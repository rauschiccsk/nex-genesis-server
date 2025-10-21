unit Scd;
{$F+}

// *****************************************************************************
//                          ZAKAZKY PRENAJMU TOVARU
// *****************************************************************************
//
// Programové funkcia:
// ---------------
// *****************************************************************************


interface

uses
  IcTypes, IcConst, IcConv, IcTools, IcVariab, DocHand, TxtWrap, NexGlob, NexPath, NexIni,
  NexMsg, NexError, ItgLog, SavClc, LinLst, Bok, Rep, Key, Afc, Doc, StkGlob,
  hSYSTEM, hGSCAT, hPAB, hSCH, hSCI, tSCH, tSCI, hSCN, tNOT,
  ComCtrls, SysUtils, Classes, Forms;

type
  PDat=^TDat;
  TDat=record
    rhSCH:TSchHnd;
    rhSCI:TSciHnd;
    rhSCN:TScnHnd;
  end;

  TScd = class(TComponent)
    constructor Create(AOwner: TComponent);
    destructor  Destroy; override;
    private
      oBokNum:Str5;
      oFrmName:Str15;
      oLst:TList;
      ohGSCAT:TGscatHnd;
      procedure Activate(pIndex:word); // Aktivuje databazu, ktora je otvorena pod poradovym cislom pIndex
    public
      ohSCH:TSchHnd;
      ohSCI:TSciHnd;
      otSCI:TSciTmp;
      ohSCN:TScnHnd;
      procedure Open(pBokNum:Str5); overload; // Otvori vsetky databazove subory
      procedure Open(pPath:ShortString;pBokNum:Str5); overload; // Otvori vsetky databazove subory
      procedure Open(pBokNum:Str5;pSCH,pSCI,pSCN:boolean); overload;// Otvori zadane databazove subory
      procedure Open(pPath:ShortString;pBokNum:Str5;pSCH,pSCI,pSCN:boolean); overload; // Otvori vsetky databazove subory
      procedure PrnDoc(pDocNum,pRepName:Str12); // Vytlaèí zadany doklad
      procedure ResDoc(pYear:Str2;pSerNum:longint); // Zarezervuje zdoklad so zadanym poradovym cislom
      procedure ResVer; // Prekontroluje ci doklad je rezervovany ak ano zrusi ho
      procedure NewDoc(pYear:Str2;pSerNum:word;pPaCode:longint;pDocDate:TDateTime); // Vygeneruje novu hlavicku dokladu
      procedure ClcDoc(pDocNum:Str12); // prepocita hlavicku zadaneho dokladu
      procedure CnfDoc; // Potvrdenie dokladu nastavi priznak rezervacie DstLck=9 na 0
      procedure TmpRef(pDocNum:Str12;pItmNum:longint); // Obnovy zaznam na zaklade BTR
      procedure AddItm(pDocNum:Str12;pGsCode:longint;pGsQnt,pDscPrc,pAgBValue,pAsBValue:double;pAodNum:Str12;pAodItm:word); // Prida novu polozku na zadanu fakturu
      procedure AddHis(pTxt:Str250); // Pre aktualny doklad ulozi zadany text do historii vykonanych operacii
      procedure SlcItm; overload; // Nacita polozky aktualneho dokladu dokladu do PX
      procedure SlcItm(pDocNum:Str12); overload; // Nacita polozky zadaneho dokladu do PX
      procedure CadGen(pDocNum:Str12); // Vygeneruje elektronicky doklad pre pokladniènú úètenku
    published
      property BokNum:Str5 read oBokNum;
  end;

implementation

constructor TScd.Create(AOwner: TComponent);
begin
  oFrmName := AOwner.Name;
  oLst := TList.Create;  oLst.Clear;
  ohGSCAT := TGscatHnd.Create;
  otSCI := TSciTmp.Create;
end;

destructor TScd.Destroy;
var I:word;
begin
  If oLst.Count>0 then begin
    For I:=1 to oLst.Count do begin
      Activate (I);
      FreeAndNil (ohSCN);
      FreeAndNil (ohSCI);
      FreeAndNil (ohSCH);
    end;
  end;
  FreeAndNil (oLst);
  FreeAndNil (otSCI);
  FreeAndNil (ohGSCAT);
