00 - Syst�mov� prostriedky (Syst�m) [SYS]
01 - Serverov� aplik�cie (Servere) [SRV]
02 - Administrat�vna �innos� (Sekret�r) [ADM]
03 - Skladov� hospod�rstvo (Sklad) [STK]
04 - Z�sobovanie skladov (Z�sobovanie) [BUY]
05 - Obchodn� �innos� (Obchod) [SAL]
06 - Predajn� �innos� (Predaj) [SAL]
07 - Servisn� �innos� (Servis) [SEV]
08 - V�robn� �innos� (V�roba) [PRO]
09 - Ekonomika a ��tovanie (Ekonomika) [ECO]
10 - Riadenie podniku (Mana�ment) [MAN]

// Obr�zky
   imBut -
   imMnu - ikony do menu
   imMod - ikony programov�ch modulov
   im

// Chronologia tvorby programov
Spr_F
Scm_F
Ivd_ItmEdi
Key_WhsEdi
Tes_TrmEdi *
Tes_TrmLst
Ccm_DocCop
Ocb_DepPay
Pls_PlcEdi
Tcb_ExpCls *
Stk_DivVer
Gsc_FgcEdi
Sob_PayMov
Agm_AgdEdi
Agm_AgrEdi
Agm_DocDel
Brg_BacEdi
Crd_BonDef
Crd_BonEdi
Crd_ModBon
Crd_MovLst
Doc_AccPer
Exp_MrpDat
Exp_TcdEdo
Gsc_CrpCpy
Gsc_IntDel
Icb_HedVer
Sob_DocFlt
Imp_CtyDef
Imp_CtyLst
Imp_PdnDef
Ksb_KsiEdi
Mcb_DocDsc
Mcm_CpyAgm
Xrm_DocEdi
Usd_AfcAgm
Tom_CusTrn
Sta_SupSal
Stc_BpcRef
Pam_CbtLst

// Importy
        Sys_ImpGsc_F
        Pls_TxtImp_F.pas
        Tcb_WgdImp_F.pas
        Sys_ImpTps_F.pas
        Sys_ImpPls_F.pas
        Sys_ImpPac_F.pas
        Sys_ImpGsc_F.pas
        Sys_ImpBac_F.pas *
        Sys_ImpApl_F.pas
        Sys_ImpAnl_F.pas
        Stk_TxtImp_F.pas
        Spe_TxtImp_F.pas
        Rpl_ImpPls_F.pas
        Rpl_ImpNew_F.pas
        Rpl_ImpDef_F.pas
        Rpl_ImpDat_F.pas
        Pls_TxtImp_F.pas
        Pls_MfdImp_F.pas
        Pab_ImpFrTxt_F.pas
        Omb_WgdImp_F.pas
        Ivd_IvdImp_F.pas
        Imb_ImpCsv_F.pas
        Idb_ImpItm_F.pas
        Gsc_TxtImp_F.pas
        Gsc_AfcImp_F.pas
        Dsc_ImpFgc_F.pas
        Bcs_ImpGsc_F.pas
        Aqo_ImpGsc_F.pas
        Aqo_ImpCpd_F.pas
        Acb_ImpAci_F.pas
        WgdImp_F.pas
        SrbImp_F.pas
        Pob_TodImp_F.pas
        Imp_SofJrn.pas
        Imp_MinMax_F.pas
        Imp_GscNot_F.pas
        Imb_ImpDoc_F.pas
        BciImp_F.pas

        Osb_ImpDoc_F.pas
        Ocb_ShpImp_F.pas
        Bcs_ImpEpl_F.pas
        Tsb_ImpDoc_F.pas
        Imp_SofDat.pas
        Bcs_ImpEpl_F.pas
        Icb_ImpCsg.pas

// Vzorov� formul�re
        Agr_AgdLst    // Zoznam z�kazn�ckych zml�v
        Pab_LimBlc    // N�kupn� limit a platobn� discipl�na
        Osq_ItmInf    // Polo�ka dod8vate�skej objedn�vky
        Mcb_MinAcq_F  // Minimaliz�ia vstupn�ch n�kladov
        Owb_OwhEdit_F // Hlavicka cestovn�ho pr�kazu
        Asc_DocEdi_F  // Anal�za z�v�zkov a poh�ad�vok
        Mcb_DocEdi    // Hlavicka cenovych ponuk
        Asc_DocDel_F  // Zru�i� vybran� v�kaz                                   !
        Dsp_ItmEdi_F  // Pridat nov� v�nimku
        Emc_MsgEdi_F  //
        UsrPsw_F      // Nastavenie hesla
        OsbBcs_F      // Automatick� generovanei objednavok
        AttLst_V      // Zoznam pr�loh
        Pls_RefGen_F

// Bazova evidenca
Gsc_F - B�zov� evidencia tovaru
        // Upravy
        Gsc_GscEdit_F  // Evidencna karta tovaru
        Gsc_ItmEdi_F   // Eviden�n� karta tovaru
        Gsc_ImgEdi_F   // Obr�zky k tovarovej polo�ke
        Gsc_GscDel_F   // Zrusenie vybraneho tovaru
        Gsc_AddImg_F   // Prida� obr�zok k tovaru                               DEL
        Gsc_GsLang_F   // Preklad do inych jazykov
        // Zobrazit
        Gsc_ItmInfo_F  // Informacia o vybranom tovare
        Gsc_MgLst_V    // Zoznam tovarovych skupin
        Gsc_FgLst_V    // Zoznam financnych skupin
        Gsc_SgLst_V    // Zoznam �pecifika�n�ch skupin
        Gsc_GscAna_V   // Zoznam doplnkovych nazvov
        Gsc_GscMod_V   // Hist�ria zmeny �dajov
        Gsc_GslDel_V   // Zoznam zru�en�ch polo�iek
        Gsc_GslDis_V   // Zoznam vyraden�ch polo�iek
        Gsc_PckLst_V   // Zoznam vratn�ch obalov
        Gsc_GpcLst_V   // Zoznam obalov�ch tovarov
        Gsc_WgsLst_V   // Zoznam v�hov�ch tovarov
        Gsc_MgTree_V   // Stromov� �trukt�ra skup�n
        Stk_StcLst_V   // Z�soba v jednotliv�ch skladoch
        Stk_SpaLst_V   // Dod�vatelia vybranej polo�ky
        Stk_CpaLst_V   // Odberatelia vybranej polo�ky
        Stk_SapLst_V   // Ceny z predajn�ch cenn�kov
        Gsc_OcdLst_V   // Nevybavene zakazky zo vsetkych skladov
        Stk_OsdLst_V   // Nedodan� dod�vate�sk� OBJ
        Stk_ActStp_V   // Zoznam neodp�san�ch v�robn�ch ��siel
        Stk_AllStp_V   // Zoznam v�etk�ch v�robn�ch ��siel
        Gsc_CraLst_V   // Zoznam prepravkov�ch tovarov
        Gsc_GscLnk_V   // Pr�slu�enstv� k tovarovej polo�ke
        // Nastroje
        Gsc_GscFilt_F  // Filtrovanie tovarovych kariet
        !Gsc_GscFilt_V // Filtrova� tovarov� polo�ky
        Gsc_BcSrch_F   // Hladat podla identifikacneho kodu
        Gsc_NaSrch_F   // H�ada� pod�a �asti n�zvu
        Gsc_NusGsc_F   // Nepouzite tovarove polozky
        Gsc_TxtExp_F   // Export do textov�ho s�boru
        Gsc_IbcGen_F   // Generovat interny ciarovy kod
        Gsc_DivSet_F   // Hromadn� nastavenie delite�nosti
        Gsc_MinMax_F   // Nastavenie skladov�ch normat�vov
        Sys_ImpGsc_F   // Import evidencii tovaru
        Sys_ImpBac_F   // Import druhotn�ch k�dov
        Imp_GscNot_F   // Import pozn�mok k tovarom
        Gsc_BacExp_F   // Export internych ciarovych kodov
        Gsc_SndShp_F   // Odosla� vybran� kartu na Web
        // Udrzba
        Gsc_Sending_F  // Posla� evidenciu tovaru na FTP                        DEL
        Gsc_BacDup_F   // H�ada� duplicitn� identifika�n� k�dy
        Gsc_BacLos_F   // H�ada� straten� druhotn� k�dy
        Gsc_PlsCpr_F   // Porovn�vanie s predajn�m cenn�kom
        Gsc_GsnSrc_F   // Vytvori� n�zvov� vyh�ad�va�
        // Servis
        Gsc_BacGen_F   // Generovat interny ciarovy kod
        Gsc_KeyGen_F   // Generovat vyhlad�vacie kluce
        Gsc_VatChg_F   // Zmena sadzby DPH
        Gsc_ReNum_F    // Pre��slovanie tovaru
        Gsc_RefGen_F   // Posla� identifikacne kody do pokladne
        Gsc_LinRef_F   // Obnova poslednej nakupnej ceny

Pab_F - Evidencia obchodn�ch partnerov
         // Upravy
        Pab_PacEdit_F  // Evidencna karta partnera
        Pab_PacCopy_V  // Kopirovanie firmy do inej knihy
        // Zobrazit
        Pab_DisPa_V    // Zoznam vyraden�ch firiem
        Pab_PagPa_V    // Zoznam firiem pod�a skup�n
        Pab_PaBacc_V   // Bankove ucty vybranej firmy
        Pab_BacDir_V   // Bankove ucty vsetkych fieriem
        Pab_WpaLst_V   // Zoznam prevadzkovych jednotiek
        // Nastroje
        Pab_StaLst_V   // Evidencia statov
        Pab_CtyLst_V   // Evidencia miest a obci
        Pab_PayLst_V   // Evidencia foriem uhrad
        Pab_TrsLst_V   // Evidencia sposobov dopravy
        Pab_BankLst_V  // Evidencia bankovych institucii
        Pab_PagLst_V   // Zoznam skupin !!!
        Pab_NameSrch_F // Vyh�ad�vanie firiem pod�a zadanej �asti n�zvu
        Pab_RefGen_F   // Posla� katal�g do pokladne
        Pab_ExpToTxt_F // Export �dajov do textov�ho s�boru
        Pab_ImpFrTxt_F // Import �dajov z textov�ho s�boru
        Pab_PacChg_F   // Zamena firmy v celom syst�me
        // Udrzba
        Pab_Sending_F  // Posla� evidenciu partnerov cez FTP                    DEL
        Pab_SynBas_F   // Synchroniz�cia so z�kladnou knihou

Wgh_F - Obsluha elektronick�ch v�h
        // Upravy
        WgiEdi_F       // Udaje vybranej polozky pre vahu LIBRA 500
        Wgh_WgiEdit_F  // Udaje vybranej polozky
        Wgh_WgnEdit_F  // Volny text polozky
        // Nastroje
        Wgh_RefData_F  // Prenos udajov z cennika
        Wgh_SndData_F  // Odoslanie udajov do vahy
        Wgh_WgiCmp_F   // Porovnanie v�hov�ch etikiet s polo�kami predaja
        WgnRef_F       // Obnovenie poznamok z bazovej evidencie
        // Udrzba
        Wgh_WgsEdit_F  //

Cwb_F - Kontrola v�hov�ho predaja
        // Udrzba
        Cwb_BookEdi_F  // Vlastnosti vybranej knihy

// Obchodna cinnost
Pls_F - Tvorba predajn�ch cien
        // Upravy
        Pls_PlcEdit_F  // Formular na zadavanie predajnej ceny
        Pls_LevEdi_F   // Karta tvorby predajnej ceny
        Pls_OrdPrn_F   // Tlac kuchynksych objednavok
        Pls_ItmEdi_F   // Formular centovorby a evidencie polozky
        // Zobrazit
        Gsc_ItmInfo_F  // Podrobne informacie o predaji
        Pls_PlsMod_V   // Historia zmaney udajov
        Pls_PlsHis_V   // Historia zmeny ceny
        Pls_PlsDis_V   // Zoznam vyraden�ch poloziek
        Pls_PlsDel_V   // Zoznam zrusenych poloziek
        Pls_PlsPck_V   // Zoznam vratnych obalov
-        Pls_PlsWgs_V   // Zoznam vahovych tovarov
-        Pls_PlsPgs_V   // Zoznam obalovych tovarov
        Pls_PlsAct_V   // Zoznam akciov�ch tovarov
        Stk_StcLst_V   // Zasoba v jednotlivych skladovch
        Stk_SpaLst_V   // Dodavatelia vybranej polozky
-        Stk_CpaLst_V   // Odberatelia vybranej polozky
-        Gsc_OcdLst_V   // Nevybavene zakazky zo vsetkych skladov
        Stk_SapLst_V   // Ceny z predajnych cennikov
-        Stk_ActStp_V   // Neodpisane vyrobne cisla
-        Stk_AllStp_V   // Vsetky vyrobne cisla
        Pls_LapChg_V   // Zmeny nakupnych cien
        Pls_SapChg_V   // Zmeny predajnych cien
        Pls_PlcInf_F   // Cenov� inform�cie
        // Tlac
        Pls_PrnFgc_F   // Tlac cenniku podla skupin
        Gsc_LabPrn_F   // Tlac cenovych etikiet
        // Nastroje
        Pls_PlsFilt_F  // Filtrovanie poloziek cennika
        Pls_BcSrch_F   // Hladat polozku podla podkodu
        Pls_NaSrch_F   // Hladat podla casti nazvu
        Gsc_NusGsc_F   // Nepouzite tovarove polozky
        Pls_NusPls_F   // Nepouzite tovarove polozky
        Pls_PlsRef_F   // Aktualiz�cia zisku predaja
        Pls_ReCalc_F   // Prepo�et predajn�ch cien
        Pls_GsCopy_F   // Kop�rovanie polo�iek do cenn�ka
        Pls_RefGen_F   // Posla� cenn�k do pokladne
        Pls_PlcDif_V   // Porovn�vanie cenn�kov
        Pls_GscDif_V   // Porovn�vanie e evidenciou tovaru
        Pls_TxtExp_F   // Export do textov�ho s�boru
-        Pls_CdCat_F    // Vyhotovenie CD katal�gu
-        Trm_DatSnd_F   // Z�pis �dajov do databanky
        Pls_LevClc_F   // Prepo�et cenov�ch hlad�n
        Sys_ImpPls_F   // Import predajneho cenika
        // Udrzba
        Pls_EditBook_F // Vlastnosti predajn�ho cenn�ka
        Pls_Synchr_F   // Synchroniz�cia z�kladnych udajov
        Pls_Sending_F  // Posla� cel� cenn�k na FTP
        Pls_SetStk_F   // Nastavi� sklad pre polo�ku
        Pls_ApCalc_F   // Prepo�et predajnej ceny bez DPH
        // Servis
        PLS_RndVer_F   // Kontrola zaokr�hlenia ceny/MJ
        Pls_AddPlm_F   // Prida� star� zmeny do hist�rie

