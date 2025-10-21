unit Value3;

interface

uses
  NexGlob;

type
  TValue3 = class
  private
    oValue: array [1..3] of double;
    procedure SetValue (pIndex:byte; pValue: double);
    function GetValue (pIndex:byte): double;
  public
    procedure Clear;
    procedure Add (pVatPrc:double; pValue:double);
    property Value[pIndex:byte]: double read GetValue write SetValue; default;
  end;

implementation

procedure TValue3.Clear;
begin
  oValue[1] := 0;
  oValue[2] := 0;
  oValue[3] := 0;
end;

procedure TValue3.Add;
var mVatGrp: byte;
begin
  mVatGrp := VatGrp(pVatPrc);
  oValue[mVatGrp] := oValue[mVatGrp]+pValue;
end;

procedure TValue3.SetValue;
begin
  oValue[pIndex] := pValue;
end;

function TValue3.GetValue (pIndex:byte): double;
begin
  Result := 0;
  If pIndex in [1,2,3]
    then Result := oValue[pIndex]
    else begin
      If pIndex = 0 then Result := oValue[1]+oValue[2]+oValue[3]
    end;
end;

end.
