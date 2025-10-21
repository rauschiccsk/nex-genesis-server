unit Mcd;

{$F+}

// *****************************************************************************
//                               OBJEKT NA PRACU S MCD
// *****************************************************************************


interface

uses // hOCI, 
  IcTypes, IcConst, IcConv, IcTools, IcVariab,
  NexBtrTable, NexPxTable, NexGlob, NexPath, NexIni, NexMsg, NexError,
  StkGlob, DocHand, LinLst,  SavClc, TxtDoc, TxtWrap,
  Rep, Bok, Key, Icd,
  hPAB, hPLS, hMCH, hMCI, hMCN, hMCO, hGsCat, hGSCIMG, hMGLST, hSYSTEM,
  tMCI, tMCN, tMCH, tMCO, tNOT,
  DB, SysUtils, Classes, Graphics, ExtCtrls, Jpeg, Forms;

type
  PDat=^TDat;
  TDat=record
    rhMCH:TMchHnd;
    rhMCI:TMciHnd;
    rhMCN:TMcnHnd;
    rhMCO:TMcoHnd;
  end;

  TMcd=class(TComponent)
    constructor Create;
    destructor Destroy; override;
    private
      oYear:Str2;
      oBokNum:Str5;
      oSerNum:longint;
      oDocNum:Str12;
      oPlsNum:word;
      oPaCode:longint;
      oSpaCode:longint;
      oWpaCode:word;
      oDocDate:TDateTime;
      oLst:TList;
      ohGSCAT:TGscatHnd;
//      procedure SetBokNum (pBokNum:Str5); function  GetBokNum:Str5;
      function GetOpenCount:word;
      procedure Activate(pIndex:word);
    public
      ohPAB:TPabHnd;
      ohMCH:TMchHnd;
      ohMCI:TMciHnd;
      ohMCN:TMcnHnd;
      ohMCO:TMcoHnd;
      otMCI:TMciTmp;
      otMCN:TMcnTmp;
      otMCO:TMcoTmp;
      procedure Open(pBokNum:Str5); overload; // Otvori vsetky databazove subory
      procedure Open(pBokNum:Str5;pMCH,pMCI,pMCN,pMCO:boolean); overload;// Otvori zadane databazove subory
      procedure OpenLst(pBokLst:ShortString); // Otvori vsetky knihy ktore su zadane v retazci
      procedure NewDoc(pYear:Str2;pDstLck:boolean); // Vygeneruje novu hlavicku dokladu
      procedure SetPac(pPaCode,pWpaCode:longint);
      procedure PrnDoc(pDocNum:Str12;pRepName:Str10); // Vytlaèí aktualny doklad
      procedure ClcDoc; overload; // Prepocita hlavicku aktualneho dokladu podla jeho poloziek
      procedure ClcDoc(pDocNum:Str12); overload;  // Prepocita hlavicku zadaneho dokladu podla jeho poloziek
      procedure DelNtc (pDocNum:Str12);
      procedure DelItm (pDocNum:Str12);
      // generovanie OFA
      procedure IcdGen(pPrnIcd:boolean); overload; // Vygeneruje polozky z aktualnej CP do novej faktury
      procedure IcdGen(pIcdNum:Str12;pPrnIcd:boolean); overload; // Vygeneruje polozky z aktualnej CP do novej faktury
      procedure IcdGen(pMcdNum,pIcdNum:Str12;pPrnIcd:boolean); overload; // Vygeneruje polozky z aktualnej CP do novej faktury
      // generovanie ZK
      procedure OcdGen(pTemp,pPrnOcd:boolean); overload; // Vygeneruje polozky z aktualnej CP do novej ZK
      procedure OcdGen(pOcdNum:Str12;pTemp,pPrnOcd:boolean); overload; // Vygeneruje polozky z aktualnej CP do novej ZK
      procedure OcdGen(pMcdNum,pOcdNum:Str12;pTemp,pPrnOcd:boolean); overload; // Vygeneruje polozky z aktualnej CP do novej ZK

      function LocExtNum(pExtNum:Str12):boolean; // Hlada variabilny symbol vo vsetkych knihach OF

      function GetNot(pDocNum:Str12;pNotType:Str1):AnsiString; // Naèíta poznámky
      procedure SavNot(pDocNum:Str12;pNotType:Str1;pNot:AnsiString); // Ulozi poznámky
      procedure DelNot(pDocNum:Str12;pNotType:Str1); // Vymaze poznámky

      procedure SlcItm(pDocNum:Str12); // nacita polozky zadaneho dokladu do PX
      procedure SlcNtc(pDocNum:Str12); // nacita poznamky zadaneho dokladu do PX
      procedure AddItm(pGsCode:longint;pGsQnt,pDscPrc,pFgBPrice,pFgAPrice:double); overload; // Prida novu polozku na zadany doklad
      procedure AddItm(pGsCode:longint;pGsQnt,pDscPrc,pFgBPrice,pFgAPrice:double;pStkCode:Str15); overload; // Prida novu polozku na zadany doklad
      procedure MCI_To_TMP(phMCI:TMciHnd; ptMCI:TMciTmp); // Ulozi zaznam z btMCI do ptMCI
    published
      property BokNum:Str5 read oBokNum;
      property Year:Str2 read oYear write oYear;
      property SerNum:longint write oSerNum;
      property DocNum:Str12 read oDocNum;
      property PlsNum:word write oPlsNum;
      property PaCode:longint write oPaCode;
      property SpaCode:longint write oSpaCode;
      property WpaCode:word write oWpaCode;
      property DocDate:TDateTime write oDocDate;
  end;

