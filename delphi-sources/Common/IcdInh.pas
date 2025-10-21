unit IcdInh;
{$F+}
(*
Na zatku kad zprvy v ppad odchoz faktury mus bt systmov zznam - viz. struktura systmovho zznamu	uvozen HDR"
Cislo	INVOIC
polozky                                      Typ	Dlka	Pozice			Zarovnn	Pov.	Pov. D.D.	Poznmka nebo hodnota poloky
HDR	Hlavika 		                        	od		do
 1	uvozen "HDR"                         Char	3	1	-	3	zleva	P	P	"HDR"
 2	Cislo dokladu (danoveho dokladu)     Char	15	4	-	18	zleva	P	P
 3	Druh dokladu (nazov) - kod           Char	3	19	-	21	zleva	P	P
 4	Funkcia spravy - kod                 Char	3	22	-	24	zleva	P	P	9 - originl
 5	Datum vystavenia                     Date	8	25	-	32	zleva	P	P	formt YYYYMMDD
 6	Datum uskutocnenia zdan. plnenia     Date	8	33	-	40	zleva	N	P	formt YYYYMMDD
 7	Datum vyskladneia                    Date	8	41	-	48	zleva	N	(P)	formt YYYYMMDD
 8	Datum dodania                        Date	8	49	-	56	zleva	N	N	formt YYYYMMDD
 9	Fakturace od: (pro summrn fakturu)   Date	8	57	-	64	zleva	N	N	formt YYYYMMDD
10	Fakturace do: (pro summrn fakturu)   Date	8	65	-	72	zleva	N	N	formt YYYYMMDD
11	Datum splatnosti                     Date	8	73	-	80	zleva	N	N	formt YYYYMMDD
12	Sposob uhrady - kod                  Char	3	81	-	83	zleva	N	N
13	Cislo zmluvy                         Char	15	84	-	98	zleva	N	N
14	Cislo objednavky zakaznika           Char	15	99	-	113	zleva	N	N
15	Datum vystavenia objednvky           Date	8	114	-	121	zleva	N	N	formt YYYYMMDD
16	Cislo objednavky u dodavatela        Char	15	122	-	136	zleva	N	N
17	Datum prijatia objednavky u dod.     Date	8	137	-	144	zleva	N	N	formt YYYYMMDD
18	Cislo dodacieho listu                Char	15	145	-	159	zleva	N	N
19	Datum vystavenia dodacieho listu     Date	8	160	-	167	zleva	N	N	formt YYYYMMDD
20	Vyznam ref. cisla faktury            Char	3	168	-	170	zleva	N	N
21	Referencne cislo faktury (zaloh.fa.) Char	15	171	-	185	zleva	N	N
22	Datum vztahujce sa k ref. cislu FA   Date	8	186	-	193	zleva	N	N	formt YYYYMMDD
23	Dealerska kategoria                  Char	15	194	-	208	zleva	N	N
24	EAN kupujceho - odbratela            CharN	17	209	-	225	zleva	P	P	EAN kd 13 mst
25	ICO kupujceho - odbratele            Char	15	226	-	240	zleva	N	P
26	DIC kupujceho - odbratele            Char	15	241	-	255	zleva	N	P
27	EAN objednatele                      CharN	17	256	-	272	zleva	N	N	EAN kd 13 mst
28	EAN miesta dodania                   CharN	17	273	-	289	zleva	N	N	EAN kd 13 mst
29	EAN fakturacneho miesta              CharN	17	290	-	306	zleva	N	N	EAN kd 13 mst
30	EAN dodavatela                       CharN	17	307	-	323	zleva	P	P	EAN kd 13 mst
31	ICO dodavatela                       Char	15	324	-	338	zleva	N	P
32	DIC dodavatela                       Char	15	339	-	353	zleva	N	P
33	EAN distribucneho skladu dodavatele  Char	17	354	-	370	zleva	N	N	EAN kd 13 mst
34	Cislo bankoveho uctu dodavatela      Char	17	371	-	387	zprava	N	N
35	Smerovy kod banky                    Char	4	388	-	391	zleva	N	N
36	Konstantny symbol platby             Char	4	392	-	395	zleva	N	N
37	Variabilny symbol platby             Char	10	396	-	405	zleva	N	N
38	Specificky symbol platby             Char	10	406	-	415	zleva	N	N
39	Kod menu                             Char	3	416	-	418	zleva	N	N	nap. "CZK"


Èíslo	Textové údaje pro daòový doklad - pro daòový doklad povinný øádek, jinak nepovinný øádek
položky                                         Typ	Délka	Pozice			Zarovnání	Pov.	Pov. D.D.
HDD	Hlavièka - textové údaje pro daòový doklad		od		do
 1	Uvození „HDD"                           Char	3	1	-	3	zleva	P	P
 2	Kupující - obchodní jméno - 1           Char	35	4	-	38	zleva	P	P
 3	Kupující - obchodní jméno - 2           Char	35	39	-	73	zleva	N	N
 4	Kupující - obchodní jméno - 3           Char	35	74	-	108	zleva	N	N
 5	Kupující - obchodní jméno - 4           Char	35	109	-	143	zleva	N	N
 6	Kupující - obchodní jméno - 5           Char	35	144	-	178	zleva	N	N
 7	Kupující - adresa - ulice a èíslo - 1   Char	35	179	-	213	zleva	P	P
 8	Kupující - adresa - ulice a èíslo - 2   Char	35	214	-	248	zleva	N	N
 9	Kupující - adresa - ulice a èíslo - 3   Char	35	249	-	283	zleva	N	N
10	Kupující - adresa - ulice a èíslo - 4   Char	35	284	-	318	zleva	N	N
11	Kupující - adresa - místo               Char	35	319	-	353	zleva	N	N
12	Kupující - adresa - PSÈ                 Char	6	354	-	359	zleva	N	N
13	Dodavatel - obchodní jméno - 1          Char	35	360	-	394	zleva	P	P
14	Dodavatel - obchodní jméno - 2          Char	35	395	-	429	zleva	N	N
15	Dodavatel - obchodní jméno - 3          Char	35	430	-	464	zleva	N	N
16	Dodavatel - obchodní jméno - 4          Char	35	465	-	499	zleva	N	N
17	Dodavatel - obchodní jméno - 5          Char	35	500	-	534	zleva	N	N
18	Dodavatel - adresa - ulice a èíslo - 1  Char	35	535	-	569	zleva	P	P
19	Dodavatel - adresa - ulice a èíslo - 2  Char	35	570	-	604	zleva	N	N
20	Dodavatel - adresa - ulice a èíslo - 3  Char	35	605	-	639	zleva	N	N
21	Dodavatel - adresa - ulice a èíslo - 4  Char	35	640	-	674	zleva	N	N
22	Dodavatel - adresa - místo              Char	35	675	-	709	zleva	N	N
23	Dodavatel - adresa - PSÈ                Char	6	710	-	715	zleva	N	N

Èíslo	Faktura - položky - max poèet opakování 25000 krát
položky                                         Typ	Délka	Pozice			Zarovnání	Pov.	Pov. D.D.	Poznámka nebo hodnota položky
LIN	Položky                         			od		do
 1	Uvození „LIN“                           Char	3	1	-	3	zleva	P	P	"LIN"
 2	Èíslo øádku                             Num	6	4	-	9	zprava	P	P
 3	EAN zboží                               CharN	25	10	-	34	zleva	P	P	EAN kód
 4	Èíslo zboží dodavatele                  Char	25	35	-	59	zleva	N	N
 5	Typ položky                             Char	3	60	-	62	zleva	N	N	 Z - zboží, O -  obaly
 6	Množství                                Num	12.3	63	-	74	zprava	P	P	délka 12 vèetnì 3 des. míst a oddìlovaèe (teèka)
 7	Cena za jednotku pøed odeètením slev    Num	12.2	75	-	86	zprava	P	P	délka 12 vèetnì 2 des. míst a oddìlovaèe (teèka)
 8	Sleva na položce                        Num	7.3	87	-	93	zprava	N	N	délka 7 vèetnì 3 des. míst a oddìlovaèe (teèka)
 9	Èástka slevy na jednotku (absolutnì)    Num	12.2	94	-	105	zprava	N	N
10	Cena za jednotku po odeètení slev       Num	12.2	106	-	117	zprava	N	N	délka 12 vèetnì 2 des. míst a oddìlovaèe (teèka)
11	Celková cena za položku                 Num	12.2	118	-	129	zprava	P	P	délka 12 vèetnì 2 des. míst a oddìlovaèe (teèka)
12	Sazba DPH                               Num	5.2	130	-	134	zprava	N	P	délka 5 vèetnì 2 des. míst a oddìlovaèe (teèka)
13	Fakturaèní mìrná jednotka               Char	3	135	-	137	zleva	N	N
14	Poèet spotøebitelských jedn.ve fa.jedn. Num	12.3	138	-	149	zprava	N	N	délka 12 vèetnì 3 des. míst a oddìlovaèe (teèka)
15	Skupina spotøební danì-kód              Char	15	150	-	164	zleva	N	(P)
16	Základ pro spotøební daò (množství)     Num	12.3	165	-	176	zprava	N	(P)	délka 12 vèetnì 3 des. míst a oddìlovaèe (teèka)
17	Èástka spotøební danì                   Num	12.2	177	-	188	zprava	N	(P)	délka 12 vèetnì 2 des. míst a oddìlovaèe (teèka)
18	EAN objednatele                         CharN	17	189	-	205	zleva	N	N	EAN kód 13 míst
19	EAN místa dodání                        CharN	17	206	-	222	zleva	N	N	EAN kód 13 míst
20	Datum dodání                            Date	8	223	-	230	zleva	N	N	formát YYYYMMDD
21	Èíslo objednávky zákazníka              Char	15	231	-	245	zleva	N	N
22	Datum vystavení objednávky              Date	8	246	-	253	zleva	N	N	formát YYYYMMDD
23	Èíslo objednávky u dodavatele           Char	15	254	-	268	zleva	N	N
24	Datum pøijetí objednávky u dodavatele   Date	8	269	-	276	zleva	N	N	formát YYYYMMDD
25	Èíslo dodacího listu                    Char	15	277	-	291	zleva	N	N
26	Datum vystavení dodacího listu          Date	8	292	-	299	zleva	N	N	formát YYYYMMDD
27	Význam ref. èísla faktury               Char	3	300	-	302	zleva	N	N
28	Referenèní èíslo fa. (zálohové apod.)   Char	15	303	-	317	zleva	N	N
29	Datum vztahující se k ref. èíslu fa.    Date	8	318	-	325	zleva	N	N	formát YYYYMMDD
30	Stav salda vratných obalù za danou cenu Num	8	326	-	333	zprava	N	N	saldo obalù jednoho typu s danou výší zálohy
31	Obaly dodané                            Num	8	334	-	341	zprava	N	N
32	Obaly vrácené                           Num	8	342	-	349	zprava	N	N
33	Stav salda vrat.ob. jednoho typu celkem Num	8	350	-	357	zprava	N	N	saldo obalù jednoho typu celkem tj. i s rozdílnou zál.
34	Dodateèná specifikace - volný text      Char	70	358	-	427	zleva	N	N


Èíslo	Obecné textové údaje - nepovinný øádek
položky		Typ	Délka	Pozice			Zarovnání	Pov.	Pov. D.D.	Poznámka nebo hodnota položky
TXT	                                		        	od		do
 1	Uvození „TXT"                                   Char	3	1	-	3	zleva	P	P	"TXT"
 2	Volný text 1 - kontakt. osoba., tel., fax atd.	Char	70	4	-	73	zleva	N	N
 3	Volný text 2 - kontakt. osoba., tel., fax atd.	Char	70	74	-	143	zleva	N	N
 4	Volný text 3 - kontakt. osoba., tel., fax atd.	Char	70	144	-	213	zleva	N	N
 5	Volný text 4 - kontakt. osoba., tel., fax atd.	Char	70	214	-	283	zleva	N	N
 6	Volný text 5 - kontakt. osoba., tel., fax atd.	Char	70	284	-	353	zleva	N	N
 7	Volný text 6 - kontakt. osoba., tel., fax atd.	Char	70	354	-	423	zleva	N	N
 8	Volný text 7 - kontakt. osoba., tel., fax atd.	Char	70	424	-	493	zleva	N	N
 9	Volný text 8 - kontakt. osoba., tel., fax atd.	Char	70	494	-	563	zleva	N	N
10	Volný text 9 - kontakt. osoba., tel., fax atd.	Char	70	564	-	633	zleva	N	N
11	Volný text 10 - kontakt. osoba., tel., fax atd.	Char	70	634	-	703	zleva	N	N

*)

