unit IcdTxt;
{$F+}

interface

uses
  IcTypes, IcConv, IcTools, IcVariab, IniFiles, SysUtils, NexGlob,
  NexPath, NexIni, TxtWrap, TxtCut, DocHand, TxtDoc, Forms;

type
  TIcdTxt = class
    constructor Create;
    destructor  Destroy; override;
    private
      oDocNum: Str12; // Cislo dokladu ktorym pracujeme
      function LoadTxtToIch:boolean; // Nacita udaje z prenosoveho suboru a vytvori alebo opravy hlavicku FA
      procedure LoadTxtToTmp; // Nacita poloky z prenosoveho suboru do docasneh databaze ptICI
      procedure LoadTxtToIcn; // Nacita poznamky FA
      procedure DeleteIci; // Vymaze polozky doacieho listu, ktore nie su v docasnej databaze
      procedure AddNewItmToIci; // Prida nove polozky do FA
    public
      oCount:word;
      oTxtDoc: TTxtDoc;
      procedure SaveToFile (pDocNum:Str12);  // Ulozi zadany doklad do textoveho suboru
      procedure LoadFromFile (pDocNum:Str12);  // Nacita doklad z textoveho suboru
    published
      property Count:word read oCount;
  end;

implementation

uses
   DM_LDGDAT, DB;

constructor TIcdTxt.Create;
begin
end;

destructor TIcdTxt.Destroy;
begin
end;

