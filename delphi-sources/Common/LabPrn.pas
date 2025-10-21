unit LabPrn;
{$F+}

// *****************************************************************************
//                     OBJEKT NA TLAÈ CENOVKOVÝCH ETIKIET
// *****************************************************************************
// Tento objekt obsahuje funkcie, ktoré umožnia tlaè cenovkových etikiet
//
// Programové funkcia:
// ---------------
// *****************************************************************************

interface

uses
  TxtWrap, BtrTable,
  IcTypes, IcConv, IcTools, NexGlob, NexPath, RepHand, Key,
  tLABPRN, hGSCAT, hGSNOTI, hAPLITM, hPLH, hAplLst,
  SysUtils, Classes, Forms, DB;

const
  cMinPriceDay = 30;

type
  TLabPrn = class(TComponent)
    constructor Create;
    destructor  Destroy; override;
//    function GetActPce(pGsCode:longint):double;
    private
      oMasterAplItm: TDataSet;

      oActDate:TDateTime;
      ohGSCAT:TGscatHnd;
      ohGSNOTI:TGsnotiHnd;
      ohAPLITM:TAplitmHnd;  //03.09.2024 TIBI
      otLABPRN:TLabprnTmp;
      ohPLH:TPLHHnd;
      oMinPLPriceHistory:string;
      oMinAPLPriceHistory:string;

      function  GetMinPrice:double;
      function  GetMinPLPrice(pPrice:double):double;
      function  GetMinAPLPrice(pPrice:double):double;
      function  GetActPos(pTbl:TDataSet):longint;
      function  OpenPLH:boolean;
      procedure AddMinPLPriceHistory;
      procedure AddMinAPLPriceHistory(pAPLITM:TDataSet);
      procedure AddToActionPricePrnHistory;
      function  GetActionPricePrnHistoryStr:string;
      function  GetActionPricePrnHistoryHead:string;
    public
      procedure Add(pGsCode:longint;pAcAPrice,pAcBPrice:double;pLabQnt:word); overload;
      procedure Add(pAplItm:TDataSet;pLabQnt:word); overload;
      procedure Prn;
    published
      property ActDate:TDateTime write oActDate;
  end;

implementation

uses bGSNOTI, bAPLITM, bAPLLST, bPlh;

constructor TLabPrn.Create;
begin
  oActDate:=Date;
  ohGSCAT:=TGscatHnd.Create;  ohGSCAT.Open;
  ohGSNOTI:=TGsnotiHnd.Create; ohGSNOTI.Open;
  ohAPLITM:=TAplitmHnd.Create; ohAPLITM.Open;
  otLABPRN:=TLabprnTmp.Create; otLABPRN.Open;
  ohPLH:=TPlhHnd.Create;
end;

destructor TLabPrn.Destroy;
begin
  FreeAndNil (ohPLH);
  FreeAndNil (otLABPRN);
  FreeAndNil (ohAPLITM);
  FreeAndNil (ohGSNOTI);
  FreeAndNil (ohGSCAT);
end;

// ********************************* PRIVATE ***********************************
(*
function TLabPrn.GetActPce(pGsCode:longint):double;
begin
  Result:=0;
  If ohAPLITM.LocateGsCode(pGsCode) then begin  // Ak by bolo viac platnych akciovych cien vyberieme najnižšiu cenu
    Repeat
      If InDateInterval (ohAPLITM.BegDate,ohAPLITM.EndDate,oActDate) then begin
        If IsNul(Result) or (Result>ohAPLITM.AcBPrice) then Result:=ohAPLITM.AcBPrice;
      end;
      Application.ProcessMessages;
      ohAPLITM.Next;
    until ohAPLITM.Eof or (ohAPLITM.GsCode<>pGsCode);
  end;
end;
*)
// ********************************** PUBLIC ***********************************

