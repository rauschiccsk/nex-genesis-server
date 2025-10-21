unit bCMSPEC;

interface

uses
  IcTypes, IcConv, NexPath, NexGlob,
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls,
  Dialogs, DB, NexBtrTable, DBTables, NexPxTable;

const
  ixPdCode = 'PdCode';

type
  TCmspecBtr = class (TComponent)
    constructor Create; overload;
    destructor  Destroy; override;
  private
    oBtrTable: TNexBtrTable;
    function ReadCount:integer;
    function FieldExist (pFieldName:ShortString): boolean;
    // Pristup k databazovym poliam
    function  ReadPdCode:longint;        procedure WritePdCode (pValue:longint);
    function  ReadCmCode:longint;        procedure WriteCmCode (pValue:longint);
    function  ReadCmQnt:double;          procedure WriteCmQnt (pValue:double);
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
    function LocatePdCode (pPdCode:longint):boolean;
    function NearestPdCode (pPdCode:longint):boolean;

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
    property PdCode:longint read ReadPdCode write WritePdCode;
    property CmCode:longint read ReadCmCode write WriteCmCode;
    property CmQnt:double read ReadCmQnt write WriteCmQnt;
    property Sended:boolean read ReadSended write WriteSended;
    property ModUser:Str8 read ReadModUser write WriteModUser;
    property ModDate:TDatetime read ReadModDate write WriteModDate;
    property ModTime:TDatetime read ReadModTime write WriteModTime;
  end;

implementation

constructor TCmspecBtr.Create;
begin
  oBtrTable := BtrInit ('CMSPEC',gPath.StkPath,Self);
end;

constructor TCmspecBtr.Create(pPath:ShortString);
begin
  oBtrTable := BtrInit ('CMSPEC',pPath,Self);
end;

destructor TCmspecBtr.Destroy;
begin
  oBtrTable.Close;  FreeAndNil (oBtrTable);
end;

// *************************************** PRIVATE ********************************************

function TCmspecBtr.ReadCount:integer;
begin
  Result := oBtrTable.RecordCount;
end;

function TCmspecBtr.FieldExist (pFieldName:ShortString): boolean;
begin
  Result := oBtrTable.FindField(pFieldName)<>nil;
end;

function TCmspecBtr.ReadPdCode:longint;
begin
  Result := oBtrTable.FieldByName('PdCode').AsInteger;
end;

procedure TCmspecBtr.WritePdCode(pValue:longint);
begin
  oBtrTable.FieldByName('PdCode').AsInteger := pValue;
end;

function TCmspecBtr.ReadCmCode:longint;
begin
  Result := oBtrTable.FieldByName('CmCode').AsInteger;
end;

procedure TCmspecBtr.WriteCmCode(pValue:longint);
begin
  oBtrTable.FieldByName('CmCode').AsInteger := pValue;
end;

function TCmspecBtr.ReadCmQnt:double;
begin
  Result := oBtrTable.FieldByName('CmQnt').AsFloat;
end;

procedure TCmspecBtr.WriteCmQnt(pValue:double);
begin
  oBtrTable.FieldByName('CmQnt').AsFloat := pValue;
end;

function TCmspecBtr.ReadSended:boolean;
begin
  Result := ByteToBool(oBtrTable.FieldByName('Sended').AsInteger);
end;

procedure TCmspecBtr.WriteSended(pValue:boolean);
begin
  oBtrTable.FieldByName('Sended').AsInteger := BoolToByte(pValue);
end;

function TCmspecBtr.ReadModUser:Str8;
begin
  Result := oBtrTable.FieldByName('ModUser').AsString;
end;

procedure TCmspecBtr.WriteModUser(pValue:Str8);
begin
  oBtrTable.FieldByName('ModUser').AsString := pValue;
end;

function TCmspecBtr.ReadModDate:TDatetime;
begin
  Result := oBtrTable.FieldByName('ModDate').AsDateTime;
end;

procedure TCmspecBtr.WriteModDate(pValue:TDatetime);
begin
  oBtrTable.FieldByName('ModDate').AsDateTime := pValue;
end;

function TCmspecBtr.ReadModTime:TDatetime;
begin
  Result := oBtrTable.FieldByName('ModTime').AsDateTime;
end;

procedure TCmspecBtr.WriteModTime(pValue:TDatetime);
begin
  oBtrTable.FieldByName('ModTime').AsDateTime := pValue;
end;

// **************************************** PUBLIC ********************************************

function TCmspecBtr.Eof: boolean;
begin
  Result := oBtrTable.Eof;
end;

function TCmspecBtr.IsFirstRec: boolean;
begin
  Result := oBtrTable.Bof;
end;

function TCmspecBtr.IsLastRec: boolean;
begin
  Result := oBtrTable.Eof;
end;

function TCmspecBtr.Active: boolean;
begin
  Result := oBtrTable.Active;
end;

function TCmspecBtr.ActPos: longint;
begin
  Result := oBtrTable.ActPos;
end;

function TCmspecBtr.GotoPos (pActPos:longint): boolean;
begin
  Result := oBtrTable.GotoPos(pActPos);
end;

function TCmspecBtr.LocatePdCode (pPdCode:longint):boolean;
begin
  SetIndex (ixPdCode);
  Result := oBtrTable.FindKey([pPdCode]);
end;

function TCmspecBtr.NearestPdCode (pPdCode:longint):boolean;
begin
  SetIndex (ixPdCode);
  Result := oBtrTable.FindNearest([pPdCode]);
end;

procedure TCmspecBtr.SetIndex (pIndexName:ShortString);
begin
  If oBtrTable.IndexName<>pIndexName then oBtrTable.IndexName := pIndexName;
end;

procedure TCmspecBtr.Open;
begin
  oBtrTable.Open;
end;

procedure TCmspecBtr.Close;
begin
  If oBtrTable.Active then oBtrTable.Close;
end;

procedure TCmspecBtr.Prior;
begin
  oBtrTable.Prior;
end;

procedure TCmspecBtr.Next;
begin
  oBtrTable.Next;
end;

procedure TCmspecBtr.First;
begin
  oBtrTable.First;
end;

procedure TCmspecBtr.Last;
begin
  oBtrTable.Last;
end;

procedure TCmspecBtr.Insert;
begin
  oBtrTable.Insert;
end;

procedure TCmspecBtr.Edit;
begin
  oBtrTable.Edit;
end;

procedure TCmspecBtr.Post;
begin
  oBtrTable.Post;
end;

procedure TCmspecBtr.Delete;
begin
  oBtrTable.Delete;
end;

procedure TCmspecBtr.SwapIndex;
begin
  oBtrTable.SwapIndex;
end;

procedure TCmspecBtr.RestoreIndex;
begin
  oBtrTable.RestoreIndex;
end;

procedure TCmspecBtr.SwapStatus;
begin
  oBtrTable.SwapStatus;
end;

procedure TCmspecBtr.RestoreStatus;
begin
  oBtrTable.RestoreStatus;
end;

procedure TCmspecBtr.EnableControls;
begin
  oBtrTable.EnableControls;
end;

procedure TCmspecBtr.DisableControls;
begin
  oBtrTable.DisableControls;
end;

end.
{MOD 2001001}
