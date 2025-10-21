unit hIPH;

interface

uses
  IcTypes, IcConv, NexPath, NexGlob, bIPH, DocHand,
  Forms, Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Dialogs;

type
  TIphHnd = class (TIphBtr)
  private
  public
    function GenDocNum (pYear:Str2;pSerNum:longint):Str12; // Vygeneruje interne cislo dokladu
  published
  end;

implementation

function TIphHnd.GenDocNum (pYear:Str2;pSerNum:longint):Str12; // Vygeneruje interne cislo dokladu
begin
  Result := GenIpDocNum(pYear,BtrTable.BookNum,pSerNum);
end;


end.
