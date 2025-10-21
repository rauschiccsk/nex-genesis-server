unit TbdTxt;
{$F+}

interface

uses
  IcTypes, IcConv, IcTools, IniFiles, SysUtils, NexPath, NexIni,
  TxtWrap, TxtCut, StkCanc, DocHand, TxtDoc, Forms;


type
  TTbdTxt = class
    constructor Create;
    destructor  Destroy;
    private
      oDocNum: Str12; // Cislo dokladu ktorym pracujeme
      procedure LoadTxtToTbh; // Nacita udaje z prenosoveho suboru a vytvori alebo opravy hlavicku dokladu
      procedure LoadTxtToTmp; // Nacita poloky z prenosoveho suboru do docasneh databaze ptTCI
      procedure DeleteTbi; // Vymaze polozky doacieho listu, ktore nie su v docasnej databaze
      procedure AddNewItmToTbi; // Prida nove polozky do dodacieho listu
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
   DM_CABDAT;

constructor TTbdTxt.Create;
begin
end;

destructor TTbdTxt.Destroy;
begin
end;

procedure TTbdTxt.SaveToFile (pDocNum:Str12);  // Ulozi zadany doklad do textoveho suboru
var mFileName:string;
begin
  mFileName := gIni.GetZipPath+pDocNum+'.TXT';
  oTxtDoc := TTxtDoc.Create;
  If FileExists (mFileName) then DeleteFile (mFileName);
  // Ulozime hlacivku dokladu
  oTxtDoc.WriteInteger ('SerNum',dmCAB.btTBH.FieldByName('SerNum').AsInteger);
  oTxtDoc.WriteString ('DocNum',dmCAB.btTBH.FieldByName('DocNum').AsString);
  oTxtDoc.WriteDate ('SalDate',dmCAB.btTBH.FieldByName('SalDate').AsDateTime);
  oTxtDoc.WriteInteger ('CasNum',dmCAB.btTBH.FieldByName('CasNum').AsInteger);
  oTxtDoc.WriteInteger ('StkNum',dmCAB.btTBH.FieldByName('StkNum').AsInteger);
  oTxtDoc.WriteInteger ('ItmCount',dmCAB.btTBH.FieldByName('ItmCount').AsInteger);
  oTxtDoc.WriteInteger ('LItmCount',dmCAB.btTBH.FieldByName('LItmCount').AsInteger);
  oTxtDoc.WriteInteger ('PItmCount',dmCAB.btTBH.FieldByName('PItmCount').AsInteger);
  oTxtDoc.WriteInteger ('PrnCount',dmCAB.btTBH.FieldByName('PrnCount').AsInteger);
  oTxtDoc.WriteInteger ('PDocNum',dmCAB.btTBH.FieldByName('PDocNum').AsInteger);
  oTxtDoc.WriteInteger ('RDocNum',dmCAB.btTBH.FieldByName('RDocNum').AsInteger);
  oTxtDoc.WriteFloat ('CValue1',dmCAB.btTBH.FieldByName('CValue1').AsFloat);
  oTxtDoc.WriteFloat ('CValue2',dmCAB.btTBH.FieldByName('CValue2').AsFloat);
  oTxtDoc.WriteFloat ('CValue3',dmCAB.btTBH.FieldByName('CValue3').AsFloat);
  oTxtDoc.WriteFloat ('CValue0',dmCAB.btTBH.FieldByName('CValue0').AsFloat);
  oTxtDoc.WriteFloat ('VatPrc1',dmCAB.btTBH.FieldByName('VatPrc1').AsFloat);
  oTxtDoc.WriteFloat ('VatPrc2',dmCAB.btTBH.FieldByName('VatPrc2').AsFloat);
  oTxtDoc.WriteFloat ('VatPrc3',dmCAB.btTBH.FieldByName('VatPrc3').AsFloat);
  oTxtDoc.WriteFloat ('AValue1',dmCAB.btTBH.FieldByName('AValue1').AsFloat);
  oTxtDoc.WriteFloat ('AValue2',dmCAB.btTBH.FieldByName('AValue2').AsFloat);
  oTxtDoc.WriteFloat ('AValue3',dmCAB.btTBH.FieldByName('AValue2').AsFloat);
  oTxtDoc.WriteFloat ('AValue0',dmCAB.btTBH.FieldByName('AValue0').AsFloat);
  oTxtDoc.WriteFloat ('BValue1',dmCAB.btTBH.FieldByName('BValue1').AsFloat);
  oTxtDoc.WriteFloat ('BValue2',dmCAB.btTBH.FieldByName('BValue2').AsFloat);
  oTxtDoc.WriteFloat ('BValue3',dmCAB.btTBH.FieldByName('BValue3').AsFloat);
  oTxtDoc.WriteFloat ('BValue0',dmCAB.btTBH.FieldByName('BValue0').AsFloat);
  oTxtDoc.WriteFloat ('VatVal1',dmCAB.btTBH.FieldByName('VatVal1').AsFloat);
  oTxtDoc.WriteFloat ('VatVal2',dmCAB.btTBH.FieldByName('VatVal2').AsFloat);
  oTxtDoc.WriteFloat ('VatVal3',dmCAB.btTBH.FieldByName('VatVal3').AsFloat);
  oTxtDoc.WriteFloat ('VatVal0',dmCAB.btTBH.FieldByName('VatVal0').AsFloat);
  oTxtDoc.WriteFloat ('PAValue1',dmCAB.btTBH.FieldByName('PAValue1').AsFloat);
  oTxtDoc.WriteFloat ('PAValue2',dmCAB.btTBH.FieldByName('PAValue2').AsFloat);
  oTxtDoc.WriteFloat ('PAValue3',dmCAB.btTBH.FieldByName('PAValue3').AsFloat);
  oTxtDoc.WriteFloat ('PAValue0',dmCAB.btTBH.FieldByName('PAValue0').AsFloat);
  oTxtDoc.WriteFloat ('PBValue1',dmCAB.btTBH.FieldByName('PBValue1').AsFloat);
  oTxtDoc.WriteFloat ('PBValue2',dmCAB.btTBH.FieldByName('PBValue2').AsFloat);
  oTxtDoc.WriteFloat ('PBValue3',dmCAB.btTBH.FieldByName('PBValue3').AsFloat);
  oTxtDoc.WriteFloat ('PBValue0',dmCAB.btTBH.FieldByName('PBValue0').AsFloat);
  oTxtDoc.WriteFloat ('PVatVal1',dmCAB.btTBH.FieldByName('PVatVal1').AsFloat);
  oTxtDoc.WriteFloat ('PVatVal2',dmCAB.btTBH.FieldByName('PVatVal2').AsFloat);
  oTxtDoc.WriteFloat ('PVatVal3',dmCAB.btTBH.FieldByName('PVatVal3').AsFloat);
  oTxtDoc.WriteFloat ('PVatVal0',dmCAB.btTBH.FieldByName('PVatVal0').AsFloat);
  oTxtDoc.WriteFloat ('BegVal0',dmCAB.btTBH.FieldByName('BegVal0').AsFloat);
  oTxtDoc.WriteFloat ('BegVal1',dmCAB.btTBH.FieldByName('BegVal1').AsFloat);
  oTxtDoc.WriteFloat ('BegVal2',dmCAB.btTBH.FieldByName('BegVal2').AsFloat);
  oTxtDoc.WriteFloat ('BegVal3',dmCAB.btTBH.FieldByName('BegVal3').AsFloat);
  oTxtDoc.WriteFloat ('BegVal4',dmCAB.btTBH.FieldByName('BegVal4').AsFloat);
  oTxtDoc.WriteFloat ('BegVal5',dmCAB.btTBH.FieldByName('BegVal5').AsFloat);
  oTxtDoc.WriteFloat ('BegVal6',dmCAB.btTBH.FieldByName('BegVal6').AsFloat);
  oTxtDoc.WriteFloat ('BegVal7',dmCAB.btTBH.FieldByName('BegVal7').AsFloat);
  oTxtDoc.WriteFloat ('BegVal8',dmCAB.btTBH.FieldByName('BegVal8').AsFloat);
  oTxtDoc.WriteFloat ('BegVal9',dmCAB.btTBH.FieldByName('BegVal9').AsFloat);
  oTxtDoc.WriteFloat ('TrnVal0',dmCAB.btTBH.FieldByName('TrnVal0').AsFloat);
  oTxtDoc.WriteFloat ('TrnVal1',dmCAB.btTBH.FieldByName('TrnVal1').AsFloat);
  oTxtDoc.WriteFloat ('TrnVal2',dmCAB.btTBH.FieldByName('TrnVal2').AsFloat);
  oTxtDoc.WriteFloat ('TrnVal3',dmCAB.btTBH.FieldByName('TrnVal3').AsFloat);
  oTxtDoc.WriteFloat ('TrnVal4',dmCAB.btTBH.FieldByName('TrnVal4').AsFloat);
  oTxtDoc.WriteFloat ('TrnVal5',dmCAB.btTBH.FieldByName('TrnVal5').AsFloat);
  oTxtDoc.WriteFloat ('TrnVal6',dmCAB.btTBH.FieldByName('TrnVal6').AsFloat);
  oTxtDoc.WriteFloat ('TrnVal7',dmCAB.btTBH.FieldByName('TrnVal7').AsFloat);
  oTxtDoc.WriteFloat ('TrnVal8',dmCAB.btTBH.FieldByName('TrnVal8').AsFloat);
  oTxtDoc.WriteFloat ('TrnVal9',dmCAB.btTBH.FieldByName('TrnVal9').AsFloat);
  oTxtDoc.WriteFloat ('Expense0',dmCAB.btTBH.FieldByName('Expense0').AsFloat);
  oTxtDoc.WriteFloat ('Expense1',dmCAB.btTBH.FieldByName('Expense1').AsFloat);
  oTxtDoc.WriteFloat ('Expense2',dmCAB.btTBH.FieldByName('Expense2').AsFloat);
  oTxtDoc.WriteFloat ('Expense3',dmCAB.btTBH.FieldByName('Expense3').AsFloat);
  oTxtDoc.WriteFloat ('Expense4',dmCAB.btTBH.FieldByName('Expense4').AsFloat);
  oTxtDoc.WriteFloat ('Expense5',dmCAB.btTBH.FieldByName('Expense5').AsFloat);
  oTxtDoc.WriteFloat ('Expense6',dmCAB.btTBH.FieldByName('Expense6').AsFloat);
  oTxtDoc.WriteFloat ('Expense7',dmCAB.btTBH.FieldByName('Expense7').AsFloat);
  oTxtDoc.WriteFloat ('Expense8',dmCAB.btTBH.FieldByName('Expense8').AsFloat);
  oTxtDoc.WriteFloat ('Expense9',dmCAB.btTBH.FieldByName('Expense9').AsFloat);
  oTxtDoc.WriteFloat ('ChangeIn0',dmCAB.btTBH.FieldByName('ChangeIn0').AsFloat);
  oTxtDoc.WriteFloat ('ChangeIn1',dmCAB.btTBH.FieldByName('ChangeIn1').AsFloat);
  oTxtDoc.WriteFloat ('ChangeIn2',dmCAB.btTBH.FieldByName('ChangeIn2').AsFloat);
  oTxtDoc.WriteFloat ('ChangeIn3',dmCAB.btTBH.FieldByName('ChangeIn3').AsFloat);
  oTxtDoc.WriteFloat ('ChangeIn4',dmCAB.btTBH.FieldByName('ChangeIn4').AsFloat);
  oTxtDoc.WriteFloat ('ChangeIn5',dmCAB.btTBH.FieldByName('ChangeIn5').AsFloat);
  oTxtDoc.WriteFloat ('ChangeIn6',dmCAB.btTBH.FieldByName('ChangeIn6').AsFloat);
  oTxtDoc.WriteFloat ('ChangeIn7',dmCAB.btTBH.FieldByName('ChangeIn7').AsFloat);
  oTxtDoc.WriteFloat ('ChangeIn8',dmCAB.btTBH.FieldByName('ChangeIn8').AsFloat);
  oTxtDoc.WriteFloat ('ChangeIn9',dmCAB.btTBH.FieldByName('ChangeIn9').AsFloat);
  oTxtDoc.WriteFloat ('ChangeOut0',dmCAB.btTBH.FieldByName('ChangeOut0').AsFloat);
  oTxtDoc.WriteFloat ('ChangeOut1',dmCAB.btTBH.FieldByName('ChangeOut1').AsFloat);
  oTxtDoc.WriteFloat ('ChangeOut2',dmCAB.btTBH.FieldByName('ChangeOut2').AsFloat);
  oTxtDoc.WriteFloat ('ChangeOut3',dmCAB.btTBH.FieldByName('ChangeOut3').AsFloat);
  oTxtDoc.WriteFloat ('ChangeOut4',dmCAB.btTBH.FieldByName('ChangeOut4').AsFloat);
  oTxtDoc.WriteFloat ('ChangeOut5',dmCAB.btTBH.FieldByName('ChangeOut5').AsFloat);
  oTxtDoc.WriteFloat ('ChangeOut6',dmCAB.btTBH.FieldByName('ChangeOut6').AsFloat);
  oTxtDoc.WriteFloat ('ChangeOut7',dmCAB.btTBH.FieldByName('ChangeOut7').AsFloat);
  oTxtDoc.WriteFloat ('ChangeOut8',dmCAB.btTBH.FieldByName('ChangeOut8').AsFloat);
  oTxtDoc.WriteString ('PayName0',dmCAB.btTBH.FieldByName('PayName0').AsString);
  oTxtDoc.WriteString ('PayName1',dmCAB.btTBH.FieldByName('PayName1').AsString);
  oTxtDoc.WriteString ('PayName2',dmCAB.btTBH.FieldByName('PayName2').AsString);
  oTxtDoc.WriteString ('PayName3',dmCAB.btTBH.FieldByName('PayName3').AsString);
  oTxtDoc.WriteString ('PayName4',dmCAB.btTBH.FieldByName('PayName4').AsString);
  oTxtDoc.WriteString ('PayName5',dmCAB.btTBH.FieldByName('PayName5').AsString);
  oTxtDoc.WriteString ('PayName6',dmCAB.btTBH.FieldByName('PayName6').AsString);
  oTxtDoc.WriteString ('PayName7',dmCAB.btTBH.FieldByName('PayName7').AsString);
  oTxtDoc.WriteString ('PayName8',dmCAB.btTBH.FieldByName('PayName8').AsString);
  oTxtDoc.WriteString ('PayName9',dmCAB.btTBH.FieldByName('PayName9').AsString);
  oTxtDoc.WriteFloat ('ClmVal',dmCAB.btTBH.FieldByName('ClmVal').AsFloat);
  oTxtDoc.WriteFloat ('NegVal',dmCAB.btTBH.FieldByName('NegVal').AsFloat);
  oTxtDoc.WriteFloat ('DscVal',dmCAB.btTBH.FieldByName('DscVal').AsFloat);
  oTxtDoc.WriteFloat ('Cancel',dmCAB.btTBH.FieldByName('Cancel').AsFloat);
  oTxtDoc.WriteFloat ('Income',dmCAB.btTBH.FieldByName('Income').AsFloat);
  oTxtDoc.WriteString ('Status1',dmCAB.btTBH.FieldByName('Status1').AsString);
  oTxtDoc.WriteString ('Status2',dmCAB.btTBH.FieldByName('Status2').AsString);
  oTxtDoc.WriteString ('Status3',dmCAB.btTBH.FieldByName('Status3').AsString);
  oTxtDoc.WriteString ('Status4',dmCAB.btTBH.FieldByName('Status4').AsString);
  oTxtDoc.WriteString ('Status5',dmCAB.btTBH.FieldByName('Status5').AsString);
  oTxtDoc.WriteString ('Status6',dmCAB.btTBH.FieldByName('Status6').AsString);
  oTxtDoc.WriteString ('Status7',dmCAB.btTBH.FieldByName('Status7').AsString);
  oTxtDoc.WriteString ('Status8',dmCAB.btTBH.FieldByName('Status8').AsString);
  oTxtDoc.WriteString ('Status9',dmCAB.btTBH.FieldByName('Status9').AsString);
  oTxtDoc.WriteString ('Status10',dmCAB.btTBH.FieldByName('Status10').AsString);
  oTxtDoc.WriteString ('Status11',dmCAB.btTBH.FieldByName('Status11').AsString);
  oTxtDoc.WriteString ('Status12',dmCAB.btTBH.FieldByName('Status12').AsString);
  oTxtDoc.WriteString ('CrtName',dmCAB.btTBH.FieldByName('CrtName').AsString);
  oTxtDoc.WriteDate ('CrtDate',dmCAB.btTBH.FieldByName('CrtDate').AsDateTime);
  oTxtDoc.WriteTime ('CrtTime',dmCAB.btTBH.FieldByName('CrtTime').AsDateTime);
  oTxtDoc.WriteString ('ModName',dmCAB.btTBH.FieldByName('ModName').AsString);
  oTxtDoc.WriteDate ('ModDate',dmCAB.btTBH.FieldByName('ModDate').AsDateTime);
  oTxtDoc.WriteTime ('ModTime',dmCAB.btTBH.FieldByName('ModTime').AsDateTime);

  // Ulozime poloziek dokladu
  dmCAB.btTBI.IndexName := 'DocNum';
  If dmCAB.btTBI.Findkey ([pDocNum]) then begin
    dmCAB.btTBI.Sended := FALSE;
    Repeat
      If dmCAB.btTBI.FieldByName('Sended').AsInteger=0 then begin
        oTxtDoc.Insert;
        oTxtDoc.WriteDate ('SalDate',dmCAB.btTBI.FieldByName('SalDate').AsDateTime);
        oTxtDoc.WriteInteger ('CasNum',dmCAB.btTBI.FieldByName('CasNum').AsInteger);
        oTxtDoc.WriteInteger ('MgCode',dmCAB.btTBI.FieldByName('MgCode').AsInteger);
        oTxtDoc.WriteInteger ('GsCode',dmCAB.btTBI.FieldByName('GsCode').AsInteger);
        oTxtDoc.WriteString ('GsName',dmCAB.btTBI.FieldByName('GsName').AsString);
        oTxtDoc.WriteString ('BarCode',dmCAB.btTBI.FieldByName('BarCode').AsString);
        oTxtDoc.WriteString ('StCode',dmCAB.btTBI.FieldByName('StCode').AsString);
        oTxtDoc.WriteInteger ('StkNum',dmCAB.btTBI.FieldByName('StkNum').AsInteger);
        oTxtDoc.WriteFloat ('SeQnt',dmCAB.btTBI.FieldByName('SeQnt').AsFloat);
        oTxtDoc.WriteFloat ('DSuQnt',dmCAB.btTBI.FieldByName('DSuQnt').AsFloat);
        oTxtDoc.WriteFloat ('PSuQnt',dmCAB.btTBI.FieldByName('PSuQnt').AsFloat);
        oTxtDoc.WriteFloat ('TSuQnt',dmCAB.btTBI.FieldByName('TSuQnt').AsFloat);
        oTxtDoc.WriteFloat ('CValue',dmCAB.btTBI.FieldByName('CValue').AsFloat);
        oTxtDoc.WriteFloat ('VatPrc',dmCAB.btTBI.FieldByName('VatPrc').AsFloat);
        oTxtDoc.WriteFloat ('DValue',dmCAB.btTBI.FieldByName('DValue').AsFloat);
        oTxtDoc.WriteFloat ('TValue',dmCAB.btTBI.FieldByName('TValue').AsFloat);
        oTxtDoc.WriteFloat ('PAValue',dmCAB.btTBI.FieldByName('PAValue').AsFloat);
        oTxtDoc.WriteFloat ('PBValue',dmCAB.btTBI.FieldByName('PBValue').AsFloat);
        oTxtDoc.WriteDate ('DrbDate',dmCAB.btTBI.FieldByName('DrbDate').AsDateTime);
        oTxtDoc.WriteString ('MsName',dmCAB.btTBI.FieldByName('MsName').AsString);
        oTxtDoc.WriteString ('Status',dmCAB.btTBI.FieldByName('Status').AsString);
        oTxtDoc.WriteFloat ('SuQnt',dmCAB.btTBI.FieldByName('SuQnt').AsFloat);
        oTxtDoc.WriteString ('PackType',dmCAB.btTBI.FieldByName('PackType').AsString);
        oTxtDoc.WriteString ('CrtName',dmCAB.btTBI.FieldByName('CrtName').AsString);
        oTxtDoc.WriteDate ('CrtDate',dmCAB.btTBI.FieldByName('CrtDate').AsDateTime);
        oTxtDoc.WriteTime ('CrtTime',dmCAB.btTBI.FieldByName('CrtTime').AsDateTime);
        oTxtDoc.WriteString ('ModName',dmCAB.btTBI.FieldByName('ModName').AsString);
        oTxtDoc.WriteDate ('ModDate',dmCAB.btTBI.FieldByName('ModDate').AsDateTime);
        oTxtDoc.WriteTime ('ModTime',dmCAB.btTBI.FieldByName('ModTime').AsDateTime);
        oTxtDoc.WriteString ('DocNum',dmCAB.btTBI.FieldByName('DocNum').AsString);
        oTxtDoc.Post;
        dmCAB.btTBI.Edit;
        dmCAB.btTBI.FieldByName ('Sended').AsInteger := 1;
        dmCAB.btTBI.Post;
      end;
      Application.ProcessMessages;
      dmCAB.btTBI.Next;
    until (dmCAB.btTBI.Eof) or (dmCAB.btTBI.FieldByName('DocNum').AsString<>pDocNum);
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

