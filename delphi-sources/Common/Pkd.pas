unit Pkd;
{$F+}

// *****************************************************************************
//                OBJEKT NA PRACU S PREBALOVACIMI DOKLADMI
// *****************************************************************************
// Programové funkcia:
// ---------------
// Gen - vygeneruje prebalovaci doklad zo zoznamu zadanych položiek.
// *****************************************************************************


interface

uses
  pBOKLST,
  IcTypes, IcConst, IcConv, IcTools, IcVariab,
  NexGlob, NexPath, NexMsg, NexError, StkHand,
  Key, Stk,
  tDOCITM, hPKCLST, hPKH, hPKI,
  ComCtrls, SysUtils, Classes, Forms, Dialogs;

type
  TPkd = class(TComponent)
    constructor Create;
    destructor  Destroy; override;
    private
      oSerNum: longint;
      oDocNum: Str12;
      oDocDate: TDateTime;
      oStk: TStk;
      ohPKH: TPkhHnd;
      ohPKI: TPkiHnd;
      otBOKLST:TBoklstTmp;
//      otDOCITM: TDocitmTmp;
    public
      procedure Open(pBokNum:Str5);
      procedure Gen(pYear:Str2;pBokNum:Str5;ptDOCITM:TDocitmTmp;pIndicator:TProgressBar); // Vygeneruje prebalovaci doklad zo zoznamu zadanych položiek.
      procedure Sub(phPKI:TPkiHnd);
      procedure Add(pDocNum:Str12;pSrcGsc,pTrgGsc:longint;pGsQnt:double;pScdNum:Str12;pScdItm:longint);
    published
      property SerNum:longint write oSerNum;
      property DocNum:Str12 read oDocNum;
      property DocDate:TDateTime write oDocDate;
  end;

implementation

constructor TPkd.Create;
begin
  ohPKH:=TPkhHnd.Create;
  ohPKI:=TPkiHnd.Create;
  oStk:=TStk.Create;
end;

destructor TPkd.Destroy;
begin
  FreeAndNil(oStk);
  FreeAndNil (ohPKI);
  FreeAndNil (ohPKH);
end;

// ********************************* PRIVATE ***********************************

// ********************************** PUBLIC ***********************************

procedure TPkd.Open(pBokNum:Str5);
begin
  If not ohPKH.Active then begin
    ohPKH.Open(pBokNum);
    ohPKI.Open(pBokNum);
  end;  
end;

procedure TPkd.Gen(pYear:Str2;pBokNum:Str5;ptDOCITM:TDocitmTmp;pIndicator:TProgressBar); // Vytvori OD na zaklade zadaneho zdrojoveho dokladu
var mhPKCLST:TPkclstHnd;  mSerNum,mItmNum:longint;  mDocNum:Str12;
begin
  If pYear='' then pYear:=gvSys.actyear2;
  If ptDOCITM.Count>0 then begin
    otBOKLST := TBoklstTmp.Create; otBOKLST.Open;
    otBOKLST.LoadToTmp('PKB');
    mhPKCLST := TPkclstHnd.Create;  mhPKCLST.Open;
    If otBOKLST.LocateBookNum(pBokNum) then begin
      Open(pBokNum);
      // Vytvorime hlavicku prebalovacieho dokladu
      mSerNum := ohPKH.NextYearSerNum(pYear);
      mDocNum := ohPKH.GenDocNum(pYear,mSerNum);
      ohPKH.Insert;
      ohPKH.SerNum   := mSerNum;
      ohPKH.DocNum   := mDocNum;
      ohPKH.StkNum   := gKey.PkbStkNum[otBOKLST.BokNum];
      ohPKH.ScSmCode := gKey.PkbSrcSmc[otBOKLST.BokNum];
      ohPKH.TgSmCode := gKey.PkbTrgSmc[otBOKLST.BokNum];
      ohPKH.Describe := 'Automatické prebalenie';
      ohPKH.DocDate  := Date;
      ohPKH.DstLck   := TRUE;
      ohPKH.Post;
      // Vytvorime polozky prebalovacieho dokladu
      oStk := TStk.Create;
      mItmNum := ohPKI.NextItmNum(mDocNum);
      pIndicator.Max := ptDOCITM.Count;
      pIndicator.Position := 0;
      ptDOCITM.First;
      Repeat
        pIndicator.StepBy(1);
        If mhPKCLST.LocateScGsCode(ptDOCITM.GsCode) then begin
          ohPKI.Insert;
          ohPKI.DocNum := mDocNum;
          ohPKI.ItmNum := mItmNum;
          ohPKI.StkNum := ohPKH.StkNum;
          ohPKI.ScSmCode := ohPKH.ScSmCode;
          ohPKI.ScGsCode := mhPKCLST.ScGsCode;
          ohPKI.ScMgCode := ptDOCITM.MgCode;
          ohPKI.ScGsName := mhPKCLST.ScGsName;
          ohPKI.ScBarCode := mhPKCLST.ScBarCode;
          ohPKI.ScGsQnt := ptDOCITM.GsQnt/mhPKCLST.ScGsKfc;
          ohPKI.ScMsName := ptDOCITM.MsName;
