unit hTnh;

interface

uses
  IcTypes, NexPath, NexGlob, bTnh,
  Forms, Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Dialogs;


type
  TTnhHnd = class (TTnhBtr)
  private
  public
    function NextTentNum:longint; // Najde nasledujuce volne cislo dokladu
  published
  end;

implementation

function TTnhHnd.NextTentNum:longint; // Najde nasledujuce volne cislo dokladu
begin
  SwapStatus;
  SetIndex (ixTentNum);
  Last;
  Result := TentNum+1;
  RestoreStatus;
end;

end.
