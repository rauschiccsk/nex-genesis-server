unit bIMW;

interface

uses
  IcTypes, IcConv, NexPath, NexGlob,
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls,
  Dialogs, DB, NexBtrTable, DBTables, NexPxTable;

const
  ixDocNum = 'DocNum';
  ixDoIt = 'DoIt';
  ixDoItRn = 'DoItRn';

type
  TImwBtr = class (TComponent)
    constructor Create; overload;
    destructor  Destroy; override;
  private
    oBookNum: Str5;
    oBtrTable: TNexBtrTable;
    function ReadCount:integer;
    function FieldExist (pFieldName:ShortString): boolean;
    // Pristup k databazovym poliam
    function  ReadDocNum:Str12;          procedure WriteDocNum (pValue:Str12);
    function  ReadItmNum:word;           procedure WriteItmNum (pValue:word);
    function  ReadRowNum:word;           procedure WriteRowNum (pValue:word);
    function  ReadGsCode:longint;        procedure WriteGsCode (pValue:longint);
    function  ReadGsName:Str30;          procedure WriteGsName (pValue:Str30);
    function  ReadBaCode:Str15;          procedure WriteBaCode (pValue:Str15);
    function  ReadMsName:Str10;          procedure WriteMsName (pValue:Str10);
    function  ReadGsQnt:double;          procedure WriteGsQnt (pValue:double);
    function  ReadCPrice:double;         procedure WriteCPrice (pValue:double);
    function  ReadCValue:double;         procedure WriteCValue (pValue:double);
    function  ReadRbaCod:Str30;          procedure WriteRbaCod (pValue:Str30);
    function  ReadRbaDat:TDatetime;      procedure WriteRbaDat (pValue:TDatetime);
  public
    constructor Create(pPath:ShortString); overload;
    // Elementarne databazove operacie
    function Eof: boolean;
    function IsFirstRec: boolean;
    function IsLastRec: boolean;
    function Active: boolean;
    function ActPos: longint;
    function GotoPos (pActPos:longint): boolean;
    function LocateDocNum (pDocNum:Str12):boolean;
    function LocateDoIt (pDocNum:Str12;pItmNum:word):boolean;
    function LocateDoItRn (pDocNum:Str12;pItmNum:word;pRowNum:word):boolean;
    function NearestDocNum (pDocNum:Str12):boolean;
    function NearestDoIt (pDocNum:Str12;pItmNum:word):boolean;
    function NearestDoItRn (pDocNum:Str12;pItmNum:word;pRowNum:word):boolean;

    procedure SetIndex (pIndexName:ShortString);
    procedure Open (pBookNum:Str5);
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
    procedure EnableControls;
    procedure DisableControls;
  published
    property BtrTable:TNexBtrTable read oBtrTable;
    property Count:integer read ReadCount;
    // Pristup k databazovym poliam
    property DocNum:Str12 read ReadDocNum write WriteDocNum;
    property ItmNum:word read ReadItmNum write WriteItmNum;
    property RowNum:word read ReadRowNum write WriteRowNum;
    property GsCode:longint read ReadGsCode write WriteGsCode;
    property GsName:Str30 read ReadGsName write WriteGsName;
    property BaCode:Str15 read ReadBaCode write WriteBaCode;
    property MsName:Str10 read ReadMsName write WriteMsName;
    property GsQnt:double read ReadGsQnt write WriteGsQnt;
    property CPrice:double read ReadCPrice write WriteCPrice;
    property CValue:double read ReadCValue write WriteCValue;
    property RbaCod:Str30 read ReadRbaCod write WriteRbaCod;
    property RbaDat:TDatetime read ReadRbaDat write WriteRbaDat;
  end;

implementation

constructor TImwBtr.Create;
begin
  oBtrTable := BtrInit ('IMW',gPath.StkPath,Self);
end;

constructor TImwBtr.Create(pPath:ShortString);
begin
  oBtrTable := BtrInit ('IMW',pPath,Self);
