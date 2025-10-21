unit Imd;
{$F+}

// *****************************************************************************
//                               OBJEKT NA PRACU SO SV
// *****************************************************************************
// Programové funkcia:
// ---------------
// *****************************************************************************


interface

uses
  tstp, tIMI,
  IcTypes, IcConst, IcConv, IcTools, IcValue, IcVariab, NexGlob, NexError, NexMsg,
  DocHand, StkGlob, LinLst, Bok, Rep, Key, Doc, Plc, Stk, Spc,
  hGSCAT, hIMH, hIMI, hIMP, hStp,
  ComCtrls, SysUtils, Classes, Forms, MxArrays;

type
  PDat=^TDat;
  TDat=record
    rhIMH:TImhHnd;
    rhIMI:TImiHnd;
    rhIMP:TImpHnd;
  end;

  TImd = class(TComponent)
    constructor Create(AOwner: TComponent);
    destructor  Destroy; override;
    private
      oBokNum:Str5;
      oSerNum:longint;
      oYear:Str2;
      oDocNum:Str12;
      oDocDate:TDateTime;
      oFrmName:Str15;
      oImhClc:TStrings;
      oInd:TProgressBar;
      oLst:TList;
      oSpc:TSpc;
      function GetBokNum:Str5;
      procedure SetBokNum(pBokNum:Str5);
      function GetOpenCount:word;
    public
      ohGSCAT:TGscatHnd;
      ohIMH:TImhHnd;
      ohIMI:TImiHnd;
      ohIMP:TImpHnd;
      otIMI:TImiTmp;
//      oOcd : TOcd;
//      ohEmsCus : TEmsCusHnd;
      procedure Activate(pIndex:word); // Aktivuje databazu, ktora je otvorena pod poradovym cislom pIndex
      procedure Open(pBokNum:Str5); overload; // Otvori vsetky databazove subory zadanej knihy
      procedure Open(pBokNum:Str5;pIMH,pIMI,pIMP:boolean); overload;// Otvori zadane databazove subory
      procedure OpenLst(pBokLst:ShortString); // Otvori vsetky knihy ktore su zadane v retazci

      procedure NewDoc(pYear:Str2;pSerNum,pStkNum,pSmCode:word;pDocDate:TDateTime;pDesTxt:Str30); // Vygeneruje novu hlavicku dokladu
      procedure ClcDoc; overload; // Prepocita hlavicku zadaneho dokladu podla jeho poloziek
      procedure ClcDoc(pDocNum:Str12); overload;// Prepocita hlavicku zadaneho dokladu podla jeho poloziek
      procedure SubDoc; overload; // Vyskladni tovar z aktualneho dokladu
      procedure SubDoc(pDocNum:Str12); overload; // Vyskladni tovar zo zadaneho dokladu
      procedure PrnDoc(pDocNum:Str12); // Vytlaèí zadany doklad
      procedure LocDoc(pDocNum:Str12); // Vyhlada zadany doklad
      procedure LstClc; // Prepocita hlavicky dokladov ktore su uvedene v zozname oImhClc
      procedure AddItm(pGsCode:longint;pGsQnt,pCPrice:double); overload;// Prida novu polozku na zadany doklad
      procedure AddItm(pDocNum:Str12;pGsCode:longint;pGsQnt,pCPrice:double); overload; // Prida novu polozku na zadany doklad
//      function  ResOcd(pDocNum:Str12;pItmNum:longint):boolean; // Zarezervuje Zakazky z polozky TOVAR NA CESTE
      function  ItmSub(pDocNum:Str12;pItmNum:longint):boolean; // Vyda zadanu polozku
      function  ItmDel(pDocNum:Str12;pItmNum:longint):boolean; // Zrusi zadanu polozku
      function  ItmUns(pDocNum:Str12;pItmNum:longint):boolean; // Odskladni zadanu polozku
      procedure DeletePdn (pDocNum:Str12;pItmNum,pStkNum:word);
//      procedure AddSto(pDocNum:Str12;pItmNum:longint);
//      procedure OpenOcd;
      function DocDel(pDocNum:Str12;pHedDel:boolean):boolean;  // Zrusi zadany doklad
    published
      property OpenCount:word read GetOpenCount;
      property BokNum:Str5 read GetBokNum write SetBokNum;
      property Year:Str2 read oYear write oYear;
      property SerNum:longint read oSerNum write oSerNum;
      property DocNum:Str12 read oDocNum;
      property DocDate:TDateTime write oDocDate;
      property Ind:TProgressBar read oInd write oInd;
  end;

