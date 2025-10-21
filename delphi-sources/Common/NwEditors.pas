unit NwEditors;

interface

uses
  BarCode, IcDate, Variants, TxtCut, NexText, IcLabels, IcEditors,
  IcTypes, IcConv, IcTools, IcText, IcVariab, IcStand, CmpTools, NexBtrTable,
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls, ExtCtrls, ComCtrls, Buttons;

type
  // **************** Editor textu *********************
  TNwNameEdit = class(TWinControl)
  private
    oEditor: TNameEdit;
    oBorder: TShape;
    oStatusLine: TStatusLine;
    eOnEnter: TNotifyEvent;
    eOnKeyDown: TKeyEvent;
    eOnChanged: TNotifyEvent;
    procedure SetText(pValue: ShortString);
    function  GetText: ShortString;
    procedure SetBorderColor(pValue: TColor);
    function  GetBorderColor: TColor;
    procedure SetMaxLength(pValue: integer);
    function  GetMaxLength: integer;
    procedure SetColor(pValue: TColor);
    function  GetColor: TColor;
    procedure SetFont(pValue: TFont);
    function  GetFont: TFont;
    procedure SetCharCase(pValue: TEditCharCase);
    function  GetCharCase: TEditCharCase;
    function  GetChanged: boolean;
    procedure MyKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure MyOnEnter (Sender: TObject);
  public
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
    procedure SetFocus; override;
  published
    property Text: ShortString read GetText write SetText;
    property StatusLine: TStatusLine read oStatusLine write oStatusLine;
    property BorderColor: TColor read GetBorderColor write SetBorderColor;
    property MaxLength: integer read GetMaxLength write SetMaxLength;
    property Color: TColor read GetColor write SetColor;
    property Font: TFont read GetFont write SetFont;
    property Changed: boolean read GetChanged;
    property CharCase: TEditCharCase read GetCharCase write SetCharCase;
    property Enabled;
    property TabOrder;
    property Anchors;
    property Visible;

    {Events}
    property OnExit;
    property OnEnter: TNotifyEvent read eOnEnter write eOnEnter;
    property OnKeyDown: TKeyEvent read eOnKeyDown write eOnKeyDown;
  end;

  // **************** Editor celeho cisla *********************
  TNwLongEdit = class(TWinControl)
  private
    oEditor: TLongEdit;
    oBorder: TShape;
    oStatusLine: TStatusLine;
    eOnEnter: TNotifyEvent;
    eOnKeyDown: TKeyEvent;
    eOnChanged: TNotifyEvent;
    procedure SetLong(pValue: longint);
    function  GetLong: longint;
    procedure SetBorderColor(pValue: TColor);
    function  GetBorderColor: TColor;
    procedure SetMaxLength(pValue: integer);
    function  GetMaxLength: integer;
    procedure SetColor(pValue: TColor);
    function  GetColor: TColor;
    procedure SetFont(pValue: TFont);
    function  GetFont: TFont;
    function  GetChanged: boolean;
    procedure MyKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure MyOnEnter (Sender: TObject);
  public
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
    procedure SetFocus; override;
  published
    property Long: longint read GetLong write SetLong;
    property StatusLine: TStatusLine read oStatusLine write oStatusLine;
    property BorderColor: TColor read GetBorderColor write SetBorderColor;
    property MaxLength: integer read GetMaxLength write SetMaxLength;
    property Color: TColor read GetColor write SetColor;
    property Font: TFont read GetFont write SetFont;
    property Changed: boolean read GetChanged;
    property Enabled;
    property TabOrder;
    property Anchors;
    {Events}
    property OnExit;
    property OnEnter: TNotifyEvent read eOnEnter write eOnEnter;
    property OnKeyDown: TKeyEvent read eOnKeyDown write eOnKeyDown;
  end;

  // **************** Editor datumu *********************
  TNwDateEdit = class(TWinControl)
  private
    oEditor: TDateEdit;
    oBorder: TShape;
    oStatusLine: TStatusLine;
    eOnEnter: TNotifyEvent;
    eOnKeyDown: TKeyEvent;
    eOnChanged: TNotifyEvent;
    procedure SetDate(pValue: TDateTime);
    function  GetDate: TDateTime;
    procedure SetBorderColor(pValue: TColor);
    function  GetBorderColor: TColor;
    procedure SetColor(pValue: TColor);
    function  GetColor: TColor;
    procedure SetFont(pValue: TFont);
    function  GetFont: TFont;
    function  GetChanged: boolean;
    procedure MyKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure MyOnEnter (Sender: TObject);
  public
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
    procedure SetFocus; override;
  published
    property Date: TDateTime read GetDate write SetDate;
    property StatusLine: TStatusLine read oStatusLine write oStatusLine;
    property BorderColor: TColor read GetBorderColor write SetBorderColor;
    property Color: TColor read GetColor write SetColor;
    property Font: TFont read GetFont write SetFont;
    property Changed: boolean read GetChanged;
    property Enabled;
    property TabOrder;
    property Anchors;
    {Events}
    property OnExit;
    property OnEnter: TNotifyEvent read eOnEnter write eOnEnter;
    property OnKeyDown: TKeyEvent read eOnKeyDown write eOnKeyDown;
  end;

  // ************* Editor hodnoty s rozsirenym textom ****************
  TNwValueEdit = class(TWinControl)
  private
    oEditor: TDoubEdit;
    oBorder: TShape;
    oExtend: TLabel;
    oDvzName: Str3;
    oMsName: Str10;
    oCharCount: byte;
    oStatusLine: TStatusLine;
    eOnEnter: TNotifyEvent;
    eOnKeyDown: TKeyEvent;
    eOnChanged: TNotifyEvent;
    procedure SetCharCount (pValue: byte);
    procedure SetValue(pValue: double);
    function  GetValue: double;
    procedure SetFract(pValue: byte);
    function  GetFract: byte;
    procedure SetExtend(pValue: Str15);
    function  GetExtend: Str15;
    procedure SetBorderColor(pValue: TColor);
    function  GetBorderColor: TColor;
    procedure SetMaxLength(pValue: integer);
    function  GetMaxLength: integer;
    procedure SetColor(pValue: TColor);
    function  GetColor: TColor;
    procedure SetFont(pValue: TFont);
    function  GetFont: TFont;
    procedure MyKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure MyOnEnter (Sender: TObject);
  public
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
    procedure SetFocus; override;
    procedure ResizeEditor; // Zmeni velkost editoru
    procedure Undo;
  published
    property CharCount: byte read oCharCount write SetCharCount;
    property Value: double read GetValue write SetValue;
    property Fract: byte read GetFract write SetFract;
    property Extend: Str15 read GetExtend write SetExtend;
    property StatusLine: TStatusLine read oStatusLine write oStatusLine;
    property BorderColor: TColor read GetBorderColor write SetBorderColor;
    property MaxLength: integer read GetMaxLength write SetMaxLength;
    property Color: TColor read GetColor write SetColor;
    property Font: TFont read GetFont write SetFont;
    property Enabled;
    property TabOrder;
    property Anchors;
    {Events}
    property OnExit;
    property OnEnter: TNotifyEvent read eOnEnter write eOnEnter;
    property OnKeyDown: TKeyEvent read eOnKeyDown write eOnKeyDown;
  end;

  // **************** Editor datumu *********************
  TNwTimeEdit = class(TWinControl)
  private
    oEditor: TTimeEdit2;
    oBorder: TShape;
    oStatusLine: TStatusLine;
    eOnEnter: TNotifyEvent;
    eOnKeyDown: TKeyEvent;
    eOnChanged: TNotifyEvent;
    procedure SetTime(pValue: TDateTime);
    function  GetTime: TDateTime;
    procedure SetBorderColor(pValue: TColor);
    function  GetBorderColor: TColor;
    procedure SetColor(pValue: TColor);
    function  GetColor: TColor;
    procedure SetFont(pValue: TFont);
    function  GetFont: TFont;
    function  GetChanged: boolean;
    procedure MyKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure MyOnEnter (Sender: TObject);
  public
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
    procedure SetFocus; override;
  published
    property Time: TDateTime read GetTime write SetTime;
    property StatusLine: TStatusLine read oStatusLine write oStatusLine;
    property BorderColor: TColor read GetBorderColor write SetBorderColor;
    property Color: TColor read GetColor write SetColor;
    property Font: TFont read GetFont write SetFont;
    property Changed: boolean read GetChanged;
    property Enabled;
    property TabOrder;
    property Anchors;
    {Events}
    property OnExit;
    property OnEnter: TNotifyEvent read eOnEnter write eOnEnter;
    property OnKeyDown: TKeyEvent read eOnKeyDown write eOnKeyDown;
  end;


