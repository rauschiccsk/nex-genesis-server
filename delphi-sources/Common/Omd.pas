unit Omd;
{$F+}

// *****************************************************************************
//                               OBJEKT NA PRACU SO SV
// *****************************************************************************
// Programové funkcia:
// ---------------
// *****************************************************************************


interface

uses
  IcTypes, IcConst, IcConv, IcTools, IcValue, IcVariab, DocHand,
  NexGlob, NexError, NexMsg, NexPxTable,
  LinLst, Bok, Rep, Key, Doc, Plc, Stk, Spc, SavClc,
  hGSCAT, hOMH, hOMI, hOMP, tOMI,
  Controls, ComCtrls, SysUtils, Classes, Forms, MxArrays;

type
  PDat=^TDat;
  TDat=record
    rhOMH:TOmhHnd;
    rhOMI:TOmiHnd;
    rhOMP:TOmpHnd;
  end;
                                          
  TOmd = class(TComponent)
    constructor Create(AOwner: TComponent);
    destructor  Destroy; override;
    private
      oBokNum:Str5;
      oYear:Str2;
      oSerNum:longint;
      oDocNum:Str12;
      oDocDate:TDateTime;
      oFrmName:Str15;
      oDocClc:TStrings;
      oInd:TProgressBar;
      oLst:TList;
      oSpc:TSpc;
      function GetBokNum:Str5;
      procedure SetBokNum(pBokNum:Str5);
      function GetOpenCount:word;
    public
      ohOMH:TOmhHnd;
      ohOMI:TOmiHnd;
      ohOMP:TOmpHnd;
      otOMI:TOmiTmp;
      ohGSCAT:TGscatHnd;
      procedure Open(pBokNum:Str5); overload; // Otvori vsetky databazove subory zadanej knihy
      procedure Open(pBokNum:Str5;pOMH,pOMI,pOMP:boolean); overload;// Otvori zadane databazove subory
      procedure OpenLst(pBokLst:ShortString); // Otvori vsetky knihy ktore su zadane v retazci

      procedure Activate(pIndex:word); // Aktivuje databazu, ktora je otvorena pod poradovym cislom pIndex
      procedure NewDoc(pYear:Str2;pSerNum,pStkNum,pSmCode:word;pDocDate:TDateTime;pDesTxt:Str30); // Vygeneruje novu hlavicku dokladu
      procedure ClcDoc; overload; // Prepocita hlavicku aktualneho dokladu podla jeho poloziek
      procedure ClcDoc(pDocNum:Str12); overload; // Prepocita hlavicku zadaneho dokladu podla jeho poloziek
      procedure SubDoc; overload; // Vyskladni tovar z aktualneho dokladu
      procedure SubDoc(pDocNum:Str12); overload; // Vyskladni tovar zo zadaneho dokladu
      procedure PrnDoc(pDocNum:Str12); // Vytlaèí zadany doklad
      procedure LocDoc(pDocNum:Str12); // Vyhlada zadany doklad
      procedure LstClc; // Prepocita hlavicky dokladov ktore su uvedene v zozname oDocClc
      procedure AddItm(pGsCode:longint;pGsQnt:double); overload;// Prida novu polozku na zadany doklad
      procedure AddItm(pDocNum:Str12;pGsCode:longint;pGsQnt:double); overload; // Prida novu polozku na zadany doklad
      procedure AddItm(pDocNum:Str12;pGsCode:longint;pGsQnt:double;pBPrice:double); overload; // Prida novu polozku na zadany doklad
      procedure AddRba(pStkNum,pGsCode:longint;pGsQnt,pDscPrc,pFgBPrice:double;pRbaCode:Str30;pRbaDate:TDate;pFifStr:String;pPxTable:TNexPxTable); // Prida novu polozku so sarzou na zadany dodaci list
      function  ItmSub(pDocNum:Str12;pItmNum:longint):boolean; // Vyda zadanu polozku
      function  ItmDel(pDocNum:Str12;pItmNum:longint):boolean; // Zrusi zadanu polozku
      function  ItmUns(pDocNum:Str12;pItmNum:longint):boolean; // Odskladni zadanu polozku

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

