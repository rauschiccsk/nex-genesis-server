unit hABODAT;

interface

uses
  IcTypes, NexPath, NexGlob, bABODAT,
  Forms, Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Dialogs;

type
  TAbodatHnd = class (TAbodatBtr)
  private
  public
    procedure Del(pLogName:Str8);
  published
  end;

implementation

procedure TAbodatHnd.Del(pLogName:Str8);
begin
  If Count>0 then begin
    First;
    Repeat
      Application.ProcessMessages;
      If LgnName=pLogName
        then Delete
        else Next;
    until Eof or (Count=0);
  end;
end;

end.
