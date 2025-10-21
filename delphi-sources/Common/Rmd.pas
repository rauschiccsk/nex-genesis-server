unit Rmd;
{$F+}

// *****************************************************************************
//                               OBJEKT NA PRACU SO MP
// *****************************************************************************
// Programové funkcia:
// ---------------
// *****************************************************************************


interface

uses
  IcProgressBar, IcTypes, IcConst, IcConv, IcTools, IcValue, DocHand, SavClc,
  NexGlob, NexPath, NexMsg, NexError, NexPxTable,
  pBokLst,
  LinLst, Bok, Rep, Key, Stk, Plc, Spc, hGSCAT, hRMH, hRMI, tRMI,
  Controls, ComCtrls, SysUtils, Classes, Forms, MxArrays;

type
  PDat=^TDat;
  TDat=record
    rhRMH:TRmhHnd;
    rhRMI:TRmiHnd;
  end;

  TRmd = class(TComponent)
    constructor Create(AOwner: TComponent);
    destructor  Destroy; override;
    private
      oFrmName:Str15;
      oRmhClc:TStrings;
      oInd:TProgressBar;
      oBokNum:Str5;
      oLst:TList;
      oSpc:TSpc;
      function GetOpenCount:word;
      procedure Activate(pIndex:word); // Aktivuje databazu, ktora je otvorena pod poradovym cislom pIndex
    public
      ohRMH:TRmhHnd;
      ohRMI:TRmiHnd;
      otRMI:TRmiTmp;
      ohGSCAT:TGscatHnd;

      function ActBok:Str5;
      procedure Open(pBokNum:Str5); overload; // Otvori vsetky databazove subory
      procedure Open(pBokNum:Str5;pRMH,pRMI:boolean); overload;// Otvori zadane databazove subory
      procedure OpenLst(pBokLst:ShortString); // Otvori vsetky knihy ktore su zadane v retazci

      procedure NewDoc(pYear:Str2;pDescribe:Str30;pResDoc:boolean); // Vygeneruje novu hlavicku dokladu
      procedure DelDoc(pDocNum:Str12;pHedDel:boolean);  // Zrusi zadany doklad
      procedure ClcDoc; overload; // Prepocita hlavicku zadaneho dokladu podla jeho poloziek
      procedure ClcDoc(pDocNum:Str12); overload; // Prepocita hlavicku zadaneho dokladu podla jeho poloziek
      procedure PrnDoc(pDocNum:Str12); // Vytlaèí zadany dodaci list
      procedure ClcLst; // Prepocita hlavicky dokladov ktore su uvedene v zozname oImhClc
      procedure SlcItm(pDocNum:Str12); // nacita polozky zadaneho dokladu do PX
      procedure AddItm(pGsCode:longint;pGsQnt:double); overload; // Prida novu polozku na aktualny doklad
      procedure AddItm(pDocNum:Str12;pGsCode:longint;pGsQnt:double); overload; // Prida novu polozku na zadany doklad
      procedure AddRba(pGsCode:longint;pGsQnt,pDscPrc,pFgBPrice:double;pRbaCode:Str30;pRbaDate:TDate;pFifStr:String;pPxTable:TNexPxTable); // Prida novu polozku so sarzou na zadany dodaci list
      procedure SubItm; overload; // Presunie zadanu polozku
      procedure SubItm(pDocNum:Str12;pItmNum:longint); overload; // Presunie zadanu polozku
      procedure SubDoc(pDocNum:Str12;pPB_OmdGen:TIcProgressBar); // Presunieme polozky dokladu

      function UnsItm(pDocNum:Str12;pItmNum:longint):boolean; // Odskladni zadanu polozku
      function DelItm(pDocNum:Str12;pItmNum:longint):boolean; // Zrusi zadanu polozku
      procedure TmpRef(pDocNum:Str12;pItmNum:longint); // Obnovy zaznam na zaklade BTR
    published
      property BokNum:Str5 read oBokNum;
      property OpenCount:word read GetOpenCount;
      property Ind:TProgressBar read oInd write oInd;
  end;

