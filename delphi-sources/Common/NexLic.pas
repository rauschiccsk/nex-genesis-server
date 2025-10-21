unit NexLic;

interface

uses
     LoginUtils, BasUtilsTCP, ExecWait,
     EncodeIni, IcTypes, IcVariab, IcConv, IcTools, IcFiles, NexPath,
     SysUtils, Windows, Classes;

type
  TWSData = record
    WSNum:longint;
    PCName:Str30;
    WSName:Str30;
  end;

  TWSList = record
    WSNum:longint;
    PCName:Str30;
    WSName:Str30;
  end;

  TWSFile = record
    ProcID  :Str10;
    UserName:Str20;
    Status  :Str5;
    RDate   :Str10;
    RTime   :Str12;
    EDate   :Str10;
    ETime   :Str12;
  end;

  TNEXLic = record
    Active   :boolean;
    SerNum   :string;
    LicKey   :string;
    UserQnt  :longint;
    CasQnt   :longint;
    TimeLimit:TDateTime;
    UpdLimit :TDateTime;
    RegDate  :TDateTime;
    RegName  :string;
    RegAddr  :string;
    RegCtn   :string;
    RegZIP   :string;
    RegStn   :string;
    INO      :string;
    TIN      :string;
    VIN      :string;
    WpaName  :string;
    WpaAddr  :string;
    WpaCtn   :string;
    WpaZIP   :string;
    WpaStn   :string;
    ModLst   :string;
  end;

  TExeData = record
    FileDate: TDateTime;
    FileSize: longint;
  end;

  procedure ReadLic;
  procedure ClearLic;

  function  GetWSNum (pPCName:string):longint;
            //Vráti poradové èíslo pracovnej stanice.

  function  ReadComputerName:string;
            //Vráti názov poèítaèa a meno prihláseného užívate¾a.

  procedure OpenWS;
            //Otvorí súbor na sledovanie spustených pracovných staníc
  procedure CloseWS;
            //Uzatvorí súbor na sledovanie spustených pracovných staníc.
            //Ak sa dá, zruší aj ten súbor.

  function  GetWSQnt:longint;
            //Vráti poèet prihlásených pracovných staníc
  procedure FillExeData;
            //Nastavý údaje spusteného Exe súboru do premennej gExeData

  procedure NEXMsgVerify;
  function  NEXTermVerify:boolean;
  procedure ShowExtNEXMsg(pTimeSec:longint;pHead,pText:string);
  function  GetNSMPath:string;

  var
     gNEXLic:TNEXLic;
     gExeData:TExeData;

implementation

  var
    uWSF:file of TWSFile;
    uWSD:TWSFile;
    uWSPos:longint;
    uWSFileName:string;
    uNEXMsgFileAge:TDateTime;
    uNEXTermFileAge:TDateTime;

procedure ReadLic;
var mIni:TEncodeIniFile; mSLst:TStringList; mS:string; I:longint;
begin
  If gPath<>nil then begin
    If FileExists(gPath.SysPath+'NEX.LIC') then begin
      mIni:=TEncodeIniFile.Create(gPath.SysPath+'NEX.LIC',FALSE);
      mIni.Encode:=TRUE;
      gNEXLic.Active:=mIni.ReadBool('ACT','Active',FALSE);
      gNEXLic.SerNum:=mIni.ReadString('ACT','SerNum','');
      gNEXLic.LicKey:=mIni.ReadString('ACT','LicKey','');
      gNEXLic.UserQnt:=mIni.ReadInteger('ACT','UserQnt',0);
      gNEXLic.CasQnt:=mIni.ReadInteger('ACT','CasQnt',0);
      gNEXLic.TimeLimit:=mIni.ReadInteger('ACT','TimeLimit',0);
      gNEXLic.UpdLimit:=mIni.ReadInteger('ACT','UpdLimit',0);
      gNEXLic.RegDate:=mIni.ReadInteger('ACT','RegDate',0);

      gNEXLic.RegName:=mIni.ReadString('ACT','RegName','');
      gNEXLic.RegAddr:=mIni.ReadString('ACT','RegAddr','');
      gNEXLic.RegCtn:=mIni.ReadString('ACT','RegCtn','');
      gNEXLic.RegZIP:=mIni.ReadString('ACT','RegZIP','');
      gNEXLic.RegStn:=mIni.ReadString('ACT','RegStn','');
      gNEXLic.INO:=mIni.ReadString('ACT','INO','');
      gNEXLic.TIN:=mIni.ReadString('ACT','TIN','');
      gNEXLic.VIN:=mIni.ReadString('ACT','VIN','');

      gNEXLic.WpaName:=mIni.ReadString('ACT','WpaName','');
      gNEXLic.WpaAddr:=mIni.ReadString('ACT','WpaAddr','');
      gNEXLic.WpaCtn:=mIni.ReadString('ACT','WpaCtn','');
      gNEXLic.WpaZIP:=mIni.ReadString('ACT','WpaZIP','');
      gNEXLic.WpaStn:=mIni.ReadString('ACT','WpaStn','');
      gNEXLic.ModLst:='';
      mSLst:=TStringList.Create;
      mIni.ReadSection('ACT',mSLst);
      If mSLst.Count>0 then begin
        gNEXLic.ModLst:=';';
        For I:=0 to mSLst.Count-1 do begin
          mS:=mSLst.Strings[I];
          If Copy(mS,1,2)='M_' then begin
            Delete(mS,1,2);
            gNEXLic.ModLst:=gNEXLic.ModLst+mS+';';
          end;
        end;
      end;
      FreeAndNil(mSLst);
      FreeAndNil(mIni);
    end;
  end;
