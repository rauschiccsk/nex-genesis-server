unit IcFiles;

interface

uses
  {IdentCode} IcTools, IcTypes, IcConv, IcVariab, FpTools, BtrTools,
  {Delphi}    Dialogs, StdCtrls, SysUtils, Windows, Classes, Consts;

type
  EInvalidDest = class(EStreamError);
  EFCantMove = class(EStreamError);

//  function FileExists(const FileName: string): Boolean;
  function FileExistsI(const FileName: string): Boolean;
  function FileInUse(pFileName:string):boolean;
  function FileExistF (const pFileName: string): boolean;
//  procedure CopyFile(const FileName, DestName: string);
  procedure MoveFile(const FileName, DestName: string);
  function  GetFileSize(const FileName: string): LongInt;
  function  FileDateTime(const FileName: string): TDateTime;
  function  HasAttr(const FileName: string; Attr: Word): Boolean;
  function  ExecuteFile(const FileName, Params, DefaultDir: string;ShowCmd: Integer): THandle;

  function  ExtractOnlyFileName(pStr: string): string;
            //By Laci 1997.6.4.   //attirva az AgyToolsba;
  function  WinFNameToDosFName(pFName: string): string;
            // By Laci 1997.11.11.
  function  PathToLastFolder(pPath: string): string;
            //By Laci 1997.11.26. pl: 'c:\Akarmi\masik\harmadik'  -> 'harmadik'
  procedure DeleteFilesInDir (pPath:string);
            //Táto metoda zruší všetky súbory zo zadaného adresára
  function  DirIsEmpty(pPath:string):boolean;
            //Táto funkcia vráti èi zadaný adresár je prázdny
  function  GetFileQntInDir (pPath:string):longint;
            //Táto funkcia vráti poèet súborov v zadanom adresáry
  function  GetDirCrtDate (pPath:string):TDateTime;
            //Hodnota funkcie je datum a cas vytvorenia zadaneho adresata
  procedure GetFileList (pMask:TStrings;var pFiles:TStrings;var pSize:longint);
            //vráti zoznam a sumarizovaný ve¾kos súborov pod¾a zadanej masky
            // pMask - zoznam masiek, pFiles - zoznam vyhovujúcich súborov, pSize - ve¾kos všetkých vyhovujúcich súborov
  function CutFile (pFile,pDPath:string;pSize:longint;var pFileNum:byte;pLFileNum,pLFileName:TLabel):boolean;
  function WrapFile (pFile,pDPath:string;var pFileNum:byte;pLFileNum,pLFileName:TLabel):boolean;
  function GetFirstCDDrive:ShortString;

//  procedure AddPathToSList (pSList:TStringList;pPath:string);
//  procedure CutPathInSList (pSList:TStringList);

//  function  FDDReady (pDrv:Str1):boolean;
//  function  PutDisk (pDiskNum:longint;pDrv:Str1):boolean;

  procedure KillFiles(Path: string);
  procedure DeleteDirectory(dir: string);
  function  DelTree(DirName : string): Boolean;
  function  WinCopyFile(Source, Dest: string): Boolean;


implementation

uses Forms, ShellAPI;

const
  SInvalidDest = 'Destination %s does not exist';
  SFCantMove = 'Cannot move file %s';
(*
function FileExists(const FileName: string): Boolean;
begin
  Result:=FileExistsI(FileName);
end;
*)
function FileExistsI(const FileName: string): Boolean;
var mI:byte;
begin
  Result:=False; mI:=0;
  repeat
    Result:=SysUtils.FileExists(FileName);
    If not Result then begin
      Inc(mI);
      Sleep(cFileExistSleepTime);
    end;
  until Result or (mI>cFileExistLoopCount);
end;


function FileInUse(pFileName:string):boolean;
var mF:file of byte; mIORes:longint;
begin
  Result:=FALSE;
  If FileExists(pFileName) then begin
    AssignFile (mF, pFileName);
    {$I-}
    FileMode := fmShareExclusive;
    Reset (mF); mIORes:=IOResult;
    If mIORes=0 then begin
      CloseFile (mF);
      mIORes:=IOResult;
    end else Result:=(mIORes=32);
    {$I+}
  end;
end;


function FileExistF (const pFileName: string): boolean;
var mF: TSearchRec;
begin
  Result := SysUtils.FindFirst(pFileName,faAnyFile,mF)=0;
  SysUtils.FindClose(mF);