implementation

uses bRMH, bRMI;

constructor TRmd.Create(AOwner: TComponent);
begin
  oFrmName:=AOwner.Name;
  ohGSCAT:=TGscatHnd.Create;
  oRmhClc:=TStringList.Create;  oRmhClc.Clear;
  oSpc:=TSpc.Create;
  oLst:=TList.Create;  oLst.Clear;
  otRMI:=TRmiTmp.Create;
  inherited;
end;

destructor TRmd.Destroy;
var I:word;
begin
  If oLst.Count>0 then begin
    For I:=1 to oLst.Count do begin
      Activate (I);
      FreeAndNil (ohRMI);
      FreeAndNil (ohRMH);
    end;
  end;
  FreeAndNil (oLst);
  FreeAndNil (oSpc);
  FreeAndNil (otRMI);
  FreeAndNil (oRmhClc);
  FreeAndNil (ohGSCAT);
  inherited;
end;

// ********************************* PRIVATE ***********************************

function TRmd.GetOpenCount:word;
begin
  Result:=oLst.Count;
end;

procedure TRmd.Activate(pIndex:word); // Aktivuje databazu, ktora je otvorena pod poradovym cislom pIndex
var mDat:PDat;
begin
  mDat:=oLst.Items[pIndex-1];
  ohRMH:=mDat.rhRMH;
  ohRMI:=mDat.rhRMI;
end;

// ********************************** PUBLIC ***********************************

function TRmd.ActBok:Str5;
begin
  Result:='';
  If ohRMH.BtrTable.Active
    then Result:=ohRMH.BtrTable.BookNum
    else begin
      If ohRMI.BtrTable.Active then Result:=ohRMI.BtrTable.BookNum;
    end;
end;

procedure TRmd.Open(pBokNum:Str5);  // Otvori vsetky databazove subory
begin
  Open(pBokNum,TRUE,TRUE);
end;

procedure TRmd.Open(pBokNum:Str5;pRMH,pRMI:boolean); // Otvori zadane databazove subory
var mFind:boolean;  mCnt:word;  mDat:PDat;
begin
  oBokNum:=pBokNum;
  mFind:=FALSE;
  If oLst.Count>0 then begin
    mCnt:=0;
    Repeat
      Inc (mCnt);
      Activate(mCnt);
      mFind:=ActBok=pBokNum;
    until mFind or (mCnt=oLst.Count);
  end;
  If not mFind then begin // Ak dana kniha este nie je otvorena potomotvorime
    // Vytvorime objekty
    ohRMH:=TRmhHnd.Create;
    ohRMI:=TRmiHnd.Create;
    // Otvorime databazove subory
    If pRMH then ohRMH.Open(pBokNum);
    If pRMI then ohRMI.Open(pBokNum);
    // Ulozime objekty do zoznamu
    GetMem (mDat,SizeOf(TDat));
    mDat^.rhRMH:=ohRMH;
    mDat^.rhRMI:=ohRMI;
    oLst.Add(mDat);
  end;
end;

procedure TRmd.OpenLst(pBokLst:ShortString); // Otvori vsetky knihy ktore su zadane v retazci
var mLinLst:TLinLst;
begin
  mLinLst:=TLinLst.Create;
  mLinLst.AddLst(pBokLst);
  If mLinLst.Count>0 then begin
    mLinLst.First;
    Repeat
      If gBok.BokExist('RMB',mLinLst.Itm,TRUE) then Open(mLinLst.Itm);
      Application.ProcessMessages;
      mLinLst.Next;
    until mLinLst.Eof;
  end;
  FreeAndNil (mLinLst);
end;

