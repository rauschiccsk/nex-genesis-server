unit AfcDmb;

interface

uses
  IcTypes, IcTools, NexPath, NexGlob, AfcBas,
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, NexBtrTable, Forms;

type
  TAfcDmb = class (TAfcBas)
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

function TAfcDmb.ReadDocAdd:boolean;
begin
  Result := ReadData('DMB',cDocAdd);
end;

procedure TAfcDmb.WriteDocAdd(pValue:boolean);
begin
  WriteData('DMB',cDocAdd,pValue);
end;

function TAfcDmb.ReadDocDel:boolean;
begin
  Result := ReadData('DMB',cDocDel);
end;

procedure TAfcDmb.WriteDocDel(pValue:boolean);
begin
  WriteData('DMB',cDocDel,pValue);
end;

function TAfcDmb.ReadDocMod:boolean;
begin
  Result := ReadData('DMB',cDocMod);
end;

procedure TAfcDmb.WriteDocMod(pValue:boolean);
begin
  WriteData('DMB',cDocMod,pValue);
end;

function TAfcDmb.ReadDocDsc:boolean;
begin
  Result := ReadData('DMB',cDocDsc);
end;

procedure TAfcDmb.WriteDocDsc(pValue:boolean);
begin
  WriteData('DMB',cDocDsc,pValue);
end;

function TAfcDmb.ReadDocLck:boolean;
begin
  Result := ReadData('DMB',cDocLck);
end;

procedure TAfcDmb.WriteDocLck(pValue:boolean);
begin
  WriteData('DMB',cDocLck,pValue);
end;

function TAfcDmb.ReadDocUnl:boolean;
begin
  Result := ReadData('DMB',cDocUnl);
end;

procedure TAfcDmb.WriteDocUnl(pValue:boolean);
begin
  WriteData('DMB',cDocUnl,pValue);
end;

function TAfcDmb.ReadVatChg:boolean;
begin
  Result := ReadData('DMB',cVatChg);
end;

procedure TAfcDmb.WriteVatChg(pValue:boolean);
begin
  WriteData('DMB',cVatChg,pValue);
end;

// ---------------------------- Zobraziù -----------------------------

function TAfcDmb.ReadSitLst:boolean;
begin
  Result := ReadData('DMB',cSitLst);
end;

procedure TAfcDmb.WriteSitLst(pValue:boolean);
begin
  WriteData('DMB',cSitLst,pValue);
end;

function TAfcDmb.ReadScgStk:boolean;
begin
  Result := ReadData('DMB',cScgStk);
end;

procedure TAfcDmb.WriteScgStk(pValue:boolean);
begin
  WriteData('DMB',cScgStk,pValue);
end;

// ---------------------------- TlaË ---------------------------------

function TAfcDmb.ReadDocPrn:boolean;
begin
  Result := ReadData('DMB',cDocPrn);
end;

procedure TAfcDmb.WriteDocPrn(pValue:boolean);
begin
  WriteData('DMB',cDocPrn,pValue);
end;

// ---------------------------- N·stroje -----------------------------

function TAfcDmb.ReadDocFlt:boolean;
begin
  Result := ReadData('DMB',cDocFlt);
end;

procedure TAfcDmb.WriteDocFlt(pValue:boolean);
begin
  WriteData('DMB',cDocFlt,pValue);
end;

function TAfcDmb.ReadJudClm:boolean;
begin
  Result := ReadData('DMB',cJudClm);
end;

procedure TAfcDmb.WriteJudClm(pValue:boolean);
begin
  WriteData('DMB',cJudClm,pValue);
end;

function TAfcDmb.ReadSolClm:boolean;
begin
  Result := ReadData('DMB',cSolClm);
end;

procedure TAfcDmb.WriteSolClm(pValue:boolean);
begin
  WriteData('DMB',cSolClm,pValue);
end;

function TAfcDmb.ReadBegRep:boolean;
begin
  Result := ReadData('DMB',cBegRep);
end;

procedure TAfcDmb.WriteBegRep(pValue:boolean);
begin
  WriteData('DMB',cBegRep,pValue);
end;

function TAfcDmb.ReadEndRep:boolean;
begin
  Result := ReadData('DMB',cEndRep);
end;

procedure TAfcDmb.WriteEndRep(pValue:boolean);
begin
  WriteData('DMB',cEndRep,pValue);
end;

function TAfcDmb.ReadRetScg:boolean;
begin
  Result := ReadData('DMB',cRetScg);
end;

procedure TAfcDmb.WriteRetScg(pValue:boolean);
begin
  WriteData('DMB',cRetScg,pValue);
end;

function TAfcDmb.ReadClsScd:boolean;
begin
  Result := ReadData('DMB',cClsScd);
end;

procedure TAfcDmb.WriteClsScd(pValue:boolean);
begin
  WriteData('DMB',cClsScd,pValue);
end;

function TAfcDmb.ReadRepSnd:boolean;
begin
  Result := ReadData('DMB',cRepSnd);
end;

procedure TAfcDmb.WriteRepSnd(pValue:boolean);
begin
  WriteData('DMB',cRepSnd,pValue);
end;

function TAfcDmb.ReadRepRcv:boolean;
begin
  Result := ReadData('DMB',cRepRcv);
end;

procedure TAfcDmb.WriteRepRcv(pValue:boolean);
begin
  WriteData('DMB',cRepRcv,pValue);
end;

function TAfcDmb.ReadEndMsg:boolean;
begin
  Result := ReadData('DMB',cEndMsg);
end;

procedure TAfcDmb.WriteEndMsg(pValue:boolean);
begin
  WriteData('DMB',cEndMsg,pValue);
end;

// ---------------------------- ⁄drûba -------------------------------

function TAfcDmb.ReadDocClc:boolean;
begin
  Result := ReadData('DMB',cDocClc);
end;

procedure TAfcDmb.WriteDocClc(pValue:boolean);
begin
  WriteData('DMB',cDocClc,pValue);
end;

// ---------------------------- Poloûky ------------------------------

function TAfcDmb.ReadItmAdd:boolean;
begin
  Result := ReadData('DMB',cItmAdd);
end;

procedure TAfcDmb.WriteItmAdd(pValue:boolean);
begin
  WriteData('DMB',cItmAdd,pValue);
end;

function TAfcDmb.ReadItmDel:boolean;
begin
  Result := ReadData('DMB',cItmDel);
end;

procedure TAfcDmb.WriteItmDel(pValue:boolean);
begin
  WriteData('DMB',cItmDel,pValue);
end;

function TAfcDmb.ReadItmMod:boolean;
begin
  Result := ReadData('DMB',cItmMod);
end;

procedure TAfcDmb.WriteItmMod(pValue:boolean);
begin
  WriteData('DMB',cItmMod,pValue);
end;

function TAfcDmb.ReadPcgMod:boolean;
begin
  Result := ReadData('DMB',cPcgMod);
end;

procedure TAfcDmb.WritePcgMod(pValue:boolean);
begin
  WriteData('DMB',cPcgMod,pValue);
end;

function TAfcDmb.ReadPcsMod:boolean;
begin
  Result := ReadData('DMB',cPcsMod);
end;

procedure TAfcDmb.WritePcsMod(pValue:boolean);
begin
  WriteData('DMB',cPcsMod,pValue);
end;

end.
