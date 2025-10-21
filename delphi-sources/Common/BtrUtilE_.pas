unit BtrUtilE_;

interface

uses
  LangForm, NexPath, IcConv, DBTables, TxtWrap,IcTools,
  DB, Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, IcEditors, Buttons, ExtCtrls, ComCtrls, CheckLst,
  IcStand, xpComp;

type
  TF_BtrUtilE = class(TLangForm)
    P_Flds: TPanel;
    L_Database: TLabel;
    LB_AllFields: TListBox;
    SB_CopySelItm: TSpeedButton;
    SB_RemoveSelItm: TSpeedButton;
    SB_CopyAllItm: TSpeedButton;
    SB_RemoveAllItm: TSpeedButton;
    SB_Up: TSpeedButton;
    SB_Down: TSpeedButton;
    LB_Trg: TListBox;
    L_Show: TLabel;
    GroupBox1: TGroupBox;
    RB_Paradox: TRadioButton;
    RB_DBase: TRadioButton;
    RB_FoxPro: TRadioButton;
    RB_ASCII: TRadioButton;
    RB_Btr: TRadioButton;
    Label1: TLabel;
    SpeedButton1: TSpeedButton;
    BB_Export: TBitBtn;
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
    BB_EmptyFld: TBitBtn;
    GB_Btr: TGroupBox;
    Label5: TLabel;
    SpeedButton2: TSpeedButton;
    BB_Cancel: TBitBtn;
    E_TrgDefFile: TEdit;
    OD_Open: TOpenDialog;
    ChB_FixFldSize: TCheckButton;
    ChB_SaveFldNames: TCheckButton;
    E_TrgPath: TNameEdit;
    RB_DBaseDef: TRadioButton;
    L_TblName: TxpLabel;
    procedure SB_CopySelItmClick(Sender: TObject);
    procedure SB_RemoveSelItmClick(Sender: TObject);
    procedure SB_CopyAllItmClick(Sender: TObject);
    procedure SB_RemoveAllItmClick(Sender: TObject);
    procedure LB_AllFieldsDblClick(Sender: TObject);
    procedure LB_TrgDblClick(Sender: TObject);
    procedure LB_AllFieldsDragDrop(Sender, Source: TObject; X, Y: Integer);
    procedure LB_AllFieldsDragOver(Sender, Source: TObject; X, Y: Integer;
      State: TDragState; var Accept: Boolean);
    procedure LB_TrgDragDrop(Sender, Source: TObject; X, Y: Integer);
    procedure LB_TrgDragOver(Sender, Source: TObject; X, Y: Integer;
      State: TDragState; var Accept: Boolean);
    procedure SB_UpClick(Sender: TObject);
    procedure SB_DownClick(Sender: TObject);
    procedure BB_EmptyFldClick(Sender: TObject);
    procedure RB_TypeClick(Sender: TObject);
    procedure BB_CancelClick(Sender: TObject);
    procedure E_TrgDefFileExit(Sender: TObject);
    procedure SpeedButton2Click(Sender: TObject);
    procedure SpeedButton1Click(Sender: TObject);
    procedure BB_ExportClick(Sender: TObject);
  private
    oExit    :boolean;

    procedure FillTrgFld;
    function  FindItemInStringList (pSList:TStrings;pS:string):boolean;
    procedure ExportToStandard;
    procedure ExportToASCII;
    procedure ExportToBtr;
    { Private declarations }
  public
    procedure Execute;
    procedure FillSrcFlds;
    { Public declarations }
  end;

var
  F_BtrUtilE: TF_BtrUtilE;

implementation

  uses Dbs_F;
{$R *.dfm}

procedure TF_BtrUtilE.Execute;
begin
  FillSrcFlds;
  ShowModal;
end;

procedure TF_BtrUtilE.FillSrcFlds;
var
  mTblName:string;
  mTblExt:string;
  I:longint;
