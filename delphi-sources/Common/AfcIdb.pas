unit AfcIdb;

interface

uses
  IcTypes, IcTools, NexPath, NexGlob, AfcBas,
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, NexBtrTable, Forms;

type
  TAfcIdb = class (TAfcBas)
  private
    // ---------------------------- ⁄pravy -------------------------------
    function ReadDocAdd:boolean;    procedure WriteDocAdd(pValue:boolean);
    function ReadDocDel:boolean;    procedure WriteDocDel(pValue:boolean);
    function ReadDocMod:boolean;    procedure WriteDocMod(pValue:boolean);
    function ReadDocLck:boolean;    procedure WriteDocLck(pValue:boolean);
    function ReadDocUnl:boolean;    procedure WriteDocUnl(pValue:boolean);
    // ---------------------------- Zobraziù -----------------------------
    function ReadSitLst:boolean;    procedure WriteSitLst(pValue:boolean);
    function ReadAccLst:boolean;    procedure WriteAccLst(pValue:boolean);
    function ReadPmiLst:boolean;    procedure WritePmiLst(pValue:boolean);
    // ---------------------------- TlaË ---------------------------------
    function ReadPrnDoc:boolean;    procedure WritePrnDoc(pValue:boolean);
    function ReadPrnLst:boolean;    procedure WritePrnLst(pValue:boolean);
    // ---------------------------- N·stroje -----------------------------
    function ReadDocFlt:boolean;    procedure WriteDocFlt(pValue:boolean);
    function ReadCrdAcc:boolean;    procedure WriteCrdAcc(pValue:boolean);
    function ReadAccDoc:boolean;    procedure WriteAccDoc(pValue:boolean);
    function ReadAccDel:boolean;    procedure WriteAccDel(pValue:boolean);
    function ReadAccMas:boolean;    procedure WriteAccMas(pValue:boolean);
    function ReadOitSnd:boolean;    procedure WriteOitSnd(pValue:boolean);
    function ReadAccOpn:boolean;    procedure WriteAccOpn(pValue:boolean);
    function ReadAccCls:boolean;    procedure WriteAccCls(pValue:boolean);
    function ReadTxtExp:boolean;    procedure WriteTxtExp(pValue:boolean);
    function ReadImpItm:boolean;    procedure WriteImpItm(pValue:boolean);
    function ReadDocCpy:boolean;    procedure WriteDocCpy(pValue:boolean);
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
    // ---------------------- Zobraziù -----------------------
    property SitLst:boolean read ReadSitLst write WriteSitLst;
    property AccLst:boolean read ReadAccLst write WriteAccLst;
    property PmiLst:boolean read ReadPmiLst write WritePmiLst;
    // ---------------------- TlaË ---------------------------
    property PrnDoc:boolean read ReadPrnDoc write WritePrnDoc;
    property PrnLst:boolean read ReadPrnLst write WritePrnLst;
    // ---------------------- N·stroje -----------------------
    property DocFlt:boolean read ReadDocFlt write WriteDocFlt;
    property CrdAcc:boolean read ReadCrdAcc write WriteCrdAcc;
    property AccDoc:boolean read ReadAccDoc write WriteAccDoc;
    property AccDel:boolean read ReadAccDel write WriteAccDel;
    property AccMas:boolean read ReadAccMas write WriteAccMas;
    property OitSnd:boolean read ReadOitSnd write WriteOitSnd;
    property AccOpn:boolean read ReadAccOpn write WriteAccOpn;
    property AccCls:boolean read ReadAccCls write WriteAccCls;
    property TxtExp:boolean read ReadTxtExp write WriteTxtExp;
    property ImpItm:boolean read ReadImpItm write WriteImpItm;
    property DocCpy:boolean read ReadDocCpy write WriteDocCpy;
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
   cDocDel = 02;  cAccLst = 22;  cPrnLst = 42;  cCrdAcc = 62;                                  cItmDel = 142;
   cDocMod = 03;  cPmiLst = 23;                 cAccDoc = 63;                                  cItmMod = 143;
   cDocRnd = 04;                                cAccDel = 64;
   cDocDsc = 05;                                cAccMas = 65;
   cDocLck = 06;                                cOitSnd = 66;
   cDocUnl = 07;                                cAccOpn = 67;
   cVatChg = 08;                                cAccCls = 68;
                                                cTxtExp = 69;
                                                cImpItm = 70;
                                                cDocCpy = 71;

