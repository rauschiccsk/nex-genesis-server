unit OmdTxt;
{$F+}

interface

uses
  IcTypes, IcConv, IcTools, IniFiles, SysUtils, NexPath, NexIni,
  TxtWrap, TxtCut, StkCanc, DocHand, TxtDoc, Forms;

type
  TOmdTxt = class
    constructor Create;
    destructor  Destroy; override;
    private
      oDocNum: Str12; // Cislo dokladu ktorym pracujeme
      procedure LoadTxtToOmh; // Nacita udaje z prenosoveho suboru a vytvori alebo opravy hlavicku prijemky
      procedure LoadTxtToTmp; // Nacita poloky z prenosoveho suboru do docasneh databaze ptOMI
      procedure DeleteOmi; // Vymaze polozky doacieho listu, ktore nie su v docasnej databaze
      procedure AddNewItmToOmi; // Prida nove polozky do prijemky
    public
      oCount: word;
      oTxtDoc: TTxtDoc;
      oImdFileName: ShortString;
      procedure SaveToFile (pDocNum:Str12);  // Ulozi zadany doklad do textoveho suboru
      procedure SaveToImdFile (pBookNum:Str5;pStkNum,pSmCode:word);  // Ulozi zadany doklad do textoveho suboru
      procedure LoadFromFile (pDocNum:Str12);  // Nacita doklad z textoveho suboru
    published
      property Count:word read oCount;
      property ImdFileName:ShortString read oImdFileName;
  end;

implementation

uses
   DM_STKDAT;

constructor TOmdTxt.Create;
begin
end;

destructor TOmdTxt.Destroy;
begin
end;

