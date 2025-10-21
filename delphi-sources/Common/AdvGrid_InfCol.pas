unit AdvGrid_InfCol;

interface

uses
  IniFiles, IcConv, AdvGrid_GridSet,
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, ExtCtrls, xpComp, StdCtrls;

type
  TF_AdvGridInfCol = class(TForm)
    xpSinglePanel1: TxpSinglePanel;
    L_Ln1: TxpLabel;
    L_Ln2: TxpLabel;
    L_Ln3: TxpLabel;
    L_Ln4: TxpLabel;
    L_Ln5: TxpLabel;
    L_Ln6: TxpLabel;
    L_Ln7: TxpLabel;
    L_Ln8: TxpLabel;
    L_Ln9: TxpLabel;
    L_Ln10: TxpLabel;
    L_Title: TxpLabel;
    B_Close: TxpBitBtn;
    procedure B_CloseClick(Sender: TObject);
  private
    procedure CMDialogKey(var Message : TCMDialogKey);  message CM_DIALOGKEY;
    procedure CalcFormSize;
    { Private declarations }
  public
    procedure Execute (pDGDFile,pColorGrp:string);
    { Public declarations }
  end;

var
  F_AdvGridInfCol: TF_AdvGridInfCol;

implementation

{$R *.dfm}

procedure TF_AdvGridInfCol.CMDialogKey(var Message : TCMDialogKey);
begin
  If Message.CharCode=VK_ESCAPE then Close;
end;

procedure TF_AdvGridInfCol.CalcFormSize;
var mTitleWidth, mLnWidth, mLnMax, mLnCnt:longint;
begin
  mLnMax := 50;
  mTitleWidth := GetTextWidth(L_Title.Caption,L_Title.Font,Self)+30+B_Close.Width;
  mLnWidth := GetTextWidth(L_Ln1.Caption,L_Ln1.Font,Self);
  If mLnMax<mLnWidth then mLnMax := mLnWidth;
  mLnWidth := GetTextWidth(L_Ln2.Caption,L_Ln2.Font,Self);
  If mLnMax<mLnWidth then mLnMax := mLnWidth;
  mLnWidth := GetTextWidth(L_Ln3.Caption,L_Ln3.Font,Self);
  If mLnMax<mLnWidth then mLnMax := mLnWidth;
  mLnWidth := GetTextWidth(L_Ln4.Caption,L_Ln4.Font,Self);
  If mLnMax<mLnWidth then mLnMax := mLnWidth;
  mLnWidth := GetTextWidth(L_Ln5.Caption,L_Ln5.Font,Self);
  If mLnMax<mLnWidth then mLnMax := mLnWidth;
  mLnWidth := GetTextWidth(L_Ln6.Caption,L_Ln6.Font,Self);
  If mLnMax<mLnWidth then mLnMax := mLnWidth;
  mLnWidth := GetTextWidth(L_Ln7.Caption,L_Ln7.Font,Self);
  If mLnMax<mLnWidth then mLnMax := mLnWidth;
  mLnWidth := GetTextWidth(L_Ln8.Caption,L_Ln8.Font,Self);
  If mLnMax<mLnWidth then mLnMax := mLnWidth;
  mLnWidth := GetTextWidth(L_Ln9.Caption,L_Ln9.Font,Self);
  If mLnMax<mLnWidth then mLnMax := mLnWidth;
  mLnWidth := GetTextWidth(L_Ln10.Caption,L_Ln10.Font,Self);
  If mLnMax<mLnWidth then mLnMax := mLnWidth;
  mLnMax := mLnMax+40;
  If mLnMax<mTitleWidth then mLnMax := mTitleWidth;
  Width := mLnMax;
  L_Ln1.Width := Width-40;
  L_Ln2.Width := Width-40;
  L_Ln3.Width := Width-40;
  L_Ln4.Width := Width-40;
  L_Ln5.Width := Width-40;
  L_Ln6.Width := Width-40;
  L_Ln7.Width := Width-40;
  L_Ln8.Width := Width-40;
  L_Ln9.Width := Width-40;
  L_Ln10.Width := Width-40;
  mLnCnt := 0;
  If L_Ln10.Visible then mLnCnt := 10;
  If L_Ln9.Visible and (mLnCnt=0) then mLnCnt := 9;
  If L_Ln8.Visible and (mLnCnt=0) then mLnCnt := 8;
  If L_Ln7.Visible and (mLnCnt=0) then mLnCnt := 7;
  If L_Ln6.Visible and (mLnCnt=0) then mLnCnt := 6;
  If L_Ln5.Visible and (mLnCnt=0) then mLnCnt := 5;
  If L_Ln4.Visible and (mLnCnt=0) then mLnCnt := 4;
  If L_Ln3.Visible and (mLnCnt=0) then mLnCnt := 3;
  If L_Ln2.Visible and (mLnCnt=0) then mLnCnt := 2;
  If L_Ln1.Visible and (mLnCnt=0) then mLnCnt := 1;
  Height := (mLnCnt-1)*(L_Ln1.Height+2)+L_Ln1.Height+35+20;
