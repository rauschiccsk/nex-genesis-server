unit StkHand;

interface

uses
  IcTypes, IcVariab, IcConv, IcConst, IcTools, IcDate, Key, 
  BtrHand, BtrTools, StkGlob, NexPath,
  NexBtrTable, NexPxTable,
  Classes, SysUtils;

type
  TGsData = record
    MgCode: word;        // »Ìslo tovarovej skupiny
    GsCode: longint;     // TovarovÈ ËÌslo
    GsName: Str30;       // N·zov tovaru
    BarCode: Str15;      // IdentifikaËn˝ kÛd tovaru
    StkCode: Str15;      // Skladov˝ kÛd tovaru
    VatPrc: double;      // Sadzba DPH tovaru
    VatCode: byte;       // Skupina DPH tovaru
    MsCode: word;        // KÛd mernej jednotky tovaru
    MsName: Str10;       // Mern· jednotka tovaru
    DocNum: Str12;       // »Ìslo skladovÈho dokladu
    ItmNum: longint;     // PoradovÈ ËÌslo poloûky na skladovom doklade
    DocDate: TDateTime;  // D·tum skladovÈho dokladu
    DrbDate: TDateTime;  // D·tum z·ruky
    RbaDate: TDateTime;  // D·tum vyrobnej sarze
    RbaCode: Str30;      // Vyrobna sarza
    CPrice: double;      // N·kupn· cena tovaru bez DPH
    GsQnt: double;       // Mnoûstvo ktorÈ treba prijaù(+) alebo vydaù(-)
    Bprice: double;      // Predajna cena tovaru s DPH
    OcdNum: Str12;       // »Ìslo doölej objedn·vky
    OcdItm: word;        // PoradovÈ ËÌslo poloûky na objedn·vke
    PaCode: longint;     // Prvotn˝ kÛd dod·vateæa
    SmCode: word;        // KÛd skladovÈho pohybu
    SmSign: Str1;        // Znak skladovÈho pohybu
    FifNum: longint;     // PoradovÈ ËÌslo FIFO - pouûÌva sa pri prÌjmu tovaru na sklad
    AcqStat: Str1;       // Priznak obstarania tovaru
    ConStk: word;        // Cislo protiskladu
  end;
(*
  TOutFifData = record
    FifNum: longint;     // »Ìslo Fifo karty
    ActPos: longint;     // PoziËn˝ blik Fifo karty v datab·zovom s˙bore
    OutQnt: double;      // Mnoûstvo, ktorÈ bude vydanÈ
    OutPrice: double;    // Cena z danej fifo karty
  end;
*)
  TSubtract = class
    constructor Create;
    destructor Destroy; override;
  private
    oGsData: TGsData;  // ⁄daje tovarovej poloûky
    oSalNul: boolean;  // Ak je TRUE pri vydaji sa vynuluje SalQnt - neodpocitany predaj
//    oOutFifos: TList;  // Fifo karty a mnoûstv· ktorÈ bud˙ vydahÈ zo skladu
//    oOutFifData: ^TOutFifData;  // Datov· zloûka zoznamu oOutFifos
    oAbortCode: word;  // KÛd preruöenia skladovÈho prÌjmu alebo v˝daja
    oInput: boolean; // Ak je true to znamena ze bo uskutocneny prijem tovaru na sklad
//    oDoc:TDocFnc;
    procedure Error (pErrCode:word);  // UloûÌ chybovÈ hl·senie do s˙boru
    procedure Abort (pAbortCode:word); // ZruöÌ tranzakciu skladovÈho prÌjmu alebo v˝daja a chybu uloûÌ do LOG s˙boru

    // Procedury ktorÈ pracuju s fifo kartamy naËÌtanÈ do vyrovn·vacej pam˙ti
//    procedure ClearOutFifos; // Vymazanie ˙dajov Fifo na odpocet
//    procedure AddToOutFifos (pFifNum,pActPos:longint; pOutQnt,pOutPrice:double);  // Prid· z·znam do zoznamu Fifo kariet, ktorÈ bud˙ vydanÈ zo skladu
//    procedure PutOutQnt (pIndex:word;pValue:double); // UloûÌ zadanÈ mnoûstvo na do zadanej fifo karty

//    function GetFifNum(pIndex:word): longint; // PoradovÈ ËÌslo fifo karty
//    function GetFifPrice(pIndex:word): double; // Je to cena na zadanej fifo karty
//    function GetFifQnt(pIndex:word): double; // Je to mnoûstvo na zadanej fifo karty
//    function GetActPos(pIndex:word): longint; // Pozicia danej FIFO karty v datab8ze FIFOxxx.BTR
//    function GetFifCount: word; // PoËet fifo kariet, ktorÈ bud˙ pouûitÌ na dan˝ v˝daj

    procedure AddToFif;    // Prid· tovarov˙ poloûku do dennika FIFO kariet
    procedure AddToStm;    // Prid· tovarov˙ poloûku do dennÌka skladov˝ch pohybov
    procedure InToStk;     // PrÌjem tovaru na skladov˙ kartu podæa vykonanÈho pohybu
    procedure OutFromFif;  // UskutoËnÌ v˝daj z FIFO kariet
    procedure OutFromStk;  // V˝daj tovaru zo skladovej karty podæa vykonanÈho pohybu
    procedure Reserve;   // Zmeni poziadavku na rezervaciu
  public
    procedure SetSalNul;
    procedure OpenStkFiles (pStkNum:longint); // Otvori subory FIFO, STKM a STOCK
    procedure CloseStkFiles; // Uzatvory subory FIFO, STKM a STOCK
    procedure AnalyzeFifo(pYear:word);  // Analyzuje Fifo karty a zisti, ûe koæko Fifo kariet bude treba pouûiù na danÈ mnoûstvo v˝daja
    procedure Input;  // PrÌjme tovar, ktor˝ je vo vyrovn·vacej pam‰te GsData na sklad
    function Output(pDocDate:TDateTime):boolean; // Vyda tovar, ktor˝ je vo vyrovn·vacej pam‰te GsData zo skladu. Pri uspesnom vydaji hodnota funkcie je true
    function GetCPrice:double; // Nakupna cena
    function GetFreQnt:double; // Volne mnozstvo

    procedure ClearGsData;   // Vymazanie ˙dajov - treba vykonaù pred zad·vanÌm novÈho tovaru
    // TovarovÈ ˙daje
    procedure PutMgCode (pValue:word);      // »Ìslo tovarovej skupiny
    procedure PutGsCode (pValue:longint);   // TovarovÈ ËÌslo
    procedure PutGsName (pValue:Str30);     // N·zov tovaru
    procedure PutBarCode (pValue:Str15);    // IdentifikaËn˝ kÛd tovaru
    procedure PutStkCode (pValue:Str15);    // Skladov˝ kÛd tovaru
    procedure PutMsName (pValue:Str10);     // Merna jednotka
    procedure PutAcqStat (pValue:Str1);     // Priznak obstarania tovaru
    // ⁄daje z dokladu
    procedure PutDocNum (pValue:Str12);     // »Ìslo skladovÈho dokladu
    procedure PutItmNum (pValue:longint);   // PoradovÈ ËÌslo poloûky na skladovom doklade
    procedure PutDocDate(pValue:TDateTime); // D·tum skladovÈho dokladu
    procedure PutDrbDate(pValue:TDateTime); // D·tum z·ruky
    procedure PutRbaDate(pValue:TDateTime); // D·tum vyrobnej sarze
    procedure PutRbaCode(pValue:Str30);     // Vyrobna sarza
    procedure PutCPrice (pValue:double);    // N·kupn· cena tovaru bez DPH
    procedure PutVatPrc (pValue:double);    // Sadzba DPH
    procedure PutGsQnt  (pValue:double);    // Mnoûstvo ktorÈ treba prijaù(+) alebo vydaù(-)
    procedure PutOcdNum (pValue:Str12);     // »Ìslo doölej objedn·vky
    procedure PutOcdItm (pValue:word);      // PoradovÈ ËÌslo poloûky na objedn·vke
    procedure PutPaCode (pValue:longint);   // Prvotn˝ kÛd dod·vateæa
    procedure PutSmCode (pValue:word);      // KÛd skladovÈho pohybu
    procedure PutSmSign (pValue:Str1);      // Znak skladoveho pohybu
    procedure PutFifNum (pValue:longint);   // Poradove cislo FIFO karty
    procedure PutBprice (pValue:double);    // Predajna cena tovaru