implementation

constructor TMcd.Create;
begin
  oPlsNum:=1;
  oLst:=TList.Create;  oLst.Clear;
  ohGSCAT:=TGscatHnd.Create;  ohGSCAT.Open;
  ohPAB:=TPabHnd.Create;  ohPAB.Open(0);
  otMCI:=TMciTmp.Create;
  otMCN:=TMcnTmp.Create;
  otMCO:=TMcoTmp.Create;
end;

destructor TMcd.Destroy;
var I:word;
begin
  If oLst.Count>0 then begin
    For I:=1 to oLst.Count do begin
      Activate(I);
      FreeAndNil(ohMCO);
      FreeAndNil(ohMCN);
      FreeAndNil(ohMCI);
      FreeAndNil(ohMCH);
    end;
  end;
  FreeAndNil (oLst);
  otMCI.Close;FreeAndNil(otMCI);
  otMCN.Close;FreeAndNil(otMCN);
  otMCO.Close;FreeAndNil(otMCO);
  FreeAndNil(ohPAB);
  FreeAndNil(ohGSCAT);
end;

// ********************************* PRIVATE ***********************************
procedure TMcd.Activate(pIndex:word); // Aktivuje databazu, ktora je otvorena pod poradovym cislom pIndex
var mDat:PDat;
begin
  mDat:=oLst.Items[pIndex-1];
  ohMCH:=mDat.rhMCH;
  ohMCI:=mDat.rhMCI;
  ohMCN:=mDat.rhMCN;
  ohMCO:=mDat.rhMCO;
end;
(*
procedure TMcd.SetBokNum (pBokNum:Str5);
var mFind:boolean;  mCnt:word;
begin
  mFind:=FALSE;
  If oMch.Count>0 then begin
    mCnt:=0;
    Repeat
      Inc (mCnt);
      Activate(mCnt);
      mFind:=ohMCH.BtrTable.BookNum=pBokNum;
    until mFind or (mCnt=oMch.Count);
  end;
  If not mFind then begin // Ak dana kniha este nie je otvorena potomotvorime
    ohMCH:=TMchHnd.Create;  ohMCH.Open(pBokNum);   oMch.Add(ohMCH);
    ohMCI:=TMciHnd.Create;  ohMCI.Open(pBokNum);   oMci.Add(ohMCI);
    ohMCN:=TMcnHnd.Create;  ohMCN.Open(pBokNum);   oMcn.Add(ohMCN);
  end;
end;
*)
function TMcd.GetOpenCount:word;
begin
  Result:=oLst.Count;
end;

(*
function TMcd.GetBokNum:Str5;
begin
  Result:=ohMCH.BtrTable.BookNum;
end;
*)

function TMcd.GetNot(pDocNum:Str12;pNotType:Str1):AnsiString;
var mNotice:TStringList;
begin
  Result:='';
  If ohMCN.LocateDocNum(pDocNum) then begin
    mNotice:=TStringList.Create;
    Repeat
      If ohMCN.NotType=pNotType then mNotice.Add(ohMCN.Notice);
      Application.ProcessMessages;
      ohMCN.Next;
    until ohMCN.Eof or (ohMCN.DocNum<>pDocNum);
    Result:=mNotice.Text;
    FreeAndNil(mNotice);
  end;
end;

