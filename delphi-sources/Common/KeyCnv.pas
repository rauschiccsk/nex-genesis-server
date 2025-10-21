unit KeyCnv;

interface

uses
  IcVariab, IcConst, IcTypes, Key,
  hNXBDEF,
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, DB, BtrTable, NexBtrTable, StdCtrls, xpComp, ExtCtrls;

type
  TKeyCnvF = class(TForm)
    btSTKLST: TNexBtrTable;
    xpSinglePanel1: TxpSinglePanel;
    xpLabel1: TxpLabel;
    btRMBLST: TNexBtrTable;
    btOCBLST: TNexBtrTable;
    btISBLST: TNexBtrTable;
    btICBLST: TNexBtrTable;
    btTSBLST: TNexBtrTable;
    btTCBLST: TNexBtrTable;
    btCSBLST: TNexBtrTable;
    btIMBLST: TNexBtrTable;
    btOSBLSt: TNexBtrTable;
    btSOBLST: TNexBtrTable;
    btOMBLST: TNexBtrTable;
    btTOBLST: TNexBtrTable;
    btIDBLST: TNexBtrTable;
    btTIBLST: TNexBtrTable;
    btALBLST: TNexBtrTable;
    btDMBLST: TNexBtrTable;
    btCMBLST: TNexBtrTable;
    btCDBLST: TNexBtrTable;
    btPKBLST: TNexBtrTable;
    btMCBLST: TNexBtrTable;
    btSVBLST: TNexBtrTable;
    btACBLST: TNexBtrTable;
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
  private
    ohNXBDEF:TNxbdefHnd;
    oBookType : Str1;
    oBookNum  : Str3;
    oBookCnv  : Str5;
  public
    // Zoznamy
    procedure StkLstCnv;
    // Knihy
    procedure ImbLstCnv;
    procedure OmbLstCnv;
    procedure RmbLstCnv;
    procedure CmbLstCnv;
    procedure CdbLstCnv;
    procedure PkbLstCnv;
    procedure DmbLstCnv;
    procedure OcbLstCnv;
    procedure OsbLstCnv;
    procedure TsbLstCnv;
    procedure TcbLstCnv;
    procedure TibLstCnv;
    procedure TobLstCnv;
    procedure IsbLstCnv;
    procedure IcbLstCnv;
    procedure CsbLstCnv;
    procedure SobLstCnv;
    procedure IdbLstCnv;
    procedure AcbLstCnv;
    procedure SvbLstCnv;
    procedure AlbLstCnv;
    procedure McbLstCnv;
  published
    property BookCnv:Str5 read oBookCnv write oBookCnv;  
  end;

implementation

{$R *.dfm}

procedure TKeyCnvF.FormCreate(Sender: TObject);
begin
  ohNXBDEF := TNxbDefHnd.Create;  ohNXBDEF.Open;
  oBookCnv := '';
end;

procedure TKeyCnvF.FormDestroy(Sender: TObject);
begin
  FreeAndNil (ohNXBDEF);
end;

// ********************************* PRIVAT ************************************

// ********************************* PUBLIC ************************************

procedure TKeyCnvF.StkLstCnv;
var mStkNum:Str5;
begin
  Show;
  ohNXBDEF.Del ('STK');
  btSTKLST.Open;
  If btSTKLST.RecordCount>0 then begin
    Repeat
      mStkNum := btSTKLST.FieldByName('StkNum').AsString;
      // Ulozime do zoznamu knih
      ohNXBDEF.Insert;
      ohNXBDEF.PmdMark := 'STK';
      ohNXBDEF.BookNum := mStkNum;
      ohNXBDEF.BookName := btSTKLST.FieldByName('StkName').AsString;
      ohNXBDEF.Post;
      // Ulozime vlastnosti skladu
      gKey.StkScType[mStkNum] := 'T';
      gKey.StkWriNum[mStkNum] := btSTKLST.FieldByName('WriNum').AsInteger;
      gKey.StkPlsNum[mStkNum] := btSTKLST.FieldByName('PlsNum').AsInteger;
      gKey.StkShared[mStkNum] := btSTKLST.FieldByName('Shared').AsInteger=1;
      Application.ProcessMessages;
      btSTKLST.Next;
    until btSTKLST.Eof;
  end;
  btSTKLST.Close;
  Hide;
end;

procedure TKeyCnvF.IMBLstCnv;
var mBookNum:Str5;
begin
  Show;
  If oBookCnv<>'' then ohNXBDEF.DelBok ('IMB',oBookCnv) else ohNXBDEF.Del ('IMB');
  btIMBLST.Open;
  If btIMBLST.RecordCount>0 then begin
    If (oBookCnv<>'') and not btIMBLST.FindKey([oBookCnv]) then Exit;
    Repeat
      // Ulozime do zoznamu knih
      mBookNum := btIMBLST.FieldByName('BookNum').AsString;
      If StrToInt(Copy(btIMBLST.FieldByName('BookNum').AsString,1,2))<StrToInt(gvsys.ActYear2)
        then oBookType:='P' else oBookType:='A';
      oBookNum := oBookType+'-'+Copy(btIMBLST.FieldByName('BookNum').AsString,3,3);
      If not ohNXBDEF.LocatePmBn('IMB',oBookNum)
        then ohNXBDEF.Insert else ohNXBDEF.Edit;
      ohNXBDEF.PmdMark := 'IMB';
      ohNXBDEF.BookNum := oBookNum;
      ohNXBDEF.BookName := btIMBLST.FieldByName('BookName').AsString;
      ohNXBDEF.BookType := 'A';
//      If ohNXBDEF.BookYear='' then ohNXBDEF.BookYear := gvSys.Actyear;
      ohNXBDEF.Post;
      // Ulozime vlastnosti skladu
      gKey.ImbStkNum[oBookNum] := btIMBLST.FieldByName('StkNum').AsInteger;
      gKey.ImbPlsNum[oBookNum] := 0;
      gKey.ImbSmCode[oBookNum] := btIMBLST.FieldByName('SmCode').AsInteger;
      gKey.ImbAutAcc[oBookNum] := btIMBLST.FieldByName('AutoAcc').AsInteger=1;
      gKey.ImbOnlSub[oBookNum] := btIMBLST.FieldByName('Online').AsInteger=1;
      gKey.ImbFtpRcv[oBookNum] := btIMBLST.FieldByName('FtpRcv').AsInteger=1;
      gKey.ImbBpcMod[oBookNum] := True;
      Application.ProcessMessages;
      btIMBLST.Next;
    until btIMBLST.Eof or (oBookCnv<>'');
  end;
  btIMBLST.Close;
  Hide;
end;

procedure TKeyCnvF.RmbLstCnv;
var mBookNum:Str5;
begin
  Show;
  If oBookCnv<>'' then ohNXBDEF.DelBok ('RMB',oBookCnv) else ohNXBDEF.Del ('RMB');
  btRMBLST.Open;
  If btRMBLST.RecordCount>0 then begin
    If (oBookCnv<>'') and not btRMBLST.FindKey([oBookCnv]) then Exit;
    Repeat
      mBookNum := btRMBLST.FieldByName('BookNum').AsString;
      If StrToInt(Copy(btRMBLST.FieldByName('BookNum').AsString,1,2))<StrToInt(gvsys.ActYear2)
        then oBookType:='P' else oBookType:='A';
      oBookNum := oBookType+'-'+Copy(btRMBLST.FieldByName('BookNum').AsString,3,3);
      If not ohNXBDEF.LocatePmBn('RMB',oBookNum)
        then ohNXBDEF.Insert else ohNXBDEF.Edit;
      ohNXBDEF.PmdMark := 'RMB';
      ohNXBDEF.BookNum := oBookNum;
      ohNXBDEF.BookName := btRMBLST.FieldByName('BookName').AsString;
      ohNXBDEF.Post;
      // Ulozime vlastnosti skladu
      gKey.RmbBoYear[oBookNum] := btRMBLST.FieldByName('BookYear').AsString;
      gKey.RmbOutStn[oBookNum] := btRMBLST.FieldByName('ScStkNum').AsInteger;
      gKey.RmbIncStn[oBookNum] := btRMBLST.FieldByName('TgStkNum').AsInteger;
      gKey.RmbOutSmc[oBookNum] := btRMBLST.FieldByName('ScSmCode').AsInteger;
      gKey.RmbIncSmc[oBookNum] := btRMBLST.FieldByName('TgSmCode').AsInteger;
      gKey.RmbAutAcc[oBookNum] := btRMBLST.FieldByName('AutoAcc').AsInteger=1;
      gKey.RmbOnlSub[oBookNum] := btRMBLST.FieldByName('Online').AsInteger=1;
      Application.ProcessMessages;
      btRMBLST.Next;
    until btRMBLST.Eof or (oBookCnv<>'');
  end;
  btRMBLST.Close;
  Hide;
end;

