unit BtrUtilI_;

interface

uses
  LangForm, NexPath, IcConv, DBTables, TxtCut,IcTools,
  DB, Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, IcEditors, Buttons, ExtCtrls, ComCtrls, CheckLst;

type
  TF_BtrUtilI = class(TLangForm)
    GroupBox1: TGroupBox;
    RB_Paradox: TRadioButton;
    RB_DBase: TRadioButton;
    RB_FoxPro: TRadioButton;
    RB_ASCII: TRadioButton;
    RB_Btr: TRadioButton;
    Label1: TLabel;
    SpeedButton1: TSpeedButton;
    BB_Import: TBitBtn;
    Panel2: TPanel;
    L_RecNum: TLabel;
    Label2: TLabel;
    L_RecQnt: TLabel;
    PB_Ind: TProgressBar;
    GB_ASCII: TGroupBox;
    Label3: TLabel;
    Label4: TLabel;
    E_Separator: TLongEdit;
    E_Delimiter: TLongEdit;
    GB_Btr: TGroupBox;
    Label5: TLabel;
    SpeedButton2: TSpeedButton;
    BB_Cancel: TBitBtn;
    E_SrcPath: TEdit;
    E_TrgDefFile: TEdit;
    OD_Open: TOpenDialog;
    Label6: TLabel;
    SpeedButton3: TSpeedButton;
    E_TrgPath: TEdit;
    P_DB: TPanel;
    ChLB_Flds: TCheckListBox;
    CE_IndexName: TComboEdit;
    L_IndexFields: TLabel;
    SB_Up: TSpeedButton;
    SB_Down: TSpeedButton;
    BB_EmptyFld: TBitBtn;
    E_DelSrc: TCheckBox;
    procedure BB_ImportClick(Sender: TObject);
    procedure RB_StandardClick(Sender: TObject);
    procedure BB_CancelClick(Sender: TObject);
    procedure FormActivate(Sender: TObject);
    procedure RB_BtrClick(Sender: TObject);
    procedure SpeedButton1Click(Sender: TObject);
    procedure SpeedButton3Click(Sender: TObject);
    procedure RB_ASCIIClick(Sender: TObject);
    procedure CE_IndexNameChange(Sender: TObject);
    procedure ChLB_FldsDragOver(Sender, Source: TObject; X, Y: Integer;
      State: TDragState; var Accept: Boolean);
    procedure ChLB_FldsDragDrop(Sender, Source: TObject; X, Y: Integer);
    procedure BB_EmptyFldClick(Sender: TObject);
    procedure SB_UpClick(Sender: TObject);
    procedure SB_DownClick(Sender: TObject);
    procedure ChLB_FldsDblClick(Sender: TObject);
  private
    oExit    :boolean;

    procedure FillStandardFlds;
    procedure FillASCIIFlds;
    procedure FillBtrFlds;
    function  FindItemInStringList (pSList:TStrings;pS:string):boolean;
    procedure ImportInStandard;
    procedure ImportInASCII;
    procedure ImportInBtr;
    procedure FindInTarget (pFld1,pFld2,pFld3,pFld4,pFld5:string);
    { Private declarations }
  public
    procedure Execute;
    { Public declarations }
  end;

var
  F_BtrUtilI: TF_BtrUtilI;

implementation

  uses Dbs_F, BtrTable;
{$R *.dfm}

procedure TF_BtrUtilI.Execute;
begin
  E_Delimiter.Long := 254;
  E_Separator.Long := 44;
  ShowModal;
end;

procedure TF_BtrUtilI.FillStandardFlds;
var
  mTblName:string;
  mTblExt:string;
  I:longint;
