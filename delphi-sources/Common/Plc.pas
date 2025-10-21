unit Plc;
{$F+}

// *****************************************************************************
//                          OBJEKT NA PRACU S PREDAJNOU CENOU
// *****************************************************************************
// Tento objekt obsahuje funkcie potrebné na rôzne výpoèty predajných cien
//
// Programové funkcia:
// ---------------
// *****************************************************************************


interface

uses
  IcTypes, IcConst, IcConv, IcTools, DocHand, NexGlob, NexPath, NexIni, Key,
  SysUtils, Classes, Forms;

type
  TPlc = class(TComponent)
    constructor Create;
    destructor  Destroy; override;
    private
      oPlsNum: word;
      oStpFrc: byte; // Pocet desatinnych miest, na ktory sa zaokruhluje nakupna cena
      oSapFrc: byte; // Pocet desatinnych miest, na ktory sa zaokruhluje predajna cena
      oSapRnd: byte; // Sposob zaokruhlenia predajnej ceny 0-Stand; 1-Down; 2-Up
      procedure SetPlsNum(pPlsNum:word);
    public
      function ClcCPrice(pPrfPrc,pAPrice:double):double; // Vypocita NC bez DPH z PC bez DPH a percentualneho zisku
      function ClcEPrice(pVatPrc:longint;pCPrice:double):double; // Vypocita NC s DPH podla sadzby DPH z PC bez DPH
      function ClcPrfPrc(pCPrice,pAPrice:double):double; // Vypocita percentualny zisk z NC a PC bez DPH
      function ClcDscPrc(pDPrice,pAPrice:double):double; // Vypocita percentualnu zlavu
      function ClcAPrice(pPrfPrc,pCPrice:double):double; overload; // Vypocita PC bez DPH z NC bez DPH a percentualneho zisku
      function ClcAPrice(pVatPrc:longint;pBPrice:double):double; overload; // Vypocita PC bez DPH podla sadzby DPH z PC s DPH
      function ClcAPrice(pVatPrc:longint;pBPrice:double;pFract:byte):double; overload; // Vypocita PC bez DPH podla sadzby DPH z PC s DPH
      function ClcBPrice(pVatPrc:longint;pAPrice:double):double; overload; // Vypocita PC s DPH podla sadzby DPH z PC bez DPH
      function ClcBPrice(pVatPrc:longint;pAPrice:double;pFract:byte):double; overload; // Vypocita PC s DPH podla sadzby DPH z PC bez DPH
    published
      property PlsNum:word write SetPlsNum;
  end;

var gPlc:TPlc;

implementation

constructor TPlc.Create;
begin
  oStpFrc:=gKey.StpRndFrc;
  SetPlsNum(1);
end;

destructor TPlc.Destroy;
begin
end;

// ********************************* PRIVATE ***********************************

procedure TPlc.SetPlsNum(pPlsNum:word);
begin
  oPlsNum:=pPlsNum;
  If oPlsNum=0 then oPlsNum:=1;
  oSapFrc:=gKey.PlsSapFrc[oPlsNum];
  oSapRnd:=gKey.PlsSapRnd[oPlsNum];
end;

// ********************************** PUBLIC ***********************************

function TPlc.ClcCPrice(pPrfPrc,pAPrice:double):double; // Vypocita NC bez DPH z PC bez DPH a percentualneho zisku
begin
  If pPrfPrc>0
    then Result:=Rd(pAPrice/(1+pPrfPrc/100),oStpFrc,cStand)
    else Result:=pAPrice;
end;

function TPlc.ClcEPrice(pVatPrc:longint;pCPrice:double):double; // Vypocita NC s DPH podla sadzby DPH z PC bez DPH
begin
  If pVatPrc>0
    then Result:=Rd(pCPrice*(1+pVatPrc/100),oSapFrc,oSapRnd)
    else Result:=pCPrice;
end;

function TPlc.ClcPrfPrc(pCPrice,pAPrice:double):double; // Vypocita percentualny zisk z NC a PC bez DPH
begin
  If IsNotNul(pCPrice)
    then Result:=((pAPrice/pCPrice)-1)*100
    else Result:=0;
end;

function TPlc.ClcDscPrc(pDPrice,pAPrice:double):double; // Vypocita percentualnu zlavu
begin
  If IsNotNul(pDPrice)
    then Result:=(1-(pAPrice/pDPrice))*100
    else Result:=0;
end;

function TPlc.ClcAPrice(pPrfPrc,pCPrice:double):double; // Vypocita PC bez DPH z NC bez DPH a percentualneho zisku
begin
  Result:=Rd(pCPrice*(1+pPrfPrc/100),oSapFrc,oSapRnd);
end;

function TPlc.ClcAPrice(pVatPrc:longint;pBPrice:double):double; // Vypocita PC bez DPH podla sadzby DPH z PC s DPH
begin
  If pVatPrc>0
    then Result:=Rd(pBPrice/(1+pVatPrc/100),oSapFrc,oSapRnd)
    else Result:=pBPrice;
end;

function TPlc.ClcAPrice(pVatPrc:longint;pBPrice:double;pFract:byte):double; // Vypocita PC bez DPH podla sadzby DPH z PC s DPH
begin
  If pVatPrc>0
    then Result:=Rd(pBPrice/(1+pVatPrc/100),pFract,oSapRnd)
    else Result:=pBPrice;
end;

function TPlc.ClcBPrice(pVatPrc:longint;pAPrice:double):double; // Vypocita PC a DPH podla sadzby DPH z PC bez DPH
begin
  If pVatPrc>0
    then Result:=Rd(pAPrice*(1+pVatPrc/100),oSapFrc,oSapRnd)
    else Result:=pAPrice;
end;

function TPlc.ClcBPrice(pVatPrc:longint;pAPrice:double;pFract:byte):double; // Vypocita PC a DPH podla sadzby DPH z PC bez DPH
begin
  If pVatPrc>0
    then Result:=Rd(pAPrice*(1+pVatPrc/100),pFract,oSapRnd)
    else Result:=pAPrice;
end;

end.
