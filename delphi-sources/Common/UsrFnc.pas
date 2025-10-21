unit UsrFnc;
// =============================================================================
//                   OBJEKT NA PRÁCU S UÍVATE¼SKİMI PRÍSTUPMI
// -----------------------------------------------------------------------------
// Tento objekt obsahuje všetky databázové súbory a funkcie pre prácu
// 1. Uívate¾mi informaèného systému
// 2. Programovımi modulmi a ich prístupovımi právami
// 3. Knihami a ich prístupovımi právami
//
// -----------------------------------------------------------------------------
// ************************* POUITÉ DATABÁZOVÉ SÚBORY *************************
// -----------------------------------------------------------------------------
// USRDAT.BTR - zoznam všetkıch uívate¾ov informaèného systému.
// USGLST.BTR - zoznam uívate¾skı skupín.
// BOKLST.BTR - zoznam všetkıch kníh informaèného systému.
// LASBOK.BTR - naposledy pouité knihy
// USGRGH.BTR - prístupové práva uívate¾skıch skupín k modulom a ku knihám.
// PRPLST.BTR - definicia predvolenıch parametrov
// PMFLST.DB  - zoznam modulov, ku ktorım zadanı uívate¾ má prístupové právo.
// USRLST.DB  - zoznam uívate¾ov, ktoré majú prístup k modulu alebo ku knihe,
//              alebo patria do zadanej kupiny.
// BOKLST.DB  - zoznam vybranıch kníh pre zadanı modul, ku ktorım zadanı uívate¾
//              má prístupové právo.
// -----------------------------------------------------------------------------
// *********************** POPIS PRIVATE FUNKCIÍ OBJEKTU ***********************
// -----------------------------------------------------------------------------
// AddPmdDat - pridá záznam do doèasného zoznamu programovıch modulov
//             Popis parametrov funkcie:
//             › pPmdCod - oznaèenie programového modulu
//             › pPmdNam - pomenovanie programového modulu
//             › pAccess - ak je TRUE do zoznamu budú pridané len tie moduly,
//                         ku ktorım danı uívate¾ má prístup.
// -----------------------------------------------------------------------------
// ************************ POPIS PUBLIC FUNKCIÍ OBJEKTU ***********************
// -----------------------------------------------------------------------------
// LodUsrDat - naèíta údaje prihláseného uívate¾a zo zonamu uívate¾ov systému
//             (USRLST.BTR). Ak naèítanie bolo úspešné t.j. v zozname uívate¾ov
//             sa nachádza zadanı uívate¾ hodnota funkcie bude TRUE.
//
// CrtPmdLst - táto funkcia vytvorí doèasnı databázovı súbor, ktorı buï obsahuje
//             všetky programové moduly informaèného systému, alebo len tie,
//             ktorému zadanı uívate¾ má prístupové právo.
//             Popis parametrov funkcie:
//             › pUsrLog - prihlasovacie meno uívate¾a, pre ktorého bude zoznam
//                         vyhotovenı.
//             › pAccess - ak je TRUE zoznam obsahuje len moduly, ku ktorım danı
//                         uívate¾ má prístup.
//
// FltUsrLst - túto funkciu je moné spusti rôznymi parametrami na na základe
//             toho vısledkom budú rôzne zoznamy uívate¾ov.
//             › (pGrpNum) - v tomto prípade zoznam (USRLST.DB) bude obsahova
//                           tıch uívate¾ov, ktoré patria do zadanej skupiny
//             › (pPmdCod) - v tomto prípade zoznam (USRLST.DB) bude obsahova
//                           len tıch uívate¾ov, ktoré majú prístup k zadanému
//                           modulu.
//             › (pPmdCod,pBokNum) - v tomto prípade zoznam (USRLST.DB) bude
//                                   obsahova len tıch uívate¾ov, ktoré majú
//                                   prístup k zadanému modulu.
//
// CrtBokLst - funkcia slúi na vyhotovenie doèasného zoznamu kníh. Zdroj údajov
//             je databázovı súbor BOKLST.BTR, z ktorého sú premiestnené do do-
//             èasného súboru BOKLST.DB knihy zadaného programového modulu, ku
//             ktorım zadanı uívate¾ má prístupové právo. Ak parameter pBokLst
//             obsahuje nejaké èísla kníh, potom tento údaj slúi ako redukcia
//             pôvodného zoznamu prístupnıch kníh uívate¾a. Napríklad ak uíva-
//             te¾ má prístupové právo ku knihám: 001,002,003,004 a parameter
//             pBokLst='001,002,005' potom databázovı súbor BOKLST.DB bude obsa-
//             hova len knihy '001,002'.
//             Popis parametrov funkcie:
//             › pUsrLog - prihlasovacie meno uívate¾a, pre ktorého bude zoznam
//                         vyhotovenı.
//             › pPmdCod - oznaèenie programového modulu, knihy ktorého budeme
//                         naèítava.
//             › pBokLst - zoznam kníh, ktorı zredukuje prístupnı zoznam kníh.
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
  hUSRLST,
  IcTypes, IcConv, IcVariab, IcTools, eUSRDAT, eUSGRGH, ePRPLST, eBOKLST, eLASBOK, tPMDLST, tBOKLST,
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Dialogs, Forms, DateUtils;

