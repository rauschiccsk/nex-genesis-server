unit hALC;

interface

uses
  IcTypes, NexPath, NexGlob, bALC,
  Forms, Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Dialogs;

type
  TAlcHnd = class (TAlcBtr)
  private
  public
    procedure Del(pDocNum:Str12);
  published
  end;

implementation

procedure TAlcHnd.Del(pDocNum:Str12);
begin
  While LocateDocNum(pDocNum) do begin
    Delete;
    Application.ProcessMessages;
  end;
end;


end.
