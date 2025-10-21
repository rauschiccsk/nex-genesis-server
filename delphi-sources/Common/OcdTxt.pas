unit OcdTxt;
{$F+}

interface

uses
  IcTypes, IcConv, IcTools, IcVariab, IniFiles, SysUtils, NexGlob,
  NexPath, NexIni, TxtWrap, TxtCut, StkCanc, DocHand, TxtDoc, Forms;

type
  TOcdTxt = class
    constructor Create;
    destructor  Destroy; override;
    private
      oDocNum: Str12; // Cislo dokladu ktorym pracujeme
      procedure LoadTxtToOch; // Nacita udaje z prenosoveho suboru a vytvori alebo opravy hlavicku ZK
      procedure LoadTxtToTmp; // Nacita poloky z prenosoveho suboru do docasneh databaze ptOCI
      procedure LoadTxtToOcn; // Nacita poloky z prenosoveho suboru do docasneh databaze ptOCI
      procedure DeleteOci; // Vymaze polozky doacieho listu, ktore nie su v docasnej databaze
      procedure AddNewItmToOci; // Prida nove polozky do ZK
    public
      oCount:word;
      oTxtDoc: TTxtDoc;
      procedure SaveToFile (pDocNum:Str12);  // Ulozi zadany doklad do textoveho suboru
      procedure LoadFromFile (pDocNum:Str12);  // Nacita doklad z textoveho suboru
    published
      property Count:word read oCount;
  end;

// FtpVersion
//   0 - prvotna verzia prenosu
//   1 - zmeny od v 10.02

implementation

uses
   DM_STKDAT, DB;

constructor TOcdTxt.Create;
begin
end;

destructor TOcdTxt.Destroy;
begin
end;

