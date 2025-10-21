unit NEXRVPh_;

interface

uses
  NEXRPh_,
  About_F,
  NexReg_, IcTools, IcConv, LangForm, NexPath,
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  ComCtrls, StdCtrls, Mask, ExtCtrls, CheckLst, Buttons, IcEditors,
  QuickRpt;

type
  TF_NEXRVPh = class(TLangForm)
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
    Label4: TLabel;
    Label5: TLabel;
    Label6: TLabel;
    E_FirmaName: TNameEdit;
    E_Address: TNameEdit;
    E_City: TNameEdit;
    E_ICO: TNameEdit;
    E_DIC: TNameEdit;
    E_ZIP: TNameEdit;
    Button1: TButton;
    procedure BB_OKClick(Sender: TObject);
    procedure ME_PrgSerNumKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure ME_PrgSerNumExit(Sender: TObject);
    procedure Button1Click(Sender: TObject);
  private
    oSNReadOnly:boolean;
    { Private declarations }
  public
    function  Execute (pPrgSerNum:string):boolean;
    { Public declarations }
  end;

var
  F_NEXRVPh: TF_NEXRVPh;

function ExecuteNEXRVPh (pPrgSerNum:string):boolean;

implementation

{$R *.DFM}

function ExecuteNEXRVPh (pPrgSerNum:string):boolean;
begin
  Application.CreateForm(TF_NEXRVPh, F_NEXRVPh);
  Result := F_NEXRVPh.Execute (pPrgSerNum);
  F_NEXRVPh.Free; F_NEXRVPh := nil;
end;

function  TF_NEXRVPh.Execute (pPrgSerNum:string):boolean;
begin
  oSNReadOnly := pPrgSerNum<>'';
  ME_PrgSerNum.Text := pPrgSerNum;
  ME_PrgSerNum.Enabled := not oSNReadOnly;
  If oSNReadOnly then ME_VerifyCode.Text := CrtVerCode(pPrgSerNum,gNEXDat.Version,gNEXDat.WSNum,gNEXDat.TimeLimit);
  ShowModal;
end;

procedure TF_NEXRVPh.BB_OKClick(Sender: TObject);
var mVersion,mWSQnt:word; mTimeLimit:TDate; mPrgList:string;
begin
  If RegCodeVerify (ME_PrgSerNum.Text,ME_VerifyCode.Text,ME_RegCode.Text) then begin
    GetDataInRegCode (ME_RegCode.Text,mVersion,mWSQnt,mTimeLimit,mPrgList);
    gNEXDat.SerNum := ME_PrgSerNum.Text;
    gNEXDat.Version := mVersion;
    gNEXDat.WSNum := mWSQnt;
    gNEXDat.Modules := mPrgList;
    gNEXDat.TimeLimit := mTimeLimit;
    gNEXDat.RootTime := GetDirCrtDate(gPath.NexPath);
    gNEXDat.FirmaName := E_FirmaName.Text;
    gNEXDat.Address := E_Address.Text;
    gNEXDat.City := E_City.Text;
    gNEXDat.ZIP := E_ZIP.Text;
    gNEXDat.ICO := E_ICO.Text;
    gNEXDat.DIC := E_DIC.Text;
    WriteToNEXDat (gPath.SysPath);
    NEXRegVerify;
    NEXAbout ('Registrátor');
    Close;
  end;
end;

procedure TF_NEXRVPh.ME_PrgSerNumKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
var mForm:TCustomForm;
begin
  If (Key = VK_RETURN) then begin
    mForm := GetParentForm (Self);
    If (Key = VK_RETURN) or (Key = VK_DOWN) then If mForm<>nil then SendMessage (mForm.Handle,WM_NEXTDLGCTL,0,0);
  end;
end;

procedure TF_NEXRVPh.ME_PrgSerNumExit(Sender: TObject);
begin
  If Length (ReplaceStr (ME_PrgSerNum.Text,' ',''))=11 then begin
    ME_VerifyCode.Text := CrtVerCode(ME_PrgSerNum.Text,gNEXDat.Version,gNEXDat.WSNum,gNEXDat.TimeLimit);
  end;
end;

procedure TF_NEXRVPh.Button1Click(Sender: TObject);
begin
  ExecuteNEXRPh (ME_PrgSerNum.Text,8,2,0,'11100000000000000000');
end;

end.
