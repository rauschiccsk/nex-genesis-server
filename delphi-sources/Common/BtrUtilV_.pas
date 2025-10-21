unit BtrUtilV_;

interface

uses
  LangForm, IcConv, IcTools, IcVariab, NexPath, NexError, NexMsg, TxtWrap,
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, ExtCtrls, AdvGrid, SrchGrid, TableView, StdCtrls, DBCtrls, DB,
  IcStand, BtrTable, DBTables, Buttons, IcButtons, IcLabels, IcEditors,
  ActnList, IcActionList, NwInfoFields;


type
  TF_BtrUtilV = class(TLangForm)
    TV_Table: TTableView;
    Panel1: TPanel;
    DBN_Table: TDBNavigator;
    DS_Table: TDataSource;
    ChB_ReadOnly: TCheckButton;
    ChB_AskBeforeDelete: TCheckButton;
    bt_Perview: TBtrieveTable;
    GB_Search: TGroupBox;
    ChB_Find: TCheckButton;
    SpecLabel1: TSpecLabel;
    SpecLabel2: TSpecLabel;
    B_FindFirst: TSpecButton;
    B_FindNext: TSpecButton;
    CB_SearchField: TIcComboBox;
    ChB_NoCaseSensitive: TCheckButton;
    B_SearchCancel: TSpecButton;
    E_SearchText: TNameEdit;
    GB_Replace: TGroupBox;
    SpecLabel3: TSpecLabel;
    CB_ReplaceField: TIcComboBox;
    SpecLabel4: TSpecLabel;
    E_ReplStrSrc: TNameEdit;
    SpecLabel5: TSpecLabel;
    E_ReplStrTrg: TNameEdit;
    B_ReplaceFirst: TSpecButton;
    B_ReplaceNext: TSpecButton;
    B_ReplaceCancel: TSpecButton;
    ChB_ReplaceAll: TCheckButton;
    ChB_Search: TCheckButton;
    ChB_Replace: TCheckButton;
    IcActionList1: TIcActionList;
    A_Exit: TAction;
    ChB_ReplaceFind: TCheckButton;
    ChB_FillField: TCheckButton;
    ChB_Filter: TCheckButton;
    GB_Filter: TGroupBox;
    SpecLabel6: TSpecLabel;
    SpecLabel7: TSpecLabel;
    ChB_FilterBTR: TCheckButton;
    E_FilterStr: TNameEdit;
    CB_FilterField: TIcComboBox;
    SB_InsFilterField: TSpecButton;
    I_Actpos: TNwNumInfo;
    B_Renumber: TSpecButton;
    B_RenumberF: TSpecButton;
    CB_SourceField: TIcComboBox;
    Label1: TLabel;
    ChB_CopyField: TCheckButton;
    I_IndexName: TNwNameInfo;
    B_DelToBtr: TButton;
    Button1: TButton;
    procedure TV_TableCtrlDelPressed(Sender: TObject);
    procedure ChB_ReadOnlyClick(Sender: TObject);
    procedure TV_TableInsPressed(Sender: TObject);
    procedure ChB_AskBeforeDeleteClick(Sender: TObject);
    procedure B_FindFirstClick(Sender: TObject);
    procedure B_FindNextClick(Sender: TObject);
    procedure B_CancelClick(Sender: TObject);
    procedure ChB_SearchClick(Sender: TObject);
    procedure ChB_ReplaceClick(Sender: TObject);
    procedure B_ReplaceFirstClick(Sender: TObject);
    procedure B_ReplaceNextClick(Sender: TObject);
    procedure A_ExitExecute(Sender: TObject);
    procedure ChB_FillFieldClick(Sender: TObject);
    procedure ChB_FilterClick(Sender: TObject);
    procedure ChB_FilterBTRClick(Sender: TObject);
    procedure SB_InsFilterFieldClick(Sender: TObject);
    procedure TV_TableDataChange(Sender: TObject; Field: TField);
    procedure B_RenumberClick(Sender: TObject);
    procedure B_RenumberFClick(Sender: TObject);
    procedure TV_TableChangeIndex(Sender: TObject);
    procedure B_DelToBtrClick(Sender: TObject);
    procedure Button1Click(Sender: TObject);
  private
    oExitSearch: boolean;
    procedure FindData;
    procedure FillFieldNames;
    procedure ReplaceData;
    { Private declarations }
  public
    procedure Execute (pPath,pTblName,pTblExt:string);
    procedure ExecuteDel (pPath,pTblName,pTblExt:string);
    { Public declarations }
  end;

