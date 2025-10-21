unit StcHand;
//******************************************************************
//                       PACA SO SKLADOCYMI KARTAMI
// Typy storien:
//  - Storno prijmoveho pohybu
//  - Storno vydajoveho pohybu
//  - Storno prijmoveho pohybu so zapornym mnozstvom
//  - Storno vydajoveho pohybu so zapornym mnozstvom
//
//  - CancelImput - stornuje prijem alebo zaporny vydaj. V tomto
//    pripade najprv zistime ci je dostatok tovaru na sklad pre
//    dane storno, ak ano prekontrolujeme ci FIFO karta daneho
//    pohybu je uz pouzita, ak nie zrusime pohyb a k nemu patriacu
//    FIFO kartu
//
//  - CancelOutput - stornuje vydaj alebo zaporny prijem. V tomto
//    pripade mnozstva jednotlivych skladovych pohybov vratime na
//    sklad
//******************************************************************

interface

uses
  IcTypes, IcVariab, IcConv, IcTools, IcFiles, BtrHand, NexPath, NexMsg,
  Classes, SysUtils, Forms, NexBtrTable;

type
  TStcHand = class
    constructor Create; 
    destructor Destroy; override;
  private
    btSTK: TNexBtrTable;
    btSTM: TNexBtrTable;
    btSTO: TNexBtrTable;
    btSTP: TNexBtrTable;
    btFIF: TNexBtrTable;
    function CancelInput: boolean;  // Storno prijmu
    function CancelOutput(pDocNum:Str12;pItmNum:longint): boolean; // Storno vydaja
  public
    procedure OpenStkFiles (pStkNum:longint); // Otvori subory FIFO, STKM a STOCK
    procedure OpenSTK (pStkNum:longint);
    procedure OpenSTM (pStkNum:longint);
    procedure OpenSTP (pStkNum:longint);
    procedure OpenSTO (pStkNum:longint);
    procedure OpenFIF (pStkNum:longint);

    function Cancel(pDocNum:Str12;pItmNum:longint): boolean;  // Stornuje polozku zadaneho dokladu zo skladu. ak nie je mozne stornovat hodnota funkcie je FALSE
    procedure OutPdnClear (pDocNum:Str12;pItmNum:longint); // Vymaze vydaj vyrobneho cisla zadanej polozky vydajoveho dokladu
  end;

implementation

constructor TStcHand.Create;
begin
  btSTK := TNexBtrTable.Create(Application);
  btSTK.Name := 'btSTK';  btSTK.FixedName := 'STK';
  btSTM := TNexBtrTable.Create(Application);
  btSTM.Name := 'btSTM';  btSTM.FixedName := 'STM';
  btSTO := TNexBtrTable.Create(Application);
  btSTO.Name := 'btSTO';  btSTO.FixedName := 'STO';
  btSTP := TNexBtrTable.Create(Application);
  btSTP.Name := 'btSTP';  btSTP.FixedName := 'STP';
  btFIF := TNexBtrTable.Create(Application);
  btFIF.Name := 'btFIF';  btFIF.FixedName := 'FIF';
end;

destructor TStcHand.Destroy;
begin
  If btSTK.Active then btSTK.Close;  FreeAndNil (btSTK);
  If btSTM.Active then btSTM.Close;  FreeAndNil (btSTM);
  If btSTO.Active then btSTO.Close;  FreeAndNil (btSTO);
  If btSTP.Active then btSTP.Close;  FreeAndNil (btSTP);
  If btFIF.Active then btFIF.Close;  FreeAndNil (btFIF);
end;

