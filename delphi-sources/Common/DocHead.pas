unit DocHead;
{$F+}
// **************************************************************************
// Objek sluzi na ukldanie hlavickovuch udajov dokladu do textoveho suboru
// Na kompletne ulozenie dokladu do textoveho suboru treba pouzivat aj objekt
// na ukladanie poloziek TDocItem
// **************************************************************************

interface

uses
  IcTypes, IcConv, IcTools, IniFiles, SysUtils, NexPath, NexIni,
  Forms, Classes;

type
  TDocHead = class
    constructor Create;
    destructor  Destroy; override;
    private
      oHeadFile: TStrings;  // Hlavicka dokladu
    public
      procedure LoadFromFile (pFileName:ShortString); // Nacitaudaje zo zadaneho suboru
      procedure WriteString (pFieldName:Str20;pValue:string);
      procedure WriteFloat (pFieldName:Str20;pValue:double);
      procedure WriteDate (pFieldName:Str20;pValue:TDateTime);
      function ReadString (pFieldName:Str20):string;
      function ReadFloat (pFieldName:Str20):double;
      function ReadDate (pFieldName:Str20):TDateTime;
      function FieldExist (pFieldName:Str20):boolean;  // TRUE ak pole existuje
    published
      property HeadFile:TStrings read oHeadFile;
  end;

implementation

constructor TDocHead.Create;
begin
  oHeadFile := TStringList.Create;  // Hlavicka dokladu
end;

destructor TDocHead.Destroy;
begin
  FreeAndNil (oHeadFile);
end;

procedure TDocHead.LoadFromFile (pFileName:ShortString); // Nacitaudaje zo zadaneho suboru
begin
  LoadSectionFromFile (pFileName,'HEAD',oHeadFile);
end;

procedure TDocHead.WriteString (pFieldName:Str20;pValue:string);
begin
  oHeadFile.Add(pFieldName+'='+pValue);
end;

procedure TDocHead.WriteFloat (pFieldName:Str20;pValue:double);
begin
  oHeadFile.Add(pFieldName+'='+StrDoub(pValue,0,5));
end;

procedure TDocHead.WriteDate (pFieldName:Str20;pValue:TDateTime);
begin                                 
  oHeadFile.Add(pFieldName+'='+StrDate(pValue));
end;

function TDocHead.FieldExist (pFieldName:Str20):boolean;  // TRUE ak pole existuje
var mCnt:word; mFind:boolean;  mFieldName:ShortString;
begin
  Result := FALSE;
  If oHeadFile.Count>0 then begin
    mCnt := 0;
    Repeat
      mFieldName := LineElement (oHeadFile.Strings[mCnt],0,'=');
      Result := UpString(mFieldName)=UpString(pFieldName);
      Inc (mCnt);
    until (mCnt=oHeadFile.Count) or Result;
  end;
end;

function TDocHead.ReadString (pFieldName:Str20):string;
var mCnt,mPos:word; mFind:boolean;  mLine,mFieldName:ShortString;
begin
  Result := '';
  If oHeadFile.Count>0 then begin
    mCnt := 0;
    Repeat
      mLine := oHeadFile.Strings[mCnt];
      mFieldName := LineElement (mLine,0,'=');
      mFind := UpString(mFieldName)=UpString(pFieldName);
      If mFind then begin
        mPos := Pos ('=',mLine);
        If mPos>0 then begin
          Delete (mLine,1,mPos);
          Result := mLine;
        end;
      end;
      Inc (mCnt);
    until (mCnt=oHeadFile.Count) or mFind;
  end;
end;

function TDocHead.ReadFloat (pFieldName:Str20):double;
begin
  Result := ValDoub (ReadString(pFieldName));
end;

function TDocHead.ReadDate (pFieldName:Str20):TDateTime;
begin
  //Mozno bude treba spravit vlstu procedure ValDate
  Result := StrToDate(ReadString(pFieldName));
end;

// **************************** PRIVATE **************************

end.
