unit bTRSLST;

interface

uses
  IcTypes, IcConv, NexPath, NexGlob,
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls,
  Dialogs, DB, NexBtrTable, DBTables, NexPxTable;

const
  ixTrsCode = 'TrsCode';
  ixTrsName = 'TrsName';
  ixSended = 'Sended';

type
  TTrslstBtr = class (TComponent)
    constructor Create; overload;
    destructor  Destroy; override;
  private
    oBtrTable: TNexBtrTable;
    function ReadCount:integer;
    function FieldExist (pFieldName:ShortString): boolean;
    // Pristup k databazovym poliam
    function  ReadTrsCode:Str3;          procedure WriteTrsCode (pValue:Str3);
    function  ReadTrsName:Str30;         procedure WriteTrsName (pValue:Str30);
    function  ReadTrsName_:Str20;        procedure WriteTrsName_ (pValue:Str20);
    function  ReadSended:boolean;        procedure WriteSended (pValue:boolean);
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
    function LocateTrsCode (pTrsCode:Str3):boolean;
    function LocateTrsName (pTrsName_:Str20):boolean;
    function LocateSended (pSended:byte):boolean;
    function NearestTrsCode (pTrsCode:Str3):boolean;
    function NearestTrsName (pTrsName_:Str20):boolean;
    function NearestSended (pSended:byte):boolean;

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
    property TrsCode:Str3 read ReadTrsCode write WriteTrsCode;
    property TrsName:Str30 read ReadTrsName write WriteTrsName;
    property TrsName_:Str20 read ReadTrsName_ write WriteTrsName_;
    property Sended:boolean read ReadSended write WriteSended;
    property ModUser:Str8 read ReadModUser write WriteModUser;
    property ModDate:TDatetime read ReadModDate write WriteModDate;
    property ModTime:TDatetime read ReadModTime write WriteModTime;
  end;

implementation

constructor TTrslstBtr.Create;
begin
  oBtrTable := BtrInit ('TRSLST',gPath.DlsPath,Self);
end;

constructor TTrslstBtr.Create(pPath:ShortString);
begin
  oBtrTable := BtrInit ('TRSLST',pPath,Self);
end;

destructor TTrslstBtr.Destroy;
begin
  oBtrTable.Close;  FreeAndNil (oBtrTable);
end;

// *************************************** PRIVATE ********************************************

function TTrslstBtr.ReadCount:integer;
begin
  Result := oBtrTable.RecordCount;
end;

function TTrslstBtr.FieldExist (pFieldName:ShortString): boolean;
begin
  Result := oBtrTable.FindField(pFieldName)<>nil;
end;

function TTrslstBtr.ReadTrsCode:Str3;
begin
  Result := oBtrTable.FieldByName('TrsCode').AsString;
end;

procedure TTrslstBtr.WriteTrsCode(pValue:Str3);
begin
  oBtrTable.FieldByName('TrsCode').AsString := pValue;
end;

function TTrslstBtr.ReadTrsName:Str30;
begin
  Result := oBtrTable.FieldByName('TrsName').AsString;
end;

procedure TTrslstBtr.WriteTrsName(pValue:Str30);
begin
  oBtrTable.FieldByName('TrsName').AsString := pValue;
end;

function TTrslstBtr.ReadTrsName_:Str20;
begin
  Result := oBtrTable.FieldByName('TrsName_').AsString;
end;

procedure TTrslstBtr.WriteTrsName_(pValue:Str20);
begin
  oBtrTable.FieldByName('TrsName_').AsString := pValue;
end;

function TTrslstBtr.ReadSended:boolean;
begin
  Result := ByteToBool(oBtrTable.FieldByName('Sended').AsInteger);
end;

procedure TTrslstBtr.WriteSended(pValue:boolean);
begin
  oBtrTable.FieldByName('Sended').AsInteger := BoolToByte(pValue);
end;

function TTrslstBtr.ReadModUser:Str8;
begin
  Result := oBtrTable.FieldByName('ModUser').AsString;
end;

procedure TTrslstBtr.WriteModUser(pValue:Str8);
begin
  oBtrTable.FieldByName('ModUser').AsString := pValue;
end;

