unit AfcScb;

interface

uses
  IcTypes, IcTools, NexPath, NexGlob, AfcBas,
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, NexBtrTable, Forms;

type
  TAfcScb = class (TAfcBas)
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

function TAfcScb.ReadDocAdd:boolean;
begin
  Result := ReadData('SCB',cDocAdd);
end;

procedure TAfcScb.WriteDocAdd(pValue:boolean);
begin
  WriteData('SCB',cDocAdd,pValue);
end;

function TAfcScb.ReadDocDel:boolean;
begin
  Result := ReadData('SCB',cDocDel);
end;

procedure TAfcScb.WriteDocDel(pValue:boolean);
begin
  WriteData('SCB',cDocDel,pValue);
end;

function TAfcScb.ReadDocMod:boolean;
begin
  Result := ReadData('SCB',cDocMod);
end;

procedure TAfcScb.WriteDocMod(pValue:boolean);
begin
  WriteData('SCB',cDocMod,pValue);
end;

function TAfcScb.ReadDocDsc:boolean;
begin
  Result := ReadData('SCB',cDocDsc);
end;

procedure TAfcScb.WriteDocDsc(pValue:boolean);
begin
  WriteData('SCB',cDocDsc,pValue);
end;

function TAfcScb.ReadDocLck:boolean;
begin
  Result := ReadData('SCB',cDocLck);
end;

procedure TAfcScb.WriteDocLck(pValue:boolean);
begin
  WriteData('SCB',cDocLck,pValue);
end;

function TAfcScb.ReadDocUnl:boolean;
begin
  Result := ReadData('SCB',cDocUnl);
end;

procedure TAfcScb.WriteDocUnl(pValue:boolean);
begin
  WriteData('SCB',cDocUnl,pValue);
end;

function TAfcScb.ReadVatChg:boolean;
begin
  Result := ReadData('SCB',cVatChg);
end;

procedure TAfcScb.WriteVatChg(pValue:boolean);
begin
  WriteData('SCB',cVatChg,pValue);
end;

// ---------------------------- Zobraziù -----------------------------

function TAfcScb.ReadSitLst:boolean;
begin
  Result := ReadData('SCB',cSitLst);
end;

procedure TAfcScb.WriteSitLst(pValue:boolean);
begin
  WriteData('SCB',cSitLst,pValue);
end;

function TAfcScb.ReadScgStk:boolean;
begin
  Result := ReadData('SCB',cScgStk);
end;

procedure TAfcScb.WriteScgStk(pValue:boolean);
begin
  WriteData('SCB',cScgStk,pValue);
end;

// ---------------------------- TlaË ---------------------------------

function TAfcScb.ReadDocPrn:boolean;
begin
  Result := ReadData('SCB',cDocPrn);
end;

procedure TAfcScb.WriteDocPrn(pValue:boolean);
begin
  WriteData('SCB',cDocPrn,pValue);
end;

// ---------------------------- N·stroje -----------------------------

function TAfcScb.ReadDocFlt:boolean;
begin
  Result := ReadData('SCB',cDocFlt);
end;

procedure TAfcScb.WriteDocFlt(pValue:boolean);
begin
  WriteData('SCB',cDocFlt,pValue);
end;

function TAfcScb.ReadJudClm:boolean;
begin
  Result := ReadData('SCB',cJudClm);
end;

procedure TAfcScb.WriteJudClm(pValue:boolean);
begin
  WriteData('SCB',cJudClm,pValue);
end;

function TAfcScb.ReadSolClm:boolean;
begin
  Result := ReadData('SCB',cSolClm);
end;

procedure TAfcScb.WriteSolClm(pValue:boolean);
begin
  WriteData('SCB',cSolClm,pValue);
end;

function TAfcScb.ReadBegRep:boolean;
begin
  Result := ReadData('SCB',cBegRep);
end;

procedure TAfcScb.WriteBegRep(pValue:boolean);
begin
  WriteData('SCB',cBegRep,pValue);
end;

function TAfcScb.ReadEndRep:boolean;
begin
  Result := ReadData('SCB',cEndRep);
end;

procedure TAfcScb.WriteEndRep(pValue:boolean);
begin
  WriteData('SCB',cEndRep,pValue);
end;

function TAfcScb.ReadRetScg:boolean;
begin
  Result := ReadData('SCB',cRetScg);
end;

procedure TAfcScb.WriteRetScg(pValue:boolean);
begin
  WriteData('SCB',cRetScg,pValue);
end;

function TAfcScb.ReadClsScd:boolean;
begin
  Result := ReadData('SCB',cClsScd);
end;

procedure TAfcScb.WriteClsScd(pValue:boolean);
begin
  WriteData('SCB',cClsScd,pValue);
end;

function TAfcScb.ReadRepSnd:boolean;
begin
  Result := ReadData('SCB',cRepSnd);
end;

procedure TAfcScb.WriteRepSnd(pValue:boolean);
begin
  WriteData('SCB',cRepSnd,pValue);
end;

function TAfcScb.ReadRepRcv:boolean;
begin
  Result := ReadData('SCB',cRepRcv);
end;

procedure TAfcScb.WriteRepRcv(pValue:boolean);
begin
  WriteData('SCB',cRepRcv,pValue);
end;

function TAfcScb.ReadEndMsg:boolean;
begin
  Result := ReadData('SCB',cEndMsg);
end;

procedure TAfcScb.WriteEndMsg(pValue:boolean);
begin
  WriteData('SCB',cEndMsg,pValue);
end;

// ---------------------------- ⁄drûba -------------------------------

function TAfcScb.ReadDocClc:boolean;
begin
  Result := ReadData('SCB',cDocClc);
end;

procedure TAfcScb.WriteDocClc(pValue:boolean);
begin
  WriteData('SCB',cDocClc,pValue);
end;

// ---------------------------- Poloûky ------------------------------

function TAfcScb.ReadItmAdd:boolean;
begin
  Result := ReadData('SCB',cItmAdd);
end;

procedure TAfcScb.WriteItmAdd(pValue:boolean);
begin
  WriteData('SCB',cItmAdd,pValue);
end;

function TAfcScb.ReadItmDel:boolean;
begin
  Result := ReadData('SCB',cItmDel);
end;

procedure TAfcScb.WriteItmDel(pValue:boolean);
begin
  WriteData('SCB',cItmDel,pValue);
end;

function TAfcScb.ReadItmMod:boolean;
begin
  Result := ReadData('SCB',cItmMod);
end;

procedure TAfcScb.WriteItmMod(pValue:boolean);
begin
  WriteData('SCB',cItmMod,pValue);
end;

function TAfcScb.ReadPcgMod:boolean;
begin
  Result := ReadData('SCB',cPcgMod);
end;

procedure TAfcScb.WritePcgMod(pValue:boolean);
begin
  WriteData('SCB',cPcgMod,pValue);
end;

function TAfcScb.ReadPcsMod:boolean;
begin
  Result := ReadData('SCB',cPcsMod);
end;

procedure TAfcScb.WritePcsMod(pValue:boolean);
begin
  WriteData('SCB',cPcsMod,pValue);
end;

end.
