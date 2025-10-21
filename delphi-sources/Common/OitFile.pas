unit OitFile;
// *****************************************************************************
// Popis:
// Tento objekt sluzi na ulozenie a nacitanie dokladu z extoveho suboru
// podla specifikacie prenosu pre kazdu zadanu prevadzkovujednotku.
// *****************************************************************************
interface

uses
  IcVariab, IcTypes, IcConv, IcConst, IcTools, TxtDoc, IniFiles,
  NexPath, NexIni, NexMsg, NexError, NexGlob, DocHand,
  Controls, ExtCtrls, Classes, StdCtrls, Buttons, Windows, Messages,
  SysUtils, Graphics, Forms, Dialogs, ComCtrls, LangForm, IcLabels,
  DBTables, PxTable, NexBtrTable, BtrTable, DB, NexPxTable;

type
  TOitFile = class(TLangForm)
    ptItem: TNexPxTable;
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormCreate(Sender: TObject);
  private
      oDocNum: Str12; // Cislo dokladu ktorym pracujeme
      procedure WriteRecData (pRecTable:TNexBtrTable); // Ulozi hlavicku dokladu do textoveho suboru
      procedure WriteBarCode (pBARCODE:TNexBtrTable;pGsCode:longint); // Ulozi podkody
      procedure WriteRecNoti (pNotiTable:TNexBtrTable;pRecNum:longint;pRecName:Str20); // Ulozi poznamky do dokladu
      procedure WriteDocHead (pSndNum:word;pHeadTable:TNexBtrTable); // Ulozi hlavicku dokladu do textoveho suboru
      procedure WriteDocItem (pItemTable:TNexBtrTable;pDocNum:Str12); // Ulozi polozky do dokladu
      procedure WriteDocNoti (pNotiTable:TNexBtrTable;pDocNum:Str12); // Ulozi poznamky do dokladu
      procedure LoadTxtToHead (pHeadTable:TNexBtrTable); // Nacita udaje z prenosoveho suboru a vytvori alebo opravy hlavicku prijemky
      procedure LoadTxtToItem; // Nacita poloky z prenosoveho suboru do docasneh databaze ptUDI
      procedure UpdateItemDat(pItemTable:TNexBtrTable;pSdfFile:ShortString); // Vlozi do polozky len prenesene udaje
      procedure DeleteBtrItem(pItemTable:TNexBtrTable); // Vymaze polozky doacieho listu, ktore nie su v docasnej databaze
      procedure AddTmpToItem(pItemTable:TNexBtrTable); // Prida nove polozky do prijemky
    public
      oCount: word;
      oTxtRec: TIniFile;
      oTxtDoc: TTxtDoc;
      oHeadSdf: ShortString;
      oItemSdf: ShortString;
      oCommand: ShortString; // Pokyn k specialnemu spracovaniu suboru
      oLoadDocSuccesful:boolean;
      oSavedFileName:ShortString; // Nazov naposledy ulozeneho suboru
      function LoadDocSuccesful:boolean; // TRUE ak doklad bol uspesne nacitani
      function ConVerifyOk(pFile:TIniFile;pDocValFld:Str20;pHeadTable:TNexBtrTable):boolean; // TRUE ak potvrdenka je sulade s odoslanym dokaldom
      // Doklad
      procedure SaveDocToFile (pDocNum:Str12;pWriNum,pSndNum:word;pHeadTable,pItemTable,pNotiTable:TNexBtrTable);  // Ulozi zadany doklad do textoveho suboru
      procedure LoadDocFrFile (pArcPath,pFileName:ShortString;pHeadTable,pItemTable,pNotiTable:TNexBtrTable);  // Nacita doklad z textoveho suboru
      // Potvrdenka
      procedure SaveConToFile (pDocNum:Str12;pWriNum:word;pDocValFld:Str20;pHeadTable:TNexBtrTable);  // Ulozi potvrdenku o prijati dokladu
      procedure LoadConFrFile (pArcPath,pFileName:ShortString;pDocValFld:Str20;pHeadTable:TNexBtrTable);  // Nacita potvrdenku o prijati dokladu
      // Zauctovanie
      procedure SaveAccToFile (pHeadTable:TNexBtrTable);  // Ulozi potvrdenku o prijati dokladu
      procedure LoadAccFrFile (pArcPath,pFileName:ShortString;pHeadTable:TNexBtrTable);  // Nacita potvrdenku o prijati dokladu

      // Zaznam
      procedure SndGscToFile (pWriNum:word;pGSCAT,pBARCODE,pGSNOTI:TNexBtrTable);
      procedure LoadGscFrFile (pArcPath,pFileName:ShortString;pGSCAT,pBARCODE,pGSNOTI:TNexBtrTable);  // Nacita doklad z textoveho suboru

      procedure SndPacToFile (pWriNum:word;pPAB:TNexBtrTable);
      procedure LoadPacFrFile (pArcPath,pFileName:ShortString;pPAB:TNexBtrTable);  // Nacita doklad z textoveho suboru

      procedure SaveToSndLst (pRcvDate,pRcvTime:Str10;pRcvStat:byte);
      procedure SaveSndStat (pWriNum:word;pHeadTable:TNexBtrTable); // Zisti stav internetoveho prenosu a ulozi na doklad
    published
      property Count:word read oCount;
      property HeadSdf:ShortString write oHeadSdf;
      property ItemSdf:ShortString write oItemSdf;
      property Command:ShortString write oCommand;
      property SavedFileName:ShortString read oSavedFileName;
  end;

