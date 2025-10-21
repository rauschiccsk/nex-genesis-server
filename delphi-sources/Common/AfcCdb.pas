unit AfcCdb;

interface

uses
  IcTypes, IcTools, NexPath, NexGlob, AfcBas,
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, NexBtrTable, Forms;

type
  TAfcCdb = class (TAfcBas)
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

function TAfcCdb.ReadDocAdd:boolean;
begin
  Result := ReadData('CDB',cDocAdd);
end;

procedure TAfcCdb.WriteDocAdd(pValue:boolean);
begin
  WriteData('CDB',cDocAdd,pValue);
end;

function TAfcCdb.ReadDocDel:boolean;
begin
  Result := ReadData('CDB',cDocDel);
end;

procedure TAfcCdb.WriteDocDel(pValue:boolean);
begin
  WriteData('CDB',cDocDel,pValue);
end;

function TAfcCdb.ReadDocMod:boolean;
begin
  Result := ReadData('CDB',cDocMod);
end;

procedure TAfcCdb.WriteDocMod(pValue:boolean);
begin
  WriteData('CDB',cDocMod,pValue);
end;

function TAfcCdb.ReadDocDsc:boolean;
begin
  Result := ReadData('CDB',cDocDsc);
end;

procedure TAfcCdb.WriteDocDsc(pValue:boolean);
begin
  WriteData('CDB',cDocDsc,pValue);
end;

function TAfcCdb.ReadDocLck:boolean;
begin
  Result := ReadData('CDB',cDocLck);
end;

procedure TAfcCdb.WriteDocLck(pValue:boolean);
begin
  WriteData('CDB',cDocLck,pValue);
end;

function TAfcCdb.ReadDocUnl:boolean;
begin
  Result := ReadData('CDB',cDocUnl);
end;

procedure TAfcCdb.WriteDocUnl(pValue:boolean);
begin
  WriteData('CDB',cDocUnl,pValue);
end;

function TAfcCdb.ReadVatChg:boolean;
begin
  Result := ReadData('CDB',cVatChg);
end;

procedure TAfcCdb.WriteVatChg(pValue:boolean);
begin
  WriteData('CDB',cVatChg,pValue);
end;

// ---------------------------- Zobraziù -----------------------------

function TAfcCdb.ReadSitLst:boolean;
begin
  Result := ReadData('CDB',cSitLst);
end;

procedure TAfcCdb.WriteSitLst(pValue:boolean);
begin
  WriteData('CDB',cSitLst,pValue);
end;

function TAfcCdb.ReadSumLst: boolean;
begin
  Result := ReadData('CDB',cSumLst);
end;

procedure TAfcCdb.WriteSumLst(pValue: boolean);
begin
  WriteData('CDB',cSumLst,pValue);
end;

// ---------------------------- TlaË ---------------------------------

function TAfcCdb.ReadDocPrn:boolean;
begin
  Result := ReadData('CDB',cDocPrn);
end;

procedure TAfcCdb.WriteDocPrn(pValue:boolean);
begin
  WriteData('CDB',cDocPrn,pValue);
end;

// ---------------------------- N·stroje -----------------------------

function TAfcCdb.ReadDocFlt:boolean;
begin
  Result := ReadData('CDB',cDocFlt);
end;

procedure TAfcCdb.WriteDocFlt(pValue:boolean);
begin
  WriteData('CDB',cDocFlt,pValue);
end;

function TAfcCdb.ReadOitSnd: boolean;
begin
  Result := ReadData('CDB',cOitSnd);
end;

procedure TAfcCdb.WriteOitSnd(pValue: boolean);
begin
  WriteData('CDB',cOitSnd,pValue);
end;

function TAfcCdb.ReadDocStp: boolean;
begin
  Result := ReadData('CDB',cDocStp);
end;

procedure TAfcCdb.WriteDocStp(pValue: boolean);
begin
  WriteData('CDB',cDocStp,pValue);
end;

// ---------------------------- ⁄drûba -------------------------------

function TAfcCdb.ReadMntFnc:boolean;
begin
  Result := ReadData('CDB',cMntFnc);
end;

procedure TAfcCdb.WriteMntFnc(pValue:boolean);
begin
  WriteData('CDB',cMntFnc,pValue);
end;

// ---------------------------- Servis -------------------------------

function TAfcCdb.ReadSerFnc: boolean;
begin
  Result := ReadData('CDB',cSerFnc);
end;

procedure TAfcCdb.WriteSerFnc(pValue: boolean);
begin
  WriteData('CDB',cSerFnc,pValue);
end;

// ---------------------------- Poloûky ------------------------------

function TAfcCdb.ReadItmAdd:boolean;
begin
  Result := ReadData('CDB',cItmAdd);
end;

procedure TAfcCdb.WriteItmAdd(pValue:boolean);
begin
  WriteData('CDB',cItmAdd,pValue);
end;

function TAfcCdb.ReadItmDel:boolean;
begin
  Result := ReadData('CDB',cItmDel);
end;

procedure TAfcCdb.WriteItmDel(pValue:boolean);
begin
  WriteData('CDB',cItmDel,pValue);
end;

function TAfcCdb.ReadItmMod:boolean;
begin
  Result := ReadData('CDB',cItmMod);
end;

procedure TAfcCdb.WriteItmMod(pValue:boolean);
begin
  WriteData('CDB',cItmMod,pValue);
end;

end.