uses bOmh, bOMI;

constructor TOmd.Create(AOwner: TComponent);
begin
  oFrmName := AOwner.Name;
  oSpc := TSpc.Create;
  ohGSCAT := TGscatHnd.Create;
  oDocClc := TStringList.Create;  oDocClc.Clear;
  oLst := TList.Create;  oLst.Clear;
  otOMI := TOmiTmp.Create;
end;

destructor TOmd.Destroy;
var I:word;
begin
  If oLst.Count>0 then begin
    For I:=1 to oLst.Count do begin
      Activate (I);
      FreeAndNil (ohOMP);
      FreeAndNil (ohOMI);
      FreeAndNil (ohOMH);
    end;
  end;
  FreeAndNil (otOMI);
  FreeAndNil (oLst);
  FreeAndNil (oDocClc);
  FreeAndNil (ohGSCAT);
  FreeAndNil (oSpc);
end;

// ********************************* PRIVATE ***********************************

function TOmd.GetBokNum:Str5;
begin
  Result := ohOMH.BtrTable.BookNum;
end;

procedure TOmd.SetBokNum (pBokNum:Str5);
var mFind:boolean;  mCnt:word;
begin
  mFind := FALSE;
  If oLst.Count>0 then begin
    mCnt := 0;
    Repeat
      Activate(mCnt);
      mFind := ohOMH.BtrTable.BookNum=pBokNum;
      Inc (mCnt);
    until mFind or (mCnt=oLst.Count);
  end;
  If not mFind then  Open(pBokNum); // Ak dana kniha este nie je otvorena potomotvorime
end;

function TOmd.GetOpenCount:word;
begin
  Result := oLst.Count;
end;

procedure TOmd.Activate(pIndex:word); // Aktivuje databazu, ktora je otvorena pod poradovym cislom pIndex
var mDat:PDat;
begin
  mDat := oLst.Items[pIndex-1];
  ohOMH := mDat.rhOMH;
  ohOMI := mDat.rhOMI;
  ohOMP := mDat.rhOMP;
end;

// ********************************** PUBLIC ***********************************

procedure TOmd.Open(pBokNum:Str5); // Otvori vsetky databazove subory
begin
  Open (pBokNum,TRUE,TRUE,False);
end;

procedure TOmd.Open(pBokNum:Str5;pOMH,pOMI,pOMP:boolean); // Otvori zadane databazove subory
var mFind:boolean;  mCnt:word;  mDat:PDat;
begin
  oBokNum := pBokNum;
  mFind := FALSE;
  If oLst.Count>0 then begin
    mCnt := 0;
    Repeat
      Inc (mCnt);
      Activate(mCnt);
      mFind := ohOMH.BtrTable.BookNum=pBokNum;
    until mFind or (mCnt=oLst.Count);
  end;
  If not mFind then begin // Ak dana kniha este nie je otvorena potomotvorime
    // Vytvorime objekty
    ohOMH := TOmhHnd.Create;
    ohOMI := TOmiHnd.Create;
    ohOMP := TOmpHnd.Create;
    // Otvorime databazove subory
    If pOMH then ohOMH.Open(pBokNum);
    If pOMI then ohOMI.Open(pBokNum);
    If pOMP then ohOMP.Open(pBokNum);
    // Ulozime objekty do zoznamu
    GetMem (mDat,SizeOf(TDat));
    mDat^.rhOMH := ohOMH;
    mDat^.rhOMI := ohOMI;
    mDat^.rhOMP := ohOMP;
    oLst.Add(mDat);
  end;
end;

