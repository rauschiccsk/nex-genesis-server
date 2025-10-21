unit Edi012;
// =============================================================================
//                   PRÍSTUP K ÚDAJOM ELEKTRONICKÝCH DOKUMENTOV
//                         formát: CSV,CONTINENTAL, INVIO
// -----------------------------------------------------------------------------
//
//
// -----------------------------------------------------------------------------
// ************************* POUŽITÉ DATABÁZOVÉ SÚBORY *************************
// -----------------------------------------------------------------------------
//
// -----------------------------------------------------------------------------
// ********************* PARAMETRE, KTORÉ POUŽÍVA FUNKCIA **********************
// -----------------------------------------------------------------------------
//
// -----------------------------------------------------------------------------
// ********************************* POZNÁMKY **********************************
// -----------------------------------------------------------------------------
//
// -----------------------------------------------------------------------------
// ****************************** HISTÓRIA ZMIEN *******************************
// -----------------------------------------------------------------------------
// 21.01[17.08.18] - Nová funkcia (RZ)
// =============================================================================

interface

uses
  IdSSLOpenSSL, IdExplicitTLSClientServerBase, IdFTPCommon,
  EdiFnc, hPROCAT, BasSrv,
  IcTools, IcConv, IcTypes, TxtCut, LinLst, NexClc, NexPath, NexIni, EncodeIni, Forms, ExtCtrls, Classes, SysUtils, Controls, IdFTP;

type
  TEdi012=class
    constructor Create;
    destructor Destroy; override;
  private
    oEdiFnc:TEdiFnc;
    oFilNam:ShortString;
    oFilDat:TStrings;
    oDocLst:TLinLst;
    oTxtCut:TTxtCut;
    function CnvTxtDte(pTxtDte:Str8):TDateTime; // Prekonvertuje dátum z formátu YYYYMMDD na TDateTime
    function ChgFtpDir(pIdFTP:TIdFTP;pPath:string):boolean;  //Prejde do zadaneho podadresara na FTP. Ak neexistuje, vytvori
    procedure LodFtpDat; // Prekontroluje Ftp server a keï nájde súbor stiahne
    procedure SepCsvFil; // Rozdelí dodaný súbor na samostatné CSV pod¾a jednotlivých faktúr

    procedure LodDocDat;
    procedure LodItmDat;
    procedure LodPsnDat;
  public
    procedure Execute(pEdiFnc:TEdiFnc);
  published
  end;

implementation

// ********************************* OBJECT ************************************

constructor TEdi012.Create;
begin
  oFilNam:='';
  oDocLst:=TLinLst.Create;
  oFilDat:=TStringList.Create;
  oTxtCut:=TTxtCut.Create; oTxtCut.SetSeparator(';'); oTxtCut.SetDelimiter('"');
end;

destructor TEdi012.Destroy;
begin
  FreeAndNil(oTxtCut);
  FreeAndNil(oFilDat);
  FreeAndNil(oDocLst);
end;

// ******************************** PUBLIC *************************************

procedure TEdi012.Execute(pEdiFnc:TEdiFnc);
begin
  oEdiFnc:=pEdiFnc;
  LodFtpDat; // Prekontroluje Ftp server a keï nájde súbor stiahne
  SepCsvFil; // Rozdelí dodaný súbor na samostatné CSV pod¾a jednotlivých faktúr
end;

// ******************************** PRIVATE ************************************

function TEdi012.CnvTxtDte(pTxtDte:Str8):TDateTime; // Prekonvertuje dátum z formátu YYYYMMDD na TDateTime
var mYY,mMM,mDD:word;
begin
  Result:=0;
  If Length(pTxtDte)=8 then begin
    mYY:=ValInt(copy(pTxtDte,1,4));
    mMM:=ValInt(copy(pTxtDte,5,2));
    mDD:=ValInt(copy(pTxtDte,7,2));
    Result:= EncodeDate(mYY,mMM,mDD);
  end;
end;

