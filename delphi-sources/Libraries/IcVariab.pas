unit IcVariab;

interface

uses StrListEdit, SysUtils, IcTypes, Classes, Graphics, Windows;

const
    cFirst=0; // Prvy - napriklad pri hromadnej tlace prvy doklad
    cNext=1;  // Dalsi - napriklad pri hromadnej tlace dalsie doklady
    cPrgNum=279;  // Poradove cislo tejto verzie systemu
    cPrgVer='22.12';  // Verzia systemu
    cPrgMod='20.08.2025';  // Datum modifikacii programoveho modulu
    cUpgrade:boolean=FALSE; // Ak je TRUE potom jedna sa o aktualizacny program - niektore veci nie su inicialozvano pri aktualizacii
    cFileExistSleepTime:integer=10; // Cakanie pri viacnasobnom volani FileExistI
    cFileExistLoopCount:integer=3; // Pocet opakovani pri viacnasobnom volani FileExistI
    cTableType:byte=0; // Typ databaz 0-Btrieve 1-Paradox
    cNexStart:boolean=False; // Typ NEX kompilacie ci je NEX_START
    cRenumAddSerNum:longint=1000000;   // pri precislovani dokladov
    cSalSmCodes:string[100]='55,58,59,60,61';
type
  TSysVar=record
    MaximizeMode:boolean; // TRUE ak je program spusteny na celu obrazozvku
    TestMode:boolean; // TRUE ak je program spusteny - aby komponenty mohli identifikova5 ci porgram bezi
    Runing:boolean; // TRUE ak je program spusteny - aby komponenty mohli identifikova5 ci porgram bezi
    LastRepExt: Str3;
    ActYear:Str4;
    ActYear2:Str2;
    PrvYear:Str4;
    PrvYear2:Str2;
    ActOrgNum: Str5; // Poradove cislo aktualnej firmy
    ActOrgName: Str30; // Nazov aktualnej firmy
    LoginName: Str8; // Prihlasovacie meno uzivatela
    LoginGroup: word; // Skupina prav prihlaseneho uzivatela
    UserName: Str30; // Cele meno uzivatela
    UsrLev:byte; // Urovaen pristupu
    UsrNum:word; // Numerický kód prihláseného užívate¾a
    Language: Str2;
    DlrCode: byte; // Kod obchodneho zastupcu ktory je priradeny prihlasenemu uzovatelovi
    WriNum: word; // Cislo prevadzkovej jednotky - ktora je zadana v databaza SYSTEM
    FirmaName: Str60;
    DefVatPrc: byte;
    BegGsCode: longint;
    EndGsCode: longint;
    BegPaCode: longint;
    EndPaCode: longint;
    EditFontName: Str30;
    EditFontSize: word;
    LabelFontName: Str30;
    LabelFontSize: word;
    ButtonFontName: Str30;
    ButtonFontSize: word;
    FontCharset: TFontCharset;
    DesignMode: boolean; // Ak je true modifikuju sa Dxx nastavenia v zoznamoch
    SysPath: string; // Systemovy adresar
    Discret: boolean; // Ak je TRUE uzivatel ma pristup k diskretnym udajom ako Nc zisk a pod
    AccShow: boolean; // Ak je TRUE po opuste ni poloziek dokladu su zabrazene na obrazovke uctovne zapisy daneho dokladu
    AccStk: boolean;  // Ak je TRUE uctovanie sa vykonava podla skladov
    AccWri: boolean;  // Ak je TRUE uctovanie sa vykonava podla prevadzkovych jednotiek
    AccCen: boolean;  // Ak je TRUE uctovanie sa vykonava podla stredisk
    MainWri: boolean; // Hlavna pervadzka - centrala
    ModToDsc: boolean; // Zmeny predajnej ceny zapocitat do zisku
    EasLdg: boolean;  // Pouziva sa jednoduche uctovnictvo
    StPRndFrc:byte;   // Pocet miest zaokuhlenia NC
    StQRndFrc:byte;   // Pocet miest zaokuhlenia mnozstva
    StvRndFrc:byte;   // Pocet miest zaokuhlenia hodnoty
    AccDvz:Str3;   // Uctovna mena
    InfDvz:Str3;   // Informacna mena
    RpcUse:boolean; // Ak je TRUE zmeny predajných cien sa zapisujú nie do cenníka ale do požiadaviek - zapína sa automaticky pri zaregistrovaní modulu požiadaviek na zmeny PC
    SecMgc:longint; // Cislo tovrovej skupiny odkial sa zacinaju sluzby (vratane)
    FirstActYearDate:TDateTime;
  end;

procedure RuningOn;
procedure SetActYear   (pValue: Str4);
procedure SetLoginName (pValue: Str20);
procedure SetUserName  (pValue: Str30);
procedure SetUsrLev (pValue:byte);
procedure SetDesignMode (pValue: boolean);
procedure SetLanguage  (pValue: Str2);
procedure SetFirmaName (pValue: Str30);
procedure SetDiscret (pValue: boolean);
procedure SetAccShow (pValue: boolean);
procedure ShowTestLog;
procedure AddToTestLog(pValue:String);

var gvSys: TSysVar;
    gNexLog:TStrings;
    gBankCodeSwift:TStrings;

implementation

uses IcConv;

