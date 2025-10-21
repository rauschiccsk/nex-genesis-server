unit hIPG;

interface

uses
  IcTypes, NexPath, NexGlob, bIPG,
  Forms, Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Dialogs;

type
  TIpgHnd = class (TIpgBtr)
  private
  public
    procedure Del(pDocNum:Str12);
  published
  end;

implementation

procedure TIpgHnd.Del(pDocNum:Str12);
begin
  While LocateDocNum(pDocNum) do begin
    Delete;
    Application.ProcessMessages;
  end;
end;


end.
