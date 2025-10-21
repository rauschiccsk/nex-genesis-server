unit StmPrp;

interface

uses
  IcTypes, IcConv, IcVariab, hPRPDEF,
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls,
  Dialogs, DB, NexBtrTable, DBTables, NexPxTable;

type
  TStmPrp=class
    constructor Create(phPRPDEF:TPrpdefHnd);
    procedure OpenPRPDEF;
  private
    ohPRPDEF:TPrpdefHnd;
    // Parametre modulu
    function GetMaiStk:word;  procedure SetMaiStk(pValue:word);
    // Parametre skladu
    function GetStcQnt(pStkNum:word):longint;    procedure SetStcQnt(pStkNum:word;pValue:longint);
    function GetStmQnt(pStkNum:word):longint;    procedure SetStmQnt(pStkNum:word;pValue:longint);
    function GetFifQnt(pStkNum:word):longint;    procedure SetFifQnt(pStkNum:word;pValue:longint);
  public
    // Parametre modulu
    property MaiStk:word read GetMaiStk write SetMaiStk;  // Hlavný (predvolený) sklad
    // Parametre skladu
    property StcQnt[pStkNum:word]:longint read GetStcQnt write SetStcQnt;    // Poèet kariet v zadanom sklade
    property StmQnt[pStkNum:word]:longint read GetStmQnt write SetStmQnt;    // Poèet pohybov v zadanom sklade
    property FifQnt[pStkNum:word]:longint read GetFifQnt write SetFifQnt;    // Poèet fifo v zadanom sklade
  end;

implementation

constructor TStmPrp.Create(phPRPDEF:TPrpdefHnd);
begin
  ohPRPDEF:=phPRPDEF;
end;

procedure TStmPrp.OpenPRPDEF;
begin
  If not ohPRPDEF.Active then ohPRPDEF.Open;;
end;

// ******************************** PRIVATE ************************************

function TStmPrp.GetMaiStk:word;
begin
  OpenPRPDEF;
  Result:=ohPRPDEF.ReadInteger('STM','','MaiStk',0);
end;

procedure TStmPrp.SetMaiStk(pValue:word);
begin
  OpenPRPDEF;
  ohPRPDEF.WriteInteger('STM','','MaiStk',pValue);
end;

function TStmPrp.GetStcQnt(pStkNum:word):longint;
begin
  OpenPRPDEF;
  Result:=ohPRPDEF.ReadInteger('STM',StrIntZero(pStkNum,3),'StcQnt',0);
end;

procedure TStmPrp.SetStcQnt(pStkNum:word;pValue:longint);
begin
  OpenPRPDEF;
  ohPRPDEF.WriteInteger('STM',StrIntZero(pStkNum,3),'StcQnt',pValue);
end;

function TStmPrp.GetStmQnt(pStkNum:word):longint;
begin
  OpenPRPDEF;
  Result:=ohPRPDEF.ReadInteger('STM',StrIntZero(pStkNum,3),'StmQnt',0);
end;

procedure TStmPrp.SetStmQnt(pStkNum:word;pValue:longint);
begin
  OpenPRPDEF;
  ohPRPDEF.WriteInteger('STM',StrIntZero(pStkNum,3),'StmQnt',pValue);
end;

function TStmPrp.GetFifQnt(pStkNum:word):longint;
begin
  OpenPRPDEF;
  Result:=ohPRPDEF.ReadInteger('STM',StrIntZero(pStkNum,3),'FifQnt',0);
end;

procedure TStmPrp.SetFifQnt(pStkNum:word;pValue:longint);
begin
  OpenPRPDEF;
  ohPRPDEF.WriteInteger('STM',StrIntZero(pStkNum,3),'FifQnt',pValue);
end;

// ********************************* PUBLIC ************************************

end.