Apl_F - Evidencia akciov�ch cien
        // Upravy
        Apl_AplLst_F  // Vlastnosti vybraneho cennika
        Apl_AplItm_F  // Polozka akcioveho cennika
        // Nastroje
        Apl_CasSnd_F  // Posla� �daje do pokladne
        Sys_ImpApl_F  // Import akcioveho cennika
        // Udrzba
        Apl_EndDel_F  // Zru�i� neplatn� akcie

Acb_F - Akciov� precenenie tovaru
        // Upravy
        Acb_AchEdit_F // Hlavicka vybraneho dokladu
        // Zobrazit
        Acb_AciLst_F  // Polozky vybraneho dokladu
        // Tlac
        Acb_DocPrn_F  // Tlac precenovacieho dokladu
        Acb_PrnNew_F  // Cenovky s akciovymi cenami
        Acb_PrnAft_F  // Cenoviek po ukonceni akcie
        Lab_PrnItm_F  // Tla� cenovkov�ch etikiet
        // Nastroje
        Acb_ActRun_F  // Zahajenie cenovej akcie
        Acb_ActEnd_F  // Okoncenie cenovej akcie
        Acb_ReadTmp_F // Asi treba vyradit tento modul - RZ 08.02.2008
        Acb_SndApl_F  // Do akciov�ho cenn�ka
        Acb_ImpAci_F  // Import akciovych cien
        // Udrzba
        Key_BokAdd_F  // Zalozit novu knihu
        Key_AcbEdi_F  // Interne prijemky

Agl_F - Evidencia zmluvn�ch podmienok
        // Nastroje
        Agl_ImpDat_F  // Import zmluvn�ch cien
        // Upravy
        Agl_AgrLst_F  // Zadavanie novej firmy
        Agl_AgrItm_F  // Zmluvna podmienka tovaru

Mcb_F - Odberate�sk� cenov� ponuky
        // Upravy
        Mcb_MchEdit_F // Hlavicka vybraneho dokladu
        Mcb_DocEdi_F  // Hlavi�ka cenovej ponuky (nov�)
        Mcb_DocDsc_F  // Z�ava na cel� doklad
        Mcb_DocRnd_F  // Zaokr�hlenie dokladu
        Doc_VatChg_F  // Zmena sadzieb DPH
        // Zobrazit
        Mcb_MciLst_F  // Polozky vybraneho doklau
        Mcb_ItmLst_F  // Polozky vybraneho doklau
        Inv_PayLst_V  // Hist�ria �hrady fakt�ry
        AttLst_V      // Zoznam pr�loh
        // Tlac
        Mcb_PrnMcd_F  // Tlac vybraneho dokladu
        Mcb_McrFrc_F  // V�kaz pod�a platnosti
        Mcb_McrStk_F  // V�kaz pod�a z�soby
        Mcb_McrFit_F  // V�kaz voln�ch polo�iek
        // Nastroje
        Mcb_DocCopy_F // Kopirovanie dokladu
        Mcb_TcdGen_F  // Vystavenie dodacieho listu
        Mcb_OcdGen_F  // Vystavenie odberate�skej z�kazky
        Mcb_ExpDoc_F  // Export cenovej ponuky
        Mcb_MciClc_F  // Prepo�et cenovej ponuky
        Mcb_MinAcq_F  // Minimaliz�ia vstupn�ch n�kladov
        // Udrzba
        Key_BokAdd_F  // Zalo�i� nov� knihu
        Key_McbEdi_F  // Vlastnosti knihy

Dsc_F - Z�avy pre odberate�ov
        // Upravy
        Dsc_FgPaDsc_F // Finan�n� skupina
        // Zobrazit
        Pab_PacLst_V  // Katal�g partnerov
        // Nastroje
        Dsc_ImpFgc_F  // Import obchodn�ch podmienok
        Dsc_ScpTbl_F  // Tabulkove nastavenie udajov

Dir_F - Kontaktn� mana��rsky di�r
        // Upravy
        Dir_ItmEdi    // Editor na za�vanie kontaktu
        // Zobrazit
        Dir_TelLst    // Zoznam telef�nnych ��siel
        Dir_EmlLst    // Zoznam elektronick�ch po�tov�ch adries
        Dir_RemLst    // Pripomienky ku kontaktnej osobe
        Dir_CrsLst    // Zoznam firemn�ch vz�ahov
        Dir_ModLst    // Zoznam �prav

Mds_F - V�kaz najmen�ieho zisku
        // Upravy
        Mds_ClcMds_F  // Vypocet minimalneho zisku
        Mds_DelMit_F  // Vymaza� polo�ky hromadne

Rpc_F - Po�iadavky na zmeny cien
        // Upravy
        Rpc_ItmEdi_F  // Zalo�i� po�iadavku
        // Nastroje
        Rpc_ItmApp_F  // Spracova� po�iadavky

Tpc_F - Evidencia terminovan�ch cien
        // Upravy
        Tpc_ItmEdi_F  // Zalo�i� po�iadavku
        // Nastroje
        Tpc_CasSnd_F  // Posla� �daje do pokladne

Crd_F - Evidencia z�kazn�ckych kariet
        // Upravy
        Crd_CrdEdit_F // Editor zakaznickej karty
        // Zobrazit
        Crd_TrnHis_V  // Historia nakupov zakaznika
        Crd_BonHis_V  // Historia v�daja bonusov
        // Nastroje
        Crd_ItmFlt_F  // Filtrovat zakaznicke karty
        Crd_CasSnd_F  // Posla� �daje do pokladne
        Crd_BonOut_F  // V�daj z�kazn�ckych bonusov
        Crd_AddInv_F  // Priradenie odb. fakt�ry ku karte
        Crd_CrdFlt_F  // Zakaznicke karty po splatnosti
        // Udrzva
        Crd_FtpSnd_F  // Posla� v�etky karty na FTP
        Crd_ClcLst_F  //
        Crd_TrnVer_F  // Kontrola obratov
        Key_CrdEdi    // Kontrola obratov

// Riadenie skladu
Stk_F - V�kaz z�soby pod�a spotreby
        // Upravy
        Stk_MinMax_F  // Skladov� normat�vy
        // Zobrazit
        Stk_StoLst    // Prehlad objednania a rezervacie
        Stk_StbLst    // Preh�ad po�iato�n�ch stavov
        Gsc_ItmInfo_F // Podrobn� inform�cie o tovare
        Stk_ItmInfo_F // Skladov� karta z�sob
        Stk_StcInf_F  // Skladov� karta z�sob
        Stk_ActFif_V  // Nevydan� FIFO karty polo�ky
        Stk_AllFif_V  // V�etky FIFO karty polo�ky
        Stk_StmLst_F  // Hist�ria skladov�ch pohybov
        Stk_StcLst_V  // Z�soba v jednotliv�ch skladoch
        Stk_ActStp_V  // Neodp�san� v�robn� ��sla
        Stk_AllStp_V  // V�etky v�robn� ��sla
        Stk_StpDir_V  // V�robn� ��sla z cel�ho skladu
        Stk_CpaLst_V  // Odberatelia vybranej polo�ky
        Stk_SpaLst_V  // Dod�vatelia vybranej polo�ky
        Stk_SapLst_V  // Ceny z predajn�ch cenn�kov
        Stk_OcdLst_V  // Nevybaven� odberate�sk� OBJ
        Stk_OciDel_V  // Zoznam zrusenych zakaziek
        Stk_OsdLst_V  // Nedodan� dod�vate�sk� OBJ
        Stk_ImrLst_V  // Nedodan� dod�vate�sk� OBJ
        Stk_MinLst_V  // Skladov� nad normat�vy
        Stk_MaxLst_V  // Skladov� pod normat�vy
        Stk_StsLst_V  // Rezervacie ERP
        Stk_StmHst_F  // Hist�ria skladov�ch pohybov za roky
        Stk_SpcLst_V  // Z�soba na pozi�n�ch miestach
        // Tlac
        Stk_PrnStk_F  // Tla� zoznamu skladov�ch kariet
        // Nastroje
        Stk_StcFilt_F // Filtrova� skladov� karty z�sob
        Stk_BcSrch_F  // H�ada� polo�ku pod�a podk�du
        Stk_NaSrch_F  // H�ada� pod�a �ast� n�zvu
        Stk_NrsNul_F  // Rezervovan� tovary s nulovou NC
        Stk_StEval_F  // Finan�n� vyhodnotenie skladov
        Stk_SmEval_F  // Finan�n� vyhodnotenie ku d�u
        Stk_StmSum_F  // Finan�n� vyhodnotenie pohybov
        Stk_StmAcc_F  // Finan�n� vyhodnotenie uctov
        Stk_StmItm_F  // Vykaz skladovych pohybov
        Stk_DayStm_F  // Denn� v�kaz pr�jmov a v�dajov
        Stk_DayStc_F  // Z�soba k zadan�mu d�tumu
        Stk_SapStc_F  // Z�soba pod�a dod�vate�ov
        Stk_SmgEvl_F  // Skladov� zasoba pod�a skup�n
        Stk_StvTrn_F  // Finan�n� vyhodnotenie obr�tkovosti
        Stk_NusStc_F  // Nepou�it� skladov� karty
        Stk_DrbLst_F  // Trvanlivos� tovarov�ch polo�iek
        Stk_SmLst_V   // Zoznam skladov�ch pohybov
        Stk_TxtExp_F  // Export do textov�ho s�boru
        Stk_TxtImp_F  // Import z textov�ho s�boru
        Stk_CnsSal_F  // V�kaz komision�lneho perdaja
        Stk_InShop_F  // �daje pre internetov� obchod
        Stk_OrdPrp_F  // Pr�prava objedn�vok
        Stk_RndDif_F  // V�kaz cenov�ch rozdielov
        Stk_PosLst_V  // Evidencia pozi�n�ch miest
        Stk_NtrStc_F  // V�kaz neobr�tkov�ho tovaru
        StkRba_F      // V�kaz z�soby pod�a spotreby
        Stk_StmRep_F  // V�kaz z�soby pod�a pohybov
        // Udrzba
        Stk_ReCalc_F  // Prepo�et skladovej karty
        Stk_StoCalc_F // Prepo�et rezervovan�ho mno�stva
        Stk_Sending_F // Posla� skladov� karty cez FTP
        Stk_Synchr_F  // Synchroniz�cia z�kladn�ch �dajov
        Stk_OcdVer_F  // Kontrola rezerv�cii z�kaziek
        Stk_OsdVer_F  // Kontrola objednan�ho mno�stva
        Stk_StcVer_F  // Kontrola skladov�ch kariet
        Stk_FifVer_F  // Kontrola FIFO kariet
        Stk_StmDup_F  // Kontrola duplicity skladov�ch pohybov
        Stk_DocVer_F  // Kontrola pohybov pod�a dokladov
        Stk_LosStm_F  // Ch�baj�ce skladov� pohyby
        Stk_LosStc_F  // Ch�baj�ce skladov� karty
        Stk_BegVer_F  // Kontrola pociatocneho stavu
        Stk_DocStm_F  // Porovn�vanie pohybov  s dokladmi
        Imp_MinMax_F  // Import skladovych normativov
        Stk_CpcVer_F  // Kontrola nakupnych cien
        Stk_NrmClc_F  // V�po�et skladov�ch normat�vov
        // Service
        Stk_StmDat_F  // Kontrola datumu FIFO a pohybov
        Stk_StmDoc_F  // Hodnota dokladov pod�a pohybov
        Stk_SalClc_F  // Perpo�et rezervacii ERP
        Stk_StkCalc_F // Perpo�et v�etk�ch skladov�ch kariet
        Stk_SalNul_F  // Vynulovanie rezerv�cii pre ERP
        Stk_OsdNul_F  // Vynulovanie objednan�ho mno�stva
        Stk_AvgRef_F  // Aktualiz�cia priemernej NC
        Stk_LastRef_F // Aktualiz�cia poslednej NC
        Stk_StmDir_V  // Denn�k skladov�ch pohybov
        Stk_OldMMQ_F  // Prenos udajov z minuleho roku
        Stk_FifClc_F  // Prepocet FIFO a STM
        Stk_FifCor_F  // Prepocet nulovych FIFO
        Stk_FifNum_F  // Generovanie ��siel FIFO v pohyboch

Imb_F - Intern� skladov� pr�jemky
        // Upravy
        Imb_ImhEdit_F // Hlavicka internej skladovej prijemky
        Doc_VatChg_F  // Zmena sadzieb DPH
        // Zobrazit
        Imb_ImiLst_F  // Polozky vybraneho dokladu
        Jrn_AccLst_V  // ��tovn� z�pisy dokladu
        // Tlac
        Imb_DocPrn_F  // Hromadn� tla� skladov�ch pr�jmov�ch dokladov
        Imb_ImdPrn_F  // Zoznam dokladov za obdobie
        // Nastroje
        Imb_ImdFilt_F // Filtrovanie prijmovych dokladov
        Imb_IncDoc_F  // Pr�jem v�etk�ch polo�iek
        Stk_SmLst_V   // Zoznam skladov�ch pohybov
        Imb_WghRcv_F  // Nacitat udaje z elektronickej vahy
        Doc_TrdInc_F  // Na��ta� z�znamn�kov� pr�jemky
        Imb_ImpDoc_F  // Na��ta� elektronick� doklad
        Imb_ImiFxa_F  // V�kaz prijat�ho majetku
        Imb_ImpCSV_F  // Import z CSV
        WgdImp_F      // Import v�hov�ho dokladu
        // Udrzba
        Imb_Sending_F // Posla� skladov� pr�jemky cez FTP                       DEL
        Imb_StmImd_F  // Porovn�vanie dokladu s pohybmi
        Imb_StmIma_F  // Porovn�vanie dokladov s pohybmi
        Doc_OitMsd_F  // Interny prenos dokladov
        Imb_ImiDir_V  // Polo�ky v�etk�ch pr�jemok
        Imb_CrdDif_F  // Dodatocne pridane polozky
        Key_BokAdd_F  // Zalozit novu knihu
        Key_ImbEdi_F  // Interne prijemky
        // Servis
        Imb_SndTxt_F  // Ulo�i� doklady do textov�ho s�boru                     DEL
        Imb_RcvTxt_F  // Na��ta� doklady z textov�ho s�boru                     DEL
        Imb_ImiToN_F  // Zmeni� polo�ky na neodpo��tan�                         DEL
        Imb_ImiRef_F  // Obnova poloziek podla hlavicky
        Imb_ClcPrc_F  // Prepo�et PC polo�iek
        Imb_IncBook_F // Pr�jem polo�iek v�etk�ch dokladov                      DEL

