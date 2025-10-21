unit tSRSTA_C;

interface

uses
  IcTypes, IcConv, NexPath, NexGlob, DocHand, 
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls,
  Dialogs, DB, NexBtrTable, DBTables, NexPxTable;

const
  ixSerNum = '';

type
  TSrsta_cTmp = class (TComponent)
    constructor Create;
    destructor  Destroy; override;
  private
    oTmpTable: TNexPxTable;
    function ReadCount:integer;
    function FieldExist (pFieldName:ShortString): boolean;
    // Pristup k databazovym poliam
    function  ReadSerNum:byte;           procedure WriteSerNum (pValue:byte);
    function  ReadBegQnt01:Str1;         procedure WriteBegQnt01 (pValue:Str1);
    function  ReadBegQnt02:Str1;         procedure WriteBegQnt02 (pValue:Str1);
    function  ReadBegQnt03:Str1;         procedure WriteBegQnt03 (pValue:Str1);
    function  ReadBegQnt04:Str1;         procedure WriteBegQnt04 (pValue:Str1);
    function  ReadBegQnt05:Str1;         procedure WriteBegQnt05 (pValue:Str1);
    function  ReadBegQnt06:Str1;         procedure WriteBegQnt06 (pValue:Str1);
    function  ReadBegQnt07:Str1;         procedure WriteBegQnt07 (pValue:Str1);
    function  ReadBegQnt08:Str1;         procedure WriteBegQnt08 (pValue:Str1);
    function  ReadBegQnt09:Str1;         procedure WriteBegQnt09 (pValue:Str1);
    function  ReadBegQnt10:Str1;         procedure WriteBegQnt10 (pValue:Str1);
    function  ReadBegQnt11:Str1;         procedure WriteBegQnt11 (pValue:Str1);
    function  ReadIncQnt01:Str1;         procedure WriteIncQnt01 (pValue:Str1);
    function  ReadIncQnt02:Str1;         procedure WriteIncQnt02 (pValue:Str1);
    function  ReadIncQnt03:Str1;         procedure WriteIncQnt03 (pValue:Str1);
    function  ReadIncQnt04:Str1;         procedure WriteIncQnt04 (pValue:Str1);
    function  ReadIncQnt05:Str1;         procedure WriteIncQnt05 (pValue:Str1);
    function  ReadIncQnt06:Str1;         procedure WriteIncQnt06 (pValue:Str1);
    function  ReadIncQnt07:Str1;         procedure WriteIncQnt07 (pValue:Str1);
    function  ReadIncQnt08:Str1;         procedure WriteIncQnt08 (pValue:Str1);
    function  ReadIncQnt09:Str1;         procedure WriteIncQnt09 (pValue:Str1);
    function  ReadIncQnt10:Str1;         procedure WriteIncQnt10 (pValue:Str1);
    function  ReadIncQnt11:Str1;         procedure WriteIncQnt11 (pValue:Str1);
    function  ReadOutQnt01:Str1;         procedure WriteOutQnt01 (pValue:Str1);
    function  ReadOutQnt02:Str1;         procedure WriteOutQnt02 (pValue:Str1);
    function  ReadOutQnt03:Str1;         procedure WriteOutQnt03 (pValue:Str1);
    function  ReadOutQnt04:Str1;         procedure WriteOutQnt04 (pValue:Str1);
    function  ReadOutQnt05:Str1;         procedure WriteOutQnt05 (pValue:Str1);
    function  ReadOutQnt06:Str1;         procedure WriteOutQnt06 (pValue:Str1);
    function  ReadOutQnt07:Str1;         procedure WriteOutQnt07 (pValue:Str1);
    function  ReadOutQnt08:Str1;         procedure WriteOutQnt08 (pValue:Str1);
    function  ReadOutQnt09:Str1;         procedure WriteOutQnt09 (pValue:Str1);
    function  ReadOutQnt10:Str1;         procedure WriteOutQnt10 (pValue:Str1);
    function  ReadOutQnt11:Str1;         procedure WriteOutQnt11 (pValue:Str1);
    function  ReadEndQnt01:Str1;         procedure WriteEndQnt01 (pValue:Str1);
    function  ReadEndQnt02:Str1;         procedure WriteEndQnt02 (pValue:Str1);
    function  ReadEndQnt03:Str1;         procedure WriteEndQnt03 (pValue:Str1);
    function  ReadEndQnt04:Str1;         procedure WriteEndQnt04 (pValue:Str1);
    function  ReadEndQnt05:Str1;         procedure WriteEndQnt05 (pValue:Str1);
    function  ReadEndQnt06:Str1;         procedure WriteEndQnt06 (pValue:Str1);
    function  ReadEndQnt07:Str1;         procedure WriteEndQnt07 (pValue:Str1);
    function  ReadEndQnt08:Str1;         procedure WriteEndQnt08 (pValue:Str1);
    function  ReadEndQnt09:Str1;         procedure WriteEndQnt09 (pValue:Str1);
    function  ReadEndQnt10:Str1;         procedure WriteEndQnt10 (pValue:Str1);
    function  ReadEndQnt11:Str1;         procedure WriteEndQnt11 (pValue:Str1);
  public
    // Elementarne databazove operacie
    function Eof: boolean;
    function Active: boolean;
    function LocateSerNum (pSerNum:byte):boolean;

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
    property SerNum:byte read ReadSerNum write WriteSerNum;
    property BegQnt01:Str1 read ReadBegQnt01 write WriteBegQnt01;
    property BegQnt02:Str1 read ReadBegQnt02 write WriteBegQnt02;
    property BegQnt03:Str1 read ReadBegQnt03 write WriteBegQnt03;
    property BegQnt04:Str1 read ReadBegQnt04 write WriteBegQnt04;
    property BegQnt05:Str1 read ReadBegQnt05 write WriteBegQnt05;
    property BegQnt06:Str1 read ReadBegQnt06 write WriteBegQnt06;
    property BegQnt07:Str1 read ReadBegQnt07 write WriteBegQnt07;
    property BegQnt08:Str1 read ReadBegQnt08 write WriteBegQnt08;
    property BegQnt09:Str1 read ReadBegQnt09 write WriteBegQnt09;
    property BegQnt10:Str1 read ReadBegQnt10 write WriteBegQnt10;
    property BegQnt11:Str1 read ReadBegQnt11 write WriteBegQnt11;
    property IncQnt01:Str1 read ReadIncQnt01 write WriteIncQnt01;
    property IncQnt02:Str1 read ReadIncQnt02 write WriteIncQnt02;
    property IncQnt03:Str1 read ReadIncQnt03 write WriteIncQnt03;
    property IncQnt04:Str1 read ReadIncQnt04 write WriteIncQnt04;
    property IncQnt05:Str1 read ReadIncQnt05 write WriteIncQnt05;
    property IncQnt06:Str1 read ReadIncQnt06 write WriteIncQnt06;
    property IncQnt07:Str1 read ReadIncQnt07 write WriteIncQnt07;
    property IncQnt08:Str1 read ReadIncQnt08 write WriteIncQnt08;
    property IncQnt09:Str1 read ReadIncQnt09 write WriteIncQnt09;
    property IncQnt10:Str1 read ReadIncQnt10 write WriteIncQnt10;
    property IncQnt11:Str1 read ReadIncQnt11 write WriteIncQnt11;
    property OutQnt01:Str1 read ReadOutQnt01 write WriteOutQnt01;
    property OutQnt02:Str1 read ReadOutQnt02 write WriteOutQnt02;
    property OutQnt03:Str1 read ReadOutQnt03 write WriteOutQnt03;
    property OutQnt04:Str1 read ReadOutQnt04 write WriteOutQnt04;
    property OutQnt05:Str1 read ReadOutQnt05 write WriteOutQnt05;
    property OutQnt06:Str1 read ReadOutQnt06 write WriteOutQnt06;
    property OutQnt07:Str1 read ReadOutQnt07 write WriteOutQnt07;
    property OutQnt08:Str1 read ReadOutQnt08 write WriteOutQnt08;
    property OutQnt09:Str1 read ReadOutQnt09 write WriteOutQnt09;
    property OutQnt10:Str1 read ReadOutQnt10 write WriteOutQnt10;
    property OutQnt11:Str1 read ReadOutQnt11 write WriteOutQnt11;
    property EndQnt01:Str1 read ReadEndQnt01 write WriteEndQnt01;
    property EndQnt02:Str1 read ReadEndQnt02 write WriteEndQnt02;
    property EndQnt03:Str1 read ReadEndQnt03 write WriteEndQnt03;
    property EndQnt04:Str1 read ReadEndQnt04 write WriteEndQnt04;
    property EndQnt05:Str1 read ReadEndQnt05 write WriteEndQnt05;
    property EndQnt06:Str1 read ReadEndQnt06 write WriteEndQnt06;
    property EndQnt07:Str1 read ReadEndQnt07 write WriteEndQnt07;
    property EndQnt08:Str1 read ReadEndQnt08 write WriteEndQnt08;
    property EndQnt09:Str1 read ReadEndQnt09 write WriteEndQnt09;
    property EndQnt10:Str1 read ReadEndQnt10 write WriteEndQnt10;
    property EndQnt11:Str1 read ReadEndQnt11 write WriteEndQnt11;
  end;

