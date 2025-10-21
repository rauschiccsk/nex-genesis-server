unit OipSnd;

interface

uses
  IcTypes, IcTools, IcConv, IcVariab, NexPath, NexMsg, NexError, NexGlob,
  DocHead, DocItem, TxtCut, ParHand,
  IniFiles, StdCtrls, Forms, Classes, SysUtils, NexBtrTable, NexPxTable, DB;

type
  TOipSnd = class
    constructor Create;
    destructor Destroy; override;
  private
    oSucces: boolean; // TRUE ak operacia bola vykonana uspesne
    oDocNum: Str12; // Cislo dokladu ktorym pracujeme
    oDocTxt: TStrings; // Cely dokument
    oHeadSdf: Str12; // Definicny subor prenosu hlavickovych udjaov
    oItemSdf: Str12; // Definicny subor prenosu poloziek dokladu
    oCommand: ShortString; // Pokyn k specialnemu spracovaniu suboru
    oFileName: ShortString; // Nazov odoslaneho suboru
    function FilterEqual (pFilter:ShortString; pTable:TNexBtrTable):boolean;  // TRUA ak zaznam zo zadanej dtabaze zhoduje so zadanym filtrom
    procedure WriteRecHead (pHeadTable:TNexBtrTable; pCommand,pAddFile:ShortString); // Ulozi udaje skladovej karty
    procedure WriteRecItem (pItemTable:TNexBtrTable;pCode:longint;pCodeField,pFilter:ShortString); // Ulozi udaje tovarovych pohybov
    procedure WriteLstItem (pItemTable:TNexBtrTable;pCodeList:TStrings;pCodeField,pFilter:ShortString); // Ulozi udaje tovarovych pohybov
    procedure WriteDocItem (pItemTable:TNexBtrTable;pDocNum:Str12;pFieldName:ShortString); // Ulozi udaje poloziek dokladu
  public
    procedure SaveToStcFile (pSTK,pSTM,pFIF,pSTO,pSTP:TNexBtrTable; pStkNum,pWriNum:word;pCommand,pHeadSdf,pAddFile:ShortString);
    procedure SaveToStlFile (pSTK,pSTM,pFIF,pSTO,pSTP:TNexBtrTable; pStkNum,pWriNum:word;pCommand,pHeadSdf,pAddFile:ShortString;pInfoLine:TLabel);
    procedure SaveToGscFile (pGSCAT,pGSNOTI,pBARCODE:TNexBtrTable; pWriNum:word);
    procedure SaveToPacFile (pPAB,pPABACC,pPACNTC,pPASUBC,pPANOTI:TNexBtrTable; pWriNum,pBookNum:word);
    procedure SaveToPlcFile (pPLS,pPLH:TNexBtrTable; pWriNum,pPlsNum:word);
    procedure SaveToWgiFile (pWGI:TNexBtrTable; pWriNum,pSection:word);
    procedure SaveToScsFile (pFGPALST,pFGPADSC:TNexBtrTable; pWriNum:word);

    procedure SaveToBkpFile (pBookId:Str3; pTable:TNexBtrTable; pWriNum:word);
    procedure SaveToDocFile (pHeadTable,pItemTable,pAdviTable,pNotiTable:TNexBtrTable; pWriNum:word; pCommand:ShortString);
    procedure SaveToConFile (pHeadTable:TNexBtrTable; pWriNum:Str3);
    procedure SaveToPmdFile (pPMI:TNexBtrTable; pDocNum:Str12; pWriNum:word);
    procedure SaveToAccFile (pJOURNAL:TNexBtrTable; pDocNum:Str12; pWriNum:word);
  published
    property FileName:ShortString read oFileName;
    property HeadSdf:Str12 write oHeadSdf;
    property ItemSdf:Str12 write oItemSdf;
  end;

implementation

uses BtrTable;

constructor TOipSnd.Create;
begin
  oFileName := '';   oHeadSdf := '';   oItemSdf := '';
  If not DirectoryExists (gPath.SndPath) then ForceDirectories (gPath.SndPath);
  oDocTxt := TStringList.Create; // Cely dokument
end;

destructor TOipSnd.Destroy;
begin
  FreeAndNil (oDocTxt);
end;

// ************************* PRIVATE METHODS *************************

function TOipSnd.FilterEqual (pFilter:ShortString; pTable:TNexBtrTable):boolean;  // TRUA ak zaznam zo zadanej dtabaze zhoduje so zadanym filtrom
var  mFiltFld,mFiltVal,mFieldName:ShortString;  I:word;
begin
  Result := TRUE;
  If pFilter<>'' then begin
    Result := FALSE;
    mFiltFld := LineElement (pFilter,0,'=');
    mFiltVal := LineElement (pFilter,1,'=');
    For I:=0 to pTable.FieldCount-1 do begin
      try
        mFieldName := pTable.Fields[I].FieldName;
        If mFiltFld=mFieldName then begin
          Result := pTable.FieldByName(mFieldName).AsString=mFiltVal;
        end;
      except end;
    end;
  end;