procedure TOmd.OpenLst(pBokLst:ShortString); // Otvori vsetky knihy ktore su zadane v retazci
var mLinLst:TLinLst;
begin
  mLinLst := TLinLst.Create;
  mLinLst.AddLst(pBokLst);
  If mLinLst.Count>0 then begin
    mLinLst.First;
    Repeat
      If gBok.BokExist('OMB',mLinLst.Itm,TRUE) then begin
        BokNum := mLinLst.Itm;
      end;
      Application.ProcessMessages;
      mLinLst.Next;
    until mLinLst.Eof;
  end;
  FreeAndNil (mLinLst);
end;

procedure TOmd.NewDoc(pYear:Str2;pSerNum,pStkNum,pSmCode:word;pDocDate:TDateTime;pDesTxt:Str30); // Vygeneruje novu hlavicku dokladu
var mSerNum,mStkNum,mSmCode:word;  mDocNum:Str12;  mDocDate:TDateTime;
begin
  oYear:=pYear;If oYear='' then oYear:=gvsys.ActYear2;
  mSerNum := pSerNum;
  mStkNum := pStkNum;
  mSmCode := pSmCode;
  mDocDate := pDocDate;
  If mSerNum=0 then mSerNum := NextSerNum(pYear,ohOMH.BtrTable);
//  If mStkNum=0 then mStkNum := gKey.OmbStkNum;
//  If mSmCode=0 then mSmCode := gKey.OmbSmCode;
  If mDocDate=0 then mDocDate := Date; // Ak nie je zadany datum nastavime aktualny den
  mDocNum := ohOMH.GenDocNum(pYear,ohOMH.BtrTable.BookNum,mSerNum);
  If not ohOMH.LocateDocNum(mDocNum) then begin // Ak neexistuje vyvorime hlacicku dokladu
    ohOMH.Insert;
    ohOMH.DocNum := mDocNum;
    ohOMH.Year := oYear;
    ohOMH.SerNum := mSerNum;
    ohOMH.StkNum := mStkNum;
    ohOMH.SmCode := mSmCode;
    ohOMH.DocDate := mDocDate;
    ohOMH.Describe := pDesTxt;
    ohOMH.Post;
  end;
  LocDoc(mDocNum);
end;

procedure TOmd.ClcDoc; // Vytlaèí zadany doklad
begin
  ohOMH.Clc(ohOMI);
end;

procedure TOmd.ClcDoc(pDocNum:Str12); // Vytlaèí zadany doklad
begin
  If ohOMH.LocateDocNum(pDocNum) then ohOMH.Clc(ohOMI);
end;

procedure TOmd.SubDoc; // Vyskladni tovar zo zadaneho dodacieho istu
var mStk:TStk;
begin
  If ohOMI.LocateDocNum(ohOMH.DocNum) then begin
    mStk := TStk.Create;
    If oInd<>nil then begin
      oInd.Max := ohOMH.ItmQnt;
      oInd.Position := 0;
    end;
    Repeat
      If oInd<>nil then oInd.StepBy(1);
      If ohOMI.StkStat='N' then begin
        mStk.Clear;
        mStk.SmSign := '-';  // Vydaj tovaru
        mStk.DocNum := ohOMI.DocNum;
        mStk.ItmNum := ohOMI.ItmNum;
        mStk.DocDate := ohOMI.DocDate;
        mStk.GsCode := ohOMI.GsCode;
        mStk.MgCode := ohOMI.MgCode;
        mStk.BarCode := ohOMI.BarCode;
        mStk.SmCode := ohOMH.SmCode;
        mStk.GsName := ohOMI.GsName;
        mStk.GsQnt := ohOMI.GsQnt;
        If mStk.Sub(ohOMI.StkNum) then begin // Ak sa podarilo vydat polozky
          ohOMI.Edit;
          ohOMI.CValue := mStk.CValue;
          ohOMI.EValue := gPlc.ClcEPrice(Round(ohOMI.VatPrc),ohOMI.CValue);
          If IsNotNul(ohOMI.GsQnt) then begin
            ohOMI.CPrice := RdX(ohOMI.CValue/ohOMI.GsQnt,gKey.StpRndFrc);
            ohOMI.EPrice := RdX(ohOMI.EValue/ohOMI.GsQnt,gKey.StpRndFrc);
          end
          else begin
            ohOMI.CPrice := ohOMI.CValue;
            ohOMI.EPrice := ohOMI.EValue;
          end;
          ohOMI.StkStat := 'S';
          ohOMI.Post;
        end;
      end;
      Application.ProcessMessages;
      ohOMI.Next;
    until ohOMI.Eof or (ohOMI.DocNum<>ohOMH.DocNum);
    FreeAndNil (mStk);
  end;
  ohOMH.Clc(ohOMI);
