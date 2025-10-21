unit bWGCLST;

interface

uses
  IcTypes, IcConv, NexPath, NexGlob,
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls,
  Dialogs, DB, NexBtrTable, DBTables, NexPxTable;

const
  ixBarCode = 'BarCode';
  ixWghDate = 'WghDate';
  ixSalDate = 'SalDate';

type
  TWgclstBtr = class (TComponent)
    constructor Create; overload;
    destructor  Destroy; override;
  private
    oBtrTable: TNexBtrTable;
    function ReadCount:integer;
    function FieldExist (pFieldName:ShortString): boolean;
    // Pristup k databazovym poliam
    function  ReadBarCode:Str15;         procedure WriteBarCode (pValue:Str15);
    function  ReadWeight:double;         procedure WriteWeight (pValue:double);
    function  ReadGsCode:longint;        procedure WriteGsCode (pValue:longint);
    function  ReadWgCode:longint;        procedure WriteWgCode (pValue:longint);
    function  ReadWghDate:TDatetime;     procedure WriteWghDate (pValue:TDatetime);
    function  ReadSalDate:TDatetime;     procedure WriteSalDate (pValue:TDatetime);
    function  ReadBPrice:double;         procedure WriteBPrice (pValue:double);
    function  ReadBValue:double;         procedure WriteBValue (pValue:double);
    function  ReadSecNum:word;           procedure WriteSecNum (pValue:word);
    function  ReadCrtUser:Str8;          procedure WriteCrtUser (pValue:Str8);
    function  ReadCrtDate:TDatetime;     procedure WriteCrtDate (pValue:TDatetime);
    function  ReadCrtTime:TDatetime;     procedure WriteCrtTime (pValue:TDatetime);
    function  ReadModNum:word;           procedure WriteModNum (pValue:word);
    function  ReadModUser:Str8;          procedure WriteModUser (pValue:Str8);
    function  ReadModDate:TDatetime;     procedure WriteModDate (pValue:TDatetime);
    function  ReadModTime:TDatetime;     procedure WriteModTime (pValue:TDatetime);
  public
    constructor Create(pPath:ShortString); overload;
    // Elementarne databazove operacie
    function Eof: boolean;
    function IsFirstRec: boolean;
    function IsLastRec: boolean;
    function Active: boolean;
    function ActPos: longint;
    function GotoPos (pActPos:longint): boolean;
    function LocateBarCode (pBarCode:Str15):boolean;
    function LocateWghDate (pWghDate:TDatetime):boolean;
    function LocateSalDate (pSalDate:TDatetime):boolean;
    function NearestBarCode (pBarCode:Str15):boolean;
    function NearestWghDate (pWghDate:TDatetime):boolean;
    function NearestSalDate (pSalDate:TDatetime):boolean;

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
    property BarCode:Str15 read ReadBarCode write WriteBarCode;
    property Weight:double read ReadWeight write WriteWeight;
    property GsCode:longint read ReadGsCode write WriteGsCode;
    property WgCode:longint read ReadWgCode write WriteWgCode;
    property WghDate:TDatetime read ReadWghDate write WriteWghDate;
    property SalDate:TDatetime read ReadSalDate write WriteSalDate;
    property BPrice:double read ReadBPrice write WriteBPrice;
    property BValue:double read ReadBValue write WriteBValue;
    property SecNum:word read ReadSecNum write WriteSecNum;
    property CrtUser:Str8 read ReadCrtUser write WriteCrtUser;
    property CrtDate:TDatetime read ReadCrtDate write WriteCrtDate;
    property CrtTime:TDatetime read ReadCrtTime write WriteCrtTime;
    property ModNum:word read ReadModNum write WriteModNum;
    property ModUser:Str8 read ReadModUser write WriteModUser;
    property ModDate:TDatetime read ReadModDate write WriteModDate;
    property ModTime:TDatetime read ReadModTime write WriteModTime;
  end;

implementation

constructor TWgclstBtr.Create;
begin
  oBtrTable := BtrInit ('WGCLST',gPath.DlsPath,Self);
end;

constructor TWgclstBtr.Create(pPath:ShortString);
begin
  oBtrTable := BtrInit ('WGCLST',pPath,Self);
end;

destructor TWgclstBtr.Destroy;
begin
  oBtrTable.Close;  FreeAndNil (oBtrTable);
end;

// *************************************** PRIVATE ********************************************