end;

procedure TOipSnd.WriteRecHead (pHeadTable:TNexBtrTable; pCommand,pAddFile:ShortString); // Ulozi udaje skladovej karty
var mCount,I:word;  mHeadFld,mElement,mFieldName:ShortString;
    mFieldType:TFieldType;  mHead:TDocHead; mFieldList:TStrings;
begin
  mHead := TDocHead.Create;
  mHead.WriteString ('Command',pCommand);
  mHead.WriteString ('AddFile',pAddFile);
  If pHeadTable<>nil then begin
    mFieldList := TStringList.Create;
    mFieldList.Clear;
    If oHeadSdf='' then begin // Ak nie je zadany zoznam poli posielame vsetku polia databaze
      For I:=0 to pHeadTable.FieldCount-1 do
        mFieldList.Add (pHeadTable.Fields[I].FieldName);
    end
    else begin  // Nacitame definicny subor prenosu *.SDF
      If FileExists (gPath.DefPath+oHeadSdf)
        then mFieldList.LoadFromFile(gPath.DefPath+oHeadSdf)
        else ShowMsg (ecSysFileIsNotExist,gPath.DefPath+oHeadSdf);
    end;
    // Ulozime udaje jednotlivych poli do suboru
    For I:=0 to mFieldList.Count-1 do begin
      try
        mFieldName := mFieldList.Strings[I];
        If pHeadTable.FindField(mFieldName)<> nil then begin
          mFieldType := pHeadTable.FieldByName(mFieldName).DataType;
          case mFieldType of
            ftFloat: mHead.WriteFloat (mFieldName,pHeadTable.FieldByName(mFieldName).AsFloat);
             ftDate: mHead.WriteDate (mFieldName,pHeadTable.FieldByName(mFieldName).AsDateTime);
               else  mHead.WriteString (mFieldName,pHeadTable.FieldByName(mFieldName).AsString);
          end;
        end;
      except end;
    end;
    FreeAndNil (mFieldList);
  end;
  oDocTxt.Add ('[HEAD]');
  oDocTxt.AddStrings (mHead.HeadFile);
  FreeAndNil (mHead);
end;

procedure TOipSnd.WriteRecItem (pItemTable:TNexBtrTable;pCode:longint;pCodeField,pFilter:ShortString); // Ulozi udaje skladovych pohybov
var I:word;  mFieldType:TFieldType;  mItems:TDocItem;  mFieldName:ShortString;
begin
  pItemTable.SwapStatus;
  If pItemTable.FindKey([pCode]) then begin
    mItems := TDocItem.Create;
    Repeat
      If FilterEqual (pFilter,pItemTable) then begin
        mItems.Insert;
        For I:=0 to pItemTable.FieldCount-1 do begin
          try
            mFieldName := pItemTable.Fields[I].FieldName;
            mFieldType := pItemTable.FieldByName(mFieldName).DataType;
            case mFieldType of
              ftFloat: mItems.WriteFloat (mFieldName,pItemTable.FieldByName(mFieldName).AsFloat);
               ftDate: mItems.WriteDate (mFieldName,pItemTable.FieldByName(mFieldName).AsDateTime);
                 else  mItems.WriteString (mFieldName,pItemTable.FieldByName(mFieldName).AsString);
            end;
          except end;
        end;
        mItems.Post;
      end;
      Application.ProcessMessages;
      pItemTable.Next;
    until pItemTable.Eof or (pItemTable.FieldByname(pCodeField).AsInteger<>pCode);
    pItemTable.RestoreStatus;
    If mItems.Count>0 then begin
      oDocTxt.Add ('');
      oDocTxt.Add ('[FLDLST-'+ pItemTable.FixedName+']');
      oDocTxt.AddStrings (mItems.FldLst);
      oDocTxt.Add ('[ITMLST-'+pItemTable.FixedName+']');
      oDocTxt.AddStrings (mItems.ItmLst);
    end;  
    FreeAndNil (mItems);
  end;
end;