procedure TOcdTxt.SaveToFile (pDocNum:Str12);  // Ulozi zadany doklad do textoveho suboru
var mFileName:string;  mWrap:TTxtWrap;   mLine:byte;
begin
  mFileName := gIni.GetZipPath+pDocNum+'.TXT';
  oTxtDoc := TTxtDoc.Create;
  If FileExists (mFileName) then DeleteFile (mFileName);
  // ******************** Ulozime hlacivku dokladu ************************
  oTxtDoc.WriteInteger ('FtpVer',1);
  oTxtDoc.WriteString ('PrgVer',cPrgVer);
  // Nezmenene polia - kompatibilne polia
  oTxtDoc.WriteString ('DocNum',dmSTK.btOCH.FieldByName('DocNum').AsString);
  oTxtDoc.WriteInteger ('SerNum',dmSTK.btOCH.FieldByName('SerNum').AsInteger);
  oTxtDoc.WriteString ('DocNum',dmSTK.btOCH.FieldByName('DocNum').AsString);
  oTxtDoc.WriteString ('ExtNum',dmSTK.btOCH.FieldByName('ExtNum').AsString);
  oTxtDoc.WriteDate ('DocDate',dmSTK.btOCH.FieldByName('DocDate').AsDateTime);
  oTxtDoc.WriteInteger ('StkNum',dmSTK.btOCH.FieldByName('StkNum').AsInteger);
  oTxtDoc.WriteInteger ('PaCode',dmSTK.btOCH.FieldByName('PaCode').AsInteger);
  oTxtDoc.WriteString ('PaName',dmSTK.btOCH.FieldByName('PaName').AsString);
  oTxtDoc.WriteString ('PayCode',dmSTK.btOCH.FieldByName('PayCode').AsString);
  oTxtDoc.WriteString ('TrsCode',dmSTK.btOCH.FieldByName('TrsCode').AsString);
  oTxtDoc.WriteString ('RspName',dmSTK.btOCH.FieldByName('RspName').AsString);
  oTxtDoc.WriteInteger ('PlsNum',dmSTK.btOCH.FieldByName('PlsNum').AsInteger);
  oTxtDoc.WriteInteger ('VatPrc1',dmSTK.btOCH.FieldByName('VatPrc1').AsInteger);
  oTxtDoc.WriteInteger ('VatPrc2',dmSTK.btOCH.FieldByName('VatPrc2').AsInteger);
  oTxtDoc.WriteInteger ('VatPrc3',dmSTK.btOCH.FieldByName('VatPrc3').AsInteger);
  oTxtDoc.WriteString ('ModUser',dmSTK.btOCH.FieldByName('ModUser').AsString);
  oTxtDoc.WriteDate ('ModDate',dmSTK.btOCH.FieldByName('ModDate').AsDateTime);
  oTxtDoc.WriteDate ('ModTime',dmSTK.btOCH.FieldByName('ModTime').AsDateTime);
  // Stare zrusene poloa - ponechava sa kvoli kompatibilite
  oTxtDoc.WriteString ('RspUser',dmSTK.btOCH.FieldByName('CrtUser').AsString);
  // Nove polia od v 10.02
  oTxtDoc.WriteDate ('ExpDate',dmSTK.btOCH.FieldByName('ExpDate').AsDateTime);
  oTxtDoc.WriteDate ('DlvDate',dmSTK.btOCH.FieldByName('DlvDate').AsDateTime);
  oTxtDoc.WriteString ('RegName',dmSTK.btOCH.FieldByName('RegName').AsString);
  oTxtDoc.WriteString ('RegIno',dmSTK.btOCH.FieldByName('RegIno').AsString);
  oTxtDoc.WriteString ('RegTin',dmSTK.btOCH.FieldByName('RegTin').AsString);
  oTxtDoc.WriteString ('RegVin',dmSTK.btOCH.FieldByName('RegVin').AsString);
  oTxtDoc.WriteString ('RegAddr',dmSTK.btOCH.FieldByName('RegAddr').AsString);
  oTxtDoc.WriteString ('RegSta',dmSTK.btOCH.FieldByName('RegSta').AsString);
  oTxtDoc.WriteString ('RegCty',dmSTK.btOCH.FieldByName('RegCty').AsString);
  oTxtDoc.WriteString ('RegCtn',dmSTK.btOCH.FieldByName('RegCtn').AsString);
  oTxtDoc.WriteString ('RegZip',dmSTK.btOCH.FieldByName('RegZip').AsString);
  oTxtDoc.WriteInteger ('IcFacDay',dmSTK.btOCH.FieldByName('IcFacDay').AsInteger);
  oTxtDoc.WriteFloat ('IcFacPrc',dmSTK.btOCH.FieldByName('IcFacPrc').AsFloat);
  oTxtDoc.WriteString ('PayName',dmSTK.btOCH.FieldByName('PayName').AsString);
  oTxtDoc.WriteInteger ('SpaCode',dmSTK.btOCH.FieldByName('SpaCode').AsInteger);
  oTxtDoc.WriteInteger ('WpaCode',dmSTK.btOCH.FieldByName('WpaCode').AsInteger);
  oTxtDoc.WriteString ('WpaName',dmSTK.btOCH.FieldByName('WpaName').AsString);
  oTxtDoc.WriteString ('WpaAddr',dmSTK.btOCH.FieldByName('WpaAddr').AsString);
  oTxtDoc.WriteString ('WpaSta',dmSTK.btOCH.FieldByName('WpaSta').AsString);
  oTxtDoc.WriteString ('WpaCty',dmSTK.btOCH.FieldByName('WpaCty').AsString);
  oTxtDoc.WriteString ('WpaCtn',dmSTK.btOCH.FieldByName('WpaCtn').AsString);
  oTxtDoc.WriteString ('WpaZip',dmSTK.btOCH.FieldByName('WpaZip').AsString);
  oTxtDoc.WriteString ('TrsName',dmSTK.btOCH.FieldByName('TrsName').AsString);
  oTxtDoc.WriteFloat ('PrfPrc',dmSTK.btOCH.FieldByName('PrfPrc').AsFloat);
  oTxtDoc.WriteString ('AcDvzName',dmSTK.btOCH.FieldByName('AcDvzName').AsString);
  oTxtDoc.WriteFloat ('AcPValue',dmSTK.btOCH.FieldByName('AcPValue').AsFloat);
  oTxtDoc.WriteFloat ('AcMValue',dmSTK.btOCH.FieldByName('AcMValue').AsFloat);
  oTxtDoc.WriteFloat ('AcWValue',dmSTK.btOCH.FieldByName('AcWValue').AsFloat);
  oTxtDoc.WriteFloat ('AcOValue',dmSTK.btOCH.FieldByName('AcOValue').AsFloat);
  oTxtDoc.WriteString ('FgDvzName',dmSTK.btOCH.FieldByName('FgDvzName').AsString);
  oTxtDoc.WriteFloat ('FgCourse',dmSTK.btOCH.FieldByName('FgCourse').AsFloat);
  oTxtDoc.WriteFloat ('FgPValue',dmSTK.btOCH.FieldByName('FgPValue').AsFloat);
  oTxtDoc.WriteString ('PValPay',dmSTK.btOCH.FieldByName('PValPay').AsString);
  oTxtDoc.WriteInteger ('DlrCode',dmSTK.btOCH.FieldByName('DlrCode').AsInteger);
  oTxtDoc.WriteString ('CusCard',dmSTK.btOCH.FieldByName('CusCard').AsString);
  oTxtDoc.WriteInteger ('VatDoc',dmSTK.btOCH.FieldByName('VatDoc').AsInteger);
  oTxtDoc.WriteInteger ('PrnCnt',dmSTK.btOCH.FieldByName('PrnCnt').AsInteger);
  oTxtDoc.WriteInteger ('DstLck',dmSTK.btOCH.FieldByName('DstLck').AsInteger);
  oTxtDoc.WriteInteger ('DstCls',dmSTK.btOCH.FieldByName('DstCls').AsInteger);
  oTxtDoc.WriteString ('CrtUser',dmSTK.btOCH.FieldByName('CrtUser').AsString);
  oTxtDoc.WriteDate ('CrtDate',dmSTK.btOCH.FieldByName('CrtDate').AsDateTime);
  oTxtDoc.WriteDate ('CrtTime',dmSTK.btOCH.FieldByName('CrtTime').AsDateTime);
  oTxtDoc.WriteString ('Year',dmSTK.btOCH.FieldByName('Year').AsString);
  // Ulozime poloziek dokladu
  If dmSTK.btOCI.IndexName<>'DoIt' then dmSTK.btOCI.IndexName := 'DoIt';
  dmSTK.btOCI.FindNearest ([pDocNum,0]);
  If dmSTK.btOCI.FieldByName ('DocNum').AsString=dmSTK.btOCH.FieldByName ('DocNum').AsString then begin
    Repeat
      oTxtDoc.Insert;
      // Nezmenene polia - kompatibilne polia
      oTxtDoc.WriteInteger ('ItmNum',dmSTK.btOCI.FieldByName('ItmNum').AsInteger);
      oTxtDoc.WriteInteger ('MgCode',dmSTK.btOCI.FieldByName('MgCode').AsInteger);
      oTxtDoc.WriteInteger ('GsCode',dmSTK.btOCI.FieldByName('GsCode').AsInteger);
      oTxtDoc.WriteString ('GsName',dmSTK.btOCI.FieldByName('GsName').AsString);
      oTxtDoc.WriteString ('BarCode',dmSTK.btOCI.FieldByName('BarCode').AsString);
      oTxtDoc.WriteString ('StkCode',dmSTK.btOCI.FieldByName('StkCode').AsString);
      oTxtDoc.WriteInteger ('StkNum',dmSTK.btOCI.FieldByName('StkNum').AsInteger);
      oTxtDoc.WriteFloat ('OrdQnt',dmSTK.btOCI.FieldByName('OrdQnt').AsFloat);
      oTxtDoc.WriteInteger ('VatPrc',Round(dmSTK.btOCI.FieldByName('VatPrc').AsFloat));
      oTxtDoc.WriteFloat ('DscPrc',dmSTK.btOCI.FieldByName('DscPrc').AsFloat);
      oTxtDoc.WriteString ('IcdNum',dmSTK.btOCI.FieldByName('IcdNum').AsString);
      oTxtDoc.WriteInteger ('IcdItm',dmSTK.btOCI.FieldByName('IcdItm').AsInteger);
      oTxtDoc.WriteDate ('IcdDate',dmSTK.btOCI.FieldByName('IcdDate').AsDateTime);
      oTxtDoc.WriteString ('StkStat',dmSTK.btOCI.FieldByName('StkStat').AsString);
      oTxtDoc.WriteString ('FinStat',dmSTK.btOCI.FieldByName('FinStat').AsString);
      oTxtDoc.WriteString ('ModUser',dmSTK.btOCI.FieldByName('ModUser').AsString);
      oTxtDoc.WriteDate ('ModDate',dmSTK.btOCI.FieldByName('ModDate').AsDateTime);
      oTxtDoc.WriteTime ('ModTime',dmSTK.btOCI.FieldByName('ModTime').AsDateTime);
      // Stare zrusene poloa - ponechava sa kvoli kompatibilite
      oTxtDoc.WriteFloat ('ItmVal',dmSTK.btOCI.FieldByName('FgDValue').AsFloat);
      oTxtDoc.WriteFloat ('DscVal',dmSTK.btOCI.FieldByName('FgDscVal').AsFloat);
      oTxtDoc.WriteFloat ('APrice',dmSTK.btOCI.FieldByName('FgAPrice').AsFloat);
      oTxtDoc.WriteFloat ('BPrice',dmSTK.btOCI.FieldByName('FgBPrice').AsFloat);
      oTxtDoc.WriteFloat ('CPrice',dmSTK.btOCI.FieldByName('FgCPrice').AsFloat);
      oTxtDoc.WriteFloat ('AValue',dmSTK.btOCI.FieldByName('FgAValue').AsFloat);
      oTxtDoc.WriteFloat ('BValue',dmSTK.btOCI.FieldByName('FgBValue').AsFloat);
      // Nove polia od v 10.02
      oTxtDoc.WriteString ('Notice',dmSTK.btOCI.FieldByName('Notice').AsString);
      oTxtDoc.WriteFloat ('Volume',dmSTK.btOCI.FieldByName('Volume').AsFloat);
      oTxtDoc.WriteFloat ('Weight',dmSTK.btOCI.FieldByName('Weight').AsFloat);
      oTxtDoc.WriteInteger ('PackGs',dmSTK.btOCI.FieldByName('PackGs').AsInteger);
      oTxtDoc.WriteString ('GsType',dmSTK.btOCI.FieldByName('GsType').AsString);
      oTxtDoc.WriteString ('MsName',dmSTK.btOCI.FieldByName('MsName').AsString);
      oTxtDoc.WriteFloat ('AcCValue',dmSTK.btOCI.FieldByName('AcCValue').AsFloat);
      oTxtDoc.WriteFloat ('AcDValue',dmSTK.btOCI.FieldByName('AcDValue').AsFloat);
      oTxtDoc.WriteFloat ('AcDscVal',dmSTK.btOCI.FieldByName('AcDscVal').AsFloat);
      oTxtDoc.WriteFloat ('AcAValue',dmSTK.btOCI.FieldByName('AcAValue').AsFloat);
      oTxtDoc.WriteFloat ('AcBValue',dmSTK.btOCI.FieldByName('AcBValue').AsFloat);
      oTxtDoc.WriteFloat ('FgCPrice',dmSTK.btOCI.FieldByName('FgCPrice').AsFloat);
      oTxtDoc.WriteFloat ('FgDPrice',dmSTK.btOCI.FieldByName('FgDPrice').AsFloat);
      oTxtDoc.WriteFloat ('FgAPrice',dmSTK.btOCI.FieldByName('FgAPrice').AsFloat);
      oTxtDoc.WriteFloat ('FgBPrice',dmSTK.btOCI.FieldByName('FgBPrice').AsFloat);
      oTxtDoc.WriteFloat ('FgCValue',dmSTK.btOCI.FieldByName('FgCValue').AsFloat);
      oTxtDoc.WriteFloat ('FgDValue',dmSTK.btOCI.FieldByName('FgDValue').AsFloat);
      oTxtDoc.WriteFloat ('FgDscVal',dmSTK.btOCI.FieldByName('FgDscVal').AsFloat);
      oTxtDoc.WriteFloat ('FgAValue',dmSTK.btOCI.FieldByName('FgAValue').AsFloat);
      oTxtDoc.WriteFloat ('FgBValue',dmSTK.btOCI.FieldByName('FgBValue').AsFloat);
      oTxtDoc.WriteString ('TcdNum',dmSTK.btOCI.FieldByName('TcdNum').AsString);
      oTxtDoc.WriteInteger ('TcdItm',dmSTK.btOCI.FieldByName('TcdItm').AsInteger);
      oTxtDoc.WriteDate ('TcdDate',dmSTK.btOCI.FieldByName('TcdDate').AsDateTime);
      oTxtDoc.WriteString ('McdNum',dmSTK.btOCI.FieldByName('McdNum').AsString);
      oTxtDoc.WriteInteger ('McdItm',dmSTK.btOCI.FieldByName('McdItm').AsInteger);
      oTxtDoc.WriteString ('Action',dmSTK.btOCI.FieldByName('Action').AsString);
      oTxtDoc.WriteString ('CrtUser',dmSTK.btOCI.FieldByName('CrtUser').AsString);
      oTxtDoc.WriteDate ('CrtDate',dmSTK.btOCI.FieldByName('CrtDate').AsDateTime);
      oTxtDoc.WriteTime ('CrtTime',dmSTK.btOCI.FieldByName('CrtTime').AsDateTime);
      (*
      DocDate    DateType     ;Datum vystavenia zakazky
      ExpDate    DateType     ;Datum platnosti (expiracie) zakazky
      DlvDate    DateType     ;Dodacia lehota
      PaCode     longint      ;Ciselny kod odberatela
      *)
      oTxtDoc.Post;
      Application.ProcessMessages;
      dmSTK.btOCI.Next;
    until (dmSTK.btOCI.Eof) or (dmSTK.btOCI.FieldByName('DocNum').AsString<>pDocNum);
