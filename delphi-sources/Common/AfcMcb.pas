unit AfcMcb;

interface

uses
  IcTypes, IcTools, NexPath, NexGlob, AfcBas,
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, NexBtrTable, Forms;

type
  TAfcMcb = class (TAfcBas)
  private
    // ---------------------------- ⁄pravy -------------------------------
    function ReadDocAdd:boolean;    procedure WriteDocAdd(pValue:boolean);
    function ReadDocDel:boolean;    procedure WriteDocDel(pValue:boolean);
    function ReadDocDsc:boolean;    procedure WriteDocDsc(pValue:boolean);
    function ReadDocLck:boolean;    procedure WriteDocLck(pValue:boolean);
    function ReadDocUnl:boolean;    procedure WriteDocUnl(pValue:boolean);
    function ReadDocRnd:boolean;    procedure WriteDocRnd(pValue:boolean);
    function ReadDocMod:boolean;    procedure WriteDocMod(pValue:boolean);
    function ReadVatChg:boolean;    procedure WriteVatChg(pValue:boolean);
    // ---------------------------- Zobraziù -----------------------------
    function ReadSitLst:boolean;    procedure WriteSitLst(pValue:boolean);
    function ReadPayLst:boolean;    procedure WritePayLst(pValue:boolean);
    function ReadBokPrp:boolean;    procedure WriteBokPrp(pValue:boolean);
    function ReadAttLst:boolean;    procedure WriteAttLst(pValue:boolean);
    // ---------------------------- TlaË ---------------------------------
    function ReadPrnMcd:boolean;    procedure WritePrnMcd(pValue:boolean);
    function ReadPrnMpd:boolean;    procedure WritePrnMpd(pValue:boolean);
    // ---------------------------- N·stroje -----------------------------
    function ReadTcdGen:boolean;    procedure WriteTcdGen(pValue:boolean);
    function ReadOcdGen:boolean;    procedure WriteOcdGen(pValue:boolean);
    function ReadDocCpy:boolean;    procedure WriteDocCpy(pValue:boolean);
    function ReadMciClc:boolean;    procedure WriteMciClc(pValue:boolean);
    function ReadCpyAgm:boolean;    procedure WriteCpyAgm(pValue:boolean);
    // ---------------------------- ⁄drûba -------------------------------
    function ReadDocClc:boolean;    procedure WriteDocClc(pValue:boolean);
    function ReadPayClc:boolean;    procedure WritePayClc(pValue:boolean);
    // ---------------------------- Poloûky ------------------------------
    function ReadItmAdd:boolean;    procedure WriteItmAdd(pValue:boolean);
    function ReadItmDel:boolean;    procedure WriteItmDel(pValue:boolean);
    function ReadItmMod:boolean;    procedure WriteItmMod(pValue:boolean);
    function ReadCphEdi:boolean;    procedure WriteCphEdi(pValue:boolean);
    // ---------------------------- Prilohy ------------------------------
    function ReadAttAdd:boolean;    procedure WriteAttAdd(pValue:boolean);
    function ReadAttDel:boolean;    procedure WriteAttDel(pValue:boolean);
    function ReadAttMod:boolean;    procedure WriteAttMod(pValue:boolean);
    function ReadAttShw:boolean;    procedure WriteAttShw(pValue:boolean);
    function ReadAttFid:boolean;    procedure WriteAttFid(pValue:boolean);

  public
    // ---------------------- ⁄pravy -------------------------
    property DocAdd:boolean read ReadDocAdd write WriteDocAdd;
    property DocDel:boolean read ReadDocDel write WriteDocDel;
    property DocDsc:boolean read ReadDocDsc write WriteDocDsc;
    property DocLck:boolean read ReadDocLck write WriteDocLck;
    property DocUnl:boolean read ReadDocUnl write WriteDocUnl;
    property DocRnd:boolean read ReadDocRnd write WriteDocRnd;
    property DocMod:boolean read ReadDocMod write WriteDocMod;
    property VatChg:boolean read ReadVatChg write WriteVatChg;
    // ---------------------- Zobraziù -----------------------
    property SitLst:boolean read ReadSitLst write WriteSitLst;
    property PayLst:boolean read ReadPayLst write WritePayLst;
    property BokPrp:boolean read ReadBokPrp write WriteBokPrp;
    property AttLst:boolean read ReadAttLst write WriteAttLst;
    // ---------------------- TlaË ---------------------------
    property PrnMcd:boolean read ReadPrnMcd write WritePrnMcd;
    property PrnMpd:boolean read ReadPrnMpd write WritePrnMpd;
    // ---------------------- N·stroje -----------------------
    property TcdGen:boolean read ReadTcdGen write WriteTcdGen;
    property OcdGen:boolean read ReadOcdGen write WriteOcdGen;
    property DocCpy:boolean read ReadDocCpy write WriteDocCpy;
    property MciClc:boolean read ReadMciClc write WriteMciClc;
    property CpyAgm:boolean read ReadCpyAgm write WriteCpyAgm;
    // ---------------------- ⁄drûba -------------------------
    property DocClc:boolean read ReadDocClc write WriteDocClc;
    property PayClc:boolean read ReadPayClc write WritePayClc;
    // ---------------------- Poloûky ------------------------
    property ItmAdd:boolean read ReadItmAdd write WriteItmAdd;
    property ItmDel:boolean read ReadItmDel write WriteItmDel;
    property ItmMod:boolean read ReadItmMod write WriteItmMod;
    property CphEdi:boolean read ReadCphEdi write WriteCphEdi;
    // ---------------------- Prilohy ------------------------
    property AttAdd:boolean read ReadAttAdd write WriteAttAdd;
    property AttDel:boolean read ReadAttDel write WriteAttDel;
    property AttMod:boolean read ReadAttMod write WriteAttMod;
    property AttShw:boolean read ReadAttShw write WriteAttShw;
    property AttFid:boolean read ReadAttFid write WriteAttFid;
  end;

