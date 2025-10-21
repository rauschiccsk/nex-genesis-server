unit SepaXmlMan;

interface

uses
  IcConv, IcTools, XSBuiltIns,
  SepaXml, XmlDoc, SysUtils, Classes;

type
  TSepaXmlMan=class
    constructor Create(pXMLFile:string);
    destructor Destroy; override;
  private
    oXML:IXMLDocumentType;
    oXmlDoc:TXMLDocument;
    oOpened:boolean;
    oErr:longint;
    oItmIndex:longint;

    function XMLTimeToDateTime(pXMLTime:string):TDateTime;
    function DateTimeToXLMTime(pDate:TDateTime):string;

    function GetBankStatement:string;
    procedure AddEntry(pSLst:TStringList;pLn:longint);

    function GetLegalSequenceNumber:longint;
    function GetCrtDate:TDateTime;
    function GetFromDate:TDateTime;
    function GetToDate:TDateTime;
    function GetAccName:string;
    function GetAccIBAN:string;
    function GetAccBIC:string;
    function GetAccCurrency:string;
    function GetPrevClsBooked:double;
    function GetClsBooked:double;
    function GetTotalCredit:double;
    function GetTotalDebit:double;
    function GetItmQnt:longint;
    function GetCreditItmQnt:longint;
    function GetDebitItmQnt:longint;

    function GetItmCount:longint;
    procedure SetItmIndex(pIndex:longint);

    function GetItmDte:TDateTime;
    function GetItmVal:double;

    function GetItmId:string;
    function GetItmIdVS:string;
    function GetItmIdSS:string;
    function GetItmIdKS:string;

    function GetItmTypeCredit:boolean;
    function GetItmContraAccIBAN:string;
    function GetItmContraAccBIC:string;
    function GetItmContraAccName:string;

    function GetItmNote:string;

    function GetBalanceIndex(pId:string):longint;
  published
    property Opened:boolean read oOpened;
    property Err:longint read oErr;

    property BankStatement:string read GetBankStatement; //Preh¾ad bankového výpisu
    property LegalSequenceNumber:longint read GetLegalSequenceNumber; //Èíslo výpisu
    property AccName:string read GetAccName; //Názov úètu
    property AccIBAN:string read GetAccIBAN; //Èíslo úètu
    property AccBIC:string read GetAccBIC; //BIC
    property AccCurrency:string read GetAccCurrency; //Mena
    property CrtDate:TDateTime read GetCrtDate; //Dátum vytvorenia
    property FromDate:TDateTime read GetFromDate; //Poèiatoèný dátum
    property ToDate:TDateTime read GetToDate; //Koneèný dátum

    property PrevClsBooked:double read GetPrevClsBooked; //Koneèný zostatok poslednej uzatvorenej
    property ClsBooked:double read GetClsBooked; //Koneèný zostatok
    property TotalCredit:double read GetTotalCredit; //Súèet kreditných položiek
    property TotalDebit:double read GetTotalDebit; //Súèet debetných položiek
    property ItmQnt:longint read GetItmQnt; //Poèet položiek
    property CreditItmQnt:longint read GetCreditItmQnt; //Poèet kreditných položiek
    property DebitItmQnt:longint read GetDebitItmQnt; //Poèet debetných položiek

    property ItmCount:longint read GetItmCount; //Poèet položiek - Count
    property ItmIndex:longint read oItmIndex write SetItmIndex; //Index aktuálnej položky

    property ItmDte:TDateTime read GetItmDte; //Dátum zaúètovania
    property ItmVal:double read GetItmVal; //Hodnota
    property ItmIdVS:string read GetItmIdVS; //Variabilný symbol
    property ItmIdSS:string read GetItmIdSS; //Špecifický symbol
    property ItmIdKS:string read GetItmIdKS; //Konštantný symbol
    property ItmContraAccIBAN:string read GetItmContraAccIBAN; //Protiúèet - IBAN
    property ItmContraAccBIC:string read GetItmContraAccBIC; //Protiúèet - BIC
    property ItmContraAccName:string read GetItmContraAccName; //Protiúèet - Názov
    property ItmNote:string read GetItmNote; //Poznámka
  end;

