unit CasIni;

interface

uses
  IcTypes, IcVariab, IcConv, NexVar, IniFiles, Classes;

type
  TCasIni = class (TIniFile)
  private
    procedure SetFiscalType (pValue:byte); // Nastavenie type fiskalneho modulu
    procedure SetFiscalPort (pValue:Str4); // Nastavenie portu fiskalneho modulu
    procedure SetFiscalVerify (pValue:boolean); // Ak je TRUE potom system kontroluje pritomnost fiskalneho modulu
    procedure SetBlockType (pValue:byte); // Nastavenie typu tlacoveho formatu pokladnicneho dokladu
    procedure SetPrinterType (pValue:byte); // Nastavenie typu tlaciarne pokladnicneh uctenky
    function GetFiscalType:byte; // Typ fiskalneho modulu
    function GetFiscalPort:Str4; // Port fiskalneho modulu
    function GetFiscalVerify:boolean; // Ak je TRUE potom system kontroluje pritomnost fiskalneho modulu
    function GetBlockType:byte; // Typ tlacoveho formatu pokladnicneho dokladu
    function GetPrinterType:byte; // Typ tlaciarne pokladnicneh uctenky
    function GetStkNum: word; // Cislo pouziteho skladu
    function GetPlsNum: word; // Cennik pre riadny predaj
    function GetCashBox:byte; // Typ otvorenia penaznej zasuvky
    function GetNulSal:boolean; // Povolenie predaja s nulovou predajnou cenou
    function GetUseCss:boolean; // Nacitanie stavu skaldu cez CSS

    procedure SetPlsNum (pValue:word); // Ulozi cislo cennika do inicializacneho suboru
    procedure SetStkNum (pValue:word); // Ulozi cislo skladu do inicializacneho suboru
    procedure SetStkDet (pValue:byte); // Sposob urcenia skladu vydaja
    procedure SetCashBox (pValue:byte); // Typ otvorenia penaznej zasuvky
    procedure SetNulSal (pValue:boolean); // Povolenie predaja s nulovou predajnou cenou
    procedure SetUseCss (pValue:boolean); // Nacitanie stavu skaldu cez CSS

    procedure SetEndBlkLnQnt (pValue:byte); // Pocet riadkov na konci uctenky
    function GetEndBlkLnQnt: byte; // Pocet riadkov na konci uctenky
    procedure SetRewindLnQnt (pValue:byte); // Pocet stahovanych riadkov
    function GetRewindLnQnt: byte; // Pocet stahovanych riadkov
    procedure SetVatTblPrint (pValue:boolean); // Tlac tabulky DPH
    function GetVatTblPrint:boolean; // Tlac tabulky DPH
    procedure SetAutoExdPrn (pValue:boolean); // Automaticka tlac expedicneho listu
    function GetAutoExdPrn:boolean; // Automaticka tlac expedicneho listu
    procedure SetOpnBlkEnab (pValue:boolean); // Povolit mat viac otvorenych pokladnicnych ucteniek
    function GetOpnBlkEnab:boolean; // Povolit mat viac otvorenych pokladnicnych ucteniek
    procedure SetCadType (pValue:byte); // Pocet stahovanych riadkov
    function GetCadType: byte; // Pocet stahovanych riadkov
    procedure SetRetCom (pValue:boolean); // Zapne obojsmernú komunikáciu pre fiscalný server
    function GetRetCom:boolean; // Zapne obojsmernú komunikáciu pre fiscalný server
    procedure SetDeskView(pValue:byte); // Zobrazenie stolov resp blockov 1-blocky 2-stoly
    function GetDeskView:byte; // Zobrazenie stolov resp blockov 1-blocky 2-stoly
    procedure SetGsCumulate(pValue:boolean); // kumulovanie tovarovych poloziek s rovankym PLU na blocku
    function GetGsCumulate:boolean; // kumulovanie tovarovych poloziek s rovankym PLU na blocku
    procedure SetGsGridSlct(pValue:boolean); // vyber tovaru z mriezky a nie zo zozanmu tovarov
    function GetGsGridSlct:boolean; // vyber tovaru z mriezky a nie zo zozanmu tovarov

  public
    procedure PutBlkNum (pBlkNum:longint); // Ulozi cislo pokladnicneho dokladu

    function GetBlkNum: longint; // Cislo pokladnicneho dokladu
    function GetStkDet: byte; // Spôsob urcenia skladu vydaja
    function GetStkVer: byte; // Kontrola ci na skladu je dostatocne mnozstvo
    function GetDocRnd: byte; // Zaokruhlenie konecnej hodnoty s DPH pokladnicneho dokladu
    function GetItmRnd: byte; // Zaokruhlenie hodnoty v PC s DPH polozky pokladnicneho dokladu
    function GetEcrNum: byte; // Cislo fisklanej pokladne
    function GetBcsStat: integer; // Stav snimaca ciaroveho kodu
    function GetBcsPort: Str4; // Komunikacny port ktoremu je pripojeny snimac
    function GetBcsBaud: Str5; // Prenosova rychlost portu ciaroveho kodu
    function GetBcsData: Str1; // Pocet data bytov prenosu portu snimaca ciaroveho kodu
    function GetBcsStop: Str1; // Pocet stop bytov prenosu portu snimaca ciaroveho kodu
    function GetBcsParit: Str1; // Parita prenosu portu snimaca ciaroveho kodu
    function GetDispType: integer; // Typ zakaznickeho displeya
    function GetDispPort: Str4; // Komunikacny port ktoremu je pripojeny zakaznicky display
    function GetWghPort: Str4; // Komunikacny port ktoremu je pripojena vaha
    function GetWghBaud: Str5; // Prenosova rychlost portu vahy
    function GetWghData: Str1; // Pocet data bytov prenosu portu vahy
    function GetWghStop: Str1; // Pocet stop bytov prenosu portu vahy
    function GetWghParit: Str1; // Parita prenosu portu
    function GetWghType: Str1; // Komunikacny protokol pripojenej vahy
    function GetWghTara: boolean; // Ci z nacitanej vahy treba odpocitat vahu balenie uvedeneho v GSCAT
    function GetSpdPayNum: byte; // Ciselny kod zalohovej platby v ERP

    property StkNum:word read GetStkNum write SetStkNum;
    property PlsNum:word read GetPlsNum write SetPlsNum;
    property StkDet:byte read GetStkDet write SetStkDet;
    property FiscalType:byte read GetFiscalType write SetFiscalType;
    property FiscalPort:Str4 read GetFiscalPort write SetFiscalPort;
    property FiscalVerify:boolean read GetFiscalVerify write SetFiscalVerify;
    property BlockType:byte read GetBlockType write SetBlockType;
    property PrinterType:byte read GetPrinterType write SetPrinterType;
    property CashBox:byte read GetCashBox write SetCashBox;
    property NulSal:boolean read GetNulSal write SetNulSal;
    property UseCss:boolean read GetUseCss write SetUseCss;
    property VatTblPrint:boolean read GetVatTblPrint write SetVatTblPrint;
    property EndBlkLnQnt:byte read GetEndBlkLnQnt write SetEndBlkLnQnt;
    property RewindLnQnt:byte read GetRewindLnQnt write SetRewindLnQnt;
    property AutoExdPrn:boolean read GetAutoExdPrn write SetAutoExdPrn;
    property OpnBlkEnab:boolean read GetOpnBlkEnab write SetOpnBlkEnab;
    property CadType:byte read GetCadType write SetCadType;
    property RetCom:boolean read GetRetCom write SetRetCom;
    property DeskView:byte read GetDeskView write SetDeskView;
    property GsCumulate:boolean read GetGsCumulate write SetGsCumulate;
    property GsGridSlct:boolean read GetGsGridSlct write SetGsGridSlct;
  end;

