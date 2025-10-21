unit TsdTxt;
{$F+}

interface

uses
  IcTypes, IcConv, IcTools, IcVariab, IniFiles, SysUtils, NexGlob,
  NexPath, NexIni, TxtWrap, TxtCut, DocHand, TxtDoc, Forms;

type
  TTsdTxt = class
    constructor Create;
    destructor  Destroy;
    private
      oDocNum: Str12; // Cislo dokladu ktorym pracujeme
      function LoadTxtToTsh:boolean; // Nacita udaje z prenosoveho suboru a vytvori alebo opravy hlavicku dodacieho listu
      procedure LoadTxtToTsp; // Nacita vyrobne cisla daneho dokladu
      procedure LoadTxtToTmp; // Nacita poloky z prenosoveho suboru do docasneh databaze ptTSI
      procedure LoadTxtToTsn; // Nacita poloky z prenosoveho suboru do docasneh databaze ptTSI
      procedure DeleteTsi; // Vymaze polozky doacieho listu, ktore nie su v docasnej databaze
      procedure AddNewItmToTsi; // Prida nove polozky do dodacieho listu
    public
      oCount:word;
      oTxtDoc: TTxtDoc;
      procedure SaveToFile (pDocNum:Str12);  // Ulozi zadany doklad do textoveho suboru
      procedure LoadFromFile (pFileName:ShortString);  // Nacita doklad z textoveho suboru
    published
      property Count:word read oCount;
  end;

implementation

uses
   DM_STKDAT, DM_DLSDAT, DB;

constructor TTsdTxt.Create;
begin
end;

destructor TTsdTxt.Destroy;
begin
end;