begin
  E_TrgPath.Text := gPath.ExpPath;
  E_Delimiter.Long := 254;
  E_Separator.Long := 44;
  (Owner as TF_Dbs).bt_Src.Active := FALSE;
  mTblName := ExtractFileName ((Owner as TF_Dbs).bt_DBLst.FieldByName ('DBName').AsString);
  L_TblName.Caption:=mTblName;
  If Pos ('.',mTblName)>1 then Delete (mTblName,Pos ('.',mTblName),Length (mTblName));
  E_TrgDefFile.Text := gPath.DefPath+RemEndNumsDef (mTblName)+'.BDF';

  mTblExt := ExtractFileExt ((Owner as TF_Dbs).bt_DBLst.FieldByName ('DBName').AsString);
  If Pos ('.',mTblExt)=1 then Delete (mTblExt,1,1);
  (Owner as TF_Dbs).bt_Src.DatabaseName := (Owner as TF_Dbs).bt_DBLst.FieldByName ('DBPath').AsString;
  (Owner as TF_Dbs).bt_Src.DefName := RemEndNumsDef (mTblName)+'.BDF';
  (Owner as TF_Dbs).bt_Src.DefPath := gPath.DefPath;
  (Owner as TF_Dbs).bt_Src.TableName := mTblName;
  (Owner as TF_Dbs).bt_Src.TableNameExt := mTblExt;
  (Owner as TF_Dbs).bt_Src.Active := TRUE;

  LB_AllFields.Clear;
  LB_Trg.Clear;
  For I:=0 to (Owner as TF_Dbs).bt_Src.FieldDefs.Count-1 do begin
    LB_AllFields.Items.Add ((Owner as TF_Dbs).bt_Src.FieldDefs.Items[I].Name);
    LB_Trg.Items.Add ((Owner as TF_Dbs).bt_Src.FieldDefs.Items[I].Name);
  end;
  (Owner as TF_Dbs).bt_Src.Active := FALSE;
end;

procedure TF_BtrUtilE.FillTrgFld;
var
  mTblName:string;
  mTblExt:string;
  I:longint;
begin
  (Owner as TF_Dbs).bt_Trg.Active := FALSE;
  mTblName := ExtractFileName ((Owner as TF_Dbs).bt_DBLst.FieldByName ('DBName').AsString);
  If Pos ('.',mTblName)>1 then Delete (mTblName,Pos ('.',mTblName),Length (mTblName));

  mTblExt := ExtractFileExt ((Owner as TF_Dbs).bt_DBLst.FieldByName ('DBName').AsString);
  If Pos ('.',mTblExt)=1 then Delete (mTblExt,1,1);
  (Owner as TF_Dbs).bt_Trg.DatabaseName := E_TrgPath.Text;
  (Owner as TF_Dbs).bt_Trg.DefName := ExtractFileName (E_TrgDefFile.Text);
  (Owner as TF_Dbs).bt_Trg.DefPath := ExtractFilePath (E_TrgDefFile.Text);
  (Owner as TF_Dbs).bt_Trg.TableName := mTblName;
  (Owner as TF_Dbs).bt_Trg.TableNameExt := 'BTR';
  (Owner as TF_Dbs).bt_Trg.Active := TRUE;

  LB_Trg.Clear;
  For I:=0 to (Owner as TF_Dbs).bt_Trg.FieldDefs.Count-1 do begin
    LB_Trg.Items.Add ((Owner as TF_Dbs).bt_Src.FieldDefs.Items[I].Name);
  end;
  (Owner as TF_Dbs).bt_Trg.Active := FALSE;
end;

function  TF_BtrUtilE.FindItemInStringList (pSList:TStrings;pS:string):boolean;
var I:longint;
begin
  Result := FALSE;
  I := 0;
  While (I<pSList.Count) and not Result do begin
    Result := pSList.Strings[I]=pS;
    Inc (I);
  end;
end;