(*
    // Ulozime poznamky dokladu
    If dmSTK.btOCN.IndexName<>'DoNtLn' then dmSTK.btOCN.IndexName:='DoNtLn';
    dmSTK.btOCN.FindNearest ([pDocNum,'',0]);
    If dmSTK.btOCN.FieldByName ('DocNum').AsString=dmSTK.btOCH.FieldByName ('DocNum').AsString then begin
      mLine := 0;
      Repeat
        Inc (mLine);
        oTxtDoc.WriteString ('NOTICES','Line'+StrInt(mLine,0),dmSTK.btOCN.FieldByName('Notice').AsString);
      until (dmSTK.btOCN.Eof) or (dmSTK.btOCN.FieldByName('DocNum').AsString<>pDocNum);
    end;
*)    
  end;
  oTxtDoc.SaveToFile (mFileName);
  FreeAndNil (oTxtDoc);
end;

procedure TOcdTxt.LoadFromFile (pDocNum:Str12);  // Nacita doklad z textoveho suboru
var mFileName:string;
begin
  oDocNum := pDocNum;
  mFileName := gIni.GetZipPath+pDocNum+'.TXT';
  If FileExists (mFileName) then begin
    oTxtDoc := TTxtDoc.Create;
    oTxtDoc.LoadFromFile (mFileName);
    LoadTxtToOch; // Nacita udaje z prenosoveho suboru a vytvori alebo opravy hlavicku ZK
    If dmSTK.btOCH.FieldByName('ItmQnt').AsInteger>0 then begin  // Ak doklad ma polozky
      // Polozky dokladu
      dmSTK.ptOCI.Open;
      dmSTK.ptOCI.IndexName := 'ItmNum';
      LoadTxtToTmp; // Nacita poloky z prenosoveho suboru do docasneh databaze ptTCI
      DeleteOci; // Vymaze polozky doacieho listu, ktore nie su v docasnej databaze
      AddNewItmToOci; // Prida nove polozky do ZK
      dmSTK.ptOCI.Close;
      OchRecalc (dmSTK.btOCH,dmSTK.btOCI);  // Prepocita hlavicku zadaneho dodacieho listu podla jeho poloziek
    end;
    // Poznamky k dokladu

    FreeAndNil (oTxtDoc);
    DeleteFile (mFileName);
  end;
