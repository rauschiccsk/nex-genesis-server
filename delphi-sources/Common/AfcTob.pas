unit AfcTob;

interface

uses
  IcTypes, IcTools, NexPath, NexGlob, AfcBas,
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, NexBtrTable, Forms;

type
  TAfcTob = class (TAfcBas)
  private
    // ---------------------------- ⁄pravy -------------------------------
    function ReadDocAdd:boolean;    procedure WriteDocAdd(pValue:boolean);
    function ReadDocDel:boolean;    procedure WriteDocDel(pValue:boolean);
    function ReadDocMod:boolean;    procedure WriteDocMod(pValue:boolean);
    function ReadDocDsc:boolean;    procedure WriteDocDsc(pValue:boolean);
    function ReadDocLck:boolean;    procedure WriteDocLck(pValue:boolean);
    function ReadDocUnl:boolean;    procedure WriteDocUnl(pValue:boolean);
    function ReadEpcEdi:boolean;    procedure WriteEpcEdi(pValue:boolean);
    // ---------------------------- Zobraziù -----------------------------
    function ReadSitLst:boolean;    procedure WriteSitLst(pValue:boolean);
    function ReadNopToi:boolean;    procedure WriteNopToi(pValue:boolean);
    function ReadNitLst: boolean;   procedure WriteNitLst(pValue: boolean);
    function ReadDitLst: boolean;   procedure WriteDitLst(pValue: boolean);
    function ReadNocLst: boolean;   procedure WriteNocLst(pValue: boolean);
    function ReadBlkVie: boolean;   procedure WriteBlkVie(pValue: boolean);
    // ---------------------------- TlaË ---------------------------------
    function ReadDocPrn:boolean;    procedure WriteDocPrn(pValue:boolean);
    // ---------------------------- N·stroje -----------------------------
    function ReadDocFlt:boolean;    procedure WriteDocFlt(pValue:boolean);
    function ReadOceLst:boolean;    procedure WriteOceLst(pValue:boolean);
    function ReadExdGen:boolean;    procedure WriteExdGen(pValue:boolean);
    function ReadOutGen:boolean;    procedure WriteOutGen(pValue:boolean);
    function ReadCadGen:boolean;    procedure WriteCadGen(pValue:boolean);
    function ReadIcdGen:boolean;    procedure WriteIcdGen(pValue:boolean);
    function ReadTcdGen:boolean;    procedure WriteTcdGen(pValue:boolean);
    function ReadOcdGen:boolean;    procedure WriteOcdGen(pValue:boolean);
    function ReadOmdGen:boolean;    procedure WriteOmdGen(pValue:boolean);
    function ReadSalEvl:boolean;    procedure WriteSalEvl(pValue:boolean);
    function ReadDlrEvl:boolean;    procedure WriteDlrEvl(pValue:boolean);
    function ReadTrmEvl:boolean;    procedure WriteTrmEvl(pValue:boolean);
    function ReadIncDoc:boolean;    procedure WriteIncDoc(pValue:boolean);
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
    property DocMod:boolean read ReadDocMod write WriteDocMod;
    property DocDsc:boolean read ReadDocDsc write WriteDocDsc;
    property DocLck:boolean read ReadDocLck write WriteDocLck;
    property DocUnl:boolean read ReadDocUnl write WriteDocUnl;
    property EpcEdi:boolean read ReadEpcEdi write WriteEpcEdi;
    // ---------------------------- Zobraziù -----------------------------
    property SitLst:boolean read ReadSitLst write WriteSitLst;
    property NopToi:boolean read ReadNopToi write WriteNopToi;
    property NitLst:boolean read ReadNitLst write WriteNitLst;
    property DitLst:boolean read ReadDitLst write WriteDitLst;
    property NocLst:boolean read ReadNocLst write WriteNocLst;
    property BlkVie:boolean read ReadBlkVie write WriteBlkVie;
    // ---------------------------- TlaË ---------------------------------
    property DocPrn:boolean read ReadDocPrn write WriteDocPrn;
    // ---------------------------- N·stroje -----------------------------
    property DocFlt:boolean read ReadDocFlt write WriteDocFlt;
    property OceLst:boolean read ReadOceLst write WriteOceLst;
    property ExdGen:boolean read ReadExdGen write WriteExdGen;
    property OutGen:boolean read ReadOutGen write WriteOutGen;
    property CadGen:boolean read ReadCadGen write WriteCadGen;
    property IcdGen:boolean read ReadIcdGen write WriteIcdGen;
    property TcdGen:boolean read ReadTcdGen write WriteTcdGen;
    property OcdGen:boolean read ReadOcdGen write WriteOcdGen;
    property OmdGen:boolean read ReadOmdGen write WriteOmdGen;
    property SalEvl:boolean read ReadSalEvl write WriteSalEvl;
    property DlrEvl:boolean read ReadDlrEvl write WriteDlrEvl;
    property TrmEvl:boolean read ReadTrmEvl write WriteTrmEvl;
    property IncDoc:boolean read ReadIncDoc write WriteIncDoc;
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
   cDocDel = 2;   cBokLst = 21;                 cOceLst = 61;                                cItmDel = 151;
   cDocMod = 3;   cNopToi = 22;                 cExdGen = 62;                                cItmMod = 152;
   cDocDsc = 4;                                 cOutGen = 63;
   cDocRnd = 5;   cNitLst = 24;                 cCadGen = 64;
   cDocLck = 6;   cDitLst = 25;                 cIcdGen = 65;
   cDocUnl = 8;   cNocLst = 26;                 cTcdGen = 66;
   cEpcEdi = 9;   cBlkVie = 27;                 cOcdGen = 67;
                                                cOmdGen = 68;
                                                cSalEvl = 69;
                                                cDlrEvl = 70;
                                                cTrmEvl = 71;
                                                cIncDoc = 72;
