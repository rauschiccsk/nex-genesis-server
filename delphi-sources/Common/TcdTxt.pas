unit TcdTxt;
{$F+}

interface

uses
  IcTypes, IcConv, IcTools, IcVariab, IniFiles, SysUtils, NexGlob,
  NexPath, NexIni, TxtWrap, TxtCut, StkCanc, DocHand, TxtDoc, Forms;

type
  TTcdTxt = class
    constructor Create;
    destructor  Destroy;
    private
      oDocNum: Str12; // Cislo dokladu ktorym pracujeme
      function LoadTxtToTch:boolean; // Nacita udaje z prenosoveho suboru a vytvori alebo opravy hlavicku dodacieho listu
      procedure LoadTxtToTmp; // Nacita poloky z prenosoveho suboru do docasneh databaze ptTCI
      procedure LoadTxtToTcn; // Nacita poloky z prenosoveho suboru do docasneh databaze ptTCI
      procedure DeleteTci; // Vymaze polozky doacieho listu, ktore nie su v docasnej databaze
      procedure AddNewItmToTci; // Prida nove polozky do dodacieho listu
    public
      oCount:word;
      oSndPath: ShortString; // Adresar kam bude ulozeny doklad
      oRcvPath: ShortString; // Adresar odkial bude nacitany doklad
      oStkStat: Str1;  // Stav polozky - ak je prazdny prenesie tak ako je na zdrojovom doklade
      oTxtDoc: TTxtDoc;
      procedure SaveToFile (pDocNum:Str12);  // Ulozi zadany doklad do textoveho suboru
      procedure LoadFromFile (pDocNum:Str12);  // Nacita doklad z textoveho suboru
    published
      property Count:word read oCount;
      property SndPath: ShortString write oSndPath;
      property RcvPath: ShortString write oRcvPath;
      property StkStat: Str1 write oStkStat;
  end;

implementation

uses
   DM_STKDAT, DB;

constructor TTcdTxt.Create;
begin
  oStkStat := '';
  oSndPath := gIni.GetZipPath; // Adresar kam bude ulozeny doklad
  oRcvPath := gIni.GetZipPath; // Adresar odkial bude nacitany doklad
end;

destructor TTcdTxt.Destroy;
begin
end;

