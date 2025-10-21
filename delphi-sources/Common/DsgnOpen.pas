unit DsgnOpen;

interface

uses
  IcForm,
  EncodeIni, DsgnUtils, IcTools, IcConv,
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, xpComp, StdCtrls, ExtCtrls;

type
  TF_DsgnOpen = class(TIcForm)
    xpSinglePanel1: TxpSinglePanel;
    LB_Forms: TListBox;
    B_Open: TxpBitBtn;
    B_Cancel: TxpBitBtn;
    L_File: TxpLabel;
    procedure B_CancelClick(Sender: TObject);
    procedure B_OpenClick(Sender: TObject);
    procedure LB_FormsDblClick(Sender: TObject);
    procedure LB_FormsKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
  private
    oSelect : boolean;
    { Private declarations }
  public
    function Execute (pFileName:string):longint;
    { Public declarations }
  end;

implementation

{$R *.dfm}

function TF_DsgnOpen.Execute (pFileName:string):longint;
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
      LB_Forms.Items.Add(StrInt (mNum,3)+' - '+mName+' ('+StrInt (mLevel,0)+')');
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
  LB_Forms.Sorted := TRUE;
  If LB_Forms.Count>0 then LB_Forms.ItemIndex := 0;
  ShowModal;
  Result := -1;
  If oSelect then begin
    If LB_Forms.Count>0 then Result := ValInt (RemSpaces (LineElement (LB_Forms.Items[LB_Forms.ItemIndex],0,'-')));
  end;
end;

procedure TF_DsgnOpen.B_CancelClick(Sender: TObject);
begin
  Close;
end;

procedure TF_DsgnOpen.B_OpenClick(Sender: TObject);
begin
  oSelect := TRUE;
  Close;
end;

procedure TF_DsgnOpen.LB_FormsDblClick(Sender: TObject);
begin
  oSelect := TRUE;
  Close;
end;

procedure TF_DsgnOpen.LB_FormsKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  If Key=VK_RETURN then begin
    oSelect := TRUE;
    Close;
  end;
end;

end.
