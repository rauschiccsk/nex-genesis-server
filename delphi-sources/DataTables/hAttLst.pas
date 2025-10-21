unit hAttlst;

interface

uses
  IcTypes, NexPath, NexGlob, bAttlst,
  Forms, Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Dialogs;


type
  TAttlstHnd = class (TAttlstBtr)
  private
  public
    function FreeAttNum(pDocNum:Str12):word;
    function NextAttNum(pDocNum:Str12):word;
  published
  end;

implementation

{ TAttlstHnd }

function TAttlstHnd.FreeAttNum(pDocNum: Str12): word;
var mAttNum:word;  mFind:boolean;
begin
  Result := 0;
  SwapIndex;
  If LocateDnAn(pDocNum,1) then begin
    mAttNum := 0;
    Repeat
      Inc (mAttNum);
      mFind := mAttNum<AttNum;
      If mAttNum>AttNum then mAttNum := AttNum;
      Next;
    until Eof or mFind or (DocNum<>pDocNum);
    If mFind
      then Result := mAttNum
      else Result := mAttNum+1;
  end
  else Result := 1;
  RestoreIndex;
end;

function TAttlstHnd.NextAttNum(pDocNum: Str12): word;
begin
  If not NearestDnAn(pDocNum,65000) then Last;
  If not IsLastRec or (DocNum<>pDocNum) then Prior;
  If DocNum=pDocNum
    then Result := AttNum+1
    else Result := 1;
end;

end.
{MOD 1902010}
