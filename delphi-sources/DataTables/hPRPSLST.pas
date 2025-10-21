unit hPrpslst;

interface

uses
  IcTypes, NexPath, NexGlob, bPrpslst,//tPrpslst,
  Forms, Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Dialogs;


type
  TPrpslstHnd = class (TPrpslstBtr)
  private
//    oTmpTable: TPrpslstTmp;
  public
    procedure Open; override;
  published
  end;

implementation

{ TPrpslstHnd }

procedure TPrpslstHnd.Open;
begin
  inherited;
  If not LocatePrpsCode(0) then begin
    Insert; PrpsCode:=0; PrpsName:='Odvod tržby';Post;
  end;
  If not LocatePrpsCode(1) then begin
    Insert; PrpsCode:=1; PrpsName:='Nákup tovaru';Post;
  end;
end;

end.
