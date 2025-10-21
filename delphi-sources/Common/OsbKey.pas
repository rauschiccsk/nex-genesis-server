unit OsbKey;

interface

uses
  IcTypes, IcConv, IcVariab, NexPath, NexGlob, NexIni, hKEYDEF,
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls,
  Dialogs, DB, NexBtrTable, DBTables, NexPxTable;

type
  TOsbKey = class (TComponent)
    constructor Create(phKEYDEF:TKeydefHnd);
    destructor  Destroy; override;
  private
    ohKEYDEF:TKeydefHnd;
    function ReadChgTxt:Str60;    procedure WriteChgTxt(pValue:Str60);
    function ReadCnfTxt:Str60;    procedure WriteCnfTxt(pValue:Str60);
    function ReadChgFil:Str60;    procedure WriteChgFil(pValue:Str60);
    function ReadCnfFil:Str60;    procedure WriteCnfFil(pValue:Str60);
    function ReadProDay:integer;    procedure WriteProDay(pValue:integer);
    function ReadBokDvz(pBokNum:Str5):Str3;       procedure WriteBokDvz(pBokNum:Str5;pValue:Str3);
    function ReadCumPrn(pBokNum:Str5):boolean;    procedure WriteCumPrn(pBokNum:Str5;pValue:boolean);
    function ReadBcsStk(pBokNum:Str5):Str60;      procedure WriteBcsStk(pBokNum:Str5;pValue:Str60);
    function ReadWriNum(pBokNum:Str5):word;       procedure WriteWriNum(pBokNum:Str5;pValue:word);
    function ReadStkNum(pBokNum:Str5):word;       procedure WriteStkNum(pBokNum:Str5;pValue:word);
    function ReadVatRnd(pBokNum:Str5):byte;       procedure WriteVatRnd(pBokNum:Str5;pValue:byte);
    function ReadValRnd(pBokNum:Str5):byte;       procedure WriteValRnd(pBokNum:Str5;pValue:byte);
    function ReadExnFrm(pBokNum:Str5):Str12;      procedure WriteExnFrm(pBokNum:Str5;pValue:Str12);
    function ReadPabNum(pBokNum:Str5):word;       procedure WritePabNum(pBokNum:Str5;pValue:word);
    function ReadTsdBok(pBokNum:Str5):Str5;       procedure WriteTsdBok(pBokNum:Str5;pValue:Str5);
    function ReadIsdBok(pBokNum:Str5):Str5;       procedure WriteIsdBok(pBokNum:Str5;pValue:Str5);
    function ReadAvgClc(pBokNum:Str5):byte;       procedure WriteAvgClc(pBokNum:Str5;pValue:byte);
    function ReadAvgMth(pBokNum:Str5):byte;       procedure WriteAvgMth(pBokNum:Str5;pValue:byte);
    function ReadOrdCoe(pBokNum:Str5):double;     procedure WriteOrdCoe(pBokNum:Str5;pValue:double);
    function ReadShared(pBokNum:Str5):byte;       procedure WriteShared(pBokNum:Str5;pValue:byte);
    function ReadSndTyp(pBokNum:Str5):byte;       procedure WriteSndTyp(pBokNum:Str5;pValue:byte);
    function ReadDefPac(pBokNum:Str5):longint;    procedure WriteDefPac(pBokNum:Str5;pValue:longint);
    function ReadItcDef(pBokNum:Str5):integer;    procedure WriteItcDef(pBokNum:Str5;pValue:integer);
    function ReadItcDlv(pBokNum:Str5):integer;    procedure WriteItcDlv(pBokNum:Str5;pValue:integer);
    function ReadItcTrm(pBokNum:Str5):integer;    procedure WriteItcTrm(pBokNum:Str5;pValue:integer);
    function ReadItcWgh(pBokNum:Str5):integer;    procedure WriteItcWgh(pBokNum:Str5;pValue:integer);
  public
    property CnfTxt:Str60 read ReadCnfTxt write WriteCnfTxt;  // Text Potvrdenia terminu dodavky
    property ChgTxt:Str60 read ReadChgTxt write WriteChgTxt;  // Text Zmena terminu dodavky
    property CnfFil:Str60 read ReadCnfFil write WriteCnfFil;  // Text Potvrdenia terminu dodavky
    property ChgFil:Str60 read ReadChgFil write WriteChgFil;  // Text Zmena terminu dodavky
    property ProDay:integer read ReadProDay write WriteProDay;  // Pocet dni prijata objednavky na sklad
    property BokDvz[pBokNum:Str5]:Str3      read ReadBokDvz write WriteBokDvz;  // Mena danej knihy
    property CumPrn[pBokNum:Str5]:boolean   read ReadCumPrn write WriteCumPrn;  // Kumulativna tlac poloziek dodavatelskej objednavky
    property BcsStk[pBokNum:Str5]:Str60     read ReadBcsStk write WriteBcsStk;  // Sklady pre kontrolu stavu pri automatickom generovani objednavok
    property WriNum[pBokNum:Str5]:word      read ReadWriNum write WriteWriNum;  // Cislo prevadzkovej jednotky (0-centrala, ostane cisla prevadzky)
    property StkNum[pBokNum:Str5]:word      read ReadStkNum write WriteStkNum;  // Základné nastavenie použitého skladu
    property VatRnd[pBokNum:Str5]:byte      read ReadVatRnd write WriteVatRnd;  // Typ zaokrúhlenia DPH z PC
    property ValRnd[pBokNum:Str5]:byte      read ReadValRnd write WriteValRnd;  // Typ zaokrúhlenia PC s DPH
    property ExnFrm[pBokNum:Str5]:Str12     read ReadExnFrm write WriteExnFrm;  // Format generovania externeho cisla
    property PabNum[pBokNum:Str5]:word      read ReadPabNum write WritePabNum;  // Èíslo knihy obchodných partnerov - dodavatelia
    property TsdBok[pBokNum:Str5]:Str5      read ReadTsdBok write WriteTsdBok;  // Èíslo knihy dodavatelskych dodacich listov
    property IsdBok[pBokNum:Str5]:Str5      read ReadIsdBok write WriteIsdBok;  // Èíslo knihy dodavatelskych FA
    property AvgClc[pBokNum:Str5]:byte      read ReadAvgClc write WriteAvgClc;  // Sposob vypoctu priemerneho mesacneho mnozstva vydajov
    property AvgMth[pBokNum:Str5]:byte      read ReadAvgMth write WriteAvgMth;  // Pocet mesiacov, z ktorych sa vypocita priemerne mnozstvo
    property OrdCoe[pBokNum:Str5]:double    read ReadOrdCoe write WriteOrdCoe;  // Koeficient vìpoctu objednacieho mnozstva
    property Shared[pBokNum:Str5]:byte      read ReadShared write WriteShared;  // Priznak zdielania sklad - zmeny su odoslane cez FTP (1-zdileany)
    property SndTyp[pBokNum:Str5]:byte      read ReadSndTyp write WriteSndTyp;  // Elektronicky prenos dokladov (0-vseobecny,1-specialny)
    property DefPac[pBokNum:Str5]:longint   read ReadDefPac write WriteDefPac;  // Kod dodavatela - ak cela kniha je vyhradena pre jedneho dodavatela
    property ItcDef[pBokNum:Str5]:integer   read ReadItcDef write WriteItcDef;  // Základná farba položiek
    property ItcDlv[pBokNum:Str5]:integer   read ReadItcDlv write WriteItcDlv;  // Dodané položky
    property ItcTrm[pBokNum:Str5]:integer   read ReadItcTrm write WriteItcTrm;  // Zadaný termín dodávky
    property ItcWgh[pBokNum:Str5]:integer   read ReadItcWgh write WriteItcWgh;  // Chýbajúca váha
  end;
