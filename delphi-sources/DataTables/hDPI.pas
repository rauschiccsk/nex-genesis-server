unit hDPI;

interface

uses
  IcTypes, IcConv, NexPath, NexGlob, bDPI,
  DocHand,
  Forms, Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Dialogs;

type
  TDpiHnd = class (TDpiBtr)
  private
  public
    procedure Post; override;
    function FreeItmNum(pDocNum:Str12):word;
    function NextItmNum(pDocNum:Str12):word;
    function GenDocNum (pYear:Str2;pSerNum:longint):Str12; // Vygeneruje interne cislo dokladu
  published
  end;

implementation

procedure TDpiHnd.Post;
begin
  EndVal := InvVal-PayVal;
  inherited;
end;

function TDpiHnd.FreeItmNum(pDocNum:Str12):word;
var mItmNum:word;  mFind:boolean;
begin
  Result := 0;
  SwapIndex;
  If LocateDoIt(pDocNum,1) then begin
    mItmNum := 0;
    Repeat
      Inc (mItmNum);
      mFind := mItmNum<ItmNum;
      If mItmNum>ItmNum then mItmNum := ItmNum;
      Next;
    until Eof or mFind or (DocNum<>pDocNum);
    If mFind
      then Result := mItmNum
      else Result := mItmNum+1;
  end
  else Result := 1;
  RestoreIndex;
end;

function TDpiHnd.NextItmNum(pDocNum:Str12):word;
begin
  SwapIndex;
  SetIndex(ixItmNum);
  Last;
  Result := ItmNum+1;
  RestoreIndex;
end;

function TDpiHnd.GenDocNum (pYear:Str2;pSerNum:longint):Str12; // Vygeneruje interne cislo dokladu
begin
  Result := DocHand.GenDiDocNum(pYear,BtrTable.BookNum,pSerNum);
end;

end.
{MOD 1904011}

