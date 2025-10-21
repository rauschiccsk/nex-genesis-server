unit EncodeIni;

interface

  uses
//    IcConv, IcTools,
    Dialogs, BaseUtils, BaseTools, BasUtilsTCP,
//    IniFiles,
    Classes, SysUtils, DateUtils;

  type


  TFileDataInfo = record
    FileName:string;
    FileDate:TDateTime;
    FileSize:longint;
    Describe:string;
  end;

  PPHashItem = ^PHashItem;
  PHashItem = ^THashItem;
  THashItem = record
    Next: PHashItem;
    Key: string;
    Value: Integer;
  end;
  
  TStringHash = class
  private
    Buckets: array of PHashItem;
  protected
    function Find(const Key: string): PPHashItem;
    function HashOf(const Key: string): Cardinal; virtual;
  public
    constructor Create(Size: Integer = 256);
    destructor Destroy; override;
    procedure Add(const Key: string; Value: Integer);
    procedure Clear;
    procedure Remove(const Key: string);
    function Modify(const Key: string; Value: Integer): Boolean;
    function ValueOf(const Key: string): Integer;
  end;


  THashedStringList = class(TStringList)
  private
    FValueHash: TStringHash;
    FNameHash: TStringHash;
    FValueHashValid: Boolean;
    FNameHashValid: Boolean;
    procedure UpdateValueHash;
    procedure UpdateNameHash;
  protected
    procedure Changed; override;
  public
    destructor Destroy; override;
    function IndexOf(const S: string): Integer; override;
    function IndexOfName(const Name: string): Integer; override;
  end;

  TEncodeIniFile = class(TObject)
  private
    FFileName: string;
    FSections: TStringList;
    FAutoSave: boolean;
    FEncode  : boolean;

    oTextFile : TextFile;
    oOpenFile : boolean;
    oReadOnly : boolean;
    oModified : boolean;
    oShowErr  : boolean;
    oOpenDelay: longint;

    function AddSection(const Section: string): TStrings;
    function GetCaseSensitive: Boolean;
    procedure SetCaseSensitive(Value: Boolean);
    procedure LoadValues;
    procedure MyOpenFile (pOpenRead, pRecreate:boolean; var pErr:longint);
    procedure MyCloseFile;
  public
    constructor Create(const FileName: string; pAutoSave:boolean); overload;
    constructor Create(const FileName: string; pAutoSave, pReadOnly:boolean; pOpenDelay:longint; var pErr:longint); overload;
    destructor  Destroy; override;

    procedure Clear;
    function SectionExists(const Section: string): Boolean;
    function ReadString(const Section, Ident, Default: string): string;
    procedure WriteString(const Section, Ident, Value: string);
    function ReadInteger(const Section, Ident: string; Default: Longint): Longint; virtual;
    procedure WriteInteger(const Section, Ident: string; Value: Longint); virtual;
    function ReadBool(const Section, Ident: string; Default: Boolean): Boolean; virtual;
    procedure WriteBool(const Section, Ident: string; Value: Boolean); virtual;
    function ReadFloat(const Section, Name: string; Default: Double): Double; virtual;
    procedure WriteFloat(const Section, Name: string; Value: Double); virtual;
    function ReadDate(const Section, Name: string; Default: TDateTime): TDateTime; virtual;
    procedure WriteDate(const Section, Name: string; Value: TDateTime); virtual;
    function ReadDateTime(const Section, Name: string; Default: TDateTime): TDateTime; virtual;
    procedure WriteDateTime(const Section, Name: string; Value: TDateTime); virtual;
    function ReadTime(const Section, Name: string; Default: TDateTime): TDateTime; virtual;
    procedure WriteTime(const Section, Name: string; Value: TDateTime); virtual;
    function ReadBinaryStream(const Section, Name: string; Value: TStream): Integer; virtual;
    procedure WriteBinaryStream(const Section, Name: string; Value: TStream); virtual;

    function  ReadFileDataToStream(const Section, Name: string; var pFileName: string; var Value: TStringStream):boolean; virtual;
    function  SaveFileData (Section, Name, pPath: string):boolean; overload;
    function  SaveFileData (Section, Name, pPath, pNewName: string):boolean; overload;
    function  WriteFileData (const Section, Name, pFile: string):boolean; overload;
    function  WriteFileData (const Section, Name, pFile, pDescr: string):boolean; overload;
    function  WriteFileData (const Section, Name, pFile, pDescr: string; pDate:TDateTime):boolean; overload;
    function  GetFileDataInfo (const Section, Name:string; var pFileDataInfo:TFileDataInfo):boolean;

    procedure ReadSection(const Section: string; Strings: TStrings);
    procedure ReadSections(Strings: TStrings);
    procedure ReadSectionValues(const Section: string; Strings: TStrings);
    procedure EraseSection(const Section: string);
    procedure DeleteKey(const Section, Ident: String);
    procedure SaveFile;
    function  ValueExists(const Section, Ident: string): Boolean;

    procedure SetStrings(List: TStrings);
    procedure GetStrings(List: TStrings);

    property  FileName:string read FFileName;
    property  Encode:boolean read FEncode write FEncode;
    property  CaseSensitive:boolean read GetCaseSensitive write SetCaseSensitive;
  end;

