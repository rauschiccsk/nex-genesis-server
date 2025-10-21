unit OmiHand;
// ***************************************************************************
//           Ovladac na pracu s polozkamy internej skladovej vydajky
// ***************************************************************************
//                               Priklady na pouziti
//
// Nacitanie poloziek zadaneho dokladu do TMP suboru>
// var mOmi:TOmi;
// begin
//   mOmi := TOmi.Create(Self);
//   mOmi.DocNum := cislo dokladu
//   mOmi.LoadFrBtr; // Nacita polozky z BTR do docasneho suboru
//   ...
//   pristup k udajom dokladu bude cez interne metody, alebo:
//   mOmi.ptOMI
//   ...
//   FreeAndNil
// end;
//
// Ulozit polozky dokladu
// var mOmi:TOmi;
// begin
//   mOmi := TOmi.Create(Self);
//   mOmi.DocNum := cislo dokladu
//   Repeat
//     mOmi.Insert;
//     mOmi.ItmNum := mCnt; // Poradove cislo polozky
//     mOmi.GsCode := ; // Tovarove cislo
//     mOmi.MgCode := ; // Tovarova skupina
//     mOmi.GsName := ; // Nazov tovaru
//     mOmi.BarCode := ;// Identifikacny kod
//     mOmi.GsQnt := ;  // Mnozstvo
//     mOmi.CPrice := ; // NC/MJ bez DPH
//     mOmi.BPrice := ; // PC/MJ s DPH
//     mOmi.Post;
//     mOmi.AddToBtr;
//     mOmi.AddStock;
//   until ...
//   ...
//   FreeAndNil
// end;
// ***************************************************************************

interface

uses
  IcTypes, IcConv, IcValue, IcTools, IcVariab, DocHand, StkHand,
  NexSys, NexText, NexIni, NexGlob, StkGlob, StcHand, BtrHand, Bok,
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, DB, BtrTable, NexBtrTable, DBTables, NexPxTable;