end;

procedure TOcdTxt.LoadTxtToOch; // Nacita udaje z prenosoveho suboru a vytvori alebo opravy hlavicku ZK
begin
  If dmSTK.btOCH.IndexName<>'DocNum' then dmSTK.btOCH.IndexName:='DocNum';
  If dmSTK.btOCH.FindKey ([oDocNum])
    then dmSTK.btOCH.Edit // Uprava hlavicky dokladu
    else dmSTK.btOCH.Insert;  // Novy doklad
  // FtpVer=2 - nova verzia od v10.02
  dmSTK.btOCH.FieldByName('SerNum').AsInteger := oTxtDoc.ReadInteger ('SerNum');
  dmSTK.btOCH.FieldByName('Year').AsString := oTxtDoc.ReadString ('Year');
  dmSTK.btOCH.FieldByName('DocNum').AsString := oTxtDoc.ReadString ('DocNum');
  dmSTK.btOCH.FieldByName('ExtNum').AsString := oTxtDoc.ReadString ('ExtNum');
  dmSTK.btOCH.FieldByName('DocDate').AsDateTime := oTxtDoc.ReadDate ('DocDate');
  dmSTK.btOCH.FieldByName('ExpDate').AsDateTime := oTxtDoc.ReadDate ('ExpDate');
  dmSTK.btOCH.FieldByName('DlvDate').AsDateTime := oTxtDoc.ReadDate ('DlvDate');
  dmSTK.btOCH.FieldByName('StkNum').AsInteger := oTxtDoc.ReadInteger ('StkNum');
  dmSTK.btOCH.FieldByName('PaCode').AsInteger := oTxtDoc.ReadInteger ('PaCode');
  dmSTK.btOCH.FieldByName('PaName').AsString := oTxtDoc.ReadString ('PaName');
  dmSTK.btOCH.FieldByName('RegName').AsString := oTxtDoc.ReadString ('RegName');
  dmSTK.btOCH.FieldByName('RegIno').AsString := oTxtDoc.ReadString ('RegIno');
  dmSTK.btOCH.FieldByName('RegTin').AsString := oTxtDoc.ReadString ('RegTin');
  dmSTK.btOCH.FieldByName('RegVin').AsString := oTxtDoc.ReadString ('RegVin');
  dmSTK.btOCH.FieldByName('RegAddr').AsString := oTxtDoc.ReadString ('RegAddr');
  dmSTK.btOCH.FieldByName('RegSta').AsString := oTxtDoc.ReadString ('RegSta');
  dmSTK.btOCH.FieldByName('RegCty').AsString := oTxtDoc.ReadString ('RegCty');
  dmSTK.btOCH.FieldByName('RegCtn').AsString := oTxtDoc.ReadString ('RegCtn');
  dmSTK.btOCH.FieldByName('RegZip').AsString := oTxtDoc.ReadString ('RegZip');
  dmSTK.btOCH.FieldByName('IcFacDay').AsInteger := oTxtDoc.ReadInteger ('IcFacDay');
  dmSTK.btOCH.FieldByName('IcFacPrc').AsFloat := oTxtDoc.ReadInteger ('IcFacPrc');
  dmSTK.btOCH.FieldByName('PayCode').AsString := oTxtDoc.ReadString ('PayCode');
  dmSTK.btOCH.FieldByName('PayName').AsString := oTxtDoc.ReadString ('PayName');
  dmSTK.btOCH.FieldByName('SpaCode').AsInteger := oTxtDoc.ReadInteger ('SpaCode');
  dmSTK.btOCH.FieldByName('WpaCode').AsInteger := oTxtDoc.ReadInteger ('WpaCode');
  dmSTK.btOCH.FieldByName('WpaName').AsString := oTxtDoc.ReadString ('WpaName');
  dmSTK.btOCH.FieldByName('WpaAddr').AsString := oTxtDoc.ReadString ('WpaAddr');
  dmSTK.btOCH.FieldByName('WpaSta').AsString := oTxtDoc.ReadString ('WpaSta');
  dmSTK.btOCH.FieldByName('WpaCty').AsString := oTxtDoc.ReadString ('WpaCty');
  dmSTK.btOCH.FieldByName('WpaCtn').AsString := oTxtDoc.ReadString ('WpaCtn');
  dmSTK.btOCH.FieldByName('WpaZip').AsString := oTxtDoc.ReadString ('WpaZip');
  dmSTK.btOCH.FieldByName('TrsCode').AsString := oTxtDoc.ReadString ('TrsCode');
  dmSTK.btOCH.FieldByName('TrsName').AsString := oTxtDoc.ReadString ('TrsName');
  dmSTK.btOCH.FieldByName('RspName').AsString := oTxtDoc.ReadString ('RspName');
  dmSTK.btOCH.FieldByName('PlsNum').AsInteger := oTxtDoc.ReadInteger ('PlsNum');
  dmSTK.btOCH.FieldByName('PrfPrc').AsFloat := oTxtDoc.ReadInteger ('PrfPrc');
  dmSTK.btOCH.FieldByName('VatPrc1').AsInteger := oTxtDoc.ReadInteger ('VatPrc1');
  dmSTK.btOCH.FieldByName('VatPrc2').AsInteger := oTxtDoc.ReadInteger ('VatPrc2');
  dmSTK.btOCH.FieldByName('VatPrc3').AsInteger := oTxtDoc.ReadInteger ('VatPrc3');
  dmSTK.btOCH.FieldByName('AcDvzName').AsString := oTxtDoc.ReadString ('AcDvzName');
  dmSTK.btOCH.FieldByName('AcPValue').AsFloat := oTxtDoc.ReadInteger ('AcPValue');
  dmSTK.btOCH.FieldByName('AcMValue').AsFloat := oTxtDoc.ReadInteger ('AcMValue');
  dmSTK.btOCH.FieldByName('AcWValue').AsFloat := oTxtDoc.ReadInteger ('AcWValue');
  dmSTK.btOCH.FieldByName('AcOValue').AsFloat := oTxtDoc.ReadInteger ('AcOValue');
  dmSTK.btOCH.FieldByName('FgDvzName').AsString := oTxtDoc.ReadString ('FgDvzName');
  dmSTK.btOCH.FieldByName('FgCourse').AsFloat := oTxtDoc.ReadInteger ('FgCourse');
  dmSTK.btOCH.FieldByName('FgPValue').AsFloat := oTxtDoc.ReadInteger ('FgPValue');
  dmSTK.btOCH.FieldByName('PValPay').AsString := oTxtDoc.ReadString ('PValPay');
  dmSTK.btOCH.FieldByName('DlrCode').AsInteger := oTxtDoc.ReadInteger ('DlrCode');
  dmSTK.btOCH.FieldByName('CusCard').AsString := oTxtDoc.ReadString ('CusCard');
  dmSTK.btOCH.FieldByName('VatDoc').AsInteger := oTxtDoc.ReadInteger ('VatDoc');
  dmSTK.btOCH.FieldByName('PrnCnt').AsInteger := oTxtDoc.ReadInteger ('PrnCnt');
  dmSTK.btOCH.FieldByName('ItmQnt').AsInteger := oTxtDoc.ReadInteger ('ItmQnt');
  dmSTK.btOCH.FieldByName('DstLck').AsInteger := oTxtDoc.ReadInteger ('DstLck');
  dmSTK.btOCH.FieldByName('DstCls').AsInteger := oTxtDoc.ReadInteger ('DstCls');
  dmSTK.btOCH.FieldByName('CrtUser').AsString := oTxtDoc.ReadString ('CrtUser');
  dmSTK.btOCH.FieldByName('CrtDate').AsDateTime := oTxtDoc.ReadDate ('CrtDate');
  dmSTK.btOCH.FieldByName('ModUser').AsString := oTxtDoc.ReadString ('ModUser');
  dmSTK.btOCH.FieldByName('ModDate').AsDateTime := oTxtDoc.ReadDate ('ModDate');
  dmSTK.btOCH.Post;
