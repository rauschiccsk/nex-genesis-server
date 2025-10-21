unit Htl;
{$F+}

// *****************************************************************************
//             OBJEKT NA PRACU S Hotelovy a rezervacnym systemom
// *****************************************************************************
// Programové funkcia:
// ---------------
// *****************************************************************************


interface

uses
  IcTypes, IcConst, IcConv, IcTools,
  NexBtrTable, NexGlob, NexPath, NexIni, NexMsg, NexError,
  StkGlob, DocHand, LinLst,  SavClc, TxtDoc, TxtWrap, Stk,
  Rep, Bok, Key, Tcd,
  hRSH, hRSS, hRSI,
  hTNH, hTNI, hTNV, hTNP, hTNS, hTNR, tTNH, tTNI, tTNV, tTNP, tTNS,
  hGsCat, hSystem, hPab, tNot,
  DB, SysUtils, Classes, Graphics, ExtCtrls, Jpeg, Forms;

type
  THtl = class(TComponent)
    constructor Create;
    destructor  Destroy; override;
    private
      oTentNum : longint;
      oPlsNum  : word;
      oPaCode  : longint;
      oSpaCode : longint;
      oWpaCode : word;
      oDateI,
      oDateO   : TDateTime;
    public
      ohPAB:TPabHnd;
      ohTNH:TTNHHnd;
      ohTNI:TTNIHnd;
      ohTNV:TTNVHnd;
      ohTNS:TTNSHnd;
      ohTNP:TTNPHnd;
      ohTNR:TTNRHnd;

      otTNI:TTNITmp;
      otTNV:TTNVTmp;
      otTNS:TTNSTmp;
      otTNP:TTNPTmp;
//      otTNR:TTNRTmp;
      procedure NewDoc(DateI,DateO:TDateTime;pRooms:String); // Vygeneruje novu hlavicku dokladu
      procedure PrnDoc(pTentNum:longint;pRepName:Str10); // Vytlaèí aktualny doklad
      procedure ClcDoc; overload; // Prepocita hlavicku aktualneho dokladu podla jeho poloziek
      procedure ClcDoc(pTentNum:longint); overload;  // Prepocita hlavicku zadaneho dokladu podla jeho poloziek
      procedure DelTnv (pTentNum:longint);
      procedure DelTni (pTentNum:longint);
      procedure DelTen (pTentNum:longint);
      procedure SlcTni(pTentNum:longint);
      procedure SlcTnv(pTentNum:longint);
      procedure SlcTen(pTentNum:longint);
      procedure AddTcd(pSerNum:longint);
      procedure DelTcd(pSerNum:longint);
    published
      property phTNH:TTNHHnd read ohTNH write ohTNH;
      property phTNI:TTNIHnd read ohTNI write ohTNI;
      property Tent:longint read oTentNum;
      property PlsNum:word write oPlsNum;
      property PaCode:longint write oPaCode;
      property SpaCode:longint write oSpaCode;
      property WpaCode:word write oWpaCode;
  end;

implementation

uses bTNS, bTCH, bTCI;


constructor THtl.Create;
begin
  oPlsNum := 1;
  ohPAB := TPabHnd.Create; ohPAB.Open(0);
  ohTnh := TTnhHnd.Create; ohTnh.Open;
  ohTni := TTniHnd.Create; ohTni.Open;
  ohTnv := TTnvHnd.Create; ohTnv.Open;
  ohTnp := TTnpHnd.Create; ohTnp.Open;
  ohTnr := TTnrHnd.Create; ohTnr.Open;
  ohTns := TTnsHnd.Create; ohTns.Open;
  otTNI := TTNITmp.Create;
  otTNV := TTNVTmp.Create;
  otTNP := TTnpTmp.Create;
//  otTNR := TTnrTmp.Create;
  otTNS := TTnsTmp.Create;
end;

destructor THtl.Destroy;
var I:word;
begin
  otTnI.Close;FreeAndNil(otTnI);
  otTnV.Close;FreeAndNil(otTnV);
  otTnp.Close;FreeAndNil(otTnp);
//  otTnr.Close;FreeAndNil(otTnr);
  otTns.Close;FreeAndNil(otTns);
  FreeAndNil (ohTnV);
  FreeAndNil (ohTnI);
  FreeAndNil (ohTnH);
  FreeAndNil (ohTnp);
  FreeAndNil (ohTnr);
  FreeAndNil (ohTns);
  FreeAndNil (ohPAB);
