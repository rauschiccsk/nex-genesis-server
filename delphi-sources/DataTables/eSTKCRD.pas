unit eSTKCRD;

interface

uses
  IcTypes, IcConv, dSTKCRD,
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Dialogs;

type
  TStkcrdHne=class(TStkcrdDat)
  private
  public
    procedure Post; overload;
  published
  end;

implementation

// *************************************** PRIVATE ********************************************

// **************************************** PUBLIC ********************************************

procedure TStkcrdHne.Post;
begin
  ActPrq:=BegPrq+IncPrq-OutPrq;
  AcrPrq:=BerPrq+InrPrq-OurPrq;
  AckPrq:=BekPrq+InkPrq-OukPrq;
  FrePrq:=ActPrq-OcrPrq;
  OsfPrq:=OsdPrq-OsrPrq;
  ActCva:=BegCva+IncCva-OutCva;
  If (FrePrq<0) then FrePrq:=0;
  If (ActPrq>0) then AvgCpc:=ActCva/ActPrq else AvgCpc:=LasCpc;
  If (MaxPrq>0) and (FrePrq>MaxPrq) then MinMax:='X';
  If (MinPrq>0) and (FrePrq<=MinPrq) then MinMax:='N';
  inherited ;
end;

end.
