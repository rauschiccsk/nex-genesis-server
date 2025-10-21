unit IcValue;

interface

uses
  IcConv, IcTools, Dialogs, NexIni;

const  cVatCnt=8;

type
  TValue8=class
    constructor Create;
    destructor Destroy; override;
  private
    oVatPrc:array [1..cVatCnt] of byte;
    oValue:array [1..cVatCnt] of double;
    procedure SetVatPrc(pIndex,pValue: byte);        function GetVatPrc(pIndex:byte): byte;
    procedure SetValue(pIndex:byte; pValue: double); function GetValue(pIndex:byte): double;
  public
    procedure Clear;
    procedure Add(pVatPrc:double; pValue:double);
    function VatGrp (pVatPrc:byte):byte; // Funkcia vrati poradove cislo skupiny DPH zadanej sadzby
    function VatQnt:byte; // Pocet danovych pouzitych skupin
    property VatPrc[pIndex:byte]: byte read GetVatPrc write SetVatPrc;
    property Value[pIndex:byte]: double read GetValue write SetValue; default;
  end;

  procedure DocClcRnd(pAcAValue,pAcBValue,pFgAValue,pFgBValue:TValue8;pVatDoc:boolean);

implementation

procedure DocClcRnd;
var I:byte;
begin
  // Vypocitame "Hodnotu bez DPH" z "Hodnoty s DPH" a zaokruhlime na 2 desatinne miesta
  For I:=1 to 3  do begin
    pAcBValue.Value[I]:=Rd2(pAcBValue.Value[I]);
    pFgBValue.Value[I]:=Rd2(pFgBValue.Value[I]);
    If pVatDoc then begin
      pAcAValue.Value[I]:=Rd2(pAcBValue.Value[I]/(1+pAcBValue.VatPrc[I]/100));
      pFgAValue.Value[I]:=Rd2(pFgBValue.Value[I]/(1+pFgBValue.VatPrc[I]/100));
    end else begin
      pAcAValue.Value[I]:=Rd2(pAcBValue.Value[I]);
      pFgAValue.Value[I]:=Rd2(pFgBValue.Value[I]);
    end;
  end;
end;

constructor TValue8.Create;
begin
  oVatPrc[1] :=   0;
  oVatPrc[2] :=   5;
  oVatPrc[3] :=  19;
  oVatPrc[4] :=  23;
  oVatPrc[5] := 100;
  oVatPrc[6] := 100;
  oVatPrc[7] := 100;
  oVatPrc[8] := 100;
end;

destructor  TValue8.Destroy;
begin
end;

procedure TValue8.Clear;
var I:byte;
begin
  For I:=1 to cVatCnt do
    oValue[I] := 0;
end;

procedure TValue8.Add;
var mVatGrp: byte;
begin
  mVatGrp := VatGrp(Round(pVatPrc));
  If mVatGrp in [1..cVatCnt]
    then oValue[mVatGrp] := oValue[mVatGrp]+pValue
    else MessageDlg('Nexistujuca sadzba DPH '+StrDoub(pVatPrc,0,0),mtInformation,[mbOk],0);
end;

function TValue8.VatGrp (pVatPrc:byte):byte;  // Funkcia vrati poradove cislo skupiny DPH zadanej sadzby
var mVatGrp: byte;  mFounded: boolean;
begin
  mVatGrp := 0;
  repeat
    Inc(mVatGrp);
    mFounded := pVatPrc=oVatPrc[mVatGrp];
  until mFounded or (mVatGrp=cVatCnt);
  if mFounded
    then Result := mVatGrp
    else Result := gIni.GetDefVatGrp;
end;

function TValue8.VatQnt:byte; // Pocet danovych pouzitych skupin
var I:byte;
begin
  Result := 0;
  For I:=1 to cVatCnt do
    If oVatPrc[I]<>100 then Inc (Result);
end;

procedure TValue8.SetVatPrc (pIndex,pValue:byte);
begin
  oVatPrc[pIndex] := pValue;
end;

function TValue8.GetVatPrc (pIndex:byte): byte;
begin
  Result := oVatPrc[pIndex];
end;

procedure TValue8.SetValue;
begin
  oValue[pIndex] := pValue;
end;

function TValue8.GetValue (pIndex:byte): double;
begin
  Result := 0;
  If pIndex in [1..cVatCnt]
    then Result := oValue[pIndex]
    else begin
      If pIndex = 0 then Result := oValue[1]+oValue[2]+oValue[3]+oValue[4]+oValue[5]+oValue[6]+oValue[7]+oValue[8];
    end;
end;

end.
{MOD 1901014}