begin
  ChLB_Flds.Clear;
  CE_IndexName.Clear;
  (Owner as TF_Dbs).bt_Trg.Active := FALSE;
  mTblName := ExtractFileName ((Owner as TF_Dbs).bt_DBLst.FieldByName ('DBName').AsString);
  If Pos ('.',mTblName)>1 then Delete (mTblName,Pos ('.',mTblName),Length (mTblName));

  mTblExt := ExtractFileExt ((Owner as TF_Dbs).bt_DBLst.FieldByName ('DBName').AsString);
  If Pos ('.',mTblExt)=1 then Delete (mTblExt,1,1);
  (Owner as TF_Dbs).bt_Trg.DatabaseName := E_TrgPath.Text;
  (Owner as TF_Dbs).bt_Trg.DefName := RemEndNumsDef (mTblName)+'.BDF';
  (Owner as TF_Dbs).bt_Trg.DefPath := gPath.DefPath;
  (Owner as TF_Dbs).bt_Trg.TableName := mTblName;
  (Owner as TF_Dbs).bt_Trg.TableNameExt := mTblExt;
  (Owner as TF_Dbs).bt_Trg.Active := TRUE;

  (Owner as TF_Dbs).T_Stand.Active := FALSE;
  (Owner as TF_Dbs).T_Stand.DatabaseName := E_SrcPath.Text;
  (Owner as TF_Dbs).T_Stand.TableName := mTblName;

  If RB_Paradox.Checked then (Owner as TF_Dbs).T_Stand.TableType := ttParadox;
  If RB_DBase.Checked then (Owner as TF_Dbs).T_Stand.TableType := ttDBase;
  If RB_FoxPro.Checked then (Owner as TF_Dbs).T_Stand.TableType := ttFoxPro;
  If (Owner as TF_Dbs).T_Stand.Exists then begin
    (Owner as TF_Dbs).T_Stand.Active := TRUE;

    For I:=0 to (Owner as TF_Dbs).T_Stand.Fields.Count-1 do begin
      ChLB_Flds.Items.Add ((Owner as TF_Dbs).T_Stand.Fields[I].FieldName);
      If (Owner as TF_Dbs).bt_Trg.FindField((Owner as TF_Dbs).T_Stand.Fields[I].FieldName)<>nil then begin
        ChLB_Flds.Checked[I] := TRUE;
      end else ChLB_Flds.ItemEnabled[I] := FALSE;
    end;
    CE_IndexName.Items.Add ('');
    For I:=0 to (Owner as TF_Dbs).bt_Trg.IndexDefs.Count-1 do begin
      CE_IndexName.Items.Add ((Owner as TF_Dbs).bt_Trg.IndexDefs.Items[I].Name);
    end;
    If CE_IndexName.Items.Count>0 then CE_IndexName.ItemIndex := 0;
  end;
end;

procedure TF_BtrUtilI.FillASCIIFlds;
var
  mTblName:string;
  mTblExt:string;
  I:longint;
  mT:TextFile;
  mCut:TTxtCut;
  mS:string;
begin
  (Owner as TF_Dbs).bt_Trg.Active := FALSE;
  mTblName := ExtractFileName ((Owner as TF_Dbs).bt_DBLst.FieldByName ('DBName').AsString);
  If Pos ('.',mTblName)>1 then Delete (mTblName,Pos ('.',mTblName),Length (mTblName));
  mTblExt := ExtractFileExt ((Owner as TF_Dbs).bt_DBLst.FieldByName ('DBName').AsString);
  If Pos ('.',mTblExt)=1 then Delete (mTblExt,1,1);

  (Owner as TF_Dbs).bt_Trg.DatabaseName := E_TrgPath.Text;
  (Owner as TF_Dbs).bt_Trg.DefName := RemEndNumsDef (mTblName)+'.BDF';
  (Owner as TF_Dbs).bt_Trg.DefPath := gPath.DefPath;
  (Owner as TF_Dbs).bt_Trg.TableName := mTblName;
  (Owner as TF_Dbs).bt_Trg.TableNameExt := mTblExt;
  (Owner as TF_Dbs).bt_Trg.Active := TRUE;

  ChLB_Flds.Clear;
  mCut := TTxtCut.Create;
  mCut.SetDelimiter(Chr (E_Delimiter.Long)); If E_Delimiter.Text='' then mCut.SetDelimiter('');
  mCut.SetSeparator(Chr (E_Separator.Long));
  AssignFile (mT,E_SrcPath.Text+mTblName+'.TXT');
  Reset (mT);
  ReadLn (mT,mS);
  mCut.SetStr(mS);
  If mCut.GetText(1)='*HEAD*' then begin
    For I:=2 to mCut.GetFldNum do begin
      ChLB_Flds.Items.Add (mCut.GetText(I));
      If (Owner as TF_Dbs).bt_Trg.FindField(mCut.GetText(I))<>nil then begin
        ChLB_Flds.Checked[I-2] := TRUE;
      end else ChLB_Flds.ItemEnabled[I-2] := FALSE;
    end;
  end else begin
    ChLB_Flds.Clear;
    For I:=0 to (Owner as TF_Dbs).bt_Trg.Fields.Count-1 do begin
      ChLB_Flds.Items.Add ((Owner as TF_Dbs).bt_Trg.Fields[I].FieldName);
      If (Owner as TF_Dbs).bt_Trg.FindField((Owner as TF_Dbs).bt_Trg.Fields[I].FieldName)<>nil then begin
        ChLB_Flds.Checked[I] := TRUE;
      end else ChLB_Flds.ItemEnabled[I] := FALSE;
    end;
  end;

  CloseFile (mT);
  FreeAndNil (mCut);
  CE_IndexName.Clear;
  CE_IndexName.Items.Add ('');
  For I:=0 to (Owner as TF_Dbs).bt_Trg.IndexDefs.Count-1 do begin
    CE_IndexName.Items.Add ((Owner as TF_Dbs).bt_Trg.IndexDefs.Items[I].Name);
  end;
  (Owner as TF_Dbs).bt_Trg.Active := FALSE;