procedure TLabPrn.Add (pGsCode:longint;pAcAPrice,pAcBPrice:double;pLabQnt:word);
var I:word;  mAcMPrice,mAcYPrice,mFgMPrice,mFgYPrice:double;
begin
  If ohGSCAT.LocateGsCode(pGsCode) then begin
    For I:=1 to pLabQnt do begin
      otLABPRN.Insert;
      otLABPRN.ItmNum:=otLABPRN.Count+1;
      BTR_To_PX (ohGSCAT.BtrTable,otLABPRN.TmpTable);

      otLABPRN.InfDvz:=gKey.SysInfDvz;
      otLABPRN.AccDvz:=gKey.SysAccDvz;
      otLABPRN.AcAPrice:=pAcAPrice;
      otLABPRN.AcBPrice:=pAcBPrice;
      otLABPRN.AcBpcInt:=StrInt(Round(Int(pAcBPrice)),0);
      otLABPRN.AcBpcFrc:=StrIntZero(Round(Frac(pAcBPrice)*100),2);
      otLABPRN.AcXPrice:=0;
      
      // TODO RZ - 18.02.2025
      If ohAPLITM.LocateGsCode(pGsCode) then begin // Existuje akciový tovar
        Repeat
          If InDateInterval(ohAPLITM.BegDate,ohAPLITM.EndDate,oActDate) then begin
            If IsNotNul(otLABPRN.AcXPrice) then begin
              If otLABPRN.AcXPrice>ohAPLITM.AcBPrice then otLABPRN.AcXPrice:=ohAPLITM.AcBPrice;
            end
            else otLABPRN.AcXPrice:=ohAPLITM.AcBPrice;
            otLABPRN.BegDate:=ohAPLITM.BegDate;
            otLABPRN.EndDate:=ohAPLITM.EndDate;
          end;
          ohAPLITM.Next;
        until ohAPLITM.Eof or (ohAPLITM.GsCode<>pGsCode);
      end;

      If IsNul(otLABPRN.AcXPrice) then otLABPRN.AcXPrice:=otLABPRN.AcBPrice;
      If IsNotNul(ohGSCAT.MsuQnt) then begin
        mAcMPrice:=Rd3(otLABPRN.AcBPrice/ohGSCAT.MsuQnt);
        mAcYPrice:=Rd3(otLABPRN.AcXPrice/ohGSCAT.MsuQnt);
        otLABPRN.AcMPrice:=StrDoub(mAcMPrice,0,3);
        otLABPRN.AcYPrice:=StrDoub(mAcYPrice,0,3);
        otLABPRN.AcMuName:=otLABPRN.AccDvz+'/'+ohGSCAT.MsuName;
      end;
      If IsNotNul(gKey.SysFixCrs) then begin
        otLABPRN.FixCrs:=StrDoub(gKey.SysFixCrs,0,4);
        If (gKey.SysInfDvz='EUR') or (gKey.SysInfDvz='€') then begin // Hlavna mena SKK informa4n8 mena EUR
          otLABPRN.FgAPrice:=Rd2(otLABPRN.AcAPrice/gKey.SysFixCrs);
          otLABPRN.FgBPrice:=Rd2(otLABPRN.AcBPrice/gKey.SysFixCrs);
          otLABPRN.FgXPrice:=Rd2(otLABPRN.AcXPrice/gKey.SysFixCrs);
          mFgMPrice:=mAcMPrice/gKey.SysFixCrs;
          mFgYPrice:=mAcYPrice/gKey.SysFixCrs;
        end
        else begin // Hlavna mena EUR informa4n8 mena SKK
          otLABPRN.FgAPrice:=Rd2(otLABPRN.AcAPrice*gKey.SysFixCrs);
          otLABPRN.FgBPrice:=Rd2(otLABPRN.AcBPrice*gKey.SysFixCrs);
          otLABPRN.FgXPrice:=Rd2(otLABPRN.AcXPrice*gKey.SysFixCrs);
          mFgMPrice:=mAcMPrice*gKey.SysFixCrs;
          mFgYPrice:=mAcYPrice*gKey.SysFixCrs;
        end;
        If IsNotNul(mFgMPrice) then begin
          otLABPRN.FgMPrice:=StrDoub(mFgMPrice,0,2);
          otLABPRN.FgYPrice:=StrDoub(mFgYPrice,0,2);
          otLABPRN.FgMuName:=otLABPRN.InfDvz+'/'+ohGSCAT.MsuName;
        end;
      end;