procedure TKeyCnvF.OmbLstCnv;
var mBookNum:Str5;
begin
  Show;
  If oBookCnv<>'' then ohNXBDEF.DelBok ('OMB',oBookCnv) else ohNXBDEF.Del ('OMB');
  btOMBLST.Open;
  If btOMBLST.RecordCount>0 then begin
    If (oBookCnv<>'') and not btOMBLST.FindKey([oBookCnv]) then Exit;
    Repeat
      mBookNum := btOMBLST.FieldByName('BookNum').AsString;
      If StrToInt(Copy(btOMBLST.FieldByName('BookNum').AsString,1,2))<StrToInt(gvsys.ActYear2)
        then oBookType:='P' else oBookType:='A';
      oBookNum := oBookType+'-'+Copy(btOMBLST.FieldByName('BookNum').AsString,3,3);
      If not ohNXBDEF.LocatePmBn('OMB',oBookNum)
        then ohNXBDEF.Insert else ohNXBDEF.Edit;
      ohNXBDEF.PmdMark := 'OMB';
      ohNXBDEF.BookNum := oBookNum;
      ohNXBDEF.BookName := btOMBLST.FieldByName('BookName').AsString;
      ohNXBDEF.Post;
      // Ulozime vlastnosti skladu
      gKey.OmbStkNum[oBookNum] := btOMBLST.FieldByName('StkNum').AsInteger;
      gKey.OmbSmCode[oBookNum] := btOMBLST.FieldByName('SmCode').AsInteger;
      gKey.OmbAutAcc[oBookNum] := btOMBLST.FieldByName('AutoAcc').AsInteger=1;
      gKey.OmbFtpSnd[oBookNum] := btOMBLST.FieldByName('Shared').AsInteger=1;
      gKey.OmbImbStk[oBookNum] := btOMBLST.FieldByName('ImdStk').AsInteger;
      gKey.OmbImbSmc[oBookNum] := btOMBLST.FieldByName('ImdSmc').AsInteger;
      gKey.OmbImbNum[oBookNum] := btOMBLST.FieldByName('ImdBook').AsString;
      gKey.OMBOnlSub[oBookNum] := btOMBLST.FieldByName('Online').AsInteger=1;
      Application.ProcessMessages;
      btOMBLST.Next;
    until btOMBLST.Eof or (oBookCnv<>'');
  end;
  btOMBLST.Close;
  Hide;
end;

procedure TKeyCnvF.OcbLstCnv;
var mBookNum:Str5;
begin
  Show;
  If oBookCnv<>'' then ohNXBDEF.DelBok ('OCB',oBookCnv) else ohNXBDEF.Del ('OCB');
  btOCBLST.Open;
  If btOCBLST.RecordCount>0 then begin
    If (oBookCnv<>'') and not btOCBLST.FindKey([oBookCnv]) then Exit;
    Repeat
      mBookNum := btOCBLST.FieldByName('BookNum').AsString;
      If StrToInt(Copy(btOCBLST.FieldByName('BookNum').AsString,1,2))<StrToInt(gvsys.ActYear2)
        then oBookType:='P' else oBookType:='A';
      oBookNum := oBookType+'-'+Copy(btOCBLST.FieldByName('BookNum').AsString,3,3);
      If not ohNXBDEF.LocatePmBn('OCB',oBookNum)
        then ohNXBDEF.Insert else ohNXBDEF.Edit;
      ohNXBDEF.PmdMark := 'OCB';
      ohNXBDEF.BookNum := oBookNum;
      ohNXBDEF.BookName := btOCBLST.FieldByName('BookName').AsString;
      ohNXBDEF.Post;
      // Ulozime vlastnosti OCBLST.BDF
      gKey.OcbBoYear[oBookNum] := btOCBLST.FieldByName('BookYear').AsString;
      gKey.OcbExnFrm[oBookNum] := btOCBLST.FieldByName('ExnFrm').AsString;
      gKey.OcbDvName[oBookNum] := btOCBLST.FieldByName('DvzName').AsString;
      gKey.OcbItmEdi[oBookNum] := btOCBLST.FieldByName('ItmForm').AsInteger;
      gKey.OcbDocEdi[oBookNum] := btOCBLST.FieldByName('DocForm').AsInteger;
      gKey.OcbAvtRnd[oBookNum] := btOCBLST.FieldByName('AcVatRnd').AsInteger;
      gKey.OcbAvlRnd[oBookNum] := btOCBLST.FieldByName('AcValRnd').AsInteger;
      gKey.OcbFvtRnd[oBookNum] := btOCBLST.FieldByName('FgVatRnd').AsInteger;
      gKey.OcbFvlRnd[oBookNum] := btOCBLST.FieldByName('FgValRnd').AsInteger;
      gKey.OcbPabNum[oBookNum] := btOCBLST.FieldByName('PabBook').AsInteger;
      gKey.OcbNotRes[oBookNum] := btOCBLST.FieldByName('NotRes').AsInteger=1;
      gKey.OcbIntDoc[oBookNum] := btOCBLST.FieldByName('IntDoc').AsInteger=1;
      gKey.OcbPrnCls[oBookNum] := btOCBLST.FieldByName('PrnCls').AsInteger=1;
      gKey.OcbDsHide[oBookNum] := btOCBLST.FieldByName('DsHide').AsInteger=1;
      gKey.OcbBaName[oBookNum] := btOCBLST.FieldByName('BankName').AsString;
      gKey.OcbBaIban[oBookNum] := btOCBLST.FieldByName('IbanCode').AsString;
      gKey.OcbBaSwft[oBookNum] := btOCBLST.FieldByName('SwftCode').AsString;
      gKey.OcbBaAddr[oBookNum] := btOCBLST.FieldByName('BankAddr').AsString;
      gKey.OcbBaCity[oBookNum] := btOCBLST.FieldByName('BankCity').AsString;
      gKey.OcbBaStat[oBookNum] := btOCBLST.FieldByName('BankStat').AsString;
      gKey.OcbWriNum[oBookNum] := btOCBLST.FieldByName('WriNum').AsInteger;
      gKey.OcbStkNum[oBookNum] := btOCBLST.FieldByName('StkNum').AsInteger;
      gKey.OcbPlsNum[oBookNum] := btOCBLST.FieldByName('PlsNum').AsInteger;
      gKey.OcbCasNum[oBookNum] := btOCBLST.FieldByName('CasNum').AsInteger;
      gKey.OcbTcbNum[oBookNum] := btOCBLST.FieldByName('TcdBook').AsString;
      gKey.OcbIcbNum[oBookNum] := btOCBLST.FieldByName('IcdBook').AsString;
      gKey.OcbPcbNum[oBookNum] := btOCBLST.FieldByName('PcdBook').AsString;
      gKey.OcbCsbNum[oBookNum] := btOCBLST.FieldByName('CsdBook').AsString;
      Application.ProcessMessages;
      btOCBLST.Next;
    until btOCBLST.Eof or (oBookCnv<>'');
  end;
  btOCBLST.Close;
  Hide;
end;

procedure TKeyCnvF.TsbLstCnv;
var mBookNum:Str5;
begin
  Show;
  If oBookCnv<>'' then ohNXBDEF.DelBok ('TSB',oBookCnv) else ohNXBDEF.Del ('TSB');
  btTSBLST.Open;
  If btTSBLST.RecordCount>0 then begin
    If (oBookCnv<>'') and not btTSBLST.FindKey([oBookCnv]) then Exit;
    Repeat
      mBookNum := btTSBLST.FieldByName('BookNum').AsString;
      If StrToInt(Copy(btTSBLST.FieldByName('BookNum').AsString,1,2))<StrToInt(gvsys.ActYear2)
        then oBookType:='P' else oBookType:='A';
      oBookNum := oBookType+'-'+Copy(btTSBLST.FieldByName('BookNum').AsString,3,3);
      If not ohNXBDEF.LocatePmBn('TSB',oBookNum)
        then ohNXBDEF.Insert else ohNXBDEF.Edit;
      ohNXBDEF.PmdMark := 'TSB';
      ohNXBDEF.BookNum := oBookNum;
      ohNXBDEF.BookName := btTSBLST.FieldByName('BookName').AsString;
      ohNXBDEF.Post;
      // Ulozime vlastnosti skladu
      // TsdRcv       byte         ;Elektronicky prenos dokladov (0-vseobecny,1-specialny)
      // RcvType      byte         ;Typ specialneho elektronickeho prenosu dokladov
      // VatRnd       byte         ;Typ zaokruhlenia DPH z PC
      // ValRnd       byte         ;Typ zaokruhlenia PC s DPH
      If gKey.TsbBoYear[oBookNum]='' then gKey.TsbBoYear[oBookNum] := btTSBLST.FieldByName('BookYear').AsString;
      If gKey.TsbWriNum[oBookNum]=0  then gKey.TsbWriNum[oBookNum] := btTSBLST.FieldByName('WriNum').AsInteger;
      If gKey.TsbStkNum[oBookNum]=0  then gKey.TsbStkNum[oBookNum] := btTSBLST.FieldByName('StkNum').AsInteger;
      If gKey.TsbPlsNum[oBookNum]=0  then gKey.TsbPlsNum[oBookNum] := btTSBLST.FieldByName('PlsNum').AsInteger;
      If gKey.TsbDvName[oBookNum]='' then gKey.TsbDvName[oBookNum] := btTSBLST.FieldByName('DvzName').AsString;
      If gKey.TsbPabNum[oBookNum]=0  then gKey.TsbPabNum[oBookNum] := btTSBLST.FieldByName('PabBook').AsInteger;
      If gKey.TsbDefPac[oBookNum]=0  then gKey.TsbDefPac[oBookNum] := btTSBLST.FieldByName('PaCode').AsInteger;
      If gKey.TsbSmCode[oBookNum]=0  then gKey.TsbSmCode[oBookNum] := btTSBLST.FieldByName('SmCode').AsInteger;
      If gKey.TsbIsbNum[oBookNum]='' then gKey.TsbIsbNum[oBookNum] := btTSBLST.FieldByName('IsdBook').AsString;
      gKey.TsbAutAcc[oBookNum] := btTSBLST.FieldByName('AutoAcc').AsInteger=1;
      gKey.TsbOnlSub[oBookNum] := btTSBLST.FieldByName('Online').AsInteger=1;
      gKey.TsbBcsVer[oBookNum] := btTSBLST.FieldByName('BcsVer').AsInteger=1;
      gKey.TsbRevClc[oBookNum] := btTSBLST.FieldByName('RevCalc').AsInteger=1;
      Application.ProcessMessages;
      btTSBLST.Next;
    until btTSBLST.Eof or (oBookCnv<>'');
  end;
  btTSBLST.Close;
  Hide;
