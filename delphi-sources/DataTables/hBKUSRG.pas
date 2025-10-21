unit hBKUSRG;

interface

uses
  IcTypes, NexPath, NexGlob, bBKUSRG,
  Forms, Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Dialogs;

type
  TBkusrgHnd = class (TBkusrgBtr)
  private
  public
    procedure Del(pLogName:Str8);
  published
  end;

implementation

procedure TBkusrgHnd.Del(pLogName:Str8);
begin
  If Count>0 then begin
    First;
    Repeat
      Application.ProcessMessages;
      If LogName=pLogName
        then Delete
        else Next;
    until Eof or (Count=0);
  end;
end;

end.
