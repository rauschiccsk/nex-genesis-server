unit AfcTcb;

interface

uses
  IcTypes, IcTools, NexPath, NexGlob, AfcBas,
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, NexBtrTable, Forms;

type
  TAfcTcb = class (TAfcBas)
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
    function ReadNpaTcd:boolean;    procedure WriteNpaTcd(pValue:boolean);
    function ReadNoiLst:boolean;    procedure WriteNoiLst(pValue:boolean);
    function ReadNpyIcd:boolean;    procedure WriteNpyIcd(pValue:boolean);
    // ---------------------------- TlaË ---------------------------------
    function ReadPrnDoc:boolean;    procedure WritePrnDoc(pValue:boolean);
    function ReadPrnStd:boolean;    procedure WritePrnStd(pValue:boolean);
    // ---------------------------- N·stroje -----------------------------
    function ReadDocFlt:boolean;    procedure WriteDocFlt(pValue:boolean);
    function ReadDocStp:boolean;    procedure WriteDocStp(pValue:boolean);
    function ReadDocStr:boolean;    procedure WriteDocStr(pValue:boolean);
    function ReadAccDoc:boolean;    procedure WriteAccDoc(pValue:boolean);
    function ReadAccDel:boolean;    procedure WriteAccDel(pValue:boolean);
    function ReadAccMas:boolean;    procedure WriteAccMas(pValue:boolean);
    function ReadIcgDoc:boolean;    procedure WriteIcgDoc(pValue:boolean);
    function ReadIcgMas:boolean;    procedure WriteIcgMas(pValue:boolean);
    function ReadFmdGen:boolean;    procedure WriteFmdGen(pValue:boolean);
    function ReadOutStk:boolean;    procedure WriteOutStk(pValue:boolean);
    function ReadExdGen:boolean;    procedure WriteExdGen(pValue:boolean);
    function ReadDocClc:boolean;    procedure WriteDocClc(pValue:boolean);
    function ReadOitSnd:boolean;    procedure WriteOitSnd(pValue:boolean);
    function ReadTrmOut:boolean;    procedure WriteTrmOut(pValue:boolean);
    function ReadTrdCpr:boolean;    procedure WriteTrdCpr(pValue:boolean);
    function ReadDocMov:boolean;    procedure WriteDocMov(pValue:boolean);
    function ReadOmiFxa:boolean;    procedure WriteOmiFxa(pValue:boolean);
    function ReadWgdImp:boolean;    procedure WriteWgdImp(pValue:boolean);
    // ---------------------------- PokladÚa -----------------------------
    function ReadCasFnc:boolean;    procedure WriteCasFnc(pValue:boolean);
    // ---------------------------- ⁄drûba -------------------------------
    function ReadMntFnc:boolean;    procedure WriteMntFnc(pValue:boolean);
    // ---------------------------- Servis -------------------------------
    function ReadSerFnc:boolean;    procedure WriteSerFnc(pValue:boolean);
    // ---------------------------- Poloûky ------------------------------
    function ReadItmAdd:boolean;    procedure WriteItmAdd(pValue:boolean);
    function ReadItmDel:boolean;    procedure WriteItmDel(pValue:boolean);
    function ReadItmMod:boolean;    procedure WriteItmMod(pValue:boolean);
    function ReadPckItm:boolean;    procedure WritePckItm(pValue:boolean);
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
    property NpaTcd:boolean read ReadNpaTcd write WriteNpaTcd;
    property NoiLst:boolean read ReadNoiLst write WriteNoiLst;
    property NpyIcd:boolean read ReadNpyIcd write WriteNpyIcd;
    // ---------------------- TlaË ---------------------------
    property PrnDoc:boolean read ReadPrnDoc write WritePrnDoc;
    property PrnStd:boolean read ReadPrnStd write WritePrnStd;
    // ---------------------- N·stroje -----------------------
    property DocFlt:boolean read ReadDocFlt write WriteDocFlt;
    property DocStp:boolean read ReadDocStp write WriteDocStp;
    property DocStr:boolean read ReadDocStr write WriteDocStr;
    property AccDoc:boolean read ReadAccDoc write WriteAccDoc;
    property AccDel:boolean read ReadAccDel write WriteAccDel;
    property AccMas:boolean read ReadAccMas write WriteAccMas;
    property IcgDoc:boolean read ReadIcgDoc write WriteIcgDoc;
    property IcgMas:boolean read ReadIcgMas write WriteIcgMas;
    property FmdGen:boolean read ReadFmdGen write WriteFmdGen;
    property OutStk:boolean read ReadOutStk write WriteOutStk;
    property ExdGen:boolean read ReadExdGen write WriteExdGen;
    property DocClc:boolean read ReadDocClc write WriteDocClc;
    property OitSnd:boolean read ReadOitSnd write WriteOitSnd;
    property TrmOut:boolean read ReadTrmOut write WriteTrmOut;
    property TrdCpr:boolean read ReadTrdCpr write WriteTrdCpr;
    property DocMov:boolean read ReadDocMov write WriteDocMov;
    property OmiFxa:boolean read ReadOmiFxa write WriteOmiFxa;
    property WgdImp:boolean read ReadWgdImp write WriteWgdImp;
    // ---------------------- PokladÚa -----------------------
    property CasFnc:boolean read ReadCasFnc write WriteCasFnc;
    // ---------------------- ⁄drûba -------------------------
    property MntFnc:boolean read ReadMntFnc write WriteMntFnc;
    // ---------------------- Servis -------------------------
    property SerFnc:boolean read ReadSerFnc write WriteSerFnc;
    // ---------------------- Poloûky ------------------------
    property ItmAdd:boolean read ReadItmAdd write WriteItmAdd;
    property ItmDel:boolean read ReadItmDel write WriteItmDel;
    property ItmMod:boolean read ReadItmMod write WriteItmMod;
    property PckItm:boolean read ReadPckItm write WritePckItm;
  end;