procedure TTbdTxt.LoadFromFile (pDocNum:Str12);  // Nacita doklad z textoveho suboru
var mFileName:string;
begin
  oDocNum := pDocNum;
  mFileName := gIni.GetZipPath+pDocNum+'.TXT';
  If FileExists (mFileName) then begin
    oTxtDoc := TTxtDoc.Create;
    oTxtDoc.LoadFromFile (mFileName);
    LoadTxtToTbh; // Nacita udaje z prenosoveho suboru a vytvori alebo opravy hlavicku dodacieho listu
    If dmCAB.btTBH.FieldByName('ItmCount').AsInteger>0 then begin  // Ak doklad ma polozky
      // Polozky dokladu
      dmCAB.ptTBI.Open;
      LoadTxtToTmp; // Nacita poloky z prenosoveho suboru do docasneh databaze ptTCI
      DeleteTbi; // Vymaze polozky doacieho listu, ktore nie su v docasnej databaze
      AddNewItmToTbi; // Prida nove polozky do dodacieho listu
      dmCAB.ptTBI.Close;
{
      F_DocHand := TF_DocHand.Create(Application);
      F_DocHand.OutputTcDoc (dmSTK.btTCH.FieldByName('DocNum').AsString);  //  Realizácia zadaného dosleho dodacieho listu
      FreeAndNil (F_DocHand);
      TbhRecalc (oDocNum);  // Prepocita hlavicku zadaneho dodacieho listu podla jeho poloziek
}
    end;
    // Poznamky k dokladu

    FreeAndNil (oTxtDoc);
    DeleteFile (mFileName);
  end;
