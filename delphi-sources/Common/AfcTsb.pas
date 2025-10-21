unit AfcTsb;

interface

uses
  IcTypes, IcTools, NexPath, NexGlob, AfcBas,
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, NexBtrTable, Forms;

type
  TAfcTsb = class (TAfcBas)
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
    function ReadNpaDoc:boolean;    procedure WriteNpaDoc(pValue:boolean);
    function ReadDlvSur:boolean;    procedure WriteDlvSur(pValue:boolean);
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
    function ReadOsdPar:boolean;    procedure WriteOsdPar(pValue:boolean);
    function ReadDocEtr:boolean;    procedure WriteDocEtr(pValue:boolean);
    function ReadTsdMpr:boolean;    procedure WriteTsdMpr(pValue:boolean);
    function ReadAddAcq:boolean;    procedure WriteAddAcq(pValue:boolean);
    function ReadTrmRcv:boolean;    procedure WriteTrmRcv(pValue:boolean);
    function ReadTsiRep:boolean;    procedure WriteTsiRep(pValue:boolean);
    function ReadOitSnd:boolean;    procedure WriteOitSnd(pValue:boolean);
    function ReadTrmInc:boolean;    procedure WriteTrmInc(pValue:boolean);
    function ReadOmdGen:boolean;    procedure WriteOmdGen(pValue:boolean);
    function ReadImiFxa:boolean;    procedure WriteImiFxa(pValue:boolean);
    function ReadDocPck:boolean;    procedure WriteDocPck(pValue:boolean);
    function ReadIcdGen:boolean;    procedure WriteIcdGen(pValue:boolean);
    function ReadRpcGen:boolean;    procedure WriteRpcGen(pValue:boolean);
    function ReadPckRep:boolean;    procedure WritePckRep(pValue:boolean);
    // ---------------------------- ⁄drûba -------------------------------
    function ReadMntFnc:boolean;    procedure WriteMntFnc(pValue:boolean);
    // ---------------------------- Servis -------------------------------
    function ReadSerFnc:boolean;    procedure WriteSerFnc(pValue:boolean);
    // ---------------------------- Poloûky ------------------------------
    function ReadItmAdd:boolean;    procedure WriteItmAdd(pValue:boolean);
    function ReadItmDel:boolean;    procedure WriteItmDel(pValue:boolean);
    function ReadItmMod:boolean;    procedure WriteItmMod(pValue:boolean);
    function ReadItmRev:boolean;    procedure WriteItmRev(pValue:boolean);
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
    property NpaDoc:boolean read ReadNpaDoc write WriteNpaDoc;
    property DlvSur:boolean read ReadDlvSur write WriteDlvSur;
    // ---------------------- TlaË ---------------------------
    property PrnDoc:boolean read ReadPrnDoc write WritePrnDoc;
    property PrnMas:boolean read ReadPrnMas write WritePrnMas;
    property PrnLst:boolean read ReadPrnLst write WritePrnLst;
    property PrnLab:boolean read ReadPrnLab write WritePrnLab;
    // ---------------------- N·stroje -----------------------
    property DocFlt:boolean read ReadDocFlt write WriteDocFlt;
    property DocStp:boolean read ReadDocStp write WriteDocStp;
    property DocCpy:boolean read ReadDocCpy write WriteDocCpy;
    property AccDoc:boolean read ReadAccDoc write WriteAccDoc;
    property AccDel:boolean read ReadAccDel write WriteAccDel;
    property AccMas:boolean read ReadAccMas write WriteAccMas;
    property OsdPar:boolean read ReadOsdPar write WriteOsdPar;
    property DocEtr:boolean read ReadDocEtr write WriteDocEtr;
    property TsdMpr:boolean read ReadTsdMpr write WriteTsdMpr;
    property AddAcq:boolean read ReadAddAcq write WriteAddAcq;
    property TrmRcv:boolean read ReadTrmRcv write WriteTrmRcv;
    property TsiRep:boolean read ReadTsiRep write WriteTsiRep;
    property OitSnd:boolean read ReadOitSnd write WriteOitSnd;
    property TrmInc:boolean read ReadTrmInc write WriteTrmInc;
    property OmdGen:boolean read ReadOmdGen write WriteOmdGen;
    property ImiFxa:boolean read ReadImiFxa write WriteImiFxa;
    property DocPck:boolean read ReadDocPck write WriteDocPck;
    property IcdGen:boolean read ReadIcdGen write WriteIcdGen;
    property RpcGen:boolean read ReadRpcGen write WriteRpcGen;
    property PckRep:boolean read ReadPckRep write WritePckRep;
    // ---------------------- ⁄drûba -------------------------
    property MntFnc:boolean read ReadMntFnc write WriteMntFnc;
    // ---------------------- Servis -------------------------
    property SerFnc:boolean read ReadSerFnc write WriteSerFnc;
    // ---------------------- Poloûky ------------------------
    property ItmAdd:boolean read ReadItmAdd write WriteItmAdd;
    property ItmDel:boolean read ReadItmDel write WriteItmDel;
    property ItmMod:boolean read ReadItmMod write WriteItmMod;
    property ItmRev:boolean read ReadItmRev write WriteItmRev;
  end;

