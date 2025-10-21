unit SysKey;

interface

uses
  IcTypes, IcConv, IcVariab, NexPath, NexGlob, NexIni, hKEYDEF,
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls,
  Dialogs, DB, NexBtrTable, DBTables, NexPxTable;

type
  TSysRec=record
    SavYer:Str2;
    RegName:Str60;       // Registrovan˝ n·zov vlastnÌka
    RegAddr:Str30;
    RegZip:Str15;
    RegCty:Str3;
    RegCtn:Str30;
    RegSta:Str2;
    RegStn:Str30;
    RegRec:Str80;
    RegWeb:Str50;
    HedName:Str30;
    FixCrs:double;
    InfDvz:Str3;
    AccDvz:Str3;
    MsuRnd:byte;
    MsuFrc:byte;
    GsnSrc:byte;
    AcvFrc:byte;
    FgpFrc:byte;
    FgvFrc:byte;
    NrdFrc:byte;
    FjrSig:boolean;
    SpeLev:boolean;
    PyeAdd:boolean;
    EdiSpc:boolean;
    EdiPce:boolean;
    TrvGsc:longint;
//    AdvGsc(pVatGrp:byte):longint;
  end;

  TSysKey=class (TComponent)
    constructor Create(phKEYDEF:TKeydefHnd);
    destructor  Destroy; override;
  private
    oLoaded:boolean;
    oSysRec:TSysRec;
    ohKEYDEF:TKeydefHnd;
    procedure LoadVerify;
    function ReadSavYer:Str2;       procedure WriteSavYer(pValue:Str2);
    function ReadRegName:Str60;     procedure WriteRegName(pValue:Str60);
    function ReadRegAddr:Str30;     procedure WriteRegAddr(pValue:Str30);
    function ReadRegZip:Str15;      procedure WriteRegZip(pValue:Str15);
    function ReadRegCty:Str3;       procedure WriteRegCty(pValue:Str3);
    function ReadRegCtn:Str30;      procedure WriteRegCtn(pValue:Str30);
    function ReadRegSta:Str2;       procedure WriteRegSta(pValue:Str2);
    function ReadRegStn:Str30;      procedure WriteRegStn(pValue:Str30);
    function ReadRegRec:Str80;      procedure WriteRegRec(pValue:Str80);
    function ReadRegWeb:Str50;      procedure WriteRegWeb(pValue:Str50);
    function ReadHedName:Str30;     procedure WriteHedName(pValue:Str30);
    function ReadFixCrs:double;     procedure WriteFixCrs(pValue:double);
    function ReadInfDvz:Str3;       procedure WriteInfDvz(pValue:Str3);
    function ReadAccDvz:Str3;       procedure WriteAccDvz(pValue:Str3);
    function ReadMsuRnd:byte;       procedure WriteMsuRnd(pValue:byte);
    function ReadMsuFrc:byte;       procedure WriteMsuFrc(pValue:byte);
    function ReadGsnSrc:byte;       procedure WriteGsnSrc(pValue:byte);
    function ReadAcvFrc:byte;       procedure WriteAcvFrc(pValue:byte);
    function ReadFgpFrc:byte;       procedure WriteFgpFrc(pValue:byte);
    function ReadFgvFrc:byte;       procedure WriteFgvFrc(pValue:byte);
    function ReadNrdFrc:byte;       procedure WriteNrdFrc(pValue:byte);
    function ReadFjrSig:boolean;    procedure WriteFjrSig(pValue:boolean);
    function ReadSpeLev:boolean;    procedure WriteSpeLev(pValue:boolean);
    function ReadPyeAdd:boolean;    procedure WritePyeAdd(pValue:boolean);
    function ReadEdiSpc:boolean;    procedure WriteEdiSpc(pValue:boolean);
    function ReadEdiPce:boolean;    procedure WriteEdiPce(pValue:boolean);
    function ReadTrvGsc:longint;    procedure WriteTrvGsc(pValue:longint);
    function ReadUsrCnt:word;       procedure WriteUsrCnt(pValue:word);