function  TEdi012.ChgFtpDir (pIdFTP:TIdFTP;pPath:string):boolean;
var mErr:boolean; mPath:string;
begin
  If pPath<>'' then begin
    pPath:=ReplaceStr(pPath,'\','/');
    If Copy(pPath,Length(pPath),1)<>'/' then pPath:=pPath+'/';
  end else pPath:='/';
  mErr:=FALSE;
  try
    pIdFTP.ChangeDir(pPath);
  except mErr:=TRUE; end;
  If mErr then begin
    mErr:=FALSE;
    try
      pIdFTP.ChangeDirUp;
    except mErr:=TRUE; end;
    If not mErr then begin
      While (pPath<>'') and not mErr do begin
        If Copy (pPath,1,1)='/' then Delete(pPath,1,1);
        If pPath<>'' then begin
          If Pos ('/',pPath)>0 then begin
            mPath:= Copy(pPath,1,Pos('/',pPath)-1);
            Delete(pPath,1,Pos('/',pPath));
          end else begin
            mPath:=pPath;
            pPath:='';
          end;
          If mPath<>'' then begin
            try
              pIdFTP.ChangeDir(mPath);
            except
              try
                pIdFTP.MakeDir(mPath);
              except mErr:=TRUE; end;
              If not mErr then begin
                try
                  pIdFTP.ChangeDir(mPath);
                except mErr:=TRUE; end;
              end;
            end;
          end;
        end;
      end;
    end;
  end;
  Result:=not mErr;
end;

procedure TEdi012.LodFtpDat; // Prekontroluje Ftp server a keï nájde súbor stiahne
var mFTP:TIdFTP; mDirLst:TStringList; mOK:boolean;
    mIOHandler:TIdSSLIOHandlerSocketOpenSSL;
begin
  With oEdiFnc do begin
    mFTP:=TIdFTP.Create(nil);
  mFTP.Port:=21;
//    mFTP.Port:=222;
    mFTP.Passive:=TRUE;
    mFTP.Host:=ohEDIREG.FtpAdr;
    mFTP.Username:=ohEDIREG.FtpUsr;
    mFTP.Password:=ohEDIREG.FtpPsw;
//  mIOHandler:=TIdSSLIOHandlerSocketOpenSSL.Create;
//  mIOHandler.SSLOptions.SSLVersions := [sslvTLSv1];
//  mFTP.IOHandler:=mIOHandler;
//  mFTP.UseTLS:=utUseImplicitTLS;
//  mFTP.DataPortProtection:=ftpdpsPrivate;

    mOK:=TRUE;
    try
      mFTP.Connect;
    except mOK:=FALSE; end;
    If mOK then begin
//      If ChgFtpDir(mFTP,'') then begin  // Podadresar na FTP
        mDirLst:=TStringList.Create;
        mFTP.List(mDirLst,'*.csv',FALSE);    // Mask
        If mDirLst.Count>0 then begin
          mOK:=TRUE;
          try
            If FileExists(gPath.ImpPath+'EDI012.csv') then DeleteFile(gPath.ImpPath+'EDI012.csv');
            mFTP.Get(mDirLst.Strings[0],gPath.ImpPath+'EDI012.csv');
          except mOK:=FALSE; end;
          If mOK then begin
            SetLastProc (mDirLst.Strings[0]);
            mFTP.Delete(mDirLst.Strings[0]);
          end;
        end;
        FreeAndNil(mDirLst);
//      end;
      try
        mFTP.Disconnect;
      except end;
    end;
    try
  FreeAndNil(mIOHandler);
      FreeAndNil(mFTP);
    except end;
  end;
end;

procedure TEdi012.SepCsvFil; // Rozdelí dodaný súbor na samostatné CSV pod¾a jednotlivých faktúr
var I:word;  mOrdCod:Str30;  mSepFil:TStrings;  mhPROCAT:TProcatHnd;
begin
  With oEdiFnc do begin
    If FileExists(gPath.ImpPath+'EDI012.csv') then begin
      oFilDat.LoadFromFile(gPath.ImpPath+'EDI012.csv');
      If oFilDat.Count>0 then begin
        mhPROCAT:=TProcatHnd.Create;
        // Vytvoríme zoznam faktúr, ktoré sú uložené v súbore
        oTxtCut.SetStr(oFilDat.Strings[1]);
        oDocLst.AddItm(oTxtCut.GetText(6));
        For I:=2 to oFilDat.Count-1 do begin
          oTxtCut.SetStr(oFilDat.Strings[I]);
          If not oDocLst.LocItm(oTxtCut.GetText(6)) then oDocLst.AddItm(oTxtCut.GetText(6));
        end;
        If oDocLst.Count>0 then begin
          // Vytvoríme samostatný súbor pre každú faktúru
          mSepFil:=TStringList.Create;
          oDocLst.First;
          Repeat
            mSepFil.Clear;
            mSepFil.Add(oFilDat.Strings[0]);
            For I:=1 to oFilDat.Count-1 do begin
              oTxtCut.SetStr(oFilDat.Strings[I]);
              If oTxtCut.GetText(6)=oDocLst.Itm then begin //
                If not ohEDIDOC.LocExtNum(oTxtCut.GetText(6)) then begin
                  ohEDIDOC.Insert;
                  ohEDIDOC.ExtNum:=oTxtCut.GetText(6);  // F006 (Invoice No)
                  ohEDIDOC.OrdNum:=oTxtCut.GetText(14); // F014 (Purchase Order No)
                  ohEDIDOC.DocDte:=CnvTxtDte(oTxtCut.GetText(7));  // F007 (Invoice Date)
                  ohEDIDOC.DlvDte:=CnvTxtDte(oTxtCut.GetText(10)); // F010 (Delivery Date)
                  ohEDIDOC.ParNum:=ohEDIREG.ParNum;
                  ohEDIDOC.ParNam:=ohEDIREG.ParNam;
                  ohEDIDOC.DvzNam:=oTxtCut.GetText(8);  // F008 (Currency)
                  ohEDIDOC.EdfNam:='DF-'+ohEDIREG.RegIno+'-'+AlignLeftBy(ohEDIDOC.ExtNum,12,'0')+'.csv';
                  ohEDIDOC.Post;
                end;
                mOrdCod:=oTxtCut.GetText(17); // F017 (Article Number)
//                If mOrdCod[1]='0' then Delete(mOrdCod,1,1);
                ohEDIITM.Insert;
                ohEDIITM.ExtNum:=ohEDIDOC.ExtNum;
                ohEDIITM.ItmNum:=oTxtCut.GetNum(15);  // F015 (Line Number)
                ohEDIITM.OrdCod:=mOrdCod;
                If mhPROCAT.LocOrdCod(mOrdCod) then begin
                  ohEDIITM.ProNum:=mhPROCAT.ProNum;
                  ohEDIITM.ProNam:=mhPROCAT.ProNam;
                  ohEDIITM.BarCod:=mhPROCAT.BarCod;
                  ohEDIITM.MsuNam:=mhPROCAT.MsuNam;
                end else begin
                  ohEDIITM.ProNum:=0;
                  ohEDIITM.ProNam:=oTxtCut.GetText(19); // F019 (Article Text)
                  ohEDIITM.BarCod:=oTxtCut.GetText(16); // F016 (EAN)
                  ohEDIITM.MsuNam:='ks';
                end;
                ohEDIITM.VatPrc:=oTxtCut.GetNum(27);  // F027 (VAT Percentage)
                ohEDIITM.DlvPrq:=oTxtCut.GetReal(22); // F022 (Quantity)
                ohEDIITM.DlvBva:=oTxtCut.GetReal(26); // F026 (Net Amount)
                ohEDIITM.DlvAva:=ClcAvaVat(ohEDIITM.DlvBva,ohEDIITM.VatPrc);
                If IsNotNul(ohEDIITM.DlvPrq) then ohEDIITM.DlvApc:=RndBas(ohEDIITM.DlvAva/ohEDIITM.DlvPrq);
                ohEDIITM.Post;
                mSepFil.Add(oFilDat.Strings[I]);
              end;
            end;
            mSepFil.SaveToFile(gPath.ImpPath+ohEDIDOC.EdfNam);
            ClcActDoc;
            Application.ProcessMessages;
            oDocLst.Next;
          until oDocLst.Eof;
          FreeAndNil(mSepFil);
          DeleteFile(gPath.ImpPath+'EDI012.csv');
        end;
        FreeAndNil(mhPROCAT);
      end;
    end;
  end;
end;

(*
procedure TEdi012.LodEdiDat;
var I:word;
begin
  oFilNam:=pFilNam;
  oEdiDat:=pEdiDat;
  If FileExists(oFilNam) then begin
    oFilDat.LoadFromFile(oFilNam);
    If oFilDat.Count>0 then begin
      oTxtCut.SetStr(oFilDat.Strings[1]);
      LodDocDat;
      For I:=1 to oFilDat.Count-1 do begin
        oTxtCut.SetStr(oFilDat.Strings[I]);
        LodItmDat;
      end;
    end;
  end;
end;
*)
procedure TEdi012.LodDocDat;
begin
(*
  oEdiDat.ovDOCDAT.Clear;
  oEdiDat.ovDOCDAT.DocVer:=1;
  oEdiDat.ovDOCDAT.SupIno:='';
  oEdiDat.ovDOCDAT.SupTin:='';
  oEdiDat.ovDOCDAT.SupVin:='';
  oEdiDat.ovDOCDAT.SupNam:='';
  oEdiDat.ovDOCDAT.SupEml:='';
  oEdiDat.ovDOCDAT.DocTyp:='F';
  oEdiDat.ovDOCDAT.ExdNum:=oTxtCut.GetText(6);  // F006 (Invoice No)
  oEdiDat.ovDOCDAT.IseNum:='';
  oEdiDat.ovDOCDAT.OriIse:='';
  oEdiDat.ovDOCDAT.OrdNum:=oTxtCut.GetText(14); // F014 (Purchase Order No)
  oEdiDat.ovDOCDAT.SndDte:=oTxtCut.GetDate(7);  // F007 (Invoice Date)
  oEdiDat.ovDOCDAT.ExpDte:=0;
  oEdiDat.ovDOCDAT.DlvDte:=oTxtCut.GetDate(10); // F010 (Delivery Date)
  oEdiDat.ovDOCDAT.DvzNam:=oTxtCut.GetText(8);  // F008 (Currency)
  oEdiDat.ovDOCDAT.DocBva:=0;
  oEdiDat.ovDOCDAT.ItmQnt:=0;
  oEdiDat.ovDOCDAT.ItmFld:='';
*)
end;

procedure TEdi012.LodItmDat;
begin
(*
  oEdiDat.ovITMDAT.Clear;
  oEdiDat.ovITMDAT.ItmNum:=oTxtCut.GetNum(15);  // F015 (Line Number)
  oEdiDat.ovITMDAT.OrdCod:=oTxtCut.GetText(17); // F017 (Article Number)
  oEdiDat.ovITMDAT.BarCod:=oTxtCut.GetText(16); // F016 (EAN)
  oEdiDat.ovITMDAT.ProNam:=oTxtCut.GetText(19); // F019 (Article Text)
  oEdiDat.ovITMDAT.MsuNam:='';
  oEdiDat.ovITMDAT.VatPrc:=oTxtCut.GetNum(27);  // F027 (VAT Percentage)
  oEdiDat.ovITMDAT.ProQnt:=oTxtCut.GetReal(22); // F022 (Quantity)
  oEdiDat.ovITMDAT.CusBpc:=oTxtCut.GetReal(23); // F023 (Gross Unit Price)
  oEdiDat.ovITMDAT.ProBva:=oTxtCut.GetReal(24); // F024 (Net Unit Price)
  oEdiDat.ovITMDAT.ProWgh:=0;
*)
end;

procedure TEdi012.LodPsnDat;
begin
end;

// ******************************** ACTIONS ************************************

end.
