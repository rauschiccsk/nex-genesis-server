unit NwInfoFields;

interface

uses
  BarCode, IcDate, Variants, TxtCut, NexText, IcLabels, IcEditors,
  IcTypes, IcConv, IcTools, IcText, IcVariab, IcStand, CmpTools, NexBtrTable,
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls, ExtCtrls, ComCtrls, Buttons;

type
  // **************** INFO pole textu *********************
  TNwNameInfo = class(TWinControl)
  private
    oCharCount: integer;  // Maximalny pocet znakov
    oValue: TLabel;
    oBorder: TShape;
    procedure SetCharCount (pValue: integer);
    procedure SetAlignment (pValue:TAlignment);
    function  GetAlignment: TAlignment;
    procedure SetText(pValue: ShortString);
    function  GetText: ShortString;
    procedure SetBorderColor(pValue: TColor);
    function  GetBorderColor: TColor;
    procedure SetColor(pValue: TColor);
    function  GetColor: TColor;
    procedure SetFont(pValue: TFont);
    function  GetFont: TFont;
  public
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
  published
    property CharCount: integer read oCharCount write SetCharCount;
    property Alignment: TAlignment read GetAlignment write SetAlignment;
    property Text: ShortString read GetText write SetText;
    property BorderColor: TColor read GetBorderColor write SetBorderColor;
    property Color: TColor read GetColor write SetColor;
    property Font: TFont read GetFont write SetFont;
    property Visible;
    property TabOrder;
    property Anchors;
  end;

  // **************** INFO pole cisla *********************
  TNwNumInfo = class(TWinControl)
  private
    oCharCount: integer;  // Maximalny pocet znakov
    oValue: TNumLabel;
    oBorder: TShape;
    procedure SetCharCount (pValue: integer);
    procedure SetAlignment (pValue:TAlignment);
    function  GetAlignment: TAlignment;
    procedure SetLong(pValue: integer);
    function  GetLong: integer;
    procedure SetDoub(pValue: double);
    function  GetDoub: double;
    procedure SetFract(pValue: byte);
    function  GetFract: byte;
    procedure SetBorderColor(pValue: TColor);
    function  GetBorderColor: TColor;
    procedure SetColor(pValue: TColor);
    function  GetColor: TColor;
    procedure SetFont(pValue: TFont);
    function  GetFont: TFont;
  public
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
  published
    property CharCount: integer read oCharCount write SetCharCount;
    property Alignment: TAlignment read GetAlignment write SetAlignment;
    property Long: integer read GetLong write SetLong;
    property Doub: double read GetDoub write SetDoub;
    property Value: double read GetDoub write SetDoub;
    property Fract: byte read GetFract write SetFract;
    property BorderColor: TColor read GetBorderColor write SetBorderColor;
    property Color: TColor read GetColor write SetColor;
    property Font: TFont read GetFont write SetFont;
    property Visible;
    property TabOrder;
    property Anchors;
  end;

procedure Register;

implementation

//***************** TNwNameInfo *******************
constructor TNwNameInfo.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  oCharCount := 30;
  Width := 220;
  Height := 17;
  TabStop := FALSE;

  oBorder := TShape.Create (Self);
  oBorder.Parent := Self;
  oBorder.Align := alClient;
  oBorder.Pen.Color := clBackground;
  oBorder.Brush.Color := $00FFEFDF;

  oValue := TLabel.Create (Self);
  oValue.Parent := Self;
  oValue.Top := 1;
  oValue.Left := 3;
  oValue.Width := 214;
  oValue.Height := 15;
  oValue.Anchors := [akTop,akBottom,akLeft,akRight];
  oValue.AutoSize := FALSE;
  oValue.Color := $00FFEFDF;
  oValue.Font.Color := clActiveCaption;
  oValue.Font.Name := 'Courier New';
  oValue.Font.Size := 10;
  oValue.Font.Style := [fsBold]
end;

destructor TNwNameInfo.Destroy;
begin
  FreeAndNil (oBorder);
  FreeAndNil (oValue);
  inherited;
end;

procedure TNwNameInfo.SetCharCount (pValue: integer);
begin
  oCharCount := pValue;
  If oCharCount>0 then begin
    Width := 8*oCharCount+7;
    RecreateWnd;
  end;
end;

procedure TNwNameInfo.SetAlignment (pValue: TAlignment);
begin
  oValue.Alignment := pValue;