function TTrslstBtr.ReadModDate:TDatetime;
begin
  Result := oBtrTable.FieldByName('ModDate').AsDateTime;
end;

procedure TTrslstBtr.WriteModDate(pValue:TDatetime);
begin
  oBtrTable.FieldByName('ModDate').AsDateTime := pValue;
end;

function TTrslstBtr.ReadModTime:TDatetime;
begin
  Result := oBtrTable.FieldByName('ModTime').AsDateTime;
end;

procedure TTrslstBtr.WriteModTime(pValue:TDatetime);
begin
  oBtrTable.FieldByName('ModTime').AsDateTime := pValue;
end;

// **************************************** PUBLIC ********************************************

function TTrslstBtr.Eof: boolean;
begin
  Result := oBtrTable.Eof;
end;

function TTrslstBtr.IsFirstRec: boolean;
begin
  Result := oBtrTable.Bof;
end;

function TTrslstBtr.IsLastRec: boolean;
begin
  Result := oBtrTable.Eof;
end;

function TTrslstBtr.Active: boolean;
begin
  Result := oBtrTable.Active;
end;

function TTrslstBtr.ActPos: longint;
begin
  Result := oBtrTable.ActPos;
end;

function TTrslstBtr.GotoPos (pActPos:longint): boolean;
begin
  Result := oBtrTable.GotoPos(pActPos);
end;

function TTrslstBtr.LocateTrsCode (pTrsCode:Str3):boolean;
begin
  SetIndex (ixTrsCode);
  Result := oBtrTable.FindKey([pTrsCode]);
end;

function TTrslstBtr.LocateTrsName (pTrsName_:Str20):boolean;
begin
  SetIndex (ixTrsName);
  Result := oBtrTable.FindKey([StrToAlias(pTrsName_)]);
end;

function TTrslstBtr.LocateSended (pSended:byte):boolean;
begin
  SetIndex (ixSended);
  Result := oBtrTable.FindKey([pSended]);
end;

function TTrslstBtr.NearestTrsCode (pTrsCode:Str3):boolean;
begin
  SetIndex (ixTrsCode);
  Result := oBtrTable.FindNearest([pTrsCode]);
end;

function TTrslstBtr.NearestTrsName (pTrsName_:Str20):boolean;
begin
  SetIndex (ixTrsName);
  Result := oBtrTable.FindNearest([pTrsName_]);
end;

function TTrslstBtr.NearestSended (pSended:byte):boolean;
begin
  SetIndex (ixSended);
  Result := oBtrTable.FindNearest([pSended]);
end;

procedure TTrslstBtr.SetIndex (pIndexName:ShortString);
begin
  If oBtrTable.IndexName<>pIndexName then oBtrTable.IndexName := pIndexName;
end;

procedure TTrslstBtr.Open;
begin
  oBtrTable.Open;
end;

procedure TTrslstBtr.Close;
begin
  If oBtrTable.Active then oBtrTable.Close;
end;

procedure TTrslstBtr.Prior;
begin
  oBtrTable.Prior;
end;

procedure TTrslstBtr.Next;
begin
  oBtrTable.Next;
end;

procedure TTrslstBtr.First;
begin
  oBtrTable.First;
end;

procedure TTrslstBtr.Last;
begin
  oBtrTable.Last;
end;

procedure TTrslstBtr.Insert;
begin
  oBtrTable.Insert;
end;

procedure TTrslstBtr.Edit;
begin
  oBtrTable.Edit;
end;

procedure TTrslstBtr.Post;
begin
  oBtrTable.Post;
end;

procedure TTrslstBtr.Delete;
begin
  oBtrTable.Delete;
end;

procedure TTrslstBtr.SwapIndex;
begin
  oBtrTable.SwapIndex;
end;

procedure TTrslstBtr.RestoreIndex;
begin
  oBtrTable.RestoreIndex;
end;

procedure TTrslstBtr.SwapStatus;
begin
  oBtrTable.SwapStatus;
end;

procedure TTrslstBtr.RestoreStatus;
begin
  oBtrTable.RestoreStatus;
end;

procedure TTrslstBtr.EnableControls;
begin
  oBtrTable.EnableControls;
end;

procedure TTrslstBtr.DisableControls;
begin
  oBtrTable.DisableControls;
end;

end.