procedure TRmd.SlcItm(pDocNum:Str12); // Nacita polozky zadaneho dokladu do PX
begin
  If otRMI.Active then otRMI.Close;
  otRMI.Open;
  If ohRMH.LocateDocNum(pDocNum) then begin
    If ohRMI.LocateDocNum(pDocNum) then begin
      Repeat
        otRMI.Insert;
        BTR_To_PX (ohRMI.BtrTable,otRMI.TmpTable);
        otRMI.Post;
        Application.ProcessMessages;
        ohRMI.Next;
      until ohRMI.Eof or (ohRMI.DocNum<>pDocNum);
    end;
  end;
end;

procedure TRmd.AddItm(pGsCode:longint;pGsQnt:double);  // Prida novu polozku na aktualny doklad
var mItmNum:longint;
begin
  If not ohGSCAT.Active then ohGSCAT.Open;
  If ohGSCAT.LocateGsCode(pGsCode) then begin
    mItmNum:=ohRMI.NextItmNum(ohRMH.DocNum);
    ohRMI.Insert;
    ohRMI.DocNum:=ohRMH.DocNum;
    ohRMI.ItmNum:=mItmNum;
    BTR_To_BTR(ohGSCAT.BtrTable,ohRMI.BtrTable);
    ohRMI.GsQnt:=pGsQnt;
    ohRMI.ScStkNum:=ohRMH.ScStkNum;
    ohRMI.TgStkNum:=ohRMH.TgStkNum;
    ohRMI.ScSmCode:=ohRMH.ScSmCode;
    ohRMI.TgSmCode:=ohRMH.TgSmCode;
    ohRMI.DocDate:=ohRMH.DocDate;
    ohRMI.StkStat:='N';
    ohRMI.Post;
  end
  else ShowMsg (eCom.GscIsNoExist,StrInt(pGsCode,0));
end;

procedure TRmd.AddItm(pDocNum:Str12;pGsCode:longint;pGsQnt:double); // Prida novu polozku na zadany doklad
begin
  If ohRMH.LocateDocNum(pDocNum)
    then AddItm(pGsCode,pGsQnt)
    else ShowMsg(eCom.DocIsNoExist,pDocNum);
end;

procedure TRmd.ClcDoc; // Vytlaèí zadany dodaci list
begin
  ohRMH.Clc(ohRMI);
end;

procedure TRmd.ClcDoc(pDocNum:Str12); // Vytlaèí zadany dodaci list
begin
  If ohRMH.LocateDocNum(pDocNum) then ohRMH.Clc(ohRMI);
end;

procedure TRmd.PrnDoc(pDocNum:Str12); // Vytlaèí zadany dodaci list
var mRep:TRep;
begin
(*
  BokNum:=BookNumFromDocNum(pDocNum);
  If ohRMH.LocateDocNum(pDocNum) then begin
    mRep:=TRep.Create(Self);
    mRep.HedBtr:=ohRMH.BtrTable;
    mRep.ItmTmp :=
    mRep.Execute('IMD');
    FreeAndNil (mRep);
  end;
*)
end;

procedure TRmd.ClcLst; // Prepocita hlavicky zakazkovych dokladov ktore su uvedene v zozname oOchClc
var I:word;  mDocNum:Str12;
begin
  If oRmhClc.Count>0 then begin  // Mame doklady na prepocitanie
    For I:=0 to oRmhClc.Count-1 do begin
      mDocNum:=oRmhClc.Strings[I];
      Open(BookNumFromDocNum(mDocNum));
      ClcDoc(mDocNum);
    end
  end;
end;

