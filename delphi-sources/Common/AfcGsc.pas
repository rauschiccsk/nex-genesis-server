unit AfcGsc;

interface

uses
  IcTypes, IcTools, NexPath, NexGlob, AfcBas,
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, NexBtrTable, Forms;

type
  TAfcGsc = class (TAfcBas)
  private
    // ---------------------------- ⁄pravy -------------------------------
    function ReadItmAdd:boolean;    procedure WriteItmAdd(pValue:boolean);
    function ReadItmDel:boolean;    procedure WriteItmDel(pValue:boolean);
    function ReadItmMod:boolean;    procedure WriteItmMod(pValue:boolean);
    function ReadItmDis:boolean;    procedure WriteItmDis(pValue:boolean);
    function ReadItmEna:boolean;    procedure WriteItmEna(pValue:boolean);
    function ReadAddImg:boolean;    procedure WriteAddImg(pValue:boolean);
    function ReadGsnLng:boolean;    procedure WriteGsnLng(pValue:boolean);
    // ---------------------------- Zobraziù -----------------------------
    // ---------------------------- TlaË ---------------------------------
    // ---------------------------- N·stroje -----------------------------
    // ---------------------------- ⁄drûba -------------------------------
    function ReadIntDel:boolean;    procedure WriteIntDel(pValue:boolean);
  public
    // ---------------------------- ⁄pravy -------------------------------
    property ItmAdd:boolean read ReadItmAdd write WriteItmAdd;
    property ItmDel:boolean read ReadItmDel write WriteItmDel;
    property ItmMod:boolean read ReadItmMod write WriteItmMod;
    property ItmDis:boolean read ReadItmDis write WriteItmDis;
    property ItmEna:boolean read ReadItmEna write WriteItmEna;
    property AddImg:boolean read ReadAddImg write WriteAddImg;
    property GsnLng:boolean read ReadGsnLng write WriteGsnLng;
    // ---------------------------- Zobraziù -----------------------------
    // ---------------------------- TlaË ---------------------------------
    // ---------------------------- N·stroje -----------------------------
    // ---------------------------- ⁄drûba -------------------------------
    property IntDel:boolean read ReadIntDel write WriteIntDel;
  end;

implementation

const
// Upravy ------  Zobrazit ----  Tlac --------  N·stroje ----  Udrzba ------  Polozky -----
   cItmAdd = 1;  // cSitLst = 20;  cDocPrn = 40;  cDocFlt = 60;  cDocClc = 90;  cItmAdd = 150;
   cItmDel = 2;
   cItmMod = 3;
   cItmDis = 4;
   cItmEna = 5;
   cAddImg = 6;
   cGsnLng = 7;                                                cIntDel = 97;
// **************************************** OBJECT *****************************************

// ---------------------------- ⁄pravy -------------------------------

function TAfcGsc.ReadItmAdd:boolean;
begin
  Result := ReadData('GSC',cItmAdd);
end;

procedure TAfcGsc.WriteItmAdd(pValue:boolean);
begin
  WriteData('GSC',cItmAdd,pValue);
end;

function TAfcGsc.ReadItmDel:boolean;
begin
  Result := ReadData('GSC',cItmDel);
end;

procedure TAfcGsc.WriteItmDel(pValue:boolean);
begin
  WriteData('GSC',cItmDel,pValue);
end;

function TAfcGsc.ReadItmMod:boolean;
begin
  Result := ReadData('GSC',cItmMod);
end;

procedure TAfcGsc.WriteItmMod(pValue:boolean);
begin
  WriteData('GSC',cItmMod,pValue);
end;

function TAfcGsc.ReadItmDis:boolean;
begin
  Result := ReadData('GSC',cItmDis);
end;

procedure TAfcGsc.WriteItmDis(pValue:boolean);
begin
  WriteData('GSC',cItmDis,pValue);
end;

function TAfcGsc.ReadItmEna:boolean;
begin
  Result := ReadData('GSC',cItmEna);
end;

procedure TAfcGsc.WriteItmEna(pValue:boolean);
begin
  WriteData('GSC',cItmEna,pValue);
end;

function TAfcGsc.ReadAddImg:boolean;
begin
  Result := ReadData('GSC',cAddImg);
end;

procedure TAfcGsc.WriteAddImg(pValue:boolean);
begin
  WriteData('GSC',cAddImg,pValue);
end;

function TAfcGsc.ReadGsnLng:boolean;
begin
  Result := ReadData('GSC',cGsnLng);
end;

procedure TAfcGsc.WriteGsnLng(pValue:boolean);
begin
  WriteData('GSC',cGsnLng,pValue);
end;

// ---------------------------- Zobraziù -----------------------------
// ---------------------------- TlaË ---------------------------------
// ---------------------------- N·stroje -----------------------------
// ---------------------------- ⁄drûba -------------------------------
function TAfcGsc.ReadIntDel:boolean;
begin
  Result:=ReadData('GSC',cIntDel);
end;

procedure TAfcGsc.WriteIntDel(pValue:boolean);
begin
  WriteData('GSC',cIntDel,pValue);
end;

end.
