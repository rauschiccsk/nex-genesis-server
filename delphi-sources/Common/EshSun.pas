unit EshSun;

interface

uses IcConv, IcTools, IdHashSHA, IdCoderMIME, IdHTTP, Classes, SysUtils, Controls, IdCoder, IdGlobal;

const
  cMaskOrder='{#shippingAddress,#items}';
  cMaskOrderB='{#shippingAddress,#billingAddress,#items}';
  cMaskAddr1='"shippingAddress": {"firstName": "#firstName","lastName": "#lastName","street": "#street","city": "#city","zip": "#zip","company": "#company","ico": "#ico","dic": "#dic","icDph": "#icDph","phone": "#phone","mail": "#mail"}';
  cMaskAddr2='"billingAddress": {"firstName": "#firstName","lastName": "#lastName","street": "#street","city": "#city","zip": "#zip","company": "#company","ico": "#ico","dic": "#dic","icDph": "#icDph","phone": "#phone","mail": "#mail"}';
  cMaskItems='"items":[#items]';
  cMaskItemData='{"code": "#code", "name": "#name", "price": #price, "vat": #vat, "qty": #qty}';

type
  TEshSun = class
    constructor Create;
    destructor Destroy; override;

  private
    oErrCode   :longint;
    oErrMsg    :string;
    oUsername  :string;
    oPassword  :string;

    oStrAddr1  :string;
    oStrAddr2  :string;
    oAddr2Set  :boolean;
    oItemLst   :TStringList;

    oIdHTTP    : TIdHTTP;

    procedure SetError(pErrCode:longint; pText:string);
    procedure GetResponseMsg (pText:string; var pErr:boolean; var pMsg:string);
    function  SendData(pURL,pDocNum:string; pBody:TStringStream):boolean;
    function  GetFileBase64(pStr:string):string;
    function  GetFileSize(pFile:string):longint;
    function  GetSHA1(pStr:string):string;
    function  LoadFile (pFileName:string):string;
    function  GetOrderBody:string;
  public
    function ChangeStatus (pURL,pOcdNum,pCode,pText:string):boolean;

    function SendInvoice (pURL,pOcdNum,pIcdNum:string;pDocDate,pExpDate:TDate;pFile:string):boolean;

    procedure ClearOrder;
    procedure AddAddr1 (pFirstName,pLastName,pStreet,pCity,pZIP,pCompany,pIno,pTin,pVin,pPhone,pMail:string);
    procedure AddAddr2 (pFirstName,pLastName,pStreet,pCity,pZIP,pCompany,pIno,pTin,pVin,pPhone,pMail:string);
    procedure AddItem (pCode,pName:string; pPrice:double; pVatPrc:byte; pQnt:double);
    function  SendOrder (pURL,pOcdNum:string):boolean;

    property ErrCode:longint read oErrCode write oErrCode;
    property ErrMsg:string read oErrMsg write oErrMsg;
    property Username:string read oUsername write oUsername;
    property Password:string read oPassword write oPassword;
  end;


implementation

constructor TEshSun.Create;
begin
  oItemLst:=TStringList.Create;
  ClearOrder;
end;

destructor TEshSun.Destroy;
begin
  FreeAndNil(oItemLst);
  inherited;
end;

procedure TEshSun.SetError(pErrCode:longint; pText:string);
var mErr:boolean; mMsg:string;
begin
  If pErrCode=-1 then begin
    If pText='Unauthorized access!' then begin
      oErrCode:=401;
      oErrMsg:='Unauthorized access!';
    end else begin
      GetResponseMsg(pText,mErr,mMsg);
      If mErr
        then oErrCode:=1
        else oErrCode:=0;
      oErrMsg:=mMsg;
    end;
  end else begin
    GetResponseMsg(pText,mErr,mMsg);
    oErrCode:=pErrCode;
    oErrMsg:=mMsg;
  end;
end;

