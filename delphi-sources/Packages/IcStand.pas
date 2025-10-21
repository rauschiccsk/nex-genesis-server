unit IcStand; //01.07.2000

interface

uses
  IcVariab, IcConv, CmpTools,
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  ExtCtrls, StdCtrls, DbCtrls, ComCtrls;

type
  // Dinamicky panel - pre zmene rozmeru zmenia sa aj rzmery
  // komponentov nachadzajuce sa na tomto panely
  TDnPanelColorThemes = (acsDOS, acsStandard, acsRandom, acsCustom);

  TPanelSize = record
    rLeft: integer;
    rTop: integer;
    rWidth: integer;
    rHeight: integer;
    rFontSize: integer;
    rControl: TControl;
  end;

  TDinamicPanel = class(TPanel)
  private
    oWidth: integer;
    oHeight: integer;
    oRectList: TList;
    oColorThemes: TDnPanelColorThemes;
    oAutoExpand: boolean;
  protected
    procedure GumiPanelOnCreate(pForm: TComponent; pPanel: TPanel);
    procedure GumiPanelOnResize(pPanel:TPanel);
    procedure PanelResize(Sender: TObject);
    procedure PanelCanResize(Sender: TObject; var NewWidth, NewHeight: Integer; var Resize: Boolean);
    procedure SetColorThemes(Value: TDnPanelColorThemes);
    procedure SetAutoexpand(Value: boolean);
    procedure AddList(pComponent: TComponent);
  public
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
  published
    property ColorThemes: TDnPanelColorThemes read oColorThemes write SetColorThemes;
    property AutoExpand: boolean read oAutoExpand write SetAutoexpand;
  end;

  // Hlavickovy panel
  THeadPanel = class(TCustomPanel)
    oHead: TLabel;
    oBody: TShape;
  private
    procedure SetHeadText (pValue:string);
    function GetHeadText: string;
    procedure SetHeadColor (pValue:TColor);
    function GetHeadColor: TColor;
    procedure SetHeadFont (pValue:TFont);
    function GetHeadFont: TFont;
    procedure SetBodyColor (pValue:TColor);
    function GetBodyColor: TColor;
    procedure SetBorderWidth (pValue:byte);
    function GetBorderWidth: byte;
  public
    constructor Create (AOwner:TComponent); override;
    destructor Destroy; override;
  published
    property HeadText: string read GetHeadText write SetHeadText;
    property HeadColor: TColor read GetHeadColor write SetHeadColor;
    property HeadFont: TFont read GetHeadFont write SetHeadFont;
    property BorderWidth: byte read GetBorderWidth write SetBorderWidth;
    property BodyColor: TColor read GetBodyColor write SetBodyColor;
    property TabOrder;
    property Visible;
    property Anchors;
  end;

  //Stavovy riadok editacneho formulara
  TStatusLine = class (TStatusBar)
  private
    oTabPosition: word;
    oCursorPosition: word;
    oDescription: string;
    procedure ShowData;
    procedure SetTabPosition (pValue:word);
    procedure SetCursorPosition (pValue:word);
    procedure SetDescription (pValue:string);
  published
    constructor Create(AOwner: TComponent); override;
    property TabPosition: word read oTabPosition write SetTabPosition;
    property CursorPosition: word read oCursorPosition write SetCursorPosition;
    property Description: string read oDescription write SetDescription;
  end;

  // Sytemovy riadok
  TSystemLine = class (TPanel)
    procedure ShowData;
  private
  published
    constructor Create(AOwner: TComponent); override;
  end;

  // Bevel pre jednoriadkove informacie
  TSingleBevel = class(TBevel)
  published
    constructor Create(AOwner: TComponent); override;
  end;

  // Bevel pre dvojriadkove informacie
  TDoubleBevel = class(TBevel)
  published
    constructor Create(AOwner: TComponent); override;
  end;

  // Zapinacie/vypinacie pole
  TCheckButton = class(TCheckBox)
  published
    constructor Create(AOwner: TComponent); override;
  end;

  // Prepinacie (vyberove) pole
  TSelectButton = class(TRadioButton)
  published
    constructor Create(AOwner: TComponent); override;
  end;

  // Vyberovy editor IcComboBox
  TIcComboBox = class(TComboBox)
  private
    eOnEnter: TNotifyEvent;
    eOnExit: TNotifyEvent;
    eOnKeyDown: TKeyEvent;
    oStatusLine: TStatusLine;
    procedure MyOnEnter (Sender: TObject);
    procedure MyOnExit (Sender: TObject);
    procedure MyOnKeyDown (Sender: TObject; var Key: Word; Shift: TShiftState);
  protected
    procedure KeyDown(var Key: Word; Shift: TShiftState); override;
    procedure CreateParams(var Params: TCreateParams); override;
  public
    constructor Create(AOwner: TComponent); override;
  published
    property StatusLine: TStatusLine read oStatusLine write oStatusLine;
    property OnEnter: TNotifyEvent read eOnEnter write eOnEnter;
    property OnExit: TNotifyEvent read eOnExit write eOnExit;
  end;