end;

procedure TKeyCnvF.TcbLstCnv;
var mBookNum:Str5;
begin
  Show;
  If oBookCnv<>'' then ohNXBDEF.DelBok ('TCB',oBookCnv) else ohNXBDEF.Del ('TCB');
  btTCBLST.Open;
  If btTCBLST.RecordCount>0 then begin
    If (oBookCnv<>'') and not btTCBLST.FindKey([oBookCnv]) then Exit;
    Repeat
      mBookNum := btTCBLST.FieldByName('BookNum').AsString;
      If StrToInt(Copy(btTCBLST.FieldByName('BookNum').AsString,1,2))<StrToInt(gvsys.ActYear2)
        then oBookType:='P' else oBookType:='A';
      oBookNum := oBookType+'-'+Copy(btTCBLST.FieldByName('BookNum').AsString,3,3);
      If not ohNXBDEF.LocatePmBn('TCB',oBookNum)
        then ohNXBDEF.Insert else ohNXBDEF.Edit;
      ohNXBDEF.PmdMark := 'TCB';
      ohNXBDEF.BookNum := oBookNum;
      ohNXBDEF.BookName := btTCBLST.FieldByName('BookName').AsString;
      ohNXBDEF.Post;
      // Nasledovne parametre neboli prenesene:
      // AutoLst    byte         ;Automaticke zobrazenie zoznamu tovaru (1-zapnuty)
      // SalCode    word         ;Kod obchodoeho zastupcu
      // StkMod     byte         ;Povolenia zmeny skladu vydaja tovaru (1-zapnuty)
      // SerMod     byte         ;Povolenie zmeny poradoveho cisla dokladu (1-zapnuty)
      // DocSnd     byte         ;Moznost online odoslania dokladu na inu prevadzku (1-zapnuta)
      // DocRcv     byte         ;Moznost online prijmu dokladu z inej prevadzky (1-zapnuta)
      // MyTelNum   Str20        ;Telefonne cislo prevadzky
      // MyFaxNum   Str20        ;Faxove cislo prevadzky
      // MyWebSite  Str30        ;Webova stranka prevadzky
      // MyEmail    Str30        ;Elektronicka postova adresa prevadzky
      gKey.TcbBoYear[oBookNum] := btTCBLST.FieldByName('BookYear').AsString;
      gKey.TcbWriNum[oBookNum] := btTCBLST.FieldByName('WriNum').AsInteger;
      gKey.TcbStkNum[oBookNum] := btTCBLST.FieldByName('StkNum').AsInteger;
      gKey.TcbPlsNum[oBookNum] := btTCBLST.FieldByName('PlsNum').AsInteger;
      gKey.TcbDvName[oBookNum] := btTCBLST.FieldByName('DvzName').AsString;
      gKey.TcbExnFrm[oBookNum] := btTCBLST.FieldByName('ExnFrm').AsString;
      gKey.TcbPabNum[oBookNum] := btTCBLST.FieldByName('PabBook').AsInteger;
      gKey.TcbDefPac[oBookNum] := 0;
      gKey.TcbSmCode[oBookNum] := btTCBLST.FieldByName('SmCode').AsInteger;
      gKey.TcbFgCalc[oBookNum] := btTCBLST.FieldByName('FgCalc').AsInteger;
      gKey.TcbAvtRnd[oBookNum] := btICBLST.FieldByName('AcVatRnd').AsInteger;
      gKey.TcbAvlRnd[oBookNum] := btICBLST.FieldByName('AcValRnd').AsInteger;
      gKey.TcbFvtRnd[oBookNum] := btICBLST.FieldByName('FgVatRnd').AsInteger;
      gKey.TcbFvlRnd[oBookNum] := btICBLST.FieldByName('FgValRnd').AsInteger;
      gKey.TcbAutAcc[oBookNum] := btTCBLST.FieldByName('AutoAcc').AsInteger=1;
      gKey.TcbOnlSub[oBookNum] := btTCBLST.FieldByName('Online').AsInteger=1;
      gKey.TcbOcnVer[oBookNum] := btTCBLST.FieldByName('OcnVer').AsInteger=1;
      gKey.TcbPrnCls[oBookNum] := btTCBLST.FieldByName('PrnCls').AsInteger=1;
      gKey.TcbIcbNum[oBookNum] := btTCBLST.FieldByName('IcdBook').AsString;
      gKey.TcbDsHide[oBookNum] := btTCBLST.FieldByName('DsHide').AsInteger=1;

      Application.ProcessMessages;
      btTCBLST.Next;
    until btTCBLST.Eof or (oBookCnv<>'');
  end;
  btTCBLST.Close;
  Hide;
end;

procedure TKeyCnvF.IsbLstCnv;
var mBookNum:Str5;
begin
  Show;
  If oBookCnv<>'' then ohNXBDEF.DelBok ('ISB',oBookCnv) else ohNXBDEF.Del ('ISB');
  btISBLST.Open;
  If btISBLST.RecordCount>0 then begin
    If (oBookCnv<>'') and not btISBLST.FindKey([oBookCnv]) then Exit;
    Repeat
      mBookNum := btISBLST.FieldByName('BookNum').AsString;
      If StrToInt(Copy(mBookNum,1,2))<StrToInt(gvsys.ActYear2)
        then oBookType:='P' else oBookType:='A';
      oBookNum := oBookType+'-'+Copy(mBookNum,3,3);
      // Ulozime do zoznamu knih
      If not ohNXBDEF.LocatePmBn('ISB',oBookNum)
        then ohNXBDEF.Insert else ohNXBDEF.Edit;
      ohNXBDEF.PmdMark := 'ISB';
      ohNXBDEF.BookNum := oBookNum;
      ohNXBDEF.BookName := btISBLST.FieldByName('BookName').AsString;
      ohNXBDEF.Post;
      // Ulozime vlastnosti skladu
      gKey.IsbBoYear[oBookNum] := btISBLST.FieldByName('BookYear').AsString;
      gKey.IsbCoSymb[oBookNum] := btISBLST.FieldByName('CsyCode').AsString;
      gKey.IsbDvName[oBookNum] := btISBLST.FieldByName('DvzName').AsString;
      gKey.IsbWriNum[oBookNum] := btISBLST.FieldByName('WriNum').AsInteger;
      gKey.IsbStkNum[oBookNum] := btISBLST.FieldByName('StkNum').AsInteger;
      gKey.IsbPlsNum[oBookNum] := btISBLST.FieldByName('PlsNum').AsInteger;
      gKey.IsbAutAcc[oBookNum] := btISBLST.FieldByName('AutoAcc').AsInteger=1;
      gKey.IsbSumAcc[oBookNum] := btISBLST.FieldByName('SumAcc').AsInteger=1;
      gKey.IsbTsdAcc[oBookNum] := btISBLST.FieldByName('AccTsd').AsInteger=1;
      gKey.IsbVatCls[oBookNum] := btISBLST.FieldByName('VatCls').AsInteger=1;
      gKey.IsbDocSnt[oBookNum] := btISBLST.FieldByName('DocSnt').AsString;
      gKey.IsbDocAnl[oBookNum] := btISBLST.FieldByName('DocAnl').AsString;
      gKey.IsbVatSnt[oBookNum] := btISBLST.FieldByName('VatSnt').AsString;
      gKey.IsbVatAnl[oBookNum] := btISBLST.FieldByName('VatAnl').AsString;
      gKey.IsbNvaSnt[oBookNum] := btISBLST.FieldByName('NVatSnt').AsString;
      gKey.IsbNvaAnl[oBookNum] := btISBLST.FieldByName('NVatAnl').AsString;
      gKey.IsbGscSnt[oBookNum] := btISBLST.FieldByName('GscSnt').AsString;
      gKey.IsbGscAnl[oBookNum] := btISBLST.FieldByName('GscAnl').AsString;
      gKey.IsbSecSnt[oBookNum] := btISBLST.FieldByName('SecSnt').AsString;
      gKey.IsbSecAnl[oBookNum] := btISBLST.FieldByName('SecAnl').AsString;
      gKey.IsbPabNum[oBookNum] := btISBLST.FieldByName('PabBook').AsInteger;
      gKey.IsbTsbNum[oBookNum] := btISBLST.FieldByName('TsdBook').AsString;
      gKey.IsbCsbNum[oBookNum] := btISBLST.FieldByName('CsdBook').AsString;
      gKey.IsbDocSpc[oBookNum] := btISBLST.FieldByName('DocSpc').AsInteger;
      Application.ProcessMessages;
      btISBLST.Next;
    until btISBLST.Eof or (oBookCnv<>'');
  end;
  btISBLST.Close;
  Hide;
