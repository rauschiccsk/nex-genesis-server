unit hBARCODE;

interface

uses
  IcTypes, NexPath, NexGlob, bBARCODE,
  Forms, Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Dialogs;

type
  TBarcodeHnd = class (TBarcodeBtr)
  private
  public
    procedure Del(pGsCode:longint);
  published
  end;

implementation

procedure TBarcodeHnd.Del(pGsCode:longint);
begin
  While LocateGsCode(pGsCode) do Delete;
end;

end.