procedure TTcdTxt.SaveToFile (pDocNum:Str12);  // Ulozi zadany doklad do textoveho suboru
var mFileName:string;  mPdnQnt:word;   mWrap:TTxtWrap;
begin
  mFileName := oSndPath+pDocNum+'.TXT';
  oTxtDoc := TTxtDoc.Create;
  If FileExists (mFileName) then DeleteFile (mFileName);
  oTxtDoc.WriteInteger ('FtpVer',1);
  oTxtDoc.WriteString ('PrgVer',cPrgVer);
  // Nezmenene polia - kompatibilne polia
  oTxtDoc.WriteInteger ('SerNum',dmSTK.btTCH.FieldByName('SerNum').AsInteger);
  oTxtDoc.WriteString ('DocNum',dmSTK.btTCH.FieldByName('DocNum').AsString);
  oTxtDoc.WriteString ('ExtNum',dmSTK.btTCH.FieldByName('ExtNum').AsString);
  oTxtDoc.WriteDate ('DocDate',dmSTK.btTCH.FieldByName('DocDate').AsDateTime);
  oTxtDoc.WriteInteger ('StkNum',dmSTK.btTCH.FieldByName('StkNum').AsInteger);
  oTxtDoc.WriteInteger ('PaCode',dmSTK.btTCH.FieldByName('PaCode').AsInteger);
  oTxtDoc.WriteString ('PaName',dmSTK.btTCH.FieldByName('PaName').AsString);
  // Nove polia od v 10.02
  oTxtDoc.WriteString ('OcdNum',dmSTK.btTCH.FieldByName('OcdNum').AsString);
  oTxtDoc.WriteDate ('DlvDate',dmSTK.btTCH.FieldByName('DlvDate').AsDateTime);
  oTxtDoc.WriteString ('RegName',dmSTK.btTCH.FieldByName('RegName').AsString);
  oTxtDoc.WriteString ('RegIno',dmSTK.btTCH.FieldByName('RegIno').AsString);
  oTxtDoc.WriteString ('RegTin',dmSTK.btTCH.FieldByName('RegTin').AsString);
  oTxtDoc.WriteString ('RegVin',dmSTK.btTCH.FieldByName('RegVin').AsString);
  oTxtDoc.WriteString ('RegAddr',dmSTK.btTCH.FieldByName('RegAddr').AsString);
  oTxtDoc.WriteString ('RegSta',dmSTK.btTCH.FieldByName('RegSta').AsString);
  oTxtDoc.WriteString ('RegCty',dmSTK.btTCH.FieldByName('RegCty').AsString);
  oTxtDoc.WriteString ('RegCtn',dmSTK.btTCH.FieldByName('RegCtn').AsString);
  oTxtDoc.WriteString ('RegZip',dmSTK.btTCH.FieldByName('RegZip').AsString);
  oTxtDoc.WriteInteger ('IcFacDay',dmSTK.btTCH.FieldByName('IcFacDay').AsInteger);
  oTxtDoc.WriteFloat ('IcFacPrc',dmSTK.btTCH.FieldByName('IcFacPrc').AsFloat);
  oTxtDoc.WriteString ('PayCode',dmSTK.btTCH.FieldByName('PayCode').AsString);
  oTxtDoc.WriteString ('PayName',dmSTK.btTCH.FieldByName('PayName').AsString);
  oTxtDoc.WriteInteger ('SpaCode',dmSTK.btTCH.FieldByName('SpaCode').AsInteger);
  oTxtDoc.WriteInteger ('WpaCode',dmSTK.btTCH.FieldByName('WpaCode').AsInteger);
  oTxtDoc.WriteString ('WpaName',dmSTK.btTCH.FieldByName('WpaName').AsString);
  oTxtDoc.WriteString ('WpaAddr',dmSTK.btTCH.FieldByName('WpaAddr').AsString);
  oTxtDoc.WriteString ('WpaSta',dmSTK.btTCH.FieldByName('WpaSta').AsString);
  oTxtDoc.WriteString ('WpaCty',dmSTK.btTCH.FieldByName('WpaCty').AsString);
  oTxtDoc.WriteString ('WpaCtn',dmSTK.btTCH.FieldByName('WpaCtn').AsString);
  oTxtDoc.WriteString ('WpaZip',dmSTK.btTCH.FieldByName('WpaZip').AsString);
  oTxtDoc.WriteString ('TrsCode',dmSTK.btTCH.FieldByName('TrsCode').AsString);
  oTxtDoc.WriteString ('TrsName',dmSTK.btTCH.FieldByName('TrsName').AsString);
  oTxtDoc.WriteString ('RspName',dmSTK.btTCH.FieldByName('RspName').AsString);
  oTxtDoc.WriteInteger ('PlsNum',dmSTK.btTCH.FieldByName('PlsNum').AsInteger);
  oTxtDoc.WriteInteger ('SmCode',dmSTK.btTCH.FieldByName('SmCode').AsInteger);
  oTxtDoc.WriteInteger ('VatPrc1',dmSTK.btTCH.FieldByName('VatPrc1').AsInteger);
  oTxtDoc.WriteInteger ('VatPrc2',dmSTK.btTCH.FieldByName('VatPrc2').AsInteger);
  oTxtDoc.WriteInteger ('VatPrc3',dmSTK.btTCH.FieldByName('VatPrc3').AsInteger);
  oTxtDoc.WriteString ('AcDvzName',dmSTK.btTCH.FieldByName('AcDvzName').AsString);
  oTxtDoc.WriteString ('FgDvzName',dmSTK.btTCH.FieldByName('FgDvzName').AsString);
  oTxtDoc.WriteFloat ('FgCourse',dmSTK.btTCH.FieldByName('FgCourse').AsFloat);
  oTxtDoc.WriteFloat ('Volume',dmSTK.btTCH.FieldByName('Volume').AsFloat);
  oTxtDoc.WriteFloat ('Weight',dmSTK.btTCH.FieldByName('Weight').AsFloat);
  oTxtDoc.WriteString ('RcvName',dmSTK.btTCH.FieldByName('RcvName').AsString);
  oTxtDoc.WriteString ('RcvCode',dmSTK.btTCH.FieldByName('RcvCode').AsString);
  oTxtDoc.WriteInteger ('DlrCode',dmSTK.btTCH.FieldByName('DlrCode').AsInteger);
  oTxtDoc.WriteString ('CusCard',dmSTK.btTCH.FieldByName('CusCard').AsString);
  oTxtDoc.WriteInteger ('VatDoc',dmSTK.btTCH.FieldByName('VatDoc').AsInteger);
  oTxtDoc.WriteInteger ('PrnCnt',dmSTK.btTCH.FieldByName('PrnCnt').AsInteger);
  oTxtDoc.WriteString ('DstPair',dmSTK.btTCH.FieldByName('DstPair').AsString);
  oTxtDoc.WriteInteger ('DstLck',dmSTK.btTCH.FieldByName('DstLck').AsInteger);
  oTxtDoc.WriteInteger ('DstCls',dmSTK.btTCH.FieldByName('DstCls').AsInteger);
  oTxtDoc.WriteString ('CrtUser',dmSTK.btTCH.FieldByName('CrtUser').AsString);
  oTxtDoc.WriteDate ('CrtDate',dmSTK.btTCH.FieldByName('CrtDate').AsDateTime);
  oTxtDoc.WriteTime ('CrtTime',dmSTK.btTCH.FieldByName('CrtTime').AsDateTime);
  oTxtDoc.WriteString ('ModUser',dmSTK.btTCH.FieldByName('ModUser').AsString);
  oTxtDoc.WriteDate ('ModDate',dmSTK.btTCH.FieldByName('ModDate').AsDateTime);
  oTxtDoc.WriteTime ('ModTime',dmSTK.btTCH.FieldByName('ModTime').AsDateTime);
  oTxtDoc.WriteFloat ('FgDBValue',dmSTK.btTCH.FieldByName('FgDBValue').AsFloat);
  oTxtDoc.WriteFloat ('FgDscBVal',dmSTK.btTCH.FieldByName('FgDscBVal').AsFloat);
  oTxtDoc.WriteString ('Year',dmSTK.btTCH.FieldByName('Year').AsString);
  // Ulozime vyrobne cisla
  mPdnQnt := 0;
  If dmSTK.btTCP.IndexName<>'DoIt' then dmSTK.btTCP.IndexName := 'DoIt';
  dmSTK.btTCP.FindNearest ([pDocNum,0]);
  If dmSTK.btTCP.FieldByName ('DocNum').AsString=dmSTK.btTCH.FieldByName ('DocNum').AsString then begin
    mWrap := TTxtWrap.Create;
    mWrap.SetDelimiter('');
    Repeat
      Inc (mPdnQnt);
      mWrap.ClearWrap;
      mWrap.SetNum(dmSTK.btTCP.FieldByName('ItmNum').AsInteger,0);
      mWrap.SetNum(dmSTK.btTCP.FieldByName('GsCode').AsInteger,0);
      mWrap.SetText(dmSTK.btTCP.FieldByName('ProdNum').AsString,0);
      mWrap.SetNum(dmSTK.btTCP.FieldByName('StkNum').AsInteger,0);
      oTxtDoc.WriteString ('ProdNum'+StrInt(mPdnQnt,0),mWrap.GetWrapText);
      Application.ProcessMessages;
      dmSTK.btTCP.Next;
    until (dmSTK.btTCP.Eof) or (dmSTK.btTCP.FieldByName('DocNum').AsString<>pDocNum);
    FreeAndNil (mWrap);
  end;
  oTxtDoc.WriteInteger ('PdnQnt',mPdnQnt);
  // Ulozime poloziek dokladu
  If dmSTK.btTCI.IndexName<>'DoIt' then dmSTK.btTCI.IndexName := 'DoIt';
  dmSTK.btTCI.FindNearest ([pDocNum,0]);
  If dmSTK.btTCI.FieldByName ('DocNum').AsString=dmSTK.btTCH.FieldByName ('DocNum').AsString then begin
    Repeat
      oTxtDoc.Insert;
      // Nezmenene polia - kompatibilne polia
      oTxtDoc.WriteInteger ('ItmNum',dmSTK.btTCI.FieldByName('ItmNum').AsInteger);
      oTxtDoc.WriteInteger ('MgCode',dmSTK.btTCI.FieldByName('MgCode').AsInteger);
      oTxtDoc.WriteInteger ('GsCode',dmSTK.btTCI.FieldByName('GsCode').AsInteger);
      oTxtDoc.WriteString ('GsName',dmSTK.btTCI.FieldByName('GsName').AsString);
      oTxtDoc.WriteString ('BarCode',dmSTK.btTCI.FieldByName('BarCode').AsString);
      oTxtDoc.WriteString ('StkCode',dmSTK.btTCI.FieldByName('StkCode').AsString);
      oTxtDoc.WriteInteger ('StkNum',dmSTK.btTCI.FieldByName('StkNum').AsInteger);
      // Nove polia od v 10.02
      oTxtDoc.WriteString ('Notice',dmSTK.btTCI.FieldByName('Notice').AsString);
      oTxtDoc.WriteFloat ('Volume',dmSTK.btTCI.FieldByName('Volume').AsFloat);
      oTxtDoc.WriteFloat ('Weight',dmSTK.btTCI.FieldByName('Weight').AsFloat);
      oTxtDoc.WriteInteger ('PackGs',dmSTK.btTCI.FieldByName('PackGs').AsInteger);
      oTxtDoc.WriteString ('GsType',dmSTK.btTCI.FieldByName('GsType').AsString);
      oTxtDoc.WriteString ('MsName',dmSTK.btTCI.FieldByName('MsName').AsString);
      oTxtDoc.WriteFloat ('GsQnt',dmSTK.btTCI.FieldByName('GsQnt').AsFloat);
      oTxtDoc.WriteInteger ('VatPrc',Round(dmSTK.btTCI.FieldByName('VatPrc').AsFloat));
      oTxtDoc.WriteFloat ('DscPrc',dmSTK.btTCI.FieldByName('DscPrc').AsFloat);
      oTxtDoc.WriteFloat ('AcCValue',dmSTK.btTCI.FieldByName('AcCValue').AsFloat);
      oTxtDoc.WriteFloat ('AcDValue',dmSTK.btTCI.FieldByName('AcDValue').AsFloat);
      oTxtDoc.WriteFloat ('AcDscVal',dmSTK.btTCI.FieldByName('AcDscVal').AsFloat);
      oTxtDoc.WriteFloat ('AcAValue',dmSTK.btTCI.FieldByName('AcAValue').AsFloat);
      oTxtDoc.WriteFloat ('AcBValue',dmSTK.btTCI.FieldByName('AcBValue').AsFloat);
      oTxtDoc.WriteFloat ('FgCPrice',dmSTK.btTCI.FieldByName('FgCPrice').AsFloat);
      oTxtDoc.WriteFloat ('FgDPrice',dmSTK.btTCI.FieldByName('FgDPrice').AsFloat);
      oTxtDoc.WriteFloat ('FgAPrice',dmSTK.btTCI.FieldByName('FgAPrice').AsFloat);
      oTxtDoc.WriteFloat ('FgBPrice',dmSTK.btTCI.FieldByName('FgBPrice').AsFloat);
      oTxtDoc.WriteFloat ('FgCValue',dmSTK.btTCI.FieldByName('FgCValue').AsFloat);
      oTxtDoc.WriteFloat ('FgDValue',dmSTK.btTCI.FieldByName('FgDValue').AsFloat);
      oTxtDoc.WriteFloat ('FgDscVal',dmSTK.btTCI.FieldByName('FgDscVal').AsFloat);
      oTxtDoc.WriteFloat ('FgAValue',dmSTK.btTCI.FieldByName('FgAValue').AsFloat);
      oTxtDoc.WriteFloat ('FgBValue',dmSTK.btTCI.FieldByName('FgBValue').AsFloat);
      oTxtDoc.WriteString ('DlvUser',dmSTK.btTCI.FieldByName('DlvUser').AsString);
      oTxtDoc.WriteString ('McdNum',dmSTK.btTCI.FieldByName('McdNum').AsString);
      oTxtDoc.WriteInteger ('McdItm',dmSTK.btTCI.FieldByName('McdItm').AsInteger);
      oTxtDoc.WriteString ('OcdNum',dmSTK.btTCI.FieldByName('OcdNum').AsString);
      oTxtDoc.WriteInteger ('OcdItm',dmSTK.btTCI.FieldByName('OcdItm').AsInteger);
      oTxtDoc.WriteString ('IcdNum',dmSTK.btTCI.FieldByName('IcdNum').AsString);
      oTxtDoc.WriteInteger ('IcdItm',dmSTK.btTCI.FieldByName('IcdItm').AsInteger);
      oTxtDoc.WriteDate ('IcdDate',dmSTK.btTCI.FieldByName('IcdDate').AsDateTime);
      If oStkStat=''
        then oTxtDoc.WriteString ('StkStat',dmSTK.btTCI.FieldByName('StkStat').AsString)
        else oTxtDoc.WriteString ('StkStat',oStkStat);
      oTxtDoc.WriteString ('FinStat',dmSTK.btTCI.FieldByName('FinStat').AsString);
      oTxtDoc.WriteString ('Action',dmSTK.btTCI.FieldByName('Action').AsString);
      oTxtDoc.WriteString ('CrtUser',dmSTK.btTCI.FieldByName('CrtUser').AsString);
      oTxtDoc.WriteDate ('CrtDate',dmSTK.btTCI.FieldByName('CrtDate').AsDateTime);
      oTxtDoc.WriteTime ('CrtTime',dmSTK.btTCI.FieldByName('CrtTime').AsDateTime);
      oTxtDoc.WriteString ('ModUser',dmSTK.btTCI.FieldByName('ModUser').AsString);
      oTxtDoc.WriteDate ('ModDate',dmSTK.btTCI.FieldByName('ModDate').AsDateTime);
      oTxtDoc.WriteTime ('ModTime',dmSTK.btTCI.FieldByName('ModTime').AsDateTime);
      oTxtDoc.Post;
      Application.ProcessMessages;
      dmSTK.btTCI.Next;
    until (dmSTK.btTCI.Eof) or (dmSTK.btTCI.FieldByName('DocNum').AsString<>pDocNum);
{
    // Ulozime poznamky dokladu
    If dmSTK.btTCN.IndexName<>'DoNtLn' then dmSTK.btTCN.IndexName:='DoNtLn';
    dmSTK.btTCN.FindNearest ([pDocNum,'',0]);
    If dmSTK.btTCN.FieldByName ('DocNum').AsString=dmSTK.btTCH.FieldByName ('DocNum').AsString then begin
      mLine := 0;
      Repeat
        Inc (mLine);
        oFile.WriteString ('NOTICES','Line'+StrInt(mLine,0),dmSTK.btTCN.FieldByName('Notice').AsString);
      until (dmSTK.btTCN.Eof) or (dmSTK.btTCN.FieldByName('DocNum').AsString<>pDocNum);
    end;
}
  end;
  oTxtDoc.SaveToFile (mFileName);
  FreeAndNil (oTxtDoc);
