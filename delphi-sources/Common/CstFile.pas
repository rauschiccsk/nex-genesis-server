unit CstFile;
{$F+}

interface

uses
  IcTypes, IcConv, IcTools, IcVariab, IcDate, SysUtils,
  NexPath, NexIni, TxtWrap, TxtCut, Forms, Classes;

type
  TData = record
    WriNum:word;       // Èíslo prevádzkovej jednotky na ktorý bol vystavený doklad (celé èíslo)
    DocNum:Str12;      // Èíslo dokladu predaja (text max 12 znakov)
    ItmNum:longint;    // Èíslo riadku dokladu predaja (celé èíslo)
    DocDate:TDateTime; // Dátum uskutoènenia predaja (formát: dd.mm.yyyy)
    DocTime:Str5;      // Èas uskutoènenia predaja (formát: hh:mm)
    SalType:Str1;      // Typ predaja (text 1 znak, možné hodnoty: C - registraèná pokladòa, D - dodací list, F - faktúra)
    GsCode:longint;    // Tovarove cislo (PLU) predaneho tovaru
    MgCode:longint;    // Tovarová skupina (celé èíslo)
    FgCode:longint;    // Finanèná skupina (celé èíslo)
    GsName:Str30;      // Názov tovaru (text max 30 znakov)
    BarCode:Str15;     // Identifikaèný kód tovaru (text max 15 znakov)
    StkCode:Str15;     // Skladový kód tovaru (text max 15 znakov)
    OsdCode:Str15;     // Objednávací kód tovaru (text max 15 znakov)
    GsQnt:double;      // Množstvo predaného tovaru (desatinné èíslo 3 desatinnými miestami)
    MsName:Str10;      // Merná jednotka tovaru
    VatPrc:double;     // Percentuálna sadzba DPH (desatinné èíslo, formát: ##.#)
    CusCrd:Str20;      // Identifikaèný kód zákazníckej karty (text max 20 znakov)
    PaCode:longint;    // Interný kód odberate¾a (celé èíslo)
    RegIno:Str10;      // IÈO odberate¾a (text max 10 znakov)
    PaName:Str30;      // Názov odberate¾a (text max 30 znakov)
    ZipCode:Str6;      // PSÈ obce alebo mesta kam tovar bol predaný (text max 6 znakov)
    DlrCode:word;      // Kód obchodného zástupcu (celé èíslo)
    RspCode:Str8;      // Identifikátor odbytového pracovníka alebo pokladníka, ktorý predal položku (text max 8 znakov)
    RspName:Str30;     // Meno a priezvisko odbytového pracovníka alebo pokladníka, ktorý predal položku (text max 30 znakov)
    AcCValue:double;   // Hodnota predaja v NC bez DPH v tuzemskej mene (desatinné èíslo 2 desatinnými miestami)
    FgDValue:double;   // Hodnota predaja v PC bez DPH pred z¾avou vo vyúètovacej mene (desatinné èíslo 2 desatinnými miestami)
    FgHValue:double;   // Hodnota predaja v PC s DPH pred z¾avou vo vyúètovacej mene (desatinné èíslo 2 desatinnými miestami)
    DscPrc:double;     // Percentuálna hodnota z¾avy (desatinné èíslo 2 desatinnými miestami)
    DscType:Str1;      // Typ z¾avy (text max 1 znak)
    FgAValue:double;   // Hodnota predaja v PC bez DPH po z¾ave vo vyúètovacej mene (desatinné èíslo 2 desatinnými miestami)
    FgBValue:double;   // Hodnota predaja v PC s DPH po z¾ave vo vyúètovacej mene (desatinné èíslo 2 desatinnými miestami)
    FgCourse:double;   // Kurz vyúètovacej meny (desatinné èíslo 5 desatinnými miestami)
    FgDvzName:Str3;    // Názov vyúètovacej meny (text max 3 znaky)
  end;

  TCstFile = class
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
      procedure SaveToFile (pWriNum:word;pDocDate:TDateTime);  // Ulozi zadany udaje do textoveho suboru
      procedure LoadFromFile (pFileName:ShortString);  // Nacita udaje z textoveho suboru
    published
      property Count:word read oCount;
      property Eof:boolean read oEof;
      property WriNum:word read oData.WriNum write oData.WriNum;      // Èíslo riadku dokladu predaja (celé èíslo)
      property DocNum:Str12 read oData.DocNum write oData.DocNum;        // Èíslo dokladu predaja (text max 12 znakov)
      property ItmNum:longint read oData.ItmNum write oData.ItmNum;      // Èíslo riadku dokladu predaja (celé èíslo)
      property DocDate:TDateTime read oData.DocDate write oData.DocDate; // Dátum uskutoènenia predaja (formát: dd.mm.yyyy)
      property DocTime:Str5 read oData.DocTime write oData.DocTime; // Èas uskutoènenia predaja (formát: hh:mm)
      property SalType:Str1 read oData.SalType write oData.SalType; // Typ predaja (text 1 znak, možné hodnoty: C - registraèná pokladòa, D - dodací list, F - faktúra)
      property GsCode:longint read oData.GsCode write oData.GsCode; // Tovarová skupina (celé èíslo)
      property MgCode:longint read oData.MgCode write oData.MgCode; // Tovarová skupina (celé èíslo)
      property FgCode:longint read oData.FgCode write oData.FgCode; // Finanèná skupina (celé èíslo)
      property GsName:Str30 read oData.GsName write oData.GsName;   // Názov tovaru (text max 30 znakov)
      property BarCode:Str15 read oData.BarCode write oData.BarCode; // Identifikaèný kód tovaru (text max 15 znakov)
      property StkCode:Str15 read oData.StkCode write oData.StkCode; // Skladový kód tovaru (text max 15 znakov)
      property OsdCode:Str15 read oData.OsdCode write oData.OsdCode; // Objednávací kód tovaru (text max 15 znakov)
      property GsQnt:double read oData.GsQnt write oData.GsQnt;     // Množstvo predaného tovaru (desatinné èíslo 3 desatinnými miestami)
      property MsName:Str10 read oData.MsName write oData.MsName;   // Merná jednotka tovaru
      property VatPrc:double read oData.VatPrc write oData.VatPrc;   // Percentuálna sadzba DPH (desatinné èíslo, formát: ##.#)
      property CusCrd:Str20 read oData.CusCrd write oData.CusCrd;    // Identifikaèný kód zákazníckej karty (text max 20 znakov)
      property PaCode:longint read oData.PaCode write oData.PaCode;  // Interný kód odberate¾a (celé èíslo)
      property RegIno:Str10 read oData.RegIno write oData.RegIno;    // IÈO odberate¾a (text max 10 znakov)
      property PaName:Str30 read oData.PaName write oData.PaName;    // Názov odberate¾a (text max 30 znakov)
      property ZipCode:Str6 read oData.ZipCode write oData.ZipCode;  // PSÈ obce alebo mesta kam tovar bol predaný (text max 6 znakov)
      property DlrCode:word read oData.DlrCode write oData.DlrCode;  // Kód obchodného zástupcu (celé èíslo)
      property RspCode:Str8 read oData.RspCode write oData.RspCode;  // Identifikátor odbytového pracovníka alebo pokladníka, ktorý predal položku (text max 8 znakov)
      property RspName:Str30 read oData.RspName write oData.RspName; // Meno a priezvisko odbytového pracovníka alebo pokladníka, ktorý predal položku (text max 30 znakov)
      property AcCValue:double read oData.AcCValue write oData.AcCValue; // Hodnota predaja v NC bez DPH v tuzemskej mene (desatinné èíslo 2 desatinnými miestami)
      property FgDValue:double read oData.FgDValue write oData.FgDValue; // Hodnota predaja v PC bez DPH pred z¾avou vo vyúètovacej mene (desatinné èíslo 2 desatinnými miestami)
      property FgHValue:double read oData.FgHValue write oData.FgHValue; // Hodnota predaja v PC s DPH pred z¾avou vo vyúètovacej mene (desatinné èíslo 2 desatinnými miestami)
      property DscPrc:double read oData.DscPrc write oData.DscPrc;       // Percentuálna hodnota z¾avy (desatinné èíslo 2 desatinnými miestami)
      property DscType:Str1 read oData.DscType write oData.DscType;      // Typ z¾avy (text max 1 znak)
      property FgAValue:double read oData.FgAValue write oData.FgAValue; // Hodnota predaja v PC bez DPH po z¾ave vo vyúètovacej mene (desatinné èíslo 2 desatinnými miestami)
      property FgBValue:double read oData.FgBValue write oData.FgBValue; // Hodnota predaja v PC s DPH po z¾ave vo vyúètovacej mene (desatinné èíslo 2 desatinnými miestami)
      property FgCourse:double read oData.FgCourse write oData.FgCourse; // Kurz vyúètovacej meny (desatinné èíslo 5 desatinnými miestami)
      property FgDvzName:Str3 read oData.FgDvzName write oData.FgDvzName;// Názov vyúètovacej meny (text max 3 znaky)
  end;

