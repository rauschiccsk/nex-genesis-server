unit hIDH;

interface

uses
  IcTypes, IcTools, IcConv, NexGlob, bIDH, Dochand,
  Forms, Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Dialogs;

type
  TIdhHnd = class (TIdhBtr)
  private
    function GetVatPrc(pVatGrp:byte):byte; // Vráti percentuálnu sadzbu DPH zadanej daòovej skupiny
  public
    function GenDocNum (pYear:Str2;pSerNum:longint):Str12; // Vygeneruje interne cislo dokladu

    property VatPrc[pVatGrp:byte]:byte read GetVatPrc;
  end;

implementation

function TIdhHnd.GetVatPrc(pVatGrp:byte):byte; // Vráti percentuálnu sadzbu DPH zadanej daòovej skupiny
begin
  Result := 0;
  case pVatGrp of
    1: Result := VatPrc1;
    2: Result := VatPrc2;
    3: Result := VatPrc3;
    4: Result := VatPrc4;
    5: Result := VatPrc5;
  end;
end;

function TIdhHnd.GenDocNum (pYear:Str2;pSerNum:longint):Str12; // Vygeneruje interne cislo dokladu
begin
  Result := GenIdDocNum(pYear,BtrTable.BookNum,pSerNum);
end;

end.