implementation

{ TStringHash }

procedure TStringHash.Add(const Key: string; Value: Integer);
var
  Hash: Integer;
  Bucket: PHashItem;
begin
  Hash := HashOf(Key) mod Cardinal(Length(Buckets));
  New(Bucket);
  Bucket^.Key := Key;
  Bucket^.Value := Value;
  Bucket^.Next := Buckets[Hash];
  Buckets[Hash] := Bucket;
end;

procedure TStringHash.Clear;
var
  I: Integer;
  P, N: PHashItem;
begin
  for I := 0 to Length(Buckets) - 1 do
  begin
    P := Buckets[I];
    while P <> nil do
    begin
      N := P^.Next;
      Dispose(P);
      P := N;
    end;
    Buckets[I] := nil;
  end;
end;

constructor TStringHash.Create(Size: Integer);
begin
  inherited Create;
  SetLength(Buckets, Size);
end;

destructor TStringHash.Destroy;
begin
  Clear;
  inherited;
end;

function TStringHash.Find(const Key: string): PPHashItem;
var
  Hash: Integer;
begin
  Hash := HashOf(Key) mod Cardinal(Length(Buckets));
  Result := @Buckets[Hash];
  while Result^ <> nil do
  begin
    if Result^.Key = Key then
      Exit
    else
      Result := @Result^.Next;
  end;
end;

function TStringHash.HashOf(const Key: string): Cardinal;
var
  I: Integer;
begin
  Result := 0;
  for I := 1 to Length(Key) do
    Result := ((Result shl 2) or (Result shr (SizeOf(Result) * 8 - 2))) xor
      Ord(Key[I]);
end;

function TStringHash.Modify(const Key: string; Value: Integer): Boolean;
var
  P: PHashItem;
begin
  P := Find(Key)^;
  if P <> nil then
  begin
    Result := True;
    P^.Value := Value;
  end
  else
    Result := False;
end;

procedure TStringHash.Remove(const Key: string);
var
  P: PHashItem;
  Prev: PPHashItem;
begin
  Prev := Find(Key);
  P := Prev^;
  if P <> nil then
  begin
    Prev^ := P^.Next;
    Dispose(P);
  end;
end;

function TStringHash.ValueOf(const Key: string): Integer;
var
  P: PHashItem;
begin
  P := Find(Key)^;
  if P <> nil then
    Result := P^.Value else
    Result := -1;
end;

{ THashedStringList }

procedure THashedStringList.Changed;
begin
  inherited;
  FValueHashValid := False;
  FNameHashValid := False;
end;

destructor THashedStringList.Destroy;
begin
  FValueHash.Free;
  FNameHash.Free;
  inherited;
end;

function THashedStringList.IndexOf(const S: string): Integer;
begin
  UpdateValueHash;
  if not CaseSensitive then
    Result :=  FValueHash.ValueOf(AnsiUpperCase(S))
  else
    Result :=  FValueHash.ValueOf(S);
end;

function THashedStringList.IndexOfName(const Name: string): Integer;
begin
  UpdateNameHash;
  if not CaseSensitive then
    Result := FNameHash.ValueOf(AnsiUpperCase(Name))
  else
    Result := FNameHash.ValueOf(Name);
end;

procedure THashedStringList.UpdateNameHash;
var
  I: Integer;
  P: Integer;
  Key: string;
