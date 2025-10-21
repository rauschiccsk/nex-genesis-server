unit Cdd;
{$F+}

// *****************************************************************************
//                               VYROBNE DOKLADY
// *****************************************************************************
//
// Programové funkcia:
// ---------------
// *****************************************************************************


interface

uses
  IcTypes, IcConst, IcConv, IcTools, IcVariab, DocHand,
  NexGlob, NexPath, NexIni, NexMsg, NexError,
  SavClc, LinLst, Bok, Rep, Key, Afc, Doc, Cpd,
  hSYSTEM, hCDH, hCDI, hCDM, hCDN, tCDI,
  ComCtrls, SysUtils, Classes, Forms;

type
  PDat=^TDat;
  TDat=record
    rhCDH:TCdhHnd;
    rhCDI:TCdiHnd;
    rhCDM:TCdmHnd;
    rhCDN:TCdnHnd;
  end;

  TCdd = class(TComponent)
    constructor Create(AOwner: TComponent);
    destructor  Destroy; override;
    private
      oBokNum:Str5;
      oFrmName:Str15;
      oLst:TList;
      procedure Activate(pIndex:word); // Aktivuje databazu, ktora je otvorena pod poradovym cislom pIndex
    public
      oCpd:TCpd;
      ohCDH:TCdhHnd;
      ohCDI:TCdiHnd;
      ohCDM:TCdmHnd;
      ohCDN:TCdnHnd;
      otCDI:TCdiTmp;
      procedure Open(pBokNum:Str5); overload; // Otvori vsetky databazove subory
      procedure Open(pBokNum:Str5;pCDH,pCDI,pCDM,pCDN:boolean); overload;// Otvori zadane databazove subory
      procedure PrnDoc(pDocNum:Str12); // Vytlaèí zadany dodaci list
      procedure NewDoc(pYear:Str2;pSerNum:word;pPaCode:longint;pPaName:Str30;pDocDate:TDateTime); // Vygeneruje novu hlavicku dokladu
      procedure ClcDoc; overload; // prepocita hlavicku aktualneho dokladu
      procedure ClcDoc(pDocNum:Str12); overload; // prepocita hlavicku zadaneho dokladu
      procedure TmpRef(pDocNum:Str12;pItmNum:word); // Obnovy zaznam na zaklade BTR
      procedure SlcItm(pDocNum:Str12); // Nacita polozky zadaneho dokladu do PX
      procedure AddItm(pDocNum:Str12;pGsCode:longint;pGsQnt:double); // Prida vyrobok na zadany doklad a nahra do dokladu jeho komponenty
    published
      property BokNum:Str5 read oBokNum;
  end;

implementation

uses bCDH, bCPH, bCPI;

constructor TCdd.Create(AOwner: TComponent);
begin
  oFrmName := AOwner.Name;
  oLst := TList.Create;  oLst.Clear;
  oCpd := TCpd.Create(Self);
  otCDI := TCdiTmp.Create;
end;

destructor TCdd.Destroy;
var I:word;
begin
  If oLst.Count>0 then begin
    For I:=1 to oLst.Count do begin
      Activate (I);
      FreeAndNil (ohCDN);
      FreeAndNil (ohCDM);
      FreeAndNil (ohCDI);
      FreeAndNil (ohCDH);
    end;
  end;
  FreeAndNil (oCpd);
  FreeAndNil (oLst);
  FreeAndNil (otCDI);
end;

// ********************************* PRIVATE ***********************************

procedure TCdd.Activate(pIndex:word); // Aktivuje databazu, ktora je otvorena pod poradovym cislom pIndex
var mDat:PDat;
begin
  mDat := oLst.Items[pIndex-1];
  ohCDH := mDat.rhCDH;
  ohCDI := mDat.rhCDI;
  ohCDM := mDat.rhCDM;
  ohCDN := mDat.rhCDN;
end;

// ********************************** PUBLIC ***********************************

procedure TCdd.Open(pBokNum:Str5); // Otvori vsetky databazove subory
begin
  Open (pBokNum,TRUE,TRUE,TRUE,TRUE);
