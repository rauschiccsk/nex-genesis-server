unit BtrTools;

interface

uses
  {IdentCode} IcVariab, IcConv, IcTools,
  {Delphi}    DBTables, Dialogs, Controls, SysUtils, Forms, DB, classes, ShellApi, windows;

const
  cChunkSize = 16386;
  cMaxIndexesNumBtr = 30;
  cMaxIndexSegmentsNumBtr = 20;

procedure DialTransferProcess(pFieldName: string; pTable, pDial:TTable);
function  TableToTextFileCP(pTable: TTable; pFileName: string): boolean; //CP - Current Position attolaz allastol illetve azzal az indexel ami eppen van* 1997.11.20. *
function  TextFileToTable(pTable: TTable; pFileName: string): boolean;
function  FPosCh(pChar: Char; pStr: string): integer; //Megadja a stringben a kivalasztott karakter elso elofordulasi poziciojat ha nincs akkor 0
function  LPosCh(pChar: Char; pStr: string): integer; //Megadja a stringben a kivalasztott karakter utolso elofordulasi poziciojat ha nincs akkor 0
function  NPosCh(pNum: integer; pChar: Char; pStr: string): integer; //Megadja a stringben az n-edik kivalasztott karakter poziciojat 1999.11.23.
function  ConventionStrComp(pStr, pConvStr: string): boolean; // * ill. ? konvencios filenev osszehasonlitas

function  ExePath(pApplication: TApplication): string; // Visszaadja a futo alkalnazas Path-jat pl. 'c:\Program Files\IDC\Tex\'
function  ExeNameOnly(pApplication: TApplication): string; // Visszaadja a futo alkalnazas Nevet '.exe' nelkul pl. 'Tex'
function  ExeNameWithoutExtension(pApplication: TApplication): string; // Visszaadja a futo alkalnazas Utvonalat + Nevet '.exe' nelkul pl. 'c:\Program Files\IDC\Tex\Tex'

function  StrToFldTpe(pStr: string): TFieldType; //1999.5.7.
function  FldTpeToStr(pFieldType: TFieldType): string; //1999.5.7.

function  ExtractOnlyFileName(pStr: string): string; //1999.5.12. c:\akarmidir\akrmifile.ext -> akarmifile
function  ExtractOnlyFilePath(pStr: string): string; //2000.3.2.  c:\akarmidir\akrmifile.ext -> c:\akarmidir

function  ReplaceStr (pStr, pFind, pRepl: string): string; //1999.5.31.
//1999.6.7.
function  WeekOfYear (pDate:TDate):byte;
//1999.6.23.
//2000.1.8. athelyezve a AgyBtrApi-ba function  BtrDataTypeToFieldType(pDataType:byte; pSize:word): TFieldType;
//1999.7.31.
function  DefaultFileName(pFileName: string): string;
//1999.8.19.
function  IntToDelimitedStr(pInt: int64): string;
//1999.10.3.
function  StringInStrings(pStr: string; pList:TStrings): boolean; //By Laci 97.2.21.
function  GetStringNumInStrings(pStr: string; pList:TStrings): integer; //By laci 97.4.5.
//1999.10.5.
function  GetStringNumInSortedStrings(pStr: string; pList:TStrings): integer;
//1999.10.7.
procedure ReadFileNamesInFolder(pFolderName, pFileNameMask, pExtensionMask: string; var pItems: TStrings); //Beolvassa az extensionban meghatarozott File nneveket aegy adott folderbol a strings be;
//1999.11.15.
procedure WriteToLogFileStrings(pFileName:String;pStrings:TStrings);
procedure WriteToLogFile(pFileName, pStr: string);
procedure AppendToTextFile(pFileName, pToAppendName: string);
function  AppendToFile(pFileName, pToAppendName: string): boolean;
//1999.11.15.
procedure AgySoftOnClick; //Internetes kapcsolatfelvetel link az oldalamra
//2000.1.20.
//2000.1.25. moved to AgyComponnentTools function  GetFreeComponentName(pForm: TForm; pName: string): string; //2000.1.20.
//2000.2.17.
function  PathToLastFolder(pPath: string): string; //By Laci 1997.11.26. pl: 'c:\Akarmi\masik\harmadik'  -> 'harmadik'