end;

(*
procedure CopyFile(const FileName, DestName: string);
var
  CopyBuffer: Pointer; { buffer for copying }
  BytesCopied: Longint;
  Source, Dest: Integer; { handles }
  Len: Integer;
  Destination: TFileName; { holder for expanded destination name }
const
  ChunkSize: Longint = 8192; { copy in 8K chunks }
begin
  Destination := ExpandFileName(DestName); { expand the destination path }
  if HasAttr(Destination, faDirectory) then { if destination is a directory... }
  begin
    Len :=  Length(Destination);
    if Destination[Len] = '\' then
      Destination := Destination + ExtractFileName(FileName) { ...clone file name }
    else
      Destination := Destination + '\' + ExtractFileName(FileName); { ...clone file name }
  end;
GetMem(CopyBuffer, ChunkSize); { allocate the buffer }
  try
    Source := FileOpen(FileName, fmShareDenyWrite); { open source file }
    if Source < 0 then raise EFOpenError.CreateFmt(SFOpenError, [FileName]);
    try
      Dest := FileCreate(Destination); { create output file; overwrite existing }
      if Dest < 0 then raise EFCreateError.CreateFmt(SFCreateError, [Destination]);
      try
        repeat
          BytesCopied := FileRead(Source, CopyBuffer^, ChunkSize); { read chunk }
          if BytesCopied > 0 then { if we read anything... }
            FileWrite(Dest, CopyBuffer^, BytesCopied); { ...write chunk }
        until BytesCopied < ChunkSize; { until we run out of chunks }
      finally
        FileClose(Dest); { close the destination file }
      end;
    finally
      FileClose(Source); { close the source file }
    end;
  finally
    FreeMem(CopyBuffer, ChunkSize); { free the buffer }
  end;
end;
*)

{ MoveFile procedure }
{
  Moves the file passed in FileName to the directory specified in DestDir.
  Tries to just rename the file.  If that fails, try to copy the file and
  delete the original.

  Raises an exception if the source file is read-only, and therefore cannot
  be deleted/moved.
}

