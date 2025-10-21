unit AdvGrid_ColText;

interface

uses
  IniFiles, IcConv,AdvGrid_GridSet,
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, xpComp, ExtCtrls, ActnList;

type
  TF_AdvGridColText = class(TForm)
    xpSinglePanel1: TxpSinglePanel;
    E_TypeNum: TxpEdit;
    E_TypeName: TxpEdit;
    xpLabel1: TxpLabel;
    xpLabel2: TxpLabel;
    xpGroupBox1: TxpGroupBox;
    xpLabel3: TxpLabel;
    xpLabel4: TxpLabel;
    xpLabel6: TxpLabel;
    xpLabel5: TxpLabel;
    xpLabel7: TxpLabel;
    xpLabel8: TxpLabel;
    xpLabel9: TxpLabel;
    xpLabel10: TxpLabel;
    xpLabel11: TxpLabel;
    xpLabel12: TxpLabel;
    E_Text1: TxpEdit;
    E_Text2: TxpEdit;
    E_Text3: TxpEdit;
    E_Text4: TxpEdit;
    E_Text5: TxpEdit;
    E_Text6: TxpEdit;
    E_Text7: TxpEdit;
    E_Text8: TxpEdit;
    E_Text9: TxpEdit;
    E_Text10: TxpEdit;
    CB_Type: TxpComboBox;
    xpLabel13: TxpLabel;
    B_Save: TxpBitBtn;
    B_Cancel: TxpBitBtn;
    B_Del: TxpBitBtn;
    ActionList1: TActionList;
    Action1: TAction;
    procedure CB_TypeChange(Sender: TObject);
    procedure B_CancelClick(Sender: TObject);
    procedure B_SaveClick(Sender: TObject);
    procedure B_DelClick(Sender: TObject);
    procedure E_TypeNumExit(Sender: TObject);
    procedure Action1Execute(Sender: TObject);
  private
    oDGDFile :string;

    procedure LoadData;
    procedure SetCBType;
    { Private declarations }
  public
    procedure Execute (pDGDFile:string);
    { Public declarations }
  end;

var
  F_AdvGridColText: TF_AdvGridColText;

implementation

{$R *.dfm}

procedure TF_AdvGridColText.Execute (pDGDFile:string);
begin
  oDGDFile := pDGDFile;
  LoadData;
  CB_TypeChange(nil);
  ShowModal;
end;

procedure TF_AdvGridColText.LoadData;
var mIni:TIniFile; mSList:TStringList; I:longint; mS:string;
begin
  CB_Type.Clear;
  mIni := TIniFile.Create(oDGDFile+cDefType);
  mSList :=TStringList.Create;
  mIni.ReadSections(mSList);
  If mSList.Count>0 then begin
    For I:=0 to mSList.Count-1 do begin
      If Pos ('ColorInfo_',mSList.Strings[I])=1 then begin
        mS := StrIntZero (ValInt (Copy (mSList.Strings[I],11,2)),2)+'. ';
        mS := mS+mIni.ReadString(mSList.Strings[I],'Name','');
        CB_Type.Items.Add(mS);
      end;
    end;
  end;
  FreeAndNil (mSList);
  FreeAndNil (mIni);
  If CB_Type.Items.Count>0 then CB_Type.ItemIndex := 0;
end;

procedure TF_AdvGridColText.SetCBType;
var I:longint; mS:string;
begin
  If CB_Type.Items.Count>0 then begin
    For I:=0 to CB_Type.Items.Count-1 do begin
      mS := '';
      If Pos ('.',CB_Type.Items.Strings[I])>0 then mS := Copy (CB_Type.Items.Strings[I],1,Pos ('.',CB_Type.Items.Strings[I])-1);
      If ValInt (mS)=E_TypeNum.AsInteger then begin
        CB_Type.ItemIndex := I;
        Break;
      end;
    end;
  end;
end;