procedure TRmd.NewDoc(pYear:Str2;pDescribe:Str30;pResDoc:boolean);  // Vygeneruje novu hlavicku dokladu
var mSerNum:longint;  mDocNum:Str12;  mhRMBLST:TBoklstTmp;
begin
  mhRMBLST:=TBoklstTmp.Create; mhRMBLST.Open;
  mhRMBLST.LoadToTmp('RMB');
  mhRMBLST.LocateBookNum(oBokNum);
  mSerNum:=ohRMH.NextSerNum(pYear); // Ak nie je zadane poradove cislo OD vygenerujeme nasledujuce
  mDocNum:=ohRMH.GenDocNum(pYear,oBokNum,mSerNum);
  If not ohRMH.LocateDocNum(mDocNum) then begin // Ak neexistuje vyvorime hlacicku dokladu OD
    ohRMH.Insert;
    ohRMH.DocNum:=mDocNum;
    ohRMH.SerNum:=mSerNum;
    ohRMH.Describe:=pDescribe;
    ohRMH.PlsNum:=1;
    ohRMH.ScStkNum:=gKey.RmbOutStn[mhRMBLST.BokNum];
    ohRMH.TgStkNum:=gKey.RmbIncStn[mhRMBLST.BokNum];
    ohRMH.ScSmCode:=gKey.RmbOutSmc[mhRMBLST.BokNum];
    ohRMH.TgSmCode:=gKey.RmbIncSmc[mhRMBLST.BokNum];
    ohRMH.DocDate:=Date;
    If pResDoc
      then ohRMH.DstLck:=9
      else ohRMH.DstLck:=0;
    ohRMH.Post;
  end;
  mhRMBLST.Close;FreeAndNil(mhRMBLST);
end;

procedure TRmd.DelDoc(pDocNum:Str12;pHedDel:boolean);  // Zrusi zadany doklad
begin
(*
  Result:=TRUE;
  If ohRMH.LocateDocNum(pDocNum) then begin
    If DocUnr(pDocNum) then begin
      If ohRMI.LocateDocNum(pDocNum) then begin
        Repeat
          Application.ProcessMessages;
          If ohRMI.StkStat='N'
            then ohRMI.Delete
            else begin
              Result:=FALSE;
              ohRMI.Next;
            end;
        until ohRMI.Eof or (ohRMI.Count=0) or (ohRMI.DocNum<>pDocNum);
      end;
    end;
    ohRMH.Clc(ohRMI);
    Result:=ohRMH.ItmQnt=0; // Je to v poriadku ak doklad nema ziadne polozky
    If Result and pHedDel then ohRMH.Delete;  // Ak je nastavene zrusenie hlavicky a bola vymazana kazda polozka zrusime hlavicku dokladu
  end;
*)
end;

procedure TRmd.SubItm; // Presunie zadanu polozku
begin
  SubItm(ohRMI.DocNum,ohRMI.ItmNum);
end;

procedure TRmd.SubItm(pDocNum:Str12;pItmNum:longint); // Presunie zadanu polozku
var mStk:TStk;
begin
  If ohRMH.LocateDocNum(pDocNum) then begin
    If ohRMI.LocateDoIt(pDocNum,pItmNum) then begin
      mStk:=TStk.Create;
      If ohRMI.StkStat='N' then begin  // Spravyme vydaj tovaru
        mStk.Clear;
        mStk.SmSign:='-';  // Vydaj tovaru
        mStk.DocNum:=ohRMI.DocNum;
        mStk.ItmNum:=ohRMI.ItmNum;
        mStk.DocDate:=ohRMI.DocDate;
        mStk.GsCode:=ohRMI.GsCode;
        mStk.MgCode:=ohRMI.MgCode;
        mStk.BarCode:=ohRMI.BarCode;
        mStk.SmCode:=ohRMH.ScSmCode;
        mStk.GsName:=ohRMI.GsName;
        mStk.GsQnt:=ohRMI.GsQnt;
        mStk.ConStk:=ohRMI.TgStkNum;
        If mStk.Sub(ohRMI.ScStkNum) then begin // Ak sa podarilo vydat polozky
          ohRMI.Edit;
          If IsNotNul(ohRMI.GsQnt) then ohRMI.CPrice:=mStk.CValue/ohRMI.GsQnt;
          ohRMI.CValue:=mStk.CValue;
          ohRMI.EValue:=RoundCValue(ohRMI.CValue*(1+ohRMI.VatPrc/100));
          ohRMI.StkStat:='O';
          ohRMI.Post;
        end;