implementation

constructor TSrsta_cTmp.Create;
begin
  oTmpTable := TmpInit ('SRSTA_C',Self);
end;

destructor TSrsta_cTmp.Destroy;
begin
  If oTmpTable.Active then oTmpTable.Close;
  FreeAndNil (oTmpTable);
end;

// *************************************** PRIVATE ********************************************

function TSrsta_cTmp.ReadCount:integer;
begin
  Result := oTmpTable.RecordCount;
end;

function TSrsta_cTmp.FieldExist (pFieldName:ShortString): boolean;
begin
  Result := oTmpTable.FindField(pFieldName)<>nil;
end;

function TSrsta_cTmp.ReadSerNum:byte;
begin
  Result := oTmpTable.FieldByName('SerNum').AsInteger;
end;

procedure TSrsta_cTmp.WriteSerNum(pValue:byte);
begin
  oTmpTable.FieldByName('SerNum').AsInteger := pValue;
end;

function TSrsta_cTmp.ReadBegQnt01:Str1;
begin
  Result := oTmpTable.FieldByName('BegQnt01').AsString;
end;

procedure TSrsta_cTmp.WriteBegQnt01(pValue:Str1);
begin
  oTmpTable.FieldByName('BegQnt01').AsString := pValue;
end;

function TSrsta_cTmp.ReadBegQnt02:Str1;
begin
  Result := oTmpTable.FieldByName('BegQnt02').AsString;