procedure TOmdTxt.SaveToFile (pDocNum:Str12);  // Ulozi zadany doklad do textoveho suboru
var mFileName:string;  mPdnQnt:word;   mWrap:TTxtWrap;
begin
  mFileName := gIni.GetZipPath+pDocNum+'.TXT';
  oTxtDoc := TTxtDoc.Create;
  If FileExists (mFileName) then DeleteFile (mFileName);
  // Ulozime hlacivku dokladu
  oTxtDoc.WriteInteger ('SerNum',dmSTK.btOMH.FieldByName('SerNum').AsInteger);
  oTxtDoc.WriteString ('DocNum',dmSTK.btOMH.FieldByName('DocNum').AsString);
  oTxtDoc.WriteInteger ('StkNum',dmSTK.btOMH.FieldByName('StkNum').AsInteger);
  oTxtDoc.WriteDate ('DocDate',dmSTK.btOMH.FieldByName('DocDate').AsDateTime);
  oTxtDoc.WriteString ('Describe',dmSTK.btOMH.FieldByName('Describe').AsString);
  oTxtDoc.WriteString ('CrtUser',dmSTK.btOMH.FieldByName('CrtUser').AsString);
  oTxtDoc.WriteInteger ('PlsNum',dmSTK.btOMH.FieldByName('PlsNum').AsInteger);
  oTxtDoc.WriteInteger ('SmCode',dmSTK.btOMH.FieldByName('SmCode').AsInteger);
  oTxtDoc.WriteInteger ('VatPrc1',Round(dmSTK.btOMH.FieldByName('VatPrc1').AsFloat));
  oTxtDoc.WriteInteger ('VatPrc2',Round(dmSTK.btOMH.FieldByName('VatPrc2').AsFloat));
  oTxtDoc.WriteInteger ('VatPrc3',Round(dmSTK.btOMH.FieldByName('VatPrc3').AsFloat));
  oTxtDoc.WriteString ('ModUser',dmSTK.btOMH.FieldByName('ModUser').AsString);
  oTxtDoc.WriteDate ('ModDate',dmSTK.btOMH.FieldByName('ModDate').AsDateTime);
  oTxtDoc.WriteDate ('ModTime',dmSTK.btOMH.FieldByName('ModTime').AsDateTime);
  oTxtDoc.WriteString ('OcdNum',dmSTK.btOMH.FieldByName('OcdNum').AsString);
  oTxtDoc.WriteString ('Year',dmSTK.btOMH.FieldByName('Year').AsString);
  // Ulozime vyrobne cisla
  mPdnQnt := 0;
  If dmSTK.btOMP.IndexName<>'DoIt' then dmSTK.btOMP.IndexName := 'DoIt';
  dmSTK.btOMP.FindNearest ([pDocNum,0]);
  If dmSTK.btOMP.FieldByName ('DocNum').AsString=dmSTK.btOMH.FieldByName ('DocNum').AsString then begin
    mWrap := TTxtWrap.Create;
    mWrap.SetDelimiter('');
    Repeat
      Inc (mPdnQnt);
      mWrap.ClearWrap;
      mWrap.SetNum(dmSTK.btOMP.FieldByName('ItmNum').AsInteger,0);
      mWrap.SetNum(dmSTK.btOMP.FieldByName('GsCode').AsInteger,0);
      mWrap.SetText(dmSTK.btOMP.FieldByName('ProdNum').AsString,0);
      mWrap.SetNum(dmSTK.btOMP.FieldByName('StkNum').AsInteger,0);
      oTxtDoc.WriteString ('ProdNum'+StrInt(mPdnQnt,0),mWrap.GetWrapText);
      Application.ProcessMessages;
      dmSTK.btOMP.Next;
    until (dmSTK.btOMP.Eof) or (dmSTK.btOMP.FieldByName('DocNum').AsString<>pDocNum);
    FreeAndNil (mWrap);
  end;
  oTxtDoc.WriteInteger ('PdnQnt',mPdnQnt);

  // Ulozime poloziek dokladu
  If dmSTK.btOMI.IndexName<>'DoIt' then dmSTK.btOMI.IndexName := 'DoIt';
  dmSTK.btOMI.FindNearest ([pDocNum,0]);
  If dmSTK.btOMI.FieldByName ('DocNum').AsString=dmSTK.btOMH.FieldByName ('DocNum').AsString then begin
    Repeat
      oTxtDoc.Insert;
      oTxtDoc.WriteInteger ('ItmNum',dmSTK.btOMI.FieldByName('ItmNum').AsInteger);
      oTxtDoc.WriteInteger ('GsCode',dmSTK.btOMI.FieldByName('GsCode').AsInteger);
      oTxtDoc.WriteInteger ('MgCode',dmSTK.btOMI.FieldByName('MgCode').AsInteger);
      oTxtDoc.WriteString ('GsName',dmSTK.btOMI.FieldByName('GsName').AsString);
      oTxtDoc.WriteString ('BarCode',dmSTK.btOMI.FieldByName('BarCode').AsString);
      oTxtDoc.WriteString ('StkCode',dmSTK.btOMI.FieldByName('StkCode').AsString);
      oTxtDoc.WriteInteger ('StkNum',dmSTK.btOMI.FieldByName('StkNum').AsInteger);
      oTxtDoc.WriteFloat ('GsQnt',dmSTK.btOMI.FieldByName('GsQnt').AsFloat);
      oTxtDoc.WriteString ('MsName',dmSTK.btOMI.FieldByName('MsName').AsString);
      oTxtDoc.WriteInteger ('VatPrc',Round(dmSTK.btOMI.FieldByName('VatPrc').AsFloat));
      oTxtDoc.WriteFloat ('CPrice',dmSTK.btOMI.FieldByName('CPrice').AsFloat);
      oTxtDoc.WriteFloat ('EPrice',dmSTK.btOMI.FieldByName('EPrice').AsFloat);
      oTxtDoc.WriteFloat ('CValue',dmSTK.btOMI.FieldByName('CValue').AsFloat);
      oTxtDoc.WriteFloat ('EValue',dmSTK.btOMI.FieldByName('EValue').AsFloat);
      oTxtDoc.WriteFloat ('AValue',dmSTK.btOMI.FieldByName('AValue').AsFloat);
      oTxtDoc.WriteFloat ('BValue',dmSTK.btOMI.FieldByName('BValue').AsFloat);
      oTxtDoc.WriteString ('StkStat',dmSTK.btOMI.FieldByName('StkStat').AsString);
      oTxtDoc.WriteString ('ModUser',dmSTK.btOMI.FieldByName('ModUser').AsString);
      oTxtDoc.WriteDate ('ModDate',dmSTK.btOMI.FieldByName('ModDate').AsDateTime);
      oTxtDoc.WriteTime ('ModTime',dmSTK.btOMI.FieldByName('ModTime').AsDateTime);
      oTxtDoc.Post;
      Application.ProcessMessages;
      dmSTK.btOMI.Next;
    until (dmSTK.btOMI.Eof) or (dmSTK.btOMI.FieldByName('DocNum').AsString<>pDocNum);

