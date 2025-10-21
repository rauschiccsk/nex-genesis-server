unit Subtract;

interface

uses
  IcTypes, IcVariab, IcConv, IcTools, BtrHand, NexPath, Variants,
  Classes, SysUtils;

type
  TGsData = record
    MgCode: word;        // »Ìslo tovarovej skupiny
    GsCode: longint;     // TovarovÈ ËÌslo
    GsName: Str30;       // N·zov tovaru
    BarCode: Str15;      // IdentifikaËn˝ kÛd tovaru
    StCode: Str15;       // Skladov˝ kÛd tovaru
    VatPrc: double;      // Sadzba DPH tovaru
    VatCode: byte;       // Skupina DPH tovaru
    MsCode: word;        // KÛd mernej jednotky tovaru
    MsName: Str10;       // Mern· jednotka tovaru
    WriNum: word;        // Prev·dzkov· jednotka - sklad
    DocNum: Str12;       // »Ìslo skladovÈho dokladu
    ItmNum: word;        // PoradovÈ ËÌslo poloûky na skladovom doklade
    DocDate: TDateTime;  // D·tum skladovÈho dokladu
    DrbDate: TDateTime;  // D·tum z·ruky
    MovPrice: double;    // N·kupn· cena tovaru bez DPH
    MovQnt: double;      // Mnoûstvo ktorÈ treba prijaù(+) alebo vydaù(-)
    OrdDocNum: Str12;    // »Ìslo doölej objedn·vky
    OrdItmNum: word;     // PoradovÈ ËÌslo poloûky na objedn·vke
    PaPCode: longint;    // Prvotn˝ kÛd dod·vateæa
    PaSCode: word;       // Druhotn˝ kÛd dod·vateæa
    SmCode: word;        // KÛd skladovÈho pohybu
    SmSign: Str1;        // Znak skladovÈho pohybu
    FifoNum: longint;    // PoradovÈ ËÌslo FIFO - pouûÌva sa pri prÌjmu tovaru na sklad
  end;

  TOutFifoData = record
    FifoNum: longint;    // »Ìslo Fifo karty
    ActPos: longint;     // PoziËn˝ blik Fifo karty v datab·zovom s˙bore
    OutQnt: double;      // Mnoûstvo, ktorÈ bude vydanÈ
    OutPrice: double;    // Cena z danej fifo karty
  end;

  TSubtract = class
    constructor Create;
    destructor Destroy; override; 
  private
    oGsData: TGsData;  // ⁄daje tovarovej poloûky
    oOutFifos: TList;  // Fifo karty a mnoûstv· ktorÈ bud˙ vydahÈ zo skladu
    oOutFifoData: ^TOutFifoData;  // Datov· zloûka zoznamu oOutFifos
    oAbortCode: word;  // KÛd preruöenia skladovÈho prÌjmu alebo v˝daja
    oInput: boolean; // Ak je true to znamena ze bo uskutocneny prijem tovaru na sklad

    procedure Error (pErrCode:word);  // UloûÌ chybovÈ hl·senie do s˙boru
    procedure Abort (pAbortCode:word); // ZruöÌ tranzakciu skladovÈho prÌjmu alebo v˝daja a chybu uloûÌ do LOG s˙boru

    // Procedury ktorÈ pracuju s fifo kartamy naËÌtanÈ do vyrovn·vacej pam˙ti
    procedure ClearOutFifos; // Vymazanie ˙dajov Fifo na odpocet
    procedure AddToOutFifos (pFifoNum,pActPos:longint; pOutQnt,pOutPrice:double);  // Prid· z·znam do zoznamu Fifo kariet, ktorÈ bud˙ vydanÈ zo skladu
    procedure AnalyzeFifo;  // Analyzuje Fifo karty a zisti, ûe koæko Fifo kariet bude treba pouûiù na danÈ mnoûstvo v˝daja
    procedure PutOutQnt (pIndex:word;pValue:double); // UloûÌ zadanÈ mnoûstvo na do zadanej fifo karty

    function GetFifoNum(pIndex:word): longint; // PoradovÈ ËÌslo fifo karty
    function GetFifoPrice(pIndex:word): double; // Je to cena na zadanej fifo karty
    function GetFifoQnt(pIndex:word): double; // Je to mnoûstvo na zadanej fifo karty
    function GetActPos(pIndex:word): longint; // Pozicia danej FIFO karty v datab8ze FIFOxxx.BTR
    function GetFifoCount: word; // PoËet fifo kariet, ktorÈ bud˙ pouûitÌ na dan˝ v˝daj

    procedure AddToFifo;    // Prid· tovarov˙ poloûku do dennika FIFO kariet
    procedure AddToStkm;    // Prid· tovarov˙ poloûku do dennÌka skladov˝ch pohybov
    procedure InToStock;    // PrÌjem tovaru na skladov˙ kartu podæa vykonanÈho pohybu
    procedure OutFromFifo;  // UskutoËnÌ v˝daj z FIFO kariet
    procedure OutFromStock; // V˝daj tovaru zo skladovej karty podæa vykonanÈho pohybu
  public
    procedure OpenStkFiles (pStkNum:longint); // Otvori subory FIFO, STKM a STOCK
    procedure CloseStkFiles; // Uzatvory subory FIFO, STKM a STOCK

    procedure Input;  // PrÌjme tovar, ktor˝ je vo vyrovn·vacej pam‰te GsData na sklad
    function Output: boolean; // Vyda tovar, ktor˝ je vo vyrovn·vacej pam‰te GsData zo skladu. Pri uspesnom vydaji hodnota funkcie je true

    procedure ClearGsData;   // Vymazanie ˙dajov - treba vykonaù pred zad·vanÌm novÈho tovaru
    // TovarovÈ ˙daje
    procedure PutMgCode (pValue:word);      // »Ìslo tovarovej skupiny
    procedure PutGsCode (pValue:longint);   // TovarovÈ ËÌslo
    procedure PutGsName (pValue:Str30);     // N·zov tovaru
    procedure PutBarCode (pValue:Str15);    // IdentifikaËn˝ kÛd tovaru
    procedure PutStCode (pValue:Str15);     // Skladov˝ kÛd tovaru
    // ⁄daje z dokladu
    procedure PutWriNum (pValue:word);      // Prev·dzkov· jednotka - sklad
    procedure PutDocNum (pValue:Str12);     // »Ìslo skladovÈho dokladu
    procedure PutItmNum (pValue:word);      // PoradovÈ ËÌslo poloûky na skladovom doklade
    procedure PutDocDate (pValue:TDateTime);// D·tum skladovÈho dokladu
    procedure PutDrbDate (pValue:TDateTime);// D·tum z·ruky
    procedure PutMovPrice (pValue:double);   // N·kupn· cena tovaru bez DPH
    procedure PutMovQnt (pValue:double);    // Mnoûstvo ktorÈ treba prijaù(+) alebo vydaù(-)
    procedure PutOrdDocNum (pValue:Str12);  // »Ìslo doölej objedn·vky
    procedure PutOrdItmNum (pValue:word);   // PoradovÈ ËÌslo poloûky na objedn·vke
    procedure PutPaPCode (pValue:longint);  // Prvotn˝ kÛd dod·vateæa
    procedure PutPaSCode (pValue:word);     // Druhotn˝ kÛd dod·vateæa
    procedure PutSmCode (pValue:word);      // KÛd skladovÈho pohybu
    procedure PutSmSign (pValue:Str1);      // Znak skladoveho pohybu
    procedure PutFifoNum (pValue:longint);  // Poradove cislo FIFO karty

    function CanFullSubtract: boolean;  // TRUE ak je moûnÈ odpoËÌtaù zo skladu celÈ zadanÈ mnoûstvo
    function GetOutQnt: double;  // Mnoûstvo ktorÈ je moûnÈ vydaù zo skladu
    function GetFifoStr: string; // Hodnota funkcie je vymenovanie pouzitych Fifo kariet - tento udaj sa uklada pri poloziek skladovych dokladov
    function GetFifoValue: double; // Je to hodnota v˝daja vypoËÌtanÈ z fifo kariet
    function GetInPrice: double; // Je to nakupna cena prijmu tovaru

    function GetStmSumQnt (pDOcNum:Str12; pItmNum:longint): double; // Hodnotou funkcie je mnozstvo, ktora uz bola odpocitana alebo pripocitan8 na sklad
  end;

