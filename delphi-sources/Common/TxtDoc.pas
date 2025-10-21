unit TxtDoc;
{$F+}

interface

uses
  IcTypes, IcConv, IcTools, IniFiles, SysUtils, NexPath, NexIni,
  TxtWrap, TxtCut, StkCanc, DocHand, NexMsg, NexError,
  Forms, Classes;

type
  TTxtDoc = class
    constructor Create;
    destructor  Destroy;
    private
      oItemActiv: boolean; // Ak je TRUE potom system pracuje  s polozkami dokladu
      oFieldCount: word;   // Pocet poli poloziek dokladu
      oItemCount: word; // Pocet poloziek dokladu
      oItemPos: word; // Poradove cilo polozky na ktorom stoji kurzor objektu
      oNotiCount: word;
      oHeadFile: TMemIniFile;  // Hlavicka dokladu
      oDescFile: TMemIniFile;  // Popis struktury poloziek
      oNotiFile: TStrings;  // Poznamky k dokladu
      oItemFile: TStrings;  // Polozky dokladu
      oTranFile: TStrings;  // Kompletny subor - obsahuve HEAD, NOTI, DESC, ITEM
      oItemWrap: TTxtWrap;
      oItemCut: TTxtCut;
      oEof: boolean;  // TRUE ak sme na konci suboru poloziek dokladu

      procedure LoadSection (pSection:Str20; var pStrings:TStrings); // premiestni zo suboru oTranFile zadanu sekciu do pStrings
      procedure SaveFieldName (pFieldName:Str20); // Ulozi nazov pola do popisoveje sekcie oDescFile
      function GetFieldNum (pFieldName:Str20):word; // Vyhlada poradove cislo pola na zaklade jeho mena
    public
      procedure WriteNoti (pNotType:Str1;pLinNum:word;pNotice:string);
      procedure WriteString (pFieldName:Str20;pValue:string);
      procedure WriteInteger (pFieldName:Str20;pValue:integer);
      procedure WriteFloat (pFieldName:Str20;pValue:double);
      procedure WriteBool (pFieldName:Str20;pValue:boolean);
      procedure WriteDate (pFieldName:Str20;pValue:TDateTime);
      procedure WriteTime (pFieldName:Str20;pValue:TDateTime);

      procedure ReadNoti (pItem:word;var pNotType:Str1; var pLinNum:word;  var pNotice:string);
      function FieldNameExist (pFieldName:Str20):boolean;
      function ReadString (pFieldName:Str20):string;
      function ReadInteger (pFieldName:Str20):integer;
      function ReadFloat (pFieldName:Str20):double;
      function ReadBool (pFieldName:Str20):boolean;
      function ReadDate (pFieldName:Str20):TDateTime;
      function ReadTime (pFieldName:Str20):TDateTime;

      // Funkcie na pracovanie s polozkami dokladu
      procedure Insert;
      procedure Post;
      procedure First;
      procedure Last;
      procedure Next;

      procedure SaveToFile (pFileName:string);  // Ulozi zadany doklad do textoveho suboru
      procedure LoadFromFile (pFileName:string);  // Nacita doklad z textoveho suboru
      procedure SetDelimiter (pDelimiter:Str1); // Nastavi hranicny znak pre polozky dokladu
      procedure SetSeparator (pSeparator:Str1); // Nastavi oddelovaci znak pre polozky dokladu
    published
      property ItemCount:word read oItemCount;
      property NotiCount:word read oNotiCount;
      property Eof:boolean read oEof;
  end;

implementation

uses
   DM_STKDAT;

constructor TTxtDoc.Create;
begin
  oItemActiv := FALSE;
  oItemCount := 0;
  oNotiCount := 0;
  oFieldCount := 0;
  oHeadFile := TMemIniFile.Create('DOCHEAD.TXT');  // Hlavicka dokladu
  oDescFile := TMemIniFile.Create('DOCDESC.TXT');  // Struktura poloziek
  oNotiFile := TStringList.Create;  // Poznamky k dokladu
  oItemFile := TStringList.Create;
  oItemWrap := TTxtWrap.Create;
  oItemCut := TTxtCut.Create;
end;

