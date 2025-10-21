unit NexError;

interface

type
  TAskCom=record // Dotazy vseobecneho typu
    YourCanDelDoc:longint; // Naozaj chcete vymazat vybrany doklad ?
    YourCanDelItm:longint; // Naozaj chcete vymazat vybranu polozku ?
    YourCanDelRec:longint; // Naozaj chcete vymazat vybrany zaznam ?
    YourCanDelBok:longint; // Naozaj chcete vymazat vybranu knihu ?
    YourCanLocDoc:longint; // Naozaj chcete uzamknut vybrany doklad ?
    YourCanUnlDoc:longint; // Naozaj chcete odomknut vybrany doklad ?
    YourCanClcDoc:longint; // Naozaj chcete prepocitat vybrany doklad ?
    YourCanClsDoc:longint; // Chcete uzatvoriù doklad ?
    YourCanDelNotDlvOci:longint; // Naozaj chcete stornovaù nedodanÈ mnoûstvo s% ?
    YourCanDelOcr:longint; // Naozaj chcete zruöiù rezerv·ciu vybranej poloûky ?
  end;
  TErrCom=record // Hlasenia vseobecneho typu
    ThisDocIsLoc:longint; // Vybrany doklad uz je uzamknuty !
    ThisDocIsUnl:longint; // Vybrany doklad este nie je uzamknuty !
    DocIsNoExist:longint; // Neexistujuci doklad !
    ThisFncIsDis:longint; // Nem·te pridelenÈ prÌstupovÈ pr·vo pouûiù t˙to funkciu !
    IcdIsCreated:longint; // Z daneho dokladu uz bola vystavena odberatelska faktura !
    BokIsNoExist:longint; // Neexistujuca kniha !
    BokIsNoAcces:longint; // Uzivatel k danej knihe nema pristup !
    MovIsNoExist:longint; // Neexistujuci pohyb !
    StkIsNoExist:longint; // Neexistujuci sklad !
    WriIsNoExist:longint; // Neexistujuca prevadzka !
    CntIsNoExist:longint; // Neexistujuce stredisko !
    PlsIsNoExist:longint; // Neexistujuci predajny cennik !
    AplIsNoExist:longint; // Neexistujuci akciovy cennik !
    GscIsNoExist:longint; // Neexistujuce tovarove cislo !
    MgcIsNoExist:longint; // Neexistujuca tovarova skupina !
    FgcIsNoExist:longint; // Neexistujuca financna skupina !
    DocNoHaveItm:longint; // Vybran˝ doklad nem· poloûky !
    UsrMaxDscSet:longint; // Maxim·lna zæava, ktor˙ moûete poskytn˙ù z·kaznikovi je xx %.
    UsrIsNoExist:longint; // Neexistujuci uzivatel systemu !
    PacNotSelect:longint; // Firma nie je zadana !
    UpdVerNotCor:longint; // Nespr·vna veriza aktualiz·cie !
    UpdNotFinish:longint; // Aktualiz·cia nebola korrektne ukonËen· !
    InsuffUsrLev:longint; // Nedostatocna uroven pristupu na vykonanie danej oper8cie !
    PmdMarkIsEmp:longint; // Nezadany modul !
    SgcIsNoExist:longint; // Neexistujuca specifikaËn· skupina !
    GsExistInDoc:longint; // Zadan˝ tovar uû existuje na danom doklade !
    WebDatComErr:longint; // Chyba pri Webovej komunik·cii !
    GsExistInLst:longint; // Zadan˝ tovar uû existuje v danom zozname
    OxiIsFullDlv:longint; // Vybran˙ poloûku nie je moûnÈ zruöiù ani stornovaù, pretoûe je kompletne dodan· !
  end;
  TErrTcb=record // Hlasenia pre odberatelske dodacie listy
    DocMovIcdExist:longint;   // Dan˝ dodacÌ list nie je moûnÈ presun˙ù do inej knihy, lebo uû je vyfakturovan˝
    PaCodeIsDiferent:longint; // Zadany doklad je vystaveny pre ineho odberatela
    RbaCodeIsEmpty:longint;   // Nie je zadana vyrobna sarza
    RbaCodeNotEnough:longint; // Nie je dostatok tovaru z danej sarze na sklade
    ThisIsOtherGsc:longint;   // Zadali ste in˝ tovar, neû ktor˝ ma byù naËÌtan˝ do danÈho balenia.
    PdnIsNotExist:longint;    // Neexistuj˙ce v˝robnÈ ËÌslo
    PdnIsNotOutInDoc:longint; // ZadanÈ v˝robnÈ ËÌslo uû bolo vydanÈ na doklade xxx
    PdnIsNotSet:longint;      // Nie je zadanÈ v˝robnÈ ËÌslo.
  end;
  TErrCas=record // Hlasenia pre elektronicke registracne pokladne
    TooManyCadItm:longint;      // Bola prekroceny maximalny pocet poloziek pokladnicnej uctenky
    GsQntIsNotDivSet:longint;   // Nespravne mnozstvo - nesuhlasi so zadanou delitelnostou
    UseAdvOverDocVal:longint;   // Cerpanie zalohy nemoze byt v celej hodnote dokladu
    FiskalInitError:longint;    // Chyba pri inicializ·cie fiök·lnej tlaËiarne
    WghDocValueIs:longint;      // Hodnota naËÌtanÈho dokladu z v·hy je: ...
    FmsIsNotAccess:longint;     // Fisk·lny server je nedostupn˝
    FmsVatPrcSetErr:longint;    // Hladina DPH 5 vo fiök·lnej tlaËiarni nie je nastaven· na 99.
    CshPayValTooBig:longint;    // Hotovostn· platba je prÌliö vysok· (max. 1000,- Ä)
    CrdPayValTooBig:longint;    // Platba kartou je prÌliö vysok· (max. 1600,- Ä)
  end;
  TErrAlb=record // Hlasenia pre prenajom naradia
    RenGscIsNotExist:longint;   // Nespravne zadane PLU na sluzbu prenajmu naradia
    RdiGscIsNotExist:longint;   // Nespravne zadane PLU na sluzbu cistenie naradia
    RduGscIsNotExist:longint;   // Nespravne zadane PLU na sluzbu opravu naradia
    SetQntIsInvalid:longint;    // Nespravne zadane mnozstva protokolu vratenia naradia
    CsbNumIsNotExist:longint;   // Nespravna kniha hotovostnej pokladne
    TcbNumIsNotExist:longint;   // Nespravna kniha odberatelskych dodacich listov
    IcbNumIsNotExist:longint;   // Nespravna kniha oderatelskych faktur
    AmdAodGenIsExist:longint;   // Z cenovej ponuky uz bola vygenerovan· z·kazka
    AodAldGenIsExist:longint;   // Zo z·kazky uz bol vygenerovan˝ doklad z·poûiËky
    CsdIncGenIsExist:longint;   // Na danu zapozicku uz bola prijata kaucia
    CsdExpGenIsExist:longint;   // Z danej zapozicky uz bola vratena kaucia
    CsdIncGenNoExist:longint;   // Nie je mozne vratit kauciu nakolko este nebola prijata
    CasNumIsNotExist:longint;   // Nie je zadane csilo pokladne
  end;
  TErrScb=record // Hlasenia pre servisne zakazky
    BegRepIsNotPut:longint;     // Eöte nebolo zadanÈ zah·jenie servisn˝ch pr·c.
    JudGrtTypeNotZ:longint;     // Posudit reklamacu je mozne len vtedy ak zakaznik ziada zarucny servis
    IcdIsExist:longint;         // Na danu servisnu zakazku ez je vystaveny dobropis
    ScdIsClosed:longint;        // Servisnu zakazku nie je mozne modifikovat pretoze je uz ukoncena
    ScgIsReturned:longint;      // Zariadenie z tejto zakazky uz bolo vratene zakaznikovi
    NoClsScgIsNotRet:longint;   // Nie je moûnÈ ukonËiù servisn˝ prÌpad, pokiaæ tovar nebol vr·ten˝ z·kaznÌkovy.
    NoClsScgIsNotSol:longint;   // Nie je moûnÈ ukonËiù servisn˝ prÌpad, pokiaæ nie je zadane jeho riesenie.
    StqIsNotEnough:longint;     // Danu operaciu nie je mozne vykonat nakolko nie je dostatok tovaru na sklade
    ScdMustJudBefSol:longint;   // Servisn˙ z·kazku je potrebnÈ pos˙diù pred rieöenÌm.
    OprNotCorSolType:longint;   // Dan· oper·cia nie je v s˙lade s rieöenÌm servisnÈho prÌpadu.
  end;
  TErrIpb=record // Hlasenia pre evienciu doslej posty
    DocNoHaveIptItm:longint;    // Doklad nie je mozne zrusit nakolko obsahuje polozky - ukoly
  end;
  TErrJob=record // Hlasenia pre spravu pracovnych ukolov
    LogUsrIsNotInEpc:longint;    // Pracovny prikaz nie je mozne zalozit nakolko nie ste zaevidovany do zaznamu zamestnancov.
  end;

