unit AfcWab;

interface

uses
  IcTypes, IcTools, NexPath, NexGlob, AfcBas,
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, NexBtrTable, Forms;

type
  TAfcWab = class (TAfcBas)
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
    function ReadEpcLst:boolean;    procedure WriteEpcLst(pValue:boolean);
    function ReadWpcDef:boolean;    procedure WriteWpcDef(pValue:boolean);
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
    property EpcLst:boolean read ReadEpcLst write WriteEpcLst;
    property WpcDef:boolean read ReadWpcDef write WriteWpcDef;
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
   cDocDel = 2;   cBokLst = 21;                 cEpcLst = 61;                                  cItmDel = 142;
   cDocMod = 3;                                 cWpcDef = 62;                                  cItmMod = 143;
   cDocDsc = 4;
   cDocRnd = 5;
   cDocLck = 6;
   cDocUnl = 8;                                 
   cVatChg = 9;                                 
                                                

// **************************************** OBJECT *****************************************

// ---------------------------- ⁄pravy -------------------------------

function TAfcWab.ReadDocAdd:boolean;
begin
  Result := ReadData('WAB',cDocAdd);
end;

procedure TAfcWab.WriteDocAdd(pValue:boolean);
begin
  WriteData('WAB',cDocAdd,pValue);
end;

function TAfcWab.ReadDocDel:boolean;
begin
  Result := ReadData('WAB',cDocDel);
end;

procedure TAfcWab.WriteDocDel(pValue:boolean);
begin
  WriteData('WAB',cDocDel,pValue);
end;

function TAfcWab.ReadDocMod:boolean;
begin
  Result := ReadData('WAB',cDocMod);
end;

procedure TAfcWab.WriteDocMod(pValue:boolean);
begin
  WriteData('WAB',cDocMod,pValue);
end;

function TAfcWab.ReadDocDsc:boolean;
begin
  Result := ReadData('WAB',cDocDsc);
end;

procedure TAfcWab.WriteDocDsc(pValue:boolean);
begin
  WriteData('WAB',cDocDsc,pValue);
end;

function TAfcWab.ReadDocLck:boolean;
begin
  Result := ReadData('WAB',cDocLck);
end;

procedure TAfcWab.WriteDocLck(pValue:boolean);
begin
  WriteData('WAB',cDocLck,pValue);
end;

function TAfcWab.ReadDocUnl:boolean;
begin
  Result := ReadData('WAB',cDocUnl);
end;

procedure TAfcWab.WriteDocUnl(pValue:boolean);
begin
  WriteData('WAB',cDocUnl,pValue);
end;

function TAfcWab.ReadVatChg:boolean;
begin
  Result := ReadData('WAB',cVatChg);
end;

procedure TAfcWab.WriteVatChg(pValue:boolean);
begin
  WriteData('WAB',cVatChg,pValue);
end;

// ---------------------------- Zobraziù -----------------------------

function TAfcWab.ReadSitLst:boolean;
begin
  Result := ReadData('WAB',cSitLst);
end;

procedure TAfcWab.WriteSitLst(pValue:boolean);
begin
  WriteData('WAB',cSitLst,pValue);
end;

// ---------------------------- TlaË ---------------------------------

function TAfcWab.ReadDocPrn:boolean;
begin
  Result := ReadData('WAB',cDocPrn);
end;

procedure TAfcWab.WriteDocPrn(pValue:boolean);
begin
  WriteData('WAB',cDocPrn,pValue);
end;

// ---------------------------- N·stroje -----------------------------

function TAfcWab.ReadDocFlt:boolean;
begin
  Result := ReadData('WAB',cDocFlt);
end;

procedure TAfcWab.WriteDocFlt(pValue:boolean);
begin
  WriteData('WAB',cDocFlt,pValue);
end;

function TAfcWab.ReadEpcLst:boolean;
begin
  Result := ReadData('WAB',cEpcLst);
end;

procedure TAfcWab.WriteEpcLst(pValue:boolean);
begin
  WriteData('WAB',cEpcLst,pValue);
end;

function TAfcWab.ReadWpcDef:boolean;
begin
  Result := ReadData('WAB',cWpcDef);
end;

procedure TAfcWab.WriteWpcDef(pValue:boolean);
begin
  WriteData('WAB',cWpcDef,pValue);
end;

// ---------------------------- ⁄drûba -------------------------------

function TAfcWab.ReadMntFnc:boolean;
begin
  Result := ReadData('WAB',cMntFnc);
end;

procedure TAfcWab.WriteMntFnc(pValue:boolean);
begin
  WriteData('WAB',cMntFnc,pValue);
end;

// ---------------------------- Servis -------------------------------

function TAfcWab.ReadSerFnc:boolean;
begin
  Result := ReadData('WAB',cSerFnc);
end;

procedure TAfcWab.WriteSerFnc(pValue:boolean);
begin
  WriteData('WAB',cSerFnc,pValue);
end;

// ---------------------------- Poloûky ------------------------------

function TAfcWab.ReadItmAdd:boolean;
begin
  Result := ReadData('WAB',cItmAdd);
end;

procedure TAfcWab.WriteItmAdd(pValue:boolean);
begin
  WriteData('WAB',cItmAdd,pValue);
end;

function TAfcWab.ReadItmDel:boolean;
begin
  Result := ReadData('WAB',cItmDel);
end;

procedure TAfcWab.WriteItmDel(pValue:boolean);
begin
  WriteData('WAB',cItmDel,pValue);
end;

function TAfcWab.ReadItmMod:boolean;
begin
  Result := ReadData('WAB',cItmMod);
end;

procedure TAfcWab.WriteItmMod(pValue:boolean);
begin
  WriteData('WAB',cItmMod,pValue);
end;

end.