implementation

const
// Upravy ---  Zobrazit --  Tlac ------  N·stroje --  Udrzba ----  Polozky ---  Prilohy ---
   cDocAdd=1;  cSitLst=9;   cPrnMcd=11;  cTcdGen=13;  cDocClc=15;  cItmAdd=16;  cAttAdd=31;
   cDocDel=2;  cBokPrp=10;  cPrnMpd=12;  cOcdGen=14;  cPayClc=21;  cItmDel=17;  cAttDel=32;
   cDocDsc=3;  cPayLst=20;               cDocCpy=15;               cItmMod=18;  cAttMod=33;
   cDocLck=4;  cAttLst=23;               cMciClc=22;               cCphEdi=19;  cAttShw=34;
   cDocUnl=5;                            cCpyAgm=23;                            cAttFid=35;
   cDocRnd=6;
   cDocMod=7;
   cVatChg=8;
// **************************************** OBJECT *****************************************

// ---------------------------- ⁄pravy -------------------------------

function TAfcMcb.ReadDocAdd:boolean;
begin
  Result := ReadData('MCB',cDocAdd);
end;

procedure TAfcMcb.WriteDocAdd(pValue:boolean);
begin
  WriteData('MCB',cDocAdd,pValue);
end;

function TAfcMcb.ReadDocDel:boolean;
begin
  Result := ReadData('MCB',cDocDel);
end;

procedure TAfcMcb.WriteDocDel(pValue:boolean);
begin
  WriteData('MCB',cDocDel,pValue);
end;

function TAfcMcb.ReadDocDsc:boolean;
begin
  Result := ReadData('MCB',cDocDsc);
end;

procedure TAfcMcb.WriteDocDsc(pValue:boolean);
begin
  WriteData('MCB',cDocDsc,pValue);
end;

function TAfcMcb.ReadDocLck:boolean;
begin
  Result := ReadData('MCB',cDocLck);
end;

procedure TAfcMcb.WriteDocLck(pValue:boolean);
begin
  WriteData('MCB',cDocLck,pValue);
end;

function TAfcMcb.ReadDocUnl:boolean;
begin
  Result := ReadData('MCB',cDocUnl);
end;

procedure TAfcMcb.WriteDocUnl(pValue:boolean);
begin
  WriteData('MCB',cDocUnl,pValue);
end;

function TAfcMcb.ReadDocRnd:boolean;
begin
  Result := ReadData('MCB',cDocRnd);
end;

procedure TAfcMcb.WriteDocRnd(pValue:boolean);
begin
  WriteData('MCB',cDocRnd,pValue);
end;

function TAfcMcb.ReadDocMod:boolean;
begin
  Result := ReadData('MCB',cDocMod);
end;

procedure TAfcMcb.WriteDocMod(pValue:boolean);
begin
  WriteData('MCB',cDocMod,pValue);
end;

function TAfcMcb.ReadVatChg:boolean;
begin
  Result := ReadData('MCB',cVatChg);
end;

procedure TAfcMcb.WriteVatChg(pValue:boolean);
begin
  WriteData('MCB',cVatChg,pValue);
end;

// ---------------------------- Zobraziù -----------------------------

function TAfcMcb.ReadSitLst:boolean;
begin
  Result := ReadData('MCB',cSitLst);
end;

procedure TAfcMcb.WriteSitLst(pValue:boolean);
begin
  WriteData('MCB',cSitLst,pValue);
end;

function TAfcMcb.ReadPayLst:boolean;
begin
  Result := ReadData('MCB',cPayLst);
end;

procedure TAfcMcb.WritePayLst(pValue:boolean);
begin
  WriteData('MCB',cPayLst,pValue);
end;

function TAfcMcb.ReadBokPrp:boolean;
begin
  Result := ReadData('MCB',cBokPrp);
end;

procedure TAfcMcb.WriteBokPrp(pValue:boolean);
begin
  WriteData('MCB',cBokPrp,pValue);
end;

function TAfcMcb.ReadAttLst:boolean;
begin
  Result := ReadData('MCB',cAttLst);
end;

procedure TAfcMcb.WriteAttLst(pValue:boolean);
begin
  WriteData('MCB',cAttLst,pValue);