procedure TTsdTxt.SaveToFile (pDocNum:Str12);  // Ulozi zadany doklad do textoveho suboru
var mFileName:string; mPdnQnt:word;  mWrap:TTxtWrap;
begin
  mFileName := gIni.GetZipPath+pDocNum+'.TXT';
  oTxtDoc := TTxtDoc.Create;
  If FileExists (mFileName) then DeleteFile (mFileName);
  oTxtDoc.WriteInteger ('FtpVer',1);
  oTxtDoc.WriteString ('PrgVer',cPrgVer);
  // Nova datavaza - od v 10.02
  oTxtDoc.WriteInteger ('SerNum',dmSTK.btTSH.FieldByName('SerNum').AsInteger);
  oTxtDoc.WriteString ('DocNum',dmSTK.btTSH.FieldByName('DocNum').AsString);
  oTxtDoc.WriteString ('ExtNum',dmSTK.btTSH.FieldByName('ExtNum').AsString);
  oTxtDoc.WriteDate ('DocDate',dmSTK.btTSH.FieldByName('DocDate').AsDateTime);
  oTxtDoc.WriteInteger ('StkNum',dmSTK.btTSH.FieldByName('StkNum').AsInteger);
  oTxtDoc.WriteInteger ('PaCode',dmSTK.btTSH.FieldByName('PaCode').AsInteger);
  oTxtDoc.WriteString ('PaName',dmSTK.btTSH.FieldByName('PaName').AsString);
  oTxtDoc.WriteString ('RegName',dmSTK.btTSH.FieldByName('RegName').AsString);
  oTxtDoc.WriteString ('RegIno',dmSTK.btTSH.FieldByName('RegIno').AsString);
  oTxtDoc.WriteString ('RegTin',dmSTK.btTSH.FieldByName('RegTin').AsString);
  oTxtDoc.WriteString ('RegVin',dmSTK.btTSH.FieldByName('RegVin').AsString);
  oTxtDoc.WriteString ('RegAddr',dmSTK.btTSH.FieldByName('RegAddr').AsString);
  oTxtDoc.WriteString ('RegSta',dmSTK.btTSH.FieldByName('RegSta').AsString);
  oTxtDoc.WriteString ('RegCty',dmSTK.btTSH.FieldByName('RegCty').AsString);
  oTxtDoc.WriteString ('RegCtn',dmSTK.btTSH.FieldByName('RegCtn').AsString);
  oTxtDoc.WriteString ('RegZip',dmSTK.btTSH.FieldByName('RegZip').AsString);
  oTxtDoc.WriteString ('PayCode',dmSTK.btTSH.FieldByName('PayCode').AsString);
  oTxtDoc.WriteString ('PayName',dmSTK.btTSH.FieldByName('PayName').AsString);
  oTxtDoc.WriteInteger ('WpaCode',dmSTK.btTSH.FieldByName('WpaCode').AsInteger);
  oTxtDoc.WriteString ('WpaName',dmSTK.btTSH.FieldByName('WpaName').AsString);
  oTxtDoc.WriteString ('WpaAddr',dmSTK.btTSH.FieldByName('WpaAddr').AsString);
  oTxtDoc.WriteString ('WpaSta',dmSTK.btTSH.FieldByName('WpaSta').AsString);
  oTxtDoc.WriteString ('WpaCty',dmSTK.btTSH.FieldByName('WpaCty').AsString);
  oTxtDoc.WriteString ('WpaCtn',dmSTK.btTSH.FieldByName('WpaCtn').AsString);
  oTxtDoc.WriteString ('WpaZip',dmSTK.btTSH.FieldByName('WpaZip').AsString);
  oTxtDoc.WriteString ('TrsCode',dmSTK.btTSH.FieldByName('TrsCode').AsString);
  oTxtDoc.WriteString ('TrsName',dmSTK.btTSH.FieldByName('TrsName').AsString);
  oTxtDoc.WriteInteger ('PlsNum',dmSTK.btTSH.FieldByName('PlsNum').AsInteger);
  oTxtDoc.WriteInteger ('VatPrc1',dmSTK.btTSH.FieldByName('VatPrc1').AsInteger);
  oTxtDoc.WriteInteger ('VatPrc2',dmSTK.btTSH.FieldByName('VatPrc2').AsInteger);
  oTxtDoc.WriteInteger ('VatPrc3',dmSTK.btTSH.FieldByName('VatPrc3').AsInteger);
  oTxtDoc.WriteString ('AcDvzName',dmSTK.btTSH.FieldByName('AcDvzName').AsString);
  oTxtDoc.WriteFloat ('FgCsdVal1',dmSTK.btTSH.FieldByName('FgCsdVal1').AsFloat);
  oTxtDoc.WriteFloat ('FgCsdVal2',dmSTK.btTSH.FieldByName('FgCsdVal2').AsFloat);
  oTxtDoc.WriteFloat ('FgCsdVal3',dmSTK.btTSH.FieldByName('FgCsdVal3').AsFloat);
  oTxtDoc.WriteString ('FgDvzName',dmSTK.btTSH.FieldByName('FgDvzName').AsString);
  oTxtDoc.WriteFloat ('FgCourse',dmSTK.btTSH.FieldByName('FgCourse').AsFloat);
  oTxtDoc.WriteString ('ZIseNum',dmSTK.btTSH.FieldByName('ZIseNum').AsString);
  oTxtDoc.WriteString ('TIseNum',dmSTK.btTSH.FieldByName('TIseNum').AsString);
  oTxtDoc.WriteString ('OIseNum',dmSTK.btTSH.FieldByName('OIseNum').AsString);
  oTxtDoc.WriteString ('GIseNum',dmSTK.btTSH.FieldByName('GIseNum').AsString);
  oTxtDoc.WriteString ('ZIsdNum',dmSTK.btTSH.FieldByName('ZIsdNum').AsString);
  oTxtDoc.WriteString ('TIsdNum',dmSTK.btTSH.FieldByName('TIsdNum').AsString);
  oTxtDoc.WriteString ('OIsdNum',dmSTK.btTSH.FieldByName('OIsdNum').AsString);
  oTxtDoc.WriteString ('GIsdNum',dmSTK.btTSH.FieldByName('GIsdNum').AsString);
  oTxtDoc.WriteString ('OcdNum',dmSTK.btTSH.FieldByName('OcdNum').AsString);
  oTxtDoc.WriteString ('CsdNum',dmSTK.btTSH.FieldByName('CsdNum').AsString);
  oTxtDoc.WriteString ('IsdNum',dmSTK.btTSH.FieldByName('IsdNum').AsString);
  oTxtDoc.WriteFloat ('VatDoc',dmSTK.btTSH.FieldByName('VatDoc').AsFloat);
  oTxtDoc.WriteInteger ('PrnCnt',dmSTK.btTSH.FieldByName('PrnCnt').AsInteger);
  oTxtDoc.WriteInteger ('ItmQnt',dmSTK.btTSH.FieldByName('ItmQnt').AsInteger);
  oTxtDoc.WriteInteger ('SmCode',dmSTK.btTSH.FieldByName('SmCode').AsInteger);
  oTxtDoc.WriteString ('DstStk',dmSTK.btTSH.FieldByName('DstStk').AsString);
  oTxtDoc.WriteString ('DstPair',dmSTK.btTSH.FieldByName('DstPair').AsString);
  oTxtDoc.WriteInteger ('DstLck',dmSTK.btTSH.FieldByName('DstLck').AsInteger);
  oTxtDoc.WriteInteger ('DstCls',dmSTK.btTSH.FieldByName('DstCls').AsInteger);
  oTxtDoc.WriteString ('CrtUser',dmSTK.btTSH.FieldByName('CrtUser').AsString);
  oTxtDoc.WriteDate ('CrtDate',dmSTK.btTSH.FieldByName('CrtDate').AsDateTime);
  oTxtDoc.WriteTime ('CrtTime',dmSTK.btTSH.FieldByName('CrtTime').AsDateTime);
  oTxtDoc.WriteString ('ModUser',dmSTK.btTSH.FieldByName('ModUser').AsString);
  oTxtDoc.WriteDate ('ModDate',dmSTK.btTSH.FieldByName('ModDate').AsDateTime);
  oTxtDoc.WriteTime ('ModTime',dmSTK.btTSH.FieldByName('ModTime').AsDateTime);
  oTxtDoc.WriteString ('Year',dmSTK.btTSH.FieldByName('Year').AsString);
  // Ulozime vyrobne cisla
  mPdnQnt := 0;
  If dmSTK.btTSP.IndexName<>'DoIt' then dmSTK.btTSP.IndexName := 'DoIt';
  dmSTK.btTSP.FindNearest ([pDocNum,0]);
  If dmSTK.btTSP.FieldByName ('DocNum').AsString=dmSTK.btTSH.FieldByName ('DocNum').AsString then begin
    mWrap := TTxtWrap.Create;
    mWrap.SetDelimiter('');
    Repeat
      Inc (mPdnQnt);
      mWrap.ClearWrap;
      mWrap.SetNum(dmSTK.btTSP.FieldByName('ItmNum').AsInteger,0);
      mWrap.SetNum(dmSTK.btTSP.FieldByName('GsCode').AsInteger,0);
      mWrap.SetText(dmSTK.btTSP.FieldByName('ProdNum').AsString,0);
      mWrap.SetNum(dmSTK.btTSP.FieldByName('StkNum').AsInteger,0);
      oTxtDoc.WriteString ('ProdNum'+StrInt(mPdnQnt,0),mWrap.GetWrapText);
      Application.ProcessMessages;
      dmSTK.btTSP.Next;
    until (dmSTK.btTSP.Eof) or (dmSTK.btTSP.FieldByName('DocNum').AsString<>pDocNum);
    FreeAndNil (mWrap);
  end;
  oTxtDoc.WriteInteger ('PdnQnt',mPdnQnt);

  // Ulozime poloziek dokladu
  If dmSTK.btTSI.IndexName<>'DoIt' then dmSTK.btTSI.IndexName := 'DoIt';
  dmSTK.btTSI.FindNearest ([pDocNum,0]);
  If dmSTK.btTSI.FieldByName ('DocNum').AsString=dmSTK.btTSH.FieldByName ('DocNum').AsString then begin
    Repeat
      oTxtDoc.Insert;
      // Nova databaza - od v10.02
      oTxtDoc.WriteInteger ('ItmNum',dmSTK.btTSI.FieldByName('ItmNum').AsInteger);
      oTxtDoc.WriteInteger ('MgCode',dmSTK.btTSI.FieldByName('MgCode').AsInteger);
      oTxtDoc.WriteInteger ('GsCode',dmSTK.btTSI.FieldByName('GsCode').AsInteger);
      oTxtDoc.WriteString ('GsName',dmSTK.btTSI.FieldByName('GsName').AsString);
      oTxtDoc.WriteString ('BarCode',dmSTK.btTSI.FieldByName('BarCode').AsString);
      oTxtDoc.WriteString ('StkCode',dmSTK.btTSI.FieldByName('StkCode').AsString);
      oTxtDoc.WriteString ('Notice',dmSTK.btTSI.FieldByName('Notice').AsString);
      oTxtDoc.WriteInteger ('PackGs',dmSTK.btTSI.FieldByName('PackGs').AsInteger);
      oTxtDoc.WriteString ('GsType',dmSTK.btTSI.FieldByName('GsType').AsString);
      oTxtDoc.WriteInteger ('StkNum',dmSTK.btTSI.FieldByName('StkNum').AsInteger);
      oTxtDoc.WriteString ('MsName',dmSTK.btTSI.FieldByName('MsName').AsString);
      oTxtDoc.WriteFloat ('GsQnt',dmSTK.btTSI.FieldByName('GsQnt').AsFloat);
      oTxtDoc.WriteInteger ('VatPrc',dmSTK.btTSI.FieldByName('VatPrc').AsInteger);
      oTxtDoc.WriteFloat ('DscPrc',dmSTK.btTSI.FieldByName('DscPrc').AsFloat);
      oTxtDoc.WriteFloat ('AcSPrice',dmSTK.btTSI.FieldByName('AcSPrice').AsFloat);
      oTxtDoc.WriteFloat ('AcDValue',dmSTK.btTSI.FieldByName('AcDValue').AsFloat);
      oTxtDoc.WriteFloat ('AcDscVal',dmSTK.btTSI.FieldByName('AcDscVal').AsFloat);
      oTxtDoc.WriteFloat ('AcZValue',dmSTK.btTSI.FieldByName('AcZValue').AsFloat);
      oTxtDoc.WriteFloat ('AcTValue',dmSTK.btTSI.FieldByName('AcTValue').AsFloat);
      oTxtDoc.WriteFloat ('AcOValue',dmSTK.btTSI.FieldByName('AcOValue').AsFloat);
      oTxtDoc.WriteFloat ('AcSValue',dmSTK.btTSI.FieldByName('AcSValue').AsFloat);
      oTxtDoc.WriteFloat ('AcRndVal',dmSTK.btTSI.FieldByName('AcRndVal').AsFloat);
      oTxtDoc.WriteFloat ('AcCValue',dmSTK.btTSI.FieldByName('AcCValue').AsFloat);
      oTxtDoc.WriteFloat ('AcEValue',dmSTK.btTSI.FieldByName('AcEValue').AsFloat);
      oTxtDoc.WriteFloat ('AcAValue',dmSTK.btTSI.FieldByName('AcAValue').AsFloat);
      oTxtDoc.WriteFloat ('AcBValue',dmSTK.btTSI.FieldByName('AcBValue').AsFloat);
      oTxtDoc.WriteFloat ('FgDPrice',dmSTK.btTSI.FieldByName('FgDPrice').AsFloat);
      oTxtDoc.WriteFloat ('FgCPrice',dmSTK.btTSI.FieldByName('FgCPrice').AsFloat);
      oTxtDoc.WriteFloat ('FgEPrice',dmSTK.btTSI.FieldByName('FgEPrice').AsFloat);
      oTxtDoc.WriteFloat ('FgDValue',dmSTK.btTSI.FieldByName('FgDValue').AsFloat);
      oTxtDoc.WriteFloat ('FgDscVal',dmSTK.btTSI.FieldByName('FgDscVal').AsFloat);
      oTxtDoc.WriteFloat ('FgRndVal',dmSTK.btTSI.FieldByName('FgRndVal').AsFloat);
      oTxtDoc.WriteFloat ('FgCValue',dmSTK.btTSI.FieldByName('FgCValue').AsFloat);
      oTxtDoc.WriteFloat ('FgEValue',dmSTK.btTSI.FieldByName('FgEValue').AsFloat);
      oTxtDoc.WriteDate ('DrbDate',dmSTK.btTSI.FieldByName('DrbDate').AsDateTime);
      oTxtDoc.WriteString ('OsdNum',dmSTK.btTSI.FieldByName('OsdNum').AsString);
      oTxtDoc.WriteInteger ('OsdItm',dmSTK.btTSI.FieldByName('OsdItm').AsInteger);
      oTxtDoc.WriteString ('IsdNum',dmSTK.btTSI.FieldByName('IsdNum').AsString);
      oTxtDoc.WriteInteger ('IsdItm',dmSTK.btTSI.FieldByName('IsdItm').AsInteger);
      oTxtDoc.WriteDate ('IsdDate',dmSTK.btTSI.FieldByName('IsdDate').AsDateTime);
      oTxtDoc.WriteString ('StkStat',dmSTK.btTSI.FieldByName('StkStat').AsString);
      oTxtDoc.WriteString ('FinStat',dmSTK.btTSI.FieldByName('FinStat').AsString);
      oTxtDoc.WriteString ('AcqStat',dmSTK.btTSI.FieldByName('AcqStat').AsString);
      oTxtDoc.WriteString ('CrtUser',dmSTK.btTSI.FieldByName('CrtUser').AsString);
      oTxtDoc.WriteDate ('CrtDate',dmSTK.btTSI.FieldByName('CrtDate').AsDateTime);
      oTxtDoc.WriteTime ('CrtTime',dmSTK.btTSI.FieldByName('CrtTime').AsDateTime);
      oTxtDoc.WriteString ('ModUser',dmSTK.btTSI.FieldByName('ModUser').AsString);
      oTxtDoc.WriteDate ('ModDate',dmSTK.btTSI.FieldByName('ModDate').AsDateTime);
      oTxtDoc.WriteTime ('ModTime',dmSTK.btTSI.FieldByName('ModTime').AsDateTime);
      oTxtDoc.Post;
      Application.ProcessMessages;
      dmSTK.btTSI.Next;
    until (dmSTK.btTSI.Eof) or (dmSTK.btTSI.FieldByName('DocNum').AsString<>pDocNum);
{
    // Ulozime poznamky dokladu
    If dmSTK.btTSN.IndexName<>'DoNtLn' then dmSTK.btTSN.IndexName:='DoNtLn';
    dmSTK.btTSN.FindNearest ([pDocNum,'',0]);
    If dmSTK.btTSI.FieldByName ('DocNum').AsString=dmSTK.btTSH.FieldByName ('DocNum').AsString then begin
      mLine := 0;
      Repeat
        Inc (mLine);
        oFile.WriteString ('NOTICES','Line'+StrInt(mLine,0),dmSTK.btTSN.FieldByName('Notice').AsString);
      until (dmSTK.btTSN.Eof) or (dmSTK.btTSN.FieldByName('DocNum').AsString<>pDocNum);
    end;
}
  end;
  oTxtDoc.SaveToFile (mFileName);
  FreeAndNil (oTxtDoc);