Omb_F - Intern� skladov� v�dajky
        // Upravy
        Omb_OmhEdit_F // Hlavicka internej skladovej vydajky
        Doc_VatChg_F  //
        // Zobrazit
        Omb_OmiLst_F  // Polozky vybranej vydajky
        Omb_NosOmi_V  // Nevyskladnene polo�ky v�dajok
        Inv_PayLst_V
        Jrn_AccLst_V  // ��tovn� z�pisy dokladu
        // Tlac
        Omb_DocPrn_F  // Tlac vybraneho dokladu
        Omb_OmdPrn_F  //
        // Nastroje
        Omb_OutDoc_F  // Vydaj vsetkych poloziek
        Omb_OmdFilt_F //
        Omb_ImdCrt_F  //
        Stk_SmLst_V   //
        Omb_StmOmd_F  // Porovn�vanie dokladu s pohybmi
        Omb_StmOma_F  // Porovn�vanie dokladov s pohybmi
        Omb_StkOut_F
        Omb_MgcStc_F  // Skladov� karty pod�a skup�n
        Doc_TrdOut_F  // Na��ta� z�znamn�kov� v�dajky
        Omb_WgdImp_F  // Na��tanie v�hov�ch dokladov
        // Udrzba
        Omb_Sending_F
        Omb_RwmVer_F  // Kontrola medziprevadkoveho presunu
        Omb_ChckSrc_F // Kontrola medziprevadkoveho presunu
        Doc_OitMsd_F  // Interny prenos dokladov
        Omb_OmiDir_V  // Polo�ky v�etk�ch v�dajok
        Omb_CrdDif_F  // Dodatocne pridane polozky
        Key_BokAdd_F  // Zalozit novu knihu
        Key_OmbEdi_F  // Interne vydajky
        // Servis
        Omb_SndTxt_F  //                                                        DEL
        Omb_RcvTxt_F  //                                                        DEL
        Omb_OmiToN_F  //                                                        DEL
        Omb_InpCor_F  // Oprava cien z�porn�ch v�dajov
        Omb_OmpDir_V  // Zoznam v�etk�ch v�robn�ch ��siel
        Omb_OmiRef_F  // Obnova polo�iek pod�a hlavi�ky
        Omb_OutBook_F // Vydaj poloziek vsetkych dokladov - celej knihy

Rmb_F - Medziskladov� presuny
        // Upravy
        Rmb_RmhEdit_F // Hlavicka vybrneho dokladu
        Rmb_MovDoc_F  // Presun v�etk�ch polo�iek
        // Zobrazit
        Rmb_RmiLst_F  // Polozky vybraneho dokladu
        Jrn_AccLst_V  // ��tovn� z�pisy dokladu
        // Tlac
        Rmb_DocPrn_F  // Hromadn� tla� dokladov
        Rmb_RmdPrn_F  // Zoznam dokladov za obdobie
        Lab_PrnItm_F  // Tla� cenovkov�ch etikiet
        // Nastroje
        Stk_SmLst_V   // Zoznam skladov�ch pohybov
        Doc_TrdOut_F  // Na��ta� z�znamn�kov� v�dajky
        Sys_DocFlt_F  // Filtrovanie dokladov
        WgdImp_F      // Import v�hov�ho dokladu
        // Udrzba
        Key_BokAdd_F  // Zalozit novu knihu
        Key_RmbEdi_F  // Interne vydajky
        Rmb_Sending_F // Posla� skladov� presunky cez FTP                       DEL
        Doc_OitMsd_F  // Interny prenos dokladov
        // Servis
        Rmb_RmiToN_F  // Zmeni� polo�ky na neodpo��tan�                         DEL
        Rmb_MovBook_F // Presun polo�iek v�etk�ch dokladov

Dmb_F - Rozobratie v�robkov
        // Upravy
        Dmb_DmhEdit_F // Hlavicka vybraneho dokladu
        // Zobrazit
        Dmb_DmiLst_F  // Popozky vybraneho dokladu
        // Tlac
        Dmb_DocPrn_F  // Hromadn� tla� dokladov
        Dmb_DmdPrn_F  // Zoznam dokladov za obdobie
        // Nastroje
        Dmb_DmpDoc_F  // Rozobratie vybraneho vyrobku
        Dmb_DmpClc_V  // Definicia vypoctu vyrobnych cien
        // Udrzba
        Key_BokAdd_F  // Zalozit novu knihu
        Key_DmbEdi_F  // Vlastnosti vybeanej knihy
        Key_cmbEdi_F  // Vlastnosti vybeanej knihy
        Dmb_StmDmi_F  // Porovn�vanie so skladov�mi pohybmi
        Doc_OitMsd_F  // Interny prenos dokladov
        // Servis
        Dmb_DmiToN_F  // Zmeni� polo�ky na neodpo��tan�                         DEL

Pkb_F - Preba�ovanie tovaru
        // Upravy
        Pkb_PkhEdit_F // Hlavicka vybraneho dokladu
        // Zobrazit
        Pkb_PkiLst_F  // Polozky vybraneho dokladu
        // Tlac
        Pkb_DocPrn_F  // Tlac vybraneho dokladu
        // Nastroje
        Pkb_PckDoc_F  // Prebalenie poloziek dokladu
        Sys_DocFlt_F  // Filtrovanie dokladov
        // Udrzba
        Key_BokAdd_F  // Zalozit novu knihu
        Key_PkbEdi_F  // Interne prijemky
        Pkb_StmPki_F  //
        Doc_OitMsd_F  // Interny prenos dokladov
        // Servis
        Pkb_PkiToN_F  // Zmenit doklady na neodpocitany
        Pkb_PkiRef_F  // Obnova poloziek podla hlaviciek

Reb_F - Prece�ovacie doklady                                                    DEL
        // Upravy
        Reb_RehEdit_F // Hlavicka vybraneho dokladu                             DEL
        Doc_VatChg_F  // Zmwna sadby DPH                                        DEL
        // Zobrazit
        Reb_ReiLst_F  // Polozky vybraneho dokladu                              DEL
        // Tlac
        Reb_PrnDoc_F  // Tlac vybraneho dokladu                                 DEL
        // Nastroje
        Reb_RevRun_F  // Precenenie poloziek dokladu                            DEL
        // Udrzba
        Reb_RebEdit_F // Vlastnosti vybranej knihy                              DEL

Alb_F - Pren�jom n�radia
        // Nastroje
        Alb_AldIcg_F  // Vystavi� odberate�sk� fakt�ru
        Alb_AldEcr_F  // Vy��tova� doklad cez FMS
        Alb_RetPro_F  // Protokol vr�tenia zariadenia

Cdb_F - Manu�lna v�roba
        // Upravy
        Cdb_CdhEdit_F // Hlavicka vybraneho dokladu
        // Zobrazit
        Cdb_CdiLst_F  // Polozky vybraneho dokladu
        Cdb_CdsLst_F  // Sum�rny zoznam komponentov
        Cdb_CdmLst_F  // zoznam komponentov vyrobku
        // Tlac
        Cdb_DocPrn_F  // Tlac vybraneho dokladu
        // Nastroje
        Cdb_CdbDoc_F  // Prebalenie poloziek dokladu
        // Udrzba
        Key_BokAdd_F  // Zalozit novu knihu
        Key_CdbEdi_F  // Vlastnosti vybeanej knihy
        {Pkb_StmPki_F}
        Doc_OitMsd_F  // Interny prenos dokladov
        // Servis
        {Pkb_PkiToN_F}// Zmenit doklady na neodpocitany                         DEL
        {Pkb_PkiRef_F}// Obnova poloziek podla hlaviciek                        DEL

Pnb_F - Prece�ovacie doklady                                                    DEL
        // Upravy
        Rmb_PndEdit_F //                                                        DEL
        Pnb_PnbEnd_F  //                                                        DEL
        // Nastroje
        Pnb_PndFilt_F //                                                        DEL
        // Udrzba
        Pnb_PnbEdit_F //                                                        DEL
        Doc_OitMsd_F  // Intern� penos dokladuv                                 DEL

Ivd_F - Inventariz�cia skladov
        // Upravy
        Ivd_IvdEdit_F // Hlavicka vybraneho dokladu
        // Zobrazit
        Ivd_FinInfo_F //
        Ivd_ItmLst_V  // Polozky vybraneho dokladu
        Ivd_IvdLst_V  // Polozky vybraneho dokladu - pozicne
        Ivd_IvlLst_V  // Zoznam inventarnych harkov
        Ivd_IvcLst_V  //
        Ivd_IviDir_V  //
        // Tlac
        Ivd_RepPrn_F  //
        // Nastroje
        Ivd_IvcCrt_F  //
        Ivd_IvlCon_F  //
        Ivd_IvdSep_F  //
        Ivd_DifPrn_F  //
        Ivd_NsRead_F  //
        Ivd_MgSum_F   // Rozdiely podla tovarovych skupin
        Ivd_IvClose_F // Uztvorenie inventury
        Ivd_MgStm_V   // Vykaz prirodzenych strat
        Ivd_StcVer_F  // Porovnavanie s aktu�lnym stavom
        Ivd_BpcVer_F  // Porovnavanie predajnych cien
        Ivd_StRead_F  // Nacitanie skladoveho stavu
        Ivd_StmRea_F  // Nacitanie skladoveho stavu ku dnu ukoncenia
        Ivd_GsRead_F  // Nacitanie evidencnych udajov
        Ivd_DelNul_F  // Vymazanie nulov�ch polo�iek

// Zasobovanie skladov
Ocp_F - Spracovanie z�kaziek
        // Upravy
        Ocp_AddItm_F  // Pridat nov� polozky do zoznamu
        Ocp_EditItm_F // Zadavanie udajov vybranej polozky
        Ocp_ProcItm_F // Spracovanie polo�ky z�kazky
        // Nastroje
        Ocp_OcpDef_V  // Definicia tvorby dokladov

Psb_F - Pl�ny dod�vate�sk�ch objedn�vok
        // Program
        Sys_UnlEdit_F // Odblokovanie dokladu
        // Upravy
        Psb_PshEdit_F // Hlavicka vybraneho dokladu
        Psb_PsdGen_F  // Prida� polozky do planu
        Doc_VatChg_F  // Zmena sadzieb DPH
        // Zobrazit
        Psb_PsiLst_F  // Polozky vybraneho dokladu
        // Tlac
        Psb_PrnPsd_F  // Tlac vybraneho dokladu
        // Nastroje
        Osb_OutMov_V  // Specifikacia skladovych pohybov
        Psb_OsdGen_F  // Vyhotovenie objedn8vky z planu
        Osb_StkOut_V  // Statisticky zoznam vydajov
        // Udrzba
        Key_BokAdd_F  // Zalo�i� nov� knihu
        Key_PsbEdi_F  // Pl�novanie objedn�vok
        {Psb_PsbEdit_F}                                                         DEL

Osb_F - Dod�vate�sk� objedn�vky
        // Upravy
        Osb_OshEdit_F // Hlavicka vybraneho dokladu
        Osb_DocDsc_F  // Z�ava na objedn�vku
        Osb_DocRnd_F  // Zaokr�hlenie objedn�vky
        Doc_VatChg_F  // Zmena sadzieb DPH
        // Zobrazit
        Osb_OsiLst_F  // Polozky vybraneho dokladu
        Osb_StkOut_V  // �tatistick� zoznam  v�dajov
        Osb_OspLst_V  // Zoznam dod�vate�ov tovaru
        // Tlac
        Osb_PrnOsd_F  // Tlac vybraneho dokladu
        // Nastroje
        Osb_OsdGen_F  // Automatick� vyhotovenie objedn�vky
        Osb_SndDbf_F  // Ulo�i� doklad do DBF s�boru                            DEL
        Osb_OsiMov_F  // Prenos polo�iek do inej objedn�vky
        Osb_DlvRead_F // Na��tanie dod�vky zo s�boru
        Osb_OutMov_V  // Specifikacia skladovych pohybov
        Osb_DocSnd_F  // Elektronicky prenos dokladov
        Osb_OsiDlv_F  // Prekrocene terminy dodavok
        Osb_OsiNar_F  // Nesplnene dodavky kumulativne
        Osb_OsiNat_F  // Kontrola term�nu dod�vky
        Osb_StoVer_F  // Kontrola skladov�ho stavu
        OsbBcs_F      // Automatick� generovanei objednavok
        OsbDdm_F      // Spravovanie terminu dodavky
        OsbSnd_F      // Odoslanie objednavky
        OsbSdc_F      // Potvrdenie term�nu objedn�vky dod�vate�om
        Osb_DocCopy_F // Kopirovanie dokladu
        Osb_ImpDoc_F  // Na��tanie elektronick�ho dokladu
        // Udrzba
        Key_BokAdd_F  // Zalozit novu knihu
        Key_OsbEdi_F  // Interne vydajky
        Osb_StoGen_F  //                                                        DEL
        Doc_OitMsd_F  // Interny prenos dokladov
        // Servis
        Osb_OsbClc_F  // Prepocet dokladov podla poloziek
        Osb_OsiRef_F  // Obnova polo�iek pod�a hlavi�iek

Osq_F - Tvorba objdn�vok zo skladu
        // Upravy
        Osq_DocEdi    // Hlavi�ka dod�vate�skej objedn�vky
        Osq_ItmEdi    // Polo�ka dod8vate�skej objedn�vky
        // Zobrazit
        Osq_ItmInf    // Polo�ka dod8vate�skej objedn�vky
        Osq_ItmLst    // Polo�ky vybran�ho dokladu