destructor TTxtDoc.Destroy;
begin
  FreeAndNil (oItemCut);
  FreeAndNil (oItemWrap);
  FreeAndNil (oNotiFile);
  FreeAndNil (oItemFile);
  FreeAndNil (oDescFile);
  FreeAndNil (oHeadFile);
end;

procedure TTxtDoc.Insert;
begin
  Inc (oItemCount);
  oItemActiv := TRUE;
  oItemWrap.ClearWrap;
end;

procedure TTxtDoc.Post;
begin
  oItemActiv := FALSE;
  oItemFile.Add (oItemWrap.GetWrapText);
end;

procedure TTxtDoc.First;
begin
  oItemActiv := TRUE;
  oItemPos := 1;
  oItemCut.SetStr (oItemFile.Strings[oItemPos]);
end;

procedure TTxtDoc.Last;
begin
  oItemActiv := TRUE;
  oItemPos := oItemFile.Count-1;
  oItemCut.SetStr (oItemFile.Strings[oItemPos]);
end;

procedure TTxtDoc.Next;
begin
  If oItemPos<oItemFile.Count-1 then begin
    oEof := False;
    Inc (oItemPos);
    oItemCut.SetStr (oItemFile.Strings[oItemPos]);
  end
  else oEof := TRUE;
end;

procedure TTxtDoc.WriteNoti (pNotType:Str1;pLinNum:word;pNotice:string);
var mWrap:TTxtWrap;
begin
  Inc (oNotiCount);
  mWrap := TTxtWrap.Create;
  mWrap.ClearWrap;
  mWrap.SetText(pNotType,0);
  mWrap.SetNum(pLinNum,0);
  mWrap.SetText(pNotice,0);
  oNotiFile.Add (mWrap.GetWrapText);
  FreeAndNil (mWrap);
end;

procedure TTxtDoc.WriteString (pFieldName:Str20;pValue:string);
var mLine:string;
begin
  If oItemActiv then begin
    SaveFieldName (pFieldName);
    oItemWrap.SetText(pValue,0);
  end
  else oHeadFile.WriteString ('HEAD',pFieldName,pValue); // V tomto pripade pracujeme len hlavickou dokladu
end;

procedure TTxtDoc.WriteInteger (pFieldName:Str20;pValue:integer);
begin
  If oItemActiv then begin
    SaveFieldName (pFieldName);
    oItemWrap.SetNum(pValue,0);
  end
  else oHeadFile.WriteInteger ('HEAD',pFieldName,pValue); // V tomto pripade pracujeme len hlavickou dokladu
end;

procedure TTxtDoc.WriteFloat (pFieldName:Str20;pValue:double);
begin
  If oItemActiv then begin
    SaveFieldName (pFieldName);
    oItemWrap.SetReal(pValue,0,3);
  end
  else oHeadFile.WriteFloat ('HEAD',pFieldName,pValue); // V tomto pripade pracujeme len hlavickou dokladu
end;

procedure TTxtDoc.WriteBool (pFieldName:Str20;pValue:boolean);
begin
  If oItemActiv then begin
    SaveFieldName (pFieldName);
    oItemWrap.SetNum(byte(pValue),0);
  end
  else oHeadFile.WriteBool ('HEAD',pFieldName,pValue); // V tomto pripade pracujeme len hlavickou dokladu
end;

procedure TTxtDoc.WriteDate (pFieldName:Str20;pValue:TDateTime);
begin
  If oItemActiv then begin
    SaveFieldName (pFieldName);
    oItemWrap.SetDate(pValue);
  end
  else oHeadFile.WriteDate ('HEAD',pFieldName,pValue); // V tomto pripade pracujeme len hlavickou dokladu
end;

procedure TTxtDoc.WriteTime (pFieldName:Str20;pValue:TDateTime);
begin
  If oItemActiv then begin
    SaveFieldName (pFieldName);
    oItemWrap.SetText (TimeToStr(pValue),0);
  end
  else oHeadFile.WriteTime ('HEAD',pFieldName,pValue); // V tomto pripade pracujeme len hlavickou dokladu
end;