end;

procedure TSrsta_cTmp.WriteBegQnt02(pValue:Str1);
begin
  oTmpTable.FieldByName('BegQnt02').AsString := pValue;
end;

function TSrsta_cTmp.ReadBegQnt03:Str1;
begin
  Result := oTmpTable.FieldByName('BegQnt03').AsString;
end;

procedure TSrsta_cTmp.WriteBegQnt03(pValue:Str1);
begin
  oTmpTable.FieldByName('BegQnt03').AsString := pValue;
end;

function TSrsta_cTmp.ReadBegQnt04:Str1;
begin
  Result := oTmpTable.FieldByName('BegQnt04').AsString;
end;

procedure TSrsta_cTmp.WriteBegQnt04(pValue:Str1);
begin
  oTmpTable.FieldByName('BegQnt04').AsString := pValue;
end;

function TSrsta_cTmp.ReadBegQnt05:Str1;
begin
  Result := oTmpTable.FieldByName('BegQnt05').AsString;
end;

procedure TSrsta_cTmp.WriteBegQnt05(pValue:Str1);
begin
  oTmpTable.FieldByName('BegQnt05').AsString := pValue;
end;

function TSrsta_cTmp.ReadBegQnt06:Str1;
begin
  Result := oTmpTable.FieldByName('BegQnt06').AsString;