var
  gCasIni: TCasIni;

implementation

procedure TCasIni.SetFiscalType (pValue:byte); // Nastavenie type fiskalneho modulu
begin
  WriteInteger ('CASSA','FiscalType',pValue);
end;

procedure TCasIni.SetFiscalPort (pValue:Str4); // Nastavenie portu fiskalneho modulu
begin
  WriteString ('CASSA','FiscalPort',pValue);
end;

procedure TCasIni.SetFiscalVerify (pValue:boolean); // Ak je TRUE potom system kontroluje pritomnost fiskalneho modulu
begin
  WriteBool ('CASSA','FiscalVerify',pValue);
end;

procedure TCasIni.SetBlockType (pValue:byte); // Nastavenie tlacoveho formatu pokladnicneho dokladu
begin
  WriteInteger ('CASSA','BlockType',pValue);
end;

procedure TCasIni.SetPrinterType (pValue:byte); // Nastavenie typu tlaciarne pokladnicneh uctenky
begin
  WriteInteger ('CASSA','PrinterType',pValue);
end;

function TCasIni.GetFiscalType:byte; // Typ fiskalneho modulu
begin
  If not ValueExists ('CASSA','FiscalType') then WriteInteger ('CASSA','FiscalType',0);
  Result := ReadInteger ('CASSA','FiscalType',0);
