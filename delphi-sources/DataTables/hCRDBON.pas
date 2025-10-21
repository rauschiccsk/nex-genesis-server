unit hCRDBON;

interface

uses
  IcTypes, NexPath, NexGlob, bCRDBON,
  Forms, Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Dialogs;

type
  TCrdbonHnd = class (TCrdbonBtr)
  private
  public
    function NextSerNum:longint; // Najde nasledujuce volne cislo dokladu
  published
  end;

implementation

function TCrdbonHnd.NextSerNum:longint; // Najde nasledujuce volne cislo dokladu
begin
  SwapStatus;
  SetIndex (ixSerNum);
  Last;
  Result := SerNum+1;
  RestoreStatus;
end;


end.
