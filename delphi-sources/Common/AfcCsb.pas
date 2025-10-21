unit AfcCsb;

interface

uses
  IcTypes, IcTools, NexPath, NexGlob, AfcBas,
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, NexBtrTable, Forms;

type
  TAfcCsb = class (TAfcBas)
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
    function ReadCsoInc:boolean;    procedure WriteCsoInc(pValue:boolean);
    function ReadCsoExp:boolean;    procedure WriteCsoExp(pValue:boolean);
    function ReadOrgDoc:boolean;    procedure WriteOrgDoc(pValue:boolean);
    // ---------------------------- TlaË ---------------------------------
    function ReadPrnDoc:boolean;    procedure WritePrnDoc(pValue:boolean);
    function ReadYebPrn:boolean;    procedure WriteYebPrn(pValue:boolean);
    function ReadMtbPrn:boolean;    procedure WriteMtbPrn(pValue:boolean);
    // ---------------------------- N·stroje -----------------------------
    function ReadDocFlt:boolean;    procedure WriteDocFlt(pValue:boolean);
    function ReadCsfRef:boolean;    procedure WriteCsfRef(pValue:boolean);
    function ReadAccDoc:boolean;    procedure WriteAccDoc(pValue:boolean);
    function ReadAccDel:boolean;    procedure WriteAccDel(pValue:boolean);
    function ReadAccMas:boolean;    procedure WriteAccMas(pValue:boolean);
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
    property DocUnl:boolean read ReadDocUnl write WriteDocUnl;
    property DocLck:boolean read ReadDocLck write WriteDocLck;
    property DocMod:boolean read ReadDocMod write WriteDocMod;
    property DocSpc:boolean read ReadDocSpc write WriteDocSpc;
    // ---------------------- Zobraziù -----------------------
    property SitLst:boolean read ReadSitLst write WriteSitLst;
    property AccLst:boolean read ReadAccLst write WriteAccLst;
    property PmiLst:boolean read ReadPmiLst write WritePmiLst;
    property CsoInc:boolean read ReadCsoInc write WriteCsoInc;
    property CsoExp:boolean read ReadCsoExp write WriteCsoExp;
    property OrgDoc:boolean read ReadOrgDoc write WriteOrgDoc;
    // ---------------------- TlaË ---------------------------
    property PrnDoc:boolean read ReadPrnDoc write WritePrnDoc;
    property YebPrn:boolean read ReadYebPrn write WriteYebPrn;
    property MtbPrn:boolean read ReadMtbPrn write WriteMtbPrn;
    // ---------------------- N·stroje -----------------------
    property DocFlt:boolean read ReadDocFlt write WriteDocFlt;
    property CsfRef:boolean read ReadCsfRef write WriteCsfRef;
    property AccDoc:boolean read ReadAccDoc write WriteAccDoc;
    property AccDel:boolean read ReadAccDel write WriteAccDel;
    property AccMas:boolean read ReadAccMas write WriteAccMas;
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
   cDocDel = 02;  cAccLst = 22;  cYebPrn = 42;  cCsfRef = 62;                                  cItmDel = 142;
   cDocMod = 03;  cCsoInc = 23;  cMtbPrn = 43;  cAccDoc = 63;                                  cItmMod = 143;
   cDocRnd = 04;  cCsoExp = 24;                 cAccDel = 64;
   cDocDsc = 05;  cOrgDoc = 25;                 cAccMas = 65;
   cDocLck = 06;  cPmiLst = 26;                 cOitSnd = 66;
   cDocUnl = 07;
   cVatChg = 08;                                
   cDocSpc = 09;










// **************************************** OBJECT *****************************************

// ---------------------- ⁄pravy -------------------------

function TAfcCsb.ReadDocAdd:boolean;
begin
  Result := ReadData('CSB',cDocAdd);
end;

procedure TAfcCsb.WriteDocAdd(pValue:boolean);
begin
  WriteData('CSB',cDocAdd,pValue);
end;

function TAfcCsb.ReadDocDel:boolean;
begin
  Result := ReadData('CSB',cDocDel);
end;

procedure TAfcCsb.WriteDocDel(pValue:boolean);
begin
  WriteData('CSB',cDocDel,pValue);
end;

function TAfcCsb.ReadDocMod:boolean;
begin
  Result := ReadData('CSB',cDocMod);
end;

procedure TAfcCsb.WriteDocMod(pValue:boolean);
begin
  WriteData('CSB',cDocMod,pValue);
end;

function TAfcCsb.ReadDocSpc:boolean;
begin
  Result := ReadData('CSB',cDocSpc);
end;

procedure TAfcCsb.WriteDocSpc(pValue:boolean);
begin
  WriteData('CSB',cDocSpc,pValue);
end;

function TAfcCsb.ReadDocLck:boolean;
begin
  Result := ReadData('CSB',cDocLck);
end;

procedure TAfcCsb.WriteDocLck(pValue:boolean);
begin
  WriteData('CSB',cDocLck,pValue);
end;

function TAfcCsb.ReadDocUnl:boolean;
begin
  Result := ReadData('CSB',cDocUnl);
end;

procedure TAfcCsb.WriteDocUnl(pValue:boolean);
begin
  WriteData('CSB',cDocUnl,pValue);
end;

// ---------------------- Zobraziù -----------------------

function TAfcCsb.ReadSitLst:boolean;
begin
  Result := ReadData('CSB',cSitLst);
end;