implementation

constructor TCstFile.Create;
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

destructor TCstFile.Destroy;
begin
  FreeAndNil (oTxtCut);
  FreeAndNil (oTxtWrap);
  FreeAndNil (oFile);
end;

procedure TCstFile.Clear; // Vybuluje udaje polozky - datovy baffer
begin
  FillChar (oData,SizeOf(TData),#0)
end;

procedure TCstFile.Add; // Prida udaje z datoveho bufferu do textoveho suboru
begin
  oTxtWrap.ClearWrap;
  With oData do begin
    If copy(DocNum,1,2)='ER' then SalType := 'C';
    If copy(DocNum,1,2)='OD' then SalType := 'D';
    If copy(DocNum,1,2)='OF' then SalType := 'F';
    oTxtWrap.SetNum (WriNum,0);       // Èíslo prevádzkovej jednotky na ktorý bol vystavený doklad (celé èíslo)
    oTxtWrap.SetText (DocNum,0);      // Èíslo dokladu predaja (text max 12 znakov)
    oTxtWrap.SetNum (ItmNum,0);       // Èíslo riadku dokladu predaja (celé èíslo)
    oTxtWrap.SetDate (DocDate);       // Dátum uskutoènenia predaja (formát: dd.mm.yyyy)
    oTxtWrap.SetText (DocTime,0);     // Èas uskutoènenia predaja (formát: hh:mm)
    oTxtWrap.SetText (SalType,0);     // Typ predaja (text 1 znak, možné hodnoty: C - registraèná pokladòa, D - dodací list, F - faktúra)
    oTxtWrap.SetNum (GsCode,0);       // Tovarove cislo (PLU) predaneho tovaru
    oTxtWrap.SetNum (MgCode,0);       // Tovarová skupina (celé èíslo)
    oTxtWrap.SetNum (FgCode,0);       // Finanèná skupina (celé èíslo)
    oTxtWrap.SetText (ReplaceStr(GsName,';',','),0);      // Názov tovaru (text max 30 znakov)
    oTxtWrap.SetText (BarCode,0);     // Identifikaèný kód tovaru (text max 15 znakov)
    oTxtWrap.SetText (StkCode,0);     // Skladový kód tovaru (text max 15 znakov)
    oTxtWrap.SetText (OsdCode,0);     // Objednávací kód tovaru (text max 15 znakov)
    oTxtWrap.SetReal (GsQnt,0,3);     // Množstvo predaného tovaru (desatinné èíslo 3 desatinnými miestami)
    oTxtWrap.SetText (MsName,0);      // Merná jednotka tovaru
    oTxtWrap.SetReal (VatPrc,0,1);    // Percentuálna sadzba DPH (desatinné èíslo, formát: ##.#)
    oTxtWrap.SetText (CusCrd,0);      // Identifikaèný kód zákazníckej karty (text max 20 znakov)
    oTxtWrap.SetNum (PaCode,0);       // Interný kód odberate¾a (celé èíslo)
    oTxtWrap.SetText (RegIno,0);      // IÈO odberate¾a (text max 10 znakov)
    oTxtWrap.SetText (PaName,0);      // Názov odberate¾a (text max 30 znakov)
    oTxtWrap.SetText (ZipCode,0);     // PSÈ obce alebo mesta kam tovar bol predaný (text max 6 znakov)
    oTxtWrap.SetNum (DlrCode,0);      // Kód obchodného zástupcu (celé èíslo)
    oTxtWrap.SetText (RspCode,0);     // Identifikátor odbytového pracovníka alebo pokladníka, ktorý predal položku (text max 8 znakov)
    oTxtWrap.SetText (RspName,0);     // Meno a priezvisko odbytového pracovníka alebo pokladníka, ktorý predal položku (text max 30 znakov)
    oTxtWrap.SetReal (AcCValue,0,2);  // Hodnota predaja v NC bez DPH v tuzemskej mene (desatinné èíslo 2 desatinnými miestami)
    oTxtWrap.SetReal (FgDValue,0,2);  // Hodnota predaja v PC bez DPH pred z¾avou vo vyúètovacej mene (desatinné èíslo 2 desatinnými miestami)
    oTxtWrap.SetReal (FgHValue,0,2);  // Hodnota predaja v PC s DPH pred z¾avou vo vyúètovacej mene (desatinné èíslo 2 desatinnými miestami)
    oTxtWrap.SetReal (DscPrc,0,2);    // Percentuálna hodnota z¾avy (desatinné èíslo 2 desatinnými miestami)
    oTxtWrap.SetText (DscType,0);     // Typ z¾avy (text max 1 znak)
    oTxtWrap.SetReal (FgAValue,0,2);  // Hodnota predaja v PC bez DPH po z¾ave vo vyúètovacej mene (desatinné èíslo 2 desatinnými miestami)
    oTxtWrap.SetReal (FgBValue,0,2);  // Hodnota predaja v PC s DPH po z¾ave vo vyúètovacej mene (desatinné èíslo 2 desatinnými miestami)
    oTxtWrap.SetReal (FgCourse,0,2);  // Kurz vyúètovacej meny (desatinné èíslo 5 desatinnými miestami)
    oTxtWrap.SetText (FgDvzName,0); // Názov vyúètovacej meny (text max 3 znaky)
  end;
  oFile.Add (oTxtWrap.GetWrapText);
end;

procedure TCstFile.First; // Skoci na prvy zaznam
begin
  oIndex := 0;
  LoadData;  // Nacita riadok textoveho suboru do datoveho bufferu
end;

procedure TCstFile.Next; // Skoci na nasledujuci zaznam
begin
  oEof := oIndex=oFile.Count-1;
  If not oEof then begin
    Inc (oIndex);
    LoadData;  // Nacita riadok textoveho suboru do datoveho bufferu
  end;
end;

procedure TCstFile.LoadData; // Nacita riadok textoveho suboru do datoveho bufferu
begin
  oTxtCut.SetStr(oFile.Strings[oIndex]);
  With oData do begin
    WriNum := oTxtCut.GetNum(1);      // Èíslo prevádzkovej jednotky na ktorý bol vystavený doklad (celé èíslo)
    DocNum := oTxtCut.GetText(2);     // Èíslo dokladu predaja (text max 12 znakov)
    ItmNum := oTxtCut.GetNum(3);      // Èíslo riadku dokladu predaja (celé èíslo)
    DocDate := oTxtCut.GetDate(4);    // Dátum uskutoènenia predaja (formát: dd.mm.yyyy)
    DocTime := oTxtCut.GetText(5);    // Èas uskutoènenia predaja (formát: hh:mm)
    SalType := oTxtCut.GetText(6);    // Typ predaja (text 1 znak, možné hodnoty: C - registraèná pokladòa, D - dodací list, F - faktúra)
    GsCode := oTxtCut.GetNum(7);      // Tovarove cislo (PLU) predaneho tovaru
    MgCode := oTxtCut.GetNum(8);      // Tovarová skupina (celé èíslo)
    FgCode := oTxtCut.GetNum(9);      // Finanèná skupina (celé èíslo)
    GsName := oTxtCut.GetText(10);     // Názov tovaru (text max 30 znakov)
    BarCode := oTxtCut.GetText(11);   // Identifikaèný kód tovaru (text max 15 znakov)
    StkCode := oTxtCut.GetText(12);   // Skladový kód tovaru (text max 15 znakov)
    OsdCode := oTxtCut.GetText(13);   // Objednávací kód tovaru (text max 15 znakov)
    GsQnt := oTxtCut.GetReal(14);     // Množstvo predaného tovaru (desatinné èíslo 3 desatinnými miestami)
    MsName := oTxtCut.GetText(15);    // Merná jednotka tovaru
    VatPrc := oTxtCut.GetReal(16);    // Percentuálna sadzba DPH (desatinné èíslo, formát: ##.#)
    CusCrd := oTxtCut.GetText(17);    // Identifikaèný kód zákazníckej karty (text max 20 znakov)
    PaCode := oTxtCut.GetNum(18);     // Interný kód odberate¾a (celé èíslo)
    RegIno := oTxtCut.GetText(19);    // IÈO odberate¾a (text max 10 znakov)
    PaName := oTxtCut.GetText(20);    // Názov odberate¾a (text max 30 znakov)
    ZipCode := oTxtCut.GetText(21);   // PSÈ obce alebo mesta kam tovar bol predaný (text max 6 znakov)
    DlrCode := oTxtCut.GetNum(22);    // Kód obchodného zástupcu (celé èíslo)
    RspCode := oTxtCut.GetText(23);   // Identifikátor odbytového pracovníka alebo pokladníka, ktorý predal položku (text max 8 znakov)
    RspName := oTxtCut.GetText(24);   // Meno a priezvisko odbytového pracovníka alebo pokladníka, ktorý predal položku (text max 30 znakov)
    AcCValue := oTxtCut.GetReal(25);  // Hodnota predaja v NC bez DPH v tuzemskej mene (desatinné èíslo 2 desatinnými miestami)
    FgDValue := oTxtCut.GetReal(26);  // Hodnota predaja v PC bez DPH pred z¾avou vo vyúètovacej mene (desatinné èíslo 2 desatinnými miestami)
    FgHValue := oTxtCut.GetReal(27);  // Hodnota predaja v PC s DPH pred z¾avou vo vyúètovacej mene (desatinné èíslo 2 desatinnými miestami)
    DscPrc := oTxtCut.GetReal(28);    // Percentuálna hodnota z¾avy (desatinné èíslo 2 desatinnými miestami)
    DscType := oTxtCut.GetText(29);   // Typ z¾avy (text max 1 znak)
    FgAValue := oTxtCut.GetReal(30);  // Hodnota predaja v PC bez DPH po z¾ave vo vyúètovacej mene (desatinné èíslo 2 desatinnými miestami)
    FgBValue := oTxtCut.GetReal(31);  // Hodnota predaja v PC s DPH po z¾ave vo vyúètovacej mene (desatinné èíslo 2 desatinnými miestami)
    FgCourse := oTxtCut.GetReal(32);  // Kurz vyúètovacej meny (desatinné èíslo 5 desatinnými miestami)
    FgDvzName := oTxtCut.GetText(33); // Názov vyúètovacej meny (text max 3 znaky)
  end;
end;

procedure TCstFile.SaveToFile (pWriNum:word;pDocDate:TDateTime);  // Ulozi zadany udaje do textoveho suboru
var mFileName:string;
begin
  If oFile.Count>0 then begin
    If not DirectoryExists (gPath.StiPath) then ForceDirectories (gPath.StiPath);
    mFileName := gPath.StiPath+'S'+StrIntZero(pWriNum,3)+DateToFileName(pDocDate)+'.TXT';
    If FileExists (mFileName) then DeleteFile (mFileName);
    oFile.SaveToFile (mFileName);
    oFile.Clear;
  end;
end;

procedure TCstFile.LoadFromFile  (pFileName:ShortString);  // Nacita udaje z textoveho suboru
begin
  If FileExists (gPath.StiPath+pFileName) then begin
    oFile.Clear;
    oFile.LoadFromFile (gPath.StiPath+pFileName);
    oCount := oFile.Count;
  end;
end;

end.
