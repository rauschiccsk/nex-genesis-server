unit bTRMLST;

interface

uses
  IcTypes, IcConv, NexPath, NexGlob,
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls,
  Dialogs, DB, NexBtrTable, DBTables, NexPxTable;

const
  ixTrmNum = 'TrmNum';

type
  TTrmlstBtr = class (TComponent)
    constructor Create; overload;
    destructor  Destroy; override;
  private
    oBtrTable: TNexBtrTable;
    function ReadCount:integer;
    function FieldExist (pFieldName:ShortString): boolean;
    // Pristup k databazovym poliam
    function  ReadTrmNum:byte;           procedure WriteTrmNum (pValue:byte);
    function  ReadTrmType:Str10;         procedure WriteTrmType (pValue:Str10);
    function  ReadTrmName:Str30;         procedure WriteTrmName (pValue:Str30);
    function  ReadRwsUsrc:Str8;          procedure WriteRwsUsrc (pValue:Str8);
    function  ReadWriNum:word;           procedure WriteWriNum (pValue:word);
    function  ReadStkNum:word;           procedure WriteStkNum (pValue:word);
    function  ReadPlsNum:word;           procedure WritePlsNum (pValue:word);
    function  ReadTibNum:Str5;           procedure WriteTibNum (pValue:Str5);
    function  ReadTobNum:Str5;           procedure WriteTobNum (pValue:Str5);
    function  ReadIvdNum:Str12;          procedure WriteIvdNum (pValue:Str12);
    function  ReadIvlNum:word;           procedure WriteIvlNum (pValue:word);
    function  ReadIvFase:byte;           procedure WriteIvFase (pValue:byte);
    function  ReadCrtUser:Str8;          procedure WriteCrtUser (pValue:Str8);
    function  ReadCrtDate:TDatetime;     procedure WriteCrtDate (pValue:TDatetime);
    function  ReadCrtTime:TDatetime;     procedure WriteCrtTime (pValue:TDatetime);
    function  ReadModNum:word;           procedure WriteModNum (pValue:word);
    function  ReadModUser:Str8;          procedure WriteModUser (pValue:Str8);
    function  ReadModDate:TDatetime;     procedure WriteModDate (pValue:TDatetime);
    function  ReadModTime:TDatetime;     procedure WriteModTime (pValue:TDatetime);
    function  ReadMcbNum:Str5;           procedure WriteMcbNum (pValue:Str5);
    function  ReadMnuDef:Str250;         procedure WriteMnuDef (pValue:Str250);
  public
    constructor Create(pPath:ShortString); overload;
    // Elementarne databazove operacie
    function Eof: boolean;
    function IsFirstRec: boolean;
    function IsLastRec: boolean;
    function Active: boolean;
    function ActPos: longint;
    function GotoPos (pActPos:longint): boolean;
    function LocateTrmNum (pTrmNum:byte):boolean;
    function NearestTrmNum (pTrmNum:byte):boolean;

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
    procedure EnableControls;
    procedure DisableControls;
  published
    property BtrTable:TNexBtrTable read oBtrTable;
    property Count:integer read ReadCount;
    // Pristup k databazovym poliam
    property TrmNum:byte read ReadTrmNum write WriteTrmNum;
    property TrmType:Str10 read ReadTrmType write WriteTrmType;
    property TrmName:Str30 read ReadTrmName write WriteTrmName;
    property RwsUsrc:Str8 read ReadRwsUsrc write WriteRwsUsrc;
    property WriNum:word read ReadWriNum write WriteWriNum;
    property StkNum:word read ReadStkNum write WriteStkNum;
    property PlsNum:word read ReadPlsNum write WritePlsNum;
    property TibNum:Str5 read ReadTibNum write WriteTibNum;
    property TobNum:Str5 read ReadTobNum write WriteTobNum;
    property IvdNum:Str12 read ReadIvdNum write WriteIvdNum;
    property IvlNum:word read ReadIvlNum write WriteIvlNum;
    property IvFase:byte read ReadIvFase write WriteIvFase;
    property CrtUser:Str8 read ReadCrtUser write WriteCrtUser;
    property CrtDate:TDatetime read ReadCrtDate write WriteCrtDate;
    property CrtTime:TDatetime read ReadCrtTime write WriteCrtTime;
    property ModNum:word read ReadModNum write WriteModNum;
    property ModUser:Str8 read ReadModUser write WriteModUser;
    property ModDate:TDatetime read ReadModDate write WriteModDate;
    property ModTime:TDatetime read ReadModTime write WriteModTime;
    property McbNum:Str5 read ReadMcbNum write WriteMcbNum;
    property MnuDef:Str250 read ReadMnuDef write WriteMnuDef;
  end;

implementation

constructor TTrmlstBtr.Create;
begin
  oBtrTable := BtrInit ('TRMLST',gPath.StkPath,Self);
end;

constructor TTrmlstBtr.Create(pPath:ShortString);
begin
  oBtrTable := BtrInit ('TRMLST',pPath,Self);
