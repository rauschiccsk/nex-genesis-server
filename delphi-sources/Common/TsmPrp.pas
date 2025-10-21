unit TsmPrp;

interface

uses
  IcTypes, IcConv, IcVariab, hPRPDEF,
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls,
  Dialogs, DB, NexBtrTable, DBTables, NexPxTable;

type
  TTsmPrp=class
    constructor Create(phPRPDEF:TPrpdefHnd);
    procedure OpenPRPDEF;
  private
    ohPRPDEF:TPrpdefHnd;
    // Parametre modulu
    function GetRndSnt:Str3;     procedure SetRndSnt(pValue:Str3);
    function GetRndAnl:Str6;     procedure SetRndAnl(pValue:Str6);
    function GetAqvSnt:Str3;     procedure SetAqvSnt(pValue:Str3);
    function GetAqvAnl:Str6;     procedure SetAqvAnl(pValue:Str6);
    // Parametre knihy
  public
    property RndSnt:Str3 read GetRndSnt write SetRndSnt;                  // Syntetický úèet zaokrúhlenia dokladu
    property RndAnl:Str6 read GetRndAnl write SetRndAnl;                  // Analitický úèet zaokrúhlenia dokladu
    property AqvSnt:Str3 read GetAqvSnt write SetAqvSnt;                  // Syntetický úèet obstarávacích nákladov
    property AqvAnl:Str6 read GetAqvAnl write SetAqvAnl;                  // Analitický úèet obstarávacích nákladov
    // ------------------------------------------- Nastavenia pre vybranú knihy  --------------------------------------------
  end;

implementation

constructor TTsmPrp.Create(phPRPDEF:TPrpdefHnd);
begin
  ohPRPDEF:=phPRPDEF;
end;

procedure TTsmPrp.OpenPRPDEF;
begin
  If not ohPRPDEF.Active then ohPRPDEF.Open;;
end;

// ******************************** PRIVATE ************************************

function TTsmPrp.GetRndSnt:Str3;
begin
  OpenPRPDEF;
  Result:=ohPRPDEF.ReadString('TSM','','RndSnt','132');
end;

procedure TTsmPrp.SetRndSnt(pValue:Str3);
begin
  OpenPRPDEF;
  ohPRPDEF.WriteString('TSM','','RndSnt',pValue);
end;

function TTsmPrp.GetRndAnl:Str6;
begin
  OpenPRPDEF;
  Result:=ohPRPDEF.ReadString('TSM','','RndAnl','000900');
end;

procedure TTsmPrp.SetRndAnl(pValue:Str6);
begin
  OpenPRPDEF;
  ohPRPDEF.WriteString('TSM','','RndAnl',pValue);
end;

function TTsmPrp.GetAqvSnt:Str3;
begin
  OpenPRPDEF;
  Result:=ohPRPDEF.ReadString('TSM','','AqvSnt','131');
end;

procedure TTsmPrp.SetAqvSnt(pValue:Str3);
begin
  OpenPRPDEF;
  ohPRPDEF.WriteString('TSM','','AqvSnt',pValue);
end;

function TTsmPrp.GetAqvAnl:Str6;
begin
  OpenPRPDEF;
  Result:=ohPRPDEF.ReadString('TSM','','AqvAnl','000900');
end;

procedure TTsmPrp.SetAqvAnl(pValue:Str6);
begin
  OpenPRPDEF;
  ohPRPDEF.WriteString('TSM','','AqvAnl',pValue);
end;
// ********************************* PUBLIC ************************************

end.