implementation

uses bIMP, bIMI, bImh;

constructor TImd.Create(AOwner: TComponent);
begin
  oFrmName := AOwner.Name;
  oSpc := TSpc.Create;
  ohGSCAT := TGscatHnd.Create;
  oImhClc := TStringList.Create;  oImhClc.Clear;
  oLst := TList.Create;  oLst.Clear;
  otIMI:=TImiTmp.Create;
  inherited;
end;

destructor TImd.Destroy;
var I:word;
begin
//  FreeAndNil (oOcd); FreeAndNil(ohEmsCus);
  If oLst.Count>0 then begin
    For I:=1 to oLst.Count do begin
      Activate (I);
      FreeAndNil (ohIMP);
      FreeAndNil (ohIMI);
      FreeAndNil (ohIMH);
    end;
  end;
  FreeAndNil (oLst);
  FreeAndNil (oImhClc);
  FreeAndNil (ohGSCAT);
  FreeAndNil (oSpc);
  FreeAndNil(otIMI);
  inherited;
end;

// ********************************* PRIVATE ***********************************

function TImd.GetBokNum:Str5;
begin
  Result := ohIMH.BtrTable.BookNum;
end;

procedure TImd.SetBokNum (pBokNum:Str5);
var mFind:boolean;  mCnt:word;
begin
  mFind := FALSE;
  If oLst.Count>0 then begin
    mCnt := 0;
    Repeat
      Activate(mCnt);
      mFind := ohIMH.BtrTable.BookNum=pBokNum;
      Inc (mCnt);
    until mFind or (mCnt=oLst.Count);
  end;
  If not mFind then  Open(pBokNum); // Ak dana kniha este nie je otvorena potomotvorime
end;

function TImd.GetOpenCount:word;
begin
  Result := oLst.Count;
end;

procedure TImd.Activate(pIndex:word); // Aktivuje databazu, ktora je otvorena pod poradovym cislom pIndex
var mDat:PDat;
begin
  mDat := oLst.Items[pIndex-1];
  ohIMH := mDat.rhIMH;
  ohIMI := mDat.rhIMI;
  ohIMP := mDat.rhIMP;
end;

// ********************************** PUBLIC ***********************************

procedure TImd.Open(pBokNum:Str5); // Otvori vsetky databazove subory
begin
  Open (pBokNum,TRUE,TRUE,TRUE);
end;

procedure TImd.Open(pBokNum:Str5;pIMH,pIMI,pIMP:boolean); // Otvori zadane databazove subory
var mFind:boolean;  mCnt:word;  mDat:PDat;
begin
  oBokNum := pBokNum;
  mFind := FALSE;
  If oLst.Count>0 then begin
    mCnt := 0;
    Repeat
      Inc (mCnt);
      Activate(mCnt);
      mFind := ohIMH.BtrTable.BookNum=pBokNum;
    until mFind or (mCnt=oLst.Count);
  end;
  If not mFind then begin // Ak dana kniha este nie je otvorena potomotvorime
    // Vytvorime objekty
    ohIMH := TImhHnd.Create;
    ohIMI := TImiHnd.Create;
    ohIMP := TImpHnd.Create;
    // Otvorime databazove subory
    If pIMH then ohIMH.Open(pBokNum);
    If pIMI then ohIMI.Open(pBokNum);
    If pIMP then ohIMP.Open(pBokNum);
    // Ulozime objekty do zoznamu
    GetMem (mDat,SizeOf(TDat));
    mDat^.rhIMH := ohIMH;
    mDat^.rhIMI := ohIMI;
    mDat^.rhIMP := ohIMP;
    oLst.Add(mDat);
  end;
end;

procedure TImd.OpenLst(pBokLst:ShortString); // Otvori vsetky knihy ktore su zadane v retazci
var mLinLst:TLinLst;
begin
  mLinLst := TLinLst.Create;
  mLinLst.AddLst(pBokLst);
  If mLinLst.Count>0 then begin
    mLinLst.First;
    Repeat
      If gBok.BokExist('IMB',mLinLst.Itm,TRUE) then begin
        BokNum := mLinLst.Itm;
      end;
      Application.ProcessMessages;
      mLinLst.Next;
    until mLinLst.Eof;
  end;
  FreeAndNil (mLinLst);
