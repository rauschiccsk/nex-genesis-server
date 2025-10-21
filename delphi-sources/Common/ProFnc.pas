unit ProFnc;
{$F+}
// *****************************************************************************
// **********               DATAB¡ZOV… S⁄BORY PRODUKTU                **********
// *****************************************************************************
interface

uses
  Key,
  IcTypes, IcConv, IcTools, IcVariab, SysUtils, Forms, NexClc, NexIni, ParCat, AgmFnc,
  hPROCAT, hPROCOD, hPLCLST, hSTCLST, hAPCLST, hFGDLST, hFGRLST;

type
  TProFnc=class
    constructor Create;
    destructor Destroy; override;
  private
    // ObchodnÈ inform·cie
    oPlsApc:double;
    oPlsBpc:double;
    oAplApc:double;
    oAplBpc:double;
    oAplPrq:word;
    oPadApc:double;
    oPadBpc:double;
    oFgdApc:double;
    oFgdBpc:double;
    oAgrApc:double;
    oAgrBpc:double;
    oMinApc:double;
    oMinBpc:double;
    oSalApc:double;
    oSalBpc:double;
    oSapSrc:Str2;
    oSapSrt:Str50;
    oAvgApc:double;
    oLasApc:double;
    oStkApc:double;
    // SkladovÈ inform·cie
    oActPrq:double;
    oFrePrq:double;
    oOsdPrq:double;
    oRstPrq:double;
    oRosPrq:double;
    // KatalÛgovÈ inform·cie
    function GetProNum:longint;
    function GetProNam:Str60;
    function GetEcrNam:Str30;
    function GetPgrNum:word;
    function GetFgrNum:word;
    function GetSgrNum:word;
    function GetBarCod:Str15;
    function GetSubCnt:byte;
    function GetStkCod:Str15;
    function GetOrdCod:Str30;
    function GetShpCod:Str30;
    function GetBasPro:longint;
    function GetPckPro:longint;
    function GetMsuNam:Str10;
    function GetMsbNam:Str5;
    function GetMsbPrq:double;
    function GetProVol:double;
    function GetProWgh:double;
    function GetVatPrc:byte;
    function GetBoxPrq:word;
    function GetBoxVol:double;
    function GetBoxWgh:double;
    function GetPalBoq:word;
    function GetProTyp:Str1;
    function GetMsnMus:boolean;
    function GetMbaMus:boolean;
    function GetGrcMth:byte;
    function GetManPac:longint;
    function GetManNam:Str10;
    function GetSupPac:longint;
    function GetShpNum:byte;
    function GetDivSta:boolean;
    function GetDisSta:boolean;
    function GetMngUsr:word;
    function GetCrtUsr:word;
    function GetCrtDte:TDatetime;
    function GetCrtTim:TDatetime;

    procedure Clear;
  public
    oPar:TParCat;
    oAgm:TAgmFnc;           // ZmluvnÈ ceny
    oParNum:longint;
    oAplNum:word;
    oSepMgc:longint; // »Ìslo tovarovej skupuny od ktorej s˙ evidovanÈ sluûby
    ohPROCAT:TProcatHnd;    // KatalÛg produktov
    ohGSCLST:TProcatHnd;    // Zoznam tovarov
    ohSVCLST:TProcatHnd;    // Zoznam sluûieb
    ohPROCOD:TProCodHnd;    // DruhotnÈ kÛdy
    ohPLCLST:TPlclstHnd;    // PredajnÈ ceny
    ohSTCLST:TStclstHnd;    // SkladovÈ karty
    ohAPCLST:TApclstHnd;    // AkciovÈ ceny
    ohFGDLST:TFgdlstHnd;    // ObchodnÈ zæavy (obchodnÈ podmienky)
    ohFGRLST:TFgrlstHnd;    // FinanËnÈ skupiny
    function LocProNum(pParNum:longint;pStkNum:word;pProNum:longint):boolean;
    function LocProCod(pParNum:longint;pStkNum:word;pProCod:Str30):boolean;    // Vyhæad·vanie podæa vöetk˝ch kÛdov
    procedure AddNewStc(pStkNum:word;pProNum:longint);
  published
