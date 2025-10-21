unit bPRJLST;

interface

uses
  IcTypes, IcConv, NexPath, NexGlob,
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls,
  Dialogs, DB, NexBtrTable, DBTables, NexPxTable;

const
  ixDocNum = 'DocNum';
  ixSerNum = 'SerNum';
  ixPrjName = 'PrjName';

type
  TPrjlstBtr = class (TComponent)
    constructor Create; overload;
    destructor  Destroy; override;
  private
    oBtrTable: TNexBtrTable;
    function ReadCount:integer;
    function FieldExist (pFieldName:ShortString): boolean;
    // Pristup k databazovym poliam
    function  ReadDocNum:Str12;          procedure WriteDocNum (pValue:Str12);
    function  ReadSerNum:word;           procedure WriteSerNum (pValue:word);
    function  ReadPrjName:Str90;         procedure WritePrjName (pValue:Str90);
    function  ReadPrjName_:Str90;        procedure WritePrjName_ (pValue:Str90);
    function  ReadBegDate:TDatetime;     procedure WriteBegDate (pValue:TDatetime);
    function  ReadEndDate:TDatetime;     procedure WriteEndDate (pValue:TDatetime);
    function  ReadRspNum:word;           procedure WriteRspNum (pValue:word);
    function  ReadRspUser:Str8;          procedure WriteRspUser (pValue:Str8);
    function  ReadRspName:Str30;         procedure WriteRspName (pValue:Str30);
    function  ReadCrtUser:Str8;          procedure WriteCrtUser (pValue:Str8);
    function  ReadCrtDate:TDatetime;     procedure WriteCrtDate (pValue:TDatetime);
    function  ReadCrtTime:TDatetime;     procedure WriteCrtTime (pValue:TDatetime);
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
    function LocateDocNum (pDocNum:Str12):boolean;
    function LocateSerNum (pSerNum:word):boolean;
    function LocatePrjName (pPrjName_:Str90):boolean;
    function NearestDocNum (pDocNum:Str12):boolean;
    function NearestSerNum (pSerNum:word):boolean;
    function NearestPrjName (pPrjName_:Str90):boolean;

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
    property DocNum:Str12 read ReadDocNum write WriteDocNum;
    property SerNum:word read ReadSerNum write WriteSerNum;
    property PrjName:Str90 read ReadPrjName write WritePrjName;
    property PrjName_:Str90 read ReadPrjName_ write WritePrjName_;
    property BegDate:TDatetime read ReadBegDate write WriteBegDate;
    property EndDate:TDatetime read ReadEndDate write WriteEndDate;
    property RspNum:word read ReadRspNum write WriteRspNum;
    property RspUser:Str8 read ReadRspUser write WriteRspUser;
    property RspName:Str30 read ReadRspName write WriteRspName;
    property CrtUser:Str8 read ReadCrtUser write WriteCrtUser;
    property CrtDate:TDatetime read ReadCrtDate write WriteCrtDate;
    property CrtTime:TDatetime read ReadCrtTime write WriteCrtTime;
    property ModUser:Str8 read ReadModUser write WriteModUser;
    property ModDate:TDatetime read ReadModDate write WriteModDate;
    property ModTime:TDatetime read ReadModTime write WriteModTime;
  end;

implementation

constructor TPrjlstBtr.Create;
begin
  oBtrTable := BtrInit ('PRJLST',gPath.DlsPath,Self);
end;

constructor TPrjlstBtr.Create(pPath:ShortString);
begin
  oBtrTable := BtrInit ('PRJLST',pPath,Self);
end;

destructor TPrjlstBtr.Destroy;
begin
  oBtrTable.Close;  FreeAndNil (oBtrTable);
end;

// *************************************** PRIVATE ********************************************

function TPrjlstBtr.ReadCount:integer;
begin
  Result := oBtrTable.RecordCount;
end;

function TPrjlstBtr.FieldExist (pFieldName:ShortString): boolean;
begin
  Result := oBtrTable.FindField(pFieldName)<>nil;
end;

function TPrjlstBtr.ReadDocNum:Str12;
begin
  Result := oBtrTable.FieldByName('DocNum').AsString;
end;

