unit IccFtp;

interface

uses
  IcTypes, IcTools, IcVariab, IcConv, IdHTTP, NMFTP,
  Windows, Registry, SysUtils, Forms, Classes;

type
  TIccFtp=class
    constructor Create(pDataFile:ShortString);
  private
    oNMFTP:TNMFTP;
    oStatus:ShortString;
    oFtpHost:ShortString;
    oFtpUser:ShortString;
    oFtpPasw:ShortString;
    oFtpPath:ShortString;
    function DecodeStr(pData:string;pMask:byte):string;
    procedure ReadFtpData(pDataFile:ShortString);
  public
    procedure Connect;
    procedure SetFtpDir; // Nastavi adresar, ktory bol nacitany z adatoveho suboru
    procedure ChangeDir(pDir:string);
    procedure Dovnload(pRemFile,pLocFile:string);
    procedure Upload(pLocFile,pRemFile:string);
    procedure Disconnect;
  published
    property Status:ShortString read oStatus write oStatus;
    property FtpHost:ShortString read oFtpHost write oFtpHost;
    property FtpUser:ShortString read oFtpuser write oFtpUser;
    property FtpPasw:ShortString read oFtpPasw write oFtpPasw;
    property FtpPath:ShortString read oFtpPath write oFtpPath;
  end;

implementation

constructor TIccFtp.Create(pDataFile:ShortString);
begin
  ReadFtpData (pDataFile);
end;

// ************************************** PRIVATE ********************************************

function  TIccFtp.DecodeStr (pData:string;pMask:byte):string;
var I:longint;
begin
  Result:='';
  For I:=1 to Length(pData) do
    Result:=Result+Chr(Ord(pData[I])+pMask);
end;

procedure TIccFtp.ReadFtpData (pDataFile:ShortString);
var mHTTP: TIdHTTP;  mData:string;  mMask1,mMask2,mMask3,mMask4:byte;
begin
  // Nacitame prihlasovacie udaje z nasej HTTP stranky
  mHTTP:=TIdHTTP.Create;
  mHTTP.Request.UserAgent:='Mozilla/4.0 (compatible; MSIE 6.0; Windows NT 5.1)';
  try
    mData:=mHTTP.Get('http://www.icc.sk/nexreg/'+pDataFile);
  except end;
  FreeAndNil (mHTTP);
  // Dekodujeme ziskane udaje
  oFtpHost:='';  oFtpUser:=''; oFtpPasw:='';
  If Length(mData)=111 then begin
    mMask1:=Ord(mData[1]);
    mMask2:=Ord(mData[2]);
    mMask3:=Ord(mData[3]);
    mMask4:=Ord(mData[4]);
    oFtpHost:=ReplaceStr(DecodeStr(copy(mData,12,20),mMask1),' ','');
    oFtpUser:=ReplaceStr(DecodeStr(copy(mData,37,10),mMask2),' ','');
    oFtpPasw:=ReplaceStr(DecodeStr(copy(mData,57,10),mMask3),' ','');
    oFtpPath:=ReplaceStr(DecodeStr(copy(mData,75,30),mMask4),' ','');
  end;
end;

// ************************************** PUBLIC ********************************************

procedure TIccFtp.Connect;
begin
  oNMFTP:=TNMFTP.Create(nil);
  oNMFTP.Passive:=TRUE;
  oNMFTP.Host:=oFtpHost;
  oNMFTP.UserID:=oFtpUser;
  oNMFTP.Password:=oFtpPasw;
  try
    oNMFTP.Connect;
  except end;
  oStatus:=oNMFTP.Status;
  oNMFTP.Mode(MODE_BYTE);
end;

procedure TIccFtp.SetFtpDir; // Nastavi adresar, ktory bol nacitany z adatoveho suboru
begin
  ChangeDir(oFtpPath);
end;

procedure TIccFtp.ChangeDir (pDir:string);
begin
  try
    If pDir<>'' then oNMFTP.ChangeDir(pDir);
    oStatus:=oNMFTP.Status;
  except end;
end;

procedure TIccFtp.Dovnload (pRemFile,pLocFile:string);
begin
  try
    oNMFTP.Download(pRemFile,pLocFile);
    oStatus:=oNMFTP.Status;
  except end;
end;

procedure TIccFtp.Upload (pLocFile,pRemFile:string);
begin
  try
    oNMFTP.Upload(pLocFile,pRemFile);
    oStatus:=oNMFTP.Status;
  except end;
end;

procedure TIccFtp.Disconnect;
begin
  try
    oNMFTP.Disconnect;
    oStatus:=oNMFTP.Status;
  except end;
  FreeAndNil(oNMFTP);
end;

end.