///    procedure WriteAdvGsc(pVatGrp:byte;pValue:longint);
  public
    function NextUsrNum:word;
    procedure LoadKeys;  // Nacita parametre do pamate

    property SavYer:Str2 read ReadSavYer write WriteSavYer;      // Posledn˝ oddelen˝ rok
    property RegName:Str60 read ReadRegName write WriteRegName;
    property RegAddr:Str30 read ReadRegAddr write WriteRegAddr;  // Registrovan· adresa vlastnÌka
    property RegZip:Str15 read ReadRegZip write WriteRegZip;     // PS» registrovaej adersy vlastnÌka
    property RegCty:Str3 read ReadRegCty write WriteRegCty;      // KÛd mesta registrovanej adresy vlastnÌka
    property RegCtn:Str30 read ReadRegCtn write WriteRegCtn;     // N·zov mesta registrovanej adresy vlastnÌka
    property RegSta:Str2 read ReadRegSta write WriteRegSta;      // N·zov öt·tu registrovanej adresy vlastnÌka
    property RegStn:Str30 read ReadRegStn write WriteRegStn;     // N·zov öt·tu registrovanej adresy vlastnÌka
    property RegRec:Str80 read ReadRegRec write WriteRegRec;     // Za·znam vobchodnom registri
    property RegWeb:Str50 read ReadRegWeb write WriteRegWeb;     // Internetov· domov· str·vka vlastnÌka
    property HedName:Str30 read ReadHedName write WriteHedName;  // Konateæ alebo majiteæ spoloùnosti
    property FixCrs:double read ReadFixCrs write WriteFixCrs;    // Konverzny kurz na EUR prechod
    property InfDvz:Str3 read ReadInfDvz write WriteInfDvz;      // INFO mena na EUR prechod
    property AccDvz:Str3 read ReadAccDvz write WriteAccDvz;      // Uctovna mena
    property MsuRnd:byte read ReadMsuRnd write WriteMsuRnd;      // Sposob zaokruhlenia mernej ceny
    property MsuFrc:byte read ReadMsuFrc write WriteMsuFrc;      // Pocetdesatinnych miest zaokruhlenia mernej ceny
    property GsnSrc:byte read ReadGsnSrc write WriteGsnSrc;      // Vyhladavanie tovaru podla casti nazvu: 0-zrychlene; 1-sekvencialne
    property AcvFrc:byte read ReadAcvFrc write WriteAcvFrc;      // Pocet desatinnych miest zaokruhlenia hodnoty riadku dokladu v uctovnej mene
    property FgpFrc:byte read ReadFgpFrc write WriteFgpFrc;      // Pocet desatinnych miest zaokruhlenia jednotkovej ceny riadku dokladu vo vyuctovnej mene
    property FgvFrc:byte read ReadFgvFrc write WriteFgvFrc;      // Pocet desatinnych miest zaokruhlenia hodnoty  riadku dokladu vo vyuctovnej mene
    property NrdFrc:byte read ReadNrdFrc write WriteNrdFrc;      // Pocet desatinnych miest pre hodnoty, ktore nie su zaokruhlene
    property FjrSig:boolean read ReadFjrSig write WriteFjrSig;   // Generovaù peÚaûn˝ dennÌk podæa znamienka ˙hradu (TRUE); podæa typu fakt˙ry (FALSE)
    property SpeLev:boolean read ReadSpeLev write WriteSpeLev;   // Povolit pouzitie viacerych cenovych hladin
    property PyeAdd:boolean read ReadPyeAdd write WritePyeAdd;   // Povolit pridavanie dokladov do knih predhcadzajucich rokov
    property EdiSpc:boolean read ReadEdiSpc write WriteEdiSpc;   // Identifikatorom pre medizfiremnu komunikaciu je öpecifikaËn˝ kÛd
    property EdiPce:boolean read ReadEdiPce write WriteEdiPce;   // Prenos doporuËenej (cennÌkovej) predajnej ceny
    property TrvGsc:longint read ReadTrvGsc write WriteTrvGsc;   // PLU poloûky dopravn˝ch n·kladov
    property UsrCnt:word read ReadUsrCnt write WriteUsrCnt;      // PoËÌtadlo uûÌvateæov systÈmu