end;

function TCasIni.GetFiscalPort:Str4; // Port fiskalneho modulu
begin
  If not ValueExists ('CASSA','FiscalPort') then WriteString ('CASSA','FiscalPort','COM1');
  Result := ReadString ('CASSA','FiscalPort','COM1');
end;

function TCasIni.GetFiscalVerify:boolean; // Ak je TRUE potom system kontroluje pritomnost fiskalneho modulu
begin
  If not ValueExists ('CASSA','FiscalVerify') then WriteBool ('CASSA','FiscalVerify',TRUE);
  Result := ReadBool ('CASSA','FiscalVerify',TRUE);
end;

function TCasIni.GetBlockType:byte; // Typ tlacoveho formatu pokladnicneho dokladu
begin
  If not ValueExists ('CASSA','BlockType') then WriteInteger ('CASSA','BlockType',4);
  Result := ReadInteger ('CASSA','BlockType',4);
end;

function TCasIni.GetPrinterType:byte; // Typ tlaciarne pokladnicneh uctenky
begin
  If not ValueExists ('CASSA','PrinterType') then WriteInteger ('CASSA','PrinterType',0);
  Result := ReadInteger ('CASSA','PrinterType',0);
end;

procedure TCasIni.PutBlkNum (pBlkNum:longint); // Ulozi cislo pokladnicneho dokladu
begin
  WriteInteger ('CASSA','BlkNum',pBlkNum);
end;

procedure TCasIni.SetPlsNum (pValue:word); // Ulozi cislo cennika do inicializacneho suboru
begin
  WriteInteger ('CASSA','PlsNum',pValue);
end;

procedure TCasIni.SetStkNum (pValue:word); // Ulozi cislo skladu do inicializacneho suboru
begin
  WriteInteger ('CASSA','StkNum',pValue);
end;

procedure TCasIni.SetStkDet (pValue:byte); // Sposob urcenia skladu vydaja
begin
  WriteInteger ('CASSA','StkDet',pValue);
end;

procedure TCasIni.SetCashBox (pValue:byte); // Typ otvorenia penaznej zasuvky
begin
  WriteInteger ('CASSA','CashBox',pValue);
end;

procedure TCasIni.SetNulSal (pValue:boolean); // Povolenie predaja s nulovou predajnou cenou
begin
  WriteBool ('CASSA','NulSal',pValue);
end;

procedure TCasIni.SetuseCss (pValue:boolean); // Nacitanie stavu skaldu cez CSS
begin
  WriteBool ('CASSA','UseCss',pValue);
end;

procedure TCasIni.SetEndBlkLnQnt (pValue:byte); // Pocet riadkov na konci uctenky
begin
  WriteInteger ('CASSA','EndBlkLnQnt',pValue);
end;

