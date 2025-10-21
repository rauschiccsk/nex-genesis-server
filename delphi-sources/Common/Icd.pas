unit Icd;
{$F+}

// *****************************************************************************
//                               OBJEKT NA PRACU S OF
// *****************************************************************************
// Tento objekt obsahuje funkcie, ktorÈ umoûnia naËÌtaù poloûky dokladov a
// uloûiù ich do inÈho dokladu
//
// ProgramovÈ funkcia:
// ---------------
// Gen - vygeneruje odberateæsk˙ fakt˙ru zo zadanÈho zdrojovÈho dokladu.
//       Zdrojov˝ doklad moûe byù:
//       - Odberateæsk˝ dodacÌ list
// Edo - vyhotovi elektronicky doklad na medizfiremnu komunikaciu
// *****************************************************************************


interface

uses
  IcVariab, IcTypes, IcConst, IcConv, IcTools, DocHand, StkGlob,
  hSYSTEM, hGSCAT, hGSNOTI, hPAB, hPLS, hTCH, hTCI, hICH, hICI, hICN, tICH, tICI,
  NexGlob, NexPath, NexIni, NexMsg, NexError,
  LinLst, SavClc, TxtDoc, TxtWrap, Bok, Key, Udo, Jrn, Rep, PayFnc,
  SysUtils, Classes, Forms;

type
  PDat=^TDat;
  TDat=record
    rhICH:TIchHnd;
    rhICI:TIciHnd;
    rhICN:TIcnHnd;
  end;

  TIcd = class(TComponent)
    constructor Create(AOwner: TComponent);
    destructor  Destroy; override;
    private
      oFrmName:Str15;
      oBokNum:Str5;
      oLst:TList;

      oYear:Str2;
      oSerNum:longint;
      oDocNum:Str12;
      oPlsNum:word;
      oPaCode:longint;
      oDocDate:TDateTime;
      ohGSCAT:TGscatHnd;
      procedure Activate(pIndex:word); // Aktivuje databazu, ktora je otvorena pod poradovym cislom pIndex
      function GetOpenCount:word;
      procedure IcdFromTcd(pTcdNum,pIcdNum:Str12); // Vyhgeneruje OF z OD
    public
      oWeight:double;
      oVolume:double;
      ohPAB:TPabHnd;
      ohICH:TIchHnd;
      ohICI:TIciHnd;
      otICI:TIciTmp;
      ohICN:TIcnHnd;
      procedure Open(pBokNum:Str5); overload; // Otvori vsetky databazove subory
      procedure Open(pBokNum:Str5;pICH,pICI,pICN:boolean); overload;// Otvori zadane databazove subory
      procedure OpenLst(pBokLst:ShortString); // Otvori vsetky knihy ktore su zadane v retazci

      procedure Gen(pSrcDoc:Str12); // Vytvori OF na zaklade zadaneho zdrojoveho dokladu
      procedure Par(pTcdDoc,pIcdNum:Str12); // Parovanie ODL s OF
      procedure Edo; // VytvorÌ elektronick˝ dokument
      procedure Prn; // VytlaËÌ aktualnu fakturu
      procedure NewDoc(pYear:Str2;pPaCode:longint;pResDoc:boolean); overload; // Vygeneruje novu hlavicku dokladu
      procedure NewDoc(pYear:Str2;pPaCode:longint;pStkNum:word;pResDoc:boolean); overload; // Vygeneruje novu hlavicku dokladu
      procedure CnfDoc; // Potvrdenie dokladu nastavi priznak rezervacie DstLck=9 na 0
      procedure ImpDoc(pDocNum:Str12;pUdo:TUdo);  // Importuje fakturu z univerzalneho dokladu
      procedure ClcDoc; overload; // Prepocita hlavicku aktualneho dokladu
      procedure ClcDoc(pDocNum:Str12); overload; // Prepocita hlavicku zadaneho dokladu
      procedure PrnDoc; overload; // VytlaËÌ aktualnu fakturu
      procedure PrnDoc(pDocNum:Str12;pAutPrn:boolean;pPrnNam,pPdfNam:Str50;pCopies:word); overload; // VytlaËÌ zadanu fakturu
      procedure PrnDoc(pDocNum:Str12;pAutPrn:boolean;pPrnNam,pPdfNam:Str50;pCopies:word;pPdf:boolean); overload; // VytlaËÌ zadanu fakturu
      procedure SlcItm(pDocNum:Str12); // Nacita polozky zadaneho dokladu do PX
      procedure AddItm(pDocNum:Str12;pGsCode:longint;pGsQnt,pDscPrc,pFgBPrice:double;pGsName:Str30;pErCode:longint); // Prida novu polozku na zadanu fakturu
      procedure AddNot(pDocNum:Str12;pLinNum:word;pNotType:Str1;pNotice:Str250); // Prida poznamku k dokladu
      procedure MovDoc(pSrDocNum,pTrDocNum:Str12;pDocDate:TDateTime;pChgTrg:boolean;pSrcBok,pTrgBok:Str5); // Presun dokladu

      function DelDoc(pDocNum:Str12):boolean; // Vymaze zadanu fakturu

      function LocDocNum(pDocNum:Str12):boolean; // Hlada interne cislo faktury vo vsetkych knihach OF
      function LocExtNum(pExtNum:Str12):boolean; // Hlada variabilny symbol vo vsetkych knihach OF
      function LocOcdNum(pOcdNum:Str12):boolean; // Hlada cislo zmluvy vo vsetkych knihach OF
    published
      property BokNum:Str5 read oBokNum;

      property Year:str2 write oYear;
      property SerNum:longint write oSerNum;
      property DocNum:Str12 read oDocNum;
      property PlsNum:word write oPlsNum;
      property PaCode:longint write oPaCode;
      property DocDate:TDateTime write oDocDate;
      property phPAB:TPabHnd read ohPAB;
  end;

