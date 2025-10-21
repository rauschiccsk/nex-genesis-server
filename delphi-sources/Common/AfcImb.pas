unit AfcImb;

interface

uses
  IcTypes, IcTools, NexPath, NexGlob, AfcBas,
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, NexBtrTable, Forms;

type
  TAfcImb = class (TAfcBas)
  private
    // ---------------------------- ⁄pravy -------------------------------
    function ReadDocAdd:boolean;    procedure WriteDocAdd(pValue:boolean);
    function ReadDocDel:boolean;    procedure WriteDocDel(pValue:boolean);
    function ReadDocMod:boolean;    procedure WriteDocMod(pValue:boolean);
    function ReadDocDsc:boolean;    procedure WriteDocDsc(pValue:boolean);
    function ReadDocRnd:boolean;    procedure WriteDocRnd(pValue:boolean);
    function ReadDocLck:boolean;    procedure WriteDocLck(pValue:boolean);
    function ReadDocUnl:boolean;    procedure WriteDocUnl(pValue:boolean);
    function ReadVatChg:boolean;    procedure WriteVatChg(pValue:boolean);
    // ---------------------------- Zobraziù -----------------------------
    function ReadSitLst:boolean;    procedure WriteSitLst(pValue:boolean);
    function ReadAccLst:boolean;    procedure WriteAccLst(pValue:boolean);
    // ---------------------------- TlaË ---------------------------------
    function ReadPrnDoc:boolean;    procedure WritePrnDoc(pValue:boolean);
    function ReadPrnMas:boolean;    procedure WritePrnMas(pValue:boolean);
    function ReadPrnLst:boolean;    procedure WritePrnLst(pValue:boolean);
    function ReadPrnLab:boolean;    procedure WritePrnLab(pValue:boolean);
    // ---------------------------- N·stroje -----------------------------
    function ReadDocFlt:boolean;    procedure WriteDocFlt(pValue:boolean);
    function ReadDocStp:boolean;    procedure WriteDocStp(pValue:boolean);
    function ReadSmcLst:boolean;    procedure WriteSmcLst(pValue:boolean);
    function ReadAccDoc:boolean;    procedure WriteAccDoc(pValue:boolean);
    function ReadAccDel:boolean;    procedure WriteAccDel(pValue:boolean);
    function ReadAccMas:boolean;    procedure WriteAccMas(pValue:boolean);
    function ReadMovLst:boolean;    procedure WriteMovLst(pValue:boolean);
    function ReadWghRcv:boolean;    procedure WriteWghRcv(pValue:boolean);
    function ReadOitSnd:boolean;    procedure WriteOitSnd(pValue:boolean);
    function ReadTrmInc:boolean;    procedure WriteTrmInc(pValue:boolean);
    function ReadEdoImp:boolean;    procedure WriteEdoImp(pValue:boolean);
    function ReadImiFxa:boolean;    procedure WriteImiFxa(pValue:boolean);
    // ---------------------------- ⁄drûba -------------------------------
    function ReadMntFnc:boolean;    procedure WriteMntFnc(pValue:boolean);
    // ---------------------------- Servis -------------------------------
    function ReadSerFnc:boolean;    procedure WriteSerFnc(pValue:boolean);
    // ---------------------------- Poloûky ------------------------------
    function ReadItmAdd:boolean;    procedure WriteItmAdd(pValue:boolean);
    function ReadItmDel:boolean;    procedure WriteItmDel(pValue:boolean);
    function ReadItmMod:boolean;    procedure WriteItmMod(pValue:boolean);
  public
    // ---------------------- ⁄pravy -------------------------
    property DocAdd:boolean read ReadDocAdd write WriteDocAdd;
    property DocDel:boolean read ReadDocDel write WriteDocDel;
    property DocDsc:boolean read ReadDocDsc write WriteDocDsc;
    property DocLck:boolean read ReadDocLck write WriteDocLck;
    property DocUnl:boolean read ReadDocUnl write WriteDocUnl;
    property DocRnd:boolean read ReadDocRnd write WriteDocRnd;
    property DocMod:boolean read ReadDocMod write WriteDocMod;
    property VatChg:boolean read ReadVatChg write WriteVatChg;
    // ---------------------- Zobraziù -----------------------
    property SitLst:boolean read ReadSitLst write WriteSitLst;
    property AccLst:boolean read ReadAccLst write WriteAccLst;
    // ---------------------- TlaË ---------------------------
    property PrnDoc:boolean read ReadPrnDoc write WritePrnDoc;
    property PrnMas:boolean read ReadPrnMas write WritePrnMas;
    property PrnLst:boolean read ReadPrnLst write WritePrnLst;
    property PrnLab:boolean read ReadPrnLab write WritePrnLab;
    // ---------------------- N·stroje -----------------------
    property DocFlt:boolean read ReadDocFlt write WriteDocFlt;
    property DocStp:boolean read ReadDocStp write WriteDocStp;
    property SmcLst:boolean read ReadSmcLst write WriteSmcLst;
    property AccDoc:boolean read ReadAccDoc write WriteAccDoc;
    property AccDel:boolean read ReadAccDel write WriteAccDel;
    property AccMas:boolean read ReadAccMas write WriteAccMas;
    property MovLst:boolean read ReadMovLst write WriteMovLst;
    property WghRcv:boolean read ReadWghRcv write WriteWghRcv;
    property OitSnd:boolean read ReadOitSnd write WriteOitSnd;
    property TrmInc:boolean read ReadTrmInc write WriteTrmInc;
    property EdoImp:boolean read ReadEdoImp write WriteEdoImp;
    property ImiFxa:boolean read ReadImiFxa write WriteImiFxa;
    // ---------------------- ⁄drûba -------------------------
    property MntFnc:boolean read ReadMntFnc write WriteMntFnc;
    // ---------------------- Servis -------------------------
    property SerFnc:boolean read ReadSerFnc write WriteSerFnc;
    // ---------------------- Poloûky ------------------------
    property ItmAdd:boolean read ReadItmAdd write WriteItmAdd;
    property ItmDel:boolean read ReadItmDel write WriteItmDel;
    property ItmMod:boolean read ReadItmMod write WriteItmMod;
  end;

