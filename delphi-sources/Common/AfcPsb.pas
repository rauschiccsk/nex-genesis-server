unit AfcPsb;

interface

uses
  IcTypes, IcTools, NexPath, NexGlob, AfcBas,
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, NexBtrTable, Forms;

type
  TAfcPsb = class (TAfcBas)
  private
    // ---------------------------- ⁄pravy -------------------------------
    function ReadDocAdd:boolean;    procedure WriteDocAdd(pValue:boolean);
    function ReadDocDel:boolean;    procedure WriteDocDel(pValue:boolean);
    function ReadDocMod:boolean;    procedure WriteDocMod(pValue:boolean);
    function ReadDocDsc:boolean;    procedure WriteDocDsc(pValue:boolean);
    function ReadDocLck:boolean;    procedure WriteDocLck(pValue:boolean);
    function ReadDocUnl:boolean;    procedure WriteDocUnl(pValue:boolean);
    function ReadVatChg:boolean;    procedure WriteVatChg(pValue:boolean);
    function ReadPsdGen:boolean;    procedure WritePsdGen(pValue:boolean);
    // ---------------------------- Zobraziù -----------------------------
    function ReadSitLst:boolean;    procedure WriteSitLst(pValue:boolean);
    function ReadOssItm:boolean;    procedure WriteOssItm(pValue:boolean);
    // ---------------------------- TlaË ---------------------------------
    function ReadDocPrn:boolean;    procedure WriteDocPrn(pValue:boolean);
    function ReadPrnMor:boolean;    procedure WritePrnMor(pValue:boolean);
    // ---------------------------- N·stroje -----------------------------
    function ReadDocFlt:boolean;    procedure WriteDocFlt(pValue:boolean);
    function ReadOsdGen:boolean;    procedure WriteOsdGen(pValue:boolean);
    function ReadOssMov:boolean;    procedure WriteOssMov(pValue:boolean);
    // ---------------------------- ⁄drûba -------------------------------
    function ReadMntFnc:boolean;    procedure WriteMntFnc(pValue:boolean);
    function ReadDocClc:boolean;    procedure WriteDocClc(pValue:boolean);
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
    property PsdGen:boolean read ReadPsdGen write WritePsdGen;
    // ---------------------------- Zobraziù -----------------------------
    property SitLst:boolean read ReadSitLst write WriteSitLst;
    property OssItm:boolean read ReadOssItm write WriteOssItm;
    // ---------------------------- TlaË ---------------------------------
    property DocPrn:boolean read ReadDocPrn write WriteDocPrn;
    property PrnMor:boolean read ReadPrnMor write WritePrnMor;
    // ---------------------------- N·stroje -----------------------------
    property DocFlt:boolean read ReadDocFlt write WriteDocFlt;
    property OsdGen:boolean read ReadOsdGen write WriteOsdGen;
    property OssMov:boolean read ReadOssMov write WriteOssMov;
    // ---------------------------- ⁄drûba -------------------------------
    property MntFnc:boolean read ReadMntFnc write WriteMntFnc;
    property DocClc:boolean read ReadDocClc write WriteDocClc;
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
   cDocDel = 2;   cBokLst = 21;  cPrnMor = 41;  cOsdGen = 61;  cDocClc = 101;                  cItmDel = 142;
   cDocMod = 3;   cOssItm = 22;                 cOssMov = 62;                                  cItmMod = 143;
   cDocDsc = 4;
   cDocRnd = 5;
   cDocLck = 6;
   cDocUnl = 8;                                 
   cVatChg = 9;
   cPsdGen =10;


// **************************************** OBJECT *****************************************

// ---------------------------- ⁄pravy -------------------------------

function TAfcPsb.ReadDocAdd:boolean;
begin
  Result := ReadData('PSB',cDocAdd);
end;

procedure TAfcPsb.WriteDocAdd(pValue:boolean);
begin
  WriteData('PSB',cDocAdd,pValue);
end;

function TAfcPsb.ReadDocDel:boolean;
begin
  Result := ReadData('PSB',cDocDel);
end;

procedure TAfcPsb.WriteDocDel(pValue:boolean);
begin
  WriteData('PSB',cDocDel,pValue);
end;

function TAfcPsb.ReadDocMod:boolean;
begin
  Result := ReadData('PSB',cDocMod);
end;

procedure TAfcPsb.WriteDocMod(pValue:boolean);
begin
  WriteData('PSB',cDocMod,pValue);
end;

function TAfcPsb.ReadDocDsc:boolean;
begin
  Result := ReadData('PSB',cDocDsc);
end;

procedure TAfcPsb.WriteDocDsc(pValue:boolean);
begin
  WriteData('PSB',cDocDsc,pValue);
end;

