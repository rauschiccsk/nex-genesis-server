unit tRES;

interface

uses
  IcTypes, IcConv, NexPath, NexGlob, DocHand, 
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls,
  Dialogs, DB, NexBtrTable, DBTables, NexPxTable;

const
  ixDoIt = '';
  ixCtmDat = 'CtmDat';

type
  TResTmp = class (TComponent)
    constructor Create;
    destructor  Destroy; override;
  private
    oTmpTable: TNexPxTable;
    function ReadCount:integer;
    function FieldExist (pFieldName:ShortString): boolean;
    // Pristup k databazovym poliam
    function  ReadDocNum:Str12;          procedure WriteDocNum (pValue:Str12);
    function  ReadItmNum:longint;        procedure WriteItmNum (pValue:longint);
    function  ReadFifNum:longint;        procedure WriteFifNum (pValue:longint);
    function  ReadResQnt:double;         procedure WriteResQnt (pValue:double);
    function  ReadCtmDat:TDatetime;      procedure WriteCtmDat (pValue:TDatetime);
  public
    // Elementarne databazove operacie
    function Eof: boolean;
    function Active: boolean;
    function LocateDoIt (pDocNum:Str12;pItmNum:longint):boolean;
    function LocateCtmDat (pCtmDat:TDatetime):boolean;

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
    property ItmNum:longint read ReadItmNum write WriteItmNum;
    property FifNum:longint read ReadFifNum write WriteFifNum;
    property ResQnt:double read ReadResQnt write WriteResQnt;
    property CtmDat:TDatetime read ReadCtmDat write WriteCtmDat;
  end;

implementation

constructor TResTmp.Create;
begin
  oTmpTable := TmpInit ('RES',Self);
end;

destructor TResTmp.Destroy;
begin
  If oTmpTable.Active then oTmpTable.Close;
  FreeAndNil (oTmpTable);
end;

// *************************************** PRIVATE ********************************************

function TResTmp.ReadCount:integer;
begin
  Result := oTmpTable.RecordCount;
end;

function TResTmp.FieldExist (pFieldName:ShortString): boolean;
begin
  Result := oTmpTable.FindField(pFieldName)<>nil;
end;

function TResTmp.ReadDocNum:Str12;
begin
  Result := oTmpTable.FieldByName('DocNum').AsString;
end;

procedure TResTmp.WriteDocNum(pValue:Str12);
begin
  oTmpTable.FieldByName('DocNum').AsString := pValue;
end;

function TResTmp.ReadItmNum:longint;
begin
  Result := oTmpTable.FieldByName('ItmNum').AsInteger;
end;

procedure TResTmp.WriteItmNum(pValue:longint);
begin
  oTmpTable.FieldByName('ItmNum').AsInteger := pValue;
end;

function TResTmp.ReadFifNum:longint;
begin
  Result := oTmpTable.FieldByName('FifNum').AsInteger;
end;

procedure TResTmp.WriteFifNum(pValue:longint);
begin
  oTmpTable.FieldByName('FifNum').AsInteger := pValue;
end;

function TResTmp.ReadResQnt:double;
begin
  Result := oTmpTable.FieldByName('ResQnt').AsFloat;
end;

procedure TResTmp.WriteResQnt(pValue:double);
begin
  oTmpTable.FieldByName('ResQnt').AsFloat := pValue;
end;

function TResTmp.ReadCtmDat:TDatetime;
begin
  Result := oTmpTable.FieldByName('CtmDat').AsDateTime;
end;

procedure TResTmp.WriteCtmDat(pValue:TDatetime);
begin
  oTmpTable.FieldByName('CtmDat').AsDateTime := pValue;
end;

// **************************************** PUBLIC ********************************************

function TResTmp.Eof: boolean;
begin
  Result := oTmpTable.Eof;
end;

function TResTmp.Active: boolean;
begin
  Result := oTmpTable.Active;
end;

function TResTmp.LocateDoIt (pDocNum:Str12;pItmNum:longint):boolean;
begin
  SetIndex (ixDoIt);
  Result := oTmpTable.FindKey([pDocNum,pItmNum]);
end;

function TResTmp.LocateCtmDat (pCtmDat:TDatetime):boolean;
begin
  SetIndex (ixCtmDat);
  Result := oTmpTable.FindKey([pCtmDat]);
end;

procedure TResTmp.SetIndex (pIndexName:ShortString);
begin
  If oTmpTable.IndexName<>pIndexName then oTmpTable.IndexName := pIndexName;
end;

procedure TResTmp.Open;
begin
  oTmpTable.Open;
end;

procedure TResTmp.Close;
begin
  If oTmpTable.Active then oTmpTable.Close;
end;

procedure TResTmp.Prior;
begin
  oTmpTable.Prior;
end;

procedure TResTmp.Next;
begin
  oTmpTable.Next;
end;

procedure TResTmp.First;
begin
  oTmpTable.First;
end;

procedure TResTmp.Last;
begin
  oTmpTable.Last;
end;

procedure TResTmp.Insert;
begin
  oTmpTable.Insert;
end;

procedure TResTmp.Edit;
begin
  oTmpTable.Edit;
end;

procedure TResTmp.Post;
var mEdit:boolean;
begin
  oTmpTable.Post;
end;

procedure TResTmp.Delete;
begin
  oTmpTable.Delete;
end;

procedure TResTmp.SwapIndex;
begin
  oTmpTable.SwapIndex;
end;

procedure TResTmp.RestoreIndex;
begin
  oTmpTable.RestoreIndex;
end;

procedure TResTmp.SwapStatus;
begin
  oTmpTable.SwapStatus;
end;

procedure TResTmp.RestoreStatus;
begin
  oTmpTable.RestoreStatus;
end;

procedure TResTmp.EnableControls;
begin
  oTmpTable.EnableControls;
end;

procedure TResTmp.DisableControls;
begin
  oTmpTable.DisableControls;
end;

end.
{MOD 1921001}