end;

procedure TKeyCnvF.IcbLstCnv;
var mBookNum:Str5;
begin
  Show;
  If oBookCnv<>'' then ohNXBDEF.DelBok ('ICB',oBookCnv) else ohNXBDEF.Del ('ICB');
  btICBLST.Open;
  If btICBLST.RecordCount>0 then begin
    If (oBookCnv<>'') and not btICBLST.FindKey([oBookCnv]) then Exit;
    Repeat
      mBookNum := btICBLST.FieldByName('BookNum').AsString;
      If StrToInt(Copy(mBookNum,1,2))<StrToInt(gvsys.ActYear2)
        then oBookType:='P' else oBookType:='A';
      oBookNum := oBookType+'-'+Copy(mBookNum,3,3);
      // Ulozime do zoznamu knih
      If not ohNXBDEF.LocatePmBn('ICB',oBookNum)
        then ohNXBDEF.Insert else ohNXBDEF.Edit;
      ohNXBDEF.PmdMark := 'ICB';
      ohNXBDEF.BookNum := oBookNum;
      ohNXBDEF.BookName := btICBLST.FieldByName('BookName').AsString;
      ohNXBDEF.Post;
      // Ulozime vlastnosti skladu
      gKey.IcbBoYear[oBookNum] := btICBLST.FieldByName('BookYear').AsString;
      gKey.IcbCoSymb[oBookNum] := btICBLST.FieldByName('CsyCode').AsString;
      gKey.IcbDvName[oBookNum] := btICBLST.FieldByName('DvzName').AsString;
      gKey.IcbExnFrm[oBookNum] := btICBLST.FieldByName('ExnFrm').AsString;
      gKey.IcbWriNum[oBookNum] := btICBLST.FieldByName('WriNum').AsInteger;
      gKey.IcbStkNum[oBookNum] := btICBLST.FieldByName('StkNum').AsInteger;
      gKey.IcbPlsNum[oBookNum] := btICBLST.FieldByName('PlsNum').AsInteger;
      gKey.IcbAvtRnd[oBookNum] := btICBLST.FieldByName('AcVatRnd').AsInteger;
      gKey.IcbAvlRnd[oBookNum] := btICBLST.FieldByName('AcValRnd').AsInteger;
      gKey.IcbFvtRnd[oBookNum] := btICBLST.FieldByName('FgVatRnd').AsInteger;
      gKey.IcbFvlRnd[oBookNum] := btICBLST.FieldByName('FgValRnd').AsInteger;
      gKey.IcbAutAcc[oBookNum] := btICBLST.FieldByName('AutoAcc').AsInteger=1;
      gKey.IcbSumAcc[oBookNum] := btICBLST.FieldByName('SumAcc').AsInteger=1;
      gKey.IcbTcdAcc[oBookNum] := btICBLST.FieldByName('AccTcd').AsInteger=1;
      gKey.IcbVatCls[oBookNum] := btICBLST.FieldByName('VatCls').AsInteger=1;
      gKey.IcbOcnVer[oBookNum] := btICBLST.FieldByName('OcnVer').AsInteger=1;
      gKey.IcbPrnCls[oBookNum] := btICBLST.FieldByName('PrnCls').AsInteger=1;
      gKey.IcbDocSnt[oBookNum] := btICBLST.FieldByName('DocSnt').AsString;
      gKey.IcbDocAnl[oBookNum] := btICBLST.FieldByName('DocAnl').AsString;
      gKey.IcbVatSnt[oBookNum] := btICBLST.FieldByName('VatSnt').AsString;
      gKey.IcbVatAnl[oBookNum] := btICBLST.FieldByName('VatAnl').AsString;
      gKey.IcbGscSnt[oBookNum] := btICBLST.FieldByName('GscSnt').AsString;
      gKey.IcbGscAnl[oBookNum] := btICBLST.FieldByName('GscAnl').AsString;
      gKey.IcbSecSnt[oBookNum] := btICBLST.FieldByName('SecSnt').AsString;
      gKey.IcbSecAnl[oBookNum] := btICBLST.FieldByName('SecAnl').AsString;
      gKey.IcbPcrSnt[oBookNum] := btICBLST.FieldByName('PCrdSnt').AsString;
      gKey.IcbPcrAnl[oBookNum] := btICBLST.FieldByName('PCrdAnl').AsString;
      gKey.IcbNcrSnt[oBookNum] := btICBLST.FieldByName('NCrdSnt').AsString;
      gKey.IcbNcrAnl[oBookNum] := btICBLST.FieldByName('NCrdAnl').AsString;
      gKey.IcbPdfSnt[oBookNum] := btICBLST.FieldByName('PPdfSnt').AsString;
      gKey.IcbPdfAnl[oBookNum] := btICBLST.FieldByName('PPdfAnl').AsString;
      gKey.IcbNdfSnt[oBookNum] := btICBLST.FieldByName('NPdfSnt').AsString;
      gKey.IcbNdfAnl[oBookNum] := btICBLST.FieldByName('NPdfAnl').AsString;
      gKey.IcbPabNum[oBookNum] := btICBLST.FieldByName('PabBook').AsInteger;
      gKey.IcbTcbNum[oBookNum] := btICBLST.FieldByName('TcdBook').AsString;
      gKey.IcbCsbNum[oBookNum] := btICBLST.FieldByName('CsdBook').AsString;
      gKey.IcbNibNum[oBookNum] := btICBLST.FieldByName('NicBook').AsString;
      gKey.IcbDocSpc[oBookNum] := btICBLST.FieldByName('DocSpc').AsInteger;
      gKey.IcbExCalc[oBookNum] := btICBLST.FieldByName('ExCalc').AsInteger;
      gKey.IcbBaCont[oBookNum] := btICBLST.FieldByName('MyConto').AsString;
      gKey.IcbBaName[oBookNum] := btICBLST.FieldByName('BankName').AsString;
      gKey.IcbBaIban[oBookNum] := btICBLST.FieldByName('IbanCode').AsString;
      gKey.IcbBaSwft[oBookNum] := btICBLST.FieldByName('SwftCode').AsString;
      gKey.IcbBaAddr[oBookNum] := btICBLST.FieldByName('BankAddr').AsString;
      gKey.IcbBaCity[oBookNum] := btICBLST.FieldByName('BankCity').AsString;
      gKey.IcbBaStat[oBookNum] := btICBLST.FieldByName('BankStat').AsString;
      Application.ProcessMessages;
      btICBLST.Next;
    until btICBLST.Eof or (oBookCnv<>'');
  end;
  btICBLST.Close;
  Hide;
end;

procedure TKeyCnvF.TobLstCnv;
var mBookNum:Str5;
begin
//  ohNXBDEF.Del ('TOM');
//  ohNXBDEF.PmdMark := 'TOM';
// TOBLST.BDF
  Show;
  If oBookCnv<>'' then ohNXBDEF.DelBok ('TOB',oBookCnv) else ohNXBDEF.Del ('TOB');
  btTOBLST.Open;
  If btTOBLST.RecordCount>0 then begin
    If (oBookCnv<>'') and not btTOBLST.FindKey([oBookCnv]) then Exit;
    Repeat
      mBookNum := btTOBLST.FieldByName('BookNum').AsString;
      If StrToInt(Copy(btTOBLST.FieldByName('BookNum').AsString,1,2))<StrToInt(gvsys.ActYear2)
        then oBookType:='P' else oBookType:='A';
      oBookNum := oBookType+'-'+Copy(btTOBLST.FieldByName('BookNum').AsString,3,3);
      If not ohNXBDEF.LocatePmBn('TOB',oBookNum)
        then ohNXBDEF.Insert else ohNXBDEF.Edit;
      ohNXBDEF.PmdMark := 'TOB';
      ohNXBDEF.BookNum := oBookNum;
      ohNXBDEF.BookName := btTOBLST.FieldByName('BookName').AsString;
      ohNXBDEF.Post;
      // toblst.bdf
      {
WriNum     word         ;Cislo prevadzkovej jednotky
TcBookNum  Str5         ;Cislo knihy ODL
IcBookNum  Str5         ;Cislo knihy OFA
OcBookNum  Str5         ;Cislo knihy ZKV
OMBookNum  Str5         ;Cislo knihy ISV
OcuBook    Str60        ;Knihy zakaziek, v ktorych sa zrusi rezervacia pri vyuctovani
TcsBookNum  Str5        ;Cislo knihy spec.ODL 
      }
      gKey.TobSndFms[oBookNum] := TRUE;
      gKey.TobSadGen[oBookNum] := 1;
      gKey.TobWriNum[oBookNum] := btTOBLST.FieldByName('WriNum').AsInteger;
      gKey.TobTcbNum[oBookNum] := btTOBLST.FieldByName('TcBookNum').AsString;
      gKey.TobIcbNum[oBookNum] := btTOBLST.FieldByName('IcBookNum').AsString;
      gKey.TobOcbNum[oBookNum] := btTOBLST.FieldByName('OcBookNum').AsString;
      gKey.TobOmbNum[oBookNum] := btTOBLST.FieldByName('OMBookNum').AsString;
      gKey.TobOcuBok[oBookNum] := btTOBLST.FieldByName('OcuBook').AsString;
      gKey.TobTcsNum[oBookNum] := btTOBLST.FieldByName('TcsBookNum').AsString;
      Application.ProcessMessages;
      btTOBLST.Next;
    until btTOBLST.Eof or (oBookCnv<>'');
  end;
  btTOBLST.Close;
  Hide;
