unit eOSILST;

interface

uses
  IcTypes, IcConv, IcTools, dOSILST,
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Dialogs;

type
  TOsilstHne=class(TOsilstDat)
  private
  public
    procedure Post; overload;
  published
  end;

implementation

// *************************************** PRIVATE ********************************************

// **************************************** PUBLIC ********************************************

procedure TOsilstHne.Post;
begin
  UndPrq:=OrdPrq-TsdPrq-CncPrq;
  If UndPrq<0 then UndPrq:=0;
  FreRes:=byte(UndPrq>RocPrq);
  If SndDte>0 then SndSta:='O';
  If IsNul(UndPrq)
    then ItmSta:='S'
    else ItmSta:='O';
  inherited ;
end;

end.