end;

procedure TOmd.SubDoc(pDocNum:Str12); // Vyskladni tovar zo zadaneho dodacieho istu
begin
  If ohOMH.LocateDocNum(pDocNum) then SubDoc;
end;

procedure TOmd.PrnDoc(pDocNum:Str12); // Vytlaèí zadany doklad
var mRep:TRep;
begin
(*
  BokNum := BookNumFromDocNum(pDocNum);
  If ohOMH.LocateDocNum(pDocNum) then begin
    mRep := TRep.Create(Self);
    mRep.HedBtr := ohOMH.BtrTable;
    mRep.ItmTmp :=
    mRep.Execute('OMD');
    FreeAndNil (mRep);
  end;
*)
end;

procedure TOmd.LstClc; // Prepocita hlavicky zakazkovych dokladov ktore su uvedene v zozname oOchClc
var I:word;
begin
  If oDocClc.Count>0 then begin  // Mame doklady na prepocitanie
    For I:=0 to oDocClc.Count-1 do begin
      BokNum := BookNumFromDocNum(oDocClc.Strings[I]);
      ClcDoc(oDocClc.Strings[I]);
    end
  end;
end;

procedure TOmd.AddItm(pGsCode:longint;pGsQnt:double); // Prida novu polozku na zadany doklad
var mItmNum:word;
begin
  If not ohGSCAT.Active then ohGSCAT.Open;
  If ohGSCAT.LocateGsCode(pGsCode) then begin
    mItmNum := NextItmNum(ohOMI.BtrTable,ohOMH.DocNum);
    ohOMI.Insert;
    ohOMI.DocNum := ohOMH.DocNum;
    ohOMI.ItmNum := mItmNum;
    BTR_To_BTR(ohGSCAT.BtrTable,ohOMI.BtrTable);
    ohOMI.GsQnt := pGsQnt;
    ohOMI.StkNum := ohOMH.StkNum;
    ohOMI.DocDate := ohOMH.DocDate;
    ohOMI.StkStat := 'N';
    ohOMI.Post;
  end
  else ShowMsg (eCom.GscIsNoExist,StrInt(pGsCode,0));
end;

procedure TOmd.AddItm(pDocNum:Str12;pGsCode:longint;pGsQnt:double;pBPrice:double); // Prida novu polozku na zadany doklad
var mItmNum:word;
begin
  If ohOMH.LocateDocNum(pDocNum) then
  begin
    If not ohGSCAT.Active then ohGSCAT.Open;
    If ohGSCAT.LocateGsCode(pGsCode) then begin
      mItmNum := NextItmNum(ohOMI.BtrTable,ohOMH.DocNum);
      ohOMI.Insert;
      ohOMI.DocNum := ohOMH.DocNum;
      ohOMI.ItmNum := mItmNum;
      BTR_To_BTR(ohGSCAT.BtrTable,ohOMI.BtrTable);
      ohOMI.GsQnt := pGsQnt;
      ohOMI.StkNum := ohOMH.StkNum;
      ohOMI.DocDate := ohOMH.DocDate;
      ohOMI.StkStat := 'N';
      ohOMI.BPrice := pBPrice;
      ohOMI.BValue := pBPrice*pGsQnt;
      ohOMI.Post;
    end
    else ShowMsg (eCom.GscIsNoExist,StrInt(pGsCode,0));
  end else ShowMsg(eCom.DocIsNoExist,pDocNum);
