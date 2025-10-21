unit AfcTib;

interface

uses
  IcTypes, IcTools, NexPath, NexGlob, AfcBas,
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, NexBtrTable, Forms;

type
  TAfcTib = class (TAfcBas)
  private
    // ---------------------------- ⁄pravy -------------------------------
    function ReadDocAdd:boolean;    procedure WriteDocAdd(pValue:boolean);
    function ReadDocDel:boolean;    procedure WriteDocDel(pValue:boolean);
    function ReadDocLck:boolean;    procedure WriteDocLck(pValue:boolean);
    function ReadDocUnl:boolean;    procedure WriteDocUnl(pValue:boolean);
    // ---------------------------- Zobraziù -----------------------------
    function ReadSitLst:boolean;    procedure WriteSitLst(pValue:boolean);
    function ReadDlvSur:boolean;    procedure WriteDlvSur(pValue:boolean);
    // ---------------------------- TlaË ---------------------------------
    function ReadDocPrn:boolean;    procedure WriteDocPrn(pValue:boolean);
    function ReadLabPrn:boolean;    procedure WriteLabPrn(pValue:boolean);
    // ---------------------------- N·stroje -----------------------------
    function ReadDocFlt:boolean;    procedure WriteDocFlt(pValue:boolean);
    function ReadTsdGen:boolean;    procedure WriteTsdGen(pValue:boolean);
    function ReadImdPar:boolean;    procedure WriteImdPar(pValue:boolean);
    // ---------------------------- ⁄drûba -------------------------------
    function ReadMntFnc:boolean;    procedure WriteMntFnc(pValue:boolean);
    // ---------------------------- Servis -------------------------------
    function ReadSerFnc:boolean;    procedure WriteSerFnc(pValue:boolean);
    // ---------------------------- Poloûky ------------------------------
    function ReadItmAdd:boolean;    procedure WriteItmAdd(pValue:boolean);
    function ReadItmDel:boolean;    procedure WriteItmDel(pValue:boolean);
    function ReadItmMod:boolean;    procedure WriteItmMod(pValue:boolean);
  public
    // ---------------------------- ⁄pravy -------------------------------
    property DocAdd:boolean read ReadDocAdd write WriteDocAdd;
    property DocDel:boolean read ReadDocDel write WriteDocDel;
    property DocLck:boolean read ReadDocLck write WriteDocLck;
    property DocUnl:boolean read ReadDocUnl write WriteDocUnl;
    // ---------------------------- Zobraziù -----------------------------
    property SitLst:boolean read ReadSitLst write WriteSitLst;
    property DlvSur:boolean read ReadDlvSur write WriteDlvSur;
    // ---------------------------- TlaË ---------------------------------
    property DocPrn:boolean read ReadDocPrn write WriteDocPrn;
    property LabPrn:boolean read ReadLabPrn write WriteLabPrn;
    // ---------------------------- N·stroje -----------------------------
    property DocFlt:boolean read ReadDocFlt write WriteDocFlt;
    property TsdGen:boolean read ReadTsdGen write WriteTsdGen;
    property ImdPar:boolean read ReadImdPar write WriteImdPar;
    // ---------------------------- ⁄drûba -------------------------------
    property MntFnc:boolean read ReadMntFnc write WriteMntFnc;
    // ---------------------------- Servis -------------------------------
    property SerFnc:boolean read ReadSerFnc write WriteSerFnc;
    // ---------------------------- Poloûky ------------------------------
    property ItmAdd:boolean read ReadItmAdd write WriteItmAdd;
    property ItmDel:boolean read ReadItmDel write WriteItmDel;
    property ItmMod:boolean read ReadItmMod write WriteItmMod;
  end;

implementation

const
// Upravy ------  Zobrazit ----  Tlac --------  N·stroje ----  Udrzba ------  Servis ------  Polozky -----
   cDocAdd = 1;   cSitLst = 20;  cDocPrn = 40;  cDocFlt = 60;  cMntFnc = 90;  cSerFnc = 120; cItmAdd = 150;
   cDocDel = 2;   cBokLst = 21;  cLabPrn = 41;  cTsdGen = 61;                                cItmDel = 151;
   cDocMod = 3;   cDlvSur = 22;                 cImdPar = 62;                                cItmMod = 152;
   cDocDsc = 4;                                 
   cDocRnd = 5;                                 
   cDocLck = 6;                                 
   cDocUnl = 8;                                 
// **************************************** OBJECT *****************************************

// ---------------------------- ⁄pravy -------------------------------