// **************************************** OBJECT *****************************************

// ---------------------------- ⁄pravy -------------------------------

function TAfcTob.ReadDocAdd:boolean;
begin
  Result := ReadData('TOB',cDocAdd);
end;

procedure TAfcTob.WriteDocAdd(pValue:boolean);
begin
  WriteData('TOB',cDocAdd,pValue);
end;

function TAfcTob.ReadDocDel:boolean;
begin
  Result := ReadData('TOB',cDocDel);
end;

procedure TAfcTob.WriteDocDel(pValue:boolean);
begin
  WriteData('TOB',cDocDel,pValue);
end;

function TAfcTob.ReadDocMod:boolean;
begin
  Result := ReadData('TOB',cDocMod);
end;

procedure TAfcTob.WriteDocMod(pValue:boolean);
begin
  WriteData('TOB',cDocMod,pValue);
end;

function TAfcTob.ReadDocDsc:boolean;
begin
  Result := ReadData('TOB',cDocDsc);
end;

procedure TAfcTob.WriteDocDsc(pValue:boolean);
begin
  WriteData('TOB',cDocDsc,pValue);
end;

function TAfcTob.ReadDocLck:boolean;
begin
  Result := ReadData('TOB',cDocLck);
end;

procedure TAfcTob.WriteDocLck(pValue:boolean);
begin
  WriteData('TOB',cDocLck,pValue);
end;

function TAfcTob.ReadDocUnl:boolean;
begin
  Result := ReadData('TOB',cDocUnl);
end;

procedure TAfcTob.WriteDocUnl(pValue:boolean);
begin
  WriteData('TOB',cDocUnl,pValue);
end;

function TAfcTob.ReadEpcEdi:boolean;
begin
  Result := ReadData('TOB',cEpcEdi);
end;

procedure TAfcTob.WriteEpcEdi(pValue:boolean);
begin
  WriteData('TOB',cEpcEdi,pValue);
end;

// ---------------------------- Zobraziù -----------------------------

function TAfcTob.ReadSitLst:boolean;
begin
  Result := ReadData('TOB',cSitLst);
end;

procedure TAfcTob.WriteSitLst(pValue:boolean);
begin
  WriteData('TOB',cSitLst,pValue);
end;

function TAfcTob.ReadNopToi:boolean;
begin
  Result := ReadData('TOB',cNopToi);
end;

procedure TAfcTob.WriteNopToi(pValue:boolean);
begin
  WriteData('TOB',cNopToi,pValue);
end;

function TAfcTob.ReadNitLst: boolean;
begin
  Result := ReadData('TOB',cNitLst);
end;

procedure TAfcTob.WriteNitLst(pValue: boolean);
begin
  WriteData('TOB',cNitLst,pValue);
end;

function TAfcTob.ReadDitLst: boolean;
begin
  Result := ReadData('TOB',cDitLst);
end;

procedure TAfcTob.WriteDitLst(pValue: boolean);
begin
  WriteData('TOB',cDitLst,pValue);
end;

function TAfcTob.ReadNocLst: boolean;
begin
  Result := ReadData('TOB',cNocLst);
end;

procedure TAfcTob.WriteNocLst(pValue: boolean);
begin
  WriteData('TOB',cNocLst,pValue);
end;

function TAfcTob.ReadBlkVie: boolean;
begin
  Result := ReadData('TOB',cBlkVie);
end;

procedure TAfcTob.WriteBlkVie(pValue: boolean);
begin
  WriteData('TOB',cBlkVie,pValue);
end;

// ---------------------------- TlaË ---------------------------------

function TAfcTob.ReadDocPrn:boolean;
begin
  Result := ReadData('TOB',cDocPrn);
end;

procedure TAfcTob.WriteDocPrn(pValue:boolean);
begin
  WriteData('TOB',cDocPrn,pValue);
end;

// ---------------------------- N·stroje -----------------------------