{
    // Ulozime poznamky dokladu
    If dmSTK.btIMN.IndexName<>'DoNtLn' then dmSTK.btIMN.IndexName:='DoNtLn';
    dmSTK.btIMN.FindNearest ([pDocNum,'',0]);
    If dmSTK.btOMI.FieldByName ('DocNum').AsString=dmSTK.btOMH.FieldByName ('DocNum').AsString then begin
      mLine := 0;
      Repeat
        Inc (mLine);
        oFile.WriteString ('NOTICES','Line'+StrInt(mLine,0),dmSTK.btIMN.FieldByName('Notice').AsString);
      until (dmSTK.btTSN.Eof) or (dmSTK.btIMN.FieldByName('DocNum').AsString<>pDocNum);
    end;
}
  end;
  oTxtDoc.SaveToFile (mFileName);
  FreeAndNil (oTxtDoc);
end;

procedure TOmdTxt.SaveToImdFile (pBookNum:Str5;pStkNum,pSmCode:word);  // Ulozi zadany doklad do textoveho suboru
var mFileName:string;  mDocNum:Str12; mPdnQnt:word;   mWrap:TTxtWrap;
begin
  mDocNum := GenImDocNum ('',pBookNum,dmSTK.btOMH.FieldByName('SerNum').AsInteger);
  oImdFileName := mDocNum+'.TXT';
  mFileName := gIni.GetZipPath+oImdFileName;
  oTxtDoc := TTxtDoc.Create;
  If FileExists (mFileName) then DeleteFile (mFileName);
  // Ulozime hlacivku dokladu
  oTxtDoc.WriteInteger ('SerNum',dmSTK.btOMH.FieldByName('SerNum').AsInteger);
  oTxtDoc.WriteString ('DocNum',mDocNum);
  oTxtDoc.WriteInteger ('StkNum',pStkNum);
  oTxtDoc.WriteDate ('DocDate',dmSTK.btOMH.FieldByName('DocDate').AsDateTime);
  oTxtDoc.WriteString ('Describe',dmSTK.btOMH.FieldByName('Describe').AsString);
  oTxtDoc.WriteString ('CrtUser',dmSTK.btOMH.FieldByName('CrtUser').AsString);
  oTxtDoc.WriteInteger ('PlsNum',dmSTK.btOMH.FieldByName('PlsNum').AsInteger);
  oTxtDoc.WriteInteger ('SmCode',pSmCode);
  oTxtDoc.WriteInteger ('VatPrc1',dmSTK.btOMH.FieldByName('VatPrc1').AsInteger);
  oTxtDoc.WriteInteger ('VatPrc2',dmSTK.btOMH.FieldByName('VatPrc2').AsInteger);
  oTxtDoc.WriteInteger ('VatPrc3',dmSTK.btOMH.FieldByName('VatPrc3').AsInteger);
  oTxtDoc.WriteString ('ModUser',dmSTK.btOMH.FieldByName('ModUser').AsString);
  oTxtDoc.WriteDate ('ModDate',dmSTK.btOMH.FieldByName('ModDate').AsDateTime);
  oTxtDoc.WriteDate ('ModTime',dmSTK.btOMH.FieldByName('ModTime').AsDateTime);
  oTxtDoc.WriteString ('OcdNum',dmSTK.btOMH.FieldByName('OcdNum').AsString);
  oTxtDoc.WriteString ('Year',dmSTK.btOMH.FieldByName('Year').AsString);
  // Ulozime vyrobne cisla
  mPdnQnt := 0;
  If dmSTK.btOMP.IndexName<>'DoIt' then dmSTK.btOMP.IndexName := 'DoIt';
  dmSTK.btOMP.FindNearest ([dmSTK.btOMH.FieldByName('DocNum').AsString,0]);
  If dmSTK.btOMP.FieldByName ('DocNum').AsString=dmSTK.btOMH.FieldByName ('DocNum').AsString then begin
    mWrap := TTxtWrap.Create;
    mWrap.SetDelimiter('');
    Repeat
      Inc (mPdnQnt);
      mWrap.ClearWrap;
      mWrap.SetNum(dmSTK.btOMP.FieldByName('ItmNum').AsInteger,0);
      mWrap.SetNum(dmSTK.btOMP.FieldByName('GsCode').AsInteger,0);
      mWrap.SetText(dmSTK.btOMP.FieldByName('ProdNum').AsString,0);
      mWrap.SetNum(dmSTK.btOMP.FieldByName('StkNum').AsInteger,0);
      oTxtDoc.WriteString ('ProdNum'+StrInt(mPdnQnt,0),mWrap.GetWrapText);
      Application.ProcessMessages;
      dmSTK.btOMP.Next;
    until (dmSTK.btOMP.Eof) or (dmSTK.btOMP.FieldByName('DocNum').AsString<>dmSTK.btOMH.FieldByName('DocNum').AsString);
    FreeAndNil (mWrap);
  end;
  oTxtDoc.WriteInteger ('PdnQnt',mPdnQnt);

  // Ulozime poloziek dokladu
  If dmSTK.btOMI.IndexName<>'DoIt' then dmSTK.btOMI.IndexName := 'DoIt';
  dmSTK.btOMI.FindNearest ([dmSTK.btOMH.FieldByName('DocNum').AsString,0]);
  If dmSTK.btOMI.FieldByName ('DocNum').AsString=dmSTK.btOMH.FieldByName ('DocNum').AsString then begin
    Repeat
      oTxtDoc.Insert;
      oTxtDoc.WriteInteger ('ItmNum',dmSTK.btOMI.FieldByName('ItmNum').AsInteger);
      oTxtDoc.WriteInteger ('GsCode',dmSTK.btOMI.FieldByName('GsCode').AsInteger);
      oTxtDoc.WriteInteger ('MgCode',dmSTK.btOMI.FieldByName('MgCode').AsInteger);
      oTxtDoc.WriteString ('GsName',dmSTK.btOMI.FieldByName('GsName').AsString);
      oTxtDoc.WriteString ('BarCode',dmSTK.btOMI.FieldByName('BarCode').AsString);
      oTxtDoc.WriteString ('StkCode',dmSTK.btOMI.FieldByName('StkCode').AsString);
      oTxtDoc.WriteInteger ('StkNum',pStkNum);
      oTxtDoc.WriteFloat ('GsQnt',dmSTK.btOMI.FieldByName('GsQnt').AsFloat);
      oTxtDoc.WriteString ('MsName',dmSTK.btOMI.FieldByName('MsName').AsString);
      oTxtDoc.WriteInteger ('VatPrc',Round(dmSTK.btOMI.FieldByName('VatPrc').AsFloat));
      oTxtDoc.WriteFloat ('CPrice',dmSTK.btOMI.FieldByName('CPrice').AsFloat);
      oTxtDoc.WriteFloat ('EPrice',dmSTK.btOMI.FieldByName('EPrice').AsFloat);
      oTxtDoc.WriteFloat ('CValue',dmSTK.btOMI.FieldByName('CValue').AsFloat);
      oTxtDoc.WriteFloat ('EValue',dmSTK.btOMI.FieldByName('EValue').AsFloat);
      oTxtDoc.WriteFloat ('AValue',dmSTK.btOMI.FieldByName('AValue').AsFloat);
      oTxtDoc.WriteFloat ('BValue',dmSTK.btOMI.FieldByName('BValue').AsFloat);
      oTxtDoc.WriteString ('StkStat','N');
      oTxtDoc.WriteString ('ModUser',dmSTK.btOMI.FieldByName('ModUser').AsString);
      oTxtDoc.WriteDate ('ModDate',dmSTK.btOMI.FieldByName('ModDate').AsDateTime);
      oTxtDoc.WriteTime ('ModTime',dmSTK.btOMI.FieldByName('ModTime').AsDateTime);
      oTxtDoc.Post;
      Application.ProcessMessages;
      dmSTK.btOMI.Next;
    until (dmSTK.btOMI.Eof) or (dmSTK.btOMI.FieldByName('DocNum').AsString<>dmSTK.btOMH.FieldByName('DocNum').AsString);