//    property AdvGsc[pVatGrp:byte]:longint read oSys.AdvGsc write WriteAdvGsc; // PLU prijmu zalohovej platby
  end;

implementation

constructor TSysKey.Create(phKEYDEF:TKeydefHnd);
begin
  oLoaded:=FALSE;
  ohKEYDEF:=phKEYDEF;
end;

destructor TSysKey.Destroy;
begin
end;

// *************************************** PRIVATE ********************************************

procedure TSysKey.LoadKeys;
begin
  oLoaded:=TRUE;
  oSysRec.SavYer:=ohKEYDEF.ReadString('SYS','','SavYer','16'); 
  oSysRec.RegName:=ohKEYDEF.ReadString('SYS','','RegName','');
  oSysRec.RegAddr:=ohKEYDEF.ReadString('SYS','','RegAddr','');
  oSysRec.RegZip:=ohKEYDEF.ReadString('SYS','','RegZip','');
  oSysRec.RegCty:=ohKEYDEF.ReadString('SYS','','RegCty','');
  oSysRec.RegCtn:=ohKEYDEF.ReadString('SYS','','RegCtn','');
  oSysRec.RegSta:=ohKEYDEF.ReadString('SYS','','RegSta','');
  oSysRec.RegStn:=ohKEYDEF.ReadString('SYS','','RegStn','');
  oSysRec.RegRec:=ohKEYDEF.ReadString('SYS','','RegRec','');
  oSysRec.RegWeb:=ohKEYDEF.ReadString('SYS','','RegWeb','');
  oSysRec.HedName:=ohKEYDEF.ReadString('SYS','','HedName','');
  oSysRec.FixCrs:=ohKEYDEF.ReadFloat('SYS','','FixCrs',0,4);
  oSysRec.InfDvz:=ohKEYDEF.ReadString('SYS','','InfDvz','');
  oSysRec.AccDvz:=ohKEYDEF.ReadString('SYS','','AccDvz','');
(*
  oSysRec.MsuRnd:=ohKEYDEF.ReadString('SYS','','X','');
  oSysRec.MsuFrc:=ohKEYDEF.ReadString('SYS','','X','');
  oSysRec.GsnSrc:=ohKEYDEF.ReadString('SYS','','X','');
  oSysRec.AcvFrc:=ohKEYDEF.ReadString('SYS','','X','');
  oSysRec.FgpFrc:=ohKEYDEF.ReadString('SYS','','X','');
  oSysRec.FgvFrc:=ohKEYDEF.ReadString('SYS','','X','');
  oSysRec.NrdFrc:=ohKEYDEF.ReadString('SYS','','X','');
  oSysRec.FjrSig:=ohKEYDEF.ReadString('SYS','','X','');
  oSysRec.SpeLev:=ohKEYDEF.ReadString('SYS','','X','');
  oSysRec.PyeAdd:=ohKEYDEF.ReadString('SYS','','X','');
  oSysRec.EdiSpc:=ohKEYDEF.ReadString('SYS','','X','');
  oSysRec.EdiPce:=ohKEYDEF.ReadString('SYS','','X','');
*)
end;

// ********************************* PUBLIC ************************************

// ********************************** SYS *************************************

procedure TSysKey.LoadVerify;
begin
  If not oLoaded then LoadKeys;
end;

function TSysKey.ReadSavYer:Str2;
begin
  LoadVerify;
  Result:=oSysRec.SavYer;
end;

procedure TSysKey.WriteSavYer(pValue:Str2);
begin
  ohKEYDEF.WriteString ('SYS','','SavYer',pValue);
end;

