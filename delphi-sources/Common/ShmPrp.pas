unit ShmPrp;

interface

uses
  IcTypes, IcConv, IcVariab, hPRPDEF,
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls,
  Dialogs, DB, NexBtrTable, DBTables, NexPxTable;

type
  TShmPrp=class
    constructor Create(phPRPDEF:TPrpdefHnd);
    procedure OpenPRPDEF;
  private
    ohPRPDEF:TPrpdefHnd;
    // Parametre modulu
    function GetBonVal(pYerNum:Str2):double;  procedure SetBonVal(pYerNum:Str2;pValue:double);
  public
    property BonVal[pYerNum:Str2]:double read GetBonVal write SetBonVal;  // Hodnota obratu s DPH, pri ktorom zákazníkovi je pridelený 1 bonus
  end;

implementation

constructor TShmPrp.Create(phPRPDEF:TPrpdefHnd);
begin
  ohPRPDEF:=phPRPDEF;
end;

procedure TShmPrp.OpenPRPDEF;
begin
  If not ohPRPDEF.Active then ohPRPDEF.Open;;
end;

// ******************************** PRIVATE ************************************

function TShmPrp.GetBonVal(pYerNum:Str2):double;
begin
  OpenPRPDEF;
  Result:=ohPRPDEF.ReadFloat('SHM',pYerNum,'BonVal',0,2);
end;

procedure TShmPrp.SetBonVal(pYerNum:Str2;pValue:double);
begin
  OpenPRPDEF;
  ohPRPDEF.WriteFloat('SHM',pYerNum,'BonVal',pValue,2);
end;

// ********************************* PUBLIC ************************************

end.