procedure TTxtDoc.ReadNoti (pItem:word;var pNotType:Str1; var pLinNum:word;  var pNotice:string);
var mText:string;  mCut:TTxtCut;
begin
  mText := oNotiFile.Strings[pItem];
  mCut := TTxtCut.Create;
  mCut.SetStr(mText);
  pNotType := mCut.GetText(1);
  pLinNum := mCut.GetNum(2);
  pNotice := mCut.GetText(3);
  FreeAndNil (mCut);
end;

function TTxtDoc.FieldNameExist (pFieldName:Str20):boolean;
begin
  If oItemActiv
    then Result := GetFieldNum(pFieldName)>0
    else Result := oHeadFile.ValueExists('HEAD',pFieldName) ; // V tomto pripade pracujeme len hlavickou dokladu
end;

function TTxtDoc.ReadString (pFieldName:Str20):string;
begin
  If oItemActiv
    then Result := oItemCut.GetText(GetFieldNum(pFieldName))
    else Result := oHeadFile.ReadString('HEAD',pFieldName,''); // V tomto pripade pracujeme len hlavickou dokladu
end;

function TTxtDoc.ReadInteger (pFieldName:Str20):integer;
begin
  If oItemActiv
    then Result := oItemCut.GetNum(GetFieldNum(pFieldName))
    else Result := oHeadFile.ReadInteger('HEAD',pFieldName,0); // V tomto pripade pracujeme len hlavickou dokladu
end;

function TTxtDoc.ReadFloat (pFieldName:Str20):double;
var mLine:string;
begin
  If oItemActiv
    then Result := oItemCut.GetReal(GetFieldNum(pFieldName))
    else begin // V tomto pripade pracujeme len hlavickou dokladu
      mLine := oHeadFile.ReadString('HEAD',pFieldName,'');
      If mLine<>'' then begin
        mLine := ReplaceStr (mLine,' ','');
        Result := ValDoub (mLine);
      end
      else Result := 0;
    end;
end;

function TTxtDoc.ReadBool (pFieldName:Str20):boolean;
begin
  If oItemActiv
    then Result := oItemCut.GetNum(GetFieldNum(pFieldName))=1
    else Result := oHeadFile.ReadBool('HEAD',pFieldName,FALSE); // V tomto pripade pracujeme len hlavickou dokladu
end;

function TTxtDoc.ReadDate (pFieldName:Str20):TDateTime;
var mLine:ShortString;
begin
  If oItemActiv
    then Result := oItemCut.GetDate(GetFieldNum(pFieldName))
    else begin // V tomto pripade pracujeme len hlavickou dokladu
      mLine := oHeadFile.ReadString('HEAD',pFieldName,'');
      If mLine<>'' then begin
        mLine := ReplaceStr (mLine,' ','');
        Result := StrToDate(mLine);
      end
      else Result := 0;
    end;
end;

function TTxtDoc.ReadTime (pFieldName:Str20):TDateTime;
var mLine:ShortString;
begin
  If oItemActiv
    then Result := oItemCut.GetTime(GetFieldNum(pFieldName))
    else begin // V tomto pripade pracujeme len hlavickou dokladu
      mLine := oHeadFile.ReadString('HEAD',pFieldName,'');
      If Pos(mLine,':')>1 then begin
        mLine := ReplaceStr (mLine,' ','');
        Result := StrToTime(mLine);
      end
      else Result := 0;
    end;
end;

procedure TTxtDoc.SaveToFile (pFileName:string);  // Ulozi zadany doklad do textoveho suboru
var mTempFile:TStrings;  mPath:ShortString;
begin
  oTranFile := TStringList.Create;  // Kompletny subor - obsahuve HEAD, NOTI, DESC, ITEM
  oTranFile.Clear;
  mTempFile := TStringList.Create;  // Docasnyu subor pomocou ktoreho prenasame udaje hlavneho suboru
  // Hlavicka dokladu
  mTempFile.Clear;
  oHeadFile.WriteInteger('HEAD','ItmQnt',oItemCount);
  oHeadFile.GetStrings (mTempFile);
  oTranFile.AddStrings (mTempFile);
  // Popsi poradia poli poloziek
  mTempFile.Clear;
  oDescFile.GetStrings (mTempFile);
  oTranFile.AddStrings (mTempFile);
  // Polozky dokladu
  oTranFile.Add ('[ITEMS]');
  oTranFile.AddStrings (oItemFile);
  // Poznamky
  If oNotiFile.Count>0 then begin
    oTranFile.Add ('[NOTICE]');
    oTranFile.AddStrings (oNotiFile);
  end;
  mPath := ExtractFilePath (pFileName);
  If not DirectoryExists (mPath) then ForceDirectories (mPath);
  oTranFile.SaveToFile (pFileName);
  FreeAndNil (mTempFile);
  FreeAndNil (oTranFile);
