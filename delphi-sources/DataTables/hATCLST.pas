unit hATCLST;

interface

uses
  IcTypes, NexPath, NexGlob, bATCLST,
  Forms, Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Dialogs;

type
  TAtclstHnd=class (TAtclstBtr)
  private
  public
    function FreeAtcNum(pDocNum:Str12;pItmNum:word):word;
    function NextAtcNum(pDocNum:Str12;pItmNum:word):word;
  published
  end;

implementation

function TAtclstHnd.FreeAtcNum(pDocNum:Str12;pItmNum:word):word;
var mAtcNum:word;  mFind:boolean;
begin
  Result:=0;
  SwapIndex;
  If LocateDnInAn(pDocNum,pItmNum,1) then begin
    mAtcNum:=0;
    Repeat
      Inc(mAtcNum);
      mFind:=mAtcNum<AtcNum;
      If mAtcNum>AtcNum then mAtcNum:=AtcNum;
      Next;
    until Eof or mFind or (DocNum<>pDocNum) or (ItmNum<>pItmNum);
    If mFind
      then Result:=mAtcNum
      else Result:=mAtcNum+1;
  end
  else Result:=1;
  RestoreIndex;
end;

function TAtclstHnd.NextAtcNum(pDocNum:Str12;pItmNum:word):word;
begin
  If not NearestDnInAn(pDocNum,pItmNum,65000) then Last;
  If not IsLastRec or (DocNum<>pDocNum) or (ItmNum<>pItmNum) then Prior;
  If DocNum=pDocNum
    then Result:=AtcNum+1
    else Result:=1;
end;

end.
{MOD 1907001}