const
  msgDirCanDisCrd=2201001;  // Naozaj chcete vyradiù vybran˙ kartu kontaktu z uûÌvania?
  msgDirNotOwnUsr=2201002;  // T˙to oper·ciu mÙûe vykonaù len spr·vca kontaktnej karty.


  cFMErrLst:array [1..101]of String=(
 '','','','','','','','','','','','','','','','','','','','','','','','','','','','','','',''
,'nespr·vny poËet poloûiek v prÌkaze'
,'nespr·vny poËet znakov v niektorej poloûke prÌkazu'
,'nezn·me platidlo'
,'cena Celkom je nespr·vna, hl·si ak je zapnut˝ GP pre kontrolu Medzis˙Ëtu (GP1=1)'
,'cena Celkom nie je v minim·lnom platidle'
,'v poloûk·ch platby nie s˙ ûiadne znaky'
,'v poloûke Pon˙knut· suma alebo Cena celkom je chyba'
,'v poloûke Kurz je chyba'
,'v poloûke Popis s˙ nepovolenÈ znaky'
,''
,'preplatenie platidlom nie je povolenÈ'
,'','','','',''
,'odpojen· tlaËiareÚ /preruöen˝ loop na doske FM/'
,'nespr·vne heslo v prÌkaze vyûaduj˙com heslo'
,'odmietnutie op‰tovnej fiskaliz·cie /FM uû je zfiskalizovan˝'
,'odmietnutie Ôalöieho otvorenia dÚa do 24:00h po vykonanej z·vierke'
,'nezn·my, alebo nepovolen˝ prÌkaz v danom stave FM'
,'ne˙speön· fiskaliz·cia, lebo FP nie je vloûen· alebo nie je Ëist·'
,'','','','','','','','','',''
,'znak EOT v prÌkaze nepriöiel do 3 s. od zaËiatku prenosu'
,'chybnÈ BCC v prÌkaze od PC'
,'nespr·vny form·t d·tumu, Ëasu'
,'chyba ËÌslovania riadkov v prÌkazoch'
,'',''
,'nastavovan˝ d·tum do RTC je menöÌ ako d·tum poslednej DU z FP ak DU existuje a ak FM je zfiskalizovan˝'
,'','','','','','','','',''
,'nevloûen· FP'
,'cudzia FP /inÈ SN a DKP/'
,'FP s dosiahnut˝mi limitmi'
,'Ëist· FP /FP bez z·pisov/'
,'nezasunut· mSD karta pre kontroln˝ z·znam (ELJ)'
,'cudzia mSD karta /inÈ SN a DKP/'
,'odpojen˝ displej'
,'chybn˝ z·pis do mSD karty'
,'chybn˝ z·pis do FP'
,'SD karta je zapÌsan· do max. kapacity'
,'','','','','',''
,'chyba parametra v prÌkaze'
,'odmietnutie prÌkazu otvorenia ˙Ëtenky z dÙvodu prechodu 24:00h bez z·vierky'
,'odmietnutie inÈho prÌkazu ako potvrdenie o servisnej prehliadke a Get variable'
,'odmietnutie inÈho prÌkazu ako potvrdenie o zostatkoch DU vo FP a Get variable'
,'odmietnutie prÌkazu zmeÚ heslo z dÙvodu, ûe HW prepÌnaË je v polohe nedovoæuj˙cej meniù heslo tzn. v tejto polohe platÌ default heslo.'
,'nepovolenÈ pouûitie DU. V danom dni je otvoren· druh· smena');

  aCom:TAskCom=(
    YourCanDelDoc:100901;
    YourCanDelItm:100902;
    YourCanDelRec:100903;
    YourCanDelBok:100904;
    YourCanLocDoc:100905;
    YourCanUnlDoc:100906;
    YourCanClcDoc:100907;
    YourCanClsDoc:100908;
    YourCanDelNotDlvOci:100909;
    YourCanDelOcr:100910;
  );
(* Hlasenia ktore nie su zaradene do noveho systemu
  acSysYourCanOutAllTcd=100104;    // Naozaj chcete vyskladnit nevydane polozky vsetkych dokladov z otvorenej knihy ?
  acSysYourCanAddDuplic=100105;    // Zadany tovar uz existuje na tomto doklade. Chcete aj napriek tomu pridat tuto polozku na doklad ?
  acSysYourCanAccBook=100106;      // Naozaj chcete rozuctovat vsetky doklady danej knihy ?
  acSysYourCanSaveChange=100109;   // Zmenili ste udaje formulara. chcete tie zmeny ulozit pred opustenim editora ?
  acSysYourCanDeleteAcc=100110;    // Naozaj chcete zrusit rozuctovanie vybraneho dokladu ?
  acSysGscIsExistInThisDoc=100117; // Zadany tovar uz existuje na danom doklade. Chcete pridat ... ?

*)
  eCom:TErrCom=(
    ThisDocIsLoc:100901;
    ThisDocIsUnl:100902;
    DocIsNoExist:100903;
    ThisFncIsDis:100904;
    IcdIsCreated:100905;
    BokIsNoExist:100906;
    BokIsNoAcces:100907;
    MovIsNoExist:100908;
    StkIsNoExist:100909;
    WriIsNoExist:100910;
    CntIsNoExist:100911;
    PlsIsNoExist:100912;
    AplIsNoExist:100913;
    GscIsNoExist:100914;
    MgcIsNoExist:100915;
    FgcIsNoExist:100916;
    DocNoHaveItm:100917;
    UsrMaxDscSet:100918;
    UsrIsNoExist:100919;
    PacNotSelect:100920;
    UpdVerNotCor:100921;
    UpdNotFinish:100922;
    InsuffUsrLev:100923;
    PmdMarkIsEmp:100924;
    SgcIsNoExist:100925;
    GsExistInDoc:100926;
    WebDatComErr:100927;
    GsExistInLst:100928;
    OxiIsFullDlv:100929
  );
  eTcb:TErrTcb=(
    DocMovIcdExist:120209;
    PaCodeIsDiferent:120210;
    RbaCodeIsEmpty:120211;
    RbaCodeNotEnough:120212;
    ThisIsOtherGsc:120213;
    PdnIsNotExist:120214;
    PdnIsNotOutInDoc:120215;
    PdnIsNotSet:120216;
  );
  eCas:TErrCas=(
    TooManyCadItm:130522;
    GsQntIsNotDivSet:130523;
    UseAdvOverDocVal:130524;
    FiskalInitError:130525;
    WghDocValueIs:130526;
    FmsIsNotAccess:130527;
    FmsVatPrcSetErr:130528;
    CshPayValTooBig:130529;
    CrdPayValTooBig:130530;
  );
  eAlb:TErrAlb=(
    RenGscIsNotExist:114001;
    RdiGscIsNotExist:114002;
    RduGscIsNotExist:114003;
    SetQntIsInvalid:114004;
    CsbNumIsNotExist:114005;
    TcbNumIsNotExist:114006;
    IcbNumIsNotExist:114007;
    AmdAodGenIsExist:114008;
    AodAldGenIsExist:114009;
    CsdIncGenIsExist:114010;
    CsdExpGenIsExist:114011;
    CsdIncGenNoExist:114012;
    CasNumIsNotExist:114013;
  );
  eScb:TErrScb=(
    BegRepIsNotPut:120501;
    JudGrtTypeNotZ:120502;
    IcdIsExist:120503;
    ScdIsClosed:120504;
    ScgIsReturned:120505;
    NoClsScgIsNotRet:120506;
    NoClsScgIsNotSol:120507;
    StqIsNotEnough:120508;
    ScdMustJudBefSol:120509;
    OprNotCorSolType:120510;
  );
  eIpb:TErrIpb=(
    DocNoHaveIptItm:220201;
  );
  eJob:TErrJob=(
    LogUsrIsNotInEpc:220401;
  );

  // SYS - Systemove prostriedky
  acSysYourCanAbortThisProc=100001; // Naozaj chcete ukoncit danu operaciu
  acSysYourCanReCalcDocHead=100002; // Naozaj chcete prepocitat hlavicku dokladu podla jeho poloziek
  acSysYourCanExitProgram=100003;   // Naozaj chcete opustit programovy modul ... ?
  acSysYourCanAddNulBPrice=100004;  // Pokusili ste predat tovar za nulovu cenu. Naozaj chcete ulozit polozku na doklad s nulovou predajnou cenou ?
  acSysYourCanCreateTable=100005;   // Naozaj chcete vytvorit novy databazovy subor ?
  acSysYourCanRunWdcProces=100006;  // Naozaj chcete vykona dennu uz8vierku prevadzky ?

  ecSysUsrNotInsertRight=100001;   //* Nem·te pridelenÈ prÌstupovÈ pr·vo prid·vaù novÈ ˙daje do danej knihy.
  ecSysUsrNotDeleteRight=100002;   //* Nem·te pridelenÈ prÌstupovÈ pr·vo zruöiù ˙daje z danej knihy.
  ecSysUsrNotModifyRight=100003;   //* Nem·te pridelenÈ prÌstupovÈ pr·vo modifikovaù ˙daje danej knihy.
  ecSysUsrNotPrintRight=100004;    //* Nem·te pridelenÈ prÌstupovÈ pr·vo tlaËiù v˝stupnÈ zostavy z danej knihy.
  ecSysUsrNotEnableRight=100005;   //* Nem·te pridelenÈ prÌstupovÈ pr·vo pouzivat danu knihu
  ecSysUsrNotPropertyRight=100006; //* Nem·te pridelenÈ prÌstupovÈ pr·vo nastavit vlastnoti danej knihy
  ecSysUsrNotDocLockRight=100007;  //
  ecSysUsrNotOwnOpenRight=100008;  //
  ecSysUsrNotAllOpenRight=100009;  //
  ecSysNoDelFromEmptyLst=100010;   // DAny zoznam je prazdny z prazdneho zoznamu nie je mozne zrusit udaje
  ecSysAccAnlIsNotExist=100011;    // Zadany  ucet neexistuje v uctovnej osonove analytickych uctov
  ecSysAbkNotDefForActUsr=100017;  // Pre prihlaseneho uzivatela nie je definovana ziadna kniha
  ecSysUsrOldPswErr=100018;        // Nspravne zadane stare heslo
  ecSysUsrNewPswErr=100019;        // Nove heslo a kontrolny zapis nie su zhodne
  ecSysAccDatePrvYear=100020;      // Uctovny datum nepatri do aktualneho roka

  // SYS - Globalne hlasenia
  acSysYourCanDeleteItm=100101;    // Naozaj chcete zrusit vybranu polozku ?
  acSysYourCanLockDoc=100102;      // Naozaj chcete uzamknut vybrany doklad ?
  acSysYourCanUnLockDoc=100103;    // Naozaj chcete odoamknut vybrany doklad ?
  acSysYourCanOutAllTcd=100104;    // Naozaj chcete vyskladnit nevydane polozky vsetkych dokladov z otvorenej knihy ?
  acSysYourCanAddDuplic=100105;    // Zadany tovar uz existuje na tomto doklade. Chcete aj napriek tomu pridat tuto polozku na doklad ?
  acSysYourCanAccBook=100106;      // Naozaj chcete rozuctovat vsetky doklady danej knihy ?
  acSysYourCanDelBook=100107;      // Naozaj chcete zrusit vybranu knihu ... ?
  acSysYourCanDelSlctDoc=100108;   // Naozaj chcete zrusit vybrany doklad ?
  acSysYourCanSaveChange=100109;   // Zmenili ste udaje formulara. chcete tie zmeny ulozit pred opustenim editora ?
  acSysYourCanDeleteAcc=100110;    // Naozaj chcete zrusit rozuctovanie vybraneho dokladu ?
  acSysChgYearCrtNewDoc=100111;    // Datum dokladu sa vztahuje na iny rok nez povodne cislo dokladu, chcete vytvorit doklad so zmenenym rokom ?
  acSysGscIsExistInThisDoc=100117; // Zadany tovar uz existuje na danom doklade. Chcete pridat ... ?

  ecSysNoModDocIsLocked=100101;    // Vybran˝ doklad nie je moûnÈ modifikovaù, pretoûe bol uzamknuty.
  ecSysTxtFileIsNotExist=100102;   // Neexistujuci textovy subor
  ecSysDocIsUseAnyUser=100103;     // Doklad pouziva iny uzivatel
  ecSysDscIsTooSmall=100104;       // Zlava nemoze mat negativnu hodnotu
  ecSysDscIsTooLarge=100105;       // Zadana zlava je prilis velka. Maximalna hodnota zlavy je 100 %
  ecSysGsQntIsNulValue=100106;     // Nezadali ste mnozstvo tovaru.
  ecSysKeyViolationFound=100107;   // Bol zaznamenany duplicitny zaznam.
  ecSysThisDocIsLocked=100108;     // Vybrany doklad ne je mozne uzamknut, pretoze uz je uzamknuty.
  ecSysThisDocIsNotLocked=100109;  // Vybrany doklad nie je mozne odomknut, pretoze nie je uzamknuty.
  ecSysThisItmPointToConDoc=100110;// Dana polozka sa odkazuje na iny doklad.
  ecSysThisDocIsReserved=100111;   // Dany doklad je rezervovany pre uzivayela ...
  ecSysActPosNotFind=100112;       // Nebola najdena fyzicka pozicia zaznamu v databaze ...
  ecSysIsCanNotDelBook=100113;     // Vybranu knihu nie je mozne zrusit, pretoze obsahuje doklady.
  ecSysThisIsNotActBook=100114;    // Nachadzate sa v knihe ktora obsahuje doklady z minulych rokov. Ak chcete pridaù do tejto knihy novy doklad je potrebne prihlasit sa pod uzivatelom s administr·torskumi pristupovymi pravami.
  ecSysBookNumIsNotProvided=100115;// Cislo knihy nebolo zadane
  ecSysBookIsNotExist=100116;      // Zadana kniha neexistuje
  ecSysGscIsExistInThisDoc=100117; // Zadany tovar uz existuje na danom doklade
  ecSysThisDateInClsPeriod=100118; // Zadanu operaciu nie je mozne vykonat, datumovo dany doklad je zaradeny do uzatvoreneho obdobia
  ecSysFileIsNotExist=100119;      // Neexistujuci subor
  ecSysDeviceIsNotInReg=100120;    // Periferne zariadenie ... nie je zaregistrovany na tomto pocitaci.
  ecSysInvalidDvzName=100121;      // Chybny nazov zahranicnej meny
  ecSysThisCourseIsNul=100122;     // Kurz zahranicnej meny ... je nula
  ecSysThisDateNotCourse=100123;   // Na datum ... nie su zadane kurzy v krzovom listku
  ecOutFileIsSavedInPath=100124;   // Vystupny subor je ulozeny do adresara ...
  ecSysProfitIsGrMinPrf=100125;    // Prekrocenie minimalneho obchodneho rozpatia
  ecSysNulPriceInThisDoc=100126;   // Dany doklad obsahuje polozku s nuloviu predajnou cenou
  ecSysInCatIsNotThisCode=100127;  // Dany ciselnik neobsahuje zadany kod
  ecSysNotItemSelected=100128;     // Neoznacili ste ziadnu polozku.
  ecSysNotBookDefined=100129;      // Nie je definovana ziadna kniha
  ecSysNulGscNulCVal=100130;       // Na danom doklade su polozky s nulovym PLU a nulovou nakupnou cenou
  ecSysNulGscOccur=100131;         // Na danom doklade su polozky s nulovym PLU
  ecSysNulCValOccur=100132;        // Na danom doklade su polozky s nulovou nakupnou cenou
  ecSysThisDocInVatCls=100133;     // Doklad je v uzavierke DPH
  ecSysFileIsWriteDeny=100134;     // Nie je mozne otvorit subor na zapisovanie

  // USR - Evidencia uzivatelov
  acUsrYourCanDeleteUsr=100201;    // Naozaj chcete zrusit vybraneho uzivatela ?
  acUsrYourCanDisableUsr=100202;   // Naozaj chcete vyradit vybraneho uzivatela z uzivania systemu ?
  acUsrYourCanEnableUsr=100203;    // Naozaj chcete zaradit vybraneho uzivatela do uzivania systemu ?

  ecUsrThisUsrIsDisabled=100201;   // Vybraneho uzivatela nie je mozne vyradit pretoze uz bo vyradeny.
  ecUsrThisUsrIsEnabled=100202;    // Vybraneho uzivatela nie je mozne zaradit pretoze je zaradeny.
  ecUsrOldPswIsNotCorrect=100203;  // Zadali ste nespravne stare heslo.
  ecUsrVerPswIsNotCorrect=100204;  // Kontrolny zapis hesla nei je zhodny s novym heslom.

  // USD - Definicia uzivatelskych prav
  acUsdYourCanDelSlctApm=100301;   // Naozaj chceet danemu uzivatelovi odopriet pristup k modulu
  acUsdYourCanDelSlctAbk=100302;   // Naozaj chceet danemu uzivatelovi odopriet pristup ku knihe

  // UPG - Aktualizacia systemu
  acUpgYourCanDeleteUpg=100401;     // Naozaj chcete zrusit vybranu aktualizaciu ?

  ecUpgNotContinualUpdate=100401;   // Tato aktualizacia nenadvazuje sa na verziu Vasho systemu. Predtym nez spustite tuto aktualizaciu naprv musite aktualizovat Vas system na verziu ...

  // KEY -
  acUsdYourCanDelSlctBook=100501;   // Naozaj chceet zrusit vybran[ knihu

  // FTP - Komunikacia stredisk
  ecFtpBadFieldName=100601;        // Chybne pole prenosoveho suboru
  ecFtpZipFileIsDamaged=100602;    // ZIP subor je poskodeny.
  ecFtpComDrvNotExist=100603;      // Neexistujuca diskova jednotka

  // GSC - Skladove karty zasob