end;

procedure TKeyCnvF.SobLstCnv;
var mBookNum:Str5;
begin
  Show;
  If oBookCnv<>'' then ohNXBDEF.DelBok ('SOB',oBookCnv) else ohNXBDEF.Del ('SOB');
  btSobLST.Open;
  If btSobLST.RecordCount>0 then begin
    If (oBookCnv<>'') and not btSOBLST.FindKey([oBookCnv]) then Exit;
    Repeat
      mBookNum := btSobLST.FieldByName('BookNum').AsString;
      If StrToInt(Copy(mBookNum,1,2))<StrToInt(gvsys.ActYear2)
        then oBookType:='P' else oBookType:='A';
      oBookNum := oBookType+'-'+Copy(mBookNum,3,3);
      // Ulozime do zoznamu knih
      If not ohNXBDEF.LocatePmBn('SOB',oBookNum)
        then ohNXBDEF.Insert else ohNXBDEF.Edit;
      ohNXBDEF.PmdMark := 'SOB';
      ohNXBDEF.BookNum := oBookNum;
      ohNXBDEF.BookName := btSobLST.FieldByName('BookName').AsString;
      ohNXBDEF.Post;
      // Ulozime vlastnosti SOBLST.BDF
//      gKey.SobWriNum[oBookNum] := btSobLST.FieldByName('WriNum').AsInteger;
//      gKey.SobPabNum[oBookNum] := btSobLST.FieldByName('PabBook').AsInteger;
      gKey.SobPyvBeg[oBookNum] := btSobLST.FieldByName('PyBegVal').AsFloat;
      gKey.SobPyvCre[oBookNum] := btSobLST.FieldByName('PyCredVal').AsFloat;
      gKey.SobPyvDeb[oBookNum] := btSobLST.FieldByName('PyDebVal').AsFloat;
      gKey.SobPyvEnd[oBookNum] := btSobLST.FieldByName('PyEndVal').AsFloat;
      gKey.SobPyvMax[oBookNum] := btSobLST.FieldByName('PyMaxPdf').AsFloat;
      gKey.SobAcvBeg[oBookNum] := btSobLST.FieldByName('AcBegVal').AsFloat;
      gKey.SobAcvCre[oBookNum] := btSobLST.FieldByName('AcCredVal').AsFloat;
      gKey.SobAcvDeb[oBookNum] := btSobLST.FieldByName('AcDebVal').AsFloat;
      gKey.SobAcvEnd[oBookNum] := btSobLST.FieldByName('AcEndVal').AsFloat;
      gKey.SobDocSnt[oBookNum] := btSobLST.FieldByName('AccSnt').AsString;
      gKey.SobDocAnl[oBookNum] := btSobLST.FieldByName('AccAnl').AsString;
      gKey.SobAutAcc[oBookNum] := btSobLST.FieldByName('AutoAcc').AsInteger=1;
      gKey.SobEycCrd[oBookNum] := btSobLST.FieldByName('EyCourse').AsFloat;
      gKey.SobEyvCrd[oBookNum] := btSobLST.FieldByName('EyCrdVal').AsFloat;
      gKey.SobPydCrs[oBookNum] := btSobLST.FieldByName('PyCourse').AsFloat;
      gKey.SobPydNam[oBookNum] := btSobLST.FieldByName('PyDvzName').AsString;
      gKey.SobBaCont[oBookNum] := btSobLST.FieldByName('ContoNum').AsString;
      gKey.SobBaName[oBookNum] := btSobLST.FieldByName('BankName').AsString;
      gKey.SobBaIban[oBookNum] := btSobLST.FieldByName('IbanCode').AsString;
      gKey.SobBaSwft[oBookNum] := btSobLST.FieldByName('SwftCode').AsString;
      gKey.SobAboTyp[oBookNum] := btSobLST.FieldByName('AboType').AsInteger;
      gKey.SobAboPat[oBookNum] := btSobLST.FieldByName('AboPath').AsString;
      gKey.SobDocQnt[oBookNum] := btSobLST.FieldByName('DocQnt').AsInteger;
      Application.ProcessMessages;
      btSOBLST.Next;
    until btSOBLST.Eof or (oBookCnv<>'');
  end;
  btSOBLST.Close;
  Hide;
end;

procedure TKeyCnvF.CsbLstCnv;
var mBookNum:Str5;
begin
  Show;
  If oBookCnv<>'' then ohNXBDEF.DelBok ('CSB',oBookCnv) else ohNXBDEF.Del ('CSB');
  btCSBLST.Open;
  If btCSBLST.RecordCount>0 then begin
    If (oBookCnv<>'') and not btCSBLST.FindKey([oBookCnv]) then Exit;
    Repeat
      mBookNum := btCSBLST.FieldByName('BookNum').AsString;
      If StrToInt(Copy(mBookNum,1,2))<StrToInt(gvsys.ActYear2)
        then oBookType:='P' else oBookType:='A';
      oBookNum := oBookType+'-'+Copy(mBookNum,3,3);
      // Ulozime do zoznamu knih
      If not ohNXBDEF.LocatePmBn('CSB',oBookNum)
        then ohNXBDEF.Insert else ohNXBDEF.Edit;
      ohNXBDEF.PmdMark := 'CSB';
      ohNXBDEF.BookNum := oBookNum;
      ohNXBDEF.BookName := btCSBLST.FieldByName('BookName').AsString;
      ohNXBDEF.Post;               
      // Ulozime vlastnosti skladu
      gKey.CsbBoYear[oBookNum] := btCSBLST.FieldByName('BookYear').AsString;
      gKey.CsbDvName[oBookNum] := btCSBLST.FieldByName('PyDvzName').AsString;
      gKey.CsbWriNum[oBookNum] := btCSBLST.FieldByName('WriNum').AsInteger;
      gKey.CsbPabNum[oBookNum] := btCSBLST.FieldByName('PabBook').AsInteger;
      gKey.CsbPyvBeg[oBookNum] := btCSBLST.FieldByName('PyBegVal').AsFloat;
      gKey.CsbPyvInc[oBookNum] := btCSBLST.FieldByName('PyIncVal').AsFloat;
      gKey.CsbPyvExp[oBookNum] := btCSBLST.FieldByName('PyExpVal').AsFloat;
      gKey.CsbPyvEnd[oBookNum] := btCSBLST.FieldByName('PyEndVal').AsFloat;
      gKey.CsbMaxPdf[oBookNum] := btCSBLST.FieldByName('PyMaxPdf').AsFloat;
      gKey.CsbAcvBeg[oBookNum] := btCSBLST.FieldByName('AcBegVal').AsFloat;
      gKey.CsbAcvInc[oBookNum] := btCSBLST.FieldByName('AcIncVal').AsFloat;
      gKey.CsbAcvExp[oBookNum] := btCSBLST.FieldByName('AcExpVal').AsFloat;
      gKey.CsbEycCrd[oBookNum] := btCSBLST.FieldByName('EyCourse').AsFloat;
      gKey.CsbEyvCrd[oBookNum] := btCSBLST.FieldByName('EyCrdVal').AsFloat;
      gKey.CsbAcvEnd[oBookNum] := btCSBLST.FieldByName('AcEndVal').AsFloat;
      gKey.CsbDocSnt[oBookNum] := btCSBLST.FieldByName('AccSnt').AsString;
      gKey.CsbDocAnl[oBookNum] := btCSBLST.FieldByName('AccAnl').AsString;
      gKey.CsbVaiSnt[oBookNum] := btCSBLST.FieldByName('IVatSnt').AsString;
      gKey.CsbVaiAnl[oBookNum] := btCSBLST.FieldByName('IVatAnl').AsString;
      gKey.CsbVaoSnt[oBookNum] := btCSBLST.FieldByName('OVatSnt').AsString;
      gKey.CsbVaoAnl[oBookNum] := btCSBLST.FieldByName('OVatAnl').AsString;
      gKey.CsbVatRnd[oBookNum] := btCSBLST.FieldByName('VatRnd').AsInteger;
      gKey.CsbValRnd[oBookNum] := btCSBLST.FieldByName('ValRnd').AsInteger;
      gKey.CsbSpcCsi[oBookNum] := 100;
      gKey.CsbSpcCse[oBookNum] := 200;
      gKey.CsbVatCls[oBookNum] := btCSBLST.FieldByName('VatCls').AsInteger=1;
      gKey.CsbAutAcc[oBookNum] := btCSBLST.FieldByName('AutoAcc').AsInteger=1;
      gKey.CsbRndVer[oBookNum] := btCSBLST.FieldByName('RndVer').AsInteger=1;
      gKey.CsbSumAcc[oBookNum] := btCSBLST.FieldByName('SumAcc').AsInteger=1;
      gKey.CsbWriAdd[oBookNum] := btCSBLST.FieldByName('WriAdd').AsInteger=1;
      Application.ProcessMessages;
      btCSBLST.Next;
    until btCSBLST.Eof or (oBookCnv<>'');
  end;
  btCSBLST.Close;
  Hide;