end;

procedure TOmd.AddItm(pDocNum:Str12;pGsCode:longint;pGsQnt:double); // Prida novu polozku na zadany doklad
begin
  If ohOMH.LocateDocNum(pDocNum)
    then AddItm(pGsCode,pGsQnt)
    else ShowMsg(eCom.DocIsNoExist,pDocNum);
end;

function TOmd.DocDel(pDocNum:Str12;pHedDel:boolean):boolean;  // Zrusi zadany doklad
begin
(*
  Result := TRUE;
  If ohOMH.LocateDocNum(pDocNum) then begin
    If DocUnr(pDocNum) then begin
      If ohOMI.LocateDocNum(pDocNum) then begin
        Repeat
          Application.ProcessMessages;
          If ohOMI.StkStat='N'
            then ohOMI.Delete
            else begin
              Result := FALSE;
              ohOMI.Next;
            end;
        until ohOMI.Eof or (ohOMI.Count=0) or (ohOMI.DocNum<>pDocNum);
      end;
    end;
    ohOMH.Clc(ohOMI);
    Result := ohOMH.ItmQnt=0; // Je to v poriadku ak doklad nema ziadne polozky
    If Result and pHedDel then ohOMH.Delete;  // Ak je nastavene zrusenie hlavicky a bola vymazana kazda polozka zrusime hlavicku dokladu
  end;
*)
end;

function TOmd.ItmSub(pDocNum: Str12; pItmNum: Integer): boolean;
var mStk:TStk;
begin
  Result := FALSE;
  If not ohGSCAT.Active then ohGSCAT.Open;
  If ohOMH.LocateDocNum(pDocNum) then begin
    If ohOMI.LocateDoIt(pDocNum,pItmNum) and ohGSCAT.LocateGsCode(ohOMI.GsCode) then begin
      mStk := TStk.Create;
      If ohOMI.StkStat='N' then begin  // Spravyme vydaj tovaru
        mStk.Clear;
        mStk.SmSign := '-';  // Vydaj tovaru
        mStk.DocNum := ohOMI.DocNum;
        mStk.ItmNum := ohOMI.ItmNum;
        mStk.DocDate := ohOMI.DocDate;
        mStk.GsCode := ohOMI.GsCode;
        mStk.MgCode := ohOMI.MgCode;
        mStk.BarCode := ohOMI.BarCode;
        mStk.SmCode := ohOMH.SmCode;
        mStk.GsName := ohOMI.GsName;
        mStk.GsQnt := ohOMI.GsQnt;
        If mStk.Sub(ohOMI.StkNum) then begin // Ak sa podarilo vydat polozky
          ohOMI.Edit;
          ohOMI.CValue := mStk.CValue;
          ohOMI.EValue := gPlc.ClcEPrice(ohGSCAT.VatPrc,ohOMI.CValue);
          If IsNotNul(ohOMI.GsQnt) then begin
            ohOMI.CPrice := RoundCPrice(ohOMI.CValue/ohOMI.GsQnt);
            ohOMI.EPrice := RoundCPrice(ohOMI.EValue/ohOMI.GsQnt);
          end;
          ohOMI.StkStat := 'S';
          ohOMI.Post;
        end;
//        If ohOMI.PosCode<>'' then oSpc.Sub(ohOMI.StkNum,ohOMI.PosCode,ohOMI.GsCode,ohOMI.DocNum,ohOMI.ItmNum,ohOMI.DocDate,ohOMI.GsQnt);
      end;
    end;
  end;
end;

