unit CsdTxt;
{$F+}

interface

uses
  IcTypes, IcConv, IcTools, IniFiles, SysUtils,
  NexPath, NexIni, NexGlob, TxtWrap, TxtCut, DocHand, TxtDoc, Forms;


type
  TCsdTxt = class
    constructor Create;
    destructor  Destroy; override;
    private
      oDocNum: Str12; // Cislo dokladu ktorym pracujeme
      function LoadTxtToCsh:boolean; // Nacita udaje z prenosoveho suboru a vytvori alebo opravy hlavicku dokladu
      procedure LoadTxtToTmp; // Nacita poloky z prenosoveho suboru do docasneh databaze ptCSI
      procedure DeleteCsi; // Vymaze polozky doacieho listu, ktore nie su v docasnej databaze
      procedure AddNewItmToCsi; // Prida nove polozky do dokladu
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

constructor TCsdTxt.Create;
begin
end;

destructor TCsdTxt.Destroy;
begin
end;

procedure TCsdTxt.SaveToFile (pDocNum:Str12);  // Ulozi zadany doklad do textoveho suboru
var mFileName:string;
begin
  mFileName := gIni.GetZipPath+pDocNum+'.TXT';
  oTxtDoc := TTxtDoc.Create;
  If FileExists (mFileName) then DeleteFile (mFileName);
  // Nova datavaza - od v 10.02
  oTxtDoc.WriteInteger ('SerNum',dmLDG.btCSH.FieldByName('SerNum').AsInteger);
  oTxtDoc.WriteString ('DocNum',dmLDG.btCSH.FieldByName('DocNum').AsString);
  oTxtDoc.WriteInteger ('DocCnt',dmLDG.btCSH.FieldByName('DocCnt').AsInteger);
  oTxtDoc.WriteString ('DocType',dmLDG.btCSH.FieldByName('DocType').AsString);
  oTxtDoc.WriteDate ('DocDate',dmLDG.btCSH.FieldByName('DocDate').AsDateTime);
  oTxtDoc.WriteInteger ('WriNum',dmLDG.btCSH.FieldByName('WriNum').AsInteger);
  oTxtDoc.WriteInteger ('PaCode',dmLDG.btCSH.FieldByName('PaCode').AsInteger);
  oTxtDoc.WriteString ('PaName',dmLDG.btCSH.FieldByName('PaName').AsString);
  oTxtDoc.WriteString ('RegName',dmLDG.btCSH.FieldByName('RegName').AsString);
  oTxtDoc.WriteString ('RegIno',dmLDG.btCSH.FieldByName('RegIno').AsString);
  oTxtDoc.WriteString ('RegTin',dmLDG.btCSH.FieldByName('RegTin').AsString);
  oTxtDoc.WriteString ('RegVin',dmLDG.btCSH.FieldByName('RegVin').AsString);
  oTxtDoc.WriteString ('RegAddr',dmLDG.btCSH.FieldByName('RegAddr').AsString);
  oTxtDoc.WriteString ('RegSta',dmLDG.btCSH.FieldByName('RegSta').AsString);
  oTxtDoc.WriteString ('RegCty',dmLDG.btCSH.FieldByName('RegCty').AsString);
  oTxtDoc.WriteString ('RegCtn',dmLDG.btCSH.FieldByName('RegCtn').AsString);
  oTxtDoc.WriteString ('RegZip',dmLDG.btCSH.FieldByName('RegZip').AsString);
  oTxtDoc.WriteString ('Notice',dmLDG.btCSH.FieldByName('Notice').AsString);
  oTxtDoc.WriteInteger ('VatPrc1',dmLDG.btCSH.FieldByName('VatPrc1').AsInteger);
  oTxtDoc.WriteInteger ('VatPrc2',dmLDG.btCSH.FieldByName('VatPrc2').AsInteger);
  oTxtDoc.WriteInteger ('VatPrc3',dmLDG.btCSH.FieldByName('VatPrc3').AsInteger);
  oTxtDoc.WriteString ('AcDvzName',dmLDG.btCSH.FieldByName('AcDvzName').AsString);
  oTxtDoc.WriteString ('PyDvzName',dmLDG.btCSH.FieldByName('PyDvzName').AsString);
  oTxtDoc.WriteFloat ('PyCourse',dmLDG.btCSH.FieldByName('PyCourse').AsFloat);
  oTxtDoc.WriteFloat ('PyBegVal',dmLDG.btCSH.FieldByName('PyBegVal').AsFloat);
  oTxtDoc.WriteInteger ('PrnCnt',dmLDG.btCSH.FieldByName('PrnCnt').AsInteger);
  oTxtDoc.WriteInteger ('DocSpc',dmLDG.btCSH.FieldByName('DocSpc').AsInteger);
  oTxtDoc.WriteString ('CrtUser',dmLDG.btCSH.FieldByName('CrtUser').AsString);
  oTxtDoc.WriteDate ('CrtDate',dmLDG.btCSH.FieldByName('CrtDate').AsDateTime);
  oTxtDoc.WriteTime ('CrtTime',dmLDG.btCSH.FieldByName('CrtTime').AsDateTime);
  oTxtDoc.WriteString ('ModUser',dmLDG.btCSH.FieldByName('ModUser').AsString);
  oTxtDoc.WriteDate ('ModDate',dmLDG.btCSH.FieldByName('ModDate').AsDateTime);
  oTxtDoc.WriteTime ('ModTime',dmLDG.btCSH.FieldByName('ModTime').AsDateTime);
  oTxtDoc.WriteString ('Year',dmLDG.btCSH.FieldByName('Year').AsString);
  // Ulozime poloziek dokladu
  If dmLDG.btCSI.IndexName<>'DoIt' then dmLDG.btCSI.IndexName := 'DoIt';
  dmLDG.btCSI.FindNearest ([pDocNum,0]);
  If dmLDG.btCSI.FieldByName ('DocNum').AsString=dmLDG.btCSH.FieldByName ('DocNum').AsString then begin
    Repeat
      oTxtDoc.Insert;
      // Nova databaza - od v10.02
      oTxtDoc.WriteInteger ('ItmNum',dmLDG.btCSI.FieldByName('ItmNum').AsInteger);
      oTxtDoc.WriteDate ('DocDate',dmLDG.btCSI.FieldByName('DocDate').AsDateTime);
      oTxtDoc.WriteString ('Describe',dmLDG.btCSI.FieldByName('Describe').AsString);
      oTxtDoc.WriteString ('DocType',dmLDG.btCSI.FieldByName('DocType').AsString);
      oTxtDoc.WriteInteger ('VatPrc',dmLDG.btCSI.FieldByName('VatPrc').AsInteger);
      oTxtDoc.WriteString ('PyDvzName',dmLDG.btCSI.FieldByName('PyDvzName').AsString);
      oTxtDoc.WriteFloat ('PyCourse',dmLDG.btCSI.FieldByName('PyCourse').AsFloat);
      oTxtDoc.WriteFloat ('PyAValue',dmLDG.btCSI.FieldByName('PyAValue').AsFloat);
      oTxtDoc.WriteFloat ('PyBValue',dmLDG.btCSI.FieldByName('PyBValue').AsFloat);
      oTxtDoc.WriteFloat ('PyPdfVal',dmLDG.btCSI.FieldByName('PyPdfVal').AsFloat);
      oTxtDoc.WriteInteger ('PaCode',dmLDG.btCSI.FieldByName('PaCode').AsInteger);
      oTxtDoc.WriteString ('AcDvzName',dmLDG.btCSI.FieldByName('AcDvzName').AsString);
      oTxtDoc.WriteFloat ('AcAValue',dmLDG.btCSI.FieldByName('AcAValue').AsFloat);
      oTxtDoc.WriteFloat ('AcBValue',dmLDG.btCSI.FieldByName('AcBValue').AsFloat);
      oTxtDoc.WriteFloat ('AcCrdVal',dmLDG.btCSI.FieldByName('AcCrdVal').AsFloat);
      oTxtDoc.WriteFloat ('AcPdfVal',dmLDG.btCSI.FieldByName('AcPdfVal').AsFloat);
      oTxtDoc.WriteString ('FgDvzName',dmLDG.btCSI.FieldByName('FgDvzName').AsString);
      oTxtDoc.WriteFloat ('FgCourse',dmLDG.btCSI.FieldByName('FgCourse').AsFloat);
      oTxtDoc.WriteFloat ('FgPayVal',dmLDG.btCSI.FieldByName('FgPayVal').AsFloat);
      oTxtDoc.WriteString ('ConDoc',dmLDG.btCSI.FieldByName('ConDoc').AsString);
      oTxtDoc.WriteString ('ConExt',dmLDG.btCSI.FieldByName('ConExt').AsString);
      oTxtDoc.WriteInteger ('WriNum',dmLDG.btCSI.FieldByName('WriNum').AsInteger);
      oTxtDoc.WriteInteger ('CentNum',dmLDG.btCSI.FieldByName('CentNum').AsInteger);
      oTxtDoc.WriteString ('CrdSnt',dmLDG.btCSI.FieldByName('CrdSnt').AsString);
      oTxtDoc.WriteString ('CrdAnl',dmLDG.btCSI.FieldByName('CrdAnl').AsString);
      oTxtDoc.WriteString ('PdfSnt',dmLDG.btCSI.FieldByName('PdfSnt').AsString);
      oTxtDoc.WriteString ('PdfAnl',dmLDG.btCSI.FieldByName('PdfAnl').AsString);
      oTxtDoc.WriteString ('AccSnt',dmLDG.btCSI.FieldByName('AccSnt').AsString);
      oTxtDoc.WriteString ('AccAnl',dmLDG.btCSI.FieldByName('AccAnl').AsString);
      oTxtDoc.WriteString ('CrtUser',dmLDG.btCSI.FieldByName('CrtUser').AsString);
      oTxtDoc.WriteDate ('CrtDate',dmLDG.btCSI.FieldByName('CrtDate').AsDateTime);
      oTxtDoc.WriteTime ('CrtTime',dmLDG.btCSI.FieldByName('CrtTime').AsDateTime);
      oTxtDoc.WriteString ('ModUser',dmLDG.btCSI.FieldByName('ModUser').AsString);
      oTxtDoc.WriteDate ('ModDate',dmLDG.btCSI.FieldByName('ModDate').AsDateTime);
      oTxtDoc.WriteTime ('ModTime',dmLDG.btCSI.FieldByName('ModTime').AsDateTime);
      oTxtDoc.Post;
      Application.ProcessMessages;
      dmLDG.btCSI.Next;
    until (dmLDG.btCSI.Eof) or (dmLDG.btCSI.FieldByName('DocNum').AsString<>pDocNum);
  end;
  oTxtDoc.SaveToFile (mFileName);
  FreeAndNil (oTxtDoc);
