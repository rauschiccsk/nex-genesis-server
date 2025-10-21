unit AfcSab;

interface

uses
  IcTypes, IcTools, NexPath, NexGlob, AfcBas,
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, NexBtrTable, Forms;

type
  TAfcSab = class (TAfcBas)
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
    function ReadSagLst:boolean;    procedure WriteSagLst(pValue:boolean);
    function ReadSacLst:boolean;    procedure WriteSacLst(pValue:boolean);
    function ReadNsiLst:boolean;    procedure WriteNsiLst(pValue:boolean);
    function ReadNscLst:boolean;    procedure WriteNscLst(pValue:boolean);
    function ReadCasPay:boolean;    procedure WriteCasPay(pValue:boolean);
    function ReadAccLst:boolean;    procedure WriteAccLst(pValue:boolean);
    function ReadSapLst:boolean;    procedure WriteSapLst(pValue:boolean);
    // ---------------------------- TlaË ---------------------------------
    function ReadDocPrn:boolean;    procedure WriteDocPrn(pValue:boolean);
    function ReadSadPrn:boolean;    procedure WriteSadPrn(pValue:boolean);
    // ---------------------------- N·stroje -----------------------------
    function ReadDocFlt:boolean;    procedure WriteDocFlt(pValue:boolean);
    function ReadSalPro:boolean;    procedure WriteSalPro(pValue:boolean);
    function ReadAccDoc:boolean;    procedure WriteAccDoc(pValue:boolean);
    function ReadAccDel:boolean;    procedure WriteAccDel(pValue:boolean);
    function ReadAccBok:boolean;    procedure WriteAccBok(pValue:boolean);
    function ReadRefRep:boolean;    procedure WriteRefRep(pValue:boolean);
    function ReadCadVer:boolean;    procedure WriteCadVer(pValue:boolean);
    function ReadSabVer:boolean;    procedure WriteSabVer(pValue:boolean);
    function ReadSaiLos:boolean;    procedure WriteSaiLos(pValue:boolean);
    function ReadOitSnd:boolean;    procedure WriteOitSnd(pValue:boolean);
    function ReadSahDcl:boolean;    procedure WriteSahDcl(pValue:boolean);
    // ---------------------------- ⁄drûba -------------------------------
    function ReadMntFnc:boolean;    procedure WriteMntFnc(pValue:boolean);
    // ---------------------------- Servis -------------------------------
    function ReadSrvFnc:boolean;    procedure WriteSrvFnc(pValue:boolean);
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
    property SagLst:boolean read ReadSagLst write WriteSagLst;
    property SacLst:boolean read ReadSacLst write WriteSacLst;
    property NsiLst:boolean read ReadNsiLst write WriteNsiLst;
    property NscLst:boolean read ReadNscLst write WriteNscLst;
    property CasPay:boolean read ReadCasPay write WriteCasPay;
    property AccLst:boolean read ReadAccLst write WriteAccLst;
    property SapLst:boolean read ReadSapLst write WriteSapLst;
    // ---------------------------- TlaË ---------------------------------
    property DocPrn:boolean read ReadDocPrn write WriteDocPrn;
    property SadPrn:boolean read ReadSadPrn write WriteSadPrn;
    // ---------------------------- N·stroje -----------------------------
    property DocFlt:boolean read ReadDocFlt write WriteDocFlt;
    property SalPro:boolean read ReadSalPro write WriteSalPro;
    property AccDoc:boolean read ReadAccDoc write WriteAccDoc;
    property AccDel:boolean read ReadAccDel write WriteAccDel;
    property AccBok:boolean read ReadAccBok write WriteAccBok;
    property RefRep:boolean read ReadRefRep write WriteRefRep;
    property CadVer:boolean read ReadCadVer write WriteCadVer;
    property SabVer:boolean read ReadSabVer write WriteSabVer;
    property SaiLos:boolean read ReadSaiLos write WriteSaiLos;
    property OitSnd:boolean read ReadOitSnd write WriteOitSnd;
    property SahDcl:boolean read ReadSahDcl write WriteSahDcl;
    // ---------------------------- ⁄drûba -------------------------------
    property MntFnc:boolean read ReadMntFnc write WriteMntFnc;
    // ---------------------------- Servis -------------------------------
    property SrvFnc:boolean read ReadSrvFnc write WriteSrvFnc;
    // ---------------------------- Poloûky ------------------------------
    property ItmAdd:boolean read ReadItmAdd write WriteItmAdd;
    property ItmDel:boolean read ReadItmDel write WriteItmDel;
    property ItmMod:boolean read ReadItmMod write WriteItmMod;
  end;

implementation