//  acGscYourCanDeleteGs=110501;     //* Naozaj chcete zrusit vybranu evidenËn˙ kartu tovaru ?
  acGscYourCanDisableGs=110502;    //* Naozaj chcete vyradit vybranu evidenËn˙ kartu tovaru ?
  acGscYourCanEnableGs=110503;     //* Naozaj chcete zaradit vybranu evidenËn˙ kartu tovaru ?
  acGscYourCanDeleteMg=110504;     //* Naozaj chcete zrusit vybranu tovaruvu skupinu ?
  acGscYourCanMsuSave=110505;      //* Zadana merna jednotka neexistuje. Chcete ju zaevidovat ?
  acGscBarCodeIsExist=110506;      //* Zadany identifikacny kod je uz priradeny k inemu tovaru, Chcete zobrazit udaje daneho tovaru ?
  acGscStkCodeIsExist=110507;      //* Zadany skladovy kod je uz priradeny k inemu tovaru, Chcete zobrazit udaje daneho tovaru ?
  acGscYourCanDeleteBc=110508;     //* Naozaj chcete zrusit vybrany sekund·rny identifikacny kod tovaru ?
  acGscYourCanDeleteNusLst=110509; //* Naozaj chcete zruöiù vöetky nepouûitÈ poloûky z b·zovej evidencii tovaru ?
  acGscYourCanDeleteNusItm=110510; //* Naozaj chcete zruöiù vybranu nepouûitÈ poloûky z b·zovej evidencii tovaru ?
  acGscYourCanUnDeleteGs=110511;   //* Naozaj chcete vratit zrusenu polozku do bazovej evidencii tovaru
  acGscYourCanDeleteFg=110512;     //* Naozaj chcete zrusit vybranu financnu skupinu ?
  acGscYourCanDeleteSg=110513;     //* Naozaj chcete zrusit vybranu öpecifikaËn˙ skupinu ?

  ecGscThisIsEqualMg=110501;       //* Chybne zadany udaje. Zadali ste tu istu skupinu, ktoru chcete vymazat.
  ecGscThisGsIsDisabled=110502;    //* Vybrana tovarova polozka je uz vyradena z evidencii.
  ecGscThisGsIsEnabled=110503;     //* Vybrana tovarova polozka je uz zaradena do evidencie.