implementation

uses
  DM_STORES;

const
  cInconsistentIndexInStock = 700;  // Chybn˝ (inkonzistentn˝0 index v s˙bore STOCKxxx.BTR
  cOutGoodsNotInStock = 701;        // Vydd·van˝ tovar nem· skladov˙ kartu
  cIncorrectFifoActPos = 702;       // Nespr·vna pozÌcia FIFO karty

constructor TSubtract.Create;
begin
  oOutFifos := TList.Create;
end;

destructor TSubtract.Destroy;
begin
  try
    ClearOutFifos; // Vymaûeme ˙daje FIFO z vyrovn·vacej pam‰te
  finally
    oOutFifos.Free;
  end;
end;

procedure TSubtract.Input;
begin
  oInput := TRUE;
  AddToFifo;  // Prid· tovarov˙ poloûku do dennika FIFO kariet
  AddToStkm;  // Prid· tovarov˙ poloûku do dennÌka skladov˝ch pohybov
  InToStock;  // UpravÌ skladov˙ kartu tovaru podæa vykonanÈho pohybu
end;

function TSubtract.Output: boolean;
var I:word;
begin
  oInput := FALSE;
  AnalyzeFifo;   // Analyzuje moûnosù v˝daja poda FIFO kariet
  Result := (GetOutQnt>=oGsData.MovQnt) and (GetOutQnt>0);
  If Result then begin
    OutFromFifo;   // UskutoËnÌ v˝daj z FIFO kariet
    For I:=1 to GetFifoCount do begin
      PutFifoNum (GetFifoNum(I));
      PutMovQnt (GetFifoQnt(I));
      PutMovPrice (GetFifoPrice(I));
      AddToStkm;     // Prid· tovarov˙ poloûku do dennÌka skladov˝ch pohybov
    end;
    OutFromStock;  // UpravÌ skladov˙ kartu tovaru podæa vykonanÈho pohybu
  end;
