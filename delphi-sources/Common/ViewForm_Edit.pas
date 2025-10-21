unit ViewForm_Edit;

interface

uses
  IcTypes, IcEditors, IcStand, NexMsg, NexText, 
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls, Buttons, ExtCtrls;

type
  TF_BookListEdit = class(TForm)
    AEPanel1: TDinamicPanel;
    Bevel1: TBevel;
    E_BookNum: TEdit;
    Label1: TLabel;
    E_BookName: TNameEdit;
    Label2: TLabel;
    B_Save: TBitBtn;
    B_Cancel: TBitBtn;
    procedure B_SaveClick(Sender: TObject);
    procedure B_CancelClick(Sender: TObject);
    procedure E_KeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
  private
    { Private declarations }
    oSaveData: boolean;

    procedure LoadText;
  public
    { Public declarations }
    procedure Execute (pBookNum:Str5; pBookName:Str30);
    function  GetBookNum: Str5;
    function  GetBookName: Str30;
    property  SaveData: boolean read oSaveData;
  end;

var
  F_BookListEdit: TF_BookListEdit;

implementation

{$R *.DFM}

procedure TF_BookListEdit.Execute (pBookNum:Str5; pBookName:Str30);
begin
  LoadText;
  oSaveData := FALSE;
  E_BookNum.Text := pBookNum;
  E_BookName.Text := pBookName;
  ShowModal;
end;

function TF_BookListEdit.GetBookNum: Str5;
begin
  Result := E_BookNum.Text;
end;

function TF_BookListEdit.GetBookName: Str30;
begin
  Result := E_BookName.Text;
end;

procedure TF_BookListEdit.LoadText;
begin
  gNT.SetSection ('BookList');
  F_BookListEdit.Caption := gNT.GetText ('F_BookLstEdit.Caption',F_BookListEdit.Caption);
  F_BookListEdit.Font.Size := gNT.GetLong (F_BookListEdit.Name+'.FontSize',F_BookListEdit.Font.Size);
  Label1.Caption := gNT.GetText ('F_BookLstEdit.Label1.Caption',Label1.Caption);
  Label2.Caption := gNT.GetText ('F_BookLstEdit.Label2.Caption',Label2.Caption);
  Label1.Font.Size := F_BookListEdit.Font.Size;
  Label2.Font.Size := F_BookListEdit.Font.Size;

  gNT.SetSection ('GLOBAL');
  B_Save.Caption := gNT.GetText ('B_Save.Caption',B_Save.Caption);
  B_Cancel.Caption := gNT.GetText ('B_Cancel.Caption',B_Cancel.Caption);
end;

procedure TF_BookListEdit.B_SaveClick(Sender: TObject);
begin
  If (E_BookNum.Text<>'') and (E_BookName.Text<>'') then begin
    oSaveData := TRUE;
    Close;
  end
  else ShowMsg (7,'');
end;

procedure TF_BookListEdit.B_CancelClick(Sender: TObject);
begin
  oSaveData := FALSE;
  Close;
end;

procedure TF_BookListEdit.E_KeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
var mForm:TCustomForm;
begin
  If (Key=VK_RETURN) or (Key=VK_DOWN) then begin
    mForm := GetParentForm(((Sender as TComponent).Owner as TControl));
    if (mForm <> nil ) then SendMessage(mForm.Handle, WM_NEXTDLGCTL, 0, 0);
  end;
  If (Key=VK_ESCAPE) then Close;
end;


end.