//  ecGscThisGsIsUsed=110504;        //* Vybranu tovarovu plozku ne je mozne zrusit, pretoze na sklade s% uz bol vykonany pohyb na dany tovar.
  ecGscBarCodeIsExist=110505;      //* Zadany ciarovy kod uz je priradeny k tovarovej polozke PLU=s%
  ecGscThisGsIsReserved=110506;    //* Dane poradove cislo tovaru uz zarezervoavl uzivate s%
  ecGscThisIsEqualFg=110507;       //* Chybne zadany udaje. Zadali ste tu istu skupinu, ktoru chcete vymazat.
  ecGscInvalidVatPrc=110508;       // Chybna sadzba DPH. Bola zadana neplatna sadzba DPH.
  ecGscIsNotExistInGsc=110509;     // Tovarova polozka ... neexistuje v evidencii tovaru.
  ecGscFgDscIsTooLarge=110510;     // Zadana zlava je mimo doporuceneho intevalu
  ecGscGsCodeIsExist=110511;       // Zadane PLU ...  neexistuje
  ecGscGsCodeIsNotEnable=110512;   // Tovarove cislo nie je z povoleneho intervalu
  ecGscThisGscIsDisabled=110513;   // Dany tovar je vyradeny z evidencie
  ecGscLinPacIsNul=110514;         // Kod dodavatela nie je zadany
  ecGscLinPriceIsNul=110515;       // Nakupna cena nie je zadana
  ecGscOsCodeIsExist=110516;       // Zadan˝ objedn·vkov˝ kÛd uû je priraden˝ k tovarovej poloûke PLU=s%
  ecGscStCodeIsExist=110517;       // Zadan˝ skladov˝ kÛd uû je priraden˝ k tovarovej poloûke PLU=s%
  ecGscSpCodeIsExist=110518;       // Zadan˝ öpecifikaËn˝ kÛd uû je priraden˝ k tovarovej poloûke PLU=s%

  // PAB - Evidencia partnerov
  acPabYourCanDeletePa=110601;  // Naozaj chcete zrusit vybranu firmu
  acPabYourCanDisablePa=110602; // Naozaj chcete vyradit vybranu firmu
  acPabYourCanEnablePa=110603;  // Naozaj chcete zaradit vybranu firmu

  ecPabNotEnoughSalLim=110601;  //* Nedostatok nakupneho limitu
  ecPabPaCodeIsNotExist=110602; //* Kod partnera c. s% neexistuje v evidencii partnerov
  ecPabPaCodeNotEnable=110603;  //* Nemozete zaevidovat alebo opravovat udaje partnera, pretoze poradove cislo partnera nespada do intervalu, ktore bolo vam pridelen.
  ecPabPaInoIsExist=110604;     // Pod zadane ICO uz bola zaevidovana firma
  ecPabWpaCodeIsExist=110605;   // Zadana prevadzka neexistuje.
  ecPabCtyCodeIsExist=110606;   // Zadany kod mesta neexistuje.
  ecPabStaCodeIsExist=110607;   // Zadany kod statu neexistuje.

  // SML - Evidencia skladovych pohybov
  ecSmlYourCanDeleteSm=110801;  // Naozaj chcete zrusit vybrany skladovy pohyb

  // MCB - Odberatelske cenove ponuky
  acMcbYourCanDeleteMcb=210201;  //* Naozaj chcete zrusit vybranu knihu doberatelskych cenovuch ponuk ?
  acMcbYourCanDeleteMcd=210202;  //* Naozaj chcete zrusit vybranu odberatelsku cenovu ponuku ?
  acMcbYourCanDeleteMci=210203;  //* Naozaj chcete zrusit vybranu polozku cenovej ponuky ?
  acMcbYourCanLockMcd=210204;    //* Naozaj chcete uazmkut vybranu cenovu ponuku ?
  acMcbYourCanUnlockMcd=210205;  //* Naozaj chcete odblokovat vybranu cenovu ponuku ?

  ecMcbThisMcdIsLocked=210201;      //* Vybrana odberatelska cenova ponuka je uz uzamknuta
  ecMcbThisMcdIsNotLocked=210202;   //* Vybrana cenova ponuka nie je uzamknuta
  ecMcbPutExpReasText=210203;    // Zadajte dovod predlzenia cenovej ponuky

  // PSB - Plany dodavatelskych objednavok
  acPsbYourCanDeletePsb=180101;   // Naozaj chcete zrusit vybranu knihu objednavkovych planov ?
  acPsbYourCanDeletePsd=180102;   // Naozaj chcete zrusit vybrany objednavkovy plan ?
  acPsbYourCanDeletePsi=180103;   // Naozaj chcete zrusit vybranu polozku objednavkoveho planu ?
  acPsbYourCanLockPsd=180104;     // Naozaj chcete uazmkut vybrany objednavkovy plan ?
  acPsbYourCanUnlockPsd=180105;   // Naozaj chcete odomknut vybrany objednavkovy plan ?

  ecPsbThisPsdIsLocked=180101;    // Vybrany plan dodavatelskej objednavky uz je uzamknuta
  ecPsbThisPsdIsNotLocked=180102; // Vybrany plan dodavatelskej objednavky nie je uzamknuta
  ecPsbIsCanNotDeletePsb=180104;  // Vybranu knihu planov dodavatelskych objednavok nie je mozne zrusit, pretoze osahuje doklady

  // OSB - Odberatelske objednavky
  acOsbYourCanDeleteOsb=111501;   // Naozaj chcete zrusit vybranu knihu dodavatelskych objednavok ?
  acOsbYourCanDeleteOsd=111502;   // Naozaj chcete zrusit vybranu dodavatelsku objednavku ?
  acOsbYourCanDeleteOsi=111503;   // Naozaj chcete zrusit vybranu polozku objednavky ?
  acOsbYourCanLockOsd=111504;     // Naozaj chcete uazmkut vybranu objednavku ?
  acOsbYourCanUnlockOsd=111505;   // Naozaj chcete odomknut vybranu objednavku ?
