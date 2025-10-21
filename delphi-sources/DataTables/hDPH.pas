unit hDPH;

interface

uses
  IcTypes, IcConv, IcVariab, IcTools, NexPath, NexGlob, NexText, bDPH, hDPI,
  Dochand,
  Forms, Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Dialogs;

type
  TDphHnd = class (TDphBtr)
  private
    function NextSerNum(pYear:Str2):longint; // Najde nasledujuce volne cislo dokladu
  public
    procedure Post; override;
    procedure NewDoc(pYear:Str2); // Vygeneruje a zarezervuje novy doklad
    procedure ResVer; // Prekontroluje ci doklad je rezervovany ak ano zrusi ho
    procedure Del(pDocNum:Str12);
    procedure Clc(phDPI:TDpiHnd);
  published
  end;

implementation

procedure TDphHnd.Post;
begin
  ItmEnd := ItmSum-ItmPay;
  PurEnd := PurVal-PurPay;
  inherited;
end;

function TDphHnd.NextSerNum(pYear:Str2):longint; // Najde nasledujuce volne cislo dokladu
begin
  Result := GetDocNextYearSerNum(BtrTable,pYear);
end;

procedure TDphHnd.NewDoc; // Vygeneruje a zarezervuje novy doklad
var mSerNum:longint; mDocNum:Str12;
begin
  If pYear=''  then pYear:=gvSys.ActYear2;
  mSerNum := NextSerNum(pYear);
  mDocNum := GenDpDocNum(pYear,BtrTable.BookNum,mSerNum);
  Insert;
  SerNum := mSerNum;
  Year := pYear;
  DocNum := mDocNum;
  DocDate := Date;
  PaName := gNT.GetSecText('STATUS','Reserve','Rezervovane')+' - '+gvSys.LoginName;
  DstLck := 9;
  Post;
end;

procedure TDphHnd.ResVer; // Prekontroluje ci doklad je rezervovany ak ano zrusi ho
begin
  If DstLck=9 then Delete;
end;

procedure TDphHnd.Del(pDocNum:Str12);
begin
  If LocateDocNum(pDocNum) then Delete;
end;

procedure TDphHnd.Clc(phDPI:TDpiHnd);
var mItmQnt:longint;  mItmSum,mItmPay,mPlnPrf,mActPrf:double;
begin
  mItmQnt := 0;  mItmSum := 0;  mItmPay := 0;  mPlnPrf := 0;  mActPrf := 0;
  phDPI.SwapIndex;
  If phDPI.LocateDocNum(DocNum) then begin
    Repeat
      Inc (mItmQnt);
      mItmSum := mItmSum+phDPI.InvVal;
      mItmPay := mItmPay+phDPI.PayVal;
      phDPI.Next;
    until (phDPI.Eof) or (phDPI.DocNum<>DocNum);
  end;
  phDPI.RestoreIndex;
  // Ulozime vypocitane hodnoty do hlavicky objednavky
  Edit;
  ItmQnt := mItmQnt;
  ItmSum := mItmSum;
  ItmPay := mItmPay;
  If IsNotNul(ItmSum) then mPlnPrf := Rd2((PurVal/ItmSum)*100);
  If IsNotNul(ItmPay) then mPlnPrf := Rd2((ItmSum/ItmPay)*100);
  Post;
end;

end.