type
  TUsrFnc=class
    constructor Create;
    destructor Destroy; override;
  private
    oUsrLog:Str10;  // Prihlasovacie meno uívate¾a
    oUsrNam:Str30;  // Meno a priezvisko uívate¾a
    oUsrPsw:Str40;  // Prístupové heslo uívate¾a
    oAutIdc:Str40;  // Autoidentifikácia uívate¾a
    oGrpNum:word;   // Skupina uívate¾ov
    oDlrNum:word;   // Èíselnı k´´od obchodného zástupcu
    oPrsNum:word;   // Osobné èíslo zamestnanca
    oMaxDsc:byte;   // Maximalna zlava èo môe poskytnú zákazníkovi dany uzivatel
    oEmlAdr:Str30;  // Emailová adresa uívate¾a
    oEmlNam:Str30;  // Meno alebo popis, ktorı bude uvedenı v emaile ako vlastník adresy
    oWpcNam:Str40;  // Názov pracovného poèítaèa
    procedure AddPmdDat(pSysNum:byte;pPmdCod:Str3;pPmdNam:Str50;pAccess:boolean);
  public
    ohUSRDAT:TUsrdatHne;
    ohUSGRGH:TUsgrghHne;
    ohBOKLST:TBoklstHne;
    ohPRPLST:TPrplstHne;
    ohLASBOK:TLasbokHne;

    otPMDLST:TPmdlstTmp;
    otBOKLST:TBoklstTmp;

    function LodUsrDat(pUsrLog:Str10):boolean;
    function GetLasBok(pPmdCod:Str3):Str3;
    procedure SavLasBok(pPmdCod,pBokNum:Str3);

    procedure FltBokLst(pPmdCod:Str3);

    procedure FltUsrLst(pGrpNum:word); overload;
    procedure FltUsrLst(pPmdCod:Str3); overload;
    procedure FltUsrLst(pPmdCod,pBokNum:Str3); overload;

    procedure CrtPmdLst(pUsrLog:Str10;pAccess:boolean);
    procedure CrtBokLst(pUsrLog:Str10;pPmdCod:Str3;pBokLst:ShortString);

  published
    property UsrLog:Str10 read oUsrLog write oUsrLog;
    property UsrNam:Str30 read oUsrNam write oUsrNam;
    property UsrPsw:Str40 read oUsrPsw write oUsrPsw;
    property AutIdc:Str40 read oAutIdc write oAutIdc;
    property GrpNum:word read oGrpNum write oGrpNum;
    property DlrNum:word read oDlrNum write oDlrNum;
    property PrsNum:word read oPrsNum write oPrsNum;
    property MaxDsc:byte read oMaxDsc write oMaxDsc;
    property EmlAdr:Str30 read oEmlAdr write oEmlAdr;
    property EmlNam:Str30 read oEmlNam write oEmlNam;
    property WpcNam:Str40 read oWpcNam write oWpcNam;
  end;

var gUsr:TUsrFnc;

implementation

// ********************************* OBJECT ************************************

constructor TUsrFnc.Create;
begin
  ohUSRDAT:=TUsrdatHne.Create;
  ohUSGRGH:=TUsgrghHne.Create;
  ohBOKLST:=TBoklstHne.Create;
  ohPRPLST:=TPrplstHne.Create;
  ohLASBOK:=TLasbokHne.Create;

  otBOKLST:=TBoklstTmp.Create;
end;

destructor TUsrFnc.Destroy;
begin
  FreeAndNil(ohUSRDAT);
  FreeAndNil(ohUSGRGH);
  FreeAndNil(ohBOKLST);
  FreeAndNil(ohPRPLST);
  FreeAndNil(ohLASBOK);

  FreeAndNil(otBOKLST);
end;

// ******************************** PRIVATE ************************************

procedure TUsrFnc.AddPmdDat(pSysNum:byte;pPmdCod:Str3;pPmdNam:Str50;pAccess:boolean);
begin
  otPMDLST.Insert;
  otPMDLST.SysNum:=pSysNum;
  otPMDLST.PmdCod:=pPmdCod;
  otPMDLST.PmdNam:=pPmdNam;
//  otPMDLST.Access:=pAccess;
  otPMDLST.Post;
end;

// ********************************* PUBLIC ************************************

