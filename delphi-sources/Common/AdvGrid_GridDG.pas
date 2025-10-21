unit AdvGrid_GridDG;

interface

uses
  AdvGrid_GridDef, AdvGrid_GridSet, TxtCut, AdvGrid_ColAdd, BaseUtils, 
  IcConv, IcTools, CompTxt,
  DB, IniFiles, Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls, ExtCtrls, Buttons, IcInfoFields, xpComp, ActnList;

type
  TF_GridDG = class(TForm)
    CB_SetList: TComboBox;
    Bevel1: TBevel;
    L_ViewerHead: TLabel;
    Bevel3: TBevel;
    L_SetNumTxt: TLabel;
    L_SetName: TLabel;
    L_SetNum: TLabel;
    E_SetHead: TEdit;
    E_SetName: TEdit;
    L_SetList: TLabel;
    Bevel2: TBevel;
    Bevel4: TBevel;
    LB_AllFields: TListBox;
    LB_Viewer: TListBox;
    GB_DGD: TPanel;
    E_DisplayName: TEdit;
    E_DisplayWidth: TEdit;
    CB_Alignment: TComboBox;
    CB_Format: TComboBox;
    CB_EditFld: TComboBox;
    L_ReadOnly: TLabel;
    L_Format: TLabel;
    L_Alignment: TLabel;
    L_Width: TLabel;
    L_Name: TLabel;
    Bevel5: TBevel;
    L_Database: TLabel;
    L_Show: TLabel;
    SB_CopySelItm: TSpeedButton;
    SB_RemoveSelItm: TSpeedButton;
    SB_CopyAllItm: TSpeedButton;
    SB_RemoveAllItm: TSpeedButton;
    SB_Up: TSpeedButton;
    SB_Down: TSpeedButton;
    BB_NewDef: TBitBtn;
    BB_Save: TBitBtn;
    BB_Exit: TBitBtn;
    Bevel6: TBevel;
    BB_Delete: TBitBtn;
    Bevel7: TBevel;
    E_DisplayWidthChar: TEdit;
    L_DisplayWidth: TLabel;
    L_DisplayWidthChar: TLabel;
    BB_DefEdit: TBitBtn;
    CB_HeadFont: TComboBox;
    SB_HeadFontBold: TSpeedButton;
    SB_HeadFontItalic: TSpeedButton;
    Label1: TLabel;
    Label2: TLabel;
    CB_GridFont: TComboBox;
    SB_GridFontBold: TSpeedButton;
    SB_GridFontItalic: TSpeedButton;
    BB_SetDefField: TButton;
    BB_SetDefViewFields: TButton;
    CB_HeadFontSize: TComboBox;
    CB_GridFontSize: TComboBox;
    BB_NewUser: TBitBtn;
    ChB_ShowOnlyUserSet: TCheckBox;
    NI_FullName: TNameInfo;
    L_DGD: TLabel;
    P_ColorGrp: TxpSinglePanel;
    L_ColorGrp: TxpLabel;
    CB_ColorGrp: TxpComboBox;
    B_AddColorGrp: TxpBitBtn;
    ChB_ServiceOnly: TCheckBox;
    ChB_CopyDGD: TCheckBox;
    B_SetUniField: TButton;
    B_SaveDefField: TButton;
    B_SaveUniField: TButton;
    B_SaveDefFields: TButton;
    ChB_SaveDefFieldsNew: TCheckBox;
    ChB_SaveUniFields: TCheckBox;
    B_DelNotExist: TButton;
    ActionList1: TActionList;
    Action1: TAction;
    L_FldInfo: TLabel;
    procedure CB_SetListChange(Sender: TObject);
    procedure LB_ViewerClick(Sender: TObject);
    procedure SB_UpClick(Sender: TObject);
    procedure SB_DownClick(Sender: TObject);
    procedure SB_CopySelItmClick(Sender: TObject);
    procedure SB_RemoveSelItmClick(Sender: TObject);
    procedure SB_CopyAllItmClick(Sender: TObject);
    procedure SB_RemoveAllItmClick(Sender: TObject);
    procedure LB_AllFieldsExit(Sender: TObject);
    procedure BB_SaveClick(Sender: TObject);
    procedure LB_AllFieldsEnter(Sender: TObject);
    procedure BB_NewDefClick(Sender: TObject);
    procedure FldEditKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure FldEditExit(Sender: TObject);
    procedure BB_DeleteClick(Sender: TObject);
    procedure BB_ExitClick(Sender: TObject);
    procedure CB_EditFldKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure LB_ViewerEnter(Sender: TObject);
    procedure LB_AllFieldsDragOver(Sender, Source: TObject; X, Y: Integer;
      State: TDragState; var Accept: Boolean);
    procedure LB_ViewerDragDrop(Sender, Source: TObject; X, Y: Integer);
    procedure LB_ViewerDragOver(Sender, Source: TObject; X, Y: Integer;
      State: TDragState; var Accept: Boolean);
    procedure LB_AllFieldsDragDrop(Sender, Source: TObject; X, Y: Integer);
    procedure LB_AllFieldsKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure LB_ViewerKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure LB_AllFieldsDblClick(Sender: TObject);
    procedure LB_ViewerDblClick(Sender: TObject);
    procedure E_SetNameExit(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure E_DisplayWidthCharExit(Sender: TObject);
    procedure E_DisplayWidthExit(Sender: TObject);
    procedure BB_DefEditClick(Sender: TObject);
    procedure CB_FormatKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure BB_SetDefFieldClick(Sender: TObject);
    procedure BB_SetDefViewFieldsClick(Sender: TObject);
    procedure BB_NewUserClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure B_DelNotExistClick(Sender: TObject);
    procedure B_SaveDefFieldClick(Sender: TObject);
    procedure B_SaveDefFieldsClick(Sender: TObject);
    procedure B_SaveUniFieldClick(Sender: TObject);
    procedure B_SetUniFieldClick(Sender: TObject);
    procedure B_AddColorGrpClick(Sender: TObject);
    procedure Action1Execute(Sender: TObject);
    procedure LB_AllFieldsClick(Sender: TObject);

  private
    oOnlyUserSet: boolean;
    oDGDName    : string;
    oDataSet    : TDataSet;
    oService    : boolean;
    oGridSet    : TGridSet;
    oFontSize   :integer;

    procedure ReadAllFlds;
    procedure SetChanged;
    procedure FillSetList;
    procedure ReadSetList (pItem:string);
    procedure ReadGridSet;
    procedure FillFldData;
    procedure DeleteInAllList (pFld:string);
    procedure HideViewerFld;
    function  FindInDefault (pFld:string):integer;
    procedure NewSetGrid (pService:boolean);
    function  GetAllFieldsIndex (pStr:string):integer;
    function  FindInAllFields (pFld:string):integer;
    procedure LoadColorGrp;
    function  CopyInDefParams (pS:string):string;
    { Private declarations }
  public
    function Execute (pIndex:integer;pOnlyUserSet,pService:boolean;pDGDName:string;pDataSet:TDataSet;pFontSize:integer):integer;
    { Public declarations }
  end;

var
  F_GridDG: TF_GridDG;

implementation

{$R *.DFM}

function  TF_GridDG.Execute (pIndex:integer;pOnlyUserSet,pService:boolean;pDGDName:string;pDataSet:TDataSet;pFontSize:integer):integer;
var mFile:TIniFile;
begin
  oOnlyUserSet := pOnlyUserSet;
  oDGDName := pDGDName;
  oDataSet := pDataSet;
  oService := pService;
  oFontSize := pFontSize;

  mFile := TIniFile.Create (oDGDName+cDefType);
  ChB_ShowOnlyUserSet.Checked := mFile.ReadBool ('SETTINGS','ShowOnlyUserSet',FALSE);
  mFile.Free;

  oGridSet := TGridSet.Create;
  oGridSet.SetDGDName (oDGDName);
  FillSetList;
  ReadAllFlds;
  CB_SetList.ItemIndex := pIndex;
  SetChanged;
  BB_DefEdit.Visible := oService;
  ChB_ServiceOnly.Enabled := oService;
  B_SaveDefField.Enabled := oService;
  B_SaveUniField.Enabled := oService;
  B_SaveDefFields.Enabled := oService;
  ChB_SaveDefFieldsNew.Enabled := oService;
  L_DGD.Caption := ExtractFileName (pDGDName);
  ShowModal;
  oGridSet.Free;
  Result := CB_SetList.ItemIndex;
end;

procedure TF_GridDG.SetChanged;
var mS:string;
begin
  mS := CB_SetList.Items.Strings[CB_SetList.ItemIndex];
  L_SetNum.Caption := Copy (mS,1,3);
  E_SetName.Text := Copy (mS,7,Length (mS));
  ReadAllFlds;
  ReadGridSet;
  If LB_Viewer.Items.Count=0 then HideViewerFld;
  LoadColorGrp;
end;

procedure TF_GridDG.FillSetList;
begin
  oGridSet.SetDGDName (oDGDName);
  If not oGridSet.DefaultExists then oGridSet.CreateDefaultGridSet (oDataSet);
  oGridSet.ReadDefault;
  ReadSetList ('');
end;

procedure TF_GridDG.ReadSetList (pItem:string);
var
  I:integer;
  mNum,mName:string;
begin
  oGridSet.ReadList (oOnlyUserSet,TRUE);
  CB_SetList.Clear;
  For I:=0 to oGridSet.oSetList.Count-1 do begin
    mNum := Copy (oGridSet.oSetList.Strings[I],1,Pos ('=',oGridSet.oSetList.Strings[I])-1);
    mName := Copy (oGridSet.oSetList.Strings[I],Pos ('=',oGridSet.oSetList.Strings[I])+1,Length (oGridSet.oSetList.Strings[I]));
    CB_SetList.Items.Add (mNum+'   '+mName);
    If pItem<>'' then begin
      If mNum=pItem then CB_SetList.ItemIndex := I;
    end;
  end;
end;

procedure TF_GridDG.ReadAllFlds;
var
  I:integer;
  mS:string;
begin
  LB_AllFields.Clear;
  If oGridSet.oDefGrid.Count>0 then begin
    For I:=0 to oGridSet.oDefGrid.Count-1 do begin
      mS := oGridSet.oDefGrid.Strings[I];
      mS := Copy (mS,1,Pos (',',mS)-1);
      LB_AllFields.Items.Add (mS);
    end;
  end;
end;

procedure TF_GridDG.CB_SetListChange(Sender: TObject);
begin
  SetChanged;
end;

procedure TF_GridDG.ReadGridSet;
var
  I:integer;
  mFld:string;
  mCom:string;
  mFont:string;
  mFontSize:string;
  mFontType:string;
begin
  oGridSet.LoadSet (L_SetNum.Caption);
  LB_Viewer.Clear;
  E_SetHead.Text := '';
  CB_HeadFont.Text := 'Times New Roman';
  CB_HeadFontSize.Text := '12';
  SB_HeadFontBold.Down := TRUE;
  SB_HeadFontItalic.Down := FALSE;
  CB_GridFont.Text := 'Arial';
  CB_GridFontSize.Text := '8';
  SB_GridFontBold.Down := FALSE;
  SB_GridFontItalic.Down := FALSE;
  If oGridSet.GetGridItCount>0 then begin
    For I:=0 to oGridSet.GetGridItCount-1 do begin
      mFld := oGridSet.oSetGrid.Strings[I];
      If Pos ('=',mFld)>0 then begin
        mCom := UpString (Copy (mFld,1,Pos ('=',mFld)-1));
        Delete (mFld,1,Pos ('=',mFld));
        If mFld<>'' then begin
          If mCom='HEAD' then E_SetHead.Text := mFld;
          If mCom='HEADFONT' then begin
            mFont := GetParamString (mFld, 1);
            mFontSize := GetParamString (mFld, 2);
            mFontType := GetParamString (mFld, 3);
            If (mFont<>'') and (ValInt (mFontSize)>0) then begin
              CB_HeadFont.Text := mFont;
              CB_HeadFontSize.Text := mFontSize;
              SB_HeadFontBold.Down := Pos ('B',mFontType)>0;
              SB_HeadFontItalic.Down := Pos ('I',mFontType)>0;
            end;
          end;
          If mCom='GRIDFONT' then begin
            mFont := GetParamString (mFld, 1);
            If mFont = '' then mFont := 'Arial';
            mFontSize := GetParamString (mFld, 2);
            mFontType := GetParamString (mFld, 3);
            If (mFont<>'') and (ValInt (mFontSize)>0) then begin
              CB_GridFont.Text := mFont;
              CB_GridFontSize.Text := mFontSize;
              SB_GridFontBold.Down := Pos ('B',mFontType)>0;
              SB_GridFontItalic.Down := Pos ('I',mFontType)>0;
            end;
          end;

          If Copy (mCom,1,5)='FIELD' then begin
            mFld := GetParamString (mFld, 1);
            LB_Viewer.Items.Add (mFld);
            DeleteInAllList (mFld);
          end;
        end;
      end;
    end;
    I := 0;
    Repeat
      mCom := '';
      mFld := oGridSet.oSetGrid.Strings[I];
      If Pos ('=',mFld)>0 then mCom := UpString (Copy (mFld,1,Pos ('=',mFld)-1));
      If Copy (mCom,1,5)<>'FIELD' then begin
        oGridSet.oSetGrid.Delete(I);
      end else Inc (I);
    until I>= oGridSet.GetGridItCount;
  end;
  If LB_Viewer.Items.Count>0 then begin
    LB_Viewer.ItemIndex := 0;
    LB_Viewer.Selected[LB_Viewer.ItemIndex] := TRUE;
    FillFldData;
  end;
end;

procedure TF_GridDG.LB_ViewerClick(Sender: TObject);
begin
  If LB_Viewer.SelCount=1
    then FillFldData
    else HideViewerFld;
end;

procedure TF_GridDG.FillFldData;
var
  mS,mSS:string;
  mAlign:string;
  mPos:longint;
begin
  If LB_Viewer.ItemIndex>=0 then begin
    mSS:=oGridSet.oSetGrid.Strings[LB_Viewer.ItemIndex];
    mSS:=Copy (mSS,Pos('=',mSS)+1,Pos(',',mSS)-Pos('=',mSS)-1);
    mPos := FindInDefault (mSS);
    If mPos>-1 then begin
      mSS:= LineElement(oGridSet.oDefGrid.Strings [mPos],LineElementNum(oGridSet.oDefGrid.Strings [mPos],',')-1,',');
      mS := oGridSet.oSetGrid.Strings[LB_Viewer.ItemIndex];
      mS := Copy (mS,Pos ('=',mS)+1,Length (mS));
      E_DisplayName.Text := LineElement (mS,1,',');
      E_DisplayWidth.Text := StrInt (ValInt (LineElement (mS,2,',')),0);
      E_DisplayWidthChar.Text := StrInt (ValInt (E_DisplayWidth.Text) div oFontSize,0);
      mAlign := LineElement (mS,3,',');
      CB_Alignment.ItemIndex := 0;
      If mAlign='L' then CB_Alignment.ItemIndex := 0;
      If mAlign='C' then CB_Alignment.ItemIndex := 1;
      If mAlign='R' then CB_Alignment.ItemIndex := 2;
      CB_Format.Text := LineElement (mS,4,',');
      NI_FullName.Text:= mSS;// LineElement (mS,6,',');  * lebo popis pola je len v nastaveni DEFAULT a v Dxx uz nie
      CB_EditFld.ItemIndex := 1;
      If LineElement (mS,5,',')='FALSE' then CB_EditFld.ItemIndex := 0;
      E_DisplayName.Enabled := TRUE;
      E_DisplayWidth.Enabled := TRUE;
      CB_Alignment.Enabled := TRUE;
      CB_Format.Enabled := TRUE;
      CB_EditFld.Enabled := oService;
    end else begin
      E_DisplayName.Text := 'Neexistujúce pole!';
    end;
  end;
end;

procedure TF_GridDG.DeleteInAllList (pFld:string);
var
  I:integer;
  mOK:boolean;
begin
  If LB_AllFields.Items.Count>0 then begin
    I := 0;
    mOK := FALSE;
    While (I<LB_AllFields.Items.Count) and not mOK do begin
      If pFld=LB_AllFields.Items.Strings[I] then begin
        LB_AllFields.Items.Delete (I);
        mOK := TRUE
      end;
      Inc (I);
    end;
  end;
end;

procedure TF_GridDG.SB_UpClick(Sender: TObject);
var mIt:integer;
begin
  If LB_Viewer.ItemIndex>0 then begin
    mIt := LB_Viewer.ItemIndex;
    LB_Viewer.Items.Move (mIt,mIt-1);
    oGridSet.oSetGrid.Move (mIt,mIt-1);
    LB_Viewer.ItemIndex := mIt-1;
    LB_Viewer.Selected[LB_Viewer.ItemIndex] := TRUE;
  end;
end;

procedure TF_GridDG.SB_DownClick(Sender: TObject);
var mIt:integer;
begin
  If (LB_Viewer.ItemIndex>=0) and (LB_Viewer.ItemIndex<LB_Viewer.Items.Count-1) then begin
    mIt := LB_Viewer.ItemIndex;
    LB_Viewer.Items.Move (mIt,mIt+1);
    oGridSet.oSetGrid.Move (mIt,mIt+1);
    LB_Viewer.ItemIndex := mIt+1;
    LB_Viewer.Selected[LB_Viewer.ItemIndex] := TRUE;
  end;
end;

procedure TF_GridDG.SB_CopySelItmClick(Sender: TObject);
var
  I:integer;
  mTab:integer;
  mIt:integer;
begin
  If LB_AllFields.SelCount>0 then begin
    mTab := LB_AllFields.ItemIndex;
    I := 0;
    While (I<LB_AllFields.Items.Count) do begin
      If LB_AllFields.Selected[I] then begin
        LB_Viewer.Items.Add (LB_AllFields.Items.Strings[I]);
        mIt := FindInDefault (LB_AllFields.Items.Strings[I]);
        If mIt>=0 then oGridSet.oSetGrid.Add ('Field'+StrInt (oGridSet.oSetGrid.Count,0)+'='+CopyInDefParams (oGridSet.oDefGrid.Strings[mIt]));
        LB_AllFields.Items.Delete (I);
      end else Inc (I);
    end;
    If mTab<LB_AllFields.Items.Count
      then LB_AllFields.ItemIndex := mTab
      else LB_AllFields.ItemIndex := LB_AllFields.Items.Count-1;
    LB_AllFields.Selected[LB_AllFields.ItemIndex] := TRUE;
  end;
end;

procedure TF_GridDG.SB_RemoveSelItmClick(Sender: TObject);
var
  I:integer;
  mTab:integer;
begin
  If LB_Viewer.SelCount>0 then begin
    mTab := LB_Viewer.ItemIndex;
    I := 0;
    While (I<LB_Viewer.Items.Count) do begin
      If LB_Viewer.Selected[I] then begin
        LB_AllFields.Items.Insert (GetAllFieldsIndex (LB_Viewer.Items.Strings[I]),LB_Viewer.Items.Strings[I]);
        LB_Viewer.Items.Delete (I);
        oGridSet.oSetGrid.Delete (I);
      end else Inc (I);
    end;
    If mTab<LB_Viewer.Items.Count
      then LB_Viewer.ItemIndex := mTab
      else LB_Viewer.ItemIndex := LB_Viewer.Items.Count-1;
    LB_Viewer.Selected[LB_Viewer.ItemIndex] := TRUE;
    FillFldData;
  end;
end;

procedure TF_GridDG.SB_CopyAllItmClick(Sender: TObject);
var
  I:integer;
  mIt:integer;
begin
  If LB_AllFields.Items.Count>0 then begin
    I := 0;
    While (I<LB_AllFields.Items.Count) do begin
      LB_Viewer.Items.Add (LB_AllFields.Items.Strings[I]);
      mIt := FindInDefault (LB_AllFields.Items.Strings[I]);
      If mIt>=0 then oGridSet.oSetGrid.Add ('Field'+StrInt (oGridSet.oSetGrid.Count,0)+'='+CopyInDefParams (oGridSet.oDefGrid.Strings[mIt]));
      LB_AllFields.Items.Delete (I);
    end;
  end;
end;

procedure TF_GridDG.SB_RemoveAllItmClick(Sender: TObject);
var I:integer;
begin
  If LB_Viewer.Items.Count>0 then begin
    I := 0;
    While (I<LB_Viewer.Items.Count) do begin
      LB_Viewer.Items.Delete (I);
      oGridSet.oSetGrid.Delete (I);
    end;
    ReadAllFlds;
    HideViewerFld;
  end;
end;

procedure TF_GridDG.HideViewerFld;
begin
  E_DisplayName.Text := '';
  E_DisplayName.Enabled := FALSE;
  E_DisplayWidth.Text := '';
  E_DisplayWidthChar.Text := '';
  E_DisplayWidth.Enabled := FALSE;
  CB_Alignment.ItemIndex := -1;
  CB_Alignment.Enabled := FALSE;
  CB_Format.Text := '';
  NI_FullName.Text:= '';
  CB_Format.Enabled := FALSE;
  CB_EditFld.ItemIndex := -1;
  CB_EditFld.Enabled := FALSE;
end;

procedure TF_GridDG.LB_AllFieldsExit(Sender: TObject);
var I:integer;
begin
  LB_AllFields.ItemIndex := -1;
  For I:=0 to LB_AllFields.Items.Count-1 do
    LB_AllFields.Selected[I] := FALSE;
end;

function  TF_GridDG.FindInDefault (pFld:string):integer;
var
  I:integer;
  mOK:boolean;
begin
  Result := -1;
  If oGridSet.oDefGrid.Count>0 then begin
    mOK := FALSE;
    I := 0;
    While (I<oGridSet.oDefGrid.Count) and not mOK do begin
      mOK := (Pos (pFld+',',oGridSet.oDefGrid.Strings[I])=1);
      If not mOK then Inc (I);
    end;
    If mOK then Result := I;
  end;
end;

procedure TF_GridDG.BB_SaveClick(Sender: TObject);
var
  I:integer;
  mSect:string;
  mFontType:string;
  mFile:TIniFile;
  mColorGrp:string;
  mAct,mFld:string; mIni:TIniFile;
begin
  If ChB_SaveUniFields.Checked and (LB_Viewer.Count>0) then begin
    mIni := TIniFile.Create(ExtractFilePath(oDGDName)+'FLDS.TXT');
    For I:=0 to LB_Viewer.Count-1 do begin
      mAct := oGridSet.oSetGrid.Strings[I];
      Delete (mAct,1,Pos ('=',mAct));
      mFld := LineElement(mAct,0,',');
      Delete (mAct,1,Pos (',',mAct));
      If not mIni.ValueExists('Fields',mFld) then mIni.WriteString('Fields',mFld,mAct);
    end;
    FreeAndNil (mIni);
  end;

  mSect := L_SetNum.Caption;
  If not oService and (Copy (mSect,1,1)<>'U') then begin
    NewSetGrid (oService);
    mSect := L_SetNum.Caption;
  end;
  If oGridSet.oSetGrid.Count>0 then begin
    For I:=0 to oGridSet.oSetGrid.Count-1 do
      oGridSet.oSetGrid.Strings[I] := 'Field'+StrInt (I,0)+'='+Copy (oGridSet.oSetGrid.Strings[I],Pos ('=',oGridSet.oSetGrid.Strings[I])+1,Length (oGridSet.oSetGrid.Strings[I]));
  end;
  mFontType := '';
  If SB_GridFontBold.Down then mFontType := mFontType+'B';
  If SB_GridFontItalic.Down then mFontType := mFontType+'I';
  oGridSet.oSetGrid.Insert (0,'GridFont='+CB_GridFont.Text+','+CB_GridFontSize.Text+','+mFontType);
  mFontType := '';
  If SB_HeadFontBold.Down then mFontType := mFontType+'B';
  If SB_HeadFontItalic.Down then mFontType := mFontType+'I';
  oGridSet.oSetGrid.Insert (0,'HeadFont='+CB_HeadFont.Text+','+CB_HeadFontSize.Text+','+mFontType);
  oGridSet.oSetGrid.Insert (0,'HEAD='+E_SetHead.Text);
  oGridSet.SaveGridSet (mSect);
  oGridSet.oSetGrid.Delete (0);
  oGridSet.ModifyInList (oService,L_SetNum.Caption,E_SetName.Text);
  ReadSetList (mSect);

  mFile := TIniFile.Create (oDGDName+cDefType);
  mFile.WriteBool ('SETTINGS','ShowOnlyUserSet',ChB_ShowOnlyUserSet.Checked);
  mFile.Free;

  If Copy (CB_SetList.Text,1,1)='D'
    then mFile := TIniFile.Create (oDGDName+cDefType)
    else mFile := TIniFile.Create (oDGDName+cUserType);
  mColorGrp := '   ';
  If CB_ColorGrp.Items.Count>0 then mColorGrp := Copy (CB_ColorGrp.Text,1,3);
  If mColorGrp='   '
    then mFile.DeleteKey (Copy (CB_SetList.Text,1,3),'ColorGrp')
    else mFile.WriteString (Copy (CB_SetList.Text,1,3),'ColorGrp',mColorGrp);
  If ChB_ServiceOnly.Checked and mFile.ValueExists(Copy (CB_SetList.Text,1,3),'ServiceOnly') then mFile.DeleteKey(Copy (CB_SetList.Text,1,3),'ServiceOnly');
  If ChB_ServiceOnly.Checked then mFile.WriteBool(Copy (CB_SetList.Text,1,3),'ServiceOnly',TRUE);
  mFile.Free;

  SetChanged;
end;

procedure TF_GridDG.LB_AllFieldsEnter(Sender: TObject);
var I:integer;
begin
  LB_Viewer.ItemIndex := -1;
  For I:=0 to LB_Viewer.Items.Count-1 do
    LB_Viewer.Selected[I] := FALSE;
  HideViewerFld;
end;

procedure TF_GridDG.BB_NewDefClick(Sender: TObject);
begin
  NewSetGrid (TRUE);
  If ChB_CopyDGD.Checked then BB_SaveClick(Sender);
  ReadSetList (L_SetNum.Caption);
  SetChanged;
  E_SetName.SetFocus;
end;

procedure TF_GridDG.FldEditKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
var mForm:TCustomForm;
begin
  case Key of
    VK_RETURN: begin
      mForm := GetParentForm (Self);
      If (Key = VK_RETURN) then SendMessage (mForm.Handle,WM_NEXTDLGCTL,0,0);
    end;
    VK_ESCAPE: Close;
  end;
end;

procedure TF_GridDG.FldEditExit(Sender: TObject);
var
  mAlignment:string;
  mReadOnly:string;
begin
  mAlignment := 'R';
  If CB_Alignment.ItemIndex=0 then mAlignment := 'L';
  If CB_Alignment.ItemIndex=1 then mAlignment := 'C';
  If CB_Alignment.ItemIndex=2 then mAlignment := 'R';
  mReadOnly := 'TRUE';
  If CB_EditFld.ItemIndex=0 then mReadOnly := 'FALSE';
  oGridSet.oSetGrid.Strings[LB_Viewer.ItemIndex] := Copy (oGridSet.oSetGrid.Strings[LB_Viewer.ItemIndex],1,Pos (',',oGridSet.oSetGrid.Strings[LB_Viewer.ItemIndex]))
    +E_DisplayName.Text+','
    +StrInt (ValInt (E_DisplayWidth.Text),0)+','
    +mAlignment+','+CB_Format.Text+','+mReadOnly{+','+NI_FullName.Text};
end;

procedure TF_GridDG.BB_DeleteClick(Sender: TObject);
var
  mName:string;
  mOK:boolean;
begin
  If not oService
  then mOK := (Copy (L_SetNum.Caption,1,1)='U')
  else mOK := TRUE;
  If mOK then begin
    oGridSet.DeleteGridSet (L_SetNum.Caption);
    If CB_SetList.ItemIndex<CB_SetList.Items.Count-1
      then mName := Copy (CB_SetList.Items.Strings[CB_SetList.ItemIndex+1],1,3)
      else mName := Copy (CB_SetList.Items.Strings[CB_SetList.Items.Count-2],1,3);
    ReadSetList (mName);
    SetChanged;
  end else Beep;
end;

procedure TF_GridDG.NewSetGrid (pService:boolean);
var mName:string;
begin
  mName := oGridSet.GetNewSection (pService);
  L_SetNum.Caption := mName;
  E_SetName.Text := mName;
end;

procedure TF_GridDG.BB_ExitClick(Sender: TObject);
begin
  Close;
end;

procedure TF_GridDG.CB_EditFldKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  case Key of
    VK_RETURN: LB_Viewer.SetFocus;
    VK_ESCAPE: Close;
  end;
end;

procedure TF_GridDG.LB_ViewerEnter(Sender: TObject);
begin
  If (LB_Viewer.ItemIndex=-1) and (LB_Viewer.Items.Count>0) then begin
    LB_Viewer.ItemIndex:= 0;
    LB_Viewer.Selected[LB_Viewer.ItemIndex] := TRUE;
    FillFldData;
  end;
end;

procedure TF_GridDG.LB_AllFieldsDragOver(Sender, Source: TObject; X,
  Y: Integer; State: TDragState; var Accept: Boolean);
begin
 Accept := (Source is TListBox) and ((Source as TListBox).Name='LB_Viewer');
end;

procedure TF_GridDG.LB_ViewerDragDrop(Sender, Source: TObject; X,
  Y: Integer);
var
  mRect:TRect;
  mNewPos:TPoint;
  mIndex:integer;
begin
  If (Sender is TListBox) and (Source is TListBox) then begin
    If (Source as TListBox).Name='LB_AllFields' then SB_CopySelItmClick(Source);
    If (Source as TListBox).Name='LB_Viewer' then begin
      mRect := LB_Viewer.ItemRect(LB_Viewer.ItemIndex);
      mNewPos.X := X;
      mNewPos.Y := Y;
      mIndex := LB_Viewer.ItemIndex;
      LB_Viewer.ItemIndex := LB_Viewer.ItemAtPos (mNewPos,TRUE);
      LB_Viewer.Items.Move (mIndex,LB_Viewer.ItemIndex);
      oGridSet.oSetGrid.Move (mIndex,LB_Viewer.ItemIndex);
      LB_Viewer.Selected[LB_Viewer.ItemIndex] := TRUE;
    end;
  end;
end;

procedure TF_GridDG.LB_ViewerDragOver(Sender, Source: TObject; X,
  Y: Integer; State: TDragState; var Accept: Boolean);
begin
  Accept := Source is TListBox;
end;

procedure TF_GridDG.LB_AllFieldsDragDrop(Sender, Source: TObject; X,
  Y: Integer);
begin
  If (Sender is TListBox) and (Source is TListBox) then begin
     If (Source as TListBox).Name='LB_Viewer' then SB_RemoveSelItmClick(Source);
  end;
end;

procedure TF_GridDG.LB_AllFieldsKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  case Key of
    VK_RETURN: LB_Viewer.SetFocus;
    VK_DELETE: SB_CopySelItmClick(Sender);
    VK_ESCAPE: Close;
  end;
end;

procedure TF_GridDG.LB_ViewerKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  case Key of
    VK_RETURN: If E_DisplayName.Enabled then E_DisplayName.SetFocus;
    VK_DELETE: SB_RemoveSelItmClick(Sender);
    VK_ESCAPE: Close;
  end;
end;

procedure TF_GridDG.LB_AllFieldsDblClick(Sender: TObject);
begin
  If LB_AllFields.Items.Count>0 then begin
    If not LB_AllFields.Selected[LB_AllFields.ItemIndex] then LB_AllFields.Selected[LB_AllFields.ItemIndex] := TRUE;
    SB_CopySelItmClick(Sender);
  end;
end;

procedure TF_GridDG.LB_ViewerDblClick(Sender: TObject);
begin
  If LB_Viewer.Items.Count>0 then begin
    If not LB_Viewer.Selected[LB_Viewer.ItemIndex] then LB_Viewer.Selected[LB_Viewer.ItemIndex] := TRUE;
    SB_RemoveSelItmClick(Sender);
  end;
end;

procedure TF_GridDG.E_SetNameExit(Sender: TObject);
var
  I:integer;
  mSect:string;
  mName:string;
begin
  mSect := L_SetNum.Caption;
  If not oService and (Copy (mSect,1,1)<>'U') then begin
    mName := E_SetName.Text;
    NewSetGrid (oService);
    E_SetName.Text := mName;
    mSect := L_SetNum.Caption;
    If oGridSet.oSetGrid.Count>0 then begin
      For I:=0 to oGridSet.oSetGrid.Count-1 do
        oGridSet.oSetGrid.Strings[I] := 'Field'+StrInt (I,0)+'='+Copy (oGridSet.oSetGrid.Strings[I],Pos ('=',oGridSet.oSetGrid.Strings[I])+1,Length (oGridSet.oSetGrid.Strings[I]));
    end;
    oGridSet.oSetGrid.Insert (0,'HEAD='+E_SetHead.Text);
    oGridSet.SaveGridSet (mSect);
    oGridSet.oSetGrid.Delete (0);
    oGridSet.ModifyInList (oService,mSect,E_SetName.Text);
    ReadSetList (mSect);
    SetChanged;
  end;
end;

function  TF_GridDG.GetAllFieldsIndex (pStr:string):integer;
var
  I:integer;
  mIndex:integer;
  mS:string;
begin
  Result := -1;
  mIndex := 0;
  I := 0;
  mIndex := FindInDefault (pStr);
  If LB_AllFields.Items.Count>0 then begin
    While (I<=mIndex) do begin
      mS := oGridSet.oDefGrid.Strings[I];
      mS := Copy (mS,1,Pos (',',mS)-1);
      If FindInAllFields (mS)>=0 then Inc (Result);
      Inc (I);
    end;
    Inc (Result);
  end;
end;

function  TF_GridDG.FindInAllFields (pFld:string):integer;
var
  I:integer;
  mOK:boolean;
begin
  Result := -1;
  If LB_AllFields.Items.Count>0 then begin
    mOK := FALSE;
    I := 0;
    While (I<LB_AllFields.Items.Count) and not mOK do begin
      mOK := (pFld=LB_AllFields.Items.Strings[I]);
      If not mOK then Inc (I);
    end;
    If mOK then Result := I;
  end;
end;

procedure TF_GridDG.LoadColorGrp;
var mIni:TIniFile; mSections:TStrings; mS,mColorGrp:string; I:longint; mColorInfExists:boolean;
begin
  CB_ColorGrp.Clear;
  If Copy (CB_SetList.Text,1,1)='D'
    then mIni := TIniFile.Create (oDGDName+cDefType)
    else mIni := TIniFile.Create (oDGDName+cUserType);
  mColorGrp := mIni.ReadString (Copy (CB_SetList.Text,1,3),'ColorGrp','');
  ChB_ServiceOnly.Checked := mIni.ReadBool(Copy (CB_SetList.Text,1,3),'ServiceOnly',FALSE);
  mIni.Free;

  mIni := TIniFile.Create (oDGDName+cDefType);
  mColorInfExists := FALSE;
  mSections := TStringList.Create;
  mIni.ReadSections(mSections);
  If mSections.Count>0 then begin
    For I:=0 to mSections.Count-1 do begin
      If not mColorInfExists then mColorInfExists := Copy (UpString (mSections.Strings[I]),1,10)='COLORINFO_';
      If Copy (UpString (mSections.Strings[I]),1,9)='COLORGRP_' then begin
        mS := Copy (mSections.Strings[I],10,3)+'. '+mIni.ReadString(mSections.Strings[I],'Name','');
        CB_ColorGrp.Items.Add(mS);
      end;
    end;
  end;
  mIni.Free;
  If Copy (CB_SetList.Text,1,1)='U' then begin
    mIni := TIniFile.Create (oDGDName+cUserType);
    mSections := TStringList.Create;
    mIni.ReadSections(mSections);
    If mSections.Count>0 then begin
      For I:=0 to mSections.Count-1 do begin
        If Copy (UpString (mSections.Strings[I]),1,9)='COLORGRP_' then begin
          mS := Copy (mSections.Strings[I],10,3)+'. '+mIni.ReadString(mSections.Strings[I],'Name','');
          CB_ColorGrp.Items.Add(mS);
        end;
      end;
    end;
    mIni.Free;
  end;

  If CB_ColorGrp.Items.Count>0 then begin
    mS := '   žiadné';
    CB_ColorGrp.Items.Add(mS);
  end;
  P_ColorGrp.Visible := mColorInfExists;
  If CB_ColorGrp.Items.Count>0 then begin
    CB_ColorGrp.ItemIndex := 0;
    For I:=0 to CB_ColorGrp.Items.Count do begin
      If Copy (CB_ColorGrp.Items.Strings[I],1,3)=mColorGrp then begin
        CB_ColorGrp.ItemIndex := I;
        Break;
      end;
    end;
  end;
end;

function  TF_GridDG.CopyInDefParams (pS:string):string;
var I:byte;
begin
  Result := '';
  For I:=0 to 5 do begin
    If I>0 then Result := Result+',';
    Result := Result+LineElement(pS,I,',');
  end;
end;

procedure TF_GridDG.FormCreate(Sender: TObject);
var mScr:TScreen;
begin
  ClientHeight := 540;
  Caption := ctGridDG_Caption;
  L_SetList.Caption := ctGridDG_SetList;
  L_SetNumTxt.Caption := ctGridDG_SetNumTxt;
  L_SetName.Caption := ctGridDG_SetName;
  L_ViewerHead.Caption := ctGridDG_ViewerHead;
  L_Database.Caption := ctGridDG_Database;
  L_Show.Caption := ctGridDG_Show;
  L_Name.Caption := ctGridDG_Name;
  L_Width.Caption := ctGridDG_Width;
  L_DisplayWidth.Caption := ctGridDG_DisplayWidth;
  L_DisplayWidthChar.Caption := ctGridDG_DisplayWidthChar;
  L_Alignment.Caption := ctGridDG_Alignment;
  L_Format.Caption := ctGridDG_Format;
  L_ReadOnly.Caption := ctGridDG_EditFld;

  SB_CopySelItm.Hint := ctGridDG_CopySelItm;
  SB_RemoveSelItm.Hint := ctGridDG_RemoveSelItm;
  SB_CopyAllItm.Hint := ctGridDG_CopyAllItm;
  SB_RemoveAllItm.Hint := ctGridDG_RemoveAllItm;
  SB_Up.Hint := ctGridDG_Up;
  SB_Down.Hint := ctGridDG_Down;

  CB_Alignment.Items.Add (ctGridDG_AlignmentLeft);
  CB_Alignment.Items.Add (ctGridDG_AlignmentCent);
  CB_Alignment.Items.Add (ctGridDG_AlignmentRight);

  CB_EditFld.Items.Add (ctGridDG_EditFldYes);
  CB_EditFld.Items.Add (ctGridDG_EditFldNo);

  BB_NewDef.Caption := ctGridDG_NewDef;
  BB_NewUser.Caption := ctGridDG_NewUser;
  BB_Delete.Caption := ctGridDG_Delete;
  BB_Save.Caption := ctGridDG_Save;
  BB_Exit.Caption := ctGridDG_Exit;
  BB_DefEdit.Caption := ctGridDG_DefEdit;
  ChB_ShowOnlyUserSet.Caption := ctGridDG_ShowOnlyUserSet;

  CB_HeadFont.Clear;
  CB_GridFont.Clear;
  mScr := TScreen.Create (Self);
  mScr.ResetFonts;
  CB_HeadFont.Items := mScr.Fonts;
  CB_GridFont.Items := mScr.Fonts;
  mScr.Free; mScr := nil;
end;

procedure TF_GridDG.E_DisplayWidthCharExit(Sender: TObject);
begin
  E_DisplayWidth.Text := StrInt (ValInt (E_DisplayWidthChar.Text)*oFontSize,0);
  FldEditExit (Sender);
end;

procedure TF_GridDG.E_DisplayWidthExit(Sender: TObject);
begin
  E_DisplayWidthChar.Text := StrInt (ValInt (E_DisplayWidth.Text) div oFontSize,0);
  FldEditExit (Sender);
end;

procedure TF_GridDG.BB_DefEditClick(Sender: TObject);
var mF:TF_GridDef;
begin
  // ulozit zmeny pred vyvolanim formulara zakladnych nastaveni
  BB_SaveClick(Sender);
  mF := TF_GridDef.Create (Self);
  mF.Execute (oDGDName,oFontSize,oDataSet);
  mF.Free;
  oGridSet.ReadDefault;
  SetChanged;
end;

procedure TF_GridDG.CB_FormatKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  case Key of
    VK_RETURN: begin
      If CB_EditFld.Enabled
        then CB_EditFld.SetFocus
        else LB_Viewer.SetFocus;
    end;
    VK_ESCAPE: Close;
  end;
end;

procedure TF_GridDG.BB_SetDefFieldClick(Sender: TObject);
var mIt:integer;
begin
  If LB_Viewer.Count>0 then begin
    mIt := FindInDefault (LB_Viewer.Items.Strings[LB_Viewer.ItemIndex]);
    If mIt>=0 then begin
      oGridSet.oSetGrid.Strings[LB_Viewer.ItemIndex] := ('Field'+StrInt (LB_Viewer.ItemIndex,0)+'='+oGridSet.oDefGrid.Strings[mIt]);
      FillFldData;
    end;
  end;
end;

procedure TF_GridDG.BB_SetDefViewFieldsClick(Sender: TObject);
var
  mIt:integer;
  I:integer;
begin
  If LB_Viewer.Count>0 then begin
    For I:=0 to LB_Viewer.Count-1 do begin
      mIt := FindInDefault (LB_Viewer.Items.Strings[I]);
      If mIt>=0 then oGridSet.oSetGrid.Strings[I] := ('Field'+StrInt (I,0)+'='+oGridSet.oDefGrid.Strings[mIt]);
    end;
    FillFldData;
  end;
end;

procedure TF_GridDG.BB_NewUserClick(Sender: TObject);
begin
  NewSetGrid(FALSE);
  If ChB_CopyDGD.Checked then BB_SaveClick(Sender);
  ReadSetList (L_SetNum.Caption);
  SetChanged;
  E_SetName.SetFocus;
end;

procedure TF_GridDG.FormShow(Sender: TObject);
begin
  BB_NewDef.Enabled := oService;
end;

procedure TF_GridDG.B_DelNotExistClick(Sender: TObject);
var I:integer;
begin
  If LB_Viewer.SelCount>0 then begin
    I := 0;
    While (I<LB_Viewer.Items.Count) do begin
      If oDataSet.FindField(LB_Viewer.Items.Strings[I])=nil then begin
        LB_Viewer.Items.Delete (I);
        oGridSet.oSetGrid.Delete (I);
      end else Inc (I);
    end;
    LB_Viewer.Selected[LB_Viewer.ItemIndex] := TRUE;
    FillFldData;
  end;
end;

procedure TF_GridDG.B_SaveDefFieldClick(Sender: TObject);
var I,J:longint; mAct,mFld,mS,mInfo:string;
begin
  If LB_Viewer.ItemIndex>-1 then begin
    mAct := oGridSet.oSetGrid.Strings[LB_Viewer.ItemIndex];
    Delete (mAct,1,Pos ('=',mAct));
    mFld := UpString (LineElement(mAct,0,','));
    oGridSet.ReadDefault;
    If oGridSet.oDefGrid.Count>0 then begin
      For I:=0 to oGridSet.oDefGrid.Count-1 do begin
        mS := oGridSet.oDefGrid.Strings[I];
        If UpString (LineElement (mS,0,','))=mFld then begin
          mInfo := LineElement(oGridSet.oDefGrid.Strings[I],6,',');
          oGridSet.oDefGrid.Strings[I] := mAct+','+mInfo;
          For J:=0 to oGridSet.oDefGrid.Count-1 do
            oGridSet.oDefGrid.Strings[J] := 'Field'+StrInt (J,0)+'='+Copy (oGridSet.oDefGrid.Strings[J],Pos ('=',oGridSet.oDefGrid.Strings[J])+1,Length (oGridSet.oDefGrid.Strings[J]));
          oGridSet.SaveDefault;
          oGridSet.ReadDefault;
          Break;
        end;
      end;
    end;
  end;
end;

procedure TF_GridDG.B_SaveDefFieldsClick(Sender: TObject);
var I,J:longint; mAct,mFld,mS,mInfo:string; mSave,mChange:boolean;
begin
  If LB_Viewer.Count>0 then begin
    mSave := FALSE;
    oGridSet.ReadDefault;
    For I:=0 to LB_Viewer.Count-1 do begin
      mAct := oGridSet.oSetGrid.Strings[I];
      Delete (mAct,1,Pos ('=',mAct));
      mFld := UpString (LineElement(mAct,0,','));
      If oGridSet.oDefGrid.Count>0 then begin
        For J:=0 to oGridSet.oDefGrid.Count-1 do begin
          mS := oGridSet.oDefGrid.Strings[J];
          If UpString (LineElement (mS,0,','))=mFld then begin
            mChange := TRUE;
            If ChB_SaveDefFieldsNew.Checked then mChange := LineElement(oGridSet.oDefGrid.Strings[J],0,',')=LineElement(oGridSet.oDefGrid.Strings[J],1,',');
            If mChange then begin
              mInfo := LineElement(oGridSet.oDefGrid.Strings[J],6,',');
              oGridSet.oDefGrid.Strings[J] := mAct+','+mInfo;
              mSave := TRUE;
            end;
            Break;
          end;
        end;
      end;
    end;
    If mSave then begin
      For J:=0 to oGridSet.oDefGrid.Count-1 do
        oGridSet.oDefGrid.Strings[J] := 'Field'+StrInt (J,0)+'='+Copy (oGridSet.oDefGrid.Strings[J],Pos ('=',oGridSet.oDefGrid.Strings[J])+1,Length (oGridSet.oDefGrid.Strings[J]));
      oGridSet.SaveDefault;
      oGridSet.ReadDefault;
    end;
  end;
end;

procedure TF_GridDG.B_SaveUniFieldClick(Sender: TObject);
var mAct,mFld:string; mIni:TIniFile;
begin
  If LB_Viewer.ItemIndex>-1 then begin
    mAct := oGridSet.oSetGrid.Strings[LB_Viewer.ItemIndex];
    Delete (mAct,1,Pos ('=',mAct));
    mFld := LineElement(mAct,0,',');
    Delete (mAct,1,Pos (',',mAct));
    mIni := TIniFile.Create(ExtractFilePath(oDGDName)+'FLDS.TXT');
    mIni.WriteString('Fields',mFld,mAct);
    FreeAndNil (mIni);
  end;
end;

procedure TF_GridDG.B_SetUniFieldClick(Sender: TObject);
var mAct,mFld,mS:string; mIni:TIniFile;
begin
  If LB_Viewer.Count>0 then begin
    mAct := oGridSet.oSetGrid.Strings[LB_Viewer.ItemIndex];
    Delete (mAct,1,Pos ('=',mAct));
    mFld := LineElement(mAct,0,',');
    mIni := TIniFile.Create(ExtractFilePath(oDGDName)+'FLDS.TXT');
    If mIni.ValueExists ('Fields',mFld) then begin
      mS := mIni.ReadString('Fields',mFld,'');
      oGridSet.oSetGrid.Strings[LB_Viewer.ItemIndex] := ('Field'+StrInt (LB_Viewer.ItemIndex,0)+'='+mFld+','+mS);
      FillFldData;
    end;
    FreeAndNil (mIni);
  end;
end;

procedure TF_GridDG.B_AddColorGrpClick(Sender: TObject);
begin
  F_AdvGridColAdd := TF_AdvGridColAdd.Create(Self);
  F_AdvGridColAdd.Execute (oDGDName,Copy (CB_SetList.Text,1,3),oService);
  FreeAndNil (F_AdvGridColAdd);
  LoadColorGrp;
end;

procedure TF_GridDG.Action1Execute(Sender: TObject);
begin
  Close;
end;

procedure TF_GridDG.LB_AllFieldsClick(Sender: TObject);
var mIndex:longint;
begin
  L_FldInfo.Caption := '';
  L_FldInfo.Hint := '';
  If LB_AllFields.ItemIndex>-1 then begin
    If oGridSet.FindFieldInDefGrid(LB_AllFields.Items.Strings[LB_AllFields.ItemIndex],mIndex) then begin
      L_FldInfo.Caption := LineElement (oGridSet.oDefGrid.Strings[mIndex],1,',');
      L_FldInfo.Hint := LineElement (oGridSet.oDefGrid.Strings[mIndex],6,',');
    end;
  end;
end;

end.