end;

function  TNwNameInfo.GetAlignment: TAlignment;
begin
  Result := oValue.Alignment;
end;

procedure TNwNameInfo.SetText(pValue: ShortString);
begin
  oValue.Caption := pValue;
end;

function  TNwNameInfo.GetText: ShortString;
begin
  Result := oValue.Caption;
end;

procedure TNwNameInfo.SetBorderColor(pValue: TColor);
begin
  oBorder.Pen.Color := pValue;
end;

function  TNwNameInfo.GetBorderColor: TColor;
begin
  Result := oBorder.Pen.Color;
end;

procedure TNwNameInfo.SetColor(pValue: TColor);
begin
  oBorder.Brush.Color := pValue;
  oValue.Color := pValue;
end;

function  TNwNameInfo.GetColor: TColor;
begin
  Result := oValue.Color;
end;

procedure TNwNameInfo.SetFont(pValue: TFont);
begin
  oValue.Font := pValue;
end;

function  TNwNameInfo.GetFont: TFont;
begin
  Result := oValue.Font;
end;

//***************** TNwNumInfo *******************
constructor TNwNumInfo.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  oCharCount := 5;
  Width := 40;
  Height := 17;
  TabStop := FALSE;

  oBorder := TShape.Create (Self);
  oBorder.Parent := Self;
  oBorder.Align := alClient;
  oBorder.Pen.Color := clBackground;
  oBorder.Brush.Color := $00FFEFDF;

  oValue := TNumLabel.Create (Self);
  oValue.Parent := Self;
  oValue.Top := 1;
  oValue.Left := 3;
  oValue.Width := 34;
  oValue.Height := 15;
  oValue.Anchors := [akTop,akBottom,akLeft,akRight];
  oValue.AutoSize := FALSE;
  oValue.Color := $00FFEFDF;
  oValue.Alignment := taRightJustify;
  oValue.Font.Color := clActiveCaption;
  oValue.Font.Name := 'Courier New';
  oValue.Font.Size := 10;
  oValue.Font.Style := [fsBold];
  oValue.Fract := 0;
  oValue.Long := 0;
end;

destructor TNwNumInfo.Destroy;
begin
  FreeAndNil (oBorder);
  FreeAndNil (oValue);
  inherited;
end;

procedure TNwNumInfo.SetCharCount (pValue: integer);
begin
  oCharCount := pValue;
  If oCharCount>0 then begin
    Width := 8*oCharCount+7;
    RecreateWnd;
  end;
end;

procedure TNwNumInfo.SetAlignment (pValue: TAlignment);
begin
  oValue.Alignment := pValue;
end;

function  TNwNumInfo.GetAlignment: TAlignment;
begin
  Result := oValue.Alignment;
end;

procedure TNwNumInfo.SetLong(pValue: integer);
begin
  oValue.Long := pValue;
end;

function  TNwNumInfo.GetLong: integer;
begin
  Result := oValue.Long;
end;

procedure TNwNumInfo.SetDoub(pValue: double);
begin
  oValue.ValueDoub := pValue;
end;

function  TNwNumInfo.GetDoub: double;
begin
  Result := oValue.ValueDoub;
end;

procedure TNwNumInfo.SetFract(pValue: byte);
begin
  oValue.Fract := pValue;
end;

function  TNwNumInfo.GetFract: byte;
begin
  Result := oValue.Fract;
end;

procedure TNwNumInfo.SetBorderColor(pValue: TColor);
begin
  oBorder.Pen.Color := pValue;
end;

function  TNwNumInfo.GetBorderColor: TColor;
begin
  Result := oBorder.Pen.Color;
end;

procedure TNwNumInfo.SetColor(pValue: TColor);
begin
  oBorder.Brush.Color := pValue;
  oValue.Color := pValue;
end;

function  TNwNumInfo.GetColor: TColor;
begin
  Result := oValue.Color;
end;

procedure TNwNumInfo.SetFont(pValue: TFont);
begin
  oValue.Font := pValue;
end;

function  TNwNumInfo.GetFont: TFont;
begin
  Result := oValue.Font;
end;


// ********************** Register ************************
procedure Register;
begin
  RegisterComponents('NwInfoField', [TNwNameInfo]);
  RegisterComponents('NwInfoField', [TNwNumInfo]);
end;

end.
