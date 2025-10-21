unit Dat;
{$F+}
// *****************************************************************************
// **********              OBJEKT NA PRÁCu S DATABÁZAMI               **********
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
      oPad:TPad;  // Databázové súbory partnerov
      oGsd:TGsd;  // Databázové súbory tovarov
      oDod:TDod;  // Databázové súbory dokladov
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