procedure TPrjlstBtr.WriteDocNum(pValue:Str12);
begin
  oBtrTable.FieldByName('DocNum').AsString := pValue;
end;

function TPrjlstBtr.ReadSerNum:word;
begin
  Result := oBtrTable.FieldByName('SerNum').AsInteger;
end;

procedure TPrjlstBtr.WriteSerNum(pValue:word);
begin
  oBtrTable.FieldByName('SerNum').AsInteger := pValue;
end;

function TPrjlstBtr.ReadPrjName:Str90;
begin
  Result := oBtrTable.FieldByName('PrjName').AsString;
end;

procedure TPrjlstBtr.WritePrjName(pValue:Str90);
begin
  oBtrTable.FieldByName('PrjName').AsString := pValue;
end;

function TPrjlstBtr.ReadPrjName_:Str90;
begin
  Result := oBtrTable.FieldByName('PrjName_').AsString;
end;

procedure TPrjlstBtr.WritePrjName_(pValue:Str90);
begin
  oBtrTable.FieldByName('PrjName_').AsString := pValue;
end;

function TPrjlstBtr.ReadBegDate:TDatetime;
begin
  Result := oBtrTable.FieldByName('BegDate').AsDateTime;
end;

procedure TPrjlstBtr.WriteBegDate(pValue:TDatetime);
begin
  oBtrTable.FieldByName('BegDate').AsDateTime := pValue;
end;

function TPrjlstBtr.ReadEndDate:TDatetime;
begin
  Result := oBtrTable.FieldByName('EndDate').AsDateTime;
end;

procedure TPrjlstBtr.WriteEndDate(pValue:TDatetime);
begin
  oBtrTable.FieldByName('EndDate').AsDateTime := pValue;
end;

function TPrjlstBtr.ReadRspNum:word;
begin
  Result := oBtrTable.FieldByName('RspNum').AsInteger;
end;

procedure TPrjlstBtr.WriteRspNum(pValue:word);
begin
  oBtrTable.FieldByName('RspNum').AsInteger := pValue;
end;

function TPrjlstBtr.ReadRspUser:Str8;
begin
  Result := oBtrTable.FieldByName('RspUser').AsString;
end;

procedure TPrjlstBtr.WriteRspUser(pValue:Str8);
begin
  oBtrTable.FieldByName('RspUser').AsString := pValue;
end;

function TPrjlstBtr.ReadRspName:Str30;
begin
  Result := oBtrTable.FieldByName('RspName').AsString;
end;

procedure TPrjlstBtr.WriteRspName(pValue:Str30);
begin
  oBtrTable.FieldByName('RspName').AsString := pValue;
end;

function TPrjlstBtr.ReadCrtUser:Str8;
begin
  Result := oBtrTable.FieldByName('CrtUser').AsString;
end;

procedure TPrjlstBtr.WriteCrtUser(pValue:Str8);
begin
  oBtrTable.FieldByName('CrtUser').AsString := pValue;
end;

function TPrjlstBtr.ReadCrtDate:TDatetime;
begin
  Result := oBtrTable.FieldByName('CrtDate').AsDateTime;
end;

procedure TPrjlstBtr.WriteCrtDate(pValue:TDatetime);
begin
  oBtrTable.FieldByName('CrtDate').AsDateTime := pValue;
end;

function TPrjlstBtr.ReadCrtTime:TDatetime;
begin
  Result := oBtrTable.FieldByName('CrtTime').AsDateTime;
end;

procedure TPrjlstBtr.WriteCrtTime(pValue:TDatetime);
begin
  oBtrTable.FieldByName('CrtTime').AsDateTime := pValue;
end;

function TPrjlstBtr.ReadModUser:Str8;
begin
  Result := oBtrTable.FieldByName('ModUser').AsString;
end;

procedure TPrjlstBtr.WriteModUser(pValue:Str8);
begin
  oBtrTable.FieldByName('ModUser').AsString := pValue;
end;

function TPrjlstBtr.ReadModDate:TDatetime;
begin
  Result := oBtrTable.FieldByName('ModDate').AsDateTime;
end;