implementation

uses bICH, bPAB, bGSCAT;

constructor TIcd.Create(AOwner: TComponent);
begin
  oFrmName:='';
  If AOwner<>nil then oFrmName := AOwner.Name;
  oPlsNum:=1;
  oLst:=TList.Create;  oLst.Clear;
  otICI:=TIciTmp.Create;
  ohGSCAT:=TGscatHnd.Create;
  ohPAB:=TPabHnd.Create;  ohPAB.Open(0);
end;

destructor TIcd.Destroy;
var I:word;
begin
  If oLst.Count>0 then begin
    For I:=1 to oLst.Count do begin
      Activate (I);
      FreeAndNil(ohICN);
      FreeAndNil(ohICI);
      FreeAndNil(ohICH);
    end;
  end;
  FreeAndNil (oLst);
  FreeAndNil (otICI);
  FreeAndNil (ohPAB);
  FreeAndNil (ohGSCAT);
end;

// ********************************* PRIVATE ***********************************

procedure TIcd.IcdFromTcd(pTcdNum,pIcdNum:Str12); // Vyhgeneruje OD z DD
var mTcbNum:Str5;  mItmNum:word;  mhTCH:TTchHnd;  mhTCI:TTciHnd;  mSav:TSavClc;
begin
  mTcbNum := BookNumFromDocNum (pTcdNum);
  mhTCH := TTchHnd.Create;  mhTCH.Open(mTcbNum);
  mhTCI := TTciHnd.Create;  mhTCI.Open(mTcbNum);
  If mhTCH.LocateDocNum(pTcdNum) then begin
    If mhTCI.LocateDocNum(pTcdNum) then begin
      If pIcdNum='' then begin // Cislo faktury nie je zadane t.j. hlavicku treba vytvorit
        If oYear='' then oYear := mhTCH.Year;
        If oSerNum=0 then oSerNum := ohICH.NextSerNum(oYear); // Ak nie je zadane poradove cislo OD vygenerujeme nasledujuce
        If oDocDate=0 then oDocDate := Date; // Ak nie je zadany datum nastavime aktualny den
        oDocNum := ohICH.GenDocNum(oYear,oSerNum);
        If not ohICH.LocateDocNum(oDocNum) then begin // Ak neexistuje vyvorime hlacicku dokladu OD
          ohICH.Insert;
          BTR_To_BTR (mhTCH.BtrTable,ohICH.BtrTable);
          ohICH.Year := oYear;
          ohICH.SerNum := oSerNum;
          ohICH.DocNum := oDocNum;
          ohICH.ExtNum := GenExtNum(oDocDate,'',gKey.IcbExnFrm[ohICH.BtrTable.BookNum],oSerNum,ohICH.BtrTable.BookNum,gKey.IcbStkNum[ohICH.BtrTable.BookNum]);
          ohICH.WriNum := gKey.IcbWriNum[ohICH.BtrTable.BookNum];
          ohICH.StkNum := gKey.IcbStkNum[ohICH.BtrTable.BookNum];
          ohICH.CsyCode := gKey.IcbCoSymb[ohICH.BtrTable.BookNum];
          ohICH.FgCourse := 1;
          ohICH.DocDate := oDocDate;
          ohICH.SndDate := oDocDate;
          ohICH.VatDate := oDocDate;
          If ohPAB.LocatePaCode(oPaCode) then begin
            ohICH.ExpDate := oDocDate+ohPAB.IcExpDay;
          end;
  //        ohICH.FgDvzName := gKey.IcbDvName[ohICH.BtrTable.BookNum];
          ohICH.Post;
        end;
      end
      else oDocNum := pIcdNum;
      If ohICH.LocateDocNum(oDocNum) then begin // Kontrola ci existuje hlavicka
        // Vytvorime polozky OD na zaklade DD
        mSav := TSavClc.Create;
        mItmNum := ohICI.NextItmNum(ohICH.DocNum);
        Repeat
          If mhTCI.IcdNum='' then begin
            ohICI.Insert;
            BTR_To_BTR (mhTCI.BtrTable,ohICI.BtrTable);
            ohICI.DocNum := oDocNum;
            ohICI.ItmNum := mItmNum;
            ohICI.TcdNum := mhTCI.DocNum;
            ohICI.TcdItm := mhTCI.ItmNum;
            ohICI.TcdDate := mhTCI.DocDate;
            ohICI.DocDate := ohICH.DocDate;
            ohICI.Status := 'Q';
            ohICI.Post;
            // UloûÌme odkaz do OD na OF
            mhTCI.Edit;
            mhTCI.IcdNum := ohICI.DocNum;
            mhTCI.IcdItm := ohICI.ItmNum;
            mhTCI.IcdDate := ohICI.DocDate;
            mhTCI.FinStat := 'F';
            mhTCI.Post;
            Inc (mItmNum);
          end;
          Application.ProcessMessages;
          mhTCI.Next;
        until mhTCI.Eof or (mhTCI.DocNum<>pTcdNum);
        ohICH.Clc(ohICI);
        FreeAndNil (mSav);
      end;
    end;
    mhTCH.Clc(mhTCI);
  end;
  FreeAndNil (mhTCI);
  FreeAndNil (mhTCH);