procedure TEshSun.GetResponseMsg (pText:string; var pErr:boolean; var pMsg:string);
var mS,mText:string;
begin
  pErr:=TRUE;
  pMsg:='';
  If Pos('{',pText)=1 then begin
    mText:=pText;
    Delete(mText,1,1);
    Delete(mText,Length(mText),1);
    mS:=LineElement(mText,0,',');
    If LineElement(mS,0,':')='"status"' then begin
      If LineElement(mS,1,':')='"ok"' then begin
        pErr:=FALSE;
        pMsg:='ok';
      end else begin
        mS:=LineElement(mText,1,',');
        pErr:=TRUE;
        pMsg:=LineElement(mS,1,':');
      end;
    end else begin
      pErr:=TRUE;
      pMsg:=mText;
    end;
  end else begin
    pErr:=TRUE;
    pMsg:=pText;
  end;
end;

function  TEshSun.SendData(pURL,pDocNum:string; pBody:TStringStream):boolean;
var mS, mRes, mMsg, mErrMsg:string; mErrCode:longint; mResponse:TMemoryStream;
begin
  mResponse := TMemoryStream.Create;
  oIdHTTP:=TIdHTTP.Create;
  try
    oIdHTTP.Request.BasicAuthentication := TRUE;
    oIdHTTP.Request.Username := oUsername;
    oIdHTTP.Request.Password := oPassword;
    oIdHTTP.Post(pURL+pDocNum, pBody, mResponse);
    SetString(mRes, PAnsiChar(mResponse.Memory), mResponse.Size);
    SetError(-1, mRes);
    Result:=oErrCode=0;
  except
    on E: EIdHTTPProtocolException do begin
      mErrCode:=E.ErrorCode;
      mMsg:=E.Message;
      mErrMsg:=E.ErrorMessage;
      If mErrMsg=''
        then SetError(mErrCode, mMsg)
        else SetError(mErrCode, mErrMsg);
    end;
  end;
  FreeAndNil(oIdHTTP);
  FreeAndNil(mResponse);
end;

function TEshSun.GetFileBase64(pStr:string):string;
var mData:TIdBytes; mFS: TFileStream; I:longint;
begin
  SetLength(mData, Length(pStr));
  For I:=0 to Length(pStr) - 1 do
    mData[I] := Ord(pStr[I+1]);
  Result:= TIdEncoderMIME.EncodeBytes(mData);
end;

function  TEshSun.GetFileSize(pFile:string):longint;
var mSR:TSearchRec;
begin
  Result:=0;
  If FindFirst(pFile, faAnyFile, mSR) = 0 then begin
    Result:=mSR.Size;
    FindClose(mSR);
  end;
end;

function  TEshSun.GetSHA1(pStr:string):string;
var mSHA1:TIdHashSHA1;
begin
  mSHA1 := TIdHashSHA1.Create;
  try
    Result := LowerCase (mSHA1.HashStringAsHex(pStr));
  finally
    mSHA1.Free;
  end;
end;

function  TEshSun.LoadFile (pFileName:string):string;
var mStream:TFileStream; mCh:array [1..10000] of char; J,mLen, mALen:longint;
begin
  Result:='';
  If FileExists(pFileName) then begin
    try
      mStream:=TFileStream.Create(pFileName, fmOpenRead);
      mLen := mStream.Size-1;
      mALen:=10000;
      Repeat
        If mLen-mStream.Position<mALen then mALen:=mLen-mStream.Position+1;
        mStream.Read(mCh, mALen);
        For J:=1 to mALen do begin
          Result:=Result+mCh[J];
        end;
      until mStream.Position>=mLen;
      FreeAndNil (mStream);
    except end;
  end;
end;

