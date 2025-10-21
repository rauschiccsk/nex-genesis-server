unit ShmFnc;
// =============================================================================
//                           Sale History Data (SHD)
// -----------------------------------------------------------------------------
// -----------------------------------------------------------------------------
// ************************* POUŽITÉ DATABÁZOVÉ SÚBORY *************************
// -----------------------------------------------------------------------------
// SHDITM - všetky predané položky pod¾a jednotlivých dokladov. Je to základ pre
//          ïa¾šie databázové súbory.
// SHDBON - evidencia vernostných onusov
// SHDLST - základný zoznam, ktorý je zobrazený pri spustení modulu
// -----------------------------------------------------------------------------
// ********************* PARAMETRE, KTORÉ POUŽÍVA FUNKCIA **********************
// -----------------------------------------------------------------------------
// -----------------------------------------------------------------------------
// ********************************* POZNÁMKY **********************************
// -----------------------------------------------------------------------------
//
// -----------------------------------------------------------------------------
// ****************************** HISTÓRIA ZMIEN *******************************
// -----------------------------------------------------------------------------
// 20.01[03.07.17] - Nová funkcia (RZ)
// =============================================================================

interface

uses
  hPARCAT,
  IcTypes, IcConv, IcVariab, IcTools, IcDate, NexPath, NexClc, NexGlob, eSHDBON, eSHDITM, eSHDLST,
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Dialogs, Forms, DateUtils;

type
  TShdFnc=class
    constructor Create;
    destructor Destroy; override;
  private
  public
    ohPARCAT:TParcatHnd;
    ohSHDBON:TShdbonHne;  // Evidencia vydaných bónusov
    ohSHDITM:TShditmHne;  // História predaja pod¾a dokladov - položkovite
    ohSHDLST:TShdlstHne;  // História predaja pod¾a produktov

    procedure ClcParDat(pParNum:longint);
  end;

implementation

constructor TShdFnc.Create;
begin
  ohPARCAT:=TParcatHnd.Create;
  ohSHDBON:=TShdbonHne.Create;
  ohSHDITM:=TShditmHne.Create;
  ohSHDLST:=TShdlstHne.Create;
end;

destructor TShdFnc.Destroy;
begin
  FreeAndNil(ohPARCAT);
  FreeAndNil(ohSHDLST);
  FreeAndNil(ohSHDITM);
  FreeAndNil(ohSHDBON);
end;

// ******************************** PRIVATE ************************************

// ********************************* PUBLIC ************************************

procedure TShdFnc.ClcParDat(pParNum:longint);
var mPstAva,mPsaAva,mPsaBva,mPreAva,mPreBva,mPdcAva,mPdcBva:double;
    mAstAva,mAsaAva,mAsaBva,mAreAva,mAreBva,mAdcAva,mAdcBva:double;
    mFirDte,mLasDte,mFyeDte:TDate; mItmQnt:longint;
begin
  If not ohSHDLST.LocParNum(pParNum) then begin
    ohSHDLST.Insert;
    If ohPARCAT.LocParNum(pParNum) then begin
      ohSHDLST.ParNam:=ohPARCAT.ParNam;
      ohSHDLST.BonCnv:=ohPARCAT.BonCnv;
      ohSHDLST.BonClc:=ohPARCAT.BonClc;
    end else begin
      ohSHDLST.ParNam:='NEIDENTIFIKOVATE¼NÝ ODBERATE¼';
    end;
    ohSHDLST.Post;
  end;
  // ---------------------------------------------------------------------------

end;

end.


