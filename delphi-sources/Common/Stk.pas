unit Stk;
{$F+}

// *****************************************************************************
//                   OBJEKT NA PRACU SO SKLADOVYMI KARTAMI
// *****************************************************************************
// Programové funkcia:
// ---------------
// xxx -
// *****************************************************************************


interface

uses // hOCI, hOSI, 
  IcTypes, IcConst, IcConv, IcTools, IcDate, IcVariab,
  NexGlob, NexPath, NexMsg, NexIni,
  DocHand, Key, StkGlob,
  hSTK, hFIF, hSTM, hSTB, hSTS, hSTP, hGSCAT, hIMI,
//bSTK, bFIF, bSTM, bSTB, bSTO, bSTS, bSTP, bOCI, bOSI, bGSCAT,
  NexBtrTable, NexPxTable, ComCtrls, SysUtils, Classes, Forms, Controls;

type
  TGscDat = record
    GsCode:longint;     // Tovarové èíslo
    MgCode:word;        // Èíslo tovarovej skupiny
    GsName:Str30;       // Názov tovaru
    BarCode:Str15;      // Identifikaèný kód tovaru
    StkCode:Str15;      // Skladový kód tovaru
    VatPrc:byte;        // Sadzba DPH tovaru
    MsName:Str10;       // Merná jednotka tovaru
    DocNum:Str12;       // Èíslo skladového dokladu
    ItmNum:longint;     // Poradové èíslo položky na skladovom doklade
    DocDate:TDateTime;  // Dátum skladového dokladu
    DrbDate:TDateTime;  // Dátum záruky
    RbaDate: TDateTime;  // Dátum vyrobnej sarze
    RbaCode: Str30;      // Vyrobna sarza
    CPrice:double;      // Nákupná cena tovaru bez DPH
    CValue:double;      // Nákupná hodnota tovaru bez DPH
    GsQnt:double;       // Množstvo ktoré treba prija(+) alebo vyda(-)
    BPrice:double;      // jednotkova predajna cena tovaru s DPH
    OcdNum:Str12;       // Èíslo došlej objednávky
    OcdItm:word;        // Poradové èíslo položky na objednávke
    PaCode:longint;     // Prvotný kód dodávate¾a
    SmCode:word;        // Kód skladového pohybu
    SmSign:Str1;        // Znak skladového pohybu
    FifNum:longint;     // Poradové èíslo FIFO - používa sa pri príjmu tovaru na sklad
    AcqSta:Str1;       // Priznak obstarania tovaru
    ConStk:word;        // Cislo protiskladu
  end;

  TFifDat = array [1..100] of record
    FifNum:longint;
    OutQnt:double;
    CPrice:double;
    PaCode:longint;
    AcqSta:Str1;       // Priznak obstarania tovaru
    ActPos:longint;
    RbaDate: TDateTime;  // Dátum vyrobnej sarze
    RbaCode: Str30;      // Vyrobna sarza
  end;

  TFifLst = class(TComponent) // Vytvori zozna FIFO kariet na vydaj zadaneho mnozstva
    constructor Create;
    destructor  Destroy; override;
    private
      oFifCnt:byte; // Po4et najdenych FIFO kariet
      oFifDat:TFifDat;
      function GetFifNum(pIndex:byte):longint;
      function GetOutQnt(pIndex:byte):double;
      function GetCPrice(pIndex:byte):double;
      function GetActPos(pIndex:byte):longint;
      function GetPaCode(pIndex:byte):longint;
      function GetAcqSta(pIndex:byte):Str1;
      function GetRbaDate(pIndex:byte):TDate;
      function GetRbaCode(pIndex:byte):Str30;
      function GetSumQnt:double;
      function GetCValue:double;
    public
      procedure Clear;
      procedure Add(pFifNum:longint;pGsQnt:double;pCPrice:double;pPaCode:longint;pAcqSta:Str1;pRbaDate:Tdate;pRbaCode:Str30;pPos:longint);
      procedure Run(pGsCode:longint;pGsQnt:double;phFIF:TFifHnd);
      property FifCnt:byte read oFifCnt;
      property FifNum[pIndex:byte]:longint read GetFifNum;
      property OutQnt[pIndex:byte]:double read GetOutQnt;
      property CPrice[pIndex:byte]:double read GetCPrice;
      property PaCode[pIndex:byte]:longint read GetPaCode;
      property AcqSta[pIndex:byte]:Str1 read GetAcqSta;
      property RbaCode[pIndex:byte]:Str30 read GetRbaCode;
      property RbaDate[pIndex:byte]:TDate read GetRbaDate;
      property ActPos[pIndex:byte]:longint read GetActPos;
      property SumQnt:double read GetSumQnt; // Kumulativne mnozstvo ktore treba vydat
      property CValue:double read GetCValue; // Kumulativna hodnota vydaja (vsetkych FIFO) v NC bez DPH
  end;

  TStk = class(TComponent)
    constructor Create; overload;
    destructor  Destroy; override;
    private
      oGsc: TGscDat;
      oFld: TStrings; // Zoznam poli ktore neboli zadane
      oStk:TList; // Zoznam otvorenych subotov STK
      oFif:TList; // Zoznam otvorenych subotov FIF
      oStm:TList; // Zoznam otvorenych subotov STM
      oStb:TList; // Zoznam otvorenych subotov STB
      oSto:TList; // Zoznam otvorenych subotov STO
      oSts:TList; // Zoznam otvorenych subotov STS
      oFifLst: TFifLst; // Vytvori zozna FIFO kariet z ktoreho bedeme vydavat
      oPath  : String;
      function FldText(pFieldName:Str20;pTable:TNexBtrTable):ShortString;
      function FldLong(pFieldName:Str20;pTable:TNexBtrTable):longint;
      function FldDoub(pFieldName:Str20;pTable:TNexBtrTable):double;
      function FldDate(pFieldName:Str20;pTable:TNexBtrTable):TDateTime;
      procedure SetStkNum(pStkNum:word); // Otvori skladove subory na zadany sklad
      procedure AddToFif;  // Prida príjem do FIFO kariet
      procedure OutFrFif;  // Vydá z príslušnej fifo karty
      procedure AddToStm;  // Prida novy skladovy pohyb prijmu alebo výdaja
      procedure ClcToStk;  // Pripocita pohyb na skladovu kartu zasob
      procedure ModFif;    // zmeni mnozstvo na FIFO karte
      procedure ModStm;    // Prida novy skladovy pohyb prijmu alebo výdaja
    public
      ohGSCAT:TGscatHnd;
      ohSTK:TStkHnd;
      ohFIF:TFifHnd;
      ohSTM:TStmHnd;
      ohSTB:TStbHnd;
//      ohSTO:TStoHnd;
      ohSTS:TStsHnd;
      constructor Create(pPath:ShortString); overload;
      procedure Open(pStkNum:word);
      procedure Clear; // Vynuluje premenne a nastavi objekt na zadavanie novej polozky
      procedure Activate(pIndex:word); // Aktivuje databazu, ktora je otvorena pod poradovym cislom pIndex
      procedure Dat(pTable:TNexBtrTable); // Zapiše do bufferu údaje tovaru zo zadanej databáze, na ktorý bude vytvorený príjem alebo výdaj
      procedure Clc(pGsCode:longint;pStm,pSts,pOcd,pOsd,pImd:boolean); // Prepocita skladovu kartu zo zadanych zdrojov
      procedure Del(pTbl:Str3;pDocNum:Str12;pItmNum:longint);
      procedure Ren(pSrcDoc:Str12;pSrcItm:longint;pTrgDoc:Str12;pTrgItm:longint); // Zmeni cislo dokladu zadanej polozky na pTrgNum
//      procedure Dlv(pStkNum:word;pDocNum:Str12;pItmNum:word;pDlvQnt:double;pDlvDate:TDateTime); // Zrusi rezervaciu zadanej polozky na skladovej karte
      procedure Sts(pStkNum:word;pDocNum:Str12;pItmNum:word;pGsCode:longint;pSalQnt:double;pSalDate:TDateTime); // Zalozi rezervaciu na predaj, ak mnozstvo je 0 zrusi rezervaciu
      procedure StsCad(pStkNum:word;pDocNum:Str12;pItmNum:word;pGsCode:longint;pSalQnt:double;pSalDate:TDateTime;pCasNum:integer); // Zalozi rezervaciu na predaj, ak mnozstvo je 0 zrusi rezervaciu
      procedure AddStc(pGsCode:longint); // Prida novu skladovu kartu do STK
      procedure ClcStc(pGsCode:longint); // Prepocita skladovukartu podla pohybov
