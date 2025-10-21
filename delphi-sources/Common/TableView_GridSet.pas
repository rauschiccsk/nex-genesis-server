unit TableView_GridSet;

interface

uses
     IcTypes, IcConv, NexPath, TxtCut, TxtWrap,
     IniFiles, Classes, SysUtils;

type
  TGridSet = class (TIniFile)
    oSetNums: TStrings;  // Identifikátory gridu - D01,D02 ...
    oSetNames: TStrings; // Názcy gridu - D01,D02 ...
  private
    { Private declarations }
  protected
    { Protected declarations }
    oFileName: Str8;     // Nazov súboru (bez rozsirenia), v ktorom su ulozene nastavenia gridu
    oSetType: char;      // Typ nastavenia: D - nastavenia autora (Default), U - nastavenia užívate¾a
    oFieldName: Str20;
    oCollumnName: Str30;
    oCollumnSize: word;
    oAlignment: TAlignment;
    oSection: Str30;
  public
    { Public declarations }
    constructor Create(pFileName: Str8);  overload;
    destructor  Destroy; override;
    {GLOBAL}
    function    ReadSetQnt: byte;
    procedure   SetSection (pSection:Str30);
    procedure   WriteSetQnt (pSetQnt:byte);
    procedure   SaveSetData;
    procedure   LoadSetData;
    function    GetSetNum (pIndex:byte): Str3;
    function    GetSetNums: TStrings;
    function    GetSetNames: TStrings;
    function    GetSetName (pSetNum:Str3): Str20;
    function    GetNextSetNum: Str3;
    {Dxx - nastavenie gridu }
    procedure   DeleteSection;
    procedure   SaveSetHead (pValue: string);
    procedure   SaveFieldQnt (pValue: word);
    function    ReadSetHead: string;
    function    ReadFieldQnt: word;

    procedure   SaveField (pIndex:word; pFieldName:Str20; pCollumnName:Str30; pCollumnSize:word; pAlignment:TAlignment);
    procedure   LoadField (pIndex:word);
    function    GetFieldName: Str20;
    function    GetCollumnName: Str30;
    function    GetCollumnSize: word;
    function    GetAlignment: TAlignment;

  published
    { Published declarations }
  end;

var gGridSet: TGridSet;

implementation

constructor TGridSet.Create (pFileName: Str8);
var mFileName: string;
begin
  oSetType := 'D'; // Zakladnné nastavenia autora systému
  mFileName := pFileName+'.'+oSetType+'GD';
  inherited Create(GetLngPath+mFileName);
  oSetNums := TStringList.Create;
  oSetNames := TStringList.Create;
end;

destructor TGridSet.Destroy;
begin
  oSetNames.Free;
  oSetNums.Free;
  inherited Destroy;
end;

function TGridSet.ReadSetQnt: byte;
begin
  Result := ReadInteger ('GLOBAL','SetQnt',0);
end;

procedure TGridSet.SetSection (pSection: Str30);
begin
  oSection := pSection;
end;

procedure TGridSet.WriteSetQnt (pSetQnt: byte);
begin
  WriteInteger ('GLOBAL','SetQnt',pSetQnt);
end;

procedure TGridSet.DeleteSection;
var mIndex:byte;
begin
  mIndex := oSetNums.IndexOf (oSection);
  oSetNums.Delete (mIndex);
  oSetNames.Delete (mIndex);
  SaveSetData;
  EraseSection (oSection);
end;

procedure TGridSet.SaveSetHead (pValue: string);
begin
  WriteString (oSection,'SetHead',pValue);
end;

procedure TGridSet.SaveFieldQnt (pValue: word);
begin
  WriteInteger (oSection,'FieldQnt',pValue);
end;

function TGridSet.ReadSetHead: string;
begin
  ReadSetHead := ReadString (oSection,'SetHead','');
end;

function TGridSet.ReadFieldQnt: word;
begin
  ReadFieldQnt := ReadInteger (oSection,'FieldQnt',0);
end;