function TWgclstBtr.ReadCount:integer;
begin
  Result := oBtrTable.RecordCount;
end;

function TWgclstBtr.FieldExist (pFieldName:ShortString): boolean;
begin
  Result := oBtrTable.FindField(pFieldName)<>nil;
end;

function TWgclstBtr.ReadBarCode:Str15;
begin
  Result := oBtrTable.FieldByName('BarCode').AsString;
end;

procedure TWgclstBtr.WriteBarCode(pValue:Str15);
begin
  oBtrTable.FieldByName('BarCode').AsString := pValue;
end;

function TWgclstBtr.ReadWeight:double;
begin
  Result := oBtrTable.FieldByName('Weight').AsFloat;
end;

procedure TWgclstBtr.WriteWeight(pValue:double);
begin
  oBtrTable.FieldByName('Weight').AsFloat := pValue;
end;

function TWgclstBtr.ReadGsCode:longint;
begin
  Result := oBtrTable.FieldByName('GsCode').AsInteger;
end;

procedure TWgclstBtr.WriteGsCode(pValue:longint);
begin
  oBtrTable.FieldByName('GsCode').AsInteger := pValue;
end;

function TWgclstBtr.ReadWgCode:longint;
begin
  Result := oBtrTable.FieldByName('WgCode').AsInteger;
end;

procedure TWgclstBtr.WriteWgCode(pValue:longint);
begin
  oBtrTable.FieldByName('WgCode').AsInteger := pValue;
end;

function TWgclstBtr.ReadWghDate:TDatetime;
begin
  Result := oBtrTable.FieldByName('WghDate').AsDateTime;
end;

procedure TWgclstBtr.WriteWghDate(pValue:TDatetime);
begin
  oBtrTable.FieldByName('WghDate').AsDateTime := pValue;
end;

function TWgclstBtr.ReadSalDate:TDatetime;
begin
  Result := oBtrTable.FieldByName('SalDate').AsDateTime;
end;

procedure TWgclstBtr.WriteSalDate(pValue:TDatetime);
begin
  oBtrTable.FieldByName('SalDate').AsDateTime := pValue;
end;

function TWgclstBtr.ReadBPrice:double;
begin
  Result := oBtrTable.FieldByName('BPrice').AsFloat;
end;

procedure TWgclstBtr.WriteBPrice(pValue:double);
begin
  oBtrTable.FieldByName('BPrice').AsFloat := pValue;
end;

function TWgclstBtr.ReadBValue:double;
begin
  Result := oBtrTable.FieldByName('BValue').AsFloat;
end;

procedure TWgclstBtr.WriteBValue(pValue:double);
begin
  oBtrTable.FieldByName('BValue').AsFloat := pValue;
end;

function TWgclstBtr.ReadSecNum:word;
begin
  Result := oBtrTable.FieldByName('SecNum').AsInteger;
end;

procedure TWgclstBtr.WriteSecNum(pValue:word);
begin
  oBtrTable.FieldByName('SecNum').AsInteger := pValue;
end;

function TWgclstBtr.ReadCrtUser:Str8;
begin
  Result := oBtrTable.FieldByName('CrtUser').AsString;
end;

procedure TWgclstBtr.WriteCrtUser(pValue:Str8);
begin
  oBtrTable.FieldByName('CrtUser').AsString := pValue;
end;

function TWgclstBtr.ReadCrtDate:TDatetime;
begin
  Result := oBtrTable.FieldByName('CrtDate').AsDateTime;
end;

procedure TWgclstBtr.WriteCrtDate(pValue:TDatetime);
begin
  oBtrTable.FieldByName('CrtDate').AsDateTime := pValue;
end;

function TWgclstBtr.ReadCrtTime:TDatetime;
begin
  Result := oBtrTable.FieldByName('CrtTime').AsDateTime;
end;

procedure TWgclstBtr.WriteCrtTime(pValue:TDatetime);
begin
  oBtrTable.FieldByName('CrtTime').AsDateTime := pValue;
end;

function TWgclstBtr.ReadModNum:word;
begin
  Result := oBtrTable.FieldByName('ModNum').AsInteger;
end;

procedure TWgclstBtr.WriteModNum(pValue:word);
begin
  oBtrTable.FieldByName('ModNum').AsInteger := pValue;
end;

function TWgclstBtr.ReadModUser:Str8;
begin
  Result := oBtrTable.FieldByName('ModUser').AsString;
end;