procedure AllBeforePost(DataSet: TDataSet); //By Laci 1997.10.21. moved from Tools 2000.2.28.

(*
procedure ShowMsg(pText, pParam: string); //ezt egyenlorecsak egyszeruen csinalom
function  AskYesNo(pText, pParam: string): boolean; //ezt is egyenlore csak egyszeruen csinalom nem fog mukodni ugy mint a dosos
procedure ShowBErr (pStatus: integer; pFilename: string);
*)

implementation

uses IcFiles;

(*
procedure ShowBErr (pStatus: integer; pFilename: string);
begin
  If not pStatus in [0,4,8,9,43]
    then MessageDlg('Btrieve error ('+IntToStr(pStatus)+') in file: '+ pFileName, mtError, [mbOk], 0);
end;

function  AskYesNo(pText, pParam: string): boolean; //ezt is egyenlorecsak egyszeruen csinalom nem fog mukodni ugy mint a dosos
begin
  Result := MessageDlg(pText + ' ' + pParam, mtConfirmation, [mbYes, mbNo], 0) = mrYes;
end;

procedure ShowMsg(pText, pParam: string); //ezt egyenlorecsak egyszeruen csinalom
begin
  MessageDlg(pText + ' ' + pParam, mtWarning, [mbOk], 0);
end;
*)
procedure AllBeforePost(DataSet: TDataSet); //By Laci 1997.10.21.
var I: integer;   mStr: string;   mFoundedField: TField;
begin
  for i:=0 to DataSet.FieldCount-1 do begin
    mStr := DataSet.Fields[i].FieldName;
    mStr := Uppercase(mStr); //2000.5.9.
(*
    If (mStr = 'ARCHIVE') then begin
      DataSet.Fields[i].ReadOnly := FALSE;
      (DataSet.Fields[i] as TIntegerField).AsInteger := 1;
      DataSet.Fields[i].ReadOnly := TRUE;
    end;
    If (mStr = 'SENDED') then begin
      DataSet.Fields[i].ReadOnly := FALSE;
      (DataSet.Fields[i] as TIntegerField).AsInteger := 0;
      DataSet.Fields[i].ReadOnly := TRUE;
    end;
    If (mStr = 'MODDATE') then begin
      DataSet.Fields[I].ReadOnly := FALSE;
      (DataSet.Fields[I] as TDateTimeField).AsDateTime := Now;
      DataSet.Fields[I].ReadOnly := TRUE;
    end;
    //2000.5.9.
    If (mStr = 'MODTIME') then begin
      DataSet.Fields[i].ReadOnly := FALSE;
      (DataSet.Fields[i] as TDateTimeField).AsString := TimeToStr(now);
      DataSet.Fields[i].ReadOnly := TRUE;
    end;
    If (mStr = 'MODUSER') then begin
      DataSet.Fields[i].ReadOnly := FALSE;
      (DataSet.Fields[i] as TStringField).AsString := gvSys.LoginName;
      DataSet.Fields[i].ReadOnly := TRUE;
    end;
*)
    If mStr[length(mStr)] = '_' then begin
      mFoundedField := DataSet.FindField(copy(mStr,1,length(mStr)-1));
      If mFoundedField <> nil then
        DataSet.Fields[i].AsString:=IcConv.StrToAlias(mFoundedField.AsString);
    end;
  end;
end;

