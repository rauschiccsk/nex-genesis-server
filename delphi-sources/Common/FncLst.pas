00 - Systémové prostriedky (Systém) [SYS]
01 - Serverové aplikácie (Servere) [SRV]
02 - Administratívna èinnos (Sekretár) [ADM]
03 - Skladové hospodárstvo (Sklad) [STK]
04 - Zásobovanie skladov (Zásobovanie) [BUY]
05 - Obchodná èinnos (Obchod) [SAL]
06 - Predajná èinnos (Predaj) [SAL]
07 - Servisná èinnos (Servis) [SEV]
08 - Vırobná èinnos (Vıroba) [PRO]
09 - Ekonomika a úètovanie (Ekonomika) [ECO]
10 - Riadenie podniku (Manament) [MAN]

// Obrázky
   imBut -
   imMnu - ikony do menu
   imMod - ikony programovıch modulov
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

// Vzorové formuláre
        Agr_AgdLst    // Zoznam zákazníckych zmlúv
        Pab_LimBlc    // Nákupnı limit a platobná disciplína
        Osq_ItmInf    // Poloka dod8vate¾skej objednávky
        Mcb_MinAcq_F  // Minimalizáia vstupnıch nákladov
        Owb_OwhEdit_F // Hlavicka cestovného príkazu
        Asc_DocEdi_F  // Analıza záväzkov a poh¾adávok
        Mcb_DocEdi    // Hlavicka cenovych ponuk
        Asc_DocDel_F  // Zruši vybranı vıkaz                                   !
        Dsp_ItmEdi_F  // Pridat novú vınimku
        Emc_MsgEdi_F  //
        UsrPsw_F      // Nastavenie hesla
        OsbBcs_F      // Automatické generovanei objednavok
        AttLst_V      // Zoznam príloh
        Pls_RefGen_F

// Bazova evidenca
Gsc_F - Bázová evidencia tovaru
        // Upravy
        Gsc_GscEdit_F  // Evidencna karta tovaru
        Gsc_ItmEdi_F   // Evidenèná karta tovaru
        Gsc_ImgEdi_F   // Obrázky k tovarovej poloke
        Gsc_GscDel_F   // Zrusenie vybraneho tovaru
        Gsc_AddImg_F   // Prida obrázok k tovaru                               DEL
        Gsc_GsLang_F   // Preklad do inych jazykov
        // Zobrazit
        Gsc_ItmInfo_F  // Informacia o vybranom tovare
        Gsc_MgLst_V    // Zoznam tovarovych skupin
        Gsc_FgLst_V    // Zoznam financnych skupin
        Gsc_SgLst_V    // Zoznam špecifikaènıch skupin
        Gsc_GscAna_V   // Zoznam doplnkovych nazvov
        Gsc_GscMod_V   // História zmeny údajov
        Gsc_GslDel_V   // Zoznam zrušenıch poloiek
        Gsc_GslDis_V   // Zoznam vyradenıch poloiek
        Gsc_PckLst_V   // Zoznam vratnıch obalov
        Gsc_GpcLst_V   // Zoznam obalovıch tovarov
        Gsc_WgsLst_V   // Zoznam váhovıch tovarov
        Gsc_MgTree_V   // Stromová štruktúra skupín
        Stk_StcLst_V   // Zásoba v jednotlivıch skladoch
        Stk_SpaLst_V   // Dodávatelia vybranej poloky
        Stk_CpaLst_V   // Odberatelia vybranej poloky
        Stk_SapLst_V   // Ceny z predajnıch cenníkov
        Gsc_OcdLst_V   // Nevybavene zakazky zo vsetkych skladov
        Stk_OsdLst_V   // Nedodané dodávate¾ské OBJ
        Stk_ActStp_V   // Zoznam neodpísanıch vırobnıch èísiel
        Stk_AllStp_V   // Zoznam všetkıch vırobnıch èísiel
        Gsc_CraLst_V   // Zoznam prepravkovıch tovarov
        Gsc_GscLnk_V   // Príslušenstvá k tovarovej poloke
        // Nastroje
        Gsc_GscFilt_F  // Filtrovanie tovarovych kariet
        !Gsc_GscFilt_V // Filtrova tovarové poloky
        Gsc_BcSrch_F   // Hladat podla identifikacneho kodu
        Gsc_NaSrch_F   // H¾ada pod¾a èasti názvu
        Gsc_NusGsc_F   // Nepouzite tovarove polozky
        Gsc_TxtExp_F   // Export do textového súboru
        Gsc_IbcGen_F   // Generovat interny ciarovy kod
        Gsc_DivSet_F   // Hromadné nastavenie delite¾nosti
        Gsc_MinMax_F   // Nastavenie skladovıch normatívov
        Sys_ImpGsc_F   // Import evidencii tovaru
        Sys_ImpBac_F   // Import druhotnıch kódov
        Imp_GscNot_F   // Import poznámok k tovarom
        Gsc_BacExp_F   // Export internych ciarovych kodov
        Gsc_SndShp_F   // Odosla vybranú kartu na Web
        // Udrzba
        Gsc_Sending_F  // Posla evidenciu tovaru na FTP                        DEL
        Gsc_BacDup_F   // H¾ada duplicitné identifikaèné kódy
        Gsc_BacLos_F   // H¾ada stratené druhotné kódy
        Gsc_PlsCpr_F   // Porovnávanie s predajnım cenníkom
        Gsc_GsnSrc_F   // Vytvori názvovı vyh¾adávaè
        // Servis
        Gsc_BacGen_F   // Generovat interny ciarovy kod
        Gsc_KeyGen_F   // Generovat vyhladávacie kluce
        Gsc_VatChg_F   // Zmena sadzby DPH
        Gsc_ReNum_F    // Preèíslovanie tovaru
        Gsc_RefGen_F   // Posla identifikacne kody do pokladne
        Gsc_LinRef_F   // Obnova poslednej nakupnej ceny

Pab_F - Evidencia obchodnıch partnerov
         // Upravy
        Pab_PacEdit_F  // Evidencna karta partnera
        Pab_PacCopy_V  // Kopirovanie firmy do inej knihy
        // Zobrazit
        Pab_DisPa_V    // Zoznam vyradenıch firiem
        Pab_PagPa_V    // Zoznam firiem pod¾a skupín
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
        Pab_NameSrch_F // Vyh¾adávanie firiem pod¾a zadanej èasti názvu
        Pab_RefGen_F   // Posla katalóg do pokladne
        Pab_ExpToTxt_F // Export údajov do textového súboru
        Pab_ImpFrTxt_F // Import údajov z textového súboru
        Pab_PacChg_F   // Zamena firmy v celom systéme
        // Udrzba
        Pab_Sending_F  // Posla evidenciu partnerov cez FTP                    DEL
        Pab_SynBas_F   // Synchronizácia so základnou knihou

Wgh_F - Obsluha elektronickıch váh
        // Upravy
        WgiEdi_F       // Udaje vybranej polozky pre vahu LIBRA 500
        Wgh_WgiEdit_F  // Udaje vybranej polozky
        Wgh_WgnEdit_F  // Volny text polozky
        // Nastroje
        Wgh_RefData_F  // Prenos udajov z cennika
        Wgh_SndData_F  // Odoslanie udajov do vahy
        Wgh_WgiCmp_F   // Porovnanie váhovıch etikiet s polokami predaja
        WgnRef_F       // Obnovenie poznamok z bazovej evidencie
        // Udrzba
        Wgh_WgsEdit_F  //

Cwb_F - Kontrola váhového predaja
        // Udrzba
        Cwb_BookEdi_F  // Vlastnosti vybranej knihy

// Obchodna cinnost
Pls_F - Tvorba predajnıch cien
        // Upravy
        Pls_PlcEdit_F  // Formular na zadavanie predajnej ceny
        Pls_LevEdi_F   // Karta tvorby predajnej ceny
        Pls_OrdPrn_F   // Tlac kuchynksych objednavok
        Pls_ItmEdi_F   // Formular centovorby a evidencie polozky
        // Zobrazit
        Gsc_ItmInfo_F  // Podrobne informacie o predaji
        Pls_PlsMod_V   // Historia zmaney udajov
        Pls_PlsHis_V   // Historia zmeny ceny
        Pls_PlsDis_V   // Zoznam vyradenıch poloziek
        Pls_PlsDel_V   // Zoznam zrusenych poloziek
        Pls_PlsPck_V   // Zoznam vratnych obalov
-        Pls_PlsWgs_V   // Zoznam vahovych tovarov
-        Pls_PlsPgs_V   // Zoznam obalovych tovarov
        Pls_PlsAct_V   // Zoznam akciovıch tovarov
        Stk_StcLst_V   // Zasoba v jednotlivych skladovch
        Stk_SpaLst_V   // Dodavatelia vybranej polozky
-        Stk_CpaLst_V   // Odberatelia vybranej polozky
-        Gsc_OcdLst_V   // Nevybavene zakazky zo vsetkych skladov
        Stk_SapLst_V   // Ceny z predajnych cennikov
-        Stk_ActStp_V   // Neodpisane vyrobne cisla
-        Stk_AllStp_V   // Vsetky vyrobne cisla
        Pls_LapChg_V   // Zmeny nakupnych cien
        Pls_SapChg_V   // Zmeny predajnych cien
        Pls_PlcInf_F   // Cenové informácie
        // Tlac
        Pls_PrnFgc_F   // Tlac cenniku podla skupin
        Gsc_LabPrn_F   // Tlac cenovych etikiet
        // Nastroje
        Pls_PlsFilt_F  // Filtrovanie poloziek cennika
        Pls_BcSrch_F   // Hladat polozku podla podkodu
        Pls_NaSrch_F   // Hladat podla casti nazvu
        Gsc_NusGsc_F   // Nepouzite tovarove polozky
        Pls_NusPls_F   // Nepouzite tovarove polozky
        Pls_PlsRef_F   // Aktualizácia zisku predaja
        Pls_ReCalc_F   // Prepoèet predajnıch cien
        Pls_GsCopy_F   // Kopírovanie poloiek do cenníka
        Pls_RefGen_F   // Posla cenník do pokladne
        Pls_PlcDif_V   // Porovnávanie cenníkov
        Pls_GscDif_V   // Porovnávanie e evidenciou tovaru
        Pls_TxtExp_F   // Export do textového súboru
-        Pls_CdCat_F    // Vyhotovenie CD katalógu
-        Trm_DatSnd_F   // Zápis údajov do databanky
        Pls_LevClc_F   // Prepoèet cenovıch hladín
        Sys_ImpPls_F   // Import predajneho cenika
        // Udrzba
        Pls_EditBook_F // Vlastnosti predajného cenníka
        Pls_Synchr_F   // Synchronizácia základnych udajov
        Pls_Sending_F  // Posla celı cenník na FTP
        Pls_SetStk_F   // Nastavi sklad pre poloku
        Pls_ApCalc_F   // Prepoèet predajnej ceny bez DPH
        // Servis
        PLS_RndVer_F   // Kontrola zaokrúhlenia ceny/MJ
        Pls_AddPlm_F   // Prida staré zmeny do histórie

Apl_F - Evidencia akciovıch cien
        // Upravy
        Apl_AplLst_F  // Vlastnosti vybraneho cennika
        Apl_AplItm_F  // Polozka akcioveho cennika
        // Nastroje
        Apl_CasSnd_F  // Posla údaje do pokladne
        Sys_ImpApl_F  // Import akcioveho cennika
        // Udrzba
        Apl_EndDel_F  // Zruši neplatné akcie

