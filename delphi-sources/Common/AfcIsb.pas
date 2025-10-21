unit AfcIsb;

interface

uses
  IcTypes, IcTools, NexPath, NexGlob, AfcBas,
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, NexBtrTable, Forms;

type
  TAfcISB = class (TAfcBas)
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
    function ReadDocEdi:boolean;    procedure WriteDocEdi(pValue:boolean);
    function ReadDocSpc:boolean;    procedure WriteDocSpc(pValue:boolean);
    function ReadItmRnd:boolean;    procedure WriteItmRnd(pValue:boolean);
    // ---------------------------- Zobraziù -----------------------------
    function ReadSitLst:boolean;    procedure WriteSitLst(pValue:boolean);
    function ReadAccLst:boolean;    procedure WriteAccLst(pValue:boolean);
    function ReadPayLst:boolean;    procedure WritePayLst(pValue:boolean);
    function ReadPmiLst:boolean;    procedure WritePmiLst(pValue:boolean);
    function ReadPqbLst:boolean;    procedure WritePqbLst(pValue:boolean);
    function ReadNpyIsd:boolean;    procedure WriteNpyIsd(pValue:boolean);
    function ReadIswLst:boolean;    procedure WriteIswLst(pValue:boolean);
    // ---------------------------- TlaË ---------------------------------
    function ReadPrnDoc:boolean;    procedure WritePrnDoc(pValue:boolean);
    function ReadPrnMas:boolean;    procedure WritePrnMas(pValue:boolean);
    function ReadPrnLst:boolean;    procedure WritePrnLst(pValue:boolean);
    // ---------------------------- N·stroje -----------------------------
    function ReadDocFlt:boolean;    procedure WriteDocFlt(pValue:boolean);
    function ReadAccDoc:boolean;    procedure WriteAccDoc(pValue:boolean);
    function ReadAccDel:boolean;    procedure WriteAccDel(pValue:boolean);
    function ReadAccMas:boolean;    procedure WriteAccMas(pValue:boolean);
    function ReadNodPar:boolean;    procedure WriteNodPar(pValue:boolean);
    function ReadTsdPar:boolean;    procedure WriteTsdPar(pValue:boolean);
    function ReadIsdPay:boolean;    procedure WriteIsdPay(pValue:boolean);
    function ReadIspEvl:boolean;    procedure WriteIspEvl(pValue:boolean);
    function ReadDocCpy:boolean;    procedure WriteDocCpy(pValue:boolean);
    function ReadIsdLiq:boolean;    procedure WriteIsdLiq(pValue:boolean);
    function ReadOitSnd:boolean;    procedure WriteOitSnd(pValue:boolean);
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
    property DocEdi:boolean read ReadDocEdi write WriteDocEdi;
    property DocSpc:boolean read ReadDocSpc write WriteDocSpc;
    property ItmRnd:boolean read ReadItmRnd write WriteItmRnd;
    // ---------------------- Zobraziù -----------------------
    property SitLst:boolean read ReadSitLst write WriteSitLst;
    property AccLst:boolean read ReadAccLst write WriteAccLst;
    property PayLst:boolean read ReadPayLst write WritePayLst;
    property PmiLst:boolean read ReadPmiLst write WritePmiLst;
    property PqbLst:boolean read ReadPqbLst write WritePqbLst;
    property NpyIsd:boolean read ReadNpyIsd write WriteNpyIsd;
    property IswLst:boolean read ReadIswLst write WriteIswLst;
    // ---------------------- TlaË ---------------------------
    property PrnDoc:boolean read ReadPrnDoc write WritePrnDoc;
    property PrnMas:boolean read ReadPrnMas write WritePrnMas;
    property PrnLst:boolean read ReadPrnLst write WritePrnLst;
    // ---------------------- N·stroje -----------------------
    property DocFlt:boolean read ReadDocFlt write WriteDocFlt;
    property AccDoc:boolean read ReadAccDoc write WriteAccDoc;
    property AccDel:boolean read ReadAccDel write WriteAccDel;
    property AccMas:boolean read ReadAccMas write WriteAccMas;
    property NodPar:boolean read ReadNodPar write WriteNodPar;
    property TsdPar:boolean read ReadTsdPar write WriteTsdPar;
    property IsdPay:boolean read ReadIsdPay write WriteIsdPay;
    property IspEvl:boolean read ReadIspEvl write WriteIspEvl;
    property DocCpy:boolean read ReadDocCpy write WriteDocCpy;
    property IsdLiq:boolean read ReadIsdLiq write WriteIsdLiq;
    property OitSnd:boolean read ReadOitSnd write WriteOitSnd;
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
   cDocDel = 02;  cAccLst = 22;  cPrnMas = 42;  cDocStp = 62;                                                 cItmDel = 142;
   cDocMod = 03;  cPayLst = 23;  cPrnLst = 43;  cDocStr = 63;                                                 cItmMod = 143;
   cDocRnd = 04;  cPqbLst = 24;                 cAccDoc = 64;
   cDocDsc = 05;  cNpyIsd = 25;                 cAccDel = 65;
   cDocLck = 06;  cPmiLst = 26;                 cAccMas = 66;
   cDocUnl = 07;  cIswLst = 27;                 cNodPar = 67;
   cVatChg = 08;                                cTsdPar = 68;
   cItmRnd = 09;                                cIsdPay = 69;
   cDocEdi = 10;                                cIspEvl = 70;
   cDocSpc = 11;                                cDocCpy = 71;
                                                cIsdLiq = 72;
                                                cOitSnd = 73;