end;

procedure TTsdTxt.LoadFromFile (pFileName:ShortString);  // Nacita doklad z textoveho suboru
var mFileName:ShortString;
begin
  oDocNum := copy(UpString(pFileName),1,12);
  mFileName := gIni.GetZipPath+pFileName;
  If FileExists (mFileName) then begin
    oTxtDoc := TTxtDoc.Create;
    oTxtDoc.LoadFromFile (mFileName);
    If LoadTxtToTsh then begin // Nacita udaje z prenosoveho suboru a vytvori alebo opravy hlavicku dodacieho listu
      LoadTxtToTsp; // Nacita vyrobne cisla daneho dokladu
//      If dmSTK.btTSH.FieldByName('ItmQnt').AsInteger>0 then begin  // Ak doklad ma polozky
        // Polozky dokladu
        dmSTK.ptTSI.Open;
        dmSTK.ptTSI.IndexName := 'ItmNum';
        LoadTxtToTmp; // Nacita poloky z prenosoveho suboru do docasneh databaze ptTSI
        DeleteTsi; // Vymaze polozky doacieho listu, ktore nie su v docasnej databaze
        AddNewItmToTsi; // Prida nove polozky do dodacieho listu
        dmSTK.ptTSI.Close;
        TshRecalc (dmSTK.btTSH,dmSTK.btTSI);  // Prepocita hlavicku zadaneho dodacieho listu podla jeho poloziek
