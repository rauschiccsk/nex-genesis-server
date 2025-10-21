unit hTIH;

interface

uses
  IcTypes, NexPath, NexGlob, DocHand, bTIH,
  Forms, Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Dialogs;

type
  TTihHnd = class (TTihBtr)
  private
  public
    function NextSerNum:longint; // Najde nasledujuce volne cislo dokladu
    function GenDocNum(pYear:Str2;pSerNum:longint):Str12; // Vygeneruje interne cislo dokladu
  published
  end;

implementation

function TTihHnd.NextSerNum;
begin
  SwapIndex;
  Btrtable.IndexName:=ixDocNum;
  Last;
  Result:=SerNum+1;
  RestoreIndex;
end;

function TTihHnd.GenDocNum(pYear:Str2;pSerNum:longint):Str12; // Vygeneruje interne cislo dokladu
begin
  Result:=GenTiDocNum(pYear,BtrTable.BookNum,pSerNum);
end;

end.