procedure TOipSnd.WriteLstItem (pItemTable:TNexBtrTable;pCodeList:TStrings;pCodeField,pFilter:ShortString); // Ulozi udaje skladovych pohybov
var I:word;  mFieldType:TFieldType;  mItems:TDocItem;  mFieldName:ShortString;  mCode,mCnt:longint;
begin
  If pCodeList.Count>0 then begin
    If pItemTable.IndexName<>pCodeField then pItemTable.IndexName := pCodeField;
    mItems := TDocItem.Create;
    mCnt := 0; // Pocitadlo zadanych kodov
    Repeat
      mCode := ValInt(pCodeList.Strings[mCnt]);
      If pItemTable.FindKey([mCode]) then begin
        Repeat
          If FilterEqual (pFilter,pItemTable) then begin
            mItems.Insert;
            For I:=0 to pItemTable.FieldCount-1 do begin
              try
                mFieldName := pItemTable.Fields[I].FieldName;
                mFieldType := pItemTable.FieldByName(mFieldName).DataType;
                case mFieldType of
                  ftFloat: mItems.WriteFloat (mFieldName,pItemTable.FieldByName(mFieldName).AsFloat);
                   ftDate: mItems.WriteDate (mFieldName,pItemTable.FieldByName(mFieldName).AsDateTime);
                     else  mItems.WriteString (mFieldName,pItemTable.FieldByName(mFieldName).AsString);
                end;
              except end;
            end;
            mItems.Post;
          end;
          Application.ProcessMessages;
          pItemTable.Next;
        until pItemTable.Eof or (pItemTable.FieldByname(pCodeField).AsInteger<>mCode);
      end;
      Application.ProcessMessages;
      Inc (mCnt);
    until mCnt>=pCodeList.Count;
    If mItems.Count>0 then begin
      oDocTxt.Add ('');
      oDocTxt.Add ('[FLDLST-'+ pItemTable.FixedName+']');
      oDocTxt.AddStrings (mItems.FldLst);
      oDocTxt.Add ('[ITMLST-'+pItemTable.FixedName+']');
      oDocTxt.AddStrings (mItems.ItmLst);
    end;  
    FreeAndNil (mItems);
  end;
end;

procedure TOipSnd.WriteDocItem (pItemTable:TNexBtrTable;pDocNum:Str12;pFieldName:ShortString); // Ulozi udaje poloziek dokladu
var I:word;  mFieldName:Str20;  mFieldType:TFieldType;  mItems:TDocItem;
    mFieldList:TStrings;
begin
  If pItemTable<>nil then begin
    mFieldList := TStringList.Create;
    mFieldList.Clear;
    If oItemSdf='' then begin // Ak nie je zadany zoznam poli posielame vsetku polia databaze
      For I:=0 to pItemTable.FieldCount-1 do
        mFieldList.Add (pItemTable.Fields[I].FieldName);
    end
    else begin  // Nacitame definicny subor prenosu *.SDF
      If FileExists (gPath.DefPath+oItemSdf)
        then mFieldList.LoadFromFile(gPath.DefPath+oItemSdf)
        else ShowMsg (ecSysFileIsNotExist,gPath.DefPath+oItemSdf);
    end;
    // Ulozime udaje jednotlivych poli do suboru
    If pItemTable.IndexName<>pFieldName then pItemTable.IndexName:=pFieldName;
    If pItemTable.FindKey([pDocNum]) then begin
      mItems := TDocItem.Create;
      Repeat
        mItems.Insert;
        For I:=0 to mFieldList.Count-1 do begin
          try
            mFieldName := mFieldList.Strings[I];
            If pItemTable.FindField(mFieldName)<> nil then begin
              mFieldType := pItemTable.FieldByName(mFieldName).DataType;
              case mFieldType of
                ftFloat: mItems.WriteFloat (mFieldName,pItemTable.FieldByName(mFieldName).AsFloat);
                 ftDate: mItems.WriteDate (mFieldName,pItemTable.FieldByName(mFieldName).AsDateTime);
                   else  mItems.WriteString (mFieldName,pItemTable.FieldByName(mFieldName).AsString);
              end;
            end;
          except end;
        end;
        mItems.Post;
        Application.ProcessMessages;
        pItemTable.Next;
      until pItemTable.Eof or (pItemTable.FieldByname(pFieldName).AsString<>pDocNum);
      If mItems.Count>0 then begin
        oDocTxt.Add ('');
        oDocTxt.Add ('[FLDLST-'+ pItemTable.FixedName+']');
        oDocTxt.AddStrings (mItems.FldLst);
        oDocTxt.Add ('[ITMLST-'+pItemTable.FixedName+']');
        oDocTxt.AddStrings (mItems.ItmLst);
      end;  
      FreeAndNil (mItems);
    end;
    FreeAndNil (mFieldList);
  end;  
end;

// ************************* PUBLIC METHODS *************************

