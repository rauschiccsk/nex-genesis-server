unit hKSN;

interface

uses
  IcTypes, NexPath, NexGlob, bKSN,
  Forms, Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Dialogs;

type
  TKsnHnd = class (TKsnBtr)
  private
  public
    procedure Del(pDocNum:Str12);
  published
  end;

implementation

procedure TKsnHnd.Del(pDocNum:Str12);
begin
  While LocateDocNum(pDocNum) do begin
    Delete;
    Application.ProcessMessages;
  end;
end;

end.
