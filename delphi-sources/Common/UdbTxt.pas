unit UdbTxt;
{$F+}

interface

uses
  IcTypes, IcVariab, IcConv, IcTools, IniFiles, SysUtils, NexPath, NexIni, NexGlob,
  TxtWrap, TxtCut, StkCanc, DocHand, TxtDoc, Forms;

type
  TUdbTxt = class
    constructor Create;
    destructor  Destroy; override;
    private
      oDocNum: Str12; // Cislo dokladu ktorym pracujeme
      procedure LoadTxtToUdh; // Nacita udaje z prenosoveho suboru a vytvori alebo opravy hlavicku prijemky
      procedure LoadTxtToTmp; // Nacita poloky z prenosoveho suboru do docasneh databaze ptUDI
      procedure DeleteUdi; // Vymaze polozky doacieho listu, ktore nie su v docasnej databaze
      procedure AddNewItmToUdi; // Prida nove polozky do prijemky
    public
      oCount: word;
      oTxtDoc: TTxtDoc;
      oLoadDocSuccesful:boolean;
      oSavedFileName:ShortString; // Nazov naposledy ulozeneho suboru
      function LoadDocSuccesful:boolean; // TRUE ak doklad bol uspesne nacitani
      function ConVerifyOk(pFile:TIniFile):boolean; // TRUE ak potvrdenka je sulade s odoslanym dokaldom
      procedure SaveDocToFile (pDocNum:Str12;pWriNum,pSndNum:word);  // Ulozi zadany doklad do textoveho suboru
      procedure SaveConToFile (pDocNum:Str12);  // Ulozi potvrdenku o prijati dokladu
      procedure LoadDocFrFile (pArcPath,pFileName:ShortString);  // Nacita doklad z textoveho suboru
      procedure LoadConFrFile (pArcPath,pFileName:ShortString);  // Nacita potvrdenku o prijati dokladu
      procedure SaveToSndLst (pRcvDate,pRcvTime:Str10;pRcvStat:byte);
      procedure SaveSndStat; // Zisti stav internetoveho prenosu a ulozi na doklad
    published
      property Count:word read oCount;
      property SavedFileName:ShortString read oSavedFileName;
  end;

implementation

uses
   DM_SYSTEM, DM_STKDAT;

constructor TUdbTxt.Create;
begin
  If not DirectoryExists (gPath.BufPath) then ForceDirectories (gPath.BufPath);
end;

destructor TUdbTxt.Destroy;
begin
end;

function TUdbTxt.LoadDocSuccesful:boolean; // TRUE ak doklad bol uspesne nacitani
begin
  Result := oLoadDocSuccesful;
end;

function TUdbTxt.ConVerifyOk(pFile:TIniFile):boolean; // TRUE ak potvrdenka je sulade s odoslanym dokaldom
begin
  Result := (pFile.ReadString('HEAD','DocDate','')=dmSTK.btUDH.FieldByName('DocDate').AsString) and
            (pFile.ReadInteger('HEAD','PaCode',0)=dmSTK.btUDH.FieldByName('PaCode').AsInteger) and
             Eq2(pFile.ReadFloat('HEAD','DocVal',0),dmSTK.btUDH.FieldByName('FgBValue').AsFloat) and
            (pFile.ReadInteger('HEAD','ItmQnt',0)=dmSTK.btUDH.FieldByName('ItmQnt').AsInteger);
end;

