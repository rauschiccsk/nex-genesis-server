unit AfcOmb;

interface

uses
  IcTypes, IcTools, NexPath, NexGlob, AfcBas,
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, NexBtrTable, Forms;

type
  TAfcOmb = class (TAfcBas)
  private
    // ---------------------------- ⁄pravy -------------------------------
    function ReadDocAdd:boolean;    procedure WriteDocAdd(pValue:boolean);
    function ReadDocDel:boolean;    procedure WriteDocDel(pValue:boolean);
    function ReadDocMod:boolean;    procedure WriteDocMod(pValue:boolean);
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
    function ReadDocCpy:boolean;    procedure WriteDocCpy(pValue:boolean);
    function ReadAccDoc:boolean;    procedure WriteAccDoc(pValue:boolean);
    function ReadAccDel:boolean;    procedure WriteAccDel(pValue:boolean);
    function ReadAccMas:boolean;    procedure WriteAccMas(pValue:boolean);
    function ReadImdGen:boolean;    procedure WriteImdGen(pValue:boolean);
    function ReadStkMgc:boolean;    procedure WriteStkMgc(pValue:boolean);
    function ReadOutStk:boolean;    procedure WriteOutStk(pValue:boolean);
    function ReadWghRcv:boolean;    procedure WriteWghRcv(pValue:boolean);
    function ReadOitSnd:boolean;    procedure WriteOitSnd(pValue:boolean);
    function ReadTrmInc:boolean;    procedure WriteTrmInc(pValue:boolean);
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
    property DocLck:boolean read ReadDocLck write WriteDocLck;
    property DocUnl:boolean read ReadDocUnl write WriteDocUnl;
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
    property AccDoc:boolean read ReadAccDoc write WriteAccDoc;
    property AccDel:boolean read ReadAccDel write WriteAccDel;
    property AccMas:boolean read ReadAccMas write WriteAccMas;
    property ImdGen:boolean read ReadImdGen write WriteImdGen;
    property StkMgc:boolean read ReadStkMgc write WriteStkMgc;
    property OutStk:boolean read ReadOutStk write WriteOutStk;
    property WghRcv:boolean read ReadWghRcv write WriteWghRcv;
    property OitSnd:boolean read ReadOitSnd write WriteOitSnd;
    property TrmInc:boolean read ReadTrmInc write WriteTrmInc;
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
   cDocMod = 03;                 cPrnLst = 43;  cDocCpy = 63;                                  cItmMod = 143;
   cDocRnd = 04;                 cPrnLab = 44;  cAccDoc = 64;
   cDocDsc = 05;                                cAccDel = 65;
   cDocLck = 06;                                cAccMas = 66;
   cDocUnl = 07;                                cImdGen = 67;
   cVatChg = 08;                                cStkMgc = 68;
                                                cOutStk = 69;
                                                cWghRcv = 70;
                                                cOitSnd = 71;
                                                cTrmInc = 72;

// **************************************** OBJECT *****************************************

// ---------------------- ⁄pravy -------------------------

function TAfcOmb.ReadDocAdd:boolean;
begin
  Result := ReadData('OMB',cDocAdd);
end;

procedure TAfcOmb.WriteDocAdd(pValue:boolean);
begin
  WriteData('OMB',cDocAdd,pValue);
end;

function TAfcOmb.ReadDocDel:boolean;
begin
  Result := ReadData('OMB',cDocDel);
end;

procedure TAfcOmb.WriteDocDel(pValue:boolean);
begin
  WriteData('OMB',cDocDel,pValue);
end;

function TAfcOmb.ReadDocMod:boolean;
begin
  Result := ReadData('OMB',cDocMod);
end;

procedure TAfcOmb.WriteDocMod(pValue:boolean);
begin
  WriteData('OMB',cDocMod,pValue);
end;

function TAfcOmb.ReadDocLck:boolean;
begin
  Result := ReadData('OMB',cDocLck);
end;

procedure TAfcOmb.WriteDocLck(pValue:boolean);
begin
  WriteData('OMB',cDocLck,pValue);
end;

function TAfcOmb.ReadDocUnl:boolean;
begin
  Result := ReadData('OMB',cDocUnl);
end;

procedure TAfcOmb.WriteDocUnl(pValue:boolean);
begin
  WriteData('OMB',cDocUnl,pValue);
end;

function TAfcOmb.ReadVatChg:boolean;
begin
  Result := ReadData('OMB',cVatChg);
end;

procedure TAfcOmb.WriteVatChg(pValue:boolean);
begin
  WriteData('OMB',cVatChg,pValue);
end;

// ---------------------- Zobraziù -----------------------

function TAfcOmb.ReadSitLst:boolean;
begin
  Result := ReadData('OMB',cSitLst);
end;

procedure TAfcOmb.WriteSitLst(pValue:boolean);
begin
  WriteData('OMB',cSitLst,pValue);
end;

function TAfcOmb.ReadAccLst:boolean;
begin
  Result := ReadData('OMB',cAccLst);
end;

procedure TAfcOmb.WriteAccLst(pValue:boolean);
begin
  WriteData('OMB',cAccLst,pValue);
end;

// ---------------------- TlaË ---------------------------

function TAfcOmb.ReadPrnDoc:boolean;
begin
  Result := ReadData('OMB',cPrnDoc);
end;

procedure TAfcOmb.WritePrnDoc(pValue:boolean);
begin
  WriteData('OMB',cPrnDoc,pValue);
end;