Acb_F - Akciové precenenie tovaru
        // Upravy
        Acb_AchEdit_F // Hlavicka vybraneho dokladu
        // Zobrazit
        Acb_AciLst_F  // Polozky vybraneho dokladu
        // Tlac
        Acb_DocPrn_F  // Tlac precenovacieho dokladu
        Acb_PrnNew_F  // Cenovky s akciovymi cenami
        Acb_PrnAft_F  // Cenoviek po ukonceni akcie
        Lab_PrnItm_F  // Tlaè cenovkovıch etikiet
        // Nastroje
        Acb_ActRun_F  // Zahajenie cenovej akcie
        Acb_ActEnd_F  // Okoncenie cenovej akcie
        Acb_ReadTmp_F // Asi treba vyradit tento modul - RZ 08.02.2008
        Acb_SndApl_F  // Do akciového cenníka
        Acb_ImpAci_F  // Import akciovych cien
        // Udrzba
        Key_BokAdd_F  // Zalozit novu knihu
        Key_AcbEdi_F  // Interne prijemky

Agl_F - Evidencia zmluvnıch podmienok
        // Nastroje
        Agl_ImpDat_F  // Import zmluvnıch cien
        // Upravy
        Agl_AgrLst_F  // Zadavanie novej firmy
        Agl_AgrItm_F  // Zmluvna podmienka tovaru

Mcb_F - Odberate¾ské cenové ponuky
        // Upravy
        Mcb_MchEdit_F // Hlavicka vybraneho dokladu
        Mcb_DocEdi_F  // Hlavièka cenovej ponuky (nová)
        Mcb_DocDsc_F  // Z¾ava na celı doklad
        Mcb_DocRnd_F  // Zaokrúhlenie dokladu
        Doc_VatChg_F  // Zmena sadzieb DPH
        // Zobrazit
        Mcb_MciLst_F  // Polozky vybraneho doklau
        Mcb_ItmLst_F  // Polozky vybraneho doklau
        Inv_PayLst_V  // História úhrady faktúry
        AttLst_V      // Zoznam príloh
        // Tlac
        Mcb_PrnMcd_F  // Tlac vybraneho dokladu
        Mcb_McrFrc_F  // Vıkaz pod¾a platnosti
        Mcb_McrStk_F  // Vıkaz pod¾a zásoby
        Mcb_McrFit_F  // Vıkaz volnıch poloiek
        // Nastroje
        Mcb_DocCopy_F // Kopirovanie dokladu
        Mcb_TcdGen_F  // Vystavenie dodacieho listu
        Mcb_OcdGen_F  // Vystavenie odberate¾skej zákazky
        Mcb_ExpDoc_F  // Export cenovej ponuky
        Mcb_MciClc_F  // Prepoèet cenovej ponuky
        Mcb_MinAcq_F  // Minimalizáia vstupnıch nákladov
        // Udrzba
        Key_BokAdd_F  // Zaloi novú knihu
        Key_McbEdi_F  // Vlastnosti knihy

Dsc_F - Z¾avy pre odberate¾ov
        // Upravy
        Dsc_FgPaDsc_F // Finanèná skupina
        // Zobrazit
        Pab_PacLst_V  // Katalóg partnerov
        // Nastroje
        Dsc_ImpFgc_F  // Import obchodnıch podmienok
        Dsc_ScpTbl_F  // Tabulkove nastavenie udajov

Dir_F - Kontaktnı manaérsky diár
        // Upravy
        Dir_ItmEdi    // Editor na zaávanie kontaktu
        // Zobrazit
        Dir_TelLst    // Zoznam telefónnych èísiel
        Dir_EmlLst    // Zoznam elektronickıch poštovıch adries
        Dir_RemLst    // Pripomienky ku kontaktnej osobe
        Dir_CrsLst    // Zoznam firemnıch vzahov
        Dir_ModLst    // Zoznam úprav

Mds_F - Vıkaz najmenšieho zisku
        // Upravy
        Mds_ClcMds_F  // Vypocet minimalneho zisku
        Mds_DelMit_F  // Vymaza poloky hromadne

Rpc_F - Poiadavky na zmeny cien
        // Upravy
        Rpc_ItmEdi_F  // Zaloi poiadavku
        // Nastroje
        Rpc_ItmApp_F  // Spracova poiadavky

Tpc_F - Evidencia terminovanıch cien
        // Upravy
        Tpc_ItmEdi_F  // Zaloi poiadavku
        // Nastroje
        Tpc_CasSnd_F  // Posla údaje do pokladne

Crd_F - Evidencia zákazníckych kariet
        // Upravy
        Crd_CrdEdit_F // Editor zakaznickej karty
        // Zobrazit
        Crd_TrnHis_V  // Historia nakupov zakaznika
        Crd_BonHis_V  // Historia vıdaja bonusov
        // Nastroje
        Crd_ItmFlt_F  // Filtrovat zakaznicke karty
        Crd_CasSnd_F  // Posla údaje do pokladne
        Crd_BonOut_F  // Vıdaj zákazníckych bonusov
        Crd_AddInv_F  // Priradenie odb. faktúry ku karte
        Crd_CrdFlt_F  // Zakaznicke karty po splatnosti
        // Udrzva
        Crd_FtpSnd_F  // Posla všetky karty na FTP
        Crd_ClcLst_F  //
        Crd_TrnVer_F  // Kontrola obratov
        Key_CrdEdi    // Kontrola obratov

// Riadenie skladu
Stk_F - Vıkaz zásoby pod¾a spotreby
        // Upravy
        Stk_MinMax_F  // Skladové normatívy
        // Zobrazit
        Stk_StoLst    // Prehlad objednania a rezervacie
        Stk_StbLst    // Preh¾ad poèiatoènıch stavov
        Gsc_ItmInfo_F // Podrobné informácie o tovare
        Stk_ItmInfo_F // Skladová karta zásob
        Stk_StcInf_F  // Skladová karta zásob
        Stk_ActFif_V  // Nevydané FIFO karty poloky
        Stk_AllFif_V  // Všetky FIFO karty poloky
        Stk_StmLst_F  // História skladovıch pohybov
        Stk_StcLst_V  // Zásoba v jednotlivıch skladoch
        Stk_ActStp_V  // Neodpísané vırobné èísla
        Stk_AllStp_V  // Všetky vırobné èísla
        Stk_StpDir_V  // Vırobné èísla z celého skladu
        Stk_CpaLst_V  // Odberatelia vybranej poloky
        Stk_SpaLst_V  // Dodávatelia vybranej poloky
        Stk_SapLst_V  // Ceny z predajnıch cenníkov
        Stk_OcdLst_V  // Nevybavené odberate¾ské OBJ
        Stk_OciDel_V  // Zoznam zrusenych zakaziek
        Stk_OsdLst_V  // Nedodané dodávate¾ské OBJ
        Stk_ImrLst_V  // Nedodané dodávate¾ské OBJ
        Stk_MinLst_V  // Skladové nad normatívy
        Stk_MaxLst_V  // Skladové pod normatívy
        Stk_StsLst_V  // Rezervacie ERP
        Stk_StmHst_F  // História skladovıch pohybov za roky
        Stk_SpcLst_V  // Zásoba na poziènıch miestach
        // Tlac
        Stk_PrnStk_F  // Tlaè zoznamu skladovıch kariet
        // Nastroje
        Stk_StcFilt_F // Filtrova skladové karty zásob
        Stk_BcSrch_F  // H¾ada poloku pod¾a podkódu
        Stk_NaSrch_F  // H¾ada pod¾a èastí názvu
        Stk_NrsNul_F  // Rezervované tovary s nulovou NC
        Stk_StEval_F  // Finanèné vyhodnotenie skladov
        Stk_SmEval_F  // Finanèné vyhodnotenie ku dòu
        Stk_StmSum_F  // Finanèné vyhodnotenie pohybov
        Stk_StmAcc_F  // Finanèné vyhodnotenie uctov
        Stk_StmItm_F  // Vykaz skladovych pohybov
        Stk_DayStm_F  // Dennı vıkaz príjmov a vıdajov
        Stk_DayStc_F  // Zásoba k zadanému dátumu
        Stk_SapStc_F  // Zásoba pod¾a dodávate¾ov
        Stk_SmgEvl_F  // Skladová zasoba pod¾a skupín
        Stk_StvTrn_F  // Finanèné vyhodnotenie obrátkovosti
        Stk_NusStc_F  // Nepouité skladové karty
        Stk_DrbLst_F  // Trvanlivos tovarovıch poloiek
        Stk_SmLst_V   // Zoznam skladovıch pohybov
        Stk_TxtExp_F  // Export do textového súboru
        Stk_TxtImp_F  // Import z textového súboru
        Stk_CnsSal_F  // Vıkaz komisionálneho perdaja
        Stk_InShop_F  // Údaje pre internetovı obchod
        Stk_OrdPrp_F  // Príprava objednávok
        Stk_RndDif_F  // Vıkaz cenovıch rozdielov
        Stk_PosLst_V  // Evidencia poziènıch miest
        Stk_NtrStc_F  // Vıkaz neobrátkového tovaru
        StkRba_F      // Vıkaz zásoby pod¾a spotreby
        Stk_StmRep_F  // Vıkaz zásoby pod¾a pohybov
        // Udrzba
        Stk_ReCalc_F  // Prepoèet skladovej karty
        Stk_StoCalc_F // Prepoèet rezervovaného mnostva
        Stk_Sending_F // Posla skladové karty cez FTP
        Stk_Synchr_F  // Synchronizácia základnıch údajov
        Stk_OcdVer_F  // Kontrola rezervácii zákaziek
        Stk_OsdVer_F  // Kontrola objednaného mnostva
        Stk_StcVer_F  // Kontrola skladovıch kariet
        Stk_FifVer_F  // Kontrola FIFO kariet
        Stk_StmDup_F  // Kontrola duplicity skladovıch pohybov
        Stk_DocVer_F  // Kontrola pohybov pod¾a dokladov
        Stk_LosStm_F  // Chıbajúce skladové pohyby
        Stk_LosStc_F  // Chıbajúce skladové karty
        Stk_BegVer_F  // Kontrola pociatocneho stavu
        Stk_DocStm_F  // Porovnávanie pohybov  s dokladmi
        Imp_MinMax_F  // Import skladovych normativov
        Stk_CpcVer_F  // Kontrola nakupnych cien
        Stk_NrmClc_F  // Vıpoèet skladovıch normatívov
        // Service
        Stk_StmDat_F  // Kontrola datumu FIFO a pohybov
        Stk_StmDoc_F  // Hodnota dokladov pod¾a pohybov
        Stk_SalClc_F  // Perpoèet rezervacii ERP
        Stk_StkCalc_F // Perpoèet všetkıch skladovıch kariet
        Stk_SalNul_F  // Vynulovanie rezervácii pre ERP
        Stk_OsdNul_F  // Vynulovanie objednaného mnostva
        Stk_AvgRef_F  // Aktualizácia priemernej NC
        Stk_LastRef_F // Aktualizácia poslednej NC
        Stk_StmDir_V  // Denník skladovıch pohybov
        Stk_OldMMQ_F  // Prenos udajov z minuleho roku
        Stk_FifClc_F  // Prepocet FIFO a STM
        Stk_FifCor_F  // Prepocet nulovych FIFO
        Stk_FifNum_F  // Generovanie èísiel FIFO v pohyboch

Imb_F - Interné skladové príjemky
        // Upravy
        Imb_ImhEdit_F // Hlavicka internej skladovej prijemky
        Doc_VatChg_F  // Zmena sadzieb DPH
        // Zobrazit
        Imb_ImiLst_F  // Polozky vybraneho dokladu
        Jrn_AccLst_V  // Úètovné zápisy dokladu
        // Tlac
        Imb_DocPrn_F  // Hromadná tlaè skladovıch príjmovıch dokladov
        Imb_ImdPrn_F  // Zoznam dokladov za obdobie
        // Nastroje
        Imb_ImdFilt_F // Filtrovanie prijmovych dokladov
        Imb_IncDoc_F  // Príjem všetkıch poloiek
        Stk_SmLst_V   // Zoznam skladovıch pohybov
        Imb_WghRcv_F  // Nacitat udaje z elektronickej vahy
        Doc_TrdInc_F  // Naèíta záznamníkové príjemky
        Imb_ImpDoc_F  // Naèíta elektronickı doklad
        Imb_ImiFxa_F  // Vıkaz prijatého majetku
        Imb_ImpCSV_F  // Import z CSV
        WgdImp_F      // Import váhového dokladu
        // Udrzba
        Imb_Sending_F // Posla skladové príjemky cez FTP                       DEL
        Imb_StmImd_F  // Porovnávanie dokladu s pohybmi
        Imb_StmIma_F  // Porovnávanie dokladov s pohybmi
        Doc_OitMsd_F  // Interny prenos dokladov
        Imb_ImiDir_V  // Poloky všetkıch príjemok
        Imb_CrdDif_F  // Dodatocne pridane polozky
        Key_BokAdd_F  // Zalozit novu knihu
        Key_ImbEdi_F  // Interne prijemky
        // Servis
        Imb_SndTxt_F  // Uloi doklady do textového súboru                     DEL
        Imb_RcvTxt_F  // Naèíta doklady z textového súboru                     DEL
        Imb_ImiToN_F  // Zmeni poloky na neodpoèítané                         DEL
        Imb_ImiRef_F  // Obnova poloziek podla hlavicky
        Imb_ClcPrc_F  // Prepoèet PC poloiek
        Imb_IncBook_F // Príjem poloiek všetkıch dokladov                      DEL