procedure TMcd.SavNot(pDocNum:Str12;pNotType:Str1;pNot:AnsiString); // Ulozi poznámky
var I:word; mNotice:TStringList;
begin
  DelNot(pDocNum,pNotType);
  mNotice:=TStringList.Create;
  mNotice.Text:=pNot;
  If mNotice.Count>0 then begin
    For I:=0 to mNotice.Count-1 do begin
      ohMCN.Insert;
      ohMCN.DocNum:=pDocNum;
      ohMCN.NotType:=pNotType;
      ohMCN.LinNum:=I;
      ohMCN.Notice:=mNotice.Strings[I];
      ohMCN.Post;
    end;
  end;
  FreeAndNil(mNotice);
end;

procedure TMcd.DelNot(pDocNum:Str12;pNotType:Str1); // Vymaze poznámky
begin
  If ohMCN.LocateDocNum(pDocNum) then begin
    Repeat
      Application.ProcessMessages;
      If ohMCN.NotType=pNotType
        then ohMCN.Delete
        else ohMCN.Next;
    until ohMCN.Eof or (ohMCN.DocNum<>pDocNum);
  end;
end;

// ********************************** PUBLIC ***********************************

procedure TMcd.Open(pBokNum:Str5); // Otvori vsetky databazove subory
begin
  Open(pBokNum,TRUE,TRUE,TRUE,TRUE);
end;

procedure TMcd.Open(pBokNum:Str5;pMCH,pMCI,pMCN,pMCO:boolean); // Otvori zadane databazove subory
var mFind:boolean;  mCnt:word;  mDat:PDat;
begin
  oBokNum:=pBokNum;
  mFind:=FALSE;
  If oLst.Count>0 then begin
    mCnt:=0;
    Repeat
      Inc (mCnt);
      Activate(mCnt);
      mFind:=ohMCH.BtrTable.BookNum=pBokNum;
    until mFind or (mCnt=oLst.Count);
  end;
  If not mFind then begin // Ak dana kniha este nie je otvorena potomotvorime
    // Vytvorime objekty
    ohMCH:=TMchHnd.Create;
    ohMCI:=TMciHnd.Create;
    ohMCN:=TMcnHnd.Create;
    ohMCO:=TMcoHnd.Create;
    // Otvorime databazove subory
    If pMCH then ohMCH.Open(pBokNum);
    If pMCI then ohMCI.Open(pBokNum);
    If pMCN then ohMCN.Open(pBokNum);
    If pMCO then ohMCO.Open(pBokNum);
    // Ulozime objekty do zoznamu
    GetMem (mDat,SizeOf(TDat));
    mDat^.rhMCH:=ohMCH;
    mDat^.rhMCI:=ohMCI;
    mDat^.rhMCN:=ohMCN;
    mDat^.rhMCO:=ohMCO;
    oLst.Add(mDat);
  end;
end;

procedure TMcd.OpenLst(pBokLst:ShortString); // Otvori vsetky knihy ktore su zadane v retazci
var mLinLst:TLinLst;
begin
  mLinLst:=TLinLst.Create;
  mLinLst.AddLst(pBokLst);
  If mLinLst.Count>0 then begin
    mLinLst.First;
    Repeat
      If gBok.BokExist('MCB',mLinLst.Itm,TRUE) then Open(mLinLst.Itm);
//      BokNum:=mLinLst.Itm;
      Application.ProcessMessages;
      mLinLst.Next;
    until mLinLst.Eof;
  end
  else begin  // Otvorime vsetky knihy
    gBok.LoadBokLst('MCB','');
    If gBok.BokLst.Count>0 then begin
      gBok.BokLst.First;
      Repeat
        Open(mLinLst.Itm);
//        BokNum:=gBok.BokLst.Itm;
        Application.ProcessMessages;
        gBok.BokLst.Next;
      until gBok.BokLst.Eof;
    end;
  end;
  FreeAndNil (mLinLst);
end;

