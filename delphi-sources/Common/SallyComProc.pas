unit SallyComProc;

interface

uses
  TxtFile,
  IcConst, IcTools, Icconv, IcDate, IcTypes, IcVariab, Btrtools,
  NexGlob, NexIni, NexText, NexPath,
  Crd, Adv, TxtWrap, TxtCut, DocHand, Tcd, Key, Htl,
  hCabLst, hCrdLst, hStkLst, hStk, hCrdTrn, hCrdBon, hPab, hCtyLst, hStaLst,
  hSpbLSt, hSpd, hGsCat, hSts,
  hCAH, hTnv, hTns, hTnh, hROL, hColItm,
  IniFiles, SysUtils, Classes, SallyComGlobal, Forms;

  procedure GetBonAct (pCusCard:string; var pBonAct, pTrnNeb , pTrnBon:double; var pErr:longint);
  procedure GetDepAct (pPaCode:longint; var pDepData:TDepData; var pErr:longint);
  procedure GetGsQnt  (pGsCode:longint; pStkNums:string; var pQnts:string; var pErr:longint);
  procedure SaveActTurn(pActTurn:TActTurn);
  procedure SaveBonInc (pCasNum,pIntDocNum:longint; pDate:TDateTime; pCusCard:string; pDocVal, pBonus: double; pType:string);
  // pType : V (Value) G (Goods)
  procedure SaveBonExp (pCasNum,pIntDocNum:longint; pDate:TDateTime; pCusCard:string; pBonus: double);
  procedure SaveDepInc (pCasNum,pPaCode,pIntDocNum:longint; pDate:TDateTime; pDepData:TDepData; pSrcDoc:Str12);
  procedure SaveDepExp (pCasNum,pPaCode,pIntDocNum:longint; pDate:TDateTime; pDepData:TDepData);

  procedure MakeGsSub (pGsData:string; var pWorkCnt:longint);
  { StkNum;CasNum;Date;GsCode;Qnt }

  // Hotelovy a rezervacny system
  function  GetTnvLst : string;
  {TentNum;RoomNum;VisNum;VisName;RoomCode|TentNum2;RoomNum2;VisNum2;VisName2;RoomCode2|.....}
  {Ubytov.; Izba  ; Host c.;  Meno hosta}
  procedure AddToTNS  (pData:string;   var pWorkCnt:longint);
  { TentNum;RoomNum;VisNum;GsCode;Qnt;BValue;BPrice}
  {Ubytov.; Izba  ; Host c.; PLU ;Mnozstvo;Hodnota s DPH;PC s DPH; Sklad; Prevádzka; Pokladòa; Pokladník; dátum uloženia; èas uloženia}
  procedure CasTcdGen(pCasNum:longint; pFileName:String; var pDocNum:Str12);
  procedure WriteToTCDErr (pFileName, pLn:string);
  procedure PabImp  (pData:string;pSeparator,pDelimiter:Str1;pFldLst:string;   var pWorkCnt:longint);
  { Fields=PaCode=1;PaName=2;Ino=3;Tin=4;Vin=5;IdCode=6;Addr=7;Ctn=8;Zip=9;Sta=10;DscPrc=11
  -  Delimiter default ; - Separator default - niè
  - Zoznam polí pre NEX:
     PaCode=1 PaName=2 RegName=2 SmlName=2 RegIno=3 RegTin=4  RegVin=5 RegAddr=7 RegCtn=8 RegZip=9 RegSta=10
     CrpAddr=7 CrpCtn=8 CrpZip=9 CrpSta=10 IvcAddr=7 IvcCtn=8 IvcZip=9 IvcSta=10 IcDscPrc=11 IdCode=6 }

  procedure CrdModDate  (pCusCard:string; pDate:TDateTime);
  procedure CrdImp  (pData:string;pSeparator,pDelimiter:Str1;pFldLst:string;   var pWorkCnt:longint);
  { Fields=CardNum=1;IDNum=2;Name=3;CrdType=4;DscPrc=5;TrnBon=6;Grp=7;PaCode=8;PaName=9;ValidFrom=10;ValidTo=11
  -  Delimiter default ; - Separator default - niè
  - Zoznam polí pre NEX:
CrdNum=1 CrdName=3 PaCode=8 PaName=9 BegDate=10  - ak nie je zadaný dátum, tak je prázdné EndDate=11  - ak nie je zadaný dátum, tak je prázdné
CrdType=4 DscPrc=5 TrnBon=6 CrdGrp=7 IdcNum=2 }
  procedure SaveCrdToCas(phCrdLst:TCrdLstHnd);
  procedure SavePabToCas(phPab:TPabHnd);


implementation

uses bTNS, bCRDLST, bSPBLST, bSPD, bTNV, bPAB, bCTYLST, bStalst, bTCH, bTCI, bCOLITM;

function  GetTnvLst;
var mhROL:TRolHnd;mhTnv:TTnvHnd;mS:TStrings;
begin
  // TNV.BDF ROL.BDF fmd
  mS:=TStringList.Create;
  mhTnv:=TTnvHnd.Create;mhTnv.Open;
  mhROL:=TRolHnd.Create;mhROL.Open;
  mhTnv.LocateStatus('U');
  while not mhTnv.Eof and (mhTnv.Status='U') do begin
    If (mhTnv.DateO>=Date) then
    begin
      If mhROL.LocateRoomNum(mhTnv.RoomNum)
        then mS.Add(IntToStr(mhTnv.TentNum)+';'+IntToStr(mhTnv.RoomNum)+';'+IntToStr(mhTnv.VisNum)+';'+mhTnv.VisName+';'+mhROL.RoomCode)
        else mS.Add(IntToStr(mhTnv.TentNum)+';'+IntToStr(mhTnv.RoomNum)+';'+IntToStr(mhTnv.VisNum)+';'+mhTnv.VisName+';');
    end;
    mhTnv.Next;
  end;
  Result:=mS.Text;
  mS.Free;
  FreeAndNil(mhTnv);
  FreeAndNil(mhROL);
end;

procedure GetBonAct (pCusCard:string; var pBonAct, pTrnNeb , pTrnBon:double; var pErr:longint);
var mhCRDLST:TCrdlstHnd; mhPAB:TPabHnd;
begin
  mhCRDLST:=TCrdlstHnd.Create;  mhCRDLST.Open;
  mhPAB:=TPabHnd.Create;  mhPAB.Open(0);
  pBonAct:=0;  pTrnNeb:=0;  pTrnBon:=0;  pErr:=1;
  If mhCrdLst.LocateCrdNum(pCusCard) then begin
    pTrnBon:=mhCrdLst.BonTrn;
    If mhPAB.LocatePaCode(mhCrdLst.PaCode) and ((mhPAB.SaDisStat=1) or(mhPAB.BuDisStat=1))
      then pErr:=2
      else pErr:=0;
    pBonAct:=mhCrdLst.ActBon;
    If mhCrdLst.BonTrn=0 then mhCrdLst.BonTrn:=gKey.CrdTrnBon;
//    pSumVal:=mhCrdLst.TrnSum - Trunc(mhCrdLst.TrnSum/mhCrdLst.TrnBon)*mhCrdLst.TrnBon;
    pTrnNeb:=mhCrdLst.NebVal;
  end;
  FreeAndNil(mhCrdLst);FreeAndNil(mhPAB);

//  pErr:=0; //OK
//  pErr:=1; //Not exist
//  pErr:=2; //Disabled

//  3 - centrálne karta ešte nie je platná
//  4 - centrálne karta je po splatnosti
end;

