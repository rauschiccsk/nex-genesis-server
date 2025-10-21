unit NexIni;

interface

uses
  IcTypes, IcVariab, IcConv, NexVar, IniFiles, Classes, SysUtils;

type
  TFltIni = class (TIniFile)
  private
  public
    procedure WriteString   (const Section, Ident, Value: String); override;
    procedure WriteInteger  (const Section, Ident: string; Value: Longint); override;
    procedure WriteBool     (const Section, Ident: string; Value: Boolean); override;
    procedure WriteDate     (const Section, Name: string; Value: TDateTime); override;
    procedure WriteDateTime (const Section, Name: string; Value: TDateTime); override;
    procedure WriteFloat    (const Section, Name: string; Value: Double); override;
    procedure WriteTime     (const Section, Name: string; Value: TDateTime); override;
  end;

  TNexIni = class (TIniFile)
  private
  public
    // SYSTEM
    function GetBetaTest:boolean; // Ak je TRUE systém pustí moduly Beta verzia
    function GetNewGscFrm:boolean; // Ak je TRUE pouziva sa novy formular tovarovej karty
    function GetNewApm:boolean; // Ak je TRUE pouziva sa novy pristup k modulom
    function GetVatPrc (pVatGrp:byte): byte; // Urèí, že zadaná skupina pVatGrp aku ma sadzbu DPH - aktualne platne sadzby
    function GetSumVatPrc (pVatGrp:byte): byte; // Urèí, že zadaná skupina pVatGrp aku ma sadzbu DPH - platne a aj stare sadzby DPH
    Function GetStaPath: string; // Adresar statistickych udajov
    function GetDefVatGrp: byte; // Prednastavena skupina DPH
    function GetCasWorkTime: byte; // Pracovna doba pokladni
    function GetCasWorkDays: byte; // pocet pracovnych dni v tyzdni
    function GetDesignMode: boolean; // Ak je true modifikuju sa Dxx nastavenia v zoznamoch
    function GetServiceMg: longint; // Cislo tovarovej skupiny od ktorej sa zacinaju sluzby
    function GetSpvMgCode:longint; // Cislo tovarovej skupiny od ktorej zalohovej platby
    function GetVatPayType: byte; // Typ platitela DPH  0-neplatitel, 1-mesacna platca,, 2-stvrtrocna platca
    function GetOldVersion: boolean; // Ak je TRUE potom system pouziva databaze stareho DOS systemu (inventarizacia)
    function GetSelfDvzName: Str3; // Vlasnta uctovna mena
    function GetSelfStaCode: Str2; // Kod statu z evidencii statov, ktory je tuzemsko
    function GetSelfOldTin: Str15; // Stare DIC
    function GetHideSaPrice: boolean; // Ak je TRUE system ukryje predajne ceny a zisk
    function GetPosRefresh: boolean; // Ak je TRUE potom system vytvara REF subory pre registracne pokladne
    procedure SetPosRefresh (pValue:boolean);
    function GetPosRefFile: boolean; // Ak je TRUE potom system vytvara *.REF subory pre registracne pokladne v opacnom pripade .xxx
    procedure SetPosRefFile (pValue:boolean);
    function GetTsbModifyBPrice: boolean; // Ak je TRUE potom system umozni zmenit predajnu cenu tovaru aj pri nadzovani poloziek DDL
    function GetTsbShowBPrice: boolean; // Ak je TRUE potom pri prijmu polozky zobrazi predajnu cenu a zisk
    function GetDefSpvBook: Str5; // Zakladne nastavenie kniha faktur zalohovych platieb
    function GetAccountSys: boolean; // Ak je TRUE toz znamena ze sa pouziva system podvojneho uctovnictva
    procedure SetAccountSys (pValue:boolean);
    function GetSpecSetting: Str3; // Je to skratka nazvu firmy, ktory ma specialne nastavenia v systeme NEX
    procedure SetSpecSetting (pValue:Str3);
    procedure SetMainWri (pValue:boolean); // Hlavna prevadzka - centrala
    function GetMainWri:boolean; // Hlavna prevadzka - centrala
    procedure SetMsgDisShow (pValue:boolean); // Moznost zakazania chybovych hlaseni
    function GetMsgDisShow:boolean; // Moznost zakazania chybovych hlaseni
    function GetNewOit:boolean; // Nova internetova komunikacia
    function GetEasLdg:boolean; // Jednoduche uctovnictvo
    function GetUnlckRsn:boolean; // Dovod odblokovania
    procedure SetCrpNum (pValue:word); // Cislo vlastnej firmy - pre centralnu statistiku
    function GetCrpNum:word; // Cislo vlastnej firmy - pre centralnu statistiku
    procedure SetCasioRcvPath (pValue:ShortString); // Adresar na prijatie udajov z terminalu CASIO
    function GetCasioRcvPath:ShortString; // Adresar na prijatie udajov z terminalu CASIO
    procedure SetCasioSndPath (pValue:ShortString); // Adresar na prijatie udajov z terminalu CASIO
    function GetCasioSndPath:ShortString; // Adresar na prijatie udajov z terminalu CASIO
    procedure SetCasioVariant (pValue:byte); // Varianta formatu komunikacnych suborov terminalu CASIO
    function GetCasioVariant:byte; // Varianta formatu komunikacnych suborov terminalu CASIO
    function GetAutoActDate:boolean; // Ak je TRUE system do kazdeho editora datumu ako zakldane nastavenie zapise aktualny datum
    function GetSabNewAcc:TDateTime; // Datum zaciatku noveho sposobu zauctovania trzby ERP

    function TsdLockAfterPrint: boolean; // Ak je TRUE potom system uzatvory jeho doklad po vytlaceni
    function TcdLockAfterPrint: boolean; // Ak je TRUE potom system uzatvory jeho doklad po vytlaceni
    function IsdLockAfterPrint: boolean; // Ak je TRUE potom system uzatvory jeho doklad po vytlaceni
    function IcdLockAfterPrint: boolean; // Ak je TRUE potom system uzatvory jeho doklad po vytlaceni

    procedure SetSelfDvzName (pValue:Str3); // Vlasnta uctovna mena
    procedure SetSelfStaCode (pValue:Str2); // Kod statu z evidencii statov, ktory je tuzemsko
    procedure SetSelfOldTin (pValue:Str15); // Stare DIC

    function GetStkClsDate: TDateTime;
    function GetSabClsDate: TDateTime;
    function GetAccClsDate: TDateTime;
    procedure SetStkClsDate (pDate:TDateTime);
    procedure SetSabClsDate (pDate:TDateTime);
    procedure SetAccClsDate (pDate:TDateTime);

    // STORES
    function  GetStkQntFract     : byte;         // Pocet desatinnych miest skladoveho mnozstva
    function  GetUseLastPrice    : boolean;      // Ak je TRUE system pouziva na cenotvorby poslednu NC, v opacnom pripade priemernu
    function  GetPlsNum (pSerNum:byte):word;     // Funkcia vrati cislo cennika zadanej cenovej urovne
    function  GetStkNum (pSerNum:byte):word;     // Funkcia vrati cislo skladu zadanej cenovej urovne
    function  GetInVatChg: boolean;              // Ak je TRUE je povolene zmenit sadzbu DPH v DDL a v DF
    function  GetOutVatChg: boolean;             // Ak je TRUE je povolene zmenit sadzbu DPH v ODL a v OF
    function  GetStkCodePrnShort : boolean;      // Ak je TRUE tlacova zostava ODL bude zotriedena podla skladoveho kodu
    function  GetStkCodeVerify   : boolean;      // Ak je TRUE systém kontroluje duplicitnost skladoveho kodu
    function  GetSaveStkToPls    : boolean;      // Ak je TRUE pri vykonani prijmu tovaru cez DDL system ulozi sklad prijmu do cennika
    function  GetIcPayDscPrc(Index:byte): double;// Zlava pro skorej platby
    function  GetBspActive       : boolean;      // Ak je TRUE to znamena ze tlacovy server etikiet je aktivny
    function  GetPccActive       :boolean;       // Zapinanie sledovanie obaloveho konta odberatelov
    function  GetPcsActive       :boolean;       // Zapinanie sledovanie obaloveho konta dodavatelov
    function  GetDepDscPrc       :double;        // Zavisly zisk - odpocita sa pri vystaveni faktur a DL od riadnej zlavy a uplatni sa pri zaplateni FA do splatnosti
    procedure SetNoActionDsc(pValue:boolean);    // Ak je TRUE na akciovy tovar sa neposkutuje zlava
    function  GetNoActionDsc     : boolean;      // Ak je TRUE na akciovy tovar sa neposkutuje zlava
    function  GetBarCodeGen      : boolean;      // Ak je TRUE program automaticky generuje interny csiarovy kod, opacnom pripade dosadi PLU
    function  GetAutoWpaMod      : boolean;      // Ak je TRU pri zmene partnera automaticky syst0m zmeni aj prijemcu
    function  GetPckOnlyEqMg     : boolean;      // Prebalenie tovaru len do rovnakych tovarovych skupin
    procedure SetIvImbNum   (pValue:Str5);       // Kniha prijmu inventarneho prebytku
    function  GetIvImbNum        : Str5;         // Kniha prijmu inventarneho prebytku
    procedure SetIvOmbNum   (pValue:Str5);       // Kniha vydaja inventarneho manka
    function  GetIvOmbNum        : Str5;         // Kniha vydaja inventarneho manka
    procedure SetStmPaName  (pValue:boolean);    // Ak je TRUE potom do skladovych pohybov system nacita aj meno firmy
    function  GetStmPaName       : boolean;      // Ak je TRUE potom do skladovych pohybov system nacita aj meno firmy
    procedure SetMainStk    (pValue:word);       // Cislo hlavneho skladu
    function  GetMainStk         : word;         // Cislo hlavneho skladu
    procedure SetMainPls (pValue:word);          // Cislo hlavneho cennika
    function  GetMainPls: word;                  // Cislo hlavneho cennika
    procedure SetAutoSavePkc(pValue:boolean);    // Ak je TRUE pri zadavani poloziek prebalenia system automaticky uklada prebalovaci koeficient
    function  GetAutoSavePkc     : boolean;      // Ak je TRUE pri zadavani poloziek prebalenia system automaticky uklada prebalovaci koeficient
    procedure SetTicExpDay  (pValue:word);       // Pocet dni po uhynuti
    function  GetTicExpDay       : word;         // Pocet dni po uhynuti
    procedure SetStcVerDifVal(pValue:double);    // Maximalna hodnota rozdielu pri kontrole skaldu
    function  GetStcVerDifVal    : double;       // Maximalna hodnota rozdielu pri kontrole skaldu
    procedure SetSavePlsToStk(pValue:boolean);   // Ak je TRUE ulozi zmeny predajne ceny na skladove karty zasob
    function  GetSavePlsToStk: boolean;          // Ak je TRUE ulozi zmeny predajne ceny na skladove karty zasob
    procedure SetAlbPenGsc(pValue:longint);      // Tovarove cislo penalizacnej polozky zapozicky naradia
    function  GetAlbPenGsc:longint;              // Tovarove cislo penalizacnej polozky zapozicky naradia
    procedure SetAlbPenPrc(pValue:byte);         // Percentualna hodnota penalizacie zapozicky naradia
    function  GetAlbPenPrc:byte;                 // Percentualna hodnota penalizacie zapozicky naradia
    procedure SetLinPacMod(pValue:boolean);      // System uklada posledneho dodavatelo do GSCAT
    function  GetLinPacMod: boolean;             // System uklada posledneho dodavatelo do GSCAT
    procedure SetFindBestSpa(pValue:boolean);    // Ak je TRUE pri spracovani objednavok vyhlada dodavatela s nejlepsou cenou
    function  GetFindBestSpa: boolean;           // Ak je TRUE pri spracovani objednavok vyhlada dodavatela s nejlepsou cenou

    function  GetIciPrnIndex:Str20; // Nazov indexu podla ktoreho budu trieden0 polozky vytlacenej OF
    function  GetTciPrnIndex:Str20; // Nazov indexu podla ktoreho budu trieden0 polozky vytlacenej OD
    function  GetOciPrnIndex:Str20; // Nazov indexu podla ktoreho budu trieden0 polozky vytlacenej ZK
    function  GetMciPrnIndex:Str20; // Nazov indexu podla ktoreho budu trieden0 polozky vytlacenej CP
    function  GetMySrCode:Str15;    // Vlastne cislo povolenie na predaj liehovych vyrobkov

    function GetImbBpcMod:boolean; // Moznost zmenit predajnu cenu
    // LEDGER
    procedure SetAccOldIcd (pValue:boolean); // Povolit rozu4tovanie starych OF
    function GetAccOldIcd:boolean; // Povolit rozu4tovanie starych OF
    procedure SetAccOldIsd (pValue:boolean); // Povolit rozu4tovanie starych DF
    function GetAccOldIsd:boolean; // Povolit rozu4tovanie starych DF
    function GetPdfValLim:double;  // Maximalna hodnota cenoveho rozdielu pri uhrady faktur
    function GetOpnSuvSnt:Str3; // Synteticky ucet otvorenia suvahovych uctov
    function GetOpnSuvAnl:Str6; // Analyticky ucet otvorenia suvahovych uctov
    function GetClsSuvSnt:Str3; // Synteticky ucet uzatvorenia suvahovych uctov
    function GetClsSuvAnl:Str6; // Analyticky ucet uzatvorenia suvahovych uctov
    function GetClsVysSnt:Str3; // Synteticky ucet uzatvorenia vysledovkovych uctov
    function GetClsVysAnl:Str6; // Analyticky ucet uzatvorenia vysledovkovych uctov
    function GetCrdPrfSnt:Str3; // Kurzovy zisk
    function GetCrdPrfAnl:Str6; // Kurzovy zisk
    function GetCrdLosSnt:Str3; // Kurzova strata
    function GetCrdLosAnl:Str6; // Kurzova strata
    function GetPdfYedSnt:Str3; // Ostatne financne vynosy
    function GetPdfYedAnl:Str6; // Ostatne financne vynosy
    function GetPdfCosSnt:Str3; // Ostatne financne naklady
    function GetPdfCosAnl:Str6; // Ostatne financne naklady
    function GetTsdRndSnt:Str3; // Cenovy rozdiel zo zaokruhlenia
    function GetTsdRndAnl:Str6; // Cenovy rozdiel zo zaokruhlenia
    procedure SetAutoCrdCalc (pValue:boolean); // Automaticky vypocet kurzoveho rozdielu
    function GetAutoCrdCalc:boolean; // Automaticke vypocet kurzoveho rozdielu
    procedure SetAutoPdfCalc (pValue:boolean); // Automaticky vypocet rozdielu uhrady
    function GetAutoPdfCalc:boolean; // Automaticke vypocet rozdielu uhrady
    procedure SetAccStk (pValue:boolean); // Rozuctovanie podla prevadzkovych jdnotiek
    function GetAccStk:boolean; // Rozuctovanie podla prevadzkovych jdnotiek
    procedure SetAccWri (pValue:boolean); // Rozuctovanie podla prevadzkovych jdnotiek
    function GetAccWri:boolean; // Rozuctovanie podla skladov
    procedure SetAccCen (pValue:boolean); // Rozuctovanie podla prevadzkovych jdnotiek
    function GetAccCen:boolean; // Rozuctovanie podla stredisk

    procedure SetExtAboDef (pValue:boolean); // Externa definicia zaucotvania ABO
    function GetExtAboDef:boolean; // Novy vykaz uzavierky DPH
    procedure SetNewVtrCls (pValue:boolean); // Novy vykaz uzavierky DPH
    function GetNewVtrCls:boolean; // Novy vykaz uzavierky DPH
    procedure SetUseAccTxt (pValue:boolean); // Pouzitie naznu analytickeho uctu pri zauctovani do UZ
    function GetUseAccTxt:boolean; // Pouzitie naznu analytickeho uctu pri zauctovani do UZ
    procedure SetSpvAutoAcc (pValue:boolean); // Automaticke rozuctovanie faktury za zalohovu platbu
    function GetSpvAutoAcc:boolean; // Automaticke rozuctovanie faktury za zalohovu platbu
    procedure SetSpvCrdSnt (pValue:Str3); // Synteticky ucet zauctovania danoveho dokladu zo zalohovych platoem - MD
    function GetSpvCrdSnt:Str3; // Synteticky ucet zauctovania danoveho dokladu zo zalohovych platoem - MD
    procedure SetSpvCrdAnl (pValue:Str6); // Analyticky ucet zauctovania danoveho dokladu zo zalohovych platoem - MD
    function GetSpvCrdAnl:Str6; // Analyticky ucet zauctovania danoveho dokladu zo zalohovych platoem - MD
    procedure SetSpvDebSnt (pValue:Str3); // Synteticky ucet zauctovania danoveho dokladu zo zalohovych platoem - DAL
    function GetSpvDebSnt:Str3; // Synteticky ucet zauctovania danoveho dokladu zo zalohovych platoem - DAL
    procedure SetSpvDebAnl (pValue:Str6); // Analyticky ucet zauctovania danoveho dokladu zo zalohovych platoem - DAL
    function GetSpvDebAnl:Str6; // Analyticky ucet zauctovania danoveho dokladu zo zalohovych platoem - DAL
    procedure SetBaPayCode (pValue:Str3); // Kod uhrady - bankovy prevodny
    function GetBaPayCode:Str3; // Kod uhrady - bankovy prevodny
    procedure SetCsPayCode (pValue:Str3); // Kod uhrady - uhrada v hotovosti
    function GetCsPayCode:Str3; // Kod uhrady - uhrada v hotovosti
    procedure SetAboSlsDelay(pValue:word); // Cakanie pre ABO certifikacie SLSP
    function GetAboSlsDelay:word; // Cakanie pre ABO certifikacie SLSP
    procedure SetVysResultLn(pValue:word); // Cislo riadky vysledovky kde je hospodarsky vysledok
    function GetVysResultLn:word; // Cislo riadky vysledovky kde je hospodarsky vysledok
    procedure SetSuvResultLn(pValue:word); // Cislo riadky vysledovky kde je hospodarsky vysledok
    function GetSuvResultLn:word; // Cislo riadky vysledovky kde je hospodarsky vysledok


    // Zaokruhlenie DF ako samostatna polozka
    procedure SetIsRndSnt (pValue:Str3); // Synteticky ucet zaokruhlenia DF
    function GetIsRndSnt:Str3; // Synteticky ucet zaokruhlenia DF
    procedure SetIsRndAnl (pValue:Str6); // Analyticky ucet zaokruhlenia DF
    function GetIsRndAnl:Str6; // Analyticky ucet zaokruhlenia DF
    procedure SetIsRndVal (pValue:double); // Horna hranica zaokruhlenia DF - potom uz ide cenovy rozdiel
    function GetIsRndVal:double; // Horna hranica zaokruhlenia DF - potom uz ide cenovy rozdiel
    // Cenovy rozdiel DF ako samostatna polozka
    procedure SetIsPdfSnt (pValue:Str3); // Synteticky ucet cenoveho rozdielu DF
    function GetIsPdfSnt:Str3; // Synteticky ucet cenoveho rozdielu DF
    procedure SetIsPdfAnl (pValue:Str6); // Analyticky ucet cenoveho rozdielu DF
    function GetIsPdfAnl:Str6; // Analyticky ucet cenoveho rozdielu DF
    // Zlava na DF ako samostatna polozka
    procedure SetIsDscSnt (pValue:Str3); // Ucet cenoveho rozdielu DF
    function GetIsDscSnt:Str3; // Ucet cenoveho rozdielu DF
    procedure SetIsDscAnl (pValue:Str6); // Analyticky ucet cenoveho rozdielu DF
    function GetIsDscAnl:Str6; // Analyticky ucet cenoveho rozdielu DF

    // CASSA
    procedure WriteBlkHeadLine (pCasNum,pLnNum:byte; pLine:Str40); // Ulozi hlavicku pokladnicneho dokladu
    procedure WriteBlkFootLine (pCasNum,pLnNum:byte; pLine:Str40); // Ulozi patu pokladnicneho dokladu
    function GetBlkHeadLine (pCasNum,pLnNum:byte):Str40; // Hlavicka pokladnicneho dokladu
    function GetBlkFootLine (pCasNum,pLnNum:byte):Str40; // Pata pokladnicneho dokladu
    function GetCasLanMod (pCasNum:byte):boolean; // Sietovy rezim registracnej pokladne

    // FTP
    function GetZipPath:string; // Pracovny adresar na loklanom dislu
    function GetComPath:string; // Cesta na prenos udajov
    procedure SetComPath (pPath:string); // Cesta na prenos udajov
    function GetAccFtpRcv:boolean; // Ak je TRUE potom system prenasa vsetky zmeny do uctovnictva
    procedure SetAccFtpRcv (pValue:boolean); // Ak je TRUE potom system prenasa vsetky zmeny do uctovnictva
    function GetArcTflSnd:boolean; // Ak je TRUE potom system prenasa subory cez priznak archive v opacnom pripade cez evidenciu prenesenych suborov
    procedure SetArcTflSnd (pValue:boolean); // Ak je TRUE potom system prenasa subory cez priznak archive v opacnom pripade cez evidenciu prenesenych suborov
    function GetOmdFtpSnd:boolean; // Ak je TRUE medziprevadzkovy presun (prijemka) je poslany cez FTP
    procedure SetOmdFtpSnd (pValue:boolean); // Ak je TRUE medziprevadzkovy presun (prijemka) je poslany cez FTP

    // FACTORING
    function GetMyBaContoFac:Str30; // Cislo uctu v pripade factoringu
    function GetMyBaNameFac:Str30;  // Nazov banky v pripade factoringu
    function GetMyBaCityFac:Str30;  // Sidlo banky v pripade factoringu
    procedure SetMyBaContoFac (pValue:Str30); // Cislo uctu v pripade factoringu
    procedure SetMyBaNameFac (pValue:Str30);  // Nazov banky v pripade factoringu
    procedure SetMyBaCityFac (pValue:Str30);  // Sidlo banky v pripade factoringu

    // ODBYT
    function GetBonAct:boolean; // Aktivacia bonusovej zlavy
    procedure SetBonAct (pValue:boolean); // Aktivacia bonusovej zlavy
    function GetBonVal:double; // Hodnota, od ktoreho plati bonusova akcia
    procedure SetBonVal (pValue:double); // Hodnota, od ktoreho plati bonusova akcia
    function GetBonNum:word; // Poradové èíslo akciového zoznamu pridaných položiek
    procedure SetBonNum (pValue:word); // Poradové èíslo akciového zoznamu pridaných položiek
    function GetBonDate:TDateTime; // Datum zahajenia akcie
    procedure SetBonDate (pValue:TDateTime); // Datum zahajenia akcie
    function GetBonType:word; // Typ ceny z ktorej sa pocita akcia
    procedure SetBonType (pValue:word); // Typ ceny z ktorej sa pocita akcia
    function GetBonGsd:longint; // PLU bonusovej zlavy
    procedure SetBonGsd (pValue:longint); // PLU bonusovej zlavy
    function GetBonGsi:ShortString; // Vymenovanie PLU poloziek z ktorej sa pocita bonusova zlava
    procedure SetBonGsi (pValue:ShortString); // Vymenovanie PLU poloziek z ktorej sa pocita bonusova zlava
    function GetModToDsc:boolean; // Vsetky zmeny PC zapocitat do zlavy
    procedure SetModToDsc (pValue:boolean); // Vsetky zmeny PC zapocitat do zlavy

    // TEMINAL
    function GetUdbInPath: string; // Adresar suboru DATA_IN.TXT
    function GetUdbOutPath: string; // Adresar suboru DATA_OUT.TXT
    function GetTrmType:byte;  // Typ pouzitej databanky
    procedure SetTrmType (pValue:byte);  // Typ pouzitej databanky

    // RNDITM
    function GetRndMgCode:longint; // Skupina polozky zaokruhlenia dokladu
    procedure SetRndMgCode (pValue:longint); // Skupina polozky zaokruhlenia dokladu
    function GetRndGsCode:longint; // PLU polozky zaokruhlenia dokladu
    procedure SetRndGsCode (pValue:longint); // PLU polozky zaokruhlenia dokladu
    function GetRndGsName:Str30; // Nazov polozky zaokruhlenia dokladu
    procedure SetRndGsName (pValue:Str30); // Nazov polozky zaokruhlenia dokladu


    public
      // SYSTEM
      property SelfDvzName:Str3 read GetSelfDvzName write SetSelfDvzName;
      property SelfStaCode:Str2 read GetSelfStaCode write SetSelfStaCode;
      property HideSaPrice:boolean read GetHideSaPrice;
      property AccountSys:boolean read GetAccountSys write SetAccountSys;
      property SpecSetting:Str3 read GetSpecSetting write SetSpecSetting;
      property MainWri:boolean read GetMainWri write SetMainWri; // Hlavna prevadzkova jednotka - centrala
      property MsgDisShow:boolean read GetMsgDisShow write SetMsgDisShow;
      property CrpNum:word read GetCrpNum write SetCrpNum;
      property EasLdg:boolean read GetEasLdg;
      property UnlckRsn:boolean read GetUnlckRsn;
      property CasioRcvPath:ShortString read GetCasioRcvPath write SetCasioRcvPath;
      property CasioSndPath:ShortString read GetCasioSndPath write SetCasioSndPath;
      property CasioVariant:byte read GetCasioVariant write SetCasioVariant;
      property AutoActDate:boolean read GetAutoActDate;

      // FTP
      property AccFtpRcv:boolean read GetAccFtpRcv write SetAccFtpRcv;
      property ArcTflSnd:boolean read GetArcTflSnd write SetArcTflSnd;
      property OmdFtpSnd:boolean read GetOmdFtpSnd write SetOmdFtpSnd;
      // STORES
      property ServiceMg:longint read GetServiceMg;
      property StkCodeVerify:boolean read GetStkCodeVerify;
      property StkCodePrnShort:boolean read GetStkCodePrnShort;
      property PdfValLim:double read GetPdfValLim;
      property OldVersion:boolean read GetOldVersion;
      property SaveStkToPls:boolean read GetSaveStkToPls;
      property IcPayDscPrc[Index:byte]:double read GetIcPayDscPrc;
      property PosRefresh:boolean read GetPosRefresh write SetPosRefresh;
      property PosRefFile:boolean read GetPosRefFile write SetPosRefFile;
      property TsbModifyBPrice:boolean read GetTsbModifyBPrice;
      property TsbShowBPrice:boolean read GetTsbShowBPrice;
      property BspActive:boolean read GetBspActive;
      property PccActive:boolean read GetPccActive;
      property PcaActive:boolean read GetPcsActive;
      property DepDscPrc:double read GetDepDscPrc; // Zavisly zisk - odpocita sa pri vystaveni faktur a DL od riadnej zlavy a uplatni sa pri zaplateni FA do splatnosti
      property NoActionDsc:boolean read GetNoActionDsc write SetNoActionDsc;
      property BarCodeGen:boolean read GetBarCodeGen;
      property AutoWpaMod:boolean read GetAutoWpaMod;
      property PckOnlyEqMg:boolean read GetPckOnlyEqMg; // Prebalenie tovaru len do rovnakych tovarovych skupin
      property IvImbNum:Str5 read GetIvImbNum write SetIvImbNum;
      property IvOmbNum:Str5 read GetIvOmbNum write SetIvOmbNum;
      property StmPaName:boolean read GetStmPaName write SetStmPaName;
      property MainStk:word read GetMainStk write SetMainStk;
      property MainPls:word read GetMainPls write SetMainPls;
      property AutoSavePkc:boolean read GetAutoSavePkc write SetAutoSavePkc;
      property TicExpDay:word read GetTicExpDay write SetTicExpDay;
      property StcVerDifVal:double read GetStcVerDifVal write SetStcVerDifVal;
      property IciPrnIndex:Str20 read GetIciPrnIndex;
      property TciPrnIndex:Str20 read GetTciPrnIndex;
      property OciPrnIndex:Str20 read GetOciPrnIndex;
      property MciPrnIndex:Str20 read GetMciPrnIndex;
      property MySrCode:Str15 read GetMySrCode;
      property SavePlsToStk:boolean read GetSavePlsToStk write SetSavePlsToStk;
      property AlbPenGsc:longint read GetAlbPenGsc write SetAlbPenGsc;
      property AlbPenPrc:byte read GetAlbPenPrc write SetAlbPenPrc;
      property LinPacMod:boolean read GetLinPacMod write SetLinPacMod;
      property FindBestSpa:boolean read GetFindBestSpa write SetFindBestSpa;

      // MOUNTFIELD

      // LEDGER
      property AccOldIcd:boolean read GetAccOldIcd;
      property AccOldIsd:boolean read GetAccOldIsd;
      property OpnSuvSnt:Str3 read GetOpnSuvSnt;
      property OpnSuvAnl:Str6 read GetOpnSuvAnl;
      property ClsSuvSnt:Str3 read GetClsSuvSnt;
      property ClsSuvAnl:Str6 read GetClsSuvAnl;
      property ClsVysSnt:Str3 read GetClsVysSnt;
      property ClsVysAnl:Str6 read GetClsVysAnl;
      property CrdPrfSnt:Str3 read GetCrdPrfSnt; // Kurzovy zisk
      property CrdPrfAnl:Str6 read GetCrdPrfAnl; // Kurzovy zisk
      property CrdLosSnt:Str3 read GetCrdLosSnt; // Kurzova strata
      property CrdLosAnl:Str6 read GetCrdLosAnl; // Kurzova strata
      property PdfYedSnt:Str3 read GetPdfYedSnt; // Ostatne financne vynosy
      property PdfYedAnl:Str6 read GetPdfYedAnl; // Ostatne financne vynosy
      property PdfCosSnt:Str3 read GetPdfCosSnt; // Ostatne financne naklady
      property PdfCosAnl:Str6 read GetPdfCosAnl; // Ostatne financne naklady
      property TsdRndSnt:Str3 read GetTsdRndSnt; // Cenovy rozdiel zo zaokruhlenia
      property TsdRndAnl:Str6 read GetTsdRndAnl; // Cenovy rozdiel zo zaokruhlenia
      property AutoCrdCalc:boolean read GetAutoCrdCalc write SetAutoCrdCalc;
      property AutoPdfCalc:boolean read GetAutoPdfCalc write SetAutoPdfCalc;
      property AccStk:boolean read GetAccStk write SetAccStk; // Rozuctovanie podla skladov
      property AccWri:boolean read GetAccWri write SetAccWri; // Rozuctovanie podla prevadzkovych jednotiek
      property AccCen:boolean read GetAccCen write SetAccCen; // Rozuctovanie podla stredisk
      property ExtAboDef:boolean read GetExtAboDef write SetExtAboDef;
      property NewVtrCls:boolean read GetNewVtrCls write SetNewVtrCls;
      property UseAccTxt:boolean read GetUseAccTxt write SetUseAccTxt;

      property AboSlsDelay:word read GetAboSlsDelay write SetAboSlsDelay;
      property VysResultLn:word read GetVysResultLn write SetVysResultLn;
      property SuvResultLn:word read GetSuvResultLn write SetSuvResultLn;

      property SpvAutoAcc:boolean read GetSpvAutoAcc write SetSpvAutoAcc;
      property SpvCrdSnt:Str3 read GetSpvCrdSnt write SetSpvCrdSnt;
      property SpvCrdAnl:Str6 read GetSpvCrdAnl write SetSpvCrdAnl;
      property SpvDebSnt:Str3 read GetSpvDebSnt write SetSpvDebSnt;
      property SpvDebAnl:Str6 read GetSpvDebAnl write SetSpvDebAnl;
      property BaPayCode:Str3 read GetBaPayCode write SetBaPayCode;
      property CsPayCode:Str3 read GetCsPayCode write SetCsPayCode;
      // Zaokruhlenie DF ako samostatna polozka
      property IsRndSnt:Str3 read GetIsRndSnt write SetIsRndSnt;
      property IsRndAnl:Str6 read GetIsRndAnl write SetIsRndAnl;
      property IsRndVal:double read GetIsRndVal write SetIsRndVal;
      // Zaokruhlenie DF ako samostatna polozka
      property IsPdfSnt:Str3 read GetIsPdfSnt write SetIsPdfSnt;
      property IsPdfAnl:Str6 read GetIsPdfAnl write SetIsPdfAnl;
      // Zlava na DF ako samostatna polozka
      property IsDscSnt:Str3 read GetIsDscSnt write SetIsDscSnt;
      property IsDscAnl:Str6 read GetIsDscAnl write SetIsDscAnl;
      // FACTORING
      property MyBaContoFac:Str30 read GetMyBaContoFac write SetMyBaContoFac;
      property MyBaNameFac:Str30 read GetMyBaNameFac write SetMyBaNameFac;
      property MyBaCityFac:Str30 read GetMyBaCityFac write SetMyBaCityFac;
      // ODBYT
      property BonAct:boolean read GetBonAct write SetBonAct; // Aktivacia bonusovej akcie
      property BonVal:double read GetBonVal write SetBonVal; // Hodnota, od ktoreho plati bonusova akcia
      property BonNum:word read GetBonNum write SetBonNum; // Poradové èíslo akciového zoznamu pridaných položiek
      property BonDate:TDateTime read GetBonDate write SetBonDate; // Datum zahajenia akcie
      property BonType:word read GetBonType write SetBonType; // Typ ceny z ktorej sa pocita akcia
      property BonGsd:longint read GetBonGsd write SetBonGsd; // PLU bonusovej zlavy
      property BonGsi:ShortString read GetBonGsi write SetBonGsi; // PLU poloziek z ktorej sa pocita bonusova zlava
      property ModToDsc:boolean read GetModToDsc write SetModToDsc; // Vsetky zmeny PC zapocitat do zlavy
      // TERMINAL
      property TrmType:byte read GetTrmType write SetTrmType;
      // RNDITM
      property RndMgCode:longint read GetRndMgCode write SetRndMgCode; // Skupina polozky zaokruhlenia dokladu
      property RndGsCode:longint read GetRndGsCode write SetRndGsCode; // PLU polozky zaokruhlenia dokladu
      property RndGsName:Str30 read GetRndGsName write SetRndGsName; // Nazov polozky zaokruhlenia dokladu

  end;

