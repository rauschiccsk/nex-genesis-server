unit QRepN;

interface

uses
  IcConst, IcConv, IniFiles, IcTools, DB,
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls, ExtCtrls, Buttons;

type
  TFldData = array [0..200] of record
    Fld       : string;
    Name      : string;
    Width     : longint;
    NameAlign : longint;
    FiledAlign: longint;
    Mask      : string;
    Summary   : boolean;
    DataType  : TFieldType;
  end;

  TF_QRNewSpec = class(TForm)
    GroupBox1: TGroupBox;
    GroupBox2: TGroupBox;
    CB_PrintFirmaName: TCheckBox;
    CB_PrintDate: TCheckBox;
    CB_PrintTitle: TCheckBox;
    E_Title: TEdit;
    GroupBox3: TGroupBox;
    RB_NoFrame: TRadioButton;
    RB_WithFrame: TRadioButton;
    CB_PrintActPgNum: TCheckBox;
    CB_PrintActPgQnt: TCheckBox;
    CB_PrintRepFile: TCheckBox;
    BB_Create: TBitBtn;
    BB_Cancel: TBitBtn;
    GroupBox4: TGroupBox;
    Label1: TLabel;
    CB_DataSet: TComboBox;
    SB_CopySelItm: TSpeedButton;
    SB_RemoveSelItm: TSpeedButton;
    SB_CopyAllItm: TSpeedButton;
    SB_RemoveAllItm: TSpeedButton;
    SB_Up: TSpeedButton;
    P_Data: TPanel;
    L_Format: TLabel;
    L_Alignment: TLabel;
    L_Width: TLabel;
    L_Name: TLabel;
    Bevel5: TBevel;
    Bevel6: TBevel;
    Bevel7: TBevel;
    L_DisplayWidth: TLabel;
    L_DisplayWidthChar: TLabel;
    E_DisplayName: TEdit;
    E_DisplayWidth: TEdit;
    CB_NameAlign: TComboBox;
    CB_Format: TComboBox;
    E_DisplayWidthChar: TEdit;
    SB_Down: TSpeedButton;
    LB_AllFields: TListBox;
    Label2: TLabel;
    Label3: TLabel;
    LB_PrintFields: TListBox;
    CB_Summary: TCheckBox;
    Label4: TLabel;
    CB_FldAlign: TComboBox;
    L_Fld: TLabel;
    Bevel1: TBevel;
    E_CharWidth: TEdit;
    Label5: TLabel;
    Label6: TLabel;
    Label7: TLabel;
    E_RepName: TEdit;
    RB_MinFrame: TRadioButton;
    CB_DataModule: TComboBox;
    procedure CB_PrintActPgNumClick(Sender: TObject);
    procedure CB_PrintActPgQntClick(Sender: TObject);
    procedure BB_CreateClick(Sender: TObject);
    procedure BB_CancelClick(Sender: TObject);
    procedure CB_DataSetChange(Sender: TObject);
    procedure LB_AllFieldsDragOver(Sender, Source: TObject; X, Y: Integer;
      State: TDragState; var Accept: Boolean);
    procedure LB_PrintFieldsDragOver(Sender, Source: TObject; X, Y: Integer;
      State: TDragState; var Accept: Boolean);
    procedure SB_CopySelItmClick(Sender: TObject);
    procedure SB_RemoveSelItmClick(Sender: TObject);
    procedure SB_CopyAllItmClick(Sender: TObject);
    procedure SB_RemoveAllItmClick(Sender: TObject);
    procedure LB_AllFieldsDragDrop(Sender, Source: TObject; X, Y: Integer);
    procedure LB_PrintFieldsDragDrop(Sender, Source: TObject; X,
      Y: Integer);
    procedure SB_UpClick(Sender: TObject);
    procedure SB_DownClick(Sender: TObject);
    procedure LB_AllFieldsDblClick(Sender: TObject);
    procedure LB_PrintFieldsDblClick(Sender: TObject);
    procedure LB_PrintFieldsClick(Sender: TObject);
    procedure KeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure CB_SummaryKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure LB_PrintFieldsKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure E_DisplayNameExit(Sender: TObject);
    procedure E_DisplayWidthExit(Sender: TObject);
    procedure CB_NameAlignExit(Sender: TObject);
    procedure CB_FldAlignExit(Sender: TObject);
    procedure CB_FormatExit(Sender: TObject);
    procedure CB_SummaryExit(Sender: TObject);
    procedure E_DisplayWidthCharExit(Sender: TObject);
    procedure LB_AllFieldsKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure LB_PrintFieldsExit(Sender: TObject);
    procedure CB_DataModuleChange(Sender: TObject);
  private
    oCreate  : boolean;
    oDefData : TFldData;

    procedure ClearDefData;
    procedure ClearFldData;
    procedure DeleteFldData (pFld:string);
    procedure AddFldData (pFld:string);
    procedure SaveFldData (pNum:longint);
    { Private declarations }
  public
    oFldData : TFldData;
    function  Execute:boolean;
    function  FindFldData (pFld:string):longint;
    { Public declarations }
  end;

