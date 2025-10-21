unit SrmPrp;
// =============================================================================
//                  PREDVOLEN… NASTAVENIA PRE SKLADOV… PRESUNY
// -----------------------------------------------------------------------------
// ****************************** POPIS PARAMETROV *****************************
// -----------------------------------------------------------------------------
//                          NASTAVENIA PRE VäETKY KNIHY
// ClrWom - farba dokladu a poloûky ak Ëak· na v˝daj zo zdrojovÈho skladu
// ClrWim - farba dokladu a poloûky ak Ëak· na prÌjem do cieæovÈho skladu
// ClrRem - farba dokladu a poloûky ak presun bol kompletne spraven˝
// ClrPou - z danÈho prÌjmu v cieæovom sklade bol uskutoËnen˝ v˝daj
// ClrFou - z danÈho prÌjmu v cieæovom sklade vöetko je vydanÈ
// -----------------------------------------------------------------------------
//                        NASTAVENIA PRE JEDNOTLIV… KNIHY
// PrnCls[BokNum] - Automaticky uzamkn˙ù doklad po jeho vytlaËenÌ
// RemCls[BokNum] - Automaticky uzamkn˙ù doklad po vykonanÌ presunu
// UlcRsn[BokNum] - Povinne zadavaù dovod odblokovania dokladu
// -----------------------------------------------------------------------------
// RepOdn[BokNum] - N·zov tlaËovej masky skladovej v˝dajky (bez rozöÌrenia)
// RepOde[BokNum] - »Ìslo tlaËovej masky skladovej v˝dajky
// RepIdn[BokNum] - N·zov tlaËovej masky skladovej prÌjemky (bez rozöÌrenia)
// RepIde[BokNum] - »Ìslo tlaËovej masky skladovej prÌjemky
// -----------------------------------------------------------------------------
// OutStn[BokNum] - Predvolen˝ sklad pre v˝daj
// OutStl[BokNum] - œaæöie povolenÈ sklady pre v˝daj
// IncStn[BokNum] - Predvolen˝ sklad pre prÌjem
// IncStl[BokNum] - œaæöie povolenÈ sklady pre prÌjem
// -----------------------------------------------------------------------------
// OutSmc[BokNum] - Predvolen˝ pohyb pre v˝daj
// OutSml[BokNum] - œaæöie povolenÈ pohyby pre v˝daj
// IncSmc[BokNum] - Predvolen˝ pohyb pre v˝daj
// IncSml[BokNum] - œaæöie povolenÈ pohyby pre prÌjem
// -----------------------------------------------------------------------------
// ProLst[BokNum] - ak je tento parameter zapnut˝ pri z·d·vanÌ novej poloûky
//                  automaticky bude zobrazen˝ v˝berov˝ zoznam produktov.
// DupVer[BokNum] - ak je tento parameter zapnut˝ pootm systÈm upozornÌ uûÌvateæa
//                  ak na tom istom doklade zad·va ten ist˝ tovar viac kr·t.
// -----------------------------------------------------------------------------
// ********************************* POZN¡MKY **********************************
// -----------------------------------------------------------------------------
//
// -----------------------------------------------------------------------------
// ****************************** HIST”RIA ZMIEN *******************************
// -----------------------------------------------------------------------------
// 20.06[20.02.18] - vytvorenie unitu
// =============================================================================

interface

uses
  IcTypes, IcConv, IcVariab, UsrFnc,
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls,
  Dialogs, DB, NexBtrTable, DBTables, NexPxTable;