var gIni: TNexIni;   // Inicializacny subor NEX.INI
    gSet: TIniFile;  // Subor do ktoreho sa ukladaju nastavenia jednotlivych uzivatelov
    gFltIni: TFltIni;   // Subor do ktoreho sa ukladaju nastavenia filtrov

implementation

procedure TNexIni.WriteBlkHeadLine (pCasNum,pLnNum:byte; pLine:Str40); // Ulozi hlavicku pokladnicneho dokladu
begin
  WriteString ('CASSA'+StrInt(pCasNum,0),'HeadLine'+StrInt(pLnNum,0),pLine);
end;

procedure TNexIni.WriteBlkFootLine (pCasNum,pLnNum:byte; pLine:Str40); // Ulozi patu pokladnicneho dokladu
begin
  WriteString ('CASSA'+StrInt(pCasNum,0),'FootLine'+StrInt(pLnNum,0),pLine);
end;

function TNexIni.GetBetaTest:boolean;
begin
  If not ValueExists ('SYSTEM','BetaTest') then WriteBool ('SYSTEM','BetaTest',FALSE);
  Result := ReadBool ('SYSTEM','BetaTest',FALSE);
end;

function TNexIni.GetNewGscFrm:boolean;
begin
  If not ValueExists ('STORES','NewGscFrm') then WriteBool ('STORES','NewGscFrm',FALSE);
  Result := ReadBool ('STORES','NewGscFrm',FALSE);