end;

procedure TCsdTxt.LoadFromFile (pDocNum:Str12);  // Nacita doklad z textoveho suboru
var mFileName:string;
begin
  oDocNum := pDocNum;
  mFileName := gIni.GetZipPath+pDocNum+'.TXT';
  If FileExists (mFileName) then begin
    oTxtDoc := TTxtDoc.Create;
    oTxtDoc.LoadFromFile (mFileName);
    If LoadTxtToCsh then begin // Nacita udaje z prenosoveho suboru a vytvori alebo opravy hlavicku dokladu
      If dmLDG.btCSH.FieldByName('ItmQnt').AsInteger>0 then begin  // Ak doklad ma polozky
        // Polozky dokladu
        dmLDG.ptCSI.Open;
        dmLDG.ptCSI.IndexName := 'ItmNum';
        LoadTxtToTmp; // Nacita poloky z prenosoveho suboru do docasneh databaze ptCSI
        DeleteCsi; // Vymaze polozky FA, ktore nie su v docasnej databaze
        AddNewItmToCsi; // Prida nove polozky do dokladu
        dmLDG.ptCSI.Close;
        CshRecalc (dmLDG.btCSH,dmLDG.btCSI);  // Prepocita hlavicku zadaneho dokladu podla jeho poloziek
      end;
    end;
    FreeAndNil (oTxtDoc);
    DeleteFile (mFileName);
  end;