begin
  if FNameHashValid then Exit;
  if FNameHash = nil then
    FNameHash := TStringHash.Create
  else
    FNameHash.Clear;
  for I := 0 to Count - 1 do
  begin
    Key := Get(I);
    P := AnsiPos('=', Key);
    if P <> 0 then
    begin
      if not CaseSensitive then
        Key := AnsiUpperCase(Copy(Key, 1, P - 1))
      else
        Key := Copy(Key, 1, P - 1);
      FNameHash.Add(Key, I);
    end;
  end;
  FNameHashValid := True;
end;

procedure THashedStringList.UpdateValueHash;
var
  I: Integer;
begin
  if FValueHashValid then Exit;
  if FValueHash = nil then
    FValueHash := TStringHash.Create
  else
    FValueHash.Clear;
  for I := 0 to Count - 1 do
    if not CaseSensitive then
      FValueHash.Add(AnsiUpperCase(Self[I]), I)
    else
      FValueHash.Add(Self[I], I);
  FValueHashValid := True;
end;

{ TEncodeIniFile }

function TEncodeIniFile.AddSection(const Section: string): TStrings;
begin
  Result := THashedStringList.Create;
  try
    THashedStringList(Result).CaseSensitive := CaseSensitive;
    FSections.AddObject(Section, Result);
  except
    Result.Free;
    raise;
  end;
end;

function TEncodeIniFile.GetCaseSensitive: Boolean;
begin
  Result := FSections.CaseSensitive;
end;

procedure TEncodeIniFile.SetCaseSensitive(Value: Boolean);
var I: Integer;
begin
  If Value <> FSections.CaseSensitive then begin
    FSections.CaseSensitive := Value;
    For I := 0 to FSections.Count - 1 do begin
      With THashedStringList(FSections.Objects[I]) do begin
        CaseSensitive := Value;
        Changed;
      end;
    end;
    THashedStringList(FSections).Changed;
  end;
end;