procedure TF_BtrUtilE.ExportToStandard;
var
  I:longint;
  mCnt:longint;
  mFld:TField;
  mTblName:string;
  mTblExt:string;
  mFldName:string;
  mFldNums: array [1..500] of record mTrg:longint; mSrc:longint end;
  mFldCnt:longint;
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

  (Owner as TF_Dbs).bt_Src.Active := FALSE;
  (Owner as TF_Dbs).bt_Src.DatabaseName := (Owner as TF_Dbs).bt_DBLst.FieldByName ('DBPath').AsString;
  (Owner as TF_Dbs).bt_Src.DefName := RemEndNumsDef (mTblName)+'.BDF';
  (Owner as TF_Dbs).bt_Src.DefPath := gPath.DefPath;
  (Owner as TF_Dbs).bt_Src.TableName := mTblName;
  (Owner as TF_Dbs).bt_Src.TableNameExt := mTblExt;
  (Owner as TF_Dbs).bt_Src.Active := TRUE;

  L_RecQnt.Caption := StrIntSepar ((Owner as TF_Dbs).bt_Src.RecordCount,0,TRUE);
  PB_Ind.Position := 0;
  PB_Ind.Max := (Owner as TF_Dbs).bt_Src.RecordCount;
  Application.ProcessMessages;

  (Owner as TF_Dbs).T_Stand.DatabaseName := E_TrgPath.Text;
  (Owner as TF_Dbs).T_Stand.TableName := mTblName;

  If RB_Paradox.Checked then (Owner as TF_Dbs).T_Stand.TableType := ttParadox;
  If RB_DBase.Checked then (Owner as TF_Dbs).T_Stand.TableType := ttDBase;
  If RB_FoxPro.Checked then (Owner as TF_Dbs).T_Stand.TableType := ttFoxPro;
  If RB_DBaseDef.Checked then (Owner as TF_Dbs).T_Stand.TableType := ttDefault;

  (Owner as TF_Dbs).T_Stand.FieldDefs.Clear;
  (Owner as TF_Dbs).T_Stand.IndexDefs.Clear;
  mCnt := 0;
  For I:=0 to LB_Trg.Count-1 do begin
    mFldName := LB_Trg.Items.Strings[I];
    mFld := (Owner as TF_Dbs).bt_Src.FindField(mFldName);
    If mFld<>nil then begin
      Inc (mFldCnt);
      mFldNums[mFldCnt].mSrc := mFld.FieldNo-1;
      mFldNums[mFldCnt].mTrg := I;
      (Owner as TF_Dbs).T_Stand.FieldDefs.Add(mFld.FieldName,mFld.DataType,mFld.Size,FALSE);
    end;
  end;
  (Owner as TF_Dbs).T_Stand.CreateTable;
  (Owner as TF_Dbs).T_Stand.Active := TRUE;

  Repeat
    try
      (Owner as TF_Dbs).T_Stand.Insert;
      For I:=1 to mFldCnt do begin
        try
          (Owner as TF_Dbs).T_Stand.Fields[mFldNums[I].mTrg].AsString := (Owner as TF_Dbs).bt_Src.Fields[mFldNums[I].mSrc].AsString;
        except end;
      end;
      (Owner as TF_Dbs).T_Stand.Post;
    except end;
    Inc (mCnt);
    L_RecNum.Caption := StrIntSepar (mCnt,0, TRUE);
    PB_Ind.Position := PB_Ind.Position+1;
    Application.ProcessMessages;
    (Owner as TF_Dbs).bt_Src.Next;
  until (Owner as TF_Dbs).bt_Src.EOF or oExit;
  (Owner as TF_Dbs).T_Stand.Close;
  (Owner as TF_Dbs).bt_Src.Close;
end;

