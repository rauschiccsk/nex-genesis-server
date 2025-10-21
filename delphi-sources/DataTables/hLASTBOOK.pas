unit hLASTBOOK;

interface

uses
  IcTypes, NexPath, NexGlob, bLASTBOOK,
  Forms, Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Dialogs;

type
  TLastbookHnd = class (TLastbookBtr)
  private
  public
    procedure Del(pLogName:Str8);
  published
  end;

implementation

procedure TLastbookHnd.Del(pLogName:Str8);
begin
  If Count>0 then begin
    First;
    Repeat
      Application.ProcessMessages;
      If LoginName=pLogName
        then Delete
        else Next;
    until Eof or (Count=0);
  end;
end;

end.
