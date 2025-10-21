unit BtrUtilN_;

interface

uses
  LangForm, IcConv,
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, Buttons, IcButtons, IcEditors;

type
  TF_BtrUtilN = class(TLangForm)
    E_DBPath: TNameEdit;
    B_Path: TSpeedButton;
    Label1: TLabel;
    Label2: TLabel;
    E_DBName: TNameEdit;
    B_OK: TSpecButton;
    B_Cancel: TSpecButton;
    OD_Open: TOpenDialog;
    procedure B_CancelClick(Sender: TObject);
    procedure B_PathClick(Sender: TObject);
    procedure B_OKClick(Sender: TObject);
  private
    oNewDB   :boolean;
    { Private declarations }
  public
    procedure Execute (pNewDB:boolean);
    { Public declarations }
  end;

var
  F_BtrUtilN: TF_BtrUtilN;

implementation

  uses Dbs_F;
{$R *.dfm}

procedure TF_BtrUtilN.Execute (pNewDB:boolean);
begin
  oNewDB := pNewDB;
  If not oNewDB then begin
    E_DBName.Text := (Owner as TF_Dbs).bt_DBLst.FieldByName ('DBName').AsString;
    E_DBPath.Text := (Owner as TF_Dbs).bt_DBLst.FieldByName ('DBPath').AsString;
  end;
  ShowModal;
end;

procedure TF_BtrUtilN.B_CancelClick(Sender: TObject);
begin
  Close;
end;

procedure TF_BtrUtilN.B_PathClick(Sender: TObject);
begin
  OD_Open.InitialDir := ExtractFilePath(E_DBPath.Text);
  OD_Open.FileName := '';
  If OD_Open.Execute then begin
    E_DBPath.Text := UpString (ExtractFilePath (OD_Open.FileName));
    E_DBName.Text := UpString (ExtractFileName (OD_Open.FileName));
  end;
end;

procedure TF_BtrUtilN.B_OKClick(Sender: TObject);
begin
  If oNewDB
    then (Owner as TF_Dbs).bt_DBLst.Insert
    else (Owner as TF_Dbs).bt_DBLst.Edit;
  (Owner as TF_Dbs).bt_DBLst.FieldByName ('DBName').AsString := UpString (E_DBName.Text);
  (Owner as TF_Dbs).bt_DBLst.FieldByName ('DBPath').AsString := UpString (E_DBPath.Text);
  (Owner as TF_Dbs).bt_DBLst.Post;
end;

end.
