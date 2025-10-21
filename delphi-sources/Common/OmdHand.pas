unit OmdHand;

interface

uses
  IcTypes, IcConv, IcValue, IcTools, IcVariab, DocHand, Bok, Key,
  NexSys, NexText, NexIni, NexGlob, StkGlob, StcHand, BtrHand, OmiHand,
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, DB, BtrTable, NexBtrTable, DBTables, NexPxTable;

type
  TOmdhand = class(TForm)
    btWSBLST: TNexBtrTable;
    btWSI: TNexBtrTable;
    btOCI: TNexBtrTable;
    btGSCAT: TNexBtrTable;
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
  private
    // Vypocitane udaje
    oDocCValue:double; // Hodnota dokladu bez DPH
    oDocEValue:double; // Hodnota dokladu s DPH
    // Hlacivkove udaje dokladu
    oYear:Str2;        // Rok skladovej prijemky
    oSerNum:longint;   // Poradove cislo skladovej prijemky
    oDocNum:Str12;     // Interne cislo skladovej prijemky
    oDocDate:TDateTime;// Datum vystavenia skladovej prijemky
    oStkNum:word;      // Cislo skladu vydaja
    oSmCode:word;      // Cislo skladoveho pohybu
    oDescribe:Str30;   // Textovy popis dokladu
    oOcdNum:Str12;     // Cislo priradenej zakazky
    oNoti:TStrings;  // Poznamky k danemu dokladu
    procedure OciClearOmd (pDocNum:Str12; pItmNum:longint); // Vymaze odkaz zo zakazky na danu polozku vudajky
    procedure WsiDelete (pDocNum:Str12; pItmNum:longint);
    function  GetYear: Str2; procedure SetYear(const Value: Str2); // Nastavi a vycita Rok
  public
    btOMH:TNexBtrTable;
    btOMN:TNexBtrTable;
    btOMP:TNexBtrTable;
    ptOMI:TNexPxTable;
    oItem:TOmi; // Udaje vybranej polozky dokladu
    // Metody na pracu s knihami
    function BookLocate (pBookNum:Str5):boolean; // TRUE ak Zafana kniha existuje
    procedure BookOpen (pBookNum:Str5); // Otvori vsetky databaze na zadanu knihu
    // Metody na pracu s dokladom
    function NewSerNum(pYear:Str2):longint; // Hodnota funkcie je nasledujece volne poradove cislo dokladu
    function DocLocate (pDocNum:Str12):boolean; // Nastavi kurzor na zadny doklad
    function DocDelVer (pDocNum:Str12):boolean; // TRUE ak doklad je mozne vymazat
    function DocIsAcc:boolean; // True ak aktualny doklad je zauctovany
    function DocIsStk:boolean; // True ak doklad naskladneny
    function DocIsLck:boolean; // True ak doklad ej uzmaknuty
    function DocIsRes:boolean; // True ak doklad rezervaovany
    procedure NewDoc (pYear:Str2;pSernum:longint); // Zarezervuje novy doklad pod nasledujucim volnym poradovym cislom
    procedure Prior; // Predchadzajuci doklad
    procedure Next; // Nasledujuci doklad
    procedure Reserve; // Zarezervuje doklad pre daneho uzivatela
    procedure UnReserve; // Ak doklad je zarezervany pr prihlaseneho uzivatela zrusi rezervaciu
    procedure Save; // Ulozi doklad a vsetky suvstazne udaje
    procedure Recalc (pDocNum:Str12); // Prepocita hlavicku na zaklade poloziek dokladu
    procedure Stock (pDocNum:Str12); // Zrusi vyskadnenie celeho dokladu
    procedure Finish; // Vykona vsetky predpisane ukoncovacie operacie daneho dokladu
    procedure Delete (pDocNum:Str12); // Vymaze zadany doklad spolu so suvstaznymi udajmi
    procedure Lock (pDocNum:Str12); // Uzamknutie dokladu
    procedure Unlock (pDocNum:Str12); // Odomknutie dokladu
    procedure Print; // Odomknutie dokladu
    procedure Archive (pDocNum:Str12); // Ulozi doklad do archivu
    // Metody na pracu s poznamkovymi riadkami dokladu
    procedure LoadNoti; // Nacita poznamkove riadky aktualneho dokladu
    // Pristupove metody k poliam hlavicky dokladu
    function GetSerNum:longint; // Poradove cislo skladovej prijemky
    function GetDocNum:Str12; // Interne cislo skladovej prijemky
    function GetDocDate:TDateTime; // Datum vystavenia skladovej prijemky
    function GetStkNum:word; // Cislo skladu vydaja
    function GetSmCode:word; // Cislo skladoveho pohybu
    function GetVatPrc(Index:byte):byte; // Sadzba DPH danovej skupiny c.1
    function GetAcCValue:double; // Hodnota dokladu v NC bez DPH - UM
    function GetAcEValue:double; // Hodnota dokladu v NC s DPH - IM
    function GetAcAValue:double; // Hodnota dokladu v PC bez DPH - UM
    function GetAcBValue:double; // Hodnota dokladu v PC s DPH - UM
    function GetDescribe:Str30; // Textovy popis dokladu
    function GetImdSnd:Str1; // Medziprevádzkové odoslanie dokladu (O-odoslane)
    function GetDstAcc:Str1; // Priznak zauctovania (A-zauctovany doklad)
    function GetDstStk:Str1; // Priznak vyskladnenia polozeik (S-vyskladneny)
    function GetDstLck:byte; // Priznak uzatvorenia (1- doklad je uzatvoreny)
    function GetConStk:word; // Cislo protiskladu prijmu alebo vydaja tovaru
    function GetTrgStk:word; // Cielovy sklad kam sa posiela tovar (0-definitývny vydaj)
    function GetOcdNum:Str12; // Interne cislo zakazky
    function GetImdNum:Str12; // Cislo automaticky vystavenej prijemky
    function GetCAccSnt:Str3; // Synteticka cast uctu rozuctovania dokladu - MD
    function GetCAccAnl:Str6; // Analyticka cast uctu rozuctovania dokladu - MD
    function GetDAccSnt:Str3; // Synteticka cast uctu rozuctovania dokladu - DAL
    function GetDAccAnl:Str6; // Analyticka cast uctu rozuctovania dokladu - DAL
    function GetCrtUser:Str8; // Prihlasovacie meno uzivatela, ktory vytvoril dokladu
    function GetItmQnt:word; // Pocet poloziek dokladu
    function GetPrnCnt:word; // Pocet vytlacenych kopii dokladu
    procedure SetSerNum (pValue:longint);
    // Pristupove metody k poznamkovym riadkom
    procedure AddNoti (pValue:ShortString); // Prida poznamkovy diadok
    // Pristupove medoty k poliam polozky dokladu