end;

procedure TCdd.Open(pBokNum:Str5;pCDH,pCDI,pCDM,pCDN:boolean); // Otvori zadane databazove subory
var mFind:boolean;  mCnt:word;  mDat:PDat;
begin
  oBokNum := pBokNum;
  mFind := FALSE;
  If oLst.Count>0 then begin
    mCnt := 0;
    Repeat
      Inc (mCnt);
      Activate(mCnt);
      mFind := ohCDH.BtrTable.BookNum=pBokNum;
    until mFind or (mCnt=oLst.Count);
  end;
  If not mFind then begin // Ak dana kniha este nie je otvorena potomotvorime
    // Vytvorime objekty
    ohCDH := TCdhHnd.Create;
    ohCDI := TCdiHnd.Create;
    ohCDM := TCdmHnd.Create;
    ohCDN := TCdnHnd.Create;
    // Otvorime databazove subory
    If pCDH then ohCDH.Open(pBokNum);
    If pCDI then ohCDI.Open(pBokNum);
    If pCDM then ohCDM.Open(pBokNum);
    If pCDN then ohCDN.Open(pBokNum);
    // Ulozime objekty do zoznamu
    GetMem (mDat,SizeOf(TDat));
    mDat^.rhCDH := ohCDH;
    mDat^.rhCDI := ohCDI;
    mDat^.rhCDM := ohCDM;
    mDat^.rhCDN := ohCDN;
    oLst.Add(mDat);
  end;
//  oCpd.Open(gKey.);
  oCpd.Open('00001');
end;

procedure TCdd.SlcItm(pDocNum:Str12); // nacita polozky zadaneho dokladu do PX
begin
  If otCDI.Active then otCDI.Close;
  otCDI.Open;
  If ohCDI.LocateDocNum(pDocNum) then begin
    Repeat
      otCDI.Insert;
      BTR_To_PX (ohCDI.BtrTable,otCDI.TmpTable);
      otCDI.Post;
      Application.ProcessMessages;
      ohCDI.Next;
    until ohCDI.Eof or (ohCDI.DocNum<>pDocNum);
  end;
end;

procedure TCdd.AddItm(pDocNum:Str12;pGsCode:longint;pGsQnt:double); // Prida vyrobok na zadany doklad a nahra do dokladu jeho komponenty
var mItmNum:word;
begin
  With oCpd do begin
    If ohCPH.LocatePdCode(pGsCode) then begin
      // Ulozime vyrobok do dokladu
      mItmNum := NextItmNum(ohCDI.BtrTable,pDocNum);
      ohCDI.Insert;
      BTR_To_BTR (ohCPH.BtrTable,ohCDI.BtrTable);
      ohCDI.DocNum := ohCDH.DocNum;
      ohCDI.ItmNum := mItmNum;
      ohCDI.GsCode := ohCPH.PdCode;
      ohCDI.GsName := ohCPH.PdName;
      ohCDI.GsQnt := pGsQnt;
      ohCDI.StkNum := ohCDH.StkNum;
      ohCDI.DocDate := ohCDH.DocDate;
      ohCDI.StkStat := 'N';
      ohCDI.Post;
      // Ulozime komponenty daneho vyrobku do vyrobneho dokladu
      If ohCPI.LocatePdCode(pGsCode) then begin
        Repeat
          ohCDM.Insert;
          BTR_To_BTR (ohCPI.BtrTable,ohCDM.BtrTable);
          ohCDM.DocNum := ohCDH.DocNum;
          ohCDM.ItmNum := mItmNum;
          ohCDM.GsCode := ohCPI.CpCode;
          ohCDM.GsName := ohCPI.CpName;
          ohCDM.PdQnt := pGsQnt;
          ohCDM.MaQnt := ohCPI.CpGsQnt/ohCPH.PdGsQnt;
          ohCDM.GsQnt := ohCDM.PdQnt*ohCDM.MaQnt;
          ohCDM.StkNum := ohCDH.CpStkNum;
          ohCDM.DocDate := ohCDH.DocDate;
          ohCDM.StkStat := 'N';
          ohCDM.Post;
          Application.ProcessMessages;
          ohCPI.Next;
        until ohCPI.Eof or (ohCPI.PdCode<>pGsCode);
      end;
    end;
  end;
