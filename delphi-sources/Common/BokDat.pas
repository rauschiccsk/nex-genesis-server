unit BokDat;
// =============================================================================
//                         OBJEKT NA PR�CU S KNIHAMI
// -----------------------------------------------------------------------------
// T�to funkcia pre vybran� invent�rny doklad vykon� nasledovn� oper�cie:
// 1. Zo skladu vybran�ho dokladu vytvor� samostatn� invent�rny h�rok pre
//    ka�d� skladov� poz�ciu (skladov� k�d polo�ky).
// 2. Do ka�d�ho invent�rneho h�rku ulo�� polo�ky, ktor� maj� skladov� poz�ciu
//    dan�ho invent�rneho h�rku.
// 3. Pre polo�ky, ktor� nemaj� skladov� poz�ciu t.j. skladov� k�d je pr�zdny
//    syst�m vytvor� samostatn� invent�rny h�rok pod n�zovm "BEZ POZ�CIE"
//
// -----------------------------------------------------------------------------
// ************************* POU�IT� DATAB�ZOV� S�BORY *************************
// -----------------------------------------------------------------------------
// BOKLST.BTR - zoznam v�etk�ch kn�h informa�n�ho syst�mu
// BOKLST.DB  - zoznam vybran�ch kn�h pre zadan� programov� modul, ku ktor�m
//              zadan� u��vate� m� pr�stupov� pr�vo
// -----------------------------------------------------------------------------
// ************************** POPIS FUNKCI� OBJEKTU ****************************
// -----------------------------------------------------------------------------
// CrtBokLst - funkcia sl��i na vyhotovenie do�asn�ho zoznamu kn�h. Zdroj �dajov
//             je datab�zov� s�bor BOKLST.BTR, z ktor�ho s� premiestnen� do do-
//             �asn�ho s�boru BOKLST.DB knihy zadan�ho programov�ho modulu, ku
//             ktor�m zadan� u��vate� m� pr�stupov� pr�vo. Ak parameter pBokLst
//             obsahuje nejak� ��sla kn�h, potom tento �daj sl��i ako redukcia
//             p�vodn�ho zoznamu pr�stupn�ch kn�h u��vate�a. Napr�klad ak u��va-
//             te� m� pr�stupov� pr�vo ku knih�m: 001,002,003,004 a parameter
//             pBokLst='001,002,005' potom datab�zov� s�bor BOKLST.DB bude obsa-
//             hova� len knihy '001,002'.
//             Popis parametrof funkcie:
//              - pUsrLog - prihlasovacie meno u��vate�a, pre ktor�ho bude vyho-
//                          toven� zoznam kn�h.
//              - pPmdCod - ozna�enie programov�ho modulu, knihy ktor�ho budeme
//                          na��tava�.
//              - pBokLst - zoznam kn�h, ktor� zredukuje pr�stupn� zoznam kn�h.
// -----------------------------------------------------------------------------
// ********************************* POZN�MKY **********************************
// -----------------------------------------------------------------------------
//
// -----------------------------------------------------------------------------
// ****************************** HIST�RIA ZMIEN *******************************
// -----------------------------------------------------------------------------
// 21.03[24.12.2018] - Nov� funkcia (RZ)
// =============================================================================

interface

uses
  IcTypes, IcConv, IcVariab, IcTools, eBOKLST, tBOKLST,
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Dialogs, Forms, DateUtils;

type
  TBokDat=class
    constructor Create;
    destructor Destroy; override;
  private
  public
    ohBOKLST:TBoklsthHne;  // Zoznam v�etk�ch kn�h informa�n�ho syst�mu
    otBOKLST:TBoklsthTmp;  // Vybran� knihy pre zadan� modul a pre u��vate�a
    procedure CrtBokLst(pUsrLog:Str10;pPmdCod:Str3;pBokLst:ShortString);
  end;

implementation

// ********************************* OBJECT ************************************

constructor TBokDat.Create;
begin
  ohBOKLST:=TBoklstHne.Create;
  otBOKLST:=TBoklstTmp.Create;
end;

destructor TBokDat.Destroy;
begin
  FreeAndNil(otBOKLST);
  FreeAndNil(ohBOKLST);
end;

// ******************************** PRIVATE ************************************

// ********************************* PUBLIC ************************************

end.