procedure MoveFile(const FileName, DestName: string);
var Destination: string;
begin
  Destination := ExpandFileName(DestName); { expand the destination path }
  if not RenameFile(FileName, Destination) then { try just renaming }
  begin
    if HasAttr(FileName, faReadOnly) then  { if it's read-only... }
      raise EFCantMove.Create(Format(SFCantMove, [FileName])); { we wouldn't be able to delete it }
      CopyFile(PChar(FileName),PChar(Destination),FALSE); { copy it over to destination...}
      If FileExists(Destination) then DeleteFile(PChar(FileName)); { ...and delete the original }
  end;
end;

{ GetFileSize function }
{
  Returns the size of the named file without opening the file.  If the file
  doesn't exist, returns -1.
}

function GetFileSize(const FileName: string): LongInt;
var SearchRec: TSearchRec;
begin
  try
    if FindFirst(ExpandFileName(FileName), faAnyFile, SearchRec) = 0 then
      Result := SearchRec.Size
    else Result := -1;
  finally
    SysUtils.FindClose(SearchRec);
  end;
end;

function FileDateTime(const FileName: string): System.TDateTime;
begin
  Result := FileDateToDateTime(FileAge(FileName));
end;

function HasAttr(const FileName: string; Attr: Word): Boolean;
var FileAttr: Integer;
begin
  FileAttr := FileGetAttr(FileName);
  if FileAttr = -1 then FileAttr := 0;
  Result := (FileAttr and Attr) = Attr;
end;

function ExecuteFile(const FileName, Params, DefaultDir: string;ShowCmd: Integer): THandle;
var zFileName,zParams,zDir: array[0..79] of Char;
begin
  Result := ShellExecute(Application.MainForm.Handle, nil,
            StrPCopy(zFileName, FileName), StrPCopy(zParams, Params),
            StrPCopy(zDir, DefaultDir), ShowCmd);
end;

function  ExtractOnlyFileName(pStr: string): string; //By Laci 1997.6.4.
var I:integer;
begin
  pStr := ExtractFileName(pStr);
  I := Length(pStr);
  While (I>0) and (pStr[I]<>'.') do dec(i);
  If (I>0) then Result := copy(pStr,1,i-1) else Result := pStr;
end;

function WinFNameToDosFName(pFName: string): string;
var mSegment: integer;   mSearchRec: TSearchRec;
    mWinFName, mDosFName: string;  I: integer;
begin
  Result := '';
  If Copy (pFName,Length (pFName),1)='\' then pFName := Copy (pFName,1,Length (pFName)-1);
  mDosFName := pFName;
  If (0 = FindFirst(pFName, faAnyFile, mSearchRec)) then begin
    mSegment := LineElementNum(pFName,'\');
    If (mSegment > 0) then begin
      mWinFName:=LineElement(pFName,0,'\');
      mDosFName:=WToD(mWinFName);
      For i:=1 to mSegment-1 do begin
        mWinFName:=mWinFname+'\'+LineElement(pFName,i,'\');
        mDosFName:=mDosFName+'\'+WToD(mWinFName);
      end;
    end;
  end;
  SysUtils.Findclose(mSearchRec);
  Result:=mDosFName;
end;

function  PathToLastFolder(pPath: string): string; //By Laci 1997.11.26. pl: 'c:\Akarmi\masik\harmadik'  -> 'harmadik'
begin
  Result := '';
  If (pPath = '') then exit;
  If pPath[length(pPath)]='\' then delete(pPath,length(pPath),1);
  If (pPath = '') then exit;
  Result := LineElement(pPath,LineElementNum(pPath, '\')-1,'\');
end;

procedure DeleteFilesInDir (pPath:string);
var mRec:TSearchRec;  mErr:integer;
begin
  mErr := SysUtils.FindFirst (pPath+'*.*', faAnyFile, mRec);
  While mErr = 0 do begin
    If (mRec.Name<>'.') and (mRec.Name<>'..') then  SysUtils.DeleteFile (pPath+mRec.Name);
    mErr := SysUtils.FindNext(mRec);
  end;
  SysUtils.FindClose(mRec);
end;

function  DirIsEmpty(pPath:string):boolean;
var mSR:TSearchRec;
begin
  Result:=TRUE;
  If DirectoryExists(pPath) then begin
    If SysUtils.FindFirst(pPath+'*.*',faAnyFile,mSR)=0 then begin
      Repeat
        If (mSR.Attr and faAnyFile)=mSR.Attr then begin
          If (mSR.Name<>'.') and (mSR.Name<>'..') then Result:=FALSE;
        end;
      until (SysUtils.FindNext(mSR)<>0) or not Result;
      SysUtils.FindClose(mSR);
    end;
  end;
end;

function  GetFileQntInDir (pPath:string):longint;
var
  mRec:TSearchRec;
  mErr:integer;
  mCnt:longint;
begin
  mCnt := 0;
  mErr := SysUtils.FindFirst (pPath+'*.*', faAnyFile, mRec);
  While mErr = 0 do begin
    If (mRec.Attr and faDirectory) = 0 then Inc (mCnt);
    mErr := SysUtils.FindNext(mRec);
  end;
  SysUtils.FindClose(mRec);
  Result := mCnt;
end;

function  GetDirCrtDate (pPath:string):TDateTime;
var
  mSRec:TSearchRec;
  mRes :integer;
begin
  If Copy (pPath,Length (pPath),1)='\' then pPath := Copy (pPath,1,Length (pPath)-1);
  mRes := FindFirst(pPath, faDirectory, mSRec);
  Result := FileDateToDateTime(mSRec.Time);
  SysUtils.FindClose(mSRec);
end;

procedure GetFileList (pMask:TStrings;var pFiles:TStrings;var pSize:longint);
var
  mIORes:longint;
  mSR   :TSearchRec;
  mFound:longint;
  mName :string;
  mCnt  :longint;
begin
  pFiles.Clear;
  pSize := 0;
  If pMask.Count>0 then begin
    mCnt := 0;
    Repeat
      mFound := FindFirst(pMask.Strings[mCnt], faAnyFile, mSR);
      while mFound = 0 do begin
        If (mSR.Attr and faDirectory) = 0 then begin
          pFiles.Add (ExtractFilePath(pMask.Strings[mCnt])+mSR.Name);
          pSize := pSize+mSR.Size;
        end;
        mFound := FindNext(mSR);
      end;
      SysUtils.FindClose(mSR);
      Inc (mCnt);
    until (mCnt>=pMask.Count);
  end;
end;

function  CutFile (pFile,pDPath:string;pSize:longint;var pFileNum:byte;pLFileNum,pLFileName:TLabel):boolean;
var
  mCnt  :longint;
  mSR   :TSearchRec;
  mFound:longint;
  mFSize:longint;
  mFName:string;

  CopyBuffer: Pointer; { buffer For copying }
  BytesCopied: Longint;
  Source, Dest: Integer; { handles }

  mErr:integer;
  mOK :boolean;
const
  ChunkSize: Longint = 1400000;
begin
(*
  mOK := TRUE;
  ChunkSize := pSize;
  mFound := FindFirst(pFile, faAnyFile, mSR);
  mCnt := 0;
  If mFound = 0 then begin
    mFSize := mSR.Size;
    GetMem(CopyBuffer, ChunkSize); { allocate the buffer }
    try
      Source := FileOpen(pFile, fmShareDenyWrite); { open source file }
      If Source < 0 then raise EFOpenError.CreateFmt(SFOpenError, [pFile]);
      try
        repeat
          try
            mFName := pDPath+ExtractOnlyFileName (pFile)+'.Z'+StrIntZero (mCnt,2);
            If pLFileNum<>nil then pLFileNum.Caption := StrInt (mCnt+1,0);
            If pLFileName<>nil then pLFileName.Caption := mFName;
            Dest := FileCreate(mFName); { create output file; overwrite existing }
            If Dest < 0 then raise EFCreateError.CreateFmt(SFCreateError, [mFName]);
            BytesCopied := FileRead(Source, CopyBuffer^, ChunkSize); { read chunk }
            If BytesCopied > 0 then begin{ If we read anything... }
              mErr := FileWrite(Dest, CopyBuffer^, BytesCopied); { ...write chunk }
              If mErr<0 then mOK := FALSE;
              Application.ProcessMessages;
            end;
          finally
            FileClose(Dest); { close the destination file }
          end;
          Inc (mCnt);
        until BytesCopied < ChunkSize; { until we run out of chunks }
      finally
        FileClose(Source); { close the source file }
      end;
    finally
      FreeMem(CopyBuffer, ChunkSize); { free the buffer }
    end;
  end;
  SysUtils.FindClose(mSR);
  pFileNum := 0;
  If mOK and (mCnt<=100) then begin
    pFileNum := mCnt;
  end else mOK := FALSE;
  CutFile := mOK;
*)  
end;

function  WrapFile (pFile,pDPath:string;var pFileNum:byte;pLFileNum,pLFileName:TLabel):boolean;
var mCnt,mFound,mFSize: longint;   mSR: TSearchRec;
    mFName:string;  mErr:integer;  mOK,mExist:boolean;
    CopyBuffer: Pointer; { buffer For copying }
    BytesCopied: Longint;
    Source, Dest: Integer; { handles }
const
  ChunkSize: Longint = 1400000;
begin
(*
  mOK := TRUE;
  mCnt := 0;
  mFName := pDPath+ExtractOnlyFileName (pFile)+'.Z';
  mFound := FindFirst(mFName+'00', faAnyFile, mSR);
  If mFound = 0 then begin
    ChunkSize := mSR.Size;
    GetMem(CopyBuffer, ChunkSize); { allocate the buffer }
    try
      try
       Dest := FileCreate(pFile); { create output file; overwrite existing }
       If Dest < 0 then raise EFCreateError.CreateFmt(SFCreateError, [pFile]);
        repeat
          try
            mExist := FileExists (mFName+StrIntZero (mCnt,2));
            If mExist then begin
              If pLFileNum<>nil then pLFileNum.Caption := StrInt (mCnt+1,0);
              If pLFileName<>nil then pLFileName.Caption := mFName+StrIntZero (mCnt,2);
              Source := FileOpen(mFName+StrIntZero (mCnt,2), fmShareDenyWrite); { open source file }
              If Source < 0 then raise EFOpenError.CreateFmt(SFOpenError, [mFName+StrIntZero (mCnt,2)]);
              BytesCopied := FileRead(Source, CopyBuffer^, ChunkSize); { read chunk }
              If BytesCopied > 0 then begin{ If we read anything... }
                mErr := FileWrite(Dest, CopyBuffer^, BytesCopied); { ...write chunk }
                If mErr<0 then mOK := FALSE;
                Application.ProcessMessages;
              end;
            end;
          finally
            FileClose(Source); { close the source file }
          end;
          Inc (mCnt);
        until (BytesCopied < ChunkSize) or not mExist; { until we run out of chunks }
      finally
        FileClose(Dest); { close the destination file }
      end;
    finally
      FreeMem(CopyBuffer, ChunkSize); { free the buffer }
    end;
  end;
  If mCnt>0 then pFileNum := mCnt;
  SysUtils.FindClose(mSR);
  WrapFile := mOK;
*)  
end;

function GetFirstCDDrive:ShortString;
var mDrv:char;  
begin
  Result := '';
  For mDrv := 'A' to 'Z' do begin
    If GetDriveType(PChar(mDrv+':\'))=DRIVE_CDROM then begin
      Result := mDrv+':\';
      Break;
    end;
  end;
end;

procedure KillFiles(Path: string);
var
  Found:         Integer;
  Attr:          Integer;
  SearchRec:     TSearchRec;
  FileName:      string;
begin
  Attr := faAnyFile;
  Found := FindFirst(Path + '\*.*', Attr, SearchRec);
  while (Found=0) do
  try
    if ((IntToHex(SearchRec.Attr, 8)='00000810')
    or  (IntToHex(SearchRec.Attr, 8)='00000010'))
    and (not (SearchRec.Name[1]='.')) then
    begin
      FileName := Path + '\' + SearchRec.Name;
      RemoveDir(FileName);
      KillFiles(FileName);
    end;
    if (not ((SearchRec.Attr=faDirectory) or (SearchRec.Attr=17))
    and not (SearchRec.Name='.') and not (SearchRec.Name='..')) then
    begin
      FileName := Path + '\' + SearchRec.Name;
      if ((FileGetAttr(FileName) and faReadOnly) > 0) then
        FileSetAttr(FileName, FileGetAttr(FileName) xor faReadOnly);

      if ((FileGetAttr(FileName) and faHidden) > 0) then
        FileSetAttr(FileName, FileGetAttr(FileName) xor faHidden);

      if ((FileGetAttr(FileName) and faSysFile) > 0) then
        FileSetAttr(FileName, FileGetAttr(FileName) xor faSysFile);

      DeleteFile(Pchar(FileName));
      KillFiles(Path);
    end;
    Found := FindNext(SearchRec); //get next file in directory
  except
  end;
  sysutils.FindClose(SearchRec);
end;

procedure DeleteDirectory(dir: string);
var
  fos: TSHFileOpStruct;
  Result: Boolean;
begin
  ZeroMemory(@fos, SizeOf(fos));
  with fos do
  begin
    wFunc := FO_DELETE;
    fFlags := FOF_SILENT or FOF_NOCONFIRMATION;
    pFrom := PChar(dir + #0);
  end;
  Result := (0 = ShFileOperation(fos));
  if DirectoryExists(dir) then
  begin
    ShowMessage('Failed');
  end else begin
    ForceDirectories(dir);
  end;
end;

Function DelTree(DirName : string): Boolean;
var
  SHFileOpStruct : TSHFileOpStruct;
  DirBuf : array [0..255] of char;
begin
  try
   Fillchar(SHFileOpStruct,Sizeof(SHFileOpStruct),0) ;
   FillChar(DirBuf, Sizeof(DirBuf), 0 ) ;
   StrPCopy(DirBuf, DirName) ;
   with SHFileOpStruct do begin
    Wnd := 0;
    pFrom := @DirBuf;
    wFunc := FO_DELETE;
    fFlags := FOF_ALLOWUNDO;
    fFlags := fFlags or FOF_NOCONFIRMATION;
    fFlags := fFlags or FOF_SILENT;
   end;
    Result := (SHFileOperation(SHFileOpStruct) = 0) ;
   except
    Result := False;
  end;
end;

function WinCopyFile(Source, Dest: string): Boolean;
var
   Struct : TSHFileOpStruct;
   Resultval: integer;
begin
   ResultVal := 1;
   try
     Source := Source + #0#0;
     Dest := Dest + #0#0;
     Struct.wnd := 0;
     Struct.wFunc := FO_COPY;
     Struct.pFrom := PChar(Source);
     Struct.pTo := PChar(Dest);
     Struct.fFlags:= FOF_SIMPLEPROGRESS or FOF_NOCONFIRMATION;
     Struct.fAnyOperationsAborted := False;
     Struct.hNameMappings := nil;
     Resultval := ShFileOperation(Struct);
   finally
     Result := (Resultval = 0);
  end;
end;

end.
{
  TSHFileOpStructA = packed record
    Wnd: HWND;
    wFunc: UINT;
    pFrom: PAnsiChar;
    pTo: PAnsiChar;
    fFlags: FILEOP_FLAGS;
    fAnyOperationsAborted: BOOL;
    hNameMappings: Pointer;
    lpszProgressTitle: PAnsiChar;
  end;
  TSHFileOpStruct = TSHFileOpStructA;

Wnd
Handle okna, kde se mají zobrazovat informace o prubehu.

wFunc
Hodnota tohoto parametru urcuje, jaká operace se má provádet.
Lze použít následující ctyri konstanty: FO_COPY, FO_DELETE, FO_MOVE, FO_RENAME.

pFrom
Ukazatel na buffer obsahující názvy souboru, se kterými se má manipulovat.
Každý název souboru je ukoncen znakem #0. Celý seznam je pak ukoncen dvema znaky #0.
Seznam souboru lze také specifikovat pomocí klasické hvezdickové konvence.

pTo
Ve vetšine prípadu je hodnotou tohoto parametru adresár, kam soubory zkopírovat/premístit.
V prípade mazání je tento parametr ignorován. Zajímavou možností je použít vlajku
FOF_MULTIDESTFILES (viz níže) - pak je hodnotou parametru seznam souboru zapsaný ve stejném
formátu jako u pFrom a funkce zkopíruje/prejmenuje soubory z pFrom na soubory na odpovídajících
místech seznamu pTo.

fFlags
Vlajky upresnující provedení operace. Hodnotou je soucet libovolných z následujících konstant:
FOF_ALLOWUNDO      V helpu je napsáno, že použití této vlajky zachovává informaci pro undo.
                   Praktický význam je, že použití této vlajky pri mazání maže soubory do koše,
                   nikoliv prímo z harddisku.
FOF_FILESONLY	   Pokud je v pFrom použita hvezdicková konvence, nezahrnou se do výberu adresáre.
FOF_MULTIDESTFILES Signalizuje, že v pTo je použit seznam souboru místo adresáre.
FOF_NOCONFIRMATION Nezobrazuje žádné potvrzovací dialogy (pri kolizích jmen souboru apod.),
                   automaticky predpokládá odpoved "Ano".
FOF_NOCONFIRMMKDIR Nevyžaduje potvrzení vytvorení nového adresáre.
FOF_NOERRORUI	   Pokud nastane nejaká chyba, nezobrazí se dialog, který o tom inforuje uživatele.
FOF_RENAMEONCOLLISION	Pokud pri kopírování/presunu dojde ke kolizi jmen (tj. cílový soubor už
                   bude existovat), jméno cílového souboru se upraví
                   (napr. v ceských Windiws se pridá predpona "Kopie - ").
FOF_SILENT	   Naní zobrazován dialog s prubehem operace (defaultne zobrazován vždy je!)
FOF_SIMPLEPROGRESS Je zobrazena jen zjednodušená verze dialogu s prubehem operace
                   (nejsou zobrazena jména jednotlivých souboru).
Poznámka 1: Nepopisoval jsem vlajky FOF_CONFIRMMOUSE, FOF_NOCOPYSECURITYATTRIBS a FOF_WANTMAPPINGHANDLE,
protože je velmi pravdepodobne nevyužijete. Jejich popis zájemci najdou v nápovede.

Poznámka 2: Typ FILEOP_FLAGS (tedy typ promenné fFlags) je definován jako Word.

fAnyOperationsAborted
Tato položka je výstupní - po volání funkce je zde hodnota True, pokud uživatel nekterou
z operací preruší kliknutím na tlacítko Storno. Pokud ne, je zde vrácena hodnota False.

hNameMappings
Pravdepodobne nebudete potrebovat. Funkce zde (pokud použijete vlajku FOF_WANTMAPPINGHANDLE)
vrací ve speciálním formátu seznam starých a nových jmen všech souboru

lpszProgressTitle
Nadpis dialogu s prubehem operace. Tento parametr je ignorován, pokud není nastavena
vlajka FOF_SIMPLEPROGRESS.

Co dodat? Že když nespecifikujete v pTo nebo pFrom úplnou cestu k souboru
(tj. zacínající korenovým adresárem), cesta se považuje za relativní vuci aktuálnímu adresári.
Ješte k návratové hodnote: Je rovná nule, pokud vše probehne hladce, nebo ruzná od nuly,
nastane-li pri manipulaci se soubory nejaká chyba.

}
