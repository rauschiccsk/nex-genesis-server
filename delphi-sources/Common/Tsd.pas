unit Tsd;
{$F+}

// *****************************************************************************
//                               OBJEKT NA PRACU S DD
// *****************************************************************************
// Tento objekt obsahuje funkcie, ktoré umožnia naèíta položky dokladov a
// uloži ich do iného dokladu
//
// Programové funkcia:
// ---------------
// *****************************************************************************


interface

uses
  IcTypes, IcConst, IcConv, IcTools, IcVariab, DocHand, NexGlob, NexPath, NexIni, NexMsg, NexError, IstFnc,
  SavClc, LinLst, Bok, Rep, Key, Stk, Jrn, Icd, ItgLog,
  hSYSTEM, hGSCAT, hPAB, hTSH, hTSI, hTSN, tTSH, tTSI, hJOURNAL, tDHEAD,
  ComCtrls, SysUtils, Classes, Forms;

type
  PDat=^TDat;
  TDat=record
    rhTSH:TTshHnd;
    rhTSI:TTsiHnd;
    rhTSN:TTsnHnd;
  end;

  TTsd = class(TComponent)
    constructor Create(AOwner: TComponent);
    destructor  Destroy; override;
    private
      oFrmName:Str15;
      oBokNum:Str5;
      oDocClc:TStrings;
      oLst:TList;
      oYear:Str2;
      oSerNum:longint;
      oDocNum:Str12;
      oPaCode:longint;
      oDocDate:TDateTime;
      oInd:TProgressBar;
      ohPAB:TPabHnd;
      ohGSCAT:TGscatHnd;
      procedure Activate(pIndex:word); // Aktivuje databazu, ktora je otvorena pod poradovym cislom pIndex
    public
      oStk:TStk;
      oIst:TIstFnc;
      ohTSH:TTshHnd;
      ohTSI:TTsiHnd;
      otTSI:TTsiTmp;
      ohTSN:TTsnHnd;
      procedure Open(pBokNum:Str5); overload; // Otvori vsetky databazove subory
      procedure Open(pBokNum:Str5;pTSH,pTSI,pTSN:boolean); overload;// Otvori zadane databazove subory

      procedure PrnDoc(pDocNum:Str12); // Vytlaèí zadany dodaci list
      procedure NewDoc(pYear:Str2;pPaCode:longint); overload; // Vygeneruje novu hlavicku dokladu
      procedure NewDoc(pYear:Str2;pPaCode:longint;pStkNum:word); overload; // Vygeneruje novu hlavicku dokladu
      procedure CnfDoc; // Potvrdenie dokladu nastavi priznak rezervacie DstLck=9 na 0
      procedure ClcDoc; overload; // Prepocita hlavicku aktualneho dokladu
      procedure ClcDoc(pDocNum:Str12); overload; // prepocita hlavicku zadaneho dokladu
      procedure ClcLst; // Prepocita hlavicky zakazkovych dokladov ktore su uvedene v zozname oDocClc
      procedure AddClc(pDocNum:Str12); // Prida doklad do zoznamu, hlavicky ktorych treba prepocitat

      procedure SubDoc(pDocNum:Str12); // Naskladni tovar zo zadaneho dodacieho istu
      procedure SlcItm(pDocNum:Str12); // Nacita polozky zadaneho dokladu do PX
      procedure AddItm(pDocNum:Str12;pGsCode:longint;pGsQnt,pFgCValue:double);overload; // Prida novu polozku na doklad
      procedure AddItm(pDocNum:Str12;pGsCode:longint;pGsQnt,pFgCValue:double;pAcqStat:Str1);overload; // Prida novu polozku na doklad
      procedure AddItm(pDocNum:Str12;pGsCode:longint;pGsQnt,pFgCValue,pFgBPrice:double);overload; // Prida novu polozku na doklad

      function SubItm(pDocNum:Str12;pItmNum:word):boolean;  // Vykona skladovu operaciu
      function UnsItm(pDocNum:Str12;pItmNum:word;pClc:boolean):boolean;  // Zrusi skladovu operaciu
      function DelItm(pDocNum:Str12;pItmNum:word):boolean;  // Zrusi zadanu polozku dodacieho listu
      procedure SetPaCode(pPaCode:longint);
    published
      property BokNum:Str5 read oBokNum;
      property Year:Str2 read oYear write oYear;
      property SerNum:longint read oSerNum write oSerNum;
      property DocNum:Str12 read oDocNum;
      property PaCode:longint write oPaCode;
      property DocDate:TDateTime write oDocDate;
      property Ind:TProgressBar read oInd write oInd;
  end;