procedure TIcdTxt.SaveToFile (pDocNum:Str12);  // Ulozi zadany doklad do textoveho suboru
var mFileName:string;  mLine:word;
begin
  mFileName := gIni.GetZipPath+pDocNum+'.TXT';
  oTxtDoc := TTxtDoc.Create;
  If FileExists (mFileName) then DeleteFile (mFileName);
  oTxtDoc.WriteInteger ('FtpVer',1);
  oTxtDoc.WriteString ('PrgVer',cPrgVer);
  // Nezmenene polia - kompatibilne polia
  oTxtDoc.WriteInteger ('SerNum',dmLDG.btICH.FieldByName('SerNum').AsInteger);
  oTxtDoc.WriteString ('DocNum',dmLDG.btICH.FieldByName('DocNum').AsString);
  oTxtDoc.WriteString ('ExtNum',dmLDG.btICH.FieldByName('ExtNum').AsString);
  oTxtDoc.WriteString ('OcdNum',dmLDG.btICH.FieldByName('OcdNum').AsString);
  oTxtDoc.WriteDate ('DocDate',dmLDG.btICH.FieldByName('DocDate').AsDateTime);
  oTxtDoc.WriteDate ('SndDate',dmLDG.btICH.FieldByName('SndDate').AsDateTime);
  oTxtDoc.WriteDate ('ExpDate',dmLDG.btICH.FieldByName('ExpDate').AsDateTime);
  oTxtDoc.WriteDate ('VatDate',dmLDG.btICH.FieldByName('VatDate').AsDateTime);
  oTxtDoc.WriteString ('CsyCode',dmLDG.btICH.FieldByName('CsyCode').AsString);
  oTxtDoc.WriteInteger ('WriNum',dmLDG.btICH.FieldByName('WriNum').AsInteger);
  oTxtDoc.WriteString ('MyConto',dmLDG.btICH.FieldByName('MyConto').AsString);
  oTxtDoc.WriteInteger ('PaCode',dmLDG.btICH.FieldByName('PaCode').AsInteger);
  oTxtDoc.WriteString ('PaName',dmLDG.btICH.FieldByName('PaName').AsString);
  oTxtDoc.WriteString ('PayCode',dmLDG.btICH.FieldByName('PayCode').AsString);
  oTxtDoc.WriteInteger ('SpaCode',dmLDG.btICH.FieldByName('SpaCode').AsInteger);
  oTxtDoc.WriteString ('TrsCode',dmLDG.btICH.FieldByName('TrsCode').AsString);
  oTxtDoc.WriteString ('RspName',dmLDG.btICH.FieldByName('RspName').AsString);
  oTxtDoc.WriteInteger ('PlsNum',dmLDG.btICH.FieldByName('PlsNum').AsInteger);
  oTxtDoc.WriteFloat ('PrfPrc',dmLDG.btICH.FieldByName('PrfPrc').AsFloat);
  oTxtDoc.WriteInteger ('VatPrc1',dmLDG.btICH.FieldByName('VatPrc1').AsInteger);
  oTxtDoc.WriteInteger ('VatPrc2',dmLDG.btICH.FieldByName('VatPrc2').AsInteger);
  oTxtDoc.WriteInteger ('VatPrc3',dmLDG.btICH.FieldByName('VatPrc3').AsInteger);
  oTxtDoc.WriteInteger ('VatDoc',dmLDG.btICH.FieldByName('VatDoc').AsInteger);
  // Nove polia od v 10.02
  oTxtDoc.WriteInteger ('StkNum',dmLDG.btICH.FieldByName('StkNum').AsInteger);
  oTxtDoc.WriteString ('RegName',dmLDG.btICH.FieldByName('RegName').AsString);
  oTxtDoc.WriteString ('RegIno',dmLDG.btICH.FieldByName('RegIno').AsString);
  oTxtDoc.WriteString ('RegTin',dmLDG.btICH.FieldByName('RegTin').AsString);
  oTxtDoc.WriteString ('RegVin',dmLDG.btICH.FieldByName('RegVin').AsString);
  oTxtDoc.WriteString ('RegAddr',dmLDG.btICH.FieldByName('RegAddr').AsString);
  oTxtDoc.WriteString ('RegSta',dmLDG.btICH.FieldByName('RegSta').AsString);
  oTxtDoc.WriteString ('RegCty',dmLDG.btICH.FieldByName('RegCty').AsString);
  oTxtDoc.WriteString ('RegCtn',dmLDG.btICH.FieldByName('RegCtn').AsString);
  oTxtDoc.WriteString ('RegZip',dmLDG.btICH.FieldByName('RegZip').AsString);
  oTxtDoc.WriteInteger ('IcFacDay',dmLDG.btICH.FieldByName('IcFacDay').AsInteger);
  oTxtDoc.WriteFloat ('IcFacPrc',dmLDG.btICH.FieldByName('IcFacPrc').AsFloat);
  oTxtDoc.WriteString ('PayName',dmLDG.btICH.FieldByName('PayName').AsString);
  oTxtDoc.WriteInteger ('WpaCode',dmLDG.btICH.FieldByName('WpaCode').AsInteger);
  oTxtDoc.WriteString ('WpaName',dmLDG.btICH.FieldByName('WpaName').AsString);
  oTxtDoc.WriteString ('WpaAddr',dmLDG.btICH.FieldByName('WpaAddr').AsString);
  oTxtDoc.WriteString ('WpaSta',dmLDG.btICH.FieldByName('WpaSta').AsString);
  oTxtDoc.WriteString ('WpaCty',dmLDG.btICH.FieldByName('WpaCty').AsString);
  oTxtDoc.WriteString ('WpaCtn',dmLDG.btICH.FieldByName('WpaCtn').AsString);
  oTxtDoc.WriteString ('WpaZip',dmLDG.btICH.FieldByName('WpaZip').AsString);
  oTxtDoc.WriteString ('TrsName',dmLDG.btICH.FieldByName('TrsName').AsString);
  oTxtDoc.WriteString ('AcDvzName',dmLDG.btICH.FieldByName('AcDvzName').AsString);
  oTxtDoc.WriteString ('FgDvzName',dmLDG.btICH.FieldByName('FgDvzName').AsString);
  oTxtDoc.WriteFloat ('FgCourse',dmLDG.btICH.FieldByName('FgCourse').AsFloat);
  oTxtDoc.WriteString ('RcvName',dmLDG.btICH.FieldByName('RcvName').AsString);
  oTxtDoc.WriteInteger ('DlrCode',dmLDG.btICH.FieldByName('DlrCode').AsInteger);
  oTxtDoc.WriteString ('CusCard',dmLDG.btICH.FieldByName('CusCard').AsString);
  oTxtDoc.WriteString ('DocSpc',dmLDG.btICH.FieldByName('DocSpc').AsString);
  oTxtDoc.WriteString ('TcdNum',dmLDG.btICH.FieldByName('TcdNum').AsString);
  oTxtDoc.WriteInteger ('PrnCnt',dmLDG.btICH.FieldByName('PrnCnt').AsInteger);
  oTxtDoc.WriteInteger ('ItmQnt',dmLDG.btICH.FieldByName('ItmQnt').AsInteger);
  oTxtDoc.WriteString ('DstPair',dmLDG.btICH.FieldByName('DstPair').AsString);
  oTxtDoc.WriteInteger ('DstLck',dmLDG.btICH.FieldByName('DstLck').AsInteger);
  oTxtDoc.WriteInteger ('DstCls',dmLDG.btICH.FieldByName('DstCls').AsInteger);
  oTxtDoc.WriteString ('CrtUser',dmLDG.btICH.FieldByName('CrtUser').AsString);
  oTxtDoc.WriteDate ('CrtDate',dmLDG.btICH.FieldByName('CrtDate').AsDateTime);
  oTxtDoc.WriteTime ('CrtTime',dmLDG.btICH.FieldByName('CrtTime').AsDateTime);
  oTxtDoc.WriteString ('ModUser',dmLDG.btICH.FieldByName('ModUser').AsString);
  oTxtDoc.WriteDate ('ModDate',dmLDG.btICH.FieldByName('ModDate').AsDateTime);
  oTxtDoc.WriteTime ('ModTime',dmLDG.btICH.FieldByName('ModTime').AsDateTime);
  oTxtDoc.WriteFloat ('FgPValue',dmLDG.btICH.FieldByName('FgPValue').AsFloat);
  oTxtDoc.WriteFloat ('CrcVal',dmLDG.btICH.FieldByName('CrcVal').AsFloat);
  oTxtDoc.WriteString ('CrCard',dmLDG.btICH.FieldByName('CrCard').AsString);
  oTxtDoc.WriteFloat ('FgDBValue',dmLDG.btICH.FieldByName('FgDBValue').AsFloat);
  oTxtDoc.WriteFloat ('FgDscBVal',dmLDG.btICH.FieldByName('FgDscBVal').AsFloat);
  oTxtDoc.WriteString ('Year',dmLDG.btICH.FieldByName('Year').AsString);
  // Ulozime poloziek dokladu
  If dmLDG.btICI.IndexName<>'DoIt' then dmLDG.btICI.IndexName := 'DoIt';
  dmLDG.btICI.FindNearest ([pDocNum,0]);
  If dmLDG.btICI.FieldByName ('DocNum').AsString=dmLDG.btICH.FieldByName ('DocNum').AsString then begin
    Repeat
      oTxtDoc.Insert;
      // Nova databaza - od v10.02
      oTxtDoc.WriteInteger ('ItmNum',dmLDG.btICI.FieldByName('ItmNum').AsInteger);
      oTxtDoc.WriteInteger ('MgCode',dmLDG.btICI.FieldByName('MgCode').AsInteger);
      oTxtDoc.WriteInteger ('GsCode',dmLDG.btICI.FieldByName('GsCode').AsInteger);
      oTxtDoc.WriteString ('GsName',dmLDG.btICI.FieldByName('GsName').AsString);
      oTxtDoc.WriteString ('BarCode',dmLDG.btICI.FieldByName('BarCode').AsString);
      oTxtDoc.WriteString ('StkCode',dmLDG.btICI.FieldByName('StkCode').AsString);
      oTxtDoc.WriteString ('Notice',dmLDG.btICI.FieldByName('Notice').AsString);
      oTxtDoc.WriteInteger ('StkNum',dmLDG.btICI.FieldByName('StkNum').AsInteger);
      oTxtDoc.WriteFloat ('Volume',dmLDG.btICI.FieldByName('Volume').AsFloat);
      oTxtDoc.WriteFloat ('Weight',dmLDG.btICI.FieldByName('Weight').AsFloat);
      oTxtDoc.WriteInteger ('PackGs',dmLDG.btICI.FieldByName('PackGs').AsInteger);
      oTxtDoc.WriteString ('GsType',dmLDG.btICI.FieldByName('GsType').AsString);
      oTxtDoc.WriteString ('MsName',dmLDG.btICI.FieldByName('MsName').AsString);
      oTxtDoc.WriteFloat ('GsQnt',dmLDG.btICI.FieldByName('GsQnt').AsFloat);
      oTxtDoc.WriteInteger ('VatPrc',dmLDG.btICI.FieldByName('VatPrc').AsInteger);
      oTxtDoc.WriteFloat ('DscPrc',dmLDG.btICI.FieldByName('DscPrc').AsFloat);
      oTxtDoc.WriteFloat ('AcCValue',dmLDG.btICI.FieldByName('AcCValue').AsFloat);
      oTxtDoc.WriteFloat ('AcDValue',dmLDG.btICI.FieldByName('AcDValue').AsFloat);
      oTxtDoc.WriteFloat ('AcDscVal',dmLDG.btICI.FieldByName('AcDscVal').AsFloat);
      oTxtDoc.WriteFloat ('AcAValue',dmLDG.btICI.FieldByName('AcAValue').AsFloat);
      oTxtDoc.WriteFloat ('AcBValue',dmLDG.btICI.FieldByName('AcBValue').AsFloat);
      oTxtDoc.WriteFloat ('FgCPrice',dmLDG.btICI.FieldByName('FgCPrice').AsFloat);
      oTxtDoc.WriteFloat ('FgDPrice',dmLDG.btICI.FieldByName('FgDPrice').AsFloat);
      oTxtDoc.WriteFloat ('FgAPrice',dmLDG.btICI.FieldByName('FgAPrice').AsFloat);
      oTxtDoc.WriteFloat ('FgBPrice',dmLDG.btICI.FieldByName('FgBPrice').AsFloat);
      oTxtDoc.WriteFloat ('FgCValue',dmLDG.btICI.FieldByName('FgCValue').AsFloat);
      oTxtDoc.WriteFloat ('FgDValue',dmLDG.btICI.FieldByName('FgDValue').AsFloat);
      oTxtDoc.WriteFloat ('FgDscVal',dmLDG.btICI.FieldByName('FgDscVal').AsFloat);
      oTxtDoc.WriteFloat ('FgAValue',dmLDG.btICI.FieldByName('FgAValue').AsFloat);
      oTxtDoc.WriteFloat ('FgBValue',dmLDG.btICI.FieldByName('FgBValue').AsFloat);
      oTxtDoc.WriteString ('McdNum',dmLDG.btICI.FieldByName('McdNum').AsString);
      oTxtDoc.WriteInteger ('McdItm',dmLDG.btICI.FieldByName('McdItm').AsInteger);
      oTxtDoc.WriteString ('OcdNum',dmLDG.btICI.FieldByName('OcdNum').AsString);
      oTxtDoc.WriteInteger ('OcdItm',dmLDG.btICI.FieldByName('OcdItm').AsInteger);
      oTxtDoc.WriteString ('TcdNum',dmLDG.btICI.FieldByName('TcdNum').AsString);
      oTxtDoc.WriteInteger ('TcdItm',dmLDG.btICI.FieldByName('TcdItm').AsInteger);
      oTxtDoc.WriteDate ('TcdDate',dmLDG.btICI.FieldByName('TcdDate').AsDateTime);
      oTxtDoc.WriteString ('Status',dmLDG.btICI.FieldByName('Status').AsString);
      oTxtDoc.WriteString ('Action',dmLDG.btICI.FieldByName('Action').AsString);
      oTxtDoc.WriteString ('AccSnt',dmLDG.btICI.FieldByName('AccSnt').AsString);
      oTxtDoc.WriteString ('AccAnl',dmLDG.btICI.FieldByName('AccAnl').AsString);
      oTxtDoc.WriteString ('CrtUser',dmLDG.btICI.FieldByName('CrtUser').AsString);
      oTxtDoc.WriteDate ('CrtDate',dmLDG.btICI.FieldByName('CrtDate').AsDateTime);
      oTxtDoc.WriteTime ('CrtTime',dmLDG.btICI.FieldByName('CrtTime').AsDateTime);
      oTxtDoc.WriteString ('ModUser',dmLDG.btICI.FieldByName('ModUser').AsString);
      oTxtDoc.WriteDate ('ModDate',dmLDG.btICI.FieldByName('ModDate').AsDateTime);
      oTxtDoc.WriteTime ('ModTime',dmLDG.btICI.FieldByName('ModTime').AsDateTime);
      oTxtDoc.WriteString ('DscType',dmLDG.btICI.FieldByName('DscType').AsString);
      oTxtDoc.WriteInteger ('DscGrp',dmLDG.btICI.FieldByName('DscGrp').AsInteger);
      oTxtDoc.WriteString ('IcdNum',dmLDG.btICI.FieldByName('IcdNum').AsString);
      oTxtDoc.WriteInteger ('IcdItm',dmLDG.btICI.FieldByName('IcdItm').AsInteger);
      oTxtDoc.WriteString ('SpMark',dmLDG.btICI.FieldByName('SpMark').AsString);
      oTxtDoc.WriteInteger ('BonNum',dmLDG.btICI.FieldByName('BonNum').AsInteger);
      oTxtDoc.Post;
      Application.ProcessMessages;
      dmLDG.btICI.Next;
    until (dmLDG.btICI.Eof) or (dmLDG.btICI.FieldByName('DocNum').AsString<>pDocNum);
  end;
  // Ulozime poznamky dokladu
  If dmLDG.btICN.IndexName<>'DoNtLn' then dmLDG.btICN.IndexName:='DoNtLn';
  dmLDG.btICN.FindNearest ([pDocNum,'',0]);
  If dmLDG.btICN.FieldByName ('DocNum').AsString=dmLDG.btICN.FieldByName ('DocNum').AsString then begin
    mLine := 0;
    Repeat
      Inc (mLine);
      oTxtDoc.WriteNoti (dmLDG.btICN.FieldByName('NotType').AsString,dmLDG.btICN.FieldByName('LinNum').AsInteger,dmLDG.btICN.FieldByName('Notice').AsString);
      Application.ProcessMessages;
      dmLDG.btICN.Next;
    until (dmLDG.btICN.Eof) or (dmLDG.btICN.FieldByName('DocNum').AsString<>pDocNum);
  end;
  oTxtDoc.SaveToFile (mFileName);
  FreeAndNil (oTxtDoc);
