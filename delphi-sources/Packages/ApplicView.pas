unit ApplicView;    //markgrid

interface

uses
  NexText, NexMsg, TableView,
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  ExtCtrls, StdCtrls, Buttons;

type
  TShowButton  = (sbExitButton, sbAddButton, sbModButton, sbDelButton, sbPrintButton, sbFiltButton);
  TShowButtons = set of TShowButton;

  TApplicView = class(TTableView)
  private
    oShowButtons: TShowButtons;
    B_AddItem: TSpeedButton;
    B_ModItem: TSpeedButton;
    B_DelItem: TSpeedButton;
    B_Print: TSpeedButton;
    B_Filter: TSpeedButton;
    B_Exit: TSpeedButton;
  private
    oOwnerForm: TForm;
    oAskBeforExit: boolean;
    {Events}
    eOnPrint: TNotifyEvent;
    eOnFilter: TNotifyEvent;
    procedure SetShowButtons (Value:TShowButtons);
    procedure MyOnModItemClick( Sender: TObject);
    procedure MyOnAddItemClick( Sender: TObject);
    procedure MyOnDelItemClick( Sender: TObject);
    procedure MyOnPrintClick( Sender: TObject);
    procedure MyOnFilterClick( Sender: TObject);
    procedure MyOnExitClick( Sender: TObject);
    procedure LoadText;
  published
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
    procedure Execute;

    property ShowButtons : TShowButtons read oShowButtons write SetShowButtons;
    property AskBeforExit: boolean read oAskBeforExit write oAskBeforExit;
    {Events}
    property OnPrint: TNotifyEvent read eOnPrint write eOnPrint;
    property OnFilter: TNotifyEvent read eOnFilter write eOnFilter;
  end;

procedure Register;

implementation

uses  DM_SYSTEM;

constructor TApplicView.Create(AOwner: TComponent);
var mTop: word;
begin
  oOwnerForm := (AOwner as TForm);
  inherited Create(AOwner);
  inherited OnEscPressed := MyOnExitClick;
  oShowButtons := [sbExitButton, sbAddButton, sbModButton, sbDelButton, sbPrintButton, sbFiltButton];
  Align := alClient;
  ToolBarHeight := 28;
  AskBeforExit := TRUE;
  oHead.Caption := 'Table Head';

  mTop := 25;
  B_Exit := TSpeedButton.Create (Self);
  B_Exit.Parent := Self;
  B_Exit.Name := 'B_Exit';
  B_Exit.Left := 7;
  B_Exit.Top := mTop;
  B_Exit.Width := 25;
  B_Exit.Height := 25;
  B_Exit.NumGlyphs := 2;
  B_Exit.ParentShowHint := False;
  B_Exit.ShowHint := True;
  B_Exit.Hint := 'Opustit programovy modul';
  B_Exit.Glyph.LoadFromResourceName (HInstance,'EXIT');
  B_Exit.OnClick := MyOnExitClick;

  B_AddItem := TSpeedButton.Create (Self);
  B_AddItem.Parent := Self;
  B_AddItem.Name := 'B_AddItem';
  B_AddItem.Left := 33;
  B_AddItem.Top := mTop;
  B_AddItem.Width := 25;
  B_AddItem.Height := 25;
  B_AddItem.NumGlyphs := 2;
  B_AddItem.ParentShowHint := False;
  B_AddItem.ShowHint := True;
  B_AddItem.Glyph.LoadFromResourceName (HInstance,'INSERT');
  B_AddItem.OnClick := MyOnAddItemClick;

  B_ModItem := TSpeedButton.Create (Self);
  B_ModItem.Parent := Self;
  B_ModItem.Name := 'B_ModItem';
  B_ModItem.Left := 59;
  B_ModItem.Top := mTop;
  B_ModItem.Width := 25;
  B_ModItem.Height := 25;
  B_ModItem.NumGlyphs := 2;
  B_ModItem.ParentShowHint := False;
  B_ModItem.ShowHint := True;
  B_ModItem.Glyph.LoadFromResourceName (HInstance,'EDIT');
  B_ModItem.OnClick := MyOnModItemClick;

  B_DelItem := TSpeedButton.Create (Self);
  B_DelItem.Parent := Self;
  B_DelItem.Name := 'B_DelItem';
  B_DelItem.Left := 85;
  B_DelItem.Top := mTop;
  B_DelItem.Width := 25;
  B_DelItem.Height := 25;
  B_DelItem.NumGlyphs := 2;
  B_DelItem.ParentShowHint := False;
  B_DelItem.ShowHint := True;
  B_DelItem.Glyph.LoadFromResourceName (HInstance,'DELETE');
  B_DelItem.OnClick := MyOnDelItemClick;

  B_Print := TSpeedButton.Create (Self);
  B_Print.Parent := Self;
  B_Print.Name := 'B_Print';
  B_Print.Left := 111;
  B_Print.Top := mTop;
  B_Print.Width := 25;
  B_Print.Height := 25;
  B_Print.NumGlyphs := 2;
  B_Print.ParentShowHint := False;
  B_Print.ShowHint := True;
  B_Print.Glyph.LoadFromResourceName (HInstance,'PRINT');
  B_Print.OnClick := MyOnPrintClick;

  B_Filter := TSpeedButton.Create (Self);
  B_Filter.Parent := Self;
  B_Filter.Name := 'B_Filter';
  B_Filter.Left := 137;
  B_Filter.Top := mTop;
  B_Filter.Width := 25;
  B_Filter.Height := 25;
  B_Filter.NumGlyphs := 2;
  B_Filter.ParentShowHint := False;
  B_Filter.ShowHint := True;
  B_Filter.Glyph.LoadFromResourceName (HInstance,'DOCSTACK');
  B_Filter.OnClick := MyOnFilterClick;
