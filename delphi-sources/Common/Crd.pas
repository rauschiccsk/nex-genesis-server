unit Crd;
{$F+}

// *****************************************************************************
//                OBJEKT NA PRACU So ZAKAZNICKYMI KARTAMI
// *****************************************************************************
// Programové funkcia:
// ---------------
// PrnBon - tlac bonusovaej poukazky.
// *****************************************************************************


interface

uses
  IcTypes, IcConst, IcConv, IcTools, IcDate, NexGlob, NexPath, NexMsg, RepHand, Key,
  hCRDLST, hCRDMOV, tCRDMOV, hPAB, tDHEAD,
  ComCtrls, SysUtils, Classes, Forms;

type
  TCrd = class(TComponent)
    constructor Create; overload;
    destructor  Destroy; override;
    private
      oDocNum:Str12;
    public
      ohCRDLST:TCrdlstHnd;
      ohCRDMOV:TCrdmovHnd;
      otCRDMOV:TCrdmovTmp;
//      constructor Create(pPath:ShortString); overload;
      procedure AddDoc(pCrdNum:Str20;pDocNum:Str12;pDocDat,pDocTim:TDateTime;pDocVal:double);
      procedure AddOut(pCrdNum:Str20;pDocNum:Str12;pDocDat:TDateTime;pOutQnt:integer);
      procedure ClcCrd(pCrdNum:Str20);  // Prepoèíta kumulatívne údaje zadanej zákazníckej karty
      procedure MovLst(pCrdNum:Str20);  // Pozbiera pohyby vybranej karty
      procedure PrnOut(pDocNum:Str12);
    published
      property DocNum:Str12 read oDocNum;
  end;

implementation

uses DM_SYSTEM, bCRDMOV;

constructor TCrd.Create;
begin
//  oPath:='';
  oDocNum:='';
  ohCRDLST:=TCrdlstHnd.Create;  ohCRDLST.Open;
  ohCRDMOV:=TCrdmovHnd.Create;  ohCRDMOV.Open;
  otCRDMOV:=TCrdmovTmp.Create;
end;