procedure TGridSet.SaveSetData;
var mWrap: TTxtWrap; I:byte;
begin
  WriteInteger ('GLOBAL','SetQnt',oSetNums.Count);

  mWrap := TTxtWrap.Create;
  mWrap.SetDelimiter ('');

  mWrap.ClearWrap;
  If oSetNums.Count>0 then begin
    For I:=0 to oSetNums.Count-1 do
      mWrap.SetText (oSetNums.Strings[I],0);
  end;
  WriteString(oSection,'SetNums',mWrap.GetWrapText);

  mWrap.ClearWrap;
  If oSetNames.Count>0 then begin
    For I:=0 to oSetNames.Count-1 do
      mWrap.SetText (oSetNames.Strings[I],0);
  end;
  WriteString(oSection,'SetNames',mWrap.GetWrapText);
  mWrap.Free;
end;

procedure TGridSet.LoadSetData;
var mCut: TTxtCut;
    mSetQnt,I:byte;
begin
  mSetQnt := ReadInteger ('GLOBAL','SetQnt',1);
  mCut := TTxtCut.Create;
  mCut.SetDelim ('');
  mCut.SetStr (ReadString(oSection,'SetNums','D01'));
  For I:=1 to mSetQnt do
    oSetNums.Add (mCut.GetText(I));
  mCut.SetStr (ReadString(oSection,'SetNames','D01'));
  For I:=1 to mSetQnt do
    oSetNames.Add (mCut.GetText(I));
  mCut.Free;
end;

function TGridSet.GetSetNum (pIndex:byte): Str3;
begin
  GetSetNum := oSetNums.Strings[pIndex];
end;

function TGridSet.GetSetNums: TStrings;
begin
  GetSetNums := oSetNums;
end;

function TGridSet.GetSetNames: TStrings;
begin
  GetSetNames := oSetNames;
end;

function TGridSet.GetSetName (pSetNum:Str3): Str20;
begin
  GetSetName := oSetNames.Strings[oSetNums.IndexOf(pSetNum)];
end;

function TGridSet.GetNextSetNum: Str3;
var mCnt: byte;  mFind: boolean;
    mSetNum: Str3;
begin
  mCnt := 0;
  Repeat
    Inc (mCnt);
    mSetNum := oSetType+StrIntZero(mCnt,2);
    mFind := oSetNums.IndexOf(mSetNum)>-1;
  until not mFind or (mCnt=oSetNums.Count);
  If not mfind
    then GetNextSetNum := mSetNum
    else GetNextSetNum := oSetType+StrIntZero(mCnt+1,2);
end;

procedure TGridSet.SaveField (pIndex:word; pFieldName:Str20; pCollumnName:Str30; pCollumnSize:word; pAlignment:TAlignment);
var mAlignMent: Str1;
begin
  case pAlignment of
    taCenter: mAlignMent := 'C';
    taLeftJustify: mAlignMent := 'L';
    taRightJustify: mAlignMent := 'R';
  end;
  WriteString (oSection,'Field'+StrInt(pIndex,0),pFieldName+','+pCollumnName+','+StrInt(pCollumnSize,0)+','+mAlignment);
end;

procedure TGridSet.LoadField (pIndex:word);
var mCut: TTxtCut;  mAlignMent: Str1;
begin
  mCut := TTxtCut.Create;
  mCut.SetDelim ('');
  mCut.SetStr (ReadString(oSection,'Field'+StrInt(pIndex,0),''));
  oFieldName := mCut.GetText (1);
  oCollumnName := mCut.GetText (2);
  oCollumnSize := mCut.GetNum (3);

  mAlignment := mCut.GetText (4);
  case mAlignment[1] of
    'C': oAlignment := taCenter;
    'R': oAlignment := taRightJustify;
    'L': oAlignment := taLeftJustify;
  end;
  mCut.Free;
end;

function TGridSet.GetFieldName: Str20;
begin
  GetFieldName := oFieldName;
end;

function TGridSet.GetCollumnName: Str30;
begin
  GetCollumnName := oCollumnName;
end;

function TGridSet.GetCollumnSize: word;
begin
  GetCollumnSize := oCollumnSize;
end;

function TGridSet.GetAlignment: TAlignment;
begin
  GetAlignment := oAlignment;
end;

end.