end;

function TCsdTxt.LoadTxtToCsh:boolean; // Nacita udaje z prenosoveho suboru a vytvori alebo opravy hlavicku dokladu
var mFind:boolean;
begin
  Result := TRUE;
  If dmLDG.btCSH.IndexName<>'DocNum' then dmLDG.btCSH.IndexName:='DocNum';
  mFind := dmLDG.btCSH.FindKey ([oDocNum]);
  If mFind then Result := dmLDG.btCSH.FieldByName('DstAcc').AsString<>'A';
  If Result then begin // Ak nie je zauctovany
    If mFind
      then dmLDG.btCSH.Edit // Uprava hlavicky dokladu
      else dmLDG.btCSH.Insert;  // Novy doklad
    dmLDG.btCSH.FieldByName('Year').AsString := oTxtDoc.ReadString ('Year');
    dmLDG.btCSH.FieldByName('SerNum').AsInteger := oTxtDoc.ReadInteger ('SerNum');
    dmLDG.btCSH.FieldByName('DocNum').AsString := oTxtDoc.ReadString ('DocNum');
    dmLDG.btCSH.FieldByName('DocCnt').AsInteger := oTxtDoc.ReadInteger ('DocCnt');
    dmLDG.btCSH.FieldByName('DocType').AsString := oTxtDoc.ReadString ('DocType');
    dmLDG.btCSH.FieldByName('DocDate').AsDateTime := oTxtDoc.ReadDate ('DocDate');
    dmLDG.btCSH.FieldByName('WriNum').AsInteger := oTxtDoc.ReadInteger ('WriNum');
    dmLDG.btCSH.FieldByName('PaCode').AsInteger := oTxtDoc.ReadInteger ('PaCode');
    dmLDG.btCSH.FieldByName('PaName').AsString := oTxtDoc.ReadString ('PaName');
    dmLDG.btCSH.FieldByName('RegName').AsString := oTxtDoc.ReadString ('RegName');
    dmLDG.btCSH.FieldByName('RegIno').AsString := oTxtDoc.ReadString ('RegIno');
    dmLDG.btCSH.FieldByName('RegTin').AsString := oTxtDoc.ReadString ('RegTin');
    dmLDG.btCSH.FieldByName('RegVin').AsString := oTxtDoc.ReadString ('RegVin');
    dmLDG.btCSH.FieldByName('RegAddr').AsString := oTxtDoc.ReadString ('RegAddr');
    dmLDG.btCSH.FieldByName('RegSta').AsString := oTxtDoc.ReadString ('RegSta');
    dmLDG.btCSH.FieldByName('RegCty').AsString := oTxtDoc.ReadString ('RegCty');
    dmLDG.btCSH.FieldByName('RegCtn').AsString := oTxtDoc.ReadString ('RegCtn');
    dmLDG.btCSH.FieldByName('RegZip').AsString := oTxtDoc.ReadString ('RegZip');
    dmLDG.btCSH.FieldByName('Notice').AsString := oTxtDoc.ReadString ('Notice');
    dmLDG.btCSH.FieldByName('VatPrc1').AsInteger := oTxtDoc.ReadInteger ('VatPrc1');
    dmLDG.btCSH.FieldByName('VatPrc2').AsInteger := oTxtDoc.ReadInteger ('VatPrc2');
    dmLDG.btCSH.FieldByName('VatPrc3').AsInteger := oTxtDoc.ReadInteger ('VatPrc3');
    dmLDG.btCSH.FieldByName('PaCode').AsInteger := oTxtDoc.ReadInteger ('PaCode');
    dmLDG.btCSH.FieldByName('AcDvzName').AsString := oTxtDoc.ReadString ('AcDvzName');
    dmLDG.btCSH.FieldByName('PyDvzName').AsString := oTxtDoc.ReadString ('PyDvzName');
    dmLDG.btCSH.FieldByName('PyCourse').AsFloat := oTxtDoc.ReadFloat ('PyCourse');
    dmLDG.btCSH.FieldByName('PyBegVal').AsFloat := oTxtDoc.ReadFloat ('PyBegVal');
    dmLDG.btCSH.FieldByName('ItmQnt').AsInteger := oTxtDoc.ReadInteger ('ItmQnt');
    dmLDG.btCSH.FieldByName('PrnCnt').AsInteger := oTxtDoc.ReadInteger ('PrnCnt');
    dmLDG.btCSH.FieldByName('DocSpc').AsInteger := oTxtDoc.ReadInteger ('DocSpc');
    dmLDG.btCSH.FieldByName('CrtUser').AsString := oTxtDoc.ReadString ('CrtUser');
    dmLDG.btCSH.FieldByName('CrtDate').AsDateTime := oTxtDoc.ReadDate ('CrtDate');
    dmLDG.btCSH.FieldByName('CrtTime').AsDateTime := oTxtDoc.ReadTime ('CrtTime');
    dmLDG.btCSH.FieldByName('ModUser').AsString := oTxtDoc.ReadString ('ModUser');
    dmLDG.btCSH.FieldByName('ModDate').AsDateTime := oTxtDoc.ReadDate ('ModDate');
    dmLDG.btCSH.FieldByName('ModTime').AsDateTime := oTxtDoc.ReadTime ('ModTime');
    dmLDG.btCSH.FieldByName('Sended').AsInteger := 1;
    dmLDG.btCSH.Post;
  end;
