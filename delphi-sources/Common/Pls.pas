unit Pls;
{$F+}

// *****************************************************************************
//                           PRÁCA S PREDAJNÝMI CENAMI
// *****************************************************************************

interface

uses
  IcTypes, IcConst, IcConv, IcTools, IcVariab,
  NexGlob, NexPath, NexIni, NexMsg, NexError, StkGlob, Key, Lpd,
  hBCSGSL, hGSCAT, hPLSLST, hPLS, hPLH, hPLC, hPLD, hSTK,
  BtrHand, ComCtrls, SysUtils, Classes, Forms;

type
  PDat=^TDat;
  TDat=record
    rhPLS:TPlsHnd;
    rhPLH:TPlhHnd;
    rhPLC:TPlcHnd;
  end;
  TPce=record
    rCpcSrc:Str1; // Zdroj nákupnej ceny A-priemerná;L-posledná;B-GSCAT;P-nákupné podmienky
    rCPrice:double;
    rProfit:double;
    rAprice:double;
    rBprice:double;
  end;

  TPls=class(TComponent)
    constructor Create(AOwner: TComponent);
    destructor Destroy; override;
    private
      oModPrg:Str3;
      oPlsNum:word;
      oLst:TList;
      oPce:TPce;
      function GetActPos:integer;
      procedure ClcDat(var pPce:TPce;pVatPrc:byte;pBprice:double;pStkNum:word;pGsCode:longint); // Vypoèíta cenu bez DPH, profit a vykoná zaokrúhlenie cien pod¾a nastavenia
      procedure SavPlh(pGsCode:longint;pPce:TPce); // Uloží zmenu ceny do histórie
      procedure savCas;  // Uloží zmeny do ERP
      procedure Activate(pIndex:word); // Aktivuje databazu, ktora je otvorena pod poradovym cislom pIndex
    public
      ohGSCAT:TGscatHnd;
      ohBCSGSL:TBcsgslHnd;
      ohPLSLST:TPlslstHnd;
      ohPLS:TPlsHnd;
      ohPLH:TPlhHnd;
      ohPLC:TPlcHnd;
      ohSTK:TStkHnd;
      procedure Open(pPlsNum:word); overload; // Otvori vsetky databazove subory
      procedure Open(pPlsNum:word;pPLH,pPLC:boolean); overload;// Otvori zadane databazove subory
      procedure NewItm(pGsCode:longint;pBprice:double;pModPrg:Str3); // Založí novú položku do aktuálne otovreného cenníka
      procedure DelItm(pGsCode:longint;pModPrg:Str3);
      procedure PlcSav(pPlsNum:word;pGsCode:longint;pBprice:double); // Automaticky prepoèíta a zmení ceny vo všetkých cenníkoch, kde je nastavený zadaný cenník ako master
      procedure SavLab(pPlsNum:word;pGsCode:longint); // Uloèí súbor per tlaè etikety
    published
      property PlsNum:word read oPlsNum;
      property ActPos:integer read GetActPos;
  end;

implementation

constructor TPls.Create(AOwner: TComponent);
begin
  oPlsNum:=0;
  ohSTK:=TStkHnd.Create;
  ohGSCAT:=TGscatHnd.Create;  ohGSCAT.Open;
  ohBCSGSL:=TBcsgslHnd.Create;
  ohPLSLST:=TPlslstHnd.Create;  ohPLSLST.Open;
  oLst:=TList.Create;  oLst.Clear;
end;

destructor TPls.Destroy;
var I:word;
begin
  If oLst.Count>0 then begin
    For I:=1 to oLst.Count do begin
      Activate(I);
      FreeAndNil(ohPLS);
      FreeAndNil(ohPLH);
      FreeAndNil(ohPLC);
    end;
  end;
  FreeAndNil(oLst);
  FreeAndNil(ohPLSLST);
  FreeAndNil(ohBCSGSL);
  FreeAndNil(ohGSCAT);
  FreeAndNil(ohSTK);
end;

// ********************************* PRIVATE ***********************************

function TPls.GetActPos:integer;
begin
  Result:=ohPLS.ActPos;
end;

procedure TPls.ClcDat(var pPce:TPce;pVatPrc:byte;pBprice:double;pStkNum:word;pGsCode:longint); // Vypoèíta cenu bez DPH, profit a vykoná zaokrúhlenie cien pod¾a nastavenia
begin
  pPce.rCpcSrc:='';  pPce.rCprice:=0;