procedure TMcd.NewDoc(pYear:Str2;pDstLck:boolean); // Vygeneruje novu hlavicku dokladu
begin
  oYear:=pYear;If oYear='' then oYear:=gvsys.ActYear2;
  If oSerNum=0 then oSerNum:=ohMCH.NextSerNum(oYear); // Ak nie je zadane poradove cislo OD vygenerujeme nasledujuce
  If oDocDate=0 then oDocDate:=Date; // Ak nie je zadany datum nastavime aktualny den
  oDocNum:=ohMCH.GenDocNum(oYear,oSerNum);
  If not ohMCH.LocateDocNum(oDocNum) then begin // Ak neexistuje vyvorime hlacicku dokladu OD
    ohMCH.Insert;
    If pDstLck then ohMCH.DstLck:=9;
    ohMCH.DocNum:=oDocNum;
    ohMCH.SerNum:=oSerNum;
    ohMCH.StkNum:=gKey.McbStkNum[ohMCH.BtrTable.BookNum];
    ohMCH.ExtNum:=GenExtNum(oDocDate,'',gKey.McbExnFmt[ohMCH.BtrTable.BookNum],ohMCH.SerNum,ohMCH.BtrTable.BookNum,ohMCH.StkNum);
    ohMCH.PlsNum:=oPlsNum;
    ohMCH.DocDate:=oDocDate;
    ohMCH.ExpDate:=oDocDate;
    ohMCH.DlvDate:=oDocDate;
    ohMCH.AcDvzName:=gIni.SelfDvzName;
    ohMCH.RspName:=gvSys.UserName;
    ohMCH.PrfPrc:=gKey.McbPrfPrc[ohMCH.BtrTable.BookNum];
    ohMCH.FgDvzName:=gKey.McbFgvDvz[ohMCH.BtrTable.BookNum];
    ohMCH.FgCourse:=GetFgCourse(ohMCH.FgDvzName,Date,1);
    If ohPAB.LocatePaCode(oPaCode) then begin
      BTR_To_BTR (ohPAB.BtrTable,ohMCH.BtrTable);
      // Zadat aj miesto dodania
    end;
    ohMCH.Post;
  end;
end;

procedure TMcd.PrnDoc(pDocNum:Str12;pRepName:Str10); // Vytlaèí aktualny doklad
var mLogo: TImage;   mLinNum:byte;   mInfVal:double; mRep:TRep;
  mhGSCIMG:TGscimgHnd; mhGSCAT:TGscatHnd; mhMGLST:TMglstHnd;
  mtMCH: TMchTmp; mtNOT: TNotTmp; mhSYSTEM:TSystemHnd;
  FileStream: TFileStream; BlobStream: TStream; Bmp: TBitmap; Jpg: TJPEGImage;
