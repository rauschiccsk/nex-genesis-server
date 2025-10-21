unit OcmPrp;

interface

uses
  IcTypes, IcConv, IcVariab, hPRPDEF,
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls,
  Dialogs, DB, NexBtrTable, DBTables, NexPxTable;

type
  TOcmPrp=class
    constructor Create(phPRPDEF:TPrpdefHnd);
    procedure OpenPRPDEF;
  private
    ohPRPDEF:TPrpdefHnd;
    // ---------------------------- Nastavenia pre v�etky knihy  ------------------------------
    function GetClrReq:integer;   procedure SetClrReq(pValue:integer);
    function GetClrRst:integer;   procedure SetClrRst(pValue:integer);
    function GetClrRos:integer;   procedure SetClrRos(pValue:integer);
    function GetClrExd:integer;   procedure SetClrExd(pValue:integer);
    function GetClrTsd:integer;   procedure SetClrTsd(pValue:integer);
    function GetClrCls:integer;   procedure SetClrCls(pValue:integer);
    function GetResTyp:byte;      procedure SetResTyp(pValue:byte);
    // ---------------------------- Nastavenia pre vybran� knihy  -----------------------------
    function GetBokNam(pBokNum:Str3):Str60;   procedure SetBokNam(pBokNum:Str3;pValue:Str60);
    function GetDvzNam(pBokNum:Str3):Str3;    procedure SetDvzNam(pBokNum:Str3;pValue:Str3);
    function GetExnFrm(pBokNum:Str3):Str12;   procedure SetExnFrm(pBokNum:Str3;pValue:Str12);
    function GetExpDay(pBokNum:Str3):integer; procedure SetExpDay(pBokNum:Str3;pValue:integer);
    function GetRepNam(pBokNum:Str3):Str8;    procedure SetRepNam(pBokNum:Str3;pValue:Str8);
    function GetRepNum(pBokNum:Str3):byte;    procedure SetRepNum(pBokNum:Str3;pValue:byte);
    function GetPrnCls(pBokNum:Str3):boolean; procedure SetPrnCls(pBokNum:Str3;pValue:boolean);
    function GetPrnDoq(pBokNum:Str3):byte;    procedure SetPrnDoq(pBokNum:Str3;pValue:byte);
    function GetUlcRsn(pBokNum:Str3):boolean; procedure SetUlcRsn(pBokNum:Str3;pValue:boolean);
    function GetItdRsn(pBokNum:Str3):boolean; procedure SetItdRsn(pBokNum:Str3;pValue:boolean);
    // ----------------------------------------------------------------------------------------
    function GetStkNum(pBokNum:Str3):word;    procedure SetStkNum(pBokNum:Str3;pValue:word);
    function GetStkSlc(pBokNum:Str3):Str250;  procedure SetStkSlc(pBokNum:Str3;pValue:Str250);
    function GetMorStk(pBokNum:Str3):boolean; procedure SetMorStk(pBokNum:Str3;pValue:boolean);
    // ----------------------------------------------------------------------------------------
    function GetActCas(pBokNum:Str3):boolean; procedure SetActCas(pBokNum:Str3;pValue:boolean);
    function GetCasNum(pBokNum:Str3):word;    procedure SetCasNum(pBokNum:Str3;pValue:word);
    function GetCasSlc(pBokNum:Str3):Str250;  procedure SetCasSlc(pBokNum:Str3;pValue:Str250);
    function GetDepInc(pBokNum:Str3):boolean; procedure SetDepInc(pBokNum:Str3;pValue:boolean);
    function GetTcbTed(pBokNum:Str3):Str5;    procedure SetTcbTed(pBokNum:Str3;pValue:Str5);
    function GetTcbExd(pBokNum:Str3):Str5;    procedure SetTcbExd(pBokNum:Str3;pValue:Str5);
    function GetTcbOtd(pBokNum:Str3):Str5;    procedure SetTcbOtd(pBokNum:Str3;pValue:Str5);
    // ----------------------------------------------------------------------------------------
    function GetItmEdi(pBokNum:Str3):byte;    procedure SetItmEdi(pBokNum:Str3;pValue:byte);
    function GetProLst(pBokNum:Str3):boolean; procedure SetProLst(pBokNum:Str3;pValue:boolean);
    function GetScmDis(pBokNum:Str3):boolean; procedure SetScmDis(pBokNum:Str3;pValue:boolean);
    function GetTrsBva(pBokNum:Str3):boolean; procedure SetTrsBva(pBokNum:Str3;pValue:boolean);
    function GetDupVer(pBokNum:Str3):boolean; procedure SetDupVer(pBokNum:Str3;pValue:boolean);
    function GetRetSal(pBokNum:Str3):boolean; procedure SetRetSal(pBokNum:Str3;pValue:boolean);
    function GetAyeCnc(pBokNum:Str3):boolean; procedure SetAyeCnc(pBokNum:Str3;pValue:boolean);
    // ----------------------------------------------------------------------------------------
    function GetActSnd(pBokNum:Str3):boolean; procedure SetActSnd(pBokNum:Str3;pValue:boolean);
    function GetFixSnd(pBokNum:Str3):boolean; procedure SetFixSnd(pBokNum:Str3;pValue:boolean);
    function GetSndNam(pBokNum:Str3):Str30;   procedure SetSndNam(pBokNum:Str3;pValue:Str30);
    function GetSndEml(pBokNum:Str3):Str30;   procedure SetSndEml(pBokNum:Str3;pValue:Str30);
    // ----------------------------------------------------------------------------------------
    function GetValClc(pBokNum:Str3):Str15;   procedure SetValClc(pBokNum:Str3;pValue:Str15);


    function GetNotRes(pBokNum:Str3):boolean; procedure SetNotRes(pBokNum:Str3;pValue:boolean);
  public
    // ------------------------------------------- Nastavenia pre v�etky knihy  --------------------------------------------
    property ClrReq:integer read GetClrReq write SetClrReq;   // Po�iadavka na objednanie
    property ClrRst:integer read GetClrRst write SetClrRst;   // Rezervovan� zo z�soby
    property ClrRos:integer read GetClrRos write SetClrRos;   // Rezervovan� z objedn�vky
    property ClrExd:integer read GetClrExd write SetClrExd;   // Prebieha expedi�n� pr�prava
    property ClrTsd:integer read GetClrTsd write SetClrTsd;   // Tovar je dodan� z�kazn�kovi
    property ClrCls:integer read GetClrCls write SetClrCls;   // Ukon�en� obchodn� pr�pad
    property ResTyp:byte read GetResTyp write SetResTyp;      // Ako rezervova� - syst�m rezerva�n�ho procesu
    // ------------------------------------------- Nastavenia pre vybran� knihy  --------------------------------------------
    property BokNam[pBokNum:Str3]:Str60 read GetBokNam write SetBokNam;   // N�zov knihy z�kazkov�ch dokladov
    property DvzNam[pBokNum:Str3]:Str3 read GetDvzNam write SetDvzNam;    // Vy��tovacia mena danej knihy
    property ExnFrm[pBokNum:Str3]:Str12 read GetExnFrm write SetExnFrm;   // Form�t generovania extern�ho ��sla
    property ExpDay[pBokNum:Str3]:integer read GetExpDay write SetExpDay; // Po�et dn� expir�cie rezerv�cie
    property RepNam[pBokNum:Str3]:Str8 read GetRepNam write SetRepNam;    // N�zov tla�ovej masky z�kazkov�ho dokladu
    property RepNum[pBokNum:Str3]:byte read GetRepNum write SetRepNum;    // ��slo tla�ovej masky z�kazkov�ho dokladu
    property PrnCls[pBokNum:Str3]:boolean read GetPrnCls write SetPrnCls; // Uzatvorenie dokladu po jeho vytla�en�
    property PrnDoq[pBokNum:Str3]:byte read GetPrnDoq write SetPrnDoq;    // Po�et vytla�en�ch k�pii dokladu
    property UlcRsn[pBokNum:Str3]:boolean read GetUlcRsn write SetUlcRsn; // Povinne zadava� dovod odblokovania zakazky
    property ItdRsn[pBokNum:Str3]:boolean read GetItdRsn write SetItdRsn; // Povinne zadava� dovod stronovania polozky
    // ----------------------------------------------------------------------------------------------------------------------
    property StkNum[pBokNum:Str3]:word read GetStkNum write SetStkNum;    // Predvolen� sklad
    property StkSlc[pBokNum:Str3]:Str250 read GetStkSlc write SetStkSlc;  // �a��ie povolen� sklady
    property MorStk[pBokNum:Str3]:boolean read GetMorStk write SetMorStk; // Povoli� na jednom doklade vyd�va� z viacer�ch skladov
    // ----------------------------------------------------------------------------------------------------------------------
    property ActCas[pBokNum:Str3]:boolean read GetActCas write SetActCas; // Aktivova� funkciu vy��tovanie z�kazky cez ERP
    property CasNum[pBokNum:Str3]:word read GetCasNum write SetCasNum;    // ��slo ERP na hotovostn� vy�ctovanie z�kazky
    property CasSlc[pBokNum:Str3]:Str250 read GetCasSlc write SetCasSlc;  // �a��ie povolen� pokladne
    property DepInc[pBokNum:Str3]:boolean read GetDepInc write SetDepInc; // Povoli� prija� z�lohov� platbu platbu cez ERP
    property TcbTed[pBokNum:Str3]:Str5 read GetTcbTed write SetTcbTed;    // Z�po�i�n� doklady - do�asn� dodacie listy
    property TcbExd[pBokNum:Str3]:Str5 read GetTcbExd write SetTcbExd;    // Expedi�n� doklady
    property TcbOtd[pBokNum:Str3]:Str5 read GetTcbOtd write SetTcbOtd;    // Be�n� dodacie listy
    // ----------------------------------------------------------------------------------------------------------------------
    property ItmEdi[pBokNum:Str3]:byte read GetItmEdi write SetItmEdi;    // ��slo frmulara editora polziek dokladu
    property ProLst[pBokNum:Str3]:boolean read GetProLst write SetProLst; // Automaticky zobrazi� v�berov� zoznam produktov pri zad�van� novej polo�ky
    property ScmDis[pBokNum:Str3]:boolean read GetScmDis write SetScmDis; // Zak�za� pou�itie ocbhodn�ch podmienok t.j. pred�va� za cenn�kov� ceny
    property TrsBva[pBokNum:Str3]:boolean read GetTrsBva write SetTrsBva; // Povoli� zad�vanie dopravn�ch n�kladov pre jednotliv� polo�ky z�kazky
    property DupVer[pBokNum:Str3]:boolean read GetDupVer write SetDupVer; // Hl�si� duplicitu ak bude pridan� polo�ka, ktor� u� existuje na danom doklade
    property RetSal[pBokNum:Str3]:boolean read GetRetSal write SetRetSal; // Maloobchodn� predaj - prioritne sa pracuje s cenami s DPH
    property AyeCnc[pBokNum:Str3]:boolean read GetAyeCnc write SetAyeCnc; // V�dy stornova� polo�ky z�kazky t.j. nikdy nevymaza� polo�ky z dokladu
    // ----------------------------------------------------------------------------------------------------------------------
    property ActSnd[pBokNum:Str3]:boolean read GetActSnd write SetActSnd; // Aktivova� funkciu automatick�ho informovania z�kazn�kov prostredn�ctvom elektronickej po�ty
    property FixSnd[pBokNum:Str3]:boolean read GetFixSnd write SetFixSnd; // Pevne nastaven� odosielate�
    property SndNam[pBokNum:Str3]:Str30 read GetSndNam write SetSndNam;   // Meno odosielate�a
    property SndEml[pBokNum:Str3]:Str30 read GetSndEml write SetSndEml;   // Emailov� adresa odosielate�a
    // ----------------------------------------------------------------------------------------------------------------------
    property ValClc[pBokNum:Str3]:Str15 read GetValClc write SetValClc;   // Kalkula�n� predpis