type
  TOmiRec = record
    // Bazove udaje
    GsCode:longint; // Tovarove cislo - PLU
    MgCode:longint; // Cislo tovarovej skupiny
    GsName:Str30;   // Nazov tovru
    BarCode:Str15;  // Identifikacny kod tovaru
    RbaCode:Str15;  // Vyrobna sarza
    RbaDate:TDate;  // Datum vyrobnej sarze
    RbaTrc:boolean;  // sledovanie vyrobnej sarze
    StkCode:Str15;  // Skladovy kod tovaru
    MsName:Str10;   // Merna jednotka tovaru
    VatPrc:byte;    // Sadzba DPH v %
    // Udaje z dokladu
    DocNum:Str12;      // Cislo dokladu
    ItmNum:longint;    // Poradove cislo polozky dokladu
    GsQnt:double;      // Prijate mnozstvo
    AcCPrice:double;   // Nakupna cena tovaru bez DPH
    AcEPrice:double;   // Nakupna cena tovaru s DPH
    AcCValue:double;   // Hodnota polozky v NC bez DPH
    AcEValue:double;   // Hodnota polozky v NC s DPH
    AcBPrice:double;   // PC/MJ s DPH
    AcAPrice:double;   // PC/MJ bez DPH
    AcAValue:double;   // Hodnota polozky v PC bez DPH
    AcBValue:double;   // Hodnota polozky v PC s DPH
    Notice:Str30;      // Poznamka k polozke dokladu
    StkStat:Str1;      // Stav polozky (N-zaevidovane,S-naskladnene)
    DocDate:TDateTime; // Datum vyhotovenia dokladu
    StkNum:word;       // Cislo skladu, odial sa vydava tovar
    ConStk:word;       // Cislo protiskladu prijmu alebo vydaja tovaru
    OcdNum:Str12;      // Cislo zakazkoveho dokladu
    OcdItm:longint;    // Cislo riadku zakazky
    SrcDoc:Str12;      // Cislo dokladu odkial pochadza dana polozka
    SrcItm:longint;    // Cislo riadku dokladu odkial pochadza dana polozka
  end;

  TOmi = class(TForm)
    btGSCAT: TNexBtrTable;
    ptOMI: TNexPxTable;
    btOMP: TNexBtrTable;
    btWSBLST: TNexBtrTable;
    btWSI: TNexBtrTable;
    btOCI: TNexBtrTable;
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
  private
    oItem:TOmiRec;
    oDocNum:Str12; // Cislo dokladu polozky ktoreho su nacitane
    oDocCVal:double; // Kumulativna hodnota dokladu bez DPH
    oDocEVal:double; // Kumulativna hodnota dokladu s DPH
    oStHand: TSubtract;
    function GetBookNum:Str5; // Cislo knihy na zaklade zadaneho cisladokladu
    procedure SetCPrice(pValue:double); // NC/MJ tovaru bez DPH
    procedure SetCValue(pValue:double); // NC tovaru bez DPH
    procedure SetBPrice(pValue:double); // PC/MJ tovaru bez DPH
    procedure ReadItem;  // Nacita zaznam do oItm udaje aktualnej polozky dokladu z prechodnej tabulky PX
    procedure WriteItem;  // Nacita zaznam do oItm udaje aktualnej polozky dokladu z prechodnej tabulky PX
  public
    btOMI:TNexBtrTable;
    function Bof:boolean; // Koniec poloziek dokladu
    function Eof:boolean; // Koniec poloziek dokladu
    function Locate (pItmNum:longint):boolean; // Nastavi kurzor na zadanu polozku a nacita udaje do bufferu
    function Count:longint; // Pocet poloziek dokladu
    function NewItm:longint; // Poradove cislo novej nasledujucej polozky
    procedure Clear; // Vymze buffer zaznamu polozky dokladu
    procedure Insert; // Prida novu polozku
    procedure Edit;   // Upravuje existujucu polozku
    procedure Post;   // Ulozi udaje polozky do docasneho suboru
    procedure Prior;  // Predchadzaj[ca polozka dokladu
    procedure Next;   // Nasledujuca polozka dokladu
    procedure Delete; // Vymaze zadany polozku spolu so suvstaznymi udajmi
    procedure DeleteTmp; // Vymaze zadany polozku 
    procedure SetDocVal(pCValue,pEValue:double); // nastavi hodnotu dokladu


    procedure ReadFrGsc(pGsCode:longint);  // Nacita zaznam do oItm z BE
    procedure LoadFrBtr(pDocNum:Str12); // Nacita polozku aktualneho dokladu do docasnej databaze
    procedure RecalcDocVal(pDocNum:Str12); // Nacita hodnoty dokladu z poloziek
    procedure AddToBtr; // Ulozi obsah docasneho suboru do BTR
    function AddStock:boolean; // Vykona skladovu opraciu
    procedure DelStock; // Zrusi skladovu opraciu
    procedure WsiDelete (pDocNum:Str12; pItmNum:longint); // Vymzaepolozku z oparativnej evidencii vody
    procedure OciUnMark (pDocNum:Str12; pItmNum:longint); // Vymaze odkaz zo zakazky na danu polozku vudajky
  published
    // Kumulativne udaje dokladu
    property DocCVal:double read oDocCVal;
    property DocEVal:double read oDocEVal;
    // Udaje polozky dokladu
    property GsCode:longint read oItem.GsCode write oItem.GsCode;
    property MgCode:longint read oItem.MgCode write oItem.MgCode;
    property GsName:Str30  read oItem.GsName  write oItem.GsName;
    property BarCode:Str15 read oItem.BarCode write oItem.BarCode;
    property RbaCode:Str15 read oItem.RbaCode write oItem.RbaCode;
    property RbaDate:TDate read oItem.RbaDate write oItem.RbaDate;
    property RbaTrc:boolean read oItem.RbaTrc write oItem.RbaTrc;
    property StkCode:Str15 read oItem.StkCode write oItem.StkCode;
    property MsName:Str10 read oItem.MsName write oItem.MsName;
    property VatPrc:byte read oItem.VatPrc write oItem.VatPrc;
    // Udaje z dokladu
    property DocNum:Str12 read oItem.DocNum write oItem.DocNum;
    property BookNum:Str5 read GetBookNum;
    property ItmNum:longint read oItem.ItmNum write oItem.ItmNum;
    property GsQnt:double read oItem.GsQnt write oItem.GsQnt;
    property CPrice:double write SetCPrice;
    property CValue:double write SetCValue;
    property BPrice:double write SetBPrice;
    property AcCPrice:double read oItem.AcCPrice write oItem.AcCPrice;
    property AcEPrice:double read oItem.AcEPrice write oItem.AcEPrice;
    property AcCValue:double read oItem.AcCValue write oItem.AcCValue;
    property AcEValue:double read oItem.AcEValue write oItem.AcEValue;
    property AcBPrice:double read oItem.AcBPrice write oItem.AcBPrice;
    property AcAPrice:double read oItem.AcAPrice write oItem.AcAPrice;
    property AcBValue:double read oItem.AcBValue write oItem.AcBValue;
    property AcAValue:double read oItem.AcAValue write oItem.AcAValue;
    property Notice:Str30 read oItem.Notice write oItem.Notice;
    property StkStat:Str1 read oItem.StkStat write oItem.StkStat;
    property DocDate:TDateTime read oItem.DocDate write oItem.DocDate;
    property StkNum:word read oItem.StkNum write oItem.StkNum;
    property ConStk:word read oItem.ConStk write oItem.ConStk;
    property OcdNum:Str12 read oItem.OcdNum write oItem.OcdNum;
    property OcdItm:longint read oItem.OcdItm write oItem.OcdItm;
    property SrcDoc:Str12 read oItem.SrcDoc write oItem.SrcDoc;
    property SrcItm:longint read oItem.SrcItm write oItem.SrcItm;
  end;