end;

procedure TSrsta_cTmp.WriteBegQnt06(pValue:Str1);
begin
  oTmpTable.FieldByName('BegQnt06').AsString := pValue;
end;

function TSrsta_cTmp.ReadBegQnt07:Str1;
begin
  Result := oTmpTable.FieldByName('BegQnt07').AsString;
end;

procedure TSrsta_cTmp.WriteBegQnt07(pValue:Str1);
begin
  oTmpTable.FieldByName('BegQnt07').AsString := pValue;
end;

function TSrsta_cTmp.ReadBegQnt08:Str1;
begin
  Result := oTmpTable.FieldByName('BegQnt08').AsString;
end;

procedure TSrsta_cTmp.WriteBegQnt08(pValue:Str1);
begin
  oTmpTable.FieldByName('BegQnt08').AsString := pValue;
end;

function TSrsta_cTmp.ReadBegQnt09:Str1;
begin
  Result := oTmpTable.FieldByName('BegQnt09').AsString;
end;

procedure TSrsta_cTmp.WriteBegQnt09(pValue:Str1);
begin
  oTmpTable.FieldByName('BegQnt09').AsString := pValue;
end;

function TSrsta_cTmp.ReadBegQnt10:Str1;
begin
  Result := oTmpTable.FieldByName('BegQnt10').AsString;
end;

procedure TSrsta_cTmp.WriteBegQnt10(pValue:Str1);
begin
  oTmpTable.FieldByName('BegQnt10').AsString := pValue;
end;

function TSrsta_cTmp.ReadBegQnt11:Str1;
begin
  Result := oTmpTable.FieldByName('BegQnt11').AsString;
end;

procedure TSrsta_cTmp.WriteBegQnt11(pValue:Str1);
begin
  oTmpTable.FieldByName('BegQnt11').AsString := pValue;
end;

function TSrsta_cTmp.ReadIncQnt01:Str1;
begin
  Result := oTmpTable.FieldByName('IncQnt01').AsString;
end;

procedure TSrsta_cTmp.WriteIncQnt01(pValue:Str1);
begin
  oTmpTable.FieldByName('IncQnt01').AsString := pValue;
end;

function TSrsta_cTmp.ReadIncQnt02:Str1;
begin
  Result := oTmpTable.FieldByName('IncQnt02').AsString;
end;

procedure TSrsta_cTmp.WriteIncQnt02(pValue:Str1);
begin
  oTmpTable.FieldByName('IncQnt02').AsString := pValue;
end;

function TSrsta_cTmp.ReadIncQnt03:Str1;
begin
  Result := oTmpTable.FieldByName('IncQnt03').AsString;
end;

procedure TSrsta_cTmp.WriteIncQnt03(pValue:Str1);
begin
  oTmpTable.FieldByName('IncQnt03').AsString := pValue;
end;

function TSrsta_cTmp.ReadIncQnt04:Str1;
begin
  Result := oTmpTable.FieldByName('IncQnt04').AsString;
end;

procedure TSrsta_cTmp.WriteIncQnt04(pValue:Str1);
begin
  oTmpTable.FieldByName('IncQnt04').AsString := pValue;
end;

function TSrsta_cTmp.ReadIncQnt05:Str1;
begin
  Result := oTmpTable.FieldByName('IncQnt05').AsString;
end;

