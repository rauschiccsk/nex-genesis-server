unit NpdTxt;
{$F+}

interface

uses
  IcTypes, IcConv, IcTools, IcVariab, IniFiles, SysUtils, NexGlob,
  NexPath, NexIni, TxtWrap, TxtCut, DocHand, TxtDoc, Forms;

type
  TNpdTxt = class
    constructor Create;
    destructor  Destroy; override;
    private
      oDocNum:Str20;       // Interne cislo zaznamu
      oSerNum:word;        // Poradove cislo zaznamu
      oPaIno:Str15;        // ICO firmy, ziadatel riesenia problemu
      oPaWri:word;         // PRJ firmy, ziadatel riesenia problemu
      oPaName:Str60;       // Nazov firmy, ziadatel riesenia problemu
      oDescribe:Str80;     // Strucny popis zazanu o preblemu
      oPrType:byte;        // Typ zaznamu (0-nezadany,1-odstranenie chyby,2-navrh na zlepsenie)
      oPrgCode:Str3;       // Programovy modul, v ktorom bol zaznamenany problem
      oRegDate:TDateTime;   // Datum zaregistrovania zaznamu
      oRegName:Str30;      // Meno osoby, ktory zaregistroval zaznam
      oRegPrior:byte;      // Priorita riesenia problemu
      oSndDate:TDateTime;   // Datum odoslania zaznamu na spracovanie
      oSndTime:TDateTime;   // Cas odoslania zaznamu na spracovanie
      oProDate:TDateTime;   // Datum spracovania zaznamu
      oProTime:TDateTime;   // Cas spracovania zaznamu
      oPlnVers:Str5;       // Verzia systemu v ktorm sa planuje riesenie problemu
      oPlnDate:TDateTime;   // Planovany datum riesenia zaznamu
      oSlvName:Str30;      // Meno osoby, ktory riesi dany problem
      oRsnCode:word;       // Skupina dovodu vziku problemu
      oRsnName:Str30;      // Pomenovanie dovodu vziku problemu
      oSlvGrp:word;        // Skupina riesenia problemu
      oSlvDate:TDateTime;   // Datum vyriesenia problemu
      oSlvTime:TDateTime;   // Cas vyriesenia problemu
      oStatus:Str1;        // Stav zaznamu (C-vyrieseny,X-nevyrieseny)
    public
      oCount:word;
      oTxtDoc: TTxtDoc;
      procedure SaveToFile;  // Ulozi zadany doklad do textoveho suboru
      procedure LoadFromFile (pDocNum:Str12);  // Nacita doklad z textoveho suboru
    published
      property Count:word read oCount;
      property DocNum:Str20 read oDocNum write oDocNum;
      property SerNum:word read oSerNum write oSerNum;
      property PaIno:Str15 read oPaIno write oPaIno;
      property PaWri:word read oPaWri write oPaWri;
      property PaName:Str60 read oPaName write oPaName;
      property Describe:Str80 read oDescribe write oDescribe;
      property PrType:byte read oPrType write oPrType;
      property PrgCode:Str3 read oPrgCode write oPrgCode;
      property RegDate:TDateTime read oRegDate write oRegDate;
      property RegName:Str30 read oRegName write oRegName;
      property RegPrior:byte read oRegPrior write oRegPrior;
      property SndDate:TDateTime read oSndDate write oSndDate;
      property SndTime:TDateTime read oSndTime write oSndTime;
      property ProDate:TDateTime read oProDate write oProDate;
      property ProTime:TDateTime read oProTime write oProTime;
      property PlnVers:Str5 read oPlnVers write oPlnVers;
      property PlnDate:TDateTime read oPlnDate write oPlnDate;
      property SlvName:Str30 read oSlvName write oSlvName;
      property RsnCode:word read oRsnCode write oRsnCode;
      property RsnName:Str30 read oRsnName write oRsnName;
      property SlvGrp:word read oSlvGrp write oSlvGrp;
      property SlvDate:TDateTime read oSlvDate write oSlvDate;
      property SlvTime:TDateTime read oSlvTime write oSlvTime;
      property Status:Str1 read oStatus write oStatus;
  end;

implementation

constructor TNpdTxt.Create;
begin
end;

destructor TNpdTxt.Destroy;
begin
end;