end;

procedure TOcdTxt.LoadTxtToTmp; // Nacita poloky z prenosoveho suboru do docasneh databaze ptTCI
begin
  If oTxtDoc.ItemCount>0 then begin
    // Ulozime polozky do docasneho suboru
    oTxtDoc.First;
    Repeat
      If not dmSTK.ptOCI.FindKey([oTxtDoc.ReadInteger ('ItmNum')]) then begin
        dmSTK.ptOCI.Insert;
        dmSTK.ptOCI.FieldByName('DocNum').AsString := dmSTK.btOCH.FieldByName('DocNum').AsString;
        dmSTK.ptOCI.FieldByName('ItmNum').AsInteger := oTxtDoc.ReadInteger ('ItmNum');
        dmSTK.ptOCI.FieldByName('RowNum').AsInteger := dmSTK.ptOCI.RecordCount+1;
        dmSTK.ptOCI.FieldByName('MgCode').AsInteger := oTxtDoc.ReadInteger ('MgCode');
        dmSTK.ptOCI.FieldByName('GsCode').AsInteger := oTxtDoc.ReadInteger ('GsCode');
        dmSTK.ptOCI.FieldByName('GsName').AsString := oTxtDoc.ReadString ('GsName');
        dmSTK.ptOCI.FieldByName('BarCode').AsString := oTxtDoc.ReadString ('BarCode');
        dmSTK.ptOCI.FieldByName('StkCode').AsString := oTxtDoc.ReadString ('StkCode');
        dmSTK.ptOCI.FieldByName('StkNum').AsInteger := oTxtDoc.ReadInteger ('StkNum');
        dmSTK.ptOCI.FieldByName('Notice').AsString := oTxtDoc.ReadString ('Notice');
        dmSTK.ptOCI.FieldByName('Volume').AsFloat := oTxtDoc.ReadFloat ('Volume');
        dmSTK.ptOCI.FieldByName('Weight').AsFloat := oTxtDoc.ReadFloat ('Weight');
        dmSTK.ptOCI.FieldByName('PackGs').AsInteger := oTxtDoc.ReadInteger ('PackGs');
        dmSTK.ptOCI.FieldByName('GsType').AsString := oTxtDoc.ReadString ('GsType');
        dmSTK.ptOCI.FieldByName('MsName').AsString := oTxtDoc.ReadString ('MsName');
        dmSTK.ptOCI.FieldByName('OrdQnt').AsFloat := oTxtDoc.ReadFloat ('OrdQnt');
        dmSTK.ptOCI.FieldByName('VatPrc').AsInteger := oTxtDoc.ReadInteger ('VatPrc');
        dmSTK.ptOCI.FieldByName('DscPrc').AsFloat := oTxtDoc.ReadFloat ('DscPrc');
        dmSTK.ptOCI.FieldByName('AcCValue').AsFloat := oTxtDoc.ReadFloat ('AcCValue');
        dmSTK.ptOCI.FieldByName('AcDValue').AsFloat := oTxtDoc.ReadFloat ('AcDValue');
        dmSTK.ptOCI.FieldByName('AcDscVal').AsFloat := oTxtDoc.ReadFloat ('AcDscVal');
        dmSTK.ptOCI.FieldByName('AcAValue').AsFloat := oTxtDoc.ReadFloat ('AcAValue');
        dmSTK.ptOCI.FieldByName('AcBValue').AsFloat := oTxtDoc.ReadFloat ('AcBValue');
        dmSTK.ptOCI.FieldByName('FgCPrice').AsFloat := oTxtDoc.ReadFloat ('FgCPrice');
        dmSTK.ptOCI.FieldByName('FgDPrice').AsFloat := oTxtDoc.ReadFloat ('FgDPrice');
        dmSTK.ptOCI.FieldByName('FgAPrice').AsFloat := oTxtDoc.ReadFloat ('FgAPrice');
        dmSTK.ptOCI.FieldByName('FgBPrice').AsFloat := oTxtDoc.ReadFloat ('FgBPrice');
        dmSTK.ptOCI.FieldByName('FgCValue').AsFloat := oTxtDoc.ReadFloat ('FgCValue');
        dmSTK.ptOCI.FieldByName('FgDValue').AsFloat := oTxtDoc.ReadFloat ('FgDValue');
        dmSTK.ptOCI.FieldByName('FgDscVal').AsFloat := oTxtDoc.ReadFloat ('FgDscVal');
        dmSTK.ptOCI.FieldByName('FgAValue').AsFloat := oTxtDoc.ReadFloat ('FgAValue');
        dmSTK.ptOCI.FieldByName('FgBValue').AsFloat := oTxtDoc.ReadFloat ('FgBValue');
        dmSTK.ptOCI.FieldByName('DlrCode').AsInteger := dmSTK.btOCH.FieldByName('DlrCode').AsInteger;
        dmSTK.ptOCI.FieldByName('DocDate').AsDateTime := dmSTK.btOCH.FieldByName('DocDate').AsDateTime;
        dmSTK.ptOCI.FieldByName('ExpDate').AsDateTime := dmSTK.btOCH.FieldByName('ExpDate').AsDateTime;
        dmSTK.ptOCI.FieldByName('DlvDate').AsDateTime := dmSTK.btOCH.FieldByName('DlvDate').AsDateTime;
        dmSTK.ptOCI.FieldByName('PaCode').AsInteger := dmSTK.btOCH.FieldByName('PaCode').AsInteger;
        dmSTK.ptOCI.FieldByName('McdNum').AsString := oTxtDoc.ReadString ('McdNum');
        dmSTK.ptOCI.FieldByName('McdItm').AsInteger := oTxtDoc.ReadInteger ('McdItm');
        dmSTK.ptOCI.FieldByName('TcdNum').AsString := oTxtDoc.ReadString ('TcdNum');
        dmSTK.ptOCI.FieldByName('TcdItm').AsInteger := oTxtDoc.ReadInteger ('TcdItm');
        dmSTK.ptOCI.FieldByName('TcdDate').AsDateTime := oTxtDoc.ReadDate ('TcdDate');
        dmSTK.ptOCI.FieldByName('IcdNum').AsString := oTxtDoc.ReadString ('IcdNum');
        dmSTK.ptOCI.FieldByName('IcdItm').AsInteger := oTxtDoc.ReadInteger ('IcdItm');
        dmSTK.ptOCI.FieldByName('IcdDate').AsDateTime := oTxtDoc.ReadDate ('IcdDate');
        dmSTK.ptOCI.FieldByName('StkStat').AsString := oTxtDoc.ReadString ('StkStat');
        dmSTK.ptOCI.FieldByName('FinStat').AsString := oTxtDoc.ReadString ('FinStat');
        dmSTK.ptOCI.FieldByName('Action').AsString := oTxtDoc.ReadString ('Action');
        dmSTK.ptOCI.FieldByName('CrtUser').AsString := oTxtDoc.ReadString ('CrtUser');
        dmSTK.ptOCI.FieldByName('CrtDate').AsDateTime := oTxtDoc.ReadDate ('CrtDate');
        dmSTK.ptOCI.FieldByName('CrtTime').AsDateTime := oTxtDoc.ReadTime ('CrtTime');
        dmSTK.ptOCI.FieldByName('ModUser').AsString := oTxtDoc.ReadString ('ModUser');
        dmSTK.ptOCI.FieldByName('ModDate').AsDateTime := oTxtDoc.ReadDate ('ModDate');
        dmSTK.ptOCI.FieldByName('ModTime').AsDateTime := oTxtDoc.ReadTime ('ModTime');
        dmSTK.ptOCI.Post;
      end;
      Application.ProcessMessages;
      oTxtDoc.Next;
    until oTxtDoc.Eof;
  end;