implementation

uses DM_SYSTEM;

{$R *.DFM}

procedure TOitFile.FormCreate(Sender: TObject);
begin
  oHeadSdf := '';
  oItemSdf := '';
  If not DirectoryExists (gPath.BufPath) then ForceDirectories (gPath.BufPath);
end;

procedure TOitFile.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  //
end;

function TOitFile.LoadDocSuccesful:boolean; // TRUE ak doklad bol uspesne nacitani
begin
  Result := oLoadDocSuccesful;
end;

function TOitFile.ConVerifyOk(pFile:TIniFile;pDocValFld:Str20;pHeadTable:TNexBtrTable):boolean; // TRUE ak potvrdenka je sulade s odoslanym dokaldom
begin
  Result := (pFile.ReadString('HEAD','DocDate','')=pHeadTable.FieldByName('DocDate').AsString) and
            (pFile.ReadInteger('HEAD','PaCode',0)=pHeadTable.FieldByName('PaCode').AsInteger) and
             Eq2(pFile.ReadFloat('HEAD','DocVal',0),pHeadTable.FieldByName(pDocValFld).AsFloat) and
            (pFile.ReadInteger('HEAD','ItmQnt',0)=pHeadTable.FieldByName('ItmQnt').AsInteger);
end;

procedure TOitFile.WriteRecData (pRecTable:TNexBtrTable); // Ulozi hlavicku dokladu do textoveho suboru
var mFieldList:TStrings;  mCnt:word;  mFieldName:Str20;
begin
  If FileExists (gPath.DefPath+pRecTable.FixedName+'.SDF') then begin
    mFieldList := TStringList.Create;
    mFieldList.LoadFromFile(gPath.DefPath+pRecTable.FixedName+'.SDF');
    If mFieldList.Count>0 then begin
      mCnt := 0;
      Repeat
        mFieldName := DelSpaces(mFieldList.Strings[mCnt]);
        oTxtRec.WriteString ('RECORD',mFieldName,pRecTable.FieldByName(mFieldName).AsString);
        Inc (mCnt);
      until mCnt=mFieldList.Count;
    end;
    FreeAndNil (mFieldList);
  end
  else ShowMsg (ecSysFileIsNotExist,gPath.DefPath+pRecTable.FixedName+'.SDF');
end;

procedure TOitFile.WriteBarCode (pBARCODE:TNexBtrTable;pGsCode:longint); // Ulozi podkody
var mCnt:word;
begin
  pBARCODE.SwapStatus;
  If pBARCODE.IndexName<>'GsCode' then pBARCODE.IndexName := 'GsCode';
  If pBARCODE.FindKey ([pGsCode]) then begin
    mCnt:= 0;
    Repeat
      Inc (mCnt);
      oTxtRec.WriteString ('BARCODE','BarCode'+StrInt(mCnt,0),pBARCODE.FieldByName('BarCode').AsString);
      pBARCODE.Next;
    until pBARCODE.Eof or (pBARCODE.FieldByName('GsCode').AsInteger<>pGsCode);
    oTxtRec.WriteInteger ('BARCODE','BarCodeQnt',mCnt);
  end;
  pBARCODE.RestoreStatus;
end;

procedure TOitFile.WriteRecNoti (pNotiTable:TNexBtrTable;pRecNum:longint;pRecName:Str20); // Ulozi poznamky do dokladu
var mCnt:word;
begin
  pNotiTable.SwapStatus;
  If pNotiTable.IndexName<>pRecName then pNotiTable.IndexName := pRecName;
  If pNotiTable.FindKey ([pRecNum]) then begin
    mCnt:= 0;
    Repeat
      Inc (mCnt);
      oTxtRec.WriteString ('NOTICE','Notice'+StrInt(mCnt,0),pNotiTable.FieldByName('Notice').AsString);
      pNotiTable.Next;
    until pNotiTable.Eof or (pNotiTable.FieldByName(pRecName).AsInteger<>pRecNum);
    oTxtRec.WriteInteger ('NOTICE','NoticeQnt',mCnt);
  end;
  pNotiTable.RestoreStatus;
end;