end;

procedure TImd.NewDoc(pYear:Str2;pSerNum,pStkNum,pSmCode:word;pDocDate:TDateTime;pDesTxt:Str30); // Vygeneruje novu hlavicku dokladu
var mSerNum,mStkNum,mSmCode:word;  mDocNum:Str12;  mDocDate:TDateTime;
begin
  mSerNum := pSerNum;
  mStkNum := pStkNum;
  mSmCode := pSmCode;
  mDocDate := pDocDate;
  oYear:=pYear;If oYear='' then oYear:=gvsys.ActYear2;
  If mSerNum=0 then mSerNum := NextSerNum(oYear,ohIMH.BtrTable);
//  If mStkNum=0 then mStkNum := gKey.ImbStkNum;
//  If mSmCode=0 then mSmCode := gKey.ImbSmCode;
  If mDocDate=0 then mDocDate := Date; // Ak nie je zadany datum nastavime aktualny den
  mDocNum := ohIMH.GenDocNum(oYear,ohIMH.BtrTable.BookNum,mSerNum);
  If not ohIMH.LocateDocNum(mDocNum) then begin // Ak neexistuje vyvorime hlacicku dokladu
    ohIMH.Insert;
    ohIMH.DocNum := mDocNum;
    ohIMH.SerNum := mSerNum;
    ohIMH.Year := oYear;
    ohIMH.StkNum := mStkNum;
    ohIMH.SmCode := mSmCode;
    ohIMH.DocDate := mDocDate;
    ohIMH.Describe := pDesTxt;
    ohIMH.Post;
  end;
  oDocNum:=mDocNum;
end;

procedure TImd.ClcDoc;
begin
  ohIMH.Clc(ohIMI);
end;

procedure TImd.ClcDoc(pDocNum:Str12);
begin
  If ohIMH.LocateDocNum(pDocNum) then ohIMH.Clc(ohIMI);
end;

procedure TImd.SubDoc; // Vyskladni tovar zo zadaneho dodacieho istu
var mStk:TStk;
begin
  If ohIMI.LocateDocNum(ohIMH.DocNum) then begin
    mStk := TStk.Create;
    If oInd<>nil then begin
      oInd.Max := ohIMH.ItmQnt;
      oInd.Position := 0;
    end;
    Repeat
      If oInd<>nil then oInd.StepBy(1);
      If ohIMI.StkStat='M' then begin
//        mStk.Dlv(ohIMI.StkNum,ohIMI.DocNum,ohIMI.ItmNum,ohIMI.GsQnt,Date);
        ohIMI.StkStat := 'N';
      end;
      If ohIMI.StkStat='N' then begin
        mStk.Clear;
        mStk.SmSign := '+';  // Prijem tovaru
        mStk.DocNum := ohIMI.DocNum;
        mStk.ItmNum := ohIMI.ItmNum;
        mStk.DocDate := ohIMI.DocDate;
        mStk.GsCode := ohIMI.GsCode;
        mStk.MgCode := ohIMI.MgCode;
        mStk.BarCode := ohIMI.BarCode;
        mStk.SmCode := ohIMH.SmCode;
        mStk.GsName := ohIMI.GsName;
        mStk.GsQnt := ohIMI.GsQnt;
        mStk.CPrice := ohIMI.CPrice;
        If mStk.Sub(ohIMI.StkNum) then begin // Ak sa podarilo vydat polozky
          ohIMI.Edit;
          ohIMI.StkStat := 'S';
          ohIMI.Post;
        end;
      end;
      Application.ProcessMessages;
      ohIMI.Next;
    until ohIMI.Eof or (ohIMI.DocNum<>ohIMH.DocNum);
    FreeAndNil (mStk);
  end;
  ohIMH.Clc(ohIMI);
end;

procedure TImd.SubDoc(pDocNum:Str12); // Vyskladni tovar zo zadaneho dodacieho istu
begin
  If ohIMH.LocateDocNum(pDocNum) then SubDoc;
end;