(*
    property NotRes[pBokNum:Str3]:boolean read GetNotRes write SetNotRes; //
*)
  end;

implementation

constructor TOcmPrp.Create(phPRPDEF:TPrpdefHnd);
begin
  ohPRPDEF:=phPRPDEF;
end;

procedure TOcmPrp.OpenPRPDEF;
begin
  If not ohPRPDEF.Active then ohPRPDEF.Open;;
end;

// ******************************** PRIVATE ************************************

function TOcmPrp.GetClrReq:integer;
begin
  OpenPRPDEF;
  Result:=ohPRPDEF.ReadInteger('OCM','','ClrReq',TColor(clRed));
end;

procedure TOcmPrp.SetClrReq(pValue:integer);
begin
  OpenPRPDEF;
  ohPRPDEF.WriteInteger('OCM','','ClrReq',pValue);
end;

function TOcmPrp.GetClrRst:integer;
begin
  OpenPRPDEF;
  Result:=ohPRPDEF.ReadInteger('OCM','','ClrRst',TColor(clBlack));
end;

procedure TOcmPrp.SetClrRst(pValue:integer);
begin
  OpenPRPDEF;
  ohPRPDEF.WriteInteger('OCM','','ClrRst',pValue);
end;

function TOcmPrp.GetClrRos:integer;
begin
  OpenPRPDEF;
  Result:=ohPRPDEF.ReadInteger('OCM','','ClrRos',TColor(clBlue));