function TEshSun.GetOrderBody:string;
var mItems,mItemLst:string; I:longint;
begin
  mItemLst:='';
  If oItemLst.Count>0 then begin
    For I:=0 to oItemLst.Count-1 do begin
      If I>0 then mItemLst:=mItemLst+',';
      mItemLst:=mItemLst+oItemLst.Strings[I];
    end;
  end;
  mItems:=cMaskItems;
  mItems:=ReplaceStr(mItems,'#items',mItemLst);
  If oAddr2Set
    then Result:=cMaskOrderB
    else Result:=cMaskOrder;
  Result:=ReplaceStr(Result,'#shippingAddress',oStrAddr1);
  Result:=ReplaceStr(Result,'#billingAddress',oStrAddr2);
  Result:=ReplaceStr(Result,'#items',mItems);
end;

function TEshSun.ChangeStatus (pURL,pOcdNum,pCode,pText:string):boolean;
var mS:string; mBody:TStringStream;
begin
  oErrCode:=-1;
  oErrMsg:='';
  Result:=FALSE;
  mS:='{"state": '+pCode+',"description": "'+pText+'"}';
  mBody := TStringStream.Create(Utf8Encode(mS));
  Result:=SendData(pURL,pOcdNum,mBody);
  FreeAndNil(mBody);
end;

function TEshSun.SendInvoice (pURL,pOcdNum,pIcdNum:string;pDocDate,pExpDate:TDate;pFile:string):boolean;
var mS,mSHA1,mFileData,mFileB64:string; mBody:TStringStream; mSize:longint;
begin
  oErrCode:=-1;
  oErrMsg:='';
  Result:=FALSE;
  If FileExists(pFile) then begin
    mSize:=GetFileSize(pFile);
    mFileData:=LoadFile (pFile);
    mSHA1:=GetSHA1(mFileData);
    mFileB64:=GetFileBase64(mFileData);

    mS:='{"number": "'+pIcdNum+'","issueDate": "'+FormatDateTime ('yyyy-mm-dd', pDocDate)+'","dueDate": "'+FormatDateTime ('yyyy-mm-dd', pExpDate)
    +'","file": "'+mFileB64+'","fileSize": "'+StrInt(mSize,0)+'","hash": "'+mSHA1+'"}';
    mBody := TStringStream.Create(Utf8Encode(mS));
    Result:=SendData(pURL,pOcdNum,mBody);
    FreeAndNil(mBody);
  end;
end;

procedure TEshSun.ClearOrder;
begin
  oAddr2Set:=FALSE;
  oStrAddr1:='';
  oStrAddr2:='';
  oItemLst.Clear;
end;

procedure TEshSun.AddAddr1 (pFirstName,pLastName,pStreet,pCity,pZIP,pCompany,pIno,pTin,pVin,pPhone,pMail:string);
begin
  oStrAddr1:=cMaskAddr1;
  oStrAddr1:=ReplaceStr(oStrAddr1,'#firstName',pFirstName);
  oStrAddr1:=ReplaceStr(oStrAddr1,'#lastName',pLastName);
  oStrAddr1:=ReplaceStr(oStrAddr1,'#street',pStreet);
  oStrAddr1:=ReplaceStr(oStrAddr1,'#city',pCity);
  oStrAddr1:=ReplaceStr(oStrAddr1,'#zip',pZIP);
  oStrAddr1:=ReplaceStr(oStrAddr1,'#company',pCompany);
  oStrAddr1:=ReplaceStr(oStrAddr1,'#ico',pIno);
  oStrAddr1:=ReplaceStr(oStrAddr1,'#dic',pTin);
  oStrAddr1:=ReplaceStr(oStrAddr1,'#icDph',pVin);
  oStrAddr1:=ReplaceStr(oStrAddr1,'#phone',pPhone);
  oStrAddr1:=ReplaceStr(oStrAddr1,'#mail',pMail);
end;