//    property ParNum:longint read GetParNum write SetParNum; // KatalÛgocÈ ËÌslo partnera
//    property AplNum:word read GetAplNum write SetAplNum;    // »Ìslo aktu·lneho akciovÈho cennÌka
//    property PlsNum:word read GetPlsNum write SetPlsNum;    // »Ìslo aktu·lneho predajnÈho cennÌka
//    property StkNum:word read GetStkNum write SetStkNum;    // »Ìslo aktu·lneho skladu
    // KatalÛgovÈ inform·cie
    property ProNum:longint read GetProNum;   // ProduktovÈ ËÌslo
    property ProNam:Str60 read GetProNam;     // N·zov produktu
    property EcrNam:Str30 read GetEcrNam;     // N·zov pre ERP
    property PgrNum:word read GetPgrNum;      // »Ìslo produktovej skupiny
    property FgrNum:word read GetFgrNum;      // »Ìslo finanËnej skupina
    property SgrNum:word read GetSgrNum;      // »Ìslo obchodnej skupiny (pre internetov˝ obchod)
    property BarCod:Str15 read GetBarCod;     // Prvotn˝ identifikaËn˝ kÛd produktu
    property SubCnt:byte read GetSubCnt;      // PoËet druhotn˝ch identifikaËn˝ch kÛdov
    property StkCod:Str15 read GetStkCod;     // Skladov˝ kÛd produktu
    property OrdCod:Str30 read GetOrdCod;     // Objedn·vkov˝ kÛd produktu
    property ShpCod:Str30 read GetShpCod;     // Obchodn˝ kÛd pre Eshop
    property BasPro:longint read GetBasPro;   // Z·kladn˝ produkt
    property PckPro:longint read GetPckPro;   // Priraden˝ obal
    property MsuNam:Str10 read GetMsuNam;     // Merna jednotka produktu
    property MsbNam:Str5 read GetMsbNam;      // Z·kladn· jednotka produktu
    property MsbPrq:double read GetMsbPrq;    // Mnoûstvo produktu (MJ) v z·kladnej jednotke
    property ProVol:double read GetProVol;    // Objem tovaru (mnoûstvo MJ na 1 m3)
    property ProWgh:double read GetProWgh;    // V·ha produktu (kg)
    property BoxPrq:word read GetBoxPrq;      // Mnoûstvo produktu v krabicovom balenÌ (ks)
    property BoxVol:double read GetBoxVol;    // Objem krabicovÈho balenia (m3)
    property BoxWgh:double read GetBoxWgh;    // V·ha krabicovÈho balenia (kg)
    property PalBoq:word read GetPalBoq;      // PoËet krabÌc na palete (ks)
    property VatPrc:byte read GetVatPrc;      // Percentu·lna sadzba DPH
    property ProTyp:Str1 read GetProTyp;      // TypovÈ oznaËenie produktu  (T-tovar,W-v·hovy tovar,O-obal,S-sluûba)
    property MsnMus:boolean read GetMsnMus;   // Povinn· evidencia v˝robn˝ch ËÌsiel
    property MbaMus:boolean read GetMbaMus;   // Povinn· evidencia v˝robnej öarûe
    property GrcMth:byte read GetGrcMth;      // Z·ruËn· doba produktu (poËet mesiacov)
    property ManPac:longint read GetManPac;   // KatalÛgovÈ ËÌslo v˝robcu produktu
    property ManNam:Str10 read GetManNam;     // Skr·ten˝ n·zov v˝robcu produktu
    property SupPac:longint read GetSupPac;   // KatalÛgovÈ ËÌslo prioritnÈho dod·vateæa produktu
    property ShpNum:byte read GetShpNum;      // »Ìslo Eshopu do ktorÈho patrÌ produkt
    property DivSta:boolean read GetDivSta;   // Deliteænosù produktu (v˝daj na desatinnÈ mnoûstvo)
    property DisSta:boolean read GetDisSta;   // PrÌznak vyradenia produktu (uû sa neobjedn·va len vypred·va sa)
    property MngUsr:word read GetMngUsr;      // KÛd uûÌvateæa, ktor˝ spravuje dan˙ produktov˙ kartu
    property CrtUsr:word read GetCrtUsr;      // KÛd uûÌvateæa, ktor˝  zaloûil dan˙ produktov˙ kartu
    property CrtDte:TDatetime read GetCrtDte; // D·tum zaloûenia produktovej karty
    property CrtTim:TDatetime read GetCrtTim; // »as zaloûenia produktovej karty
    // ObchodnÈ inform·cie
    property PlsApc:double read oPlsApc;      // Jednotkov· cena bDPH - cennÌkov· cena (PC)
    property PlsBpc:double read oPlsBpc;      // Jednotkov· cena sDPH - cennÌkov· cena (PC)
    property AplApc:double read oAplApc;      // Jednotkov· cena bDPH - akciov· cena (AC)
    property AplBpc:double read oAplBpc;      // Jednotkov· cena sDPH - akciov· cena (AC)
    property AplPrq:word read oAplPrq;        // Mnoûstvo pre ktorÈ platÌ akciov· cena
    property PadApc:double read oPadApc;      // Jednotkov· cena bDPH - firemn· cena (FC)
    property PadBpc:double read oPadBpc;      // Jednotkov· cena sDPH - firemn· cena (FC)
    property FgdApc:double read oFgdApc;      // Jednotkov· cena bDPH - obchodn· cena (OC)
    property FgdBpc:double read oFgdBpc;      // Jednotkov· cena sDPH - obchodn· cena (OC)
    property AgrApc:double read oAgrApc;      // Jednotkov· cena bDPH - zmluvn· cena (ZC)
    property AgrBpc:double read oAgrBpc;      // Jednotkov· cena sDPH - zmluvn· cena (ZC)
    property MinApc:double read oMinApc;      // Jednotkov· cena bDPH - minim·lna cena (MC)
    property MinBpc:double read oMinBpc;      // Jednotkov· cena sDPH - minim·lna cena (MC)
    property SalApc:double read oSalApc write oSalApc;      // Jednotkov· cena bDPH - cena pre z·kaznÌka
    property SalBpc:double read oSalBpc write oSalBpc;      // Jednotkov· cena sDPH - cena pre z·kaznÌka
    property SapSrc:Str2 read oSapSrc;        // Zdroj predajnej ceny (AC-akcia;ZC-zmluva;DC-diskontn·;PA-firemn·;PC-cennÌkov·)
    property SapSrt:Str50 read oSapSrt;       // TextovÈ pomenovanie zdroja predajnej ceny
    // SkladovÈ inform·cie
    property ActPrq:double read oActPrq;      // Mnoûstvo aktu·lnej skladovej z·soby
    property FrePrq:double read oFrePrq;      // VolnÈ mnoûstvo na predaj
    property OsdPrq:double read oOsdPrq;      // ObjednanÈ mnoûstvo od dod·vateæa
    property RstPrq:double read oRstPrq;      // RezervovanÈ mnoûstvo zo z·soby (na z·kazk·ch)
    property RosPrq:double read oRosPrq;      // RezervovanÈ mnoûstvo z objedn·vky (na z·kazk·ch)
    property AvgApc:double read oAvgApc;      // Priemern· n·kupn· cena tovaru
    property LasApc:double read oLasApc;      // Posledn· n·kupn· cena tovaru
    property StkApc:double read oStkApc;      // Priemern· alebo posledn· n·kupn· cena - podæa nastaveniea
  end;