implementation

constructor TOsbKey.Create(phKEYDEF:TKeydefHnd);
begin
  ohKEYDEF := phKEYDEF;
end;

destructor TOsbKey.Destroy;
begin
end;

// ******************************** PRIVATE ************************************

function TOsbKey.ReadCnfTxt:Str60;
begin
  Result := ohKEYDEF.ReadString('OSB','','CnfTxt','Potvrdenie terminu dodavky');
end;

procedure TOsbKey.WriteCnfTxt(pValue:Str60);
begin
  ohKEYDEF.WriteString('OSB','','CnfTxt',pValue);
end;

function TOsbKey.ReadChgTxt:Str60;
begin
  Result := ohKEYDEF.ReadString('OSB','','ChgTxt','Zmena terminu dodavky');
end;

procedure TOsbKey.WriteChgTxt(pValue:Str60);
begin
  ohKEYDEF.WriteString('OSB','','ChgTxt',pValue);
end;

function TOsbKey.ReadCnfFil:Str60;
begin
  Result := ohKEYDEF.ReadString('OSB','','CnfFil','');
end;

procedure TOsbKey.WriteCnfFil(pValue:Str60);
begin
  ohKEYDEF.WriteString('OSB','','CnfFil',pValue);
end;

function TOsbKey.ReadChgFil:Str60;
begin
  Result := ohKEYDEF.ReadString('OSB','','ChgFil','');
