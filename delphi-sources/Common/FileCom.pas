unit FileCom;

interface

uses
  IcTypes, IcConv, TxtWrap, TxtCut, NexGlob,
  Controls, Classes, SysUtils;

type
  THead = record
    DocNum: Str12;      // ��tovn� ��slo dokladu
    ExtNum: Str12;      // Extern� ��slo dokladu
    DocDate: TDate;     // D�tum dokladu
    SmCode: longint;    // K�d skladov�ho pohybu
    SmName: Str30;      // N�zov skladov�ho pohybu
    WriNum1: longint;   // Prev�dzkov� jednotka skladu (zdrojov� v pr�pade medziskladov�ho presunu)
    WriNum2: longint;   // Cie�ov� prev�dzka v pr�pade medziskladov�o presunu
    Describe: Str30;    // Popis dokladu
    VatPrc1: double;    // Sadzba DPH skupiny �. 1
    VatPrc2: double;    // Sadzba DPH skupiny �. 2
    VatPrc3: double;    // Sadzba DPH skupiny �. 3
    AValue: double;     // Hodnota dokladu v NC bez DPH
    BValue: double;     // Hodnota dokladu v NC s DPH
    PAValue: double;    // Hodnota dokladu v PC bez DPH
    PBValue: double;    // Hodnota dokladu v PC s DPH 
    PaPCode: longint;   // Prvotn� k�d partnera
    PaSCode: word;      // Druhotn� k�d partnera
    PaName: Str30;      // N�zov partnera
    PaIno: Str15;       // I�O partnera
    PaTin: Str15;       // DI� partnera
    PaAddr: Str30;      // Adresa partnera
    PaConto: Str30;     // Bakov� ��et partnera
    ItmQnt: word;       // Po�et polo�iek dokladu
  end;

  TItem = record
    ItmNum: word;       // Poradov� ��slo polo�ky dokladu
    GsCode: longint;    // Tovarov� ��slo polo�ky
    GsName: Str30;      // N�zov tovaru
    BarCode: Str15;     // �iarov� k�d tovaru
    StCode: Str15;      // Skladov� k�d tovaru
    MsName: Str10;      // Mern� jednotka tovaru
    VatPrc: double;     // Sadzba DPH
    GsQnt: double;      // Mno�stvo tovaru
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
    procedure SetHead (pDocNum: Str12;      // ��tovn� ��slo dokladu
                       pExtNum: Str12;      // Extern� ��slo dokladu
                       pDocDate: TDate;     // D�tum dokladu
                       pSmCode: longint;    // K�d skladov�ho pohybu
                       pSmName: Str30;      // N�zov skladov�ho pohybu
                       pWriNum1: longint;   // Prev�dzkov� jednotka skladu (zdrojov� v pr�pade medziskladov�ho presunu)
                       pWriNum2: longint;   // Cie�ov� prev�dzka v pr�pade medziskladov�o presunu
                       pDescribe: Str30;    // Popis dokladu
                       pVatPrc1: double;    // Sadzba DPH skupiny �. 1
                       pVatPrc2: double;    // Sadzba DPH skupiny �. 2
                       pVatPrc3: double;    // Sadzba DPH skupiny �. 3
                       pAValue: double;     // Hodnota dokladu v NC bez DPH
                       pBValue: double;     // Hodnota dokladu v NC s DPH
                       pPAValue: double;    // Hodnota dokladu v PC bez DPH
                       pPBValue: double);   // Hodnota dokladu v PC  s DPH

    procedure SetPart (pPaPCode: longint;   // Prvotn� k�d partnera
                       pPaSCode: word;      // Druhotn� k�d partnera
                       pPaName: Str30;      // N�zov partnera
                       pPaIno: Str15;       // I�O partnera
                       pPaTin: Str15;       // DI� partnera
                       pPaAddr: Str30;      // Adresa partnera
                       pPaConto: Str30);    // Bakov� ��et partnera

    procedure AddItem (pItmNum: word;       // Poradov� ��slo polo�ky dokladu
                       pGsCode: longint;    // Tovarov� ��slo polo�ky
                       pGsName: Str30;      // N�zov tovaru
                       pBarCode: Str15;     // �iarov� k�d tovaru
                       pStCode: Str15;      // Skladov� k�d tovaru
                       pMsName: Str10;      // Mern� jednotka tovaru
                       pVatPrc: double;     // Sadzba DPH
                       pGsQnt: double;      // Mno�stvo tovaru
                       pGsAVal: double;     // Hodnota tovaru v NC bez DPH
                       pGsBVal: double;     // Hodnota tovaru v NC s DPH
                       pGsPAVal: double;    // Hodnota tovaru v PC bez DPH
                       pGsPBVal: double);   // Hodnota tovaru v PC s DPH

    procedure SaveToFile (pFile:string);    // Ulo�i �daje dokladu do s�boru

    procedure LoadFromFile (pFile:string);  // Na��ta �daje dokladu zo s�boru
    // �daje hlavi�ky dokladu
    function GetDocNum: Str12;      // ��tovn� ��slo dokladu
    function GetExtNum: Str12;      // Extern� ��slo dokladu
    function GetDocDate: TDate;     // D�tum dokladu
    function GetSmCode: longint;    // K�d skladov�ho pohybu
    function GetSmName: Str30;      // N�zov skladov�ho pohybu
    function GetWriNum1: longint;   // Prev�dzkov� jednotka skladu (zdrojov� v pr�pade medziskladov�ho presunu)
    function GetWriNum2: longint;   // Cie�ov� prev�dzka v pr�pade medziskladov�o presunu
    function GetDescribe: Str30;    // Popis dokladu
    function GetVatPrc1: double;    // Sadzba DPH skupiny �. 1
    function GetVatPrc2: double;    // Sadzba DPH skupiny �. 2
    function GetVatPrc3: double;    // Sadzba DPH skupiny �. 3
    function GetAValue(pVatGrp:byte): double;     // Hodnota dokladu v NC bez DPH
    function GetBValue(pVatGrp:byte): double;     // Hodnota dokladu v NC s DPH
    function GetPAValue(pVatGrp:byte): double;    // Hodnota dokladu v PC bez DPH
    function GetPBValue(pVatGrp:byte): double;    // Hodnota dokladu v PC s DPH
    function GetPaPCode: longint;   // Prvotn� k�d partnera
    function GetPaSCode: word;      // Druhotn� k�d partnera
    function GetPaName: Str30;      // N�zov partnera
    function GetPaIno: Str15;       // I�O partnera
    function GetPaTin: Str15;       // DI� partnera
    function GetPaAddr: Str30;      // Adresa partnera
    function GetPaConto: Str30;     // Bakov� ��et partnera
    function GetItmQnt: word;       // Po�et polo�iek dokladu

    // Udaje polo�iek dokladu
    function GetItmNum (pItm:word): word;       // Poradov� ��slo polo�ky dokladu
    function GetGsCode (pItm:word): longint;    // Tovarov� ��slo polo�ky
    function GetGsName (pItm:word): Str30;      // N�zov tovaru
    function GetBarCode (pItm:word): Str15;     // �iarov� k�d tovaru
    function GetStCode (pItm:word): Str15;      // Skladov� k�d tovaru
    function GetMsName (pItm:word): Str10;      // Mern� jednotka tovaru
    function GetVatPrc (pItm:word): double;     // Sadzba DPH
    function GetVatGrp (pItm:word): byte;       // Skupina DPH
    function GetGsQnt (pItm:word): double;      // Mno�stvo tovaru
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
  oHead.DocNum := pDocNum;       // ��tovn� ��slo dokladu
  oHead.ExtNum := pExtNum;       // Extern� ��slo dokladu
  oHead.DocDate := pDocDate;     // D�tum dokladu
  oHead.SmCode := pSmCode;       // K�d skladov�ho pohybu
  oHead.SmName := pSmName;       // N�zov skladov�ho pohybu
  oHead.WriNum1 := pWriNum1;     // Prev�dzkov� jednotka skladu (zdrojov� v pr�pade medziskladov�ho presunu)
  oHead.WriNum2 := pWriNum2;     // Cie�ov� prev�dzka v pr�pade medziskladov�o presunu
  oHead.Describe := pDescribe;   // Popis dokladu
  oHead.VatPrc1 := pVatPrc1;     // Sadzba DPH skupiny �. 1
  oHead.VatPrc2 := pVatPrc2;     // Sadzba DPH skupiny �. 2
  oHead.VatPrc3 := pVatPrc3;     // Sadzba DPH skupiny �. 3
  oHead.AValue := pAValue;       // Hodnota dokladu v NC bez DPH
  oHead.BValue := pBValue;       // Hodnota dokladu v NC s DPH
  oHead.PAValue := pPAValue;     // Hodnota dokladu v PC bez DPH
  oHead.PBValue := pPBValue;     // Hodnota dokladu v PC s DPH
