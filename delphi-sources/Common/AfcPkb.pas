unit AfcPkb;

interface

uses
  IcTypes, IcTools, NexPath, NexGlob, AfcBas,
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, NexBtrTable, Forms;

type
  TAfcPkb = class (TAfcBas)
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
    function ReadScgStk:boolean;    procedure WriteScgStk(pValue:boolean);
    // ---------------------------- TlaË ---------------------------------
    function ReadDocPrn:boolean;    procedure WriteDocPrn(pValue:boolean);
    // ---------------------------- N·stroje -----------------------------
    function ReadDocFlt:boolean;    procedure WriteDocFlt(pValue:boolean);
    function ReadJudClm:boolean;    procedure WriteJudClm(pValue:boolean);
    function ReadSolClm:boolean;    procedure WriteSolClm(pValue:boolean);
    function ReadBegRep:boolean;    procedure WriteBegRep(pValue:boolean);
    function ReadEndRep:boolean;    procedure WriteEndRep(pValue:boolean);
    function ReadRetScg:boolean;    procedure WriteRetScg(pValue:boolean);
    function ReadClsScd:boolean;    procedure WriteClsScd(pValue:boolean);
    function ReadRepSnd:boolean;    procedure WriteRepSnd(pValue:boolean);
    function ReadRepRcv:boolean;    procedure WriteRepRcv(pValue:boolean);
    function ReadEndMsg:boolean;    procedure WriteEndMsg(pValue:boolean);
    // ---------------------------- ⁄drûba -------------------------------
    function ReadDocClc:boolean;    procedure WriteDocClc(pValue:boolean);
    // ---------------------------- Poloûky ------------------------------
    function ReadItmAdd:boolean;    procedure WriteItmAdd(pValue:boolean);
    function ReadItmDel:boolean;    procedure WriteItmDel(pValue:boolean);
    function ReadItmMod:boolean;    procedure WriteItmMod(pValue:boolean);
    function ReadPcgMod:boolean;    procedure WritePcgMod(pValue:boolean);
    function ReadPcsMod:boolean;    procedure WritePcsMod(pValue:boolean);
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
    property ScgStk:boolean read ReadScgStk write WriteScgStk;
    // ---------------------------- TlaË ---------------------------------
    property DocPrn:boolean read ReadDocPrn write WriteDocPrn;
    // ---------------------------- N·stroje -----------------------------
    property DocFlt:boolean read ReadDocFlt write WriteDocFlt;
    property JudClm:boolean read ReadJudClm write WriteJudClm;
    property SolClm:boolean read ReadSolClm write WriteSolClm;
    property BegRep:boolean read ReadBegRep write WriteBegRep;
    property EndRep:boolean read ReadEndRep write WriteEndRep;
    property RetScg:boolean read ReadRetScg write WriteRetScg;
    property ClsScd:boolean read ReadClsScd write WriteClsScd;
    property RepSnd:boolean read ReadRepSnd write WriteRepSnd;
    property RepRcv:boolean read ReadRepRcv write WriteRepRcv;
    property EndMsg:boolean read ReadEndMsg write WriteEndMsg;
    // ---------------------------- ⁄drûba -------------------------------
    property DocClc:boolean read ReadDocClc write WriteDocClc;
    // ---------------------------- Poloûky ------------------------------
    property ItmAdd:boolean read ReadItmAdd write WriteItmAdd;
    property ItmDel:boolean read ReadItmDel write WriteItmDel;
    property ItmMod:boolean read ReadItmMod write WriteItmMod;
    property PcgMod:boolean read ReadPcgMod write WritePcgMod;
    property PcsMod:boolean read ReadPcsMod write WritePcsMod;
  end;

implementation