end;

procedure TTcdTxt.LoadFromFile (pDocNum:Str12);  // Nacita doklad z textoveho suboru
var mFileName:string;
begin
  oDocNum := pDocNum;
  mFileName := oRcvPath+pDocNum+'.TXT';
  If FileExists (mFileName) then begin
    oTxtDoc := TTxtDoc.Create;
    oTxtDoc.LoadFromFile (mFileName);
    If LoadTxtToTch then begin // Nacita udaje z prenosoveho suboru a vytvori alebo opravy hlavicku dodacieho listu
      If dmSTK.btTCH.FieldByName('ItmQnt').AsInteger>0 then begin  // Ak doklad ma polozky
        // Polozky dokladu
        dmSTK.ptTCI.Open;
        dmSTK.ptTCI.IndexName := 'ItmNum';
        LoadTxtToTmp; // Nacita poloky z prenosoveho suboru do docasneh databaze ptTCI
        DeleteTci; // Vymaze polozky doacieho listu, ktore nie su v docasnej databaze
        AddNewItmToTci; // Prida nove polozky do dodacieho listu
        dmSTK.ptTCI.Close;
        TchRecalc (dmSTK.btTCH,dmSTK.btTCI);  // Prepocita hlavicku zadaneho dodacieho listu podla jeho poloziek
      end;
      // Poznamky k dokladu
    end;
    FreeAndNil (oTxtDoc);
    DeleteFile (mFileName);
  end;
