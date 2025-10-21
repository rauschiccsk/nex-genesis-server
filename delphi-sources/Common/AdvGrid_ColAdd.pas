unit AdvGrid_ColAdd;

interface

uses
  IcConv,
  IniFiles, AdvGrid_GridSet,
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, ExtCtrls, xpComp, StdCtrls, ActnList;

type
  TF_AdvGridColAdd = class(TForm)
    xpSinglePanel1: TxpSinglePanel;
    xpGroupBox1: TxpGroupBox;
    L_Ln1: TxpLabel;
    B_Color1: TxpBitBtn;
    B_Color2: TxpBitBtn;
    B_Color3: TxpBitBtn;
    B_Color4: TxpBitBtn;
    B_Color5: TxpBitBtn;
    B_Color6: TxpBitBtn;
    B_Color7: TxpBitBtn;
    B_Color8: TxpBitBtn;
    B_Color9: TxpBitBtn;
    B_Color10: TxpBitBtn;
    L_Ln2: TxpLabel;
    L_Ln3: TxpLabel;
    L_Ln4: TxpLabel;
    L_Ln5: TxpLabel;
    L_Ln6: TxpLabel;
    L_Ln7: TxpLabel;
    L_Ln8: TxpLabel;
    L_Ln9: TxpLabel;
    L_Ln10: TxpLabel;
    xpLabel13: TxpLabel;
    CB_ColorGrp: TxpComboBox;
    E_GrpNum: TxpEdit;
    xpLabel1: TxpLabel;
    xpLabel2: TxpLabel;
    E_GrpName: TxpEdit;
    CD_Color: TColorDialog;
    B_Save: TxpBitBtn;
    CB_ColorMode: TxpComboBox;
    CB_ColorTypes: TxpComboBox;
    xpLabel3: TxpLabel;
    B_Cancel: TxpBitBtn;
    B_Del: TxpBitBtn;
    B_New: TxpBitBtn;
    ActionList1: TActionList;
    Action1: TAction;
    procedure B_Color1Click(Sender: TObject);
    procedure B_Color2Click(Sender: TObject);
    procedure B_Color3Click(Sender: TObject);
    procedure B_Color4Click(Sender: TObject);
    procedure B_Color5Click(Sender: TObject);
    procedure B_Color6Click(Sender: TObject);
    procedure B_Color7Click(Sender: TObject);
    procedure B_Color8Click(Sender: TObject);
    procedure B_Color9Click(Sender: TObject);
    procedure B_Color10Click(Sender: TObject);
    procedure CB_ColorModeChange(Sender: TObject);
    procedure CB_ColorGrpChange(Sender: TObject);
    procedure CB_ColorTypesChange(Sender: TObject);
    procedure B_SaveClick(Sender: TObject);
    procedure B_CancelClick(Sender: TObject);
    procedure B_DelClick(Sender: TObject);
    procedure B_NewClick(Sender: TObject);
    procedure Action1Execute(Sender: TObject);
  private
    oDGDFile    : string;
    oDGDName    : string;
    oServiceMode: boolean;

    procedure LoadColorGrps;
    procedure LoadColors (pGrp:string);
    procedure FillColorInfo;
    procedure SetColorInfo (pType:longint);
    { Private declarations }
  public
    procedure Execute (pDGDFile,pDGDName:string;pServiceMode:boolean);
    { Public declarations }
  end;

var
  F_AdvGridColAdd: TF_AdvGridColAdd;

implementation

{$R *.dfm}

procedure TF_AdvGridColAdd.Execute (pDGDFile,pDGDName:string;pServiceMode:boolean);
begin
  oDGDFile := pDGDFile;
  oDGDName := pDGDName;
  oServiceMode := pServiceMode;
  FillColorInfo;
  If oServiceMode then begin
    CB_ColorMode.ItemIndex := 0;
  end else begin
    CB_ColorMode.ItemIndex := 1;
    CB_ColorMode.Enabled := FALSE;
  end;
  CB_ColorModeChange(nil);
  ShowModal;
end;

procedure TF_AdvGridColAdd.LoadColorGrps;
var mIni:TIniFile; mSections:TStrings; mS,mColorGrp:string; I:longint;
begin
  CB_ColorGrp.Clear;
  If CB_ColorMode.ItemIndex=0 then begin
    mIni := TIniFile.Create (oDGDFile+cDefType);
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
  end else begin
    mIni := TIniFile.Create (oDGDFile+cUserType);
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
end;

