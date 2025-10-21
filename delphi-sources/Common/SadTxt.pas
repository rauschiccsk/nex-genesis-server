unit SadTxt;
{$F+}

interface

uses
  IcTypes, IcConv, IcTools, IniFiles, SysUtils, NexPath, NexIni,
  TxtWrap, TxtCut, StkCanc, DocHand, TxtDoc, Forms;


type
  TSadTxt = class
    constructor Create;
    destructor  Destroy; override;
    private
      oDocNum: Str12; // Cislo dokladu ktorym pracujeme
      procedure LoadTxtToSAh; // Nacita udaje z prenosoveho suboru a vytvori alebo opravy hlavicku dokladu
      procedure LoadTxtToTmp; // Nacita poloky z prenosoveho suboru do docasneh databaze ptCSI
      procedure DeleteSai; // Vymaze polozky doacieho listu, ktore nie su v docasnej databaze
      procedure AddNewItmToSai; // Prida nove polozky do dokladu
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

constructor TSadTxt.Create;
begin
end;

destructor TSadTxt.Destroy;
begin
end;

procedure TSadTxt.SaveToFile (pDocNum:Str12);  // Ulozi zadany doklad do textoveho suboru
var mFileName:string;
begin
  mFileName := gIni.GetZipPath+pDocNum+'.TXT';
  oTxtDoc := TTxtDoc.Create;
  If FileExists (mFileName) then DeleteFile (mFileName);
  // Ulozime hlacivku dokladu
  oTxtDoc.WriteString ('DocNum',dmCAB.btSAH.FieldByName('DocNum').AsString);
  oTxtDoc.WriteDate ('DocDate',dmCAB.btSAH.FieldByName('DocDate').AsDateTime);
  oTxtDoc.WriteFloat ('VatPrc1',dmCAB.btSAH.FieldByName('VatPrc1').AsFloat);
  oTxtDoc.WriteFloat ('VatPrc2',dmCAB.btSAH.FieldByName('VatPrc2').AsFloat);
  oTxtDoc.WriteFloat ('VatPrc3',dmCAB.btSAH.FieldByName('VatPrc3').AsFloat);
  oTxtDoc.WriteInteger ('PrnCnt',dmCAB.btSAH.FieldByName('PrnCnt').AsInteger);
  oTxtDoc.WriteString ('CrtUser',dmCAB.btSAH.FieldByName('CrtUser').AsString);
  oTxtDoc.WriteDate ('CrtDate',dmCAB.btSAH.FieldByName('CrtDate').AsDateTime);
  oTxtDoc.WriteTime ('CrtTime',dmCAB.btSAH.FieldByName('CrtTime').AsDateTime);
  oTxtDoc.WriteInteger ('ModNum',dmCAB.btSAH.FieldByName('ModNum').AsInteger);
  oTxtDoc.WriteString ('ModUser',dmCAB.btSAH.FieldByName('ModUser').AsString);
  oTxtDoc.WriteDate ('ModDate',dmCAB.btSAH.FieldByName('ModDate').AsDateTime);
  oTxtDoc.WriteTime ('ModTime',dmCAB.btSAH.FieldByName('ModTime').AsDateTime);
  // Ulozime poloziek dokladu
  If dmCAB.btSAI.IndexName<>'DoGsSt' then dmCAB.btSAI.IndexName := 'DoGsSt';
  dmCAB.btSAI.FindNearest ([pDocNum,0]);
  If dmCAB.btSAI.FieldByName ('DocNum').AsString=dmCAB.btSAI.FieldByName ('DocNum').AsString then begin
    Repeat
      oTxtDoc.Insert;
      oTxtDoc.WriteString ('DocNum',dmCAB.btSAI.FieldByName ('DocNum').AsString);
      oTxtDoc.WriteInteger ('GsCode',dmCAB.btSAI.FieldByName ('GsCode').AsInteger);
      oTxtDoc.WriteInteger ('MgCode',dmCAB.btSAI.FieldByName ('MgCode').AsInteger);
      oTxtDoc.WriteString ('GsName',dmCAB.btSAI.FieldByName ('GsName').AsString);
      oTxtDoc.WriteString ('BarCode',dmCAB.btSAI.FieldByName ('BarCode').AsString);
      oTxtDoc.WriteString ('StkCode',dmCAB.btSAI.FieldByName ('StkCode').AsString);
      oTxtDoc.WriteFloat ('SeQnt',dmCAB.btSAI.FieldByName ('SeQnt').AsFloat);
      oTxtDoc.WriteFloat ('SuQnt',dmCAB.btSAI.FieldByName ('SuQnt').AsFloat);
      oTxtDoc.WriteFloat ('CValue',dmCAB.btSAI.FieldByName ('CValue').AsFloat);
      oTxtDoc.WriteInteger ('VatPrc',dmCAB.btSAI.FieldByName ('VatPrc').AsInteger);
      oTxtDoc.WriteFloat ('DscVal',dmCAB.btSAI.FieldByName ('DscVal').AsFloat);
      oTxtDoc.WriteFloat ('AValue',dmCAB.btSAI.FieldByName ('AValue').AsFloat);
      oTxtDoc.WriteFloat ('BValue',dmCAB.btSAI.FieldByName ('BValue').AsFloat);
      oTxtDoc.WriteDate ('DocDate',dmCAB.btSAI.FieldByName ('DocDate').AsDateTime);
      oTxtDoc.WriteString ('StkStat',dmCAB.btSAI.FieldByName ('StkStat').AsString);
      oTxtDoc.WriteString ('CrtUser',dmCAB.btSAI.FieldByName ('CrtUser').AsString);
      oTxtDoc.WriteDate ('CrtDate',dmCAB.btSAI.FieldByName ('CrtDate').AsDateTime);
      oTxtDoc.WriteTime ('CrtTime',dmCAB.btSAI.FieldByName ('CrtTime').AsDateTime);
      oTxtDoc.WriteInteger ('ModNum',dmCAB.btSAI.FieldByName ('ModNum').AsInteger);
      oTxtDoc.WriteString ('ModUser',dmCAB.btSAI.FieldByName ('ModUser').AsString);
      oTxtDoc.WriteDate ('ModDate',dmCAB.btSAI.FieldByName ('ModDate').AsDateTime);
      oTxtDoc.WriteTime ('ModTime',dmCAB.btSAI.FieldByName ('ModTime').AsDateTime);
      oTxtDoc.WriteInteger ('StkNum',dmCAB.btSAI.FieldByName ('StkNum').AsInteger);
      oTxtDoc.Post;
      Application.ProcessMessages;
      dmCAB.btSAI.Next;
    until (dmCAB.btSAI.Eof) or (dmCAB.btSAI.FieldByName('DocNum').AsString<>pDocNum);
  end;
  oTxtDoc.SaveToFile (mFileName);
  FreeAndNil (oTxtDoc);