end;

procedure TCsdTxt.LoadTxtToTmp; // Nacita poloky z prenosoveho suboru do docasneh databaze ptCSI
begin
  If oTxtDoc.ItemCount>0 then begin
    // Ulozime polozky do docasneho suboru
    oTxtDoc.First;
    Repeat
      If not dmLDG.ptCSI.FindKey([oTxtDoc.ReadInteger ('ItmNum')]) then begin
        dmLDG.ptCSI.Insert;
        dmLDG.ptCSI.FieldByName('RowNum').AsInteger := dmLDG.ptCSI.RecordCount+1;
        dmLDG.ptCSI.FieldByName('DocNum').AsString := dmLDG.btCSH.FieldByName('DocNum').AsString;
        dmLDG.ptCSI.FieldByName('ItmNum').AsInteger := oTxtDoc.ReadInteger ('ItmNum');
        dmLDG.ptCSI.FieldByName('DocDate').AsDateTime := oTxtDoc.ReadDate ('DocDate');
        dmLDG.ptCSI.FieldByName('Describe').AsString := oTxtDoc.ReadString ('Describe');
        dmLDG.ptCSI.FieldByName('DocType').AsString := dmLDG.btCSH.FieldByName('DocType').AsString;
        dmLDG.ptCSI.FieldByName('VatPrc').AsInteger := oTxtDoc.ReadInteger ('VatPrc');
        dmLDG.ptCSI.FieldByName('PyDvzName').AsString := oTxtDoc.ReadString ('PyDvzName');
        dmLDG.ptCSI.FieldByName('PyAValue').AsFloat := oTxtDoc.ReadFloat ('PyAValue');
        dmLDG.ptCSI.FieldByName('PyBValue').AsFloat := oTxtDoc.ReadFloat ('PyBValue');
        dmLDG.ptCSI.FieldByName('PyPdfVal').AsFloat := oTxtDoc.ReadFloat ('PyPdfVal');
        dmLDG.ptCSI.FieldByName('AcDvzName').AsString := oTxtDoc.ReadString ('AcDvzName');
        dmLDG.ptCSI.FieldByName('AcAValue').AsFloat := oTxtDoc.ReadFloat ('AcAValue');
        dmLDG.ptCSI.FieldByName('AcBValue').AsFloat := oTxtDoc.ReadFloat ('AcBValue');
        dmLDG.ptCSI.FieldByName('AcCrdVal').AsFloat := oTxtDoc.ReadFloat ('AcCrdVal');
        dmLDG.ptCSI.FieldByName('AcPdfVal').AsFloat := oTxtDoc.ReadFloat ('AcPdfVal');
        dmLDG.ptCSI.FieldByName('FgDvzName').AsString := oTxtDoc.ReadString ('FgDvzName');
        dmLDG.ptCSI.FieldByName('FgCourse').AsFloat := oTxtDoc.ReadFloat ('FgCourse');
        dmLDG.ptCSI.FieldByName('FgPayVal').AsFloat := oTxtDoc.ReadFloat ('FgPayVal');
        dmLDG.ptCSI.FieldByName('ConDoc').AsString := oTxtDoc.ReadString ('ConDoc');
        dmLDG.ptCSI.FieldByName('ConExt').AsString := oTxtDoc.ReadString ('ConExt');
        dmLDG.ptCSI.FieldByName('WriNum').AsInteger := oTxtDoc.ReadInteger ('WriNum');
        dmLDG.ptCSI.FieldByName('CentNum').AsInteger := oTxtDoc.ReadInteger ('CentNum');
        dmLDG.ptCSI.FieldByName('CrdSnt').AsString := oTxtDoc.ReadString ('CrdSnt');
        dmLDG.ptCSI.FieldByName('CrdAnl').AsString := oTxtDoc.ReadString ('CrdAnl');
        dmLDG.ptCSI.FieldByName('PdfSnt').AsString := oTxtDoc.ReadString ('PdfSnt');
        dmLDG.ptCSI.FieldByName('PdfAnl').AsString := oTxtDoc.ReadString ('PdfAnl');
        dmLDG.ptCSI.FieldByName('AccSnt').AsString := oTxtDoc.ReadString ('AccSnt');
        dmLDG.ptCSI.FieldByName('AccAnl').AsString := oTxtDoc.ReadString ('AccAnl');
        dmLDG.ptCSI.FieldByName('PaCode').AsInteger := oTxtDoc.ReadInteger ('PaCode');
        dmLDG.ptCSI.FieldByName('CrtUser').AsString := oTxtDoc.ReadString ('CrtUser');
        dmLDG.ptCSI.FieldByName('CrtDate').AsDateTime := oTxtDoc.ReadDate ('CrtDate');
        dmLDG.ptCSI.FieldByName('CrtTime').AsDateTime := oTxtDoc.ReadTime ('CrtTime');
        dmLDG.ptCSI.FieldByName('ModUser').AsString := oTxtDoc.ReadString ('ModUser');
        dmLDG.ptCSI.FieldByName('ModDate').AsDateTime := oTxtDoc.ReadDate ('ModDate');
        dmLDG.ptCSI.FieldByName('ModTime').AsDateTime := oTxtDoc.ReadTime ('ModTime');
        dmLDG.ptCSI.Post;
      end;
      Application.ProcessMessages;
      oTxtDoc.Next;
    until oTxtDoc.Eof;
  end;
