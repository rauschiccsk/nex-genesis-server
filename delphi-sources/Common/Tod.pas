unit Tod;
{$F+}

// *****************************************************************************
//                   OBJEKT NA PRACU TERMINALOVYMI VYDAJKAMI
// *****************************************************************************
// Programové funkcia:
// ---------------
// *****************************************************************************


interface

uses // bOCI, 
  IcTypes, IcConst, IcConv, IcTools, IcDate, IcVariab, DocHand, NexGlob, NexPath, NexTypes, NexMsg, NexError, NexClc,
  SavClc, Key, Stk, Spc, Tcd, Rep, Udo, Plc, ItgLog, DocFnc,
  hTOH, hTOA, hTOI, tTOI, hSTK, hSTS, bGSCAT, hAPLITM, hFGPADSC, hDLRDSC, hDLRLST, hPLS, hPAB, bAGRITM, bAPLITM, bFGPADSC, bDLRDSC, bDLRLST, bPLS, bPAB,
  BtrTools, ComCtrls, SysUtils, Classes, Forms;

type
  PDat=^TDat;
  TDat=record
    rhTOH:TTohHnd;
    rhTOI:TToiHnd;
    rhTOA:TToaHnd;
  end;

  TTod=class(TComponent)
    constructor Create(AOwner: TComponent);
    destructor  Destroy; override;
    private
      oYear:Str2;
      oBokNum:Str5;
      oSerNum:longint;
      oDocNum:Str12;
      oPaCode:longint;
      oDocDate:TDateTime;
      oDocClc:TStrings;
      oOpnBok:TStrings;
      oLst:TList;
      function GetBokNum:Str5;
      procedure SetBokNum (pBokNum:Str5);
      procedure SetDocNum(pDocNum:Str12);
    public
      ohTOH:TTohHnd;
      ohTOA:TToaHnd;
      ohTOI:TToiHnd;
      otTOI:TToiTmp;
      function ActBok:Str5;
      procedure Activate(pIndex:word); // Aktivuje databazu, ktora je otvorena pod poradovym cislom pIndex
      procedure Open(pBokNum:Str5); overload; // Otvori vsetky databazove subory
      procedure Open(pBokNum:Str5;pTOH,pTOI,pTOA:boolean); overload;// Otvori zadane databazove subory
      function Del(pDocNum:Str12;pHedDel:boolean):boolean;  // Zrusi zadany doklad
      procedure ExpDoc(pDocNum:Str12;pUdo:TUdo); // Ulozi vydajku ako univerzalny elektronicky doklad
      procedure RefIcd(pDocNum:Str12;pUdo:TUdo); // nacita do poloziek vydajky odkazy na odberatelske faktury
      procedure NewDoc(pPaCode:longint;pPaName:Str30); // Vytvory novu hlavicku dokladu
      procedure OcdSub(pDocNum:Str12;pBokLst:ShortString); // Odpise dodane mnozstvo zadanej terminalovej vydajky zo zakazkovych dokladov
      procedure StsCad(pDocNum:Str12); // Zmeni cislo terminalovej vydajky v STS na cislo kontrolnej pasky ECR
      procedure StsDoc(pDocNum:Str12); // vytvori rezervacie v STS an polozky TOI
      procedure StsDelItm(pDocNum:Str12;pItmNum:longint); // zrusi rezervaciu v STS na polozku TOI
      procedure AddClc(pDocNum:Str12); // Prida doklad do zoznamu, hlavicky ktorych treba prepocitat
      procedure LstClc; // Prepocita hlavicky zakazkovych dokladov ktore su uvedene v zozname oOchClc
      function  OcdPrc(pDocNum:Str12;pBokLst:ShortString):boolean; // Vyhlada nizsie ceny zo zakaziek
//      procedure ToiDel(pDocNum:Str12;pItmNum:longint;pBokLst:ShortString); // Odpise dodane mnozstvo zadanej terminalovej vydajky zo zakazkovych dokladov , zmaze pozicie v TOP a SPM a prepocita SPC
      procedure DtrTra(pDocNum:Str12); // prepocet cien poloziek podla obch. podmienok
//      function  OcdItm(pDocNum:Str12;pItmNum:longint;pBokLst:ShortString;pUpdateTOI:boolean; var pDPrice,pDscPrc:double; var pSrcDoc:Str20):boolean; // vyhlada najnizsiu cenu vybranej poozky zo zakaziek
      // Kontrolne funkcie
      procedure BcpVer(pDocNum:Str12); // Prekontroluje predajne ceny poloziek zadaneho dokladu a v pripade nezhodny opravi podla OP
      procedure OcpVer(pDocNum:Str12); // Zisti ci zakaznik zo zadaneho dokladu ma nevybavene zakazky ak ano porovna ceny a ked zakazkova cena je nizsia doplni do dokladu
      procedure ItmClc(pDocNum:Str12); // Prpocita kumulativne udaje poloziek terminalovej vydajky
      procedure DocClc(pDocNum:Str12); overload; // Prpocita kumulativne udaje hlavicky terminalovej vydajky
      procedure ExdPrn(pDocNum:Str12); overload; // Tlac expedicneho prikazu

      procedure DocClc; overload; // Prpocita kumulativne udaje hlavicky terminalovej vydajky
      procedure ExdPrn; overload; // Tlac expedicneho prikazu
      // Vyuctovacie funkcie
      function OutItm(pDocNum:Str12):word; // Pocet poloziek na vyuctovanie cez ODL
      procedure TcdRef(pDocNum:Str12;pToi:boolean);overload; // zapise udaje z TOI do TCI
      procedure TcdRef; overload; // zapise udaje z TOI do TCI
      procedure TcdGen(pYear:Str2;pDocNum:Str12); // Vygeneruje odberatelsky dodaci list z terminalovej vydajky
      procedure IcdGen(pYear:Str2;pDocNum:Str12); // Vygeneruje odberatelsku fakturu z terminalovej vydajky
      procedure TopGen; // Vygeneruje skladove pozicie na vydaj
      procedure TodArc; // Premiestni hlavicku aktualneho dokladu do archivu
      procedure IcnSav(pDocNum:Str12;pItmNum:word;pIcdNum:Str12;pIcdItm:word); // Ulozi odkaz na OF do zadanej polozky terminalovej vydajky
      procedure TcdIcv(pDocNum:Str12); // Nacita NC z dodacich listov
      procedure TcdIcvLns(pDocNum:Str12;pLines:TStrings); // Nacita NC z dodacich listov

//      procedure TciGen tcd
      procedure AddTot(pTodNum:Str12;pTodItm:word;pTcdNum:Str12;pTcdItm:word;pTcdDate:TDateTime;pGsCode:longint;pDlvQnt:double); // Ulozi zaznam o vsytavenom dodacom liste k zadane polozke
    published
      property phTOH:TTohHnd read ohTOH write ohTOH;
      property phTOA:TToaHnd read ohTOA write ohTOA;
      property phTOI:TToiHnd read ohTOI write ohTOI;
      property ptTOI:TToiTmp read otTOI write otTOI;
      property BokNum:Str5 read GetBokNum write SetBokNum;
      property Year:Str2 read oYear write oYear;
      property SerNum:longint read oSerNum write oSerNum;
      property DocNum:Str12 read oDocNum write SetDocNum;
      property PaCode:longint write oPaCode;
      property DocDate:TDateTime write oDocDate;
  end;

implementation

uses DM_SYSTEM, bTOI, bTOH, bTCI, bSPC, dOCILST;

constructor TTod.Create(AOwner: TComponent);
begin
  oDocClc:=TStringList.Create;  oDocClc.Clear;
  oOpnBok:=TStringList.Create;  oOpnBok.Clear;
  oLst:=TList.Create;  oLst.Clear;
  ohTOH:=TTohHnd.Create;
  ohTOA:=TToaHnd.Create;
  ohTOI:=TToiHnd.Create;
  otTOI:=TToiTmp.Create;
end;

destructor TTod.Destroy;
var I:word;
begin
  If oLst.Count>0 then begin
    For I:=1 to oLst.Count do begin
      Activate(I);
      FreeAndNil(ohTOH);
      FreeAndNil(ohTOA);
      FreeAndNil(ohTOI);
    end;
  end;
  FreeAndNil(oLst);
  FreeAndNil(oDocClc);
  FreeAndNil(oOpnBok);
end;

// ********************************* PRIVATE ***********************************

function TTod.GetBokNum:Str5;
begin
  Result := ohTOH.BtrTable.BookNum;
end;

procedure TTod.SetBokNum (pBokNum:Str5);
begin
  If ohTOH.BtrTable.BookNum<>pBokNum then ohTOH.Open(pBokNum);
  If ohTOA.BtrTable.BookNum<>pBokNum then ohTOA.Open(pBokNum);
  If ohTOI.BtrTable.BookNum<>pBokNum then ohTOI.Open(pBokNum);
end;

procedure TTod.SetDocNum(pDocNum:Str12);
begin
  If ohTOH.LocateDocNum(pDocNum)
    then oDocNum:=pDocNum
    else oDocNum:='';
end;

// ********************************** PUBLIC ***********************************