end;

function TNexIni.GetNewApm:boolean; // Ak je TRUE pouziva sa novy pristup k modulom
begin
  If not ValueExists ('SYSTEM','NewApm') then WriteBool ('SYSTEM','NewApm',True);
  Result := ReadBool ('SYSTEM','NewApm',FALSE);
end;

function TNexIni.GetVatPrc (pVatGrp:byte): byte;
begin
  Result := 0;
  case pVatGrp of
    1: begin
         If not ValueExists ('SYSTEM','VatPrc1') then WriteInteger ('SYSTEM','VatPrc1',0);
         Result := ReadInteger ('SYSTEM','VatPrc1',0);
       end;
    2: begin
         If not ValueExists ('SYSTEM','VatPrc2') then WriteInteger ('SYSTEM','VatPrc2',20);
         Result := ReadInteger ('SYSTEM','VatPrc2',20);
       end;
    3: begin
         If not ValueExists ('SYSTEM','VatPrc3') then WriteInteger ('SYSTEM','VatPrc3',100);
         Result := ReadInteger ('SYSTEM','VatPrc3',100);
       end;
    4: begin
         If not ValueExists ('SYSTEM','VatPrc4') then WriteInteger ('SYSTEM','VatPrc4',100);
         Result := ReadInteger ('SYSTEM','VatPrc4',100);
       end;
    5: begin
         If not ValueExists ('SYSTEM','VatPrc5') then WriteInteger ('SYSTEM','VatPrc5',100);
         Result := ReadInteger ('SYSTEM','VatPrc5',100);
       end;
    6: begin
         If not ValueExists ('SYSTEM','VatPrc6') then WriteInteger ('SYSTEM','VatPrc6',100);
         Result := ReadInteger ('SYSTEM','VatPrc6',100);
       end;
  end;