procedure TF_BtrUtilE.ExportToASCII;
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
  mWrap:TTxtWrap;
  mFldOK:boolean;
  mType:TFieldType;
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
  (Owner as TF_Dbs).bt_Src.DatabaseName := (Owner as TF_Dbs).bt_DBLst.FieldByName ('DBPath').AsString;
  (Owner as TF_Dbs).bt_Src.DefName := RemEndNumsDef (mTblName)+'.BDF';
  (Owner as TF_Dbs).bt_Src.DefPath := gPath.DefPath;
  (Owner as TF_Dbs).bt_Src.TableName := mTblName;
  (Owner as TF_Dbs).bt_Src.TableNameExt := mTblExt;
  (Owner as TF_Dbs).bt_Src.Active := TRUE;
  L_RecQnt.Caption := StrIntSepar ((Owner as TF_Dbs).bt_Src.RecordCount,0,TRUE);
  PB_Ind.Position := 0;
  PB_Ind.Max := (Owner as TF_Dbs).bt_Src.RecordCount;
  Application.ProcessMessages;

  mWrap := TTxtWrap.Create;
  mWrap.SetDelimiter(Chr (E_Delimiter.Long));
  mWrap.SetSeparator(Chr (E_Separator.Long));
  AssignFile (mT,E_TrgPath.Text+mTblName+'.TXT');
  {$I-}Rewrite(mT);{$I+}
  If (IOResult=0) and((Owner as TF_Dbs).bt_Src.RecordCount>0) then begin
    For I:=0 to LB_Trg.Count-1 do begin
      mFldName := LB_Trg.Items.Strings[I];
      Inc (mFldCnt);
      mFldOK := FALSE;
      If mFldName<>'----' then begin
        mFld := (Owner as TF_Dbs).bt_Src.FindField(mFldName);
        If mFld<>nil then begin
          mFldNums[mFldCnt].mSrc := mFld.FieldNo-1;
          mFldNums[mFldCnt].mTrg := I;
          mFldOK := TRUE;
        end;
      end;
      If not mFldOK then begin
        mFldNums[mFldCnt].mSrc := -1;
        mFldNums[mFldCnt].mTrg := -1;
      end;
    end;
    If ChB_SaveFldNames.Checked then begin
      mWrap.ClearWrap;
      mWrap.SetText ('*HEAD*',0);
      For I:=0 to LB_Trg.Count-1 do
        mWrap.SetText (LB_Trg.Items.Strings[I],0);
      WriteLn (mT, mWrap.GetWrapText);
    end;
    Repeat
      try
        mWrap.ClearWrap;
        For I:=1 to LB_Trg.Count do begin
          try
            If mFldNums[I].mTrg<>-1 then begin
              If ChB_FixFldSize.Checked then begin
                mType := (Owner as TF_Dbs).bt_Src.Fields[mFldNums[I].mSrc].DataType;
                case mType of
                  ftString,ftWideString: mWrap.SetText ((Owner as TF_Dbs).bt_Src.Fields[mFldNums[I].mSrc].AsString,(Owner as TF_Dbs).bt_Src.Fields[mFldNums[I].mSrc].DataSize);
                  ftSmallint,ftInteger,ftLargeint: mWrap.SetNum ((Owner as TF_Dbs).bt_Src.Fields[mFldNums[I].mSrc].AsInteger,8);
                  ftWord: mWrap.SetNum ((Owner as TF_Dbs).bt_Src.Fields[mFldNums[I].mSrc].AsInteger,5);
                  ftBytes: mWrap.SetNum ((Owner as TF_Dbs).bt_Src.Fields[mFldNums[I].mSrc].AsInteger,3);
                  ftFloat,ftCurrency : mWrap.SetReal ((Owner as TF_Dbs).bt_Src.Fields[mFldNums[I].mSrc].AsFloat,12,3);
                  ftDate: mWrap.SetText ((Owner as TF_Dbs).bt_Src.Fields[mFldNums[I].mSrc].AsString,10);
                  ftTime: mWrap.SetText ((Owner as TF_Dbs).bt_Src.Fields[mFldNums[I].mSrc].AsString,8);
                  ftDateTime: mWrap.SetText ((Owner as TF_Dbs).bt_Src.Fields[mFldNums[I].mSrc].AsString,20);
                end;
              end else mWrap.SetText ((Owner as TF_Dbs).bt_Src.Fields[mFldNums[I].mSrc].AsString,0);
            end else mWrap.SetText ('',0);
          except end;
        end;
        WriteLn (mT, mWrap.GetWrapText);
      except end;
      Inc (mCnt);
      L_RecNum.Caption := StrIntSepar (mCnt,0, TRUE);
      PB_Ind.Position := PB_Ind.Position+1;
      Application.ProcessMessages;
      (Owner as TF_Dbs).bt_Src.Next;
    until (Owner as TF_Dbs).bt_Src.EOF or oExit;
    CloseFile (mT);
  end;
  FreeAndNil (mWrap);
  (Owner as TF_Dbs).bt_Src.Close;