implementation

uses bTSI, bTSH;

constructor TTsd.Create(AOwner: TComponent);
begin
  oFrmName:=AOwner.Name;
  oDocClc:=TStringList.Create;  oDocClc.Clear;
  oLst:=TList.Create;  oLst.Clear;
  oStk:=TStk.Create;
  oIst:=TIstFnc.Create;
  ohGSCAT:=TGscatHnd.Create;  ohGSCAT.Open;
  ohPAB:=TPabHnd.Create;  ohPAB.Open(0);
  otTSI:=TTsiTmp.Create;
end;

destructor TTsd.Destroy;
var I:word;
begin
  FreeAndNil(oIst);
  If oLst.Count>0 then begin
    For I:=1 to oLst.Count do begin
      Activate (I);
      FreeAndNil(ohTSN);
      FreeAndNil(ohTSI);
      FreeAndNil(ohTSH);
    end;
  end;
  FreeAndNil(oLst);
  FreeAndNil(oStk);
  FreeAndNil(otTSI);
  FreeAndNil(ohPAB);
  FreeAndNil(ohGSCAT);
  FreeAndNil(oDocClc);
end;

// ********************************* PRIVATE ***********************************

procedure TTsd.Activate(pIndex:word); // Aktivuje databazu, ktora je otvorena pod poradovym cislom pIndex
var mDat:PDat;
begin
  mDat:=oLst.Items[pIndex-1];
  ohTSH:=mDat.rhTSH;
  ohTSI:=mDat.rhTSI;
  ohTSN:=mDat.rhTSN;
end;

// ********************************** PUBLIC ***********************************

procedure TTsd.Open(pBokNum:Str5); // Otvori vsetky databazove subory
begin
  Open (pBokNum,TRUE,TRUE,TRUE);
end;

procedure TTsd.Open(pBokNum:Str5;pTSH,pTSI,pTSN:boolean); // Otvori zadane databazove subory
var mFind:boolean;  mCnt:word;  mDat:PDat;
begin
  oBokNum:=pBokNum;
  mFind:=FALSE;
  If oLst.Count>0 then begin
    mCnt:=0;
    Repeat
      Inc (mCnt);
      Activate(mCnt);
      mFind:=ohTSH.BtrTable.BookNum=pBokNum;
    until mFind or (mCnt=oLst.Count);
  end;
  If not mFind then begin // Ak dana kniha este nie je otvorena potomotvorime
    // Vytvorime objekty
    ohTSH:=TTshHnd.Create;
    ohTSI:=TTsiHnd.Create;
    ohTSN:=TTsnHnd.Create;
    // Otvorime databazove subory
    If pTSH then ohTSH.Open(pBokNum);
    If pTSI then ohTSI.Open(pBokNum);
    If pTSN then ohTSN.Open(pBokNum);
    // Ulozime objekty do zoznamu
    GetMem (mDat,SizeOf(TDat));
    mDat^.rhTSH:=ohTSH;
    mDat^.rhTSI:=ohTSI;
    mDat^.rhTSN:=ohTSN;
    oLst.Add(mDat);
  end;
end;

