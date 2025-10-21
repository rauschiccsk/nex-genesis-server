unit tSRPRH_C;

interface

uses
  IcTypes, IcConv, NexPath, NexGlob, DocHand, 
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls,
  Dialogs, DB, NexBtrTable, DBTables, NexPxTable;

const
  ixRowNum = '';

type
  TSrprh_cTmp = class (TComponent)
    constructor Create;
    destructor  Destroy; override;
  private
    oTmpTable: TNexPxTable;
    function ReadCount:integer;
    function FieldExist (pFieldName:ShortString): boolean;
    // Pristup k databazovym poliam
    function  ReadRowNum:longint;        procedure WriteRowNum (pValue:longint);
    function  ReadLaQnt01:Str1;          procedure WriteLaQnt01 (pValue:Str1);
    function  ReadLaQnt02:Str1;          procedure WriteLaQnt02 (pValue:Str1);
    function  ReadLaQnt03:Str1;          procedure WriteLaQnt03 (pValue:Str1);
    function  ReadLaQnt04:Str1;          procedure WriteLaQnt04 (pValue:Str1);
    function  ReadLaQnt05:Str1;          procedure WriteLaQnt05 (pValue:Str1);
    function  ReadLaQnt06:Str1;          procedure WriteLaQnt06 (pValue:Str1);
    function  ReadLaQnt07:Str1;          procedure WriteLaQnt07 (pValue:Str1);
    function  ReadLaQnt08:Str1;          procedure WriteLaQnt08 (pValue:Str1);
    function  ReadLaQnt09:Str1;          procedure WriteLaQnt09 (pValue:Str1);
    function  ReadLaQnt10:Str1;          procedure WriteLaQnt10 (pValue:Str1);
    function  ReadLaQnt11:Str1;          procedure WriteLaQnt11 (pValue:Str1);
  public
    // Elementarne databazove operacie
    function Eof: boolean;
    function Active: boolean;
    function LocateRowNum (pRowNum:longint):boolean;

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
    property RowNum:longint read ReadRowNum write WriteRowNum;
    property LaQnt01:Str1 read ReadLaQnt01 write WriteLaQnt01;
    property LaQnt02:Str1 read ReadLaQnt02 write WriteLaQnt02;
    property LaQnt03:Str1 read ReadLaQnt03 write WriteLaQnt03;
    property LaQnt04:Str1 read ReadLaQnt04 write WriteLaQnt04;
    property LaQnt05:Str1 read ReadLaQnt05 write WriteLaQnt05;
    property LaQnt06:Str1 read ReadLaQnt06 write WriteLaQnt06;
    property LaQnt07:Str1 read ReadLaQnt07 write WriteLaQnt07;
    property LaQnt08:Str1 read ReadLaQnt08 write WriteLaQnt08;
    property LaQnt09:Str1 read ReadLaQnt09 write WriteLaQnt09;
    property LaQnt10:Str1 read ReadLaQnt10 write WriteLaQnt10;
    property LaQnt11:Str1 read ReadLaQnt11 write WriteLaQnt11;
  end;

implementation

constructor TSrprh_cTmp.Create;
begin
  oTmpTable := TmpInit ('SRPRH_C',Self);
end;

destructor TSrprh_cTmp.Destroy;
begin
  If oTmpTable.Active then oTmpTable.Close;
  FreeAndNil (oTmpTable);
end;

// *************************************** PRIVATE ********************************************

function TSrprh_cTmp.ReadCount:integer;
begin
  Result := oTmpTable.RecordCount;
end;

function TSrprh_cTmp.FieldExist (pFieldName:ShortString): boolean;
begin
  Result := oTmpTable.FindField(pFieldName)<>nil;
end;

function TSrprh_cTmp.ReadRowNum:longint;
begin
  Result := oTmpTable.FieldByName('RowNum').AsInteger;
end;

procedure TSrprh_cTmp.WriteRowNum(pValue:longint);
begin
  oTmpTable.FieldByName('RowNum').AsInteger := pValue;
end;

function TSrprh_cTmp.ReadLaQnt01:Str1;
begin
  Result := oTmpTable.FieldByName('LaQnt01').AsString;
end;

procedure TSrprh_cTmp.WriteLaQnt01(pValue:Str1);
begin
  oTmpTable.FieldByName('LaQnt01').AsString := pValue;
end;

function TSrprh_cTmp.ReadLaQnt02:Str1;
begin
  Result := oTmpTable.FieldByName('LaQnt02').AsString;
end;

procedure TSrprh_cTmp.WriteLaQnt02(pValue:Str1);
begin
  oTmpTable.FieldByName('LaQnt02').AsString := pValue;
end;

function TSrprh_cTmp.ReadLaQnt03:Str1;
begin
  Result := oTmpTable.FieldByName('LaQnt03').AsString;
end;

procedure TSrprh_cTmp.WriteLaQnt03(pValue:Str1);
begin
  oTmpTable.FieldByName('LaQnt03').AsString := pValue;
