unit DsgnSave;

interface

uses
  IcForm,
  EncodeIni, DsgnUtils, IcTools, IcConv,
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, xpComp, StdCtrls, ExtCtrls;

type
  TF_DsgnSave = class(TIcForm)
    xpSinglePanel1: TxpSinglePanel;
    L_File: TxpLabel;
    LB_Forms: TListBox;
    B_Save: TxpBitBtn;
    B_Cancel: TxpBitBtn;
    xpLabel1: TxpLabel;
    E_FormNum: TxpEdit;
    xpLabel2: TxpLabel;
    E_FormName: TxpEdit;
    xpLabel3: TxpLabel;
    E_FormLevel: TxpEdit;
    procedure LB_FormsDblClick(Sender: TObject);
    procedure LB_FormsKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure B_SaveClick(Sender: TObject);
    procedure B_CancelClick(Sender: TObject);
    procedure LB_FormsClick(Sender: TObject);
  private
    oSelect   : boolean;

    procedure SaveVerify;
  public
    function Execute (pFileName:string;pFormNum:byte):boolean;
  end;

implementation

{$R *.dfm}

function TF_DsgnSave.Execute (pFileName:string;pFormNum:byte):boolean;
var mIni:TEncodeIniFile; mSect:TStrings; mName:string; I,mNum,mLevel:longint;
begin
  oSelect := FALSE;
  L_File.Caption := pFileName;
  LB_Forms.Clear;
  mSect := TStringList.Create;
  mIni := TEncodeIniFile.Create(GetFormDefFileName(pFileName,0),FALSE);
  mIni.ReadSectionValues('List',mSect);
  FreeAndNil (mIni);
  If mSect.Count>0 then begin
    For I:=0 to mSect.Count-1 do begin
      mNum := ValInt (LineElement (mSect.Strings[I],0,'='));
      mName := LineElement (mSect.Strings[I],1,'=');
      mLevel := ValInt (LineElement (mName,1,';'));
      mName := LineElement (mName,0,';');
      If mNum<100 then LB_Forms.Items.Add(StrInt (mNum,3)+' - '+mName+' ('+StrInt (mLevel,0)+')');
    end;
  end;
  mSect.Clear;
  mIni := TEncodeIniFile.Create(GetFormDefFileName(pFileName,100),FALSE);
  mIni.ReadSectionValues('List',mSect);
  FreeAndNil (mIni);
  If mSect.Count>0 then begin
    For I:=0 to mSect.Count-1 do begin
      mNum := ValInt (LineElement (mSect.Strings[I],0,'='));
      mName := LineElement (mSect.Strings[I],1,'=');
      mLevel := ValInt (LineElement (mName,1,';'));
      mName := LineElement (mName,0,';');
      LB_Forms.Items.Add(StrInt (mNum,3)+' - '+mName+' ('+StrInt (mLevel,0)+')');
    end;
  end;
  FreeAndNil (mSect);
  If LB_Forms.Count>0 then begin
    For I:=0 to LB_Forms.Count-1 do begin
      mNum := ValInt (Copy (LB_Forms.Items[I],1,3));
      If mNum=pFormNum then begin
        LB_Forms.ItemIndex := I;
        LB_FormsClick(nil);
      end;
    end;
  end;
  LB_Forms.Sorted := TRUE;
  ShowModal;
  Result := FALSE;
  If oSelect then begin
    Result := TRUE;
  end;
end;

procedure TF_DsgnSave.SaveVerify;
begin
  oSelect := TRUE;
  Close;
end;

procedure TF_DsgnSave.LB_FormsDblClick(Sender: TObject);
begin
  SaveVerify;
end;

procedure TF_DsgnSave.LB_FormsKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  If Key=VK_RETURN then SaveVerify;
end;

procedure TF_DsgnSave.B_SaveClick(Sender: TObject);
begin
  SaveVerify;
end;

procedure TF_DsgnSave.B_CancelClick(Sender: TObject);
begin
  Close;
end;

procedure TF_DsgnSave.LB_FormsClick(Sender: TObject);
var mS:string;
begin
  If LB_Forms.ItemIndex>-1 then begin
    mS := LB_Forms.Items[LB_Forms.ItemIndex];
    mS := RemSpaces (Copy (mS,1,Pos (' - ',mS)-1));
    E_FormNum.AsInteger := ValInt (mS);
    mS := LB_Forms.Items[LB_Forms.ItemIndex];
    mS := Copy (mS,Pos (' - ',mS)+3,Length (mS));
    E_FormName.Text := Copy (mS, 1, Pos (' (',mS)-1);
    mS := LB_Forms.Items[LB_Forms.ItemIndex];
    Delete (mS,1,Pos ('(',mS));
    mS := Copy (mS,1,Pos (')',mS)-1);
    E_FormLevel.AsInteger := ValInt (mS);
  end;
end;

end.