implementation

{$R *.dfm}

procedure TOmi.FormCreate(Sender: TObject);
begin
  btOMI := nil;
end;

procedure TOmi.FormDestroy(Sender: TObject);
begin
  If ptOMI.Active then ptOMI.Close;
  If btOMI.Active then btOMI.Close;
  If btOMP.Active then btOMP.Close;
  If btGSCAT.Active then btGSCAT.Close;
end;

// *************************** PRIVATE METHODS *******************************

procedure TOmi.SetCPrice(pValue:double); // Nakupna cena tovaru bez DPH
begin
  oItem.AcCPrice := pValue;
  oItem.AcCValue := Rd2(oItem.AcCPrice*oItem.GsQnt);
  oItem.AcEValue := Rd2(oItem.AcCValue*(1+oItem.VatPrc/100));
  If IsNotNul(oItem.GsQnt)
    then oItem.AcEPrice := RoundCPrice(oItem.AcCValue/oItem.GsQnt)
    else oItem.AcEPrice := 0;
end;

procedure TOmi.SetCValue(pValue:double); // NC tovaru bez DPH
begin
  oItem.AcCValue := pValue;
  oItem.AcCPrice := RoundCPrice(oItem.AcCPrice/oItem.GsQnt);
  oItem.AcEValue := Rd2(oItem.AcCValue*(1+oItem.VatPrc/100));
  If IsNotNul(oItem.GsQnt)
    then oItem.AcEPrice := RoundCPrice(oItem.AcCValue/oItem.GsQnt)
    else oItem.AcEPrice := 0;
end;

procedure TOmi.SetBPrice(pValue:double); // Nakupna cena tovaru bez DPH
begin
  oItem.AcBPrice := pValue;
  oItem.AcBValue := Rd2(oItem.AcBPrice*oItem.GsQnt);
  oItem.AcAValue := Rd2(oItem.AcBValue/(1+oItem.VatPrc/100));
  If IsNotNul(oItem.GsQnt)
    then oItem.AcAPrice := Rd2(oItem.AcBValue/oItem.GsQnt)
    else oItem.AcAPrice := 0;
end;

// *************************** PUBLIC METHODS *******************************

function TOmi.Bof:boolean; // Koniec poloziek dokladu
begin
  Result := ptOMI.Bof;
end;

function TOmi.Eof:boolean; // Koniec poloziek dokladu
begin
  Result := ptOMI.Eof;
end;

function TOmi.Locate (pItmNum:longint):boolean; // Nastavi kurzor na zadanu polozku a nacita udaje do bufferu
begin
  ptOMI.SwapIndex;
  ptOMI.IndexName := '';
  Result := ptOMI.FindKey([DocNum,pItmNum]);
  ReadItem;
  ptOMI.RestoreIndex;
end;

function TOmi.Count;
begin
  Result := ptOMI.RecordCount;
end;

function TOmi.NewItm:longint; // Poradove cislo novej nasledujucej polozky
begin
  Clear;
  ptOMI.SwapIndex;
  ptOMI.IndexName := '';
  ptOMI.Last;
  Result := ptOMI.FieldByName('ItmNum').AsInteger+1;
  ptOMI.RestoreIndex;
  oItem.ItmNum := Result;