end;

procedure TF_BtrUtilI.FillBtrFlds;
var
  mTblName:string;
  mTblExt:string;
  I:longint;
begin
  (Owner as TF_Dbs).bt_Trg.Active := FALSE;
  mTblName := ExtractFileName ((Owner as TF_Dbs).bt_DBLst.FieldByName ('DBName').AsString);
  If Pos ('.',mTblName)>1 then Delete (mTblName,Pos ('.',mTblName),Length (mTblName));
  E_TrgDefFile.Text := gPath.DefPath+RemEndNumsDef (mTblName)+'.BDF';

  mTblExt := ExtractFileExt ((Owner as TF_Dbs).bt_DBLst.FieldByName ('DBName').AsString);
  If Pos ('.',mTblExt)=1 then Delete (mTblExt,1,1);
  (Owner as TF_Dbs).bt_Trg.DatabaseName := E_TrgPath.Text;
  (Owner as TF_Dbs).bt_Trg.DefName := RemEndNumsDef (mTblName)+'.BDF';
  (Owner as TF_Dbs).bt_Trg.DefPath := gPath.DefPath;
  (Owner as TF_Dbs).bt_Trg.TableName := mTblName;
  (Owner as TF_Dbs).bt_Trg.TableNameExt := mTblExt;
  (Owner as TF_Dbs).bt_Trg.Active := TRUE;

  (Owner as TF_Dbs).bt_Src.DatabaseName := E_SrcPath.Text;
  (Owner as TF_Dbs).bt_Src.DefName := ExtractFileName (E_TrgDefFile.Text);
  (Owner as TF_Dbs).bt_Src.DefPath := ExtractFilePath (E_TrgDefFile.Text);
  (Owner as TF_Dbs).bt_Src.TableName := mTblName;
  (Owner as TF_Dbs).bt_Src.TableNameExt := 'BTR';
  (Owner as TF_Dbs).bt_Src.Active := TRUE;

  ChLB_Flds.Clear;
  For I:=0 to (Owner as TF_Dbs).bt_Src.Fields.Count-1 do begin
    ChLB_Flds.Items.Add ((Owner as TF_Dbs).bt_Src.Fields[I].FieldName);
    If (Owner as TF_Dbs).bt_Trg.FindField((Owner as TF_Dbs).bt_Src.Fields[I].FieldName)<>nil then begin
      ChLB_Flds.Checked[I] := TRUE;
    end else ChLB_Flds.ItemEnabled[I] := FALSE;
  end;

  CE_IndexName.Clear;
  CE_IndexName.Items.Add ('');
  For I:=0 to (Owner as TF_Dbs).bt_Trg.IndexDefs.Count-1 do begin
    CE_IndexName.Items.Add ((Owner as TF_Dbs).bt_Trg.IndexDefs.Items[I].Name);
  end;
  (Owner as TF_Dbs).bt_Trg.Active := FALSE;
  (Owner as TF_Dbs).bt_Src.Active := FALSE;
end;

function  TF_BtrUtilI.FindItemInStringList (pSList:TStrings;pS:string):boolean;
var I:longint;
begin
  Result := FALSE;
  I := 0;
  While (I<pSList.Count) and not Result do begin
    Result := pSList.Strings[I]=pS;
    Inc (I);
  end;
end;

procedure TF_BtrUtilI.ImportInStandard;
var
  I:longint;
  mCnt:longint;
  mFldS:TField;
  mFldT:TField;
  mTblName:string;
  mTblExt:string;
  mFldName:string;
  mFldNums: array [1..500] of record mTrg:longint; mSrc:longint end;
  mFldCnt:longint;
  mFldData:array [1..5] of string;
  mIndexNum:longint;
