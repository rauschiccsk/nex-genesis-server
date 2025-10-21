unit AfcRmb;

interface

uses
  IcTypes, IcTools, NexPath, NexGlob, AfcBas,
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, NexBtrTable, Forms;

type
  TAfcRmb = class (TAfcBas)
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
    function ReadNsuItm:boolean;    procedure WriteNsuItm(pValue:boolean);
    // ---------------------------- TlaË ---------------------------------
    function ReadPrnDoc:boolean;    procedure WritePrnDoc(pValue:boolean);
    function ReadPrnMas:boolean;    procedure WritePrnMas(pValue:boolean);
    function ReadPrnLst:boolean;    procedure WritePrnLst(pValue:boolean);
    function ReadPrnLab:boolean;    procedure WritePrnLab(pValue:boolean);
    // ---------------------------- N·stroje -----------------------------
    function ReadDocFlt:boolean;    procedure WriteDocFlt(pValue:boolean);
    function ReadDocStp:boolean;    procedure WriteDocStp(pValue:boolean);
    function ReadAccDoc:boolean;    procedure WriteAccDoc(pValue:boolean);
    function ReadAccDel:boolean;    procedure WriteAccDel(pValue:boolean);
    function ReadAccMas:boolean;    procedure WriteAccMas(pValue:boolean);
    function ReadMovLst:boolean;    procedure WriteMovLst(pValue:boolean);
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
    property DocDsc:boolean read ReadDocDsc write WriteDocDsc;
    property DocLck:boolean read ReadDocLck write WriteDocLck;
    property DocUnl:boolean read ReadDocUnl write WriteDocUnl;
    property DocRnd:boolean read ReadDocRnd write WriteDocRnd;
    property DocMod:boolean read ReadDocMod write WriteDocMod;
    property VatChg:boolean read ReadVatChg write WriteVatChg;
    // ---------------------- Zobraziù -----------------------
    property SitLst:boolean read ReadSitLst write WriteSitLst;
    property AccLst:boolean read ReadAccLst write WriteAccLst;
    property NsuItm:boolean read ReadNsuItm write WriteNsuItm;
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
    property MovLst:boolean read ReadMovLst write WriteMovLst;
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
   cDocMod = 03;  cNsuItm = 23;  cPrnLst = 43;  cDocCpy = 63;                                  cItmMod = 143;
   cDocRnd = 04;                 cPrnLab = 44;  cAccDoc = 64;
   cDocDsc = 05;                                cAccDel = 65;
   cDocLck = 06;                                cAccMas = 66;
   cDocUnl = 07;                                cMovLst = 67;
   cVatChg = 08;                                cWghRcv = 68;
                                                cOitSnd = 69;
                                                cTrmInc = 70;

// **************************************** OBJECT *****************************************

// ---------------------- ⁄pravy -------------------------

function TAfcRmb.ReadDocAdd:boolean;
begin
  Result := ReadData('RMB',cDocAdd);
end;

procedure TAfcRmb.WriteDocAdd(pValue:boolean);
begin
  WriteData('RMB',cDocAdd,pValue);
end;

function TAfcRmb.ReadDocDel:boolean;
begin
  Result := ReadData('RMB',cDocDel);
end;

procedure TAfcRmb.WriteDocDel(pValue:boolean);
begin
  WriteData('RMB',cDocDel,pValue);
end;

function TAfcRmb.ReadDocMod:boolean;
begin
  Result := ReadData('RMB',cDocMod);
end;

procedure TAfcRmb.WriteDocMod(pValue:boolean);
begin
  WriteData('RMB',cDocMod,pValue);
end;

function TAfcRmb.ReadDocRnd:boolean;
begin
  Result := ReadData('RMB',cDocRnd);
end;

procedure TAfcRmb.WriteDocRnd(pValue:boolean);
begin
  WriteData('RMB',cDocRnd,pValue);
end;

function TAfcRmb.ReadDocDsc:boolean;
begin
  Result := ReadData('RMB',cDocDsc);
end;

procedure TAfcRmb.WriteDocDsc(pValue:boolean);
begin
  WriteData('RMB',cDocDsc,pValue);
end;

function TAfcRmb.ReadDocLck:boolean;
begin
  Result := ReadData('RMB',cDocLck);
end;

procedure TAfcRmb.WriteDocLck(pValue:boolean);
begin
  WriteData('RMB',cDocLck,pValue);
end;

function TAfcRmb.ReadDocUnl:boolean;
begin
  Result := ReadData('RMB',cDocUnl);
end;

procedure TAfcRmb.WriteDocUnl(pValue:boolean);
begin
  WriteData('RMB',cDocUnl,pValue);
end;

function TAfcRmb.ReadVatChg:boolean;
begin
  Result := ReadData('RMB',cVatChg);
end;

procedure TAfcRmb.WriteVatChg(pValue:boolean);
begin
  WriteData('RMB',cVatChg,pValue);
end;

// ---------------------- Zobraziù -----------------------

function TAfcRmb.ReadSitLst:boolean;
begin
  Result := ReadData('RMB',cSitLst);
end;

procedure TAfcRmb.WriteSitLst(pValue:boolean);
begin
  WriteData('RMB',cSitLst,pValue);
end;

function TAfcRmb.ReadAccLst:boolean;
begin
  Result := ReadData('RMB',cAccLst);
end;

