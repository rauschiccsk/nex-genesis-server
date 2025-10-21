unit WsdTxt;
{$F+}

interface

uses
  IcTypes, IcConv, IcTools, IniFiles, SysUtils, IcVariab, NexPath, NexIni,
  TxtWrap, TxtCut, StkCanc, DocHand, TxtDoc, Forms;

type
  TWsdTxt = class
    constructor Create;
    destructor  Destroy; override;
    private
      oDocNum: Str12; // Cislo dokladu ktorym pracujeme
      procedure LoadTxtToWsh; // Nacita udaje z prenosoveho suboru a vytvori alebo opravy hlavicku prijemky
      procedure LoadTxtToTmp; // Nacita poloky z prenosoveho suboru do docasneh databaze ptWSI
      procedure DeleteDocItm; // Vymaze polozky dokladu
      procedure AddNewDocItm; // Prida nove polozky do dokladu
    public
      oCount: word;
      oTxtDoc: TTxtDoc;
      procedure SaveToFile (pDocNum:Str12;pFileName:ShortString);  // Ulozi zadany doklad do textoveho suboru
      procedure SaveConFile; // Ulozi potvrdenku
      procedure LoadFromFile (pDocNum:Str12);  // Nacita doklad z textoveho suboru
      procedure LoadNewDoc (pFileName:ShortString);  // Nacita obsah suboru do noveho dokladu
      procedure LoadConFile(pArcPath,pFileName:ShortString); // Nacita potvrdenku
    published
      property Count:word read oCount;
  end;

implementation

uses
   DM_STKDAT;

constructor TWsdTxt.Create;
begin
end;

destructor TWsdTxt.Destroy;
begin
end;