function TCasIni.GetEndBlkLnQnt: byte;  // Pocet riadkov na konci uctenky
begin
  If not ValueExists ('CASSA','EndBlkLnQnt') then WriteInteger ('CASSA','EndBlkLnQnt',9);
  Result := ReadInteger ('CASSA','EndBlkLnQnt',9);
end;

procedure TCasIni.SetRewindLnQnt (pValue:byte); // Pocet stahovanych riadkov
begin
  WriteInteger ('CASSA','RewindLnQnt',pValue);
end;

function TCasIni.GetRewindLnQnt: byte;  // Pocet stahovanych riadkov
begin
  If not ValueExists ('CASSA','RewindLnQnt') then WriteInteger ('CASSA','RewindLnQnt',4);
  Result := ReadInteger ('CASSA','RewindLnQnt',4);
end;

procedure TCasIni.SetVatTblPrint (pValue:boolean); // Tkac tabulky DPH
begin
  WriteBool ('CASSA','VatTblPrint',pValue);
end;

function TCasIni.GetVatTblPrint:boolean; // Tkac tabulky DPH
begin
  If not ValueExists ('CASSA','VatTblPrint') then WriteBool ('CASSA','VatTblPrint',FALSE);
  Result := ReadBool ('CASSA','VatTblPrint',FALSE);
end;

procedure TCasIni.SetAutoExdPrn (pValue:boolean); // Automaticka tlac expedicneho listu
begin
  WriteBool ('CASSA','AutoExdPrn',pValue);
end;

function TCasIni.GetAutoExdPrn:boolean; // Automaticka tlac expedicneho listu
begin
  If not ValueExists ('CASSA','AutoExdPrn') then WriteBool ('CASSA','AutoExdPrn',FALSE);
  Result := ReadBool ('CASSA','AutoExdPrn',FALSE);
end;

procedure TCasIni.SetOpnBlkEnab (pValue:boolean); // Povolit mat viac otvorenych pokladnicnych ucteniek
begin
  WriteBool ('CASSA','OpnBlkEnab',pValue);
end;

function TCasIni.GetOpnBlkEnab:boolean; // Povolit mat viac otvorenych pokladnicnych ucteniek
begin
  If not ValueExists ('CASSA','OpnBlkEnab') then WriteBool ('CASSA','OpnBlkEnab',FALSE);
  Result := ReadBool ('CASSA','OpnBlkEnab',FALSE);
end;

procedure TCasIni.SetCadType (pValue:byte);
begin
  WriteInteger ('CASSA','CadType',pValue);
end;

function TCasIni.GetCadType: byte;
begin
  If not ValueExists ('CASSA','CadType') then WriteInteger ('CASSA','CadType',0);
  Result := ReadInteger ('CASSA','CadType',0);
end;

procedure TCasIni.SetRetCom (pValue:boolean);
begin
  WriteBool ('CASSA','RetCom',pValue);
end;

function TCasIni.GetRetCom:boolean;
begin
  If not ValueExists ('CASSA','RetCom') then WriteBool ('CASSA','RetCom',TRUE);
  Result := ReadBool ('CASSA','RetCom',TRUE);
end;

procedure TCasIni.SetDeskView (pValue:byte); // Zobrazit stoly
begin
  WriteInteger ('CASSA','DeskView',pValue);
end;

function TCasIni.GetDeskView:byte; // Zobrazit stoly
begin
  If not ValueExists ('CASSA','DeskView') then WriteInteger ('CASSA','DeskView',0);
  Result := ReadInteger ('CASSA','DeskView',0);
end;

procedure TCasIni.SetGsCumulate (pValue:boolean); // kumulovanie tovarovych poloziek s rovankym PLU na blocku
begin
  WriteBool ('CASSA','GsCumulate',pValue);
end;

function TCasIni.GetGsCumulate:boolean; // kumulovanie tovarovych poloziek s rovankym PLU na blocku
begin
  If not ValueExists ('CASSA','GsCumulate') then WriteBool ('CASSA','GsCumulate',False);
  Result := ReadBool ('CASSA','GsCumulate',False);
end;