procedure Register;

implementation

//***************** TNwNameEdit *******************
constructor TNwNameEdit.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  inherited OnEnter := MyOnEnter;
  Width := 220;
  Height := 17;

  oEditor := TNameEdit.Create (Self);
  oEditor.Parent := Self;
  oEditor.Top := 1;
  oEditor.Left := 1;
  oEditor.Width := 218;
  oEditor.Height := 15;
  oEditor.BorderStyle := bsNone;
  oEditor.Anchors := [akTop,akBottom,akLeft,akRight];
  oEditor.Font.Name := 'Courier New';
  oEditor.Font.Size := 9;
  oEditor.OnKeyDown := MyKeyDown;

  oBorder := TShape.Create (Self);
  oBorder.Parent := Self;
  oBorder.Align := alClient;
  oBorder.Pen.Color := clBackground;
end;

destructor TNwNameEdit.Destroy;
begin
  FreeAndNil (oBorder);
  FreeAndNil (oEditor);
  inherited;
end;

procedure TNwNameEdit.SetFocus;
begin
  oEditor.SetFocus;
  oEditor.SelectAll;
end;

procedure TNwNameEdit.SetText(pValue: ShortString);
begin
  oEditor.Text := pValue;
end;

function  TNwNameEdit.GetText: ShortString;
begin
  Result := oEditor.Text
