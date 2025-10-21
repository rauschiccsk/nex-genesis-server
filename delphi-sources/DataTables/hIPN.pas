unit hIPN;

interface

uses
  IcTypes, NexPath, NexGlob, bIPN,
  Forms, Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Dialogs;

type
  TIpnHnd = class (TIpnBtr)
  private
  public
    procedure Del(pDocNum:Str12);
  published
  end;

implementation

procedure TIpnHnd.Del(pDocNum:Str12);
begin
  While LocateDocNum(pDocNum) do begin
    Delete;
    Application.ProcessMessages;
  end;
end;

end.