//  pPce.rBprice:=Rd(pBprice,gKey.PlsSapFrc[oPlsNum],gKey.PlsSapRnd[oPlsNum]);
  pPce.rBprice:=RoundBPrice(pBprice,ohPLSLST.RndType);
  pPce.rAprice:=pBprice/(1+pVatPrc/100);
  If not ohSTK.Active or (ohSTK.StkNum<>pStkNum) then ohSTK.Open(pStkNum);
  If ohSTK.LocateGsCode(pGsCode) then begin
    If ohPLSLST.AvgCalc=1 then begin
      pPce.rCpcSrc:='A';
      pPce.rCprice:=ohSTK.AvgPrice;
    end else begin
      pPce.rCpcSrc:='L';
      pPce.rCprice:=ohSTK.LastPrice;
      If IsNul(pPce.rCprice) then begin // Ak tovar nemá poslednú nákupnú cenu zameníme priemernou
        pPce.rCpcSrc:='A';
        pPce.rCprice:=ohSTK.AvgPrice;
      end;
    end;
  end;
  If IsNul(pPce.rCprice) then begin
    If ohGSCAT.LocateGsCode(pGsCode) then begin
      pPce.rCpcSrc:='B';
      pPce.rCprice:=ohGSCAT.LinPrice;
    end;
  end;
  If IsNul(pPce.rCprice) then begin
    If not ohBCSGSL.Active then ohBCSGSL.Open;
    If ohBCSGSL.LocateGsCode(pGsCode) then begin
      pPce.rCpcSrc:='P';
      pPce.rCprice:=ohBCSGSL.FgCPrice;
    end;
  end;
  If IsNotNul(pPce.rCprice)
    then pPce.rProfit:=((pPce.rAprice/pPce.rCprice)-1)*100
    else pPce.rProfit:=0;
end;

procedure TPls.Activate(pIndex:word); // Aktivuje databazu, ktora je otvorena pod poradovym cislom pIndex
var mDat:PDat;
begin
  mDat:=oLst.Items[pIndex-1];
  ohPLS:=mDat.rhPLS;
  ohPLH:=mDat.rhPLH;
  ohPLC:=mDat.rhPLC;
end;

// ********************************** PUBLIC ***********************************

procedure TPls.Open(pPlsNum:word);
begin
  Open(pPlsNum,TRUE,TRUE);
end;

procedure TPls.Open(pPlsNum:word;pPLH,pPLC:boolean);
var mFind:boolean;  mCnt:word;  mDat:PDat;
begin
//  If ohPLSLST.LocatePlsNum(pPlsNum) then begin
    oPlsNum:=pPlsNum;
    mFind:=FALSE;
    If oLst.Count>0 then begin
      mCnt:=0;
      Repeat
        Inc(mCnt);
        Activate(mCnt);
        mFind:=ohPLS.BtrTable.BookNum=StrIntZero(pPlsNum,5);
      until mFind or (mCnt=oLst.Count);
    end;
    If not mFind then begin // Ak dana kniha este nie je otvorena potomotvorime
      // Vytvorime objekty
      ohPLS:=TPlsHnd.Create;  ohPLS.Open(pPlsNum);   // Cenník vždy musí by otvorený
      ohPLH:=TPlhHnd.Create;
      ohPLC:=TPlcHnd.Create;
      // Otvorime databazove subory
      If pPLH then ohPLH.Open(pPlsNum);
      If pPLC then ohPLC.Open(pPlsNum);
      // Ulozime objekty do zoznamu
      GetMem(mDat,SizeOf(TDat));
      mDat^.rhPLS:=ohPLS;
      mDat^.rhPLH:=ohPLH;
      mDat^.rhPLC:=ohPLC;
      oLst.Add(mDat);
    end;
//  end else ; // Zadaný cenník nie je v zozname
end;