end;

procedure TSadTxt.LoadFromFile (pDocNum:Str12);  // Nacita doklad z textoveho suboru
var mFileName:string;
begin
  oDocNum := pDocNum;
  mFileName := gIni.GetZipPath+pDocNum+'.TXT';
  If FileExists (mFileName) then begin
    oTxtDoc := TTxtDoc.Create;
    oTxtDoc.LoadFromFile (mFileName);
    LoadTxtToSah; // Nacita udaje z prenosoveho suboru a vytvori alebo opravy hlavicku dokladu
//    If dmCAB.btSAH.FieldByName('ItmQnt').AsInteger>0 then begin  // Ak doklad ma polozky
      // Polozky dokladu
      dmCAB.ptSAI.Open;
      LoadTxtToTmp; // Nacita poloky z prenosoveho suboru do docasneh databaze ptCSI
      DeleteSai; // Vymaze polozky FA, ktore nie su v docasnej databaze
      AddNewItmToSai; // Prida nove polozky do dokladu
      dmCAB.ptSAI.Close;
      SahRecalc (dmCAB.btSAH,dmCAB.btSAI,NIL);  // Prepocita hlavicku zadaneho dokladu podla jeho poloziek
//    end;
    FreeAndNil (oTxtDoc);
    DeleteFile (mFileName);
  end;
end;

procedure TSadTxt.LoadTxtToSah; // Nacita udaje z prenosoveho suboru a vytvori alebo opravy hlavicku dokladu
begin
  If dmCAB.btSAH.IndexName<>'DocNum' then dmCAB.btSAH.IndexName:='DocNum';
  If dmCAB.btSAH.FindKey ([oDocNum])
    then dmCAB.btSAH.Edit // Uprava hlavicky dokladu
    else dmCAB.btSAH.Insert;  // Novy doklad
  dmCAB.btSAH.FieldByName('DocNum').AsString := oTxtDoc.ReadString ('DocNum');
  dmCAB.btSAH.FieldByName('DocDate').AsDateTime := oTxtDoc.ReadDate ('DocDate');
  dmCAB.btSAH.FieldByName('VatPrc1').AsFloat := oTxtDoc.ReadFloat ('VatPrc1');
  dmCAB.btSAH.FieldByName('VatPrc2').AsFloat := oTxtDoc.ReadFloat ('VatPrc2');
  dmCAB.btSAH.FieldByName('VatPrc3').AsFloat := oTxtDoc.ReadFloat ('VatPrc3');
  dmCAB.btSAH.FieldByName('PrnCnt').AsInteger := oTxtDoc.ReadInteger ('PrnCnt');
  dmCAB.btSAH.FieldByName('CrtUser').AsString := oTxtDoc.ReadString ('CrtUser');
  dmCAB.btSAH.FieldByName('CrtDate').AsDateTime := oTxtDoc.ReadDate ('CrtDate');
  dmCAB.btSAH.FieldByName('CrtTime').AsDateTime := oTxtDoc.ReadTime ('CrtTime');
  dmCAB.btSAH.FieldByName('ModNum').AsInteger := oTxtDoc.ReadInteger ('ModNum');
  dmCAB.btSAH.FieldByName('ModUser').AsString := oTxtDoc.ReadString ('ModUser');
  dmCAB.btSAH.FieldByName('ModDate').AsDateTime := oTxtDoc.ReadDate ('ModDate');
  dmCAB.btSAH.FieldByName('ModTime').AsDateTime := oTxtDoc.ReadTime ('ModTime');
  dmCAB.btSAH.Post;