var
  F_QRNewSpec: TF_QRNewSpec;

implementation

uses QRep_;

{$R *.DFM}

function  TF_QRNewSpec.Execute:boolean;
begin
  oCreate := FALSE;
  CB_DataSet.Clear;
  CB_DataSet.Text := '';
  E_RepName.Text := '';
  LB_AllFields.Items.Clear;
  LB_PrintFields.Items.Clear;
  ClearDefData;
  ClearFldData;
  ShowModal;
  Result := oCreate;
end;

procedure TF_QRNewSpec.ClearFldData;
var I:longint;
begin
  For I:=0 to 200 do begin
    oFldData[I].Fld        := '';
    oFldData[I].Name       := '';
    oFldData[I].Width      := 0;
    oFldData[I].NameAlign  := 0;
    oFldData[I].FiledAlign := 0;
    oFldData[I].Mask       := '';
    oFldData[I].Summary    := FALSE;
    oFldData[I].DataType   := ftString;
  end;
  L_Fld.Caption := '';
  E_DisplayName.Text := '';
  E_DisplayWidth.Text := '';
  E_DisplayWidthChar.Text := '';
  CB_NameAlign.ItemIndex := 0;
  CB_FldAlign.ItemIndex := 0;
  CB_Format.Text := '';
  CB_Summary.Checked := FALSE;
end;

procedure TF_QRNewSpec.ClearDefData;
var I:longint;
begin
  For I:=0 to 200 do begin
    oDefData[I].Fld        := '';
    oDefData[I].Name       := '';
    oDefData[I].Width      := 0;
    oDefData[I].NameAlign  := 0;
    oDefData[I].FiledAlign := 0;
    oDefData[I].Mask       := '';
    oDefData[I].Summary    := FALSE;
    oDefData[I].DataType   := ftString;
  end;
end;

procedure TF_QRNewSpec.DeleteFldData (pFld:string);
var
  I:longint;
  mFind:boolean;
begin
  I := 0;
  mFind := FALSE;
  If Pos (' - ',pFld)>0 then pFld := Copy (pFld, 1 , Pos (' - ',pFld)-1);
  While (I<200) and not mFind do begin
    mFind := oFldData[I].Fld=pFld;
    If not mFind then Inc (I);
  end;
  If mFind then begin
    oFldData[I].Fld        := '';
    oFldData[I].Name       := '';
    oFldData[I].Width      := 0;
    oFldData[I].NameAlign  := 0;
    oFldData[I].FiledAlign := 0;
    oFldData[I].Mask       := '';
    oFldData[I].Summary    := FALSE;
    oFldData[I].DataType   := ftString;
  end;
end;

procedure TF_QRNewSpec.AddFldData (pFld:string);
var
  I,J:longint;
  mT:TIniFile;
  mS:string;
  mFind:boolean;
