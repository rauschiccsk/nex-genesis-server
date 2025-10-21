unit hAMH;

interface

uses
  IcTypes, IcConv, IcTools, IcVariab, NexPath, NexGlob, NexText, Plc, bAMH, hAMI, DocHand,
  Forms, Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Dialogs;

type
  TAmhHnd = class (TAmhBtr)
  private
  public
    procedure ResVer; // Prekontroluje ci doklad je rezervovany ak ano zrusi ho
    function NextSerNum(pYear:Str2):longint; // Najde nasledujuce volne cislo dokladu
    function GenDocNum (pYear:Str2;pSerNum:longint):Str12; // Vygeneruje interne cislo dokladu

    procedure Res(pYear:Str2;pSerNum:longint); // Zarezervuje doklad so zadanym poradovym cislom
    procedure Clc(phAMI:TAmiHnd);
  published
  end;

implementation

procedure TAmhHnd.ResVer; // Prekontroluje ci doklad je rezervovany ak ano zrusi ho
begin
  If DstLck=9 then Delete;
end;

function TAmhHnd.NextSerNum; // Najde nasledujuce volne cislo dokladu
begin
  Result := GetDocNextYearSerNum(BtrTable,pYear);
end;

function TAmhHnd.GenDocNum (pYear:Str2;pSerNum:longint):Str12; // Vygeneruje interne cislo dokladu
begin

  Result := GenAmDocNum(pYear,BtrTable.BookNum,pSerNum);
end;

procedure TAmhHnd.Res(pYear:Str2;pSerNum:longint); // Zarezervuje zdoklad so zadanym poradovym cislom
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

procedure TAmhHnd.Clc(phAMI:TAmiHnd);
var I:byte; mItmQnt:longint;  mAgAValue,mAgBValue,mAsDValue,mAsHValue,mAsAValue,mAsBValue:double;
    mAodNum:Str12;
begin
  mItmQnt := 0;  mAgAValue := 0;  mAgBValue := 0;  mAodNum := '';
  mAsDValue := 0;  mAsHValue := 0;  mAsAValue := 0;  mAsBValue := 0;
  phAMI.SwapIndex;
  If phAMI.LocateDocNum (DocNum) then begin
    Repeat
      Inc (mItmQnt);
      mAgAValue := mAgAValue+phAMI.AgAValue;
      mAgBvalue := mAgBvalue+phAMI.AgBValue;
      mAsDValue := mAsDValue+phAMI.AsDValue;
      mAsHValue := mAsHValue+phAMI.AsHValue;
      mAsAValue := mAsAValue+phAMI.AsAValue;
      mAsBvalue := mAsBvalue+phAMI.ASBValue;
      If phAMI.AodNum<>'' then mAodNum := phAMI.AodNum;
      phAMI.Next;
    until (phAMI.Eof) or (phAMI.DocNum<>DocNum);
  end;
  phAMI.RestoreIndex;
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
  AodNum := mAodNum;
  ItmQnt := mItmQnt;
  Post;
end;

end.