//      otLABPRN.MinPrice:=GetMinPrice; // RZ - 31.12.2024 spolu s RT
      otLABPRN.MinPrice:=0;
      otLABPRN.GaName:=ohGSCAT.GaName;
      // Nacitame poznamkove riadky
      If ohGSNOTI.LocateGsCode(ohGSCAT.GsCode) then begin
        otLABPRN.Notice1:=ohGSNOTI.Notice;  ohGSNOTI.Next;
        If ohGSNOTI.GsCode=ohGSCAT.GsCode then begin
          otLABPRN.Notice2:=ohGSNOTI.Notice;  ohGSNOTI.Next;
          If ohGSNOTI.GsCode=ohGSCAT.GsCode then begin
            otLABPRN.Notice3:=ohGSNOTI.Notice;  ohGSNOTI.Next;
            If ohGSNOTI.GsCode=ohGSCAT.GsCode then begin
              otLABPRN.Notice4:=ohGSNOTI.Notice;  ohGSNOTI.Next;
              If ohGSNOTI.GsCode=ohGSCAT.GsCode then begin
                otLABPRN.Notice5:=ohGSNOTI.Notice;  ohGSNOTI.Next;
                If ohGSNOTI.GsCode=ohGSCAT.GsCode then begin
                  otLABPRN.Notice6:=ohGSNOTI.Notice;  ohGSNOTI.Next;
                end;
              end;
            end;
          end;
        end;
      end;
      otLABPRN.Post;
      AddToActionPricePrnHistory;
    end;
  end;
end;

procedure TLabPrn.Add(pAplItm:TDataSet;pLabQnt:word);
var I:word;  mAcMPrice,mAcYPrice,mFgMPrice,mFgYPrice:double;
begin
  oMasterAplItm:=pAplItm;
  If ohGSCAT.LocateGsCode(pAplItm.FieldByName('GsCode').AsInteger) then begin
    For I:=1 to pLabQnt do begin
      otLABPRN.Insert;
      otLABPRN.ItmNum:=otLABPRN.Count+1;
      BTR_To_PX (ohGSCAT.BtrTable,otLABPRN.TmpTable);

      otLABPRN.InfDvz:=gKey.SysInfDvz;
      otLABPRN.AccDvz:=gKey.SysAccDvz;
      otLABPRN.AcAPrice:=pAplItm.FieldByName('PcAPrice').AsFloat;
      otLABPRN.AcBPrice:=pAplItm.FieldByName('PcBPrice').AsFloat;
      otLABPRN.AcBpcInt:=StrInt(Round(Int(pAplItm.FieldByName('PcBPrice').AsFloat)),0);
      otLABPRN.AcBpcFrc:=StrIntZero(Round(Frac(pAplItm.FieldByName('PcBPrice').AsFloat)*100),2);
