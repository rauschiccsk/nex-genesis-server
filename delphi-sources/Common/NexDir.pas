unit NexDir;

interface

uses
  IcTypes, IcVariab, IcConv,
  Windows, SysUtils, Forms, Classes;

type
  TNexDir=class
    constructor Create;
  public
    function NexDir:ShortString;  // Adresar informaèného systému
    function ActYer:ShortString;  // Adresar aktualneho roka YEARACT
    // ------------------------------- NEX -------------------------------------
    function Archiv:ShortString;  // Adresár archivovanych údajov
    function BckUpd:ShortString;  // Adresár aktualizaèných záloh
    function ExpDat:ShortString;  // Adresar exportovaných súborov
    function ImpDat:ShortString;  // Adresar importovaných súborov
    function NexDat:ShortString;  // Adresár datových súborov
    function SysDat:ShortString;  // Adresár systémových údajov
    // ------------------------------ ARCHIV -----------------------------------
    function DocArc:ShortString;  // Adresár archivovaných dokumentov
    function EmlArc:ShortString;  // Adresár archivovaných emailov
    function PdfArc:ShortString;  // Adresár archivovaných PDF súborov
    // ------------------------------ NEXDAT -----------------------------------
    function CasDat(pCasNum:word):ShortString; // Adresár údajov zadanej pokladne
    function FatDat:ShortString;  // Adresár prílohových súborov
    function ImgDat:ShortString;  // Adresár obrazkov užívate¾a
    // ------------------------------ SYSDAT -----------------------------------
    function DefDat:ShortString;  // Adresár DDF súborov
    function DgdDat:ShortString;  // Adresár DGD súborov
    function LogDat:ShortString;  // Adresár LOG súborov
    function RepDat:ShortString;  // Adresár tlacových šablónov
    function SetDat:ShortString;  // Adresár užívate¾ských nastavení



    function LngPath: ShortString;  // Adresár jazykových suborov
    function MgdPath: ShortString;  // Adresár údajov manazmentu
    function BufPath: ShortString;  // Adresár internetovych prenosovych suborov
    function RcvPath: ShortString;  // Adresár internetoveho prenosu - prijate udaje
    function SndPath: ShortString;  // Adresár internetoveho prenosu - odoslane udaje
    function BpsPath: ShortString;  // Adresár pre tlacovy server etikiet
    function GsyPath: ShortString;  // Adresar globalny SYSTEM
  private
    oNexPath : ShortString;
    oActYer:Str4;
    oTmpDat:ShortString;
    procedure SetActYear(pValue:Str4);
  public
    property PrivPath: ShortString read oPrivPath write oPrivPath;
  published
    property NexPath: ShortString read oNexPath write oNexPath; // Hlavný adresár informaèného systému
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

function TPaths.DvcPath: ShortString;  // Adresár pre tlacovy server etikiet
begin
  Result:=NexPath+'DEVICE\';
end;

function TPaths.WghPath: ShortString;  // Adresar vahovych udajov
begin
  Result:=NexPath+'WGHDOC\';
end;

function TPaths.BpsPath: ShortString;  // Adresár pre tlacovy server etikiet
begin
  Result:=GetBpsPath;
  If Result='' then begin
    Result:=NexPath+'BPSLAB\';
    If oActYear='' then Result:=NexPath;
  end;
end;

function TPaths.RfdPath: ShortString;  // Adresár pre RF komunikaciu
begin
  Result:=NexPath+'RFDCOM\';
end;

function TPaths.HtlPath: ShortString;  // Adresár hoteloveho systemu
begin
  Result:=NexPath+'HOTEL\';
end;

function TPaths.StdPath: ShortString;  // Adresár centralnej statistiky
begin
  Result:=NexPath+'STADAT\';
end;

function TPaths.StiPath: ShortString;  // Adresár importu centralnej statistiky
begin
  Result:=NexPath+'STADAT\IMPORT\';
end;

function TPaths.StaPath: ShortString;  // Adresár importu centralnej statistiky
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

