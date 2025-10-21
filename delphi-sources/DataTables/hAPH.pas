unit hAPH;

interface

uses
  IcTypes, IcConv, NexPath, NexGlob, bAPH, DocHand,
  Forms, Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Dialogs;

type
  TAphHnd = class (TAphBtr)
  private
  public
    function GenDocNum (pYear:Str2;pBokNum:Str5;pSerNum:longint):Str12; // Vygeneruje interne cislo dokladu
    function GetBokNum:Str5; // Cislo otvorenej knihy
    function GetActive:boolean; // TRUE ak databaza je otvorena
  published
    property BokNum:Str5 read GetBokNum;
    property Active:boolean read GetActive;
  end;

implementation

function TAphHnd.GenDocNum (pYear:Str2;pBokNum:Str5;pSerNum:longint):Str12; // Vygeneruje interne cislo dokladu
begin
  Result := GenApDocNum(pYear,pBokNum,pSerNum);
end;

function TAphHnd.GetBokNum:Str5;
begin
  Result := BtrTable.BookNum;
end;

function TAphHnd.GetActive:boolean;
begin
  Result := BtrTable.Active;
end;


end.