end;

procedure TNwNameEdit.SetBorderColor(pValue: TColor);
begin
  oBorder.Pen.Color := pValue;
end;

function  TNwNameEdit.GetBorderColor: TColor;
begin
  Result := oBorder.Pen.Color;
end;

procedure TNwNameEdit.SetMaxLength(pValue: integer);
begin
  oEditor.MaxLength := pValue;
end;

function  TNwNameEdit.GetMaxLength: integer;
begin
  Result := oEditor.MaxLength;
end;

procedure TNwNameEdit.SetColor(pValue: TColor);
begin
  oEditor.Color := pValue;
end;

function  TNwNameEdit.GetColor: TColor;
begin
  Result := oEditor.Color;
end;

procedure TNwNameEdit.SetFont(pValue: TFont);
begin
  oEditor.Font := pValue;
end;

function  TNwNameEdit.GetFont: TFont;
begin
  Result := oEditor.Font;
end;

procedure TNwNameEdit.SetCharCase(pValue: TEditCharCase);
begin
  oEditor.CharCase := pValue;
end;

function  TNwNameEdit.GetCharCase: TEditCharCase;
begin
  Result := oEditor.CharCase;
end;

function  TNwNameEdit.GetChanged: boolean;
begin
  Result := oEditor.Changed;
end;

procedure TNwNameEdit.MyKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
begin
//  If (Key=VK_RETURN) or (Key=VK_DOWN) or (Key=VK_UP) or (Key=VK_END) then SetCode (E_Code.Text);
  If Assigned (eOnKeyDown) then eOnKeyDown (Sender,Key,Shift);
end;

procedure TNwNameEdit.MyOnEnter (Sender: TObject);
begin
  If oStatusLine<>nil then begin
    oStatusLine.TabPosition := TabOrder;
    oStatusLine.CursorPosition := 0;
    oStatusLine.Description := Hint;
  end;
  If Assigned (eOnEnter) then eOnEnter (Sender);
end;

//***************** TNwLongEdit *******************
constructor TNwLongEdit.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  inherited OnEnter := MyOnEnter;
  Width := 40;
  Height := 17;

  oEditor := TLongEdit.Create (Self);
  oEditor.Parent := Self;
  oEditor.Top := 1;
  oEditor.Left := 1;
  oEditor.Width := 38;
  oEditor.Height := 15;
  oEditor.BorderStyle := bsNone;
  oEditor.Anchors := [akTop,akBottom,akLeft,akRight];
  oEditor.Font.Name := 'Courier New';
  oEditor.Font.Size := 9;
  oEditor.OnKeyDown := MyKeyDown;

  oBorder := TShape.Create (Self);
  oBorder.Parent := Self;
  oBorder.Align := alClient;
  oBorder.Pen.Color := clBackground;
end;

