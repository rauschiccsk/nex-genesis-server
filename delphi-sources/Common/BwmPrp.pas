unit BwmPrp;

interface

uses
  IcTypes, IcConv, IcVariab, hPRPDEF,
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls,
  Dialogs, DB, NexBtrTable, DBTables, NexPxTable;

type
  TBwmPrp=class
    constructor Create(phPRPDEF:TPrpdefHnd);
    procedure OpenPRPDEF;
  private
    ohPRPDEF:TPrpdefHnd;
    // Parametre modulu
    function GetStkNum(pBokNum:Str3):word;  procedure SetStkNum(pBokNum:Str3;pValue:word);
    function GetPlsNum(pBokNum:Str3):word;  procedure SetPlsNum(pBokNum:Str3;pValue:word);
  public
    property StkNum[pBokNum:Str3]:word read GetStkNum write SetStkNum;  // Skald zápožièky
    property PlsNum[pBokNum:Str3]:word read GetPlsNum write SetPlsNum;  // Cenník zápožièky - hodnota náradia
  end;

implementation

constructor TBwmPrp.Create(phPRPDEF:TPrpdefHnd);
begin
  ohPRPDEF:=phPRPDEF;
end;

procedure TBwmPrp.OpenPRPDEF;
begin
  If not ohPRPDEF.Active then ohPRPDEF.Open;;
end;

// ******************************** PRIVATE ************************************

function TBwmPrp.GetStkNum(pBokNum:Str3):word;
begin
  OpenPRPDEF;
  Result:=ohPRPDEF.ReadInteger('BWM',pBokNum,'StkNum',1);
end;

procedure TBwmPrp.SetStkNum(pBokNum:Str3;pValue:word);
begin
  OpenPRPDEF;
  ohPRPDEF.WriteInteger('BWM',pBokNum,'StkNum',pValue);
end;

function TBwmPrp.GetPlsNum(pBokNum:Str3):word;
begin
  OpenPRPDEF;
  Result:=ohPRPDEF.ReadInteger('BWM',pBokNum,'PlsNum',1);
end;

procedure TBwmPrp.SetPlsNum(pBokNum:Str3;pValue:word);
begin
  OpenPRPDEF;
  ohPRPDEF.WriteInteger('BWM',pBokNum,'PlsNum',pValue);
end;

// ********************************* PUBLIC ************************************

end.


