unit AfcIcb;

interface

uses
  IcTypes, IcTools, NexPath, NexGlob, AfcBas,
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, NexBtrTable, Forms;

type
  TAfcIcb = class (TAfcBas)
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
    function ReadDocSpc:boolean;    procedure WriteDocSpc(pValue:boolean);
    // ---------------------------- Zobraziù -----------------------------
    function ReadSitLst:boolean;    procedure WriteSitLst(pValue:boolean);
    function ReadAccLst:boolean;    procedure WriteAccLst(pValue:boolean);
    function ReadPayLst:boolean;    procedure WritePayLst(pValue:boolean);
    function ReadNopIch:boolean;    procedure WriteNopIch(pValue:boolean);
    function ReadSpeLst:boolean;    procedure WriteSpeLst(pValue:boolean);
    function ReadNpyIcd:boolean;    procedure WriteNpyIcd(pValue:boolean);
    function ReadPmiLst:boolean;    procedure WritePmiLst(pValue:boolean);
    function ReadIcwLst:boolean;    procedure WriteIcwLst(pValue:boolean);
    // ---------------------------- TlaË ---------------------------------
    function ReadPrnDoc:boolean;    procedure WritePrnDoc(pValue:boolean);
    function ReadPrnAcc:boolean;    procedure WritePrnAcc(pValue:boolean);
    function ReadPrnIcd: boolean;   procedure WritePrnIcd(pValue: boolean);
    function ReadPrnLiq: boolean;   procedure WritePrnLiq(pValue: boolean);
    function ReadPrnLst: boolean;   procedure WritePrnLst(pValue: boolean);
    function ReadPrnMas: boolean;   procedure WritePrnMas(pValue: boolean);
    function ReadPrnSum: boolean;   procedure WritePrnSum(pValue: boolean);
    // ---------------------------- N·stroje -----------------------------
    function ReadDocFlt:boolean;    procedure WriteDocFlt(pValue:boolean);
    function ReadGscSrc:boolean;    procedure WriteGscSrc(pValue:boolean);
    function ReadAccPer:boolean;    procedure WriteAccPer(pValue:boolean);
    function ReadAccDoc:boolean;    procedure WriteAccDoc(pValue:boolean);
    function ReadAccDel:boolean;    procedure WriteAccDel(pValue:boolean);
    function ReadAccMas:boolean;    procedure WriteAccMas(pValue:boolean);
    function ReadTcdGen:boolean;    procedure WriteTcdGen(pValue:boolean);
    function ReadTcdPar:boolean;    procedure WriteTcdPar(pValue:boolean);
    function ReadTcdCon:boolean;    procedure WriteTcdCon(pValue:boolean);
    function ReadCsdGen:boolean;    procedure WriteCsdGen(pValue:boolean);
    function ReadCrdPay:boolean;    procedure WriteCrdPay(pValue:boolean);
    function ReadSpeInc:boolean;    procedure WriteSpeInc(pValue:boolean);
    function ReadSpeExp:boolean;    procedure WriteSpeExp(pValue:boolean);
    function ReadNpaIcd:boolean;    procedure WriteNpaIcd(pValue:boolean);
    function ReadIcdPay:boolean;    procedure WriteIcdPay(pValue:boolean);
    function ReadIcdPer:boolean;    procedure WriteIcdPer(pValue:boolean);
    function ReadIcdWrn:boolean;    procedure WriteIcdWrn(pValue:boolean);
    function ReadPenGen:boolean;    procedure WritePenGen(pValue:boolean);
    function ReadNopIci:boolean;    procedure WriteNopIci(pValue:boolean);
    function ReadIciRep:boolean;    procedure WriteIciRep(pValue:boolean);
    function ReadIciSum:boolean;    procedure WriteIciSum(pValue:boolean);
    function ReadDocCpy:boolean;    procedure WriteDocCpy(pValue:boolean);
    function ReadIcdEml:boolean;    procedure WriteIcdEml(pValue:boolean);
    // ---------------------------- PokladÚa -----------------------------
    function ReadCasFnc:boolean;    procedure WriteCasFnc(pValue:boolean);
    // ---------------------------- Exp+Imp ------------------------------
    function ReadExpImp:boolean;    procedure WriteExpImp(pValue:boolean);
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
    property DocSpc:boolean read ReadDocSpc write WriteDocSpc;
    // ---------------------- Zobraziù -----------------------
    property SitLst:boolean read ReadSitLst write WriteSitLst;
    property AccLst:boolean read ReadAccLst write WriteAccLst;
    property PayLst:boolean read ReadPayLst write WritePayLst;
    property NopIch:boolean read ReadNopIch write WriteNopIch;
    property SpeLst:boolean read ReadSpeLst write WriteSpeLst;
    property NpyIcd:boolean read ReadNpyIcd write WriteNpyIcd;
    property PmiLst:boolean read ReadPmiLst write WritePmiLst;
    property IcwLst:boolean read ReadIcwLst write WriteIcwLst;
    // ---------------------- TlaË ---------------------------
    property PrnDoc:boolean read ReadPrnDoc write WritePrnDoc;
    property PrnAcc:boolean read ReadPrnAcc write WritePrnAcc;
    property PrnMas:boolean read ReadPrnMas write WritePrnMas;
    property PrnLst:boolean read ReadPrnLst write WritePrnLst;
    property PrnIcd:boolean read ReadPrnIcd write WritePrnIcd;
    property PrnLiq:boolean read ReadPrnLiq write WritePrnLiq;
    property PrnSum:boolean read ReadPrnSum write WritePrnSum;
    // ---------------------- N·stroje -----------------------
    property DocFlt:boolean read ReadDocFlt write WriteDocFlt;
    property GscSrc:boolean read ReadGscSrc write WriteGscSrc;
    property AccPer:boolean read ReadAccPer write WriteAccPer;
    property AccDoc:boolean read ReadAccDoc write WriteAccDoc;
    property AccDel:boolean read ReadAccDel write WriteAccDel;
    property AccMas:boolean read ReadAccMas write WriteAccMas;
    property TcdGen:boolean read ReadTcdGen write WriteTcdGen;
    property TcdPar:boolean read ReadTcdPar write WriteTcdPar;
    property TcdCon:boolean read ReadTcdCon write WriteTcdCon;
    property CsdGen:boolean read ReadCsdGen write WriteCsdGen;
    property CrdPay:boolean read ReadCrdPay write WriteCrdPay;
    property SpeInc:boolean read ReadSpeInc write WriteSpeInc;
    property SpeExp:boolean read ReadSpeExp write WriteSpeExp;
    property NpaIcd:boolean read ReadNpaIcd write WriteNpaIcd;
    property IcdPay:boolean read ReadIcdPay write WriteIcdPay;
    property IcdPer:boolean read ReadIcdPer write WriteIcdPer;
    property IcdWrn:boolean read ReadIcdWrn write WriteIcdWrn;
    property PenGen:boolean read ReadPenGen write WritePenGen;
    property NopIci:boolean read ReadNopIci write WriteNopIci;
    property IciRep:boolean read ReadIciRep write WriteIciRep;
    property IciSum:boolean read ReadIciSum write WriteIciSum;
    property DocCpy:boolean read ReadDocCpy write WriteDocCpy;
    property IcdEml:boolean read ReadIcdEml write WriteIcdEml;
    // ---------------------- PokladÚa -----------------------
    property CasFnc:boolean read ReadCasFnc write WriteCasFnc;
    // ----------------------- ExpImp ------------------------
    property ExpImp:boolean read ReadExpImp write WriteExpImp;
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
// Upravy ------  Zobrazit ----  Tlac --------  N·stroje ----  PokladÚa ----  ⁄drzba -------  Servis ------   Polozky ------
   cDocAdd = 01;  cSitLst = 21;  cPrnDoc = 41;  cDocFlt = 61;  cCasFnc = 90;  cMntFnc = 110;  cSerFnc = 120;  cItmAdd = 141;
   cDocDel = 02;  cAccLst = 22;  cPrnSum = 42;  cGscSrc = 62;  cExpImp = 100;                                 cItmDel = 142;
   cDocMod = 03;  cNopIch = 23;  cPrnAcc = 43;  cAccPer = 63;                                                 cItmMod = 143;
   cDocRnd = 04;  cSpeLst = 24;  cPrnMas = 44;  cAccDoc = 64;
   cDocDsc = 05;  cPmiLst = 25;  cPrnLst = 45;  cAccDel = 65;
   cDocLck = 06;  cPayLst = 26;  cPrnIcd = 46;  cAccMas = 66;
   cDocUnl = 07;  cIcwLst = 27;  cPrnLiq = 47;  cTcdGen = 67;
   cVatChg = 08;  cNpyIcd = 28;                 cTcdPar = 68;
   cDocSpc = 09;                                cTcdCon = 69;
                                                cCsdGen = 70;
                                                cCrdPay = 71;
                                                cSpeInc = 72;
                                                cSpeExp = 73;
                                                cNpaIcd = 74;
                                                cIcdPay = 75;
                                                cIcdPer = 76;
                                                cIcdWrn = 77;
                                                cPenGen = 78;
                                                cNopIci = 79;
                                                cIciRep = 80;
                                                cIciSum = 81;
                                                cDocCpy = 82;
                                                cIcdEml = 83;

