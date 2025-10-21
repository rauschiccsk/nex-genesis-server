unit hFINJRN;

interface

uses
  IcTypes, NexPath, NexGlob, bFINJRN,
  Forms, Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Dialogs;

type
  TFinjrnHnd = class (TFinjrnBtr)
  private
  public
    procedure DocDel(pDocNum:Str12);
  published
  end;

implementation

procedure TFinjrnHnd.DocDel(pDocNum:Str12);
begin
  While LocateDocNum(pDocNum) do begin
    Delete;
    Application.ProcessMessages;
  end;
end;

end.