destructor TNwLongEdit.Destroy;
begin
  FreeAndNil (oBorder);
  FreeAndNil (oEditor);
  inherited;
end;

procedure TNwLongEdit.SetFocus;
begin
  oEditor.SetFocus;
  oEditor.SelectAll;
end;

procedure TNwLongEdit.SetLong(pValue: longint);
begin
  oEditor.Long := pValue;
end;

function  TNwLongEdit.GetLong: longint;
begin
  Result := oEditor.Long;
end;

procedure TNwLongEdit.SetBorderColor(pValue: TColor);
begin
  oBorder.Pen.Color := pValue;
end;

function  TNwLongEdit.GetBorderColor: TColor;
begin
  Result := oBorder.Pen.Color;
end;

procedure TNwLongEdit.SetMaxLength(pValue: integer);
begin
  oEditor.MaxLength := pValue;
end;

function  TNwLongEdit.GetMaxLength: integer;
begin
  Result := oEditor.MaxLength;
end;

procedure TNwLongEdit.SetColor(pValue: TColor);
begin
  oEditor.Color := pValue;
end;

function  TNwLongEdit.GetColor: TColor;
begin
  Result := oEditor.Color;
end;

procedure TNwLongEdit.SetFont(pValue: TFont);
begin
  oEditor.Font := pValue;
end;

function  TNwLongEdit.GetFont: TFont;
begin
  Result := oEditor.Font;
end;

function  TNwLongEdit.GetChanged: boolean;
begin
  Result := oEditor.Changed;
end;

procedure TNwLongEdit.MyKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
begin
//  If (Key=VK_RETURN) or (Key=VK_DOWN) or (Key=VK_UP) or (Key=VK_END) then SetCode (E_Code.Text);
  If Assigned (eOnKeyDown) then eOnKeyDown (Sender,Key,Shift);
end;

procedure TNwLongEdit.MyOnEnter (Sender: TObject);
begin
  If oStatusLine<>nil then begin
    oStatusLine.TabPosition := TabOrder;
    oStatusLine.CursorPosition := 0;
    oStatusLine.Description := Hint;
  end;
  If Assigned (eOnEnter) then eOnEnter (Sender);
end;

//***************** TNwDateEdit *******************
constructor TNwDateEdit.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  inherited OnEnter := MyOnEnter;
  Width := 66;
  Height := 17;

  oEditor := TDateEdit.Create (Self);
  oEditor.Parent := Self;
  oEditor.Top := 1;
  oEditor.Left := 1;
  oEditor.Width := 64;
  oEditor.Height := 15;
  oEditor.BorderStyle := bsNone;
  oEditor.Anchors := [akTop,akBottom,akLeft,akRight];
  oEditor.Font.Name := 'Courier New';
  oEditor.Font.Size := 9;
  oEditor.OnKeyDown := MyKeyDown;

  oBorder := TShape.Create (Self);
  oBorder.Parent := Self;
  oBorder.Align := alClient;
  oBorder.Pen.Color := clBackground;
end;

destructor TNwDateEdit.Destroy;
begin
  FreeAndNil (oBorder);
  FreeAndNil (oEditor);
  inherited;
end;

procedure TNwDateEdit.SetFocus;
begin
  oEditor.SetFocus;
  oEditor.SelectAll;
end;

procedure TNwDateEdit.SetDate(pValue: TDateTime);
begin
  oEditor.Date := pValue;
end;

function  TNwDateEdit.GetDate: TDateTime;
begin
  Result := oEditor.Date;
end;

procedure TNwDateEdit.SetBorderColor(pValue: TColor);
begin
  oBorder.Pen.Color := pValue;
end;

function  TNwDateEdit.GetBorderColor: TColor;
begin
  Result := oBorder.Pen.Color;
end;

procedure TNwDateEdit.SetColor(pValue: TColor);
begin
  oEditor.Color := pValue;
end;

function  TNwDateEdit.GetColor: TColor;
begin
  Result := oEditor.Color;
end;

procedure TNwDateEdit.SetFont(pValue: TFont);
begin
  oEditor.Font := pValue;
end;

function  TNwDateEdit.GetFont: TFont;
begin
  Result := oEditor.Font;
end;

function  TNwDateEdit.GetChanged: boolean;
begin
  Result := oEditor.Changed;
end;