begin
  I := 0;
  If Pos (' - ',pFld)>0 then pFld := Copy (pFld, 1 , Pos (' - ',pFld)-1);
  While (oFldData[I].Fld<>'') and (I<200) do
    Inc (I);
  If oFldData[I].Fld='' then begin
    mFind := FALSE; // RZ 09.07.2002
    J := 0;  // 27.12.2001
    While (J<200) and not mFind do begin
      mFind := oDefData[J].Fld=pFld;
      If not mFind then Inc (J);
    end;
    If mFind then begin
      oFldData[I].Fld := oDefData[J].Fld;
      oFldData[I].Name := oDefData[J].Name;
      oFldData[I].Width := oDefData[J].Width*ValInt (E_CharWidth.Text);
      oFldData[I].NameAlign := oDefData[J].NameAlign;
      oFldData[I].FiledAlign := oDefData[J].FiledAlign;
      oFldData[I].Mask := oDefData[J].Mask;
      oFldData[I].Summary := oDefData[J].Summary;
      oFldData[I].DataType := oDefData[J].DataType;
    end;
    mT := TIniFile.Create (cRepPath+'RepFld.Ini');
    mS := mT.ReadString ('QREP',pFld,'');
    If mS<>'' then begin
      oFldData[I].Fld := pFld;
      oFldData[I].Name := LineElement (mS,0,',');
      oFldData[I].Width := ValInt (LineElement (mS,1,','));
      oFldData[I].NameAlign := ValInt (LineElement (mS,2,','));
      oFldData[I].FiledAlign := ValInt (LineElement (mS,3,','));
      oFldData[I].Mask := LineElement (mS,4,',');
      oFldData[I].Summary := (LineElement (mS,5,',')='A');
    end;
    mT.Free; mT := nil;
  end;
end;

procedure TF_QRNewSpec.SaveFldData (pNum:longint);
var
  mT:TIniFile;
  mS:string;
  mSum:string;
begin
  mT := TIniFile.Create (cRepPath+'RepFld.Ini');
  If oFldData[pNum].Summary
    then mSum := 'A'
    else mSum := 'N';
  mS := oFldData[pNum].Name+','+StrInt (oFldData[pNum].Width,0)+','+StrInt (oFldData[pNum].NameAlign,0)+','+StrInt (oFldData[pNum].FiledAlign,0)+','+oFldData[pNum].Mask+','+mSum;
  mT.WriteString ('QREP',oFldData[pNum].Fld,mS);
  mT.Free; mT := nil;
end;

function  TF_QRNewSpec.FindFldData (pFld:string):longint;
var
  I:longint;
  mFind:boolean;
begin
  I := 0;
  mFind := FALSE;
  If Pos (' - ',pFld)>0 then pFld := Copy (pFld, 1 , Pos (' - ',pFld)-1);
  While (I<200) and not mFind do begin
    mFind := (oFldData[I].Fld = pFld);
    If not mFind then Inc (I);
  end;
  If mFind
    then Result := I
    else Result := -1;
end;

procedure TF_QRNewSpec.CB_PrintActPgNumClick(Sender: TObject);
begin
  If CB_PrintActPgNum.Focused then CB_PrintActPgQnt.Checked := FALSE;
end;

procedure TF_QRNewSpec.CB_PrintActPgQntClick(Sender: TObject);
begin
  If CB_PrintActPgQnt.Focused then CB_PrintActPgNum.Checked := FALSE;
end;

procedure TF_QRNewSpec.BB_CreateClick(Sender: TObject);
begin
  oCreate := TRUE;
  Close;
end;

procedure TF_QRNewSpec.BB_CancelClick(Sender: TObject);
begin
  Close;
end;

procedure TF_QRNewSpec.CB_DataSetChange(Sender: TObject);
var
  I:longint;
  mT:TIniFile;
  mS:string;
  mName:string;
  mComp:TObject;
  mDataType:TFieldType;