end;

procedure TCdd.PrnDoc(pDocNum:Str12); // Vytlaèí zadany dodaci list
var mRep:TRep;  mhSYSTEM:TSystemHnd;  mBokNum:Str5;
begin
  mBokNum := BookNumFromDocNum(pDocNum);
  gAfc.GrpNum := gvSys.LoginGroup;
  gAfc.BookNum := mBokNum;
//  If gAfc.AmbDocPrn then begin
    Open(mBokNum,TRUE,TRUE,FALSE,FALSE);
    If ohCDH.LocateDocNum(pDocNum) then begin
      mhSYSTEM := TSystemHnd.Create;  mhSYSTEM.Open;
      SlcItm(pDocNum);
      // --------------------------
      mRep := TRep.Create(Self);
      mRep.SysBtr := mhSYSTEM.BtrTable;
      mRep.HedBtr := ohCDH.BtrTable;
      mRep.ItmTmp := otCDI.TmpTable;
      mRep.Execute('CDD');
      FreeAndNil (mRep);
      // --------------------------
      FreeAndNil (mhSYSTEM);
    end;
//  end
//  else ShowMsg(eCom.ThisFncIsDis,'');
end;

procedure TCdd.NewDoc(pYear:Str2;pSerNum:word;pPaCode:longint;pPaName:Str30;pDocDate:TDateTime); // Vygeneruje novu hlavicku dokladu
var mSerNum:word;  mDocNum:Str12;  mDocDate:TDateTime;  
begin
  If pYear='' then pYear:=gvSys.ActYear2;
  mSerNum := pSerNum;
  mDocDate := pDocDate;
  If mSerNum=0 then mSerNum := NextSerNum(pYear,ohCDH.BtrTable); // Ak nie je zadane poradove cislo OD vygenerujeme nasledujuce
  If mDocDate=0 then mDocDate := Date; // Ak nie je zadany datum nastavime aktualny den
  mDocNum := ohCDH.GenDocNum(pYear,mSerNum);
  If not ohCDH.LocateDocNum(mDocNum) then begin // Ak neexistuje vyvorime hlacicku dokladu OD
    ohCDH.Insert;
    ohCDH.DocNum := mDocNum;
    ohCDH.Year := pYear;
    ohCDH.SerNum := mSerNum;
    ohCDH.DocDate := mDocDate;
    ohCDH.PaCode := pPaCode;
    ohCDH.PaName := pPaName;
    ohCDH.StkNum := gKey.CdbStkNuI[oBokNum];
    ohCDH.CpStkNum := gKey.CdbStkNuO[oBokNum];
    ohCDH.PdSmCode := gKey.CdbSmCodI[oBokNum];
    ohCDH.CpSmCode := gKey.CdbSmCodO[oBokNum];
    ohCDH.Post;
  end;
end;

procedure TCdd.ClcDoc; // prepocita hlavicku zadaneho dokladu
begin
  ohCDH.Clc(ohCDI);
end;

procedure TCdd.ClcDoc(pDocNum:Str12); // Prepocita hlavicku zadaneho dokladu
var mBokNum:Str5;
begin
  mBokNum := BookNumFromDocNum(pDocNum);
  Open (mBokNum,TRUE,TRUE,FALSE,FALSE);
  If ohCDH.LocateDocNum(pDocNum) then ohCDH.Clc(ohCDI);
end;

procedure TCdd.TmpRef(pDocNum:Str12;pItmNum:word); // Obnovy zaznam na zaklade BTR
begin
  If ohCDI.LocateDoIt(pDocNum,pItmNum) then begin
    otCDI.Insert;
    BTR_To_PX (ohCDI.BtrTable,otCDI.TmpTable);
    otCDI.Post;
  end;
end;

end.


