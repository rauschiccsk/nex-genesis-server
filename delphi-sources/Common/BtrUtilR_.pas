unit BtrUtilR_;

interface

uses
  LangForm, NexPath, IcConv, DBTables, TxtWrap,IcTools,
  DB, Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, IcEditors, Buttons, ExtCtrls, ComCtrls, CheckLst,
  IcStand, ActnList;

type
  TF_BtrUtilR = class(TLangForm)
    B_Run: TBitBtn;
    GroupBox1: TGroupBox;
    ChB_StkPath: TCheckButton;
    ChB_DlsPath: TCheckButton;
    ChB_LdgPath: TCheckButton;
    ChB_CabPath: TCheckButton;
    ChB_SpecPath: TCheckButton;
    E_SpecPath: TEdit;
    ChB_DelNoExistsFiles: TCheckButton;
    ChB_SysPath: TCheckButton;
    ActionList1: TActionList;
    A_Run: TAction;
    procedure B_RunClick(Sender: TObject);
    procedure E_SpecPathExit(Sender: TObject);
  private
    procedure FindTablesInPath (pPath:string);
    procedure DeleteNoExistsFile;
    { Private declarations }
  public
    procedure Execute;
    { Public declarations }
  end;

var
  F_BtrUtilR: TF_BtrUtilR;

implementation

  uses Dbs_F, BtrTable;
{$R *.dfm}

procedure TF_BtrUtilR.Execute;
begin
  ShowModal;
end;

procedure TF_BtrUtilR.FindTablesInPath (pPath:string);
var mSR:TSearchRec; mIndexName:string;
begin
  If FindFirst (pPath+'*.BTR',faAnyFile,mSR)=0 then begin
    mIndexName := (Owner as TF_Dbs).bt_DBLst.IndexName;
    (Owner as TF_Dbs).bt_DBLst.IndexFieldNames := 'DBPath;DBName';
    Repeat
      If (mSR.Name<>'.') and (mSR.Name<>'..') then begin
        If not (Owner as TF_Dbs).bt_DBLst.FindKey([UpString (pPath),UpString (mSR.Name)]) then begin
          (Owner as TF_Dbs).bt_DBLst.Insert;
          (Owner as TF_Dbs).bt_DBLst.FieldByName ('DBPath').AsString := UpString (pPath);
          (Owner as TF_Dbs).bt_DBLst.FieldByName ('DBName').AsString := UpString (mSR.Name);
          (Owner as TF_Dbs).bt_DBLst.Post;
        end;
      end;
    until FindNext (mSR)<>0;
    FindClose (mSR);
    (Owner as TF_Dbs).bt_DBLst.IndexName := mIndexName;
  end;
end;

procedure TF_BtrUtilR.DeleteNoExistsFile;
begin
  If (Owner as TF_Dbs).bt_DBLst.RecordCount>0 then begin
    (Owner as TF_Dbs).bt_DBLst.First;
    Repeat
      Application.ProcessMessages;
      If FileExists((Owner as TF_Dbs).bt_DBLst.FieldByName ('DBPath').AsString+(Owner as TF_Dbs).bt_DBLst.FieldByName ('DBName').AsString)
        then (Owner as TF_Dbs).bt_DBLst.Next
        else (Owner as TF_Dbs).bt_DBLst.Delete;
    until ((Owner as TF_Dbs).bt_DBLst.RecordCount=0) or ((Owner as TF_Dbs).bt_DBLst.Eof);
  end;
end;

procedure TF_BtrUtilR.B_RunClick(Sender: TObject);
begin
  If ChB_StkPath.Checked then FindTablesInPath (gPath.StkPath);
  If ChB_DlsPath.Checked then FindTablesInPath (gPath.DlsPath);
  If ChB_LdgPath.Checked then FindTablesInPath (gPath.LdgPath);
  If ChB_CabPath.Checked then FindTablesInPath (gPath.CabPath);
  If ChB_SysPath.Checked then FindTablesInPath (gPath.SysPath);
  If ChB_SpecPath.Checked and DirectoryExists (E_SpecPath.Text) then FindTablesInPath (E_SpecPath.Text);
  If ChB_DelNoExistsFiles.Checked then DeleteNoExistsFile;
  Close;
end;

procedure TF_BtrUtilR.E_SpecPathExit(Sender: TObject);
begin
  If (E_SpecPath.Text<>'') and (Copy (E_SpecPath.Text,Length (E_SpecPath.Text),1)<>'\') then E_SpecPath.Text := E_SpecPath.Text+'\'; 
end;

end.
{MOD 1908001}