end;

procedure TFileCom.SetPart;
begin
  oHead.PaPCode := pPaPCode;     // Prvotn� k�d partnera
  oHead.PaSCode := pPaSCode;     // Druhotn� k�d partnera
  oHead.PaName := pPaName;       // N�zov partnera
  oHead.PaIno := pPaIno;         // I�O partnera
  oHead.PaTin := pPaTin;         // DI� partnera
  oHead.PaAddr := pPaAddr;       // Adresa partnera
  oHead.PaConto := pPaConto;     // Bakov� ��et partnera
end;

procedure TFileCom.AddItem;
begin
  New (oItemData);
  oItemData^.ItmNum := pItmNum;   // Poradov� ��slo polo�ky dokladu
  oItemData^.GsCode := pGsCode;   // Tovarov� ��slo polo�ky
  oItemData^.GsName := pGsName;   // N�zov tovaru
  oItemData^.BarCode := pBarCode; // �iarov� k�d tovaru
  oItemData^.StCode := pStCode;   // Skladov� k�d tovaru
  oItemData^.MsName := pMsName;   // Mern� jednotka tovaru
  oItemData^.VatPrc := pVatPrc;   // Sadzba DPH
  oItemData^.GsQnt := pGsQnt;     // Mno�stvo tovaru
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
  mWrap.SetText ('H',1);             // Ozna�enie �e sa jedn� o hlavi�ky dokladu
  mWrap.SetText (oHead.DocNum,0);    // ��tovn� ��slo dokladu
  mWrap.SetText (oHead.ExtNum,0);    // Extern� ��slo dokladu
  mWrap.SetText (DateToStr(oHead.DocDate),0);  // D�tum dokladu
  mWrap.SetNum  (oHead.SmCode,0);    // K�d skladov�ho pohybu
  mWrap.SetText (oHead.SmName,0);    // N�zov skladov�ho pohybu
  mWrap.SetNum  (oHead.WriNum1,0);   // Prev�dzkov� jednotka dokladu
  mWrap.SetNum  (oHead.WriNum2,0);   // Prev�dzkov� jednotka dokladu - cie�ov� prev�dzka pri MP
  mWrap.SetText (oHead.Describe,0);  // Popis dokladu
  mWrap.SetReal (oHead.VatPrc1,0,1); // Sadzba DPH 1
  mWrap.SetReal (oHead.VatPrc2,0,1); // Sadzba DPH 2
  mWrap.SetReal (oHead.VatPrc3,0,1); // Sadzba DPH 3
  mWrap.SetReal (oHead.AValue,0,2);  // Hodnota dokladu v NC bez DPH
  mWrap.SetReal (oHead.BValue,0,2);  // Hodnota dokladu v NC s DPH
  mWrap.SetReal (oHead.PAValue,0,2); // Hodnota dokladu v PC bez DPH
  mWrap.SetReal (oHead.PBValue,0,2); // Hodnota dokladu v PC s DPH
  mWrap.SetNum  (oHead.PaPCode,0);   // Prvotn� k�d partnera
  mWrap.SetNum  (oHead.PaSCode,0);   // Druhotn� k�d partnera
  mWrap.SetText (oHead.PaName,0);    // N�zov partnera
  mWrap.SetText (oHead.PaIno,0);     // I�O partnera
  mWrap.SetText (oHead.PaTin,0);     // DI� partnera
  mWrap.SetText (oHead.PaAddr,0);    // Adresa partnera
  mWrap.SetText (oHead.PaConto,0);   // Bankov� ��et partnera
  mWrap.SetNum  (oItems.Count,0);    // Po�et polo�iek dokladu
  mFile.Add (mWrap.GetWrapText);

  For I:=0 to oItems.Count-1 do begin
    oItemData := oItems.Items[I];  // Na��tame premennu z pam�te
    mWrap.ClearWrap;
    mWrap.SetText ('I',1);  // Ozna�enie �e sa jedn� o polo�iek dokladu
    mWrap.SetNum (oItemData^.ItmNum,0);     // Poradov� ��slo polo�ky dokladu
    mWrap.SetNum (oItemData^.GsCode,0);     // Tovarov� ��slo polo�ky
    mWrap.SetText (oItemData^.GsName,0);    // N�zov tovaru
    mWrap.SetText (oItemData^.BarCode,0);   // �iarov� k�d tovaru
    mWrap.SetText (oItemData^.StCode,0);    // Skladov� k�d tovaru
    mWrap.SetText (oItemData^.MsName,0);    // Mern� jednotka tovaru
    mWrap.SetReal (oItemData^.VatPrc,0,1);  // Sadzba DPH
    mWrap.SetReal (oItemData^.GsQnt,0,2);   // Mno�stvo tovaru
    mWrap.SetReal (oItemData^.GsAVal,0,2);  // Hodnota tovaru v NC bez DPH
    mWrap.SetReal (oItemData^.GsBVal,0,2);  // Hodnota tovaru v NC s DPH
    mWrap.SetReal (oItemData^.GsPAVal,0,2); // Hodnota tovaru v NC bez DPH
    mWrap.SetReal (oItemData^.GsPBVal,0,2); // Hodnota tovaru v NC s DPH
    mFile.Add (mWrap.GetWrapText);
    Dispose(oItemData);  // Zru��me premenn� a uvoln�me miesto v pam�ti
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
      oHead.DocNum := mCut.GetText (2);   // ��tovn� ��slo dokladu
      oHead.ExtNum := mCut.GetText (3);   // Extern� ��slo dokladu
      oHead.DocDate := StrToDate(mCut.GetText(4));  // D�tum dokladu
      oHead.SmCode := mCut.GetNum (5);    // K�d skladov�ho pohybu
      oHead.SmName := mCut.GetText (6);   // N�zov skladov�ho pohybu
      oHead.WriNum1 := mCut.GetNum (7);   // Prev�dzkov� jednotka
      oHead.WriNum1 := mCut.GetNum (8);   // Prev�dzkov� jednotka - cie�ov� prv�dzka v pr�pade MP
      oHead.Describe := mCut.GetText (9); // Textov� popis dokladu
      oHead.VatPrc1 := mCut.GetReal (10); // Sadzba DPH 1
      oHead.VatPrc2 := mCut.GetReal (11); // Sadzba DPH 2
      oHead.VatPrc3 := mCut.GetReal (12); // Sadzba DPH 3
      oHead.AValue := mCut.GetReal (13);  // Hodnota dokladu v NC bez FPH
      oHead.BValue := mCut.GetReal (14);  // Hodnota dokladu v NC s FPH
      oHead.PAValue := mCut.GetReal (15); // Hodnota dokladu v PC bez FPH
      oHead.PBValue := mCut.GetReal (16); // Hodnota dokladu v PC s FPH
      oHead.PaPCode := mCut.GetNum (17);  // Prvotn� k�d partnera
      oHead.PaSCode := mCut.GetNum (18);  // Druhotn� k�d partnera
      oHead.PaName := mCut.GetText (19);  // N�zov partnera
      oHead.PaIno := mCut.GetText (20);   // I�O partnera
      oHead.PaTin := mCut.GetText (21);   // DI� partnera
      oHead.PaAddr := mCut.GetText (22);  // Adresa partnera
      oHead.PaConto := mCut.GetText (23); // Bamkov� ��et partnera
      oHead.ItmQnt := mCut.GetNum (24);   // Po�et polo�iek dokladu
    end;
    If mCut.GetText(1)='I' then begin
      New (oItemData);  // Vytvorime novu premennu na ulo�nie na��tan�ch �dajov
      oItemData^.ItmNum := mCut.GetNum (2);    // Poradov� ��slo polo�ky dokladu
      oItemData^.GsCode := mCut.GetNum (3);    // Tovarov� ��slo polo�ky
      oItemData^.GsName := mCut.GetText (4);   // N�zov tovaru
      oItemData^.BarCode := mCut.GetText (5);  // �iarov� k�d tovaru
      oItemData^.StCode := mCut.GetText (6);   // Skladov� k�d tovaru
      oItemData^.MsName := mCut.GetText (7);   // Mern� jednotka tovaru
      oItemData^.VatPrc := mCut.GetReal (8);   // Sadzba DPH
      oItemData^.GsQnt := mCut.GetReal (9);    // Mno�stvo tovaru
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