end;

procedure TOcmPrp.SetClrRos(pValue:integer);
begin
  OpenPRPDEF;
  ohPRPDEF.WriteInteger('OCM','','ClrRos',pValue);
end;

function TOcmPrp.GetClrExd:integer;
begin
  OpenPRPDEF;
  Result:=ohPRPDEF.ReadInteger('OCM','','ClrExd',TColor(clMaroon));
end;

procedure TOcmPrp.SetClrExd(pValue:integer);
begin
  OpenPRPDEF;
  ohPRPDEF.WriteInteger('OCM','','ClrExd',pValue);
end;

function TOcmPrp.GetClrTsd:integer;
begin
  OpenPRPDEF;
  Result:=ohPRPDEF.ReadInteger('OCM','','ClrTsd',TColor(clGreen));
end;

procedure TOcmPrp.SetClrTsd(pValue:integer);
begin
  OpenPRPDEF;
  ohPRPDEF.WriteInteger('OCM','','ClrTsd',pValue);
end;

function TOcmPrp.GetClrCls:integer;
begin
  OpenPRPDEF;
  Result:=ohPRPDEF.ReadInteger('OCM','','ClrCls',TColor(clGray));
end;

procedure TOcmPrp.SetClrCls(pValue:integer);
begin
  OpenPRPDEF;
  ohPRPDEF.WriteInteger('OCM','','ClrCls',pValue);