procedure TAfcCsb.WriteSitLst(pValue:boolean);
begin
  WriteData('CSB',cSitLst,pValue);
end;

function TAfcCsb.ReadAccLst:boolean;
begin
  Result := ReadData('CSB',cAccLst);
end;

procedure TAfcCsb.WriteAccLst(pValue:boolean);
begin
  WriteData('CSB',cAccLst,pValue);
end;

function TAfcCsb.ReadCsoInc:boolean;
begin
  Result := ReadData('CSB',cCsoInc);
end;

procedure TAfcCsb.WriteCsoInc(pValue:boolean);
begin
  WriteData('CSB',cCsoInc,pValue);
end;

function TAfcCsb.ReadCsoExp:boolean;
begin
  Result := ReadData('CSB',cCsoExp);
end;

procedure TAfcCsb.WriteCsoExp(pValue:boolean);
begin
  WriteData('CSB',cCsoExp,pValue);
end;

function TAfcCsb.ReadOrgDoc:boolean;
begin
  Result := ReadData('CSB',cOrgDoc);
end;

procedure TAfcCsb.WriteOrgDoc(pValue:boolean);
begin
  WriteData('CSB',cOrgDoc,pValue);
end;

function TAfcCsb.ReadPmiLst: boolean;
begin
  Result := ReadData('CSB',cPmiLst);
end;

procedure TAfcCsb.WritePmiLst(pValue: boolean);
begin
  WriteData('CSB',cPmiLst,pValue);
end;

// ---------------------- TlaË ---------------------------

function TAfcCsb.ReadPrnDoc:boolean;
begin
  Result := ReadData('CSB',cPrnDoc);
end;

procedure TAfcCsb.WritePrnDoc(pValue:boolean);
begin
  WriteData('CSB',cPrnDoc,pValue);
end;

function TAfcCsb.ReadYebPrn:boolean;
begin
  Result := ReadData('CSB',cYebPrn);
end;

procedure TAfcCsb.WriteYebPrn(pValue:boolean);
begin
  WriteData('CSB',cYebPrn,pValue);
end;

function TAfcCsb.ReadMtbPrn:boolean;
begin
  Result := ReadData('CSB',cMtbPrn);
end;

procedure TAfcCsb.WriteMtbPrn(pValue:boolean);
begin
  WriteData('CSB',cMtbPrn,pValue);
end;

// ---------------------- N·stroje -----------------------

function TAfcCsb.ReadDocFlt:boolean;
begin
  Result := ReadData('CSB',cDocFlt);
end;

procedure TAfcCsb.WriteDocFlt(pValue:boolean);
begin
  WriteData('CSB',cDocFlt,pValue);
end;

function TAfcCsb.ReadCsfRef:boolean;
begin
  Result := ReadData('CSB',cCsfRef);
end;

procedure TAfcCsb.WriteCsfRef(pValue:boolean);
begin
  WriteData('CSB',cCsfRef,pValue);
end;

function TAfcCsb.ReadAccDoc:boolean;
begin
  Result := ReadData('CSB',cAccDoc);
end;

procedure TAfcCsb.WriteAccDoc(pValue:boolean);
begin
  WriteData('CSB',cAccDoc,pValue);
end;

function TAfcCsb.ReadAccDel:boolean;
begin
  Result := ReadData('CSB',cAccDel);
end;

procedure TAfcCsb.WriteAccDel(pValue:boolean);
begin
  WriteData('CSB',cAccDel,pValue);
end;

function TAfcCsb.ReadAccMas:boolean;
begin
  Result := ReadData('CSB',cAccMas);
end;

procedure TAfcCsb.WriteAccMas(pValue:boolean);
begin
  WriteData('CSB',cAccMas,pValue);
end;

function TAfcCsb.ReadOitSnd:boolean;
begin
  Result := ReadData('CSB',cOitSnd);
end;

procedure TAfcCsb.WriteOitSnd(pValue:boolean);
begin
  WriteData('CSB',cOitSnd,pValue);
end;

// ---------------------- ⁄drûba -------------------------

function TAfcCsb.ReadMntFnc:boolean;
begin
  Result := ReadData('CSB',cMntFnc);
end;

procedure TAfcCsb.WriteMntFnc(pValue:boolean);
begin
  WriteData('CSB',cMntFnc,pValue);
end;

// ---------------------- Servis -------------------------

function TAfcCsb.ReadSerFnc:boolean;
begin
  Result := ReadData('CSB',cSerFnc);
end;

procedure TAfcCsb.WriteSerFnc(pValue:boolean);
begin
  WriteData('CSB',cSerFnc,pValue);
end;

// ---------------------- Poloûky ------------------------

function TAfcCsb.ReadItmAdd:boolean;
begin
  Result := ReadData('CSB',cItmAdd);
end;

procedure TAfcCsb.WriteItmAdd(pValue:boolean);
begin
  WriteData('CSB',cItmAdd,pValue);
end;

function TAfcCsb.ReadItmDel:boolean;
begin
  Result := ReadData('CSB',cItmDel);
end;

procedure TAfcCsb.WriteItmDel(pValue:boolean);
begin
  WriteData('CSB',cItmDel,pValue);
end;

function TAfcCsb.ReadItmMod:boolean;
begin
  Result := ReadData('CSB',cItmMod);
end;

procedure TAfcCsb.WriteItmMod(pValue:boolean);
begin
  WriteData('CSB',cItmMod,pValue);
end;

end.