end;

procedure TF_BtrUtilE.ExportToBtr;
var
  I:longint;
  mCnt:longint;
  mFld:TField;
  mTblName:string;
  mTblExt:string;
  mFldName:string;
  mFldNums: array [1..500] of record mTrg:longint; mSrc:longint end;
  mFldCnt:longint;
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
  (Owner as TF_Dbs).bt_Src.DatabaseName := (Owner as TF_Dbs).bt_DBLst.FieldByName ('DBPath').AsString;
  (Owner as TF_Dbs).bt_Src.DefName := RemEndNumsDef (mTblName)+'.BDF';
  (Owner as TF_Dbs).bt_Src.DefPath := gPath.DefPath;
  (Owner as TF_Dbs).bt_Src.TableName := mTblName;
  (Owner as TF_Dbs).bt_Src.TableNameExt := mTblExt;
  (Owner as TF_Dbs).bt_Src.Active := TRUE;
  L_RecQnt.Caption := StrIntSepar ((Owner as TF_Dbs).bt_Src.RecordCount,0,TRUE);
  PB_Ind.Position := 0;
  PB_Ind.Max := (Owner as TF_Dbs).bt_Src.RecordCount;
  Application.ProcessMessages;

  (Owner as TF_Dbs).bt_Trg.DatabaseName := E_TrgPath.Text;
  (Owner as TF_Dbs).bt_Trg.DefName := ExtractFileName (E_TrgDefFile.Text);
  (Owner as TF_Dbs).bt_Trg.DefPath := ExtractFilePath (E_TrgDefFile.Text);
  (Owner as TF_Dbs).bt_Trg.TableName := mTblName;
  (Owner as TF_Dbs).bt_Trg.TableNameExt := 'BTR';
  (Owner as TF_Dbs).bt_Trg.Modify := FALSE;
  (Owner as TF_Dbs).bt_Trg.Archive := FALSE;
  (Owner as TF_Dbs).bt_Trg.Sended := FALSE;
  If (Owner as TF_Dbs).bt_Trg.Exists then (Owner as TF_Dbs).bt_Trg.DeleteTable;
  (Owner as TF_Dbs).bt_Trg.CreateTable;
  (Owner as TF_Dbs).bt_Trg.Active := TRUE;

  mCnt := 0;
  For I:=1 to (Owner as TF_Dbs).bt_Src.FieldCount do begin
    mFldName := (Owner as TF_Dbs).bt_Src.Fields[I-1].FieldName;
    If FindItemInStringList (LB_Trg.Items,mFldName) then begin
      mFld := (Owner as TF_Dbs).bt_Trg.FindField(mFldName);
      If mFld<>nil then begin
        Inc (mFldCnt);
        mFldNums[mFldCnt].mSrc := I-1;
        mFldNums[mFldCnt].mTrg := mFld.FieldNo-1;
      end;
    end;
  end;
  Repeat
    try
      (Owner as TF_Dbs).bt_Trg.Insert;
      For I:=1 to mFldCnt do begin
        try
          (Owner as TF_Dbs).bt_Trg.Fields[mFldNums[I].mTrg].AsString := (Owner as TF_Dbs).bt_Src.Fields[mFldNums[I].mSrc].AsString;
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
  (Owner as TF_Dbs).bt_Trg.Close;
  (Owner as TF_Dbs).bt_Src.Close;
