unit CsmFile;
{$F+}

interface

uses
  IcTypes, IcConv, IcTools, IcVariab, IcDate, SysUtils,
  NexPath, NexIni, TxtWrap, TxtCut, Forms, Classes;

type
  TData = record
    CrpNum:word;       // Èíslo vlastnej firmy
    DocNum:Str12;      // Èíslo dokladu predaja (text max 12 znakov)
    ItmNum:longint;    // Èíslo riadku dokladu predaja (celé èíslo)
    DocDate:TDateTime; // Dátum uskutoènenia predaja (formát: dd.mm.yyyy)
    WriNum:word;       // Èíslo prevádzkovej jednotky na ktorý bol vystavený doklad (celé èíslo)
    StkNum:word;       // Cislo skladu na ktorom bol vykonany skladovy pohyb
    BarCode:Str15;     // Identifikaèný kód tovaru (text max 15 znakov)
    StkCode:Str15;     // Skladový kód tovaru (text max 15 znakov)
    GsCode:longint;    // Tovarove cislo (PLU) predaneho tovaru
    MgCode:longint;    // Tovarová skupina (celé èíslo)
    FgCode:longint;    // Finanèná skupina (celé èíslo)
    GsName:Str30;      // Názov tovaru (text max 30 znakov)
    VatPrc:double;     // Percentuálna sadzba DPH (desatinné èíslo, formát: ##.#)
    GsQnt:double;      // Množstvo predaného tovaru (desatinné èíslo 3 desatinnými miestami)
    SmCode:word;       // Ciselny kod skladoveho pohybu
    SpaCode:longint;   // Cisleny kod dodavatela
    CpaCode:longint;   // Cisleny kod odberatela
    AcqStat:Str1;      // Priznak obstarania (R-riadny, K-komisionalny)
    ScStkNum:word;     // Cislo skladu odkial tovar prichadza
    TgStkNum:word;     // Cislo skladu kam tovar bol poslany
    AcCValue:double;   // Hodnota polozky v NC bez DPH - v uctovnej mene
    FgBValue:double;   // Hodnota predaja v PC s DPH - VM
    CrtUser:Str8;      // Prihlasovacie meno uzivatela, ktory vytvoril zaznam
    CrtDate:TDateTime; // Datum vytvorenia zaznamu
    CrtTime:Str5;      // Cas vytvorenia zaznamu
  end;

  TCsmFile = class
    constructor Create;
    destructor  Destroy; override;
    private
      oCount:word;
      oTxtWrap: TTxtWrap;
      oTxtCut: TTxtCut;
      oFile: TStrings;
      oData: TData;
      oIndex: word; // Poradove cislo zaznamu na ktorom stojime
      oEof: boolean; // TRUE ak je koniec suboru
    public
      procedure Clear; // Vybuluje udaje polozky - datovy baffer
      procedure Add; // Prida udaje z datoveho bufferu do textoveho suboru
      procedure First; // Skoci na prvy zaznam
      procedure Next; // Skoci na nasledujuci zaznam
      procedure LoadData; // Nacita riadok textoveho suboru do datoveho bufferu
      procedure SaveToFile (pDocDate:TDateTime);  // Ulozi zadany udaje do textoveho suboru
      procedure LoadFromFile (pFileName:ShortString);  // Nacita udaje z textoveho suboru
    published
      property Count:word read oCount;
      property Eof:boolean read oEof;

      property CrpNum:word read oData.CrpNum write oData.CrpNum; // Èíslo vlastnej firmy
      property DocNum:Str12 read oData.DocNum write oData.DocNum; // Èíslo dokladu predaja (text max 12 znakov)
      property ItmNum:longint read oData.ItmNum write oData.ItmNum; // Èíslo riadku dokladu predaja (celé èíslo)
      property DocDate:TDateTime read oData.DocDate write oData.DocDate; // Dátum uskutoènenia predaja (formát: dd.mm.yyyy)
      property WriNum:word read oData.WriNum write oData.WriNum; // Èíslo riadku dokladu predaja (celé èíslo)
      property StkNum:word read oData.StkNum write oData.StkNum; // Èíslo skladu
      property BarCode:Str15 read oData.BarCode write oData.BarCode; // Identifikaèný kód tovaru (text max 15 znakov)
      property StkCode:Str15 read oData.StkCode write oData.StkCode; // Skladový kód tovaru (text max 15 znakov)
      property GsCode:longint read oData.GsCode write oData.GsCode; // Tovarová skupina (celé èíslo)
      property MgCode:longint read oData.MgCode write oData.MgCode; // Tovarová skupina (celé èíslo)
      property FgCode:longint read oData.FgCode write oData.FgCode; // Finanèná skupina (celé èíslo)
      property GsName:Str30 read oData.GsName write oData.GsName; // Názov tovaru (text max 30 znakov)
      property VatPrc:double read oData.VatPrc write oData.VatPrc; // Percentuálna sadzba DPH (desatinné èíslo, formát: ##.#)
      property GsQnt:double read oData.GsQnt write oData.GsQnt; // Množstvo predaného tovaru (desatinné èíslo 3 desatinnými miestami)
      property SmCode:word read oData.SmCode write oData.SmCode; // Ciselny kod skladoveho pohybu
      property SpaCode:longint read oData.SpaCode write oData.SpaCode; // Cisleny kod dodavatela
      property CpaCode:longint read oData.CpaCode write oData.CpaCode; // Cisleny kod odberatela
      property AcqStat:Str1 read oData.AcqStat write oData.AcqStat; // Priznak obstarania (R-riadny, K-komisionalny)
      property ScStkNum:word read oData.ScStkNum write oData.ScStkNum; // Cislo skladu odkial tovar prichadza
      property TgStkNum:word read oData.TgStkNum write oData.TgStkNum; // Cislo skladu kam tovar bol poslany
      property AcCValue:double read oData.AcCValue write oData.AcCValue; // Hodnota predaja v NC bez DPH v tuzemskej mene (desatinné èíslo 2 desatinnými miestami)
      property FgBValue:double read oData.FgBValue write oData.FgBValue; // Hodnota predaja v PC s DPH po z¾ave vo vyúètovacej mene (desatinné èíslo 2 desatinnými miestami)
      property CrtUser:Str8 read oData.CrtUser write oData.CrtUser; // Prihlasovacie meno uzivatela, ktory vytvoril zaznam
      property CrtDate:TDateTime read oData.CrtDate write oData.CrtDate; // Datum vytvorenia zaznamu
      property CrtTime:Str5 read oData.CrtTime write oData.CrtTime; // Cas vytvorenia zaznamu
  end;