// **************************************** OBJECT *****************************************

// ---------------------- ⁄pravy -------------------------

function TAfcISB.ReadDocAdd:boolean;
begin
  Result := ReadData('ISB',cDocAdd);
end;

procedure TAfcISB.WriteDocAdd(pValue:boolean);
begin
  WriteData('ISB',cDocAdd,pValue);
end;

function TAfcISB.ReadDocDel:boolean;
begin
  Result := ReadData('ISB',cDocDel);
end;

procedure TAfcISB.WriteDocDel(pValue:boolean);
begin
  WriteData('ISB',cDocDel,pValue);
end;

function TAfcISB.ReadDocMod:boolean;
begin
  Result := ReadData('ISB',cDocMod);
end;

procedure TAfcISB.WriteDocMod(pValue:boolean);
begin
  WriteData('ISB',cDocMod,pValue);
end;

function TAfcISB.ReadDocRnd:boolean;
begin
  Result := ReadData('ISB',cDocRnd);
end;

procedure TAfcISB.WriteDocRnd(pValue:boolean);
begin
  WriteData('ISB',cDocRnd,pValue);
end;

function TAfcISB.ReadDocDsc:boolean;
begin
  Result := ReadData('ISB',cDocDsc);
end;

procedure TAfcISB.WriteDocDsc(pValue:boolean);
begin
  WriteData('ISB',cDocDsc,pValue);
end;

function TAfcISB.ReadDocLck:boolean;
begin
  Result := ReadData('ISB',cDocLck);
end;

procedure TAfcISB.WriteDocLck(pValue:boolean);
begin
  WriteData('ISB',cDocLck,pValue);
end;

function TAfcISB.ReadDocUnl:boolean;
begin
  Result := ReadData('ISB',cDocUnl);
end;

procedure TAfcISB.WriteDocUnl(pValue:boolean);
begin
  WriteData('ISB',cDocUnl,pValue);
end;

function TAfcISB.ReadVatChg:boolean;
begin
  Result := ReadData('ISB',cVatChg);
end;

procedure TAfcISB.WriteVatChg(pValue:boolean);
begin
  WriteData('ISB',cVatChg,pValue);
end;

function TAfcISB.ReadDocEdi:boolean;
begin
  Result := ReadData('ISB',cDocEdi);