function TUsrFnc.LodUsrDat(pUsrLog:Str10):boolean;
var mhUSRLST:TUsrlstHnd;
begin
  If ohUSRDAT.Count=0 then begin // Prenesieme údaje zo starého súboru
    mhUSRLST:=TUsrlstHnd.Create; mhUSRLST.Open;
    mhUSRLST.First;
    Repeat
      ohUSRDAT.Insert;
      ohUSRDAT.UsrLog:=mhUSRLST.LoginName;
      ohUSRDAT.UsrNam:=mhUSRLST.UserName;
      ohUSRDAT.UsrOwn:=mhUSRLST.LoginOwnr;
      ohUSRDAT.UsrLng:=mhUSRLST.Language;
      ohUSRDAT.UsrTyp:=2;
      ohUSRDAT.UsrLev:=mhUSRLST.UsrLev;
      ohUSRDAT.GrpNum:=mhUSRLST.GrpNum;
      ohUSRDAT.DlrNum:=mhUSRLST.DlrCode;
      ohUSRDAT.PrsNum:=mhUSRLST.UsrNum;
      ohUSRDAT.MaxDsc:=mhUSRLST.MaxDsc;
      ohUSRDAT.Post;
      Application.ProcessMessages;
      mhUSRLST.Next;
    until mhUSRLST.Eof;
    FreeAndNil(mhUSRLST);
  end;
  // Naèítame údaje zadaného uívate¾a
  Result:=ohUSRDAT.LocUsrLog(pUsrLog);
  If Result then begin
    oUsrLog:=ohUSRDAT.UsrLog;
    oUsrNam:=ohUSRDAT.UsrNam;
    oUsrPsw:=ohUSRDAT.UsrOwn;
    oAutIdc:=ohUSRDAT.AutIdc;
    oGrpNum:=ohUSRDAT.GrpNum;
    oDlrNum:=ohUSRDAT.DlrNum;
    oPrsNum:=ohUSRDAT.PrsNum;
    oMaxDsc:=ohUSRDAT.MaxDsc;
    oEmlAdr:=ohUSRDAT.EmlNam;
    oEmlNam:=ohUSRDAT.EmlAdr;
    oWpcNam:=ohUSRDAT.WpcNam;
  end;
end;

function TUsrFnc.GetLasBok(pPmdCod:Str3):Str3;
begin
  Result:='';
  If ohLASBOK.LocUlPc(oUsrLog,pPmdCod) then Result:=ohLASBOK.BokNum;
end;

procedure TUsrFnc.SavLasBok(pPmdCod,pBokNum:Str3);
begin
  If ohLASBOK.LocUlPc(oUsrLog,pPmdCod) then begin
    ohLASBOK.Edit;
    ohLASBOK.BokNum:=pBokNum;
    ohLASBOK.Post;
  end else begin
    ohLASBOK.Insert;
    ohLASBOK.UsrLog:=oUsrLog;
    ohLASBOK.PmdCod:=pPmdCod;
    ohLASBOK.BokNum:=pBokNum;
    ohLASBOK.Post;
  end;
end;

procedure TUsrFnc.FltBokLst(pPmdCod:Str3);
begin
  ohBOKLST.SwapIndex;
  ohBOKLST.SetIndex('PmdCod');
  ohBOKLST.Table.ClearFilter;
  ohBOKLST.Table.Filter:='['+ohBOKLST.FieldNum('PmdCod')+']={'+pPmdCod+'}';
  ohBOKLST.Table.Filtered:=TRUE;
  ohBOKLST.RestIndex;
end;

procedure TUsrFnc.FltUsrLst(pGrpNum:word);
begin
end;

procedure TUsrFnc.FltUsrLst(pPmdCod:Str3);
begin
end;

procedure TUsrFnc.FltUsrLst(pPmdCod,pBokNum:Str3);
begin
end;

