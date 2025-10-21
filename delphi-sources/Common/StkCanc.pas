unit StkCanc;
//******************************************************************
//                       STORNOVANIE SKLADOVEHO POHYBU
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
  IcTypes, IcVariab, IcConv, IcTools, IcFiles, BtrHand, NexPath, NexMsg, NexError, 
  Classes, SysUtils;

type
  TStkCanc = class
    constructor Create;
    destructor Destroy; override;
  private
  public
    procedure OpenStkFiles (pStkNum:longint); // Otvori subory FIFO, STKM a STOCK
    procedure CloseStkFiles; // Uzatvory subory FIFO, STKM a STOCK
    function CancelInput:byte;  // Storno prijmu
    function Cancel(pDocNum:Str12;pItmNum:longint):byte;  // Stornuje polozku zadaneho dokladu zo skladu. ak nie je mozne stornovat hodnota funkcie je FALSE
    function CancelGsCode(pDocNum:Str12;pItmNum,pGSCode:longint):byte;  // Stornuje polozku zadaneho dokladu zo skladu. ak nie je mozne stornovat hodnota funkcie je FALSE
    function CancelOutput(pDocNum:Str12;pItmNum:longint):byte; // Storno vydaja
    function CancelOutput1(pDocNum:Str12;pItmNum:longint):byte; // Storno vydaja
  end;

implementation

uses DM_STKDAT;

constructor TStkCanc.Create;
begin
//
end;

destructor TStkCanc.Destroy;
begin
//
end;

function TStkCanc.CancelInput:byte;
var mLog:TStrings;
begin
  Result:=0;
  dmSTK.btSTK.SwapIndex;
  dmSTK.btSTK.IndexName:='GsCode';
  If dmSTK.btSTK.FindKey([dmSTK.btSTM.FieldByName('GsCode').AsInteger]) then begin
    If dmSTK.btSTK.FieldByName('FreQnt').AsFloat>=dmSTK.btSTM.FieldByName ('GsQnt').AsFloat then begin
      dmSTK.btFIF.SwapIndex;
      dmSTK.btFIF.IndexName:='FifNum';
      If dmSTK.btFIF.FindKey([dmSTK.btSTM.FieldByName('FifNum').AsInteger]) then begin
        If Eq3(dmSTK.btFIF.FieldByName('OutQnt').AsFloat,0) // FIFO karta este nebola pouzita
          then Result:=0
          else Result:=1;
        If Result=0 then begin
          dmSTK.btFIF.Delete; // Zrusime FIFO kartu
          // Znizime prijate mnozstvo a hodnotu na skladovej karte
          dmSTK.btSTK.Edit;
          dmSTK.btSTK.FieldByName('InQnt').AsFloat:=dmSTK.btSTK.FieldByName('InQnt').AsFloat-dmSTK.btSTM.FieldByName ('GsQnt').AsFloat;
          dmSTK.btSTK.FieldByName('InVal').AsFloat:=dmSTK.btSTK.FieldByName('InVal').AsFloat-dmSTK.btSTM.FieldByName ('CValue').AsFloat;
          dmSTK.btSTK.Post;
          // Zrusime skladovy pohyb
          dmSTK.btSTM.Delete;
        end;
      end
      else begin
        mLog:=TStringList.Create;
        If FileExistsI (gPath.SysPath+'STKERR.LOG') then mLog.LoadFromFile(gPath.SysPath+'STKERR.LOG');
        mLog.Add('Storno - neexistujuca FIFO karta '+dmSTK.btSTM.FieldByName('FifNum').AsString);
        mLog.SaveToFile(gPath.SysPath+'STKERR.LOG');
        FreeAndNil (mLog);
      end;
      dmSTK.btFIF.RestoreIndex;
    end else Result:=2;
  end;
  dmSTK.btSTK.RestoreIndex;
end;

