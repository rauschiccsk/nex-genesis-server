unit hAscdoc;

interface

uses
  IcTypes, NexPath, NexGlob, bASCDOC,
  Forms, Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Dialogs;

type
  TAscdocHnd = class (TAscdocBtr)
  private
  public
    function NextSerNum:longint;  // Najde nasledujuce volne cislo dokladu
  published
  end;

implementation

function TAscdocHnd.NextSerNum:longint; // Najde nasledujuce volne cislo dokladu
begin
  SwapStatus;
  SetIndex (ixSerNum);
  Last;
  Result := SerNum+1;
  RestoreStatus;
end;

end.
