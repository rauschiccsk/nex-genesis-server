unit ShmFnc;
// =============================================================================
//                           Sale History Data (SHD)
// -----------------------------------------------------------------------------
// -----------------------------------------------------------------------------
// ************************* POU�IT� DATAB�ZOV� S�BORY *************************
// -----------------------------------------------------------------------------
// SHDITM - v�etky predan� polo�ky pod�a jednotliv�ch dokladov. Je to z�klad pre
//          �a��ie datab�zov� s�bory.
// SHDBON - evidencia vernostn�ch onusov
// SHDLST - z�kladn� zoznam, ktor� je zobrazen� pri spusten� modulu
// -----------------------------------------------------------------------------
// ********************* PARAMETRE, KTOR� POU��VA FUNKCIA **********************
// -----------------------------------------------------------------------------
// -----------------------------------------------------------------------------
// ********************************* POZN�MKY **********************************
// -----------------------------------------------------------------------------
//
// -----------------------------------------------------------------------------
// ****************************** HIST�RIA ZMIEN *******************************
// -----------------------------------------------------------------------------
// 20.01[03.07.17] - Nov� funkcia (RZ)
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
    ohSHDBON:TShdbonHne;  // Evidencia vydan�ch b�nusov
    ohSHDITM:TShditmHne;  // Hist�ria predaja pod�a dokladov - polo�kovite
    ohSHDLST:TShdlstHne;  // Hist�ria predaja pod�a produktov

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
      ohSHDLST.ParNam:='NEIDENTIFIKOVATE�N� ODBERATE�';
    end;
    ohSHDLST.Post;
  end;
  // ---------------------------------------------------------------------------

end;

end.


