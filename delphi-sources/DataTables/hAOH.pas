unit hAOH;

interface

uses
  IcTypes, IcConv, IcVariab, IcTools, NexPath, NexGlob, Nextext, Plc, bAOH, hAOI, DocHand,
  Forms, Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Dialogs;

type
  TAohHnd = class (TAohBtr)
  private
  public
    procedure ResVer; // Prekontroluje ci doklad je rezervovany ak ano zrusi ho
    function NextSerNum(pYear:Str2):longint; // Najde nasledujuce volne cislo dokladu
    function GenDocNum (pYear:Str2;pSerNum:longint):Str12; // Vygeneruje interne cislo dokladu

    procedure Res(pYear:Str2;pSerNum:longint); // Zarezervuje doklad so zadanym poradovym cislom
    procedure Clc(phAOI:TAoiHnd);
  published
  end;

implementation

procedure TAohHnd.ResVer; // Prekontroluje ci doklad je rezervovany ak ano zrusi ho
begin
  If DstLck=9 then Delete;
end;

function TAohHnd.NextSerNum; // Najde nasledujuce volne cislo dokladu
begin
  Result := GetDocNextYearSerNum(BtrTable,pYear);
end;

function TAohHnd.GenDocNum (pYear:Str2;pSerNum:longint):Str12; // Vygeneruje interne cislo dokladu
begin
  Result := GenAoDocNum(pYear,BtrTable.BookNum,pSerNum);
end;

procedure TAohHnd.Res(pYear:Str2;pSerNum:longint); // Zarezervuje zdoklad so zadanym poradovym cislom
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

procedure TAohHnd.Clc(phAOI:TAoiHnd);
var I:byte; mItmQnt:longint;  mAgAValue,mAgBValue,mAsDValue,mAsHValue,mAsAValue,mAsBValue:double;
    mAmdNum,mAldNum:Str12;
begin
  mAmdNum := ''; mAldNum := '';
  mItmQnt := 0;  mAgAValue := 0;  mAgBvalue := 0;
  mAsDValue := 0;  mAsHValue := 0;  mAsAValue := 0;  mAsBValue := 0;
  phAOI.SwapIndex;
  If phAOI.LocateDocNum (DocNum) then begin
    Repeat
      Inc (mItmQnt);
      mAgAValue := mAgAValue+phAOI.AgAValue;
      mAgBvalue := mAgBvalue+phAOI.AgBValue;
      mAsDValue := mAsDValue+phAOI.AsDValue;
      mAsHValue := mAsHValue+phAOI.AsHValue;
      mAsAValue := mAsAValue+phAOI.AsAValue;
      mAsBvalue := mAsBvalue+phAOI.ASBValue;
      If phAOI.AmdNum<>'' then mAmdNum := phAOI.AmdNum;
      If phAOI.AldNum<>'' then mAldNum := phAOI.AldNum;
      phAOI.Next;
    until (phAOI.Eof) or (phAOI.DocNum<>DocNum);
  end;
  phAOI.RestoreIndex;
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
  AldNum := mAldNum;
  ItmQnt := mItmQnt;
  Post;
end;

end.