implementation

constructor TProFnc.Create;
begin
  oPar:=TParCat.Create;
  oAgm:=TAgmFnc.Create;
  oSepMgc:=gIni.GetServiceMg;
  ohPROCAT:=TProcatHnd.Create;
  ohGSCLST:=TProcatHnd.Create;
  ohSVCLST:=TProcatHnd.Create;
  ohPROCOD:=TProcodHnd.Create;
//  ohPROGRP:=TProgrpHnd.Create;
  ohPLCLST:=TPlclstHnd.Create;
  ohSTCLST:=TStclstHnd.Create;
  ohAPCLST:=TApclstHnd.Create;
  ohFGDLST:=TFgdlstHnd.Create;
  ohFGRLST:=TFgrlstHnd.Create;
end;

destructor TProFnc.Destroy;
begin
  FreeAndNil(oPar);
  FreeAndNil(oAgm);
  FreeAndNil(ohFGRLST);
  FreeAndNil(ohFGDLST);
  FreeAndNil(ohAPCLST);
  FreeAndNil(ohSTCLST);
  FreeAndNil(ohPLCLST);
//  FreeAndnil(ohPROGRP);
  FreeAndnil(ohPROCOD);
  FreeAndnil(ohSVCLST);
  FreeAndnil(ohGSCLST);
  FreeAndnil(ohPROCAT);
