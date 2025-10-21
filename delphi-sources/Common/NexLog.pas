unit NexLog;
// *******************************************************************************************************************************
//                                                           LOG METHODS
// *******************************************************************************************************************************
//                                                   Copyright(c) 2024 ICC s.r.o.
//                                                       All rights reserved
//
// ------------------------------------------------------- UNIT DESCRIPTION ------------------------------------------------------
// ------------------------------------------------------ METODS DESCRIPTION -----------------------------------------------------
// ----------------------------------------------------- UNIT VERSION HISTPRY ----------------------------------------------------
// 1.0 - Initial version created by: Zoltan Rausch on 2024-04-26
// =======================================================================================================-=======================

interface

uses
  {Delphi} StdCtrls, SysUtils, SyncObjs,
  {NEX}    IcDate, IcFiles, NexPath;

const
  LOG_LEVEL_SYS = 0;
  LOG_LEVEL_ERR = 1;
  LOG_LEVEL_INF = 2;
  LOG_LEVEL_DAT = 4;

  procedure Log(pLogLevel:byte;pSender:TObject;pMethodName:String;pLogInfo:String);

  procedure LogSys(pSender:TObject;pMethodName:String;pLogInfo:String);
  procedure LogErr(pSender:TObject;pMethodName:String;pLogInfo:String);
  procedure LogInf(pSender:TObject;pMethodName:String;pLogInfo:String);
  procedure LogDat(pSender:TObject;pMethodName:String;pLogInfo:String);

var gLogFileName: string;
    gLogLineData: string;
    gLogAccess: TCriticalSection;

implementation

procedure Log(pLogLevel:byte;pSender:TObject;pMethodName:String;pLogInfo:String);
var mLogFileName,mSender,mLogLevel:String;  mLogFile:TextFile;
begin
  gLogAccess.Enter;
  try
    if gLogFileName = ''
      then mLogFileName := gPath.LogPath+ExtractOnlyFileName(ParamStr(0))+'_'+DateToFileName(now)+'.log'
      else mLogFileName := gPath.LogPath+ExtractOnlyFileName(gLogFileName)+'_'+DateToFileName(now)+'.log';
    AssignFile(mLogFile,mLogFileName);
    if FileExists(mLogFileName)
      then Append(mLogFile)
      else Rewrite(mLogFile);
    mSender := 'NIL';
    case pLogLevel of
      LOG_LEVEL_SYS: mLogLevel := '[SYS]';
      LOG_LEVEL_ERR: mLogLevel := '[ERR]';
      LOG_LEVEL_INF: mLogLevel := '[INF]';
      LOG_LEVEL_DAT: mLogLevel := '[DAT]';
               else  mLogLevel := '[---]';
    end;
    if Assigned(pSender) then mSender := pSender.ClassName;
    gLogLineData := FormatDateTime('yyyy-mm-dd hh:nn:ss.zzz',now)+';'+mLogLevel+';'+mSender+';'+pMethodName+';'+pLogInfo;
    try
      WriteLn(mLogFile,gLogLineData);
    finally
      CloseFile(mLogFile);
    end;
  finally
    gLogAccess.Release;
  end;
end;

procedure LogSys(pSender:TObject;pMethodName:String;pLogInfo:String);
begin
  Log(LOG_LEVEL_SYS,pSender,pMethodName,pLogInfo);
end;

procedure LogErr(pSender:TObject;pMethodName:String;pLogInfo:String);
begin
  Log(LOG_LEVEL_ERR,pSender,pMethodName,pLogInfo);
end;

procedure LogInf(pSender:TObject;pMethodName:String;pLogInfo:String);
begin
  Log(LOG_LEVEL_INF,pSender,pMethodName,pLogInfo);
end;

procedure LogDat(pSender:TObject;pMethodName:String;pLogInfo:String);
begin
  Log(LOG_LEVEL_DAT,pSender,pMethodName,pLogInfo);
end;

initialization
  gLogAccess := TCriticalSection.Create;

finalization
  FreeAndNil(gLogAccess);

end.