end;

function TIcd.GetOpenCount:word;
begin
  Result := oLst.Count;
end;

procedure TIcd.Activate(pIndex:word); // Aktivuje databazu, ktora je otvorena pod poradovym cislom pIndex
var mDat:PDat;
begin
  mDat := oLst.Items[pIndex-1];
  ohICH := mDat.rhICH;
  ohICI := mDat.rhICI;
  ohICN := mDat.rhICN;
end;

// ********************************** PUBLIC ***********************************

procedure TIcd.Open(pBokNum:Str5); // Otvori vsetky databazove subory
begin
  Open (pBokNum,TRUE,TRUE,TRUE);
end;

procedure TIcd.Open(pBokNum:Str5;pICH,pICI,pICN:boolean); // Otvori zadane databazove subory
var mFind:boolean;  mCnt:word;  mDat:PDat;
begin
  oBokNum := pBokNum;
  mFind := FALSE;
  If oLst.Count>0 then begin
    mCnt := 0;
    Repeat
      Inc (mCnt);
      Activate(mCnt);
      mFind := ohICH.BtrTable.BookNum=pBokNum;
    until mFind or (mCnt=oLst.Count);
  end;
  If not mFind then begin // Ak dana kniha este nie je otvorena potomotvorime
    // Vytvorime objekty
    ohICH := TIchHnd.Create;
    ohICI := TIciHnd.Create;
    ohICN := TIcnHnd.Create;
    // Otvorime databazove subory
    If pICH then ohICH.Open(pBokNum);
    If pICI then ohICI.Open(pBokNum);
    If pICN then ohICN.Open(pBokNum);
    // Ulozime objekty do zoznamu
    GetMem (mDat,SizeOf(TDat));
    mDat^.rhICH := ohICH;
    mDat^.rhICI := ohICI;
    mDat^.rhICN := ohICN;
    oLst.Add(mDat);
  end;
end;

procedure TIcd.OpenLst(pBokLst:ShortString); // Otvori vsetky knihy ktore su zadane v retazci
var mLinLst:TLinLst;
begin
  mLinLst := TLinLst.Create;
  mLinLst.AddLst(pBokLst);
  If mLinLst.Count>0 then begin
    mLinLst.First;
    Repeat
      If gBok.BokExist('ICB',mLinLst.Itm,TRUE) then begin
        Open (mLinLst.Itm);
      end;
      Application.ProcessMessages;
      mLinLst.Next;
    until mLinLst.Eof;
  end
  else begin  // Otvorime vsetky knihy
    gBok.LoadBokLst('ICB','');
    If gBok.BokLst.Count>0 then begin
      gBok.BokLst.First;
      Repeat
        Open (gBok.BokLst.Itm);
        Application.ProcessMessages;
        gBok.BokLst.Next;
      until gBok.BokLst.Eof;
    end;
  end;
  FreeAndNil (mLinLst);
end;

procedure TIcd.Gen(pSrcDoc:Str12); // Vytvori OF na zaklade zadaneho zdrojoveho dokladu
var mDocType:byte;
begin
  mDocType := GetDocType (pSrcDoc);
  case mDocType of
    dtTC: IcdFromTcd(pSrcDoc,''); // Vyggeneruje OF z DD
  end;