function TStcHand.CancelInput:boolean;
var mLog:TStrings;
begin
  Result := FALSE;
  btFIF.IndexName := 'FifNum';
  If btFIF.FindKey ([btSTM.FieldByName('FifNum').AsInteger]) then begin
    Result := Eq3 (btFIF.FieldByName('OutQnt').AsFloat,0); // FIFO karta este nebola pouzita
    If Result then begin
      btFIF.Delete; // Zrusime FIFO kartu
      // Znizime prijate mnozstvo a hodnotu na skladovej karte
      btSTK.IndexName := 'GsCode';
      If btSTK.FindKey ([btSTM.FieldByName('GsCode').AsInteger]) then begin
        btSTK.Edit;
        btSTK.FieldByName ('InQnt').AsFloat := btSTK.FieldByName ('InQnt').AsFloat-btSTM.FieldByName ('GsQnt').AsFloat;
        btSTK.FieldByName ('InVal').AsFloat := btSTK.FieldByName ('InVal').AsFloat-btSTM.FieldByName ('CValue').AsFloat;
        btSTK.Post;
      end;
      // Zrusime skladovy pohyb
      btSTM.Delete;
    end;
  end
  else begin
    mLog := TStringList.Create;
    If FileExistsI (gPath.SysPath+'STKERR.LOG') then mLog.LoadFromFile(gPath.SysPath+'STKERR.LOG');
    mLog.Add('Storno - neexistujuca FIFO karta '+btSTM.FieldByName('FifNum').AsString);
    mLog.SaveToFile(gPath.SysPath+'STKERR.LOG');
    FreeAndNil (mLog);
  end;
end;

function TStcHand.CancelOutput(pDocNum:Str12;pItmNum:longint): boolean; // Storno vydaja
var mStr:Str8;
begin
  btFIF.IndexName := 'FifNum';
  While btSTM.FindKey ([pDocNum,pItmNum]) do begin
    If btFIF.FindKey ([btSTM.FieldByName('FifNum').AsInteger]) then begin
      // Znizime vydane mnozstvo FIFO t.j. pripocitame zaporne mnozstvo
      btFIF.Edit;
      btFIF.FieldByName('OutQnt').AsFloat := btFIF.FieldByName ('OutQnt').AsFloat+btSTM.FieldByName ('GsQnt').AsFloat;
      btFIF.FieldByName('ActQnt').AsFloat := btFIF.FieldByName('InQnt').AsFloat-btFIF.FieldByName('OutQnt').AsFloat;
      If IsNul (btFIF.FieldByName('ActQnt').AsFloat)
        then btFIF.FieldByName('Status').AsString := 'X'
        else btFIF.FieldByName('Status').AsString := 'A';
      btFIF.Post;
    end;
    // Znizime vydane mnozstvo a hodnotu na skladovej karte
    btSTK.IndexName := 'GsCode';
    If btSTK.FindKey ([btSTM.FieldByName('GsCode').AsInteger]) then begin
      btSTK.Edit;
      If LongInInt(btSTM.FieldByName ('SmCode').AsInteger,cSalSmCodes) then mStr:='SaQnt' else mStr:='OuQnt';
      If btSTM.FieldByName ('DocDate').AsDateTime>=gvSys.FirstActYearDate then mStr:='A'+mStr else mStr:='P'+mStr;
      If btSTK.FindField(mStr)<>NIL
        then btSTK.FieldByName (mStr).AsFloat := btSTK.FieldByName (mStr).AsFloat+btSTM.FieldByName ('GsQnt').AsFloat;
      btSTK.FieldByName ('OutQnt').AsFloat := btSTK.FieldByName ('OutQnt').AsFloat+btSTM.FieldByName ('GsQnt').AsFloat;
      btSTK.FieldByName ('OutVal').AsFloat := btSTK.FieldByName ('OutVal').AsFloat+btSTM.FieldByName ('CValue').AsFloat;
      btSTK.FieldByName('ActQnt').AsFloat := btSTK.FieldByName('BegQnt').AsFloat+btSTK.FieldByName('InQnt').AsFloat-btSTK.FieldByName('OutQnt').AsFloat;
      btSTK.FieldByName('ActVal').AsFloat := btSTK.FieldByName('BegVal').AsFloat+btSTK.FieldByName('InVal').AsFloat-btSTK.FieldByName('OutVal').AsFloat;
      btSTK.FieldByName('FreQnt').AsFloat := btSTK.FieldByName('ActQnt').AsFloat-btSTK.FieldByName('SalQnt').AsFloat-btSTK.FieldByName('OcdQnt').AsFloat;
      If (btSTK.FieldByName('FreQnt').AsFloat<0) then btSTK.FieldByName('FreQnt').AsFloat := 0;
      If (btSTK.FieldByName('ActQnt').AsFloat>0)
        then btSTK.FieldByName('AvgPrice').AsFloat := btSTK.FieldByName('ActVal').AsFloat/btSTK.FieldByName('ActQnt').AsFloat
        else btSTK.FieldByName('AvgPrice').AsFloat := btSTK.FieldByName('LastPrice').AsFloat;
      If (btSTK.FieldByName ('MaxQnt').AsFloat>0) and (btSTK.FieldByName ('FreQnt').AsFloat>btSTK.FieldByName ('MaxQnt').AsFloat) then btSTK.FieldByName ('MinMax').AsString := 'X';
      If (btSTK.FieldByName ('FreQnt').AsFloat<=btSTK.FieldByName ('MinQnt').AsFloat) then btSTK.FieldByName ('MinMax').AsString := 'N';
      btSTK.Post;
    end;
    // Zrusime skladovy pohyb
    btSTM.Delete;
  end;