end;

procedure TOcdTxt.LoadTxtToOcn; // Nacita poloky z prenosoveho suboru do docasneh databaze ptTCI
begin
end;

procedure TOcdTxt.DeleteOci; // Vymaze polozky doacieho listu, ktore nie su v docasnej databaze
begin
  If dmSTK.btOCI.IndexName<>'DocNum' then dmSTK.btOCI.IndexName:='DocNum';
  If dmSTK.btOCI.FindKey ([oDocNum]) then begin
    Repeat
      Application.ProcessMessages;
      If dmSTK.ptOCI.FindKey ([dmSTK.btOCI.FieldByName('ItmNum').AsInteger]) then begin
        dmSTK.btOCI.Delete; // Zrusime polozku ZK
      end
      else dmSTK.btOCI.Next;
    until (dmSTK.btOCI.Eof) or (dmSTK.btOCI.RecordCount=0) or (dmSTK.btOCI.FieldByName('DocNum').AsString<>oDocNum);
  end;
end;

procedure TOcdTxt.AddNewItmToOci; // Prida nove polozky do ZK
begin
  dmSTK.btOCI.Modify := FALSE;
  dmSTK.btOCI.IndexName:='DoIt';
  dmSTK.ptOCI.First;
  Repeat
    If not dmSTK.btOCI.FindKey ([oDocNum,dmSTK.ptOCI.FieldByName('ItmNum').AsInteger]) then begin
      dmSTK.btOCI.Insert;
      PX_To_BTR (dmSTK.ptOCI,dmSTK.btOCI);
      dmSTK.btOCI.Post;
    end
    else begin  // Ak bola zmenena len cena vykoname zmenu
    end;
    Application.ProcessMessages;
    dmSTK.ptOCI.Next;
  until (dmSTK.ptOCI.Eof);
  dmSTK.btOCI.Modify := TRUE;
end;

end.
