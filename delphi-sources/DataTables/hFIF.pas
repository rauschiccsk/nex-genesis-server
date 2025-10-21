unit hFIF;

interface

uses
  IcTypes, NexPath, NexGlob, bFIF,
  Forms, Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Dialogs;

type
  TFifHnd = class (TFifBtr)
  private
  public
    function NextFifNum:longint;
    procedure Post; overload;
  published
  end;

implementation

function TFifHnd.NextFifNum:longint;
begin
  SwapIndex;
  SetIndex (ixFifNum);
  Last;
  Result := FifNum+1;
  RestoreIndex;
end;

procedure TFifHnd.Post;
begin
  ActQnt := InQnt-OutQnt;
  If (ActQnt>0)
    then Status := 'A'
    else Status := 'X';
  If (ActQnt<0) then begin  // Bezpecnostne nastavenie
    ActQnt := 0;
    OutQnt := InQnt;
  end;
  inherited ;
end;

end.
