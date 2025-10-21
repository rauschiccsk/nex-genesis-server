unit DocItem;
{$F+}
// **************************************************************************
// Objek sluzi na ukldanie poloziek dokladov do textoveho suboru
// Na kompletne ulozenie dokladu do textoveho suboru treba pouzivat aj objekt
// na ukladanie hlavicky TDocHead
// **************************************************************************

interface

uses
  IcTypes, IcConv, IcTools, NexPath, NexIni, TxtWrap, TxtCut, NexMsg, NexError,
  Forms, IniFiles, SysUtils, Classes;

type
  TDocItem = class
    constructor Create;
    destructor  Destroy; override;
    private
      oFldCnt: word;     // Pocet poli poloziek dokladu
      oCursor: word; // Poradove cilo polozky na ktorom stoji kurzor objektu
      oItmLst: TStrings;  // Polozky dokladu
      oFldLst: TStrings; // Popisovy zoznam poli
      oLine: boolean;  // TRUE ak je to riadok zaznamu
      oWrap: TTxtWrap;
      oCut: TTxtCut;
      oEof: boolean;  // TRUE ak sme na konci suboru poloziek dokladu

      procedure SaveFieldName (pFieldName:Str20); // Ulozi nazov pola do popisoveje sekcie oDescFile
      function GetFieldNum (pFieldName:Str20):word; // Vyhlada poradove cislo pola na zaklade jeho mena
      function GetCount:word; // Pocet poloziek dokladu
    public
      procedure LoadFromFile (pFileName,pSecName:ShortString);

      procedure WriteString (pFieldName:Str20;pValue:string);
      procedure WriteInteger (pFieldName:Str20;pValue:integer);
      procedure WriteFloat (pFieldName:Str20;pValue:double);
      procedure WriteBool (pFieldName:Str20;pValue:boolean);
      procedure WriteDate (pFieldName:Str20;pValue:TDateTime);
      procedure WriteTime (pFieldName:Str20;pValue:TDateTime);

      function FieldExist (pFieldName:Str20):boolean; // TRUE a pole existuje
//      function FieldNameExist (pFieldName:Str20):boolean;
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
    published
      property Count:word read GetCount;
      property Line:boolean read oLine;
      property Eof:boolean read oEof;
      property FldLst:TStrings read oFldLst;
      property ItmLst:TStrings read oItmLst;
  end;

implementation

constructor TDocItem.Create;
begin
  oFldCnt := 0;  oLine := FALSE;
  oItmLst := TStringList.Create;
  oFldLst := TStringList.Create; // Popisovy zoznam poli
  oWrap := TTxtWrap.Create;  oWrap.SetDelimiter('');  oWrap.SetSeparator(';');
  oCut := TTxtCut.Create;    oCut.SetDelimiter('');   oCut.SetSeparator(';');
end;

destructor TDocItem.Destroy;
begin
  FreeAndNil (oCut);
  FreeAndNil (oWrap);
  FreeAndNil (oFldLst);
  FreeAndNil (oItmLst);
end;

procedure TDocItem.Insert;
begin
  oFldLst.Clear; oFldCnt := 0;
  oWrap.ClearWrap;
end;

procedure TDocItem.Post;
begin
  oItmLst.Add (oWrap.GetWrapText);
end;

procedure TDocItem.First;
begin
  oCursor := 0;
  oCut.SetStr (oItmLst.Strings[oCursor]);
  oLine := oCut.Count=oFldLst.Count;
end;

procedure TDocItem.Last;
begin
  oCursor := oItmLst.Count-1;
  oCut.SetStr (oItmLst.Strings[oCursor]);
  oLine := oCut.Count=oFldLst.Count;
end;

procedure TDocItem.Next;
begin
  If oCursor<oItmLst.Count-1 then begin
    oEof := False;
    Inc (oCursor);
    oCut.SetStr (oItmLst.Strings[oCursor]);
    oLine := oCut.Count=oFldLst.Count;
  end
  else oEof := TRUE;
end;