begin
  mhGSCAT :=TGscatHnd.Create;  mhGSCAT.Open;
  mhGscImg:=TGscImgHnd.Create; mhGSCIMG.Open;
  mhMGLST :=TMglstHnd.Create; mhMGLST.Open;
  mtNOT  :=TNotTmp.Create; mtNOT.Open;
  mtMCH  :=TMchTmp.Create; mtMCH.Open;
  mhSYSTEM:=TSystemHnd.Create;  mhSYSTEM.Open;
  mtMCH.Insert;
  BTR_To_PX (ohMCH.BtrTable,mtMCH.TmpTable);
  mtMCH.FgVatVal1:=ohMCH.FgBValue1-ohMCH.FgAValue1;
  mtMCH.FgVatVal2:=ohMCH.FgBValue2-ohMCH.FgAValue2;
  mtMCH.FgVatVal3:=ohMCH.FgBValue3-ohMCH.FgAValue3;
  mtMCH.RegStn   :=GetStaName (ohMCH.RegSta);
  mtMCH.WpaStn   :=GetStaName (ohMCH.WpaSta);
  mtMCH.DlrName  :=GetDlrName (ohMCH.DlrCode);
  If gKey.SysFixCrs>0 then begin
    If gKey.SysInfDvz='EUR'
      then mInfVal:=ohMCH.FgBValue/gKey.SysFixCrs
      else mInfVal:=ohMCH.FgBValue*gKey.SysFixCrs;
    mtMCH.Info:='Konverzný kurz: '+StrDoub(gKey.SysFixCrs,2,4)+'    Hodnota dokladu: '+StrDoub(mInfVal,0,2)+' '+gKey.SysInfDvz;
  end;
  mtMCH.Post;
  // Pozbierame poznamky k dokladu
  ohMCN.NearestDoNtLn (ohMCH.DocNum,'',0);
  If ohMCN.DocNum=ohMCH.DocNum then begin
    mtNOT.Insert;
    mLinNum:=0;
    Repeat
      Inc (mLinNum);
      If ohMCN.NotType='' then ohMCN.NotType:='N';
      If mtNOT.TmpTable.FindField ('Notice'+ohMCN.NotType+StrInt(mLinNum,0))<>nil
        then mtNOT.TmpTable.FieldByName ('Notice'+ohMCN.NotType+StrInt(mLinNum,0)).AsString:=ohMCN.Notice;
      ohMCN.Next;
    until (ohMCN.Eof) or (mLinNum>=5) or (ohMCN.DocNum<>ohMCH.DocNum);
    mtNOT.Post;
  end;
  // Polozky vybraneho dokladu
  otMCI.Open;otMCI.TmpTable.DelRecs;
  otMCI.TmpTable.IndexName:=gIni.MciPrnIndex;
  If ohMCI.LocateDocNum (ohMCH.DocNum) then begin
    Repeat
      otMCI.Insert;
      MCI_To_TMP(ohMCI,otMCI);
      otMCI.MgName:=GetNameByCode(mhMGLST.BtrTable,otMCI.MgCode,'MgCode','MgName');
      If mhGSCAT.LocateGsCode(otMCI.GsCode) then begin
        otMCI.SpcCode:=mhGSCAT.SpcCode;
        otMCI.FgCode :=mhGSCAT.FgCode;
        If (otMCI.TmpTable.FindField('Image')<>NIL) then begin
          If mhGSCIMG.LocateGsCode(otMCI.GsCode)
          and FileExists(gPath.ImgPath+mhGSCIMG.ImgName) then begin
            BlobStream:=otMCI.TmpTable.CreateBlobStream(otMCI.TmpTable.FieldByName('IMAGE'),bmWrite);
            FileStream:=TFileStream.Create(gPath.ImgPath+mhGSCIMG.ImgName,fmOpenRead or fmShareDenyNone);
            BlobStream.CopyFrom(FileStream,FileStream.Size);
            FileStream.Free;
            BlobStream.Free;
          end else begin
            If FileExists (gPath.ImgPath+StrInt(otMCI.GsCode,0)+'.jpg') then begin
              Bmp:=TBitmap.Create;Jpg:=TJPEGImage.Create;
              try
                Jpg.LoadFromFile(gPath.ImgPath+StrInt(otMCI.GsCode,0)+'.jpg');
                Bmp.Assign(Jpg);
                Bmp.SaveToFile(gPath.ImgPath+'TEMP.BMP');
              finally
                Jpg.Free;Bmp.Free;
              end;
              BlobStream:=otMCI.TmpTable.CreateBlobStream(otMCI.TmpTable.FieldByName('IMAGE'),bmWrite);
              FileStream:=TFileStream.Create(gPath.ImgPath+'TEMP.BMP',fmOpenRead or fmShareDenyNone);
              BlobStream.CopyFrom(FileStream,FileStream.Size);
              FileStream.Free;
              BlobStream.Free;
            end;
          end;
        end;
      end;
      otMCI.Post;
      ohMCI.Next;
    until (ohMCI.Eof) or (ohMCI.DocNum<>ohMCH.DocNum);
  end;

  mRep:=TRep.Create(Self);
  mRep.SysBtr:=mhSYSTEM.BtrTable;
  mRep.HedTmp:=mtMCH.TmpTable;
  mRep.ItmTmp:=otMCI.TmpTable;
  mRep.SpcTmp:=mtNOT.TmpTable;
  mRep.Execute(pRepName);
  FreeAndNil (mRep);

  otMCI.Close;
  mhMGLST.Close;
  mhGSCIMG.Close;
  mhGSCAT.Close;
  mtMCH.Close;
  mtNOT.Close;
  FreeAndNil(mhGSCAT);
  FreeAndNil(mhGscImg);
  FreeAndNil(mhMGLST);
  FreeAndNil(mtNot);
  FreeAndNil(mtMCH);
end;

procedure TMcd.ClcDoc; // Prepocita hlavicku zadaneho dokladu podla jeho poloziek
begin
  ohMCH.Clc(ohMCI);
end;

procedure TMcd.ClcDoc(pDocNum:Str12); // Prepocita hlavicku zadaneho dokladu podla jeho poloziek
begin
  If ohMCH.LocateDocNum(pDocNum) then ohMCH.Clc(ohMCI);
end;

function TMcd.LocExtNum(pExtNum:Str12):boolean; // Hlada variabilny symbol vo vsetkych knihach OF
var mCnt:word;
begin
  mCnt:=0;
  Result:=FALSE;
  Repeat
    Inc (mCnt);
    Activate(mCnt);
    Result:=ohMCH.LocateExtNum(pExtNum);
    Application.ProcessMessages;
  until (mCnt=oLst.Count) or Result;
end;

procedure TMcd.SlcItm(pDocNum: Str12);
begin
  If otMCI.Active then otMCI.Close;
  otMCI.Open;
  If ohMCH.LocateDocNum(pDocNum) then begin
    If ohMCI.LocateDocNum(pDocNum) then begin
      Repeat
        otMCI.Insert;
        MCI_To_TMP(ohMCI,otMCI);
        otMCI.Post;
        Application.ProcessMessages;
        ohMCI.Next;
      until ohMCI.Eof or (ohMCI.DocNum<>pDocNum);
    end;
  end;
