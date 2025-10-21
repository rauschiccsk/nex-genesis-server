unit UdmPrp;

interface

uses
  IcTypes, IcConv, IcVariab, hPRPDEF,
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls,
  Dialogs, DB, NexBtrTable, DBTables, NexPxTable;

type
  TUdmPrp=class
    constructor Create(phPRPDEF:TPrpdefHnd);
    procedure OpenPRPDEF;
  private
    ohPRPDEF:TPrpdefHnd;
    // ---------------------------- Nastavenia pre vöetky knihy  ------------------------------
    function GetClrMin:integer;   procedure SetClrMin(pValue:integer);
    function GetClrOpt:integer;   procedure SetClrOpt(pValue:integer);
    function GetClrMax:integer;   procedure SetClrMax(pValue:integer);
    function GetClrNul:integer;   procedure SetClrNul(pValue:integer);
    function GetClrDis:integer;   procedure SetClrDis(pValue:integer);
    // ---------------------------- Nastavenia pre vybran˙ knihy  -----------------------------
    function GetOcbNum(pStkNum:word):Str3;    procedure SetOcbNum(pStkNum:word;pValue:Str3);
    function GetOcbSlc(pStkNum:word):Str250;  procedure SetOcbSlc(pStkNum:word;pValue:Str250);
    function GetMorStk(pStkNum:word):boolean; procedure SetMorStk(pStkNum:word;pValue:boolean);
  public
    // ------------------------------------------- Nastavenia pre vöetky knihy  --------------------------------------------
    property ClrMin:integer read GetClrMin write SetClrMin;   // PodnormatÌvna z·soba
    property ClrOpt:integer read GetClrOpt write SetClrOpt;   // Optim·lna z·soba
    property ClrMax:integer read GetClrMax write SetClrMax;   // NadnormatÌvna z·soba
    property ClrNul:integer read GetClrNul write SetClrNul;   // Nulov· z·soba na predaj
    property ClrDis:integer read GetClrDis write SetClrDis;   // Vyraden˝ tovar z evidencie
    // ------------------------------------------- Nastavenia pre vybran˙ knihy  --------------------------------------------
    property OcbNum[pStkNum:word]:Str3 read GetOcbNum write SetOcbNum;    // »Ìslo predvolenej knihy z·kazkov˝ch dokladov
    property OcbSlc[pStkNum:word]:Str250 read GetOcbSlc write SetOcbSlc;  // œaæöie povolenÈ knihy z·kazkov˝ch dokladov
    property MorStk[pStkNum:word]:boolean read GetMorStk write SetMorStk; // Povoliù na jednom doklade vyd·vaù z viacer˝ch skladov
  end;

implementation

constructor TUdmPrp.Create(phPRPDEF:TPrpdefHnd);
begin
  ohPRPDEF:=phPRPDEF;
end;

procedure TUdmPrp.OpenPRPDEF;
begin
  If not ohPRPDEF.Active then ohPRPDEF.Open;;
end;

// ******************************** PRIVATE ************************************

function TUdmPrp.GetClrMin:integer;
begin
  OpenPRPDEF;
  Result:=ohPRPDEF.ReadInteger('UDM','','ClrMin',TColor(clRed));
end;

procedure TUdmPrp.SetClrMin(pValue:integer);
begin
  OpenPRPDEF;
  ohPRPDEF.WriteInteger('UDM','','ClrMin',pValue);
end;

function TUdmPrp.GetClrOpt:integer;
begin
  OpenPRPDEF;
  Result:=ohPRPDEF.ReadInteger('UDM','','ClrOpt',TColor(clBlack));
end;

procedure TUdmPrp.SetClrOpt(pValue:integer);
begin
  OpenPRPDEF;
  ohPRPDEF.WriteInteger('UDM','','ClrOpt',pValue);
end;

function TUdmPrp.GetClrMax:integer;
begin
  OpenPRPDEF;
  Result:=ohPRPDEF.ReadInteger('UDM','','ClrMax',TColor(clBlue));
end;

procedure TUdmPrp.SetClrMax(pValue:integer);
begin
  OpenPRPDEF;
  ohPRPDEF.WriteInteger('UDM','','ClrMax',pValue);
end;

function TUdmPrp.GetClrNul:integer;
begin
  OpenPRPDEF;
  Result:=ohPRPDEF.ReadInteger('UDM','','ClrNul',TColor(clGreen));
end;

procedure TUdmPrp.SetClrNul(pValue:integer);
begin
  OpenPRPDEF;
  ohPRPDEF.WriteInteger('UDM','','ClrNul',pValue);
end;

function TUdmPrp.GetClrDis:integer;
begin
  OpenPRPDEF;
  Result:=ohPRPDEF.ReadInteger('UDM','','ClrDis',TColor(clGray));
end;

procedure TUdmPrp.SetClrDis(pValue:integer);
begin
  OpenPRPDEF;
  ohPRPDEF.WriteInteger('UDM','','ClrDis',pValue);
end;

function TUdmPrp.GetOcbNum(pStkNum:word):Str3;
begin
  OpenPRPDEF;
  Result:=ohPRPDEF.ReadString('UDM',StrIntZero(pStkNum,3),'OcbNum','001');
end;

procedure TUdmPrp.SetOcbNum(pStkNum:word;pValue:Str3);
begin
  OpenPRPDEF;
  ohPRPDEF.WriteString('UDM',StrIntZero(pStkNum,3),'OcbNum',pValue);
end;

function TUdmPrp.GetOcbSlc(pStkNum:word):Str250;
begin
  OpenPRPDEF;
  Result:=ohPRPDEF.ReadString('UDM',StrIntZero(pStkNum,3),'OcbSlc','');
end;

procedure TUdmPrp.SetOcbSlc(pStkNum:word;pValue:Str250);
begin
  OpenPRPDEF;
  ohPRPDEF.WriteString('UDM',StrIntZero(pStkNum,3),'OcbSlc',pValue);
end;

function TUdmPrp.GetMorStk(pStkNum:word):boolean;
begin
  OpenPRPDEF;
  Result:=ohPRPDEF.ReadBoolean('UDM',StrIntZero(pStkNum,3),'MorStk',FALSE);
end;

procedure TUdmPrp.SetMorStk(pStkNum:word;pValue:boolean);
begin
  OpenPRPDEF;
  ohPRPDEF.WriteBoolean('UDM',StrIntZero(pStkNum,3),'MorStk',pValue);
end;

// ********************************* PUBLIC ************************************

end.


