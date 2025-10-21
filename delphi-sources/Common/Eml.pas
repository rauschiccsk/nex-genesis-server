unit Eml;
{$F+}

// *****************************************************************************
//                        POSIELANIE ELEKTRONICKEJ POŠTY
// *****************************************************************************

interface

uses
  hEml, hEmlReg, hDirCnt, Key,
  Btrtools,
  IcVariab, IcTypes, IcConst, IcConv, IcTools, IcFiles,
  NexGlob, NexPath, NexIni, NexMsg, NexError,
  IdSMTPBase, IdSMTP, IdBaseComponent, IdComponent, IdTCPConnection, IdAttachmentFile,
  IdAttachment, IdText, IdTCPClient, IdExplicitTLSClientServerBase,
  IdMessageClient, IdMessage, IdAntiFreezeBase, IdAntiFreeze,
  IdSASL, IdSASLUserPass, IdSASLLogin, IdUserPassProvider, IdSSLOpenSSL,
  Mapi, SysUtils, Classes, Forms, Dialogs;

type
  TEml = class
    constructor Create;
    destructor  Destroy;
    private
      oIdMsgSend: TIdMessage;
      oSMTP: TIdSMTP;
      procedure ShowMessage(pText:ShortString);
    public
      oMessage:TMapiMessage;
      oSrcName:string;
      oSrcAddr:string;
      oCntNum   : word;
      oEML      : TEml;
      ohEml     : TEmlHnd;
      ohEmlReg  : TEmlRegHnd;
      ohDirCnt  : TDirCntHnd;
      function Snd(const pSubject,pMsgText,pTrgName,pTrgAddr:string;const pAttachFileNames: array of String):longint;
      function SndEms(const pEmlNum,pFromName,pFromAddr,pSubject,pToName,pToAddr,pCcAddr,pBccAddr:string;
                pMsgText,pAttFile:TStrings;pPriority:byte;pReturnReciept:boolean;pLink:String;var pErr:boolean):Str12;
    published
      property SrcName:string write oSrcName;
      property SrcAddr:string write oSrcAddr;
  end;

function EmlSnd(const pSubject,pMsgText,pTrgName,pTrgAddr,pAttFile:string):longint;
function EmlSndSmtp(const pEmlNum,pFromName,pFromAddr,pSubject,pToName,pToAddr,pCcAddr,pBccAddr:string;
                pMsgText,pAttFile:TStrings;pPriority:byte;pReturnReciept:boolean;pLink:String;var pErr:boolean):Str12;

function FindEmlPath(const pPath,pEmlNum:string):string;

implementation

