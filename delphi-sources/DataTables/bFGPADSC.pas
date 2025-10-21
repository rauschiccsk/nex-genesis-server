unit bFgpadsc;

interface

uses
  IcTypes, NexPath, NexGlob,
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls,
  Dialogs, DB, NexBtrTable, DBTables, NexPxTable;

const
  ixPaFg = 'PaFg';
  ixPaCode = 'PaCode';
  ixSended = 'Sended';

type
  TFgpadscBtr = class (TComponent)
    constructor Create;
    destructor  Destroy; override;
  private
    oBtrTable: TNexBtrTable;
    function ReadCount:integer;
    function FieldExist (pFieldName:ShortString): boolean;
    // Pristup k databazovym poliam
    function  ReadPaCode:longint;        procedure WritePaCode (pValue:longint);
    function  ReadFgCode:longint;        procedure WriteFgCode (pValue:longint);
    function  ReadDscPrc:double;         procedure WriteDscPrc (pValue:double);
    function  ReadSended:boolean;        procedure WriteSended (pValue:boolean);
    function  ReadModNum:word;           procedure WriteModNum (pValue:word);
    function  ReadModUser:Str8;          procedure WriteModUser (pValue:Str8);
    function  ReadModDate:TDatetime;     procedure WriteModDate (pValue:TDatetime);
    function  ReadModTime:TDatetime;     procedure WriteModTime (pValue:TDatetime);
  public
    // Elementarne databazove operacie
    function Eof: boolean;
    function Active: boolean;
    function ActPos: longint;
    function GotoPos (pActPos:longint): boolean;
    function LocatePaFg (pPaCode:longint;pFgCode:longint):boolean;
    function LocatePaCode (pPaCode:longint):boolean;
    function LocateSended (pSended:byte):boolean;

    procedure SetIndex (pIndexName:ShortString);
    procedure Open;
    procedure Close;
    procedure Prior;
    procedure Next;
    procedure First;
    procedure Last;
    procedure Insert;
    procedure Edit;
    procedure Post;
    procedure Delete;
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
    property FgCode:longint read ReadFgCode write WriteFgCode;
    property DscPrc:double read ReadDscPrc write WriteDscPrc;
    property Sended:boolean read ReadSended write WriteSended;
    property ModNum:word read ReadModNum write WriteModNum;
    property ModUser:Str8 read ReadModUser write WriteModUser;
    property ModDate:TDatetime read ReadModDate write WriteModDate;
    property ModTime:TDatetime read ReadModTime write WriteModTime;
  end;

implementation

constructor TFgpadscBtr.Create;
begin
  oBtrTable := BtrInit ('FGPADSC',gPath.StkPath,Self);
end;

destructor  TFgpadscBtr.Destroy;
begin
    oBtrTable.Close;  FreeAndNil (oBtrTable);
end;

// *************************************** PRIVATE ********************************************

function TFgpadscBtr.ReadCount:integer;
begin
  Result := oBtrTable.RecordCount;
end;

function TFgpadscBtr.FieldExist (pFieldName:ShortString): boolean;
begin
  Result := oBtrTable.FindField(pFieldName)<>nil;
end;

function TFgpadscBtr.ReadPaCode:longint;
begin
  Result := oBtrTable.FieldByName('PaCode').AsInteger;
end;

procedure TFgpadscBtr.WritePaCode(pValue:longint);
begin
  oBtrTable.FieldByName('PaCode').AsInteger := pValue;
end;

function TFgpadscBtr.ReadFgCode:longint;
begin
  Result := oBtrTable.FieldByName('FgCode').AsInteger;
end;

procedure TFgpadscBtr.WriteFgCode(pValue:longint);
begin
  oBtrTable.FieldByName('FgCode').AsInteger := pValue;
end;

function TFgpadscBtr.ReadDscPrc:double;
begin
  Result := oBtrTable.FieldByName('DscPrc').AsFloat;
end;

procedure TFgpadscBtr.WriteDscPrc(pValue:double);
begin
  oBtrTable.FieldByName('DscPrc').AsFloat := pValue;
end;

function TFgpadscBtr.ReadSended:boolean;
begin
  Result := oBtrTable.FieldByName('Sended').AsBoolean;
end;

