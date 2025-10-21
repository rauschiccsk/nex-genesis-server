unit IcLabels;

interface

uses
  IcVariab, IcConv,
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls;

type
  TSpecLabel = class(TLabel)
  private
    oFixedSize: boolean;
  published
    constructor Create(AOwner: TComponent); override;
    procedure Loaded; override;
    property FixedSize:boolean read oFixedSize write oFixedSize;
  end;

  // Label ktora sa zarovnava do lava
  TLeftLabel = class(TSpecLabel)
  published
    constructor Create(AOwner: TComponent); override;
  end;

  // Label ktora sa zarovnava do stredu
  TCenterLabel = class(TSpecLabel)
  published
    constructor Create(AOwner: TComponent); override;
  end;

  // Label ktora sa zarovnava do prava
  TRightLabel = class(TSpecLabel)
  published
    constructor Create(AOwner: TComponent); override;
  end;

  // Label numerickych hodnot
  TNumLabel = class(TSpecLabel)
    constructor Create(AOwner: TComponent); override;
  private
    oFract: byte;
    oValue: double;
    function  GetValueInt: integer;
    procedure SetValueInt(pValue: integer);
    function  GetValueDoub: double;
    procedure SetValueDoub(pValue: double);
    function  GetValueDate: TDateTime;
    procedure SetValueDate(pValue: TDateTime);
    procedure SetFract(pValue:byte);
    function  GetAsInteger: integer;
    procedure SetAsInteger(pValue: integer);
    function  GetAsFloat: double;
    procedure SetAsFloat(pValue: double);
  protected
    { Protected declarations }
  public
    { Public declarations }
  published
    { Published declarations }
    property Fract: byte          read oFract write SetFract;
    property ValueInt:  integer   read GetValueInt  write SetValueInt;
    property ValueDoub: double    read GetValueDoub write SetValueDoub;
    property ValueDate: TDatetime read GetValueDate write SetValueDate;
    property Long: integer        read GetValueInt  write SetValueInt;
    property Value: double        read GetValueDoub write SetValueDoub;

    property AsInteger:integer    read GetAsInteger write SetAsInteger;
    property AsFloat:double       read GetAsFloat write SetAsFloat;
  end;

procedure Register;

implementation

// ****************** TSpecLabel ******************
constructor TSpecLabel.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  oFixedSize := FALSE; // Velkost sa nacita zo suboru
end;

procedure TSpecLabel.Loaded;
begin
  inherited;
  If not oFixedSize then begin
    Font.Name := gvSys.LabelFontName;
    Font.Size := gvSys.LabelFontSize;
  end;
end;

// ****************** TLeftLabel ******************
constructor TLeftLabel.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  Alignment := taLeftJustify;
end;

// ****************** TCenterLabel ******************
constructor TCenterLabel.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  Width := 100;
  AutoSize := FALSE;
  Alignment := taCenter;
end;

// ****************** TRightLabel ******************
constructor TRightLabel.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  Alignment := taRightJustify;
end;

// ****************** TNumLabel ******************
constructor TNumLabel.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  oValue := 0;
  oFract := 2;
end;

function  TNumLabel.GetValueInt: integer;
begin
  try
    Result := StrToInt(Caption);
  except
    Result := 0;
  end;
end;

procedure TNumLabel.SetValueInt(pValue: integer);
begin
  oValue := pValue;
  Caption := IntToStr(pValue);
end;

function  TNumLabel.GetValueDoub: double;
begin
  Result := oValue;
end;

procedure TNumLabel.SetValueDoub(pValue: double);
begin
  If Abs(pValue) < 0.0000000001 then oValue := 0 else oValue:=pValue;
//  oValue := pValue;
  Caption := StrRealSepar(oValue,0,oFract,TRUE);
end;

function  TNumLabel.GetValueDate: TDateTime;
begin
  try
    Result := StrToDate(Caption);
  except
    Result := 0;
  end;
end;

procedure TNumLabel.SetValueDate(pValue: TDateTime);
begin
  Caption := DateToStr(pValue);
end;

procedure TNumLabel.SetFract(pValue:byte);
begin
  oFract := pValue;
  Caption := StrRealSepar(oValue,0,oFract,TRUE);
  Repaint;
end;

function  TNumLabel.GetAsInteger: integer;
begin
  Result := GetValueInt;
end;

procedure TNumLabel.SetAsInteger(pValue: integer);
begin
  SetValueInt(pValue);
end;

function  TNumLabel.GetAsFloat: double;
begin
  Result := GetValueDoub;
end;

procedure TNumLabel.SetAsFloat(pValue: double);
begin
  SetValueDoub(pValue);
end;

procedure Register;
begin
  RegisterComponents('IcStandard', [TSpecLabel]);
  RegisterComponents('IcStandard', [TLeftLabel]);
  RegisterComponents('IcStandard', [TCenterLabel]);
  RegisterComponents('IcStandard', [TRightLabel]);
  RegisterComponents('IcStandard', [TNumLabel]);
end;

end.