procedure TTod.ExpDoc(pDocNum:Str12;pUdo:TUdo); // Ulozi vydajku ako univerzalny elektronicky doklad
var mPlc:TPlc;
begin
  If ohTOH.LocateDocNum(pDocNum) then begin
    If ohTOI.LocateDocNum(pDocNum) then begin
      mPlc := TPlc.Create;
      Repeat
        pUdo.Insert;
        pUdo.DocNum := ohTOI.DocNum;
        pUdo.ItmNum := ohTOI.ItmNum;
        pUdo.MgCode := ohTOI.MgCode;
        pUdo.GsCode := ohTOI.GsCode;
        pUdo.GsName := ohTOI.GsName;
        pUdo.BarCode := ohTOI.BarCode;
        pUdo.StkCode := ohTOI.StkCode;
        pUdo.Notice := ohTOI.Notice;
        pUdo.WriNum := ohTOI.WriNum;
        pUdo.StkNum := ohTOI.StkNum;
        pUdo.Volume := ohTOI.Volume;
        pUdo.Weight := ohTOI.Weight;
        pUdo.PackGs := ohTOI.PackGs;
        pUdo.GsType := ohTOI.GsType;
        pUdo.MsName := ohTOI.MsName;
        pUdo.GsQnt := ohTOI.GsQnt;
        pUdo.VatPrc := ohTOI.VatPrc;
        pUdo.DscPrc := ohTOI.DscPrc;
        pUdo.AcCValue := ohTOI.CValue;
        pUdo.AcEValue := mPlc.ClcEPrice(ohTOI.VatPrc,ohTOI.CValue);
        pUdo.AcDValue := ohTOI.DValue;
        pUdo.AcHValue := ohTOI.HValue;
        pUdo.AcAValue := ohTOI.AValue;
        pUdo.AcBValue := ohTOI.BValue;
        pUdo.FgCourse := 1;
        pUdo.FgCValue := pUdo.AcCValue;
        pUdo.FgEValue := pUdo.AcEValue;
        pUdo.FgDValue := pUdo.AcDValue;
        pUdo.FgHValue := pUdo.AcHValue;
        pUdo.FgAValue := pUdo.AcAValue;
        pUdo.FgBValue := pUdo.AcBValue;
        pUdo.PaCode := ohTOI.PaCode;
        pUdo.DocDate := ohTOI.DocDate;
        pUdo.TcdNum := ohTOI.TcdNum;
        pUdo.TcdItm := ohTOI.TcdItm;
//        pUdo.TcdDate := ohTOI.
        pUdo.IcdNum := ohTOI.IcdNum;
        pUdo.IcdItm := ohTOI.IcdItm;
//        pUdo.IcdDate := ohTOI.
        pUdo.Post;
        ohTOI.Next;
      until ohTOI.Eof or (ohTOI.DocNum<>pDocNum);
      FreeAndNil(mPlc);
    end;
  end;
end;

procedure TTod.RefIcd(pDocNum:Str12;pUdo:TUdo); // nacita do poloziek vydajky odkazy na odberatelske faktury
begin
  If pUdo.Count>0 then begin
    pUdo.First;
    Repeat
      If ohTOI.LocateDoIt(pUdo.DocNum,pUdo.ItmNum) then begin
        ohTOI.Edit;
        ohTOI.IcdNum := pUdo.IcdNum;
        ohTOI.IcdItm := pUdo.IcdItm;
        ohTOI.Post;
      end;
      Application.ProcessMessages;
      pUdo.Next;
    until pUdo.Eof;
    ohTOH.Clc(ohTOI);
  end;
end;

procedure TTod.NewDoc(pPaCode:longint;pPaName:Str30); // Vytvory novu hlavicku dokladu
begin
  oYear:=gvSys.ActYear2;
  oSerNum:=ohTOH.NextSerNum; // Ak nie je zadane poradove cislo OD vygenerujeme nasledujuce
  oDocDate:=Date; // Ak nie je zadany datum nastavime aktualny den
  oDocNum:=ohTOH.GenDocNum(Year,oSerNum);  
  If not ohTOH.LocateDocNum(oDocNum) then begin // Ak neexistuje vyvorime hlacicku dokladu OD
    ohTOH.Insert;
    ohTOH.SerNum:=oSerNum;
    ohTOH.DocNum:=oDocNum;
    ohTOH.DocDate:=oDocDate;
    ohTOH.PaCode:=pPaCode;
    ohTOH.PaName:=pPaName;
    ohTOH.WriNum:=gKey.TobWriNum[ohTOH.BtrTable.BookNum];
    ohTOH.StkNum:=gKey.TobStkNum[ohTOH.BtrTable.BookNum];
    ohTOH.Status:='O';
    ohTOH.Post;
  end;
end;

procedure TTod.OcdSub(pDocNum:Str12;pBokLst:ShortString); // Odpise dodane mnozstvo zadanej terminalovej vydajky zo zakazkovych dokladov
var mDoc:TDocFnc;  mExdPrq,mOutQnt,mDebQnt,mSubQnt,mPlsApc,mSalBpc:double;  mFind:boolean;  mStdNum:Str12; mStdItm:longint;
begin
  If ohTOH.LocateDocNum(pDocNum) then begin // Zadany doklad existuje
    If ohTOI.LocateDocNum(pDocNum) then begin // Zadany doklad ma polozky
      mDoc:=TDocFnc.Create;
      With mDoc.oOcd do begin
        DocLst.Clear;
        Repeat
          mOutQnt:=ohTOI.GsQnt;
          Repeat
            mFind:=ohOCILST.LocSnPaPnSt(ohTOH.StkNum,ohTOH.PaCode,ohTOI.GsCode,'R');
            If mFind then begin
              mDoc.oOcd.AddDocLst(ohOCILST.DocNum);
              mDebQnt:=ohOCILST.RstPrq; // Rezervované množstvo pre daného zákazníka
              If mDebQnt>=mOutQnt then begin // Vydane mnozstvo mozeme odpisat z jednej polozky zakazky
                mSubQnt:=mOutQnt;
                mOutQnt:=0;
                If mDebQnt>=mOutQnt then begin // Nebolo vydane všetko èo je na zákazke
                  // Ulozime hlasenie o tejto skutocnosti
                end;
              end
              else begin // Vydané množstvo budeme odpisovat z viacerych zákaziek
                mSubQnt:=mDebQnt;
                mOutQnt:=mOutQnt-mDebQnt;
              end;
              If ohTOH.CadNum<>'' then begin
                mStdNum:=ohTOH.CadNum;
                mStdItm:=0;
              end;
              If ohTOI.TcdNum<>'' then begin
                mStdNum:=ohTOI.TcdNum;
                mStdItm:=ohTOI.TcdItm;
              end;
              // Zapíšeme do zákazky dodané množstvo a doklad vyúètovania
              If ohOCRLST.LocIaRt(ohOCILST.ItmAdr,'S') then begin
                mExdPrq:=mSubQnt;
                Repeat
                  Application.ProcessMessages;
                  If ohOCRLST.ResPrq>mExdPrq then begin
                    ohOCRLST.Edit;
                    ohOCRLST.ResPrq:=ohOCRLST.ResPrq-mExdPrq;
                    ohOCRLST.Post;
                    mExdPrq:=0;
                  end else begin
                    mExdPrq:=mExdPrq-ohOCRLST.ResPrq;
                    ohOCRLST.Delete;
                  end;
                until ohOCRLST.Eof or (ohOCRLST.OciAdr<>ohOCILST.ItmAdr) or IsNul(mExdPrq);
                ohOCILST.Edit;
                ohOCILST.TcdPrq:=ohOCILST.TcdPrq+mSubQnt;
                ohOCILST.TcdNum:=mStdNum;
                ohOCILST.TcdItm:=mStdItm;
                ohOCILST.TcdDte:=Date;
                ohOCILST.Post;
                mDoc.ClcOciRes(ohOCILST.ItmAdr);
                mDoc.oStk.StcClc(ohOCILST.StkNum,ohOCILST.ProNum);
              end;
              ohTOI.Edit;
              mSalBpc:=0;  mPlsApc:=0;
              If IsNotNul(ohOCILST.SalPrq) then begin
                mSalBpc:=RndBas(ohOCILST.SalBva/ohOCILST.SalPrq);
                mPlsApc:=RndBas(ohOCILST.PlsAva/ohOCILST.SalPrq);
              end;
              If ohTOI.BPrice>mSalBpc then begin // Na zákazke je lepšia cena než na terminalovej výdajke preto zmenime cenu na zákazkovu
                ohTOI.PrcDst:='X'; // Cena je zo zakazkoveho dokladu
                ohTOI.BPrice:=mSalBpc;
                ohTOI.BValue:=Rd2(mSalBpc*ohTOI.GsQnt);
                ohTOI.AValue:=ClcAvaVat(ohTOI.BValue,ohTOI.VatPrc);
                ohTOI.DValue:=Rd2(mPlsApc*ohTOI.GsQnt);
                ohTOI.HValue:=ClcBvaVat(ohTOI.DValue,ohTOI.VatPrc);
                If IsNotNul(ohOCILST.SalPrq) then ohTOI.HPrice:=RndBas(ohTOI.HValue/ohOCILST.SalPrq);
                ohTOI.DscPrc:=ClcDscPrc(ohTOI.HValue,ohTOI.BValue);
              end;
              ohTOI.OcdNum:=ohOCILST.DocNum;
              ohTOI.OcdItm:=ohOCILST.ItmNum;
              ohTOI.Post;
            end else begin // Nebola ani nájdená ani jedna položka zákazky
              // Ulozime hlasenie o tejto skutocnosti
            end;
          until IsNul(mOutQnt) or not mFind;
          Application.ProcessMessages;
          ohTOI.Next;
        until ohTOI.Eof or (ohTOI.DocNum<>pDocNum);
        ClcDocLst; // Prepocita hlavicky zakazkovych dokladov ktore su uvedene v zozname oOchClc
      end;
      FreeAndNil(mDoc);
    end;
  end;