Tsb_F - Dod�vate�sk� dodacie listy
        // Upravy
        Tsb_TshEdit_F // Hlavi�ka dod�vate�sk�ho dodacieho listu
        Tsb_DocDsc_F  // Z�ava na vybran� doklad
        Doc_VatChg_F  // Zmena sadzieb DPH
        // Zobrazit
        Tsb_TsiLst_F  // Polozky dodacieho lsitu
        Jrn_AccLst_V  // Zoznam ��tovn�ch z�pisov
        Tsb_DlvSur_V  // Zoznam dodavok naviac
        // Tlac
        Tsb_DocPrn_F  // Tla� vybran�ho dokladu
        Tsb_TsdPrn_F  // Tla� dokladov za obdobie
        Lab_PrnItm_F  // Tla� cenovkov�ch etikiet
        // Nastroje
        Tsb_IncDoc_F  // Pr�jem v�etk�ch polo�iek
        Tsb_TsdMpr_F  // Spojenie dodacieho listu s fakt�rou
        Tsb_AddAcq_F  // Rozpo�et obstar�vac�ch n�kladov
        Tsb_TrmRcv_V  // Na��tanie �dajov zo z�znamn�ka
        Doc_TrdInc_F  // Na��ta� z�znamn�kov� pr�jemky
        Tsb_TsdRcv_F  // Elektronick� prenos dokladov
        Tsb_EdiRcv_F  // Elektronick� prenos dokladov
        Tsb_DocCopy_F // Kop�rovanie vybraneho dokladu
        Tsb_TsiRep_F  // Vykaz prijmu tovaru na sklad
        Tsb_OmdGen_F  // Presun na inu prevadzku
        Doc_AddRpc_F  // Vytvori� po�iadavky na zmenu cien
        Doc_AutPck_F  // Automaticke prebalenie tovaru
        Imb_ImiFxa_F  // V�kaz prijat�ho majetku
        Tsb_TshFlt_F  // Filtrovanie dokladov
        Sys_DocFlt_F  // Filtrovanie dokladov
        Tsb_PckRep    // V�kaz obalov
        Tsb_ImpDoc_F  // Na��ta� elektronick� doklad
        TsdBcs_F      // Prepo�et NC polo�iek pod�a obchodn�ch podmienok
        // Udrzba
        Doc_ItmRef_F  // Obnova �dajov polo�iek
        Tsb_NoPair_F  // Nevyp�rovan� DL k zadan�mu d�tumu
        Tsb_Sending_F // Posla� dodacie listy cez FTP
        Tsb_TsiIsi_F  // Kontrola vyp�rovan�ch polo�iek DDL a DF
        Tsb_OsdPair_F // P�rovanie DDL s objedn�vkami
        Tsb_StmTsd_F  // Porovn�vanie dokladu s pohybmi
        Tsb_StmTsa_F  // Porovn�vanie dokladov s pohybmi
        Tsb_TsdVer_F  // Hodnotov� kontrola dokladov
        Tsb_TsnVer_F  // Kontrola intern�ho ��sla dokladu
        Tsb_TsdMis_F  // Zoznam chybajucich dokladov
        Doc_OitMsd_F  // Interny prenos dokladov
        Key_BokAdd_F  // Zalozit novu knihu
        Key_TsbEdi_F  // Dodavatelske dodacie listy
        // Servis
        Tsb_DocClc_F  // Prepo�et dokladov pod�a polo�iek
        Tsb_TsiToN_F  // Zmeni� polo�ky na neodpo��tan�
        Tsb_SndTxt_F  // Ulo�i� doklady do textov�ho s�boru
        Tsb_RcvTxt_F  // Na��ta� doklady z textov�ho s�boru
        Tsb_IsdDate_F // Doplnenie d�tumu vyp�rovania s FA
        Tsb_TshRen_F  // Pre��slovanie do�l�ch dodac�ch listov
        Tsb_TsiDir_V  // Polo�ky v�etk�ch dodac�ch listov
        Tsb_TshChg_F  // Zmena ��sla  do�l�ho dodacieho listu
        Doc_AcvClc_F  // Prepocet uctovnej meny
        Tsb_IncBook_F // Pr�jem polo�iek v�etk�ch dokladov
        TsdUns_F      // Vr�tenie prijat�ho tovaru

Ksb_F - Konsigna�n� vysporiadanie
        // Upravy
        Ksb_KsdAdd_F  // Prida� nov� doklady  - star� sp�sob
        // Zobrazit
        Ksb_KsiLst_F  // Polo�ky vybran�ho dokladu
        // Nastroje
        Ksb_TsdGen_F  // Vystavi� do�l� dodac� list
        // Servis
        Ksb_KsiDir_V  // Polo�ky v�etk�ch dokladov

Bcs_F - Obchodn� podmienky dod�vok
        // Upravy
        Bcs_GscEdit_F // Tovarov� polo�ka vybran�ho dod�vate�a
        Bcs_PalEdi_F  // Obchodn� podmienky dod�vate�a
        Bcs_MorDel_F  // Hromadn� zru�enie polo�iek
        // Zobrazit
        Pab_PacLst_V  // Katal�g partnerov
        // Nastroje
        Bcs_ImpGsc_F  // Import obchodn�ch podmienok
        Bcs_ImpEpl_F  // Import elektronick�ho cen�ka
        Bcs_GslRat_F  // Zmena dodavky oznacenych poloziek
        BcsRel_V      // Prepocet spolahlivosti
        // Udrzba
        Bcs_PalRef_F  // Doplnenie ch�baj�cich firiem

Tim_F - Termin�lov� pr�jemky
        // Zobrazit
        Tim_SitLst_V  // Polozky vybraneho dokladu
        Tsb_DlvSur_V  // Zoznam dodavok naviac
        // Tlac
        Lab_PrnLab_F  // Hromadna tlac etikiet
        // Nastroje
        Tim_TsdGen_F  // Vyhotovi� dod�vate�sk� dodac� list
        Tim_ImdPair_F // P�rova� intern� skladov� pr�jemku
        // Udrzba
        Tim_OsiVer_F  // Vyhotovi� dod�vate�sk� dodac� list
        Key_BokAdd_F  //
        Key_TibEdi_F  // Dodavatelske dodacie listy

Lab_F - Tla� cenovkov�ch etikiet
        // Tlac
        Lab_PrnItm_F  // Tla� cwnovkov�ch etikiet
        // Nastroje
        Lab_PlsFlt_F  // Filtrova� polo�ky cenn�ka
        Tsb_DocLst_V  // Dod�vate�ske dodacie listy
        Imb_DocLst_V  // Intern� skladov� pr�jemky

// Velkoobchodny predaj
Udb_F - Univerz�lne odbytov� doklady
        // Upravy
        Udb_DocEdi_F  // Hlavi�ka odbytov�ho dokladu
        Udb_DocCls_F  // Uzatvorenie dokladu
        Udb_ItmEdi_F  // Polo�ka odbytov�ho dokladu
        // Zobrazit
        Ocb_ItmLst_F  // Polo�ky vybran�ho dokladu

Ocb_F - Odberate�sk� z�kazky
        // Upravy
        Ocb_OchEdi_F  // Hlavicka vybraneho dokladu - nova
        Ocb_OchEdit_F // Hlavicka vybraneho dokladu
        Ocb_DocDsc_F  // Z�ava na doklad
        Ocb_DocRnd_F  // Zaokr�hli� vybran� doklad
        Ocb_DocDel_F  // Zru�i� vybran� doklad
        Doc_VatChg_F  // Zmena sadzieb DPH
        // Zobrazit
        Ocb_OciLst_F  // Poloky vybraneho dokladu
        Spe_DocLst_V  // Zoznam prijat�ch a vydan�ch z�loh
        Ocb_OccDoc_F  // Zmluva o dielo
        AttLst_V      // Zoznam pr�loh
        // Tlac
        Ocb_PrnOcd_F  // Tlac vybraneho dokladu
        // Nastroje
        Ocb_DpzLst_F  // Evidencia z�lohov�ch platieb
        Ocb_PcdGen_F  // Vystavi� z�lohov� FA
        Ocb_TcdGen_F  // Vystavi� odberatelsk� DL
        Ocb_IcdGen_F  // Vystavi� odberate�sk� FA
        Ocb_ImdGen_F  // Vystavi� skladov� pijemku
        Ocb_OmdGen_F  // Vystavi� skladov� vydajku
        Doc_RmdGen_F  // Vystavi� skladov� prevodku
        Ocb_MneVal_F  // Zadavanie vyrobnych nakladov
        Ocb_NopOch_F  // Zoznam nevybavenych zakaziek
        Ocb_NopOci_F  // Zoznam nevybavenych polo�iek
        Ocb_OciExp_F  // Zoznam tovaru na exped�ciu
        Ocb_CadGen_F  // Vyuctovat doklad cez ERP
        Ocb_FmsGen_F  // Vyuctovat doklad cez FMS
        Icb_NoPayIc_F // Neuhraden� fakt�ry odberate�a
        Spe_Conto_F   // Evidencia z�lohov�ch platieb
        Ocb_OcdSta_F  // Stav odberatelskych zakaziek
        Ocb_OciRes_F  // Rezervacia prijateho tovaru
        Ocb_OciRep_F  // V�kaz objendnan�ho tovaru
        Ocb_DocCopy_F // Kop�rovanie vybranej z�kazky
        Ocb_ResFre_F  // Uvolni� rezerv�ciu po platnosti
        Ocb_ChgTrm_F  // Zmenen� term�ny dod�vok
        Ocb_MinStc_F  // Z�soba pod minim�lnym stavom
        Ocb_ShpImp_F  // Import z internetov0ho obchodu
        Exb_ExdGen_F  // Generovanie expedi�n�ch pr�kazov
        Ocb_ResOsd_F  // Rezerv�cia objednan�ho mno�stva
        // Udrzba
        Key_BokAdd_F  // Zalozit novu knihu
        Key_OcbEdi_F  // Interne vydajky
        Ocb_StoGen_F  // Prepo�et z�kazkov�ch rezerv�cii
        Ocb_Sending_F // Posla� odberate�sk� z�kazky cez FTP
        Ocb_OciRef_F  // Doplnenie �dajov polo�iek z�kaziek
        Spe_IncDoc_F  // Pr�jem z�lohovej platby
        Doc_OitMsd_F  // Interny prenos dokladov
        Ocb_StpRef_F  // Na��tanie n�kupn�ch cien
        // Servis
        Ocb_StoRes_F  // Kontrola vydaneho mnozstva zakaziek
        Ocb_DlvVer_F  // Kontrola vydaneho mnozstva zakaziek
        Ocb_OctVer_F  // Kontrola vydaneho mnozstva zakaziek
        Ocb_OciLnk_F  // Nespravne dodane polozky
        Ocb_OciVer_F  // Nespravne vyskaldnene polozky
        Ocb_OciDel_V  // Stornovane polozky zakaziek
        Ocb_OciDir_V  // Polozky vsetkych dokladov
        Ocb_OcbClc_F  // Prepocet dokladov podla poloziek

Tcb_F - Odberate�sk� dodacie listy
        // Upravy
        Tcb_TchEdit_F // Hlavicka dodacieho listu
        Tcb_DocDsc_F  // Z�ava na vybran� doklad
        Tcb_AddHds_F  // Logistick� z�ava na doklad
        Tcb_DocRnd_F  // Zaokruhlenie dokladu
        Doc_VatChg_F  // Zmena sadzieb DPH
        // Zobrazit
        Tcb_TciLst_F  // Polozky vybraneho dokladu
        Tcb_NopTch_V  // Zoznam nevyp�rovan�ch dodac�ch listov
        Tcb_NosTci_V  // Nevyskladnen� polo�ky DL
        TcbTcc_V      // Nevysporiadane komponenty
        TccLst_V      // Zoznam vyrobkov a komponentov
        TcdTcs_V      // Zoznam vyrobkov a komponentov
        Jrn_AccLst_V  // ��tovn� z�pisy dokladu
        // Tlac
        Tcb_DocPrn_F  // Tlac vybraneho dokladu
        Tcb_TcdPrn_F  // Tlac zoznamu dokladov
        // Nastroje
        Tcb_DocFlt_F  // Filtrov� zoznam dokladov
        Tcb_OutDoc_F  // V�daj polo�iek vybran�ho dokladu
        Tcb_AccPer_F  // Zauctovat doklady za obdobie
        Tcb_IcdGen_F  // Vystavenie odberatelskej faktury
        Tcb_IcdMog_F  // Hromadne vystavenie faktury
        Tcb_CadGen_F  // Vy��tova� doklad cez FM
        Icb_NoPayIc_F // Neuhraden� fakt�ry odberate�a
        Tcb_OutStk_F  // Hromadn� vy��tovanie skladu
        Tcb_DocClc_F  // Prepocet cien vybran�ho dokladu
        Tcb_FmdGen_F  // Vyuctovat doklad cez FMS
        Doc_TrdOut_F  // Na��ta� termin�lov� v�dajky
        Doc_TrdCpr_F  // Porovna� s termin�lovou v�dajkou
        Omb_OmiFxa_F  // V�kaz vydan�ho majetku
        Exb_ExdGen_F  // Generovanie expedi�n�ch pr�kazov
        Tcb_WgdImp_F  // Na��tanie v�hov�ch dokladov
        Tcb_EdiRcv_F  // Medzifiremn� prenos dokladu
        WgdImp_F      // Na��tanie v�hov�ch dokladov
        BciImp_F      // Na��tanie elektronickeho dokladu
     // Udrzba
        Tcb_TciRef_F  // Hlavickove udaje do polozky
        Tcb_TchRef_F  // Obnova �dajov hlavi�iek DL
        Tcb_Sending_F // Posla� dodacie listy cez FTP
        Tcb_StmTcd_F  // Porovn�vanie dokladu s pohybmi
        Tcb_StmTca_F  // Porovn�vanie dokladov s pohybmi
        Tcb_TcdVer_F  // Hodnotov� kontrola dokladov
        Tcb_TcnVer_F  // Kontrola intern�ho ��sla dokladu
        Tcb_TciSyn_F  // Synchroniz�cia zakladnych udajov
        Doc_OitMsd_F  // Interny prenos dokladov
        Tcb_TciDir_V  // Polo�ky v�etk�ch doda�ch listov
        Tcb_DocMov_F  // Presun dokladu do inej knihy
        Key_BokAdd_F  // Zalozit novu knihu
        Key_TcbEdi_F  // Dodavatelske dodacie listy
        // Servis
        Tcb_TcdRen_F  // Precislovanie dodacich listov
        Tcb_TciToN_F  // Zmeni� polo�ky na neodpo��tan�
        Tcb_TchVer_F  // Kontrola hlavi�iek pod�a polo�iek
        Tcb_CaMark_F  // Ozna�i� DL ako vy��tovan� cez ERP
        Tcb_TcpDir_V  // Zoznam vydan�ch v�robn�ch ��siel
        Tcb_OutBook_F // V�daj polo�iek v�etk�ch dokladov
        Tcb_FgCalc_F  // Prepocet vyuctovecej meny
        Tcb_MsnRef_F  // Doplnit merne jednotky
        Tcb_CncOut_F  // Zru�enie v�daj tovaru
        Tcb_TomCmp_F  // Na��ta� termin�lov� v�dajky
        Doc_AcvClc_F  // Prepocet uctovnej meny
        Tcb_ItgVer_F  // Kontrola vyuctovania poloziek cez pokladnu
        // Pokladna
        Cas_IncDoc_F  // Prijem poc. stavu do FM
        Cas_ExpDoc_F  // Prijem poc. stavu do FM
        // Ostatne
        Tcb_BonAdd_F  // B�nusov� akcia