//      end;
      // Poznamky k dokladu
    end;
    FreeAndNil (oTxtDoc);
    DeleteFile (mFileName);
  end;
end;

function TTsdTxt.LoadTxtToTsh:boolean; // Nacita udaje z prenosoveho suboru a vytvori alebo opravy hlavicku dodacieho listu
var mFind:boolean;
begin
  Result := TRUE;
  If dmSTK.btTSH.IndexName<>'DocNum' then dmSTK.btTSH.IndexName:='DocNum';
  mFind := dmSTK.btTSH.FindKey ([oDocNum]);
  If mFind then Result := dmSTK.btTSH.FieldByName('DstAcc').AsString<>'A';
  If Result then begin // Ak nie je zauctovany
    If mFind
      then dmSTK.btTSH.Edit // Uprava hlavicky dokladu
      else dmSTK.btTSH.Insert;
    dmSTK.btTSH.FieldByName('SerNum').AsInteger := oTxtDoc.ReadInteger ('SerNum');
    dmSTK.btTSH.FieldByName('Year').AsString := oTxtDoc.ReadString ('Year');
    dmSTK.btTSH.FieldByName('DocNum').AsString := oTxtDoc.ReadString ('DocNum');
    dmSTK.btTSH.FieldByName('ExtNum').AsString := oTxtDoc.ReadString ('ExtNum');
    dmSTK.btTSH.FieldByName('DocDate').AsDateTime := oTxtDoc.ReadDate ('DocDate');
    dmSTK.btTSH.FieldByName('StkNum').AsInteger := oTxtDoc.ReadInteger ('StkNum');
    dmSTK.btTSH.FieldByName('PaCode').AsInteger := oTxtDoc.ReadInteger ('PaCode');
    dmSTK.btTSH.FieldByName('PaName').AsString := oTxtDoc.ReadString ('PaName');
    dmSTK.btTSH.FieldByName('RegName').AsString := oTxtDoc.ReadString ('RegName');
    dmSTK.btTSH.FieldByName('RegIno').AsString := oTxtDoc.ReadString ('RegIno');
    dmSTK.btTSH.FieldByName('RegTin').AsString := oTxtDoc.ReadString ('RegTin');
    dmSTK.btTSH.FieldByName('RegVin').AsString := oTxtDoc.ReadString ('RegVin');
    dmSTK.btTSH.FieldByName('RegAddr').AsString := oTxtDoc.ReadString ('RegAddr');
    dmSTK.btTSH.FieldByName('RegSta').AsString := oTxtDoc.ReadString ('RegSta');
    dmSTK.btTSH.FieldByName('RegCty').AsString := oTxtDoc.ReadString ('RegCty');
    dmSTK.btTSH.FieldByName('RegCtn').AsString := oTxtDoc.ReadString ('RegCtn');
    dmSTK.btTSH.FieldByName('RegZip').AsString := oTxtDoc.ReadString ('RegZip');
    dmSTK.btTSH.FieldByName('PayCode').AsString := oTxtDoc.ReadString ('PayCode');
    dmSTK.btTSH.FieldByName('PayName').AsString := oTxtDoc.ReadString ('PayName');
    dmSTK.btTSH.FieldByName('WpaName').AsString := oTxtDoc.ReadString ('WpaName');
    dmSTK.btTSH.FieldByName('WpaName').AsString := oTxtDoc.ReadString ('WpaName');
    dmSTK.btTSH.FieldByName('WpaAddr').AsString := oTxtDoc.ReadString ('WpaAddr');
    dmSTK.btTSH.FieldByName('WpaSta').AsString := oTxtDoc.ReadString ('WpaSta');
    dmSTK.btTSH.FieldByName('WpaCty').AsString := oTxtDoc.ReadString ('WpaCty');
    dmSTK.btTSH.FieldByName('WpaCtn').AsString := oTxtDoc.ReadString ('WpaCtn');
    dmSTK.btTSH.FieldByName('WpaZip').AsString := oTxtDoc.ReadString ('WpaZip');
    dmSTK.btTSH.FieldByName('TrsCode').AsString := oTxtDoc.ReadString ('TrsCode');
    dmSTK.btTSH.FieldByName('TrsName').AsString := oTxtDoc.ReadString ('TrsName');
    dmSTK.btTSH.FieldByName('PlsNum').AsInteger := oTxtDoc.ReadInteger ('PlsNum');
    dmSTK.btTSH.FieldByName('VatPrc1').AsInteger := oTxtDoc.ReadInteger ('VatPrc1');
    dmSTK.btTSH.FieldByName('VatPrc2').AsInteger := oTxtDoc.ReadInteger ('VatPrc2');
    dmSTK.btTSH.FieldByName('VatPrc3').AsInteger := oTxtDoc.ReadInteger ('VatPrc3');
    dmSTK.btTSH.FieldByName('AcDvzName').AsString := oTxtDoc.ReadString ('AcDvzName');
    dmSTK.btTSH.FieldByName('FgCsdVal1').AsFloat := oTxtDoc.ReadFloat ('FgCsdVal1');
    dmSTK.btTSH.FieldByName('FgCsdVal2').AsFloat := oTxtDoc.ReadFloat ('FgCsdVal2');
    dmSTK.btTSH.FieldByName('FgCsdVal3').AsFloat := oTxtDoc.ReadFloat ('FgCsdVal3');
    dmSTK.btTSH.FieldByName('FgDvzName').AsString := oTxtDoc.ReadString ('FgDvzName');
    dmSTK.btTSH.FieldByName('FgCourse').AsFloat := oTxtDoc.ReadFloat ('FgCourse');
    dmSTK.btTSH.FieldByName('ZIseNum').AsString := oTxtDoc.ReadString ('ZIseNum');
    dmSTK.btTSH.FieldByName('TIseNum').AsString := oTxtDoc.ReadString ('TIseNum');
    dmSTK.btTSH.FieldByName('OIseNum').AsString := oTxtDoc.ReadString ('OIseNum');
    dmSTK.btTSH.FieldByName('GIseNum').AsString := oTxtDoc.ReadString ('GIseNum');
    dmSTK.btTSH.FieldByName('ZIsdNum').AsString := oTxtDoc.ReadString ('ZIsdNum');
    dmSTK.btTSH.FieldByName('TIsdNum').AsString := oTxtDoc.ReadString ('TIsdNum');
    dmSTK.btTSH.FieldByName('OIsdNum').AsString := oTxtDoc.ReadString ('OIsdNum');
    dmSTK.btTSH.FieldByName('GIsdNum').AsString := oTxtDoc.ReadString ('GIsdNum');
    If dmSTK.btTSH.FieldByName('CsdNum').AsString=''
      then dmSTK.btTSH.FieldByName('CsdNum').AsString := oTxtDoc.ReadString ('CsdNum');
    If dmSTK.btTSH.FieldByName('IsdNum').AsString=''
      then dmSTK.btTSH.FieldByName('IsdNum').AsString := oTxtDoc.ReadString ('IsdNum');
    If dmSTK.btTSH.FieldByName('DstPair').AsString=''
      then dmSTK.btTSH.FieldByName('DstPair').AsString := oTxtDoc.ReadString ('DstPair');
    dmSTK.btTSH.FieldByName('VatDoc').AsInteger := oTxtDoc.ReadInteger ('VatDoc');
    dmSTK.btTSH.FieldByName('PrnCnt').AsInteger := oTxtDoc.ReadInteger ('PrnCnt');
    dmSTK.btTSH.FieldByName('ItmQnt').AsInteger := oTxtDoc.ReadInteger ('ItmQnt');
    dmSTK.btTSH.FieldByName('SmCode').AsInteger := oTxtDoc.ReadInteger ('SmCode');
    dmSTK.btTSH.FieldByName('DstStk').AsString := oTxtDoc.ReadString ('DstStk');
    dmSTK.btTSH.FieldByName('CrtUser').AsString := oTxtDoc.ReadString ('CrtUser');
    dmSTK.btTSH.FieldByName('ModUser').AsString := oTxtDoc.ReadString ('ModUser');
    dmSTK.btTSH.FieldByName('ModDate').AsDateTime := oTxtDoc.ReadDate ('ModDate');
    dmSTK.btTSH.FieldByName('ModTime').AsDateTime := oTxtDoc.ReadTime ('ModTime');
    dmSTK.btTSH.FieldByName('Sended').AsInteger := 1;
    dmSTK.btTSH.Post;
  end;