begin
  mFldCnt := 0;
  For I:=1 to 500 do begin
    mFldNums[I].mTrg := 0;
    mFldNums[I].mSrc := 0;
  end;
  mTblName := ExtractFileName ((Owner as TF_Dbs).bt_DBLst.FieldByName ('DBName').AsString);
  If Pos ('.',mTblName)>1 then Delete (mTblName,Pos ('.',mTblName),Length (mTblName));
  mTblExt := ExtractFileExt ((Owner as TF_Dbs).bt_DBLst.FieldByName ('DBName').AsString);
  If Pos ('.',mTblExt)=1 then Delete (mTblExt,1,1);

  (Owner as TF_Dbs).T_Stand.Active := FALSE;
  (Owner as TF_Dbs).T_Stand.DatabaseName := E_SrcPath.Text;
  (Owner as TF_Dbs).T_Stand.TableName := mTblName;
  If RB_Paradox.Checked then (Owner as TF_Dbs).T_Stand.TableType := ttParadox;
  If RB_DBase.Checked then (Owner as TF_Dbs).T_Stand.TableType := ttDBase;
  If RB_FoxPro.Checked then (Owner as TF_Dbs).T_Stand.TableType := ttFoxPro;
  If (Owner as TF_Dbs).T_Stand.Exists then begin
    (Owner as TF_Dbs).T_Stand.Active := TRUE;

    (Owner as TF_Dbs).bt_Trg.Active := FALSE;
    (Owner as TF_Dbs).bt_Trg.DatabaseName := E_TrgPath.Text;
    (Owner as TF_Dbs).bt_Trg.DefName := RemEndNumsDef (mTblName)+'.BDF';
    (Owner as TF_Dbs).bt_Trg.DefPath := gPath.DefPath;
    (Owner as TF_Dbs).bt_Trg.TableName := mTblName;
    (Owner as TF_Dbs).bt_Trg.TableNameExt := mTblExt;
    If (Owner as TF_Dbs).bt_Trg.Exists and (CE_IndexName.Text='') and E_DelSrc.Checked then (Owner as TF_Dbs).bt_Trg.DeleteTable;
    (Owner as TF_Dbs).bt_Trg.Modify := FALSE;
    (Owner as TF_Dbs).bt_Trg.Archive := FALSE;
    (Owner as TF_Dbs).bt_Trg.Sended := FALSE;
    (Owner as TF_Dbs).bt_Trg.CreateTable;
    (Owner as TF_Dbs).bt_Trg.Active := TRUE;

    mCnt := 0;
    For I:=0 to ChLB_Flds.Count-1 do begin
      If ChLB_Flds.ItemEnabled[I] and ChLB_Flds.Checked[I] then begin
        mFldName := ChLB_Flds.Items.Strings[I];
        mFldS := (Owner as TF_Dbs).T_Stand.FindField(mFldName);
        mFldT := (Owner as TF_Dbs).bt_Trg.FindField(mFldName);
        If (mFldS<>nil) and (mFldT<>nil) then begin
          Inc (mFldCnt);
          mFldNums[mFldCnt].mSrc := mFldS.FieldNo-1;
          mFldNums[mFldCnt].mTrg := mFldT.FieldNo-1;
        end;
      end;
    end;

    L_RecQnt.Caption := StrIntSepar ((Owner as TF_Dbs).T_Stand.RecordCount,0,TRUE);
    PB_Ind.Position := 0;
    PB_Ind.Max := (Owner as TF_Dbs).T_Stand.RecordCount;
    Application.ProcessMessages;

    If CE_IndexName.Text<>'' then (Owner as TF_Dbs).bt_Trg.IndexName := CE_IndexName.Text;
    Repeat
      try
        If CE_IndexName.Text='' then begin
          (Owner as TF_Dbs).bt_Trg.Insert;
        end else begin
          mFldData[1] := ''; mFldData[2] := ''; mFldData[3] := ''; mFldData[4] := ''; mFldData[5] := '';
          mIndexNum := LineElementNum(L_IndexFields.Caption,';');
          If mIndexNum>5 then mIndexNum := 5;
          For I:=1 to mIndexNum do begin
            try
              mFldData[I] := (Owner as TF_Dbs).T_Stand.FieldByName (LineElement(L_IndexFields.Caption,I-1,';')).AsString;
            except end;
          end;
          FindInTarget (mFldData[1],mFldData[2],mFldData[3],mFldData[4],mFldData[5]);
        end;
        For I:=1 to mFldCnt do begin
          try
            If ChLB_Flds.ItemEnabled[I-1] and ChLB_Flds.Checked[I-1] then (Owner as TF_Dbs).bt_Trg.Fields[mFldNums[I].mTrg].AsString := (Owner as TF_Dbs).T_Stand.Fields[mFldNums[I].mSrc].AsString;
          except end;
        end;
        (Owner as TF_Dbs).bt_Trg.Post;
      except end;
      Inc (mCnt);
      L_RecNum.Caption := StrIntSepar (mCnt,0, TRUE);
      PB_Ind.Position := PB_Ind.Position+1;
      Application.ProcessMessages;
      (Owner as TF_Dbs).T_Stand.Next;
    until (Owner as TF_Dbs).T_Stand.EOF or oExit;

    (Owner as TF_Dbs).T_Stand.Active := FALSE;
    (Owner as TF_Dbs).bt_Trg.Active := FALSE;
  end else MessageDlg('**--** Neexistuje zdrojový súbor'+#13+E_SrcPath.Text+mTblName, mtInformation, [mbOK], 0);
end;

procedure TF_BtrUtilI.ImportInASCII;
var
  I:longint;
  mCnt:longint;
  mFld:TField;
  mTblName:string;
  mTblExt:string;
  mFldName:string;
  mFldNums: array [1..500] of record mTrg:longint; mSrc:longint end;
  mFldCnt:longint;
  mT:TextFile;
  mCut:TTxtCut;
  mFldOK:boolean;
  mS:string;
  mFldData:array [1..5] of string;
  mIndexNum:longint;
  mIndFieldNum:longint;
  mHead:boolean;
  mData:string;
begin
  mFldCnt := 0;
  For I:=1 to 500 do begin
    mFldNums[I].mTrg := 0;
    mFldNums[I].mSrc := 0;
  end;
  oExit := FALSE;
  mTblName := ExtractFileName ((Owner as TF_Dbs).bt_DBLst.FieldByName ('DBName').AsString);
  If Pos ('.',mTblName)>1 then Delete (mTblName,Pos ('.',mTblName),Length (mTblName));
  mTblExt := ExtractFileExt ((Owner as TF_Dbs).bt_DBLst.FieldByName ('DBName').AsString);
  If Pos ('.',mTblExt)=1 then Delete (mTblExt,1,1);

  mCut := TTxtCut.Create;
  AssignFile (mT,E_SrcPath.Text+mTblName+'.TXT');
  mCut.SetDelimiter(Chr (E_Delimiter.Long)); If E_Delimiter.Text='' then mCut.SetDelimiter('');
  mCut.SetSeparator(Chr (E_Separator.Long));
  Reset (mT);
  mCnt := 0;
  mHead := FALSE;
  Repeat
    ReadLn (mT,mS);
    If mCnt=0 then begin
      mCut.SetStr (mS);
      mHEAD := mCut.GetText(1)='*HEAD*';
    end;
    Inc (mCnt);
  until EOF (mT);
  Reset (mT);
  If mHead then ReadLn (mT,mS);
  L_RecQnt.Caption := StrIntSepar (mCnt,0,TRUE);
  PB_Ind.Position := 0;
  PB_Ind.Max := mCnt;

  (Owner as TF_Dbs).bt_Trg.DatabaseName := E_TrgPath.Text;
  (Owner as TF_Dbs).bt_Trg.DefName := RemEndNumsDef (mTblName)+'.BDF';
  (Owner as TF_Dbs).bt_Trg.DefPath := gPath.DefPath;
  (Owner as TF_Dbs).bt_Trg.TableName := mTblName;
  (Owner as TF_Dbs).bt_Trg.TableNameExt := mTblExt;
  If (Owner as TF_Dbs).bt_Trg.Exists and (CE_IndexName.Text='') and E_DelSrc.Checked then (Owner as TF_Dbs).bt_Trg.DeleteTable;
  (Owner as TF_Dbs).bt_Trg.Modify := FALSE;
  (Owner as TF_Dbs).bt_Trg.Archive := FALSE;
  (Owner as TF_Dbs).bt_Trg.Sended := FALSE;
  (Owner as TF_Dbs).bt_Trg.Active := TRUE;
  Application.ProcessMessages;
  For I:=0 to ChLB_Flds.Count-1 do begin
    mFldName := ChLB_Flds.Items.Strings[I];
    Inc (mFldCnt);
    mFldOK := FALSE;
    If mFldName<>'----' then begin
      mFld := (Owner as TF_Dbs).bt_Trg.FindField(mFldName);
      If mFld<>nil then begin
        mFldNums[mFldCnt].mSrc := I+1;
        mFldNums[mFldCnt].mTrg := mFld.FieldNo-1;
        mFldOK := TRUE;
      end;
    end;
    If not mFldOK then begin
      mFldNums[mFldCnt].mSrc := -1;
      mFldNums[mFldCnt].mTrg := -1;
    end;
  end;

  mCnt := 0;
  If CE_IndexName.Text<>'' then (Owner as TF_Dbs).bt_Trg.IndexName := CE_IndexName.Text;
  Repeat
    try
      ReadLn (mT,mS);
      mCut.SetStr (mS);
      If CE_IndexName.Text='' then begin
        (Owner as TF_Dbs).bt_Trg.Insert;
      end else begin
        mFldData[1] := ''; mFldData[2] := ''; mFldData[3] := ''; mFldData[4] := ''; mFldData[5] := '';
        mIndexNum := LineElementNum(L_IndexFields.Caption,';');
        If mIndexNum>5 then mIndexNum := 5;
        For I:=1 to mIndexNum do begin
          mIndFieldNum := ChLB_Flds.Items.IndexOf(LineElement(L_IndexFields.Caption,I-1,';'))+1;
          If mIndFieldNum >0 then mFldData[I] := RemRightSpaces (RemLeftSpaces (mCut.GetText(mIndFieldNum)));
        end;
        FindInTarget (mFldData[1],mFldData[2],mFldData[3],mFldData[4],mFldData[5]);
      end;
      For I:=1 to mFldCnt do begin
        try
          If mFldNums[I].mTrg<>-1 then begin
            mData := RemRightSpaces (RemLeftSpaces (mCut.GetText(mFldNums[I].mSrc)));
            If (Owner as TF_Dbs).bt_Trg.Fields[mFldNums[I].mTrg].DataType in [ftFloat,ftCurrency] then mData := ReplaceStr(mData,'.',',');
            If ChLB_Flds.ItemEnabled[I-1] and ChLB_Flds.Checked[I-1] then (Owner as TF_Dbs).bt_Trg.Fields[mFldNums[I].mTrg].AsString := mData;
          end;
        except end;
      end;
      (Owner as TF_Dbs).bt_Trg.Post;
    except (Owner as TF_Dbs).bt_Trg.Cancel; end;

    Inc (mCnt);
    L_RecNum.Caption := StrIntSepar (mCnt,0, TRUE);
    PB_Ind.Position := PB_Ind.Position+1;
    Application.ProcessMessages;
  until EOF (mT) or oExit;

  CloseFile (mT);
  FreeAndNil (mCut);
  (Owner as TF_Dbs).bt_Trg.Close;
end;

procedure TF_BtrUtilI.ImportInBtr;
var
  I:longint;
  mCnt:longint;
  mFldS:TField;
  mFldT:TField;
  mTblName:string;
  mTblExt:string;
  mFldName:string;
  mFldNums: array [1..500] of record mTrg:longint; mSrc:longint end;
  mFldCnt:longint;
  mFldData:array [1..5] of string;
  mIndexNum:longint;
begin
  mFldCnt := 0;
  For I:=1 to 500 do begin
    mFldNums[I].mTrg := 0;
    mFldNums[I].mSrc := 0;
  end;
  oExit := FALSE;
  mTblName := ExtractFileName ((Owner as TF_Dbs).bt_DBLst.FieldByName ('DBName').AsString);
  If Pos ('.',mTblName)>1 then Delete (mTblName,Pos ('.',mTblName),Length (mTblName));
  mTblExt := ExtractFileExt ((Owner as TF_Dbs).bt_DBLst.FieldByName ('DBName').AsString);
  If Pos ('.',mTblExt)=1 then Delete (mTblExt,1,1);
  (Owner as TF_Dbs).bt_Trg.DatabaseName := E_TrgPath.Text;
  (Owner as TF_Dbs).bt_Trg.DefName := RemEndNumsDef (mTblName)+'.BDF';
  (Owner as TF_Dbs).bt_Trg.DefPath := gPath.DefPath;
  (Owner as TF_Dbs).bt_Trg.TableName := mTblName;
  (Owner as TF_Dbs).bt_Trg.TableNameExt := mTblExt;
  If (Owner as TF_Dbs).bt_Trg.Exists and (CE_IndexName.Text='') then (Owner as TF_Dbs).bt_Trg.DeleteTable;
  (Owner as TF_Dbs).bt_Trg.Modify := FALSE;
  (Owner as TF_Dbs).bt_Trg.Archive := FALSE;
  (Owner as TF_Dbs).bt_Trg.Sended := FALSE;
  (Owner as TF_Dbs).bt_Trg.Active := TRUE;

  (Owner as TF_Dbs).bt_Src.DatabaseName := E_SrcPath.Text;
  (Owner as TF_Dbs).bt_Src.DefName := ExtractFileName (E_TrgDefFile.Text);
  (Owner as TF_Dbs).bt_Src.DefPath := ExtractFilePath (E_TrgDefFile.Text);
  (Owner as TF_Dbs).bt_Src.TableName := mTblName;
  (Owner as TF_Dbs).bt_Src.TableNameExt := 'BTR';
  (Owner as TF_Dbs).bt_Src.Active := TRUE;

  L_RecQnt.Caption := StrIntSepar ((Owner as TF_Dbs).bt_Src.RecordCount,0,TRUE);
  PB_Ind.Position := 0;
  PB_Ind.Max := (Owner as TF_Dbs).bt_Src.RecordCount;
  Application.ProcessMessages;

  mCnt := 0;
  For I:=0 to ChLB_Flds.Count-1 do begin
    If ChLB_Flds.ItemEnabled[I] and ChLB_Flds.Checked[I] then begin
      mFldName := ChLB_Flds.Items.Strings[I];
      mFldS := (Owner as TF_Dbs).bt_Src.FindField(mFldName);
      mFldT := (Owner as TF_Dbs).bt_Trg.FindField(mFldName);
      If (mFldS<>nil) and (mFldT<>nil) then begin
        Inc (mFldCnt);
        mFldNums[mFldCnt].mSrc := mFldS.FieldNo-1;
        mFldNums[mFldCnt].mTrg := mFldT.FieldNo-1;
      end;
    end;
  end;

  If CE_IndexName.Text<>'' then (Owner as TF_Dbs).bt_Trg.IndexName := CE_IndexName.Text;
  Repeat
    try
      If CE_IndexName.Text='' then begin
        (Owner as TF_Dbs).bt_Trg.Insert;
      end else begin
        mFldData[1] := ''; mFldData[2] := ''; mFldData[3] := ''; mFldData[4] := ''; mFldData[5] := '';
        mIndexNum := LineElementNum(L_IndexFields.Caption,';');
        If mIndexNum>5 then mIndexNum := 5;
        For I:=1 to mIndexNum do begin
          try
            mFldData[I] := (Owner as TF_Dbs).bt_Src.FieldByName (LineElement(L_IndexFields.Caption,I-1,';')).AsString;
          except end;
        end;
        FindInTarget (mFldData[1],mFldData[2],mFldData[3],mFldData[4],mFldData[5]);
      end;
      For I:=1 to mFldCnt do begin
        try
          If ChLB_Flds.ItemEnabled[I-1] and ChLB_Flds.Checked[I-1] then (Owner as TF_Dbs).bt_Trg.Fields[mFldNums[I].mTrg].AsString := (Owner as TF_Dbs).bt_Src.Fields[mFldNums[I].mSrc].AsString;
        except end;
      end;
      (Owner as TF_Dbs).bt_Trg.Post;
    except (Owner as TF_Dbs).bt_Trg.Cancel; end;

    Inc (mCnt);
    L_RecNum.Caption := StrIntSepar (mCnt,0, TRUE);
    PB_Ind.Position := PB_Ind.Position+1;
    Application.ProcessMessages;
    (Owner as TF_Dbs).bt_Src.Next;
  until (Owner as TF_Dbs).bt_Src.EOF or oExit;
  (Owner as TF_Dbs).bt_Src.Active := FALSE;
  (Owner as TF_Dbs).bt_Trg.Active := FALSE;
end;

procedure TF_BtrUtilI.FindInTarget (pFld1,pFld2,pFld3,pFld4,pFld5:string);
var
  mFind:boolean;
  mIndexNum:longint;
begin
  mIndexNum := LineElementNum(L_IndexFields.Caption,';');
  mFind := FALSE;
  case mIndexNum of
    1: mFind := (Owner as TF_Dbs).bt_Trg.FindKey([pFld1]);
    2: mFind := (Owner as TF_Dbs).bt_Trg.FindKey([pFld1,pFld2]);
    3: mFind := (Owner as TF_Dbs).bt_Trg.FindKey([pFld1,pFld2,pFld3]);
    4: mFind := (Owner as TF_Dbs).bt_Trg.FindKey([pFld1,pFld2,pFld3,pFld4]);
    5: mFind := (Owner as TF_Dbs).bt_Trg.FindKey([pFld1,pFld2,pFld3,pFld4,pFld5]);
  end;
  If mFind
    then (Owner as TF_Dbs).bt_Trg.Edit
    else (Owner as TF_Dbs).bt_Trg.Insert;
end;

procedure TF_BtrUtilI.BB_ImportClick(Sender: TObject);
begin
  oExit := FALSE;
  If RB_Paradox.Checked or RB_DBase.Checked or RB_FoxPro.Checked then ImportInStandard;
  If RB_ASCII.Checked then ImportInASCII;
  If RB_Btr.Checked then ImportInBtr;
  L_RecNum.Caption := StrIntSepar (0,0,TRUE);
  L_RecQnt.Caption := StrIntSepar (0,0,TRUE);
  PB_Ind.Position := 0;
  PB_Ind.Max := 0;
end;

procedure TF_BtrUtilI.RB_StandardClick(Sender: TObject);
begin
  GB_ASCII.Visible := FALSE;
  GB_Btr.Visible := FALSE;
  BB_EmptyFld.Enabled := FALSE;
  SB_Up.Enabled := FALSE;
  SB_Down.Enabled := FALSE;
  FillStandardFlds;
end;

procedure TF_BtrUtilI.BB_CancelClick(Sender: TObject);
begin
  oExit := TRUE;
end;

procedure TF_BtrUtilI.FormActivate(Sender: TObject);
begin
  E_SrcPath.Text := gPath.ExpPath;
  E_TrgPath.Text := gPath.ImpPath;
end;

procedure TF_BtrUtilI.RB_BtrClick(Sender: TObject);
begin
  GB_ASCII.Visible := FALSE;
  GB_Btr.Visible := TRUE;
  BB_EmptyFld.Enabled := FALSE;
  SB_Up.Enabled := FALSE;
  SB_Down.Enabled := FALSE;
  FillBtrFlds;
end;

procedure TF_BtrUtilI.SpeedButton1Click(Sender: TObject);
begin
  OD_Open.InitialDir := ExtractFilePath(E_SrcPath.Text);
  OD_Open.FileName := '';
  If OD_Open.Execute then begin
    E_SrcPath.Text := ExtractFilePath(OD_Open.FileName);
//    E_SrcDefFileExit(Sender);
  end;
end;

procedure TF_BtrUtilI.SpeedButton3Click(Sender: TObject);
begin
  OD_Open.InitialDir := ExtractFilePath(E_TrgPath.Text);
  OD_Open.FileName := '';
  If OD_Open.Execute then begin
    E_TrgPath.Text := ExtractFilePath(OD_Open.FileName);
//    E_TrgDefFileExit(Sender);
  end;
end;

procedure TF_BtrUtilI.RB_ASCIIClick(Sender: TObject);
begin
  GB_ASCII.Visible := TRUE;
  GB_Btr.Visible := FALSE;
  BB_EmptyFld.Enabled := TRUE;
  SB_Up.Enabled := TRUE;
  SB_Down.Enabled := TRUE;
  FillASCIIFlds;
end;

procedure TF_BtrUtilI.CE_IndexNameChange(Sender: TObject);
begin
  L_IndexFields.Caption := '';
  If CE_IndexName.Text<>'' then begin
    L_IndexFields.Caption := (Owner as TF_Dbs).bt_Trg.IndexDefs.Items[CE_IndexName.ItemIndex-1].Fields;
  end;
end;

procedure TF_BtrUtilI.ChLB_FldsDragOver(Sender, Source: TObject; X,
  Y: Integer; State: TDragState; var Accept: Boolean);
begin
  Accept := Source is TCheckListBox;
end;

procedure TF_BtrUtilI.ChLB_FldsDragDrop(Sender, Source: TObject; X,
  Y: Integer);
var
  mRect:TRect;
  mNewPos:TPoint;
  mIndex:integer;
begin
  If (Sender is TCheckListBox) and (Source is TCheckListBox) then begin
    If (Source as TCheckListBox).Name='ChLB_Flds' then begin
      mRect := ChLB_Flds.ItemRect(ChLB_Flds.ItemIndex);
      mNewPos.X := X;
      mNewPos.Y := Y;
      mIndex := ChLB_Flds.ItemIndex;
      ChLB_Flds.ItemIndex := ChLB_Flds.ItemAtPos (mNewPos,TRUE);
      ChLB_Flds.Items.Move (mIndex,ChLB_Flds.ItemIndex);
      ChLB_Flds.Selected[ChLB_Flds.ItemIndex] := TRUE;
    end;
  end;
end;

procedure TF_BtrUtilI.BB_EmptyFldClick(Sender: TObject);
begin
  ChLB_Flds.Items.Add('----');
end;

procedure TF_BtrUtilI.SB_UpClick(Sender: TObject);
var mIt:integer;
begin
  If ChLB_Flds.ItemIndex>0 then begin
    mIt := ChLB_Flds.ItemIndex;
    ChLB_Flds.Items.Move (mIt,mIt-1);
    ChLB_Flds.ItemIndex := mIt-1;
    ChLB_Flds.Selected[ChLB_Flds.ItemIndex] := TRUE;
  end;
end;

procedure TF_BtrUtilI.SB_DownClick(Sender: TObject);
var mIt:integer;
begin
  If (ChLB_Flds.ItemIndex>=0) and (ChLB_Flds.ItemIndex<ChLB_Flds.Items.Count-1) then begin
    mIt := ChLB_Flds.ItemIndex;
    ChLB_Flds.Items.Move (mIt,mIt+1);
    ChLB_Flds.ItemIndex := mIt+1;
    ChLB_Flds.Selected[ChLB_Flds.ItemIndex] := TRUE;
  end;
end;

procedure TF_BtrUtilI.ChLB_FldsDblClick(Sender: TObject);
begin
  If ChLB_Flds.Items[ChLB_Flds.ItemIndex]='----' then ChLB_Flds.Items.Delete (ChLB_Flds.ItemIndex);
end;

end.