end;

procedure TIcd.Par(pTcdDoc,pIcdNum:Str12); // Parovanie ODL s OF
begin
  IcdFromTcd(pTcdDoc,pIcdNum);
end;

procedure TIcd.Edo; // VytvorÌ elektronick˝ dokument
var mFileName:string; mWrap:TTxtWrap;  mTxtDoc: TTxtDoc;  mhPLS:TPlsHnd;
begin
  If oPlsNum=0 then oPlsNum := 1;
  mhPLS := TPlsHnd.Create;  mhPLS.Open(oPlsNum);
  mFileName := gIni.GetComPath+ohICH.ExtNum+'.TXT';
  mTxtDoc := TTxtDoc.Create;
  If FileExists (mFileName) then DeleteFile (mFileName);
  // Ulozime hlacivku dokladu
  mTxtDoc.WriteString ('ExtNum',ohICH.ExtNum);
  mTxtDoc.WriteDate ('DocDate',ohICH.DocDate);
  mTxtDoc.WriteDate ('ExpDate',ohICH.ExpDate);
  mTxtDoc.WriteDate ('TaxDate',ohICH.VatDate);
  mTxtDoc.WriteString ('RegIno',ohICH.RegIno);
  mTxtDoc.WriteString ('RegTin',ohICH.RegTin);
  mTxtDoc.WriteString ('RegVin',ohICH.RegVin);
  mTxtDoc.WriteString ('RegName',ohICH.RegName);
  mTxtDoc.WriteString ('RegCtn',ohICH.RegCtn);
  mTxtDoc.WriteString ('RegZip',ohICH.RegZip);
  mTxtDoc.WriteString ('ContoNum',ohICH.MyConto);
  mTxtDoc.WriteString ('FgDvzName',ohICH.FgDvzName);
  mTxtDoc.WriteFloat ('FgAValue',ohICH.FgAValue);
  mTxtDoc.WriteFloat ('FgBValue',ohICH.FgBValue);
  mTxtDoc.WriteInteger ('ItmQnt',ohICH.ItmQnt);
  // Ulozime poloziek dokladu
  If ohICI.LocateDocNum(ohICH.DocNum) then begin
    Repeat
      mTxtDoc.Insert;
      mTxtDoc.WriteString ('BarCode',ohICI.BarCode);
      mTxtDoc.WriteString ('GsName',ohICI.GsName);
      mTxtDoc.WriteString ('MsName',ohICI.MsName);
      mTxtDoc.WriteInteger ('VatPrc',ohICI.VatPrc);
      mTxtDoc.WriteFloat ('GsQnt',ohICI.GsQnt);
      mTxtDoc.WriteFloat ('DscPrc',ohICI.DscPrc);
      mTxtDoc.WriteFloat ('FgDValue',ohICI.FgDValue);
      mTxtDoc.WriteFloat ('FgDscVal',ohICI.FgDscVal);
      mTxtDoc.WriteFloat ('FgAValue',ohICI.FgAValue);
      mTxtDoc.WriteFloat ('FgBValue',ohICI.FgBValue);
      If mhPLS.LocateGsCode(ohICI.GsCode)
        then mTxtDoc.WriteFloat ('EuBPrice',mhPLS.BPrice)
        else mTxtDoc.WriteFloat ('EuBPrice',0);
      mTxtDoc.Post;
      ohICI.Next;
      Application.ProcessMessages;
    until (ohICI.Eof) or (ohICI.DocNum<>ohICH.DocNum);
  end;
  mTxtDoc.SaveToFile (mFileName);
  FreeAndNil (mTxtDoc);
  FreeAndNil (mhPLS);
end;

procedure TIcd.Prn; // VytlaËÌ aktualnu fakturu
begin
end;

procedure TIcd.NewDoc(pYear:Str2;pPaCode:longint;pResDoc:boolean); // Vygeneruje novu hlavicku dokladu
begin
  NewDoc(pYear,pPaCode,0,pResDoc);
end;

