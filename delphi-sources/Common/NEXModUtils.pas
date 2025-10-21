unit NexModUtils;

interface

uses
  MsgBox, UsrFnc, NexRight,
  DBTables, hDEBREG,
  BasUtilsTCP, BaseUtils, NEXApi, EncodeIni, LoginUtils, NexLic,
  hUSRLST,
  PQRep_, PQRepR_, Preview_,
  NexPath, NexText, NexInit, NexIni, NexGlob,
  BtrLst, BtrTable, Prp, Cnt, DefRgh, Bok, Afc, Key, Plc, TblRef, Txt,
  IcDate, IcConst, IcConv, TxtCut, IcFiles, IcText, IcVariab,
  ExtCtrls, Messages, Windows, ComCtrls, StdCtrls, Classes, Forms, Dialogs, SysUtils, DateUtils;

type
  TModParamData = record
    ModulTitle  :string;
    Modul       :string;
    UserName    :string;
    FullName    :string;
    RootPath    :string;
    Year        :string;
    PathYear    :string;
    OrgName     :string;
    MainPrivPath:string;
    SubPrivPath :string;
    MnuProcID   :longint;
    MnuAppHandle:longint;
  end;

  function  VerifyMod(var pMod:string; pModID:string):boolean;

  procedure ModFormActivate(pMainForm:TForm;pModTitle,pModInfo:TLabel;pInd:TProgressBar;pNexMnuTimer,pRunTimer:TTimer;pAppRestore:TNotifyEvent);
  procedure ModFormCreate;
  procedure ModFormClose;
  procedure ModRunTimer(pForm:TForm;pModResize:TNotifyEvent);
  function  ResizeTimer:boolean;
  procedure NexMnuTimer(pNexMenuTimer:TTimer);

  procedure ModFormResize(pResizeTimer:TTimer);
  procedure ModAppRestore;

  function  NexModLogin:boolean; //AutomatickÈ prihl·senie modulu a inicializ·cia z·kladn˝ch objektov. Prihlasovacie ˙daje s˙ odoslane z Nex menu cez parameter
  procedure NexModClose;  //UkonËenie z·kladn˝ch objektov

  procedure NexFileSizeVerify(pFileSize:longint);
            //Prekontroluje veækosù aplik·cie. Do parametra treba zadaù veækosù aplikaËnÈho s˙boru po kompil·ciÌ.
            //Ak aktu·lna veækos nesedÌ s veækosùou po kompil·ciÌ, systÈm vypÌöechybovÈ hl·senie.
            //V tom prÌpade je veæk· pravdepodobnosù vÌrusovej infekcie.
            //Ak sa zad· do parametra -1, po spustenÌ programu uloûÌ veækosù aplik·cie do clipboardu

  var
    gModParamData:TModParamData;

implementation

uses
    DM_PRNTMP,
    DM_DLSDAT, DM_CPDDAT, DM_STKDAT, DM_LDGDAT, DM_CABDAT, DM_STADAT,
    DM_SYSTEM, DM_PRODPL, DM_PRNDAT, DM_MNGDAT, DM_TIM, DM_TOM, bUSRLST;

  var
    uFormActivate:boolean;
    uModForm:TForm;
    uMainForm:TForm;
    uMainFormClosing:TDateTime;
    uModWindowState:TWindowState;