procedure TOipSnd.SaveToStcFile (pSTK,pSTM,pFIF,pSTO,pSTP:TNexBtrTable; pStkNum,pWriNum:word;pCommand,pHeadSdf,pAddFile:ShortString);
var mFileName,mTmpFileName:ShortString;  mGsCode:longint;  mParHand:TParHand;
begin
  // Ulozime udaje karty do suboru
  mGsCode := pSTK.FieldByName('GsCode').AsInteger;
  mFileName := 'R-ST'+StrIntZero(pStkNum,4)+StrIntZero(mGsCode,6)+'-'+StrIntZero(pWriNum,3)+'-'+StrIntZero(gvSys.WriNum,3);
  mTmpFileName := gPath.SndPath+mFileName+'.TMP';
  oFileName := mFileName+'.TXT';
  oDocTxt.Clear;
  If FileExists (mTmpFileName+'') then DeleteFile (mTmpFileName);

  // Zistime ci na skladovu kartu nie je definovany specilany prenos
  oHeadSdf := pHeadSdf;
  WriteRecHead (pSTK,pCommand,pAddFile); // Ulozi udaje skladovej karty
  If (pAddFile='') then begin // Posielame vsetky prilohy
    WriteRecItem (pSTM,mGsCode,'GsCode',''); // Ulozi udaje skladovych pohybov
    WriteRecItem (pFIF,mGsCode,'GsCode',''); // Ulozi udaje FIFO kariet
    WriteRecItem (pSTO,mGsCode,'GsCode',''); // Ulozi udaje objednavky a rezervacie
    WriteRecItem (pSTP,mGsCode,'GsCode',''); // Ulozi udaje objednavky a rezervacie
  end
  else begin
    mParHand := TParHand.Create;
    mParHand.Line := pAddFile;
    If mParHand.ParExist('STM') then WriteRecItem (pSTM,mGsCode,'GsCode',mParHand.ParValue('STM')); // Ulozi udaje skladovych pohybov
    If mParHand.ParExist('FIF') then WriteRecItem (pFIF,mGsCode,'GsCode',mParHand.ParValue('FIF')); // Ulozi udaje FIFO kariet
    If mParHand.ParExist('STO') then WriteRecItem (pSTO,mGsCode,'GsCode',mParHand.ParValue('STO')); // Ulozi udaje objednavky a rezervacie
    If mParHand.ParExist('STP') then WriteRecItem (pSTP,mGsCode,'GsCode',mParHand.ParValue('STK')); // Ulozi udaje objednavky a rezervacie
    FreeAndNil (mParHand);
  end;
  // Ulozime udaje do TMP suboru
  If FileExists (mTmpFileName) then DeleteFile (mTmpFileName);
  oDocTxt.SaveToFile (mTmpFileName);
  // Premenujeme TMP subor na TXT
  If FileExists (gPath.SndPath+oFileName) then DeleteFile (gPath.SndPath+oFileName);
  RenameFile (mTmpFileName,gPath.SndPath+oFileName);
end;

procedure TOipSnd.SaveToStlFile (pSTK,pSTM,pFIF,pSTO,pSTP:TNexBtrTable; pStkNum,pWriNum:word;pCommand,pHeadSdf,pAddFile:ShortString;pInfoLine:TLabel);
var mFileName,mTmpFileName:ShortString;  mParHand:TParHand;  mCodeList:TStrings;  mSndNum:word;
begin
  oDocTxt.Clear;
  // Ulozime udaje do suboru
  pInfoLine.Visible := TRUE;
  pInfoLine.Caption := 'Zber zmenených skladových kariet';
  mCodeList := TStringList.Create;
  mCodeList.Clear;
  While pSTK.FindKey([0]) do begin  // Pokial najdeme karty na odoslanie posielame ich
    mCodeList.Add (pSTK.fieldByName('GsCode').AsString);
    pSTK.Edit;
    pSTK.FieldByName ('Sended').AsInteger := 1;
    pSTK.Post;
  end;
  If mCodeList.Count>0 then begin
    mSndNum := 0;
    Repeat
      Inc (mSndNum);
      mFileName := 'L-ST'+StrIntZero(pStkNum,4)+StrIntZero(mSndNum,6)+'-'+StrIntZero(pWriNum,3)+'-'+StrIntZero(gvSys.WriNum,3);
      mTmpFileName := gPath.SndPath+mFileName+'.TMP';
      oFileName := mFileName+'.TXT';
    until not FileExists (gPath.SndPath+oFileName+'');
    If FileExists (mTmpFileName+'') then DeleteFile (mTmpFileName);
    // Zistime ci na skladovu kartu nie je definovany specilany prenos
    oHeadSdf := pHeadSdf;
    pInfoLine.Caption := 'Zápis skladových kariet';
    WriteRecHead (nil,pCommand,pAddFile); // Ulozi udaje skladovej karty
    WriteLstItem (pSTK,mCodeList,'GsCode',''); // Ulozi udaje skladovych kariet
    If (pAddFile='') then begin // Posielame vsetky prilohy
      pInfoLine.Caption := 'Zápis skladových pohybov';
      WriteLstItem (pSTM,mCodeList,'GsCode',''); // Ulozi udaje skladovych pohybov
      pInfoLine.Caption := 'Zápis FIFO kariet';
      WriteLstItem (pFIF,mCodeList,'GsCode',''); // Ulozi udaje FIFO kariet
      pInfoLine.Caption := 'Zápis rezervacií a objednávok';
      WriteLstItem (pSTO,mCodeList,'GsCode',''); // Ulozi udaje objednavky a rezervacie
      pInfoLine.Caption := 'Zápis výrobných èísiel';
      WriteLstItem (pSTP,mCodeList,'GsCode',''); // Ulozi udaje objednavky a rezervacie
    end
    else begin
      mParHand := TParHand.Create;
      mParHand.Line := pAddFile;
      pInfoLine.Caption := 'Zápis skladových pohybov';
      If mParHand.ParExist('STM') then WriteLstItem (pSTM,mCodeList,'GsCode',mParHand.ParValue('STM')); // Ulozi udaje skladovych pohybov
      pInfoLine.Caption := 'Zápis FIFO kariet';
      If mParHand.ParExist('FIF') then WriteLstItem (pFIF,mCodeList,'GsCode',mParHand.ParValue('FIF')); // Ulozi udaje FIFO kariet
      pInfoLine.Caption := 'Zápis rezervacií a objednávok';
      If mParHand.ParExist('STO') then WriteLstItem (pSTO,mCodeList,'GsCode',mParHand.ParValue('STO')); // Ulozi udaje objednavky a rezervacie
      pInfoLine.Caption := 'Zápis výrobných èísiel';
      If mParHand.ParExist('STP') then WriteLstItem (pSTP,mCodeList,'GsCode',mParHand.ParValue('STK')); // Ulozi udaje objednavky a rezervacie
      FreeAndNil (mParHand);
    end;
    // Ulozime udaje do TMP suboru
    If FileExists (mTmpFileName) then DeleteFile (mTmpFileName);
    oDocTxt.SaveToFile (mTmpFileName);
    // Premenujeme TMP subor na TXT
    If FileExists (gPath.SndPath+oFileName) then DeleteFile (gPath.SndPath+oFileName);
    RenameFile (mTmpFileName,gPath.SndPath+oFileName);
  end;
  FreeAndNil (mCodeList);
  pInfoLine.Visible := FALSE;