procedure TSrsta_cTmp.WriteIncQnt05(pValue:Str1);
begin
  oTmpTable.FieldByName('IncQnt05').AsString := pValue;
end;

function TSrsta_cTmp.ReadIncQnt06:Str1;
begin
  Result := oTmpTable.FieldByName('IncQnt06').AsString;
end;

procedure TSrsta_cTmp.WriteIncQnt06(pValue:Str1);
begin
  oTmpTable.FieldByName('IncQnt06').AsString := pValue;
end;

function TSrsta_cTmp.ReadIncQnt07:Str1;
begin
  Result := oTmpTable.FieldByName('IncQnt07').AsString;
end;

procedure TSrsta_cTmp.WriteIncQnt07(pValue:Str1);
begin
  oTmpTable.FieldByName('IncQnt07').AsString := pValue;
end;

function TSrsta_cTmp.ReadIncQnt08:Str1;
begin
  Result := oTmpTable.FieldByName('IncQnt08').AsString;
end;

procedure TSrsta_cTmp.WriteIncQnt08(pValue:Str1);
begin
  oTmpTable.FieldByName('IncQnt08').AsString := pValue;
end;

function TSrsta_cTmp.ReadIncQnt09:Str1;
begin
  Result := oTmpTable.FieldByName('IncQnt09').AsString;
end;

procedure TSrsta_cTmp.WriteIncQnt09(pValue:Str1);
begin
  oTmpTable.FieldByName('IncQnt09').AsString := pValue;
end;

function TSrsta_cTmp.ReadIncQnt10:Str1;
begin
  Result := oTmpTable.FieldByName('IncQnt10').AsString;
end;

procedure TSrsta_cTmp.WriteIncQnt10(pValue:Str1);
begin
  oTmpTable.FieldByName('IncQnt10').AsString := pValue;
end;

function TSrsta_cTmp.ReadIncQnt11:Str1;
begin
  Result := oTmpTable.FieldByName('IncQnt11').AsString;
end;

procedure TSrsta_cTmp.WriteIncQnt11(pValue:Str1);
begin
  oTmpTable.FieldByName('IncQnt11').AsString := pValue;
end;

function TSrsta_cTmp.ReadOutQnt01:Str1;
begin
  Result := oTmpTable.FieldByName('OutQnt01').AsString;
end;

procedure TSrsta_cTmp.WriteOutQnt01(pValue:Str1);
begin
  oTmpTable.FieldByName('OutQnt01').AsString := pValue;
end;

function TSrsta_cTmp.ReadOutQnt02:Str1;
begin
  Result := oTmpTable.FieldByName('OutQnt02').AsString;
end;

procedure TSrsta_cTmp.WriteOutQnt02(pValue:Str1);
begin
  oTmpTable.FieldByName('OutQnt02').AsString := pValue;
end;

function TSrsta_cTmp.ReadOutQnt03:Str1;
begin
  Result := oTmpTable.FieldByName('OutQnt03').AsString;
end;

procedure TSrsta_cTmp.WriteOutQnt03(pValue:Str1);
begin
  oTmpTable.FieldByName('OutQnt03').AsString := pValue;
end;

function TSrsta_cTmp.ReadOutQnt04:Str1;
begin
  Result := oTmpTable.FieldByName('OutQnt04').AsString;
end;

procedure TSrsta_cTmp.WriteOutQnt04(pValue:Str1);
begin
  oTmpTable.FieldByName('OutQnt04').AsString := pValue;
end;

function TSrsta_cTmp.ReadOutQnt05:Str1;
begin
  Result := oTmpTable.FieldByName('OutQnt05').AsString;
end;

procedure TSrsta_cTmp.WriteOutQnt05(pValue:Str1);
begin
  oTmpTable.FieldByName('OutQnt05').AsString := pValue;
end;

function TSrsta_cTmp.ReadOutQnt06:Str1;
begin
  Result := oTmpTable.FieldByName('OutQnt06').AsString;