end;

function TOcmPrp.GetResTyp:byte;
begin
  OpenPRPDEF;
  Result:=ohPRPDEF.ReadInteger('OCM','','ResTyp',3);
end;

procedure TOcmPrp.SetResTyp(pValue:byte);
begin
  OpenPRPDEF;
  ohPRPDEF.WriteInteger('OCM','','ResTyp',pValue);
end;

function TOcmPrp.GetBokNam(pBokNum:Str3):Str60;
begin
  OpenPRPDEF;
  Result:=ohPRPDEF.ReadString('OCM',pBokNum,'BokNam','');
end;

procedure TOcmPrp.SetBokNam(pBokNum:Str3;pValue:Str60);
begin
  OpenPRPDEF;
  ohPRPDEF.WriteString('OCM',pBokNum,'BokNam',pValue);
end;

function TOcmPrp.GetStkNum(pBokNum:Str3):word;
begin
  OpenPRPDEF;
  Result:=ohPRPDEF.ReadInteger('OCM',pBokNum,'StkNum',0);
end;

procedure TOcmPrp.SetStkNum(pBokNum:Str3;pValue:word);
begin
  OpenPRPDEF;
  ohPRPDEF.WriteInteger('OCM',pBokNum,'StkNum',pValue);
end;

function TOcmPrp.GetStkSlc(pBokNum:Str3):Str250;
begin
  OpenPRPDEF;
  Result:=ohPRPDEF.ReadString('OCM',pBokNum,'StkSlc','');
end;

procedure TOcmPrp.SetStkSlc(pBokNum:Str3;pValue:Str250);
begin
  OpenPRPDEF;
  ohPRPDEF.WriteString('OCM',pBokNum,'StkSlc',pValue);
end;

function TOcmPrp.GetMorStk(pBokNum:Str3):boolean;
begin
  OpenPRPDEF;
  Result:=ohPRPDEF.ReadBoolean('OCM',pBokNum,'MorStk',FALSE);
end;

procedure TOcmPrp.SetMorStk(pBokNum:Str3;pValue:boolean);
begin
  OpenPRPDEF;
  ohPRPDEF.WriteBoolean('OCM',pBokNum,'MorStk',pValue);
end;

function TOcmPrp.GetActCas(pBokNum:Str3):boolean;
begin
  OpenPRPDEF;
  Result:=ohPRPDEF.ReadBoolean('OCM',pBokNum,'ActCas',FALSE);
end;

procedure TOcmPrp.SetActCas(pBokNum:Str3;pValue:boolean);
begin
  OpenPRPDEF;
  ohPRPDEF.WriteBoolean('OCM',pBokNum,'ActCas',pValue);
