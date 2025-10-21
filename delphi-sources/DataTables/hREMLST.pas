unit hREMLST;

interface

uses
  IcTypes, NexPath, NexGlob, bREMLST,
  Forms, Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Dialogs;

type
  TRemlstHnd = class (TRemlstBtr)
  private
  public
    function FreeRemNum(pDocNum:Str12;pItmNum:word):word;
    function NextRemNum(pDocNum:Str12;pItmNum:word):word;
  published
  end;

implementation

function TRemlstHnd.FreeRemNum(pDocNum:Str12;pItmNum:word):word;
var mRemNum:word;  mFind:boolean;
begin
  Result:=0;
  SwapIndex;
  If LocateDnInRn(pDocNum,pItmNum,1) then begin
    mRemNum:=0;
    Repeat
      Inc(mRemNum);
      mFind:=mRemNum<RemNum;
      If mRemNum>RemNum then mRemNum:=RemNum;
      Next;
    until Eof or mFind or (DocNum<>pDocNum) or (ItmNum<>pItmNum);
    If mFind
      then Result:=mRemNum
      else Result:=mRemNum+1;
  end
  else Result:=1;
  RestoreIndex;
end;

function TRemlstHnd.NextRemNum(pDocNum:Str12;pItmNum:word):word;
begin
  If not NearestDnInRn(pDocNum,pItmNum,65000) then Last;
  If not IsLastRec or (DocNum<>pDocNum) or (ItmNum<>pItmNum) then Prior;
  If DocNum=pDocNum
    then Result:=RemNum+1
    else Result:=1;
end;

end.
{MOD 1907001}
