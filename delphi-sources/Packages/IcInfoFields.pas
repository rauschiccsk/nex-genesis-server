unit IcInfoFields;

interface

uses
  IcConv, IcVariab, IcLabels, IcText,
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls, ExtCtrls;

type
  // Informacne pole volnych textov
  TNameInfo = class(TCustomPanel)
    L_InfoText: TNumLabel;
  private
    procedure SetAlignment (pValue:TAlignment);
    function GetAlignment: TAlignment;
    procedure SetText (pValue:string);
    function GetText: string;
    procedure SetColor (pValue:TColor);
    function GetColor: TColor;
    procedure SetFont (pValue:TFont);
    function GetFont: TFont;
  public
    constructor Create (AOwner:TComponent); override;
    destructor Destroy; override;
    procedure Loaded; override;
  published
    property Alignment: TAlignment read GetAlignment write SetAlignment;
    property Text: string read GetText write SetText;
    property Color: TColor read GetColor write SetColor;
    property Font: TFont read GetFont write SetFont;
    property Visible;
    property Anchors;
  end;

  // Informacne pole pre cele cisla
  TLongInfo = class(TNameInfo)
  private
    procedure SetLong (pValue:longint);
    function GetLong: longint;
  public
    constructor Create (AOwner:TComponent); override;
  published
    property Long: longint read GetLong write SetLong;
  end;

  // Informacne pole pre datum
  TDateInfo = class(TNameInfo)
  private
    oDate: TDateTime;
    procedure SetDate (pValue:TDateTime);
    function GetDate: TDateTime;
  public
    constructor Create (AOwner:TComponent); override;
  published
    property Date: TDateTime read GetDate write SetDate;
  end;

  // Informacne pole pre cas
  TTimeInfo = class(TNameInfo)
  private
    oTime: TDateTime;
    procedure SetTime (pValue:TDateTime);
    function GetTime: TDateTime;
  public
    constructor Create (AOwner:TComponent); override;
  published
    property Time: TDateTime read GetTime write SetTime;
  end;

  // Informacne pole penazne hodnoty
  TValueInfo = class(TCustomPanel)
    L_Value: TSpecLabel;
    L_Extend: TSpecLabel;
  private
    oValue: double;  // Hodnota informacneho pola
    oFract: byte;    // Pocet desaticnych mist
    procedure SetValue (pValue:double);
    procedure SetText (pValue:string);
    function  GetText: string;
    procedure SetExtend (pValue:string);
    function  GetExtend: string;
    procedure SetColor (pValue:TColor);
    function GetColor: TColor;
    procedure SetFont (pValue:TFont);
    function GetFont: TFont;
    procedure SetFract (pValue:byte);

  public
    constructor Create (AOwner:TComponent); override;
    procedure Loaded; override;
    destructor Destroy; override;
  published
    property Value: double read oValue write SetValue;
    property Text: string read GetText write SetText;
    property Extend: string read GetExtend write SetExtend;
    Property Fract: byte read oFract write SetFract;
    property Color: TColor read GetColor write SetColor;
    property Font: TFont read GetFont write SetFont;
    property Anchors;
    property Visible;
  end;

  // Informacne pole penazne hodnoty
  TPriceInfo = class(TValueInfo)
    procedure SetIntCoin(pValue: string);
    function  GetIntCoin: string;
    procedure SetMeasure(pValue: string);
    function  GetMeasure: string;
  private
    oIntCoin: string;
    oMeasure: string;
  public
    constructor Create (AOwner:TComponent); override;
    procedure Loaded; override;
  published
    property IntCoin: string read GetIntCoin write SetIntCoin;
    property Measure: string read GetMeasure write SetMeasure;
  end;

  // Informacne pole mnozstva
  TQuantInfo = class(TValueInfo)
  public
    constructor Create (AOwner:TComponent); override;
  end;

  // Informacne pole percentualnej hodnoty
  TPrcInfo = class(TValueInfo)
  public
    constructor Create (AOwner:TComponent); override;
  end;

procedure Register;

implementation