end;

procedure TMcd.SlcNtc(pDocNum: Str12);
begin
  If otMCN.Active then otMCN.Close;
  otMCN.Open;
  If ohMCH.LocateDocNum(pDocNum) then begin
    If ohMCN.LocateDocNum(pDocNum) then begin
      Repeat
        otMCN.Insert;
        BTR_To_PX (ohMCN.BtrTable,otMCN.TmpTable);
        otMCN.Post;
        Application.ProcessMessages;
        ohMCN.Next;
      until ohMCN.Eof or (ohMCN.DocNum<>pDocNum);
    end;
  end;
end;

procedure TMcd.DelNtc(pDocNum: Str12);
begin
  ohMCN.NearestDoNtLn (pDocNum,'',0);
  If ohMCN.DocNum=pDocNum then begin
    Repeat
      Application.ProcessMessages;
      ohMCN.Delete;
    until (ohMCN.Eof) or (ohMCN.DocNum<>pDocNum);
  end;
end;

procedure TMcd.DelItm(pDocNum: Str12);
begin
  ohMCI.NearestDoIt (pDocNum,0);
  If ohMCI.DocNum=pDocNum then begin
    Repeat
      Application.ProcessMessages;
      ohMCI.Delete;
    until (ohMCI.Eof) or (ohMCI.DocNum<>pDocNum);
  end;
end;

procedure TMcd.IcdGen(pPrnIcd: boolean);
begin
  IcdGen('',pPrnIcd);
end;

procedure TMcd.IcdGen(pMCdNum, pIcdNum: Str12; pPrnIcd: boolean);
begin
  If ohMCH.LocateDocNum(pMCdNum)
    then IcdGen(pIcdNum,pPrnIcd)
    else ShowMsg(eCom.DocIsNoExist,pMCdNum);
end;

procedure TMcd.IcdGen(pIcdNum: Str12; pPrnIcd: boolean);
var mIcd:TIcd;  mBokNum:Str5;  mItmNum:word;  mIcdNum:Str12;
begin
  If ohMCI.LocateDocNum(ohMCH.DocNum) then begin
    mBokNum:=gKey.McbIcbNum[BokNum];
    mIcd:=TIcd.Create(Self);
    mIcd.Open(mBokNum,TRUE,TRUE,FALSE);
    mIcdNum:=pIcdNum;
    If mIcdNum='' then begin
      mIcd.NewDoc('',ohMCH.PaCode,FALSE);
      mIcdNum:=mIcd.DocNum;
    end;
    If mIcd.ohICH.LocateDocNum(mIcdNum) then begin
      Repeat
          mItmNum:=mIcd.ohICI.NextItmNum(mIcdNum);
          mIcd.ohICI.Insert;
          BTR_To_BTR (ohMCI.BtrTable,mIcd.ohICI.BtrTable);
          mIcd.ohICI.DocNum:=mIcdNum;
          mIcd.ohICI.ItmNum:=mItmNum;
          mIcd.ohICI.PaCode:=mIcd.ohICH.PaCode;
          mIcd.ohICI.DocDate:=mIcd.ohICH.DocDate;
          mIcd.ohICI.MCdNum:=ohMCI.DocNum;
          mIcd.ohICI.MCdItm:=ohMCI.ItmNum;
          mIcd.ohICI.Post;
          // Spatny odkaz na fakturu
          {
          ohMCI.Edit;
          ohMCI.IcdNum:=mIcdNum;
          ohMCI.IcdItm:=mItmNum;
          ohMCI.IcdDate:=mIcd.ohICH.DocDate;
          ohMCI.Post;
           }
        Application.ProcessMessages;
        ohMCI.Next;
      until ohMCI.Eof or (ohMCI.DocNum<>ohMCH.DocNum);
      mIcd.ClcDoc;
      If pPrnIcd then mIcd.PrnDoc;
      ClcDoc;
    end
    else ShowMsg(eCom.DocIsNoExist,mIcdNum);
    FreeAndNil(mIcd);
  end;
end;

procedure TMcd.OcdGen(pTemp,pPrnOcd:boolean);  // Vygeneruje polozky z aktualnej CP do novej ZK;
begin
  OcdGen('',pTemp,pPrnOcd);
end;