const
// Upravy ------  Zobrazit ----  Tlac --------  N·stroje ----  Udrzba ------  Servis ------- Polozky -----
   cDocAdd = 1;   cSitLst = 20;  cDocPrn = 40;  cDocFlt = 60;  cMntFnc = 90;  cSrvFnc = 120; cItmAdd = 150;
   cDocDel = 2;   cBokLst = 21;  cSadPrn = 41;  cSalPro = 61;                                cItmDel = 151;
   cDocMod = 3;   cSagLst = 22;                 cAccDoc = 62;                                cItmMod = 152;
   cDocDsc = 4;   cSacLst = 23;                 cAccDel = 63;
   cDocRnd = 5;   cNsiLst = 24;                 cAccBok = 64;
   cDocLck = 6;   cNscLst = 25;                 cRefRep = 65;
   cDocUnl = 8;   cCasPay = 26;                 cCadVer = 66;
   cVatChg = 9;   cAccLst = 27;                 cSabVer = 67;
                  cSapLst = 28;                 cSaiLos = 68;
                                                cOitSnd = 69;
                                                cSahDcl = 70;
// **************************************** OBJECT *****************************************

// ---------------------------- ⁄pravy -------------------------------

function TAfcSab.ReadDocAdd:boolean;
begin
  Result := ReadData('SAB',cDocAdd);
end;

procedure TAfcSab.WriteDocAdd(pValue:boolean);
begin
  WriteData('SAB',cDocAdd,pValue);
end;

function TAfcSab.ReadDocDel:boolean;
begin
  Result := ReadData('SAB',cDocDel);
end;

procedure TAfcSab.WriteDocDel(pValue:boolean);
begin
  WriteData('SAB',cDocDel,pValue);
end;

function TAfcSab.ReadDocMod:boolean;
begin
  Result := ReadData('SAB',cDocMod);
end;

procedure TAfcSab.WriteDocMod(pValue:boolean);
begin
  WriteData('SAB',cDocMod,pValue);
end;

function TAfcSab.ReadDocDsc:boolean;
begin
  Result := ReadData('SAB',cDocDsc);
end;

procedure TAfcSab.WriteDocDsc(pValue:boolean);
begin
  WriteData('SAB',cDocDsc,pValue);
end;

function TAfcSab.ReadDocLck:boolean;
begin
  Result := ReadData('SAB',cDocLck);
end;

procedure TAfcSab.WriteDocLck(pValue:boolean);
begin
  WriteData('SAB',cDocLck,pValue);
end;

function TAfcSab.ReadDocUnl:boolean;
begin
  Result := ReadData('SAB',cDocUnl);
end;

procedure TAfcSab.WriteDocUnl(pValue:boolean);
begin
  WriteData('SAB',cDocUnl,pValue);
end;

function TAfcSab.ReadVatChg:boolean;
begin
  Result := ReadData('SAB',cVatChg);
end;

procedure TAfcSab.WriteVatChg(pValue:boolean);
begin
  WriteData('SAB',cVatChg,pValue);
end;

// ---------------------------- Zobraziù -----------------------------

function TAfcSab.ReadSitLst:boolean;
begin
  Result := ReadData('SAB',cSitLst);
end;

procedure TAfcSab.WriteSitLst(pValue:boolean);
begin
  WriteData('SAB',cSitLst,pValue);
end;

function TAfcSab.ReadSagLst:boolean;
begin
  Result := ReadData('SAB',cSagLst);
end;

procedure TAfcSab.WriteSagLst(pValue:boolean);
begin
  WriteData('SAB',cSagLst,pValue);
end;

function TAfcSab.ReadAccLst: boolean;
begin
  Result := ReadData('SAB',cAccLst);
end;

procedure TAfcSab.WriteAccLst(pValue: boolean);
begin
  WriteData('SAB',cAccLst,pValue);
end;

function TAfcSab.ReadCasPay: boolean;
begin
  Result := ReadData('SAB',cCasPay);
end;

procedure TAfcSab.WriteCasPay(pValue: boolean);
begin
  WriteData('SAB',cCasPay,pValue);
end;

function TAfcSab.ReadNscLst: boolean;
begin
  Result := ReadData('SAB',cNscLst);
end;

procedure TAfcSab.WriteNscLst(pValue: boolean);
begin
  WriteData('SAB',cNscLst,pValue);
end;

function TAfcSab.ReadNsiLst: boolean;
begin
  Result := ReadData('SAB',cNsiLst);
end;

procedure TAfcSab.WriteNsiLst(pValue: boolean);
begin
  WriteData('SAB',cNsiLst,pValue);
end;

function TAfcSab.ReadSacLst: boolean;
begin
  Result := ReadData('SAB',cSacLst);
end;

procedure TAfcSab.WriteSacLst(pValue: boolean);
begin
  WriteData('SAB',cSacLst,pValue);
end;

function TAfcSab.ReadSapLst: boolean;
begin
  Result := ReadData('SAB',cSapLst);
end;

procedure TAfcSab.WriteSapLst(pValue: boolean);
begin
  WriteData('SAB',cSapLst,pValue);
end;

// ---------------------------- TlaË ---------------------------------

