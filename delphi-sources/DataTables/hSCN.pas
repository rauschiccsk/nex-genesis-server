unit hSCN;

interface

uses
  IcTypes, NexPath, NexGlob, bSCN,
  Forms, Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Dialogs;

type
  TScnHnd = class (TScnBtr)
  private
  public
    procedure Del(pDocNum:Str12);
  published
  end;

implementation

procedure TScnHnd.Del(pDocNum:Str12);
begin
  While LocateDocNum(pDocNum) do begin
    Delete;
    Application.ProcessMessages;
  end;
end;

end.