end;

function TSrprh_cTmp.ReadLaQnt04:Str1;
begin
  Result := oTmpTable.FieldByName('LaQnt04').AsString;
end;

procedure TSrprh_cTmp.WriteLaQnt04(pValue:Str1);
begin
  oTmpTable.FieldByName('LaQnt04').AsString := pValue;
end;

function TSrprh_cTmp.ReadLaQnt05:Str1;
begin
  Result := oTmpTable.FieldByName('LaQnt05').AsString;
end;

procedure TSrprh_cTmp.WriteLaQnt05(pValue:Str1);
begin
  oTmpTable.FieldByName('LaQnt05').AsString := pValue;
end;

function TSrprh_cTmp.ReadLaQnt06:Str1;
begin
  Result := oTmpTable.FieldByName('LaQnt06').AsString;
end;

procedure TSrprh_cTmp.WriteLaQnt06(pValue:Str1);
begin
  oTmpTable.FieldByName('LaQnt06').AsString := pValue;
end;

function TSrprh_cTmp.ReadLaQnt07:Str1;
begin
  Result := oTmpTable.FieldByName('LaQnt07').AsString;
end;

procedure TSrprh_cTmp.WriteLaQnt07(pValue:Str1);
begin
  oTmpTable.FieldByName('LaQnt07').AsString := pValue;
end;

function TSrprh_cTmp.ReadLaQnt08:Str1;
begin
  Result := oTmpTable.FieldByName('LaQnt08').AsString;
end;

procedure TSrprh_cTmp.WriteLaQnt08(pValue:Str1);
begin
  oTmpTable.FieldByName('LaQnt08').AsString := pValue;
end;

function TSrprh_cTmp.ReadLaQnt09:Str1;
begin
  Result := oTmpTable.FieldByName('LaQnt09').AsString;
end;

procedure TSrprh_cTmp.WriteLaQnt09(pValue:Str1);
begin
  oTmpTable.FieldByName('LaQnt09').AsString := pValue;
end;

function TSrprh_cTmp.ReadLaQnt10:Str1;
begin
  Result := oTmpTable.FieldByName('LaQnt10').AsString;
end;

procedure TSrprh_cTmp.WriteLaQnt10(pValue:Str1);
begin
  oTmpTable.FieldByName('LaQnt10').AsString := pValue;
end;

function TSrprh_cTmp.ReadLaQnt11:Str1;
begin
  Result := oTmpTable.FieldByName('LaQnt11').AsString;
end;

procedure TSrprh_cTmp.WriteLaQnt11(pValue:Str1);
begin
  oTmpTable.FieldByName('LaQnt11').AsString := pValue;
end;

// **************************************** PUBLIC ********************************************

function TSrprh_cTmp.Eof: boolean;
begin
  Result := oTmpTable.Eof;
end;

function TSrprh_cTmp.Active: boolean;
begin
  Result := oTmpTable.Active;
end;

function TSrprh_cTmp.LocateRowNum (pRowNum:longint):boolean;
begin
  SetIndex (ixRowNum);
  Result := oTmpTable.FindKey([pRowNum]);
end;

procedure TSrprh_cTmp.SetIndex (pIndexName:ShortString);
begin
  If oTmpTable.IndexName<>pIndexName then oTmpTable.IndexName := pIndexName;
end;

procedure TSrprh_cTmp.Open;
begin
  oTmpTable.Open;
end;

procedure TSrprh_cTmp.Close;
begin
  If oTmpTable.Active then oTmpTable.Close;
end;

procedure TSrprh_cTmp.Prior;
begin
  oTmpTable.Prior;
end;

procedure TSrprh_cTmp.Next;
begin
  oTmpTable.Next;
end;

procedure TSrprh_cTmp.First;
begin
  oTmpTable.First;
end;

procedure TSrprh_cTmp.Last;
begin
  oTmpTable.Last;
end;

procedure TSrprh_cTmp.Insert;
begin
  oTmpTable.Insert;
end;

procedure TSrprh_cTmp.Edit;
begin
  oTmpTable.Edit;
end;

procedure TSrprh_cTmp.Post;
var mEdit:boolean;
begin
  oTmpTable.Post;
end;

procedure TSrprh_cTmp.Delete;
begin
  oTmpTable.Delete;
end;

procedure TSrprh_cTmp.SwapIndex;
begin
  oTmpTable.SwapIndex;
end;

procedure TSrprh_cTmp.RestoreIndex;
begin
  oTmpTable.RestoreIndex;
end;

procedure TSrprh_cTmp.SwapStatus;
begin
  oTmpTable.SwapStatus;
end;

procedure TSrprh_cTmp.RestoreStatus;
begin
  oTmpTable.RestoreStatus;
end;

procedure TSrprh_cTmp.EnableControls;
begin
  oTmpTable.EnableControls;
end;

procedure TSrprh_cTmp.DisableControls;
begin
  oTmpTable.DisableControls;
end;

end.
