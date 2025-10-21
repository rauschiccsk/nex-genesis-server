unit PrintQR_;

interface

uses
  QRDM_, QRDM2_,
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls, Qrctrls, ExtCtrls, Buttons, QuickRpt;

type
  TForm1 = class(TForm)
    E_RepName: TEdit;
    Button1: TButton;
    CB_Level: TComboBox;
    E_FirmaName: TEdit;
    E_UserName: TEdit;
    E_PrivatPath: TEdit;
    CB_PrintDemo: TCheckBox;
    CB_PrintAbout: TCheckBox;
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    Label4: TLabel;
    Label5: TLabel;
    L_About: TLabel;
    E_About: TEdit;
    Memo1: TMemo;
    procedure Button1Click(Sender: TObject);
    procedure FormCreate(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Form1: TForm1;

implementation

uses PQRep_;

{$R *.DFM}

procedure TForm1.Button1Click(Sender: TObject);
begin
  cUserRepLevel := CB_Level.ItemIndex;
  cFirmaName := E_FirmaName.Text;
  cUserName := E_UserName.Text;
  cPrivatPath := E_PrivatPath.Text;
  cPrintDemo := CB_PrintDemo.Checked;
  cPrintAbout := CB_PrintAbout.Checked;
  cAbout := E_About.Text;

  DataModule1.Table1.Active := TRUE;
  DataModule2.DBFTable.Active := TRUE;
  F_PQRep.Execute (E_RepName.Text);
end;

procedure TForm1.FormCreate(Sender: TObject);
begin
  CB_Level.ItemIndex := cUserRepLevel;
  E_FirmaName.Text := cFirmaName;
  E_UserName.Text := cUserName;
  E_PrivatPath.Text := cPrivatPath;
  CB_PrintDemo.Checked := cPrintDemo;
  CB_PrintAbout.Checked := cPrintAbout;
  E_About.Text := 'NO-00-00300,  NEX Office od firmy IdentCode Consulting s.r.o.';
end;

end.
