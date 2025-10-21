unit EmdHnd;

interface

uses
  BasUtilsTCP, EncodeIni, IcTools,
  IdExplicitTLSClientServerBase, IdSSLOpenSSL,
  Classes, SysUtils, IdSMTP, IdMessage, IdMessageBuilder, IdCoderHeader, IdMessageParts;

type
  TVarObj=class (TObject)
  private
    oValue:string;
  public
    property Value:string read oValue write oValue;
  end;

  TEmdHnd=class
  private
    oSndNam:ShortString;  // Meno odosielate¾a
    oSndAdr:ShortString;  // Emailová adresa odosielate¾a
    oTrgAdr:ShortString;  // Emailová adresa adresáta
    oCopAdr:ShortString;  // Emailová adresa - kópia
    oHidAdr:ShortString;  // Emailová adresa - skrytá kópia
    oRcvAdr:ShortString;  // Emailová adresa komu odpoveda
    oSubjec:ShortString;  // Predmet emailu
    oBody:string;         // Telo emailu
    oIsBodyHtml:boolean;  //TRUE - telo má HTML formát
    oDraftEncode:boolean; //Èi treba zakódova koncept
    oSmtp:ShortString;    // Názov servera odchádzajúcej pošty
    oPort:longint;        // Port pre odchádzajúcu poštu
    oUser:ShortString;    // Užívate¾ské meno pre odchádzajúcu poštu
    oPasw:ShortString;    // Heslo pre odchádzajúcu poštu
    oVarLst:TStringList;  // Zoznam premenných
    oAtdLst:TStringList;  // Zoznam pripojených súborov
    oErrCod:integer;      // Èíslo chyby
    oErrTxt:string;
    oMsg:TIdMessage;
    oMsgFill:boolean;

    function ReplaceVariables(pStr:string):string;
    procedure FillMailMsg;
  public
    constructor Create;
    destructor Destroy; override;

    procedure Clear;
    procedure AddTrgAdr(pValue:ShortString);
    procedure AddCopAdr(pValue:ShortString);
    procedure AddHidAdr(pValue:ShortString);

    procedure  AddVar(pVar, pValue:ShortString);
    function   AddAtd(pPath,pFile:ShortString):boolean;
    procedure  AddBody(pBody:string);
    function   AddBodyMask (pPath,pMask:string):boolean;
    function   AddBodyHTMLMask (pPath,pMask:string):boolean;
    procedure  SetSubjec(pSubjec:ShortString);

    function  SaveMail (pPath,pFile:string):boolean;
    function  LoadMail (pPath,pFile:string):boolean;
    function  SendMail:boolean;

    function  SaveDraft (pPath,pFile:string):boolean;
    function  AddAttachToDraft (pPath,pFile,pAttachmentPath,pAttachmentList:string):boolean;
    function  SendDraft (pPath,pFile:string):boolean;

    property Smtp:ShortString read oSmtp write oSmtp;
    property Port:longint read oPort write oPort;
    property User:ShortString read oUser write oUser;
    property Pasw:ShortString read oPasw write oPasw;

    property SndNam:ShortString read oSndNam write oSndNam;
    property SndAdr:ShortString read oSndAdr write oSndAdr;
    property TrgAdr:ShortString read oTrgAdr write oTrgAdr;
    property CopAdr:ShortString read oCopAdr write oCopAdr;
    property HidAdr:ShortString read oHidAdr write oHidAdr;
    property RcvAdr:ShortString read oRcvAdr write oRcvAdr;
    property Subjec:ShortString read oSubjec write SetSubjec;
    property Body:string read oBody write oBody;
    property ErrCod:integer read oErrCod;
    property ErrTxt:string read oErrTxt;
    property DraftEncode:boolean read oDraftEncode write oDraftEncode;
  end;

function SendMail:boolean;

implementation

uses IdEMailAddress, IdReply;

function SendMail:boolean;
begin
end;

constructor TEmdHnd.Create;
begin
  oErrCod:=0;
  oErrTxt:='';
  oVarLst:=TStringList.Create;
  oAtdLst:=TStringList.Create;
  oMsg:=TIdMessage.Create(nil);
  oMsgFill:=FALSE;
  oDraftEncode:=FALSE;
end;

