unit hCAPADV;

interface

uses
  IcTypes, NexPath, NexGlob, bCAPADV,
  Forms, Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Dialogs;

type
  TCapadvHnd = class (TCapadvBtr)
  private
  public
    procedure Del (pPayNum:word);
  published
  end;

implementation

procedure TCapadvHnd.Del (pPayNum:word);
begin
  While LocatePayNum(pPayNum) do Delete; 
end;

end.