procedure TOitFile.WriteDocHead (pSndNum:word;pHeadTable:TNexBtrTable); // Ulozi hlavicku dokladu do textoveho suboru
var mFieldList:TStrings;  mCnt:word;  mFieldName:Str20;  mFieldType:TFieldType;
begin
  If oHeadSdf='' then oHeadSdf := pHeadTable.FixedName+'.SDF';
  If FileExists (gPath.DefPath+oHeadSdf) then begin
    mFieldList := TStringList.Create;
    mFieldList.LoadFromFile(gPath.DefPath+oHeadSdf);
    If mFieldList.Count>0 then begin
      mCnt := 0;
      oTxtDoc.WriteString ('DatType', 'DOC');
      oTxtDoc.WriteInteger ('SndNum', pSndNum);
      oTxtDoc.WriteString ('HeadSdf', oHeadSdf);
      oTxtDoc.WriteString ('ItemSdf', oItemSdf);
      oTxtDoc.WriteString ('Command', oCommand);
      Repeat
        mFieldName := DelSpaces(mFieldList.Strings[mCnt]);
        mFieldType := pHeadTable.FieldByName(mFieldName).DataType;
        If (mFieldType=ftFloat) then begin // Ak je to desatinne cislo konvertujeme vlastnou konvertovacou funckiou - kvoli bodke a ciarke
          If mFieldName='FgCourse'
            then oTxtDoc.WriteString (mFieldName,StrDoub(pHeadTable.FieldByName(mFieldName).AsFloat,0,5))
            else oTxtDoc.WriteString (mFieldName,StrDoub(pHeadTable.FieldByName(mFieldName).AsFloat,0,2));
        end
        else oTxtDoc.WriteString (mFieldName,pHeadTable.FieldByName(mFieldName).AsString);
        Inc (mCnt);
      until mCnt=mFieldList.Count;
    end;
    FreeAndNil (mFieldList);
  end
  else ShowMsg (ecSysFileIsNotExist,gPath.DefPath+oHeadSdf);
end;

procedure TOitFile.WriteDocItem (pItemTable:TNexBtrTable;pDocNum:Str12); // Ulozi polozky do dokladu
var mFieldList:TStrings;  mCnt:word;  mFieldName:Str20;  mFieldType:TFieldType;
begin
  If oItemSdf='' then oItemSdf := pItemTable.FixedName+'.SDF';
  If FileExists (gPath.DefPath+oItemSdf) then begin
    mFieldList := TStringList.Create;
    mFieldList.LoadFromFile(gPath.DefPath+oItemSdf);
    If mFieldList.Count>0 then begin
      If pItemTable.IndexName<>'DocNum' then pItemTable.IndexName :='DocNum';
      If pItemTable.FindKey ([pDocNum]) then begin
        Repeat
          oTxtDoc.Insert;
          mCnt := 0;
          Repeat
            mFieldName := DelSpaces(mFieldList.Strings[mCnt]);
            mFieldType := pItemTable.FieldByName(mFieldName).DataType;
            If (mFieldType=ftFloat)
              then oTxtDoc.WriteFloat (mFieldName,pItemTable.FieldByName(mFieldName).AsFloat)
              else oTxtDoc.WriteString (mFieldName,pItemTable.FieldByName(mFieldName).AsString);
            Inc (mCnt);
          until mCnt=mFieldList.Count;
          oTxtDoc.Post;
          Application.ProcessMessages;
          pItemTable.Next;
        until (pItemTable.Eof) or (pItemTable.FieldByName('DocNum').AsString<>pDocNum);
      end;
    end;
    FreeAndNil (mFieldList);
  end
  else ShowMsg (ecSysFileIsNotExist,gPath.DefPath+pItemTable.FixedName+'.SDF');
end;

procedure TOitFile.WriteDocNoti (pNotiTable:TNexBtrTable;pDocNum:Str12); // Ulozi poznamky do dokladu
begin
end;

procedure TOitFile.SaveDocToFile (pDocNum:Str12;pWriNum,pSndNum:word;pHeadTable,pItemTable,pNotiTable:TNexBtrTable);  // Ulozi zadany doklad do textoveho suboru
var mFileName,mDocFileName,mTmpFileName:ShortString;
begin
  If gIni.GetNewOit then begin
    If not DirectoryExists (gPath.SndPath) then ForceDirectories (gPath.SndPath);
    mFileName := 'D-'+pDocNum+'-'+StrIntZero(pWriNum,3)+'-'+StrIntZero(gvSys.WriNum,3);
    mDocFileName := gPath.SndPath+mFileName+'.TXT';
    mTmpFileName := gPath.SndPath+mFileName+'.TMP';
    oSavedFileName := mFileName+'.TXT';
  end
  else begin
    mFileName := pDocNum+'-'+StrIntZero(pWriNum,3)+'-'+StrIntZero(pSndNum,4);
    mDocFileName := gPath.BufPath+mFileName+'.DOC';
    mTmpFileName := gPath.BufPath+mFileName+'.TMP';
    oSavedFileName := mFileName+'.DOC';
  end;
  oTxtDoc := TTxtDoc.Create;
  oTxtDoc.SetDelimiter ('');
  oTxtDoc.SetSeparator (';');
  If FileExists (mTmpFileName+'') then DeleteFile (mTmpFileName);

  WriteDocHead (pSndNum,pHeadTable); // Ulozi hlavicku dokladu do textoveho suboru
  WriteDocItem (pItemTable,pDocNum); // Ulozi polozky do dokladu
  WriteDocNoti (pNotiTable,pDocNum); // Ulozi poznamky do dokladu

  oTxtDoc.SaveToFile (mTmpFileName);
  If FileExists (mDocFileName) then DeleteFile (mDocFileName);
  RenameFile (mTmpFileName,mDocFileName);
  FreeAndNil (oTxtDoc);