end;

function TNexIni.GetSumVatPrc (pVatGrp:byte): byte;
begin
  Result := 0;
  case pVatGrp of
    1: begin
         If not ValueExists ('SYSTEM','SumVatPrc1') then WriteInteger ('SYSTEM','SumVatPrc1',0);
         Result := ReadInteger ('SYSTEM','SumVatPrc1',0);
       end;
    2: begin
         If not ValueExists ('SYSTEM','SumVatPrc2') then WriteInteger ('SYSTEM','SumVatPrc2',20);
         Result := ReadInteger ('SYSTEM','SumVatPrc2',20);
       end;
    3: begin
         If not ValueExists ('SYSTEM','SumVatPrc3') then WriteInteger ('SYSTEM','SumVatPrc3',19);
         Result := ReadInteger ('SYSTEM','SumVatPrc3',19);
       end;
    4: begin
         If not ValueExists ('SYSTEM','SumVatPrc4') then WriteInteger ('SYSTEM','VatPrc4',14);
         Result := ReadInteger ('SYSTEM','SumVatPrc4',14);
       end;
    5: begin
         If not ValueExists ('SYSTEM','SumVatPrc5') then WriteInteger ('SYSTEM','SumVatPrc5',20);
         Result := ReadInteger ('SYSTEM','SumVatPrc5',20);
       end;
    6: begin
         If not ValueExists ('SYSTEM','SumVatPrc6') then WriteInteger ('SYSTEM','SumVatPrc6',10);
         Result := ReadInteger ('SYSTEM','SumVatPrc6',10);
       end;
    7: begin
         If not ValueExists ('SYSTEM','SumVatPrc7') then WriteInteger ('SYSTEM','SumVatPrc7',23);
         Result := ReadInteger ('SYSTEM','SumVatPrc7',23);
       end;
    8: begin
         If not ValueExists ('SYSTEM','SumVatPrc8') then WriteInteger ('SYSTEM','SumVatPrc8',6);
         Result := ReadInteger ('SYSTEM','SumVatPrc8',6);
       end;
  end;
end;