//        ohPKI.TgMgCode
          ohPKI.TgSmCode := ohPKH.TgSmCode;
          ohPKI.TgGsCode := mhPKCLST.TgGsCode;
          ohPKI.TgGsName := mhPKCLST.TgGsName;
          ohPKI.TgBarCode := mhPKCLST.TgBarCode;
          ohPKI.TgGsQnt := (ohPKI.ScGsQnt*mhPKCLST.TgGsKfc)/mhPKCLST.ScGsKfc;
//        ohPKI.TgMsName
          ohPKI.StkStat := 'N';
          ohPKI.DocDate := ohPKH.DocDate;
          ohPKI.ScdNum := ptDOCITM.DocNum;
          ohPKI.ScdItm := ptDOCITM.ItmNum;
          ohPKI.Post;
          // Odpocitame tovar zo skladovej karty
          Sub(ohPKI);
          // Odkaz na riadok prebalovacieho dokladu
          ptDOCITM.Edit;
          ptDOCITM.TgdNum := mDocNum;
          ptDOCITM.TgdItm := mItmNum;
          ptDOCITM.Post;
          Inc (mItmNum);
        end;
        Application.ProcessMessages;
        ptDOCITM.Next;
      until ptDOCITM.Eof;
      ohPKH.Clc(ohPKI);
    end
    else ShowMsg (ecSysBookIsNotExist,pBokNum);
    FreeAndNil (mhPKCLST);
    otBOKLST.Close;FreeAndNil(otBOKLST);
  end;
end;

procedure TPkd.Sub(phPKI:TPkiHnd);
begin
  If phPKI.StkStat='N' then begin
    oStk.Clear;
    oStk.SmSign := '-';  // Vydaj tovaru
    oStk.DocNum := phPKI.DocNum;
    oStk.ItmNum := phPKI.ItmNum;
    oStk.DocDate := phPKI.DocDate;
    oStk.GsCode := phPKI.ScGsCode;
    oStk.MgCode := phPKI.ScMgCode;
    oStk.BarCode := phPKI.ScBarCode;
    oStk.SmCode := phPKI.ScSmCode;
    oStk.GsName := phPKI.ScGsName;
    oStk.GsQnt := phPKI.ScGsQnt;
    If oStk.Sub(phPKI.StkNum) then begin // Ak sa podarilo vydat polozky
      // Ulozime nakupnu cenu a priznak ze skladovy pohyb vydaja bol urobeny
      phPKI.Edit;
      phPKI.ScCValue := oStk.CValue;
      phPKI.TgCValue := oStk.CValue;
      phPKI.ScCPrice := RoundCPrice(oStk.CValue/phPKI.ScGsQnt);
      phPKI.TgCPrice := RoundCPrice(oStk.CValue/phPKI.TgGsQnt);
//      phPKI.DrbDate := dmSTK.GetOutDrbDate;
      If phPKI.StkStat='N' then phPKI.StkStat := 'O';
      phPKI.Post;
    end;
  end;
  If phPKI.StkStat='O' then begin
    oStk.Clear;
    oStk.SmSign := '+';  // Prijem tovaru
    oStk.DocNum := phPKI.DocNum;
    oStk.ItmNum := phPKI.ItmNum+10000;
    oStk.DocDate := phPKI.DocDate;
    oStk.GsCode := phPKI.TgGsCode;
    oStk.MgCode := phPKI.TgMgCode;
    oStk.BarCode := phPKI.TgBarCode;
    oStk.SmCode := phPKI.TgSmCode;
    oStk.GsName := phPKI.TgGsName;
    oStk.GsQnt := phPKI.TgGsQnt;
    oStk.CPrice := phPKI.TgCPrice;
    oStk.DrbDate := phPKI.DrbDate;
    oStk.Sub(phPKI.StkNum); // Prijem tovaru na skladovu kartu
    phPKI.Edit;
    If phPKI.StkStat='O' then phPKI.StkStat := 'S';
    phPKI.Post;
  end;
