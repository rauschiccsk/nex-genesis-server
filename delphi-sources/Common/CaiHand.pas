unit CaiHand;
// *****************************************************************************
//      Ovladac na pracu s polozkami kontrolnej pasky pokladnicneho predaja
// *****************************************************************************
//
// *****************************************************************************

interface

uses
  IcTypes, IcDate, IcConv, IcVariab, IcTools, TxtCut, NexPath, NexGlob,
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms, Dialogs;

type
  THead = record // Udaje hlavicky pokladnicnej uzavierky
    BlkNum:longint;     // Cislo uctenky
    BlkDate:TDateTime;  // Datum vyhotovenia uctenky
    BlkTime:TDateTime;  // Cas vyhotovenia uctenky
    RegIno:Str10;       // ICO zakaznickej firmy
    CrdNum:Str15;       // Kod zakzanickej karty
    StuName:Str8;       // Prihlasovacie meno skladnika
    LgnName:Str8;       // Prihlasovacie meno pokladnika
    UsrName:Str30;      // Meno a priazvisko pokladnika
  end;

  TItem = record // Udaje polozky pokladnicnej uzavierky
    ItmNum:double;      // Cislo riadku uctenky
    MgCode:longint;     // Cislo tovarovej skupiny
    GsCode:longint;     // Tovrove cislo - PLU
    GsName:Str30;       // Nazov predaneho tovaru
    BarCode:Str15;      // Identifikacny kod tovaru
    ProdNum:Str30;      // Vyrobne cislo tovaru
    Action:Str1;        // Akciove oznacenie tovaru
    VatPrc:byte;        // Percentualna sadzba DPH
    StkNum:word;        // Sklad z ktoreho sa odpocita polozka
    GsQnt:double;       // Predane mnozstvo tovaru
    DscPrc:double;      // Percentualna zlavana polozku
    DscVal:double;      // Hodnota zlavy polozky
    PrfPrc:double;      // Percentualna obchodna marza
    BPrice:double;      // Predajna cena s DPH za MJ
    BValue:double;      // Predajna cena s DPH za polozku
  end;

  TCaiHand = class(TForm)
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
  private
    oCasNum:word;    // Cislo pokladne
    oItmCnt:integer; // Riadok na ktorom stoji kurzor textoveho suboru
    oFile:TStrings;  // Textovy subor kontrolnej pasky
    oEof:boolean;    // TRUE k kurzoj je nakoci textoveho suboru
    oCut:TTxtCut;    // Objekt na spracovanie riadku trextoveho suboru
    oHead:THead; // Udaje hlavicky pokladnicnej uctenky
    oItem:TItem; // Udaje polozky pokladnicnej uctenky
    oActItm: integer;  // Aktualna pozicia v textovom subore kde sa nachadza tovarova polozka
    function FileName(pDate:TDateTime):Str12; // Nazov kontrolnej pasky na zadany datum
    procedure LoadHead; // Nacita hlavickove udaje uctenky
    procedure LoadItem; // Nacita polozku uctenky
    function GetAValue:double; // Predajna cena bez DPH za polozku
  public
    function  LoadFrTxt (pCasNum:word; pDate:TDateTime):boolean; // Nacita textovy subor zo zadaneho datumu do oFile
    procedure First;            // Nastavi ukazovatel textoveho suboru na prvy riadok
    function  Next:boolean;     // Nasledujuci riadok uctenky
    function  NextDoc: boolean; // Nastavy ukazovatel na nasledujucu hlavicku uctenky, ak existuje hodnota funkcie je TRUE
    // Property
    property Eof:boolean read oEof;  // TRUE k kurzoj je nakoci textoveho suboru
    property CasNum:word read oCasNum;   // Cislo pokladne
    property BlkNum:longint read oHead.BlkNum;     // Interne cislo uctenky
    property BlkDate:TDateTime read oHead.BlkDate; // Datum vyhotovenia uctenky
    property BlkTime:TDateTime read oHead.BlkTime; // Cas vyhotovenia uctenky
    property RegIno:Str10 read oHead.RegIno;       // ICO zakaznickej firmy
    property CrdNum:Str15 read oHead.CrdNum;       // Kod zakzanickej karty
    property StuName:Str8 read oHead.StuName;      // Prihlasovacie meno skladnika
    property LgnName:Str8 read oHead.LgnName;      // Prihlasovacie meno pokladnika
    property UsrName:Str30 read oHead.UsrName;     // Meno a priazvisko pokladnika
    property ItmNum:double read oItem.ItmNum;      // Cislo riadku uctenky
    property MgCode:longint read oItem.MgCode;     // Cislo tovarovej skupiny
    property GsCode:longint read oItem.GsCode;     // Tovrove cislo - PLU
    property GsName:Str30 read oItem.GsName;       // Nazov predaneho tovaru
    property BarCode:Str15 read oItem.BarCode;      // Identifikacny kod tovaru
    property ProdNum:Str30 read oItem.ProdNum;      // Vyrobne cislo tovaru
    property Action:Str1 read oItem.Action;        // Akciove oznacenie tovaru
    property VatPrc:byte read oItem.VatPrc;        // Percentualna sadzba DPH
    property StkNum:word read oItem.StkNum;        // Sklad z ktoreho sa odpocita polozka
    property GsQnt:double read oItem.GsQnt;       // Predane mnozstvo tovaru
    property DscPrc:double read oItem.DscPrc;      // Percentualna zlavana polozku
    property DscVal:double read oItem.DscVal;      // Hodnota zlavy polozky
    property PrfPrc:double read oItem.PrfPrc;      // Percentualna obchodna marza
    property BPrice:double read oItem.BPrice;      // Predajna cena s DPH za MJ
    property BValue:double read oItem.BValue;      // Predajna cena s DPH za polozku
    property AValue:double read GetAValue;        // Predajna cena bez DPH za polozku
  end;

