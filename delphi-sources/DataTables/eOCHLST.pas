unit eOCHLST;

interface

uses
  IcTypes, IcConv, IcTools, dOCHLST,
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Dialogs;

type
  TOchlstHne=class(TOchlstDat)
  private
  public
    procedure Post; overload;
  published
  end;

implementation

// *************************************** PRIVATE ********************************************

// **************************************** PUBLIC ********************************************

procedure TOchlstHne.Post;
begin
  DstExd:='';
  If ExdPrq>0 then DstExd:='E';
  If IsNul(DvzCrs) then DvzCrs:=1;
  If DvzNam='' then DvzNam:='EUR';
  If PayCod='' then PayCod:='H';
  If TrsCod='' then TrsCod:='C';
  If TrsCod<>'V' then TrsLin:=0;
  inherited ;
end;

end.