end;

procedure TIcdTxt.LoadFromFile (pDocNum:Str12);  // Nacita doklad z textoveho suboru
var mFileName:string;   mLinNum,I:word;  mNotType:Str1;  mNotice:string;
begin
  oDocNum := pDocNum;
  mFileName := gIni.GetZipPath+pDocNum+'.TXT';
  If FileExists (mFileName) then begin
    oTxtDoc := TTxtDoc.Create;
    oTxtDoc.LoadFromFile (mFileName);
    If LoadTxtToIch then begin // Nacita udaje z prenosoveho suboru a vytvori alebo opravy hlavicku dodacieho listu
      If dmLDG.btICH.FieldByName('ItmQnt').AsInteger>0 then begin  // Ak doklad ma polozky
        // Polozky dokladu
        dmLDG.ptICI.Open;
        dmLDG.ptICI.IndexName := 'ItmNum';
        LoadTxtToTmp; // Nacita poloky z prenosoveho suboru do docasneh databaze ptICI
        DeleteIci; // Vymaze polozky FA, ktore nie su v docasnej databaze
        AddNewItmToIci; // Prida nove polozky do dodacieho listu
        dmLDG.ptICI.Close;
        IchRecalc (dmLDG.btICH,dmLDG.btICI);  // Prepocita hlavicku zadanej FA podla jeho poloziek
      end;
      // Poznamky k dokladu
      If oTxtDoc.NotiCount>0 then begin
        IchNoticeDelete (dmLDG.btICH.FieldByName('DocNum').AsString);
        For I:=1 to oTxtDoc.NotiCount-1 do begin
          oTxtDoc.ReadNoti(I,mNotType,mLinNum,mNotice);
          dmLDG.btICN.Insert;
          dmLDG.btICN.FieldByName ('DocNum').AsString := dmLDG.btICH.FieldByName('DocNum').AsString;
          dmLDG.btICN.FieldByName ('NotType').AsString := mNotType;
          dmLDG.btICN.FieldByName ('LinNum').AsInteger := mLinNum;
          dmLDG.btICN.FieldByName ('Notice').AsString := mNotice;
          dmLDG.btICN.Post;
        end;
      end;
    end;
    FreeAndNil (oTxtDoc);
    DeleteFile (mFileName);
  end;