end;

procedure TTbdTxt.LoadTxtToTbh; // Nacita udaje z prenosoveho suboru a vytvori alebo opravy hlavicku dokladu
begin
  If dmCAB.btTBH.IndexName<>'DocNum' then dmCAB.btTBH.IndexName:='DocNum';
  If dmCAB.btTBH.FindKey ([oDocNum])
    then dmCAB.btTBH.Edit // Uprava hlavicky dokladu
    else dmCAB.btTBH.Insert;  // Novy doklad
  dmCAB.btTBH.FieldByName('SerNum').AsInteger := oTxtDoc.ReadInteger ('SerNum');
  dmCAB.btTBH.FieldByName('DocNum').AsString := oTxtDoc.ReadString ('DocNum');
  dmCAB.btTBH.FieldByName('SalDate').AsDateTime := oTxtDoc.ReadDate ('SalDate');
  dmCAB.btTBH.FieldByName('CasNum').AsInteger := oTxtDoc.ReadInteger ('CasNum');
  dmCAB.btTBH.FieldByName('StkNum').AsInteger := oTxtDoc.ReadInteger ('StkNum');
  dmCAB.btTBH.FieldByName('ItmCount').AsInteger := oTxtDoc.ReadInteger ('ItmCount');
  dmCAB.btTBH.FieldByName('LItmCount').AsInteger := oTxtDoc.ReadInteger ('LItmCount');
  dmCAB.btTBH.FieldByName('PItmCount').AsInteger := oTxtDoc.ReadInteger ('PItmCount');
  dmCAB.btTBH.FieldByName('PrnCount').AsInteger := oTxtDoc.ReadInteger ('PrnCount');
  dmCAB.btTBH.FieldByName('PDocNum').AsInteger := oTxtDoc.ReadInteger ('PDocNum');
  dmCAB.btTBH.FieldByName('RDocNum').AsInteger := oTxtDoc.ReadInteger ('RDocNum');
  dmCAB.btTBH.FieldByName('CValue1').AsFloat := oTxtDoc.ReadFloat ('CValue1');
  dmCAB.btTBH.FieldByName('CValue2').AsFloat := oTxtDoc.ReadFloat ('CValue2');
  dmCAB.btTBH.FieldByName('CValue3').AsFloat := oTxtDoc.ReadFloat ('CValue3');
  dmCAB.btTBH.FieldByName('CValue0').AsFloat := oTxtDoc.ReadFloat ('CValue0');
  dmCAB.btTBH.FieldByName('VatPrc1').AsFloat := oTxtDoc.ReadFloat ('VatPrc1');
  dmCAB.btTBH.FieldByName('VatPrc2').AsFloat := oTxtDoc.ReadFloat ('VatPrc2');
  dmCAB.btTBH.FieldByName('VatPrc3').AsFloat := oTxtDoc.ReadFloat ('VatPrc3');
  dmCAB.btTBH.FieldByName('AValue1').AsFloat := oTxtDoc.ReadFloat ('AValue1');
  dmCAB.btTBH.FieldByName('AValue2').AsFloat := oTxtDoc.ReadFloat ('AValue2');
  dmCAB.btTBH.FieldByName('AValue3').AsFloat := oTxtDoc.ReadFloat ('AValue3');
  dmCAB.btTBH.FieldByName('AValue0').AsFloat := oTxtDoc.ReadFloat ('AValue0');
  dmCAB.btTBH.FieldByName('BValue1').AsFloat := oTxtDoc.ReadFloat ('BValue1');
  dmCAB.btTBH.FieldByName('BValue2').AsFloat := oTxtDoc.ReadFloat ('BValue2');
  dmCAB.btTBH.FieldByName('BValue3').AsFloat := oTxtDoc.ReadFloat ('BValue3');
  dmCAB.btTBH.FieldByName('BValue0').AsFloat := oTxtDoc.ReadFloat ('BValue0');
  dmCAB.btTBH.FieldByName('VatVal1').AsFloat := oTxtDoc.ReadFloat ('VatVal1');
  dmCAB.btTBH.FieldByName('VatVal2').AsFloat := oTxtDoc.ReadFloat ('VatVal2');
  dmCAB.btTBH.FieldByName('VatVal3').AsFloat := oTxtDoc.ReadFloat ('VatVal3');
  dmCAB.btTBH.FieldByName('VatVal0').AsFloat := oTxtDoc.ReadFloat ('VatVal0');
  dmCAB.btTBH.FieldByName('PAValue1').AsFloat := oTxtDoc.ReadFloat ('PAValue1');
  dmCAB.btTBH.FieldByName('PAValue2').AsFloat := oTxtDoc.ReadFloat ('PAValue2');
  dmCAB.btTBH.FieldByName('PAValue3').AsFloat := oTxtDoc.ReadFloat ('PAValue3');
  dmCAB.btTBH.FieldByName('PAValue0').AsFloat := oTxtDoc.ReadFloat ('PAValue0');
  dmCAB.btTBH.FieldByName('PBValue1').AsFloat := oTxtDoc.ReadFloat ('PBValue1');
  dmCAB.btTBH.FieldByName('PBValue2').AsFloat := oTxtDoc.ReadFloat ('PBValue2');
  dmCAB.btTBH.FieldByName('PBValue3').AsFloat := oTxtDoc.ReadFloat ('PBValue3');
  dmCAB.btTBH.FieldByName('PBValue0').AsFloat := oTxtDoc.ReadFloat ('PBValue0');
  dmCAB.btTBH.FieldByName('PVatVal1').AsFloat := oTxtDoc.ReadFloat ('PVatVal1');
  dmCAB.btTBH.FieldByName('PVatVal2').AsFloat := oTxtDoc.ReadFloat ('PVatVal2');
  dmCAB.btTBH.FieldByName('PVatVal3').AsFloat := oTxtDoc.ReadFloat ('PVatVal3');
  dmCAB.btTBH.FieldByName('PVatVal0').AsFloat := oTxtDoc.ReadFloat ('PVatVal0');
  dmCAB.btTBH.FieldByName('BegVal0').AsFloat := oTxtDoc.ReadFloat ('BegVal0');
  dmCAB.btTBH.FieldByName('BegVal1').AsFloat := oTxtDoc.ReadFloat ('BegVal1');
  dmCAB.btTBH.FieldByName('BegVal2').AsFloat := oTxtDoc.ReadFloat ('BegVal2');
  dmCAB.btTBH.FieldByName('BegVal3').AsFloat := oTxtDoc.ReadFloat ('BegVal3');
  dmCAB.btTBH.FieldByName('BegVal4').AsFloat := oTxtDoc.ReadFloat ('BegVal4');
  dmCAB.btTBH.FieldByName('BegVal5').AsFloat := oTxtDoc.ReadFloat ('BegVal5');
  dmCAB.btTBH.FieldByName('BegVal6').AsFloat := oTxtDoc.ReadFloat ('BegVal6');
  dmCAB.btTBH.FieldByName('BegVal7').AsFloat := oTxtDoc.ReadFloat ('BegVal7');
  dmCAB.btTBH.FieldByName('BegVal8').AsFloat := oTxtDoc.ReadFloat ('BegVal8');
  dmCAB.btTBH.FieldByName('BegVal9').AsFloat := oTxtDoc.ReadFloat ('BegVal9');
  dmCAB.btTBH.FieldByName('TrnVal0').AsFloat := oTxtDoc.ReadFloat ('TrnVal0');
  dmCAB.btTBH.FieldByName('TrnVal1').AsFloat := oTxtDoc.ReadFloat ('TrnVal1');
  dmCAB.btTBH.FieldByName('TrnVal2').AsFloat := oTxtDoc.ReadFloat ('TrnVal2');
  dmCAB.btTBH.FieldByName('TrnVal3').AsFloat := oTxtDoc.ReadFloat ('TrnVal3');
  dmCAB.btTBH.FieldByName('TrnVal4').AsFloat := oTxtDoc.ReadFloat ('TrnVal4');
  dmCAB.btTBH.FieldByName('TrnVal5').AsFloat := oTxtDoc.ReadFloat ('TrnVal5');
  dmCAB.btTBH.FieldByName('TrnVal6').AsFloat := oTxtDoc.ReadFloat ('TrnVal6');
  dmCAB.btTBH.FieldByName('TrnVal7').AsFloat := oTxtDoc.ReadFloat ('TrnVal7');
  dmCAB.btTBH.FieldByName('TrnVal8').AsFloat := oTxtDoc.ReadFloat ('TrnVal8');
  dmCAB.btTBH.FieldByName('TrnVal9').AsFloat := oTxtDoc.ReadFloat ('TrnVal9');
  dmCAB.btTBH.FieldByName('Expense0').AsFloat := oTxtDoc.ReadFloat ('Expense0');
  dmCAB.btTBH.FieldByName('Expense1').AsFloat := oTxtDoc.ReadFloat ('Expense1');
  dmCAB.btTBH.FieldByName('Expense2').AsFloat := oTxtDoc.ReadFloat ('Expense2');
  dmCAB.btTBH.FieldByName('Expense3').AsFloat := oTxtDoc.ReadFloat ('Expense3');
  dmCAB.btTBH.FieldByName('Expense4').AsFloat := oTxtDoc.ReadFloat ('Expense4');
  dmCAB.btTBH.FieldByName('Expense5').AsFloat := oTxtDoc.ReadFloat ('Expense5');
  dmCAB.btTBH.FieldByName('Expense6').AsFloat := oTxtDoc.ReadFloat ('Expense6');
  dmCAB.btTBH.FieldByName('Expense7').AsFloat := oTxtDoc.ReadFloat ('Expense7');
  dmCAB.btTBH.FieldByName('Expense8').AsFloat := oTxtDoc.ReadFloat ('Expense8');
  dmCAB.btTBH.FieldByName('Expense9').AsFloat := oTxtDoc.ReadFloat ('Expense9');
  dmCAB.btTBH.FieldByName('ChangeIn0').AsFloat := oTxtDoc.ReadFloat ('ChangeIn0');
  dmCAB.btTBH.FieldByName('ChangeIn1').AsFloat := oTxtDoc.ReadFloat ('ChangeIn1');
  dmCAB.btTBH.FieldByName('ChangeIn2').AsFloat := oTxtDoc.ReadFloat ('ChangeIn2');
  dmCAB.btTBH.FieldByName('ChangeIn3').AsFloat := oTxtDoc.ReadFloat ('ChangeIn3');
  dmCAB.btTBH.FieldByName('ChangeIn4').AsFloat := oTxtDoc.ReadFloat ('ChangeIn4');
  dmCAB.btTBH.FieldByName('ChangeIn5').AsFloat := oTxtDoc.ReadFloat ('ChangeIn5');
  dmCAB.btTBH.FieldByName('ChangeIn6').AsFloat := oTxtDoc.ReadFloat ('ChangeIn6');
  dmCAB.btTBH.FieldByName('ChangeIn7').AsFloat := oTxtDoc.ReadFloat ('ChangeIn7');
  dmCAB.btTBH.FieldByName('ChangeIn8').AsFloat := oTxtDoc.ReadFloat ('ChangeIn8');
  dmCAB.btTBH.FieldByName('ChangeIn9').AsFloat := oTxtDoc.ReadFloat ('ChangeIn9');
  dmCAB.btTBH.FieldByName('ChangeOut0').AsFloat := oTxtDoc.ReadFloat ('ChangeOut0');
  dmCAB.btTBH.FieldByName('ChangeOut1').AsFloat := oTxtDoc.ReadFloat ('ChangeOut1');
  dmCAB.btTBH.FieldByName('ChangeOut2').AsFloat := oTxtDoc.ReadFloat ('ChangeOut2');
  dmCAB.btTBH.FieldByName('ChangeOut3').AsFloat := oTxtDoc.ReadFloat ('ChangeOut3');
  dmCAB.btTBH.FieldByName('ChangeOut4').AsFloat := oTxtDoc.ReadFloat ('ChangeOut4');
  dmCAB.btTBH.FieldByName('ChangeOut5').AsFloat := oTxtDoc.ReadFloat ('ChangeOut5');
  dmCAB.btTBH.FieldByName('ChangeOut6').AsFloat := oTxtDoc.ReadFloat ('ChangeOut6');
  dmCAB.btTBH.FieldByName('ChangeOut7').AsFloat := oTxtDoc.ReadFloat ('ChangeOut7');
  dmCAB.btTBH.FieldByName('ChangeOut8').AsFloat := oTxtDoc.ReadFloat ('ChangeOut8');
  dmCAB.btTBH.FieldByName('PayName0').AsString := oTxtDoc.ReadString ('PayName0');
  dmCAB.btTBH.FieldByName('PayName1').AsString := oTxtDoc.ReadString ('PayName1');
  dmCAB.btTBH.FieldByName('PayName2').AsString := oTxtDoc.ReadString ('PayName2');
  dmCAB.btTBH.FieldByName('PayName3').AsString := oTxtDoc.ReadString ('PayName3');
  dmCAB.btTBH.FieldByName('PayName4').AsString := oTxtDoc.ReadString ('PayName4');
  dmCAB.btTBH.FieldByName('PayName5').AsString := oTxtDoc.ReadString ('PayName5');
  dmCAB.btTBH.FieldByName('PayName6').AsString := oTxtDoc.ReadString ('PayName6');
  dmCAB.btTBH.FieldByName('PayName7').AsString := oTxtDoc.ReadString ('PayName7');
  dmCAB.btTBH.FieldByName('PayName8').AsString := oTxtDoc.ReadString ('PayName8');
  dmCAB.btTBH.FieldByName('PayName9').AsString := oTxtDoc.ReadString ('PayName9');
  dmCAB.btTBH.FieldByName('ClmVal').AsFloat := oTxtDoc.ReadFloat ('ClmVal');
  dmCAB.btTBH.FieldByName('NegVal').AsFloat := oTxtDoc.ReadFloat ('NegVal');
  dmCAB.btTBH.FieldByName('DscVal').AsFloat := oTxtDoc.ReadFloat ('DscVal');
  dmCAB.btTBH.FieldByName('Cancel').AsFloat := oTxtDoc.ReadFloat ('Cancel');
  dmCAB.btTBH.FieldByName('Income').AsFloat := oTxtDoc.ReadFloat ('Income');
  dmCAB.btTBH.FieldByName('Status1').AsString := oTxtDoc.ReadString ('Status1');
  dmCAB.btTBH.FieldByName('Status2').AsString := oTxtDoc.ReadString ('Status2');
  dmCAB.btTBH.FieldByName('Status3').AsString := oTxtDoc.ReadString ('Status3');
  dmCAB.btTBH.FieldByName('Status4').AsString := oTxtDoc.ReadString ('Status4');
  dmCAB.btTBH.FieldByName('Status5').AsString := oTxtDoc.ReadString ('Status5');
  dmCAB.btTBH.FieldByName('Status6').AsString := oTxtDoc.ReadString ('Status6');
  dmCAB.btTBH.FieldByName('Status7').AsString := oTxtDoc.ReadString ('Status7');
  dmCAB.btTBH.FieldByName('Status8').AsString := oTxtDoc.ReadString ('Status8');
  dmCAB.btTBH.FieldByName('Status9').AsString := oTxtDoc.ReadString ('Status9');
  dmCAB.btTBH.FieldByName('Status10').AsString := oTxtDoc.ReadString ('Status10');
  dmCAB.btTBH.FieldByName('Status11').AsString := oTxtDoc.ReadString ('Status11');
  dmCAB.btTBH.FieldByName('Status12').AsString := oTxtDoc.ReadString ('Status12');
  dmCAB.btTBH.FieldByName('CrtName').AsString := oTxtDoc.ReadString ('CrtName');
  dmCAB.btTBH.FieldByName('CrtDate').AsDateTime := oTxtDoc.ReadDate ('CrtDate');
  dmCAB.btTBH.FieldByName('CrtTime').AsDateTime := oTxtDoc.ReadTime ('CrtTime');
  dmCAB.btTBH.FieldByName('ModName').AsString := oTxtDoc.ReadString ('ModName');
  dmCAB.btTBH.FieldByName('ModDate').AsDateTime := oTxtDoc.ReadDate ('ModDate');
  dmCAB.btTBH.FieldByName('ModTime').AsDateTime := oTxtDoc.ReadTime ('ModTime');
  dmCAB.btTBH.Post;