end;

procedure TOmi.Clear;
begin
  FillChar (oItem,SizeOf(TOmiRec),#0);
end;

procedure TOmi.Insert; // Prida novu polozku
begin
  ptOMI.Insert;
end;

procedure TOmi.Edit;   // Upravuje existujucu polozku
begin
  ptOMI.Edit;
end;

procedure TOmi.Post;   // Ulozi udaje polozky do docasneho suboru
begin
  ptOMI.Post;
end;

procedure TOmi.Prior;  // Predchadzaj[ca polozka dokladu
begin
  ptOMI.Prior;
  ReadItem;
end;

procedure TOmi.Next;   // Nasledujuca polozka dokladu
begin
  ptOMI.Next;
  ReadItem;
end;

procedure TOmi.LoadFrBtr(pDocNum:Str12); // nacita polozku aktualneho dokladu do docasnej databaze
begin
  oDocNum := pDocNum;
  try
    If ptOMI.Active then ptOMI.Close;
    ptOMI.Open;
    If not btOMI.Active then btOMI.Open (BookNum);
    btOMI.SwapStatus;
    btOMI.IndexName := 'DocNum';
    oDocCVal := 0;   oDocEVal := 0;
    If btOMI.FindKey ([oDocNum]) then begin
      Repeat
        Insert;
        BTR_To_PX (btOMI,ptOMI);
        Post;
        ReadItem;  // Nacita zaznam do oItm udaje aktualnej polozky dokladu z prechodnej tabulky PX
        oDocCVal := oDocCVal+AcCValue;
        oDocEVal := oDocEVal+AcEValue;
        btOMI.Next;
      until (btOMI.Eof) or (btOMI.FieldByName('DocNum').AsString<>oDocNum);
    end;
  finally
    btOMI.RestoreStatus;
  end;
end;

procedure TOmi.RecalcDocVal(pDocNum:Str12); // nacita polozku aktualneho dokladu do docasnej databaze
begin
  oDocNum := pDocNum;
  try
    If not btOMI.Active then btOMI.Open (BookNum);
    btOMI.SwapStatus;
    btOMI.IndexName := 'DocNum';
    oDocCVal := 0;   oDocEVal := 0;
    If btOMI.FindKey ([oDocNum]) then begin
      Repeat
        ReadItem;  // Nacita zaznam do oItm udaje aktualnej polozky dokladu z prechodnej tabulky PX
        oDocCVal := oDocCVal+AcCValue;
        oDocEVal := oDocEVal+AcEValue;
        btOMI.Next;
      until (btOMI.Eof) or (btOMI.FieldByName('DocNum').AsString<>oDocNum);
    end;
  finally
    btOMI.RestoreStatus;
  end;
end;

procedure TOmi.SetDocVal(pCValue,pEValue:double); // nastavi hodnotu dokladu
begin
  oDocCVal:=pCValue;
  oDocEVal:=pEValue;
end;

procedure TOmi.AddToBtr; // Ulozi obsah docasneho suboru do BTR
begin
  If not btOMI.Active then btOMI.Open (BookNum);
  btOMI.Insert;
  PX_To_BTR (ptOMI,btOMI);
  btOMI.Post;
end;

function TOmi.AddStock:boolean; // Vykona skladovu opraciu
var mSign:Str1;  mCPrice:double;
begin
(*
  If btOMI.FieldByName('GsQnt').AsFloat>0
    then mSign := '-'  // Vydaj tovaru - riadny dodaci list
    else mSign := '+'; // Prijem tovaru - dobropis
  oStHand.OpenStkFiles (btOMI.FieldByName('StkNum').AsInteger);
  dmSTK.ClearOutFifos; // Vymažeme údaje FIFO z vyrovnávacej pamäte
  oStHand.ClearGsData;
  oStHand.PutDocNum (btOMI.FieldByName('DocNum').AsString);
  oStHand.PutItmNum (btOMI.FieldByName('ItmNum').AsInteger);
  oStHand.PutDocDate (dmSTK.btOMH.FieldByName('DocDate').AsDateTime);
  oStHand.PutSmSign (mSign);
  oStHand.PutGsCode (btOMI.FieldByName('GsCode').AsInteger);
  oStHand.PutMgCode (btOMI.FieldByName('MgCode').AsInteger);
  oStHand.PutBarCode (btOMI.FieldByName('BarCode').AsString);
  oStHand.PutSmCode (dmSTK.btOMH.FieldByName('SmCode').AsInteger);
  oStHand.PutGsName (btOMI.FieldByName('GsName').AsString);
  oStHand.PutVatPrc (btOMI.FieldByName('VatPrc').AsFloat);
  oStHand.PutGsQnt (Abs(btOMI.FieldByName('GsQnt').AsFloat));
  oStHand.PutCPrice (dmSTK.GetOutFifValue/btOMI.FieldByName('GsQnt').AsFloat);
  oStHand.PutBValue (btOMI.FieldByName('BValue').AsFloat);
  oStHand.PutConStk (btOMI.FieldByName('ConStk').AsInteger);
  If mSign='-' then begin // Vydaj tovaru
    BtrBegTrans;
      Result := oStHand.Output;
      If Result then begin
        oCValue := dmSTK.GetOutFifValue;
        btOMI.Edit;
        btOMI.FieldByName ('CValue').AsFloat := oCValue;
        btOMI.FieldByName ('CPrice').AsFloat := Rd2(oCValue/dmSTK.GetOutFifosQnt);
        btOMI.FieldByName ('EValue').AsFloat := Rd2(oCValue*(1+btOMI.FieldByName ('VatPrc').AsFloat/100));
        btOMI.FieldByName ('EPrice').AsFloat := Rd2(btOMI.FieldByName ('EValue').AsFloat/dmSTK.GetOutFifosQnt);
        If btOMI.FieldByName ('StkStat').AsString='N' then btOMI.FieldByName ('StkStat').AsString := 'S';
        btOMI.Post;
      end;
    BtrEndTrans;
  end
  else begin // Prijem na dobropisovaneho tvaru
    Result := TRUE; // Prijem vzdy mozeme urobit
    mCPrice := 0;
    If IsNotNul(btOMI.FieldByName('GsQnt').AsFloat) then mCPrice := Rd2(btOMI.FieldByName ('CValue').AsFloat/btOMI.FieldByName('GsQnt').AsFloat);
    If IsNul (mCPrice) then begin  // Ak cena prijmu je nulova vyhladame cenu zo skladovej karty
      dmSTK.btSTK.SwapStatus;
      If dmSTK.btSTK.IndexName<>'GsCode' then dmSTK.btSTK.IndexName := 'GsCode';
      If dmSTK.btSTK.FindKey([btOMI.FieldByName('GsCode').AsInteger]) then begin
        mCPrice := dmSTK.btSTK.FieldByName('LastPrice').AsFloat;
        // Ak aj posledna nakupna cena je nula potom skusime priemernu nakupnu cenu
        If IsNul (mCPrice) then mCPrice := dmSTK.btSTK.FieldByName('AvgPrice').AsFloat;
      end;
      dmSTK.btSTK.RestoreStatus;
    end;
    oStHand.PutCPrice (mCPrice);
    oStHand.Input;
    btOMI.Edit;
    btOMI.FieldByName ('CPrice').AsFloat := mCPrice;
    btOMI.FieldByName ('CValue').AsFloat := Rd2(mCPrice*btOMI.FieldByName('GsQnt').AsFloat);
    btOMI.FieldByName ('EValue').AsFloat := Rd2(btOMI.FieldByName ('CValue').AsFloat*(1+btOMI.FieldByName ('VatPrc').AsInteger/100));
    If IsNotNul (btOMI.FieldByName('GsQnt').AsFloat) then btOMI.FieldByName ('EPrice').AsFloat := Rd2(btOMI.FieldByName ('EValue').AsFloat/btOMI.FieldByName('GsQnt').AsFloat);
    If btOMI.FieldByName ('StkStat').AsString='N' then btOMI.FieldByName ('StkStat').AsString := 'S';
    btOMI.Post;
  end;
*)  
end;

procedure TOmi.DelStock; // Zrusi skladovu operaciu
var mStcHand:TStcHand;
begin

end;

procedure TOmi.Delete; // Vymaze zadany polozku spolu so suvstaznymi udajmi
var mStcHand:TStcHand; // mStkNum:word;
begin
  If not btOMP.Active then btOMP.Open(BookNum);
  btOMI.SwapIndex;
  btOMI.IndexName := 'DocNum';
  If btOMI.GotoPos(ptOMI.FieldByName('ActPos').AsInteger) then begin
    ReadItem;
    mStcHand := TStcHand.Create;
    mStcHand.OpenStkFiles(StkNum);
    mStcHand.OpenSTP (StkNum);
    try BtrBegTrans;
      If mStcHand.Cancel(DocNum,ItmNum) then begin
        oDocCVal := oDocCVal-AcCValue;
        oDocEVal := oDocEVal-AcEValue;
        // Zrusime vyrobne cisla z ODL
        btOMP.IndexName := 'DoIt';
        While btOMP.FindKey ([DocNum,ItmNum]) do btOMP.Delete;
        mStcHand.OutPdnClear (DocNum,ItmNum); // Zrusime vyrobne cisla zo skladu
        OciUnMark (OcdNum,OcdItm);
        // Len pre MOUNTFIELD - ak existuje zaznam v OE odstramime odkaz
        btOMI.IndexName := 'DoIt';
        If btOMI.FindKey ([DocNum,ItmNum]) then btOMI.Delete; // Zrusime polozku z BTR suboru
        ptOMI.Delete; // Zrusime polozku z docasneho suboru
        ReadItem;
      end;
    BtrEndTrans;
    except BtrAbortTrans; end;
    FreeAndNil (mStcHand);
  end;
  btOMI.RestoreIndex;
end;

procedure TOmi.DeleteTmp; // Vymaze zadany polozku
begin
  If not btOMP.Active then btOMP.Open(BookNum);
  oDocCVal := oDocCVal-AcCValue;
  oDocEVal := oDocEVal-AcEValue;
  btOMP.IndexName := 'DoIt';
  While btOMP.FindKey ([DocNum,ItmNum]) do btOMP.Delete;
//  mStcHand.OutPdnClear (DocNum,ItmNum); // Zrusime vyrobne cisla zo skladu
  OciUnMark (OcdNum,OcdItm);
  ptOMI.Delete; // Zrusime polozku z docasneho suboru
  ReadItem;
end;

function TOmi.GetBookNum:Str5; // Cislo knihy na zaklade zadaneho cisladokladu
begin
  Result := BookNumFromDocNum(oDocNum);
end;

procedure TOmi.WsiDelete (pDocNum:Str12; pItmNum:longint); // Vymzaepolozku z oparativnej evidencii vody
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

procedure TOmi.OciUnMark (pDocNum:Str12; pItmNum:longint); // Vymaze odkaz zo zakazky na danu polozku vudajky
var mBookNum:Str5;
begin
  mBookNum := BookNumFromDocNum (pDocNum);
  If gBok.BokExist('OCB',mBookNum,True) then begin
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

procedure TOmi.ReadFrGsc(pGsCode:longint);  // Nacita zaznam do oItm z BE
begin
  If not btGSCAT.Active then btGSCAT.Open;
  btGSCAT.IndexName := 'GsCode';
  If btGSCAT.FindKey([pGsCode]) then begin
    oItem.GsCode := btGSCAT.FieldByName ('GsCode').AsInteger;
    oItem.MgCode := btGSCAT.FieldByName ('MgCode').AsInteger;
    oItem.GsName := btGSCAT.FieldByName ('GsName').AsString;
    oItem.BarCode := btGSCAT.FieldByName ('BarCode').AsString;
    oItem.RbaTrc := btGSCAT.FieldByName ('RbaTrc').AsInteger=1;
    oItem.StkCode := btGSCAT.FieldByName ('StkCode').AsString;
    oItem.MsName := btGSCAT.FieldByName ('MsName').AsString;
    oItem.VatPrc := btGSCAT.FieldByName ('VatPrc').AsInteger;
  end
  else oItem.GsCode := pGsCode;
end;

procedure TOmi.ReadItem;  // Nacita zaznam do oItm udaje aktualnej polozky dokladu z prechodnej tabulky PX
begin
  oItem.GsCode := ptOMI.FieldByName ('GsCode').AsInteger;
  oItem.MgCode := ptOMI.FieldByName ('MgCode').AsInteger;
  oItem.GsName := ptOMI.FieldByName ('GsName').AsString;
  oItem.BarCode := ptOMI.FieldByName ('BarCode').AsString;
  oItem.RbaCode := ptOMI.FieldByName ('RbaCode').AsString;
  oItem.RbaDate := ptOMI.FieldByName ('RbaDate').AsDateTime;
  oItem.StkCode := ptOMI.FieldByName ('StkCode').AsString;
  oItem.MsName := ptOMI.FieldByName ('MsName').AsString;
  oItem.VatPrc := ptOMI.FieldByName ('VatPrc').AsInteger;
  oItem.DocNum := ptOMI.FieldByName ('DocNum').AsString;
  oItem.ItmNum := ptOMI.FieldByName ('ItmNum').AsInteger;
  oItem.GsQnt := ptOMI.FieldByName ('GsQnt').AsFloat;
  oItem.AcCPrice := ptOMI.FieldByName ('CPrice').AsFloat;
  oItem.AcEPrice := ptOMI.FieldByName ('EPrice').AsFloat;
  oItem.AcCValue := ptOMI.FieldByName ('CValue').AsFloat;
  oItem.AcEValue := ptOMI.FieldByName ('EValue').AsFloat;
  oItem.AcBPrice := ptOMI.FieldByName ('BPrice').AsFloat;
  oItem.AcAValue := ptOMI.FieldByName ('AValue').AsFloat;
  oItem.AcBValue := ptOMI.FieldByName ('BValue').AsFloat;
  oItem.Notice := ptOMI.FieldByName ('Notice').AsString;
  oItem.StkStat := ptOMI.FieldByName ('StkStat').AsString;
  oItem.DocDate := ptOMI.FieldByName ('DocDate').AsDateTime;
  oItem.StkNum := ptOMI.FieldByName ('StkNum').AsInteger;
  oItem.ConStk := ptOMI.FieldByName ('ConStk').AsInteger;
  oItem.OcdNum := ptOMI.FieldByName ('OcdNum').AsString;
  oItem.OcdItm := ptOMI.FieldByName ('OcdItm').AsInteger;
  oItem.SrcDoc := ptOMI.FieldByName ('SrcDoc').AsString;
  oItem.SrcItm := ptOMI.FieldByName ('SrcItm').AsInteger;
end;

procedure TOmi.WriteItem; // Zapise zaznam z oItm do prechodnej tabulky (PX) poloziek dokladu
begin
  ptOMI.FieldByName ('GsCode').AsInteger := oItem.GsCode;
  ptOMI.FieldByName ('MgCode').AsInteger := oItem.MgCode;
  ptOMI.FieldByName ('GsName').AsString := oItem.GsName;
  ptOMI.FieldByName ('BarCode').AsString := oItem.BarCode;
  ptOMI.FieldByName ('RbaCode').AsString := oItem.RbaCode;
  ptOMI.FieldByName ('RbaDate').AsDateTime := oItem.RbaDate;
  ptOMI.FieldByName ('StkCode').AsString := oItem.StkCode;
  ptOMI.FieldByName ('MsName').AsString := oItem.MsName;
  ptOMI.FieldByName ('VatPrc').AsInteger := oItem.VatPrc;
  ptOMI.FieldByName ('ItmNum').AsInteger := oItem.ItmNum;
  ptOMI.FieldByName ('GsQnt').AsFloat := oItem.GsQnt;
  ptOMI.FieldByName ('CPrice').AsFloat := oItem.AcCPrice;
  ptOMI.FieldByName ('EPrice').AsFloat := oItem.AcEPrice;
  ptOMI.FieldByName ('CValue').AsFloat := oItem.AcCValue;
  ptOMI.FieldByName ('EValue').AsFloat := oItem.AcEValue;
  ptOMI.FieldByName ('BPrice').AsFloat := oItem.AcBPrice;
  ptOMI.FieldByName ('AValue').AsFloat := oItem.AcAValue;
  ptOMI.FieldByName ('BValue').AsFloat := oItem.AcBValue;
  ptOMI.FieldByName ('Notice').AsString := oItem.Notice;
  ptOMI.FieldByName ('StkStat').AsString := oItem.StkStat;
  ptOMI.FieldByName ('StkNum').AsInteger := oItem.StkNum;
  ptOMI.FieldByName ('ConStk').AsInteger := oItem.ConStk;
  ptOMI.FieldByName ('OcdNum').AsString := oItem.OcdNum;
  ptOMI.FieldByName ('OcdItm').AsInteger := oItem.OcdItm;
  ptOMI.FieldByName ('SrcDoc').AsString := oItem.SrcDoc;
  ptOMI.FieldByName ('SrcItm').AsInteger := oItem.SrcItm;
end;

end.
{MOD 1809014}