//  acOsbYourCanAddDuplic=111506;   // Zadany tovar uz existuje na tejto objednavke. Chcete aj napriek tomu pridat tuto polozku na doklad ?
  acOsbSlctOsiIsPaired=111507;    // Zadana polozka dodavatelskej objednavky u je vyparovana s dodacim listom .... Chcete aj naprik tomu zrusit danu polozku ?
  acOsbThisIsNotDlvQnt=111508;    // Naozaj chcete zrusit nedodane mnozstvo vybranej polozky ?
  acOsbInsFreItmToGsCat=111509;    // Naozaj chcete zaevidovat polozku do evidencie tovaru ?

  ecOsbThisOsdIsLocked=111501;    // Vybrana objednavka uz je uzamknuta
  ecOsbThisOsdIsNotLocked=111502; // Vybrana objednavka nie je uzamknuta
  // 111503
  ecOsbIsCanNotDeleteOsb=111504;  // Vybranu knihu dodavatelskych objednavok nie je mozne zrusit, pretoze osahuje doklady
  ecOsbBookIsNotExist=111505;     // Zadana kniha dodavatelskych objednavok neexistuje
  ecOsbGsQntLessMinOsq=111510;     // Zadali ste menej neû minim·lne objedn·vacie mnoûstvo

  // PCB - Odberatelske fakture
  ecPcbBookIsNotExist=120404;     //* Kniha odberatelskych zalohovych faktur pod cilom %s neexistuje v zozname zalohovych faktur.

  // CAB - Knihy registra4nych pokladnic
  acCabYourCanDeleteIcb=130101;   //* Naozaj chcete zrusit vybranu knihu doberatelskych faktur ?

  ecCabInvalidSalProcDate=130101; // Nespravny datumovy interval spracovania udajov pokladnicneho predaja
  ecCabInvalidCasNum=130102;      // Nespravny interval cisiel registracnych pokladni.

  // STK - Skladove karty zasob
  acStkYourCanDeleteStc=110901;  //* Naozaj chcete zrusit vybranu skladovu kartu ?
  acStkYourCanDisableStc=110902; //* Naozaj chcete vyradit skladovu kartu z uzivania ? Z vyradenej karty mozete vydat ale prijimat nie
  acStkYourCanEnableStc=110903;  //* Naozaj chcete zaradit skladovu kartu do uzivania ?
  acStkYourCanDeleteSm=110904;   //* Naozaj chcete vybrany skladovy pohyb ? (skladovu operaciu)
  acStkYourCanGenFif=110905;     //* Naozaj chcete znovu vygenerovat FIFO karty vybraneho tovaru ?
  acStkYourCanDeletePdn=110906;  // Naozaj chcete zrusit vybrane vyrobne cislo ?
  acStkYourCanDeleteSts=110907;  //* Naozaj chcete zrusit vybranu rezervaciu na predaj ?

  ecStkCardIsNotDeleted=110901;   // Skladov˙ kartu nie je moûnÈ zruöiù. Zruöiù mÙûete len tie skladovÈ karty, na ktorÈ eöte nebol vykonan˝ ûiadny prÌjem.
  ecStkBarCodeIsNotExist=110902;  // Pod zadan˝m Ëiarov˝m kÛdom neexistuje ûiadna tovarov· poloûka.
  ecStkAPriceSmlCPrice=110903;    // Predajna cena tovru bez DPH je uz pod nakupnou cenou.
  ecStkPdnQntIsNotCorrect=110904; // Pocet zadanych vyrobnych cisiel nezodpoveda mnozstvu vydaneho tovaru
  ecStkThisGsIsNotInStk=110905;   // Zadane mnozstvo nie je mozne vydat, pretoze na skladovej karte nie je dostatok tovaru.
  ecStkInconsistentFif=110906;    // Na Fifo karte cislo ... je ine tovarove cislo ako doklade prijmu.
  ecStkInconsistentStm=110907;    // Na skladovom pohybe cislo ... je ine tovarove cislo ako doklade prijmu.
  ecStkStmIsNotExistInDoc=110908; // Skladovy pohyb cislo ... nema suvstazny zapis na suvstaznom doklade ...
  ecStkIsNotExistInStkLst=110909; // Neexistujuci sklad.
  ecStkThisFifCardIsUsed=110910;  // Nie je pozne stornovat vybranu polozku pretoze z jej FIFO karty uz bol uskutocneny vydaj.
  ecStkFifEndQntIsLacking=110911; // Bie je dostatok tovaru na danej FIFO karte
  ecStkCorItmIsInClsPeriod=110912;// Opravu nie je mozne vykonat nakolko oprava by zmenila udaje uzatvoreneho obdobia
  ecStkStsNotExists       =110913;// Neexistuje rezervacia na danu polozku skladu.

  // PLS - Tvorba predajn˝ch cien
  acPlsYourCanDeletePlsItm=110701; //* Naozaj chcete zrusit vybranu polozku z cennika ?
  acPlsYourCanMarkAction=110702;   //* Naozaj chcete oznacit vybranu polozku za akciov˝ tovar ?
  acPlsYourCanUnMarkAction=110703; //* Naozaj chcete zruöiù akciovÈ oznaËenie pre vybran˙ poloûku ?
  acPlsYourCanDisableGs=110704;    //* Naozaj chcete vyradit vybranu polozku z predaja ?
  acPlsYourCanEnableGs=110705;     //* Naozaj chcete zaradit vybranu polozku do predaja ?
  acPlsYourCanDeletePls=110706;    //* Naozaj chcete zrusit vybrany cennik ?
  acPlsYouCanChangeBPrice=110707;  // Bola zaznamenana zmena predajnej ceny. Povodna cena je ... Chcete zmenit predajnu cenu c cenniku.
  acPlsYouCanAddItmToPls=110708;   // Zadany tovar nie je v predajnom cenniku avsak ma zadanu predajnu cenu. Chcete tento tovar vlozit do cennika c.

  ecPlsStkNumIsNotExist=110701;    //* Sklad, ktory je priradeny k cenniku neexistuje.
  ecPlsGsNotExistInGsCat=110702;   //* Zadane tovarovÈ ËÌslo neexistuje v evidencii tvoaru.
  ecPlsIsNotDeletedMark=110703;    //* Nie je moûnÈ zruöiù dan˝ cennÌk. Ak chcete zruöiù cel˝ cennÌk, potom vo vlastnostiach cennÌka treba povoliù zruöenie danÈho cennÌka.
  ecPlsSrcPlsNumIsZero=110704;     //* Nezadali ste cislo predajneho cennika, ktorou chcete porovnat aktualny cennik.
  ecPlsThisGsIsInAction=110705;    // Nie je moûnÈ zmenit predajnu cenu.
  ecPlsThisPlsNumNotExist=110706;  // Zadane cislo cennika neexistuje

  // OMB - Interne skladove vydajky
  acOmbYourCanDeleteOmb=111101;  // Naozaj chcete zrusit vybranu knihu internych skladovych vydajok
  acOmbYourCanDeleteOmd=111102;  // Naozaj chcete zrusit vybranu skladovu vydajku
  acOmbYourCanDeleteOmi=111103;  // Naozaj chcete zrusit vybranu polozku skldovej vydajky
  acOmbYourCanLockOmd=111104;    // Naozaj chcete uazmkut vybrany dodavatelsky dodaci list ?
  acOmbYourCanUnlockOmd=111105;  // Naozaj chcete odmkunt vybrany dodavatelsky dodaci list ?
  acOmbCarRegNotExistPdn=111106; // Zadane vyrobne cislo uz existuje. Aj v tom pripade chcete vydat tovar ?
                       // 180207;  // Naozaj chcete zrusit vyparovanie vybranej polozky dodacieho listu s fakturou ?
  acOmbYourCanIncomeOmi=111108;  // Naozaj chcete prijat vybranu polozku na sklad ?

  ecOmbThisOmdIsLocked=111101;    // Vybrany dodaci list uz je uzamknuty
  ecOmbThisOmdIsNotLocked=111102; // Vybrany dodaci list nie je uzamknuty
  ecOmbBookIsNotExist=111103;     // Zadana kniha odberatelskych dodacich listov neexistuje
  ecOmbIsCanNotDeleteOmb=111104;  // Vybranu knihu intern˝ch skladov˝ch vydajok nie je mozne zrusit, pretoze osahuje doklady.
  ecOmbSlctImiIsIncome=111005;    // Vybrana polozka skladovej vydajky uz je vydana zo sklad.
  ecOmbSlctImdIsIncome=111006;    // Vybrana skladova vydajka neobsahuje ziadnu polozku, ktoru by bolo mozne vydat zo skladu.
  ecOmbSndIsNotPossible=111107;   // Nie je zadana kniha skladovych prijmov
  ecOmbIMIDelIsNotPossible=111108;// Nie je mozne zrusit skladovu prijemku lebo je uz prijata na sklad

  // IMB - Interne skladove prijemky
  acImbYourCanDeleteImb=111001;  // Naozaj chcete zrusit vybranu knihu internych skladovych vydajok
  acImbYourCanDeleteImd=111002;  // Naozaj chcete zrusit vybranu skladovu vydajku ?
  acImbYourCanDeleteImi=111003;  // Naozaj chcete zrusit vybranu polozku skldovej vydajky ?
  acImbYourCanLockImd=111004;    // Naozaj chcete uazmkut vybrany dodavatelsky dodaci list ?
  acImbYourCanUnlockImd=111005;  // Naozaj chcete odmkunt vybrany dodavatelsky dodaci list ?
  acImbCarRegNotExistPdn=111006; // Zadane vyrobne cislo uz existuje. Aj v tom pripade chcete vydat tovar ?
                         // 180207;  // Naozaj chcete zrusit vyparovanie vybranej polozky dodacieho listu s fakturou ?
  acImbYourCanIncomeOmi=111008;  // Naozaj chcete prijat vybranu polozku na sklad ?
  acImbDelImiNotEnghPos=111009;  // Chcete zrusit polozku aj ked na pozicii neni dostatok tovaru?

  ecImbThisImdIsLocked=111001;    // Vybrany dodaci list uz je uzamknuty
  ecImbThisImdIsNotLocked=111002; // Vybrany dodaci list nie je uzamknuty
  ecImbBookIsNotExist=111003;     // Zadana kniha dodavatelskych dodacich listov neexistuje
  ecImbIsCanNotDeleteImb=111004;  // Vybranu knihu dodavatelskych dodacich listov nie je mozne zrusit, pretoze osahuje doklady
  ecImbSlctImiIsIncome=111005;    // Vybranu polozka dodacieho listu uz je prijata na sklad.
  ecImbSlctImdIsIncome=111006;    // Vybrana skladova prijemka neobsahuje ziadnu polozku, ktoru by bolo mozne prijat na sklad.
  ecImbRcvIsNotPossible=111007;   // Nie je mozne vykonat internetovy prenos dokladu pretoze nie je zadany sklad alebo skladovy pohyb

  // IVD - Inventarizacia skladov
  acIvdYourCanClearIvd=111701;   // Inventarny dokld uz obsahuje polozky. Naozaj chcete zlucit inv. harky do inv. dokladu
  acIvdIvlFaseIsExist=111702;    // Do inventarneho harku c. ... uz bola nacitana faza c. ...
  acIvdYourCanDeleteIvd=111703;  // Naozaj chcete vymazat invent8rny doklad ?

  ecIvdIvlIsNotExist=111701;     // Neexistuju inventarne harky
  ecIvdImbNumIsNotExist=111703;  // Neexistujyce cislo knihy skldovych prijmov
  ecIvdOmbNumIsNotExist=111704;  // Neexistujyce cislo knihy skldovych vydajov
  ecIvdDelIvdInIviExist=111705;  // Nie je mozne zrustit polozku lebo existuje na inv. harku
  ecIvdNotAllIvlClosed=111706;  // Nie su uzatvorene vsetky inv. harky

  // REB - Precenovacie doklady
  acRebYourCanDeleteReb=111901;   // Naozaj chcete zrusit vybranu knihu precenovacich dokladov ?
  acRebYourCanDeleteRed=111902;   // Naozaj chcete zrusit vybrany precenovaci doklad ?
  acRebYourCanDeleteRei=111903;   // Naozaj chcete zrusit vybranu polozku precenovacieho dokladu ?

  ecRebSlctDocIsRevalue=111901;   // Vybrany doklad nie je mozne zrusit pretoze jeho polozky uz boli precenene.

  // ACB - Akciove precenenie tovaru
  acAcbTmpDocInsNotEmpty=112001;  // V docasnom doklade precenenia tovaru boli najdene polozky - chcete ich nacitad do daneho dokladu ?

  ecAcbSlctDocIsClosed=112001;    // Vybrany doklad nie je mozne zrusit pretoze uz je uatvoreny.

  // PKB - Doklady kompletizacii vyrobku
  ecPkbPackOnlyEqualMg=113001;    // Prebalit tovar len do rovnakych tovarovych skupin

  // TIM - Terminalovy prijem tovaru
  ecTimBsbPriceIsNotExist=115001;  // Nie je definovan8 cenav obchodn7ch podmienk8ch dod8vatelov

  // AFB - Akciove letaky
  acAFBItmDelete        =116001;   // Naozaj chcete zrusit polozku

  ecAfbSlctDocIsClosed=116001;    // Vybrany doklad nie je mozne zrusit pretoze uz je uatvoreny.
  ecAfbCoDayDifAcDay  =116002;    // Pocet dni kontrolneho obdobia a akcioveho obdobia su neni rovnake

  // APL - Akciovy cennik
  acAplRecalcDifPrc   =117001;   // Naozaj chcete prepocitat zisk poloziek

  // OCB - Odberatelske objednavky
  acOcbYourCanDeleteOcb=120101;  // Naozaj chcete zrusit vybranu knihu doberatelskych zakaziek ?
  acOcbYourCanDeleteOcd=120102;  // Naozaj chcete zrusit vybranu odberatelsku zakazku ?
  acOcbYourCanDeleteOci=120103;  // Naozaj chcete zrusit vybranu polozku objednavky ?
  acOcbYourCanLockOcd=120104;    // Naozaj chcete uazmkut vybranu zakazku ?
  acOcbYourCanUnlockOcd=120105;  // Naozaj chcete odblokovat vybranu zakazku ?
  acOcbYourCanAddOcdQnt=120106;  // Zadana mnozstvo je viaz nez mnozstvo na predaj. Chcete aj napriek tomu ulozit polozku na doklad a tak vytvori5 poziadavku na doobjednavanie tovaru ?
  acOcbYourCanDelPairOci=120107; // Naozaj chcete zrusit vyparovanu polozku ?
  acOcbYourCanDelOciRes=120108;  // Naozaj chcete zrusit rezervaciu vybranej polozky ?
  acOcbYourCanAddOciRes=120109;  // Naozaj zarezervovat vybranu tovarovu polozku ?

  ecOcbThisOcdIsLocked=120101;      //* Vybrana odberatelska zakazka je uz uzamknuta
  ecOcbThisOcdIsNotLocked=120102;   //* Vybrana zakazka nie je uzamknuta
  ecOcbOciIsNotExistInGsCat=120103; //* Polozka objednavky neexistuje v evidencii tovaru
  ecOcbNoItmForFms=120104;          // Nadanej zakazke neexistuje polozka na vyuctovanie
  ecOcbExtNumIsExist=120105;        // ZadanÈ externÈ ËÌslo uû existuje na z·kazke: 
  ecOcbTcdIsExist=120106;           // Z danej enerovan˝ dodacÌ list

  // TCB - Odberatelske dodacie listy
  acTcbYourCanDeleteTcb=120201;  //* Naozaj chcete zrusit vybranu knihu doberatelskych dodacib listov
  acTcbYourCanDeleteTcd=120202;  //* Naozaj chcete zrusit vybrany odberatelsky dodaci list
  acTcbYourCanDeleteTci=120203;  //* Naozaj chcete zrusit vybranu polozku odberatelskeho dodacieho listu
  acTcbYourCanLockTcd=120204;    //* Naozaj chcete uazmkut vybrany odberatelsky dodaci list ?
  acTcbYourCanUnlockTcd=120205;  //* Naozaj chcete odblokovat vybrany dodaci list ?
  acTcbCarRegNotExistPdn=120206; // Zadane vyrobne cislo neexistuje. Aj v tom pripade chcete vydat tovar ?
  acTcbYourCanUnPairTci=120207;  // Naozaj chcete zrusit vyparovanie vybranej polozky dodacieho listu s fakturou ?
  acTcbYourCanDelOutItm=120208;  // Naozaj chcet ezrusit vydaj zo skladu pre vybrany tovar ?
  acTcbYourCanDelOutDoc=120209;  // Naozaj chcet ezrusit vydaj zo skladu pre cely doklad ?

  ecTcbThisTcdIsLocked=120201;    //* Vybrany dodaci list uz je uzamknuty
  ecTcbThisTcdIsNotLocked=120202; //* Vybrany dodaci list nie je uzamknuty
  ecTcbBookIsNotExist=120203;     //* Zadana kniha odberatelskych dodacich listov neexistuje
  ecTcbCasRegIsNotEnable=120204;  // Zo zadanej knihy nie je povolene vyucttovat dodacie listy cez registracnyu pokladnu.
  ecTcbIsCanNotDeleteTcb=120205;  //* Vybranu knihu odberatelskych dodacihc listov nie je mozne zrusit, pretoze osahuje doklady
  ecTcbNoAllTciIsStkOut=120206;   // Nebolo mozne vydat zo skladu vestkych poloziek vybraneho dokladu.
  ecTcbItmIsFiscalNoDel=120207;   // Vybranu polozku dodacieho listu nie je mozne zrusit, pretoze uz bola vyuctovana cez ERP.
  ecTcbNulBPriceDetected=120208;  // U ... poloziek bola zaznamenan8 nulova predajna cena. Tieto polozky su oznacene s cervenou farbou.

  // ICB - Odberatelske fakture
  acIcbYourCanDeleteIcb=120301;  //* Naozaj chcete zrusit vybranu knihu doberatelskych faktur ?
  acIcbYourCanDeleteIcd=120302;  //* Naozaj chcete zrusit vybranu odberatelsku faktury ?
  acIcbYourCanDeleteIci=120303;  //* Naozaj chcete zrusit vybranu polozku odberatelskej faktury ?
  acIcbYourCanLockIcd=120304;    //* Naozaj chcete uazmkut vybranu odberatelsku fakturu ?
  acIcbYourCanUnlockIcd=120305;  //* Naozaj chcete odblokovat vybranu odberatelsku fakturu ?
  acIcbYourCanUnPairIci =120306; // Naozaj chcete zrusit vyparovanie vybranej polozky faktury s dodacim listom ?