procedure TF_AdvGridColAdd.LoadColors (pGrp:string);
var mIni:TIniFile; mSect:string; mType:longint;
begin
  mSect := 'ColorGrp_'+pGrp;
  If CB_ColorMode.ItemIndex=0
    then mIni := TIniFile.Create (oDGDFile+cDefType)
    else mIni := TIniFile.Create (oDGDFile+cUserType);
  L_Ln1.Font.Color := mIni.ReadInteger(mSect,'Color1',0);
  L_Ln2.Font.Color := mIni.ReadInteger(mSect,'Color2',0);
  L_Ln3.Font.Color := mIni.ReadInteger(mSect,'Color3',0);
  L_Ln4.Font.Color := mIni.ReadInteger(mSect,'Color4',0);
  L_Ln5.Font.Color := mIni.ReadInteger(mSect,'Color5',0);
  L_Ln6.Font.Color := mIni.ReadInteger(mSect,'Color6',0);
  L_Ln7.Font.Color := mIni.ReadInteger(mSect,'Color7',0);
  L_Ln8.Font.Color := mIni.ReadInteger(mSect,'Color8',0);
  L_Ln9.Font.Color := mIni.ReadInteger(mSect,'Color9',0);
  L_Ln10.Font.Color := mIni.ReadInteger(mSect,'Color10',0);
  mType := mIni.ReadInteger(mSect,'Type',0);
  mIni.Free;
  SetColorInfo(mType);
end;

procedure TF_AdvGridColAdd.FillColorInfo;
var mIni:TIniFile; mSections:TStrings; mS:string; I:longint;
begin
  CB_ColorTypes.Text := '';
  mIni := TIniFile.Create (oDGDFile+cDefType);
  mSections := TStringList.Create;
  mIni.ReadSections(mSections);
  If mSections.Count>0 then begin
    For I:=0 to mSections.Count-1 do begin
      If Copy (UpString (mSections.Strings[I]),1,10)='COLORINFO_' then begin
        mS := Copy (mSections.Strings[I],11,2)+'. '+mIni.ReadString(mSections.Strings[I],'Name','');
        CB_ColorTypes.Items.Add(mS);
      end;
    end;
  end;
  mIni.Free;
end;

procedure TF_AdvGridColAdd.SetColorInfo (pType:longint);
var mIni:TIniFile; mSect:string; I:longint; mS:string;
begin
  If CB_ColorTypes.Items.Count>0 then begin
    For I:=0 to CB_ColorTypes.Items.Count-1 do begin
      mS := '';
      If Pos ('.',CB_ColorTypes.Items.Strings[I])>0 then mS := Copy (CB_ColorTypes.Items.Strings[I],1,Pos ('.',CB_ColorTypes.Items.Strings[I])-1);
      If ValInt (mS)=pType then begin
        CB_ColorTypes.ItemIndex := I;
        Break;
      end;
    end;
  end;
  mSect := 'ColorInfo_'+StrInt (pType,0);
  mIni := TIniFile.Create (oDGDFile+cDefType);
  L_Ln1.Caption := mIni.ReadString(mSect,'Info1','');
  B_Color1.Enabled := L_Ln1.Caption<>'';
  L_Ln2.Caption := mIni.ReadString(mSect,'Info2','');
  B_Color2.Enabled := L_Ln2.Caption<>'';
  L_Ln3.Caption := mIni.ReadString(mSect,'Info3','');
  B_Color3.Enabled := L_Ln3.Caption<>'';
  L_Ln4.Caption := mIni.ReadString(mSect,'Info4','');
  B_Color4.Enabled := L_Ln4.Caption<>'';
  L_Ln5.Caption := mIni.ReadString(mSect,'Info5','');
  B_Color5.Enabled := L_Ln5.Caption<>'';
  L_Ln6.Caption := mIni.ReadString(mSect,'Info6','');
  B_Color6.Enabled := L_Ln6.Caption<>'';
  L_Ln7.Caption := mIni.ReadString(mSect,'Info7','');
  B_Color7.Enabled := L_Ln7.Caption<>'';
  L_Ln8.Caption := mIni.ReadString(mSect,'Info8','');
  B_Color8.Enabled := L_Ln8.Caption<>'';
  L_Ln9.Caption := mIni.ReadString(mSect,'Info9','');
  B_Color9.Enabled := L_Ln9.Caption<>'';
  L_Ln10.Caption := mIni.ReadString(mSect,'Info10','');
  B_Color10.Enabled := L_Ln10.Caption<>'';
  mIni.Free;
end;

procedure TF_AdvGridColAdd.B_Color1Click(Sender: TObject);
begin
  CD_Color.Color := L_Ln1.Font.Color;
  If CD_Color.Execute then L_Ln1.Font.Color := CD_Color.Color;