const
// Upravy ------  Zobrazit ----  Tlac --------  N·stroje ----  Udrzba ------  Polozky -----
   cDocAdd = 1;   cSitLst = 20;  cDocPrn = 40;  cDocFlt = 60;  cDocClc = 90;  cItmAdd = 150;
   cDocDel = 2;   cBokLst = 21;                 cJudClm = 61;                 cItmDel = 151;
   cDocMod = 3;   cScgStk = 22;                 cSolClm = 62;                 cItmMod = 152;
   cDocDsc = 4;                                 cBegRep = 63;                 cPcgMod = 153;
   cDocRnd = 5;                                 cEndRep = 64;                 cPcsMod = 154;
   cDocLck = 6;                                 cRetScg = 65;
   cDocUnl = 8;                                 cClsScd = 66;
   cVatChg = 9;                                 cRepSnd = 67;
                                                cRepRcv = 68;
                                                cEndMsg = 69;
// **************************************** OBJECT *****************************************

// ---------------------------- ⁄pravy -------------------------------

function TAfcPkb.ReadDocAdd:boolean;
begin
  Result := ReadData('PKB',cDocAdd);
end;

procedure TAfcPkb.WriteDocAdd(pValue:boolean);
begin
  WriteData('PKB',cDocAdd,pValue);
end;

function TAfcPkb.ReadDocDel:boolean;
begin
  Result := ReadData('PKB',cDocDel);
end;

procedure TAfcPkb.WriteDocDel(pValue:boolean);
begin
  WriteData('PKB',cDocDel,pValue);
end;

function TAfcPkb.ReadDocMod:boolean;
begin
  Result := ReadData('PKB',cDocMod);
end;

procedure TAfcPkb.WriteDocMod(pValue:boolean);
begin
  WriteData('PKB',cDocMod,pValue);
end;

function TAfcPkb.ReadDocDsc:boolean;
begin
  Result := ReadData('PKB',cDocDsc);
end;

procedure TAfcPkb.WriteDocDsc(pValue:boolean);
begin
  WriteData('PKB',cDocDsc,pValue);
end;

function TAfcPkb.ReadDocLck:boolean;
begin
  Result := ReadData('PKB',cDocLck);
end;

procedure TAfcPkb.WriteDocLck(pValue:boolean);
begin
  WriteData('PKB',cDocLck,pValue);
end;

function TAfcPkb.ReadDocUnl:boolean;
begin
  Result := ReadData('PKB',cDocUnl);
end;

procedure TAfcPkb.WriteDocUnl(pValue:boolean);
begin
  WriteData('PKB',cDocUnl,pValue);
end;

function TAfcPkb.ReadVatChg:boolean;
begin
  Result := ReadData('PKB',cVatChg);
end;

procedure TAfcPkb.WriteVatChg(pValue:boolean);
begin
  WriteData('PKB',cVatChg,pValue);
end;

// ---------------------------- Zobraziù -----------------------------

function TAfcPkb.ReadSitLst:boolean;
begin
  Result := ReadData('PKB',cSitLst);
end;

procedure TAfcPkb.WriteSitLst(pValue:boolean);
begin
  WriteData('PKB',cSitLst,pValue);
end;

function TAfcPkb.ReadScgStk:boolean;
begin
  Result := ReadData('PKB',cScgStk);
end;

procedure TAfcPkb.WriteScgStk(pValue:boolean);
begin
  WriteData('PKB',cScgStk,pValue);
end;

// ---------------------------- TlaË ---------------------------------

function TAfcPkb.ReadDocPrn:boolean;
begin
  Result := ReadData('PKB',cDocPrn);
end;

procedure TAfcPkb.WriteDocPrn(pValue:boolean);
begin
  WriteData('PKB',cDocPrn,pValue);
end;

// ---------------------------- N·stroje -----------------------------

function TAfcPkb.ReadDocFlt:boolean;
begin
  Result := ReadData('PKB',cDocFlt);
end;

procedure TAfcPkb.WriteDocFlt(pValue:boolean);
begin
  WriteData('PKB',cDocFlt,pValue);
end;

function TAfcPkb.ReadJudClm:boolean;
begin
  Result := ReadData('PKB',cJudClm);