end;

destructor TImwBtr.Destroy;
begin
  oBtrTable.Close;  FreeAndNil (oBtrTable);
end;

// *************************************** PRIVATE ********************************************

function TImwBtr.ReadCount:integer;
begin
  Result := oBtrTable.RecordCount;
end;

function TImwBtr.FieldExist (pFieldName:ShortString): boolean;
begin
  Result := oBtrTable.FindField(pFieldName)<>nil;
end;

function TImwBtr.ReadDocNum:Str12;
begin
  Result := oBtrTable.FieldByName('DocNum').AsString;
end;

procedure TImwBtr.WriteDocNum(pValue:Str12);
begin
  oBtrTable.FieldByName('DocNum').AsString := pValue;
end;

function TImwBtr.ReadItmNum:word;
begin
  Result := oBtrTable.FieldByName('ItmNum').AsInteger;
end;

procedure TImwBtr.WriteItmNum(pValue:word);
begin
  oBtrTable.FieldByName('ItmNum').AsInteger := pValue;
end;

function TImwBtr.ReadRowNum:word;
begin
  Result := oBtrTable.FieldByName('RowNum').AsInteger;
end;

procedure TImwBtr.WriteRowNum(pValue:word);
begin
  oBtrTable.FieldByName('RowNum').AsInteger := pValue;
end;

function TImwBtr.ReadGsCode:longint;
begin
  Result := oBtrTable.FieldByName('GsCode').AsInteger;
end;

procedure TImwBtr.WriteGsCode(pValue:longint);
begin
  oBtrTable.FieldByName('GsCode').AsInteger := pValue;
end;

function TImwBtr.ReadGsName:Str30;
begin
  Result := oBtrTable.FieldByName('GsName').AsString;
end;

procedure TImwBtr.WriteGsName(pValue:Str30);
begin
  oBtrTable.FieldByName('GsName').AsString := pValue;
end;

function TImwBtr.ReadBaCode:Str15;
begin
  Result := oBtrTable.FieldByName('BaCode').AsString;
end;

procedure TImwBtr.WriteBaCode(pValue:Str15);
begin
  oBtrTable.FieldByName('BaCode').AsString := pValue;
end;

function TImwBtr.ReadMsName:Str10;
begin
  Result := oBtrTable.FieldByName('MsName').AsString;
end;

procedure TImwBtr.WriteMsName(pValue:Str10);
begin
  oBtrTable.FieldByName('MsName').AsString := pValue;
end;

function TImwBtr.ReadGsQnt:double;
begin
  Result := oBtrTable.FieldByName('GsQnt').AsFloat;
end;

procedure TImwBtr.WriteGsQnt(pValue:double);
begin
  oBtrTable.FieldByName('GsQnt').AsFloat := pValue;
end;

function TImwBtr.ReadCPrice:double;
begin
  Result := oBtrTable.FieldByName('CPrice').AsFloat;
end;

procedure TImwBtr.WriteCPrice(pValue:double);
begin
  oBtrTable.FieldByName('CPrice').AsFloat := pValue;
end;

function TImwBtr.ReadCValue:double;
begin
  Result := oBtrTable.FieldByName('CValue').AsFloat;
end;

procedure TImwBtr.WriteCValue(pValue:double);
begin
  oBtrTable.FieldByName('CValue').AsFloat := pValue;
end;

function TImwBtr.ReadRbaCod:Str30;
begin
  Result := oBtrTable.FieldByName('RbaCod').AsString;
end;

procedure TImwBtr.WriteRbaCod(pValue:Str30);
begin
  oBtrTable.FieldByName('RbaCod').AsString := pValue;
end;

function TImwBtr.ReadRbaDat:TDatetime;
begin
  Result := oBtrTable.FieldByName('RbaDat').AsDateTime;
end;

