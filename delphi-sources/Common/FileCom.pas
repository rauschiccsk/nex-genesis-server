unit FileCom;

interface

uses
  IcTypes, IcConv, TxtWrap, TxtCut, NexGlob,
  Controls, Classes, SysUtils;

type
  THead = record
    DocNum: Str12;      // Úètovné èíslo dokladu
    ExtNum: Str12;      // Externé èíslo dokladu
    DocDate: TDate;     // Dátum dokladu
    SmCode: longint;    // Kód skladového pohybu
    SmName: Str30;      // Názov skladového pohybu
    WriNum1: longint;   // Prevádzková jednotka skladu (zdrojová v prípade medziskladového presunu)
    WriNum2: longint;   // Cie¾ová prevádzka v prípade medziskladovéo presunu
    Describe: Str30;    // Popis dokladu
    VatPrc1: double;    // Sadzba DPH skupiny è. 1
    VatPrc2: double;    // Sadzba DPH skupiny è. 2
    VatPrc3: double;    // Sadzba DPH skupiny è. 3
    AValue: double;     // Hodnota dokladu v NC bez DPH
    BValue: double;     // Hodnota dokladu v NC s DPH
    PAValue: double;    // Hodnota dokladu v PC bez DPH
    PBValue: double;    // Hodnota dokladu v PC s DPH 
    PaPCode: longint;   // Prvotný kód partnera
    PaSCode: word;      // Druhotný kód partnera
    PaName: Str30;      // Názov partnera
    PaIno: Str15;       // IÈO partnera
    PaTin: Str15;       // DIÈ partnera
    PaAddr: Str30;      // Adresa partnera
    PaConto: Str30;     // Bakový úèet partnera
    ItmQnt: word;       // Poèet položiek dokladu
  end;

  TItem = record
    ItmNum: word;       // Poradové èíslo položky dokladu
    GsCode: longint;    // Tovarové èíslo položky
    GsName: Str30;      // Názov tovaru
    BarCode: Str15;     // Èiarový kód tovaru
    StCode: Str15;      // Skladový kód tovaru
    MsName: Str10;      // Merná jednotka tovaru
    VatPrc: double;     // Sadzba DPH
    GsQnt: double;      // Množstvo tovaru
    GsAVal: double;     // Hodnota tovaru v NC bez DPH
    GsBVal: double;     // Hodnota tovaru v NC s DPH
    GsPAVal: double;    // Hodnota tovaru v PC bez DPH
    GsPBVal: double;    // Hodnota tovaru v PC s DPH
  end;

  TFileCom = class
    constructor Create;
    destructor Destroy; override;
  private
    oFileName: Str12;
    oHead: THead;
    oItems: TList;
    oItemData: ^TItem;

  public
    procedure SetHead (pDocNum: Str12;      // Úètovné èíslo dokladu
                       pExtNum: Str12;      // Externé èíslo dokladu
                       pDocDate: TDate;     // Dátum dokladu
                       pSmCode: longint;    // Kód skladového pohybu
                       pSmName: Str30;      // Názov skladového pohybu
                       pWriNum1: longint;   // Prevádzková jednotka skladu (zdrojová v prípade medziskladového presunu)
                       pWriNum2: longint;   // Cie¾ová prevádzka v prípade medziskladovéo presunu
                       pDescribe: Str30;    // Popis dokladu
                       pVatPrc1: double;    // Sadzba DPH skupiny è. 1
                       pVatPrc2: double;    // Sadzba DPH skupiny è. 2
                       pVatPrc3: double;    // Sadzba DPH skupiny è. 3
                       pAValue: double;     // Hodnota dokladu v NC bez DPH
                       pBValue: double;     // Hodnota dokladu v NC s DPH
                       pPAValue: double;    // Hodnota dokladu v PC bez DPH
                       pPBValue: double);   // Hodnota dokladu v PC  s DPH

    procedure SetPart (pPaPCode: longint;   // Prvotný kód partnera
                       pPaSCode: word;      // Druhotný kód partnera
                       pPaName: Str30;      // Názov partnera
                       pPaIno: Str15;       // IÈO partnera
                       pPaTin: Str15;       // DIÈ partnera
                       pPaAddr: Str30;      // Adresa partnera
                       pPaConto: Str30);    // Bakový úèet partnera

    procedure AddItem (pItmNum: word;       // Poradové èíslo položky dokladu
                       pGsCode: longint;    // Tovarové èíslo položky
                       pGsName: Str30;      // Názov tovaru
                       pBarCode: Str15;     // Èiarový kód tovaru
                       pStCode: Str15;      // Skladový kód tovaru
                       pMsName: Str10;      // Merná jednotka tovaru
                       pVatPrc: double;     // Sadzba DPH
                       pGsQnt: double;      // Množstvo tovaru
                       pGsAVal: double;     // Hodnota tovaru v NC bez DPH
                       pGsBVal: double;     // Hodnota tovaru v NC s DPH
                       pGsPAVal: double;    // Hodnota tovaru v PC bez DPH
                       pGsPBVal: double);   // Hodnota tovaru v PC s DPH

    procedure SaveToFile (pFile:string);    // Uloži údaje dokladu do súboru

    procedure LoadFromFile (pFile:string);  // Naèíta údaje dokladu zo súboru
    // Údaje hlavièky dokladu
    function GetDocNum: Str12;      // Úètovné èíslo dokladu
    function GetExtNum: Str12;      // Externé èíslo dokladu
    function GetDocDate: TDate;     // Dátum dokladu
    function GetSmCode: longint;    // Kód skladového pohybu
    function GetSmName: Str30;      // Názov skladového pohybu
    function GetWriNum1: longint;   // Prevádzková jednotka skladu (zdrojová v prípade medziskladového presunu)
    function GetWriNum2: longint;   // Cie¾ová prevádzka v prípade medziskladovéo presunu
    function GetDescribe: Str30;    // Popis dokladu
    function GetVatPrc1: double;    // Sadzba DPH skupiny è. 1
    function GetVatPrc2: double;    // Sadzba DPH skupiny è. 2
    function GetVatPrc3: double;    // Sadzba DPH skupiny è. 3
    function GetAValue(pVatGrp:byte): double;     // Hodnota dokladu v NC bez DPH
    function GetBValue(pVatGrp:byte): double;     // Hodnota dokladu v NC s DPH
    function GetPAValue(pVatGrp:byte): double;    // Hodnota dokladu v PC bez DPH
    function GetPBValue(pVatGrp:byte): double;    // Hodnota dokladu v PC s DPH
    function GetPaPCode: longint;   // Prvotný kód partnera
    function GetPaSCode: word;      // Druhotný kód partnera
    function GetPaName: Str30;      // Názov partnera
    function GetPaIno: Str15;       // IÈO partnera
    function GetPaTin: Str15;       // DIÈ partnera
    function GetPaAddr: Str30;      // Adresa partnera
    function GetPaConto: Str30;     // Bakový úèet partnera
    function GetItmQnt: word;       // Poèet položiek dokladu

    // Udaje položiek dokladu
    function GetItmNum (pItm:word): word;       // Poradové èíslo položky dokladu
    function GetGsCode (pItm:word): longint;    // Tovarové èíslo položky
    function GetGsName (pItm:word): Str30;      // Názov tovaru
    function GetBarCode (pItm:word): Str15;     // Èiarový kód tovaru
    function GetStCode (pItm:word): Str15;      // Skladový kód tovaru
    function GetMsName (pItm:word): Str10;      // Merná jednotka tovaru
    function GetVatPrc (pItm:word): double;     // Sadzba DPH
    function GetVatGrp (pItm:word): byte;       // Skupina DPH
    function GetGsQnt (pItm:word): double;      // Množstvo tovaru
    function GetGsAVal (pItm:word): double;     // Hodnota tovaru v NC bez DPH
    function GetGsBVal (pItm:word): double;     // Hodnota tovaru v NC s DPH
    function GetGsPAVal (pItm:word): double;    // Hodnota tovaru v PC bez DPH
    function GetGsPBVal (pItm:word): double;    // Hodnota tovaru v PC s DPH
  end;