{
    // Ulozime poznamky dokladu
    If dmSTK.btIMN.IndexName<>'DoNtLn' then dmSTK.btIMN.IndexName:='DoNtLn';
    dmSTK.btIMN.FindNearest ([pDocNum,'',0]);
    If dmSTK.btOMI.FieldByName ('DocNum').AsString=dmSTK.btOMH.FieldByName ('DocNum').AsString then begin
      mLine := 0;
      Repeat
        Inc (mLine);
        oFile.WriteString ('NOTICES','Line'+StrInt(mLine,0),dmSTK.btIMN.FieldByName('Notice').AsString);
      until (dmSTK.btTSN.Eof) or (dmSTK.btIMN.FieldByName('DocNum').AsString<>pDocNum);
    end;
}
  end;
  oTxtDoc.SaveToFile (mFileName);
  FreeAndNil (oTxtDoc);
end;

procedure TOmdTxt.LoadFromFile (pDocNum:Str12);  // Nacita doklad z textoveho suboru
var mFileName:string;
begin
  oDocNum := pDocNum;
  If not DirectoryExists (gIni.GetZipPath) then ForceDirectories (gIni.GetZipPath);
  mFileName := gIni.GetZipPath+pDocNum+'.TXT';
  If FileExists (mFileName) then begin
    oTxtDoc := TTxtDoc.Create;
    oTxtDoc.LoadFromFile (mFileName);
    LoadTxtToOmh; // Nacita udaje z prenosoveho suboru a vytvori alebo opravy hlavicku prijemky
    If dmSTK.btOMH.FieldByName('ItmQnt').AsInteger>0 then begin  // Ak doklad ma polozky
      // Polozky dokladu
      dmSTK.ptOMI.Open;
      dmSTK.ptOMI.IndexName := 'ItmNum';
      LoadTxtToTmp; // Nacita poloky z prenosoveho suboru do docasneh databaze ptOMI
      DeleteOmi; // Vymaze polozky vydajky, ktore nie su v docasnej databaze
      AddNewItmToOmi; // Prida nove polozky do vydajky
      dmSTK.ptOMI.Close;
      OmhRecalc (dmSTK.btOMH,dmSTK.btOMI);  // Prepocita hlavicku zadaneho dodacieho listu podla jeho poloziek
    end;
    // Poznamky k dokladu
    FreeAndNil (oTxtDoc);
    DeleteFile (mFileName);
  end;