type
  TSrmPrp=class
  private
    // ---------------------------- Nastavenia pre vöetky knihy  ------------------------------
    function GetClrWom:integer;   procedure SetClrWom(pValue:integer);
    function GetClrWim:integer;   procedure SetClrWim(pValue:integer);
    function GetClrRem:integer;   procedure SetClrRem(pValue:integer);
    function GetClrPou:integer;   procedure SetClrPou(pValue:integer);
    function GetClrFou:integer;   procedure SetClrFou(pValue:integer);
    // ---------------------------- Nastavenia pre vybran˙ knihy  -----------------------------
    function GetBokNam(pBokNum:Str3):Str50;   procedure SetBokNam(pBokNum:Str3;pValue:Str50);
    // ----------------------------------------------------------------------------------------
    function GetPrnCls(pBokNum:Str3):boolean; procedure SetPrnCls(pBokNum:Str3;pValue:boolean);
    function GetRemCls(pBokNum:Str3):boolean; procedure SetRemCls(pBokNum:Str3;pValue:boolean);
    function GetUlcRsn(pBokNum:Str3):boolean; procedure SetUlcRsn(pBokNum:Str3;pValue:boolean);
    // ----------------------------------------------------------------------------------------
    function GetRepOdn(pBokNum:Str3):Str8;    procedure SetRepOdn(pBokNum:Str3;pValue:Str8);
    function GetRepOde(pBokNum:Str3):Str2;    procedure SetRepOde(pBokNum:Str3;pValue:Str2);
    function GetRepIdn(pBokNum:Str3):Str8;    procedure SetRepIdn(pBokNum:Str3;pValue:Str8);
    function GetRepIde(pBokNum:Str3):Str2;    procedure SetRepIde(pBokNum:Str3;pValue:Str2);
    // ----------------------------------------------------------------------------------------
    function GetOutStn(pBokNum:Str3):word;    procedure SetOutStn(pBokNum:Str3;pValue:word);
    function GetOutStl(pBokNum:Str3):Str250;  procedure SetOutStl(pBokNum:Str3;pValue:Str250);
    function GetIncStn(pBokNum:Str3):word;    procedure SetIncStn(pBokNum:Str3;pValue:word);
    function GetIncStl(pBokNum:Str3):Str250;  procedure SetIncStl(pBokNum:Str3;pValue:Str250);
    // ----------------------------------------------------------------------------------------
    function GetOutSmc(pBokNum:Str3):word;    procedure SetOutSmc(pBokNum:Str3;pValue:word);
    function GetOutSml(pBokNum:Str3):Str250;  procedure SetOutSml(pBokNum:Str3;pValue:Str250);
    function GetIncSmc(pBokNum:Str3):word;    procedure SetIncSmc(pBokNum:Str3;pValue:word);
    function GetIncSml(pBokNum:Str3):Str250;  procedure SetIncSml(pBokNum:Str3;pValue:Str250);
    // ----------------------------------------------------------------------------------------
    function GetProLst(pBokNum:Str3):boolean; procedure SetProLst(pBokNum:Str3;pValue:boolean);
    function GetDupVer(pBokNum:Str3):boolean; procedure SetDupVer(pBokNum:Str3;pValue:boolean);
  public
    // -------------------- Nastavenia pre vöetky knihy  -----------------------
    property ClrWom:integer read GetClrWom write SetClrWom;
    property ClrWim:integer read GetClrWim write SetClrWim;
    property ClrRem:integer read GetClrRem write SetClrRem;
    property ClrPou:integer read GetClrPou write SetClrPou;
    property ClrFou:integer read GetClrFou write SetClrFou;
    // -------------------- Nastavenia pre vybran˙ knihy  ----------------------
    property BokNam[pBokNum:Str3]:Str50 read GetBokNam write SetBokNam;
    // -------------------------------------------------------------------------
    property PrnCls[pBokNum:Str3]:boolean read GetPrnCls write SetPrnCls;
    property RemCls[pBokNum:Str3]:boolean read GetRemCls write SetRemCls;
    property UlcRsn[pBokNum:Str3]:boolean read GetUlcRsn write SetUlcRsn;
    // -------------------------------------------------------------------------
    property RepOdn[pBokNum:Str3]:Str8 read GetRepOdn write SetRepOdn;
    property RepOde[pBokNum:Str3]:Str2 read GetRepOde write SetRepOde;
    property RepIdn[pBokNum:Str3]:Str8 read GetRepIdn write SetRepIdn;
    property RepIde[pBokNum:Str3]:Str2 read GetRepIde write SetRepIde;
    // -------------------------------------------------------------------------
    property OutStn[pBokNum:Str3]:word read GetOutStn write SetOutStn;
    property OutStl[pBokNum:Str3]:Str250 read GetOutStl write SetOutStl;
    property IncStn[pBokNum:Str3]:word read GetIncStn write SetIncStn;
    property IncStl[pBokNum:Str3]:Str250 read GetIncStl write SetIncStl;
    // -------------------------------------------------------------------------
    property OutSmc[pBokNum:Str3]:word read GetOutSmc write SetOutSmc;
    property OutSml[pBokNum:Str3]:Str250 read GetOutSml write SetOutSml;
    property IncSmc[pBokNum:Str3]:word read GetIncSmc write SetIncSmc;
    property IncSml[pBokNum:Str3]:Str250 read GetIncSml write SetIncSml;
    // -------------------------------------------------------------------------
    property ProLst[pBokNum:Str3]:boolean read GetProLst write SetProLst;
    property DupVer[pBokNum:Str3]:boolean read GetDupVer write SetDupVer;
  end;

implementation

// ******************************** PRIVATE ************************************

function TSrmPrp.GetClrWom:integer;
begin
  Result:=gUsr.ohPRPLST.ReadInteger('SRM','','ClrWom',TColor(clRed));
end;

procedure TSrmPrp.SetClrWom(pValue:integer);
begin
  gUsr.ohPRPLST.WriteInteger('SRM','','ClrWom',pValue);
end;

function TSrmPrp.GetClrWim:integer;
begin
  Result:=gUsr.ohPRPLST.ReadInteger('SRM','','ClrWim',TColor(clBlue));