end;

procedure ClearLic;
begin
  gNEXLic.Active:=FALSE;
  gNEXLic.SerNum:='';
  gNEXLic.LicKey:='';
  gNEXLic.UserQnt:=0;
  gNEXLic.CasQnt:=0;
  gNEXLic.TimeLimit:=0;
  gNEXLic.UpdLimit:=0;
  gNEXLic.RegDate:=0;
  gNEXLic.RegName:='';
  gNEXLic.RegAddr:='';
  gNEXLic.RegCtn:='';
  gNEXLic.RegZIP:='';
  gNEXLic.RegStn:='';
  gNEXLic.INO:='';
  gNEXLic.TIN:='';
  gNEXLic.VIN:='';
  gNEXLic.WpaName:='';
  gNEXLic.WpaAddr:='';
  gNEXLic.WpaCtn:='';
  gNEXLic.WpaZIP:='';
  gNEXLic.WpaStn:='';
  gNEXLic.ModLst:='';
end;

function GetWSNum (pPCName:string):longint;
var
  mT: file of TWSList;
  mD: TWSList;
  mFind:boolean;
begin
  Result := 0;
  AssignFile (mT,gPath.SysPath+'WSDATA.LST');
  {$I-}
  If not FileExists (gPath.SysPath+'WSDATA.LST') then Rewrite (mT);
  FileMode := fmOpenRead;
  Reset (mT);
  mFind := FALSE;
  mD.WSNum := 0;
  mD.PCName := '';
  While not EOF (mT) and not mFind do begin
    Read (mT, mD);
    mFind := UpString (mD.PCName)=UpString (pPCName);
  end;
  If not mFind then begin
    FileMode := fmOpenWrite;
    Reset (mT);
    Seek (mT, FileSize (mT));
    mD.WSNum := mD.WSNum+1;
    mD.PCName := pPCName;
    mD.WSName := '';
    Write (mT,mD);
  end;
  Result := mD.WSNum;
  {$I+}
  CloseFile (mT);
end;

function  ReadComputerName:string;
var mSize:dword; mBuff: array[0..255] of char; mS:string;
begin
  Result := '';
  mSize := 256;
  mS := 'nopc';
  If GetComputerName(mBuff, mSize) then mS := mBuff;
  Result := ReplaceStr (ReplaceStr (mS, '~', '-'), '_', '-');

  mSize := 256;
  mS := 'noname';
  If GetUserName(mBuff, mSize) then mS := mBuff;
  Result := Result+'~'+ReplaceStr (ReplaceStr (mS, '~', '-'), '_', '-');
end;

