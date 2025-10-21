unit IcButtons;

interface

uses
  IcText, IcStand, IcVariab, CmpTools,
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls, Buttons;

type
  TButtonType = (btNone,btItems,btDocPrint,btMultiPrn,
                 btInfo,btSearch,btHistory,btSummary,
                 btRefresh,btCalc,btBooks,
                 btExit,btInsert,btDelete,btEdit,btSelect,
                 btNwSelect);

  TSpecButton = class(TBitBtn)
  private
    oStatusLine: TStatusLine;
    oButtonType: TButtonType;
    eOnEnter: TNotifyEvent;
    eOnKeyDown: TKeyEvent;
    procedure SetButtonType (pValue:TButtonType);
    procedure MyOnEnter (Sender: TObject);
    procedure MyOnKeyDown (Sender: TObject; var Key: Word; Shift: TShiftState);
  public
    constructor Create(AOwner: TComponent); override;
  published
    property ButtonType: TButtonType read oButtonType write SetButtonType;
    property StatusLine: TStatusLine read oStatusLine write oStatusLine;
    { Events }
    property OnEnter:TNotifyEvent read eOnEnter write eOnEnter;
  end;

  TCancelButton = class(TSpecButton)
  public
    constructor Create(AOwner: TComponent); override;
  end;

  TOkButton = class(TSpecButton)
  public
    constructor Create(AOwner: TComponent); override;
  end;

  TSaveButton = class(TSpecButton)
  public
    constructor Create(AOwner: TComponent); override;
  end;

  TSpecSpeedButton = class(TSpeedButton)
  public
    constructor Create(AOwner: TComponent); override;
  private
    oButtonType: TButtonType;
    procedure SetButtonType (pValue:TButtonType);
  published
    property ButtonType: TButtonType read oButtonType write SetButtonType;
  end;

procedure Register;

implementation

{$R BUTTONS.RES}

// TSpecButton
constructor TSpecButton.Create(AOwner: TComponent);
begin
  inherited;
  inherited OnEnter := MyOnEnter;
  inherited OnKeyDown := MyOnKeyDown;
  Width  := 90;
  Height := 25;
//  NumGlyphs := 2;
  Font.Name := gvSys.ButtonFontName;
  Font.Size := 10;
end;

procedure TSpecButton.MyOnEnter (Sender: TObject);
begin
  If oStatusLine<>nil then begin
    oStatusLine.TabPosition := TabOrder;
    oStatusLine.CursorPosition := 0;
    oStatusLine.Description := Hint;
  end;
  If Assigned (eOnEnter) then eOnEnter (Sender);
end;

procedure TSpecButton.MyOnKeyDown (Sender: TObject; var Key: Word; Shift: TShiftState);
var mForm:TCustomForm;
begin
  If Assigned (eOnKeyDown) then eOnKeyDown (Sender,Key,Shift);
  mForm := GetParentForm(((Sender as TComponent).Owner as TControl));
//  If (Key=VK_ESCAPE) then mForm.Close;
end;

procedure TSpecButton.SetButtonType(pValue: TButtonType);
begin
  oButtonType := pValue;
  Glyph.Dormant;
  case oButtonType of
       btItems: Glyph.LoadFromResourceName (HInstance,'ITEMS');
    btDocPrint: Glyph.LoadFromResourceName (HInstance,'DOCPRINT');
    btMultiPrn: Glyph.LoadFromResourceName (HInstance,'MULTIPRN');
        btInfo: Glyph.LoadFromResourceName (HInstance,'INFO');
        btCalc: Glyph.LoadFromResourceName (HInstance,'CALC');
      btSearch: Glyph.LoadFromResourceName (HInstance,'SEARCH');
     btHistory: Glyph.LoadFromResourceName (HInstance,'HISTORY');
     btSummary: Glyph.LoadFromResourceName (HInstance,'SUMMARY');
     btRefresh: Glyph.LoadFromResourceName (HInstance,'REFRESH');
        btExit: Glyph.LoadFromResourceName (HInstance,'EXIT');
      btInsert: Glyph.LoadFromResourceName (HInstance,'INSERT');
      btDelete: Glyph.LoadFromResourceName (HInstance,'DELETE');
        btEdit: Glyph.LoadFromResourceName (HInstance,'EDIT');
      btSelect: Glyph.LoadFromResourceName (HInstance,'SELECTBUTTON');
  end;
end;

// TCancelButton
constructor TCancelButton.Create(AOwner: TComponent);
begin
  inherited;
  Name := 'B_Cancel';
  Caption := ctEscButton;
  ModalResult := mrCancel;
  Glyph.Dormant;
  Glyph.LoadFromResourceName (HInstance,'CANCELBUTTON');
end;

// TOkButton
constructor TOkButton.Create(AOwner: TComponent);
begin
  inherited;
  Name := 'B_Ok';
  Caption := ctOkButton;
//  ModalResult := mrOk;
  Glyph.Dormant;
  Glyph.LoadFromResourceName (HInstance,'OKBUTTON');
end;

// TSaveButton
constructor TSaveButton.Create(AOwner: TComponent);
begin
  inherited;
  Name := 'B_Save';
  Caption := ctSaveButton;
  Glyph.Dormant;
  Glyph.LoadFromResourceName (HInstance,'SAVEBUTTON');
end;

// TSpecSpeedButton
constructor TSpecSpeedButton.Create(AOwner: TComponent);
begin
  inherited;
  Name := 'B_SpecButton';
  Width := 25;
  Height := 25;
//  NumGlyphs := 2;
  SetButtonType (btNone);
end;

procedure TSpecSpeedButton.SetButtonType(pValue: TButtonType);
begin
  oButtonType := pValue;
  Glyph.Dormant;
  case oButtonType of
       btItems: Glyph.LoadFromResourceName (HInstance,'ITEMS');
    btDocPrint: Glyph.LoadFromResourceName (HInstance,'DOCPRINT');
    btMultiPrn: Glyph.LoadFromResourceName (HInstance,'MULTIPRN');
        btInfo: Glyph.LoadFromResourceName (HInstance,'INFO');
        btCalc: Glyph.LoadFromResourceName (HInstance,'CALC');
      btSearch: Glyph.LoadFromResourceName (HInstance,'SEARCH');
     btHistory: Glyph.LoadFromResourceName (HInstance,'HISTORY');
     btSummary: Glyph.LoadFromResourceName (HInstance,'SUMMARY');
     btRefresh: Glyph.LoadFromResourceName (HInstance,'REFRESH');
        btExit: Glyph.LoadFromResourceName (HInstance,'EXIT');
      btInsert: Glyph.LoadFromResourceName (HInstance,'INSERT');
      btDelete: Glyph.LoadFromResourceName (HInstance,'DELETE');
        btEdit: Glyph.LoadFromResourceName (HInstance,'EDIT');
      btSelect: Glyph.LoadFromResourceName (HInstance,'SELECTBUTTON');
       btBooks: Glyph.LoadFromResourceName (HInstance,'BOOKS');
    btNwSelect: Glyph.LoadFromResourceName (HInstance,'NWSELECT');
  end;
end;


procedure Register;
begin
  RegisterComponents('IcButtons', [TSpecButton]);
  RegisterComponents('IcButtons', [TCancelButton]);
  RegisterComponents('IcButtons', [TOkButton]);
  RegisterComponents('IcButtons', [TSaveButton]);
  RegisterComponents('IcButtons', [TSpecSpeedButton]);
end;

end.
