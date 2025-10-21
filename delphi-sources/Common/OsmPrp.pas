unit OsmPrp;

interface

uses
  IcTypes, IcConv, IcVariab, hPRPDEF,
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls,
  Dialogs, DB, NexBtrTable, DBTables, NexPxTable;

type
  TOsmPrp=class
    constructor Create(phPRPDEF:TPrpdefHnd);
    procedure OpenPRPDEF;
  private
    ohPRPDEF:TPrpdefHnd;
    // Parametre modulu
    function GetMaxDly:word;                  procedure SetMaxDly(pValue:word);
    function GetDocAdr(pDocYer:Str2):longint; procedure SetDocAdr(pDocYer:Str2;pValue:longint);
    function GetItmAdr(pDocYer:Str2):longint; procedure SetItmAdr(pDocYer:Str2;pValue:longint);
    // Parametre knihy
    function GetStkNum(pBokNum:Str3):word;    procedure SetStkNum(pBokNum:Str3;pValue:word);
    function GetDocBok(pBokNum:Str3):Str60;   procedure SetDocBok(pBokNum:Str3;pValue:Str60);
    function GetValClc(pBokNum:Str3):Str15;   procedure SetValClc(pBokNum:Str3;pValue:Str15);
    function GetRepNam(pBokNum:Str3):Str8;    procedure SetRepNam(pBokNum:Str3;pValue:Str8);
    function GetRepNum(pBokNum:Str3):byte;    procedure SetRepNum(pBokNum:Str3;pValue:byte);
    function GetPrnCls(pBokNum:Str3):boolean; procedure SetPrnCls(pBokNum:Str3;pValue:boolean);
    function GetPrnDoq(pBokNum:Str3):byte;    procedure SetPrnDoq(pBokNum:Str3;pValue:byte);
  public
    property MaxDly:word read GetMaxDly write SetMaxDly;                  // Maximálna doba meškania dodávky
    // ------------------------------------------- Nastavenia pre vybranú knihy  --------------------------------------------
    property StkNum[pBokNum:Str3]:word read GetStkNum write SetStkNum;    // Predvolený sklad
    property DocBok[pBokNum:Str3]:Str60 read GetDocBok write SetDocBok;   // Názov knihy dodávate¾ských objednávok
    property ValClc[pBokNum:Str3]:Str15 read GetValClc write SetValClc;   // Vzorec na výpoèet finanèných údajov
    property RepNam[pBokNum:Str3]:Str8 read GetRepNam write SetRepNam;    // Názov tlaèovej masky zákazkového dokladu
    property RepNum[pBokNum:Str3]:byte read GetRepNum write SetRepNum;    // Èíslo tlaèovej masky zákazkového dokladu
    property PrnCls[pBokNum:Str3]:boolean read GetPrnCls write SetPrnCls; // Uzatvorenie dokladu po jeho vytlaèení
    property PrnDoq[pBokNum:Str3]:byte read GetPrnDoq write SetPrnDoq;    // Poèet vytlaèených kópii dokladu
  end;

implementation

constructor TOsmPrp.Create(phPRPDEF:TPrpdefHnd);
begin
  ohPRPDEF:=phPRPDEF;
end;

procedure TOsmPrp.OpenPRPDEF;
begin
  If not ohPRPDEF.Active then ohPRPDEF.Open;;
end;

// ******************************** PRIVATE ************************************

function TOsmPrp.GetMaxDly:word;
begin
  OpenPRPDEF;
  Result:=ohPRPDEF.ReadInteger('OSM','','MaxDly',20);
end;

procedure TOsmPrp.SetMaxDly(pValue:word);
begin
  OpenPRPDEF;
  ohPRPDEF.WriteInteger('OSM','','MaxDly',pValue);
end;

function TOsmPrp.GetStkNum(pBokNum:Str3):word;
begin
  OpenPRPDEF;
  Result:=ohPRPDEF.ReadInteger('OSM',pBokNum,'StkNum',0);
end;