end;

procedure TTbdTxt.LoadTxtToTmp; // Nacita poloky z prenosoveho suboru do docasneh databaze ptTCI
begin
  // Ulozime polozky do docasneho suboru
  oTxtDoc.First;
  Repeat
    dmCAB.ptTBI.Insert;
    dmCAB.ptTBI.FieldByName('DocNum').AsString := oTxtDoc.ReadString ('DocNum');
    dmCAB.ptTBI.FieldByName('SalDate').AsDateTime := oTxtDoc.ReadDate ('SalDate');
    dmCAB.ptTBI.FieldByName('CasNum').AsInteger := oTxtDoc.ReadInteger ('CasNum');
    dmCAB.ptTBI.FieldByName('MgCode').AsInteger := oTxtDoc.ReadInteger ('MgCode');
    dmCAB.ptTBI.FieldByName('GsCode').AsInteger := oTxtDoc.ReadInteger ('GsCode');
    dmCAB.ptTBI.FieldByName('GsName').AsString := oTxtDoc.ReadString ('GsName');
    dmCAB.ptTBI.FieldByName('BarCode').AsString := oTxtDoc.ReadString ('BarCode');
    dmCAB.ptTBI.FieldByName('StCode').AsString := oTxtDoc.ReadString ('StCode');
    dmCAB.ptTBI.FieldByName('StkNum').AsInteger := oTxtDoc.ReadInteger ('StkNum');
    dmCAB.ptTBI.FieldByName('SeQnt').AsFloat := oTxtDoc.ReadFloat ('SeQnt');
    dmCAB.ptTBI.FieldByName('DSuQnt').AsFloat := oTxtDoc.ReadFloat ('DSuQnt');
    dmCAB.ptTBI.FieldByName('PSuQnt').AsFloat := oTxtDoc.ReadFloat ('PSuQnt');
    dmCAB.ptTBI.FieldByName('TSuQnt').AsFloat := oTxtDoc.ReadFloat ('TSuQnt');
    dmCAB.ptTBI.FieldByName('CValue').AsFloat := oTxtDoc.ReadFloat ('CValue');
    dmCAB.ptTBI.FieldByName('VatPrc').AsFloat := oTxtDoc.ReadFloat ('VatPrc');
    dmCAB.ptTBI.FieldByName('DValue').AsFloat := oTxtDoc.ReadFloat ('DValue');
    dmCAB.ptTBI.FieldByName('TValue').AsFloat := oTxtDoc.ReadFloat ('TValue');
    dmCAB.ptTBI.FieldByName('PAValue').AsFloat := oTxtDoc.ReadFloat ('PAValue');
    dmCAB.ptTBI.FieldByName('PBValue').AsFloat := oTxtDoc.ReadFloat ('PBValue');
    dmCAB.ptTBI.FieldByName('DrbDate').AsDateTime := oTxtDoc.ReadDate ('DrbDate');
    dmCAB.ptTBI.FieldByName('MsName').AsString := oTxtDoc.ReadString ('MsName');
    dmCAB.ptTBI.FieldByName('Status').AsString := oTxtDoc.ReadString ('Status');
    dmCAB.ptTBI.FieldByName('SuQnt').AsFloat := oTxtDoc.ReadFloat ('SuQnt');
    dmCAB.ptTBI.FieldByName('PackType').AsString := oTxtDoc.ReadString ('PackType');
    dmCAB.ptTBI.FieldByName('CrtName').AsString := oTxtDoc.ReadString ('CrtName');
    dmCAB.ptTBI.FieldByName('CrtDate').AsDateTime := oTxtDoc.ReadDate ('CrtDate');
    dmCAB.ptTBI.FieldByName('CrtTime').AsDateTime := oTxtDoc.ReadTime ('CrtTime');
    dmCAB.ptTBI.FieldByName('ModName').AsString := oTxtDoc.ReadString ('ModName');
    dmCAB.ptTBI.FieldByName('ModDate').AsDateTime := oTxtDoc.ReadDate ('ModDate');
    dmCAB.ptTBI.FieldByName('ModTime').AsDateTime := oTxtDoc.ReadTime ('ModTime');
    dmCAB.ptTBI.Post;
    oTxtDoc.Next;
    Application.ProcessMessages;
  until oTxtDoc.Eof;