end;

function TOcmPrp.GetCasNum(pBokNum:Str3):word;
begin
  OpenPRPDEF;
  Result:=ohPRPDEF.ReadInteger('OCM',pBokNum,'CasNum',0);
end;

procedure TOcmPrp.SetCasNum(pBokNum:Str3;pValue:word);
begin
  OpenPRPDEF;
  ohPRPDEF.WriteInteger('OCM',pBokNum,'CasNum',pValue);
end;

function TOcmPrp.GetCasSlc(pBokNum:Str3):Str250;
begin
  OpenPRPDEF;
  Result:=ohPRPDEF.ReadString('OCM',pBokNum,'CasSlc','');
end;

procedure TOcmPrp.SetCasSlc(pBokNum:Str3;pValue:Str250);
begin
  OpenPRPDEF;
  ohPRPDEF.WriteString('OCM',pBokNum,'CasSlc',pValue);
end;

function TOcmPrp.GetDepInc(pBokNum:Str3):boolean;
begin
  OpenPRPDEF;
  Result:=ohPRPDEF.ReadBoolean('OCM',pBokNum,'DepInc',FALSE);
end;

procedure TOcmPrp.SetDepInc(pBokNum:Str3;pValue:boolean);
begin
  OpenPRPDEF;
  ohPRPDEF.WriteBoolean('OCM',pBokNum,'DepInc',pValue);
end;

function TOcmPrp.GetTcbTed(pBokNum:Str3):Str5;
begin
  OpenPRPDEF;
  Result:=ohPRPDEF.ReadString('OCM',pBokNum,'TcbTed','A-001');
end;

procedure TOcmPrp.SetTcbTed(pBokNum:Str3;pValue:Str5);
begin
  OpenPRPDEF;
  ohPRPDEF.WriteString('OCM',pBokNum,'TcbTed',pValue);
end;

function TOcmPrp.GetTcbExd(pBokNum:Str3):Str5;
begin
  OpenPRPDEF;
  Result:=ohPRPDEF.ReadString('OCM',pBokNum,'TcbExd','A-001');
end;

procedure TOcmPrp.SetTcbExd(pBokNum:Str3;pValue:Str5);
begin
  OpenPRPDEF;
  ohPRPDEF.WriteString('OCM',pBokNum,'TcbExd',pValue);
end;

function TOcmPrp.GetTcbOtd(pBokNum:Str3):Str5;
begin
  OpenPRPDEF;
  Result:=ohPRPDEF.ReadString('OCM',pBokNum,'TcbOtd','A-001');
end;

procedure TOcmPrp.SetTcbOtd(pBokNum:Str3;pValue:Str5);
begin
  OpenPRPDEF;
  ohPRPDEF.WriteString('OCM',pBokNum,'TcbOtd',pValue);
end;

function TOcmPrp.GetExnFrm(pBokNum:Str3):Str12;
begin
  OpenPRPDEF;
  Result:=ohPRPDEF.ReadString('OCM',pBokNum,'ExnFrm','yybbbnnnnn');
end;

procedure TOcmPrp.SetExnFrm(pBokNum:Str3;pValue:Str12);
begin
  OpenPRPDEF;
  ohPRPDEF.WriteString('OCM',pBokNum,'ExnFrm',pValue);
end;

function TOcmPrp.GetExpDay(pBokNum:Str3):integer;
begin
  OpenPRPDEF;
  Result:=ohPRPDEF.ReadInteger('OCM',pBokNum,'ExpDay',15);
end;

procedure TOcmPrp.SetExpDay(pBokNum:Str3;pValue:integer);
begin
  OpenPRPDEF;
  ohPRPDEF.WriteInteger('OCM',pBokNum,'ExpDay',pValue);
end;

function TOcmPrp.GetRepNam(pBokNum:Str3):Str8;
begin
  OpenPRPDEF;
  Result:=ohPRPDEF.ReadString('OCM',pBokNum,'RepNam','OCDBAS');
end;

procedure TOcmPrp.SetRepNam(pBokNum:Str3;pValue:Str8);
begin
  OpenPRPDEF;
  ohPRPDEF.WriteString('OCM',pBokNum,'RepNam',pValue);
end;

function TOcmPrp.GetRepNum(pBokNum:Str3):byte;
begin
  OpenPRPDEF;
  Result:=ohPRPDEF.ReadInteger('OCM',pBokNum,'RepNum',1);