(*
constructor TCrd.Create(pPath: ShortString);
begin
  oPath:=pPath;
  ohCRDLST:=TCrdlstHnd.Create(pPath+'DIALS\');  ohCRDLST.Open;
  ohCRDMOV:=TCrdmovHnd.Create(pPath+'DIALS\');  ohCRDMOV.Open;
  otCRDMOV:=TCrdmovTmp.Create;

//  ohCRDBON := TCrdbonHnd.Create(pPath+'DIALS\');  ohCRDBON.Open;
//  ohCRDTRN := TCrdtrnHnd.Create(pPath+'CABACK\');  ohCRDTRN.Open;
end;
*)

destructor TCrd.Destroy;
begin
  FreeAndNil(otCRDMOV);
  FreeAndNil(ohCRDMOV);
  FreeAndNil(ohCRDLST);
end;

// ********************************** PRIVATE **********************************

// ********************************** PUBLIC ***********************************

procedure TCrd.ClcCrd(pCrdNum:Str20); // Prepoèíta kumulatívne údaje zadanej zákazníckej karty
var mItmNum:longint; mItmQnt,mLasItm:word;  mBegVal,mDocVal,mBonVal,mNebVal:double;  mBegBon,mInpBon,mOutBon:longint;
begin
  If ohCRDLST.LocateCrdNum(pCrdNum) then begin
    If ohCRDMOV.NearestCnIn(pCrdNum,1) then begin
      If ohCRDMOV.CrdNum=pCrdNum then begin
        mBegVal:=0;
        If ohCRDMOV.DocTyp='B' then mBegVal:=ohCRDMOV.BegVal;
        Repeat
          ohCRDMOV.Edit;
          ohCRDMOV.BegVal:=mBegVal;
          If ohCRDMOV.DocTyp<>'O' then begin
            If IsNotNul(ohCRDMOV.BonTrn) then ohCRDMOV.BonQnt:=Trunc((ohCRDMOV.BegVal+ohCRDMOV.DocVal)/ohCRDMOV.BonTrn);
          end;
          ohCRDMOV.Post;
          mBegVal:=ohCRDMOV.NouVal;
          Application.ProcessMessages;
          ohCRDMOV.Next;
        until ohCRDMOV.Eof or (ohCRDMOV.CrdNum<>pCrdNum);
      end;
    end;
    mItmQnt:=0;  mLasItm:=0;
    mBegVal:=0;  mDocVal:=0;  mBonVal:=0;  mBegBon:=0;  mInpBon:=0;  mOutBon:=0;
    If ohCRDMOV.LocateCrdNum(pCrdNum) then begin
      Repeat
        Inc(mItmQnt);
        If mLasItm<ohCRDMOV.ItmNum then begin
          mLasItm:=ohCRDMOV.ItmNum;
          mNebVal:=ohCRDMOV.NebVal;
        end;
        If ohCRDMOV.DocTyp='B' then begin
          mBegVal:=ohCRDMOV.BegVal;
          mBegBon:=ohCRDMOV.BonQnt;
        end;
        If ohCRDMOV.DocTyp='I' then mInpBon:=mInpBon+ohCRDMOV.BonQnt;
        If ohCRDMOV.DocTyp='O' then mOutBon:=mOutBon+ohCRDMOV.BonQnt*(-1);
        mDocVal:=mDocVal+ohCRDMOV.DocVal;
        If ohCRDMOV.BonQnt>0 then mBonVal:=mBonVal+ohCRDMOV.BonQnt*ohCRDMOV.BonTrn;
        Application.ProcessMessages;
        ohCRDMOV.Next;
      until ohCRDMOV.Eof or (ohCRDMOV.CrdNum<>pCrdNum);
    end;
    ohCRDLST.Edit;
    ohCRDLST.BegVal:=mBegVal;
    ohCRDLST.DocVal:=mDocVal;
    If ohCRDLST.CrdType='D' then begin
      ohCRDLST.BonTrn:=0;
      ohCRDLST.BonVal:=0;
      ohCRDLST.NouVal:=0;
      ohCRDLST.NebVal:=0;
      ohCRDLST.TrnVal:=0;
      ohCRDLST.BegBon:=0;
      ohCRDLST.InpBon:=0;
      ohCRDLST.OutBon:=0;
      ohCRDLST.ActBon:=0;
    end else begin
      ohCRDLST.BonVal:=mBonVal;
      ohCRDLST.NouVal:=ohCRDLST.BegVal+ohCRDLST.DocVal-ohCRDLST.BonVal;
      ohCRDLST.NebVal:=mNebVal;
      ohCRDLST.BegBon:=mBegBon;
      ohCRDLST.InpBon:=mInpBon;
      ohCRDLST.OutBon:=mOutBon;
      ohCRDLST.ActBon:=mBegBon+mInpBon-mOutBon;
      If IsNul(ohCRDLST.BonTrn) then ohCRDLST.BonTrn:=gKey.CrdTrnBon;
    end;
    ohCRDLST.LasItm:=mLasItm;
    ohCRDLST.ItmQnt:=mItmQnt;
    ohCRDLST.Post;
  end;
end;

procedure TCrd.MovLst(pCrdNum:Str20);
begin
  otCRDMOV.Open;
  If ohCRDMOV.LocateCrdNum(pCrdNum) then begin
    Repeat
      otCRDMOV.Insert;
      BTR_To_PX(ohCRDMOV.BtrTable,otCRDMOV.TmpTable);
      otCRDMOV.BonVal:=ohCRDMOV.BonVal;
      otCRDMOV.NouVal:=ohCRDMOV.NouVal;
      otCRDMOV.NebVal:=ohCRDMOV.NebVal;
      otCRDMOV.Post;
      ohCRDMOV.Next;
    until ohCRDMOV.Eof or (ohCRDMOV.CrdNum<>pCrdNum);
  end;
end;

procedure TCrd.AddDoc(pCrdNum:Str20;pDocNum:Str12;pDocDat,pDocTim:TDateTime;pDocVal:double);
var mItmNum:longint;  mBegVal:double;
begin
  If ohCRDLST.LocateCrdNum(pCrdNum) then begin
    If not ohCRDMOV.LocateDocNum(pDocNum) then begin
      If ohCRDMOV.LocateCnIn(pCrdNum,ohCRDLST.LasItm) then begin
        mItmNum:=ohCRDLST.LasItm+1;
        mBegVal:=ohCRDMOV.NouVal;
      end else begin
        If ohCRDMOV.LocateCrdNum(pCrdNum) then begin
          mItmNum:=0;
          Repeat
            If ohCRDMOV.ItmNum>mItmNum then begin
              mItmNum:=ohCRDMOV.ItmNum;
              mBegVal:=ohCRDMOV.NouVal;
            end;
            ohCRDMOV.Next;
          until ohCRDMOV.Eof or (ohCRDMOV.CrdNum<>pCrdNum);
        end else begin
          mItmNum:=1;
          mBegVal:=0;
        end;
      end;
      ohCRDMOV.Insert;
      ohCRDMOV.CrdNum:=pCrdNum;
      ohCRDMOV.ItmNum:=mItmNum;
      ohCRDMOV.DocNum:=pDocNum;
      ohCRDMOV.DocDat:=pDocDat;
      ohCRDMOV.DocTim:=pDocTim;
      ohCRDMOV.BegVal:=mBegVal;
      ohCRDMOV.DocVal:=pDocVal;
      ohCRDMOV.BonTrn:=ohCRDLST.BonTrn;
      If IsNotNul(ohCRDMOV.BonTrn) then ohCRDMOV.BonQnt:=Trunc((ohCRDMOV.BegVal+ohCRDMOV.DocVal)/ohCRDMOV.BonTrn);
      ohCRDMOV.DocTyp:='I';
      ohCRDMOV.Post;
    end else ;
  end else ;
  ClcCrd(pCrdNum);
end;

procedure TCrd.AddOut(pCrdNum:Str20;pDocNum:Str12;pDocDat:TDateTime;pOutQnt:integer);
var mItmNum:longint;  mBegVal:double;
begin
  If ohCRDLST.LocateCrdNum(pCrdNum) then begin
    If not ohCRDMOV.LocateDocNum(pDocNum) then begin
      If ohCRDMOV.LocateCnIn(pCrdNum,ohCRDLST.LasItm) then begin
        mItmNum:=ohCRDLST.LasItm+1;
        mBegVal:=ohCRDMOV.NouVal;
      end else begin
        If ohCRDMOV.LocateCrdNum(pCrdNum) then begin
          mItmNum:=0;
          Repeat
            If ohCRDMOV.ItmNum>mItmNum then begin
              mItmNum:=ohCRDMOV.ItmNum;
              mBegVal:=ohCRDMOV.NouVal;
            end;
            ohCRDMOV.Next;
          until ohCRDMOV.Eof or (ohCRDMOV.CrdNum<>pCrdNum);
        end else begin
          mItmNum:=1;
          mBegVal:=0;
        end;
      end;
      If pDocNum='' then begin
        pDocNum:='VB'+SysYearL+StrIntZero(gKey.CrdOutNum+1,6);
        oDocNum:=pDocNum;
        gKey.CrdOutNum:=gKey.CrdOutNum+1;
      end;
      ohCRDMOV.Insert;
      ohCRDMOV.CrdNum:=pCrdNum;
      ohCRDMOV.ItmNum:=mItmNum;
      ohCRDMOV.DocNum:=pDocNum;
      ohCRDMOV.DocDat:=pDocDat;
      ohCRDMOV.BegVal:=mBegVal;
      ohCRDMOV.BonTrn:=ohCRDLST.BonTrn;
      ohCRDMOV.BonQnt:=pOutQnt*(-1);
      ohCRDMOV.DocTyp:='O';
      ohCRDMOV.Post;
    end else ;
  end else ;
  ClcCrd(pCrdNum);
end;

procedure TCrd.PrnOut(pDocNum:Str12);
var  mRep:TF_RepHand; mhPAB:TPabHnd;  mtDHEAD:TDheadTmp;
     mhCRDLST:TCrdlstHnd;  mhCRDMOV:TCrdmovHnd;  // mtCRDBON:TCrdbonTmp;
begin
  mhCRDMOV:=TCrdmovHnd.Create;  mhCRDMOV.Open;
  If mhCRDMOV.LocateDocNum(pDocNum) then begin
    mhCRDLST:=TCrdlstHnd.Create;  mhCRDLST.Open;
    If mhCRDLST.LocateCrdNum(mhCRDMOV.CrdNum) then begin
      mhPAB:=TPabHnd.Create;  mhPAB.Open(0);
      mtDHEAD:=TDheadTmp.Create;  mtDHEAD.Open;
      mtDHEAD.Insert;
      mtDHEAD.IdCode:=mhCRDLST.CrdNum;
      mtDHEAD.RegName:=mhCRDLST.CrdName;
      mtDHEAD.DocNum:=mhCRDMOV.DocNum;
      mtDHEAD.Date1:=mhCRDMOV.DocDat;
      mtDHEAD.TxtVal:=StrInt(mhCRDMOV.BonQnt*(-1),0);
      If mhPAB.LocatePaCode(mhCRDLST.PaCode) then begin
        mtDHEAD.RegName:=mhPAB.RegName;
        mtDHEAD.RegIno:=mhPAB.RegIno;
        mtDHEAD.RegAddr:=mhPAB.RegAddr;
        mtDHEAD.RegCtn:=mhPAB.RegCtn;
        mtDHEAD.RegZip:=mhPAB.RegZip;
      end;
      // Udaje dodavatela
      mtDHEAD.OwnIno:=dmSYS.btSYSTEM.FieldByName ('MyPaIno').AsString;
      mtDHEAD.OwnTin:=dmSYS.btSYSTEM.FieldByName ('MyPaTin').AsString;
      mtDHEAD.OwnVin:=dmSYS.btSYSTEM.FieldByName ('MyPaVin').AsString;
      mtDHEAD.OwnName:=dmSYS.btSYSTEM.FieldByName ('MyPaName').AsString;
      mtDHEAD.OwnAddr:=dmSYS.btSYSTEM.FieldByName ('MyPaAddr').AsString;
      mtDHEAD.OwnZip:=dmSYS.btSYSTEM.FieldByName ('MyZipCode').AsString;
      mtDHEAD.OwnCtn:=dmSYS.btSYSTEM.FieldByName ('MyCtyName').AsString;
      mtDHEAD.OwnStn:=dmSYS.btSYSTEM.FieldByName ('MyStaName').AsString;
      mtDHEAD.OwnWeb:=dmSYS.btSYSTEM.FieldByName ('MyWebSite').AsString;
      mtDHEAD.OwnTel:=dmSYS.btSYSTEM.FieldByName ('MyTelNum').AsString;
      mtDHEAD.OwnFax:=dmSYS.btSYSTEM.FieldByName ('MyFaxNum').AsString;
      mtDHEAD.OwnEml:=dmSYS.btSYSTEM.FieldByName ('MyEmail').AsString;
      mtDHEAD.OwnReg:=dmSYS.btSYSTEM.FieldByName ('Register').AsString;
      mtDHEAD.Post;
      FreeAndNil(mhPAB);   
(*
      mtCRDBON := TCrdbonTmp.Create; mtCRDBON.Open;
      mtCRDBON.Insert;
      BTR_To_PX (mhCRDBON.BtrTable,mtCRDBON.TmpTable);
      mtCRDBON.Post;
*)
      // Tlac dokladu
      mRep:=TF_RepHand.Create(Self);
      mRep.Main:=mhCRDLST.BtrTable;
      mRep.Spec:=mtDHEAD.TmpTable;
//      mRep.Item := mtCRDBON.TmpTable;
      mRep.Execute (gPath.RepPath+'CRDOUT');
      FreeAndNil(mRep);
//      FreeAndNil (mtCRDBON);
    end;
    FreeAndNil(mtDHEAD);
    FreeAndNil(mhCRDLST);
  end;
  FreeAndNil(mhCRDMOV);
end;

end.