implementation

(*
Vzor
var mR:TSEPAXMLMan; I,mItmCnt:longint;
begin
  mR:=TSEPAXMLMan.Create('názov súboru');

  mR.BankStatement; // Preh¾ad bankového výpisu
  mR.LegalSequenceNumber; // Èíslo výpisu
  mR.AccName;  // Názov úètu
  mR.AccIBAN;  // Èíslo úètu
  mR.AccBIC;   // BIC
  mR.AccCurrency; // Mena
  mR.CrtDate;  // Dátum vytvorenia
  mR.FromDate; // Poèiatoèný dátum
  mR.ToDate;   // Koneèný dátum
  mR.PrevClsBooked; // Koneèný zostatok poslednej uzatvorenej
  mR.ClsBooked; // Koneèný zostatok
  mR.TotalCredit; // Súèet kreditných položiek
  mR.TotalDebit;  // Súèet debetných položiek
  mR.ItmQnt; // Poèet položiek
  mR.CreditItmQnt; // Poèet kreditných položiek
  mR.DebitItmQnt;  // Poèet debetných položiek

  mItmCnt:=mR.ItmCount;
  If mItmCnt>0 then begin
    For I:=0 to mItmCnt-1 do begin
      ItmIndex:=I; // Index aktuálnej položky

      mR.ItmDate; // Dátum zaúètovania
      mR.ItmVal;  // Hodnota
      mR.ItmIdVS; // Variabilný symbol
      mR.ItmIdSS; // Špecifický symbol
      mR.ItmIdKS; // Konštantný symbol
      mR.ItmContraAccIBAN; // Protiúèet - IBAN
      mR.ItmContraAccBIC;  // Protiúèet - BIC
      mR.ItmContraAccName; // Protiúèet - Názov
      mR.ItmNote; // Poznámka
  end;
  FreeAndNil(mR);
end;
*)

constructor TSEPAXMLMan.Create(pXMLFile:string);
begin
  oXML:=nil;
  oXMLDoc:=nil;
  oOpened:=FALSE;
  oErr:=-1;
  If FileExists(pXMLFile) then begin
    try
      oXMLDoc:=TXMLDocument.Create(pXMLFile);
      oXML:=GetDocument(oXMLDoc);
      oOpened:=TRUE;
    except oErr:=1; end;
  end;
  oItmIndex:=-1;
end;

destructor TSEPAXMLMan.Destroy;
begin
  oXML:=nil;
  oXMLDoc:=nil;
  inherited;
end;

function TSEPAXMLMan.XMLTimeToDateTime(pXMLTime:string):TDateTime;
begin
  Result:=0;
  with TXSDateTime.Create() do
    try
      XSToNative(pXMLTime); // convert from WideString
      Result:=AsDateTime; // convert to TDateTime
    finally
      Free;
    end;
end;

function TSEPAXMLMan.DateTimeToXLMTime(pDate:TDateTime):string;
begin
  Result:='';
  with TXSDateTime.Create() do
    try
      AsDateTime:=pDate; // convert from TDateTime
      Result:=NativeToXS; // convert to WideString
    finally
      Free;
    end;
end;

function TSEPAXMLMan.GetBankStatement:string;
var mSLst:TStringList; mLn,I,mCnt:longint; mStr:string;
begin
  mLn:=80;
  Result:='';
  If oOpened then begin
    mSLst:=TStringList.Create;