procedure TWsdTxt.SaveToFile (pDocNum:Str12;pFileName:ShortString);  // Ulozi zadany doklad do textoveho suboru
var  mPdnQnt:word;   mWrap:TTxtWrap;
begin
  oTxtDoc := TTxtDoc.Create;
  If FileExists (pFileName) then DeleteFile (pFileName);
  // Ulozime hlacivku dokladu
  oTxtDoc.WriteInteger ('SerNum',dmSTK.btWSH.FieldByName('SerNum').AsInteger);
  oTxtDoc.WriteString ('DocNum',dmSTK.btWSH.FieldByName('DocNum').AsString);
  oTxtDoc.WriteDate ('DocDate',dmSTK.btWSH.FieldByName('DocDate').AsDateTime);
  oTxtDoc.WriteInteger ('StkNum',dmSTK.btWSH.FieldByName('StkNum').AsInteger);
  oTxtDoc.WriteInteger ('SmCode',dmSTK.btWSH.FieldByName('SmCode').AsInteger);
  oTxtDoc.WriteInteger ('PaCode',dmSTK.btWSH.FieldByName('PaCode').AsInteger);
  oTxtDoc.WriteString ('PaName',dmSTK.btWSH.FieldByName('PaName').AsString);
  oTxtDoc.WriteString ('RegName',dmSTK.btWSH.FieldByName('RegName').AsString);
  oTxtDoc.WriteString ('RegIno',dmSTK.btWSH.FieldByName('RegIno').AsString);
  oTxtDoc.WriteString ('RegTin',dmSTK.btWSH.FieldByName('RegTin').AsString);
  oTxtDoc.WriteString ('RegVin',dmSTK.btWSH.FieldByName('RegVin').AsString);
  oTxtDoc.WriteString ('RegAddr',dmSTK.btWSH.FieldByName('RegAddr').AsString);
  oTxtDoc.WriteString ('RegSta',dmSTK.btWSH.FieldByName('RegSta').AsString);
  oTxtDoc.WriteString ('RegCty',dmSTK.btWSH.FieldByName('RegCty').AsString);
  oTxtDoc.WriteString ('RegCtn',dmSTK.btWSH.FieldByName('RegCtn').AsString);
  oTxtDoc.WriteString ('RegZip',dmSTK.btWSH.FieldByName('RegZip').AsString);
  oTxtDoc.WriteInteger ('SpaCode',dmSTK.btWSH.FieldByName('SpaCode').AsInteger);
  oTxtDoc.WriteInteger ('WpaCode',dmSTK.btWSH.FieldByName('WpaCode').AsInteger);
  oTxtDoc.WriteString ('WpaName',dmSTK.btWSH.FieldByName('WpaName').AsString);
  oTxtDoc.WriteString ('WpaAddr',dmSTK.btWSH.FieldByName('WpaAddr').AsString);
  oTxtDoc.WriteString ('WpaSta',dmSTK.btWSH.FieldByName('WpaSta').AsString);
  oTxtDoc.WriteString ('WpaCty',dmSTK.btWSH.FieldByName('WpaCty').AsString);
  oTxtDoc.WriteString ('WpaCtn',dmSTK.btWSH.FieldByName('WpaCtn').AsString);
  oTxtDoc.WriteString ('WpaZip',dmSTK.btWSH.FieldByName('WpaZip').AsString);
  oTxtDoc.WriteInteger ('InpQnt',dmSTK.btWSH.FieldByName('InpQnt').AsInteger);
  oTxtDoc.WriteInteger ('OutQnt',dmSTK.btWSH.FieldByName('OutQnt').AsInteger);
  oTxtDoc.WriteInteger ('ActQnt',dmSTK.btWSH.FieldByName('ActQnt').AsInteger);
  oTxtDoc.WriteInteger ('PcoQnt',dmSTK.btWSH.FieldByName('PcoQnt').AsInteger);
  oTxtDoc.WriteInteger ('PciQnt',dmSTK.btWSH.FieldByName('PciQnt').AsInteger);
  oTxtDoc.WriteString ('OutDate1',dmSTK.btWSH.FieldByName('OutDate1').AsString);
  oTxtDoc.WriteString ('OutDate2',dmSTK.btWSH.FieldByName('OutDate2').AsString);
  oTxtDoc.WriteString ('OutDate3',dmSTK.btWSH.FieldByName('OutDate3').AsString);
  oTxtDoc.WriteString ('OutDate4',dmSTK.btWSH.FieldByName('OutDate4').AsString);
  oTxtDoc.WriteInteger ('PrnCnt',dmSTK.btWSH.FieldByName('PrnCnt').AsInteger);
  oTxtDoc.WriteInteger ('DstLck',dmSTK.btWSH.FieldByName('DstLck').AsInteger);
  oTxtDoc.WriteString ('IcdNum',dmSTK.btWSH.FieldByName('IcdNum').AsString);
  oTxtDoc.WriteString ('CrtUser',dmSTK.btWSH.FieldByName('CrtUser').AsString);
  oTxtDoc.WriteString ('CrtDate',dmSTK.btWSH.FieldByName('CrtDate').AsString);
  oTxtDoc.WriteString ('CrtTime',dmSTK.btWSH.FieldByName('CrtTime').AsString);
  oTxtDoc.WriteString ('ModUser',dmSTK.btWSH.FieldByName('ModUser').AsString);
  oTxtDoc.WriteString ('ModDate',dmSTK.btWSH.FieldByName('ModDate').AsString);
  oTxtDoc.WriteString ('ModTime',dmSTK.btWSH.FieldByName('ModTime').AsString);
  oTxtDoc.WriteString ('LouDate',dmSTK.btWSH.FieldByName('LouDate').AsString);
  oTxtDoc.WriteString ('TelWork',dmSTK.btWSH.FieldByName('TelWork').AsString);
  oTxtDoc.WriteString ('TelMob',dmSTK.btWSH.FieldByName('TelMob').AsString);
  oTxtDoc.WriteString ('PlnDate1',dmSTK.btWSH.FieldByName('PlnDate1').AsString);
  oTxtDoc.WriteString ('PlnDate2',dmSTK.btWSH.FieldByName('PlnDate2').AsString);
  oTxtDoc.WriteString ('PlnDate3',dmSTK.btWSH.FieldByName('PlnDate3').AsString);
  oTxtDoc.WriteString ('PlnDate4',dmSTK.btWSH.FieldByName('PlnDate4').AsString);
  oTxtDoc.WriteInteger ('SanType1',dmSTK.btWSH.FieldByName('SanType1').AsInteger);
  oTxtDoc.WriteInteger ('SanType2',dmSTK.btWSH.FieldByName('SanType2').AsInteger);
  oTxtDoc.WriteInteger ('SanType3',dmSTK.btWSH.FieldByName('SanType3').AsInteger);
  oTxtDoc.WriteInteger ('SanType4',dmSTK.btWSH.FieldByName('SanType4').AsInteger);
  oTxtDoc.WriteInteger ('SndWri',gvSys.WriNum);
  oTxtDoc.WriteDate ('SndDate',Date);
  oTxtDoc.WriteTime ('SndTime',Time);
  // Ulozime poloziek dokladu
  If dmSTK.btWSI.IndexName<>'DoIt' then dmSTK.btWSI.IndexName := 'DoIt';
  dmSTK.btWSI.FindNearest ([pDocNum,0]);
  If dmSTK.btWSI.FieldByName ('DocNum').AsString=dmSTK.btWSH.FieldByName ('DocNum').AsString then begin
    Repeat
      oTxtDoc.Insert;
      oTxtDoc.WriteInteger ('ItmNum',dmSTK.btWSI.FieldByName('ItmNum').AsInteger);
      oTxtDoc.WriteInteger ('GsCode',dmSTK.btWSI.FieldByName('GsCode').AsInteger);
      oTxtDoc.WriteString ('GsName',dmSTK.btWSI.FieldByName('GsName').AsString);
      oTxtDoc.WriteString ('BarCode',dmSTK.btWSI.FieldByName('BarCode').AsString);
      oTxtDoc.WriteString ('MsName',dmSTK.btWSI.FieldByName('MsName').AsString);
      oTxtDoc.WriteInteger ('PackGs',dmSTK.btWSI.FieldByName('PackGs').AsInteger);
      oTxtDoc.WriteFloat ('GsQnt',dmSTK.btWSI.FieldByName('GsQnt').AsFloat);
      oTxtDoc.WriteString ('Notice',dmSTK.btWSI.FieldByName('Notice').AsString);
      oTxtDoc.WriteString ('OmdNum',dmSTK.btWSI.FieldByName('OmdNum').AsString);
      oTxtDoc.WriteInteger ('OmdItm',dmSTK.btWSI.FieldByName('OmdItm').AsInteger);
      oTxtDoc.WriteString ('IcdNum',dmSTK.btWSI.FieldByName('IcdNum').AsString);
      oTxtDoc.WriteInteger ('IcdItm',dmSTK.btWSI.FieldByName('IcdItm').AsInteger);
      oTxtDoc.WriteString ('CrtUser',dmSTK.btWSI.FieldByName('CrtUser').AsString);
      oTxtDoc.WriteString ('CrtDate',dmSTK.btWSI.FieldByName('CrtDate').AsString);
      oTxtDoc.WriteString ('CrtTime',dmSTK.btWSI.FieldByName('CrtTime').AsString);
      oTxtDoc.WriteInteger ('ModNum',dmSTK.btWSI.FieldByName('ModNum').AsInteger);
      oTxtDoc.WriteString ('ModUser',dmSTK.btWSI.FieldByName('ModUser').AsString);
      oTxtDoc.WriteString ('ModDate',dmSTK.btWSI.FieldByName('ModDate').AsString);
      oTxtDoc.WriteString ('ModTime',dmSTK.btWSI.FieldByName('ModTime').AsString);
      oTxtDoc.WriteString ('LouDate',dmSTK.btWSI.FieldByName('LouDate').AsString);
      oTxtDoc.WriteString ('IcdType',dmSTK.btWSI.FieldByName('IcdType').AsString);
      oTxtDoc.Post;
      Application.ProcessMessages;
      dmSTK.btWSI.Next;
    until (dmSTK.btWSI.Eof) or (dmSTK.btWSI.FieldByName('DocNum').AsString<>pDocNum);