// **************************************** OBJECT *****************************************

// ---------------------- ⁄pravy -------------------------

function TAfcIcb.ReadDocAdd:boolean;
begin
  Result := ReadData('ICB',cDocAdd);
end;

procedure TAfcIcb.WriteDocAdd(pValue:boolean);
begin
  WriteData('ICB',cDocAdd,pValue);
end;

function TAfcIcb.ReadDocDel:boolean;
begin
  Result := ReadData('ICB',cDocDel);
end;

procedure TAfcIcb.WriteDocDel(pValue:boolean);
begin
  WriteData('ICB',cDocDel,pValue);
end;

function TAfcIcb.ReadDocMod:boolean;
begin
  Result := ReadData('ICB',cDocMod);
end;

procedure TAfcIcb.WriteDocMod(pValue:boolean);
begin
  WriteData('ICB',cDocMod,pValue);
end;

function TAfcIcb.ReadDocRnd:boolean;
begin
  Result := ReadData('ICB',cDocRnd);
end;

procedure TAfcIcb.WriteDocRnd(pValue:boolean);
begin
  WriteData('ICB',cDocRnd,pValue);
end;

function TAfcIcb.ReadDocDsc:boolean;
begin
  Result := ReadData('ICB',cDocDsc);
end;

procedure TAfcIcb.WriteDocDsc(pValue:boolean);
begin
  WriteData('ICB',cDocDsc,pValue);
