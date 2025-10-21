unit AfcOsb;

interface

uses
  IcTypes, IcTools, NexPath, NexGlob, AfcBas,
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, NexBtrTable, Forms;

type
  TAfcOsb = class (TAfcBas)
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
    function ReadBokLst:boolean;    procedure WriteBokLst(pValue:boolean);
    function ReadStaOut:boolean;    procedure WriteStaOut(pValue:boolean);
    function ReadOspLst:boolean;    procedure WriteOspLst(pValue:boolean);
    // ---------------------------- TlaË ---------------------------------
    function ReadPrnDoc:boolean;    procedure WritePrnDoc(pValue:boolean);
    // ---------------------------- N·stroje -----------------------------
    function ReadOsdGen:boolean;    procedure WriteOsdGen(pValue:boolean);
    function ReadSnfDbf:boolean;    procedure WriteSnfDbf(pValue:boolean);
    function ReadDlvRea:boolean;    procedure WriteDlvRea(pValue:boolean);
    function ReadOsiDlv:boolean;    procedure WriteOsiDlv(pValue:boolean);
    function ReadOsiNat:boolean;    procedure WriteOsiNat(pValue:boolean);
    function ReadOssMov:boolean;    procedure WriteOssMov(pValue:boolean);
    function ReadOsdPar:boolean;    procedure WriteOsdPar(pValue:boolean);
    function ReadDocSnd:boolean;    procedure WriteDocSnd(pValue:boolean);
    function ReadOitSnd:boolean;    procedure WriteOitSnd(pValue:boolean);
    function ReadOsiNar:boolean;    procedure WriteOsiNar(pValue:boolean);
    function ReadBcsGen:boolean;    procedure WriteBcsGen(pValue:boolean);
    function ReadOsdSnd:boolean;    procedure WriteOsdSnd(pValue:boolean);
    function ReadOsdDdm:boolean;    procedure WriteOsdDdm(pValue:boolean);
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
    property BokLst:boolean read ReadBokLst write WriteBokLst;
    property StaOut:boolean read ReadStaOut write WriteStaOut;
    property OspLst:boolean read ReadOspLst write WriteOspLst;
    // ---------------------- TlaË ---------------------------
    property PrnDoc:boolean read ReadPrnDoc write WritePrnDoc;
    // ---------------------- N·stroje -----------------------
    property OsdGen:boolean read ReadOsdGen write WriteOsdGen;
    property SnfDbf:boolean read ReadSnfDbf write WriteSnfDbf;
    property DlvRea:boolean read ReadDlvRea write WriteDlvRea;
    property OsiDlv:boolean read ReadOsiDlv write WriteOsiDlv;
    property OsiNat:boolean read ReadOsiNat write WriteOsiNat;
    property OssMov:boolean read ReadOssMov write WriteOssMov;
    property OsdPar:boolean read ReadOsdPar write WriteOsdPar;
    property DocSnd:boolean read ReadDocSnd write WriteDocSnd;
    property OitSnd:boolean read ReadOitSnd write WriteOitSnd;
    property OsiNar:boolean read ReadOsiNar write WriteOsiNar;
    property BcsGen:boolean read ReadBcsGen write WriteBcsGen;
    property OsdSnd:boolean read ReadOsdSnd write WriteOsdSnd;
    property OsdDdm:boolean read ReadOsdDdm write WriteOsdDdm;
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
   cDocAdd = 01;  cSitLst = 21;  cPrnDoc = 41;  cOsdGen = 61;  cMntFnc = 100;  cSerFnc = 120;  cItmAdd = 141;
   cDocDel = 02;  cBokLst = 22;  cPrnMas = 42;  cSnfDbf = 62;                                  cItmDel = 142;
   cDocMod = 03;  cStaOut = 23;  cPrnLst = 43;  cDlvRea = 63;                                  cItmMod = 143;
   cDocRnd = 04;  cOspLst = 24;  cPrnLab = 44;  cOsiDlv = 64;  
   cDocDsc = 05;                                cOsiNat = 65;
   cDocLck = 06;                                cOssMov = 66;
   cDocUnl = 07;                                cOsdPar = 67;  
   cVatChg = 08;                                cDocSnd = 68;
                                                cOitSnd = 69;
                                                cOsiNar = 70;
                                                cBcsGen = 71;
                                                cOsdSnd = 72;
                                                cOsdDdm = 73;
                                                
                                                
                                                
                                                
                                                