end;

procedure TKeyCnvF.OsbLstCnv;
var mBookNum:Str5;
begin
  Show;
  If oBookCnv<>'' then ohNXBDEF.DelBok ('OSB',oBookCnv) else ohNXBDEF.Del ('OSB');
  btOSBLST.Open;
  If btOSBLST.RecordCount>0 then begin
    If (oBookCnv<>'') and not btOSBLST.FindKey([oBookCnv]) then Exit;
    Repeat
      mBookNum := btOSBLST.FieldByName('BookNum').AsString;
      If StrToInt(Copy(btOSBLST.FieldByName('BookNum').AsString,1,2))<StrToInt(gvsys.ActYear2)
        then oBookType:='P' else oBookType:='A';
      oBookNum := oBookType+'-'+Copy(btOSBLST.FieldByName('BookNum').AsString,3,3);
      If not ohNXBDEF.LocatePmBn('OSB',oBookNum)
        then ohNXBDEF.Insert else ohNXBDEF.Edit;
      ohNXBDEF.PmdMark := 'OSB';
      ohNXBDEF.BookNum := oBookNum;
      ohNXBDEF.BookName := btOSBLST.FieldByName('BookName').AsString;
      ohNXBDEF.Post;
      // Ulozime vlastnosti skladu
      gKey.OSB.ExnFrm[oBookNum] := btOSBLST.FieldByName('ExnFrm').AsString;
      gKey.OSB.BokDvz[oBookNum] := btOSBLST.FieldByName('DvzName').AsString;
      gKey.OSB.VatRnd[oBookNum] := btOSBLST.FieldByName('VatRnd').AsInteger;
      gKey.OSB.ValRnd[oBookNum] := btOSBLST.FieldByName('ValRnd').AsInteger;
      gKey.OSB.PabNum[oBookNum] := btOSBLST.FieldByName('PabBook').AsInteger;
      gKey.OSB.WriNum[oBookNum] := btOSBLST.FieldByName('WriNum').AsInteger;
      gKey.OSB.StkNum[oBookNum] := btOSBLST.FieldByName('StkNum').AsInteger;
      gKey.OSB.TsdBok[oBookNum] := btOSBLST.FieldByName('TsdBook').AsString;
      gKey.OSB.AvgClc[oBookNum] := btOSBLST.FieldByName('AvgCalc').AsInteger;
      gKey.OSB.AvgMth[oBookNum] := btOSBLST.FieldByName('AvgMth').AsInteger;
//      gKey.OSB.ExtPrc[oBookNum] := btOSBLST.FieldByName('ExtPrc').AsFloat;
      gKey.OSB.OrdCoe[oBookNum] := btOSBLST.FieldByName('OrdCoef').AsFloat;
      gKey.OSB.Shared[oBookNum] := btOSBLST.FieldByName('Shared').AsInteger;
      gKey.OSB.SndTyp[oBookNum] := btOSBLST.FieldByName('SndType').AsInteger;
      gKey.OSB.DefPac[oBookNum] := btOSBLST.FieldByName('PaCode').AsInteger;
      Application.ProcessMessages;
      btOSBLST.Next;
    until btOSBLST.Eof or (oBookCnv<>'');
  end;
  btOSBLST.Close;
  Hide;
end;

procedure TKeyCnvF.AlbLstCnv;
begin

end;

procedure TKeyCnvF.CdbLstCnv;
var mBookNum:Str5;
begin
  Show;
  btCDBLST.Open;
  If oBookCnv<>'' then ohNXBDEF.DelBok ('CDB',oBookCnv) else ohNXBDEF.Del ('CDB');
  If btCDBLST.RecordCount>0 then begin
    If (oBookCnv<>'') and not btCDBLST.FindKey([oBookCnv]) then Exit;
    Repeat
      mBookNum := btCDBLST.FieldByName('BookNum').AsString;
      If StrToInt(Copy(btCDBLST.FieldByName('BookNum').AsString,1,2))<StrToInt(gvsys.ActYear2)
        then oBookType:='P' else oBookType:='A';
      oBookNum := oBookType+'-'+Copy(btCDBLST.FieldByName('BookNum').AsString,3,3);
      If not ohNXBDEF.LocatePmBn('CDB',oBookNum)
        then ohNXBDEF.Insert else ohNXBDEF.Edit;
      ohNXBDEF.PmdMark := 'CDB';
      ohNXBDEF.BookNum := oBookNum;
      ohNXBDEF.BookName := btCDBLST.FieldByName('BookName').AsString;
      ohNXBDEF.Post;
      // Ulozime vlastnosti skladu cdblst.bdf
//      gKey.CdbOnlSub[oBookNum] := mhCDBLST.;
      gKey.CdbStkNuI[oBookNum] := btCDBLST.FieldByName('StkNum').AsInteger;
      gKey.CdbStkNuO[oBookNum] := btCDBLST.FieldByName('CpStkNum').AsInteger;
      gKey.CdbPlsNum[oBookNum] := btCDBLST.FieldByName('PlsNum').AsInteger;
      gKey.CdbSmCodI[oBookNum] := btCDBLST.FieldByName('PdSmCode').AsInteger;
      gKey.CdbSmCodO[oBookNum] := btCDBLST.FieldByName('CpSmCode').AsInteger;
      gKey.CdbCpiBok[oBookNum] := btCDBLST.FieldByName('CpiBook').AsInteger;
      Application.ProcessMessages;
      btCDBLST.Next;
    until btCDBLST.Eof or (oBookCnv<>'');
  end;
  btCDBLST.Close;
  Hide;
end;

procedure TKeyCnvF.CmbLstCnv;
var mBookNum:Str5;
begin
  Show;
  btCMBLST.Open;
  If oBookCnv<>'' then ohNXBDEF.DelBok ('CMB',oBookCnv) else ohNXBDEF.Del ('CMB');
  If btCMBLST.RecordCount>0 then begin
    If (oBookCnv<>'') and not btCMBLST.FindKey([oBookCnv]) then Exit;
    Repeat
      mBookNum := btCMBLST.FieldByName('BookNum').AsString;
      If StrToInt(Copy(btCMBLST.FieldByName('BookNum').AsString,1,2))<StrToInt(gvsys.ActYear2)
        then oBookType:='P' else oBookType:='A';
      oBookNum := oBookType+'-'+Copy(btCMBLST.FieldByName('BookNum').AsString,3,3);
      If not ohNXBDEF.LocatePmBn('CMB',oBookNum)
        then ohNXBDEF.Insert else ohNXBDEF.Edit;
      ohNXBDEF.PmdMark := 'CMB';
      ohNXBDEF.BookNum := oBookNum;
      ohNXBDEF.BookName := btCMBLST.FieldByName('BookName').AsString;
      ohNXBDEF.Post;
      // Ulozime vlastnosti skladu CMBlst.bdf
      gKey.CmbOnlSub[oBookNum] := btCMBLST.FieldByName('Online').AsInteger=1;
      gKey.CmbStkNum[oBookNum] := btCMBLST.FieldByName('StkNum').AsInteger;
      gKey.CmbPlsNum[oBookNum] := btCMBLST.FieldByName('PlsNum').AsInteger;
      gKey.CmbSmCode[oBookNum] := btCMBLST.FieldByName('SmCode').AsInteger;
      Application.ProcessMessages;
      btCMBLST.Next;
    until btCMBLST.Eof or (oBookCnv<>'');
  end;
  btCMBLST.Close;
  Hide;
end;