function TOmd.ItmDel(pDocNum: Str12; pItmNum: Integer): boolean;
var mOK:boolean;
begin
  Result := FALSE;
  ohOMI.LocateDoIt(pDocNum,pItmNum);
  If (ohOMI.PosCode<>'') then oSpc.StkNum:=ohOMI.StkNum;
  mOK:= (ohOMI.StkStat<>'S') or (ohOMI.PosCode='') or
  ((ohOMI.PosCode<>'') and oSpc.ohSPC.LocatePoGs(ohOMI.PosCode,ohOMI.GsCode) and (oSpc.ohSPC.ActQnt>=0-ohOMI.GsQnt));
  If not mOK then mOK := AskYes(acImbDelImiNotEnghPos,ohOMI.PosCode);
  If mOK then begin
    If ItmUns(pDocNum,pItmNum) then begin
//      If ohOMI.PosCode<>'' then oSpc.Del(ohOMI.StkNum,ohOMI.PosCode,ohOMI.GsCode,ohOMI.DocNum,ohOMI.ItmNum);
      While ohOMP.LocateDoIt(pDocNum,pItmNum) do ohOMP.Delete;
      ohOMI.Delete;
      If (otOmi<>NIL) and otOMI.Active then begin
        If otOMI.LocateDoIt(pDocNum,pItmNum) then otOMI.Delete;
      end;
      Result := TRUE;
    end;
  end;
end;

function TOmd.ItmUns(pDocNum: Str12; pItmNum: Integer): boolean;
var mStk:TStk;
begin
  Result := TRUE;
  If ohOMH.LocateDocNum(pDocNum) then begin
    If ohOMI.LocateDoIt(pDocNum,pItmNum) then begin
      mStk := TStk.Create;
      If ohOMI.StkStat='S' then begin
        If mStk.Uns(ohOMI.StkNum,ohOMI.DocNum,ohOMI.ItmNum) then begin // Zrusime skladovy vydaj
          mStk.OutPdnClear(ohOMI.DocNum,ohOMI.ItmNum,ohOMI.StkNum);
          ohOMI.Edit;
          ohOMI.CValue := 0;
          ohOMI.EValue := 0;
          ohOMI.StkStat := 'N';
          ohOMI.Post;
        end
        else Result := FALSE;
      end;
      FreeAndNil (mStk);
    end;
  end;
end;

procedure TOmd.LocDoc(pDocNum: Str12);
begin
  If ohOMH.LocateDocNum(pDocNum) then begin
    oDocNum :=ohOMH.DocNum;
    oSerNum :=ohOMH.SerNum;
    oYear :=ohOMH.Year;
    oDocDate:=ohOMH.DocDate;
  end else begin
    oDocNum :='';
    oYear :='';
    oSerNum :=0;
    oDocDate:=0;
  end;
end;

procedure TOmd.AddRba(pStkNum,pGsCode: Integer; pGsQnt, pDscPrc, pFgBPrice: double;
  pRbaCode: Str30; pRbaDate: TDate; pFifStr: String;pPxTable: TNexPxTable);
var mJ,mI,mItmNum:word; mStk:TStk; mQnt,mSQnt:double; mRbaCode,mLine,mStr:String;
    mFifNum:longint; mL:TStrings;