end;

function TTcdTxt.LoadTxtToTch:boolean; // Nacita udaje z prenosoveho suboru a vytvori alebo opravy hlavicku dodacieho listu
var mFind:boolean;
begin
  Result := TRUE;
  If dmSTK.btTCH.IndexName<>'DocNum' then dmSTK.btTCH.IndexName:='DocNum';
  mFind := dmSTK.btTCH.FindKey ([oDocNum]);
  If mFind then Result := dmSTK.btTCH.FieldByName('DstAcc').AsString<>'A';
  If Result then begin // Ak nie je zauctovany
    If mFind
      then dmSTK.btTCH.Edit // Uprava hlavicky dokladu
      else dmSTK.btTCH.Insert;  // Novy doklad
    dmSTK.btTCH.FieldByName('SerNum').AsInteger := oTxtDoc.ReadInteger ('SerNum');
    dmSTK.btTCH.FieldByName('Year').AsString := oTxtDoc.ReadString ('Year');
    dmSTK.btTCH.FieldByName('DocNum').AsString := oTxtDoc.ReadString ('DocNum');
    dmSTK.btTCH.FieldByName('ExtNum').AsString := oTxtDoc.ReadString ('ExtNum');
    dmSTK.btTCH.FieldByName('OcdNum').AsString := oTxtDoc.ReadString ('OcdNum');
    dmSTK.btTCH.FieldByName('DocDate').AsDateTime := oTxtDoc.ReadDate ('DocDate');
    dmSTK.btTCH.FieldByName('DlvDate').AsDateTime := oTxtDoc.ReadDate ('DlvDate');
    dmSTK.btTCH.FieldByName('StkNum').AsInteger := oTxtDoc.ReadInteger ('StkNum');
    dmSTK.btTCH.FieldByName('PaCode').AsInteger := oTxtDoc.ReadInteger ('PaCode');
    dmSTK.btTCH.FieldByName('PaName').AsString := oTxtDoc.ReadString ('PaName');
    dmSTK.btTCH.FieldByName('RegName').AsString := oTxtDoc.ReadString ('RegName');
    dmSTK.btTCH.FieldByName('RegIno').AsString := oTxtDoc.ReadString ('RegIno');
    dmSTK.btTCH.FieldByName('RegTin').AsString := oTxtDoc.ReadString ('RegTin');
    dmSTK.btTCH.FieldByName('RegVin').AsString := oTxtDoc.ReadString ('RegVin');
    dmSTK.btTCH.FieldByName('RegAddr').AsString := oTxtDoc.ReadString ('RegAddr');
    dmSTK.btTCH.FieldByName('RegSta').AsString := oTxtDoc.ReadString ('RegSta');
    dmSTK.btTCH.FieldByName('RegCty').AsString := oTxtDoc.ReadString ('RegCty');
    dmSTK.btTCH.FieldByName('RegCtn').AsString := oTxtDoc.ReadString ('RegCtn');
    dmSTK.btTCH.FieldByName('RegZip').AsString := oTxtDoc.ReadString ('RegZip');
    dmSTK.btTCH.FieldByName('IcFacDay').AsInteger := oTxtDoc.ReadInteger ('IcFacDay');
    dmSTK.btTCH.FieldByName('IcFacPrc').AsFloat := oTxtDoc.ReadFloat ('IcFacPrc');
    dmSTK.btTCH.FieldByName('PayCode').AsString := oTxtDoc.ReadString ('PayCode');
    dmSTK.btTCH.FieldByName('PayName').AsString := oTxtDoc.ReadString ('PayName');
    dmSTK.btTCH.FieldByName('SpaCode').AsInteger := oTxtDoc.ReadInteger ('SpaCode');
    dmSTK.btTCH.FieldByName('WpaCode').AsInteger := oTxtDoc.ReadInteger ('WpaCode');
    dmSTK.btTCH.FieldByName('WpaName').AsString := oTxtDoc.ReadString ('WpaName');
    dmSTK.btTCH.FieldByName('WpaAddr').AsString := oTxtDoc.ReadString ('WpaAddr');
    dmSTK.btTCH.FieldByName('WpaSta').AsString := oTxtDoc.ReadString ('WpaSta');
    dmSTK.btTCH.FieldByName('WpaCty').AsString := oTxtDoc.ReadString ('WpaCty');
    dmSTK.btTCH.FieldByName('WpaCtn').AsString := oTxtDoc.ReadString ('WpaCtn');
    dmSTK.btTCH.FieldByName('WpaZip').AsString := oTxtDoc.ReadString ('WpaZip');
    dmSTK.btTCH.FieldByName('TrsCode').AsString := oTxtDoc.ReadString ('TrsCode');
    dmSTK.btTCH.FieldByName('TrsName').AsString := oTxtDoc.ReadString ('TrsName');
    dmSTK.btTCH.FieldByName('RspName').AsString := oTxtDoc.ReadString ('RspName');
    dmSTK.btTCH.FieldByName('PlsNum').AsInteger := oTxtDoc.ReadInteger ('PlsNum');
    dmSTK.btTCH.FieldByName('SmCode').AsInteger := oTxtDoc.ReadInteger ('SmCode');
    dmSTK.btTCH.FieldByName('VatPrc1').AsInteger := oTxtDoc.ReadInteger ('VatPrc1');
    dmSTK.btTCH.FieldByName('VatPrc2').AsInteger := oTxtDoc.ReadInteger ('VatPrc2');
    dmSTK.btTCH.FieldByName('VatPrc3').AsInteger := oTxtDoc.ReadInteger ('VatPrc3');
    dmSTK.btTCH.FieldByName('AcDvzName').AsString := oTxtDoc.ReadString ('AcDvzName');
    dmSTK.btTCH.FieldByName('FgDvzName').AsString := oTxtDoc.ReadString ('FgDvzName');
    dmSTK.btTCH.FieldByName('FgCourse').AsFloat := oTxtDoc.ReadFloat ('FgCourse');
    dmSTK.btTCH.FieldByName('Volume').AsFloat := oTxtDoc.ReadFloat ('Volume');
    dmSTK.btTCH.FieldByName('Weight').AsFloat := oTxtDoc.ReadFloat ('Weight');
    dmSTK.btTCH.FieldByName('RcvName').AsString := oTxtDoc.ReadString ('RcvName');
    dmSTK.btTCH.FieldByName('RcvCode').AsString := oTxtDoc.ReadString ('RcvCode');
    dmSTK.btTCH.FieldByName('DlrCode').AsInteger := oTxtDoc.ReadInteger ('DlrCode');
    dmSTK.btTCH.FieldByName('CusCard').AsString := oTxtDoc.ReadString ('CusCard');
    dmSTK.btTCH.FieldByName('VatDoc').AsInteger := oTxtDoc.ReadInteger ('VatDoc');
    dmSTK.btTCH.FieldByName('PrnCnt').AsInteger := oTxtDoc.ReadInteger ('PrnCnt');
    dmSTK.btTCH.FieldByName('ItmQnt').AsInteger := oTxtDoc.ReadInteger ('ItmQnt');
    dmSTK.btTCH.FieldByName('DstPair').AsString := oTxtDoc.ReadString ('DstPair');
    dmSTK.btTCH.FieldByName('DstLck').AsInteger := oTxtDoc.ReadInteger ('DstLck');
    dmSTK.btTCH.FieldByName('DstCls').AsInteger := oTxtDoc.ReadInteger ('DstCls');
    dmSTK.btTCH.FieldByName('CrtUser').AsString := oTxtDoc.ReadString ('CrtUser');
    dmSTK.btTCH.FieldByName('CrtDate').AsDateTime := oTxtDoc.ReadDate ('CrtDate');
    dmSTK.btTCH.FieldByName('CrtTime').AsDateTime := oTxtDoc.ReadTime ('CrtTime');
    dmSTK.btTCH.FieldByName('ModUser').AsString := oTxtDoc.ReadString ('ModUser');
    dmSTK.btTCH.FieldByName('ModDate').AsDateTime := oTxtDoc.ReadDate ('ModDate');
    dmSTK.btTCH.FieldByName('ModTime').AsDateTime := oTxtDoc.ReadTime ('ModTime');
    dmSTK.btTCH.FieldByName('FgDBValue').AsFloat := oTxtDoc.ReadFloat ('FgDBValue');
    dmSTK.btTCH.FieldByName('FgDscBVal').AsFloat := oTxtDoc.ReadFloat ('FgDscBVal');
    dmSTK.btTCH.Post;
  end;
