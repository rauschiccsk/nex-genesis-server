unit eSHDITM;

interface

uses
  IcTypes, IcConv, NexClc, dSHDITM,
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Dialogs;

type
  TShditmHne=class(TShdItmDat)
  private
    constructor Create; overload;
  public
    procedure Post; overload;
  published
  end;

implementation

// *************************************** PRIVATE ********************************************

constructor TShditmHne.Create;
begin
  inherited;
  oTable.DelToTxt:=FALSE;  // 8.3.2019 TIBI - vypne z�pis vymazan�ch rekordov do DEL s�boru
end;

// **************************************** PUBLIC ********************************************

procedure TShditmHne.Post;
begin
  PrfAva:=SalAva-StkAva;
  PrfPrc:=ClcPrfPrc(StkAva,SalAva);
  inherited ;
end;

end.