function TAfcOmb.ReadPrnMas:boolean;
begin
  Result := ReadData('OMB',cPrnMas);
end;

procedure TAfcOmb.WritePrnMas(pValue:boolean);
begin
  WriteData('OMB',cPrnMas,pValue);
end;

function TAfcOmb.ReadPrnLst:boolean;
begin
  Result := ReadData('OMB',cPrnLst);
end;

procedure TAfcOmb.WritePrnLst(pValue:boolean);
begin
  WriteData('OMB',cPrnLst,pValue);
end;

function TAfcOmb.ReadPrnLab:boolean;
begin
  Result := ReadData('OMB',cPrnLab);
end;

procedure TAfcOmb.WritePrnLab(pValue:boolean);
begin
  WriteData('OMB',cPrnLab,pValue);
end;

// ---------------------- N·stroje -----------------------

function TAfcOmb.ReadDocFlt:boolean;
begin
  Result := ReadData('OMB',cDocFlt);
end;

procedure TAfcOmb.WriteDocFlt(pValue:boolean);
begin
  WriteData('OMB',cDocFlt,pValue);
end;

function TAfcOmb.ReadDocStp:boolean;
begin
  Result := ReadData('OMB',cDocStp);
end;

procedure TAfcOmb.WriteDocStp(pValue:boolean);
begin
  WriteData('OMB',cDocStp,pValue);
end;

function TAfcOmb.ReadDocCpy:boolean;
begin
  Result := ReadData('OMB',cDocCpy);
end;

procedure TAfcOmb.WriteDocCpy(pValue:boolean);
begin
  WriteData('OMB',cDocCpy,pValue);
end;

function TAfcOmb.ReadAccDoc:boolean;
begin
  Result := ReadData('OMB',cAccDoc);
end;

procedure TAfcOmb.WriteAccDoc(pValue:boolean);
begin
  WriteData('OMB',cAccDoc,pValue);
end;

function TAfcOmb.ReadAccDel:boolean;
begin
  Result := ReadData('OMB',cAccDel);
end;

procedure TAfcOmb.WriteAccDel(pValue:boolean);
begin
  WriteData('OMB',cAccDel,pValue);
end;

function TAfcOmb.ReadAccMas:boolean;
begin
  Result := ReadData('OMB',cAccMas);
end;

procedure TAfcOmb.WriteAccMas(pValue:boolean);
begin
  WriteData('OMB',cAccMas,pValue);
end;

function TAfcOmb.ReadImdGen:boolean;
begin
  Result := ReadData('OMB',cImdGen);
end;

procedure TAfcOmb.WriteImdGen(pValue:boolean);
begin
  WriteData('OMB',cImdGen,pValue);
end;

function TAfcOmb.ReadStkMgc:boolean;
begin
  Result := ReadData('OMB',cStkMgc);
end;

procedure TAfcOmb.WriteStkMgc(pValue:boolean);
begin
  WriteData('OMB',cStkMgc,pValue);
end;

function TAfcOmb.ReadOutStk:boolean;
begin
  Result := ReadData('OMB',cOutStk);
end;

procedure TAfcOmb.WriteOutStk(pValue:boolean);
begin
  WriteData('OMB',cOutStk,pValue);
end;

function TAfcOmb.ReadWghRcv:boolean;
begin
  Result := ReadData('OMB',cWghRcv);
end;

procedure TAfcOmb.WriteWghRcv(pValue:boolean);
begin
  WriteData('OMB',cWghRcv,pValue);
end;

function TAfcOmb.ReadOitSnd:boolean;
begin
  Result := ReadData('OMB',cOitSnd);
end;

procedure TAfcOmb.WriteOitSnd(pValue:boolean);
begin
  WriteData('OMB',cOitSnd,pValue);
end;

function TAfcOmb.ReadTrmInc:boolean;
begin
  Result := ReadData('OMB',cTrmInc);
end;

procedure TAfcOmb.WriteTrmInc(pValue:boolean);
begin
  WriteData('OMB',cTrmInc,pValue);
end;

// ---------------------- ⁄drûba -------------------------

function TAfcOmb.ReadMntFnc:boolean;
begin
  Result := ReadData('OMB',cMntFnc);
end;

procedure TAfcOmb.WriteMntFnc(pValue:boolean);
begin
  WriteData('OMB',cMntFnc,pValue);
end;

// ---------------------- Servis -------------------------

function TAfcOmb.ReadSerFnc:boolean;
begin
  Result := ReadData('OMB',cSerFnc);
end;

procedure TAfcOmb.WriteSerFnc(pValue:boolean);
begin
  WriteData('OMB',cSerFnc,pValue);
end;

// ---------------------- Poloûky ------------------------

function TAfcOmb.ReadItmAdd:boolean;
begin
  Result := ReadData('OMB',cItmAdd);
end;

procedure TAfcOmb.WriteItmAdd(pValue:boolean);
begin
  WriteData('OMB',cItmAdd,pValue);
end;

function TAfcOmb.ReadItmDel:boolean;
begin
  Result := ReadData('OMB',cItmDel);
end;

procedure TAfcOmb.WriteItmDel(pValue:boolean);
begin
  WriteData('OMB',cItmDel,pValue);
end;

function TAfcOmb.ReadItmMod:boolean;
begin
  Result := ReadData('OMB',cItmMod);
end;

procedure TAfcOmb.WriteItmMod(pValue:boolean);
begin
  WriteData('OMB',cItmMod,pValue);
end;

end.
