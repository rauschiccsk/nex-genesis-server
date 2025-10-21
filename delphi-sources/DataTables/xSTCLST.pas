unit xSTCLST;

interface

uses
  IcTypes, IcConv, hSTCLST,
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Dialogs;

type
  TStclstHnx=class(TStclstHnd)
  private
  public
    procedure Post; overload;
  published
  end;

implementation

// *************************************** PRIVATE ********************************************

// **************************************** PUBLIC ********************************************

procedure TStclstHnx.Post;
begin
  ActPrq:=BegPrq+IncPrq-OutPrq;
  ActVal:=BegVal+IncVal-OutVal;
  FrePrq:=ActPrq-RstPrq-RsaPrq;
  FroPrq:=OsdPrq-RosPrq;
  If (FrePrq<0) then FrePrq:=0;
  If (ActPrq>0)
    then AvgApc:=ActVal/ActPrq
    else AvgApc:=LasApc;
  If (MaxPrq>0) and (FrePrq>MaxPrq) then MinMax:='X';
  If (MinPrq>0) and (FrePrq<=MinPrq) then MinMax:='N';
  inherited ;
end;

end.
