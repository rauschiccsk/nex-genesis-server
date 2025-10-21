unit hIPD;

interface

uses
  IcTypes, NexPath, NexGlob, bIPD,
  Forms, Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Dialogs;

type
  TIpdHnd = class (TIpdBtr)
  private
  public
    procedure Del(pDocNum:Str12);
  published
  end;

implementation

procedure TIpdHnd.Del(pDocNum:Str12);
begin
  While LocateDocNum(pDocNum) do begin
    Delete;
    Application.ProcessMessages;
  end;
end;

end.