end;

destructor TTrmlstBtr.Destroy;
begin
  oBtrTable.Close;  FreeAndNil (oBtrTable);
end;

// *************************************** PRIVATE ********************************************

function TTrmlstBtr.ReadCount:integer;
begin
  Result := oBtrTable.RecordCount;
end;

function TTrmlstBtr.FieldExist (pFieldName:ShortString): boolean;
begin
  Result := oBtrTable.FindField(pFieldName)<>nil;
end;

function TTrmlstBtr.ReadTrmNum:byte;
begin
  Result := oBtrTable.FieldByName('TrmNum').AsInteger;
end;

procedure TTrmlstBtr.WriteTrmNum(pValue:byte);
begin
  oBtrTable.FieldByName('TrmNum').AsInteger := pValue;
end;

function TTrmlstBtr.ReadTrmType:Str10;
begin
  Result := oBtrTable.FieldByName('TrmType').AsString;
end;

procedure TTrmlstBtr.WriteTrmType(pValue:Str10);
begin
  oBtrTable.FieldByName('TrmType').AsString := pValue;
end;

function TTrmlstBtr.ReadTrmName:Str30;
begin
  Result := oBtrTable.FieldByName('TrmName').AsString;
end;

procedure TTrmlstBtr.WriteTrmName(pValue:Str30);
begin
  oBtrTable.FieldByName('TrmName').AsString := pValue;
end;

function TTrmlstBtr.ReadRwsUsrc:Str8;
begin
  Result := oBtrTable.FieldByName('RwsUsrc').AsString;
end;

procedure TTrmlstBtr.WriteRwsUsrc(pValue:Str8);
begin
  oBtrTable.FieldByName('RwsUsrc').AsString := pValue;
end;

function TTrmlstBtr.ReadWriNum:word;
begin
  Result := oBtrTable.FieldByName('WriNum').AsInteger;
end;

procedure TTrmlstBtr.WriteWriNum(pValue:word);
begin
  oBtrTable.FieldByName('WriNum').AsInteger := pValue;
end;

function TTrmlstBtr.ReadStkNum:word;
begin
  Result := oBtrTable.FieldByName('StkNum').AsInteger;
end;

procedure TTrmlstBtr.WriteStkNum(pValue:word);
begin
  oBtrTable.FieldByName('StkNum').AsInteger := pValue;
end;

function TTrmlstBtr.ReadPlsNum:word;
begin
  Result := oBtrTable.FieldByName('PlsNum').AsInteger;
end;

procedure TTrmlstBtr.WritePlsNum(pValue:word);
begin
  oBtrTable.FieldByName('PlsNum').AsInteger := pValue;
end;

function TTrmlstBtr.ReadTibNum:Str5;
begin
  Result := oBtrTable.FieldByName('TibNum').AsString;
end;

procedure TTrmlstBtr.WriteTibNum(pValue:Str5);
begin
  oBtrTable.FieldByName('TibNum').AsString := pValue;
end;

function TTrmlstBtr.ReadTobNum:Str5;
begin
  Result := oBtrTable.FieldByName('TobNum').AsString;
end;

procedure TTrmlstBtr.WriteTobNum(pValue:Str5);
begin
  oBtrTable.FieldByName('TobNum').AsString := pValue;
end;

function TTrmlstBtr.ReadIvdNum:Str12;
begin
  Result := oBtrTable.FieldByName('IvdNum').AsString;
end;

procedure TTrmlstBtr.WriteIvdNum(pValue:Str12);
begin
  oBtrTable.FieldByName('IvdNum').AsString := pValue;
end;

function TTrmlstBtr.ReadIvlNum:word;
begin
  Result := oBtrTable.FieldByName('IvlNum').AsInteger;
end;

procedure TTrmlstBtr.WriteIvlNum(pValue:word);
begin
  oBtrTable.FieldByName('IvlNum').AsInteger := pValue;
end;

function TTrmlstBtr.ReadIvFase:byte;
begin
  Result := oBtrTable.FieldByName('IvFase').AsInteger;
end;

procedure TTrmlstBtr.WriteIvFase(pValue:byte);
begin
  oBtrTable.FieldByName('IvFase').AsInteger := pValue;
end;

function TTrmlstBtr.ReadCrtUser:Str8;
begin
  Result := oBtrTable.FieldByName('CrtUser').AsString;
end;

procedure TTrmlstBtr.WriteCrtUser(pValue:Str8);
begin
  oBtrTable.FieldByName('CrtUser').AsString := pValue;
end;

function TTrmlstBtr.ReadCrtDate:TDatetime;
begin
  Result := oBtrTable.FieldByName('CrtDate').AsDateTime;
end;

procedure TTrmlstBtr.WriteCrtDate(pValue:TDatetime);
begin
  oBtrTable.FieldByName('CrtDate').AsDateTime := pValue;
end;

function TTrmlstBtr.ReadCrtTime:TDatetime;
begin
  Result := oBtrTable.FieldByName('CrtTime').AsDateTime;