end;

destructor TApplicView.Destroy;
begin
  B_Exit.Free;
  B_AddItem.Free;
  B_ModItem.Free;
  B_DelItem.Free;
  B_Print.Free;
  B_Filter.Free;
  inherited Destroy;
end;

procedure TApplicView.SetShowButtons (Value:TShowButtons);
begin
  oShowButtons := Value;
  B_AddItem.Visible :=sbAddButton   in oShowButtons;
  B_ModItem.Visible :=sbModButton   in oShowButtons;
  B_DelItem.Visible :=sbDelButton   in oShowButtons;
  B_Print.Visible   :=sbPrintButton in oShowButtons;
  B_Filter.Visible  :=sbFiltButton  in oShowButtons;
  B_Exit.Visible    :=sbExitButton  in oShowButtons;
end;

procedure TApplicView.Execute;
begin
  LoadText;
end;

procedure TApplicView.MyOnModItemClick(Sender: TObject);
begin
  If Assigned (OnModPressed) then OnModPressed(Sender);
end;

procedure TApplicView.MyOnAddItemClick(Sender: TObject);
begin
  If Assigned (OnInsPressed) then OnInsPressed(Sender);
end;

procedure TApplicView.MyOnDelItemClick(Sender: TObject);
begin
  If Assigned (OnDelPressed) then OnDelPressed(Sender);
end;

procedure TApplicView.MyOnPrintClick(Sender: TObject);
begin
  If Assigned (eOnPrint) then eOnPrint(Sender);
end;

procedure TApplicView.MyOnFilterClick(Sender: TObject);
begin
  If Assigned (eOnFilter) then eOnFilter(Sender);
end;

procedure TApplicView.MyOnExitClick(Sender: TObject);
begin
  If oAskBeforExit then begin
    If AskYes (8,'') then oOwnerForm.Close;
  end
  else oOwnerForm.Close;
end;

procedure TApplicView.LoadText;
begin
  gNT.SetSection ('ApplicView');
  B_AddItem.Hint := gNT.GetText('B_AddItem.Hint','Pridat novy zaznam');
  B_ModItem.Hint := gNT.GetText('B_ModItem.Hint','Upravit vybrany zaznam');
  B_DelItem.Hint := gNT.GetText('B_DelItem.Hint','Zrusit vybrany zaznam');
  B_Print.Hint := gNT.GetText('B_Print.Hint','Tlac zoznamu');
  B_Filter.Hint := gNT.GetText('B_Filter.Hint','Filtrovanie zoznamu');
  B_Exit.Hint := gNT.GetText('B_Exit.Hint','Opustit porgramovy modul');
end;


procedure Register;
begin
  RegisterComponents('IcDataAccess', [TApplicView]);
end;

end.