end;

function TIcdTxt.LoadTxtToIch:boolean; // Nacita udaje z prenosoveho suboru a vytvori alebo opravy hlavicku FA
var mFind:boolean;
begin
  Result := TRUE;
  If dmLDG.btICH.IndexName<>'DocNum' then dmLDG.btICH.IndexName:='DocNum';
  mFind := dmLDG.btICH.FindKey ([oDocNum]);
  If mFind then Result := dmLDG.btICH.FieldByName('DstAcc').AsString<>'A';
  If Result then begin // Ak nie je zauctovany
    If mFind
      then dmLDG.btICH.Edit // Uprava hlavicky dokladu
      else dmLDG.btICH.Insert;  // Novy doklad
    dmLDG.btICH.FieldByName('Year').AsString := oTxtDoc.ReadString ('Year');
    dmLDG.btICH.FieldByName('SerNum').AsInteger := oTxtDoc.ReadInteger ('SerNum');
    dmLDG.btICH.FieldByName('DocNum').AsString := oTxtDoc.ReadString ('DocNum');
    dmLDG.btICH.FieldByName('ExtNum').AsString := oTxtDoc.ReadString ('ExtNum');
    dmLDG.btICH.FieldByName('OcdNum').AsString := oTxtDoc.ReadString ('OcdNum');
    dmLDG.btICH.FieldByName('DocDate').AsDateTime := oTxtDoc.ReadDate ('DocDate');
    dmLDG.btICH.FieldByName('SndDate').AsDateTime := oTxtDoc.ReadDate ('SndDate');
    dmLDG.btICH.FieldByName('ExpDate').AsDateTime := oTxtDoc.ReadDate ('ExpDate');
    dmLDG.btICH.FieldByName('VatDate').AsDateTime := oTxtDoc.ReadDate ('VatDate');
    dmLDG.btICH.FieldByName('CsyCode').AsString := oTxtDoc.ReadString ('CsyCode');
    dmLDG.btICH.FieldByName('WriNum').AsInteger := oTxtDoc.ReadInteger ('WriNum');
    dmLDG.btICH.FieldByName('StkNum').AsInteger := oTxtDoc.ReadInteger ('StkNum');
    dmLDG.btICH.FieldByName('MyConto').AsString := oTxtDoc.ReadString ('MyConto');
    dmLDG.btICH.FieldByName('PaCode').AsInteger := oTxtDoc.ReadInteger ('PaCode');
    dmLDG.btICH.FieldByName('PaName').AsString := oTxtDoc.ReadString ('PaName');
    dmLDG.btICH.FieldByName('RegName').AsString := oTxtDoc.ReadString ('RegName');
    dmLDG.btICH.FieldByName('RegIno').AsString := oTxtDoc.ReadString ('RegIno');
    dmLDG.btICH.FieldByName('RegTin').AsString := oTxtDoc.ReadString ('RegTin');
    dmLDG.btICH.FieldByName('RegVin').AsString := oTxtDoc.ReadString ('RegVin');
    dmLDG.btICH.FieldByName('RegAddr').AsString := oTxtDoc.ReadString ('RegAddr');
    dmLDG.btICH.FieldByName('RegSta').AsString := oTxtDoc.ReadString ('RegSta');
    dmLDG.btICH.FieldByName('RegCty').AsString := oTxtDoc.ReadString ('RegCty');
    dmLDG.btICH.FieldByName('RegCtn').AsString := oTxtDoc.ReadString ('RegCtn');
    dmLDG.btICH.FieldByName('RegZip').AsString := oTxtDoc.ReadString ('RegZip');
    dmLDG.btICH.FieldByName('IcFacDay').AsInteger := oTxtDoc.ReadInteger ('IcFacDay');
    dmLDG.btICH.FieldByName('IcFacPrc').AsFloat := oTxtDoc.ReadFloat ('IcFacPrc');
    dmLDG.btICH.FieldByName('PayCode').AsString := oTxtDoc.ReadString ('PayCode');
    dmLDG.btICH.FieldByName('PayName').AsString := oTxtDoc.ReadString ('PayName');
    dmLDG.btICH.FieldByName('SpaCode').AsInteger := oTxtDoc.ReadInteger ('SpaCode');
    dmLDG.btICH.FieldByName('WpaCode').AsInteger := oTxtDoc.ReadInteger ('WpaCode');
    dmLDG.btICH.FieldByName('WpaName').AsString := oTxtDoc.ReadString ('WpaName');
    dmLDG.btICH.FieldByName('WpaAddr').AsString := oTxtDoc.ReadString ('WpaAddr');
    dmLDG.btICH.FieldByName('WpaSta').AsString := oTxtDoc.ReadString ('WpaSta');
    dmLDG.btICH.FieldByName('WpaCty').AsString := oTxtDoc.ReadString ('WpaCty');
    dmLDG.btICH.FieldByName('WpaCtn').AsString := oTxtDoc.ReadString ('WpaCtn');
    dmLDG.btICH.FieldByName('WpaZip').AsString := oTxtDoc.ReadString ('WpaZip');
    dmLDG.btICH.FieldByName('TrsCode').AsString := oTxtDoc.ReadString ('TrsCode');
    dmLDG.btICH.FieldByName('TrsName').AsString := oTxtDoc.ReadString ('TrsName');
    dmLDG.btICH.FieldByName('RspName').AsString := oTxtDoc.ReadString ('RspName');
    dmLDG.btICH.FieldByName('PlsNum').AsInteger := oTxtDoc.ReadInteger ('PlsNum');
    dmLDG.btICH.FieldByName('PrfPrc').AsFloat := oTxtDoc.ReadFloat ('PrfPrc');
    dmLDG.btICH.FieldByName('VatPrc1').AsInteger := oTxtDoc.ReadInteger ('VatPrc1');
    dmLDG.btICH.FieldByName('VatPrc2').AsInteger := oTxtDoc.ReadInteger ('VatPrc2');
    dmLDG.btICH.FieldByName('VatPrc3').AsInteger := oTxtDoc.ReadInteger ('VatPrc3');
    dmLDG.btICH.FieldByName('AcDvzName').AsString := oTxtDoc.ReadString ('AcDvzName');
    dmLDG.btICH.FieldByName('FgDvzName').AsString := oTxtDoc.ReadString ('FgDvzName');
    dmLDG.btICH.FieldByName('FgCourse').AsFloat := oTxtDoc.ReadFloat ('FgCourse');
    dmLDG.btICH.FieldByName('RcvName').AsString := oTxtDoc.ReadString ('RcvName');
    dmLDG.btICH.FieldByName('DlrCode').AsInteger := oTxtDoc.ReadInteger ('DlrCode');
    dmLDG.btICH.FieldByName('CusCard').AsString := oTxtDoc.ReadString ('CusCard');
    dmLDG.btICH.FieldByName('VatDoc').AsInteger := oTxtDoc.ReadInteger ('VatDoc');
    dmLDG.btICH.FieldByName('DocSpc').AsInteger := oTxtDoc.ReadInteger ('DocSpc');
    dmLDG.btICH.FieldByName('TcdNum').AsString := oTxtDoc.ReadString ('TcdNum');
    dmLDG.btICH.FieldByName('PrnCnt').AsInteger := oTxtDoc.ReadInteger ('PrnCnt');
    dmLDG.btICH.FieldByName('ItmQnt').AsInteger := oTxtDoc.ReadInteger ('ItmQnt');
    dmLDG.btICH.FieldByName('DstPair').AsString := oTxtDoc.ReadString ('DstPair');
    dmLDG.btICH.FieldByName('DstLck').AsInteger := oTxtDoc.ReadInteger ('DstLck');
    dmLDG.btICH.FieldByName('DstCls').AsInteger := oTxtDoc.ReadInteger ('DstCls');
    dmLDG.btICH.FieldByName('CrtUser').AsString := oTxtDoc.ReadString ('CrtUser');
    dmLDG.btICH.FieldByName('CrtDate').AsDateTime := oTxtDoc.ReadDate ('CrtDate');
    dmLDG.btICH.FieldByName('CrtTime').AsDateTime := oTxtDoc.ReadTime ('CrtTime');
    dmLDG.btICH.FieldByName('ModUser').AsString := oTxtDoc.ReadString ('ModUser');
    dmLDG.btICH.FieldByName('ModDate').AsDateTime := oTxtDoc.ReadDate ('ModDate');
    dmLDG.btICH.FieldByName('ModTime').AsDateTime := oTxtDoc.ReadTime ('ModTime');
    dmLDG.btICH.FieldByName('FgPValue').AsFloat := oTxtDoc.ReadFloat ('FgPValue');
    dmLDG.btICH.FieldByName('CrcVal').AsFloat := oTxtDoc.ReadFloat ('CrcVal');
    dmLDG.btICH.FieldByName('CrCard').AsString := oTxtDoc.ReadString ('CrCard');
    dmLDG.btICH.FieldByName('FgDBValue').AsFloat := oTxtDoc.ReadFloat ('FgDBValue');
    dmLDG.btICH.FieldByName('FgDscBVal').AsFloat := oTxtDoc.ReadFloat ('FgDscBVal');
    dmLDG.btICH.Post;
  end;
