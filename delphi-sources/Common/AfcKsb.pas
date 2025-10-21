unit AfcKsb;

interface

uses
  IcTypes, IcTools, NexPath, NexGlob, AfcBas,
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, NexBtrTable, Forms;

type
  TAfcKsb = class (TAfcBas)
  private
    // ---------------------------- ⁄pravy -------------------------------
    function ReadDocAdd:boolean;    procedure WriteDocAdd(pValue:boolean);
    function ReadDocDel:boolean;    procedure WriteDocDel(pValue:boolean);
    function ReadDocMod:boolean;    procedure WriteDocMod(pValue:boolean);
    function ReadDocDsc:boolean;    procedure WriteDocDsc(pValue:boolean);
    function ReadDocLck:boolean;    procedure WriteDocLck(pValue:boolean);
    function ReadDocUnl:boolean;    procedure WriteDocUnl(pValue:boolean);
    function ReadVatChg:boolean;    procedure WriteVatChg(pValue:boolean);
    // ---------------------------- Zobraziù -----------------------------
    function ReadSitLst:boolean;    procedure WriteSitLst(pValue:boolean);
    // ---------------------------- TlaË ---------------------------------
    function ReadDocPrn:boolean;    procedure WriteDocPrn(pValue:boolean);
    // ---------------------------- N·stroje -----------------------------
    function ReadDocFlt:boolean;    procedure WriteDocFlt(pValue:boolean);
    function ReadTsdGen:boolean;    procedure WriteTsdGen(pValue:boolean);
    // ---------------------------- ⁄drûba -------------------------------
    function ReadMntFnc:boolean;    procedure WriteMntFnc(pValue:boolean);
    // ---------------------------- SERVIS -------------------------------
    function ReadSerFnc:boolean;    procedure WriteSerFnc(pValue:boolean);
    // ---------------------------- Poloûky ------------------------------
    function ReadItmAdd:boolean;    procedure WriteItmAdd(pValue:boolean);
    function ReadItmDel:boolean;    procedure WriteItmDel(pValue:boolean);
    function ReadItmMod:boolean;    procedure WriteItmMod(pValue:boolean);
  public
    // ---------------------------- ⁄pravy -------------------------------
    property DocAdd:boolean read ReadDocAdd write WriteDocAdd;
    property DocDel:boolean read ReadDocDel write WriteDocDel;
    property DocMod:boolean read ReadDocMod write WriteDocMod;
    property DocDsc:boolean read ReadDocDsc write WriteDocDsc;
    property DocLck:boolean read ReadDocLck write WriteDocLck;
    property DocUnl:boolean read ReadDocUnl write WriteDocUnl;
    property VatChg:boolean read ReadVatChg write WriteVatChg;
    // ---------------------------- Zobraziù -----------------------------
    property SitLst:boolean read ReadSitLst write WriteSitLst;
    // ---------------------------- TlaË ---------------------------------
    property DocPrn:boolean read ReadDocPrn write WriteDocPrn;
    // ---------------------------- N·stroje -----------------------------
    property DocFlt:boolean read ReadDocFlt write WriteDocFlt;
    property TsdGen:boolean read ReadTsdGen write WriteTsdGen;
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
// Upravy ------  Zobrazit ----  Tlac --------  N·stroje ----  ⁄drzba -------  Servis ------   Polozky ------
   cDocAdd = 1;   cSitLst = 20;  cDocPrn = 40;  cDocFlt = 60;  cMntFnc = 100;  cSerFnc = 120;  cItmAdd = 141;
   cDocDel = 2;   cBokLst = 21;                 cTsdGen = 61;                                  cItmDel = 142;
   cDocMod = 3;                                                                                cItmMod = 143;
   cDocDsc = 4;
   cDocRnd = 5;
   cDocLck = 6;
   cDocUnl = 8;                                 
   cVatChg = 9;                                 
                                                

// **************************************** OBJECT *****************************************

// ---------------------------- ⁄pravy -------------------------------

function TAfcKsb.ReadDocAdd:boolean;
begin
  Result := ReadData('KSB',cDocAdd);
end;

procedure TAfcKsb.WriteDocAdd(pValue:boolean);
begin
  WriteData('KSB',cDocAdd,pValue);
end;