procedure TTsd.SlcItm(pDocNum:Str12); // Nacita polozky zadaneho dokladu do PX
begin
  If otTSI.Active then otTSI.Close;
  otTSI.Open;
  If ohTSI.LocateDocNum(pDocNum) then begin
    Repeat
      otTSI.Insert;
      BTR_To_PX (ohTSI.BtrTable,otTSI.TmpTable);
      otTSI.Post;
      Application.ProcessMessages;
      ohTSI.Next;
    until ohTSI.Eof or (ohTSI.DocNum<>pDocNum);
  end;
end;

procedure TTsd.PrnDoc(pDocNum:Str12); // Vytlaèí zadany dodaci list
var mJrn:TJrn;  mRep:TRep;  mtTSH:TTshTmp;  mhSYSTEM:TSystemHnd;  mBokNum:Str5;  mInfVal:double;
begin
  mBokNum:=BookNumFromDocNum(pDocNum);
  Open (mBokNum);
  If ohTSH.LocateDocNum(pDocNum) then begin
    mhSYSTEM:=TSystemHnd.Create;  mhSYSTEM.Open;
    mtTSH:=TTshTmp.Create;   mtTSH.Open;
    mtTSH.Insert;
    BTR_To_PX (ohTSH.BtrTable,mtTSH.TmpTable);
    mtTSH.Post;
    SlcItm(pDocNum);
    mJrn:=TJrn.Create;
    mJrn.DocAcc(pDocNum);
    // --------------------------
    mRep:=TRep.Create(Self);
    mRep.SysBtr:=mhSYSTEM.BtrTable;
    mRep.HedTmp:=mtTSH.TmpTable;
    mRep.SpcTmp:=mJrn.ptDOCACC.TmpTable;
    mRep.ItmTmp:=otTSI.TmpTable;
    mRep.Execute('TSD');
    FreeAndNil (mRep);
    // --------------------------
    FreeAndNil (mJrn);
    FreeAndNil (mtTSH);
    FreeAndNil (mhSYSTEM);
  end;
end;

procedure TTsd.NewDoc(pYear:Str2;pPaCode:longint); // Vygeneruje novu hlavicku dokladu
begin
  NewDoc(pYear,pPaCode,0);
end;

procedure TTsd.NewDoc(pYear:Str2;pPaCode:longint;pStkNum:word); // Vygeneruje novu hlavicku dokladu
begin
  oYear:=pYear;If oYear='' then oYear:=gvsys.ActYear2;
  If oSerNum=0 then oSerNum:=ohTSH.NextSerNum(oYear); // Ak nie je zadane poradove cislo OD vygenerujeme nasledujuce
  If oDocDate=0 then oDocDate:=Date; // Ak nie je zadany datum nastavime aktualny den
  oDocNum:=ohTSH.GenDocNum(oYear,oSerNum);
  If not ohTSH.LocateDocNum(oDocNum) then begin // Ak neexistuje vyvorime hlacicku dokladu OD
    ohTSH.Insert;
    ohTSH.DocNum:=oDocNum;
    ohTSH.SerNum:=oSerNum;
    ohTSH.Year:=oYear;
    If pStkNum<>0
      then ohTSH.StkNum:=pStkNum
      else ohTSH.StkNum:=gKey.TsbStkNum[BokNum];
    ohTSH.SmCode:=gKey.TsbSmCode[BokNum];
    ohTSH.DocDate:=oDocDate;
    If ohPAB.LocatePaCode(pPaCode) then BTR_To_BTR (ohPAB.BtrTable,ohTSH.BtrTable);
    ohTSH.WpaCode:=0;
    ohTSH.WpaName:=ohTSH.PaName;
    ohTSH.WpaAddr:=ohTSH.RegAddr;
    ohTSH.WpaSta:=ohTSH.RegSta;
    ohTSH.WpaCty:=ohTSH.RegCty;
    ohTSH.WpaCtn:=ohTSH.RegCtn;
    ohTSH.WpaZip:=ohTSH.RegZip;
    ohTSH.AcDvzName:=gKey.SysAccDvz;
    ohTSH.FgDvzName:=gKey.TsbDvName[BokNum];
    ohTSH.FgCourse:=1;
    ohTSH.DstLck:=9;
    ohTSH.VatDoc:=1;
    ohTSH.Post;
  end;