end;

procedure TTddTxt.DeleteTbi; // Vymaze polozky doacieho listu, ktore nie su v docasnej databaze
var mStkCanc: TStkCanc;
begin
{
  mStkCanc := TStkCanc.Create;
  If dmSTK.btTCI.IndexName<>'DocNum' then dmSTK.btTCI.IndexName:='DocNum';
  If dmSTK.btTCI.FindKey ([oDocNum]) then begin
    Repeat
      If dmSTK.ptTCI.FindKey ([dmSTK.btTCI.FieldByName('ItmNum').AsInteger]) then begin
        // Overime ci na danom poradovom cisle je ten isty tovar a to iste mnozstvo
        If (dmSTK.btTCI.FieldByName('GsCode').AsInteger<>dmSTK.ptTCI.FieldByName('GsCode').AsInteger) or not Eq3 (dmSTK.btTCI.FieldByName('GsQnt').AsFloat,dmSTK.ptTCI.FieldByName('GsQnt').AsFloat) then begin
          // Zrusime polozku dodacieho listu
          If mStkCanc.Cancel (dmSTK.btTCI.FieldByName('DocNum').AsString,dmSTK.btTCI.FieldByName('ItmNum').AsInteger) then dmSTK.btTCI.Delete;
        end
        else dmSTK.btTCI.Next; // Polozka sa zhoduje - ideme dalej
      end
      else begin // Zrusime polozku dodacieho listu
        If dmSTK.btTCI.FieldByName('StkStat').AsString='S' then begin
          // Tovar uz bol odpocitany zo skladu preto pred zrusenim traba stornovat skaldovy prijem
          dmSTK.OpenStkFiles (dmSTK.btTCI.FieldByName('StkNum').AsInteger);
          If mStkCanc.Cancel (dmSTK.btTCI.FieldByName('DocNum').AsString,dmSTK.btTCI.FieldByName('ItmNum').AsInteger) then dmSTK.btTCI.Delete;
          dmSTK.CloseStkFiles;
        end;
      end;
      Application.ProcessMessages;
    until (dmSTK.btTCI.Eof) or (dmSTK.btTCI.RecordCount=0) or (dmSTK.btTCI.FieldByName('DocNum').AsString<>oDocNum);
  end;
  FreeAndNil (mStkCanc);
}
end;