end;

procedure TF_BtrUtilE.SB_CopySelItmClick(Sender: TObject);
var
  I:integer;
  mTab:integer;
begin
  If LB_AllFields.SelCount>0 then begin
    mTab := LB_AllFields.ItemIndex;
    I := 0;
    While (I<LB_AllFields.Items.Count) do begin
      If LB_AllFields.Selected[I] and not FindItemInStringList (LB_Trg.Items,LB_AllFields.Items.Strings[I])
        then LB_Trg.Items.Add (LB_AllFields.Items.Strings[I]);
      Inc (I);
    end;
    If mTab<LB_AllFields.Items.Count
      then LB_AllFields.ItemIndex := mTab
      else LB_AllFields.ItemIndex := LB_AllFields.Items.Count-1;
    LB_AllFields.Selected[LB_AllFields.ItemIndex] := TRUE;
  end;
end;

procedure TF_BtrUtilE.SB_RemoveSelItmClick(Sender: TObject);
var
  I:integer;
  mTab:integer;
begin
  If LB_Trg.SelCount>0 then begin
    mTab := LB_Trg.ItemIndex;
    I := 0;
    While (I<LB_Trg.Items.Count) do begin
      If LB_Trg.Selected[I] then begin
        LB_Trg.Items.Delete (I);
      end else Inc (I);
    end;
    If mTab<LB_Trg.Items.Count
      then LB_Trg.ItemIndex := mTab
      else LB_Trg.ItemIndex := LB_Trg.Items.Count-1;
    LB_Trg.Selected[LB_Trg.ItemIndex] := TRUE;
  end;
end;

procedure TF_BtrUtilE.SB_CopyAllItmClick(Sender: TObject);
var
  I:integer;
begin
  If LB_AllFields.Items.Count>0 then begin
    I := 0;
    While (I<LB_AllFields.Items.Count) do begin
      If not FindItemInStringList (LB_Trg.Items,LB_AllFields.Items.Strings[I])
        then LB_Trg.Items.Add (LB_AllFields.Items.Strings[I]);
      Inc (I);
    end;
  end;
end;

procedure TF_BtrUtilE.SB_RemoveAllItmClick(Sender: TObject);
begin
  LB_Trg.Clear;
end;

procedure TF_BtrUtilE.LB_AllFieldsDblClick(Sender: TObject);
begin
  If LB_AllFields.Items.Count>0 then begin
    If not LB_AllFields.Selected[LB_AllFields.ItemIndex] then LB_AllFields.Selected[LB_AllFields.ItemIndex] := TRUE;
    SB_CopySelItmClick(Sender);
  end;
end;

procedure TF_BtrUtilE.LB_TrgDblClick(Sender: TObject);
begin
  If LB_Trg.Items.Count>0 then begin
    If not LB_Trg.Selected[LB_Trg.ItemIndex] then LB_Trg.Selected[LB_Trg.ItemIndex] := TRUE;
    SB_RemoveSelItmClick(Sender);
  end;
end;

procedure TF_BtrUtilE.LB_AllFieldsDragDrop(Sender, Source: TObject; X,
  Y: Integer);
begin
  If (Sender is TListBox) and (Source is TListBox) then begin
     If (Source as TListBox).Name='LB_Trg' then SB_RemoveSelItmClick(Source);
  end;
end;

procedure TF_BtrUtilE.LB_AllFieldsDragOver(Sender, Source: TObject; X,
  Y: Integer; State: TDragState; var Accept: Boolean);
begin
 Accept := (Source is TListBox) and ((Source as TListBox).Name='LB_Trg');
