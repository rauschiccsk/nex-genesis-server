unit AfcCmb;

interface

uses
  IcTypes, IcTools, NexPath, NexGlob, AfcBas,
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, NexBtrTable, Forms;

type
  TAfcCmb = class (TAfcBas)
  private
    // ---------------------------- ⁄pravy -------------------------------
    function ReadDocAdd:boolean;    procedure WriteDocAdd(pValue:boolean);
    function ReadDocDel:boolean;    procedure WriteDocDel(pValue:boolean);
    function ReadDocMod:boolean;    procedure WriteDocMod(pValue:boolean);
    function ReadDocLck:boolean;    procedure WriteDocLck(pValue:boolean);
    function ReadDocUnl:boolean;    procedure WriteDocUnl(pValue:boolean);
    // ---------------------------- Zobraziù -----------------------------
    function ReadSitLst:boolean;    procedure WriteSitLst(pValue:boolean);
    // ---------------------------- TlaË ---------------------------------
    function ReadDocPrn:boolean;    procedure WriteDocPrn(pValue:boolean);
    function ReadCmdPrn: boolean;   procedure WriteCmdPrn(pValue: boolean);
    // ---------------------------- N·stroje -----------------------------
    function ReadDocFlt:boolean;    procedure WriteDocFlt(pValue:boolean);
    function ReadAccDoc: boolean;   procedure WriteAccDoc(pValue: boolean);
    function ReadCmpDoc: boolean;   procedure WriteCmpDoc(pValue: boolean);
    function ReadCphLst: boolean;   procedure WriteCphLst(pValue: boolean);
    // ---------------------------- ⁄drûba -------------------------------
    function ReadMntFnc:boolean;    procedure WriteMntFnc(pValue:boolean);
    // ---------------------------- Servis -------------------------------
    function ReadSerFnc: boolean;   procedure WriteSerFnc(pValue: boolean);
    // ---------------------------- Poloûky ------------------------------
    function ReadItmAdd:boolean;    procedure WriteItmAdd(pValue:boolean);
    function ReadItmDel:boolean;    procedure WriteItmDel(pValue:boolean);
    function ReadItmMod:boolean;    procedure WriteItmMod(pValue:boolean);
  public
    // ---------------------------- ⁄pravy -------------------------------
    property DocAdd:boolean read ReadDocAdd write WriteDocAdd;
    property DocDel:boolean read ReadDocDel write WriteDocDel;
    property DocMod:boolean read ReadDocMod write WriteDocMod;
    property DocLck:boolean read ReadDocLck write WriteDocLck;
    property DocUnl:boolean read ReadDocUnl write WriteDocUnl;
    // ---------------------------- Zobraziù -----------------------------
    property SitLst:boolean read ReadSitLst write WriteSitLst;
    // ---------------------------- TlaË ---------------------------------
    property DocPrn:boolean read ReadDocPrn write WriteDocPrn;
    property CmdPrn:boolean read ReadCmdPrn write WriteCmdPrn;
    // ---------------------------- N·stroje -----------------------------
    property DocFlt:boolean read ReadDocFlt write WriteDocFlt;
    property CmpDoc:boolean read ReadCmpDoc write WriteCmpDoc;
    property AccDoc:boolean read ReadAccDoc write WriteAccDoc;
    property CphLst:boolean read ReadCphLst write WriteCphLst;
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
// Upravy ------  Zobrazit ----  Tlac --------  N·stroje ----  Udrzba -------  Servis -------  Polozky -----
   cDocAdd = 1;   cSitLst = 20;  cDocPrn = 40;  cDocFlt = 60;  cMntFnc = 110;  cSerFnc = 120;  cItmAdd = 150;
   cDocDel = 2;   cBokLst = 21;  cCmdPrn = 40;  cCmpDoc= 62;                                   cItmDel = 151;
   cDocMod = 3;                                 cAccDoc= 63;                                   cItmMod = 152;
   cDocLck = 6;                                 cCphLst= 64;
   cDocUnl = 8;





// **************************************** OBJECT *****************************************

// ---------------------------- ⁄pravy -------------------------------

function TAfcCmb.ReadDocAdd:boolean;
begin
  Result := ReadData('CMB',cDocAdd);
end;

procedure TAfcCmb.WriteDocAdd(pValue:boolean);
begin
  WriteData('CMB',cDocAdd,pValue);
end;

function TAfcCmb.ReadDocDel:boolean;
begin
  Result := ReadData('CMB',cDocDel);
