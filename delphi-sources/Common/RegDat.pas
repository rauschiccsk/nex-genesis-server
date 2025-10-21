unit RegDat;
// ********************************************************************************************
//                           Udaje o registracii informacneho systemu NEX
// ********************************************************************************************

interface

uses
  //SysReg1,
  NexRgh, NexLic, NexRight,
  IcTypes, IcConv, NexPath, NexGlob, pNXPLST,
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls,
  Dialogs, DB, NexBtrTable, DBTables, NexPxTable;

const cMaxPmd = 5000;

type
  TPmdData = record
    SystemL :Str1;    // Moduly patriace dosystemu NEX L
    SystemM :Str1;    // Moduly patriace dosystemu NEX M
    SystemP :Str1;    // Moduly patriace dosystemu NEX P
    SysMark :Str2;    // Cislo podsystemu
    PmdMark :Str3;    // Typove oznacenie programoveho modulu
    PmdType :Str1;    // Typ M-modul; F-Funkcia
    PmdName :Str40;   // Nazov programoveho modulu
    PmdReg :boolean;  // Ak je TRUE modul je registrovany
  end;

  TRegData = record
    SerNum :Str15;  // S�riov� ��slo in�tal�cie - syst�m generuje automaticky
  end;

  TReg = class (TComponent)
    constructor Create;
    destructor  Destroy; override;
  private
    oDataHnd: TNxpLst;
    oPmd: array [1..cMaxPmd] of TPmdData;
    procedure PmdLstCrt; // Vytvory zoznam programovych modulov
    procedure AddToTable (pIndex:word); // Prida modul do PXtabulky
    procedure Add (pIndex:word;pSystemL,pSystemM,pSystemP:Str1;pSysMark:Str2;pPmdMark:Str3;pPmdType:Str1;pPmdName:Str40);
    function GetNxpLst:TNexPxTable;
    procedure SetNxpLst(pValue:TNexPxTable);
  public
    procedure OpenTable;
    procedure FillTable (pSystem,pPmdType:Str1);
    procedure CloseTable;
    procedure SaveToFile; // Ulozi zoznam programovych modulov do textoveho suboru
    function GetPmdName(pPmdMark:Str3):Str40;
  published
//    property ptNXPLST:TNexPxTable read GetNxpLst write SetNxpLst;
    property DataSet:TNexPxTable read GetNxpLst write SetNxpLst;
    property DataHnd:TNxpLst read oDataHnd write oDataHnd;
  end;

implementation

constructor TReg.Create;
begin
  PmdLstCrt; // Vytvory zoznam programovych modulov
end;

destructor  TReg.Destroy;
begin
end;

// *************************************** PRIVATE ********************************************