procedure TTcdTxt.AddNewItmToTci; // Prida nove polozky do dodacieho listu
begin
  dmCAB.btTBI.Modify := FALSE;
  dmCAB.btTBI.IndexName:='CaSaStGs';
  dmCAB.ptTBI.First;
  Repeat
    If dmCAB.btTBI.FindKey ([dmCAB.ptTBI.FieldByName('CasNum').AsInteger,dmCAB.ptTBI.FieldByName('SalDate').AsDateTime,dmCAB.ptTBI.FieldByName('StkNum').AsInteger,dmCAB.ptTBI.FieldByName('GsCode').AsInteger]) then begin
      dmCAB.btTBI.Edit;

      dmCAB.btTBI.Post;
    end
    else begin  // Ak bola zmenena len cena vykoname zmenu
      dmCAB.btTBI.Insert;
      dmCAB.btTBI.FieldByName('DocNum').AsString := dmCAB.ptTBI.FieldByName('DocNum').AsString;
      dmCAB.btTBI.FieldByName('SalDate').AsDateTime := dmCAB.ptTBI.FieldByName('SalDate').AsDateTime;
      dmCAB.btTBI.FieldByName('CasNum').AsInteger := dmCAB.ptTBI.FieldByName('CasNum').AsInteger;
      dmCAB.btTBI.FieldByName('MgCode').AsInteger := dmCAB.ptTBI.FieldByName('MgCode').AsInteger;
      dmCAB.btTBI.FieldByName('GsCode').AsInteger := dmCAB.ptTBI.FieldByName('GsCode').AsInteger;
      dmCAB.btTBI.FieldByName('GsName').AsString := dmCAB.ptTBI.FieldByName('GsName').AsString;
      dmCAB.btTBI.FieldByName('BarCode').AsString := dmCAB.ptTBI.FieldByName('BarCode').AsString;
      dmCAB.btTBI.FieldByName('StCode').AsString := dmCAB.ptTBI.FieldByName('StCode').AsString;
      dmCAB.btTBI.FieldByName('StkNum').AsInteger := dmCAB.ptTBI.FieldByName('StkNum').AsInteger;
      dmCAB.btTBI.FieldByName('SeQnt').AsFloat := dmCAB.ptTBI.FieldByName('SeQnt').AsFloat;
      dmCAB.btTBI.FieldByName('DSuQnt').AsFloat ;= dmCAB.ptTBI.FieldByName('DSuQnt').AsFloat;
      dmCAB.btTBI.FieldByName('PSuQnt').AsFloat := dmCAB.ptTBI.FieldByName('PSuQnt').AsFloat;
      dmCAB.btTBI.FieldByName('TSuQnt').AsFloat := dmCAB.ptTBI.FieldByName('TSuQnt').AsFloat;
      dmCAB.btTBI.FieldByName('CValue').AsFloat := dmCAB.ptTBI.FieldByName('CValue').AsFloat;
      dmCAB.btTBI.FieldByName('VatPrc').AsFloat := dmCAB.ptTBI.FieldByName('VatPrc').AsFloat;
      dmCAB.btTBI.FieldByName('DValue').AsFloat := dmCAB.ptTBI.FieldByName('DValue').AsFloat;
      dmCAB.btTBI.FieldByName('TValue').AsFloat := dmCAB.ptTBI.FieldByName('TValue').AsFloat;
      dmCAB.btTBI.FieldByName('PAValue').AsFloat := dmCAB.ptTBI.FieldByName('PAValue').AsFloat;
      dmCAB.btTBI.FieldByName('PBValue').AsFloat := dmCAB.ptTBI.FieldByName('PBValue').AsFloat;
      dmCAB.btTBI.FieldByName('DrbDate').AsDateTime := dmCAB.ptTBI.FieldByName('DrbDate').AsDateTime;
      dmCAB.btTBI.FieldByName('MsName').AsString := dmCAB.ptTBI.FieldByName('MsName').AsString;
      dmCAB.btTBI.FieldByName('Status').AsString := dmCAB.ptTBI.FieldByName('Status').AsString;
      dmCAB.btTBI.FieldByName('SuQnt').AsFloat := dmCAB.ptTBI.FieldByName('SuQnt').AsFloat;
      dmCAB.btTBI.FieldByName('PackType').AsString := dmCAB.ptTBI.FieldByName('PackType').AsString;
      dmCAB.btTBI.FieldByName('CrtName').AsStrin := dmCAB.ptTBI.FieldByName('CrtName').AsString;
      dmCAB.btTBI.FieldByName('CrtDate').AsDateTime := dmCAB.ptTBI.FieldByName('CrtDate').AsDateTime;
      dmCAB.btTBI.FieldByName('CrtTime').AsDateTime := dmCAB.ptTBI.FieldByName('CrtTime').AsDateTime;
      dmCAB.btTBI.FieldByName('ModName').AsString := dmCAB.ptTBI.FieldByName('ModName').AsString;
      dmCAB.btTBI.FieldByName('ModDate').AsDateTime := dmCAB.ptTBI.FieldByName('ModDate').AsDateTime;
      dmCAB.btTBI.FieldByName('ModTime').AsDateTime := dmCAB.ptTBI.FieldByName('ModTime').AsDateTime;
      dmCAB.btTBI.Post;
    end;
    Application.ProcessMessages;
    dmSTK.ptTCI.Next;
  until (dmSTK.ptTCI.Eof);
  dmSTK.btTCI.Modify := TRUE;
end;

end.