procedure TImd.PrnDoc(pDocNum:Str12); // Vytlaèí zadany doklad
var mRep:TRep;
begin
(*
  BokNum := BookNumFromDocNum(pDocNum);
  If ohIMH.LocateDocNum(pDocNum) then begin
    mRep := TRep.Create(Self);
    mRep.HedBtr := ohIMH.BtrTable;
    mRep.ItmTmp :=
    mRep.Execute('IMD');
    FreeAndNil (mRep);
  end;
*)
end;

procedure TImd.LstClc; // Prepocita hlavicky zakazkovych dokladov ktore su uvedene v zozname oOchClc
var I:word;
begin
  If oImhClc.Count>0 then begin  // Mame doklady na prepocitanie
    For I:=0 to oImhClc.Count-1 do begin
      BokNum := BookNumFromDocNum(oImhClc.Strings[I]);
      ClcDoc(oImhClc.Strings[I]);
    end
  end;
end;

procedure TImd.AddItm(pGsCode:longint;pGsQnt,pCPrice:double); // Prida novu polozku na zadany doklad
var mItmNum:word;
var mStk:TStk;
begin
  If not ohGSCAT.Active then ohGSCAT.Open;
  If ohGSCAT.LocateGsCode(pGsCode) then begin
    mItmNum := NextItmNum(ohIMI.BtrTable,ohIMH.DocNum);
    ohIMI.Insert;
    ohIMI.DocNum := ohIMH.DocNum;
    ohIMI.ItmNum := mItmNum;
    BTR_To_BTR(ohGSCAT.BtrTable,ohIMI.BtrTable);
    ohIMI.GsQnt := pGsQnt;
    ohIMI.CPrice := pCPrice;
    ohIMI.CValue := Rd2(pCPrice*pGsQnt);
    ohIMI.EValue := gPlc.ClcEPrice(Round(ohIMI.VatPrc),ohIMI.CValue);
    If IsNotNul(ohIMI.GsQnt)
      then ohIMI.EPrice := RdX(ohIMI.EValue/ohIMI.GsQnt,gKey.StpRndFrc)
      else ohIMI.EPrice := ohIMI.EValue;
    ohIMI.StkNum := ohIMH.StkNum;
    ohIMI.DocDate := ohIMH.DocDate;
    If ohIMH.AwdSta=1 then begin
      ohIMI.StkStat := 'M';
      ohIMI.Post;
//      mStk := TStk.Create;
//      mStk.AddSto(ohIMI);
//      FreeAndNil(mStk);
    end else begin
      ohIMI.StkStat := 'N';
      ohIMI.Post;
    end;
  end
  else ShowMsg (eCom.GscIsNoExist,StrInt(pGsCode,0));
end;

procedure TImd.AddItm(pDocNum:Str12;pGsCode:longint;pGsQnt,pCPrice:double); // Prida novu polozku na zadany doklad
begin
  If ohIMH.LocateDocNum(pDocNum)
    then AddItm(pGsCode,pGsQnt,pCPrice)
    else ShowMsg(eCom.DocIsNoExist,pDocNum);
end;

function TImd.DocDel(pDocNum:Str12;pHedDel:boolean):boolean;  // Zrusi zadany doklad
begin
(*
  Result := TRUE;
  If ohIMH.LocateDocNum(pDocNum) then begin
    If DocUnr(pDocNum) then begin
      If ohIMI.LocateDocNum(pDocNum) then begin
        Repeat
          Application.ProcessMessages;
          If ohIMI.StkStat='N'
            then ohIMI.Delete
            else begin
              Result := FALSE;
              ohIMI.Next;
            end;
        until ohIMI.Eof or (ohIMI.Count=0) or (ohIMI.DocNum<>pDocNum);
      end;
    end;
    ohIMH.Clc(ohIMI);
    Result := ohIMH.ItmQnt=0; // Je to v poriadku ak doklad nema ziadne polozky
    If Result and pHedDel then ohIMH.Delete;  // Ak je nastavene zrusenie hlavicky a bola vymazana kazda polozka zrusime hlavicku dokladu
  end;
*)
end;

function TIMd.ItmSub(pDocNum: Str12; pItmNum: Integer): boolean;
var mStk:TStk;
begin
  Result := FALSE;
  If not ohGSCAT.Active then ohGSCAT.Open;
  If ohIMH.LocateDocNum(pDocNum) then begin
    If ohIMI.LocateDoIt(pDocNum,pItmNum) and ohGSCAT.LocateGsCode(ohIMI.GsCode) then begin
      mStk := TStk.Create;
      If ohIMI.StkStat='M' then begin