procedure TNpdTxt.SaveToFile;  // Ulozi zadany doklad do textoveho suboru
var mFileName:string;
begin
  mFileName := gPath.MgdPath+oDocNum+'.TXT';
  oTxtDoc := TTxtDoc.Create;
  If FileExists (mFileName) then DeleteFile (mFileName);
  oTxtDoc.WriteString ('PrgVer',cPrgVer);
  oTxtDoc.WriteString ('DocNum',oDocNum);       // Interne cislo zaznamu
  oTxtDoc.WriteString ('PaIno',oPaIno);         // ICO firmy, ziadatel riesenia problemu
  oTxtDoc.WriteInteger ('PaWri',oPaWri);        // PRJ firmy, ziadatel riesenia problemu
  oTxtDoc.WriteString ('PaName',oPaName);       // Nazov firmy, ziadatel riesenia problemu
  oTxtDoc.WriteInteger ('SerNum',oSerNum);      // Poradove cislo zaznamu
  oTxtDoc.WriteString ('Describe',oDescribe);   // Strucny popis zazanu o preblemu
  oTxtDoc.WriteInteger ('PrType',oPrType);      // Typ zaznamu (0-nezadany,1-odstranenie chyby,2-navrh na zlepsenie)
  oTxtDoc.WriteString ('PrgCode',oPrgCode);     // Programovy modul, v ktorom bol zaznamenany problem
  oTxtDoc.WriteDate ('RegDate',oRegDate);       // Datum zaregistrovania zaznamu
  oTxtDoc.WriteString ('RegName',oRegName);     // Meno osoby, ktory zaregistroval zaznam
  oTxtDoc.WriteInteger ('RegPrior',oRegPrior);  // Priorita riesenia problemu
  oTxtDoc.WriteDate ('SndDate',oSndDate);       // Datum odoslania zaznamu na spracovanie
  oTxtDoc.WriteTime ('SndTime',oSndTime);       // Cas odoslania zaznamu na spracovanie
  oTxtDoc.WriteDate ('ProDate',oProDate);       // Datum spracovania zaznamu
  oTxtDoc.WriteTime ('ProTime',oProTime);       // Cas spracovania zaznamu
  oTxtDoc.WriteString ('PlnVers',oPlnVers);     // Verzia systemu v ktorm sa planuje riesenie problemu
  oTxtDoc.WriteDate ('PlnDate',oPlnDate);       // Planovany datum riesenia zaznamu
  oTxtDoc.WriteString ('SlvName',oSlvName);     // Meno osoby, ktory riesi dany problem
  oTxtDoc.WriteInteger ('RsnCode',oRsnCode);    // Skupina dovodu vziku problemu
  oTxtDoc.WriteString ('RsnName',oRsnName);     // Pomenovanie dovodu vziku problemu
  oTxtDoc.WriteInteger ('SlvGrp',oSlvGrp);      // Skupina riesenia problemu
  oTxtDoc.WriteDate ('SlvDate',oSlvDate);       // Datum vyriesenia problemu
  oTxtDoc.WriteTime ('SlvTime',oSlvTime);       // Cas vyriesenia problemu
  oTxtDoc.WriteString ('Status',oStatus);       // Stav zaznamu (C-vyrieseny,X-nevyrieseny)
  oTxtDoc.SaveToFile (mFileName);
  FreeAndNil (oTxtDoc);
end;

procedure TNpdTxt.LoadFromFile (pDocNum:Str12);  // Nacita doklad z textoveho suboru
var mFileName:string;
begin
  mFileName := gPath.MgdPath+oDocNum+'.TXT';
  If FileExists (mFileName) then begin
    oTxtDoc := TTxtDoc.Create;
    oTxtDoc.LoadFromFile (mFileName);
    oDocNum := oTxtDoc.ReadString ('DocNum');       // Interne cislo zaznamu
    oPaIno := oTxtDoc.ReadString ('PaIno');         // ICO firmy, ziadatel riesenia problemu
    oPaWri := oTxtDoc.ReadInteger ('PaWri');        // PRJ firmy, ziadatel riesenia problemu
    oPaName := oTxtDoc.ReadString ('PaName');       // Nazov firmy, ziadatel riesenia problemu
    oSerNum := oTxtDoc.ReadInteger ('SerNum');      // Poradove cislo zaznamu
    oDescribe := oTxtDoc.ReadString ('Describe');   // Strucny popis zazanu o preblemu
    oPrType := oTxtDoc.ReadInteger ('PrType');      // Typ zaznamu (0-nezadany,1-odstranenie chyby,2-navrh na zlepsenie)
    oPrgCode := oTxtDoc.ReadString ('PrgCode');     // Programovy modul, v ktorom bol zaznamenany problem
    oRegDate := oTxtDoc.ReadDate ('RegDate');       // Datum zaregistrovania zaznamu
    oRegName := oTxtDoc.ReadString ('RegName');     // Meno osoby, ktory zaregistroval zaznam
    oRegPrior := oTxtDoc.ReadInteger ('RegPrior');  // Priorita riesenia problemu
    oSndDate := oTxtDoc.ReadDate ('SndDate');       // Datum odoslania zaznamu na spracovanie
    oSndTime := oTxtDoc.ReadTime ('SndTime');       // Cas odoslania zaznamu na spracovanie
    oProDate := oTxtDoc.ReadDate ('ProDate');       // Datum spracovania zaznamu
    oProTime := oTxtDoc.ReadTime ('ProTime');       // Cas spracovania zaznamu
    oPlnVers := oTxtDoc.ReadString ('PlnVers');     // Verzia systemu v ktorm sa planuje riesenie problemu
    oPlnDate := oTxtDoc.ReadDate ('PlnDate');       // Planovany datum riesenia zaznamu
    oSlvName := oTxtDoc.ReadString ('SlvName');     // Meno osoby, ktory riesi dany problem
    oRsnCode := oTxtDoc.ReadInteger ('RsnCode');    // Skupina dovodu vziku problemu
    oRsnName := oTxtDoc.ReadString ('RsnName');     // Pomenovanie dovodu vziku problemu
    oSlvGrp := oTxtDoc.ReadInteger ('SlvGrp');      // Skupina riesenia problemu
    oSlvDate := oTxtDoc.ReadDate ('SlvDate');       // Datum vyriesenia problemu
    oSlvTime := oTxtDoc.ReadTime ('SlvTime');       // Cas vyriesenia problemu
    oStatus := oTxtDoc.ReadString ('Status');       // Stav zaznamu (C-vyrieseny,X-nevyrieseny)
    FreeAndNil (oTxtDoc);
  end;
end;

end.
