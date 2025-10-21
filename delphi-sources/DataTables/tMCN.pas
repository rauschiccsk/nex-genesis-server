unit tMCN;

interface

uses
  IcTypes, IcConv, NexPath, NexGlob, DocHand, 
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls,
  Dialogs, DB, NexBtrTable, DBTables, NexPxTable;

const
  ixDoNtLn = '';
  ixDocNum = 'DocNum';

type
  TMcnTmp = class (TComponent)
    constructor Create;
    destructor  Destroy; override;
  private
    oTmpTable: TNexPxTable;
    function ReadCount:integer;
    function FieldExist (pFieldName:ShortString): boolean;
    // Pristup k databazovym poliam
    function  ReadDocNum:Str12;          procedure WriteDocNum (pValue:Str12);
    function  ReadNotType:Str1;          procedure WriteNotType (pValue:Str1);
    function  ReadLinNum:word;           procedure WriteLinNum (pValue:word);
    function  ReadNotice:Str250;         procedure WriteNotice (pValue:Str250);
  public
    // Elementarne databazove operacie
    function Eof: boolean;
    function Active: boolean;
    function LocateDoNtLn (pDocNum:Str12;pNotType:Str1;pLinNum:word):boolean;
    function LocateDocNum (pDocNum:Str12):boolean;

    procedure SetIndex (pIndexName:ShortString);
    procedure Open;
    procedure Close;
    procedure Prior; virtual;
    procedure Next; virtual;
    procedure First; virtual;
    procedure Last; virtual;
    procedure Insert; virtual;
    procedure Edit; virtual;
    procedure Post; virtual;
    procedure Delete; virtual;
    procedure SwapIndex;
    procedure RestoreIndex;
    procedure SwapStatus;
    procedure RestoreStatus;
    procedure DisableControls;
    procedure EnableControls;
  published
    property TmpTable:TNexPxTable read oTmpTable write oTmpTable;
    property Count:integer read ReadCount;
    property DocNum:Str12 read ReadDocNum write WriteDocNum;
    property NotType:Str1 read ReadNotType write WriteNotType;
    property LinNum:word read ReadLinNum write WriteLinNum;
    property Notice:Str250 read ReadNotice write WriteNotice;
  end;

implementation

constructor TMcnTmp.Create;
begin
  oTmpTable := TmpInit ('MCN',Self);
end;

destructor TMcnTmp.Destroy;
begin
  If oTmpTable.Active then oTmpTable.Close;
  FreeAndNil (oTmpTable);
end;

// *************************************** PRIVATE ********************************************

function TMcnTmp.ReadCount:integer;
begin
  Result := oTmpTable.RecordCount;
end;

function TMcnTmp.FieldExist (pFieldName:ShortString): boolean;
begin
  Result := oTmpTable.FindField(pFieldName)<>nil;
end;

function TMcnTmp.ReadDocNum:Str12;
begin
  Result := oTmpTable.FieldByName('DocNum').AsString;
end;

procedure TMcnTmp.WriteDocNum(pValue:Str12);
begin
  oTmpTable.FieldByName('DocNum').AsString := pValue;
end;

function TMcnTmp.ReadNotType:Str1;
begin
  Result := oTmpTable.FieldByName('NotType').AsString;
end;

procedure TMcnTmp.WriteNotType(pValue:Str1);
begin
  oTmpTable.FieldByName('NotType').AsString := pValue;
end;

function TMcnTmp.ReadLinNum:word;
begin
  Result := oTmpTable.FieldByName('LinNum').AsInteger;
end;

procedure TMcnTmp.WriteLinNum(pValue:word);
begin
  oTmpTable.FieldByName('LinNum').AsInteger := pValue;
end;

function TMcnTmp.ReadNotice:Str250;
begin
  Result := oTmpTable.FieldByName('Notice').AsString;
end;

procedure TMcnTmp.WriteNotice(pValue:Str250);
begin
  oTmpTable.FieldByName('Notice').AsString := pValue;
end;

// **************************************** PUBLIC ********************************************

function TMcnTmp.Eof: boolean;
begin
  Result := oTmpTable.Eof;
end;

function TMcnTmp.Active: boolean;
begin
  Result := oTmpTable.Active;
end;

function TMcnTmp.LocateDoNtLn (pDocNum:Str12;pNotType:Str1;pLinNum:word):boolean;
begin
  SetIndex (ixDoNtLn);
  Result := oTmpTable.FindKey([pDocNum,pNotType,pLinNum]);
end;

function TMcnTmp.LocateDocNum (pDocNum:Str12):boolean;
begin
  SetIndex (ixDocNum);
  Result := oTmpTable.FindKey([pDocNum]);
end;

procedure TMcnTmp.SetIndex (pIndexName:ShortString);
begin
  If oTmpTable.IndexName<>pIndexName then oTmpTable.IndexName := pIndexName;
end;

procedure TMcnTmp.Open;
begin
  oTmpTable.Open;
end;

procedure TMcnTmp.Close;
begin
  If oTmpTable.Active then oTmpTable.Close;
end;

procedure TMcnTmp.Prior;
begin
  oTmpTable.Prior;
end;

procedure TMcnTmp.Next;
begin
  oTmpTable.Next;
end;

procedure TMcnTmp.First;
begin
  oTmpTable.First;
end;

procedure TMcnTmp.Last;
begin
  oTmpTable.Last;
end;

procedure TMcnTmp.Insert;
begin
  oTmpTable.Insert;
end;

procedure TMcnTmp.Edit;
begin
  oTmpTable.Edit;
end;

procedure TMcnTmp.Post;
var mEdit:boolean;
begin
  oTmpTable.Post;
end;

procedure TMcnTmp.Delete;
begin
  oTmpTable.Delete;
end;

procedure TMcnTmp.SwapIndex;
begin
  oTmpTable.SwapIndex;
end;

procedure TMcnTmp.RestoreIndex;
begin
  oTmpTable.RestoreIndex;
end;

procedure TMcnTmp.SwapStatus;
begin
  oTmpTable.SwapStatus;
end;

procedure TMcnTmp.RestoreStatus;
begin
  oTmpTable.RestoreStatus;
end;

procedure TMcnTmp.EnableControls;
begin
  oTmpTable.EnableControls;
end;

procedure TMcnTmp.DisableControls;
begin
  oTmpTable.DisableControls;
end;

end.