//    procedure PutBPrice (pValue:double);    // Predajna cena s DPH
    procedure PutConStk (pValue:word);      // Cislo protiskladu

//    function GetOutQnt: double;   // Mnoûstvo ktorÈ je moûnÈ vydaù zo skladu
//    function GetFifStr: string;  // Hodnota funkcie je vymenovanie pouzitych Fifo kariet - tento udaj sa uklada pri poloziek skladovych dokladov
//    function GetFifValue: double; // Je to hodnota v˝daja vypoËÌtanÈ z fifo kariet
    function GetInPrice: double;  // Je to nakupna cena prijmu tovaru

    function GetStmSumQnt (pDocNum:Str12; pItmNum:longint): double; // Hodnotou funkcie je mnozstvo, ktora uz bola odpocitana alebo pripocitana na sklad
    procedure DocStmSum (pDocNum:Str12; pItmNum:longint; var pSumQnt,pSumVal:double); // Procedure vypocita a vrati v parametroch mnozstvo (pSumQnt) a hodnotu (pSumVal) ktore boli vyskladene alebo naskladnene cez dany doklad a polozku
  end;

  procedure VerifyStkStat(pBtr:TNexBtrTable; pTmp:TNexPxTable);
  procedure DocStmSum (pDocNum:Str12; pItmNum,pStkNum:longint; var pSumQnt,pSumVal:double); // Procedure vypocita a vrati v parametroch mnozstvo (pSumQnt) a hodnotu (pSumVal) ktore boli vyskladene alebo naskladnene cez dany doklad a polozku

implementation

uses
  DM_STKDAT, DocHand;

const
  cInconsistentIndexInStock = 700;  // Chybn˝ (inkonzistentn˝0 index v s˙bore STOCKxxx.BTR
  cOutGoodsNotInStock = 701;        // Vydd·van˝ tovar nem· skladov˙ kartu
  cIncorrectFifoActPos = 702;       // Nespr·vna pozÌcia FIFO karty

procedure VerifyStkStat(pBtr:TNexBtrTable; pTmp:TNexPxTable);
  function GetStmSumQnt (pDocNum:Str12; pItmNum:longint): double; // Hodnotou funkcie je mnozstvo, ktora uz bola odpocitana alebo pripocitan8 na sklad
  begin
    Result:=0;
    dmSTK.btSTM.SwapStatus;
    dmSTK.btSTM.IndexName:='DoIt';
    If dmSTK.btSTM.FindKey ([pDocNum,pItmNum]) then begin
      Repeat
        Result:=Result+dmSTK.btSTM.FieldByName('GsQnt').AsFloat;
        dmSTK.btSTM.Next;
      until (dmSTK.btSTM.Eof) or (dmSTK.btSTM.FieldByName('DocNum').AsString<>pDocNum) or (dmSTK.btSTM.FieldByName('ItmNum').AsInteger<>pItmNum);
    end;
    dmSTK.btSTM.RestoreStatus;
  end;

begin
  If (pTmp.FieldByName('StkStat').AsString='N')
  and IsNotNul(GetStmSumQnt (pTmp.FieldByName('DocNum').AsString,pTmp.FieldByName('ItmNum').AsInteger))
  then begin  // Ci urcite nie je skaldovy pohyb
    pTmp.Edit;
    pTmp.FieldByName('Status').AsString:='S';
    pTmp.Post;
    pBtr.SwapIndex;
    pBtr.IndexName:='DoIt';
    If pBtr.FindKey ([pTmp.FieldByName('DocNum').AsString,pTmp.FieldByName('ItmNum').AsInteger]) then begin
      pBtr.Edit;
      pBtr.FieldByName('Status').AsString:='S';
      pBtr.Post;
    end;
    pBtr.RestoreIndex;
  end;
end;

procedure DocStmSum (pDocNum:Str12; pItmNum,pStkNum:longint; var pSumQnt,pSumVal:double); // Procedure vypocita a vrati v parametroch mnozstvo (pSumQnt) a hodnotu (pSumVal) ktore boli vyskladene alebo naskladnene cez dany doklad a polozku
begin
  pSumQnt:=0;  pSumVal:=0;
  dmSTK.btSTM.Open(pstkNum);
  dmSTK.btSTM.IndexName:='DoIt';
  If dmSTK.btSTM.FindKey ([pDocNum,pItmNum]) then begin
    Repeat
      pSumQnt:=pSumQnt+dmSTK.btSTM.FieldByName('GsQnt').AsFloat;
      pSumVal:=pSumVal+dmSTK.btSTM.FieldByName('CValue').AsFloat;
      dmSTK.btSTM.Next;
    until (dmSTK.btSTM.Eof) or (dmSTK.btSTM.FieldByName('DocNum').AsString<>pDocNum) or (dmSTK.btSTM.FieldByName('ItmNum').AsInteger<>pItmNum);
  end;