end;

// ********************************* PRIVATE ***********************************

// ********************************** PUBLIC ***********************************

procedure THtl.NewDoc; // Vygeneruje novu hlavicku dokladu TNH.BDF
begin
  If oTentNum=0 then oTentNum := ohTNH.NextTentNum; // Ak nie je zadane poradove cislo vygenerujeme nasledujuce
  If oDateI=0 then oDateI := Date;   // Ak nie je zadany datum prichodu nastavime aktualny den
  If oDateO=0 then oDateO := Date+1; // Ak nie je zadany datum odchodu nastavime zajtrajsi den
  If not ohTNH.LocateTentNum(oTentNum) then begin // Ak neexistuje vyvorime hlacicku dokladu
    ohTNH.Insert;
    ohTNH.TentNum := oTentNum;
    ohTNH.DateI := oDateI;
    ohTNH.DateO := oDateO;
    ohTNH.DvzName := gIni.SelfDvzName;
    If ohPAB.LocatePaCode(oPaCode) then begin
      BTR_To_BTR (ohPAB.BtrTable,ohTNH.BtrTable);
      // Zadat aj miesto dodania
    end;
    ohTNH.Post;
  end;
end;

procedure THtl.PrnDoc(pTentNum:longint;pRepName:Str10); // Vytlaèí aktualny doklad
var mLinNum:byte;   mInfVal:double; mRep:TRep;
  mtTNH: TTNHTmp; mtNOT: TNotTmp; mhSYSTEM:TSystemHnd;
begin
  mtNOT   := TNotTmp.Create; mtNOT.Open;
  mtTNH   := TTNHTmp.Create; mtTNH.Open;
  mhSYSTEM := TSystemHnd.Create;  mhSYSTEM.Open;
  mtTNH.Insert;
  BTR_To_PX (ohTNH.BtrTable,mtTNH.TmpTable);
  mtTNH.Post;
  // Pozbierame poznamky k dokladu
  ohTNV.NearestTentNum (ohTNH.TentNum);
  If ohTNV.TentNum=ohTNH.TentNum then begin
    mtNOT.Insert;
    mLinNum := 0;
    Repeat
      Inc (mLinNum);
//      mtNOT.TmpTable.FieldByName ('Notice'+StrInt(mLinNum,0)).AsString := ohTNV.Notice;
      ohTNV.Next;
    until (ohTNV.Eof) or (mLinNum>=5) or (ohTNV.TentNum<>ohTNH.TentNum);
    mtNOT.Post;
  end;
  // Polozky vybraneho dokladu
  otTNI.Open;otTNI.TmpTable.DelRecs;
  If ohTNI.LocateTentNum (ohTNH.TentNum) then begin
    Repeat
      otTNI.Insert;
      BTR_To_PX(ohTNI.BtrTable,otTNI.TmpTable);
      otTNI.Post;
      ohTNI.Next;
    until (ohTNI.Eof) or (ohTNI.TentNum<>ohTNH.TentNum);
  end;

  mRep := TRep.Create(Self);
  mRep.SysBtr := mhSYSTEM.BtrTable;
  mRep.HedTmp := mtTNH.TmpTable;
  mRep.ItmTmp := otTNI.TmpTable;
  mRep.SpcTmp := mtNOT.TmpTable;
  mRep.Execute(pRepName);
  FreeAndNil (mRep);

  otTNI.Close;
  mtTNH.Close;
  mtNOT.Close;
  FreeAndNil(mtNot);
  FreeAndNil(mtTNH);
end;

procedure THtl.ClcDoc; // Prepocita hlavicku zadaneho dokladu podla jeho poloziek
begin
  //ohTNH.Clc(ohTNI);
end;

procedure THtl.ClcDoc(pTentNum:longint); // Prepocita hlavicku zadaneho dokladu podla jeho poloziek
begin
//  If ohTNH.LocateTentNum(pTentNum) then ohTNH.Clc(ohTNI);
end;

procedure THtl.SlcTni(pTentNum: longint);
begin
  If otTNI.Active then otTNI.Close;
  otTNI.Open;
  If ohTNH.LocateTentNum(pTentNum) then begin
    If ohTNI.LocateTentNum(pTentNum) then begin
      Repeat
        otTNI.Insert;
        BTR_To_PX (ohTNI.BtrTable,otTNI.TmpTable);
        otTNI.Post;
        Application.ProcessMessages;
        ohTNI.Next;
      until ohTNI.Eof or (ohTNI.TentNum<>pTentNum);
    end;
  end;
