unit Lpd;
{$F+}

// *****************************************************************************
//                           LABEL PRINT DOCUMENTS
// *****************************************************************************

interface

uses
  IcTypes, IcConst, IcConv, IcTools, IcVariab, NexGlob, NexPath,
  BtrHand, ComCtrls, SysUtils, Classes, Forms;

type
  TLpd=class(TComponent)
    constructor Create(AOwner: TComponent);
    destructor Destroy; override;
    private
      oSrvPath:ShortString;
    public
      procedure Save(pPlsNum:word;pGsCode:longint);
    published
  end;

implementation

constructor TLpd.Create(AOwner: TComponent);
begin
  oSrvPath:=gPath.SrvPath;
end;

destructor TLpd.Destroy;
begin
  //
end;

// ********************************* PRIVATE ***********************************

// ********************************** PUBLIC ***********************************

procedure TLpd.Save(pPlsNum:word;pGsCode:longint);
var mFile:TStrings; mName:Str8;
begin
  If not DirectoryExists(oSrvPath) then ForceDirectories(oSrvPath);
  mName:='L'+StrIntZero(pGsCode,7);
  mFile:=TStringList.Create;
  mFile.Add('[LAB]');
  mFile.Add('PlsNum='+StrInt(pPlsNum,0));
  mFile.Add('GsCode='+StrInt(pGsCode,0));
  mFile.SaveToFile(oSrvPath+mName+'.$$$');
  FreeAndNil(mFile);
  RenameFile(oSrvPath+mName+'.$$$',oSrvPath+mName+'.LAB');
end;

end.


