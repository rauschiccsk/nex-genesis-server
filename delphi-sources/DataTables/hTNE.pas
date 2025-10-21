unit hTne;

interface

uses
  IcTypes, NexPath, NexGlob, bTne,
  Forms, Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Dialogs;


type
  TTneHnd = class (TTneBtr)
  private
  public
    function NextSerNum:longint; // Najde nasledujuce volne cislo dokladu
  published
  end;

implementation

{ TTneHnd }

function TTneHnd.NextSerNum: longint;
begin
  Result:=1;
  if Count>0 then begin
    SwapStatus;
    NearestEvNum(0);
    Last;
    Result:=EvNum+1;
    RestoreStatus;
  end;
end;

end.
{MOD 1905001}