begin
  ClearDefData;
  ClearFldData;
  LB_PrintFields.Items.Clear;
  LB_AllFields.Items.Clear;
  try
    LB_AllFields.Items.AddStrings (F_QRMain.FillFieldNames (CB_DataSet.Text));
  except end;
  mComp := F_QRMain.GetTableObj (CB_DataSet.Text);
  mT := TIniFile.Create (cRepPath+'RepFld.Ini');
  For I:=0 to LB_AllFields.Items.Count-1 do begin
    mS := mT.ReadString ('QREP',LB_AllFields.Items.Strings[I],'');
    mName := LineElement (mS,0,',');
    If mName<>'' then LB_AllFields.Items.Strings[I] := LB_AllFields.Items.Strings[I]+' - '+mName;
    If I<=200 then begin
      try
        If (mComp<>nil) and (mComp is TDataSet) then begin
          oDefData[I].Fld        := LB_AllFields.Items.Strings[I];
          If Pos (' - ',oDefData[I].Fld)>0 then oDefData[I].Fld := Copy (oDefData[I].Fld, 1, Pos (' - ',oDefData[I].Fld)-1);
          oDefData[I].Name       := oDefData[I].Fld;
          oDefData[I].Width      := (mComp as TDataSet).FieldDefs.Items[I].Size;
          oDefData[I].NameAlign  := 1;
          oDefData[I].FiledAlign := 0;
          oDefData[I].Mask       := '';
          mDataType :=  (mComp as TDataSet).FieldDefs.Items[I].DataType;
          oDefData[I].DataType := mDataType;
          If (mDataType=ftSmallint) or (mDataType=ftInteger) or (mDataType=ftWord) or (mDataType=ftBytes) then begin
            oDefData[I].FiledAlign := 2;
            oDefData[I].Mask       := '### ### ### ###';
            oDefData[I].Width      := 8;
          end;
          If (mDataType=ftFloat) or (mDataType=ftCurrency) then begin
            oDefData[I].FiledAlign := 2;
            oDefData[I].Mask       := '### ### ### ##0.00';
            oDefData[I].Width      := 14;
          end;
          If (mDataType=ftDate) then oDefData[I].Width := 8;
          If (mDataType=ftTime) then oDefData[I].Width := 6;
          If (mDataType=ftDateTime) then oDefData[I].Width := 14;
        end;
      except end;
    end;
  end;
  mT.Free; mT := nil;
end;

procedure TF_QRNewSpec.LB_AllFieldsDragOver(Sender, Source: TObject; X,
  Y: Integer; State: TDragState; var Accept: Boolean);
begin
 Accept := (Source is TListBox) and ((Source as TListBox).Name='LB_PrintFields');
end;

procedure TF_QRNewSpec.LB_PrintFieldsDragOver(Sender, Source: TObject; X,
  Y: Integer; State: TDragState; var Accept: Boolean);
begin
 Accept := (Source is TListBox) and (((Source as TListBox).Name='LB_AllFields') or ((Source as TListBox).Name='LB_PrintFields'));
end;

procedure TF_QRNewSpec.SB_CopySelItmClick(Sender: TObject);
var
  I,J:integer;
  mAdd:boolean;
begin
  If LB_AllFields.SelCount>0 then begin
    I := 0;
    While (I<LB_AllFields.Items.Count) do begin
      If LB_AllFields.Selected[I] then begin
        mAdd := TRUE;
        If LB_PrintFields.Items.Count>0 then begin
          For J:=0 to LB_PrintFields.Items.Count-1 do begin
            mAdd := (LB_AllFields.Items.Strings[I]<>LB_PrintFields.Items.Strings[J]);
            If not mAdd then Break;
          end;
        end;
        If mAdd then begin
          LB_PrintFields.Items.Add (LB_AllFields.Items.Strings[I]);
          AddFldData (LB_AllFields.Items.Strings[I]);
        end;
      end;
      Inc (I);
    end;
  end;
end;

procedure TF_QRNewSpec.SB_RemoveSelItmClick(Sender: TObject);
var
  I,J:integer;
  mAdd:boolean;