destructor  TEmdHnd.Destroy;
begin
  FreeAndNil(oVarLst);
  FreeAndNil(oAtdLst);
  FreeAndNil(oMsg);
end;

function  TEmdHnd.ReplaceVariables(pStr:string):string;
var I:longint;
begin
  If oVarLst.Count>0 then begin
    For I:=0 to oVarLst.Count-1 do begin
      try
        If Pos (oVarLst.Strings[I],pStr)>0 then pStr:=ReplaceStr(pStr,oVarLst.Strings[I],(oVarLst.Objects[I] as TVarObj).Value);
      except end;
    end;
  end;
  Result:=pStr;
end;

procedure  TEmdHnd.FillMailMsg;
var I:longint; mS:string; mBuilder:TIdCustomMessageBuilder;
begin
  If not oMsgFill then begin
    try
      mBuilder:=TIdMessageBuilderHtml.Create;
      TIdMessageBuilderHtml(mBuilder).HtmlViewerNeededMsg:='';
      TIdMessageBuilderHtml(mBuilder).HtmlCharSet:='UTF-8';
      TIdMessageBuilderHtml(mBuilder).PlainTextCharSet:='UTF-8';
      If oIsBodyHtml then begin
//        TIdMessageBuilderHtml(mBuilder).Html.Text:=UTF8Encode (oBody);
        TIdMessageBuilderHtml(mBuilder).Html.Text:=oBody;
        TIdMessageBuilderHtml(mBuilder).PlainText.Text:=UTF8Encode (' ');
      end else TIdMessageBuilderHtml(mBuilder).PlainText.Text:=oBody;
      try
        If oAtdLst<>nil then begin
          If oAtdLst.Count>0 then begin
            For I:=0 to oAtdLst.Count-1 do begin
              mS:=oAtdLst.Strings[I];
              mBuilder.Attachments.Add(mS);
            end;
          end;
        end;
        mBuilder.FillMessage(oMsg);
      finally FreeAndNil (mBuilder); end;

      oMsg.CharSet:='UTF-8';
      oMsg.ContentTransferEncoding:='7bit';
      oMsg.From.Name:=oSndNam;
      oMsg.From.Address:=oSndAdr;
      oMsg.ExtraHeaders.Values['Subject']:='=?UTF-8?B?'+EncodeB64 (UTF8Encode (oSubjec),0)+'?=';
      If LineElementNum(oTrgAdr,',')>0 then begin
        For I:=0 to LineElementNum(oTrgAdr,',')-1 do begin
          mS:=LineElement(oTrgAdr,I,',');
          If mS<>'' then oMsg.Recipients.Add.Address:=mS;
        end;
      end;
      If LineElementNum(oCopAdr,',')>0 then begin
        For I:=0 to LineElementNum(oCopAdr,',')-1 do begin
          mS:=LineElement(oCopAdr,I,',');
          If mS<>'' then oMsg.CCList.Add.Address:=mS;
        end;
      end;
      If LineElementNum(oHidAdr,',')>0 then begin
        For I:=0 to LineElementNum(oHidAdr,',')-1 do begin
        mS:=LineElement(oHidAdr,I,',');
        if mS<>'' then oMsg.BccList.Add.Address:=mS;
        end;
      end;
      oMsg.ReplyTo.Add.Address:=oRcvAdr;
    except oErrCod:=21; end;
    oMsgFill:=TRUE;
  end;
end;

procedure TEmdHnd.Clear;
begin
  oSndNam:='';
  oSndAdr:='';
  oTrgAdr:='';
  oCopAdr:='';
  oHidAdr:='';
  oRcvAdr:='';
  oSubjec:='';
  oBody:='';
  oIsBodyHtml:=FALSE;
  oDraftEncode:=FALSE;
  oVarLst.Clear;
  oAtdLst.Clear;
  oErrCod:=0;
  oMsgFill:=FALSE;
end;

procedure  TEmdHnd.AddTrgAdr(pValue:ShortString);
begin
  If oTrgAdr<>'' then oTrgAdr:=oTrgAdr+',';
  oTrgAdr:=oTrgAdr+pValue;
end;

procedure  TEmdHnd.AddCopAdr(pValue:ShortString);
begin
  If oCopAdr<>'' then oCopAdr:=oCopAdr+',';
  oCopAdr:=oCopAdr+pValue;