//    function ItmFrGsc (pGsCode:longint):boolean; // Nacita udaje zzadanej polozky z BE
    procedure SetSrcItmTable (pTable:TNexPxTable); // PX databáza ako zdroj pre vytvorenie poloziek dokladu
    // Vypocitane udaje
    property DocCValue:double read oDocCValue; // Hodnota dokladu bez DPH
    property DocEValue:double read oDocEValue; // Hodnota dokladu s DPH
    // Hlavickove udaje dokladu
    property Year:Str2 read GetYear write SetYear; // Rok vytvoreneho dokladu
    property SerNum:longint read GetSerNum write SetSerNum; // Poradove cislo skladovej prijemky
    property DocNum:Str12 read GetDocNum; // Interne cislo skladovej prijemky
    property DocDate:TDateTime read GetDocDate write oDocDate; // Datum vystavenia skladovej prijemky
    property StkNum:word read GetStkNum write oStkNum; // Cislo skladu vydaja
    property SmCode:word read GetSmCode write oSmCode; // Cislo skladoveho pohybu
    property VatPrc[Index:byte]:byte read GetVatPrc; // Sadzba DPH danovej skupiny c.1
    property AcCValue:double read GetAcCValue; // Hodnota dokladu v NC bez DPH - UM
    property AcEValue:double read GetAcEValue; // Hodnota dokladu v NC s DPH - IM
    property AcAValue:double read GetAcAValue; // Hodnota dokladu v PC bez DPH - UM
    property AcBValue:double read GetAcBValue; // Hodnota dokladu v PC s DPH - UM
    property Describe:Str30 read GetDescribe write oDescribe; // Textovy popis dokladu
    property ImdSnd:Str1 read GetImdSnd; // Medziprevádzkové odoslanie dokladu (O-odoslane)
    property DstAcc:Str1 read GetDstAcc; // Priznak zauctovania (A-zauctovany doklad)
    property DstStk:Str1 read GetDstStk; // Priznak vyskladnenia polozeik (S-vyskladneny)
    property DstLck:byte read GetDstLck; // Priznak uzatvorenia (1- doklad je uzatvoreny)
    property ConStk:word read GetConStk; // Cislo protiskladu prijmu alebo vydaja tovaru
    property TrgStk:word read GetTrgStk; // Cielovy sklad kam sa posiela tovar (0-definitývny vydaj)
    property OcdNum:Str12 read GetOcdNum write oOcdNum; // Interne cislo zakazky
    property ImdNum:Str12 read GetImdNum; // Cislo automaticky vystavenej prijemky
    property CAccSnt:Str3 read GetCAccSnt; // Synteticka cast uctu rozuctovania dokladu - MD
    property CAccAnl:Str6 read GetCAccAnl; // Analyticka cast uctu rozuctovania dokladu - MD
    property DAccSnt:Str3 read GetDAccSnt; // Synteticka cast uctu rozuctovania dokladu - DAL
    property DAccAnl:Str6 read GetDAccAnl; // Analyticka cast uctu rozuctovania dokladu - DAL
    property CrtUser:Str8 read GetCrtUser; // Prihlasovacie meno uzivatela, ktory vytvoril dokladu
    property ItmQnt:word read GetItmQnt; // Pocet poloziek dokladu
    property PrnCnt:word read GetPrnCnt; // Pocet vytlacenych kopii dokladu
    property Notice:TStrings read oNoti write oNoti; // Poznamkove riadky k zadanemu dokladu
    property Item:TOmi read oItem write oItem; // Udaje polozky dokladu
  end;