end;

procedure TOmdTxt.LoadTxtToOmh; // Nacita udaje z prenosoveho suboru a vytvori alebo opravy hlavicku dodacieho listu
begin
  If dmSTK.btOMH.IndexName<>'DocNum' then dmSTK.btOMH.IndexName:='DocNum';
  If dmSTK.btOMH.FindKey ([oDocNum])
    then dmSTK.btOMH.Edit     // Uprava hlavicky dokladu
    else dmSTK.btOMH.Insert;  // Novy doklad
  dmSTK.btOMH.FieldByName('SerNum').AsInteger := oTxtDoc.ReadInteger ('SerNum');
  dmSTK.btOMH.FieldByName('Year').AsString := oTxtDoc.ReadString ('Year');
  dmSTK.btOMH.FieldByName('DocNum').AsString := oTxtDoc.ReadString ('DocNum');
  dmSTK.btOMH.FieldByName('StkNum').AsInteger := oTxtDoc.ReadInteger ('StkNum');
  dmSTK.btOMH.FieldByName('DocDate').AsDateTime := oTxtDoc.ReadDate ('DocDate');
  dmSTK.btOMH.FieldByName('Describe').AsString := oTxtDoc.ReadString ('Describe');
  dmSTK.btOMH.FieldByName('CrtUser').AsString := oTxtDoc.ReadString ('CrtUser');
  dmSTK.btOMH.FieldByName('PlsNum').AsInteger := oTxtDoc.ReadInteger ('PlsNum');
  dmSTK.btOMH.FieldByName('SmCode').AsInteger := oTxtDoc.ReadInteger ('SmCode');
  dmSTK.btOMH.FieldByName('VatPrc1').AsFloat := oTxtDoc.ReadInteger ('VatPrc1');
  dmSTK.btOMH.FieldByName('VatPrc2').AsFloat := oTxtDoc.ReadInteger ('VatPrc2');
  dmSTK.btOMH.FieldByName('VatPrc3').AsFloat := oTxtDoc.ReadInteger ('VatPrc3');
  dmSTK.btOMH.FieldByName('ModUser').AsString := oTxtDoc.ReadString ('ModUser');
  dmSTK.btOMH.FieldByName('ModDate').AsDateTime := oTxtDoc.ReadDate ('ModDate');
  dmSTK.btOMH.FieldByName('ModTime').AsDateTime := oTxtDoc.ReadTime ('ModTime');
  dmSTK.btOMH.FieldByName('ItmQnt').AsInteger := oTxtDoc.ReadInteger ('ItmQnt');
  dmSTK.btOMH.FieldByName('OcdNum').AsString := oTxtDoc.ReadString ('OcdNum');
  dmSTK.btOMH.Post;