procedure TEncodeIniFile.LoadValues;
var List: TStringList; mS,mSTrg:string; I, mErr:longint;
begin
  oModified := FALSE;
  If oOpenFile then begin
    If (FileName <> '') and FileExists(FileName) then begin
      List := TStringList.Create;
      try
  //      List.LoadFromFile(FileName);
        MyCloseFile;
        MyOpenFile(TRUE, FALSE, mErr);
        If mErr=0 then begin
          Repeat
            {$I-} ReadLn (oTextFile, mS); {$I+} mErr := IOResult;
            If mErr=0 then List.Add (mS);
          until Eof (oTextFile) or (mErr<>0);
          If mErr=0 then begin
            MyCloseFile;
            MyOpenFile(oReadOnly, FALSE, mErr);
          end;
          mS := '';
          If Copy (List.Text,1,3)='EIF' then begin
            mSTrg := List.Text;
            Delete (mSTrg,1,3);
            mS := '';
            For I:=1 to Length (mSTrg) do
              mS := mS+Chr (Ord(mSTrg[I])-5);
            List.Text := mS;
          end;
          SetStrings(List);
        end else begin
          Clear;
          If mErr<>0 then MessageDlg('Nie je moûnÈ otvoriù s˙bor:'+#13+FFileName+#13+'Chyba: '+StrInt (mErr,0), mtError, [mbOk], 0);
        end;
      finally
        List.Free;
      end;
    end else Clear;
  end else begin
    Clear;
  end;
end;

procedure TEncodeIniFile.MyOpenFile (pOpenRead, pRecreate:boolean; var pErr:longint);
var mTime:TDateTime; mCnt:longint;
begin
  pErr := 0;
  AssignFile (oTextFile, FFileName);
  mTime := IncMilliSecond (Now, oOpenDelay);
  mCnt := 0;
  Repeat
    {$I-}
    If pOpenRead then begin
      Reset (oTextFile);
    end else begin
      If pRecreate then begin
        Rewrite (oTextFile);
      end else begin
        If FileExists(FFileName)
          then Append (oTextFile)
          else Rewrite (oTextFile);
      end;
    end;
    {$I+} pErr := IOResult;
    If pErr>0 then Wait (10);
    Inc (mCnt);
  until (pErr=0) or (Now>mTime);
  oOpenFile := (pErr=0);
end;

procedure TEncodeIniFile.MyCloseFile;
var mErr:longint;
begin
  {$I-} CloseFile (oTextFile); {$I+} mErr := IOResult;
  oOpenFile := FALSE;
end;

constructor TEncodeIniFile.Create(const FileName: string; pAutoSave:boolean);
var mErr:longint;
begin
  Create (FileName, pAutoSave, FALSE, 30000, mErr);
  oShowErr := TRUE;
  If mErr<>0 then MessageDlg('Nie je moûnÈ otvoriù s˙bor:'+#13+FFileName+#13+'Chyba: '+StrInt (mErr,0), mtError, [mbOk], 0);
end;

constructor TEncodeIniFile.Create(const FileName: string; pAutoSave, pReadOnly:boolean; pOpenDelay:longint; var pErr:longint);
begin
  oShowErr := FALSE;
  FFileName := FileName;
  FSections := THashedStringList.Create;
  FAutoSave := pAutoSave;
  FEncode := TRUE;
  oReadOnly := pReadOnly;
  oOpenDelay := pOpenDelay;
  MyOpenFile (oReadOnly, FALSE, pErr);
  LoadValues;
end;

destructor TEncodeIniFile.Destroy;
begin
  If oModified then SaveFile;
  If FSections <> nil then Clear;
  FSections.Free;
  If oOpenFile then MyCloseFile;
  inherited;
end;

procedure TEncodeIniFile.Clear;
var
  I: Integer;
begin
  For I := 0 to FSections.Count - 1 do
    TObject(FSections.Objects[I]).Free;
  FSections.Clear;
end;

function TEncodeIniFile.SectionExists(const Section: string): Boolean;
var S: TStrings;
begin
  S := TStringList.Create;
  try
    ReadSection(Section, S);
    Result := S.Count > 0;
  finally
    S.Free;
  end;
end;

function TEncodeIniFile.ReadString(const Section, Ident, Default: string): string;
var
  I: Integer;
  Strings: TStrings;
begin
  Result := Default;
  I := FSections.IndexOf(Section);
  If I >= 0 then begin
    Strings := TStrings(FSections.Objects[I]);
    I := Strings.IndexOfName(Ident);
    If I >= 0 then begin
      Result := Copy(Strings[I], Length(Ident) + 2, Maxint);
    end;
  end;
  If (I=-1) and FAutoSave then WriteString(Section,Ident,Default);
end;

procedure TEncodeIniFile.WriteString(const Section, Ident, Value: String);
var
  I: Integer;
  S: string;
  mSList: TStrings;
begin
  oModified := TRUE;
  I := FSections.IndexOf(Section);
  If I >= 0
    then mSList := TStrings(FSections.Objects[I])
    else mSList := AddSection(Section);
  S := Ident + '=' + Value;
  I := mSList.IndexOfName(Ident);
  If I >= 0 then mSList[I] := S else mSList.Add(S);
end;

function TEncodeIniFile.ReadInteger(const Section, Ident: string; Default: Longint): Longint;
var IntStr: string;
begin
  If not ValueExists(Section, Ident) and FAutoSave then WriteInteger (Section,Ident,Default);
  IntStr := ReadString(Section, Ident, '');
  If (Length(IntStr) > 2) and (IntStr[1] = '0') and ((IntStr[2] = 'X') or (IntStr[2] = 'x'))
    then IntStr := '$' + Copy(IntStr, 3, Maxint);
  Result := StrToIntDef(IntStr, Default);
end;

procedure TEncodeIniFile.WriteInteger(const Section, Ident: string; Value: Longint);
begin
  WriteString(Section, Ident, IntToStr(Value));
end;

function TEncodeIniFile.ReadBool(const Section, Ident: string;
  Default: Boolean): Boolean;
begin
  If not ValueExists(Section, Ident) and FAutoSave then WriteBool (Section,Ident,Default);
  Result := ReadInteger(Section, Ident, Ord(Default)) <> 0;
end;

procedure TEncodeIniFile.WriteBool(const Section, Ident: string; Value: Boolean);
const
  Values: array[Boolean] of string = ('0', '1');
begin
  WriteString(Section, Ident, Values[Value]);
end;

function TEncodeIniFile.ReadFloat(const Section, Name: string; Default: Double): Double;
var
  FloatStr: string;
begin
  If not ValueExists(Section, Name) and FAutoSave then WriteFloat (Section,Name,Default);
  FloatStr := ReadString(Section, Name, '');
  Result := Default;
  if FloatStr <> '' then
  try
    Result := ValDoub(FloatStr);
  except
    on EConvertError do
    else raise;
  end;
end;

procedure TEncodeIniFile.WriteFloat(const Section, Name: string; Value: Double);
begin
  WriteString(Section, Name, StrDoub(Value,0,2));
end;

function TEncodeIniFile.ReadDate(const Section, Name: string; Default: TDateTime): TDateTime;
var
  DateStr: string;
begin
  If not ValueExists(Section, Name) and FAutoSave then WriteDate (Section,Name,Default);
  DateStr := ReadString(Section, Name, '');
  Result := Default;
  if DateStr <> '' then
  try
    Result := StrToDate(DateStr);
  except
    on EConvertError do
    else raise;
  end;
end;

procedure TEncodeIniFile.WriteDate(const Section, Name: string; Value: TDateTime);
begin
  WriteString(Section, Name, DateToStr(Value));
end;

function TEncodeIniFile.ReadDateTime(const Section, Name: string; Default: TDateTime): TDateTime;
var
  DateStr: string;
begin
  If not ValueExists(Section, Name) and FAutoSave then WriteDateTime (Section,Name,Default);
  DateStr := ReadString(Section, Name, '');
  Result := Default;
  if DateStr <> '' then
  try
    Result := StrToDateTime(DateStr);
  except
    on EConvertError do
    else raise;
  end;
end;

procedure TEncodeIniFile.WriteDateTime(const Section, Name: string; Value: TDateTime);
begin
  WriteString(Section, Name, DateTimeToStr(Value));
end;

function TEncodeIniFile.ReadTime(const Section, Name: string; Default: TDateTime): TDateTime;
var
  TimeStr: string;
begin
  If not ValueExists(Section, Name) and FAutoSave then WriteTime (Section,Name,Default);
  TimeStr := ReadString(Section, Name, '');
  Result := Default;
  if TimeStr <> '' then
  try
    Result := StrToTime(TimeStr);
  except
    on EConvertError do
    else raise;
  end;
end;

procedure TEncodeIniFile.WriteTime(const Section, Name: string; Value: TDateTime);
begin
  WriteString(Section, Name, TimeToStr(Value));
end;

function TEncodeIniFile.ReadBinaryStream(const Section, Name: string;
  Value: TStream): Integer;
var
  Text: string;
  Stream: TMemoryStream;
  Pos: Integer;
begin
  Text := ReadString(Section, Name, '');
  if Text <> '' then
  begin
    if Value is TMemoryStream then
      Stream := TMemoryStream(Value)
    else Stream := TMemoryStream.Create;
    try
      Pos := Stream.Position;
      Stream.SetSize(Stream.Size + Length(Text) div 2);
      HexToBin(PChar(Text), PChar(Integer(Stream.Memory) + Stream.Position), Length(Text) div 2);
      Stream.Position := Pos;
      if Value <> Stream then Value.CopyFrom(Stream, Length(Text) div 2);
      Result := Stream.Size - Pos;
    finally
      if Value <> Stream then Stream.Free;
    end;
  end else Result := 0;
end;

procedure TEncodeIniFile.WriteBinaryStream(const Section, Name: string;
  Value: TStream);
var
  Text: string;
  Stream: TMemoryStream;
begin
  SetLength(Text, (Value.Size - Value.Position) * 2);
  if Length(Text) > 0 then
  begin
    if Value is TMemoryStream then
      Stream := TMemoryStream(Value)
    else Stream := TMemoryStream.Create;
    try
      if Stream <> Value then
      begin
        Stream.CopyFrom(Value, Value.Size - Value.Position);
        Stream.Position := 0;
      end;
      BinToHex(PChar(Integer(Stream.Memory) + Stream.Position), PChar(Text),
        Stream.Size - Stream.Position);
    finally
      if Value <> Stream then Stream.Free;
    end;
  end;
  WriteString(Section, Name, Text);
end;


function  TEncodeIniFile.ReadFileDataToStream(const Section, Name: string; var pFileName: string; var Value: TStringStream):boolean;
var mS:string;
begin
  Result:=FALSE;
  mS:=ReadString(Section, Name,'');
  pFileName:=LineElement(mS,0,';');
  mS:=DecodeB64(LineElement(mS,4,';'),0);
  If mS<>'' then begin
    Value:=TStringStream.Create(mS);
    Result:=TRUE;
  end;
end;

function  TEncodeIniFile.SaveFileData (Section, Name, pPath: string):boolean;
begin
  Result:=SaveFileData (Section, Name, pPath, '');
end;

function  TEncodeIniFile.SaveFileData (Section, Name, pPath, pNewName: string):boolean;
var mS:string; mFileDate:TDateTime; mT:TextFile; mRes:longint;
begin
  Result:=FALSE;
  mS:=ReadString(Section, Name,'');
  If pNewName='' then pNewName:=LineElement(mS,0,';');
  mFileDate:=Now;
  If LineElement(mS,1,';')<>'' then mFileDate:=ArraySToFloat(DecodeB64(LineElement(mS,1,';'),0));
  mS:=DecodeB64(LineElement(mS,4,';'),0);
  If mS<>'' then begin
    If not DirectoryExists(pPath) then ForceDirectories(pPath);
    If DirectoryExists(pPath) then begin
      AssignFile (mT, pPath+pNewName);
      {$I-} Rewrite (mT); {$I+} mRes := IOResult;
      If mRes=0 then begin
        {$I-} Write (mT, mS); {$I+} mRes := IOResult;
        Result:=(mRes=0);
      end;
      {$I-} CloseFile (mT); {$I+} mRes := IOResult;
      If Result then FileSetDate(pPath+pNewName, DateTimeToFileDate(mFileDate));
    end;
  end;
end;

function  TEncodeIniFile.WriteFileData (const Section, Name, pFile: string):boolean;
begin
  Result:=WriteFileData (Section, Name, pFile, '');
end;

function  TEncodeIniFile.WriteFileData (const Section, Name, pFile, pDescr: string):boolean;
var mFileDate:TDateTime;
begin
  mFileDate:=FileDateToDateTime(FileAge(pFile));
  Result:=WriteFileData (Section, Name, pFile, pDescr, mFileDate);
end;

function  TEncodeIniFile.WriteFileData (const Section, Name, pFile, pDescr: string; pDate:TDateTime):boolean;
var mS,mFileData:string; mStream:TFileStream; mLen,mALen,J:longint; mCh:array [1..100000] of char;
begin
  Result := FALSE;
  If FileExists(pFile) then begin
    mS:=''; mFileData:='';
    try
      mStream:=TFileStream.Create(pFile, fmOpenRead);
      mLen:=mStream.Size-1;
      mALen:=100000;
      Repeat
        If mLen-mStream.Position<mALen then mALen:=mLen-mStream.Position+1;
        mStream.Read(mCh, mALen);
        For J:=1 to mALen do begin
          mFileData:=mFileData+mCh[J];
        end;
      until mStream.Position>=mLen;
      FreeAndNil (mStream);
      mFileData:=EncodeB64(mFileData,0);
      mS:=ExtractFileName(pFile)+';'+EncodeB64(FloatToArrayS(pDate),0)+';'+StrInt(mLen+1,0)+';'+EncodeB64(pDescr,0)+';'+mFileData;
      WriteString(Section, Name, mS);
    except end;
  end;
end;

function  TEncodeIniFile.GetFileDataInfo (const Section, Name:string; var pFileDataInfo:TFileDataInfo):boolean;
var mS:string; mFileDate:TDateTime;
begin
  Result:=FALSE;
  pFileDataInfo.FileName:='';
  pFileDataInfo.FileDate:=0;
  pFileDataInfo.FileSize:=0;
  pFileDataInfo.Describe:='';
  mS:=ReadString(Section, Name,'');
  If mS<>'' then begin
    pFileDataInfo.FileName:=LineElement(mS,0,';');
    If LineElement(mS,1,';')<>'' then pFileDataInfo.FileDate:=ArraySToFloat(DecodeB64(LineElement(mS,1,';'),0));
    pFileDataInfo.FileSize:=ValInt(LineElement(mS,2,';'));
    pFileDataInfo.Describe:=LineElement(mS,3,';');
    Result:=(pFileDataInfo.FileName<>'') and (Length (LineElement(mS,4,';'))>0);
  end;
end;

procedure TEncodeIniFile.ReadSection(const Section: string; Strings: TStrings);
var
  I, J: Integer;
  SectionStrings: TStrings;
begin
  Strings.BeginUpdate;
  try
    Strings.Clear;
    I := FSections.IndexOf(Section);
    If I >= 0 then begin
      SectionStrings := TStrings(FSections.Objects[I]);
      For J := 0 to SectionStrings.Count - 1 do
        Strings.Add(SectionStrings.Names[J]);
    end;
  finally
    Strings.EndUpdate;
  end;
end;

procedure TEncodeIniFile.ReadSections(Strings: TStrings);
begin
  Strings.Assign(FSections);
end;

procedure TEncodeIniFile.ReadSectionValues(const Section: string;
  Strings: TStrings);
var
  I: Integer;
begin
  Strings.BeginUpdate;
  try
    Strings.Clear;
    I := FSections.IndexOf(Section);
    if I >= 0 then Strings.Assign(TStrings(FSections.Objects[I]));
  finally
    Strings.EndUpdate;
  end;
end;

procedure TEncodeIniFile.EraseSection(const Section: string);
var
  I: Integer;
begin
  I := FSections.IndexOf(Section);
  if I >= 0 then begin
    TStrings(FSections.Objects[I]).Free;
    FSections.Delete(I);
    oModified := TRUE;
  end;
end;

procedure TEncodeIniFile.DeleteKey(const Section, Ident: String);
var
  I, J: Integer;
  Strings: TStrings;
begin
  I := FSections.IndexOf(Section);
  If I >= 0 then begin
    Strings := TStrings(FSections.Objects[I]);
    J := Strings.IndexOfName(Ident);
    If J >= 0 then begin
      Strings.Delete(J);
      oModified := TRUE;
    end;
  end;
end;

procedure TEncodeIniFile.SaveFile;
var List: TStringList; mS,mSTrg:string; I,mErr:longint;
begin
  If oOpenFile then begin
    If not oReadOnly then begin
      oModified := FALSE;
      List := TStringList.Create;
      try
        GetStrings(List);
        If FEncode then begin
          mS := ''; mSTrg := List.Text;
          For I:=1 to Length (mSTrg) do
            mS := mS+Chr (Ord(mSTrg[I])+5);
          List.Text := 'EIF'+mS;
        end;
    //    List.SaveToFile(FFileName);
        MyCloseFile;
        MyOpenFile(FALSE, TRUE, mErr);
        If mErr=0 then begin
          {$I-} Write (oTextFile, List.Text); {$I+} mErr := IOResult;
          If mErr<>0 then begin
            MessageDlg('Chyba pri uloûenÌ d·t do s˙boru:'+#13+FFileName+#13+'Chyba: '+StrInt (mErr,0), mtError, [mbOk], 0)
          end else begin
            MyCloseFile;
            MyOpenFile(FALSE, FALSE, mErr);
          end;
        end else begin
          MessageDlg('Nie je moûnÈ otvoriù s˙bor:'+#13+FFileName+#13+'Chyba: '+StrInt (mErr,0), mtError, [mbOk], 0);
        end;
      finally
        List.Free;
      end;
    end else begin
      MessageDlg('S˙bor:'+#13+FFileName+#13+'nie je otvor˝ na z·pis.'+#13+'Chyba: '+StrInt (mErr,0), mtError, [mbOk], 0);
    end;
  end;
end;

function TEncodeIniFile.ValueExists(const Section, Ident: string): Boolean;
var S: TStrings;
begin
  S := TStringList.Create;
  try
    ReadSection(Section, S);
    Result := S.IndexOf(Ident) > -1;
  finally
    S.Free;
  end;
end;

procedure TEncodeIniFile.SetStrings(List: TStrings);
var
  I, J: Integer;
  S: string;
  Strings: TStrings;
begin
  Clear;
  Strings := nil;
  For I := 0 to List.Count - 1 do begin
    S := Trim(List[I]);
    If (S <> '') and (S[1] <> ';') then begin
      If (S[1] = '[') and (S[Length(S)] = ']') then begin
        Delete(S, 1, 1);
        SetLength(S, Length(S)-1);
        Strings := AddSection(Trim(S));
      end else begin
        If Strings <> nil then begin
          J := Pos('=', S);
          If J > 0 // remove spaces before and after '='
            then Strings.Add(Trim(Copy(S, 1, J-1)) + '=' + Trim(Copy(S, J+1, MaxInt)) )
            else Strings.Add(S);
        end;
      end;
    end;
  end;
end;

procedure TEncodeIniFile.GetStrings(List: TStrings);
var
  I, J: Integer;
  Strings: TStrings;
begin
  List.BeginUpdate;
  try
    for I := 0 to FSections.Count - 1 do
    begin
      List.Add('[' + FSections[I] + ']');
      Strings := TStrings(FSections.Objects[I]);
      for J := 0 to Strings.Count - 1 do List.Add(Strings[J]);
//      List.Add('');
    end;
  finally
    List.EndUpdate;
  end;
end;

end.