implementation

constructor TCsmFile.Create;
begin
  oFile := TStringList.Create;
  oFile.Clear;
  oTxtWrap := TTxtWrap.Create;
  oTxtWrap.SetDelimiter('');
  oTxtWrap.SetSeparator(';');
  oTxtCut := TTxtCut.Create;
  oTxtCut.SetDelimiter('');
  oTxtCut.SetSeparator(';');
end;

destructor TCsmFile.Destroy;
begin
  FreeAndNil (oTxtCut);
  FreeAndNil (oTxtWrap);
  FreeAndNil (oFile);
end;

procedure TCsmFile.Clear; // Vybuluje udaje polozky - datovy baffer
begin
  FillChar (oData,SizeOf(TData),#0)
end;

procedure TCsmFile.Add; // Prida udaje z datoveho bufferu do textoveho suboru
begin
  oTxtWrap.ClearWrap;
  With oData do begin
    oTxtWrap.SetNum (CrpNum,0);     // Èíslo vlastnej firmy
    oTxtWrap.SetText (DocNum,0);    // Èíslo dokladu predaja (text max 12 znakov)
    oTxtWrap.SetNum (ItmNum,0);     // Èíslo riadku dokladu predaja (celé èíslo)
    oTxtWrap.SetDate (DocDate);     // Dátum uskutoènenia predaja (formát: dd.mm.yyyy)
    oTxtWrap.SetNum (WriNum,0);     // Èíslo prevádzkovej jednotky na ktorý bol vystavený doklad (celé èíslo)
    oTxtWrap.SetNum (StkNum,0);     // Cislo skladu na ktorom bol vykonany skladovy pohyb
    oTxtWrap.SetText (BarCode,0);   // Identifikaèný kód tovaru (text max 15 znakov)
    oTxtWrap.SetText (StkCode,0);   // Skladový kód tovaru (text max 15 znakov)
    oTxtWrap.SetNum (GsCode,0);     // Tovarove cislo (PLU) predaneho tovaru
    oTxtWrap.SetNum (MgCode,0);     // Tovarová skupina (celé èíslo)
    oTxtWrap.SetNum (FgCode,0);     // Finanèná skupina (celé èíslo)
    oTxtWrap.SetText (GsName,0);    // Názov tovaru (text max 30 znakov)
    oTxtWrap.SetReal (VatPrc,0,1);  // Percentuálna sadzba DPH (desatinné èíslo, formát: ##.#)
    oTxtWrap.SetReal (GsQnt,0,3);   // Množstvo predaného tovaru (desatinné èíslo 3 desatinnými miestami)
    oTxtWrap.SetNum (SmCode,0);     // Ciselny kod skladoveho pohybu
    oTxtWrap.SetNum (SpaCode,0);    // Cisleny kod dodavatela
    oTxtWrap.SetNum (CpaCode,0);    // Cisleny kod odberatela
    oTxtWrap.SetText (AcqStat,0);   // Priznak obstarania (R-riadny, K-komisionalny)
    oTxtWrap.SetNum (ScStkNum,0);   // Cislo skladu odkial tovar prichadza
    oTxtWrap.SetNum (TgStkNum,0);   // Cislo skladu kam tovar bol poslany
    oTxtWrap.SetReal (AcCValue,0,2);// Hodnota polozky v NC bez DPH - v uctovnej mene
    oTxtWrap.SetReal (FgBValue,0,2);// Hodnota predaja v PC s DPH - VM
    oTxtWrap.SetText (CrtUser,0);   // Prihlasovacie meno uzivatela, ktory vytvoril zaznam
    oTxtWrap.SetDate (CrtDate);     // Datum vytvorenia zaznamu
    oTxtWrap.SetText (CrtTime,0);   // Cas vytvorenia zaznamu
  end;
  oFile.Add (oTxtWrap.GetWrapText);
end;

procedure TCsmFile.First; // Skoci na prvy zaznam
begin
  oIndex := 0;
  LoadData;  // Nacita riadok textoveho suboru do datoveho bufferu
end;

procedure TCsmFile.Next; // Skoci na nasledujuci zaznam
begin
  oEof := oIndex=oFile.Count-1;
  If not oEof then begin
    Inc (oIndex);
    LoadData;  // Nacita riadok textoveho suboru do datoveho bufferu
  end;
end;

procedure TCsmFile.LoadData; // Nacita riadok textoveho suboru do datoveho bufferu
begin
  oTxtCut.SetStr(oFile.Strings[oIndex]);
  With oData do begin
    CrpNum := oTxtCut.GetNum(1);         // Èíslo vlastnej firmy
    DocNum := oTxtCut.GetText(2);        // Èíslo dokladu predaja (text max 12 znakov)
    ItmNum := oTxtCut.GetNum(3);         // Èíslo riadku dokladu predaja (celé èíslo)
    DocDate := oTxtCut.GetDate(4);       // Dátum uskutoènenia predaja (formát: dd.mm.yyyy)
    WriNum := oTxtCut.GetNum(5);         // Èíslo prevádzkovej jednotky na ktorý bol vystavený doklad (celé èíslo)
    StkNum := oTxtCut.GetNum(6);         // Cislo skladu na ktorom bol vykonany skladovy pohyb
    BarCode := oTxtCut.GetText(7);       // Identifikaèný kód tovaru (text max 15 znakov)
    StkCode := oTxtCut.GetText(8);       // Skladový kód tovaru (text max 15 znakov)
    GsCode := oTxtCut.GetNum(9);         // Tovarove cislo (PLU) predaneho tovaru
    MgCode := oTxtCut.GetNum(10);        // Tovarová skupina (celé èíslo)
    FgCode := oTxtCut.GetNum(11);        // Finanèná skupina (celé èíslo)
    GsName := oTxtCut.GetText(12);       // Názov tovaru (text max 30 znakov)
    VatPrc := oTxtCut.GetReal(13);       // Percentuálna sadzba DPH (desatinné èíslo, formát: ##.#)
    GsQnt := oTxtCut.GetReal(14);        // Množstvo predaného tovaru (desatinné èíslo 3 desatinnými miestami)
    SmCode := oTxtCut.GetNum(15);        // Ciselny kod skladoveho pohybu
    SpaCode := oTxtCut.GetNum(16);       // Cisleny kod dodavatela
    CpaCode := oTxtCut.GetNum(17);       // Cisleny kod odberatela
    AcqStat := oTxtCut.GetText(18);      // Priznak obstarania (R-riadny, K-komisionalny)
    ScStkNum := oTxtCut.GetNum(19);      // Cislo skladu odkial tovar prichadza
    TgStkNum := oTxtCut.GetNum(20);      // Cislo skladu kam tovar bol poslany
    AcCValue := oTxtCut.GetReal(21);     // Hodnota polozky v NC bez DPH - v uctovnej mene
    FgBValue := oTxtCut.GetReal(22);     // Hodnota predaja v PC s DPH - VM
    CrtUser := oTxtCut.GetText(23);      // Prihlasovacie meno uzivatela, ktory vytvoril zaznam
    CrtDate := oTxtCut.GetDate(24);      // Datum vytvorenia zaznamu
    CrtTime := oTxtCut.GetText(25);      // Cas vytvorenia zaznamu
  end;
end;

procedure TCsmFile.SaveToFile (pDocDate:TDateTime);  // Ulozi zadany udaje do textoveho suboru
var mFileName:string;
begin
  If oFile.Count>0 then begin
    If not DirectoryExists (gPath.StiPath) then ForceDirectories (gPath.StiPath);
    mFileName := gPath.StiPath+'STM'+StrIntZero(gIni.CrpNum,2)+StrIntZero(gvSys.WriNum,3)+DateToFileName(pDocDate)+'.TXT';
    If FileExists (mFileName) then DeleteFile (mFileName);
    oFile.SaveToFile (mFileName);
    oFile.Clear;
  end;
end;

procedure TCsmFile.LoadFromFile  (pFileName:ShortString);  // Nacita udaje z textoveho suboru
begin
  If FileExists (gPath.StiPath+pFileName) then begin
    oFile.Clear;
    oFile.LoadFromFile (gPath.StiPath+pFileName);
    oCount := oFile.Count;
  end;
end;

end.