end;

procedure TTcdTxt.LoadTxtToTmp; // Nacita poloky z prenosoveho suboru do docasneh databaze ptTCI
begin
  // Ulozime polozky do docasneho suboru
  If oTxtDoc.ItemCount>0 then begin
    oTxtDoc.First;
    Repeat
      If not dmSTK.ptTCI.FindKey([oTxtDoc.ReadInteger ('ItmNum')]) then begin
        dmSTK.ptTCI.Insert;
        dmSTK.ptTCI.FieldByName('DocNum').AsString := dmSTK.btTCH.FieldByName('DocNum').AsString;
        dmSTK.ptTCI.FieldByName('ItmNum').AsInteger := oTxtDoc.ReadInteger ('ItmNum');
        dmSTK.ptTCI.FieldByName('RowNum').AsInteger := dmSTK.ptTCI.RecordCount+1;
        dmSTK.ptTCI.FieldByName('MgCode').AsInteger := oTxtDoc.ReadInteger ('MgCode');
        dmSTK.ptTCI.FieldByName('GsCode').AsInteger := oTxtDoc.ReadInteger ('GsCode');
        dmSTK.ptTCI.FieldByName('GsName').AsString := oTxtDoc.ReadString ('GsName');
        dmSTK.ptTCI.FieldByName('BarCode').AsString := oTxtDoc.ReadString ('BarCode');
        dmSTK.ptTCI.FieldByName('StkCode').AsString := oTxtDoc.ReadString ('StkCode');
        dmSTK.ptTCI.FieldByName('Notice').AsString := oTxtDoc.ReadString ('Notice');
        dmSTK.ptTCI.FieldByName('StkNum').AsInteger := oTxtDoc.ReadInteger ('StkNum');
        dmSTK.ptTCI.FieldByName('Volume').AsFloat := oTxtDoc.ReadFloat ('Volume');
        dmSTK.ptTCI.FieldByName('Weight').AsFloat := oTxtDoc.ReadFloat ('Weight');
        dmSTK.ptTCI.FieldByName('PackGs').AsInteger := oTxtDoc.ReadInteger ('PackGs');
        dmSTK.ptTCI.FieldByName('GsType').AsString := oTxtDoc.ReadString ('GsType');
        dmSTK.ptTCI.FieldByName('MsName').AsString := oTxtDoc.ReadString ('MsName');
        dmSTK.ptTCI.FieldByName('GsQnt').AsFloat := oTxtDoc.ReadFloat ('GsQnt');
        dmSTK.ptTCI.FieldByName('VatPrc').AsInteger := oTxtDoc.ReadInteger ('VatPrc');
        dmSTK.ptTCI.FieldByName('DscPrc').AsFloat := oTxtDoc.ReadFloat ('DscPrc');
        dmSTK.ptTCI.FieldByName('AcCValue').AsFloat := oTxtDoc.ReadFloat ('AcCValue');