procedure TDocItem.LoadFromFile (pFileName,pSecName:ShortString); // Nacitaudaje zo zadaneho suboru
begin
  LoadSectionFromFile (pFileName,'FLDLST-'+pSecName,oFldLst);
  LoadSectionFromFile (pFileName,'ITMLST-'+pSecName,oItmLst);
end;

procedure TDocItem.WriteString (pFieldName:Str20;pValue:string);
begin
  SaveFieldName (pFieldName);
  oWrap.SetText(pValue,0);
end;

procedure TDocItem.WriteInteger (pFieldName:Str20;pValue:integer);
begin
  SaveFieldName (pFieldName);
  oWrap.SetNum(pValue,0);
end;

procedure TDocItem.WriteFloat (pFieldName:Str20;pValue:double);
begin
  SaveFieldName (pFieldName);
  oWrap.SetReal(pValue,0,3);
end;

procedure TDocItem.WriteBool (pFieldName:Str20;pValue:boolean);
begin
  SaveFieldName (pFieldName);
  oWrap.SetNum(byte(pValue),0);
end;

procedure TDocItem.WriteDate (pFieldName:Str20;pValue:TDateTime);
begin
  SaveFieldName (pFieldName);
  oWrap.SetDate(pValue);
end;

procedure TDocItem.WriteTime (pFieldName:Str20;pValue:TDateTime);
begin
  SaveFieldName (pFieldName);
  oWrap.SetText (TimeToStr(pValue),0);
end;

//function TDocItem.FieldNameExist (pFieldName:Str20):boolean;
//begin
//  Result := GetFieldNum(pFieldName)>0
//end;

function TDocItem.ReadString (pFieldName:Str20):string;
begin
  Result := oCut.GetText(GetFieldNum(pFieldName))
end;

function TDocItem.ReadInteger (pFieldName:Str20):integer;
begin
  Result := oCut.GetNum(GetFieldNum(pFieldName))
end;

function TDocItem.ReadFloat (pFieldName:Str20):double;
var mLine:string;
begin
  Result := oCut.GetReal(GetFieldNum(pFieldName))
end;

function TDocItem.ReadBool (pFieldName:Str20):boolean;
begin
  Result := oCut.GetNum(GetFieldNum(pFieldName))=1
end;

function TDocItem.ReadDate (pFieldName:Str20):TDateTime;
begin
  Result := oCut.GetDate(GetFieldNum(pFieldName))
end;

function TDocItem.ReadTime (pFieldName:Str20):TDateTime;
begin
  Result := oCut.GetTime(GetFieldNum(pFieldName))
end;

// **************************** PRIVATE **************************

procedure TDocItem.SaveFieldName (pFieldName:Str20); // Ulozi nazov pola do popisoveje sekcie oDescFile
begin
  Inc (oFldCnt);
  oFldLst.Add(pFieldName+'='+StrInt(oFldCnt,0))
end;

function TDocItem.FieldExist (pFieldName:Str20):boolean; // TRUE a pole existuje
var mCnt:word;  mFieldName:ShortString;
begin
  Result := FALSE;
  If oFldLst.Count>0 then begin
    mCnt := 0;
    Repeat
      mFieldName := LineElement(oFldLst.Strings[mCnt],0,'=');
      Result := UpString(mFieldName)=UpString(pFieldName);
      Inc (mCnt);
    until (mCnt=oFldLst.Count) or Result;
  end;
end;

function TDocItem.GetFieldNum (pFieldName:Str20):word; // Vyhlada poradove cislo pola na zaklade jeho mena
var mCnt:word;  mFieldName:ShortString;  mFind:boolean;
begin
  Result := 0;
  If oFldLst.Count>0 then begin
    mCnt := 0;
    Repeat
      mFieldName := LineElement(oFldLst.Strings[mCnt],0,'=');
      mFind := UpString(mFieldName)=UpString(pFieldName);
      If mFind then Result := ValInt(LineElement(oFldLst.Strings[mCnt],1,'='));
      Inc (mCnt);
    until (mCnt=oFldLst.Count) or mFind;
  end;
end;

function TDocItem.GetCount:word; // Pocet poloziek dokladu
begin
  Result := oItmLst.Count;
end;

end.