procedure TKeyCnvF.DmbLstCnv;
var mBookNum:Str5;
begin
  Show;
  btDMBLST.Open;
  If oBookCnv<>'' then ohNXBDEF.DelBok ('DMB',oBookCnv) else ohNXBDEF.Del ('DMB');
  If btDMBLST.RecordCount>0 then begin
    If (oBookCnv<>'') and not btDMBLST.FindKey([oBookCnv]) then Exit;
    Repeat
      mBookNum := btDMBLST.FieldByName('BookNum').AsString;
      If StrToInt(Copy(btDMBLST.FieldByName('BookNum').AsString,1,2))<StrToInt(gvsys.ActYear2)
        then oBookType:='P' else oBookType:='A';
      oBookNum := oBookType+'-'+Copy(btDMBLST.FieldByName('BookNum').AsString,3,3);
      If not ohNXBDEF.LocatePmBn('DMB',oBookNum)
        then ohNXBDEF.Insert else ohNXBDEF.Edit;
      ohNXBDEF.PmdMark := 'DMB';
      ohNXBDEF.BookNum := oBookNum;
      ohNXBDEF.BookName := btDMBLST.FieldByName('BookName').AsString;
      ohNXBDEF.Post;
      // Ulozime vlastnosti skladu DMBlst.bdf
      {
PlsNum      word         ;Cislo prioritneho predajneho cennika
OuStkNum    word         ;Cislo skladu vydaja
InStkNum    word         ;Cislo skladu vydaja
OuSmCode    word         ;Zakladne nastavenie skladoveho pohybu vydaja
InSmCode    word         ;Zakladne nastavenie skladoveho pohybu prijmu
}
//      gKey.DMBOnlSub[oBookNum] := btDMBLST.FieldByName('Online').AsInteger=1;
      gKey.DmbStkNuI[oBookNum] := btDMBLST.FieldByName('InStkNum').AsInteger;
      gKey.DMBStkNuO[oBookNum] := btDMBLST.FieldByName('OuttkNum').AsInteger;
      gKey.DMBPlsNum[oBookNum] := btDMBLST.FieldByName('PlsNum').AsInteger;
      gKey.DmbSmCodI[oBookNum] := btDMBLST.FieldByName('InSmCode').AsInteger;
      gKey.DmbSmCodO[oBookNum] := btDMBLST.FieldByName('OuSmCode').AsInteger;
      Application.ProcessMessages;
      btDMBLST.Next;
    until btDMBLST.Eof or (oBookCnv<>'');
  end;
  btDMBLST.Close;
  Hide;
end;

procedure TKeyCnvF.IdbLstCnv;
var mBookNum:Str5;
begin
  Show;
  btIDBLST.Open;
  If oBookCnv<>'' then ohNXBDEF.DelBok ('IDB',oBookCnv) else ohNXBDEF.Del ('IDB');
  If btIDBLST.RecordCount>0 then begin
    If (oBookCnv<>'') and not btIDBLST.FindKey([oBookCnv]) then Exit;
    Repeat
      mBookNum := btIDBLST.FieldByName('BookNum').AsString;
      If StrToInt(Copy(btIDBLST.FieldByName('BookNum').AsString,1,2))<StrToInt(gvsys.ActYear2)
        then oBookType:='P' else oBookType:='A';
      oBookNum := oBookType+'-'+Copy(btIDBLST.FieldByName('BookNum').AsString,3,3);
      If not ohNXBDEF.LocatePmBn('IDB',oBookNum)
        then ohNXBDEF.Insert else ohNXBDEF.Edit;
      ohNXBDEF.PmdMark := 'IDB';
      ohNXBDEF.BookNum := oBookNum;
      ohNXBDEF.BookName := btIDBLST.FieldByName('BookName').AsString;
      ohNXBDEF.Post;
      // Ulozime vlastnosti skladu IDBlst.bdf
{
WriNum      word         ;Cislo prevadzkvoej jednotky
WriAdd      byte         ;Povinne zadavanie prevadzkovej jednotky (1-zapnuty)
}
      gKey.IdbWriNum[oBookNum] := btIDBLST.FieldByName('WriNum').AsInteger;
      gKey.IdbWriAdd[oBookNum] := btIDBLST.FieldByName('WriAdd').AsInteger=1;
      Application.ProcessMessages;
      btIDBLST.Next;
    until btIDBLST.Eof or (oBookCnv<>'');
  end;
  btIDBLST.Close;
  Hide;
end;

procedure TKeyCnvF.TibLstCnv;
var mBookNum:Str5;
begin
  Show;
  btTIBLST.Open;
  If oBookCnv<>'' then ohNXBDEF.DelBok ('TIB',oBookCnv) else ohNXBDEF.Del ('TIB');
  If btTIBLST.RecordCount>0 then begin
    If (oBookCnv<>'') and not btTIBLST.FindKey([oBookCnv]) then Exit;
    Repeat
      mBookNum := btTIBLST.FieldByName('BookNum').AsString;
      If StrToInt(Copy(btTIBLST.FieldByName('BookNum').AsString,1,2))<StrToInt(gvsys.ActYear2)
        then oBookType:='P' else oBookType:='A';
      oBookNum := oBookType+'-'+Copy(btTIBLST.FieldByName('BookNum').AsString,3,3);
      If not ohNXBDEF.LocatePmBn('TIB',oBookNum)
        then ohNXBDEF.Insert else ohNXBDEF.Edit;
      ohNXBDEF.PmdMark := 'TIB';
      ohNXBDEF.BookNum := oBookNum;
      ohNXBDEF.BookName := btTIBLST.FieldByName('BookName').AsString;
      ohNXBDEF.Post;
      // Ulozime vlastnosti skladu TIBlst.bdf
{
WriNum     word         ;Cislo prevadzkovej jednotky
TsbNum     Str5         ;Cislo knihy dodavatelskych dodacich listov
ImbNum     Str5         ;Cislo knihy internych skladovych prijemok
OsbNums    Str60        ;Knihy objedn vok na parovanie
}
      gKey.TibTsbNum[oBookNum] := btTIBLST.FieldByName('TsbNum').AsString;
      gKey.TibImbNum[oBookNum] := btTIBLST.FieldByName('ImbNum').AsString;
      gKey.TibOsbLst[oBookNum] := btTIBLST.FieldByName('OsbNums').AsString;
//      gKey.TibOcbLst[oBookNum] := btTIBLST.FieldByName('').AsString;
//      gKey.TibWrmAut[oBookNum] := btTIBLST.FieldByName('').AsString;
//      gKey.TibOsiPce[oBookNum] := btTIBLST.FieldByName('').AsInteger=1;
      Application.ProcessMessages;
      btTIBLST.Next;
    until btTIBLST.Eof or (oBookCnv<>'');
  end;
  btTIBLST.Close;
  Hide;
end;

procedure TKeyCnvF.PKBLstCnv;
var mBookNum:Str5;
begin
  Show;
  btPKBLST.Open;
  If oBookCnv<>'' then ohNXBDEF.DelBok ('PKB',oBookCnv) else ohNXBDEF.Del ('PKB');
  If btPKBLST.RecordCount>0 then begin
    If (oBookCnv<>'') and not btPKBLST.FindKey([oBookCnv]) then Exit;
    Repeat
      mBookNum := btPKBLST.FieldByName('BookNum').AsString;
      If StrToInt(Copy(btPKBLST.FieldByName('BookNum').AsString,1,2))<StrToInt(gvsys.ActYear2)
        then oBookType:='P' else oBookType:='A';
      oBookNum := oBookType+'-'+Copy(btPKBLST.FieldByName('BookNum').AsString,3,3);
      If not ohNXBDEF.LocatePmBn('PKB',oBookNum)
        then ohNXBDEF.Insert else ohNXBDEF.Edit;
      ohNXBDEF.PmdMark := 'PKB';
      ohNXBDEF.BookNum := oBookNum;
      ohNXBDEF.BookName := btPKBLST.FieldByName('BookName').AsString;
      ohNXBDEF.Post;
      // Ulozime vlastnosti PKBlst.bdf
      gKey.PkbStkNum[oBookNum] := btPKBLST.FieldByName('StkNum').AsInteger;
      gKey.PkbSrcSmc[oBookNum] := btPKBLST.FieldByName('ScSmCode').AsInteger;
      gKey.PkbPlsNum[oBookNum] := btPKBLST.FieldByName('PlsNum').AsInteger;
      gKey.PkbTrgSmc[oBookNum] := btPKBLST.FieldByName('TgSmCode').AsInteger;
      Application.ProcessMessages;
      btPKBLST.Next;
    until btPKBLST.Eof or (oBookCnv<>'');
  end;
  btPKBLST.Close;
  Hide;
end;

