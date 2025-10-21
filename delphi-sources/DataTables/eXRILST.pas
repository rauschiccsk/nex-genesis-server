unit eXRILST;

interface

uses
  IcTypes, IcConv, dXRILST,    
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Dialogs;

type
  TXrilstHne=class(TXrilstDat)
  private
  public
    procedure Post; overload;
  published
  end;

implementation

// *************************************** PRIVATE ********************************************

// **************************************** PUBLIC ********************************************

procedure TXrilstHne.Post;
begin
  SalPrq:=SalStq+SalCmq;
  StkPrq:=StkStq+StkCmq;
  inherited ;
end;

end.