procedure TAfcRmb.WriteAccLst(pValue:boolean);
begin
  WriteData('RMB',cAccLst,pValue);
end;

function TAfcRmb.ReadNsuItm:boolean;
begin
  Result := ReadData('RMB',cNsuItm);
end;

procedure TAfcRmb.WriteNsuItm(pValue:boolean);
begin
  WriteData('RMB',cNsuItm,pValue);
end;

// ---------------------- TlaË ---------------------------

function TAfcRmb.ReadPrnDoc:boolean;
begin
  Result := ReadData('RMB',cPrnDoc);
end;

procedure TAfcRmb.WritePrnDoc(pValue:boolean);
begin
  WriteData('RMB',cPrnDoc,pValue);
end;

function TAfcRmb.ReadPrnMas:boolean;
begin
  Result := ReadData('RMB',cPrnMas);
end;

procedure TAfcRmb.WritePrnMas(pValue:boolean);
begin
  WriteData('RMB',cPrnMas,pValue);
end;

function TAfcRmb.ReadPrnLst:boolean;
begin
  Result := ReadData('RMB',cPrnLst);
end;

procedure TAfcRmb.WritePrnLst(pValue:boolean);
begin
  WriteData('RMB',cPrnLst,pValue);
end;

function TAfcRmb.ReadPrnLab:boolean;
begin
  Result := ReadData('RMB',cPrnLab);
end;

procedure TAfcRmb.WritePrnLab(pValue:boolean);
begin
  WriteData('RMB',cPrnLab,pValue);
end;

// ---------------------- N·stroje -----------------------

function TAfcRmb.ReadDocFlt:boolean;
begin
  Result := ReadData('RMB',cDocFlt);
end;

procedure TAfcRmb.WriteDocFlt(pValue:boolean);
begin
  WriteData('RMB',cDocFlt,pValue);
end;

function TAfcRmb.ReadDocStp:boolean;
begin
  Result := ReadData('RMB',cDocStp);
end;

procedure TAfcRmb.WriteDocStp(pValue:boolean);
begin
  WriteData('RMB',cDocStp,pValue);
end;

function TAfcRmb.ReadAccDoc:boolean;
begin
  Result := ReadData('RMB',cAccDoc);
end;

procedure TAfcRmb.WriteAccDoc(pValue:boolean);
begin
  WriteData('RMB',cAccDoc,pValue);
end;

function TAfcRmb.ReadAccDel:boolean;
begin
  Result := ReadData('RMB',cAccDel);
end;

procedure TAfcRmb.WriteAccDel(pValue:boolean);
begin
  WriteData('RMB',cAccDel,pValue);
end;

function TAfcRmb.ReadAccMas:boolean;
begin
  Result := ReadData('RMB',cAccMas);
end;

procedure TAfcRmb.WriteAccMas(pValue:boolean);
begin
  WriteData('RMB',cAccMas,pValue);
end;

function TAfcRmb.ReadMovLst:boolean;
begin
  Result := ReadData('RMB',cMovLst);
end;

procedure TAfcRmb.WriteMovLst(pValue:boolean);
begin
  WriteData('RMB',cMovLst,pValue);
end;

function TAfcRmb.ReadWghRcv:boolean;
begin
  Result := ReadData('RMB',cWghRcv);
end;

procedure TAfcRmb.WriteWghRcv(pValue:boolean);
begin
  WriteData('RMB',cWghRcv,pValue);
end;

function TAfcRmb.ReadOitSnd:boolean;
begin
  Result := ReadData('RMB',cOitSnd);
end;

procedure TAfcRmb.WriteOitSnd(pValue:boolean);
begin
  WriteData('RMB',cOitSnd,pValue);
end;

function TAfcRmb.ReadTrmInc:boolean;
begin
  Result := ReadData('RMB',cTrmInc);
end;

procedure TAfcRmb.WriteTrmInc(pValue:boolean);
begin
  WriteData('RMB',cTrmInc,pValue);
end;

// ---------------------- ⁄drûba -------------------------

function TAfcRmb.ReadMntFnc:boolean;
begin
  Result := ReadData('RMB',cMntFnc);
end;

procedure TAfcRmb.WriteMntFnc(pValue:boolean);
begin
  WriteData('RMB',cMntFnc,pValue);
end;

// ---------------------- Servis -------------------------

function TAfcRmb.ReadSerFnc:boolean;
begin
  Result := ReadData('RMB',cSerFnc);
end;

procedure TAfcRmb.WriteSerFnc(pValue:boolean);
begin
  WriteData('RMB',cSerFnc,pValue);
end;

// ---------------------- Poloûky ------------------------

function TAfcRmb.ReadItmAdd:boolean;
begin
  Result := ReadData('RMB',cItmAdd);
end;

procedure TAfcRmb.WriteItmAdd(pValue:boolean);
begin
  WriteData('RMB',cItmAdd,pValue);
end;

function TAfcRmb.ReadItmDel:boolean;
begin
  Result := ReadData('RMB',cItmDel);
end;

procedure TAfcRmb.WriteItmDel(pValue:boolean);
begin
  WriteData('RMB',cItmDel,pValue);
end;

function TAfcRmb.ReadItmMod:boolean;
begin
  Result := ReadData('RMB',cItmMod);
end;

procedure TAfcRmb.WriteItmMod(pValue:boolean);
begin
  WriteData('RMB',cItmMod,pValue);
end;

end.
