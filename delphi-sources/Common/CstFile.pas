unit CstFile;
{$F+}

interface

uses
  IcTypes, IcConv, IcTools, IcVariab, IcDate, SysUtils,
  NexPath, NexIni, TxtWrap, TxtCut, Forms, Classes;

type
  TData = record
    WriNum:word;       // ��slo prev�dzkovej jednotky na ktor� bol vystaven� doklad (cel� ��slo)
    DocNum:Str12;      // ��slo dokladu predaja (text max 12 znakov)
    ItmNum:longint;    // ��slo riadku dokladu predaja (cel� ��slo)
    DocDate:TDateTime; // D�tum uskuto�nenia predaja (form�t: dd.mm.yyyy)
    DocTime:Str5;      // �as uskuto�nenia predaja (form�t: hh:mm)
    SalType:Str1;      // Typ predaja (text 1 znak, mo�n� hodnoty: C - registra�n� poklad�a, D - dodac� list, F - fakt�ra)
    GsCode:longint;    // Tovarove cislo (PLU) predaneho tovaru
    MgCode:longint;    // Tovarov� skupina (cel� ��slo)
    FgCode:longint;    // Finan�n� skupina (cel� ��slo)
    GsName:Str30;      // N�zov tovaru (text max 30 znakov)
    BarCode:Str15;     // Identifika�n� k�d tovaru (text max 15 znakov)
    StkCode:Str15;     // Skladov� k�d tovaru (text max 15 znakov)
    OsdCode:Str15;     // Objedn�vac� k�d tovaru (text max 15 znakov)
    GsQnt:double;      // Mno�stvo predan�ho tovaru (desatinn� ��slo 3 desatinn�mi miestami)
    MsName:Str10;      // Mern� jednotka tovaru
    VatPrc:double;     // Percentu�lna sadzba DPH (desatinn� ��slo, form�t: ##.#)
    CusCrd:Str20;      // Identifika�n� k�d z�kazn�ckej karty (text max 20 znakov)
    PaCode:longint;    // Intern� k�d odberate�a (cel� ��slo)
    RegIno:Str10;      // I�O odberate�a (text max 10 znakov)
    PaName:Str30;      // N�zov odberate�a (text max 30 znakov)
    ZipCode:Str6;      // PS� obce alebo mesta kam tovar bol predan� (text max 6 znakov)
    DlrCode:word;      // K�d obchodn�ho z�stupcu (cel� ��slo)
    RspCode:Str8;      // Identifik�tor odbytov�ho pracovn�ka alebo pokladn�ka, ktor� predal polo�ku (text max 8 znakov)
    RspName:Str30;     // Meno a priezvisko odbytov�ho pracovn�ka alebo pokladn�ka, ktor� predal polo�ku (text max 30 znakov)
    AcCValue:double;   // Hodnota predaja v NC bez DPH v tuzemskej mene (desatinn� ��slo 2 desatinn�mi miestami)
    FgDValue:double;   // Hodnota predaja v PC bez DPH pred z�avou vo vy��tovacej mene (desatinn� ��slo 2 desatinn�mi miestami)
    FgHValue:double;   // Hodnota predaja v PC s DPH pred z�avou vo vy��tovacej mene (desatinn� ��slo 2 desatinn�mi miestami)
    DscPrc:double;     // Percentu�lna hodnota z�avy (desatinn� ��slo 2 desatinn�mi miestami)
    DscType:Str1;      // Typ z�avy (text max 1 znak)
    FgAValue:double;   // Hodnota predaja v PC bez DPH po z�ave vo vy��tovacej mene (desatinn� ��slo 2 desatinn�mi miestami)
    FgBValue:double;   // Hodnota predaja v PC s DPH po z�ave vo vy��tovacej mene (desatinn� ��slo 2 desatinn�mi miestami)
    FgCourse:double;   // Kurz vy��tovacej meny (desatinn� ��slo 5 desatinn�mi miestami)
    FgDvzName:Str3;    // N�zov vy��tovacej meny (text max 3 znaky)
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
      property WriNum:word read oData.WriNum write oData.WriNum;      // ��slo riadku dokladu predaja (cel� ��slo)
      property DocNum:Str12 read oData.DocNum write oData.DocNum;        // ��slo dokladu predaja (text max 12 znakov)
      property ItmNum:longint read oData.ItmNum write oData.ItmNum;      // ��slo riadku dokladu predaja (cel� ��slo)
      property DocDate:TDateTime read oData.DocDate write oData.DocDate; // D�tum uskuto�nenia predaja (form�t: dd.mm.yyyy)
      property DocTime:Str5 read oData.DocTime write oData.DocTime; // �as uskuto�nenia predaja (form�t: hh:mm)
      property SalType:Str1 read oData.SalType write oData.SalType; // Typ predaja (text 1 znak, mo�n� hodnoty: C - registra�n� poklad�a, D - dodac� list, F - fakt�ra)
      property GsCode:longint read oData.GsCode write oData.GsCode; // Tovarov� skupina (cel� ��slo)
      property MgCode:longint read oData.MgCode write oData.MgCode; // Tovarov� skupina (cel� ��slo)
      property FgCode:longint read oData.FgCode write oData.FgCode; // Finan�n� skupina (cel� ��slo)
      property GsName:Str30 read oData.GsName write oData.GsName;   // N�zov tovaru (text max 30 znakov)
      property BarCode:Str15 read oData.BarCode write oData.BarCode; // Identifika�n� k�d tovaru (text max 15 znakov)
      property StkCode:Str15 read oData.StkCode write oData.StkCode; // Skladov� k�d tovaru (text max 15 znakov)
      property OsdCode:Str15 read oData.OsdCode write oData.OsdCode; // Objedn�vac� k�d tovaru (text max 15 znakov)
      property GsQnt:double read oData.GsQnt write oData.GsQnt;     // Mno�stvo predan�ho tovaru (desatinn� ��slo 3 desatinn�mi miestami)
      property MsName:Str10 read oData.MsName write oData.MsName;   // Mern� jednotka tovaru
      property VatPrc:double read oData.VatPrc write oData.VatPrc;   // Percentu�lna sadzba DPH (desatinn� ��slo, form�t: ##.#)
      property CusCrd:Str20 read oData.CusCrd write oData.CusCrd;    // Identifika�n� k�d z�kazn�ckej karty (text max 20 znakov)
      property PaCode:longint read oData.PaCode write oData.PaCode;  // Intern� k�d odberate�a (cel� ��slo)
      property RegIno:Str10 read oData.RegIno write oData.RegIno;    // I�O odberate�a (text max 10 znakov)
      property PaName:Str30 read oData.PaName write oData.PaName;    // N�zov odberate�a (text max 30 znakov)
      property ZipCode:Str6 read oData.ZipCode write oData.ZipCode;  // PS� obce alebo mesta kam tovar bol predan� (text max 6 znakov)
      property DlrCode:word read oData.DlrCode write oData.DlrCode;  // K�d obchodn�ho z�stupcu (cel� ��slo)
      property RspCode:Str8 read oData.RspCode write oData.RspCode;  // Identifik�tor odbytov�ho pracovn�ka alebo pokladn�ka, ktor� predal polo�ku (text max 8 znakov)
      property RspName:Str30 read oData.RspName write oData.RspName; // Meno a priezvisko odbytov�ho pracovn�ka alebo pokladn�ka, ktor� predal polo�ku (text max 30 znakov)
      property AcCValue:double read oData.AcCValue write oData.AcCValue; // Hodnota predaja v NC bez DPH v tuzemskej mene (desatinn� ��slo 2 desatinn�mi miestami)
      property FgDValue:double read oData.FgDValue write oData.FgDValue; // Hodnota predaja v PC bez DPH pred z�avou vo vy��tovacej mene (desatinn� ��slo 2 desatinn�mi miestami)
      property FgHValue:double read oData.FgHValue write oData.FgHValue; // Hodnota predaja v PC s DPH pred z�avou vo vy��tovacej mene (desatinn� ��slo 2 desatinn�mi miestami)
      property DscPrc:double read oData.DscPrc write oData.DscPrc;       // Percentu�lna hodnota z�avy (desatinn� ��slo 2 desatinn�mi miestami)
      property DscType:Str1 read oData.DscType write oData.DscType;      // Typ z�avy (text max 1 znak)
      property FgAValue:double read oData.FgAValue write oData.FgAValue; // Hodnota predaja v PC bez DPH po z�ave vo vy��tovacej mene (desatinn� ��slo 2 desatinn�mi miestami)
      property FgBValue:double read oData.FgBValue write oData.FgBValue; // Hodnota predaja v PC s DPH po z�ave vo vy��tovacej mene (desatinn� ��slo 2 desatinn�mi miestami)
      property FgCourse:double read oData.FgCourse write oData.FgCourse; // Kurz vy��tovacej meny (desatinn� ��slo 5 desatinn�mi miestami)
      property FgDvzName:Str3 read oData.FgDvzName write oData.FgDvzName;// N�zov vy��tovacej meny (text max 3 znaky)
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
    oTxtWrap.SetNum (WriNum,0);       // ��slo prev�dzkovej jednotky na ktor� bol vystaven� doklad (cel� ��slo)
    oTxtWrap.SetText (DocNum,0);      // ��slo dokladu predaja (text max 12 znakov)
    oTxtWrap.SetNum (ItmNum,0);       // ��slo riadku dokladu predaja (cel� ��slo)
    oTxtWrap.SetDate (DocDate);       // D�tum uskuto�nenia predaja (form�t: dd.mm.yyyy)
    oTxtWrap.SetText (DocTime,0);     // �as uskuto�nenia predaja (form�t: hh:mm)
    oTxtWrap.SetText (SalType,0);     // Typ predaja (text 1 znak, mo�n� hodnoty: C - registra�n� poklad�a, D - dodac� list, F - fakt�ra)
    oTxtWrap.SetNum (GsCode,0);       // Tovarove cislo (PLU) predaneho tovaru
    oTxtWrap.SetNum (MgCode,0);       // Tovarov� skupina (cel� ��slo)
    oTxtWrap.SetNum (FgCode,0);       // Finan�n� skupina (cel� ��slo)
    oTxtWrap.SetText (ReplaceStr(GsName,';',','),0);      // N�zov tovaru (text max 30 znakov)
    oTxtWrap.SetText (BarCode,0);     // Identifika�n� k�d tovaru (text max 15 znakov)
    oTxtWrap.SetText (StkCode,0);     // Skladov� k�d tovaru (text max 15 znakov)
    oTxtWrap.SetText (OsdCode,0);     // Objedn�vac� k�d tovaru (text max 15 znakov)
    oTxtWrap.SetReal (GsQnt,0,3);     // Mno�stvo predan�ho tovaru (desatinn� ��slo 3 desatinn�mi miestami)
    oTxtWrap.SetText (MsName,0);      // Mern� jednotka tovaru
    oTxtWrap.SetReal (VatPrc,0,1);    // Percentu�lna sadzba DPH (desatinn� ��slo, form�t: ##.#)
    oTxtWrap.SetText (CusCrd,0);      // Identifika�n� k�d z�kazn�ckej karty (text max 20 znakov)
    oTxtWrap.SetNum (PaCode,0);       // Intern� k�d odberate�a (cel� ��slo)
    oTxtWrap.SetText (RegIno,0);      // I�O odberate�a (text max 10 znakov)
    oTxtWrap.SetText (PaName,0);      // N�zov odberate�a (text max 30 znakov)
    oTxtWrap.SetText (ZipCode,0);     // PS� obce alebo mesta kam tovar bol predan� (text max 6 znakov)
    oTxtWrap.SetNum (DlrCode,0);      // K�d obchodn�ho z�stupcu (cel� ��slo)
    oTxtWrap.SetText (RspCode,0);     // Identifik�tor odbytov�ho pracovn�ka alebo pokladn�ka, ktor� predal polo�ku (text max 8 znakov)
    oTxtWrap.SetText (RspName,0);     // Meno a priezvisko odbytov�ho pracovn�ka alebo pokladn�ka, ktor� predal polo�ku (text max 30 znakov)
    oTxtWrap.SetReal (AcCValue,0,2);  // Hodnota predaja v NC bez DPH v tuzemskej mene (desatinn� ��slo 2 desatinn�mi miestami)
    oTxtWrap.SetReal (FgDValue,0,2);  // Hodnota predaja v PC bez DPH pred z�avou vo vy��tovacej mene (desatinn� ��slo 2 desatinn�mi miestami)
    oTxtWrap.SetReal (FgHValue,0,2);  // Hodnota predaja v PC s DPH pred z�avou vo vy��tovacej mene (desatinn� ��slo 2 desatinn�mi miestami)
    oTxtWrap.SetReal (DscPrc,0,2);    // Percentu�lna hodnota z�avy (desatinn� ��slo 2 desatinn�mi miestami)
    oTxtWrap.SetText (DscType,0);     // Typ z�avy (text max 1 znak)
    oTxtWrap.SetReal (FgAValue,0,2);  // Hodnota predaja v PC bez DPH po z�ave vo vy��tovacej mene (desatinn� ��slo 2 desatinn�mi miestami)
    oTxtWrap.SetReal (FgBValue,0,2);  // Hodnota predaja v PC s DPH po z�ave vo vy��tovacej mene (desatinn� ��slo 2 desatinn�mi miestami)
    oTxtWrap.SetReal (FgCourse,0,2);  // Kurz vy��tovacej meny (desatinn� ��slo 5 desatinn�mi miestami)
    oTxtWrap.SetText (FgDvzName,0); // N�zov vy��tovacej meny (text max 3 znaky)
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
    WriNum := oTxtCut.GetNum(1);      // ��slo prev�dzkovej jednotky na ktor� bol vystaven� doklad (cel� ��slo)
    DocNum := oTxtCut.GetText(2);     // ��slo dokladu predaja (text max 12 znakov)
    ItmNum := oTxtCut.GetNum(3);      // ��slo riadku dokladu predaja (cel� ��slo)
    DocDate := oTxtCut.GetDate(4);    // D�tum uskuto�nenia predaja (form�t: dd.mm.yyyy)
    DocTime := oTxtCut.GetText(5);    // �as uskuto�nenia predaja (form�t: hh:mm)
    SalType := oTxtCut.GetText(6);    // Typ predaja (text 1 znak, mo�n� hodnoty: C - registra�n� poklad�a, D - dodac� list, F - fakt�ra)
    GsCode := oTxtCut.GetNum(7);      // Tovarove cislo (PLU) predaneho tovaru
    MgCode := oTxtCut.GetNum(8);      // Tovarov� skupina (cel� ��slo)
    FgCode := oTxtCut.GetNum(9);      // Finan�n� skupina (cel� ��slo)
    GsName := oTxtCut.GetText(10);     // N�zov tovaru (text max 30 znakov)
    BarCode := oTxtCut.GetText(11);   // Identifika�n� k�d tovaru (text max 15 znakov)
    StkCode := oTxtCut.GetText(12);   // Skladov� k�d tovaru (text max 15 znakov)
    OsdCode := oTxtCut.GetText(13);   // Objedn�vac� k�d tovaru (text max 15 znakov)
    GsQnt := oTxtCut.GetReal(14);     // Mno�stvo predan�ho tovaru (desatinn� ��slo 3 desatinn�mi miestami)
    MsName := oTxtCut.GetText(15);    // Mern� jednotka tovaru
    VatPrc := oTxtCut.GetReal(16);    // Percentu�lna sadzba DPH (desatinn� ��slo, form�t: ##.#)
    CusCrd := oTxtCut.GetText(17);    // Identifika�n� k�d z�kazn�ckej karty (text max 20 znakov)
    PaCode := oTxtCut.GetNum(18);     // Intern� k�d odberate�a (cel� ��slo)
    RegIno := oTxtCut.GetText(19);    // I�O odberate�a (text max 10 znakov)
    PaName := oTxtCut.GetText(20);    // N�zov odberate�a (text max 30 znakov)
    ZipCode := oTxtCut.GetText(21);   // PS� obce alebo mesta kam tovar bol predan� (text max 6 znakov)
    DlrCode := oTxtCut.GetNum(22);    // K�d obchodn�ho z�stupcu (cel� ��slo)
    RspCode := oTxtCut.GetText(23);   // Identifik�tor odbytov�ho pracovn�ka alebo pokladn�ka, ktor� predal polo�ku (text max 8 znakov)
    RspName := oTxtCut.GetText(24);   // Meno a priezvisko odbytov�ho pracovn�ka alebo pokladn�ka, ktor� predal polo�ku (text max 30 znakov)
    AcCValue := oTxtCut.GetReal(25);  // Hodnota predaja v NC bez DPH v tuzemskej mene (desatinn� ��slo 2 desatinn�mi miestami)
    FgDValue := oTxtCut.GetReal(26);  // Hodnota predaja v PC bez DPH pred z�avou vo vy��tovacej mene (desatinn� ��slo 2 desatinn�mi miestami)
    FgHValue := oTxtCut.GetReal(27);  // Hodnota predaja v PC s DPH pred z�avou vo vy��tovacej mene (desatinn� ��slo 2 desatinn�mi miestami)
    DscPrc := oTxtCut.GetReal(28);    // Percentu�lna hodnota z�avy (desatinn� ��slo 2 desatinn�mi miestami)
    DscType := oTxtCut.GetText(29);   // Typ z�avy (text max 1 znak)
    FgAValue := oTxtCut.GetReal(30);  // Hodnota predaja v PC bez DPH po z�ave vo vy��tovacej mene (desatinn� ��slo 2 desatinn�mi miestami)
    FgBValue := oTxtCut.GetReal(31);  // Hodnota predaja v PC s DPH po z�ave vo vy��tovacej mene (desatinn� ��slo 2 desatinn�mi miestami)
    FgCourse := oTxtCut.GetReal(32);  // Kurz vy��tovacej meny (desatinn� ��slo 5 desatinn�mi miestami)
    FgDvzName := oTxtCut.GetText(33); // N�zov vy��tovacej meny (text max 3 znaky)
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
