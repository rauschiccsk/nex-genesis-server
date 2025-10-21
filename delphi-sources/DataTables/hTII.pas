unit hTII;

interface

uses
  IcTypes, NexPath, NexGlob, bTII,
  Forms, Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Dialogs;

type
  TTiiHnd = class (TTiiBtr)
  private
  public
    function FreeItmNum(pDocNum:Str12):word;
    function NextItmNum(pDocNum:Str12):word;
  published
  end;

implementation

function TTiiHnd.FreeItmNum(pDocNum:Str12):word;
var mItmNum:word;  mFind:boolean;
begin
  Result:=0;
  SwapIndex;
  If LocateDoIt(pDocNum,1) then begin
    mItmNum:=0;
    Repeat
      Inc(mItmNum);
      mFind:=mItmNum<ItmNum;
      If mItmNum>ItmNum then mItmNum:=ItmNum;
      Next;
    until Eof or mFind or (DocNum<>pDocNum);
    If mFind
      then Result:=mItmNum
      else Result:=mItmNum+1;
  end
  else Result:=1;
  RestoreIndex;
end;

function TTiiHnd.NextItmNum(pDocNum:Str12):word;
begin
  If not NearestDoIt(pDocNum,65000) then Last;
  If not IsLastRec or (DocNum<>pDocNum) then Prior;
  If DocNum=pDocNum
    then Result:=ItmNum+1
    else Result:=1;
end;

end.