implementation

uses IniHandle;

constructor TFileCom.Create;
begin
  oItems := TList.Create;
end;

destructor TFileCom.Destroy;
var I: word;
begin
  try
   For I:=0 to (oItems.Count-1) do begin
     oItemData := oItems.Items[I];
     Dispose(oItemData);
   end;
  finally
    oItems.Free;
  end;
end;

procedure TFileCom.SetHead;
begin
  oHead.DocNum := pDocNum;       // Úètovné èíslo dokladu
  oHead.ExtNum := pExtNum;       // Externé èíslo dokladu
  oHead.DocDate := pDocDate;     // Dátum dokladu
  oHead.SmCode := pSmCode;       // Kód skladového pohybu
  oHead.SmName := pSmName;       // Názov skladového pohybu
  oHead.WriNum1 := pWriNum1;     // Prevádzková jednotka skladu (zdrojová v prípade medziskladového presunu)
  oHead.WriNum2 := pWriNum2;     // Cie¾ová prevádzka v prípade medziskladovéo presunu
  oHead.Describe := pDescribe;   // Popis dokladu
  oHead.VatPrc1 := pVatPrc1;     // Sadzba DPH skupiny è. 1
  oHead.VatPrc2 := pVatPrc2;     // Sadzba DPH skupiny è. 2
  oHead.VatPrc3 := pVatPrc3;     // Sadzba DPH skupiny è. 3
  oHead.AValue := pAValue;       // Hodnota dokladu v NC bez DPH
  oHead.BValue := pBValue;       // Hodnota dokladu v NC s DPH
  oHead.PAValue := pPAValue;     // Hodnota dokladu v PC bez DPH
  oHead.PBValue := pPBValue;     // Hodnota dokladu v PC s DPH