end;

// ********************************* PRIVATE ***********************************

procedure TScd.Activate(pIndex:word); // Aktivuje databazu, ktora je otvorena pod poradovym cislom pIndex
var mDat:PDat;
begin
  mDat := oLst.Items[pIndex-1];
  ohSCH := mDat.rhSCH;
  ohSCI := mDat.rhSCI;
  ohSCN := mDat.rhSCN;
end;

// ********************************** PUBLIC ***********************************

procedure TScd.Open(pBokNum:Str5); // Otvori vsetky databazove subory
begin
  Open ('',pBokNum,TRUE,TRUE,TRUE);
end;

procedure TScd.Open(pPath:ShortString;pBokNum:Str5); // Otvori vsetky databazove subory
begin
  Open (pPath,pBokNum,TRUE,TRUE,TRUE);
end;

procedure TScd.Open(pBokNum:Str5;pSCH,pSCI,pSCN:boolean); // Otvori zadane databazove subory
begin
  Open('',pBokNum,pSCH,pSCI,pSCN); // Otvori vsetky databazove subory
end;

procedure TScd.Open(pPath:ShortString;pBokNum:Str5;pSCH,pSCI,pSCN:boolean); // Otvori vsetky databazove subory
var mFind:boolean;  mCnt:word;  mDat:PDat;
begin
  oBokNum := pBokNum;
  mFind := FALSE;
  If oLst.Count>0 then begin
    mCnt := 0;
    Repeat
      Inc (mCnt);
      Activate(mCnt);
      mFind := ohSCH.BtrTable.BookNum=pBokNum;
    until mFind or (mCnt=oLst.Count);
  end;
  If not mFind then begin // Ak dana kniha este nie je otvorena potomotvorime
    // Vytvorime objekty
    If pPath='' then begin
      ohSCH := TSchHnd.Create;
      ohSCI := TSciHnd.Create;
      ohSCN := TScnHnd.Create;
    end
    else begin
      ohSCH := TSchHnd.Create(pPath);
      ohSCI := TSciHnd.Create(pPath);
      ohSCN := TScnHnd.Create(pPath);
    end;
    // Otvorime databazove subory
    If pSCH then ohSCH.Open(pBokNum);
    If pSCI then ohSCI.Open(pBokNum);
    If pSCN then ohSCN.Open(pBokNum);
    // Ulozime objekty do zoznamu
    GetMem (mDat,SizeOf(TDat));
    mDat^.rhSCH := ohSCH;
    mDat^.rhSCI := ohSCI;
    mDat^.rhSCN := ohSCN;
    oLst.Add(mDat);
  end;
end;

procedure TScd.AddItm(pDocNum:Str12;pGsCode:longint;pGsQnt,pDscPrc,pAgBValue,pAsBValue:double;pAodNum:Str12;pAodItm:word); // Prida novu polozku na zadanu fakturu
begin
end;

procedure TScd.AddHis(pTxt:Str250); // Pre aktualny doklad ulozi zadany text do historii vykonanych operacii
var mLinNum:byte;
begin
  mLinNum := 0;
  If ohSCN.LocateDocNum(ohSCH.DocNum) then begin  // Najde me posledny riadok
    Repeat
      If ohSCN.NotType='H' then begin
        If mLinNum<ohSCN.LinNum then mLinNum := ohSCN.LinNum;
      end;
      ohSCN.Next;
    until ohSCN.Eof or (ohSCN.DocNum<>ohSCH.DocNum);
  end;
  // Pridame novy riadok
  ohSCN.Insert;
  ohSCN.NotType := 'H';
  ohSCN.DocNum := ohSCH.DocNum;
  ohSCN.LinNum := mLinNum;
  ohSCN.Notice := pTxt;
  ohSCN.Post;
end;

procedure TScd.SlcItm; // nacita polozky zadaneho dokladu do PX
begin
  If otSCI.Active then otSCI.Close;
  otSCI.Open;
  If ohSCI.LocateDocNum(ohSCH.DocNum) then begin
    Repeat
      otSCI.Insert;
      BTR_To_PX (ohSCI.BtrTable,otSCI.TmpTable);
      otSCI.Post;
      Application.ProcessMessages;
      ohSCI.Next;
    until ohSCI.Eof or (ohSCI.DocNum<>ohSCH.DocNum);
  end;