//        mStk.Dlv(ohIMI.StkNum,ohIMI.DocNum,ohIMI.ItmNum,ohIMI.GsQnt,Date);
        ohIMI.StkStat := 'N';
      end;
      If ohIMI.StkStat='N' then begin  // Spravyme vydaj tovaru
        mStk.Clear;
        mStk.SmSign  := '+';  // Prijem tovaru
        mStk.DocNum  := ohIMI.DocNum;
        mStk.ItmNum  := ohIMI.ItmNum;
        mStk.DocDate := ohIMI.DocDate;
        mStk.GsCode  := ohIMI.GsCode;
        mStk.MgCode  := ohIMI.MgCode;
        mStk.BarCode := ohIMI.BarCode;
        mStk.SmCode  := ohIMH.SmCode;
        mStk.GsName  := ohIMI.GsName;
        mStk.GsQnt   := ohIMI.GsQnt;
        mStk.CValue  := ohIMI.CValue;
        mStk.CPrice  := ohIMI.CPrice;
        If mStk.Sub(ohIMI.StkNum) then begin // Ak sa podarilo vydat polozky
          ohIMI.Edit;
          ohIMI.CValue  := mStk.CValue;
          ohIMI.EValue  := gPlc.ClcEPrice(ohGSCAT.VatPrc,ohIMI.CValue);
          ohIMI.StkStat := 'S';
          ohIMI.Post;
        end;
//        If ohIMI.PosCode<>'' then oSpc.Sub(ohIMH.StkNum,ohIMI.PosCode,ohIMI.GsCode,ohIMI.DocNum,ohIMI.ItmNum,ohIMI.DocDate,0-ohIMI.GsQnt,0);
      end;
    end;
  end;
end;

function TIMd.ItmDel(pDocNum: Str12; pItmNum: Integer): boolean;
var mOK:boolean;
var mStk:TStk;
begin
  Result := FALSE;
  ohIMH.LocateDocNum(pDocNum);
  ohIMI.LocateDoIt(pDocNum,pItmNum);
  If (ohIMI.PosCode<>'') then oSpc.StkNum:=ohIMH.StkNum;
  mOK:= (ohIMI.PosCode='') or (ohIMI.StkStat<>'S') or
  ((ohIMI.PosCode<>'') and oSpc.ohSPC.LocatePoGs(ohIMI.PosCode,ohIMI.GsCode) and (oSpc.ohSPC.ActQnt>=ohIMI.GsQnt));
  If not mOK then mOK := AskYes(acImbDelImiNotEnghPos,ohIMI.PosCode);
  If mOK then begin
    If ItmUns(pDocNum,pItmNum) then begin
//      If ohIMI.PosCode<>'' then oSpc.Del(ohIMH.StkNum,ohIMI.PosCode,ohIMI.GsCode,ohIMI.DocNum,ohIMI.ItmNum);
      While ohIMP.LocateDoIt (ohIMI.DocNum,ohIMI.ItmNum) do begin
        ohIMP.Delete;
      end;
      DeletePdn (ohIMI.DocNum,ohIMI.ItmNum,ohIMI.StkNum);
//      mStk := TStk.Create;
//      mStk.DelSto(ohIMI.DocNum,ohIMI.ItmNum);
//      FreeAndNil(mStk);
      ohIMI.Delete;
//      If (otIMI<>NIL) and otIMI.Active then otIMI.Delete;
      Result := TRUE;
    end;
  end;
end;

function TIMd.ItmUns(pDocNum: Str12; pItmNum: Integer): boolean;
var mStk:TStk;
begin
  Result := TRUE;
  If ohIMH.LocateDocNum(pDocNum) then begin
    If ohIMI.LocateDoIt(pDocNum,pItmNum) then begin
      mStk := TStk.Create;
      If ohIMI.StkStat='S' then begin
        If mStk.Uns(ohIMI.StkNum,ohIMI.DocNum,ohIMI.ItmNum) then begin // Zrusime skladovy vydaj
          ohIMI.Edit;
          If ohIMH.AwdSta=1 then begin
            ohIMI.StkStat := 'M';
            ohIMI.Post;