end;

procedure TIcdTxt.LoadTxtToTmp; // Nacita poloky z prenosoveho suboru do docasneh databaze ptTCI
begin
  If oTxtDoc.ItemCount>0 then begin
    // Ulozime polozky do docasneho suboru
    oTxtDoc.First;
    Repeat
      If not dmLDG.ptICI.FindKey([oTxtDoc.ReadInteger ('ItmNum')]) then begin
        dmLDG.ptICI.Insert;
        dmLDG.ptICI.FieldByName('DocNum').AsString := dmLDG.btICH.FieldByName('DocNum').AsString;
        dmLDG.ptICI.FieldByName('ItmNum').AsInteger := oTxtDoc.ReadInteger ('ItmNum');
        dmLDG.ptICI.FieldByName('RowNum').AsInteger := dmLDG.ptICI.RecordCount+1;
        dmLDG.ptICI.FieldByName('MgCode').AsInteger := oTxtDoc.ReadInteger ('MgCode');
        dmLDG.ptICI.FieldByName('GsCode').AsInteger := oTxtDoc.ReadInteger ('GsCode');
        dmLDG.ptICI.FieldByName('GsName').AsString := oTxtDoc.ReadString ('GsName');
        dmLDG.ptICI.FieldByName('BarCode').AsString := oTxtDoc.ReadString ('BarCode');
        dmLDG.ptICI.FieldByName('StkCode').AsString := oTxtDoc.ReadString ('StkCode');
        dmLDG.ptICI.FieldByName('Notice').AsString := oTxtDoc.ReadString ('Notice');
        dmLDG.ptICI.FieldByName('StkNum').AsInteger := oTxtDoc.ReadInteger ('StkNum');
        dmLDG.ptICI.FieldByName('Volume').AsFloat := oTxtDoc.ReadFloat ('Volume');
        dmLDG.ptICI.FieldByName('Weight').AsFloat := oTxtDoc.ReadFloat ('Weight');
        dmLDG.ptICI.FieldByName('PackGs').AsInteger := oTxtDoc.ReadInteger ('PackGs');
        dmLDG.ptICI.FieldByName('GsType').AsString := oTxtDoc.ReadString ('GsType');
        dmLDG.ptICI.FieldByName('MsName').AsString := oTxtDoc.ReadString ('MsName');
        dmLDG.ptICI.FieldByName('GsQnt').AsFloat := oTxtDoc.ReadFloat ('GsQnt');
        dmLDG.ptICI.FieldByName('VatPrc').AsInteger := oTxtDoc.ReadInteger ('VatPrc');
        dmLDG.ptICI.FieldByName('DscPrc').AsFloat := oTxtDoc.ReadFloat ('DscPrc');
        dmLDG.ptICI.FieldByName('AcCValue').AsFloat := oTxtDoc.ReadFloat ('AcCValue');
        dmLDG.ptICI.FieldByName('AcDValue').AsFloat := oTxtDoc.ReadFloat ('AcDValue');
        dmLDG.ptICI.FieldByName('AcDscVal').AsFloat := oTxtDoc.ReadFloat ('AcDscVal');
        dmLDG.ptICI.FieldByName('AcAValue').AsFloat := oTxtDoc.ReadFloat ('AcAValue');
        dmLDG.ptICI.FieldByName('AcBValue').AsFloat := oTxtDoc.ReadFloat ('AcBValue');
        dmLDG.ptICI.FieldByName('FgCPrice').AsFloat := oTxtDoc.ReadFloat ('FgCPrice');
        dmLDG.ptICI.FieldByName('FgDPrice').AsFloat := oTxtDoc.ReadFloat ('FgDPrice');
        dmLDG.ptICI.FieldByName('FgAPrice').AsFloat := oTxtDoc.ReadFloat ('FgAPrice');
        dmLDG.ptICI.FieldByName('FgBPrice').AsFloat := oTxtDoc.ReadFloat ('FgBPrice');
        dmLDG.ptICI.FieldByName('FgCValue').AsFloat := oTxtDoc.ReadFloat ('FgCValue');
        dmLDG.ptICI.FieldByName('FgDValue').AsFloat := oTxtDoc.ReadFloat ('FgDValue');
        dmLDG.ptICI.FieldByName('FgDscVal').AsFloat := oTxtDoc.ReadFloat ('FgDscVal');
        dmLDG.ptICI.FieldByName('FgAValue').AsFloat := oTxtDoc.ReadFloat ('FgAValue');
        dmLDG.ptICI.FieldByName('FgBValue').AsFloat := oTxtDoc.ReadFloat ('FgBValue');
        dmLDG.ptICI.FieldByName('DlrCode').AsInteger := dmLDG.btICH.FieldByName('DlrCode').AsInteger;
        dmLDG.ptICI.FieldByName('DocDate').AsDateTime := dmLDG.btICH.FieldByName('DocDate').AsDateTime;
        dmLDG.ptICI.FieldByName('PaCode').AsInteger := dmLDG.btICH.FieldByName('PaCode').AsInteger;
        dmLDG.ptICI.FieldByName('McdNum').AsString := oTxtDoc.ReadString ('McdNum');
        dmLDG.ptICI.FieldByName('McdItm').AsInteger := oTxtDoc.ReadInteger ('McdItm');
        dmLDG.ptICI.FieldByName('OcdNum').AsString := oTxtDoc.ReadString ('OcdNum');
        dmLDG.ptICI.FieldByName('OcdItm').AsInteger := oTxtDoc.ReadInteger ('OcdItm');
        dmLDG.ptICI.FieldByName('TcdNum').AsString := oTxtDoc.ReadString ('TcdNum');
        dmLDG.ptICI.FieldByName('TcdItm').AsInteger := oTxtDoc.ReadInteger ('TcdItm');
        dmLDG.ptICI.FieldByName('TcdDate').AsDateTime := oTxtDoc.ReadDate ('TcdDate');
        dmLDG.ptICI.FieldByName('Status').AsString := oTxtDoc.ReadString ('Status');
        dmLDG.ptICI.FieldByName('Action').AsString := oTxtDoc.ReadString ('Action');
        dmLDG.ptICI.FieldByName('AccSnt').AsString := oTxtDoc.ReadString ('AccSnt');
        dmLDG.ptICI.FieldByName('AccAnl').AsString := oTxtDoc.ReadString ('AccAnl');
        dmLDG.ptICI.FieldByName('CrtUser').AsString := oTxtDoc.ReadString ('CrtUse');
        dmLDG.ptICI.FieldByName('CrtDate').AsDateTime := oTxtDoc.ReadDate ('CrtDate');
        dmLDG.ptICI.FieldByName('CrtTime').AsDateTime := oTxtDoc.ReadTime ('CrtTime');
        dmLDG.ptICI.FieldByName('ModUser').AsString := oTxtDoc.ReadString ('ModUse');
        dmLDG.ptICI.FieldByName('ModDate').AsDateTime := oTxtDoc.ReadDate ('ModDate');
        dmLDG.ptICI.FieldByName('ModTime').AsDateTime := oTxtDoc.ReadTime ('ModTime');
        dmLDG.ptICI.FieldByName('DscType').AsString := oTxtDoc.ReadString ('DscType');
        dmLDG.ptICI.FieldByName('DscGrp').AsInteger := oTxtDoc.ReadInteger ('DscGrp');
        dmLDG.ptICI.FieldByName('IcdNum').AsString := oTxtDoc.ReadString ('IcdNum');
        dmLDG.ptICI.FieldByName('IcdItm').AsInteger := oTxtDoc.ReadInteger ('IcdItm');
        dmLDG.ptICI.FieldByName('SpMark').AsString := oTxtDoc.ReadString ('SpMark');
        dmLDG.ptICI.FieldByName('BonNum').AsInteger := oTxtDoc.ReadInteger ('BonNum');
        dmLDG.ptICI.Post;
      end;
      oTxtDoc.Next;
      Application.ProcessMessages;
    until oTxtDoc.Eof;
  end;
