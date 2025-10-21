unit Ipd;
{$F+}

// *****************************************************************************
//                           DOKUMENTY DOSLEJ POSTY
// *****************************************************************************

interface

uses
  IcVariab, IcTypes, IcConst, IcConv, IcTools, NexGlob, NexPath, NexIni, NexMsg, NexError,
  LinLst, SavClc, TxtDoc, TxtWrap, Bok, Key, Rep, Doc,
  hSYSTEM, hPAB, hIPH, hIPD, hIPT, hIPE, hIPG, hIPN, tIPD, tIPT, tIPE, tIPG,
  SysUtils, Classes, Forms;

type
  PDat=^TDat;
  TDat=record
    rhIPH:TIphHnd;
    rhIPD:TIpdHnd;
    rhIPT:TIptHnd;
    rhIPE:TIpeHnd;
    rhIPN:TIpnHnd;
    rhIPG:TIpgHnd;
  end;

  TIpd = class(TComponent)
    constructor Create(AOwner: TComponent);
    destructor  Destroy; override;
    private
      oBokNum:Str5;
      oLst:TList;
      oDocNum:Str12;
      procedure Activate(pIndex:word); // Aktivuje databazu, ktora je otvorena pod poradovym cislom pIndex
      function GetOpenCount:word;
    public
      ohPAB:TPabHnd;
      ohIPH:TIphHnd;
      ohIPD:TIpdHnd;
      ohIPT:TIptHnd;
      ohIPE:TIpeHnd;
      ohIPG:TIpgHnd;
      ohIPN:TIpnHnd;
      otIPD:TIpdTmp;
      otIPT:TIptTmp;
      otIPE:TIpeTmp;
      otIPG:TIpgTmp;
      procedure Open(pBokNum:Str5); overload; // Otvori vsetky databazove subory
      procedure Open(pBokNum:Str5;pIPH,pIPD,pIPT,pIPE,pIPG,pIPN:boolean); overload;// Otvori zadane databazove subory
      procedure OpenLst(pBokLst:ShortString); // Otvori vsetky knihy ktore su zadane v retazci

      procedure PrnDoc; overload; // Vytlaèí aktualnu fakturu
      procedure PrnDoc(pDocNum:Str12); overload; // Vytlaèí zadanu fakturu
      procedure SlcItm(pDocNum:Str12); // Nacita polozky zadaneho dokladu do PX
      procedure AddItm(pDocNum:Str12;pGsCode:longint;pGsQnt,pDscPrc,pFgBPrice:double;pGsName:Str30;pErCode:longint); // Prida novu polozku na zadanu fakturu
      procedure AddNot(pDocNum:Str12;pLinNum:word;pNotType:Str1;pNotice:Str250); // Prida poznamku k dokladu

      procedure ColIpd(pDocNum:Str12);
      procedure ColIpt(pDocNum:Str12);
      procedure ColIpe(pDocNum:Str12);
      procedure ColIpg(pDocNum:Str12);

      function DelDoc:boolean; overload; // Vymaze aktualnu doklad
      function DelDoc(pDocNum:Str12):boolean; overload; // Vymaze zadany doklad
    published
      property BokNum:Str5 read oBokNum;
      property DocNum:Str12 read oDocNum;
  end;

implementation

constructor TIpd.Create(AOwner: TComponent);
begin
  oLst := TList.Create;  oLst.Clear;
  otIPD := TIpdTmp.Create;
  otIPT := TIptTmp.Create;
  otIPE := TIpeTmp.Create;
  otIPG := TIpgTmp.Create;
  ohPAB := TPabHnd.Create;
end;

destructor TIpd.Destroy;
var I:word;
begin
  If oLst.Count>0 then begin
    For I:=1 to oLst.Count do begin
      Activate (I);
      FreeAndNil (ohIPN);
      FreeAndNil (ohIPE);
      FreeAndNil (ohIPG);
      FreeAndNil (ohIPT);
      FreeAndNil (ohIPD);
      FreeAndNil (ohIPH);
    end;
  end;
  FreeAndNil (oLst);
  FreeAndNil (ohPAB);
  FreeAndNil (otIPE);
  FreeAndNil (otIPG);
  FreeAndNil (otIPT);
  FreeAndNil (otIPD);
end;

// ********************************* PRIVATE ***********************************

function TIpd.GetOpenCount:word;
begin
  Result := oLst.Count;
end;

procedure TIpd.Activate(pIndex:word); // Aktivuje databazu, ktora je otvorena pod poradovym cislom pIndex
var mDat:PDat;
begin
  mDat := oLst.Items[pIndex-1];
  ohIPH := mDat.rhIPH;
  ohIPD := mDat.rhIPD;
  ohIPT := mDat.rhIPT;
  ohIPE := mDat.rhIPE;
  ohIPG := mDat.rhIPG;
  ohIPN := mDat.rhIPN;
end;

// ********************************** PUBLIC ***********************************