Omb_F - Interné skladové vıdajky
        // Upravy
        Omb_OmhEdit_F // Hlavicka internej skladovej vydajky
        Doc_VatChg_F  //
        // Zobrazit
        Omb_OmiLst_F  // Polozky vybranej vydajky
        Omb_NosOmi_V  // Nevyskladnene poloky vıdajok
        Inv_PayLst_V
        Jrn_AccLst_V  // Úètovné zápisy dokladu
        // Tlac
        Omb_DocPrn_F  // Tlac vybraneho dokladu
        Omb_OmdPrn_F  //
        // Nastroje
        Omb_OutDoc_F  // Vydaj vsetkych poloziek
        Omb_OmdFilt_F //
        Omb_ImdCrt_F  //
        Stk_SmLst_V   //
        Omb_StmOmd_F  // Porovnávanie dokladu s pohybmi
        Omb_StmOma_F  // Porovnávanie dokladov s pohybmi
        Omb_StkOut_F
        Omb_MgcStc_F  // Skladové karty pod¾a skupín
        Doc_TrdOut_F  // Naèíta záznamníkové vıdajky
        Omb_WgdImp_F  // Naèítanie váhovıch dokladov
        // Udrzba
        Omb_Sending_F
        Omb_RwmVer_F  // Kontrola medziprevadkoveho presunu
        Omb_ChckSrc_F // Kontrola medziprevadkoveho presunu
        Doc_OitMsd_F  // Interny prenos dokladov
        Omb_OmiDir_V  // Poloky všetkıch vıdajok
        Omb_CrdDif_F  // Dodatocne pridane polozky
        Key_BokAdd_F  // Zalozit novu knihu
        Key_OmbEdi_F  // Interne vydajky
        // Servis
        Omb_SndTxt_F  //                                                        DEL
        Omb_RcvTxt_F  //                                                        DEL
        Omb_OmiToN_F  //                                                        DEL
        Omb_InpCor_F  // Oprava cien zápornıch vıdajov
        Omb_OmpDir_V  // Zoznam všetkıch vırobnıch èísiel
        Omb_OmiRef_F  // Obnova poloiek pod¾a hlavièky
        Omb_OutBook_F // Vydaj poloziek vsetkych dokladov - celej knihy

Rmb_F - Medziskladové presuny
        // Upravy
        Rmb_RmhEdit_F // Hlavicka vybrneho dokladu
        Rmb_MovDoc_F  // Presun všetkıch poloiek
        // Zobrazit
        Rmb_RmiLst_F  // Polozky vybraneho dokladu
        Jrn_AccLst_V  // Úètovné zápisy dokladu
        // Tlac
        Rmb_DocPrn_F  // Hromadná tlaè dokladov
        Rmb_RmdPrn_F  // Zoznam dokladov za obdobie
        Lab_PrnItm_F  // Tlaè cenovkovıch etikiet
        // Nastroje
        Stk_SmLst_V   // Zoznam skladovıch pohybov
        Doc_TrdOut_F  // Naèíta záznamníkové vıdajky
        Sys_DocFlt_F  // Filtrovanie dokladov
        WgdImp_F      // Import váhového dokladu
        // Udrzba
        Key_BokAdd_F  // Zalozit novu knihu
        Key_RmbEdi_F  // Interne vydajky
        Rmb_Sending_F // Posla skladové presunky cez FTP                       DEL
        Doc_OitMsd_F  // Interny prenos dokladov
        // Servis
        Rmb_RmiToN_F  // Zmeni poloky na neodpoèítané                         DEL
        Rmb_MovBook_F // Presun poloiek všetkıch dokladov

Dmb_F - Rozobratie vırobkov
        // Upravy
        Dmb_DmhEdit_F // Hlavicka vybraneho dokladu
        // Zobrazit
        Dmb_DmiLst_F  // Popozky vybraneho dokladu
        // Tlac
        Dmb_DocPrn_F  // Hromadná tlaè dokladov
        Dmb_DmdPrn_F  // Zoznam dokladov za obdobie
        // Nastroje
        Dmb_DmpDoc_F  // Rozobratie vybraneho vyrobku
        Dmb_DmpClc_V  // Definicia vypoctu vyrobnych cien
        // Udrzba
        Key_BokAdd_F  // Zalozit novu knihu
        Key_DmbEdi_F  // Vlastnosti vybeanej knihy
        Key_cmbEdi_F  // Vlastnosti vybeanej knihy
        Dmb_StmDmi_F  // Porovnávanie so skladovımi pohybmi
        Doc_OitMsd_F  // Interny prenos dokladov
        // Servis
        Dmb_DmiToN_F  // Zmeni poloky na neodpoèítané                         DEL

Pkb_F - Preba¾ovanie tovaru
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

Reb_F - Preceòovacie doklady                                                    DEL
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

Alb_F - Prenájom náradia
        // Nastroje
        Alb_AldIcg_F  // Vystavi odberate¾skú faktúru
        Alb_AldEcr_F  // Vyúètova doklad cez FMS
        Alb_RetPro_F  // Protokol vrátenia zariadenia

Cdb_F - Manuálna vıroba
        // Upravy
        Cdb_CdhEdit_F // Hlavicka vybraneho dokladu
        // Zobrazit
        Cdb_CdiLst_F  // Polozky vybraneho dokladu
        Cdb_CdsLst_F  // Sumárny zoznam komponentov
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

Pnb_F - Preceòovacie doklady                                                    DEL
        // Upravy
        Rmb_PndEdit_F //                                                        DEL
        Pnb_PnbEnd_F  //                                                        DEL
        // Nastroje
        Pnb_PndFilt_F //                                                        DEL
        // Udrzba
        Pnb_PnbEdit_F //                                                        DEL
        Doc_OitMsd_F  // Internı penos dokladuv                                 DEL

Ivd_F - Inventarizácia skladov
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
        Ivd_StcVer_F  // Porovnavanie s aktuálnym stavom
        Ivd_BpcVer_F  // Porovnavanie predajnych cien
        Ivd_StRead_F  // Nacitanie skladoveho stavu
        Ivd_StmRea_F  // Nacitanie skladoveho stavu ku dnu ukoncenia
        Ivd_GsRead_F  // Nacitanie evidencnych udajov
        Ivd_DelNul_F  // Vymazanie nulovıch poloiek

// Zasobovanie skladov
Ocp_F - Spracovanie zákaziek
        // Upravy
        Ocp_AddItm_F  // Pridat nové polozky do zoznamu
        Ocp_EditItm_F // Zadavanie udajov vybranej polozky
        Ocp_ProcItm_F // Spracovanie poloky zákazky
        // Nastroje
        Ocp_OcpDef_V  // Definicia tvorby dokladov

Psb_F - Plány dodávate¾skıch objednávok
        // Program
        Sys_UnlEdit_F // Odblokovanie dokladu
        // Upravy
        Psb_PshEdit_F // Hlavicka vybraneho dokladu
        Psb_PsdGen_F  // Prida polozky do planu
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
        Key_BokAdd_F  // Zaloi novú knihu
        Key_PsbEdi_F  // Plánovanie objednávok
        {Psb_PsbEdit_F}                                                         DEL

Osb_F - Dodávate¾ské objednávky
        // Upravy
        Osb_OshEdit_F // Hlavicka vybraneho dokladu
        Osb_DocDsc_F  // Z¾ava na objednávku
        Osb_DocRnd_F  // Zaokrúhlenie objednávky
        Doc_VatChg_F  // Zmena sadzieb DPH
        // Zobrazit
        Osb_OsiLst_F  // Polozky vybraneho dokladu
        Osb_StkOut_V  // Štatistickı zoznam  vıdajov
        Osb_OspLst_V  // Zoznam dodávate¾ov tovaru
        // Tlac
        Osb_PrnOsd_F  // Tlac vybraneho dokladu
        // Nastroje
        Osb_OsdGen_F  // Automatické vyhotovenie objednávky
        Osb_SndDbf_F  // Uloi doklad do DBF súboru                            DEL
        Osb_OsiMov_F  // Prenos poloiek do inej objednávky
        Osb_DlvRead_F // Naèítanie dodávky zo súboru
        Osb_OutMov_V  // Specifikacia skladovych pohybov
        Osb_DocSnd_F  // Elektronicky prenos dokladov
        Osb_OsiDlv_F  // Prekrocene terminy dodavok
        Osb_OsiNar_F  // Nesplnene dodavky kumulativne
        Osb_OsiNat_F  // Kontrola termínu dodávky
        Osb_StoVer_F  // Kontrola skladového stavu
        OsbBcs_F      // Automatické generovanei objednavok
        OsbDdm_F      // Spravovanie terminu dodavky
        OsbSnd_F      // Odoslanie objednavky
        OsbSdc_F      // Potvrdenie termínu objednávky dodávate¾om
        Osb_DocCopy_F // Kopirovanie dokladu
        Osb_ImpDoc_F  // Naèítanie elektronického dokladu
        // Udrzba
        Key_BokAdd_F  // Zalozit novu knihu
        Key_OsbEdi_F  // Interne vydajky
        Osb_StoGen_F  //                                                        DEL
        Doc_OitMsd_F  // Interny prenos dokladov
        // Servis
        Osb_OsbClc_F  // Prepocet dokladov podla poloziek
        Osb_OsiRef_F  // Obnova poloiek pod¾a hlavièiek

Osq_F - Tvorba objdnávok zo skladu
        // Upravy
        Osq_DocEdi    // Hlavièka dodávate¾skej objednávky
        Osq_ItmEdi    // Poloka dod8vate¾skej objednávky
        // Zobrazit
        Osq_ItmInf    // Poloka dod8vate¾skej objednávky
        Osq_ItmLst    // Poloky vybraného dokladu