//    mSLst.Add('12345678901234567890123456789012345678901234567890123456789012345678901234567890');
    mSLst.Add('');
    mSLst.Add(AlignCenter('Preh¾ad výpisu z úètu è.: '+StrInt(LegalSequenceNumber,0),mLn));
    mSLst.Add('');
    mSLst.Add('');
    mStr:='Názov úètu:'+AlignLeft(AccName,39-11)+'  '+'Úètovné obdobie:'+AlignLeft(DateToStr(XMLTimeToDateTime(oXML.BkToCstmrStmt.Stmt.FrToDt.FrDtTm))+'-'+DateToStr(XMLTimeToDateTime(oXML.BkToCstmrStmt.Stmt.FrToDt.ToDtTm)),39-16);
    mSLst.Add(mStr);
    mStr:='Èíslo úètu:'+AlignLeft(AccIBAN,39-11)+'  '+'Poèiatoèný stav úètu:'+AlignLeft(StrDoub(PrevClsBooked,0,2),39-21);
    mSLst.Add(mStr);
    mStr:='BIC:'+AlignLeft(AccBIC,39-4)+'  '+'Vklady spolu:'+AlignLeft(StrDoub(TotalCredit,0,2),39-13);
    mSLst.Add(mStr);
    mStr:='Mena:'+AlignLeft(AccCurrency,39-5)+'  '+'Výbery spolu:'+AlignLeft(StrDoub(TotalDebit,0,2),39-13);
    mSLst.Add(mStr);
    mStr:='Dátum vyhotovenia:'+AlignLeft(DateToStr(CrtDate),39-18)+'  '+'Koneèný stav úètu:'+AlignLeft(StrDoub(ClsBooked,0,2),39-18);
    mSLst.Add(mStr);
    mSLst.Add('');
    mStr:='Poèet položiek: '+StrInt(ItmQnt,3)+' '+'Poèet kreditných položiek: '+StrInt(CreditItmQnt,3)+' '+'Poèet debetných položiek: '+StrInt(DebitItmQnt,3);
    mSLst.Add(mStr);
    mSLst.Add('');
    mSLst.Add('');
    mSLst.Add(AlignCenterBy('',mLn-1,'-'));
    mSLst.Add('Dátum      Popis                                                      Suma ');
    mSLst.Add('zúètovania transakcie                                                 transakcie');
    mSLst.Add(AlignCenterBy('',mLn-1,'-'));

    mCnt:=ItmCount;
    If mCnt>0 then begin
      For I:=0 to mCnt-1 do begin
        ItmIndex:=I;
        AddEntry(mSLst,mLn);
      end;
    end;

    Result:=mSLst.Text;
    FreeAndNil(mSLst);
  end;
end;

procedure TSEPAXMLMan.AddEntry(pSLst:TStringList;pLn:longint);
var mS,mSS:string; mSLst:TStringList; I:longint;
begin
  mSLst:=TStringList.Create;

  mS:=ItmContraAccIBAN;
  If mS<>'' then mS:='Protiúèet: '+mS+'   '+'BIC: '+ItmContraAccBIC;
  If mS<>'' then mSLst.Add(mS);

  mS:=ItmContraAccName;
  If mS<>'' then mS:='Názov protiúètu: '+mS;
  If mS<>'' then mSLst.Add(mS);

  mS:='';
  mSS:=ItmIdVS;
  If mSS<>'' then mS:='VS: '+mSS+' ';
  mSS:=ItmIdSS;
  If mSS<>'' then mS:=mS+'SS: '+mSS+' ';
  mSS:=ItmIdKS;
  If mSS<>'' then mS:=mS+'KS: '+mSS;
  If mS<>'' then mSLst.Add(mS);

  mS:=ItmNote;
  If mS<>'' then mSLst.Add(mS);

  If mSLst.Count>0 then begin
    mS:=AlignRight(DateToStr(ItmDte),11)+AlignRight(mSLst.Strings[0],pLn-11-12)+AlignLeft(StrDoub(ItmVal,0,2),12);
    pSLst.Add(mS);
    If mSLst.Count>1 then begin
      For I:=1 to mSLst.Count-1 do begin
        mS:=AlignRight(' ',11)+AlignRight(mSLst.Strings[I],pLn-11-12)+AlignLeft(' ',12);
        pSLst.Add(mS);
      end;
    end;
  end;
  pSLst.Add(AlignCenterBy('',pLn-1,'-'));
  FreeAndNil(mSLst);