end;

procedure TTsd.CnfDoc; // Potvrdenie dokladu nastavi priznak rezervacie DstLck=9 na 0
begin
  If ohTSH.DstLck=9 then begin
    ohTSH.Edit;
    ohTSH.DstLck:=0;
    ohTSH.Post;
  end;
end;

procedure TTsd.AddItm(pDocNum:Str12;pGsCode:longint;pGsQnt,pFgCValue:double); // Prida novu polozku na doklad
var mItmNum:word;
begin
  If ohTSH.LocateDocNum(pDocNum) then begin
    If not ohGSCAT.Active then ohGSCAT.Open;
    If ohGSCAT.LocateGsCode(pGsCode) then begin
      mItmNum:=ohTSI.NextItmNum(pDocNum);
      ohTSI.Insert;
      ohTSI.DocNum:=pDocNum;
      ohTSI.ItmNum:=mItmNum;
      BTR_To_BTR(ohGSCAT.BtrTable,ohTSI.BtrTable);
      If ohTSH.VatDoc=0 then ohTSI.VatPrc:=0;
      If oIst.GetCctVat(ohTSH.PaCode,pGsCode) then begin // Kontrola na prenesenie daònovej povinnosti DPH
        ohTSI.CctVat:=1;
        ohTSI.VatPrc:=0;
      end;
      ohTSI.GsQnt:=pGsQnt;
      ohTSI.SetFgCValue(pFgCValue,ohTSH.FgCourse);
      ohTSI.StkNum:=ohTSH.StkNum;
      ohTSI.DocDate:=ohTSH.DocDate;
      ohTSI.PaCode:=ohTSH.PaCode;
      If gKey.TsbAcqGsc[BookNumFromDocNum(pDocNum)]
        then ohTSI.AcqStat:= 'K'
        else ohTSI.AcqStat:= 'R';
      ohTSI.StkStat:='N';
      ohTSI.Post;
    end
    else ShowMsg (eCom.GscIsNoExist,StrInt(pGsCode,0));
  end
  else ShowMsg(eCom.DocIsNoExist,pDocNum);
end;

procedure TTsd.AddItm(pDocNum:Str12;pGsCode:longint;pGsQnt,pFgCValue:double;pAcqStat:Str1); // Prida novu polozku na doklad
var mItmNum:word;
begin
  If ohTSH.LocateDocNum(pDocNum) then begin
    If not ohGSCAT.Active then ohGSCAT.Open;
    If ohGSCAT.LocateGsCode(pGsCode) then begin
      mItmNum:=ohTSI.NextItmNum(pDocNum);
      ohTSI.Insert;
      ohTSI.DocNum:=pDocNum;
      ohTSI.ItmNum:=mItmNum;
      BTR_To_BTR(ohGSCAT.BtrTable,ohTSI.BtrTable);
      If oIst.GetCctVat(ohTSH.PaCode,pGsCode) then begin // Kontrola na prenesenie daònovej povinnosti DPH
        ohTSI.CctVat:=1;
        ohTSI.VatPrc:=0;
      end;
      ohTSI.GsQnt:=pGsQnt;
      ohTSI.SetFgCValue(pFgCValue,ohTSH.FgCourse);
      ohTSI.StkNum:=ohTSH.StkNum;
      ohTSI.DocDate:=ohTSH.DocDate;
      ohTSI.PaCode:=ohTSH.PaCode;
      ohTSI.AcqStat:=pAcqStat;
      ohTSI.StkStat:='N';
      ohTSI.Post;
    end
    else ShowMsg (eCom.GscIsNoExist,StrInt(pGsCode,0));
  end
  else ShowMsg(eCom.DocIsNoExist,pDocNum);
end;