end;

procedure TSadTxt.LoadTxtToTmp; // Nacita poloky z prenosoveho suboru do docasneh databaze ptCSI
begin
  // Ulozime polozky do docasneho suboru
  oTxtDoc.First;
  Repeat
    dmCAB.ptSAI.Insert;
    dmCAB.ptSAI.FieldByName ('DocNum').AsString    := oTxtDoc.ReadString ('DocNum');
    dmCAB.ptSAI.FieldByName ('GsCode').AsInteger   := oTxtDoc.ReadInteger ('GsCode');
    dmCAB.ptSAI.FieldByName ('MgCode').AsInteger   := oTxtDoc.ReadInteger ('MgCode');
    dmCAB.ptSAI.FieldByName ('GsName').AsString    := oTxtDoc.ReadString ('GsName');
    dmCAB.ptSAI.FieldByName ('BarCode').AsString   := oTxtDoc.ReadString ('BarCode');
    dmCAB.ptSAI.FieldByName ('StkCode').AsString   := oTxtDoc.ReadString ('StkCode');
    dmCAB.ptSAI.FieldByName ('SeQnt').AsFloat      := oTxtDoc.ReadFloat ('SeQnt');
    dmCAB.ptSAI.FieldByName ('SuQnt').AsFloat      := oTxtDoc.ReadFloat ('SuQnt');
    dmCAB.ptSAI.FieldByName ('CValue').AsFloat     := oTxtDoc.ReadFloat ('CValue');
    dmCAB.ptSAI.FieldByName ('VatPrc').AsInteger   := oTxtDoc.ReadInteger ('VatPrc');
    dmCAB.ptSAI.FieldByName ('DscVal').AsFloat     := oTxtDoc.ReadFloat ('DscVal');
    dmCAB.ptSAI.FieldByName ('AValue').AsFloat     := oTxtDoc.ReadFloat ('AValue');
    dmCAB.ptSAI.FieldByName ('BValue').AsFloat     := oTxtDoc.ReadFloat ('BValue');
    dmCAB.ptSAI.FieldByName ('DocDate').AsDateTime := oTxtDoc.ReadDate ('DocDate');
    dmCAB.ptSAI.FieldByName ('StkStat').AsString   := oTxtDoc.ReadString ('StkStat');
    dmCAB.ptSAI.FieldByName ('CrtUser').AsString   := oTxtDoc.ReadString ('CrtUser');
    dmCAB.ptSAI.FieldByName ('CrtDate').AsDateTime := oTxtDoc.ReadDate ('CrtDate');
    dmCAB.ptSAI.FieldByName ('CrtTime').AsDateTime := oTxtDoc.ReadTime ('CrtTime');
    dmCAB.ptSAI.FieldByName ('ModNum').AsInteger   := oTxtDoc.ReadInteger ('ModNum');
    dmCAB.ptSAI.FieldByName ('ModUser').AsString   := oTxtDoc.ReadString ('ModUser');
    dmCAB.ptSAI.FieldByName ('ModDate').AsDateTime := oTxtDoc.ReadDate ('ModDate');
    dmCAB.ptSAI.FieldByName ('ModTime').AsDateTime := oTxtDoc.ReadTime ('ModTime');
    dmCAB.btSAI.FieldByName ('StkNum').AsInteger   := oTxtDoc.ReadInteger ('StkNum');
    dmCAB.ptSAI.Post;
    oTxtDoc.Next;
    Application.ProcessMessages;
  until oTxtDoc.Eof;
end;