function TStkCanc.CancelOutput(pDocNum:Str12;pItmNum:longint):byte; // Storno vydaja
var mStr:Str8;
begin
  dmSTK.btFIF.SwapIndex;
  dmSTK.btFIF.IndexName:='FifNum';
  While dmSTK.btSTM.FindKey ([pDocNum,pItmNum]) do begin
    If dmSTK.btFIF.FindKey ([dmSTK.btSTM.FieldByName('FifNum').AsInteger]) then begin
      // Znizime vydane mnozstvo FIFO t.j. pripocitame zaporne mnozstvo
      dmSTK.btFIF.Edit;
      dmSTK.btFIF.FieldByName ('OutQnt').AsFloat:=dmSTK.btFIF.FieldByName ('OutQnt').AsFloat+dmSTK.btSTM.FieldByName ('GsQnt').AsFloat;
      dmSTK.btFIF.Post;
    end;
    // Znizime vydane mnozstvo a hodnotu na skladovej karte
    dmSTK.btSTK.SwapIndex;
    dmSTK.btSTK.IndexName:='GsCode';
    If dmSTK.btSTK.FindKey ([dmSTK.btSTM.FieldByName('GsCode').AsInteger]) then begin
      dmSTK.btSTK.Edit;
      If LongInInt(dmSTK.btSTM.FieldByName ('SmCode').AsInteger,cSalSmCodes) then mStr:='SaQnt' else mStr:='OuQnt';
      If dmSTK.btSTM.FieldByName ('DocDate').AsDateTime>=gvSys.FirstActYearDate then mStr:='A'+mStr else mStr:='P'+mStr;
      If dmSTK.btSTK.FindField(mStr)<>NIL
        then dmSTK.btSTK.FieldByName (mStr).AsFloat:=dmSTK.btSTK.FieldByName (mStr).AsFloat+dmSTK.btSTM.FieldByName ('GsQnt').AsFloat;
      dmSTK.btSTK.FieldByName ('OutQnt').AsFloat:=dmSTK.btSTK.FieldByName ('OutQnt').AsFloat+dmSTK.btSTM.FieldByName ('GsQnt').AsFloat;
      dmSTK.btSTK.FieldByName ('OutVal').AsFloat:=dmSTK.btSTK.FieldByName ('OutVal').AsFloat+dmSTK.btSTM.FieldByName ('CValue').AsFloat;
      dmSTK.btSTK.Post;
    end;
    dmSTK.btSTK.RestoreIndex;
    // Zrusime skladovy pohyb
    dmSTK.btSTM.Delete;
  end;
  dmSTK.btFIF.RestoreIndex;
end;

function TStkCanc.Cancel(pDocNum:Str12;pItmNum:longint):byte;  // Stornuje polozku zadaneho dokladu zo skladu. ak nie je mozne stornovat hodnota funkcie je FALSE
begin
  Result:=0;
  dmSTK.btSTK.SwapIndex;
  dmSTK.btSTM.SwapIndex;
  dmSTK.btSTM.IndexName:='DoIt';
  If dmSTK.btSTM.FindKey ([pDocNum,pItmNum]) then begin
    If dmSTK.btSTM.FieldByName('GsQnt').AsFloat>0
      then Result:=CancelInput // Storno prijmu
      else CancelOutput(pDocNum,pItmNum); // Storno vydaja
  end;
  dmSTK.btSTM.RestoreIndex;
  dmSTK.btSTK.RestoreIndex;
  If not Result=0 then SetAbortTrans;
end;

function TStkCanc.CancelGsCode;
begin
  Result:=0;
  dmSTK.btSTK.SwapIndex;
  dmSTK.btSTM.SwapIndex;
  dmSTK.btSTM.IndexName:='DoIt';
  If dmSTK.btSTM.FindKey ([pDocNum,pItmNum]) then begin
    While (Result=0) and (dmSTK.btSTM.FieldByName('DocNum').AsString=pDocNum) and (dmSTK.btSTM.FieldByName('ItmNum').AsInteger=pItmNum) do begin
      If dmSTK.btSTM.FieldByName('GsCode').AsInteger=pGSCode then begin
        If dmSTK.btSTM.FieldByName('GsQnt').AsFloat>0 then begin
          Result:=CancelInput // Storno prijmu
        end else begin
          Result:=CancelOutput1(pDocNum,pItmNum); // Storno vydaja
        end;
      end else dmSTK.btSTM.Next;
    end;
  end;
  dmSTK.btSTM.RestoreIndex;
  dmSTK.btSTK.RestoreIndex;
  If not Result=0 then SetAbortTrans;