end;

procedure TOipSnd.SaveToGscFile (pGSCAT,pGSNOTI,pBARCODE:TNexBtrTable; pWriNum:word);
var mFileName,mTmpFileName:ShortString;  mGsCode:longint;
begin
  // Ulozime udaje tovarovej karty do suboru
  mGsCode := pGSCAT.FieldByName('GsCode').AsInteger;
  mFileName := 'R-GS'+StrIntZero(mGsCode,10)+'-'+StrIntZero(pWriNum,3)+'-'+StrIntZero(gvSys.WriNum,3);
  mTmpFileName := gPath.SndPath+mFileName+'.TMP';
  oFileName := mFileName+'.TXT';
  oDocTxt.Clear;
  If FileExists (mTmpFileName+'') then DeleteFile (mTmpFileName);

  WriteRecHead (pGSCAT,'',''); // Ulozi udaje skladovej karty
  WriteRecItem (pGSNOTI,mGsCode,'GsCode','');  // Ulozi poznamky k tovarovej karte
  WriteRecItem (pBARCODE,mGsCode,'GsCode',''); // Ulozi podkody k tovarovej karte

  // Ulozime udaje do TMP suboru
  If FileExists (mTmpFileName) then DeleteFile (mTmpFileName);
  oDocTxt.SaveToFile (mTmpFileName);
  // Premenujeme TMP subor na TXT
  If FileExists (gPath.SndPath+oFileName) then DeleteFile (gPath.SndPath+oFileName);
  RenameFile (mTmpFileName,gPath.SndPath+oFileName);
end;

procedure TOipSnd.SaveToPacFile (pPAB,pPABACC,pPACNTC,pPASUBC,pPANOTI:TNexBtrTable; pWriNum,pBookNum:word);
var mFileName,mTmpFileName:ShortString;  mPaCode:longint;
begin
  // Ulozime udaje tovarovej karty do suboru
  mPaCode := pPAB.FieldByName('PaCode').AsInteger;
  mFileName := 'R-PA'+StrIntZero(pBookNum,4)+StrIntZero(mPaCode,6)+'-'+StrIntZero(pWriNum,3)+'-'+StrIntZero(gvSys.WriNum,3);
  mTmpFileName := gPath.SndPath+mFileName+'.TMP';
  oFileName := mFileName+'.TXT';
  oDocTxt.Clear;
  If FileExists (mTmpFileName+'') then DeleteFile (mTmpFileName);

  WriteRecHead (pPAB,'',''); // Ulozi udaje skladovej karty
  WriteRecItem (pPABACC,mPaCode,'PaCode','');  // Ulozi bankove ucty daneho partnera
  WriteRecItem (pPACNTC,mPaCode,'PaCode','');  // Ulozi kontaktne udaje daneho partnera
  WriteRecItem (pPASUBC,mPaCode,'PaCode','');  // Ulozi prevadzkove jednotky daneho partnera
  WriteRecItem (pPANOTI,mPaCode,'PaCode','');  // Ulozi poznamky k danemu partnerovi

  // Ulozime udaje do TMP suboru
  If FileExists (mTmpFileName) then DeleteFile (mTmpFileName);
  oDocTxt.SaveToFile (mTmpFileName);
  // Premenujeme TMP subor na TXT
  If FileExists (gPath.SndPath+oFileName) then DeleteFile (gPath.SndPath+oFileName);
  RenameFile (mTmpFileName,gPath.SndPath+oFileName);
