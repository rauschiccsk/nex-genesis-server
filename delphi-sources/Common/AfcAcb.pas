unit AfcAcb;

interface

uses
  IcTypes, IcTools, NexPath, NexGlob, AfcBas,
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, NexBtrTable, Forms;

type
  TAfcAcb = class (TAfcBas)
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
    function ReadOitSnd: boolean;   procedure WriteOitSnd(pValue: boolean);
    // ---------------------------- ⁄drûba -------------------------------
    function ReadMntFnc:boolean;    procedure WriteMntFnc(pValue:boolean);
    // ---------------------------- Servis -------------------------------
    function ReadSerFnc:boolean;    procedure WriteSerFnc(pValue:boolean);
    // ---------------------------- Poloûky ------------------------------
    function ReadItmAdd:boolean;    procedure WriteItmAdd(pValue:boolean);
    function ReadItmDel:boolean;    procedure WriteItmDel(pValue:boolean);
    function ReadItmMod:boolean;    procedure WriteItmMod(pValue:boolean);
    function ReadDocStp: boolean;   procedure WriteDocStp(pValue: boolean);
    function ReadSumLst: boolean;   procedure WriteSumLst(pValue: boolean);
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
    property SumLst:boolean read ReadSumLst write WriteSumLst;
    // ---------------------------- TlaË ---------------------------------
    property DocPrn:boolean read ReadDocPrn write WriteDocPrn;
    // ---------------------------- N·stroje -----------------------------
    property DocFlt:boolean read ReadDocFlt write WriteDocFlt;
    property DocStp:boolean read ReadDocStp write WriteDocStp;
    property OitSnd:boolean read ReadOitSnd write WriteOitSnd;
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
// Upravy ------  Zobrazit ----  Tlac --------  N·stroje ----  Udrzba ------  Udrzba ------  Polozky -----
   cDocAdd = 1;   cSitLst = 20;  cDocPrn = 40;  cDocFlt = 60;  cMntFnc = 100; cSerFnc = 120; cItmAdd = 150;
   cDocDel = 2;   cBokLst = 21;                 cDocStp = 61;                                cItmDel = 151;
   cDocMod = 3;   cSumLst = 22;                 cOitSnd = 62;                                cItmMod = 152;
   cDocDsc = 4;
   cDocRnd = 5;
   cDocLck = 6;
   cDocUnl = 8;                                 
   cVatChg = 9;                                 
                                                

// **************************************** OBJECT *****************************************

// ---------------------------- ⁄pravy -------------------------------

function TAfcAcb.ReadDocAdd:boolean;
begin
  Result := ReadData('ACB',cDocAdd);
end;

procedure TAfcAcb.WriteDocAdd(pValue:boolean);
begin
  WriteData('ACB',cDocAdd,pValue);
end;

function TAfcAcb.ReadDocDel:boolean;
begin
  Result := ReadData('ACB',cDocDel);
end;

procedure TAfcAcb.WriteDocDel(pValue:boolean);
begin
  WriteData('ACB',cDocDel,pValue);
end;

function TAfcAcb.ReadDocMod:boolean;
begin
  Result := ReadData('ACB',cDocMod);
end;

procedure TAfcAcb.WriteDocMod(pValue:boolean);
begin
  WriteData('ACB',cDocMod,pValue);
end;

function TAfcAcb.ReadDocDsc:boolean;
begin
  Result := ReadData('ACB',cDocDsc);
end;

procedure TAfcAcb.WriteDocDsc(pValue:boolean);
begin
  WriteData('ACB',cDocDsc,pValue);
end;

function TAfcAcb.ReadDocLck:boolean;
begin
  Result := ReadData('ACB',cDocLck);
end;

procedure TAfcAcb.WriteDocLck(pValue:boolean);
begin
  WriteData('ACB',cDocLck,pValue);
end;

function TAfcAcb.ReadDocUnl:boolean;
begin
  Result := ReadData('ACB',cDocUnl);
end;

procedure TAfcAcb.WriteDocUnl(pValue:boolean);
begin
  WriteData('ACB',cDocUnl,pValue);
end;

function TAfcAcb.ReadVatChg:boolean;
begin
  Result := ReadData('ACB',cVatChg);
end;

procedure TAfcAcb.WriteVatChg(pValue:boolean);
begin
  WriteData('ACB',cVatChg,pValue);
end;

// ---------------------------- Zobraziù -----------------------------

function TAfcAcb.ReadSitLst:boolean;
begin
  Result := ReadData('ACB',cSitLst);
end;

procedure TAfcAcb.WriteSitLst(pValue:boolean);
begin
  WriteData('ACB',cSitLst,pValue);
end;

function TAfcAcb.ReadSumLst: boolean;
begin
  Result := ReadData('ACB',cSumLst);
end;

procedure TAfcAcb.WriteSumLst(pValue: boolean);
begin
  WriteData('ACB',cSumLst,pValue);
end;

// ---------------------------- TlaË ---------------------------------

function TAfcAcb.ReadDocPrn:boolean;
begin
  Result := ReadData('ACB',cDocPrn);
end;

procedure TAfcAcb.WriteDocPrn(pValue:boolean);
begin
  WriteData('ACB',cDocPrn,pValue);
end;

// ---------------------------- N·stroje -----------------------------

function TAfcAcb.ReadDocFlt:boolean;
begin
  Result := ReadData('ACB',cDocFlt);
end;

procedure TAfcAcb.WriteDocFlt(pValue:boolean);
begin
  WriteData('ACB',cDocFlt,pValue);
end;

function TAfcAcb.ReadOitSnd: boolean;
begin
  Result := ReadData('ACB',cOitSnd);
end;

procedure TAfcAcb.WriteOitSnd(pValue: boolean);
begin
  WriteData('ACB',cOitSnd,pValue);
end;

function TAfcAcb.ReadDocStp: boolean;
begin
  Result := ReadData('ACB',cDocStp);
end;

procedure TAfcAcb.WriteDocStp(pValue: boolean);
begin
  WriteData('ACB',cDocStp,pValue);
end;

// ---------------------------- ⁄drûba -------------------------------

function TAfcAcb.ReadMntFnc:boolean;
begin
  Result := ReadData('ACB',cMntFnc);
end;

procedure TAfcAcb.WriteMntFnc(pValue:boolean);
begin
  WriteData('ACB',cMntFnc,pValue);
end;

// ---------------------------- Servis -------------------------------

function TAfcAcb.ReadSerFnc: boolean;
begin
  Result := ReadData('ACB',cSerFnc);
end;

procedure TAfcAcb.WriteSerFnc(pValue: boolean);
begin
  WriteData('ACB',cSerFnc,pValue);
end;

// ---------------------------- Poloûky ------------------------------

function TAfcAcb.ReadItmAdd:boolean;
begin
  Result := ReadData('ACB',cItmAdd);
end;

procedure TAfcAcb.WriteItmAdd(pValue:boolean);
begin
  WriteData('ACB',cItmAdd,pValue);
end;

function TAfcAcb.ReadItmDel:boolean;
begin
  Result := ReadData('ACB',cItmDel);
end;

procedure TAfcAcb.WriteItmDel(pValue:boolean);
begin
  WriteData('ACB',cItmDel,pValue);
end;

function TAfcAcb.ReadItmMod:boolean;
begin
  Result := ReadData('ACB',cItmMod);
end;

procedure TAfcAcb.WriteItmMod(pValue:boolean);
begin
  WriteData('ACB',cItmMod,pValue);
end;

end.