end;

// ---------------------------- TlaË ---------------------------------

function TAfcMcb.ReadPrnMcd:boolean;
begin
  Result := ReadData('MCB',cPrnMcd);
end;

procedure TAfcMcb.WritePrnMcd(pValue:boolean);
begin
  WriteData('MCB',cPrnMcd,pValue);
end;

function TAfcMcb.ReadPrnMpd:boolean;
begin
  Result := ReadData('MCB',cPrnMpd);
end;

procedure TAfcMcb.WritePrnMpd(pValue:boolean);
begin
  WriteData('MCB',cPrnMpd,pValue);
end;

// ---------------------------- N·stroje -----------------------------

function TAfcMcb.ReadTcdGen:boolean;
begin
  Result := ReadData('MCB',cTcdGen);
end;

procedure TAfcMcb.WriteTcdGen(pValue:boolean);
begin
  WriteData('MCB',cTcdGen,pValue);
end;

function TAfcMcb.ReadOcdGen:boolean;
begin
  Result := ReadData('MCB',cOcdGen);
end;

procedure TAfcMcb.WriteOcdGen(pValue:boolean);
begin
  WriteData('MCB',cOcdGen,pValue);
end;

function TAfcMcb.ReadDocCpy:boolean;
begin
  Result := ReadData('MCB',cDocCpy);
end;

procedure TAfcMcb.WriteDocCpy(pValue:boolean);
begin
  WriteData('MCB',cDocCpy,pValue);
end;

function TAfcMcb.ReadMciClc:boolean;
begin
  Result := ReadData('MCB',cMciClc);
end;

procedure TAfcMcb.WriteMciClc(pValue:boolean);
begin
  WriteData('MCB',cMciClc,pValue);
end;

function TAfcMcb.ReadCpyAgm:boolean;
begin
  Result := ReadData('MCB',cCpyAgm);
end;

procedure TAfcMcb.WriteCpyAgm(pValue:boolean);
begin
  WriteData('MCB',cCpyAgm,pValue);
end;
// ---------------------------- ⁄drûba -------------------------------

function TAfcMcb.ReadDocClc:boolean;
begin
  Result := ReadData('MCB',cDocClc);
end;

procedure TAfcMcb.WriteDocClc(pValue:boolean);
begin
  WriteData('MCB',cDocClc,pValue);
end;

function TAfcMcb.ReadPayClc:boolean;
begin
  Result := ReadData('MCB',cPayClc);
end;

procedure TAfcMcb.WritePayClc(pValue:boolean);
begin
  WriteData('MCB',cPayClc,pValue);
end;

// ---------------------------- Poloûky ------------------------------

function TAfcMcb.ReadItmAdd:boolean;
begin
  Result := ReadData('MCB',cItmAdd);
end;

procedure TAfcMcb.WriteItmAdd(pValue:boolean);
begin
  WriteData('MCB',cItmAdd,pValue);
end;

function TAfcMcb.ReadItmDel:boolean;
begin
  Result := ReadData('MCB',cItmDel);
end;

procedure TAfcMcb.WriteItmDel(pValue:boolean);
begin
  WriteData('MCB',cItmDel,pValue);
end;

function TAfcMcb.ReadItmMod:boolean;
begin
  Result := ReadData('MCB',cItmMod);
end;

procedure TAfcMcb.WriteItmMod(pValue:boolean);
begin
  WriteData('MCB',cItmMod,pValue);
end;

function TAfcMcb.ReadCphEdi:boolean;
begin
  Result := ReadData('MCB',cCphEdi);
end;

procedure TAfcMcb.WriteCphEdi(pValue:boolean);
begin
  WriteData('MCB',cCphEdi,pValue);
end;

// ---------------------------- Prilohy ------------------------------

function TAfcMcb.ReadAttAdd:boolean;
begin
  Result := ReadData('MCB',cAttAdd);
end;

procedure TAfcMcb.WriteAttAdd(pValue:boolean);
begin
  WriteData('MCB',cAttAdd,pValue);
end;

function TAfcMcb.ReadAttDel:boolean;
begin
  Result := ReadData('MCB',cAttDel);
end;

procedure TAfcMcb.WriteAttDel(pValue:boolean);
begin
  WriteData('MCB',cAttDel,pValue);
end;

function TAfcMcb.ReadAttMod:boolean;
begin
  Result := ReadData('MCB',cAttMod);
end;

procedure TAfcMcb.WriteAttMod(pValue:boolean);
begin
  WriteData('MCB',cAttMod,pValue);
end;

function TAfcMcb.ReadAttShw:boolean;
begin
  Result := ReadData('MCB',cAttShw);
end;

procedure TAfcMcb.WriteAttShw(pValue:boolean);
begin
  WriteData('MCB',cAttShw,pValue);
end;

function TAfcMcb.ReadAttFid:boolean;
begin
  Result := ReadData('MCB',cAttFid);
end;

procedure TAfcMcb.WriteAttFid(pValue:boolean);
begin
  WriteData('MCB',cAttFid,pValue);
end;

end.
{MOD 1902010}