function TAfcTib.ReadDocAdd:boolean;
begin
  Result := ReadData('TIB',cDocAdd);
end;

procedure TAfcTib.WriteDocAdd(pValue:boolean);
begin
  WriteData('TIB',cDocAdd,pValue);
end;

function TAfcTib.ReadDocDel:boolean;
begin
  Result := ReadData('TIB',cDocDel);
end;

procedure TAfcTib.WriteDocDel(pValue:boolean);
begin
  WriteData('TIB',cDocDel,pValue);
end;

function TAfcTib.ReadDocLck:boolean;
begin
  Result := ReadData('TIB',cDocLck);
end;

procedure TAfcTib.WriteDocLck(pValue:boolean);
begin
  WriteData('TIB',cDocLck,pValue);
end;

function TAfcTib.ReadDocUnl:boolean;
begin
  Result := ReadData('TIB',cDocUnl);
end;

procedure TAfcTib.WriteDocUnl(pValue:boolean);
begin
  WriteData('TIB',cDocUnl,pValue);
end;

// ---------------------------- Zobraziù -----------------------------

function TAfcTib.ReadSitLst:boolean;
begin
  Result := ReadData('TIB',cSitLst);
end;

procedure TAfcTib.WriteSitLst(pValue:boolean);
begin
  WriteData('TIB',cSitLst,pValue);
end;

function TAfcTib.ReadDlvSur:boolean;
begin
  Result := ReadData('TIB',cDlvSur);
end;

procedure TAfcTib.WriteDlvSur(pValue:boolean);
begin
  WriteData('TIB',cDlvSur,pValue);
end;

// ---------------------------- TlaË ---------------------------------

function TAfcTib.ReadDocPrn:boolean;
begin
  Result := ReadData('TIB',cDocPrn);
end;

procedure TAfcTib.WriteDocPrn(pValue:boolean);
begin
  WriteData('TIB',cDocPrn,pValue);
end;

function TAfcTib.ReadLabPrn:boolean;
begin
  Result := ReadData('TIB',cLabPrn);
end;

procedure TAfcTib.WriteLabPrn(pValue:boolean);
begin
  WriteData('TIB',cLabPrn,pValue);
end;

// ---------------------------- N·stroje -----------------------------

function TAfcTib.ReadDocFlt:boolean;
begin
  Result := ReadData('TIB',cDocFlt);
end;

procedure TAfcTib.WriteDocFlt(pValue:boolean);
begin
  WriteData('TIB',cDocFlt,pValue);
end;

function TAfcTib.ReadTsdGen:boolean;
begin
  Result := ReadData('TIB',cTsdGen);
end;

procedure TAfcTib.WriteTsdGen(pValue:boolean);
begin
  WriteData('TIB',cTsdGen,pValue);
end;

function TAfcTib.ReadImdPar:boolean;
begin
  Result := ReadData('TIB',cImdPar);
end;

procedure TAfcTib.WriteImdPar(pValue:boolean);
begin
  WriteData('TIB',cImdPar,pValue);
end;

// ---------------------------- ⁄drûba -------------------------------

function TAfcTib.ReadMntFnc:boolean;
begin
  Result := ReadData('TIB',cMntFnc);
end;

procedure TAfcTib.WriteMntFnc(pValue:boolean);
begin
  WriteData('TIB',cMntFnc,pValue);
end;

// ---------------------------- Servis -------------------------------

function TAfcTib.ReadSerFnc:boolean;
begin
  Result := ReadData('TIB',cSerFnc);
end;

procedure TAfcTib.WriteSerFnc(pValue:boolean);
begin
  WriteData('TIB',cSerFnc,pValue);
end;

// ---------------------------- Poloûky ------------------------------

function TAfcTib.ReadItmAdd:boolean;
begin
  Result := ReadData('TIB',cItmAdd);
end;

procedure TAfcTib.WriteItmAdd(pValue:boolean);
begin
  WriteData('TIB',cItmAdd,pValue);
end;

function TAfcTib.ReadItmDel:boolean;
begin
  Result := ReadData('TIB',cItmDel);
end;

procedure TAfcTib.WriteItmDel(pValue:boolean);
begin
  WriteData('TIB',cItmDel,pValue);
end;

function TAfcTib.ReadItmMod:boolean;
begin
  Result := ReadData('TIB',cItmMod);
end;

procedure TAfcTib.WriteItmMod(pValue:boolean);
begin
  WriteData('TIB',cItmMod,pValue);
end;

end.