procedure TTsd.AddItm(pDocNum:Str12;pGsCode:longint;pGsQnt,pFgCValue,pFgBPrice:double); // Prida novu polozku na doklad
var mItmNum:word;
begin
  If ohTSH.LocateDocNum(pDocNum) then begin
    If not ohGSCAT.Active then ohGSCAT.Open;
    If ohGSCAT.LocateGsCode(pGsCode) then begin
      mItmNum:=ohTSI.NextItmNum(pDocNum);
      ohTSI.Insert;
      ohTSI.DocNum:=pDocNum;
      ohTSI.ItmNum:=mItmNum;
      BTR_To_BTR(ohGSCAT.BtrTable,ohTSI.BtrTable);
      If oIst.GetCctVat(ohTSH.PaCode,pGsCode) then begin // Kontrola na prenesenie daònovej povinnosti DPH
        ohTSI.CctVat:=1;
        ohTSI.VatPrc:=0;
      end;
      ohTSI.GsQnt:=pGsQnt;
      ohTSI.SetFgCValue(pFgCValue,ohTSH.FgCourse);
      ohTSI.StkNum:=ohTSH.StkNum;
      ohTSI.DocDate:=ohTSH.DocDate;
      ohTSI.PaCode:=ohTSH.PaCode;
      ohTSI.StkStat:='N';
      ohTSI.AcBValue:= ClcAcFromFgC(pFgBPrice*pGsQnt,1);
      ohTSI.AcAValue:= ClcAcFromFgC(pFgBPrice*pGsQnt/(1+ohTSI.VatPrc/100),1);
      ohTSI.Post;
    end
    else ShowMsg (eCom.GscIsNoExist,StrInt(pGsCode,0));
  end
  else ShowMsg(eCom.DocIsNoExist,pDocNum);
end;

procedure TTsd.SubDoc(pDocNum:Str12); // Naskladni tovar zo zadaneho dodacieho istu
begin
  If ohTSH.LocateDocNum(pDocNum) then begin
    If ohTSI.LocateDocNum(pDocNum) then begin
      If oInd<>nil then begin
        oInd.Max:=ohTSH.ItmQnt;
        oInd.Position:=0;
      end;
      Repeat
        If oInd<>nil then oInd.StepBy(1);
        If ohTSI.StkStat='N' then begin
          If ohTSI.StkNum>0 then oStk.StkNum:=ohTSI.StkNum else oStk.StkNum:=ohTSH.StkNum;
          oStk.Clear;
          oStk.SmSign:='+';  // Prijem tovaru
          oStk.DocNum:=ohTSI.DocNum;
          oStk.ItmNum:=ohTSI.ItmNum;
          oStk.DocDate:=ohTSI.DocDate;
          oStk.GsCode:=ohTSI.GsCode;
          oStk.MgCode:=ohTSI.MgCode;
          oStk.BarCode:=ohTSI.BarCode;
          oStk.AcqSta:=ohTSI.AcqStat;
          oStk.PaCode:=ohTSH.PaCode;
          oStk.SmCode:=ohTSH.SmCode;
          oStk.GsName:=ohTSI.GsName;
          oStk.GsQnt:=ohTSI.GsQnt;
          oStk.CValue:=ohTSI.AcCValue;
          oStk.CPrice:=ohTSI.AcCValue/ohTSI.GsQnt;
          If oStk.Sub(ohTSI.StkNum) then begin // Ak sa podarilo vydat polozky
            ohTSI.Edit;
            ohTSI.StkStat:='S';
            ohTSI.Post;
          end;
        end;
        Application.ProcessMessages;
        ohTSI.Next;
      until ohTSI.Eof or (ohTSI.DocNum<>pDocNum);
    end;
    ohTSH.Clc(ohTSI);
  end;
end;

procedure TTsd.ClcDoc;  // Prepocita hlavicku aktualneho dokladu
begin
  ClcDoc(ohTSH.DocNum);
end;

procedure TTsd.ClcDoc(pDocNum:Str12); // prepocita hlavicku zadaneho dokladu
begin
  If ohTSH.LocateDocNum(pDocNum) then ohTSH.Clc(ohTSI);
end;

procedure TTsd.AddClc(pDocNum: Str12);
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