end;

procedure TTsdTxt.LoadTxtToTsp; // Nacita vyrobne cisla daneho dokladu
var mItmNum,mPdnQnt,I:word;  mCut:TTxtCut;
begin
  // Mymazeme vsetky vyrobne cisla daneho dokladu
  dmSTK.btTSP.SwapIndex;
  dmSTK.btTSP.IndexName := 'DocNum';
  While dmSTK.btTSP.FindKey ([dmSTK.btTSH.FieldByName('DocNum').AsString]) do dmSTK.btTSP.Delete;
  // STP - Vymazeme vsetky vyrobne cisla daneho dokladu
  dmSTK.OpenList(dmSTK.btSTP,dmSTK.btTSH.FieldByName('StkNum').AsInteger);
  dmSTK.btSTP.IndexName := 'InDoIt';
  dmSTK.btSTP.FindNearest ([dmSTK.btTSH.FieldByName('DocNum').AsString,0]);
  If dmSTK.btSTP.FieldByName ('InDocNum').AsString=dmSTK.btTSH.FieldByName('DocNum').AsString then begin
    Repeat
      dmSTK.btSTP.Delete;
    until (dmSTK.btSTP.Eof) or (dmSTK.btSTP.RecordCount=0) or (dmSTK.btSTP.FieldByName ('InDocNum').AsString<>dmSTK.btTSH.FieldByName('DocNum').AsString);
  end;

  // Ulozime vyrobne cisla daneho dokladu
  mPdnQnt := oTxtDoc.ReadInteger ('PdnQnt');
  If mPdnQnt>0 then begin
    mCut := TTxtCut.Create;
    mCut.SetDelimiter('');
    For I:=1 to mPdnQnt do begin
      mCut.SetStr(oTxtDoc.ReadString('ProdNum'+StrInt(I,0)));
      dmSTK.btTSP.Insert;
      dmSTK.btTSP.FieldByName ('DocNum').AsString := dmSTK.btTSH.FieldByName('DocNum').AsString;
      dmSTK.btTSP.FieldByName ('ItmNum').AsInteger := mCut.GetNum(1);
      dmSTK.btTSP.FieldByName ('ItmNum').AsInteger := mCut.GetNum(2);
      dmSTK.btTSP.FieldByName ('ProdNum').AsString := mCut.GetText(3);
      dmSTK.btTSP.FieldByName ('StkNum').AsInteger := mCut.GetNum(4);
      dmSTK.btTSP.FieldByName ('DocDate').AsDateTime := dmSTK.btTSH.FieldByName('DocDate').AsDateTime;
      dmSTK.btTSP.Post;

      dmSTK.btSTP.Insert;
      dmSTK.btSTP.FieldByName ('GsCode').AsInteger := dmSTK.btTSP.FieldByName ('GsCode').AsInteger;
      dmSTK.btSTP.FieldByName ('ProdNum').AsString := dmSTK.btTSP.FieldByName ('ProdNum').AsString;
      dmSTK.btSTP.FieldByName ('InDocDate').AsDateTime := dmSTK.btTSP.FieldByName ('DocDate').AsDateTime;
      dmSTK.btSTP.FieldByName ('InDocNum').AsString := dmSTK.btTSP.FieldByName ('DocNum').AsString;
      dmSTK.btSTP.FieldByName ('InItmNum').AsInteger := dmSTK.btTSP.FieldByName ('ItmNum').AsInteger;
      dmSTK.btSTP.FieldByName ('Status').AsString := 'A';
      dmSTK.btSTP.Post;
    end;
    FreeAndNil (mCut);
  end;
  dmSTK.btSTP.Close;
