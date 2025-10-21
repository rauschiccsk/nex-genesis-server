unit OtpFnc;
// =============================================================================
//                     PROTOKOLY O ZMENEN�CH TERM�NOCH
// =============================================================================
// ********************** POPIS JEDNOTLIV�CH FUNKCII ***************************
// -----------------------------------------------------------------------------
// AddNewDoc - prid� nov� protokol do zoznamu
//             pOsdNum - ��slo dod�vate�skej objedn�vky
//             pDocDes - Textov� popis dokladu
//
// AddNewItm - prid� z�kazkov� polo�ky a hlavi�ku z�kazky do protokolu. Ulo��
//             �daje pred zmenou term�nu a n�sledne prepo��ta kumulat�vne �daje
//             z�kazky a protokolu.
//             pDocNum - Intern� ��slo protokolu
//             pOciAdr - Fyzick� adresa
//
// AddModItm - do existuj�cej z�kazkovej polo�ky protokolu prid� �daje, ktor�
//             vznikli po zmenenom term�ne
//             pDocNum - Intern� ��slo protokolu
//             pOciAdr - Fyzick� adresa
// -----------------------------------------------------------------------------
// ************************* POU�IT� DATAB�ZOV� S�BORY *************************
// -----------------------------------------------------------------------------
// OTPLST.BTR - zoznam protokolov o zmenen�ch term�noch dod�vok
// OTPOCD.BTR - zoznam z�kazkov�ch dokladov, v ktor�ch zmena term�nu dod�vky
//              vyvolal probl�m
// OTPOCI.BTR - zoznam polo�iek z�kazkov�ch dokladov, u ktor�ch zmena term�nu
//              dod�vky vyvolal probl�m
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
// 20.01[03.07.17] - Nov� funkcia (RZ)
// =============================================================================

interface

uses
  IcTypes, IcConv, IcVariab, IcTools, Nexpath, NexClc, NexGlob, StkGlob, Prp, eOTPLST, eOTPOCH, eOTPOCI,
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Dialogs, Forms, DateUtils;

type
  TOtpFnc=class
    constructor Create;
    destructor Destroy; override;
  private
  public
    ohOTPLST:TOtplstHne;  // Zoznam protokolov o zmenen�ch term�noch dod�vok
    ohOTPOCH:TOtpochHne;  // Zoznam z�kazkov�ch dokladov jednotliv�ch protokolov
    ohOTPOCI:TOtpociHne;  // Zoznam polo�iek z�kazkov�ch dokladov jednotliv�ch protokolov
    procedure AddNewDoc(pOsdNum:Str12;pDocDes:Str100);
    procedure AddNewItm(pDocNum:Str12;pOciAdr:longint);
    procedure AddModItm(pDocNum:Str12;pOciAdr:longint);
  end;

implementation

constructor TArdFnc.Create;
begin
  ohOTPLST:=TOtplstHne.Create;
  ohOTPOCH:=TOtpochHne.Create;
  ohOTPOCI:=TOtpociHne.Create;
end;

destructor TArdFnc.Destroy;
begin
  FreeAndNil(ohOTPOCI);
  FreeAndNil(ohOTPOCH);
  FreeAndNil(ohOTPLST);
end;

// ******************************** PRIVATE ************************************

// ********************************* PUBLIC ************************************

procedure TArdFnc.AddNewDoc(pOsdNum:Str12;pDocDes:Str100);
begin
end;

procedure TArdFnc.AddNewItm(pDocNum:Str12;pOciAdr:longint);
begin
end;

procedure TArdFnc.AddModItm(pDocNum:Str12;pOciAdr:longint);
begin
end;

end.