procedure TNwDateEdit.MyKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
begin
  If Assigned (eOnKeyDown) then eOnKeyDown (Sender,Key,Shift);
end;

procedure TNwDateEdit.MyOnEnter (Sender: TObject);
begin
  If oStatusLine<>nil then begin
    oStatusLine.TabPosition := TabOrder;
    oStatusLine.CursorPosition := 0;
    oStatusLine.Description := Hint;
  end;
  If Assigned (eOnEnter) then eOnEnter (Sender);
end;

//***************** TNwTimeEdit *******************
constructor TNwTimeEdit.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  inherited OnEnter := MyOnEnter;
  Width := 66;
  Height := 17;

  oEditor := TTimeEdit2.Create (Self);
  oEditor.Parent := Self;
  oEditor.Top := 1;
  oEditor.Left := 1;
  oEditor.Width := 64;
  oEditor.Height := 15;
  oEditor.BorderStyle := bsNone;
  oEditor.Anchors := [akTop,akBottom,akLeft,akRight];
  oEditor.Font.Name := 'Courier New';
  oEditor.Font.Size := 9;
  oEditor.OnKeyDown := MyKeyDown;

  oBorder := TShape.Create (Self);
  oBorder.Parent := Self;
  oBorder.Align := alClient;
  oBorder.Pen.Color := clBackground;
end;

destructor TNwTimeEdit.Destroy;
begin
  FreeAndNil (oBorder);
  FreeAndNil (oEditor);
  inherited;
end;

procedure TNwTimeEdit.SetFocus;
begin
  oEditor.SetFocus;
  oEditor.SelectAll;
end;

procedure TNwTimeEdit.SetTime(pValue: TDateTime);
begin
  oEditor.Time := pValue;
end;

function  TNwTimeEdit.GetTime: TDateTime;
begin
  Result := oEditor.Time;
end;

procedure TNwTimeEdit.SetBorderColor(pValue: TColor);
begin
  oBorder.Pen.Color := pValue;
end;

function  TNwTimeEdit.GetBorderColor: TColor;
begin
  Result := oBorder.Pen.Color;
end;

procedure TNwTimeEdit.SetColor(pValue: TColor);
begin
  oEditor.Color := pValue;
end;

function  TNwTimeEdit.GetColor: TColor;
begin
  Result := oEditor.Color;
end;

procedure TNwTimeEdit.SetFont(pValue: TFont);
begin
  oEditor.Font := pValue;
end;

function  TNwTimeEdit.GetFont: TFont;
begin
  Result := oEditor.Font;
end;

function  TNwTimeEdit.GetChanged: boolean;
begin
//  Result := oEditor.Changed;
end;

procedure TNwTimeEdit.MyKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
begin
  If Assigned (eOnKeyDown) then eOnKeyDown (Sender,Key,Shift);
end;

procedure TNwTimeEdit.MyOnEnter (Sender: TObject);
begin
  If oStatusLine<>nil then begin
    oStatusLine.TabPosition := TabOrder;
    oStatusLine.CursorPosition := 0;
    oStatusLine.Description := Hint;
  end;
  If Assigned (eOnEnter) then eOnEnter (Sender);
end;

//***************** TNwValueEdit *******************
constructor TNwValueEdit.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  inherited OnEnter := MyOnEnter;
  oCharCount := 11;
  Width := 90;
  Height := 17;

  oBorder := TShape.Create (Self);
  oBorder.Parent := Self;
  oBorder.Width := 90;
  oBorder.Height := 17;
  oBorder.Align := alClient;
  oBorder.Anchors := [akTop,akBottom,akLeft,akRight];
  oBorder.Pen.Color := clBackground;
(*
  oExtend := TLabel.Create (Self);
  oExtend.Parent := Self;
  oExtend.Top := 2;
  oExtend.Align := alRight;
  oExtend.Visible := FALSE;
  oExtend.Font.Name := 'Courier New';
  oExtend.Font.Size := 9;
//  oExtend.Anchors := [akTop,akBottom,akRight];
*)
  oEditor := TDoubEdit.Create (Self);
  oEditor.Parent := Self;
  oEditor.Top := 1;
  oEditor.Left := 1;
  oEditor.Width := oBorder.Width-2;
  oEditor.Height := 15;
  oEditor.BorderStyle := bsNone;
  oEditor.Anchors := [akTop,akBottom,akLeft,akRight];
  oEditor.Font.Name := 'Courier New';
  oEditor.Font.Size := 9;
  oEditor.OnKeyDown := MyKeyDown;

  oExtend := TLabel.Create (Self);
  oExtend.Parent := Self;
  oExtend.Top := 2;
  oExtend.Align := alRight;
  oExtend.Visible := FALSE;
  oExtend.Font.Name := 'Courier New';
  oExtend.Font.Size := 9;