procedure TUdbTxt.SaveDocToFile (pDocNum:Str12;pWriNum,pSndNum:word);  // Ulozi zadany doklad do textoveho suboru
var mFileName,mDocFileName,mTmpFileName:ShortString;
begin
  mFileName := pDocNum+'-'+StrIntZero(pWriNum,3)+'-'+StrIntZero(pSndNum,4);
  mDocFileName := gPath.BufPath+mFileName+'.DOC';
  mTmpFileName := gPath.BufPath+mFileName+'.TMP';
  oSavedFileName := mFileName+'.DOC';
  oTxtDoc := TTxtDoc.Create;
  oTxtDoc.SetDelimiter ('');
  oTxtDoc.SetSeparator (';');
  If FileExists (mTmpFileName+'') then DeleteFile (mTmpFileName);
  // Ulozime hlacivku dokladu UDH.BDF
  oTxtDoc.WriteString    ('DatType',  'DOC');
  oTxtDoc.WriteInteger   ('SndNum',   pSndNum);
  oTxtDoc.WriteInteger   ('SerNum',   dmSTK.btUDH.FieldByName('SerNum').AsInteger);
  oTxtDoc.WriteString    ('DocNum',   dmSTK.btUDH.FieldByName('DocNum').AsString);
  oTxtDoc.WriteInteger   ('WriNum',   dmSTK.btUDH.FieldByName('WriNum').AsInteger);
  oTxtDoc.WriteInteger   ('StkNum',   dmSTK.btUDH.FieldByName('StkNum').AsInteger);
  oTxtDoc.WriteDate      ('DocDate',  dmSTK.btUDH.FieldByName('DocDate').AsDateTime);
  oTxtDoc.WriteInteger   ('PaCode',   dmSTK.btUDH.FieldByName('PaCode').AsInteger);
  oTxtDoc.WriteString    ('PaName',   dmSTK.btUDH.FieldByName('PaName').AsString);
  oTxtDoc.WriteString    ('RegName',  dmSTK.btUDH.FieldByName('RegName').AsString);
  oTxtDoc.WriteString    ('RegIno',   dmSTK.btUDH.FieldByName('RegIno').AsString);
  oTxtDoc.WriteString    ('RegTin',   dmSTK.btUDH.FieldByName('RegTin').AsString);
  oTxtDoc.WriteString    ('RegVin',   dmSTK.btUDH.FieldByName('RegVin').AsString);
  oTxtDoc.WriteString    ('RegAddr',  dmSTK.btUDH.FieldByName('RegAddr').AsString);
  oTxtDoc.WriteString    ('RegSta',   dmSTK.btUDH.FieldByName('RegSta').AsString);
  oTxtDoc.WriteString    ('RegCty',   dmSTK.btUDH.FieldByName('RegCty').AsString);
  oTxtDoc.WriteString    ('RegCtn',   dmSTK.btUDH.FieldByName('RegCtn').AsString);
  oTxtDoc.WriteString    ('RegZip',   dmSTK.btUDH.FieldByName('RegZip').AsString);
  oTxtDoc.WriteString    ('RegTel',   dmSTK.btUDH.FieldByName('RegTel').AsString);
  oTxtDoc.WriteInteger   ('PlsNum',   dmSTK.btUDH.FieldByName('PlsNum').AsInteger);
  oTxtDoc.WriteFloat     ('DscPrc',   dmSTK.btUDH.FieldByName('DscPrc').AsFloat);
  oTxtDoc.WriteInteger   ('VatPrc1',  Round(dmSTK.btUDH.FieldByName('VatPrc1').AsFloat));
  oTxtDoc.WriteInteger   ('VatPrc2',  Round(dmSTK.btUDH.FieldByName('VatPrc2').AsFloat));
  oTxtDoc.WriteInteger   ('VatPrc3',  Round(dmSTK.btUDH.FieldByName('VatPrc3').AsFloat));
  oTxtDoc.WriteString    ('FgDvzName',dmSTK.btUDH.FieldByName ('FgDvzName').AsString);
  oTxtDoc.WriteString    ('AcCValue', dmSTK.btUDH.FieldByName ('AcCValue').AsString);
  oTxtDoc.WriteString    ('FgDValue', dmSTK.btUDH.FieldByName ('FgDValue').AsString);
  oTxtDoc.WriteString    ('FgHValue', dmSTK.btUDH.FieldByName ('FgHValue').AsString);
  oTxtDoc.WriteString    ('FgAValue', dmSTK.btUDH.FieldByName ('FgAValue').AsString);
  oTxtDoc.WriteString    ('FgBValue', dmSTK.btUDH.FieldByName ('FgBValue').AsString);
  oTxtDoc.WriteString    ('CusCard',  dmSTK.btUDH.FieldByName ('CusCard').AsString);
  oTxtDoc.WriteString    ('WsdNum',   dmSTK.btUDH.FieldByName ('WsdNum').AsString);
  oTxtDoc.WriteString    ('TcdNum',   dmSTK.btUDH.FieldByName ('TcdNum').AsString);
  oTxtDoc.WriteString    ('IcdNum',   dmSTK.btUDH.FieldByName ('IcdNum').AsString);
  oTxtDoc.WriteString    ('CsdNum',   dmSTK.btUDH.FieldByName ('CsdNum').AsString);
  oTxtDoc.WriteString    ('NudNum',   dmSTK.btUDH.FieldByName ('NudNum').AsString);
  oTxtDoc.WriteString    ('DlrCode',  dmSTK.btUDH.FieldByName ('DlrCode').AsString);
  oTxtDoc.WriteString    ('SpMark',   dmSTK.btUDH.FieldByName ('SpMark').AsString);
  oTxtDoc.WriteDate      ('IcdDate',  dmSTK.btUDH.FieldByName ('IcdDate').AsDateTime);
  oTxtDoc.WriteDate      ('NudDate',  dmSTK.btUDH.FieldByName ('NudDate').AsDateTime);
  oTxtDoc.WriteInteger   ('VatDoc',   dmSTK.btUDH.FieldByName ('VatDoc').AsInteger);
  oTxtDoc.WriteInteger   ('PrnCnt',   dmSTK.btUDH.FieldByName ('PrnCnt').AsInteger);
  oTxtDoc.WriteInteger   ('ItmQnt',   dmSTK.btUDH.FieldByName ('ItmQnt').AsInteger);
  oTxtDoc.WriteInteger   ('DstLck',   dmSTK.btUDH.FieldByName ('DstLck').AsInteger);
  oTxtDoc.WriteInteger   ('DstCls',   dmSTK.btUDH.FieldByName ('DstCls').AsInteger);
  oTxtDoc.WriteInteger   ('BonNum',   dmSTK.btUDH.FieldByName ('BonNum').AsInteger);
  oTxtDoc.WriteString    ('CrtUser',  dmSTK.btUDH.FieldByName('CrtUser').AsString);
  oTxtDoc.WriteString    ('ModUser',  dmSTK.btUDH.FieldByName('ModUser').AsString);
  oTxtDoc.WriteDate      ('ModDate',  dmSTK.btUDH.FieldByName('ModDate').AsDateTime);
  oTxtDoc.WriteTime      ('ModTime',  dmSTK.btUDH.FieldByName('ModTime').AsDateTime);
  oTxtDoc.WriteString    ('NotLots',  dmSTK.btUDH.FieldByName('NotLots').AsString);
  oTxtDoc.WriteString    ('Year',     dmSTK.btUDH.FieldByName('Year').AsString);
  // Ulozime polozky dokladu
  If dmSTK.btUDI.IndexName<>'DoIt' then dmSTK.btUDI.IndexName :='DoIt';
  dmSTK.btUDI.FindNearest ([pDocNum,0]);
  If dmSTK.btUDI.FieldByName ('DocNum').AsString=dmSTK.btUDH.FieldByName ('DocNum').AsString then begin
    Repeat
      oTxtDoc.Insert;
      oTxtDoc.WriteInteger ('ItmNum',   dmSTK.btUDI.FieldByName ('ItmNum').AsInteger);
      oTxtDoc.WriteInteger ('GsCode',   dmSTK.btUDI.FieldByName ('GsCode').AsInteger);
      oTxtDoc.WriteInteger ('MgCode',   dmSTK.btUDI.FieldByName ('MgCode').AsInteger);
      oTxtDoc.WriteString  ('GsName',   dmSTK.btUDI.FieldByName ('GsName').AsString);
      oTxtDoc.WriteString  ('BarCode',  dmSTK.btUDI.FieldByName ('BarCode').AsString);
      oTxtDoc.WriteString  ('StkCode',  dmSTK.btUDI.FieldByName ('StkCode').AsString);
      oTxtDoc.WriteString  ('Notice',   dmSTK.btUDI.FieldByName ('Notice').AsString);
      oTxtDoc.WriteInteger ('StkNum',   dmSTK.btUDI.FieldByName ('StkNum').AsInteger);
      oTxtDoc.WriteFloat   ('Volume',   dmSTK.btUDI.FieldByName ('Volume').AsFloat);
      oTxtDoc.WriteFloat   ('Weight',   dmSTK.btUDI.FieldByName ('Weight').AsFloat);
      oTxtDoc.WriteInteger ('PackGs',   dmSTK.btUDI.FieldByName ('PackGs').AsInteger);
      oTxtDoc.WriteString  ('GsType',   dmSTK.btUDI.FieldByName ('GsType').AsString);
      oTxtDoc.WriteString  ('MsName',   dmSTK.btUDI.FieldByName ('MsName').AsString);
      oTxtDoc.WriteFloat   ('GsQnt',    dmSTK.btUDI.FieldByName ('GsQnt').AsFloat);
      oTxtDoc.WriteInteger ('VatPrc',   dmSTK.btUDI.FieldByName ('VatPrc').AsInteger);
      oTxtDoc.WriteFloat   ('DscPrc',   dmSTK.btUDI.FieldByName ('DscPrc').AsFloat);
      oTxtDoc.WriteFloat   ('FgHPrice', dmSTK.btUDI.FieldByName ('FgHPrice').AsFloat);
      oTxtDoc.WriteFloat   ('FgBPrice', dmSTK.btUDI.FieldByName ('FgBPrice').AsFloat);
      oTxtDoc.WriteFloat   ('AcCValue', dmSTK.btUDI.FieldByName ('AcCValue').AsFloat);
      oTxtDoc.WriteFloat   ('FgDValue', dmSTK.btUDI.FieldByName ('FgDValue').AsFloat);
      oTxtDoc.WriteFloat   ('FgHValue', dmSTK.btUDI.FieldByName ('FgHValue').AsFloat);
      oTxtDoc.WriteFloat   ('FgAValue', dmSTK.btUDI.FieldByName ('FgAValue').AsFloat);
      oTxtDoc.WriteFloat   ('FgBValue', dmSTK.btUDI.FieldByName ('FgBValue').AsFloat);
      oTxtDoc.WriteInteger ('DlrCode', dmSTK.btUDI.FieldByName ('DlrCode').AsInteger);
      oTxtDoc.WriteDate    ('DocDate', dmSTK.btUDI.FieldByName ('DocDate').AsDateTime);
      oTxtDoc.WriteInteger ('PaCode',  dmSTK.btUDI.FieldByName ('PaCode').AsInteger);
      oTxtDoc.WriteString  ('TcdNum',  dmSTK.btUDI.FieldByName ('TcdNum').AsString);
      oTxtDoc.WriteInteger ('TcdItm',  dmSTK.btUDI.FieldByName ('TcdItm').AsInteger);
      oTxtDoc.WriteString  ('IcdNum',  dmSTK.btUDI.FieldByName ('IcdNum').AsString);
      oTxtDoc.WriteInteger ('IcdItm',  dmSTK.btUDI.FieldByName ('IcdItm').AsInteger);
      oTxtDoc.WriteString  ('NudNum',  dmSTK.btUDI.FieldByName ('NudNum').AsString);
      oTxtDoc.WriteInteger ('NudItm',  dmSTK.btUDI.FieldByName ('NudItm').AsInteger);
      oTxtDoc.WriteString  ('FinStat', dmSTK.btUDI.FieldByName ('FinStat').AsString);
      oTxtDoc.WriteString  ('Action',  dmSTK.btUDI.FieldByName ('Action').AsString);
      oTxtDoc.WriteString  ('DscType', dmSTK.btUDI.FieldByName ('DscType').AsString);
      oTxtDoc.WriteString  ('SpMark',  dmSTK.btUDI.FieldByName ('SpMark').AsString);
      oTxtDoc.WriteInteger ('BonNum',  dmSTK.btUDI.FieldByName ('BonNum').AsInteger);
      oTxtDoc.WriteString  ('CrtUser', dmSTK.btUDI.FieldByName ('CrtUser').AsString);
      oTxtDoc.WriteString  ('CrtDate', dmSTK.btUDI.FieldByName ('CrtDate').AsString);
      oTxtDoc.WriteString  ('CrtTime', dmSTK.btUDI.FieldByName ('CrtTime').AsString);
      oTxtDoc.WriteInteger ('ModNum',  dmSTK.btUDI.FieldByName ('ModNum').AsInteger);
      oTxtDoc.WriteString  ('ModUser', dmSTK.btUDI.FieldByName('ModUser').AsString);
      oTxtDoc.WriteString  ('ModDate', dmSTK.btUDI.FieldByName('ModDate').AsString);
      oTxtDoc.WriteString  ('ModTime', dmSTK.btUDI.FieldByName('ModTime').AsString);
      oTxtDoc.Post;
      Application.ProcessMessages;
      dmSTK.btUDI.Next;
    until (dmSTK.btUDI.Eof) or (dmSTK.btUDI.FieldByName('DocNum').AsString<>pDocNum);
  end;
  oTxtDoc.SaveToFile (mTmpFileName);
  If FileExists (mDocFileName) then DeleteFile (mDocFileName);
  RenameFile (mTmpFileName,mDocFileName);
  FreeAndNil (oTxtDoc);
