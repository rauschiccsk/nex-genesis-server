unit IcConst;

interface

uses
  Windows,SysUtils,Graphics;

const
  NONE = -1;

  VK_0 = $30;    VK_A = $41;    VK_K = $4B;    VK_U = $55;
  VK_1 = $31;    VK_B = $42;    VK_L = $4C;    VK_V = $56;
  VK_2 = $32;    VK_C = $43;    VK_M = $4D;    VK_W = $57;
  VK_3 = $33;    VK_D = $44;    VK_N = $4E;    VK_X = $58;
  VK_4 = $34;    VK_E = $45;    VK_O = $4F;    VK_Y = $59;
  VK_5 = $35;    VK_F = $46;    VK_P = $50;    VK_Z = $5A;
  VK_6 = $36;    VK_G = $47;    VK_Q = $51;
  VK_7 = $37;    VK_H = $48;    VK_R = $52;
  VK_8 = $38;    VK_I = $49;    VK_S = $53;
  VK_9 = $39;    VK_J = $4A;    VK_T = $54;

  cAdd=1;  cMod=2;

  cColorC =clBlack;
  cColorE =clBlue;
  cColorP =clGreen;
  cColorI =clRed;
(*
  cCas =  1; // Maloobchodny predaj
  cMcb =  2; // Odberatelske cenove ponuky
  cOcb =  3; // Odberatelske objednavky
  cTcb =  4; // Odberatelske dodacie listy
  cIcb =  5; // Odberatelske faktury
  cOsb =  6; // Dodavatelske objednavky
  cTsb =  7; // Dodavatelske dodacie listy
  cIsb =  8; // Dodavatelske faktury
  cScb =  9; // Servisne zakazky
  cOwb = 10; // Vyuctovanie sluzobje cesty
*)
  dtIM =  1; // Interne skladove prijemky
  dtOM =  2; // Interne skladove vydajky
  dtRM =  3; // Medziskladove presuny
  dtPK =  4; // Manualne prebalenie tovaru
  dtMS =  5; // Dodavatelske cenove ponuky
  dtOS =  6; // Dodavatelske objednavky
  dtTS =  7; // Dodavatelske dodacie listy
  dtIS =  8; // Dodavatelske faktury
  dtMC =  9; // Odberatelske cenove ponuky
  dtOC = 10; // Odberatelske objednavky
  dtTC = 11; // Odberatelske dodacie listy
  dtIC = 12; // Odberatelske faktury
  dtCS = 13; // Hotovostne pokladnicne doklady
  dtSO = 14; // Bankove vypisy
  dtID = 15; // Interne uctovne doklady
  dtSV = 16; // Faktura za zalohu
  dtMI = 17; // Prijemka MTZ
  dtMO = 18; // Vydajka MTZ
  dtCM = 19; // Kompletizacia vyrobkov
  dtSA = 20; // Skladove vydajky MO perdaja
  dtSC = 21; // Servisné zákazky
  dtOW = 22; // Doklad vyuctovania sluzobnej cesty
  dtUD = 23; // Univerzalny odbytovy doklad
  dtCD = 24; // Vyrobny doklad
  dtTO = 25; // Terminalova skladova vydajka
  dtTI = 26; // Terminalova skladova prijemka
  dtAM = 27; // Cenová ponuka prenájmu
  dtAO = 28; // Zákazkový doklad prenájmu
  dtAL = 29; // Zápožièný doklad prenájmu
  dtPO = 30; // Pozicna skladova vydajka
  dtPI = 31; // Pozicna skladova prijemka
  dtKS = 32; // Komisonalne vysporiadanie
  dtDM = 33; // Rozobratie
  dtPS = 34; // Planovanie objednavok
  dtAC = 35; // Akciove precenenie
  dtPQ = 36; // Prevodne prikazy
  dtDP = 37; // Postupene pohladavky
  dtDI = 38; // Postupene pohladavky FA

  dtStdId = 0; // Bezny uctovny doklad
  dtBegId = 1; // Otvorenie suvahovych uctov
  dtEndId = 9; // Uzatvorenie uctov


  cChDosToChWin: array [0..18] of byte =  (0,1,2,77,128,129,130,
    134, 136, 161, 162, 163, 177, 178, 186, 204, 222, 238,255);
  cMainHead = 'Report designer';
  cRepPath:string = 'c:\b\';

// pocty riadkov v ktorych su ulozene parametre kopirovanych komponentov
  cLabelLineCount  = 26;
  cDBTextLineCount = 29;
  cExprLineCount   = 30;
  cSysdataLineCount= 28;
  cMemoLineCount   = 26;  // + Memo lines + 4
  cShapeLineCount  = 21;
  cImageLineCount  = 19;
  cDBImageLineCount= 21;
  cChartLineCount  = 21;
  cBarCodeLineCount= 20;

  cUserRepLevel: byte = 5;
  cFirmaName: string = 'IdentCode Consulting s.r.o.';
  cUserName:string = 'ADMIN';
  cMainPrivPath:string = '';
  cSubPrivPath:string = '';
  cPrintDemo:boolean = FALSE;
  cPrintAbout:boolean = TRUE;
  cAbout:string = '';
  cLogNexWork:boolean = TRUE;
  cBokNumOnBokOpen:boolean=False;
  // ci pre zistenie cisla knihy dokaldu aktualneho roka treba vyhladat aktualny doklad
  // tak ze sa otvori kniha dokladov a najde sa doklad (ak je FALSE tak sa nastavi kniha A-bbb)

implementation

end.
{MOD 1904011}

