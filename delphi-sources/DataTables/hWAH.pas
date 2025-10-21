unit hWAH;

interface

uses
  IcTypes, IcTools, IcConv, NexPath, NexGlob, bWAH, DocHand,
  Forms, Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Dialogs;

type
  TWahHnd = class (TWahBtr)
  private
  public
    function GenDocNum (pyear:Str2;pSerNum:longint):Str12; // Vygeneruje interne cislo dokladu
  published
  end;

implementation

function TWahHnd.GenDocNum (pyear:Str2;pSerNum:longint):Str12; // Vygeneruje interne cislo dokladu
begin
  Result := GenWaDocNum(pyear,BtrTable.BookNum,pSerNum);
end;

end.