(*
  mSub := TSubtract.Create;
  If phPKI.StkStat='N' then begin
    mSub.ClearGsData;
    mSub.PutSmSign ('-');  // Vydaj tovaru
    mSub.PutDocNum (phPKI.DocNum);
    mSub.PutItmNum (phPKI.ItmNum);
    mSub.PutDocDate (phPKI.DocDate);
    mSub.PutGsCode (phPKI.ScGsCode);
    mSub.PutMgCode (phPKI.ScMgCode);
    mSub.PutBarCode (phPKI.ScBarCode);
    mSub.PutSmCode (phPKI.ScSmCode);
    mSub.PutGsName (phPKI.ScGsName);
    mSub.PutGsQnt (phPKI.ScGsQnt);
    mSub.PutCPrice (dmSTK.GetOutFifValue/phPKI.ScGsQnt);
    Result := mSub.Output;
    If Result then begin
      oCValue := dmSTK.GetOutFifValue;
      phPKI.Edit;
      phPKI.ScCValue := oCValue;
      phPKI.ScCPrice := RoundCPrice(oCValue/dmSTK.GetOutFifosQnt);
      phPKI.TgCValue := oCValue;
      phPKI.TgCPrice := RoundCPrice(oCValue/dmSTK.btPKI.FieldByName ('TgGsQnt').AsFloat);
      phPKI.DrbDate := dmSTK.GetOutDrbDate;
      If phPKI.StkStat='N' then phPKI.StkStat := 'O';
      dmSTK.btPKI.Post;
    end
  end;
  If phPKI.StkStat='O' then begin
    mSub.ClearGsData;
    mSub.PutDocNum (phPKI.DocNum);
    mSub.PutItmNum (phPKI.ItmNum+10000);
    mSub.PutDocDate (phPKI.DocDate);
    mSub.PutGsCode (phPKI.TgGsCode);
    mSub.PutMgCode (phPKI.TgMgCode);
    mSub.PutBarCode (phPKI.TgBarCode);
    mSub.PutSmCode (phPKI.TgSmCode);
    mSub.PutGsName (phPKI.TgGsName);
    mSub.PutGsQnt (phPKI.TgGsQnt);
    mSub.PutCPrice (phPKI.TgCPrice);
    mSub.PutDrbDate (phPKI.DrbDate);
    Result := TRUE;
    mSub.PutSmSign ('+');  // Prijem tovaru
    mSub.Input;
    dmSTK.btPKI.Edit;
    If phPKI.StkStat='O' then phPKI.StkStat := 'S';
    dmSTK.btPKI.Post;
  end;
  FreeAndNil (mSub);
*)
end;

procedure TPkd.Add(pDocNum:Str12;pSrcGsc,pTrgGsc:longint;pGsQnt:double;pScdNum:Str12;pScdItm:longint);
var mItmNum:word;
begin
  If ohPKH.LocateDocNum(pDocNum) then begin
    mItmNum:=ohPKI.NextItmNum(pDocNum);
    If not oStk.ohGSCAT.Active then oStk.ohGSCAT.Open;
    ohPKI.Insert;
    ohPKI.DocNum:=pDocNum;
    ohPKI.ItmNum:=mItmNum;
    ohPKI.StkNum:=ohPKH.StkNum;
    ohPKI.DocDate:=ohPKH.DocDate;
    ohPKI.ScSmCode:=ohPKH.ScSmCode;
    ohPKI.TgSmCode:=ohPKH.TgSmCode;
    ohPKI.ScGsQnt:=pGsQnt;
    ohPKI.TgGsQnt:=pGsQnt;
    ohPKI.ScGsCode:=pSrcGsc;
    ohPKI.TgGsCode:=pTrgGsc;
    If oStk.ohGSCAT.LocateGsCode(pSrcGsc) then begin
      ohPKI.ScGsName:=oStk.ohGSCAT.GsName;
      ohPKI.ScMgCode:=oStk.ohGSCAT.MgCode;
      ohPKI.ScBarCode:=oStk.ohGSCAT.BarCode;
      ohPKI.ScMsName:=oStk.ohGSCAT.MsName;
    end else MessageDlg('Neexistujúce tovarové èíslo v bázovej evidencii: '+StrInt(pTrgGsc,0),mtInformation,[mbOk],0);
    If oStk.ohGSCAT.LocateGsCode(pTrgGsc) then begin
      ohPKI.TgGsName:=oStk.ohGSCAT.GsName;
      ohPKI.TgMgCode:=oStk.ohGSCAT.MgCode;
      ohPKI.TgBarCode:=oStk.ohGSCAT.BarCode;
      ohPKI.TgMsName:=oStk.ohGSCAT.MsName;
    end else MessageDlg('Neexistujúce tovarové èíslo v bázovej evidencii: '+StrInt(pTrgGsc,0),mtInformation,[mbOk],0);
    ohPKI.StkStat:='N';
    ohPKI.ScdNum:=pScdNum;
    ohPKI.ScdItm:=pScdItm;
    ohPKI.Post;
    // Odpocitame tovar zo skladovej karty
    Sub(ohPKI);
  end else MessageDlg('Neexistujúci doklad: '+pDocNum,mtInformation,[mbOk],0);
end;

end.
{MOD 1907001}