implementation

const
// Upravy ------  Zobrazit ----  Tlac --------  N·stroje ----  ⁄drzba -------  Servis ------   Polozky ------
   cDocAdd = 01;  cSitLst = 21;  cPrnDoc = 41;  cDocFlt = 61;  cMntFnc = 100;  cSerFnc = 120;  cItmAdd = 141;
   cDocDel = 02;  cAccLst = 22;  cPrnMas = 42;  cDocStp = 62;                                  cItmDel = 142;
   cDocMod = 03;  cNpaDoc = 23;  cPrnLst = 43;  cDocCpy = 63;                                  cItmMod = 143;
   cDocRnd = 04;  cDlvSur = 24;  cPrnLab = 44;  cAccDoc = 64;                                  cItmRev = 144;
   cDocDsc = 05;                                cAccDel = 65;
   cDocLck = 06;                                cAccMas = 66;
   cDocUnl = 07;                                cOsdPar = 67;
   cVatChg = 08;                                cDocEtr = 68;
                                                cTsdMpr = 69;
                                                cAddAcq = 70;
                                                cTrmRcv = 71;
                                                cTsiRep = 72;
                                                cOitSnd = 73;
                                                cTrmInc = 74;
                                                cOmdGen = 75;
                                                cImiFxa = 76;
                                                cDocPck = 77;
                                                cIcdGen = 78;
                                                cRpcGen = 79;
                                                cPckRep = 80;

// **************************************** OBJECT *****************************************

// ---------------------- ⁄pravy -------------------------

function TAfcTsb.ReadDocAdd:boolean;
begin
  Result := ReadData('TSB',cDocAdd);
end;

procedure TAfcTsb.WriteDocAdd(pValue:boolean);
begin
  WriteData('TSB',cDocAdd,pValue);
end;

function TAfcTsb.ReadDocDel:boolean;
begin
  Result := ReadData('TSB',cDocDel);
end;

procedure TAfcTsb.WriteDocDel(pValue:boolean);
begin
  WriteData('TSB',cDocDel,pValue);
end;

function TAfcTsb.ReadDocMod:boolean;
begin
  Result := ReadData('TSB',cDocMod);
end;

procedure TAfcTsb.WriteDocMod(pValue:boolean);
begin
  WriteData('TSB',cDocMod,pValue);
end;

function TAfcTsb.ReadDocRnd:boolean;
begin
  Result := ReadData('TSB',cDocRnd);
end;

procedure TAfcTsb.WriteDocRnd(pValue:boolean);
begin
  WriteData('TSB',cDocRnd,pValue);
end;

function TAfcTsb.ReadDocDsc:boolean;
begin
  Result := ReadData('TSB',cDocDsc);
end;

procedure TAfcTsb.WriteDocDsc(pValue:boolean);
begin
  WriteData('TSB',cDocDsc,pValue);
end;

function TAfcTsb.ReadDocLck:boolean;
begin
  Result := ReadData('TSB',cDocLck);
end;

procedure TAfcTsb.WriteDocLck(pValue:boolean);
begin
  WriteData('TSB',cDocLck,pValue);
end;

function TAfcTsb.ReadDocUnl:boolean;
begin
  Result := ReadData('TSB',cDocUnl);
end;

procedure TAfcTsb.WriteDocUnl(pValue:boolean);
begin
  WriteData('TSB',cDocUnl,pValue);
end;

function TAfcTsb.ReadVatChg:boolean;
begin
  Result := ReadData('TSB',cVatChg);
end;

procedure TAfcTsb.WriteVatChg(pValue:boolean);
begin
  WriteData('TSB',cVatChg,pValue);
end;

// ---------------------- Zobraziù -----------------------

function TAfcTsb.ReadSitLst:boolean;
begin
  Result := ReadData('TSB',cSitLst);
end;

procedure TAfcTsb.WriteSitLst(pValue:boolean);
begin
  WriteData('TSB',cSitLst,pValue);
