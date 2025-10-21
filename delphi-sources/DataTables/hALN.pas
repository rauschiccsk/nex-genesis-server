unit hALN;

interface

uses
  IcTypes, NexPath, NexGlob, bALN, 
  Forms, Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Dialogs;

type
  TAlnHnd = class (TAlnBtr)
  private
  public
    procedure Del(pDocNum:Str12);
  published
  end;

implementation

procedure TAlnHnd.Del(pDocNum:Str12);
begin
  While LocateDocNum(pDocNum) do begin
    Delete;
    Application.ProcessMessages;
  end;
end;

end.
