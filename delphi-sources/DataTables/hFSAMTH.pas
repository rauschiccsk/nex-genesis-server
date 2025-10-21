unit hFSAMTH;

interface

uses
  IcTypes, NexPath, NexGlob, bFSAMTH,
  Forms, Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Dialogs;

type
  TFsamthHnd = class (TFsamthBtr)
  private
  public
    procedure Del;  // Vymaze csetky zaznamyh z databaze
  published
  end;

implementation

procedure TFsamthHnd.Del;
begin
  If Count>0 then begin
    First;
    Repeat
      Delete
    until Eof or (Count=0)
  end;
end;

end.