procedure TUsrFnc.CrtPmdLst(pUsrLog:Str10;pAccess:boolean);
begin
  // -------------------------------- SYSTÉM -----------------------------------
  AddPmdDat(0,'SYS','Systémové nastavenia',pAccess);
  AddPmdDat(0,'USM','Evidencia uívate¾ov',pAccess);
  AddPmdDat(0,'DBM','Správa dátovıch súborov',pAccess);
  AddPmdDat(0,'PRP','Predvolené nastavenia',pAccess);
  // ----------------------------- ZÁSOBOVANIE ---------------------------------
  AddPmdDat(1,'ASM','Podmienky obstarania',pAccess);                      // REG
  AddPmdDat(1,'PSM','Dodávate¾ské zálohy',pAccess);                       // REG
  AddPmdDat(1,'MSM','Dodávate¾ské ponuky',pAccess);                       // REG
  AddPmdDat(1,'OSM','Dodávate¾ské objednávky',pAccess);                   // REG
  AddPmdDat(1,'KSM','Dodávate¾ská konsignácia',pAccess);                  // REG
  AddPmdDat(1,'TSM','Dodávate¾ské vıdajky',pAccess);                      // REG
  AddPmdDat(1,'ISM','Dodávate¾ské faktúry',pAccess);                      // REG
  AddPmdDat(1,'TIM','Terminálové príjemky',pAccess);                      // REG
  // -------------------------------- SKLAD ------------------------------------
  AddPmdDat(2,'PRO','Katalóg produktov',pAccess);
  AddPmdDat(2,'STM','Skladové karty zásob',pAccess);
  AddPmdDat(2,'SNM','Správa vırobnıch èísiel',pAccess);                   // REG
  AddPmdDat(2,'SIM','Skladové príjemky',pAccess);                         // REG
  AddPmdDat(2,'SOM','Skladové vıdajky',pAccess);                          // REG
  AddPmdDat(2,'SRM','Skladové presunky',pAccess);                         // REG
  AddPmdDat(2,'PKM','Prebalenie produktu',pAccess);                       // REG
  AddPmdDat(2,'CPM','Kompletizácia produktu',pAccess);                    // REG
  AddPmdDat(2,'__M','Priemyselná vıroba',pAccess);                        // REG
  AddPmdDat(2,'__M','Rozobratie vırobkov',pAccess);                       // REG
  AddPmdDat(2,'IVM','Inventarizácia skladov',pAccess);                    // REG
  // ------------------------------- SERVIS ------------------------------------
  AddPmdDat(3,'SOM','Servisné zákazky',pAccess);                          // REG
  AddPmdDat(3,'SCM','Evidencia opráv',pAccess);                           // REG
  // ------------------------------- OBCHOD ------------------------------------
  AddPmdDat(4,'CPL','Predajné cenníky',pAccess);                          // REG
  AddPmdDat(4,'APL','Akciové cenníky',pAccess);                           // REG
  AddPmdDat(4,'TPL','Termínované cenníky',pAccess);                       // REG
  AddPmdDat(4,'RPL','Plánovanie cien',pAccess);                           // REG
  AddPmdDat(4,'___','Preceòovacie pokyny',pAccess);                       // REG
  AddPmdDat(4,'ACM','Podmienky predaja',pAccess);                         // REG
  AddPmdDat(4,'PCM','Odberate¾ské zálohy',pAccess);                       // REG
  AddPmdDat(4,'MCM','Odberate¾ské ponuky',pAccess);                       // REG
  AddPmdDat(4,'OCM','Odberate¾ské objednávky',pAccess);                   // REG
  AddPmdDat(4,'KCM','Odberate¾ská konsignácia',pAccess);                  // REG
  AddPmdDat(4,'TCM','Odberate¾ské vıdajky',pAccess);                      // REG
  AddPmdDat(4,'ICM','Odberate¾ské faktúry',pAccess);                      // REG
  AddPmdDat(4,'CAM','Pokladniènı predaj',pAccess);                        // REG
  // ------------------------------- FINANCIE ----------------------------------
  AddPmdDat(5,'CDM','Hotovostná pokladòa',pAccess);                       // REG
  AddPmdDat(5,'BSM','Bankové vıpisy',pAccess);                            // REG
  AddPmdDat(5,'BTM','Prevodné príkzy',pAccess);                           // REG
  // ------------------------------ ÚÈTOVNÍCTVO --------------------------------
  AddPmdDat(6,'JRM','Denník úètovnıch zápisov',pAccess);
  AddPmdDat(6,'IDM','Interné úètovné doklady',pAccess);                   // REG
  AddPmdDat(6,'VTM','Evidencia uzávierok DPH',pAccess);                   // REG
  AddPmdDat(6,'LBM','Hlavná kniha úètov',pAccess);                        // REG
  AddPmdDat(6,'ARM','Legislatívne vıkazy',pAccess);                       // REG
  // ------------------------------ MANAMENT ----------------------------------
  AddPmdDat(7,'___','Štatistika nákupu',pAccess);                         // REG
  AddPmdDat(7,'___','Štatistika predaja',pAccess);                        // REG
  AddPmdDat(7,'XRM','',pAccess);
  // ---------------------------- ADMINISTRÁCIA --------------------------------
  AddPmdDat(8,'PAM','Evidencia partnerov',pAccess);
  AddPmdDat(8,'CRM','',pAccess);                                          // REG
  AddPmdDat(8,'ILM','Došlá korešpondencia',pAccess);                      // REG
  AddPmdDat(8,'OLM','Odoslaná korešpondencia',pAccess);                   // REG
end;

procedure TUsrFnc.CrtBokLst(pUsrLog:Str10;pPmdCod:Str3;pBokLst:ShortString);
begin
end;

end.


