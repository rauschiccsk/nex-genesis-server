unit hHrshlg;

interface

uses
  IcTypes, NexPath, NexGlob, bHrshlg,
  Forms, Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Dialogs;


type
  THrshlgHnd = class (THrshlgBtr)
  private
  public
    function NextSerNum:longint;
  published
  end;

implementation

{ THrshlgHnd }

function THrshlgHnd.NextSerNum: longint;
begin
  SwapStatus;
  If Count=0 then Result:=1
  else begin
    NearestSerNum(1);
    Last;
    Result:=SerNum+1;
  end;
  RestoreStatus;
end;

end.
