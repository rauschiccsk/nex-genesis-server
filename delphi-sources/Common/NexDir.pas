unit NexDir;

interface

uses
  IcTypes, IcVariab, IcConv,
  Windows, SysUtils, Forms, Classes;

type
  TNexDir=class
    constructor Create;
  public
    function NexDir:ShortString;  // Adresar informa�n�ho syst�mu
    function ActYer:ShortString;  // Adresar aktualneho roka YEARACT
    // ------------------------------- NEX -------------------------------------
    function Archiv:ShortString;  // Adres�r archivovanych �dajov
    function BckUpd:ShortString;  // Adres�r aktualiza�n�ch z�loh
    function ExpDat:ShortString;  // Adresar exportovan�ch s�borov
    function ImpDat:ShortString;  // Adresar importovan�ch s�borov
    function NexDat:ShortString;  // Adres�r datov�ch s�borov
    function SysDat:ShortString;  // Adres�r syst�mov�ch �dajov
    // ------------------------------ ARCHIV -----------------------------------
    function DocArc:ShortString;  // Adres�r archivovan�ch dokumentov
    function EmlArc:ShortString;  // Adres�r archivovan�ch emailov
    function PdfArc:ShortString;  // Adres�r archivovan�ch PDF s�borov
    // ------------------------------ NEXDAT -----------------------------------
    function CasDat(pCasNum:word):ShortString; // Adres�r �dajov zadanej pokladne
    function FatDat:ShortString;  // Adres�r pr�lohov�ch s�borov
    function ImgDat:ShortString;  // Adres�r obrazkov u��vate�a
    // ------------------------------ SYSDAT -----------------------------------
    function DefDat:ShortString;  // Adres�r DDF s�borov
    function DgdDat:ShortString;  // Adres�r DGD s�borov
    function LogDat:ShortString;  // Adres�r LOG s�borov
    function RepDat:ShortString;  // Adres�r tlacov�ch �abl�nov
    function SetDat:ShortString;  // Adres�r u��vate�sk�ch nastaven�



    function LngPath: ShortString;  // Adres�r jazykov�ch suborov
    function MgdPath: ShortString;  // Adres�r �dajov manazmentu
    function BufPath: ShortString;  // Adres�r internetovych prenosovych suborov
    function RcvPath: ShortString;  // Adres�r internetoveho prenosu - prijate udaje
    function SndPath: ShortString;  // Adres�r internetoveho prenosu - odoslane udaje
    function BpsPath: ShortString;  // Adres�r pre tlacovy server etikiet
    function GsyPath: ShortString;  // Adresar globalny SYSTEM
  private
    oNexPath : ShortString;
    oActYer:Str4;
    oTmpDat:ShortString;
    procedure SetActYear(pValue:Str4);
  public
    property PrivPath: ShortString read oPrivPath write oPrivPath;
  published
    property NexPath: ShortString read oNexPath write oNexPath; // Hlavn� adres�r informa�n�ho syst�mu
    property ActYear: Str4 read oActYear write SetActYear;
  end;

var gPath: TPaths;

implementation

uses NexLogin, NexInit;


constructor TPaths.Create;
begin
  oNexPath:='C:\NEX\';
  oActYear:=gvSys.ActYear;
  oPrivPath:= 'C:\NEXTEMP\';
end;

procedure TPaths.PrvYear; // Nastavi predchadzajuci rok
begin
  ActYear:=StrInt(ValInt(gvSys.ActYear)-1,4);
end;

function TPaths.NydPath: ShortString;  // Adresar aktualneho roka
begin
  Result:=NexPath+'YEAR'+oActYear+'\';
  If oActYear='' then Result:=NexPath;
end;

function TPaths.ActYer:ShortString;  // Adresar aktualneho roka YEARACT
begin
  Result:=NexDir+'YEARACT\';
end;



function TPaths.ImpPath: ShortString;
begin
  Result:=NexPath+'IMPORT\';
  If oActYear='' then Result:=NexPath+'IMPORT\';
end;

function TPaths.ExpPath: ShortString;
begin
  Result:=NexPath+'EXPORT\';
  If oActYear='' then Result:=NexPath+'EXPORT\';
end;

function TPaths.CdwPath: ShortString;
begin
  Result:=NexPath+'CDWDAT\';
  If oActYear='' then Result:=NexPath+'CDWDAT\';
end;

function TPaths.AtcPath: ShortString;
begin
  Result:=NexPath+'ATCDAT\';
  If oActYear='' then Result:=NexPath+'ATCDAT\';
end;

function TPaths.SysPath: ShortString;
begin
  Result:=NexPath+'YEAR'+ActYear+'\SYSTEM\';
  If oActYear='' then Result:=NexPath+'SYSTEM\';
end;

function TPaths.DefPath: ShortString;
begin
  Result:=NydPath+'DBIDEF\';
  If oActYear='' then Result:=NexPath+'DBIDEF\';
end;

function TPaths.RepPath: ShortString;
begin
  Result:=NydPath+'REPORT\';
  If oActYear='' then Result:=NexPath+'REPORT\';
end;

function TPaths.LngPath: ShortString;
begin
  Result:=NydPath+'SYSTEM\LANGUAGE\'+gvSys.Language+'\';
  If oActYear='' then Result:=NexPath+'SYSTEM\LANGUAGE\'+gvSys.Language+'\';
end;