end;

function TSEPAXMLMan.GetLegalSequenceNumber:longint;
begin
  Result:=0;
  If oOpened then begin
    try
      If oXML.BkToCstmrStmt.Stmt.ChildNodes.FindNode('LglSeqNb')<>nil then Result:=oXML.BkToCstmrStmt.Stmt.LglSeqNb;
    except oErr:=100 end;
  end;
end;

function TSEPAXMLMan.GetCrtDate:TDateTime;
begin
  Result:=0;
  If oOpened then begin
    try
      If oXML.BkToCstmrStmt.Stmt.ChildNodes.FindNode('CreDtTm')<>nil then Result:=XMLTimeToDateTime(oXML.BkToCstmrStmt.Stmt.CreDtTm);
    except oErr:=101 end;
  end;
end;

function TSEPAXMLMan.GetFromDate:TDateTime;
begin
  Result:=0;
  If oOpened then begin
    try
      If oXML.BkToCstmrStmt.Stmt.FrToDt.ChildNodes.FindNode('FrDtTm')<>nil then Result:=XMLTimeToDateTime(oXML.BkToCstmrStmt.Stmt.FrToDt.FrDtTm);
    except oErr:=102 end;
  end;
end;

function TSEPAXMLMan.GetToDate:TDateTime;
begin
  Result:=0;
  If oOpened then begin
    try
      If oXML.BkToCstmrStmt.Stmt.FrToDt.ChildNodes.FindNode('ToDtTm')<>nil then Result:=XMLTimeToDateTime(oXML.BkToCstmrStmt.Stmt.FrToDt.ToDtTm);
    except oErr:=103 end;
  end;
end;

function TSEPAXMLMan.GetAccName:string;
begin
  Result:='';
  If oOpened then begin
    try
      If oXML.BkToCstmrStmt.Stmt.Acct.ChildNodes.FindNode('Nm')<>nil then Result:=oXML.BkToCstmrStmt.Stmt.Acct.Nm;
    except oErr:=104 end;
  end;
end;

function TSEPAXMLMan.GetAccIBAN:string;
begin
  Result:='';
  If oOpened then begin
    try
      If oXML.BkToCstmrStmt.Stmt.Acct.Id.ChildNodes.FindNode('IBAN')<>nil then Result:=oXML.BkToCstmrStmt.Stmt.Acct.Id.IBAN;
    except oErr:=105 end;
  end;
end;

function TSEPAXMLMan.GetAccBIC:string;
begin
  Result:='';
  If oOpened then begin
    try
      If oXML.BkToCstmrStmt.Stmt.Acct.Svcr.FinInstnId.ChildNodes.FindNode('BIC')<>nil then Result:=oXML.BkToCstmrStmt.Stmt.Acct.Svcr.FinInstnId.BIC;
    except oErr:=106 end;
  end;
end;

function TSEPAXMLMan.GetAccCurrency:string;
begin
  Result:='';
  If oOpened then begin
    try
      If oXML.BkToCstmrStmt.Stmt.Acct.ChildNodes.FindNode('Ccy')<>nil then Result:=oXML.BkToCstmrStmt.Stmt.Acct.Ccy;
    except oErr:=107 end;
  end;
end;