//        dmSTK.ptTCI.FieldByName('AcDValue').AsFloat := oTxtDoc.ReadFloat ('AcDValue');
//        dmSTK.ptTCI.FieldByName('AcDscVal').AsFloat := oTxtDoc.ReadFloat ('AcDscVal');
        dmSTK.ptTCI.FieldByName('AcAValue').AsFloat := oTxtDoc.ReadFloat ('AcAValue');
        dmSTK.ptTCI.FieldByName('AcBValue').AsFloat := oTxtDoc.ReadFloat ('AcBValue');
        dmSTK.ptTCI.FieldByName('FgCPrice').AsFloat := oTxtDoc.ReadFloat ('FgCPrice');
        dmSTK.ptTCI.FieldByName('FgDPrice').AsFloat := oTxtDoc.ReadFloat ('FgDPrice');
        dmSTK.ptTCI.FieldByName('FgAPrice').AsFloat := oTxtDoc.ReadFloat ('FgAPrice');
        dmSTK.ptTCI.FieldByName('FgBPrice').AsFloat := oTxtDoc.ReadFloat ('FgBPrice');
        dmSTK.ptTCI.FieldByName('FgCValue').AsFloat := oTxtDoc.ReadFloat ('FgCValue');
        dmSTK.ptTCI.FieldByName('FgDValue').AsFloat := oTxtDoc.ReadFloat ('FgDValue');
        dmSTK.ptTCI.FieldByName('FgDscVal').AsFloat := oTxtDoc.ReadFloat ('FgDscVal');
        dmSTK.ptTCI.FieldByName('FgAValue').AsFloat := oTxtDoc.ReadFloat ('FgAValue');
        dmSTK.ptTCI.FieldByName('FgBValue').AsFloat := oTxtDoc.ReadFloat ('FgBValue');
        dmSTK.ptTCI.FieldByName('DlrCode').AsInteger := dmSTK.btTCH.FieldByName('DlrCode').AsInteger;
        dmSTK.ptTCI.FieldByName('DocDate').AsDateTime := dmSTK.btTCH.FieldByName('DocDate').AsDateTime;
        dmSTK.ptTCI.FieldByName('DlvDate').AsDateTime := dmSTK.btTCH.FieldByName('DlvDate').AsDateTime;
        dmSTK.ptTCI.FieldByName('PaCode').AsInteger := dmSTK.btTCH.FieldByName('PaCode').AsInteger;
        dmSTK.ptTCI.FieldByName('DlvUser').AsString := oTxtDoc.ReadString ('DlvUser');
        dmSTK.ptTCI.FieldByName('McdNum').AsString := oTxtDoc.ReadString ('McdNum');
        dmSTK.ptTCI.FieldByName('McdItm').AsInteger := oTxtDoc.ReadInteger ('McdItm');
        dmSTK.ptTCI.FieldByName('OcdNum').AsString := oTxtDoc.ReadString ('OcdNum');
        dmSTK.ptTCI.FieldByName('OcdItm').AsInteger := oTxtDoc.ReadInteger ('OcdItm');
        dmSTK.ptTCI.FieldByName('IcdNum').AsString := oTxtDoc.ReadString ('IcdNum');
        dmSTK.ptTCI.FieldByName('IcdItm').AsInteger := oTxtDoc.ReadInteger ('IcdItm');
        dmSTK.ptTCI.FieldByName('IcdDate').AsDateTime := oTxtDoc.ReadDate ('IcdDate');
        dmSTK.ptTCI.FieldByName('StkStat').AsString := oTxtDoc.ReadString ('StkStat');
        dmSTK.ptTCI.FieldByName('FinStat').AsString := oTxtDoc.ReadString ('FinStat');
        dmSTK.ptTCI.FieldByName('Action').AsString := oTxtDoc.ReadString ('Action');
        dmSTK.ptTCI.FieldByName('CrtUser').AsString := oTxtDoc.ReadString ('CrtUser');
        dmSTK.ptTCI.FieldByName('CrtDate').AsDateTime := oTxtDoc.ReadDate ('CrtDate');
        dmSTK.ptTCI.FieldByName('CrtTime').AsDateTime := oTxtDoc.ReadTime ('CrtTime');
        dmSTK.ptTCI.FieldByName('ModUser').AsString := oTxtDoc.ReadString ('ModUser');
        dmSTK.ptTCI.FieldByName('ModDate').AsDateTime := oTxtDoc.ReadDate ('ModDate');
        dmSTK.ptTCI.FieldByName('ModTime').AsDateTime := oTxtDoc.ReadTime ('ModTime');
        dmSTK.ptTCI.Post;
      end;
      oTxtDoc.Next;
      Application.ProcessMessages;
    until oTxtDoc.Eof;
  end;
