unit AfcAgm;

interface

uses
  IcTypes, IcTools, NexPath, NexGlob, AfcBas,
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, NexBtrTable, Forms;

type
  TAfcAgm = class (TAfcBas)
  private
    // ============================ DOKLADY ==============================
    // ---------------------------- ⁄pravy -------------------------------
    function ReadDocAdd:boolean;    procedure WriteDocAdd(pValue:boolean);
    function ReadDocDel:boolean;    procedure WriteDocDel(pValue:boolean);
    function ReadDocMod:boolean;    procedure WriteDocMod(pValue:boolean);
    // ---------------------------- Zobraziù -----------------------------
    function ReadItmLst:boolean;    procedure WriteItmLst(pValue:boolean);
    // ---------------------------- TlaË ---------------------------------
    function ReadDocPrn:boolean;    procedure WriteDocPrn(pValue:boolean);
    // ---------------------------- N·stroje -----------------------------
    // ---------------------------- ⁄drûba -------------------------------

    // ============================ POLOéKY ==============================
    // ---------------------------- ⁄pravy -------------------------------
    function ReadItmAdd:boolean;    procedure WriteItmAdd(pValue:boolean);
    function ReadItmDel:boolean;    procedure WriteItmDel(pValue:boolean);
    function ReadItmMod:boolean;    procedure WriteItmMod(pValue:boolean);
    // ---------------------------- Zobraziù -----------------------------
    function ReadAgdLst:boolean;    procedure WriteAgdLst(pValue:boolean);
    function ReadDelHis:boolean;    procedure WriteDelHis(pValue:boolean);
    function ReadModHis:boolean;    procedure WriteModHis(pValue:boolean);

    // ============================ ZMLUVY ===============================
    // ---------------------------- ⁄pravy -------------------------------
    function ReadAgdAdd:boolean;    procedure WriteAgdAdd(pValue:boolean);
    function ReadAgdDel:boolean;    procedure WriteAgdDel(pValue:boolean);
    function ReadAgdMod:boolean;    procedure WriteAgdMod(pValue:boolean);
    // ---------------------------- Zobraziù -----------------------------
    function ReadAtcDoc:boolean;    procedure WriteAtcDoc(pValue:boolean);
    // ---------------------------- N·stroje -----------------------------
    function ReadAgdSig:boolean;    procedure WriteAgdSig(pValue:boolean);
  public
    // ============================ DOKLADY ==============================
    // ---------------------------- ⁄pravy -------------------------------
    property DocAdd:boolean read ReadDocAdd write WriteDocAdd;
    property DocDel:boolean read ReadDocDel write WriteDocDel;
    property DocMod:boolean read ReadDocMod write WriteDocMod;
    // ---------------------------- Zobraziù -----------------------------
    property ItmLst:boolean read ReadItmLst write WriteItmLst;
    // ---------------------------- TlaË ---------------------------------
    property DocPrn:boolean read ReadDocPrn write WriteDocPrn;
    // ---------------------------- N·stroje -----------------------------
    // ---------------------------- ⁄drûba -------------------------------

    // ============================ POLOéKY ==============================
    // ---------------------------- ⁄pravy -------------------------------
    property ItmAdd:boolean read ReadItmAdd write WriteItmAdd;
    property ItmDel:boolean read ReadItmDel write WriteItmDel;
    property ItmMod:boolean read ReadItmMod write WriteItmMod;
    // ---------------------------- Zobraziù -----------------------------
    property AgdLst:boolean read ReadAgdLst write WriteAgdLst;
    property DelHis:boolean read ReadDelHis write WriteDelHis;
    property ModHis:boolean read ReadModHis write WriteModHis;

    // ============================ ZMLUVY ===============================
    // ---------------------------- ⁄pravy -------------------------------
    property AgdAdd:boolean read ReadAgdAdd write WriteAgdAdd;
    property AgdDel:boolean read ReadAgdDel write WriteAgdDel;
    property AgdMod:boolean read ReadAgdMod write WriteAgdMod;
    // ---------------------------- Zobraziù -----------------------------
    property AtcDoc:boolean read ReadAtcDoc write WriteAtcDoc;
    // ---------------------------- N·stroje -----------------------------
    property AgdSig:boolean read ReadAgdSig write WriteAgdSig;
  end;

implementation

const
// ---------------------------------- DOKLADY --------------------------------------
// Upravy -----  Zobrazit ---  Tlac -------  N·stroje ---  Udrzba ----  Polozky ----
   cDocAdd=1;    cItmLst=21;   cDocPrn=41;
   cDocDel=2;
   cDocMod=3;
// ---------------------------------- POLOéKY --------------------------------------
// Upravy -----  Zobrazit ---  Tlac -------  N·stroje ---  Udrzba ----  Polozky ----
   cItmAdd=101;  cAgdLst=121;
   cItmDel=102;  cDelHis=122;
   cItmMod=103;  cModHis=123;
// ---------------------------------- ZMLUVY ---------------------------------------
// Upravy -----  Zobrazit ---  Tlac -------  N·stroje ---  Udrzba ----  Polozky ----
   cAgdAdd=201;  cAtcDoc=111;                cAgdSig=231;
   cAgdDel=202;
   cAgdMod=203;