end;

procedure THtl.SlcTnv(pTentNum: longint);
begin
  If otTNV.Active then otTNV.Close;
  otTNV.Open;
  If ohTNH.LocateTentNum(pTentNum) then begin
    If ohTNV.LocateTentNum(pTentNum) then begin
      Repeat
        otTNV.Insert;
        BTR_To_PX (ohTNV.BtrTable,otTNV.TmpTable);
        otTNV.Post;
        Application.ProcessMessages;
        ohTNV.Next;
      until ohTNV.Eof or (ohTNV.TentNum<>pTentNum);
    end;
  end;
end;

procedure THtl.SlcTen(pTentNum: longint);
begin
  If otTNV.Active then otTNV.Close;
  otTNV.Open;
  If ohTNH.LocateTentNum(pTentNum) then begin
    If ohTNV.LocateTentNum(pTentNum) then begin
      Repeat
        otTNV.Insert;BTR_To_PX (ohTNV.BtrTable,otTNV.TmpTable);otTNV.Post;
        ohTNV.Next;
      until ohTNV.Eof or (ohTNV.TentNum<>pTentNum);
    end;
  end;
  If otTni.Active then otTni.Close;
  otTni.Open;
  If ohTNH.LocateTentNum(pTentNum) then begin
    If ohTni.LocateTentNum(pTentNum) then begin
      Repeat
        otTni.Insert;BTR_To_PX (ohTni.BtrTable,otTni.TmpTable);otTni.Post;
        ohTni.Next;
      until ohTni.Eof or (ohTni.TentNum<>pTentNum);
    end;
  end;
  If otTns.Active then otTns.Close;
  otTns.Open;
  If ohTNH.LocateTentNum(pTentNum) then begin
    If ohTns.LocateTentNum(pTentNum) then begin
      Repeat
        otTns.Insert;BTR_To_PX (ohTns.BtrTable,otTns.TmpTable);otTns.Post;
        ohTns.Next;
      until ohTns.Eof or (ohTns.TentNum<>pTentNum);
    end;
  end;
{
  If otTnr.Active then otTnr.Close;
  otTnr.Open;
  If ohTNH.LocateTentNum(pTentNum) then begin
    If ohTnr.LocateTentNum(pTentNum) then begin
      Repeat
        otTnr.Insert;BTR_To_PX (ohTnr.BtrTable,otTnr.TmpTable);otTnr.Post;
        ohTnr.Next;
      until ohTnr.Eof or (ohTnr.TentNum<>pTentNum);
    end;
  end;
}
  If otTnp.Active then otTnp.Close;
  otTnp.Open;
  If ohTNH.LocateTentNum(pTentNum) then begin
    If ohTnp.LocateTentNum(pTentNum) then begin
      Repeat
        otTnp.Insert;BTR_To_PX (ohTnp.BtrTable,otTnp.TmpTable);otTnp.Post;
        ohTnp.Next;
      until ohTnp.Eof or (ohTnp.TentNum<>pTentNum);
    end;
  end;
  Application.ProcessMessages;
end;

procedure THtl.DelTnv(pTentNum: longint);
begin
  If ohTNV.LocateTentNum (pTentNum) then begin
    Repeat ohTNV.Delete; until (ohTNV.Eof) or (ohTNV.TentNum<>pTentNum);
  end;
end;

procedure THtl.DelTni(pTentNum: longint);
begin
  If ohTNI.LocateTentNum (pTentNum) then begin
    Repeat ohTNI.Delete; until (ohTNI.Eof) or (ohTNI.TentNum<>pTentNum);
  end;
end;