Icb_F - Evidencia odberate�sk�ch fakt�r
        // Upravy
        Icb_IchEdit_F // Hlavicka odberatelskeh faktury
        Icb_DocDsc_F  // Z�ava na vybran� doklad
        Icb_DocDsc0_F // Z�ava na vybran� doklad
        Icb_DocRnd_F  // Zaokruhlenie dokladu
        Icb_DocSpc_F  // �pecifik�cia vybran�ho dokladu
        Doc_VatChg_F  // Zmena sadzieb DPH
        // Zobrazit
        Icb_IciLst_F  // Polozky vybraneho dokladu
        Icb_NopIch_V  // Zoznam nevyp�rovan�ch fakt�r
        Icb_NpyIcd_V  // Neuhraden� fakt�ry odberate�ov
        Inv_PayLst_V  // Hist�ria �hrady fakt�ry
        Spe_DocLst_V  // Zoznam prijat�ch a vydan�ch z�loh
        Jrn_AccLst_V  // Uctovne zapisy dokladu
        Acc_PmiLst_V  // Denn�k �hrady fakt�r
        Icb_IccLst_V  // Ulozena kopia faktury
        Icb_IcwLst_V  // Historia upomienok
        // Tlac
        Icb_DocPrn_F  // Tlac vybraneho dokladu
        Icb_IcdPrn_F  // Tlac dokladov za obdobie
        Icb_LiqPrn_F  // Tlac likvidacneho listu
        // Nastroje
        Icb_DocFlt_F  // Filtrova� odberate�sk� fakt�ry
        Icb_IcdFilt_F // Filtrova� odberate�sk� fakt�ry
        Icb_AccPer_F  // Zauctovanie dokladov za obdobie
        Icb_TcdPair_F // P�rovanie s dodac�m listom
        Icb_TcdGen_F  // Vystavenie dodacieho listu
        Icb_CsdGen_F  // Hotovostn� �hrada fakt�ry
        Icb_CadGen_F  // Hotovostn� �hrada fakt�ry cez ERP
        Icb_CadClm_F  // Storno �hrady fakt�ry cez ERP
        Icb_NoPayIc_F // Neuhraden� fakt�ry odberate�a
        Spe_IncDoc_F  // Pr�jem z�lohovej platby
        Spe_ExpDoc_F  // �erpanie z�lphovej platby
        Icb_IcdPay_F  // Poh�ad�vky k zadan�mu d�tumu
        Icb_IcpEvl_F  // Poh�ad�vky podla splatnosti
        Icb_IcdWrn_F  // Upomineky pre odberatelov
        Icb_PenGen_F  // Vystavenie penaliza�nej fakt�ry
        Icb_DocSnd_F  // Elektronick� prenos dokladu - stary
        Icb_IcdSnd_F  // Elektronick� prenos dokladu
        Icb_CrcPay_F  // �hrada cez platobn� kartu
        Icb_DocCopy_F // Kop�rovanie vybranej fakt�ry
        Icb_IciRep_F  // V�pis fakturovan�ho tovaru
        Icb_IciRepS_F // V�pis fakturovan�ho tovaru kumulovane
        Icb_TraExp_F  // Export �dajov pre dopravu
        Icb_IcdEml    // Rozoslanie fakt�r emailom
        CadGen_F      // Hotovostn� �hrada externej fakt�ry cez ERP
        // Importy
        Icb_ImpCsg    // Import z�sielkov�ch �dajov
        // Udrzba
        Key_BokAdd_F  // Zalo�i� nov� knihu
        Key_IcbEdi    // Dodavatelske dodacie listy
        Icb_IciRef_F  // Doplnenie �dajov polo�iek OF
        Icb_Sending_F // Posla� cel� knihy cez FTP
        Icb_PmiVer_F  // Kontrola �hrady fakt�r
        Icb_IciTci_F  // Kontrola vyp�rovania FA a DL
        Icb_CprRef_F  // Prenos nakupnych cien z ODL
        Doc_MisNum_F  // Zoznam chybajucich dokladov
        Doc_OitMsd_F  // Online odoslanie dokladov
        Icb_IcnVer_F  // Kontrola intern�ho ��sla dokladu
        Icb_FacDel_F  // Zrusit faktoring dokladu
        // Pokladna
        Cas_IncDoc_F  // Prijem poc. stavu do FM
        Cas_ExpDoc_F  // Prijem poc. stavu do FM
        // Servis
        Icb_MgRef_F   // Obnova tovarovych skupin
        Icb_FgCalc_F  // Prepocet vyuctovecej meny
        Icb_AcvClc_F  // Prepocet uctovnej meny
        Doc_AcvClc_F  // Prepocet uctovnej meny
        Icb_MsnRef_F  // Doplnenie mernej jednotky
        Icb_IcnDel_F  // Mazanie pr�zdnych pozn�mok
        Doc_ItmRef_F  // Obnova udajov poloziek
        Icb_ItmVer_F  // Kontrola DPH poloziek
        ItmRnd_F      // prepocet a zaokruhlenie poloziek
        Icb_DocMov_F  // Presun do inej knihy
        // Ostatne
        Icb_BonAdd_F  // Pridavanie bonusovej akacie

        Icb_SaleLim_F // ???

Spe_F - Evidencia z�lohov�ch platieb
        // Zobrazit
        Spe_Conto_F   //
        Spe_SpvLst_F  //
        // Tlac
        Spe_IncDoc_F  //
        Spe_ExpDoc_F  //
        // Nastroje
        Spe_IncSpd_F  // Vykaz zalohovych prijmov
        Spe_ExpSpd_F  // Vykaz cerpania zaloh
        Spe_SpdSum_F
        Spe_DocFlt_F  // Filter precerpanych zaloh
        SpeEdi_F      //
        // Udrzba
        Spe_ReCalc_F  //
        // Servis
        Spe_TxtExp_F  //

Svb_F - Evidencia fakt�r z�lohov�ch platieb
        // Zobrazit
        Jrn_AccLst_V  //
        // Udrzba
        Key_BokAdd_F  //
        Key_SvbEdi_F  // Dodavatelske dodacie listy
        {Icb_Sending_F}                                                         DEL

Cas_F - Maloobchodn� predaj
        // Upravy
        Cas_SaveItm_F // Premiestnit do inej uctenky
        // Nastroje
        Cas_CrdLst_V  //
        Cas_DocPrn_F  //
        Gsc_GsLst_V   //
        Cas_Close_F   //
        Cas_TFile     //
        Cas_ItmDsc_F  //
        Doc_PdnSlct_V //
        Pab_PacLst_V  //
        Spe_IncDoc_F  //
        Spe_DocLst_V  //
        Cas_DocDsc_F  //
        Cas_AddTns_F  // Pridant na ucet izby
        Cas_PayLst_V  //
        Sys_StkLst_V  //
        Cas_UniDoc_V  // Nacitat elektronicky doklad
        Cas_BlkLst_F  // Otvorenie pokladnicnej uctenky s nazvom
        Cas_BlkLst_V  // Zoznam otvorenych dokladov
        Cas_CrdRead_F // Identifik�cia cez z�kazn�ku kartu
        Cas_LstVie_F  // Tlac dokladov
        // Pokladna
        Cas_IncDoc_F  // Prijem do pokladne
        Cas_ExpDoc_F  // Vydaj z pokladne
        Cas_PayChg_F  // Zmena platidla
        Cas_Calcul_F  //
        Cas_PrnRep_F  // Tlac pokladnicneho hlasenia na zadany den
        // Konfiguracia
        Cas_SetProp_F //

Eis_F - �daje pre internetov� obchod
        // Nastroje
        Eis_DmgLst_V  // Zak�zan� tovarov� skupiny                              DEL
        Eis_ExpDat_F  // Export pre internetovy obchod

Tom_F - Z�znamn�kov� predaj - klientsk� �as�
        // Upravy
        Tom_DocEdit_F // Formular vykazu
        Tom_DocDsc_F  // Zlava na doklad
        Tom_EpcEdit_F // Zodpovedn� osoby
        // Zobrazit
        Tom_ItmLst_V  // Polozky dokladu
        Tom_NitLst_V  // Zoznam nepredajneho skladu
        Tom_NocLst_V  // Zoznam nesplnenych dodavok
        Tom_ToaLst_V  // Archivovane terminalove vydajky
        Tom_TohLst_V  // Nevyuctovane terminalove vydajky
        Tom_DitLst_V  // Zoznam zru�en�ch polo�iek
        // Nastroje
        Tom_OceLst_V  // Expedi�n� list
        Exb_ExdGen_F  // Vyhotovenie expedicneho prikazu
        Tom_TodVer_F  // Kontrola pred vyuctovanim
        Tom_CadGen_F  // Vy��tova� doklad cez ERP
        Tom_IcdGen_F  // Vy��tova� doklad cez OFA
        Tom_OcdGen_F  // Vy��tova� doklad cez ZKV
        Tom_TcdGen_F  // Vy��tova� doklad cez ODL
        Tom_OmdGen_F  // Vy��tova� doklad cez ISV
        Tom_FmdGen_F  // Vy��tova� doklad cez FMS
        Tom_IcdGen1_F // Vy��tova� doklad cez OFA - Pozicny system
        Pob_SalEvl_F  // Vyhodnotenie predaja
        Pob_DlrEvl_F  // Vyhodnotenie predaja
        IncDoc_F      // Prijem zalohovej platby
        // Udrzba
        Key_BokAdd_F  //
        Key_TobEdi_F  // Dodavatelske dodacie listy
        Tom_AItLst_V  // Polo�ky terminalov�ch vydajok
        Tom_IcnRef_F  // Doplni� ��sla odberatelsk�ch fakt�r
        Tom_TrmClc_F  // Financne vyhodnotenie terminvalov
       // Servis
        Tom_StsVer_F  // Kontrola rezervacii STS
        Tom_EpcRef_F  // Doplnenie zodpovedn�ch os�b
        Tom_OctLst_F  //
        Tom_GenVer_F  //
        Tom_CrdClc_F  // Prepo�et z�kazn�ckych bonusov
        Tom_SrvLst_F  // Servis - prezeranie a oprava poloziek
        Tom_SpmVer_F  // Kontrola poz�ci� termin�lov�ch v�dajok s pohybmi poz�ci�
        Tob_TcdRef_F  // Obnovenie �dajov ODL z TOM
        Tob_TcdIcv_F  // Nacitanie NC z ODL
        Cai_BlkVie_F

Pob_F - Pozi�n� v�daj tovaru
        // Uravy
        Pob_DocDsc_F  // Z�ava na vybran� doklad
        // Zobrazit
        Pob_PoiLst_F  // Zoznam poloziek dokladu
        // Nastroje
        Gpm_ExdGen_F  // Tvorba expedi�n�ch pr�kazov
        Pob_FmdGen_F  // Vy��tova� doklad cez FMS
        Pob_IcdGen_F  // Vy��tova� doklad cez OFA
        // Servis
        Pob_TodImp_F  //

// Maloobchodny predaj
Cab_F - Knihy registra�n�ch pokladn�
        // Zobrazit
        Cab_TbiLst_F  //
        // Nastroje
        Cab_CahRef_F  // Nacitanie pokladnicnych udajov
        Cab_CdyEvl_F  //
        Cab_CmgEvl_F  //
        Cab_CasSnd_F  // Posla� �daje do pokladne
        // Udrzba
        Sys_CasLst_F  //

Sab_F - Skladov� v�dajky MO predaja
        // Zobrazit
        Sab_SaiLst_F  // Polozky vybraneho dokladu
        Sab_SagLst_F  // Trzba pod�a tovarov�ch skup�n
        Sab_SacLst_F  // Zoznam vyrobkov a komponentov
        Sab_CasPay_V  // Trzba podla platobnych prostriedkov
        Sab_NsiLst_F  // Nevysporiadan� polo�ky MO predaja
        Sab_NscLst_F  // Nevysporiadan� polo�ky MO predaja - komponenty
        Jrn_AccLst_V  // ��tovn� z�pisy vybraneho dokladu
        SapLst_V      // Zoznam za��tovania �hrad FA
        SabSac_V      // Nevysporiadane komponenty
        SacLst_V      // Zoznam komponentov
        // Tlac
        Sab_SadPrn_F  //
        // Nastroje
        Cab_SalProc_F // Spracovanie pokladnicneho predaja
        Sab_Refund_F  //
        Sab_CadVer_F  //
        Sab_SabVer_F  //
        Sab_SaiLos_F  // Polozky so zapornym ziskom
        Sab_AccDoc_F  // Za��tova� registra�n� poklad�u
        // Udrzba
        Sab_DocClc_F  // Prepocet podla poloziek
        Key_BokAdd_F  //
        Key_SabEdi_F  // Vlastnosti knihy
        Sab_TbiDel_F  //
        Sab_StmSad_F  // Porovn�vanie dokladu s pohybmi
        Sab_StmSaa_F  // Porovn�vanie dokladov s pohybmi
        Sab_SagClc_F  // Prepo�et pod�a tovarov�ch skup�n
        Sab_SaiSyn_F  // Synchronizacia zakladnych udajov
        Sab_DelOut_F  // Vr�ti� v�etko na sklad
        Doc_OitMsd_F  // Interny prenos dokladov
        SabAcv_F      // Kontrola zauctovania dokladov
        // Servis
        Sab_DocDel_F  //
        Sab_SaiRef_F  //
        Sab_CpiVer_F  // Kontrola predaja podla komponetov
        Sab_MgcChg_F  // Zmena tovarovej skupiny