end;

procedure  TEmdHnd.AddHidAdr (pValue:ShortString);
begin
  If oHidAdr<>'' then oHidAdr:=oHidAdr+',';
  oHidAdr:=oHidAdr+pValue;
end;

procedure  TEmdHnd.AddVar (pVar, pValue:ShortString);
var mVarObj:TVarObj;
begin
  If pVar<>'' then begin
    pVar:='#'+pVar+'#';
    mVarObj:=TVarObj.Create;
    mVarObj.Value:=pValue;
    oVarLst.AddObject(pVar, mVarObj);
  end;
end;

function TEmdHnd.AddAtd(pPath,pFile:ShortString):boolean;
begin
  Result:=FALSE;
  If DirectoryExists(pPath) then begin
    If FileExists(pPath+pFile) then begin
      oAtdLst.Add(pPath+pFile);
      Result:=TRUE;
    end else oErrCod:=11;
  end else oErrCod:=10;
end;

procedure  TEmdHnd.SetSubjec(pSubjec:ShortString);
begin
  oSubjec:=ReplaceVariables(pSubjec);
end;

procedure  TEmdHnd.AddBody (pBody:string);
begin
  oIsBodyHtml:=FALSE;
  oBody:=ReplaceVariables(pBody);
end;

function TEmdHnd.AddBodyMask (pPath,pMask:string):boolean;
var mSL:TStringList;
begin
  oIsBodyHtml:=FALSE;
  Result:=FALSE;
  oBody:='';
  If FileExists(pPath+pMask) then begin
    mSL:=TStringList.Create;
    try
      mSL.LoadFromFile(pPath+pMask);
      Result:=TRUE;
      If mSL.Count>0 then oBody:=ReplaceVariables(mSL.Text);
    except end;
    FreeAndNil(mSL);
  end;
end;

function TEmdHnd.AddBodyHTMLMask (pPath,pMask:string):boolean;
begin
  Result:=AddBodyMask (pPath,pMask);
  oIsBodyHtml:=TRUE;
end;

function TEmdHnd.SaveMail (pPath,pFile:string):boolean;
begin
  Result:=FALSE;
  If oErrCod=0 then begin
    If DirectoryExists(pPath) then begin
      If oSndAdr<>'' then begin
        If oTrgAdr+oCopAdr+oHidAdr<>'' then begin
          FillMailMsg;
          oMsg.SaveToFile(pPath+pFile);
          Result:=TRUE;
        end else oErrCod:=3;
      end else oErrCod:=2;
    end else oErrCod:=1;
  end;
end;

function  TEmdHnd.LoadMail (pPath,pFile:string):boolean;
var mSubject:string;
begin
  Result:=FALSE;
  If oErrCod=0 then begin
    If DirectoryExists(pPath) then begin
      If FileExists(pPath+pFile) then begin
        try
          oMsg.LoadFromFile(pPath+pFile);
          mSubject:=oMsg.Subject;
          oMsg.Subject:='';
          oMsg.CharSet:='UTF-8';
          oMsg.ExtraHeaders.Values['Subject']:='=?UTF-8?B?'+EncodeB64 (UTF8Encode (mSubject),0)+'?=';
          oMsgFill:=TRUE;
          Result:=TRUE;
        except oErrCod:=33; end;
      end else oErrCod:=32;
    end else oErrCod:=31;
  end;
end;

function  TEmdHnd.SendMail:boolean;
var mSMTP:TIdSMTP;
  mIdSSLHandler: TIdSSLIOHandlerSocketOpenSSL;
begin
  Result:=FALSE;
  If oErrCod=0 then begin
    FillMailMsg;
    If oErrCod=0 then begin
      mSMTP:=TIdSMTP.Create(nil);
      try
        mSMTP.Host:=oSmtp;
        mSMTP.Port:=oPort;
        mSMTP.Username:=oUser;
        mSMTP.Password:=oPasw;
        mSMTP.ConnectTimeout:=3000;

//        mSMTP.Authenticate;
//        mSMTP.UseTLS
//        mSMTP.AuthType
//        mSMTP.AuthType:=satDefault;
//        mSMTP.UseTLS:=utNoTLSSupport;