procedure TCasIni.SetGsGridSlct (pValue:boolean); // vyber tovaru z mriezky
begin
  WriteBool ('CASSA','GsGridSlct',pValue);
end;

function TCasIni.GetGsGridSlct:boolean; // vyber tovaru z mriezky
begin
  If not ValueExists ('CASSA','GsGridSlct') then WriteBool ('CASSA','GsGridSlct',TRUE);
  Result := ReadBool ('CASSA','GsGridSlct',TRUE);
end;

function TCasIni.GetBlkNum: longint; // Cislo pokladnicneho dokladu
begin
  If not ValueExists ('CASSA','BlkNum') then WriteInteger ('CASSA','BlkNum',0);
  Result := ReadInteger ('CASSA','BlkNum',0);
end;

function TCasIni.GetStkNum: word; // Cislo pouziteho skladu
begin
  If not ValueExists ('CASSA','StkNum') then WriteInteger ('CASSA','StkNum',1);
  Result := ReadInteger ('CASSA','StkNum',1);
end;

function TCasIni.GetPlsNum: word; // Cislo pouziteho predajneho cennika
begin
  If not ValueExists ('CASSA','PlsNum') then WriteInteger ('CASSA','PlsNum',1);
  Result := ReadInteger ('CASSA','PlsNum',1);
end;

function TCasIni.GetCashBox:byte; // Typ otvorenia penaznej zasuvky
begin
  If not ValueExists ('CASSA','CashBox') then WriteInteger ('CASSA','CashBox',0);
  Result := ReadInteger ('CASSA','CashBox',0);
end;

function TCasIni.GetNulSal:boolean; // Povolenie predaja s nulovou predajnou cenou
begin
  If not ValueExists ('CASSA','NulSal') then WriteBool ('CASSA','NulSal',TRUE);
  Result := ReadBool ('CASSA','NulSal',TRUE);
end;

function TCasIni.GetUseCss:boolean; // Nacitanie stavu skaldu cez CSS
begin
  If not ValueExists ('CASSA','UseCss') then WriteBool ('CASSA','UseCss',False);
  Result := ReadBool ('CASSA','UseCss',False);
end;

function TCasIni.GetStkDet: byte; // Spôsob urcenia skladu vydaja
begin
  If not ValueExists ('CASSA','StkDet') then WriteInteger ('CASSA','StkDet',0);
  Result := ReadInteger ('CASSA','StkDet',0);
end;

function TCasIni.GetStkVer: byte; // Kontrola ci na skladu je dostatocne mnozstvo
begin
  If not ValueExists ('CASSA','StkVer') then WriteInteger ('CASSA','StkVer',0);
  Result := ReadInteger ('CASSA','StkVer',0);
end;

function TCasIni.GetDocRnd: byte; // Zaokruhlenie konecnej hodnoty s DPH pokladnicneho dokladu
begin
  If not ValueExists ('CASSA','DocRnd') then WriteInteger ('CASSA','DocRnd',0);
  Result := ReadInteger ('CASSA','DocRnd',0);
end;

function TCasIni.GetItmRnd: byte; // Zaokruhlenie hodnoty v PC s DPH polozky pokladnicneho dokladu
begin
  If not ValueExists ('CASSA','ItmRnd') then WriteInteger ('CASSA','ItmRnd',0);
  Result := ReadInteger ('CASSA','ItmRnd',0);
end;

function TCasIni.GetEcrNum: byte; // Cislo fisklanej pokladne
begin
  If not ValueExists ('CASSA','ErcNum') then WriteInteger ('CASSA','ErcNum',1);
  Result := ReadInteger ('CASSA','ErcNum',0);
end;

function TCasIni.GetBcsStat: integer; // Stav snimaca ciaroveho kodu
begin
  If not ValueExists ('CASSA','BcsStat') then WriteInteger ('CASSA','BcsStat',1);
  Result := ReadInteger ('CASSA','BcsStat',1);
end;

function TCasIni.GetBcsPort: Str4; // Cislo portu ktoremu je pripojeny snimac
begin
  If not ValueExists ('CASSA','BcsPort') then WriteString ('CASSA','BcsPort','COM1');
  Result := ReadString ('CASSA','BcsPort','COM1');