//        If ohRMI.SrcPos<>'' then oSpc.Sub(ohRMH.ScStkNum,ohRMI.SrcPos,ohRMI.GsCode,ohRMI.DocNum,ohRMI.ItmNum,ohRMI.DocDate,ohRMI.GsQnt);
      end;
      If ohRMI.StkStat='O' then begin  // Spravyme prijem tovaru
        mStk.Clear;
        mStk.SmSign:='+';  // Prijem tovaru
        mStk.DocNum:=ohRMI.DocNum;
        mStk.ItmNum:=ohRMI.ItmNum;
        mStk.DocDate:=ohRMI.DocDate;
        mStk.GsCode:=ohRMI.GsCode;
        mStk.MgCode:=ohRMI.MgCode;
        mStk.BarCode:=ohRMI.BarCode;
        mStk.SmCode:=ohRMH.TgSmCode;
        mStk.GsName:=ohRMI.GsName;
        mStk.GsQnt:=ohRMI.GsQnt;
        mStk.CPrice:=ohRMI.CPrice;
        If mStk.Sub(ohRMI.TgStkNum) then begin // Ak sa podarilo vydat polozky
          ohRMI.Edit;
          ohRMI.StkStat:='S';
          ohRMI.Post;
        end;
//        If ohRMI.TrgPos<>'' then oSpc.Sub(ohRMH.TgStkNum,ohRMI.TrgPos,ohRMI.GsCode,ohRMI.DocNum,ohRMI.ItmNum,ohRMI.DocDate,ohRMI.GsQnt*(-1));
      end;
      FreeAndNil (mStk);
    end;
  end;
end;

function TRmd.UnsItm(pDocNum:Str12;pItmNum:longint):boolean; // Odskladni zadanu polozku
var mStk:TStk;
begin
  Result:=TRUE;
  If ohRMH.LocateDocNum(pDocNum) then begin
    If ohRMI.LocateDoIt(pDocNum,pItmNum) then begin
      mStk:=TStk.Create;
      If ohRMI.StkStat='S' then begin
        If mStk.Uns(ohRMI.TgStkNum,ohRMI.DocNum,ohRMI.ItmNum) then begin // Zrusime skladovy prijem
          ohRMI.Edit;
          ohRMI.StkStat:='O';
          ohRMI.Post;
        end
        else Result:=FALSE;
      end;
      If ohRMI.StkStat='O' then begin
        If mStk.Uns(ohRMI.ScStkNum,ohRMI.DocNum,ohRMI.ItmNum) then begin // Zrusime skladovy vydaj
          ohRMI.Edit;
          ohRMI.CValue:=0;
          ohRMI.EValue:=0;
          ohRMI.StkStat:='N';
          ohRMI.Post;
        end
        else Result:=FALSE;
      end;
      FreeAndNil (mStk);
    end;
  end;
end;

function TRmd.DelItm(pDocNum:Str12;pItmNum:longint):boolean; // Zrusi zadanu polozku
begin
  Result:=FALSE;
  ohRMI.LocateDoIt(pDocNum,pItmNum);
  If (ohRMI.TrgPos<>'') then oSpc.StkNum:=ohRMH.TgStkNum;
  If (ohRMI.TrgPos='') or
  ((ohRMI.TrgPos<>'') and oSpc.ohSPC.LocatePoGs(ohRMI.TrgPos,ohRMI.GsCode) and (oSpc.ohSPC.ActQnt>=ohRmi.GsQnt))
  then begin
    If UnsItm(pDocNum,pItmNum) then begin
//      If ohRMI.SrcPos<>'' then oSpc.Del(ohRMH.ScStkNum,ohRMI.SrcPos,ohRMI.GsCode,ohRMI.DocNum,ohRMI.ItmNum);
//      If ohRMI.TrgPos<>'' then oSpc.Del(ohRMH.TgStkNum,ohRMI.TrgPos,ohRMI.GsCode,ohRMI.DocNum,ohRMI.ItmNum);
      ohRMI.Delete;
      If otRMI.Active then otRMI.Delete;
      Result:=TRUE;
    end;
  end;