// *********** Informacne pole volnych textov *********
constructor TNameInfo.Create (AOwner:TComponent);
begin
  inherited Create (AOwner);
  Width := 250;
  Height := 20;
  BevelOuter := bvLowered;
  BorderWidth := 1;
  Caption := '';
  TabStop := FALSE;

  L_InfoText := TNumLabel.Create (Self);
  L_InfoText.Parent := Self;
  L_InfoText.Top := 2;
  L_InfoText.Left := 2;
  L_InfoText.Align := alClient;
  L_InfoText.Alignment := taLeftJustify;
  L_InfoText.Layout := tlCenter;
  L_InfoText.Font.Color := clNavy;
  L_InfoText.Font.Style := [fsBold];
  L_InfoText.Font.Name := gvSys.EditFontName;
  L_InfoText.Font.Size := gvSys.EditFontSize;
  L_InfoText.Caption := '';
end;

destructor TNameInfo.Destroy;
begin
  L_InfoText.Free;
  inherited;
end;

procedure TNameInfo.Loaded;
begin
  inherited;
  L_InfoText.Font.Charset := gvSys.FontCharset;
  Caption := '';
end;

procedure TNameInfo.SetAlignment (pValue: TAlignment);
begin
  L_InfoText.Alignment := pValue;
end;

function TNameInfo.GetAlignment: TAlignment;
begin
  Result := L_InfoText.Alignment;
end;

procedure TNameInfo.SetText (pValue: string);
begin
  L_InfoText.Caption := pValue;
end;

function TNameInfo.GetText: string;
begin
  Result := L_InfoText.Caption;
end;

procedure TNameInfo.SetColor (pValue: TColor);
begin
  L_InfoText.Color := pValue;
end;

function TNameInfo.GetColor: TColor;
begin
  Result := L_InfoText.Color;
end;

procedure TNameInfo.SetFont (pValue: TFont);
begin
  L_InfoText.Font := pValue;
end;

function TNameInfo.GetFont: TFont;
begin
  Result := L_InfoText.Font;
end;

// *********** Informacne pole pre cele cisla ************
constructor TLongInfo.Create (AOwner:TComponent);
begin
  inherited Create (AOwner);
  Width := 50;
  L_InfoText.Alignment := taRightJustify;
  L_InfoText.Caption := '0';
end;

procedure TLongInfo.SetLong (pValue: longint);
begin
  L_InfoText.ValueInt := pValue;
end;

function TLongInfo.GetLong: longint;
begin
  Result := L_InfoText.ValueInt;
end;

// *********** Informacne pole pre datum ************
constructor TDateInfo.Create (AOwner:TComponent);
begin
  inherited Create (AOwner);
  Width := 70;
  L_InfoText.Alignment := taRightJustify;
  SetDate (Date);
end;

procedure TDateInfo.SetDate (pValue: TDateTime);
begin
  oDate := pValue;
  If oDAte=0
    then L_InfoText.Caption := ''
    else L_InfoText.Caption := DateToStr(pValue);
end;

function TDateInfo.GetDate: TDateTime;
begin
  Result := oDate;
end;

// *********** Informacne pole pre cas ************
constructor TTimeInfo.Create (AOwner:TComponent);
begin
  inherited Create (AOwner);
  Width := 55;
  L_InfoText.Alignment := taRightJustify;
  SetTime (Now)
end;

procedure TTimeInfo.SetTime (pValue: TDateTime);
begin
  oTime := pValue;
  L_InfoText.Caption := TimeToStr(pValue);
end;

function TTimeInfo.GetTime: TDateTime;
begin
  Result := oTime;
end;

// *********** Informacne pole pre hodnotu *********
constructor TValueInfo.Create (AOwner:TComponent);
begin
  inherited Create (AOwner);
  Width := 110;
  Height := 20;
  BevelOuter := bvLowered;
  BorderWidth := 3;
  oFract := 2;

  L_Value := TSpecLabel.Create (Self);
  L_Value.Parent := Self;
  L_Value.Align := alClient;
  L_Value.AutoSize := TRUE;
  L_Value.Alignment := taRightJustify;
  L_Value.Layout := tlCenter;
  L_Value.Font.Color := clNavy;
  L_Value.Font.Style := [fsBold];
  L_Value.Font.Name := gvSys.EditFontName;
  L_Value.Font.Size := gvSys.EditFontSize;

  L_Extend := TSpecLabel.Create (Self);
  L_Extend.Parent := Self;
  L_Extend.Align := alRight;
  L_Extend.Alignment := taLeftJustify;
  L_Extend.Layout := tlCenter;
  L_Extend.Font.Name := gvSys.EditFontName;
  L_Extend.Font.Size := gvSys.EditFontSize;

  SetValue (0);
  Extend := ctIntCoin;