procedure TEshSun.AddAddr2 (pFirstName,pLastName,pStreet,pCity,pZIP,pCompany,pIno,pTin,pVin,pPhone,pMail:string);
begin
  oAddr2Set:=TRUE;
  oStrAddr2:=cMaskAddr2;
  oStrAddr2:=ReplaceStr(oStrAddr2,'#firstName',pFirstName);
  oStrAddr2:=ReplaceStr(oStrAddr2,'#lastName',pLastName);
  oStrAddr2:=ReplaceStr(oStrAddr2,'#street',pStreet);
  oStrAddr2:=ReplaceStr(oStrAddr2,'#city',pCity);
  oStrAddr2:=ReplaceStr(oStrAddr2,'#zip',pZIP);
  oStrAddr2:=ReplaceStr(oStrAddr2,'#company',pCompany);
  oStrAddr2:=ReplaceStr(oStrAddr2,'#ico',pIno);
  oStrAddr2:=ReplaceStr(oStrAddr2,'#dic',pTin);
  oStrAddr2:=ReplaceStr(oStrAddr2,'#icDph',pVin);
  oStrAddr2:=ReplaceStr(oStrAddr2,'#phone',pPhone);
  oStrAddr2:=ReplaceStr(oStrAddr2,'#mail',pMail);
end;

procedure TEshSun.AddItem (pCode,pName:string; pPrice:double; pVatPrc:byte; pQnt:double);
var mS:string;
begin
  mS:=cMaskItemData;
  mS:=ReplaceStr(mS,'#code',pCode);
  mS:=ReplaceStr(mS,'#name',pName);
  mS:=ReplaceStr(mS,'#price',StrDoub(pPrice,0,2));
  mS:=ReplaceStr(mS,'#vat',StrDoub(pVatPrc,0,2));
  mS:=ReplaceStr(mS,'#qty',StrDoub(pQnt,0,2));
  oItemLst.Add(mS);
end;

function TEshSun.SendOrder (pURL,pOcdNum:string):boolean;
var mBody:TStringStream; mS:string;
begin
  Result:=FALSE;
  mS:=GetOrderBody;
  mBody := TStringStream.Create(Utf8Encode(mS));
  Result:=SendData(pURL,pOcdNum,mBody);
  FreeAndNil(mBody);
end;

end.

mRes
'{"status":"ok"}'

Unauthorized access!


-----------------------

mErrMsg
400
'HTTP/1.1 400 Error'
'{"status":"error","message":"Order  not found."}'
'{"status":"error","message":"Order 81526 not found."}'

500
'HTTP/1.1 500 Internal Server Error'



      Zmena obsahu objednavky

      POST  www.pneueshop.sk/admin/api/order/[cislo_objednavky]
      BODY vo formate JSON



{
"shippingAddress": {firstName: "Jan",lastName: "Maly",street: "Štúrova 22",city: "Nitra",zip: "94901",company: "Firma s.r.o.",ico: "123456",dic: "20304050",icDph: "SK20304050"},
"billingAddress": {firstName: "Jan",lastName: "Maly",street: "Štúrova 22",city: "Nitra",zip: "94901",company: "Firma s.r.o.",ico: "123456",dic: "20304050",icDph: "SK20304050"},
"items":[

{code: "123456", name: "Matador MP40", price: 49.90, vat: 20.00, qty: 4},
{code: "123456", name: "Matador MP40", price: 49.90, vat: 20.00, qty: 4},
{code: "123456", name: "Matador MP40", price: 49.90, vat: 20.00, qty: 4},

]
}


{
"shippingAddress": {firstName: "#firstName",lastName: "#lastName",street: "#street",city: "#city",zip: "#zip",company: "#company",ico: "#ico",dic: "#dic",icDph: "#icDph"},
"billingAddress": {firstName: "#firstName",lastName: "#lastName",street: "#street",city: "#city",zip: "#zip",company: "#company",ico: "#ico",dic: "#dic",icDph: "#icDph"},
"items":[
{code: "#code", name: "#name", price: #price, vat: #va, qty: #qty},
]
}