//  acIcbYourCanAddDuplic=120307;  // Zadany tovar uz existuje na tejto fakture. Chcete aj napriek tomu pridat tuto polozku na doklad ?
  acIcbYourCanReCalcPayVal=120308; // Naozaj chcete prepocitat uhradenu ciastku vybranej faktury

  ecIcbThisIcdIsLocked=120301;    // Vybrana odberatelska faktura je uz uzamknuta.
  ecIcbThisIcdIsNotLocked=120302; // Vybrana odberatelska faktura este nebola uzamknuta.
//  ecIcbBookIsNotExist=120203;   //* Zadana kniha odberatelskych dodacich listov neexistuje
//  ecIcbBookIsNotExist=120304;   // Dana lniha odberatelskych faktur neexistuje
  ecIcbNoAllItmOutFromStk=120305; // Nebolo mozne vydat zo skladu vsetkych poloziek vystaveneho dodacieho listu.
  ecIcbCsbNumIsNotExist=120306;   // Vo vlastnostiach danej knihy faktur nie je zadane cislo knihy hotovostnej pkladne
  ecIcbThisWsiIsOutput=120307;    // Danu polozku faktury nie je mozne vydat, pretoze je v OE vody a uz je vydany zo skladu
  ecIcbThisNotFacInvoice=120308;  // DAna faktura nie je faktoringovy doklad

  // RPL - Doporucene predajne ceny
  ecRplExcNumIsInvalid=120401;    // Chybne cislo cenovej vynimky
  ecRplNewTextIsNotSet=120402;    // Nov˝ n·zov tovaru nie je zadany

  // SPE - Evidencia zalohovych platieb
  acSpeYourCanCreateConto=120601;// Odberatel ... este nema zalozane konto zalohovych platieb. Chete to teraz zalozit ?
  acSpeYourCanDelSlctDoc=120602; // Naozaj chcete zrusit vybrany doklad zalohovej platby.

  ecSpeExpValIsTooLarge=120601;  // Zadali ste vacsiu hodnotu pouzitia zalhovej platby ako konecny stav zalohoveho uctu daneho odberatela.
  ecSpeNoDelIsNoLastDoc=120602;  // Vybrany doklad nie je posledny v poradi dokladov zalohovych platieb. Zrusit mozete len psledny doklad.
  ecSpeVatDocIsNotExist=120603;  // Neexistuje danovy doklad c. , ktory bol vystaveny k prijmu zalohovej platbe.

  // SAL - vseobecne hlasenia per cely odbytovy system
  ecSalInPriceIsNul=120901;       // Zadali ste zaporny vydaj t.j. prijem na uplne novy tovar, ktory este nema urcenu nakupnu cenu - treba NC zadat
  ecAtpSalBlwMinBpc=120902;       // Pokus o predaj pod minim·lnou predajnou cenou

  // CAS - Maloobchodny predaj
  acCasYourCanDeleteCai=130501;  // Naozaj chcete zrusit vybranu polozku pokladnicneho dokladu ?
  acCasYourCanSaleToNeg=130502;  // Na skladovej karte  nie je dostatok z vybraneho tovaru. Chcete aj napriek tomu predat dany tovar ?
  acCasYourCanDeleteCad=130503;  // Naozaj chcete zrusit pokladnicneho doklad ?
  acCasThosIsNotVatDocI=130504;   // Ak pridate tuto polozku uctenka bude mat hodnotu vacsiu nez 50000.- Sk. Chcete pridat danu polozku na uctenku ?
  acCasYourCanDeletePay=130505;  // Naozaj chcete zrusit vybrany platobny prostriedok ?
  acCasYourCanExecXClose=130506; // Naozaj chcete vykonat uzavierku smeny ?
  acCasYourCanExecDClose=130507; // Naozaj chcete vykonat dennu uzavierku pokladne ?
  acCasYourCanExecMClose=130508; // Naozaj chcete vykonat mesacn uzavierku pokladne ?
  acCasYourCanLoadOpenBlk=130509;// System zaznamenal neuzatvoreny pokladnicny doklad. Chcete nacitat tento doklad do pokladne a potom uzatvorit ?
//  acCasYourCanAddDuplic=130510;  // Zadany tovar uz existuje na tomto pokladnicnom doklade. Chcete aj napriek tomu pridat tuto polozku na doklad ?
  acCasYourCanLastBlkPrn=130511; // Naozaj chcete vytlacit kopiu posldenej uctenky ?
  acCasThosIsNotVatDocB=130512;   // Hodnotu danej uctenky je vacsia nez 50000.- Sk. Naozaj chcete uzatvorit tuto uctenku ?

  ecCasNumIsNotSetting=130501;     // Nie je zadane cislo pokladne
  ecCasNumIsNotCorrect=130502;     // Nespravne cislo pokladne
  ecCasPayIsNotEmpty=130503;       // Nie je mozne zrusit dany platobny prostriedok, pretoze obsahuje financnu hodnotu .
  ecCasNotEnoughStkQnt=130504;     // Na sklade nie je dostatocne mnozstvo
  ecCasDscPrcIsTooLarge=130505;    // Zadana zlava presahuje maximalnu hornu hranicu zlavy.
  ecCasExpValIsTooLarge=130506;    // Zadali ste vacsiu ciastku odvodu ako konecny stav daneho platobneho prostriedku.
  ecCasPriceIsNegative=130507;     // Zadali ste zapornu predajnu cenu. Cena nemoze byt zaporna len mnozstvo.
  ecCasDCloseError=130508;         // Dennu uzavierku nebolo mozne vykonat. Cislo chyby je ...
  ecCasMCloseError=130509;         // Mesacnu uzavierku nebolo mozne vykonat. Cislo chyby je ...
  ecCasPrinterNotReady=130510;     // K fisklanemu modulu nie je pripojena tlaciaren alebo tlaciaren je vypnuta
  ecCasDateIsNotCorrect=130511;    // Nespravny systemovy datum pokladne
  ecCasBlkIsNotClosed=130512;      // Momentalne mate otvorenu pokladnicnu uctenku. Program mozete opustit az po uzatvoreni danej pokladnicnej uctenky
  ecCasPaCodeIsNotExist=130513;    // Firma, ktoremu pratri dana zakaznicka karta nie je v evidnecii partnerov
  ecCasDisabledNulSale=130514;     // Nie je povoleny predaj tovaru s nulovou predajnou cenou.
  ecCasBarCodeIsNotExist=130515;   // Neexistujuci identifikacny kod tovaru
  ecCasNoDscThisIsActionGs=130516; // Na vybranu polozku nie je mozne zadat zlavu nakolko tento tovar je pod cenocou akxiou
  ecCasErrorToFiskalWrite=130517;  // Chyba pri komunikacii s fisklanym modulom
  ecCasCrdTrnDuplicBlkNum=130518;  // V zaznamoch o pouziti bonusovej zakaznickej karty doslo k duplicitnemu cislu pokladnicnych dokladov
  ecCasNotCrdNumInCrdLst=130519;   // Zoznam zakaznickych kariet neobsahuje danu zakazncku kartu
  ecCasNoCashIsTooLarge=130520;    // PrÌliö velk· nehotovostn· platba - napr. ak stravnÈ lÌstky prevyöuj˙ hodnotu dokladu
  ecCasFmdCommunicError=130521;    // Chyba pri komuunikaci s fisk8lnym modulom - pokladnicna uctenka nebola spracovana
  ecCasFmdInitError=130525;        // Chyba pri inicializacii fiskalneho modulu
  ecCasReadWgdDocVal=130526;       // Bol nacitnay vahovy doklad v hodnote :
  ecCasCssNotActive=130527;        // Pokladnicny Server je nedostupny
  ecCasFmdVatPrc5NotSet=130528;   // Hladina DPH 5 nie je nastaven· na 99

  // ACC - Globalne hlasenia podvojneho cutovnictva
  ecAccSmCodeIsNotExist=150001;   // Dany dokld nie je mozne rozuctovt pretoze skladovy pohyb .. neexistuje v zoznamu skldovych pohybov

  // IDB - Integrne uctovne doklady
  acIdbYourCanDeleteIdb=150301;  // Naozaj chcete zrusit vybranu knihu internych uctovnuch dokladov ?
  acIdbYourCanDeleteIdd=150302;  // Naozaj chcete zrusit vybrany interny uctovny doklad ?
  acIdbYourCanDeleteIdi=150303;  // Naozaj chcete zrusit vybranu polozku interneho uctovneho dokladu ?
  acIdbYourCanLockIdd=150304;    // Naozaj chcete uazmkut vybrany interny uctovny doklad ?
  acIdbYourCanUnlockIdd=150305;  // Naozaj chcete odmkunt vybrany interny uctovny doklad ?
  acIdbYourCanDelFillIdd=150306; // Vybrany interny uctovny doklad obsahuje polozky. Chcete vymazat vybrany doklad spolu s jeho polozkami ?

  ecIdbThisIddIsLocked=150301;    //* Vybrany interny uctovny doklad uz je uzamknuty
  ecIdbThisIddIsNotLocked=150302; //* Vybrany interny uctovny doklad nie je uzamknuty
  ecIdbBookIsNotExist=150303;     //* Zadana kniha internych uctovnych dokladov neexistuje
  ecIdbIsCanNotDeleteIdb=150304;  //* Vybranu knihu internych uctovnych dokladov nie je mozne zrusit, pretoze osahuje doklady
  ecIdbAccSideIsNotEqual=150305;  // Strana MD a DAL daneho interneho uctovneho dokladu nie su rovnake. Rozdiel medzi nimi je ... Sk

  // CSB - Hotovostne pokladne
  acCsbYourCanDeleteCsb=150401;  // Naozaj chcete zrusit vybranu knihu pokladnicnych dokladov ?
  acCsbYourCanDeleteCsd=150402;  // Naozaj chcete zrusit vybrany pokladnicny doklad ?
  acCsbYourCanDeleteCsi=150403;  // Naozaj chcete zrusit vybranu polozku pokladnicneho dokladu ?
  acCsbYourCanLockCsd=150404;    // Naozaj chcete uazmkut vybrany pokladnicny doklad ?
  acCsbYourCanUnlockCsd=150405;  // Naozaj chcete odmkunt vybrany pokladnicny doklad ?
  acCsbYourCanDelFillCsd=150406; // Vybrany pokladnicny doklad obsahuje polozky. Chcete vymazat vybrany doklad spolu s jeho polozkami ?

  ecCsbDocIsNotRndCorr=150401;   // Doklad nie je korrektne zaokruhlent

  // SOB - Evidencia bankovych vypisov
  acSobYourCanDeleteSob=150501;   // Naozaj chcete zrusit vybranu knihu bankovych vypisov ?
  acSobYourCanDeleteSod=150502;   // Naozaj chcete zrusit vybrany bankovy vypis ?
  acSobYourCanDeleteSoi=150503;   // Naozaj chcete zrusit vybru polozku bankoveho vypisu >
  acSobNoEqSohAndSoiSum=150504;   // Konecna hodnota bankoveho vypisu vypocitane na zaklade zadanych pooloziek nesedi s hodnoto ktora bola zadana do hlavicky dokladu. Chcete zmenit konecy stav nypisu na zaklade jeho poloziek ?
  acSobThisDifIsCrdVal=150505;    // Medzi uhradenou ciastkou a hodnotou faktury je rozdiel ... Chcete tuto ciastku zauctovat ako kurzovy rozdiel ?
  acSobNoAllItmiSpaired=150506;   // Nie su vsetky polozky elektronickeho bankoveho vypisu vyparovane chcete ich napriek tomu vlozit do vypisu

  ecSobNoAllItmiSpaired=150501;   // Nie su vsetky polozky elektronickeho bankoveho vypisu vyparovane
  ecSobAboEokIsInvalid=150502;    // Zadany elektronicku osobny kluc je nespravny
  ecSobClientIdIsEmpty=150503;    // Nie je zadany identifikacny kod klienta pre elektronicke bankovnictvo
  ecSobItmDeleteError=150503;     // Chyba pri zru3en9 poloziek bankoveho vypisu

  // PQB - Evidencia prevodnych prikazov
  ecPqbThisDocisSended=150601;    // Dany prevodny prikaz uz bol odoslany do banky
  ecPqbThisIsdIsNotBaPay=150602;  // Dana faktura nie je oznacena na uhradu s bankovym prevodom

  // ISB - Dodavatelske danove doklady
  acIsbYourCanDeleteIsb=150801;  // Naozaj chcete zrusit vybranu knihu dodavatelskych danovych dokladov
  acIsbYourCanDeleteIsd=150802;  // Naozaj chcete zrusit vybrany dodavatelsky danovy doklad
  acIsbYourCanDeleteIsi=150803;  // Naozaj chcete zrusit vybranu polozku danoveho dokldu
  acIsbYourCanLockIsd=150804;    // Naozaj chcete uazmkut vybrany dodavatelsky dodaci list ?
  acIsbYourCanUnlockIsd=150805;  // Naozaj chcete odmkunt vybrany dodavatelsky dodaci list ?