//            mStk := TStk.Create;
//            mStk.StoRef(ohIMI);
//            FreeAndNil(mStk);
          end else begin
            ohIMI.StkStat := 'N';
            ohIMI.Post;
          end;
        end
        else Result := FALSE;
      end;
      FreeAndNil (mStk);
    end;
  end;
end;

procedure TIMd.DeletePdn (pDocNum:Str12;pItmNum,pStkNum:word);
var mhSTP:TStpHnd;
begin
  mhSTP:=TStpHnd.Create;
  mhSTP.Open(pStkNum);
  While mhSTP.LocateInDoIt (pDocNum,pItmNum) do begin
    mhSTP.Delete;
  end;
  mhSTP.Close;
  FreeAndNil(mhSTP);
end;

procedure TImd.LocDoc(pDocNum: Str12);
begin
  If ohIMH.LocateDocNum(pDocNum) then begin
    oDocNum:=ohIMH.DocNum;
    oSerNum:=ohIMH.SerNum;
    oYear:=ohIMH.Year;
  end else begin
    oDocNum:='';
    oSerNum:=0;
    oYear:='';
  end;
end;

(*
procedure TImd.AddSto(pDocNum: Str12; pItmNum: Integer);
var mStk:TStk;
begin
  If ohIMH.LocateDocNum(pDocNum)and ohIMI.LocateDoIt(pDocNum,pItmNum) then begin
    mStk := TStk.Create;
    mStk.StoRef(ohImi);
    FreeAndNil(mStk);
  end;
end;

function TImd.ResOcd(pDocNum: Str12; pItmNum: Integer): boolean;
var mStk:TStk;
var mResQnt,mQnt:double; mBook:Str5; mDocLst,mLCnf,mLChg:TStrings; mWriNum,mI:integer;
    mLine:string; mDate:TDateTime; mOcdNum:Str12;mOcdItm:integer;
begin
  If not ohGSCAT.Active then ohGSCAT.Open;
  If ohIMH.LocateDocNum(pDocNum) then begin
    If ohIMI.LocateDoIt(pDocNum,pItmNum) and ohGSCAT.LocateGsCode(ohIMI.GsCode) then begin
      OpenOcd;
      mLCnf:=TStringList.Create;mLChg:=TStringList.Create;mDocLst:=TStringList.Create;
      mWriNum := GetWriNum(ohIMI.StkNum);
      mStk := TStk.Create;
      If ohIMI.StkStat='M' then begin
        mStk.StkNum:=ohIMI.StkNum;
        mStk.ohSto.LocateDoIt(ohIMI.DocNum,ohIMI.ItmNum);
        mQnt:=mStk.ohSto.OrdQnt-mStk.ohSto.DlvQnt-mStk.ohSto.ResQnt;
//        mQnt:=otOsi.OrdQnt-otOsi.DlvQnt-mStk.ohSto.ResQnt;
        mResQnt:=0;
        mStk.ohSto.LocateGsOrSt(ohIMI.GsCode,'C','N');
        while (mQnt>0) and not mStk.ohSto.Eof and(mStk.ohSto.GsCode=ohIMI.GsCode)and(mStk.ohSto.OrdType='C')and(mStk.ohSto.StkStat='N')do
        begin
          If mStk.ohSto.OrdQnt<=mQnt then begin
            mBook:=BookNumFromDocNum(mStk.ohSto.DocNum);
            oOcd.Open(mBook);
            If oOcd.ohOCI.LocateDoIt(mStk.ohSto.DocNum,mStk.ohSto.ItmNum) then begin
              mQnt:=mQnt-mStk.ohSto.OrdQnt;mResQnt:=mResQnt+mStk.ohSto.OrdQnt;
              oOcd.ohOCI.Edit;
              oOcd.ohOCI.OsdNum :=ohIMI.DocNum;
              oOcd.ohOCI.OsdItm :=ohIMI.ItmNum;
              oOcd.ohOCI.OsdDate:=ohIMI.DocDate;
              oOcd.ohOCI.DlvDate:= ohIMI.DocDate+gkey.ImbDlvDay[BokNum];
              oOcd.ohOCI.DlvNoti:= '';
              oOcd.ohOCI.DlvNum := oOcd.ohOCI.DlvNum+1;
              oOcd.ohOCI.StkStat:='O';
              If oOcd.ohOCI.DlvDate<oOcd.ohOCI.RqdDate then oOcd.ohOCI.DlvDate:=oOcd.ohOCI.RqdDate;
              oOcd.ohOCI.Post;
              If mDocLst.IndexOf(oOcd.ohOCI.DocNum)=-1 then mDocLst.Add(oOcd.ohOCI.DocNum);
              mStk.ohSto.Edit;
              mStk.ohSto.OsdNum:=ohIMI.DocNum;
              mStk.ohSto.OsdItm:=ohIMI.ItmNum;
              mStk.ohSto.DlvDate:= ohIMI.DocDate+gkey.ImbDlvDay[BokNum];
              mStk.ohSto.StkStat:='O';
              mStk.ohSto.AcqMode:='O';
              mStk.ohSto.Post;
              mDate:=oOcd.ohOCI.DlvDate;
              mOcdNum:=oOcd.ohOCI.DocNum;mOcdItm:=oOcd.ohOCI.ItmNum;
              If mLCnf.IndexOfName(oOcd.ohOCI.DocNum)=-1 then begin
                mLCnf.Add(oOcd.ohOCI.DocNum+'='+IntToStr(oOcd.ohOCI.PaCode)+';'+IntToStr(oOcd.ohOCI.GsCode)+';'
                 +oOcd.ohOCI.GsName+';'+oOcd.ohOCI.BarCode+';'+StrDoub(oOcd.ohOCI.OrdQnt,0,3)+';'+DateToStr(mDate));
              end else begin
                mLCnf.Values[oOcd.ohOCI.DocNum]:=mLCnf.Values[oOcd.ohOCI.DocNum]+'|'
                                          +IntToStr(oOcd.ohOCI.PaCode)+';'+IntToStr(oOcd.ohOCI.GsCode)+';'
                +oOcd.ohOCI.GsName+';'+oOcd.ohOCI.BarCode+';'+StrDoub(oOcd.ohOCI.OrdQnt,0,3)+';'+DateToStr(mDate);
              end;
              mStk.ohSto.LocateGsOrSt(ohIMI.GsCode,'C','N');
            end else mStk.ohSto.Next;
          end else mStk.ohSto.Next;
        end;
        If IsNotNul(mResQnt) and mStk.ohSto.LocateDoIt(ohIMI.DocNum,ohIMI.ItmNum) then begin
          mStk.ohSto.Edit;
          mStk.ohSto.ResQnt:=mStk.ohSto.ResQnt+mResQnt;
          mStk.ohSto.Post;
        end;
      end;
      If mDocLst.Text<>'' then begin
        For mI:=0 to mDocLst.Count-1 do oOcd.ClcDoc(mDocLst[mI]);
      end;
      // Generovanie sprav zakaznikom
      for mI:=0 to mLCnf.Count-1 do begin
        mLine:=mLCnf.Strings[mI];
        mLine:=Copy(mLine,Pos('=',mLine)+1,Length(mLine)-Pos('=',mLine));
        ohEmsCus.CrtMsg(mWriNum,'',Date,'C',mLCnf.Names[mI],ValInt(LineElement(mLine,0,';')),
        gKey.osb.CnfTxt+' '+oOcd.GetExtNum(mLCnf.Names[mI])+' '+DateToStr(oOcd.GetDocDate(mLCnf.Names[mI])),mLine);
      end;
      for mI:=0 to mLChg.Count-1 do begin
        mLine:=mLChg.Strings[mI];
        mLine:=Copy(mLine,Pos('=',mLine)+1,Length(mLine)-Pos('=',mLine));
        ohEmsCus.CrtMsg(mWriNum,'',Date,'M',mLChg.Names[mI],ValInt(LineElement(mLine,0,';')),
        gKey.osb.ChgTxt+' '+oOcd.GetExtNum(mLChg.Names[mI])+' '+DateToStr(oOcd.GetDocDate(mLChg.Names[mI])),mLine);
      end;
      FreeAndNil(mDocLst);
      FreeAndNil(mLCnf);
      FreeAndNil(mLChg);
      FreeAndNil(mStk);
    end;
  end;
end;

procedure TImd.OpenOcd;
begin
  If oOcd=NIL then begin oOcd:=TOcd.Create(Self); oOcd.OpenLst(''); end;
  If ohEmsCus=NIL then begin ohEmsCus:=TEmscusHnd.Create;ohEmsCus.Open; end;
end;
*)
end.