implementation

{$R *.dfm}

procedure TCaiHand.FormCreate(Sender: TObject);
begin
  oCut := TTxtCut.Create;
  oFile := TStringList.Create;
end;

procedure TCaiHand.FormDestroy(Sender: TObject);
begin
  FreeAndNil (oFile);
  FreeAndNil (oCut);
end;

// ************************ PRIVATE *************************
function TCaiHand.LoadFrTxt (pCasNum:word; pDate:TDateTime):boolean; // Nacita textovy subor zo zadaneho datumu do oFile
begin
  oFile.Clear;
  oItmCnt := -1;
  oCasNum := pCasNum;
  Result := FileExists (gPath.CasPath(oCasNum)+FileName(pDate));;
  If Result then oFile.LoadFromFile(gPath.CasPath(oCasNum)+FileName(pDate));
end;

// ********************************* PUBLIC ***********************************
function TCaiHand.FileName(pDate:TDateTime):Str12; // Nazov kontrolnej pasky na zadany datum
begin
  Result := 'T'+DateToFileName(pDate)+'.'+StrIntZero(oCasNum,3);
end;

procedure TCaiHand.LoadHead;
begin
  oItem.ItmNum := 0;
  With oHead do begin
    BlkNum := oCut.GetNum(4);
    BlkDate := oCut.GetDate(5);
    BlkTime := oCut.GetTime(6);
    RegIno := oCut.GetText(11);
    CrdNum := oCut.GetText(8);
    LgnName := oCut.GetText(9);
    UsrName := oCut.GetText(13);
    StuName := '';
  end;
end;

procedure TCaiHand.LoadItem;
begin
  With oItem do begin
    ItmNum := ItmNum+1;
    MgCode := oCut.GetNum(3);
    GsCode := oCut.GetNum(4);
    GsName := oCut.GetText(2);
    BarCode := oCut.GetText(12);
    ProdNum := oCut.GetText(19);
    Action := oCut.GetText(21);
    VatPrc := oCut.GetNum(6);
    StkNum := oCut.GetNum(16);
    GsQnt := oCut.GetReal(5);
    DscPrc := oCut.GetReal(7);
    DscVal := oCut.GetReal(18);
    PrfPrc := oCut.GetReal(8);
    BPrice := oCut.GetReal(9);
    BValue := oCut.GetReal(10);
  end;
end;

function TCaiHand.GetAValue:double; // Predajna cena bez DPH za polozku
begin
  Result := Rd2(oItem.BValue/(1+oItem.VatPrc/100));
end;

procedure TCaiHand.First;
var mFind: boolean;
begin
  oActItm := -1;
  oItmCnt := -1;
end;

function TCaiHand.Next:boolean;
var mFind:boolean;
begin
  Result := FALSE;
  If oFile.Count>0 then begin
    Repeat
      Inc (oActItm);
      Inc(oItmCnt);
      oCut.SetStr(oFile.Strings[oItmCnt]);
      If (oCut.GetText(1)='SB') then begin
        LoadHead; // Nacita hlavickove udaje uctenky
        Inc(oItmCnt);
        oCut.SetStr(oFile.Strings[oItmCnt]);
      end;
      mFind := oCut.GetText(1)='SI';
      If mFind then LoadItem; // Nacita polozku uctenky
      oEof := (oItmCnt=oFile.Count-1);
    until mFind or oEof;
    Result := mFind;
  end;
end;

function TCaiHand.NextDoc;
var mFind: boolean;
begin
  mFind := False;
  Repeat
    Inc (oActItm);
    Inc (oItmCnt);
    oCut.SetStr (oFile.Strings[oActItm]);
    If (oCut.GetText(1)='SB') or (oCut.GetText(1)='CB') then begin
      mFind := TRUE;
      oItmCnt := 0;
      LoadHead; // Nacita hlavickove udaje uctenky
    end;
  until mFind or (oActItm=oFile.Count-1);
  oEof := not mFind;
  Result := mFind;
end;

end.