end;

procedure TSrsta_cTmp.WriteOutQnt06(pValue:Str1);
begin
  oTmpTable.FieldByName('OutQnt06').AsString := pValue;
end;

function TSrsta_cTmp.ReadOutQnt07:Str1;
begin
  Result := oTmpTable.FieldByName('OutQnt07').AsString;
end;

procedure TSrsta_cTmp.WriteOutQnt07(pValue:Str1);
begin
  oTmpTable.FieldByName('OutQnt07').AsString := pValue;
end;

function TSrsta_cTmp.ReadOutQnt08:Str1;
begin
  Result := oTmpTable.FieldByName('OutQnt08').AsString;
end;

procedure TSrsta_cTmp.WriteOutQnt08(pValue:Str1);
begin
  oTmpTable.FieldByName('OutQnt08').AsString := pValue;
end;

function TSrsta_cTmp.ReadOutQnt09:Str1;
begin
  Result := oTmpTable.FieldByName('OutQnt09').AsString;
end;

procedure TSrsta_cTmp.WriteOutQnt09(pValue:Str1);
begin
  oTmpTable.FieldByName('OutQnt09').AsString := pValue;
end;

function TSrsta_cTmp.ReadOutQnt10:Str1;
begin
  Result := oTmpTable.FieldByName('OutQnt10').AsString;
end;

procedure TSrsta_cTmp.WriteOutQnt10(pValue:Str1);
begin
  oTmpTable.FieldByName('OutQnt10').AsString := pValue;
end;

function TSrsta_cTmp.ReadOutQnt11:Str1;
begin
  Result := oTmpTable.FieldByName('OutQnt11').AsString;
end;

procedure TSrsta_cTmp.WriteOutQnt11(pValue:Str1);
begin
  oTmpTable.FieldByName('OutQnt11').AsString := pValue;
end;

function TSrsta_cTmp.ReadEndQnt01:Str1;
begin
  Result := oTmpTable.FieldByName('EndQnt01').AsString;
end;

procedure TSrsta_cTmp.WriteEndQnt01(pValue:Str1);
begin
  oTmpTable.FieldByName('EndQnt01').AsString := pValue;
end;

function TSrsta_cTmp.ReadEndQnt02:Str1;
begin
  Result := oTmpTable.FieldByName('EndQnt02').AsString;
end;

procedure TSrsta_cTmp.WriteEndQnt02(pValue:Str1);
begin
  oTmpTable.FieldByName('EndQnt02').AsString := pValue;
end;

function TSrsta_cTmp.ReadEndQnt03:Str1;
begin
  Result := oTmpTable.FieldByName('EndQnt03').AsString;
end;

procedure TSrsta_cTmp.WriteEndQnt03(pValue:Str1);
begin
  oTmpTable.FieldByName('EndQnt03').AsString := pValue;
end;

function TSrsta_cTmp.ReadEndQnt04:Str1;
begin
  Result := oTmpTable.FieldByName('EndQnt04').AsString;
end;

procedure TSrsta_cTmp.WriteEndQnt04(pValue:Str1);
begin
  oTmpTable.FieldByName('EndQnt04').AsString := pValue;
end;

function TSrsta_cTmp.ReadEndQnt05:Str1;
begin
  Result := oTmpTable.FieldByName('EndQnt05').AsString;
end;

procedure TSrsta_cTmp.WriteEndQnt05(pValue:Str1);
begin
  oTmpTable.FieldByName('EndQnt05').AsString := pValue;
end;

function TSrsta_cTmp.ReadEndQnt06:Str1;
begin
  Result := oTmpTable.FieldByName('EndQnt06').AsString;
end;

procedure TSrsta_cTmp.WriteEndQnt06(pValue:Str1);
begin
  oTmpTable.FieldByName('EndQnt06').AsString := pValue;
end;

