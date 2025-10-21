unit hRpc;

interface

uses
  IcTypes, NexPath, NexGlob, bRPC,
  Forms, Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Dialogs;

type
  TRpcHnd = class (TRpcBtr)
  private
  public
    function NextSerNum:longint;  // Najde nasledujuce volne cislo polozky
  published
  end;

implementation

function TRpcHnd.NextSerNum:longint; // Najde nasledujuce volne cislo polozky
begin
  SwapStatus;
  SetIndex (bRPC.ixSerNum);
  Last;
  Result := SerNum+1;
  RestoreStatus;
end;

end.
