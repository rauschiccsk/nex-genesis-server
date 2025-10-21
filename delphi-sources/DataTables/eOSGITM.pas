unit eOSGITM;

interface

uses
  IcTypes, IcConv, dOSGITM,
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Dialogs;

type
  TOsgitmHne=class(TOsgitmDat)
  private
  public
    procedure Post; overload;
  published
  end;

implementation

// *************************************** PRIVATE ********************************************

// **************************************** PUBLIC ********************************************

procedure TOsgitmHne.Post;
begin
//  UndPrq:=OrdPrq-TsdPrq;
//  FreRes:=byte(UndPrq>RocPrq);
  inherited ;
end;

end.