end;

procedure TTcdTxt.LoadTxtToTcn; // Nacita poloky z prenosoveho suboru do docasneh databaze ptTCI
begin
end;

procedure TTcdTxt.DeleteTci; // Vymaze polozky doacieho listu, ktore nie su v docasnej databaze
begin
  If dmSTK.btTCI.IndexName<>'DocNum' then dmSTK.btTCI.IndexName:='DocNum';
  If dmSTK.btTCI.FindKey ([oDocNum]) then begin
    Repeat
      Application.ProcessMessages;
      dmSTK.btTCI.Delete
    until (dmSTK.btTCI.Eof) or (dmSTK.btTCI.RecordCount=0) or (dmSTK.btTCI.FieldByName('DocNum').AsString<>oDocNum);
  end;
end;

procedure TTcdTxt.AddNewItmToTci; // Prida nove polozky do dodacieho listu
begin
  dmSTK.btTCI.Modify := FALSE;
  dmSTK.btTCI.IndexName:='DoIt';
  dmSTK.ptTCI.First;
  Repeat
    If not dmSTK.btTCI.FindKey ([oDocNum,dmSTK.ptTCI.FieldByName('ItmNum').AsInteger]) then begin
      dmSTK.btTCI.Insert;
      PX_To_BTR (dmSTK.ptTCI,dmSTK.btTCI);
      dmSTK.btTCI.Post;
    end
    else begin  // Ak bola zmenena len cena vykoname zmenu

    end;
    Application.ProcessMessages;
    dmSTK.ptTCI.Next;
  until (dmSTK.ptTCI.Eof);
  dmSTK.btTCI.Modify := TRUE;
end;

end.