// **************************************** OBJECT *****************************************

// ---------------------- ⁄pravy -------------------------

function TAfcIdb.ReadDocAdd:boolean;
begin
  Result := ReadData('IDB',cDocAdd);
end;

procedure TAfcIdb.WriteDocAdd(pValue:boolean);
begin
  WriteData('IDB',cDocAdd,pValue);
end;

function TAfcIdb.ReadDocDel:boolean;
begin
  Result := ReadData('IDB',cDocDel);
end;

procedure TAfcIdb.WriteDocDel(pValue:boolean);
begin
  WriteData('IDB',cDocDel,pValue);
end;

function TAfcIdb.ReadDocMod:boolean;
begin
  Result := ReadData('IDB',cDocMod);
end;

procedure TAfcIdb.WriteDocMod(pValue:boolean);
begin
  WriteData('IDB',cDocMod,pValue);
end;

function TAfcIdb.ReadDocLck:boolean;
begin
  Result := ReadData('IDB',cDocLck);
end;

procedure TAfcIdb.WriteDocLck(pValue:boolean);
begin
  WriteData('IDB',cDocLck,pValue);
end;

function TAfcIdb.ReadDocUnl:boolean;
begin
  Result := ReadData('IDB',cDocUnl);
end;

procedure TAfcIdb.WriteDocUnl(pValue:boolean);
begin
  WriteData('IDB',cDocUnl,pValue);
end;

// ---------------------- Zobraziù -----------------------

function TAfcIdb.ReadSitLst:boolean;
begin
  Result := ReadData('IDB',cSitLst);
end;

procedure TAfcIdb.WriteSitLst(pValue:boolean);
begin
  WriteData('IDB',cSitLst,pValue);
end;

function TAfcIdb.ReadAccLst:boolean;
begin
  Result := ReadData('IDB',cAccLst);
end;

procedure TAfcIdb.WriteAccLst(pValue:boolean);
begin
  WriteData('IDB',cAccLst,pValue);
end;

function TAfcIdb.ReadPmiLst: boolean;
begin
  Result := ReadData('IDB',cPmiLst);
end;

procedure TAfcIdb.WritePmiLst(pValue: boolean);
begin
  WriteData('IDB',cPmiLst,pValue);
end;

// ---------------------- TlaË ---------------------------

function TAfcIdb.ReadPrnDoc:boolean;
begin
  Result := ReadData('IDB',cPrnDoc);
end;

procedure TAfcIdb.WritePrnDoc(pValue:boolean);
begin
  WriteData('IDB',cPrnDoc,pValue);
end;

function TAfcIdb.ReadPrnLst:boolean;
begin
  Result := ReadData('IDB',cPrnLst);
end;

procedure TAfcIdb.WritePrnLst(pValue:boolean);
begin
  WriteData('IDB',cPrnLst,pValue);
end;

// ---------------------- N·stroje -----------------------

function TAfcIdb.ReadDocFlt:boolean;
begin
  Result := ReadData('IDB',cDocFlt);
end;

procedure TAfcIdb.WriteDocFlt(pValue:boolean);
begin
  WriteData('IDB',cDocFlt,pValue);
end;

function TAfcIdb.ReadCrdAcc:boolean;
begin
  Result := ReadData('IDB',cCrdAcc);
end;

procedure TAfcIdb.WriteCrdAcc(pValue:boolean);
begin
  WriteData('IDB',cCrdAcc,pValue);