procedure TMcd.OcdGen(pMcdNum,pOcdNum:Str12;pTemp,pPrnOcd:boolean); // Vygeneruje polozky z aktualnej CP do novej ZK
begin
  If ohMCH.LocateDocNum(pMCdNum)
    then OcdGen(pOcdNum,pTemp,pPrnOcd)
    else ShowMsg(eCom.DocIsNoExist,pMCdNum);
end;

procedure TMcd.OcdGen(pOcdNum:Str12;pTemp,pPrnOcd:boolean); // Vygeneruje polozky z aktualnej CP do novej ZK;
var mBokNum:Str5;  mItmNum:word;  mOcdNum:Str12; mLast:boolean;
begin
(*
  If ohMCI.LocateDocNum(ohMCH.DocNum) then begin
    mBokNum:=gKey.McbOcbNum[BokNum];
    mOcd:=TOcd.Create(Self);
    mOcd.Open(mBokNum,TRUE,TRUE,FALSE,False);
    mOcdNum:=pOcdNum;
    If mOcdNum='' then begin
      mOcd.NewDoc('',ohMCH.PaCode,FALSE);
      mOcdNum:=mOcd.DocNum;
    end;
    If mOcd.ohOCH.LocateDocNum(mOcdNum) then begin
      Repeat
          If pTemp then ohMCI.LocateDoIt(otMCI.DocNum,otMCI.ItmNum);
          mItmNum:=mOcd.ohOCI.LasItmNum(mOcdNum);
          mOcd.AddItm(ohMCI.GsCode,ohmci.GsQnt,ohmci.DscPrc,ohmci.FgBprice,-1{-1=zisti sa volne mnozstvo});
          // netreba lebo predosle prida aj STO
          // mOcd.AddSto(mOcdNum,mOcd.ohOCI.GsCode);
          mOcd.ohOCI.Insert;
          BTR_To_BTR (ohMCI.BtrTable,mOcd.ohOCI.BtrTable);
          mOcd.ohOCI.DocNum:=mOcdNum;
          mOcd.ohOCI.ItmNum:=mItmNum;
          mOcd.ohOCI.PaCode:=mOcd.ohOCH.PaCode;
          mOcd.ohOCI.DocDate:=mOcd.ohOCH.DocDate;
          mOcd.ohOCI.McdNum:=ohMCI.DocNum;
          mOcd.ohOCI.MCdItm:=ohMCI.ItmNum;
          mOcd.ohOCI.Post;
          // Spatny odkaz na ZK
          ohMCI.Edit;
          ohMCI.OcdNum:=mOcdNum;
          ohMCI.OcdItm:=mItmNum;
          ohMCI.OcdDate:=mOcd.ohOCH.DocDate;
          ohMCI.Post;
          otMCI.Edit;
          If pTemp then begin
            otMCI.OcdNum:=mOcdNum;
            otMCI.OcdItm:=mItmNum;
            otMCI.OcdDate:=mOcd.ohOCH.DocDate;
            otMCI.Post;
          end;
        Application.ProcessMessages;
        If pTemp then begin
          otMCI.Next;
          mLast:=otMCI.Eof or (otMCI.DocNum<>ohMCH.DocNum)
        end else begin
          ohMCI.Next;
          mLast:=ohMCI.Eof or (ohMCI.DocNum<>ohMCH.DocNum)
        end;
      until mLast;
      mOcd.ClcDoc;
      If pPrnOcd then mOcd.PrnDoc;
      ClcDoc;
    end
    else ShowMsg(eCom.DocIsNoExist,mOcdNum);
    FreeAndNil(mOcd);
  end;
*)  
end;

procedure TMcd.AddItm(pGsCode: Integer; pGsQnt, pDscPrc,pFgBPrice,pFgAPrice: double);
var mItmNum:word;
begin
  If not ohGSCAT.Active then ohGSCAT.Open;
  If ohGSCAT.LocateGsCode(pGsCode) then begin
    mItmNum:=ohMCI.NextItmNum(ohMCH.DocNum);
    ohMCI.Insert;
    ohMCI.DocNum:=ohMCH.DocNum;
    ohMCI.ItmNum:=mItmNum;
    BTR_To_BTR(ohGSCAT.BtrTable,ohMCI.BtrTable);
    ohMCI.GsQnt:=pGsQnt;
    ohMCI.DscPrc:=pDscPrc;