{
    // Ulozime poznamky dokladu
    If dmSTK.btIMN.IndexName<>'DoNtLn' then dmSTK.btIMN.IndexName:='DoNtLn';
    dmSTK.btIMN.FindNearest ([pDocNum,'',0]);
    If dmSTK.btWSI.FieldByName ('DocNum').AsString=dmSTK.btWSH.FieldByName ('DocNum').AsString then begin
      mLine := 0;
      Repeat
        Inc (mLine);
        oFile.WriteString ('NOTICES','Line'+StrInt(mLine,0),dmSTK.btIMN.FieldByName('Notice').AsString);
      until (dmSTK.btTSN.Eof) or (dmSTK.btIMN.FieldByName('DocNum').AsString<>pDocNum);
    end;
}
  end;
  oTxtDoc.SaveToFile (pFileName);
  FreeAndNil (oTxtDoc);
end;

procedure TWsdTxt.SaveConFile; // Ulozi potvrdenku
var mFileName:ShortString; mFile:TIniFile;
begin
  mFileName := gIni.GetZipPath+dmSTK.btWSH.FieldByName('SndDoc').AsString+'.TMP';
  If FileExists (mFileName) then DeleteFile (mFileName);
  mFile := TIniFile.Create(mFileName);
  mFile.WriteInteger ('HEAD','SerNum',dmSTK.btWSH.FieldByName('SerNum').AsInteger);
  mFile.WriteString ('HEAD','DocNum',dmSTK.btWSH.FieldByName('DocNum').AsString);
  mFile.WriteDate ('HEAD','DocDate',dmSTK.btWSH.FieldByName('DocDate').AsDateTime);
  mFile.WriteInteger ('HEAD','PaCode',dmSTK.btWSH.FieldByName('PaCode').AsInteger);
  mFile.WriteInteger ('HEAD','ItmQnt',dmSTK.btWSH.FieldByName('ItmQnt').AsInteger);
  mFile.WriteString ('HEAD','RcvDate',dmSTK.btWSH.FieldByName('RcvDate').AsString);
  mFile.WriteString ('HEAD','RcvTime',dmSTK.btWSH.FieldByName('RcvTime').AsString);
  FreeAndNil (mFile);
end;

