unit UsrFnc;
// =============================================================================
//                   OBJEKT NA PR�CU S U��VATE�SK�MI PR�STUPMI
// -----------------------------------------------------------------------------
// Tento objekt obsahuje v�etky datab�zov� s�bory a funkcie pre pr�cu
// 1. U��vate�mi informa�n�ho syst�mu
// 2. Programov�mi modulmi a ich pr�stupov�mi pr�vami
// 3. Knihami a ich pr�stupov�mi pr�vami
//
// -----------------------------------------------------------------------------
// ************************* POU�IT� DATAB�ZOV� S�BORY *************************
// -----------------------------------------------------------------------------
// USRDAT.BTR - zoznam v�etk�ch u��vate�ov informa�n�ho syst�mu.
// USGLST.BTR - zoznam u��vate�sk� skup�n.
// BOKLST.BTR - zoznam v�etk�ch kn�h informa�n�ho syst�mu.
// LASBOK.BTR - naposledy pou�it� knihy
// USGRGH.BTR - pr�stupov� pr�va u��vate�sk�ch skup�n k modulom a ku knih�m.
// PRPLST.BTR - definicia predvolen�ch parametrov
// PMFLST.DB  - zoznam modulov, ku ktor�m zadan� u��vate� m� pr�stupov� pr�vo.
// USRLST.DB  - zoznam u��vate�ov, ktor� maj� pr�stup k modulu alebo ku knihe,
//              alebo patria do zadanej kupiny.
// BOKLST.DB  - zoznam vybran�ch kn�h pre zadan� modul, ku ktor�m zadan� u��vate�
//              m� pr�stupov� pr�vo.
// -----------------------------------------------------------------------------
// *********************** POPIS PRIVATE FUNKCI� OBJEKTU ***********************
// -----------------------------------------------------------------------------
// AddPmdDat - prid� z�znam do do�asn�ho zoznamu programov�ch modulov
//             Popis parametrov funkcie:
//             � pPmdCod - ozna�enie programov�ho modulu
//             � pPmdNam - pomenovanie programov�ho modulu
//             � pAccess - ak je TRUE do zoznamu bud� pridan� len tie moduly,
//                         ku ktor�m dan� u��vate� m� pr�stup.
// -----------------------------------------------------------------------------
// ************************ POPIS PUBLIC FUNKCI� OBJEKTU ***********************
// -----------------------------------------------------------------------------
// LodUsrDat - na��ta �daje prihl�sen�ho u��vate�a zo zonamu u��vate�ov syst�mu
//             (USRLST.BTR). Ak na��tanie bolo �spe�n� t.j. v zozname u��vate�ov
//             sa nach�dza zadan� u��vate� hodnota funkcie bude TRUE.
//
// CrtPmdLst - t�to funkcia vytvor� do�asn� datab�zov� s�bor, ktor� bu� obsahuje
//             v�etky programov� moduly informa�n�ho syst�mu, alebo len tie,
//             ktor�mu zadan� u��vate� m� pr�stupov� pr�vo.
//             Popis parametrov funkcie:
//             � pUsrLog - prihlasovacie meno u��vate�a, pre ktor�ho bude zoznam
//                         vyhotoven�.
//             � pAccess - ak je TRUE zoznam obsahuje len moduly, ku ktor�m dan�
//                         u��vate� m� pr�stup.
//
// FltUsrLst - t�to funkciu je mo�n� spusti� r�znymi parametrami na na z�klade
//             toho v�sledkom bud� r�zne zoznamy u��vate�ov.
//             � (pGrpNum) - v tomto pr�pade zoznam (USRLST.DB) bude obsahova�
//                           t�ch u��vate�ov, ktor� patria do zadanej skupiny
//             � (pPmdCod) - v tomto pr�pade zoznam (USRLST.DB) bude obsahova�
//                           len t�ch u��vate�ov, ktor� maj� pr�stup k zadan�mu
//                           modulu.
//             � (pPmdCod,pBokNum) - v tomto pr�pade zoznam (USRLST.DB) bude
//                                   obsahova� len t�ch u��vate�ov, ktor� maj�
//                                   pr�stup k zadan�mu modulu.
//
// CrtBokLst - funkcia sl��i na vyhotovenie do�asn�ho zoznamu kn�h. Zdroj �dajov
//             je datab�zov� s�bor BOKLST.BTR, z ktor�ho s� premiestnen� do do-
//             �asn�ho s�boru BOKLST.DB knihy zadan�ho programov�ho modulu, ku
//             ktor�m zadan� u��vate� m� pr�stupov� pr�vo. Ak parameter pBokLst
//             obsahuje nejak� ��sla kn�h, potom tento �daj sl��i ako redukcia
//             p�vodn�ho zoznamu pr�stupn�ch kn�h u��vate�a. Napr�klad ak u��va-
//             te� m� pr�stupov� pr�vo ku knih�m: 001,002,003,004 a parameter
//             pBokLst='001,002,005' potom datab�zov� s�bor BOKLST.DB bude obsa-
//             hova� len knihy '001,002'.
//             Popis parametrov funkcie:
//             � pUsrLog - prihlasovacie meno u��vate�a, pre ktor�ho bude zoznam
//                         vyhotoven�.
//             � pPmdCod - ozna�enie programov�ho modulu, knihy ktor�ho budeme
//                         na��tava�.
//             � pBokLst - zoznam kn�h, ktor� zredukuje pr�stupn� zoznam kn�h.
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
  hUSRLST,
  IcTypes, IcConv, IcVariab, IcTools, eUSRDAT, eUSGRGH, ePRPLST, eBOKLST, eLASBOK, tPMDLST, tBOKLST,
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Dialogs, Forms, DateUtils;

