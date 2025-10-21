unit Sad;
{$F+}

// *****************************************************************************
//                OBJEKT NA PRACU SO Skladovymi vydajkami MO predaja
// *****************************************************************************
// Programové funkcia:
// ---------------
// *****************************************************************************


interface

uses
  IcValue, IcTypes, IcConst, IcConv, IcTools, IcDate, IcVariab,  NexGlob, NexPath, NexIni, NexText, NexMsg, NexError,
  TxtDoc, TxtWrap, PsDayData, JrnAcc, DocHand, StkCanc, Stk, Key, Csd, Idd, Adv, PayFnc,
  hGsCat, hCph, hCpi, hCabLst, hSAH, hSAI, hSAC, hSAP, hICH,
  hAccSnt, hAccAnl,// hSAG,
  ComCtrls, SysUtils, Classes, Forms;

type
  PDat=^TDat;
  TDat=record
    rhSAH:TSAHHnd;
    rhSAI:TSAIHnd;
    rhSAC:TSACHnd;
    rhSAP:TSAPHnd;
  end;

  TSad = class(TComponent)
    constructor Create(AOwner: TComponent);
    destructor  Destroy; override;
    private
      oFrmName:Str15;
      oBokNum:Str5;
      oLst:TList;

      oDocNum: Str12;
      oDocDate: TDateTime;
      ohCPH:TCphHnd;
      ohCPI:TCpiHnd;
      ohGSCAT:TGscatHnd;
      oInd:TProgressBar;
      procedure Activate(pIndex:word); // Aktivuje databazu, ktora je otvorena pod poradovym cislom pIndex
    public
      ohSAH: TSAHHnd;
      ohSAI: TSAIHnd;
      ohSAC: TSACHnd;
//      ohSAG: TSAGHnd;
      ohSAP: TSAPHnd;
      oPay:TPayFnc;
      procedure Open(pBokNum:Str5); overload; // Otvori vsetky databazove subory
      procedure Open(pBokNum:Str5;pSAH,pSAI,pSAC,pSAG,pSAP:boolean); overload;// Otvori zadane databazove subory
      procedure Prn; // Vytlaèí aktualnu fakturu
      procedure AccSap(pDocNum:Str12);  // zauctuje uhrady FA cez ERP
      procedure AccSad(pDocNum:Str12;pWriNum:integer);  // zauctuje registracnu pokladnu
      procedure LocDoc(pDocNum:Str12);   // Vyhlada doklad
      procedure SubDoc; overload; // Vyskladni tovar zo zadaneho dokladu
      procedure SubDoc(pDocNum:Str12); overload; // Vyskladni tovar zo zadaneho dokladu
      procedure ClcDoc; overload; // Prepocita hlavicku aktualneho dokladu
      procedure ClcDoc(pDocNum:Str12); overload; // prepocita hlavicku zadaneho dokladu

      procedure AddItc(pDocNum:Str12;pItmNum,pStkNum:longint); // Prida komponenty polozky na zadany doklad
      procedure ModItc(pDocNum:Str12;pItmNum,pStkNum:longint); // Zmeni mnozstvo komponentov polozky na zadany doklad
      function  IssItc(pDocNum:Str12;pItmNum,pStkNum,pParent:longint):boolean; // Zisti ci su vsetky komponenty vyskladnene

      procedure AddSac(pItmNum,pParent,pStkNum,pGsCode,pPdCode:longint;pGsQnt,pAcCPrice,pDscPrc,pFgBPrice:double;pWriNum:longint);  // Prida novu polozku na zadany doklad
      procedure UnsSac(pDocNum:Str12;pItmNum,pStkNum,pParent:longint); // vystornuje komponenty polozky dokladu
      function  DelSac(pDocNum:Str12;pItmNum,pStkNum,pParent:longint):boolean; // Zrusime komponenty polozky dokladu ak su nevyskladnene
      procedure InsSac(var pNextNum:word;pItmNum,pSacNum:longint;pDocDate:TDateTime;pStkNum:integer;pGsQnt:double);
      procedure ModSac(pItmNum,pSacNum:longint;pGsQnt:double);
      procedure SubSac(pDocNum:Str12;pItmNum,pStkNum,pSACNum:longint); // vyda komponenty polozky dokladu
      function  ClcSac(pDocNum:Str12;pItmNum,pStkNum,pSACNum:longint):double; // sumarizuje NC vyrobku
      procedure ClcSacAll(pDocNum:Str12;pItmNum,pStkNum,pSACNum:longint;var pSeQnt,pSuQnt,pCValue:double); // sumarizuje NC vyrobku

      function  SacDocNum(pDocNum:Str12):Str12;

    published
      property BokNum:Str5 read oBokNum;
      property DocNum:Str12 read oDocNum;
      property DocDate:TDateTime write oDocDate;
      property Ind:TProgressBar read oInd write oInd;
  end;

implementation

uses bSAH, bSAC, bICH, bSAP, bSAI, bCPI;

constructor TSad.Create(AOwner: TComponent);
begin
  If AOwner<>NIL
    then oFrmName:=AOwner.Name
    else oFrmName:='TSad';
  oLst:=TList.Create;  oLst.Clear;
  ohGSCAT:=TGscatHnd.Create;  ohGSCAT.Open;
  ohCPH:=TCphHnd.Create;
  ohCPI:=TCpiHnd.Create;
end;

destructor TSad.Destroy;
var I:word;
begin
  If oLst.Count>0 then begin
    For I:=1 to oLst.Count do begin
      Activate (I);
//      FreeAndNil (ohSAG);
      FreeAndNil (ohSAP);
      FreeAndNil (ohSAC);
      FreeAndNil (ohSAI);
      FreeAndNil (ohSAH);
    end;
  end;
  FreeAndNil (oLst);
  FreeAndNil (ohCPH);
  FreeAndNil (ohCPI);
  FreeAndNil (ohGSCAT);
end;

// ********************************* PRIVATE ***********************************

procedure TSad.Activate(pIndex:word); // Aktivuje databazu, ktora je otvorena pod poradovym cislom pIndex
var mDat:PDat;
begin
  mDat:=oLst.Items[pIndex-1];
  ohSAH:=mDat.rhSAH;
  ohSAI:=mDat.rhSAI;
  ohSAC:=mDat.rhSAC;
  ohSAP:=mDat.rhSAP;
//  ohSAG:=mDat.rhSAG;
  ohCPH.Close;
  ohCPI.Close;
  If gKey.SabCpiBok[ohSAH.BokNum]<>'' then
  begin
    ohCPH.Open(gKey.SabCpiBok[ohSAH.BokNum]);
    ohCPI.Open(gKey.SabCpiBok[ohSAH.BokNum]);
  end;
end;

// ********************************** PUBLIC ***********************************

procedure TSad.Open(pBokNum:Str5); // Otvori vsetky databazove subory
begin
  Open (pBokNum,TRUE,TRUE,TRUE,TRUE,TRUE);
end;

procedure TSad.Open(pBokNum:Str5;pSAH,pSAI,pSAC,pSAG,pSAP:boolean); // Otvori zadane databazove subory
var mFind:boolean;  mCnt:word;  mDat:PDat;
begin
  oBokNum:=pBokNum;
  mFind:=FALSE;
  If oLst.Count>0 then begin
    mCnt:=0;
    Repeat
      Inc (mCnt);
      Activate(mCnt);
      mFind:=ohSAH.BtrTable.BookNum=pBokNum;
    until mFind or (mCnt=oLst.Count);
  end;
  If not mFind then begin // Ak dana kniha este nie je otvorena potomotvorime
    // Vytvorime objekty
    ohSAH:=TSAHHnd.Create;
    ohSAI:=TSAIHnd.Create;
    ohSAC:=TSACHnd.Create;
    ohSAP:=TSAPHnd.Create;
//    ohSAG:=TSAGHnd.Create;
    // Otvorime databazove subory
    If pSAH then ohSAH.Open(pBokNum);
    If pSAI then ohSAI.Open(pBokNum);
    If pSAC then ohSAC.Open(pBokNum);
//    If pSAG then ohSAG.Open(pBokNum);
    If pSAP then ohSAP.Open(pBokNum);
    ohCPH.Close;
    ohCPI.Close;
    If gKey.SabCpiBok[ohSAH.BokNum]<>'' then
    begin
      ohCPH.Open(gKey.SabCpiBok[ohSAH.BokNum]);
      ohCPI.Open(gKey.SabCpiBok[ohSAH.BokNum]);
    end;
    // Ulozime objekty do zoznamu
    GetMem (mDat,SizeOf(TDat));
    mDat^.rhSAH:=ohSAH;
    mDat^.rhSAI:=ohSAI;
    mDat^.rhSAC:=ohSAC;
//    mDat^.rhSAG:=ohSAG;
    mDat^.rhSAP:=ohSAP;
    oLst.Add(mDat);
  end;
end;

procedure TSad.Prn; // Vytlaèí aktualnu fakturu
begin
end;