end;

(*
procedure TTod.ToiDel(pDocNum:Str12;pItmNum:longint;pBokLst:ShortString); // Odpise dodane mnozstvo zadanej terminalovej vydajky zo zakazkovych dokladov
var mFind:boolean; mI:word;
begin
  If ohTOH.LocateDocNum(pDocNum) then begin // Zadany doklad existuje
    If ohTOI.LocateDoIt(pDocNum,pItmNum) then begin // Zadany doklad ma polozky
{
      oSpc.StkNum:=ohTOH.StkNum;
      If ohTOP.LocateDoIt(pDocNum,pItmNum) then begin // Zadany doklad ma polozky TOP
        repeat
          oSpc.Del(ohTOH.StkNum,ohTOP.PosOut,ohTOI.GsCode,ohTOH.DocNum,ohTOI.ItmNum);
          ohTOP.Delete;
        until ohTOP.Eof or (ohTOP.DocNum<>pDocNum)or(ohTOP.ItmNum<>pItmNum)
      end;
}
      mOcd:=TOcd.Create(Self);
      mOcd.OpenLst(pBokLst);
      If mOcd.OpenCount>0 then begin  // Su otorene knihy na odpisanie dodaneho tovaru
        for mI:=1 to mOcd.OpenCount do begin
          mOcd.Activate(mI);
          mFind:=mOcd.LocatePaGsSt(ohTOH.PaCode,ohTOI.GsCode,'S',True) ;
          If mFind then begin
            repeat
              If (mOcd.ohOCI.TodNum=pDocNum)and(mOcd.ohOCI.TodItm=pItmNum)then begin // OCI sa vztahuje na tuto polozku TOI
                mOcd.ohOCI.Edit;
                mOcd.ohOCI.TodNum  :='';
                mOcd.ohOCI.TodItm  :=0;
                mOcd.ohOCI.DlvQnt  :=0;
                mOcd.ohOCI.DlvDate :=0;
                mOcd.ohOCI.StkStat :='R';
                mOcd.ohOCI.Post;
                mOcd.AddClc(mOcd.ohOCI.DocNum);
                mOcd.RefSto;
              end;
              mOcd.ohOCI.Next;
            until mOcd.ohOCI.Eof or (mOcd.ohOCI.PaCode<>ohTOH.PaCode) or (mOcd.ohOCI.GsCode<>ohTOI.GsCode)or(mOcd.ohOCI.StkStat<>'S');
          end;
        end;
        for mI:=1 to mOcd.OpenCount do begin
          mOcd.Activate(mI);
          mFind:=mOcd.LocatePaGsSt(ohTOH.PaCode,ohTOI.GsCode,'R',True) ;
          If mFind then begin
            repeat
              If (mOcd.ohOCI.TodNum=pDocNum)and(mOcd.ohOCI.TodItm=pItmNum)then begin // OCI sa vztahuje na tuto polozku TOI
                mOcd.ohOCI.Edit;
                mOcd.ohOCI.TodNum:='';
                mOcd.ohOCI.TodItm:=0;
                mOcd.ohOCI.Post;
                mOcd.AddClc(mOcd.ohOCI.DocNum);
                mOcd.RefSto;
              end;
              mOcd.ohOCI.Next;
            until mOcd.ohOCI.Eof or (mOcd.ohOCI.PaCode<>ohTOH.PaCode) or (mOcd.ohOCI.GsCode<>ohTOI.GsCode);
          end;
        end;
        Application.ProcessMessages;
      end;
      mOcd.LstClc;
      FreeAndNil (mOcd);
    end;
  end;
end;
*)

function  TTod.OcdPrc(pDocNum:Str12;pBokLst:ShortString):boolean; // vyhlada nizsie ceny zo zakaziek
var mDoc:TDocFnc;  mI:integer; mChange:boolean;  mSalBpc,mPlsApc:double;
begin
  mChange:=False;
  If ohTOH.LocateDocNum(pDocNum) then begin // Zadany doklad existuje
    If ohTOI.LocateDocNum(pDocNum) then begin // Zadany doklad ma polozky
      mDoc:=TDocFnc.Create;
      With mDoc.oOcd do begin
        If ohOCILST.LocSnPaPnSt(ohTOI.StkNum,ohTOH.PaCode,ohTOI.GsCode,'R') then begin
          Repeat
            If (ohOCILST.UndPrq>=ohTOI.GsQnt) and (ohTOI.OcdNum='') then begin
              ohTOI.Edit;
              ohTOI.OcdNum:=ohOCILST.DocNum;
              ohTOI.OcdItm:=ohOCILST.ItmNum;
              ohTOI.Post;
            end;
            mSalBpc:=0;  mPlsApc:=0;
            If IsNotNul(ohOCILST.SalPrq) then begin
              mSalBpc:=RndBas(ohOCILST.SalBva/ohOCILST.SalPrq);
              mPlsApc:=RndBas(ohOCILST.PlsAva/ohOCILST.SalPrq);
            end;
            If ohTOI.BPrice>mSalBpc then begin // Na zakazke je lepsia cena nez na terminalovej vydajke preto zmenime cenu na zakazkovu
              ohTOI.Edit;
              ohTOI.PrcDst:='X'; // Cena je zo zakazkoveho dokladu
              ohTOI.BPrice:=mSalBpc;
              ohTOI.BValue:=Rd2(mSalBpc*ohTOI.GsQnt);
              ohTOI.AValue:=ClcAvaVat(ohTOI.BValue,ohTOI.VatPrc);
              ohTOI.DValue:=Rd2(mPlsApc*ohTOI.GsQnt);
              ohTOI.HValue:=ClcBvaVat(ohTOI.DValue,ohTOI.VatPrc);
              If IsNotNul(ohOCILST.SalPrq) then ohTOI.HPrice:=RndBas(ohTOI.HValue/ohOCILST.SalPrq);
              ohTOI.DscPrc:=ClcDscPrc(ohTOI.HValue,ohTOI.BValue);
              ohTOI.Post;
              mChange:=True;
            end;
            Application.ProcessMessages;
            ohOCILST.Next;
          until ohOCILST.Eof or (ohOCILST.StkNum<>ohTOI.StkNum) or (ohOCILST.ParNum<>ohTOH.PaCode) or (ohOCILST.ProNum<>ohTOI.GsCode) or (ohOCILST.RstSta<>'R');
        end;
      end;
//      mOcd.LstClc; // Prepocita hlavicky zakazkovych dokladov ktore su uvedene v zozname oOchClc
      FreeAndNil(mDoc);
    end;
  end;
  Result:=mChange;
end;

(*
function  TTod.OcdItm(pDocNum:Str12;pItmNum:longint;pBokLst:ShortString;pUpdateTOI:boolean; var pDPrice,pDscPrc:double; var pSrcDoc:Str20):boolean; // vyhlada najnizsiu cenu vybranej poozky zo zakaziek
var mOCd:TOCD;  mI:integer; mBPrice:double;
begin
  Result:=False;
  If ohTOH.LocateDocNum(pDocNum) and ohTOI.LocateDoIt(pDocNum,pItmNum) then begin
  // Zadana polozka dokladu existuje
    mOcd:=TOcd.Create(Self);
    mOcd.OpenLst(pBokLst);
    If mOcd.OpenCount>0 then begin  // Su otorene knihy na odpisanie dodaneho tovaru
      mBPrice:=ohTOI.BPrice;
      for mI:=1 to mOCd.OpenCount do begin
        mOCd.Activate(mI);
        mOcd.ohOCI.SetIndex(ixPaGsSt);
        If mOcd.ohOCI.LocatePaGsSt(ohTOH.PaCode,ohTOI.GsCode,'R') then begin
          Repeat
            If (mBPrice>mOcd.ohOCI.FgBPrice) then begin // Na zakazke je lepsia cena nez na terminalovej vydajke preto zmenime cenu na zakazkovu
              Result:=True;
              mBPrice:=mOcd.ohOCI.FgBPrice;
              pDPrice:=mOcd.ohOCI.FgDPrice;
              pDscPrc:=mOcd.ohOCI.DscPrc;
              pSrcDoc:=mOcd.ohOCI.DocNum+'/'+StrInt(mOcd.ohOCI.ItmNum,0);
              If pUpdateTOI then begin
                ohTOI.Edit;
                ohTOI.PrcDst:='X'; // Cena je zo zakazkoveho dokladu
                ohTOI.BPrice:=mOcd.ohOCI.FgBPrice;
                ohTOI.BValue:=Rd2(ohTOI.BPrice*ohTOI.GsQnt);
                ohTOI.AValue:=Rd2(ohTOI.BValue/(1+ohTOI.VatPrc/100));
//                ohTOI.AValue:=Rd2(mOcd.ohOCI.FgAPrice*ohTOI.GsQnt);
                ohTOI.HPrice:=mOcd.ohOCI.FgDPrice*(1+ohTOI.VatPrc/100); //oci.bdf
                ohTOI.HValue:=Rd2(ohTOI.HPrice*ohTOI.GsQnt);
                ohTOI.DValue:=Rd2(mOcd.ohOCI.FgDPrice*ohTOI.GsQnt);
                ohTOI.DscPrc:=mOcd.ohOCI.DscPrc;
                ohTOI.Post;
              end;
            end;
            mOcd.ohOCI.Next;
          until mOcd.ohOCI.Eof or(mOcd.ohOCI.PaCode<>ohTOH.PaCode)or(mOcd.ohOCI.GsCode<>ohTOI.GsCode)or(mOcd.ohOCI.StkStat<>'R');
        end;
      end;
      Application.ProcessMessages;
    end;
    FreeAndNil (mOcd);
  end;
end;
*)

