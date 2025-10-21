unit hCAPDEF;

interface

uses
  IcTypes, NexPath, NexGlob, bCAPDEF,
  Forms, Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Dialogs;

type
  TCapdefHnd = class (TCapdefBtr)
  private
  public
    procedure Open; override;
    function NextPayNum:word;
  published
  end;

implementation

procedure TCapdefHnd.Open;
begin
  inherited;
  If Count=0 then begin
    Insert;
    PayNum := 0;
    PayName := 'Hotovosù';
    Post;
  end;
end;

function TCapdefHnd.NextPayNum:word;
begin
  SwapIndex;
  SetIndex (ixPayNum);
  Last;
  Result := PayNum+1;
  RestoreIndex;
end;

end.