procedure THtl.DelTen(pTentNum: longint);
begin
  If ohTNV.LocateTentNum (pTentNum) then begin
    Repeat ohTNV.Delete; until (ohTNV.Eof) or (ohTNV.TentNum<>pTentNum);
  end;
  If ohTni.LocateTentNum (pTentNum) then begin
    Repeat ohTni.Delete; until (ohTni.Eof) or (ohTni.TentNum<>pTentNum);
  end;
  If ohTns.LocateTentNum (pTentNum) then begin
    Repeat ohTns.Delete; until (ohTns.Eof) or (ohTns.TentNum<>pTentNum);
  end;
  If ohTnr.LocateTentNum (pTentNum) then begin
    Repeat ohTnr.Delete; until (ohTnr.Eof) or (ohTnr.TentNum<>pTentNum);
  end;
  If ohTnp.LocateTentNum (pTentNum) then begin
    Repeat ohTnp.Delete; until (ohTnp.Eof) or (ohTnp.TentNum<>pTentNum);
  end;
  If ohTnh.LocateTentNum (pTentNum) then ohTNH.Delete;
end;

procedure THtl.AddTcd(pSerNum: Integer);
var mhGsCat:TGscatHnd; mTcd:TTcd; mF:boolean; mSerNum,mT,mI:longint; mExt:String;
begin
  mhGsCat:=TGscatHnd.Create;mhGsCat.Open;
  If ohTNS.LocateSerNum(pSerNum) and (ohTNS.GsCode>0) and (ohTNS.SrvCode=0) and mhGsCat.LocateGsCode(ohTns.GsCode)
  then begin
    mTcd:=TTcd.Create;
    mTcd.Open(gKey.CasTcdBok[0]);
    mSerNum:=ohTNS.SerNum;
    mT:=ohTNS.TentNum;
    mExt:=StrIntZero(mT,7);
    mF:=mTcd.ohTCH.LocateExtNum(mExt) and (mTcd.ohTCH.DocDate=Date);
    while not mF and not mTcd.ohTCH.Eof and (mTcd.ohTCH.ExtNum=mExt) do begin
      mTcd.ohTCH.Next;
      mF:=(mTcd.ohTCH.ExtNum=mExt)and (mTcd.ohTCH.DocDate=Date);
    end;
    If not mF then begin
      ohTNH.LocateTentNum(mT);
      mTcd.NewDoc('',ohTNH.Group,ohTNS.StkNum,True);
      mTcd.ohTCH.Edit;mTcd.ohTCH.ExtNum:=mExt;mTcd.ohTCH.Post;
    end;
    mTcd.LocDoc(mTcd.ohTCH.DocNum);
    mTcd.AddItm(ohTNS.StkNum,ohTNS.GsCode,ohTNS.Quant,0,ohTNS.DscPrc,ohTNS.Bprice,ohTNS.WriNum,'');
    ohTNS.Edit;
    ohTNS.TcdNum   := mTcd.ohTCI.DocNum;
    ohTNS.TcdItm   := mTcd.ohTCI.ItmNum;
    ohTNS.Post;
    mTcd.CnfDoc;mTcd.SubDoc;mTcd.ClcDoc;
  end;
  FreeAndNil(mhGsCat);
end;

procedure THtl.DelTcd(pSerNum: Integer);
var mhGsCat:TGscatHnd; mTcd:TTcd; mF:boolean; mSerNum,mT,mI:longint; mExt:String;
begin
  mhGsCat:=TGscatHnd.Create;mhGsCat.Open;
  If ohTNS.LocateSerNum(pSerNum) and (ohTNS.GsCode>0) and (ohTNS.SrvCode=0) and mhGsCat.LocateGsCode(ohTns.GsCode)
  then begin
    mTcd:=TTcd.Create;
    mTcd.Open(gKey.CasTcdBok[0]);
    mSerNum:=ohTNS.SerNum;
    mT:=ohTNS.TentNum;
    mExt:=StrIntZero(mT,7);
    mTcd.LocDoc(ohTNS.TcdNum);
    mF:=mTcd.ohTCH.LocateDocNum(ohTNS.TcdNum) and mTcd.ohTCI.LocateDoIt(ohTNS.TcdNum,ohTNS.TcdItm);
    If mF then begin
      mTcd.UnsTcc(ohTNS.TcdNum,ohTNS.TcdItm,0);
      If mTcd.DelTcc(ohTNS.TcdNum,ohTNS.TcdItm,0) then begin
        mTcd.ohTCI.Delete;
        ohTNS.Edit;
        ohTNS.TcdNum   := '';
        ohTNS.TcdItm   := 0;
        ohTNS.Post;
        mTcd.CnfDoc;{mTcd.SubDoc;}mTcd.ClcDoc;
      end;  
    end;
    FreeAndNil(mTcd);
  end;
  FreeAndNil(mhGsCat);
end;

end.
{MOD 1810003} 