end;

procedure TScd.SlcItm(pDocNum:Str12); // nacita polozky zadaneho dokladu do PX
begin
  If ohSCH.LocateDocNum(pDocNum) then SlcItm;
end;

procedure TScd.CadGen(pDocNum:Str12); // Vygeneruje elektronicky doklad pre pokladniènú úètenku
var mFile:TStrings;  mWrap:TTxtWrap;
begin
  If ohSCI.LocateDocNum(pDocNum) then begin
    mFile := TStringList.Create;
    mWrap := TTxtWrap.Create;
    Repeat
      If otSCI.GrtType='-' then begin
        mWrap.ClearWrap;
        mWrap.SetText (ohSCI.BarCode,0);
        mWrap.SetText (ohSCI.GsName,0);
        mWrap.SetReal (ohSCI.GsQnt,0,3);
        mWrap.SetReal (ohSCI.FgBPrice,0,2);
        mFile.Add (mWrap.GetWrapText);
      end;
      Application.ProcessMessages;
      ohSCI.Next;
    until ohSCI.Eof or (ohSCI.DocNum<>pDocNum);
    If not DirectoryExists (gPath.IndPath) then ForceDirectories (gPath.IndPath);
    If mFile.Count>0 then mFile.SaveToFile(gPath.IndPath+'UD-'+pDocNum+'_'+ohSCH.PaName+'.TXT');
    FreeAndNil (mFile);
  end;
end;

procedure TScd.PrnDoc(pDocNum,pRepName:Str12); // Vytlaèí zadany doklad
var mBokNum:Str5;  mRep:TRep;  mtSCH:TSchTmp;  mhSYSTEM:TSystemHnd;  mtNOT:TNotTmp;
begin
  mBokNum := BookNumFromDocNum(pDocNum);
  gAfc.GrpNum := gvSys.LoginGroup;
  gAfc.BookNum := mBokNum;
  If gAfc.Scb.DocPrn then begin
    Open (mBokNum,TRUE,TRUE,TRUE);
    If ohSCH.LocateDocNum(pDocNum) then begin
      mhSYSTEM := TSystemHnd.Create;  mhSYSTEM.Open;
      mtNOT := TNotTmp.Create;  mtNOT.Open;
      Notice(ohSCN.BtrTable,mtNOT.TmpTable,pDocNum,'A'); // Prijaté príslušenstvá
      Notice(ohSCN.BtrTable,mtNOT.TmpTable,pDocNum,'S'); // Stav zariadenia
      Notice(ohSCN.BtrTable,mtNOT.TmpTable,pDocNum,'C'); // Zákazník uvádza
      Notice(ohSCN.BtrTable,mtNOT.TmpTable,pDocNum,'T'); // Vyjadrenie technika
      Notice(ohSCN.BtrTable,mtNOT.TmpTable,pDocNum,'P'); // Návrh riešenia
      Notice(ohSCN.BtrTable,mtNOT.TmpTable,pDocNum,'R'); // Odporúèanie
      Notice(ohSCN.BtrTable,mtNOT.TmpTable,pDocNum,'I'); // Interne poznámky
      mtSCH := TSchTmp.Create;  mtSCH.Open;
      mtSCH.Insert;
      BTR_To_PX (ohSCH.BtrTable,mtSCH.TmpTable);
      mtSCH.FgEndVal := mtSCH.FgAftVal-mtSCH.FgAdvVal;
      If ohSCH.GrtType='Z' then mtSCH.GrtStat := 'X';
      If ohSCH.GrtType='-' then mtSCH.NgrStat := 'X';
      If ohSCH.CusClm=1 then mtSCH.ClmStat := 'X';
      If ohSCH.RetPart=1 then mtSCH.RetStat := 'X';
      mtSCH.DlrName   := GetDlrName(ohSCH.DlrCode);
      mtSCH.Post;
      SlcItm(pDocNum);
      otSCI.LocateItItm('',0);
      otSCI.First;
      // --------------------------
      mRep := TRep.Create(Self);
      mRep.SysBtr := mhSYSTEM.BtrTable;
      mRep.HedTmp := mtSCH.TmpTable;
      mRep.ItmTmp := otSCI.TmpTable;
      mRep.SpcTmp := mtNOT.TmpTable;
      mRep.Execute(pRepName);
      If mRep.Printed then begin
        ohSCH.Edit;
        ohSCH.PrnCnt := ohSCH.PrnCnt+1;
        ohSCH.Post;
      end;
      FreeAndNil (mRep);
      // --------------------------
      FreeAndNil (mtSCH);
      FreeAndNil (mtNOT);
      FreeAndNil (mhSYSTEM);
    end;
  end
  else ShowMsg(eCom.ThisFncIsDis,'');