procedure TWgclstBtr.WriteModUser(pValue:Str8);
begin
  oBtrTable.FieldByName('ModUser').AsString := pValue;
end;

function TWgclstBtr.ReadModDate:TDatetime;
begin
  Result := oBtrTable.FieldByName('ModDate').AsDateTime;
end;

procedure TWgclstBtr.WriteModDate(pValue:TDatetime);
begin
  oBtrTable.FieldByName('ModDate').AsDateTime := pValue;
end;

function TWgclstBtr.ReadModTime:TDatetime;
begin
  Result := oBtrTable.FieldByName('ModTime').AsDateTime;
end;

procedure TWgclstBtr.WriteModTime(pValue:TDatetime);
begin
  oBtrTable.FieldByName('ModTime').AsDateTime := pValue;
end;

// **************************************** PUBLIC ********************************************

function TWgclstBtr.Eof: boolean;
begin
  Result := oBtrTable.Eof;
end;

function TWgclstBtr.IsFirstRec: boolean;
begin
  Result := oBtrTable.Bof;
end;

function TWgclstBtr.IsLastRec: boolean;
begin
  Result := oBtrTable.Eof;
end;

function TWgclstBtr.Active: boolean;
begin
  Result := oBtrTable.Active;
end;

function TWgclstBtr.ActPos: longint;
begin
  Result := oBtrTable.ActPos;
end;

function TWgclstBtr.GotoPos (pActPos:longint): boolean;
begin
  Result := oBtrTable.GotoPos(pActPos);
end;

function TWgclstBtr.LocateBarCode (pBarCode:Str15):boolean;
begin
  SetIndex (ixBarCode);
  Result := oBtrTable.FindKey([pBarCode]);
end;

function TWgclstBtr.LocateWghDate (pWghDate:TDatetime):boolean;
begin
  SetIndex (ixWghDate);
  Result := oBtrTable.FindKey([pWghDate]);
end;

function TWgclstBtr.LocateSalDate (pSalDate:TDatetime):boolean;
begin
  SetIndex (ixSalDate);
  Result := oBtrTable.FindKey([pSalDate]);
end;

function TWgclstBtr.NearestBarCode (pBarCode:Str15):boolean;
begin
  SetIndex (ixBarCode);
  Result := oBtrTable.FindNearest([pBarCode]);
end;

function TWgclstBtr.NearestWghDate (pWghDate:TDatetime):boolean;
begin
  SetIndex (ixWghDate);
  Result := oBtrTable.FindNearest([pWghDate]);
end;

function TWgclstBtr.NearestSalDate (pSalDate:TDatetime):boolean;
begin
  SetIndex (ixSalDate);
  Result := oBtrTable.FindNearest([pSalDate]);
end;

procedure TWgclstBtr.SetIndex (pIndexName:ShortString);
begin
  If oBtrTable.IndexName<>pIndexName then oBtrTable.IndexName := pIndexName;
end;

procedure TWgclstBtr.Open;
begin
  oBtrTable.Open;
end;

procedure TWgclstBtr.Close;
begin
  If oBtrTable.Active then oBtrTable.Close;
end;

procedure TWgclstBtr.Prior;
begin
  oBtrTable.Prior;
end;

procedure TWgclstBtr.Next;
begin
  oBtrTable.Next;
end;

procedure TWgclstBtr.First;
begin
  oBtrTable.First;
end;

procedure TWgclstBtr.Last;
begin
  oBtrTable.Last;
end;

procedure TWgclstBtr.Insert;
begin
  oBtrTable.Insert;
end;

procedure TWgclstBtr.Edit;
begin
  oBtrTable.Edit;
end;

procedure TWgclstBtr.Post;
begin
  oBtrTable.Post;
end;

procedure TWgclstBtr.Delete;
begin
  oBtrTable.Delete;
end;

procedure TWgclstBtr.SwapIndex;
begin
  oBtrTable.SwapIndex;
end;

procedure TWgclstBtr.RestoreIndex;
begin
  oBtrTable.RestoreIndex;
end;

procedure TWgclstBtr.SwapStatus;
begin
  oBtrTable.SwapStatus;
end;

procedure TWgclstBtr.RestoreStatus;
begin
  oBtrTable.RestoreStatus;
end;

procedure TWgclstBtr.EnableControls;
begin
  oBtrTable.EnableControls;
end;

procedure TWgclstBtr.DisableControls;
begin
  oBtrTable.DisableControls;
end;

end.
