unit Fjr;
{$F+}

// *****************************************************************************
//            OBJEKT NA PRACU S POLOZKAMI PENAZNEHO DENNIKA
// *****************************************************************************
// Programové funkcia:
// ---------------
// FltItm - vyfitruje polozky PD pdola zadanych kriterii do ptFINJOUR
// *****************************************************************************


interface

uses
  IcTypes, IcConst, IcConv, IcTools, NexGlob, Rep, Key,
  hFINJRN, tFINJRN,
  ComCtrls, SysUtils, Classes, Forms, XpComp;

type
  TFjr = class(TComponent)
    constructor Create;
    destructor  Destroy; override;
    private
      oAbo:boolean;
      oInd:TProgressBar;
      oCnt:TxpEdit;
      ohFINJRN:TFinjrnHnd;
      otFINJRN:TFinjrnTmp;
      procedure IndMax(pMax:longint);
      procedure IndInc;
    public
      procedure AboFlt;
      procedure ItmFlt(pBegDate,pEndDate:TDateTime;pAccSnt,pDocType:ShortString);
      procedure ItmPrn;

      property ptFINJRN:TFinjrnTmp read otFINJRN write otFINJRN;
      property Ind:TProgressBar read oInd write oInd;
      property Cnt:TxpEdit read oCnt write oCnt;
    published
  end;

implementation

constructor TFjr.Create;
begin
  oAbo := FALSE;  oInd := nil;
  ohFINJRN := TFinjrnHnd.Create;  ohFINJRN.Open;
  otFINJRN := TFinjrnTmp.Create;  otFINJRN.Open;
end;

destructor TFjr.Destroy;
begin
  FreeAndNil (otFINJRN);
  FreeAndNil (ohFINJRN);
end;

// ********************************* PRIVATE ***********************************

procedure TFjr.IndMax(pMax:longint);
begin
  If oInd<>nil then begin
    oInd.Max := pMax;
    oInd.Position := 0;
  end;
end;

procedure TFjr.IndInc;
begin
  If oInd<>nil then oInd.StepBy(1);
end;

// ********************************** PUBLIC ***********************************

procedure TFjr.ItmFlt(pBegDate,pEndDate:TDateTime;pAccSnt,pDocType:ShortString);
var mDateOk,mAccSntOk,mDocTypeOk:boolean;
begin
  If ohFINJRN.Count>0 then begin
    oCnt.AsInteger := 0;   oAbo := FALSE;
    try
      otFINJRN.Open;
      otFINJRN.DisableControls;
      IndMax (ohFINJRN.Count);
      ohFINJRN.First;
      Repeat
        IndInc;
        oCnt.AsInteger := oCnt.AsInteger+1;
        mDateOk := InDateInterval (pBegDate,pEndDate,ohFINJRN.DocDate) or ((pBegDate=0) and (pEndDate=0));
        mAccSntOk := StrInInterval(ohFINJRN.AccSnt,pAccSnt) or (pAccSnt='');
        mDocTypeOk := StrInInterval(copy(ohFINJRN.DocNum,1,2),pDocType) or (pDocType='');
        If mDateOk and mAccSntOk and  mDocTypeOk then begin
          otFINJRN.Insert;
          BTR_To_PX (ohFINJRN.BtrTable,otFINJRN.TmpTable);
          otFINJRN.Post;
        end;
        Application.ProcessMessages;
        ohFINJRN.Next;
      until oAbo or ohFINJRN.Eof;
    finally
      otFINJRN.EnableControls;
    end;
  end;
end;

procedure TFjr.ItmPrn;
var mRep:TRep;
begin
  mRep := TRep.Create(Self);
//    mRep.HedTmp := ;
  mRep.ItmTmp := otFINJRN.TmpTable;
  mRep.Execute('FJRFLT');
  FreeAndNil (mRep);
end;

procedure TFjr.AboFlt;
begin
  oAbo := TRUE;
end;

end.