type
  TUsrFnc=class
    constructor Create;
    destructor Destroy; override;
  private
    oUsrLog:Str10;  // Prihlasovacie meno u��vate�a
    oUsrNam:Str30;  // Meno a priezvisko u��vate�a
    oUsrPsw:Str40;  // Pr�stupov� heslo u��vate�a
    oAutIdc:Str40;  // Autoidentifik�cia u��vate�a
    oGrpNum:word;   // Skupina u��vate�ov
    oDlrNum:word;   // ��seln� k��od obchodn�ho z�stupcu
    oPrsNum:word;   // Osobn� ��slo zamestnanca
    oMaxDsc:byte;   // Maximalna zlava �o m��e poskytn�� z�kazn�kovi dany uzivatel
    oEmlAdr:Str30;  // Emailov� adresa u��vate�a
    oEmlNam:Str30;  // Meno alebo popis, ktor� bude uveden� v emaile ako vlastn�k adresy
    oWpcNam:Str40;  // N�zov pracovn�ho po��ta�a
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
  If ohUSRDAT.Count=0 then begin // Prenesieme �daje zo star�ho s�boru
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
  // Na��tame �daje zadan�ho u��vate�a
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
  // -------------------------------- SYST�M -----------------------------------
  AddPmdDat(0,'SYS','Syst�mov� nastavenia',pAccess);
  AddPmdDat(0,'USM','Evidencia u��vate�ov',pAccess);
  AddPmdDat(0,'DBM','Spr�va d�tov�ch s�borov',pAccess);
  AddPmdDat(0,'PRP','Predvolen� nastavenia',pAccess);
  // ----------------------------- Z�SOBOVANIE ---------------------------------
  AddPmdDat(1,'ASM','Podmienky obstarania',pAccess);                      // REG
  AddPmdDat(1,'PSM','Dod�vate�sk� z�lohy',pAccess);                       // REG
  AddPmdDat(1,'MSM','Dod�vate�sk� ponuky',pAccess);                       // REG
  AddPmdDat(1,'OSM','Dod�vate�sk� objedn�vky',pAccess);                   // REG
  AddPmdDat(1,'KSM','Dod�vate�sk� konsign�cia',pAccess);                  // REG
  AddPmdDat(1,'TSM','Dod�vate�sk� v�dajky',pAccess);                      // REG
  AddPmdDat(1,'ISM','Dod�vate�sk� fakt�ry',pAccess);                      // REG
  AddPmdDat(1,'TIM','Termin�lov� pr�jemky',pAccess);                      // REG
  // -------------------------------- SKLAD ------------------------------------
  AddPmdDat(2,'PRO','Katal�g produktov',pAccess);
  AddPmdDat(2,'STM','Skladov� karty z�sob',pAccess);
  AddPmdDat(2,'SNM','Spr�va v�robn�ch ��siel',pAccess);                   // REG
  AddPmdDat(2,'SIM','Skladov� pr�jemky',pAccess);                         // REG
  AddPmdDat(2,'SOM','Skladov� v�dajky',pAccess);                          // REG
  AddPmdDat(2,'SRM','Skladov� presunky',pAccess);                         // REG
  AddPmdDat(2,'PKM','Prebalenie produktu',pAccess);                       // REG
  AddPmdDat(2,'CPM','Kompletiz�cia produktu',pAccess);                    // REG
  AddPmdDat(2,'__M','Priemyseln� v�roba',pAccess);                        // REG
  AddPmdDat(2,'__M','Rozobratie v�robkov',pAccess);                       // REG
  AddPmdDat(2,'IVM','Inventariz�cia skladov',pAccess);                    // REG
  // ------------------------------- SERVIS ------------------------------------
  AddPmdDat(3,'SOM','Servisn� z�kazky',pAccess);                          // REG
  AddPmdDat(3,'SCM','Evidencia opr�v',pAccess);                           // REG
  // ------------------------------- OBCHOD ------------------------------------
  AddPmdDat(4,'CPL','Predajn� cenn�ky',pAccess);                          // REG
  AddPmdDat(4,'APL','Akciov� cenn�ky',pAccess);                           // REG
  AddPmdDat(4,'TPL','Term�novan� cenn�ky',pAccess);                       // REG
  AddPmdDat(4,'RPL','Pl�novanie cien',pAccess);                           // REG
  AddPmdDat(4,'___','Prece�ovacie pokyny',pAccess);                       // REG
  AddPmdDat(4,'ACM','Podmienky predaja',pAccess);                         // REG
  AddPmdDat(4,'PCM','Odberate�sk� z�lohy',pAccess);                       // REG
  AddPmdDat(4,'MCM','Odberate�sk� ponuky',pAccess);                       // REG
  AddPmdDat(4,'OCM','Odberate�sk� objedn�vky',pAccess);                   // REG
  AddPmdDat(4,'KCM','Odberate�sk� konsign�cia',pAccess);                  // REG
  AddPmdDat(4,'TCM','Odberate�sk� v�dajky',pAccess);                      // REG
  AddPmdDat(4,'ICM','Odberate�sk� fakt�ry',pAccess);                      // REG
  AddPmdDat(4,'CAM','Pokladni�n� predaj',pAccess);                        // REG
  // ------------------------------- FINANCIE ----------------------------------
  AddPmdDat(5,'CDM','Hotovostn� poklad�a',pAccess);                       // REG
  AddPmdDat(5,'BSM','Bankov� v�pisy',pAccess);                            // REG
  AddPmdDat(5,'BTM','Prevodn� pr�kzy',pAccess);                           // REG
  // ------------------------------ ��TOVN�CTVO --------------------------------
  AddPmdDat(6,'JRM','Denn�k ��tovn�ch z�pisov',pAccess);
  AddPmdDat(6,'IDM','Intern� ��tovn� doklady',pAccess);                   // REG
  AddPmdDat(6,'VTM','Evidencia uz�vierok DPH',pAccess);                   // REG
  AddPmdDat(6,'LBM','Hlavn� kniha ��tov',pAccess);                        // REG
  AddPmdDat(6,'ARM','Legislat�vne v�kazy',pAccess);                       // REG
  // ------------------------------ MANA�MENT ----------------------------------
  AddPmdDat(7,'___','�tatistika n�kupu',pAccess);                         // REG
  AddPmdDat(7,'___','�tatistika predaja',pAccess);                        // REG
  AddPmdDat(7,'XRM','',pAccess);
  // ---------------------------- ADMINISTR�CIA --------------------------------
  AddPmdDat(8,'PAM','Evidencia partnerov',pAccess);
  AddPmdDat(8,'CRM','',pAccess);                                          // REG
  AddPmdDat(8,'ILM','Do�l� kore�pondencia',pAccess);                      // REG
  AddPmdDat(8,'OLM','Odoslan� kore�pondencia',pAccess);                   // REG
end;

procedure TUsrFnc.CrtBokLst(pUsrLog:Str10;pPmdCod:Str3;pBokLst:ShortString);
begin
end;

end.