end;

procedure TUdbTxt.SaveConToFile (pDocNum:Str12);  // Ulozi potvrdenku o prijati dokladu
var mFileName,mDocFileName,mTmpFileName:ShortString; mFile:TIniFile;
begin
  mFileName := pDocNum+'-'+StrIntZero(dmSTK.btUDH.FieldByName('WriNum').AsInteger,3)+'-'+StrIntZero(dmSTK.btUDH.FieldByName('SndNum').AsInteger,4);
  mDocFileName := gPath.BufPath+mFileName+'.CON';
  mTmpFileName := gPath.BufPath+mFileName+'.TMP';
  oSavedFileName := mFileName+'.CON';
  If FileExists (mTmpFileName+'') then DeleteFile (mTmpFileName);
  mFile := TIniFile.Create(mTmpFileName);
  mFile.WriteString ('HEAD','DatType','CON');
  mFile.WriteInteger ('HEAD','WriNum',gvSys.WriNum);
  mFile.WriteInteger ('HEAD','SerNum',dmSTK.btUDH.FieldByName('SerNum').AsInteger);
  mFile.WriteString ('HEAD','DocNum',dmSTK.btUDH.FieldByName('DocNum').AsString);
  mFile.WriteDate ('HEAD','DocDate',dmSTK.btUDH.FieldByName('DocDate').AsDateTime);
  mFile.WriteInteger ('HEAD','PaCode',dmSTK.btUDH.FieldByName('PaCode').AsInteger);
  mFile.WriteFloat ('HEAD','DocVal',dmSTK.btUDH.FieldByName('FgBValue').AsFloat);
  mFile.WriteInteger ('HEAD','ItmQnt',dmSTK.btUDH.FieldByName('ItmQnt').AsInteger);
  mFile.WriteInteger ('HEAD','SndNum',dmSTK.btUDH.FieldByName('SndNum').AsInteger);
  mFile.WriteString ('HEAD','RcvDate',DateToStr(Date));
  mFile.WriteString ('HEAD','RcvTime',TimeToStr(Time));
  mFile.WriteString ('HEAD','Year',dmSTK.btUDH.FieldByName('Year').AsString);
  FreeAndNil (mFile);
  If FileExists (mDocFileName) then DeleteFile (mDocFileName);
  RenameFile (mTmpFileName,mDocFileName);