function TSysKey.ReadRegName:Str60;
begin
  LoadVerify;
  Result:=oSysRec.RegName;
end;

procedure TSysKey.WriteRegName(pValue:Str60);
begin
  ohKEYDEF.WriteString ('SYS','','RegName',pValue);
end;

function TSysKey.ReadRegAddr:Str30;
begin
  LoadVerify;
  Result:=oSysRec.RegAddr;
end;

procedure TSysKey.WriteRegAddr(pValue:Str30);
begin
end;

function TSysKey.ReadRegZip:Str15;
begin
  LoadVerify;
  Result:=oSysRec.RegZip;
end;

procedure TSysKey.WriteRegZip(pValue:Str15);
begin
end;

function TSysKey.ReadRegCty:Str3;
begin
  LoadVerify;
  Result:=oSysRec.RegCty;
end;

procedure TSysKey.WriteRegCty(pValue:Str3);
begin
end;

function TSysKey.ReadRegCtn:Str30;
begin
  LoadVerify;
  Result:=oSysRec.RegCtn;
end;

procedure TSysKey.WriteRegCtn(pValue:Str30);
begin
end;

function TSysKey.ReadRegSta:Str2;
begin
  LoadVerify;
  Result:=oSysRec.RegSta;
end;

procedure TSysKey.WriteRegSta(pValue:Str2);
begin
end;

function TSysKey.ReadRegStn:Str30;
begin
  LoadVerify;
  Result:=oSysRec.RegStn;
end;

procedure TSysKey.WriteRegStn(pValue:Str30);
begin
end;

function TSysKey.ReadRegRec:Str80;
begin
  LoadVerify;
  Result:=oSysRec.RegRec;
end;

procedure TSysKey.WriteRegRec(pValue:Str80);
begin
end;

function TSysKey.ReadRegWeb:Str50;
begin
  LoadVerify;
  Result:=oSysRec.RegWeb;
end;

procedure TSysKey.WriteRegWeb(pValue:Str50);
begin
end;

function TSysKey.ReadHedName:Str30;
begin
  LoadVerify;
  Result:=oSysRec.HedName;
end;

procedure TSysKey.WriteHedName(pValue:Str30);
begin
end;

function TSysKey.ReadFixCrs:double;
begin
  LoadVerify;
  Result:=oSysRec.FixCrs;
end;

procedure TSysKey.WriteFixCrs(pValue:double);
begin
  ohKEYDEF.WriteFloat('SYS','','SysFixCrs',pValue,4);
end;

function TSysKey.ReadInfDvz:Str3;
begin
  LoadVerify;
  Result:=oSysRec.InfDvz;
end;

procedure TSysKey.WriteInfDvz(pValue:Str3);
begin
  ohKEYDEF.WriteString('SYS','','SysInfDvz',pValue);
end;

function TSysKey.ReadAccDvz:Str3;
begin
  LoadVerify;
  Result:=oSysRec.AccDvz;
  If Result='' then Result:='EUR';
end;

procedure TSysKey.WriteAccDvz(pValue:Str3);
begin
  ohKEYDEF.WriteString('SYS','','SysAccDvz',pValue);
end;

function TSysKey.ReadMsuRnd:byte;
begin
  LoadVerify;
  Result:=oSysRec.MsuRnd;
end;

procedure TSysKey.WriteMsuRnd(pValue:byte);
begin
  ohKEYDEF.WriteInteger('SYS','','SysMsuRnd',pValue);
end;

function TSysKey.ReadMsuFrc:byte;
begin
  LoadVerify;
  Result:=oSysRec.MsuFrc;
end;

procedure TSysKey.WriteMsuFrc(pValue:byte);
begin
  ohKEYDEF.WriteInteger('SYS','','SysMsuFrc',pValue);
end;

function TSysKey.ReadGsnSrc:byte;
begin
  LoadVerify;
  Result:=oSysRec.GsnSrc;
end;