end;

procedure TOcmPrp.SetRepNum(pBokNum:Str3;pValue:byte);
begin
  OpenPRPDEF;
  ohPRPDEF.WriteInteger('OCM',pBokNum,'RepNum',pValue);
end;

function TOcmPrp.GetDvzNam(pBokNum:Str3):Str3;
begin
  OpenPRPDEF;
  Result:=ohPRPDEF.ReadString('OCM',pBokNum,'DvzNam','EUR');
end;

procedure TOcmPrp.SetDvzNam(pBokNum:Str3;pValue:Str3);
begin
  OpenPRPDEF;
  ohPRPDEF.WriteString('OCM',pBokNum,'DvzNam',pValue);
end;

function TOcmPrp.GetItmEdi(pBokNum:Str3):byte;
begin
  OpenPRPDEF;
  Result:=ohPRPDEF.ReadInteger('OCM',pBokNum,'ItmEdi',0);
end;

procedure TOcmPrp.SetItmEdi(pBokNum:Str3;pValue:byte);
begin
  OpenPRPDEF;
  ohPRPDEF.WriteInteger('OCM',pBokNum,'ItmEdi',pValue);
end;

function TOcmPrp.GetProLst(pBokNum:Str3):boolean;
begin
  OpenPRPDEF;
  Result:=ohPRPDEF.ReadBoolean('OCM',pBokNum,'ProLst',FALSE);
end;

procedure TOcmPrp.SetProLst(pBokNum:Str3;pValue:boolean);
begin
  OpenPRPDEF;
  ohPRPDEF.WriteBoolean('OCM',pBokNum,'ProLst',pValue);
end;

function TOcmPrp.GetScmDis(pBokNum:Str3):boolean;
begin
  OpenPRPDEF;
  Result:=ohPRPDEF.ReadBoolean('OCM',pBokNum,'ScmDis',FALSE);
end;

procedure TOcmPrp.SetScmDis(pBokNum:Str3;pValue:boolean);
begin
  OpenPRPDEF;
  ohPRPDEF.WriteBoolean('OCM',pBokNum,'ScmDis',pValue);
end;

function TOcmPrp.GetTrsBva(pBokNum:Str3):boolean;
begin
  OpenPRPDEF;
  Result:=ohPRPDEF.ReadBoolean('OCM',pBokNum,'TrsBva',FALSE);
end;

procedure TOcmPrp.SetTrsBva(pBokNum:Str3;pValue:boolean);
begin
  OpenPRPDEF;
  ohPRPDEF.WriteBoolean('OCM',pBokNum,'TrsBva',pValue);
end;

function TOcmPrp.GetDupVer(pBokNum:Str3):boolean;
begin
  OpenPRPDEF;
  Result:=ohPRPDEF.ReadBoolean('OCM',pBokNum,'DupVer',FALSE);
end;

procedure TOcmPrp.SetDupVer(pBokNum:Str3;pValue:boolean);
begin
  OpenPRPDEF;
  ohPRPDEF.WriteBoolean('OCM',pBokNum,'DupVer',pValue);
end;

function TOcmPrp.GetRetSal(pBokNum:Str3):boolean;
begin
  OpenPRPDEF;
  Result:=ohPRPDEF.ReadBoolean('OCM',pBokNum,'RetSal',FALSE);
end;

procedure TOcmPrp.SetRetSal(pBokNum:Str3;pValue:boolean);
begin
  OpenPRPDEF;
  ohPRPDEF.WriteBoolean('OCM',pBokNum,'RetSal',pValue);
end;

function TOcmPrp.GetAyeCnc(pBokNum:Str3):boolean;
begin
  OpenPRPDEF;
  Result:=ohPRPDEF.ReadBoolean('OCM',pBokNum,'AyeCnc',FALSE);
end;

procedure TOcmPrp.SetAyeCnc(pBokNum:Str3;pValue:boolean);
begin
  OpenPRPDEF;
  ohPRPDEF.WriteBoolean('OCM',pBokNum,'AyeCnc',pValue);
end;

function TOcmPrp.GetActSnd(pBokNum:Str3):boolean;
begin
  OpenPRPDEF;
  Result:=ohPRPDEF.ReadBoolean('OCM',pBokNum,'ActSnd',FALSE);
end;

procedure TOcmPrp.SetActSnd(pBokNum:Str3;pValue:boolean);
begin
  OpenPRPDEF;
  ohPRPDEF.WriteBoolean('OCM',pBokNum,'ActSnd',pValue);