end;

// ********************************* PRIVATE ***********************************

function TProFnc.GetProNum:longint;
begin
  Result:=ohPROCAT.ProNum;
end;

function TProFnc.GetProNam:Str60;
begin
  Result:=ohPROCAT.ProNam;
end;

function TProFnc.GetEcrNam:Str30;
begin
  Result:=ohPROCAT.EcrNam;
end;

function TProFnc.GetPgrNum:word;
begin
  Result:=ohPROCAT.PgrNum;
end;

function TProFnc.GetFgrNum:word;
begin
  Result:=ohPROCAT.FgrNum;
end;

function TProFnc.GetSgrNum:word;
begin
  Result:=ohPROCAT.SgrNum;
end;

function TProFnc.GetBarCod:Str15;
begin
  Result:=ohPROCAT.BarCod;
end;

function TProFnc.GetSubCnt:byte;
begin
  Result:=ohPROCAT.SubCnt;
end;

function TProFnc.GetStkCod:Str15;
begin
  Result:=ohPROCAT.StkCod;
end;

function TProFnc.GetOrdCod:Str30;
begin
  Result:=ohPROCAT.OrdCod;
end;

function TProFnc.GetShpCod:Str30;
begin
  Result:=ohPROCAT.ShpCod;
end;

function TProFnc.GetBasPro:longint;
begin
  Result:=ohPROCAT.BasPro;
end;

function TProFnc.GetPckPro:longint;
begin
  Result:=ohPROCAT.PckPro;
end;

function TProFnc.GetMsuNam:Str10;
begin
  Result:=ohPROCAT.MsuNam;
end;

function TProFnc.GetMsbNam:Str5;
begin
  Result:=ohPROCAT.MsbNam;
end;

function TProFnc.GetMsbPrq:double;
begin
  Result:=ohPROCAT.MsbPrq;
end;

function TProFnc.GetProVol:double;
begin
  Result:=ohPROCAT.ProVol;
end;

function TProFnc.GetProWgh:double;
begin
  Result:=ohPROCAT.ProWgh;
end;

function TProFnc.GetVatPrc:byte;
begin
  Result:=ohPROCAT.VatPrc;
end;

function TProFnc.GetBoxPrq:word;
begin
  Result:=ohPROCAT.BoxPrq;
end;

function TProFnc.GetBoxVol:double;
begin
  Result:=ohPROCAT.BoxVol;
end;

function TProFnc.GetBoxWgh:double;
begin
  Result:=ohPROCAT.BoxWgh;
end;

function TProFnc.GetPalBoq:word;
begin
  Result:=ohPROCAT.PalBoq;
end;

function TProFnc.GetProTyp:Str1;
begin
  Result:=ohPROCAT.ProTyp;
  If ohPROCAT.PgrNum>=oSepMgc then Result:='S';
end;

function TProFnc.GetMsnMus:boolean;
begin
  Result:=ohPROCAT.MsnMus;
end;

function TProFnc.GetMbaMus:boolean;
begin
  Result:=ohPROCAT.MbaMus;
end;

function TProFnc.GetGrcMth:byte;
begin
  Result:=ohPROCAT.GrcMth;
end;

function TProFnc.GetManPac:longint;
begin
  Result:=ohPROCAT.ManPac;
end;

function TProFnc.GetManNam:Str10;
begin
  Result:=ohPROCAT.ManNam;
end;

function TProFnc.GetSupPac:longint;
begin
  Result:=ohPROCAT.SupPac;
end;

function TProFnc.GetShpNum:byte;
begin
  Result:=ohPROCAT.ShpNum;
end;

function TProFnc.GetDivSta:boolean;
begin
  Result:=ohPROCAT.DivSta;
end;

function TProFnc.GetDisSta:boolean;
begin
  Result:=ohPROCAT.DisSta;
end;

