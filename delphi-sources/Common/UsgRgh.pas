unit UsgRgh;

interface

uses
  IcTypes, IcTools,
  SrmRgh,
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, NexBtrTable, Forms;

type
  TUsgRgh=class
    constructor Create;
    destructor Destroy;
  private
    oSrmRgh:TSrmRgh;
  public
    procedure LodUsrRgh(pGrpNum:word;pPmdCod,pBokNum:Str3);
    procedure SavUsrRgh(pGrpNum:word;pPmdCod,pBokNum:Str3);
  published
    property Srm:TSrmRgh read oSrmRgh write oSrmRgh;
  end;

var gUsg:TUsgRgh;

implementation

constructor TUsgRgh.Create;
begin
  oSrmRgh:=TSrmRgh.Create;
end;

destructor TUsgRgh.Destroy;
begin
  FreeAndNil(oSrmRgh);
end;

procedure TUsgRgh.LodUsrRgh(pGrpNum:word;pPmdCod,pBokNum:Str3);
var mUsgRgh:Str255;
begin
  mUsgRgh:=FillStr('',255,'.');
  If oUsrDat.ohUSGRGH.LocGnPcBn(pGrpNum,pPmdCod,pBokNum) then mUsgRgh:=oUsrDat.ohUSGRGH.UsgRgh;
  If pPmdCod='SRM' then oSrmRgh.UsgRgh:=mUsgRgh;
end;

procedure TUsgRgh.SavUsrRgh(pGrpNum:word;pPmdCod,pBokNum:Str3);
var mUsgRgh:Str255;
begin
  If pPmdCod='SRM' then mUsgRgh:=oSrmRgh.UsgRgh;
  With oUsrDat do begin
    If ohUSGRGH.LocGnPcBn(pGrpNum,pPmdCod,pBokNum) then begin
      ohUSGRGH.Edit;
      ohUSGRGH.UsgRgh:=mUsgRgh;
      ohUSGRGH.Post;
    end else begin
      ohUSGRGH.Insert;
      ohUSGRGH.GrpNum:=pGrpNum;
      ohUSGRGH.PmdCod:=pPmdCod;
      ohUSGRGH.BokNum:=pBokNum;
      ohUSGRGH.UsgRgh:=mUsgRgh;
      ohUSGRGH.Post;
    end;
  end;
end;

// ******************************* PRIVATE *************************************

end.