(*
      procedure AddSto(phIMI:TImiHnd); overload;
      procedure AddSto(phOSI:TOsiHnd); overload;
      function  AddSto(phOCI:TOciHnd):Str1; overload; // Vyhotovi rezervaciu na zadany riadok zakazky
      procedure DelSto(pDocNum:Str12;pItmNum:longint); // Vyhotovi rezervaciu na zadany riadok zakazky
      procedure StoRef(phOCI:TOciHnd); overload; // Obnovi zaznam SRO na zaklade polozky zakazky
      procedure StoRef(phOSI:TOsiHnd); overload; // Obnovi zaznam SRO na zaklade polozky objednavky
      procedure StoRef(phIMI:TImiHnd); overload; // Obnovi zaznam SRO na zaklade polozky prijemky TOVAR NA CESTE
*)
      procedure OutPdnClear (pDocNum:Str12;pItmNum,pStkNum:longint); // Vymaze vydaj vyrobneho cisla zadanej polozky vydajoveho dokladu

      function Sub(pStkNum:word):boolean; // Vykoná príjem alebo výdaj tovaru zo skladu
      function SubMod(pStkNum:word):boolean;
      // Vykoná príjem alebo výdaj tovaru zo skladu , ak uz boli robene vydaje a stornujeme rsp. modifikujeme vydaj tak zmeni udaje pohybu a FIFO a nespravi novy prijem

      function Uns(pStkNum:word;pDocNum:Str12;pItmNum:longint):boolean; // Stornuje skladovu operaciu danej polozky
      function GetOpenCount:word;
      function ClcStm(pDocNum:Str12;pItmNum:longint):double;  // Spocita mnozstvo vybranej polozky dokladu zo skladovych pohybov
//      function OcdOsdStoVer(pDocNum:Str12;pItmNum:longint):string; // Kontrola dodania objednavok z zakazkach
      function GetFre(pStkNum:word;pGsCode:longint):double;   // vrati volne mnozstvo
      procedure MyOut;
      function VerifyRba   (pStkNum,pGsCode:longint;pRbaCode:Str30;pQnt:Double;var pRbaQnt,pRbnQnt,pRboQnt:double;var pRbaDate:TDate):boolean;
    published
      property StkNum:word write SetStkNum;
      property GsCode:longint read oGsc.GsCode write oGsc.GsCode;
      property MgCode:word read oGsc.MgCode write oGsc.MgCode;
      property GsName:Str30 read oGsc.GsName write oGsc.GsName;
      property BarCode:Str15 read oGsc.BarCode write oGsc.BarCode;
      property StkCode:Str15 read oGsc.StkCode write oGsc.StkCode;
      property VatPrc:byte read oGsc.VatPrc write oGsc.VatPrc;
      property MsName:Str10 read oGsc.MsName write oGsc.MsName;
      property DocNum:Str12 read oGsc.DocNum write oGsc.DocNum;
      property ItmNum:longint read oGsc.ItmNum write oGsc.ItmNum;
      property DocDate:TDateTime read oGsc.DocDate write oGsc.DocDate;
      property DrbDate:TDateTime read oGsc.DrbDate write oGsc.DrbDate;
      property RbaDate:TDateTime read oGsc.RbaDate write oGsc.RbaDate;
      property RbaCode:Str30 read oGsc.RbaCode write oGsc.RbaCode;
      property CPrice:double read oGsc.CPrice write oGsc.CPrice;
      property GsQnt:double read oGsc.GsQnt write oGsc.GsQnt;
      property BPrice:double read oGsc.BPrice write oGsc.BPrice;
      property OcdNum:Str12 read oGsc.OcdNum write oGsc.OcdNum;
      property OcdItm:word read oGsc.OcdItm write oGsc.OcdItm;
      property PaCode:longint read oGsc.PaCode write oGsc.PaCode;
      property AcqSta:Str1 read oGsc.AcqSta write oGsc.AcqSta;
      property SmCode:word read oGsc.SmCode write oGsc.SmCode;
      property SmSign:Str1 read oGsc.SmSign write oGsc.SmSign;
      property FifNum:longint read oGsc.FifNum write oGsc.FifNum;
      property ConStk:word read oGsc.ConStk write oGsc.ConStk;
      property CValue:double read oGsc.CValue write oGsc.CValue;
      property Path:string read oPath write oPath;
      property FifLst:TFifLst read oFifLst;
  end;

implementation

uses bSTK, bSTO, bSTM, bFIF;

// *****************************************************************************
// ****************                TFifLst                  ********************
// *****************************************************************************

constructor TFifLst.Create;
begin
  oFifCnt:=0;
end;

destructor TFifLst.Destroy;
begin
  inherited;
end;

// ********************************* PRIVATE ***********************************