function TProFnc.GetMngUsr:word;
begin
  Result:=ohPROCAT.MngUsr;
end;

function TProFnc.GetCrtUsr:word;
begin
  Result:=ohPROCAT.CrtUsr;
end;

function TProFnc.GetCrtDte:TDatetime;
begin
  Result:=ohPROCAT.CrtDte;
end;

function TProFnc.GetCrtTim:TDatetime;
begin
  Result:=ohPROCAT.CrtTim;
end;

procedure TProFnc.Clear;
begin
  // ObchodnÈ inform·cie
  oPlsApc:=0;  oPlsBpc:=0;
  oAplApc:=0;  oAplBpc:=0;  oAplPrq:=0;
  oPadApc:=0;  oPadBpc:=0;
  oFgdApc:=0;  oFgdBpc:=0;
  oAgrApc:=0;  oAgrBpc:=0;
  oMinApc:=0;  oMinBpc:=0;
  oSalApc:=0;  oSalBpc:=0;  oSapSrc:='';
  // SkladovÈ inform·cie
  oActPrq:=0;  oFrePrq:=0;
  oOsdPrq:=0;  oRstPrq:=0;  oRosPrq:=0;
  oAvgApc:=0;  oLasApc:=0;
end;

// ********************************** PUBLIC ***********************************

function TProFnc.LocProNum(pParNum:longint;pStkNum:word;pProNum:longint):boolean;
var mDscPrc,mMinPrf:double;  mStkNum:word;
begin
  Clear;
  ohPROCAT.SwapIndex;
//  ohSTCLST.SwapIndex;
//  ohPLCLST.SwapIndex;
  ohAPCLST.SwapIndex;
  Result:=ohPROCAT.LocProNum(pProNum);
  If Result then begin
    // CennÌkov· cena
    If ohPLCLST.LocProNum(oPar.PlsNum[pParNum],pProNum) then begin
      oSapSrc:='PC';  oSapSrt:='CennÌkov· cena';
      oPlsApc:=ohPLCLST.PlsApc;
      oPlsBpc:=ohPLCLST.PlsBpc;
      oSalApc:=oPlsApc;
      oSalBpc:=oPlsBpc;
      // Akciov· cena
      If (ohAPCLST.LocProNum(oPar.AplNum[pParNum],pProNum)) and InDateInterval(ohAPCLST.BegDte,ohAPCLST.EndDte,Date) then begin // TODO Treba to prerobiù aby d·tumov˝ interval kontroloval podæa d·tumu dokladu
        oAplApc:=ohAPCLST.ApsApc;
        oAplBpc:=ohAPCLST.ApsBpc;
        If IsNotNul(oAplBpc) and (oAplBpc<oSalBpc) then begin
          oSapSrc:='AC';  oSapSrt:='Akciov· cena';
          oSalApc:=oAplApc;
          oSalBpc:=oAplBpc;
        end;
      end;
      // Firemn· zæava
      mDscPrc:=oPar.DscPrc[pParNum];
      If IsNotNul(mDscPrc) then begin
        oPadApc:=ClcAvaDsc(oPlsApc,mDscPrc);
        oPadBpc:=ClcBvaVat(oPadApc,VatPrc);
        If IsNotNul(oPadBpc) and (oPadBpc<oSalBpc) then begin
          oSapSrc:='FC';  oSapSrt:='Firemn· cena';
          oSalApc:=oPadApc;
          oSalBpc:=oPadBpc;
        end;
      end;
      // Sortimentn· zæava
      If ohFGDLST.LocPnFn(pParNum,ohPROCAT.FgrNum) then begin
        If IsNotNul(ohFGDLST.DscPrc) then begin
          oFgdApc:=ClcAvaDsc(oPlsApc,ohFGDLST.DscPrc);
          oFgdBpc:=ClcBvaVat(oFgdApc,VatPrc);
          If IsNotNul(oFgdBpc) and (oFgdBpc<oSalBpc) then begin
            oSapSrc:='OC';  oSapSrt:='Obchodn· cena';
            oSalApc:=oFgdApc;
            oSalBpc:=oFgdBpc;
          end;
        end;
      end;
      // Zmluvn· cena
      oAgrApc:=oAgm.GetAgcApc(pProNum,pParNum,'',Date);
      oAgrBpc:=oAgm.GetAgcBpc(pProNum,pParNum,'',Date);
      If IsNotNul(oAgrBpc) and (oAgrBpc<oSalBpc) then begin
        oSapSrc:='ZC';  oSapSrt:='Zmluvn· cena';
        oSalApc:=oAgrApc;
        oSalBpc:=oAgrBpc;
      end;
      // ⁄daje zo skladovej karty z·sob
      If gKey.Whs.MpcStk=1
        then mStkNum:=pStkNum
        else mStkNum:=gKey.Stk.MaiStk;
      If ohSTCLST.LocSnPn(mStkNum,pProNum) then begin
        oActPrq:=ohSTCLST.ActPrq;
        oFrePrq:=ohSTCLST.FrePrq;
        oOsdPrq:=ohSTCLST.OsdPrq;
        oRstPrq:=ohSTCLST.RstPrq;
        oRosPrq:=ohSTCLST.RosPrq;
        oAvgApc:=ohSTCLST.AvgApc;
        oLasApc:=ohSTCLST.LasApc;
        If gKey.Whs.MpcCpc=1
          then oStkApc:=oAvgApc
          else oStkApc:=oLasApc;
        // Minim·lna cena
        If gKey.Whs.MpcAct then begin
          mMinPrf:=gKey.Whs.MinPrf;
          If ohFGRLST.LocFgrNum(ohPROCAT.FgrNum) then mMinPrf:=ohFGRLST.MinPrf;
          oMinApc:=ClcAvaPrf(oStkApc,mMinPrf);
          oMinBpc:=ClcBvaVat(oMinApc,VatPrc);
          If oSalApc<oMinApc then begin
            If (oSapSrc<>'AC') or (not gKey.Whs.MpcApc and (oSapSrc='AC')) then begin
              oSapSrc:='MC';  oSapSrt:='Minim·lna cena';
              oSalApc:=oMinApc;
              oSalBpc:=ClcBvaVat(oSalApc,VatPrc);
            end;
          end;
        end;
      end;
    end; // RZ v20.09  else Result:=FALSE;
  end;
  ohAPCLST.RestIndex;