procedure OpenWS;
var mWSNum:longint; mIORes:longint;
begin
  If not cGldService then begin
    mWSNum := GetWSNum (ReadComputerName);
    uWSFileName:=gPath.SysPath+'WS.'+StrIntZero (mWSNum,3);
    AssignFile (uWSF,uWSFileName);
    {$I-}
    If not FileExists (uWSFileName) then Rewrite (uWSF);
    FileMode := fmOpenWrite;
    Reset (uWSF);

    FillChar(uWSD,SizeOf(uWSD),#0);
    uWSD.UserName:=gvSys.LoginName;
    uWSD.ProcID:=StrInt(GetCurrentProcessId,0);
    uWSD.Status:='RUN';
    uWSD.RDate:=FormatDateTime('dd.mm.yyyy',Date);
    uWSD.RTime:=FormatDateTime('hh:nn:ss,zzz',Time);
    uWSPos:=FileSize(uWSF);
    Seek(uWSF,uWSPos);
    Write(uWSF, uWSD); mIORes:=IOResult;
    {$I+}
  end;
end;

procedure CloseWS;
var mIORes:longint;
begin
  If not cGldService then begin
    {$I-}
    Seek(uWSF,uWSPos);
    uWSD.Status:='END';
    uWSD.EDate:=FormatDateTime('dd.mm.yyyy',Date);
    uWSD.ETime:=FormatDateTime('hh:nn:ss,zzz',Time);
    Write(uWSF, uWSD); mIORes:=IOResult;
    {$I+}
    {$I-} CloseFile (uWSF); mIORes:=IOResult; {$I+}
    If FileExists (uWSFileName) then begin
      If not FileInUse(uWSFileName) then SysUtils.DeleteFile(uWSFileName);
    end;
  end;
end;

function  GetWSQnt:longint;
var mSR:TSearchRec;
begin
  Result := 0;
  If FindFirst (gPath.SysPath+'WS.???',faAnyFile,mSR)=0 then begin
    Repeat
      If FileExists (gPath.SysPath+mSR.Name) then begin
        If not FileInUse(gPath.SysPath+mSR.Name) then SysUtils.DeleteFile(gPath.SysPath+mSR.Name);
      end;
      If FileExists (gPath.SysPath+mSR.Name) then Result := Result+1;
    until FindNext (mSR)<>0;
  end;
  SysUtils.FindClose (mSR);
end;

procedure FillExeData;
begin
  gExeData.FileDate:=0;
  gExeData.FileSize:=0;
  If FileExists(ParamStr(0)) then begin
    try
      gExeData.FileDate:=FileDateToDateTime(FileAge(ParamStr(0)));
    except end;
    try
      gExeData.FileSize:=IcFiles.GetFileSize(string(ParamStr(0)));
    except end;
  end;
end;

procedure NEXMsgVerify;
var mT:TextFile; mIORes:longint; mS,mWS,mHead,mText:string; mShow,mWhiteList:boolean; mFileDate:TDateTime;
begin
  mFileDate:=0;
  If FileExists(gPath.SysPath+'NEXMSG.CMD') then begin
    mFileDate:=FileDateToDateTime(FileAge(gPath.SysPath+'NEXMSG.CMD'));
    If mFileDate<>uNEXMsgFileAge then begin
      AssignFile (mT,gPath.SysPath+'NEXMSG.CMD');
      {$I-}
      FileMode := fmOpenRead;
      Reset(mT); mIORes:=IOResult;
      ReadLn(mT,mS); mIORes:=IOResult;
      If mIORes=0 then begin
        mWhiteList:=(LineElement(mS,0,zRS)='W');
        mWS:=LineElement(mS,4,zRS);
        mHead:=LineElement(mS,5,zRS);
        mText:=DecodeB64(LineElement(mS,6,zRS),0);
        If mWhiteList
          then mShow:=Pos(zUS+GetNEXComputerName+zUS,mWS)=0
          else mShow:=Pos(zUS+GetNEXComputerName+zUS,mWS)>0;
        If mShow then ShowExtNEXMsg(300,mHead,mText);
      end;
      CloseFile(mT); mIORes:=0;
      {$I+}
    end;
  end;
  uNEXMsgFileAge:=mFileDate;
end;

function  NEXTermVerify:boolean;
var mT:TextFile; mIORes:longint; mS,mWS:string; mWhiteList:boolean; mFileDate:TDateTime;
begin
  Result:=FALSE;
  mFileDate:=0;
  If FileExists(gPath.SysPath+'NEXTERM.CMD') then begin
    mFileDate:=FileDateToDateTime(FileAge(gPath.SysPath+'NEXTERM.CMD'));
    If mFileDate<>uNEXTermFileAge then begin
      AssignFile (mT,gPath.SysPath+'NEXTERM.CMD');
      {$I-}
      FileMode := fmOpenRead;
      Reset(mT); mIORes:=IOResult;
      ReadLn(mT,mS); mIORes:=IOResult;
      If mIORes=0 then begin
        mWhiteList:=(LineElement(mS,0,zRS)='W');
        mWS:=LineElement(mS,4,zRS);
        If mWhiteList
          then Result:=Pos(zUS+GetNEXComputerName+zUS,mWS)=0
          else Result:=Pos(zUS+GetNEXComputerName+zUS,mWS)>0;
      end;
      CloseFile(mT); mIORes:=0;
      {$I+}
    end;
  end;
  uNEXTermFileAge:=mFileDate;
end;

procedure ShowExtNEXMsg(pTimeSec:longint;pHead,pText:string);
var mPath,mS:string;
begin
  mPath:=GetNSMPath;
  If mPath<>'' then begin
    If FileExists(mPath+'NEXMSG.EXE') then begin
      mS:=StrInt(pTimeSec,0)+zUS+pHead+zUS+pText;
      mS:=EncodeB64(mS,0);
      ExecApp(mPath+'NEXMSG.EXE',mS);
    end;
  end;
end;

function  GetNSMPath:string;
var mIni: TEncodeIniFile; mErr:longint; mOrgLstFile, mGrp:String;
begin
  Result:='';
  If gPath<>nil then begin
    mOrgLstFile:=gPath.SysPath+cOrgLstFile;
    mIni:=TEncodeIniFile.Create(mOrgLstFile, FALSE, FALSE, 30000, mErr);
    mIni.Encode:=cOrgLstEncode;
    If mErr=0 then begin
      mGrp:='NSM';
      If not mIni.ValueExists(mGrp, 'Path') then mIni.WriteString(mGrp, 'Path', gPath.NexPath+'NSM\');
      Result:=mIni.ReadString(mGrp, 'Path', '');
    end;
    FreeAndNil (mIni);
  end;
end;

begin
  uNEXMsgFileAge:=0;
  uNEXTermFileAge:=0;
end.