Tsb_F - Dodávate¾ské dodacie listy
        // Upravy
        Tsb_TshEdit_F // Hlavièka dodávate¾ského dodacieho listu
        Tsb_DocDsc_F  // Z¾ava na vybranı doklad
        Doc_VatChg_F  // Zmena sadzieb DPH
        // Zobrazit
        Tsb_TsiLst_F  // Polozky dodacieho lsitu
        Jrn_AccLst_V  // Zoznam úètovnıch zápisov
        Tsb_DlvSur_V  // Zoznam dodavok naviac
        // Tlac
        Tsb_DocPrn_F  // Tlaè vybraného dokladu
        Tsb_TsdPrn_F  // Tlaè dokladov za obdobie
        Lab_PrnItm_F  // Tlaè cenovkovıch etikiet
        // Nastroje
        Tsb_IncDoc_F  // Príjem všetkıch poloiek
        Tsb_TsdMpr_F  // Spojenie dodacieho listu s faktúrou
        Tsb_AddAcq_F  // Rozpoèet obstarávacích nákladov
        Tsb_TrmRcv_V  // Naèítanie údajov zo záznamníka
        Doc_TrdInc_F  // Naèíta záznamníkové príjemky
        Tsb_TsdRcv_F  // Elektronickı prenos dokladov
        Tsb_EdiRcv_F  // Elektronickı prenos dokladov
        Tsb_DocCopy_F // Kopírovanie vybraneho dokladu
        Tsb_TsiRep_F  // Vykaz prijmu tovaru na sklad
        Tsb_OmdGen_F  // Presun na inu prevadzku
        Doc_AddRpc_F  // Vytvori poiadavky na zmenu cien
        Doc_AutPck_F  // Automaticke prebalenie tovaru
        Imb_ImiFxa_F  // Vıkaz prijatého majetku
        Tsb_TshFlt_F  // Filtrovanie dokladov
        Sys_DocFlt_F  // Filtrovanie dokladov
        Tsb_PckRep    // Vıkaz obalov
        Tsb_ImpDoc_F  // Naèíta elektronickı doklad
        TsdBcs_F      // Prepoèet NC poloiek pod¾a obchodnıch podmienok
        // Udrzba
        Doc_ItmRef_F  // Obnova údajov poloiek
        Tsb_NoPair_F  // Nevypárované DL k zadanému dátumu
        Tsb_Sending_F // Posla dodacie listy cez FTP
        Tsb_TsiIsi_F  // Kontrola vypárovanıch poloiek DDL a DF
        Tsb_OsdPair_F // Párovanie DDL s objednávkami
        Tsb_StmTsd_F  // Porovnávanie dokladu s pohybmi
        Tsb_StmTsa_F  // Porovnávanie dokladov s pohybmi
        Tsb_TsdVer_F  // Hodnotová kontrola dokladov
        Tsb_TsnVer_F  // Kontrola interného èísla dokladu
        Tsb_TsdMis_F  // Zoznam chybajucich dokladov
        Doc_OitMsd_F  // Interny prenos dokladov
        Key_BokAdd_F  // Zalozit novu knihu
        Key_TsbEdi_F  // Dodavatelske dodacie listy
        // Servis
        Tsb_DocClc_F  // Prepoèet dokladov pod¾a poloiek
        Tsb_TsiToN_F  // Zmeni poloky na neodpoèítané
        Tsb_SndTxt_F  // Uloi doklady do textového súboru
        Tsb_RcvTxt_F  // Naèíta doklady z textového súboru
        Tsb_IsdDate_F // Doplnenie dátumu vypárovania s FA
        Tsb_TshRen_F  // Preèíslovanie došlıch dodacích listov
        Tsb_TsiDir_V  // Poloky všetkıch dodacích listov
        Tsb_TshChg_F  // Zmena èísla  došlého dodacieho listu
        Doc_AcvClc_F  // Prepocet uctovnej meny
        Tsb_IncBook_F // Príjem poloiek všetkıch dokladov
        TsdUns_F      // Vrátenie prijatého tovaru

Ksb_F - Konsignaèné vysporiadanie
        // Upravy
        Ksb_KsdAdd_F  // Prida nové doklady  - starı spôsob
        // Zobrazit
        Ksb_KsiLst_F  // Poloky vybraného dokladu
        // Nastroje
        Ksb_TsdGen_F  // Vystavi došlı dodací list
        // Servis
        Ksb_KsiDir_V  // Poloky všetkıch dokladov

Bcs_F - Obchodné podmienky dodávok
        // Upravy
        Bcs_GscEdit_F // Tovarová poloka vybraného dodávate¾a
        Bcs_PalEdi_F  // Obchodné podmienky dodávate¾a
        Bcs_MorDel_F  // Hromadné zrušenie poloiek
        // Zobrazit
        Pab_PacLst_V  // Katalóg partnerov
        // Nastroje
        Bcs_ImpGsc_F  // Import obchodnıch podmienok
        Bcs_ImpEpl_F  // Import elektronického ceníka
        Bcs_GslRat_F  // Zmena dodavky oznacenych poloziek
        BcsRel_V      // Prepocet spolahlivosti
        // Udrzba
        Bcs_PalRef_F  // Doplnenie chıbajúcich firiem

Tim_F - Terminálové príjemky
        // Zobrazit
        Tim_SitLst_V  // Polozky vybraneho dokladu
        Tsb_DlvSur_V  // Zoznam dodavok naviac
        // Tlac
        Lab_PrnLab_F  // Hromadna tlac etikiet
        // Nastroje
        Tim_TsdGen_F  // Vyhotovi dodávate¾skı dodací list
        Tim_ImdPair_F // Párova internú skladovú príjemku
        // Udrzba
        Tim_OsiVer_F  // Vyhotovi dodávate¾skı dodací list
        Key_BokAdd_F  //
        Key_TibEdi_F  // Dodavatelske dodacie listy

Lab_F - Tlaè cenovkovıch etikiet
        // Tlac
        Lab_PrnItm_F  // Tlaè cwnovkovıch etikiet
        // Nastroje
        Lab_PlsFlt_F  // Filtrova poloky cenníka
        Tsb_DocLst_V  // Dodávate¾ske dodacie listy
        Imb_DocLst_V  // Interné skladové príjemky

// Velkoobchodny predaj
Udb_F - Univerzálne odbytové doklady
        // Upravy
        Udb_DocEdi_F  // Hlavièka odbytového dokladu
        Udb_DocCls_F  // Uzatvorenie dokladu
        Udb_ItmEdi_F  // Poloka odbytového dokladu
        // Zobrazit
        Ocb_ItmLst_F  // Poloky vybraného dokladu

Ocb_F - Odberate¾ské zákazky
        // Upravy
        Ocb_OchEdi_F  // Hlavicka vybraneho dokladu - nova
        Ocb_OchEdit_F // Hlavicka vybraneho dokladu
        Ocb_DocDsc_F  // Z¾ava na doklad
        Ocb_DocRnd_F  // Zaokrúhli vybranı doklad
        Ocb_DocDel_F  // Zruši vybranı doklad
        Doc_VatChg_F  // Zmena sadzieb DPH
        // Zobrazit
        Ocb_OciLst_F  // Poloky vybraneho dokladu
        Spe_DocLst_V  // Zoznam prijatıch a vydanıch záloh
        Ocb_OccDoc_F  // Zmluva o dielo
        AttLst_V      // Zoznam príloh
        // Tlac
        Ocb_PrnOcd_F  // Tlac vybraneho dokladu
        // Nastroje
        Ocb_DpzLst_F  // Evidencia zálohovıch platieb
        Ocb_PcdGen_F  // Vystavi zálohovú FA
        Ocb_TcdGen_F  // Vystavi odberatelskı DL
        Ocb_IcdGen_F  // Vystavi odberate¾skú FA
        Ocb_ImdGen_F  // Vystavi skladovú pijemku
        Ocb_OmdGen_F  // Vystavi skladovú vydajku
        Doc_RmdGen_F  // Vystavi skladovú prevodku
        Ocb_MneVal_F  // Zadavanie vyrobnych nakladov
        Ocb_NopOch_F  // Zoznam nevybavenych zakaziek
        Ocb_NopOci_F  // Zoznam nevybavenych poloiek
        Ocb_OciExp_F  // Zoznam tovaru na expedíciu
        Ocb_CadGen_F  // Vyuctovat doklad cez ERP
        Ocb_FmsGen_F  // Vyuctovat doklad cez FMS
        Icb_NoPayIc_F // Neuhradené faktúry odberate¾a
        Spe_Conto_F   // Evidencia zálohovıch platieb
        Ocb_OcdSta_F  // Stav odberatelskych zakaziek
        Ocb_OciRes_F  // Rezervacia prijateho tovaru
        Ocb_OciRep_F  // Vıkaz objendnaného tovaru
        Ocb_DocCopy_F // Kopírovanie vybranej zákazky
        Ocb_ResFre_F  // Uvolni rezerváciu po platnosti
        Ocb_ChgTrm_F  // Zmenené termíny dodávok
        Ocb_MinStc_F  // Zásoba pod minimálnym stavom
        Ocb_ShpImp_F  // Import z internetov0ho obchodu
        Exb_ExdGen_F  // Generovanie expediènıch príkazov
        Ocb_ResOsd_F  // Rezervácia objednaného mnostva
        // Udrzba
        Key_BokAdd_F  // Zalozit novu knihu
        Key_OcbEdi_F  // Interne vydajky
        Ocb_StoGen_F  // Prepoèet zákazkovıch rezervácii
        Ocb_Sending_F // Posla odberate¾ské zákazky cez FTP
        Ocb_OciRef_F  // Doplnenie údajov poloiek zákaziek
        Spe_IncDoc_F  // Príjem zálohovej platby
        Doc_OitMsd_F  // Interny prenos dokladov
        Ocb_StpRef_F  // Naèítanie nákupnıch cien
        // Servis
        Ocb_StoRes_F  // Kontrola vydaneho mnozstva zakaziek
        Ocb_DlvVer_F  // Kontrola vydaneho mnozstva zakaziek
        Ocb_OctVer_F  // Kontrola vydaneho mnozstva zakaziek
        Ocb_OciLnk_F  // Nespravne dodane polozky
        Ocb_OciVer_F  // Nespravne vyskaldnene polozky
        Ocb_OciDel_V  // Stornovane polozky zakaziek
        Ocb_OciDir_V  // Polozky vsetkych dokladov
        Ocb_OcbClc_F  // Prepocet dokladov podla poloziek

Tcb_F - Odberate¾ské dodacie listy
        // Upravy
        Tcb_TchEdit_F // Hlavicka dodacieho listu
        Tcb_DocDsc_F  // Z¾ava na vybranı doklad
        Tcb_AddHds_F  // Logistická z¾ava na doklad
        Tcb_DocRnd_F  // Zaokruhlenie dokladu
        Doc_VatChg_F  // Zmena sadzieb DPH
        // Zobrazit
        Tcb_TciLst_F  // Polozky vybraneho dokladu
        Tcb_NopTch_V  // Zoznam nevypárovanıch dodacích listov
        Tcb_NosTci_V  // Nevyskladnené poloky DL
        TcbTcc_V      // Nevysporiadane komponenty
        TccLst_V      // Zoznam vyrobkov a komponentov
        TcdTcs_V      // Zoznam vyrobkov a komponentov
        Jrn_AccLst_V  // Úètovné zápisy dokladu
        // Tlac
        Tcb_DocPrn_F  // Tlac vybraneho dokladu
        Tcb_TcdPrn_F  // Tlac zoznamu dokladov
        // Nastroje
        Tcb_DocFlt_F  // Filtrov zoznam dokladov
        Tcb_OutDoc_F  // Vıdaj poloiek vybraného dokladu
        Tcb_AccPer_F  // Zauctovat doklady za obdobie
        Tcb_IcdGen_F  // Vystavenie odberatelskej faktury
        Tcb_IcdMog_F  // Hromadne vystavenie faktury
        Tcb_CadGen_F  // Vyúètova doklad cez FM
        Icb_NoPayIc_F // Neuhradené faktúry odberate¾a
        Tcb_OutStk_F  // Hromadné vyúètovanie skladu
        Tcb_DocClc_F  // Prepocet cien vybraného dokladu
        Tcb_FmdGen_F  // Vyuctovat doklad cez FMS
        Doc_TrdOut_F  // Naèíta terminálové vıdajky
        Doc_TrdCpr_F  // Porovna s terminálovou vıdajkou
        Omb_OmiFxa_F  // Vıkaz vydaného majetku
        Exb_ExdGen_F  // Generovanie expediènıch príkazov
        Tcb_WgdImp_F  // Naèítanie váhovıch dokladov
        Tcb_EdiRcv_F  // Medzifiremnı prenos dokladu
        WgdImp_F      // Naèítanie váhovıch dokladov
        BciImp_F      // Naèítanie elektronickeho dokladu
     // Udrzba
        Tcb_TciRef_F  // Hlavickove udaje do polozky
        Tcb_TchRef_F  // Obnova údajov hlavièiek DL
        Tcb_Sending_F // Posla dodacie listy cez FTP
        Tcb_StmTcd_F  // Porovnávanie dokladu s pohybmi
        Tcb_StmTca_F  // Porovnávanie dokladov s pohybmi
        Tcb_TcdVer_F  // Hodnotová kontrola dokladov
        Tcb_TcnVer_F  // Kontrola interného èísla dokladu
        Tcb_TciSyn_F  // Synchronizácia zakladnych udajov
        Doc_OitMsd_F  // Interny prenos dokladov
        Tcb_TciDir_V  // Poloky všetkıch dodaích listov
        Tcb_DocMov_F  // Presun dokladu do inej knihy
        Key_BokAdd_F  // Zalozit novu knihu
        Key_TcbEdi_F  // Dodavatelske dodacie listy
        // Servis
        Tcb_TcdRen_F  // Precislovanie dodacich listov
        Tcb_TciToN_F  // Zmeni poloky na neodpoèítané
        Tcb_TchVer_F  // Kontrola hlavièiek pod¾a poloiek
        Tcb_CaMark_F  // Oznaèi DL ako vyúètovanı cez ERP
        Tcb_TcpDir_V  // Zoznam vydanıch vırobnıch èísiel
        Tcb_OutBook_F // Vıdaj poloiek všetkıch dokladov
        Tcb_FgCalc_F  // Prepocet vyuctovecej meny
        Tcb_MsnRef_F  // Doplnit merne jednotky
        Tcb_CncOut_F  // Zrušenie vıdaj tovaru
        Tcb_TomCmp_F  // Naèíta terminálové vıdajky
        Doc_AcvClc_F  // Prepocet uctovnej meny
        Tcb_ItgVer_F  // Kontrola vyuctovania poloziek cez pokladnu
        // Pokladna
        Cas_IncDoc_F  // Prijem poc. stavu do FM
        Cas_ExpDoc_F  // Prijem poc. stavu do FM
        // Ostatne
        Tcb_BonAdd_F  // Bónusová akcia