procedure TIcd.NewDoc(pYear:Str2;pPaCode:longint;pStkNum:word;pResDoc:boolean); // Vygeneruje novu hlavicku dokladu
begin
  oYear:=pYear;
  If oSerNum=0 then oSerNum:=ohICH.NextSerNum(pYear); // Ak nie je zadane poradove cislo OD vygenerujeme nasledujuce
  If oDocDate=0 then oDocDate:=Date; // Ak nie je zadany datum nastavime aktualny den
  oDocNum:=ohICH.GenDocNum(pYear,oSerNum);
  If not ohICH.LocateDocNum(oDocNum) then begin // Ak neexistuje vyvorime hlacicku dokladu OD
    ohICH.Insert;
    ohICH.DocNum:=oDocNum;
    ohICH.Year:=oYear;
    ohICH.SerNum:=oSerNum;
    ohICH.WriNum:=gKey.IcbWriNum[BokNum];
    If pStkNum<>0
      then ohICH.StkNum:=pStkNum
      else ohICH.StkNum:=gKey.IcbStkNum[BokNum];
    ohICH.ExtNum:=GenExtNum(oDocDate,'',gKey.IcbExnFrm[BokNum],oSerNum,BokNum,ohICH.StkNum);
    ohICH.CsyCode:=gKey.IcbCoSymb[BokNum];
    ohICH.DocDate:=oDocDate;
    ohICH.SndDate:=oDocDate;
    ohICH.VatDate:=oDocDate;
    ohICH.RspName:=gvSys.UserName;
    ohICH.DocSpc:=gKey.IcbDocSpc[BokNum];
    If ohPAB.LocatePaCode(pPaCode) then begin
      BTR_To_BTR(ohPAB.BtrTable,ohICH.BtrTable);
      ohICH.PlsNum:=ohPAB.IcPlsNum;
      ohICH.ExpDate:=oDocDate+ohPAB.IcExpDay;
      // Zadat aj miesto dodania
    end;
    ohICH.SpaCode:=ohICH.PaCode;
    ohICH.WpaName:=ohICH.PaName;
    ohICH.WpaAddr:=ohICH.RegAddr;
    ohICH.WpaSta:=ohICH.RegSta;
    ohICH.WpaZip:=ohICH.RegZip;
    ohICH.WpaCty:=ohICH.RegCty;
    ohICH.WpaCtn:=ohICH.RegCtn;
    ohICH.MyConto:=gKey.IcbBaIban[BokNum];
    ohICH.AcDvzName:=gKey.SysAccDvz;
    ohICH.FgDvzName:=gKey.IcbDvName[BokNum];
    ohICH.FgCourse:=1;
    ohICH.VatDoc:=1;
    If pResDoc
      then ohICH.DstLck:=9
      else ohICH.DstLck:=0;
    ohICH.Post;
  end;
end;

procedure TIcd.CnfDoc; // potvrdenie dokladu nastavi priznak rezervacie DstLck=9 na 0
begin
  If ohICH.DstLck=9 then begin
    ohICH.Edit;
    ohICH.DstLck := 0;
    ohICH.Post;
  end;
end;

procedure TIcd.ImpDoc(pDocNum:Str12;pUdo:TUdo);  // Importuje fakturu z univerzalneho dokladu
var mItmNum:word;
begin
  If pUdo.Count>0 then begin
    If ohICH.LocateDocNum(pDocNum) then begin
      mItmNum := ohICI.NextItmNum(ohICH.DocNum);
      pUdo.First;
      Repeat
        // Vytvorime polozku faktury
        ohICI.Insert;
        PX_To_BTR (pUdo.TmpTable,ohICI.BtrTable);
        ohICI.DocNum := pDocNum;
        ohICI.ItmNum := mItmNum;
        ohICI.ScdNum := pUdo.DocNum;
        ohICI.ScdItm := pUdo.ItmNum;
        If ohICI.TcdNum=''
          then ohICI.Status := 'N'
          else ohICI.Status := 'Q';
        ohICI.Post;
        // Ulozime odkaz na polozku faktury
        pUdo.Edit;
        pUdo.IcdNum := pDocNum;
        pUdo.IcdItm := mItmNum;
        pUdo.IcdDate := ohICH.DocDate;
        pUdo.Post;
        Inc (mItmNum);
        Application.ProcessMessages;
        pUdo.Next;
      until pUdo.Eof;
      ohICH.Clc(ohICI);
    end;
  end;
end;

procedure TIcd.ClcDoc; // prepocita hlavicku zadaneho dokladu
begin
  ohICH.Clc(ohICI);
end;

procedure TIcd.ClcDoc(pDocNum:Str12); // prepocita hlavicku zadaneho dokladu
var mBokNum:Str5;
begin
  mBokNum := BookNumFromDocNum(pDocNum);
  Open (mBokNum,TRUE,TRUE,FALSE);
  If ohICH.LocateDocNum(pDocNum) then ohICH.Clc(ohICI);
end;

procedure TIcd.PrnDoc; // VytlaËÌ aktualnu fakturu
begin
  PrnDoc(ohICH.DocNum,FALSE,'','',0,FALSE);
end;

procedure TIcd.PrnDoc(pDocNum:Str12;pAutPrn:boolean;pPrnNam,pPdfNam:Str50;pCopies:word); // VytlaËÌ aktualnu fakturu
begin
  PrnDoc(pDocNum,pAutPrn,pPrnNam,pPdfNam,pCopies,FALSE);