end;

procedure TFileCom.SetPart;
begin
  oHead.PaPCode := pPaPCode;     // Prvotný kód partnera
  oHead.PaSCode := pPaSCode;     // Druhotný kód partnera
  oHead.PaName := pPaName;       // Názov partnera
  oHead.PaIno := pPaIno;         // IÈO partnera
  oHead.PaTin := pPaTin;         // DIÈ partnera
  oHead.PaAddr := pPaAddr;       // Adresa partnera
  oHead.PaConto := pPaConto;     // Bakový úèet partnera
end;

procedure TFileCom.AddItem;
begin
  New (oItemData);
  oItemData^.ItmNum := pItmNum;   // Poradové èíslo položky dokladu
  oItemData^.GsCode := pGsCode;   // Tovarové èíslo položky
  oItemData^.GsName := pGsName;   // Názov tovaru
  oItemData^.BarCode := pBarCode; // Èiarový kód tovaru
  oItemData^.StCode := pStCode;   // Skladový kód tovaru
  oItemData^.MsName := pMsName;   // Merná jednotka tovaru
  oItemData^.VatPrc := pVatPrc;   // Sadzba DPH
  oItemData^.GsQnt := pGsQnt;     // Množstvo tovaru
  oItemData^.GsAVal := pGsAVal;   // Hodnota tovaru v NC bez DPH
  oItemData^.GsBVal := pGsBVal;   // Hodnota tovaru v NC s DPH
  oItemData^.GsPAVal := pGsPAVal; // Hodnota tovaru v PC bez DPH
  oItemData^.GsPBVal := pGsPBVal; // Hodnota tovaru v PC s DPH
  oItems.Add (oItemData);
end;