end;

procedure TTxtDoc.LoadFromFile (pFileName:string);  // Nacita doklad z textoveho suboru
var mTempFile:TStrings;
begin
  If FileExists (pFileName) then begin
    oTranFile := TStringList.Create;  // Kompletny subor - obsahuve HEAD, NOTI, DESC, ITEM
    oTranFile.LoadFromFile (pFileName);
    mTempFile := TStringList.Create;  // Docasnyu subor pomocou ktoreho prenasame udaje hlavneho suboru
    // Nacitame hlavicku dokladu
    LoadSection ('HEAD',mTempFile); // Prenos hlavicky
    oHeadFile.Clear;
    oHeadFile.SetStrings (mTempFile);
    // Popis poradia poli dokladu
    LoadSection ('DESCRIBE',mTempFile); // Prenos hlavicky
    oDescFile.Clear;
    oDescFile.SetStrings (mTempFile);
//    oItemCut.SetDelimiter(oDescFile.ReadString('DESCRIBE','Delimiter',#254));
//    oItemCut.SetSeparator(oDescFile.ReadString('DESCRIBE','Separator',','));
    LoadSection ('ITEMS',mTempFile); // Prenos hlavicky
    oItemFile.Clear;
    oItemFile.AddStrings (mTempFile);
    oItemCount := oItemFile.Count-1;
    // Nacitame poznamky
    LoadSection ('NOTICE',mTempFile); // Prenos hlavicky
    oNotiFile.Clear;
    oNotiFile.AddStrings (mTempFile);
    oNotiCount := oNotiFile.Count;

    Application.ProcessMessages;
    FreeAndNil (mTempFile);
    FreeAndNil (oTranFile);
  end;
end;

procedure TTxtDoc.SetDelimiter (pDelimiter:Str1); // Nastavi hranicny znak pre polozky dokladu
begin
  oItemWrap.SetDelimiter(pDelimiter);
  oItemCut.SetDelimiter(pDelimiter);
end;

procedure TTxtDoc.SetSeparator (pSeparator:Str1); // Nastavi oddelovaci znak pre polozky dokladu
begin
  oItemWrap.SetSeparator(pSeparator);
  oItemCut.SetSeparator(pSeparator);
end;

// **************************** PRIVATE **************************

procedure TTxtDoc.LoadSection (pSection:Str20; var pStrings:TStrings);
var mCnt,mFindCnt:integer;   mFind,mEnd:boolean;  mLine:string;
begin
  mCnt := 0;  mFindCnt := 0; mFind := FALSE; mEnd := FALSE;
  pStrings.Clear;
  Repeat
    mLine := oTranFile.Strings[mCnt];
    If not mFind then mFind := Pos('['+pSection+']',mLine)>0;
    If (mFindCnt>1) then mEnd := (Pos('[',mLine)=1) and (Pos(']',mLine)>0);
    If mFind and not mEnd then begin
      Inc (mFindCnt);
      pStrings.Add (mLine);
    end;
    Inc (mCnt);
  until (mCnt>=oTranFile.Count) or mEnd;
end;

procedure TTxtDoc.SaveFieldName (pFieldName:Str20); // Ulozi nazov pola do popisoveje sekcie oDescFile
begin
  If not oDescFile.ValueExists ('DESCRIBE',pFieldName) then begin
    Inc (oFieldCount);
    oDescFile.WriteInteger('DESCRIBE',pFieldName,oFieldCount);
  end;
end;

function TTxtDoc.GetFieldNum (pFieldName:Str20):word; // Vyhlada poradove cislo pola na zaklade jeho mena
begin
  Result := oDescFile.ReadInteger ('DESCRIBE',pFieldName,0);
// Chybove hlasenia treba ulozit do suboru
//  If Result=0 then ShowMsg (ecFtpBadFieldName,pFieldName);
end;

end.