end;

procedure TIcdTxt.LoadTxtToIcn; // Nacita poloky z prenosoveho suboru do docasneh databaze ptTCI
begin
end;

procedure TIcdTxt.DeleteIci; // Vymaze polozky doacieho listu, ktore nie su v docasnej databaze
begin
  If dmLDG.btICI.IndexName<>'DocNum' then dmLDG.btICI.IndexName:='DocNum';
  If dmLDG.btICI.FindKey ([oDocNum]) then begin
    Repeat
      Application.ProcessMessages;
      dmLDG.btICI.Delete; // Zrusime polozku FA
    until (dmLDG.btICI.Eof) or (dmLDG.btICI.RecordCount=0) or (dmLDG.btICI.FieldByName('DocNum').AsString<>oDocNum);
  end;
end;

procedure TIcdTxt.AddNewItmToIci; // Prida nove polozky do dodacieho listu
begin
  dmLDG.ptICI.First;
  dmLDG.btICI.Sended := FALSE;
  dmLDG.btICI.Modify := FALSE;
  dmLDG.btICI.IndexName:='DoIt';
  dmLDG.btICI.First;
  Repeat
    If not dmLDG.btICI.FindKey ([oDocNum,dmLDG.ptICI.FieldByName('ItmNum').AsInteger]) then begin
      dmLDG.btICI.Insert;
      PX_To_BTR (dmLDG.ptICI,dmLDG.btICI);
      dmLDG.btICI.Post;
    end
    else begin  // Ak bola zmenena len cena vykoname zmenu
    end;
    Application.ProcessMessages;
    dmLDG.ptICI.Next;
  until (dmLDG.ptICI.Eof);
  dmLDG.btICI.Modify := TRUE;
  dmLDG.btICI.Sended := TRUE;
end;

end.