function TSrsta_cTmp.ReadEndQnt07:Str1;
begin
  Result := oTmpTable.FieldByName('EndQnt07').AsString;
end;

procedure TSrsta_cTmp.WriteEndQnt07(pValue:Str1);
begin
  oTmpTable.FieldByName('EndQnt07').AsString := pValue;
end;

function TSrsta_cTmp.ReadEndQnt08:Str1;
begin
  Result := oTmpTable.FieldByName('EndQnt08').AsString;
end;

procedure TSrsta_cTmp.WriteEndQnt08(pValue:Str1);
begin
  oTmpTable.FieldByName('EndQnt08').AsString := pValue;
end;

function TSrsta_cTmp.ReadEndQnt09:Str1;
begin
  Result := oTmpTable.FieldByName('EndQnt09').AsString;
end;

procedure TSrsta_cTmp.WriteEndQnt09(pValue:Str1);
begin
  oTmpTable.FieldByName('EndQnt09').AsString := pValue;
end;

function TSrsta_cTmp.ReadEndQnt10:Str1;
begin
  Result := oTmpTable.FieldByName('EndQnt10').AsString;
end;

procedure TSrsta_cTmp.WriteEndQnt10(pValue:Str1);
begin
  oTmpTable.FieldByName('EndQnt10').AsString := pValue;
end;

function TSrsta_cTmp.ReadEndQnt11:Str1;
begin
  Result := oTmpTable.FieldByName('EndQnt11').AsString;
end;

procedure TSrsta_cTmp.WriteEndQnt11(pValue:Str1);
begin
  oTmpTable.FieldByName('EndQnt11').AsString := pValue;
end;

// **************************************** PUBLIC ********************************************

function TSrsta_cTmp.Eof: boolean;
begin
  Result := oTmpTable.Eof;
end;

function TSrsta_cTmp.Active: boolean;
begin
  Result := oTmpTable.Active;
end;

function TSrsta_cTmp.LocateSerNum (pSerNum:byte):boolean;
begin
  SetIndex (ixSerNum);
  Result := oTmpTable.FindKey([pSerNum]);
end;

procedure TSrsta_cTmp.SetIndex (pIndexName:ShortString);
begin
  If oTmpTable.IndexName<>pIndexName then oTmpTable.IndexName := pIndexName;
end;

procedure TSrsta_cTmp.Open;
begin
  oTmpTable.Open;
end;

procedure TSrsta_cTmp.Close;
begin
  If oTmpTable.Active then oTmpTable.Close;
end;

procedure TSrsta_cTmp.Prior;
begin
  oTmpTable.Prior;
end;

procedure TSrsta_cTmp.Next;
begin
  oTmpTable.Next;
end;

procedure TSrsta_cTmp.First;
begin
  oTmpTable.First;
end;

procedure TSrsta_cTmp.Last;
begin
  oTmpTable.Last;
end;

procedure TSrsta_cTmp.Insert;
begin
  oTmpTable.Insert;
end;

procedure TSrsta_cTmp.Edit;
begin
  oTmpTable.Edit;
end;

procedure TSrsta_cTmp.Post;
var mEdit:boolean;
begin
  oTmpTable.Post;
end;

procedure TSrsta_cTmp.Delete;
begin
  oTmpTable.Delete;
end;

procedure TSrsta_cTmp.SwapIndex;
begin
  oTmpTable.SwapIndex;
end;

procedure TSrsta_cTmp.RestoreIndex;
begin
  oTmpTable.RestoreIndex;
end;

procedure TSrsta_cTmp.SwapStatus;
begin
  oTmpTable.SwapStatus;
end;

procedure TSrsta_cTmp.RestoreStatus;
begin
  oTmpTable.RestoreStatus;
end;

procedure TSrsta_cTmp.EnableControls;
begin
  oTmpTable.EnableControls;
end;

procedure TSrsta_cTmp.DisableControls;
begin
  oTmpTable.DisableControls;
end;

end.