Icb_F - Evidencia odberate¾skıch faktúr
        // Upravy
        Icb_IchEdit_F // Hlavicka odberatelskeh faktury
        Icb_DocDsc_F  // Z¾ava na vybranı doklad
        Icb_DocDsc0_F // Z¾ava na vybranı doklad
        Icb_DocRnd_F  // Zaokruhlenie dokladu
        Icb_DocSpc_F  // Špecifikácia vybraného dokladu
        Doc_VatChg_F  // Zmena sadzieb DPH
        // Zobrazit
        Icb_IciLst_F  // Polozky vybraneho dokladu
        Icb_NopIch_V  // Zoznam nevypárovanıch faktúr
        Icb_NpyIcd_V  // Neuhradené faktúry odberate¾ov
        Inv_PayLst_V  // História úhrady faktúry
        Spe_DocLst_V  // Zoznam prijatıch a vydanıch záloh
        Jrn_AccLst_V  // Uctovne zapisy dokladu
        Acc_PmiLst_V  // Denník úhrady faktúr
        Icb_IccLst_V  // Ulozena kopia faktury
        Icb_IcwLst_V  // Historia upomienok
        // Tlac
        Icb_DocPrn_F  // Tlac vybraneho dokladu
        Icb_IcdPrn_F  // Tlac dokladov za obdobie
        Icb_LiqPrn_F  // Tlac likvidacneho listu
        // Nastroje
        Icb_DocFlt_F  // Filtrova odberate¾ské faktúry
        Icb_IcdFilt_F // Filtrova odberate¾ské faktúry
        Icb_AccPer_F  // Zauctovanie dokladov za obdobie
        Icb_TcdPair_F // Párovanie s dodacím listom
        Icb_TcdGen_F  // Vystavenie dodacieho listu
        Icb_CsdGen_F  // Hotovostná úhrada faktúry
        Icb_CadGen_F  // Hotovostná úhrada faktúry cez ERP
        Icb_CadClm_F  // Storno úhrady faktúry cez ERP
        Icb_NoPayIc_F // Neuhradené faktúry odberate¾a
        Spe_IncDoc_F  // Príjem zálohovej platby
        Spe_ExpDoc_F  // Èerpanie zálphovej platby
        Icb_IcdPay_F  // Poh¾adávky k zadanému dátumu
        Icb_IcpEvl_F  // Poh¾adávky podla splatnosti
        Icb_IcdWrn_F  // Upomineky pre odberatelov
        Icb_PenGen_F  // Vystavenie penalizaènej faktúry
        Icb_DocSnd_F  // Elektronickı prenos dokladu - stary
        Icb_IcdSnd_F  // Elektronickı prenos dokladu
        Icb_CrcPay_F  // Úhrada cez platobnú kartu
        Icb_DocCopy_F // Kopírovanie vybranej faktúry
        Icb_IciRep_F  // Vıpis fakturovaného tovaru
        Icb_IciRepS_F // Vıpis fakturovaného tovaru kumulovane
        Icb_TraExp_F  // Export údajov pre dopravu
        Icb_IcdEml    // Rozoslanie faktúr emailom
        CadGen_F      // Hotovostná úhrada externej faktúry cez ERP
        // Importy
        Icb_ImpCsg    // Import zásielkovıch údajov
        // Udrzba
        Key_BokAdd_F  // Zaloi novú knihu
        Key_IcbEdi    // Dodavatelske dodacie listy
        Icb_IciRef_F  // Doplnenie údajov poloiek OF
        Icb_Sending_F // Posla celú knihy cez FTP
        Icb_PmiVer_F  // Kontrola úhrady faktúr
        Icb_IciTci_F  // Kontrola vypárovania FA a DL
        Icb_CprRef_F  // Prenos nakupnych cien z ODL
        Doc_MisNum_F  // Zoznam chybajucich dokladov
        Doc_OitMsd_F  // Online odoslanie dokladov
        Icb_IcnVer_F  // Kontrola interného èísla dokladu
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
        Icb_IcnDel_F  // Mazanie prázdnych poznámok
        Doc_ItmRef_F  // Obnova udajov poloziek
        Icb_ItmVer_F  // Kontrola DPH poloziek
        ItmRnd_F      // prepocet a zaokruhlenie poloziek
        Icb_DocMov_F  // Presun do inej knihy
        // Ostatne
        Icb_BonAdd_F  // Pridavanie bonusovej akacie

        Icb_SaleLim_F // ???

Spe_F - Evidencia zálohovıch platieb
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

Svb_F - Evidencia faktúr zálohovıch platieb
        // Zobrazit
        Jrn_AccLst_V  //
        // Udrzba
        Key_BokAdd_F  //
        Key_SvbEdi_F  // Dodavatelske dodacie listy
        {Icb_Sending_F}                                                         DEL

Cas_F - Maloobchodnı predaj
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
        Cas_CrdRead_F // Identifikácia cez zákazníku kartu
        Cas_LstVie_F  // Tlac dokladov
        // Pokladna
        Cas_IncDoc_F  // Prijem do pokladne
        Cas_ExpDoc_F  // Vydaj z pokladne
        Cas_PayChg_F  // Zmena platidla
        Cas_Calcul_F  //
        Cas_PrnRep_F  // Tlac pokladnicneho hlasenia na zadany den
        // Konfiguracia
        Cas_SetProp_F //

Eis_F - Údaje pre internetovı obchod
        // Nastroje
        Eis_DmgLst_V  // Zakázané tovarové skupiny                              DEL
        Eis_ExpDat_F  // Export pre internetovy obchod

Tom_F - Záznamníkovı predaj - klientská èas
        // Upravy
        Tom_DocEdit_F // Formular vykazu
        Tom_DocDsc_F  // Zlava na doklad
        Tom_EpcEdit_F // Zodpovedné osoby
        // Zobrazit
        Tom_ItmLst_V  // Polozky dokladu
        Tom_NitLst_V  // Zoznam nepredajneho skladu
        Tom_NocLst_V  // Zoznam nesplnenych dodavok
        Tom_ToaLst_V  // Archivovane terminalove vydajky
        Tom_TohLst_V  // Nevyuctovane terminalove vydajky
        Tom_DitLst_V  // Zoznam zrušenıch poloiek
        // Nastroje
        Tom_OceLst_V  // Expediènı list
        Exb_ExdGen_F  // Vyhotovenie expedicneho prikazu
        Tom_TodVer_F  // Kontrola pred vyuctovanim
        Tom_CadGen_F  // Vyúètova doklad cez ERP
        Tom_IcdGen_F  // Vyúètova doklad cez OFA
        Tom_OcdGen_F  // Vyúètova doklad cez ZKV
        Tom_TcdGen_F  // Vyúètova doklad cez ODL
        Tom_OmdGen_F  // Vyúètova doklad cez ISV
        Tom_FmdGen_F  // Vyúètova doklad cez FMS
        Tom_IcdGen1_F // Vyúètova doklad cez OFA - Pozicny system
        Pob_SalEvl_F  // Vyhodnotenie predaja
        Pob_DlrEvl_F  // Vyhodnotenie predaja
        IncDoc_F      // Prijem zalohovej platby
        // Udrzba
        Key_BokAdd_F  //
        Key_TobEdi_F  // Dodavatelske dodacie listy
        Tom_AItLst_V  // Poloky terminalovıch vydajok
        Tom_IcnRef_F  // Doplni èísla odberatelskıch faktúr
        Tom_TrmClc_F  // Financne vyhodnotenie terminvalov
       // Servis
        Tom_StsVer_F  // Kontrola rezervacii STS
        Tom_EpcRef_F  // Doplnenie zodpovednıch osôb
        Tom_OctLst_F  //
        Tom_GenVer_F  //
        Tom_CrdClc_F  // Prepoèet zákazníckych bonusov
        Tom_SrvLst_F  // Servis - prezeranie a oprava poloziek
        Tom_SpmVer_F  // Kontrola pozícií terminálovıch vıdajok s pohybmi pozícií
        Tob_TcdRef_F  // Obnovenie údajov ODL z TOM
        Tob_TcdIcv_F  // Nacitanie NC z ODL
        Cai_BlkVie_F

Pob_F - Poziènı vıdaj tovaru
        // Uravy
        Pob_DocDsc_F  // Z¾ava na vybranı doklad
        // Zobrazit
        Pob_PoiLst_F  // Zoznam poloziek dokladu
        // Nastroje
        Gpm_ExdGen_F  // Tvorba expediènıch príkazov
        Pob_FmdGen_F  // Vyúètova doklad cez FMS
        Pob_IcdGen_F  // Vyúètova doklad cez OFA
        // Servis
        Pob_TodImp_F  //

// Maloobchodny predaj
Cab_F - Knihy registraènıch pokladní
        // Zobrazit
        Cab_TbiLst_F  //
        // Nastroje
        Cab_CahRef_F  // Nacitanie pokladnicnych udajov
        Cab_CdyEvl_F  //
        Cab_CmgEvl_F  //
        Cab_CasSnd_F  // Posla údaje do pokladne
        // Udrzba
        Sys_CasLst_F  //

Sab_F - Skladové vıdajky MO predaja
        // Zobrazit
        Sab_SaiLst_F  // Polozky vybraneho dokladu
        Sab_SagLst_F  // Trzba pod¾a tovarovıch skupín
        Sab_SacLst_F  // Zoznam vyrobkov a komponentov
        Sab_CasPay_V  // Trzba podla platobnych prostriedkov
        Sab_NsiLst_F  // Nevysporiadané poloky MO predaja
        Sab_NscLst_F  // Nevysporiadané poloky MO predaja - komponenty
        Jrn_AccLst_V  // Úètovné zápisy vybraneho dokladu
        SapLst_V      // Zoznam zaúètovania úhrad FA
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
        Sab_AccDoc_F  // Zaúètova registraènú pokladòu
        // Udrzba
        Sab_DocClc_F  // Prepocet podla poloziek
        Key_BokAdd_F  //
        Key_SabEdi_F  // Vlastnosti knihy
        Sab_TbiDel_F  //
        Sab_StmSad_F  // Porovnávanie dokladu s pohybmi
        Sab_StmSaa_F  // Porovnávanie dokladov s pohybmi
        Sab_SagClc_F  // Prepoèet pod¾a tovarovıch skupín
        Sab_SaiSyn_F  // Synchronizacia zakladnych udajov
        Sab_DelOut_F  // Vráti všetko na sklad
        Doc_OitMsd_F  // Interny prenos dokladov
        SabAcv_F      // Kontrola zauctovania dokladov
        // Servis
        Sab_DocDel_F  //
        Sab_SaiRef_F  //
        Sab_CpiVer_F  // Kontrola predaja podla komponetov
        Sab_MgcChg_F  // Zmena tovarovej skupiny