end;

procedure TRmd.TmpRef(pDocNum:Str12;pItmNum:longint); // Obnovy zaznam na zaklade BTR
begin
  If ohRMI.LocateDoIt(pDocNum,pItmNum) then begin
    If otRMI.LocateDoIt(ohRMI.DocNum,ohRMI.ItmNum)
      then otRMI.Edit
      else otRMI.Insert;
    BTR_To_PX (ohRMI.BtrTable,otRMI.TmpTable);
    otRMI.Post;
  end;
end;

procedure TRmd.SubDoc;
var mStk:TStk;

      procedure Sub_Item;
      begin
        try
          If ohRMI.StkStat='N' then begin  // Spravyme vydaj tovaru
            mStk.Clear;
            mStk.SmSign:='-';  // Vydaj tovaru
            mStk.DocNum:=ohRMI.DocNum;
            mStk.ItmNum:=ohRMI.ItmNum;
            mStk.DocDate:=ohRMI.DocDate;
            mStk.GsCode:=ohRMI.GsCode;
            mStk.MgCode:=ohRMI.MgCode;
            mStk.BarCode:=ohRMI.BarCode;
            mStk.SmCode:=ohRMH.ScSmCode;
            mStk.GsName:=ohRMI.GsName;
            mStk.GsQnt:=ohRMI.GsQnt;
            mStk.ConStk:=ohRMI.TgStkNum;
            If mStk.Sub(ohRMI.ScStkNum) then begin // Ak sa podarilo vydat polozky
              ohRMI.Edit;
              If IsNotNul(ohRMI.GsQnt) then ohRMI.CPrice:=mStk.CValue/ohRMI.GsQnt;
              ohRMI.CValue:=mStk.CValue;
              ohRMI.EValue:=RoundCValue(ohRMI.CValue*(1+ohRMI.VatPrc/100));
              ohRMI.StkStat:='O';
              ohRMI.Post;
            end;
//            If ohRMI.SrcPos<>'' then oSpc.Sub(ohRMH.ScStkNum,ohRMI.SrcPos,ohRMI.GsCode,ohRMI.DocNum,ohRMI.ItmNum,ohRMI.DocDate,ohRMI.GsQnt);
          end;
          If ohRMI.StkStat='O' then begin  // Spravyme prijem tovaru
            mStk.Clear;
            mStk.SmSign:='+';  // Prijem tovaru
            mStk.DocNum:=ohRMI.DocNum;
            mStk.ItmNum:=ohRMI.ItmNum;
            mStk.DocDate:=ohRMI.DocDate;
            mStk.GsCode:=ohRMI.GsCode;
            mStk.MgCode:=ohRMI.MgCode;
            mStk.BarCode:=ohRMI.BarCode;
            mStk.SmCode:=ohRMH.TgSmCode;
            mStk.GsName:=ohRMI.GsName;
            mStk.GsQnt:=ohRMI.GsQnt;
            mStk.CPrice:=ohRMI.CPrice;
            If mStk.Sub(ohRMI.TgStkNum) then begin // Ak sa podarilo vydat polozky
              ohRMI.Edit;
              ohRMI.StkStat:='S';
              ohRMI.Post;
            end;
//            If ohRMI.TrgPos<>'' then oSpc.Sub(ohRMH.TgStkNum,ohRMI.TrgPos,ohRMI.GsCode,ohRMI.DocNum,ohRMI.ItmNum,ohRMI.DocDate,ohRMI.GsQnt*(-1));
          end;
        finally
        end
      end;
      // end procedure Sub_Item