function TSEPAXMLMan.GetPrevClsBooked:double;
var mIndex:longint;
begin
  Result:=0;
  If oOpened then begin
    mIndex:=GetBalanceIndex('PRCD');
    If mIndex>-1 then begin
      try
        If oXML.BkToCstmrStmt.Stmt.Bal[mIndex].ChildNodes.FindNode('Amt')<>nil then Result:=ValDoub(oXML.BkToCstmrStmt.Stmt.Bal[mIndex].Amt.Text);
        If oXML.BkToCstmrStmt.Stmt.Bal[mIndex].ChildNodes.FindNode('CdtDbtInd')<>nil then begin
          If oXML.BkToCstmrStmt.Stmt.Bal[mIndex].CdtDbtInd='DBIT' then Result:=-1*Result;
        end;
      except oErr:=108 end;
    end;
  end;
end;

function TSEPAXMLMan.GetClsBooked:double;
var mIndex:longint;
begin
  Result:=0;
  If oOpened then begin
    mIndex:=GetBalanceIndex('CLBD');
    If mIndex>-1 then begin
      try
        If oXML.BkToCstmrStmt.Stmt.Bal[mIndex].ChildNodes.FindNode('Amt')<>nil then Result:=ValDoub(oXML.BkToCstmrStmt.Stmt.Bal[mIndex].Amt.Text);
        If oXML.BkToCstmrStmt.Stmt.Bal[mIndex].ChildNodes.FindNode('CdtDbtInd')<>nil then begin
          If oXML.BkToCstmrStmt.Stmt.Bal[mIndex].CdtDbtInd='DBIT' then Result:=-1*Result;
        end;
      except oErr:=109 end;
    end;
  end;
end;

function TSEPAXMLMan.GetTotalCredit:double;
begin
  Result:=0;
  If oOpened then begin
    try
      If oXML.BkToCstmrStmt.Stmt.TxsSummry.TtlCdtNtries.ChildNodes.FindNode('Sum')<>nil then Result:=ValDoub(oXML.BkToCstmrStmt.Stmt.TxsSummry.TtlCdtNtries.Sum);
    except oErr:=110 end;
  end;
end;

function TSEPAXMLMan.GetTotalDebit:double;
begin
  Result:=0;
  If oOpened then begin
    try
      If oXML.BkToCstmrStmt.Stmt.TxsSummry.TtlDbtNtries.ChildNodes.FindNode('Sum')<>nil then Result:=-1*ValDoub(oXML.BkToCstmrStmt.Stmt.TxsSummry.TtlDbtNtries.Sum);
    except oErr:=111 end;
  end;
end;

function TSEPAXMLMan.GetItmQnt:longint;
begin
  Result:=0;
  If oOpened then begin
    try
      If oXML.BkToCstmrStmt.Stmt.TxsSummry.TtlNtries.ChildNodes.FindNode('NbOfNtries')<>nil then Result:=oXML.BkToCstmrStmt.Stmt.TxsSummry.TtlNtries.NbOfNtries;
    except oErr:=112 end;
  end;
end;

function TSEPAXMLMan.GetCreditItmQnt:longint;
begin
  Result:=0;
  If oOpened then begin
    try
      If oXML.BkToCstmrStmt.Stmt.TxsSummry.TtlCdtNtries.ChildNodes.FindNode('NbOfNtries')<>nil then Result:=oXML.BkToCstmrStmt.Stmt.TxsSummry.TtlCdtNtries.NbOfNtries;
    except oErr:=113 end;
  end;
end;

function TSEPAXMLMan.GetDebitItmQnt:longint;
begin
  Result:=0;
  If oOpened then begin
    try
      If oXML.BkToCstmrStmt.Stmt.TxsSummry.TtlDbtNtries.ChildNodes.FindNode('NbOfNtries')<>nil then Result:=oXML.BkToCstmrStmt.Stmt.TxsSummry.TtlDbtNtries.NbOfNtries;
    except oErr:=114 end;
  end;
end;

function TSEPAXMLMan.GetItmCount:longint;
begin
  Result:=0;
  If oOpened then begin
    try
      If oXML.BkToCstmrStmt.Stmt.ChildNodes.FindNode('Ntry')<>nil then Result:=oXML.BkToCstmrStmt.Stmt.Ntry.Count;
    except end;
  end;