end;

procedure TSubtract.OpenStkFiles (pStkNum: longint); // Otvori subory FIFO, STKM a STOCK
begin
  If pStkNum<>dmSTORES.GetActStkNum then begin
    dmSTORES.OpenSTK (pStkNum);
    dmSTORES.OpenSTM (pStkNum);
    dmSTORES.OpenFIF (pStkNum);
  end;
end;

procedure TSubtract.CloseStkFiles; // Uzatvory subory FIFO, STKM a STOCK
begin
  dmSTORES.btSTOCK.Close;
  dmSTORES.btSTKM.Close;
  dmSTORES.btFIFO.Close;
end;

procedure TSubtract.Error (pErrCode:word);  // UloûÌ chybovÈ hl·senie do s˙boru
var mTx: TStrings;
begin
  mTx := TStringList.Create;
  mTx.Add (gvSys.LoginName+' '+DateTimeToStr(Now)+' PLU='+StrInt(oGsData.GsCode,0)+' ERR='+StrInt(pErrCode,0));
  mTx.SaveToFile (gPath.SysPath+'STKERR.LOG');
  mTx.Free;
end;

procedure TSubtract.Abort (pAbortCode:word);
begin
  BtrAbortTrans;  // ZruöÌme tranzakciu Btrievu
  oAbortCode := pAbortCode;
  Error (pAbortCode);
end;

procedure TSubtract.ClearOutFifos; // Vymazanie ˙dajov Fifo na odpocet
var I:word;
begin
  If oOutFifos.Count>0 then begin
    For I:=0 to (oOutFifos.Count-1) do begin
      oOutFifoData := oOutFifos.Items[I];
      Dispose(oOutFifoData);
    end;
  end;
end;

procedure TSubtract.AddToOutFifos (pFifoNum,pActPos:longint; pOutQnt,pOutPrice:double);  // Prid· z·znam do zoznamu Fifo kariet, ktorÈ bud˙ vydanÈ zo skladu
begin
  New (oOutFifoData);
  oOutFifoData^.FifoNum := pFifoNum;
  oOutFifoData^.ActPos := pActPos;
  oOutFifoData^.OutQnt := pOutQnt;
  oOutFifoData^.OutPrice := pOutPrice;
  oOutFifos.Add (oOutFifoData);
end;

