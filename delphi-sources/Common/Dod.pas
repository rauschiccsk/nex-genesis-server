unit Dod;
{$F+}
// *****************************************************************************
// **********               DATABÁZOVÉ SÚBORY DOKLADOV                **********
// *****************************************************************************
interface

uses
  IcTypes, IcConv, IcTools, IcVariab, IniFiles, SysUtils, NexGlob,
  Tov, Mcv, //Ocv,
  NexPath, NexIni, Forms;

type
  TDod=class
    constructor Create;
    destructor Destroy; override;
    private
    public
      oTod:TTov;
//      oOcd:TOcv;
      oMcd:TMcv;
    published
  end;

implementation

constructor TDod.Create;
begin
  oTod:=TTov.Create;
//  oOcd:=TOcv.Create;
  oMcd:=TMcv.Create;
end;

destructor TDod.Destroy;
begin
  FreeAndNil(oMcd);
//  FreeAndNil(oOcd);
  FreeAndNil(oTod);
end;
// ********************************* PRIVATE ***********************************
// ********************************** PUBLIC ***********************************
end.
