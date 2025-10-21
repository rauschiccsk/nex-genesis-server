unit tACVDOC;

interface

uses
  IcTypes, IcConv, NexPath, NexGlob, DocHand, 
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls,
  Dialogs, DB, NexBtrTable, DBTables, NexPxTable;

const
  ixDocNum = '';

type
  TAcvdocTmp = class (TComponent)
    constructor Create;
    destructor  Destroy; override;
  private
    oTmpTable: TNexPxTable;
    function ReadCount:integer;
    function FieldExist (pFieldName:ShortString): boolean;
    // Pristup k databazovym poliam
    function  ReadDocNum:Str12;          procedure WriteDocNum (pValue:Str12);
    function  ReadDocDate:TDatetime;     procedure WriteDocDate (pValue:TDatetime);
    function  ReadCValue:double;         procedure WriteCValue (pValue:double);
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
    property CValue:double read ReadCValue write WriteCValue;
  end;

implementation

constructor TAcvdocTmp.Create;
begin
  oTmpTable := TmpInit ('ACVDOC',Self);
end;

destructor TAcvdocTmp.Destroy;
begin
  If oTmpTable.Active then oTmpTable.Close;
  FreeAndNil (oTmpTable);
end;

// *************************************** PRIVATE ********************************************

function TAcvdocTmp.ReadCount:integer;
begin
  Result := oTmpTable.RecordCount;
end;

function TAcvdocTmp.FieldExist (pFieldName:ShortString): boolean;
begin
  Result := oTmpTable.FindField(pFieldName)<>nil;
end;

function TAcvdocTmp.ReadDocNum:Str12;
begin
  Result := oTmpTable.FieldByName('DocNum').AsString;
end;

procedure TAcvdocTmp.WriteDocNum(pValue:Str12);
begin
  oTmpTable.FieldByName('DocNum').AsString := pValue;
end;

function TAcvdocTmp.ReadDocDate:TDatetime;
begin
  Result := oTmpTable.FieldByName('DocDate').AsDateTime;
end;

procedure TAcvdocTmp.WriteDocDate(pValue:TDatetime);
begin
  oTmpTable.FieldByName('DocDate').AsDateTime := pValue;
end;

function TAcvdocTmp.ReadCValue:double;
begin
  Result := oTmpTable.FieldByName('CValue').AsFloat;
end;

procedure TAcvdocTmp.WriteCValue(pValue:double);
begin
  oTmpTable.FieldByName('CValue').AsFloat := pValue;
end;

// **************************************** PUBLIC ********************************************

function TAcvdocTmp.Eof: boolean;
begin
  Result := oTmpTable.Eof;
end;

function TAcvdocTmp.Active: boolean;
begin
  Result := oTmpTable.Active;
end;

function TAcvdocTmp.LocateDocNum (pDocNum:Str12):boolean;
begin
  SetIndex (ixDocNum);
  Result := oTmpTable.FindKey([pDocNum]);
end;

procedure TAcvdocTmp.SetIndex (pIndexName:ShortString);
begin
  If oTmpTable.IndexName<>pIndexName then oTmpTable.IndexName := pIndexName;
end;

procedure TAcvdocTmp.Open;
begin
  oTmpTable.Open;
end;

procedure TAcvdocTmp.Close;
begin
  If oTmpTable.Active then oTmpTable.Close;
end;

procedure TAcvdocTmp.Prior;
begin
  oTmpTable.Prior;
end;

procedure TAcvdocTmp.Next;
begin
  oTmpTable.Next;
end;

procedure TAcvdocTmp.First;
begin
  oTmpTable.First;
end;

procedure TAcvdocTmp.Last;
begin
  oTmpTable.Last;
end;

procedure TAcvdocTmp.Insert;
begin
  oTmpTable.Insert;
end;

procedure TAcvdocTmp.Edit;
begin
  oTmpTable.Edit;
end;

procedure TAcvdocTmp.Post;
var mEdit:boolean;
begin
  oTmpTable.Post;
end;

procedure TAcvdocTmp.Delete;
begin
  oTmpTable.Delete;
end;

procedure TAcvdocTmp.SwapIndex;
begin
  oTmpTable.SwapIndex;
end;

procedure TAcvdocTmp.RestoreIndex;
begin
  oTmpTable.RestoreIndex;
end;

procedure TAcvdocTmp.SwapStatus;
begin
  oTmpTable.SwapStatus;
end;

procedure TAcvdocTmp.RestoreStatus;
begin
  oTmpTable.RestoreStatus;
end;

procedure TAcvdocTmp.EnableControls;
begin
  oTmpTable.EnableControls;
end;

procedure TAcvdocTmp.DisableControls;
begin
  oTmpTable.DisableControls;
end;

end.
{MOD 1913001}
