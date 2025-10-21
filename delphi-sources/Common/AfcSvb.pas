unit AfcSvb;

interface

uses
  IcTypes, IcTools, NexPath, NexGlob, AfcBas,
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, NexBtrTable, Forms;

type
  TAfcSvb = class (TAfcBas)
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
    function ReadAccDoc:boolean;    procedure WriteAccDoc(pValue:boolean);
    function ReadAccDel:boolean;    procedure WriteAccDel(pValue:boolean);
    function ReadAccMas:boolean;    procedure WriteAccMas(pValue:boolean);
    function ReadSndDoc:boolean;    procedure WriteSndDoc(pValue:boolean);
    function ReadSndMas:boolean;    procedure WriteSndMas(pValue:boolean);
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
    property AccDoc:boolean read ReadAccDoc write WriteAccDoc;
    property AccDel:boolean read ReadAccDel write WriteAccDel;
    property AccMas:boolean read ReadAccMas write WriteAccMas;
    property SndDoc:boolean read ReadSndDoc write WriteSndDoc;
    property SndMas:boolean read ReadSndMas write WriteSndMas;
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
   cDocDel = 02;  cAccLst = 22;  cPrnLst = 42;  cAccDoc = 62;                                  cItmDel = 142;
   cDocMod = 03;  cPmiLst = 23;                 cAccDel = 63;                                  cItmMod = 143;
   cDocRnd = 04;                                cAccMas = 64;
   cDocDsc = 05;                                cSndDoc = 65;
   cDocLck = 06;                                cSndMas = 66;
   cDocUnl = 07;
   cVatChg = 08;




// **************************************** OBJECT *****************************************

// ---------------------- ⁄pravy -------------------------

function TAfcSvb.ReadDocAdd:boolean;
begin
  Result := ReadData('SVB',cDocAdd);
end;

procedure TAfcSvb.WriteDocAdd(pValue:boolean);
begin
  WriteData('SVB',cDocAdd,pValue);
end;

function TAfcSvb.ReadDocDel:boolean;
begin
  Result := ReadData('SVB',cDocDel);
end;

procedure TAfcSvb.WriteDocDel(pValue:boolean);
begin
  WriteData('SVB',cDocDel,pValue);
end;

function TAfcSvb.ReadDocMod:boolean;
begin
  Result := ReadData('SVB',cDocMod);
end;

procedure TAfcSvb.WriteDocMod(pValue:boolean);
begin
  WriteData('SVB',cDocMod,pValue);
end;

function TAfcSvb.ReadDocLck:boolean;
begin
  Result := ReadData('SVB',cDocLck);
end;

procedure TAfcSvb.WriteDocLck(pValue:boolean);
begin
  WriteData('SVB',cDocLck,pValue);
end;

function TAfcSvb.ReadDocUnl:boolean;
begin
  Result := ReadData('SVB',cDocUnl);
end;

procedure TAfcSvb.WriteDocUnl(pValue:boolean);
begin
  WriteData('SVB',cDocUnl,pValue);
end;

// ---------------------- Zobraziù -----------------------

function TAfcSvb.ReadSitLst:boolean;
begin
  Result := ReadData('SVB',cSitLst);
end;

procedure TAfcSvb.WriteSitLst(pValue:boolean);
begin
  WriteData('SVB',cSitLst,pValue);
end;

function TAfcSvb.ReadAccLst:boolean;
begin
  Result := ReadData('SVB',cAccLst);
end;

procedure TAfcSvb.WriteAccLst(pValue:boolean);
begin
  WriteData('SVB',cAccLst,pValue);
end;

function TAfcSvb.ReadPmiLst: boolean;
begin
  Result := ReadData('SVB',cPmiLst);
end;

procedure TAfcSvb.WritePmiLst(pValue: boolean);
begin
  WriteData('SVB',cPmiLst,pValue);
end;

// ---------------------- TlaË ---------------------------

function TAfcSvb.ReadPrnDoc:boolean;
begin
  Result := ReadData('SVB',cPrnDoc);
end;

procedure TAfcSvb.WritePrnDoc(pValue:boolean);
begin
  WriteData('SVB',cPrnDoc,pValue);
end;

function TAfcSvb.ReadPrnLst:boolean;
begin
  Result := ReadData('SVB',cPrnLst);
end;

procedure TAfcSvb.WritePrnLst(pValue:boolean);
begin
  WriteData('SVB',cPrnLst,pValue);
end;

// ---------------------- N·stroje -----------------------

function TAfcSvb.ReadDocFlt:boolean;
begin
  Result := ReadData('SVB',cDocFlt);
end;

procedure TAfcSvb.WriteDocFlt(pValue:boolean);
begin
  WriteData('SVB',cDocFlt,pValue);
end;

function TAfcSvb.ReadAccDoc:boolean;
begin
  Result := ReadData('SVB',cAccDoc);
end;

procedure TAfcSvb.WriteAccDoc(pValue:boolean);
begin
  WriteData('SVB',cAccDoc,pValue);
end;

function TAfcSvb.ReadAccDel:boolean;
begin
  Result := ReadData('SVB',cAccDel);
end;

procedure TAfcSvb.WriteAccDel(pValue:boolean);
begin
  WriteData('SVB',cAccDel,pValue);
end;

function TAfcSvb.ReadAccMas:boolean;
begin
  Result := ReadData('SVB',cAccMas);
end;

procedure TAfcSvb.WriteAccMas(pValue:boolean);
begin
  WriteData('SVB',cAccMas,pValue);
end;

function TAfcSvb.ReadSndDoc:boolean;
begin
  Result := ReadData('SVB',cSndDoc);
end;

procedure TAfcSvb.WriteSndDoc(pValue:boolean);
begin
  WriteData('SVB',cSndDoc,pValue);
end;

function TAfcSvb.ReadSndMas:boolean;
begin
  Result := ReadData('SVB',cSndMas);
end;

procedure TAfcSvb.WriteSndMas(pValue:boolean);
begin
  WriteData('SVB',cSndMas,pValue);
end;

// ---------------------- ⁄drûba -------------------------

function TAfcSvb.ReadMntFnc:boolean;
begin
  Result := ReadData('SVB',cMntFnc);
end;

procedure TAfcSvb.WriteMntFnc(pValue:boolean);
begin
  WriteData('SVB',cMntFnc,pValue);
end;

// ---------------------- Servis -------------------------

function TAfcSvb.ReadSerFnc:boolean;
begin
  Result := ReadData('SVB',cSerFnc);
end;

procedure TAfcSvb.WriteSerFnc(pValue:boolean);
begin
  WriteData('SVB',cSerFnc,pValue);
end;

// ---------------------- Poloûky ------------------------

function TAfcSvb.ReadItmAdd:boolean;
begin
  Result := ReadData('SVB',cItmAdd);
end;

procedure TAfcSvb.WriteItmAdd(pValue:boolean);
begin
  WriteData('SVB',cItmAdd,pValue);
end;

function TAfcSvb.ReadItmDel:boolean;
begin
  Result := ReadData('SVB',cItmDel);
end;

procedure TAfcSvb.WriteItmDel(pValue:boolean);
begin
  WriteData('SVB',cItmDel,pValue);
end;

function TAfcSvb.ReadItmMod:boolean;
begin
  Result := ReadData('SVB',cItmMod);
end;

procedure TAfcSvb.WriteItmMod(pValue:boolean);
begin
  WriteData('SVB',cItmMod,pValue);
end;

end.