end;

function TStcHand.Cancel (pDocNum:Str12;pItmNum:longint): boolean;  // Stornuje polozku zadaneho dokladu zo skladu. ak nie je mozne stornovat hodnota funkcie je FALSE
begin
  Result := TRUE;
  btSTM.IndexName := 'DoIt';
  If btSTM.FindKey ([pDocNum,pItmNum]) then begin
    If btSTM.FieldByName('GsQnt').AsFloat>0
      then Result := CancelInput // Storno prijmu
      else CancelOutput (pDocNum,pItmNum); // Storno vydaja
  end;
  If not Result then SetAbortTrans;
end;

procedure TStcHand.OpenStkFiles (pStkNum: longint); // Otvori subory FIFO, STKM a STOCK
begin
  OpenSTK (pStkNum);
  OpenSTM (pStkNum);
  OpenFIF (pStkNum);
end;

procedure TStcHand.OpenSTK (pStkNum:longint);
begin
  If not btSTK.Active or (pStkNum<>btSTK.ListNum) then btSTK.Open (pStkNum);
end;

procedure TStcHand.OpenSTM (pStkNum:longint);
begin
  If not btSTM.Active or (pStkNum<>btSTM.ListNum) then btSTM.Open (pStkNum);
end;

procedure TStcHand.OpenSTP (pStkNum:longint);
begin
  If not btSTP.Active or (pStkNum<>btSTP.ListNum) then btSTP.Open (pStkNum);
end;

procedure TStcHand.OpenSTO (pStkNum:longint);
begin
  If not btSTO.Active or (pStkNum<>btSTO.ListNum) then btSTO.Open (pStkNum);
end;

procedure TStcHand.OpenFIF (pStkNum:longint);
begin
  If not btFIF.Active or (pStkNum<>btFIF.ListNum) then btFIF.Open (pStkNum);
end;

procedure TStcHand.OutPdnClear (pDocNum:Str12;pItmNum:longint); // Vymaze vydaj vyrobneho cisla zadanej polozky vydajoveho dokladu
begin
  btSTP.IndexName := 'OutDoIt';
  While btSTP.FindKey ([pDocNum,pItmNum]) do begin
    btSTP.Edit;
    btSTP.FieldByName ('OutDocNum').AsString := '';
    btSTP.FieldByName ('OutItmNum').AsInteger := 0;
    btSTP.FieldByName ('OutDocDate').AsDateTime := 0;
    btSTP.FieldByName ('Status').AsString := 'A';
    btSTP.Post;
  end;
end;

end.