end;

procedure TAfcPkb.WriteJudClm(pValue:boolean);
begin
  WriteData('PKB',cJudClm,pValue);
end;

function TAfcPkb.ReadSolClm:boolean;
begin
  Result := ReadData('PKB',cSolClm);
end;

procedure TAfcPkb.WriteSolClm(pValue:boolean);
begin
  WriteData('PKB',cSolClm,pValue);
end;

function TAfcPkb.ReadBegRep:boolean;
begin
  Result := ReadData('PKB',cBegRep);
end;

procedure TAfcPkb.WriteBegRep(pValue:boolean);
begin
  WriteData('PKB',cBegRep,pValue);
end;

function TAfcPkb.ReadEndRep:boolean;
begin
  Result := ReadData('PKB',cEndRep);
end;

procedure TAfcPkb.WriteEndRep(pValue:boolean);
begin
  WriteData('PKB',cEndRep,pValue);
end;

function TAfcPkb.ReadRetScg:boolean;
begin
  Result := ReadData('PKB',cRetScg);
end;

procedure TAfcPkb.WriteRetScg(pValue:boolean);
begin
  WriteData('PKB',cRetScg,pValue);
end;

function TAfcPkb.ReadClsScd:boolean;
begin
  Result := ReadData('PKB',cClsScd);
end;

procedure TAfcPkb.WriteClsScd(pValue:boolean);
begin
  WriteData('PKB',cClsScd,pValue);
end;

function TAfcPkb.ReadRepSnd:boolean;
begin
  Result := ReadData('PKB',cRepSnd);
end;

procedure TAfcPkb.WriteRepSnd(pValue:boolean);
begin
  WriteData('PKB',cRepSnd,pValue);
end;

function TAfcPkb.ReadRepRcv:boolean;
begin
  Result := ReadData('PKB',cRepRcv);
end;

procedure TAfcPkb.WriteRepRcv(pValue:boolean);
begin
  WriteData('PKB',cRepRcv,pValue);
end;

function TAfcPkb.ReadEndMsg:boolean;
begin
  Result := ReadData('PKB',cEndMsg);
end;

procedure TAfcPkb.WriteEndMsg(pValue:boolean);
begin
  WriteData('PKB',cEndMsg,pValue);
end;

// ---------------------------- ⁄drûba -------------------------------

function TAfcPkb.ReadDocClc:boolean;
begin
  Result := ReadData('PKB',cDocClc);
end;

procedure TAfcPkb.WriteDocClc(pValue:boolean);
begin
  WriteData('PKB',cDocClc,pValue);
end;

// ---------------------------- Poloûky ------------------------------

function TAfcPkb.ReadItmAdd:boolean;
begin
  Result := ReadData('PKB',cItmAdd);
end;

procedure TAfcPkb.WriteItmAdd(pValue:boolean);
begin
  WriteData('PKB',cItmAdd,pValue);
end;

function TAfcPkb.ReadItmDel:boolean;
begin
  Result := ReadData('PKB',cItmDel);
end;

procedure TAfcPkb.WriteItmDel(pValue:boolean);
begin
  WriteData('PKB',cItmDel,pValue);
end;

function TAfcPkb.ReadItmMod:boolean;
begin
  Result := ReadData('PKB',cItmMod);
end;

procedure TAfcPkb.WriteItmMod(pValue:boolean);
begin
  WriteData('PKB',cItmMod,pValue);
end;

function TAfcPkb.ReadPcgMod:boolean;
begin
  Result := ReadData('PKB',cPcgMod);
end;

procedure TAfcPkb.WritePcgMod(pValue:boolean);
begin
  WriteData('PKB',cPcgMod,pValue);
end;

function TAfcPkb.ReadPcsMod:boolean;
begin
  Result := ReadData('PKB',cPcsMod);
end;

procedure TAfcPkb.WritePcsMod(pValue:boolean);
begin
  WriteData('PKB',cPcsMod,pValue);
end;

end.
