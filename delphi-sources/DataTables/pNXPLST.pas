unit pNXPLST; // Zoznam vykazov obratovej pedvahy

interface

uses
  IcTypes, IcTools, NexPath, NexGlob, TxtCut, pREGPMD,
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls,
  Dialogs, DB, DBTables, NexPxTable;

const
  ixSmPm = '';
  ixPmdMark = 'PmdMark';
  ixPmdName = 'PmdName';

type
  TNxpLst = class (TComponent)
    constructor Create;
    destructor  Destroy; override;
  private
    oTmpTable: TNexPxTable;
    function ReadCount:integer;
    function Registered(pIndex:word):boolean;
    function GetIndexName:ShortString;
    procedure SetIndexName (pIndexName:ShortString);

    function ReadSysMark:Str2;       procedure WriteSysMark (pValue:Str2);
    function ReadPmdMark:Str3;       procedure WritePmdMark (pValue:Str3);
    function ReadPmdType:Str1;       procedure WritePmdType (pValue:Str1);
    function ReadPmdName:Str40;      procedure WritePmdName (pValue:Str40);
    function ReadRegInd:word;        procedure WriteRegInd (pValue:word);
  public
    thREGPMD: TRegPmdTmp;
    function Eof: boolean;
    function LocateSmPm (pSysMark:Str2;pPmdMark:Str3):boolean;
    procedure Open;
    procedure Close;
    procedure Prior;
    procedure Next;
    procedure First;
    procedure Last;
    procedure Insert;
    procedure Edit;
    procedure Post;
    procedure Delete;
    procedure SwapIndex;
    procedure RestoreIndex;
    procedure SwapStatus;
    procedure RestoreStatus;
    procedure DisableControls;
    procedure EnableControls;
    procedure LoadFromFile (pSystem:Str1);
  published
    property TmpTable:TNexPxTable read oTmpTable write oTmpTable;
    property Count:integer read ReadCount;
    property IndexName:ShortString read GetIndexName write SetIndexName;

    property SysMark:Str2 read ReadSysMark write WriteSysMark;
    property PmdMark:Str3 read ReadPmdMark write WritePmdMark;
    property PmdType:Str1 read ReadPmdType write WritePmdType;
    property PmdName:Str40 read ReadPmdName write WritePmdName;
    property RegInd:word read ReadRegInd write WriteRegInd;
  end;

implementation

constructor TNxpLst.Create;
begin
  oTmpTable := TmpInit ('NXPLST',Self);
end;

destructor  TNxpLst.Destroy;
begin
  If oTmpTable.Active then oTmpTable.Close;
  FreeAndNil (oTmpTable);
end;

// *************************************** PRIVATE ********************************************

function TNxpLst.ReadCount:integer;
begin
  Result := oTmpTable.RecordCount;
end;

function TNxpLst.Registered(pIndex:word):boolean;
begin
  Result := thREGPMD.LocateRegInd(pIndex);
end;

function TNxpLst.ReadSysMark:Str2;
begin
  Result := oTmpTable.FieldByName('SysMark').AsString;
end;

function TNxpLst.ReadPmdMark:Str3;
begin
  Result := oTmpTable.FieldByName('PmdMark').AsString;
end;

function TNxpLst.ReadPmdType:Str1;
begin
  Result := oTmpTable.FieldByName('PmdType').AsString;
end;

function TNxpLst.ReadPmdName:Str40;
begin
  Result := oTmpTable.FieldByName('PmdName').AsString;
end;

function TNxpLst.ReadRegInd:word;
begin
  Result := oTmpTable.FieldByName('RegInd').AsInteger;
end;

procedure TNxpLst.WriteSysMark (pValue:Str2);
begin
  oTmpTable.FieldByName('SysMark').AsString := pValue;
end;

procedure TNxpLst.WritePmdMark (pValue:Str3);
begin
  oTmpTable.FieldByName('PmdMark').AsString := pValue;
end;

procedure TNxpLst.WritePmdType (pValue:Str1);
begin
  oTmpTable.FieldByName('PmdType').AsString := pValue;
end;

procedure TNxpLst.WritePmdName (pValue:Str40);
begin
  oTmpTable.FieldByName('PmdName').AsString := pValue;