end;

procedure TUdbTxt.LoadDocFrFile (pArcPath,pFileName:ShortString);  // Nacita doklad z textoveho suboru
var mFileName:string;
begin
  oLoadDocSuccesful := FALSE;
  oDocNum := copy(pFileName,1,12);
  mFileName := pArcPath+pFileName;
  If FileExists (mFileName) then begin
    oLoadDocSuccesful := TRUE;
    oTxtDoc := TTxtDoc.Create;
    oTxtDoc.SetDelimiter ('');
    oTxtDoc.SetSeparator (';');
    oTxtDoc.LoadFromFile (mFileName);
    LoadTxtToUdh; // Nacita udaje z prenosoveho suboru a vytvori alebo opravy hlavicku prijemky
    If dmSTK.btUDH.FieldByName('ItmQnt').AsInteger>0 then begin  // Ak doklad ma polozky
      // Polozky dokladu
      dmSTK.ptUDI.Open;
      dmSTK.ptUDI.IndexName :='ItmNum';
      LoadTxtToTmp; // Nacita poloky z prenosoveho suboru do docasneh databaze ptUDI
      DeleteUDI; // Vymaze polozky vydajky, ktore nie su v docasnej databaze
      AddNewItmToUdi; // Prida nove polozky do vydajky
      dmSTK.ptUDI.Close;
      UdhRecalc (dmSTK.btUDH,dmSTK.btUDI);  // Prepocita hlavicku zadaneho dodacieho listu podla jeho poloziek
    end;
    // Poznamky k dokladu
    FreeAndNil (oTxtDoc);
