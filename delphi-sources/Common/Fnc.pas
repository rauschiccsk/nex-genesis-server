unit Fnc;
{$F+}
// *****************************************************************************
// **********                        FUNKCIE                          **********
// *****************************************************************************
interface

uses
  IcTypes, IcConv, IcTools, IcVariab, IniFiles, SysUtils,
  Dat, Gsf, Pcf, Stf, Tof, Mcf, Forms;

type
  TFnc=class
    constructor Create;
    destructor Destroy; override;
    private
    public
      oDat:TDat;
      oGsf:TGsf;
      oPcf:TPcf;
      oStf:TStf;
      oTof:TTof;
      oMcf:TMcf;
    published
  end;

implementation

constructor TFnc.Create;
begin
  oDat:=TDat.Create;
  oGsf:=TGsf.Create(oDat);
  oPcf:=TPcf.Create(oDat);
  oStf:=TStf.Create(oDat);
  oMcf:=TMcf.Create(oDat);

  oTof:=TTof.Create(oDat,oStf);
end;

destructor TFnc.Destroy;
begin
  FreeAndNil(oTof);

  FreeAndNil(oMcf);
  FreeAndNil(oStf);
  FreeAndNil(oPcf);
  FreeAndNil(oGsf);
  FreeAndNil(oDat);
end;
// ********************************* PRIVATE ***********************************
// ********************************** PUBLIC ***********************************
end.

// ******************************** �TRUKT�RA **********************************
TDat - TSyd -
     - TPad - TPacDat
     - TGsd - TGscDat(GSCAT.BTR)
            - TBacDat(BARCODE.BTR)
            - TStd - TStcDat(STKnnnnn.BTR)
                   - TStmDat(STMnnnnn.BTR)
                   - TStoDat(STOnnnnn.BTR)
                   - TStsDat(STSnnnnn.BTR)
                   - TFifDat(FIFnnnnn.BTR)
            - TPld - TPlcDat(PLSnnnnn.BTR)
                   - TPlhDat(STKnnnnn.BTR)
     - TAcd - TAcdDat
     - TDod -

TFnc - TGsf - Funkcie na pr�cu s tovarov�mi polo�kami
     - TPcf - Funkcie na pr�cu s predajn�mi cenami
     - TStf - Funkcie na pr�cu so skladovou z�sobou


