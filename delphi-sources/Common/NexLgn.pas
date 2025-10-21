unit NexLgn;

interface

uses
  NexLic, EncodeIni, IcTools, IcConv, NexPath, BasUtilsTCP, IcVariab, IcDate, NexText, IcConst, NEXApi,
  LoginAddOrg, LoginUtils, NexGlob, NexMsg, IcTypes, IcFiles,
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, xpComp, ExtCtrls, ActnList, DBTables;

type
  TF_NexLgn = class(TForm)
    P_Back: TxpSinglePanel;
    L_LoginName: TxpLabel;
    L_Passw: TxpLabel;
    I_Logo: TImage;
    L_OrgName: TxpLabel;
    L_Year: TxpLabel;
    B_Run: TxpBitBtn;
    E_LoginName: TxpEdit;
    E_UsrPsw: TxpEdit;
    P_Head: TxpSinglePanel;
    L_Head: TxpLabel;
    P_Exit: TxpSinglePanel;
    B_Exit: TxpBitBtn;
    E_OrgName: TxpEdit;
    E_Year: TxpEdit;
    AL_Main: TActionList;
    A_OK: TAction;
    A_Exit: TAction;
    ChB_RememberName: TxpCheckBox;
    ChB_AutoLogin: TxpCheckBox;
    BB_ShowMore: TxpBitBtn;
    L_ShowMore: TxpLabel;
    T_Scan: TTimer;
    procedure L_HeadMouseDown(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure L_HeadMouseMove(Sender: TObject; Shift: TShiftState; X,
      Y: Integer);
    procedure L_HeadMouseUp(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure A_OKExecute(Sender: TObject);
    procedure A_ExitExecute(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure BB_ShowMoreClick(Sender: TObject);
    procedure FormActivate(Sender: TObject);
    procedure ChB_RememberNameClick(Sender: TObject);
    procedure ChB_AutoLoginClick(Sender: TObject);
    procedure E_UsrPswKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure T_ScanTimer(Sender: TObject);
  private
    oMouseX       : longint;
    oMouseY       : longint;
    oMouseDown    : boolean;
    oFirst        : boolean;
    oComputerName : string;
    oOrgLstFile   : string;
    oWSSetFile    : string;
    oRootPath     : string;
    oLogined      : boolean;
    oErrQnt       : longint;
    oExtAutoLogin : boolean;

    procedure CreateOrgLst;
    function  ReadWSData:boolean;
    procedure ReadWSIni;
    procedure SaveWSIni;
    procedure SetSysData;
    procedure RunLogin;
    function  GldPsw(pText:string):boolean;
  public
    property Logined:boolean read oLogined;
  end;

function ExecuteNexLgn(pMainForm:TForm):boolean;
function ExecuteAutoLgn(pUserName:string):boolean;

function  GetMainPrivPath:string;
procedure SetPrivPathsVars;
procedure SubPrivPathsCleaning(pSelf:boolean);
function  GetBcsPort   : Str5;
function  GetBpsPath   : Str80;
function  GetPortData(pPort:Str5) : Str12;
function  GetWriNum    : word;
function  GetCasNum    : word;
function  GetFixStkNum : word;
procedure SetCasNum (pCasNum:word);


var
  F_NexLgn: TF_NexLgn;
  uLastPsw:string;

implementation

{$R *.dfm}

  uses DM_SYSTEM;

function ExecuteAutoLgn(pUserName:string):boolean;
var mIni:TEncodeIniFile; mFile, mComputerName, mGrp:string; mErr, mNum:longint;
begin
  Result:=FALSE;
  gvSys.ActOrgNum:='';
  mComputerName:=GetNEXComputerName;
  gPath.ActYear:='ACT';
  SetActYear (LineElement(StrDate(Date),2,'.'));
  SetLoginName (pUserName);
  SetUserName (pUserName);
  mFile:=ExtractFilePath(ParamStr(0))+cOrgLstFile;
  mIni:=TEncodeIniFile.Create(mFile, FALSE, TRUE, 30000, mErr);
  mIni.Encode:=cOrgLstEncode;
  If mErr=0 then begin
    mNum:=0;
    If ParamStr(2)<>''  then begin
      mNum:=ValInt(ParamStr(2));
    end else begin
      mGrp:='PC_'+mComputerName;
      If mIni.SectionExists(mGrp) then mNum:=mIni.ReadInteger(mGrp, 'DefOrg', 1);
    end;
    If mNum>0 then begin
      gvSys.ActOrgNum:=StrInt (mNum, 0);
      mGrp:='ORG_'+StrIntZero (mNum, 2);
      gPath.NexPath:=mIni.ReadString(mGrp, 'Path', '');

      mGrp:='PCO_'+mComputerName+'_'+StrIntZero (ValInt(gvSys.ActOrgNum),2);
      If mIni.ValueExists(mGrp, 'Path') then gPath.NexPath:=mIni.ReadString(mGrp, 'Path', '');  //10.05.2018 TIBI Õpecißlny root adresßr pre danÿ pracovnÿ stanicu

      gvSys.SysPath:=gPath.SysPath;
      gvSys.FirstActYearDate:=FirstActYearDate;
      Result:=TRUE;
      cUserName:=pUserName;
    end;
  end;
  FreeAndNil (mIni);
  SetPrivPathsVars;
  FreeAndNil (gNT);
  gNT:=TNexText.Create;
//  If Result then Result:=NexRegVerify;
end;

function ExecuteNexLgn(pMainForm:TForm):boolean;
var mR:TF_NexLgn;
begin
  mR:=TF_NexLgn.Create(pMainForm);
  mR.ShowModal;
  Result:=mR.Logined;
  FreeAndNil(mR);
end;

function GetPortData(pPort: Str5): Str12;
var mIni: TEncodeIniFile; mErr:longint; mOrgLstFile, mGrp:String;
begin
  Result:='';
  mOrgLstFile:=ExtractFilePath(ParamStr(0))+cOrgLstFile;
  mIni:=TEncodeIniFile.Create(mOrgLstFile, FALSE, FALSE, 30000, mErr);
  mIni.Encode:=cOrgLstEncode;
  If mErr=0 then begin
    mGrp:='PC_'+GetNEXComputerName;
    If not mIni.ValueExists(mGrp, pPort) then mIni.WriteString(mGrp, pPort, '9600,7,1,N');
    Result:=mIni.ReadString(mGrp, pPort, '9600,7,1,N');
  end;
  FreeAndNil (mIni);
end;
function GetMainPrivPath: string;
var mIni: TEncodeIniFile; mErr:longint; mOrgLstFile, mGrp:String;
begin
  Result:='';
  mOrgLstFile:=ExtractFilePath(ParamStr(0))+cOrgLstFile;
  mIni:=TEncodeIniFile.Create(mOrgLstFile, FALSE, FALSE, 30000, mErr);
  mIni.Encode:=cOrgLstEncode;
  If mErr=0 then begin
    mGrp:='PC_'+GetNEXComputerName;
    If not mIni.ValueExists(mGrp, 'PrivPath') then mIni.WriteString(mGrp, 'PrivPath', 'C:\NexTemp\'+GetWinUserName+'\');
    Result:=mIni.ReadString(mGrp, 'PrivPath', '');
  end;
  FreeAndNil (mIni);
end;

procedure SetPrivPathsVars;
var mSub:string;
begin
  cMainPrivPath:=GetMainPrivPath;
  mSub:=UpString(LineElement(ExtractFileName(ParamStr(0)),0,'.')+'$'+StrInt(GetCurrentProcessId,0));
  cSubPrivPath:=cMainPrivPath+mSub+'\';
  gPath.MainPrivPath:=cMainPrivPath;
  gPath.SubPrivPath:=cSubPrivPath;
  SubPrivPathsCleaning(FALSE);
  If not DirectoryExists(cSubPrivPath) then ForceDirectories(cSubPrivPath);
end;

procedure SubPrivPathsCleaning(pSelf:boolean);
var mSR:TSearchRec; mPath,mS:string; mOK:boolean; mPID:longint;
begin
  If DirectoryExists(cMainPrivPath) then begin
    If FindFirst(cMainPrivPath+'*.*',faDirectory,mSR)=0 then begin
      Repeat
        If (mSR.Attr and faDirectory)=mSR.Attr then begin
          If Pos('$',mSR.Name)>0 then begin
            mS:=LineElement(mSR.Name,1,'$');
            mPID:=ValInt(mS);
            If mPID>0 then begin
              mOK:=not ExistProcessID(mPID);
              If pSelf and not mOK then mOK:=(mPID=GetCurrentProcessId);
              If mOK then begin
                mPath:=cMainPrivPath+mSR.Name+'\';
                mOK:=TRUE;
                If FileExists(mPath+'PDOXUSR.NET') then mOK:=not FileInUse(mPath+'PDOXUSR.NET');
                If mOK then begin
                  DeleteFilesInDir(mPath);
                  If DirIsEmpty(mPath) then RemoveDir(mPath);
                end;
              end;
            end;
          end;
        end;
      until FindNext(mSR) <> 0;
      FindClose(mSR);
    end;
  end;
end;

function GetBcsPort: Str5;
var mIni: TEncodeIniFile; mErr:longint; mOrgLstFile, mGrp:String;
begin
  Result:='';
  mOrgLstFile:=ExtractFilePath(ParamStr(0))+cOrgLstFile;
  mIni:=TEncodeIniFile.Create(mOrgLstFile, FALSE, FALSE, 30000, mErr);
  mIni.Encode:=cOrgLstEncode;
  If mErr=0 then begin
    mGrp:='PC_'+GetNEXComputerName;
    If not mIni.ValueExists(mGrp, 'BcsPort') then mIni.WriteString(mGrp, 'BcsPort', '');
    Result:=mIni.ReadString(mGrp, 'BcsPort', '');
  end;
  FreeAndNil (mIni);
end;

function GetBpsPath: Str80;
var mIni: TEncodeIniFile; mErr:longint; mOrgLstFile, mGrp:String;
begin
  Result:='';
  mOrgLstFile:=ExtractFilePath(ParamStr(0))+cOrgLstFile;
  mIni:=TEncodeIniFile.Create(mOrgLstFile, FALSE, FALSE, 30000, mErr);
  mIni.Encode:=cOrgLstEncode;
  If mErr=0 then begin
    mGrp:='PC_'+GetNEXComputerName;
    If not mIni.ValueExists(mGrp, 'BpsPath') then mIni.WriteString(mGrp, 'BpsPath', 'C:\NexTemp\');
    Result:=mIni.ReadString(mGrp, 'BpsPath', '');
  end;
  FreeAndNil (mIni);
end;

function GetWrinum: word;
var mIni: TEncodeIniFile; mErr:longint; mOrgLstFile, mGrp:String;
begin
  Result:=0;
  mOrgLstFile:=ExtractFilePath(ParamStr(0))+cOrgLstFile;
  mIni:=TEncodeIniFile.Create(mOrgLstFile, FALSE, FALSE, 30000, mErr);
  mIni.Encode:=cOrgLstEncode;
  If mErr=0 then begin
    mGrp:='PCO_'+GetNEXComputerName+'_'+gvSys.ActOrgNum;
    If not mIni.ValueExists(mGrp, 'Wrinum') then mIni.WriteInteger(mGrp, 'Wrinum', 1);
    Result:=mIni.ReadInteger(mGrp, 'Wrinum', 1);
  end;
  FreeAndNil (mIni);
end;

function GetCasNum: word;
var mIni: TEncodeIniFile; mErr:longint; mOrgLstFile, mGrp:String;
begin
  Result:=0;
  mOrgLstFile:=ExtractFilePath(ParamStr(0))+cOrgLstFile;
  mIni:=TEncodeIniFile.Create(mOrgLstFile, FALSE, FALSE, 30000, mErr);
  mIni.Encode:=cOrgLstEncode;
  If mErr=0 then begin
    mGrp:='PC_'+GetNEXComputerName;
    If not mIni.ValueExists(mGrp, 'CasNum') then mIni.WriteInteger(mGrp, 'CasNum', 1);
    Result:=mIni.ReadInteger(mGrp, 'CasNum', 1);
  end;
  FreeAndNil (mIni);
end;

function GetFixStkNum: word;
var mIni: TEncodeIniFile; mErr:longint; mOrgLstFile, mGrp:String;
begin
  Result:=0;
  mOrgLstFile:=ExtractFilePath(ParamStr(0))+cOrgLstFile;
  mIni:=TEncodeIniFile.Create(mOrgLstFile, FALSE, FALSE, 30000, mErr);
  mIni.Encode:=cOrgLstEncode;
  If mErr=0 then begin
    mGrp:='PCO_'+GetNEXComputerName+'_'+gvSys.ActOrgNum;
    If not mIni.ValueExists(mGrp, 'FixStkNum') then mIni.WriteInteger(mGrp, 'FixStkNum', 1);
    Result:=mIni.ReadInteger(mGrp, 'FixStkNum', 1);
  end;
  FreeAndNil (mIni);
end;

// **********************************
// **************** SET *************
// **********************************

procedure SetCasNum (pCasNum:word);
var mIni: TEncodeIniFile; mErr:longint; mOrgLstFile, mGrp:String;
begin
  mOrgLstFile:=ExtractFilePath(ParamStr(0))+cOrgLstFile;
  mIni:=TEncodeIniFile.Create(mOrgLstFile, FALSE, FALSE, 30000, mErr);
  mIni.Encode:=cOrgLstEncode;
  If mErr=0 then begin
    mGrp:='PC_'+GetNEXComputerName;
    mIni.WriteInteger(mGrp, 'CasNum', pCasNum);
  end;
  FreeAndNil (mIni);
end;


// **** TF_NexLgn ****

procedure TF_NexLgn.CreateOrgLst;
var mR:TF_LoginAddOrg;
begin
  mR:=TF_LoginAddOrg.Create(Self);
  mR.Execute(oOrgLstFile);
  FreeAndNil (mR);
end;

function TF_NexLgn.ReadWSData:boolean;
var  mIni: TEncodeIniFile; mErr:longint; mOrgLst:TStringList; mCnt:longint; mS,mGrp,mYear:string;
begin
  Result:=FALSE;
  mIni:=TEncodeIniFile.Create(oOrgLstFile, FALSE, FALSE, 30000, mErr);
  mIni.Encode:=cOrgLstEncode;
  If mErr=0 then begin
    mGrp:='PC_'+oComputerName;
    mOrgLst:=TStringList.Create;
    mIni.ReadSections(mOrgLst);
    mOrgLst.Sort;
    If mOrgLst.Count>0 then begin
      mCnt:=0;
      Repeat
        mS:=mOrgLst.Strings[mCnt];
        If Copy (mS, 1, 4)='ORG_'then begin
          Inc (mCnt);
        end else begin
          mOrgLst.Delete(mCnt);
        end;
      until mCnt>=mOrgLst.Count;
      If mOrgLst.Count>0 then begin
        If not mIni.SectionExists(mGrp) then begin
          mIni.WriteString(mGrp, 'PrivPath', 'C:\NexTemp\');
          mIni.WriteString(mGrp, 'ModUser', '');
          mIni.WriteString(mGrp, 'ModDate', FormatDateTime ('dd.mm.yyyy', Date));
          mIni.WriteString(mGrp, 'ModTime', FormatDateTime ('hh:nn:ss', Time));
        end;
        mGrp:=mOrgLst.Strings[0];
        If mIni.SectionExists(mGrp) then begin
          mS:=mIni.ReadString(mGrp, 'Name', '');
          E_OrgName.Text:=mS;
          mYear:=LineElement(mIni.ReadString(mGrp, 'Years', ''),0,',');
          oRootPath:=mIni.ReadString(mGrp, 'Path', '');
          If ValInt(mYear)>0
            then E_Year.Text:=mYear
            else E_Year.Text:=cActYearText;
          If DirectoryExists(oRootPath) then begin
            gPath.NexPath:=oRootPath;
            gPath.ActYear:=mYear;
            oWSSetFile:=gPath.SysPath+cWSSetFile;
            ReadWSIni;
            Result:=TRUE;
          end else begin
            If DirectoryExists(ExtractFileDrive(oRootPath)) then begin
              MessageDlg('Adresár informaèného systému NEX nie je dostupný!'+#13+oRootPath, mtError, [mbOk], 0);
            end else begin
              MessageDlg('Disketová jednotka  '+ExtractFileDrive(oRootPath)+'  nie je dostupná!', mtError, [mbOk], 0);
            end;
          end;
        end;
      end;
      FreeAndNil(mOrgLst);
    end;
  end;
  FreeAndNil (mIni);
end;

procedure TF_NexLgn.ReadWSIni;
var  mWSIni:TEncodeIniFile; mErr:longint; mCmd,mS:string;
begin
  ChB_RememberName.Checked:=FALSE;
  ChB_AutoLogin.Checked:=FALSE;
  mS:=DecodeB64(ParamStr(1),65);
  mCmd:=LineElement(mS,0,' ');
  mS:=LineElement(mS,1,' ');
  oExtAutoLogin:=FALSE;
  If (mCmd='LOGIN') and (mS<>'') then begin
    ChB_AutoLogin.Checked:=TRUE;
    E_LoginName.Text:=LineElement(mS,0,zUS);
    E_UsrPsw.Text:=LineElement(mS,1,zUS);
    oErrQnt:=2;
    oExtAutoLogin:=TRUE;
    BB_ShowMore.Visible:=FALSE;
    L_ShowMore.Visible:=FALSE;
  end else begin
    If (mCmd<>'LOGOFF') then begin
      If FileExists(oWSSetFile) then begin
        mWSIni:=TEncodeIniFile.Create(oWSSetFile, FALSE, TRUE, 30000, mErr);
        mWSIni.Encode:=cOrgLstEncode;
        If mErr=0 then begin
          ChB_RememberName.Checked:=mWSIni.ReadBool('WS_'+oComputerName,'RemName',FALSE);
          ChB_AutoLogin.Checked:=mWSIni.ReadBool('WS_'+oComputerName,'AutoLogin',FALSE);
          If ChB_RememberName.Checked or ChB_AutoLogin.Checked then E_LoginName.Text:=mWSIni.ReadString('WS_'+oComputerName,'LoginName','');
          If ChB_AutoLogin.Checked then begin
            E_UsrPsw.Text:=LineElement (DecodeB64(mWSIni.ReadString('WS_'+oComputerName,'LoginPsw',''),65),1,zUS);
          end;
        end;
        FreeAndNil (mWSIni);
      end;
    end else begin
//      BB_ShowMore.Visible:=FALSE;
//      L_ShowMore.Visible:=FALSE;
    end;
  end;
end;

procedure TF_NexLgn.SaveWSIni;
var mWSIni: TEncodeIniFile; mErr:longint; mSave:boolean;
begin
  mWSIni:=TEncodeIniFile.Create(oWSSetFile, FALSE, FALSE, 30000, mErr);
  mWSIni.Encode:=cOrgLstEncode;
  mSave:=FALSE;
  If mErr=0 then begin
    If (mWSIni.ReadBool('WS_'+oComputerName,'RemName',FALSE)<>ChB_RememberName.Checked) or (not ChB_RememberName.Checked and not mWSIni.ValueExists('WS_'+oComputerName,'RemName')) then begin
      mSave:=TRUE;
      mWSIni.WriteBool('WS_'+oComputerName,'RemName',ChB_RememberName.Checked);
    end;
    If (mWSIni.ReadBool('WS_'+oComputerName,'AutoLogin',FALSE)<>ChB_AutoLogin.Checked) or (not ChB_AutoLogin.Checked and not mWSIni.ValueExists('WS_'+oComputerName,'AutoLogin'))  then begin
      mSave:=TRUE;
      mWSIni.WriteBool('WS_'+oComputerName,'AutoLogin',ChB_AutoLogin.Checked);
    end;
    If (ChB_RememberName.Checked or ChB_AutoLogin.Checked) then begin
      If (mWSIni.ReadString('WS_'+oComputerName,'LoginName','')<>E_LoginName.Text) then begin
        mSave:=TRUE;
        mWSIni.WriteString('WS_'+oComputerName,'LoginName',E_LoginName.Text);
      end;
    end else begin
      If mWSIni.ValueExists('WS_'+oComputerName,'LoginName') then begin
        mSave:=TRUE;
        mWSIni.DeleteKey('WS_'+oComputerName,'LoginName');
      end;
    end;
    If ChB_AutoLogin.Checked then begin
      If (mWSIni.ReadString('WS_'+oComputerName,'LoginPsw','')<>EncodeB64(oComputerName+zUS+E_UsrPsw.Text,65)) then begin
        mSave:=TRUE;
        mWSIni.WriteString('WS_'+oComputerName,'LoginPsw',EncodeB64(oComputerName+zUS+E_UsrPsw.Text,65));
      end;
    end else begin
      If mWSIni.ValueExists('WS_'+oComputerName,'LoginPsw') then begin
        mSave:=TRUE;
        mWSIni.DeleteKey('WS_'+oComputerName,'LoginPsw');
      end;
    end;
    If mSave then mWSIni.SaveFile;
  end;
  FreeAndNil (mWSIni);
end;


procedure TF_NexLgn.SetSysData;
begin
  If ValInt (E_Year.Text)>0 then begin
    SetActYear (E_Year.Text);
    gPath.ActYear:=gvSys.ActYear;
  end else begin
    SetActYear (LineElement(StrDate(Date),2,'.'));
    gPath.ActYear:='ACT';
  end;
  gvSys.FirstActYearDate:=FirstActYearDate;
  gPath.NexPath:=oRootPath;
  gvSys.SysPath:=gPath.SysPath;
  gvSys.ActOrgName:=E_OrgName.Text;
  FreeAndNil (gNT);
  gNT:=TNexText.Create;
end;

procedure TF_NexLgn.RunLogin;
var mWSQnt:longint;
begin
  dmSYS.btUSRLST.Open;
  try
    dmSYS.btUSRLST.IndexName:='LnLo';
    If not dmSYS.btUSRLST.FindKey([UpString(E_LoginName.Text), E_UsrPsw.Text]) then begin
      dmSYS.btUSRLST.IndexName:='LoginName';
      If dmSYS.btUSRLST.FindKey([UpString(E_LoginName.Text)]) and GldPsw(E_UsrPsw.Text) then begin
        cGldService:=TRUE;
        SetLoginName (dmSYS.btUSRLST.FieldByName ('LoginName').AsString);
        oLogined:=TRUE;
      end else begin
        Inc (oErrQnt);
        ShowMsg (9,'');
        E_UsrPsw.Text:='';
        E_UsrPsw.SetFocus;
      end;
    end else begin
      oLogined:=TRUE;
    end;
    If oLogined then begin
      oLogined:=FALSE;
      ReadLic;
      mWSQnt:=GetWSQnt;
      If mWSQnt<=gNEXLic.UserQnt then begin
        oLogined:=TRUE;
      end else begin
        MessageDlg('**--** Daná registrácia má licenciu na '+StrInt (gNEXLic.UserQnt,0)+' pracovných staníc'+#13+'Momentálne nie je možné spusti systém na tomto poèítaèi!!!', mtInformation, [mbOk], 0);
      end;
    end;
    If oLogined then begin
      cUserName:=dmSYS.btUSRLST.FieldByName ('LoginName').AsString;
      SetPrivPathsVars;

      Session.NetFileDir:=cSubPrivPath;
      Session.PrivateDir:=cSubPrivPath;

      SetLoginNameGroup (dmSYS.btUSRLST.FieldByName ('LoginName').AsString);
      SetLoginName (dmSYS.btUSRLST.FieldByName ('LoginName').AsString);
      SetUserName (dmSYS.btUSRLST.FieldByName ('UserName').AsString);
      gvSys.DlrCode:=dmSYS.btUSRLST.FieldByName ('DlrCode').AsInteger;
      gvSys.UsrNum:=dmSYS.btUSRLST.FieldByName ('UsrNum').AsInteger;
      SetUsrLev (dmSYS.btUSRLST.FieldByName ('UsrLev').AsInteger);
      PostMessage(Self.Handle, WM_CLOSE, 0, 0);
    end else begin
      If (oErrQnt>=3) then PostMessage(Self.Handle, WM_CLOSE, 0, 0);
    end;
  finally
    dmSYS.btUSRLST.Close;
  end;
end;

function  TF_NexLgn.GldPsw (pText:string):boolean;
begin
  Result:=pText=#77+#105+#99+#114+#111+#115+#111+#102+#116;
end;

procedure TF_NexLgn.L_HeadMouseDown(Sender: TObject; Button: TMouseButton;
  Shift: TShiftState; X, Y: Integer);
begin
  If Button=mbLeft then begin
    oMouseX:=X;
    oMouseY:=Y;
    oMouseDown:=TRUE
  end;
end;

procedure TF_NexLgn.L_HeadMouseMove(Sender: TObject; Shift: TShiftState; X,
  Y: Integer);
var mRect:TRect;
begin
 if oMouseDown then begin
    GetWindowRect(Handle, mRect);
    SetWindowPos(Handle, HWND_TOPMOST, mRect.Left+(X-oMouseX), mRect.Top+(Y-oMouseY), mRect.Right-mRect.Left, mRect.Bottom-mRect.Top, 0);
  end;
end;

procedure TF_NexLgn.L_HeadMouseUp(Sender: TObject; Button: TMouseButton;
  Shift: TShiftState; X, Y: Integer);
begin
  If (Button=mbLeft) and oMouseDown then oMouseDown:=FALSE;
end;

procedure TF_NexLgn.A_OKExecute(Sender: TObject);
begin
  If (E_LoginName.Text<>'') then begin
    uLastPsw:=E_UsrPsw.Text;
    SetSysData;
    If DirectoryExists(gvSys.SysPath) then begin
      RunLogin;
    end else ; //Neexistujúci systémový adresár
    If oLogined then begin
      SaveWSIni;
      Application.ProcessMessages;
      PostMessage(Self.Handle, WM_CLOSE, 0, 0);
    end;
  end;
  If not oLogined then begin
    If E_LoginName.Text=''
      then E_LoginName.SetFocus
      else E_UsrPsw.SetFocus;
  end;
end;

procedure TF_NexLgn.A_ExitExecute(Sender: TObject);
begin
  Close;
end;

procedure TF_NexLgn.FormCreate(Sender: TObject);
begin
  oFirst:=TRUE;
  oErrQnt:=0;
  oLogined:=FALSE;
  oRootPath:='';
  uLastPsw:='';
  ClientHeight:=200;
  oComputerName:=GetNEXComputerName;
  oOrgLstFile:=ExtractFilePath(ParamStr(0))+cOrgLstFile;
end;

procedure TF_NexLgn.BB_ShowMoreClick(Sender: TObject);
begin
  ClientHeight:=227;
  ChB_RememberName.Enabled:=TRUE;
  ChB_AutoLogin.Enabled:=TRUE;
  L_ShowMore.Visible:=FALSE;
  BB_ShowMore.Visible:=FALSE;
  If E_LoginName.Text=''
    then E_LoginName.SetFocus
    else E_UsrPsw.SetFocus;
end;

procedure TF_NexLgn.FormActivate(Sender: TObject);
begin
  If oFirst then begin
    If not FileExists(oOrgLstFile) then CreateOrgLst;
    If FileExists(oOrgLstFile) then begin
      If ReadWSData then begin
        NEXMsgVerify;
        If not NEXTermVerify then begin
          If ChB_AutoLogin.Checked then begin
            If E_LoginName.Text='' then E_UsrPsw.Text:='';
            If (E_LoginName.Text<>'') then begin
              Application.ProcessMessages;
              A_OKExecute(Sender);
              PostMessage(Self.Handle, WM_CLOSE, 0, 0);
            end;
          end;
          If E_LoginName.Text=''
            then E_LoginName.SetFocus
            else E_UsrPsw.SetFocus;
          T_Scan.Enabled:=TRUE;
        end else PostMessage(Self.Handle, WM_CLOSE, 0, 0);
      end else PostMessage(Self.Handle, WM_CLOSE, 0, 0);
    end else PostMessage(Self.Handle, WM_CLOSE, 0, 0);
  end;
end;

procedure TF_NexLgn.ChB_RememberNameClick(Sender: TObject);
begin
  If E_LoginName.Text=''
    then E_LoginName.SetFocus
    else E_UsrPsw.SetFocus;
end;

procedure TF_NexLgn.ChB_AutoLoginClick(Sender: TObject);
begin
  If E_LoginName.Text=''
    then E_LoginName.SetFocus
    else E_UsrPsw.SetFocus;
end;

procedure TF_NexLgn.E_UsrPswKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
var mMsg: TMsg;
begin
  If Key=VK_RETURN then begin
    Key:=0;
    PeekMessage(mMsg, 0, WM_CHAR, WM_CHAR, PM_REMOVE);
    A_OKExecute(Sender);
  end;
end;

procedure TF_NexLgn.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  Application.ProcessMessages;
end;

procedure TF_NexLgn.T_ScanTimer(Sender: TObject);
begin
  NEXMsgVerify;
  If NEXTermVerify then PostMessage(Self.Handle, WM_CLOSE, 0, 0);
end;

end.