procedure GetDepAct (pPaCode:longint; var pDepData:TDepData; var pErr:longint);
var mhSpbLst:TSpblstHnd; mhPAB:TPabHnd; I:longint;
begin
  For I:=1 to 5 do
    pDepData[I].DepVal:=0;
  pErr:=0;
  mhSpbLst:=TSpblstHnd.Create;mhSpbLst.Open;
  mhPAB:=TPabHnd.Create;mhPAB.Open(0);
  If mhSpbLst.LocatePaCode(pPaCode) then begin
    If mhPAB.LocatePaCode(pPaCode) and ((mhPAB.SaDisStat=1) or(mhPAB.BuDisStat=1))
      then pErr:=2
      else pErr:=0;
    pDepData[1].VatPrc:=mhSpbLst.VatPrc1;
    pDepData[1].DepVal:=mhSpbLst.IncVal1+mhSpbLst.ExpVal1;
    pDepData[2].VatPrc:=mhSpbLst.VatPrc2;
    pDepData[2].DepVal:=mhSpbLst.IncVal2+mhSpbLst.ExpVal2;
    pDepData[3].VatPrc:=mhSpbLst.VatPrc3;
    pDepData[3].DepVal:=mhSpbLst.IncVal3+mhSpbLst.ExpVal3;
    pDepData[4].VatPrc:=mhSpbLst.VatPrc4;
    pDepData[4].DepVal:=mhSpbLst.IncVal4+mhSpbLst.ExpVal4;
    pDepData[5].VatPrc:=mhSpbLst.VatPrc5;
    pDepData[5].DepVal:=mhSpbLst.IncVal5+mhSpbLst.ExpVal5;
  end;
  FreeAndNil(mhSpbLst);FreeAndNil(mhPAB);
(*
  pErr:=0; //OK
  pErr:=1; //Not exist
  pErr:=2; //Disabled
*)
end;

procedure GetGsQnt (pGsCode:longint; pStkNums:string; var pQnts:string; var pErr:longint);
var mhStk:TStkHnd;mhstklst:TStklstHnd;mI:byte;
begin
  pErr:=0;
  mhStk:=TStkHnd.Create;
  mhstklst:=TStklstHnd.Create;mhstklst.Open;
  pQnts:='';
  For mI:=0 to LineElementNum(pStkNums,',')-1 do begin
    mhStk.Open(ValInt(LineElement(pStkNums,mI,',')));
    If mhStk.LocateGsCode(pGsCode)
      then pQnts:=pQnts+','+StrDoub(mhStk.FreQnt,0,3)
      else pQnts:=pQnts+',';
  end;
  If pQnts<>'' then system.Delete(pQnts,1,1);
  FreeAndNil(mhStk);FreeAndNil(mhstklst);
(*
  pErr:=0; //OK
  pErr:=1; //Not exist
  pErr:=2; //Disabled
*)
end;

procedure SaveActTurn (pActTurn:TActTurn);
var mhCAH:TCahHnd; mI:byte;
begin
  //Zapísanie aktuálneho stavu
  If pActTurn.CasNum>0 then begin
    mhCAH:=TCahHnd.Create;mhCAH.Open(pActTurn.CasNum);
    If mhCAH.LocateDocDate(pActTurn.ActDate) then mhCAH.Edit else mhCAH.Insert;
    // CAH.BDF
    mhCAH.DocDate   :=pActTurn.ActDate;
//    mhCah.UserName  :=pActTurn.UserName
    for mI:=0 to 9  do begin
//      mhCah.DBegVal[0]:=pActTurn.DBegVal[0]
      mhCah.BegVal_[mI]:=pActTurn.BegVal[mI];
      mhCah.TrnVal_[mI]:=pActTurn.TrnVal[mI];
      mhCah.ExpVal_[mI]:=pActTurn.ExpVal[mI];
      mhCah.ChIVal_[mI]:=pActTurn.ChIVal[mI];
      mhCah.ChEVal_[mI]:=pActTurn.ChOVal[mI];
      mhCah.IncVal_[mI]:=pActTurn.IncVal[mI];
//      mhCah.EndVal_[mI]:=pActTurn.EndVal[mI];
    end;
//    mhCah.PaidAdv_ (mI,pActTurn.PaidAdv[0]
//    mhCah.UsedAdv_ (mI,pActTurn.UsedAdv[0]
//    mhCah.IncValFM_(mI,pActTurn.IncValFM[0]
//    mhCah.NotToRet  :=ActTurn.NotToRet
    mhCAH.Post;
    FreeAndNil(mhCAH);
  end;
end;

procedure SaveBonInc(pCasNum,pIntDocNum:longint; pDate:TDateTime; pCusCard:string; pDocVal, pBonus: double; pType:string);
var mCrd:TCrd; mDocNum:Str12;
begin
  mDocNum:='ER'+StrIntZero(pCasNum,3)+StrIntZero(pIntDocNum,7);
  mCrd:=TCrd.Create;
  mCrd.AddDoc(pCusCard,mDocNum,pDate,pDate,pDocVal);
  mCrd.ClcCrd(pCusCard);
  FreeAndNil(mCrd);

(* RZ
  If pType='V' then begin
    // Hodnotovy Bonus TOD cas_F
    mCrdTrn:=TCrdTrn.Create;
    mCrdTrn.CrdNum :=pCusCard;
    mCrdTrn.BlkNum :=StrIntZero(pCasNum,3)+StrIntZero(pIntDocNum,7);
    mCrdTrn.BlkDate:=pDate;
    mCrdTrn.BlkTime:=pDate;
    mCrdTrn.BlkVal :=pDocVal;
    mCrdTrn.Add(FALSE);  // nevytvori subor C*.CRD
    FreeAndNil(mCrdTrn);
  end else begin
    // Bonus podla tovarov
  end;
*)
end;

procedure SaveBonExp (pCasNum,pIntDocNum:longint; pDate:TDateTime; pCusCard:string; pBonus: double);
var mCrd:TCrd; mhCRDBON: TCrdbonHnd; mSerNum:word;
begin
  mhCRDBON:=TCrdbonHnd.Create; mhCRDBON.Open;
  mCrd:=TCrd.Create;
  mSerNum:=mhCRDBON.NextSerNum;
  mhCRDBON.Insert;
  mhCRDBON.CrdNum :=pCusCard;
  mhCRDBON.SerNum :=mSerNum;
  mhCRDBON.OutDate:=pDate;
  mhCRDBON.OutQnt :=Round(pBonus);
  mhCRDBON.Post;
  mCrd.ClcCrd(pCusCard); // Prepocitame vydane bonusy na základe historie
  FreeAndNil(mCrd);
  FreeAndNil (mhCRDBON);
end;

procedure SaveDepInc (pCasNum,pPaCode,pIntDocNum:longint; pDate:TDateTime; pDepData:TDepData;pSrcDoc:Str12);
var mhSPD:TSpdHnd; mhSPBLST:TSpblstHnd; mhPAB:TPabHnd; mDescribe,mVatDoc:Str12; mSpdSn,mSpdIn:longint;
    mhGSCAT:TGscatHnd; mVat: array[1..5] of longint; I:longint; mFind:boolean; mS:String;