end;

procedure TTrmlstBtr.WriteCrtTime(pValue:TDatetime);
begin
  oBtrTable.FieldByName('CrtTime').AsDateTime := pValue;
end;

function TTrmlstBtr.ReadModNum:word;
begin
  Result := oBtrTable.FieldByName('ModNum').AsInteger;
end;

procedure TTrmlstBtr.WriteModNum(pValue:word);
begin
  oBtrTable.FieldByName('ModNum').AsInteger := pValue;
end;

function TTrmlstBtr.ReadModUser:Str8;
begin
  Result := oBtrTable.FieldByName('ModUser').AsString;
end;

procedure TTrmlstBtr.WriteModUser(pValue:Str8);
begin
  oBtrTable.FieldByName('ModUser').AsString := pValue;
end;

function TTrmlstBtr.ReadModDate:TDatetime;
begin
  Result := oBtrTable.FieldByName('ModDate').AsDateTime;
end;

procedure TTrmlstBtr.WriteModDate(pValue:TDatetime);
begin
  oBtrTable.FieldByName('ModDate').AsDateTime := pValue;
end;

function TTrmlstBtr.ReadModTime:TDatetime;
begin
  Result := oBtrTable.FieldByName('ModTime').AsDateTime;
end;

procedure TTrmlstBtr.WriteModTime(pValue:TDatetime);
begin
  oBtrTable.FieldByName('ModTime').AsDateTime := pValue;
end;

function TTrmlstBtr.ReadMcbNum:Str5;
begin
  Result := oBtrTable.FieldByName('McbNum').AsString;
end;

procedure TTrmlstBtr.WriteMcbNum(pValue:Str5);
begin
  oBtrTable.FieldByName('McbNum').AsString := pValue;
end;

function TTrmlstBtr.ReadMnuDef:Str250;
begin
  Result := oBtrTable.FieldByName('MnuDef').AsString;
end;

procedure TTrmlstBtr.WriteMnuDef(pValue:Str250);
begin
  oBtrTable.FieldByName('MnuDef').AsString := pValue;
end;

// **************************************** PUBLIC ********************************************

function TTrmlstBtr.Eof: boolean;
begin
  Result := oBtrTable.Eof;
end;

function TTrmlstBtr.IsFirstRec: boolean;
begin
  Result := oBtrTable.Bof;
end;

function TTrmlstBtr.IsLastRec: boolean;
begin
  Result := oBtrTable.Eof;
end;

function TTrmlstBtr.Active: boolean;
begin
  Result := oBtrTable.Active;
end;

function TTrmlstBtr.ActPos: longint;
begin
  Result := oBtrTable.ActPos;
end;

function TTrmlstBtr.GotoPos (pActPos:longint): boolean;
begin
  Result := oBtrTable.GotoPos(pActPos);
end;

function TTrmlstBtr.LocateTrmNum (pTrmNum:byte):boolean;
begin
  SetIndex (ixTrmNum);
  Result := oBtrTable.FindKey([pTrmNum]);
end;

function TTrmlstBtr.NearestTrmNum (pTrmNum:byte):boolean;
begin
  SetIndex (ixTrmNum);
  Result := oBtrTable.FindNearest([pTrmNum]);
end;

procedure TTrmlstBtr.SetIndex (pIndexName:ShortString);
begin
  If oBtrTable.IndexName<>pIndexName then oBtrTable.IndexName := pIndexName;
end;

procedure TTrmlstBtr.Open;
begin
  oBtrTable.Open;
end;

procedure TTrmlstBtr.Close;
begin
  If oBtrTable.Active then oBtrTable.Close;
end;

procedure TTrmlstBtr.Prior;
begin
  oBtrTable.Prior;
end;

procedure TTrmlstBtr.Next;
begin
  oBtrTable.Next;
end;

procedure TTrmlstBtr.First;
begin
  oBtrTable.First;
end;

procedure TTrmlstBtr.Last;
begin
  oBtrTable.Last;
end;

procedure TTrmlstBtr.Insert;
begin
  oBtrTable.Insert;
end;

procedure TTrmlstBtr.Edit;
begin
  oBtrTable.Edit;
end;

procedure TTrmlstBtr.Post;
begin
  oBtrTable.Post;
end;

procedure TTrmlstBtr.Delete;
begin
  oBtrTable.Delete;
end;

procedure TTrmlstBtr.SwapIndex;
begin
  oBtrTable.SwapIndex;
end;

procedure TTrmlstBtr.RestoreIndex;
begin
  oBtrTable.RestoreIndex;
end;

procedure TTrmlstBtr.SwapStatus;
begin
  oBtrTable.SwapStatus;
end;

procedure TTrmlstBtr.RestoreStatus;
begin
  oBtrTable.RestoreStatus;
end;

procedure TTrmlstBtr.EnableControls;
begin
  oBtrTable.EnableControls;
end;

procedure TTrmlstBtr.DisableControls;
begin
  oBtrTable.DisableControls;
end;

end.
{MOD 1928001}