procedure TKeyCnvF.MCBLstCnv;
var mBookNum:Str5;
begin
  Show;
  btMCBLST.Open;
  If oBookCnv<>'' then ohNXBDEF.DelBok ('MCB',oBookCnv) else ohNXBDEF.Del ('MCB');
  If btMCBLST.RecordCount>0 then begin
    If (oBookCnv<>'') and not btMCBLST.FindKey([oBookCnv]) then Exit;
    Repeat
      mBookNum := btMCBLST.FieldByName('BookNum').AsString;
      If StrToInt(Copy(btMCBLST.FieldByName('BookNum').AsString,1,2))<StrToInt(gvsys.ActYear2)
        then oBookType:='P' else oBookType:='A';
      oBookNum := oBookType+'-'+Copy(btMCBLST.FieldByName('BookNum').AsString,3,3);
      If not ohNXBDEF.LocatePmBn('MCB',oBookNum)
        then ohNXBDEF.Insert else ohNXBDEF.Edit;
      ohNXBDEF.PmdMark := 'MCB';
      ohNXBDEF.BookNum := oBookNum;
      ohNXBDEF.BookName := btMCBLST.FieldByName('BookName').AsString;
      ohNXBDEF.Post;
      // Ulozime vlastnosti MCBlst.bdf
{
DvzBook    byte         ;Typ knihy (0-tuzemska, 1-valutova)
DocQnt     word         ;Poèet dokladov v danej knihe
SerMod     byte         ;Povolenie zmeny poradoveho cisla dokladu (1-zapnuty)
PabBook    word         ;Èíslo knihy obchodných partnerov - odberatelia
Shared     byte         ;Priznak zdielania sklad - zmeny su odoslane cez FTP (1-zdileany)
PlsNum     word         ;Cislo predvoleneho predajneho cennika pre danu knihu
SalCode    word         ;Kod obchodoeho zastupcu
MyConto    Str30        ;Bankovy ucet dodavatela
IbanCode   Str10        ;IBAN kod
SwftCode   Str30        ;S.W.I.F.T kod
BankAddr   Str30        ;Adresa banky
BankCity   Str30        ;Sidlo banky
BankStat   Str30        ;Stat banky
BankName   Str30        ;Nazov banky
DocForm    byte         ;Cislo frmulara editora hlavicky dokladu
}
      gKey.McbFgvDvz[oBookNum]  := btMCBLST.FieldByName('DvzName').AsString;
      gKey.McbWriNum [oBookNum] := btMCBLST.FieldByName('WriNum').AsInteger;
      gKey.MCBStkNum [oBookNum] := btMCBLST.FieldByName('StkNum').AsInteger;
//      gKey.McbVatRnd[oBookNum] := btMCBLST.FieldByName('FgVatRnd').AsInteger;
//      gKey.McbRndBva[oBookNum] := btMCBLST.FieldByName('FgValRnd').AsInteger;
      gKey.McbExnFmt [oBookNum] := btMCBLST.FieldByName('ExnFrm').AsString;
//      gKey.MCBSerMod [oBookNum] := btMCBLST.FieldByName('SerMod
      gKey.McbPabNum[oBookNum] := btMCBLST.FieldByName('PabBook').AsInteger;
      gKey.McbOcbNum[oBookNum] := btMCBLST.FieldByName('OcdBook').AsString;
//      gKey.MCBShared [oBookNum] := btMCBLST.FieldByName('Shared
//      gKey.MCBPlsNum [oBookNum] := btMCBLST.FieldByName('PlsNum
//      gKey.MCBSalCode[oBookNum] := btMCBLST.FieldByName('SalCode
//      gKey.MCBMyConto[oBookNum] := btMCBLST.FieldByName('MyConto
      gKey.McbTcbNum[oBookNum] := btMCBLST.FieldByName('TcdBook').AsString;
      gKey.McbIcbNum[oBookNum] := btMCBLST.FieldByName('IcdBook').AsString;
      gKey.McbPrnCls [oBookNum] := btMCBLST.FieldByName('PrnCls').AsInteger=1;
      gKey.McbVatRnd[oBookNum] := btMCBLST.FieldByName('AcVatRnd').AsInteger;
      gKey.McbDocRnd[oBookNum] := btMCBLST.FieldByName('AcValRnd').AsInteger;
//      gKey.MCBIbanCod[oBookNum] := btMCBLST.FieldByName('IbanCode
//      gKey.MCBSwftCod[oBookNum] := btMCBLST.FieldByName('SwftCode
//      gKey.MCBBankAdd[oBookNum] := btMCBLST.FieldByName('BankAddr
//      gKey.MCBBankCit[oBookNum] := btMCBLST.FieldByName('BankCity
//      gKey.MCBBankSta[oBookNum] := btMCBLST.FieldByName('BankStat
//      gKey.MCBBankNam[oBookNum] := btMCBLST.FieldByName('BankName
      gKey.McbItmFrm[oBookNum] := btMCBLST.FieldByName('ItmForm').AsInteger;
//      gKey.MCBDocForm[oBookNum] := btMCBLST.FieldByName('DocForm
      gKey.McbDsHide [oBookNum] := btMCBLST.FieldByName('DsHide').AsInteger=1;
      Application.ProcessMessages;
      btMCBLST.Next;
    until btMCBLST.Eof or (oBookCnv<>'');
  end;
  btMCBLST.Close;
  Hide;
end;

procedure TKeyCnvF.SVBLstCnv;
var mBookNum:Str5;
begin
  Show;
  btSVBLST.Open;
  If oBookCnv<>'' then ohNXBDEF.DelBok ('SVB',oBookCnv) else ohNXBDEF.Del ('SVB');
  If btSVBLST.RecordCount>0 then begin
    If (oBookCnv<>'') and not btSVBLST.FindKey([oBookCnv]) then Exit;
    Repeat
      mBookNum := btSVBLST.FieldByName('BookNum').AsString;
      If StrToInt(Copy(btSVBLST.FieldByName('BookNum').AsString,1,2))<StrToInt(gvsys.ActYear2)
        then oBookType:='P' else oBookType:='A';
      oBookNum := oBookType+'-'+Copy(btSVBLST.FieldByName('BookNum').AsString,3,3);
      If not ohNXBDEF.LocatePmBn('SVB',oBookNum)
        then ohNXBDEF.Insert else ohNXBDEF.Edit;
      ohNXBDEF.PmdMark := 'SVB';
      ohNXBDEF.BookNum := oBookNum;
      ohNXBDEF.BookName := btSVBLST.FieldByName('BookName').AsString;
      ohNXBDEF.Post;
      // Ulozime vlastnosti skladu SVBlst.bdf
      gKey.SvbWriNum[oBookNum] := btSVBLST.FieldByName('WriNum').AsInteger;
      gKey.SvbDocSnt[oBookNum] := btSVBLST.FieldByName('DocSnt').AsString;
      gKey.SvbDocAnl[oBookNum] := btSVBLST.FieldByName('DocAnl').AsString;
      gKey.SvbVatSnt[oBookNum] := btSVBLST.FieldByName('VatSnt').AsString;
      gKey.SvbVatAnl[oBookNum] := btSVBLST.FieldByName('VatAnl').AsString;
      gKey.SvbExnFrm[oBookNum] := btSVBLST.FieldByName('ExnFrm').AsString;
      gKey.SvbAutAcc[oBookNum] := btSVBLST.FieldByName('AutoAcc').AsInteger=1;
      gKey.SvbWriSha[oBookNum] := btSVBLST.FieldByName('Shared').AsInteger=1;
      Application.ProcessMessages;
      btSVBLST.Next;
    until btSVBLST.Eof or (oBookCnv<>'');
  end;
  btSVBLST.Close;
  Hide;
end;

procedure TKeyCnvF.AcbLstCnv;
var mBookNum:Str5;
begin
  Show;
  btAcbLST.Open;
  If oBookCnv<>'' then ohNXBDEF.DelBok ('ACB',oBookCnv) else ohNXBDEF.Del ('ACB');
  If btACBLST.RecordCount>0 then begin
    If (oBookCnv<>'') and not btAcbLST.FindKey([oBookCnv]) then Exit;
    Repeat
      mBookNum := btAcbLST.FieldByName('BookNum').AsString;
      If StrToInt(Copy(btAcbLST.FieldByName('BookNum').AsString,1,2))<StrToInt(gvsys.ActYear2)
        then oBookType:='P' else oBookType:='A';
      oBookNum := oBookType+'-'+Copy(btAcbLST.FieldByName('BookNum').AsString,3,3);
      If not ohNXBDEF.LocatePmBn('ACB',oBookNum)
        then ohNXBDEF.Insert else ohNXBDEF.Edit;
      ohNXBDEF.PmdMark := 'ACB';
      ohNXBDEF.BookNum := oBookNum;
      ohNXBDEF.BookName := btAcbLST.FieldByName('BookName').AsString;
      ohNXBDEF.Post;
      // Ulozime vlastnosti skladu Acblst.bdf
{
PlsNum     longint      ;Poradove cislo predajneho cennika
RndType    byte         ;Sposob zaokruhlenia predajnej ceny
Weight     byte         ;
LabPrn     byte         ;Prepinac na automaticku tlac cenovkovej etikety
}
      gKey.AcbPlsNum[oBookNum] := btAcbLST.FieldByName('PlsNum').AsInteger;
      gKey.AcbRndTyp[oBookNum] := btAcbLST.FieldByName('RndType').AsInteger;
      Application.ProcessMessages;
      btAcbLST.Next;
    until btAcbLST.Eof or (oBookCnv<>'');
  end;
  btAcbLST.Close;
  Hide;
end;

end.