end;

procedure TAfcISB.WriteDocEdi(pValue:boolean);
begin
  WriteData('ISB',cDocEdi,pValue);
end;

function TAfcISB.ReadDocSpc:boolean;
begin
  Result := ReadData('ISB',cDocSpc);
end;

procedure TAfcISB.WriteDocSpc(pValue:boolean);
begin
  WriteData('ISB',cDocSpc,pValue);
end;

function TAfcISB.ReadItmRnd:boolean;
begin
  Result := ReadData('ISB',cItmRnd);
end;

procedure TAfcISB.WriteItmRnd(pValue:boolean);
begin
  WriteData('ISB',cItmRnd,pValue);
end;

// ---------------------- Zobraziù -----------------------

function TAfcISB.ReadSitLst:boolean;
begin
  Result := ReadData('ISB',cSitLst);
end;

procedure TAfcISB.WriteSitLst(pValue:boolean);
begin
  WriteData('ISB',cSitLst,pValue);
end;

function TAfcISB.ReadAccLst:boolean;
begin
  Result := ReadData('ISB',cAccLst);
end;

procedure TAfcISB.WriteAccLst(pValue:boolean);
begin
  WriteData('ISB',cAccLst,pValue);
end;

function TAfcISB.ReadPayLst:boolean;
begin
  Result := ReadData('ISB',cPayLst);
end;

procedure TAfcISB.WritePayLst(pValue:boolean);
begin
  WriteData('ISB',cPayLst,pValue);
end;

function TAfcISB.ReadPmiLst:boolean;
begin
  Result := ReadData('ISB',cPmiLst);
end;

procedure TAfcISB.WritePmiLst(pValue:boolean);
begin
  WriteData('ISB',cPmiLst,pValue);
end;

function TAfcISB.ReadPqbLst:boolean;
begin
  Result := ReadData('ISB',cPqbLst);
end;

procedure TAfcISB.WritePqbLst(pValue:boolean);
begin
  WriteData('ISB',cPqbLst,pValue);
end;

function TAfcISB.ReadNpyIsd:boolean;
begin
  Result := ReadData('ISB',cNpyIsd);
end;

procedure TAfcISB.WriteNpyIsd(pValue:boolean);
begin
  WriteData('ISB',cNpyIsd,pValue);
end;

function TAfcISB.ReadIswLst:boolean;
begin
  Result := ReadData('ISB',cIswLst);
end;

procedure TAfcISB.WriteIswLst(pValue:boolean);
begin
  WriteData('ISB',cIswLst,pValue);
end;

// ---------------------- TlaË ---------------------------

function TAfcISB.ReadPrnDoc:boolean;
begin
  Result := ReadData('ISB',cPrnDoc);
end;

procedure TAfcISB.WritePrnDoc(pValue:boolean);
begin
  WriteData('ISB',cPrnDoc,pValue);
end;

function TAfcISB.ReadPrnMas:boolean;
begin
  Result := ReadData('ISB',cPrnMas);
end;

procedure TAfcISB.WritePrnMas(pValue:boolean);
begin
  WriteData('ISB',cPrnMas,pValue);
end;

function TAfcISB.ReadPrnLst:boolean;
begin
  Result := ReadData('ISB',cPrnLst);
end;

procedure TAfcISB.WritePrnLst(pValue:boolean);
begin
  WriteData('ISB',cPrnLst,pValue);
end;

// ---------------------- N·stroje -----------------------

function TAfcISB.ReadDocFlt:boolean;
begin
  Result := ReadData('ISB',cDocFlt);
end;

procedure TAfcISB.WriteDocFlt(pValue:boolean);
begin
  WriteData('ISB',cDocFlt,pValue);
end;

function TAfcISB.ReadAccDoc:boolean;
begin
  Result := ReadData('ISB',cAccDoc);
end;