procedure TPrjlstBtr.WriteModDate(pValue:TDatetime);
begin
  oBtrTable.FieldByName('ModDate').AsDateTime := pValue;
end;

function TPrjlstBtr.ReadModTime:TDatetime;
begin
  Result := oBtrTable.FieldByName('ModTime').AsDateTime;
end;

procedure TPrjlstBtr.WriteModTime(pValue:TDatetime);
begin
  oBtrTable.FieldByName('ModTime').AsDateTime := pValue;
end;

// **************************************** PUBLIC ********************************************

function TPrjlstBtr.Eof: boolean;
begin
  Result := oBtrTable.Eof;
end;

function TPrjlstBtr.IsFirstRec: boolean;
begin
  Result := oBtrTable.Bof;
end;

function TPrjlstBtr.IsLastRec: boolean;
begin
  Result := oBtrTable.Eof;
end;

function TPrjlstBtr.Active: boolean;
begin
  Result := oBtrTable.Active;
end;

function TPrjlstBtr.ActPos: longint;
begin
  Result := oBtrTable.ActPos;
end;

function TPrjlstBtr.GotoPos (pActPos:longint): boolean;
begin
  Result := oBtrTable.GotoPos(pActPos);
end;

function TPrjlstBtr.LocateDocNum (pDocNum:Str12):boolean;
begin
  SetIndex (ixDocNum);
  Result := oBtrTable.FindKey([pDocNum]);
end;

function TPrjlstBtr.LocateSerNum (pSerNum:word):boolean;
begin
  SetIndex (ixSerNum);
  Result := oBtrTable.FindKey([pSerNum]);
end;

function TPrjlstBtr.LocatePrjName (pPrjName_:Str90):boolean;
begin
  SetIndex (ixPrjName);
  Result := oBtrTable.FindKey([StrToAlias(pPrjName_)]);
end;

function TPrjlstBtr.NearestDocNum (pDocNum:Str12):boolean;
begin
  SetIndex (ixDocNum);
  Result := oBtrTable.FindNearest([pDocNum]);
end;

function TPrjlstBtr.NearestSerNum (pSerNum:word):boolean;
begin
  SetIndex (ixSerNum);
  Result := oBtrTable.FindNearest([pSerNum]);
end;

function TPrjlstBtr.NearestPrjName (pPrjName_:Str90):boolean;
begin
  SetIndex (ixPrjName);
  Result := oBtrTable.FindNearest([pPrjName_]);
end;

procedure TPrjlstBtr.SetIndex (pIndexName:ShortString);
begin
  If oBtrTable.IndexName<>pIndexName then oBtrTable.IndexName := pIndexName;
end;

procedure TPrjlstBtr.Open;
begin
  oBtrTable.Open;
end;

procedure TPrjlstBtr.Close;
begin
  If oBtrTable.Active then oBtrTable.Close;
end;

procedure TPrjlstBtr.Prior;
begin
  oBtrTable.Prior;
end;

procedure TPrjlstBtr.Next;
begin
  oBtrTable.Next;
end;

procedure TPrjlstBtr.First;
begin
  oBtrTable.First;
end;

procedure TPrjlstBtr.Last;
begin
  oBtrTable.Last;
end;

procedure TPrjlstBtr.Insert;
begin
  oBtrTable.Insert;
end;

procedure TPrjlstBtr.Edit;
begin
  oBtrTable.Edit;
end;

procedure TPrjlstBtr.Post;
begin
  oBtrTable.Post;
end;

procedure TPrjlstBtr.Delete;
begin
  oBtrTable.Delete;
end;

procedure TPrjlstBtr.SwapIndex;
begin
  oBtrTable.SwapIndex;
end;

procedure TPrjlstBtr.RestoreIndex;
begin
  oBtrTable.RestoreIndex;
end;

procedure TPrjlstBtr.SwapStatus;
begin
  oBtrTable.SwapStatus;
end;

procedure TPrjlstBtr.RestoreStatus;
begin
  oBtrTable.RestoreStatus;
end;

procedure TPrjlstBtr.EnableControls;
begin
  oBtrTable.EnableControls;
end;

procedure TPrjlstBtr.DisableControls;
begin
  oBtrTable.DisableControls;
end;

end.