procedure TF_AdvGridColText.CB_TypeChange(Sender: TObject);
var mIni:TIniFile; mSect:string;
begin
  If CB_Type.Text<>'' then begin
    E_TypeNum.AsInteger := ValInt (Copy (CB_Type.Text,1,2));
    E_TypeName.AsString := Copy (CB_Type.Text,5,Length (CB_Type.Text));
    mIni := TIniFile.Create(oDGDFile+cDefType);
    mSect := 'ColorInfo_'+StrInt(E_TypeNum.AsInteger,0);
    E_Text1.Text := mIni.ReadString(mSect,'Info1','');
    E_Text2.Text := mIni.ReadString(mSect,'Info2','');
    E_Text3.Text := mIni.ReadString(mSect,'Info3','');
    E_Text4.Text := mIni.ReadString(mSect,'Info4','');
    E_Text5.Text := mIni.ReadString(mSect,'Info5','');
    E_Text6.Text := mIni.ReadString(mSect,'Info6','');
    E_Text7.Text := mIni.ReadString(mSect,'Info7','');
    E_Text8.Text := mIni.ReadString(mSect,'Info8','');
    E_Text9.Text := mIni.ReadString(mSect,'Info9','');
    E_Text10.Text := mIni.ReadString(mSect,'Info10','');
    FreeAndNil (mIni);
  end;
end;

procedure TF_AdvGridColText.B_CancelClick(Sender: TObject);
begin
  Close;
end;

procedure TF_AdvGridColText.B_SaveClick(Sender: TObject);
var mIni:TIniFile; mSect:string;
begin
  If E_TypeNum.AsInteger>0 then begin
    mIni := TIniFile.Create(oDGDFile+cDefType);
    mSect := 'ColorInfo_'+StrInt(E_TypeNum.AsInteger,0);
    mIni.WriteString(mSect,'Name',E_TypeName.Text);
    mIni.WriteString(mSect,'Info1',E_Text1.Text);
    mIni.WriteString(mSect,'Info2',E_Text2.Text);
    mIni.WriteString(mSect,'Info3',E_Text3.Text);
    mIni.WriteString(mSect,'Info4',E_Text4.Text);
    mIni.WriteString(mSect,'Info5',E_Text5.Text);
    mIni.WriteString(mSect,'Info6',E_Text6.Text);
    mIni.WriteString(mSect,'Info7',E_Text7.Text);
    mIni.WriteString(mSect,'Info8',E_Text8.Text);
    mIni.WriteString(mSect,'Info9',E_Text9.Text);
    mIni.WriteString(mSect,'Info10',E_Text10.Text);
    FreeAndNil (mIni);
    LoadData;
    SetCBType;
  end;
end;

procedure TF_AdvGridColText.B_DelClick(Sender: TObject);
var mIni:TIniFile; mSect:string;
begin
  If CB_Type.Text<>'' then begin
    If MessageDlg ('Naozaj chcete zruši?', mtWarning,[mbYes,mbNo], 0)=mrYes then begin
      mIni := TIniFile.Create(oDGDFile+cDefType);
      mIni.EraseSection('ColorInfo_'+StrInt (E_TypeNum.AsInteger,0));
      FreeAndNil (mIni);
      LoadData;
      CB_TypeChange(nil);
    end;
  end;
end;

procedure TF_AdvGridColText.E_TypeNumExit(Sender: TObject);
var I:longint; mS:string; mFind:boolean;
begin
  If CB_Type.Items.Count>0 then begin
    For I:=0 to CB_Type.Items.Count-1 do begin
      mS := '';
      If Pos ('.',CB_Type.Items.Strings[I])>0 then mS := Copy (CB_Type.Items.Strings[I],1,Pos ('.',CB_Type.Items.Strings[I])-1);
      If ValInt (mS)=E_TypeNum.AsInteger then begin
        CB_Type.ItemIndex := I;
        CB_TypeChange(nil);
        Break;
      end;
    end;
  end;
end;

procedure TF_AdvGridColText.Action1Execute(Sender: TObject);
begin
  Close;
end;

end.