function TFileCom.GetDocNum: Str12;      // ��tovn� ��slo dokladu
begin
  Result := oHead.DocNum;
end;

function TFileCom.GetExtNum: Str12;      // Extern� ��slo dokladu
begin
  Result := oHead.ExtNum;
end;

function TFileCom.GetDocDate: TDate;     // D�tum dokladu
begin
  Result := oHead.DocDate;
end;

function TFileCom.GetSmCode: longint;    // K�d skladov�ho pohybu
begin
  Result := oHead.SmCode;
end;

function TFileCom.GetSmName: Str30;      // N�zov skladov�ho pohybu
begin
  Result := oHead.SmName;
end;

function TFileCom.GetWriNum1: longint;   // Prev�dzkov� jednotka skladu (zdrojov� v pr�pade medziskladov�ho presunu)
begin
  Result := oHead.WriNum1;
end;

function TFileCom.GetWriNum2: longint;   // Cie�ov� prev�dzka v pr�pade medziskladov�o presunu
begin
  Result := oHead.WriNum2;
end;

function TFileCom.GetDescribe: Str30;    // Popis dokladu
begin
  Result := oHead.Describe;
end;

function TFileCom.GetVatPrc1: double;    // Sadzba DPH skupiny �. 1
begin
  Result := oHead.VatPrc1;