(* 03.09.2024 Tibi - Kvôly CKD som vypol tento spôsob zistenia akciovej ceny
      otLABPRN.AcXPrice:=0;
      If ohAPLITM.LocateAnGs(pAplItm.FieldByName('AplNum').AsInteger,pAplItm.FieldByName('GsCode').AsInteger) then begin // Existuje akciový tovar
        Repeat
          If InDateInterval(ohAPLITM.BegDate,ohAPLITM.EndDate,oActDate) then begin
            If IsNotNul(otLABPRN.AcXPrice) then begin
              If otLABPRN.AcXPrice>ohAPLITM.AcBPrice then otLABPRN.AcXPrice:=ohAPLITM.AcBPrice;
            end
            else otLABPRN.AcXPrice:=ohAPLITM.AcBPrice;
            otLABPRN.BegDate:=ohAPLITM.BegDate;
            otLABPRN.EndDate:=ohAPLITM.EndDate;
          end;
          ohAPLITM.Next;
        until ohAPLITM.Eof or (ohAPLITM.GsCode<>pAplItm.FieldByName('GsCode').AsInteger) or (ohAPLITM.AplNum<>pAplItm.FieldByName('AplNum').AsInteger);
      end;
      If IsNul(otLABPRN.AcXPrice) then otLABPRN.AcXPrice:=otLABPRN.AcBPrice;
*)
      otLABPRN.AcXPrice:=pAplItm.FieldByName('AcBPrice').AsFloat;

      If IsNotNul(ohGSCAT.MsuQnt) then begin
        mAcMPrice:=Rd3(otLABPRN.AcBPrice/ohGSCAT.MsuQnt);
        mAcYPrice:=Rd3(otLABPRN.AcXPrice/ohGSCAT.MsuQnt);
        otLABPRN.AcMPrice:=StrDoub(mAcMPrice,0,3);
        otLABPRN.AcYPrice:=StrDoub(mAcYPrice,0,3);
        otLABPRN.AcMuName:=otLABPRN.AccDvz+'/'+ohGSCAT.MsuName;
      end;
      If IsNotNul(gKey.SysFixCrs) then begin
        otLABPRN.FixCrs:=StrDoub(gKey.SysFixCrs,0,4);
        If (gKey.SysInfDvz='EUR') or (gKey.SysInfDvz='€') then begin // Hlavna mena SKK informa4n8 mena EUR
          otLABPRN.FgAPrice:=Rd2(otLABPRN.AcAPrice/gKey.SysFixCrs);
          otLABPRN.FgBPrice:=Rd2(otLABPRN.AcBPrice/gKey.SysFixCrs);
          otLABPRN.FgXPrice:=Rd2(otLABPRN.AcXPrice/gKey.SysFixCrs);
          mFgMPrice:=mAcMPrice/gKey.SysFixCrs;
          mFgYPrice:=mAcYPrice/gKey.SysFixCrs;
        end
        else begin // Hlavna mena EUR informa4n8 mena SKK
          otLABPRN.FgAPrice:=Rd2(otLABPRN.AcAPrice*gKey.SysFixCrs);
          otLABPRN.FgBPrice:=Rd2(otLABPRN.AcBPrice*gKey.SysFixCrs);
          otLABPRN.FgXPrice:=Rd2(otLABPRN.AcXPrice*gKey.SysFixCrs);
          mFgMPrice:=mAcMPrice*gKey.SysFixCrs;
          mFgYPrice:=mAcYPrice*gKey.SysFixCrs;
        end;
        If IsNotNul(mFgMPrice) then begin
          otLABPRN.FgMPrice:=StrDoub(mFgMPrice,0,2);
          otLABPRN.FgYPrice:=StrDoub(mFgYPrice,0,2);
          otLABPRN.FgMuName:=otLABPRN.InfDvz+'/'+ohGSCAT.MsuName;
        end;
      end;
      otLABPRN.MinPrice:=GetMinPrice;
      otLABPRN.GaName:=ohGSCAT.GaName;
      // Nacitame poznamkove riadky
      If ohGSNOTI.LocateGsCode(ohGSCAT.GsCode) then begin
        otLABPRN.Notice1:=ohGSNOTI.Notice;  ohGSNOTI.Next;
        If ohGSNOTI.GsCode=ohGSCAT.GsCode then begin
          otLABPRN.Notice2:=ohGSNOTI.Notice;  ohGSNOTI.Next;
          If ohGSNOTI.GsCode=ohGSCAT.GsCode then begin
            otLABPRN.Notice3:=ohGSNOTI.Notice;  ohGSNOTI.Next;
            If ohGSNOTI.GsCode=ohGSCAT.GsCode then begin
              otLABPRN.Notice4:=ohGSNOTI.Notice;  ohGSNOTI.Next;
              If ohGSNOTI.GsCode=ohGSCAT.GsCode then begin
                otLABPRN.Notice5:=ohGSNOTI.Notice;  ohGSNOTI.Next;
                If ohGSNOTI.GsCode=ohGSCAT.GsCode then begin
                  otLABPRN.Notice6:=ohGSNOTI.Notice;  ohGSNOTI.Next;
                end;
              end;
            end;
          end;
        end;
      end;
      otLABPRN.Post;
      AddToActionPricePrnHistory;
    end;
  end;