//  ohPLCLST.RestIndex;
//  ohSTCLST.RestIndex;
  ohPROCAT.RestIndex;
end;

function TProFnc.LocProCod(pParNum:longint;pStkNum:word;pProCod:Str30):boolean;    // Vyhæad·vanie podæa vöetk˝ch kÛdov
begin
  Result:=FALSE;
  If (pProCod[1]='.') or (pProCod[1]=',') then begin
    Delete(pProCod,1,1);
    Result:=ohPROCAT.LocProNum(ValInt(pProCod));
  end else begin
    Result:=ohPROCAT.LocShpCod(pProCod);
    If not Result then Result:=ohPROCAT.LocOrdCod(pProCod);
    If not Result then Result:=ohPROCAT.LocBarCod(pProCod);
  end;
end;

procedure TProFnc.AddNewStc(pStkNum:word;pProNum:longint);
begin
  If ohPROCAT.LocProNum(pProNum) then begin
    If not ohSTCLST.LocSnPn(pStkNum,pProNum) then begin
      ohSTCLST.Insert;
      ohSTCLST.ProNum:=ohPROCAT.ProNum;
    end else ohSTCLST.Edit;
    ohSTCLST.ProNam:=ohPROCAT.ProNam;
    ohSTCLST.PgrNum:=ohPROCAT.PgrNum;
    ohSTCLST.FgrNum:=ohPROCAT.FgrNum;
    ohSTCLST.BarCod:=ohPROCAT.BarCod;
    ohSTCLST.StkCod:=ohPROCAT.StkCod;
    ohSTCLST.OrdCod:=ohPROCAT.OrdCod;
    ohSTCLST.MsuNam:=ohPROCAT.MsuNam;
    ohSTCLST.VatPrc:=ohPROCAT.VatPrc;
    ohSTCLST.ProTyp:=ohPROCAT.ProTyp;
    ohSTCLST.DisSta:=ohPROCAT.DisSta;
    ohSTCLST.Post;
  end else ; // TODO: neexistuj˙ci produkt v katalÛgu
end;

end.


