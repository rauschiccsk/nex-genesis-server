unit eEDOIMP;

interface

uses
  IcTypes, IcConv, IcTools, NexClc, dEDOIMP,
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Dialogs;

type
  TEdoimpHne=class(TEdoimpDat)
  private
  public
    procedure Post; overload;
  published
  end;

implementation

// *************************************** PRIVATE ********************************************

// **************************************** PUBLIC ********************************************

procedure TEdoimpHne.Post;
begin
  If IsNotNul(BuyPrq) then BuyApc:=RndBas(BuyAva/BuyPrq);
  inherited ;
end;

end.
