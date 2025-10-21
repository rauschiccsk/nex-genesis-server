unit hOSI;

interface

uses
  IcTypes, NexPath, NexGlob, bOSI,
  Forms, Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Dialogs;

type
  TOsiHnd = class (TOsiBtr)
  private
  public
    procedure Del(pDocNum:Str12);
  published
  end;

implementation

procedure ToSiHnd.Del(pDocNum:Str12);
begin
  While LocateDocNum(pDocNum) do begin
    Delete;
    Application.ProcessMessages;
  end;
end;

end.