end;

function TOcmPrp.GetFixSnd(pBokNum:Str3):boolean;
begin
  OpenPRPDEF;
  Result:=ohPRPDEF.ReadBoolean('OCM',pBokNum,'FixSnd',FALSE);
end;

procedure TOcmPrp.SetFixSnd(pBokNum:Str3;pValue:boolean);
begin
  OpenPRPDEF;
  ohPRPDEF.WriteBoolean('OCM',pBokNum,'FixSnd',pValue);
end;

function TOcmPrp.GetSndNam(pBokNum:Str3):Str30;
begin
  OpenPRPDEF;
  Result:=ohPRPDEF.ReadString('OCM',pBokNum,'SndNam','');
end;

procedure TOcmPrp.SetSndNam(pBokNum:Str3;pValue:Str30);
begin
  OpenPRPDEF;
  ohPRPDEF.WriteString('OCM',pBokNum,'SndNam',pValue);
end;

function TOcmPrp.GetSndEml(pBokNum:Str3):Str30;
begin
  OpenPRPDEF;
  Result:=ohPRPDEF.ReadString('OCM',pBokNum,'SndEml','');
end;

procedure TOcmPrp.SetSndEml(pBokNum:Str3;pValue:Str30);
begin
  OpenPRPDEF;
  ohPRPDEF.WriteString('OCM',pBokNum,'SndEml',pValue);
end;

function TOcmPrp.GetNotRes(pBokNum:Str3):boolean;
begin
  OpenPRPDEF;
  Result:=ohPRPDEF.ReadBoolean('OCM',pBokNum,'NotRes',FALSE);
end;

procedure TOcmPrp.SetNotRes(pBokNum:Str3;pValue:boolean);
begin
  OpenPRPDEF;
  ohPRPDEF.WriteBoolean('OCM',pBokNum,'NotRes',pValue);
end;

function TOcmPrp.GetPrnCls(pBokNum:Str3):boolean;
begin
  OpenPRPDEF;
  Result:=ohPRPDEF.ReadBoolean('OCM',pBokNum,'PrnCls',FALSE);
end;

procedure TOcmPrp.SetPrnCls(pBokNum:Str3;pValue:boolean);
begin
  OpenPRPDEF;
  ohPRPDEF.WriteBoolean('OCM',pBokNum,'PrnCls',pValue);
end;

function TOcmPrp.GetPrnDoq(pBokNum:Str3):byte;
begin
  OpenPRPDEF;
  Result:=ohPRPDEF.ReadInteger('OCM',pBokNum,'PrnDoq',1);
end;

procedure TOcmPrp.SetPrnDoq(pBokNum:Str3;pValue:byte);
begin
  OpenPRPDEF;
  ohPRPDEF.WriteInteger('OCM',pBokNum,'PrnDoq',pValue);
end;

function TOcmPrp.GetUlcRsn(pBokNum:Str3):boolean;
begin
  OpenPRPDEF;
  Result:=ohPRPDEF.ReadBoolean('OCM',pBokNum,'UlcRsn',FALSE);
end;

procedure TOcmPrp.SetUlcRsn(pBokNum:Str3;pValue:boolean);
begin
  OpenPRPDEF;
  ohPRPDEF.WriteBoolean('OCM',pBokNum,'UlcRsn',pValue);
end;

function TOcmPrp.GetItdRsn(pBokNum:Str3):boolean;
begin
  OpenPRPDEF;
  Result:=ohPRPDEF.ReadBoolean('OCM',pBokNum,'ItdRsn',FALSE);
end;

procedure TOcmPrp.SetItdRsn(pBokNum:Str3;pValue:boolean);
begin
  OpenPRPDEF;
  ohPRPDEF.WriteBoolean('OCM',pBokNum,'ItdRsn',pValue);
end;

function TOcmPrp.GetValClc(pBokNum:Str3):Str15;
begin
  OpenPRPDEF;
  Result:=ohPRPDEF.ReadString('OCM',pBokNum,'ValClc','ABS5M5M5ME999');
end;

procedure TOcmPrp.SetValClc(pBokNum:Str3;pValue:Str15);
begin
  OpenPRPDEF;
  ohPRPDEF.WriteString('OCM',pBokNum,'ValClc',pValue);
end;

// ********************************* PUBLIC ************************************

end.