procedure TTod.StsCad(pDocNum:Str12); // Zmeni cislo terminalovej vydajky v STS na cislo kontrolnej pasky ECR
var mhSTS:TStsHnd;  mhSTK:TStkHnd;  mSalQnt:double;
begin
  If ohTOH.LocateDocNum(pDocNum) then begin
    If ohTOI.LocateDocNum(pDocNum) then begin
      mhSTK:=TStkHnd.Create;  mhSTK.Open(ohTOH.StkNum);
      mhSTS:=TStsHnd.Create;  mhSTS.Open(ohTOH.StkNum);
      Repeat
        If mhSTS.LocateDoIt(ohTOI.DocNum,ohTOI.ItmNum) then begin
          mhSTS.Edit;
          mhSTS.SalDate:=Date;
          mhSTS.CasNum:=ohTOH.CasNum;
          mhSTS.DocNum:=ohTOH.CadNum;
          mhSTS.ItmNum:=0;
          mhSTS.Post;
        end
        else begin // neexistuje rezervacia peto spravime autokorekciu
          mhSTS.Insert;
          mhSTS.GsCode:=ohTOI.GsCode;
          mhSTS.SalQnt:=ohTOI.GsQnt;
          mhSTS.SalDate:=Date;
          mhSTS.CasNum:=ohTOH.CasNum;
          mhSTS.DocNum:=ohTOH.CadNum;
          mhSTS.ItmNum:=0;
          mhSTS.Post;
          If mhSTK.LocateGsCode(ohTOI.GsCode) then begin
            mSalQnt:=mhSTS.SalQntSum(ohTOI.GsCode);
            mhSTK.Edit;
            mhSTK.SalQnt:=mSalQnt;
            mhSTK.Post;
          end;
        end;
        Application.ProcessMessages;
        ohTOI.Next;
      until ohTOI.Eof or (ohTOI.DocNum<>pDocNum);
      FreeAndNil(mhSTS);
      FreeAndNil(mhSTK);
    end;
  end;
end;

procedure TTod.StsDoc(pDocNum:Str12); // vytvori rezervacie v STS an polozky TOI
var mhSTS:TStsHnd;  mhSTK:TStkHnd;  mSalQnt:double;
begin
  If ohTOH.LocateDocNum(pDocNum) then begin
    If ohTOI.LocateDocNum(pDocNum) then begin
      mhSTK:=TStkHnd.Create;  mhSTK.Open(ohTOH.StkNum);
      mhSTS:=TStsHnd.Create;  mhSTS.Open(ohTOH.StkNum);
      Repeat
        If mhSTS.LocateDoIt(ohTOI.DocNum,ohTOI.ItmNum) then begin
          mhSTS.Edit;
          mhSTS.SalDate:=ohTOH.DocDate;
          mhSTS.CasNum:=ohTOH.CasNum;
          mhSTS.DocNum:=ohTOH.DocNum;
          mhSTS.ItmNum:=ohTOI.ItmNum;
          mhSTS.GsCode:=ohTOI.GsCode;
          mhSTS.SalQnt:=ohTOI.GsQnt-ohTOI.DlvQnt;
          mhSTS.Post;
        end
        else begin // neexistuje rezervacia peto spravime autokorekciu
          mhSTS.Insert;
          mhSTS.SalDate:=ohTOH.DocDate;
          mhSTS.CasNum:=ohTOH.CasNum;
          mhSTS.DocNum:=ohTOI.DocNum;
          mhSTS.ItmNum:=ohTOI.ItmNum;
          mhSTS.GsCode:=ohTOI.GsCode;
          mhSTS.SalQnt:=ohTOI.GsQnt-ohTOI.DlvQnt;
          mhSTS.Post;
          If mhSTK.LocateGsCode(ohTOI.GsCode) then begin
            mSalQnt:=mhSTS.SalQntSum(ohTOI.GsCode);
            mhSTK.Edit;
            mhSTK.SalQnt:=mSalQnt;
            mhSTK.Post;
          end;
        end;
        Application.ProcessMessages;
        ohTOI.Next;
      until ohTOI.Eof or (ohTOI.DocNum<>pDocNum);
      FreeAndNil(mhSTS);
      FreeAndNil(mhSTK);
    end;
  end;
end;

procedure TTod.StsDelItm(pDocNum:Str12;pItmNum:longint); // zrusi rezervaciu v STS na polozku TOI
var mhSTS:TStsHnd;  mhSTK:TStkHnd;  mSalQnt:double;
begin
  If ohTOH.LocateDocNum(pDocNum) then begin
    If ohTOI.LocateDoIt(pDocNum,pItmNum) then begin
      mhSTK:=TStkHnd.Create;  mhSTK.Open(ohTOH.StkNum);
      mhSTS:=TStsHnd.Create;  mhSTS.Open(ohTOH.StkNum);
      If mhSTS.LocateDoIt(ohTOI.DocNum,ohTOI.ItmNum) then mhSTS.Delete;
      If mhSTK.LocateGsCode(ohTOI.GsCode) then begin
        mSalQnt:=mhSTS.SalQntSum(ohTOI.GsCode);
        mhSTK.Edit;
        mhSTK.SalQnt:=mSalQnt;
        mhSTK.Post;
      end;
      FreeAndNil(mhSTS);
      FreeAndNil(mhSTK);
    end;
  end;
end;

procedure TTod.AddClc(pDocNum:Str12); // Prida doklad do zoznamu, hlavicky ktorych treba prepocitat
var mExist:boolean;  I:word;
begin
  mExist:=FALSE;
  If oDocClc.Count>0 then begin  // Mame doklady na prepocitanie
    For I:=0 to oDocClc.Count-1 do begin
      If oDocClc.Strings[I]=pDocNum then mExist:=TRUE;
    end
  end;
  If not mExist then oDocClc.Add(pDocNum);
end;

procedure TTod.LstClc; // Prepocita hlavicky zakazkovych dokladov ktore su uvedene v zozname oOchClc
var I:word;
begin
  If oDocClc.Count>0 then begin  // Mame doklady na prepocitanie
    For I:=0 to oDocClc.Count-1 do begin
      BokNum:=BookNumFromDocNum(oDocClc.Strings[I]);
      DocClc(oDocClc.Strings[I]);
    end
  end;
end;

procedure TTod.BcpVer(pDocNum:Str12); // Prekontroluje predajne ceny poloziek zadaneho dokladu a v pripade nezhodny opravi podla OP
begin
  If ohTOH.LocateDocNum(pDocNum) then begin
    If ohTOI.LocateDocNum(pDocNum) then begin
      Repeat
        ohTOI.Edit;
        ohTOI.BValue:=Rd2(ohTOI.BValue);
        ohTOI.Post;
        Application.ProcessMessages;
        ohTOI.Next;
      until ohTOI.Eof or (ohTOI.DocNum<>pDocNum);
    end;
  end;
end;

procedure TTod.OcpVer(pDocNum:Str12); // Zisti ci zakaznik zo zadaneho dokladu ma nevybavene zakazky ak ano porovna ceny a ked zakazkova cena je nizsia doplni do dokladu
begin
end;

procedure TTod.ItmClc(pDocNum:Str12); // Prpocita kumulativne udaje poloziek terminalovej vydajky
begin
end;

procedure TTod.DocClc(pDocNum:Str12); // Prpocita kumulativne udaje hlavicky terminalovej vydajky
begin
  If ohTOH.LocateDocNum(pDocNum) then ohTOH.Clc(ohTOI);
end;

procedure TTod.DocClc; // Prpocita kumulativne udaje hlavicky terminalovej vydajky
begin
  ohTOH.Clc(ohTOI);
end;