// moznost zapnut    DeleteFile (mFileName);
  end;
end;

procedure TUdbTxt.LoadConFrFile (pArcPath,pFileName:ShortString);  // Nacita potvrdenku o prijati dokladu
var mFileName:ShortString; mFile:TIniFile;  mDocNum:Str12;
begin
  mFileName := pArcPath+pFileName;
  If FileExists (mFileName) then begin
    mFile := TIniFile.Create(mFileName);
    mDocNum := mFile.ReadString ('HEAD','DocNum','');
    dmSTK.btUDH.SwapIndex;
    If dmSTK.btUDH.IndexName<>'DocNum' then dmSTK.btUDH.IndexName := 'DocNum';
    If dmSTK.btUDH.FindKey ([mDocNum]) then begin
      If ConVerifyOk(mFile) then begin
        dmSTK.btUDH.Edit;
        dmSTK.btUDH.FieldByName ('SndStat').AsString := 'O';
        dmSTK.btUDH.Post;
        If dmSYS.btSNDLST.FindKey([mDocNum,mFile.ReadInteger('HEAD','WriNum',0),mFile.ReadInteger('HEAD','SndNum',0)]) then SaveToSndLst (mFile.ReadString('HEAD','RcvDate',''),mFile.ReadString('HEAD','RcvTime',''),0); // Prenos bol potvrdeny
      end
      else SaveToSndLst (mFile.ReadString('HEAD','RcvDate',''),mFile.ReadString('HEAD','RcvTime',''),1);  // Kontrolne udaje nie su zhodne
      SaveSndStat; // Zisti stav internetoveho prenosu a ulozi na doklad
    end;
    dmSTK.btUDH.RestoreIndex;
    FreeAndNil (mFile);
    DeleteFile (mFileName);
  end;
end;

procedure TUdbTxt.SaveToSndLst (pRcvDate,pRcvTime:Str10;pRcvStat:byte);
begin
  dmSYS.btSNDLST.Edit;
  dmSYS.btSNDLST.FieldByName ('RcvDate').AsString := pRcvDate;
  dmSYS.btSNDLST.FieldByName ('RcvTime').AsString := pRcvTime;
  dmSYS.btSNDLST.FieldByName ('RcvStat').AsInteger := pRcvStat;
  dmSYS.btSNDLST.Post;
end;

procedure TUdbTxt.SaveSndStat; // Zisti stav internetoveho prenosu a ulozi na doklad
var mNotCon,mSndErr:byte;
begin
  dmSYS.btSNDLST.FindNearest ([dmSTK.btUDH.FieldByName('DocNum').AsString,dmSTK.btUDH.FieldByName('WriNum').AsInteger]);
  If (dmSYS.btSNDLST.FieldByName('DatNum').AsString=dmSTK.btUDH.FieldByName('DocNum').AsString) and (dmSYS.btSNDLST.FieldByName('WriNum').AsInteger=dmSTK.btUDH.FieldByName('WriNum').AsInteger) then begin
    mNotCon := 0;  mSndErr := 0;
    Repeat
      If dmSYS.btSNDLST.FieldByName('RcvStat').AsInteger=0 then Inc (mNotCon);
      If dmSYS.btSNDLST.FieldByName('RcvStat').AsInteger=9 then Inc (mSndErr);
      Application.ProcessMessages;
      dmSYS.btSNDLST.Next;
    until dmSYS.btSNDLST.Eof or (dmSYS.btSNDLST.FieldByName('DatNum').AsString<>dmSTK.btUDH.FieldByName('DocNum').AsString) and (dmSYS.btSNDLST.FieldByName('WriNum').AsInteger<>dmSTK.btUDH.FieldByName('WriNum').AsInteger);
    dmSTK.btUDH.Modify := FALSE;
    dmSTK.btUDH.Edit;
    If mNotCon=0 then dmSTK.btUDH.FieldByName('SndStat').AsString := 'O';
    If mSndErr>0 then dmSTK.btUDH.FieldByName('SndStat').AsString := 'E';
    dmSTK.btUDH.Post;
    dmSTK.btUDH.Modify := TRUE;
  end;