end;

function TCasIni.GetBcsBaud: Str5; // prenosova rychlost portu ciaroveho kodu
begin
  If not ValueExists ('CASSA','BcsBaud') then WriteString ('CASSA','BcsBaud','9600');
  Result := ReadString ('CASSA','BcsBaud','9600');
end;

function TCasIni.GetBcsData: Str1; // Pocet databytov prenosu portu snimaca ciaroveho kodu
begin
  If not ValueExists ('CASSA','BcsData') then WriteString ('CASSA','BcsData','7');
  Result := ReadString ('CASSA','BcsData','7');
end;

function TCasIni.GetBcsStop: Str1; // Pocet stop bytov prenosu portu snimaca ciaroveho kodu
begin
  If not ValueExists ('CASSA','BcsStop') then WriteString ('CASSA','BcsStop','1');
  Result := ReadString ('CASSA','BcsStop','1');
end;

function TCasIni.GetBcsParit: Str1; // Parita prenosu portu snimaca ciaroveho kodu
begin
  If not ValueExists ('CASSA','BcsParit') then WriteString ('CASSA','BcsParit','N');
  Result := ReadString ('CASSA','BcsParit','N');
end;

function TCasIni.GetDispType: integer; // Typ zakaznickeho displeya
begin
  If not ValueExists ('CASSA','DispType') then WriteInteger ('CASSA','DispType',0);
  Result := ReadInteger ('CASSA','DispType',0);
end;

function TCasIni.GetDispPort: Str4; // Cislo portu ktoremu je pripojeny snimac
begin
  If not ValueExists ('CASSA','DispPort') then WriteString ('CASSA','DispPort','COM1');
  Result := ReadString ('CASSA','DispPort','COM1');
end;

function TCasIni.GetWghPort: Str4; // Cislo portu ktoremu je pripojena vaha
begin
  If not ValueExists ('CASSA','WghPort') then WriteString ('CASSA','WghPort','COM1');
  Result := ReadString ('CASSA','WghPort','COM1');
end;

function TCasIni.GetWghBaud: Str5; // prenosova rychlost portu vahy
begin
  If not ValueExists ('CASSA','WghBaud') then WriteString ('CASSA','WghBaud','9600');
  Result := ReadString ('CASSA','WghBaud','9600');
end;

function TCasIni.GetWghData: Str1; // Pocet databytov prenosu portu vahy
begin
  If not ValueExists ('CASSA','WghData') then WriteString ('CASSA','WghData','8');
  Result := ReadString ('CASSA','WghData','8');
end;

function TCasIni.GetWghStop: Str1; // Pocet stop bytov prenosu portu vahy
begin
  If not ValueExists ('CASSA','WghStop') then WriteString ('CASSA','WghStop','1');
  Result := ReadString ('CASSA','WghStop','1');
end;

function TCasIni.GetWghParit: Str1; // Parita prenosu portu vahy
begin
  If not ValueExists ('CASSA','WghParit') then WriteString ('CASSA','WghParit','E');
  Result := ReadString ('CASSA','WghParit','E');
end;

function TCasIni.GetWghTara: boolean; // Znizenie vahy o vahu obalu
begin
  If not ValueExists ('CASSA','WghTara') then WriteBool ('CASSA','WghTara',False);
  Result := ReadBool ('CASSA','WghTara',False);
end;

function TCasIni.GetWghType: Str1; // Protokol pripojenej vahy
begin
  If not ValueExists ('CASSA','WghType') then WriteString ('CASSA','WghType','A');
  Result := ReadString ('CASSA','WghType','A');
end;

function TCasIni.GetSpdPayNum: byte; // Ciselny kod zalohovej platby v ERP
begin
  If not ValueExists ('CASSA','SpdPayNum') then WriteInteger ('CASSA','SpdPayNum',1);
  Result := ReadInteger ('CASSA','SpdPayNum',1);
end;

end.