begin
  try
    mStk:=TStk.Create;
    If ohRMH.LocateDocNum(pDocNum) then begin
      If ohRMI.NearestDoIt(pDocNum,1) and (ohRMI.DocNum=pDocNum) then begin
        repeat
          Sub_Item;
          pPB_OmdGen.StepBy(1);
          Application.ProcessMessages;
          ohRMI.Next;
        until ohRMI.Eof or (ohRMI.DocNum<>pDocNum);
      end;
    end;
  finally
    FreeAndNil (mStk);
  end;
end;

procedure TRmd.AddRba(pGsCode: Integer; pGsQnt, pDscPrc, pFgBPrice: double;
  pRbaCode: Str30; pRbaDate: TDate; pFifStr: String; pPxTable: TNexPxTable);
var mJ,mI,mItmNum:word; mStk:TStk; mStk2:TStk; mQnt,mSQnt:double; mRbaCode,mLine,mStr:String;
    mFifNum:longint; mL:TStrings;
begin
  If not ohGSCAT.Active then ohGSCAT.Open;
  If not ohGSCAT.LocateGsCode(pGsCode) then begin
    ShowMsg (eCom.GscIsNoExist,StrInt(pGsCode,0));
    Exit;
  end;
  mL:=TStringList.Create;
  mStk:=TStk.Create;mStk2:=TStk.Create;
  mStk.StkNum:=ohRMH.ScStkNum;
  mStk2.StkNum:=ohRMH.TgStkNum;
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
      mRbaCode:=mL.Names[mI];
      mLine:=mL.Values[mRbaCode];
      mSQnt:=0;
      mStk.FifLst.Clear;
      for mJ:=0 to LineElementNum(mLine,'|')-1 do begin
        mStr:=LineElement(mLine,mJ,'|');
        mFifNum:=ValInt(LineElement(mStr,0,'*'));
        mQnt:=ValDoub(LineElement(mStr,1,'*'));
        mSQnt:=mSQnt+mQnt;
        mStk.ohFIF.LocateFifNum(mFifNum);
        mStk.FifLst.Add(mFifNum,mQnt,mStk.ohFIF.InPrice,mStk.ohFIF.PaCode,
          mStk.ohFIF.AcqStat,mStk.ohFIF.RbaDate,mStk.ohFIF.RbaCode,mStk.ohFIF.ActPos);
      end;
      mItmNum:=ohRMI.NextItmNum(ohRMH.DocNum);
      ohRMI.Insert;
      BTR_To_BTR(ohGSCAT.BtrTable,ohRMI.BtrTable);
      BTR_To_BTR(ohRMH.BtrTable,ohRMI.BtrTable);
      ohRMI.DocNum:=ohRMH.DocNum;
      ohRMI.ItmNum:=mItmNum;
      ohRMI.GsQnt:=mSQnt;
      If mStk.ohFIF.RbaCode=''
        then ohRMI.RbaCode:=pRbaCode
        else ohRMI.RbaCode:=mStk.ohFIF.RbaCode;
      ohRMI.RbaDate:=mStk.ohFIF.RbaDate;
      ohRMI.BPrice:=RoundFgABPrice(pFgBPrice);
      ohRMI.BValue:=RoundFgABValue(pFgBPrice*mSQnt);
      ohRMI.AValue:=RoundFgABValue(ohRMI.BValue/(1+ohRMI.VatPrc/100));
      ohRMI.DocDate:=ohRMH.DocDate;
      ohRMI.StkStat:='N';
      ohRMI.Post;

      ohRMH.Edit;
      ohRMH.RbaCode:= ohRMI.RbaCode;
      ohRMH.RbaDate:= ohRMI.RbaDate;
      ohRMH.Post;

      mStk.Clear;
      mStk.SmSign:='-';  // Vydaj tovaru
      mStk.DocNum:=ohRMI.DocNum;
      mStk.ItmNum:=ohRMI.ItmNum;
      mStk.DocDate:=ohRMI.DocDate;
      mStk.GsCode:=ohRMI.GsCode;
      mStk.MgCode:=ohRMI.MgCode;
      mStk.BarCode:=ohRMI.BarCode;
      mStk.SmCode:=ohRMH.ScSmCode;
      mStk.GsName:=ohRMI.GsName;
      mStk.GsQnt:=mSQnt;
      mStk.MyOut;  // Vydá z príslušnej fifo karty

      ohRMI.Edit;
      ohRMI.StkStat:='O';
      ohRMI.CValue:=mStk.CValue;
      ohRMI.EValue:=RoundCValue(ohRMI.CValue*(1+ohRMI.VatPrc/100));
      If mSQnt<>0 then ohRMI.CPrice:=ohRMI.CValue/mSQnt;
      ohRMI.Post;

      If ohRMI.StkStat='O' then begin  // Spravyme prijem tovaru
        mStk2.Clear;
        mStk2.SmSign:='+';  // Prijem tovaru
        mStk2.DocNum:=ohRMI.DocNum;
        mStk2.ItmNum:=ohRMI.ItmNum;
        mStk2.DocDate:=ohRMI.DocDate;
        mStk2.GsCode:=ohRMI.GsCode;
        mStk2.MgCode:=ohRMI.MgCode;
        mStk2.BarCode:=ohRMI.BarCode;
        mStk2.SmCode:=ohRMH.TgSmCode;
        mStk2.GsName:=ohRMI.GsName;
        mStk2.GsQnt:=ohRMI.GsQnt;
        mStk2.CPrice:=ohRMI.CPrice;
        mStk2.RbaDate:= ohRMI.RbaDate;
        mStk2.RbaCode:= ohRMI.RbaCode;
        If mStk2.Sub(ohRMI.TgStkNum) then begin // Ak sa podarilo vydat polozky
          ohRMI.Edit;
          ohRMI.StkStat:='S';
          ohRMI.Post;
        end;