Cai_F - Informácie pokladnièného predaja
        // Hladat
        Cai_GsSrch_F  // Vyh¾adávanie pokladniènıch dokladov pod¾a zadaného tovaru
        Cai_QntSrc_F  // Vyh¾adávanie pokladniènıch dokladov pod¾a zadaného mnostva
        // Zobrazit
        Cai_CasInf_F  // Okamitá denná trba
        Cai_CgsEvl_F  // Okamitı predaj pod¾a tovaru
        // Nastroje
        Cai_CusEvl_F  // Vyhodnotenie nákupu zákazníkov
        Cai_CurEvl_F  // Vyhodnotenie predaja pokladníkov
        Cai_CsdPrn_F  // Tlaè kópie pokladniènej úètenky
        Cai_PayEvl_F  // Vyhodnotenie predaja pokladníkov
        Cai_CasBtm_F  // Vyhodnotenie èasu úètovania
        Cai_CusExp_F  // Export nakupu zakaznikov do e-journalu LYONESS
        // Udrzba
        Cai_PckVer_F  // Kontrola obalovıch tovarov
        Cai_BlkVer_F  // Kontrola dokladov
        // Storna
        Cai_CacItm_F  // Polokovitı zoznam storien
        Cai_CanItm_F  // Polokovitı zoznam reklamacii
        Cai_CacUsr_F  // Kumulatívne pod¾a pokladníkov

Cdc_F - Tlaè kópií dokladov
        ItmRnd_F      // Prepocet a zaokruhlenie poloziek dokladu
        Icb_ExpTxt_F  // Uloi do textového súboru

Cac_F - Vıkaz dennıch uzávierok
        // Nastroje
        CacLst_F      // Vlastnosti vybranej knihy
        CacCol_F      // Vlastnosti vybranej knihy

// Riadenie logistiky
// Riadenie servisu
Scb_F - Servisné zákazky
        // Upravy
        Scb_SchEdi_F  // Hlavicka servisnej zakazky
        Scb_SchEdt_F  // Hlavicka servisnej zakazky
        // Zobrazit
        Scb_SciLst_F  // Poloky vybraného dokladu
        Scb_ScgStk_F  // Sklad servisovaného tovaru
        // Nastroje
        Scb_DocFlt_F  // Filtrovanie servisnıch zákaziek
        Scb_JudClm_F  // Posúsenie servisného prípadu
        Scb_SolAcl_F  // Riešenie servisného prípadu - uznaná reklamácia
        Scb_SolNcl_F  // Riešenie servisného prípadu - neuznaná reklamácia
        Scb_RetScg_F  // Vráti tovar zákazníkovi
        Scb_BegRep_F  // Zahájenie servisnıch prác
        Scb_EndRep_F  // Ukonèenie servisnıch prác
        Scb_RepSnd_F  // Záznam odoslania do opravy
        Scb_RepRcv_F  // Záznam vrátenia z opravy
        Scb_Cls101_F  // Ukonèenie servisného prípadu - vlastná oprava
        Scb_Cls102_F  // Ukonèenie servisného prípadu - vımena
        Scb_Cls103_F  // Ukonèenie servisného prípadu - dobropis
        Scb_EndMsg_F  // Oznámenie ukonèenia servisu
        Scb_TrmVer_F  // Kontrola dodrania lehôt
        // Servis
        Scb_SciDir_V  // Polozky vsetkych dokladov

Clb_F - Zákaznícke reklamácie
        // Udrzba
        Clb_ClbEdit_F // Vlastnosti vyrbanej knihy
        Doc_OitMsd_F  // Interny prenos dokladov

// Kompenzacna vyroba
Cmb_F - Kompletizácia vırobkov
        // Upravy
        Cmb_CmhEdit_F // Hlavicka vybraneho dokladu
        // Zobrazit
        Cmb_CmiLst_F  // Polozky vybraneho dokladu
        // Tlac
        Cmb_DocPrn_F  // Tlac vybraneho dokladu
        Cmb_CmdPrn_F  // Zoznam dokladov za obdobie
        // Nastroje
        Cmb_CmpDoc_F  // Kompletizacia vybraneho vyrobku
        Cpb_CphLst_V  // Kalkulácia vyrobkov
        // Udrzba
        Key_BokAdd_F  // Zalozit novu knihu
        Key_CmbEdi_F  // Kniha kompletizacii
        Cmb_StmCmi_F  //
        Cmb_StmCma_F  // Porovnávanie dokladov s pohybmi
        // Servis
        Cmb_CmiToN_F  //
        Cmb_ItmRev_F  //

Cpb_F - Kalkulácia vırobkov
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
Isb_F - Dodávate¾ské faktúry
        // Upravy
        Isb_IshEdit_F // Hlavicka dodavatelskej faktury
        Isb_DocDel_F  // Zrusenie vybranej faktury
        Isb_DocDsc_F  // Z¾ava na faktúru
        Isb_DocRnd_F  // Zaokrúhlenie dokladu
        Isb_DocRev_F  // Uprava faktury
        Isb_FgdRev_F  // Uprava faktury - zahranicna faktura
        Isb_DocSpc_F  // Špecifikácia vybraného dokladu
        Doc_VatChg_F  // Zmena sadzieb DPH
        // Zobrazit
        Isb_IsiLst_F  // Polozky vybranej faktury
        Inv_PayLst_V  // Historia uhrady faktur
        Isb_PmqLst_V  // Historia prevodnych prikazov
        Isb_NpyIsd_V  // Neuhradené faktúry dodávate¾ov
        Jrn_AccLst_V  // Uctovne zapisi dokladu
        Acc_PmiLst_V  // Dennik uhrady dokladov
        Isb_IswLst_V  // Evidencia upomienok
        // Tlac
        Isb_DocPrn_F  // Tlac vybraneho dokladu
        Isb_IsdPrn_F  // Zoznam dokladov za obdobie
        // Nastroje
        Isb_DocFlt_F  // Filtrova dodávate¾ské faktúry
        Isb_IsdFilt_F // Filtrovamie došlıch faktúr
        Isb_TsdPair_F // Parovanie s dodacim listom
        Isb_DocCopy_F // Kopirovanie dokladu
        Isb_IsdPay_F  // Zavazky k zadanemu datumu
        Isb_IspEvl_F  // Zavazky podla splatnosti
        Isb_IsdLiq_F  // Likvidácia dodávatelskej faktury
        // Udrzba
        Key_BokAdd_F  // Zaloi novú knihu
        Key_IsbEdi_F  // Dodavatelske FA Key_SabEdi_F;
        Isb_PmiVer_F  // Kontrola úhrady faktúr
        Isb_IsnVer_F  // Kontrola interného èísla dokladu
        Isb_IsdVer_F  // Hodnotová kontrola dokladov
        Doc_MisNum_F  // Zoznam chybajucich dokladov
        Doc_OitMsd_F  // Internı prenos dokladov
        Doc_ItmRef_F  // Obnova udajov poloziek
        // Servis
        Doc_AcvClc_F  // Prepocet uctovnej meny
        Isb_IsdRen_F  // Precislovanie dokladov
        Isb_AccDate_F // Doplni dátum rozúètovania
        Isb_DocDate_F // Doplni dátum FA do poloiek
        Isb_IsiDir_V  // Poloky všetkıch faktúr
        Isb_CrsChg_F  // Prepoèet faktúry pod¾a zmeneného kurzu

Csb_F - Hotovostné pokladne
        // Upravy
        Csb_CshEdit_F // Vybrany pokladnicny doklad
        Csb_EndCalc_F // Prepoèet koneèného stavu
        Csb_DocSpc_F  // Špecifikácia vybraného dokladu
        // Zobrazit
        Csb_CsdSum_F  // Kumulativne udaje pokladne
        Csb_CsoInc_V  // Príjmové hotovostné operácie
        Csb_CsoExp_V  // Vıdajové hotovostné operácie
        Jrn_AccLst_V  // Zoznam úètovnıch zápisov
        Acc_PmiLst_V  // Denník úhrady faktúr
        // Tlac
        Csb_DocPrn_F  // Tlac pokladnicneho dokladu
        Csb_MtbPrn_F  // Tlac mesacnej pokladnicnej knihy
        // Nastroje
        Csb_DocFlt_F  // Filtrova pokladnièné doklady
        Csb_CsfRep_F  // Vykaz platieb fyzickym osobam
        Csb_AccPer_F  // Zauctovanie dokladov za obdobie
        // Udrzba
        Key_BokAdd_F  //
        Key_CsbEdi    // Dodavatelske dodacie listy
        Csb_CsiDir_V  // Poloky všetkıch dokladov
        Csb_PmiVer_F  // Kontrola uhrady faktur
        Csb_CntClc_F  // Prepoèet koneèného stavu
        Csb_AccRef_F  // Obnova predkontacie faktur
        Doc_OitMsd_F  // Interny prenos dokladov
        // Service
        Csb_CshRen_F  // Precislovanie pokladnicnych dokladov
        Csb_CsiRef_F  // Doplnenie údajov poloiek dokladov
        Csb_PacRef_F  // Doplnit kod firmy do polozeik

Sob_F - Bankové vıpisy
        // Upravy
        Sob_SohEdit_F // Hlavicka bankoveho vypisu
        // Zobrazit
        Sob_SoiLst_F  // Polozky bankoveho vypisu
        Acc_PmiLst_V  // Denník úhrady faktúr
        Jrn_AccLst_V  //
        // Tlac
        Sob_DocPrn_F  //
        // Nastroje
        Sob_AboOtp_F  // Elektronickı bankovı vıpis - OTP
        Sob_AboSls_F  // Elektronickı bankovı vıpis - SLOVENSKA SPORITELNA
        Sob_AboSbr_F  // Elektronickı bankovı vıpis - SBERBANK
        Sob_AboUni_F  // Elektronickı bankovı vıpis - UNICREDIT
        Sob_SomLst_V  // Evidencia bankovıch operácií
        Sob_EndCalc_F // Prepoèet koneèného stavu
        Sob_AboDat_V  // Údaje elektronickeho bankovníctva
        // Udrzba
        Key_BokAdd_F  // Zaloi novú knihu
        Key_SobEdi_F  // Dodavatelske dodacie listy
        Sob_AccCalc_F // Prepoèet poloiek pod¾a kurzu
        Sob_PmiVer_F  // Kontrola uhrady faktur
        Doc_OitMsd_F  // Interny prenos dokladov
        Sys_LdgFlt_F  // Filtrovanie dokladov
       // Service
        Sob_AccPdf_F  // Predkontácia rozdielov úhrady
        Sob_SoiDir_V  // Poloky všetkıch bankovıch vıpisov
        Sob_PacRef_F  // Doplnit kod firmy

Pqb_F - Prevodné príkazy
        // Upravy
        Pqb_PqhEdit_F // Hlavicka vybraneho dokladu
        Pqb_NpyIsd_F  // Neuhradené dodávate¾ské faktúry
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

Vtb_F - Evidencia DPH - starı //                                                 DEL
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
        Vtb_SrvCrt_F  // Súhrnnı vıkaz DPH                                       DEL