procedure TSad.AccSap(pDocNum:Str12); // zauctuje uhrady FA cez ERP
var mCsd:TCsd; mPaCode:longint; mPaVal:double; mExtNum:Str20; mCsdNum:Str12;
    mhICH:TIchHnd;mAccAnl:Str6;mAccSnt:Str3;mhAccSnt:TAccsntHnd;mhAccAnl:TAccAnlHnd;
  procedure SapToCsi;
  begin
    ohSAP.LocateDnPc(pDocNum,mPaCode);
    repeat
      mAccSnt:=gkey.IcbDocSnt[BookNumFromDocNum(ohSAP.IcdNum)];
      mAccAnl:=AccAnlGen(gkey.IcbDocAnl[BookNumFromDocNum(ohSAP.IcdNum)],mPaCode);
      If not mhAccAnl.LocateSnAn(mAccSnt,mAccAnl) then begin
        mhAccAnl.Insert;
        mhAccAnl.AccSnt:=mAccSnt;
        mhAccAnl.AccAnl:=mAccAnl;
        mhAccAnl.AnlName:=ohSAP.PaName;
        mhAccAnl.Post;
      end;
      mCsd.AddItmAcc(mCsdNum,gKey.SabIcpCoi[ohSAH.BtrTable.BookNum],0,ohSAP.PayVal,ohSAP.IcdNum,ohSAP.IceNum,mAccSnt,mAccAnl,gNT.GetText('IcbPayTxt','Úhrada faktúry ')+' '+ohSAP.IceNum,0);
      ohSAP.Next;
    until ohSAP.Eof or (mPaCode<>ohSAP.PaCode) or (pDocNum<>ohSAP.DocNum);
  end;

  procedure CsdNumToSap;
  begin
    ohSAP.LocateDnPc(pDocNum,mPaCode);
    Repeat
      ohSAP.Edit;
      ohSAP.CsdNum:=mCsdNum;
      ohSAP.Post;
      oPay.ClcPayVal(ohSAP.IcdNum,Date,0);
      If ohSAP.IcdNum<>'' then begin
        mhICH.Open(BookNumFromDocNum(ohSAP.IcdNum));
        If mhICH.LocateDocNum(ohSAP.IcdNum) then
        begin
          mhICH.Edit;
          mhICH.AcPayVal:= oPay.InvAcv;
          mhICH.FgPayVal:= oPay.InvVal;
          mhICH.AcEndVal:= mhICH.AcBValue-mhICH.AcPayVal-mhICH.EyCrdVal;
          mhICH.FgEndVal:= mhICH.FgBValue-mhICH.FgPayVal;
          If mhICH.PayDate<ohSAP.DocDate then mhICH.PayDate:=ohSAP.DocDate;
          mhICH.DstPay :=byte(Eq2(mhICH.AcEndVal,0) and Eq2(mhICH.FgEndVal,0));
          mhICH.Post;
        end;
      end;
      ohSAP.Next;
    until ohSAP.Eof or (mPaCode<>ohSAP.PaCode) or (pDocNum<>ohSAP.DocNum);
  end;

begin
  If ohSAH.BtrTable.BookNum<>BookNumFromDocNum(pDocNum) then Open(BookNumFromDocNum(pDocNum));
  If (gKey.SabIcpCsb[ohSAH.BtrTable.BookNum]<>'')and ohSAP.NearestDnPc(pDocNum,0) and (ohSAP.DocNum=pDocNum) then begin
    mhICH:=TIchHnd.Create;
    mhAccSnt:=TAccsntHnd.Create;mhAccSnt.Open;
    mhAccAnl:=TAccanlHnd.Create;mhAccAnl.Open;
    oPay:=TPayFnc.Create;
    mCsd:=TCsd.Create(Self);mCsd.Open(gKey.SabIcpCsb[ohSAH.BtrTable.BookNum]);
    mCsdNum:='';mPaVal:=0;
    repeat
      ohSAH.LocateDocNum(ohSAP.DocNum);
      mPaCode:=ohSAP.PaCode;mExtNum:=ohSAP.IceNum;mCsdNum:=ohSAP.CsdNum;mPaVal:=0;
      repeat
        If mCsdNum='' then mCsdNum:=ohSAP.CsdNum;
        mPaVal:=mPaVal+ohSAP.PayVal;
        ohSAP.Next;
      until ohSAP.Eof or (mPaCode<>ohSAP.PaCode) or (pDocNum<>ohSAP.DocNum);
      If mCsdNum='' then begin
        mCsd.NewDoc(YearS(ohSAH.DocDate),0,mPaCode,ohSAH.DocDate,'','I');
        mCsd.CnfDoc; // Potvrdenie dokladu nastavi priznak rezervacie DstLck=9 na 0
        mCsdNum:=mCsd.ohCSH.DocNum;
        SapToCsi;
        mCsd.ClcDoc(mCsdNum);
        mCsd.AccDoc;
      end else begin
        If not mCsd.ohCSH.LocateDocNum(mCsdNum) or (mCsd.ohCSH.PaCode<>mPaCode)
        or (mCsd.ohCSH.DocType<>'I') or (mCsd.ohCSH.DocDate<>ohSAH.DocDate) then begin
          mCsd.NewDoc(YearS(ohSAH.DocDate),SerNumFromDocNum(mCsdNum),mPaCode,ohSAH.DocDate,'','I');
          mCsd.CnfDoc; // Potvrdenie dokladu nastavi priznak rezervacie DstLck=9 na 0
        end;
        mCsd.ClcDoc(mCsdNum);
        If mCsd.ohCSI.LocateDocNum(mCsdNum) then begin
          If not Eq2(mCsd.ohCSH.PyBValue,mPaVal) then begin
            while mCsd.ohCSI.LocateDocNum(mCsdNum) do mCsd.ohCSI.Delete;
            SapToCsi;
          end;
        end else begin
          SapToCsi;
        end;
        mCsd.ClcDoc(mCsdNum);
        mCsd.AccDoc;
      end;
      CsdNumToSap;
    until ohSAP.Eof or (ohSAP.DocNum<>pDocNum);
    FreeAndNil(mCsd);
    FreeAndNil(oPay);
    FreeAndNil(mhICH);
    FreeAndNil(mhAccSnt);
    FreeAndNil(mhAccAnl);
  end;
end;