end;

procedure TOmdTxt.LoadTxtToTmp; // Nacita poloky z prenosoveho suboru do docasneh databaze ptOMI
begin
  If oTxtDoc.ItemCount>0 then begin
    // Ulozime polozky do docasneho suboru
    oTxtDoc.First;
    Repeat
      If not dmSTK.ptOMI.FindKey ([oTxtDoc.ReadInteger ('ItmNum')]) then begin
        dmSTK.ptOMI.Insert;
        dmSTK.ptOMI.FieldByName('DocNum').AsString := oDocNum;
        dmSTK.ptOMI.FieldByName('ItmNum').AsInteger := oTxtDoc.ReadInteger ('ItmNum');
        dmSTK.ptOMI.FieldByName('GsCode').AsInteger := oTxtDoc.ReadInteger ('GsCode');
        dmSTK.ptOMI.FieldByName('MgCode').AsInteger := oTxtDoc.ReadInteger ('MgCode');
        dmSTK.ptOMI.FieldByName('GsName').AsString := oTxtDoc.ReadString ('GsName');
        dmSTK.ptOMI.FieldByName('BarCode').AsString := oTxtDoc.ReadString ('BarCode');
        dmSTK.ptOMI.FieldByName('StkCode').AsString := oTxtDoc.ReadString ('StkCode');
        dmSTK.ptOMI.FieldByName('StkNum').AsInteger := oTxtDoc.ReadInteger ('StkNum');
        dmSTK.ptOMI.FieldByName('GsQnt').AsFloat := oTxtDoc.ReadFloat ('GsQnt');
        dmSTK.ptOMI.FieldByName('MsName').AsString := oTxtDoc.ReadString ('MsName');
        dmSTK.ptOMI.FieldByName('VatPrc').AsFloat := oTxtDoc.ReadFloat ('VatPrc');
        dmSTK.ptOMI.FieldByName('CPrice').AsFloat := oTxtDoc.ReadFloat ('CPrice');
        dmSTK.ptOMI.FieldByName('EPrice').AsFloat := oTxtDoc.ReadFloat ('EPrice');
        dmSTK.ptOMI.FieldByName('CValue').AsFloat := oTxtDoc.ReadFloat ('CValue');
        dmSTK.ptOMI.FieldByName('EValue').AsFloat := oTxtDoc.ReadFloat ('EValue');
        dmSTK.ptOMI.FieldByName('AValue').AsFloat := oTxtDoc.ReadFloat ('AValue');
        dmSTK.ptOMI.FieldByName('BValue').AsFloat := oTxtDoc.ReadFloat ('BValue');
        dmSTK.ptOMI.FieldByName('StkStat').AsString := oTxtDoc.ReadString ('StkStat');
        dmSTK.ptOMI.FieldByName('ModUser').AsString := oTxtDoc.ReadString ('ModUser');
        dmSTK.ptOMI.FieldByName('ModDate').AsDateTime := oTxtDoc.ReadDate ('ModDate');
        dmSTK.ptOMI.FieldByName('ModTime').AsDateTime := oTxtDoc.ReadTime ('ModTime');
        dmSTK.ptOMI.Post;
      end;
      otxtDoc.Next;
      Application.ProcessMessages;
    until oTxtDoc.Eof;
  end;
end;

procedure TOmdTxt.DeleteOmi; // Vymaze polozky doacieho listu, ktore nie su v docasnej databaze
begin
  If dmSTK.btOMI.IndexName<>'DocNum' then dmSTK.btOMI.IndexName:='DocNum';
  If dmSTK.btOMI.FindKey ([oDocNum]) then begin
    Repeat
      Application.ProcessMessages;
      // Zrusime polozku vydajky
      If dmSTK.btOMI.FieldByName('StkStat').AsString='N'
        then dmSTK.btOMI.Delete
        else dmSTK.btOMI.Next;
    until (dmSTK.btOMI.Eof) or (dmSTK.btOMI.RecordCount=0) or (dmSTK.btOMI.FieldByName('DocNum').AsString<>oDocNum);
  end;