procedure Register;

implementation

  uses IcEditors;


//***************** TDinamicpanel *******************
function  IsParent(pComponent, pParent:TComponent): boolean;
var mComponent: TComponent;
    mExit: boolean;
begin
  Result := FALSE;
  mComponent := pComponent;
  mExit := FALSE;
  while (mComponent is TControl) and not mExit do begin
    If (mComponent as TControl).Parent = nil then begin
      mExit := TRUE;
    end else If (mComponent as TControl).Parent = pParent then begin
      Result := TRUE;
      mExit := TRUE;
    end else begin
      mComponent := (mComponent as TControl).Parent;
    end;
    If (mComponent=pComponent) then mExit := TRUE;
  end;
end;

procedure TDinamicPanel.AddList(pComponent: TComponent);
var mRect: ^TPanelSize;
begin
  If pComponent is TControl then begin
    Getmem(mRect, Sizeof(TPanelSize));
    mRect^.rLeft    := (pComponent as TControl).Left;
    mRect^.rTop     := (pComponent as TControl).Top;
    mRect^.rWidth   := (pComponent as TControl).Width;
    mRect^.rHeight  := (pComponent as TControl).Height;
    mRect^.rControl := (pComponent as TControl);

    If (pComponent is TLabel)        then mRect^.rFontSize := (pComponent as TLabel).Font.Size else
    If (pComponent is TButton)       then mRect^.rFontSize := (pComponent as TButton).Font.Size else
    If (pComponent is TDBCheckBox)   then mRect^.rFontSize := (pComponent as TDBCheckBox).Font.Size else
    If (pComponent is TCheckBox)     then mRect^.rFontSize := (pComponent as TCheckBox).Font.Size else
    If (pComponent is TRadioButton)  then mRect^.rFontSize := (pComponent as TRadioButton).Font.Size else
    If (pComponent is TDBEdit)       then mRect^.rFontSize := (pComponent as TDBEdit).Font.Size else
    If (pComponent is TComboBox)     then mRect^.rFontSize := (pComponent as TComboBox).Font.Size else
    If (pComponent is TEdit)         then mRect^.rFontSize := (pComponent as TEdit).Font.Size else
    If (pComponent is TPanel)        then mRect^.rFontSize := (pComponent as TPanel).Font.Size else
    If (pComponent is TGroupBox)     then mRect^.rFontSize := (pComponent as TGroupBox).Font.Size else
    If (pComponent is TPageControl)  then mRect^.rFontSize := (pComponent as TPageControl).Font.Size else
    If (pComponent is TFLongEdit)    then mRect^.rFontSize := (pComponent as TFLongEdit).Font.Size else
    ;
    oRectList.Add(mRect);
  end;
end;

constructor TDinamicPanel.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  oRectList    := TList.Create;
  oAutoExpand  := FALSE;
  oColorThemes := acsStandard; //2000.5.3.
  If not Assigned(OnResize) then OnResize := PanelResize;
  If not Assigned(OnCanResize) then OnCanResize := PanelCanResize;
  Caption := ' '; //2000.5.3.
end;

destructor TDinamicPanel.Destroy;
begin
  oRectList.Free;
  inherited Destroy;
end;

procedure TDinamicPanel.SetAutoexpand(Value: boolean);
begin
  oAutoExpand := Value;
  oRectList.Clear;
  If oAutoExpand then GumiPanelOnCreate(self.Owner, self);
end;

procedure TDinamicPanel.SetColorThemes(Value: TDnPanelColorThemes);
var mForm: TForm;
    mPanelBG,mLabelFG,mEditBG,mEditFG,mHeadBG,
    mHeadFG,mGroupBoxBG,mGroupBoxFG: TColor;
    I: integer;