end;

procedure TTsdTxt.LoadTxtToTmp; // Nacita poloky z prenosoveho suboru do docasneh databaze ptTSI
begin
  If oTxtDoc.ItemCount>0 then begin
    // Ulozime polozky do docasneho suboru
    oTxtDoc.First;
    Repeat
      If not dmSTK.ptTSI.FindKey([oTxtDoc.ReadInteger ('ItmNum')]) then begin
        dmSTK.ptTSI.Insert;
        dmSTK.ptTSI.FieldByName('DocNum').AsString := dmSTK.btTSH.FieldByName('DocNum').AsString;
        dmSTK.ptTSI.FieldByName('ItmNum').AsInteger := oTxtDoc.ReadInteger ('ItmNum');
        dmSTK.ptTSI.FieldByName('RowNum').AsInteger := dmSTK.ptTSI.RecordCount+1;
        dmSTK.ptTSI.FieldByName('MgCode').AsInteger := oTxtDoc.ReadInteger ('MgCode');
        dmSTK.ptTSI.FieldByName('GsCode').AsInteger := oTxtDoc.ReadInteger ('GsCode');
        dmSTK.ptTSI.FieldByName('GsName').AsString := oTxtDoc.ReadString ('GsName');
        dmSTK.ptTSI.FieldByName('BarCode').AsString := oTxtDoc.ReadString ('BarCode');
        dmSTK.ptTSI.FieldByName('StkCode').AsString := oTxtDoc.ReadString ('StkCode');
        dmSTK.ptTSI.FieldByName('Notice').AsString := oTxtDoc.ReadString ('Notice');
        dmSTK.ptTSI.FieldByName('PackGs').AsInteger := oTxtDoc.ReadInteger ('PackGs');
        dmSTK.ptTSI.FieldByName('GsType').AsString := oTxtDoc.ReadString ('GsType');
        dmSTK.ptTSI.FieldByName('StkNum').AsInteger := oTxtDoc.ReadInteger ('StkNum');
        dmSTK.ptTSI.FieldByName('MsName').AsString := oTxtDoc.ReadString ('MsName');
        dmSTK.ptTSI.FieldByName('GsQnt').AsFloat := oTxtDoc.ReadFloat ('GsQnt');
        dmSTK.ptTSI.FieldByName('VatPrc').AsInteger := oTxtDoc.ReadInteger ('VatPrc');
        dmSTK.ptTSI.FieldByName('DscPrc').AsFloat := oTxtDoc.ReadFloat ('DscPrc');
        dmSTK.ptTSI.FieldByName('AcSPrice').AsFloat := oTxtDoc.ReadFloat ('AcSPrice');
        dmSTK.ptTSI.FieldByName('AcDValue').AsFloat := oTxtDoc.ReadFloat ('AcDValue');
        dmSTK.ptTSI.FieldByName('AcDscVal').AsFloat := oTxtDoc.ReadFloat ('AcDscVal');
        dmSTK.ptTSI.FieldByName('AcCValue').AsFloat := oTxtDoc.ReadFloat ('AcCValue');
        dmSTK.ptTSI.FieldByName('AcEValue').AsFloat := oTxtDoc.ReadFloat ('AcEValue');
        dmSTK.ptTSI.FieldByName('AcZValue').AsFloat := oTxtDoc.ReadFloat ('AcZValue');
        dmSTK.ptTSI.FieldByName('AcTValue').AsFloat := oTxtDoc.ReadFloat ('AcTValue');
        dmSTK.ptTSI.FieldByName('AcOValue').AsFloat := oTxtDoc.ReadFloat ('AcOValue');
        dmSTK.ptTSI.FieldByName('AcSValue').AsFloat := oTxtDoc.ReadFloat ('AcSValue');
        dmSTK.ptTSI.FieldByName('AcRndVal').AsFloat := oTxtDoc.ReadFloat ('AcRndVal');
        dmSTK.ptTSI.FieldByName('AcAValue').AsFloat := oTxtDoc.ReadFloat ('AcAValue');
        dmSTK.ptTSI.FieldByName('AcBValue').AsFloat := oTxtDoc.ReadFloat ('AcBValue');
        dmSTK.ptTSI.FieldByName('FgDPrice').AsFloat := oTxtDoc.ReadFloat ('FgDPrice');
        dmSTK.ptTSI.FieldByName('FgCPrice').AsFloat := oTxtDoc.ReadFloat ('FgCPrice');
        dmSTK.ptTSI.FieldByName('FgEPrice').AsFloat := oTxtDoc.ReadFloat ('FgEPrice');
        dmSTK.ptTSI.FieldByName('FgDValue').AsFloat := oTxtDoc.ReadFloat ('FgDValue');
        dmSTK.ptTSI.FieldByName('FgDscVal').AsFloat := oTxtDoc.ReadFloat ('FgDscVal');
        dmSTK.ptTSI.FieldByName('FgRndVal').AsFloat := oTxtDoc.ReadFloat ('FgRndVal');
        dmSTK.ptTSI.FieldByName('FgCValue').AsFloat := oTxtDoc.ReadFloat ('FgCValue');
        dmSTK.ptTSI.FieldByName('FgEValue').AsFloat := oTxtDoc.ReadFloat ('FgEValue');
        dmSTK.ptTSI.FieldByName('DocDate').AsDateTime := dmSTK.btTSH.FieldByName('DocDate').AsDateTime;
        dmSTK.ptTSI.FieldByName('DrbDate').AsDateTime := oTxtDoc.ReadDate ('DrbDate');
        dmSTK.ptTSI.FieldByName('PaCode').AsInteger := dmSTK.btTSH.FieldByName('PaCode').AsInteger;
        dmSTK.ptTSI.FieldByName('OsdNum').AsString := oTxtDoc.ReadString ('OsdNum');
        dmSTK.ptTSI.FieldByName('OsdItm').AsInteger := oTxtDoc.ReadInteger ('OsdItm');
        If dmSTK.ptTSI.FieldByName('FinStat').AsString='' then begin
          dmSTK.ptTSI.FieldByName('IsdNum').AsString := oTxtDoc.ReadString ('IsdNum');
          dmSTK.ptTSI.FieldByName('IsdItm').AsInteger := oTxtDoc.ReadInteger ('IsdItm');
          dmSTK.ptTSI.FieldByName('IsdDate').AsDateTime := oTxtDoc.ReadDate ('IsdDate');
          dmSTK.ptTSI.FieldByName('FinStat').AsString := oTxtDoc.ReadString ('FinStat');
        end;
        dmSTK.ptTSI.FieldByName('StkStat').AsString := oTxtDoc.ReadString ('StkStat');
        dmSTK.ptTSI.FieldByName('AcqStat').AsString := oTxtDoc.ReadString ('AcqStat');
        dmSTK.ptTSI.FieldByName('CrtUser').AsString := oTxtDoc.ReadString ('CrtUser');
        dmSTK.ptTSI.FieldByName('CrtDate').AsDateTime := oTxtDoc.ReadDate ('CrtDate');
        dmSTK.ptTSI.FieldByName('CrtTime').AsDateTime := oTxtDoc.ReadTime ('CrtTime');
        dmSTK.ptTSI.FieldByName('ModUser').AsString := oTxtDoc.ReadString ('ModUser');
        dmSTK.ptTSI.FieldByName('ModDate').AsDateTime := oTxtDoc.ReadDate ('ModDate');
        dmSTK.ptTSI.FieldByName('ModTime').AsDateTime := oTxtDoc.ReadTime ('ModTime');
        dmSTK.ptTSI.Post;
      end;
      Application.ProcessMessages;
      oTxtDoc.Next;
    until oTxtDoc.Eof;
  end;  