implementation

const
// Upravy ------  Zobrazit ----  Tlac --------  N·stroje ----  PokladÚa ----  ⁄drzba -------  Servis ------   Polozky ------
   cDocAdd = 01;  cSitLst = 21;  cPrnDoc = 41;  cDocFlt = 61;  cCasFnc = 80;  cMntFnc = 100;  cSerFnc = 120;  cItmAdd = 141;
   cDocDel = 02;  cAccLst = 22;  cPrnStd = 42;  cDocStp = 62;                                                 cItmDel = 142;
   cDocMod = 03;  cNpaTcd = 23;                 cDocStr = 63;                                                 cItmMod = 143;
   cDocRnd = 04;  cNoiLst = 24;                 cAccDoc = 64;                                                 cPckItm = 144;
   cDocDsc = 05;  cNpyIcd = 25;                 cAccDel = 65;
   cDocLck = 06;                                cAccMas = 66;
   cDocUnl = 07;                                cIcgDoc = 67;
   cVatChg = 08;                                cIcgMas = 68;
                                                cFmdGen = 69;
                                                cOutStk = 70;
                                                cExdGen = 71;
                                                cDocClc = 72;
                                                cOitSnd = 73;
                                                cTrmOut = 74;
                                                cTrdCpr = 75;
                                                cDocMov = 76;
                                                cOmiFxa = 77;
                                                cWgdImp = 78;

// **************************************** OBJECT *****************************************

// ---------------------- ⁄pravy -------------------------

function TAfcTcb.ReadDocAdd:boolean;
begin
  Result := ReadData('TCB',cDocAdd);
end;

procedure TAfcTcb.WriteDocAdd(pValue:boolean);
begin
  WriteData('TCB',cDocAdd,pValue);
end;

function TAfcTcb.ReadDocDel:boolean;
begin
  Result := ReadData('TCB',cDocDel);
end;

procedure TAfcTcb.WriteDocDel(pValue:boolean);
begin
  WriteData('TCB',cDocDel,pValue);
end;

function TAfcTcb.ReadDocMod:boolean;
begin
  Result := ReadData('TCB',cDocMod);
end;

procedure TAfcTcb.WriteDocMod(pValue:boolean);
begin
  WriteData('TCB',cDocMod,pValue);
end;

function TAfcTcb.ReadDocRnd:boolean;
begin
  Result := ReadData('TCB',cDocRnd);
end;

procedure TAfcTcb.WriteDocRnd(pValue:boolean);
begin
  WriteData('TCB',cDocRnd,pValue);
end;

function TAfcTcb.ReadDocDsc:boolean;
begin
  Result := ReadData('TCB',cDocDsc);
end;

procedure TAfcTcb.WriteDocDsc(pValue:boolean);
begin
  WriteData('TCB',cDocDsc,pValue);
end;

function TAfcTcb.ReadDocLck:boolean;
begin
  Result := ReadData('TCB',cDocLck);
end;

procedure TAfcTcb.WriteDocLck(pValue:boolean);
begin
  WriteData('TCB',cDocLck,pValue);
end;

function TAfcTcb.ReadDocUnl:boolean;
begin
  Result := ReadData('TCB',cDocUnl);
end;