procedure TWsdTxt.LoadFromFile (pDocNum:Str12);  // Nacita doklad z textoveho suboru
var mFileName:string;
begin
  oDocNum := pDocNum;
  If not DirectoryExists (gIni.GetZipPath) then ForceDirectories (gIni.GetZipPath);
  mFileName := gIni.GetZipPath+pDocNum+'.TXT';
  If FileExists (mFileName) then begin
    oTxtDoc := TTxtDoc.Create;
    oTxtDoc.LoadFromFile (mFileName);
    LoadTxtToWsh; // Nacita udaje z prenosoveho suboru a vytvori alebo opravy hlavicku prijemky
    If dmSTK.btWSH.FieldByName('ItmQnt').AsInteger>0 then begin  // Ak doklad ma polozky
      // Polozky dokladu
      dmSTK.ptWSI.Open;
      dmSTK.ptWSI.IndexName := 'ItmNum';
      LoadTxtToTmp; // Nacita poloky z prenosoveho suboru do docasneh databaze ptWSI
      DeleteDocItm; // Vymaze polozky vydajky, ktore nie su v docasnej databaze
      AddNewDocItm; // Prida nove polozky do vydajky
      dmSTK.ptWSI.Close;
      OmhRecalc (dmSTK.btWSH,dmSTK.btWSI);  // Prepocita hlavicku zadaneho dodacieho listu podla jeho poloziek
    end;
    // Poznamky k dokladu
    FreeAndNil (oTxtDoc);
    DeleteFile (mFileName);
  end;
end;

