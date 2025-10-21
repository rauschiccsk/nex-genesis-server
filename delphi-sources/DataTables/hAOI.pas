unit hAOI;

interface

uses
  IcTypes, IcTools, NexPath, NexGlob, bAOI,
  Forms, Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Dialogs;

type
  TAoiHnd = class (TAoiBtr)
  private
  public
    procedure Post; overload;
    function FreeItmNum(pDocNum:Str12):word;
    function NextItmNum(pDocNum:Str12):word;
  published
  end;

implementation

procedure TAoiHnd.Post;
begin
  If AldNum='' then begin
    If Eq5(GsQnt,ResQnt)
      then Status := 'R'
      else Status := 'N';
  end
  else Status := 'Z';
  inherited ;
end;

function TAoiHnd.FreeItmNum(pDocNum:Str12):word;
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

function TAoiHnd.NextItmNum(pDocNum:Str12):word;
begin
  If not NearestDoIt(pDocNum,65000) then Last;
  If not IsLastRec or (DocNum<>pDocNum) then Prior;
  If DocNum=pDocNum
    then Result := ItmNum+1
    else Result := 1;
end;

end.
