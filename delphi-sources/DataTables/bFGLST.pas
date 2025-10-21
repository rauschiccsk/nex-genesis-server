unit bFGLST;

interface

uses
  IcTypes, IcConv, NexPath, NexGlob,
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls,
  Dialogs, DB, NexBtrTable, DBTables, NexPxTable;

const
  ixFgCode = 'FgCode';
  ixFgName = 'FgName';
  ixSended = 'Sended';

type
  TFglstBtr = class (TComponent)
    constructor Create; overload;
    destructor  Destroy; override;
  private
    oBtrTable: TNexBtrTable;
    function ReadCount:integer;
    function FieldExist (pFieldName:ShortString): boolean;
    // Pristup k databazovym poliam
    function  ReadFgCode:longint;        procedure WriteFgCode (pValue:longint);
    function  ReadFgName:Str30;          procedure WriteFgName (pValue:Str30);
    function  ReadFgName_:Str20;         procedure WriteFgName_ (pValue:Str20);
    function  ReadDescribe:Str150;       procedure WriteDescribe (pValue:Str150);
    function  ReadSended:boolean;        procedure WriteSended (pValue:boolean);
    function  ReadMaxDsc:double;         procedure WriteMaxDsc (pValue:double);
    function  ReadModNum:word;           procedure WriteModNum (pValue:word);
    function  ReadModUser:Str8;          procedure WriteModUser (pValue:Str8);
    function  ReadModDate:TDatetime;     procedure WriteModDate (pValue:TDatetime);
    function  ReadModTime:TDatetime;     procedure WriteModTime (pValue:TDatetime);
    function  ReadMinPrf:double;         procedure WriteMinPrf (pValue:double);
  public
    constructor Create(pPath:ShortString); overload;
    // Elementarne databazove operacie
    function Eof: boolean;
    function IsFirstRec: boolean;
    function IsLastRec: boolean;
    function Active: boolean;
    function ActPos: longint;
    function GotoPos (pActPos:longint): boolean;
    function LocateFgCode (pFgCode:longint):boolean;
    function LocateFgName (pFgName_:Str20):boolean;
    function LocateSended (pSended:byte):boolean;
    function NearestFgCode (pFgCode:longint):boolean;
    function NearestFgName (pFgName_:Str20):boolean;
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
    property FgCode:longint read ReadFgCode write WriteFgCode;
    property FgName:Str30 read ReadFgName write WriteFgName;
    property FgName_:Str20 read ReadFgName_ write WriteFgName_;
    property Describe:Str150 read ReadDescribe write WriteDescribe;
    property Sended:boolean read ReadSended write WriteSended;
    property MaxDsc:double read ReadMaxDsc write WriteMaxDsc;
    property ModNum:word read ReadModNum write WriteModNum;
    property ModUser:Str8 read ReadModUser write WriteModUser;
    property ModDate:TDatetime read ReadModDate write WriteModDate;
    property ModTime:TDatetime read ReadModTime write WriteModTime;
    property MinPrf:double read ReadMinPrf write WriteMinPrf;
  end;

implementation

constructor TFglstBtr.Create;
begin
  oBtrTable := BtrInit ('FGLST',gPath.StkPath,Self);
end;

constructor TFglstBtr.Create(pPath:ShortString);
begin
  oBtrTable := BtrInit ('FGLST',pPath,Self);
end;

destructor TFglstBtr.Destroy;
begin
  oBtrTable.Close;  FreeAndNil (oBtrTable);
end;

// *************************************** PRIVATE ********************************************

function TFglstBtr.ReadCount:integer;
begin
  Result := oBtrTable.RecordCount;
end;

function TFglstBtr.FieldExist (pFieldName:ShortString): boolean;
begin
  Result := oBtrTable.FindField(pFieldName)<>nil;
end;

function TFglstBtr.ReadFgCode:longint;
begin
  Result := oBtrTable.FieldByName('FgCode').AsInteger;
end;

procedure TFglstBtr.WriteFgCode(pValue:longint);
begin
  oBtrTable.FieldByName('FgCode').AsInteger := pValue;
end;

function TFglstBtr.ReadFgName:Str30;
begin
  Result := oBtrTable.FieldByName('FgName').AsString;
end;

procedure TFglstBtr.WriteFgName(pValue:Str30);
begin
  oBtrTable.FieldByName('FgName').AsString := pValue;
end;

function TFglstBtr.ReadFgName_:Str20;
begin
  Result := oBtrTable.FieldByName('FgName_').AsString;
end;

procedure TFglstBtr.WriteFgName_(pValue:Str20);
begin
  oBtrTable.FieldByName('FgName_').AsString := pValue;
end;

function TFglstBtr.ReadDescribe:Str150;
begin
  Result := oBtrTable.FieldByName('Describe').AsString;
end;

procedure TFglstBtr.WriteDescribe(pValue:Str150);
begin
  oBtrTable.FieldByName('Describe').AsString := pValue;
end;

function TFglstBtr.ReadSended:boolean;
begin
  Result := ByteToBool(oBtrTable.FieldByName('Sended').AsInteger);
end;

procedure TFglstBtr.WriteSended(pValue:boolean);
begin
  oBtrTable.FieldByName('Sended').AsInteger := BoolToByte(pValue);
end;