//  acIsbYourCanAddDuplic=150806;  // Zadany tovar uz existuje na tejto fakture. Chcete aj napriek tomu pridat tuto polozku na doklad ?
  acIsbYourCanUnPairIsi=150807;  // Naozaj chcete zrusit vyparovanie vybranej polozky dodacieho listu s fakturou ?
                       // 180208;  //
  acIsbYourCanIshRecalc=150809;  // Naozaj chcete prepocitat hlavicku vybraneho dodaciieho listu na zaklede jeho poloziek ?
  acIsbRecalcAllDoc=150810;  // Chcete prepocitat vsetky doklady?

  ecIsbThisIsdIsLocked=150801;    // Vybrany dodaci list uz je uzamknuty
  ecIsbThisIsdIsNotLocked=150802; // Vybrany dodaci list nie je uzamknuty
  ecIsbBookIsNotExist=150803;     // Zadana kniha dodavatelskych dodacich listov neexistuje
  acIsbIsCanNotDeleteTsb=150804;  // Vybranu knihu dodavatelskych dodacich listov nie je mozne zrusit, pretoze osahuje doklady

  // ACC - Obratova predvaha
  ecAccNoDelItIsNotNulValue=151201; // Ucet nie je mozne zrusit z obratovej predvahy, pretoze nema nulovu hodnotu.

  // BLC - Tvorba uctovnych vykazov
  acBlcYourCanDeleteBlc=151301;  // Naozaj chcete zrusit vybrany vykaz ?

  // JRN - Dennik uctovnych zapisov
  ecJrnNoDelItIsUsedInJrn=151401; // Ucet nie je mozne zrusit pretoze je pouzity v denniku uctovnych zapisov

  // FJR - Penazny dennik
  ecFjrRowNumIsInvalid=151501;   // Neexistujuce cislo riadku penaznehodennika

  // SAC - Evidencia podsuvahovych uctov
  acSacYourCanDeleteAcc=151601;  // Naozaj chcete zrusit vybrany ucet
  acSacYourCanDeleteItm=151602;  // Naozaj chcete zrusit vybrany uctovny zapis

  // MTB - Evidencia MTZ
  ecMtbIsNotDeleteImd=151701;    // Nie je mozne zrusit vybranu prijemku pretoze uz je vydana zo skladu
  ecMtbOuQntisTooLarge=151702;   // Zadan0 mnozstvo je prilis velke. Z vybranej prijemky maximalne mozete vydat ... ks

  // CRS - Kurzovy listok
  ecCrsDevizaIsNotExist=151801;  // Zadana mena neexistuje v kurzovom listku
  ecCrsCourseIsNotExist=151801;  // Na zadany datum neexsituje kurz

  // VTR - Evidencia DPH
  ecVtrVtdSpcIsNotExist=151901;  // Neexistuje zoznam specifikacie dokladov

  // CRD - Zakazcnicke karty
  ecCrdInvPaCodeNotEqual= 169001;  // Vybrana faktura nie je vystavna na firmu ku ktorej je priradeny zakaznicka karta
  ecCrdInvAlreadyAssign=169002;  // Vybrana faktura je uz priradena ku druhej zakaznickej karte

  acCrdImpItmFromTxt=169001;  // Chcete importovat vybrane karty 

  // FXB - Evidencia dlhodobeho majetku
  acFxbYourCanDeleteFxa=170101;  // Naozaj chcete zrusit vybranu evidencnu kartu dlhodobeho majetku ?
  acFxbYourCanDeleteFxt=170102;  // Naozaj chcete zrusit vybrany danovy odpis dlhodobeho majetku ?
  acFxbYourCanDeleteFxl=170103;  // Naozaj chcete zrusit vybrany uctovny odpis dlhodobeho majetku ?
  acFxbYourCanDeleteFxc=170104;  // Naozaj chcete zrusit vybrane technicke zhodnotenie dlhodobeho majetku ?
  acFxbYourCanDeleteTgr=170105;  // Naozaj chcete zrusit vybrane danovu dopisovu skupinu ?
  acFxbYourCanDeleteAgr=170106;  // Naozaj chcete zrusit vybrane uctovnu dopisovu skupinu ?
  acFxbYourCanDeleteFxb=170107;  // Naozaj chcete zrusit vybranu knihu dlhodobeho majetku ?
  acFxbYourCanDeleteInt=170108;  // Naozaj chcete zrusit prerusenie odpisu dlhodobeho majetku ?

  ecFxbBookIsNotEmpty=170101;    // Vybranu knihu dlhodobeho majetku nie je mozne zrusit pretoze obsahuje evidencne karty.
  ecFxbFxtGrpIsNotEmpty=170102;  // Tabulka danovych odpisov je prazdna. Bez tejto tabulky nie je mozne vypocitat danove odpisy.
  ecFxbFxtGrpIsNotExist=170103;  // Dana danova odpisova skupina neexistuje v tabulke odpisovych skupin.

  // TSB - Dodavatelske dodacie listy
  acTsbYourCanDeleteTsb=180201;  // Naozaj chcete zrusit vybranu knihu dodavatelskych dodacib listov
  acTsbYourCanDeleteTsd=180202;  // Naozaj chcete zrusit vybrany dodavatelsky dodaci list
  acTsbYourCanDeleteTsi=180203;  // Naozaj chcete zrusit vybranu polozku dodavatelskeho dodacieho lstu ?
  acTsbYourCanLockTsd=180204;    // Naozaj chcete uazmkut vybrany dodavatelsky dodaci list ?
  acTsbYourCanUnlockTsd=180205;  // Naozaj chcete odmkunt vybrany dodavatelsky dodaci list ?
  acTsbYourCanDelFillTsd=180206; // Vybrany dodaci list obsahuje polozky. Chcete vymazat vybrany doklad spolu s jeho polozkami ?
  acTsbYourCanUnPairTsi=180207;  // Naozaj chcete zrusit vyparovanie vybranej polozky dodacieho listu s fakturou ?
  acTsbYourCanIncomeTsi=180208;  // Naozaj chcete prijat na sklad vybranu polozku dodacieho listu ?
  acTsbYourCanTshRecalc=180209;  // Naozaj chcete prepocitat hlavicku vybraneho dodaciieho listu na zaklede jeho poloziek ?
