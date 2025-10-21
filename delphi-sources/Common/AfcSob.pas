unit AfcSob;

interface

uses
  IcTypes, IcTools, NexPath, NexGlob, AfcBas,
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, NexBtrTable, Forms;

type
  TAfcSob = class (TAfcBas)
  private
    // ---------------------------- ⁄pravy -------------------------------
    function ReadDocAdd:boolean;    procedure WriteDocAdd(pValue:boolean);
    function ReadDocDel:boolean;    procedure WriteDocDel(pValue:boolean);
    function ReadDocMod:boolean;    procedure WriteDocMod(pValue:boolean);
    function ReadDocLck:boolean;    procedure WriteDocLck(pValue:boolean);
    function ReadDocUnl:boolean;    procedure WriteDocUnl(pValue:boolean);
    function ReadDocSpc:boolean;    procedure WriteDocSpc(pValue:boolean);
    // ---------------------------- Zobraziù -----------------------------
    function ReadSitLst:boolean;    procedure WriteSitLst(pValue:boolean);
    function ReadAccLst:boolean;    procedure WriteAccLst(pValue:boolean);
    function ReadPmiLst:boolean;    procedure WritePmiLst(pValue:boolean);
    // ---------------------------- TlaË ---------------------------------
    function ReadPrnDoc:boolean;    procedure WritePrnDoc(pValue:boolean);
    // ---------------------------- N·stroje -----------------------------
    function ReadDocFlt:boolean;    procedure WriteDocFlt(pValue:boolean);
    function ReadEndClc:boolean;    procedure WriteEndClc(pValue:boolean);
    function ReadAccDoc:boolean;    procedure WriteAccDoc(pValue:boolean);
    function ReadAccDel:boolean;    procedure WriteAccDel(pValue:boolean);
    function ReadAccMas:boolean;    procedure WriteAccMas(pValue:boolean);
    function ReadOitSnd:boolean;    procedure WriteOitSnd(pValue:boolean);
    function ReadSomLst:boolean;    procedure WriteSomLst(pValue:boolean);
    function ReadAboRcv:boolean;    procedure WriteAboRcv(pValue:boolean);
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
    property DocUnl:boolean read ReadDocUnl write WriteDocUnl;
    property DocLck:boolean read ReadDocLck write WriteDocLck;
    property DocMod:boolean read ReadDocMod write WriteDocMod;
    property DocSpc:boolean read ReadDocSpc write WriteDocSpc;
    // ---------------------- Zobraziù -----------------------
    property SitLst:boolean read ReadSitLst write WriteSitLst;
    property AccLst:boolean read ReadAccLst write WriteAccLst;
    property PmiLst:boolean read ReadPmiLst write WritePmiLst;
    // ---------------------- TlaË ---------------------------
    property PrnDoc:boolean read ReadPrnDoc write WritePrnDoc;
    // ---------------------- N·stroje -----------------------
    property DocFlt:boolean read ReadDocFlt write WriteDocFlt;
    property EndClc:boolean read ReadEndClc write WriteEndClc;
    property AccDoc:boolean read ReadAccDoc write WriteAccDoc;
    property AccDel:boolean read ReadAccDel write WriteAccDel;
    property AccMas:boolean read ReadAccMas write WriteAccMas;
    property OitSnd:boolean read ReadOitSnd write WriteOitSnd;
    property SomLst:boolean read ReadSomLst write WriteSomLst;
    property AboRcv:boolean read ReadAboRcv write WriteAboRcv;
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
   cDocDel = 02;  cAccLst = 22;  cYebPrn = 42;  cEndClc = 62;                                  cItmDel = 142;
   cDocMod = 03;  cCsoInc = 23;  cMtbPrn = 43;  cAccDoc = 63;                                  cItmMod = 143;
   cDocRnd = 04;  cCsoExp = 24;                 cAccDel = 64;
   cDocDsc = 05;  cOrgDoc = 25;                 cAccMas = 65;
   cDocLck = 06;  cPmiLst = 26;                 cOitSnd = 66;
   cDocUnl = 07;                                cSomLst = 67;
   cVatChg = 08;                                cAboRcv = 68;
   cDocSpc = 09;










// **************************************** OBJECT *****************************************

// ---------------------- ⁄pravy -------------------------

function TAfcSob.ReadDocAdd:boolean;
begin
  Result := ReadData('SOB',cDocAdd);
end;

procedure TAfcSob.WriteDocAdd(pValue:boolean);
begin
  WriteData('SOB',cDocAdd,pValue);
end;

function TAfcSob.ReadDocDel:boolean;
begin
  Result := ReadData('SOB',cDocDel);
end;

procedure TAfcSob.WriteDocDel(pValue:boolean);
begin
  WriteData('SOB',cDocDel,pValue);
end;

function TAfcSob.ReadDocMod:boolean;
begin
  Result := ReadData('SOB',cDocMod);
end;

procedure TAfcSob.WriteDocMod(pValue:boolean);
begin
  WriteData('SOB',cDocMod,pValue);
end;

function TAfcSob.ReadDocSpc:boolean;
begin
  Result := ReadData('SOB',cDocSpc);
end;

procedure TAfcSob.WriteDocSpc(pValue:boolean);
begin
  WriteData('SOB',cDocSpc,pValue);