Cai_F - Inform�cie pokladni�n�ho predaja
        // Hladat
        Cai_GsSrch_F  // Vyh�ad�vanie pokladni�n�ch dokladov pod�a zadan�ho tovaru
        Cai_QntSrc_F  // Vyh�ad�vanie pokladni�n�ch dokladov pod�a zadan�ho mno�stva
        // Zobrazit
        Cai_CasInf_F  // Okam�it� denn� tr�ba
        Cai_CgsEvl_F  // Okam�it� predaj pod�a tovaru
        // Nastroje
        Cai_CusEvl_F  // Vyhodnotenie n�kupu z�kazn�kov
        Cai_CurEvl_F  // Vyhodnotenie predaja pokladn�kov
        Cai_CsdPrn_F  // Tla� k�pie pokladni�nej ��tenky
        Cai_PayEvl_F  // Vyhodnotenie predaja pokladn�kov
        Cai_CasBtm_F  // Vyhodnotenie �asu ��tovania
        Cai_CusExp_F  // Export nakupu zakaznikov do e-journalu LYONESS
        // Udrzba
        Cai_PckVer_F  // Kontrola obalov�ch tovarov
        Cai_BlkVer_F  // Kontrola dokladov
        // Storna
        Cai_CacItm_F  // Polo�kovit� zoznam storien
        Cai_CanItm_F  // Polo�kovit� zoznam reklamacii
        Cai_CacUsr_F  // Kumulat�vne pod�a pokladn�kov

Cdc_F - Tla� k�pi� dokladov
        ItmRnd_F      // Prepocet a zaokruhlenie poloziek dokladu
        Icb_ExpTxt_F  // Ulo�i� do textov�ho s�boru

Cac_F - V�kaz denn�ch uz�vierok
        // Nastroje
        CacLst_F      // Vlastnosti vybranej knihy
        CacCol_F      // Vlastnosti vybranej knihy

// Riadenie logistiky
// Riadenie servisu
Scb_F - Servisn� z�kazky
        // Upravy
        Scb_SchEdi_F  // Hlavicka servisnej zakazky
        Scb_SchEdt_F  // Hlavicka servisnej zakazky
        // Zobrazit
        Scb_SciLst_F  // Polo�ky vybran�ho dokladu
        Scb_ScgStk_F  // Sklad servisovan�ho tovaru
        // Nastroje
        Scb_DocFlt_F  // Filtrovanie servisn�ch z�kaziek
        Scb_JudClm_F  // Pos�senie servisn�ho pr�padu
        Scb_SolAcl_F  // Rie�enie servisn�ho pr�padu - uznan� reklam�cia
        Scb_SolNcl_F  // Rie�enie servisn�ho pr�padu - neuznan� reklam�cia
        Scb_RetScg_F  // Vr�ti� tovar z�kazn�kovi
        Scb_BegRep_F  // Zah�jenie servisn�ch pr�c
        Scb_EndRep_F  // Ukon�enie servisn�ch pr�c
        Scb_RepSnd_F  // Z�znam odoslania do opravy
        Scb_RepRcv_F  // Z�znam vr�tenia z opravy
        Scb_Cls101_F  // Ukon�enie servisn�ho pr�padu - vlastn� oprava
        Scb_Cls102_F  // Ukon�enie servisn�ho pr�padu - v�mena
        Scb_Cls103_F  // Ukon�enie servisn�ho pr�padu - dobropis
        Scb_EndMsg_F  // Ozn�menie ukon�enia servisu
        Scb_TrmVer_F  // Kontrola dodr�ania leh�t
        // Servis
        Scb_SciDir_V  // Polozky vsetkych dokladov

Clb_F - Z�kazn�cke reklam�cie
        // Udrzba
        Clb_ClbEdit_F // Vlastnosti vyrbanej knihy
        Doc_OitMsd_F  // Interny prenos dokladov

// Kompenzacna vyroba
Cmb_F - Kompletiz�cia v�robkov
        // Upravy
        Cmb_CmhEdit_F // Hlavicka vybraneho dokladu
        // Zobrazit
        Cmb_CmiLst_F  // Polozky vybraneho dokladu
        // Tlac
        Cmb_DocPrn_F  // Tlac vybraneho dokladu
        Cmb_CmdPrn_F  // Zoznam dokladov za obdobie
        // Nastroje
        Cmb_CmpDoc_F  // Kompletizacia vybraneho vyrobku
        Cpb_CphLst_V  // Kalkul�cia vyrobkov
        // Udrzba
        Key_BokAdd_F  // Zalozit novu knihu
        Key_CmbEdi_F  // Kniha kompletizacii
        Cmb_StmCmi_F  //
        Cmb_StmCma_F  // Porovn�vanie dokladov s pohybmi
        // Servis
        Cmb_CmiToN_F  //
        Cmb_ItmRev_F  //

Cpb_F - Kalkul�cia v�robkov
        // Upravy
        Gsc_GsLst_V   // Pridat novy vyrobok
        {Cpb_CphEdit_F}
        Cpb_CphEdi_F  // Hlavicka vybraneho dokladu
        // Zobrazit
        Cpb_CpiLst_V  // Polozky vybraneho dokladu
        Cpb_CpiLst_F  // Polozky vybraneho dokladu
        Cpb_CphLst_F  // Vyrobky vybraneho komponentu
        // Tlac
        Cpb_DocPrn_F  // Tlac vybraneho dokladu
        // Nastroje
        Cpb_CpiCmi_F  // Generovat podla kompletizacii
        // Udrzba
        Cpb_CpbEdit_F // Vlastnosti vybranej knihy

// Priemyselna vyroba
// Financne uctovnictvo
Isb_F - Dod�vate�sk� fakt�ry
        // Upravy
        Isb_IshEdit_F // Hlavicka dodavatelskej faktury
        Isb_DocDel_F  // Zrusenie vybranej faktury
        Isb_DocDsc_F  // Z�ava na fakt�ru
        Isb_DocRnd_F  // Zaokr�hlenie dokladu
        Isb_DocRev_F  // Uprava faktury
        Isb_FgdRev_F  // Uprava faktury - zahranicna faktura
        Isb_DocSpc_F  // �pecifik�cia vybran�ho dokladu
        Doc_VatChg_F  // Zmena sadzieb DPH
        // Zobrazit
        Isb_IsiLst_F  // Polozky vybranej faktury
        Inv_PayLst_V  // Historia uhrady faktur
        Isb_PmqLst_V  // Historia prevodnych prikazov
        Isb_NpyIsd_V  // Neuhraden� fakt�ry dod�vate�ov
        Jrn_AccLst_V  // Uctovne zapisi dokladu
        Acc_PmiLst_V  // Dennik uhrady dokladov
        Isb_IswLst_V  // Evidencia upomienok
        // Tlac
        Isb_DocPrn_F  // Tlac vybraneho dokladu
        Isb_IsdPrn_F  // Zoznam dokladov za obdobie
        // Nastroje
        Isb_DocFlt_F  // Filtrova� dod�vate�sk� fakt�ry
        Isb_IsdFilt_F // Filtrovamie do�l�ch fakt�r
        Isb_TsdPair_F // Parovanie s dodacim listom
        Isb_DocCopy_F // Kopirovanie dokladu
        Isb_IsdPay_F  // Zavazky k zadanemu datumu
        Isb_IspEvl_F  // Zavazky podla splatnosti
        Isb_IsdLiq_F  // Likvid�cia dod�vatelskej faktury
        // Udrzba
        Key_BokAdd_F  // Zalo�i� nov� knihu
        Key_IsbEdi_F  // Dodavatelske FA Key_SabEdi_F;
        Isb_PmiVer_F  // Kontrola �hrady fakt�r
        Isb_IsnVer_F  // Kontrola intern�ho ��sla dokladu
        Isb_IsdVer_F  // Hodnotov� kontrola dokladov
        Doc_MisNum_F  // Zoznam chybajucich dokladov
        Doc_OitMsd_F  // Intern� prenos dokladov
        Doc_ItmRef_F  // Obnova udajov poloziek
        // Servis
        Doc_AcvClc_F  // Prepocet uctovnej meny
        Isb_IsdRen_F  // Precislovanie dokladov
        Isb_AccDate_F // Doplni� d�tum roz��tovania
        Isb_DocDate_F // Doplni� d�tum FA do polo�iek
        Isb_IsiDir_V  // Polo�ky v�etk�ch fakt�r
        Isb_CrsChg_F  // Prepo�et fakt�ry pod�a zmenen�ho kurzu

Csb_F - Hotovostn� pokladne
        // Upravy
        Csb_CshEdit_F // Vybrany pokladnicny doklad
        Csb_EndCalc_F // Prepo�et kone�n�ho stavu
        Csb_DocSpc_F  // �pecifik�cia vybran�ho dokladu
        // Zobrazit
        Csb_CsdSum_F  // Kumulativne udaje pokladne
        Csb_CsoInc_V  // Pr�jmov� hotovostn� oper�cie
        Csb_CsoExp_V  // V�dajov� hotovostn� oper�cie
        Jrn_AccLst_V  // Zoznam ��tovn�ch z�pisov
        Acc_PmiLst_V  // Denn�k �hrady fakt�r
        // Tlac
        Csb_DocPrn_F  // Tlac pokladnicneho dokladu
        Csb_MtbPrn_F  // Tlac mesacnej pokladnicnej knihy
        // Nastroje
        Csb_DocFlt_F  // Filtrova� pokladni�n� doklady
        Csb_CsfRep_F  // Vykaz platieb fyzickym osobam
        Csb_AccPer_F  // Zauctovanie dokladov za obdobie
        // Udrzba
        Key_BokAdd_F  //
        Key_CsbEdi    // Dodavatelske dodacie listy
        Csb_CsiDir_V  // Polo�ky v�etk�ch dokladov
        Csb_PmiVer_F  // Kontrola uhrady faktur
        Csb_CntClc_F  // Prepo�et kone�n�ho stavu
        Csb_AccRef_F  // Obnova predkontacie faktur
        Doc_OitMsd_F  // Interny prenos dokladov
        // Service
        Csb_CshRen_F  // Precislovanie pokladnicnych dokladov
        Csb_CsiRef_F  // Doplnenie �dajov polo�iek dokladov
        Csb_PacRef_F  // Doplnit kod firmy do polozeik

Sob_F - Bankov� v�pisy
        // Upravy
        Sob_SohEdit_F // Hlavicka bankoveho vypisu
        // Zobrazit
        Sob_SoiLst_F  // Polozky bankoveho vypisu
        Acc_PmiLst_V  // Denn�k �hrady fakt�r
        Jrn_AccLst_V  //
        // Tlac
        Sob_DocPrn_F  //
        // Nastroje
        Sob_AboOtp_F  // Elektronick� bankov� v�pis - OTP
        Sob_AboSls_F  // Elektronick� bankov� v�pis - SLOVENSKA SPORITELNA
        Sob_AboSbr_F  // Elektronick� bankov� v�pis - SBERBANK
        Sob_AboUni_F  // Elektronick� bankov� v�pis - UNICREDIT
        Sob_SomLst_V  // Evidencia bankov�ch oper�ci�
        Sob_EndCalc_F // Prepo�et kone�n�ho stavu
        Sob_AboDat_V  // �daje elektronickeho bankovn�ctva
        // Udrzba
        Key_BokAdd_F  // Zalo�i� nov� knihu
        Key_SobEdi_F  // Dodavatelske dodacie listy
        Sob_AccCalc_F // Prepo�et polo�iek pod�a kurzu
        Sob_PmiVer_F  // Kontrola uhrady faktur
        Doc_OitMsd_F  // Interny prenos dokladov
        Sys_LdgFlt_F  // Filtrovanie dokladov
       // Service
        Sob_AccPdf_F  // Predkont�cia rozdielov �hrady
        Sob_SoiDir_V  // Polo�ky v�etk�ch bankov�ch v�pisov
        Sob_PacRef_F  // Doplnit kod firmy

Pqb_F - Prevodn� pr�kazy
        // Upravy
        Pqb_PqhEdit_F // Hlavicka vybraneho dokladu
        Pqb_NpyIsd_F  // Neuhraden� dod�vate�sk� fakt�ry
        // Zobrazit
        Pqb_PqiLst_F  // Polozky vybraneho dokladu
        // Tlac
        Pqb_DocPrn_F  // Tlac vybraneho dokladu
        // Nastroje
        Sys_LdgFlt_F  // Filtrovanie dokladov
        Pqb_AboSnd_F  // Elektronicke bankovnictvo - OTP
        Pqb_AboSbr_F  // Elektronicke bankovnictvo - SBERBANK
        Pqb_AboUni_F  // Elektronicke bankovnictvo - UNICREDIT
        Pqb_AboVub_F  // Elektronicke bankovnictvo - VUB
        Pqb_AboSls_F  // Elektronicke bankovnictvo - SLSP
        // Udrzba
        Key_BokAdd_F  //
        Key_SobEdi_F  // Dodavatelske dodacie listy

Vtb_F - Evidencia DPH - star� //                                                 DEL
        // Upravy
        Vtb_NopVat_F  //                                                         DEL
        Vtb_ClsDel_F  //                                                         DEL
        Vtb_AddCls_F  // Pridat novu uzavierku DPH                               DEL
        // Zobrazit
        Vtb_VatDoc_V  //                                                         DEL
        Pab_EuStat_V  //                                                         DEL
        Vtb_VtcLst_V  //                                                         DEL
        Vtb_VtcSpc_V  //                                                         DEL
        // Tlac
        Vtb_VtdPrn_F  //                                                         DEL
        // Nastroje
        Vtb_ActVer_F  //                                                         DEL
        Vtb_JrnVer_F  //                                                         DEL
        Vtb_NapVat_F  //                                                         DEL
        Vtb_VatVer_F  //                                                         DEL
        Vtb_SrvCrt_F  // S�hrnn� v�kaz DPH                                       DEL

Vtr_F - Evidencia DPH
        // Upravy
        Vtb_NopVat_F  // Neuhraden� DPH k zadan�mu d�tumu
        Vtr_ClsDel_F  // Zrusit vykaz uzavierky DPH
        Vtr_AddCls_F  // Pridat novu uzavierku DPH
        // Zobrazit
        Vtr_DocLst_V  // Vsetky polozky vykazu DPH
        Vtr_VtiLst_V  // Polozky kontrolneho vykazu DPH
        Pab_EuStat_V  // Zoznam �lensk�ch �t�tov EU
        Vtb_VtcLst_V  // Zoznam kalkula�n�ch obdob�
        Vtr_VtdSpc_V  // Specifikacia dokladov DPH
        // Tlac
        Vtr_VtdPrn_F  // Tlac danoveho priznania
        // Nastroje
        Vtr_ActVer_F  // Porovnavanie s aktualnym stavom
        Vtr_JrnVer_F  // Porovnavanie s dennikom UZ
        Vtr_NapVat_F  // Vykaz neuplatnenej DPH
        Vtr_VatVer_F  // Kontrola spr8vnosti ciastky DPH
        Vtr_SrvCrt_F  // S�hrnn� v�kaz DPH
        VtrXms_F      // Generovanie suhrnneho v�kazu DPH do XML
        VtrXmr_F      // Generovanie v�kazu DPH do XML
        VtrXmi_F      // Generovanie kontroln�ho v�kazu DPH do XML
        // Udrzba
        Key_VtrEdi_F  // Inicializa�n� parametre