var  gOmd:TOmdhand;

implementation

{$R *.dfm}

procedure TOmdhand.FormCreate(Sender: TObject);
begin
  oItem := TOmi.Create(Self);
  oNoti := nil;
  btOMH := nil;
  btOMN := nil;
  btOMP := nil;
  ptOMI := nil;
  oYear := gvSys.ActYear2;
end;

procedure TOmdhand.FormDestroy(Sender: TObject);
begin
  FreeAndNil (oItem);
end;

// *************************** PRIVATE METHODS *******************************

procedure TOmdhand.OciClearOmd (pDocNum:Str12; pItmNum:longint); // Vymaze odkaz zo zakazky na danu polozku vudajky
var mBookNum:Str5;
begin
  mBookNum := BookNumFromDocNum (pDocNum);
  If gBok.BokExist('OCB',mBookNum,true) then begin
    btOCI.Open (mBookNum);
    btOCI.IndexName := 'DoIt';
    If btOCI.FindKey([pDocNum,pItmNum]) then begin
      btOCI.Edit;
      btOCI.FieldByName ('TcdNum').AsString := '';
      btOCI.FieldByName ('TcdItm').AsInteger := 0;
      btOCI.Post;
    end;
    btOCI.Close;
  end;
end;

procedure TOmdhand.WsiDelete (pDocNum:Str12; pItmNum:longint); // Vymzaepolozku z oparativnej evidencii vody
var mBookNum:Str5;
begin
  mBookNum := BookNumFromDocNum(pDocNum);
  If BookExist(btWSBLST,mBookNum) then begin
    btWSI.Open (mBookNum);
    btWSI.IndexName := 'DoIt';
    If btWSI.FindKey([pDocNum,pItmNum]) then begin
      btWSI.Edit;
      btWSI.FieldByName ('OmdNum').AsString := '';
      btWSI.FieldByName ('OmdItm').AsInteger := 0;
      btWSI.Post;
    end;
    btWSI.Close;
  end;
