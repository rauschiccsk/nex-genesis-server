unit hFSADAY;

interface

uses
  IcTypes, NexPath, NexGlob, bFSADAY,
  Forms, Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Dialogs;

type
  TFsadayHnd = class (TFsadayBtr)
  private
  public
    procedure Del;  // Vymaze csetky zaznamyh z databaze
  published
  end;

implementation

procedure TFsadayHnd.Del;
begin
  If Count>0 then begin
    First;
    Repeat
      Delete
    until Eof or (Count=0)
  end;
end;

end.