end;

function TAfcTsb.ReadAccLst:boolean;
begin
  Result := ReadData('TSB',cAccLst);
end;

procedure TAfcTsb.WriteAccLst(pValue:boolean);
begin
  WriteData('TSB',cAccLst,pValue);
end;

function TAfcTsb.ReadNpaDoc:boolean;
begin
  Result := ReadData('TSB',cNpaDoc);
end;

procedure TAfcTsb.WriteNpaDoc(pValue:boolean);
begin
  WriteData('TSB',cNpaDoc,pValue);
end;

function TAfcTsb.ReadDlvSur:boolean;
begin
  Result := ReadData('TSB',cDlvSur);
end;

procedure TAfcTsb.WriteDlvSur(pValue:boolean);
begin
  WriteData('TSB',cDlvSur,pValue);
end;

// ---------------------- TlaË ---------------------------

function TAfcTsb.ReadPrnDoc:boolean;
begin
  Result := ReadData('TSB',cPrnDoc);
end;

procedure TAfcTsb.WritePrnDoc(pValue:boolean);
begin
  WriteData('TSB',cPrnDoc,pValue);
end;

function TAfcTsb.ReadPrnMas:boolean;
begin
  Result := ReadData('TSB',cPrnMas);
end;

procedure TAfcTsb.WritePrnMas(pValue:boolean);
begin
  WriteData('TSB',cPrnMas,pValue);
end;

function TAfcTsb.ReadPrnLst:boolean;
begin
  Result := ReadData('TSB',cPrnLst);
end;

procedure TAfcTsb.WritePrnLst(pValue:boolean);
begin
  WriteData('TSB',cPrnLst,pValue);
end;

function TAfcTsb.ReadPrnLab:boolean;
begin
  Result := ReadData('TSB',cPrnLab);
end;

procedure TAfcTsb.WritePrnLab(pValue:boolean);
begin
  WriteData('TSB',cPrnLab,pValue);
end;

// ---------------------- N·stroje -----------------------

function TAfcTsb.ReadDocFlt:boolean;
begin
  Result := ReadData('TSB',cDocFlt);
end;

procedure TAfcTsb.WriteDocFlt(pValue:boolean);
begin
  WriteData('TSB',cDocFlt,pValue);
end;

function TAfcTsb.ReadDocStp:boolean;
begin
  Result := ReadData('TSB',cDocStp);
end;

procedure TAfcTsb.WriteDocStp(pValue:boolean);
begin
  WriteData('TSB',cDocStp,pValue);
end;

function TAfcTsb.ReadDocCpy:boolean;
begin
  Result := ReadData('TSB',cDocCpy);
end;

procedure TAfcTsb.WriteDocCpy(pValue:boolean);
begin
  WriteData('TSB',cDocCpy,pValue);
end;

function TAfcTsb.ReadAccDoc:boolean;
begin
  Result := ReadData('TSB',cAccDoc);
end;

procedure TAfcTsb.WriteAccDoc(pValue:boolean);
begin
  WriteData('TSB',cAccDoc,pValue);
end;

function TAfcTsb.ReadAccDel:boolean;
begin
  Result := ReadData('TSB',cAccDel);
end;

procedure TAfcTsb.WriteAccDel(pValue:boolean);
begin
  WriteData('TSB',cAccDel,pValue);
end;

function TAfcTsb.ReadAccMas:boolean;
begin
  Result := ReadData('TSB',cAccMas);
end;

procedure TAfcTsb.WriteAccMas(pValue:boolean);
begin
  WriteData('TSB',cAccMas,pValue);
end;

function TAfcTsb.ReadOsdPar:boolean;
begin
  Result := ReadData('TSB',cOsdPar);
end;

procedure TAfcTsb.WriteOsdPar(pValue:boolean);
begin
  WriteData('TSB',cOsdPar,pValue);
end;

function TAfcTsb.ReadDocEtr:boolean;
begin
  Result := ReadData('TSB',cDocEtr);
end;

procedure TAfcTsb.WriteDocEtr(pValue:boolean);
begin
  WriteData('TSB',cDocEtr,pValue);
end;

function TAfcTsb.ReadTsdMpr:boolean;
begin
  Result := ReadData('TSB',cTsdMpr);
end;

procedure TAfcTsb.WriteTsdMpr(pValue:boolean);
begin
  WriteData('TSB',cTsdMpr,pValue);
end;

function TAfcTsb.ReadAddAcq:boolean;
begin
  Result := ReadData('TSB',cAddAcq);
end;

