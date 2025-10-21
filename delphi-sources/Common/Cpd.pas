unit Cpd;
{$F+}

// *****************************************************************************
//                        DOKLADY KALKULACII VYROBKOV
// *****************************************************************************
//
// Programové funkcia:
// ---------------
// *****************************************************************************


interface

uses
  IcTypes, IcConst, IcConv, IcTools, IcVariab, DocHand,
  NexGlob, NexPath, NexIni, NexMsg, NexError,
  SavClc, LinLst, Bok, Rep, Key, Afc,
  hSYSTEM, hCPH, hCPI, tCPI, tCPH,
  ComCtrls, SysUtils, Classes, Forms;

type
  PDat=^TDat;
  TDat=record
    rhCPH:TCphHnd;
    rhCPI:TCpiHnd;
  end;

  TCpd = class(TComponent)
    constructor Create(AOwner: TComponent);
    destructor  Destroy; override;
    private
      oBokNum:Str5;
      oFrmName:Str15;
      oCpiVal:double; // Hodnota komponetov
      oCpsVal:double; // Hodnota rezijnych poloziek
      oLst:TList;
      procedure Activate(pIndex:word); // Aktivuje databazu, ktora je otvorena pod poradovym cislom pIndex
    public
      ohCPH:TCphHnd;
      ohCPI:TCpiHnd;
      otCPI:TCpiTmp;
      otCPH:TCphTmp;
      procedure Open(pBokNum:Str5); overload; // Otvori vsetky databazove subory
      procedure Open(pBokNum:Str5;pCPH,pCPI:boolean); overload;// Otvori zadane databazove subory
      procedure PrnDoc(pBokNum:Str5;pPdCode:longint); // Vytlaèí zadany dodaci list
      procedure NewDoc(pSerNum:word;pPaCode:longint;pDocDate:TDateTime); // Vygeneruje novu hlavicku dokladu
      procedure ClcDoc; overload; // prepocita hlavicku zadaneho dokladu
      procedure ClcDoc(pPdCode:longint); overload; // prepocita hlavicku zadaneho dokladu
      procedure TmpRef(pPdCode,pCpCode:longint); // Obnovy zaznam na zaklade BTR
      procedure SlcItm(pPdCode:longint); // Nacita polozky zadaneho dokladu do PX
      procedure SlcPd(pCpCode:longint); // Nacita vyrobky so zadanym komponentom do PX
    published
      property BokNum:Str5 read oBokNum;
      property CpiVal:double read oCpiVal;
      property CpsVal:double read oCpsVal;
  end;

implementation

constructor TCpd.Create(AOwner: TComponent);
begin
  oFrmName := AOwner.Name;
  oLst := TList.Create;  oLst.Clear;
  otCPI := TCpiTmp.Create;
  otCPH := TCphTmp.Create;
end;

destructor TCpd.Destroy;
var I:word;
begin
  If oLst.Count>0 then begin
    For I:=1 to oLst.Count do begin
      Activate (I);
      FreeAndNil (ohCPI);
      FreeAndNil (ohCPH);
    end;
  end;
  FreeAndNil (oLst);
  otCPI.Close; FreeAndNil (otCPI);
  otCPH.Close; FreeAndNil (otCPH);
end;

// ********************************* PRIVATE ***********************************

procedure TCpd.Activate(pIndex:word); // Aktivuje databazu, ktora je otvorena pod poradovym cislom pIndex
var mDat:PDat;
begin
  mDat := oLst.Items[pIndex-1];
  ohCPH := mDat.rhCPH;
  ohCPI := mDat.rhCPI;
end;

// ********************************** PUBLIC ***********************************

procedure TCpd.Open(pBokNum:Str5); // Otvori vsetky databazove subory
begin
  Open (pBokNum,TRUE,TRUE);
end;

procedure TCpd.Open(pBokNum:Str5;pCPH,pCPI:boolean); // Otvori zadane databazove subory
var mFind:boolean;  mCnt:word;  mDat:PDat;
begin
  oBokNum := pBokNum;
  mFind := FALSE;
  If oLst.Count>0 then begin
    mCnt := 0;
    Repeat
      Inc (mCnt);
      Activate(mCnt);
      mFind := ohCPH.BtrTable.BookNum=pBokNum;
    until mFind or (mCnt=oLst.Count);
  end;
  If not mFind then begin // Ak dana kniha este nie je otvorena potomotvorime
    // Vytvorime objekty
    ohCPH := TCphHnd.Create;
    ohCPI := TCpiHnd.Create;
    // Otvorime databazove subory
    If pCPH then ohCPH.Open(pBokNum);
    If pCPI then ohCPI.Open(pBokNum);
    // Ulozime objekty do zoznamu
    GetMem (mDat,SizeOf(TDat));
    mDat^.rhCPH := ohCPH;
    mDat^.rhCPI := ohCPI;
    oLst.Add(mDat);
  end;
end;

procedure TCpd.SlcItm(pPdCode:longint); // nacita polozky zadaneho dokladu do PX
var mSecMgc:longint;
begin
  oCpiVal := 0;  oCpsVal := 0;
  mSecMgc := gIni.ServiceMg;
  If otCPI.Active then otCPI.Close;
  otCPI.Open;
  If ohCPI.LocatePdCode(pPdCode) then begin
    Repeat
      otCPI.Insert;
      BTR_To_PX (ohCPI.BtrTable,otCPI.TmpTable);
      otCPI.Post;
      If otCPI.MgCode<mSecMgc
        then oCpiVal := oCpiVal+otCPI.CValue
        else oCpsVal := oCpsVal+otCPI.CValue;
      Application.ProcessMessages;
      ohCPI.Next;
    until ohCPI.Eof or (ohCPI.PdCode<>pPdCode);
  end;
