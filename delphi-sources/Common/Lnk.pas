unit Lnk;
{$F+}

// *****************************************************************************
//                   FUNKCIE NA RIADENIE PRISTUPU  K DOKLADOM
// *****************************************************************************
// *****************************************************************************


interface

uses
  IcTypes, IcConst, IcConv, IcVariab, NexMsg, NexError, DocHand,
  Amd, Aod, Ald,
  ComCtrls, SysUtils, Classes, Forms, NexBtrTable, NexPxTable;

type
  TLnk = class(TComponent)
    constructor Create(AOwner: TComponent);
    destructor  Destroy; override;
    private
    public
      oAmd:TAmd;
      oAod:TAod;
      oAld:TAld;
      procedure Del(pDocNum:Str12;pItmNum:longint;pDocFld,pItmFld:ShortString); // Zrusi odkaz riadku na iny doklad
    published
  end;

procedure LnkDel(pDocNum:Str12;pItmNum:longint;pDocFld,pItmFld:ShortString); // Zrusi odkaz riadku na iny doklad

implementation

procedure LnkDel(pDocNum:Str12;pItmNum:longint;pDocFld,pItmFld:ShortString); // Zrusi odkaz riadku na iny doklad
var mLnk:TLnk;
begin
  mLnk := TLnk.Create(nil);
  mLnk.Del(pDocNum,pItmNum,pDocFld,pItmFld);
  FreeAndNil(mLnk);
end;

// ********************************** OBJEKT ***********************************

constructor TLnk.Create(AOwner: TComponent);
begin
  oAmd := TAmd.Create(Self);
  oAod := TAod.Create(Self);
  oAld := TAld.Create(Self);
end;

destructor TLnk.Destroy;
begin
  FreeAndNil(oAld);
  FreeAndNil(oAod);
  FreeAndNil(oAmd);
end;

// ********************************* PRIVATE ***********************************

// ********************************** PUBLIC ***********************************

procedure TLnk.Del(pDocNum:Str12;pItmNum:longint;pDocFld,pItmFld:ShortString); // Zrusi odkaz riadku na iny doklad
var mDocTyp:byte;  mBokNum:Str5;
begin
  mDocTyp := GetDocType (pDocNum);
  mBokNum := BookNumFromDocNum(pDocNum);
  case mDocTyp of
    dtIM: ;
    dtOM: ;
    dtRM: ;
    dtPK: ;
    dtMS: ;
    dtOS: ;
    dtTS: ;
    dtIS: ;
    dtMC: ;
    dtOC: ;
    dtTC: ;
    dtIC: ;
    dtCS: ;
    dtSO: ;
    dtID: ;
    dtSV: ;
    dtMI: ;
    dtMO: ;
    dtCM: ;
    dtSA: ;
    dtSC: ;
    dtOW: ;
    dtUD: ;
    dtCD: ;
    dtTO: ;
    dtTI: ;
    dtAM: With oAmd do begin
            Open(mBokNum,TRUE,TRUE,FALSE);
            If ohAMI.LocateDoIt(pDocNum,pItmNum) then begin
              ohAMI.Edit;
              ohAMI.BtrTable.FieldByName(pDocFld).AsString := '';
              ohAMI.BtrTable.FieldByName(pItmFld).AsInteger := 0;
              ohAMI.Post;
            end;
            ClcDoc(pDocNum);
          end;
    dtAO: With oAod do begin
            Open(mBokNum,TRUE,TRUE,FALSE);
            If ohAOI.LocateDoIt(pDocNum,pItmNum) then begin
              ohAOI.Edit;
              ohAOI.BtrTable.FieldByName(pDocFld).AsString := '';
              ohAOI.BtrTable.FieldByName(pItmFld).AsInteger := 0;
              ohAOI.Post;
            end;
            ClcDoc(pDocNum);
          end;
    dtAL: With oAld do begin
            Open(mBokNum,TRUE,TRUE,FALSE,FALSE);
            If ohALI.LocateDoIt(pDocNum,pItmNum) then begin
              ohALI.Edit;
              ohALI.BtrTable.FieldByName(pDocFld).AsString := '';
              ohALI.BtrTable.FieldByName(pItmFld).AsInteger := 0;
              ohALI.Post;
            end;
            ClcDoc(pDocNum);
          end;
  end;
end;

end.


