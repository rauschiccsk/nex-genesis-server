unit BtrLst;

interface

uses
  IcTypes, IcTools, IcConv, IcVariab, NexPath,  
  StdCtrls, Forms, Classes, SysUtils, Dialogs;

type
  TBtrLst = class
    constructor Create;
    destructor Destroy; override;
  private
    oCab: TStrings; // Zoznam suborov CABACK
    oDls: TStrings; // Zoznam suborov DIALS
    oLdg: TStrings; // Zoznam suborov LEDGER
    oStk: TStrings; // Zoznam suborov STORES
    oPdp: TStrings; // Zoznam suborov PRODPL
    oCpd: TStrings; // Zoznam suborov CPDDAT
    oSta: TStrings; // Zoznam suborov STADAT
    oHtl: TStrings; // Zoznam suborov HOTEL
    oSys: TStrings; // Zoznam suborov SYSTEM
    function NameExist(pName:ShortString;pLst:TStrings):boolean;
  public
    function BtrPath(pName:ShortString):ShortString;  // Vrati kompletnu cestu k databazovemu suboru
    function DirName(pName:ShortString):Str8; // Vrati len nazov adresara kde je umietneny datbazovy subor
  published
  end;

var gBtr:TBtrLst;

implementation

constructor TBtrLst.Create;
begin
  // ########################### CABACK #############################
  oCab:=TStringList.Create; // Zoznam suborov CABACK
  // >>>>>>>>>>>>>>>>>>>>>>>>>>>> CAB <<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<
  oCab.Add('SHDLST');  // História predaja - zoznam zákazníkov
  oCab.Add('SHDITM');  // História predaja - základný zoznam predaných položiek
  oCab.Add('SHDBON');  // História predaja - história vydaných bonusov
  oCab.Add('CASLST');  // Zoznam registracnych pokladni
  oCab.Add('CABLST');  // Zoznam registracnych pokladni
  oCab.Add('CAH');     // Denne uzavierkove udaje pokldne
  oCab.Add('CBH');     // Nebudeme pouzivat
  // >>>>>>>>>>>>>>>>>>>>>>>>>>>> SAB <<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<
  oCab.Add('SABLST');  // Zoznam knich doklady MO predaja
  oCab.Add('SAH');     // Hlavicky doklady MO predaja
  oCab.Add('SAI');     // Polozky doklady MO predaja
  oCab.Add('SAC');     // Komponenty vyrobkov dokladu MO predaja
  oCab.Add('SAG');     // Kumulativne podla tovarovy skupin
  oCab.Add('CAP');     // Register pokladnicnych platieb (n-cislo pokladne)
  oCab.Add('CASPAY');  // Zoznam pokladnicnych platobnych prostriedkov
  oCab.Add('CASUSR');  // Zoznam pokladnikov
  oCab.Add('CASORD');  // Zoznam pokladnicnych objednavok
  oCab.Add('BLKLST');  // Zoznam otvorenych pokladnicnych ucteniek
  oCab.Add('BLKITM');  // Polozky otvorenych pokladnicnych ucteniek
  oCab.Add('SABLST');  // Zoznam knih skladovych vydajov MO predaja
  oCab.Add('SAH');     // Hlavicky vydajovych dokladov MO predaja
  oCab.Add('SAI');     // Polozky skladovych vydajov MO predaja
  oCab.Add('SAC');     // Komponenty vyrobkov dokladu MO predaja
  oCab.Add('SAG');     // Kumulativny zoznam MO predaja podla tovarovych skupin
  oCab.Add('SAP');     // Hotovostne uhrady FA MO predaja
  oCab.Add('SADMOD');  // Zoznam vydajok MO predaja, ktore boli modifikovane - treba ich prepocitat
  oCab.Add('CASSAS');  //
  oCab.Add('CAFDOC');  // Pokladnicne dokladu podla pokladnikov
  oCab.Add('CAFSUM');  // Kumulativny stav financie podla pokladnikov
  oCab.Add('CRDTRN');  // Obraty zakaznickych kariet
  oCab.Add('CAPADV');  //
  oCab.Add('CAPDEF');  //

  // ########################### DIALS #############################
  oDls:=TStringList.Create; // Zoznam suborov DIALS
  oDls.Add('WRILST');  // Zoznam prevadzkovych jednotiek
  oDls.Add('CRDLST');  // Zoznam zakaznickych kariet
  oDls.Add('DLRLST');  // Zoznam obchodnych zastupcov
  oDls.Add('DRVLST');  // Zoznam vodicov sluzobnych vozidiel
  oDls.Add('REFLST');  // Zoznam typov referencii
  oDls.Add('DSCLST');  // Zoznam typov zliav
  oDls.Add('CCTLST');  // Jednotný colný sadzobník
  oDls.Add('CCTDEF');  // Colný sadzobník pre prenesenie daòovej povinnosti
  // >>>>>>>>>>>>>>>>>>>>>>>>>>>> PAB <<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<
  oDls.Add('PAGLST');  // Zoznam triediacich skupin partnerov
  oDls.Add('STALST');  // Zoznam statov
  oDls.Add('CTYLST');  // Zoznam miest a obci
  oDls.Add('PAYLST');  // Zoznam foriem uhrady faktur
  oDls.Add('TRSLST');  // Zoznam sposobov dopravy
  oDls.Add('BANKLST'); // Zoznam bankovych ustavov
  oDls.Add('PABLST');  // Zoznam knih obdhodnych partnerov
  oDls.Add('PAB');     // Kniha partnerov
  oDls.Add('PABACC');  // Bankove ucty obchodnych partnerov
  oDls.Add('PACNTC');  // Kontakty obchodnych partnerov
  oDls.Add('PASUBC');  // Prevadzkove jednotky obchodnych partnerov
  oDls.Add('PANOTI');  // Poznamky na evidencnej karte partnerov
  oDls.Add('WGSLST');  // Zoznam vahovych sekcii
  oDls.Add('WGI');     // Polozky vahovej sekcii
  oDls.Add('WGN');     // Poznamky k vahovym tovarov
  oDls.Add('EPCLST');  // Zoznam zamestnancov
  // ########################### LEDGER #############################
  oLdg:=TStringList.Create; // Zoznam suborov LEDGER
  oLdg.Add('ACCSNT');  // Uctovna osnova syntetickych uctov
  oLdg.Add('ACCANL');  // Uctovna osnova analytickych uctov
  oLdg.Add('ACCTRN');  // Obratova predvaha analytickych uctov
  oLdg.Add('PMBLST');  // Knihy dennikov uhrady faktur
  oLdg.Add('PMI');     // Dennik uhrady faktur
  oLdg.Add('PMQ');     // Histopria prevodnych prikazov
  oLdg.Add('SVBLST');  // Knihy faktur zalohovychplatieb
  oLdg.Add('SPBLST');  //
  oLdg.Add('SPD');     //
  oLdg.Add('SPV');     //
  oLdg.Add('SPVLST');  //
  oLdg.Add('JOURNAL'); // Dennik uctovnych zapisov
  oLdg.Add('CRSLST');  // Zoznam devizovych mien
  oLdg.Add('VTRAWR');  // Legislatívny výkaz DPH
  // >>>>>>>>>>>>>>>>>>>>>>>>>>>> ACT <<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<
  oLdg.Add('ACTLST');  // Zoznam vykazov obratovej pedvahy
  oLdg.Add('ACT');     // Vykaz obratovej predvahy
  // >>>>>>>>>>>>>>>>>>>>>>>>>>>> BLC <<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<
  oLdg.Add('BLCLST');  // Zoznam uctovnych vykazov
  oLdg.Add('SUVDEF');  // Definicia vykazu suvahy
  oLdg.Add('VYSDEF');  // Definicia vykazu vysledovky
  oLdg.Add('SUV');     // Vykaz suvahy
  oLdg.Add('VYS');     // Vykaz vysledovky
  // >>>>>>>>>>>>>>>>>>>>>>>>>>>> SRD <<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<
  oLdg.Add('SRDOC');   // Hlavicky dokladov vykazu liehovych vyrobov
  oLdg.Add('SRMOV');   // Polozky vykazu liehovych vyrobkov - primy a vydaje
  oLdg.Add('SRSTA');   // Polozky vykazu liehovych vyrobkov - stavy
  // >>>>>>>>>>>>>>>>>>>>>>>>>>>> PQB <<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<
  oLdg.Add('PQBLST');  // Zoznam knih prevodnych prikazov
  oLdg.Add('PQH');     // Hlavicky prevodnych prikazov
  oLdg.Add('PQI');     // Polozky prevodnych prikazov
  // >>>>>>>>>>>>>>>>>>>>>>>>>>>> DPB <<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<
  oLdg.Add('DPBLST');  // Zoznam knih postupenych pohladavok
  oLdg.Add('DPH');     // Hlavicky postupenych pohladavok
  oLdg.Add('DPI');     // Polozky postupenych pohladavok
  // >>>>>>>>>>>>>>>>>>>>>>>>>>>> SOB <<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<
  oLdg.Add('SOBLST');  // Zoznam knih bankovych vypisov
  oLdg.Add('SOH');     // Kniha bankovych vypisov
  oLdg.Add('SOI');     // Polozky bankovych vypisov
  oLdg.Add('SOMLST');  // Zoznam bankovych operacii
  oLdg.Add('ABODAT');  // Udaje pre automaticke bankovnictvo
  oLdg.Add('ABODEF');  // Definicia automatickeho zauctovania ABO
  // >>>>>>>>>>>>>>>>>>>>>>>>>>>> OWB <<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<
  oLdg.Add('OWBLST');  // Knihy vyuctovania sluzobnych ciest
  oLdg.Add('OWH');     // Doklady vyuctovania sluzobnych ciest
  oLdg.Add('OWI');     // Polozky vyuctovani sluzobnych ciest
  // >>>>>>>>>>>>>>>>>>>>>>>>>>>> ISB <<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<
  oLdg.Add('ISBLST');  // Knihy dodavatelskych faktur
  oLdg.Add('ISH');     // Hlavicky dodavatelskych faktur
  oLdg.Add('ISI');     // Polozky dodavatelskych faktur
  oLdg.Add('ISN');     // Poznamky dodavatelskych faktur
  oLdg.Add('ISW');     // Historia upomienok k DF
  oLdg.Add('ISRCRH');  // Zoznam hlaviciek prekurzovacich dokladov DF
  oLdg.Add('ISRCRI');  // Zoznam koncorocnych prekurzovani DF
  oLdg.Add('ISRLST');  // Rezijne polozky dodavatelskej faktury
  oLdg.Add('ISDSPC');  // Specifikacia dodavatelskych faktury
  // >>>>>>>>>>>>>>>>>>>>>>>>>>>> ICB <<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<
  oLdg.Add('ICBLST');  // Knihy odberatelskych faktur
  oLdg.Add('ICH');     // Hlavicky odberatelskych faktur
  oLdg.Add('ICI');     // Polozky odberatelskych faktur
  oLdg.Add('ICN');     // Poznamky odberatelskych faktur
  oLdg.Add('ICP');     // Penalizacne faktury pripojene k OF
  oLdg.Add('ICW');     // Historia upomienok k OF
  oLdg.Add('ICDSPC');  // Specifikacia odberatelskych faktury
  // >>>>>>>>>>>>>>>>>>>>>>>>>>>> CSB <<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<
  oLdg.Add('CSBLST');  // Knihy hotovostnych pokladni
  oLdg.Add('CSH');     // Hlavicky hotovostnych dokladov
  oLdg.Add('CSI');     // Polozky hotovostnych dokladov
  oLdg.Add('CSN');     // Poznamky hotovostnych dokladov
  oLdg.Add('CSOEXP');  // Zoznam vydajovych operacii
  oLdg.Add('CSOINC');  // Zoznam prijmovych operacii
  // >>>>>>>>>>>>>>>>>>>>>>>>>>>> IDB <<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<
  oLdg.Add('IDBLST');  // Knihy internych uctovnych dokladov
  oLdg.Add('IDH');     // Hlavicky internych uctovnych dokladov
  oLdg.Add('IDI');     // Polozky internych uctovnych dokladov
  oLdg.Add('IDN');     // Poznamky internych uctovnych dokladov
  oLdg.Add('IDMLST');  // Zoznam pohybov uctovnych dokladov
  // >>>>>>>>>>>>>>>>>>>>>>>>>>>> WAB <<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<
  oLdg.Add('WABLST');  // Knihy pre vypocet odmeny zamestnancov
  oLdg.Add('WAH');     // Hlavicky vykazov odmeny zamestnancov
  oLdg.Add('WAI');     // Hlavicky vykazov odmeny zamestnancov
  oLdg.Add('WAE');     // 
  oLdg.Add('WARDEF');  // Definicia kalkulacnych predpisov
  // >>>>>>>>>>>>>>>>>>>>>>>>>>>> VTB <<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<
  oLdg.Add('VTBDOC');  // Zoznam danovych dokladov evidencii DPH
  oLdg.Add('VTDSPC');  // Specifikacia dokladov z hladiska DPH
  oLdg.Add('VTCLST');  // Zoznam klaklulacnych obdobi
  oLdg.Add('VTRLST');  // Zoznam dokladov
  oLdg.Add('VTC');     // Klakulacne vzorce priznania DPH
  oLdg.Add('VTI');     // Polozky kontrolneho DPH
  oLdg.Add('VTR');     // Zoznam danovych dokladov - evidencia DPH
  oLdg.Add('VTCSPC');  // Specifikacia dokladov z hladiska DPH
  // >>>>>>>>>>>>>>>>>>>>>>>>>>>> CRS <<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<
  oLdg.Add('CRSHIS');  // Kurzovy list 
  // >>>>>>>>>>>>>>>>>>>>>>>>>>>> FXB <<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<
  oLdg.Add('FXBLST');  // Zoznam knih dlhodobeho majetku
  oLdg.Add('FXA');     // Evidencne karty dlhodobeho majetku
  oLdg.Add('FXM');     // Korrekcia vstupnej ceny majetku
  oLdg.Add('FXN');     // Poznamky k dlhodobemu majetku
  oLdg.Add('FXL');     // Uctovny odpisovy plan majetku
  oLdg.Add('FXT');     // Danovy odpisy dlhodobeho majetku
  oLdg.Add('FXTGRP');  // Danove odpisove skupiny
  oLdg.Add('FXAGRP');  // Uctovne skupiny majetku
  // >>>>>>>>>>>>>>>>>>>>>>>>>>>> FRJ <<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<
  oLdg.Add('FINJRN');  // Penazny dennik
  oLdg.Add('FRIDOC');  // Vykaz prijmova a vydajov
  oLdg.Add('FRPDOC');  // Vykaz majetku a zavazkov
  // ########################### STORES #############################
  oStk:=TStringList.Create; // Zoznam suborov STORES
  oStk.Add('ACDTMP');  // Docasne ulozeny doklad
  oStk.Add('TRMLST');  // Zoznam mobilných terminálov
  // >>>>>>>>>>>>>>>>>>>>>>>>>>>> GSC <<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<
  oStk.Add('GSCAT');   // Evidencia tovaru
  oStk.Add('GSCLNK');  // Linkovane tovary
  oStk.Add('SRCAT');   // Evidevice liehovych vyrobkov
  oStk.Add('GSNOTI');  // Poznamky k polozkam eivdencii tovaru
  oStk.Add('GSCANA');  // Doplnkový názov tovaru
  oStk.Add('GSNAME');  // Vyhladavanie tovaru podla nazvu
  oStk.Add('GSLANG');  // Preklad nazvu tovaru do inych jazykov
  oStk.Add('BARCODE'); // Druhotne identifikacne kody
  oStk.Add('GSCIMG');  // Linky na obrazky tovarov
  oStk.Add('MGLST');   // Zoznam tovarovych skupin
  oStk.Add('FGLST');   // Zoznam financnych skupin
  oStk.Add('SPCINF');  // Zoznam tovarov ku ktorym su pripojene spec. informacie
  oStk.Add('SRCAT');   // Zoznam liehovych vyrobkov
  oStk.Add('UNLHIS');  // Historia odblokovania dokladov
  oStk.Add('EISDMG');  // Zakazané tovarové skupiny pre internetový obchod
  // >>>>>>>>>>>>>>>>>>>>>>>>>>>> PLS <<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<
  oStk.Add('PLSLST');  // Zoznam predajnych cennikov
  oStk.Add('PLS');     // Predajny cennik
  oStk.Add('PLH');     // Historia zmeny predajnych cien
  oStk.Add('PLD');     // Zoznam zrusenych poloziek cennika
  // >>>>>>>>>>>>>>>>>>>>>>>>>>>> DSC <<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<
  oStk.Add('FGPADSC'); // Zlavy podla finanèných skupÝn
  oStk.Add('FGPALST'); // Zoznam firiem, ktorym je priradena zlava
  // >>>>>>>>>>>>>>>>>>>>>>>>>>>> AGL <<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<
  oStk.Add('AGRLST');  // Zmluvne ceny zakaznikov
  oStk.Add('AGRITM');  // Zoznam partnerov ktoré maju zmluvne ceny
  // >>>>>>>>>>>>>>>>>>>>>>>>>>>> APL <<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<
  oStk.Add('APLLST');  // Zoznam akciových cenníkov
  oStk.Add('APLITM');  // Zoznam akciovych tovarov
  // >>>>>>>>>>>>>>>>>>>>>>>>>>>> ACB <<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<
  oStk.Add('ACBLST');  // Knihy akciovych preceneni tovarov
  oStk.Add('ACH');     // Hlavicky precenovacich dokladov
  oStk.Add('ACI');     // Polozky precenovacich dokladov
  // >>>>>>>>>>>>>>>>>>>>>>>>>>>> STK <<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<
  oStk.Add('WRSLST');  // Zoznam skladov do vyhodnotenia WRS 
  oStk.Add('STKLST');  // Zoznam skladov
  oStk.Add('STK');     // Skladove karty zasob
  oStk.Add('STM');     // Dennik skladovych pohybov
  oStk.Add('FIF');     // FIFO karty tovarov
  oStk.Add('STO');     // Zoznam objednavkovych dokladov
  oStk.Add('STP');     // Zoznam vyrobnych cisiel
  oStk.Add('STR');     // Zoznam automatickych rezervacii
  oStk.Add('STS');     // Neodpocitane polozky MO predaja
  oStk.Add('SMLST');   // Zoznam skladovych pohubov
  oStk.Add('SPC');     // Pozièné skladové karty
  oStk.Add('SPM');     // Pohyby na pozièných skladových kartách
  oStk.Add('POS');     // Pozicie
  oStk.Add('STB');     // Pociatocne stavy
  // >>>>>>>>>>>>>>>>>>>>>>>>>>>> BCS <<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<
  oStk.Add('BCSGSL');  // Obchodne podmienky dodavatelov
  oStk.Add('BCSPAL');  // Zoznam dodavatelov pre obchodne podmienky
  // >>>>>>>>>>>>>>>>>>>>>>>>>>>> PCC <<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<
  oStk.Add('PCCGSC');  // Zoznam obalovych tovarov obaloveho konta
  oStk.Add('PCCHIS');  // Historia obalovych tovarov
  oStk.Add('PCCLST');  // Zoznam odberatelov obaloveho konta
  // >>>>>>>>>>>>>>>>>>>>>>>>>>>> IMB <<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<
  oStk.Add('IMBLST');  // Zoznam knich internych skladovych prijemok
  oStk.Add('IMH');     // Hlavicky internych skladovych prijemok
  oStk.Add('IMI');     // Polozky internych skladovych prijemok
  oStk.Add('IMN');     // Poznamky internych skladovych prijemok
  oStk.Add('IMP');     // Vyrobne cisla internych skladovych prijemok
  oStk.Add('IMW');     // Váhové balíky
  // >>>>>>>>>>>>>>>>>>>>>>>>>>>> OMB <<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<
  oStk.Add('OMBLST');  // Zoznam knich internych skladovych vydajok
  oStk.Add('OMH');     // Hlavicky internych skladovych vydajok
  oStk.Add('OMI');     // Polozky internych skladovych vydajok
  oStk.Add('OMN');     // Poznamky internych skladovych vydajok
  oStk.Add('OMP');     // Vyeobne cisla internych skladovych vydajok
  // >>>>>>>>>>>>>>>>>>>>>>>>>>>> RMB <<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<
  oStk.Add('RMBLST');  // Zoznam knich medziskladovych presunov
  oStk.Add('RMH');     // Hlavicky medziskladovych presunov
  oStk.Add('RMI');     // Polozky medziskladovych presunov
  oStk.Add('RMN');     // Poznamky medziskladovych presunov
  oStk.Add('RMP');     // Vyeobne cisla medziskladovych presunov
  // >>>>>>>>>>>>>>>>>>>>>>>>>>>> PNB <<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<
  oStk.Add('PNBLST');  // Zoznam knih protokolov nepredajneho skladu
  oStk.Add('PMD');     // Zoznam protokolov nepredajneho skladu
  // >>>>>>>>>>>>>>>>>>>>>>>>>>>> CPB <<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<
  oStk.Add('CPBLST');  // Zoznam knih kalkulacii vyrobkov
  oStk.Add('CPH');     // Kalkulacia vyrobkov - zoznam vyrobkov
  oStk.Add('CPI');     // Kalkulacia vyrobkov - zoznam komponentov
  // >>>>>>>>>>>>>>>>>>>>>>>>>>>> CMB <<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<
  oStk.Add('CMBLST');  // Zoznam knich kompletizacnych dokladov
  oStk.Add('CMH');     // Hlavicky kompletizacnych dokladov
  oStk.Add('CMI');     // Polozky kompletizacnych dokladov
  oStk.Add('CMN');     // Poznamky kompletizacnych dokladov
  // >>>>>>>>>>>>>>>>>>>>>>>>>>>> CDB <<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<
  oStk.Add('CDBLST');  // Zoznam knih vyrobnych dokladov
  oStk.Add('CDH');     // Hlavicky hromadnych vyrobnych dokladov
  oStk.Add('CDI');     // Polozky (vyrobky) kompletizacneho dokladu
  oStk.Add('CDM');     // Komponenty (materi ly) vyrobneho dokladu
  oStk.Add('CDN');     // Komponenty (materi ly) vyrobneho dokladu
  // >>>>>>>>>>>>>>>>>>>>>>>>>>>> PKB <<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<
  oStk.Add('PKBLST');  // Zoznam knich prebalovacich dokladov
  oStk.Add('PKCLST');  // Zoznam koeficientov prebalenia
  oStk.Add('PKH');     // Hlavicky prebalovacich dokladov
  oStk.Add('PKI');     // Polozky prebalovacich dokladov
  // >>>>>>>>>>>>>>>>>>>>>>>>>>>> DMB <<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<
  oStk.Add('DMBLST');  // Zoznam knih dokladov rozobratia
  oStk.Add('DMH');     // Hlavicky dokladu rozobratia
  oStk.Add('DMI');     // Polozky dokladu rozobratia
  oStk.Add('DMN');     // Poznamky ku dokladom rozobratia
  // >>>>>>>>>>>>>>>>>>>>>>>>>>>> PSB <<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<
  oStk.Add('PSBLST');  // Zoznam knih objednavkocych planov
  oStk.Add('PSH');     // Hlavicky objednavkovych planov
  oStk.Add('PSI');     // Polozky objednavkovych planov
  oStk.Add('PSN');     // Poznamky×ky objednavkovych planov
  // >>>>>>>>>>>>>>>>>>>>>>>>>>>> OSB <<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<
  oStk.Add('OSHLST');  // Hlavicky dodavatelskych objednavok
  oStk.Add('OSILST');  // Polozky dodavatelskych objednavok
  oStk.Add('OSNLST');  // Poznamky dodavatelskych objednavok

  oStk.Add('OSBLST');  // Zoznam knich dodavatelskych objednavok
  oStk.Add('OSH');     // Hlavicky dodavatelskych objednavok
  oStk.Add('OSI');     // Polozky dodavatelskych objednavok
  oStk.Add('OSN');     // Poznamky dodavatelskych objednavok
  oStk.Add('OST');     // Ddkazy na vyparovane DDL
  oStk.Add('OSS');     // Statistika vydaneho a prijateho tovaru
  oStk.Add('OSSMOV');  // Skladove pohyby, ktore sa zapocitaju do objednavok
  oStk.Add('OSIMSF');  // Vyberovy zoznam poloziek - Mountfield

  // >>>>>>>>>>>>>>>>>>>>>>>>>>>> TSB <<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<
  oStk.Add('TSBLST');  // Zoznam knich dodavatelskych DL
  oStk.Add('TSH');     // Hlavicky dodavatelskych DL
  oStk.Add('TSI');     // Polozky dodavatelskych DL
  oStk.Add('TSN');     // Poznamky dodavatelskych DL
  oStk.Add('TSP');     // Vyeobne cisla dodavatelskych DL
  // >>>>>>>>>>>>>>>>>>>>>>>>>>>> UDB <<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<
  oStk.Add('UDBLST');  // Zoznam knih univerzalnych odbytovych dokladov
  oStk.Add('UDH');     // Hlavicky univerzalnych odbytovych dokladov
  oStk.Add('UDI');     // Polozky univerzalneho odbytoveho dokladu
  oStk.Add('UDN');     // Poznamky k univerzalnym odbytovum dokladom
  // >>>>>>>>>>>>>>>>>>>>>>>>>>>> MCB <<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<
  oStk.Add('MCBLST');  // Zoznam knich odberatelskych cenovych ponuk
  oStk.Add('MCH');     // Hlavicky odberatelskych cenovych ponuk
  oStk.Add('MCI');     // Polozky odberatelskych cenovych ponuk
  oStk.Add('MCN');     // Poznamky odberatelskych cenovych ponuk
  oStk.Add('MCRLST');  // Volne polozky cenovej ponuky
  // >>>>>>>>>>>>>>>>>>>>>>>>>>>> OCB <<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<
  oStk.Add('OCHLST');  // Hlavicky odberatelskych zakaziek
  oStk.Add('OCILST');  // Polozky odberatelskych zakaziek
  oStk.Add('OCNLST');  // Poznamky odberatelskych zakaziek
  oStk.Add('OCRLST');  // Detailné zákazkové rezervácie

  oStk.Add('OCBLST');  // Zoznam knich odberatelskych
  oStk.Add('OCH');     // Hlavicky odberatelskych zakaziek
  oStk.Add('OCI');     // Polozky odberatelskych zakaziek
  oStk.Add('OCN');     // Poznamky odberatelskych zakaziek
  oStk.Add('OCC');     // Evidenicia obchodnych zmluv
  oStk.Add('OCD');     // Zoznam zrusenych poloziek zakaziek
  oStk.Add('OCT');     // Zoznam vyskaldnenych poloziek zakaziek
  oStk.Add('OCPDEF');  // Definicia pre spracovanie zakaziek
  oStk.Add('OCPITM');  // Spracovanie poloziek odbertaelskych zakaziek
  oStk.Add('OCPSND');  // Zoznam spracovanych zakaziek na odoslanie
  
  // >>>>>>>>>>>>>>>>>>>>>>>>>>>> TCB <<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<
  oStk.Add('TCBLST');  // Zoznam knich odberatelskych DL
  oStk.Add('TCH');     // Hlavicky odberatelskych DL
  oStk.Add('TCI');     // Polozky odberatelskych DL
  oStk.Add('TCN');     // Poznamky odberatelskych DL
  oStk.Add('TCP');     // Vyeobne cisla odberatelskych DL
  oStk.Add('TCC');     // Viacurovnova vyroba poloziek ODL
  // >>>>>>>>>>>>>>>>>>>>>>>>>>>> IVD <<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<
  oStk.Add('IVDLST');  // Zoznam inventarnych dokladov
  oStk.Add('IVD');     // Inventarny doklad
  oStk.Add('IVC');     // Zoznam tovarov pre databanku
  oStk.Add('IVI');     // Inventßrny harok
  oStk.Add('IVL');     // Hlavickove udaje inventarnych harkov
  oStk.Add('IVM');     // Prirodzene straty podla tovarovych skupin
  oStk.Add('IVN');     // Zoznam nevysporiadaných položiek
  // >>>>>>>>>>>>>>>>>>>>>>>>>>>> CLB <<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<
  oStk.Add('CLBLST');  // Zoznam knih zakaznickych reklamacii
  oStk.Add('CLH');     // Hlavicky zakaznickych reklamacii
  // >>>>>>>>>>>>>>>>>>>>>>>>>>>> SCB <<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<
  oStk.Add('SCBLST');  // Zoznam knih servisnych zakziek
  oStk.Add('SCH');     // Hlavicky servisnych zakaziek
  oStk.Add('SCI');     // Nahradne diely servisnych zakaziek
  oStk.Add('SCS');     // Sluzby servisnych zakaziek
  oStk.Add('SCN');     // Poznamky k servisnym zakazkam
  // >>>>>>>>>>>>>>>>>>>>>>>>>>>> CWB <<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<
  oStk.Add('CWBLST');  // Zoznam knih dokladov kontroly vahoveho rpeaja
  oStk.Add('CWH');     // Hlavicky dokladov kontroly vahoveho rpeaja
  oStk.Add('CWI');     // Kumulativny zoznam poloziek
  oStk.Add('CWC');     // Zoznam poloziek z registracnych pokladnic
  oStk.Add('CWW');     // Zoznam poloziek z elektronickych vah
  // >>>>>>>>>>>>>>>>>>>>>>>>>>>> ALB <<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<
  oStk.Add('ALBLST');  // Zoznam knih vypožicanych naradi
  oStk.Add('ALH');     // Hlavicky dokladov vypožicanych naradi
  oStk.Add('ALI');     // Polozky dokladov vypožicanych naradi
  oStk.Add('ALN');     // Poznamky k dokladu vypožicanych zariadeni
  oStk.Add('ALC');     // Historia fakturacie zapozicky
  oStk.Add('AMH');     // Hlavicky dokladov vypožicanych naradi
  oStk.Add('AMI');     // Polozky dokladov vypožicanych naradi
  oStk.Add('AMN');     // Poznamky k dokladu vypožicanych zariadeni
  oStk.Add('AMC');     // Historia fakturacie zapozicky
  oStk.Add('AOH');     // Hlavicky dokladov vypožicanych naradi
  oStk.Add('AOI');     // Polozky dokladov vypožicanych naradi
  oStk.Add('AON');     // Poznamky k dokladu vypožicanych zariadeni
  oStk.Add('AOC');     // Historia fakturacie zapozicky
  // >>>>>>>>>>>>>>>>>>>>>>>>>>>> REB <<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<
  oStk.Add('REBLST');  // Zoznam knih precenovacich protokolov
  oStk.Add('REH');     // Hlavicky dokladov precenovacich protokolov
  oStk.Add('REI');     // Polozky dokladov precenovacich protokolov

  // >>>>>>>>>>>>>>>>>>>>>>>>>>>> AQM <<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<
  oStk.Add('AQMDOC');  // Hlavicky cenovych ponuk AQM
  oStk.Add('AQMITM');  // Polozky cenovych ponuk AQM
  oStk.Add('AQMNTC');  // Poznamky k cenovu ponukam AQM
  oStk.Add('AQODOC');  // Hlavicky cenovych ponuk AQO
  oStk.Add('AQOITM');  // Polozky cenovych ponuk AQO
  oStk.Add('AQONTC');  // Poznamky k cenovu ponukam AQO
  oStk.Add('AQOQTE');  // Sablony splatkovych kalendarov AQM
  oStk.Add('AQOQTC');  // Splátkový kalendár zmlúv AQM
  oStk.Add('AQKAPI');  // Kapitoly - bazenove skupiny
  // >>>>>>>>>>>>>>>>>>>>>>>>>>>> TIM <<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<
  oStk.Add('TIBLST');  // Zoznam knih terminalovych prijmov
  oStk.Add('TIH');     // Hlavicky terminalovych prijmov
  oStk.Add('TII');     // Polozky terminalovych prijmov
  oStk.Add('TIP');     // Skladové pozície kam tovar bol prijatý
  // >>>>>>>>>>>>>>>>>>>>>>>>>>>> TOM <<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<
  oStk.Add('TOBLST');  // Zoznam knih terminalovych vydajov
  oStk.Add('TOH');     // Hlavicky terminalovych vydajov
  oStk.Add('TOA');     // Hlavicky terminalovych vydajov - archiv
  oStk.Add('TOI');     // Polozky terminalovych vydajov
  oStk.Add('TOD');     // Zrusene polozky terminalovych vydajov
  oStk.Add('TOE');     // Neidentifikovane polozky terminalovych vydajov
  oStk.Add('TOP');     // Pozicie terminalovych vydajov
  oStk.Add('TOT');     // Odkazy na vyparovane ODL
  // >>>>>>>>>>>>>>>>>>>>>>>>>>>> KSB <<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<
  oStk.Add('KSH');     // Doklady konsignašného vysporiadania
  oStk.Add('KSI');     // Polozky konsignašného vysporiadania
  oStk.Add('KSO');     // Výdaje z konsignaènej zásoby
  oStk.Add('KSN');     // Poznamky

  // >>>>>>>>>>>>>>>>>>>>>>>>>>>> MFS <<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<
  oStk.Add('OSIMFS');  //
  oStk.Add('AFC');     // Akciove poukazky na pohonnu hmotu
  // >>>>>>>>>>>>>>>>>>>>>>>>>>>> SOB <<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<
  // ############################ HOTEL #############################
  oHtl:=TStringList.Create; // Zoznam suborov HOTEL
  oHtl.Add('RSH');     // Zoznam rezervacii
  oHtl.Add('RSI');     // Rezervacie izieb
  oHtl.Add('RSS');     // Rezervacie sluzieb
  oHtl.Add('RSP');     // Rezervacie - platby
  oHtl.Add('VIS');     // Zoznam hosti
  oHtl.Add('ROL');     // Zoznam izieb
  oHtl.Add('SRV');     // Zoznam sluzieb
  oHtl.Add('TNH');     // Zoznam ubytovani
  oHtl.Add('TNI');     // Zoznam izieb ubytovani
  oHtl.Add('TNS');     // Zoznam sluzieb ubytovani
  oHtl.Add('TNP');     // Zoznam paltieb ubytovani
  oHtl.Add('TNB2');    // Zoznam
  oHtl.Add('TNV');     // Zoznam ubytovanych hosti
  oHtl.Add('TNNOTI');  // Poznamky ubytovani
  oHtl.Add('RSNOTI');  // Poznamky rezervacii
  oHtl.Add('TNATU');   // Zoznam imporotvnaych hovorov z ustredni
  oHtl.Add('HRSC');    // Zoznam operacii hoteloveho systemu
  oHtl.Add('TNOMB');   // Zoznam vydanych poloziek SV
  oHtl.Add('CRSVLST'); // Kurzovy list VALUT
  oHtl.Add('CRSVHIS'); // Kurzovy list VALUT - HISTORIA
  oHtl.Add('TNE');     // Pripomienky
  oHtl.Add('TNEPLN');  // Pripomienky casova os
  oHtl.Add('PLN');     // Aktivne pripomienky
  // ########################### PRODPL #############################
  oPdp:=TStringList.Create; // Zoznam suborov PRODPL
  // ########################### CPDDAT #############################
  oCpd:=TStringList.Create; // Zoznam suborov CPDDAT
  // ########################### STADAT #############################
  oSta:=TStringList.Create; // Zoznam suborov STADAT
  oSta.Add('CSTCTLST');  // Zoznam miest a obci - hlavny
  oSta.Add('CSTMGLST');  // Zoznam tovarovych skupin pre statistiku
  oSta.Add('CSTPACAX');  // Katalog partnerov pre statistiku - pomocny
  oSta.Add('CSTPACMN');  // Katalog partnerov pre statistiku - hlavny
  oSta.Add('CSTSALFG');  // Statistika predaja podla financnych skupin
  oSta.Add('CSTSALGS');  // Statistika predaja podla tovaru
  oSta.Add('CSTSALMG');  // Statistika predaja podla tovarovych skupin
  oSta.Add('CSTSTMGS');  // Statistika skladovych pohybov
  // ########################### SYSTEM #############################
  oSys:=TStringList.Create; // Zoznam suborov SYSTEM
  oSys.Add('USRGRP');  // Zoznam uzivatelskych skupin
  oSys.Add('USRLST');  // Zoznam uzivatelov systemu
  oSys.Add('BKUSRG');  // Uzivatelske nastavenia pre knihy
  oSys.Add('MSGDIS');  // Zoznam zakazanych chybovych hlaseni
  oSys.Add('SYSTEM');  // Systemovej udaje uzivatelskej firmy
  oSys.Add('SNDDEF');  // Predpis odoslania udajov
  oSys.Add('PGUSRG');  // Uzivatelske nastavenia globalne
  oSys.Add('OPENDOC'); // Zoznam otvorenych dokladov
  oSys.Add('LASTBOOK');// Naposledy otvorené knihy
  oSys.Add('MYCONTO'); // Zoznam vlastnych bankovych uctov
  oSys.Add('UPGLST');  // Zoznam vykonanych aktualizacii
  oSys.Add('UPG');     // Zoznam aktualizovanych suborov
  oSys.Add('BACDEF');  // Definicia viazanosti knih
  oSys.Add('KEYDEF');  // Definicia riadiacich parametrov 
  oSys.Add('NXPDEF');  // Zoznam vsetkych knih systemu NEX
  oSys.Add('NXBDEF');  // Zoznam vsetkych programovych modulov NEX
  oSys.Add('APMDEF');  // Pristupove prava uzivatelov k modulom
  oSys.Add('ABKDEF');  // Pristupove prava uzivatelov ku kniham
  oSys.Add('AFCDEF');  // Pristupove prava uzivatelov ku funkciam
  oSys.Add('SPRLST');  // Systémové správy
  oSys.Add('EASLST');  // Definícia rozoslania emailových správ
  oSys.Add('EASDEF');  // Definícia komu odosla správu