end;

procedure TCsdTxt.DeleteCsi; // Vymaze polozky dokladu, ktore nie su v docasnej databaze
begin
  If dmLDG.btCSI.IndexName<>'DocNum' then dmLDG.btCSI.IndexName:='DocNum';
  If dmLDG.btCSI.FindKey ([oDocNum]) then begin
    Repeat
      Application.ProcessMessages;
      dmLDG.btCSI.Delete;
    until (dmLDG.btCSI.Eof) or (dmLDG.btCSI.RecordCount=0) or (dmLDG.btCSI.FieldByName('DocNum').AsString<>oDocNum);
  end;
end;

procedure TCsdTxt.AddNewItmToCsi; // Prida nove polozky do dokladu
begin
  dmLDG.ptCSI.First;
  dmLDG.btCSI.Sended := FALSE;
  dmLDG.btCSI.Modify := FALSE;
  dmLDG.btCSI.IndexName:='DoIt';
  dmLDG.btCSI.First;
  Repeat
    If not dmLDG.btCSI.FindKey ([oDocNum,dmLDG.ptCSI.FieldByName('ItmNum').AsInteger]) then begin
      dmLDG.btCSI.Insert;
      PX_To_BTR (dmLDG.ptCSI,dmLDG.btCSI);
      dmLDG.btCSI.Post;
    end;
    Application.ProcessMessages;
    dmLDG.ptCSI.Next;
  until (dmLDG.ptCSI.Eof);
  dmLDG.btCSI.Modify := TRUE;
  dmLDG.btCSI.Sended := TRUE;
end;

end.