end;

procedure TLabPrn.Prn;
var mRep:TF_RepHand;
begin
  mRep:=TF_RepHand.Create(Self);
  mRep.Item:=otLABPRN.TmpTable;
  mRep.Execute(gPath.RepPath+'LAB');
  FreeAndNil(mRep);
end;

function TLabPrn.GetMinPrice:double;
begin
  Result:=otLABPRN.AcBPrice;
  oMinPLPriceHistory:='';
  oMinAPLPriceHistory:='';
  If cMinPriceDay>0 then begin
    Result:=GetMinPLPrice(Result);
    Result:=GetMinAPLPrice(Result);
  end;
end;

function TLabPrn.GetMinPLPrice(pPrice:double):double;
var mFirstDate:TDateTime;
begin
  Result:=pPrice;
  OpenPLH;
  If ohPLH.Active then begin
    If ohPLH.BtrTable.RecordCount>0 then begin
      If ohPLH.LocateGsCode(otLABPRN.GsCode) then begin
        mFirstDate:=Now-cMinPriceDay;
        Repeat
          If ohPLH.CrtDate>=mFirstDate then begin
            If IsNul(Result) then begin
              Result:=ohPLH.OBPrice;
            end else begin
              If ohPLH.OBPrice<Result then Result:=ohPLH.OBPrice;
            end;
            If IsNul(Result) then begin
              Result:=ohPLH.NBPrice;
            end else begin
              If ohPLH.NBPrice<Result then Result:=ohPLH.NBPrice;
            end;
            AddMinPLPriceHistory;
          end;
          Application.ProcessMessages;
          ohPLH.Next;
        until (ohPLH.GsCode<>otLABPRN.GsCode) or ohPLH.Eof;
      end;
    end;
  end;
end;

function TLabPrn.GetMinAPLPrice(pPrice:double):double;
var mAPLITM:TAplitmHnd; mFirstDate:TDateTime;
begin
  Result:=pPrice;
  mAPLITM:=TAplitmHnd.Create;
  mAPLITM.Open;
  If mAPLITM.LocateAnGs(oMasterAplItm.FieldByName('AplNum').AsInteger, oMasterAplItm.FieldByName('GsCode').AsInteger) then begin
    mFirstDate:=Now-cMinPriceDay;
    Repeat
      If mAPLITM.ActPos<>GetActPos(oMasterAplItm) then begin
        If (mAPLITM.BegDate<=Date) and (mAPLITM.EndDate>=mFirstDate) then begin
          If IsNul(Result) then begin
            Result:=mAPLITM.AcBPrice;
          end else begin
            If mAPLITM.AcBPrice<Result then Result:=mAPLITM.AcBPrice;
          end;
          AddMinAPLPriceHistory(mAPLITM.BtrTable);
        end;
      end;
      Application.ProcessMessages;
      mAPLITM.Next;
    until mAPLITM.Eof or (mAPLITM.GsCode<>oMasterAplItm.FieldByName('GsCode').AsInteger) or (mAPLITM.AplNum<>oMasterAplItm.FieldByName('AplNum').AsInteger);
  end;
  FreeAndNil(mAPLITM);
end;