end;

procedure TCpd.SlcPd(pCpCode:longint); // Nacita vyrobky so zadanym komponentom do PX
var mSecMgc:longint;
begin
  mSecMgc := gIni.ServiceMg;
  If otCPH.Active then otCPH.Close;
  otCPH.Open;
  ohCPI.First;
  Repeat
    If (ohCPI.CpCode=pCpCode) and ohCPH.LocatePdCode(ohCPI.PdCode) then begin
      otCPH.Insert;
      BTR_To_PX (ohCPH.BtrTable,otCPH.TmpTable);
      otCPH.IRcGsQnt  := ohCpi.RcGsQnt;
      otCPH.ILosPrc   := ohCpi.LosPrc ;
      otCPH.ICpGsQnt  := ohCpi.CpGsQnt;
      otCPH.ICPrice   := ohCpi.CPrice ;
      otCPH.IDPrice   := ohCpi.DPrice ;
      otCPH.IHPrice   := ohCpi.HPrice ;
      otCPH.IDscPrc   := ohCpi.DscPrc ;
      otCPH.IDscType  := ohCpi.DscType;
      otCPH.IAPrice   := ohCpi.APrice ;
      otCPH.IBPrice   := ohCpi.BPrice ;
      otCPH.ICValue   := ohCpi.CValue ;
      otCPH.INotice   := ohCpi.Notice ;
      otCPH.IItmType  := ohCpi.ItmType;
      otCPH.IPdGsQntu := ohCpi.PdGsQntu;
      otCPH.IRcGsQntu := ohCpi.RcGsQntu;
      otCPH.ICpGsQntu := ohCpi.CpGsQntu;
      otCPH.Post;
    end;
    ohCPI.Next;
  until ohCPI.Eof;
end;

procedure TCpd.PrnDoc(pBokNum:Str5;pPdCode:longint); // Vytlaèí zadany dodaci list
var mRep:TRep;  mhSYSTEM:TSystemHnd;
begin
  gAfc.GrpNum := gvSys.LoginGroup;
  gAfc.BookNum := pBokNum;
  If gAfc.AmbDocPrn then begin
    Open(pBokNum,TRUE,TRUE);
    If ohCPH.LocatePdCode(pPdCode) then begin
      mhSYSTEM := TSystemHnd.Create;  mhSYSTEM.Open;
      SlcItm(pPdCode);
      // --------------------------
      mRep := TRep.Create(Self);
      mRep.SysBtr := mhSYSTEM.BtrTable;
      mRep.HedBtr := ohCPH.BtrTable;
      mRep.ItmTmp := otCPI.TmpTable;
      mRep.Execute('CPD');
      FreeAndNil (mRep);
      // --------------------------
      FreeAndNil (mhSYSTEM);
    end;
  end
  else ShowMsg(eCom.ThisFncIsDis,'');
end;

procedure TCpd.NewDoc(pSerNum:word;pPaCode:longint;pDocDate:TDateTime); // Vygeneruje novu hlavicku dokladu
var mSerNum:word;  mDocNum:Str12;  mDocDate:TDateTime;
begin
(*
  mSerNum := pSerNum;
  mDocDate := pDocDate;
  If mSerNum=0 then mSerNum := ohCPH.NextSerNum; // Ak nie je zadane poradove cislo OD vygenerujeme nasledujuce
  If mDocDate=0 then mDocDate := Date; // Ak nie je zadany datum nastavime aktualny den
  mDocNum := ohCPH.GenDocNum(mSerNum);
  If not ohCPH.LocateDocNum(mDocNum) then begin // Ak neexistuje vyvorime hlacicku dokladu OD
    ohCPH.Insert;
    ohCPH.DocNum := mDocNum;
    ohCPH.SerNum := mSerNum;
    ohCPH.DocDate := mDocDate;
    If (pPaCode>0) then begin
      mhPAB := TPabHnd.Create;  mhPAB.Open(0);
      If mhPAB.LocatePaCode(pPaCode) then BTR_To_BTR (mhPAB.BtrTable,ohCPH.BtrTable);
      FreeAndNil (mhPAB);
    end;
    ohCPH.Post;
  end;
*)
end;

procedure TCpd.ClcDoc; // prepocita hlavicku zadaneho dokladu
begin
  ohCPH.Clc(ohCPI);
end;

procedure TCpd.ClcDoc(pPdCode:longint); // prepocita hlavicku zadaneho dokladu
begin
  If ohCPH.LocatePdCode(pPdCode) then ohCPH.Clc(ohCPI);
end;

procedure TCpd.TmpRef(pPdCode,pCpCode:longint); // Obnovy zaznam na zaklade BTR
begin
  If ohCPI.LocatePdCp(pPdCode,pCpCode) then begin
    If otCPI.LocateCpCode(pCpCode)
      then otCPI.Edit
      else otCPI.Insert;
    BTR_To_PX (ohCPI.BtrTable,otCPI.TmpTable);
    otCPI.Post;
  end;
end;

end.
{MOD 1905009}
{MOD 1905010}