procedure TWsdTxt.LoadNewDoc (pFileName:ShortString);  // Nacita obsah suboru do noveho dokladu
var mSerNum,mItmNum:word;   mDocNum:Str12;
begin
  oTxtDoc := TTxtDoc.Create;
  oTxtDoc.LoadFromFile (pFileName);
  If not dmSTK.btWSH.FindKey([oTxtDoc.ReadString('DocNum')]) then begin
    // Urcime nove cislo dokladu
    dmSTK.btWSH.IndexName := 'SerNum';
    dmSTK.btWSH.Last;
    mSerNum := dmSTK.btWSH.FieldByName ('SerNum').AsInteger+1;
    mDocNum := 'AV'+dmSTK.btWSBLST.FieldByName('BookNum').AsString+StrIntZero(mSerNum,5);
    // Nacitame hlavicku dokladu
    dmSTK.btWSH.Insert;
    dmSTK.btWSH.FieldByName('SerNum').AsInteger := mSerNum;
    dmSTK.btWSH.FieldByName('DocNum').AsString := mDocNum;
    dmSTK.btWSH.FieldByName('DocDate').AsDateTime := oTxtDoc.ReadDate('DocDate');
    dmSTK.btWSH.FieldByName('StkNum').AsInteger := dmSTK.btWSBLST.FieldByName('StkNum').AsInteger;
    dmSTK.btWSH.FieldByName('SmCode').AsInteger := oTxtDoc.ReadInteger('SmCode');
    dmSTK.btWSH.FieldByName('PaCode').AsInteger := oTxtDoc.ReadInteger('PaCode');
    dmSTK.btWSH.FieldByName('PaName').AsString := oTxtDoc.ReadString('PaName');
    dmSTK.btWSH.FieldByName('RegName').AsString := oTxtDoc.ReadString('RegName');
    dmSTK.btWSH.FieldByName('RegIno').AsString := oTxtDoc.ReadString('RegIno');
    dmSTK.btWSH.FieldByName('RegTin').AsString := oTxtDoc.ReadString('RegTin');
    dmSTK.btWSH.FieldByName('RegVin').AsString := oTxtDoc.ReadString('RegVin');
    dmSTK.btWSH.FieldByName('RegAddr').AsString := oTxtDoc.ReadString('RegAddr');
    dmSTK.btWSH.FieldByName('RegSta').AsString := oTxtDoc.ReadString('RegSta');
    dmSTK.btWSH.FieldByName('RegCty').AsString := oTxtDoc.ReadString('RegCty');
    dmSTK.btWSH.FieldByName('RegCtn').AsString := oTxtDoc.ReadString('RegCtn');
    dmSTK.btWSH.FieldByName('RegZip').AsString := oTxtDoc.ReadString('RegZip');
    dmSTK.btWSH.FieldByName('SpaCode').AsInteger := oTxtDoc.ReadInteger('SpaCode');
    dmSTK.btWSH.FieldByName('WpaCode').AsInteger := oTxtDoc.ReadInteger('WpaCode');
    dmSTK.btWSH.FieldByName('WpaName').AsString := oTxtDoc.ReadString('WpaName');
    dmSTK.btWSH.FieldByName('WpaAddr').AsString := oTxtDoc.ReadString('WpaAddr');
    dmSTK.btWSH.FieldByName('WpaSta').AsString := oTxtDoc.ReadString('WpaSta');
    dmSTK.btWSH.FieldByName('WpaCty').AsString := oTxtDoc.ReadString('WpaCty');
    dmSTK.btWSH.FieldByName('WpaCtn').AsString := oTxtDoc.ReadString('WpaCtn');
    dmSTK.btWSH.FieldByName('WpaZip').AsString := oTxtDoc.ReadString('WpaZip');
    dmSTK.btWSH.FieldByName('InpQnt').AsInteger := oTxtDoc.ReadInteger('InpQnt');
    dmSTK.btWSH.FieldByName('OutQnt').AsInteger := oTxtDoc.ReadInteger('OutQnt');
    dmSTK.btWSH.FieldByName('ActQnt').AsInteger := oTxtDoc.ReadInteger('ActQnt');
    dmSTK.btWSH.FieldByName('PcoQnt').AsInteger := oTxtDoc.ReadInteger('PcoQnt');
    dmSTK.btWSH.FieldByName('PciQnt').AsInteger := oTxtDoc.ReadInteger('PciQnt');
    dmSTK.btWSH.FieldByName('OutDate1').AsString := oTxtDoc.ReadString('OutDate1');
    dmSTK.btWSH.FieldByName('OutDate2').AsString := oTxtDoc.ReadString('OutDate2');
    dmSTK.btWSH.FieldByName('OutDate3').AsString := oTxtDoc.ReadString('OutDate3');
    dmSTK.btWSH.FieldByName('OutDate4').AsString := oTxtDoc.ReadString('OutDate3');
    dmSTK.btWSH.FieldByName('PrnCnt').AsInteger := oTxtDoc.ReadInteger('PrnCnt');
    dmSTK.btWSH.FieldByName('IcdNum').AsString := oTxtDoc.ReadString('IcdNum');
    dmSTK.btWSH.FieldByName('CrtUser').AsString := oTxtDoc.ReadString('CrtUser');
    dmSTK.btWSH.FieldByName('CrtDate').AsString := oTxtDoc.ReadString('CrtDate');
    dmSTK.btWSH.FieldByName('CrtTime').AsString := oTxtDoc.ReadString('CrtTime');
    dmSTK.btWSH.FieldByName('LouDate').AsString := oTxtDoc.ReadString('LouDate');
    dmSTK.btWSH.FieldByName('TelWork').AsString := oTxtDoc.ReadString('TelWork');
    dmSTK.btWSH.FieldByName('TelMob').AsString := oTxtDoc.ReadString('TelMob');
    dmSTK.btWSH.FieldByName('PlnDate1').AsString := oTxtDoc.ReadString('PlnDate1');
    dmSTK.btWSH.FieldByName('PlnDate2').AsString := oTxtDoc.ReadString('PlnDate2');
    dmSTK.btWSH.FieldByName('PlnDate3').AsString := oTxtDoc.ReadString('PlnDate3');
    dmSTK.btWSH.FieldByName('PlnDate4').AsString := oTxtDoc.ReadString('PlnDate4');
    dmSTK.btWSH.FieldByName('SanType1').AsInteger := oTxtDoc.ReadInteger('SanType1');
    dmSTK.btWSH.FieldByName('SanType2').AsInteger := oTxtDoc.ReadInteger('SanType2');
    dmSTK.btWSH.FieldByName('SanType3').AsInteger := oTxtDoc.ReadInteger('SanType3');
    dmSTK.btWSH.FieldByName('SanType4').AsInteger := oTxtDoc.ReadInteger('SanType4');
    dmSTK.btWSH.FieldByName('SndWri').AsInteger := oTxtDoc.ReadInteger('SndWri');
    dmSTK.btWSH.FieldByName('SndDoc').AsString := oTxtDoc.ReadString('DocNum');
    dmSTK.btWSH.FieldByName('SndDate').AsString := oTxtDoc.ReadString('SndDate');
    dmSTK.btWSH.FieldByName('SndTime').AsString := oTxtDoc.ReadString('SndTime');
    dmSTK.btWSH.FieldByName('RcvDate').AsDateTime := Date;
    dmSTK.btWSH.FieldByName('RcvTime').AsDateTime := Time;
    dmSTK.btWSH.Post;
    If oTxtDoc.ItemCount>0 then begin  // Ak doklad ma polozky
      // Polozky dokladu
      oTxtDoc.First;
      mItmNum := 0;
      Repeat
        Inc (mItmNum);
        dmSTK.btWSI.Insert;
        dmSTK.btWSI.FieldByName('DocNum').AsString := mDocNum;
        dmSTK.btWSI.FieldByName('ItmNum').AsInteger := mItmNum;
        dmSTK.btWSI.FieldByName('GsCode').AsInteger := oTxtDoc.ReadInteger('GsCode');
        dmSTK.btWSI.FieldByName('GsName').AsString := oTxtDoc.ReadString('GsName');
        dmSTK.btWSI.FieldByName('BarCode').AsString := oTxtDoc.ReadString('BarCode');
        dmSTK.btWSI.FieldByName('MsName').AsString := oTxtDoc.ReadString('MsName');
        dmSTK.btWSI.FieldByName('PackGs').AsInteger := oTxtDoc.ReadInteger('PackGs');
        dmSTK.btWSI.FieldByName('GsQnt').AsFloat := oTxtDoc.ReadFloat('GsQnt');
        dmSTK.btWSI.FieldByName('Notice').AsString := oTxtDoc.ReadString('Notice');
        dmSTK.btWSI.FieldByName('OmdNum').AsString := oTxtDoc.ReadString('OmdNum');
        dmSTK.btWSI.FieldByName('OmdItm').AsInteger := oTxtDoc.ReadInteger('OmdItm');
        dmSTK.btWSI.FieldByName('IcdNum').AsString := oTxtDoc.ReadString('IcdNum');
        dmSTK.btWSI.FieldByName('IcdItm').AsInteger := oTxtDoc.ReadInteger('IcdItm');
        dmSTK.btWSI.FieldByName('DocDate').AsString := dmSTK.btWSH.FieldByName('DocDate').AsString;
        dmSTK.btWSI.FieldByName('CrtUser').AsString := oTxtDoc.ReadString('CrtUser');
        dmSTK.btWSI.FieldByName('CrtDate').AsString := oTxtDoc.ReadString('CrtDate');
        dmSTK.btWSI.FieldByName('CrtTime').AsString := oTxtDoc.ReadString('CrtTime');
        dmSTK.btWSI.FieldByName('ModNum').AsInteger := oTxtDoc.ReadInteger('ModNum');
        dmSTK.btWSI.FieldByName('ModUser').AsString := oTxtDoc.ReadString('ModUser');
        dmSTK.btWSI.FieldByName('ModDate').AsString := oTxtDoc.ReadString('ModDate');
        dmSTK.btWSI.FieldByName('ModTime').AsString := oTxtDoc.ReadString('ModTime');
        dmSTK.btWSI.FieldByName('LouDate').AsString := oTxtDoc.ReadString('LouDate');
        dmSTK.btWSI.FieldByName('IcdType').AsString := oTxtDoc.ReadString('IcdType');
        dmSTK.btWSI.Post;
        Application.ProcessMessages;
        oTxtDoc.Next;
      until oTxtDoc.Eof;
      WshRecalc (dmSTK.btWSH,dmSTK.btWSI);  // Prepocita hlavicku zadaneho dodacieho listu podla jeho poloziek
    end;
  end;
  FreeAndNil (oTxtDoc);
