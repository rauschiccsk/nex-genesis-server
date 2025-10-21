unit DBSErr_;

interface

uses
  LangForm, NexPath, DB, 
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, ExtCtrls, AdvGrid, SrchGrid, TableView, ComCtrls, StdCtrls, IcFiles, 
  Buttons;

type
  TF_DBSErr = class(TLangForm)
    TV_DBSErr: TTableView;
    Panel1: TPanel;
    BB_Rebuild: TBitBtn;
    BB_RebuildAll: TBitBtn;
    ProgressBar1: TProgressBar;
    BB_Cancel: TBitBtn;
    BB_Delete: TBitBtn;
    procedure TV_DBSErrDrawColorRow(Sender: TObject; var pRowColor: TColor;
      pField: TField; pFirstFld: Boolean);
    procedure BB_RebuildClick(Sender: TObject);
    procedure BB_RebuildAllClick(Sender: TObject);
    procedure BB_CancelClick(Sender: TObject);
    procedure BB_DeleteClick(Sender: TObject);
  private
    { Private declarations }
  public
    procedure Execute;
    { Public declarations }
  end;

var
  F_DBSErr: TF_DBSErr;

implementation

  uses Dbs_F;

{$R *.dfm}

procedure TF_DBSErr.Execute;
begin
  TV_DBSErr.SetPath := gPath.LngPath+'Service\';
  TV_DBSErr.DGDPath := gPath.LngPath+'Service\';
  TV_DBSErr.DataSet := (Owner as TF_Dbs).ptDBLSTErr;
  ShowModal;
end;

procedure TF_DBSErr.TV_DBSErrDrawColorRow(Sender: TObject;
  var pRowColor: TColor; pField: TField; pFirstFld: Boolean);
begin
  If pFirstFld then begin
    pRowColor := clBlack;
    If (Owner as TF_Dbs).ptDBLSTErr.FieldByName ('State').AsString='BADSTRUCT' then pRowColor := clRed;
    If (Owner as TF_Dbs).ptDBLSTErr.FieldByName ('State').AsString='NODEF' then pRowColor := clBlue;
  end;
end;

procedure TF_DBSErr.BB_RebuildClick(Sender: TObject);
begin
  BB_Rebuild.Enabled := FALSE;
  BB_RebuildAll.Enabled := FALSE;
  (Owner as TF_Dbs).bt_DBLst.IndexFieldNames := 'DBPath;DBName';
  (Owner as TF_Dbs).TV_DBLst.oDBSrGrid.SetExtIndexName((Owner as TF_Dbs).bt_DBLst.IndexName);
  If (Owner as TF_Dbs).bt_DBLst.FindKey ([(Owner as TF_Dbs).ptDBLSTErr.FieldByName ('DBPath').AsString,(Owner as TF_Dbs).ptDBLSTErr.FieldByName ('DBName').AsString]) then begin
    (Owner as TF_Dbs).BB_RebuildClick(Sender);
    (Owner as TF_Dbs).ptDBLSTErr.Delete;
  end;
  BB_Rebuild.Enabled := TRUE;
  BB_RebuildAll.Enabled := TRUE;
end;

procedure TF_DBSErr.BB_RebuildAllClick(Sender: TObject);
begin
  BB_Rebuild.Enabled := FALSE;
  BB_RebuildAll.Enabled := FALSE;
  (Owner as TF_Dbs).oExit := FALSE;
  (Owner as TF_Dbs).SetButtonStatus (FALSE);
  If (Owner as TF_Dbs).ptDBLSTErr.RecordCount>0 then begin
    If MessageDlg('**--** Naozaj chcete spustiù obnovu na vöetky datab·zovÈ s˙bory?', mtConfirmation, [mbYes,mbNo], 0)=mrYes then begin
      (Owner as TF_Dbs).ptDBLSTErr.First;
      (Owner as TF_Dbs).bt_DBLst.IndexFieldNames := 'DBPath;DBName';
      (Owner as TF_Dbs).TV_DBLst.oDBSrGrid.SetExtIndexName((Owner as TF_Dbs).bt_DBLst.IndexName);
      Repeat
        Application.ProcessMessages;
        If (Owner as TF_Dbs).ptDBLSTErr.FieldByName ('STATE').AsString='BADSTRUCT' then begin
          If (Owner as TF_Dbs).bt_DBLst.FindKey ([(Owner as TF_Dbs).ptDBLSTErr.FieldByName ('DBPath').AsString,(Owner as TF_Dbs).ptDBLSTErr.FieldByName ('DBName').AsString]) then begin
            (Owner as TF_Dbs).RebuildDB;
            (Owner as TF_Dbs).ptDBLSTErr.Delete;
          end else (Owner as TF_Dbs).ptDBLSTErr.Next;
        end else (Owner as TF_Dbs).ptDBLSTErr.Next;
      until (Owner as TF_Dbs).ptDBLSTErr.EOF or (Owner as TF_Dbs).oExit;
    end;
  end;
  (Owner as TF_Dbs).SetButtonStatus (TRUE);
  BB_Rebuild.Enabled := TRUE;
  BB_RebuildAll.Enabled := TRUE;
end;

procedure TF_DBSErr.BB_CancelClick(Sender: TObject);
begin
  BB_CancelClick(Sender);
end;

procedure TF_DBSErr.BB_DeleteClick(Sender: TObject);
begin
  (Owner as TF_Dbs).bt_DBLst.SwapIndex;
  (Owner as TF_Dbs).bt_DBLst.IndexName:='DpDn';
  If (Owner as TF_Dbs).bt_DBLst.FindKey ([(Owner as TF_Dbs).ptDBLSTErr.FieldByName ('DBPath').AsString,(Owner as TF_Dbs).ptDBLSTErr.FieldByName ('DBName').AsString]) then begin
    If ((Owner as TF_Dbs).ptDBLSTErr.FieldByName ('State').AsString='NODEF') and (MessageDlg('**--** Chcete aj zrusit datab·zovy s˙bor '+(Owner as TF_Dbs).ptDBLSTErr.FieldByName ('DBName').AsString+'?', mtConfirmation, [mbYes,mbNo], 0)=mrYes) then begin
      If FileExistsI ((Owner as TF_Dbs).ptDBLSTErr.FieldByName ('DBPath').AsString+(Owner as TF_Dbs).ptDBLSTErr.FieldByName ('DBName').AsString)
        then DeleteFile ((Owner as TF_Dbs).ptDBLSTErr.FieldByName ('DBPath').AsString+(Owner as TF_Dbs).ptDBLSTErr.FieldByName ('DBName').AsString);
    end;
    (Owner as TF_Dbs).bt_DBLst.Delete;
    (Owner as TF_Dbs).ptDBLSTErr.Delete;
  end;
  (Owner as TF_Dbs).bt_DBLst.RestoreIndex;
end;

end.