end;

function TAfcIcb.ReadDocLck:boolean;
begin
  Result := ReadData('ICB',cDocLck);
end;

procedure TAfcIcb.WriteDocLck(pValue:boolean);
begin
  WriteData('ICB',cDocLck,pValue);
end;

function TAfcIcb.ReadDocUnl:boolean;
begin
  Result := ReadData('ICB',cDocUnl);
end;

procedure TAfcIcb.WriteDocUnl(pValue:boolean);
begin
  WriteData('ICB',cDocUnl,pValue);
end;

function TAfcIcb.ReadVatChg:boolean;
begin
  Result := ReadData('ICB',cVatChg);
end;

procedure TAfcIcb.WriteVatChg(pValue:boolean);
begin
  WriteData('ICB',cVatChg,pValue);
end;

function TAfcIcb.ReadDocSpc:boolean;
begin
  Result := ReadData('ICB',cDocSpc);
end;

procedure TAfcIcb.WriteDocSpc(pValue:boolean);
begin
  WriteData('ICB',cDocSpc,pValue);
end;

// ---------------------- Zobraziù -----------------------

function TAfcIcb.ReadSitLst:boolean;
begin
  Result := ReadData('ICB',cSitLst);
end;

procedure TAfcIcb.WriteSitLst(pValue:boolean);
begin
  WriteData('ICB',cSitLst,pValue);
