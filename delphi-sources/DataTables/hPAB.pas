unit hPAB;

interface

uses
  IcTypes, NexPath, NexGlob, bPAB,
  Forms, Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Dialogs;

type
  TPabHnd = class (TPabBtr)
  private
  public
    procedure Insert; overload;
    function  NextPaCodeInt(pF,pL:longint):longint;
  published
  end;

implementation

procedure TPabHnd.Insert;
var mNextPaCode:longint;
begin
  SwapIndex;
  SetIndex(ixPaCode);
  Last;
  mNextPaCode := PaCode+1;
  RestoreIndex;
  inherited ;
  PaCode := mNextPaCode;
end;

function TPabHnd.NextPaCodeInt;
begin
  Result:=pF;
  If Count=1 then Exit;
  If not NearestPaCode(pF) then Exit;
  If pL=0 then begin
    Last;
    If PaCode>pF then Result:=PaCode+1;
  end else begin
    NearestPaCode(pL);
    If not EOF then Prior else Last;
    If PaCode>pF then Result:=PaCode+1;
  end;
end;

end.