// **************************************** OBJECT *****************************************

// ---------------------- ⁄pravy -------------------------

function TAfcOsb.ReadDocAdd:boolean;
begin
  Result := ReadData('OSB',cDocAdd);
end;

procedure TAfcOsb.WriteDocAdd(pValue:boolean);
begin
  WriteData('OSB',cDocAdd,pValue);
end;

function TAfcOsb.ReadDocDel:boolean;
begin
  Result := ReadData('OSB',cDocDel);
end;

procedure TAfcOsb.WriteDocDel(pValue:boolean);
begin
  WriteData('OSB',cDocDel,pValue);
end;

function TAfcOsb.ReadDocMod:boolean;
begin
  Result := ReadData('OSB',cDocMod);
end;

procedure TAfcOsb.WriteDocMod(pValue:boolean);
begin
  WriteData('OSB',cDocMod,pValue);
end;

function TAfcOsb.ReadDocRnd:boolean;
begin
  Result := ReadData('OSB',cDocRnd);
end;

procedure TAfcOsb.WriteDocRnd(pValue:boolean);
begin
  WriteData('OSB',cDocRnd,pValue);
end;

function TAfcOsb.ReadDocDsc:boolean;
begin
  Result := ReadData('OSB',cDocDsc);
end;

procedure TAfcOsb.WriteDocDsc(pValue:boolean);
begin
  WriteData('OSB',cDocDsc,pValue);
end;

function TAfcOsb.ReadDocLck:boolean;
begin
  Result := ReadData('OSB',cDocLck);
end;

procedure TAfcOsb.WriteDocLck(pValue:boolean);
begin
  WriteData('OSB',cDocLck,pValue);
end;

function TAfcOsb.ReadDocUnl:boolean;
begin
  Result := ReadData('OSB',cDocUnl);
end;

procedure TAfcOsb.WriteDocUnl(pValue:boolean);
begin
  WriteData('OSB',cDocUnl,pValue);
end;

function TAfcOsb.ReadVatChg:boolean;
begin
  Result := ReadData('OSB',cVatChg);
end;

procedure TAfcOsb.WriteVatChg(pValue:boolean);
begin
  WriteData('OSB',cVatChg,pValue);
end;

// ---------------------- Zobraziù -----------------------

function TAfcOsb.ReadSitLst:boolean;
begin
  Result := ReadData('OSB',cSitLst);
end;

procedure TAfcOsb.WriteSitLst(pValue:boolean);
begin
  WriteData('OSB',cSitLst,pValue);
end;

function TAfcOsb.ReadBokLst:boolean;
begin
  Result := ReadData('OSB',cBokLst);
end;

procedure TAfcOsb.WriteBokLst(pValue:boolean);
begin
  WriteData('OSB',cBokLst,pValue);
end;

function TAfcOsb.ReadStaOut:boolean;
begin
  Result := ReadData('OSB',cStaOut);
end;

procedure TAfcOsb.WriteStaOut(pValue:boolean);
begin
  WriteData('OSB',cStaOut,pValue);
end;

function TAfcOsb.ReadOspLst:boolean;
begin
  Result := ReadData('OSB',cOspLst);
end;

procedure TAfcOsb.WriteOspLst(pValue:boolean);
begin
  WriteData('OSB',cOspLst,pValue);
end;

// ---------------------- TlaË ---------------------------

function TAfcOsb.ReadPrnDoc:boolean;
begin
  Result := ReadData('OSB',cPrnDoc);
end;

procedure TAfcOsb.WritePrnDoc(pValue:boolean);
begin
  WriteData('OSB',cPrnDoc,pValue);
end;

// ---------------------- N·stroje -----------------------

function TAfcOsb.ReadOsdGen:boolean;
begin
  Result := ReadData('OSB',cOsdGen);
end;

procedure TAfcOsb.WriteOsdGen(pValue:boolean);
begin
  WriteData('OSB',cOsdGen,pValue);
end;

function TAfcOsb.ReadSnfDbf:boolean;
begin
  Result := ReadData('OSB',cSnfDbf);
end;

procedure TAfcOsb.WriteSnfDbf(pValue:boolean);
begin
  WriteData('OSB',cSnfDbf,pValue);
end;

function TAfcOsb.ReadDlvRea:boolean;
begin
  Result := ReadData('OSB',cDlvRea);