end;

procedure TUdbTxt.LoadTxtToUdh; // Nacita udaje z prenosoveho suboru a vytvori alebo opravy hlavicku dodacieho listu
begin
  If dmSTK.btUDH.IndexName<>'DocNum' then dmSTK.btUDH.IndexName:='DocNum';
  If dmSTK.btUDH.FindKey ([oDocNum])
    then dmSTK.btUDH.Edit     // Uprava hlavicky dokladu
    else dmSTK.btUDH.Insert;  // Novy doklad
  dmSTK.btUDH.FieldByName('SerNum').AsInteger := oTxtDoc.ReadInteger ('SerNum');
  dmSTK.btUDH.FieldByName('Year').AsString := oTxtDoc.ReadString ('Year');
  dmSTK.btUDH.FieldByName('DocNum').AsString := oTxtDoc.ReadString ('DocNum');
  dmSTK.btUDH.FieldByName('WriNum').AsInteger := oTxtDoc.ReadInteger ('WriNum');
  dmSTK.btUDH.FieldByName('StkNum').AsInteger := oTxtDoc.ReadInteger ('StkNum');
  dmSTK.btUDH.FieldByName('DocDate').AsDateTime := oTxtDoc.ReadDate ('DocDate');
  dmSTK.btUDH.FieldByName('PaCode').AsInteger := oTxtDoc.ReadInteger ('PaCode');
  dmSTK.btUDH.FieldByName('PaName').AsString := oTxtDoc.ReadString ('PaName');
  dmSTK.btUDH.FieldByName('RegName').AsString := oTxtDoc.ReadString ('RegName');
  dmSTK.btUDH.FieldByName('RegIno').AsString := oTxtDoc.ReadString ('RegIno');
  dmSTK.btUDH.FieldByName('RegTin').AsString := oTxtDoc.ReadString ('RegTin');
  dmSTK.btUDH.FieldByName('RegVin').AsString := oTxtDoc.ReadString ('RegVin');
  dmSTK.btUDH.FieldByName('RegAddr').AsString := oTxtDoc.ReadString ('RegAddr');
  dmSTK.btUDH.FieldByName('RegSta').AsString := oTxtDoc.ReadString ('RegSta');
  dmSTK.btUDH.FieldByName('RegCty').AsString := oTxtDoc.ReadString ('RegCty');
  dmSTK.btUDH.FieldByName('RegCtn').AsString := oTxtDoc.ReadString ('RegCtn');
  dmSTK.btUDH.FieldByName('RegZip').AsString := oTxtDoc.ReadString ('RegZip');
  dmSTK.btUDH.FieldByName('RegTel').AsString := oTxtDoc.ReadString ('RegTel');
  dmSTK.btUDH.FieldByName('PlsNum').AsInteger := oTxtDoc.ReadInteger ('PlsNum');
  dmSTK.btUDH.FieldByName('DscPrc').AsFloat := oTxtDoc.ReadFloat ('DscPrc');
  dmSTK.btUDH.FieldByName('VatPrc1').AsFloat := oTxtDoc.ReadInteger ('VatPrc1');
  dmSTK.btUDH.FieldByName('VatPrc2').AsFloat := oTxtDoc.ReadInteger ('VatPrc2');
  dmSTK.btUDH.FieldByName('VatPrc3').AsFloat := oTxtDoc.ReadInteger ('VatPrc3');
  dmSTK.btUDH.FieldByName('FgDvzName').AsString := oTxtDoc.ReadString ('FgDvzName');
  dmSTK.btUDH.FieldByName('AcCValue').AsString := oTxtDoc.ReadString ('AcCValue');
  dmSTK.btUDH.FieldByName('FgDValue').AsString := oTxtDoc.ReadString ('FgDValue');
  dmSTK.btUDH.FieldByName('FgHValue').AsString := oTxtDoc.ReadString ('FgHValue');
  dmSTK.btUDH.FieldByName('FgAValue').AsString := oTxtDoc.ReadString ('FgAValue');
  dmSTK.btUDH.FieldByName('FgBValue').AsString := oTxtDoc.ReadString ('FgBValue');
  dmSTK.btUDH.FieldByName('CusCard').AsString := oTxtDoc.ReadString ('CusCard');
  dmSTK.btUDH.FieldByName('WsdNum').AsString := oTxtDoc.ReadString ('WsdNum');
  dmSTK.btUDH.FieldByName('TcdNum').AsString := oTxtDoc.ReadString ('TcdNum');
  dmSTK.btUDH.FieldByName('IcdNum').AsString := oTxtDoc.ReadString ('IcdNum');
  dmSTK.btUDH.FieldByName('CsdNum').AsString := oTxtDoc.ReadString ('CsdNum');
  dmSTK.btUDH.FieldByName('NudNum').AsString := oTxtDoc.ReadString ('NudNum');
  dmSTK.btUDH.FieldByName('DlrCode').AsString := oTxtDoc.ReadString ('DlrCode');
  dmSTK.btUDH.FieldByName('SpMark').AsString := oTxtDoc.ReadString ('SpMark');
  dmSTK.btUDH.FieldByName('IcdDate').AsDateTime := oTxtDoc.ReadDate ('IcdDate');
  dmSTK.btUDH.FieldByName('NudDate').AsDateTime := oTxtDoc.ReadDate ('NudDate');
  dmSTK.btUDH.FieldByName('VatDoc').AsInteger := oTxtDoc.ReadInteger ('VatDoc');
  dmSTK.btUDH.FieldByName('PrnCnt').AsInteger := oTxtDoc.ReadInteger ('PrnCnt');
  dmSTK.btUDH.FieldByName('ItmQnt').AsInteger := oTxtDoc.ReadInteger ('ItmQnt');
  dmSTK.btUDH.FieldByName('DstLck').AsInteger := oTxtDoc.ReadInteger ('DstLck');
  dmSTK.btUDH.FieldByName('DstCls').AsInteger := oTxtDoc.ReadInteger ('DstCls');
  dmSTK.btUDH.FieldByName('BonNum').AsInteger := oTxtDoc.ReadInteger ('BonNum');
  dmSTK.btUDH.FieldByName('SndNum').AsInteger := oTxtDoc.ReadInteger ('SndNum');
  dmSTK.btUDH.FieldByName('CrtUser').AsString := oTxtDoc.ReadString ('CrtUser');
  dmSTK.btUDH.FieldByName('CrtDate').AsDateTime := oTxtDoc.ReadDate ('CrtDate');
  dmSTK.btUDH.FieldByName('CrtTime').AsString := oTxtDoc.ReadString ('CrtTime');
  dmSTK.btUDH.FieldByName('ModUser').AsString := oTxtDoc.ReadString ('ModUser');
  dmSTK.btUDH.FieldByName('ModDate').AsDateTime := oTxtDoc.ReadDate ('ModDate');
  dmSTK.btUDH.FieldByName('ModTime').AsString := oTxtDoc.ReadString ('ModTime');
  dmSTK.btUDH.Post;