function TAfcSab.ReadDocPrn:boolean;
begin
  Result := ReadData('SAB',cDocPrn);
end;

procedure TAfcSab.WriteDocPrn(pValue:boolean);
begin
  WriteData('SAB',cDocPrn,pValue);
end;

function TAfcSab.ReadSadPrn: boolean;
begin
  Result := ReadData('SAB',cSadPrn);
end;

procedure TAfcSab.WriteSadPrn(pValue: boolean);
begin
  WriteData('SAB',cSadPrn,pValue);
end;

// ---------------------------- N·stroje -----------------------------

function TAfcSab.ReadDocFlt:boolean;
begin
  Result := ReadData('SAB',cDocFlt);
end;

procedure TAfcSab.WriteDocFlt(pValue:boolean);
begin
  WriteData('SAB',cDocFlt,pValue);
end;

function TAfcSab.ReadSalPro:boolean;
begin
  Result := ReadData('SAB',cSalPro);
end;

procedure TAfcSab.WriteSalPro(pValue:boolean);
begin
  WriteData('SAB',cSalPro,pValue);
end;

function TAfcSab.ReadAccDoc:boolean;
begin
  Result := ReadData('SAB',cAccDoc);
end;

procedure TAfcSab.WriteAccDoc(pValue:boolean);
begin
  WriteData('SAB',cAccDoc,pValue);
end;

function TAfcSab.ReadAccDel:boolean;
begin
  Result := ReadData('SAB',cAccDel);
end;

procedure TAfcSab.WriteAccDel(pValue:boolean);
begin
  WriteData('SAB',cAccDel,pValue);
end;

function TAfcSab.ReadAccBok:boolean;
begin
  Result := ReadData('SAB',cAccBok);
end;

procedure TAfcSab.WriteAccBok(pValue:boolean);
begin
  WriteData('SAB',cAccBok,pValue);
end;

function TAfcSab.ReadRefRep:boolean;
begin
  Result := ReadData('SAB',cRefRep);
end;

procedure TAfcSab.WriteRefRep(pValue:boolean);
begin
  WriteData('SAB',cRefRep,pValue);
end;

function TAfcSab.ReadCadVer:boolean;
begin
  Result := ReadData('SAB',cCadVer);
end;

procedure TAfcSab.WriteCadVer(pValue:boolean);
begin
  WriteData('SAB',cCadVer,pValue);
end;

function TAfcSab.ReadSabVer:boolean;
begin
  Result := ReadData('SAB',cSabVer);
end;

procedure TAfcSab.WriteSabVer(pValue:boolean);
begin
  WriteData('SAB',cSabVer,pValue);
end;

function TAfcSab.ReadSaiLos:boolean;
begin
  Result := ReadData('SAB',cSaiLos);
end;

procedure TAfcSab.WriteSaiLos(pValue:boolean);
begin
  WriteData('SAB',cSaiLos,pValue);
end;

function TAfcSab.ReadOitSnd:boolean;
begin
  Result := ReadData('SAB',cOitSnd);
end;

procedure TAfcSab.WriteOitSnd(pValue:boolean);
begin
  WriteData('SAB',cOitSnd,pValue);
end;

function TAfcSab.ReadSahDcl:boolean;
begin
  Result := ReadData('SAB',cSahDcl);
end;

procedure TAfcSab.WriteSahDcl(pValue:boolean);
begin
  WriteData('SAB',cSahDcl,pValue);
end;

// ---------------------------- ⁄drûba -------------------------------

function TAfcSab.ReadMntFnc:boolean;
begin
  Result := ReadData('SAB',cMntFnc);
end;

procedure TAfcSab.WriteMntFnc(pValue:boolean);
begin
  WriteData('SAB',cMntFnc,pValue);
end;

// ---------------------------- Poloûky ------------------------------

function TAfcSab.ReadItmAdd:boolean;
begin
  Result := ReadData('SAB',cItmAdd);
end;

procedure TAfcSab.WriteItmAdd(pValue:boolean);
begin
  WriteData('SAB',cItmAdd,pValue);
end;

function TAfcSab.ReadItmDel:boolean;
begin
  Result := ReadData('SAB',cItmDel);
end;

procedure TAfcSab.WriteItmDel(pValue:boolean);
begin
  WriteData('SAB',cItmDel,pValue);
end;

function TAfcSab.ReadItmMod:boolean;
begin
  Result := ReadData('SAB',cItmMod);
end;

procedure TAfcSab.WriteItmMod(pValue:boolean);
begin
  WriteData('SAB',cItmMod,pValue);
end;

function TAfcSab.ReadSrvFnc: boolean;
begin
  Result := ReadData('SAB',cSrvFnc);
end;

procedure TAfcSab.WriteSrvFnc(pValue: boolean);
begin
  WriteData('SAB',cSrvFnc,pValue);
end;

end.
{MOD 1808008}
