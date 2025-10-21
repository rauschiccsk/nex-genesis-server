unit SctXmlMan;  // Import úhrad SEPA Credit Transfer XML

interface

uses
  IcConv, IcTools, XSBuiltIns,
  SCTXML, XMLDoc, SysUtils, Classes, Forms;

type
  TSCTXMLMan = class
    constructor Create;
    destructor Destroy; override;
  private
    oXML:IXMLDocumentType;
    oIDCnt:longint;

    function DateTimeToXLMTime(pDate:TDateTime):string;
    function GetIDStr:string;
  published
    procedure SetHead (pVal:double;pItmNum:longint;pDate:TDateTime;pOwnName,pAddrLn1,pAddrLn2,pIBAN,pBIC,pBankName:string);
    procedure AddItem(pVal:double;pVS,pSS,pKS,pIBAN,pBIC,pNote:string);
    procedure SaveXML (pFileName:string);
  end;

implementation

uses XMLIntf;


//Príklad
//var mR:TSCTXMLMan;
//begin
//  mR:=TSCTXMLMan.Create;
//  mR.SetHead(6.3,2,Date,'IDENTCODE CONSULTING s.r.o.','','','SK1911000000002626064187','TATRSKBX','TATRA BANKA, A.S.');
//  mR.AddItem(2.5,'201801','01','0308','SK0209000000000011613195','GIBASKBX','Uhrada FA 201801');
//  mR.AddItem(3.8,'201802','02','0008','SK0209000000000019193260','GIBASKBX','Uhrada FA 201802');
//  mR.SaveXML('prikaztb.xml');
//  FreeAndNil(mR);
//end;



constructor TSCTXMLMan.Create;
begin
  oXML:=SCTXML.NewDocument;
  oIDCnt:=0;
end;

destructor TSCTXMLMan.Destroy;
begin
  oXML:=nil;
  inherited;
end;

function TSCTXMLMan.DateTimeToXLMTime(pDate:TDateTime):string;
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

function TSCTXMLMan.GetIDStr:string;
begin
  Inc(oIDCnt);
  Result:=FormatDateTime('yymmddhhnnsszzz',Now)+StrIntZero(oIDCnt,3);
end;

procedure TSCTXMLMan.SetHead (pVal:double;pItmNum:longint;pDate:TDateTime;pOwnName,pAddrLn1,pAddrLn2,pIBAN,pBIC,pBankName:string);
begin
  oXML.Attributes['xmlns']:='urn:iso:std:iso:20022:tech:xsd:pain.001.001.03';
  oXML.Attributes['xmlns:xsi']:='http://www.w3.org/2001/XMLSchema-instance';
  oXML.Attributes['xsi:schemaLocation']:='urn:iso:std:iso:20022:tech:xsd:pain.001.001.03 pain.001.001.03.xsd';

  oXML.CstmrCdtTrfInitn.GrpHdr.MsgId:=GetIDStr;
  oXML.CstmrCdtTrfInitn.GrpHdr.CreDtTm:=DateTimeToXLMTime(Now);
  oXML.CstmrCdtTrfInitn.GrpHdr.NbOfTxs:=pItmNum;
  oXML.CstmrCdtTrfInitn.GrpHdr.CtrlSum:=StrDoub(pVal,0,2);
  oXML.CstmrCdtTrfInitn.GrpHdr.InitgPty.Nm:=ConvToNoDiakr(pOwnName);

  oXML.CstmrCdtTrfInitn.PmtInf.PmtInfId:=GetIDStr;
  oXML.CstmrCdtTrfInitn.PmtInf.PmtMtd:='TRF';
  oXML.CstmrCdtTrfInitn.PmtInf.BtchBookg:='false';
  oXML.CstmrCdtTrfInitn.PmtInf.NbOfTxs:=pItmNum;
  oXML.CstmrCdtTrfInitn.PmtInf.CtrlSum:=StrDoub(pVal,0,2);

  oXML.CstmrCdtTrfInitn.PmtInf.PmtTpInf.InstrPrty:='NORM';
  oXML.CstmrCdtTrfInitn.PmtInf.PmtTpInf.SvcLvl.Cd:='SEPA';
  oXML.CstmrCdtTrfInitn.PmtInf.ReqdExctnDt:=FormatDateTime('yyyy-mm-dd',pDate);
  oXML.CstmrCdtTrfInitn.PmtInf.Dbtr.Nm:=ConvToNoDiakr(pOwnName);
  oXML.CstmrCdtTrfInitn.PmtInf.Dbtr.PstlAdr.Ctry:='SK';