end;

procedure TWsdTxt.LoadConFile(pArcPath,pFileName:ShortString); // Nacita potvrdenku
var mFile:TIniFile; mDocNum:Str12;
begin
  If FileExists (pArcPath+pFileName) then begin
    mFile := TIniFile.Create(pArcPath+pFileName);
    mDocNum := copy (pFileName,1,12);
    If dmSTK.btWSH.IndexName<>'DocNum' then dmSTK.btWSH.IndexName := 'DocNum';
    If dmSTK.btWSH.FindKey([mDocNum]) then begin
      dmSTK.btWSH.Edit;
      If (dmSTK.btWSH.FieldByName ('PaCode').AsInteger=mFile.ReadInteger('HEAD','PaCode',0)) and (dmSTK.btWSH.FieldByName ('ItmQnt').AsInteger=mFile.ReadInteger('HEAD','ItmQnt',0)) then begin
        dmSTK.btWSH.FieldByName ('RcvDoc').AsString := mFile.ReadString('HEAD','DocNum','');
        dmSTK.btWSH.FieldByName ('RcvDate').AsString := mFile.ReadString('HEAD','RcvDate','');
        dmSTK.btWSH.FieldByName ('RcvTime').AsString := mFile.ReadString('HEAD','RcvTime','');
      end
      else dmSTK.btWSH.FieldByName ('RcvDoc').AsString := 'ERROR';
      dmSTK.btWSH.Post;
    end;
    FreeAndNil (mFile);
  end;
end;