end;

// **************************** PUBLIC METHODS *******************************

function TOmdhand.BookLocate (pBookNum:Str5):boolean; // TRUE ak Zafana kniha existuje
begin
  Result := gBok.BokExist ('OMB',pBookNum,True);
end;

procedure TOmdhand.BookOpen (pBookNum:Str5); // Otvori vsetky databaze na zadanu knihu
begin
  If pBookNum='LAST' then pBookNum := GetLastBook('OMB',btOMH.BookNum);
  btOMH.Open (pBookNum);
  btOMN.Open (pBookNum);
  btOMP.Open (pBookNum);
  oItem.btOMI.Open (pBookNum);
  BookLocate (pBookNum);
end;

function TOmdhand.NewSerNum(pYear:Str2):longint; // Hodnota funkcie je nasledujece volne poradove cislo dokladu
begin
  Result := GetDocNextYearSerNum(btOMH,pYear);
end;

function TOmdhand.DocLocate (pDocNum:Str12):boolean; // Nastavi kurzor na zadny doklad
begin
  If btOMH.FieldByName('DocNum').AsString<>pDocNum then begin
    btOMH.SwapIndex;
    btOMH.IndexName := 'DocNum';
    Result := btOMH.FindKey([pDocNum]);
    btOMH.RestoreIndex;
  end
  else Result := TRUE; // Kurzor stoji na zadanom doklade
end;

function TOmdhand.DocDelVer (pDocNum:Str12):boolean; // TRUE ak doklad je mozne vymazat
begin
end;

function TOmdhand.DocIsAcc:boolean; // True ak aktualny doklad je zauctovany
begin
  Result := DstAcc='A';
end;

function TOmdhand.DocIsStk:boolean; // True ak doklad naskladneny
begin
  Result := DstStk='S';
end;

function TOmdhand.DocIsLck:boolean; // True ak doklad ej uzmaknuty
begin
  Result := DstLck=1;
end;

function TOmdhand.DocIsRes:boolean; // True ak doklad rezervaovany
begin
  Result := DstLck=9;
end;

procedure TOmdhand.NewDoc (pYear:Str2;pSernum:longint); // Zarezervuje novy doklad pod nasledujucim volnym poradovym cislom
begin
  oYear:=pYear;
  oDocDate := Date;
  oStkNum := gKey.OmbStkNum[btOMH.BookNum];
  oSmCode := gKey.OmbSmCode[btOMH.BookNum];
  oDescribe := '';  oOcdNum := '';
  If oNoti<>nil then oNoti.Clear;
  If pSerNum=0
    then SetSerNum (NewSerNum(oYear))
    else SetSerNum (pSerNum);
  Reserve;
end;

procedure TOmdhand.Prior; // Predchadzajuci doklad
begin
end;

procedure TOmdhand.Next; // Nasledujuci doklad
begin
end;

procedure TOmdhand.Reserve; // Zarezervuje doklad pre daneho uzivatela
begin
  btOMH.Insert;
  btOMH.FieldByName ('SerNum').AsInteger := oSerNum;
  btOMH.FieldByName ('Year').AsString := oYear;
  btOMH.FieldByName ('DocNum').AsString := oDocNum;
  btOMH.FieldByName ('DocDate').AsDateTime := Date;
  btOMH.FieldByName ('Describe').AsString := gNT.GetSecText('STATUS','Reserve','Rezervovane')+' - '+gvSys.LoginName;
  btOMH.FieldByName ('DstLck').AsInteger := 9;
  btOMH.FieldByName ('CrtUser').AsString := gvSys.LoginName;
  btOMH.Post;
end;

procedure TOmdhand.UnReserve; // Ak doklad je zarezervany pr prihlaseneho uzivatela zrusi rezervaciu
begin
  If (DstLck=9) and (CrtUser=gvSys.LoginName) then btOMH.Delete;
end;

procedure TOmdhand.Recalc (pDocNum:Str12); // Prepocita hlavicku na zaklade poloziek dokladu
var mItmQnt:longint;   mAcAValue,mAcBValue:double;  I:byte;
    mAcCValue,mAcEValue:TValue8;  mDstStk:Str1;