end;

procedure TScd.ResDoc(pYear:Str2;pSerNum:longint); // Zarezervuje zdoklad so zadanym poradovym cislom
begin
  If pYear='' then pYear:=gvSys.ActYear2;
  If not ohSCH.LocateYearSerNum(pYear,pSerNum) then ohSCH.Res(pYear,pSerNum);
end;

procedure TScd.ResVer; // Prekontroluje ci doklad je rezervovany ak ano zrusi ho
begin
  If ohSCH.DstLck=9 then begin
    ohSCN.Del(ohSCH.DocNum);
    ohSCH.Delete;
  end;
end;

procedure TScd.NewDoc(pYear:Str2;pSerNum:word;pPaCode:longint;pDocDate:TDateTime); // Vygeneruje novu hlavicku dokladu
var mSerNum:word;  mDocNum:Str12;  mDocDate:TDateTime;  mhPAB:TPabHnd;
begin
  If pYear='' then pYear:=gvSys.ActYear2;
  mSerNum := pSerNum;
  mDocDate := pDocDate;
  If mSerNum=0 then mSerNum := ohSCH.NextSerNum(pYear); // Ak nie je zadane poradove cislo OD vygenerujeme nasledujuce
  If mDocDate=0 then mDocDate := Date; // Ak nie je zadany datum nastavime aktualny den
  mDocNum := ohSCH.GenDocNum(pYear,mSerNum);
  If not ohSCH.LocateDocNum(mDocNum) then begin // Ak neexistuje vyvorime hlacicku dokladu OD
    ohSCH.Insert;
    ohSCH.DocNum := mDocNum;
    ohSCH.SerNum := mSerNum;
    ohSCH.DocDate := mDocDate;
    ohSCH.DstLck := 9;
    If (pPaCode>0) then begin
      mhPAB := TPabHnd.Create;  mhPAB.Open(0);
      If mhPAB.LocatePaCode(pPaCode) then BTR_To_BTR (mhPAB.BtrTable,ohSCH.BtrTable);
      FreeAndNil (mhPAB);
    end;
    ohSCH.Post;
  end;
end;

procedure TScd.ClcDoc(pDocNum:Str12); // prepocita hlavicku zadaneho dokladu
var mBokNum:Str5;
begin
  mBokNum := BookNumFromDocNum(pDocNum);
  Open (mBokNum,TRUE,TRUE,FALSE);
  If ohSCH.LocateDocNum(pDocNum) then ohSCH.Clc(ohSCI);
end;

procedure TScd.CnfDoc; // potvrdenie dokladu nastavi priznak rezervacie DstLck=9 na 0
begin
  If ohSCH.DstLck=9 then begin
    ohSCH.Edit;
    ohSCH.DstLck := 0;
    ohSCH.Post;
  end;
end;

procedure TScd.TmpRef(pDocNum:Str12;pItmNum:longint); // Obnovy zaznam na zaklade BTR
begin
  If ohSCI.LocateDoIt(pDocNum,pItmNum) then begin
    If otSCI.LocateDoIt(ohSCI.DocNum,ohSCI.ItmNum)
      then otSCI.Edit
      else otSCI.Insert;
    BTR_To_PX (ohSCI.BtrTable,otSCI.TmpTable);
    otSCI.Post;
  end;
end;

end.

{MOD 1904012}

