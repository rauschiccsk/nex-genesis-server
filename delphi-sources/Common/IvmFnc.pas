unit IvmFnc;
// *****************************************************************************
//                    FUNKCIE INVENTARIZAÈNÉHO MODULU
// *****************************************************************************
// *****************************************************************************

interface

uses
  IcTypes, IcConv, IcVariab, IcTools, IcDate, Prp, NexPath, EmdHnd, Cnt, eIVMIVD, eIVMIVI, eIVMSHD, eIVMSHI, tIVMSHI,
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Dialogs, Forms, DateUtils;

type
  TIvmFnc=class
    constructor Create;
    destructor Destroy; override;
  private
  public
    oActBok:Str3;         // Aktuálna kniha dokladov
    ohIVMIVD:TIvmivdHne;
    ohIVMIVI:TIvmiviHne;
    ohIVMSHD:TIvmshdHne;
    ohIVMSHI:TIvmshiHne;
    otIVMSHI:TIvmshiTmp;
    property ActBok:Str3 read oActBok write oActBok;     // Aktuálna kniha dokladov
  end;

implementation

// ********************************** OBJECT ***********************************

constructor TIvmFnc.Create;
begin
  ohIVMIVD:=TIvmivdHne.Create;
  ohIVMIVI:=TIvmiviHne.Create;
  ohIVMSHD:=TIvmshdHne.Create;
  ohIVMSHI:=TIvmshiHne.Create;
  otIVMSHI:=TIvmshiTmp.Create;
end;

destructor TIvmFnc.Destroy;
begin
  FreeAndNil(ohIVMIVD);
  FreeAndNil(ohIVMIVI);
  FreeAndNil(ohIVMSHD);
  FreeAndNil(ohIVMSHI);
  FreeAndNil(otIVMSHI);
end;

// ******************************** PRIVATE ************************************

// ******************************** PUBLIC *************************************

end.