Vtr_F - Evidencia DPH
        // Upravy
        Vtb_NopVat_F  // Neuhradená DPH k zadanému dátumu
        Vtr_ClsDel_F  // Zrusit vykaz uzavierky DPH
        Vtr_AddCls_F  // Pridat novu uzavierku DPH
        // Zobrazit
        Vtr_DocLst_V  // Vsetky polozky vykazu DPH
        Vtr_VtiLst_V  // Polozky kontrolneho vykazu DPH
        Pab_EuStat_V  // Zoznam èlenskıch štátov EU
        Vtb_VtcLst_V  // Zoznam kalkulaènıch období
        Vtr_VtdSpc_V  // Specifikacia dokladov DPH
        // Tlac
        Vtr_VtdPrn_F  // Tlac danoveho priznania
        // Nastroje
        Vtr_ActVer_F  // Porovnavanie s aktualnym stavom
        Vtr_JrnVer_F  // Porovnavanie s dennikom UZ
        Vtr_NapVat_F  // Vykaz neuplatnenej DPH
        Vtr_VatVer_F  // Kontrola spr8vnosti ciastky DPH
        Vtr_SrvCrt_F  // Súhrnnı vıkaz DPH
        VtrXms_F      // Generovanie suhrnneho vıkazu DPH do XML
        VtrXmr_F      // Generovanie vıkazu DPH do XML
        VtrXmi_F      // Generovanie kontrolného vıkazu DPH do XML
        // Udrzba
        Key_VtrEdi_F  // Inicializaèné parametre

Acv_F - Úètovné pomôcky
        // Nastroje
        Acv_AccVer_F  // Kontrola rozuctovanosti dokladov
        Acv_MetVer_F  // Kontrola spravnosti metodiky uctovania
        Acv_BlcVer_F  // Kontrola bilancie uctovnych zapisov
        Acv_SntInv_F  // Inventarizacia suvahovych úètov
        Acv_TsdNop_F  // Vykaz nevyfakturovanych dodavok

Srb_F - Vıkazy liehovıch vırobkov
        // Upravy
        Srb_DocEdit_F // Hlavicka vykazu liehovych vyrobkov
        SrdEdi_F      // Hlavicka vykazu liehovych vyrobkov 2011
        Srb_DocDel_F  // Zrusenie vykazu liehovych vyrobkov
        Srb_Collect_F // Zber udajov do vybraneho vykazu
        SrbCol_F      // Zber udajov do vybraneho vykazu
        // Zobrazit
        Srb_SrCat_V   // Evidencia liehovıch vırobkov
        Srb_SrSta_V   // Mesaènı stav liehovıch vırobkov
        Srb_SrMov_V   // Mesaènı stav liehovıch vırobkov
        // Tlac
        Srb_DocPrn_F  // Tlac vybraneho vykazu
        // Nastroje
        Srb_XmlExp_F  // Generovanie XML

Srd_F - Vıkazy liehovıch vırobkov
        // Upravy
        SrdEdi_F      // Hlavicka vykazu liehovych vyrobkov 2011
        SrbCol_F      // Zber udajov do vybraneho vykazu
        // Zobrazit
        SrbCat_V      // Evidencia liehovıch vırobkov
        SrbSta_V      // Mesaènı stav liehovıch vırobkov
        SrbMov_V      // Mesaènı stav liehovıch vırobkov
        // Tlac
        SrbPrn_F      // Tlac vybraneho vykazu
        {Srb_DocPrn_F}// Tlac vybraneho vykazu
        // Nastroje
        SrbXml_F      // Zrušenie vıkazu
        SrbImp_F      // Vıkaz liehovıch vırobkov
        SrbRep_F      // Vıkaz liehovıch vırobkov
        SrbSum_V      // Mesaènı stav liehovıch vırobkov

Mtb_F - Skladov9 karty MTZ {Evidencia uívate¾ov systému}                       DEL
        // Upravy
        Mtb_StcEdit_F //                                                        DEL
        Mtb_ImdEdit_F //                                                        DEL
        Mtb_OmdEdit_F //                                                        DEL
        // Tlac
        Mtb_MtsPrn_F  //                                                        DEL
        Mtb_MtiPrn_F  //                                                        DEL
        Mtb_MtoPrn_F  //                                                        DEL

Crs_F - Kurzovı list národnej banky                                             DEL
        // Upravy
        Crs_CrhEdit_F // Dennı kurz devíz                                       DEL
        // Nastroje
        Crs_RcvDat_F  // Nacitat kurzovy list NBS                               DEL
        Crs_RcvEcb_F  // Nacitat kurzovy list ECB                               DEL

Owb_F - Vyúètovanie sluobnıch ciest                                            DEL
        // Upravy
        Owb_OwhEdit_F // Hlavicka cestovného príkazu                            DEL
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

Dpb_F - Postúpené a odkúpené poh¾adávky
        // Upravy
        Dpb_DocEdi_F  // Zaloi hlavicku zmluvy
        // Zobrazit
        Inv_PayLst_V  // História úhrady faktúry
        Dpb_SitLst_V  // Pohladavky vybranej zmluvy

// Jednoduche uctovnictvo
Fna_F - Predkontaèné predpisy
        // Upravy
        Fna_ItmEdit_F // Editor predkonta4n0ho predpisu

Fjr_F - Peòanı denník
        // Zobrazit
        Fjr_FinInf_F  // Stav penaznych prostredkov
        // Tlac
        Fjr_PrnDoc_F  // Tlac penazneho dennika
        // Nastroje
        Fjr_ItmFlt_F  // Filtrova peòanı denník
        Fjr_AddBeg_F  // Zaúètova poèiatoènı stav

Fri_F - Vıkaz príjmov a vıdajov
        // Upravy
        Fri_AddDoc_F  // Prida novı vıkaz

Frp_F - Vıkazy o majetku a záväzkoch
        // Upravy
        Frp_AddDoc_F;    // Prida novı vıkaz

// Podvojne uctovnictvo
Jrn_F - Denník úètovnıch zápisov
        // Zobrazit
        Acc_AccSnt_V  // Úètovná osnova syntetickıch úètov
        Acc_AccAnl_V  // Úètovná osnova analytickıch úètov
        Jrn_NotRnd_F  // Nezaokrúhlené úètovné záznamy
        Jrn_BegClc_F  // Poèiatoèné stavy
        // Nastroje
        Jrn_AccFilt_F // Filtrovanie uctovnych zapisov
        Jrn_AccSum_F  // Obrat uctu za obdonie
        Jrn_AccMov_F  // Pohyby vybraneho uctu
        Jrn_AccBlc_F  // Vykaz saldokontnych uctov
        Jrn_SuvCalc_F // Vykaz suvahovıch úètov
        Jrn_VysCalc_F // Vykaz vısledovkovıch úètov
        Jrn_DefCalc_F // Vykaz definovanıch úètov
        // Servis
        Jrn_StmJrn_F  // Kontrola podla skladovych pohybov
        Jrn_BookVer_F // Kontrola podla knih dokladov

Acc_F - Obratová predvaha úètov
        // Tlac
        Acc_TrnPrn_F  // Tlaè obratovej predvahy
        // Nastroje
        Jrn_AccMov_F  // Pohyby vybraného úètu
        Acc_ReCalc_F  // Prepoèet obratovej predvahy

Act_F - Vıkaz obratovej predvahy
        // Upravy
        Act_AddAct_F  // Pridat novy vykaz
        Act_DelAct_F  // Zrusit vybrany vykaz
        // Zobrazit
        Act_ItmLst_V  // Zoznam poloziek vykazu

Blc_F - Úètovné vıkazy
        Blc_Upgrade_F // Aktualizácia podvojného úètovníctva
        Blc_Calc_F    // Vıpoèet nového vıkazu
        Blc_SuvDef_F  // Definícia riadku súvahy
        Blc_VysDef_F  // Definícia riadku vısledovky
        Blc_SuvPrev_F // Stav v minulom úètovnom období
        Blc_VysPrev_F // Stav v minulom úètovnom období
        Blc_SuvCalc_V // Kalkulaènı vzorec riadku vıkazu súvahy
        Blc_VysCalc_V // Kalkulaènı vzorec riadku vıkazu vısledovky

Idb_F - Interné úètovné doklady
        // Upravy
        Idb_IdhEdit_F // Havicka vybraneho dokladu
        Idb_DelDoc_F  // Zrušenie úètovného dokladu
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
        Idb_PmiVer_F  // Kontrola úhrady faktúr
        Idb_IdiDir_V  // Poloky všetkıch dokladov
        Idb_CrdDif_F  // Dodatocne pridane polozky
        // Service
        Idb_IdhRen_F  // Precislovanie dokladov
        Idb_PacRef_F  // Doplnenie kodu firmy

Rcr_F - Koncoroèné prekurzovanie faktúr
        // Upravy
        Rcr_IsdCol_F  // Zber neuhradenych zahranicnych DF
        Rcr_IsdRcr_F  // Vypocet kurzovych rozdielov DF
        Rcr_IsdAcc_F  // Zauctovanie kurzovych rozdielov DF
        Rcr_IcdCol_F  // Zber neuhradenych zahranicnych OF
        Rcr_IcdRcr_F  // Vypocet kurzovych rozdielov OF
        Rcr_IcdAcc_F  // Zauctovanie kurzovych rozdielov OF
        // Zobrazit
        Rcr_IsdRcr_V  // Zoznam prekurzovanıch faktúr
        Rcr_IcdRcr_V  // Zoznam prekurzovanıch faktúr

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
Asc_F - Analıza záväzkov a poh¾adávok
        // Upravy
        Asc_DocEdi_F  // Analıza záväzkov a poh¾adávok
        Asc_DocDel_F  // Zruši vybranı vıkaz                                   !

// Logistika
RbaSta_F - Vıkaz vırobnej šare

// Manazment
Sta_F - Štatistika nákupu a predaja
        // Nakup
        Sta_TopSap_F  // Vyhodnotenie najlepsich dodavatelov
        !Sta_SapGsl_V // Nákup vybraného dodávate¾a
        Sta_SapPay_F  // Sucet platieb pre dodavatela
        // Predaj
        Sta_TopCus_F  // Vyhodnotenie najlepsich doberatelov
        Sta_CtySal_F  // Vyhodnotenie predaja podla miest
        Sta_SalGsp_F  // Predaj tovaru podla odberatelov
        Sta_SalPam_F  // Predaj odberate¾a pod¾a skupín
        Sta_SalNul_F  // Predaj odberate¾a pod¾a skupín
        //
        Sta_SalEvl_F  // Vyhodnotenie MO a VO predaka
        Sta_IcdPrf_F  // Ziskovost odberatelskych faktur
        //
        Sta_WriEvl_F  // Vyhodnotenie predaja prevádzky
        Sta_WmgEvl_F  // Vyhodnotenie predaja pod¾a skupín
        Sta_WgsEvl_F  // Vyhodnotenie predaja pod¾a tovaru
        // Sklad
        Sta_DayGsm_F  // Denny prijem a vydaj tovar
        Sta_GscMov_F  // Mesacny prijem a vydaj tovaru
        Sta_MgcMov_F  // Prijem a vydaj podla tovarovych skupin
        //
        Sta_WrsEvl_F  // Vyhodnotenie skladov prevádzok
        // Ostatne
        Sta_StmAll_F  // Vyhodnotenia skladovych pohybov
        Sta_CstExp_F  // Export do centrálnej štatistiky

Seb_F - Vıberová štatistika predaja
        // Upravy
        Gsc_GsLst_V   //
        Seb_Collect_F //
        // Udrzba
        Seb_SebEdit_F //

Npb_F - Záznamy o problémoch                                                    DEL
        // Upravy
        Npb_NpdEdit_F                                                           DEL
        Npb_NpSend_F                                                            DEL
        Npb_NpProc_F                                                            DEL
        Npb_NpSolv_F                                                            DEL

Rew_F - Odmeny pre obchodníkov                                                  DEL
        // Upravy
        Rew_AddRep_F  // Pridat novy vykaz                                      DEL
        Rew_DelRep_F  // Zrusit vybrany vykaz                                   DEL
        // Zobrazit
        Rew_ItmLst_V  // Zoznam poloziek vykazu                                 DEL

