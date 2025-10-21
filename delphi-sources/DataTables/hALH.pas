unit hALH;

interface

uses
  IcTypes, IcConv, IcVariab, IcTools, NexPath, NexGlob, Nextext, Plc, bALH, hALI, DocHand,
  Forms, Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Dialogs;

type
  TAlhHnd = class (TAlhBtr)
  private
  public
    function NextSerNum(pYear:Str2):longint; // Najde nasledujuce volne cislo dokladu
    function GenDocNum (pYear:Str2;pSerNum:longint):Str12; // Vygeneruje interne cislo dokladu

    procedure Del(pDocNum:Str12);
    procedure ResVer; // Prekontroluje ci doklad je rezervovany ak ano zrusi ho
    procedure Res(pYear:Str2;pSerNum:longint); // Zarezervuje doklad so zadanym poradovym cislom
    procedure Clc(phALI:TAliHnd);
  published
  end;

implementation

function TAlhHnd.NextSerNum; // Najde nasledujuce volne cislo dokladu
begin
  Result := GetDocNextYearSerNum(BtrTable,pYear);
end;

function TAlhHnd.GenDocNum (pYear:Str2;pSerNum:longint):Str12; // Vygeneruje interne cislo dokladu
begin
  Result := GenAlDocNum(pYear,BtrTable.BookNum,pSerNum);
end;

procedure TAlhHnd.Del(pDocNum:Str12);
begin
  If LocateDocNum(pDocNum) then Delete;
end;

procedure TAlhHnd.ResVer; // Prekontroluje ci doklad je rezervovany ak ano zrusi ho
begin
  If DstLck=9 then Delete;
end;

procedure TAlhHnd.Res(pYear:Str2;pSerNum:longint); // Zarezervuje zdoklad so zadanym poradovym cislom
begin
  Insert;
  SerNum := pSerNum;
  Year := pYear;
  DocNum := GenDocNum(pYear,pSerNum);
  DocDate := Date;
  DstLck := 9;
  PaName := gNt.GetSecText('STATUS','Reserve','Rezervovane pre: ')+gvSys.LoginName;
  Post;
end;

procedure TAlhHnd.Clc(phALI:TAliHnd);
var I:byte; mItmQnt:longint;  mAgAValue,mAgBValue,mAsDValue,mAsHValue,mAsAValue,mAsBValue:double;
    mAmdNum,mAodNum,mIcdNum:Str12;
begin
  mAmdNum := ''; mAodNum := '';   mIcdNum := '';
  mItmQnt := 0;  mAgAValue := 0;  mAgBvalue := 0;  
  mAsDValue := 0;  mAsHValue := 0;  mAsAValue := 0;  mAsBValue := 0;
  phALI.SwapIndex;
  If phALI.LocateDocNum (DocNum) then begin
    Repeat
      Inc (mItmQnt);
      mAgAValue := mAgAValue+phALI.AgAValue;
      mAgBvalue := mAgBvalue+phALI.AgBValue;
      mAsDValue := mAsDValue+phALI.AsDValue;
      mAsHValue := mAsHValue+phALI.AsHValue;
      mAsAValue := mAsAValue+phALI.AsAValue;
      mAsBvalue := mAsBvalue+phALI.ASBValue;
      If phALI.AmdNum<>'' then mAmdNum := phALI.AmdNum;
      If phALI.AodNum<>'' then mAodNum := phALI.AodNum;
      If phALI.IcdNum<>'' then mIcdNum := phALI.IcdNum;
      phALI.Next;
    until (phALI.Eof) or (phALI.DocNum<>DocNum);
  end;
  phALI.RestoreIndex;
  // Ulozime vypocitane hodnoty do hlavicky dokladu
  Edit;
  AgAValue := mAgAValue;
  AgBValue := mAgBvalue;
  AsDValue := mAsDValue;
  AsHValue := mAsHValue;
  AsDdsVal := mAsDValue-mAsAValue;
  AsHdsVal := mAsHValue-mAsBvalue;
  AsAValue := mAsAValue;
  AsBValue := mAsBvalue;   
  DscPrc := gPlc.ClcDscPrc(AsDValue,AsAValue);
  SurVal := Rd2(AgBValue*(SurPrc/100));
  AmdNum := mAmdNum;
  AodNum := mAodNum;
  IcdNum := mIcdNum;
  ItmQnt := mItmQnt;
  Post;
end;

end.