//        If ohRMI.TrgPos<>'' then oSpc.Sub(ohRMH.TgStkNum,ohRMI.TrgPos,ohRMI.GsCode,ohRMI.DocNum,ohRMI.ItmNum,ohRMI.DocDate,ohRMI.GsQnt*(-1));
      end;

      pPxTable.Insert;
      BTR_To_PX(ohRMI.BtrTable,pPxTable); // Ulozi zaznam z btRMI do ptRMI
      pPxTable.Post;
    end;
  end else begin
    mItmNum:=ohRMI.NextItmNum(ohRMH.DocNum);
    ohRMI.Insert;
    BTR_To_BTR(ohRMH.BtrTable,ohRMI.BtrTable);
    ohRMI.DocNum:=ohRMH.DocNum;
    ohRMI.ItmNum:=mItmNum;
    BTR_To_BTR(ohGSCAT.BtrTable,ohRMI.BtrTable);
    ohRMI.GsQnt:=pGsQnt;
    ohRMI.RbaCode:=pRbaCode;
    ohRMI.RbaDate:=pRbaDate;
    ohRMI.BPrice:=RoundFgABPrice(pFgBPrice);
    ohRMI.BValue:=RoundFgABValue(pFgBPrice*mSQnt);
    ohRMI.AValue:=RoundFgABValue(ohRMI.BValue/(1+ohRMI.VatPrc/100));
    ohRMI.DocDate:=ohRMH.DocDate;
    ohRMI.StkStat:='N';
    ohRMI.Post;

    ohRMH.Edit;
    ohRMH.RbaCode:= ohRMI.RbaCode;
    ohRMH.RbaDate:= ohRMI.RbaDate;
    ohRMH.Post;

    pPxTable.Insert;
    BTR_To_PX(ohRMI.BtrTable,pPxTable); // Ulozi zaznam z btRMI do ptRMI
    pPxTable.Post;
  end;
  ohRMH.Clc(ohRMI);
  FreeAndNil(mStk);
  FreeAndNil(mStk2);
end;

end.
{MOD 1810002}
{MOD 1810005}