procedure TAfcTsb.WriteAddAcq(pValue:boolean);
begin
  WriteData('TSB',cAddAcq,pValue);
end;

function TAfcTsb.ReadTrmRcv:boolean;
begin
  Result := ReadData('TSB',cTrmRcv);
end;

procedure TAfcTsb.WriteTrmRcv(pValue:boolean);
begin
  WriteData('TSB',cTrmRcv,pValue);
end;

function TAfcTsb.ReadTsiRep:boolean;
begin
  Result := ReadData('TSB',cTsiRep);
end;

procedure TAfcTsb.WriteTsiRep(pValue:boolean);
begin
  WriteData('TSB',cTsiRep,pValue);
end;

function TAfcTsb.ReadOitSnd:boolean;
begin
  Result := ReadData('TSB',cOitSnd);
end;

procedure TAfcTsb.WriteOitSnd(pValue:boolean);
begin
  WriteData('TSB',cOitSnd,pValue);
end;

function TAfcTsb.ReadTrmInc:boolean;
begin
  Result := ReadData('TSB',cTrmInc);
end;

procedure TAfcTsb.WriteTrmInc(pValue:boolean);
begin
  WriteData('TSB',cTrmInc,pValue);
end;

function TAfcTsb.ReadOmdGen:boolean;
begin
  Result := ReadData('TSB',cOmdGen);
end;

procedure TAfcTsb.WriteOmdGen(pValue:boolean);
begin
  WriteData('TSB',cOmdGen,pValue);
end;

function TAfcTsb.ReadImiFxa:boolean;
begin
  Result := ReadData('TSB',cImiFxa);
end;

procedure TAfcTsb.WriteImiFxa(pValue:boolean);
begin
  WriteData('TSB',cImiFxa,pValue);
end;

function TAfcTsb.ReadDocPck:boolean;
begin
  Result := ReadData('TSB',cDocPck);
end;

procedure TAfcTsb.WriteDocPck(pValue:boolean);
begin
  WriteData('TSB',cDocPck,pValue);
end;

function TAfcTsb.ReadIcdGen:boolean;
begin
  Result := ReadData('TSB',cIcdGen);
end;

procedure TAfcTsb.WriteIcdGen(pValue:boolean);
begin
  WriteData('TSB',cIcdGen,pValue);
end;

function TAfcTsb.ReadRpcGen:boolean;
begin
  Result := ReadData('TSB',cRpcGen);
end;

procedure TAfcTsb.WriteRpcGen(pValue:boolean);
begin
  WriteData('TSB',cRpcGen,pValue);
end;

function TAfcTsb.ReadPckRep:boolean;
begin
  Result := ReadData('TSB',cPckRep);
end;

procedure TAfcTsb.WritePckRep(pValue:boolean);
begin
  WriteData('TSB',cPckRep,pValue);
end;

// ---------------------- ⁄drûba -------------------------

function TAfcTsb.ReadMntFnc:boolean;
begin
  Result := ReadData('TSB',cMntFnc);
end;

procedure TAfcTsb.WriteMntFnc(pValue:boolean);
begin
  WriteData('TSB',cMntFnc,pValue);
end;

// ---------------------- Servis -------------------------

function TAfcTsb.ReadSerFnc:boolean;
begin
  Result := ReadData('TSB',cSerFnc);
end;

procedure TAfcTsb.WriteSerFnc(pValue:boolean);
begin
  WriteData('TSB',cSerFnc,pValue);
end;

// ---------------------- Poloûky ------------------------

function TAfcTsb.ReadItmAdd:boolean;
begin
  Result := ReadData('TSB',cItmAdd);
end;

procedure TAfcTsb.WriteItmAdd(pValue:boolean);
begin
  WriteData('TSB',cItmAdd,pValue);
end;

function TAfcTsb.ReadItmDel:boolean;
begin
  Result := ReadData('TSB',cItmDel);
end;

procedure TAfcTsb.WriteItmDel(pValue:boolean);
begin
  WriteData('TSB',cItmDel,pValue);
end;

function TAfcTsb.ReadItmMod:boolean;
begin
  Result := ReadData('TSB',cItmMod);
end;

procedure TAfcTsb.WriteItmMod(pValue:boolean);
begin
  WriteData('TSB',cItmMod,pValue);
end;

function TAfcTsb.ReadItmRev:boolean;
begin
  Result := ReadData('TSB',cItmRev);
end;

procedure TAfcTsb.WriteItmRev(pValue:boolean);
begin
  WriteData('TSB',cItmRev,pValue);
end;

end.