procedure TFgpadscBtr.WriteSended(pValue:boolean);
begin
  oBtrTable.FieldByName('Sended').AsBoolean := pValue;
end;

function TFgpadscBtr.ReadModNum:word;
begin
  Result := oBtrTable.FieldByName('ModNum').AsInteger;
end;

procedure TFgpadscBtr.WriteModNum(pValue:word);
begin
  oBtrTable.FieldByName('ModNum').AsInteger := pValue;
end;

function TFgpadscBtr.ReadModUser:Str8;
begin
  Result := oBtrTable.FieldByName('ModUser').AsString;
end;

procedure TFgpadscBtr.WriteModUser(pValue:Str8);
begin
  oBtrTable.FieldByName('ModUser').AsString := pValue;
end;

function TFgpadscBtr.ReadModDate:TDatetime;
begin
  Result := oBtrTable.FieldByName('ModDate').AsDateTime;
end;

procedure TFgpadscBtr.WriteModDate(pValue:TDatetime);
begin
  oBtrTable.FieldByName('ModDate').AsDateTime := pValue;
end;

function TFgpadscBtr.ReadModTime:TDatetime;
begin
  Result := oBtrTable.FieldByName('ModTime').AsDateTime;
end;

procedure TFgpadscBtr.WriteModTime(pValue:TDatetime);
begin
  oBtrTable.FieldByName('ModTime').AsDateTime := pValue;
end;

// **************************************** PUBLIC ********************************************

function TFgpadscBtr.Eof: boolean;
begin
  Result := oBtrTable.Eof;
end;

function TFgpadscBtr.Active: boolean;
begin
  Result := oBtrTable.Active;
end;

function TFgpadscBtr.ActPos: longint;
begin
  Result := oBtrTable.ActPos;
end;

function TFgpadscBtr.GotoPos (pActPos:longint): boolean;
begin
  Result := oBtrTable.GotoPos(pActPos);
end;

function TFgpadscBtr.LocatePaFg (pPaCode:longint;pFgCode:longint):boolean;
begin
  SetIndex (ixPaFg);
  Result := oBtrTable.FindKey([pPaCode,pFgCode]);
end;

function TFgpadscBtr.LocatePaCode (pPaCode:longint):boolean;
begin
  SetIndex (ixPaCode);
  Result := oBtrTable.FindKey([pPaCode]);
end;

function TFgpadscBtr.LocateSended (pSended:byte):boolean;
begin
  SetIndex (ixSended);
  Result := oBtrTable.FindKey([pSended]);
end;

procedure TFgpadscBtr.SetIndex (pIndexName:ShortString);
begin
  If oBtrTable.IndexName<>pIndexName then oBtrTable.IndexName := pIndexName;
end;

procedure TFgpadscBtr.Open;
begin
  oBtrTable.Open;
end;

procedure TFgpadscBtr.Close;
begin
  If oBtrTable.Active then oBtrTable.Close;
end;

procedure TFgpadscBtr.Prior;
begin
  oBtrTable.Prior;
end;

procedure TFgpadscBtr.Next;
begin
  oBtrTable.Next;
end;

procedure TFgpadscBtr.First;
begin
  oBtrTable.First;
end;

procedure TFgpadscBtr.Last;
begin
  oBtrTable.Last;
end;

procedure TFgpadscBtr.Insert;
begin
  oBtrTable.Insert;
end;

procedure TFgpadscBtr.Edit;
begin
  oBtrTable.Edit;
end;

procedure TFgpadscBtr.Post;
begin
  oBtrTable.Post;
end;

procedure TFgpadscBtr.Delete;
begin
  oBtrTable.Delete;
end;

procedure TFgpadscBtr.SwapIndex;
begin
  oBtrTable.SwapIndex;
end;

procedure TFgpadscBtr.RestoreIndex;
begin
  oBtrTable.RestoreIndex;
end;

procedure TFgpadscBtr.SwapStatus;
begin
  oBtrTable.SwapStatus;
end;

procedure TFgpadscBtr.RestoreStatus;
begin
  oBtrTable.RestoreStatus;
end;

procedure TFgpadscBtr.EnableControls;
begin
  oBtrTable.EnableControls;
end;

procedure TFgpadscBtr.DisableControls;
begin
  oBtrTable.DisableControls;
end;

end.