procedure TSad.AccSad(pDocNum:Str12;pWriNum:integer);  // zauctuje registracnu pokladnu
var mBokNum:Str5; mSvcMgc:longint;  mhCABLST:TCablstHnd;  mPsDay:TPsDayData; mDocDate: TDateTime;
    mSecVal,mGscVal,mBValue,mCValue,mVatVal,mSpiBvl,mSpeBvl,mSpiVat,mSpeVat,mCseVal,mCrcVal,mCsiVal,mIncVal: double;
    mBvlDoc,mDocNum,mCvlDoc,mSpiDoc,mSpeDoc,mSpvDoc,mCseDoc,mCsiDoc,mIncCsi,mIncCse: Str12;
    oDBVal:array [1..5] of double;
    oDVVal:array [1..5] of double;
    oGscValA,oGscValB,oSecValA,oSecValB:double;
    oSpiValA,oSpiValB,oSpeValA,oSpeValB:TValue8;
    mServiceMg,mgKey_SysAdvGsc,mgKey_MarAdvGsc:longint;I,mVatQnt:byte;

  procedure BvlDocGen;
  var mCsd:TCsd;   mSecBvl,mGscBvl,mSecVat,mGscVat:double;
  begin
    If IsNotNul(mBValue) then begin
      mCsd:=TCsd.Create(Self);   mCsd.Open(gKey.SabEcrCsb[ohSAH.BtrTable.BookNum]);
      If mBvlDoc='' then begin // Vygenerujeme novy pokladnicny doklad
        mCsd.NewDoc(YearS(ohSAH.DocDate),0,0,ohSAH.DocDate,'','I');
        mCsd.CnfDoc; // Potvrdenie dokladu nastavi priznak rezervacie DstLck=9 na 0
        mBvlDoc:=mCsd.ohCSH.DocNum;    Application.ProcessMessages;
        If gKey.SabAccDcl[oBokNum] then begin
          mCsd.AddItm(mBvlDoc,gKey.SabBseCoi[oBokNum],oSecValB-oSecValA,oSecValB,'','');
          mCsd.AddItmAcc(mBvlDoc,gKey.SabBgsCoi[oBokNum],oDVVal[1],oDBVal[1],'','','','','',gIni.GetVatPrc(1));
          mCsd.AddItmAcc(mBvlDoc,gKey.SabBgsCoi[oBokNum],
            oDVVal[2]-(oSecValB-oSecValA)-(oSpiValB[0]-oSpiValA[0])-(oSpeValB[0]-oSpeValA[0]),
            oDBVal[2]-oSecValB-oSpiValB[0]-oSpeValB[0],'','','','','',gIni.GetVatPrc(2));
          mCsd.AddItmAcc(mBvlDoc,gKey.SabBgsCoi[oBokNum],oDVVal[3],oDBVal[3],'','','','','',gIni.GetVatPrc(3));
        end else begin
          mCsd.AddItm(mBvlDoc,gKey.SabBseCoi[oBokNum],oSecValB-oSecValA,oSecValB,'','');
          mCsd.AddItm(mBvlDoc,gKey.SabBgsCoi[oBokNum],oGscValB-oGscValA,oGscValB,'','');
        end;
        mCsd.ClcDoc(mBvlDoc);
        mCsd.AccDoc;
        If ohSAH.LocateDocNum(mDocNum) then begin
          ohSAH.Edit;
          ohSAH.BvlDoc:=mBvlDoc;
          ohSAH.Post;
        end;
      end
      else begin  // Opravime existujuci pokladnicny doklad

      end;
      FreeAndNil(mCsd);
    end;
  end;

  procedure CvlDocGen;
  begin
  end;

  procedure SpiDocGen;
  var mCsd:TCsd;
  begin
    If IsNotNul(mSpiBvl) then begin
      mCsd:=TCsd.Create(Self);   mCsd.Open(gKey.SabEcrCsb[ohSAH.BtrTable.BookNum]);
      If mSpiDoc='' then begin // Vygenerujeme novy pokladnicny doklad
        mCsd.NewDoc(YearS(ohSAH.DocDate),0,0,ohSAH.DocDate,'','I');
        mCsd.CnfDoc; // Potvrdenie dokladu nastavi priznak rezervacie DstLck=9 na 0
        mSpiDoc:=mCsd.ohCSH.DocNum;    Application.ProcessMessages;
        mCsd.AddItm(mSpiDoc,gKey.SabSpiCoi[ohSAH.BtrTable.BookNum],0,mSpiBvl,'',mDocNum);
        mCsd.ClcDoc(mSpiDoc);
        mCsd.AccDoc;
        If ohSAH.LocateDocNum(mDocNum) then begin
          ohSAH.Edit;
          ohSAH.SpiDoc:=mSpiDoc;
          ohSAH.Post;
        end;
      end
      else begin  // Opravime existujuci pokladnicny doklad

      end;
      FreeAndNil(mCsd);
    end;
  end;

  procedure SpeDocGen;
  var mCsd:TCsd;
  begin
    If IsNotNul(mSpeBvl) then begin
      mCsd:=TCsd.Create(Self);   mCsd.Open(gKey.SabEcrCsb[ohSAH.BtrTable.BookNum]);
      If mSpeDoc='' then begin // Vygenerujeme novy pokladnicny doklad
        mCsd.NewDoc(YearS(ohSAH.DocDate),0,0,ohSAH.DocDate,'','E');
        mCsd.CnfDoc; // Potvrdenie dokladu nastavi priznak rezervacie DstLck=9 na 0
        mSpeDoc:=mCsd.ohCSH.DocNum;    Application.ProcessMessages;
        mCsd.AddItm(mSpeDoc,gKey.SabSpeCoe[ohSAH.BtrTable.BookNum],0,mSpeBvl,'',mDocNum);
        mCsd.ClcDoc(mSpeDoc);
        mCsd.AccDoc;
        If ohSAH.LocateDocNum(mDocNum) then begin
          ohSAH.Edit;
          ohSAH.SpeDoc:=mSpeDoc;
          ohSAH.Post;
        end;
      end
      else begin  // Opravime existujuci pokladnicny doklad

      end;
      FreeAndNil(mCsd);
    end;
  end;

  procedure SpvDocGen;
  var mIdd:TIdd;
  begin
    If IsNotNul(mSpiVat) or IsNotNul(mSpeVat)  then begin
      mIdd:=TIdd.Create(Self);   mIdd.Open(gKey.SabIdbNum[ohSAH.BtrTable.BookNum]);
      If mSpvDoc='' then begin // Vygenerujeme novy pokladnicny doklad
        mIdd.NewDoc(YearS(ohSAH.DocDate),0,0,ohSAH.DocDate,'',FALSE);
        mIdd.ohIDH.Edit;
        mIdd.ohIDH.ExtNum:=mDocNum;
        mIdd.ohIDH.VtcSpc:=205;
        mIdd.ohIDH.Post;

        mSpvDoc:=mIdd.ohIDH.DocNum;    Application.ProcessMessages;
        mIdd.AddItm(mSpvDoc,gKey.SabSviCrd[ohSAH.BtrTable.BookNum],mSpiVat,0,0,0,0);
        mIdd.AddItm(mSpvDoc,gKey.SabSviDeb[ohSAH.BtrTable.BookNum],0,mSpiVat,gIni.GetVatPrc(2),0,mSpiVat);
        mIdd.AddItm(mSpvDoc,gKey.SabSveCrd[ohSAH.BtrTable.BookNum],mSpeVat,0,gIni.GetVatPrc(2),0,mSpeVat*(-1));
        mIdd.AddItm(mSpvDoc,gKey.SabSveDeb[ohSAH.BtrTable.BookNum],0,mSpeVat,0,0,0);
        mIdd.ClcDoc(mSpvDoc);
        If ohSAH.LocateDocNum(mDocNum) then begin
          ohSAH.Edit;
          ohSAH.SpvDoc:=mSpvDoc;
          ohSAH.Post;
        end;
      end
      else begin  // Opravime existujuci pokladnicny doklad

      end;
      FreeAndNil(mIdd);
    end;
  end;

  procedure CseDocGen;
  var mCsd:TCsd;
  begin
    If IsNotNul(mCseVal) or IsNotNul(mCrcVal) then begin
      mCsd:=TCsd.Create(Self);   mCsd.Open(gKey.SabEcrCsb[ohSAH.BtrTable.BookNum]);
      If mCseDoc='' then begin // Vygenerujeme novy pokladnicny doklad
        mCsd.NewDoc(YearS(ohSAH.DocDate),0,0,ohSAH.DocDate,'','E');
        mCsd.CnfDoc; // Potvrdenie dokladu nastavi priznak rezervacie DstLck=9 na 0
        mCseDoc:=mCsd.ohCSH.DocNum;    Application.ProcessMessages;
        mCsd.AddItm(mCseDoc,gKey.SabCshCoe[ohSAH.BtrTable.BookNum],0,mCseVal,'',mDocNum);
        mCsd.AddItm(mCseDoc,gKey.SabCrdCoe[ohSAH.BtrTable.BookNum],0,mCrcVal,'',mDocNum);
        mCsd.ClcDoc(mCseDoc);
        mCsd.AccDoc;
        If ohSAH.LocateDocNum(mDocNum) then begin
          ohSAH.Edit;
          ohSAH.CseDoc:=mCseDoc;
          ohSAH.CseVal:=mCseVal;
          ohSAH.CrcVal:=mCrcVal;
          ohSAH.Post;
        end;
      end
      else begin  // Opravime existujuci pokladnicny doklad

      end;
      FreeAndNil(mCsd);
    end;
  end;

  procedure CsiDocGen;
  var mCsd:TCsd;
  begin
    If IsNotNul(mCsiVal) then begin
      mCsd:=TCsd.Create(Self);   mCsd.Open(gKey.SabCenCsb[ohSAH.BtrTable.BookNum]);
      If mCsiDoc='' then begin // Vygenerujeme novy pokladnicny doklad
        mCsd.NewDoc(YearS(ohSAH.DocDate),0,0,ohSAH.DocDate,'','I');
        mCsd.CnfDoc; // Potvrdenie dokladu nastavi priznak rezervacie DstLck=9 na 0
        mCsiDoc:=mCsd.ohCSH.DocNum;     Application.ProcessMessages;
        mCsd.AddItm(mCsiDoc,gKey.SabCshCoi[ohSAH.BtrTable.BookNum],0,mCsiVal,'',mDocNum);
        mCsd.ClcDoc(mCsiDoc);
        mCsd.AccDoc;
        If ohSAH.LocateDocNum(mDocNum) then begin
          ohSAH.Edit;
          ohSAH.CsiDoc:=mCsiDoc;
          ohSAH.Post;
        end;
      end
      else begin  // Opravime existujuci pokladnicny doklad

      end;
      FreeAndNil(mCsd);
    end;
  end;

  procedure IncDocGen; // Vygeneruje vydajovy a prijmovy pokladnicny doklad z HP na prijem hotovosti do ERP
  var mCsd:TCsd;
  begin
    If IsNotNul(mIncVal) then begin
      // ******************************* VYDAJ *******************************
      mCsd:=TCsd.Create(Self);   mCsd.Open(gKey.SabCenCsb[ohSAH.BtrTable.BookNum]);
      If mIncCse='' then begin // Vygenerujeme novy vydajovy pokladnicny doklad
        mCsd.NewDoc(YearS(ohSAH.DocDate),0,0,ohSAH.DocDate,'','E');
        mCsd.CnfDoc; // Potvrdenie dokladu nastavi priznak rezervacie DstLck=9 na 0
        mIncCse:=mCsd.ohCSH.DocNum;     Application.ProcessMessages;
        mCsd.AddItm(mIncCse,gKey.SabCshCre[ohSAH.BtrTable.BookNum],0,mIncVal,'',mDocNum);
        mCsd.ClcDoc(mIncCse);
        mCsd.AccDoc;
        If ohSAH.LocateDocNum(mDocNum) then begin
          ohSAH.Edit;
          ohSAH.IncCse:=mIncCse;
          ohSAH.IncVal:=mIncVal;
          ohSAH.Post;
        end;
      end
      else begin  // Opravime existujuci pokladnicny doklad

      end;
      FreeAndNil(mCsd);
      // ******************************* PRIJJEM *******************************
      mCsd:=TCsd.Create(Self);   mCsd.Open(gKey.SabEcrCsb[ohSAH.BtrTable.BookNum]);
      If mIncCsi='' then begin // Vygenerujeme novy prijmovy pokladnicny doklad
        mCsd.NewDoc(YearS(ohSAH.DocDate),0,0,ohSAH.DocDate,'','I');
        mCsd.CnfDoc; // Potvrdenie dokladu nastavi priznak rezervacie DstLck=9 na 0
        mIncCsi:=mCsd.ohCSH.DocNum;     Application.ProcessMessages;
        mCsd.AddItm(mIncCsi,gKey.SabCshCri[ohSAH.BtrTable.BookNum],0,mIncVal,'',mDocNum);
        mCsd.ClcDoc(mIncCsi);
        mCsd.AccDoc;
        If ohSAH.LocateDocNum(mDocNum) then begin
          ohSAH.Edit;
          ohSAH.IncCsi:=mIncCsi;
          ohSAH.IncVal:=mIncVal;
          ohSAH.Post;
        end;
      end
      else begin  // Opravime existujuci pokladnicny doklad

      end;
      FreeAndNil(mCsd);
    end;
  end;