// ************************************ OBJECT *************************************

// ============================ DOKLADY ==============================
// ---------------------------- ⁄pravy -------------------------------

function TAfcAgm.ReadDocAdd:boolean;
begin
  Result:=ReadData('AGM',cDocAdd);
end;

procedure TAfcAgm.WriteDocAdd(pValue:boolean);
begin
  WriteData('AGM',cDocAdd,pValue);
end;

function TAfcAgm.ReadDocDel:boolean;
begin
  Result:=ReadData('AGM',cDocDel);
end;

procedure TAfcAgm.WriteDocDel(pValue:boolean);
begin
  WriteData('AGM',cDocDel,pValue);
end;

function TAfcAgm.ReadDocMod:boolean;
begin
  Result:=ReadData('AGM',cDocMod);
end;

procedure TAfcAgm.WriteDocMod(pValue:boolean);
begin
  WriteData('AGM',cDocMod,pValue);
end;

// ---------------------------- Zobraziù -----------------------------
function TAfcAgm.ReadItmLst:boolean;
begin
  Result:=ReadData('AGM',cItmLst);
end;

procedure TAfcAgm.WriteItmLst(pValue:boolean);
begin
  WriteData('AGM',cItmLst,pValue);
end;

// ---------------------------- TlaË ---------------------------------
function TAfcAgm.ReadDocPrn:boolean;
begin
  Result:=ReadData('AGM',cDocPrn);
end;

procedure TAfcAgm.WriteDocPrn(pValue:boolean);
begin
  WriteData('AGM',cDocPrn,pValue);
end;

// ============================ POLOéKY ==============================
// ---------------------------- ⁄pravy -------------------------------
function TAfcAgm.ReadItmAdd:boolean;
begin
  Result:=ReadData('AGM',cItmAdd);
end;

procedure TAfcAgm.WriteItmAdd(pValue:boolean);
begin
  WriteData('AGM',cItmAdd,pValue);
end;

function TAfcAgm.ReadItmDel:boolean;
begin
  Result:=ReadData('AGM',cItmDel);
end;

procedure TAfcAgm.WriteItmDel(pValue:boolean);
begin
  WriteData('AGM',cItmDel,pValue);
end;

function TAfcAgm.ReadItmMod:boolean;
begin
  Result:=ReadData('AGM',cItmMod);
end;

procedure TAfcAgm.WriteItmMod(pValue:boolean);
begin
  WriteData('AGM',cItmMod,pValue);
end;

// ---------------------------- Zobraziù -----------------------------
function TAfcAgm.ReadAgdLst:boolean;
begin
  Result:=ReadData('AGM',cAgdLst);
end;

procedure TAfcAgm.WriteAgdLst(pValue:boolean);
begin
  WriteData('AGM',cAgdLst,pValue);
end;

function TAfcAgm.ReadDelHis:boolean;
begin
  Result:=ReadData('AGM',cDelHis);
end;

procedure TAfcAgm.WriteDelHis(pValue:boolean);
begin
  WriteData('AGM',cDelHis,pValue);
end;

function TAfcAgm.ReadModHis:boolean;
begin
  Result:=ReadData('AGM',cModHis);
end;

procedure TAfcAgm.WriteModHis(pValue:boolean);
begin
  WriteData('AGM',cModHis,pValue);
end;

// ---------------------------- TlaË ---------------------------------
// ---------------------------- N·stroje -----------------------------
// ---------------------------- ⁄drûba -------------------------------

// ============================ ZMLUVY ===============================
// ---------------------------- ⁄pravy -------------------------------
function TAfcAgm.ReadAgdAdd:boolean;
begin
  Result:=ReadData('AGM',cAgdAdd);
end;

procedure TAfcAgm.WriteAgdAdd(pValue:boolean);
begin
  WriteData('AGM',cAgdAdd,pValue);
end;

function TAfcAgm.ReadAgdDel:boolean;
begin
  Result:=ReadData('AGM',cAgdDel);
end;

procedure TAfcAgm.WriteAgdDel(pValue:boolean);
begin
  WriteData('AGM',cAgdDel,pValue);
end;

function TAfcAgm.ReadAgdMod:boolean;
begin
  Result:=ReadData('AGM',cAgdMod);
end;

procedure TAfcAgm.WriteAgdMod(pValue:boolean);
begin
  WriteData('AGM',cAgdMod,pValue);
end;

// ---------------------------- Zobraziù -----------------------------
function TAfcAgm.ReadAtcDoc:boolean;
begin
  Result:=ReadData('AGM',cAtcDoc);
end;

procedure TAfcAgm.WriteAtcDoc(pValue:boolean);
begin
  WriteData('AGM',cAtcDoc,pValue);
end;

// ---------------------------- N·stroje -----------------------------

function TAfcAgm.ReadAgdSig:boolean;
begin
  Result:=ReadData('AGM',cAgdSig);
end;

procedure TAfcAgm.WriteAgdSig(pValue:boolean);
begin
  WriteData('AGM',cAgdSig,pValue);
end;

end.

{MOD 1915001 - Nov˝ prepracovan˝ modul }