end;

procedure TOitFile.SaveConToFile (pDocNum:Str12;pWriNum:word;pDocValFld:Str20;pHeadTable:TNexBtrTable);  // Ulozi potvrdenku o prijati dokladu
var mFileName,mDocFileName,mTmpFileName:ShortString; mFile:TIniFile;
begin
  mFileName := pDocNum+'-'+StrIntZero(pWriNum,3)+'-'+StrIntZero(pHeadTable.FieldByName('SndNum').AsInteger,4);
  mDocFileName := gPath.BufPath+mFileName+'.CON';
  mTmpFileName := gPath.BufPath+mFileName+'.TMP';
  oSavedFileName := mFileName+'.CON';
  If FileExists (mTmpFileName+'') then DeleteFile (mTmpFileName);
  mFile := TIniFile.Create(mTmpFileName);
  mFile.WriteString ('HEAD','DatType','CON');
  mFile.WriteInteger ('HEAD','WriNum',gvSys.WriNum);

  mFile.WriteInteger ('HEAD','SerNum',pHeadTable.FieldByName('SerNum').AsInteger);
  mFile.WriteString ('HEAD','DocNum',pHeadTable.FieldByName('DocNum').AsString);
  mFile.WriteDate ('HEAD','DocDate',pHeadTable.FieldByName('DocDate').AsDateTime);
  mFile.WriteInteger ('HEAD','PaCode',pHeadTable.FieldByName('PaCode').AsInteger);
  mFile.WriteFloat ('HEAD','DocVal',pHeadTable.FieldByName(pDocValFld).AsFloat);
  mFile.WriteInteger ('HEAD','ItmQnt',pHeadTable.FieldByName('ItmQnt').AsInteger);
  mFile.WriteInteger ('HEAD','SndNum',pHeadTable.FieldByName('SndNum').AsInteger);

  mFile.WriteString ('HEAD','RcvDate',DateToStr(Date));
  mFile.WriteString ('HEAD','RcvTime',TimeToStr(Time));
  FreeAndNil (mFile);
  If FileExists (mDocFileName) then DeleteFile (mDocFileName);
  RenameFile (mTmpFileName,mDocFileName);
end;

procedure TOitFile.LoadDocFrFile (pArcPath,pFileName:ShortString;pHeadTable,pItemTable,pNotiTable:TNexBtrTable);  // Nacita doklad z textoveho suboru
var mFileName:ShortString;
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
    oCommand := oTxtDoc.ReadString('Command');
    LoadTxtToHead(pHeadTable); // Nacita udaje z prenosoveho suboru a vytvori alebo opravy hlavicku prijemky
    If oCommand='UPDATE' then begin
      UpdateItemDat(pItemTable,oTxtDoc.ReadString('ItemSdf'))
    end
    else begin
      DeleteBtrItem(pItemTable); // Vymaze polozky vydajky, ktore nie su v docasnej databaze
      If pHeadTable.FieldByName('ItmQnt').AsInteger>0 then begin  // Ak doklad ma polozky
        ptItem.DefPath := gPath.PrvPath;
        ptItem.DefName := pItemTable.FixedName+'.TDF';
        ptItem.FixName := pItemTable.FixedName;
        ptItem.TableName := pItemTable.FixedName;
        ptItem.Open;
        ptItem.IndexName :='ItmNum';
        LoadTxtToItem; // Nacita poloky z prenosoveho suboru do docasneho suboru poloziek
        AddTmpToItem(pItemTable);  // Prida nove polozky do vydajky
        ptItem.Close;
      end;
    end;
    // Poznamky k dokladu
    FreeAndNil (oTxtDoc);
// moznost zapnut    DeleteFile (mFileName);
  end;
end;