function FindEmlPath(const pPath,pEmlNum:string):string;
begin
  Result:='';
  If FileExists(pPath+pEmlNum+'.NLM') then Result:=pPath
  else If FileExists(pPath+'RCV\'+pEmlNum+'.NLM') then Result:=pPath+'RCV\'
  else If FileExists(pPath+'SND\'+pEmlNum+'.NLM') then Result:=pPath+'SND\';
end;

function EmlSnd(const pSubject,pMsgText,pTrgName,pTrgAddr,pAttFile:string):longint;
var mEml:TEml;
begin
  mEml := TEml.Create;
  Result := mEml.Snd(pSubject,pMsgText,pTrgName,pTrgAddr,[pAttFile]);
  FreeAndNil(mEml);
end;

function EmlSndSmtp(const pEmlNum,pFromName,pFromAddr,pSubject,pToName,pToAddr,pCcAddr,pBccAddr:string;
  pMsgText,pAttFile:TStrings;pPriority:byte;pReturnReciept:boolean;pLink:String;var pErr:boolean):Str12;
var mEml:TEml;
begin
  mEml := TEml.Create;
  Result := mEml.SndEms(pEmlNum,pFromName,pFromAddr,pSubject,pToName,pToAddr,pCcAddr,pBccAddr,pMsgText,pAttFile,pPriority,pReturnReciept,pLink,pErr);
  FreeAndNil(mEml);
end;

constructor TEml.Create;
begin
  oSrcName   := 'www.pneueshop.sk';
  oSrcAddr   := 'hornik@pneueshop.sk';
  oIdMsgSend := TIdMessage.Create;
  oSMTP      := TIdSMTP.Create;
  oSMTP.Host     :=gKey.Emc.Host;
  oSMTP.Username :=gKey.Emc.UserName;
  oSMTP.Password :=gKey.Emc.Password;
  oSMTP.Port     :=Valint(gKey.Emc.Port);
  oIdMsgSend.ContentType:='multipart/mixed';
  oIdMsgSend.Encoding:=meMIME;
  ohDIRCNT := TDircntHnd.Create; ohDIRCNT.Open;
  If ohDirCnt.LocateLogName(gvSys.LoginName)
    then oCntNum := 0
    else ohDirCnt.LocateCntNum(oCntNum);
  ohEml := TEmlHnd.Create;       ohEml.Open(oCntNum);
  ohEmlReg := TEmlregHnd.Create; ohEmlReg.Open;
end;

destructor TEml.Destroy;
begin
  //
  FreeAndNil(ohEml);
  FreeAndNil(ohEmlReg);
  FreeAndNil(ohDirCnt);
  FreeAndNil(oIdMsgSend);
  FreeAndNil(oSMTP);
end;

// ********************************* PRIVATE ***********************************

procedure TEml.ShowMessage(pText:ShortString);
begin
  MessageDlg(pText,mtInformation,[mbOk],0);
end;

// ********************************** PUBLIC ***********************************

function TEml.Snd(const pSubject,pMsgText,pTrgName,pTrgAddr:string;const pAttachFileNames: array of String):longint;
var mOriginator,mRecipient:TMapiRecipDesc;  mFiles,mFilesTmp:PMapiFileDesc; I:Integer;  mErr:longint;
begin
  oMessage.nRecipCount := 1;
  oMessage.lpszSubject := PChar(pSubject);
  oMessage.lpszNoteText := PChar(pMsgText);

  FillChar(mOriginator, Sizeof(TMapiRecipDesc), 0);
  mOriginator.lpszName := PAnsiChar(AnsiString(oSrcName));
  mOriginator.lpszAddress := PAnsiChar(AnsiString('SMTP:'+oSrcAddr));
  oMessage.lpOriginator := @mOriginator;

  FillChar(mRecipient, Sizeof(TMapiRecipDesc), 0);
  mRecipient.ulRecipClass := MAPI_TO;
  mRecipient.lpszName := PAnsiChar(AnsiString(pTrgName));
  mRecipient.lpszAddress := PAnsiChar(AnsiString('SMTP:'+pTrgAddr));
  oMessage.lpRecips := @mRecipient;

  oMessage.nFileCount := High(pAttachFileNames)-Low(pAttachFileNames)+1;
  mFiles := AllocMem(SizeOf(TMapiFileDesc)*oMessage.nFileCount);
  oMessage.lpFiles := mFiles;
  mFilesTmp := mFiles;
  For I:=Low(pAttachFileNames) to High(pAttachFileNames) do begin
    mFilesTmp.nPosition := $FFFFFFFF;
    mFilesTmp.lpszPathName := PAnsiChar(AnsiString(pAttachFileNames[I]));
    Inc(mFilesTmp)
  end;
  try
    mErr := MapiSendMail(0,Application.MainForm.Handle,oMessage,MAPI_LOGON_UI {or MAPI_NEW_SESSION},0);
    Result := mErr;
  finally
    FreeMem(mFiles)
  end;

  case mErr of
    MAPI_E_AMBIGUOUS_RECIPIENT: ShowMessage('A recipient matched more than one of the recipient descriptor structures and MAPI_DIALOG was not set. No message was sent.');
    MAPI_E_ATTACHMENT_NOT_FOUND: Showmessage('The specified attachment was not found; no message was sent.');
    MAPI_E_ATTACHMENT_OPEN_FAILURE: Showmessage('The specified attachment could not be opened; no message was sent.');
    MAPI_E_BAD_RECIPTYPE: Showmessage('The type of a recipient was not MAPI_TO, MAPI_CC, or MAPI_BCC. No message was sent.');
    MAPI_E_FAILURE: Showmessage('One or more unspecified errors occurred; no message was sent.');
    MAPI_E_INSUFFICIENT_MEMORY: Showmessage('There was insufficient memory to proceed. No message was sent.');
    MAPI_E_LOGIN_FAILURE: Showmessage('There was no default logon, and the user failed to log on successfully when the logon dialog box was displayed. No message was sent.');
    MAPI_E_TEXT_TOO_LARGE: Showmessage('The text in the message was too large to sent; the message was not sent.');
    MAPI_E_TOO_MANY_FILES: Showmessage('There were too many file attachments; no message was sent.');
    MAPI_E_TOO_MANY_RECIPIENTS: Showmessage('There were too many recipients; no message was sent.');
    MAPI_E_UNKNOWN_RECIPIENT: Showmessage('A recipient did not appear in the address list; no message was sent.');
    MAPI_E_USER_ABORT: Showmessage('The user canceled the process; no message was sent.');
    SUCCESS_SUCCESS: ; // OK
  else
    Showmessage('MAPISendMail failed with an unknown error code.');
  end;
end;

function TEml.SndEms(const pEmlNum,pFromName, pFromAddr, pSubject, pToName,
  pToAddr, pCcAddr, pBccAddr: string; pMsgText, pAttFile: TStrings;
  pPriority: byte; pReturnReciept: boolean; pLink: String;var pErr:boolean): Str12;
var mEmlNum:Str12;mS,mSS:String;mI:byte;
begin
  pErr:= True;
  Result:=pEmlNum;
  If (pEmlNum<>'') and FileExists(gPath.BufPath+pEmlNum+'.NLM')
    then oIdMsgSend.LoadFromFile(gPath.BufPath+pEmlNum+'.NLM')
    else Result:='';
  If Result='' then begin
    with oIdMsgSend do
    begin
      with TIdText.Create(oIdMsgSend.MessageParts, pMsgText) do
      begin
       ContentType := 'text/plain';
      end;
      If oCntNum=0
        then From.Text := pFromAddr
        else From.Text := ohDirCnt.WrkEml;
      ReplyTo.EMailAddresses := pFromAddr;
      Recipients.EMailAddresses := pToAddr;
      Subject := pSubject;
      Priority := TIdMessagePriority(pPriority);
      CCList.EMailAddresses := pCcAddr;
      BccList.EMailAddresses := pBccAddr;
      If CCList.EMailAddresses<>'' then ExtraHeaders.Add('I-CC: '+CCList.EMailAddresses);
      If BccList.EMailAddresses<>'' then ExtraHeaders.Add('I-BCC: '+BCCList.EMailAddresses);
      If pLink<>'' then ExtraHeaders.Add('I-LNK: '+pLink);
      If pReturnReciept
        then ReceiptRecipient.Text := pFromAddr
        else ReceiptRecipient.Text := '';
      If pAttFile.Count>0 then begin
        For mI:=0 to pAttFile.Count-1 do begin
          mSS:=pAttFile[mI];
          With TIdAttachmentFile.Create(oIdMsgSend.MessageParts, mSS) do
            ExtraHeaders.Add(IntToStr(IcFiles.GetFileSize(mSS)));
        end;
      end;
      mEmlNum:=ohEml.GetNextEODocnum;
      Result:=mEmlNum;
      SaveToFile(gPath.BufPath+mEmlNum+'.NLM');
    end;
    ohEml.Insert;
    ohEml.EmlNum := mEmlNum;
    ohEml.EmlDes := oIdMsgSend.Subject;
    ohEml.EmlDate:= Date;
    ohEml.EmlTime:= Time;
    ohEml.CntEml := oIdMsgSend.From.Address;
    ohEml.CntNum := oCntNum;
    If oCntNum>0 then begin
      ohEml.CntPac := ohDirCnt.EmpPac;
      ohEml.CntName:= ohDirCnt.CnName;
    end;
    ohEml.SndSta := 'W';
    ohEml.DspSta := 'X';
    ohEml.EmfNum := 1;
    ohEml.AtcQnt := oIdMsgSend.MessageParts.AttachmentCount;
    ohEml.Post;
  end;
  case gKey.Emc.UseTls of
    0:oSMTP.UseTLS:=utNoTLSSupport;
    1:oSMTP.UseTLS:=utUseImplicitTLS;
    2:oSMTP.UseTLS:=utUseRequireTLS;
    3:oSMTP.UseTLS:=utUseExplicitTLS;
  end;
  If gKey.Emc.UseTls>0 then begin
    oSMTP.IOHandler := TIdSSLIOHandlerSocketOpenSSL.Create(oSMTP);
//   (mSMTP.IOHandler as TIdSSLIOHandlerSocketOpenSSL).SSLOptions.Method := sslvSSLv23;
//          mSMTP.AuthType := satSASL;
  end;
  case gKey.Emc.AuthType of
    0:oSMTP.AuthType:=satNone;
    1:oSMTP.AuthType:=satDefault;
    2:oSMTP.AuthType:=satSASL;
//    2:oSMTP.AuthType:=TIdSMTPAuthenticationType(atSASL);
  end;
  oSMTP.Authenticate;
  try
    oSMTP.Connect;
      If oSmtp.Connected then begin
      try
        try
          pErr:=False;
          oSMTP.Send(oIdMsgSend);
        except
          pErr:= True;
          WriteToLogFile (gPath.SysPath+'LOG\Sendmail.err', oSMTP.LastCmdResult.Code+' - '+ReplaceStr (oSMTP.LastCmdResult.Text.Text, #13+#10, '|'));
        end;
      finally
        oSMTP.Disconnect;
      end;
    end;
  except
    WriteToLogFile (gPath.SysPath+'LOG\Sendmail.err', 'Connect_Error'+gKey.Emc.Host);
  end;
end;

end.
