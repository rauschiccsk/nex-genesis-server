unit NEXRPh_;

interface

uses
  NexReg_, IcTools, IcConv, LangForm,
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  ComCtrls, StdCtrls, Mask, ExtCtrls, CheckLst, Buttons;

type
  TF_NEXRPh = class(TLangForm)
    StatusBar1: TStatusBar;
    Bevel4: TBevel;
    Bevel5: TBevel;
    Bevel6: TBevel;
    Label11: TLabel;
    Label12: TLabel;
    Label13: TLabel;
    ME_PrgSerNum: TMaskEdit;
    ME_VerifyCode: TMaskEdit;
    ME_RegCode: TMaskEdit;
    BB_OK: TBitBtn;
    Panel1: TPanel;
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    E_Version: TEdit;
    E_WSQnt: TEdit;
    E_TimeLimit: TEdit;
    E_PrgList: TEdit;
    Label4: TLabel;
    procedure ME_VerifyCodeExit(Sender: TObject);
    procedure BB_OKClick(Sender: TObject);
    procedure ME_PrgSerNumKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure Button1Click(Sender: TObject);
  private
    oRegOK   :boolean;
    { Private declarations }
  public
    function  Execute (pPrgSerNum:string;pVersion,pWSQnt:word;pTimeLimit:TDate;pPrgList:string):boolean;
    { Public declarations }
  end;

var
  F_NEXRPh: TF_NEXRPh;

function ExecuteNEXRPh (pPrgSerNum:string;pVersion,pWSQnt:word;pTimeLimit:TDate;pPrgList:string):boolean;

implementation

{$R *.DFM}

function ExecuteNEXRPh (pPrgSerNum:string;pVersion,pWSQnt:word;pTimeLimit:TDate;pPrgList:string):boolean;
begin
  Application.CreateForm(TF_NEXRPh, F_NEXRPh);
  Result := F_NEXRPh.Execute (pPrgSerNum,pVersion,pWSQnt,pTimeLimit,pPrgList);
  F_NEXRPh.Free; F_NEXRPh := nil;
end;

function  TF_NEXRPh.Execute (pPrgSerNum:string;pVersion,pWSQnt:word;pTimeLimit:TDate;pPrgList:string):boolean;
begin
  E_Version.Text := StrInt (pVersion,0);
  E_WSQnt.Text := StrInt (pWSQnt,0);
  If pTimeLimit=0
    then E_TimeLimit.Text := ''
    else E_TimeLimit.Text := DateToStr (pTimeLimit);
  E_PrgList.Text := pPrgList;
  ME_PrgSerNum.Text := pPrgSerNum;
  oRegOK := FALSE;
  ShowModal;
  Result := oRegOK;
end;

procedure TF_NEXRPh.ME_VerifyCodeExit(Sender: TObject);
var mS:string;
    mVer,mWSQnt:word;mTimeLimit:TDate;
begin
  ME_RegCode.Text := '';
  mTimeLimit := 0;
  If E_TimeLimit.Text<>'' then mTimeLimit := StrToDate (E_TimeLimit.Text);
  mS := CrtRegCode (ME_PrgSerNum.Text,ME_VerifyCode.Text,E_PrgList.Text,ValInt (E_Version.Text),ValInt (E_WSQnt.Text),mTimeLimit);
  If mS<>'' then begin
    ME_RegCode.Text := mS;
  end else begin
    MessageDlg ('**--**  Nesprávny kontrolný kód', mtInformation, [mbOk], 0);
//    ME_VerifyCode.SetFocus;
  end;
end;

procedure TF_NEXRPh.BB_OKClick(Sender: TObject);
begin
  oRegOK := TRUE;
  Close;
end;

procedure TF_NEXRPh.ME_PrgSerNumKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
var mForm:TCustomForm;
begin
  If (Key = VK_RETURN) then begin
    mForm := GetParentForm (Self);
    If (Key = VK_RETURN) or (Key = VK_DOWN) then If mForm<>nil then SendMessage (mForm.Handle,WM_NEXTDLGCTL,0,0);
  end;
end;

procedure TF_NEXRPh.Button1Click(Sender: TObject);
begin
  ME_VerifyCode.Text := CrtVerCode (ME_PrgSerNum.Text,1,1,0);
end;

end.