end;

destructor TBtrLst.Destroy;
begin
  FreeAndNil (oCab);
  FreeAndNil (oDls);
  FreeAndNil (oLdg);
  FreeAndNil (oStk);
  FreeAndNil (oPdp);
  FreeAndNil (oCpd);
  FreeAndNil (oSta);
  FreeAndNil (oHtl);
  FreeAndNil (oSys);
end;

// ************************* PRIVATE METHODS *************************

function TBtrLst.NameExist(pName:ShortString;pLst:TStrings):boolean;
var I:word;
begin
  Result:=FALSE;
  If pLst.Count>0 then begin
    For I:=0 to pLst.Count-1 do
      If pLst.Strings[I]=pName then Result:=TRUE;
  end;    
end;

// ************************* PUBLIC METHODS *************************

function TBtrLst.BtrPath(pName:ShortString):ShortString;
begin
  Result:='';
  If NameExist(pName,oCab) then Result:=gPath.CabPath;
  If NameExist(pName,oDls) then Result:=gPath.DlsPath;
  If NameExist(pName,oLdg) then Result:=gPath.LdgPath;
  If NameExist(pName,oStk) then Result:=gPath.StkPath;
  If NameExist(pName,oPdp) then Result:=gPath.PdpPath;
  If NameExist(pName,oCpd) then Result:=gPath.CpdPath;
  If NameExist(pName,oSta) then Result:=gPath.StdPath;
  If NameExist(pName,oHtl) then Result:=gPath.HtlPath;
  If NameExist(pName,oSys) then Result:=gPath.SysPath;
//  If Result='' then MessageDlg('Databáza '+pName+' nie je v systéme defionvaná!', mtInformation,[mbOk], 0);
end;

function TBtrLst.DirName(pName:ShortString):Str8; // Vrati len nazov adresara kde je umietneny datbazovy subor
begin
  Result:='';
  If NameExist(pName,oCab) then Result:='CABACK';
  If NameExist(pName,oDls) then Result:='DIALS';
  If NameExist(pName,oLdg) then Result:='LEDGER';
  If NameExist(pName,oStk) then Result:='STORES';
  If NameExist(pName,oPdp) then Result:='PRODPL';
  If NameExist(pName,oCpd) then Result:='CPDDAT';
  If NameExist(pName,oSta) then Result:='STADAT';
  If NameExist(pName,oHtl) then Result:='HOTEL';
  If NameExist(pName,oSys) then Result:='SYSTEM';
end;

end.
{MOD 1904011}

