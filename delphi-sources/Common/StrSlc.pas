unit StrSlc;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls;

type
  TF_StrSlc = class(TForm)
    Button1: TButton;
    Button2: TButton;
    Button3: TButton;
    Button4: TButton;
    Button5: TButton;
    Button6: TButton;
    Button7: TButton;
    Button8: TButton;
    Button9: TButton;
    Button10: TButton;
    Button11: TButton;
    Button12: TButton;
    Button13: TButton;
    Button14: TButton;
    Edit1: TEdit;
    Button45: TButton;
    Button16: TButton;
    Button17: TButton;
    Button19: TButton;
    Button20: TButton;
    Button21: TButton;
    Button22: TButton;
    Button15: TButton;
    Button23: TButton;
    Button24: TButton;
    Button25: TButton;
    Button26: TButton;
    Button43: TButton;
    Button40: TButton;
    Button41: TButton;
    Button42: TButton;
    Button28: TButton;
    Button44: TButton;
    Button37: TButton;
    Button38: TButton;
    Button39: TButton;
    Button27: TButton;
    Button34: TButton;
    Button35: TButton;
    Button36: TButton;
    Button33: TButton;
    Button31: TButton;
    Button32: TButton;
    Button30: TButton;
    Button29: TButton;
    Button18: TButton;
    B_Cancel: TButton;
    procedure Button1Click(Sender: TObject);
    procedure Button45Click(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure Button44Click(Sender: TObject);
    procedure B_CancelClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure Edit1DblClick(Sender: TObject);
  private
    { Private declarations }
    oSelected: boolean;
  public
    { Public declarations }
    function ExecuteInputStr:string;
  end;

var
  F_StrSlc: TF_StrSlc;

implementation

{$R *.dfm}

procedure TF_StrSlc.Button1Click(Sender: TObject);
begin
  Edit1.Text:=Edit1.Text+(Sender as TButton).Caption;
end;

procedure TF_StrSlc.Button45Click(Sender: TObject);
begin
  Edit1.Text:=copy(Edit1.Text,1,length(Edit1.Text)-1);
end;

procedure TF_StrSlc.FormCreate(Sender: TObject);
var i:byte;
begin
  For I:= 1 to 26 do (FindComponent('Button'+IntToStr(I)) as TButton).Caption:=Chr(64+I);
end;

procedure TF_StrSlc.Button44Click(Sender: TObject);
begin
  oSelected:=True;
  Close;
end;

procedure TF_StrSlc.B_CancelClick(Sender: TObject);
begin
  oSelected:=False;
  Close;
end;

function TF_StrSlc.ExecuteInputStr: string;
begin
  ShowModal;
  If oSelected then Result:=Edit1.Text else Result:='';
end;

procedure TF_StrSlc.FormShow(Sender: TObject);
begin
  Edit1.Text:='';
  oSelected:=False;
end;

procedure TF_StrSlc.Edit1DblClick(Sender: TObject);
begin
  Edit1.Text:='';
end;

end.