end;

procedure TTsdTxt.LoadTxtToTsn; // Nacita poloky z prenosoveho suboru do docasneh databaze ptTSI
begin
end;

procedure TTsdTxt.DeleteTsi; // Vymaze polozky doacieho listu, ktore nie su v docasnej databaze
var mAccFtpRcv:boolean;
begin
  mAccFtpRcv := gIni.AccFtpRcv;
  If dmSTK.btTSI.IndexName<>'DocNum' then dmSTK.btTSI.IndexName:='DocNum';
  If dmSTK.btTSI.FindKey ([oDocNum]) then begin
    Repeat
      Application.ProcessMessages;
      If (dmSTK.btTSI.FieldByName('StkStat').AsString='N') or mAccFtpRcv
        then dmSTK.btTSI.Delete
        else dmSTK.btTSI.Next;
    until (dmSTK.btTSI.Eof) or (dmSTK.btTSI.RecordCount=0) or (dmSTK.btTSI.FieldByName('DocNum').AsString<>oDocNum);
  end;
end;

procedure TTsdTxt.AddNewItmToTsi; // Prida nove polozky do dodacieho listu
begin
  dmSTK.btTSI.Modify := FALSE;
  dmSTK.btTSI.IndexName:='DoIt';
  dmSTK.ptTSI.First;
  Repeat
    If not dmSTK.btTSI.FindKey ([oDocNum,dmSTK.ptTSI.FieldByName('ItmNum').AsInteger]) then begin
      dmSTK.btTSI.Insert;
      PX_To_BTR (dmSTK.ptTSI,dmSTK.btTSI);
      dmSTK.btTSI.Post;
    end
    else begin  // Ak bola zmenena len cena vykoname zmenu
    end;
    Application.ProcessMessages;
    dmSTK.ptTSI.Next;
  until (dmSTK.ptTSI.Eof);
  dmSTK.btTSI.Modify := TRUE;
end;

end.
