unit DscDet;

interface

uses
  IcTypes, IcVariab, IcConv, IcTools, NexIni,
  Windows, Registry, SysUtils, Forms, Classes;

type
  TDscDet = class
    constructor Create;
    destructor Destroy; override;
  private
    oAction: Str1;     // Akciove oznacenie
    oPaCode: longint;  // Kod firmy
    oFgCode: longint;  // Kod firmy
    oFacDay: word;     // FACTORING - pocet dni
    oFacPrc: double;   // FACTORING - koeficient
    oBPrice: double;   // PC s DPH
  public
    procedure Clear;    // Vybnuluje nastavenua
    function GetDscPrc:double; // Urci zlavu podla zadanych vlastnosti
  published
    property Action:Str1 write oAction;
    property PaCode:longint write oPaCode;
    property FgCode:longint write oPaCode;
    property FacDay:word write oFacDay;
    property FacPrc:double write oFacPrc;
    property BPrice:double write oBPrice;
    property DscPrc:double read GetDscPrc;
  end;

var gDsc: TDscDet;

implementation

uses
  DM_STKDAT;

constructor TDscDet.Create;
begin
  Clear; // Vybnuluje nastavenua
end;

destructor TDscDet.Destroy;
begin
end;

procedure TDscDet.Clear; // Vybnuluje nastavenua
begin
  oAction := '';   oBPrice := 0;
  oPaCode := 0;    oFgCode := 0;
  oFacDay := 0;    oFacPrc := 0;
end;

// ------------------------------------------------------

function TDscDet.GetDscPrc:double;
var mDscPrc:double;
begin
  mDscPrc := 0;
  If oAction<>'A' then begin // Zlavu dame len vtedy ak to nie je akciovy tovar
    If dmSTK.btFGPADSC.FindKey ([oPaCode,oFgCode]) then mDscPrc := dmSTK.btFGPADSC.FieldByName('DscPrc').AsFloat;
    If oFacDay=0 then begin
      If IsNotNul (mDscPrc) then mDscPrc := mDscPrc-gIni.DepDscPrc;
    end
    else mDscPrc := mDscPrc-oFacPrc; // FACTORING
  end;
  Result := mDscPrc;
end;


end.