end;

procedure TF_AdvGridColAdd.B_Color2Click(Sender: TObject);
begin
  CD_Color.Color := L_Ln2.Font.Color;
  If CD_Color.Execute then L_Ln2.Font.Color := CD_Color.Color;
end;

procedure TF_AdvGridColAdd.B_Color3Click(Sender: TObject);
begin
  CD_Color.Color := L_Ln3.Font.Color;
  If CD_Color.Execute then L_Ln3.Font.Color := CD_Color.Color;
end;

procedure TF_AdvGridColAdd.B_Color4Click(Sender: TObject);
begin
  CD_Color.Color := L_Ln4.Font.Color;
  If CD_Color.Execute then L_Ln4.Font.Color := CD_Color.Color;
end;

procedure TF_AdvGridColAdd.B_Color5Click(Sender: TObject);
begin
  CD_Color.Color := L_Ln5.Font.Color;
  If CD_Color.Execute then L_Ln5.Font.Color := CD_Color.Color;
end;

procedure TF_AdvGridColAdd.B_Color6Click(Sender: TObject);
begin
  CD_Color.Color := L_Ln6.Font.Color;
  If CD_Color.Execute then L_Ln6.Font.Color := CD_Color.Color;
end;

procedure TF_AdvGridColAdd.B_Color7Click(Sender: TObject);
begin
  CD_Color.Color := L_Ln7.Font.Color;
  If CD_Color.Execute then L_Ln7.Font.Color := CD_Color.Color;
end;

procedure TF_AdvGridColAdd.B_Color8Click(Sender: TObject);
begin
  CD_Color.Color := L_Ln8.Font.Color;
  If CD_Color.Execute then L_Ln8.Font.Color := CD_Color.Color;
end;

procedure TF_AdvGridColAdd.B_Color9Click(Sender: TObject);
begin
  CD_Color.Color := L_Ln9.Font.Color;
  If CD_Color.Execute then L_Ln9.Font.Color := CD_Color.Color;
end;

procedure TF_AdvGridColAdd.B_Color10Click(Sender: TObject);
begin
  CD_Color.Color := L_Ln10.Font.Color;
  If CD_Color.Execute then L_Ln10.Font.Color := CD_Color.Color;
end;

procedure TF_AdvGridColAdd.CB_ColorModeChange(Sender: TObject);
begin
  LoadColorGrps;
  If CB_ColorGrp.Items.Count>0 then begin
    CB_ColorGrp.ItemIndex := 0;
    CB_ColorGrpChange(nil);
  end;
end;

procedure TF_AdvGridColAdd.CB_ColorGrpChange(Sender: TObject);
begin
  LoadColors (Copy (CB_ColorGrp.Text,1,3));
  E_GrpNum.AsInteger := ValInt (Copy (CB_ColorGrp.Text,2,2));
  E_GrpName.AsString := Copy (CB_ColorGrp.Text,5,Length (CB_ColorGrp.Text));
end;

procedure TF_AdvGridColAdd.CB_ColorTypesChange(Sender: TObject);
var mIni:TIniFile; mSect,mS:string;
begin
  mS := '';
  If Pos ('.',CB_ColorTypes.Text)>0 then mS := Copy (CB_ColorTypes.Text,1,Pos ('.',CB_ColorTypes.Text)-1);
  mSect := 'ColorInfo_'+StrInt (ValInt (mS),0);
  mIni := TIniFile.Create (oDGDFile+cDefType);
  L_Ln1.Caption := mIni.ReadString(mSect,'Info1','');
  B_Color1.Enabled := L_Ln1.Caption<>'';
  L_Ln2.Caption := mIni.ReadString(mSect,'Info2','');
  B_Color2.Enabled := L_Ln2.Caption<>'';
  L_Ln3.Caption := mIni.ReadString(mSect,'Info3','');
  B_Color3.Enabled := L_Ln3.Caption<>'';
  L_Ln4.Caption := mIni.ReadString(mSect,'Info4','');
  B_Color4.Enabled := L_Ln4.Caption<>'';
  L_Ln5.Caption := mIni.ReadString(mSect,'Info5','');
  B_Color5.Enabled := L_Ln5.Caption<>'';
  L_Ln6.Caption := mIni.ReadString(mSect,'Info6','');
  B_Color6.Enabled := L_Ln6.Caption<>'';
  L_Ln7.Caption := mIni.ReadString(mSect,'Info7','');
  B_Color7.Enabled := L_Ln7.Caption<>'';
  L_Ln8.Caption := mIni.ReadString(mSect,'Info8','');
  B_Color8.Enabled := L_Ln8.Caption<>'';
  L_Ln9.Caption := mIni.ReadString(mSect,'Info9','');
  B_Color9.Enabled := L_Ln9.Caption<>'';
  L_Ln10.Caption := mIni.ReadString(mSect,'Info10','');
  B_Color10.Enabled := L_Ln10.Caption<>'';
  mIni.Free;
