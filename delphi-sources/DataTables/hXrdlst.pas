unit hXRDLST;

interface

uses
  IcTypes, NexPath, NexGlob, DocHand, bXRDLST, 
  Forms, Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Dialogs;

type
  TXrdlstHnd=class (TXrdlstBtr)
  private
  public
    function NextSerNum(pYear:Str2):longint; // Najde nasledujuce volne cislo dokladu
    function GenDocNum(pYear:Str2;pSerNum:longint):Str12; // Vygeneruje interne cislo dokladu
  published
  end;

implementation

function TXrdlstHnd.NextSerNum;
begin
  Result:=GetDocNextYearSerNum(BtrTable,pYear);
end;

function TXrdlstHnd.GenDocNum(pYear:Str2;pSerNum:longint):Str12;
begin
  Result:=GenXrDocNum(pYear,pSerNum);
end;

end.
{MOD 1918001}