implementation

const
// Upravy ------  Zobrazit ----  Tlac --------  N·stroje ----  ⁄drzba -------  Servis ------   Polozky ------
   cDocAdd = 01;  cSitLst = 21;  cPrnDoc = 41;  cDocFlt = 61;  cMntFnc = 100;  cSerFnc = 120;  cItmAdd = 141;
   cDocDel = 02;  cAccLst = 22;  cPrnMas = 42;  cDocStp = 62;                                  cItmDel = 142;
   cDocMod = 03;                 cPrnLst = 43;  cSmcLst = 63;                                  cItmMod = 143;
   cDocRnd = 04;                 cPrnLab = 44;  cAccDoc = 64;
   cDocDsc = 05;                                cAccDel = 65;
   cDocLck = 06;                                cAccMas = 66;
   cDocUnl = 07;                                cMovLst = 67;
   cVatChg = 08;                                cWghRcv = 68;
                                                cOitSnd = 69;
                                                cTrmInc = 70;
                                                cEdoImp = 71;
                                                cImiFxa = 72;
// **************************************** OBJECT *****************************************

// ---------------------- ⁄pravy -------------------------

function TAfcImb.ReadDocAdd:boolean;
begin
  Result := ReadData('IMB',cDocAdd);
end;

procedure TAfcImb.WriteDocAdd(pValue:boolean);
begin
  WriteData('IMB',cDocAdd,pValue);
end;

function TAfcImb.ReadDocDel:boolean;
begin
  Result := ReadData('IMB',cDocDel);
end;

procedure TAfcImb.WriteDocDel(pValue:boolean);
begin
  WriteData('IMB',cDocDel,pValue);
