unit tACVJRN;

interface

uses
  IcTypes, IcConv, NexPath, NexGlob, DocHand, 
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls,
  Dialogs, DB, NexBtrTable, DBTables, NexPxTable;

const
  ixDocNum = '';

type
  TAcvjrnTmp = class (TComponent)
    constructor Create;
    destructor  Destroy; override;
  private
    oTmpTable: TNexPxTable;
    function ReadCount:integer;
    function FieldExist (pFieldName:ShortString): boolean;
    // Pristup k databazovym poliam
    function  ReadDocNum:Str12;          procedure WriteDocNum (pValue:Str12);
    function  ReadDocDate:TDatetime;     procedure WriteDocDate (pValue:TDatetime);
    function  ReadCrdVal:double;         procedure WriteCrdVal (pValue:double);
    function  ReadDebVal:double;         procedure WriteDebVal (pValue:double);
  public
    // Elementarne databazove operacie
    function Eof: boolean;
    function Active: boolean;
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
    property DocDate:TDatetime read ReadDocDate write WriteDocDate;
    property CrdVal:double read ReadCrdVal write WriteCrdVal;
    property DebVal:double read ReadDebVal write WriteDebVal;
  end;

implementation

constructor TAcvjrnTmp.Create;
begin
  oTmpTable := TmpInit ('ACVJRN',Self);
end;

destructor TAcvjrnTmp.Destroy;
begin
  If oTmpTable.Active then oTmpTable.Close;
  FreeAndNil (oTmpTable);
end;

// *************************************** PRIVATE ********************************************

function TAcvjrnTmp.ReadCount:integer;
begin
  Result := oTmpTable.RecordCount;
end;

function TAcvjrnTmp.FieldExist (pFieldName:ShortString): boolean;
begin
  Result := oTmpTable.FindField(pFieldName)<>nil;
end;

function TAcvjrnTmp.ReadDocNum:Str12;
begin
  Result := oTmpTable.FieldByName('DocNum').AsString;
end;

procedure TAcvjrnTmp.WriteDocNum(pValue:Str12);
begin
  oTmpTable.FieldByName('DocNum').AsString := pValue;
end;

function TAcvjrnTmp.ReadDocDate:TDatetime;
begin
  Result := oTmpTable.FieldByName('DocDate').AsDateTime;
end;

procedure TAcvjrnTmp.WriteDocDate(pValue:TDatetime);
begin
  oTmpTable.FieldByName('DocDate').AsDateTime := pValue;
end;

function TAcvjrnTmp.ReadCrdVal:double;
begin
  Result := oTmpTable.FieldByName('CrdVal').AsFloat;
end;

procedure TAcvjrnTmp.WriteCrdVal(pValue:double);
begin
  oTmpTable.FieldByName('CrdVal').AsFloat := pValue;
end;

function TAcvjrnTmp.ReadDebVal:double;
begin
  Result := oTmpTable.FieldByName('DebVal').AsFloat;
end;

procedure TAcvjrnTmp.WriteDebVal(pValue:double);
begin
  oTmpTable.FieldByName('DebVal').AsFloat := pValue;
end;

// **************************************** PUBLIC ********************************************

function TAcvjrnTmp.Eof: boolean;
begin
  Result := oTmpTable.Eof;
end;

function TAcvjrnTmp.Active: boolean;
begin
  Result := oTmpTable.Active;
end;

function TAcvjrnTmp.LocateDocNum (pDocNum:Str12):boolean;
begin
  SetIndex (ixDocNum);
  Result := oTmpTable.FindKey([pDocNum]);
end;

procedure TAcvjrnTmp.SetIndex (pIndexName:ShortString);
begin
  If oTmpTable.IndexName<>pIndexName then oTmpTable.IndexName := pIndexName;
end;

procedure TAcvjrnTmp.Open;
begin
  oTmpTable.Open;
end;

procedure TAcvjrnTmp.Close;
begin
  If oTmpTable.Active then oTmpTable.Close;
end;

procedure TAcvjrnTmp.Prior;
begin
  oTmpTable.Prior;
end;

procedure TAcvjrnTmp.Next;
begin
  oTmpTable.Next;
end;

procedure TAcvjrnTmp.First;
begin
  oTmpTable.First;
end;

procedure TAcvjrnTmp.Last;
begin
  oTmpTable.Last;
end;

procedure TAcvjrnTmp.Insert;
begin
  oTmpTable.Insert;
end;

procedure TAcvjrnTmp.Edit;
begin
  oTmpTable.Edit;
end;

procedure TAcvjrnTmp.Post;
var mEdit:boolean;
begin
  oTmpTable.Post;
end;

procedure TAcvjrnTmp.Delete;
begin
  oTmpTable.Delete;
end;

procedure TAcvjrnTmp.SwapIndex;
begin
  oTmpTable.SwapIndex;
end;

procedure TAcvjrnTmp.RestoreIndex;
begin
  oTmpTable.RestoreIndex;
end;

procedure TAcvjrnTmp.SwapStatus;
begin
  oTmpTable.SwapStatus;
end;

procedure TAcvjrnTmp.RestoreStatus;
begin
  oTmpTable.RestoreStatus;
end;

procedure TAcvjrnTmp.EnableControls;
begin
  oTmpTable.EnableControls;
end;

procedure TAcvjrnTmp.DisableControls;
begin
  oTmpTable.DisableControls;
end;

end.
{MOD 1913001}
