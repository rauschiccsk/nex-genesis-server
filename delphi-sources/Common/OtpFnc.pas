unit OtpFnc;
// =============================================================================
//                     PROTOKOLY O ZMENENÝCH TERMÍNOCH
// =============================================================================
// ********************** POPIS JEDNOTLIVÝCH FUNKCII ***************************
// -----------------------------------------------------------------------------
// AddNewDoc - pridá nový protokol do zoznamu
//             pOsdNum - Èíslo dodávate¾skej objednávky
//             pDocDes - Textový popis dokladu
//
// AddNewItm - pridá zákazkovú položky a hlavièku zákazky do protokolu. Uloží
//             údaje pred zmenou termínu a následne prepoèíta kumulatívne údaje
//             zákazky a protokolu.
//             pDocNum - Interné èíslo protokolu
//             pOciAdr - Fyzická adresa
//
// AddModItm - do existujúcej zákazkovej položky protokolu pridá údaje, ktoré
//             vznikli po zmenenom termíne
//             pDocNum - Interné èíslo protokolu
//             pOciAdr - Fyzická adresa
// -----------------------------------------------------------------------------
// ************************* POUŽITÉ DATABÁZOVÉ SÚBORY *************************
// -----------------------------------------------------------------------------
// OTPLST.BTR - zoznam protokolov o zmenených termínoch dodávok
// OTPOCD.BTR - zoznam zákazkových dokladov, v ktorých zmena termínu dodávky
//              vyvolal problém
// OTPOCI.BTR - zoznam položiek zákazkových dokladov, u ktorých zmena termínu
//              dodávky vyvolal problém
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
  IcTypes, IcConv, IcVariab, IcTools, Nexpath, NexClc, NexGlob, StkGlob, Prp, eOTPLST, eOTPOCH, eOTPOCI,
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Dialogs, Forms, DateUtils;

type
  TOtpFnc=class
    constructor Create;
    destructor Destroy; override;
  private
  public
    ohOTPLST:TOtplstHne;  // Zoznam protokolov o zmenených termínoch dodávok
    ohOTPOCH:TOtpochHne;  // Zoznam zákazkových dokladov jednotlivých protokolov
    ohOTPOCI:TOtpociHne;  // Zoznam položiek zákazkových dokladov jednotlivých protokolov
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