procedure TTod.ExdPrn(pDocNum:Str12); // Tlac expedicneho prikazu
var mtTOI:TToiTmp;  mRep:TRep;
begin
  If ohTOH.LocateDocNum(pDocNum) then begin
    If ohTOI.LocateDocNum(pDocNum) then begin
      mtTOI:=TToiTmp.Create;  mtTOI.Open;
      Repeat
        If IsNotNul(ohTOI.GsQnt-ohTOI.DlvQnt) then begin
          mtTOI.Insert;
          BTR_To_PX (ohTOI.BtrTable,mtTOI.TmpTable);
          mtTOI.Post;
        end;
        ohTOI.Next;
      until ohTOI.Eof or (ohTOI.DocNum<>pDocNum);
      If mtTOI.Count>0 then begin
        mRep:=TRep.Create(Self);
        mRep.SysBtr:=dmSYS.btSYSTEM;
        mRep.HedBtr:=ohTOH.BtrTable;
        mRep.ItmTmp:=mtTOI.TmpTable;
        mRep.Execute('TODEXD');
        FreeAndNil (mRep);
      end;
      FreeAndNil (mtTOI);
    end;
  end;
end;

procedure TTod.ExdPrn; // Tlac expedicneho prikazu
begin
  ExdPrn(ohTOH.DocNum);
end;

function TTod.OutItm(pDocNum:Str12):word; // Pocet poloziek na vyuctovanie cez ODL
begin
  Result:=0;
  If ohTOI.LocateDocNum(pDocNum) then begin
    Repeat
      If IsNotNul(ohTOI.OutQnt) then Inc (Result);
      ohTOI.Next;
    until ohTOI.Eof or (ohTOI.DocNum<>pDocNum);
  end;
end;

procedure TTod.TcdGen(pYear:Str2;pDocNum:Str12); // Vygeneruje odberatelsky dodaci list z terminalovej vydajky
var mTcd:TTcd;  mStk:TStk; mSpc:TSpc; mItgLog:TItgLog;  mSav:TSavClc;  mItmNum:word;
begin
  oYear:=pYear;If oYear='' then oYear:=gvsys.ActYear2;
  If ohTOH.LocateDocNum(pDocNum) then begin
    oDocNum:=ohTOH.DocNum;
    If ohTOI.LocateDocNum(pDocNum) then begin
      mStk:=TStk.Create;
      mTcd:=TTcd.Create(Self);
      mTcd.Open(gKey.TobTcbNum[ohTOH.BtrTable.BookNum]);
      mTcd.NewDoc(oYear,ohTOH.PaCode,FALSE);
//      mTcd.NewDoc(ohTOH.PaCode);mTcd.CnfDoc;
      // Vytvorime polozky OD na zaklade DD
      mItgLog:=TItgLog.Create;
      mSpc:=TSpc.Create;
      mSav:=TSavClc.Create;
      mItmNum:=mTcd.ohTCI.NextItmNum(mTcd.DocNum);
      Repeat
        If IsNotNul(ohTOI.OutQnt) then begin
          // Vypoèíteme predajné ceny  TOI.BDF
          mSav.GsQnt:=ohTOI.OutQnt;
          mSav.VatPrc:=ohTOI.VatPrc;
          mSav.DscPrc:=ohTOI.DscPrc;
          If IsNotNul(ohTOI.BPrice)
            then mSav.FgBPrice:=ohTOI.BPrice
            else If IsNotNul(ohTOI.GsQnt)
              then mSav.FgBPrice:=ohTOI.BValue/ohTOI.GsQnt
              else mSav.FgBPrice:=ohTOI.BValue/ohTOI.OutQnt;
          mTcd.ohTCI.Insert;
          BTR_To_BTR (ohTOI.BtrTable,mTcd.ohTCI.BtrTable); // toi.bdf tci.bdf
          mTcd.ohTCI.DocNum:=mTcd.DocNum;
          mTcd.ohTCI.ItmNum:=mItmNum;
          mTcd.ohTCI.ScdNum:=ohTOI.DocNum;
          mTcd.ohTCI.ScdItm:=ohTOI.ItmNum;
          mTcd.ohTCI.GsQnt:=ohTOI.OutQnt;
          If IsNotNul(ohTOI.GsQnt) then mTcd.ohTCI.AcCValue:=ohTOI.CValue*ohTOI.OutQnt/ohTOI.GsQnt;
//            else mTcd.ohTCI.AcCValue:=ohTOI.CValue/ohTOI.GsQnt*ohTOI.OutQnt;
          mTcd.ohTCI.Sav:=mSav;
          mTcd.ohTCI.StkStat:='N';
          If (mTcd.ohTCI.IcdNum='') and (ohTOI.CadNum<>'') then  mTcd.ohTCI.IcdNum:=ohTOI.CadNum;
          If ohTOI.IcdNum<>'' then begin
            mTcd.ohTCI.IcdNum :=ohTOI.IcdNum;
            mTcd.ohTCI.IcdItm :=ohTOI.IcdItm;
            mTcd.ohTCI.FinStat:='F';
          end else If ohTOI.CadNum<>'' then begin
            mTcd.ohTCI.IcdNum :=ohTOI.CadNum;
            mTcd.ohTCI.IcdItm :=ohTOI.CasNum;
            mTcd.ohTCI.FinStat:='C';
          end else mTcd.ohTCI.FinStat:='';
          mTcd.ohTCI.Post;
          mTcd.AddItc(mTcd.ohTCI.DocNum,mTcd.ohTCI.ItmNum);
          // -------------------------------
(*
          ohTOT.Insert;
          ohTOT.DocNum:=mTcd.ohTCI.ScdNum;
          ohTOT.ItmNum:=mTcd.ohTCI.ScdItm;
          ohTOT.TcdNum:=mTcd.ohTCI.DocNum;
          ohTOT.TcdItm:=mTcd.ohTCI.ItmNum;
          ohTOT.TcdDate:=mTcd.ohTCI.DocDate;
          ohTOT.GsCode:=mTcd.ohTCI.GsCode;
          ohTOT.DlvQnt:=mTcd.ohTCI.GsQnt;
          ohTOT.Post;
*)          
          // Ulozime odkaz do polozky terminalovej vydajky na dodaci list
          ohTOI.Edit;
          ohTOI.OutQnt:=0;
//          ohTOI.DlvQnt:=ohTOT.SumDlvQnt(ohTOI.DocNum,ohTOI.ItmNum);
          ohTOI.TcdNum:=mTcd.DocNum;
          ohTOI.TcdItm:=mItmNum;
          ohTOI.Post;
          // -------------------------------
          mStk.Sts(ohTOH.StkNum,ohTOI.DocNum,ohTOI.ItmNum,ohTOI.GsCode,ohTOI.GsQnt-ohTOI.DlvQnt,Date); // Zrusi rezervaciu terminalovene vydajky
          // Vyskladnime tovar z pozicneho miesta
(*
          If ohTOP.LocateDoIt(ohTOI.DocNum,ohTOI.ItmNum) then begin
            Repeat
              mSpc.Sub(ohTOH.StkNum,ohTOP.PosOut,ohTOI.GsCode,ohTOH.DocNum,ohTOI.ItmNum,ohTOH.DocDate,ohTOP.OutQnt);
              ohTOP.Edit;
              ohTOP.DlvQnt:=ohTOP.DlvQnt+ohTOP.OutQnt;
              ohTOP.OutQnt:=0;
              ohTOP.Post;
              Application.ProcessMessages;
              ohTOP.Next;
            until ohTOP.Eof or (ohTOP.DocNum<>ohTOI.DocNum) or (ohTOP.ItmNum<>ohTOI.ItmNum);
          end
          else mSpc.Sub(ohTOH.StkNum,'0',ohTOI.GsCode,ohTOH.DocNum,ohTOI.ItmNum,ohTOH.DocDate,ohTOI.GsQnt);
*)
          // Historia operacii nad polozkami dokladov
          mItgLog.Add(ohTOI.DocNum,ohTOI.ItmNum,ohTOI.TcdNum,ohTOI.TcdItm,'TOD');
          Inc (mItmNum);
        end;
        Application.ProcessMessages;
        ohTOI.Next;
      until ohTOI.Eof or (ohTOI.DocNum<>pDocNum);
      mTcd.SubDoc(mTcd.DocNum);
      mTcd.PrnDoc(mTcd.DocNum,'',FALSE,'','',0);
      FreeAndNil (mSav);
      FreeAndNil (mStk);
      FreeAndNil (mSpc);
      FreeAndNil (mTcd);
      FreeAndNil (mItgLog);
    end;
  end;
end;

