unit AfcPac;

interface

uses
  IcTypes, IcTools, NexPath, NexGlob, AfcBas,
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, NexBtrTable, Forms;

type
  TAfcPac=class(TAfcBas)
  private
    // ---------------------------- ⁄pravy -------------------------------
    function ReadItmAdd:boolean;    procedure WriteItmAdd(pValue:boolean);
    function ReadItmDel:boolean;    procedure WriteItmDel(pValue:boolean);
    function ReadItmMod:boolean;    procedure WriteItmMod(pValue:boolean);
    function ReadCmpEdi:boolean;    procedure WriteCmpEdi(pValue:boolean);
    // ---------------------------- Zobraziù -----------------------------
    // ---------------------------- TlaË ---------------------------------
    // ---------------------------- N·stroje -----------------------------
    // ---------------------------- ⁄drûba -------------------------------
  public
    // ---------------------------- ⁄pravy -------------------------------
    property ItmAdd:boolean read ReadItmAdd write WriteItmAdd;
    property ItmDel:boolean read ReadItmDel write WriteItmDel;
    property ItmMod:boolean read ReadItmMod write WriteItmMod;
    property CmpEdi:boolean read ReadCmpEdi write WriteCmpEdi;
    // ---------------------------- Zobraziù -----------------------------
    // ---------------------------- TlaË ---------------------------------
    // ---------------------------- N·stroje -----------------------------
    // ---------------------------- ⁄drûba -------------------------------
  end;

implementation

const
// Upravy ------  Zobrazit ----  Tlac --------  N·stroje ----  Udrzba ------  Polozky -----
   cItmAdd=1;    // cSitLst = 20;  cDocPrn = 40;  cDocFlt = 60;  cDocClc = 90;  cItmAdd = 150;
   cItmDel=2;
   cItmMod=3;
   cCmpEdi=4;
// **************************************** OBJECT *****************************************

// ---------------------------- ⁄pravy -------------------------------

function TAfcPac.ReadItmAdd:boolean;
begin
  Result:=ReadData('PAC',cItmAdd);
end;

procedure TAfcPac.WriteItmAdd(pValue:boolean);
begin
  WriteData('PAC',cItmAdd,pValue);
end;

function TAfcPac.ReadItmDel:boolean;
begin
  Result:=ReadData('PAC',cItmDel);
end;

procedure TAfcPac.WriteItmDel(pValue:boolean);
begin
  WriteData('PAC',cItmDel,pValue);
end;

function TAfcPac.ReadItmMod:boolean;
begin
  Result:=ReadData('PAC',cItmMod);
end;

procedure TAfcPac.WriteItmMod(pValue:boolean);
begin
  WriteData('PAC',cItmMod,pValue);
end;

function TAfcPac.ReadCmpEdi:boolean;
begin
  Result:=ReadData('PAC',cCmpEdi);
end;

procedure TAfcPac.WriteCmpEdi(pValue:boolean);
begin
  WriteData('PAC',cCmpEdi,pValue);
end;

// ---------------------------- Zobraziù -----------------------------
// ---------------------------- TlaË ---------------------------------
// ---------------------------- N·stroje -----------------------------
// ---------------------------- ⁄drûba -------------------------------

end.