begin
  If not ohGSCAT.Active then ohGSCAT.Open;
  If not ohGSCAT.LocateGsCode(pGsCode) then begin
    ShowMsg (eCom.GscIsNoExist,StrInt(pGsCode,0));
    Exit;
  end;
  mL:=TStringList.Create;
  mStk:=TStk.Create;
  If pStkNum>0 then mStk.StkNum:=pStkNum;
  If pStkNum=0 then mStk.StkNum:=ohOMH.StkNum;
  If pFifStr='' then begin
    mQnt:=pGsQnt;
    mRbaCode:=pRbaCode;
    mStk.ohFIF.LocateGcRc(pGsCode,pRbaCode);
    while not mStk.ohFIF.Eof and(mStk.ohFIF.GsCode=pGsCode) and(mQnt>0) and(mStk.ohFIF.RbaCode=pRbaCode) do
    begin
      If (mStk.ohFIF.Status='A' )then begin
        If mqnt>mStk.ohFIF.ActQnt
          then mStr:=mStr+'|'+IntToStr(mStk.ohFIF.FifNum)+'*'+StrDoub(mStk.ohFIF.ActQnt,0,5)
          else mStr:=mStr+'|'+IntToStr(mStk.ohFIF.FifNum)+'*'+StrDoub(mQnt,0,5);
        mQnt:=mQnt-mStk.ohFIF.ActQnt;
      end;
      mStk.ohFIF.Next;
    end;
    If mStr<>'' then begin
      Delete (mStr,1,1);
      mL.Add(mRbaCode+'='+mStr);
    end;
    mRbaCode:='';mStr:='';
    mStk.ohFIF.NearestGcRc(pGsCode,'');
    while not mStk.ohFIF.Eof and(mStk.ohFIF.GsCode=pGsCode) and(mQnt>0) do begin
      If mRbaCode<>mStk.ohFIF.RbaCode then begin
        If mStr<>'' then begin
          Delete (mStr,1,1);
          mL.Add(mRbaCode+'='+mStr);
        end;
        mRbaCode:=mStk.ohFIF.RbaCode;mStr:='';
      end;
      If (mStk.ohFIF.Status='A' )and(mStk.ohFIF.RbaCode='') then begin
        If mqnt>mStk.ohFIF.ActQnt
          then mStr:=mStr+'|'+IntToStr(mStk.ohFIF.FifNum)+'*'+StrDoub(mStk.ohFIF.ActQnt,0,5)
          else mStr:=mStr+'|'+IntToStr(mStk.ohFIF.FifNum)+'*'+StrDoub(mQnt,0,5);
        mQnt:=mQnt-mStk.ohFIF.ActQnt;
      end;
      mStk.ohFIF.Next;
    end;
    If mStr<>'' then begin
      Delete (mStr,1,1);
      mL.Add(mRbaCode+'='+mStr);
    end;
  end else begin
    mL.Clear;
    for mJ:=0 to LineElementNum(pFifStr,'|')-1 do begin
      mStr:=LineElement(pFifStr,mJ,'|');
      mFifNum:=ValInt(LineElement(mStr,0,'*'));
      mQnt:=ValDoub(LineElement(mStr,1,'*'));
      If mStk.ohFIF.LocateFifNum(mFifNum)
        then mRbaCode:=mStk.ohFIF.RbaCode;
      If mL.IndexOfName(mRbaCode)=-1
        then mL.Add(mRbaCode+'='+mStr)
        else mL.Values[mRbaCode]:=mL.Values[mRbaCode]+'|'+mStr;
    end;
  end;
  If mL.Count>0 then begin
    For mI:=0 to ml.Count-1 do begin
      mStk.FifLst.Clear;
      mRbaCode:=mL.Names[mI];
      mLine:=mL.Values[mRbaCode];
      mSQnt:=0;
      for mJ:=0 to LineElementNum(mLine,'|')-1 do begin
        mStr:=LineElement(mLine,mJ,'|');
        mFifNum:=ValInt(LineElement(mStr,0,'*'));
        mQnt:=ValDoub(LineElement(mStr,1,'*'));
        mSQnt:=mSQnt+mQnt;
        mStk.ohFIF.LocateFifNum(mFifNum);
        mStk.FifLst.Add(mFifNum,mQnt,mStk.ohFIF.InPrice,mStk.ohFIF.PaCode,
          mStk.ohFIF.AcqStat,mStk.ohFIF.RbaDate,mStk.ohFIF.RbaCode,mStk.ohFIF.ActPos);
      end;
      mItmNum := ohOMI.NextItmNum(ohOMH.DocNum);
      ohOMI.Insert;
      ohOMI.DocNum := ohOMH.DocNum;
      ohOMI.ItmNum := mItmNum;
      BTR_To_BTR(ohGSCAT.BtrTable,ohOMI.BtrTable);
      ohOMI.GsQnt := mSQnt;
      If mStk.ohFIF.RbaCode=''
        then ohOMI.RbaCode := pRbaCode
        else ohOMI.RbaCode := mStk.ohFIF.RbaCode;
      ohOMI.RbaDate := mStk.ohFIF.RbaDate;