//    utNoTLSSupport,
//    utUseImplicitTLS, // ssl iohandler req, allways tls
//    utUseRequireTLS, // ssl iohandler req, user command only accepted when in tls
//    utUseExplicitTLS // < user can choose to use tls

//        mSMTP.Authenticate;
        mSMTP.Connect;
        If mSMTP.Connected then begin
          try
            oErrTxt:=oSmtp+'/'+oUser+'/'+StrInt(oPort,0);
            mSMTP.Send(oMsg);
            Result:=TRUE;
          except oErrCod:=43 end;

// WriteToErrLog ('sendmail.err', mSMTP.LastCmdResult.Code+' - '+ReplaceStr (mSMTP.LastCmdResult.Text.Text, zCR+zLF, '|'));

          try mSMTP.Disconnect; except end;
        end else oErrCod:=42;
      except oErrCod:=41; end;
      try FreeAndNil(mSMTP); except end;
    end;
  end;
end;

function  TEmdHnd.SaveDraft (pPath,pFile:string):boolean;
var mF:TEncodeIniFile; mFile,mSect:string; I:longint; mOK:boolean;
begin
  Result:=FALSE;
  If FileExists(pPath+pFile) then DeleteFile(pPath+pFile);
  try
    mF:=TEncodeIniFile.Create(pPath+pFile,FALSE);
    mF.Encode:=oDraftEncode;
    mSect:='MAIL';
    mF.WriteString(mSect,'SndName',oSndNam);
    mF.WriteString(mSect,'SndAdr',oSndAdr);
    mF.WriteString(mSect,'TrgAdr',oTrgAdr);
    mF.WriteString(mSect,'CopAdr',oCopAdr);
    mF.WriteString(mSect,'HidAdr',oHidAdr);
    mF.WriteString(mSect,'RcvAdr',oRcvAdr);
    mF.WriteString(mSect,'Subjec',oSubjec);
    mF.WriteString(mSect,'Body',EncodeB64(oBody,0));
    mF.WriteBool(mSect,'IsBodyHtml',oIsBodyHtml);
    mOK:=TRUE;
    try
      If oAtdLst<>nil then begin
        If oAtdLst.Count>0 then begin
          For I:=0 to oAtdLst.Count-1 do begin
            mFile:=oAtdLst.Strings[I];
            If FileExists(mFile)
              then mF.WriteFileData(mSect,'Attach'+StrInt(I+1,0),mFile)
              else mOK:=FALSE;
          end;
        end;
      end;
    except mOK:=FALSE; end;
    If mOK then begin
      mF.SaveFile;
      Result:=TRUE;
    end;
    FreeAndNil(mF);
  except end;
end;

function  TEmdHnd.AddAttachToDraft (pPath,pFile,pAttachmentPath,pAttachmentList:string):boolean;
var I,mCnt:longint; mF:TEncodeIniFile; mSect,mAttachFile:string; mOK:boolean;
begin
  Result:=FALSE;
  If FileExists(pPath+pFile) then begin
    If pAttachmentList<>'' then begin
      mCnt:=LineElementNum(pAttachmentList,';');
      If mCnt>0 then begin
        mOK:=TRUE;
        For I:=0 to mCnt-1 do begin
          mAttachFile:=LineElement(pAttachmentList,I,';');
          mOK:=FileExists(pAttachmentPath+mAttachFile);
          If not mOK then Break;
        end;
        If mOK then begin
          Result:=TRUE;
          mSect:='MAIL';
          mF:=TEncodeIniFile.Create(pPath+pFile,FALSE);
          mF.Encode:=oDraftEncode;
          For I:=0 to mCnt-1 do begin
            mAttachFile:=LineElement(pAttachmentList,I,';');
            mF.WriteFileData(mSect,'Attach'+StrInt(I+1,0),pAttachmentPath+mAttachFile);
          end;
          mF.SaveFile;
          FreeAndNil(mF);
        end;
      end;
    end;
  end;
end;

function  TEmdHnd.SendDraft (pPath,pFile:string):boolean;
var I, mFCnt:longint; mFName,mSect,mS:string; mBuilder:TIdCustomMessageBuilder; mF:TEncodeIniFile;
    mStream:TStringStream; mFLst:TStringList;