end;

procedure TSEPAXMLMan.SetItmIndex(pIndex:longint);
var mCount:longint;
begin
  mCount:=GetItmCount;
  oItmIndex:=-1;
  If (mCount>0) and (pIndex>=0) and (pIndex<mCount) then oItmIndex:=pIndex;
end;

function TSEPAXMLMan.GetItmDte:TDateTime;
begin
  Result:=0;
  If oOpened then begin
    try
      If oXML.BkToCstmrStmt.Stmt.Ntry[oItmIndex].BookgDt.ChildNodes.FindNode('Dt')<>nil then Result:=XMLTimeToDateTime(oXML.BkToCstmrStmt.Stmt.Ntry[oItmIndex].BookgDt.Dt);
    except oErr:=115 end;
  end;
end;

function TSEPAXMLMan.GetItmVal:double;
begin
  Result:=0;
  If oOpened then begin
    try
      If oXML.BkToCstmrStmt.Stmt.Ntry[oItmIndex].ChildNodes.FindNode('Amt')<>nil then begin
        Result:=ValDoub(oXML.BkToCstmrStmt.Stmt.Ntry[oItmIndex].Amt.Text);
        If oXML.BkToCstmrStmt.Stmt.Ntry[oItmIndex].CdtDbtInd='DBIT' then Result:=-1*Result;
      end;
    except oErr:=116 end;
  end;
end;

function TSEPAXMLMan.GetItmId:string;
begin
  Result:='';
  If oOpened then begin
    try
      If oXML.BkToCstmrStmt.Stmt.Ntry[oItmIndex].NtryDtls.TxDtls.Refs.ChildNodes.FindNode('EndToEndId')<>nil then Result:=oXML.BkToCstmrStmt.Stmt.Ntry[oItmIndex].NtryDtls.TxDtls.Refs.EndToEndId;
    except oErr:=117 end;
  end;
end;

function TSEPAXMLMan.GetItmIdVS:string;
var mS:string;
begin
  Result:='';
  mS:=GetItmId;
  If mS<>'' then begin
    If Pos ('/VS',mS)=1 then begin
      Delete(mS,1,Pos ('/VS',mS)+2);
      Result:=Copy(mS,1,Pos('/',mS)-1);
    end else begin
      If Pos ('VS',mS)=1 then begin    //14.05.2018 TIBI 
        Delete(mS,1,Pos ('VS',mS)+1);
        Result:=Copy(mS,1,Pos('/',mS)-1);
      end;
    end;
  end;
end;

function TSEPAXMLMan.GetItmIdSS:string;
var mS:string;
begin
  Result:='';
  mS:=GetItmId;
  If mS<>'' then begin
    If Pos ('/SS',mS)>0 then begin
      Delete(mS,1,Pos ('/SS',mS)+2);
      Result:=Copy(mS,1,Pos('/',mS)-1);
    end;
  end;
end;

function TSEPAXMLMan.GetItmIdKS:string;
var mS:string;
begin
  Result:='';
  mS:=GetItmId;
  If mS<>'' then begin
    If Pos ('/KS',mS)>0 then begin
      Delete(mS,1,Pos ('/KS',mS)+2);
      Result:=mS;
    end;
  end;
end;

function TSEPAXMLMan.GetItmTypeCredit:boolean;
begin
  Result:=TRUE;
  If oOpened then begin
    try
      If oXML.BkToCstmrStmt.Stmt.Ntry[oItmIndex].ChildNodes.FindNode('CdtDbtInd')<>nil then begin
        Result:=oXML.BkToCstmrStmt.Stmt.Ntry[oItmIndex].CdtDbtInd<>'DBIT';
      end;
    except oErr:=119 end;
  end;
end;

