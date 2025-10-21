unit hOPENDOC;

interface

uses
  IcTypes, NexPath, NexGlob, bOPENDOC,
  Forms, Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Dialogs;

type
  TOpendocHnd = class (TOpendocBtr)
  private
  public
    procedure Del(pUsrName:Str30);
  published
  end;

implementation

procedure TOpendocHnd.Del(pUsrName:Str30);
begin
  If Count>0 then begin
    First;
    Repeat
      Application.ProcessMessages;
      If UserName=pUsrName
        then Delete
        else Next;
    until Eof or (Count=0);
  end;
end;

end.