end;

procedure TF_AdvGridColAdd.B_SaveClick(Sender: TObject);
var mIni:TIniFile; mS,mSect,mDGDType:string; mType,I:longint;
begin
  If E_GrpNum.AsInteger>0 then begin
    If CB_ColorMode.ItemIndex=0 then begin
      mDGDType := 'D';
      mIni := TIniFile.Create(oDGDFile+cDefType);
    end else begin
      mDGDType := 'U';
      mIni := TIniFile.Create(oDGDFile+cUserType);
    end;
    mType := ValInt (Copy (CB_ColorTypes.Text,1, Pos ('.',CB_ColorTypes.Text)-1));
    mSect := 'ColorGrp_'+mDGDType+StrIntZero(E_GrpNum.AsInteger,2);
    mIni.WriteString(mSect,'Name',E_GrpName.Text);
    mIni.WriteInteger(mSect,'Type',mType);
    mIni.WriteInteger(mSect,'Color1',L_Ln1.Font.Color);
    mIni.WriteInteger(mSect,'Color2',L_Ln2.Font.Color);
    mIni.WriteInteger(mSect,'Color3',L_Ln3.Font.Color);
    mIni.WriteInteger(mSect,'Color4',L_Ln4.Font.Color);
    mIni.WriteInteger(mSect,'Color5',L_Ln5.Font.Color);
    mIni.WriteInteger(mSect,'Color6',L_Ln6.Font.Color);
    mIni.WriteInteger(mSect,'Color7',L_Ln7.Font.Color);
    mIni.WriteInteger(mSect,'Color8',L_Ln8.Font.Color);
    mIni.WriteInteger(mSect,'Color9',L_Ln9.Font.Color);
    mIni.WriteInteger(mSect,'Color10',L_Ln10.Font.Color);
    FreeAndNil (mIni);
    LoadColorGrps;
    If CB_ColorGrp.Items.Count>0 then begin
      For I:=0 to CB_ColorGrp.Items.Count-1 do begin
        mS := '';
        If Pos ('.',CB_ColorGrp.Items.Strings[I])>0 then mS := Copy (CB_ColorGrp.Items.Strings[I],2,Pos ('.',CB_ColorGrp.Items.Strings[I])-2);
        If ValInt (mS)=E_GrpNum.AsInteger then begin
          CB_ColorGrp.ItemIndex := I;
          Break;
        end;
      end;
    end;
  end;
end;

procedure TF_AdvGridColAdd.B_CancelClick(Sender: TObject);
begin
  Close;
end;

procedure TF_AdvGridColAdd.B_DelClick(Sender: TObject);
var mIni:TIniFile; mSect,mDGDType:string;
begin
  If CB_ColorGrp.Text<>'' then begin
    If MessageDlg ('Naozaj chcete zruši?', mtWarning,[mbYes,mbNo], 0)=mrYes then begin
      If CB_ColorMode.ItemIndex=0 then begin
        mDGDType := 'D';
        mIni := TIniFile.Create(oDGDFile+cDefType);
      end else begin
        mDGDType := 'U';
        mIni := TIniFile.Create(oDGDFile+cUserType);
      end;
      mIni.EraseSection('ColorGrp_'+mDGDType+StrIntZero (E_GrpNum.AsInteger,2));
      FreeAndNil (mIni);
      CB_ColorModeChange(nil);
    end;
  end;
end;

procedure TF_AdvGridColAdd.B_NewClick(Sender: TObject);
var mS:string; mNum,I:longint;
begin
  mNum := 1;
  If CB_ColorGrp.Items.Count>0 then begin
    For I:=0 to CB_ColorGrp.Items.Count-1 do begin
      mS := '';
      If Pos ('.',CB_ColorGrp.Items.Strings[I])>0 then mS := Copy (CB_ColorGrp.Items.Strings[I],2,Pos ('.',CB_ColorGrp.Items.Strings[I])-2);
      If ValInt (mS)>mNum then begin
        Break;
      end else Inc (mNum);
    end;
  end;
  E_GrpNum.AsInteger := mNum;
end;

procedure TF_AdvGridColAdd.Action1Execute(Sender: TObject);
begin
  Close;
end;

end.