//      ohOMI.DrbDate := mStk.ohFIF.DrbDate;
      ohOMI.BPrice := RoundFgABPrice(pFgBPrice);
      ohOMI.BValue := RoundFgABValue(pFgBPrice*mSQnt);
      ohOMI.AValue := RoundFgABValue(ohOMI.BValue/(1+ohOMI.VatPrc/100));
      ohOMI.StkNum := ohOMH.StkNum;
      ohOMI.DocDate := ohOMH.DocDate;
      ohOMI.StkStat := 'N';
      If pStkNum>0 then ohOMI.StkNum  := pStkNum;
  //    If pWriNum>0 then ohOMI.WriNum  := pWriNum;
      ohOMI.Post;
      ohOMH.Edit;
      ohOMH.RbaCode:= ohOMI.RbaCode;
      ohOMH.RbaDate:= ohOMI.RbaDate;
      ohOMH.Post;
      mStk.Clear;
      mStk.SmSign := '-';  // Vydaj tovaru
      mStk.DocNum := ohOMI.DocNum;
      mStk.ItmNum := ohOMI.ItmNum;
      mStk.DocDate := ohOMI.DocDate;
      mStk.GsCode := ohOMI.GsCode;
      mStk.MgCode := ohOMI.MgCode;
      mStk.BarCode := ohOMI.BarCode;
      mStk.SmCode := ohOMH.SmCode;
      mStk.GsName := ohOMI.GsName;
      mStk.GsQnt := mSQnt;
      mStk.MyOut;  // Vydá z príslušnej fifo karty
      ohOMI.Edit;
      ohOMI.StkStat := 'S';
      ohOMI.CValue := mStk.CValue;
      ohOMI.EValue := RoundCValue(ohOMI.CValue*(1+ohOmi.VatPrc/100));
      If mSQnt<>0 then ohOMI.CPrice := ohOMI.CValue/mSQnt;
      ohOMI.Post;
      pPxTable.Insert;
      BTR_To_PX(ohOMI.BtrTable,pPxTable); // Ulozi zaznam z btOMI do ptOMI
      pPxTable.Post;
    end;
  end else begin
    mItmNum := ohOMI.NextItmNum(ohOMH.DocNum);
    ohOMI.Insert;
    ohOMI.DocNum := ohOMH.DocNum;
    ohOMI.ItmNum := mItmNum;
    BTR_To_BTR(ohGSCAT.BtrTable,ohOMI.BtrTable);
    ohOMI.GsQnt := pGsQnt;
    ohOMI.RbaCode := pRbaCode;
    ohOMI.RbaDate := pRbaDate;
    ohOMI.StkNum := ohOMH.StkNum;
//    ohOMI.DrbDate := mStk.ohFIF.DrbDate;
    ohOMI.BPrice := RoundFgABPrice(pFgBPrice);
    ohOMI.BValue := RoundFgABValue(pFgBPrice*mSQnt);
    ohOMI.AValue := RoundFgABValue(ohOMI.BValue/(1+ohOMI.VatPrc/100));
    ohOMI.DocDate := ohOMH.DocDate;
    ohOMI.StkStat := 'N';
    If pStkNum>0 then ohOMI.StkNum  := pStkNum;
//    If pWriNum>0 then ohOMI.WriNum  := pWriNum;
    ohOMI.Post;
    ohOMH.Edit;
    ohOMH.RbaCode:= ohOMI.RbaCode;
    ohOMH.RbaDate:= ohOMI.RbaDate;
    ohOMH.Post;
    pPxTable.Insert;
    BTR_To_PX(ohOMI.BtrTable,pPxTable); // Ulozi zaznam z btOMI do ptOMI
    pPxTable.Post;
  end;
  ClcDoc;
  FreeAndNil(mStk);
end;

end.

{MOD 1809014}
{MOD 1810005}
{MOD 1902007}

