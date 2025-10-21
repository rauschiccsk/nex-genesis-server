unit IcmPrp;

interface

uses
  IcTypes, IcConv, IcVariab, hPRPDEF,
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls,
  Dialogs, DB, NexBtrTable, DBTables, NexPxTable;

type
  TIcmPrp=class
    constructor Create(phPRPDEF:TPrpdefHnd);
    procedure OpenPRPDEF;
  private
    ohPRPDEF:TPrpdefHnd;
    // ---------------------------- Nastavenia pre všetky knihy  ------------------------------
    // ---------------------------- Nastavenia pre vybranú knihy  -----------------------------
    function GetTcbEna(pBokNum:Str3):Str250;   procedure SetTcbEna(pBokNum:Str3;pValue:Str250);
  public
    // ------------------------------------------- Nastavenia pre všetky knihy  --------------------------------------------
    // ------------------------------------------- Nastavenia pre vybranú knihy  --------------------------------------------
    property TcbEna[pBokNum:Str3]:Str250 read GetTcbEna write SetTcbEna;   // Povolené knihy dodacích listov
  end;

implementation

constructor TIcmPrp.Create(phPRPDEF:TPrpdefHnd);
begin
  ohPRPDEF:=phPRPDEF;
end;

procedure TIcmPrp.OpenPRPDEF;
begin
  If not ohPRPDEF.Active then ohPRPDEF.Open;;
end;

// ******************************** PRIVATE ************************************

function TIcmPrp.GetTcbEna(pBokNum:Str3):Str250;
begin
  OpenPRPDEF;
  Result:=ohPRPDEF.ReadString('ICM',pBokNum,'TcbEna','');
end;

procedure TIcmPrp.SetTcbEna(pBokNum:Str3;pValue:Str250);
begin
  OpenPRPDEF;
  ohPRPDEF.WriteString('ICM',pBokNum,'TcbEna',pValue);
end;

// ********************************* PUBLIC ************************************

end.