function TNexIni.GetStaPath: string;
begin
  If not ValueExists ('SYSTEM','StaPath') then WriteString ('SYSTEM','StaPath','C:\NEX\STATIS\');
  Result := ReadString ('SYSTEM','StaPath','C:\NEX\STATIS\')
end;

function TNexIni.GetCasWorkDays: byte;
begin
  If not ValueExists ('SYSTEM','CasWorkDays') then WriteInteger ('SYSTEM','CasWorkDays',7);
  Result := ReadInteger ('SYSTEM','CasWorkDays',7)
end;

function TNexIni.GetDesignMode: boolean; // Ak je true modifikuju sa Dxx nastavenia v zoznamoch
begin
  If not ValueExists ('SYSTEM','DesignMode') then WriteBool ('SYSTEM','DesignMode',FALSE);
  Result := ReadBool ('SYSTEM','DesignMode',FALSE);
end;

function TNexIni.GetBlkHeadLine(pCasNum,pLnNum:byte):Str40;
begin
  Result := ReadString ('CASSA'+StrInt(pCasNum,0),'HeadLine'+StrInt(pLnNum,0),'');
end;

function TNexIni.GetBlkFootLine(pCasNum,pLnNum:byte):Str40;
begin
  Result := ReadString ('CASSA'+StrInt(pCasNum,0),'FootLine'+StrInt(pLnNum,0),'');
end;

function TNexIni.GetCasLanMod (pCasNum:byte):boolean; // Sietovy rezim registracnej pokladne
begin
  Result := ReadBool ('CASSA'+StrInt(pCasNum,0),'CasLanMod',FALSE);
end;

function TNexIni.GetSelfStaCode:Str2; // Kod statu z evidencii statov, ktory je tuzemsko
begin
  If not ValueExists ('SYSTEM','SelfStaCode') then WriteString ('SYSTEM','SelfStaCode','SK');
  Result := ReadString ('SYSTEM','SelfStaCode','SK');
end;

function TNexIni.GetSelfOldTin: Str15; // Stare DIC
begin
  If not ValueExists ('SYSTEM','SelfOldTin') then WriteString ('SYSTEM','SelfOldTin','');
  Result := ReadString ('SYSTEM','SelfOldTin','');
end;

function TNexIni.GetHideSaPrice: boolean; // Ak je TRUE system ukryje predajne ceny a zisk
begin
  If not ValueExists ('SYSTEM','HideSaPrice') then WriteBool ('SYSTEM','HideSaPrice',FALSE);
  Result := Readbool ('SYSTEM','HideSaPrice',FALSE);
end;

function TNexIni.GetPosRefresh: boolean; // Ak je TRUE potom system vytvara REF subory pre registracne pokladne
begin
  If not ValueExists ('STORES','PosRefresh') then WriteBool ('STORES','PosRefresh',FALSE);
  Result := Readbool ('STORES','PosRefresh',FALSE);
end;

procedure TNexIni.SetPosRefresh (pValue:boolean);
begin
  WriteBool ('STORES','PosRefresh',pValue);
end;

function TNexIni.GetPosRefFile: boolean; // Ak je TRUE potom system vytvara *.REF subory pre registracne pokladne v opacnom pripade .xxx
begin
  If not ValueExists ('STORES','PosRefFile') then WriteBool ('STORES','PosRefFile',TRUE);
  Result := Readbool ('STORES','PosRefFile',TRUE);
end;

procedure TNexIni.SetPosRefFile (pValue:boolean);
begin
  WriteBool ('STORES','PosRefFile',pValue);
end;

function TNexIni.GetTsbModifyBPrice: boolean; // Ak je TRUE potom system umozni zmenit predajnu cenu tovaru aj pri nadzovani poloziek DDL
begin
  If not ValueExists ('STORES','TsbModifyBPrice') then WriteBool ('STORES','TsbModifyBPrice',TRUE);
  Result := Readbool ('STORES','TsbModifyBPrice',TRUE);
end;

function TNexIni.GetTsbShowBPrice: boolean; // Ak je TRUE potom pri prijmu polozky zobrazi predajnu cenu a zisk
begin
  If not ValueExists ('STORES','TsbShowBPrice') then WriteBool ('STORES','TsbShowBPrice',TRUE);
  Result := Readbool ('STORES','TsbShowBPrice',TRUE);
end;

function TNexIni.GetDefSpvBook: Str5; // Zakladne nastavenie kniha faktur zalohovych platieb
begin
  If not ValueExists ('LEDGER','DefSpvBook') then WriteString ('LEDGER','DefSpvBook','A-001');
  Result := ReadString ('LEDGER','DefSpvBook','A-001');
end;

function TNexIni.GetAccountSys: boolean; // Ak je TRUE toz znamena ze sa pouziva system podvojneho uctovnictva
begin
  If not ValueExists ('SYSTEM','AccountSys') then WriteBool ('SYSTEM','AccountSys',TRUE);
  Result := Readbool ('SYSTEM','AccountSys',TRUE);
end;

procedure TNexIni.SetAccountSys (pValue:boolean);
begin
  WriteBool ('SYSTEM','AccountSys',pValue);
end;

function TNexIni.GetSpecSetting:Str3; // Je to skratka nazvu firmy, ktory ma specialne nastavenia v systeme NEX
begin
  If not ValueExists ('SYSTEM','SpecSetting') then WriteString ('SYSTEM','SpecSetting','');
  Result := ReadString ('SYSTEM','SpecSetting','');
end;

procedure TNexIni.SetSpecSetting (pValue:Str3);
begin
  WriteString ('SYSTEM','SpecSetting',pValue);
end;

function TNexIni.GetServiceMg:longint; // Cislo tovarovej skupiny od ktorej sa zacinaju sluzby
begin
  If not ValueExists ('SYSTEM','ServiceMg') then WriteInteger ('SYSTEM','ServiceMg',9000);
  Result := ReadInteger ('SYSTEM','ServiceMg',9000);
end;

function TNexIni.GetSpvMgCode:longint; // Cislo tovarovej skupiny od ktorej zalohovej platby
begin
  If not ValueExists ('SYSTEM','SpvMgCode') then WriteInteger ('SYSTEM','SpvMgCode',9000);
  Result := ReadInteger ('SYSTEM','SpvMgCode',9000);
end;

function TNexIni.GetVatPayType:byte; // Typ platitela DPH  0-neplatitel, 1-mesacna platca,, 2-stvrtrocna platca
begin
  If not ValueExists ('SYSTEM','VatPayType') then WriteInteger ('SYSTEM','VatPayType',1);
  Result := ReadInteger ('SYSTEM','VatPayType',1);
end;

procedure TNexIni.SetMainWri (pValue:boolean);
begin
  WriteBool ('SYSTEM','MainWri',pValue);
end;

function TNexIni.GetMainWri:boolean;
begin
  If not ValueExists ('SYSTEM','MainWri') then WriteBool ('SYSTEM','MainWri',FALSE);
  Result := ReadBool ('SYSTEM','MainWri',FALSE);
end;

procedure TNexIni.SetMsgDisShow (pValue:boolean); // Moznost zakazania chybovych hlaseni
begin
  WriteBool ('SYSTEM','MsgDisShow',pValue);
end;

function TNexIni.GetMsgDisShow:boolean; // Moznost zakazania chybovych hlaseni
begin
  If not ValueExists ('SYSTEM','MsgDisShow') then WriteBool ('SYSTEM','MsgDisShow',FALSE);
  Result := ReadBool ('SYSTEM','MsgDisShow',FALSE);
end;

function TNexIni.GetNewOit:boolean; // Nova internetova komunikacia
begin
  If not ValueExists ('SYSTEM','NewOit') then WriteBool ('SYSTEM','NewOit',FALSE);
  Result := ReadBool ('SYSTEM','NewOit',FALSE);
end;

function TNexIni.GetEasLdg:boolean; // Jednoduche uctovnictvo
begin
  If not ValueExists ('SYSTEM','EasLdg') then WriteBool ('SYSTEM','EasLdg',FALSE);
  Result := ReadBool ('SYSTEM','EasLdg',FALSE);
end;

function TNexIni.GetUnlckRsn:boolean; // Jednoduche uctovnictvo
begin
  If not ValueExists ('SYSTEM','UnlckRsn') then WriteBool ('SYSTEM','UnlckRsn',FALSE);
  Result := ReadBool ('SYSTEM','UnlckRsn',FALSE);
end;

procedure TNexIni.SetCrpNum (pValue:word);
begin
  WriteInteger ('SYSTEM','CrpNum',pValue);
end;

function TNexIni.GetCrpNum:word;
begin
  If not ValueExists ('SYSTEM','CrpNum') then WriteInteger ('SYSTEM','CrpNum',1);
  Result := ReadInteger ('SYSTEM','CrpNum',0);
end;

function TNexIni.GetStkQntFract:byte; // Pocet desatinnych miest skladoveho mnozstva
begin
  If not ValueExists ('STORES','StkQntFract') then WriteInteger ('STORES','StkQntFract',3);
  Result := ReadInteger ('STORES','StkQntFract',3);
end;

procedure TNexIni.SetCasioRcvPath (pValue:ShortString); // Adresar na prijatie udajov z terminalu CASIO
begin
  WriteString ('SYSTEM','CasioRcvPath',pValue);
end;

function TNexIni.GetCasioRcvPath:ShortString; // Adresar na prijatie udajov z terminalu CASIO
begin
  If not ValueExists ('SYSTEM','CasioRcvPath') then WriteString ('SYSTEM','CasioRcvPath','C:\CASIO\');
  Result := ReadString ('SYSTEM','CasioRcvPath','C:\CASIO\');
end;

procedure TNexIni.SetCasioSndPath (pValue:ShortString); // Adresar na prijatie udajov z terminalu CASIO
begin
  WriteString ('SYSTEM','CasioSndPath',pValue);
end;

function TNexIni.GetCasioSndPath:ShortString; // Adresar na prijatie udajov z terminalu CASIO
begin
  If not ValueExists ('SYSTEM','CasioSndPath') then WriteString ('SYSTEM','CasioSndPath','C:\CASIO\');
  Result := ReadString ('SYSTEM','CasioSndPath','C:\CASIO\');
end;

procedure TNexIni.SetCasioVariant (pValue:byte); // Varianta formatu komunikacnych suborov terminalu CASIO
begin
  WriteInteger ('SYSTEM','CasioVariant',pValue);
end;

function TNexIni.GetCasioVariant:byte; // Varianta formatu komunikacnych suborov terminalu CASIO
begin
  If not ValueExists ('SYSTEM','CasioVariant') then WriteInteger ('SYSTEM','CasioVariant',1);
  Result := ReadInteger ('SYSTEM','CasioVariant',1);
end;

function TNexIni.GetUseLastPrice:boolean; // Ak je TRUE system pouziva na cenotvorby poslednu NC, v opacnom pripade priemernu
begin
  If not ValueExists ('STORES','UseLastPrice') then WriteBool ('STORES','UseLastPrice',FALSE);
  Result := ReadBool ('STORES','UseLastPrice',FALSE);
end;

function TNexIni.GetPlsNum (pSerNum:byte):word; // Funkcia vrati cislo cennika zadanej cenovej urovne
begin
  If not ValueExists ('STORES','PlsNum'+StrInt(pSerNum,0)) then WriteInteger ('STORES','PlsNum'+StrInt(pSerNum,0),pSerNum);
  Result := ReadInteger ('STORES','PlsNum'+StrInt(pSerNum,0),pSerNum);
end;

function TNexIni.GetStkNum (pSerNum:byte):word; // Funkcia vrati cislo skladu zadanej cenovej urovne
begin
  If not ValueExists ('STORES','StkNum'+StrInt(pSerNum,0)) then WriteInteger ('STORES','StkNum'+StrInt(pSerNum,0),pSerNum);
  Result := ReadInteger ('STORES','StkNum'+StrInt(pSerNum,0),pSerNum);
end;

function TNexIni.GetSelfDvzName: Str3; // Uctovna mena
begin
  If not ValueExists ('SYSTEM','SelfDvzName') then WriteString ('SYSTEM','SelfDvzName','EUR');
  Result := ReadString ('SYSTEM','SelfDvzName','EUR');
end;

function TNexIni.GetInVatChg: boolean; // Ak je TRUE je povolene zmenit sadzbu DPH v DDL a v DF
begin
  If not ValueExists ('STORES','InVatChg') then WriteBool ('STORES','InVatChg',FALSE);
  Result := ReadBool ('STORES','InVatChg',FALSE);
end;

function TNexIni.GetOutVatChg:boolean; // Ak je TRUE je povolene zmenit sadzbu DPH v ODL a v OF
begin
  If not ValueExists ('STORES','OutVatChg') then WriteBool ('STORES','OutVatChg',FALSE);
  Result := ReadBool ('STORES','OutVatChg',FALSE);
end;

function TNexIni.GetStkCodePrnShort: boolean; // Ak je TRUE tlacova zostava ODL bude zotriedena podla skladoveho kodu
begin
  If not ValueExists ('STORES','StkCodePrnShort') then WriteBool ('STORES','StkCodePrnShort',FALSE);
  Result := ReadBool ('STORES','StkCodePrnShort',FALSE);
end;

function TNexIni.GetStkCodeVerify: boolean; // Ak je TRUE systém kontroluje duplicitnost skladoveho kodu
begin
  If not ValueExists ('STORES','StkCodeVerify') then WriteBool ('STORES','StkCodeVerify',TRUE);
  Result := ReadBool ('STORES','StkCodeVerify',TRUE);
end;

function TNexIni.GetSaveStkToPls: boolean; // Ak je TRUE pri vykonani prijmu tovaru cez DDL system ulozi sklad prijmu do cennika
begin
  If not ValueExists ('STORES','SaveStkToPls') then WriteBool ('STORES','SaveStkToPls',FALSE);
  Result := ReadBool ('STORES','SaveStkToPls',FALSE);
end;

function TNexIni.GetIcPayDscPrc(Index:byte): double; // Zlava pro skorej platby
begin
  If not ValueExists ('STORES','IcPayDscPrc'+StrInt(Index,1)) then WriteInteger ('STORES','IcPayDscPrc'+StrInt(Index,1),0);
  Result := ReadInteger ('STORES','IcPayDscPrc'+StrInt(Index,1),0);
end;

function TNexIni.GetBspActive: boolean; // Ak je TRUE to znamena ze tlacovy server etikiet je aktivny
begin
  If not ValueExists ('STORES','BspActive') then WriteBool ('STORES','BspActive',FALSE);
  Result := Readbool ('STORES','BspActive',FALSE);
end;

function TNexIni.GetPccActive:boolean; // Zapinanie sledovanie obaloveho konta odberatelov
begin
  If not ValueExists ('STORES','PccActive') then WriteBool ('STORES','PccActive',FALSE);
  Result := Readbool ('STORES','PccActive',FALSE);
end;

function TNexIni.GetPcsActive:boolean; // Zapinanie sledovanie obaloveho konta dodavatelov
begin
  If not ValueExists ('STORES','PcsActive') then WriteBool ('STORES','PcsActive',FALSE);
  Result := Readbool ('STORES','PcsActive',FALSE);
end;

function TNexIni.GetDepDscPrc:double; // Zavisly zisk - odpocita sa pri vystaveni faktur a DL od riadnej zlavy a uplatni sa pri zaplateni FA do splatnosti
begin
  If not ValueExists ('STORES','DepDscPrc') then WriteFloat ('STORES','DepDscPrc',0);
  Result := ReadFloat ('STORES','DepDscPrc',0);
end;

procedure TNexIni.SetNoActionDsc (pValue:boolean);  // Ak je TRUE na akciovy tovar sa neposkutuje zlava
begin
  WriteBool ('STORES','NoActionDsc',pValue);
end;

function TNexIni.GetNoActionDsc: boolean; // Ak je TRUE na akciovy tovar sa neposkutuje zlava
begin
  If not ValueExists ('STORES','NoActionDsc') then WriteBool ('STORES','NoActionDsc',TRUE);
  Result := ReadBool ('STORES','NoActionDsc',TRUE);
end;

function TNexIni.GetBarCodeGen: boolean; // Ak je TRUE program automaticky generuje interny csiarovy kod, opacnom pripade dosadi PLU
begin
  If not ValueExists ('STORES','BarCodeGen') then WriteBool ('STORES','BarCodeGen',TRUE);
  Result := ReadBool ('STORES','BarCodeGen',TRUE);
end;

function TNexIni.GetAutoWpaMod: boolean; // Ak je TRU pri zmene partnera automaticky syst0m zmeni aj prijemcu
begin
  If not ValueExists ('STORES','AutoWpaMod') then WriteBool ('STORES','AutoWpaMod',TRUE);
  Result := ReadBool ('STORES','AutoWpaMod',TRUE);
end;

function TNexIni.GetImbBpcMod:boolean; // Moznost zmenit predajnu cenu
begin
  If not ValueExists ('STORES','ImbBpcMod') then WriteBool ('STORES','ImbBpcMod',FALSE);
  Result := ReadBool ('STORES','ImbBpcMod',FALSE);
end;

// ****************************
//           STORES
// ****************************

function TNexIni.GetPckOnlyEqMg: boolean; // Prebalenie tovaru len do rovnakych tovarovych skupin
begin
  If not ValueExists ('STORES','PckOnlyEqMg') then WriteBool ('STORES','PckOnlyEqMg',FALSE);
  Result := ReadBool ('STORES','PckOnlyEqMg',FALSE);
end;

procedure TNexIni.SetIvImbNum(pValue:Str5); // Kniha prijmu inventarneho prebytku
begin
  WriteString ('STORES','IvImbNum',pValue);
end;

function TNexIni.GetIvImbNum: Str5; // Kniha prijmu inventarneho prebytku
begin
  If not ValueExists ('STORES','IvImbNum') then WriteString ('STORES','IvImbNum','');
  Result := ReadString ('STORES','IvImbNum','');
end;

procedure TNexIni.SetIvOmbNum(pValue:Str5); // Kniha vydaja inventarneho manka
begin
  WriteString ('STORES','IvOmbNum',pValue);
end;

function TNexIni.GetIvOmbNum: Str5; // Kniha vydaja inventarneho manka
begin
  If not ValueExists ('STORES','IvOmbNum') then WriteString ('STORES','IvOmbNum','');
  Result := ReadString ('STORES','IvOmbNum','');
end;

procedure TNexIni.SetStmPaName (pValue:boolean);  // Ak je TRUE potom do skladovych pohybov system nacita aj meno firmy
begin
  WriteBool ('STORES','StmPaName',pValue);
end;

function TNexIni.GetStmPaName: boolean; // Ak je TRUE potom do skladovych pohybov system nacita aj meno firmy
begin
  If not ValueExists ('STORES','StmPaName') then WriteBool ('STORES','StmPaName',TRUE);
  Result := ReadBool ('STORES','StmPaName',TRUE);
end;

procedure TNexIni.SetMainStk (pValue:word);  // Ak je TRUE potom do skladovych pohybov system nacita aj meno firmy
begin
  WriteInteger ('STORES','MainStk',pValue);
end;

function TNexIni.GetMainStk: word; // Ak je TRUE potom do skladovych pohybov system nacita aj meno firmy
begin
  If not ValueExists ('STORES','MainStk') then WriteInteger ('STORES','MainStk',1);
  Result := ReadInteger ('STORES','MainStk',1);
end;

procedure TNexIni.SetMainPls (pValue:word);  // Ak je TRUE potom do skladovych pohybov system nacita aj meno firmy
begin
  WriteInteger ('STORES','MainPls',pValue);
end;

function TNexIni.GetMainPls: word; // Ak je TRUE potom do skladovych pohybov system nacita aj meno firmy
begin
  If not ValueExists ('STORES','MainPls') then WriteInteger ('STORES','MainPls',1);
  Result := ReadInteger ('STORES','MainPls',1);
end;

procedure TNexIni.SetTicExpDay (pValue:word);  // pocet dni po uhynuti
begin
  WriteInteger ('STORES','TicExpDay',pValue);
end;

function TNexIni.GetTicExpDay: word; // pocet dni po uhynuti
begin
  If not ValueExists ('STORES','TicExpDay') then WriteInteger ('STORES','TicExpDay',0);
  Result := ReadInteger ('STORES','TicExpDay',0);
end;

procedure TNexIni.SetAutoSavePkc (pValue:boolean);  // Ak je TRUE pri zadavani poloziek prebalenia system automaticky uklada prebalovaci koeficient
begin
  WriteBool ('STORES','AutoSavePkc',pValue);
end;

function TNexIni.GetAutoSavePkc: boolean; // Ak je TRUE pri zadavani poloziek prebalenia system automaticky uklada prebalovaci koeficient
begin
  If not ValueExists ('STORES','AutoSavePkc') then WriteBool ('STORES','AutoSavePkc',FALSE);
  Result := ReadBool ('STORES','AutoSavePkc',FALSE);
end;

procedure TNexIni.SetSavePlsToStk (pValue:boolean);  // Ak je TRUE ulozi zmeny predajne ceny na skladove karty zasob
begin
  WriteBool ('STORES','SavePlsToStk',pValue);
end;

function TNexIni.GetSavePlsToStk: boolean; // Ak je TRUE ulozi zmeny predajne ceny na skladove karty zasob
begin
  If not ValueExists ('STORES','SavePlsToStk') then WriteBool ('STORES','SavePlsToStk',TRUE);
  Result := ReadBool ('STORES','SavePlsToStk',TRUE);
end;

procedure TNexIni.SetAlbPenGsc(pValue:longint);  // Tovarove cislo penalizacnej polozky zapozicky naradia
begin
  WriteInteger ('STORES','AlbPenGsc',pValue);
end;

function TNexIni.GetAlbPenGsc:longint; // Tovarove cislo penalizacnej polozky zapozicky naradia
begin
  If not ValueExists ('STORES','AlbPenGsc') then WriteInteger ('STORES','AlbPenGsc',0);
  Result := ReadInteger ('STORES','AlbPenGsc',0);
end;

procedure TNexIni.SetAlbPenPrc(pValue:byte);  // Percentualna hodnota penalizacie zapozicky naradia
begin
  WriteInteger ('STORES','AlbPenPrc',pValue);
end;

function TNexIni.GetAlbPenPrc:byte; // Percentualna hodnota penalizacie zapozicky naradia
begin
  If not ValueExists ('STORES','AlbPenPrc') then WriteInteger ('STORES','AlbPenPrc',1);
  Result := ReadInteger ('STORES','AlbPenPrc',1);
end;

procedure TNexIni.SetLinPacMod (pValue:boolean);      // System uklada posledneho dodavatelo do GSCAT
begin
  WriteBool ('STORES','LinPacMod',pValue);
end;

function  TNexIni.GetLinPacMod: boolean;             // System uklada posledneho dodavatelo do GSCAT
begin
  If not ValueExists ('STORES','LinPacMod') then WriteBool ('STORES','LinPacMod',FALSE);
  Result := ReadBool ('STORES','LinPacMod',FALSE);
end;

procedure TNexIni.SetStcVerDifVal (pValue:double);  // Maximalna hodnota rozdielu pri kontrole skaldu
begin
  WriteFloat ('STORES','StcVerDifVal',pValue);
end;

function  TNexIni.GetFindBestSpa: boolean;           // Ak je TRUE pri spracovani objednavok vyhlada dodavatela s nejlepsou cenou
begin
  If not ValueExists ('STORES','FindBestSpa') then WriteBool ('STORES','FindBestSpa',TRUE);
  Result := ReadBool ('STORES','FindBestSpa',TRUE);
end;

procedure TNexIni.SetFindBestSpa(pValue:boolean);    // Ak je TRUE pri spracovani objednavok vyhlada dodavatela s nejlepsou cenou
begin
  WriteBool ('STORES','FindBestSpa',pValue);
end;

function TNexIni.GetStcVerDifVal: double; // Maximalna hodnota rozdielu pri kontrole skaldu
begin
  If not ValueExists ('STORES','StcVerDifVal') then WriteFloat ('STORES','StcVerDifVal',0.1);
  Result := ReadFloat ('STORES','StcVerDifVal',0.1);
end;

function TNexIni.GetIciPrnIndex:Str20; // Nazov indexu podla ktoreho budu triedene polozky vytlacenej OF
begin
  If not ValueExists ('STORES','IciPrnIndex') then WriteString ('STORES','IciPrnIndex','');
  Result := ReadString ('STORES','IciPrnIndex','');
end;

function TNexIni.GetTciPrnIndex:Str20; // Nazov indexu podla ktoreho budu triedene polozky vytlacenej OD
begin
  If not ValueExists ('STORES','TciPrnIndex') then WriteString ('STORES','TciPrnIndex','');
  Result := ReadString ('STORES','TciPrnIndex','');
end;

function TNexIni.GetOciPrnIndex:Str20; // Nazov indexu podla ktoreho budu triedene polozky vytlacenej ZK
begin
  If not ValueExists ('STORES','OciPrnIndex') then WriteString ('STORES','OciPrnIndex','');
  Result := ReadString ('STORES','OciPrnIndex','');
end;

function TNexIni.GetMciPrnIndex:Str20; // Nazov indexu podla ktoreho budu triedene polozky vytlacenej CP
begin
  If not ValueExists ('STORES','MciPrnIndex') then WriteString ('STORES','MciPrnIndex','');
  Result := ReadString ('STORES','MciPrnIndex','');
end;

function TNexIni.GetMySrCode:Str15; // Vlastne cislo povolenie na predaj liehovych vyrobkov
begin
  If not ValueExists ('STORES','MySrCode') then WriteString ('STORES','MySrCode','');
  Result := ReadString ('STORES','MySrCode','');
end;

function TNexIni.GetPdfValLim: double; // Maximalna hodnota cenoveho rozdielu pri uhrady faktur
begin
  If not ValueExists ('LEDGER','PdfValLimit') then WriteFloat ('LEDGER','PdfValLimit',10);
  Result := ReadFloat ('LEDGER','PdfValLimit',10);
end;

function TNexIni.GetAccOldIcd: boolean; // Ak je TRUE potom system povoli rozuctovat stare OF do pocittocneho stavu
begin
  If not ValueExists ('LEDGER','AccOldIcd') then WriteBool ('LEDGER','AccOldIcd',FALSE);
  Result := Readbool ('LEDGER','AccOldIcd',FALSE);
end;

procedure TNexIni.SetAccOldIcd (pValue:boolean);
begin
  WriteBool ('LEDGER','AccOldIcd',pValue);
end;

function TNexIni.GetAccOldIsd: boolean; // Ak je TRUE potom system povoli rozuctovat stare DF do pocittocneho stavu
begin
  If not ValueExists ('LEDGER','AccOldIsd') then WriteBool ('LEDGER','AccOldIsd',FALSE);
  Result := Readbool ('LEDGER','AccOldIsd',FALSE);
end;

procedure TNexIni.SetAccOldIsd (pValue:boolean);
begin
  WriteBool ('LEDGER','AccOldIsd',pValue);
end;

function TNexIni.GetOpnSuvSnt:Str3; // Synteticky ucet otvorenia suvahovych uctov
begin
  If not ValueExists ('LEDGER','OpnSuvSnt') then WriteString ('LEDGER','OpnSuvSnt','701');
  Result := ReadString ('LEDGER','OpnSuvSnt','701');
end;

function TNexIni.GetOpnSuvAnl:Str6; // Analyticky ucet otvorenia suvahovych uctov
begin
  If not ValueExists ('LEDGER','OpnSuvAnl') then WriteString ('LEDGER','OpnSuvAnl','000100');
  Result := ReadString ('LEDGER','OpnSuvAnl','000100');
end;

function TNexIni.GetClsSuvSnt:Str3; // Synteticky ucet uzatvorenia suvahovych uctov
begin
  If not ValueExists ('LEDGER','ClsSuvSnt') then WriteString ('LEDGER','ClsSuvSnt','702');
  Result := ReadString ('LEDGER','ClsSuvSnt','702');
end;

function TNexIni.GetClsSuvAnl:Str6; // Analyticky ucet uzatvorenia suvahovych uctov
begin
  If not ValueExists ('LEDGER','ClsSuvAnl') then WriteString ('LEDGER','ClsSuvAnl','000100');
  Result := ReadString ('LEDGER','ClsSuvAnl','000100');
end;

function TNexIni.GetClsVysSnt:Str3; // Synteticky ucet uzatvorenia vysledovkovych uctov
begin
  If not ValueExists ('LEDGER','ClsVysSnt') then WriteString ('LEDGER','ClsVysSnt','710');
  Result := ReadString ('LEDGER','ClsVysSnt','710');
end;

function TNexIni.GetClsVysAnl:Str6; // Analyticky ucet uzatvorenia vysledovkovych uctov
begin
  If not ValueExists ('LEDGER','ClsVysAnl') then WriteString ('LEDGER','ClsVysAnl','000100');
  Result := ReadString ('LEDGER','ClsVysAnl','000100');
end;

function TNexIni.GetCrdPrfSnt:Str3; // Kurzovy zisk
begin
  If not ValueExists ('LEDGER','CrdPrfSnt') then WriteString ('LEDGER','CrdPrfSnt','663');
  Result := ReadString ('LEDGER','CrdPrfSnt','663');
end;

function TNexIni.GetCrdPrfAnl:Str6; // Kurzovy zisk
begin
  If not ValueExists ('LEDGER','CrdPrfAnl') then WriteString ('LEDGER','CrdPrfAnl','000100');
  Result := ReadString ('LEDGER','CrdPrfAnl','000100');
end;

function TNexIni.GetCrdLosSnt:Str3; // Kurzova strata
begin
  If not ValueExists ('LEDGER','CrdLosSnt') then WriteString ('LEDGER','CrdLosSnt','563');
  Result := ReadString ('LEDGER','CrdLosSnt','563');
end;

function TNexIni.GetCrdLosAnl:Str6; // Kurzova strata
begin
  If not ValueExists ('LEDGER','CrdLosAnl') then WriteString ('LEDGER','CrdLosAnl','000100');
  Result := ReadString ('LEDGER','CrdLosAnl','000100');
end;

function TNexIni.GetPdfYedSnt:Str3; // Ostatne financne vynosy
begin
  If not ValueExists ('LEDGER','PdfYedSnt') then WriteString ('LEDGER','PdfYedSnt','668');
  Result := ReadString ('LEDGER','PdfYedSnt','648');
end;

function TNexIni.GetPdfYedAnl:Str6; // Kurzovy zisk
begin
  If not ValueExists ('LEDGER','PdfYedAnl') then WriteString ('LEDGER','PdfYedAnl','000100');
  Result := ReadString ('LEDGER','PdfYedAnl','000100');
end;

function TNexIni.GetPdfCosSnt:Str3; // Kurzova strata
begin
  If not ValueExists ('LEDGER','PdfCosSnt') then WriteString ('LEDGER','PdfCosSnt','568');
  Result := ReadString ('LEDGER','PdfCosSnt','548');
end;

function TNexIni.GetPdfCosAnl:Str6; // Kurzova strata
begin
  If not ValueExists ('LEDGER','PdfCosAnl') then WriteString ('LEDGER','PdfCosAnl','000100');
  Result := ReadString ('LEDGER','PdfCosAnl','000100');
end;

function TNexIni.GetTsdRndSnt:Str3; // Cenovy rozdiel zo zaokruhlenia
begin
  If not ValueExists ('LEDGER','TsdRndSnt') then WriteString ('LEDGER','TsdRndSnt','132');
  Result := ReadString ('LEDGER','TsdRndSnt','132');
end;

function TNexIni.GetTsdRndAnl:Str6; // Cenovy rozdiel zo zaokruhlenia
begin
  If not ValueExists ('LEDGER','TsdRndAnl') then WriteString ('LEDGER','TsdRndAnl','000900');
  Result := ReadString ('LEDGER','TsdRndAnl','000900');
end;

procedure TNexIni.SetAutoCrdCalc (pValue:boolean);
begin
  WriteBool ('LEDGER','AutoCrdCalc',pValue);
end;

function TNexIni.GetAutoCrdCalc:boolean;
begin
  If not ValueExists ('LEDGER','AutoCrdCalc') then WriteBool ('LEDGER','AutoCrdCalc',TRUE);
  Result := ReadBool ('LEDGER','AutoCrdCalc',TRUE);
end;

procedure TNexIni.SetAutoPdfCalc (pValue:boolean);
begin
  WriteBool ('LEDGER','AutoPdfCalc',pValue);
end;

function TNexIni.GetAutoPdfCalc:boolean;
begin
  If not ValueExists ('LEDGER','AutoPdfCalc') then WriteBool ('LEDGER','AutoPdfCalc',TRUE);
  Result := ReadBool ('LEDGER','AutoPdfCalc',TRUE);
end;

procedure TNexIni.SetAccStk (pValue:boolean);
begin
  WriteBool ('LEDGER','AccStk',pValue);
end;

function TNexIni.GetAccStk:boolean;
begin
  If not ValueExists ('LEDGER','AccStk') then WriteBool ('LEDGER','AccStk',FALSE);
  Result := ReadBool ('LEDGER','AccStk',FALSE);
end;

procedure TNexIni.SetAccWri (pValue:boolean);
begin
  WriteBool ('LEDGER','AccWri',pValue);
end;

function TNexIni.GetAccWri:boolean;
begin
  If not ValueExists ('LEDGER','AccWri') then WriteBool ('LEDGER','AccWri',FALSE);
  Result := ReadBool ('LEDGER','AccWri',FALSE);
end;

procedure TNexIni.SetAccCen (pValue:boolean);
begin
  WriteBool ('LEDGER','AccCen',pValue);
end;

function TNexIni.GetAccCen:boolean;
begin
  If not ValueExists ('LEDGER','AccCen') then WriteBool ('LEDGER','AccCen',FALSE);
  Result := ReadBool ('LEDGER','AccCen',FALSE);
end;

procedure TNexIni.SetExtAboDef (pValue:boolean); // Externa definicia zaucotvania ABO
begin
  WriteBool ('LEDGER','ExtAboDef',pValue);
end;

function TNexIni.GetExtAboDef:boolean; // Novy vykaz uzavierky DPH
begin
  If not ValueExists ('LEDGER','ExtAboDef') then WriteBool ('LEDGER','ExtAboDef',FALSE);
  Result := ReadBool ('LEDGER','ExtAboDef',FALSE);
end;

procedure TNexIni.SetNewVtrCls (pValue:boolean);
begin
  WriteBool ('LEDGER','NewVtrCls',pValue);
end;

function TNexIni.GetNewVtrCls:boolean;
begin
  If not ValueExists ('LEDGER','NewVtrCls') then WriteBool ('LEDGER','NewVtrCls',FALSE);
  Result := ReadBool ('LEDGER','NewVtrCls',FALSE);
end;

procedure TNexIni.SetUseAccTxt (pValue:boolean);
begin
  WriteBool ('LEDGER','UseAccTxt',pValue);
end;

function TNexIni.GetUseAccTxt:boolean;
begin
  If not ValueExists ('LEDGER','UseAccTxt') then WriteBool ('LEDGER','UseAccTxt',FALSE);
  Result := ReadBool ('LEDGER','UseAccTxt',FALSE);
end;

procedure TNexIni.SetSpvAutoAcc (pValue:boolean);
begin
  WriteBool ('LEDGER','SpvAutoAcc',pValue);
end;

function TNexIni.GetSpvAutoAcc:boolean; // Automaticke rozuctovanie faktury za zalohovu platbu
begin
  If not ValueExists ('LEDGER','SpvAutoAcc') then WriteBool ('LEDGER','SpvAutoAcc',FALSE);
  Result := ReadBool ('LEDGER','SpvAutoAcc',FALSE);
end;

procedure TNexIni.SetSpvCrdSnt (pValue:Str3);
begin
  WriteString ('LEDGER','SpvCrdSnt',pValue);
end;

function TNexIni.GetSpvCrdSnt:Str3; // Synteticky ucet zauctovania danoveho dokladu zo zalohovych platoem - MD
begin
  If not ValueExists ('LEDGER','SpvCrdSnt') then WriteString ('LEDGER','SpvCrdSnt','324');
  Result := ReadString ('LEDGER','SpvCrdSnt','324');
end;

procedure TNexIni.SetSpvCrdAnl (pValue:Str6);
begin
  WriteString ('LEDGER','SpvCrdAnl',pValue);
end;

function TNexIni.GetSpvCrdAnl:Str6; // Analyticky ucet zauctovania danoveho dokladu zo zalohovych platoem - MD
begin
  If not ValueExists ('LEDGER','SpvCrdAnl') then WriteString ('LEDGER','SpvCrdAnl','000100');
  Result := ReadString ('LEDGER','SpvCrdAnl','000100');
end;

procedure TNexIni.SetSpvDebSnt (pValue:Str3);
begin
  WriteString ('LEDGER','SpvDebSnt',pValue);
end;

function TNexIni.GetSpvDebSnt:Str3; // Synteticky ucet zauctovania danoveho dokladu zo zalohovych platoem - MD
begin
  If not ValueExists ('LEDGER','SpvDebSnt') then WriteString ('LEDGER','SpvDebSnt','343');
  Result := ReadString ('LEDGER','SpvDebSnt','343');
end;

procedure TNexIni.SetSpvDebAnl (pValue:Str6);
begin
  WriteString ('LEDGER','SpvDebAnl',pValue);
end;

function TNexIni.GetSpvDebAnl:Str6; // Analyticky ucet zauctovania danoveho dokladu zo zalohovych platoem - MD
begin
  If not ValueExists ('LEDGER','SpvDebAnl') then WriteString ('LEDGER','SpvDebAnl','000019');
  Result := ReadString ('LEDGER','SpvDebAnl','000019');
end;

procedure TNexIni.SetBaPayCode (pValue:Str3); // Kod uhrady - bankovy prevodny
begin
  WriteString ('LEDGER','BaPayCode',pValue);
end;

function TNexIni.GetBaPayCode:Str3; // Kod uhrady - bankovy prevodny
begin
  If not ValueExists ('LEDGER','BaPayCode') then WriteString ('LEDGER','BaPayCode','pp');
  Result := ReadString ('LEDGER','BaPayCode','pp');
end;

procedure TNexIni.SetCsPayCode (pValue:Str3); // Kod uhrady - uhrada v hotovosti
begin
  WriteString ('LEDGER','CsPayCode',pValue);
end;

function TNexIni.GetCsPayCode:Str3; // Kod uhrady - uhrada v hotovosti
begin
  If not ValueExists ('LEDGER','CsPayCode') then WriteString ('LEDGER','CsPayCode','h');
  Result := ReadString ('LEDGER','CsPayCode','h');
end;

procedure TNexIni.SetAboSlsDelay (pValue:word);
begin
  WriteInteger ('LEDGER','AboSlsDelay',pValue);
end;

function TNexIni.GetAboSlsDelay:word;
begin
  If not ValueExists ('LEDGER','AboSlsDelay') then WriteInteger ('LEDGER','AboSlsDelay',0);
  Result := ReadInteger ('LEDGER','AboSlsDelay',0);
end;

procedure TNexIni.SetVysResultLn (pValue:word);
begin
  WriteInteger ('LEDGER','VysResultLn',pValue);
end;

function TNexIni.GetVysResultLn:word;
begin
  If not ValueExists ('LEDGER','VysResultLn') then WriteInteger ('LEDGER','VysResultLn',57);
  Result := ReadInteger ('LEDGER','VysResultLn',57);
end;

procedure TNexIni.SetSuvResultLn (pValue:word);
begin
  WriteInteger ('LEDGER','SuvResultLn',pValue);
end;

function TNexIni.GetSuvResultLn:word;
begin
  If not ValueExists ('LEDGER','SuvResultLn') then WriteInteger ('LEDGER','SuvResultLn',85);
  Result := ReadInteger ('LEDGER','SuvResultLn',85);
end;

procedure TNexIni.SetIsRndSnt (pValue:Str3);
begin
  WriteString ('LEDGER','IsRndSnt',pValue);
end;

function TNexIni.GetIsRndSnt:Str3; // Synteticky ucet zauctovania danoveho dokladu zo zalohovych platoem - MD
begin
  If not ValueExists ('LEDGER','IsRndSnt') then WriteString ('LEDGER','IsRndSnt','548');
  Result := ReadString ('LEDGER','IsRndSnt','548');
end;

procedure TNexIni.SetIsRndAnl (pValue:Str6);
begin
  WriteString ('LEDGER','IsRndAnl',pValue);
end;

function TNexIni.GetIsRndAnl:Str6;
begin
  If not ValueExists ('LEDGER','IsRndAnl') then WriteString ('LEDGER','IsRndAnl','100000');
  Result := ReadString ('LEDGER','IsRndAnl','100000');
end;

procedure TNexIni.SetIsRndVal (pValue:double);
begin
  WriteFloat ('LEDGER','IsRndVal',pValue);
end;

function TNexIni.GetIsRndVal:double;
begin
  If not ValueExists ('LEDGER','IsRndVal') then WriteFloat ('LEDGER','IsRndVal',5);
  Result := ReadFloat ('LEDGER','IsRndVal',5);
end;

procedure TNexIni.SetIsPdfSnt (pValue:Str3);
begin
  WriteString ('LEDGER','IsPdfSnt',pValue);
end;

function TNexIni.GetIsPdfSnt:Str3; // Synteticky ucet zauctovania danoveho dokladu zo zalohovych platoem - MD
begin
  If not ValueExists ('LEDGER','IsPdfSnt') then WriteString ('LEDGER','IsPdfSnt','132');
  Result := ReadString ('LEDGER','IsPdfSnt','132');
end;

procedure TNexIni.SetIsPdfAnl (pValue:Str6);
begin
  WriteString ('LEDGER','IsPdfAnl',pValue);
end;

function TNexIni.GetIsPdfAnl:Str6;
begin
  If not ValueExists ('LEDGER','IsPdfAnl') then WriteString ('LEDGER','IsPdfAnl','200000');
  Result := ReadString ('LEDGER','IsPdfAnl','200000');
end;

procedure TNexIni.SetIsDscSnt (pValue:Str3);
begin
  WriteString ('LEDGER','IsDscSnt',pValue);
end;

function TNexIni.GetIsDscSnt:Str3; // Synteticky ucet zauctovania danoveho dokladu zo zalohovych platoem - MD
begin
  If not ValueExists ('LEDGER','IsDscSnt') then WriteString ('LEDGER','IsDscSnt','132');
  Result := ReadString ('LEDGER','IsDscSnt','132');
end;

procedure TNexIni.SetIsDscAnl (pValue:Str6);
begin
  WriteString ('LEDGER','IsDscAnl',pValue);
end;

function TNexIni.GetIsDscAnl:Str6;
begin
  If not ValueExists ('LEDGER','IsDscAnl') then WriteString ('LEDGER','IsDscAnl','200000');
  Result := ReadString ('LEDGER','IsDscAnl','200000');
end;

function TNexIni.GetOldVersion: boolean; // Ak je TRUE potom system pouziva databaze stareho DOS systemu (inventarizacia)
begin
  If not ValueExists ('SYSTEM','OldVersion') then WriteBool ('SYSTEM','OldVersion',FALSE);
  Result := ReadBool ('SYSTEM','OldVersion',FALSE);
end;

function TNexIni.GetAutoActDate: boolean; // Ak je TRUE system do kazdeho editora datumu ako zakldane nastavenie zapise aktualny datum
begin
  If not ValueExists ('SYSTEM','AutoActDate') then WriteBool ('SYSTEM','AutoActDate',TRUE);
  Result := ReadBool ('SYSTEM','AutoActDate',TRUE);
end;

function TNexIni.GetSabNewAcc:TDateTime;
begin
  If not ValueExists ('SYSTEM','SabNewAcc') then WriteDate ('SYSTEM','SabNewAcc',0);
  Result := ReadDate ('SYSTEM','SabNewAcc',0);
end;

function TNexIni.TsdLockAfterPrint: boolean; // Ak je TRUE potom system uzatvory jeho doklad po vytlaceni
begin
  If not ValueExists ('SYSTEM','TsdLockAfterPrint') then WriteBool ('SYSTEM','TsdLockAfterPrint',FALSE);
  Result := ReadBool ('SYSTEM','TsdLockAfterPrint',FALSE);
end;

function TNexIni.TcdLockAfterPrint: boolean; // Ak je TRUE potom system uzatvory jeho doklad po vytlaceni
begin
  If not ValueExists ('SYSTEM','TcdLockAfterPrint') then WriteBool ('SYSTEM','TcdLockAfterPrint',FALSE);
  Result := ReadBool ('SYSTEM','TcdLockAfterPrint',FALSE);
end;

function TNexIni.IsdLockAfterPrint: boolean; // Ak je TRUE potom system uzatvory jeho doklad po vytlaceni
begin
  If not ValueExists ('SYSTEM','IsdLockAfterPrint') then WriteBool ('SYSTEM','IsdLockAfterPrint',FALSE);
  Result := ReadBool ('SYSTEM','IsdLockAfterPrint',FALSE);
end;

function TNexIni.IcdLockAfterPrint: boolean; // Ak je TRUE potom system uzatvory jeho doklad po vytlaceni
begin
  If not ValueExists ('SYSTEM','IcdLockAfterPrint') then WriteBool ('SYSTEM','IcdLockAfterPrint',FALSE);
  Result := ReadBool ('SYSTEM','IcdLockAfterPrint',FALSE);
end;

procedure TNexIni.SetSelfDvzName (pValue:Str3); // Vlasnta mena
begin
  WriteString ('SYSTEM','SelfDvzName',pValue);
end;

procedure TNexIni.SetSelfStaCode (pValue:Str2); // Kod statu z evidencii statov, ktory je tuzemsko
begin
  WriteString ('SYSTEM','SelfStaCode',pValue);
end;

procedure TNexIni.SetSelfOldTin (pValue:Str15); // Stare DIC
begin
  WriteString ('SYSTEM','SelfOldTin',pValue);
end;

function TNexIni.GetStkClsDate: TDateTime;
begin
  If not ValueExists ('SYSTEM','StkClsDate') then WriteDate ('SYSTEM','StkClsDate',0);
  Result := ReadDate ('SYSTEM','StkClsDate',0);
end;

function TNexIni.GetSabClsDate: TDateTime;
begin
  If not ValueExists ('SYSTEM','SabClsDate') then WriteDate ('SYSTEM','SabClsDate',0);
  Result := ReadDate ('SYSTEM','SabClsDate',0);
end;

function TNexIni.GetAccClsDate: TDateTime;
begin
  If not ValueExists ('SYSTEM','AccClsDate') then WriteDate ('SYSTEM','AccClsDate',0);
  Result := ReadDate ('SYSTEM','AccClsDate',0);
end;

procedure TNexIni.SetStkClsDate (pDate:TDateTime);
begin
  WriteDate ('SYSTEM','StkClsDate',pDate);
end;

procedure TNexIni.SetSabClsDate (pDate:TDateTime);
begin
  WriteDate ('SYSTEM','SabClsDate',pDate);
end;

procedure TNexIni.SetAccClsDate (pDate:TDateTime);
begin
  WriteDate ('SYSTEM','AccClsDate',pDate);
end;

function TNexIni.GetZipPath:string; // Pracovny adresar na loklanom dislu
begin
  If not ValueExists ('SYSTEM','ZipPath') then WriteString ('SYSTEM','ZipPath','C:\NexZip\');
  Result := ReadString ('SYSTEM','ZipPath','C:\NexZip\');
  If not DirectoryExists (Result) then ForceDirectories (Result);
end;

function TNexIni.GetComPath:string; // Komunikacny adresar na prenos udajov
begin
  If not ValueExists ('SYSTEM','ComPath') then WriteString ('SYSTEM','ComPath','C:\TRANS\');
  Result := ReadString ('SYSTEM','ComPath','C:\TRANS\');
  If not DirectoryExists (Result) then ForceDirectories (Result);
end;

procedure TNexIni.SetComPath (pPath:string); // Cesta na prenos udajov
begin
  WriteString ('SYSTEM','ComPath',pPath);
  If not DirectoryExists (pPath) then ForceDirectories (pPath);
end;

function TNexIni.GetAccFtpRcv: boolean; // Ak je TRUE potom system vytvara REF subory pre registracne pokladne
begin
  If not ValueExists ('FTP','AccFtpRcv') then WriteBool ('FTP','AccFtpRcv',FALSE);
  Result := Readbool ('FTP','AccFtpRcv',FALSE);
end;

procedure TNexIni.SetAccFtpRcv (pValue:boolean);
begin
  WriteBool ('FTP','AccFtpRcv',pValue);
end;

function TNexIni.GetArcTflSnd: boolean; // Ak je TRUE potom system prenasa subory cez priznak archive v opacnom pripade cez evidenciu prenesenych suborov
begin
  If not ValueExists ('FTP','ArcTflSnd') then WriteBool ('FTP','ArcTflSnd',TRUE);
  Result := Readbool ('FTP','ArcTflSnd',TRUE);
end;

procedure TNexIni.SetArcTflSnd (pValue:boolean);
begin
  WriteBool ('FTP','ArcTflSnd',pValue);
end;


function TNexIni.GetOmdFtpSnd: boolean; // Ak je TRUE medziprevadzkovy presun (prijemka) je poslany cez FTP
begin
  If not ValueExists ('FTP','OmdFtpSnd') then WriteBool ('FTP','OmdFtpSnd',TRUE);
  Result := Readbool ('FTP','OmdFtpSnd',TRUE);
end;

procedure TNexIni.SetOmdFtpSnd (pValue:boolean);
begin
  WriteBool ('FTP','OmdFtpSnd',pValue);
end;

function TNexIni.GetMyBaContoFac:Str30; // Cislo uctu v pripade factoringu
begin
  If not ValueExists ('FACTORING','MyBaContoFac') then WriteString ('FACTORING','MyBaContoFac','');
  Result := ReadString ('FACTORING','MyBaContoFac','');
end;

function TNexIni.GetMyBaNameFac:Str30;  // Nazov banky v pripade factoringu
begin
  If not ValueExists ('FACTORING','MyBaNameFac') then WriteString ('FACTORING','MyBaNameFac','');
  Result := ReadString ('FACTORING','MyBaNameFac','');
end;

function TNexIni.GetMyBaCityFac:Str30;    // Sidlo banky v pripade factoringu
begin
  If not ValueExists ('FACTORING','MyBaCityFac') then WriteString ('FACTORING','MyBaCityFac','');
  Result := ReadString ('FACTORING','MyBaCityFac','');
end;

procedure TNexIni.SetMyBaContoFac (pValue:Str30); // Cislo uctu v pripade factoringu
begin
  WriteString ('FACTORING','MyBaContoFac',pValue);
end;

procedure TNexIni.SetMyBaNameFac (pValue:Str30);  // Nazov banky v pripade factoringu
begin
  WriteString ('FACTORING','MyBaNameFac',pValue);
end;

procedure TNexIni.SetMyBaCityFac (pValue:Str30);    // Sidlo banky v pripade factoringu
begin
  WriteString ('FACTORING','MyBaCityFac',pValue);
end;

function TNexIni.GetBonAct:boolean; // Aktivacia bonusovej zlavy
begin
  If not ValueExists ('ACTIONS','BonAct') then WriteBool ('ACTIONS','BonAct',FALSE);
  Result := ReadBool ('ACTIONS','BonAct',FALSE);
end;

procedure TNexIni.SetBonAct (pValue:boolean); // Aktivacia bonusovej zlavy
begin
  WriteBool ('ACTIONS','BonAct',pValue);
end;

function TNexIni.GetBonVal:double; // Hodnota, od ktoreho plati bonusova akcia
begin
  If not ValueExists ('ACTIONS','BonVal') then WriteFloat ('ACTIONS','BonVal',0);
  Result := ReadFloat ('ACTIONS','BonVal',0);
end;

procedure TNexIni.SetBonVal (pValue:double); // Hodnota, od ktoreho plati bonusova akcia
begin
  WriteFloat ('ACTIONS','BonVal',pValue);
end;

function TNexIni.GetBonNum:word; // Poradové èíslo akciového zoznamu pridaných položiek
begin
  If not ValueExists ('ACTIONS','BonNum') then WriteInteger ('ACTIONS','BonNum',0);
  Result := ReadInteger ('ACTIONS','BonNum',0);
end;

procedure TNexIni.SetBonNum (pValue:word); // Poradové èíslo akciového zoznamu pridaných položiek
begin
  WriteInteger ('ACTIONS','BonNum',pValue);
end;

function TNexIni.GetBonDate:TDateTime; // Datum zahajenia akcie
begin
  If not ValueExists ('ACTIONS','BonDate') then WriteDate ('ACTIONS','BonDate',Date);
  Result := ReadDate ('ACTIONS','BonDate',Date);
end;

procedure TNexIni.SetBonDate (pValue:TDateTime); // Datum zahajenia akcie
begin
  WriteDate ('ACTIONS','BonDate',pValue);
end;

function TNexIni.GetBonType:word; // Datum zahajenia akcie
begin
  If not ValueExists ('ACTIONS','BonType') then WriteInteger ('ACTIONS','BonType',2);
  Result := ReadInteger ('ACTIONS','BonType',2);
end;

procedure TNexIni.SetBonType (pValue:word); // Poradové èíslo akciového zoznamu pridaných položiek
begin
  WriteInteger ('ACTIONS','BonType',pValue);
end;

function TNexIni.GetBonGsd:longint; // PLU bonusovej zlavy
begin
  If not ValueExists ('ACTIONS','BonGsd') then WriteInteger ('ACTIONS','BonGsd',0);
  Result := ReadInteger ('ACTIONS','BonGsd',0);
end;

procedure TNexIni.SetBonGsd (pValue:longint); // PLU bonusovej zlavy
begin
  WriteInteger ('ACTIONS','BonGsd',pValue);
end;

function TNexIni.GetBonGsi:ShortString; // Vymenovanie PLU poloziek z ktorej sa pocita bonusova zlava
begin
  If not ValueExists ('ACTIONS','BonGsi') then WriteString ('ACTIONS','BonGsi','');
  Result := ReadString ('ACTIONS','BonGsi','');
end;

procedure TNexIni.SetBonGsi (pValue:ShortString); // Vymenovanie PLU poloziek z ktorej sa pocita bonusova zlava
begin
  WriteString ('ACTIONS','BonGsi',pValue);
end;

function TNexIni.GetModToDsc:boolean; // Vsetky zmeny PC zapocitat do zlavy
begin
  If not ValueExists ('SALES','ModToDsc') then WriteBool ('SALES','ModToDsc',FALSE);
  Result := ReadBool ('SALES','ModToDsc',FALSE);
end;

procedure TNexIni.SetModToDsc (pValue:boolean); // Vsetky zmeny PC zapocitat do zlavy
begin
  WriteBool ('SALES','ModToDsc',pValue);
end;


function TNexIni.GetUdbInPath: string; // Adresar suboru DATA_IN.TXT
begin
  If not ValueExists ('UDBMMC','InPath') then WriteString ('UDBMMC','InPath','C:\UDBMMC2003\');
  Result := ReadString ('UDBMMC','InPath','C:\UDBMMC2003\');
  If not DirectoryExists (Result) then ForceDirectories (Result);
end;

function TNexIni.GetUdbOutPath: string; // Adresar suboru DATA_OUT.TXT
begin
  If not ValueExists ('UDBMMC','OutPath') then WriteString ('UDBMMC','OutPath','C:\UDBMMC2003\');
  Result := ReadString ('UDBMMC','OutPath','C:\UDBMMC2003\');
end;

function TNexIni.GetTrmType:byte; // Typ pouzitej databanky
begin
  If not ValueExists ('HARDWARE','TrmType') then WriteInteger ('HARDWARE','TrmType',0);
  Result := ReadInteger ('HARDWARE','TrmType',0);
end;

procedure TNexIni.SetTrmType (pValue:byte); // Typ pouzitej databanky
begin
  WriteInteger ('HARDWARE','TrmType',pValue);
end;

function TNexIni.GetRndMgCode:longint; // Skupina polozky zaokruhlenia dokladu
begin
  If not ValueExists ('RNDITM','RndMgCode') then WriteInteger ('RNDITM','RndMgCode',9000);
  Result := ReadInteger ('RNDITM','RndMgCode',0);
end;

procedure TNexIni.SetRndMgCode (pValue:longint); // Skupina polozky zaokruhlenia dokladu
begin
  WriteInteger ('RNDITM','RndMgCode',pValue);
end;

function TNexIni.GetRndGsCode:longint; // PLU polozky zaokruhlenia dokladu
begin
  If not ValueExists ('RNDITM','RndGsCode') then WriteInteger ('RNDITM','RndGsCode',0);
  Result := ReadInteger ('RNDITM','RndGsCode',0);
end;

procedure TNexIni.SetRndGsCode (pValue:longint); // PLU polozky zaokruhlenia dokladu
begin
  WriteInteger ('RNDITM','RndGsCode',pValue);
end;

function TNexIni.GetRndGsName:Str30; // Nazov polozky zaokruhlenia dokladu
begin
  If not ValueExists ('RNDITM','RndGsName') then WriteString ('RNDITM','RndGsName','Zaokrúhlenie');
  Result := ReadString ('RNDITM','RndGsName','');
end;

procedure TNexIni.SetRndGsName (pValue:Str30); // Nazov polozky zaokruhlenia dokladu
begin
  WriteString ('RNDITM','RndGsName',pValue);
end;


{ TFltIni }

procedure TFltIni.WriteBool(const Section, Ident: string; Value: Boolean);
begin
  If Value then inherited else DeleteKey(Section,Ident);
end;

procedure TFltIni.WriteDate(const Section, Name: string; Value: TDateTime);
begin
  If Value<>0 then inherited else DeleteKey(Section,Name);
end;

procedure TFltIni.WriteDateTime(const Section, Name: string;
  Value: TDateTime);
begin
  If Value<>0 then inherited else DeleteKey(Section,Name);
end;

procedure TFltIni.WriteFloat(const Section, Name: string; Value: Double);
begin
  If Value<>0 then inherited else DeleteKey(Section,Name);
end;

procedure TFltIni.WriteInteger(const Section, Ident: string;
  Value: Integer);
begin
  If Value<>0 then inherited else DeleteKey(Section,Ident);
end;

procedure TFltIni.WriteString(const Section, Ident, Value: String);
begin
  If Value<>'' then inherited else DeleteKey(Section,Ident);
end;

procedure TFltIni.WriteTime(const Section, Name: string; Value: TDateTime);
begin
  If Value<>0 then inherited else DeleteKey(Section,Name);
end;

function TNexIni.GetCasWorkTime: byte;
begin
  If not ValueExists ('SYSTEM','CasWorkTime') then WriteInteger ('SYSTEM','CasWorkTime',12);
  Result := ReadInteger ('SYSTEM','CasWorkTime',12)
end;

function TNexIni.GetDefVatGrp: byte;
begin
  If not ValueExists ('SYSTEM','DefVatGrp') then WriteInteger ('SYSTEM','DefVatGrp',2);
  Result := ReadInteger ('SYSTEM','DefVatGrp',2)
end;

end.
{MOD 1907001}