//  oExtend.Anchors := [akTop,akBottom,akRight];
end;

destructor TNwValueEdit.Destroy;
begin
  FreeAndNil (oExtend);
  FreeAndNil (oBorder);
  FreeAndNil (oEditor);
  inherited;
end;

procedure TNwValueEdit.SetFocus;
begin
  oEditor.SetFocus;
  oEditor.SelectAll;
end;

procedure TNwValueEdit.ResizeEditor; // Zmeni velkost editoru
var mExtLen:byte;
begin
  mExtLen := Length(oExtend.Caption);
  oExtend.Visible := mExtLen>0;
  If oExtend.Visible then oExtend.Width   := 2+mExtLen*8;
  If oExtend.Visible
//     then Width := 2+8*oCharCount+6+mExtLen*8
     then Width := 2+8*oCharCount+2+mExtLen*8
     else Width := 2+8*oCharCount;
  oEditor.Width := oBorder.Width-2;
  RecreateWnd;
  Invalidate;
end;

procedure TNwValueEdit.Undo; 
begin
  oEditor.Undo;
end;

procedure TNwValueEdit.SetCharCount(pValue: byte);
begin
  oCharCount := pValue;
  ResizeEditor;
end;

procedure TNwValueEdit.SetValue(pValue: double);
begin
  oEditor.Value := pValue;
end;

function  TNwValueEdit.GetValue: double;
begin
  Result := oEditor.Value;
end;

procedure TNwValueEdit.SetFract(pValue: byte);
begin
  oEditor.Fract := pValue;
end;

function  TNwValueEdit.GetFract: byte;
begin
  Result := oEditor.Fract;
end;

procedure TNwValueEdit.SetExtend(pValue: Str15);
begin
  oExtend.Caption := pValue;
  ResizeEditor;
end;

function  TNwValueEdit.GetExtend: Str15;
begin
  Result := oExtend.Caption;
end;

procedure TNwValueEdit.SetBorderColor(pValue: TColor);
begin
  oBorder.Pen.Color := pValue;
end;

function  TNwValueEdit.GetBorderColor: TColor;
begin
  Result := oBorder.Pen.Color;
end;

procedure TNwValueEdit.SetMaxLength(pValue: integer);
begin
  oEditor.MaxLength := pValue;
  ResizeEditor;
end;

function  TNwValueEdit.GetMaxLength: integer;
begin
  Result := oEditor.MaxLength;
end;

procedure TNwValueEdit.SetColor(pValue: TColor);
begin
  oEditor.Color := pValue;
end;

function  TNwValueEdit.GetColor: TColor;
begin
  Result := oEditor.Color;
end;

procedure TNwValueEdit.SetFont(pValue: TFont);
begin
  oEditor.Font := pValue;
end;

function  TNwValueEdit.GetFont: TFont;
begin
  Result := oEditor.Font;
end;

procedure TNwValueEdit.MyKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
begin
//  If (Key=VK_RETURN) or (Key=VK_DOWN) or (Key=VK_UP) or (Key=VK_END) then SetCode (E_Code.Text);
  If Assigned (eOnKeyDown) then eOnKeyDown (Sender,Key,Shift);
end;

procedure TNwValueEdit.MyOnEnter (Sender: TObject);
begin
  If oStatusLine<>nil then begin
    oStatusLine.TabPosition := TabOrder;
    oStatusLine.CursorPosition := 0;
    oStatusLine.Description := Hint;
  end;
  If Assigned (eOnEnter) then eOnEnter (Sender);
end;


// ********************** Register ************************
procedure Register;
begin
  RegisterComponents('NwEditors', [TNwNameEdit]);
  RegisterComponents('NwEditors', [TNwLongEdit]);
  RegisterComponents('NwEditors', [TNwDateEdit]);
  RegisterComponents('NwEditors', [TNwValueEdit]);
  RegisterComponents('NwEditors', [TNwTimeEdit]);
end;

end.