begin
  oColorThemes := Value;
  If (Value = acsCustom) then exit;
  case Value of
    acsDOS       : begin
                     mPanelBG   := clNavy;
                     mLabelFG   := clAqua;
                     mEditBG    := $00800040;//$00400000;
                     mEditFG    := clWhite;
                     mHeadBG    := clYellow;
                     mHeadFG    := clBlack;
                     mGroupBoxBG := clNavy;
                     mGroupBoxFG := clYellow;
                   end;
    acsStandard  : begin
                     mPanelBG   := clBtnFace;
                     mLabelFG   := clWindowText;
                     mEditBG    := clWindow;
                     mEditFG    := clWindowText;
                     mHeadBG    := clBtnFace;
                     mHeadFG    := clWindowText;
                     mGroupBoxBG := clBtnFace;
                     mGroupBoxFG := clWindowText;
                   end;
    acsRandom    : begin
                     mPanelBG   := ((random(256)*256+Random(256))*256)+random(256);
                     mLabelFG   := ((random(256)*256+Random(256))*256)+random(256);
                     mEditBG    := ((random(256)*256+Random(256))*256)+random(256);
                     mEditFG    := ((random(256)*256+Random(256))*256)+random(256);
                     mHeadBG    := ((random(256)*256+Random(256))*256)+random(256);
                     mHeadFG    := ((random(256)*256+Random(256))*256)+random(256);
                     mGroupBoxBG := ((random(256)*256+Random(256))*256)+random(256);
                     mGroupBoxFG := ((random(256)*256+Random(256))*256)+random(256);
                   end;
  end;
  mForm := TForm(owner);
  Color := mPanelBG;
  If mForm.ComponentCount>0 then for i := 0 to mForm.ComponentCount-1 do begin
    If mForm.Components[i] is TControl then begin
      If isParent((mForm.Components[i] as TControl), self) then begin
        If (mForm.Components[i] is TPanel) then begin
          (mForm.Components[i] as TPanel).Color := mHeadBG;
          (mForm.Components[i] as TPanel).Font.Color := mHeadFG;
        end;
        If (mForm.Components[i] is TLabel) then (mForm.Components[i] as TLabel).Font.Color := mLabelFG;
        If (mForm.Components[i] is TCheckBox) then (mForm.Components[i] as TCheckBox).Font.Color := mLabelFG;
        If (mForm.Components[i] is TDBCheckBox) then (mForm.Components[i] as TDBCheckBox).Font.Color := mLabelFG;
        If (mForm.Components[i] is TRadioButton) then (mForm.Components[i] as TRadioButton).Font.Color := mLabelFG;
        If (mForm.Components[i] is TDBEdit) then begin
          (mForm.Components[i] as TDBEdit).Color := mEditBG;
          (mForm.Components[i] as TDBEdit).Font.Color := mEditFG;
        end;
        If (mForm.Components[i] is TEdit) then begin
          (mForm.Components[i] as TEdit).Color := mEditBG;
          (mForm.Components[i] as TEdit).Font.Color := mEditFG;
        end;
        If (mForm.Components[i] is TComboBox) then begin
          (mForm.Components[i] as TComboBox).Color := mEditBG;
          (mForm.Components[i] as TComboBox).Font.Color := mEditFG;
        end;
        If (mForm.Components[i] is TGroupBox) then begin
          (mForm.Components[i] as TGroupBox).Color := mGroupBoxBG;
          (mForm.Components[i] as TGroupBox).Font.Color := mGroupBoxFG;
        end;
      end;
    end;
  end;
end;

procedure TDinamicPanel.PanelCanResize(Sender: TObject; var NewWidth, NewHeight: Integer; var Resize: Boolean);
begin
  If (oRectList.Count <= 0) and (oAutoExpand) then GumiPanelOnCreate(self.Owner, self);
end;

procedure TDinamicPanel.PanelResize(Sender: TObject);
begin
  GumiPanelOnResize(self);
end;

procedure TDinamicPanel.GumiPanelOnCreate(pForm: TComponent; pPanel: TPanel);
var I: integer;
begin
  oWidth   := pPanel.Width;
  oHeight  := pPanel.Height;
  oRectList.Clear;
  If pForm.ComponentCount > 0 then for i := 0 to pForm.ComponentCount -1 do begin
    If (pForm.Components[i] is TControl) then begin
      If IsParent((pForm.Components[i] as TControl), pPanel) then begin
        AddList((pForm.Components[i] as TControl));
      end;
    end;
  end;
end;

procedure TDinamicPanel.GumiPanelOnResize(pPanel:TPanel);
var I: integer;
    mControl: TControl;
    mFontSize: integer;
    mCoefHeight,mCoefWidth: real;