procedure TFileCom.SaveToFile;
var mFile: TStrings;   I:word;   mWrap: TTxtWrap;
begin
  mWrap := TTxtWrap.Create;
  mWrap.SetDelimiter (#254);

  mFile := TStringList.Create;
  mWrap.ClearWrap;
  mWrap.SetText ('H',1);             // Oznaèenie že sa jedná o hlavièky dokladu
  mWrap.SetText (oHead.DocNum,0);    // Úètovné èíslo dokladu
  mWrap.SetText (oHead.ExtNum,0);    // Externé èíslo dokladu
  mWrap.SetText (DateToStr(oHead.DocDate),0);  // Dátum dokladu
  mWrap.SetNum  (oHead.SmCode,0);    // Kód skladového pohybu
  mWrap.SetText (oHead.SmName,0);    // Názov skladového pohybu
  mWrap.SetNum  (oHead.WriNum1,0);   // Prevádzková jednotka dokladu
  mWrap.SetNum  (oHead.WriNum2,0);   // Prevádzková jednotka dokladu - cie¾ová prevádzka pri MP
  mWrap.SetText (oHead.Describe,0);  // Popis dokladu
  mWrap.SetReal (oHead.VatPrc1,0,1); // Sadzba DPH 1
  mWrap.SetReal (oHead.VatPrc2,0,1); // Sadzba DPH 2
  mWrap.SetReal (oHead.VatPrc3,0,1); // Sadzba DPH 3
  mWrap.SetReal (oHead.AValue,0,2);  // Hodnota dokladu v NC bez DPH
  mWrap.SetReal (oHead.BValue,0,2);  // Hodnota dokladu v NC s DPH
  mWrap.SetReal (oHead.PAValue,0,2); // Hodnota dokladu v PC bez DPH
  mWrap.SetReal (oHead.PBValue,0,2); // Hodnota dokladu v PC s DPH
  mWrap.SetNum  (oHead.PaPCode,0);   // Prvotný kód partnera
  mWrap.SetNum  (oHead.PaSCode,0);   // Druhotný kód partnera
  mWrap.SetText (oHead.PaName,0);    // Názov partnera
  mWrap.SetText (oHead.PaIno,0);     // IÈO partnera
  mWrap.SetText (oHead.PaTin,0);     // DIÈ partnera
  mWrap.SetText (oHead.PaAddr,0);    // Adresa partnera
  mWrap.SetText (oHead.PaConto,0);   // Bankový úèet partnera
  mWrap.SetNum  (oItems.Count,0);    // Poèet položiek dokladu
  mFile.Add (mWrap.GetWrapText);

  For I:=0 to oItems.Count-1 do begin
    oItemData := oItems.Items[I];  // Naèítame premennu z pamäte
    mWrap.ClearWrap;
    mWrap.SetText ('I',1);  // Oznaèenie že sa jedná o položiek dokladu
    mWrap.SetNum (oItemData^.ItmNum,0);     // Poradové èíslo položky dokladu
    mWrap.SetNum (oItemData^.GsCode,0);     // Tovarové èíslo položky
    mWrap.SetText (oItemData^.GsName,0);    // Názov tovaru
    mWrap.SetText (oItemData^.BarCode,0);   // Èiarový kód tovaru
    mWrap.SetText (oItemData^.StCode,0);    // Skladový kód tovaru
    mWrap.SetText (oItemData^.MsName,0);    // Merná jednotka tovaru
    mWrap.SetReal (oItemData^.VatPrc,0,1);  // Sadzba DPH
    mWrap.SetReal (oItemData^.GsQnt,0,2);   // Množstvo tovaru
    mWrap.SetReal (oItemData^.GsAVal,0,2);  // Hodnota tovaru v NC bez DPH
    mWrap.SetReal (oItemData^.GsBVal,0,2);  // Hodnota tovaru v NC s DPH
    mWrap.SetReal (oItemData^.GsPAVal,0,2); // Hodnota tovaru v NC bez DPH
    mWrap.SetReal (oItemData^.GsPBVal,0,2); // Hodnota tovaru v NC s DPH
    mFile.Add (mWrap.GetWrapText);
    Dispose(oItemData);  // Zrušíme premennú a uvolníme miesto v pamäti
  end;
  oItems.Clear;
  mWrap.Free;

  mFile.SaveToFile (pFile);
  mFile.Free;
end;

procedure TFileCom.LoadFromFile;
var mFile: TStrings;   I:word;   mCut: TTxtCut;
begin
  mCut := TTxtCut.Create;
  mCut.SetDelimiter (#254);

  mFile := TStringList.Create;
  mFile.LoadFromFile (pFile);
  For I:=0 to mFile.Count-1 do begin
    mCut.SetStr (mFile.Strings[I]);
    If mCut.GetText(1)='H' then begin
      oHead.DocNum := mCut.GetText (2);   // Úètovné èíslo dokladu
      oHead.ExtNum := mCut.GetText (3);   // Externé èíslo dokladu
      oHead.DocDate := StrToDate(mCut.GetText(4));  // Dátum dokladu
      oHead.SmCode := mCut.GetNum (5);    // Kód skladového pohybu
      oHead.SmName := mCut.GetText (6);   // Názov skladového pohybu
      oHead.WriNum1 := mCut.GetNum (7);   // Prevádzková jednotka
      oHead.WriNum1 := mCut.GetNum (8);   // Prevádzková jednotka - cie¾ová prvádzka v prípade MP
      oHead.Describe := mCut.GetText (9); // Textový popis dokladu
      oHead.VatPrc1 := mCut.GetReal (10); // Sadzba DPH 1
      oHead.VatPrc2 := mCut.GetReal (11); // Sadzba DPH 2
      oHead.VatPrc3 := mCut.GetReal (12); // Sadzba DPH 3
      oHead.AValue := mCut.GetReal (13);  // Hodnota dokladu v NC bez FPH
      oHead.BValue := mCut.GetReal (14);  // Hodnota dokladu v NC s FPH
      oHead.PAValue := mCut.GetReal (15); // Hodnota dokladu v PC bez FPH
      oHead.PBValue := mCut.GetReal (16); // Hodnota dokladu v PC s FPH
      oHead.PaPCode := mCut.GetNum (17);  // Prvotný kód partnera
      oHead.PaSCode := mCut.GetNum (18);  // Druhotný kód partnera
      oHead.PaName := mCut.GetText (19);  // Názov partnera
      oHead.PaIno := mCut.GetText (20);   // IÈO partnera
      oHead.PaTin := mCut.GetText (21);   // DIÈ partnera
      oHead.PaAddr := mCut.GetText (22);  // Adresa partnera
      oHead.PaConto := mCut.GetText (23); // Bamkový úèet partnera
      oHead.ItmQnt := mCut.GetNum (24);   // Poèet položiek dokladu
    end;
    If mCut.GetText(1)='I' then begin
      New (oItemData);  // Vytvorime novu premennu na uložnie naèítaných údajov
      oItemData^.ItmNum := mCut.GetNum (2);    // Poradové èíslo položky dokladu
      oItemData^.GsCode := mCut.GetNum (3);    // Tovarové èíslo položky
      oItemData^.GsName := mCut.GetText (4);   // Názov tovaru
      oItemData^.BarCode := mCut.GetText (5);  // Èiarový kód tovaru
      oItemData^.StCode := mCut.GetText (6);   // Skladový kód tovaru
      oItemData^.MsName := mCut.GetText (7);   // Merná jednotka tovaru
      oItemData^.VatPrc := mCut.GetReal (8);   // Sadzba DPH
      oItemData^.GsQnt := mCut.GetReal (9);    // Množstvo tovaru
      oItemData^.GsAVal := mCut.GetReal (10);   // Hodnota tovaru v NC bez DPH
      oItemData^.GsBVal := mCut.GetReal (11);  // Hodnota tovaru v NC s DPH
      oItemData^.GsPAVal := mCut.GetReal (12); // Hodnota tovaru v PC bez DPH
      oItemData^.GsPBVal := mCut.GetReal (13); // Hodnota tovaru v PC s DPH
      oItems.Add (oItemData);
    end;
  end;
  mCut.Free;
  mFile.Free;
end;

function TFileCom.GetDocNum: Str12;      // Úètovné èíslo dokladu
begin
  Result := oHead.DocNum;
end;

function TFileCom.GetExtNum: Str12;      // Externé èíslo dokladu
begin
  Result := oHead.ExtNum;
end;

function TFileCom.GetDocDate: TDate;     // Dátum dokladu
begin
  Result := oHead.DocDate;
end;

function TFileCom.GetSmCode: longint;    // Kód skladového pohybu
begin
  Result := oHead.SmCode;
end;

function TFileCom.GetSmName: Str30;      // Názov skladového pohybu
begin
  Result := oHead.SmName;
end;

function TFileCom.GetWriNum1: longint;   // Prevádzková jednotka skladu (zdrojová v prípade medziskladového presunu)
begin
  Result := oHead.WriNum1;
end;

function TFileCom.GetWriNum2: longint;   // Cie¾ová prevádzka v prípade medziskladovéo presunu
begin
  Result := oHead.WriNum2;
end;

function TFileCom.GetDescribe: Str30;    // Popis dokladu
begin
  Result := oHead.Describe;
end;

function TFileCom.GetVatPrc1: double;    // Sadzba DPH skupiny è. 1
begin
  Result := oHead.VatPrc1;
end;

function TFileCom.GetVatPrc2: double;    // Sadzba DPH skupiny è. 2
begin
  Result := oHead.VatPrc2;
end;

function TFileCom.GetVatPrc3: double;    // Sadzba DPH skupiny è. 3
begin
  Result := oHead.VatPrc3;
end;

function TFileCom.GetAValue(pVatGrp:byte): double;     // Hodnota dokladu v NC bez DPH
var I:word;
begin
  For I:=1 to GetItmQnt do
    If (pVatGrp=GetVatGrp(I)) or (pVatGrp=0) then Result := Result+GetGsAVal(I);
end;

function TFileCom.GetBValue(pVatGrp:byte): double;     // Hodnota dokladu v NC s DPH
var I:word;
begin
  For I:=1 to GetItmQnt do
    If (pVatGrp=GetVatGrp(I)) or (pVatGrp=0) then Result := Result+GetGsBVal(I);
end;

function TFileCom.GetPAValue(pVatGrp:byte): double;     // Hodnota dokladu v PC bez DPH
var I:word;
begin
  For I:=1 to GetItmQnt do
    If (pVatGrp=GetVatGrp(I)) or (pVatGrp=0) then Result := Result+GetGsPAVal(I);
end;

function TFileCom.GetPBValue(pVatGrp:byte): double;     // Hodnota dokladu v PC s DPH
var I:word;
begin
  For I:=1 to GetItmQnt do
    If (pVatGrp=GetVatGrp(I)) or (pVatGrp=0) then Result := Result+GetGsPBVal(I);
end;

function TFileCom.GetPaPCode: longint;   // Prvotný kód partnera
begin
  Result := oHead.PaPCode;
end;

function TFileCom.GetPaSCode: word;      // Druhotný kód partnera
begin
  Result := oHead.PaSCode;
end;

function TFileCom.GetPaName: Str30;      // Názov partnera
begin
  Result := oHead.PaName;
end;

function TFileCom.GetPaIno: Str15;       // IÈO partnera
begin
  Result := oHead.PaIno;
end;

function TFileCom.GetPaTin: Str15;       // DIÈ partnera
begin
  Result := oHead.PaTin;
end;

function TFileCom.GetPaAddr: Str30;      // Adresa partnera
begin
  Result := oHead.PaAddr;
end;

function TFileCom.GetPaConto: Str30;     // Bakový úèet partnera
begin
  Result := oHead.PaConto;
end;

function TFileCom.GetItmQnt: word;       // Poèet položiek dokladu
begin
  Result := oItems.Count;
end;

function TFileCom.GetItmNum (pItm:word): word;    // Poradové èíslo položky dokladu
begin
  oItemData := oItems.Items[pItm-1];
  Result := oItemData^.ItmNum;
end;

function TFileCom.GetGsCode (pItm:word): longint; // Tovarové èíslo položky
begin
  oItemData := oItems.Items[pItm-1];
  Result := oItemData^.GsCode;
end;

function TFileCom.GetGsName (pItm:word): Str30;   // Názov tovaru
begin
  oItemData := oItems.Items[pItm-1];
  Result := oItemData^.GsName;
end;

function TFileCom.GetBarCode (pItm:word): Str15;  // Èiarový kód tovaru
begin
  oItemData := oItems.Items[pItm-1];
  Result := oItemData^.BarCode;
end;

function TFileCom.GetStCode (pItm:word): Str15;   // Skladový kód tovaru
begin
  oItemData := oItems.Items[pItm-1];
  Result := oItemData^.StCode;
end;

function TFileCom.GetMsName (pItm:word): Str10;   // Merná jednotka tovaru
begin
  oItemData := oItems.Items[pItm-1];
  Result := oItemData^.MsName;
end;

function TFileCom.GetVatPrc (pItm:word): double;  // Sadzba DPH
begin
  oItemData := oItems.Items[pItm-1];
  Result := oItemData^.VatPrc;
end;

function TFileCom.GetVatGrp (pItm:word): byte;    // Skupina DPH
begin
  oItemData := oItems.Items[pItm-1];
  Result := DocVatGrp(oItemData^.VatPrc,GetVatPrc1,GetVatPrc2,GetVatPrc3);
end;

function TFileCom.GetGsQnt (pItm:word): double;   // Množstvo tovaru
begin
  oItemData := oItems.Items[pItm-1];
  Result := oItemData^.GsQnt;
end;

function TFileCom.GetGsAVal (pItm:word): double;  // Hodnota tovaru v NC bez DPH
begin
  oItemData := oItems.Items[pItm-1];
  Result := oItemData^.GsAVal;
end;

function TFileCom.GetGsBVal (pItm:word): double;  // Hodnota tovaru v NC s DPH
begin
  oItemData := oItems.Items[pItm-1];
  Result := oItemData^.GsBVal;
end;

function TFileCom.GetGsPAVal (pItm:word): double;  // Hodnota tovaru v PC bez DPH
begin
  oItemData := oItems.Items[pItm-1];
  Result := oItemData^.GsPAVal;
end;

function TFileCom.GetGsPBVal (pItm:word): double;  // Hodnota tovaru v PC s DPH
begin
  oItemData := oItems.Items[pItm-1];
  Result := oItemData^.GsPBVal;
end;

end.