function TPaths.MsgPath: ShortString;
begin
  Result:=NydPath+'SYSTEM\MESSAGES\'+gvSys.Language+'\';
  If oActYear='' then Result:=NexPath+'SYSTEM\MESSAGES\'+gvSys.Language+'\';
end;

function TPaths.BckPath: ShortString;
begin
  Result:=NydPath+'BACKUP\';
  If oActYear='' then Result:=NexPath+'BACKUP\';
end;

function TPaths.ArcPath: ShortString;
begin
  Result:=NexPath+'ARCHIV\';
end;

function TPaths.EMLPath: ShortString;
begin
  Result:=ArcPath+'EML\';
end;

function TPaths.DlsPath: ShortString;
begin
  Result:=NydPath+'DIALS\';
  If oActYear='' then Result:=NexPath+'DIALS\';
end;

function TPaths.StkPath: ShortString;
begin
  Result:=NydPath+'STORES\';
  If oActYear='' then Result:=NexPath+'STORES\';
end;

function TPaths.CabPath: ShortString;
begin
  Result:=NydPath+'CABACK\';
  If oActYear='' then Result:=NexPath+'CABACK\';
end;

function TPaths.LdgPath: ShortString;
begin
  Result:=NydPath+'LEDGER\';
  If oActYear='' then Result:=NexPath+'LEDGER\';
end;

function TPaths.PdpPath: ShortString;
begin
  Result:=NydPath+'PRODPL\';
  If oActYear='' then Result:=NexPath+'PRODPL\';
end;

function TPaths.CpdPath: ShortString;
begin
  Result:=NydPath+'CPDDAT\';
  If oActYear='' then Result:=NexPath+'CPDDAT\';
end;

function TPaths.MgdPath: ShortString;
begin
  Result:=NydPath+'MNGDAT\';
  If oActYear='' then Result:=NexPath+'MNGDAT\';
end;

function TPaths.BufPath: ShortString;
begin
  Result:=NydPath+'BUFDAT\';
  If oActYear='' then Result:=NexPath+'BUFDAT\';
end;

function TPaths.RcvPath: ShortString;
begin
  Result:=NydPath+'BUFDAT\RCV\';
  If oActYear='' then Result:=NexPath+'BUFDAT\RCV\';
end;

function TPaths.SndPath: ShortString;
begin
  Result:=NydPath+'BUFDAT\SND\';
  If oActYear='' then Result:=NexPath+'BUFDAT\SND\';
end;

function TPaths.ColPath: ShortString;
begin
  Result:=NydPath+'COLDAT\';
  If oActYear='' then Result:=NexPath+'COLDAT\';
end;

function TPaths.ImgPath: ShortString;
begin
  Result:=NydPath+'IMAGES\';
  If oActYear='' then Result:=NexPath+'IMAGES\';
end;

function TPaths.PrvPath(pActYear:Str4): ShortString;  // Adresar kde su prenesene udaje predchadzajuceho roka
begin
  Result:=NexPath+'YEAR'+StrInt(ValInt(pActYear)-1,4)+'\';
  If oActYear='' then Result:=NexPath;
end;

function TPaths.DvcPath: ShortString;  // Adres�r pre tlacovy server etikiet
begin
  Result:=NexPath+'DEVICE\';
end;

function TPaths.WghPath: ShortString;  // Adresar vahovych udajov
begin
  Result:=NexPath+'WGHDOC\';
end;

function TPaths.BpsPath: ShortString;  // Adres�r pre tlacovy server etikiet
begin
  Result:=GetBpsPath;
  If Result='' then begin
    Result:=NexPath+'BPSLAB\';
    If oActYear='' then Result:=NexPath;
  end;
end;

function TPaths.RfdPath: ShortString;  // Adres�r pre RF komunikaciu
begin
  Result:=NexPath+'RFDCOM\';
end;

function TPaths.HtlPath: ShortString;  // Adres�r hoteloveho systemu
begin
  Result:=NexPath+'HOTEL\';
end;

function TPaths.StdPath: ShortString;  // Adres�r centralnej statistiky
begin
  Result:=NexPath+'STADAT\';
end;

function TPaths.StiPath: ShortString;  // Adres�r importu centralnej statistiky
begin
  Result:=NexPath+'STADAT\IMPORT\';
end;

function TPaths.StaPath: ShortString;  // Adres�r importu centralnej statistiky
begin
  Result:=NexPath+'STADAT\ARCHIV\';
end;

function TPaths.GsyPath: ShortString;  // Adresar globalny SYSTEM
begin
  Result:=NexPath+'SYSTEM\';
end;

function TPaths.CasPath(pCasNum:word): ShortString;
begin
  Result:=NydPath+'CABACK\C'+StrIntZero(pCasNum,3)+'\';
  If oActYear='' then Result:=NexPath;
end;

function TPaths.DatPath (pDatType:byte): ShortString; // Adresar pre zadany typ udaja
begin
  case pDatType of
    0: Result:=SysPath;
    1: Result:=DlsPath;
    2: Result:=StkPath;
    3: Result:=CabPath;
    4: Result:=LdgPath;
    5: Result:=MgdPath;
  end;
end;

function TPaths.LogPath: ShortString;
begin
  Result:=SysPath+'LOG\';
  If oActYear='' then Result:=NexPath+'SYSTEM\LOG\';
end;

function TPaths.SrvPath:ShortString;
begin
  Result:=NexPath+'SRVDAT\';
end;

procedure TPaths.SetActYer(pValue:Str4);
begin
  oActYer:=pValue;
end;

end.