procedure TReg.PmdLstCrt; // Vytvory zoznam programovych modulov
begin
  FillChar (oPmd,SizeOf(oPmd),#0);
  // ----------------- MODULY NEPODLIEHAJUCE K REGISTRACII ---------------------
  Add (0001,'X','X','X','00','SYS','M','Syst�mov� nastavenia');
  Add (0002,'X','X','X','00','USD','M','Evidencia u��vate�ov syst�mu');
  Add (0003,'X','X','X','00','DBS','M','�dr�ba datab�zov�ch s�borov');
  Add (0004,'X','X','X','00','KEY','M','Spr�va riadiacich parametrov');
  Add (0005,'X','X','X','00','GSC','M','B�zov� evidencia tovaru');
  Add (0006,'X','X','X','00','PAB','M','Evidencia obchodn�ch partnerov');
  Add (0007,'X','X','X','00','STK','M','Skladov� karty z�sob');
  Add (0008,'X','X','X','00','JRN','M','Denn�k ��tovn�ch z�pisov');
  Add (0009,'X','X','X','00','FJR','M','Pe�a�n� denn�k');
  Add (0010,'X','X','X','00','ACV','M','��tovn� pom�cky');
  Add (0011,'X','X','X','00','IFC','M','Komunika�n� rozhranie');
  // ------------------------ SYSTEMOVE PROSTRIEDKY ----------------------------
  //                               M O D U L Y
  Add (0101,'-','X','X','01','CCS','M','Centr�lny riadiaci syst�m');
  Add (0102,'-','X','X','01','CPS','M','Termin�lov� server');
  //                              F U N K C I E
  Add (0141,'X','X','X','01','MOD','F','Riadenia pr�stupu k modulom');
  Add (0142,'-','X','X','01','DAT','F','Riadenia pr�stupu k �dajom');
  Add (0143,'-','X','X','01','FNC','F','Riadenia pr�stupu k funkci�m');
  Add (0144,'-','X','X','01','REP','F','Prostriedky n�vrhu tla�ov�ch zost�v');
  Add (0145,'X','X','X','01','XLS','F','Export �dajov do EXCEL');
  Add (0146,'X','X','X','01','OLE','F','Export �dajov do OLE');
  Add (0147,'X','X','X','01','DVZ','F','Zahrani�n� vy��tovacie menay');
  Add (0148,'-','-','X','01','AMS','F','Automatick� generovanie spr�v');
  Add (0149,'-','-','X','01','ELG','F','Viacjazykov� syst�mov� prostredie');
  Add (0150,'X','X','X','01','RLG','F','Viacjazykov� v�stupn� zostavy');
  Add (0151,'-','X','X','25','OAD','F','Online archiv�cia �dajov');
  // -------------------------- OBCHODN� �INNOS� -------------------------------
  //                               M O D U L Y
  Add (0201,'X','X','X','02','CRD','M','Evidencia z�kazn�ckych kariet');
  Add (0202,'X','X','X','02','PLS','M','Evidencia predajn�ch cien');
  Add (0203,'X','X','X','02','APL','M','Evidencia akciov�ch cien');
  Add (0204,'-','X','X','02','AGL','M','Evidencia zmluvn�ch cien');
  Add (0205,'X','X','X','02','MCB','M','Odberate�sk� cenov� ponuky');
  Add (0206,'-','X','X','02','CCN','M','Obchodn� r�mcov� zmluvy');
  Add (0207,'-','X','X','02','BCB','M','V�eobecn� obchodn� podmienky');
  Add (0208,'-','X','X','02','BCI','M','Individu�lne obchodn� podmienky');
  Add (0209,'-','X','X','02','DIR','M','Kontaktn� mana��rsky di�r');
  Add (0210,'-','X','X','02','AFB','M','Spr�va let�kov�ch akci�');
  Add (0211,'X','X','X','02','ACB','M','Akciov� precenenie tovaru');
  Add (0212,'-','X','X','02','RPL','M','Doporu�en� predajn� ceny');
  Add (0213,'-','X','X','02','RPC','M','Po�iadavky na zmeny cien');
  Add (0214,'-','X','X','02','MDS','M','V�kaz najmen�ieho zisku');
  Add (0215,'-','X','X','02','TPC','M','Evidencia terminovan�ch cien');
  // --------------------------- RIADENIE SKLADU -------------------------------
  //                               M O D U L Y
  Add (0301,'X','X','X','03','IMB','M','Intern� skladov� pr�jemky');
  Add (0302,'X','X','X','03','OMB','M','Intern� skladov� v�dajky');
  Add (0303,'X','X','X','03','RMB','M','Medziskladov� presun');
  Add (0304,'X','X','X','03','PKB','M','Preba�ovanie tovaru');
  Add (0305,'X','X','X','03','IVB','M','Inventariz�cia skladov');
  Add (0306,'X','X','X','03','IVP','M','Kompenz�cia invent�rnych rozdielov');
  Add (0307,'-','X','X','03','REB','M','Prece�ovac� protokol');
  Add (0308,'-','X','X','03','PMG','M','Obalov� hospod�rstvo');
  Add (0345,'X','X','X','03','ASN','M','Spr�va v�robn�ch ��siel');
  //                              F U N K C I E
  Add (0341,'X','X','X','03','MBA','F','Viac identifika�n�ch k�dov');
  Add (0342,'X','X','X','03','GIM','F','Pripojen� obr�zok k tovaru');
  Add (0343,'-','X','X','03','IVU','F','Termin�lov� inventariz�cia UDB');
  Add (0344,'-','X','X','03','IVC','F','Termin�lov� inventariz�cia CPH');
  Add (0346,'X','X','X','03','KOM','F','Komision�lny tovar');
  // ------------------------- Z�SOBOVANIE SKLADOV -----------------------------
  //                               M O D U L Y
  Add (0401,'-','X','X','04','MSB','M','Dod�vate�sk� cenov� ponuky');
  Add (0402,'-','X','X','04','BSB','M','Obchodn� podmienky dod�vok');
  Add (0403,'-','X','X','04','PSB','M','Pl�novanie objedn�vok');
  Add (0404,'-','X','X','04','OCP','M','Spracovanie po�iadaviek na objednanie');
  Add (0405,'X','X','X','04','OSB','M','Dod�vate�sk� objedn�vky');
  Add (0406,'X','X','X','04','TSB','M','Dod�vate�sk� dodacie listy');
  Add (0407,'-','X','X','04','TIB','M','Termin�lov� pr�jem tovaru');
  Add (0408,'-','-','X','04','PIM','M','Pozi�n� pr�jem tovaru');
  Add (0409,'X','X','X','04','KSB','M','Komision�lne vy��tovanie');
  Add (0410,'X','X','X','04','OSQ','M','Tvorba objedn�vok zo skladu');
  //                              F U N K C I E
  Add (0441,'-','X','X','04','OST','F','Spr�va term�nov dod�vok');
  Add (0442,'-','X','X','04','TSJ','F','Origin�lne podklady DDL');
  Add (0443,'-','-','X','04','APS','F','Automatick� p�rovanie objedn�vok');
  Add (0444,'-','-','X','04','ARC','F','Automatick� rezerv�cia z�kaziek');
  // ------------------------- VE�KOOBCHODN� PREDAJ ----------------------------
  //                               M O D U L Y
  Add (0501,'-','X','X','05','UDB','M','Univerz�lne odbytov� doklady');
  Add (0502,'X','X','X','05','OCB','M','Odberate�sk� z�kazky');
  Add (0503,'X','X','X','05','TCB','M','Odberate�sk� dodacie listy');
  Add (0504,'X','X','X','05','ICB','M','Odberate�sk� fakt�ry');
  Add (0505,'-','X','X','05','PCO','M','Evidencia z�lohov�ch platieb');
  Add (0506,'-','X','X','05','ALB','M','Po�i�ov�a - riadenie v�po�i�ky');
  Add (0507,'-','X','X','05','TOB','M','Termin�lov� v�daj tovaru');
  Add (0508,'-','X','X','05','POM','M','Pozi�n� v�daj toaru');
  Add (0509,'-','X','X','05','DSP','M','V�nimky blokovania z�kazn�ka');
  Add (0510,'-','X','X','05','SVB','M','Fakt�ry z�lohov�ch platieb');
  //                              F U N K C I E
  Add (0541,'-','X','X','05','GLG','F','Viacjazykov� n�zvy tovarov');
  Add (0542,'-','X','X','05','URS','F','Automatick� uvolnenie rezerv�cie');
  Add (0543,'-','X','X','05','LIM','F','N�kupn� limit odberate�a');
  Add (0544,'-','-','X','05','PCR','F','Pl�novanie rezerv�cie');
  Add (0545,'X','X','X','05','TCF','F','Fi�k�lne vy��tovanie ODL');
  // ------------------------- MALOOBCHODN� PREDAJ -----------------------------
  //                               M O D U L Y
  Add (0601,'X','X','X','06','CAS','M','Elektronick� registra�n� poklad�a');
  Add (0602,'X','X','X','06','SAB','M','Spr�va maloobchodn�ho predaja');
  Add (0603,'X','X','X','06','CAI','M','Infom�cie o pokladni�nom predaji');
  Add (0604,'-','X','X','06','FMS','M','Fisk�lny server');
  Add (0605,'X','X','X','06','CSS','M','Pokladni�n� server');
  Add (0606,'-','X','X','06','PVC','M','Riadenie cenov�ch termin�lov');
  Add (0607,'X','X','X','06','CAP','M','Tla� k�pi� dokladov');
  Add (0608,'X','X','X','06','CAC','M','V�kaz denn�ch uz�vierok');
  //                              F U N K C I E
  Add (0641,'X','X','X','06','CCA','F','Anal�za pokladni�n�ch storien');
  // ------------------------- RIADENIE LOGISTIKY ------------------------------
  //                               M O D U L Y
  Add (0701,'-','X','X','07','EXO','M','Evidencia expedi�n�ch pr�kazov');
  Add (0702,'-','X','X','07','CAR','M','Evidencia n�kladn�ch aut');
  Add (0703,'-','X','X','07','EXP','M','Pl�novanie rozvozu tovaru');
  Add (0704,'-','X','X','07','RBA','M','Vykaz v�robnej �ar�e');
  // -------------------------- RIADENIE SERVISU -------------------------------
  //                               M O D U L Y
  Add (0801,'-','X','X','08','SCB','M','Servisn� z�kazky');
  Add (0802,'-','X','X','08','CLB','M','Z�kazn�cke reklamacie');
  // ------------------------- KOMPLETIZA�N� V�ROBA ----------------------------
  //                               M O D U L Y
  Add (0901,'X','X','X','09','CPB','M','Kalkul�cia v�robkov');
  Add (0902,'X','X','X','09','CMB','M','Kompletiz�cia v�robkov');
  Add (0903,'X','X','X','09','CDB','M','V�robn� doklady');
  Add (0904,'X','X','X','09','DMB','M','Rozobratie v�robkov');
  // -------------------------- PRIEMYSLEN� V�ROBA -----------------------------
  //                                M O D U L Y
  Add (1001,'-','-','X','10','SPP','M','�pecifik�cia v�robkov');
  Add (1002,'-','-','X','10','TPP','M','Technologick� pr�prava');
  Add (1003,'-','-','X','10','POP','M','V�robn� z�kazky');
  Add (1004,'-','-','X','10','PAR','M','Anal�za po�iadaviek');
  Add (1005,'-','-','X','10','COP','M','Pl�novanie v�roby');
  Add (1006,'-','-','X','10','OPP','M','Optimaliz�cia v�roby');
  Add (1007,'-','-','X','10','OPC','M','Pl�novan�e kapac�t');
  Add (1008,'-','-','X','10','CPR','M','Riadenie v�roby');
  // ------------------------- FINAN�N� ��TOVN�CTVO ----------------------------
  //                                M O D U L Y
  Add (1101,'X','X','X','11','ISB','M','Dod�vate�sk� fakt�ry');
  Add (1102,'X','X','X','11','CSB','M','Hotovostn� poklad�a');
  Add (1103,'X','X','X','11','SOB','M','Bankov� v�pisy');
  Add (1104,'X','X','X','11','PQB','M','Prevodn� pr�kazy');
  Add (1105,'-','X','X','11','USB','M','Upomienky od dod�vate�ov');
  Add (1106,'-','X','X','11','UCB','M','Upomienky pre odberate�ov');
  Add (1107,'X','X','X','11','VTR','M','Evidencia dokladov DPH');
  Add (1108,'-','X','X','11','FUE','M','Vy��tovanie spotreby PHM');
  Add (1109,'-','X','X','11','OWB','M','Vy��tovanie slu�obn�ch ciest');
  Add (1110,'-','X','X','11','SCA','M','Spl�tkov� kalend�r z�v�zkov');
  Add (1111,'-','X','X','11','CCA','M','Spl�tkov� kalend�r poh�ad�vok');
  Add (1112,'-','X','X','11','DPB','M','Post�penie a odk�penie poh�ad�vok');
  //                               F U N K C I E
  Add (1141,'-','X','X','11','ISJ','F','Origin�lne podklady DF');
  Add (1142,'-','X','X','11','CSJ','F','Origin�lne podklady HP');
  Add (1143,'-','X','X','11','PEN','F','Vystavenie penaliza�n�ch fakt�r');
  // ------------------------ JEDNODUCH� ��TOVN�CTVO ---------------------------
  //                                M O D U L Y
  Add (1201,'X','X','X','12','JDB','M','Intern� ��tovn� doklady');
  Add (1202,'X','X','X','12','FJR','M','Pe�a�n� denn�k');
  //                               F U N K C I E
  Add (1241,'X','X','X','12','FAC','F','Automatick� predkont�cia');
  // ------------------------- PODVOJN� ��TOVN�CTVO ----------------------------
  //                                M O D U L Y
  Add (1301,'X','X','X','13','IDB','M','Intern� ��tovn� doklady');
  Add (1302,'X','X','X','13','JRN','M','Denn�k ��tovn�ch z�pisov');
  Add (1303,'X','X','X','13','LDG','M','Hlavn� kniha ��tov');
  Add (1304,'X','X','X','13','ACT','M','Obratov� predvaha ��tov');
  Add (1305,'X','X','X','13','BLC','M','Intern� s�vaha a v�sledovka');
  Add (1306,'X','X','X','13','RCR','M','Koncoro�n� prekuzovanie fakt�r');
  //                               F U N K C I E
  Add (1341,'X','X','X','13','LAC','F','Automatick� predkont�cia');
  // -------------------------- MZDOV� ��TOVN�CTVO -----------------------------
  //                                M O D U L Y
  // ---------------------- ELEKTRONICK� BANKOVN�CTVO --------------------------
  //                                M O D U L Y
  Add (1501,'-','X','X','15','CRS','M','Kurzov� list n�rodnej banky');
  Add (1502,'-','X','X','15','OTV','M','Elektronick� bankov� v�pisy OTP');
  Add (1503,'-','X','X','15','OTP','M','Elektronick� prevodn� pr�kazy OTP');
  Add (1502,'-','X','X','15','STV','M','Elektronick� bankov� v�pisy SLS');
  Add (1503,'-','X','X','15','STP','M','Elektronick� prevodn� pr�kazy SLS');
  // --------------------------- EVIDENCIA MAJETKU -----------------------------
  //                                M O D U L Y
  Add (1601,'-','X','X','16','FXB','M','Evidencia investi�n�ho majetku');
  Add (1602,'-','X','X','16','MTB','M','Evidencia drobn�ho majetku');
  //                               F U N K C I E
  Add (1641,'-','X','X','16','LSU','F','��tovn� odpisy');
  Add (1642,'-','X','X','16','FXI','F','Inventariz�cia majetku - termin�l');
  // -------------------------- INTERN� V�KAZN�CTVO ----------------------------
  //                                 M O D U L Y
  Add (1701,'-','X','X','17','WAB','M','V�po�et odmeny zamestnancov');
  Add (1702,'-','-','X','17','XJR','M','XLS v�kazy ��tov');
  // --------------------------- EXTERN� V�KAZN�CTVO ---------------------------
  //                                 M O D U L Y
  Add (1801,'-','X','X','18','SRB','M','V�kaz liehov�ch v�robkov');
  Add (1802,'-','X','X','18','BLR','M','Legislat�vna s�vaha a v�sledovka');
  Add (1803,'-','X','X','18','CFW','M','Legislat�vny Cash-Flow');
  // ----------------------------- ANAL�ZA N�KUPU ------------------------------
  //                                 M O D U L Y
  Add (1901,'X','X','X','19','TOS','M','Vyhodnotenie najlep��ch dod�vate�ov');
  Add (1902,'-','X','X','19','DPY','M','Vyhodnotenie spo�ahlivosti dod�vate�ov');
  // -------------------------------- MANA�MENY --------------------------------
  //                                 M O D U L Y
  Add (2001,'X','X','X','20','TOC','M','Vyhodnotenie najlep��ch odberate�ov');
  Add (2002,'-','-','X','20','CST','M','Konsolidovan� �tatistika');
  Add (2003,'-','X','X','20','XRB','M','XLS v�kazy predaja a z�soby');
  Add (2004,'X','X','X','20','SSA','M','�tatistika VO predaja');
  Add (2005,'X','X','X','20','SSB','M','�tatistika MO predaja');
  Add (2006,'-','X','X','20','SSR','M','�tatistika predaja pod�a regi�nov');
  Add (2007,'-','X','X','20','SSS','M','V�berov� sortimentn� �tatistika');

  Add (2011,'-','X','X','20','PRB','M','Spr�va informa�n�ch projektov');
  Add (2012,'-','X','X','20','CRB','M','Spr�va z�kazn�ckych po�iadaviek');
  // ----------------------------- HOTELOV� SYST�M -----------------------------
  //                                 M O D U L Y
  Add (2101,'X','X','X','21','HRS','M','Hotelov� syst�m - recepcia');
  // --------------------------- ADMINIST�VNA �INNOS� --------------------------
  //                                 M O D U L Y
  Add (2201,'-','X','X','22','CRP','M','Kancel�rska kore�pondencia');
  Add (2202,'-','X','X','22','IPB','M','Evidencia do�lej po�ty');
  Add (2203,'-','X','X','22','OPB','M','Evidencia odoslanej po�ty');
  Add (2204,'-','X','X','22','JOB','M','Spr�va pracovn�ch pr�kazov');
  Add (2205,'-','X','X','22','APB','M','�iadosti bezhotovostn�ho styku');
  Add (2206,'-','X','X','22','PRJ','M','Spr�va podnikov�ch projektov');
  Add (2207,'-','X','X','22','EMC','M','Elektronick� spr�vy z�kazn�kom');
  // --------------------------- KOMUNIKA�N� SYST�MY ---------------------------
  //                                 M O D U L Y
  Add (2301,'-','-','X','23','IML','M','Intern� elektronick� po�ta');
  Add (2302,'-','X','X','23','OIP','M','Medziprev�dzkov� komunik�cia - server');
  Add (2303,'-','X','X','23','OIC','M','Medziprev�dzkov� komunik�cia - klient');
  Add (2304,'-','X','X','23','EDI','M','Medzifiremn� komunik�cia');
  // --------------------------- INTERNETOV� OBCHOD ----------------------------
  //                                 M O D U L Y
  Add (2401,'-','X','X','24','ITS','M','Internetov� obchod - aplika�n� program');
  Add (2402,'-','X','X','24','ITO','M','Spr�va internetov�ho obchodu-objedn�vky');
  Add (2403,'-','X','X','24','ITC','M','Spr�va internetov�ho obchodu-katal�g');
  // -------------------------- �PECI�LNE PODSYST�MY ---------------------------
  //                                 M O D U L Y
  Add (2501,'-','X','X','25','WGH','M','Obsluha elektronick�ch v�h');
  Add (2502,'X','X','X','11','CWB','M','Bankov� v�pis SEPA');
  Add (2503,'-','X','X','25','MDO','M','Spr�va dokumentov');
  Add (2504,'X','X','X','25','LAB','M','Tla� cenovkov�ch etikiet');
  // -------------------------- PODPORA ZARIADEN� ------------------------------
  //                               F U N K C I E
  Add (2641,'-','X','X','26','MMX','F','Prenosn� z�znamn�k UDB-MMX');
  Add (2642,'-','X','X','26','CPH','F','Prenosn� z�znamn�k CIPHER');
  // -------------------------- RIADENIE EKONOMIKY -----------------------------
  //                                 M O D U L Y
  Add (2701,'-','-','X','27','PCR','M','Pl�noanie zdrojov �veru');
  Add (2702,'-','-','X','27','SWE','M','Odlo�en� splatnos� z�v�zkov');
  Add (2703,'X','X','X','11','CWE','M','Prevodn� pr�kaz SEPA');
  Add (2704,'-','X','X','27','ASC','M','Anal�za z�v�zkov a poh�ad�vok');
  // -------------------------- DOCH�DZKOV� SYST�M -----------------------------
  //                                 M O D U L Y
  Add (2801,'-','-','X','28','ATS','M','Doch�dzkov� server');
  Add (2802,'-','-','X','28','ATR','M','Evidencia doch�dzky');

end;

procedure TReg.AddToTable (pIndex:word); // Prida modul do PXtabulky
begin
  oDataHnd.Insert;
  oDataHnd.SysMark := oPmd[pIndex].SysMark;
  oDataHnd.PmdMark := oPmd[pIndex].PmdMark;
  oDataHnd.PmdType := oPmd[pIndex].PmdType;
  oDataHnd.PmdName := oPmd[pIndex].PmdName;
  oDataHnd.RegInd := pIndex;
  oDataHnd.Post;
end;

procedure TReg.Add (pIndex:word;pSystemL,pSystemM,pSystemP:Str1;pSysMark:Str2;pPmdMark:Str3;pPmdType:Str1;pPmdName:Str40);
begin
  oPmd[pIndex].SystemL := pSystemL;
  oPmd[pIndex].SystemM := pSystemM;
  oPmd[pIndex].SystemP := pSystemP;
  oPmd[pIndex].SysMark := pSysMark;
  oPmd[pIndex].PmdMark := pPmdMark;
  oPmd[pIndex].PmdType := pPmdType;
  oPmd[pIndex].PmdName := pPmdName;
  oPmd[pIndex].PmdReg := TRUE;
end;

function TReg.GetNxpLst:TNexPxTable;
begin
  Result := oDataHnd.TmpTable;
end;

procedure TReg.SetNxpLst(pValue:TNexPxTable);
begin
  oDataHnd.TmpTable := pValue;
end;

// **************************************** PUBLIC ********************************************

procedure TReg.OpenTable;
begin
  oDataHnd := TNxpLst.Create;
  oDataHnd.Open;
end;

procedure TReg.FillTable (pSystem:Str1;pPmdType:Str1);
var I:word;
begin
  oDataHnd.Close;   oDataHnd.Open;
  For I:=1 to cMaxPmd do begin
//TIBI NEXLIC
//    If (I<100) or GetEnableMod(I) then begin
    If gNEXLic.ModLst='' then ReadLic;
    If RghModEnabled(oPmd[I].PmdMark) then begin
      If (pPmdType='') or (pPmdType=oPmd[I].PmdType) then begin
        If pSystem='L' then begin // NEX L
          If oPmd[I].SystemL='X' then begin
            If oPmd[I].PmdMark<>'' then AddToTable (I);
          end;
        end;
        If pSystem='M' then begin // NEX M
          If oPmd[I].SystemM='X' then begin
            If oPmd[I].PmdMark<>'' then AddToTable (I);
          end;
        end;
        If pSystem='P' then begin // NEX P
          If oPmd[I].SystemP='X' then begin
            If oPmd[I].PmdMark<>'' then AddToTable (I);
          end;
        end;
      end;
    end;
  end;
end;

procedure TReg.CloseTable;
begin
  oDataHnd.Close;
  FreeAndNil (oDataHnd);
end;

procedure TReg.SaveToFile; // Ulozi zoznam programovych modulov do texttoveho suboru
var mFile:TStrings; I:word;
begin
  mFile := TStringList.Create;;
  For I:=1 to cMaxPmd do begin
    If oPmd[I].PmdMark<>'' then begin
      mFile.Add (StrIntZero(I,4)+';'+oPmd[I].SystemL+';'+oPmd[I].SystemM+';'+oPmd[I].SystemP+';'+oPmd[I].SysMark+';'+oPmd[I].PmdMark+';'+oPmd[I].PmdName);
    end;
  end;
  If mFile.Count>0 then mFile.SaveToFile(gPath.CdwPath+'NXPLST.SYS');
  FreeAndNil (mFile);
end;

function TReg.GetPmdName(pPmdMark:Str3):Str40;
var mCnt:word;  mFind:boolean;
begin
  Result := '';
  mCnt := 0;
  Repeat
    Inc (mCnt);
    mFind := oPmd[mCnt].PmdMark=pPmdMark;
  until (mCnt=cMaxPmd) or mFind;
  If mFind then Result := oPmd[mCnt].PmdName;
end;

end.
{MOD 1901005}
{MOD 1905017}
