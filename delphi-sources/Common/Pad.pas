unit Pad;
{$F+}
// *****************************************************************************
// **********              DATABÁZOVÉ SÚBORY PARTNEROV                **********
// *****************************************************************************
interface

uses
  IcTypes, IcConv, IcTools, IcVariab, IniFiles, SysUtils, NexGlob,
  hPAB, hCRDLST,
  NexPath, NexIni, Forms;

type
  TPad=class
    constructor Create;
    destructor Destroy; override;
    private
    public
      ohPAB:TPabHnd;  // Evidennèné karty partnerov
      ohCRDLST:TCrdlstHnd;  // Zoznam zákazníckych kariet
      procedure OpenPAB;
      procedure OpenCRDLST;
      function LocPaCode(pPaCode:longint):boolean;
      function LocIdCode(pIdCode:Str15):boolean;
    published
  end;

implementation

uses bPAB;

constructor TPad.Create;
begin
  ohPAB:=nil;
  ohCRDLST:=nil;
end;

destructor TPad.Destroy;
begin
  If ohCRDLST<>nil then FreeAndnil(ohCRDLST);
  If ohPAB<>nil then FreeAndnil(ohPAB);
end;

// ********************************* PRIVATE ***********************************
// ********************************** PUBLIC ***********************************

procedure TPad.OpenPAB;
begin
  If ohPAB=nil then begin
    ohPAB:=TPabHnd.Create;
    ohPAB.Open(0);
  end;
end;

procedure TPad.OpenCRDLST;
begin
  If ohCRDLST=nil then begin
    ohCRDLST:=TCrdlstHnd.Create;
    ohCRDLST.Open;
  end;
end;

function TPad.LocPaCode(pPaCode:longint):boolean;
begin
  Result:=ohPAB.LocatePaCode(pPaCode);
end;

function TPad.LocIdCode(pIdCode:Str15):boolean;
var mPaCode:longint;
begin
  Result:=FALSE;
  If pIdCode<>'' then begin
    If (pIdCode[1]='.') or (pIdCode[1]=',') then begin
      Delete(pIdCode,1,1);
      mPaCode:=ValInt(pIdCode);
      Result:=LocPaCode(mPaCode);
    end else begin
      Result:=ohPAB.LocateRegIno(pIdCode);
      If not Result then begin
        OpenCRDLST;
        Result:=ohCRDLST.LocateCrdNum(pIdCode);
        If Result then Result:=ohPAB.LocatePaCode(ohCRDLST.PaCode);
      end;
    end;
  end;
end;

end.