begin
  If LB_PrintFields.SelCount>0 then begin
    I := 0;
    While (I<LB_PrintFields.Items.Count) do begin
      If LB_PrintFields.Selected[I] then begin
        DeleteFldData (LB_PrintFields.Items.Strings[I]);
        LB_PrintFields.Items.Delete (I);
      end else Inc (I);
    end;
    P_Data.Enabled := FALSE;
  end;
end;

procedure TF_QRNewSpec.SB_CopyAllItmClick(Sender: TObject);
var
  I,J:integer;
  mAdd:boolean;
begin
  I := 0;
  While (I<LB_AllFields.Items.Count) do begin
    mAdd := TRUE;
    If LB_PrintFields.Items.Count>0 then begin
      For J:=0 to LB_PrintFields.Items.Count-1 do begin
        mAdd := (LB_AllFields.Items.Strings[I]<>LB_PrintFields.Items.Strings[J]);
        If not mAdd then Break;
      end;
    end;
    If mAdd then begin
      LB_PrintFields.Items.Add (LB_AllFields.Items.Strings[I]);
      AddFldData (LB_AllFields.Items.Strings[I]);
    end;
    Inc (I);
  end;
end;

procedure TF_QRNewSpec.SB_RemoveAllItmClick(Sender: TObject);
begin
  LB_PrintFields.Items.Clear;
  ClearFldData;
  P_Data.Enabled := FALSE;
end;

procedure TF_QRNewSpec.LB_AllFieldsDragDrop(Sender, Source: TObject; X,
  Y: Integer);
begin
  SB_RemoveSelItmClick (Sender);
end;

procedure TF_QRNewSpec.LB_PrintFieldsDragDrop(Sender, Source: TObject; X,
  Y: Integer);
var
  mRect:TRect;
  mNewPos:TPoint;
  mIndex:integer;
begin
  If (Sender is TListBox) and (Source is TListBox) then begin
    If (Source as TListBox).Name='LB_AllFields' then SB_CopySelItmClick (Sender);
    If (Source as TListBox).Name='LB_PrintFields' then begin
      mRect := LB_PrintFields.ItemRect(LB_PrintFields.ItemIndex);
      mNewPos.X := X;
      mNewPos.Y := Y;
      mIndex := LB_PrintFields.ItemIndex;
      LB_PrintFields.ItemIndex := LB_PrintFields.ItemAtPos (mNewPos,TRUE);
      LB_PrintFields.Items.Move (mIndex,LB_PrintFields.ItemIndex);
      If LB_PrintFields.ItemIndex=-1 then LB_PrintFields.ItemIndex := LB_PrintFields.Items.Count-1;
      LB_PrintFields.Selected[LB_PrintFields.ItemIndex] := TRUE;
    end;
  end;

end;

procedure TF_QRNewSpec.SB_UpClick(Sender: TObject);
var mIt:integer;
begin
  If LB_PrintFields.ItemIndex>0 then begin
    mIt := LB_PrintFields.ItemIndex;
    LB_PrintFields.Items.Move (mIt,mIt-1);
    LB_PrintFields.ItemIndex := mIt-1;
    LB_PrintFields.Selected [LB_PrintFields.ItemIndex] := TRUE;
  end;
end;

procedure TF_QRNewSpec.SB_DownClick(Sender: TObject);
var mIt:integer;
begin
  If (LB_PrintFields.ItemIndex>=0) and (LB_PrintFields.ItemIndex<LB_PrintFields.Items.Count-1) then begin
    mIt := LB_PrintFields.ItemIndex;
    LB_PrintFields.Items.Move (mIt,mIt+1);
    LB_PrintFields.ItemIndex := mIt+1;
    LB_PrintFields.Selected[LB_PrintFields.ItemIndex] := TRUE;
  end;
end;

procedure TF_QRNewSpec.LB_AllFieldsDblClick(Sender: TObject);
begin
  SB_CopySelItmClick (Sender);
end;

procedure TF_QRNewSpec.LB_PrintFieldsDblClick(Sender: TObject);
begin
  SB_RemoveSelItmClick (Sender);
end;

