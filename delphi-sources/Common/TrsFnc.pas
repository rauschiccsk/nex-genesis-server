unit TrsFnc;
// =============================================================================
//                        PL�NOVAC� KALEND�R ROZVOZU
// -----------------------------------------------------------------------------
//                       
// -----------------------------------------------------------------------------
//
//
// -----------------------------------------------------------------------------
// ************************* POU�IT� DATAB�ZOV� S�BORY *************************
// -----------------------------------------------------------------------------
// TRSPLS.BTR - Pl�novac� kalend�r rozvozu
// -----------------------------------------------------------------------------
// ********************* PARAMETRE, KTOR� POU��VA FUNKCIA **********************
// -----------------------------------------------------------------------------
//
// -----------------------------------------------------------------------------
// ********************************* POZN�MKY **********************************
// -----------------------------------------------------------------------------
//
// -----------------------------------------------------------------------------
// ****************************** HIST�RIA ZMIEN *******************************
// -----------------------------------------------------------------------------
// 20.01[__.__.17] -
// =============================================================================
interface

uses
  IcTypes, IcConv, IcVariab, IcTools, IcDate, Nexpath, NexClc, NexGlob, StkGlob, Prp, eTRSLIN, eTRSPLN,
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Dialogs, Forms, DateUtils;

type
  TTrsFnc=class
    constructor Create;
    destructor Destroy; override;
  private
  public
    ohTRSLIN:TTrslinHne;  // Zoznam smerov rozvozu
    ohTRSPLN:TTrsplnHne;  // Pl�novac� kalend�r rozvozu
    function GetTrsDte(pActDte:TDateTime;pTrsLin:byte;pPrvSch:boolean):TDateTime; // Hodnotou funkcie je najbli��� d�tum rozvozu od zadan�ho d�tumu pre zadan� smer
  end;

implementation

constructor TTrsFnc.Create;
begin
  ohTRSLIN:=TTrslinHne.Create;
  ohTRSPLN:=TTrsplnHne.Create;
end;

destructor TTrsFnc.Destroy;
begin
  FreeAndNil(ohTRSPLN);
  FreeAndNil(ohTRSLIN);
end;

// ******************************** PRIVATE ************************************

// ********************************* PUBLIC ************************************

function TTrsFnc.GetTrsDte(pActDte:TDateTime;pTrsLin:byte;pPrvSch:boolean):TDateTime; // Hodnotou funkcie je najbli��� d�tum rozvozu od zadan�ho d�tumu pre zadan� smer
var mY,mM,mD,mMth,mDay:word; mFind,mAbort:boolean; mDate:TDate;
begin
  Result:=0;
  DecodeDate(pActDte,mY,mM,mD);
  If ohTRSPLN.LocTyTmTl(mY,mM,pTrsLin) then begin
    mFind:=FALSE; mMth:=mM; mDay:=mD;
    If pPrvSch then begin // Hlad�me term�n pred zadan�m d�tumom
      mAbort:=FALSE;
      Repeat
        Repeat
          mDate:=EncodeDate(mY,mMth,mDay);
          mAbort:=(mDate<=Date+1);
          mFind:=ohTRSPLN.Table.FieldByName('TrsD'+StrIntZero(mDay,2)).AsString='X';
          If not mFind then Dec(mDay);
        until (mDay=0) or mAbort or mFind;
        If not mFind and not mAbort then begin
          Dec(mMth);
          mDay:=MonthLastDay(mY,mMth);
          ohTRSPLN.LocTyTmTl(mY,mMth,pTrsLin);
        end;
      until (mMth=0) or mAbort or mFind;
      If mFind
        then Result:=EncodeDate(mY,mMth,mDay)
        else pPrvSch:=FALSE; // Ak sme nena�li h�ad�me nesk�r�� d�tum ne� zadan�
    end;
    If not pPrvSch then begin
      Repeat
        Repeat
          Inc(mDay);
          If mDay<=31 then mFind:=ohTRSPLN.Table.FieldByName('TrsD'+StrIntZero(mDay,2)).AsString='X';
        until (mDay>=31) or mFind;
        If not mFind then begin
          mDay:=0;
          Inc(mMth);
          ohTRSPLN.LocTyTmTl(mY,mMth,pTrsLin);
        end;
      until (mMth=13) or mFind;
      If mFind then Result:=EncodeDate(mY,mMth,mDay);
    end;
  end;
end;

end.