end;

procedure TOipSnd.SaveToPlcFile (pPLS,pPLH:TNexBtrTable; pWriNum,pPlsNum:word);
var mFileName,mTmpFileName:ShortString;  mGsCode:longint;
begin
  // Ulozime udaje tovarovej karty do suboru
  mGsCode := pPLS.FieldByName('GsCode').AsInteger;
  mFileName := 'R-PL'+StrIntZero(pPlsNum,4)+StrIntZero(mGsCode,6)+'-'+StrIntZero(pWriNum,3)+'-'+StrIntZero(gvSys.WriNum,3);
  mTmpFileName := gPath.SndPath+mFileName+'.TMP';
  oFileName := mFileName+'.TXT';
  oDocTxt.Clear;
  If FileExists (mTmpFileName+'') then DeleteFile (mTmpFileName);

  WriteRecHead (pPLS,'',''); // Ulozi udaje z predajneho cennika
  WriteRecItem (pPLH,mGsCode,'GsCode','');  // Ulozi historiu zmeny predajnych cien

  // Ulozime udaje do TMP suboru
  If FileExists (mTmpFileName) then DeleteFile (mTmpFileName);
  oDocTxt.SaveToFile (mTmpFileName);
  // Premenujeme TMP subor na TXT
  If FileExists (gPath.SndPath+oFileName) then DeleteFile (gPath.SndPath+oFileName);
  RenameFile (mTmpFileName,gPath.SndPath+oFileName);
end;

procedure TOipSnd.SaveToWgiFile (pWGI:TNexBtrTable; pWriNum,pSection:word);
var mFileName,mTmpFileName:ShortString;  mGsCode:longint;
begin
  // Ulozime udaje tovarovej karty do suboru
  mGsCode := pWGI.FieldByName('GsCode').AsInteger;
  mFileName := 'R-WG'+StrIntZero(pSection,4)+StrIntZero(mGsCode,6)+'-'+StrIntZero(pWriNum,3)+'-'+StrIntZero(gvSys.WriNum,3);
  mTmpFileName := gPath.SndPath+mFileName+'.TMP';
  oFileName := mFileName+'.TXT';
  oDocTxt.Clear;
  If FileExists (mTmpFileName+'') then DeleteFile (mTmpFileName);

  WriteRecHead (NIL,'',''); // Ulozi udaje z predajneho cennika
  WriteRecItem (pWGI,mGsCode,'GsCode','');  // Ulozi historiu zmeny predajnych cien

  // Ulozime udaje do TMP suboru
  If FileExists (mTmpFileName) then DeleteFile (mTmpFileName);
  oDocTxt.SaveToFile (mTmpFileName);
  // Premenujeme TMP subor na TXT
  If FileExists (gPath.SndPath+oFileName) then DeleteFile (gPath.SndPath+oFileName);
  RenameFile (mTmpFileName,gPath.SndPath+oFileName);
end;

procedure TOipSnd.SaveToScsFile (pFGPALST,pFGPADSC:TNexBtrTable; pWriNum:word);
var mFileName,mTmpFileName:ShortString;  mPaCode:longint;
begin
  // Ulozime udaje tovarovej karty do suboru
  mPaCode := pFGPALST.FieldByName ('PaCode').AsInteger;
  mFileName := 'R-PO'+StrIntZero(mPaCode,10)+'-'+StrIntZero(pWriNum,3)+'-'+StrIntZero(gvSys.WriNum,3);
  mTmpFileName := gPath.SndPath+mFileName+'.TMP';
  oFileName := mFileName+'.TXT';
  oDocTxt.Clear;
  If FileExists (mTmpFileName+'') then DeleteFile (mTmpFileName);

  WriteRecHead (pFGPALST,'',''); // Ulozi udaje z predajneho cennika
  WriteRecItem (pFGPADSC,mPaCode,'PaCode','');  // Ulozi obchodne podmienky zadaneho odberatela

  // Ulozime udaje do TMP suboru
  If FileExists (mTmpFileName) then DeleteFile (mTmpFileName);
  oDocTxt.SaveToFile (mTmpFileName);
  // Premenujeme TMP subor na TXT
  If FileExists (gPath.SndPath+oFileName) then DeleteFile (gPath.SndPath+oFileName);
  RenameFile (mTmpFileName,gPath.SndPath+oFileName);
end;

