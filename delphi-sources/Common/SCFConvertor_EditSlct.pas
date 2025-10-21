unit SCFConvertor_EditSlct;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls;

type
  TF_FldEditSlct = class(TForm)
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    Label4: TLabel;
    ComboBox1: TComboBox;
    CheckBox1: TCheckBox;
    procedure ComboBox1KeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure ComboBox1DblClick(Sender: TObject);
    procedure CheckBox1Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
    function Execute (pFld1,pFld2:string;pType:integer;var pCheck:boolean):integer;
  end;

var
  F_FldEditSlct: TF_FldEditSlct;

implementation

{$R *.DFM}

function TF_FldEditSlct.Execute;
begin
  ComboBox1.ItemIndex:=pType-1;
  ComboBox1.Text:=ComboBox1.items[pType-1];
  Label3.Caption:=pFld1;
  Label4.Caption:=pFld2;
  CheckBox1.Checked:=pCheck;
  If ShowModal =mrOK then Result:= ComboBox1.ItemIndex+1 else Result:=0;
  pCheck:=CheckBox1.Checked;
end;

procedure TF_FldEditSlct.ComboBox1KeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  If Key=vk_RETURN then ModalResult:=mrOK;
end;

procedure TF_FldEditSlct.ComboBox1DblClick(Sender: TObject);
begin
  ModalResult:=mrOK;
end;

procedure TF_FldEditSlct.CheckBox1Click(Sender: TObject);
begin
  ComboBox1.SetFocus;
end;

end.