end;

function TAfcIdb.ReadAccDoc:boolean;
begin
  Result := ReadData('IDB',cAccDoc);
end;

procedure TAfcIdb.WriteAccDoc(pValue:boolean);
begin
  WriteData('IDB',cAccDoc,pValue);
end;

function TAfcIdb.ReadAccDel:boolean;
begin
  Result := ReadData('IDB',cAccDel);
end;

procedure TAfcIdb.WriteAccDel(pValue:boolean);
begin
  WriteData('IDB',cAccDel,pValue);
end;

function TAfcIdb.ReadAccMas:boolean;
begin
  Result := ReadData('IDB',cAccMas);
end;

procedure TAfcIdb.WriteAccMas(pValue:boolean);
begin
  WriteData('IDB',cAccMas,pValue);
end;

function TAfcIdb.ReadOitSnd:boolean;
begin
  Result := ReadData('IDB',cOitSnd);
end;

procedure TAfcIdb.WriteOitSnd(pValue:boolean);
begin
  WriteData('IDB',cOitSnd,pValue);
end;

function TAfcIdb.ReadAccOpn:boolean;
begin
  Result := ReadData('IDB',cAccOpn);
end;

procedure TAfcIdb.WriteAccOpn(pValue:boolean);
begin
  WriteData('IDB',cAccOpn,pValue);
end;

function TAfcIdb.ReadAccCls:boolean;
begin
  Result := ReadData('IDB',cAccCls);
end;

procedure TAfcIdb.WriteAccCls(pValue:boolean);
begin
  WriteData('IDB',cAccCls,pValue);
end;

function TAfcIdb.ReadTxtExp:boolean;
begin
  Result := ReadData('IDB',cTxtExp);
end;

procedure TAfcIdb.WriteTxtExp(pValue:boolean);
begin
  WriteData('IDB',cTxtExp,pValue);
end;

function TAfcIdb.ReadImpItm:boolean;
begin
  Result := ReadData('IDB',cImpItm);
end;

procedure TAfcIdb.WriteImpItm(pValue:boolean);
begin
  WriteData('IDB',cImpItm,pValue);
end;

function TAfcIdb.ReadDocCpy:boolean;
begin
  Result := ReadData('IDB',cDocCpy);
end;

procedure TAfcIdb.WriteDocCpy(pValue:boolean);
begin
  WriteData('IDB',cDocCpy,pValue);
end;

// ---------------------- ⁄drûba -------------------------

function TAfcIdb.ReadMntFnc:boolean;
begin
  Result := ReadData('IDB',cMntFnc);
end;

procedure TAfcIdb.WriteMntFnc(pValue:boolean);
begin
  WriteData('IDB',cMntFnc,pValue);
end;

// ---------------------- Servis -------------------------

function TAfcIdb.ReadSerFnc:boolean;
begin
  Result := ReadData('IDB',cSerFnc);
end;

procedure TAfcIdb.WriteSerFnc(pValue:boolean);
begin
  WriteData('IDB',cSerFnc,pValue);
end;

// ---------------------- Poloûky ------------------------

function TAfcIdb.ReadItmAdd:boolean;
begin
  Result := ReadData('IDB',cItmAdd);
end;

procedure TAfcIdb.WriteItmAdd(pValue:boolean);
begin
  WriteData('IDB',cItmAdd,pValue);
end;

function TAfcIdb.ReadItmDel:boolean;
begin
  Result := ReadData('IDB',cItmDel);
end;

procedure TAfcIdb.WriteItmDel(pValue:boolean);
begin
  WriteData('IDB',cItmDel,pValue);
end;

function TAfcIdb.ReadItmMod:boolean;
begin
  Result := ReadData('IDB',cItmMod);
end;

procedure TAfcIdb.WriteItmMod(pValue:boolean);
begin
  WriteData('IDB',cItmMod,pValue);
end;

end.