Wab_F - Vıpoèet odmeny zamestnancov
        // Upravy
        Wab_WahEdi_F  // Editor na zalozenie noveho vykazu
        // Zobrazit
        Wab_WaeLst_V  // Zoznam zamestnancov vybraneho dokladu
        // Nastroje
        Sys_EpcLst_V  // Zoznam zamestnancov
        Wab_EpgLst_V  // Zamestnanecké skupiny

Dsp_F - Vınimky odblokovania zákazníka
        // Upravy
        Dsp_ItmEdi_F  // Pridat novú vınimku

Rpl_F - Doporuèené predajné ceny
        // Upravy
        Rpl_ImpDat_F  // Naèíta cennik dodavatela
        Rpl_ImpPls_F  // Naèíta predajnı cenník
        Rpl_ImpNew_F  // Naèíta nové poloky z NEX
        Rpl_CpyMgp_F  // Hromadnı prenos DC do OC
        Rpl_CpyMgn_F  // Hromadnı prenos OC do OC
        Rpl_ChgMgc_F  // Zmena tovarovıch skupín
        Rpl_ItmEdit_F // Upravi údaje poloky
        Rpl_ChgName_F // Preloi názoy tovarov
        Rpl_CpyName_F // Preloi názoy tovarov
        Rpl_StcEdi_F  // Zmena skladovej pozicie
        // Zobrazit
        Rpl_BokEdi_F  // Vlastnosti cenníka
        // Nastroje
        Rpl_ItmFilt_F // Filtrova poloky cenníka
        Rpl_DisRpl_F  // Zoznam vyradenıch poloiek
        Rpl_StpClc_F  // Vıpoèet predajnıch cien
        Rpl_ExcClc_F  // Vıpoèet špeciálnych cien
        Rpl_ImpDef_F  // Import základnıch údajov
        Rpl_ExpDef_F  // Export základnıch údajov
        Rpl_ExpMdc_F  // Export obchodnıch cien - MEDIACAT
        Rpl_ExpNex_F  // Export údajov do systému NEX

Prj_F - Správa podnikovıch projektov
        // Upravy
        Prj_DocEdi    // Editor projektu
        // Nastroje
        Prj_DocFlt    // Filtrovanie podla projektu

Prb_F - Správa informaènıch projektov
        // Upravy
        Prb_DocEdi_F  // Editor projektu
        // Zobrazit
        Prb_ItmLst_V  // Polozky projektu
        Prb_DocClc_F  // Vyhodnotenie projektu
        // Udrzba
        Key_PrbEdi    // Vlastnosti vybranej knihy 

Crb_F - Správa zákazníckych poiadaviek
        // Upravy
        Crb_DocEdi_F  // Editor poiadavky
        // Zobrazit
        {Prb_ItmLst_V}// Polozky projektu
        {Prb_DocClc_F}// Vyhodnotenie projektu
        // Udrzba
        Key_CrbEdi_F  // Vlastnosti vybranej knihy 

Job_F - Evidencia pracovnıch úkolov
        // Upravy
        Job_DocEdi    // Prida úkol
        // Nastroje
        Job_ItmCpy_F  // Kopírova úkol

Pxb_F - Návrh informaènıch systémov

// Administrativa
Apb_F - iadosti bezhotovostného styku
        // Upravy
        Apb_DocEdi    // Zaloi iados
        Apb_DebVer    // Overi dlhy iadate¾a
        Apb_AprSig    // Schváli iados
        // Zobrazit
        Apb_DocInf_F  // Zobrazi iados
        Apb_DelLst_V  // Zrušené iadosti

Ipb_F - Evidencia došlej pošty
        // Upravy
        Ipb_DocEdi_F  //
        Ipb_DetEdi_F  //
        Ipb_DocScn    //
        // Nastroje
        Ipb_IpgLst    //

Eml_F - Elektronické správy
        // Upravy
        Eml_MsgEdi_F  //
        Eml_MsgVie_F  //
        EmlFlt_F      //
        EmlAdr_F      //

Emc_F - Elektronické správy
        Emc_MsgEdi_F  //

// Systemove nastroje
Sys_F - Nastavenie systémovıch údajov
        // Upravy
        Sys_SysProp_F // Vlastnosti informacneho systemu
        Sys_ComProp_F // Komunikacne parametre systemu
        Sys_IniProp_F // Inicializacne parametre systemu
        Sys_OpenDoc_V // Zoznam otvorenıch dokladov
        Sys_DocCls_F  // Uzatvorenie dokladov systému
        Sys_WriCls_V  // Uzatváranie dokladov prevádzok
        Sys_Device_V  // Nastavenie perifernych zariadeni
        Sys_RegSys_F  // Registrácia informaèného systému
        // Tlaè
        Sys_TicPrn_V  // Tlaè platobnıch kupónov
        // Nastroje
        Sys_SysLst_V  // Evidencia podsystémov
        Sys_CntLst_V  // Evidencia hospodárskych stredisk
        Sys_WriLst_V  // Evidencia prevadzokovıch jednotiek
        Sys_StkLst_V  // Evidencia tovarovıch skladov
        Sys_EpcLst_V  // Evidencia zamestnancov
        Sys_CasLst_V  // Evidencia registracnıch pokladníc
        Sys_DlrLst_V  // Evidencia obchodnıch zástupcov
        Sys_DrvLst_V  // Evidencia vodièov sluobnıch vozidiel
        Sys_UsrLst_V  // Evidencia uzivatelov systemu
        Sys_CapDef_V  // Evidencia platobnıch prostriedkov
        Sys_OitDef_V  // Definicia interneho prenosu udajov
        Sys_RwcLst_V  // Definicia medziprevadzkoveho prenosu
        Sys_MyConto_V // Zoznam bankovıch úètov
        Sys_FtpMng_F  // Oznacenie dokladov na FTP prenos
        Sys_ColItm_V  // Evidencia zbernych poloziek
        // Import
        Sys_ImpGsc_F  // Import evidencii tovaru
        Sys_ImpBac_F  // Import druhotnıch kódov
        Imp_GscNot_F  // Import poznámok k tovarom
        Sys_ImpPac_F  // Import evidencii firiem
        Sys_ImpPls_F  // Import predajneho cenika
        Sys_ImpApl_F  // Import akciového cenika
        Sys_ImpAnl_F  // Import úètovnej osnovy
        // Rozhranie
        Sys_ExpTps_F  // Export pre TP-SOFT
        Sys_ImpTps_F  // Import zo systemu TP-SOFT
        Imp_SofDat    // Import dokladov systemu SOFTIP
        Imp_SofJrn    // Import úètovnej dávky SOFTIP
        Stenia4_F     // Príjem tovaru STIHL a naslednı predaj do AS
        // Service
        Sys_VatChg_F  // Zmena sadzieb DPH
        Sys_ArcYear_F // Uzavierka roka

Ifc_F - Nastavenie systémovıch údajov
        // Import
        Sys_ImpGsc_F  // Import evidencii tovaru
        Sys_ImpBac_F  // Import druhotnıch kódov
        Imp_GscNot_F  // Import poznámok k tovarom
        Sys_ImpPac_F  // Import evidencii firiem
        Sys_ImpPls_F  // Import predajneho cenika
        Sys_ImpApl_F  // Import akciového cenika
        // Rozhranie
        Exp_CasRef    // Export REF suborov pre pokladne
        // Rozhranie
        Sys_ExpTps_F  // Export pre TP-SOFT
        Sys_ImpTps_F  // Import zo systemu TP-SOFT
        Imp_SofDat    // Import dokladov systemu SOFTIP
        Imp_SofJrn    // Import úètovnej dávky SOFTIP

Usr_F - Evidencia uívatelov systému
        // Upravy
        UsrPsw_F      // Nastavenie hesla

{Usd_F}
Grp_F - Evidencia pracovnıch skupín
        // Nastravenia
        Usd_AfcGsc_F  // Evidencia tovaru
        Usd_AfcPob_F  // Pozièné skladové vıdajky
        Usd_AfcScb_F  // Servisné zákazky
        Usd_AfcKsb_F  // Komisionalne vysporiadanie
        Usd_AfcOcb    // Odberate¾ské zákazky
        Usd_AfcTcb    // Odberate¾ské dodacie lsity
        Usd_AfcIcb    // Odberate¾ské FA
        Usd_AfcOsb    // Odberate¾ské zákazky
        Usd_AfcTsb    // Dodavate¾ské dodacie lsity
        Usd_AfcIsb    // Dodavate¾ské FA
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
        Usd_AfcMcb    // Odberate¾ské cenové ponuky
        Usd_AfcPsb    // Plány dodávate¾skıch objednávok

Bac_F - Riadenie viazaností kníh
        NxbLst_V      // Zoznam kníh vybraného modulu

Key_F - Správa riadiacich parametrov
        Key_SysEdi_F  // Globálne parametre systému
        {Key_CrdEdi_F}// Zákaznícke karty
        Key_AscEdi_F  // Analıza záväzkov a poh¾adávok
        Key_WriEdi_F  // Prevádzkové jednotky
        Key_GscEdi_F  // Bázová evidencia tovaru
        Key_EmcEdi_F  // Elektronicke spravy
        Key_StkEdi_F  // Sklady
        Key_AplEdi_F  // Akciove cenniky
        Key_ImbEdi_F  // Interné skladové vıdajky
        Key_OmbEdi_F  // Interné skladové vıdajky
        Key_RmbEdi_F  // Medziskladové prevodky
        Key_PkbEdi_F  // Prebalovanie
        Key_CmbEdi_F  // Kompletizacia
        Key_DmbEdi_F  // Kompletizacia
        Key_OsbEdi_F  // Dodávate¾ské objednávky
        Key_TsbEdi_F  // Dodavatelske dodacie listy
        Key_IsbEdi_F  // Dodavatelske faktury
        Key_McbEdi_F  // Odberatelske cenové ponuky
        Key_OcmEdi    // Odberatelske zákazky - modul
        Key_OcbEdi_F  // Odberatelske zákazky - knihy
        Key_TcbEdi_F  // Odberatelske dodacie listy
        Key_IcmEdi    // Odberatelske faktury - modul
        Key_IcbEdi    // Odberatelske faktury - knihy
        Key_CsbEdi    // Hotovostne pokladne
        Key_CsbEdi_F  // Hotovostne pokladne OLD
        Key_SobEdi_F  // Bankove vypisy
        Key_IdbEdi_F  // Interne doklady
        Key_CrdEdi    // Zakaznicke karty
        Key_PrmEdi    // Správa informaènıch projektov - modul
        Key_PrbEdi    // Správa informaènıch projektov - knihy
        Key_CrmEdi_F  // Správa zákazníckych poiadaviek - modul
        Key_CrbEdi_F  // Správa zákazníckych poiadaviek - knihy
        Key_TibEdi_F  // Terminálové príjemky
        Key_TobEdi_F  // Terminálové vıdajky
        Key_SvbEdi_F  // Faktury ZP
        Key_SabEdi_F  // Sprava pokladne
        Key_PsbEdi_F  // Planovanie
        Key_ScbEdi_F  // Servisné zákazky
        Key_PobEdi_F  // Pozièné vıdajky
        Key_AlbEdi_F  // Prenájom náradia
        Key_KsbEdi_F  // Komisionalne vyuctovanie
        Key_VtrEdi_F  // Evidencia DPH

Dbs_F - Údrba databázovıch súborov
        Sys_FldSum_F  // Sumarizovanie polí databáz
        Sys_FldCopy_F // Kopírovanie polí databáz

Wdc_F - Denná uzávierka prevádzky
        // Ukoly
        Stk_StcVer_F  // Kontrola skladovıch kariet
        Stk_DocVer_F  // Porovnavanie dokladov s pohybmi
        Cab_SalProc_F // Spracovanie pokladnicneho predaja

Psw_F - Zmena prístupového hesla

Ver_F - Kontrolné funkcie
        // Nastroje
        Ver_GscBac_F  // Porovnávanie tovarového èísla

Inf_F - Popis zmien v systéme NEX
Log_F - Zoznam LOG suborov NEX
Evb_F - Správa pripomienok
        // Upravy
        EvbItm_F      // Editor Pripomienky


// Èíselníky
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