procedure TAfcTcb.WriteDocUnl(pValue:boolean);
begin
  WriteData('TCB',cDocUnl,pValue);
end;

function TAfcTcb.ReadVatChg:boolean;
begin
  Result := ReadData('TCB',cVatChg);
end;

procedure TAfcTcb.WriteVatChg(pValue:boolean);
begin
  WriteData('TCB',cVatChg,pValue);
end;

// ---------------------- Zobraziù -----------------------

function TAfcTcb.ReadSitLst:boolean;
begin
  Result := ReadData('TCB',cSitLst);
end;

procedure TAfcTcb.WriteSitLst(pValue:boolean);
begin
  WriteData('TCB',cSitLst,pValue);
end;

function TAfcTcb.ReadAccLst:boolean;
begin
  Result := ReadData('TCB',cAccLst);
end;

procedure TAfcTcb.WriteAccLst(pValue:boolean);
begin
  WriteData('TCB',cAccLst,pValue);
end;

function TAfcTcb.ReadNpaTcd:boolean;
begin
  Result := ReadData('TCB',cNpaTcd);
end;

procedure TAfcTcb.WriteNpaTcd(pValue:boolean);
begin
  WriteData('TCB',cNpaTcd,pValue);
end;

function TAfcTcb.ReadNoiLst:boolean;
begin
  Result := ReadData('TCB',cNoiLst);
end;

procedure TAfcTcb.WriteNoiLst(pValue:boolean);
begin
  WriteData('TCB',cNoiLst,pValue);
end;

function TAfcTcb.ReadNpyIcd:boolean;
begin
  Result := ReadData('TCB',cNpyIcd);
end;

procedure TAfcTcb.WriteNpyIcd(pValue:boolean);
begin
  WriteData('TCB',cNpyIcd,pValue);
end;

// ---------------------- TlaË ---------------------------

function TAfcTcb.ReadPrnDoc:boolean;
begin
  Result := ReadData('TCB',cPrnDoc);
end;

procedure TAfcTcb.WritePrnDoc(pValue:boolean);
begin
  WriteData('TCB',cPrnDoc,pValue);
end;

function TAfcTcb.ReadPrnStd:boolean;
begin
  Result := ReadData('TCB',cPrnStd);
end;

procedure TAfcTcb.WritePrnStd(pValue:boolean);
begin
  WriteData('TCB',cPrnStd,pValue);
end;

// ---------------------- N·stroje -----------------------

function TAfcTcb.ReadDocFlt:boolean;
begin
  Result := ReadData('TCB',cDocFlt);
end;

procedure TAfcTcb.WriteDocFlt(pValue:boolean);
begin
  WriteData('TCB',cDocFlt,pValue);
end;

function TAfcTcb.ReadDocStp:boolean;
begin
  Result := ReadData('TCB',cDocStp);
end;

procedure TAfcTcb.WriteDocStp(pValue:boolean);
begin
  WriteData('TCB',cDocStp,pValue);
end;

function TAfcTcb.ReadDocStr:boolean;
begin
  Result := ReadData('TCB',cDocStr);
end;

procedure TAfcTcb.WriteDocStr(pValue:boolean);
begin
  WriteData('TCB',cDocStr,pValue);
end;

function TAfcTcb.ReadAccDoc:boolean;
begin
  Result := ReadData('TCB',cAccDoc);
end;

procedure TAfcTcb.WriteAccDoc(pValue:boolean);
begin
  WriteData('TCB',cAccDoc,pValue);
end;

function TAfcTcb.ReadAccDel:boolean;
begin
  Result := ReadData('TCB',cAccDel);
end;

procedure TAfcTcb.WriteAccDel(pValue:boolean);
begin
  WriteData('TCB',cAccDel,pValue);
end;

function TAfcTcb.ReadAccMas:boolean;
begin
  Result := ReadData('TCB',cAccMas);
end;

procedure TAfcTcb.WriteAccMas(pValue:boolean);
begin
  WriteData('TCB',cAccMas,pValue);
end;

function TAfcTcb.ReadIcgDoc:boolean;
begin
  Result := ReadData('TCB',cIcgDoc);
end;

procedure TAfcTcb.WriteIcgDoc(pValue:boolean);
begin
  WriteData('TCB',cIcgDoc,pValue);
end;

function TAfcTcb.ReadIcgMas:boolean;
begin
  Result := ReadData('TCB',cIcgMas);
end;

procedure TAfcTcb.WriteIcgMas(pValue:boolean);
begin
  WriteData('TCB',cIcgMas,pValue);
end;

function TAfcTcb.ReadFmdGen:boolean;
begin
  Result := ReadData('TCB',cFmdGen);
