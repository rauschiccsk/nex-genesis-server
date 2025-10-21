unit hFSABOK;

interface

uses
  IcTypes, NexPath, NexGlob, bFSABOK,
  Forms, Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Dialogs;

type
  TFsabokHnd = class (TFsabokBtr)
  private
  public
    procedure Nul;
  published
  end;

implementation

procedure TFsabokHnd.Nul;
begin
  Edit;
  BuyVal := 0;
  SalVal := 0;
  OvrVal := 0;
  PrfVal := 0;
  PrfPrc := 0;
  Post;
end;

end.