end;

function TAfcImb.ReadDocMod:boolean;
begin
  Result := ReadData('IMB',cDocMod);
end;

procedure TAfcImb.WriteDocMod(pValue:boolean);
begin
  WriteData('IMB',cDocMod,pValue);
end;

function TAfcImb.ReadDocRnd:boolean;
begin
  Result := ReadData('IMB',cDocRnd);
end;

procedure TAfcImb.WriteDocRnd(pValue:boolean);
begin
  WriteData('IMB',cDocRnd,pValue);
end;

function TAfcImb.ReadDocDsc:boolean;
begin
  Result := ReadData('IMB',cDocDsc);
end;

procedure TAfcImb.WriteDocDsc(pValue:boolean);
begin
  WriteData('IMB',cDocDsc,pValue);
end;

function TAfcImb.ReadDocLck:boolean;
begin
  Result := ReadData('IMB',cDocLck);
end;

procedure TAfcImb.WriteDocLck(pValue:boolean);
begin
  WriteData('IMB',cDocLck,pValue);
end;

function TAfcImb.ReadDocUnl:boolean;
begin
  Result := ReadData('IMB',cDocUnl);
end;

procedure TAfcImb.WriteDocUnl(pValue:boolean);
begin
  WriteData('IMB',cDocUnl,pValue);
end;

function TAfcImb.ReadVatChg:boolean;
begin
  Result := ReadData('IMB',cVatChg);
end;

procedure TAfcImb.WriteVatChg(pValue:boolean);
begin
  WriteData('IMB',cVatChg,pValue);
end;

// ---------------------- Zobraziù -----------------------

function TAfcImb.ReadSitLst:boolean;
begin
  Result := ReadData('IMB',cSitLst);
end;

procedure TAfcImb.WriteSitLst(pValue:boolean);
begin
  WriteData('IMB',cSitLst,pValue);
end;

function TAfcImb.ReadAccLst:boolean;
begin
  Result := ReadData('IMB',cAccLst);
end;

procedure TAfcImb.WriteAccLst(pValue:boolean);
begin
  WriteData('IMB',cAccLst,pValue);
end;

// ---------------------- TlaË ---------------------------

function TAfcImb.ReadPrnDoc:boolean;
begin
  Result := ReadData('IMB',cPrnDoc);
end;

procedure TAfcImb.WritePrnDoc(pValue:boolean);
begin
  WriteData('IMB',cPrnDoc,pValue);
end;

function TAfcImb.ReadPrnMas:boolean;
begin
  Result := ReadData('IMB',cPrnMas);
end;

procedure TAfcImb.WritePrnMas(pValue:boolean);
begin
  WriteData('IMB',cPrnMas,pValue);
end;

function TAfcImb.ReadPrnLst:boolean;
begin
  Result := ReadData('IMB',cPrnLst);
end;

procedure TAfcImb.WritePrnLst(pValue:boolean);
begin
  WriteData('IMB',cPrnLst,pValue);
end;

function TAfcImb.ReadPrnLab:boolean;
begin
  Result := ReadData('IMB',cPrnLab);
end;

procedure TAfcImb.WritePrnLab(pValue:boolean);
begin
  WriteData('IMB',cPrnLab,pValue);
end;

// ---------------------- N·stroje -----------------------

function TAfcImb.ReadDocFlt:boolean;
begin
  Result := ReadData('IMB',cDocFlt);
end;

procedure TAfcImb.WriteDocFlt(pValue:boolean);
begin
  WriteData('IMB',cDocFlt,pValue);
end;

function TAfcImb.ReadDocStp:boolean;
begin
  Result := ReadData('IMB',cDocStp);
end;

procedure TAfcImb.WriteDocStp(pValue:boolean);
begin
  WriteData('IMB',cDocStp,pValue);
end;

function TAfcImb.ReadSmcLst:boolean;
begin
  Result := ReadData('IMB',cSmcLst);
end;

