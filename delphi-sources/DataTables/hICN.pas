unit hICN;

interface

uses
  IcTypes, NexPath, NexGlob, bICN,
  Forms, Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Dialogs;

type
  TIcnHnd = class (TIcnBtr)
  private
  public
    procedure Del(pDocNum:Str12);
  published
  end;

implementation

procedure TIcnHnd.Del(pDocNum:Str12);
begin
  While LocateDocNum(pDocNum) do begin
    Delete;
    Application.ProcessMessages;
  end;
end;

end.