procedure TTod.TcdRef(pDocNum:Str12;pToi:boolean); // zapise udaje z TOI do TCI
var mTcd:TTcd;  mItmNum:word;
begin
  If ohTOH.LocateDocNum(pDocNum) or ohTOA.LocateDocNum(pDocNum) then begin
    oDocNum:=pDocNum;
    If pToi then begin
      If ohTOI.NearestDoIt(pDocNum,1) and (ohTOI.DocNum=pDocNum) then begin
        mTcd:=TTcd.Create(Self);
        mTcd.Open(gKey.TobTcbNum[ohTOI.BtrTable.BookNum]);
        // Zapiseme udaje z TOT do TCI
        Repeat
          If IsNotNul(ohTOI.GsQnt) and (ohTOI.TcdNum<>'')and (ohTOI.TcdItm>0)
          and mTcd.ohTCI.LocateDoIt(ohTOI.TcdNum,ohTOI.TcdItm) then begin
            mTcd.ohTCI.Edit;
            mTcd.ohTCI.ScdNum:=ohTOI.DocNum;
            mTcd.ohTCI.ScdItm:=ohTOI.ItmNum;
            mTcd.ohTCI.IcdNum:=ohTOI.IcdNum;
            mTcd.ohTCI.IcdItm:=ohTOI.IcdItm;
            If (mTcd.ohTCI.OcdNum='') then begin
              mTcd.ohTCI.OcdNum:=ohTOI.OcdNum;
              mTcd.ohTCI.OcdItm:=ohTOI.OcdItm;
            end;
            If (mTcd.ohTCI.IcdNum='') and (ohTOI.CadNum<>'') then begin
              mTcd.ohTCI.IcdNum:=ohTOI.CadNum;
              mTcd.ohTCI.IcdItm:=ohTOI.CasNum;
            end;
            If (mTcd.ohTCI.IcdNum<>'')and(mTcd.ohTCI.FinStat<>'C')and(mTcd.ohTCI.FinStat<>'Q')
              then mTcd.ohTCI.FinStat:='Q';
            mTcd.ohTCI.Post;
            // -------------------------------
          end;
          Application.ProcessMessages;
          ohTOI.Next;
        until ohTOI.Eof or (ohTOI.DocNum<>pDocNum);
        If mTcd.ohTCH.LocateDocNum(mTcd.ohTCI.DocNum) then mTcd.ohTCH.Clc(mTcd.ohTCI);
        FreeAndNil (mTcd);
      end;
    end else begin
(*
      If ohTOT.NearestDoIt(pDocNum,1) and (ohTOT.DocNum=pDocNum) then begin
        mTcd:=TTcd.Create(Self);
        mTcd.Open(gKey.TobTcbNum[ohTOI.BtrTable.BookNum]);
        // Zapiseme udaje z TOT do TCI
        Repeat
          mItmNum:=mTcd.ohTCI.ItmNum;
          If IsNotNul(ohTOT.DlvQnt) and (ohTOT.TcdNum<>'')and (ohTOT.TcdItm>0)
          and mTcd.ohTCI.LocateDoIt(ohTOT.TcdNum,ohTOT.TcdItm) then begin
            ohTOI.LocateDoIt(pDocNum,ohTOT.ItmNum);
            mTcd.ohTCI.Edit;
            mTcd.ohTCI.ScdNum:=ohTOT.DocNum;
            mTcd.ohTCI.ScdItm:=ohTOT.ItmNum;
            mTcd.ohTCI.IcdNum:=ohTOI.IcdNum;
            mTcd.ohTCI.IcdItm:=ohTOI.IcdItm;
            If (mTcd.ohTCI.IcdNum='') and (ohTOI.CadNum<>'') then begin
              mTcd.ohTCI.IcdNum:=ohTOI.CadNum;
              mTcd.ohTCI.IcdItm:=ohTOI.CasNum;
            end;
            If (mTcd.ohTCI.OcdNum='') then begin
              mTcd.ohTCI.OcdNum:=ohTOI.OcdNum;
              mTcd.ohTCI.OcdItm:=ohTOI.OcdItm;
            end;
            If (mTcd.ohTCI.IcdNum<>'')and(mTcd.ohTCI.FinStat<>'C')and(mTcd.ohTCI.FinStat<>'Q')
              then mTcd.ohTCI.FinStat:='Q';
            mTcd.ohTCI.Post;
            // -------------------------------
          end;
          Application.ProcessMessages;
          ohTOT.Next;
        until ohTOT.Eof or (ohTOT.DocNum<>pDocNum);
        If mTcd.ohTCH.LocateDocNum(mTcd.ohTCI.DocNum) then mTcd.ohTCH.Clc(mTcd.ohTCI);
        FreeAndNil (mTcd);
      end;
*)
    end;
  end;
end;

procedure TTod.TcdRef; // zapise udaje z TOI do TCI
var mTcd:TTcd;  mItmNum:word;
begin
  mTcd:=TTcd.Create(Self);
  mTcd.Open(gKey.TobTcbNum[ohTOH.BtrTable.BookNum]);
  ohTOI.First;
  // Zapiseme udaje z TOI do TCI
  Repeat
    If IsNotNul(ohTOI.GsQnt) and (ohTOI.TcdNum<>'')and (ohTOI.TcdItm>0)
    and mTcd.ohTCI.LocateDoIt(ohTOI.TcdNum,ohTOI.TcdItm) then begin
      mTcd.ohTCI.Edit;
      mTcd.ohTCI.ScdNum:=ohTOI.DocNum;
      mTcd.ohTCI.ScdItm:=ohTOI.ItmNum;
      mTcd.ohTCI.IcdNum:=ohTOI.IcdNum;
      mTcd.ohTCI.IcdItm:=ohTOI.IcdItm;
      If (mTcd.ohTCI.OcdNum='') then begin
        mTcd.ohTCI.OcdNum:=ohTOI.OcdNum;
        mTcd.ohTCI.OcdItm:=ohTOI.OcdItm;
      end;
      If (mTcd.ohTCI.IcdNum='') and (ohTOI.CadNum<>'') then begin
        mTcd.ohTCI.IcdNum:=ohTOI.CadNum;
        mTcd.ohTCI.IcdItm:=ohTOI.CasNum;
      end;
      If (mTcd.ohTCI.IcdNum<>'')and(mTcd.ohTCI.FinStat<>'C')and(mTcd.ohTCI.FinStat<>'Q')
        then mTcd.ohTCI.FinStat:='Q';
      mTcd.ohTCI.Post;
      // -------------------------------
    end;
    Application.ProcessMessages;
    ohTOI.Next;
  until ohTOI.Eof;
  FreeAndNil (mTcd);
end;

procedure TTod.TcdIcv(pDocNum:Str12); // Nacita NC z dodacich listov
begin
  TcdIcvLns(pDocNum,NIL);
end;

procedure TTod.TcdIcvLns(pDocNum:Str12;pLines:TStrings); // Nacita NC z dodacich listov
var mTcd:TTcd;  mItmNum:word;
begin
  mTcd:=TTcd.Create(Self);
  mTcd.Open(gKey.TobTcbNum[ohTOH.BtrTable.BookNum]);
  ohTOI.First;
  If ohTOI.LocateDocNum(pDocNum) and ohTOH.LocateDocNum(pDocNum) then begin
    // Zapiseme udaje z TOI do TCI
    Repeat
      If IsNotNul(ohTOI.GsQnt) and (ohTOI.TcdNum<>'')and (ohTOI.TcdItm>0)
      and mTcd.ohTCI.LocateDoIt(ohTOI.TcdNum,ohTOI.TcdItm) then begin
        If not Eq2(mTcd.ohTCI.AcCValue,ohTOI.CValue) then begin
          If pLines<>NIL then pLines.Add(ohTOI.DocNum+'|'+IntToStr(ohTOI.ItmNum)+'|'+ohTOI.TcdNum+'|'+IntToStr(ohTOI.TcdItm)+'|'+FloatToStr(ohTOI.CValue)+'|'+FloatToStr(mTcd.ohTCI.AcCValue));
          ohTOI.Edit;
          ohTOI.CValue:=mTcd.ohTCI.AcCValue;
          ohTOI.Post;
        end;
        // -------------------------------
      end;
      Application.ProcessMessages;
      ohTOI.Next;
    until ohTOI.Eof or (ohTOI.DocNum<>pDocNum);
    ohTOH.LocateDocNum(pDocNum);
    ohTOI.LocateDocNum(pDocNum);
    ohTOH.Clc(ohTOI);
  end;
  FreeAndNil (mTcd);
end;

procedure TTod.IcdGen(pYear:Str2;pDocNum:Str12); // Vygeneruje odberatelsku fakturu z terminalovej vydajky
begin
  oYear:=pYear;If oYear='' then oYear:=gvsys.ActYear2;
end;

procedure TTod.TopGen; // Vygeneruje skladove pozicie na vydaj
var mFPosQnt,mGsQnt,mResQnt:double;
    mFPosCode,mStr: string;
