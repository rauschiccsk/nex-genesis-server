unit bAGRLST;

interface

uses
  IcTypes, IcConv, NexPath, NexGlob,
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls,
  Dialogs, DB, NexBtrTable, DBTables, NexPxTable;

const
  ixPaCode = 'PaCode';
  ixPaName = 'PaName';

type
  TAgrlstBtr = class (TComponent)
    constructor Create; overload;
    destructor  Destroy; override;
  private
    oBtrTable: TNexBtrTable;
    function ReadCount:integer;
    function FieldExist (pFieldName:ShortString): boolean;
    // Pristup k databazovym poliam
    function  ReadPaCode:longint;        procedure WritePaCode (pValue:longint);
    function  ReadPaName:Str30;          procedure WritePaName (pValue:Str30);
    function  ReadPaName_:Str30;         procedure WritePaName_ (pValue:Str30);
    function  ReadItmQnt:longint;        procedure WriteItmQnt (pValue:longint);
    function  ReadNotice:Str60;          procedure WriteNotice (pValue:Str60);
    function  ReadMinPrf:double;         procedure WriteMinPrf (pValue:double);
    function  ReadAgdNum:Str20;          procedure WriteAgdNum (pValue:Str20);
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
    function LocatePaCode (pPaCode:longint):boolean;
    function LocatePaName (pPaName_:Str30):boolean;
    function NearestPaCode (pPaCode:longint):boolean;
    function NearestPaName (pPaName_:Str30):boolean;

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
    property PaCode:longint read ReadPaCode write WritePaCode;
    property PaName:Str30 read ReadPaName write WritePaName;
    property PaName_:Str30 read ReadPaName_ write WritePaName_;
    property ItmQnt:longint read ReadItmQnt write WriteItmQnt;
    property Notice:Str60 read ReadNotice write WriteNotice;
    property MinPrf:double read ReadMinPrf write WriteMinPrf;
    property AgdNum:Str20 read ReadAgdNum write WriteAgdNum;
    property CrtUser:Str8 read ReadCrtUser write WriteCrtUser;
    property CrtDate:TDatetime read ReadCrtDate write WriteCrtDate;
    property CrtTime:TDatetime read ReadCrtTime write WriteCrtTime;
    property ModUser:Str8 read ReadModUser write WriteModUser;
    property ModDate:TDatetime read ReadModDate write WriteModDate;
    property ModTime:TDatetime read ReadModTime write WriteModTime;
  end;

implementation

constructor TAgrlstBtr.Create;
begin
  oBtrTable := BtrInit ('AGRLST',gPath.StkPath,Self);
end;

constructor TAgrlstBtr.Create(pPath:ShortString);
begin
  oBtrTable := BtrInit ('AGRLST',pPath,Self);
end;

destructor TAgrlstBtr.Destroy;
begin
  oBtrTable.Close;  FreeAndNil (oBtrTable);
end;

// *************************************** PRIVATE ********************************************

function TAgrlstBtr.ReadCount:integer;
begin
  Result := oBtrTable.RecordCount;
end;

function TAgrlstBtr.FieldExist (pFieldName:ShortString): boolean;
begin
  Result := oBtrTable.FindField(pFieldName)<>nil;
end;

function TAgrlstBtr.ReadPaCode:longint;
begin
  Result := oBtrTable.FieldByName('PaCode').AsInteger;
end;

procedure TAgrlstBtr.WritePaCode(pValue:longint);
begin
  oBtrTable.FieldByName('PaCode').AsInteger := pValue;
end;

function TAgrlstBtr.ReadPaName:Str30;
begin
  Result := oBtrTable.FieldByName('PaName').AsString;
end;

procedure TAgrlstBtr.WritePaName(pValue:Str30);
begin
  oBtrTable.FieldByName('PaName').AsString := pValue;
end;

function TAgrlstBtr.ReadPaName_:Str30;
begin
  Result := oBtrTable.FieldByName('PaName_').AsString;
end;

procedure TAgrlstBtr.WritePaName_(pValue:Str30);
begin
  oBtrTable.FieldByName('PaName_').AsString := pValue;
end;

function TAgrlstBtr.ReadItmQnt:longint;
begin
  Result := oBtrTable.FieldByName('ItmQnt').AsInteger;
end;

procedure TAgrlstBtr.WriteItmQnt(pValue:longint);
begin
  oBtrTable.FieldByName('ItmQnt').AsInteger := pValue;
end;

function TAgrlstBtr.ReadNotice:Str60;
begin
  Result := oBtrTable.FieldByName('Notice').AsString;
end;

procedure TAgrlstBtr.WriteNotice(pValue:Str60);
begin
  oBtrTable.FieldByName('Notice').AsString := pValue;
end;

function TAgrlstBtr.ReadMinPrf:double;
begin
  Result := oBtrTable.FieldByName('MinPrf').AsFloat;
end;

procedure TAgrlstBtr.WriteMinPrf(pValue:double);
begin
  oBtrTable.FieldByName('MinPrf').AsFloat := pValue;
end;

function TAgrlstBtr.ReadAgdNum:Str20;
begin
  Result := oBtrTable.FieldByName('AgdNum').AsString;
end;

procedure TAgrlstBtr.WriteAgdNum(pValue:Str20);
begin
  oBtrTable.FieldByName('AgdNum').AsString := pValue;