procedure TIpd.Open(pBokNum:Str5); // Otvori vsetky databazove subory
begin
  Open (pBokNum,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE);
end;

procedure TIpd.Open(pBokNum:Str5;pIPH,pIPD,pIPT,pIPE,pIPG,pIPN:boolean); // Otvori zadane databazove subory
var mFind:boolean;  mCnt:word;  mDat:PDat;
begin
  oBokNum := pBokNum;
  mFind := FALSE;
  If oLst.Count>0 then begin
    mCnt := 0;
    Repeat
      Inc (mCnt);
      Activate(mCnt);
      mFind := ohIPH.BtrTable.BookNum=pBokNum;
    until mFind or (mCnt=oLst.Count);
  end;
  If not mFind then begin // Ak dana kniha este nie je otvorena potomotvorime
    // Vytvorime objekty
    ohIPH := TIphHnd.Create;
    ohIPD := TIpdHnd.Create;
    ohIPT := TIptHnd.Create;
    ohIPE := TIpeHnd.Create;
    ohIPG := TIpgHnd.Create;
    ohIPN := TIpnHnd.Create;
    // Otvorime databazove subory
    If pIPH then ohIPH.Open(pBokNum);
    If pIPD then ohIPD.Open(pBokNum);
    If pIPT then ohIPT.Open(pBokNum);
    If pIPE then ohIPE.Open(pBokNum);
    If pIPG then ohIPG.Open(pBokNum);
    If pIPN then ohIPN.Open(pBokNum);
    // Ulozime objekty do zoznamu
    GetMem (mDat,SizeOf(TDat));
    mDat^.rhIPH := ohIPH;
    mDat^.rhIPD := ohIPD;
    mDat^.rhIPT := ohIPT;
    mDat^.rhIPE := ohIPE;
    mDat^.rhIPG := ohIPG;
    mDat^.rhIPN := ohIPN;
    oLst.Add(mDat);
  end;
end;

procedure TIpd.OpenLst(pBokLst:ShortString); // Otvori vsetky knihy ktore su zadane v retazci
var mLinLst:TLinLst;
begin
  mLinLst := TLinLst.Create;
  mLinLst.AddLst(pBokLst);
  If mLinLst.Count>0 then begin
    mLinLst.First;
    Repeat
      If gBok.BokExist('IPB',mLinLst.Itm,TRUE) then begin
        Open (mLinLst.Itm);
      end;
      Application.ProcessMessages;
      mLinLst.Next;
    until mLinLst.Eof;
  end
  else begin  // Otvorime vsetky knihy
    gBok.LoadBokLst('IPB','');
    If gBok.BokLst.Count>0 then begin
      gBok.BokLst.First;
      Repeat
        Open (gBok.BokLst.Itm);
        Application.ProcessMessages;
        gBok.BokLst.Next;
      until gBok.BokLst.Eof;
    end;
  end;
  FreeAndNil (mLinLst);
end;

(*
procedure TIpd.NewDoc(pPaCode:longint); // Vygeneruje novu hlavicku dokladu
begin
  If oSerNum=0 then oSerNum := ohIPH.NextSerNum; // Ak nie je zadane poradove cislo OD vygenerujeme nasledujuce
  If oDocDate=0 then oDocDate := Date; // Ak nie je zadany datum nastavime aktualny den
  oDocNum := ohIPH.GenDocNum(oSerNum);
  If not ohIPH.LocateDocNum(oDocNum) then begin // Ak neexistuje vyvorime hlacicku dokladu OD
    ohIPH.Insert;
    ohIPH.DocNum := oDocNum;
    ohIPH.SerNum := oSerNum;
    ohIPH.WriNum := oWriNum;

    ohICH.ExtNum := GenExtNum('',gKey.IcbExnFrm[BokNum],oSerNum,BokNum,ohICH.StkNum);
    ohICH.DocDate := oDocDate;
    ohICH.CrtName := gvSys.UserName;
    If ohPAB.LocatePaCode(pPaCode) then begin
      BTR_To_BTR (ohPAB.BtrTable,ohICH.BtrTable);
    end;
    ohICH.Post;
  end;
end;
*)

procedure TIpd.PrnDoc; // Vytlaèí aktualnu fakturu
begin
  PrnDoc(ohIPH.DocNum);
end;

procedure TIpd.PrnDoc(pDocNum:Str12); // Vytlaèí zadanu fakturu
//var mRep:TRep;  mtICH:TIchTmp;  mhSYSTEM:TSystemHnd;  mBokNum:Str5;  mInfVal:double;
begin
(*
  mBokNum := CuttDocNum(pDocNum);
  Open (mBokNum);
  If ohICH.LocateDocNum(pDocNum) then begin
    mhSYSTEM := TSystemHnd.Create;  mhSYSTEM.Open;
    mtIPH := TIphTmp.Create;   mtICH.Open;
    mtICH.Insert;
    BTR_To_PX (ohICH.BtrTable,mtICH.TmpTable);
    mtICH.Post;
    SlcItm(pDocNum);
    // --------------------------
    mRep := TRep.Create(Self);
    mRep.SysBtr := mhSYSTEM.BtrTable;
    mRep.HedTmp := mtICH.TmpTable;
    mRep.SpcTmp := otIPN.TmpTable;
    mRep.ItmTmp := otIPI.TmpTable;
    mRep.Execute('IPD',ohIPH.DocNum);
    FreeAndNil (mRep);
    // --------------------------
    FreeAndNil (mJrn);
    FreeAndNil (mtIPH);
  end;
*)
end;