end;

// *************************************************
// ********************* SUBSTRACT *****************
// *************************************************

constructor TSubtract.Create;
begin
  oSalNul:=FALSE;
//  oOutFifos:=TList.Create;
//  oDoc:=TDocFnc.;
end;

destructor TSubtract.Destroy;
begin
  dmSTK.ClearOutFifos; // Vymaûeme ˙daje FIFO z vyrovn·vacej pam‰te
(*
  try
    ClearOutFifos; // Vymaûeme ˙daje FIFO z vyrovn·vacej pam‰te
  finally
    oOutFifos.Free;
  end;
*)
end;

procedure TSubtract.Input;
begin
  oInput:=TRUE;
  AddToFif;  // Prid· tovarov˙ poloûku do dennika FIFO kariet
  AddToStm;  // Prid· tovarov˙ poloûku do dennÌka skladov˝ch pohybov
  InToStk;   // UpravÌ skladov˙ kartu tovaru podæa vykonanÈho pohybu
  If gKey.StkRsvOcd[StrInt(dmSTK.GetActStkNum,0)] then Reserve;   // Zmeni poziadavku na rezervaciu
end;

function TSubtract.Output(pDocDate:TDateTime):boolean;
var I:word;  mFifQnt:double;
begin
  oInput:=FALSE;
  If dmSTK.GetOutFifCount=0 then AnalyzeFifo(Year(pDocDate));   // Analyzuje moûnosù v˝daja poda FIFO kariet -  v opacnom pripade FIFO karty a vydane mnozstva boli urcene z vonka
  mFifQnt:=dmSTK.GetOutFifosQnt;
  Result:=((mFifQnt>Abs(oGsData.GsQnt)) or Eq3(mFifQnt,Abs(oGsData.GsQnt))) and (dmSTK.GetOutFifosQnt>0);
  If Result then begin
    OutFromFif;   // UskutoËnÌ v˝daj z FIFO kariet
    For I:=1 to dmSTK.GetOutFifCount do begin
      PutFifNum(dmSTK.GetOutFifNum(I));
      PutGsQnt(dmSTK.GetOutFifQnt(I));
      PutCPrice(dmSTK.GetOutFifPrice(I));
      PutAcqStat(dmSTK.GetOutAcqStat(I));
      PutDrbDate(dmSTK.GetOutDrbDate);
      AddToStm;  // Prid· tovarov˙ poloûku do dennÌka skladov˝ch pohybov
    end;
    OutFromStk;  // UpravÌ skladov˙ kartu tovaru podæa vykonanÈho pohybu
  end;
end;

function TSubtract.GetCPrice:double; // Nakupna cena
begin
  Result:=oGsData.CPrice;
end;

function TSubtract.GetFreQnt:double; // Volne mnozstvo
begin
  Result:=0;
  dmSTK.btSTK.SwapIndex;
  If dmSTK.btSTK.IndexName<>'GsCode' then dmSTK.btSTK.IndexName:='GsCode';
  If dmSTK.btSTK.FindKey ([oGsData.GsCode]) then begin
    If dmSTK.btSTK.FieldByName('GsCode').AsInteger=oGsData.GsCode then Result:=dmSTK.btSTK.FieldByName ('FreQnt').AsFloat;
  end;
  dmSTK.btSTK.RestoreIndex;
end;

procedure TSubtract.SetSalNul;
begin
  oSalNul:=TRUE;
end;

procedure TSubtract.OpenStkFiles (pStkNum: longint); // Otvori subory FIFO, STKM a STOCK
begin
  If (pStkNum<>dmSTK.GetActStkNum) or not dmSTK.btSTK.Active or not dmSTK.btSTM.Active or not dmSTK.btFIF.Active then begin
    dmSTK.OpenSTK (pStkNum);
    dmSTK.OpenSTM (pStkNum);
    dmSTK.OpenFIF (pStkNum);
  end;
  If not dmSTK.btSTK.Active or (dmSTK.btSTK.TableName <> dmSTK.btSTK.FixedName+StrIntZero(pStkNum,5)) then dmSTK.OpenSTK (pStkNum);
  If not dmSTK.btSTM.Active or (dmSTK.btSTM.TableName <> dmSTK.btSTM.FixedName+StrIntZero(pStkNum,5)) then dmSTK.OpenSTM (pStkNum);
  If not dmSTK.btFIF.Active or (dmSTK.btFIF.TableName <> dmSTK.btFIF.FixedName+StrIntZero(pStkNum,5)) then dmSTK.OpenFIF (pStkNum);
end;

procedure TSubtract.CloseStkFiles; // Uzatvory subory FIFO, STKM a STOCK
begin
  dmSTK.btSTK.Close;
  dmSTK.btSTM.Close;
  dmSTK.btFIF.Close;
end;

procedure TSubtract.Error (pErrCode:word);  // UloûÌ chybovÈ hl·senie do s˙boru
var mTx: TStrings;
begin
  mTx:=TStringList.Create;
  mTx.Add (gvSys.LoginName+' '+DateTimeToStr(Now)+' PLU='+StrInt(oGsData.GsCode,0)+' ERR='+StrInt(pErrCode,0));
  mTx.SaveToFile (gPath.SysPath+'STKERR.LOG');
  mTx.Free;
end;

procedure TSubtract.Abort (pAbortCode:word);
begin
  BtrAbortTrans;  // ZruöÌme tranzakciu Btrievu
  oAbortCode:=pAbortCode;
  Error (pAbortCode);