begin
(*
  ohPOS.Open(ohTOH.StkNum);
  If ohTOI.LocateDocNum(oDocNum) then begin
//    oSpc.StkNum:=ohTOH.StkNum;
    mStr:='';mFPosCode:='';mFPosQnt:=0;
    Repeat
      If not ohTOP.LocateDoIt(ohTOI.DocNum,ohTOI.ItmNum) then begin
        mGsQnt:=ohTOI.GsQnt-ohTOI.DlvQnt-ohTOI.OutQnt;
      end else begin
        mGsQnt:=ohTOI.GsQnt;
        Repeat
          mGsQnt:=mGsQnt-ohTOP.GsQnt;
          ohTOP.Next;
        until ohTOP.Eof or (ohTOP.DocNum<>ohTOI.DocNum) or (ohTOP.ItmNum<>ohTOI.ItmNum);
      end;
      If mGSQnt<>0 then begin
        If oSpc.ohSPC.LocateGsCode(ohTOI.GsCode) then begin // Najdeme skladovu poziciu odkial mozeme vydat tovar
          Repeat
            If oSpc.ohSPC.PosCode<>'1' then begin
              If (mGsQnt<0) then begin
                If mFPosCode='' then mFPosCode:=oSpc.ohSPC.PosCode;
                If ohPOS.LocatePosCode(oSpc.ohSPC.PosCode) and (ohPOS.MaxQnt-oSpc.ohSPC.FreQnt>mFPosQnt)
                then begin
                  mFPosQnt:=ohPOS.MaxQnt-oSpc.ohSPC.FreQnt;
                  mFPosCode:= oSpc.ohSPC.PosCode;
                end;
                If ohPOS.LocatePosCode(oSpc.ohSPC.PosCode) and (ohPOS.MaxQnt-oSpc.ohSPC.FreQnt>(0-mGsQnt)) then begin
                  mFPosQnt:=0-mGsQnt;
                  mResQnt:=mGsQnt;
                  mGsQnt:=0;
                  // Ulozime zaznam do pozicnych pohybov
                  oSpc.ohSPM.Insert;
                  oSpc.ohSPM.PosCode:=oSpc.ohSPC.PosCode;
                  oSpc.ohSPM.GsCode:=oSpc.ohSPC.GsCode;
                  oSpc.ohSPM.GsQnt:=0; // Len rezervacia
                  oSpc.ohSPM.ResQnt:=mResQnt*(-1);
                  oSpc.ohSPM.DocNum:=ohTOI.DocNum;
                  oSpc.ohSPM.ItmNum:=ohTOI.ItmNum;
                  oSpc.ohSPM.DocDate:=ohTOI.DocDate;
                  oSpc.ohSPM.Post;
                  oSpc.Clc(oSpc.ohSPC.PosCode,oSpc.ohSPC.GsCode);
                  // Vegenerujeme poziciu odkial treba vydat tovar
                  ohTOP.Insert;
                  ohTOP.DocNum:=ohTOI.DocNum;
                  ohTOP.ItmNum:=ohTOI.ItmNum;
                  ohTOP.GsCode:=ohTOI.GsCode;
                  ohTOP.GsName:=ohTOI.GsName;
                  ohTOP.GsQnt:=mResQnt;
                  ohTOP.PosOut:=oSpc.ohSPC.PosCode;
                  ohTOP.Post;
                end;
              end else If (oSpc.ohSPC.FreQnt>0) or (mGsQnt<0) then begin
                If (oSpc.ohSPC.FreQnt>=mGsQnt) or (mGsQnt<0) then begin
                  mResQnt:=mGsQnt;
                  mGsQnt:=0;
                end
                else begin
                  mResQnt:=oSpc.ohSPC.FreQnt;
                  mGsQnt:=mGsQnt-oSpc.ohSPC.FreQnt;
                end;
                // Ulozime zaznam do pozicnych pohybov
                oSpc.ohSPM.Insert;
                oSpc.ohSPM.PosCode:=oSpc.ohSPC.PosCode;
                oSpc.ohSPM.GsCode:=oSpc.ohSPC.GsCode;
                oSpc.ohSPM.GsQnt:=0; // Len rezervacia
                oSpc.ohSPM.ResQnt:=mResQnt*(-1);
                oSpc.ohSPM.DocNum:=ohTOI.DocNum;
                oSpc.ohSPM.ItmNum:=ohTOI.ItmNum;
                oSpc.ohSPM.DocDate:=ohTOI.DocDate;
                oSpc.ohSPM.Post;
                oSpc.Clc(oSpc.ohSPC.PosCode,oSpc.ohSPC.GsCode);
                // Vegenerujeme poziciu odkial treba vydat tovar
                ohTOP.Insert;
                ohTOP.DocNum:=ohTOI.DocNum;
                ohTOP.ItmNum:=ohTOI.ItmNum;
                ohTOP.GsCode:=ohTOI.GsCode;
                ohTOP.GsName:=ohTOI.GsName;
                ohTOP.GsQnt:=mResQnt;
                ohTOP.PosOut:=oSpc.ohSPC.PosCode;
                ohTOP.Post;
              end;
            end;
            oSpc.ohSPC.Next;
          until oSpc.ohSPC.Eof or (oSpc.ohSPC.GsCode<>ohTOI.GsCode) or IsNul(mGsQnt);
          If (mGsQnt<0) and (mFPosCode<>'') then begin
            If oSpc.ohSPC.LocatePoGs(mFPosCode,ohTOI.GsCode) then begin
              // Ulozime zaznam do pozicnych pohybov
              oSpc.ohSPM.Insert;
              oSpc.ohSPM.PosCode:=oSpc.ohSPC.PosCode;
              oSpc.ohSPM.GsCode:=oSpc.ohSPC.GsCode;
              oSpc.ohSPM.GsQnt:=0; // Len rezervacia
              oSpc.ohSPM.ResQnt:=0-mGsQnt;
              oSpc.ohSPM.DocNum:=ohTOI.DocNum;
              oSpc.ohSPM.ItmNum:=ohTOI.ItmNum;
              oSpc.ohSPM.DocDate:=ohTOI.DocDate;
              oSpc.ohSPM.Post;
              oSpc.Clc(oSpc.ohSPC.PosCode,oSpc.ohSPC.GsCode);
              // Vegenerujeme poziciu odkial treba vydat tovar
              ohTOP.Insert;
              ohTOP.DocNum:=ohTOI.DocNum;
              ohTOP.ItmNum:=ohTOI.ItmNum;
              ohTOP.GsCode:=ohTOI.GsCode;
              ohTOP.GsName:=ohTOI.GsName;
              ohTOP.GsQnt:=mGsQnt;
              ohTOP.PosOut:=oSpc.ohSPC.PosCode;
              ohTOP.Post;
            end;
          end;
        end;
        If IsNotNul (mGSQnt) then mStr:=mStr+StrInt(ohTOI.GsCode,6)+' '+AlignRight(ohTOI.GsName,25)+' '+StrDoub(mGsQnt,7,3)+#13+#10;
      end;
      Application.ProcessMessages;
      ohTOI.Next;
    until ohTOI.Eof or (ohTOI.DocNum<>ohTOH.DocNum);
    If mStr<>'' then NexMsg.ShowMsg(ecTomNotEnoughPos,mStr);
  end;
  ohPOS.Close;
*)
end;

procedure TTod.TodArc; // Premiestni hlavicku aktualneho dokladu do archivu
begin
(*
  If ohTOA.LocateDocNum(ohTOH.DocNum)
    then ohTOA.Edit
    else ohTOA.Insert;
  BTR_To_BTR (ohTOH.BtrTable,ohTOA.BtrTable);
  ohTOA.Status:='A';
  ohTOA.Post;
  ohTOH.Delete;
*)
end;

procedure TTod.IcnSav(pDocNum:Str12;pItmNum:word;pIcdNum:Str12;pIcdItm:word); // Ulozi odkaz na OF do zadanej polozky terminalovej vydajky
begin
  BokNum:=BookNumFromDocNum(pDocNum);
  If ohTOI.LocateDoIt(pDocNum,pItmNum) then begin
    ohTOI.Edit;
    ohTOI.IcdNum:=pIcdNum;
    ohTOI.IcdItm:=pIcdItm;
    ohTOI.Post;
    AddClc(pDocNum);
  end;
end;

procedure TTod.AddTot(pTodNum:Str12;pTodItm:word;pTcdNum:Str12;pTcdItm:word;pTcdDate:TDateTime;pGsCode:longint;pDlvQnt:double); // Ulozi zaznam o vsytavenom dodacom liste k zadane polozke
begin
(*
  ohTOT.Insert;
  ohTOT.DocNum :=
  ohTOT.ItmNum
  ohTOT.TcdNum
  ohTOT.TcdItm
  ohTOT.TcdDate
  ohTOT.GsCode
  ohTOT.DlvQnt
  ohTOT.Post;
*)
end;

procedure TTod.Open(pBokNum:Str5); 
begin
  Open(pBokNum,TRUE,TRUE,TRUE);
end;

procedure TTod.Open(pBokNum:Str5;pTOH,pTOI,pTOA:boolean);
var mFind:boolean;  mCnt:word;  mDat:PDat;
begin
  oBokNum:=pBokNum;
  mFind:=FALSE;
  If oLst.Count>0 then begin
    mCnt:=0;
    Repeat
      Inc(mCnt);
      Activate(mCnt);
      mFind:=ActBok=pBokNum;
    until mFind or (mCnt=oLst.Count);
  end;
  If not mFind then begin // Ak dana kniha este nie je otvorena potomotvorime
    oOpnBok.Add(pBokNum);  // <<< Zistit ci treba tuto premennu pouzivat >>>
    // Vytvorime objekty
    ohTOH:=TTohHnd.Create;
    ohTOI:=TToiHnd.Create;
    ohTOA:=TToaHnd.Create;
    // Otvorime databazove subory
    If pTOH then ohTOH.Open(pBokNum);
    If pTOI then ohTOI.Open(pBokNum);
    If pTOA then ohTOA.Open(pBokNum);
    // Ulozime objekty do zoznamu
    GetMem(mDat,SizeOf(TDat));
    mDat^.rhTOH:=ohTOH;
    mDat^.rhTOI:=ohTOI;
    mDat^.rhTOA:=ohTOA;
    oLst.Add(mDat);
  end;
end;

function TTod.ActBok:Str5;
begin
  Result:='';
  If ohTOH.BtrTable.Active
    then Result:=ohTOH.BtrTable.BookNum
    else begin
      If ohTOI.BtrTable.Active
        then Result:=ohTOI.BtrTable.BookNum
        else begin
          If ohTOA.BtrTable.Active then Result:=ohTOA.BtrTable.BookNum
        end;
    end;
