unit hCDH;      

interface

uses
  IcTypes, IcConv, NexPath, NexGlob, bCDH, hCDI, Dochand,
  Forms, Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Dialogs;

type
  TCdhHnd = class (TCdhBtr)
  private
  public
    function NextSerNum(pYear:Str2):longint; // Najde nasledujuce volne cislo dokladu
    function GenDocNum (pYear:Str2;pSerNum:longint):Str12; // Vygeneruje interne cislo dokladu

    procedure Clc(phCDI:TCdiHnd);
  published
  end;

implementation

function TCdhHnd.NextSerNum; // Najde nasledujuce volne cislo dokladu
begin
  Result:=GetDocNextYearSerNum(BtrTable,pYear);
end;

function TCdhHnd.GenDocNum (pYear:Str2;pSerNum:longint):Str12; // Vygeneruje interne cislo dokladu
begin
  Result := GenCdDocNum(pYear,BtrTable.BookNum,pSerNum);
end;

procedure TCdhHnd.Clc(phCDI:TCdiHnd);
var mItmQnt:longint;  mDstStk:Str1;  mCValue,mBValue:double;
begin
  mItmQnt := 0;  mCValue := 0;  mBValue := 0;  mDstStk := 'N';
  If phCDI.LocateDocNum(DocNum) then begin
    mDstStk := 'S';
    Repeat
      Inc (mItmQnt);
      mCValue := mCValue+phCDI.CValue;
      mBValue := mBValue+phCDI.BPrice*phCDI.GsQnt;
      If (phCDI.StkStat='N') then mDstStk := 'N';
      phCDI.Next;
    until (phCDI.Eof) or (phCDI.DocNum<>DocNum);
  end;
  // Ulozime vypocitane hodnoty do hlavicky dokladu
  Edit;
  CValue := mCValue;
  BValue := mBValue;
  DstStk := mDstStk;
  ItmQnt := mItmQnt;
  Post;
end;

end.
