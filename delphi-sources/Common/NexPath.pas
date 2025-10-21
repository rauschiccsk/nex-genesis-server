unit NexPath;

interface

uses
  IcTypes, IcVariab, IcConv,
  Windows, SysUtils, Forms, Classes;

type
  TPaths=class
    constructor Create;
  public
    procedure PrvYear; // Nastavi predchadzajuci rok

    function ActArchivePath: ShortString; // Arch�vny adres�r vn�tri v ACTYEAR
    function NydPath: ShortString;  // Adres�r aktualneho roka
    function ActPath: ShortString;  // Adres�r aktualneho roka YEARACT
    function MngPath: ShortString;  // Adres�r MANAGER
    function IndPath: ShortString;  // Adres�r prijatych dokumentov a suborov
    function ImpPath: ShortString;  // Adres�r IMPORT
    function ExpPath: ShortString;  // Adres�r EXPORT
    function CdwPath: ShortString;  // Adres�r CDWDAT
    function AtcPath: ShortString;  // Adres�r pr�loh
    function SysPath: ShortString;  // Adres�r syst�mov�ch �dajov
    function DefPath: ShortString;  // Adres�r starych defini�n�ch s�borov
    function RepPath: ShortString;  // Adres�r tlacovych masiek
    function DlsPath: ShortString;  // Adres�r �islenikov
    function LngPath: ShortString;  // Adres�r jazykov�ch suborov
    function MsgPath: ShortString;  // Adres�r syst�mov�ch hl�sen� a dotazov
    function BckPath: ShortString;  // Adres�r zalohovanych �dajov
    function ArcPath: ShortString;  // Adres�r archivovanych �dajov
    function EmlPath: ShortString;  // Adres�r archivovanych emailov
    function LdgPath: ShortString;  // Adres�r �dajov podvojn�ho ��tovn�ctva
    function StkPath: ShortString;  // Adres�r �dajov skladov�ho hospod�rstva
    function CabPath: ShortString;  // Adres�r �dajov pokladnicneho predaja csetkych pokladni
    function PdpPath: ShortString;  // Adres�r �dajov pl�novania v�roby
    function CpdPath: ShortString;  // Adres�r �dajov riadenia v�roby
    function MgdPath: ShortString;  // Adres�r �dajov manazmentu
    function BufPath: ShortString;  // Adres�r internetovych prenosovych suborov
    function RcvPath: ShortString;  // Adres�r internetoveho prenosu - prijate udaje
    function SndPath: ShortString;  // Adres�r internetoveho prenosu - odoslane udaje
    function ColPath: ShortString;  // Adres�r coln�ch �dajov
    function ImgPath: ShortString;  // Adres�r obrazkov
    function BpsPath: ShortString;  // Adres�r pre tlacovy server etikiet
    function DvcPath: ShortString;  // Adres�r externych HW zariadeni
    function WghPath: ShortString;  // Adres�r vahovych udajov
    function RfdPath: ShortString;  // Adres�r pre RF komunikaciu
    function HtlPath: ShortString;  // Adres�r hoteloveho systemu
    function StdPath: ShortString;  // Adres�r udajov centralnej statistiky
    function StiPath: ShortString;  // Adres�r importu centralnej statistiky
    function StaPath: ShortString;  // Adres�r archivu centralnej statistiky
    function GsyPath: ShortString;  // Adres�r globalny SYSTEM
    function PrvPath(pActYear:Str4): ShortString;  // Adres�r kde su prenesene udaje predchadzajuceho roka
    function CasPath (pCasNum:word): ShortString; // Adres�r �dajov pokladne
    function DatPath (pDatType:byte): ShortString; // Adres�r pre zadany typ udaja
    function LogPath: ShortString;  // Adres�r LOG suborov
    function SrvPath: ShortString;  // Adres�r pre komunik�ciu serverov�ch aplik�cii
(*    function PrivPath: ShortString; // Vlastn� adres�r uzivatela
*)
  private
    oNexPath : ShortString;
    oActYear : Str4;
    oMainPrivPath: ShortString;
    oSubPrivPath : ShortString;
    procedure SetActYear(pValue:Str4);
  public
    property MainPrivPath: ShortString read oMainPrivPath write oMainPrivPath;
    property SubPrivPath: ShortString read oSubPrivPath write oSubPrivPath;
  published
    property NexPath: ShortString read oNexPath write oNexPath; // Hlavn� adres�r informa�n�ho syst�mu
    property ActYear: Str4 read oActYear write SetActYear;
  end;

var gPath: TPaths;

implementation

uses NexInit, NexLgn;


constructor TPaths.Create;
begin
  oNexPath:='C:\NEX\';
  oActYear:=gvSys.ActYear;
  oMainPrivPath:= 'C:\NEXTEMP\';
  oSubPrivPath:= 'C:\NEXTEMP\';
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

function TPaths.ActPath: ShortString;  // Adresar aktualneho roka YEARACT
begin
  Result:=NexPath+'YEARACT\';
end;

function TPaths.MngPath: ShortString;
begin
  Result:=NexPath+'MANAGER\';
  If oActYear='' then Result:=NexPath+'MANAGER\';
end;

function TPaths.IndPath: ShortString;
begin
  Result:=NexPath+'INDOCS\';
  If oActYear='' then Result:=NexPath+'INDOCS\';
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

function TPaths.ActArchivePath: ShortString;
begin
  Result:=NydPath+'ARCHIV\';
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

(*
MOD 1911001 - preroben� na property
function TPaths.PrivPath: ShortString;
begin
  Result:=oPrivPath;
end;
*)

function TPaths.LogPath: ShortString;
begin
  Result:=SysPath+'LOG\';
  If oActYear='' then Result:=NexPath+'SYSTEM\LOG\';
end;

function TPaths.SrvPath:ShortString;
begin
  Result:=NexPath+'SRVDAT\';
end;

procedure TPaths.SetActYear(pValue: Str4);
begin
  oActYear:=pValue;
end;

end.
{MOD 1907001}
{MOD 1911001 - NexTemp nena��ta pri Create a funkcia PrivPath bols preroben� na property}