function TAfcPsb.ReadDocLck:boolean;
begin
  Result := ReadData('PSB',cDocLck);
end;

procedure TAfcPsb.WriteDocLck(pValue:boolean);
begin
  WriteData('PSB',cDocLck,pValue);
end;

function TAfcPsb.ReadDocUnl:boolean;
begin
  Result := ReadData('PSB',cDocUnl);
end;

procedure TAfcPsb.WriteDocUnl(pValue:boolean);
begin
  WriteData('PSB',cDocUnl,pValue);
end;

function TAfcPsb.ReadVatChg:boolean;
begin
  Result := ReadData('PSB',cVatChg);
end;

procedure TAfcPsb.WriteVatChg(pValue:boolean);
begin
  WriteData('PSB',cVatChg,pValue);
end;

function TAfcPsb.ReadPsdGen:boolean;
begin
  Result := ReadData('PSB',cPsdGen);
end;

procedure TAfcPsb.WritePsdGen(pValue:boolean);
begin
  WriteData('PSB',cPsdGen,pValue);
end;

// ---------------------------- Zobraziù -----------------------------

function TAfcPsb.ReadSitLst:boolean;
begin
  Result := ReadData('PSB',cSitLst);
end;

procedure TAfcPsb.WriteSitLst(pValue:boolean);
begin
  WriteData('PSB',cSitLst,pValue);
end;

function TAfcPsb.ReadOssItm:boolean;
begin
  Result := ReadData('PSB',cOssItm);
end;

procedure TAfcPsb.WriteOssItm(pValue:boolean);
begin
  WriteData('PSB',cOssItm,pValue);
end;

// ---------------------------- TlaË ---------------------------------

function TAfcPsb.ReadDocPrn:boolean;
begin
  Result := ReadData('PSB',cDocPrn);
end;

procedure TAfcPsb.WriteDocPrn(pValue:boolean);
begin
  WriteData('PSB',cDocPrn,pValue);
end;

function TAfcPsb.ReadPrnMor:boolean;
begin
  Result := ReadData('PSB',cPrnMor);
end;

procedure TAfcPsb.WritePrnMor(pValue:boolean);
begin
  WriteData('PSB',cPrnMor,pValue);
end;

// ---------------------------- N·stroje -----------------------------

function TAfcPsb.ReadDocFlt:boolean;
begin
  Result := ReadData('PSB',cDocFlt);
end;

procedure TAfcPsb.WriteDocFlt(pValue:boolean);
begin
  WriteData('PSB',cDocFlt,pValue);
end;

function TAfcPsb.ReadOsdGen:boolean;
begin
  Result := ReadData('PSB',cOsdGen);
end;

procedure TAfcPsb.WriteOsdGen(pValue:boolean);
begin
  WriteData('PSB',cOsdGen,pValue);
end;

function TAfcPsb.ReadOssMov:boolean;
begin
  Result := ReadData('PSB',cOssMov);
end;

procedure TAfcPsb.WriteOssMov(pValue:boolean);
begin
  WriteData('PSB',cOssMov,pValue);
end;

// ---------------------------- ⁄drûba -------------------------------

function TAfcPsb.ReadMntFnc:boolean;
begin
  Result := ReadData('PSB',cMntFnc);
end;

procedure TAfcPsb.WriteMntFnc(pValue:boolean);
begin
  WriteData('PSB',cMntFnc,pValue);
end;

function TAfcPsb.ReadDocClc:boolean;
begin
  Result := ReadData('PSB',cDocClc);
end;

procedure TAfcPsb.WriteDocClc(pValue:boolean);
begin
  WriteData('PSB',cDocClc,pValue);
end;

// ---------------------------- Servis -------------------------------

function TAfcPsb.ReadSerFnc:boolean;
begin
  Result := ReadData('PSB',cSerFnc);
end;

procedure TAfcPsb.WriteSerFnc(pValue:boolean);
begin
  WriteData('PSB',cSerFnc,pValue);
end;

// ---------------------------- Poloûky ------------------------------

function TAfcPsb.ReadItmAdd:boolean;
begin
  Result := ReadData('PSB',cItmAdd);
end;

procedure TAfcPsb.WriteItmAdd(pValue:boolean);
begin
  WriteData('PSB',cItmAdd,pValue);
end;

function TAfcPsb.ReadItmDel:boolean;
begin
  Result := ReadData('PSB',cItmDel);
end;

procedure TAfcPsb.WriteItmDel(pValue:boolean);
begin
  WriteData('PSB',cItmDel,pValue);
end;

function TAfcPsb.ReadItmMod:boolean;
begin
  Result := ReadData('PSB',cItmMod);
end;

procedure TAfcPsb.WriteItmMod(pValue:boolean);
begin
  WriteData('PSB',cItmMod,pValue);
end;

end.