procedure TOitFile.LoadConFrFile (pArcPath,pFileName:ShortString;pDocValFld:Str20;pHeadTable:TNexBtrTable);  // Nacita potvrdenku o prijati dokladu
var mFileName:ShortString; mFile:TIniFile;  mDocNum:Str12;  mWriNum:word;
begin
  mFileName := pArcPath+pFileName;
  If FileExists (mFileName) then begin
    mFile := TIniFile.Create(mFileName);
    mDocNum := mFile.ReadString ('HEAD','DocNum','');
    mWriNum := mFile.ReadInteger ('HEAD','WriNum',0);
    pHeadTable.SwapIndex;
    If pHeadTable.IndexName<>'DocNum' then pHeadTable.IndexName := 'DocNum';
    If pHeadTable.FindKey ([mDocNum]) then begin
      If ConVerifyOk(mFile,pDocValFld,pHeadTable) then begin
        pHeadTable.Edit;
        pHeadTable.FieldByName ('SndStat').AsString := 'O';
        pHeadTable.Post;
        If dmSYS.btSNDLST.FindKey([mDocNum,mFile.ReadInteger('HEAD','WriNum',0),mFile.ReadInteger('HEAD','SndNum',0)]) then SaveToSndLst (mFile.ReadString('HEAD','RcvDate',''),mFile.ReadString('HEAD','RcvTime',''),0); // Prenos bol potvrdeny
      end
      else SaveToSndLst (mFile.ReadString('HEAD','RcvDate',''),mFile.ReadString('HEAD','RcvTime',''),1);  // Kontrolne udaje nie su zhodne
      SaveSndStat(mWriNum,pHeadTable); // Zisti stav internetoveho prenosu a ulozi na doklad
    end;
    pHeadTable.RestoreIndex;
    FreeAndNil (mFile);
    DeleteFile (mFileName);
  end;
end;

procedure TOitFile.SaveAccToFile (pHeadTable:TNexBtrTable);  // Ulozi potvrdenku o prijati dokladu
var mFileName,mDocFileName,mTmpFileName:ShortString; mFile:TIniFile;
begin
  mFileName := pHeadTable.FieldByName('DocNum').AsString+'-'+StrIntZero(pHeadTable.FieldByName('WriNum').AsInteger,3)+'-0000';
  mDocFileName := gPath.BufPath+mFileName+'.ACC';
  mTmpFileName := gPath.BufPath+mFileName+'.TMP';
  oSavedFileName := mFileName+'.ACC';
  If FileExists (mTmpFileName+'') then DeleteFile (mTmpFileName);
  mFile := TIniFile.Create(mTmpFileName);
  mFile.WriteString ('HEAD','DatType','ACC');
  mFile.WriteInteger ('HEAD','WriNum',gvSys.WriNum);
  mFile.WriteString ('HEAD','DocNum',pHeadTable.FieldByName('DocNum').AsString);
  mFile.WriteString ('HEAD','DstAcc',pHeadTable.FieldByName('DstAcc').AsString);
  mFile.WriteString ('HEAD','RcvDate',DateToStr(Date));
  mFile.WriteString ('HEAD','RcvTime',TimeToStr(Time));
  FreeAndNil (mFile);
  If FileExists (mDocFileName) then DeleteFile (mDocFileName);
  RenameFile (mTmpFileName,mDocFileName);
end;

procedure TOitFile.LoadAccFrFile (pArcPath,pFileName:ShortString;pHeadTable:TNexBtrTable);  // Nacita potvrdenku o prijati dokladu
var mFileName:ShortString; mFile:TIniFile;  mDocNum:Str12;
begin
  mFileName := pArcPath+pFileName;
  If FileExists (mFileName) then begin
    mFile := TIniFile.Create(mFileName);
    mDocNum := mFile.ReadString ('HEAD','DocNum','');
    pHeadTable.SwapIndex;
    If pHeadTable.IndexName<>'DocNum' then pHeadTable.IndexName := 'DocNum';
    If pHeadTable.FindKey ([mDocNum]) then begin
      pHeadTable.Edit;
      pHeadTable.FieldByName ('DstAcc').AsString := mFile.ReadString ('HEAD','DstAcc','');
      pHeadTable.Post;
    end;
    pHeadTable.RestoreIndex;
    FreeAndNil (mFile);
    DeleteFile (mFileName);
  end;
end;

procedure TOitFile.SndGscToFile (pWriNum:word;pGSCAT,pBARCODE,pGSNOTI:TNexBtrTable);
var mFileName,mDocFileName,mTmpFileName:ShortString;
begin
  mFileName := 'GSC'+StrIntZero(pGSCAT.FieldByName('GsCode').AsInteger,9)+'-'+StrIntZero(pWriNum,3)+'-0000';
  mDocFileName := gPath.BufPath+mFileName+'.REC';
  mTmpFileName := gPath.BufPath+mFileName+'.TMP';
  oSavedFileName := mFileName+'.REC';
  oTxtRec := TIniFile.Create(mTmpFileName);
  If FileExists (mTmpFileName+'') then DeleteFile (mTmpFileName);
  WriteRecData (pGSCAT); // Ulozi hlavicku dokladu do textoveho suboru
  WriteBarCode (pBARCODE,pGSCAT.FieldByName('GsCode').AsInteger); // Ulozi podkody
  WriteRecNoti (pGSNOTI,pGSCAT.FieldByName('GsCode').AsInteger,'GsCode'); // Ulozi poznamky do dokladu
  FreeAndNil (oTxtRec);
  If FileExists (mDocFileName) then DeleteFile (mDocFileName);
  RenameFile (mTmpFileName,mDocFileName);