procedure TOsmPrp.SetStkNum(pBokNum:Str3;pValue:word);
begin
  OpenPRPDEF;
  ohPRPDEF.WriteInteger('OSM',pBokNum,'StkNum',pValue);
end;

function TOsmPrp.GetDocAdr(pDocYer:Str2):longint;
begin
  OpenPRPDEF;
  Result:=ohPRPDEF.ReadInteger('OSM','Y'+pDocYer,'DocAdr',ValInt(pDocYer)*100000000);
end;

procedure TOsmPrp.SetDocAdr(pDocYer:Str2;pValue:longint);
begin
  OpenPRPDEF;
  ohPRPDEF.WriteInteger('OSM','Y'+pDocYer,'DocAdr',pValue);
end;

function TOsmPrp.GetItmAdr(pDocYer:Str2):longint;
begin
  OpenPRPDEF;
  Result:=ohPRPDEF.ReadInteger('OSM','Y'+pDocYer,'ItmAdr',ValInt(pDocYer)*100000000);
end;

procedure TOsmPrp.SetItmAdr(pDocYer:Str2;pValue:longint);
begin
  OpenPRPDEF;
  ohPRPDEF.WriteInteger('OSM','Y'+pDocYer,'ItmAdr',pValue);
end;

function TOsmPrp.GetDocBok(pBokNum:Str3):Str60;
begin
  OpenPRPDEF;
  Result:=ohPRPDEF.ReadString('OSM',pBokNum,'DocBok','');
end;

procedure TOsmPrp.SetDocBok(pBokNum:Str3;pValue:Str60);
begin
  OpenPRPDEF;
  ohPRPDEF.WriteString('OSM',pBokNum,'DocBok',pValue);
end;

function TOsmPrp.GetValClc(pBokNum:Str3):Str15;
begin
  OpenPRPDEF;
  Result:=ohPRPDEF.ReadString('OSM',pBokNum,'ValClc','ABS5M5M5ME999');
end;

procedure TOsmPrp.SetValClc(pBokNum:Str3;pValue:Str15);
begin
  OpenPRPDEF;
  ohPRPDEF.WriteString('OSM',pBokNum,'ValClc',pValue);
end;

function TOsmPrp.GetRepNam(pBokNum:Str3):Str8;
begin
  OpenPRPDEF;
  Result:=ohPRPDEF.ReadString('OSM',pBokNum,'RepNam','OSDBAS');
end;

procedure TOsmPrp.SetRepNam(pBokNum:Str3;pValue:Str8);
begin
  OpenPRPDEF;
  ohPRPDEF.WriteString('OSM',pBokNum,'RepNam',pValue);
end;

function TOsmPrp.GetRepNum(pBokNum:Str3):byte;
begin
  OpenPRPDEF;
  Result:=ohPRPDEF.ReadInteger('OSM',pBokNum,'RepNum',1);
end;

procedure TOsmPrp.SetRepNum(pBokNum:Str3;pValue:byte);
begin
  OpenPRPDEF;
  ohPRPDEF.WriteInteger('OSM',pBokNum,'RepNum',pValue);
end;

function TOsmPrp.GetPrnCls(pBokNum:Str3):boolean;
begin
  OpenPRPDEF;
  Result:=ohPRPDEF.ReadBoolean('OSM',pBokNum,'PrnCls',FALSE);
end;

procedure TOsmPrp.SetPrnCls(pBokNum:Str3;pValue:boolean);
begin
  OpenPRPDEF;
  ohPRPDEF.WriteBoolean('OSM',pBokNum,'PrnCls',pValue);
end;

function TOsmPrp.GetPrnDoq(pBokNum:Str3):byte;
begin
  OpenPRPDEF;
  Result:=ohPRPDEF.ReadInteger('OSM',pBokNum,'PrnDoq',1);
end;

procedure TOsmPrp.SetPrnDoq(pBokNum:Str3;pValue:byte);
begin
  OpenPRPDEF;
  ohPRPDEF.WriteInteger('OSM',pBokNum,'PrnDoq',pValue);
end;

// ********************************* PUBLIC ************************************

end.