end;

procedure TUdbTxt.LoadTxtToTmp; // Nacita poloky z prenosoveho suboru do docasneh databaze ptUDI
begin
  If oTxtDoc.ItemCount>0 then begin
    // Ulozime polozky do docasneho suboru
    oTxtDoc.First;
    Repeat
      If not dmSTK.ptUDI.FindKey ([oTxtDoc.ReadInteger ('ItmNum')]) then begin
        dmSTK.ptUDI.Insert;
        dmSTK.ptUDI.FieldByName('DocNum').AsString := oDocNum;
        dmSTK.ptUDI.FieldByName ('ItmNum').AsInteger := oTxtDoc.ReadInteger ('ItmNum');
        dmSTK.ptUDI.FieldByName ('GsCode').AsInteger := oTxtDoc.ReadInteger ('GsCode');
        dmSTK.ptUDI.FieldByName ('MgCode').AsInteger := oTxtDoc.ReadInteger ('MgCode');
        dmSTK.ptUDI.FieldByName ('GsName').AsString := oTxtDoc.ReadString ('GsName');
        dmSTK.ptUDI.FieldByName ('BarCode').AsString := oTxtDoc.ReadString ('BarCode');
        dmSTK.ptUDI.FieldByName ('StkCode').AsString := oTxtDoc.ReadString ('StkCode');
        dmSTK.ptUDI.FieldByName ('Notice').AsString := oTxtDoc.ReadString ('Notice');
        dmSTK.ptUDI.FieldByName ('StkNum').AsInteger := oTxtDoc.ReadInteger ('StkNum');
        dmSTK.ptUDI.FieldByName ('Volume').AsFloat := oTxtDoc.ReadFloat ('Volume');
        dmSTK.ptUDI.FieldByName ('Weight').AsFloat := oTxtDoc.ReadFloat ('Weight');
        dmSTK.ptUDI.FieldByName ('PackGs').AsInteger := oTxtDoc.ReadInteger ('PackGs');
        dmSTK.ptUDI.FieldByName ('GsType').AsString := oTxtDoc.ReadString ('GsType');
        dmSTK.ptUDI.FieldByName ('MsName').AsString := oTxtDoc.ReadString ('MsName');
        dmSTK.ptUDI.FieldByName ('GsQnt').AsFloat := oTxtDoc.ReadFloat ('GsQnt');
        dmSTK.ptUDI.FieldByName ('VatPrc').AsInteger := oTxtDoc.ReadInteger ('VatPrc');
        dmSTK.ptUDI.FieldByName ('DscPrc').AsFloat := oTxtDoc.ReadFloat ('DscPrc');
        dmSTK.ptUDI.FieldByName ('FgHPrice').AsFloat := oTxtDoc.ReadFloat ('FgHPrice');
        dmSTK.ptUDI.FieldByName ('FgBPrice').AsFloat := oTxtDoc.ReadFloat ('FgBPrice');
        dmSTK.ptUDI.FieldByName ('AcCValue').AsFloat := oTxtDoc.ReadFloat ('AcCValue');
        dmSTK.ptUDI.FieldByName ('FgDValue').AsFloat := oTxtDoc.ReadFloat ('FgDValue');
        dmSTK.ptUDI.FieldByName ('FgHValue').AsFloat := oTxtDoc.ReadFloat ('FgHValue');
        dmSTK.ptUDI.FieldByName ('FgAValue').AsFloat := oTxtDoc.ReadFloat ('FgAValue');
        dmSTK.ptUDI.FieldByName ('FgBValue').AsFloat := oTxtDoc.ReadFloat ('FgBValue');
        dmSTK.ptUDI.FieldByName ('DlrCode').AsInteger := oTxtDoc.ReadInteger ('DlrCode');
        dmSTK.ptUDI.FieldByName ('DocDate').AsDateTime := oTxtDoc.ReadDate ('DocDate');
        dmSTK.ptUDI.FieldByName ('PaCode').AsInteger := oTxtDoc.ReadInteger ('PaCode');
        dmSTK.ptUDI.FieldByName ('TcdNum').AsString := oTxtDoc.ReadString ('TcdNum');
        dmSTK.ptUDI.FieldByName ('TcdItm').AsInteger := oTxtDoc.ReadInteger ('TcdItm');
        dmSTK.ptUDI.FieldByName ('IcdNum').AsString := oTxtDoc.ReadString ('IcdNum');
        dmSTK.ptUDI.FieldByName ('IcdItm').AsInteger := oTxtDoc.ReadInteger ('IcdItm');
        dmSTK.ptUDI.FieldByName ('NudNum').AsString := oTxtDoc.ReadString ('NudNum');
        dmSTK.ptUDI.FieldByName ('NudItm').AsInteger := oTxtDoc.ReadInteger ('NudItm');
        dmSTK.ptUDI.FieldByName ('FinStat').AsString := oTxtDoc.ReadString ('FinStat');
        dmSTK.ptUDI.FieldByName ('Action').AsString := oTxtDoc.ReadString ('Action');
        dmSTK.ptUDI.FieldByName ('DscType').AsString := oTxtDoc.ReadString ('DscType');
        dmSTK.ptUDI.FieldByName ('SpMark').AsString := oTxtDoc.ReadString ('SpMark');
        dmSTK.ptUDI.FieldByName ('BonNum').AsInteger := oTxtDoc.ReadInteger ('BonNum');
        dmSTK.ptUDI.FieldByName ('CrtUser').AsString := oTxtDoc.ReadString ('CrtUser');
        dmSTK.ptUDI.FieldByName ('CrtDate').AsDateTime := oTxtDoc.ReadDate ('CrtDate');
        dmSTK.ptUDI.FieldByName ('CrtTime').AsDateTime := oTxtDoc.ReadTime ('CrtTime');
        dmSTK.ptUDI.FieldByName ('ModNum').AsInteger := oTxtDoc.ReadInteger ('ModNum');
        dmSTK.ptUDI.FieldByName ('ModUser').AsString := oTxtDoc.ReadString ('ModUser');
        dmSTK.ptUDI.FieldByName ('ModDate').AsDateTime := oTxtDoc.ReadDate ('ModDate');
        dmSTK.ptUDI.FieldByName ('ModTime').AsDateTime := oTxtDoc.ReadTime ('ModTime');
        dmSTK.ptUDI.Post;
      end;
      oTxtDoc.Next;
      Application.ProcessMessages;
    until oTxtDoc.Eof;
  end;