begin
  mhPAB:=TPabHnd.Create; mhPAB.Open(0);
  If mhPAB.LocatePaCode(pPaCode) then begin
    mhGSCAT:=TGscatHnd.Create;mhGSCAT.Open;
    mhSpbLst:=TSpblstHnd.Create;mhSpbLst.Open;
    mhSPD:=TSpdHnd.Create;mhSPD.Open(pPaCode);
    If not mhSpbLst.LocatePaCode(pPaCode) then begin
      mhSpbLst.Insert;
      BTR_To_BTR(mhPab.BtrTable,mhSpbLst.BtrTable);
      mhSPBLST.VatPrc1:=gIni.GetVatPrc(1);
      mhSPBLST.VatPrc2:=gIni.GetVatPrc(2);
      mhSPBLST.VatPrc3:=gIni.GetVatPrc(3);
      mhSPBLST.VatPrc4:=gIni.GetVatPrc(4);
      mhSPBLST.VatPrc5:=gIni.GetVatPrc(5);
      mhSPBLST.VatPrc6:=gIni.GetVatPrc(6);
      mhSPBLST.Post;
    end;
    mVatDoc:='ECR'+DateToFileName(pDate)+StrIntZero(pCasNum,3);
    mDescribe:=IntToStr(pCasNum)+'/'+IntToStr(pIntDocNum);
    mFind:=False;
    If (pSrcDoc<>'') and (GetDocType(pSrcDoc)=dtTO) then begin
      mFind:=mhSpd.LocateConDoc(pSrcDoc);
    end else begin
      If mhSPD.LocateDescribe(mDescribe) then mFind:=mhSPD.ConDoc=mVatDoc;
      While not mFind and not mhSpd.Eof and (mhSPD.Describe=mDescribe) do begin
        mFind:=(mhSPD.ConDoc=mVatDoc) and (mhSPD.Describe=mDescribe);
        mhSPD.Next;
      end;
    end;
    If not mFind then begin
      mFind:=False;
      mhSpbLst.Edit;
      For I:=1 to 5 do begin
        If (pDepData[I].GsCode>0) and IsNotNul (pDepData[I].DepVal) and (pDepData[I].VatPrc<100) then begin
          mFind:=FALSE;
          If pDepData[I].VatPrc=mhSpbLst.VatPrc1 then begin
            mFind:=TRUE;
            mhSpbLst.IncVal1:=mhSpbLst.IncVal1+pDepData[I].DepVal;
            mhSpbLst.PrfVal1:=mhSpbLst.PrfVal1+pDepData[I].DepVal;
          end;
          If not mFind and (pDepData[I].VatPrc=mhSpbLst.VatPrc2) then begin
            mFind:=TRUE;
            mhSpbLst.IncVal2:=mhSpbLst.IncVal2+pDepData[I].DepVal;
            mhSpbLst.PrfVal2:=mhSpbLst.PrfVal2+pDepData[I].DepVal;
          end;
          If not mFind and (pDepData[I].VatPrc=mhSpbLst.VatPrc3) then begin
            mFind:=TRUE;
            mhSpbLst.IncVal3:=mhSpbLst.IncVal3+pDepData[I].DepVal;
            mhSpbLst.PrfVal3:=mhSpbLst.PrfVal3+pDepData[I].DepVal;
          end;
          If not mFind and (pDepData[I].VatPrc=mhSpbLst.VatPrc4) then begin
            mFind:=TRUE;
            mhSpbLst.IncVal4:=mhSpbLst.IncVal4+pDepData[I].DepVal;
            mhSpbLst.PrfVal4:=mhSpbLst.PrfVal4+pDepData[I].DepVal;
          end;
          If not mFind and (pDepData[I].VatPrc=mhSpbLst.VatPrc5) then begin
            mFind:=TRUE;
            mhSpbLst.IncVal5:=mhSpbLst.IncVal5+pDepData[I].DepVal;
            mhSpbLst.PrfVal5:=mhSpbLst.PrfVal5+pDepData[I].DepVal;
          end;
          If not mFind then begin
            If not DirectoryExists(gPath.BckPath+'LOGS\ERRS\')
              then ForceDirectories(gPath.BckPath+'LOGS\ERRS\');
            mS:='Prijem zalohovej platby;Neexistujuca sadzba '+IntToStr(pDepData[I].VatPrc)+';'
            +IntToStr(pCasNum)+';'+IntToStr(pPaCode)+';'+IntToStr(pIntDocNum)+';'+
            dateToStr(pDate)+';'+IntToStr(pDepData[I].GsCode)+';';
            WriteToLogFile(gPath.BckPath+'LOGS\ERRS\NCS.ERR',mS);
          end;
        end;
      end;
      mhSpbLst.IncVal :=mhSpbLst.IncVal1+mhSpbLst.IncVal2+mhSpbLst.IncVal3+mhSpbLst.IncVal4+mhSpbLst.IncVal5;
      mhSpbLst.EndVal :=mhSpbLst.IncVal+mhSpbLst.ExpVal;
      mhSpbLst.PrfVal :=mhSpbLst.PrfVal1+mhSpbLst.PrfVal2+mhSpbLst.PrfVal3+mhSpbLst.PrfVal4+mhSpbLst.PrfVal5;
      mhSpbLst.Post;

      // Ulozime doklad o prijmu zalohy
      mhSpd.LocateSerNum(1); mhSpd.Last; mSpdSn:=mhSpd.SerNum+1;
      mhSpd.LocateIncNum(1); mhSpd.Last; mSpdIn:=mhSpd.IncNum+1;
      mhSpd.Insert;
      mhSpd.SerNum:=mSpdSn;
      mhSpd.IncNum:=mSpdIn;
      mhSpd.DocNum:=GenSeDocNum (pPaCode,mSpdSn);
      mhSpd.DocDate:=pDate;
      mhSpd.Describe:=IntToStr(pCasNum)+'/'+IntToStr(pIntDocNum);
      mhSpd.VatPrc1:=gIni.GetVatPrc(1);
      mhSpd.VatPrc2:=gIni.GetVatPrc(2);
      mhSpd.VatPrc3:=gIni.GetVatPrc(3);
      FillChar (mVat,sizeof(mVat),#0);
      For I:=1 to 3 do begin
        If (pDepData[I].GsCode>0) and (pDepData[I].VatPrc=mhSpd.VatPrc3) then mVat[3]:=I;
        If (pDepData[I].GsCode>0) and (pDepData[I].VatPrc=mhSpd.VatPrc2) then mVat[2]:=I;
        If (pDepData[I].GsCode>0) and (pDepData[I].VatPrc=mhSpd.VatPrc1) then mVat[1]:=I;
      end;
      If mVat[1]>0 then mhSpd.DocVal1:=pDepData[mVat[1]].DepVal;
      If mVat[2]>0 then mhSpd.DocVal2:=pDepData[mVat[2]].DepVal;
      If mVat[3]>0 then mhSpd.DocVal3:=pDepData[mVat[3]].DepVal;
      mhSpd.DocVal :=mhSpd.DocVal1+mhSpd.DocVal2+mhSpd.DocVal3;
      mhSpd.PrfVal1:=mhSpd.DocVal1;
      mhSpd.PrfVal2:=mhSpd.DocVal2;
      mhSpd.PrfVal3:=mhSpd.DocVal3;
      mhSpd.PrfVal :=mhSpd.DocVal;
      mhSpd.IncVal :=mhSPBLST.IncVal;
      mhSpd.ExpVal :=mhSPBLST.ExpVal;
      mhSpd.EndVal :=mhSPBLST.EndVal;
      mhSpd.PayMode:='H';
      mhSpd.RspName:='';
      mhSpd.VatDoc :='';
      mhSpd.ConDoc :=mVatDoc;
      mhSpd.PayDoc :=mVatDoc;
      mhSpd.PayDate:=pDate;
      mhSpd.Post;
    end else begin

    end;
    mhGsCat.Close;FreeAndNil(mhGSCat);
    FreeAndNil(mhSpd);FreeAndNil(mhSpbLst);
  end;
  FreeAndNil(mhPab);
end;

procedure SaveDepExp (pCasNum,pPaCode,pIntDocNum:longint; pDate:TDateTime; pDepData:TDepData);
var mhSpd:TSpdHnd; mhSpbLst: TSpblstHnd; mhPab:TPabHnd; mDescribe,mVatDoc:Str12; mSpdSn,mSpdOu:longint;
   mVat: array[1..5] of longint; I:longint; mFind:boolean; mS:string;
begin
  mhPab:=TPabHnd.Create;mhPab.Open(0);
  If mhPab.LocatePaCode(pPaCode) then begin
    mhSpbLst:=TSpblstHnd.Create;mhSpbLst.Open;
    mhSpd:=TSpdHnd.Create;mhSpd.Open(pPaCode);
    If not mhSpbLst.LocatePaCode(pPaCode) then begin
      mhSpbLst.Insert;
      BTR_To_BTR(mhPab.BtrTable,mhSpbLst.BtrTable);
      mhSpbLst.VatPrc1:=gIni.GetVatPrc(1);
      mhSpbLst.VatPrc2:=gIni.GetVatPrc(2);
      mhSpbLst.VatPrc3:=gIni.GetVatPrc(3);
      mhSpbLst.VatPrc4:=gIni.GetVatPrc(4);
      mhSpbLst.VatPrc5:=gIni.GetVatPrc(5);
      mhSpbLst.VatPrc6:=gIni.GetVatPrc(6);
      mhSpbLst.Post;
    end;

    mVatDoc :='ECR'+DateToFileName(pDate)+StrIntZero(pCasNum,3);
    mDescribe:= IntToStr(pCasNum)+'/'+IntToStr(pIntDocNum);
    mFind:=False;
    If mhSpd.LocateDescribe(mDescribe) then mFind:=mhSpd.ConDoc=mVatDoc;
    while not mFind and not mhSpd.Eof and (mhSpd.Describe=mDescribe) do begin
      mFind:=(mhSpd.ConDoc=mVatDoc) and (mhSpd.Describe=mDescribe) ;
      mhSpd.Next;
    end;
    If not mFind then begin
      mFind:=False;
      mhSpbLst.Edit;
      For I:=1 to 5 do begin
        If (pDepData[I].GsCode>0) and IsNotNul (pDepData[I].DepVal) and (pDepData[I].VatPrc<100) then begin
          mFind:=FALSE;
          If pDepData[I].VatPrc=mhSpbLst.VatPrc1 then begin
            mFind:=TRUE;
            mhSpbLst.ExpVal1:=mhSpbLst.ExpVal1-pDepData[I].DepVal;
          end;
          If not mFind and (pDepData[I].VatPrc=mhSpbLst.VatPrc2) then begin
            mFind:=TRUE;
            mhSpbLst.ExpVal2:=mhSpbLst.ExpVal2-pDepData[I].DepVal;
          end;
          If not mFind and (pDepData[I].VatPrc=mhSpbLst.VatPrc3) then begin
            mFind:=TRUE;
            mhSpbLst.ExpVal3:=mhSpbLst.ExpVal3-pDepData[I].DepVal;
          end;
          If not mFind and (pDepData[I].VatPrc=mhSpbLst.VatPrc4) then begin
            mFind:=TRUE;
            mhSpbLst.ExpVal4:=mhSpbLst.ExpVal4-pDepData[I].DepVal;
          end;
          If not mFind and (pDepData[I].VatPrc=mhSpbLst.VatPrc5) then begin
            mFind:=TRUE;
            mhSpbLst.ExpVal5:=mhSpbLst.ExpVal5-pDepData[I].DepVal;
          end;
          If not mFind then begin
            If not DirectoryExists(gPath.BckPath+'LOGS\ERRS\')
              then ForceDirectories(gPath.BckPath+'LOGS\ERRS\');
            mS:='Cerpanie zalohovej platby;Neexistujuca sadzba '+IntToStr(pDepData[I].VatPrc)+';'
            +IntToStr(pCasNum)+';'+IntToStr(pPaCode)+';'+IntToStr(pIntDocNum)+';'+
            dateToStr(pDate)+';'+IntToStr(pDepData[I].GsCode)+';';
            WriteToLogFile(gPath.BckPath+'LOGS\ERRS\NCS.ERR',mS);
          end;
        end;
      end;
      mhSpbLst.ExpVal :=mhSpbLst.ExpVal1+mhSpbLst.ExpVal2+mhSpbLst.ExpVal3+mhSpbLst.ExpVal4+mhSpbLst.ExpVal5;
      mhSpbLst.EndVal :=mhSpbLst.IncVal+mhSpbLst.ExpVal;
      mhSpbLst.Post;

      mVatDoc:='ECR'+DateToFileName(pDate)+StrIntZero(pCasNum,3);
      // Ulozime doklad o prijmu zalohy
      mhSpd.LocateSerNum(1);mhSpd.last;mSpdSn:=mhSpd.SerNum+1;
      mhSpd.LocateExpNum(1);mhSpd.last;mSpdOu:=mhSpd.ExpNum+1;
      mhSpd.Insert;
      mhSpd.SerNum:=mSpdSn;
      mhSpd.ExpNum:=mSpdOu;
      mhSpd.DocNum:=GenSeDocNum (pPaCode,mSpdSn);
      mhSpd.DocDate:=pDate;
      mhSpd.Describe:=IntToStr(pCasNum)+'/'+IntToStr(pIntDocNum);
      mhSpd.VatPrc1:=gIni.GetVatPrc(1);
      mhSpd.VatPrc2:=gIni.GetVatPrc(2);
      mhSpd.VatPrc3:=gIni.GetVatPrc(3);
      FillChar (mVat,sizeof(mVat),#0);
      For I:=1 to 3 do begin
        If (pDepData[I].GsCode>0) and (pDepData[I].VatPrc=mhSpd.VatPrc3) then mVat[3]:=I;
        If (pDepData[I].GsCode>0) and (pDepData[I].VatPrc=mhSpd.VatPrc2) then mVat[2]:=I;
        If (pDepData[I].GsCode>0) and (pDepData[I].VatPrc=mhSpd.VatPrc1) then mVat[1]:=I;
      end;
      If mVat[1]>0 then mhSpd.DocVal1:=0-pDepData[mVat[1]].DepVal;
      If mVat[2]>0 then mhSpd.DocVal2:=0-pDepData[mVat[2]].DepVal;
      If mVat[3]>0 then mhSpd.DocVal3:=0-pDepData[mVat[3]].DepVal;
      mhSpd.DocVal:=0-pDepData[mVat[1]].DepVal-pDepData[mVat[2]].DepVal-pDepData[mVat[3]].DepVal;
      mhSpd.IncVal:=mhSPBLST.IncVal;
      mhSpd.ExpVal:=mhSPBLST.ExpVal;
      mhSpd.EndVal:=mhSPBLST.EndVal;
      mhSpd.PayMode:='H';
      mhSpd.RspName:='';
      mhSpd.VatDoc:='';
      mhSpd.ConDoc:=mVatDoc;
      mhSpd.Post;
    end;
    FreeAndNil(mhSpd);FreeAndNil(mhSpbLst);
  end;
  FreeAndNil(mhPab);
end;

procedure MakeGsSub (pGsData:string; var pWorkCnt:longint);
var mI,mStkNum:integer; mS:string; mhSts:TStsHnd;mhStk:TStkHnd; mSalQnt:double;
    mSList:TStringList; mGsCode:longint;
begin
  pWorkCnt:=0; mStkNum:= 0;
  mhSts:=TStsHnd.Create;mhStk:=TStkHnd.Create;
  mSList:=TStringList.Create;
  mSList.Text:=pGsData;
  // Rezervácia tovaru     StkNum;CasNum;Date;GsCode;Qnt
  If mSList.Count>0 then begin
    For mI:=0 to mSList.Count-1 do begin
      mS:=mSList.Strings[mI];
      If ValInt(LineElement(mS,0,';'))<>mStkNum then begin
        mStkNum:=ValInt(LineElement(mS,0,';'));
        mhSts.Open(mStkNum);
        mhStk.Open(mStkNum);
      end;
      mGsCode:=StrToInt(LineElement(mS,3,';'));
      If mhSTS.LocateGcSdCn(StrToInt(LineElement(mS,3,';')), StrToDate(LineElement(mS,2,';')), StrToInt (LineElement(mS,1,';')))
        then mhSTS.Edit
        else mhSTS.Insert;
      mhSTS.SalDate:=StrToDate(LineElement(mS,2,';'));
      mhSTS.CasNum :=StrToInt (LineElement(mS,1,';'));
      mhSTS.DocNum :='';
      mhSTS.ItmNum :=0;
      mhSTS.GsCode :=mGsCode;
      mhSTS.SalQnt :=mhSTS.SalQnt+ValDoub(LineElement(mS,4,';'));
      mhSTS.Post;
      If IsNul (mhSTS.SalQnt) then mhSTS.Delete;
      If mhSTK.LocateGsCode(mGsCode) then begin
        mSalQnt:=mhSTS.SalQntSum(mGsCode);
        mhSTK.Edit;
        mhSTK.SalQnt:=mSalQnt;
        mhSTK.Post;
      end;
      Inc(pWorkCnt);
      Application.ProcessMessages;
      If cAppBreak then Break;
    end;
  end;
  FreeAndNil (mSList);
end;

procedure PabImp  (pData:string;pSeparator,pDelimiter:Str1;pFldLst:string;   var pWorkCnt:longint);
var mhCty:TCtyLstHnd; mhSta:TStaLstHnd; mhPab,mhPAB3:TPabHnd; mSList,mFList:TStringList; mCut:TTxtCutLst;
    mJ,mI:longint; mIno,mId,mName,mS,mSta,mCty,mZIP:string; mF,mFind:boolean;
begin
  pWorkCnt:=0;

  mhPAB:=TPABHnd.Create;mhPAB.Open(0);mhPAB.NearestPaCode(0);mhPAB.Last;
  mhPAB3:=TPABHnd.Create;mhPAB3.Open(3);mhPAB3.NearestPaCode(0);mhPAB3.Last;
  mhSta:=TStalstHnd.Create;mhSta.Open;
  mhCty:=TCtylstHnd.Create;mhCty.Open;
  mSList:=TStringList.Create;
  mFList:=TStringList.Create;
  mCut:=TTxtCutLst.Create;mCut.SetDelimiter(pDelimiter);mCut.SetSeparator(pSeparator);
  mSList.Text:=pData;
  mFList.Text:=pFldLst;
  If mSList.Count>0 then begin
    For mJ:=0 to mSList.Count-1 do begin
      mS:=mSList.Strings[mJ];
      mCut.SetStr(mS);
      mI:=mCut.GetNum(ValInt(mFList.Values['PaCode']));
      mIno:=mCut.GetText(ValInt(mFList.Values['RegIno']));
      mName:=mCut.GetText(ValInt(mFList.Values['PaName']));
      mId:=mCut.GetText(ValInt(mFList.Values['IdCode']));

      mSta:=mCut.GetText(ValInt(mFList.Values['RegSta']));
      mCty:=mCut.GetText(ValInt(mFList.Values['RegCtn']));
      mZIP:=mCut.GetText(ValInt(mFList.Values['RegZIP']));
      mFind:= (mI>0) and mhPab.LocatePaCode(mI);
      If not mFind then mFind:= (mIno<>'') and mhPab.LocateRegIno(mIno);
      If not mFind then mFind:= (mId<>'') and mhPab.LocateIdCode(mId);
      If not mFind and (mI=0) and (mIno='') and (mId='') and (mName='')
        then mFind:= mhPab.LocatePaName(mName);

      If mSta<>'' then begin
        If Length(mSta)<=2
          then mF:= mhSta.LocateStaCode(mSta) or mhSta.LocateStaCode(StrToAlias(mSta))
          else mF:= mhSta.LocateStaName(mSta) or mhSta.LocateStaName(StrToAlias(mSta));
        If not mF then begin
          mhSta.Insert;
          mhSta.StaName:=mCut.GetText(ValInt(mFList.Values['RegSta']));
          If Length(mSta)<=2 then mhSta.StaCode:=mSta;
          mhSta.Post;
        end;
      end;
      If mCty<>'' then begin
        If Length(mCty)<=3
          then mF:= mhCty.LocateCtyCode(mCty) or mhCty.LocateCtyCode(StrToAlias(mCty))
          else mF:= mhCty.LocateCtyName(mCty) or mhCty.LocateCtyName(StrToAlias(mCty));
        If not mF then begin
          mhCty.Insert;
          mhCty.CtyName:=mCty;
          If Length(mCty)<=3 then mhCty.CtyCode:=mCty;
          If (mZIP<>'') then mhCty.ZipCode:=mZIP;
          mhCty.Post;
        end;
      end;
      If not mFind then begin
        If mI=0 then mI:=mhPab.NextPaCodeInt(gKey.CasPabBeg,gKey.CasPabEnd);
        mhPAB.Insert;
        mhPAB.PaCode  :=mI;
        mhPAB.PaName  :=mCut.GetText(ValInt(mFList.Values['PaName']));
        mhPAB.RegName :=mCut.GetText(ValInt(mFList.Values['RegName']));
        mhPAB.SmlName :=mCut.GetText(ValInt(mFList.Values['SmlName']));
        mhPAB.RegIno  :=mCut.GetText(ValInt(mFList.Values['RegIno']));
        mhPAB.RegTin  :=mCut.GetText(ValInt(mFList.Values['RegTin']));
        mhPAB.RegVin  :=mCut.GetText(ValInt(mFList.Values['RegVin']));
        mhPAB.RegAddr :=mCut.GetText(ValInt(mFList.Values['RegAddr']));
        mhPAB.CrpAddr :=mCut.GetText(ValInt(mFList.Values['CrpAddr']));
        mhPAB.IvcAddr :=mCut.GetText(ValInt(mFList.Values['IvcAddr']));
        mhPAB.RegEml  :=mCut.GetText(ValInt(mFList.Values['RegEml']));
        mhPAB.RegTel  :=mCut.GetText(ValInt(mFList.Values['RegTel']));
        If mCty<>'' then begin
          mhPAB.RegCtn  :=mhCty.CtyName;
          mhPAB.RegZip  :=mhCty.ZipCode;
          mhPAB.CrpCtn  :=mhCty.CtyName;
          mhPAB.CrpZip  :=mhCty.ZipCode;
          mhPAB.IvcCtn  :=mhCty.CtyName;
          mhPAB.IvcZip  :=mhCty.ZipCode;
          mhPAB.RegSta  :=mhCty.StaCode;
          mhPAB.CrpSta  :=mhCty.StaCode;
          mhPAB.IvcSta  :=mhCty.StaCode;
        end else begin
          mhPAB.RegZip  :=mCut.GetText(ValInt(mFList.Values['RegZip']));
          mhPAB.CrpZip  :=mCut.GetText(ValInt(mFList.Values['CrpZip']));
          mhPAB.IvcZip  :=mCut.GetText(ValInt(mFList.Values['IvcZip']));
        end;
        If mSta<>'' then begin
          mhPAB.RegSta  :=mhSta.StaCode;
          mhPAB.CrpSta  :=mhSta.StaCode;
          mhPAB.IvcSta  :=mhSta.StaCode;
        end;
        mhPAB.IcDscPrc:=mCut.GetReal(ValInt(mFList.Values['IcDscPrc']));
        mhPAB.IdCode  :=mCut.GetText(ValInt(mFList.Values['IdCode']));
        mhPAB.Post;
      end else begin
        mhPAB.Edit;
        mhPAB.PaName  :=mCut.GetText(ValInt(mFList.Values['PaName']));
        mhPAB.RegName :=mCut.GetText(ValInt(mFList.Values['RegName']));
        mhPAB.SmlName :=mCut.GetText(ValInt(mFList.Values['SmlName']));
        mhPAB.RegIno  :=mCut.GetText(ValInt(mFList.Values['RegIno']));
        mhPAB.RegTin  :=mCut.GetText(ValInt(mFList.Values['RegTin']));
        mhPAB.RegVin  :=mCut.GetText(ValInt(mFList.Values['RegVin']));
        mhPAB.RegAddr :=mCut.GetText(ValInt(mFList.Values['RegAddr']));
        mhPAB.CrpAddr :=mCut.GetText(ValInt(mFList.Values['CrpAddr']));
        mhPAB.IvcAddr :=mCut.GetText(ValInt(mFList.Values['IvcAddr']));
        mhPAB.RegEml  :=mCut.GetText(ValInt(mFList.Values['RegEml']));
        mhPAB.RegTel  :=mCut.GetText(ValInt(mFList.Values['RegTel']));
        If mCty<>'' then begin
          mhPAB.RegCtn  :=mhCty.CtyName;
          mhPAB.RegZip  :=mhCty.ZipCode;
          mhPAB.CrpCtn  :=mhCty.CtyName;
          mhPAB.CrpZip  :=mhCty.ZipCode;
          mhPAB.IvcCtn  :=mhCty.CtyName;
          mhPAB.IvcZip  :=mhCty.ZipCode;
          mhPAB.RegSta  :=mhCty.StaCode;
          mhPAB.CrpSta  :=mhCty.StaCode;
          mhPAB.IvcSta  :=mhCty.StaCode;
        end else begin
          mhPAB.RegZip  :=mCut.GetText(ValInt(mFList.Values['RegZip']));
          mhPAB.CrpZip  :=mCut.GetText(ValInt(mFList.Values['CrpZip']));
          mhPAB.IvcZip  :=mCut.GetText(ValInt(mFList.Values['IvcZip']));
        end;
        If mSta<>'' then begin
          mhPAB.RegSta  :=mhSta.StaCode;
          mhPAB.CrpSta  :=mhSta.StaCode;
          mhPAB.IvcSta  :=mhSta.StaCode;
        end;
        mhPAB.IcDscPrc:=mCut.GetReal(ValInt(mFList.Values['IcDscPrc']));
        mhPAB.IdCode  :=mCut.GetText(ValInt(mFList.Values['IdCode']));
        mhPAB.Post;
      end;
      If mhPAB3.LocatePaCode(mhPAB.PaCode) then begin
        mhPAB3.Edit;
        BTR_To_BTR(mhPAB.BtrTable,mhPAB3.BtrTable);
        mhPAB3.Post;
      end else begin
        mhPAB3.Insert;
        BTR_To_BTR(mhPAB.BtrTable,mhPAB3.BtrTable);
        mhPAB3.Post;
      end;
      SavePabToCas(mhPab3);
      Inc(pWorkCnt);
      Application.ProcessMessages;
      If cAppBreak then Break;
    end; // FOR
  end; // If mSList.Count>0 then begin
  FreeAndNil (mSList); FreeAndNil (mFList);
  FreeAndNil (mhPAB3);  FreeAndNil (mhPAB);  FreeAndNil (mhCty); FreeAndNil (mhSta);
end;

procedure CrdModDate  (pCusCard:string; pDate:TDateTime);
var mhCrdLst:TCrdLstHnd;
begin
  mhCrdLst:=TCrdLstHnd.Create;mhCrdLst.Open;
  If mhCrdLst.LocateCrdNum(pCusCard) then begin
    mhCrdLst.Edit;
    mhCrdLst.EndDate:=pDate;
    mhCrdLst.Post;
    SaveCrdToCas(mhCrdLst);
  end;
  FreeAndNil(mhCrdLst);
end;

procedure CrdImp(pData:string;pSeparator,pDelimiter:Str1;pFldLst:string; var pWorkCnt:longint);
var mhCrdLst:TCrdLstHnd; mhPab:TPabHnd; mSList,mFList:TStringList; mCut:TTxtCutLst;
    mJ,mI:longint; mIno,mId,mName,mS,mSta,mCty,mZIP:string; mFind:boolean;
begin
  pWorkCnt:=0;

  mhCrdLst:=TCrdLstHnd.Create;mhCrdLst.Open;mhCrdLst.NearestCrdNum('');mhCrdLst.Last;
  mhPab:=TPabHnd.Create;mhPab.Open(0);mhPab.NearestPaCode(0);mhPab.Last;
  mSList:=TStringList.Create;
  mFList:=TStringList.Create;
  mCut:=TTxtCutLst.Create;mCut.SetDelimiter(pDelimiter);mCut.SetSeparator(pSeparator);
  mSList.Text:=pData;
  mFList.Text:=pFldLst;
  If mSList.Count>0 then begin
    For mJ:=0 to mSList.Count-1 do begin
      mS:=mSList.Strings[mJ];
      mCut.SetStr(mS);
{
     CrdNum=1
     CrdName=3
     PaCode=8
     PaName=9
     BegDate=10  - ak nie je zadaný dátum, tak je prázdné
     EndDate=11  - ak nie je zadaný dátum, tak je prázdné
     CrdType=4
     DscPrc=5
     TrnBon=6
     CrdGrp=7
     IdcNum=2

}
      mI:=mCut.GetNum(ValInt(mFList.Values['PaCode']));
      mIno:=mCut.GetText(ValInt(mFList.Values['CrdNum']));
      mName:=mCut.GetText(ValInt(mFList.Values['CrdName']));

      If mINO<>'' then begin
        mFind:=mhCrdLst.LocateCrdNum(mIno);
        If not mFind then begin
          mhCrdLst.Insert;
          mhCrdLst.CrdNum :=mCut.GetText(ValInt(mFList.Values['CrdNum']));
          mhCrdLst.CrdName:=mCut.GetText(ValInt(mFList.Values['CrdName']));
          mhCrdLst.PaCode :=mCut.GetNum(ValInt(mFList.Values['PaCode']));
          mhCrdLst.PaName :=mCut.GetText(ValInt(mFList.Values['PaName']));
          If mFList.Values['BegDate']<>'' then mhCrdLst.BegDate:=mCut.GetDate(ValInt(mFList.Values['BegDate']));
          If mFList.Values['EndDate']<>'' then mhCrdLst.EndDate:=mCut.GetDate(ValInt(mFList.Values['EndDate']));
          mhCrdLst.CrdType:=mCut.GetText(ValInt(mFList.Values['CrdType']));
          mhCrdLst.DscPrc :=mCut.GetReal(ValInt(mFList.Values['DscPrc']));
          mhCrdLst.BonTrn :=mCut.GetReal(ValInt(mFList.Values['TrnBon']));
          mhCrdLst.CrdGrp :=mCut.GetNum(ValInt(mFList.Values['CrdGrp']));
          mhCrdLst.IdcNum :=mCut.GetText(ValInt(mFList.Values['IdcNum']));
          If (mI>0) and mhPab.LocatePaCode(mI) then begin
            mhCrdLst.PaName  :=mhPab.PaName;
          end;
          mhCrdLst.Post;
        end else begin
          mhCrdLst.Edit;
          mhCrdLst.CrdName:=mCut.GetText(ValInt(mFList.Values['CrdName']));
          mhCrdLst.PaCode :=mCut.GetNum(ValInt(mFList.Values['PaCode']));
          mhCrdLst.PaName :=mCut.GetText(ValInt(mFList.Values['PaName']));
          If mFList.Values['BegDate']<>'' then mhCrdLst.BegDate:=mCut.GetDate(ValInt(mFList.Values['BegDate']));
          If mFList.Values['EndDate']<>'' then mhCrdLst.EndDate:=mCut.GetDate(ValInt(mFList.Values['EndDate']));
          mhCrdLst.CrdType:=mCut.GetText(ValInt(mFList.Values['CrdType']));
          mhCrdLst.DscPrc :=mCut.GetReal(ValInt(mFList.Values['DscPrc']));
          mhCrdLst.BonTrn :=mCut.GetReal(ValInt(mFList.Values['TrnBon']));
          mhCrdLst.CrdGrp :=mCut.GetNum(ValInt(mFList.Values['CrdGrp']));
          mhCrdLst.IdcNum :=mCut.GetText(ValInt(mFList.Values['IdcNum']));
          If (mI>0) and mhPab.LocatePaCode(mI) then begin
            mhCrdLst.PaName  :=mhPab.PaName;
          end;
          mhCrdLst.Post;
        end;
        SaveCrdToCas(mhCrdLst);
      end;
      Inc(pWorkCnt);
      Application.ProcessMessages;
      If cAppBreak then Break;
    end;
  end;
  FreeAndNil (mSList);
  FreeAndNil (mFList);
end;

procedure AddToTNS  (pData:string;   var pWorkCnt:longint);
var mhTns:TTnsHnd; mhTnh:TTnhHnd; mGS:TGscatHnd; mColItm:TColItmHnd; mSList:TStringList; mTcd:TTcd; mF:boolean;
    mExt,mCN,mCD,mCT,mS:string; mSumVal,mVal,mPrc,mQnt:double;
    mLCI,mCI,mTentNum,mSerNum,mI,mStk,mWri,mCas,mGsCode,mT,mR,mV:longint;
  {Ubytov.; Izba  ; Host c.; PLU ;Mnozstvo;Hodnota s DPH;PC s DPH; Sklad; Prevádzka; Pokladòa; Pokladník; dátum uloženia; èas uloženia}
  procedure SaveTcdItm;
  var m2OK:boolean;
  begin
    mColItm.LocateColNum(mCI);
    mGS.LocateGsCode(mColItm.GsCode);
    mTcd.AddItm(mstk,mColItm.GsCode,1,0,0,0,mWri,'');
  end;
  procedure SaveColItm;
  var m2OK:boolean;
  begin
    mColItm.LocateColNum(mLCI);
    mGS.LocateGsCode(mColItm.GsCode);
    m2OK:=True;
    If mColItm.DayQnt>0 then m2OK:=mColItm.DayQnt>mhTns.TnsGscCnt(mColItm.GsCode,mT,0,0,Date);
    If mColItm.TenQnt>0 then m2OK:=m2OK and (mColItm.TenQnt>mhTns.TnsGscCnt(mColItm.GsCode,mT,0,0,0));
    If not m2OK
      then mVal:=mSumVal
      else If mColItm.DscVal>mSumVal then mVal:=0 else mVal:=mSumVal-mColItm.DscVal;
    mSerNum:=mSerNum+1;
    mhTNS.Insert;
    mhTNS.SerNum     :=mSerNum;
    mhTNS.TentNum    :=mT;
    mhTNS.RoomNum    :=mR;
    mhTNS.VisNum     :=mV;
    mhTNS.Group      :=0;
    mhTNS.GsCode     :=mColItm.GsCode;
    If mGS.LocateGsCode(mColItm.GsCode) then begin
      mhTNS.MgCode:=mGS.MgCode;
      mhTNS.GsName:=mGS.GsName;
      mhTNS.VatPrc:=mGS.VatPrc;
    end;
    mhTNS.BPrice  :=mVal;
    mhTNS.Quant   :=1;
    mhTNS.BValue  :=mVal;
    mhTNS.AValue  :=Rd2(mVal/(1+mGS.VatPrc/100));
    mhTNS.APrice  :=Rd2(mhTNS.AValue/mQnt);
    mhTNS.BPrice  :=Rd2(mhTNS.BValue/mQnt);
    mhTNS.Status  :='N';  // Stav
    mhTNS.Daily   :='N';  // Uctovat denne (A/N)
    mhTNS.StkNum  :=mStk;
    mhTNS.WriNum  :=mWri;
    mhTNS.CasNum  :=mCas;
    mhTNS.CasUser :=mCN;
    mhTNS.CasDate :=StrToDate(mCD);
    mhTNS.CasTime :=StrToTime(mCT);
    mhTNS.DscPrc  :=0;
    mhTNS.TcdNum  :=mTcd.ohTCI.DocNum;
    mhTNS.TcdItm  :=mTcd.ohTCI.ItmNum;
    mhTNS.Post;
    mTcd.ohTCI.Edit;
    mTcd.ohTCI.StkStat:='C';
    mTcd.ohTCI.SetFgBPrice(mVal,mTcd.ohTCH.FgCourse,mTcd.ohTCH.VatDoc);
    mTcd.ohTCI.Post;
  end;

begin
  pWorkCnt:=0;
  mSList:=TStringList.Create;
  mSList.Text:=pData;
  If mSList.Count>0 then begin
    mhTNS:=TTNSHnd.Create;mhTNS.Open;mhTNS.NearestSerNum(0);mhTNS.Last;
    mhTNh:=TTNhHnd.Create;mhTNh.Open;mhTNh.NearestTentNum(0);mhTNh.Last;
    mGS:=TGscatHnd.Create;mGS.Open;
    mColItm:=TColItmHnd.Create;mColItm.Open;
    mTcd:=TTcd.Create;
    mTcd.Open(gKey.CasTcdBok[0]);
    mTentNum:=0;
    mSerNum:=mhTNS.SerNum;
    mLCI:=0;mSumVal:=0;
    For mI:=0 to mSList.Count-1 do begin
      mS:=mSList.Strings[mI];
      If (mS<>'') and (LineElementNum(mS,';')>=12)then begin
        mT:=StrToInt(LineElement(mS,0,';'));
        mR:=StrToInt(LineElement(mS,1,';'));
        mV:=StrToInt(LineElement(mS,2,';'));
        mGsCode:=StrToInt(LineElement(mS,3,';'));
        mQnt:=ValDoub(LineElement(mS,4,';'));
        mPrc:=ValDoub(LineElement(mS,6,';'));
        mVal:=ValDoub(LineElement(mS,5,';'));
        mStk:=StrToInt(LineElement(mS,7,';'));
        mWri:=StrToInt(LineElement(mS,8,';'));
        mCas:=StrToInt(LineElement(mS,9,';'));
        mCN :=LineElement(mS,10,';');
        mCD :=LineElement(mS,11,';');
        mCT :=LineElement(mS,12,';');
        mCI :=ValInt(LineElement(mS,13,';'));
        If (mTentNum=0)or(mT<>mTentNum) then begin
          If mTentNum>0 then begin
            mTcd.CnfDoc;mTcd.SubDoc;mTcd.ClcDoc;
            If (mLCI>0) then begin
              // ulzoit mLCI
              SaveColItm;
            end;
          end;
          mExt:=StrIntZero(mT,7);
          mF:=mTcd.ohTCH.LocateExtNum(mExt) and (mTcd.ohTCH.DocDate=Date);
          while not mF and not mTcd.ohTCH.Eof and (mTcd.ohTCH.ExtNum=mExt) do begin
            mTcd.ohTCH.Next;
            mF:=(mTcd.ohTCH.ExtNum=mExt)and (mTcd.ohTCH.DocDate=Date);
          end;
          If not mF then begin
            mhTnh.LocateTentNum(mT);
            mTcd.SerNum:=0;
            mTcd.NewDoc('',mhTnh.Group,mStk,True);
            mTcd.ohTCH.Edit;mTcd.ohTCH.ExtNum:=mExt;mTcd.ohTCH.Post;
          end;
          mTcd.LocDoc(mTcd.ohTCH.DocNum);
          mTentNum:=mT;
        end;
        If mCI>0 then begin
          If mLCI<>mCI then begin
            // ulzoit mLCI
            If (mLCI>0) then SaveColItm;
            mLCI:=mCI;
            mSumVal:=0;
            SaveTcdItm;
          end;
          mSumVal:=mSumVal+mVal;
          mTcd.AddTcc(mTcd.ohTCI.ItmNum,mTcd.ohTCI.ItmNum,mTcd.ohTCI.StkNum,mGsCode,mTcd.ohTCI.GsCode,mQnt,0,0,mPrc,mWri);
        end else begin
          If (mLCI>0) then SaveColItm;
          mSumVal:=0;mLCI:=0;
          mSerNum:=mSerNum+1;
          mhTNS.Insert;
          mhTNS.SerNum     :=mSerNum;
          mhTNS.TentNum    :=mT;
          mhTNS.RoomNum    :=mR;
          mhTNS.VisNum     :=mV;
          mhTNS.Group      :=0;
          mhTNS.GsCode     :=mGsCode;
          If mGS.LocateGsCode(mGsCode) then begin
            mhTNS.MgCode:=mGS.MgCode;
            mhTNS.GsName:=mGS.GsName;
            mhTNS.VatPrc:=mGS.VatPrc;
          end;
          mhTNS.BPrice  :=mPrc;
          mhTNS.Quant   :=mQnt;
          mhTNS.BValue  :=mVal;
          mhTNS.AValue  :=Rd2(mVal/(1+mGS.VatPrc/100));
          mhTNS.APrice  :=Rd2(mhTNS.AValue/mQnt);
          mhTNS.BPrice  :=Rd2(mhTNS.BValue/mQnt);
          mhTNS.Status  :='N';  // Stav
          mhTNS.Daily   :='N';  // Uctovat denne (A/N)
          mhTNS.StkNum  :=mStk;
          mhTNS.WriNum  :=mWri;
          mhTNS.CasNum  :=mCas;
          mhTNS.CasUser :=mCN;
          mhTNS.CasDate :=StrToDate(mCD);
          mhTNS.CasTime :=StrToTime(mCT);
          mhTNS.DscPrc  :=0;
          mhTNS.Post;
          mTcd.AddItm(mStk,mGScode,mQnt,0,0,mPrc,mWri,'');
          mhTNS.Edit;
          mhTNS.TcdNum  :=mTcd.ohTCI.DocNum;
          mhTNS.TcdItm  :=mTcd.ohTCI.ItmNum;
          mhTNS.Post;
        end; // mCI=0
      end; // mS<>''
      Inc(pWorkCnt);
      Application.ProcessMessages;
      If cAppBreak then Break;
    end; // For
    If (mLCI>0) then SaveColItm;
    If mTentNum>0 then begin
      mTcd.CnfDoc;mTcd.SubDoc;mTcd.ClcDoc;
    end;
    FreeAndNil (mhTns);
    FreeAndNil (mGS);
  end;
  FreeAndNil (mSList);
end;

procedure CasTcdGen(pCasNum:longint; pFileName:String; var pDocNum:Str12);
var mTcd:TTcd; mI,mCnt:integer; mS:String; mCut:TTxtCutLst; mINI:TIniFile; mGsCode:longint; mSList:TStringList;
{
[BLK]
PaCode=10044
PaName=Peter Melis
DocDscPrc=0.00
BlkVal=122.52
Name=
CrtUser=pokladna
CrtDate=14.06.12 08:38
Itm_1=2;PONOZKY NBA MAN LOGOS;;;;7;0;0;700007;700007;;;W;20;Kus;0;0;0;0.00;0.00;0;0.000;1.000;0.000;11.033333;13.24;11.033333;13.24;11.033333;13.24;11.033333;13.24;0;0;0;0;0.00;1;P-1-1;;;;0;;14.6.2012;8:33:29;;0;0;0;;0
ItmQnt=2
Itm_2=3;PONOZKY NBA JUNIOR TENIS;;;;7;0;0;700006;700006;;;W;20;Kus;0;0;0;0.00;0.00;0;0.000;1.000;0.000;11.033333;13.24;11.033333;13.24;11.033333;13.24;11.033333;13.24;0;0;0;0;0.00;1;P-1-1;;;;0;;14.6.2012;8:33:31;;0;0;0;;0
}
begin
  pDocNum:='';
  If not FileExists(pFileName)then Exit;
  mTcd:=TTcd.Create;
  mTcd.Open(gKey.CasTcdBok[pCasNum]);
  mIni:=TIniFile.Create(pFileName);
  mCut:=TTxtCutLst.Create;
  mCut.SetDelimiter('');
  mCut.SetSeparator(';');

  mSList:=TStringList.Create;
  mCnt:=mIni.ReadInteger('BLK','ItmQnt',0);
  If mCnt>0 then begin
    mIni.ReadSectionValues('BLK', mSList);
    mTcd.NewDoc('',mIni.ReadInteger('BLK','PaCode',1),True);
    pDocNum:=mTcd.DocNum;
    for mI:=0 to mSList.Count-1 do begin
      If Copy (mSList.Strings[mI], 1, 4)='Itm_' then begin
        mS:= mSList.Strings[mI];
        mS:=RemLeftSpaces(Copy (mS, Pos ('=', mS)+1, 255));
        mCut.SetStr(mS);
        // doplnit prevadzku
        mGsCode:=mCut.GetNum(0+1);
        If mGsCode>0
//          then mTcd.AddItm(mCut.GetNum(37+1), mGsCode, mCut.GetReal(22+1),0,mCut.GetReal(32+1),mCut.GetReal(27+1),0,'')
//  13.01.2020 TIBI - namiesto pôvodnej ceny zapisuje do dodacieho listu z¾avnená cena s DPH
          then mTcd.AddItm(mCut.GetNum(37+1), mGsCode, mCut.GetReal(22+1),0,mCut.GetReal(32+1),mCut.GetReal(26),0,'')
          else WriteToTCDErr (pFileName, mS);
      end;
    end;
  end;
  mTcd.CnfDoc;
  mTcd.SubDoc;
  mTcd.ClcDoc;
  FreeAndNil(mIni);
  FreeAndNil(mTcd);
  FreeAndNil (mCut);
  FreeAndNil (mSList);
end;

procedure WriteToTCDErr (pFileName, pLn:string);
var mFile, mS:string; mErr:longint;
begin
  mFile:=gPath.BckPath+'DOCS\TCD.ERR';
  If not DirectoryExists(ExtractFileDir(mFile)) then ForceDirectories(ExtractFileDir(mFile));
  mS:=FormatDateTime ('dd.mm.yyyy hh:nn:ss', Date)+';'+ExtractFilename (pFileName)+';'+pLn+#13+#10;
  SaveFullTxtFile(mFile, mS, mErr);
end;

procedure SaveCrdToCas(phCrdLst:TCrdLstHnd);
var mhCABLST:TCablstHnd;  mTxt:TStrings;  mWrap:TTxtWrap;  mPath:ShortString; mI:integer; mS:String;
begin
  mWrap:=TTxtWrap.Create;
  mTxt:=TStringList.Create;
  mWrap.SetDelimiter('');
  mWrap.SetSeparator(';');
  mWrap.ClearWrap;
  mWrap.SetText(phCRDLST.CrdNum,0);    // 1
  mWrap.SetText(phCRDLST.CrdName,0);   // 2
  mWrap.SetText(phCRDLST.CrdType,0);   // 3
  mWrap.SetText(phCRDLST.DscType,0);   // 4
  mWrap.SetNum (phCRDLST.PaCode,0);    // 5
  mWrap.SetText(phCRDLST.PaName,0);    // 6
  mWrap.SetReal(phCRDLST.BonTrn,0,2);  // 7
  mWrap.SetReal(phCRDLST.DscPrc,0,2);  // 8
  mWrap.SetNum (phCRDLST.OutBon,0);    // 9
  mWrap.SetNum (phCRDLST.CrdGrp,0);    // 10
  mWrap.SetDate(phCRDLST.BegDate);     // 11
  mWrap.SetDate(phCRDLST.EndDate);     // 12
  mS:=mWrap.GetWrapText;
  FreeAndNil (mWrap);
  mhCABLST:=TCablstHnd.Create;  mhCABLST.Open;
  If mhCABLST.Count>0 then begin
    mhCABLST.First;
    Repeat
      mPath:=gPath.CasPath(mhCABLST.CasNum);
      mTxt.Clear;
      If FileExists (mPath+'CRDLST.REF') then mTxt.LoadFromFile(mPath+'CRDLST.REF');
      mTxt.Add(mS);
      mTxt.SaveToFile(mPath+'CRDLST.TMP');
      If FileExists (mPath+'CRDLST.REF') then DeleteFile (mPath+'CRDLST.REF');
      RenameFile (mPath+'CRDLST.TMP',mPath+'CRDLST.REF');
      Application.ProcessMessages;
      mhCABLST.Next;
    until mhCABLST.Eof;
  end;
  FreeAndNil (mhCABLST);
  FreeAndNil (mTxt);
end;

procedure SavePabToCas(phPab:TPabHnd);
var mhCABLST:TCablstHnd;  mTxt:TStrings;  mWrap:TTxtWrap;  mPath:ShortString; mI:integer; mS:String;
begin
  mWrap:=TTxtWrap.Create;
  mTxt:=TStringList.Create;
  mWrap.ClearWrap;
  mWrap.SetText ('M',  0);            //  1
  mWrap.SetNum  (phPab.PaCode,  0);   //  2
  mWrap.SetText (phPab.PaName,  0);   //  3
  mWrap.SetText (phPab.RegIno,  0);   //  4
  mWrap.SetText (phPab.RegTin,  0);   //  5
  mWrap.SetText (phPab.IdCode,  0);   //  6
  mWrap.SetReal (phPab.IcDscPrc,0,0); //  7
  mWrap.SetText (phPAB.RegVin,0);     //  8
  mWrap.SetText (phPAB.RegAddr,0);    //  9
  mWrap.SetText (phPAB.RegCtn,0);     // 10
  mWrap.SetText (phPAB.RegZip,0);     // 11
  mWrap.SetText (phPAB.RegSta,0);     // 12
  mWrap.SetNum  (phPAB.IcPlsNum,0);   // 13
  mWrap.SetNum  (phPAB.SpeLev,0);     // 14
  mWrap.SetNum  (0{phPAB.UseSelfPls},0);     // 15 pab.bdf
  mWrap.SetNum  (0{phPAB.DstActCalc},0);     // 16
  mWrap.SetNum  (phPAB.IcAplNum,0);   // 17
  mWrap.SetNum  (phPAB.IcPayBrm,0);   // 18
  mWrap.SetNum  (phPAB.SaDisStat,0);  // 19
  mWrap.SetReal (phPAB.AdvPay,0,2);   // 20
  mWrap.SetText (phPAB.RegTel,0);     // 21
  mWrap.SetText (phPAB.RegEml,0);     // 22
  mS:=mWrap.GetWrapText;
  FreeAndNil (mWrap);
  mhCABLST:=TCablstHnd.Create;  mhCABLST.Open;
  If mhCABLST.Count>0 then begin
    mhCABLST.First;
    Repeat
      mPath:=gPath.CasPath(mhCABLST.CasNum);
      mTxt.Clear;
      If FileExists (mPath+'PAB00003.REF') then mTxt.LoadFromFile(mPath+'PAB00003.REF');
      mTxt.Add(mS);
      mTxt.SaveToFile(mPath+'PAB00003.TMP');
      If FileExists (mPath+'PAB00003.REF') then DeleteFile (mPath+'PAB00003.REF');
      RenameFile (mPath+'PAB00003.TMP',mPath+'PAB00003.REF');
      Application.ProcessMessages;
      mhCABLST.Next;
    until mhCABLST.Eof;
  end;
  FreeAndNil (mhCABLST);
  FreeAndNil (mTxt);
end;

end.
{MOD 1810003}
{MOD 1905003}