procedure TImwBtr.WriteRbaDat(pValue:TDatetime);
begin
  oBtrTable.FieldByName('RbaDat').AsDateTime := pValue;
end;

// **************************************** PUBLIC ********************************************

function TImwBtr.Eof: boolean;
begin
  Result := oBtrTable.Eof;
end;

function TImwBtr.IsFirstRec: boolean;
begin
  Result := oBtrTable.Bof;
end;

function TImwBtr.IsLastRec: boolean;
begin
  Result := oBtrTable.Eof;
end;

function TImwBtr.Active: boolean;
begin
  Result := oBtrTable.Active;
end;

function TImwBtr.ActPos: longint;
begin
  Result := oBtrTable.ActPos;
end;

function TImwBtr.GotoPos (pActPos:longint): boolean;
begin
  Result := oBtrTable.GotoPos(pActPos);
end;

function TImwBtr.LocateDocNum (pDocNum:Str12):boolean;
begin
  SetIndex (ixDocNum);
  Result := oBtrTable.FindKey([pDocNum]);
end;

function TImwBtr.LocateDoIt (pDocNum:Str12;pItmNum:word):boolean;
begin
  SetIndex (ixDoIt);
  Result := oBtrTable.FindKey([pDocNum,pItmNum]);
end;

function TImwBtr.LocateDoItRn (pDocNum:Str12;pItmNum:word;pRowNum:word):boolean;
begin
  SetIndex (ixDoItRn);
  Result := oBtrTable.FindKey([pDocNum,pItmNum,pRowNum]);
end;

function TImwBtr.NearestDocNum (pDocNum:Str12):boolean;
begin
  SetIndex (ixDocNum);
  Result := oBtrTable.FindNearest([pDocNum]);
end;

function TImwBtr.NearestDoIt (pDocNum:Str12;pItmNum:word):boolean;
begin
  SetIndex (ixDoIt);
  Result := oBtrTable.FindNearest([pDocNum,pItmNum]);
end;

function TImwBtr.NearestDoItRn (pDocNum:Str12;pItmNum:word;pRowNum:word):boolean;
begin
  SetIndex (ixDoItRn);
  Result := oBtrTable.FindNearest([pDocNum,pItmNum,pRowNum]);
end;

procedure TImwBtr.SetIndex (pIndexName:ShortString);
begin
  If oBtrTable.IndexName<>pIndexName then oBtrTable.IndexName := pIndexName;
end;

procedure TImwBtr.Open(pBookNum:Str5);
begin
  oBookNum := pBookNum;
  oBtrTable.Open(pBookNum);
end;

procedure TImwBtr.Close;
begin
  If oBtrTable.Active then oBtrTable.Close;
end;

procedure TImwBtr.Prior;
begin
  oBtrTable.Prior;
end;

procedure TImwBtr.Next;
begin
  oBtrTable.Next;
end;

procedure TImwBtr.First;
begin
  oBtrTable.First;
end;

procedure TImwBtr.Last;
begin
  oBtrTable.Last;
end;

procedure TImwBtr.Insert;
begin
  oBtrTable.Insert;
end;

procedure TImwBtr.Edit;
begin
  oBtrTable.Edit;
end;

procedure TImwBtr.Post;
begin
  oBtrTable.Post;
end;

procedure TImwBtr.Delete;
begin
  oBtrTable.Delete;
end;

procedure TImwBtr.SwapIndex;
begin
  oBtrTable.SwapIndex;
end;

procedure TImwBtr.RestoreIndex;
begin
  oBtrTable.RestoreIndex;
end;

procedure TImwBtr.SwapStatus;
begin
  oBtrTable.SwapStatus;
end;

procedure TImwBtr.RestoreStatus;
begin
  oBtrTable.RestoreStatus;
end;

procedure TImwBtr.EnableControls;
begin
  oBtrTable.EnableControls;
end;

procedure TImwBtr.DisableControls;
begin
  oBtrTable.DisableControls;
end;

end.
{MOD 1926001}