procedure TFifLst.Clear;
begin
  oFifCnt:=0;
  FillChar (oFifDat,SizeOf(TFifDat),#0);
end;

function TFifLst.GetFifNum(pIndex:byte):longint;
begin
  Result:=0;
  If pIndex in [1..100] then Result:=oFifDat[pIndex].FifNum;
end;

function TFifLst.GetOutQnt(pIndex:byte):double;
begin
  Result:=0;
  If pIndex in [1..100] then Result:=oFifDat[pIndex].OutQnt;
end;

function TFifLst.GetCPrice(pIndex:byte):double;
begin
  Result:=0;
  If pIndex in [1..100] then Result:=oFifDat[pIndex].CPrice;
end;

function TFifLst.GetPaCode(pIndex:byte):longint;
begin
  Result:=0;
  If pIndex in [1..100] then Result:=oFifDat[pIndex].PaCode;
end;

function TFifLst.GetAcqSta(pIndex:byte):Str1;
begin
  Result:='';
  If pIndex in [1..100] then Result:=oFifDat[pIndex].AcqSta;
end;

function TFifLst.GetRbaDate(pIndex:byte):TDate;
begin
  Result:=0;
  If pIndex in [1..100] then Result:=oFifDat[pIndex].RbaDate;
end;

function TFifLst.GetRbaCode(pIndex:byte):Str30;
begin
  Result:='';
  If pIndex in [1..100] then Result:=oFifDat[pIndex].RbaCode;
end;

function TFifLst.GetActPos(pIndex:byte):longint;
begin
  Result:=0;
  If pIndex in [1..100] then Result:=oFifDat[pIndex].ActPos;
end;

function TFifLst.GetSumQnt:double;
var I:byte;
begin
  Result:=0;
  For I:=1 to oFifCnt do
    Result:=Result+OutQnt[I];
end;

function TFifLst.GetCValue:double;
var I:byte;
begin
  Result:=0;
  For I:=1 to oFifCnt do
    Result:=Result+CPrice[I];
end;

// ********************************** PUBLIC ***********************************

procedure TFifLst.Add(pFifNum:longint;pGsQnt:double;pCPrice:double;pPaCode:longint;pAcqSta:Str1;pRbaDate:Tdate;pRbaCode:Str30;pPos:longint);
begin
  If oFifCnt=100 then ShowMsg(0,'Interval FIFO mimo rozsah FIFO: '+IntToStr(pFifNum)) else
  begin
    Inc(oFifCnt);
    oFifDat[oFifCnt].FifNum:=pFifNum;
    oFifDat[oFifCnt].OutQnt:=pGsQnt;
    oFifDat[oFifCnt].CPrice:=pCPrice;
    oFifDat[oFifCnt].PaCode:=pPaCode;
    oFifDat[oFifCnt].AcqSta:=pAcqSta;
    oFifDat[oFifCnt].ActPos:=pPos;
    oFifDat[oFifCnt].RbaDate:= pRbaDate;
    oFifDat[oFifCnt].RbaCode:= pRbaCode;
  end;
end;

procedure TFifLst.Run(pGsCode:longint;pGsQnt:double;phFIF:TFifHnd);
var mGsQnt:double;mO_O_R:boolean;
begin
  Clear;
  phFIF.SwapStatus;
{
  If gIni.SpecSetting='SO'
    then phFIF.NearestGsStDa(pGsCode,'A',36526)
    else phFIF.NearestGsStDa(pGsCode,'A',FirstActYearDate);
}
  phFIF.NearestGsStDa(pGsCode,'A',FirstYearDate('2000'));
  If (phFIF.GsCode=pGsCode) and (phFIF.Status='A') then begin
    mGsQnt:=pGsQnt;
    mO_O_R:=False;
    Repeat
      If oFifCnt=100 then
      begin
        ShowMsg(0,'Interval FIFO mimo rozsah PLU: '+IntToStr(pGsCode));
        mO_O_R:=True;
      end else begin
        Inc(oFifCnt);
        If phFIF.ActQnt>=mGsQnt then begin // Je dostatok na FIFO karte aby vydat tovar
          oFifDat[oFifCnt].OutQnt:=mGsQnt;
          oFifDat[oFifCnt].FifNum:=phFIF.FifNum;
          oFifDat[oFifCnt].CPrice:=phFIF.InPrice;
          oFifDat[oFifCnt].PaCode:=phFIF.PaCode;
          oFifDat[oFifCnt].AcqSta:=phFIF.AcqStat;
          oFifDat[oFifCnt].RbaDate:= phFIF.RbaDate;
          oFifDat[oFifCnt].RbaCode:= phFIF.RbaCode;
          oFifDat[oFifCnt].ActPos:=phFIF.ActPos;
          mGsQnt:=0;
        end
        else begin // Na karte nie je dostatok tovaru aby vydat vsetko
          oFifDat[oFifCnt].OutQnt:=phFIF.ActQnt;
          oFifDat[oFifCnt].FifNum:=phFIF.FifNum;
          oFifDat[oFifCnt].CPrice:=phFIF.InPrice;
          oFifDat[oFifCnt].PaCode:=phFIF.PaCode;
          oFifDat[oFifCnt].AcqSta:=phFIF.AcqStat;
          oFifDat[oFifCnt].RbaDate:= phFIF.RbaDate;
          oFifDat[oFifCnt].RbaCode:= phFIF.RbaCode;
          oFifDat[oFifCnt].ActPos:=phFIF.ActPos;
          mGsQnt:=mGsQnt-phFIF.ActQnt;
        end;
      end;
      phFIF.Next;
    until mO_O_R or(oFifCnt>100)or phFIF.Eof or (phFIF.GsCode<>pGsCode) or (phFIF.Status<>'A') or IsNul(mGsQnt);
  end;
  phFIF.RestoreStatus;
end;

// *****************************************************************************
// ****************                  TStk                   ********************
// *****************************************************************************

constructor TStk.Create;
begin
  oPath:='';
  oFifLst:=TFifLst.Create;
  oFld:=TStringList.Create;  oFld.Clear;
  ohGSCAT:=TGscatHnd.Create;
  oStk:=TList.Create;  oStk.Clear;
  oFif:=TList.Create;  oFif.Clear;
  oStm:=TList.Create;  oStm.Clear;
  oStb:=TList.Create;  oStb.Clear;
  oSto:=TList.Create;  oSto.Clear;
  oSts:=TList.Create;  oSts.Clear;

  ohSTK:=TStkHnd.Create;
  ohFIF:=TFifHnd.Create;
  ohSTM:=TStmHnd.Create;
  ohSTB:=TStbHnd.Create;
//  ohSTO:=TStoHnd.Create;
  ohSTS:=TStsHnd.Create;
end;

constructor TStk.Create(pPath: ShortString);
begin
  oPath:=pPath;
  oFifLst:=TFifLst.Create;
  oFld:=TStringList.Create;  oFld.Clear;
  ohGSCAT:=TGscatHnd.Create(oPath);
  oStk:=TList.Create;  oStk.Clear;
  oFif:=TList.Create;  oFif.Clear;
  oStm:=TList.Create;  oStm.Clear;
  oStb:=TList.Create;  oStb.Clear;
  oSto:=TList.Create;  oSto.Clear;
  oSts:=TList.Create;  oSts.Clear;

  ohSTK:=TStkHnd.Create(oPath);
  ohFIF:=TFifHnd.Create(oPath);
  ohSTM:=TStmHnd.Create(oPath);
  ohSTB:=TStbHnd.Create(oPath);
//  ohSTO:=TStoHnd.Create(oPath);
  ohSTS:=TStsHnd.Create(oPath);
end;

destructor TStk.Destroy;
var I:word;
begin
  FreeAndNil (oFld);
  FreeAndNil (oFifLst);
  FreeAndNil (ohGSCAT);
  If oStk.Count>0 then begin
    For I:=0 to oStk.Count-1 do begin
      Activate (I);
      FreeAndNil (ohSTK);
      FreeAndNil (ohFIF);
      FreeAndNil (ohSTM);
      FreeAndNil (ohSTB);
//      FreeAndNil (ohSTO);
      FreeAndNil (ohSTS);
    end;
  end;
  FreeAndNil (oStk);
  FreeAndNil (oFif);
  FreeAndNil (oStm);
  FreeAndNil (oStb);
  FreeAndNil (oSto);
  FreeAndNil (oSts);
  inherited;
end;

// ********************************* PRIVATE ***********************************

function TStk.FldText (pFieldName:Str20;pTable:TNexBtrTable):ShortString;
begin
  Result:='';
  If pTable.FindField(pFieldName)<>nil
    then Result:=pTable.FieldByName(pFieldName).AsString
    else oFld.Add(pFieldName);
end;

function TStk.FldLong (pFieldName:Str20;pTable:TNexBtrTable):longint;
begin
  Result:=0;
  If pTable.FindField(pFieldName)<>nil
    then Result:=pTable.FieldByName(pFieldName).AsInteger
    else oFld.Add(pFieldName);
end;

function TStk.FldDoub (pFieldName:Str20;pTable:TNexBtrTable):double;
begin
  Result:=0;
  If pTable.FindField(pFieldName)<>nil
    then Result:=pTable.FieldByName(pFieldName).AsFloat
    else oFld.Add(pFieldName);
end;

function TStk.FldDate (pFieldName:Str20;pTable:TNexBtrTable):TDateTime;
begin
  Result:=0;
  If pTable.FindField(pFieldName)<>nil
    then Result:=pTable.FieldByName(pFieldName).AsDateTime
    else oFld.Add(pFieldName);
end;

procedure TStk.SetStkNum(pStkNum:word); // Otvori skladove subory na zadany sklad
var mFind:boolean;  mCnt:word;
begin
  mFind:=FALSE;
  If oStk.Count>0 then begin
    mCnt:=0;
    Repeat
      Activate(mCnt);
      mFind:=ohSTK.BtrTable.ListNum=pStkNum;
      Inc (mCnt);
    until mFind or (mCnt=oStk.Count);
  end;
  If not mFind then begin // Ak dana kniha este nie je otvorena potomotvorime
    If oPath='' then ohSTK:=TStkHnd.Create else ohSTK:=TStkHnd.Create(oPath);
    If oPath='' then ohFIF:=TFifHnd.Create else ohFIF:=TFifHnd.Create(oPath);
    If oPath='' then ohSTM:=TStmHnd.Create else ohSTM:=TStmHnd.Create(oPath);
    If oPath='' then ohSTB:=TStbHnd.Create else ohSTB:=TStbHnd.Create(oPath);
//    If oPath='' then ohSTO:=TStoHnd.Create else ohSTO:=TStoHnd.Create(oPath);
    If oPath='' then ohSTS:=TStsHnd.Create else ohSTS:=TStsHnd.Create(oPath);
    ohSTK.Open(pStkNum);   oStk.Add(ohSTK);
    ohFIF.Open(pStkNum);   oFif.Add(ohFIF);
    ohSTM.Open(pStkNum);   oStm.Add(ohSTM);
    ohSTB.Open(pStkNum);   oStb.Add(ohSTB);
//    ohSTO.Open(pStkNum);   oSto.Add(ohSTO);
    ohSTS.Open(pStkNum);   oSts.Add(ohSTS);
  end;
end;

procedure TStk.AddToFif;  // Prida príjem do FIFO kariet
var mFifNum:longint;
begin
  If oGsc.AcqSta='' then oGsc.AcqSta:='R';
  mFifNum:=ohFIF.NextFifNum;
  ohFIF.Insert;
  ohFIF.FifNum:=mFifNum;
  ohFIF.DocNum:=oGsc.DocNum;
  ohFIF.ItmNum:=oGsc.ItmNum;
  ohFIF.GsCode:=oGsc.GsCode;
  ohFIF.DocDate:=oGsc.DocDate;
  ohFIF.DrbDate:=oGsc.DrbDate;
  ohFIF.RbaDate:=oGsc.RbaDate;
  ohFIF.RbaCode:=oGsc.RbaCode;
  ohFIF.InPrice:=oGsc.CPrice;
  ohFIF.InQnt:=oGsc.GsQnt;
  ohFIF.OutQnt:=0;
  ohFIF.ActQnt:=oGsc.GsQnt;
  ohFIF.PaCode:=oGsc.PaCode;
  ohFIF.AcqStat:=oGsc.AcqSta;
  ohFIF.RbaCode:=oGsc.RbaCode;
  ohFIF.RbaDate:=oGsc.RbaDate;
  ohFIF.Status:='A';
  ohFIF.Post;
  oFifLst.Clear;
  oFifLst.Add(mFifNum,oGsc.GsQnt,oGsc.CPrice,oGsc.PaCode,oGsc.AcqSta,oGsc.RbaDate,oGsc.RbaCode,ohFIF.ActPos);
end;

procedure TStk.OutFrFif;  // Vydá z príslušnej fifo karty
var I:word;
begin
  oGsc.CValue:=0;
  For I:=1 to oFifLst.FifCnt do begin
    ohFIF.GotoPos(oFifLst.ActPos[I]);
    If ohFIF.GsCode=oGsc.GsCode then begin // Je to spravny tovar
      If (ohFIF.FifNum=oFifLst.FifNum[I]) then begin
        ohFIF.Edit;
        ohFIF.OutQnt:=ohFIF.OutQnt+oFifLst.OutQnt[I];
        ohFIF.Post;
        oGsc.CValue:=oGsc.CValue+(ohFIF.InPrice*oFifLst.OutQnt[I]);
      end
      else ; // LOG - Nespravna FIFO karta - asi porušeni databáze
    end
    else ; // LOG - Chybny index na PLU vo FIF
  end;
  oGsc.CValue:=RoundCValue(oGsc.CValue);
end;

procedure TStk.AddToStm;  // Prida novy skladovy pohyb prijmu alebo výdaja
var I:word; mStmNum:longint;
begin
  For I:=1 to oFifLst.FifCnt do begin
    mStmNum:=ohSTM.NextStmNum;
    ohSTM.Insert;
    ohSTM.StmNum:=mStmNum;
    ohSTM.FifNum:=oFifLst.FifNum[I];
    ohSTM.DocNum:=oGsc.DocNum;
    ohSTM.ItmNum:=oGsc.ItmNum;
    ohSTM.GsCode:=oGsc.GsCode;
    ohSTM.MgCode:=oGsc.MgCode;
    ohSTM.GsName:=oGsc.GsName;
    ohSTM.DocDate:=oGsc.DocDate;
    ohSTM.SmCode:=oGsc.SmCode;
    If oGsc.SmSign='+'
      then ohSTM.GsQnt:=oFifLst.OutQnt[I]
      else ohSTM.GsQnt:=oFifLst.OutQnt[I]*(-1);
    ohSTM.CValue:=RoundCValue(oFifLst.CPrice[I]*ohSTM.GsQnt);
    ohSTM.BValue:=Rd2(oGsc.BPrice*ohSTM.GsQnt);
    ohSTM.OcdNum:=oGsc.OcdNum;
    ohSTM.OcdItm:=oGsc.OcdItm;
    ohSTM.PaCode:=oGsc.PaCode;
    ohSTM.ConStk:=oGsc.ConStk;
    If GetDocType(ohSTM.DocNum) in [dtTS,dtIM,dtRM] then ohSTM.SpaCode:=oFifLst.PaCode[I];
    ohSTM.AcqStat:=oFifLst.AcqSta[I];
    ohSTM.Post;
  end;
end;

procedure TStk.ClcToStk;  // Pripocita pohyb na skladovu kartu zasob
var mStr:Str8;
begin
  If ohSTK.LocateGsCode(oGsc.GsCode) then begin
    If ohSTK.GsCode=oGsc.GsCode then begin // Bezpeènostná kontrola èí sme našli správny tovar
      ohSTK.Edit;
      If oGsc.SmSign='+' then begin // Prijem
        ohSTK.InQnt:=ohSTK.InQnt+oGsc.GsQnt;
        ohSTK.InVal:=ohSTK.InVal+oGsc.CValue;
        ohSTK.LastPrice:=oGsc.CPrice;
        If Rd2(ohSTK.ActQnt)>0
          then ohSTK.AvgPrice:=Rd2(ohSTK.ActVal/ohSTK.ActQnt)
          else ohSTK.AvgPrice:=ohSTK.LastPrice;
        ohSTK.LastIDate:=oGsc.DocDate;
        ohSTK.LastIQnt:=oGsc.GsQnt;
        // Treba to len v pripade dodacieho listu - len ked je to prijem od dodavetela
        If (oGsc.PaCode>0) and (oGsc.GsQnt>0) and  (GetDocType(oGsc.DocNum)=dtTS) then ohSTK.LinPac:=oGsc.PaCode;
      end
      else begin  // Vydaj
        If LongInInt(oGsc.SmCode,cSalSmCodes) then mStr:='SaQnt' else mStr:='OuQnt';
        If oGsc.DocDate>=gvSys.FirstActYearDate then mStr:='A'+mStr else mStr:='P'+mStr;
        If ohSTK.BtrTable.FindField(mStr)<>NIL
          then ohSTK.BtrTable.FieldByName (mStr).AsFloat:=ohSTK.BtrTable.FieldByName (mStr).AsFloat+oGsc.GsQnt;
        ohSTK.OutQnt:=ohSTK.OutQnt+oGsc.GsQnt;
        ohSTK.OutVal:=ohSTK.OutVal+oGsc.CValue;
        If Rd2(ohSTK.ActQnt)>0
          then ohSTK.AvgPrice:=Rd2(ohSTK.ActVal/ohSTK.ActQnt)
          else ohSTK.AvgPrice:=ohSTK.LastPrice;
        ohSTK.LastODate:=oGsc.DocDate;
        ohSTK.LastOQnt:=oGsc.GsQnt;
      end;
      ohSTK.Post;
    end
    else ; // LOG - Chybny index na skladovej karte
  end
  else begin  // Neexistuje karta
    If oGsc.SmSign='+' then begin
      If not ohGSCAT.Active then ohGSCAT.Open;
      If ohGSCAT.LocateGsCode(oGsc.GsCode) then begin
        ohSTK.Insert;
        BTR_To_BTR (ohGSCAT.BtrTable,ohSTK.BtrTable);
        ohSTK.InQnt:=ohSTK.InQnt+oGsc.GsQnt;
        ohSTK.InVal:=ohSTK.InVal+Rd2(oGsc.GsQnt*oGsc.CPrice);
        ohSTK.LastPrice:=oGsc.CPrice;
        If Rd3(ohSTK.ActQnt)>0
          then ohSTK.AvgPrice:=Rd2(ohSTK.ActVal/ohSTK.ActQnt)
          else ohSTK.AvgPrice:=ohSTK.LastPrice;
        ohSTK.LastIDate:=oGsc.DocDate;
        ohSTK.LastIQnt:=oGsc.GsQnt;
        // Treba to len v pripade dodacieho listu - len ked je to prijem od dodavetela
        If (oGsc.PaCode>0) and (oGsc.GsQnt>0) and  (GetDocType(oGsc.DocNum)=dtTS) then ohSTK.LinPac:=oGsc.PaCode;
        If LongInInt(oGsc.SmCode,cSalSmCodes) then mStr:='SaQnt' else mStr:='OuQnt';
        If oGsc.DocDate>=gvSys.FirstActYearDate then mStr:='A'+mStr else mStr:='P'+mStr;
        If ohSTK.BtrTable.FindField(mStr)<>NIL
          then ohSTK.BtrTable.FieldByName (mStr).AsFloat:=ohSTK.BtrTable.FieldByName (mStr).AsFloat+oGsc.GsQnt;
        ohSTK.Post;
      end
      else ; // LOG - Tovar nema evidencnu kartu
    end
  end;
end;

// ********************************** PUBLIC ***********************************

procedure TStk.Open(pStkNum:word);
begin
  StkNum:=pStkNum;
end;

procedure TStk.Clear; // Vynuluje premenne a nastavi objekt na zadavanie novej polozky
begin
  oFld.Clear;
  FillChar (oGsc,SizeOf(TGscDat),#0);
end;

procedure TStk.Activate(pIndex:word); // Aktivuje databazu, ktora je otvorena pod poradovym cislom pIndex
begin
  ohSTK:=oStk.Items[pIndex];
  ohFIF:=oFif.Items[pIndex];
  ohSTM:=oStm.Items[pIndex];
  ohSTB:=oStb.Items[pIndex];
//  ohSTO:=oSto.Items[pIndex];
  ohSTS:=oSts.Items[pIndex];
end;

procedure TStk.Dat(pTable:TNexBtrTable); // Zapiše do bufferu údaje tovaru zo zadanej databáze, na ktorý bude vytvorený príjem alebo výdaj
var mDocType:byte;
begin
  Clear;
  With oGsc do begin
    GsCode:=FldLong ('GsCode',pTable);
    MgCode:=FldLong ('MgCode',pTable);
    GsName:=FldText ('GsName',pTable);
    BarCode:=FldText ('BarCode',pTable);
    StkCode:=FldText ('StkCode',pTable);
    VatPrc:=FldLong ('VatPrc',pTable);
    MsName:=FldText ('MsName',pTable);
    DocNum:=FldText ('DocNum',pTable);
    ItmNum:=FldLong ('ItmNum',pTable);
    DocDate:=FldDate ('DocDate',pTable);
    DrbDate:=FldDate ('DrbDate',pTable);
    RbaDate:=FldDate ('RbaDate',pTable);
    RbaCode:=FldText ('RbaCode',pTable);
    GsQnt:=FldDoub ('GsQnt',pTable);
    BPrice:=FldDoub ('BPrice',pTable);
    OcdNum:=FldText ('OcdNum',pTable);
    OcdItm:=FldLong ('OcdItm',pTable);
    PaCode:=FldLong ('PaCode',pTable);
    SmCode:=FldLong ('SmCode',pTable);
    AcqSta:=FldText ('AcqStat',pTable);
    ConStk:=FldLong ('ConStk',pTable);
    // Pre jednopohybové doklady nastavíme znak skladového pohybu
    mDocType:=GetDocType(DocNum);
    If mDocType in [dtTS,dtIM] then begin // Príjmové skladové doklady
      If GsQnt>0
        then SmSign:='+'
        else SmSign:='-';
    end;
    If mDocType in [dtTC,dtOM,dtSA] then begin // Výdajové skladové doklady
      If GsQnt>0
        then SmSign:='-'
        else SmSign:='+';
    end;
  end;
end;

procedure TStk.Clc(pGsCode:longint;pStm,pSts,pOcd,pOsd,pImd:boolean); // Prepocita skladovu kartu zo zadanych zdrojov
var mSalQnt,mOcdQnt,mOsdQnt,mOsrQnt,mNrsQnt,mImrQnt:double;
begin
  If ohSTK.LocateGsCode(pGsCode) then begin
    mSalQnt:=0;  mOcdQnt:=0;  mOsdQnt:=0; mOsrQnt:=0; mNrsQnt:=0; mImrQnt:=0;
    If pSts then begin // prepocitame rezervacie na predaj
      If ohSTS.LocateGsCode(pGsCode) then begin
        Repeat
          mSalQnt:=mSalQnt+ohSTS.SalQnt;
          ohSTS.Next;
        until ohSTS.Eof or (ohSTS.GsCode<>pGsCode);
        Application.ProcessMessages;
      end;
    end else mSalQnt:=ohSTK.SalQnt;
    mOcdQnt:=ohSTK.OcdQnt;
    mOsdQnt:=ohSTK.OsdQnt;
    mOsrQnt:=ohSTK.OsrQnt;
    mNrsQnt:=ohSTK.NrsQnt;
    mImrQnt:=ohSTK.ImrQnt;

//    If pOcd then mOcdQnt:=ohSTO.OcdQnt(pGsCode); // Prepocitame rezervacie na zakazky
//    If pOsd then mOsdQnt:=ohSTO.OsdQnt(pGsCode); // Prepocitame objednavky
//    If pOsd then mOsrQnt:=ohSTO.OsrQnt(pGsCode); // Prepocitame rezervacie z objednavky
//    If pOcd then mNrsQnt:=ohSTO.NrsQnt(pGsCode); // Prepocitame poziadavky
//    If pImd then mImrQnt:=ohSTO.ImrQnt(pGsCode); // Prepocitame poziadavky
//    If pOsd then mOsrQnt:=ohSTO.OsrQnt(pGsCode); // Prepocitame rezervacie z objednavky
    // Ulozime vypocitane udaje na skladovu kartu
    If (ohSTK.SalQnt<>mSalQnt) or (ohSTK.OcdQnt<>mOcdQnt) or (ohSTK.OsdQnt<>mOsdQnt)
    or (ohSTK.OsrQnt<>mOsrQnt) or (ohSTK.NrsQnt<>mNrsQnt) or (ohSTK.ImrQnt<>mImrQnt) then begin
      ohSTK.Edit;
      If pSts then ohSTK.SalQnt:=mSalQnt;
      If pOcd then ohSTK.OcdQnt:=mOcdQnt;
      If pOsd then ohSTK.OsdQnt:=mOsdQnt;

      If pOsd then ohSTK.OsrQnt:=mOsrQnt;
      If pOcd then ohSTK.NrsQnt:=mNrsQnt;
      If pImd then ohSTK.ImrQnt:=mImrQnt;
      ohSTK.Post;
    end;
  end;
end;

procedure TStk.Del(pTbl:Str3;pDocNum:Str12;pItmNum:longint);
var mGsCode:longint;
begin
  If pTbl='STS' then begin
    If not ohSTS.Active then ohSTS.Open(ohSTK.BtrTable.ListNum);
    If ohSTS.LocateDoIt(pDocNum,pItmNum) then begin
      mGsCode:=ohSTS.GsCode;
      ohSTS.Delete;
      Clc(mGsCode,FALSE,TRUE,FALSE,FALSE,FALSE); // Prepocita skladovu kartu zo zadanych zdrojov
    end;
  end;
(*
  If pTbl='STO' then begin
    If ohSTO.LocateDoIt(pDocNum,pItmNum) then begin
      mGsCode:=ohSTO.GsCode;
      ohSTO.Delete;
      Clc(mGsCode,FALSE,FALSE,TRUE,TRUE,TRUE); // Prepocita skladovu kartu zo zadanych zdrojov
    end;
  end;
*)  
end;

procedure TStk.Ren(pSrcDoc:Str12;pSrcItm:longint;pTrgDoc:Str12;pTrgItm:longint); // Zmeni cislo dokladu zadanej polozky na pTrgNum
begin
  While ohSTM.LocateDoIt(pSrcDoc,pSrcItm) do begin
    ohSTM.Edit;
    ohSTM.DocNum:=pTrgDoc;
    ohSTM.ItmNum:=pTrgItm;
    ohSTM.DocDate:=Date;
    ohSTM.Post;
  end;
  While ohFIF.LocateDoIt(pSrcDoc,pSrcItm) do begin
    ohFIF.Edit;
    ohFIF.DocNum:=pTrgDoc;
    ohFIF.ItmNum:=pTrgItm;
    ohFIF.DocDate:=Date;
    ohFIF.Post;
  end;
end;
(*
procedure TStk.Dlv(pStkNum:word;pDocNum:Str12;pItmNum:word;pDlvQnt:double;pDlvDate:TDateTime); // Oznaco na skladovej karte ze tovar bol dodany
var mOsrQnt,mOcdQnt,mNrsQnt,mImrQnt:double;
begin
  StkNum:=pStkNum;
  If ohSTO.LocateDoIt(pDocNum,pItmNum) then begin
    ohSTO.Edit;
    ohSTO.DlvQnt:=pDlvQnt;
    ohSTO.DlvDate:=pDlvDate;
    ohSTO.Post;
  end;
  // Prepocitame kumultivne hodnoty na skladovej karte
  If ohSTK.LocateGsCode(ohSTO.GsCode) then begin
    mOsrQnt:=ohSTO.OsrQnt(ohSTO.GsCode);
    mOcdQnt:=ohSTO.OcdQnt(ohSTO.GsCode);
    mNrsQnt:=ohSTO.NrsQnt(ohSTO.GsCode);
    mImrQnt:=ohSTO.ImrQnt(ohSTO.GsCode);
    ohSTK.Edit;
    ohSTK.OsrQnt:=mOsrQnt;
    ohSTK.OcdQnt:=mOcdQnt;
    ohSTK.NrsQnt:=mNrsQnt;
    ohSTK.ImrQnt:=mImrQnt;
    ohSTK.Post;
  end;
end;
*)
procedure TStk.Sts(pStkNum:word;pDocNum:Str12;pItmNum:word;pGsCode:longint;pSalQnt:double;pSalDate:TDateTime); // Zalozi rezervaciu na predaj, ak mnozstvo je 0 zrusi rezervaciu
begin
  StkNum:=pStkNum;
  If not ohSTS.Active then ohSTS.Open(ohSTK.BtrTable.ListNum);
  If ohSTS.LocateDoIt(pDocNum,pItmNum) then begin
    If IsNotNul(pSalQnt) then begin
      ohSTS.Edit;
      ohSTS.GsCode:=pGsCode;
      ohSTS.SalQnt:=pSalQnt;
      ohSTS.SalDate:=pSalDate;
      ohSTS.Post;
    end
    else ohSTS.Delete;
  end
  else begin
    If IsNotNul(pSalQnt) then begin
      ohSTS.Insert;
      ohSTS.DocNum:=pDocNum;
      ohSTS.ItmNum:=pItmNum;
      ohSTS.GsCode:=pGsCode;
      ohSTS.SalQnt:=pSalQnt;
      ohSTS.SalDate:=pSalDate;
      ohSTS.Post;
    end;
  end;
  Clc(pGsCode,FALSE,TRUE,FALSE,FALSE,FALSE); // Prepocita skladovu kartu zo zadanych zdrojov
end;

procedure TStk.StsCad(pStkNum:word;pDocNum:Str12;pItmNum:word;pGsCode:Integer;pSalQnt:double;pSalDate:TDateTime;pCasNum:integer);
begin
  StkNum:=pStkNum;
  If not ohSTS.Active then ohSTS.Open(ohSTK.BtrTable.ListNum);
  If ohSTS.LocateGcSdCn(pGsCode,pSalDate,pCasNum) then begin
    If IsNotNul(pSalQnt) then begin
      ohSTS.Edit;
      ohSTS.SalQnt:=ohSTS.SalQnt+pSalQnt;
      ohSTS.Post;
    end
    else ohSTS.Delete;
  end
  else begin
    If IsNotNul(pSalQnt) then begin
      ohSTS.Insert;
      ohSTS.CasNum:=pCasNum;
      ohSTS.DocNum:=pDocNum;
      ohSTS.ItmNum:=pItmNum;
      ohSTS.GsCode:=pGsCode;
      ohSTS.SalQnt:=pSalQnt;
      ohSTS.SalDate:=pSalDate;
      ohSTS.Post;
    end;
  end;
  Clc(pGsCode,FALSE,TRUE,FALSE,FALSE,FALSE); // Prepocita skladovu kartu zo zadanych zdrojov
end;

procedure TStk.AddStc(pGsCode:longint); // Prida novu skladovu kartu do STK
begin
  If not ohGSCAT.Active then ohGSCAT.Open;
  If ohGSCAT.LocateGsCode(pGsCode) then begin
    ohSTK.Insert;
    BTR_To_BTR (ohGSCAT.BtrTable,ohSTK.BtrTable);
    ohSTK.Post;
  end;
end;

procedure TStk.ClcStc(pGsCode:longint); // Prepocita skladovukartu podla pohybov
var mASaQnt,mPSaQnt,mAOuQnt,mPOuQnt,mBegQnt,mBegVal,mInQnt,mInVal,mOutQnt,mOutVal:double;
begin
  If ohSTK.LocateGsCode(pGsCode) then begin
    If ohSTM.LocateGsCode(pGsCode) then begin
      mASaQnt:=0; mPSaQnt:=0; mAOuQnt:=0; mPOuQnt:=0;
      mBegQnt:=0;  mInQnt:=0;  mOutQnt:=0;
      mBegVal:=0;  mInVal:=0;  mOutVal:=0;
      Repeat
        If StmIsBegMov(ohSTM.BtrTable) then begin // Pociatocny stav
          mBegQnt:=mBegQnt+ohSTM.GsQnt;
          mBegVal:=mBegVal+ohSTM.CValue;
        end
        else begin
          If ohSTM.GsQnt>0 then begin
            mInQnt:=mInQnt+ohSTM.GsQnt;
            mInVal:=mInVal+ohSTM.CValue;
          end
          else begin
            mOutQnt:=mOutQnt+Abs(ohSTM.GsQnt);
            mOutVal:=mOutVal+Abs(ohSTM.CValue);
            If LongInInt(ohSTM.SmCode,cSalSmCodes) then begin
              If ohSTM.DocDate>=gvSys.FirstActYearDate
                then mASaQnt:=mASaQnt-ohSTM.GsQnt
                else mPSaQnt:=mPSaQnt-ohSTM.GsQnt;
            end else begin
              If ohSTM.DocDate>=gvSys.FirstActYearDate
                then mAOuQnt:=mAOuQnt-ohSTM.GsQnt
                else mPOuQnt:=mPOuQnt-ohSTM.GsQnt;
            end;
          end;
        end;
        ohSTM.Next;
      until (ohSTM.Eof) or (ohSTM.GsCode<>pGsCode);
      ohSTK.Edit;
      ohSTK.BegQnt:=mBegQnt;
      ohSTK.BegVal:=mBegVal;
      ohSTK.InQnt :=mInQnt;
      ohSTK.OutQnt:=mOutQnt;
      ohSTK.InVal :=mInVal;
      ohSTK.OutVal:=mOutVal;
      ohSTK.ASaQnt:=mASaQnt;
      ohSTK.AOuQnt:=mAOuQnt;
      ohSTK.PSaQnt:=mPSaQnt;
      ohSTK.POuQnt:=mPOuQnt;
      ohSTK.Post;
    end else begin
      ohSTK.Edit;
      ohSTK.BegQnt:=0;
      ohSTK.BegVal:=0;
      ohSTK.InQnt :=0;
      ohSTK.OutQnt:=0;
      ohSTK.InVal :=0;
      ohSTK.OutVal:=0;
      ohSTK.ASaQnt:=0;
      ohSTK.AOuQnt:=0;
      ohSTK.PSaQnt:=0;
      ohSTK.POuQnt:=0;
      ohSTK.Post;
    end;
  end;
end;
(*
procedure TStk.AddSto(phIMI:TImiHnd);
var mImrQnt:double;
begin
  If phIMI.StkNum>0 then begin
    StkNum:=phIMI.StkNum;
    If not ohSTO.LocateDoIt(phIMI.DocNum,phIMI.ItmNum) then begin
      ohSTO.Insert;
      BTR_To_BTR (phIMI.BtrTable,ohSTO.BtrTable);
      ohSTO.OrdType:='M';
//      ohSTO.StkStat:='M';
      ohSTO.OrdQnt:=phIMI.GsQnt;
      If phIMI.StkStat<>'S' then ohSTO.DlvQnt:=0 else ohSTO.DlvQnt:=ohSTO.OrdQnt;
      ohSTO.Post;
      // Prepocitame kumultivne hodnoty na skladovej karte
      If ohSTK.LocateGsCode(phIMI.GsCode) then begin
        mImrQnt:=ohSTO.ImrQnt(phIMI.GsCode);
        ohSTK.Edit;
        ohSTK.ImrQnt:=mImrQnt;
        ohSTK.Post;
      end;
    end;
  end;
end;

procedure TStk.AddSto(phOSI:TOsiHnd);
var mOsdQnt:double;
begin
  If phOSI.StkNum>0 then begin
    StkNum:=phOSI.StkNum;
    If not ohSTO.LocateDoIt(phOSI.DocNum,phOSI.ItmNum) then begin
      ohSTO.Insert;
      BTR_To_BTR (phOSI.BtrTable,ohSTO.BtrTable);
      ohSTO.OrdType:='S';
      ohSTO.StkStat:='O';
      ohSTO.Post;
      // Prepocitame kumultivne hodnoty na skladovej karte
      If ohSTK.LocateGsCode(phOSI.GsCode) then begin
        mOsdQnt:=ohSTO.OsdQnt(phOSI.GsCode);
        ohSTK.Edit;
        ohSTK.OsdQnt:=mOsdQnt;
        ohSTK.Post;
      end;
    end;
  end;
end;

function TStk.AddSto(phOCI:TOciHnd):Str1; // Vyhotovi rezervaciu na zadany riadok zakazky
var mOsrQnt,mOcdQnt,mNrsQnt,mImrQnt:double;  mStkStat:Str1;
begin
  mStkStat:='N';
  StkNum:=phOCI.StkNum;
  If not ohSTK.LocateGsCode(phOCI.GsCode) then AddStc(phOCI.GsCode); // Prida novu skladovu kartu do STK
  If ohSTK.FreQnt>=phOCI.OrdQnt then mStkStat:='R';
  If not ohSTO.LocateDoIt(phOCI.DocNum,phOCI.ItmNum) then begin
    ohSTO.Insert; // Neexistuje zaznam k danej polozke zakazke preto zalozime
    BTR_To_BTR (phOCI.BtrTable,ohSTO.BtrTable);
    ohSTO.OrdType:='C';
    ohSTO.StkStat:=mStkStat;
    ohSTO.Post;
    // Priznak zapiseme aj do polozky zakazky
    phOCI.Edit;
    phOCI.StkStat:=mStkStat;
    phOCI.Post;
  end;
  // Prepocitame kumultivne hodnoty na skladovej karte
  If ohSTK.LocateGsCode(phOCI.GsCode) then begin
    mOcdQnt:=ohSTO.OcdQnt(phOCI.GsCode);
    mOsrQnt:=ohSTO.OsrQnt(ohSTO.GsCode);
    mNrsQnt:=ohSTO.NrsQnt(phOCI.GsCode);
    mImrQnt:=ohSTO.ImrQnt(phOCI.GsCode);
    ohSTK.Edit;
    ohSTK.OsrQnt:=mOsrQnt;
    ohSTK.OcdQnt:=mOcdQnt;
    ohSTK.NrsQnt:=mNrsQnt;
    ohSTK.ImrQnt:=mImrQnt;
    ohSTK.Post;
  end;
  Result:=mStkStat;
end;

procedure TStk.DelSto(pDocNum:Str12;pItmNum:longint); // Vyhotovi rezervaciu na zadany riadok zakazky
var mGsCode:longint;
begin
  If ohSTO.LocateDoIt(pDocNum,pItmNum) then begin
    mGsCode:=ohSTO.GsCode;
    ohSTO.Delete; // Neexistuje zaznam k danej polozke zakazke preto zalozime
    If ohSTK.LocateGsCode(mGsCode) then begin
      ohSTK.Edit;
      ohSTK.OsdQnt:=ohSTO.OsdQnt(mGsCode);
      ohSTK.OsrQnt:=ohSTO.OsrQnt(mGsCode);
      ohSTK.NrsQnt:=ohSTO.NrsQnt(mGsCode);
      ohSTK.ImrQnt:=ohSTO.ImrQnt(mGsCode);
      ohSTK.OcdQnt:=ohSTO.OcdQnt(mGsCode); // Prepocitame rezervacie na zakazky
      ohSTK.Post;
    end;
  end;
end;

procedure TStk.StoRef(phOCI:TOciHnd);  // Odpise rezervaciu zo zadaneho dokladu
var mOsrQnt,mOcdQnt,mNrsQnt,mImrQnt:double;
begin
  StkNum:=phOCI.StkNum;
  If ohSTO.LocateDoIt(phOCI.DocNum,phOCI.ItmNum)
    then ohSTO.Edit   // Nasli sme zaznam k danej polozke zakazke
    else ohSTO.Insert; // Neexistuje zaznam k danej polozke zakazke preto zalozime
  BTR_To_BTR (phOCI.BtrTable,ohSTO.BtrTable);
  ohSTO.OrdType:='C';
  ohSTO.Post;
  // Prepocitame kumultivne hodnoty na skladovej karte
  If ohSTK.LocateGsCode(phOCI.GsCode) then begin
    mOsrQnt:=ohSTO.OsrQnt(phOCI.GsCode);
    mOcdQnt:=ohSTO.OcdQnt(phOCI.GsCode);
    mNrsQnt:=ohSTO.NrsQnt(phOCI.GsCode);
    mImrQnt:=ohSTO.ImrQnt(phOCI.GsCode);
    ohSTK.Edit;
    ohSTK.OcdQnt:=mOcdQnt;
    ohSTK.OsrQnt:=mOsrQnt;
    ohSTK.NrsQnt:=mNrsQnt;
    ohSTK.ImrQnt:=mImrQnt;
    ohSTK.Post;
  end;
end;

procedure TStk.StoRef(phIMI:TImiHnd);
var mImrQnt:double;
begin
  StkNum:=phIMI.StkNum;
  If ohSTO.LocateDoIt(phIMI.DocNum,phIMI.ItmNum)
    then ohSTO.Edit   // Nasli sme zaznam k danej polozke zakazke
    else ohSTO.Insert; // Neexistuje zaznam k danej polozke zakazke preto zalozime
  BTR_To_BTR (phIMI.BtrTable,ohSTO.BtrTable);
  ohSTO.OrdQnt:=phIMI.GsQnt;
  If phIMI.StkStat<>'S' then ohSTO.DlvQnt:=0 else ohSTO.DlvQnt:=ohSTO.OrdQnt;
  ohSTO.Post;
  // Prepocitame kumultivne hodnoty na skladovej karte
  If ohSTK.LocateGsCode(phIMI.GsCode) then begin
    mImrQnt:=ohSTO.ImrQnt(phIMI.GsCode);
    ohSTK.Edit;
    ohSTK.ImrQnt:=mImrQnt;
    ohSTK.Post;
  end;
end;

procedure TStk.StoRef(phOSI:TOsiHnd);
var mOsdQnt:double;
begin
  StkNum:=phOSI.StkNum;
  If ohSTO.LocateDoIt(phOSI.DocNum,phOSI.ItmNum)
    then ohSTO.Edit   // Nasli sme zaznam k danej polozke zakazke
    else ohSTO.Insert; // Neexistuje zaznam k danej polozke zakazke preto zalozime
  BTR_To_BTR (phOSI.BtrTable,ohSTO.BtrTable);
  ohSTO.Post;
  // Prepocitame kumultivne hodnoty na skladovej karte
  If ohSTK.LocateGsCode(phOSI.GsCode) then begin
    mOsdQnt:=ohSTO.OsdQnt(phOSI.GsCode);
    ohSTK.Edit;
    ohSTK.OsdQnt:=mOsdQnt;
    ohSTK.Post;
  end;
end;
*)
function TStk.Sub(pStkNum:word):boolean; // Vykoná príjem alebo výdaj tovaru zo skladu
begin
  Result:=FALSE;
  If (oGsc.GsQnt<0)then begin // Zmena typu ak je zaporne mnozstvo
    oGsc.GsQnt:=0-oGsc.GsQnt;
    oGsc.CValue:=0-oGsc.CValue;
    If oGsc.SmSign='+'
      then oGsc.SmSign:='-'
      else oGsc.SmSign:='+';
  end;
  If pStkNum>0 then begin
    StkNum:=pStkNum;  // Otvori skladove subori na zadany sklad
    If oGsc.SmSign='+' then begin // Prijem tovaru na sklad
      Result:=TRUE;
      If IsNul(oGsc.CValue) then oGsc.CValue:=oGsc.CPrice*oGsc.GsQnt;
      AddToFif;  // Prida príjem do FIFO kariet
      AddToStm;  // Prida novy skladovy pohyb prijmu alebo výdaja
      ClcToStk;  // Pripocita pohyb na skladovu kartu zasob
    end
    else begin
      If oGsc.SmSign='-' then begin // Vydaj tovaru zo skladu
        If ohSTK.LocateGsCode(oGsc.GsCode) then begin // Ak existuje skladova karta
          If Rd3(ohSTK.FreQnt)>=Rd3(oGsc.GsQnt) then begin // Mame dost tovaru na skladovej karte
//          If Rd3(ohSTK.ActQnt)>=Rd3(oGsc.GsQnt) then begin // Mame dost tovaru na skladovej karte
            oFifLst.Run(oGsc.GsCode,oGsc.GsQnt,ohFIF);
            If Rd3(oFifLst.SumQnt)>=Rd3(oGsc.GsQnt) then begin // Mame dost tovaru aj podla FIFO kariet
              Result:=TRUE;
              OutFrFif;  // Vydá z príslušnej fifo karty
              AddToStm;  // Prida novy skladovy pohyb prijmu alebo výdaja
              ClcToStk;  // Pripocita pohyb na skladovu kartu zasob
            end;
          end;
        end
        else ; // LOG
      end
      else ; // LOG
    end;
  end
  else ; // LOG
end;

function TStk.Uns(pStkNum:word;pDocNum:Str12;pItmNum:longint):boolean; // Stornuje skladovu operaciu danej polozky
var mLog:TStrings; mStr:Str8;
begin
  Result:=TRUE;
  StkNum:=pStkNum;  // Otvori skladove subori na zadany sklad
  If ohSTM.LocateDoIt(pDocNum,pItmNum) then begin
    If ohSTM.GsQnt>0 then begin // Storno prijmu
      If ohFIF.LocateFifNum(ohSTM.FifNum) then begin
        If IsNul(ohFIF.OutQnt) then begin // FIFO karta este nebola pouzita
          ohFIF.Delete; // Zrusime FIFO kartu
          If ohSTK.LocateGsCode(ohSTM.GsCode) then begin // Znizime prijate mnozstvo a hodnotu na skladovej karte
            ohSTK.Edit;
            ohSTK.InQnt:=ohSTK.InQnt-ohSTM.GsQnt;
            ohSTK.InVal:=ohSTK.InVal-ohSTM.CValue;
            ohSTK.Post;
          end;
          ohSTM.Delete; // Zrusime skladovy pohyb
        end
        else Result:=FALSE;
      end
      else begin  // Chyba - neexistujuca FIFO karta
        mLog:=TStringList.Create;
        If FileExists (gPath.SysPath+'STKERR.LOG') then mLog.LoadFromFile(gPath.SysPath+'STKERR.LOG');
        mLog.Add('Storno - neexistujuca FIFO karta '+StrInt(ohSTM.FifNum,6));
        mLog.SaveToFile(gPath.SysPath+'STKERR.LOG');
        FreeAndNil (mLog);
      end;
    end
    else begin // Storno vydaja
      While ohSTM.LocateDoIt(pDocNum,pItmNum) do begin
        If ohFIF.LocateFifNum(ohSTM.FifNum) then begin  // Znizime vydane mnozstvo FIFO t.j. pripocitame zaporne mnozstvo
          ohFIF.Edit;
          ohFIF.OutQnt:=ohFIF.OutQnt+ohSTM.GsQnt;
          ohFIF.Post;
        end;
        If ohSTK.LocateGsCode(ohSTM.GsCode) then begin // Znizime prijate mnozstvo a hodnotu na skladovej karte
          ohSTK.Edit;
          ohSTK.OutQnt:=ohSTK.OutQnt+ohSTM.GsQnt;
          ohSTK.OutVal:=ohSTK.OutVal+ohSTM.CValue;
          If LongInInt(oGsc.SmCode,cSalSmCodes) then mStr:='SaQnt' else mStr:='OuQnt';
          If oGsc.DocDate>=gvSys.FirstActYearDate then mStr:='A'+mStr else mStr:='P'+mStr;
          If ohSTK.BtrTable.FindField(mStr)<>NIL
            then ohSTK.BtrTable.FieldByName (mStr).AsFloat:=ohSTK.BtrTable.FieldByName (mStr).AsFloat+ohSTM.GsQnt;
          ohSTK.Post;
        end;
        ohSTM.Delete; // Zrusime skladovy pohyb
      end;
    end;
  end
  else begin // Chyba - neexistujuci skladovy pohyb
    mLog:=TStringList.Create;
    If FileExists (gPath.SysPath+'STKERR.LOG') then mLog.LoadFromFile(gPath.SysPath+'STKERR.LOG');
    mLog.Add('Storno - neexistujuci skladoy pohyb: '+pDocNum+' / '+StrInt(pItmNum,0));
    mLog.SaveToFile(gPath.SysPath+'STKERR.LOG');
    FreeAndNil (mLog);
  end;
end;

function TStk.GetOpenCount:word;
begin
  Result:=oStk.Count;
end;

procedure TStk.OutPdnClear(pDocNum: Str12; pItmNum,pStkNum: Integer);
var mhSTP:TStpHnd;
begin
  If oPath='' then mhSTP:=TStpHnd.Create else mhSTP:=TStpHnd.Create(oPath);
  mhSTP.Open(pStkNum);
  While mhSTP.LocateOutDoIt (pDocNum,pItmNum) do begin
    mhSTP.Edit;
    mhSTP.OutDocNum:='';
    mhSTP.OutItmNum:=0;
    mhSTP.OutDocDate:=0;
    mhSTP.Status:='A';
    mhSTP.Post;
  end;
  FreeAndNil(mhSTP);
end;

function TStk.GetFre(pStkNum: word; pGsCode: Integer): double;
begin
  StkNum:=pStkNum;
  If not ohSTK.LocateGsCode(pGsCode) then Result:=0 else Result:=ohSTK.FreQnt;
end;

function TStk.ClcStm(pDocNum: Str12; pItmNum: Integer): double;
begin
  Result:=0;
  If ohSTM.LocateDoIt(pDocNum,pItmNum) then begin
    Repeat
      Result:=Result+ohSTM.GsQnt;
      ohSTM.Next;
    until (ohSTM.Eof) or (ohSTM.DocNum<>pDocNum)or (ohSTM.ItmNum<>pItmNum);
  end;
end;

function TStk.SubMod(pStkNum: word): boolean;
var mQnt:double;
begin
  Result:=FALSE;
  If (oGsc.GsQnt<0)then begin // Zmena typu ak je zaporne mnozstvo
    oGsc.GsQnt:=0-oGsc.GsQnt;
    oGsc.CValue:=0-oGsc.CValue;
    If oGsc.SmSign='+'
      then oGsc.SmSign:='-'
      else oGsc.SmSign:='+';
  end;
  If pStkNum>0 then begin
    StkNum:=pStkNum;  // Otvori skladove subori na zadany sklad
    If oGsc.SmSign='+' then begin // Prijem tovaru na sklad
      mQnt:=ClcStm(oGsc.DocNum,oGsc.ItmNum);
      If mQnt+oGsc.GsQnt<0 then begin
        Result:=TRUE;
        If IsNul(oGsc.CValue) then oGsc.CValue:=oGsc.CPrice*oGsc.GsQnt;
        ModStm;    // Znizi vydane mnozstva z pohybov
        ClcToStk;  // Pripocita pohyb na skladovu kartu zasob
      end else begin
        Result:=TRUE;
        If IsNul(oGsc.CValue) then oGsc.CValue:=oGsc.CPrice*oGsc.GsQnt;
        AddToFif;  // Prida príjem do FIFO kariet
        AddToStm;  // Prida novy skladovy pohyb prijmu alebo výdaja
        ClcToStk;  // Pripocita pohyb na skladovu kartu zasob
      end;
    end
    else begin
      If oGsc.SmSign='-' then begin // Vydaj tovaru zo skladu
        If ohSTK.LocateGsCode(oGsc.GsCode) then begin // Ak existuje skladova karta
          If Rd3(ohSTK.FreQnt)>=Rd3(oGsc.GsQnt) then begin // Mame dost tovaru na skladovej karte
//          If Rd3(ohSTK.ActQnt)>=Rd3(oGsc.GsQnt) then begin // Mame dost tovaru na skladovej karte
            oFifLst.Run(oGsc.GsCode,oGsc.GsQnt,ohFIF);
            If Rd3(oFifLst.SumQnt)>=Rd3(oGsc.GsQnt) then begin // Mame dost tovaru aj podla FIFO kariet
              Result:=TRUE;
              OutFrFif;  // Vydá z príslušnej fifo karty
              AddToStm;  // Prida novy skladovy pohyb prijmu alebo výdaja
              ClcToStk;  // Pripocita pohyb na skladovu kartu zasob
            end;
          end;
        end
        else ; // LOG
      end
      else ; // LOG
    end;
  end
  else ; // LOG
end;

procedure TStk.ModFif;
begin

end;

procedure TStk.ModStm;
var mV,mQntSum,mQ:double;
begin
  mQntSum:=oGsc.GsQnt;
  If ohSTM.LocateDoIt(oGsc.DocNum,oGsc.ItmNum) then begin
    repeat
      If (ohSTM.GsQnt<0) then begin
        If Eq3(Abs(ohSTM.GsQnt),mQntSum) then begin
          mQ:=Abs(ohSTM.GsQnt);
          If ohFIF.LocateFifNum(ohSTM.FifNum) then begin  // Znizime vydane mnozstvo FIFO t.j. pripocitame zaporne mnozstvo
            ohFIF.Edit;
            ohFIF.OutQnt:=ohFIF.OutQnt-mQ;
            ohFIF.Post;
          end;
          ohSTM.Delete;
          mQntSum:=0;
        end else If Abs(ohSTM.GsQnt)<mQntSum then begin
          mQ:=Abs(ohSTM.GsQnt);
          If ohFIF.LocateFifNum(ohSTM.FifNum) then begin  // Znizime vydane mnozstvo FIFO t.j. pripocitame zaporne mnozstvo
            ohFIF.Edit;
            ohFIF.OutQnt:=ohFIF.OutQnt-mQ;
            ohFIF.Post;
          end;
          ohSTM.Delete;
          mQntSum:=mQntSum-mQ;
        end else begin
          mQ:=mQntSum;
          If ohFIF.LocateFifNum(ohSTM.FifNum) then begin  // Znizime vydane mnozstvo FIFO t.j. pripocitame zaporne mnozstvo
            ohFIF.Edit;
            ohFIF.OutQnt:=ohFIF.OutQnt-mQ;
            ohFIF.Post;
          end;
          mV:=ohSTM.CValue/ohSTM.GsQnt;
          ohSTM.Edit;
          ohSTM.GsQnt:=ohSTM.GsQnt + mQ;
          ohSTM.CValue:= ohSTM.GsQnt*mV;
          ohSTM.Post;
          mQntSum:=0;
        end;
      end else ohSTM.Next;
    until ohSTM.Eof or (mQntSum<=0);
  end;
end;
(*
function TStk.OcdOsdStoVer(pDocNum: Str12; pItmNum: Integer): STRING;
var mFreQnt:double;
begin
  Result:='';
  If ohSTO.LocateOdOi(pDocNum,pItmNum) and ohSTK.LocateGsCode(ohSTO.GsCode) then begin
    mFreQnt:=ohSTK.FreQnt;
    repeat
      If (ohSTO.StkStat='O') and (ohSTO.OrdQnt-ohSTO.DlvQnt>0) and (ohSTO.OrdQnt-ohSTO.DlvQnt<=mFreQnt) then begin
        Result:=Result+'|'+ohSTO.DocNum+','+IntToStr(ohSTO.ItmNum)+','+IntToStr(ohSTO.GsCode)+','+FloatToStr(ohSTO.OrdQnt-ohSTO.DlvQnt)+',+';
        mFreQnt:=mFreQnt-(ohSTO.OrdQnt-ohSTO.DlvQnt);
        // Reserve STO + OCI
      end else if (ohSTO.StkStat='O') and (ohSTO.OrdQnt-ohSTO.DlvQnt>0) then begin
        Result:=Result+'|'+ohSTO.DocNum+','+IntToStr(ohSTO.ItmNum)+','+IntToStr(ohSTO.GsCode)+','+FloatToStr(ohSTO.OrdQnt-ohSTO.DlvQnt)+',-';
      end;
      ohSTO.Next;
    until ohSTO.Eof or (ohSTO.OsdNum<>pDocNum) or (ohSTO.OsdItm<>pItmNum);
  end;
  If Result<>'' then Result:=copy(Result,2,12345);
end;
*)
procedure TStk.MyOut;
begin
  OutFrFif;  // Vydá z príslušnej fifo karty
  AddToStm;  // Prida novy skladovy pohyb prijmu alebo výdaja
  ClcToStk;  // Pripocita pohyb na skladovu kartu zasob
end;

function TStk.VerifyRba(pStkNum, pGsCode: Integer; pRbaCode: Str30;
  pQnt: Double; var pRbaQnt, pRbnQnt, pRboQnt: double;
  var pRbaDate: TDate): boolean;
begin
  pRbaDate:=0;
  StkNum:=pStkNum;
  pRbaQnt:=0;pRbnQnt:=0;pRboQnt:=0;
  ohFIF.LocateGsCode(pGsCode);
  while not ohFIF.Eof and (ohFIF.GsCode=pGsCode) do
  begin
    If ohFIF.Status='A' then begin
      If ohFIF.RbaCode=pRbaCode
        then begin
          pRbaQnt:=pRbaQnt+ohFIF.ActQnt;
          pRbaDate:=ohFIF.RbaDate;
        end else If ohFIF.RbaCode=''
          then pRbnQnt:=pRbnQnt+ohFIF.ActQnt
          else pRboQnt:=pRboQnt+ohFIF.ActQnt;
    end;
    ohFIF.Next;
  end;
  Result:=Eq3(pQnt,pRbaQnt) or (pQnt<pRbaQnt);
end;

end.
{MOD 1924}