end;

function TAfcIcb.ReadAccLst:boolean;
begin
  Result := ReadData('ICB',cAccLst);
end;

procedure TAfcIcb.WriteAccLst(pValue:boolean);
begin
  WriteData('ICB',cAccLst,pValue);
end;

function TAfcIcb.ReadPayLst:boolean;
begin
  Result := ReadData('ICB',cPayLst);
end;

procedure TAfcIcb.WritePayLst(pValue:boolean);
begin
  WriteData('ICB',cPayLst,pValue);
end;

function TAfcIcb.ReadNopIch:boolean;
begin
  Result := ReadData('ICB',cNopIch);
end;

procedure TAfcIcb.WriteNopIch(pValue:boolean);
begin
  WriteData('ICB',cNopIch,pValue);
end;

function TAfcIcb.ReadSpeLst:boolean;
begin
  Result := ReadData('ICB',cSpeLst);
end;

procedure TAfcIcb.WriteSpeLst(pValue:boolean);
begin
  WriteData('ICB',cSpeLst,pValue);
end;

function TAfcIcb.ReadNpyIcd:boolean;
begin
  Result := ReadData('ICB',cNpaIcd);
end;

procedure TAfcIcb.WriteNpyIcd(pValue:boolean);
begin
  WriteData('ICB',cNpyIcd,pValue);
end;

function TAfcIcb.ReadPmiLst:boolean;
begin
  Result := ReadData('ICB',cPmiLst);
end;

procedure TAfcIcb.WritePmiLst(pValue:boolean);
begin
  WriteData('ICB',cPmiLst,pValue);
end;

function TAfcIcb.ReadIcwLst:boolean;
begin
  Result := ReadData('ICB',cIcwLst);
end;

procedure TAfcIcb.WriteIcwLst(pValue:boolean);
begin
  WriteData('ICB',cIcwLst,pValue);
end;

// ---------------------- TlaË ---------------------------

function TAfcIcb.ReadPrnDoc:boolean;
begin
  Result := ReadData('ICB',cPrnDoc);
end;

procedure TAfcIcb.WritePrnDoc(pValue:boolean);
begin
  WriteData('ICB',cPrnDoc,pValue);
end;

function TAfcIcb.ReadPrnAcc:boolean;
begin
  Result := ReadData('ICB',cPrnAcc);
end;

procedure TAfcIcb.WritePrnAcc(pValue:boolean);
begin
  WriteData('ICB',cPrnAcc,pValue);
end;

function TAfcIcb.ReadPrnIcd: boolean;
begin
  Result := ReadData('ICB',cPrnIcd);
end;

procedure TAfcIcb.WritePrnIcd(pValue: boolean);
begin
  WriteData('ICB',cPrnIcd,pValue);
end;

function TAfcIcb.ReadPrnLiq: boolean;
begin
  Result := ReadData('ICB',cPrnLiq);
end;

procedure TAfcIcb.WritePrnLiq(pValue: boolean);
begin
  WriteData('ICB',cPrnLiq,pValue);
end;

function TAfcIcb.ReadPrnLst: boolean;
begin
  Result := ReadData('ICB',cPrnLst);
end;

procedure TAfcIcb.WritePrnLst(pValue: boolean);
begin
  WriteData('ICB',cPrnLst,pValue);
end;

function TAfcIcb.ReadPrnMas: boolean;
begin
  Result := ReadData('ICB',cPrnMas);
end;

procedure TAfcIcb.WritePrnMas(pValue: boolean);
begin
  WriteData('ICB',cPrnMas,pValue);
end;

function TAfcIcb.ReadPrnSum: boolean;
begin
  Result := ReadData('ICB',cPrnSum);
end;

procedure TAfcIcb.WritePrnSum(pValue: boolean);
begin
  WriteData('ICB',cPrnSum,pValue);
end;

// ---------------------- N·stroje -----------------------

function TAfcIcb.ReadDocFlt:boolean;
begin
  Result := ReadData('ICB',cDocFlt);
end;