end;

procedure TAfcTcb.WriteFmdGen(pValue:boolean);
begin
  WriteData('TCB',cFmdGen,pValue);
end;

function TAfcTcb.ReadExdGen:boolean;
begin
  Result := ReadData('TCB',cExdGen);
end;

procedure TAfcTcb.WriteOutStk(pValue:boolean);
begin
  WriteData('TCB',cOutStk,pValue);
end;

function TAfcTcb.ReadOutStk:boolean;
begin
  Result := ReadData('TCB',cOutStk);
end;

procedure TAfcTcb.WriteExdGen(pValue:boolean);
begin
  WriteData('TCB',cExdGen,pValue);
end;

function TAfcTcb.ReadDocClc:boolean;
begin
  Result := ReadData('TCB',cDocClc);
end;

procedure TAfcTcb.WriteDocClc(pValue:boolean);
begin
  WriteData('TCB',cDocClc,pValue);
end;

function TAfcTcb.ReadOitSnd:boolean;
begin
  Result := ReadData('TCB',cOitSnd);
end;

procedure TAfcTcb.WriteOitSnd(pValue:boolean);
begin
  WriteData('TCB',cOitSnd,pValue);
end;

function TAfcTcb.ReadTrmOut:boolean;
begin
  Result := ReadData('TCB',cTrmOut);
end;

procedure TAfcTcb.WriteTrmOut(pValue:boolean);
begin
  WriteData('TCB',cTrmOut,pValue);
end;

function TAfcTcb.ReadTrdCpr:boolean;
begin
  Result := ReadData('TCB',cTrdCpr);
end;

procedure TAfcTcb.WriteTrdCpr(pValue:boolean);
begin
  WriteData('TCB',cTrdCpr,pValue);
end;

function TAfcTcb.ReadDocMov:boolean;
begin
  Result := ReadData('TCB',cDocMov);
end;

procedure TAfcTcb.WriteDocMov(pValue:boolean);
begin
  WriteData('TCB',cDocMov,pValue);
end;

function TAfcTcb.ReadOmiFxa:boolean;
begin
  Result := ReadData('TCB',cOmiFxa);
end;

procedure TAfcTcb.WriteOmiFxa(pValue:boolean);
begin
  WriteData('TCB',cOmiFxa,pValue);
end;

function TAfcTcb.ReadWgdImp:boolean;
begin
  Result := ReadData('TCB',cWgdImp);
end;

procedure TAfcTcb.WriteWgdImp(pValue:boolean);
begin
  WriteData('TCB',cWgdImp,pValue);
end;

// ---------------------- PokladÚa -----------------------

function TAfcTcb.ReadCasFnc:boolean;
begin
  Result := ReadData('TCB',cCasFnc);
end;

procedure TAfcTcb.WriteCasFnc(pValue:boolean);
begin
  WriteData('TCB',cCasFnc,pValue);
end;

// ---------------------- ⁄drûba -------------------------

function TAfcTcb.ReadMntFnc:boolean;
begin
  Result := ReadData('TCB',cMntFnc);
end;

procedure TAfcTcb.WriteMntFnc(pValue:boolean);
begin
  WriteData('TCB',cMntFnc,pValue);
end;

// ---------------------- Servis -------------------------

function TAfcTcb.ReadSerFnc:boolean;
begin
  Result := ReadData('TCB',cSerFnc);
end;

procedure TAfcTcb.WriteSerFnc(pValue:boolean);
begin
  WriteData('TCB',cSerFnc,pValue);
end;

// ---------------------- Poloûky ------------------------

function TAfcTcb.ReadItmAdd:boolean;
begin
  Result := ReadData('TCB',cItmAdd);
end;

procedure TAfcTcb.WriteItmAdd(pValue:boolean);
begin
  WriteData('TCB',cItmAdd,pValue);
end;

function TAfcTcb.ReadItmDel:boolean;
begin
  Result := ReadData('TCB',cItmDel);
end;

procedure TAfcTcb.WriteItmDel(pValue:boolean);
begin
  WriteData('TCB',cItmDel,pValue);
end;

function TAfcTcb.ReadItmMod:boolean;
begin
  Result := ReadData('TCB',cItmMod);
end;

procedure TAfcTcb.WriteItmMod(pValue:boolean);
begin
  WriteData('TCB',cItmMod,pValue);
end;

function TAfcTcb.ReadPckItm:boolean;
begin
  Result := ReadData('TCB',cPckItm);
end;

procedure TAfcTcb.WritePckItm(pValue:boolean);
begin
  WriteData('TCB',cPckItm,pValue);
end;

end.