procedure TOipSnd.SaveToBkpFile (pBookId:Str3; pTable:TNexBtrTable; pWriNum:word);
var mFieldList:TStrings;  mFieldName:Str20;  mFile:TIniFile;  I:word;
    mFileName,mTmpFileName:ShortString;  mFieldType:TFieldType;
begin
  mFileName := 'B-'+pBookId+pTable.FieldByName('BookNum').AsString+'XXXXX-'+StrIntZero(pWriNum,3)+'-'+StrIntZero(gvSys.WriNum,3);
  mTmpFileName := gPath.SndPath+mFileName+'.TMP';
  oFileName := mFileName+'.TXT';
  mFile := TIniFile.Create(mTmpFileName);
  For I:= 0 to pTable.FieldCount-1 do begin
    try
      mFieldName := pTable.Fields[I].FieldName;
      mFieldType := pTable.FieldByName(mFieldName).DataType;
      If (mFieldType=ftFloat)
        then mFile.WriteString ('BOOK',mFieldName,StrDoub(pTable.FieldByName(mFieldName).AsFloat,0,2))
        else mFile.WriteString ('BOOK',mFieldName,pTable.FieldByName(mFieldName).AsString);
    except end;
  end;
  FreeAndNil (mFile);
  If FileExists (gPath.SndPath+oFileName) then DeleteFile (gPath.SndPath+oFileName);
  RenameFile (mTmpFileName,gPath.SndPath+oFileName);
end;

procedure TOipSnd.SaveToDocFile (pHeadTable,pItemTable,pAdviTable,pNotiTable:TNexBtrTable; pWriNum:word; pCommand:ShortString);
var mFileName,mTmpFileName:ShortString;
begin
  // Ulozime udaje h;avicky dokladu
  mFileName := 'D-'+pHeadTable.fieldByName('DocNum').AsString+'-'+StrIntZero(pWriNum,3)+'-'+StrIntZero(gvSys.WriNum,3);
  mTmpFileName := gPath.SndPath+mFileName+'.TMP';
  oFileName := mFileName+'.TXT';
  oDocTxt.Clear;
  If FileExists (mTmpFileName+'') then DeleteFile (mTmpFileName);

  WriteRecHead (pHeadTable,pCommand,''); // Ulozi udaje z predajneho cennika
  WriteDocItem (pItemTable,pHeadTable.FieldByName('DocNum').AsString,'DocNum');  // Ulozi historiu zmeny predajnych cien
  WriteDocItem (pAdviTable,pHeadTable.FieldByName('DocNum').AsString,'DocNum');  // Ulozi historiu zmeny predajnych cien
  WriteDocItem (pNotiTable,pHeadTable.FieldByName('DocNum').AsString,'DocNum');  // Ulozi poznamky dokladu

  // Ulozime udaje do TMP suboru
  If FileExists (mTmpFileName) then DeleteFile (mTmpFileName);
  oDocTxt.SaveToFile (mTmpFileName);
  // Premenujeme TMP subor na TXT
  If FileExists (gPath.SndPath+oFileName) then DeleteFile (gPath.SndPath+oFileName);
  RenameFile (mTmpFileName,gPath.SndPath+oFileName);
end;

procedure TOipSnd.SaveToConFile (pHeadTable:TNexBtrTable; pWriNum:Str3);
var mFieldList:TStrings;  mCnt:word;  mFieldName:Str20;  mFile:TIniFile;
    mSdfName,mFileName,mConFileName,mTmpFileName:ShortString;  mFieldType:TFieldType;
begin
  mSdfName := pHeadTable.FixedName+'-O.SDF';
  If FileExists (gPath.DefPath+mSdfName) then begin
    mFieldList := TStringList.Create;
    mFieldList.LoadFromFile(gPath.DefPath+mSdfName);
    If mFieldList.Count>0 then begin
      mFileName := 'O-'+pHeadTable.FieldByName('DocNum').AsString+'-'+pWriNum+'-'+StrIntZero(gvSys.WriNum,3);
      oFileName := mFileName+'.TXT';
      mConFileName := gPath.SndPath+mFileName+'.TXT';
      mTmpFileName := gPath.SndPath+mFileName+'.TMP';
      mFile := TIniFile.Create(mTmpFileName);
      mCnt := 0;
      Repeat
        mFieldName := DelSpaces(mFieldList.Strings[mCnt]);
        mFieldType := pHeadTable.FieldByName(mFieldName).DataType;
        case mFieldType of
          ftFloat: mFile.WriteString ('HEAD',mFieldName,StrDoub(pHeadTable.FieldByName(mFieldName).AsFloat,0,5));
           ftDate: mFile.WriteString ('HEAD',mFieldName,StrDate(pHeadTable.FieldByName(mFieldName).AsDateTime))
             else  mFile.WriteString ('HEAD',mFieldName,pHeadTable.FieldByName(mFieldName).AsString);
        end;
        Inc (mCnt);
      until mCnt=mFieldList.Count;
      FreeAndNil (mFieldList);
      FreeAndNil (mFile);
      If FileExists (mConFileName) then DeleteFile (mConFileName);
      RenameFile (mTmpFileName,mConFileName);
    end;
  end
  else ShowMsg (ecSysFileIsNotExist,gPath.DefPath+mSdfName);