procedure TPls.PlcSav(pPlsNum:word;pGsCode:longint;pBprice:double);
var mGrpCod:longint;  mBprice:double;  mPce:TPce;  mStkNum:word;  mBpcMod:boolean;
begin
  oModPrg:='PLC'; // Automatický prepoèet cien
  If ohPLSLST.LocateMaster(pPlsNum) then begin
    mStkNum:=ohPLSLST.StkNum;
    If ohGSCAT.LocateGsCode(pGsCode) then begin
      Repeat
        mGrpCod:=0;
        Open(ohPLSLST.PlsNum);
        If ohPLSLST.GrpTyp='T' then mGrpCod:=ohGSCAT.MgCode;
        If ohPLSLST.GrpTyp='F' then mGrpCod:=ohGSCAT.FgCode;
        If ohPLSLST.GrpTyp='S' then mGrpCod:=ohGSCAT.SgCode;
        If mGrpCod>0 then begin
          If ohPLC.LocateGrpCod(mGrpCod) then begin
            mBprice:=pBprice*(1+ohPLC.ClcPrc/100);
            If ohPLS.LocateGsCode(pGsCode) then begin
              If ohPLS.StkNum>0 then mStkNum:=ohPLS.StkNum;
              ClcDat(mPce,ohGSCAT.VatPrc,mBprice,mStkNum,pGsCode);
              mBpcMod:=not Equal(mPce.rBprice,ohPLS.Bprice,gKey.PlsSapFrc[oPlsNum]);
              If mBpcMod then SavPlh(pGsCode,mPce);
              ohPLS.Edit;
              If mBpcMod then begin
                ohPLS.ChgItm:='';
                ohPLS.OvsUser:=gvSys.LoginName;
                ohPLS.OvsDate:=Date;
              end;
            end else begin
              ClcDat(mPce,ohGSCAT.VatPrc,mBprice,mStkNum,pGsCode);
              If ohPLH.LocateGsCode(pGsCode) then SavPlh(pGsCode,mPce); // Ak tovar už má históriu za píšeme novú cenu
              ohPLS.Insert;
              BTR_To_BTR(ohGSCAT.BtrTable,ohPLS.BtrTable);
            end;
            ohPLS.CpcSrc:=mPce.rCpcSrc;
            ohPLS.Profit:=mPce.rProfit;
            ohPLS.Aprice:=mPce.rAprice;
            ohPLS.Bprice:=mPce.rBprice;
            ohPLS.Post;
            If ohPLSLST.PrnLab=1 then SavLab(pPlsNum,pGsCode);
          end else ; // Daná xxx skupina nie je zadaná do kalkulaèného predpisu
        end else ; // Nie je nastavený správny typ tovarovej skupiny
        Application.ProcessMessages;
        ohPLSLST.Next;
      until ohPLSLST.Eof or (ohPLSLST.Master<>pPlsNum);
    end else ; // Tovar nie je v bázovej evidencii
  end;
end;

procedure TPls.SavLab(pPlsNum:word;pGsCode:longint);
var mLpd:TLpd;
begin
  mLpd:=TLpd.Create(Self);
  mLpd.Save(pPlsNum,pGsCode);
  FreeAndNil(mLpd);
end;

procedure TPls.NewItm(pGsCode:longint;pBprice:double;pModPrg:Str3);
var mPce:TPce;
begin
  oModPrg:=pModPrg;
  If ohGSCAT.LocateGsCode(pGsCode) then begin
    ClcDat(mPce,ohGSCAT.VatPrc,pBprice,ohPLSLST.StkNum,pGsCode);
    If ohPLH.LocateGsCode(pGsCode) then SavPlh(pGsCode,mPce); // Ak tovar už má históriu za píšeme novú cenu
    ohPLS.Insert;
    BTR_To_BTR(ohGSCAT.BtrTable,ohPLS.BtrTable);
    ohPLS.CpcSrc:=mPce.rCpcSrc;
    ohPLS.Profit:=mPce.rProfit;
    ohPLS.Aprice:=mPce.rAprice;
    ohPLS.Bprice:=mPce.rBprice;
    ohPLS.Post;
  end else ; // Neexistuje tovar v bázovej evidencii
end;

procedure TPls.DelItm(pGsCode:longint;pModPrg:Str3);
var mPce:TPce;  mhPLD:TPldHnd;
begin
  oModPrg:=pModPrg;
  If ohPLS.LocateGsCode(pGsCode) then begin
    mhPLD:=TPldHnd.Create;  mhPLD.Open(oPlsNum);
    mhPLD.Insert;
    BTR_To_BTR(ohPLS.BtrTable,mhPLD.BtrTable);
    mhPLD.Post;
    ohPLS.Delete;
    FillChar(mPce,SizeOf(mPce),#0);
    SavPlh(pGsCode,mPce);
  end;
end;

procedure TPls.SavPlh(pGsCode:longint;pPce:TPce);
begin
  ohPLH.Insert;
  ohPLH.GsCode:=pGsCode;
  If ohPLS.GsCode=pGsCode then begin
    ohPLH.OProfit:=ohPLS.Profit;
    ohPLH.OAPrice:=ohPLS.APrice;
    ohPLH.OBPrice:=ohPLS.BPrice;
  end;
  ohPLH.NProfit:=pPce.rProfit;
  ohPLH.NAPrice:=pPce.rAprice;
  ohPLH.NBPrice:=pPce.rBprice;
  ohPLH.ModPrg:=oModPrg;
  ohPLH.Post
end;

procedure TPls.savCas;  // Uloží zmeny do ERP
begin
end;

end.