end;

function TStkCanc.CancelOutput1(pDocNum:Str12;pItmNum:longint):byte; // Storno vydaja
var mStr:Str8;
begin
  Result:=0;
  dmSTK.btFIF.SwapIndex;
  dmSTK.btFIF.IndexName:='FifNum';
  If dmSTK.btFIF.FindKey([dmSTK.btSTM.FieldByName('FifNum').AsInteger]) then begin
    // Znizime vydane mnozstvo FIFO t.j. pripocitame zaporne mnozstvo
    dmSTK.btFIF.Edit;
    dmSTK.btFIF.FieldByName('OutQnt').AsFloat:=dmSTK.btFIF.FieldByName ('OutQnt').AsFloat+dmSTK.btSTM.FieldByName ('GsQnt').AsFloat;
    dmSTK.btFIF.Post;
  end;
  // Znizime vydane mnozstvo a hodnotu na skladovej karte
  dmSTK.btSTK.SwapIndex;
  dmSTK.btSTK.IndexName:='GsCode';
  If dmSTK.btSTK.FindKey([dmSTK.btSTM.FieldByName('GsCode').AsInteger]) then begin
    dmSTK.btSTK.Edit;
    If LongInInt(dmSTK.btSTM.FieldByName('SmCode').AsInteger,cSalSmCodes) then mStr:='SaQnt' else mStr:='OuQnt';
    If dmSTK.btSTM.FieldByName('DocDate').AsDateTime>=gvSys.FirstActYearDate then mStr:='A'+mStr else mStr:='P'+mStr;
    If dmSTK.btSTK.FindField(mStr)<>NIL then dmSTK.btSTK.FieldByName (mStr).AsFloat:=dmSTK.btSTK.FieldByName (mStr).AsFloat+dmSTK.btSTM.FieldByName ('GsQnt').AsFloat;
    dmSTK.btSTK.FieldByName('OutQnt').AsFloat:=dmSTK.btSTK.FieldByName ('OutQnt').AsFloat+dmSTK.btSTM.FieldByName ('GsQnt').AsFloat;
    dmSTK.btSTK.FieldByName('OutVal').AsFloat:=dmSTK.btSTK.FieldByName ('OutVal').AsFloat+dmSTK.btSTM.FieldByName ('CValue').AsFloat;
    dmSTK.btSTK.Post;
  end;
  dmSTK.btSTK.RestoreIndex;
  // Zrusime skladovy pohyb
  dmSTK.btSTM.Delete;
  dmSTK.btFIF.RestoreIndex;
end;

procedure TStkCanc.OpenStkFiles (pStkNum: longint); // Otvori subory FIFO, STKM a STOCK
begin
  If not dmSTK.btSTK.Active or (pStkNum<>dmSTK.GetActStkNum) then begin
    dmSTK.OpenSTK(pStkNum);
    dmSTK.OpenSTM(pStkNum);
    dmSTK.OpenFIF(pStkNum);
  end;
  If not dmSTK.btSTK.Active or (dmSTK.btSTK.TableName<>dmSTK.btSTK.FixedName+StrIntZero(pStkNum,5)) then dmSTK.OpenSTK(pStkNum);
  If not dmSTK.btSTM.Active or (dmSTK.btSTM.TableName<>dmSTK.btSTM.FixedName+StrIntZero(pStkNum,5)) then dmSTK.OpenSTM(pStkNum);
  If not dmSTK.btFIF.Active or (dmSTK.btFIF.TableName<>dmSTK.btFIF.FixedName+StrIntZero(pStkNum,5)) then dmSTK.OpenFIF(pStkNum);
end;

procedure TStkCanc.CloseStkFiles; // Uzatvory subory FIFO, STKM a STOCK
begin
  dmSTK.btSTK.Close;
  dmSTK.btSTM.Close;
  dmSTK.btFIF.Close;
end;

end.