end;

procedure TIcd.PrnDoc(pDocNum:Str12;pAutPrn:boolean;pPrnNam,pPdfNam:Str50;pCopies:word;pPdf:boolean); // VytlaËÌ zadanu fakturu
var mJrn:TJrn;  mRep:TRep;  mtICH:TIchTmp;  mhSYSTEM:TSystemHnd;  mBokNum:Str5;  mInfVal:double;  mFileName:ShortString;
begin
  mBokNum:=BookNumFromDocNum(pDocNum);
//  If pMasNam='' then pMasNam:=
  If pPdfNam='' then pPdfNam:=pDocNum;
  Open(mBokNum);
  ohICH.SwapIndex;
  If ohICH.LocateDocNum(pDocNum) then begin
    mhSYSTEM:=TSystemHnd.Create;  mhSYSTEM.Open;
    mtICH:=TIchTmp.Create;   mtICH.Open;
    mtICH.Insert;
    BTR_To_PX(ohICH.BtrTable,mtICH.TmpTable);
    mtICH.RegStn:=GetStaName(mtICH.RegSta);
    mtICH.WpaStn:=GetStaName(mtICH.WpaSta);
    If gKey.IcbVatClc[mBokNum] then begin
      mtICH.FgAValue1:=Rd2(ohICH.FgBValue1/(1+(ohICH.VatPrc[1]/100)));
      mtICH.FgAValue2:=Rd2(ohICH.FgBValue2/(1+(ohICH.VatPrc[2]/100)));
      mtICH.FgAValue3:=Rd2(ohICH.FgBValue3/(1+(ohICH.VatPrc[3]/100)));
      mtICH.FgAValue4:=Rd2(ohICH.FgBValue4/(1+(ohICH.VatPrc[4]/100)));
      mtICH.FgVatVal1:=Rd2(mtICH.FgBValue1-mtICH.FgAValue1);
      mtICH.FgVatVal2:=Rd2(mtICH.FgBValue2-mtICH.FgAValue2);
      mtICH.FgVatVal3:=Rd2(mtICH.FgBValue3-mtICH.FgAValue3);
      mtICH.FgVatVal4:=Rd2(mtICH.FgBValue4-mtICH.FgAValue4);
      mtICH.FgAValue:=mtICH.FgAValue1+mtICH.FgAValue2+mtICH.FgAValue3+mtICH.FgAValue4;
      mtICH.FgVatVal:=mtICH.FgVatVal1+mtICH.FgVatVal2+mtICH.FgVatVal3+mtICH.FgVatVal4;
      mtICH.FgBValue:=mtICH.FgBValue1+mtICH.FgBValue2+mtICH.FgBValue3+mtICH.FgBValue4;
    end
    else begin
      mtICH.FgVatVal1:=ohICH.FgBValue1-ohICH.FgAValue1;
      mtICH.FgVatVal2:=ohICH.FgBValue2-ohICH.FgAValue2;
      mtICH.FgVatVal3:=ohICH.FgBValue3-ohICH.FgAValue3;
      mtICH.FgVatVal4:=ohICH.FgBValue4-ohICH.FgAValue4;
    end;
    SlcItm(pDocNum);
    mtICH.DlrName:=GetDlrName(ohICH.DlrCode);
    mtICH.Weight:=oWeight;
    mtICH.Volume:=oVolume;
    mtICH.Post;
//    SlcItm(pDocNum);
    mJrn:=TJrn.Create;
    mJrn.DocAcc(pDocNum);
//    If gIni.StkCodePrnShort then dmSTK.ptTCI.IndexName := 'ScBc';
    // --------------------------
    mRep:=TRep.Create(Self);
    mRep.SysBtr:=mhSYSTEM.BtrTable;
    mRep.HedTmp:=mtICH.TmpTable;
    mRep.SpcTmp:=mJrn.ptDOCACC.TmpTable;
    mRep.ItmTmp:=otICI.TmpTable;
    If ohICH.VatDoc=1
      then mFileName:=gKey.IcbRepVtd[ohICH.BtrTable.BookNum]
      else mFileName:=gKey.IcbRepNvd[ohICH.BtrTable.BookNum];
    If pPdf
      then mRep.ExecuteQuick(mFileName,'PDFCreator',pPdfNam)
      else begin
        If pAutPrn
          then mRep.ExecuteQuick(mFileName,pPrnNam,ohICH.DocNum,pCopies)
          else mRep.Execute(mFileName,ohICH.DocNum);
      end;
    FreeAndNil (mRep);
    // --------------------------
    FreeAndNil(mJrn);
    FreeAndNil(mtICH);
    FreeAndNil(mhSYSTEM);
  end;
  ohICH.RestoreIndex;