begin
  If oRectList.Count > 0 then begin
    visible := FALSE;
    mCoefHeight := pPanel.Height / oHeight;
    mCoefWidth  := pPanel.Width  / oWidth;
    for i := 0 to oRectList.Count-1 do begin
      mControl := TPanelSize(oRectList[I]^).rControl;
      mFontSize := Round(TPanelSize(oRectList[i]^).rFontSize*mCoefHeight);

      TPanelSize(oRectList[i]^).rControl.Left   := Round(TPanelSize(oRectList[I]^).rLeft   * mCoefWidth);
      TPanelSize(oRectList[i]^).rControl.Top    := Round(TPanelSize(oRectList[I]^).rTop    * mCoefHeight);
      TPanelSize(oRectList[i]^).rControl.Width  := Round(TPanelSize(oRectList[I]^).rWidth  * mCoefWidth);
      TPanelSize(oRectList[i]^).rControl.Height := Round(TPanelSize(oRectList[I]^).rHeight * mCoefHeight);

      If (mControl is TLabel)       then (mControl as TLabel).Font.Size := mFontSize else
      If (mControl is TDBEdit)      then (mControl as TDBEdit).Font.Size := mFontSize else
      If (mControl is TButton)      then (mControl as TButton).Font.Size := mFontSize else
      If (mControl is TDBCheckBox)  then (mControl as TDBCheckBox).Font.Size := mFontSize else
      If (mControl is TCheckBox)    then (mControl as TCheckBox).Font.Size := mFontSize else
      If (mControl is TRadioButton) then (mControl as TRadioButton).Font.Size := mFontSize else
      If (mControl is TComboBox)    then (mControl as TComboBox).Font.Size := mFontSize else
      If (mControl is TEdit)        then (mControl as TEdit).Font.Size := mFontSize else
      If (mControl is TPanel)       then (mControl as TPanel).Font.Size := mFontSize else
      If (mControl is TGroupBox)    then (mControl as TGroupBox).Font.Size := mFontSize else
      If (mControl is TPageControl) then (mControl as TPageControl).Font.Size := mFontSize else
      If (mControl is TFLongEdit)   then (mControl as TFLongEdit).Font.Size := mFontSize else
      ;
    end;
    visible := TRUE;
  end;
end;

// ***************** THeadPanel ********************

constructor THeadPanel.Create (AOwner:TComponent);
begin
  inherited Create (AOwner);
  Width := 200;
  Height := 50;
  Color := 0;
  Caption := '';
  BorderStyle := bsNone;
  BevelInner := bvNone;
  BevelOuter := bvNone;
  // Telo panelu
  oBody := TShape.Create (Self);
  oBody.Parent := Self;
  oBody.Align := alClient;
  oBody.Brush.Color := clSkyBlue;
  oBody.Pen.Color := clBackground;
  oBody.Pen.Width := 2;
  // Hlavicka panelu
  oHead := TLabel.Create (Self);
  oHead.Parent := Self;
  oHead.Top := 0;
  oHead.Left := 0;
  oHead.Height := 16;
  oHead.Width := Width;
  oHead.Anchors := [akTop,akLeft,akRight];
  oHead.Alignment := taCenter;
  oHead.AutoSize := FALSE;
  oHead.Color := clBackground;
  oHead.Font.Name := 'Arial';
  oHead.Font.Color := clWhite;
  oHead.Font.Style := [fsBold];
  oHead.Font.Size := 9;
  oHead.Caption := ' ';
end;

destructor THeadPanel.Destroy;
begin
  FreeAndNil (oHead);
  FreeAndNil (oBody);
  inherited;
end;

procedure THeadPanel.SetHeadText (pValue: string);
begin
  oHead.Caption := pValue;
end;

function THeadPanel.GetHeadText: string;
begin
  Result := oHead.Caption;
end;

procedure THeadPanel.SetHeadColor (pValue: TColor);
begin
  oHead.Color := pValue;
  oBody.Pen.Color := pValue;
end;

function THeadPanel.GetHeadColor: TColor;
begin
  Result := oHead.Color;
end;

procedure THeadPanel.SetHeadFont (pValue: TFont);
begin
  oHead.Font := pValue;
end;

function THeadPanel.GetHeadFont: TFont;
begin
  Result := oHead.Font;
end;

procedure THeadPanel.SetBorderWidth (pValue:byte);
begin
  oBody.Pen.Width := pValue;
end;

function THeadPanel.GetBorderWidth:byte;
begin
  Result := oBody.Pen.Width;
end;

procedure THeadPanel.SetBodyColor (pValue: TColor);
begin
  Color := pValue;
  oBody.Brush.Color := pValue;
end;

function THeadPanel.GetBodyColor: TColor;
begin
  Result := oBody.Brush.Color;
end;