begin
  mItmQnt := 0;  mAcAValue := 0;  mAcBValue := 0;
  mAcCValue := TValue8.Create;  mAcCValue.Clear;
  mAcEValue := TValue8.Create;  mAcEValue.Clear;
  For I:=1 to 3 do begin
    mAcCValue.VatPrc[I] := VatPrc[I];
    mAcEValue.VatPrc[I] := VatPrc[I];
  end;
  oItem.btOMI.SwapIndex;
  oItem.btOMI.IndexName := 'DocNum';
  mDstStk := 'N';
  If oItem.btOMI.FindKey ([DocNum]) then begin
    mDstStk := 'S';
    Repeat
      Inc (mItmQnt);
      mAcCValue.Add (oItem.VatPrc,oItem.AcCValue);
      mAcEValue.Add (oItem.VatPrc,oItem.AcEValue);
      mAcBValue := mAcBValue+oItem.AcBValue;
      mAcAValue := mAcAValue+(oItem.AcBValue)/(1+oItem.VatPrc/100);
      If (oItem.StkStat='N') then mDstStk := 'N';
      Next;
    until Eof or (DocNum<>oItem.DocNum);
  end;
  oItem.btOMI.RestoreIndex;
  // Ulozime vypocitane hodnoty do hlavicky dokladu
  btOMH.Edit;
  btOMH.FieldByName ('CValue').AsFloat := mAcCValue[0];
  btOMH.FieldByName ('CValue1').AsFloat := mAcCValue[1];
  btOMH.FieldByName ('CValue2').AsFloat := mAcCValue[2];
  btOMH.FieldByName ('CValue3').AsFloat := mAcCValue[3];
  btOMH.FieldByName ('CValue4').AsFloat := mAcCValue[4];
  btOMH.FieldByName ('CValue5').AsFloat := mAcCValue[5];

  btOMH.FieldByName ('VatVal').AsFloat := mAcEValue[0]-mAcCValue[0];
  btOMH.FieldByName ('VatVal1').AsFloat := mAcEValue[1]-mAcCValue[1];
  btOMH.FieldByName ('VatVal2').AsFloat := mAcEValue[2]-mAcCValue[2];
  btOMH.FieldByName ('VatVal3').AsFloat := mAcEValue[3]-mAcCValue[3];
  btOMH.FieldByName ('VatVal4').AsFloat := mAcEValue[4]-mAcCValue[4];
  btOMH.FieldByName ('VatVal5').AsFloat := mAcEValue[5]-mAcCValue[5];

  btOMH.FieldByName ('EValue').AsFloat := mAcEValue[0];
  btOMH.FieldByName ('EValue1').AsFloat := mAcEValue[1];
  btOMH.FieldByName ('EValue2').AsFloat := mAcEValue[2];
  btOMH.FieldByName ('EValue3').AsFloat := mAcEValue[3];
  btOMH.FieldByName ('EValue4').AsFloat := mAcEValue[4];
  btOMH.FieldByName ('EValue5').AsFloat := mAcEValue[5];

  btOMH.FieldByName ('AValue').AsFloat := Rd2(mAcAValue);
  btOMH.FieldByName ('BValue').AsFloat := Rd2(mAcBValue);
  btOMH.FieldByName ('DstStk').AsString := mDstStk;
  btOMH.FieldByName ('ItmQnt').AsInteger := mItmQnt;
  btOMH.Post;
  FreeAndNil (mAcCValue);
  FreeAndNil (mAcEValue);
end;

procedure TOmdhand.Stock (pDocNum:Str12); // Zrusi vyskadnenie celeho dokladu
begin
end;

procedure TOmdhand.Finish; // Vykona vsetky predpisane ukoncovacie operacie daneho dokladu
begin
//  SndDocToFile (1,btOMH,oItem.btOMI,btOMP,btOMN);
end;