interface

uses
  IcTypes, IcConv, IcTools, IcVariab, IcFiles, IcDate, SysUtils,
  NexPath, NexIni, Classes, Forms;

type
  THdr = record
    DocNum: Str15; // Cislo dokladu - danoveho doladu
    DocType: Str3; // Druh dokladu
    DocFunc: Str3; // Finkcia spravy (9-original)
    DocDate: TDateTime; // Datum vystavenia dokladu
    VatDate: TDateTime; // Datum uskutocnenia zdanitelneho plnenia
    StkDate: TDateTime; // Datum vyskladnenia
    DlvDate: TDateTime; // Datum dodania
    BegDate: TDateTime; // Fakturacia od - pre sumarnu fakturu
    EndDate: TDateTime; // FAkturacia do - pre sumarnu fakturu
    ExpDate: TDateTime; // Datum splatnosti
    PayMode: Str3; // Sposob uhrady
    CtrNum: Str15; // Cislo zmluvy
    OceNum: Str15; // Cislo objednavky(zakazky) zakaznika
    OceDate: TDateTime; // Datum vystavenia objednavky(zakazky)
    OcdNum: Str15; // Cislo objednavky(zakazky) u dodavatela
    OcdDate: TDateTime; // Datum prijatia objednavky(zakazky) u dodavatela
    TcdNum: Str15; // Cislo dodacieho listu
    TcdDate: TDateTime; // Datum dodacieho listu
    RefType: Str3; // Vyznam referencneho cisla
    RefNum: Str15; // Cislo referencneho dokladu
    RefDate: TDateTime; // Datum vystavenia referencneho dokladu
    DlrType: Str15; // Dealerska kategoria
    CusEan: Str17;  // EAN kupujuceho
    CusIno: Str15;  // ICO kupujuceho
    CusTin: Str15;  // DIC kupujuceho
    OrdEan: Str17;  // EAN objednavatela
    DlvEan: Str17;  // EAN miesta dodania
    InvEan: Str17;  // EAN fakturacneho miesta
    SupEan: Str17;  // EAN dodavatela
    SupIno: Str15;  // ICO dodavatela
    SupTin: Str15;  // DIC dodavatela
    StkEan: Str17;  // EAN distribucneho skladu dodavatele
    MyConto: Str17; // Cislo bankoveho uctu dodavatela
    BankCode: Str4; // Smerovy kod banky
    CsySymb: Str4;  // Konstantny symbol platby
    VarSymb: Str10; // Variabilny symbol platby
    SpcSymb: Str10; // Specificky symbol platby
    DvzName: Str3;  // Kod menu
  end;

  THdd = record
    CusName1: Str35;  // Kupující - obchodní jméno - 1
    CusName2: Str35;  // Kupující - obchodní jméno - 2
    CusName3: Str35;  // Kupující - obchodní jméno - 3
    CusName4: Str35;  // Kupující - obchodní jméno - 4
    CusName5: Str35;  // Kupující - obchodní jméno - 5
    CusAddr1: Str35;  // Kupující - adresa - ulice a èíslo - 1
    CusAddr2: Str35;  // Kupující - adresa - ulice a èíslo - 2
    CusAddr3: Str35;  // Kupující - adresa - ulice a èíslo - 3
    CusAddr4: Str35;  // Kupující - adresa - ulice a èíslo - 4
    CusCtn: Str35;    // Kupující - adresa - místo
    CusZip: Str6;     // Kupující - adresa - PSÈ
    SupName1: Str35;  // Dodavatel - obchodní jméno - 1
    SupName2: Str35;  // Dodavatel - obchodní jméno - 2
    SupName3: Str35;  // Dodavatel - obchodní jméno - 3
    SupName4: Str35;  // Dodavatel - obchodní jméno - 4
    SupName5: Str35;  // Dodavatel - obchodní jméno - 5
    SupAddr1: Str35;  // Dodavatel - adresa - ulice a èíslo - 1
    SupAddr2: Str35;  // Dodavatel - adresa - ulice a èíslo - 2
    SupAddr3: Str35;  // Dodavatel - adresa - ulice a èíslo - 3
    SupAddr4: Str35;  // Dodavatel - adresa - ulice a èíslo - 4
    SupCtn: Str35;    // Dodavatel - adresa - místo
    SupZip: Str6;     // Dodavatel - adresa - PSÈ
  end;

  TLin = record
    ItmNum: word;       // Èíslo øádku
    BarCode: Str25;     // EAN zboží
    CusCode: Str25;     // Èíslo zboží dodavatele
    GsType: Str3;       // Typ položky
    GsQnt: double;      // Množství
    DPrice: double;     // Cena za jednotku pøed odeètením slev
    DscPrc: double;     // Sleva na položce
    DscVal: double;     // Èástka slevy na jednotku (absolutnì)
    APrice: double;     // Cena za jednotku po odeètení slev
    AValue: double;     // Celková cena za položku
    VatPrc: double;     // Sazba DPH
    MsName: Str3;       // Fakturaèní mìrná jednotka
    PckQnt: double;     // Poèet spotøebitelských jedn.ve fa.jedn.
    TaxGrp: Str15;      // Skupina spotøební danì-kód
    TaxBas: double;     // Základ pro spotøební daò (množství)
    TaxVal: double;     // Èástka spotøební danì
    OrdEan: Str17;      // EAN objednatele
    DlvEan: Str17;      // EAN místa dodání
    DlvDate:TDateTime;  // Datum dodání
    OceNum: Str15;      // Cislo objednavky(zakazky) zakaznika
    OceDate: TDateTime; // Datum vystavenia objednavky(zakazky)
    OcdNum: Str15;      // Cislo objednavky(zakazky) u dodavatela
    OcdDate: TDateTime; // Datum prijatia objednavky(zakazky) u dodavatela
    TcdNum: Str15;      // Èíslo dodacího listu
    TcdDate: TDateTime; // Datum vystavení dodacího listu
    RefType: Str3;      // Vyznam referencneho cisla
    RefNum: Str15;      // Referenèní èíslo fa. (zálohové apod.)
    RefDate: TDateTime; // Datum vztahující se k ref. èíslu fa
    PckSta: word;       // Stav salda vratných obalù za danou cenu
    PckOut: word;       // Obaly dodané
    PckRet: word;       // Obaly vrácené
    PckBlc: word;       // Stav salda vrat.ob. jednoho typu celkem
    Notice: Str70;      // Dodateèná specifikace - volný text
  end;

  TIcdInh = class
    constructor Create(pFileName:ShortString);
    destructor  Destroy; override;
    private
      oItemCount:word;
      oFile: TStrings;
      oFileName: ShortString;
      oHdr: THdr; // Hlavicka HDR
      oHdd: THdd; // Hlavicka HDD
      oLin: TLin; /// Polozky LIN
      oTxt: array[1..10] of Str70; // Cast TXT
      procedure SetFreTxt (Index:byte;pValue:Str70);
    public
      procedure Clear;
      procedure ClearItem;
      procedure AddToSYS;
      procedure AddToHDR;
      procedure AddToHDD;
      procedure AddToLIN;
      procedure AddToTXT;
      procedure SaveToFile;

      property ItemCount:word read oItemCount;
      // Hlavicka HDR
      property DocNum:Str15 write oHDR.DocNum; // Cislo dokladu - danoveho doladu
      property DocType:Str3 write oHDR.DocType; // Druh dokladu
      property DocFunc:Str3 write oHDR.DocFunc; // Finkcia spravy (9-original)
      property DocDate:TDateTime write oHDR.DocDate; // Datum vystavenia dokladu
      property VatDate:TDateTime write oHDR.VatDate; // Datum uskutocnenia zdanitelneho plnenia
      property StkDate:TDateTime write oHDR.StkDate; // Datum vyskladnenia
      property DlvDate:TDateTime write oHDR.DlvDate; // Datum dodania
      property BegDate:TDateTime write oHDR.BegDate; // Fakturacia od - pre sumarnu fakturu
      property EndDate:TDateTime write oHDR.EndDate; // FAkturacia do - pre sumarnu fakturu
      property ExpDate:TDateTime write oHDR.ExpDate; // Datum splatnosti
      property PayMode:Str3 write oHDR.PayMode; // Sposob uhrady
      property CtrNum:Str15 write oHDR.CtrNum; // Cislo zmluvy
      property OceNum:Str15 write oHDR.OceNum; // Cislo objednavky(zakazky) zakaznika
      property OceDate:TDateTime write oHDR.OceDate; // Datum vystavenia objednavky(zakazky)
      property OcdNum:Str15 write oHDR.OcdNum; // Cislo objednavky(zakazky) u dodavatela
      property OcdDate:TDateTime write oHDR.OcdDate; // Datum prijatia objednavky(zakazky) u dodavatela
      property TcdNum:Str15 write oHDR.TcdNum; // Cislo dodacieho listu
      property TcdDate:TDateTime write oHDR.TcdDate; // Datum dodacieho listu
      property RefType:Str3 write oHDR.RefType; // Vyznam referencneho cisla
      property RefNum:Str15 write oHDR.RefNum; // Cislo referencneho dokladu
      property RefDate:TDateTime write oHDR.RefDate; // Datum vystavenia referencneho dokladu
      property DlrType:Str15 write oHDR.DlrType; // Dealerska kategoria
      property CusEan:Str17 write oHDR.CusEan;  // EAN kupujuceho
      property CusIno:Str15 write oHDR.CusIno;  // ICO kupujuceho
      property CusTin:Str15 write oHDR.CusTin;  // DIC kupujuceho
      property OrdEan:Str17 write oHDR.OrdEan;  // EAN objednavatela
      property DlvEan:Str17 write oHDR.DlvEan;  // EAN miesta dodania
      property InvEan:Str17 write oHDR.InvEan;  // EAN fakturacneho miesta
      property SupEan:Str17 write oHDR.SupEan;  // EAN dodavatela
      property SupIno:Str15 write oHDR.SupIno;  // ICO dodavatela
      property SupTin:Str15 write oHDR.SupTin;  // DIC dodavatela
      property StkEan:Str17 write oHDR.StkEan;  // EAN distribucneho skladu dodavatele
      property MyConto:Str17 write oHDR.MyConto; // Cislo bankoveho uctu dodavatela
      property BankCode:Str4 write oHDR.BankCode; // Smerovy kod banky
      property CsySymb:Str4 write oHDR.CsySymb;  // Konstantny symbol platby
      property VarSymb:Str10 write oHDR.VarSymb; // Variabilny symbol platby
      property SpcSymb:Str10 write oHDR.SpcSymb; // Specificky symbol platby
      property DvzName:Str3 write oHDR.DvzName;  // Kod menu
      // Hlavicka HDD
      property CusName1:Str35 write oHDD.CusName1;  // Kupující - obchodní jméno - 1
      property CusName2:Str35 write oHDD.CusName2;  // Kupující - obchodní jméno - 2
      property CusName3:Str35 write oHDD.CusName3;  // Kupující - obchodní jméno - 3
      property CusName4:Str35 write oHDD.CusName4;  // Kupující - obchodní jméno - 4
      property CusName5:Str35 write oHDD.CusName5;  // Kupující - obchodní jméno - 5
      property CusAddr1:Str35 write oHDD.CusAddr1;  // Kupující - adresa - ulice a èíslo - 1
      property CusAddr2:Str35 write oHDD.CusAddr2;  // Kupující - adresa - ulice a èíslo - 2
      property CusAddr3:Str35 write oHDD.CusAddr3;  // Kupující - adresa - ulice a èíslo - 3
      property CusAddr4:Str35 write oHDD.CusAddr4;  // Kupující - adresa - ulice a èíslo - 4
      property CusCtn:Str35 write oHDD.CusCtn;      // Kupující - adresa - místo
      property CusZip:Str6 write oHDD.CusZip;       // Kupující - adresa - PSÈ
      property SupName1:Str35 write oHDD.SupName1;  // Dodavatel - obchodní jméno - 1
      property SupName2:Str35 write oHDD.SupName2;  // Dodavatel - obchodní jméno - 2
      property SupName3:Str35 write oHDD.SupName3;  // Dodavatel - obchodní jméno - 3
      property SupName4:Str35 write oHDD.SupName4;  // Dodavatel - obchodní jméno - 4
      property SupName5:Str35 write oHDD.SupName5;  // Dodavatel - obchodní jméno - 5
      property SupAddr1:Str35 write oHDD.SupAddr1;  // Dodavatel - adresa - ulice a èíslo - 1
      property SupAddr2:Str35 write oHDD.SupAddr2;  // Dodavatel - adresa - ulice a èíslo - 2
      property SupAddr3:Str35 write oHDD.SupAddr3;  // Dodavatel - adresa - ulice a èíslo - 3
      property SupAddr4:Str35 write oHDD.SupAddr4;  // Dodavatel - adresa - ulice a èíslo - 4
      property SupCtn:Str35 write oHDD.SupCtn;      // Dodavatel - adresa - místo
      property SupZip:Str6 write oHDD.SupZip;       // Dodavatel - adresa - PSÈ
      // Hlavicka LIN
      property iItmNum:word write oLIN.ItmNum;        // Èíslo øádku
      property iBarCode:Str25 write oLIN.BarCode;     // EAN zboží
      property iCusCode:Str25 write oLIN.CusCode;     // Èíslo zboží dodavatele
      property iGsType:Str3 write oLIN.GsType;        // Typ položky
      property iGsQnt:double write oLIN.GsQnt;        // Množství
      property iDPrice:double write oLIN.DPrice;      // Cena za jednotku pøed odeètením slev
      property iDscPrc:double write oLIN.DscPrc;      // Sleva na položce
      property iDscVal:double write oLIN.DscVal;      // Èástka slevy na jednotku (absolutnì)
      property iAPrice:double write oLIN.APrice;      // Cena za jednotku po odeètení slev
      property iAValue:double write oLIN.AValue;      // Celková cena za položku
      property iVatPrc:double write oLIN.VatPrc;      // Sazba DPH
      property iMsName:Str3 write oLIN.MsName;        // Fakturaèní mìrná jednotka
      property iPckQnt:double write oLIN.PckQnt;      // Poèet spotøebitelských jedn.ve fa.jedn.
      property iTaxGrp:Str15 write oLIN.TaxGrp;       // Skupina spotøební danì-kód
      property iTaxBas:double write oLIN.TaxBas;      // Základ pro spotøební daò (množství)
      property iTaxVal:double write oLIN.TaxVal;      // Èástka spotøební danì
      property iOrdEan:Str17 write oLIN.OrdEan;       // EAN objednatele
      property iDlvEan:Str17 write oLIN.DlvEan;       // EAN místa dodání
      property iDlvDate:TDateTime write oLIN.DlvDate; // Datum dodání
      property iOceNum:Str15 write oLIN.OceNum;       // Cislo objednavky(zakazky) zakaznika
      property iOceDate:TDateTime write oLIN.OceDate; // Datum vystavenia objednavky(zakazky)
      property iOcdNum:Str15 write oLIN.OcdNum;       // Cislo objednavky(zakazky) u dodavatela
      property iOcdDate:TDateTime write oLIN.OcdDate; // Datum prijatia objednavky(zakazky) u dodavatela
      property iTcdNum:Str15 write oLIN.TcdNum;       // Èíslo dodacího listu
      property iTcdDate:TDateTime write oLIN.TcdDate; // Datum vystavení dodacího listu
      property iRefType:Str3 write oLIN.RefType;      // Vyznam referencneho cisla
      property iRefNum:Str15 write oLIN.RefNum;       // Referenèní èíslo fa. (zálohové apod.)
      property iRefDate:TDateTime write oLIN.RefDate; // Datum vztahující se k ref. èíslu fa
      property iPckSta:word write oLIN.PckSta;        // Stav salda vratných obalù za danou cenu
      property iPckOut:word write oLIN.PckOut;        // Obaly dodané
      property iPckRet:word write oLIN.PckRet;        // Obaly vrácené
      property iPckBlc:word write oLIN.PckBlc;        // Stav salda vrat.ob. jednoho typu celkem
      property iNotice:Str70 write oLIN.Notice;       // Dodateèná specifikace - volný text
      // Volny text TXT
      property FreTxt[Index:byte]:Str70 write SetFreTxt;  // Volny text
  end;