end;

procedure TOitFile.LoadGscFrFile (pArcPath,pFileName:ShortString;pGSCAT,pBARCODE,pGSNOTI:TNexBtrTable);  // Nacita doklad z textoveho suboru
var mFileName:ShortString; mFile:TIniFile;  mFieldList:TStrings;
    mGsCode:longint;  mFieldName:Str20;  mCnt:byte; mSbcCnt:word;
begin
  If FileExists (gPath.DefPath+pGSCAT.FixedName+'.SDF') then begin
    mFieldList := TStringList.Create;
    mFieldList.LoadFromFile(gPath.DefPath+pGSCAT.FixedName+'.SDF');
    If mFieldList.Count>0 then begin
      mFileName := pArcPath+pFileName;
      If FileExists (mFileName) then begin
        mFile := TIniFile.Create(mFileName);
        mGsCode := mFile.ReadInteger ('RECORD','GsCode',0);
        mSbcCnt := mFile.ReadInteger ('BARCODE','BarCodeQnt',0);
        If (mGsCode>0) then begin
          If pGSCAT.FindKey([mGsCode])
            then pGSCAT.Edit     // Uprava karty
            else pGSCAT.Insert;  // Nova karta
          // Vlozime poliad databazoveho suboru
          mCnt := 0;
          Repeat
            mFieldName := DelSpaces(mFieldList.Strings[mCnt]);
            If mFile.ValueExists('RECORD',mFieldName) then begin
              pGSCAT.FieldByName(mFieldName).AsString := mFile.ReadString('RECORD',mFieldName,'');
            end;
            Inc (mCnt);
          until mCnt=mFieldList.Count;
          pGSCAT.FieldByName('SbcCnt').AsInteger := mSbcCnt;
          pGSCAT.Post;
          // Vymzae podkody na zadane PLU
          If pBARCODE.IndexName<>'GsCode' then pBARCODE.IndexName:='GsCode';
          While pBARCODE.FindKey([mGsCode]) do
            pBARCODE.Delete;
          // Ulozime druhotne identifikacne kody
          If mSbcCnt>0 then begin
            mCnt := 0;
            Repeat
              Inc (mCnt);
              mFieldName := 'BarCode'+StrInt(mCnt,0);
              If mFile.ValueExists('BARCODE',mFieldName) then begin
                pBARCODE.Insert;
                pBARCODE.FieldByName('GsCode').AsInteger := mGsCode;
                pBARCODE.FieldByName('BarCode').AsString := mFile.ReadString('BARCODE',mFieldName,'');
                pBARCODE.Post;
              end;
            until mCnt=mSbcCnt;
          end;
        end;
        FreeAndNil (mFile);
        DeleteFile (mFileName);
      end;
    end;
    FreeAndNil (mFieldList);
  end
  else ShowMsg (ecSysFileIsNotExist,gPath.DefPath+pGSCAT.FixedName+'.SDF');
end;

procedure TOitFile.LoadPacFrFile (pArcPath,pFileName:ShortString;pPAB:TNexBtrTable);  // Nacita doklad z textoveho suboru
var mFileName:ShortString; mFile:TIniFile;  mFieldList:TStrings;
    mPaCode:longint;  mFieldName:Str20;  mCnt:byte;
begin
  If FileExists (gPath.DefPath+pPAB.FixedName+'.SDF') then begin
    mFieldList := TStringList.Create;
    mFieldList.LoadFromFile(gPath.DefPath+pPAB.FixedName+'.SDF');
    If mFieldList.Count>0 then begin
      mFileName := pArcPath+pFileName;
      If FileExists (mFileName) then begin
        mFile := TIniFile.Create(mFileName);
        mPaCode := mFile.ReadInteger ('RECORD','PaCode',0);
        If (mPaCode>0) then begin
          If pPAB.FindKey([mPaCode])
            then pPAB.Edit     // Uprava karty
            else pPAB.Insert;  // Nova karta
          // Vlozime poliad databazoveho suboru
          mCnt := 0;
          Repeat
            mFieldName := DelSpaces(mFieldList.Strings[mCnt]);
            If mFile.ValueExists('RECORD',mFieldName) then begin
              pPAB.FieldByName(mFieldName).AsString := mFile.ReadString('RECORD',mFieldName,'');
            end;
            Inc (mCnt);
          until mCnt=mFieldList.Count;
          pPAB.Post;
        end;
        FreeAndNil (mFile);
        DeleteFile (mFileName);
      end;
    end;
    FreeAndNil (mFieldList);
  end
  else ShowMsg (ecSysFileIsNotExist,gPath.DefPath+pPAB.FixedName+'.SDF');
