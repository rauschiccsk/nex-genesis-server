unit SpHand;

interface

  uses IniFiles,Forms,SysUtils,DateUtils,Types,Windows;

  const
    zNul    = Chr (0);
    zS      = Chr (1);
    zSTX    = Chr (2);
    zETX    = Chr (3);
    zEOT    = Chr (4);
    zENQ    = Chr (5);
    zACK    = Chr (6);
    zNAK    = Chr (21);
    zETB    = Chr (23);
    zESC    = Chr (27);
    zCR     = Chr (13);
    zLF     = Chr (10);
    zDLE    = Chr (16);
    zRVI    = Chr (16)+Chr (64);
    zSOH    = Chr (13);


  type
    TSPHand = class
    private
      oSPHand   : THandle;
      oErr      : DWord;
      oTF       : TextFile;
      oWriteDelay:word;

      oLogPath  : string;
      oWriteLog : boolean;

      procedure   SetLogVerify (pCOM:string);
      procedure   WriteToLog (pS:string);
    public
      constructor Create (pCOM,pBaud,pParity,pData,pStop,pLogPath:string);
      destructor  Destroy; override;

      procedure   SetTimeOut (pReadIntervalTimeOut,pReadTotalTimeOutMultiplier,pReadTotalTimeoutConstant,pWriteTotalTimeoutMultiplier,pWriteTotalTimeoutConstant:longint);
      procedure   SetFlag (pFlag:word);

      function    WriteToPort (pData:string):boolean;
      function    ReadInPortLen  (pLen:integer):string;
      function    ReadInPortToETX:string;  // FT4000
      function    ReadInPortEOT_ETB_ETX:string; // pre pokladòu UNIWELL

      function    GetModemState:cardinal;
      function    GetWaitCommEvent:cardinal;
      procedure   Delay (pMSec:longint);
      procedure   Impulz;
      property    WriteDelay: word read oWriteDelay write oWriteDelay;
    end;

implementation

constructor TSPHand.Create (pCOM,pBaud,pParity,pData,pStop,pLogPath:string);
var mDef:string; mDCB:TDCB;
begin
  oWriteDelay:=200;
  SetLastError (0);
  If Length (pCom)<=2 then pCom := 'COM'+pCom;
  oSPHand := CreateFile(PChar (pCom),GENERIC_READ or GENERIC_WRITE,0,nil,OPEN_EXISTING, 0, 0);
  oErr := GetLastError;
  mDef := pCOM+':'+pBaud+','+pParity+','+pData+','+pStop;
  GetCommState(oSPHand,mDCB);
  BuildCommDCB (PCHar (mDef),mDCB);
  SetCommState(oSPHand,mDCB);
  SetTimeOut (2000,500,500,500,500);
  Delay (200);
  SetLogVerify (pCOM);
  oLogPath:=pLogPath;
  WriteToLog('');
  WriteToLog('**********  '+DateTimeToStr (Now)+'  **********');
  WriteToLog(' Open: '+pCOM+':'+pBaud+','+pParity+','+pData+','+pStop);
end;

destructor  TSPHand.Destroy;
begin
  WriteToLog('Close');
  CloseHandle (oSPHand);
end;

procedure TSPHand.SetTimeOut (pReadIntervalTimeOut,pReadTotalTimeOutMultiplier,pReadTotalTimeoutConstant,pWriteTotalTimeoutMultiplier,pWriteTotalTimeoutConstant:longint);
var mTO :_COMMTIMEOUTS;
begin
  GetCommTimeouts(oSPHand,mTO);
  mTO.ReadIntervalTimeout := pReadIntervalTimeout;
  mTO.ReadTotalTimeoutMultiplier := pReadTotalTimeoutMultiplier;
  mTO.ReadTotalTimeoutConstant := pReadTotalTimeoutConstant;
  mTO.WriteTotalTimeoutMultiplier := pWriteTotalTimeoutMultiplier;
  mTO.WriteTotalTimeoutConstant := pWriteTotalTimeoutConstant;
  SetCommTimeouts(oSPHand,mTO);
end;

procedure   TSPHand.SetFlag (pFlag:word);
var mDCB:TDCB;
begin
  GetCommState(oSPHand,mDCB);
  mDCB.Flags := pFlag;
  SetCommState(oSPHand,mDCB);
end;

function    TSPHand.WriteToPort (pData:string):boolean;
var I:longint; mWN:cardinal;
  mPCh:array [1..9000] of char;
begin
  For I:=1 to 9000 do
    mPCh[I] := #0;
  For I:=1 to Length (pData) do
    mPCh[I] := pData[I];
  Result := WriteFile(oSPHand, mPCh, Length (pData),mWN,nil);
  Delay (oWriteDelay);
  WriteToLog('Write: '+pData);
  If not Result then oErr := GetLastError;
end;