function TSEPAXMLMan.GetItmContraAccIBAN:string;
begin
  Result:='';
  If oOpened then begin
    try
      If GetItmTypeCredit then begin
        If oXML.BkToCstmrStmt.Stmt.Ntry[oItmIndex].NtryDtls.TxDtls.RltdPties.DbtrAcct.Id.ChildNodes.FindNode('IBAN')<>nil
          then Result:=oXML.BkToCstmrStmt.Stmt.Ntry[oItmIndex].NtryDtls.TxDtls.RltdPties.DbtrAcct.Id.IBAN;
      end else begin
        If oXML.BkToCstmrStmt.Stmt.Ntry[oItmIndex].NtryDtls.TxDtls.RltdPties.CdtrAcct.Id.ChildNodes.FindNode('IBAN')<>nil
          then Result:=oXML.BkToCstmrStmt.Stmt.Ntry[oItmIndex].NtryDtls.TxDtls.RltdPties.CdtrAcct.Id.IBAN;
      end;
    except oErr:=119; end;
  end;
end;

function TSEPAXMLMan.GetItmContraAccBIC:string;
begin
  Result:='';
  If oOpened then begin
    try
      If GetItmTypeCredit then begin
        If oXML.BkToCstmrStmt.Stmt.Ntry[oItmIndex].NtryDtls.TxDtls.RltdAgts.DbtrAgt.FinInstnId.ChildNodes.FindNode('BIC')<>nil
          then Result:=oXML.BkToCstmrStmt.Stmt.Ntry[oItmIndex].NtryDtls.TxDtls.RltdAgts.DbtrAgt.FinInstnId.BIC;
      end else begin
        If oXML.BkToCstmrStmt.Stmt.Ntry[oItmIndex].NtryDtls.TxDtls.RltdAgts.CdtrAgt.FinInstnId.ChildNodes.FindNode('BIC')<>nil
          then Result:=oXML.BkToCstmrStmt.Stmt.Ntry[oItmIndex].NtryDtls.TxDtls.RltdAgts.CdtrAgt.FinInstnId.BIC;
      end;
    except oErr:=120; end;
  end;
end;

function TSEPAXMLMan.GetItmContraAccName:string;
begin
  Result:='';
  If oOpened then begin
    try
      If GetItmTypeCredit then begin
        If oXML.BkToCstmrStmt.Stmt.Ntry[oItmIndex].NtryDtls.TxDtls.RltdPties.DbtrAcct.ChildNodes.FindNode('Nm')<>nil
          then Result:=oXML.BkToCstmrStmt.Stmt.Ntry[oItmIndex].NtryDtls.TxDtls.RltdPties.DbtrAcct.Nm;
      end else begin
        If oXML.BkToCstmrStmt.Stmt.Ntry[oItmIndex].NtryDtls.TxDtls.RltdPties.CdtrAcct.ChildNodes.FindNode('Nm')<>nil
          then Result:=oXML.BkToCstmrStmt.Stmt.Ntry[oItmIndex].NtryDtls.TxDtls.RltdPties.CdtrAcct.Nm;
      end;
    except oErr:=121; end;
  end;
end;

function TSEPAXMLMan.GetItmNote:string;
begin
  Result:='';
  If oOpened then begin
    try
      If oXML.BkToCstmrStmt.Stmt.Ntry[oItmIndex].NtryDtls.TxDtls.RmtInf.ChildNodes.FindNode('Ustrd')<>nil then Result:=oXML.BkToCstmrStmt.Stmt.Ntry[oItmIndex].NtryDtls.TxDtls.RmtInf.Ustrd;
    except oErr:=122 end;
  end;
end;

function TSEPAXMLMan.GetBalanceIndex(pId:string):longint;
var I:longint;
begin
  Result:=-1;
  try
    For I:=0 to oXML.BkToCstmrStmt.Stmt.Bal.Count-1 do begin
      If oXML.BkToCstmrStmt.Stmt.Bal[I].Tp.CdOrPrtry.Cd=pId then begin
        Result:=I;
        Break;
      end;
    end;
  except oErr:=123; end;
end;

end.