end;

procedure TF_AdvGridInfCol.Execute (pDGDFile,pColorGrp:string);
var mIni:TIniFile; mType:byte;
begin
  If Copy (pColorGrp,1,1)='U'
    then mIni := TIniFile.Create(pDGDFile+cUserType)
    else mIni := TIniFile.Create(pDGDFile+cDefType);
  If mIni.SectionExists('ColorGrp_'+pColorGrp) then begin
    L_Title.Caption := mIni.ReadString('ColorGrp_'+pColorGrp,'Name','');
    L_Ln1.Font.Color := mIni.ReadInteger('ColorGrp_'+pColorGrp,'Color1',clBlack);
    L_Ln2.Font.Color := mIni.ReadInteger('ColorGrp_'+pColorGrp,'Color2',clBlack);
    L_Ln3.Font.Color := mIni.ReadInteger('ColorGrp_'+pColorGrp,'Color3',clBlack);
    L_Ln4.Font.Color := mIni.ReadInteger('ColorGrp_'+pColorGrp,'Color4',clBlack);
    L_Ln5.Font.Color := mIni.ReadInteger('ColorGrp_'+pColorGrp,'Color5',clBlack);
    L_Ln6.Font.Color := mIni.ReadInteger('ColorGrp_'+pColorGrp,'Color6',clBlack);
    L_Ln7.Font.Color := mIni.ReadInteger('ColorGrp_'+pColorGrp,'Color7',clBlack);
    L_Ln8.Font.Color := mIni.ReadInteger('ColorGrp_'+pColorGrp,'Color8',clBlack);
    L_Ln9.Font.Color := mIni.ReadInteger('ColorGrp_'+pColorGrp,'Color9',clBlack);
    L_Ln10.Font.Color := mIni.ReadInteger('ColorGrp_'+pColorGrp,'Color10',clBlack);
    mType := mIni.ReadInteger('ColorGrp_'+pColorGrp,'Type',0);
    FreeAndNil (mIni);
    mIni := TIniFile.Create(pDGDFile+cDefType);
    If mType>0 then begin
      L_Ln1.Caption := mIni.ReadString('ColorInfo_'+StrInt (mType,0),'Info1','');
      L_Ln2.Caption := mIni.ReadString('ColorInfo_'+StrInt (mType,0),'Info2','');
      L_Ln3.Caption := mIni.ReadString('ColorInfo_'+StrInt (mType,0),'Info3','');
      L_Ln4.Caption := mIni.ReadString('ColorInfo_'+StrInt (mType,0),'Info4','');
      L_Ln5.Caption := mIni.ReadString('ColorInfo_'+StrInt (mType,0),'Info5','');
      L_Ln6.Caption := mIni.ReadString('ColorInfo_'+StrInt (mType,0),'Info6','');
      L_Ln7.Caption := mIni.ReadString('ColorInfo_'+StrInt (mType,0),'Info7','');
      L_Ln8.Caption := mIni.ReadString('ColorInfo_'+StrInt (mType,0),'Info8','');
      L_Ln9.Caption := mIni.ReadString('ColorInfo_'+StrInt (mType,0),'Info9','');
      L_Ln10.Caption := mIni.ReadString('ColorInfo_'+StrInt (mType,0),'Info10','');
    end;
    L_Ln1.Visible := L_Ln1.Caption<>'';
    L_Ln2.Visible := L_Ln2.Caption<>'';
    L_Ln3.Visible := L_Ln3.Caption<>'';
    L_Ln4.Visible := L_Ln4.Caption<>'';
    L_Ln5.Visible := L_Ln5.Caption<>'';
    L_Ln6.Visible := L_Ln6.Caption<>'';
    L_Ln7.Visible := L_Ln7.Caption<>'';
    L_Ln8.Visible := L_Ln8.Caption<>'';
    L_Ln9.Visible := L_Ln9.Caption<>'';
    L_Ln10.Visible := L_Ln10.Caption<>'';
  end;
  FreeAndNil (mIni);
  CalcFormSize;
  ShowModal;
end;

procedure TF_AdvGridInfCol.B_CloseClick(Sender: TObject);
begin
  Close;
end;

end.