end;

procedure TAfcCmb.WriteDocDel(pValue:boolean);
begin
  WriteData('CMB',cDocDel,pValue);
end;

function TAfcCmb.ReadDocMod:boolean;
begin
  Result := ReadData('CMB',cDocMod);
end;

procedure TAfcCmb.WriteDocMod(pValue:boolean);
begin
  WriteData('CMB',cDocMod,pValue);
end;

function TAfcCmb.ReadDocLck:boolean;
begin
  Result := ReadData('CMB',cDocLck);
end;

procedure TAfcCmb.WriteDocLck(pValue:boolean);
begin
  WriteData('CMB',cDocLck,pValue);
end;

function TAfcCmb.ReadDocUnl:boolean;
begin
  Result := ReadData('CMB',cDocUnl);
end;

procedure TAfcCmb.WriteDocUnl(pValue:boolean);
begin
  WriteData('CMB',cDocUnl,pValue);
end;

// ---------------------------- Zobraziù -----------------------------

function TAfcCmb.ReadSitLst:boolean;
begin
  Result := ReadData('CMB',cSitLst);
end;

procedure TAfcCmb.WriteSitLst(pValue:boolean);
begin
  WriteData('CMB',cSitLst,pValue);
end;

// ---------------------------- TlaË ---------------------------------

function TAfcCmb.ReadDocPrn:boolean;
begin
  Result := ReadData('CMB',cDocPrn);
end;

procedure TAfcCmb.WriteDocPrn(pValue:boolean);
begin
  WriteData('CMB',cDocPrn,pValue);
end;

// ---------------------------- N·stroje -----------------------------

function TAfcCmb.ReadDocFlt:boolean;
begin
  Result := ReadData('CMB',cDocFlt);
end;

procedure TAfcCmb.WriteDocFlt(pValue:boolean);
begin
  WriteData('CMB',cDocFlt,pValue);
end;

function TAfcCmb.ReadAccDoc: boolean;
begin
  Result := ReadData('CMB',cAccDoc);
end;

procedure TAfcCmb.WriteAccDoc(pValue: boolean);
begin
  WriteData('CMB',cAccDoc,pValue);
end;

function TAfcCmb.ReadCmpDoc: boolean;
begin
  Result := ReadData('CMB',cCmpDoc);
end;

procedure TAfcCmb.WriteCmpDoc(pValue: boolean);
begin
  WriteData('CMB',cCmpDoc,pValue);
end;

function TAfcCmb.ReadCphLst: boolean;
begin
  Result := ReadData('CMB',cCphLst);
end;

procedure TAfcCmb.WriteCphLst(pValue: boolean);
begin
  WriteData('CMB',cCphLst,pValue);
end;

// ---------------------------- ⁄drûba -------------------------------

function TAfcCmb.ReadMntFnc:boolean;
begin
  Result := ReadData('CMB',cMntFnc);
end;

procedure TAfcCmb.WriteMntFnc(pValue:boolean);
begin
  WriteData('CMB',cMntFnc,pValue);
end;

// ---------------------------- Servis -------------------------------

// ---------------------------- Poloûky ------------------------------

function TAfcCmb.ReadItmAdd:boolean;
begin
  Result := ReadData('CMB',cItmAdd);
end;

procedure TAfcCmb.WriteItmAdd(pValue:boolean);
begin
  WriteData('CMB',cItmAdd,pValue);
end;

function TAfcCmb.ReadItmDel:boolean;
begin
  Result := ReadData('CMB',cItmDel);
end;

procedure TAfcCmb.WriteItmDel(pValue:boolean);
begin
  WriteData('CMB',cItmDel,pValue);
end;

function TAfcCmb.ReadItmMod:boolean;
begin
  Result := ReadData('CMB',cItmMod);
end;

procedure TAfcCmb.WriteItmMod(pValue:boolean);
begin
  WriteData('CMB',cItmMod,pValue);
end;

function TAfcCmb.ReadSerFnc: boolean;
begin
  Result := ReadData('CMB',cSerFnc);
end;

procedure TAfcCmb.WriteSerFnc(pValue: boolean);
begin
  WriteData('CMB',cSerFnc,pValue);
end;

function TAfcCmb.ReadCmdPrn: boolean;
begin
  Result := ReadData('CMB',cCmdPrn);
end;

procedure TAfcCmb.WriteCmdPrn(pValue: boolean);
begin
  WriteData('CMB',cCmdPrn,pValue);
end;

end.