function TAfcTob.ReadDocFlt:boolean;
begin
  Result := ReadData('TOB',cDocFlt);
end;

procedure TAfcTob.WriteDocFlt(pValue:boolean);
begin
  WriteData('TOB',cDocFlt,pValue);
end;

function TAfcTob.ReadOceLst:boolean;
begin
  Result := ReadData('TOB',cOceLst);
end;

procedure TAfcTob.WriteOceLst(pValue:boolean);
begin
  WriteData('TOB',cOceLst,pValue);
end;

function TAfcTob.ReadExdGen:boolean;
begin
  Result := ReadData('TOB',cExdGen);
end;

procedure TAfcTob.WriteExdGen(pValue:boolean);
begin
  WriteData('TOB',cExdGen,pValue);
end;

function TAfcTob.ReadOutGen:boolean;
begin
  Result := ReadData('TOB',cOutGen);
end;

procedure TAfcTob.WriteOutGen(pValue:boolean);
begin
  WriteData('TOB',cOutGen,pValue);
end;

function TAfcTob.ReadCadGen:boolean;
begin
  Result := ReadData('TOB',cCadGen);
end;

procedure TAfcTob.WriteCadGen(pValue:boolean);
begin
  WriteData('TOB',cCadGen,pValue);
end;

function TAfcTob.ReadIcdGen:boolean;
begin
  Result := ReadData('TOB',cIcdGen);
end;

procedure TAfcTob.WriteIcdGen(pValue:boolean);
begin
  WriteData('TOB',cIcdGen,pValue);
end;

function TAfcTob.ReadTcdGen:boolean;
begin
  Result := ReadData('TOB',cTcdGen);
end;

procedure TAfcTob.WriteTcdGen(pValue:boolean);
begin
  WriteData('TOB',cTcdGen,pValue);
end;

function TAfcTob.ReadOcdGen:boolean;
begin
  Result := ReadData('TOB',cOcdGen);
end;

procedure TAfcTob.WriteOcdGen(pValue:boolean);
begin
  WriteData('TOB',cOcdGen,pValue);
end;

function TAfcTob.ReadOmdGen:boolean;
begin
  Result := ReadData('TOB',cOmdGen);
end;

procedure TAfcTob.WriteOmdGen(pValue:boolean);
begin
  WriteData('TOB',cOmdGen,pValue);
end;

function TAfcTob.ReadSalEvl:boolean;
begin
  Result := ReadData('TOB',cSalEvl);
end;

procedure TAfcTob.WriteSalEvl(pValue:boolean);
begin
  WriteData('TOB',cSalEvl,pValue);
end;

function TAfcTob.ReadDlrEvl:boolean;
begin
  Result := ReadData('TOB',cDlrEvl);
end;

procedure TAfcTob.WriteDlrEvl(pValue:boolean);
begin
  WriteData('TOB',cDlrEvl,pValue);
end;

function TAfcTob.ReadTrmEvl:boolean;
begin
  Result := ReadData('TOB',cTrmEvl);
end;

procedure TAfcTob.WriteTrmEvl(pValue:boolean);
begin
  WriteData('TOB',cTrmEvl,pValue);
end;

function TAfcTob.ReadIncDoc:boolean;
begin
  Result := ReadData('TOB',cIncDoc);
end;

procedure TAfcTob.WriteIncDoc(pValue:boolean);
begin
  WriteData('TOB',cIncDoc,pValue);
end;

// ---------------------------- ⁄drûba -------------------------------

function TAfcTob.ReadMntFnc:boolean;
begin
  Result := ReadData('TOB',cMntFnc);
end;

procedure TAfcTob.WriteMntFnc(pValue:boolean);
begin
  WriteData('TOB',cMntFnc,pValue);
end;

// ---------------------------- Servis -------------------------------

function TAfcTob.ReadSerFnc:boolean;
begin
  Result := ReadData('TOB',cSerFnc);
end;

procedure TAfcTob.WriteSerFnc(pValue:boolean);
begin
  WriteData('TOB',cSerFnc,pValue);
end;

// ---------------------------- Poloûky ------------------------------

function TAfcTob.ReadItmAdd:boolean;
begin
  Result := ReadData('TOB',cItmAdd);
end;

procedure TAfcTob.WriteItmAdd(pValue:boolean);
begin
  WriteData('TOB',cItmAdd,pValue);
end;

function TAfcTob.ReadItmDel:boolean;
begin
  Result := ReadData('TOB',cItmDel);
end;

procedure TAfcTob.WriteItmDel(pValue:boolean);
begin
  WriteData('TOB',cItmDel,pValue);
end;

function TAfcTob.ReadItmMod:boolean;
begin
  Result := ReadData('TOB',cItmMod);
end;

procedure TAfcTob.WriteItmMod(pValue:boolean);
begin
  WriteData('TOB',cItmMod,pValue);
end;

end.