// ***************** TStatusLine *******************
constructor TStatusLine.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  Panels.BeginUpdate;
  try
    Panels.Add;  // Panel na zobrazenie pozicii
    Panels.Items[0].Width := 35;
    Panels.Add;  // Panel na zobrazenie popisu
  finally
    Panels.EndUpdate;
  end;
  Font.Name := gvSys.LabelFontName;
  Font.Size := gvSys.LabelFontSize;
end;

procedure TStatusLine.ShowData;
begin
  Panels.Items[0].Width := 35;
  Panels.Items[0].Alignment := taCenter;
  Panels.Items[0].Text := StrInt(oTabPosition+1,3)+' : '+StrInt(oCursorPosition,0);
  Panels.Items[1].Text := oDescription;
end;

procedure TStatusLine.SetTabPosition (pValue:word);
begin
  oTabPosition := pValue;
  ShowData;
end;

procedure TStatusLine.SetCursorPosition (pValue:word);
begin
  oCursorPosition := pValue;
  ShowData;
end;

procedure TStatusLine.SetDescription (pValue:string);
begin
  oDescription := pValue;
  ShowData;
end;

//***************** TSystemLine *******************
constructor TSystemLine.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
(*
  Panels.BeginUpdate;
  try
    Panels.Add;  // Panel na zobrazenie aktualneho roka
    Panels.Add;  // Panel na zobrazenie nazvu firmy
    Panels.Add;  // Panel na zobrazenie prihlaseneho uzivatela
    Panels.Items[0].Width := 35;
    Panels.Items[1].Width := 200;
  finally
    Panels.EndUpdate;
  end;
*)
end;

procedure TSystemLine.ShowData;
begin
(*
  Panels.Items[0].Width := 35;
  Panels.Items[0].Alignment := taCenter;
  Panels.Items[0].Text := gvSys.ActYear;
  Panels.Items[1].Width := 200;
  Panels.Items[1].Text := ' '+gvSys.ActOrgName;
  Panels.Items[2].Text := ' '+gvSys.UserName;
*)  
end;

//*************** TSingleBevel ********************
constructor TSingleBevel.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  Width := 258;
  Height := 20;
end;

//*************** TDoubleBevel ********************
constructor TDoubleBevel.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  Width := 258;
  Height := 42;
end;

//*************** TCheckButton ********************
constructor TCheckButton.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  Font.Name := gvSys.LabelFontName;
  Font.Size := gvSys.LabelFontSize;
end;

//*************** TSelectButton ********************
constructor TSelectButton.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  Font.Name := gvSys.LabelFontName;
  Font.Size := gvSys.LabelFontSize;
end;

//***************** TIcComboBox *******************
procedure TIcComboBox.CreateParams(var Params: TCreateParams);
begin
  inherited CreateParams(Params);
end;

constructor TIcComboBox.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  inherited OnEnter := MyOnEnter;
  inherited OnExit := MyOnExit;
  inherited OnKeyDown := MyOnKeyDown;
  Font.Name := gvSys.EditFontName;
  Font.Size := gvSys.EditFontSize;
end;

procedure TIcComboBox.KeyDown(var Key: Word; Shift: TShiftState);
begin
  SpecKeyDownHandle (Parent,Key,Shift);
  inherited;
end;

procedure TIcComboBox.MyOnEnter (Sender: TObject);
begin
  Color := clAqua;
  If oStatusLine<>nil then begin
    oStatusLine.TabPosition := TabOrder;
    oStatusLine.CursorPosition := 0;
    oStatusLine.Description := Hint;
  end;
  SetFocus;
  If Assigned (eOnEnter) then eOnEnter (Sender);
end;

procedure TIcComboBox.MyOnExit (Sender: TObject);
begin
  Color := clWhite;
  If Assigned (eOnExit) then eOnExit (Sender);
end;

procedure TIcComboBox.MyOnKeyDown (Sender: TObject; var Key: Word; Shift: TShiftState);
begin
  If Key=VK_F7 then
  else begin
    If Assigned (eOnEnter)
      then eOnEnter (Sender)
      else Key := 0;
  end;
end;


//*************************************************
procedure Register;
begin
  RegisterComponents('IcStandard', [TDinamicPanel]);
  RegisterComponents('IcStandard', [THeadPanel]);
  RegisterComponents('IcStandard', [TStatusLine]);
  RegisterComponents('IcStandard', [TSystemLine]);
  RegisterComponents('IcStandard', [TSingleBevel]);
  RegisterComponents('IcStandard', [TDoubleBevel]);
  RegisterComponents('IcStandard', [TCheckButton]);
  RegisterComponents('IcStandard', [TSelectButton]);
  RegisterComponents('IcStandard', [TIcComboBox]);
end;

end.