end;

function TAgrlstBtr.ReadCrtUser:Str8;
begin
  Result := oBtrTable.FieldByName('CrtUser').AsString;
end;

procedure TAgrlstBtr.WriteCrtUser(pValue:Str8);
begin
  oBtrTable.FieldByName('CrtUser').AsString := pValue;
end;

function TAgrlstBtr.ReadCrtDate:TDatetime;
begin
  Result := oBtrTable.FieldByName('CrtDate').AsDateTime;
end;

procedure TAgrlstBtr.WriteCrtDate(pValue:TDatetime);
begin
  oBtrTable.FieldByName('CrtDate').AsDateTime := pValue;
end;

function TAgrlstBtr.ReadCrtTime:TDatetime;
begin
  Result := oBtrTable.FieldByName('CrtTime').AsDateTime;
end;

procedure TAgrlstBtr.WriteCrtTime(pValue:TDatetime);
begin
  oBtrTable.FieldByName('CrtTime').AsDateTime := pValue;
end;

function TAgrlstBtr.ReadModUser:Str8;
begin
  Result := oBtrTable.FieldByName('ModUser').AsString;
end;

procedure TAgrlstBtr.WriteModUser(pValue:Str8);
begin
  oBtrTable.FieldByName('ModUser').AsString := pValue;
end;

function TAgrlstBtr.ReadModDate:TDatetime;
begin
  Result := oBtrTable.FieldByName('ModDate').AsDateTime;
end;

procedure TAgrlstBtr.WriteModDate(pValue:TDatetime);
begin
  oBtrTable.FieldByName('ModDate').AsDateTime := pValue;
end;

function TAgrlstBtr.ReadModTime:TDatetime;
begin
  Result := oBtrTable.FieldByName('ModTime').AsDateTime;
end;

procedure TAgrlstBtr.WriteModTime(pValue:TDatetime);
begin
  oBtrTable.FieldByName('ModTime').AsDateTime := pValue;
end;

// **************************************** PUBLIC ********************************************

function TAgrlstBtr.Eof: boolean;
begin
  Result := oBtrTable.Eof;
end;

function TAgrlstBtr.IsFirstRec: boolean;
begin
  Result := oBtrTable.Bof;
end;

function TAgrlstBtr.IsLastRec: boolean;
begin
  Result := oBtrTable.Eof;
end;

function TAgrlstBtr.Active: boolean;
begin
  Result := oBtrTable.Active;
end;

function TAgrlstBtr.ActPos: longint;
begin
  Result := oBtrTable.ActPos;
end;

function TAgrlstBtr.GotoPos (pActPos:longint): boolean;
begin
  Result := oBtrTable.GotoPos(pActPos);
end;

function TAgrlstBtr.LocatePaCode (pPaCode:longint):boolean;
begin
  SetIndex (ixPaCode);
  Result := oBtrTable.FindKey([pPaCode]);
end;

function TAgrlstBtr.LocatePaName (pPaName_:Str30):boolean;
begin
  SetIndex (ixPaName);
  Result := oBtrTable.FindKey([StrToAlias(pPaName_)]);
end;

function TAgrlstBtr.NearestPaCode (pPaCode:longint):boolean;
begin
  SetIndex (ixPaCode);
  Result := oBtrTable.FindNearest([pPaCode]);
end;

function TAgrlstBtr.NearestPaName (pPaName_:Str30):boolean;
begin
  SetIndex (ixPaName);
  Result := oBtrTable.FindNearest([pPaName_]);
end;

procedure TAgrlstBtr.SetIndex (pIndexName:ShortString);
begin
  If oBtrTable.IndexName<>pIndexName then oBtrTable.IndexName := pIndexName;
end;

procedure TAgrlstBtr.Open;
begin
  oBtrTable.Open;
end;

procedure TAgrlstBtr.Close;
begin
  If oBtrTable.Active then oBtrTable.Close;
end;

procedure TAgrlstBtr.Prior;
begin
  oBtrTable.Prior;
end;

procedure TAgrlstBtr.Next;
begin
  oBtrTable.Next;
end;

procedure TAgrlstBtr.First;
begin
  oBtrTable.First;
end;

procedure TAgrlstBtr.Last;
begin
  oBtrTable.Last;
end;

procedure TAgrlstBtr.Insert;
begin
  oBtrTable.Insert;
end;

procedure TAgrlstBtr.Edit;
begin
  oBtrTable.Edit;
end;

procedure TAgrlstBtr.Post;
begin
  oBtrTable.Post;
end;

procedure TAgrlstBtr.Delete;
begin
  oBtrTable.Delete;
end;

procedure TAgrlstBtr.SwapIndex;
begin
  oBtrTable.SwapIndex;
end;

procedure TAgrlstBtr.RestoreIndex;
begin
  oBtrTable.RestoreIndex;
end;

procedure TAgrlstBtr.SwapStatus;
begin
  oBtrTable.SwapStatus;
end;

procedure TAgrlstBtr.RestoreStatus;
begin
  oBtrTable.RestoreStatus;
end;

procedure TAgrlstBtr.EnableControls;
begin
  oBtrTable.EnableControls;
end;

procedure TAgrlstBtr.DisableControls;
begin
  oBtrTable.DisableControls;
end;

end.
{MOD 1915001}