Acv_F - ��tovn� pom�cky
        // Nastroje
        Acv_AccVer_F  // Kontrola rozuctovanosti dokladov
        Acv_MetVer_F  // Kontrola spravnosti metodiky uctovania
        Acv_BlcVer_F  // Kontrola bilancie uctovnych zapisov
        Acv_SntInv_F  // Inventarizacia suvahovych ��tov
        Acv_TsdNop_F  // Vykaz nevyfakturovanych dodavok

Srb_F - V�kazy liehov�ch v�robkov
        // Upravy
        Srb_DocEdit_F // Hlavicka vykazu liehovych vyrobkov
        SrdEdi_F      // Hlavicka vykazu liehovych vyrobkov 2011
        Srb_DocDel_F  // Zrusenie vykazu liehovych vyrobkov
        Srb_Collect_F // Zber udajov do vybraneho vykazu
        SrbCol_F      // Zber udajov do vybraneho vykazu
        // Zobrazit
        Srb_SrCat_V   // Evidencia liehov�ch v�robkov
        Srb_SrSta_V   // Mesa�n� stav liehov�ch v�robkov
        Srb_SrMov_V   // Mesa�n� stav liehov�ch v�robkov
        // Tlac
        Srb_DocPrn_F  // Tlac vybraneho vykazu
        // Nastroje
        Srb_XmlExp_F  // Generovanie XML

Srd_F - V�kazy liehov�ch v�robkov
        // Upravy
        SrdEdi_F      // Hlavicka vykazu liehovych vyrobkov 2011
        SrbCol_F      // Zber udajov do vybraneho vykazu
        // Zobrazit
        SrbCat_V      // Evidencia liehov�ch v�robkov
        SrbSta_V      // Mesa�n� stav liehov�ch v�robkov
        SrbMov_V      // Mesa�n� stav liehov�ch v�robkov
        // Tlac
        SrbPrn_F      // Tlac vybraneho vykazu
        {Srb_DocPrn_F}// Tlac vybraneho vykazu
        // Nastroje
        SrbXml_F      // Zru�enie v�kazu
        SrbImp_F      // V�kaz liehov�ch v�robkov
        SrbRep_F      // V�kaz liehov�ch v�robkov
        SrbSum_V      // Mesa�n� stav liehov�ch v�robkov

Mtb_F - Skladov9 karty MTZ {Evidencia u��vate�ov syst�mu}                       DEL
        // Upravy
        Mtb_StcEdit_F //                                                        DEL
        Mtb_ImdEdit_F //                                                        DEL
        Mtb_OmdEdit_F //                                                        DEL
        // Tlac
        Mtb_MtsPrn_F  //                                                        DEL
        Mtb_MtiPrn_F  //                                                        DEL
        Mtb_MtoPrn_F  //                                                        DEL

Crs_F - Kurzov� list n�rodnej banky                                             DEL
        // Upravy
        Crs_CrhEdit_F // Denn� kurz dev�z                                       DEL
        // Nastroje
        Crs_RcvDat_F  // Nacitat kurzovy list NBS                               DEL
        Crs_RcvEcb_F  // Nacitat kurzovy list ECB                               DEL

Owb_F - Vy��tovanie slu�obn�ch ciest                                            DEL
        // Upravy
        Owb_OwhEdit_F // Hlavicka cestovn�ho pr�kazu                            DEL
        // Zobrazit
        Owb_OwiLst_F  // Polozky vybraneho dokladu                              DEL
        Jrn_AccLst_V  // Uctovne zapisi dokladu                                 DEL
        Acc_PmiLst_V  // Dennik uhrady dokladov                                 DEL
        Inv_PayLst_V  // Uhrady vybraneho dokldu                                DEL
        // Tlac
        Owb_DocPrn_F  // Tlac vyuctovania sluzobnej cesty                       DEL
        // Nastroje
        Owb_CshLst_V  // Parovanie s pokladnicnym dokladom                      DEL
        // Udrzba
        Key_BokAdd_F  // Zalozit novu knihu                                     DEL
        Key_OwbEdi_F  // Dodavatelske dodacie listy                             DEL

Dpb_F - Post�pen� a odk�pen� poh�ad�vky
        // Upravy
        Dpb_DocEdi_F  // Zalo�i� hlavicku zmluvy
        // Zobrazit
        Inv_PayLst_V  // Hist�ria �hrady fakt�ry
        Dpb_SitLst_V  // Pohladavky vybranej zmluvy

// Jednoduche uctovnictvo
Fna_F - Predkonta�n� predpisy
        // Upravy
        Fna_ItmEdit_F // Editor predkonta4n0ho predpisu

Fjr_F - Pe�a�n� denn�k
        // Zobrazit
        Fjr_FinInf_F  // Stav penaznych prostredkov
        // Tlac
        Fjr_PrnDoc_F  // Tlac penazneho dennika
        // Nastroje
        Fjr_ItmFlt_F  // Filtrova� pe�a�n� denn�k
        Fjr_AddBeg_F  // Za��tova� po�iato�n� stav

Fri_F - V�kaz pr�jmov a v�dajov
        // Upravy
        Fri_AddDoc_F  // Prida� nov� v�kaz

Frp_F - V�kazy o majetku a z�v�zkoch
        // Upravy
        Frp_AddDoc_F;    // Prida� nov� v�kaz

// Podvojne uctovnictvo
Jrn_F - Denn�k ��tovn�ch z�pisov
        // Zobrazit
        Acc_AccSnt_V  // ��tovn� osnova syntetick�ch ��tov
        Acc_AccAnl_V  // ��tovn� osnova analytick�ch ��tov
        Jrn_NotRnd_F  // Nezaokr�hlen� ��tovn� z�znamy
        Jrn_BegClc_F  // Po�iato�n� stavy
        // Nastroje
        Jrn_AccFilt_F // Filtrovanie uctovnych zapisov
        Jrn_AccSum_F  // Obrat uctu za obdonie
        Jrn_AccMov_F  // Pohyby vybraneho uctu
        Jrn_AccBlc_F  // Vykaz saldokontnych uctov
        Jrn_SuvCalc_F // Vykaz suvahov�ch ��tov
        Jrn_VysCalc_F // Vykaz v�sledovkov�ch ��tov
        Jrn_DefCalc_F // Vykaz definovan�ch ��tov
        // Servis
        Jrn_StmJrn_F  // Kontrola podla skladovych pohybov
        Jrn_BookVer_F // Kontrola podla knih dokladov

Acc_F - Obratov� predvaha ��tov
        // Tlac
        Acc_TrnPrn_F  // Tla� obratovej predvahy
        // Nastroje
        Jrn_AccMov_F  // Pohyby vybran�ho ��tu
        Acc_ReCalc_F  // Prepo�et obratovej predvahy

Act_F - V�kaz obratovej predvahy
        // Upravy
        Act_AddAct_F  // Pridat novy vykaz
        Act_DelAct_F  // Zrusit vybrany vykaz
        // Zobrazit
        Act_ItmLst_V  // Zoznam poloziek vykazu

Blc_F - ��tovn� v�kazy
        Blc_Upgrade_F // Aktualiz�cia podvojn�ho ��tovn�ctva
        Blc_Calc_F    // V�po�et nov�ho v�kazu
        Blc_SuvDef_F  // Defin�cia riadku s�vahy
        Blc_VysDef_F  // Defin�cia riadku v�sledovky
        Blc_SuvPrev_F // Stav v minulom ��tovnom obdob�
        Blc_VysPrev_F // Stav v minulom ��tovnom obdob�
        Blc_SuvCalc_V // Kalkula�n� vzorec riadku v�kazu s�vahy
        Blc_VysCalc_V // Kalkula�n� vzorec riadku v�kazu v�sledovky

Idb_F - Intern� ��tovn� doklady
        // Upravy
        Idb_IdhEdit_F // Havicka vybraneho dokladu
        Idb_DelDoc_F  // Zru�enie ��tovn�ho dokladu
        // Zobrazit
        Idb_IdiLst_F  // Polozky vybranehod dokladu
        Jrn_AccLst_V  // Uctovne zapisy dokladu
        // Tlac
        Idb_DocPrn_F  // Tlac vybraneho dokladu
        // Nastroje
        Idb_IddFilt_F // Filtrovanie internych dokladov
        Idb_AccClose_F// Uzatvorenie analytickych uctov
        Idb_AccOpen_F // otvorenie suvahovych uctov
        Idb_CrdAcc_F  // Zauctovanie kurzovych rozdielov
        Idb_DocCopy_F // Kopirovanie vybraneho dokladu
        Idb_ImpItm_F  // Import poloziek dokladu
        // Udrzba
        Key_BokAdd_F
        Key_IdbEdi_F  // Vlastnosti knihy
        Idb_PmiVer_F  // Kontrola �hrady fakt�r
        Idb_IdiDir_V  // Polo�ky v�etk�ch dokladov
        Idb_CrdDif_F  // Dodatocne pridane polozky
        // Service
        Idb_IdhRen_F  // Precislovanie dokladov
        Idb_PacRef_F  // Doplnenie kodu firmy

Rcr_F - Koncoro�n� prekurzovanie fakt�r
        // Upravy
        Rcr_IsdCol_F  // Zber neuhradenych zahranicnych DF
        Rcr_IsdRcr_F  // Vypocet kurzovych rozdielov DF
        Rcr_IsdAcc_F  // Zauctovanie kurzovych rozdielov DF
        Rcr_IcdCol_F  // Zber neuhradenych zahranicnych OF
        Rcr_IcdRcr_F  // Vypocet kurzovych rozdielov OF
        Rcr_IcdAcc_F  // Zauctovanie kurzovych rozdielov OF
        // Zobrazit
        Rcr_IsdRcr_V  // Zoznam prekurzovan�ch fakt�r
        Rcr_IcdRcr_V  // Zoznam prekurzovan�ch fakt�r

// Evidencia majetku
Fxb_F - Evidencia majetku
        // Upravy
        Fxb_CrdEdit_F // Evidncna karta majetku
        // Zobrazit
        Fxb_FxaGrp_V  //
        Fxb_FxtGrp_V  //
        Fxb_FxtLst_V  //
        Fxb_FxlLst_V  //
        Fxb_FxcLst_V  //
        Fxb_FxmLst_V  //
        // Tlac
        Fxb_PrnCrd_F  // Tlac vybranej evidencnej karty
        // Nastroje
        Fxb_Recalc    //
        Fxb_AsdFxa_F  // Vyradenie majetku z uzivania
        // Servis
        Fxb_FxlDir_V  //
        Fxb_SulClc_F  // Prepocet sadzby uctovnych dopisov
        Fxb_SutClc_F  // Prepocet sadzby danovych dopisov
        Fxb_Book_F    //
        Fxb_Filt_F    //
        Fxb_Info_F    //
        Fxb_ActSuPrn_F//
        {Fxb_Aside_F}
        Fxb_Acc_F     //

// Fxm_F -

// Riadenie ekonomiky
Asc_F - Anal�za z�v�zkov a poh�ad�vok
        // Upravy
        Asc_DocEdi_F  // Anal�za z�v�zkov a poh�ad�vok
        Asc_DocDel_F  // Zru�i� vybran� v�kaz                                   !

// Logistika
RbaSta_F - V�kaz v�robnej �ar�e

// Manazment
Sta_F - �tatistika n�kupu a predaja
        // Nakup
        Sta_TopSap_F  // Vyhodnotenie najlepsich dodavatelov
        !Sta_SapGsl_V // N�kup vybran�ho dod�vate�a
        Sta_SapPay_F  // Sucet platieb pre dodavatela
        // Predaj
        Sta_TopCus_F  // Vyhodnotenie najlepsich doberatelov
        Sta_CtySal_F  // Vyhodnotenie predaja podla miest
        Sta_SalGsp_F  // Predaj tovaru podla odberatelov
        Sta_SalPam_F  // Predaj odberate�a pod�a skup�n
        Sta_SalNul_F  // Predaj odberate�a pod�a skup�n
        //
        Sta_SalEvl_F  // Vyhodnotenie MO a VO predaka
        Sta_IcdPrf_F  // Ziskovost odberatelskych faktur
        //
        Sta_WriEvl_F  // Vyhodnotenie predaja prev�dzky
        Sta_WmgEvl_F  // Vyhodnotenie predaja pod�a skup�n
        Sta_WgsEvl_F  // Vyhodnotenie predaja pod�a tovaru
        // Sklad
        Sta_DayGsm_F  // Denny prijem a vydaj tovar
        Sta_GscMov_F  // Mesacny prijem a vydaj tovaru
        Sta_MgcMov_F  // Prijem a vydaj podla tovarovych skupin
        //
        Sta_WrsEvl_F  // Vyhodnotenie skladov prev�dzok
        // Ostatne
        Sta_StmAll_F  // Vyhodnotenia skladovych pohybov
        Sta_CstExp_F  // Export do centr�lnej �tatistiky

Seb_F - V�berov� �tatistika predaja
        // Upravy
        Gsc_GsLst_V   //
        Seb_Collect_F //
        // Udrzba
        Seb_SebEdit_F //

Npb_F - Z�znamy o probl�moch                                                    DEL
        // Upravy
        Npb_NpdEdit_F                                                           DEL
        Npb_NpSend_F                                                            DEL
        Npb_NpProc_F                                                            DEL
        Npb_NpSolv_F                                                            DEL

Rew_F - Odmeny pre obchodn�kov                                                  DEL
        // Upravy
        Rew_AddRep_F  // Pridat novy vykaz                                      DEL
        Rew_DelRep_F  // Zrusit vybrany vykaz                                   DEL
        // Zobrazit
        Rew_ItmLst_V  // Zoznam poloziek vykazu                                 DEL