procedure TAfcIcb.WriteDocFlt(pValue:boolean);
begin
  WriteData('ICB',cDocFlt,pValue);
end;

function TAfcIcb.ReadGscSrc:boolean;
begin
  Result := ReadData('ICB',cGscSrc);
end;

procedure TAfcIcb.WriteGscSrc(pValue:boolean);
begin
  WriteData('ICB',cGscSrc,pValue);
end;

function TAfcIcb.ReadAccPer:boolean;
begin
  Result := ReadData('ICB',cAccPer);
end;

procedure TAfcIcb.WriteAccPer(pValue:boolean);
begin
  WriteData('ICB',cAccPer,pValue);
end;

function TAfcIcb.ReadAccDoc:boolean;
begin
  Result := ReadData('ICB',cAccDoc);
end;

procedure TAfcIcb.WriteAccDoc(pValue:boolean);
begin
  WriteData('ICB',cAccDoc,pValue);
end;

function TAfcIcb.ReadAccDel:boolean;
begin
  Result := ReadData('ICB',cAccDel);
end;

procedure TAfcIcb.WriteAccDel(pValue:boolean);
begin
  WriteData('ICB',cAccDel,pValue);
end;

function TAfcIcb.ReadAccMas:boolean;
begin
  Result := ReadData('ICB',cAccMas);
end;

procedure TAfcIcb.WriteAccMas(pValue:boolean);
begin
  WriteData('ICB',cAccMas,pValue);
end;

function TAfcIcb.ReadTcdGen:boolean;
begin
  Result := ReadData('ICB',cTcdGen);
end;

procedure TAfcIcb.WriteTcdGen(pValue:boolean);
begin
  WriteData('ICB',cTcdGen,pValue);
end;

function TAfcIcb.ReadTcdPar:boolean;
begin
  Result := ReadData('ICB',cTcdPar);
end;

procedure TAfcIcb.WriteTcdPar(pValue:boolean);
begin
  WriteData('ICB',cTcdPar,pValue);
end;

function TAfcIcb.ReadTcdCon:boolean;
begin
  Result := ReadData('ICB',cTcdCon);
end;

procedure TAfcIcb.WriteTcdCon(pValue:boolean);
begin
  WriteData('ICB',cTcdCon,pValue);
end;

function TAfcIcb.ReadCrdPay:boolean;
begin
  Result := ReadData('ICB',cCrdPay);
end;

procedure TAfcIcb.WriteCsdGen(pValue:boolean);
begin
  WriteData('ICB',cCsdGen,pValue);
end;

function TAfcIcb.ReadCsdGen:boolean;
begin
  Result := ReadData('ICB',cCsdGen);
end;

procedure TAfcIcb.WriteCrdPay(pValue:boolean);
begin
  WriteData('ICB',cCrdPay,pValue);
end;

function TAfcIcb.ReadSpeInc:boolean;
begin
  Result := ReadData('ICB',cSpeInc);
end;

procedure TAfcIcb.WriteSpeInc(pValue:boolean);
begin
  WriteData('ICB',cSpeInc,pValue);
end;

function TAfcIcb.ReadSpeExp:boolean;
begin
  Result := ReadData('ICB',cSpeExp);
end;

procedure TAfcIcb.WriteSpeExp(pValue:boolean);
begin
  WriteData('ICB',cSpeExp,pValue);
end;

function TAfcIcb.ReadNpaIcd:boolean;
begin
  Result := ReadData('ICB',cNpaIcd);
end;

procedure TAfcIcb.WriteNpaIcd(pValue:boolean);
begin
  WriteData('ICB',cNpaIcd,pValue);
end;

function TAfcIcb.ReadIcdPay:boolean;
begin
  Result := ReadData('ICB',cIcdPay);
end;

procedure TAfcIcb.WriteIcdPay(pValue:boolean);
begin
  WriteData('ICB',cIcdPay,pValue);
end;

function TAfcIcb.ReadIcdPer:boolean;
begin
  Result := ReadData('ICB',cIcdPer);
end;

