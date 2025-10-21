unit Gsf;
{$F+}
// *****************************************************************************
// **********               FUNKCIE NA PR�CU S TOVARMI                **********
// *****************************************************************************
interface

uses
  IcTypes, IcConv, IcTools, IcVariab, IniFiles, SysUtils, NexGlob, Dat,
  NexPath, NexIni, Forms;

type
  TGsf=class
    constructor Create(pDat:TDat);
    destructor Destroy; override;
    private
    public
      oDat:TDat;
      procedure AddBac(pGsCode:longint;pBaCode:Str15);  // Prid� identifika�n� k�d do podk�dov
    published
  end;

implementation

constructor TGsf.Create(pDat:TDat);
begin
  oDat:=pDat;
end;

destructor TGsf.Destroy;
begin
end;

// ********************************* PRIVATE ***********************************

// ********************************** PUBLIC ***********************************

procedure TGsf.AddBac(pGsCode:longint;pBaCode:Str15);  // Prid� identifika�n� k�d do podk�dov
begin
  With oDat do begin
    oGsd.OpenGSC;
    oGsd.OpenBAC;
    If not oGsd.LocBaCode(pBaCode) then begin
      oGsd.ohBAC.Insert;
      oGsd.ohBAC.GsCode:=pGsCode;
      oGsd.ohBAC.BarCode:=pBaCode;
      oGsd.ohBAC.Post;
    end;
  end;
end;

end.