procedure TIpd.SlcItm(pDocNum:Str12); // nacita polozky zadaneho dokladu do PX
begin
  If otIPD.Active then otIPD.Close;
  otIPD.Open;
  If ohIPD.LocateDocNum(pDocNum) then begin
    Repeat
      otIPD.Insert;
      BTR_To_PX (ohIPD.BtrTable,otIPD.TmpTable);
      otIPD.Post;
      Application.ProcessMessages;
      ohIPD.Next;
    until ohIPD.Eof or (ohIPD.DocNum<>pDocNum);
  end;
end;

procedure TIpd.AddItm(pDocNum:Str12;pGsCode:longint;pGsQnt,pDscPrc,pFgBPrice:double;pGsName:Str30;pErCode:longint); // Prida novu polozku na zadanu fakturu
var mItmNum:word;
begin
(*
  If ohICH.LocateDocNum(pDocNum) then begin
    If not ohGSCAT.Active then ohGSCAT.Open;
    If ohGSCAT.LocateGsCode(pGsCode) then begin
      mItmNum := ohICI.NextItmNum(pDocNum);
      ohICI.Insert;
      ohICI.DocNum := pDocNum;
      ohICI.ItmNum := mItmNum;

      ohICI.PaCode := ohICH.PaCode;
      ohICI.DocDate := ohICH.DocDate;
      ohICI.Post;
    end
    else ShowMsg(pErCode,StrInt(pGsCode,0));
  end
  else ShowMsg(eCom.DocIsNoExist,pDocNum);
*)
end;

procedure TIpd.AddNot(pDocNum:Str12;pLinNum:word;pNotType:Str1;pNotice:Str250); // Prida poznamku k dokladu
begin
end;

procedure TIpd.ColIpd(pDocNum:Str12);
begin
  otIPD.Close;  otIPD.Open;
  If ohIPD.LocateDocNum(pDocNum) then begin
    Repeat
      otIPD.Insert;
      BTR_To_PX(ohIPD.BtrTable,otIPD.TmpTable);
      otIPD.Post;
      Application.ProcessMessages;
      ohIPD.Next;
    until ohIPD.Eof or (ohIPD.DocNum<>pDocNum);
  end;
end;

procedure TIpd.ColIpt(pDocNum:Str12);
begin
  otIPT.Close;  otIPT.Open;
  If ohIPT.LocateDocNum(pDocNum) then begin
    Repeat
      otIPT.Insert;
      BTR_To_PX(ohIPT.BtrTable,otIPT.TmpTable);
      otIPT.Post;
      Application.ProcessMessages;
      ohIPT.Next;
    until ohIPT.Eof or (ohIPT.DocNum<>pDocNum);
  end;
end;

procedure TIpd.ColIpe(pDocNum:Str12);
begin
  otIPE.Close;  otIPE.Open;
  If ohIPE.LocateDocNum(pDocNum) then begin
    Repeat
      otIPE.Insert;
      BTR_To_PX(ohIPE.BtrTable,otIPE.TmpTable);
      otIPE.Post;
      Application.ProcessMessages;
      ohIPE.Next;
    until ohIPE.Eof or (ohIPE.DocNum<>pDocNum);
  end;
end;

procedure TIpd.ColIpg(pDocNum:Str12);
begin
  otIPG.Close;  otIPG.Open;
  If ohIPG.LocateDocNum(pDocNum) then begin
    Repeat
      otIPG.Insert;
      BTR_To_PX(ohIPG.BtrTable,otIPG.TmpTable);
      otIPG.Post;
      Application.ProcessMessages;
      ohIPG.Next;
    until ohIPG.Eof or (ohIPG.DocNum<>pDocNum);
  end;
end;

function TIpd.DelDoc:boolean;
begin
  DelDoc(ohIPH.DocNum);
end;

function TIpd.DelDoc(pDocNum:Str12):boolean;
begin
  Result := TRUE;
  Open(CuttBokNum(pDocNum));
  If ohIPH.LocateDocNum(pDocNum) then begin
    If not ohIPT.LocateDocNum(pDocNum) then begin
      ohIPD.Del(pDocNum);
      ohIPE.Del(pDocNum);
      ohIPG.Del(pDocNum);
      ohIPN.Del(pDocNum);
      ohIPH.Delete;
    end
    else ShowMsg(eIpb.DocNoHaveIptItm,'');
  end;
end;

end.