procedure TAfcImb.WriteSmcLst(pValue:boolean);
begin
  WriteData('IMB',cSmcLst,pValue);
end;

function TAfcImb.ReadAccDoc:boolean;
begin
  Result := ReadData('IMB',cAccDoc);
end;

procedure TAfcImb.WriteAccDoc(pValue:boolean);
begin
  WriteData('IMB',cAccDoc,pValue);
end;

function TAfcImb.ReadAccDel:boolean;
begin
  Result := ReadData('IMB',cAccDel);
end;

procedure TAfcImb.WriteAccDel(pValue:boolean);
begin
  WriteData('IMB',cAccDel,pValue);
end;

function TAfcImb.ReadAccMas:boolean;
begin
  Result := ReadData('IMB',cAccMas);
end;

procedure TAfcImb.WriteAccMas(pValue:boolean);
begin
  WriteData('IMB',cAccMas,pValue);
end;

function TAfcImb.ReadOitSnd:boolean;
begin
  Result := ReadData('IMB',cOitSnd);
end;

procedure TAfcImb.WriteOitSnd(pValue:boolean);
begin
  WriteData('IMB',cOitSnd,pValue);
end;

function TAfcImb.ReadImiFxa:boolean;
begin
  Result := ReadData('IMB',cImiFxa);
end;

procedure TAfcImb.WriteImiFxa(pValue:boolean);
begin
  WriteData('IMB',cImiFxa,pValue);
end;

// ---------------------- ⁄drûba -------------------------

function TAfcImb.ReadMntFnc:boolean;
begin
  Result := ReadData('IMB',cMntFnc);
end;

procedure TAfcImb.WriteMntFnc(pValue:boolean);
begin
  WriteData('IMB',cMntFnc,pValue);
end;

// ---------------------- Servis -------------------------

function TAfcImb.ReadSerFnc:boolean;
begin
  Result := ReadData('IMB',cSerFnc);
end;

procedure TAfcImb.WriteSerFnc(pValue:boolean);
begin
  WriteData('IMB',cSerFnc,pValue);
end;

// ---------------------- Poloûky ------------------------

function TAfcImb.ReadItmAdd:boolean;
begin
  Result := ReadData('IMB',cItmAdd);
end;

procedure TAfcImb.WriteItmAdd(pValue:boolean);
begin
  WriteData('IMB',cItmAdd,pValue);
end;

function TAfcImb.ReadItmDel:boolean;
begin
  Result := ReadData('IMB',cItmDel);
end;

procedure TAfcImb.WriteItmDel(pValue:boolean);
begin
  WriteData('IMB',cItmDel,pValue);
end;

function TAfcImb.ReadItmMod:boolean;
begin
  Result := ReadData('IMB',cItmMod);
end;

procedure TAfcImb.WriteItmMod(pValue:boolean);
begin
  WriteData('IMB',cItmMod,pValue);
end;

function TAfcImb.ReadEdoImp: boolean;
begin
  Result := ReadData('IMB',cEdoImp);
end;

function TAfcImb.ReadMovLst: boolean;
begin
  Result := ReadData('IMB',cMovLst);
end;

function TAfcImb.ReadTrmInc: boolean;
begin
  Result := ReadData('IMB',cTrmInc);
end;

function TAfcImb.ReadWghRcv: boolean;
begin
  Result := ReadData('IMB',cWghRcv);
end;

procedure TAfcImb.WriteEdoImp(pValue: boolean);
begin
  WriteData('IMB',cEdoImp,pValue);
end;

procedure TAfcImb.WriteMovLst(pValue: boolean);
begin
  WriteData('IMB',cMovLst,pValue);
end;

procedure TAfcImb.WriteTrmInc(pValue: boolean);
begin
  WriteData('IMB',cTrmInc,pValue);
end;

procedure TAfcImb.WriteWghRcv(pValue: boolean);
begin
  WriteData('IMB',cWghRcv,pValue);
end;

end.