procedure TF_QRNewSpec.LB_PrintFieldsClick(Sender: TObject);
var
  I:longint;
  mFind:boolean;
  mFld:string;
  mDataType:TFieldType;
begin
  If LB_PrintFields.SelCount=1 then begin
    P_Data.Enabled := TRUE;
    CB_Format.Clear;
    I := 0;
    mFind := FALSE;
    While (I<LB_PrintFields.Items.Count) and not mFind do begin
      mFind := LB_PrintFields.Selected [I];
      If not mFind then Inc (I);
    end;
    mFld := '';
    If mFind then mFld := LB_PrintFields.Items.Strings[I];
    I := FindFldData (mFld);
    If I>-1 then begin
      L_Fld.Caption  := oFldData[I].Fld;
      E_DisplayName.Text := oFldData[I].Name;
      E_DisplayWidth.Text := StrInt (oFldData[I].Width,0);
      If ValInt (E_CharWidth.Text)>0
        then E_DisplayWidthChar.Text := StrInt ((ValInt (E_DisplayWidth.Text) div ValInt (E_CharWidth.Text)),0)
        else E_DisplayWidthChar.Text := '0';
      CB_NameAlign.ItemIndex := oFldData[I].NameAlign;
      CB_FldAlign.ItemIndex := oFldData[I].FiledAlign;
      CB_Format.Text := oFldData[I].Mask;
      CB_Summary.Checked := oFldData[I].Summary;
      mDataType := oFldData[I].DataType;
      If (mDataType=ftSmallint) or (mDataType=ftInteger) or (mDataType=ftWord) or (mDataType=ftBytes) or (mDataType=ftFloat) or (mDataType=ftCurrency) then begin
        CB_Format.Items.Add ('');
        CB_Format.Items.Add ('### ### ### ###');
        CB_Format.Items.Add ('### ### ### ##0');
        CB_Format.Items.Add ('### ### ### ##0.00');
        CB_Format.Items.Add ('### ### ### ##0.000');
      end;
    end;
  end else begin
    P_Data.Enabled := FALSE;
    L_Fld.Caption := '';
    E_DisplayName.Text := '';
    E_DisplayWidth.Text := '';
    E_DisplayWidthChar.Text := '';
    CB_NameAlign.ItemIndex := 0;
    CB_FldAlign.ItemIndex := 0;
    CB_Format.Text := '';
    CB_Summary.Checked := FALSE;
  end;
end;

procedure TF_QRNewSpec.KeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
var mForm:TCustomForm;
begin
  If Key=VK_RETURN then begin
    mForm := GetParentForm (Self);
    If (Key = VK_RETURN) then SendMessage (mForm.Handle,WM_NEXTDLGCTL,0,0);
  end;
end;

procedure TF_QRNewSpec.CB_SummaryKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  If Key=VK_RETURN then LB_PrintFields.SetFocus;
end;

procedure TF_QRNewSpec.LB_PrintFieldsKeyDown(Sender: TObject;
  var Key: Word; Shift: TShiftState);
begin
  If Key=VK_RETURN then begin
    If LB_PrintFields.SelCount=1 then begin
      P_Data.Enabled := TRUE;
      E_DisplayName.SetFocus;
    end;
  end;
  If ssCtrl in Shift then begin
    If Key=VK_UP then begin
      SB_UpClick (Sender);
      Key := 0;
    end;
    If Key=VK_DOWN then begin
      SB_DownClick (Sender);
      Key := 0;
    end;
  end;
  If Key=VK_DELETE then SB_RemoveSelItmClick (Sender);
end;