end;

procedure TOmdTxt.AddNewItmToOmi; // Prida nove polozky do dodacieho listu
begin
  dmSTK.btOMI.Modify := FALSE;
  dmSTK.btOMI.IndexName:='DoIt';
  dmSTK.ptOMI.First;
  Repeat
    If not dmSTK.btOMI.FindKey ([oDocNum,dmSTK.ptOMI.FieldByName('ItmNum').AsInteger]) then begin
      dmSTK.btOMI.Insert;
      dmSTK.btOMI.FieldByName ('ItmNum').AsInteger := dmSTK.ptOMI.FieldByName ('ItmNum').AsInteger;
      dmSTK.btOMI.FieldByName ('DocNum').AsString := oDocNum;
      dmSTK.btOMI.FieldByName ('MgCode').AsInteger := dmSTK.ptOMI.FieldByName ('MgCode').AsInteger;
      dmSTK.btOMI.FieldByName ('GsCode').AsInteger := dmSTK.ptOMI.FieldByName ('GsCode').AsInteger;
      dmSTK.btOMI.FieldByName ('GsName').AsString := dmSTK.ptOMI.FieldByName ('GsName').AsString;
      dmSTK.btOMI.FieldByName ('BarCode').AsString := dmSTK.ptOMI.FieldByName ('BarCode').AsString;
      dmSTK.btOMI.FieldByName ('StkCode').AsString := dmSTK.ptOMI.FieldByName ('StkCode').AsString;
      dmSTK.btOMI.FieldByName ('StkNum').AsInteger := dmSTK.ptOMI.FieldByName ('StkNum').AsInteger;
      dmSTK.btOMI.FieldByName ('MsName').AsString := dmSTK.ptOMI.FieldByName ('MsName').AsString;
      dmSTK.btOMI.FieldByName ('GsQnt').AsFloat := dmSTK.ptOMI.FieldByName ('GsQnt').AsFloat;
      dmSTK.btOMI.FieldByName ('VatPrc').AsFloat := dmSTK.ptOMI.FieldByName ('VatPrc').AsFloat;
      dmSTK.btOMI.FieldByName ('CPrice').AsFloat := dmSTK.ptOMI.FieldByName ('CPrice').AsFloat;
      dmSTK.btOMI.FieldByName ('EPrice').AsFloat := dmSTK.ptOMI.FieldByName ('EPrice').AsFloat;
      dmSTK.btOMI.FieldByName ('CValue').AsFloat := dmSTK.ptOMI.FieldByName ('CValue').AsFloat;
      dmSTK.btOMI.FieldByName ('EValue').AsFloat := dmSTK.ptOMI.FieldByName ('EValue').AsFloat;
      dmSTK.btOMI.FieldByName ('AValue').AsFloat := dmSTK.ptOMI.FieldByName ('AValue').AsFloat;
      dmSTK.btOMI.FieldByName ('BValue').AsFloat := dmSTK.ptOMI.FieldByName ('BValue').AsFloat;
      dmSTK.btOMI.FieldByName ('StkStat').AsString := 'N';
      dmSTK.btOMI.FieldByName ('ModNum').AsInteger := dmSTK.ptOMI.FieldByName ('ModNum').AsInteger;
      dmSTK.btOMI.FieldByName ('ModUser').AsString := dmSTK.ptOMI.FieldByName ('ModUser').AsString;
      dmSTK.btOMI.FieldByName ('ModDate').AsDateTime := dmSTK.ptOMI.FieldByName ('ModDate').AsDateTime;
      dmSTK.btOMI.FieldByName ('ModTime').AsDateTime := dmSTK.ptOMI.FieldByName ('ModTime').AsDateTime;
      dmSTK.btOMI.Post;
    end
    else begin  // Ak bola zmenena len cena vykoname zmenu

    end;
    Application.ProcessMessages;
    dmSTK.ptOMI.Next;
  until (dmSTK.ptOMI.Eof);
  dmSTK.btOMI.Modify := TRUE;
end;

end.