//  acTsbYourCanAddDuplic=180210;  // Zadany tovar uz existuje na tomto dodacom liste. Chcete aj napriek tomu pridat tuto polozku na doklad ?
  acTsbYourCanAddNulPrice=180211; // Naozaj chcete ulozit polozku dodacieho listu s nulovou nakupnou cenou ?
  acTsbYourCanDelProdNums=180212; // K zadanej polozke dodacieho listu su priradene vyrobne cisla. Chete tieto vyrobne cisla zrusit ?

  ecTsbThisTsdIsLocked=180201;    // Vybrany dodaci list uz je uzamknuty
  ecTsbThisTsdIsNotLocked=180202; // Vybrany dodaci list nie je uzamknuty
  ecTsbBookIsNotExist=180203;     // Zadana kniha dodavatelskych dodacich listov neexistuje
  ecTsbDlvQntIsNotValid=180204;   // Zadane mnozstvo dodavky je vacsie ako objednane mnozstvo.
  ecTsbSlctTsiIsIncome=180205;    // Vybrana polozka dodacieho listu uz je prijata na sklad.
  ecTsbSlctTsdIsIncome=180206;    // Vybrany dodaci list neobsahuje ziadnu polozku, ktoru by bolo mozne prijat na sklad.
  ecTsbSlctItmCanNotDel=180207;   // Vybranu polozku dodacieho listu uz nie je mozne zrusit, pretoze uz z daneho prijmu bol uskutocneny vydaj.
  ecTsbTsdPaIsNotIsdPa=180208;    // Vybrany dodaci list a vybrana faktura nemaju rovnakeho dodavatela
  ecTsbTrmRcvCPriceIsNul=180209;  // Dany doklad obsahuje polozku s nulovou nakupnou cenou. Pred ulozenim dokladu do DDL je potrebne zadat vsetkyy nakupne ceny
  ecTsbBcsPriceDifferent=180210;  // Zmena nakupnej ceny oproti obchodnym podminekam
  ecTsbSlcItmIsReserved=180211;   // Vybranu polozku dodacieho listu uz nie je mozne zrusit, pretoûe z meho uû bola vykonan· rezerv·cia

  // HRS - Hotelov˝ rezervaËn˝ systÈm

  // CMB - Doklady kompletizacii vyrobku
  acCmbYourCanDeleteCmb=310101;   // Naozaj chcete zrusit vybranu knihu dokladov kompleriz·cii vyrobkov ?
  acCmbYourCanDeleteCmd=310102;   // Naozaj chcete zrusit vybrany doklad kompleriz·cii vyrobkov ?
  acCmbYourCanUseCmSpec=310103;   // Chcete nacitat specifikaciu zadaneho vyrobku ?
  acCmbYourCanInputCmh=310104;    // Komponenty daneho vyrobku uz su vyskladnene ale vyrobok este nie je prijaty na sklad. Chcete prijat vyrobok na sklad ?

  ecCmbYourCanNotDelCmd=310107;   // Vybrany doklad kopletizacii vyrobku nie je mozne zrusit, pretoze vyrobok uz bol prijaty zo sklad.
  ecCmbThisPdIsInput=310108;      // Komponenty daeho vyrobku nie je mozne modifikovat pretoze vyrobok uz je prijaty na sklad
  ecCmbSlctCmdIsCompletize=310109;// Vybrany vyrobok je uz kompetizovany.
  ecCmbStkStatNSTMNotNul=310110;  // Vybrany vyrobok je oznaceny ako nekompetizovany, hoci uz ma skladove pohyby

  // CPD - Systemove prostriedky
  acItbYourCanDeleteIt=320601;   // Naozaj chcete zrusit vybrany vyrobny nastroj ?
  acItbYourCanDisableIt=320602;  // Naozaj chcete vyradit vybrany vyrobny nastroj ?
  acItbYourCanEnableIt=320603;   // Naozaj chcete zaradit vybrany vyrobny nastroj ?
  acItbYourCanSrchHole=320604;   // Naozaj chcete najst volnu poziciu ?

  ecItbThisIsEqualGrp=320601;    // Chybny udaje. Zadali ste tu istu skupinu, ktoru chcete vymazat.
  ecItbThisItExistInBook=320602; // Pod zadany poradovym cislo uz je zaevidovany nastroj v knihe c. ..
  ecItbThisItIsDisabled=320603;  // Tento vyrobny nastro uz je vyradeny
  ecItbThisItIsEnabled=320604;   // Tento vyrobny nastro uz je zaradeny

  // DMB - Doklady rozobratia vyrobku
  acDmbYourCanDeleteDmb=330101;   // Naozaj chcete zrusit vybranu knihu dokladov rozobratia vyrobkov ?
  acDmbYourCanDeleteDmd=330102;   // Naozaj chcete zrusit vybrany doklad rozobratia vyrobkov ?
  acDmbYourCanUseDmSpec=330103;   // Chcete nacitat specifikaciu zadaneho vyrobku ?

  ecDmbYourCanNotDelDmd=330101;   // Vybrany doklad rozobratia vyrobku nie je mozne zrusit, pretoze niektore komponenty uz boli vydane
  ecDmbThisPdIsOutput=330102;     // Komponenty daeho vyrobku nie je mozne modifikovat pretoze vyrobok uz je vydany zo skladu
  ecDmbSlctDmdIsDismantle=330103; // Vybrany vyrobok je uz rozobraty
  ecDmbVariabItmNotSelect=330104; // Komponent s vypoctovou cenou nie je oznaceny.
  ecDmbProductIsNotOutput=330105; // Vyrobok # nie je mozne vydat na rozbalenie pretoze na sklade c. x nie je dostatok

  // CDB - Doklady rozobratia vyrobku
  acCdbYourCanDeleteCdb=331101;   // Naozaj chcete zrusit vybranu knihu dokladov manu·lnej vyroby ?
  acCdbYourCanDeleteCdd=331102;   // Naozaj chcete zrusit vybrany doklad manu·lnej vyroby ?

  ecCdbYourCanNotDelCdd=331101;   // Vybran˝ v˝robok nie je moûnÈ zruöiù, pretoûe bol uû vydan˝ zo skladu
  ecCdbThisPdIsOutput=331102;     // Komponenty daeho vyrobku nie je mozne modifikovat pretoze vyrobok uz je vydany zo skladu

  // AQM - Bazenove cenove ponuky
  acAqmMonValIsNotAddToItm=400001; // Montazna praca este nebola pridana ...
  acAqmMonValIsModifyed=400002;    // Zmenila sa hodnota montaznej prace ...

  ecAqmAqoDocIsCreated=400001;     // Z tejto cenovej ponuky uz bola vygenerovana zakazka

  // AQO - Bazenove zakazky
  ecAqoQtcPrcSumIsInvalid=400101;  // Chybne percentualne rozdelenie splatok ...
  ecAqoThisItmIsCanceled=400102;   // Danu polozku nie je mozne storoovat pretoze uz bola stornovana
  ecAqoMonGscNotModified=400103;   // Montaznu pracu nie je mozne modifikovat. Tuto polozku system pocita automaticky

  // PND - Protokol nepredajneho skladu
  acPndYourCanInActiveSlctDoc=401001; // Naozaj chcete deaktivovat protokol nepredajneho skladu

  // UDB - Univerzalny odbytovy doklad
  ecUdbDscGrpIsInvalid=402001;   // Chybne cislo tocenia. Jednotlive tocenia musia byt plynule ocislovane
  ecUdbPayValIsNotEnough=402002; // Neboli zadane dostatocne financne prostriedky na uhradu pokladnicneho dokladu
  ecUdbDscPrcIsInvalid=402003;   // Nespravna sadzba zlavy. Rovnaka skupina zlavy musi mat rovnake percento zlavy.
  ecUdbDscTypeIsNotExist=402004; // Nespravny typ zlavy. Zadany tyyp zlavy nie je definovany v zozname zliav
  ecUdbThisIsNudDoc=402005;      // Na dobropis nie je mozne vystavit dobropis.
  ecUdbNudDocIsExist=402006;     // Na dany doklad uz bol vystaveny dobropis

  // VNC - Vzdialeny servis
  acVNCDeleteSlctdPa    =403001;   // Naozaj chcete zrusit vybranu prev·dzku z VNC ?
  acVNCDisableSlctdPa   =403002;   // Naozaj chcete zablokovat vybranu prev·dzku z VNC ?
  acVNCEnableSlctdPa    =403003;   // Naozaj chcete odblokovat vybranu prev·dzku z VNC ?

  
  // TOM - Terminalove vydajky
  acTomDocDelete        =406001;   // Naozaj chcete zrusit doklad
  acTomNitDelete        =406003;   // Naozaj chcete zrusit polozku nepredajneho tovaru
  acTomNitADelete       =406004;   // Naozaj chcete zrusit vsetky polozky nepredajneho tovaru
  acTomItmDelete        =406005;   // Naozaj chcete zrusit polozku
  acTomAlreadyTopOut    =406006;   // Na dany tovar uz je vytvorena pozicia ktora nebola este ale dodana
  acTomAlreadyTopQnt    =406007;   // Na dany tovar su uz vygenerovane pozicie a nie je ho mozne vydat z pozicie 1

  ecTomBlkNotFound      =406002;   // Pokladnicny doklad nebol najdeny
  ecTomNotEnoughPos     =406003;   // Nedostatok tovarov na poziciach

  // HWD - Hardware Devices
  ecHwdComPrgIsNotExist=900001;  // Neexistuje komunikacny program
  ecHwdTrmTypeIsNotSlct=900002;  // Nezadali ste typ databanky

  // BPS - Tlacovy server cenovkovych etikiet
  ecBpsServerIsInActive=910101;   // Tlacovy server nie je aktivovany

  // WSB - Operativna evidencia vody
  ecWsbBarCodeIsNotExist=920001;   // Neexistujuci kod povolenych tovarov
  ecWwbThisDocIsSended=920002;     // Dany doklad nie je mozne odoslat pretoze uz bol odoslany
  ecWsbThisDocIsEnded=920003;      // Danu doklad nie je mozne odoslat na inu prevadzku. Odber vody bol ukonceny
  ecWsbThisIsSelfWriNum=920004;    // Zadali ste vlastnu prevadzkovu jednotku
  ecWsbNotSetWriNum=920005;        // Nezadali ste prevadzkovu jednotku kam ma byt doklad odoslany

  // BTR - Chybove hlasenia databazoveho ovladaca
  ecBtrDatabaseIsNotExist=990001;// Neexistujuci databazovy subor.
  ecBtrDefFileIsNotExist=990002; // Neexistujuci definiËn˝ subor.
  ecBtrFieldTypeIsBad=990003;    // Chybny typ databazoveho pola.
  ecBtrIndexTypeIsBad=990004;    // Chybne definovany index.
  ecBtrIndexNameIsBad=990005;    // Chybne definovane meno indexu.

implementation

end.
{MOD 1804002}
{MOD 1805010} {MOD 1805023}
{MOD 1807008} {MOD 1807015}
{MOD 1809012}
{MOD 1901013}
{MOD 1901003}
{MOD 1904023}
{MOD 1926001}