end;
(*
procedure TSubtract.ClearOutFifos; // Vymazanie ˙dajov Fifo na odpocet
var I:word;
begin
  If oOutFifos.Count>0 then begin
    For I:=0 to (oOutFifos.Count-1) do begin
      oOutFifData:=oOutFifos.Items[I];
      Dispose(oOutFifData);
    end;
  end;
end;

procedure TSubtract.AddToOutFifos (pFifNum,pActPos:longint; pOutQnt,pOutPrice:double);  // Prid· z·znam do zoznamu Fifo kariet, ktorÈ bud˙ vydanÈ zo skladu
begin
  New (oOutFifData);
  oOutFifData^.FifNum:=pFifNum;
  oOutFifData^.ActPos:=pActPos;
  oOutFifData^.OutQnt:=pOutQnt;
  oOutFifData^.OutPrice:=pOutPrice;
  oOutFifos.Add (oOutFifData);
end;
*)
procedure TSubtract.ClearGsData;  // Vymazanie ˙dajov z vyrovn·vacej pam‰te - treba vykonaù pred zad·vanÌm novÈho tovaru
begin
  FillChar (oGsData,SizeOf(TGsData),#0);
end;

procedure TSubtract.PutDocNum (pValue:Str12); // »Ìslo skladovÈho dokladu
begin
  oGsData.DocNum:=pValue;
end;

procedure TSubtract.PutItmNum (pValue:longint); // PoradovÈ ËÌslo poloûky na skladovom doklade
begin
  oGsData.ItmNum:=pValue;
end;

procedure TSubtract.PutMgCode (pValue:word); // »Ìslo tovarovej skupiny
begin
  oGsData.MgCode:=pValue;
end;

procedure TSubtract.PutGsCode (pValue:longint); // TovarovÈ ËÌslo
begin
  oGsData.GsCode:=pValue;
end;

procedure TSubtract.PutGsName (pValue:Str30); // N·zov tovaru
begin
  oGsData.GsName:=pValue;
end;

procedure TSubtract.PutBarCode (pValue:Str15); // IdentifikaËn˝ kÛd tovaru
begin
  oGsData.BarCode:=pValue;
end;

procedure TSubtract.PutStkCode (pValue:Str15); // Skladov˝ kÛd tovaru
begin
  oGsData.StkCode:=pValue;
end;

procedure TSubtract.PutMsName (pValue:Str10);     // Merna jednotka
begin
  oGsData.MsName:=pValue;
end;

procedure TSubtract.PutAcqStat (pValue:Str1); // Priznak obstarania toaru
begin
  oGsData.AcqStat:=pValue;
end;

procedure TSubtract.PutDocDate (pValue:TDateTime); // D·tum skladovÈho dokladu
begin
  oGsData.DocDate:=pValue;
end;

procedure TSubtract.PutDrbDate (pValue:TDateTime); // D·tum z·ruky
begin
  oGsData.DrbDate:=pValue;
end;

procedure TSubtract.PutRbaDate (pValue:TDateTime); // D·tum sarze
begin
  oGsData.RbaDate:=pValue;
end;

procedure TSubtract.PutRbaCode (pValue:Str30); // Kod sarze
begin
  oGsData.RbaCode:=pValue;
end;

procedure TSubtract.PutCPrice (pValue:double); // N·kupn· cena tovaru bez DPH
begin
  If (oGsData.SmSign='+')and (pValue=0) and not gKey.StkNulPrc then begin // Dosadime poslednu nakupnu cenu tovaru ak nie je povolena nulova NC
    If dmSTK.btSTK.IndexName<>'GsCode' then dmSTK.btSTK.IndexName:='GsCode';
    If dmSTK.btSTK.FindKey ([oGsData.GsCode]) then oGsData.CPrice:=dmSTK.btSTK.FieldByName ('LastPrice').AsFloat;
  end
  else oGsData.CPrice:=pValue;
end;

procedure TSubtract.PutVatPrc (pValue:double); // Sadzba DPH
begin
  oGsData.VatPrc:=pValue;
end;

procedure TSubtract.PutGsQnt (pValue:double); // Mnoûstvo ktorÈ treba prijaù(+) alebo vydaù(-)
begin
  oGsData.GsQnt:=pValue;
end;

procedure TSubtract.PutOcdNum (pValue:Str12); // »Ìslo doölej objedn·vky
begin
  oGsData.OcdNum:=pValue;
end;

procedure TSubtract.PutOcdItm (pValue:word); // PoradovÈ ËÌslo poloûky na objedn·vke
begin
  oGsData.OcdItm:=pValue;
end;

procedure TSubtract.PutPaCode (pValue:longint); // Prvotn˝ kÛd dod·vateæa
begin
  oGsData.PaCode:=pValue;
end;

procedure TSubtract.PutSmCode (pValue:word); // KÛd skladovÈho pohybu
begin
  oGsData.SmCode:=pValue;
end;

procedure TSubtract.PutSmSign (pValue:Str1); // Znak skladovÈho pohybu
begin
  oGsData.SmSign:=pValue;
end;

procedure TSubtract.PutFifNum (pValue:longint);  // Poradove cislo FIFO karty
begin
  oGsData.FifNum:=pValue;
end;

procedure TSubtract.PutBprice(pValue:double);  // Predajna cena s DPH
begin
  oGsData.Bprice:=pValue;
end;

procedure TSubtract.PutConStk (pValue:word); // Cislo protiskladu
begin
  oGsData.ConStk:=pValue;
end;

procedure TSubtract.AnalyzeFifo(pYear:word); // Analyzuje Fifo karty a zisti, ûe koæko Fifo kariet bude treba pouûiù na danÈ mnoûstvo v˝daja
var mGsQnt: double;
begin
//  oOutFifos.Clear;
  dmSTK.btFIF.SwapStatus;
  dmSTK.btFIF.IndexName:='GsStDa';
  dmSTK.btFIF.FindNearest([oGsData.GsCode,'A',36000]);
  If (dmSTK.btFIF.FieldByName('GsCode').AsInteger=oGsData.GsCode) and (dmSTK.btFIF.FieldByName('Status').AsString='A') then begin
    mGsQnt:=Abs(oGsData.GsQnt);
    Repeat
      If dmSTK.btFIF.FieldByName('ActQnt').AsFloat>0 then begin
        If Year(dmSTK.btFIF.FieldByName('DocDate').AsDateTime)<=pYear then begin
          If dmSTK.btFIF.FieldByName ('ActQnt').AsFloat<mGsQnt then begin
            // Bude to z viacer˝ch kariet
            dmSTK.AddToOutFifos (dmSTK.btFIF.FieldByName ('FifNum').AsInteger,dmSTK.btFIF.ActPos,dmSTK.btFIF.FieldByName ('ActQnt').AsFloat,dmSTK.btFIF.FieldByName ('InPrice').AsFloat,dmSTK.btFIF.FieldByName ('AcqStat').AsString,dmSTK.btFIF.FieldByName('DocDate').AsDateTime,dmSTK.btFIF.FieldByName('DrbDate').AsDateTime);
            mGsQnt:=mGsQnt-dmSTK.btFIF.FieldByName ('ActQnt').AsFloat;
          end
          else begin
            dmSTK.AddToOutFifos(dmSTK.btFIF.FieldByName ('FifNum').AsInteger,dmSTK.btFIF.ActPos,mGsQnt,dmSTK.btFIF.FieldByName ('InPrice').AsFloat,dmSTK.btFIF.FieldByName ('AcqStat').AsString,dmSTK.btFIF.FieldByName('DocDate').AsDateTime,dmSTK.btFIF.FieldByName('DrbDate').AsDateTime);
            mGsQnt:=0;
          end;
        end;
      end;
      dmSTK.btFIF.Next;
    until Equal(mGsQnt,0,3) or (dmSTK.btFIF.Eof) or (dmSTK.btFIF.FieldByName('GsCode').Asinteger<>oGsData.GsCode) or (dmSTK.btFIF.FieldByName('Status').AsString<>'A');
  end;
  dmSTK.btFIF.RestoreStatus;
end;

procedure TSubtract.AddToFif;
begin
  If oGsData.AcqStat='' then oGsData.AcqStat:='R';
  // UrËÌme nasleduj˙ce FifoNum
  dmSTK.btFIF.SwapStatus;
  dmSTK.btFIF.IndexName:='FifNum';
  dmSTK.btFIF.Last;
  oGsData.FifNum:=dmSTK.btFIF.FieldByName ('FifNum').AsInteger+1;
  dmSTK.btFIF.RestoreStatus;
  // Prid·me poloûku do FIFO
  dmSTK.btFIF.Insert;
  dmSTK.btFIF.FieldByName ('FifNum').AsInteger:=oGsData.FifNum;
  dmSTK.btFIF.FieldByName ('DocNum').AsString:=oGsData.DocNum;
  dmSTK.btFIF.FieldByName ('ItmNum').AsInteger:=oGsData.ItmNum;
  dmSTK.btFIF.FieldByName ('GsCode').AsInteger:=oGsData.GsCode;
  dmSTK.btFIF.FieldByName ('DocDate').AsDateTime:=oGsData.DocDate;
  dmSTK.btFIF.FieldByName ('DrbDate').AsDateTime:=oGsData.DrbDate;
  dmSTK.btFIF.FieldByName ('RbaDate').AsDateTime:=oGsData.RbaDate;
  dmSTK.btFIF.FieldByName ('RbaCode').AsString:=oGsData.RbaCode;
  dmSTK.btFIF.FieldByName ('InPrice').AsFloat:=oGsData.CPrice;
  dmSTK.btFIF.FieldByName ('InQnt').AsFloat:=oGsData.GsQnt;
  dmSTK.btFIF.FieldByName ('OutQnt').AsFloat:=0;
  dmSTK.btFIF.FieldByName ('ActQnt').AsFloat:=oGsData.GsQnt;
  dmSTK.btFIF.FieldByName ('AcqStat').AsString:=oGsData.AcqStat;
  dmSTK.btFIF.FieldByName ('PaCode').AsInteger:=oGsData.PaCode;
  dmSTK.btFIF.FieldByName ('Status').AsString:='W';
  dmSTK.btFIF.Post;
end;

procedure TSubtract.AddToStm;
var mNextStmNum: longint;
begin
  // UrËÌme nasleduj˙ci StmNum
  dmSTK.btSTM.SwapStatus;
  dmSTK.btSTM.IndexName:='StmNum';
  dmSTK.btSTM.Last;
  mNextStmNum:=dmSTK.btSTM.FieldByName ('StmNum').AsInteger+1;
  dmSTK.btSTM.RestoreStatus;
  // Prid·me poloûku do STM
  dmSTK.btSTM.Insert;
  dmSTK.btSTM.FieldByName ('StmNum').AsInteger:=mNextStmNum;
  dmSTK.btSTM.FieldByName ('DocNum').AsString:=oGsData.DocNum;
  dmSTK.btSTM.FieldByName ('ItmNum').AsInteger:=oGsData.ItmNum;
  dmSTK.btSTM.FieldByName ('GsCode').AsInteger:=oGsData.GsCode;
  dmSTK.btSTM.FieldByName ('MgCode').AsInteger:=oGsData.MgCode;
  dmSTK.btSTM.FieldByName ('GsName').AsString:=oGsData.GsName;
  dmSTK.btSTM.FieldByName ('DocDate').AsDateTime:=oGsData.DocDate;
  dmSTK.btSTM.FieldByName ('SmCode').AsInteger:=oGsData.SmCode;
  dmSTK.btSTM.FieldByName ('FifNum').AsInteger:=oGsData.FifNum;
  If oGsData.SmSign='+'
    then dmSTK.btSTM.FieldByName ('GsQnt').AsFloat:=oGsData.GsQnt
    else dmSTK.btSTM.FieldByName ('GsQnt').AsFloat:=oGsData.GsQnt*(-1);
  dmSTK.btSTM.FieldByName ('CValue').AsFloat:=oGsData.CPrice*dmSTK.btSTM.FieldByName ('GsQnt').AsFloat;
  dmSTK.btSTM.FieldByName ('Bprice').AsFloat:=oGsData.Bprice;
  dmSTK.btSTM.FieldByName ('Bvalue').AsFloat:=oGsData.Bprice*oGsData.GsQnt;
  dmSTK.btSTM.FieldByName ('OcdNum').AsString:=oGsData.OcdNum;
  dmSTK.btSTM.FieldByName ('OcdItm').AsInteger:=oGsData.OcdItm;
  dmSTK.btSTM.FieldByName ('PaCode').AsInteger:=oGsData.PaCode;
  dmSTK.btSTM.FieldByName ('ConStk').AsInteger:=oGsData.ConStk;
  If GetDocType(dmSTK.btSTM.FieldByName ('DocNum').AsString) in [dtTS,dtIM,dtRM] then dmSTK.btSTM.FieldByName ('SpaCode').AsInteger:=oGsData.PaCode;
  dmSTK.btSTM.FieldByName ('AcqStat').AsString:=oGsData.AcqStat;
  dmSTK.btSTM.Post;
end;

procedure TSubtract.InToStk;
begin
  If dmSTK.btSTK.IndexName<>'GsCode' then dmSTK.btSTK.IndexName:='GsCode';
  If dmSTK.btSTK.FindKey ([oGsData.GsCode]) then begin
    If dmSTK.btSTK.FieldByName('GsCode').AsInteger=oGsData.GsCode then begin
      dmSTK.btSTK.Edit;
      dmSTK.btSTK.FieldByName ('InQnt').AsFloat:=dmSTK.btSTK.FieldByName ('InQnt').AsFloat+oGsData.GsQnt;
      dmSTK.btSTK.FieldByName ('InVal').AsFloat:=dmSTK.btSTK.FieldByName ('InVal').AsFloat+oGsData.GsQnt*oGsData.CPrice;
      dmSTK.btSTK.FieldByName ('LastPrice').AsFloat:=oGsData.CPrice;
      If Rd2(dmSTK.btSTK.FieldByName ('ActQnt').AsFloat)>0
        then dmSTK.btSTK.FieldByName ('AvgPrice').AsFloat:=Rd2(dmSTK.btSTK.FieldByName ('ActVal').AsFloat/dmSTK.btSTK.FieldByName ('ActQnt').AsFloat)
        else dmSTK.btSTK.FieldByName ('AvgPrice').AsFloat:=dmSTK.btSTK.FieldByName ('LastPrice').AsFloat;
      dmSTK.btSTK.FieldByName ('LastIDate').AsDateTime:=oGsData.DocDate;
      dmSTK.btSTK.FieldByName ('LastIQnt').AsFloat:=oGsData.GsQnt;
//    Treba to len v pripade dodacieho listu - len ked je to prijem od dodavetela
      If (oGsData.PaCode>0) and (oGsData.GsQnt>0) and  (Copy(oGsData.DocNum,1,2)='DD')
        then dmSTK.btSTK.FieldByName ('LinPac').AsInteger:=oGsData.PaCode;
      If oSalNul then dmSTK.btSTK.FieldByName ('SalQnt').AsFloat:=0;
      dmSTK.btSTK.Post;
    end
    else Abort (cInconsistentIndexInStock);
  end
  else begin // Neexistuje skladova karta preto treba vytvorit
    dmSTK.btSTK.Insert;
    dmSTK.btSTK.FieldByName ('GsCode').AsInteger:=oGsData.GsCode;
    dmSTK.btSTK.FieldByName ('MgCode').AsInteger:=oGsData.MgCode;
    dmSTK.btSTK.FieldByName ('GsName').AsString:=oGsData.GsName;
    dmSTK.btSTK.FieldByName ('BarCode').AsString:=oGsData.BarCode;
    dmSTK.btSTK.FieldByName ('StkCode').AsString:=oGsData.StkCode;
    dmSTK.btSTK.FieldByName ('MsName').AsString:=oGsData.MsName;
    dmSTK.btSTK.FieldByName ('VatPrc').AsFloat:=oGsData.VatPrc;
    dmSTK.btSTK.FieldByName ('InQnt').AsFloat:=oGsData.GsQnt;
    dmSTK.btSTK.FieldByName ('InVal').AsFloat:=oGsData.GsQnt*oGsData.CPrice;
    If Rd2(dmSTK.btSTK.FieldByName ('ActQnt').AsFloat)>0
      then dmSTK.btSTK.FieldByName ('AvgPrice').AsFloat:=Rd2 (dmSTK.btSTK.FieldByName ('ActVal').AsFloat/dmSTK.btSTK.FieldByName ('ActQnt').AsFloat)
      else dmSTK.btSTK.FieldByName ('AvgPrice').AsFloat:=dmSTK.btSTK.FieldByName ('LastPrice').AsFloat;
    dmSTK.btSTK.FieldByName ('LastPrice').AsFloat:=oGsData.CPrice;
    dmSTK.btSTK.FieldByName ('ActPrice').AsFloat:=oGsData.CPrice;
    dmSTK.btSTK.FieldByName ('LastIDate').AsDateTime:=oGsData.DocDate;
    dmSTK.btSTK.FieldByName ('LastIQnt').AsFloat:=oGsData.GsQnt;
//  Treba to len v pripade dodacieho listu - len ked je to prijem od dodavetela
    If (oGsData.PaCode>0) and (oGsData.GsQnt>0) and  (Copy(oGsData.DocNum,1,2)='DD')
      then dmSTK.btSTK.FieldByName ('LinPac').AsInteger:=oGsData.PaCode;
    dmSTK.btSTK.Post;
  end;
end;

procedure TSubtract.OutFromFif;  // UskutoËnÌ v˝daj z FIFO kariet
var I:word;
begin
  For I:=1 to dmSTK.GetOutFifCount do begin
    dmSTK.btFIF.GotoPos (dmSTK.GetOutActPos(I));
    If dmSTK.btFIF.FieldByName ('FifNum').AsInteger=dmSTK.GetOutFifNum(I) then begin
      dmSTK.btFIF.Edit;
      dmSTK.btFIF.FieldByName ('OutQnt').AsFloat:=dmSTK.btFIF.FieldByName ('OutQnt').AsFloat+dmSTK.GetOutFifQnt(I);
      dmSTK.btFIF.Post;
    end
    else begin // FIFO karta nebola n·jden· - asi poruöeni datab·ze
      dmSTK.PutOutFifQnt (I,0);  // Vynulujeme kartu vo vyrovn·vacej pam‰ti
      Error (cIncorrectFifoActPos);
    end;
  end;
end;

procedure TSubtract.OutFromStk;
var mStr:Str8;
begin
  If dmSTK.btSTK.IndexName<>'GsCode' then dmSTK.btSTK.IndexName:='GsCode';
  If dmSTK.btSTK.FindKey ([oGsData.GsCode]) then begin
    If dmSTK.btSTK.FieldByName('GsCode').AsInteger=oGsData.GsCode then begin
      dmSTK.btSTK.Edit;
      If LongInInt(oGsData.SmCode,cSalSmCodes) then mStr:='SaQnt' else mStr:='OuQnt';
      If oGsData.DocDate>=gvSys.FirstActYearDate then mStr:='A'+mStr else mStr:='P'+mStr;
      If dmSTK.btSTK.FindField(mStr)<>NIL
        then dmSTK.btSTK.FieldByName (mStr).AsFloat:=dmSTK.btSTK.FieldByName (mStr).AsFloat+oGsData.GsQnt;
      dmSTK.btSTK.FieldByName ('OutQnt').AsFloat:=dmSTK.btSTK.FieldByName ('OutQnt').AsFloat+dmSTK.GetOutFifosQnt;
      dmSTK.btSTK.FieldByName ('OutVal').AsFloat:=dmSTK.btSTK.FieldByName ('OutVal').AsFloat+dmSTK.GetOutFifValue;
      If Rd2(dmSTK.btSTK.FieldByName ('ActQnt').AsFloat)>0
        then dmSTK.btSTK.FieldByName ('AvgPrice').AsFloat:=Rd2 (dmSTK.btSTK.FieldByName ('ActVal').AsFloat/dmSTK.btSTK.FieldByName ('ActQnt').AsFloat);
      dmSTK.btSTK.FieldByName ('ActPrice').AsFloat:=oGsData.CPrice;
      dmSTK.btSTK.FieldByName ('LastODate').AsDateTime:=oGsData.DocDate;
      dmSTK.btSTK.FieldByName ('LastOQnt').AsFloat:=oGsData.GsQnt;
      If oSalNul then dmSTK.btSTK.FieldByName ('SalQnt').AsFloat:=0;
      dmSTK.btSTK.Post;
    end
    else Abort (cInconsistentIndexInStock);
  end
  else Abort (cOutGoodsNotInStock);
end;

procedure TSubtract.Reserve;   // Zmeni poziadavku na rezervaciu
var mNrsLst:TStrings; // Zoznam ActPos zaznamov z STO, ktore su poziadavky
    mFreQnt:double;  I:word;   mReserve:boolean;  mBookNum:Str5;
begin

(*
  If dmSTK.btSTO.Active then begin
    mReserve:=FALSE; // TRUE ak niektora poziadavka bola zmenena na rezervaciu
    // Zapametame zaznamy, ktore su poziadavkami na objednanie
    mNrsLst:=TStringList.Create;
    // Obchodne zakazky - Objednane z prijemky tovar na ceste
    If (oGsData.DocNum<>'') and (oGsData.ItmNum>0) then begin
      dmSTK.btSTO.IndexName:='OdOi';
      If (dmSTK.btSTO.IndexName='OdOi') and dmSTK.btSTO.FindKey([oGsData.DocNum,oGsData.ItmNum]) then begin
        Repeat
          If (dmSTK.btSTO.FieldByName('StkStat').AsString='O') and (dmSTK.btSTO.FieldByName('OrdType').AsString='C') and (dmSTK.btSTO.FieldByName('OrdQnt').AsFloat-dmSTK.btSTO.FieldByName('DlvQnt').AsFloat>0)
            then mNrsLst.Add(StrInt(dmSTK.btSTO.ActPos,0));
          dmSTK.btSTO.Next;
        until (dmSTK.btSTO.Eof) or (dmSTK.btSTO.FieldByName('OsdNum').AsString<>oGsData.DocNum) or (dmSTK.btSTO.FieldByName('OsdItm').AsInteger<>oGsData.ItmNum) ;
      end;
    end;
    // Obchodne zakazky - Objednane zo zadanej objednavky
    If (oGsData.OcdNum<>'') and (oGsData.OcdItm>0) then begin
      dmSTK.btSTO.IndexName:='OdOi';
      If (dmSTK.btSTO.IndexName='OdOi') and dmSTK.btSTO.FindKey([oGsData.OcdNum,oGsData.OcdItm]) then begin
        Repeat
          If (dmSTK.btSTO.FieldByName('StkStat').AsString='O') and (dmSTK.btSTO.FieldByName('OrdType').AsString='C') and (dmSTK.btSTO.FieldByName('OrdQnt').AsFloat-dmSTK.btSTO.FieldByName('DlvQnt').AsFloat>0)
            then mNrsLst.Add (StrInt(dmSTK.btSTO.ActPos,0));
          dmSTK.btSTO.Next;
        until (dmSTK.btSTO.Eof) or (dmSTK.btSTO.FieldByName('OsdNum').AsString<>oGsData.OcdNum) or (dmSTK.btSTO.FieldByName('OsdItm').AsInteger<>oGsData.OcdItm) ;
      end;
    end;
    dmSTK.btSTO.IndexName:='GsOrSt';
    // Obchodne zakazky - poziadavky
    If dmSTK.btSTO.FindKey([oGsData.GsCode,'C','N']) then begin
      Repeat
        If mNrsLst.IndexOf(StrInt(dmSTK.btSTO.ActPos,0))=-1 then mNrsLst.Add (StrInt(dmSTK.btSTO.ActPos,0));
        dmSTK.btSTO.Next;
      until (dmSTK.btSTO.Eof) or (dmSTK.btSTO.FieldByName('GsCode').AsInteger<>oGsData.GsCode) or (dmSTK.btSTO.FieldByName('OrdType').AsString<>'C') or (dmSTK.btSTO.FieldByName('StkStat').AsString<>'N');
    end;
    // Obchodne zakazky - objednane
    If dmSTK.btSTO.FindKey([oGsData.GsCode,'C','O']) then begin
      Repeat
        If mNrsLst.IndexOf(StrInt(dmSTK.btSTO.ActPos,0))=-1 then mNrsLst.Add (StrInt(dmSTK.btSTO.ActPos,0));
        dmSTK.btSTO.Next;
      until (dmSTK.btSTO.Eof) or (dmSTK.btSTO.FieldByName('GsCode').AsInteger<>oGsData.GsCode) or (dmSTK.btSTO.FieldByName('OrdType').AsString<>'C') or (dmSTK.btSTO.FieldByName('StkStat').AsString<>'O');
    end;
    // Obchodne zakazky - ine
    If dmSTK.btSTO.FindKey([oGsData.GsCode,'C','E']) then begin
      Repeat
        If mNrsLst.IndexOf(StrInt(dmSTK.btSTO.ActPos,0))=-1 then mNrsLst.Add (StrInt(dmSTK.btSTO.ActPos,0));
        dmSTK.btSTO.Next;
      until (dmSTK.btSTO.Eof) or (dmSTK.btSTO.FieldByName('GsCode').AsInteger<>oGsData.GsCode) or (dmSTK.btSTO.FieldByName('OrdType').AsString<>'C') or (dmSTK.btSTO.FieldByName('StkStat').AsString<>'E');
    end;
    // Obchodne zakazky
    If dmSTK.btSTO.FindKey ([oGsData.GsCode,'X','N']) then begin
      Repeat
        If mNrsLst.IndexOf(StrInt(dmSTK.btSTO.ActPos,0))=-1 then mNrsLst.Add (StrInt(dmSTK.btSTO.ActPos,0));
        dmSTK.btSTO.Next;
      until (dmSTK.btSTO.Eof) or (dmSTK.btSTO.FieldByName('GsCode').AsInteger<>oGsData.GsCode) or (dmSTK.btSTO.FieldByName('OrdType').AsString<>'X') or (dmSTK.btSTO.FieldByName('StkStat').AsString<>'N');
    end;
    // Zmenime poziadavku na rezervaciu
    If mNrsLst.Count>0 then begin
      mFreQnt:=dmSTK.btSTK.FieldByName ('FreQnt').AsFloat;
      For I:=0 to mNrsLst.Count-1 do begin
        If dmSTK.btSTO.GotoPos(ValInt(mNrsLst.Strings[I])) then begin
          If Eq3(mFreQnt,dmSTK.btSTO.FieldByName ('OrdQnt').AsFloat) or (mFreQnt>dmSTK.btSTO.FieldByName ('OrdQnt').AsFloat) then begin
            mReserve:=TRUE;
            dmSTK.btSTO.Edit;
            dmSTK.btSTO.FieldByName ('StkStat').AsString:='R';
            dmSTK.btSTO.Post;
            // Oznacime rezervaciu na polozky zakazkoveho dokladu
            mBookNum:=BookNumFromDocNum(dmSTK.btSTO.FieldByName('DocNum').AsString);
            dmSTK.OpenBook(dmSTK.btOCI,mBookNum);
            dmSTK.btOCI.IndexName:='DoIt';
            If dmSTK.btOCI.FindKey ([dmSTK.btSTO.FieldByName('DocNum').AsString,dmSTK.btSTO.FieldByName('ItmNum').AsInteger]) then begin
              dmSTK.btOCI.Edit;
              dmSTK.btOCI.FieldByName ('StkStat').AsString:='R';
              dmSTK.btOCI.Post;
            end;
            dmSTK.btOCI.Close;
            mFreQnt:=mFreQnt-dmSTK.btSTO.FieldByName ('OrdQnt').AsFloat;
          end;
        end;
      end;
    end;
    FreeAndNil (mNrsLst);
    If mReserve then OcdRecalcFromSto (oGsData.GsCode);
  end else WriteToLogFile (gPath.SysPath+'NEXERR.LOG','STKHAND.Reserve - STO not Active - PLU :'+StrInt(oGsData.GsCode,7));
*)
end;

(*
function TSubtract.GetFifNum(pIndex:word): longint; // PoradovÈ ËÌslo fifo karty
begin
  oOutFifData:=oOutFifos.Items[pIndex-1];
  Result:=oOutFifData^.FifNum;
end;

function TSubtract.GetFifPrice(pIndex:word): double; // Je to cena na zadanej fifo karty
begin
  oOutFifData:=oOutFifos.Items[pIndex-1];
  Result:=oOutFifData^.OutPrice;
end;

function TSubtract.GetFifQnt(pIndex:word): double; // Je to mnoûstvo na zadanej fifo karty
begin
  oOutFifData:=oOutFifos.Items[pIndex-1];
  Result:=oOutFifData^.OutQnt;
end;

function TSubtract.GetActPos(pIndex:word): longint; // Pozicia danej FIFO karty v datab8ze FIFOxxx.BTR
begin
  oOutFifData:=oOutFifos.Items[pIndex-1];
  Result:=oOutFifData^.ActPos;
end;

function TSubtract.GetFifValue: double; // Je to hodnota v˝daja vypoËÌtanÈ z fifo kariet
var I:longint;
begin
  Result:=0;
  For I:=1 to oOutFifos.Count do
    Result:=Result+GetFifQnt(I)*GetFifPrice (I);
end;
*)
function TSubtract.GetInPrice: double; // Je to nakupna cena prijmu tovaru
begin
  Result:=oGsData.CPrice;
end;
(*
function TSubtract.GetFifCount: word; // PoËet fifo kariet, ktorÈ bud˙ pouûitÌ na dan˝ v˝daj
begin
  Result:=oOutFifos.Count;
end;

function TSubtract.GetOutQnt: double;  // Mnoûstvo ktorÈ je moûnÈ vydaù zo skladu
var I:longint;
begin
  Result:=0;
  For I:=1 to oOutFifos.Count do
    Result:=Result+GetFifQnt (I);
end;

function TSubtract.GetFifStr: string; // Hodnota funkcie je vymenovanie pouzitych Fifo kariet - tento udaj sa uklada pri poloziek skladovych dokladov
var mCnt:word;  mFifo:string;
begin
  Result:='';
  If oInput then begin
    Result:=StrInt(oGsData.FifNum,0)+'*'+StripFractZero(StrDoub(oGsData.GsQnt,0,6));
  end
  else begin
    If GetFifCount>0 then begin
      mCnt:=0;
      Repeat
         Inc (mCnt);
         mFifo:=StrInt(GetFifNum(mCnt),0)+'*'+StripFractZero(StrDoub(GetFifQnt(mCnt),0,6));
         If Result=''
           then Result:=mFifo
           else Result:=Result+','+mFifo;
      until (mCnt=GetFifCount);
    end;
  end;
end;
*)

function TSubtract.GetStmSumQnt (pDocNum:Str12; pItmNum:longint): double; // Hodnotou funkcie je mnozstvo, ktora uz bola odpocitana alebo pripocitan8 na sklad
begin
  Result:=0;
  dmSTK.btSTM.IndexName:='DoIt';
  If dmSTK.btSTM.FindKey ([pDocNum,pItmNum]) then begin
    Repeat
      Result:=Result+dmSTK.btSTM.FieldByName('GsQnt').AsFloat;
      dmSTK.btSTM.Next;
    until (dmSTK.btSTM.Eof) or (dmSTK.btSTM.FieldByName('DocNum').AsString<>pDocNum) or (dmSTK.btSTM.FieldByName('ItmNum').AsInteger<>pItmNum);
  end;
end;

procedure TSubtract.DocStmSum (pDocNum:Str12; pItmNum:longint; var pSumQnt,pSumVal:double); // Procedure vypocita a vrati v parametroch mnozstvo (pSumQnt) a hodnotu (pSumVal) ktore boli vyskladene alebo naskladnene cez dany doklad a polozku
begin
  pSumQnt:=0;  pSumVal:=0;
  dmSTK.btSTM.IndexName:='DoIt';
  If dmSTK.btSTM.FindKey ([pDocNum,pItmNum]) then begin
    Repeat
      pSumQnt:=pSumQnt+dmSTK.btSTM.FieldByName('GsQnt').AsFloat;
      pSumVal:=pSumVal+dmSTK.btSTM.FieldByName('CValue').AsFloat;
      dmSTK.btSTM.Next;
    until (dmSTK.btSTM.Eof) or (dmSTK.btSTM.FieldByName('DocNum').AsString<>pDocNum) or (dmSTK.btSTM.FieldByName('ItmNum').AsInteger<>pItmNum);
  end;
end;

end.
{MOD 1811001 - OznaËiù vöetky pohyby s pr·zdnym prÌznakom AcqStat na "R" }