begin
  Result:=FALSE;
  oMsgFill:=TRUE;
  If FileExists(pPath+pFile) then begin
    try
      mF:=TEncodeIniFile.Create(pPath+pFile,FALSE);
      mSect:='MAIL';
      oSndNam:=mF.ReadString(mSect,'SndNam','');
      oSndAdr:=mF.ReadString(mSect,'SndAdr','');
      oTrgAdr:=mF.ReadString(mSect,'TrgAdr','');
      oCopAdr:=mF.ReadString(mSect,'CopAdr','');
      oHidAdr:=mF.ReadString(mSect,'HidAdr','');
      oRcvAdr:=mF.ReadString(mSect,'RcvAdr','');
      oSubjec:=mF.ReadString(mSect,'Subjec','');
      oBody:=DecodeB64(mF.ReadString(mSect,'Body',''),0);
      oIsBodyHtml:=mF.ReadBool(mSect,'IsBodyHtml',FALSE);
      try
        mBuilder:=TIdMessageBuilderHtml.Create;
        TIdMessageBuilderHtml(mBuilder).HtmlViewerNeededMsg:='';
        TIdMessageBuilderHtml(mBuilder).HtmlCharSet:='UTF-8';
        TIdMessageBuilderHtml(mBuilder).PlainTextCharSet:='UTF-8';
        If oIsBodyHtml then begin
//          TIdMessageBuilderHtml(mBuilder).Html.Text:=UTF8Encode (oBody);
          TIdMessageBuilderHtml(mBuilder).Html.Text:=oBody;
          TIdMessageBuilderHtml(mBuilder).PlainText.Text:=UTF8Encode (' ');
        end else TIdMessageBuilderHtml(mBuilder).PlainText.Text:=oBody;

        try
          mFLst:=TStringList.Create;
          I:=0;
          While mF.ValueExists(mSect, 'Attach'+StrInt(I+1,0)) do begin
            mStream:=nil;
            If mF.ReadFileDataToStream(mSect, 'Attach'+StrInt(I+1,0),mFName,mStream) then begin
              mFLst.Add(mFName);
              mBuilder.Attachments.Add(mStream,'');
            end;
            Inc (I);
          end;

          mBuilder.FillMessage(oMsg);

          I:=0; mFCnt:=0;
          For I:=0 to oMsg.MessageParts.Count-1 do begin
            If oMsg.MessageParts[I].PartType = mptAttachment then begin
              oMsg.MessageParts[I].FileName := mFLst.Strings[mFCnt];
              Inc (mFCnt);
            end;
          end;
          FreeAndNil(mFLst);
        finally FreeAndNil (mBuilder); end;

        oMsg.CharSet:='UTF-8';
        oMsg.ContentTransferEncoding:='7bit';
        oMsg.From.Name:=oSndNam;
        oMsg.From.Address:=oSndAdr;
        oMsg.ExtraHeaders.Values['Subject']:='=?UTF-8?B?'+EncodeB64 (UTF8Encode (oSubjec),0)+'?=';

        If LineElementNum(oTrgAdr,',')>0 then begin
          For I:=0 to LineElementNum(oTrgAdr,',')-1 do begin
            mS:=LineElement(oTrgAdr,I,',');
            If mS<>'' then oMsg.Recipients.Add.Address:=mS;
          end;
        end;

        If LineElementNum(oCopAdr,',')>0 then begin
          For I:=0 to LineElementNum(oCopAdr,',')-1 do begin
            mS:=LineElement(oCopAdr,I,',');
            If mS<>'' then oMsg.CCList.Add.Address:=mS;
          end;
        end;

        If LineElementNum(oHidAdr,',')>0 then begin
          For I:=0 to LineElementNum(oHidAdr,',')-1 do begin
          mS:=LineElement(oHidAdr,I,',');
          if mS<>'' then oMsg.BccList.Add.Address:=mS;
          end;
        end;

        oMsg.ReplyTo.Add.Address:=oRcvAdr;
      except end;
      FreeAndNil(mF);
      Result:=SendMail;
      If not Result then begin
        WriteStrToFile(pPath+'sendmail.err',FormatDateTime('dd.mm.yyyy hh:nn:ss,zzz',Now)+' - Chyba: '+StrInt (oErrCod,0)+' - '+oErrTxt);
      end;
    except end;
  end;
end;

end.
