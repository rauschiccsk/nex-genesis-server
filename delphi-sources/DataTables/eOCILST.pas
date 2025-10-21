unit eOCILST;

interface

uses
  IcTypes, IcConv, IcTools, NexClc, dOCILST,
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Dialogs;

type
  TOcilstHne=class(TOcilstDat)
  private
  public
    procedure Post; overload;
  published
  end;

implementation

// *************************************** PRIVATE ********************************************

// **************************************** PUBLIC ********************************************

procedure TOcilstHne.Post;
begin
  UndPrq:=SalPrq-TcdPrq-CncPrq;
  If UndPrq<0 then UndPrq:=0;
  ReqPrq:=UndPrq-RstPrq-RosPrq;
  If ReqPrq<0 then ReqPrq:=0;
  If IsNul(UndPrq) then begin TrsDte:=0; RatDte:=0;  end;
  EndBva:=SalBva+TrsBva;
  If IsNotNul(SalPrq) then SalApc:=RndBas(SalAva/SalPrq);
  ReqSta:='';  RstSta:='';  RosSta:='';  ExdSta:='';  UndSta:='';  CncSta:='';
  If IsNotNul(ReqPrq) then ReqSta:='P';
  If IsNotNul(RstPrq) then RstSta:='R';
  If IsNotNul(RosPrq) then RosSta:='R';
  If IsNotNul(ExdPrq) then ExdSta:='E';
  If IsNotNul(UndPrq) then UndSta:='U';
  If IsNotNul(CncPrq) then CncSta:='C';
  inherited ;
end;

end.