end;

procedure TSrmPrp.SetClrWim(pValue:integer);
begin
  gUsr.ohPRPLST.WriteInteger('SRM','','ClrWim',pValue);
end;

function TSrmPrp.GetClrRem:integer;
begin
  Result:=gUsr.ohPRPLST.ReadInteger('SRM','','ClrRem',TColor(clBlack));
end;

procedure TSrmPrp.SetClrRem(pValue:integer);
begin
  gUsr.ohPRPLST.WriteInteger('SRM','','ClrRem',pValue);
end;

function TSrmPrp.GetClrPou:integer;
begin
  Result:=gUsr.ohPRPLST.ReadInteger('SRM','','ClrPou',TColor(clMaroon));
end;

procedure TSrmPrp.SetClrPou(pValue:integer);
begin
  gUsr.ohPRPLST.WriteInteger('SRM','','ClrPou',pValue);
end;

function TSrmPrp.GetClrFou:integer;
begin
  Result:=gUsr.ohPRPLST.ReadInteger('SRM','','ClrFou',TColor(clGray));
end;

procedure TSrmPrp.SetClrFou(pValue:integer);
begin
  gUsr.ohPRPLST.WriteInteger('SRM','','ClrFou',pValue);
end;

function TSrmPrp.GetBokNam(pBokNum:Str3):Str50;
begin
  Result:='';
  If gUsr.ohBOKLST.LocPmBn('SRM',pBokNum) then Result:=gUsr.ohBOKLST.BokNam;
end;

procedure TSrmPrp.SetBokNam(pBokNum:Str3;pValue:Str50);
begin
  With gUsr do begin
    If ohBOKLST.LocPmBn('SRM',pBokNum) then begin
      If ohBOKLST.BokNam<>pValue then begin
        ohBOKLST.Edit;
        ohBOKLST.BokNam:=pValue;
        ohBOKLST.Post;
      end;
    end else begin
      ohBOKLST.Insert;
      ohBOKLST.PmdCod:='SRM';
      ohBOKLST.BokNum:=pBokNum;
      ohBOKLST.BokNam:=pValue;
      ohBOKLST.CrtUsr:=gUsr.UsrLog;
      ohBOKLST.CrtUsn:=gUsr.UsrNam;
      ohBOKLST.CrtDte:=Date;
      ohBOKLST.CrtTim:=Time;
      ohBOKLST.Post;
    end;
  end;
end;

function TSrmPrp.GetPrnCls(pBokNum:Str3):boolean;
begin
  Result:=gUsr.ohPRPLST.ReadBoolean('SRM',pBokNum,'PrnCls',FALSE);
end;

procedure TSrmPrp.SetPrnCls(pBokNum:Str3;pValue:boolean);
begin
  gUsr.ohPRPLST.WriteBoolean('SRM',pBokNum,'PrnCls',pValue);
end;

function TSrmPrp.GetRemCls(pBokNum:Str3):boolean;
begin
  Result:=gUsr.ohPRPLST.ReadBoolean('SRM',pBokNum,'RemCls',FALSE);
end;

procedure TSrmPrp.SetRemCls(pBokNum:Str3;pValue:boolean);
begin
  gUsr.ohPRPLST.WriteBoolean('SRM',pBokNum,'RemCls',pValue);
end;

function TSrmPrp.GetUlcRsn(pBokNum:Str3):boolean;
begin
  Result:=gUsr.ohPRPLST.ReadBoolean('SRM',pBokNum,'UlcRsn',FALSE);
end;

procedure TSrmPrp.SetUlcRsn(pBokNum:Str3;pValue:boolean);
begin
  gUsr.ohPRPLST.WriteBoolean('SRM',pBokNum,'UlcRsn',pValue);
end;

function TSrmPrp.GetRepOdn(pBokNum:Str3):Str8;
begin
  Result:=gUsr.ohPRPLST.ReadString('SRM',pBokNum,'RepOdn','SRDOUT');
end;

procedure TSrmPrp.SetRepOdn(pBokNum:Str3;pValue:Str8);
begin
  gUsr.ohPRPLST.WriteString('SRM',pBokNum,'RepOdn',pValue);
end;

function TSrmPrp.GetRepOde(pBokNum:Str3):Str2;
begin
  Result:=gUsr.ohPRPLST.ReadString('SRM',pBokNum,'RepOde','01');
end;

procedure TSrmPrp.SetRepOde(pBokNum:Str3;pValue:Str2);
begin
  gUsr.ohPRPLST.WriteString('SRM',pBokNum,'RepOde',pValue);
end;

function TSrmPrp.GetRepIdn(pBokNum:Str3):Str8;
begin
  Result:=gUsr.ohPRPLST.ReadString('SRM',pBokNum,'RepIdn','SRDINC');