function  PathToLastFolder(pPath: string): string; //By Laci 1997.11.26. pl: 'c:\Akarmi\masik\harmadik'  -> 'harmadik'
begin
  Result := '';
  If (pPath = '') then exit;
  If pPath[length(pPath)]='\' then delete(pPath,length(pPath),1);
  If (pPath = '') then exit;
  Result := LineElement(pPath,LineElementNum(pPath, '\')-1,'\');
end;

procedure AgySoftOnClick;
  begin
    If ShellExecute(Application.Handle,PChar('open'),PChar('http://w3.swi.hu/agysoft'),PChar(''), nil, SW_NORMAL) < 33 then
    If ShellExecute(Application.Handle,PChar('open'),PChar('netscape.exe'),PChar('http://w3.swi.hu/agysoft'),nil,SW_NORMAL) < 32 then
    If ShellExecute(Application.Handle,PChar('open'),PChar('iexplore.exe'),PChar('http://w3.swi.hu/agysoft'),nil,SW_NORMAL) < 32 then
    showmessage ('Please visit me at : http://w3.swi.hu/agysoft');
  end;

function AppendToFile(pFileName, pToAppendName: string): boolean;
  var
    mFH,
    mAFH : integer;
    mReadBytes: integer;
    mCopyBuffer: pointer;
  begin
    Result := TRUE;
    mFH := FileOpen(pFileName, fmOpenWrite or fmShareDenyNone);
    If (mFH <= 0) then mFH := FileCreate(pFileName);
    mAFH := FileOpen(pToAppendName, fmOpenRead or fmShareDenyNone);
    If (mFH > 0) then begin
      If (mAFH > 0) then begin
        GetMem(mCopyBuffer, cChunkSize);
        FileSeek(mFH,0,2);
        FileSeek(mAFH,0,0);
        Repeat
          mReadBytes := FileRead(mAFH, mCopyBuffer^, cChunkSize);
          If (mReadBytes < 0) then Result := FALSE
          else If mReadBytes <> FileWrite(mFH, mCopyBuffer^, mReadBytes) then Result := FALSE;
        until (mReadBytes = 0) or (not Result);
        FreeMem(mCopyBuffer);
        FileClose(mAFH);
      end else Result := FALSE;
      FileClose(mFH);
    end else Result := FALSE;
  end;

procedure AppendToTextFile(pFileName, pToAppendName: string);
  var
    mF1, mF2: TextFile;
    mStr: string;
  begin
    AssignFile(mF1, pFileName);
    AssignFile(mF2, pToAppendName);
    try Append(mF1); except Rewrite(mF1); end;
    try
      Reset(mF2);
      While not EOF(mF2) do begin
        ReadLN(mF2, mStr);
        WriteLN(mF1, mStr);
      end;
    except
    end;
    CloseFile(mF1);
    CloseFile(mF2);
  end;


procedure WriteToLogFileStrings(pFileName:String;pStrings:TStrings);
  var
    mF: TextFile;
    mI: integer;
begin
  If pStrings.Count>0 then begin
    AssignFile(mF, pFileName);
    If FileExistsI (pFileName)
      then {$I-}Append(mF){$I+}
      else {$I-}Rewrite(mF);{$I+}
    If IOResult=0 then begin
      for mI:=0 to pStrings.Count-1 do WriteLN(mF, pStrings.Strings[mI]);
      CloseFile(mF);
    end;
  end;
end;

procedure WriteToLogFile(pFileName, pStr: string);
  var
    mF: TextFile;
    mPath:String;
  begin
    If DirectoryExists(ExtractFilePath(pFileName)) or (ExtractFilePath(pFileName)='') then begin
      AssignFile(mF, pFileName);
      If FileExistsI (pFileName)
        then {$I-}Append(mF){$I+}
        else {$I-}Rewrite(mF);{$I+}
      If IOResult=0 then begin
        WriteLN(mF, pStr+';|;'+DateTimeToStr(Now));
        CloseFile(mF);
      end;
    end;
  end;


procedure ReadFileNamesInFolder(pFolderName, pFileNameMask, pExtensionMask: string; var pItems: TStrings);
  var
    mSearchRec: TSearchRec;
  begin
    pItems.Clear;
    If (0 = FindFirst(pFolderName + '\' + pFileNameMask + '.' + pExtensionMask, faAnyFile, mSearchRec)) then Repeat
      If (mSearchRec.Attr and faDirectory) <> faDirectory then begin
        pItems.Add(mSearchRec.Name);
      end;
    until (FindNext(mSearchRec) <> 0);
    SysUtils.FindClose(mSearchRec);
  end;


function  GetStringNumInSortedStrings(pStr: string; pList:TStrings): integer;
  var
//    i: integer;
    mBegin,
    mEnd,
    mMed: integer;
    mFound: boolean;
  begin
    Result := -1;
    If (pList.Count <= 0) then exit;        //Result = -1 not in list
    mBegin := 0;
    mEnd := pList.Count-1;
    mFound := FALSE;
    pStr := UpperCase(pStr);
    Repeat
      mMed := (mBegin+mEnd) div 2;
      If pStr = UpperCase(pList[mMed]) then mFound := TRUE
      else If pStr < UpperCase(pList[mMed])
        then mEnd := mMed - 1
        else mBegin := mMed +1;
    until (mBegin > mEnd) or mFound;
    If mFound then Result := mMed;
  end;


function  GetStringNumInStrings(pStr: string; pList:TStrings): integer;
  var    i: integer;
  begin
    Result := -1;
    If (pList.Count <= 0) then exit;        //Result = -1 not in list
    i := 0;
    While (i < pList.Count) and (pStr <> pList[i]) do inc(i);
    If (i < pList.Count) then Result := i;  //Result = number string in list
{      else Result = -1 not in list}
  end;


function  StringInStrings(pStr: string; pList:TStrings): boolean;
  var    i: integer;
  begin
    i := 0;
    While (i < pList.Count) and (UpperCase(pStr) <> UpperCase(pList[i])) do inc(i);
    If (pList.Count > 0)
      then StringInStrings := (i < pList.Count)
      else StringInStrings := FALSE;
  end;


function  IntToDelimitedStr(pInt: int64): string;
  var
    mStr,
    mNew: string;
    mLen: integer;
    mCnt: integer;
    i: integer;
  begin
    mStr := IntToStr(pInt);
    mLen := length(mStr);
    If mLen > 3 then begin
      mCnt := 0;
      for i := mLen downto 1 do begin
        mNew := mStr[i] + mNew;
        inc(mCnt);
        If (mCnt mod 3) = 0 then mNew := ' ' + mNew;
      end;
      mStr := mNew;
    end;
    Result := mStr
  end;


function  DefaultFileName(pFileName: string): string;
  var
    mFullExeName,
    mExeDrive,
    mExePath,
    mExeName,
    mDefaultExtension: string;
    mPos: integer;
  begin
    mFullExeName := Application.ExeName;
    mDefaultExtension := 'AL';

    mExeDrive := ExtractFileDrive(mFullExeName);        // 'J:'
    mExePath  := ExtractFilePath(mFullExeName);         // 'J:\DEVW\LACI\ALANG\'
    mExeName  := ExtractFileName(mFullExeName);         // 'PROJECT1.EXE'
    mExeName  := copy(mExeName, 1, length(mExeName)-3); // 'PROJECT1.'

    If pFileName = '' then begin
      Result := mExePath + mExeName + mDefaultExtension;
    end else begin
      mPos := pos('.', pFileName);
      If (mPos = 0) then pFileName := pFileName + '.' + mDefaultExtension;
      If (mPos = 1) then begin
        delete(pFileName,1,1);
        Result := mExePath + mExeName + pFileName;
      end else begin
        If 1 = pos('\', pFileName) then delete(pFileName,1,1);
        mPos := pos(':', pFileName);
        If (mPos = 0) then begin
          Result := mExePath + pFileName;
        end else begin
          If (mPos = 1) then begin
            delete(pFileName,1,1);
            Result := mExeDrive+pFileName
          end else Result := pFileName;
        end;
      end;
    end;
  end;


function  WeekOfYear (pDate:TDate):byte;
var
  mY,mM,mD:word;
  mDate:TDate;
  mDays :integer;
begin
  DecodeDate (pDate,mY,mM,mD);
  mDate := EncodeDate (mY,1,1);
  mDays := Round (pDate-mDate) + DayOfWeek(mDate);
  If (mDays div 7) = (mDays / 7)
    then Result := mDays div 7
    else Result := mDays div 7 + 1;
end;


function  ReplaceStr (pStr, pFind, pRepl: string): string;
var mStr: string;
begin
  mStr := '';
  While Pos (pFind,pStr)>0 do begin
    mStr := mStr+Copy (pStr,1,Pos (pFind,pStr)-1)+pRepl;
    Delete (pStr,1,Pos (pFind,pStr)-1+Length (pFind));
  end;
  ReplaceStr := mStr+pStr;
end;

function  ExtractOnlyFileName(pStr: string): string;
  var
    i:integer;
  begin
    pStr := ExtractFileName(pStr);
    i := length(pStr);
    While (i>0) and (pStr[i]<>'.') do dec(i);
    If (i>0) then Result := copy(pStr,1,i-1) else Result := pStr;
  end;

function  ExtractOnlyFilePath(pStr: string): string;
  begin
    Result := ExtractFilePath(pStr);
    If (Result[length(Result)] = '\')
      then delete(Result,length(Result),1);
  end;

{
ftUnknown	Unknown or undetermined
ftString	Character or string field
ftSmallint	16-bit integer field
ftInteger	32-bit integer field
ftWord	        16-bit unsigned integer field
ftBoolean	Boolean field
ftFloat	        Floating-point numeric field
ftCurrency	Money field
ftBCD	        Binary-Coded Decimal field
ftDate	        Date field
ftTime	        Time field
ftDateTime	Date and time field
ftBytes	        Fixed number of bytes (binary storage)
ftVarBytes	Variable number of bytes (binary storage)
ftAutoInc	Auto-incrementing 32-bit integer counter field
ftBlob	        Binary Large OBject field
ftMemo	        Text memo field
ftGraphic	Bitmap field
ftFmtMemo	Formatted text memo field
ftParadoxOle	Paradox OLE field
ftDBaseOle	dBASE OLE field
ftTypedBinary	Typed binary field
ftCursor	Output cursor from an Oracle stored procedure (TParam only)
ftFixedChar	Fixed character field
ftWideString	Wide string field
ftLargeInt	Large integer field
ftADT	        Abstract Data Type field
ftArray	        Array field
ftReference	REF field
ftDataSet	DataSet field}


function  StrToFldTpe(pStr: string): TFieldType;
  var
    mCh :char;
  begin
    mCh := pStr[1];
    case mCh of
      'N' : Result := ftFloat;
      'A' : Result := ftString;
      'D' : Result := ftDate;
      'T' : Result := ftTime;
      '@' : Result := ftDateTime;
      'I' : Result := ftInteger;
      '$' : Result := ftCurrency;
      'F' : Result := ftFmtMemo;
      '+' : Result := ftAutoInc;
      'S' : Result := ftSmallint;
      '#' : Result := ftBCD;
      'M' : Result := ftMemo;
      'B' : Result := ftBlob;
      'Y' : Result := ftBytes;
      'G' : Result := ftGraphic;
      'O' : Result := ftParadoxOle; //  ftDBaseOle
      'L' : Result := ftBoolean;
//1999.7.16      '~' : Result := ftFixedChar; //1999.5.17. hat meglatjuk
      else  Result := ftUnknown;
    end
 {Ami kimaradt : ftWord, ftVarBytes, ;ftTypedBinary}
  end;

function  FldTpeToStr(pFieldType: TFieldType): string;
  begin
    If (pFieldType = ftFloat)           then Result := 'N'
    else If (pFieldType = ftString)     then Result := 'A'
    else If (pFieldType = ftDate)       then Result := 'D'
    else If (pFieldType = ftTime)       then Result := 'T'
    else If (pFieldType = ftDateTime)   then Result := '@'
    else If (pFieldType = ftInteger)    then Result := 'I'
    else If (pFieldType = ftCurrency)   then Result := '$'
    else If (pFieldType = ftFmtMemo)    then Result := 'F'
    else If (pFieldType = ftAutoInc)    then Result := '+'
    else If (pFieldType = ftSmallint)   then Result := 'S'
    else If (pFieldType = ftBCD)        then Result := '#'
    else If (pFieldType = ftMemo)       then Result := 'M'
    else If (pFieldType = ftBlob)       then Result := 'B'
    else If (pFieldType = ftBytes)      then Result := 'Y'
    else If (pFieldType = ftGraphic)    then Result := 'G'
    else If (pFieldType = ftParadoxOle) then Result := 'O'
    else If (pFieldType = ftDBaseOle)   then Result := 'O'
    else If (pFieldType = ftBoolean)    then Result := 'L'
    else Result := 'A';
  end;

function  ExePath(pApplication: TApplication): string;
  begin
    Result := ExtractFilePath(pApplication.ExeName);
  end;
function  ExeNameOnly(pApplication: TApplication): string;
  begin
    Result := ExtractOnlyFileName(pApplication.ExeName); //By Laci 1998.2.24
  end;

function  ExeNameWithoutExtension(pApplication: TApplication): string;
  begin
    Result := ExePath(pApplication)+ExeNameOnly(pApplication); //By Laci 1998.2.24
  end;


function  ConventionStrComp(pStr, pConvStr: string): boolean;
  procedure CSCSlave(var pStr, pConvStr: string);
    var
      mStrLen, mConvStrLen: integer;
      mInsStr: string;
      i, mPos: integer;
    begin
      mStrLen := length(pStr);
      mConvStrLen := length(pConvStr);
      mInsStr := '';
      for i := 0 to (mStrLen - mConvStrLen) do mInsStr := mInsStr + '?';
      mPos := pos('*',pConvStr);
      If mPos>0 then begin
        delete(pConvStr,mPos,1);
        insert(mInsStr, pConvStr,mPos);
      end;
    end;

  var
    mPos, mLen: integer;
    mStr1, mStr2, mConvStr1, mConvStr2: string;
  begin
    Result := TRUE;
    If (pStr = '') and (pConvStr = '') then exit;
    Result := FALSE;
    If (pStr = '') or  (pConvStr = '') then exit;
    // inentolegyiksemures
    mPos := LPosCh('.', pStr);
    mStr1 := copy(pStr,1,mPos-1);
    mStr2 := copy(pStr,mPos, length(pStr));

    mPos := LPosCh('.', pConvStr);
    mConvStr1 := copy(pConvStr,1,mPos-1);
    mConvStr2 := copy(pConvStr,mPos, length(pConvStr));

    If (length(mConvStr1) > length(mStr1)) or (length(mConvStr2) > length(mStr2)) then exit;

    CSCSlave(mStr1, mConvStr1);
    CSCSlave(mStr2, mConvStr2);

    pStr:=mStr1+'.'+mStr2;
    pConvStr:=mConvStr1+'.'+mConvStr2;

    mLen :=length(pStr);
    mPos:=1;
    While (mPos<=mLen) and ((pStr[mPos]=pConvStr[mPos]) or (pConvStr[mPos]='?')) do inc(mPos);
    Result := (mPos > mLen);
  end;


function  FPosCh(pChar: Char; pStr: string): integer;
  begin
    Result := pos(pChar,pStr);
  end;

function  LPosCh(pChar: Char; pStr: string): integer;
  var
    i: integer;
  begin
    i := length(pStr);
    While (i>0) and (pStr[i]<>pChar) do dec(i);
    Result := i;
  end;

function  NPosCh(pNum: integer; pChar: Char; pStr: string): integer; //Megadja a stringben az n-edik kivalasztott karakter poziciojat 1999.11.23.
  var
    i,
    mNum: integer;
  begin
    i := 1;
    mNum := 0;
    Result := 0;
    While (i <= length(pStr)) and (Result = 0) do begin
      If (pStr[i] = pChar) then inc(mNum);
      If (mNum = pNum) then Result := i;
      inc(i);
    end;
  end;

procedure DialTransferProcess(pFieldName: string; pTable, pDial:TTable);
  begin
    try
      pTable.Edit;
      If (pTable.FindField(pFieldName) <> nil) then begin
        pTable.FieldByName(pFieldName).AsString := pDial.FieldByname('Name').AsString;
      end;
      If (pTable.FindField(pFieldName+'C')<>nil) then pTable.FieldByName(pFieldName+'C').AsInteger := pDial.FieldByname('Code').AsInteger;
      If (pTable.FindField('ZIP') <> nil) and (pDial.FindField('ZIP') <> nil) then begin
         If (pTable.FindField('ZIP').AsString = '') then pTable.FindField('ZIP').AsString := pDial.FindField('ZIP').AsString;
      end;
      If (pTable.FindField('Distr') <> nil) and (pDial.FindField('Distr') <> nil) then begin
         If (pTable.FindField('Distr').AsString = '') then pTable.FindField('Distr').AsString := pDial.FindField('Distr').AsString;
      end;
      pTable.Post;
    except end;
  end;


function  TableToTextFileCP(pTable: TTable; pFileName: string): boolean; //CP - Current Position attolaz allastol illetve azzal az indexel ami eppen van//******************** 1997.11.20. **********************
  var
    mTFile: TextFile;
    mRecStr: string;
    i,j: integer;
    mExit: boolean;
  begin
//    Result := TRUE;
    AssignFile(mTFile, pFileName);
    Rewrite(mTFile);
    pTable.FieldDefs.Update;
    i:=0;
    mExit := FALSE;
    While (not pTable.Eof) and (not mExit) do begin
      try
        mRecStr := '';
        If pTable.FieldDefs.Count > 0 then begin
          mRecStr := pTable.FieldByName(pTable.FieldDefs.Items[0].Name).AsString;
        end;
        If pTable.FieldDefs.Count > 1 then begin
          for j := 1 to pTable.FieldDefs.Count-1 do begin
            mRecStr := mRecStr + '|'+ pTable.FieldByName(pTable.FieldDefs.Items[j].Name).AsString;
          end;
        end;
        WriteLn(mTFile,mRecStr);
        pTable.Next;
        inc(i);
        If i>100 then begin
          mExit := (MessageDlg('Tul vagyunk 100 on Folytassam ?', mtConfirmation, [mbYes, mbNo], 0) <> mrYes);
          i := 0;
        end;
      except
        mExit := (MessageDlg('Valami Hiba tortent Folytassam ?', mtConfirmation, [mbYes, mbNo], 0) <> mrYes);
      end;
    end;
    CloseFile(mTFile);
    Result := not mExit;
  end;
//**************************************************************************


function  TextFileToTable(pTable: TTable; pFileName: string): boolean;
  var
    mTFile: TextFile;
    mRecStr: string;
    j: integer;
    mReadOnly: boolean;
  begin
    Result := TRUE;
    {$I-}
    AssignFile(mTFile, pFileName);
    FileMode := 0;
    Reset(mTFile);
    {$I+}
    If (IOResult = 0) then begin
      pTable.Active := TRUE;
      pTable.FieldDefs.Update;
      While not EOF(mTFile) do begin
        ReadLn(mTFile, mRecStr);
        If (mRecStr <> '') then begin
          try
            pTable.Insert;
            for j := 0 to pTable.FieldDefs.Count-1 do begin
              try
                mReadOnly := pTable.FieldByName(pTable.FieldDefs.Items[j].Name).ReadOnly;
                pTable.FieldByName(pTable.FieldDefs.Items[j].Name).ReadOnly := FALSE;
                pTable.FieldByName(pTable.FieldDefs.Items[j].Name).AsString := LineElement(mRecStr,j,'|');
                pTable.FieldByName(pTable.FieldDefs.Items[j].Name).ReadOnly := mReadOnly;
              except end;
            end;
            pTable.Post;
          except pTable.Cancel; end;
        end;
      end;
      CloseFile(mTFile);
    end;
  end;

end.