end;

procedure TOipSnd.SaveToPmdFile (pPMI:TNexBtrTable; pDocNum:Str12; pWriNum:word);
var mFileName,mTmpFileName:ShortString; I:word; mHead:TDocHead;
    mFieldName:Str20;  mFieldType:TFieldType;  mItems:TDocItem;
begin
  mFileName := 'P-'+pDocNum+'-'+StrIntZero(pWriNum,3)+'-'+StrIntZero(gvSys.WriNum,3);
  mTmpFileName := gPath.SndPath+mFileName+'.TMP';
  oFileName := mFileName+'.TXT';
  oDocTxt.Clear;
  If FileExists (mTmpFileName+'') then DeleteFile (mTmpFileName);

  WriteRecHead (nil,'',''); // Ulozi udaje z predajneho cennika
  WriteDocItem (pPMI,pDocNum,'DocNum');  // Ulozi historiu zmeny predajnych cien
(*
  mHead := TDocHead.Create;
  mHead.WriteString ('Command','');
  oDocTxt.Add ('[HEAD]');
  oDocTxt.AddStrings (mHead.HeadFile);

  If pPMI.IndexName<>'ConDoc' then pPMI.IndexName := 'ConDoc';
  If pPMI.FindKey([pDocNum]) then begin
    mItems := TDocItem.Create;
    Repeat
      mItems.Insert;
      For I:=0 to pPMI.FieldCount-1 do begin
        try
          mFieldName := pPMI.Fields[I].FieldName;
          mFieldType := pPMI.FieldByName(mFieldName).DataType;
          case mFieldType of
            ftFloat: mItems.WriteFloat (mFieldName,pPMI.FieldByName(mFieldName).AsFloat);
             ftDate: mItems.WriteDate (mFieldName,pPMI.FieldByName(mFieldName).AsDateTime);
               else  mItems.WriteString (mFieldName,pPMI.FieldByName(mFieldName).AsString);
          end;
        except end;
      end;
      mItems.Post;
      Application.ProcessMessages;
      pPMI.Next;
    until pPMI.Eof or (pPMI.FieldByname('ConDoc').AsString<>pDocNum);
    oDocTxt.Add ('[FLDLST-PMI]');
    oDocTxt.AddStrings (mItems.FldLst);
    oDocTxt.Add ('[ITMLST-PMI]');
    oDocTxt.AddStrings (mItems.ItmLst);
    FreeAndNil (mItems);
    FreeAndNil (mHead);
  end;
*)

  // Ulozime udaje do TMP suboru
  If FileExists (mTmpFileName) then DeleteFile (mTmpFileName);
  oDocTxt.SaveToFile (mTmpFileName);
  // Premenujeme TMP subor na TXT
  If FileExists (gPath.SndPath+oFileName) then DeleteFile (gPath.SndPath+oFileName);
  RenameFile (mTmpFileName,gPath.SndPath+oFileName);
end;

procedure TOipSnd.SaveToAccFile (pJOURNAL:TNexBtrTable; pDocNum:Str12; pWriNum:word);
var mFileName,mTmpFileName:ShortString;  mHead:TDocHead;
begin
  // Ulozime udaje h;avicky dokladu
  mFileName := 'A-'+pDocNum+'-'+StrIntZero(pWriNum,3)+'-'+StrIntZero(gvSys.WriNum,3);
  mTmpFileName := gPath.SndPath+mFileName+'.TMP';
  oFileName := mFileName+'.TXT';
  oDocTxt.Clear;
  oDocTxt.Add ('[HEAD]');
  If FileExists (mTmpFileName+'') then DeleteFile (mTmpFileName);
  mHead := TDocHead.Create;
  If (pJOURNAL=nil) or not pJOURNAL.Active then begin
    mHead.WriteString('Command','DEL');
    oDocTxt.AddStrings (mHead.HeadFile);
  end
  else begin
    mHead.WriteString('Command','ACC');
    oDocTxt.AddStrings (mHead.HeadFile);
    WriteDocItem (pJOURNAL,pDocNum,'DocNum');  // Ulozi historiu zmeny predajnych cien
  end;
  FreeAndNil (mHead);
  // Ulozime udaje do TMP suboru
  If FileExists (mTmpFileName) then DeleteFile (mTmpFileName);
  oDocTxt.SaveToFile (mTmpFileName);
  // Premenujeme TMP subor na TXT
  If FileExists (gPath.SndPath+oFileName) then DeleteFile (gPath.SndPath+oFileName);
  RenameFile (mTmpFileName,gPath.SndPath+oFileName);
end;

end.