end;

function TAfcSob.ReadDocLck:boolean;
begin
  Result := ReadData('SOB',cDocLck);
end;

procedure TAfcSob.WriteDocLck(pValue:boolean);
begin
  WriteData('SOB',cDocLck,pValue);
end;

function TAfcSob.ReadDocUnl:boolean;
begin
  Result := ReadData('SOB',cDocUnl);
end;

procedure TAfcSob.WriteDocUnl(pValue:boolean);
begin
  WriteData('SOB',cDocUnl,pValue);
end;

// ---------------------- Zobraziù -----------------------

function TAfcSob.ReadSitLst:boolean;
begin
  Result := ReadData('SOB',cSitLst);
end;

procedure TAfcSob.WriteSitLst(pValue:boolean);
begin
  WriteData('SOB',cSitLst,pValue);
end;

function TAfcSob.ReadAccLst:boolean;
begin
  Result := ReadData('SOB',cAccLst);
end;

procedure TAfcSob.WriteAccLst(pValue:boolean);
begin
  WriteData('SOB',cAccLst,pValue);
end;

function TAfcSob.ReadPmiLst: boolean;
begin
  Result := ReadData('SOB',cPmiLst);
end;

procedure TAfcSob.WritePmiLst(pValue: boolean);
begin
  WriteData('SOB',cPmiLst,pValue);
end;

// ---------------------- TlaË ---------------------------

function TAfcSob.ReadPrnDoc:boolean;
begin
  Result := ReadData('SOB',cPrnDoc);
end;

procedure TAfcSob.WritePrnDoc(pValue:boolean);
begin
  WriteData('SOB',cPrnDoc,pValue);
end;

// ---------------------- N·stroje -----------------------

function TAfcSob.ReadDocFlt:boolean;
begin
  Result := ReadData('SOB',cDocFlt);
end;

procedure TAfcSob.WriteDocFlt(pValue:boolean);
begin
  WriteData('SOB',cDocFlt,pValue);
end;

function TAfcSob.ReadEndClc:boolean;
begin
  Result := ReadData('SOB',cEndClc);
end;

procedure TAfcSob.WriteEndClc(pValue:boolean);
begin
  WriteData('SOB',cEndClc,pValue);
end;

function TAfcSob.ReadAccDoc:boolean;
begin
  Result := ReadData('SOB',cAccDoc);
end;

procedure TAfcSob.WriteAccDoc(pValue:boolean);
begin
  WriteData('SOB',cAccDoc,pValue);
end;

function TAfcSob.ReadAccDel:boolean;
begin
  Result := ReadData('SOB',cAccDel);
end;

procedure TAfcSob.WriteAccDel(pValue:boolean);
begin
  WriteData('SOB',cAccDel,pValue);
end;

function TAfcSob.ReadAccMas:boolean;
begin
  Result := ReadData('SOB',cAccMas);
end;

procedure TAfcSob.WriteAccMas(pValue:boolean);
begin
  WriteData('SOB',cAccMas,pValue);
end;

function TAfcSob.ReadOitSnd:boolean;
begin
  Result := ReadData('SOB',cOitSnd);
end;

procedure TAfcSob.WriteOitSnd(pValue:boolean);
begin
  WriteData('SOB',cOitSnd,pValue);
end;

function TAfcSob.ReadSomLst:boolean;
begin
  Result := ReadData('SOB',cSomLst);
end;

procedure TAfcSob.WriteSomLst(pValue:boolean);
begin
  WriteData('SOB',cSomLst,pValue);
end;

function TAfcSob.ReadAboRcv:boolean;
begin
  Result := ReadData('SOB',cAboRcv);
end;

procedure TAfcSob.WriteAboRcv(pValue:boolean);
begin
  WriteData('SOB',cAboRcv,pValue);
end;

// ---------------------- ⁄drûba -------------------------

function TAfcSob.ReadMntFnc:boolean;
begin
  Result := ReadData('SOB',cMntFnc);
end;

procedure TAfcSob.WriteMntFnc(pValue:boolean);
begin
  WriteData('SOB',cMntFnc,pValue);
end;

// ---------------------- Servis -------------------------

function TAfcSob.ReadSerFnc:boolean;
begin
  Result := ReadData('SOB',cSerFnc);
end;

procedure TAfcSob.WriteSerFnc(pValue:boolean);
begin
  WriteData('SOB',cSerFnc,pValue);
end;

// ---------------------- Poloûky ------------------------

function TAfcSob.ReadItmAdd:boolean;
begin
  Result := ReadData('SOB',cItmAdd);
end;

procedure TAfcSob.WriteItmAdd(pValue:boolean);
begin
  WriteData('SOB',cItmAdd,pValue);
end;

function TAfcSob.ReadItmDel:boolean;
begin
  Result := ReadData('SOB',cItmDel);
end;

procedure TAfcSob.WriteItmDel(pValue:boolean);
begin
  WriteData('SOB',cItmDel,pValue);
end;

function TAfcSob.ReadItmMod:boolean;
begin
  Result := ReadData('SOB',cItmMod);
end;

procedure TAfcSob.WriteItmMod(pValue:boolean);
begin
  WriteData('SOB',cItmMod,pValue);
end;

end.