end;                    

procedure TUdbTxt.DeleteUdi; // Vymaze polozky doacieho listu, ktore nie su v docasnej databaze
begin
  If dmSTK.btUDI.IndexName<>'DocNum' then dmSTK.btUDI.IndexName:='DocNum';
  If dmSTK.btUDI.FindKey ([oDocNum]) then begin
    Repeat
      Application.ProcessMessages;
      dmSTK.btUDI.Delete
    until (dmSTK.btUDI.Eof) or (dmSTK.btUDI.RecordCount=0) or (dmSTK.btUDI.FieldByName('DocNum').AsString<>oDocNum);
  end;
end;

procedure TUdbTxt.AddNewItmToUdi; // Prida nove polozky do dodacieho listu
begin
  dmSTK.btUDI.Modify := FALSE;
  dmSTK.btUDI.IndexName:='DoIt';
  dmSTK.ptUDI.First;
  Repeat
    If not dmSTK.btUDI.FindKey ([oDocNum,dmSTK.ptUDI.FieldByName('ItmNum').AsInteger]) then begin
      dmSTK.btUDI.Insert;
      PX_To_BTR(dmSTK.ptUDI,dmSTK.btUDI);
      dmSTK.btUDI.FieldByName ('DocNum').AsString := oDocNum;
      dmSTK.btUDI.Post;
    end;
    Application.ProcessMessages;
    dmSTK.ptUDI.Next;
  until (dmSTK.ptUDI.Eof);
  dmSTK.btUDI.Modify := TRUE;
end;

end.