//    ohMCI.AcCValue:=RdX(pAcCPrice*pGsQnt,gKey.StpRndFrc);
//    ohMCI.FgCValue:=ClcFgFromAcS(ohMCI.AcCValue,ohMCH.FgCourse);
//    If ohMCI.GsQnt<>0 then ohMCI.FgCPrice:=ohMCI.FgCValue/ohMCI.GsQnt;
    If ohMCH.VatDoc=0 then begin
      If pFgAPrice=0 then pFgAPrice:=pFgBPrice/(1+ohMCI.VatPrc);
      ohMCI.VatPrc:=0;
      ohMCI.SetFgAPrice(pFgAPrice,ohMCH.FgCourse);
    end else ohMCI.SetFgBPrice(pFgBPrice,ohMCH.FgCourse);
    ohMCI.StkNum:=ohMCH.StkNum;
//    ohMCI.WriNum:=ohMCH.WriNum;
    ohMCI.PaCode:=ohMCH.PaCode;
    ohMCI.DocDate:=ohMCH.DocDate;
    ohMCI.Status :='N';
    ohMCI.Post;
  end
  else ShowMsg (eCom.GscIsNoExist,StrInt(pGsCode,0));
end;

procedure TMcd.AddItm(pGsCode: Integer; pGsQnt, pDscPrc,pFgBPrice,pFgAPrice: double;pStkCode:Str15);
var mItmNum:word;
begin
  If not ohGSCAT.Active then ohGSCAT.Open;
  If ohGSCAT.LocateGsCode(pGsCode) then begin
    mItmNum:=ohMCI.NextItmNum(ohMCH.DocNum);
    ohMCI.Insert;
    ohMCI.DocNum:=ohMCH.DocNum;
    ohMCI.ItmNum:=mItmNum;
    BTR_To_BTR(ohGSCAT.BtrTable,ohMCI.BtrTable);
    ohMCI.GsQnt:=pGsQnt;
    ohMCI.DscPrc:=pDscPrc;
    If ohMCH.VatDoc=0 then begin
      If pFgAPrice=0 then pFgAPrice:=pFgBPrice/(1+ohMCI.VatPrc);
      ohMCI.VatPrc:=0;
      ohMCI.SetFgAPrice(pFgAPrice,ohMCH.FgCourse);
    end else ohMCI.SetFgBPrice(pFgBPrice,ohMCH.FgCourse);
    ohMCI.StkNum:=ohMCH.StkNum;
    ohMCI.PaCode:=ohMCH.PaCode;
    ohMCI.StkCode:=pStkCode;
    ohMCI.DocDate:=ohMCH.DocDate;
    ohMCI.Status :='N';
    ohMCI.Post;
  end
  else ShowMsg (eCom.GscIsNoExist,StrInt(pGsCode,0));
end;

procedure TMcd.SetPac(pPaCode,pWpaCode:longint);
begin
  oPaCode:=pPaCode;oWpaCode:=pWpaCode;
  If ohPAB.LocatePaCode(oPaCode) then begin
    ohMCH.Edit;
    BTR_To_BTR (ohPAB.BtrTable,ohMCH.BtrTable);
    ohMCH.SpaCode:=ohMCH.PaCode;
    ohMCH.WpaCode:=0;
    ohMCH.WpaName:=ohMCH.RegName;
    ohMCH.WpaAddr:=ohMCH.RegAddr;
    ohMCH.WpaSta :=ohMCH.RegSta;
    ohMCH.WpaCty :=ohMCH.RegCty;
    ohMCH.WpaCtn :=ohMCH.RegCtn;
    ohMCH.WpaZip :=ohMCH.RegZip;
    If oWpaCode>0 then begin
    end;
    ohMCH.Post;
    // Zadat aj miesto dodania
  end;
end;

procedure TMcd.MCI_To_TMP(phMCI:TMciHnd; ptMCI:TMciTmp); // Ulozi zaznam z btMCI do ptMCI
begin
  BTR_To_PX (phMCI.BtrTable,ptMCI.TmpTable); // Ulozi vseobecne polia poloziek do docasneho suboru
  // Ulozime specialne pole do docasneho suboru
  If IsNotNul(phMCI.GsQnt) then begin
    ptMCI.AcDPrice:=Rd2(phMCI.AcDValue/phMCI.GsQnt);
    ptMCI.AcCPrice:=RoundCPrice(phMCI.AcCValue/phMCI.GsQnt);
    ptMCI.AcAPrice:=Rd2(phMCI.AcAValue/phMCI.GsQnt);
    ptMCI.AcBPrice:=Rd2(phMCI.AcBValue/phMCI.GsQnt);
  end;
end;

end.
{MOD 1804002}  {MOD 1904012}
{MOD 1905022}
{MOD 1907001}
{MOD 1910 - pole Rspname zapisova5 len pri vytvoren9 dokladu }
{MOD 1931 - nový databázový súbor MCO }