procedure SetActYear (pValue: Str4);
begin
  gvSys.ActYear:=pValue;
  gvSys.ActYear2:=copy(pValue,3,2);
  gvSys.PrvYear:=StrInt(ValInt(pValue)-1,4);
  gvSys.PrvYear2:=copy(gvSys.PrvYear,3,2);
end;

procedure SetLoginName (pValue: Str20);
begin
  If pValue=''
    then gvSys.LoginName:='NONAME'
    else gvSys.LoginName:=pValue;
end;

procedure SetUserName (pValue: Str30);
begin
  gvSys.UserName:=pValue;
end;

procedure SetUsrLev(pValue:byte);
begin
  gvSys.UsrLev:=pValue;
end;

procedure SetDesignMode (pValue: boolean);
begin
  gvSys.DesignMode:=pValue;
end;

procedure SetLanguage (pValue: Str2);
begin
  gvSys.Language:=UpString(pValue);
  If gvSys.Language='SK' then gvSys.FontCharset:=EASTEUROPE_CHARSET;
  If gvSys.Language='CZ' then gvSys.FontCharset:=EASTEUROPE_CHARSET;
  If gvSys.Language='HU' then gvSys.FontCharset:=EASTEUROPE_CHARSET;
  If gvSys.Language='RU' then gvSys.FontCharset:=RUSSIAN_CHARSET;
  If gvSys.Language='UA' then gvSys.FontCharset:=RUSSIAN_CHARSET;
end;

procedure SetFirmaName (pValue: Str30);
begin
  gvSys.FirmaName:=pValue;
end;

procedure SetDiscret (pValue: boolean);
begin
  gvSys.Discret:=pValue;
end;

procedure SetAccShow (pValue: boolean);
begin
  gvSys.AccShow:=pValue;
end;

procedure RuningOn;
begin
  gvSys.Runing:=TRUE;;
end;

procedure ShowTestLog;
begin
  If gNexLog.Count>0 then StrListEditExecute(gNexLog);
end;

procedure AddToTestLog;
begin
  gNexLog.Add(pValue+';'+DateTimetoStr(Now));
end;

begin
  gvSys.MaximizeMode:=TRUE;
  gvSys.TestMode:=FALSE;
  gvSys.Runing:=FALSE;
  gvSys.ActYear:='2025';
  gvSys.ActYear2:='25';
  gvSys.LoginName:='--------';
  gvSys.UserName:='------------------------------';
  gvSys.UsrLev:=0;
  gvSys.UsrNum:=0;
  gvSys.Language:='SK';
  gvSys.FirmaName:='------------------------------';
  gvSys.DlrCode:=0;
  gvSys.BegGsCode:=0;
  gvSys.EndGsCode:=0;
  gvSys.BegPaCode:=0;
  gvSys.EndPaCode:=0;
  gvSys.EditFontName:='Arial';
  gvSys.EditFontSize:=9;
  gvSys.LabelFontName:='Times New Roman';
  gvSys.LabelFontSize:=10;
  gvSys.ButtonFontName:='Times New Roman';
  gvSys.FontCharSet:=DEFAULT_CHARSET;
  gvSys.ButtonFontSize:=10;
  gvSys.DesignMode:=False;
  gvSys.Discret:=TRUE;
  gvSys.AccShow:=TRUE;
  gvSys.EasLdg:=FALSE;
  gNexLog:=TStringlist.create;
  gBankCodeSwift:=TStringlist.create;
  gBankCodeSwift.Add('0200=SUBASKBX');
  gBankCodeSwift.Add('0720=NBSBSKBX');
  gBankCodeSwift.Add('0900=GIBASKBX');
  gBankCodeSwift.Add('1100=TATRSKBX');
  gBankCodeSwift.Add('1111=UNCRSKBX');
  gBankCodeSwift.Add('3000=SLZBSKBA');
  gBankCodeSwift.Add('3100=LUBASKBX');
  gBankCodeSwift.Add('4900=ISTRSKBA');
  gBankCodeSwift.Add('5200=OTPVSKBX');
  gBankCodeSwift.Add('5600=KOMASK2X');
  gBankCodeSwift.Add('5900=PRVASKBA');
  gBankCodeSwift.Add('6500=POBNSKBA');
  gBankCodeSwift.Add('7300=INGBSKBX');
  gBankCodeSwift.Add('7500=CEKOSKBX');
  gBankCodeSwift.Add('7930=WUSTSKBA');
  gBankCodeSwift.Add('8020=CRLYSKBX');
  gBankCodeSwift.Add('8050=COBASKBX');
  gBankCodeSwift.Add('8100=KOMBSKBA');
  gBankCodeSwift.Add('8120=BSLOSK22');
  gBankCodeSwift.Add('8130=CITISKBA');
  gBankCodeSwift.Add('8160=EXSKSKBX');
  gBankCodeSwift.Add('8170=KBSPSKBX');
  gBankCodeSwift.Add('8180=SPSRSKBA');
  gBankCodeSwift.Add('8300=HSBCSKBA');
  gBankCodeSwift.Add('8320=JTBPSKBA');
  gBankCodeSwift.Add('8330=FIOZSKBA');
  gBankCodeSwift.Add('8400=');
  gBankCodeSwift.Add('8410=RIDBSKBX');
end.