procedure TAfcISB.WriteAccDoc(pValue:boolean);
begin
  WriteData('ISB',cAccDoc,pValue);
end;

function TAfcISB.ReadAccDel:boolean;
begin
  Result := ReadData('ISB',cAccDel);
end;

procedure TAfcISB.WriteAccDel(pValue:boolean);
begin
  WriteData('ISB',cAccDel,pValue);
end;

function TAfcISB.ReadAccMas:boolean;
begin
  Result := ReadData('ISB',cAccMas);
end;

procedure TAfcISB.WriteAccMas(pValue:boolean);
begin
  WriteData('ISB',cAccMas,pValue);
end;

function TAfcISB.ReadNodPar:boolean;
begin
  Result := ReadData('ISB',cNodPar);
end;

procedure TAfcISB.WriteNodPar(pValue:boolean);
begin
  WriteData('ISB',cNodPar,pValue);
end;

function TAfcISB.ReadTsdPar:boolean;
begin
  Result := ReadData('ISB',cTsdPar);
end;

procedure TAfcISB.WriteTsdPar(pValue:boolean);
begin
  WriteData('ISB',cTsdPar,pValue);
end;

function TAfcISB.ReadIsdPay:boolean;
begin
  Result := ReadData('ISB',cIsdPay);
end;

procedure TAfcISB.WriteIsdPay(pValue:boolean);
begin
  WriteData('ISB',cIsdPay,pValue);
end;

function TAfcISB.ReadDocCpy:boolean;
begin
  Result := ReadData('ISB',cDocCpy);
end;

procedure TAfcISB.WriteIspEvl(pValue:boolean);
begin
  WriteData('ISB',cIspEvl,pValue);
end;

function TAfcISB.ReadIspEvl:boolean;
begin
  Result := ReadData('ISB',cIspEvl);
end;

procedure TAfcISB.WriteDocCpy(pValue:boolean);
begin
  WriteData('ISB',cDocCpy,pValue);
end;

function TAfcISB.ReadIsdLiq:boolean;
begin
  Result := ReadData('ISB',cIsdLiq);
end;

procedure TAfcISB.WriteIsdLiq(pValue:boolean);
begin
  WriteData('ISB',cIsdLiq,pValue);
end;

function TAfcISB.ReadOitSnd:boolean;
begin
  Result := ReadData('ISB',cOitSnd);
end;

procedure TAfcISB.WriteOitSnd(pValue:boolean);
begin
  WriteData('ISB',cOitSnd,pValue);
end;

// ---------------------- ⁄drûba -------------------------

function TAfcISB.ReadMntFnc:boolean;
begin
  Result := ReadData('ISB',cMntFnc);
end;

procedure TAfcISB.WriteMntFnc(pValue:boolean);
begin
  WriteData('ISB',cMntFnc,pValue);
end;

// ---------------------- Servis -------------------------

function TAfcISB.ReadSerFnc:boolean;
begin
  Result := ReadData('ISB',cSerFnc);
end;

procedure TAfcISB.WriteSerFnc(pValue:boolean);
begin
  WriteData('ISB',cSerFnc,pValue);
end;

// ---------------------- Poloûky ------------------------

function TAfcISB.ReadItmAdd:boolean;
begin
  Result := ReadData('ISB',cItmAdd);
end;

procedure TAfcISB.WriteItmAdd(pValue:boolean);
begin
  WriteData('ISB',cItmAdd,pValue);
end;

function TAfcISB.ReadItmDel:boolean;
begin
  Result := ReadData('ISB',cItmDel);
end;

procedure TAfcISB.WriteItmDel(pValue:boolean);
begin
  WriteData('ISB',cItmDel,pValue);
end;

function TAfcISB.ReadItmMod:boolean;
begin
  Result := ReadData('ISB',cItmMod);
end;

procedure TAfcISB.WriteItmMod(pValue:boolean);
begin
  WriteData('ISB',cItmMod,pValue);
end;

end.