end;

procedure TTod.Activate(pIndex:word); // Aktivuje databazu, ktora je otvorena pod poradovym cislom pIndex
var mDat:PDat;
begin
  mDat:=oLst.Items[pIndex-1];
  ohTOH:=mDat.rhTOH;
  ohTOA:=mDat.rhTOA;
  ohTOI:=mDat.rhTOI;
end;

function TTod.Del(pDocNum:Str12;pHedDel:boolean):boolean;  // Zrusi zadany doklad
begin
(*
  Result:=TRUE;
  If ohTOH.LocateDocNum(pDocNum) then begin
    If Uns(pDocNum) then begin
      If ohTOI.LocateDocNum(pDocNum) then begin
        Repeat
          Application.ProcessMessages;
          If ohTOI.StkStat='N'
            then ohTOI.Delete
            else begin
              Result:=FALSE;
              ohTOI.Next;
            end;
        until ohTOI.Eof or (ohTOI.Count=0) or (ohTOI.DocNum<>pDocNum);
      end;
    end;
    ohTOH.Clc(ohTOI);
    Result:=ohTOH.ItmQnt=0; // Je to v poriadku ak doklad nema ziadne polozky
    If Result and pHedDel then ohTOH.Delete;  // Ak je nastavene zrusenie hlavicky a bola vymazana kazda polozka zrusime hlavicku dokladu
  end;
*)
end;


procedure TTod.DtrTra(pDocNum: Str12);
var //mhAgrItm : TAgrItmhnd;
    mhAplItm : TAplItmhnd;
    mhFgPaDsc: TFgPaDschnd;
    mhDlrDsc : TDlrDschnd;
    mhDlrLst : TDlrLsthnd;
    mhPls    : TPlsHnd;
    mhPab    : TPabHnd;
    mItmData: TItmData; // Udaje vybranej polozky
begin
  ohTOH.LocateDocNum(pDocNum);ohTOI.LocateDocNum(pDocNum);
//  mhAgrItm:=TAgritmHnd.Create;   mhAgrItm.Open;  mhAgrItm.SetIndex(bAGRITM.ixPaGs);
  mhAPLITM:=TAplitmHnd.Create;   mhAPLITM.Open;  mhAPLITM.SetIndex(bAPLITM.ixAnGs);;
  mhFgPaDsc:=TFgPaDscHnd.Create; mhFgPaDsc.Open; mhFgPaDsc.SetIndex(bFgPaDsc.ixPaFg);;
  mhDlrDsc:=TDlrDscHnd.Create;   mhDlrDsc.Open;  //mhDlrDsc.SetIndex(bDlrDsc.ixAnGs);;
  mhDlrLst:=TDlrLstHnd.Create;   mhDlrLst.Open;  //mhDlrLst.SetIndex(bDlrLst.ixAnGs);;
  mhPab:=TPabHnd.Create;         mhPab.Open(0);  mhPab.SetIndex(bPab.ixPaCode);
  mhPls:=TPlsHnd.Create;
  If mhPAB.LocatePaCode(ohTOH.PaCode) then begin
    mItmData.IcPlsNum:=mhPAB.IcPlsNum;
    mItmData.IcAplNum:=mhPAB.IcAplNum;
    mItmData.IcDscPrc:=mhPAB.IcDscPrc;
    mItmData.IcFacPrc:=mhPAB.IcFacPrc;
  end else begin
    mItmData.IcPlsNum:=1;
    mItmData.IcAplNum:=0;
    mItmData.IcDscPrc:=0;
    mItmData.IcFacPrc:=0;
  end;
  If mItmData.IcPlsNum=0 then mItmData.IcPlsNum:=1;
  mhPLS.Open(mItmData.IcPlsNum);

  ohTOI.LocateDocNum(ohTOH.DocNum);
  If (ohToi.DocNum=pDocNum)and(ohToh.DocNum=pDocNum) then begin
    Repeat
      If (ohTOI.GsQnt<>0) then begin
        fillchar(mItmData,SizeOF(mItmData),0);
        mItmData.FgCourse:=1;
        mItmData.PaCode  :=ohTOH.PaCode;
        mItmData.GsCode  :=ohTOI.GsCode;
        mItmData.VatPrc  :=ohTOI.VatPrc;
        mItmData.DlrCode :=0;
        mItmData.DocDate :=ohTOI.DocDate;
        If mhPLS.LocateGsCode(ohTOI.GsCode) then begin
          mItmData.DscPrc  :=0;
          mItmData.FgAPrice:=mhPLS.APrice;
          mItmData.FgDPrice:=mhPLS.APrice;
          mItmData.FgBPrice:=mhPLS.BPrice;
          mItmData.FgHPrice:=mhPLS.BPrice;
          mItmData.FgCode  :=mhPLS.FgCode;
        end else begin
          mItmData.DscPrc  :=ohTOI.DscPrc;
          mItmData.FgAPrice:=ohTOI.BPrice/(1+ohTOI.VatPrc/100);
          mItmData.FgDPrice:=ohTOI.HPrice/(1+ohTOI.VatPrc/100);
          mItmData.FgBPrice:=ohTOI.BPrice;
          mItmData.FgHPrice:=ohTOI.HPrice;
        end;
        mItmData.AcCPrice:=ohTOI.CValue/ohTOI.GsQnt;
        mItmData.GsQnt   :=ohTOI.GSQnt;
        mItmData.FgAValue:=Rd2(mItmData.FgAPrice*mItmData.GsQnt);
        mItmData.FgDValue:=Rd2(mItmData.FgDPrice*mItmData.GsQnt);
        mItmData.FgBValue:=Rd2(mItmData.FgBPrice*mItmData.GsQnt);
        mItmData.FgHValue:=Rd2(mItmData.FgHPrice*mItmData.GsQnt);
//        mItmData.FgAValue:=Rd2(mItmData.FgBValue/(1+mItmData.VatPrc/100));
        If mhPAB.LocatePaCode(mItmData.PaCode) then begin
          mItmData.IcPlsNum:=mhPAB.IcPlsNum;
          mItmData.IcAplNum:=mhPAB.IcAplNum;
          mItmData.IcDscPrc:=mhPAB.IcDscPrc;
          mItmData.IcFacPrc:=mhPAB.IcFacPrc;
        end else begin
          mItmData.IcPlsNum:=1;
          mItmData.IcAplNum:=1;
          mItmData.IcDscPrc:=0;
          mItmData.IcFacPrc:=0;
        end;
        If mItmData.IcPlsNum=0 then mItmData.IcPlsNum:=1;
        mItmData.FgFract :=2;
//        DetermineTra (mItmData,4,2,mhAgrItm.BtrTable,mhAplItm.BtrTable,mhFgPaDsc.BtrTable,mhDlrDsc.BtrTable,mhDlrLst.BtrTable); // Zistime ceny podla obchodnych podmienok odberatela
        DetermineTra (mItmData,4,2,mhAplItm.BtrTable,mhFgPaDsc.BtrTable,mhDlrDsc.BtrTable,mhDlrLst.BtrTable); // Zistime ceny podla obchodnych podmienok odberatela
        If not Eqd(ohTOI.BPrice,mItmData.FgBPrice,0.001) then begin
          WriteToLogFile(gPath.SysPath+copy(pDocNum,1,7)+'.LOG',
          'Zmena PC DetermineTra '+ohTOI.DocNum+'/'+IntToStr(ohTOI.ItmNum));
          WriteToLogFile(gPath.SysPath+copy(pDocNum,1,7)+'.LOG',
          '  '+StrDoub(ohTOI.BPrice,12,3)+' << '+StrDoub(mItmData.FgBPrice,12,3));
        end;
        ohTOI.Edit;
        // TOI.BDF
        ohTOI.DscPrc:=mItmData.DscPrc;        // Zlava
        ohTOI.HPrice:=mItmData.FgHPrice;      // PC/MJ s DPH pred zlavou vo vyuctovnej mene
        ohTOI.BPrice:=mItmData.FgBPrice;      // PC/MJ s DPH po zlave vo vyuctovnej mene
        ohTOI.DValue:=mItmData.FgDValue;      // PC bez DPH pred zlavou vo vyuctovnej mene
        ohTOI.HValue:=mItmData.FgHValue;      // PC s DPH pred zlavou vo vyuctovnej mene
        ohTOI.AValue:=mItmData.FgAValue;      // PC bez DPH po zlave vo vyuctovnej mene
        ohTOI.BValue:=mItmData.FgBValue;      // PC s DPH po zlave vo vyuctovnej mene
        ohTOI.Post;
      end;
      ohTOI.Next;
    until (ohTOI.Eof) or (ohTOI.DocNum<>pDocNum);
  end;

//  mhAgrItm.Close; FreeAndNil(mhAgrItm);
  mhAPLITM.Close; FreeAndNil(mhAPLITM);
  mhFgPaDsc.Close;FreeAndNil(mhFgPaDsc);
  mhDlrDsc.Close; FreeAndNil(mhDlrDsc);
  mhDlrLst.Close; FreeAndNil(mhDlrLst);
  mhPab.Close;    FreeAndNil(mhPab);
  mhPls.Close;    FreeAndNil(mhPls);

  DocClc;
end;

end.
