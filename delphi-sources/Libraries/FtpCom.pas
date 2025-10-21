unit FtpCom;

interface

uses
  FtpSend,
  IcTypes, IcConv, IcTools, SysUtils, Classes;

type
  TFtpCom = class (TFtpSend)
    constructor Create;
    destructor  Destroy; override;
    private
      oFileCount: word;  // Pocet suborov va katualnom adresare po prikazu ReadFileList
      oFileList: TStrings;
    public
      function Download (pRemoteFile,pLocalFile:string):boolean;  // Nahravanie udajov na FTP server
      function Upload (pLocalFile,pRemoteFile:string):boolean;   // Nacitanie udajov z FTP serveru
      // pRemoteFile - nazov vzdialeneho suboru na FTP servery
      // pLocalFile - nazov lokalneho suboru na miestnom disku
      procedure ReadFileList;
    published
      property FileCount:word read oFileCount;
      property FileList:TStrings read  oFileList;
  end;

implementation

constructor TFtpCom.Create;
begin
  inherited ;
  oFileList := TStringList.Create;
end;

destructor TFtpCom.Destroy;
begin
  FreeAndNil (oFileList);
  inherited ;
end;

function TFtpCom.Download (pRemoteFile,pLocalFile:string):boolean;  // Nahravanie udajov na FTP server do aktualneho adresara
begin
  DirectFileName := pLocalFile;
  DirectFile := TRUE;
  Result := RetrieveFile(pRemoteFile, FALSE);
end;

function TFtpCom.Upload (pLocalFile,pRemoteFile:string):boolean;   // Nacitanie udajov z FTP serveru z aktualneho adresara
begin
 DirectFileName := pLocalFile;
 DirectFile := TRUE;
 Result := StoreFile(pRemoteFile, FALSE);
end;

procedure TFtpCom.ReadFileList;
var mFtpListRec:TFtpListRec; I:word;
begin
  oFileCount := 0;
  oFileList.Clear;
  List('',FALSE);
  If FtpList.List.Count>0 then begin
    For I:=0 to FtpList.List.Count-1 do begin
      mFtpListRec := FtpList.List.Items[I];
      If not mFtpListRec.Directory then begin
        Inc (oFileCount);
        oFileList.Add (mFtpListRec.FileName);
      end;
    end;
  end;
end;

end.