begin
  If not ohGSCAT.Active then ohGSCAT.Open;
  If ohSAH.BtrTable.BookNum<>BookNumFromDocNum(pDocNum) then Open(BookNumFromDocNum(pDocNum));
  If gKey.SabAccAll[ohSAH.BtrTable.BookNum] then begin
    mSvcMgc:=gIni.ServiceMg;
    mBValue:= 0;  mSecVal:= 0;  mGscVal:= 0;  mVatVal:= 0;
    mCseVal:= 0;  mCrcVal:= 0;  mIncVal:= 0;
    oSpiValA:=TValue8.Create;  oSpiValA.Clear;
    oSpeValA:=TValue8.Create;  oSpeValA.Clear;
    oSpiValB:=TValue8.Create;  oSpiValA.Clear;
    oSpeValB:=TValue8.Create;  oSpeValB.Clear;
    For I:=1 to 3 do begin
      oSpiValA.VatPrc[I]:=ohSAH.BtrTable.FieldByName('VatPrc'+StrInt(I,0)).AsInteger;
      oSpiValB.VatPrc[I]:=ohSAH.BtrTable.FieldByName('VatPrc'+StrInt(I,0)).AsInteger;
      oSpeValA.VatPrc[I]:=ohSAH.BtrTable.FieldByName('VatPrc'+StrInt(I,0)).AsInteger;
      oSpeValB.VatPrc[I]:=ohSAH.BtrTable.FieldByName('VatPrc'+StrInt(I,0)).AsInteger;
    end;
    If ohSAH.LocateDocNum(pDocNum) then begin
      mDocNum:=ohSAH.DocNum;
      mDocDate:= ohSAH.DocDate;

      mSpiBvl:=ohSAH.SpiVal+ohSAH.SpiVat;
      mSpeBvl:=ohSAH.SpeVal*(-1)+ohSAH.SpeVat*(-1);

      mBValue:=ohSAH.BValue;
      mVatVal:=ohSAH.VatVal-ohSAH.SpiVat-ohSAH.SpeVat;
      mSecVal:=ohSAH.SecVal;
      mGscVal:=mBValue-mSpiBvl+mSpeBvl-mVatVal-ohSAH.SecVal;