function TAfcKsb.ReadDocDel:boolean;
begin
  Result := ReadData('KSB',cDocDel);
end;

procedure TAfcKsb.WriteDocDel(pValue:boolean);
begin
  WriteData('KSB',cDocDel,pValue);
end;

function TAfcKsb.ReadDocMod:boolean;
begin
  Result := ReadData('KSB',cDocMod);
end;

procedure TAfcKsb.WriteDocMod(pValue:boolean);
begin
  WriteData('KSB',cDocMod,pValue);
end;

function TAfcKsb.ReadDocDsc:boolean;
begin
  Result := ReadData('KSB',cDocDsc);
end;

procedure TAfcKsb.WriteDocDsc(pValue:boolean);
begin
  WriteData('KSB',cDocDsc,pValue);
end;

function TAfcKsb.ReadDocLck:boolean;
begin
  Result := ReadData('KSB',cDocLck);
end;

procedure TAfcKsb.WriteDocLck(pValue:boolean);
begin
  WriteData('KSB',cDocLck,pValue);
end;

function TAfcKsb.ReadDocUnl:boolean;
begin
  Result := ReadData('KSB',cDocUnl);
end;

procedure TAfcKsb.WriteDocUnl(pValue:boolean);
begin
  WriteData('KSB',cDocUnl,pValue);
end;

function TAfcKsb.ReadVatChg:boolean;
begin
  Result := ReadData('KSB',cVatChg);
end;

procedure TAfcKsb.WriteVatChg(pValue:boolean);
begin
  WriteData('KSB',cVatChg,pValue);
end;

// ---------------------------- Zobraziù -----------------------------

function TAfcKsb.ReadSitLst:boolean;
begin
  Result := ReadData('KSB',cSitLst);
end;

procedure TAfcKsb.WriteSitLst(pValue:boolean);
begin
  WriteData('KSB',cSitLst,pValue);
end;

// ---------------------------- TlaË ---------------------------------

function TAfcKsb.ReadDocPrn:boolean;
begin
  Result := ReadData('KSB',cDocPrn);
end;

procedure TAfcKsb.WriteDocPrn(pValue:boolean);
begin
  WriteData('KSB',cDocPrn,pValue);
end;

// ---------------------------- N·stroje -----------------------------

function TAfcKsb.ReadDocFlt:boolean;
begin
  Result := ReadData('KSB',cDocFlt);
end;

procedure TAfcKsb.WriteDocFlt(pValue:boolean);
begin
  WriteData('KSB',cDocFlt,pValue);
end;

function TAfcKsb.ReadTsdGen:boolean;
begin
  Result := ReadData('KSB',cTsdGen);
end;

procedure TAfcKsb.WriteTsdGen(pValue:boolean);
begin
  WriteData('KSB',cTsdGen,pValue);
end;

// ---------------------------- ⁄drûba -------------------------------

function TAfcKsb.ReadMntFnc:boolean;
begin
  Result := ReadData('KSB',cMntFnc);
end;

procedure TAfcKsb.WriteMntFnc(pValue:boolean);
begin
  WriteData('KSB',cMntFnc,pValue);
end;

// ---------------------------- Servis -------------------------------

function TAfcKsb.ReadSerFnc:boolean;
begin
  Result := ReadData('KSB',cSerFnc);
end;

procedure TAfcKsb.WriteSerFnc(pValue:boolean);
begin
  WriteData('KSB',cSerFnc,pValue);
end;

// ---------------------------- Poloûky ------------------------------

function TAfcKsb.ReadItmAdd:boolean;
begin
  Result := ReadData('KSB',cItmAdd);
end;

procedure TAfcKsb.WriteItmAdd(pValue:boolean);
begin
  WriteData('KSB',cItmAdd,pValue);
end;

function TAfcKsb.ReadItmDel:boolean;
begin
  Result := ReadData('KSB',cItmDel);
end;

procedure TAfcKsb.WriteItmDel(pValue:boolean);
begin
  WriteData('KSB',cItmDel,pValue);
end;

function TAfcKsb.ReadItmMod:boolean;
begin
  Result := ReadData('KSB',cItmMod);
end;

procedure TAfcKsb.WriteItmMod(pValue:boolean);
begin
  WriteData('KSB',cItmMod,pValue);
end;

end.
