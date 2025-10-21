unit PlsFnc;
{$F+}

// *****************************************************************************
//                  ZBIERKA FUNKCII NA PRACU S PREDAJNYM CENNIKOM
// *****************************************************************************
// Tento objekt obsahuje funkcie, ktoré umožnia prístup k po6iadavk8m na zmeny
// predajn7ch cien.
//
// Programové funkcia:
// ---------------
// Add - založí pre zadaneho pracovnikanovy pracovny ukol
// *****************************************************************************


interface

uses
  IcTypes, IcConv, IcTools, IcVariab, IniFiles, SysUtils, NexGlob, BtrHand, Bok, Key,
  hPLS, hPLH, hGSCAT, hABKDEF,
  NexPath, NexIni, TxtWrap, TxtCut, StkCanc, DocHand, TxtDoc, Forms;

type
  TPlsFnc = class
    constructor Create;
    destructor  Destroy; override;
    private
      oPlsNum: word; // Cislo predajneho cennika ktorym pracuje objekt
      oStkNum: word;
      oGsCode: longint;
      oAPrice: double;
      oProfit: double;
      oBPrice: double;
      oOpenGs: boolean;
      oSrcPmd: Str3;
      oChgPrc: boolean; // TRUE ak bola zmenena predajna cena tovaru
      ohGSCAT: TGscatHnd;
      ohPLH: TPlhHnd;
      function Access (pPlsNum:word):boolean;
      procedure SaveToPls;
      procedure SaveToPlh;
    public
      ohPLS: TPlsHnd;
      procedure Open(pPlsNum:word);
      procedure Del(pPlsNum,pGsCode:longint);
      procedure Add(pPlsNum,pGsCode:longint);
    published
      property StkNum:word write oStkNum;
      property APrice:double write oAPrice;
      property Profit:double write oProfit;
      property BPrice:double write oBPrice;
      property OpenGs:boolean write oOpenGs;
      property SrcPmd:Str3 write oSrcPmd;
  end;

implementation

constructor TPlsFnc.Create;
begin
  oPlsNum := 0;
  ohGSCAT := TGscatHnd.Create;  ohGSCAT.Open;
  ohPLS := TPlsHnd.Create;ohPLS.OpenPlsAdd;
  ohPLH := TPlhHnd.Create;
end;

destructor TPlsFnc.Destroy;
begin
  FreeAndNil (ohPLH);
  ohPLS.ClosePlsAdd;
  FreeAndNil (ohPLS);
  FreeAndNil (ohGSCAT);
end;

// ********************************* PRIVATE ***********************************

function TPlsFnc.Access (pPlsNum:word):boolean;
begin
  Result := TRUE;
//  gAfc.GrpNum := gvSys.LoginGroup;
//  gAfc.BookNum := StrInt(pPlsNum,0);
//  gAfc.RpcItmAdd;
end;

procedure TPlsFnc.SaveToPls;
begin
  If ohPLS.LocateGsCode(oGsCode) then begin
    ohPLS.Edit;
    ohPLS.BPrice := oBPrice;
    If IsNul(oAPrice)
      then ohPLS.APrice := Rd2(oBPrice/(1+ohPLS.VatPrc/100))
      else ohPLS.APrice := oAPrice;
  end
  else begin
    ohPLS.Insert;
    ohPLS.GsCode := oGsCode;
    ohPLS.BPrice := oBPrice;
    If ohGSCAT.LocateGsCode(oGsCode) then begin
      BTR_To_BTR (ohGSCAT.BtrTable,ohPLS.BtrTable);
      If IsNul(oAPrice)
        then ohPLS.APrice := Rd2(oBPrice/(1+ohGSCAT.VatPrc/100))
        else ohPLS.APrice := oAPrice;
    end;
  end;
  If oChgPrc then ohPLS.ChgItm := '';
  ohPLS.Post;
end;

procedure TPlsFnc.SaveToPlh;
begin
  If oChgPrc then begin  // Bola zmenena predajna cena preto ulozime zaznam do historie zmien predajnych cien
    ohPLH.Insert;
    ohPLH.GsCode := ohPLS.GsCode;
    ohPLH.OProfit := ohPLS.Profit;
    ohPLH.OAPrice := ohPLS.APrice;
    ohPLH.OBPrice := ohPLS.BPrice;
    ohPLH.NProfit := oProfit;
    ohPLH.NAPrice := oAPrice;
    ohPLH.NBPrice := oBPrice;
    ohPLH.ModPrg := oSrcPmd;
    ohPLH.Post
  end;
end;

// ********************************** PUBLIC ***********************************

procedure TPlsFnc.Open(pPlsNum:word);
begin
  If not ohPLS.Active or (oPlsNum<>pPlsNum) then begin
    oPlsNum := pPlsNum;
    ohPLS.Open(pPlsNum);
    ohPLH.Open(pPlsNum);
  end;
end;

procedure TPlsFnc.Del (pPlsNum,pGsCode:longint);
begin
end;

procedure TPlsFnc.Add (pPlsNum,pGsCode:longint);
begin
  If Access(pPlsNum) then begin // Nasli sme knihy pracovnych ukolov uzivatela komu chcema zalozit novy ukol
    oPlsNum := pPlsNum;
    oGsCode := pGsCode;
    Open(pPlsNum);
    If ohPLS.LocateGsCode(oGsCode) then oChgPrc := not Eq2(ohPLS.BPrice,oBPrice);
    try BtrBegTrans;
      SaveToPlh; // Ulozi zmeny do historie zmeny PC
      SaveToPls; // Ulozi zmeny do cennika
    BtrEndTrans;
    except BtrAbortTrans; end;
  end;
end;

end.
