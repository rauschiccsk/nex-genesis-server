unit Jrn;
{$F+}

// *****************************************************************************
//            OBJEKT NA PRACU S POLOZKAMI DENNIKA UCTOVNYCH ZAPISOV
// *****************************************************************************
// Programové funkcia:
// ---------------
// DocItm - nacita uctovne zapisy zadaneho dokladu do pt
// DocAcc - nacita uctovne zapisy zadaneho dokladu do ptDOCACC
// *****************************************************************************


interface

uses
  IcTypes, IcConst, IcConv, IcTools, NexGlob, NexPath, NexMsg, RepHand, Key,
  hJOURNAL, tDOCACC,
  ComCtrls, SysUtils, Classes, Forms;

type
  TJrn = class(TComponent)
    constructor Create;
    destructor  Destroy; override;
    private
      ohJOURNAL:TJournalHnd;
      otDOCACC:TDocaccTmp;
    public
      procedure DocItm(pDocNum:Str12);
      procedure DocAcc(pDocNum:Str12);

      property ptDOCACC:TDocaccTmp read otDOCACC write otDOCACC;
    published
  end;

implementation

constructor TJrn.Create;
begin
  otDOCACC := TDocaccTmp.Create;
  ohJOURNAL := TJournalHnd.Create;  ohJOURNAL.Open;
end;

destructor TJrn.Destroy;
begin
  FreeAndNil (ohJOURNAL);
  FreeAndNil (otDOCACC);
end;

// ********************************* PRIVATE ***********************************

// ********************************** PUBLIC ***********************************

procedure TJrn.DocItm(pDocNum:Str12);
begin
end;

procedure TJrn.DocAcc(pDocNum:Str12);
var mCnt:byte;
begin
  otDOCACC.Open;
  otDOCACC.Insert;
  otDOCACC.DocNum := pDocNum;
  If ohJOURNAL.LocateDocNum(pDocNum) then begin
    mCnt := 0;
    Repeat
      Inc (mCnt);
      otDOCACC.TmpTable.FieldByName ('AccSnt'+StrInt(mCnt,1)).AsString := ohJOURNAL.AccSnt;
      otDOCACC.TmpTable.FieldByName ('AccAnl'+StrInt(mCnt,1)).AsString := ohJOURNAL.AccAnl;
      otDOCACC.TmpTable.FieldByName ('CreVal'+StrInt(mCnt,1)).AsFloat := ohJOURNAL.CredVal;
      otDOCACC.TmpTable.FieldByName ('DebVal'+StrInt(mCnt,1)).AsFloat := ohJOURNAL.DebVal;
      ohJOURNAL.Next;
    until (ohJOURNAL.Eof) or (mCnt=8) or (ohJOURNAL.DocNum<>pDocNum);
  end;
  otDOCACC.Post;
end;

end.