end;

procedure TSrmPrp.SetRepIdn(pBokNum:Str3;pValue:Str8);
begin
  gUsr.ohPRPLST.WriteString('SRM',pBokNum,'RepIdn',pValue);
end;

function TSrmPrp.GetRepIde(pBokNum:Str3):Str2;
begin
  Result:=gUsr.ohPRPLST.ReadString('SRM',pBokNum,'RepIde','01');
end;

procedure TSrmPrp.SetRepIde(pBokNum:Str3;pValue:Str2);
begin
  gUsr.ohPRPLST.WriteString('SRM',pBokNum,'RepIde',pValue);
end;

function TSrmPrp.GetOutStn(pBokNum:Str3):word;
begin
  Result:=gUsr.ohPRPLST.ReadInteger('SRM',pBokNum,'OutStn',0);
end;

procedure TSrmPrp.SetOutStn(pBokNum:Str3;pValue:word);
begin
  gUsr.ohPRPLST.WriteInteger('SRM',pBokNum,'OutStn',pValue);
end;

function TSrmPrp.GetOutStl(pBokNum:Str3):Str250;
begin
  Result:=gUsr.ohPRPLST.ReadString('SRM',pBokNum,'OutStl','');
end;

procedure TSrmPrp.SetOutStl(pBokNum:Str3;pValue:Str250);
begin
  gUsr.ohPRPLST.WriteString('SRM',pBokNum,'OutStl',pValue);
end;

function TSrmPrp.GetIncStn(pBokNum:Str3):word;
begin
  Result:=gUsr.ohPRPLST.ReadInteger('SRM',pBokNum,'IncStn',0);
end;

procedure TSrmPrp.SetIncStn(pBokNum:Str3;pValue:word);
begin
  gUsr.ohPRPLST.WriteInteger('SRM',pBokNum,'IncStn',pValue);
end;

function TSrmPrp.GetIncStl(pBokNum:Str3):Str250;
begin
  Result:=gUsr.ohPRPLST.ReadString('SRM',pBokNum,'IncStl','');
end;

procedure TSrmPrp.SetIncStl(pBokNum:Str3;pValue:Str250);
begin
  gUsr.ohPRPLST.WriteString('SRM',pBokNum,'IncStl',pValue);
end;

function TSrmPrp.GetOutSmc(pBokNum:Str3):word;
begin
  Result:=gUsr.ohPRPLST.ReadInteger('SRM',pBokNum,'OutSmc',12);
end;

procedure TSrmPrp.SetOutSmc(pBokNum:Str3;pValue:word);
begin
  gUsr.ohPRPLST.WriteInteger('SRM',pBokNum,'OutSmc',pValue);
end;

function TSrmPrp.GetOutSml(pBokNum:Str3):Str250;
begin
  Result:=gUsr.ohPRPLST.ReadString('SRM',pBokNum,'OutSml','');
end;

procedure TSrmPrp.SetOutSml(pBokNum:Str3;pValue:Str250);
begin
  gUsr.ohPRPLST.WriteString('SRM',pBokNum,'OutSml',pValue);
end;

function TSrmPrp.GetIncSmc(pBokNum:Str3):word;
begin
  Result:=gUsr.ohPRPLST.ReadInteger('SRM',pBokNum,'IncSmc',22);
end;

procedure TSrmPrp.SetIncSmc(pBokNum:Str3;pValue:word);
begin
  gUsr.ohPRPLST.WriteInteger('SRM',pBokNum,'IncSmc',pValue);
end;

function TSrmPrp.GetIncSml(pBokNum:Str3):Str250;
begin
  Result:=gUsr.ohPRPLST.ReadString('SRM',pBokNum,'IncSml','');
end;

procedure TSrmPrp.SetIncSml(pBokNum:Str3;pValue:Str250);
begin
  gUsr.ohPRPLST.WriteString('SRM',pBokNum,'IncSml',pValue);
end;

function TSrmPrp.GetProLst(pBokNum:Str3):boolean;
begin
  Result:=gUsr.ohPRPLST.ReadBoolean('SRM',pBokNum,'ProLst',FALSE);
end;

procedure TSrmPrp.SetProLst(pBokNum:Str3;pValue:boolean);
begin
  gUsr.ohPRPLST.WriteBoolean('SRM',pBokNum,'ProLst',pValue);
end;

function TSrmPrp.GetDupVer(pBokNum:Str3):boolean;
begin
  Result:=gUsr.ohPRPLST.ReadBoolean('SRM',pBokNum,'DupVer',FALSE);
end;

procedure TSrmPrp.SetDupVer(pBokNum:Str3;pValue:boolean);
begin
  gUsr.ohPRPLST.WriteBoolean('SRM',pBokNum,'DupVer',pValue);
end;

// ********************************* PUBLIC ************************************

end.


