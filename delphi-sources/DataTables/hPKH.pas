unit hPKH;

interface

uses
  IcTypes, IcConv, IcTools, IcValue, NexPath, NexGlob, NexIni, bPKH, hPKI, 
  Forms, Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Dialogs;

type
  TPkhHnd = class (TPkhBtr)
  private
  public
    function NextYearSerNum(pYear:Str2):longint; // Najde nasledujuce volne cislo dokladu
    function GenDocNum (pYear:Str2;pSerNum:longint):Str12; // Vygeneruje interne cislo dokladu
    procedure Del(pDocNum:Str12);
    procedure Clc(phPKI:TPkiHnd);
  published
  end;

implementation
uses DocHand;

function TPkhHnd.NextYearSerNum(pYear:Str2):longint; // Najde nasledujuce volne cislo dokladu
begin
  Result := GetDocNextYearSerNum(BtrTable,pYear);
end;

function TPkhHnd.GenDocNum (pYear:Str2;pSerNum:longint):Str12; // Vygeneruje interne cislo dokladu
begin
  Result := GenPkDocNum(pYear,BtrTable.BookNum,pSerNum);
end;

procedure TPkhHnd.Del(pDocNum:Str12);
begin
  If LocateDocNum(pDocNum) then Delete;
end;

procedure TPkhHnd.Clc (phPKI:TPkiHnd);
var mItmQnt:longint;  mDstStk:Str1;
begin
  mItmQnt := 0;
  phPKI.SwapIndex;
  mDstStk := 'N';
  phPKI.NearestDoIt(DocNum,0);
  If phPKI.DocNum=DocNum then begin
    mDstStk := 'S';
    Repeat
      Inc (mItmQnt);
      If (phPKI.StkStat='N') then mDstStk := 'N';
      phPKI.Next;
    until (phPKI.Eof) or (phPKI.DocNum<>DocNum);
  end;
  phPKI.RestoreIndex;
  // Ulozime vypocitane hodnoty do hlavicky dokladu
  Edit;
  DstStk := mDstStk;
  ItmQnt := mItmQnt;
  Post;
end;

end.