procedure TAfcIcb.WriteIcdPer(pValue:boolean);
begin
  WriteData('ICB',cIcdPer,pValue);
end;

function TAfcIcb.ReadIcdWrn:boolean;
begin
  Result := ReadData('ICB',cIcdWrn);
end;

procedure TAfcIcb.WriteIcdWrn(pValue:boolean);
begin
  WriteData('ICB',cIcdWrn,pValue);
end;

function TAfcIcb.ReadPenGen:boolean;
begin
  Result := ReadData('ICB',cPenGen);
end;

procedure TAfcIcb.WritePenGen(pValue:boolean);
begin
  WriteData('ICB',cPenGen,pValue);
end;

function TAfcIcb.ReadDocCpy: boolean;
begin
  Result := ReadData('ICB',cDocCpy);
end;

procedure TAfcIcb.WriteDocCpy(pValue: boolean);
begin
  WriteData('ICB',cDocCpy,pValue);
end;

function TAfcIcb.ReadIcdEml: boolean;
begin
  Result := ReadData('ICB',cIcdEml);
end;

procedure TAfcIcb.WriteIcdEml(pValue: boolean);
begin
  WriteData('ICB',cIcdEml,pValue);
end;

function TAfcIcb.ReadIciRep: boolean;
begin
  Result := ReadData('ICB',cIciRep);
end;

procedure TAfcIcb.WriteIciRep(pValue: boolean);
begin
  WriteData('ICB',cIciRep,pValue);
end;

function TAfcIcb.ReadIciSum: boolean;
begin
  Result := ReadData('ICB',cIciSum);
end;

procedure TAfcIcb.WriteIciSum(pValue: boolean);
begin
  WriteData('ICB',cIciSum,pValue);
end;

function TAfcIcb.ReadNopIci: boolean;
begin
  Result := ReadData('ICB',cNopIci);
end;

procedure TAfcIcb.WriteNopIci(pValue: boolean);
begin
  WriteData('ICB',cNopIci,pValue);
end;

// ---------------------- PokladÚa -----------------------

function TAfcIcb.ReadCasFnc:boolean;
begin
  Result := ReadData('ICB',cCasFnc);
end;

procedure TAfcIcb.WriteCasFnc(pValue:boolean);
begin
  WriteData('ICB',cCasFnc,pValue);
end;

// ------------------- Export import ---------------------

function TAfcIcb.ReadExpImp:boolean;
begin
  Result := ReadData('ICB',cExpImp);
end;

procedure TAfcIcb.WriteExpImp(pValue:boolean);
begin
  WriteData('ICB',cExpImp,pValue);
end;

// ---------------------- ⁄drûba -------------------------

function TAfcIcb.ReadMntFnc:boolean;
begin
  Result := ReadData('ICB',cMntFnc);
end;

procedure TAfcIcb.WriteMntFnc(pValue:boolean);
begin
  WriteData('ICB',cMntFnc,pValue);
end;

// ---------------------- Servis -------------------------

function TAfcIcb.ReadSerFnc:boolean;
begin
  Result := ReadData('ICB',cSerFnc);
end;

procedure TAfcIcb.WriteSerFnc(pValue:boolean);
begin
  WriteData('ICB',cSerFnc,pValue);
end;

// ---------------------- Poloûky ------------------------

function TAfcIcb.ReadItmAdd:boolean;
begin
  Result := ReadData('ICB',cItmAdd);
end;

procedure TAfcIcb.WriteItmAdd(pValue:boolean);
begin
  WriteData('ICB',cItmAdd,pValue);
end;

function TAfcIcb.ReadItmDel:boolean;
begin
  Result := ReadData('ICB',cItmDel);
end;

procedure TAfcIcb.WriteItmDel(pValue:boolean);
begin
  WriteData('ICB',cItmDel,pValue);
end;

function TAfcIcb.ReadItmMod:boolean;
begin
  Result := ReadData('ICB',cItmMod);
end;

procedure TAfcIcb.WriteItmMod(pValue:boolean);
begin
  WriteData('ICB',cItmMod,pValue);
end;

end.