end;

procedure TIcd.SlcItm(pDocNum:Str12); // nacita polozky zadaneho dokladu do PX
var mSpcSet:Str3;  mhGSNOTI:TGsnotiHnd;  mLn7,mLn8,mLn9:Str20;
begin
  oWeight:=0;  oVolume:=0;
  If otICI.Active then otICI.Close;
  otICI.Open;
//13.10.2015 Tibi - GsCat nebol otvoren˝
  If not ohGSCAT.Active then ohGSCAT.Open;
  If ohICI.LocateDocNum(pDocNum) then begin
    mSpcSet:=gIni.SpecSetting;
    If mSpcSet='TOP' then begin
      mhGSNOTI:=TGsnotiHnd.Create;  mhGSNOTI.Open;
    end;
    Repeat
      otICI.Insert;
      BTR_To_PX (ohICI.BtrTable,otICI.TmpTable);
      If mSpcSet='TOP' then begin
        If mhGSNOTI.LocateGsCode(ohICI.GsCode) then begin
          mhGSNOTI.Next;  mhGSNOTI.Next;  mhGSNOTI.Next;  mhGSNOTI.Next;  mhGSNOTI.Next;  mhGSNOTI.Next;
          mLn7:=mhGSNOTI.Notice; mhGSNOTI.Next;
          mLn8:=mhGSNOTI.Notice; mhGSNOTI.Next;
          mLn9:=mhGSNOTI.Notice;
          otICI.Notice:='Spotreba='+mLn7+'; Valiv˝ odpor='+mLn8+'; HluËnosù='+mLn9;
        end;
      end;
      If ohGSCAT.LocateGsCode(ohICI.GsCode) then begin
        otICI.Weight:=ohGSCAT.Weight*otICI.GsQnt;
        otICI.Volume:=ohGSCAT.Volume*otICI.GsQnt;
        otICI.GsName:=ohGSCAT.GsName;
        oWeight:=oWeight+otICI.Weight;
        oVolume:=oVolume+otICI.Volume;
      end;
      otICI.Post;
      Application.ProcessMessages;
      ohICI.Next;
    until ohICI.Eof or (ohICI.DocNum<>pDocNum);
    If mSpcSet='TOP' then FreeAndNil(mhGSNOTI);
  end;
end;

procedure TIcd.AddItm(pDocNum:Str12;pGsCode:longint;pGsQnt,pDscPrc,pFgBPrice:double;pGsName:Str30;pErCode:longint); // Prida novu polozku na zadanu fakturu
var mItmNum:word;
begin
  If ohICH.LocateDocNum(pDocNum) then begin
    If not ohGSCAT.Active then ohGSCAT.Open;
    If ohGSCAT.LocateGsCode(pGsCode) then begin
      mItmNum := ohICI.NextItmNum(pDocNum);
      ohICI.Insert;
      ohICI.DocNum := pDocNum;
      ohICI.ItmNum := mItmNum;
      BTR_To_BTR(ohGSCAT.BtrTable,ohICI.BtrTable);
      ohICI.GsQnt := pGsQnt;
      If pGsName<>'' then ohICI.GsName := pGsName;
      ohICI.DscPrc := pDscPrc;
      ohICI.SetFgBPrice(pFgBPrice,ohICH.FgCourse);
      ohICI.StkNum := ohICH.StkNum;
      ohICI.WriNum := ohICH.WriNum;
      ohICI.PaCode := ohICH.PaCode;
      ohICI.DocDate := ohICH.DocDate;
      ohICI.Post;
    end
    else ShowMsg(pErCode,StrInt(pGsCode,0));
  end
  else ShowMsg(eCom.DocIsNoExist,pDocNum);
end;

procedure TIcd.AddNot(pDocNum:Str12;pLinNum:word;pNotType:Str1;pNotice:Str250); // Prida poznamku k dokladu
begin
  ohICN.Insert;
  ohICN.DocNum := pDocNum;
  ohICN.LinNum := pLinNum;
  ohICN.NotType := pNotType;
  ohICN.Notice := pNotice;
  ohICN.Post;
end;

function TIcd.DelDoc(pDocNum:Str12):boolean; // Vymaze zadanu fakturu
begin
  Result := TRUE;
  Open(BookNumFromDocNum(pDocNum));
  If ohICH.LocateDocNum(pDocNum) then begin
    If ohICI.LocateDocNum(pDocNum) then Result := FALSE;
    ohICN.Del(pDocNum);
    If Result then ohICH.Delete;  // Ak je nastavene zrusenie hlavicky a bola vymazana kazda polozka zrusime hlavicku dokladu
  end;
