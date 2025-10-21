unit FtpSnd;
// *****************************************************************************
// Popis: Tento objekt ulozi zadany subor na FTP
// *****************************************************************************
interface

uses
  IcVariab, IcTypes, IcConv, IcConst, IcTools, NexPath, NexIni, FtpCom,
  Controls, ExtCtrls, Classes, StdCtrls, Buttons, Windows, Messages,
  SysUtils, Graphics, Forms, Dialogs, ComCtrls, LangForm, IcLabels, DB,
  BtrTable, NexBtrTable, IcProc;

type
  TFtpSnd = class(TLangForm)
    Image1: TImage;
    IcProcess1: TIcProcess;
    Timer: TTimer;
    L_Status: TCenterLabel;
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormCreate(Sender: TObject);
  private
    oFtp: TFtpCom; // FTP komunikacny unit
    oSuccess: boolean;       // TRUE ak prenos bol uspesny
    oFilePath: ShortString;  // Adresar kde je ulozeny textovy subor
    oFileName: ShortString;  // Nazov textoveho suboru
    oFtpHost: ShortString;    // Host FTP server
    oFtpUser: ShortString;    // Prihlasovanice meno na FTP server
    oFtpPasw: ShortString;    // Pristupove heslo na FTP server
    oFtpPath: ShortString;    // Adresat na FTP servery
    procedure FtpConnect;    // Pripoji sa na FTP
    procedure FtpUpload;     // Ulozi subor na FTP
    procedure FtpDownLoad(pFileMask:ShortString);   // Nacita subory z FTP
    procedure FtpDisconnect; // Odpoji sa z FTP
    procedure ShowStatus (pText:ShortString);
  public
    procedure SendFileToFtp (pFileName:ShortString);
    procedure LoadFilesFromFtp (pFileMask:ShortString); // Nacita prijemky zadanej knihy
  published
    property Success:boolean read oSuccess;
    property FtpHost:ShortString write oFtpHost;
    property FtpUser:ShortString write oFtpUser;
    property FtpPasw:ShortString write oFtpPasw;
    property FtpPath:ShortString write oFtpPath;
  end;

implementation

uses
  DM_SYSTEM;

{$R *.DFM}

procedure TFtpSnd.FormCreate(Sender: TObject);
begin
  Show;
  Application.ProcessMessages;
  oFtpHost := '';    // Host FTP server
  oFtpUser := '';    // Prihlasovanice meno na FTP server
  oFtpPasw := '';    // Pristupove heslo na FTP server
  oFtpPath := 'ONLINE';    // Adresat na FTP servery
  oFilePath := gIni.GetZipPath;
  oFtp := TFtpCom.Create;
end;

procedure TFtpSnd.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  FreeAndNil (oFtp);
  Hide;
end;

procedure TFtpSnd.SendFileToFtp (pFileName:ShortString);
begin
  oFileName := pFileName;
  If FileExists (oFilePath+oFileName) then begin
    FtpConnect;    // Pripoji sa na FTP
    FtpUpload;     // Ulozi subor na FTP
    FtpDisconnect; // Odpoji sa z FTP
  end;
end;

procedure TFtpSnd.LoadFilesFromFtp (pFileMask:ShortString); // Nacita prijemky zadanej knihy
begin
  FtpConnect;    // Pripoji sa na FTP
  FtpDownload (pFileMask);   // Ulozi subor na FTP
  FtpDisconnect; // Odpoji sa z FTP
end;

// ************************* PRIVATE *******************************

procedure TFtpSnd.FtpConnect; // Pripoji sa na FTP
var mFtpHost,mFtpRoot:ShortString;  mPos:byte;
begin
  // Ak nie su z vonku zadane parametre FTP servera nacitame vlastne
  If oFtpHost='' then begin
    oFtpHost := dmSYS.btSYSTEM.FieldByName ('FtpHost').AsString;
    oFtpUser := dmSYS.btSYSTEM.FieldByName ('FtpUser').AsString;
    oFtpPasw := dmSYS.btSYSTEM.FieldByName ('FtpPasw').AsString;
  end;
  // Pripojime sa na FTP server
  mPos := Pos('/',oFtpHost);
  If mPos>0 then begin
    mFtpHost := copy (oFtpHost,1,mPos-1);
    mFtpRoot := copy (oFtpHost,mPos+1,Length(oFtpHost)-mPos);
  end
  else begin
    mFtpHost := oFtpHost;
    mFtpRoot := '';
  end;
  // Connect na FTP
  oFtp.TargetHost := mFtpHost;
  oFtp.UserName := oFtpUser;
  oFtp.Password := oFtpPasw;
  ShowStatus ('Pripája sa k '+oFtp.TargetHost);
  try
    If oFtp.Login then begin
      ShowStatus ('Pripojené k '+oFtp.TargetHost);
      oFtp.ChangeWorkingDir(mFtpRoot);
    end
    else ShowStatus ('FTP pripojenie nebolo úspešné');
  except end;
end;

procedure TFtpSnd.FtpUpload;  // Ulozi udaje na FTP
var mFtpDir:ShortString; mCnt:byte;  mSuccess:boolean;
begin
  try
    If oFtpPath<>'' then oFtp.ChangeWorkingDir(oFtpPath);
    mFtpDir := oFtp.GetCurrentDir;
    If Pos('/'+oFtpPath,mFtpDir)=0 then begin // Ak neexsituje adresar vytvorime
      oFtp.CreateDir(oFtpPath);
      oFtp.ChangeWorkingDir(oFtpPath);
    end;
    oFtp.DirectFile := TRUE;
    oFtp.DirectFileName := oFilePath+oFileName;
    mCnt := 0;  oSuccess := FALSE;
    Repeat
      Inc (mCnt);
      oSuccess := oFtp.StoreFile(oFileName,FALSE);
    until oSuccess or (mCnt=5);
    If oSuccess then DeleteFile (oFilePath+oFileName);
  finally
    oFtp.ChangeWorkingDir('..');
  end;
end;

procedure TFtpSnd.FtpDownLoad(pFileMask:ShortString); // Nacita udaje z FTP
var mFileName:ShortString; I,mCnt:word;   mExist:boolean;
    mFileCount:longint;  mMaskLen:byte;
begin
  try
    mMaskLen := Length (pFileMask);
    oFtp.ChangeWorkingDir('ONLINE');
    oFtp.ReadFileList;
    mFileCount := oFtp.FileCount;
    If mFileCount>0 then begin
      For I:=0 to mFileCount-1 do begin
        mFileName := oFtp.FileList[I];
        If copy(mFileName,1,mMaskLen)=pFileMask then begin // Najdeny subor vyhovuje zadanej maske
          ShowStatus ('Prijímam subor: '+mFileName);
          try
            mCnt := 0;
            Repeat
              Inc (mCnt);
              oFtp.Download (mFileName,oFilePath+mFileName); // Download
              mExist := FileExists (oFilePath+mFileName);
            until mExist or (mCnt>10);
            If mExist then oFtp.DeleteFile(mFileName);
          except end;
        end;
      end;
    end;
    oFtp.ChangeWorkingDir('..');
  except end;
end;

procedure TFtpSnd.FtpDisconnect; // Odpoji sa z FTP
begin
  try
    ShowStatus ('Odpája sa od'+oFtp.TargetHost);
    If oFtp.Logout
      then ShowStatus ('Odpojenie bolo úspešne vykonané')
      else ShowStatus ('Chyba pri odpojení');
  except end;
end;

procedure TFtpSnd.ShowStatus (pText:ShortString);
begin
  L_Status.Caption := pText;
  Application.ProcessMessages;
end;

end.