procedure TSadTxt.DeleteSai; // Vymaze polozky dokladu, ktore nie su v docasnej databaze
begin
  If dmCAB.btSAI.IndexName<>'DocNum' then dmCAB.btSAI.IndexName:='DocNum';
  If dmCAB.btSAI.FindKey ([oDocNum]) then begin
    Repeat
      Application.ProcessMessages;
      dmCAB.btSAI.Delete;
    until (dmCAB.btSAI.Eof) or (dmCAB.btSAI.RecordCount=0) or (dmCAB.btSAI.FieldByName('DocNum').AsString<>oDocNum);
  end;
end;

procedure TSadTxt.AddNewItmToSai; // Prida nove polozky do dokladu
begin
  dmCAB.btSAI.Sended := FALSE;
  dmCAB.btSAI.Modify := FALSE;
  dmCAB.btSAI.IndexName:='DoGsSt';
  dmCAB.ptSAI.First;
  Repeat
    If not dmCAB.btSAI.FindKey ([oDocNum,dmCAB.ptSAI.FieldByName('GsCode').AsInteger,dmCAB.ptSAI.FieldByName('StkNum').AsInteger]) then begin
      dmCAB.btSAI.Insert;
      dmCAB.btSAI.FieldByName ('DocNum').AsString := oDocNum;
      dmCAB.btSAI.FieldByName ('GsCode').AsInteger := dmCAB.ptSAI.FieldByName ('GsCode').AsInteger;
      dmCAB.btSAI.FieldByName ('StkNum').AsInteger := dmCAB.ptSAI.FieldByName ('StkNum').AsInteger;
      dmCAB.btSAI.FieldByName ('MgCode').AsInteger := dmCAB.ptSAI.FieldByName ('MgCode').AsInteger;
      dmCAB.btSAI.FieldByName ('GsName').AsString := dmCAB.ptSAI.FieldByName ('GsName').AsString;
      dmCAB.btSAI.FieldByName ('BarCode').AsString := dmCAB.ptSAI.FieldByName ('BarCode').AsString;
      dmCAB.btSAI.FieldByName ('StkCode').AsString := dmCAB.ptSAI.FieldByName ('StkCode').AsString;
      dmCAB.btSAI.FieldByName ('SeQnt').AsFloat := dmCAB.ptSAI.FieldByName ('SeQnt').AsFloat;
      dmCAB.btSAI.FieldByName ('SuQnt').AsFloat := dmCAB.ptSAI.FieldByName ('SuQnt').AsFloat;
      dmCAB.btSAI.FieldByName ('CValue').AsFloat := dmCAB.ptSAI.FieldByName ('CValue').AsFloat;
      dmCAB.btSAI.FieldByName ('VatPrc').AsInteger := dmCAB.ptSAI.FieldByName ('VatPrc').AsInteger;
      dmCAB.btSAI.FieldByName ('DscVal').AsFloat := dmCAB.ptSAI.FieldByName ('DscVal').AsFloat;
      dmCAB.btSAI.FieldByName ('AValue').AsFloat := dmCAB.ptSAI.FieldByName ('AValue').AsFloat;
      dmCAB.btSAI.FieldByName ('BValue').AsFloat := dmCAB.ptSAI.FieldByName ('BValue').AsFloat;
      dmCAB.btSAI.FieldByName ('DocDate').AsDateTime := dmCAB.ptSAI.FieldByName ('DocDate').AsDateTime;
      dmCAB.btSAI.FieldByName ('StkStat').AsString := dmCAB.ptSAI.FieldByName ('StkStat').AsString;
      dmCAB.btSAI.FieldByName ('CrtUser').AsString := dmCAB.ptSAI.FieldByName ('CrtUser').AsString;
      dmCAB.btSAI.FieldByName ('CrtDate').AsDateTime := dmCAB.ptSAI.FieldByName ('CrtDate').AsDateTime;
      dmCAB.btSAI.FieldByName ('CrtTime').AsDateTime := dmCAB.ptSAI.FieldByName ('CrtTime').AsDateTime;
      dmCAB.btSAI.FieldByName ('ModNum').AsInteger := dmCAB.ptSAI.FieldByName ('ModNum').AsInteger;
      dmCAB.btSAI.FieldByName ('ModUser').AsString := dmCAB.ptSAI.FieldByName ('ModUser').AsString;
      dmCAB.btSAI.FieldByName ('ModDate').AsDateTime := dmCAB.ptSAI.FieldByName ('ModDate').AsDateTime;
      dmCAB.btSAI.FieldByName ('ModTime').AsDateTime := dmCAB.ptSAI.FieldByName ('ModTime').AsDateTime;
      dmCAB.btSAI.Post;
    end;
    Application.ProcessMessages;
    dmCAB.ptSAI.Next;
  until (dmCAB.ptSAI.Eof);
  dmCAB.btSAI.Modify := TRUE;
  dmCAB.btSAI.Sended := TRUE;
end;

end.