function    TSPHand.ReadInPortLen  (pLen:integer):string;
var mStr :array [1..9000] of char;
    I:longint; mLp:LongWord;
begin
  Result := '';
  If ReadFile(oSPHand,mStr,pLen,mLP,nil) then begin
    If mLP>0 then begin
      For I:=1 to mLP do
        Result := Result+mStr[I];
    end;
    WriteToLog(' Read: '+Result);
  end else begin
    oErr := GetLastError;
  end;
end;

function  TSPHand.ReadInPortToETX:string;
var mCh: char; I:longint; mLp:LongWord; mETX:boolean;
begin
  Result := '';
  mETX := FALSE;
  Repeat
    If ReadFile(oSPHand, mCh, 1, mLP, nil) then begin
      If mLP=1 then begin
        If mCh=zETX
          then mETX := TRUE
          else Result := Result+mCh;
      end;
    end else begin
      oErr := GetLastError;
    end;
  until (mLP=0);// or mETX;
  WriteToLog(' Read: '+Result);
end;

function  TSPHand.ReadInPortEOT_ETB_ETX:string; // pre pokladòu UNIWELL
var mChar,mPrevChar :char; mEnd:boolean;
    I:longint; mLp:LongWord;
begin
  Result := '';
  mPrevChar := Chr (0);
  mEnd := FALSE;
  Repeat
    If ReadFile(oSPHand,mChar,1,mLP,nil) then begin
      If mLP>0 then begin
        Result := Result+mChar;
        If (mChar=zEOT) or (mPrevChar=zETB) or (mPrevChar=zETX) then mEnd := TRUE;
        mPrevChar := mChar;
      end;
    end else begin
      oErr := GetLastError;
    end;
  until mEnd or (mChar='');
  If Result<>'' then WriteToLog(' Read: '+Result);
end;

function  TSPHand.GetModemState:cardinal;
var mStatus:cardinal;
  mCnt:longint;mT:TextFile; mPrev:longint;
begin
  mCnt := 0;
  mPrev := 0;
  Repeat
    GetCommModemStatus(oSPHand,mStatus);
    If mStatus<>mPrev then begin
      AssignFile (mT,'PortStat');
      If FileExists ('PortStat')
        then Append (mT)
        else Rewrite (mT);
      WriteLn (mT,mStatus);
      CloseFile (mT);
      mCnt := 0;
      mPrev := mStatus;
    end else Inc (mCnt);
  until mCnt=20;
  Result := mStatus;
end;

function  TSPHand.GetWaitCommEvent:cardinal;
var mStatus:cardinal;
  mCnt:longint;mT:textFile; mPrev:longint;
begin
  mCnt := 0;
  mPrev := 0;
  Repeat
    WaitCommEvent(oSPHand,mStatus,nil);
    If mStatus<>mPrev then begin
      AssignFile (mT,'PortStat');
      If FileExists ('PortStat')
        then Append (mT)
        else Rewrite (mT);
      WriteLn (mT,mStatus);
      CloseFile (mT);
      mCnt := 0;
      mPrev := mStatus;
    end else Inc (mCnt);
  until mCnt=20;
  Result := mStatus;
end;

procedure   TSPHand.Delay (pMSec:longint);
var mTime:TDateTime;
begin
  mTime  :=  IncMilliSecond (Now,pMSec);
  Repeat
    Application.ProcessMessages;
  until Now>=mTime;
end;

procedure   TSPHand.Impulz;
var
  mB:boolean;
  mErr:DWord;
begin
  mErr := 0;
  mB := SetCommBreak (oSPHand);
  If not mB then mErr := GetLastError;
  Sleep (15);
  mB := ClearCommBreak (oSPHand);
  If not mB then mErr := GetLastError;
  Sleep (50);
//  modemová komunikácia Sleep (1000);
end;

procedure   TSPHand.SetLogVerify (pCOM:string);
var mIni:TIniFile;
begin
  oWriteLog := FALSE;
  If FileExists (ExtractFilePath (ParamStr(0))+'SPHAND.INI') then begin
    oLogPath := ExtractFilePath (ParamStr(0));
    mIni := TIniFile.Create(ExtractFilePath (ParamStr(0))+'SPHAND.INI');
    oWriteLog := mIni.ReadBool('SYSTEM',pCOM, FALSE);
    FreeAndNil (mIni);
  end;
end;

procedure   TSPHand.WriteToLog (pS:string);
var mIOErr:longint;
begin
  If oWriteLog then begin
    AssignFile (oTF, oLogPath+'SPHAND.LOG');
    {$I-}
    If FileExists(oLogPath+'SPHAND.LOG')
      then Append (oTF)
      else Rewrite (oTF);
    {$I+} mIOErr:= IOResult;
    {$I-} WriteLn (oTF,pS); {$I+} mIOErr:= IOResult;
    {$I-} CloseFile (oTF); {$I+} mIOErr:= IOResult;
  end;
end;

end.