end;

procedure TAfcOsb.WriteDlvRea(pValue:boolean);
begin
  WriteData('OSB',cDlvRea,pValue);
end;

function TAfcOsb.ReadOsiDlv:boolean;
begin
  Result := ReadData('OSB',cOsiDlv);
end;

procedure TAfcOsb.WriteOsiDlv(pValue:boolean);
begin
  WriteData('OSB',cOsiDlv,pValue);
end;

function TAfcOsb.ReadOsiNat:boolean;
begin
  Result := ReadData('OSB',cOsiNat);
end;

procedure TAfcOsb.WriteOsiNat(pValue:boolean);
begin
  WriteData('OSB',cOsiNat,pValue);
end;

function TAfcOsb.ReadOssMov:boolean;
begin
  Result := ReadData('OSB',cOssMov);
end;

procedure TAfcOsb.WriteOssMov(pValue:boolean);
begin
  WriteData('OSB',cOssMov,pValue);
end;

function TAfcOsb.ReadOsdPar:boolean;
begin
  Result := ReadData('OSB',cOsdPar);
end;

procedure TAfcOsb.WriteOsdPar(pValue:boolean);
begin
  WriteData('OSB',cOsdPar,pValue);
end;

function TAfcOsb.ReadDocSnd:boolean;
begin
  Result := ReadData('OSB',cDocSnd);
end;

procedure TAfcOsb.WriteDocSnd(pValue:boolean);
begin
  WriteData('OSB',cDocSnd,pValue);
end;

function TAfcOsb.ReadOsiNar:boolean;
begin
  Result := ReadData('OSB',cOsiNar);
end;

procedure TAfcOsb.WriteOsiNar(pValue:boolean);
begin
  WriteData('OSB',cOsiNar,pValue);
end;

function TAfcOsb.ReadBcsGen:boolean;
begin
  Result := ReadData('OSB',cBcsGen);
end;

procedure TAfcOsb.WriteBcsGen(pValue:boolean);
begin
  WriteData('OSB',cBcsGen,pValue);
end;

function TAfcOsb.ReadOsdSnd:boolean;
begin
  Result := ReadData('OSB',cOsdSnd);
end;

procedure TAfcOsb.WriteOsdSnd(pValue:boolean);
begin
  WriteData('OSB',cOsdSnd,pValue);
end;

function TAfcOsb.ReadOsdDdm:boolean;
begin
  Result := ReadData('OSB',cOsdDdm);
end;

procedure TAfcOsb.WriteOsdDdm(pValue:boolean);
begin
  WriteData('OSB',cOsdDdm,pValue);
end;

function TAfcOsb.ReadOitSnd:boolean;
begin
  Result := ReadData('OSB',cOitSnd);
end;

procedure TAfcOsb.WriteOitSnd(pValue:boolean);
begin
  WriteData('OSB',cOitSnd,pValue);
end;

// ---------------------- ⁄drûba -------------------------

function TAfcOsb.ReadMntFnc:boolean;
begin
  Result := ReadData('OSB',cMntFnc);
end;

procedure TAfcOsb.WriteMntFnc(pValue:boolean);
begin
  WriteData('OSB',cMntFnc,pValue);
end;

// ---------------------- Servis -------------------------

function TAfcOsb.ReadSerFnc:boolean;
begin
  Result := ReadData('OSB',cSerFnc);
end;

procedure TAfcOsb.WriteSerFnc(pValue:boolean);
begin
  WriteData('OSB',cSerFnc,pValue);
end;

// ---------------------- Poloûky ------------------------

function TAfcOsb.ReadItmAdd:boolean;
begin
  Result := ReadData('OSB',cItmAdd);
end;

procedure TAfcOsb.WriteItmAdd(pValue:boolean);
begin
  WriteData('OSB',cItmAdd,pValue);
end;

function TAfcOsb.ReadItmDel:boolean;
begin
  Result := ReadData('OSB',cItmDel);
end;

procedure TAfcOsb.WriteItmDel(pValue:boolean);
begin
  WriteData('OSB',cItmDel,pValue);
end;

function TAfcOsb.ReadItmMod:boolean;
begin
  Result := ReadData('OSB',cItmMod);
end;

procedure TAfcOsb.WriteItmMod(pValue:boolean);
begin
  WriteData('OSB',cItmMod,pValue);
end;

end.