procedure TOmdhand.Save; // Ulozi doklad a vsetky suvstazne udaje
begin
  // Ulozime hlavickove udaje dokladu
  btOMH.Edit;
  btOMH.FieldByName ('DocDate').AsDateTime := oDocDate;
  btOMH.FieldByName ('StkNum').AsInteger := oStkNum;
  btOMH.FieldByName ('SmCode').AsInteger := oSmCode;
  btOMH.FieldByName ('Describe').AsString := oDescribe;
  If DocIsRes then begin
    btOMH.FieldByName ('VatPrc1').AsInteger := gIni.GetVatPrc(1);
    btOMH.FieldByName ('VatPrc2').AsInteger := gIni.GetVatPrc(2);
    btOMH.FieldByName ('VatPrc3').AsInteger := gIni.GetVatPrc(3);
    btOMH.FieldByName ('VatPrc4').AsInteger := gIni.GetVatPrc(4);
    btOMH.FieldByName ('VatPrc5').AsInteger := gIni.GetVatPrc(5);
    btOMH.FieldByName ('DstStk').AsString := 'N';
    btOMH.FieldByName ('DstLck').Asinteger := 0;
  end;
  btOMH.Post;
  // Ulozime poznamkove riadky
  If oNoti<>nil then SaveNotice (btOMN,DocNum,'',oNoti);
end;

procedure TOmdhand.Delete (pDocNum:Str12); // Vymaze zadany doklad spolu so suvstaznymi udajmi
begin
end;

procedure TOmdhand.Lock (pDocNum:Str12); // Uzamknutie dokladu
begin
end;

procedure TOmdhand.Unlock (pDocNum:Str12); // Odomknutie dokladu
begin
end;

procedure TOmdhand.Print; // Odomknutie dokladu
begin
end;

procedure TOmdhand.Archive (pDocNum:Str12); // Ulozi doklad do archivu
begin
end;

function TOmdhand.GetSerNum:longint; // Poradove cislo skladovej prijemky
begin
  Result := btOMH.FieldByName ('SerNum').AsInteger;
end;

function TOmdhand.GetDocNum:Str12; // Interne cislo skladovej prijemky
begin
  Result := btOMH.FieldByName ('DocNum').AsString;
end;

function TOmdhand.GetDocDate:TDateTime; // Datum vystavenia skladovej prijemky
begin
  Result := btOMH.FieldByName ('DocDate').AsDateTime;
end;

function TOmdhand.GetStkNum:word; // Cislo skladu vydaja
begin
  Result := btOMH.FieldByName ('StkNum').AsInteger;
end;

function TOmdhand.GetSmCode:word; // Cislo skladoveho pohybu
begin
  Result := btOMH.FieldByName ('SmCode').AsInteger;
end;

function TOmdhand.GetVatPrc(Index:byte):byte; // Sadzba DPH danovej skupiny c.1
begin
  Result := btOMH.FieldByName ('VatPrc'+StrInt(Index,1)).AsInteger;
end;

function TOmdhand.GetAcCValue:double; // Hodnota dokladu v NC bez DPH - UM
begin
  Result := btOMH.FieldByName ('CValue').AsFloat;
end;

function TOmdhand.GetAcEValue:double; // Hodnota dokladu v NC s DPH - IM
begin
  Result := btOMH.FieldByName ('EValue').AsFloat;
end;

function TOmdhand.GetAcAValue:double; // Hodnota dokladu v PC bez DPH - UM
begin
  Result := btOMH.FieldByName ('AValue').AsFloat;
end;

function TOmdhand.GetAcBValue:double; // Hodnota dokladu v PC s DPH - UM
begin
  Result := btOMH.FieldByName ('BValue').AsFloat;
end;

function TOmdhand.GetDescribe:Str30; // Textovy popis dokladu
begin
  Result := btOMH.FieldByName ('Describe').AsString;
end;

function TOmdhand.GetImdSnd:Str1; // Medziprevádzkové odoslanie dokladu (O-odoslane)
begin
  Result := btOMH.FieldByName ('ImdSnd').AsString;
end;

function TOmdhand.GetDstAcc:Str1; // Priznak zauctovania (A-zauctovany doklad)
begin
  Result := btOMH.FieldByName ('DstAcc').AsString;
end;