end;

procedure TOitFile.SndPacToFile (pWriNum:word;pPAB:TNexBtrTable);
var mFileName,mDocFileName,mTmpFileName:ShortString;
begin
  mFileName := 'PAC'+StrIntZero(pPAB.FieldByName('PaCode').AsInteger,9)+'-'+StrIntZero(pWriNum,3)+'-0000';
  mDocFileName := gPath.BufPath+mFileName+'.REC';
  mTmpFileName := gPath.BufPath+mFileName+'.TMP';
  oSavedFileName := mFileName+'.REC';
  oTxtRec := TIniFile.Create(mTmpFileName);
  If FileExists (mTmpFileName+'') then DeleteFile (mTmpFileName);
  WriteRecData (pPAB); // Ulozi hlavicku dokladu do textoveho suboru
  FreeAndNil (oTxtRec);
  If FileExists (mDocFileName) then DeleteFile (mDocFileName);
  RenameFile (mTmpFileName,mDocFileName);
end;

procedure TOitFile.SaveToSndLst (pRcvDate,pRcvTime:Str10;pRcvStat:byte);
begin
  dmSYS.btSNDLST.Edit;
  dmSYS.btSNDLST.FieldByName ('RcvDate').AsString := pRcvDate;
  dmSYS.btSNDLST.FieldByName ('RcvTime').AsString := pRcvTime;
  dmSYS.btSNDLST.FieldByName ('RcvStat').AsInteger := pRcvStat;
  dmSYS.btSNDLST.Post;
end;

procedure TOitFile.SaveSndStat(pWriNum:word;pHeadTable:TNexBtrTable); // Zisti stav internetoveho prenosu a ulozi na doklad
var mNotCon,mSndErr:byte;
begin
  dmSYS.btSNDLST.FindNearest ([pHeadTable.FieldByName('DocNum').AsString,pWriNum]);
  If (dmSYS.btSNDLST.FieldByName('DatNum').AsString=pHeadTable.FieldByName('DocNum').AsString) and (dmSYS.btSNDLST.FieldByName('WriNum').AsInteger=pWriNum) then begin
    mNotCon := 0;  mSndErr := 0;
    Repeat
      If dmSYS.btSNDLST.FieldByName('RcvStat').AsInteger=0 then Inc (mNotCon);
      If dmSYS.btSNDLST.FieldByName('RcvStat').AsInteger=9 then Inc (mSndErr);
      Application.ProcessMessages;
      dmSYS.btSNDLST.Next;
    until dmSYS.btSNDLST.Eof or (dmSYS.btSNDLST.FieldByName('DatNum').AsString<>pHeadTable.FieldByName('DocNum').AsString) and (dmSYS.btSNDLST.FieldByName('WriNum').AsInteger<>pWriNum);
    pHeadTable.Modify := FALSE;
    pHeadTable.Edit;
    If mNotCon=0 then pHeadTable.FieldByName('SndStat').AsString := 'O';
    If mSndErr>0 then pHeadTable.FieldByName('SndStat').AsString := 'E';
    pHeadTable.Post;
    pHeadTable.Modify := TRUE;
  end;
end;

procedure TOitFile.LoadTxtToHead(pHeadTable:TNexBtrTable); // Nacita udaje z prenosoveho suboru a vytvori alebo opravy hlavicku dodacieho listu
var mFieldList:TStrings;  mCnt:word;  mFieldName:Str20;
begin
  If FileExists (gPath.DefPath+pHeadTable.FixedName+'.SDF') then begin
    mFieldList := TStringList.Create;
    mFieldList.LoadFromFile(gPath.DefPath+pHeadTable.FixedName+'.SDF');
    If mFieldList.Count>0 then begin
      If pHeadTable.IndexName<>'DocNum' then pHeadTable.IndexName:='DocNum';
      If pHeadTable.FindKey ([oDocNum])
        then pHeadTable.Edit     // Uprava hlavicky dokladu
        else pHeadTable.Insert;  // Novy doklad
      // Vlozime poliad databazoveho suboru
      mCnt := 0;
      Repeat
        mFieldName := DelSpaces(mFieldList.Strings[mCnt]);
        If oTxtDoc.FieldNameExist(mFieldName) then begin
          pHeadTable.FieldByName(mFieldName).AsString := oTxtDoc.ReadString(mFieldName);
        end;
        Inc (mCnt);
      until mCnt=mFieldList.Count;
      If oCommand='NST' then pHeadTable.FieldByName('DstLck').AsInteger := 0;
      pHeadTable.Post;
    end;
    FreeAndNil (mFieldList);
  end
  else ShowMsg (ecSysFileIsNotExist,gPath.DefPath+pHeadTable.FixedName+'.SDF');