end;

destructor TValueInfo.Destroy;
begin
  L_Value.Free;
  L_Extend.Free;
  inherited;
end;

procedure TValueInfo.Loaded;
begin
  inherited;
//  Extend := ctIntCoin;
end;

procedure TValueInfo.SetValue (pValue: double);
begin
  oValue := pValue;
  L_Value.Caption := StrRealSepar (pValue,0,oFract,TRUE);
//  StrDoub(pValue,0,oFract)
end;

procedure TValueInfo.SetText (pValue: string);
begin
  L_Value.Caption := pValue;
end;

function TValueInfo.GetText: string;
begin
  Result := L_Value.Caption;
end;

procedure TValueInfo.SetExtend (pValue: string);
begin
  If pValue<>'' then begin
    If pValue[1]<>' '
      then L_Extend.Caption := ' '+pValue
      else L_Extend.Caption := pValue;
  end;    
end;

function TValueInfo.GetExtend: string;
begin
  Result := L_Extend.Caption;
end;

procedure TValueInfo.SetColor (pValue: TColor);
begin
  L_Value.Color := pValue;
end;

function TValueInfo.GetColor: TColor;
begin
  Result := L_Value.Color;
end;

procedure TValueInfo.SetFont (pValue: TFont);
begin
  L_Value.Font := pValue;
end;

function TValueInfo.GetFont: TFont;
begin
  Result := L_Value.Font;
end;

procedure TValueInfo.SetFract(pValue:byte);
begin
  oFract := pValue;
  L_Value.Caption := StrRealSepar (Value,0,oFract,TRUE);
end;

// *********** Informacne pole pre cenu *********
constructor TPriceInfo.Create (AOwner:TComponent);
begin
  inherited Create (AOwner);
  SetValue (0);
  IntCoin := ctIntCoin;
  Measure := ctMeasure;
end;

procedure TPriceInfo.Loaded;
begin
  IntCoin := ctIntCoin;
  Measure := ctMeasure;
end;

procedure TPriceInfo.SetIntCoin(pValue:string);
begin
  oIntCoin := pValue;
  Extend := oIntCoin+'/'+oMeasure;
end;

function TPriceInfo.GetIntCoin: string;
begin
  Result := oIntCoin;
end;

procedure TPriceInfo.SetMeasure(pValue:string);
begin
  oMeasure := pValue;
  Extend := oIntCoin+'/'+oMeasure;
end;

function TPriceInfo.GetMeasure: string;
begin
  Result := oMeasure;
end;

// *********** Informacne pole pre mnozstva *********
constructor TQuantInfo.Create (AOwner:TComponent);
begin
  inherited Create (AOwner);
  Fract := 3;
  SetValue (0);
  SetExtend (ctMeasure);
end;

// *** Informacne pole pre percentualnej hodnoty ****
constructor TPrcInfo.Create (AOwner:TComponent);
begin
  inherited Create (AOwner);
  Width := 60;
  SetValue (0);
  SetExtend ('%');
end;


//***************************************************
procedure Register;
begin
  RegisterComponents('IcInfoFields', [TNameInfo]);
  RegisterComponents('IcInfoFields', [TLongInfo]);
  RegisterComponents('IcInfoFields', [TDateInfo]);
  RegisterComponents('IcInfoFields', [TTimeInfo]);
  RegisterComponents('IcInfoFields', [TValueInfo]);
  RegisterComponents('IcInfoFields', [TPriceInfo]);
  RegisterComponents('IcInfoFields', [TQuantInfo]);
  RegisterComponents('IcInfoFields', [TPrcInfo]);
end;

end.
