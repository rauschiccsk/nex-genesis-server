unit DapFnc;
// =============================================================================
//                       APLIKOVANÉ PROCESY NAD DOKLADMI
// =============================================================================
// ********************** POPIS JEDNOTLIVÝCH FUNKCII ***************************
// -----------------------------------------------------------------------------
//
// -----------------------------------------------------------------------------
// ************************ POUŽITÉ DATABÁZOVÉ SÚBORY **************************
// -----------------------------------------------------------------------------
// DOCAPP.BTR - zoznam aplikovaných procesov nad dokladmi
// -----------------------------------------------------------------------------
// ********************* PARAMETRE, KTORÉ POUŽÍVA FUNKCIA **********************
// -----------------------------------------------------------------------------
//
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
  IcTypes, IcConv, IcVariab, IcTools, Nexpath, NexClc, NexGlob, StkGlob, Prp, BasUtilsTCP, eDOCAPP,
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Dialogs, Forms, DateUtils;

type
  TDapFnc=class
    constructor Create;
    destructor Destroy; override;
  private
  public
    oDocNum:Str12;
    oUsrLog:Str8;
    oUsrNam:Str30;
    oDapDte:TDate;
    oDapTim:TTime;
    oProces:Str1;
    ohDOCAPP:TDocAppHne;
    procedure Add(pDocTyp:Str2;pDocNum:Str12;pUsrLog:Str8;pUsrNam:Str30;pDteTim:TDateTime;pProces:Str1);
    function Loc(pDocTyp:Str2;pDocNum:Str12;pProces:Str1):boolean; // Najde zadaný proces

    property DocNum:Str12 read oDocNum;
    property UsrLog:Str8 read oUsrLog;
    property UsrNam:Str30 read oUsrNam;
    property DapDte:TDate read oDapDte;
    property DapTim:TTime read oDapTim;
    property Proces:Str1 read oProces;
  end;

implementation

constructor TDapFnc.Create;
begin
  ohDOCAPP:=TDocappHne.Create;
end;

destructor TDapFnc.Destroy;
begin
  FreeAndNil(ohDOCAPP);
end;

// ******************************** PRIVATE ************************************

// ********************************* PUBLIC ************************************

procedure TDapFnc.Add(pDocTyp:Str2;pDocNum:Str12;pUsrLog:Str8;pUsrNam:Str30;pDteTim:TDateTime;pProces:Str1);
begin
  ohDOCAPP.Insert;
  ohDOCAPP.DocTyp:=pDocTyp;
  ohDOCAPP.DocNum:=pDocNum;
  ohDOCAPP.Proces:=pProces;
  ohDOCAPP.DapSig:=EncodeB64(pDocNum+zUS+pUsrLog+zUS+pUsrNam+zUS+FloatToArrayS(pDteTim)+zUS+pProces,1);
  ohDOCAPP.Post;
end;

function TDapFnc.Loc(pDocTyp:Str2;pDocNum:Str12;pProces:Str1):boolean; // Najde zadaný proces
var mLine:Str100; mDteTim:TDateTime;
begin
  oDocNum:=''; oUsrLog:=''; oUsrNam:=''; oDapDte:=0; oDapTim:=0;
  If ohDOCAPP.LocDtDaPr(pDocTyp,pDocNum,pProces) then begin
    mLine:=DecodeB64(ohDOCAPP.DapSig,1);
    oDocNum:=LineElement(mLine,1,zUS);
    oUsrLog:=LineElement(mLine,2,zUS);
    oUsrNam:=LineElement(mLine,3,zUS);
    mDteTim:=ArraySToFloat(LineElement(mLine,4,zUS));
    oProces:=LineElement(mLine,5,zUS);
    oDapDte:=mDteTim;
    oDapTim:=mDteTim;
  end;
end;

end.