//      mgKey_SysAdvGsc:=Adv.FndVerAdvGsCode(0,gvSys.DefVatPrc,NIL);
//      mgKey_MarAdvGsc:=gKey.MarAdvGsc;
      mSvcMgc:=gIni.ServiceMg;
      If ohSAI.LocateDocNum(ohSAH.DocNum) then begin
        oGscValA:=0;oGscValB:=0;oSecValA:=0;oSecValB:=0;
        oSpiValA.Clear;oSpiValB.Clear;oSpeValA.Clear;oSpeValB.Clear;
        Repeat
          If ohSAI.GsCode<>mgKey_SysAdvGsc then begin
            If ohSAI.GsCode<>mgKey_MarAdvGsc then begin
              ohGSCAT.LocateGsCode(ohSAI.GsCode);
              If (ohSAI.MgCode<mServiceMg)or(ohGSCAT.GsType='K') then begin // Tovar a KUPON
                oGscValA:=oGscValA+ohSAI.AValue; // Tovar
                oGscValB:=oGscValB+ohSAI.BValue; // Tovar
              end
              else begin
                oSecValA:=oSecValA+ohSAI.AValue; // Sluzby
                oSecValB:=oSecValB+ohSAI.BValue; // Sluzby
              end;
            end
            else begin
              If oSpeValA.VatGrp(ohSAI.VatPrc)=0 then begin // Neexistujuca sadzba DPH
                mVatQnt:=oSpiValA.VatQnt;
                oSpiValA.VatPrc[mVatQnt+1]:=ohSAI.VatPrc;
                oSpeValA.VatPrc[mVatQnt+1]:=ohSAI.VatPrc;
                oSpiValB.VatPrc[mVatQnt+1]:=ohSAI.VatPrc;
                oSpeValB.VatPrc[mVatQnt+1]:=ohSAI.VatPrc;
              end;
              oSpeValA.Add (ohSAI.VatPrc,ohSAI.BValue);
              oSpeValB.Add (ohSAI.VatPrc,ohSAI.BValue);
            end;
          end
          else begin

            If oSpiValA.VatGrp(ohSAI.VatPrc)=0 then begin // Neexistujuca sadzba DPH
              mVatQnt:=oSpiValA.VatQnt;
              oSpiValA.VatPrc[mVatQnt+1]:=ohSAI.VatPrc;
              oSpeValA.VatPrc[mVatQnt+1]:=ohSAI.VatPrc;
              oSpiValB.VatPrc[mVatQnt+1]:=ohSAI.VatPrc;
              oSpeValB.VatPrc[mVatQnt+1]:=ohSAI.VatPrc;
            end;
            oSpiValA.Add (ohSAI.VatPrc,ohSAI.AValue);
            oSpiValB.Add (ohSAI.VatPrc,ohSAI.AValue);
          end;
          ohSAI.Next;
        until (ohSAI.Eof) or (ohSAI.DocNum<>ohSAH.DocNum);
        mSecVal:=oSecValA;
        mGscVal:=oGscValA;
        mBValue:=oGscValB+oSecValB+oSpiValB[0]+oSpeValB[0];
        mVatVal:=oGscValB-oGscValA+oSecValB-oSecValA;
        mSpiBvl:=oSpiValB[0];
        mSpiVat:=oSpiValB[0]-oSpiValA[0];
        mSpeBvl:=0-oSpeValB[0];
        mSpeVat:=0-(oSpeValB[0]-oSpeValA[0]);
      end;

      mCValue:=ohSAH.CValue;
      mSpiVat:=ohSAH.SpiVat;
      mSpeVat:=ohSAH.SpeVat*(-1);
      mCseVal:=ohSAH.CseVal;
      mCrcVal:=ohSAH.CrcVal;
      mCsiVal:=ohSAH.CseVal;
      mIncVal:=ohSAH.IncVal;

      mBvlDoc:=ohSAH.BvlDoc;
      If ohSAH.DstAcc='A' then mCvlDoc:=ohSAH.DocNum;
      mSpiDoc:=ohSAH.SpiDoc;
      mSpeDoc:=ohSAH.SpeDoc;
      mSpvDoc:=ohSAH.SpvDoc;
      mCseDoc:=ohSAH.CseDoc;
      mCsiDoc:=ohSAH.CsiDoc;
      mIncCse:=ohSAH.IncCse;
      mIncCsi:=ohSAH.IncCsi;

      If (mCseDoc='') or (mIncCse='') or (mIncCsi='') then begin
      If  mCseDoc='' then begin mCseVal:=0; mCrcVal:=0;end;
      If (mIncCse='') or (mIncCsi='') then mIncVal:=0;
        mPsDay:=TPsDayData.Create;
        mhCABLST:=TCablstHnd.Create;   mhCABLST.Open;
        If mhCABLST.Count>0 then begin
          mhCABLST.First;
          Repeat
            If mhCABLST.WriNum=pWriNum then begin
              mPsDay.ReadFile(mhCABLST.CasNum,mDocDate);
              mPsDay.ReadGlobData; // Procedura nacita globalne udaje predaja do pamatovych premennych
              If mCseDoc='' then begin
                mCseVal:=mCseVal+mPsDay.GetExpVal(0);
                mCrcVal:=mCrcVal+mPsDay.GetExpVal(1);
              end;
              If (mIncCse='') or (mIncCsi='') then mIncVal:=mIncVal+mPsDay.GetIncVal;
            end;
            Application.ProcessMessages;
            mhCABLST.Next;
          until mhCABLST.Eof;
        end;
        mhCABLST.Close;FreeAndNil(mhCABLST);
      end;
      mCsiVal:=mCseVal;
      FillChar (oDBVal,SizeOf(oDBVal),#0);
      FillChar (oDVVal,SizeOf(oDVVal),#0);
      If gKey.sabAccDcl[oBokNum] then begin
        mPsDay:=TPsDayData.Create;
        mhCABLST:=TCablstHnd.Create;   mhCABLST.Open;
        If mhCABLST.Count>0 then begin
          mhCABLST.First;
          Repeat
            If mhCABLST.WriNum=gKey.SABWriNum[oBokNum] then begin
              mPsDay.ReadFile(mhCABLST.CasNum,mDocDate);
              mPsDay.ReadGlobData; // Procedura nacita globalne udaje predaja do pamatovych premennych
              oDBVal[1]:=oDBVal[1]+mPsDay.GetDClsValA(1);
              oDVVal[1]:=oDVVal[1]+mPsDay.GetDClsVatA(1);
              oDBVal[2]:=oDBVal[2]+mPsDay.GetDClsValA(2);
              oDVVal[2]:=oDVVal[2]+mPsDay.GetDClsVatA(2);
              oDBVal[3]:=oDBVal[3]+mPsDay.GetDClsValA(3);
              oDVVal[3]:=oDVVal[3]+mPsDay.GetDClsVatA(3);
            end;
            Application.ProcessMessages;
            mhCABLST.Next;
          until mhCABLST.Eof;
        end;
        mhCABLST.Close;FreeAndNil(mhCABLST);
        mBValue:=oDBVal[1]+oDBVal[2]+oDBVal[3];
        mVatVal:=oDVVal[1]+oDVVal[2]+oDVVal[3]-mSpiVat+mSpeVat;
        mGscVal:=mBValue-mSpiBvl+mSpeBvl-mSecVal-mVatVal;
      end;
      AccSap(pDocNum);
//      BvlDocGen;
//      SpiDocGen;
//      SpeDocGen;
//      SpvDocGen;
      IncDocGen; // Vygeneruje vydajovy a prijmovy pokladnicny doklad z HP na prijem hotovosti do ERP
      CseDocGen;
      CsiDocGen;
    end;
  end else begin
    AccSap(pDocNum);
  end
end;

// *****************************************************************************
// ********************************** SAC **************************************
// *****************************************************************************

procedure TSad.InsSAC(var pNextNum:word;pItmNum,pSacNum:longint;pDocDate:TDateTime;pStkNum:integer;pGsQnt:double);
var mPdGsQnt:double;
begin
  ohSAC.SwapStatus;
  If ohCPH.LocatePdCode(ohSAC.CpCode) then begin
    ohCPI.LocatePdCode(ohSAC.CpCode);
    while not ohCPI.Eof and (ohCPI.PdCode=ohCPH.PdCode) do begin
      mPdGsQnt:=ohCPI.PdGsQnt;
      If IsNul (mPdGsQnt) then mPdGsQnt:=ohCPH.PdGsQnt;
      If IsNul (mPdGsQnt) then mPdGsQnt:=1;
      ohSAC.Insert;
      ohSAC.DocNum :=SacDocNum(oDocNum);
      ohSAC.ItmNum :=pItmNum;
      ohSAC.SacNum :=pNextNum;
      ohSAC.Parent :=pSacNum;
      ohSAC.PdCode :=ohCPH.PdCode;
      ohSAC.CpCode :=ohCPI.CpCode;
      ohSAC.CpName :=ohCPI.CpName;
      ohSAC.BarCode:=ohCPI.BarCode;
      ohSAC.MsName :=ohCPI.MsName;
      ohSAC.DocDate:=pDocDate;
      ohSAC.StkNum :=pStknum;
      ohSAC.ItmType:=ohCPI.ItmType;
      ohSAC.MgCode :=ohCPI.MgCode;
      ohSAC.VatPrc :=ohCPI.VatPrc;
      ohSAC.CPrice :=0;
      ohSAC.CValue :=0;
      ohSAC.StkStat:='N';
      ohSAC.DocDate:=pDocDate;
      ohSAC.PdGsQnt:=pGsQnt;
      ohSAC.LosPrc :=ohCPI.LosPrc;
      ohSAC.RcGsQnt:=Rd3(pGsQnt*ohCPI.RcGsQnt/mPdGsQnt);
      ohSAC.CpSeQnt:=Rd3(ohSAC.RcGsQnt*(1+ohCPI.LosPrc/100));
      If ohSAC.ItmType = 'W' then begin
        ohSAC.CPrice:=ohCPI.CPrice;
        ohSAC.CValue:=ohCPI.CPrice*ohSAC.CpSeQnt;
        ohSAC.CpSuQnt:=ohSAC.CpSeQnt;
      end;
      ohCPI.SwapStatus;
      If (ohSAC.PdCode<>ohSAC.CpCode) and ohCPI.LocatePdCode(ohSAC.CpCode)
        then ohSAC.ItmType:='X';
      ohCPI.RestoreStatus;
      ohSAC.Post;
      Inc(pNextNum);
      Application.ProcessMessages;
      ohCPI.Next;
    end;
  end;
  ohSAC.RestoreStatus;
end;


procedure TSad.AddItc(pDocNum:Str12;pItmNum,pStkNum:longint); // Prida komponenty polozky na zadany doklad
var mSerNum:word; mPdGsQnt:double;mItmNum:word; mSumQnt,mSumVal,mCpSeQnt:double; mF: boolean;
begin
  // SAC.bdf
  If oDocNum<>pDocNum then LocDoc(pDocNum);
  If ohSAI.LocateDoGsSt(oDocNum,pItmNum,pStkNum)and(ohCPI.Active or (gKey.SabCpiBok[oBokNum]<>'')) then begin
    If not ohCPI.Active then  ohCPI.Open(gKey.SabCpiBok[oBokNum]);If not ohCPH.Active then  ohCPH.Open(gKey.SabCpiBok[oBokNum]);
    If not ohGSCAT.Active then ohGSCAT.Open;
    If ohGSCAT.LocateGsCode(ohSAI.GsCode) then begin
      If ohCPH.LocatePdCode(ohSAI.GsCode) then begin
        mSerNum:=ohSAC.NextSerNum(SacDocNum(oDocNum));
        ohCPI.LocatePdCode(ohSAI.GsCode);
        while not ohCPI.Eof and (ohCPI.PdCode=ohSAI.GsCode) do begin
          mCpSeQnt:=0;
          mPdGsQnt:=ohCPI.PdGsQnt;
          If IsNul (mPdGsQnt) then mPdGsQnt:=ohCPH.PdGsQnt;
          If IsNul (mPdGsQnt) then mPdGsQnt:=1;
          ohSAC.Insert;
          ohSAC.DocNum :=SacDocNum(oDocNum);
          ohSAC.ItmNum :=pItmNum;
          ohSAC.SacNum :=mSerNum;
          ohSAC.Parent :=-1;
          ohSAC.PdCode :=ohSAI.GsCode;
          ohSAC.CpCode :=ohCPI.CpCode;
          ohSAC.CpName :=ohCPI.CpName;
          ohSAC.BarCode:=ohCPI.BarCode;
          ohSAC.MsName :=ohCPI.MsName;
          ohSAC.DocDate:=ohSAI.DocDate;
          ohSAC.StkNum :=ohSAI.Stknum;
          ohSAC.ItmType:=ohCPI.ItmType;
          ohSAC.MgCode :=ohCPI.MgCode;
          ohSAC.VatPrc :=ohCPI.VatPrc;
          ohSAC.CPrice :=0;
          ohSAC.CValue :=0;
          ohSAC.StkStat:='N';
          ohSAC.DocDate:=ohSAI.DocDate;
          ohSAC.PdGsQnt:=ohSAI.SeQnt;
          ohSAC.LosPrc :=ohCPI.LosPrc;
          ohSAC.RcGsQnt:=Rd3(ohSAI.SeQnt*ohCPI.RcGsQnt/mPdGsQnt);
          ohSAC.CpSeQnt:=Rd3(ohSAC.RcGsQnt*(1+ohCPI.LosPrc/100));
          If ohSAC.ItmType = 'W' then begin
            ohSAC.CPrice:=ohCPI.CPrice;
            ohSAC.CValue:=ohCPI.CPrice*ohSAC.CpSeQnt;
            ohSAC.CpSuQnt:=ohSAC.CpSeQnt;
          end;
          mCpSeQnt:=mCpSeQnt+Rd3(Rd3(ohSAI.SeQnt*ohCPI.RcGsQnt/mPdGsQnt)*(1+ohCPI.LosPrc/100));
          ohCPI.SwapStatus;
          If (ohSAC.PdCode<>ohSAC.CpCode) and ohCPI.LocatePdCode(ohSAC.CpCode)
            then ohSAC.ItmType:='X';
          ohCPI.RestoreStatus;
          ohSAC.Post;
          Inc(mSerNum);
          Application.ProcessMessages;
          ohCPI.Next;
        end;
        ohSAI.Edit;
        ohSAI.StkStat:='C';
        ohSAI.Cvalue:= 0;
        ohSAI.Post;
        repeat
          mF:=False;
          ohSAC.LocateDnInSt(SacDocNum(oDocNum),pItmNum,pStkNum);
          while not ohSAC.Eof and (ohSAC.DocNum=SacDocNum(oDocNum)) do begin
            mF:=mF or (ohSAC.ItmType='X');
            If ohSAC.ItmType='X' then begin
              InsSAC(mSerNum,ohSAC.ItmNum,ohSAC.SacNum,ohSAC.DocDate,ohSAC.StkNum,ohSAC.CpSeQnt);
              ohSAC.Edit;
              ohSAC.ItmType:='P';
              ohSAC.Post;
            end;
            ohSAC.Next;
          end;
        until not mF;
      end;
    end
    else ShowMsg (eCom.GscIsNoExist,StrInt(ohSAI.GsCode,0));
  end;
end;

procedure TSad.AddSAC; // Prida komponent na doklad
var mSerNum:word; mItmNum:word; mF: boolean;
begin
  // SAC.bdf
  If ohSAI.LocateDoGsSt(SacDocNum(oDocNum),pItmNum,pStkNum)and(ohCPI.Active or (gKey.SabCpiBok[oBokNum]<>'')) then begin
    If not ohCPI.Active then  ohCPI.Open(gKey.SabCpiBok[oBokNum]);
    If not ohCPH.Active then  ohCPH.Open(gKey.SabCpiBok[oBokNum]);
    If not ohGSCAT.Active then ohGSCAT.Open;
    If ohGSCAT.LocateGsCode(pGsCode) then begin
      mSerNum:=ohSAC.NextSerNum(SacDocNum(oDocNum));
      ohSAC.Insert;
      ohSAC.DocNum :=SacDocNum(oDocNum);
      ohSAC.ItmNum :=pItmNum;
      ohSAC.SacNum :=mSerNum;
      ohSAC.Parent :=pParent;
      ohSAC.PdCode :=pPdCode;
      ohSAC.CpCode :=ohGSCAT.GsCode;
      ohSAC.CpName :=ohGSCAT.GsName;
      ohSAC.BarCode:=ohGSCAT.BarCode;
      ohSAC.MsName :=ohGSCAT.MsName;
      ohSAC.DocDate:=ohSAI.DocDate;
      ohSAC.StkNum :=ohSAI.Stknum;
      ohSAC.ItmType:='C';
      ohSAC.MgCode :=ohGSCAT.MgCode;
      ohSAC.VatPrc :=ohGSCAT.VatPrc;
      ohSAC.CPrice :=0;
      ohSAC.CValue :=0;
      ohSAC.StkStat:='N';
      ohSAC.DocDate:=ohSAI.DocDate;
      ohSAC.PdGsQnt:=1;
      ohSAC.LosPrc :=0;
      ohSAC.RcGsQnt:=pGsQnt;
      ohSAC.CpSeQnt:=pGsQnt;
      If ohSAC.ItmType = 'W' then begin
        ohSAC.CPrice:=ohCPI.CPrice;
        ohSAC.CValue:=ohCPI.CPrice*ohSAC.CpSeQnt;
        ohSAC.CpSuQnt:=ohSAC.CpSeQnt;
      end;
      ohCPI.SwapStatus;
      If (ohSAC.PdCode<>ohSAC.CpCode) and ohCPI.LocatePdCode(ohSAC.CpCode)
        then ohSAC.ItmType:='X';
      ohCPI.RestoreStatus;
      ohSAC.Post;
      ohSAI.Edit;
      ohSAI.StkStat:='C';
      ohSAI.Cvalue:= 0;
      ohSAI.Post;
      Inc(mSerNum);
      repeat
        mF:=False;
        ohSAC.LocateDocNum(SacDocNum(oDocNum));
        while not ohSAC.Eof and (ohSAC.DocNum=SacDocNum(oDocNum)) do begin
          mF:=mF or (ohSAC.ItmType='X');
          If ohSAC.ItmType='X' then begin
            InsSAC(mSerNum,ohSAC.ItmNum,ohSAC.SacNum,ohSAC.DocDate,ohSAC.StkNum,ohSAC.CpSeQnt);
            ohSAC.Edit;
            ohSAC.ItmType:='P';
            ohSAC.Post;
          end;
          ohSAC.Next;
        end;
      until not mF;
    end
    else ShowMsg (eCom.GscIsNoExist,StrInt(ohSAI.GsCode,0));
  end;
end;

procedure TSad.UnsSAC(pDocNum:Str12;pItmNum,pStkNum,pParent:longint); // Stornuje komponenty polozky na zadany doklad
var mItmNum:word; mSumQnt,mSumVal,mCpSeQnt,mPdGsQnt:double; mStkCanc: TStkCanc;
begin
  // SAC.bdf
  LocDoc(pDocNum);
  If ohSAI.LocateDoGsSt(oDocNum,pItmNum,pStkNum)and ohSAC.LocateDnInSt(SacDocNum(oDocNum),pItmNum,pStkNum)then begin
    mStkCanc:=TStkCanc.Create;
    mStkCanc.OpenStkFiles(ohSAI.StkNum);
    If not ohGSCAT.Active then ohGSCAT.Open;
    If ohGSCAT.LocateGsCode(ohSAI.GsCode)then begin
      while not ohSAC.Eof and (ohSAC.DocNum=SacDocNum(ohSAI.DocNum)) and (ohSAC.ItmNum=ohSAI.GsCode) do begin
        If (pParent=0) or (pParent=ohSAC.Parent) then
        begin
          If mStkCanc.Cancel(ohSAC.DocNum,ohSAC.SacNum)=0 then
          begin
            ohSAC.Edit;
            ohSAC.StkStat:='N';
            ohSAC.CValue:=0;
            ohSAC.CpSuQnt:=0;
            ohSAC.Post;
          end;
        end;
        ohSAC.Next;
      end;
    end;
    FreeAndNil(mStkCanc);
  end;
end;

function TSad.DelSAC(pDocNum:Str12;pItmNum,pStkNum,pParent:longint):boolean;
var mItmNum:word; mSumQnt,mSumVal,mCpSeQnt,mPdGsQnt:double;
begin
  Result:=True;
  LocDoc(pDocNum);
  // SAC.bdf
  If ohSAI.LocateDoGsSt(oDocNum,pItmNum,pStkNum)and ohSAC.LocateDnInSt(SacDocNum(oDocNum),pItmNum,pStkNum)then
  begin
    while Result and not ohSAC.Eof and (ohSAC.DocNum=SacDocNum(ohSAI.DocNum)) and (ohSAC.ItmNum=ohSAI.GsCode) do begin
      If (pParent=0) or (pParent=ohSAC.Parent) then Result:=IsNul(ohSAC.CpSuQnt);
      ohSAC.Next;
    end;
    If Result then begin
      ohSAC.LocateDnInSt(SacDocNum(oDocNum),pItmNum,pStkNum);
      while not ohSAC.Eof and (ohSAC.DocNum=SacDocNum(ohSAI.DocNum)) and (ohSAC.ItmNum=ohSAI.GsCode) do begin
        If (pParent=0) or (pParent=ohSAC.Parent) then ohSAC.Delete;
      end;
    end;
  end;
end;

function TSad.IssItc(pDocNum:Str12;pItmNum,pStkNum,pParent: Integer): boolean;
var mParent:longint;mV,mValue:double;
begin
  LocDoc(pDocNum);
  Result:=TRUE;
  ohSAC.SwapStatus;
  If ohSAH.LocateDocNum(pDocNum) and ohSAI.LocateDoGsSt(pDocNum,pItmNum,pStkNum)  then begin
    If pParent>=1 then begin
      If ohSAC.LocateDnPa(SacDocNum(pDocNum),pParent) then begin
        If ohSAC.ItmType='C' then begin
          Result:=Eq3(ohSAC.CpSeQnt,ohSAC.CpSuQnt);
        end else If ohSAC.ItmType='W' then begin
          Result:=True;
        end else If ohSAC.ItmType='P' then begin
          mParent:=ohSAC.SacNum;mValue:=0;
          ohSAC.LocateDnInSt(SacDocNum(pDocNum),pItmNum,pStkNum);
          repeat
            If ohSAC.Parent=mParent then Result:=IssItc(pDocNum,pItmNum,pStkNum,ohSAC.SacNum);
            ohSAC.Next;
          until not Result or ohSAC.Eof or (ohSAC.DocNum<>SacDocNum(pDocNum))or (ohSAC.ItmNum<>pItmNum);
        end;
      end;
    end else begin
      mParent:=pItmNum;
      ohSAC.LocateDnInSt(SacDocNum(pDocNum),pItmNum,pStkNum);
      repeat
        If (ohSAC.Parent=-1) and (ohSAC.ItmNum=pItmNum) then begin
          result:=IssItc(pDocNum,pItmNum,pStkNum,ohSAC.SacNum);
        end;
        ohSAC.Next;
      until not Result or ohSAC.Eof or (ohSAC.DocNum<>SacDocNum(pDocNum))or (ohSAC.ItmNum<>pItmNum)
    end;
  end;
  ohSAC.RestoreStatus;
end;

procedure TSad.SubSAC(pDocNum: Str12; pItmNum,pStkNum, pSACNum: Integer);
var mStk:TStk; mFind:boolean; mCnt:byte; mParent:longint; mQ:double;
begin
  LocDoc(pDocNum);
  ohSAC.SwapStatus;
  If ohSAH.LocateDocNum(pDocNum) and ohSAI.LocateDoGsSt(pDocNum,pItmNum,pStkNum)  then begin
    If ohSAC.LocateDnSn(SacDocNum(oDocNum),pSACNum) then begin
      If ohSAC.ItmType='C' then begin
        If IsNotNul(ohSAC.CpSeQnt-ohSAC.CpSuQnt) then begin
          mStk:=TStk.Create;
          mStk.Clear;
          mStk.SmSign:='-';  // Vydaj tovaru
          mStk.DocNum:=ohSAC.DocNum;
          mStk.ItmNum:=ohSAC.SacNum;
          mStk.DocDate:=ohSAC.DocDate;
          mStk.GsCode:=ohSAC.CpCode;
          mStk.MgCode:=ohSAC.MgCode;
          mStk.BarCode:=ohSAC.BarCode;
          mStk.SmCode:=59;
          mStk.GsName:=ohSAC.CpName;
          mQ:=ohSac.CpSeQnt-ohSac.CpSuQnt;
          mStk.GsQnt :=ohSac.CpSeQnt-ohSac.CpSuQnt;
          mStk.CValue:=ohSac.CPrice*(ohSac.CpSeQnt-ohSac.CpSuQnt);
          If ((mStk.GsQnt>0)and mStk.Sub(ohSac.StkNum)) or mStk.SubMod(ohSac.StkNum) then begin // Ak sa podarilo vydat polozky
            ohSac.Edit;
            ohSac.CpSuQnt:=ohSac.CpSuQnt+mQ;
            If mQ<0
              then ohSAC.CValue:=ohSAC.CValue - Abs(mStk.CValue)
              else ohSAC.CValue:=ohSAC.CValue + Abs(mStk.CValue);
            If (ohSAC.CpSuQnt)<>0 then ohSAC.CPrice:=ohSAC.CValue/ohSAC.CpSuQnt;
            If IsNul(ohSAC.CpSeQnt-ohSAC.CpSuQnt) then ohSAC.StkStat:='S';
            ohSAC.Post;
          end;
          FreeAndNil (mStk);
        end;
      end else If ohSAC.ItmType='P' then begin
        mParent:=ohSAC.SacNum;
        ohSAC.LocateDnInSt(SacDocNum(pDocNum),pItmNum,pStkNum);
        repeat
          If ohSAC.Parent=mParent then begin
            SubSAC(pDocNum,pItmNum,pStkNum,ohSAC.SacNum);
          end;
          ohSAC.Next;
        until ohSAC.Eof or (ohSAC.DocNum<>SacDocNum(oDocNum))or (ohSAC.ItmNum<>pItmNum)
      end;
    end;
  end;
  ohSAC.RestoreStatus;
end;

function TSad.ClcSAC(pDocNum: Str12; pItmNum, pStkNum, pSACNum: Integer):double;
var mParent:longint;mV,mValue:double;
begin
  Result:=0;
  LocDoc(pDocNum);
  ohSAC.SwapStatus;
  If ohSAH.LocateDocNum(pDocNum) and ohSAI.LocateDoGsSt(pDocNum,pItmNum,pStkNum)  then begin
    If pSACNum>=1 then begin
      If ohSAC.LocateDnSn(SacDocNum(pDocNum),pSACNum) then begin
        If ohSAC.ItmType='C' then begin
          Result:=Result+ohSAC.CValue;
        end else If ohSAC.ItmType='W' then begin
          //
        end else If ohSAC.ItmType='P' then begin
          mParent:=ohSAC.SacNum;mValue:=0;
          ohSAC.LocateDnInSt(SacDocNum(pDocNum),pItmNum,pStkNum);
          repeat
            If ohSAC.Parent=mParent then begin
              mV:=ClcSAC(pDocNum,pItmNum,pStkNum,ohSAC.SacNum);
              Result:=Result+mV;
              mValue:=mValue+mV;
            end;
            ohSAC.Next;
          until ohSAC.Eof or (ohSAC.DocNum<>SacDocNum(pDocNum))or (ohSAC.ItmNum<>pItmNum);
          ohSAC.LocateDnSn(SacDocNum(pDocNum),mParent);
          ohSAC.Edit;
          ohSAC.CValue:=mValue;
          If IsNotNul(ohSAC.CpSuQnt)
            then ohSAC.CPrice:=ohSAC.CValue/ohSAC.CpSuQnt
            else ohSAC.CPrice:=ohSAC.CValue;
          ohSAC.Post;
        end;
      end;
    end else begin
      mParent:=pItmNum;
      ohSAC.LocateDnInSt(SacDocNum(pDocNum),pItmNum,pStkNum);
      repeat
        If (ohSAC.Parent=-1) and (ohSAC.ItmNum=pItmNum) then begin
          result:=Result+ClcSAC(pDocNum,pItmNum,pStkNum,ohSAC.SacNum);
        end;
        ohSAC.Next;
      until ohSAC.Eof or (ohSAC.DocNum<>SacDocNum(pDocNum))or (ohSAC.ItmNum<>pItmNum)
    end;
  end;
  ohSAC.RestoreStatus;
end;

function TSad.SacDocNum;
begin
  Result:='SC'+copy(pDocNum,3,10);
end;

procedure TSad.LocDoc(pDocNum: Str12);
begin
  If ohSAH.LocateDocNum(pDocNum) then begin
    oDocNum:=ohSAH.DocNum;
    oDocDate:= ohSAH.DocDate;
  end;
end;

procedure TSad.SubDoc;
var mStk:TStk; mCnt:byte; mQ,mCValue,mCpSeQnt,mCpSuQnt:double;
begin
  If ohSAI.LocateDocNum(ohSAH.DocNum) then begin
    mStk:=TStk.Create;
    If oInd<>nil then begin
      oInd.Max:=ohSAH.ItmQnt;
      oInd.Position:=0;
    end;
    Repeat
      If oInd<>nil then oInd.StepBy(1);
      If ohSAI.StkStat='N' then begin
        mStk.Clear;
        mStk.SmSign:='-';  // Vydaj tovaru
        mStk.DocNum:=ohSAI.DocNum;
        mStk.ItmNum:=ohSAI.GsCode;
        mStk.DocDate:=ohSAI.DocDate;
        mStk.GsCode:=ohSAI.GsCode;
        mStk.MgCode:=ohSAI.MgCode;
        mStk.BarCode:=ohSAI.BarCode;
        mStk.SmCode:=59;
        mStk.GsName:=ohSAI.GsName;
        mStk.GsQnt:=ohSAI.SeQnt;
        mStk.CValue:=ohSAI.CValue;
        If IsNotNul(mStk.GsQnt) then mStk.CPrice:=RoundCPrice(ohSAI.CValue/ohSAI.SeQnt);
        If mStk.Sub(ohSAI.StkNum) then begin
          ohSAI.Edit;
          If ohSAI.SeQnt<0
            then ohSAI.CValue:=0-Abs(mStk.CValue)
            else ohSAI.CValue:=Abs(mStk.CValue);
          If ohSAI.SeQnt<>0 then ohSAI.CPrice:=ohSAI.CValue/ohSAI.SeQnt;
          ohSAI.StkStat:='S';
          ohSAI.Post;
        end;
      end else If ohSAI.StkStat='C' then begin
        mCpSeQnt:=0;mCpSuQnt:=0;mCValue:=0;
        If ohSAC.LocateDnInSt(SacDocNum(ohSAI.DocNum),ohSAI.GsCode,ohSAI.StkNum) then begin
          repeat
            If (ohSac.ItmType='C') and IsNotNul(ohSac.CpSeQnt-ohSac.CpSuQnt) then begin
              mStk.Clear;
              mStk.SmSign:='-';  // Vydaj tovaru
              mStk.DocNum:=ohSac.DocNum;
              mStk.ItmNum:=ohSac.SacNum;
              mStk.DocDate:=ohSac.DocDate;
              mStk.GsCode:=ohSac.CpCode;
              mStk.MgCode:=ohSac.MgCode;
              mStk.BarCode:= ohSac.BarCode;
              mStk.SmCode:=59;
              mStk.GsName:=ohSac.CpName;
              mQ:=ohSac.CpSeQnt-ohSac.CpSuQnt;
              mStk.GsQnt :=ohSac.CpSeQnt-ohSac.CpSuQnt;
              mStk.CValue:=ohSac.CPrice*(ohSac.CpSeQnt-ohSac.CpSuQnt);
              If ((mStk.GsQnt>0)and mStk.Sub(ohSac.StkNum)) or mStk.SubMod(ohSac.StkNum) then begin // Ak sa podarilo vydat polozky
                ohSac.Edit;
                ohSac.CpSuQnt:=ohSac.CpSuQnt+mQ;
                If mQ<0
                  then ohSac.CValue:=ohSac.CValue - Abs(mStk.CValue)
                  else ohSac.CValue:=ohSac.CValue + Abs(mStk.CValue);
                If (ohSac.CpSuQnt)<>0 then ohSac.CPrice:=ohSac.CValue/ohSac.CpSuQnt;
                If IsNul(ohSac.CpSeQnt-ohSac.CpSuQnt) then ohSac.StkStat:='S';
                ohSac.Post;
              end;
            end;
            If (ohSac.ItmType<>'P')then begin
              mCValue :=mCValue+ohSac.CValue;
              mCpSeQnt:=mCpSeQnt+ohSac.CpSeQnt;
              mCpSuQnt:=mCpSuQnt+ohSac.CpSuQnt;
            end;
            ohSac.Next;
          until ohSac.Eof or (ohSac.DocNum<>SacDocNum(ohSAI.DocNum))or (ohSac.ItmNum<>ohSAI.GsCode)or (ohSac.StkNum<>ohSAI.StkNum)
        end;
        ohSAI.Edit;
        ohSAI.StkStat:='C';
        ohSAI.CpSeQnt:=mCpSeQnt;
        ohSAI.CpSuQnt:=mCpSuQnt;
        ohSAI.CValue :=mCValue;
        ohSAI.Post;
      end;
      Application.ProcessMessages;
      ohSAI.Next;
    until ohSAI.Eof or (ohSAI.DocNum<>ohSAH.DocNum);
    FreeAndNil (mStk);
  end;
  ClcDoc; // ohSAH.Clc(ohSAI);
end;

procedure TSad.SubDoc(pDocNum: Str12);
begin
  If ohSAH.LocateDocNum(pDocNum) then begin
    LocDoc(pDocNum);
    SubDoc;
  end;
end;

procedure TSad.ClcDoc;
var mSe,mSu,mCValue:double;
begin
  If ohSAC.LocateDocNum(SacDocNum(ohSAH.DocNum)) then begin
    ohSAI.NearestDoGsSt(ohSAH.DocNum,0,0);
    while not ohSAI.Eof and (ohSAI.DocNum=ohSAH.DocNum) do begin
      If ohSAI.StkStat='C' then begin
        ClcSACAll(ohSAH.DocNum,ohSAI.GsCode,ohSAI.StkNum,0,mSe,mSu,mCValue);
        // SAI.bdf
        If not Eq2(ohSAI.CValue,mCValue) or not Eq3(ohSAI.CpSeQnt,mSe) or not Eq3(ohSAI.CpSuQnt,mSu) then
        begin
          ohSAI.Edit;
          ohSAI.CValue:=mCValue;
          ohSAI.CpSeQnt:=mSe;
          ohSAI.CpSuQnt:=mSu;
          If IsNotNul(ohSAI.CpSuQnt)
            then ohSAI.CPrice:=ohSAI.CValue/ohSAI.CpSuQnt
            else ohSAI.CPrice:=ohSAI.CValue;
          ohSAI.Post;
        end;
      end;
      ohSAI.Next;
    end;
  end;
  ohSAH.Clc(ohSAI);
end;

procedure TSad.ClcDoc(pDocNum: Str12);
begin
  If ohSAH.LocateDocNum(pDocNum) then begin
    LocDoc(pDocNum);
    ClcDoc;
  end;
end;

procedure TSad.ModItc(pDocNum: Str12; pItmNum, pStkNum: Integer);
var mSerNum:word; mPdGsQnt:double;mItmNum:word; mSumQnt,mSumVal,mCpSeQnt:double; mF: boolean;
begin
  // SAC.bdf
  If oDocNum<>pDocNum then LocDoc(pDocNum);
  If ohSAI.LocateDoGsSt(oDocNum,pItmNum,pStkNum)then begin
    If not ohGSCAT.Active then ohGSCAT.Open;
    If ohGSCAT.LocateGsCode(ohSAI.GsCode) then begin
      ohSAC.LocateDnInSt(SacDocNum(pDocNum),pItmNum,pStkNum);
      repeat
        If (ohSAC.Parent=-1) and (ohSAC.ItmNum=pItmNum) then begin
          ohSAC.Edit;
          mPdGsQnt:= ohSAI.SeQnt/ohSAC.PdGsQnt;
          ohSAC.PdGsQnt:=ohSAI.SeQnt;
          ohSAC.RcGsQnt:=Rd3(ohSAC.RcGsQnt*mPdGsQnt);
          ohSAC.CpSeQnt:=Rd3(ohSAC.RcGsQnt*(1+ohCPI.LosPrc/100));
          If ohSAC.ItmType = 'W' then begin
            ohSAC.CPrice:=ohCPI.CPrice;
            ohSAC.CValue:=ohCPI.CPrice*ohSAC.CpSeQnt;
            ohSAC.CpSuQnt:=ohSAC.CpSeQnt;
          end;
          ohSAC.Post;
          If ohSAC.ItmType = 'P' then ModSAC(pItmNum,ohSAC.SacNum,ohSAC.PdGsQnt);
        end;
        ohSAC.Next;
      until ohSAC.Eof or (ohSAC.DocNum<>SacDocNum(pDocNum))or (ohSAC.ItmNum<>pItmNum)
    end
    else ShowMsg (eCom.GscIsNoExist,StrInt(ohSAI.GsCode,0));
  end;
end;

procedure TSad.ModSac(pItmNum, pSacNum: Integer; pGsQnt: double);
var mSerNum:word; mPdGsQnt:double;mItmNum:word; mSumQnt,mSumVal,mCpSeQnt:double; mF: boolean;
begin
  ohSAC.SwapStatus;
  If ohSAC.LocateDnPa(SacDocNum(oDocNum),pSacNum) then begin
    repeat
      ohSAC.Edit;
      mPdGsQnt:= pGsQnt/ohSAC.PdGsQnt;
      ohSAC.PdGsQnt:=pGsQnt;
      ohSAC.RcGsQnt:=Rd3(ohSAC.RcGsQnt*mPdGsQnt);
      ohSAC.CpSeQnt:=Rd3(ohSAC.RcGsQnt*(1+ohCPI.LosPrc/100));
      If ohSAC.ItmType = 'W' then begin
        ohSAC.CPrice:=ohCPI.CPrice;
        ohSAC.CValue:=ohCPI.CPrice*ohSAC.CpSeQnt;
        ohSAC.CpSuQnt:=ohSAC.CpSeQnt;
      end;
      ohSAC.Post;
      If ohSAC.ItmType = 'P' then ModSAC(pItmNum,ohSAC.SacNum,ohSAC.PdGsQnt);
      ohSAC.Next;
    until ohSAC.Eof or (ohSAC.DocNum<>SacDocNum(oDocNum))or (ohSAC.Parent<>pSacNum);
  end;
  ohSAC.RestoreStatus;
end;

procedure TSad.ClcSacAll(pDocNum: Str12; pItmNum, pStkNum,
  pSACNum: Integer; var pSeQnt, pSuQnt, pCValue: double);
var mParent:longint;mV,mVS,mSe,mSeS,mSu,mSuS:double;
begin
  mV:=0;mVS:=0;mSe:=0;mSeS:=0;mSu:=0;mSuS:=0;
  If pDocNum<>oDocNum then LocDoc(pDocNum);
  ohSAC.SwapStatus;
  If ohSAH.LocateDocNum(pDocNum) and ohSAI.LocateDoGsSt(pDocNum,pItmNum,pStkNum)  then begin
    If pSACNum>=1 then begin
      If ohSAC.LocateDnSn(SacDocNum(pDocNum),pSACNum) then begin
        If ohSAC.ItmType='C' then begin
          mSeS:=mSeS+ohSAC.CpSeQnt;
          mSuS:=mSuS+ohSAC.CpSuQnt;
          mVS:=mVS+ohSAC.CValue;
        end else If ohSAC.ItmType='W' then begin
          mSeS:=mSeS+ohSAC.CpSeQnt;
          mSuS:=mSuS+ohSAC.CpSuQnt;
          mVS:=mVS+ohSAC.CValue;
        end else If ohSAC.ItmType='P' then begin
          mParent:=ohSAC.SacNum;
          ohSAC.LocateDnInSt(SacDocNum(pDocNum),pItmNum,pStkNum);
          repeat
            If ohSAC.Parent=mParent then begin
              ClcSACAll(pDocNum,pItmNum,pStkNum,ohSAC.SacNum,mSe,mSu,mV);
              mSeS:=mSeS+mSe;
              mSuS:=mSuS+mSu;
              mVS:=mVS+mV;
            end;
            ohSAC.Next;
          until ohSAC.Eof or (ohSAC.DocNum<>SacDocNum(pDocNum))or (ohSAC.ItmNum<>pItmNum);
          ohSAC.LocateDnSn(SacDocNum(pDocNum),mParent);
          ohSAC.Edit;
          ohSAC.CValue:=mVS;
          If IsNotNul(ohSAC.CpSuQnt)
            then ohSAC.CPrice:=ohSAC.CValue/ohSAC.CpSuQnt
            else ohSAC.CPrice:=ohSAC.CValue;
          ohSAC.Post;
        end;
      end;
    end else begin
      mParent:=pItmNum;
      ohSAC.LocateDnInSt(SacDocNum(pDocNum),pItmNum,pStkNum);
      repeat
        If (ohSAC.Parent=-1) and (ohSAC.ItmNum=pItmNum) then begin
          ClcSacAll(pDocNum,pItmNum,pStkNum,ohSAC.SacNum,mSe,mSu,mV);
          mSeS:=mSeS+mSe;
          mSuS:=mSuS+mSu;
          mVS:=mVS+mV;
        end;
        ohSAC.Next;
      until ohSAC.Eof or (ohSAC.DocNum<>SacDocNum(pDocNum))or (ohSAC.ItmNum<>pItmNum)
    end;
  end;
  ohSAC.RestoreStatus;
  pSeQnt:=mSeS;pSuQnt:=mSuS;pCValue:=mVS;
end;

end.
{MOD 1808004}