procedure TSubtract.ClearGsData;  // Vymazanie ˙dajov z vyrovn·vacej pam‰te - treba vykonaù pred zad·vanÌm novÈho tovaru
begin
  FillChar (oGsData,SizeOf(TGsData),#0);
end;

procedure TSubtract.PutWriNum (pValue:word); // Prev·dzkov· jednotka - sklad
begin
  oGsData.WriNum := pValue;
end;

procedure TSubtract.PutDocNum (pValue:Str12); // »Ìslo skladovÈho dokladu
begin
  oGsData.DocNum := pValue;
end;

procedure TSubtract.PutItmNum (pValue:word); // PoradovÈ ËÌslo poloûky na skladovom doklade
begin
  oGsData.ItmNum := pValue;
end;

procedure TSubtract.PutMgCode (pValue:word); // »Ìslo tovarovej skupiny
begin
  oGsData.MgCode := pValue;
end;

procedure TSubtract.PutGsCode (pValue:longint); // TovarovÈ ËÌslo
begin
  oGsData.GsCode := pValue;
end;

procedure TSubtract.PutGsName (pValue:Str30); // N·zov tovaru
begin
  oGsData.GsName := pValue;
end;

procedure TSubtract.PutBarCode (pValue:Str15); // IdentifikaËn˝ kÛd tovaru
begin
  oGsData.BarCode := pValue;
end;

procedure TSubtract.PutStCode (pValue:Str15); // Skladov˝ kÛd tovaru
begin
  oGsData.StCode := pValue;
end;

procedure TSubtract.PutDocDate (pValue:TDateTime); // D·tum skladovÈho dokladu
begin
  oGsData.DocDate := pValue;
end;

procedure TSubtract.PutDrbDate (pValue:TDateTime); // D·tum z·ruky
begin
  oGsData.DrbDate := pValue;
end;

procedure TSubtract.PutMovPrice (pValue:double); // N·kupn· cena tovaru bez DPH
begin
  If pValue=0 then begin // Dosadime poslednu nakupnu cenu tovaru
    If dmSTORES.btSTOCK.IndexName<>'GsCode' then dmSTORES.btSTOCK.IndexName:='GsCode';
    If dmSTORES.btSTOCK.FindKey ([oGsData.GsCode]) then oGsData.MovPrice := dmSTORES.btSTOCK.FieldByName ('LastPrice').AsFloat;
  end
  else oGsData.MovPrice := pValue;
end;

procedure TSubtract.PutMovQnt (pValue:double); // Mnoûstvo ktorÈ treba prijaù(+) alebo vydaù(-)
begin
  oGsData.MovQnt := pValue;
end;

procedure TSubtract.PutOrdDocNum (pValue:Str12); // »Ìslo doölej objedn·vky
begin
  oGsData.OrdDocNum := pValue;
end;

procedure TSubtract.PutOrdItmNum (pValue:word); // PoradovÈ ËÌslo poloûky na objedn·vke
begin
  oGsData.OrdItmNum := pValue;
end;

procedure TSubtract.PutPaPCode (pValue:longint); // Prvotn˝ kÛd dod·vateæa
begin
  oGsData.PaPCode := pValue;
end;

procedure TSubtract.PutPaSCode (pValue:word); // Druhotn˝ kÛd dod·vateæa
begin
  oGsData.PaSCode := pValue;
end;

procedure TSubtract.PutSmCode (pValue:word); // KÛd skladovÈho pohybu
begin
  oGsData.SmCode := pValue;
end;

procedure TSubtract.PutSmSign (pValue:Str1); // Znak skladovÈho pohybu
begin
  oGsData.SmSign := pValue;
end;

procedure TSubtract.PutFifoNum (pValue:longint);  // Poradove cislo FIFO karty
begin
  oGsData.FifoNum := pValue;
end;

procedure TSubtract.AnalyzeFifo; // Analyzuje Fifo karty a zisti, ûe koæko Fifo kariet bude treba pouûiù na danÈ mnoûstvo v˝daja
var mMovQnt: double;
begin
  oOutFifos.Clear;
  dmSTORES.btFIFO.SwapStatus;
  dmSTORES.btFIFO.IndexName := 'GsCode';
  If dmSTORES.btFIFO.Locate ('GsCode',VarArrayOf([oGsData.GsCode]),[]) then begin
    mMovQnt := Abs(oGsData.MovQnt);
    Repeat
      If dmSTORES.btFIFO.FieldByName ('ActQnt').AsFloat>0 then begin
        If dmSTORES.btFIFO.FieldByName ('ActQnt').AsFloat<mMovQnt then begin
          // Bude to z viacer˝ch kariet
          AddToOutFifos (dmSTORES.btFIFO.FieldByName ('FifoNum').AsInteger,dmSTORES.btFIFO.ActPos,dmSTORES.btFIFO.FieldByName ('ActQnt').AsFloat,dmSTORES.btFIFO.FieldByName ('InPrice').AsFloat);
          mMovQnt := mMovQnt-dmSTORES.btFIFO.FieldByName ('ActQnt').AsFloat;
        end
        else begin
          AddToOutFifos (dmSTORES.btFIFO.FieldByName ('FifoNum').AsInteger,dmSTORES.btFIFO.ActPos,mMovQnt,dmSTORES.btFIFO.FieldByName ('InPrice').AsFloat);
          mMovQnt := 0;
        end;
      end;
      dmSTORES.btFIFO.Next;
    until Equal(mMovQnt,0,3) or (dmSTORES.btFIFO.Eof) or (dmSTORES.btFIFO.FieldByName('GsCode').Asinteger<>oGsData.GsCode)
  end;
  dmSTORES.btFIFO.RestoreStatus;
end;

procedure TSubtract.PutOutQnt (pIndex:word;pValue:double);
begin
  oOutFifoData := oOutFifos.Items[pIndex-1];
  oOutFifoData^.OutQnt := pValue;
end;

procedure TSubtract.AddToFifo;
begin
  // UrËÌme nasleduj˙ce FifoNum
  dmSTORES.btFIFO.SwapStatus;
  dmSTORES.btFIFO.IndexName := 'FifoNum';
  dmSTORES.btFIFO.Last;
  oGsData.FifoNum := dmSTORES.btFIFO.FieldByName ('FifoNum').AsInteger+1;
  dmSTORES.btFIFO.RestoreStatus;
  // Prid·me poloûku do FIFO
  dmSTORES.btFIFO.Insert;
  dmSTORES.btFIFO.FieldByName ('WriNum').AsInteger := oGsData.WriNum;
  dmSTORES.btFIFO.FieldByName ('FifoNum').AsInteger := oGsData.FifoNum;
  dmSTORES.btFIFO.FieldByName ('DocNum').AsString := oGsData.DocNum;
  dmSTORES.btFIFO.FieldByName ('ItmNum').AsInteger := oGsData.ItmNum;
  dmSTORES.btFIFO.FieldByName ('MgCode').AsInteger := oGsData.MgCode;
  dmSTORES.btFIFO.FieldByName ('GsCode').AsInteger := oGsData.GsCode;
  dmSTORES.btFIFO.FieldByName ('GsName').AsString := oGsData.GsName;
  dmSTORES.btFIFO.FieldByName ('BarCode').AsString := oGsData.BarCode;
  dmSTORES.btFIFO.FieldByName ('StCode').AsString := oGsData.StCode;
  dmSTORES.btFIFO.FieldByName ('DocDate').AsDateTime := oGsData.DocDate;
  dmSTORES.btFIFO.FieldByName ('DrbDate').AsDateTime := oGsData.DrbDate;
  dmSTORES.btFIFO.FieldByName ('InPrice').AsFloat := oGsData.MovPrice;
  dmSTORES.btFIFO.FieldByName ('InQnt').AsFloat := oGsData.MovQnt;
  dmSTORES.btFIFO.FieldByName ('OutQnt').AsFloat := 0;
  dmSTORES.btFIFO.FieldByName ('ActQnt').AsFloat := oGsData.MovQnt;
  dmSTORES.btFIFO.FieldByName ('OrdDocNum').AsString := oGsData.OrdDocNum;
  dmSTORES.btFIFO.FieldByName ('OrdItmNum').AsInteger := oGsData.OrdItmNum;
  dmSTORES.btFIFO.FieldByName ('PaPCode').AsInteger := oGsData.PaPCode;
  dmSTORES.btFIFO.FieldByName ('PaSCode').AsInteger := oGsData.PaSCode;
  dmSTORES.btFIFO.Post;
end;

procedure TSubtract.AddToStkm;
var mNextStmNum: longint;
begin
  // UrËÌme nasleduj˙ci StmNum
  dmSTORES.btSTKM.SwapStatus;
  dmSTORES.btSTKM.IndexName := 'StmNum';
  dmSTORES.btSTKM.Last;
  mNextStmNum := dmSTORES.btSTKM.FieldByName ('StmNum').AsInteger+1;
  dmSTORES.btSTKM.RestoreStatus;
  // Prid·me poloûku do FIFO
  dmSTORES.btSTKM.Insert;
  dmSTORES.btSTKM.FieldByName ('WriNum').AsInteger := oGsData.WriNum;
  dmSTORES.btSTKM.FieldByName ('StmNum').AsInteger := mNextStmNum;
  dmSTORES.btSTKM.FieldByName ('DocDate').AsDateTime := oGsData.DocDate;
  dmSTORES.btSTKM.FieldByName ('SmCode').AsInteger := oGsData.SmCode;
  dmSTORES.btSTKM.FieldByName ('SmSign').AsString := oGsData.SmSign;
  dmSTORES.btSTKM.FieldByName ('MgCode').AsInteger := oGsData.MgCode;
  dmSTORES.btSTKM.FieldByName ('GsCode').AsInteger := oGsData.GsCode;
  dmSTORES.btSTKM.FieldByName ('GsName').AsString := oGsData.GsName;
  dmSTORES.btSTKM.FieldByName ('BarCode').AsString := oGsData.BarCode;
  dmSTORES.btSTKM.FieldByName ('StCode').AsString := oGsData.StCode;
  dmSTORES.btSTKM.FieldByName ('DocNum').AsString := oGsData.DocNum;
  dmSTORES.btSTKM.FieldByName ('ItmNum').AsInteger := oGsData.ItmNum;
  dmSTORES.btSTKM.FieldByName ('FifoNum').AsInteger := oGsData.FifoNum;
  If oGsData.SmSign='+' then begin
    dmSTORES.btSTKM.FieldByName ('MovQnt').AsFloat := oGsData.MovQnt;
    dmSTORES.btSTKM.FieldByName ('MovVal').AsFloat := oGsData.MovPrice*oGsData.MovQnt;
  end
  else begin
    dmSTORES.btSTKM.FieldByName ('MovQnt').AsFloat := oGsData.MovQnt*(-1);
    dmSTORES.btSTKM.FieldByName ('MovVal').AsFloat := oGsData.MovPrice*oGsData.MovQnt*(-1);
  end;
  dmSTORES.btSTKM.FieldByName ('Status').AsString := 'N';
  dmSTORES.btSTKM.FieldByName ('DrbDate').AsDateTime := oGsData.DrbDate;
  dmSTORES.btSTKM.FieldByName ('OrdDocNum').AsString := oGsData.OrdDocNum;
  dmSTORES.btSTKM.FieldByName ('OrdItmNum').AsInteger := oGsData.OrdItmNum;
  dmSTORES.btSTKM.FieldByName ('PaPCode').AsInteger := oGsData.PaPCode;
  dmSTORES.btSTKM.FieldByName ('PaSCode').AsInteger := oGsData.PaSCode;
  dmSTORES.btSTKM.Post;
end;

procedure TSubtract.InToStock;
begin
  If dmSTORES.btSTOCK.IndexName<>'GsCode' then dmSTORES.btSTOCK.IndexName:='GsCode';
  If dmSTORES.btSTOCK.FindKey ([oGsData.GsCode]) then begin
    If dmSTORES.btSTOCK.FieldByName('GsCode').AsInteger=oGsData.GsCode then begin
      dmSTORES.btSTOCK.Edit;
      dmSTORES.btSTOCK.FieldByName ('InQnt').AsFloat := dmSTORES.btSTOCK.FieldByName ('InQnt').AsFloat+oGsData.MovQnt;
      dmSTORES.btSTOCK.FieldByName ('ActQnt').AsFloat := dmSTORES.btSTOCK.FieldByName ('InQnt').AsFloat-dmSTORES.btSTOCK.FieldByName ('OutQnt').AsFloat;
      dmSTORES.btSTOCK.FieldByName ('FreeQnt').AsFloat := dmSTORES.btSTOCK.FieldByName ('ActQnt').AsFloat-dmSTORES.btSTOCK.FieldByName ('SalQnt').AsFloat-dmSTORES.btSTOCK.FieldByName ('ResQnt').AsFloat;
      dmSTORES.btSTOCK.FieldByName ('InVal').AsFloat := dmSTORES.btSTOCK.FieldByName ('InVal').AsFloat+oGsData.MovQnt*oGsData.MovPrice;
      dmSTORES.btSTOCK.FieldByName ('ActVal').AsFloat := dmSTORES.btSTOCK.FieldByName ('IvQnt').AsFloat+dmSTORES.btSTOCK.FieldByName ('InVal').AsFloat-dmSTORES.btSTOCK.FieldByName ('OutVal').AsFloat;
      If Rd2(dmSTORES.btSTOCK.FieldByName ('ActQnt').AsFloat)>0
        then dmSTORES.btSTOCK.FieldByName ('AvgPrice').AsFloat := Rd2(dmSTORES.btSTOCK.FieldByName ('ActVal').AsFloat/dmSTORES.btSTOCK.FieldByName ('ActQnt').AsFloat);
      dmSTORES.btSTOCK.Post;
    end
    else Abort (cInconsistentIndexInStock);
  end
  else begin // Neexistuje skladova karta preto treba vytvorit
    dmSTORES.btSTOCK.Insert;
    dmSTORES.btSTOCK.FieldByName ('WriNum').AsInteger := oGsData.WriNum;
    dmSTORES.btSTOCK.FieldByName ('GsCode').AsInteger := oGsData.GsCode;
    dmSTORES.btSTOCK.FieldByName ('MgCode').AsInteger := oGsData.MgCode;
    dmSTORES.btSTOCK.FieldByName ('GsName').AsString := oGsData.GsName;
    dmSTORES.btSTOCK.FieldByName ('BarCode').AsString := oGsData.BarCode;
    dmSTORES.btSTOCK.FieldByName ('StCode').AsString := oGsData.StCode;
    dmSTORES.btSTOCK.FieldByName ('MsCode').AsInteger := oGsData.MsCode;
    dmSTORES.btSTOCK.FieldByName ('MsName').AsString := oGsData.MsName;
    dmSTORES.btSTOCK.FieldByName ('VatCode').AsInteger := oGsData.VatCode;
    dmSTORES.btSTOCK.FieldByName ('VatPrc').AsFloat := oGsData.VatCode;
    dmSTORES.btSTOCK.FieldByName ('InQnt').AsFloat := oGsData.MovQnt;
    dmSTORES.btSTOCK.FieldByName ('ActQnt').AsFloat := dmSTORES.btSTOCK.FieldByName ('InQnt').AsFloat-dmSTORES.btSTOCK.FieldByName ('OutQnt').AsFloat;
    dmSTORES.btSTOCK.FieldByName ('FreeQnt').AsFloat := dmSTORES.btSTOCK.FieldByName ('ActQnt').AsFloat-dmSTORES.btSTOCK.FieldByName ('SalQnt').AsFloat-dmSTORES.btSTOCK.FieldByName ('ResQnt').AsFloat;
    dmSTORES.btSTOCK.FieldByName ('InVal').AsFloat := oGsData.MovQnt*oGsData.MovPrice;
    dmSTORES.btSTOCK.FieldByName ('ActVal').AsFloat := dmSTORES.btSTOCK.FieldByName ('InVal').AsFloat-dmSTORES.btSTOCK.FieldByName ('OutVal').AsFloat;
    If Rd2(dmSTORES.btSTOCK.FieldByName ('ActQnt').AsFloat)>0
      then dmSTORES.btSTOCK.FieldByName ('AvgPrice').AsFloat := Rd2 (dmSTORES.btSTOCK.FieldByName ('ActVal').AsFloat/dmSTORES.btSTOCK.FieldByName ('ActQnt').AsFloat);
    dmSTORES.btSTOCK.FieldByName ('LastPrice').AsFloat := oGsData.MovPrice;
    dmSTORES.btSTOCK.FieldByName ('ActPrice').AsFloat := oGsData.MovPrice;
    dmSTORES.btSTOCK.FieldByName ('LastIDate').AsDateTime := oGsData.DocDate;
    dmSTORES.btSTOCK.FieldByName ('LastIQnt').AsFloat := oGsData.MovQnt;
    dmSTORES.btSTOCK.Post;
  end;
end;

procedure TSubtract.OutFromFifo;  // UskutoËnÌ v˝daj z FIFO kariet
var I:word;
begin
  For I:=1 to GetFifoCount do begin
    dmSTORES.btFIFO.GotoPos (GetActPos(I));
    If dmSTORES.btFIFO.FieldByName ('FifoNum').AsInteger=GetFifoNum(I) then begin
      dmSTORES.btFIFO.Edit;
      dmSTORES.btFIFO.FieldByName ('OutQnt').AsFloat := dmSTORES.btFIFO.FieldByName ('OutQnt').AsFloat+GetFifoQnt(I);
      dmSTORES.btFIFO.FieldByName ('ActQnt').AsFloat := dmSTORES.btFIFO.FieldByName ('InQnt').AsFloat-dmSTORES.btFIFO.FieldByName ('OutQnt').AsFloat;
      dmSTORES.btFIFO.Post;
    end
    else begin // FIFO karta nebola n·jden· - asi poruöeni datab·ze
      PutOutQnt (I,0);  // Vynulujeme kartu vo vyrovn·vacej pam‰ti
      Error (cIncorrectFifoActPos);
    end;
  end;
end;

procedure TSubtract.OutFromStock;
begin
  If dmSTORES.btSTOCK.IndexName<>'GsCode' then dmSTORES.btSTOCK.IndexName := 'GsCode';
  If dmSTORES.btSTOCK.FindKey ([oGsData.GsCode]) then begin
    If dmSTORES.btSTOCK.FieldByName('GsCode').AsInteger=oGsData.GsCode then begin
      dmSTORES.btSTOCK.Edit;
      dmSTORES.btSTOCK.FieldByName ('OutQnt').AsFloat := dmSTORES.btSTOCK.FieldByName ('OutQnt').AsFloat+GetOutQnt;
      dmSTORES.btSTOCK.FieldByName ('ActQnt').AsFloat := dmSTORES.btSTOCK.FieldByName ('InQnt').AsFloat-dmSTORES.btSTOCK.FieldByName ('OutQnt').AsFloat;
      dmSTORES.btSTOCK.FieldByName ('FreeQnt').AsFloat := dmSTORES.btSTOCK.FieldByName ('ActQnt').AsFloat-dmSTORES.btSTOCK.FieldByName ('SalQnt').AsFloat-dmSTORES.btSTOCK.FieldByName ('ResQnt').AsFloat;
      dmSTORES.btSTOCK.FieldByName ('OutVal').AsFloat := dmSTORES.btSTOCK.FieldByName ('OutVal').AsFloat+GetFifoValue;
      dmSTORES.btSTOCK.FieldByName ('ActVal').AsFloat := dmSTORES.btSTOCK.FieldByName ('InVal').AsFloat-dmSTORES.btSTOCK.FieldByName ('OutVal').AsFloat;
      If Rd2(dmSTORES.btSTOCK.FieldByName ('ActQnt').AsFloat)>0
        then dmSTORES.btSTOCK.FieldByName ('AvgPrice').AsFloat := Rd2 (dmSTORES.btSTOCK.FieldByName ('ActVal').AsFloat/dmSTORES.btSTOCK.FieldByName ('ActQnt').AsFloat);
      dmSTORES.btSTOCK.FieldByName ('ActPrice').AsFloat := oGsData.MovPrice;
      dmSTORES.btSTOCK.FieldByName ('LastODate').AsDateTime := oGsData.DocDate;
      dmSTORES.btSTOCK.FieldByName ('LastOQnt').AsFloat := oGsData.MovQnt;
      dmSTORES.btSTOCK.Post;
    end
    else Abort (cInconsistentIndexInStock);
  end
  else Abort (cOutGoodsNotInStock);
end;

function TSubtract.CanFullSubtract: boolean;  // TRUE ak je moûnÈ odpoËÌtaù zo skladu celÈ zadanÈ mnoûstvo
begin
end;

function TSubtract.GetFifoNum(pIndex:word): longint; // PoradovÈ ËÌslo fifo karty
begin
  oOutFifoData := oOutFifos.Items[pIndex-1];
  Result := oOutFifoData^.FifoNum;
end;

function TSubtract.GetFifoPrice(pIndex:word): double; // Je to cena na zadanej fifo karty
begin
  oOutFifoData := oOutFifos.Items[pIndex-1];
  Result := oOutFifoData^.OutPrice;
end;

function TSubtract.GetFifoQnt(pIndex:word): double; // Je to mnoûstvo na zadanej fifo karty
begin
  oOutFifoData := oOutFifos.Items[pIndex-1];
  Result := oOutFifoData^.OutQnt;
end;

function TSubtract.GetActPos(pIndex:word): longint; // Pozicia danej FIFO karty v datab8ze FIFOxxx.BTR
begin
  oOutFifoData := oOutFifos.Items[pIndex-1];
  Result := oOutFifoData^.ActPos;
end;

function TSubtract.GetFifoValue: double; // Je to hodnota v˝daja vypoËÌtanÈ z fifo kariet
var I:longint;
begin
  Result := 0;
  For I:=1 to oOutFifos.Count do
    Result := Result+GetFifoQnt(I)*GetFifoPrice (I);
end;

function TSubtract.GetInPrice: double; // Je to nakupna cena prijmu tovaru
begin
  Result := oGsData.MovPrice;
end;

function TSubtract.GetFifoCount: word; // PoËet fifo kariet, ktorÈ bud˙ pouûitÌ na dan˝ v˝daj
begin
  Result := oOutFifos.Count;
end;

function TSubtract.GetOutQnt: double;  // Mnoûstvo ktorÈ je moûnÈ vydaù zo skladu
var I:longint;
begin
  Result := 0;
  For I:=1 to oOutFifos.Count do
    Result := Result+GetFifoQnt (I);
end;

function TSubtract.GetFifoStr: string; // Hodnota funkcie je vymenovanie pouzitych Fifo kariet - tento udaj sa uklada pri poloziek skladovych dokladov
var mCnt:word;  mFifo:string;
begin
  Result := '';
  If oInput then begin
    Result := StrInt(oGsData.FifoNum,0)+'*'+StripFractZero(StrDoub(oGsData.MovQnt,0,6));
  end
  else begin
    If GetFifoCount>0 then begin
      mCnt := 0;
      Repeat
         Inc (mCnt);
         mFifo := StrInt(GetFifoNum(mCnt),0)+'*'+StripFractZero(StrDoub(GetFifoQnt(mCnt),0,6));
         If Result=''
           then Result := mFifo
           else Result := Result+','+mFifo;
      until (mCnt=GetFifoCount);
    end;
  end;
end;

function TSubtract.GetStmSumQnt (pDocNum:Str12; pItmNum:longint): double; // Hodnotou funkcie je mnozstvo, ktora uz bola odpocitana alebo pripocitan8 na sklad
begin
  Result := 0;
  dmSTORES.btSTKM.IndexName := 'DoItSt';
  If dmSTORES.btSTKM.FindKey ([pDocNum,pItmNum,'N']) then begin
    Repeat
      Result := Result+dmSTORES.btSTKM.FieldByName('MovQnt').AsFloat;
      dmSTORES.btSTKM.Next;
    until (dmSTORES.btSTKM.Eof) or (dmSTORES.btSTKM.FieldByName('DocNum').AsString<>pDocNum) or (dmSTORES.btSTKM.FieldByName('ItmNum').AsInteger<>pItmNum) or (dmSTORES.btSTKM.FieldByName('Status').AsString<>'N');
  end;
end;

end.
