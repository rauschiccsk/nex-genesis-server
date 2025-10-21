unit hTcc;

interface

uses
  IcTypes, NexPath, NexGlob, bTcc,
  Forms, Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Dialogs;


type
  TTccHnd = class (TTccBtr)
  private
    function GetBokNum:Str5; // Cislo otvorenej knihy
  public
    function NextSerNum(pDocNum:Str12):word;
  published
    property BokNum:Str5 read GetBokNum;
  end;

implementation

function TTccHnd.GetBokNum:Str5; // Cislo otvorenej knihy
begin
  Result := BtrTable.BookNum;
end;

function TTccHnd.NextSerNum(pDocNum: Str12): word;
begin
  Result:=10000;
  If NearestTdTc(pDocNum,65500) then begin
    If not Eof then Prior else Last;
  end else begin
    Last;
  end;
  If TcdNum=pDocNum then Result:=TccItm+1;
end;

end.