procedure TSysKey.WriteGsnSrc(pValue:byte);
begin
  ohKEYDEF.WriteInteger('SYS','','SysGsnSrc',pValue);
end;

function TSysKey.ReadAcvFrc:byte;
begin
  LoadVerify;
  Result:=oSysRec.AcvFrc;
end;

procedure TSysKey.WriteAcvFrc(pValue:byte);
begin
  ohKEYDEF.WriteInteger('SYS','','SysAcvFrc',pValue);
end;

function TSysKey.ReadFgpFrc:byte;
begin
  LoadVerify;
  Result:=oSysRec.FgpFrc;
end;

procedure TSysKey.WriteFgpFrc(pValue:byte);
begin
  ohKEYDEF.WriteInteger('SYS','','SysFgpFrc',pValue);
end;

function TSysKey.ReadFgvFrc:byte;
begin
  LoadVerify;
  Result:=oSysRec.FgvFrc;
end;

procedure TSysKey.WriteFgvFrc(pValue:byte);
begin
  ohKEYDEF.WriteInteger('SYS','','SysFgvFrc',pValue);
end;

function TSysKey.ReadNrdFrc:byte;
begin
  LoadVerify;
  Result:=oSysRec.NrdFrc;
end;

procedure TSysKey.WriteNrdFrc(pValue:byte);
begin
  ohKEYDEF.WriteInteger('SYS','','SysNrdFrc',pValue);
end;

function TSysKey.ReadFjrSig:boolean;
begin
  LoadVerify;
  Result:=oSysRec.FjrSig;
end;

procedure TSysKey.WriteFjrSig(pValue:boolean);
begin
  ohKEYDEF.WriteBoolean('SYS','','SysFjrSig',pValue);
end;

function TSysKey.ReadSpeLev:boolean;
begin
  LoadVerify;
  Result:=oSysRec.SpeLev;
end;

procedure TSysKey.WriteSpeLev(pValue:boolean);
begin
  ohKEYDEF.WriteBoolean('SYS','','SysSpeLev',pValue);
end;

function TSysKey.ReadPyeAdd:boolean;
begin
  LoadVerify;
  Result:=oSysRec.PyeAdd;
end;

procedure TSysKey.WritePyeAdd(pValue:boolean);
begin
  ohKEYDEF.WriteBoolean('SYS','','SysPyeAdd',pValue);
end;

function TSysKey.ReadEdiSpc:boolean;
begin
  LoadVerify;
  Result:=oSysRec.EdiSpc;
end;

procedure TSysKey.WriteEdiSpc(pValue:boolean);
begin
  ohKEYDEF.WriteBoolean('SYS','','SysEdiSpc',pValue);
end;

function TSysKey.ReadEdiPce:boolean;
begin
  LoadVerify;
  Result:=oSysRec.EdiPce;
end;

procedure TSysKey.WriteEdiPce(pValue:boolean);
begin
  ohKEYDEF.WriteBoolean('SYS','','SysEdiPce',pValue);
end;

function TSysKey.ReadTrvGsc:longint;
begin
  Result:=ohKEYDEF.ReadInteger('SYS','','TrvGsc',0);
end;

procedure TSysKey.WriteTrvGsc(pValue:longint);
begin
  ohKEYDEF.WriteInteger('SYS','','TrvGsc',pValue);
end;

function TSysKey.ReadUsrCnt:word;
begin
  Result:=ohKEYDEF.ReadInteger('SYS','','UsrCnt',0);
end;

procedure TSysKey.WriteUsrCnt(pValue:word);
begin
  ohKEYDEF.WriteInteger('SYS','','UsrCnt',pValue);
end;

function TSysKey.NextUsrNum:word;
begin
  Result:=UsrCnt+1;
  UsrCnt:=Result;
end;

(*
procedure TSysKey.WriteSysAdvGsc(pVatGrp:byte;pValue:longint);
begin
  WriteString ('SYS',StrIntZero(pVatGrp,2),'SysAdvGsc',StrInt(pValue,0))
end;
*)

end.