procedure TWsdTxt.LoadTxtToWsh; // Nacita udaje z prenosoveho suboru a vytvori alebo opravy hlavicku dodacieho listu
begin
  If dmSTK.btWSH.IndexName<>'DocNum' then dmSTK.btWSH.IndexName:='DocNum';
  If dmSTK.btWSH.FindKey ([oDocNum])
    then dmSTK.btWSH.Edit     // Uprava hlavicky dokladu
    else dmSTK.btWSH.Insert;  // Novy doklad
  dmSTK.btWSH.FieldByName('SerNum').AsInteger := oTxtDoc.ReadInteger ('SerNum');
  dmSTK.btWSH.FieldByName('DocNum').AsString := oTxtDoc.ReadString ('DocNum');
  dmSTK.btWSH.FieldByName('StkNum').AsInteger := oTxtDoc.ReadInteger ('StkNum');
  dmSTK.btWSH.FieldByName('DocDate').AsDateTime := oTxtDoc.ReadDate ('DocDate');
  dmSTK.btWSH.FieldByName('Describe').AsString := oTxtDoc.ReadString ('Describe');
  dmSTK.btWSH.FieldByName('CrtUser').AsString := oTxtDoc.ReadString ('CrtUser');
  dmSTK.btWSH.FieldByName('PlsNum').AsInteger := oTxtDoc.ReadInteger ('PlsNum');
  dmSTK.btWSH.FieldByName('SmCode').AsInteger := oTxtDoc.ReadInteger ('SmCode');
  dmSTK.btWSH.FieldByName('VatPrc1').AsFloat := oTxtDoc.ReadInteger ('VatPrc1');
  dmSTK.btWSH.FieldByName('VatPrc2').AsFloat := oTxtDoc.ReadInteger ('VatPrc2');
  dmSTK.btWSH.FieldByName('VatPrc3').AsFloat := oTxtDoc.ReadInteger ('VatPrc3');
  dmSTK.btWSH.FieldByName('ModUser').AsString := oTxtDoc.ReadString ('ModUser');
  dmSTK.btWSH.FieldByName('ModDate').AsDateTime := oTxtDoc.ReadDate ('ModDate');
  dmSTK.btWSH.FieldByName('ModTime').AsDateTime := oTxtDoc.ReadTime ('ModTime');
  dmSTK.btWSH.FieldByName('ItmQnt').AsInteger := oTxtDoc.ReadInteger ('ItmQnt');
  dmSTK.btWSH.FieldByName('OcdNum').AsString := oTxtDoc.ReadString ('OcdNum');
  dmSTK.btWSH.Post;
end;

procedure TWsdTxt.LoadTxtToTmp; // Nacita poloky z prenosoveho suboru do docasneh databaze ptWSI
begin
  If oTxtDoc.ItemCount>0 then begin
    // Ulozime polozky do docasneho suboru
    oTxtDoc.First;
    Repeat
      If not dmSTK.ptWSI.FindKey ([oTxtDoc.ReadInteger ('ItmNum')]) then begin
        dmSTK.ptWSI.Insert;
        dmSTK.ptWSI.FieldByName('DocNum').AsString := oDocNum;
        dmSTK.ptWSI.FieldByName('ItmNum').AsInteger := oTxtDoc.ReadInteger ('ItmNum');
        dmSTK.ptWSI.FieldByName('GsCode').AsInteger := oTxtDoc.ReadInteger ('GsCode');
        dmSTK.ptWSI.FieldByName('MgCode').AsInteger := oTxtDoc.ReadInteger ('MgCode');
        dmSTK.ptWSI.FieldByName('GsName').AsString := oTxtDoc.ReadString ('GsName');
        dmSTK.ptWSI.FieldByName('BarCode').AsString := oTxtDoc.ReadString ('BarCode');
        dmSTK.ptWSI.FieldByName('StkCode').AsString := oTxtDoc.ReadString ('StkCode');
        dmSTK.ptWSI.FieldByName('StkNum').AsInteger := oTxtDoc.ReadInteger ('StkNum');
        dmSTK.ptWSI.FieldByName('GsQnt').AsFloat := oTxtDoc.ReadFloat ('GsQnt');
        dmSTK.ptWSI.FieldByName('MsName').AsString := oTxtDoc.ReadString ('MsName');
        dmSTK.ptWSI.FieldByName('VatPrc').AsFloat := oTxtDoc.ReadFloat ('VatPrc');
        dmSTK.ptWSI.FieldByName('CPrice').AsFloat := oTxtDoc.ReadFloat ('CPrice');
        dmSTK.ptWSI.FieldByName('EPrice').AsFloat := oTxtDoc.ReadFloat ('EPrice');
        dmSTK.ptWSI.FieldByName('CValue').AsFloat := oTxtDoc.ReadFloat ('CValue');
        dmSTK.ptWSI.FieldByName('EValue').AsFloat := oTxtDoc.ReadFloat ('EValue');
        dmSTK.ptWSI.FieldByName('AValue').AsFloat := oTxtDoc.ReadFloat ('AValue');
        dmSTK.ptWSI.FieldByName('BValue').AsFloat := oTxtDoc.ReadFloat ('BValue');
        dmSTK.ptWSI.FieldByName('StkStat').AsString := oTxtDoc.ReadString ('StkStat');
        dmSTK.ptWSI.FieldByName('ModUser').AsString := oTxtDoc.ReadString ('ModUser');
        dmSTK.ptWSI.FieldByName('ModDate').AsDateTime := oTxtDoc.ReadDate ('ModDate');
        dmSTK.ptWSI.FieldByName('ModTime').AsDateTime := oTxtDoc.ReadTime ('ModTime');
        dmSTK.ptWSI.Post;
      end;
      otxtDoc.Next;
      Application.ProcessMessages;
    until oTxtDoc.Eof;
  end;