Wab_F - V�po�et odmeny zamestnancov
        // Upravy
        Wab_WahEdi_F  // Editor na zalozenie noveho vykazu
        // Zobrazit
        Wab_WaeLst_V  // Zoznam zamestnancov vybraneho dokladu
        // Nastroje
        Sys_EpcLst_V  // Zoznam zamestnancov
        Wab_EpgLst_V  // Zamestnaneck� skupiny

Dsp_F - V�nimky odblokovania z�kazn�ka
        // Upravy
        Dsp_ItmEdi_F  // Pridat nov� v�nimku

Rpl_F - Doporu�en� predajn� ceny
        // Upravy
        Rpl_ImpDat_F  // Na��ta� cennik dodavatela
        Rpl_ImpPls_F  // Na��ta� predajn� cenn�k
        Rpl_ImpNew_F  // Na��ta� nov� polo�ky z NEX
        Rpl_CpyMgp_F  // Hromadn� prenos DC do OC
        Rpl_CpyMgn_F  // Hromadn� prenos OC do OC
        Rpl_ChgMgc_F  // Zmena tovarov�ch skup�n
        Rpl_ItmEdit_F // Upravi� �daje polo�ky
        Rpl_ChgName_F // Prelo�i� n�zoy tovarov
        Rpl_CpyName_F // Prelo�i� n�zoy tovarov
        Rpl_StcEdi_F  // Zmena skladovej pozicie
        // Zobrazit
        Rpl_BokEdi_F  // Vlastnosti cenn�ka
        // Nastroje
        Rpl_ItmFilt_F // Filtrova� polo�ky cenn�ka
        Rpl_DisRpl_F  // Zoznam vyraden�ch polo�iek
        Rpl_StpClc_F  // V�po�et predajn�ch cien
        Rpl_ExcClc_F  // V�po�et �peci�lnych cien
        Rpl_ImpDef_F  // Import z�kladn�ch �dajov
        Rpl_ExpDef_F  // Export z�kladn�ch �dajov
        Rpl_ExpMdc_F  // Export obchodn�ch cien - MEDIACAT
        Rpl_ExpNex_F  // Export �dajov do syst�mu NEX

Prj_F - Spr�va podnikov�ch projektov
        // Upravy
        Prj_DocEdi    // Editor projektu
        // Nastroje
        Prj_DocFlt    // Filtrovanie podla projektu

Prb_F - Spr�va informa�n�ch projektov
        // Upravy
        Prb_DocEdi_F  // Editor projektu
        // Zobrazit
        Prb_ItmLst_V  // Polozky projektu
        Prb_DocClc_F  // Vyhodnotenie projektu
        // Udrzba
        Key_PrbEdi    // Vlastnosti vybranej knihy 

Crb_F - Spr�va z�kazn�ckych po�iadaviek
        // Upravy
        Crb_DocEdi_F  // Editor po�iadavky
        // Zobrazit
        {Prb_ItmLst_V}// Polozky projektu
        {Prb_DocClc_F}// Vyhodnotenie projektu
        // Udrzba
        Key_CrbEdi_F  // Vlastnosti vybranej knihy 

Job_F - Evidencia pracovn�ch �kolov
        // Upravy
        Job_DocEdi    // Prida� �kol
        // Nastroje
        Job_ItmCpy_F  // Kop�rova� �kol

Pxb_F - N�vrh informa�n�ch syst�mov

// Administrativa
Apb_F - �iadosti bezhotovostn�ho styku
        // Upravy
        Apb_DocEdi    // Zalo�i� �iados�
        Apb_DebVer    // Overi� dlhy �iadate�a
        Apb_AprSig    // Schv�li� �iados�
        // Zobrazit
        Apb_DocInf_F  // Zobrazi� �iados�
        Apb_DelLst_V  // Zru�en� �iadosti

Ipb_F - Evidencia do�lej po�ty
        // Upravy
        Ipb_DocEdi_F  //
        Ipb_DetEdi_F  //
        Ipb_DocScn    //
        // Nastroje
        Ipb_IpgLst    //

Eml_F - Elektronick� spr�vy
        // Upravy
        Eml_MsgEdi_F  //
        Eml_MsgVie_F  //
        EmlFlt_F      //
        EmlAdr_F      //

Emc_F - Elektronick� spr�vy
        Emc_MsgEdi_F  //

// Systemove nastroje
Sys_F - Nastavenie syst�mov�ch �dajov
        // Upravy
        Sys_SysProp_F // Vlastnosti informacneho systemu
        Sys_ComProp_F // Komunikacne parametre systemu
        Sys_IniProp_F // Inicializacne parametre systemu
        Sys_OpenDoc_V // Zoznam otvoren�ch dokladov
        Sys_DocCls_F  // Uzatvorenie dokladov syst�mu
        Sys_WriCls_V  // Uzatv�ranie dokladov prev�dzok
        Sys_Device_V  // Nastavenie perifernych zariadeni
        Sys_RegSys_F  // Registr�cia informa�n�ho syst�mu
        // Tla�
        Sys_TicPrn_V  // Tla� platobn�ch kup�nov
        // Nastroje
        Sys_SysLst_V  // Evidencia podsyst�mov
        Sys_CntLst_V  // Evidencia hospod�rskych stredisk
        Sys_WriLst_V  // Evidencia prevadzokov�ch jednotiek
        Sys_StkLst_V  // Evidencia tovarov�ch skladov
        Sys_EpcLst_V  // Evidencia zamestnancov
        Sys_CasLst_V  // Evidencia registracn�ch pokladn�c
        Sys_DlrLst_V  // Evidencia obchodn�ch z�stupcov
        Sys_DrvLst_V  // Evidencia vodi�ov slu�obn�ch vozidiel
        Sys_UsrLst_V  // Evidencia uzivatelov systemu
        Sys_CapDef_V  // Evidencia platobn�ch prostriedkov
        Sys_OitDef_V  // Definicia interneho prenosu udajov
        Sys_RwcLst_V  // Definicia medziprevadzkoveho prenosu
        Sys_MyConto_V // Zoznam bankov�ch ��tov
        Sys_FtpMng_F  // Oznacenie dokladov na FTP prenos
        Sys_ColItm_V  // Evidencia zbernych poloziek
        // Import
        Sys_ImpGsc_F  // Import evidencii tovaru
        Sys_ImpBac_F  // Import druhotn�ch k�dov
        Imp_GscNot_F  // Import pozn�mok k tovarom
        Sys_ImpPac_F  // Import evidencii firiem
        Sys_ImpPls_F  // Import predajneho cenika
        Sys_ImpApl_F  // Import akciov�ho cenika
        Sys_ImpAnl_F  // Import ��tovnej osnovy
        // Rozhranie
        Sys_ExpTps_F  // Export pre TP-SOFT
        Sys_ImpTps_F  // Import zo systemu TP-SOFT
        Imp_SofDat    // Import dokladov systemu SOFTIP
        Imp_SofJrn    // Import ��tovnej d�vky SOFTIP
        Stenia4_F     // Pr�jem tovaru STIHL a nasledn� predaj do AS
        // Service
        Sys_VatChg_F  // Zmena sadzieb DPH
        Sys_ArcYear_F // Uzavierka roka

Ifc_F - Nastavenie syst�mov�ch �dajov
        // Import
        Sys_ImpGsc_F  // Import evidencii tovaru
        Sys_ImpBac_F  // Import druhotn�ch k�dov
        Imp_GscNot_F  // Import pozn�mok k tovarom
        Sys_ImpPac_F  // Import evidencii firiem
        Sys_ImpPls_F  // Import predajneho cenika
        Sys_ImpApl_F  // Import akciov�ho cenika
        // Rozhranie
        Exp_CasRef    // Export REF suborov pre pokladne
        // Rozhranie
        Sys_ExpTps_F  // Export pre TP-SOFT
        Sys_ImpTps_F  // Import zo systemu TP-SOFT
        Imp_SofDat    // Import dokladov systemu SOFTIP
        Imp_SofJrn    // Import ��tovnej d�vky SOFTIP

Usr_F - Evidencia u��vatelov syst�mu
        // Upravy
        UsrPsw_F      // Nastavenie hesla

{Usd_F}
Grp_F - Evidencia pracovn�ch skup�n
        // Nastravenia
        Usd_AfcGsc_F  // Evidencia tovaru
        Usd_AfcPob_F  // Pozi�n� skladov� v�dajky
        Usd_AfcScb_F  // Servisn� z�kazky
        Usd_AfcKsb_F  // Komisionalne vysporiadanie
        Usd_AfcOcb    // Odberate�sk� z�kazky
        Usd_AfcTcb    // Odberate�sk� dodacie lsity
        Usd_AfcIcb    // Odberate�sk� FA
        Usd_AfcOsb    // Odberate�sk� z�kazky
        Usd_AfcTsb    // Dodavate�sk� dodacie lsity
        Usd_AfcIsb    // Dodavate�sk� FA
        Usd_AfcImb    // Iterne prijemky
        Usd_AfcOmb    // Iterne vydajky
        Usd_AfcRmb    // Medziskladoce presuny
        Usd_AfcCdb    // Manualna vyroba
        Usd_AfcWab    // Vypocet odmeny zamestnancov
        Usd_AfcCsb    // Hotovostne pokaldne
        Usd_AfcSob    // Bankove vypisy
        Usd_AfcIdb    // Interne doklady
        Usd_AfcTob    // Terminalove vydajky
        Usd_AfcTib    // Terminalove prijemky
        Usd_AfcSab    // Spracovanie MO predaja
        Usd_AfcMcb    // Odberate�sk� cenov� ponuky
        Usd_AfcPsb    // Pl�ny dod�vate�sk�ch objedn�vok

Bac_F - Riadenie viazanost� kn�h
        NxbLst_V      // Zoznam kn�h vybran�ho modulu

Key_F - Spr�va riadiacich parametrov
        Key_SysEdi_F  // Glob�lne parametre syst�mu
        {Key_CrdEdi_F}// Z�kazn�cke karty
        Key_AscEdi_F  // Anal�za z�v�zkov a poh�ad�vok
        Key_WriEdi_F  // Prev�dzkov� jednotky
        Key_GscEdi_F  // B�zov� evidencia tovaru
        Key_EmcEdi_F  // Elektronicke spravy
        Key_StkEdi_F  // Sklady
        Key_AplEdi_F  // Akciove cenniky
        Key_ImbEdi_F  // Intern� skladov� v�dajky
        Key_OmbEdi_F  // Intern� skladov� v�dajky
        Key_RmbEdi_F  // Medziskladov� prevodky
        Key_PkbEdi_F  // Prebalovanie
        Key_CmbEdi_F  // Kompletizacia
        Key_DmbEdi_F  // Kompletizacia
        Key_OsbEdi_F  // Dod�vate�sk� objedn�vky
        Key_TsbEdi_F  // Dodavatelske dodacie listy
        Key_IsbEdi_F  // Dodavatelske faktury
        Key_McbEdi_F  // Odberatelske cenov� ponuky
        Key_OcmEdi    // Odberatelske z�kazky - modul
        Key_OcbEdi_F  // Odberatelske z�kazky - knihy
        Key_TcbEdi_F  // Odberatelske dodacie listy
        Key_IcmEdi    // Odberatelske faktury - modul
        Key_IcbEdi    // Odberatelske faktury - knihy
        Key_CsbEdi    // Hotovostne pokladne
        Key_CsbEdi_F  // Hotovostne pokladne OLD
        Key_SobEdi_F  // Bankove vypisy
        Key_IdbEdi_F  // Interne doklady
        Key_CrdEdi    // Zakaznicke karty
        Key_PrmEdi    // Spr�va informa�n�ch projektov - modul
        Key_PrbEdi    // Spr�va informa�n�ch projektov - knihy
        Key_CrmEdi_F  // Spr�va z�kazn�ckych po�iadaviek - modul
        Key_CrbEdi_F  // Spr�va z�kazn�ckych po�iadaviek - knihy
        Key_TibEdi_F  // Termin�lov� pr�jemky
        Key_TobEdi_F  // Termin�lov� v�dajky
        Key_SvbEdi_F  // Faktury ZP
        Key_SabEdi_F  // Sprava pokladne
        Key_PsbEdi_F  // Planovanie
        Key_ScbEdi_F  // Servisn� z�kazky
        Key_PobEdi_F  // Pozi�n� v�dajky
        Key_AlbEdi_F  // Pren�jom n�radia
        Key_KsbEdi_F  // Komisionalne vyuctovanie
        Key_VtrEdi_F  // Evidencia DPH

Dbs_F - �dr�ba datab�zov�ch s�borov
        Sys_FldSum_F  // Sumarizovanie pol� datab�z
        Sys_FldCopy_F // Kop�rovanie pol� datab�z

Wdc_F - Denn� uz�vierka prev�dzky
        // Ukoly
        Stk_StcVer_F  // Kontrola skladov�ch kariet
        Stk_DocVer_F  // Porovnavanie dokladov s pohybmi
        Cab_SalProc_F // Spracovanie pokladnicneho predaja

Psw_F - Zmena pr�stupov�ho hesla

Ver_F - Kontroln� funkcie
        // Nastroje
        Ver_GscBac_F  // Porovn�vanie tovarov�ho ��sla

Inf_F - Popis zmien v syst�me NEX
Log_F - Zoznam LOG suborov NEX
Evb_F - Spr�va pripomienok
        // Upravy
        EvbItm_F      // Editor Pripomienky


// ��seln�ky
  Acc_AccAnl_V,
  Sys_CrsLst_V,
  Sys_PlsLst_V,
  Sys_StkLst_V,
  Sys_WriLst_V,
  Sys_PabLst_V,
  Pab_PacLst_V,
  Pab_WpaLst_V,
  Sys_EpcLst_V,
  Sys_EpgLst_V,
  Stk_SmLst_V,
  Gsc_MgLst_V,
  Gsc_SgLst_V,
  Gsc_FgLst_V,
  Sys_AplLst_V,
  Sys_RefLst_V,
  Sys_DrvLst_V,
  Gsc_GsLst_V,
  Sys_DlrLst_V,
  Pab_CtyLst_V,
  Pab_StaLst_V,
  Sys_TrsLst_V,
  Sys_PayLst_V,
  Pab_CtyLst_F,
  Pab_BankLst_V,
  Sys_CntLst_V,
  Sys_GrpLst,
  Sys_UsrGrp,
  Sys_Com_F
  Sys_DscLst_F
  CsoInc_V,
  CsoExp_V,

  GscLst
  GscSrch
  PacLst
  DscDet


If not DirectoryExists(E_DirNam.AsString) then ForceDirectories(E_DirNam.AsString);

