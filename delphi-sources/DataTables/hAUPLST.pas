unit hAUPLST;

interface

uses
  IcTypes, NexPath, NexGlob, bAUPLST,
  Forms, Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Dialogs;

type
  TAuplstHnd=class (TAuplstBtr)
  private
  public
    function FreeApCode:longint;
    function NextApCode:longint;
  published
  end;

implementation

function TAuplstHnd.FreeApCode:longint;
var mApCode:longint;  mFind:boolean;
begin
  Result:=0;
  SwapIndex;
  If LocateApCode(1) then begin
    mApCode:=0;
    Repeat
      Inc(mApCode);
      mFind:=mApCode<ApCode;
      If mApCode>ApCode then mApCode:=ApCode;
      Next;
    until Eof or mFind;
    If mFind
      then Result:=mApCode
      else Result:=mApCode+1;
  end
  else Result:=1;
  RestoreIndex;
end;

function TAuplstHnd.NextApCode:longint;
begin
  If Count>0 then begin
    SwapIndex;
    SetIndex(ixApCode);
    Last;
    Result:=ApCode+1;
    RestoreIndex;
  end else Result:=1;
end;

end.
{MOD 1908001}