procedure SetTestMode;
var  mIni: TEncodeIniFile; mErr:longint; mOrgLst:TStringList; mCnt:longint; mS,mGrp,mYear:string;
begin
  mIni:=TEncodeIniFile.Create(ExtractFilePath(ParamStr(0))+cOrgLstFile, FALSE, FALSE, 30000, mErr);
  mIni.Encode:=cOrgLstEncode;
  If mErr=0 then begin
    mGrp:='PC_'+GetNEXComputerName;
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
        gModParamData.MainPrivPath:=mIni.ReadString(mGrp, 'PrivPath', 'C:\NEXTEMP\');
        gModParamData.SubPrivPath:=gModParamData.MainPrivPath;
        mGrp:=mOrgLst.Strings[0];
        If mIni.SectionExists(mGrp) then begin
          gModParamData.OrgName:=mIni.ReadString(mGrp, 'Name', '');
          gModParamData.PathYear:=LineElement(mIni.ReadString(mGrp, 'Years', ''),0,',');
          gModParamData.Year:=gModParamData.PathYear;
          If ValInt (gModParamData.Year)=0 then gModParamData.Year:=LineElement(StrDate(Date),2,'.');
          gModParamData.RootPath:=mIni.ReadString(mGrp, 'Path', '');
          If not DirectoryExists(gModParamData.RootPath) then begin
            If DirectoryExists(ExtractFileDrive(gModParamData.RootPath)) then begin
              MessageDlg('Adres·r informaËnÈho systÈmu NEX nie je dostupn˝!'+#13+gModParamData.RootPath, mtError, [mbOk], 0);
            end else begin
              MessageDlg('Disketov· jednotka  '+ExtractFileDrive(gModParamData.RootPath)+'  nie je dostupn·!', mtError, [mbOk], 0);
            end;
          end;
        end;
      end;
      FreeAndNil(mOrgLst);
    end;
  end;
  FreeAndNil (mIni);
end;

function ReadParam:boolean;
//T·to funkcia naËÌta prihlasovacie ˙daje z parametra programu, ktorÈ boli odoslanÈ z NEX menu
var mS:string; mErr:longint;
begin
  Result:=FALSE;
  mErr:=-1;
  gModParamData.ModulTitle:='';
  gModParamData.RootPath:='';
  gModParamData.Year:='';
  gModParamData.PathYear:='';
  gModParamData.OrgName:='';
  gModParamData.MainPrivPath:='';
  gModParamData.SubPrivPath:='';
  gModParamData.MnuProcID:=0;
  gModParamData.MnuAppHandle:=0;
  If ParamCount>0 then begin
    If ParamCount=2 then begin
      If (ParamStr(1)='MOD') or (ParamStr(1)='TST') then begin
        If (ParamStr(1)='MOD') then begin
          gModParamData.Modul:='';
          gModParamData.UserName:='';
          gModParamData.FullName:='';
          mS:=DecodeB64(ParamStr(2),65);
          If LineElement(mS,0,zRS)='MOD' then begin
            gModParamData.Modul:=LineElement(mS,1,zRS); //OznaËenie spustenÈho modulu
            gModParamData.ModulTitle:=LineElement(mS,2,zRS); //HlaviËka spustenÈho modulu
            gModParamData.UserName:=LineElement(mS,3,zRS); //Prihl·sen˝ uûÌvateæ
            gModParamData.FullName:=LineElement(mS,4,zRS); //CelÈm meno
            gModParamData.RootPath:=LineElement(mS,5,zRS); //Root adres·r systÈmu
            gModParamData.Year:=LineElement(mS,6,zRS); //Aktu·lny rok
            gModParamData.PathYear:=LineElement(mS,7,zRS); //Aktu·lny rok pre adres·r
            gModParamData.OrgName:=LineElement(mS,8,zRS); //N·zov prihl·senej firmy
            gModParamData.MainPrivPath:=LineElement(mS,9,zRS); //Hlavn˝ pomocn˝ adres·r
            gModParamData.SubPrivPath:=LineElement(mS,10,zRS); //Pomocn˝ podadres·r
            gModParamData.MnuProcID:=ValInt(LineElement(mS,11,zRS)); //ProcessID pre NexMnu
            gModParamData.MnuAppHandle:=ValInt(LineElement(mS,12,zRS)); //Application handle pre NexMnu
          end else mErr:=3; //V druhom parameteri po dekÛdovanÌ prv· poloûka musÌ byù MOD
        end else begin
          // TestovacÌ mÛd. NaËitaj˙ sa ˙daje z ORGLST.INI
          SetTestMode;
        end;
        If (gModParamData.Modul='') or (gModParamData.UserName='') or (gModParamData.RootPath='') or (gModParamData.Year='') then begin
          mErr:=4; //AspoÚ jeden hlavn˝ parameter je pr·zdn˝
        end else begin
          If DirectoryExists(ExtractFileDrive(gModParamData.RootPath)) then begin
            If DirectoryExists(gModParamData.RootPath) then begin
              Result:=TRUE;
            end else begin
              MessageDlg('KoreÚov˝ adres·r  '+gModParamData.RootPath+'  nie je dostupn˝!',mtError,[mbOk],0);
            end;
          end else begin
            MessageDlg('Disketov· jednotka  '+ExtractFileDrive(gModParamData.RootPath)+'  nie je dostupn·!',mtError,[mbOk],0);
          end;
        end;
      end else mErr:=2; //Prv˝ parameter musÌ byù MOD
    end else mErr:=1; //Nespr·vny poËet parametrov
  end else begin
    //Modul bol spusten˝ bez parametra
    MessageDlg('Tento program sa sp˙öùa len pomocou informaËnÈho systÈmu NEX!',mtError,[mbOk],0);
    Application.Terminate;
  end;
  If mErr>0 then begin
    MessageDlg('Nespr·vne spustenie modulu!'+#13+'KÛd chyby: '+StrInt(mErr,0),mtError,[mbOk],0);
  end;
end;

procedure NexDefInit;
// T·to funkcia inicializuje z·kladnÈ objekty a premennÈ
begin
  gPath:=TPaths.Create;
  gNT:=TNexText.Create;
  gBtr:=TBtrLst.Create;
  dmSYS:=TdmSYS.Create (Application);

  SetActYear (gModParamData.Year);
  gvSys.FirstActYearDate:=FirstActYearDate;
  gPath.NexPath:=gModParamData.RootPath;
  gPath.ActYear:=gModParamData.PathYear;
  gvSys.SysPath:=gPath.SysPath;
  gvSys.ActOrgNum:='1';
  gvSys.ActOrgName:=gModParamData.OrgName;
  FreeAndNil (gNT);
  gNT:=TNexText.Create;
end;

procedure CloseAllDatabase (pDataModule:TDataModule);
// T·to funkcia uzatvorÌ vöetky datab·zy zadanÈho modulu
var I: integer;
begin
  For I:=0 to pDataModule.ComponentCount-1 do begin
    // TBtrieveTable
    If (pDataModule.Components[I] is TBtrieveTable) then begin
      If (pDataModule.Components[I] as TBtrieveTable).Active
        then (pDataModule.Components[I] as TBtrieveTable).Close;
    end;
  end;
end;

procedure NexDefDone;
// T·to funkcia ukonËÌ z·kladnÈ objekty
begin
  If dmSYS<>nil then begin CloseAllDatabase (dmSYS); FreeAndNil (dmSYS); end;
  FreeAndNil (gBtr);
  FreeAndNil (gPath);
  FreeAndNil (gNT);
end;

function LoginVerify:boolean;
// T·to funkcia naËÌta a nastavÌ prihlasovacie ˙dajÈ zadanÈho uûÌvateæa
begin
  Result:=FALSE;
  If DirectoryExists(gvSys.SysPath) then begin
    dmSYS.btUSRLST.Open;
    try
      dmSYS.btUSRLST.IndexName:='LoginName';
      If dmSYS.btUSRLST.FindKey([UpString(gModParamData.UserName)]) then begin
        Result:=TRUE;
      end;
      If Result then begin
        cUserName:=gModParamData.UserName;
        cMainPrivPath:=gModParamData.MainPrivPath;
        cSubPrivPath:=gModParamData.SubPrivPath;
        gPath.MainPrivPath:=gModParamData.MainPrivPath;
        gPath.SubPrivPath:=gModParamData.SubPrivPath;

        Session.NetFileDir:=gModParamData.SubPrivPath;
//        Session.PrivateDir:=gModParamData.SubPrivPath;

        SetLoginNameGroup (gModParamData.UserName);
        SetLoginName (dmSYS.btUSRLST.FieldByName ('LoginName').AsString);
        SetUserName (gModParamData.FullName);
        gvSys.DlrCode:=dmSYS.btUSRLST.FieldByName ('DlrCode').AsInteger;
        gvSys.UsrNum:=dmSYS.btUSRLST.FieldByName ('UsrNum').AsInteger;
        SetUsrLev (dmSYS.btUSRLST.FieldByName ('UsrLev').AsInteger);
      end;
    finally
      dmSYS.btUSRLST.Close;
    end;
  end;
end;

procedure NexMainInit;
// T·to funckia inicializuje vöetky objekty potrebÈ pre pouûÌvanie modulu
var mActOrg:byte; mCut:TTxtCut; mhUSRLST:TusrlstHnd;
begin
  RuningOn;
  gReg:=TReg.Create;
  gPrp:=TPrp.Create;
  gCnt:=TCnt.Create;
  // Nove databaze
  dmSTK:=TdmSTK.Create (Application);
  dmDLS:=TdmDLS.Create (Application);
  dmCAB:=TdmCAB.Create (Application);
  dmPDP:=TdmPDP.Create (Application);
  dmCPD:=TdmCPD.Create (Application);
  dmLDG:=TdmLDG.Create (Application);
  dmMNG:=TdmMNG.Create (Application);
  dmPRN:=TdmPRN.Create (Application);
  dmSTA:=TdmSTA.Create (Application);
  dmTIM:=TdmTIM.Create (Application);
  dmTOM:=TdmTOM.Create (Application);
  dmSYS.btUSRLST.Open;
  dmSYS.btBKUSRG.Open;
  If FileExistsI (gPath.DefPath+'MSGDIS.BDF') then dmSYS.btMSGDIS.Open;
  // Nacitame systemove udaje
  dmSYS.btSYSTEM.Open;
  If {pSndFiles} TRUE then dmSYS.btSNDDEF.Open;
  SysDateVerify; // Prekontroluje ci v systemovom adresare existuje SYSDAT.TXT ak ano naimportuje udaje do SYSTEM.BTR
  gvSys.WriNum:=dmSYS.btSYSTEM.FieldByName ('MyWriNum').AsInteger;
  gvSys.FirmaName:=dmSYS.btSYSTEM.FieldByName ('MyPaName').AsString;
  gvSys.BegGsCode:=dmSYS.btSYSTEM.FieldByName ('BegGsCode').AsInteger;
  gvSys.EndGsCode:=dmSYS.btSYSTEM.FieldByName ('EndGsCode').AsInteger;
  gvSys.BegPaCode:=dmSYS.btSYSTEM.FieldByName ('BegPaCode').AsInteger;
  gvSys.EndPaCode:=dmSYS.btSYSTEM.FieldByName ('EndPaCode').AsInteger;
  gIni:=TNexIni.Create (gPath.SysPath+'NEX.INI');
  gSet:=TNexIni.Create (gPath.SysPath+gvSys.LoginName+'.INI');
//  gFlt:=TFltIni.Create (gPath.SysPath+'FLT_SET.LST');
  gRgh:=TDefRgh.Create;
  gBok:=TBok.Create;
  gAfc:=TAfc.Create;
  gRgh.LoadRight(gvSys.LoginGroup);
  gvSys.DefVatPrc:=gIni.GetVatPrc(gIni.GetDefVatGrp);
  gvSys.AccStk:=gIni.AccStk;
  gvSys.AccWri:=gIni.AccWri;
  gvSys.AccCen:=gIni.AccCen;
  gvSys.MainWri:=gIni.MainWri;
  gvSys.ModToDsc:=gIni.ModToDsc;
  gvSys.EasLdg:=gIni.EasLdg;
  gvSys.SecMgc:=gIni.ServiceMg;
  gStatistic2:=gIni.ReadBool('SYSTEM', 'BtrStatistic',True);
  gBtrErrorLogfile:=gIni.ReadBool('SYSTEM', 'BtrErrorLog',False);
  gIni.WriteBool('SYSTEM', 'BtrStatistic',gStatistic2);
  gIni.WriteBool('SYSTEM', 'BtrErrorLog',gBtrErrorLogfile);
  If gStatistic2 and (ValDoub(dmSYS.btSYSTEM.GetVersion)<9) then gStatistic2:=FALSE;
  cFirmaName:=gvSys.FirmaName;
  cPrintDemo:=FALSE;
  SetDesignMode (gIni.GetDesignMode);
  LoadGlobalData;
  cRepPath:=gPath.RepPath;  // Pre report generator RZ 26.02.2008
  gKey:=TKey.Create;
  gvSys.MaximizeMode:= gKey.SysMaxScr;
  gvSys.StpRndFrc:= gKey.StpRndFrc;
  gvSys.StqRndFrc:= gKey.StqRndFrc;
  gvSys.StvRndFrc:= gKey.StvRndFrc;
  gvSys.InfDvz:=gKey.SysInfDvz;
  gvSys.AccDvz:=gKey.SysAccDvz;
  ctIntCoin:=gKey.SysAccDvz;     // Cele peniaze
  ctFractCoin:=gKey.SysAccDvz;   // Drobne peniaze
  // StatusLine
  ctSLYear:=gvSys.ActYear;
  ctSLFirmaNum:=gvSys.ActOrgNum;
  ctSLFirmaName:=gvSys.FirmaName;
  ctSLUserName:=gvSys.UserName;
  // Nastavime cisleny kÛd uzivaela
  If gvSys.UsrNum=0 then begin // Vygenerujeme novÈ uûÌvateæskÈ ËÌslo
    mhUSRLST:=TusrlstHnd.Create;  mhUSRLST.Open;
    If mhUSRLST.LocateLoginName(gvSys.LoginName) then begin
      mhUSRLST.Edit;
      mhUSRLST.UsrNum:=gKey.Sys.NextUsrNum;
      mhUSRLST.Post;
    end;
    gvSys.UsrNum:=mhUSRLST.UsrNum;
    FreeAndNil(mhUSRLST);
  end;

  gPlc:=TPlc.Create;
  gTblRef:=TTblRefF.Create(Application);
  gTxt:=nil;
end;

procedure NexMainDestroy;
// T·to funkcia ukonËi vöetky inicializovanÈ objekty pre modul
begin
  If dmDLS<>nil then begin CloseAllDatabase (dmDLS);  FreeAndNil (dmDLS); end;
  If dmSTK<>nil then begin CloseAllDatabase (dmSTK);  FreeAndNil (dmSTK); end;
  If dmCAB<>nil then begin CloseAllDatabase (dmCAB);  FreeAndNil (dmCAB); end;
  If dmPDP<>nil then begin CloseAllDatabase (dmPDP);  FreeAndNil (dmPDP); end;
  If dmCPD<>nil then begin CloseAllDatabase (dmCPD);  FreeAndNil (dmCPD); end;
  If dmLDG<>nil then begin CloseAllDatabase (dmLDG);  FreeAndNil (dmLDG); end;
  If dmMNG<>nil then begin CloseAllDatabase (dmMNG);  FreeAndNil (dmMNG); end;
  If dmPRN<>nil then begin CloseAllDatabase (dmPRN);  FreeAndNil (dmPRN); end;
  If dmSTA<>nil then begin CloseAllDatabase (dmSTA);  FreeAndNil (dmSTA); end;
  If dmTIM<>nil then begin CloseAllDatabase (dmTIM);  FreeAndNil (dmTIM); end;
  If dmTOM<>nil then begin CloseAllDatabase (dmTOM);  FreeAndNil (dmTOM); end;

//  FreeAndNil (gFlt);
  FreeAndNil (gSet);
  FreeAndNil (gIni);
  FreeAndNil (gAfc);
  FreeAndNil (gBok);
  FreeAndNil (gRgh);
  FreeAndNil (gReg);
  FreeAndNil (gPlc);
  FreeAndNil (gPrp);
  FreeAndNil (gCnt);
  If gTxt<>nil  then FreeAndNil(gTxt);
end;

function VerifyMod(var pMod:string; pModID:string):boolean;
begin
  Result:=(pMod=pModID);
  If Result then pMod:='';
end;

procedure ModFormActivate(pMainForm:TForm;pModTitle,pModInfo:TLabel;pInd:TProgressBar;pNexMnuTimer,pRunTimer:TTimer;pAppRestore:TNotifyEvent);
var mRun:boolean;
begin
  If uFormActivate then begin
    uMainForm:=pMainForm;
    uFormActivate:=FALSE;
    pModTitle.Caption:='';
    pModInfo.Caption:='';
    pInd.Position:=pInd.Position+1;
    mRun:=FALSE;
    If ReadParam then begin
      pModTitle.Caption:=gModParamData.ModulTitle;
      pModInfo.Caption:=gModParamData.Year+' - '+gModParamData.OrgName+' - '+gModParamData.FullName;
      uMainForm.Caption:=gModParamData.ModulTitle+' - '+gModParamData.Year+' - '+gModParamData.OrgName+' - '+gModParamData.FullName;
      Application.Title:=uMainForm.Caption;
      Application.ProcessMessages;
      pInd.Position:=pInd.Position+1;
      If NexModLogin then begin
        pNexMnuTimer.Enabled:=TRUE;
        pInd.Position:=pInd.Position+1;
        Application.CreateForm(TF_PQRep, F_PQRep);
        pInd.Position:=pInd.Position+1;
        Application.CreateForm(TF_Preview, F_Preview);
        pInd.Position:=pInd.Position+1;
        Application.CreateForm(TF_Rep, F_Rep);
        pInd.Position:=pInd.Position+1;
        gMsg:=TMsgBox.Create(Application);
        gUsr:=TUsrFnc.Create;  gUsr.LodUsrDat(gvSys.LoginName);
        ReadLic;
        FillExeData;
        Application.OnRestore:=pAppRestore;
        pRunTimer.Enabled:=TRUE;
        ghDEBREG:=TDebregHnd.Create;
        gNexRight:=TNexRight.Create;
        mRun:=TRUE;
      end;
    end;
    If not mRun then begin
      Application.ProcessMessages;
      PostMessage(uMainForm.Handle, WM_CLOSE, 0, 0);
    end;
  end;
end;

procedure ModFormCreate;
begin
  uFormActivate:=TRUE;
  uMainFormClosing:=0;
end;

procedure ModFormClose;
begin
  Application.ProcessMessages;
  FreeAndNil(ghDEBREG);
  FreeAndNil(gUsr);
  FreeAndNil(gMsg);
  gNexRight:=TNexRight.Create;
  NexModClose;
  ShowExtApp(gModParamData.MnuAppHandle);
end;

procedure ModRunTimer(pForm:TForm;pModResize:TNotifyEvent);
begin
  Application.ProcessMessages;
  uModForm:=pForm;
  uMainForm.Hide;
  If uModForm<>nil then begin
    uModForm.Caption:=uModForm.Caption;
    uModWindowState:=uModForm.WindowState;
    uModForm.OnResize:=pModResize;
    Application.BringToFront;
    uModForm.ShowModal;
    FreeAndNil(uModForm);
  end;
  uMainForm.Close;
end;

function ResizeTimer:boolean;
begin
  Result:=FALSE;
  If uModForm<>nil then begin
    If uModWindowState<>uModForm.WindowState then begin
      If uModForm.WindowState=wsMinimized then Application.Minimize;
    end else begin
      Result:=TRUE;
    end;
  end;
end;

procedure NexMnuTimer;
begin
  If gModParamData.MnuProcID>0 then begin
    If uMainFormClosing>0 then begin
      If uMainFormClosing<Now then TerminateExtApp(Application.Handle);
    end else begin
      If not ExistProcessID(gModParamData.MnuProcID) then begin
        uMainFormClosing:=IncSecond(Now,2);
        CloseExtApp(Application.Handle);
      end;
    end;
  end;
end;

procedure ModFormResize(pResizeTimer:TTimer);
begin
  If uModForm<>nil then begin
    If uModForm.WindowState<>wsMinimized then begin
      uModWindowState:=uModForm.WindowState;
      pResizeTimer.Enabled:=TRUE;
    end;
  end;
end;

procedure ModAppRestore;
begin
  If uModForm<>nil then uModForm.WindowState:=uModWindowState;
end;

function NexModLogin:boolean;
begin
  Result:=FALSE;
  NexDefInit;
  If LoginVerify then begin
    NexMainInit;
    Result:=TRUE;
  end;
end;

procedure NexModClose;
begin
  NexMainDestroy;
  NexDefDone;
end;

procedure NexFileSizeVerify(pFileSize:longint);
var mFileSize:longint; mSR:TSearchRec; mMsg:string; mEdit:TEdit; mForm:TForm;
begin
  mFileSize:=0;
  If FindFirst(ParamStr(0),faAnyFile,mSR)=0 then begin
    mFileSize:=mSR.Size;
    FindClose(mSR);
  end;
  If pFileSize=-1 then begin  //NaËÌta veækosù aplik·cie do clipboardu
    Application.CreateForm(TForm,mForm);
    mEdit:=TEdit.Create(mForm);
    mEdit.Parent:=mForm;
    mEdit.Text:=StrInt(mFileSize,0);
    mEdit.SelectAll;
    mEdit.CopyToClipboard;
    FreeAndNil(mEdit);
    mForm.Close;
  end else begin
    If mFileSize<>pFileSize then begin
      mMsg:='Veækosù aplikaËnÈho modulu sa zmenila !!!'+#13
            +'( '+ParamStr(0)+ ')'+#13
            +'PÙvodn· veækosù bola: '+StrIntSepar(pFileSize,0,TRUE)+#13
            +'Aktu·lna veækosù je: '+StrIntSepar(mFileSize,0,TRUE)+#13
            +'Prekontrolujte systÈm,'+#13
            +'nakoæko je veæk· pravdepodobnosù vÌrusovej infekcie !';
      ShowMessage(mMsg);
    end;
  end;
end;

end.