end;

procedure TOsbKey.WriteChgFil(pValue:Str60);
begin
  ohKEYDEF.WriteString('OSB','','ChgFil',pValue);
end;

function TOsbKey.ReadProDay:integer;
begin
  Result := ohKEYDEF.ReadInteger('OSB','','ProDay',0);
end;

procedure TOsbKey.WriteProDay(pValue:integer);
begin
  ohKEYDEF.WriteInteger('OSB','','ProDay',pValue);
end;

function TOsbKey.ReadBokDvz(pBokNum:Str5):Str3;
begin
  Result := ohKEYDEF.ReadString('OSB',pBokNum,'BokDvz','EUR');
end;

procedure TOsbKey.WriteBokDvz(pBokNum:Str5;pValue:Str3);
begin
  ohKEYDEF.WriteString('OSB',pBokNum,'BokDvz',pValue);
end;

function TOsbKey.ReadBcsStk(pBokNum:Str5):Str60;
begin
  Result := ohKEYDEF.ReadString('OSB',pBokNum,'BcsStk','');
end;

procedure TOsbKey.WriteBcsStk(pBokNum:Str5;pValue:Str60);
begin
  ohKEYDEF.WriteString('OSB',pBokNum,'BcsStk',pValue);
end;

function TOsbKey.ReadCumPrn(pBokNum:Str5):boolean;
begin
  Result := ohKEYDEF.ReadBoolean('OSB',pBokNum,'CumPrn',FALSE);
end;

procedure TOsbKey.WriteCumPrn(pBokNum:Str5;pValue:boolean);
begin
  ohKEYDEF.WriteBoolean('OSB',pBokNum,'CumPrn',pValue);
end;

// ********************************* PUBLIC ************************************

function TOsbKey.ReadAvgClc(pBokNum: Str5): byte;
begin
  Result := ohKEYDEF.ReadInteger('OSB',pBokNum,'AvgClc',0);
end;

procedure TOsbKey.WriteAvgClc(pBokNum: Str5; pValue: byte);
begin
  ohKEYDEF.WriteInteger('OSB',pBokNum,'AvgClc',pValue);
end;

function TOsbKey.ReadAvgMth(pBokNum: Str5): byte;
begin
  Result := ohKEYDEF.ReadInteger('OSB',pBokNum,'AvgMth',0);
end;

procedure TOsbKey.WriteAvgMth(pBokNum: Str5; pValue: byte);
begin
  ohKEYDEF.WriteInteger('OSB',pBokNum,'AvgMth',pValue);
end;

function TOsbKey.ReadDefPac(pBokNum: Str5): longint;
begin
  Result := ohKEYDEF.ReadInteger('OSB',pBokNum,'DefPac',0);
end;

procedure TOsbKey.WriteDefPac(pBokNum: Str5; pValue: Integer);
begin
  ohKEYDEF.WriteInteger('OSB',pBokNum,'DefPac',pValue);
end;

function TOsbKey.ReadExnFrm(pBokNum: Str5): Str12;
begin
  Result := ohKEYDEF.ReadString('OSB',pBokNum,'ExnFrm','yybbbddddd');
end;

procedure TOsbKey.WriteExnFrm(pBokNum: Str5; pValue: Str12);
begin
  ohKEYDEF.WriteString('OSB',pBokNum,'ExnFrm',pValue);
end;

function TOsbKey.ReadOrdCoe(pBokNum: Str5): double;
begin
  Result := ohKEYDEF.ReadFloat('OSB',pBokNum,'OrdCoe',0,3);
end;

procedure TOsbKey.WriteOrdCoe(pBokNum: Str5; pValue: double);
begin
  ohKEYDEF.WriteFloat('OSB',pBokNum,'OrdCoe',pValue,3);
end;

function TOsbKey.ReadPabNum(pBokNum: Str5): word;
begin
  Result := ohKEYDEF.ReadInteger('OSB',pBokNum,'PabNum',0);
end;

procedure TOsbKey.WritePabNum(pBokNum: Str5; pValue: word);
begin
  ohKEYDEF.WriteInteger('OSB',pBokNum,'PabNum',pValue);
end;

function TOsbKey.ReadShared(pBokNum: Str5): byte;
begin
  Result := ohKEYDEF.ReadInteger('OSB',pBokNum,'Shared',0);
end;