end;

procedure TNxpLst.WriteRegInd (pValue:word);
begin
  oTmpTable.FieldByName('RegInd').AsInteger := pValue;
end;

// **************************************** PUBLIC ********************************************

function TNxpLst.Eof: boolean;
begin
  Result := oTmpTable.Eof;
end;

function TNxpLst.LocateSmPm (pSysMark:Str2;pPmdMark:Str3):boolean;
begin
  SetIndexName (ixSmPm);
  Result := oTmpTable.FindKey([pSysMark,pPmdMark]);
end;

function TNxpLst.GetIndexName:ShortString;
begin
  Result := oTmpTable.IndexName;
end;

procedure TNxpLst.SetIndexName (pIndexName:ShortString);
begin
  If oTmpTable.IndexName<>pIndexName then oTmpTable.IndexName := pIndexName;
end;

procedure TNxpLst.Open;
begin
  oTmpTable.Open;
end;

procedure TNxpLst.Close;
begin
  oTmpTable.Close;
end;

procedure TNxpLst.Prior;
begin
  oTmpTable.Prior;
end;

procedure TNxpLst.Next;
begin
  oTmpTable.Next;
end;

procedure TNxpLst.First;
begin
  oTmpTable.First;
end;

procedure TNxpLst.Last;
begin
  oTmpTable.Last;
end;

procedure TNxpLst.Insert;
begin
  oTmpTable.Insert;
end;

procedure TNxpLst.Edit;
begin
  oTmpTable.Edit;
end;

procedure TNxpLst.Post;
begin
  oTmpTable.Post;
end;

procedure TNxpLst.Delete;
begin
  oTmpTable.Delete;
end;

procedure TNxpLst.SwapIndex;
begin
  oTmpTable.SwapIndex;
end;

procedure TNxpLst.RestoreIndex;
begin
  oTmpTable.RestoreIndex;
end;

procedure TNxpLst.SwapStatus;
begin
  oTmpTable.SwapStatus;
end;

procedure TNxpLst.RestoreStatus;
begin
  oTmpTable.RestoreStatus;
end;

procedure TNxpLst.DisableControls;
begin
  oTmpTable.DisableControls;
end;

procedure TNxpLst.EnableControls;
begin
  oTmpTable.EnableControls;
end;

procedure TNxpLst.LoadFromFile (pSystem:Str1);
var mFile:TStrings;  mFileName:ShortString;  mCut:TTxtCut;  mIndex,I:word;
begin
  thREGPMD.SwapStatus;
  thREGPMD.IndexName := ixRegInd;
  mFileName := gPath.CdwPath+'NXPLST.SYS';
  If FileExists (mFileName) then begin
    mFile := TStringList.Create;
    mFile.LoadFromFile(mFileName);
    If mFile.Count>0 then begin
      mCut := TTxtCut.Create;
      mCut.SetDelimiter('');
      mCut.SetSeparator(';');
      For I:=0 to mFile.Count-1 do begin
        mCut.SetStr (mFile.Strings[I]);
        mIndex := mCut.GetNum(1);
        If pSystem='L' then begin // NEX L
          If (mCut.GetText(2)='X') and not Registered(mIndex) then begin
            Insert;
            RegInd := mIndex;
            SysMark := mCut.GetText(5);
            PmdMark := mCut.GetText(6);
            PmdName := mCut.GetText(7);
            Post;
          end;
        end;
        If pSystem='M' then begin // NEX M
          If (mCut.GetText(3)='X') and not Registered(mIndex) then begin
            Insert;
            RegInd := mIndex;
            SysMark := mCut.GetText(5);
            PmdMark := mCut.GetText(6);
            PmdName := mCut.GetText(7);
            Post;
          end;
        end;
        If pSystem='P' then begin // NEX M
          If (mCut.GetText(4)='X') and not Registered(mIndex) then begin
            Insert;
            RegInd := mIndex;
            SysMark := mCut.GetText(5);
            PmdMark := mCut.GetText(6);
            PmdName := mCut.GetText(7);
            Post;
          end;
        end;
      end;
      FreeAndNil (mCut);
    end;
    FreeAndNil (mFile);
  end;
  thREGPMD.RestoreStatus;
end;

end.
