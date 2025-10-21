unit Dat;
{$F+}
// *****************************************************************************
// **********              OBJEKT NA PR�Cu S DATAB�ZAMI               **********
// *****************************************************************************
interface

uses
  IcTypes, IcConv, IcTools, IcVariab, IniFiles, SysUtils, NexGlob,
  Pad, Gsd, Dod,
  NexPath, NexIni, Forms;

type
  TDat=class
    constructor Create;
    destructor Destroy; override;
    private
    public
      oPad:TPad;  // Datab�zov� s�bory partnerov
      oGsd:TGsd;  // Datab�zov� s�bory tovarov
      oDod:TDod;  // Datab�zov� s�bory dokladov
    published
  end;

implementation

constructor TDat.Create;
begin
  oPad:=TPad.Create;
  oGsd:=TGsd.Create;
  oDod:=TDod.Create;
end;

destructor TDat.Destroy;
begin
  FreeAndNil(oDod);
  FreeAndNil(oGsd);
  FreeAndNil(oPad);
end;

// ********************************* PRIVATE ***********************************

// ********************************** PUBLIC ***********************************

end.