//  oXML.CstmrCdtTrfInitn.PmtInf.Dbtr.PstlAdr.AdrLine.Add(ConvToNoDiakr(pAddrLn1));
//  oXML.CstmrCdtTrfInitn.PmtInf.Dbtr.PstlAdr.AdrLine.Add(ConvToNoDiakr(pAddrLn2));

  oXML.CstmrCdtTrfInitn.PmtInf.DbtrAcct.Id.IBAN:=pIBAN;
  oXML.CstmrCdtTrfInitn.PmtInf.DbtrAcct.Ccy:='EUR';

  oXML.CstmrCdtTrfInitn.PmtInf.DbtrAgt.FinInstnId.BIC:=pBIC;
  oXML.CstmrCdtTrfInitn.PmtInf.DbtrAgt.FinInstnId.Nm:=ConvToNoDiakr(pBankName);

  oXML.CstmrCdtTrfInitn.PmtInf.ChrgBr:='SLEV';
end;

procedure TSCTXMLMan.AddItem(pVal:double;pVS,pSS,pKS,pIBAN,pBIC,pNote:string);
var mIndex:longint;
begin
  mIndex:=oXML.CstmrCdtTrfInitn.PmtInf.CdtTrfTxInf.Count;
  oXML.CstmrCdtTrfInitn.PmtInf.CdtTrfTxInf.Add;

  oXML.CstmrCdtTrfInitn.PmtInf.CdtTrfTxInf[mIndex].PmtId.InstrId:=GetIDStr;
//  oXML.CstmrCdtTrfInitn.PmtInf.CdtTrfTxInf[mIndex].PmtId.EndToEndId:='VS'+pVS+'/SS'+pSS+'/KS'+pKS;
  //14.05.2018 TIBI
  oXML.CstmrCdtTrfInitn.PmtInf.CdtTrfTxInf[mIndex].PmtId.EndToEndId:='/VS'+pVS+'/SS'+pSS+'/KS'+pKS;

  oXML.CstmrCdtTrfInitn.PmtInf.CdtTrfTxInf[mIndex].PmtTpInf.InstrPrty:='NORM';
  oXML.CstmrCdtTrfInitn.PmtInf.CdtTrfTxInf[mIndex].PmtTpInf.SvcLvl.Cd:='SEPA';

  oXML.CstmrCdtTrfInitn.PmtInf.CdtTrfTxInf[mIndex].Amt.InstdAmt.Ccy:='EUR';
  oXML.CstmrCdtTrfInitn.PmtInf.CdtTrfTxInf[mIndex].Amt.InstdAmt.Text:=StrDoub(pVal,0,2);
  oXML.CstmrCdtTrfInitn.PmtInf.CdtTrfTxInf[mIndex].ChrgBr:='SLEV';
  oXML.CstmrCdtTrfInitn.PmtInf.CdtTrfTxInf[mIndex].CdtrAgt.FinInstnId.BIC:=pBIC;
  oXML.CstmrCdtTrfInitn.PmtInf.CdtTrfTxInf[mIndex].Cdtr.Nm:=ConvToNoDiakr(pNote); //Názov príjemcu
  oXML.CstmrCdtTrfInitn.PmtInf.CdtTrfTxInf[mIndex].CdtrAcct.Id.IBAN:=pIBAN;
  oXML.CstmrCdtTrfInitn.PmtInf.CdtTrfTxInf[mIndex].RmtInf.Ustrd:=ConvToNoDiakr(pNote);
end;

procedure TSCTXMLMan.SaveXML (pFileName:string);
var mXMLDoc:TXMLDocument;
begin
  mXMLDoc:=TXMLDocument.Create(Application.MainForm);
  mXMLDoc.XML.Text:=ReplaceStr(AnsiToUtf8(oXML.XML),' xmlns=""','');
  mXMLDoc.Active:=TRUE;
  mXMLDoc.Version:='1.0';
  mXMLDoc.Encoding:='utf-8';
  mXMLDoc.SaveToFile(pFileName);
  mXMLDoc:=nil;
end;

end.