procedure TTsd.ClcLst; // Prepocita hlavicky zakazkovych dokladov ktore su uvedene v zozname oDocClc
var I:word;
begin
  If oDocClc.Count>0 then begin  // Mame doklady na prepocitanie
    For I:=0 to oDocClc.Count-1 do begin
      Open(BookNumFromDocNum(oDocClc.Strings[I]));
      ClcDoc(oDocClc.Strings[I]);
    end
  end;
end;

function TTsd.SubItm(pDocNum:Str12;pItmNum:word):boolean;  // Zrusi skladovu operaciu (t.j. prijem tovar naspat vyda podla znaku mnozstva
begin
  Result:=FALSE;
  If ohTSI.LocateDoIt(pDocNum,pItmNum) then begin
    If ohTSI.StkStat='N' then begin
      oStk.Clear;
      oStk.SmSign:='+';  // Prijem tovaru
      oStk.DocNum:=ohTSI.DocNum;
      oStk.ItmNum:=ohTSI.ItmNum;
      oStk.DocDate:=ohTSI.DocDate;
      oStk.GsCode:=ohTSI.GsCode;
      oStk.MgCode:=ohTSI.MgCode;
      oStk.BarCode:=ohTSI.BarCode;
      oStk.AcqSta:=ohTSI.AcqStat;
      oStk.PaCode:=ohTSH.PaCode;
      oStk.SmCode:=ohTSH.SmCode;
      oStk.GsName:=ohTSI.GsName;
      oStk.GsQnt:=ohTSI.GsQnt;
      oStk.CValue:=ohTSI.AcCValue;
      oStk.CPrice:=ohTSI.AcCValue/ohTSI.GsQnt;
      If oStk.Sub(ohTSI.StkNum) then begin // Ak sa podarilo vydat polozky
        ohTSI.Edit;
        ohTSI.StkStat:='S';
        ohTSI.Post;
        Result:=TRUE;
      end;
    end;
  end;
end;

function TTsd.UnsItm(pDocNum:Str12;pItmNum:word;pClc:boolean):boolean;  // Zrusi skladovu operaciu (t.j. prijem tovar naspat vyda podla znaku mnozstva
begin
  Result:=TRUE;
  If ohTSH.LocateDocNum(pDocNum) then begin
    If ohTSI.LocateDoIt(pDocNum,pItmNum) then begin
      If ohTSI.StkStat='S' then begin
        If oStk.Uns(ohTSI.StkNum,ohTSI.DocNum,ohTSI.ItmNum) then begin
          ohTSI.Edit;
          ohTSI.StkStat:='N';
          ohTSI.Post;
        end
        else Result:=FALSE;
      end;
    end;
    If pClc then ohTSH.Clc(ohTSI);
  end;
end;

function TTsd.DelItm(pDocNum:Str12;pItmNum:word):boolean;  // Zrusi zadanu polozku dodacieho listu
begin
  Result:=TRUE;
  If ohTSH.LocateDocNum(pDocNum) then begin
    If UnsItm(pDocNum,pItmNum,False) then begin
      If ohTSI.StkStat='N'
        then ohTSI.Delete
        else Result:=FALSE;
    end;
    ohTSH.Clc(ohTSI);
  end;
end;

procedure TTsd.SetPaCode(pPaCode: Integer);
begin
  If ohPAB.LocatePaCode(pPaCode) then
  begin
    ohTSH.Edit;
    BTR_To_BTR (ohPAB.BtrTable,ohTSH.BtrTable);
    ohTSH.WpaCode:=0;
    ohTSH.WpaName:=ohTSH.PaName;
    ohTSH.WpaAddr:=ohTSH.RegAddr;
    ohTSH.WpaSta:=ohTSH.RegSta;
    ohTSH.WpaCty:=ohTSH.RegCty;
    ohTSH.WpaCtn:=ohTSH.RegCtn;
    ohTSH.WpaZip:=ohTSH.RegZip;
    ohTSH.Post;
  end;
end;

end.
{MOD 1807008}
{MOD 1905002}
