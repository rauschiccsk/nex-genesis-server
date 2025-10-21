unit NexRight;

interface

uses
  NexRgh,
  IcTypes, IcVariab, IcConv, NexIni, hAPMDEF,
  Windows, Registry, SysUtils, Forms, Classes;


type
  TNexRight = class(TComponent)
    constructor Create;
    destructor Destroy; override;
  public
    function Enabled (pModul:byte): boolean;
    function Registered (pModul:byte): boolean;
    function GetNewModNum (pModul:byte):word;
  private
    ohAPMDEF: TApmdefHnd;
  published
  end;

var gNexRight: TNexRight;

implementation

constructor TNexRight.Create;
begin
  // Nacitame pristupove prava prihlaseneho uzivatela k pouzitiu programovych modulov
  ohAPMDEF := TApmdefHnd.Create;
  ohAPMDEF.Open;
end;

destructor TNexRight.Destroy;
begin
  FreeAndNil (ohAPMDEF);
end;

// ------------------------------------------------------

function TNexRight.Enabled (pModul:byte): boolean;
var mNewMod:word; // Nove cislo programoveho modulu
begin
  Result := FALSE;
//TIBI 03.08.2018
  If LicModEnabled(GetPmdMark (pModul)) then begin
//  mNewMod := GetNewModNum(pModul);
//  If GetEnableMod(mNewMod) then begin
    If (gvSys.LoginGroup=0)
      then Result := TRUE
      else Result := ohAPMDEF.LocateGrPm(gvSys.LoginGroup,GetPmdMark(pModul));
  end
  else begin
    If mNewMod<100 then begin
      If (gvSys.LoginGroup=0)
        then Result := TRUE
        else Result := ohAPMDEF.LocateGrPm(gvSys.LoginGroup,GetPmdMark(pModul));
    end;
  end;
end;

function TNexRight.Registered (pModul:byte): boolean;
var mNewMod:word; // Nove cislo programoveho modulu
begin
  Result := FALSE;
//Tibi 03.08.2018
//  mNewMod := GetNewModNum(pModul);
//  Result := GetEnableMod(mNewMod);
  Result := LicModEnabled(GetPmdMark (pModul));
end;

function TNexRight.GetNewModNum (pModul:byte):word;
begin
  Result := 0;
  case pModul of
    cSys: Result := 0001;
    cUsr: Result := 0002;
    cDbs: Result := 0003;
    cKey: Result := 0004;
    cGsc: Result := 0005;
    cPab: Result := 0006;
    cStk: Result := 0007;
    cJrn: Result := 0008;
//    cFjr: Result := 0009;
    cAcv: Result := 0010;
    cIfc: Result := 0011;
    // -----------------
    cCrd: Result := 0201;
    cPls: Result := 0202;
    cApl: Result := 0203;
    cAgl: Result := 0204;
    cMcb: Result := 0205;
    cBci: Result := 0208;
//    cDir: Result := 0209;
    cAcb: Result := 0211;
    cRpl: Result := 0212;
    cRpc: Result := 0213;
    cMds: Result := 0214;
    cTpc: Result := 0215;
     // -----------------
    cBsb: Result := 0402;
    cPsb: Result := 0403;
    cOcp: Result := 0404;
    cOsb: Result := 0405;
    cTsb: Result := 0406;
    cTim: Result := 0407;
    cPim: Result := 0408;
    cKsb: Result := 0409;
    cOsq: Result := 0410;
    // -----------------
    cImb: Result := 0301;
    cOmb: Result := 0302;
    cRmb: Result := 0303;
    cIvd: Result := 0305;
    cReb: Result := 0307;
    cPkb: Result := 0304;
    cAlb: Result := 0506;
    cCpb: Result := 0901;
    cCmb: Result := 0902;
    cCdb: Result := 0903;
    cDmb: Result := 0904;
    // -----------------
    cPkl: Result := 0304;
    cMpb: Result := 0304;  {!!!}
    cLab: Result := 2504;
    cKom: Result := 0346;
    // -----------------
    cUdb: Result := 0501;
    cOcb: Result := 0502;
    cTcb: Result := 0503;
    cIcb: Result := 0504;
    cScb: Result := 0801;
    cSpe: Result := 0505;
    cSvb: Result := 0505;
    cTom: Result := 0507;
    cPom: Result := 0508;
    cDsp: Result := 0509;
    cCas: Result := 0601;
    cClb: Result := 0802;
    cItc: Result := 2403;
   // -----------------
    cCab: Result := 0602;
    cSab: Result := 0602;
    cCai: Result := 0603;
    cCap: Result := 0607;
    cCac: Result := 0608;
    // --- Riadenie logistiky ---
    cExb: Result := 0701;
    cRba: Result := 0704;
    // --------------------------
    cIdb: Result := 1301;
    cCsb: Result := 1102;
    cSob: Result := 1103;
    cPqb: Result := 1104;
    cIsb: Result := 1101;
    cVtb: Result := 1107;
//    cJrn: Result := 1302;
    cLdg: Result := 1303;
    cBlr: Result := 1305;
    cSrb: Result := 1801;
    cRcr: Result := 1306;
    cAct: Result := 1304;
    cCrs: Result := 1501;
    cOwb: Result := 1109;
    cDpb: Result := 1112;
    // -----------------
    cFxb: Result := 1601;
    cMtb: Result := 1602;
    // -----------------
    cWab: Result := 1701;
    // -----------------
    cPrb: Result := 2011;
    cCrb: Result := 2012;
    cPxb: Result := 2013;
    cXrm: Result := 2003;
    // -----------------
    cDir: Result := 2201;
    cIpb: Result := 2202;
    cJob: Result := 2204;
    cApb: Result := 2205;
    cPrj: Result := 2206;
    cEmc: Result := 2207;
    // -----------------
    cSta: Result := 2004;
    cSeb: Result := 2007;
    // -----------------
    cHrs: Result := 2101;
    // -----------------
    cWgh: Result := 2501;
    cCwb: Result := 2502;
    cCwe: Result := 2703;
    // -----------------
    cAsc: Result := 2704;
  end;
end;

end.
{MOD 1901005}
{MOD 1905014}