implementation

constructor TIcdInh.Create (pFileName:ShortString);
begin
  oFileName := pFileName;
  oFile := TStringList.Create;
  If FileExistsI (pFileName) then oFile.LoadFromFile(pFileName);
end;

destructor TIcdInh.Destroy;
begin
  FreeAndNil (oFile);
end;

procedure TIcdInh.SetFreTxt (Index:byte;pValue:Str70);
begin
  If (Index>0) and (Index<11) then oTxt[Index] := AlignRight(pValue,70);
end;

procedure TIcdInh.Clear;
begin
  FillChar (oHDR,SizeOf(oHDR),#0);
  FillChar (oHDD,SizeOf(oHDD),#0);
  FillChar (oTXT,SizeOf(oTXT),#0);
end;

procedure TIcdInh.ClearItem;
begin
  FillChar (oLin,SizeOf(oLin),#0);
end;

procedure TIcdInh.AddToSYS;
var mLine:string;
begin
  mLine := 'SYS'+AlignRight(oHDR.CusEan,14)+'E'+'D  96A'+'RECADV'+'P';
  oFile.Add(mLine);
end;

procedure TIcdInh.AddToHDR;
var mLine:string;
begin
  With oHDR do
    mLine := 'HDR'+
             AlignRight(DocNum,15)+   // Cislo dokladu - danoveho doladu
             AlignRight(DocType,3)+   // Druh dokladu
             AlignRight(DocFunc,3)+   // Finkcia spravy (9-original)
             DateToTxt(DocDate)+     // Datum vystavenia dokladu
             DateToTxt(VatDate)+     // Datum uskutocnenia zdanitelneho plnenia
             DateToTxt(StkDate)+     // Datum vyskladnenia
             DateToTxt(DlvDate)+     // Datum dodania
             DateToTxt(BegDate)+     // Fakturacia od - pre sumarnu fakturu
             DateToTxt(EndDate)+     // FAkturacia do - pre sumarnu fakturu
             DateToTxt(ExpDate)+     // Datum splatnosti
             AlignRight(PayMode,3)+   // Sposob uhrady
             AlignRight(CtrNum,15)+   // Cislo zmluvy
             AlignRight(OceNum,15)+   // Cislo objednavky(zakazky) zakaznika
             DateToTxt(OceDate)+     // Datum vystavenia objednavky(zakazky)
             AlignRight(OcdNum,15)+   // Cislo objednavky(zakazky) u dodavatela
             DateToTxt(OcdDate)+     // Datum prijatia objednavky(zakazky) u dodavatela
             AlignRight(TcdNum,15)+   // Cislo dodacieho listu
             DateToTxt(TcdDate)+     // Datum dodacieho listu
             AlignRight(RefType,3)+   // Vyznam referencneho cisla
             AlignRight(RefNum,15)+   // Cislo referencneho dokladu
             DateToTxt(RefDate)+     // Datum vystavenia referencneho dokladu
             AlignRight(DlrType,15)+  // Dealerska kategoria
             AlignRight(CusEan,17)+   // EAN kupujuceho
             AlignRight(CusIno,15)+   // ICO kupujuceho
             AlignRight(CusTin,15)+   // DIC kupujuceho
             AlignRight(OrdEan,17)+   // EAN objednavatela
             AlignRight(DlvEan,17)+   // EAN miesta dodania
             AlignRight(InvEan,17)+   // EAN fakturacneho miesta
             AlignRight(SupEan,17)+   // EAN dodavatela
             AlignRight(SupIno,15)+   // ICO dodavatela
             AlignRight(SupTin,15)+   // DIC dodavatela
             AlignRight(StkEan,17)+   // EAN distribucneho skladu dodavatele
             AlignRight(MyConto,17)+  // Cislo bankoveho uctu dodavatela
             AlignRight(BankCode,4)+  // Smerovy kod banky
             AlignRight(CsySymb,4)+   // Konstantny symbol platby
             AlignRight(VarSymb,10)+  // Variabilny symbol platby
             AlignRight(SpcSymb,10)+  // Specificky symbol platby
             AlignRight(DvzName,3);   // Kod menu
  oFile.Add(mLine);
end;

procedure TIcdInh.AddToHDD;
var mLine:string;
begin
  With oHDD do
    mLine := 'HDD'+
              AlignRight(CusName1,35)+  // Kupující - obchodní jméno - 1
              AlignRight(CusName2,35)+  // Kupující - obchodní jméno - 2
              AlignRight(CusName3,35)+  // Kupující - obchodní jméno - 3
              AlignRight(CusName4,35)+  // Kupující - obchodní jméno - 4
              AlignRight(CusName5,35)+  // Kupující - obchodní jméno - 5
              AlignRight(CusAddr1,35)+  // Kupující - adresa - ulice a èíslo - 1
              AlignRight(CusAddr2,35)+  // Kupující - adresa - ulice a èíslo - 2
              AlignRight(CusAddr3,35)+  // Kupující - adresa - ulice a èíslo - 3
              AlignRight(CusAddr4,35)+  // Kupující - adresa - ulice a èíslo - 4
              AlignRight(CusCtn,35)+    // Kupující - adresa - místo
              AlignRight(CusZip,6)+     // Kupující - adresa - PSÈ
              AlignRight(SupName1,35)+  // Dodavatel - obchodní jméno - 1
              AlignRight(SupName2,35)+  // Dodavatel - obchodní jméno - 2
              AlignRight(SupName3,35)+  // Dodavatel - obchodní jméno - 3
              AlignRight(SupName4,35)+  // Dodavatel - obchodní jméno - 4
              AlignRight(SupName5,35)+  // Dodavatel - obchodní jméno - 5
              AlignRight(SupAddr1,35)+  // Dodavatel - adresa - ulice a èíslo - 1
              AlignRight(SupAddr2,35)+  // Dodavatel - adresa - ulice a èíslo - 2
              AlignRight(SupAddr3,35)+  // Dodavatel - adresa - ulice a èíslo - 3
              AlignRight(SupAddr4,35)+  // Dodavatel - adresa - ulice a èíslo - 4
              AlignRight(SupCtn,35)+    // Dodavatel - adresa - místo
              AlignRight(SupZip,6);     // Dodavatel - adresa - PSÈ
  oFile.Add(mLine);
end;

procedure TIcdInh.AddToLIN;
var mLine:string;
begin
  With oLIN do
    mLine := 'LIN'+
              StrInt(ItmNum,3)+           // Èíslo øádku
              AlignRight(BarCode,25)+     // EAN zboží
              AlignRight(CusCode,25)+     // Èíslo zboží dodavatele
              AlignRight(GsType,3)+       // Typ položky
              StrDoub(GsQnt,12,3)+        // Množství
              StrDoub(DPrice,12,2)+       // Cena za jednotku pøed odeètením slev
              StrDoub(DscPrc,12,3)+       // Sleva na položce
              StrDoub(DscVal,12,2)+       // Èástka slevy na jednotku (absolutnì)    Num	12.2	94	-	105	zprava	N	N
              StrDoub(APrice,12,2)+       // Cena za jednotku po odeètení slev
              StrDoub(AValue,12,2)+       // Celková cena za položku                 Num	12.2	118	-	129	zprava	P	P	délka 12 vèetnì 2 des. míst a oddìlovaèe (teèka)
              StrDoub(VatPrc,5,2)+        // Sazba DPH
              AlignRight(MsName,3)+       // Fakturaèní mìrná jednotka
              StrDoub(PckQnt,12,3)+       // Poèet spotøebitelských jedn.ve fa.jedn. Num	12.3	138	-	149	zprava	N	N	délka 12 vèetnì 3 des. míst a oddìlovaèe (teèka)
              AlignRight(TaxGrp,15)+      // Skupina spotøební danì-kód
              StrDoub(TaxBas,12,3)+       // Základ pro spotøební daò (množství)     Num	12.3	165	-	176	zprava	N	(P)	délka 12 vèetnì 3 des. míst a oddìlovaèe (teèka)
              StrDoub(TaxVal,12,2)+       // Èástka spotøební danì
              AlignRight(OrdEan,17)+      // EAN objednatele
              AlignRight(DlvEan,17)+      // EAN místa dodání
              DateToTxt(DlvDate)+         // Datum dodání
              AlignRight(OceNum,15)+      // Cislo objednavky(zakazky) zakaznika
              DateToTxt(OceDate)+         // Datum vystavenia objednavky(zakazky)
              AlignRight(OcdNum,15)+      // Cislo objednavky(zakazky) u dodavatela
              DateToTxt(OcdDate)+         // Datum prijatia objednavky(zakazky) u dodavatela
              AlignRight(TcdNum,15)+      // Èíslo dodacího listu
              DateToTxt(TcdDate)+         // Datum vystavení dodacího listu
              AlignRight(RefType,3)+      // Vyznam referencneho cisla
              AlignRight(RefNum,15)+      // Referenèní èíslo fa. (zálohové apod.)
              DateToTxt(RefDate)+         // Datum vztahující se k ref. èíslu fa
              StrInt(PckSta,8)+           // Stav salda vratných obalù za danou cenu
              StrInt(PckOut,8)+           // Obaly dodané
              StrInt(PckRet,8)+           // Obaly vrácené
              StrInt(PckBlc,8)+           // Stav salda vrat.ob. jednoho typu celkem
              AlignRight(Notice,70);      // Dodateèná specifikace - volný text
  oFile.Add(mLine);
end;

procedure TIcdInh.AddToTXT;
var mLine:string;
begin
  mLine := 'TXT'+oTxt[1]+oTxt[2]+oTxt[3]+oTxt[4]+oTxt[5]+oTxt[6]+oTxt[7]+oTxt[8]+oTxt[9]+oTxt[10];
  oFile.Add(mLine);
end;

procedure TIcdInh.SaveToFile;
begin
  oFile.SaveToFile(oFileName);
end;

end.