end;

function TIcd.LocDocNum(pDocNum:Str12):boolean; // Hlada variabilny symbol vo vsetkych knihach OF
var mCnt:word;
begin
  mCnt := 0;
  Result := FALSE;
  Repeat
    Inc (mCnt);
    Activate(mCnt);
    Result := ohICH.LocateDocNum(pDocNum);
    Application.ProcessMessages;
  until (mCnt=oLst.Count) or Result;
end;

function TIcd.LocExtNum(pExtNum:Str12):boolean; // Hlada variabilny symbol vo vsetkych knihach OF
var mCnt:word;
begin
  mCnt := 0;
  Result := FALSE;
  Repeat
    Inc (mCnt);
    Activate(mCnt);
    Result := ohICH.LocateExtNum(pExtNum);
    Application.ProcessMessages;
  until (mCnt=oLst.Count) or Result;
end;

function TIcd.LocOcdNum(pOcdNum:Str12):boolean; // Hlada cislo zmluvy vo vsetkych knihach OF
var mCnt:word;
begin
  mCnt := 0;
  Result := FALSE;
  Repeat
    Inc (mCnt);
    Activate(mCnt);
    Result := ohICH.LocateOcdNum(pOcdNum);
    Application.ProcessMessages;
  until (mCnt=oLst.Count) or Result;
end;

procedure TIcd.MovDoc;
var mhIcH:TIchHnd;  mhIcI:TIciHnd; mhIcn:TIcnHnd;
begin
  Open(pTrgBok);
  mhIcH := TIchHnd.Create;  mhIcH.Open(pSrcBok);
  mhIcI := TIciHnd.Create;  mhIcI.Open(pSrcBok);
  mhIcN := TIcnHnd.Create;  mhIcN.Open(pSrcBok);
  If mhIcH.LocateDocNum(pSrDocNum) then begin
    If mhIcI.LocateDocNum(pSrDocNum) then begin
      If pChgTrg then begin
        oYear   := YearFromDocNum(pTrDocNum);
        oDocNum := pTrDocNum;
        oSerNum := SerNumFromDocNum(pTrDocNum);
        oDocDate:= pdocDate;
      end else begin
        oDocNum := mhIcH.DocNum;
        oSerNum := mhIcH.SerNum;
        oDocDate := mhIcH.DocDate;
      end;
      If not ohIcH.LocateDocNum(oDocNum) then begin // Ak neexistuje vyvorime hlacicku dokladu OD
        ohIcH.Insert;
        BTR_To_BTR (mhIcH.BtrTable,ohIcH.BtrTable);
//      If pChgTrg then begin
        ohICH.DocNum:=oDocNum;
        ohICH.SerNum:=oSerNum;
        ohICH.Year:=oYear;
        ohICH.DocDate:=oDocDate;
        ohICH.ExtNum:=GenExtNum(ohICH.DocDate,'',gKey.IcbExnFrm[ohICH.BtrTable.BookNum],ohICH.SerNum,ohICH.BtrTable.BookNum,gKey.IcbStkNum[ohICH.BtrTable.BookNum]);
//      end;
        ohICH.Post;
      end;
      // Prekopirujeme polozky dodacieho listu
      Repeat
        ohICI.Insert;
        BTR_To_BTR (mhIcI.BtrTable,ohIcI.BtrTable);
//        If pChgTrg then begin
        ohICI.DocNum:=oDocNum;
        ohICI.DocDate:=oDocDate;
//        end;
        ohIcI.Post;
        // Precislujeme skladove pohyby a FIFO
        Application.ProcessMessages;
        mhIcI.Next;
      until mhIcI.Eof or (mhIcI.DocNum<>pSrDocNum);
      If mhIcN.LocateDocNum(pSrDocNum) then begin
        Repeat
          ohIcN.Insert;
          BTR_To_BTR (mhIcN.BtrTable,ohIcN.BtrTable);
          If pChgTrg then begin
            ohIcN.DocNum := oDocNum;
          end;
          ohIcN.Post;
          // Precislujeme skladove pohyby a FIFO
          Application.ProcessMessages;
          mhIcN.Next;
        until mhIcN.Eof or (mhIcN.DocNum<>pSrDocNum);
      end;
      ohIcH.Clc(ohIcI);
      mhIcI.Del(pSrDocNum);
      mhIcN.Del(pSrDocNum);
      mhIcH.Del(pSrDocNum);
    end;
  end;
  mhIcN.Close;FreeAndNil (mhIcN);
  mhIcI.Close;FreeAndNil (mhIcI);
  mhIcH.Close;FreeAndNil (mhIcH);
end;

end.
{MOD 1807028}
{MOD 1904012}
{MOD 1905019}
{MOD 1907001}
