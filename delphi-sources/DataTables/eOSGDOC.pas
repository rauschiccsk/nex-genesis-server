unit eOSGDOC;

interface

uses
  IcTypes, IcConv, dOSGDOC,
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Dialogs;

type
  TOsgdocHne=class(TOsgdocDat)
  private
  public
    procedure Post; overload;
  published
  end;

implementation

// *************************************** PRIVATE ********************************************

// **************************************** PUBLIC ********************************************

procedure TOsgdocHne.Post;
begin
//  UndPrq:=OrdPrq-TsdPrq;
//  FreRes:=byte(UndPrq>RocPrq);
  inherited ;
end;

end.