var
  F_BtrUtilV: TF_BtrUtilV;

implementation


{$R *.dfm}

procedure TF_BtrUtilV.Execute (pPath,pTblName,pTblExt:string);
var  mTitle:string;
begin
  bt_Perview.DatabaseName := pPath;
  bt_Perview.DefName := RemEndNumsDef (pTblName)+'.BDF';
  bt_Perview.DefPath := gPath.DefPath;
  bt_Perview.TableName := pTblName;
  bt_Perview.TableNameExt := pTblExt;
  If not DirectoryExists(gPath.LngPath+'Service\') then ForceDirectories(gPath.LngPath+'Service\');
  TV_Table.SetPath := gPath.LngPath+'Service\';
  TV_Table.DGDPath := gPath.LngPath+'Service\';
  TV_Table.DGDName := pTblName;
  TV_Table.ServiceMode := TRUE;
  bt_Perview.Active := TRUE;
  TV_Table.DataSet := bt_Perview;
  DS_Table.DataSet := bt_Perview;
  I_IndexName.Text :=bt_Perview.IndexName;
  mTitle := Caption;
  Caption := mTitle+' - '+bt_Perview.DatabaseName+pTblName+'.'+pTblExt;
  FillFieldNames;
  B_DelToBtr.Enabled:=False;
  B_DelToBtr.Visible:=False;
  ShowModal;
  Caption := mTitle;
  TV_Table.DataSet := nil;
  DS_Table.DataSet := nil;
  bt_Perview.Active := FALSE;
end;

procedure TF_BtrUtilV.ExecuteDel (pPath,pTblName,pTblExt:string);
var  mTitle:string;
begin
  If FileExists(pPath+pTblName+'.DEL') or FileExists(pPath+pTblName+'.DTX') then begin
    bt_Perview.DatabaseName := pPath;
    bt_Perview.DefName := RemEndNumsDef (pTblName)+'.BDF';
    bt_Perview.DefPath := gPath.DefPath;
    bt_Perview.TableName := pTblName;
    bt_Perview.TableNameExt := 'BTD';
    If not DirectoryExists(gPath.LngPath+'Service\') then ForceDirectories(gPath.LngPath+'Service\');
    TV_Table.SetPath := gPath.LngPath+'Service\';
    TV_Table.DGDPath := gPath.LngPath+'Service\';
    TV_Table.DGDName := pTblName;
    TV_Table.ServiceMode := TRUE;
    bt_Perview.Active := TRUE;
    bt_Perview.DTX2Btr;
    TV_Table.DataSet := bt_Perview;
    DS_Table.DataSet := bt_Perview;
    I_IndexName.Text :=bt_Perview.IndexName;
    mTitle := Caption;
    Caption := mTitle+' - '+bt_Perview.DatabaseName+pTblName+'.DEL';
    FillFieldNames;
    B_DelToBtr.Enabled:=True;
    B_DelToBtr.Visible:=True;
    ShowModal;
    Caption := mTitle;
    TV_Table.DataSet := nil;
    DS_Table.DataSet := nil;
    bt_Perview.Active := FALSE;
    DeleteFile(pPath+pTblName+'.BTD');
  end else ShowMsg(ecSysTxtFileIsNotExist, pPath+pTblName+' .DEL + .DTX');
end;

procedure TF_BtrUtilV.FindData;
var
  mFind:boolean;
  mS1,mS2:string;
begin
  B_FindFirst.Enabled := FALSE;
  B_FindNext.Enabled := FALSE;
  GB_Replace.Enabled := FALSE;
  oExitSearch := FALSE;
  mFind := FALSE;
  Repeat
    Application.ProcessMessages;
    mS1 := E_SearchText.Text;
    mS2 := TV_Table.DataSet.FieldByName (CB_SearchField.Text).AsString;
    If ChB_NoCaseSensitive.Checked then begin
      mS1 :=  StrToAlias (mS1);
      mS2 := StrToAlias (mS2);
    end;
    If ChB_Find.Checked then begin
      mFind := (mS1=mS2);
    end else begin
      If (mS1<>'') or (mS2<>'')
        then mFind := (Pos (mS1,mS2)>0)
        else mFind := TRUE;
    end;
    If not mFind then TV_Table.DataSet.Next;
  until mFind or TV_Table.DataSet.EOF or oExitSearch;
  If not mFind
    then MessageDlg('Vyhladávanie bolo dokonèené! Zadaný reazec nebol najdený!', mtInformation	, [mbOK], 0)
    else TV_Table.SetFocus;
  B_FindFirst.Enabled := TRUE;
  B_FindNext.Enabled := TRUE;
  GB_Replace.Enabled := TRUE;
end;

procedure TF_BtrUtilV.FillFieldNames;
var I:longint;
begin
  CB_SearchField.Clear;
  CB_ReplaceField.Clear;
  CB_SourceField.Clear;
  CB_FilterField.Clear;
  For I:=0 to TV_Table.DataSet.FieldCount-1 do begin
    CB_SearchField.Items.Add(TV_Table.DataSet.Fields[I].FieldName);
    CB_ReplaceField.Items.Add(TV_Table.DataSet.Fields[I].FieldName);
    CB_SourceField.Items.Add(TV_Table.DataSet.Fields[I].FieldName);
//    CB_FilterField.Items.Add(TV_Table.DataSet.Fields[I].FieldName);
  end;
  For I:=0 to bt_Perview.FieldCount-1 do begin
    CB_FilterField.Items.Add(bt_Perview.FieldDefs[I].Name);
  end;
  If CB_SearchField.Items.Count>0  then CB_SearchField.ItemIndex := 0;
  If CB_ReplaceField.Items.Count>0 then CB_ReplaceField.ItemIndex:= 0;
  If CB_SourceField.Items.Count>0  then CB_SourceField.ItemIndex := 0;
  If CB_FilterField.Items.Count>0  then CB_FilterField.ItemIndex := 0;
end;

procedure TF_BtrUtilV.ReplaceData;
var
  mFind:boolean;
  mEnd:boolean;
  mS:string;
  mPos:longint;
begin
  B_ReplaceFirst.Enabled := FALSE;
  B_ReplaceNext.Enabled := FALSE;
  GB_Search.Enabled := FALSE;
  oExitSearch := FALSE;
  mFind := FALSE;
  mEnd := FALSE;
  Repeat
    Application.ProcessMessages;
    mS := TV_Table.DataSet.FieldByName (CB_ReplaceField.Text).AsString;
    If not ChB_FillField.Checked then begin
      If (mS<>'') or (E_ReplStrSrc.Text<>'') then begin
        If ChB_ReplaceFind.Checked
          then mFind := (E_ReplStrSrc.Text=mS)
          else mFind := (Pos (E_ReplStrSrc.Text,mS)>0);
      end else mFind := TRUE;
    end else mFind := TRUE;
    If mFind then begin
      If ChB_CopyField.Checked then begin
         mS := TV_Table.DataSet.FieldByName (CB_SourceField.Text).AsString;
      end else If ChB_FillField.Checked then begin
        mS := E_ReplStrTrg.Text;
      end else begin
        If ChB_ReplaceFind.Checked then begin
          mS := E_ReplStrTrg.Text;
        end else begin
          mPos := Pos (E_ReplStrSrc.Text,mS);
          Delete (mS,mPos, Length (E_ReplStrSrc.Text));
          Insert (E_ReplStrTrg.Text, mS, mPos);
        end;
      end;
      try
        TV_Table.DataSet.Edit;
        TV_Table.DataSet.FieldByName (CB_ReplaceField.Text).AsString := mS;
        TV_Table.DataSet.Post;
      except end;
      If ChB_ReplaceAll.Checked then TV_Table.DataSet.Next;
    end else TV_Table.DataSet.Next;
    If not ChB_ReplaceAll.Checked then mEnd := mFind;
  until mEnd or TV_Table.DataSet.EOF or oExitSearch;
  TV_Table.SetFocus;
  B_ReplaceFirst.Enabled := TRUE;
  B_ReplaceNext.Enabled := TRUE;
  GB_Search.Enabled := TRUE;
end;

procedure TF_BtrUtilV.TV_TableCtrlDelPressed(Sender: TObject);
var mT:TextFile; I,mIORes:longint; mFile:string; mTxtWrap:TTxtWrap;
    mDel:boolean;
begin
  If not ChB_ReadOnly.Checked then begin
    If ChB_AskBeforeDelete.Checked
      then mDel := MessageDlg('**--** Naozaj chcete zruši vybranú položku?', mtConfirmation, [mbYes,mbNo], 0)=mrYes
      else mDel := TRUE;
    If mDel then begin
      try
        If TV_Table.DataSet is TBtrieveTable then begin
          mFile := (TV_Table.DataSet as TBtrieveTable).DatabaseName+ExtractFileName ((TV_Table.DataSet as TBtrieveTable).TableName)+'.DTX';
          AssignFile (mT, mFile);
          {$I-}
          If FileExists(mFile) then Append (mT) else Rewrite (mT);
          {$I+}
          mIORes := IOResult;
          If mIORes=0 then begin
            mTxtWrap := TTxtWrap.Create;
            mTxtWrap.SetDelimiter ('');
            mTxtWrap.SetSeparator (';');
            mTxtWrap.ClearWrap;
            mTxtWrap.SetText(TV_Table.LoginName,0);
            mTxtWrap.SetDate(Date);
            mTxtWrap.SetTime(Time);
            mTxtWrap.SetText(cPrgVer,0);
            mTxtWrap.SetText('S',0);
            For I:=0 to TV_Table.DataSet.FieldCount-1 do begin
              mTxtWrap.SetText(TV_Table.DataSet.FieldByName (TV_Table.DataSet.FieldDefs[I].Name).AsString,0);
            end;
            {$I-} WriteLn (mT, mTxtWrap.GetWrapText); {$I+}
            mIORes := IOResult;
          end;
          {$I-} CloseFile (mT); {$I+}
          mIORes := IOResult;
          FreeAndNil (mTxtWrap);
        end;
      except end;
      TV_Table.DataSet.Delete;
    end;
  end;
end;

procedure TF_BtrUtilV.ChB_ReadOnlyClick(Sender: TObject);
begin
  ChB_AskBeforeDelete.Enabled := not ChB_ReadOnly.Checked;
  TV_Table.ReadOnly := ChB_ReadOnly.Checked;
  If ChB_ReadOnly.Checked then begin
    DBN_Table.VisibleButtons := DBN_Table.VisibleButtons-[nbInsert];
    DBN_Table.VisibleButtons := DBN_Table.VisibleButtons-[nbDelete];
    DBN_Table.VisibleButtons := DBN_Table.VisibleButtons-[nbEdit];
    DBN_Table.VisibleButtons := DBN_Table.VisibleButtons-[nbPost];
    DBN_Table.VisibleButtons := DBN_Table.VisibleButtons-[nbCancel];
  end else begin
    DBN_Table.VisibleButtons := DBN_Table.VisibleButtons+[nbInsert];
    DBN_Table.VisibleButtons := DBN_Table.VisibleButtons+[nbDelete];
    DBN_Table.VisibleButtons := DBN_Table.VisibleButtons+[nbEdit];
    DBN_Table.VisibleButtons := DBN_Table.VisibleButtons+[nbPost];
    DBN_Table.VisibleButtons := DBN_Table.VisibleButtons+[nbCancel];
  end;
end;

procedure TF_BtrUtilV.TV_TableInsPressed(Sender: TObject);
begin
  If not ChB_ReadOnly.Checked then begin
    TV_Table.DataSet.Insert;
  end;
end;

procedure TF_BtrUtilV.ChB_AskBeforeDeleteClick(Sender: TObject);
begin
  DBN_Table.ConfirmDelete := ChB_AskBeforeDelete.Checked;
end;

procedure TF_BtrUtilV.B_FindFirstClick(Sender: TObject);
begin
  If TV_Table.DataSet.RecordCount>0 then begin
    TV_Table.DataSet.First;
    FindData;
  end;
end;

procedure TF_BtrUtilV.B_FindNextClick(Sender: TObject);
begin
  If TV_Table.DataSet.RecordCount>0 then begin
    If not TV_Table.DataSet.EOF then begin
      TV_Table.DataSet.Next;
      FindData;
    end;
  end;
end;

procedure TF_BtrUtilV.B_CancelClick(Sender: TObject);
begin
  oExitSearch := TRUE;
end;

procedure TF_BtrUtilV.ChB_SearchClick(Sender: TObject);
begin
  GB_Search.Visible := ChB_Search.Checked;
end;

procedure TF_BtrUtilV.ChB_ReplaceClick(Sender: TObject);
begin
  GB_Replace.Visible := ChB_Replace.Checked;
end;

procedure TF_BtrUtilV.B_ReplaceFirstClick(Sender: TObject);
begin
  If TV_Table.DataSet.RecordCount>0 then begin
    TV_Table.DataSet.First;
    ReplaceData;
  end;
end;

procedure TF_BtrUtilV.B_ReplaceNextClick(Sender: TObject);
begin
  If TV_Table.DataSet.RecordCount>0 then begin
    If not TV_Table.DataSet.EOF then begin
      TV_Table.DataSet.Next;
      ReplaceData;
    end;
  end;
end;

procedure TF_BtrUtilV.A_ExitExecute(Sender: TObject);
begin
  Close;
end;

procedure TF_BtrUtilV.ChB_FillFieldClick(Sender: TObject);
begin
  If ChB_FillField.Checked then begin
    E_ReplStrSrc.Enabled := FALSE;
    E_ReplStrSrc.Text := '';
  end else begin
    E_ReplStrSrc.Enabled := TRUE;
  end;
end;

procedure TF_BtrUtilV.ChB_FilterClick(Sender: TObject);
begin
  GB_Filter.Visible := ChB_Filter.Checked;
end;

procedure TF_BtrUtilV.ChB_FilterBTRClick(Sender: TObject);
begin
  (TV_Table.DataSet as TBtrieveTable).Filter   := E_FilterStr.Text;
  (TV_Table.DataSet as TBtrieveTable).Filtered := Chb_FilterBtr.Checked;
  TV_Table.Refresh;
  TV_Table.DataSet.Refresh;
end;

procedure TF_BtrUtilV.SB_InsFilterFieldClick(Sender: TObject);
var mS : String;
begin
  mS:=E_FilterStr.Text;
  Insert('['+IntToStr(CB_FilterField.ItemIndex)+']',mS,E_FilterStr.SelStart+1);
  E_FilterStr.Text:=mS;
end;

procedure TF_BtrUtilV.TV_TableDataChange(Sender: TObject; Field: TField);
begin
  I_Actpos.Long:=bt_Perview.ActPos;
end;

procedure TF_BtrUtilV.B_RenumberClick(Sender: TObject);
var mnum:longint;
begin
  If MessageDlg ('Nazoaj chcete precislovat pole '+ CB_FilterField.Text,mtConfirmation, [mbYes, mbNo], 0) = mrYes then
  begin
    TV_Table.DataSet.DisableControls;
    TV_Table.DataSet.Last;
    try
      mNum:= TV_Table.DataSet.fieldbyname(CB_FilterField.Text).AsInteger;
    except
      mNum:=0;
    end;
    If mNum>0 then
    begin
      TV_Table.DataSet.Prior;
      while not TV_Table.DataSet.Bof do begin
        Dec(mNum);
        try
          If TV_Table.DataSet.fieldbyname(CB_FilterField.Text).AsInteger<>mNum then
          begin
            TV_Table.DataSet.Edit;
            TV_Table.DataSet.fieldbyname(CB_FilterField.Text).AsInteger:=mNum;
            TV_Table.DataSet.Post;
          end;
        finally
        end;
        TV_Table.DataSet.Prior;
      end;
    end;
    TV_Table.DataSet.EnableControls;
    TV_Table.SetFocus;
  end;
end;

procedure TF_BtrUtilV.B_RenumberFClick(Sender: TObject);
var mnum:longint;
begin
  If MessageDlg ('Nazoaj chcete precislovat pole '+ CB_FilterField.Text,mtConfirmation, [mbYes, mbNo], 0) = mrYes then
  begin
    TV_Table.DataSet.DisableControls;
    TV_Table.DataSet.First;
    try
      mNum:= TV_Table.DataSet.fieldbyname(CB_FilterField.Text).AsInteger;
    except
      mNum:=-1;
    end;
    If mNum>=0 then
    begin
      TV_Table.DataSet.Next;
      while not TV_Table.DataSet.EOF do begin
        Inc(mNum);
        try
          If TV_Table.DataSet.fieldbyname(CB_FilterField.Text).AsInteger<>mNum then
          begin
            TV_Table.DataSet.Edit;
            TV_Table.DataSet.fieldbyname(CB_FilterField.Text).AsInteger:=mNum;
            TV_Table.DataSet.Post;
          end;
        finally
        end;
        TV_Table.DataSet.Next;
      end;
    end;
    TV_Table.DataSet.EnableControls;
    TV_Table.SetFocus;
  end;
end;

procedure TF_BtrUtilV.TV_TableChangeIndex(Sender: TObject);
begin
  I_IndexName.Text :=bt_Perview.IndexName;
  inherited;
end;

procedure TF_BtrUtilV.B_DelToBtrClick(Sender: TObject);
var mbt_Perview: TBtrieveTable;
begin
  mbt_Perview:=TBtrieveTable.Create(self);
  mbt_Perview.DatabaseName := bt_Perview.DatabaseName;
  mbt_Perview.DefName      := bt_Perview.DefName;
  mbt_Perview.DefPath      := bt_Perview.DefPath;
  mbt_Perview.TableName    := bt_Perview.TableName;
  mbt_Perview.TableNameExt := 'BTR';
  mbt_Perview.Open;
  mbt_Perview.Insert;
  mbt_Perview.SetRecordBuffer(bt_Perview.GetRecordBuffer);
  mbt_Perview.Post;
  FreeAndNil(mbt_Perview);
end;

procedure TF_BtrUtilV.Button1Click(Sender: TObject);
begin
  If ChB_FilterBTR.Checked and (MessageDlg ('Nazoaj chcete zrusit vsetky vyfiltrovane polozky?',mtConfirmation, [mbYes, mbNo], 0) = mrYes) then
  begin
    I_Actpos.Long:=TV_Table.DataSet.RecordCount;
    TV_Table.DataSet.DisableControls;
    TV_Table.DataSet.First;
    If not TV_Table.DataSet.Eof then
    begin
      while not TV_Table.DataSet.Eof do
      begin
        try
          TV_Table.DataSet.Delete;
          I_Actpos.Long:=I_Actpos.Long-1;
          Application.ProcessMessages;
        finally
        end;
      end;
    end;
    TV_Table.DataSet.EnableControls;
    TV_Table.SetFocus;
  end;
end;

end.


