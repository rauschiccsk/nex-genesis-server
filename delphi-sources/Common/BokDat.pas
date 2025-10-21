unit BokDat;
// =============================================================================
//                         OBJEKT NA PRÁCU S KNIHAMI
// -----------------------------------------------------------------------------
// Táto funkcia pre vybranı inventúrny doklad vykoná nasledovné operácie:
// 1. Zo skladu vybraného dokladu vytvorí samostatnı inventúrny hárok pre
//    kadú skladovú pozíciu (skladovı kód poloky).
// 2. Do kadého inventúrneho hárku uloí poloky, ktoré majú skladovú pozíciu
//    daného inventúrneho hárku.
// 3. Pre poloky, ktoré nemajú skladovú pozíciu t.j. skladovı kód je prázdny
//    systém vytvorí samostatnı inventúrny hárok pod názovm "BEZ POZÍCIE"
//
// -----------------------------------------------------------------------------
// ************************* POUITÉ DATABÁZOVÉ SÚBORY *************************
// -----------------------------------------------------------------------------
// BOKLST.BTR - zoznam všetkıch kníh informaèného systému
// BOKLST.DB  - zoznam vybranıch kníh pre zadanı programovı modul, ku ktorım
//              zadanı uívate¾ má prístupové právo
// -----------------------------------------------------------------------------
// ************************** POPIS FUNKCIÍ OBJEKTU ****************************
// -----------------------------------------------------------------------------
// CrtBokLst - funkcia slúi na vyhotovenie doèasného zoznamu kníh. Zdroj údajov
//             je databázovı súbor BOKLST.BTR, z ktorého sú premiestnené do do-
//             èasného súboru BOKLST.DB knihy zadaného programového modulu, ku
//             ktorım zadanı uívate¾ má prístupové právo. Ak parameter pBokLst
//             obsahuje nejaké èísla kníh, potom tento údaj slúi ako redukcia
//             pôvodného zoznamu prístupnıch kníh uívate¾a. Napríklad ak uíva-
//             te¾ má prístupové právo ku knihám: 001,002,003,004 a parameter
//             pBokLst='001,002,005' potom databázovı súbor BOKLST.DB bude obsa-
//             hova len knihy '001,002'.
//             Popis parametrof funkcie:
//              - pUsrLog - prihlasovacie meno uívate¾a, pre ktorého bude vyho-
//                          tovenı zoznam kníh.
//              - pPmdCod - oznaèenie programového modulu, knihy ktorého budeme
//                          naèítava.
//              - pBokLst - zoznam kníh, ktorı zredukuje prístupnı zoznam kníh.
// -----------------------------------------------------------------------------
// ********************************* POZNÁMKY **********************************
// -----------------------------------------------------------------------------
//
// -----------------------------------------------------------------------------
// ****************************** HISTÓRIA ZMIEN *******************************
// -----------------------------------------------------------------------------
// 21.03[24.12.2018] - Nová funkcia (RZ)
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
    ohBOKLST:TBoklsthHne;  // Zoznam všetkıch kníh informaèného systému
    otBOKLST:TBoklsthTmp;  // Vybrané knihy pre zadanı modul a pre uívate¾a
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