function  TLabPrn.GetActPos(pTbl:TDataSet):longint;
begin
  If pTbl is TBtrieveTable
    then Result := (pTbl as TBtrieveTable).ActPos
    else Result := pTbl.FieldByName('RecActPos').AsInteger;
end;

function TLabPrn.OpenPLH:boolean;
var mhAplLst:TApllstHnd;
begin
  If not ohPLH.Active then begin
    mhAplLst:=TApllstHnd.Create;
    mhAplLst.Open;
    If mhAplLst.LocateAplNum(oMasterAplItm.FieldByName('AplNum').AsInteger) then ohPLH.Open(mhAplLst.PlsNum);
    FreeAndNil(mhAplLst);
  end;
end;

procedure TLabPrn.AddMinPLPriceHistory;
begin
  If oMinPLPriceHistory<>'' then oMinPLPriceHistory:=oMinPLPriceHistory+',';
  oMinPLPriceHistory:=oMinPLPriceHistory+DateToStr(ohPLH.CrtDate)+':'+StrDoub(ohPLH.OBPrice,0,2)+':'+StrDoub(ohPLH.NBPrice,0,2);
end;

procedure TLabPrn.AddMinAPLPriceHistory(pAPLITM:TDataSet);
begin
  If oMinAPLPriceHistory<>'' then oMinAPLPriceHistory:=oMinAPLPriceHistory+',';
  oMinAPLPriceHistory:=oMinAPLPriceHistory+DateToStr(pAPLITM.FieldByName('BegDate').AsDateTime)+':'
                       +DateToStr(pAPLITM.FieldByName('EndDate').AsDateTime)+':'
                       +StrDoub(pAPLITM.FieldByName('AcBPrice').AsFloat,0,2);
end;

procedure TLabPrn.AddToActionPricePrnHistory;
var mPath,mFile:string;
begin
  mPath:=gPath.LogPath+'APL_LOG\';
  mFile:='APL'+FormatDateTime('yyyymm',Date)+'.LOG';
  If not DirectoryExists(mPath) then ForceDirectories(mPath);
  If not FileExists(mPath+mFile) then WriteStrToFile(mPath+mFile, GetActionPricePrnHistoryHead);
  WriteStrToFile(mPath+mFile, GetActionPricePrnHistoryStr);
end;

function TLabPrn.GetActionPricePrnHistoryStr:string;
var mWrap:TTxtWrap;
begin
  mWrap := TTxtWrap.Create;
  mWrap.SetDelimiter('');
  mWrap.SetSeparator(';');
  mWrap.SetText(FormatDateTime('dd.mm.yyyy hh:nn:ss,zzz', Now), 0);
  mWrap.SetNum(otLABPRN.GsCode, 0);
  mWrap.SetText(otLABPRN.GsName, 0);
  mWrap.SetReal(otLABPRN.AcXPrice, 0, 2);
  mWrap.SetReal(otLABPRN.AcBPrice, 0, 2);
  mWrap.SetReal(otLABPRN.MinPrice, 0, 2);
  mWrap.SetText(oMinPLPriceHistory, 0);
  mWrap.SetText(oMinAPLPriceHistory, 0);
  Result := mWrap.GetWrapText;
  FreeAndNil (mWrap);
end;

function TLabPrn.GetActionPricePrnHistoryHead:string;
var mWrap:TTxtWrap;
begin
  mWrap := TTxtWrap.Create;
  mWrap.SetDelimiter('');
  mWrap.SetSeparator(';');
  mWrap.SetText('Dátum a èas vytlaèenia', 0);
  mWrap.SetText('PLU', 0);
  mWrap.SetText('Názov tovaru', 0);
  mWrap.SetText('Akciová cena', 0);
  mWrap.SetText('Cenníková cena', 0);
  mWrap.SetText('Najnižšia cena', 0);
  mWrap.SetText('História zmien PC v cenníku', 0);
  mWrap.SetText('História zmien akciových cien', 0);
  Result := mWrap.GetWrapText;
  FreeAndNil (mWrap);
end;

end.