end;

function TFileCom.GetVatPrc2: double;    // Sadzba DPH skupiny �. 2
begin
  Result := oHead.VatPrc2;
end;

function TFileCom.GetVatPrc3: double;    // Sadzba DPH skupiny �. 3
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

function TFileCom.GetPaPCode: longint;   // Prvotn� k�d partnera
begin
  Result := oHead.PaPCode;
end;

function TFileCom.GetPaSCode: word;      // Druhotn� k�d partnera
begin
  Result := oHead.PaSCode;
end;

function TFileCom.GetPaName: Str30;      // N�zov partnera
begin
  Result := oHead.PaName;
end;

function TFileCom.GetPaIno: Str15;       // I�O partnera
begin
  Result := oHead.PaIno;
end;

function TFileCom.GetPaTin: Str15;       // DI� partnera
begin
  Result := oHead.PaTin;
end;

function TFileCom.GetPaAddr: Str30;      // Adresa partnera
begin
  Result := oHead.PaAddr;
end;

function TFileCom.GetPaConto: Str30;     // Bakov� ��et partnera
begin
  Result := oHead.PaConto;
end;

function TFileCom.GetItmQnt: word;       // Po�et polo�iek dokladu
begin
  Result := oItems.Count;
end;

function TFileCom.GetItmNum (pItm:word): word;    // Poradov� ��slo polo�ky dokladu
begin
  oItemData := oItems.Items[pItm-1];
  Result := oItemData^.ItmNum;
end;

function TFileCom.GetGsCode (pItm:word): longint; // Tovarov� ��slo polo�ky
begin
  oItemData := oItems.Items[pItm-1];
  Result := oItemData^.GsCode;
end;

function TFileCom.GetGsName (pItm:word): Str30;   // N�zov tovaru
begin
  oItemData := oItems.Items[pItm-1];
  Result := oItemData^.GsName;
end;

function TFileCom.GetBarCode (pItm:word): Str15;  // �iarov� k�d tovaru
begin
  oItemData := oItems.Items[pItm-1];
  Result := oItemData^.BarCode;
end;

function TFileCom.GetStCode (pItm:word): Str15;   // Skladov� k�d tovaru
begin
  oItemData := oItems.Items[pItm-1];
  Result := oItemData^.StCode;
end;

function TFileCom.GetMsName (pItm:word): Str10;   // Mern� jednotka tovaru
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

function TFileCom.GetGsQnt (pItm:word): double;   // Mno�stvo tovaru
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