procedure TF_QRNewSpec.E_DisplayNameExit(Sender: TObject);
var I,J:longint;
begin
  I := FindFldData (L_Fld.Caption);
  If I>-1 then begin
    oFldData[I].Name := E_DisplayName.Text;
    SaveFldData (I);
    For J:=0 to LB_PrintFields.Items.Count-1 do begin
      If Pos (oFldData[I].Fld,LB_PrintFields.Items.Strings[J])=1 then begin
        LB_PrintFields.Items.Strings[J] := oFldData[I].Fld+' - '+oFldData[I].Name;
        Break;
      end;
    end;
    LB_PrintFields.Selected[LB_PrintFields.ItemIndex] := TRUE;
    For J:=0 to LB_AllFields.Items.Count-1 do begin
      If Pos (oFldData[I].Fld,LB_AllFields.Items.Strings[J])=1 then begin
        LB_AllFields.Items.Strings[J] := oFldData[I].Fld+' - '+oFldData[I].Name;
        Break;
      end;
    end;
  end;
end;

procedure TF_QRNewSpec.E_DisplayWidthExit(Sender: TObject);
var I:longint;
begin
  I := FindFldData (L_Fld.Caption);
  If I>-1 then begin
    oFldData[I].Width := ValInt (E_DisplayWidth.Text);
    SaveFldData (I);
    If ValInt (E_CharWidth.Text)<>0
      then E_DisplayWidthChar.Text := StrInt ((ValInt (E_DisplayWidth.Text) div ValInt (E_CharWidth.Text)),0)
      else E_DisplayWidthChar.Text := '0';
  end;
end;

procedure TF_QRNewSpec.CB_NameAlignExit(Sender: TObject);
var I:longint;
begin
  I := FindFldData (L_Fld.Caption);
  If I>-1 then begin
    oFldData[I].NameAlign := CB_NameAlign.ItemIndex;
    SaveFldData (I);
  end;
end;

procedure TF_QRNewSpec.CB_FldAlignExit(Sender: TObject);
var I:longint;
begin
  I := FindFldData (L_Fld.Caption);
  If I>-1 then begin
    oFldData[I].FiledAlign := CB_FldAlign.ItemIndex;
    SaveFldData (I);
  end;
end;

procedure TF_QRNewSpec.CB_FormatExit(Sender: TObject);
var I:longint;
begin
  I := FindFldData (L_Fld.Caption);
  If I>-1 then begin
    oFldData[I].Mask := CB_Format.Text;
    SaveFldData (I);
  end;
end;

procedure TF_QRNewSpec.CB_SummaryExit(Sender: TObject);
var I:longint;
begin
  I := FindFldData (L_Fld.Caption);
  If I>-1 then begin
    oFldData[I].Summary := CB_Summary.Checked;
    SaveFldData (I);
  end;
end;

procedure TF_QRNewSpec.E_DisplayWidthCharExit(Sender: TObject);
var I:longint;
begin
  E_DisplayWidth.Text := StrInt (ValInt (E_DisplayWidthChar.Text)*ValInt (E_CharWidth.Text),0);
  I := FindFldData (L_Fld.Caption);
  If I>-1 then begin
    oFldData[I].Width := ValInt (E_DisplayWidth.Text);
    SaveFldData (I);
  end;
end;

procedure TF_QRNewSpec.LB_AllFieldsKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  If Key=VK_RETURN then SB_CopySelItmClick(Sender);
end;

procedure TF_QRNewSpec.LB_PrintFieldsExit(Sender: TObject);
begin
  If LB_PrintFields.SelCount<>1
    then P_Data.Enabled := FALSE
    else P_Data.Enabled := TRUE;
end;

procedure TF_QRNewSpec.CB_DataModuleChange(Sender: TObject);
var J:longint;
begin
  LB_AllFields.Items.Clear;
  LB_PrintFields.Items.Clear;
  ClearDefData;
  ClearFldData;

  CB_DataSet.Clear;
  If Application.FindComponent (CB_DataModule.Text) is TDataModule then begin
    For J:=0 to Application.FindComponent (CB_DataModule.Text).ComponentCount-1 do begin
      If Application.FindComponent (CB_DataModule.Text).Components[J] is TDataSet then begin
        CB_DataSet.Items.Add (Application.FindComponent (CB_DataModule.Text).Name+'.'+Application.FindComponent (CB_DataModule.Text).Components[J].Name);
      end;
    end;
  end;
end;

end.