procedure TOsbKey.WriteShared(pBokNum: Str5; pValue: byte);
begin
  ohKEYDEF.WriteInteger('OSB',pBokNum,'Shared',pValue);
end;

function TOsbKey.ReadSndTyp(pBokNum: Str5): byte;
begin
  Result := ohKEYDEF.ReadInteger('OSB',pBokNum,'SndTyp',0);
end;

procedure TOsbKey.WriteSndTyp(pBokNum: Str5; pValue: byte);
begin
  ohKEYDEF.WriteInteger('OSB',pBokNum,'SndTyp',pValue);
end;

function TOsbKey.ReadStkNum(pBokNum: Str5): word;
begin
  Result := ohKEYDEF.ReadInteger('OSB',pBokNum,'StkNum',0);
end;

procedure TOsbKey.WriteStkNum(pBokNum: Str5; pValue: word);
begin
  ohKEYDEF.WriteInteger('OSB',pBokNum,'StkNum',pValue);
end;

function TOsbKey.ReadTsdBok(pBokNum: Str5): Str5;
begin
  Result := ohKEYDEF.ReadString('OSB',pBokNum,'TsdBok','');
end;

procedure TOsbKey.WriteTsdBok(pBokNum, pValue: Str5);
begin
  ohKEYDEF.WriteString('OSB',pBokNum,'TsdBok',pValue);
end;

function TOsbKey.ReadIsdBok(pBokNum: Str5): Str5;
begin
  Result := ohKEYDEF.ReadString('OSB',pBokNum,'IsdBok','');
end;

procedure TOsbKey.WriteIsdBok(pBokNum, pValue: Str5);
begin
  ohKEYDEF.WriteString('OSB',pBokNum,'IsdBok',pValue);
end;

function TOsbKey.ReadValRnd(pBokNum: Str5): byte;
begin
  Result := ohKEYDEF.ReadInteger('OSB',pBokNum,'ValRnd',0);
end;

procedure TOsbKey.WriteValRnd(pBokNum: Str5; pValue: byte);
begin
  ohKEYDEF.WriteInteger('OSB',pBokNum,'ValRnd',pValue);
end;

function TOsbKey.ReadVatRnd(pBokNum: Str5): byte;
begin
  Result := ohKEYDEF.ReadInteger('OSB',pBokNum,'VatRnd',0);
end;

procedure TOsbKey.WriteVatRnd(pBokNum: Str5; pValue: byte);
begin
  ohKEYDEF.WriteInteger('OSB',pBokNum,'VatRnd',pValue);
end;

function TOsbKey.ReadWriNum(pBokNum: Str5): word;
begin
  Result := ohKEYDEF.ReadInteger('OSB',pBokNum,'WriNum',0);
end;

procedure TOsbKey.WriteWriNum(pBokNum: Str5; pValue: word);
begin
  ohKEYDEF.WriteInteger('OSB',pBokNum,'WriNum',pValue);
end;

function TOsbKey.ReadItcDef(pBokNum: Str5): integer;
begin
  Result := ohKEYDEF.Readinteger('OSB',pBokNum,'ItcDef',$000000);
end;

procedure TOsbKey.WriteItcDef(pBokNum: Str5; pValue: integer);
begin
  ohKEYDEF.WriteInteger('OSB',pBokNum,'ItcDef',pValue);
end;

function TOsbKey.ReadItcDlv(pBokNum: Str5): integer;
begin
  Result := ohKEYDEF.Readinteger('OSB',pBokNum,'ItcDlv',$C0C0C0);
end;

procedure TOsbKey.WriteItcDlv(pBokNum: Str5; pValue: integer);
begin
  ohKEYDEF.WriteInteger('OSB',pBokNum,'ItcDlv',pValue);   
end;

function TOsbKey.ReadItcTrm(pBokNum: Str5): integer;
begin
  Result := ohKEYDEF.Readinteger('OSB',pBokNum,'ItcTrm',$008000);
end;

procedure TOsbKey.WriteItcTrm(pBokNum: Str5; pValue: integer);
begin
  ohKEYDEF.WriteInteger('OSB',pBokNum,'ItcTrm',pValue);
end;

function TOsbKey.ReadItcWgh(pBokNum: Str5): integer;
begin
  Result := ohKEYDEF.Readinteger('OSB',pBokNum,'ItcWgh',$000000);
end;

procedure TOsbKey.WriteItcWgh(pBokNum: Str5; pValue: integer);
begin
  ohKEYDEF.WriteInteger('OSB',pBokNum,'ItcWgh',pValue);   
end;

end.
{MOD 1901015}