function TFglstBtr.ReadMaxDsc:double;
begin
  Result := oBtrTable.FieldByName('MaxDsc').AsFloat;
end;

procedure TFglstBtr.WriteMaxDsc(pValue:double);
begin
  oBtrTable.FieldByName('MaxDsc').AsFloat := pValue;
end;

function TFglstBtr.ReadModNum:word;
begin
  Result := oBtrTable.FieldByName('ModNum').AsInteger;
end;

procedure TFglstBtr.WriteModNum(pValue:word);
begin
  oBtrTable.FieldByName('ModNum').AsInteger := pValue;
end;

function TFglstBtr.ReadModUser:Str8;
begin
  Result := oBtrTable.FieldByName('ModUser').AsString;
end;

procedure TFglstBtr.WriteModUser(pValue:Str8);
begin
  oBtrTable.FieldByName('ModUser').AsString := pValue;
end;

function TFglstBtr.ReadModDate:TDatetime;
begin
  Result := oBtrTable.FieldByName('ModDate').AsDateTime;
end;

procedure TFglstBtr.WriteModDate(pValue:TDatetime);
begin
  oBtrTable.FieldByName('ModDate').AsDateTime := pValue;
end;

function TFglstBtr.ReadModTime:TDatetime;
begin
  Result := oBtrTable.FieldByName('ModTime').AsDateTime;
end;

procedure TFglstBtr.WriteModTime(pValue:TDatetime);
begin
  oBtrTable.FieldByName('ModTime').AsDateTime := pValue;
end;

function TFglstBtr.ReadMinPrf:double;
begin
  Result := oBtrTable.FieldByName('MinPrf').AsFloat;
end;

procedure TFglstBtr.WriteMinPrf(pValue:double);
begin
  oBtrTable.FieldByName('MinPrf').AsFloat := pValue;
end;

// **************************************** PUBLIC ********************************************

function TFglstBtr.Eof: boolean;
begin
  Result := oBtrTable.Eof;
end;

function TFglstBtr.IsFirstRec: boolean;
begin
  Result := oBtrTable.Bof;
end;

function TFglstBtr.IsLastRec: boolean;
begin
  Result := oBtrTable.Eof;
end;

function TFglstBtr.Active: boolean;
begin
  Result := oBtrTable.Active;
end;

function TFglstBtr.ActPos: longint;
begin
  Result := oBtrTable.ActPos;
end;

function TFglstBtr.GotoPos (pActPos:longint): boolean;
begin
  Result := oBtrTable.GotoPos(pActPos);
end;

function TFglstBtr.LocateFgCode (pFgCode:longint):boolean;
begin
  SetIndex (ixFgCode);
  Result := oBtrTable.FindKey([pFgCode]);
end;

function TFglstBtr.LocateFgName (pFgName_:Str20):boolean;
begin
  SetIndex (ixFgName);
  Result := oBtrTable.FindKey([StrToAlias(pFgName_)]);
end;

function TFglstBtr.LocateSended (pSended:byte):boolean;
begin
  SetIndex (ixSended);
  Result := oBtrTable.FindKey([pSended]);
end;

function TFglstBtr.NearestFgCode (pFgCode:longint):boolean;
begin
  SetIndex (ixFgCode);
  Result := oBtrTable.FindNearest([pFgCode]);
end;

function TFglstBtr.NearestFgName (pFgName_:Str20):boolean;
begin
  SetIndex (ixFgName);
  Result := oBtrTable.FindNearest([pFgName_]);
end;

function TFglstBtr.NearestSended (pSended:byte):boolean;
begin
  SetIndex (ixSended);
  Result := oBtrTable.FindNearest([pSended]);
end;

procedure TFglstBtr.SetIndex (pIndexName:ShortString);
begin
  If oBtrTable.IndexName<>pIndexName then oBtrTable.IndexName := pIndexName;
end;

procedure TFglstBtr.Open;
begin
  oBtrTable.Open;
end;

procedure TFglstBtr.Close;
begin
  If oBtrTable.Active then oBtrTable.Close;
end;

procedure TFglstBtr.Prior;
begin
  oBtrTable.Prior;
end;

procedure TFglstBtr.Next;
begin
  oBtrTable.Next;
end;

procedure TFglstBtr.First;
begin
  oBtrTable.First;
end;

procedure TFglstBtr.Last;
begin
  oBtrTable.Last;
end;

procedure TFglstBtr.Insert;
begin
  oBtrTable.Insert;
end;

procedure TFglstBtr.Edit;
begin
  oBtrTable.Edit;
end;

procedure TFglstBtr.Post;
begin
  oBtrTable.Post;
end;

procedure TFglstBtr.Delete;
begin
  oBtrTable.Delete;
end;

procedure TFglstBtr.SwapIndex;
begin
  oBtrTable.SwapIndex;
end;

procedure TFglstBtr.RestoreIndex;
begin
  oBtrTable.RestoreIndex;
end;

procedure TFglstBtr.SwapStatus;
begin
  oBtrTable.SwapStatus;
end;

procedure TFglstBtr.RestoreStatus;
begin
  oBtrTable.RestoreStatus;
end;

procedure TFglstBtr.EnableControls;
begin
  oBtrTable.EnableControls;
end;

procedure TFglstBtr.DisableControls;
begin
  oBtrTable.DisableControls;
end;

end.
{MOD 1928001}