function TOmdhand.GetDstStk:Str1; // Priznak vyskladnenia polozeik (S-vyskladneny)
begin
  Result := btOMH.FieldByName ('DstStk').AsString;
end;

function TOmdhand.GetDstLck:byte; // Priznak uzatvorenia (1- doklad je uzatvoreny)
begin
  Result := btOMH.FieldByName ('DstLck').AsInteger;
end;

function TOmdhand.GetConStk:word; // Cislo protiskladu prijmu alebo vydaja tovaru
begin
  Result := btOMH.FieldByName ('ConStk').AsInteger;
end;

function TOmdhand.GetTrgStk:word; // Cielovy sklad kam sa posiela tovar (0-definitývny vydaj)
begin
  Result := btOMH.FieldByName ('TrgStk').AsInteger;
end;

function TOmdhand.GetOcdNum:Str12; // Interne cislo zakazky
begin
  Result := btOMH.FieldByName ('OcdNum').AsString;
end;

function TOmdhand.GetImdNum:Str12; // Cislo automaticky vystavenej prijemky
begin
  Result := btOMH.FieldByName ('ImdNum').AsString;
end;

function TOmdhand.GetCAccSnt:Str3; // Synteticka cast uctu rozuctovania dokladu - MD
begin
  Result := btOMH.FieldByName ('CAccSnt').AsString;
end;

function TOmdhand.GetCAccAnl:Str6; // Analyticka cast uctu rozuctovania dokladu - MD
begin
  Result := btOMH.FieldByName ('CAccAnl').AsString;
end;

function TOmdhand.GetDAccSnt:Str3; // Synteticka cast uctu rozuctovania dokladu - DAL
begin
  Result := btOMH.FieldByName ('DAccSnt').AsString;
end;

function TOmdhand.GetDAccAnl:Str6; // Analyticka cast uctu rozuctovania dokladu - DAL
begin
  Result := btOMH.FieldByName ('DAccAnl').AsString;
end;

function TOmdhand.GetCrtUser:Str8; // Prihlasovacie meno uzivatela, ktory vytvoril dokladu
begin
  Result := btOMH.FieldByName ('CrtUser').AsString;
end;

function TOmdhand.GetItmQnt:word; // Pocet poloziek dokladu
begin
  Result := btOMH.FieldByName ('ItmQnt').AsInteger;
end;

function TOmdhand.GetPrnCnt:word; // Pocet vytlacenych kopii dokladu
begin
  Result := btOMH.FieldByName ('PrnCnt').AsInteger;
end;

procedure TOmdhand.LoadNoti; // Poznamkove rirakdy k dokladu
begin
  If oNoti<>nil then LoadNotice (btOMN,DocNum,'',oNoti);
end;

procedure TOmdhand.SetSerNum (pValue:longint);
begin
  oSerNum := pValue;
  oDocNum := GenOmDocNum (oYear,btOMH.BookNum,oSerNum);
end;


procedure TOmdhand.AddNoti (pValue:ShortString); // Prida poznamkovy diadok
begin
end;

procedure TOmdhand.SetSrcItmTable (pTable:TNexPxTable); // PX databáza ako zdroj pre vytvorenie poloziek dokladu
var mGsCode:longint;
begin
  If pTable.RecordCount>0 then begin
    btGSCAT.IndexName := 'GsCode';
    Repeat
      mGsCode := pTable.fieldByName('GsCode').AsInteger;
//      If btGSCAT.FindKey([mGsCode]) then ReadItmFrGsc;  // Nacita zaznam do oItm z BE

//      WriteItmToOmi; // Zapise zaznam z oItm do prechodnej tabulky (PX) poloziek dokladu

      Application.ProcessMessages;
      pTable.Next;
    until pTable.Eof;
  end;
end;

function TOmdhand.GetYear: Str2;
begin
  Result := btOMH.FieldByName ('Year').AsString;
  If Result='' then Result:=YearFromDocNum(GetDocNum)
end;

procedure TOmdhand.SetYear(const Value: Str2);
begin
  oYear := Value;
  If oSerNum >0 then oDocNum := GenOmDocNum (oYear,btOMH.BookNum,oSerNum);
end;

end.