end;

procedure TOitFile.LoadTxtToItem; // Nacita poloky z prenosoveho suboru do docasneh databaze ptUDI
var mFieldList:TStrings;  mCnt:word;  mFieldName:Str20;
begin
  If oTxtDoc.ItemCount>0 then begin
    If FileExists (gPath.DefPath+ptItem.FixName+'.SDF') then begin
      mFieldList := TStringList.Create;
      mFieldList.LoadFromFile(gPath.DefPath+ptItem.FixName+'.SDF');
      If mFieldList.Count>0 then begin
        ptItem.IndexName := 'ItmNum';
        oTxtDoc.First;
        Repeat
          If not ptItem.FindKey ([oTxtDoc.ReadInteger ('ItmNum')]) then begin
            ptItem.Insert;
            ptItem.FieldByName('DocNum').AsString := oDocNum;
            // Ulozime pilia databazoveho suboru
            mCnt := 0;
            Repeat
              mFieldName := DelSpaces(mFieldList.Strings[mCnt]);
              ptItem.FieldByName (mFieldName).AsString := oTxtDoc.ReadString(mFieldName);
              Inc (mCnt);
            until mCnt=mFieldList.Count;
            If oCommand='NST' then begin  // Ak je pokyn je k zmene StkStat=N
              ptItem.FieldByName ('StkStat').AsString := 'N';
            end;
            ptItem.Post;
          end;
          Application.ProcessMessages;
          oTxtDoc.Next;
        until oTxtDoc.Eof;
      end;
      FreeAndNil (mFieldList);
    end
    else ShowMsg (ecSysFileIsNotExist,gPath.DefPath+ptItem.TableName+'.SDF');
  end;
end;

procedure TOitFile.UpdateItemDat(pItemTable:TNexBtrTable;pSdfFile:ShortString); // Vlozi do polozky len prenesene udaje
var mFieldList:TStrings;  mCnt:word;  mFieldName:Str20;
begin
  If oTxtDoc.ItemCount>0 then begin
    If FileExists (gPath.DefPath+pSdfFile) then begin
      mFieldList := TStringList.Create;
      mFieldList.LoadFromFile(gPath.DefPath+pSdfFile);
      If mFieldList.Count>0 then begin
        pItemTable.IndexName := 'DoIt';
        oTxtDoc.First;
        Repeat
          If pItemTable.FindKey ([oTxtDoc.ReadString('DocNum'),oTxtDoc.ReadInteger('ItmNum')]) then begin
            pItemTable.Edit;
            mCnt := 0;
            Repeat
              mFieldName := DelSpaces(mFieldList.Strings[mCnt]);
              pItemTable.FieldByName (mFieldName).AsString := oTxtDoc.ReadString(mFieldName);
              Inc (mCnt);
            until mCnt=mFieldList.Count;
            pItemTable.Post;
          end;
          Application.ProcessMessages;
          oTxtDoc.Next;
        until oTxtDoc.Eof;
      end;
      FreeAndNil (mFieldList);
    end
    else ShowMsg (ecSysFileIsNotExist,gPath.DefPath+pSdfFile);
  end;
end;

procedure TOitFile.DeleteBtrItem(pItemTable:TNexBtrTable); // Vymaze polozky doacieho listu, ktore nie su v docasnej databaze
begin
  If pItemTable.IndexName<>'DocNum' then pItemTable.IndexName:='DocNum';
  If pItemTable.FindKey ([oDocNum]) then begin
    Repeat
      Application.ProcessMessages;
      If oCommand='NST' then begin  // Ak je pokyn je k zmene StkStat=N
        If pItemTable.FindField('StkStat')<>nil then begin
          If pItemTable.FindField('StkStat').AsString='N' then pItemTable.Delete;
        end;
      end
      else pItemTable.Delete;
    until (pItemTable.Eof) or (pItemTable.RecordCount=0) or (pItemTable.FieldByName('DocNum').AsString<>oDocNum);
  end;
end;

procedure TOitFile.AddTmpToItem(pItemTable:TNexBtrTable); // Prida nove polozky do dodacieho listu
begin
  pItemTable.Modify := FALSE;
  pItemTable.IndexName:='DoIt';
  ptItem.First;
  Repeat
    If not pItemTable.FindKey ([oDocNum,ptItem.FieldByName('ItmNum').AsInteger]) then begin
      pItemTable.Insert;
      PX_To_BTR (ptItem,pItemTable);
      pItemTable.FieldByName ('DocNum').AsString := oDocNum;
      pItemTable.Post;
    end;
    ptItem.Next;
    Application.ProcessMessages;
  until (ptItem.Eof);
  pItemTable.Modify := TRUE;
end;

end.