end;

procedure TWsdTxt.DeleteDocItm; // Vymaze polozky doacieho listu, ktore nie su v docasnej databaze
begin
  If dmSTK.btWSI.IndexName<>'DocNum' then dmSTK.btWSI.IndexName:='DocNum';
  If dmSTK.btWSI.FindKey ([oDocNum]) then begin
    Repeat
      Application.ProcessMessages;
      dmSTK.btWSI.Delete // Zrusime polozku dokladu
    until (dmSTK.btWSI.Eof) or (dmSTK.btWSI.RecordCount=0) or (dmSTK.btWSI.FieldByName('DocNum').AsString<>oDocNum);
  end;
end;

procedure TWsdTxt.AddNewDocItm; // Prida nove polozky do dodacieho listu
begin
(*
  dmSTK.btWSI.Modify := FALSE;
  dmSTK.btWSI.IndexName:='DoIt';
  dmSTK.ptWSI.First;
  Repeat
    If not dmSTK.btWSI.FindKey ([oDocNum,dmSTK.ptWSI.FieldByName('ItmNum').AsInteger]) then begin
      dmSTK.btWSI.Insert;
      dmSTK.btWSI.FieldByName ('ItmNum').AsInteger := dmSTK.ptWSI.FieldByName ('ItmNum').AsInteger;
      dmSTK.btWSI.FieldByName ('DocNum').AsString := oDocNum;
      dmSTK.btWSI.FieldByName ('MgCode').AsInteger := dmSTK.ptWSI.FieldByName ('MgCode').AsInteger;
      dmSTK.btWSI.FieldByName ('GsCode').AsInteger := dmSTK.ptWSI.FieldByName ('GsCode').AsInteger;
      dmSTK.btWSI.FieldByName ('GsName').AsString := dmSTK.ptWSI.FieldByName ('GsName').AsString;
      dmSTK.btWSI.FieldByName ('BarCode').AsString := dmSTK.ptWSI.FieldByName ('BarCode').AsString;
      dmSTK.btWSI.FieldByName ('StkCode').AsString := dmSTK.ptWSI.FieldByName ('StkCode').AsString;
      dmSTK.btWSI.FieldByName ('StkNum').AsInteger := dmSTK.ptWSI.FieldByName ('StkNum').AsInteger;
      dmSTK.btWSI.FieldByName ('MsName').AsString := dmSTK.ptWSI.FieldByName ('MsName').AsString;
      dmSTK.btWSI.FieldByName ('GsQnt').AsFloat := dmSTK.ptWSI.FieldByName ('GsQnt').AsFloat;
      dmSTK.btWSI.FieldByName ('VatPrc').AsFloat := dmSTK.ptWSI.FieldByName ('VatPrc').AsFloat;
      dmSTK.btWSI.FieldByName ('CPrice').AsFloat := dmSTK.ptWSI.FieldByName ('CPrice').AsFloat;
      dmSTK.btWSI.FieldByName ('EPrice').AsFloat := dmSTK.ptWSI.FieldByName ('EPrice').AsFloat;
      dmSTK.btWSI.FieldByName ('CValue').AsFloat := dmSTK.ptWSI.FieldByName ('CValue').AsFloat;
      dmSTK.btWSI.FieldByName ('EValue').AsFloat := dmSTK.ptWSI.FieldByName ('EValue').AsFloat;
      dmSTK.btWSI.FieldByName ('AValue').AsFloat := dmSTK.ptWSI.FieldByName ('AValue').AsFloat;
      dmSTK.btWSI.FieldByName ('BValue').AsFloat := dmSTK.ptWSI.FieldByName ('BValue').AsFloat;
      dmSTK.btWSI.FieldByName ('StkStat').AsString := 'N';
      dmSTK.btWSI.FieldByName ('ModNum').AsInteger := dmSTK.ptWSI.FieldByName ('ModNum').AsInteger;
      dmSTK.btWSI.FieldByName ('ModUser').AsString := dmSTK.ptWSI.FieldByName ('ModUser').AsString;
      dmSTK.btWSI.FieldByName ('ModDate').AsDateTime := dmSTK.ptWSI.FieldByName ('ModDate').AsDateTime;
      dmSTK.btWSI.FieldByName ('ModTime').AsDateTime := dmSTK.ptWSI.FieldByName ('ModTime').AsDateTime;
      dmSTK.btWSI.Post;
    end
    else begin  // Ak bola zmenena len cena vykoname zmenu

    end;
    Application.ProcessMessages;
    dmSTK.ptWSI.Next;
  until (dmSTK.ptWSI.Eof);
  dmSTK.btWSI.Modify := TRUE;
*)
end;

end.