end;

procedure TF_BtrUtilE.LB_TrgDragDrop(Sender, Source: TObject; X,
  Y: Integer);
var
  mRect:TRect;
  mNewPos:TPoint;
  mIndex:integer;
begin
  If (Sender is TListBox) and (Source is TListBox) then begin
    If (Source as TListBox).Name='LB_AllFields' then SB_CopySelItmClick(Source);
    If (Source as TListBox).Name='LB_Trg' then begin
      mRect := LB_Trg.ItemRect(LB_Trg.ItemIndex);
      mNewPos.X := X;
      mNewPos.Y := Y;
      mIndex := LB_Trg.ItemIndex;
      LB_Trg.ItemIndex := LB_Trg.ItemAtPos (mNewPos,TRUE);
      LB_Trg.Items.Move (mIndex,LB_Trg.ItemIndex);
      LB_Trg.Selected[LB_Trg.ItemIndex] := TRUE;
    end;
  end;
end;

procedure TF_BtrUtilE.LB_TrgDragOver(Sender, Source: TObject; X,
  Y: Integer; State: TDragState; var Accept: Boolean);
begin
  Accept := Source is TListBox;
end;

procedure TF_BtrUtilE.SB_UpClick(Sender: TObject);
var mIt:integer;
begin
  If LB_Trg.ItemIndex>0 then begin
    mIt := LB_Trg.ItemIndex;
    LB_Trg.Items.Move (mIt,mIt-1);
    LB_Trg.ItemIndex := mIt-1;
    LB_Trg.Selected[LB_Trg.ItemIndex] := TRUE;
  end;
end;

procedure TF_BtrUtilE.SB_DownClick(Sender: TObject);
var mIt:integer;
begin
  If (LB_Trg.ItemIndex>=0) and (LB_Trg.ItemIndex<LB_Trg.Items.Count-1) then begin
    mIt := LB_Trg.ItemIndex;
    LB_Trg.Items.Move (mIt,mIt+1);
    LB_Trg.ItemIndex := mIt+1;
    LB_Trg.Selected[LB_Trg.ItemIndex] := TRUE;
  end;
end;

procedure TF_BtrUtilE.BB_EmptyFldClick(Sender: TObject);
begin
  LB_Trg.Items.Add('----');
end;

procedure TF_BtrUtilE.RB_TypeClick(Sender: TObject);
begin
  GB_ASCII.Visible := RB_ASCII.Checked;
  GB_Btr.Visible := RB_Btr.Checked;
end;

procedure TF_BtrUtilE.BB_CancelClick(Sender: TObject);
begin
  oExit := TRUE;
end;

procedure TF_BtrUtilE.E_TrgDefFileExit(Sender: TObject);
begin
  FillTrgFld;
end;

procedure TF_BtrUtilE.SpeedButton2Click(Sender: TObject);
begin
  OD_Open.InitialDir := ExtractFilePath(E_TrgDefFile.Text);
  OD_Open.FileName := '';
  If OD_Open.Execute then begin
    E_TrgDefFile.Text := OD_Open.FileName;
    E_TrgDefFileExit(Sender);
  end;
end;

procedure TF_BtrUtilE.SpeedButton1Click(Sender: TObject);
begin
  OD_Open.InitialDir := ExtractFilePath(E_TrgPath.Text);
  OD_Open.FileName := '';
  If OD_Open.Execute then begin
    E_TrgPath.Text := ExtractFilePath(OD_Open.FileName);
    E_TrgDefFileExit(Sender);
  end;
end;

procedure TF_BtrUtilE.BB_ExportClick(Sender: TObject);
begin
  oExit := FALSE;
  If RB_Paradox.Checked or RB_DBase.Checked or RB_DBaseDef.Checked or RB_FoxPro.Checked then ExportToStandard;
  If RB_ASCII.Checked then ExportToASCII;
  If RB_Btr.Checked then ExportToBtr;
end;

end.
