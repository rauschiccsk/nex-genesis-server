unit bStklst;

interface

uses
  IcTypes, IcConv, NexPath, NexGlob,
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls,
  Dialogs, DB, NexBtrTable, DBTables, NexPxTable;

const
  ixStkNum = 'StkNum';
  ixStkName = 'StkName';

type
  TStklstBtr = class (TComponent)
    constructor Create; overload;
    destructor  Destroy; override;
  private
    oBtrTable: TNexBtrTable;
    function ReadCount:integer;
    function FieldExist (pFieldName:ShortString): boolean;
    // Pristup k databazovym poliam
    function  ReadStkNum:word;           procedure WriteStkNum (pValue:word);
    function  ReadStkName:Str30;         procedure WriteStkName (pValue:Str30);
    function  ReadStkName_:Str15;        procedure WriteStkName_ (pValue:Str15);
    function  ReadStkType:Str1;          procedure WriteStkType (pValue:Str1);
    function  ReadIvDate:TDatetime;      procedure WriteIvDate (pValue:TDatetime);
    function  ReadWriNum:word;           procedure WriteWriNum (pValue:word);
    function  ReadPlsNum:word;           procedure WritePlsNum (pValue:word);
    function  ReadShared:boolean;        procedure WriteShared (pValue:boolean);
    function  ReadModNum:word;           procedure WriteModNum (pValue:word);
    function  ReadModUser:Str8;          procedure WriteModUser (pValue:Str8);
    function  ReadModDate:TDatetime;     procedure WriteModDate (pValue:TDatetime);
    function  ReadModTime:TDatetime;     procedure WriteModTime (pValue:TDatetime);
  public
    constructor Create(pPath:ShortString); overload;
    // Elementarne databazove operacie
    function Eof: boolean;
    function Active: boolean;
    function ActPos: longint;
    function GotoPos (pActPos:longint): boolean;
    function LocateStkNum (pStkNum:word):boolean;
    function LocateStkName (pStkName_:Str15):boolean;

    procedure SetIndex (pIndexName:ShortString);
    procedure Open;
    procedure Close;
    procedure Prior;
    procedure Next;
    procedure First;
    procedure Last;
    procedure Insert;
    procedure Edit;
    procedure Post; virtual;
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
    property StkNum:word read ReadStkNum write WriteStkNum;
    property StkName:Str30 read ReadStkName write WriteStkName;
    property StkName_:Str15 read ReadStkName_ write WriteStkName_;
    property StkType:Str1 read ReadStkType write WriteStkType;
    property IvDate:TDatetime read ReadIvDate write WriteIvDate;
    property WriNum:word read ReadWriNum write WriteWriNum;
    property PlsNum:word read ReadPlsNum write WritePlsNum;
    property Shared:boolean read ReadShared write WriteShared;
    property ModNum:word read ReadModNum write WriteModNum;
    property ModUser:Str8 read ReadModUser write WriteModUser;
    property ModDate:TDatetime read ReadModDate write WriteModDate;
    property ModTime:TDatetime read ReadModTime write WriteModTime;
  end;

implementation

constructor TStklstBtr.Create;
begin
  oBtrTable := BtrInit ('STKLST',gPath.StkPath,Self);
end;

constructor TStklstBtr.Create(pPath:ShortString);
begin
  oBtrTable := BtrInit ('STKLST',pPath,Self);
end;

destructor TStklstBtr.Destroy;
begin
  oBtrTable.Close;  FreeAndNil (oBtrTable);
end;

// *************************************** PRIVATE ********************************************

function TStklstBtr.ReadCount:integer;
begin
  Result := oBtrTable.RecordCount;
end;

function TStklstBtr.FieldExist (pFieldName:ShortString): boolean;
begin
  Result := oBtrTable.FindField(pFieldName)<>nil;
end;

function TStklstBtr.ReadStkNum:word;
begin
  Result := oBtrTable.FieldByName('StkNum').AsInteger;
end;

procedure TStklstBtr.WriteStkNum(pValue:word);
begin
  oBtrTable.FieldByName('StkNum').AsInteger := pValue;
end;

function TStklstBtr.ReadStkName:Str30;
begin
  Result := oBtrTable.FieldByName('StkName').AsString;
end;

procedure TStklstBtr.WriteStkName(pValue:Str30);
begin
  oBtrTable.FieldByName('StkName').AsString := pValue;
end;

function TStklstBtr.ReadStkName_:Str15;
begin
  Result := oBtrTable.FieldByName('StkName_').AsString;
end;

procedure TStklstBtr.WriteStkName_(pValue:Str15);
begin
  oBtrTable.FieldByName('StkName_').AsString := pValue;
end;

function TStklstBtr.ReadStkType:Str1;
begin
  Result := oBtrTable.FieldByName('StkType').AsString;
end;

procedure TStklstBtr.WriteStkType(pValue:Str1);
begin
  oBtrTable.FieldByName('StkType').AsString := pValue;
end;

function TStklstBtr.ReadIvDate:TDatetime;
begin
  Result := oBtrTable.FieldByName('IvDate').AsDateTime;
end;

procedure TStklstBtr.WriteIvDate(pValue:TDatetime);
begin
  oBtrTable.FieldByName('IvDate').AsDateTime := pValue;
end;

function TStklstBtr.ReadWriNum:word;
begin
  Result := oBtrTable.FieldByName('WriNum').AsInteger;
end;

procedure TStklstBtr.WriteWriNum(pValue:word);
begin
  oBtrTable.FieldByName('WriNum').AsInteger := pValue;
end;

function TStklstBtr.ReadPlsNum:word;
begin
  Result := oBtrTable.FieldByName('PlsNum').AsInteger;
end;

procedure TStklstBtr.WritePlsNum(pValue:word);
begin
  oBtrTable.FieldByName('PlsNum').AsInteger := pValue;
end;

function TStklstBtr.ReadShared:boolean;
begin
  Result := ByteToBool(oBtrTable.FieldByName('Shared').AsInteger);
end;

procedure TStklstBtr.WriteShared(pValue:boolean);
begin
  oBtrTable.FieldByName('Shared').AsInteger := BoolToByte(pValue);
end;

function TStklstBtr.ReadModNum:word;
begin
  Result := oBtrTable.FieldByName('ModNum').AsInteger;
end;

procedure TStklstBtr.WriteModNum(pValue:word);
begin
  oBtrTable.FieldByName('ModNum').AsInteger := pValue;
end;

function TStklstBtr.ReadModUser:Str8;
begin
  Result := oBtrTable.FieldByName('ModUser').AsString;
end;

procedure TStklstBtr.WriteModUser(pValue:Str8);
begin
  oBtrTable.FieldByName('ModUser').AsString := pValue;
end;

function TStklstBtr.ReadModDate:TDatetime;
begin
  Result := oBtrTable.FieldByName('ModDate').AsDateTime;
end;

procedure TStklstBtr.WriteModDate(pValue:TDatetime);
begin
  oBtrTable.FieldByName('ModDate').AsDateTime := pValue;
end;

function TStklstBtr.ReadModTime:TDatetime;
begin
  Result := oBtrTable.FieldByName('ModTime').AsDateTime;
end;

procedure TStklstBtr.WriteModTime(pValue:TDatetime);
begin
  oBtrTable.FieldByName('ModTime').AsDateTime := pValue;
end;

// **************************************** PUBLIC ********************************************

function TStklstBtr.Eof: boolean;
begin
  Result := oBtrTable.Eof;
end;

function TStklstBtr.Active: boolean;
begin
  Result := oBtrTable.Active;
end;

function TStklstBtr.ActPos: longint;
begin
  Result := oBtrTable.ActPos;
end;

function TStklstBtr.GotoPos (pActPos:longint): boolean;
begin
  Result := oBtrTable.GotoPos(pActPos);
end;

function TStklstBtr.LocateStkNum (pStkNum:word):boolean;
begin
  SetIndex (ixStkNum);
  Result := oBtrTable.FindKey([pStkNum]);
end;

function TStklstBtr.LocateStkName (pStkName_:Str15):boolean;
begin
  SetIndex (ixStkName);
  Result := oBtrTable.FindKey([pStkName_]);
end;

procedure TStklstBtr.SetIndex (pIndexName:ShortString);
begin
  If oBtrTable.IndexName<>pIndexName then oBtrTable.IndexName := pIndexName;
end;

procedure TStklstBtr.Open;
begin
  oBtrTable.Open;
end;

procedure TStklstBtr.Close;
begin
  If oBtrTable.Active then oBtrTable.Close;
end;

procedure TStklstBtr.Prior;
begin
  oBtrTable.Prior;
end;

procedure TStklstBtr.Next;
begin
  oBtrTable.Next;
end;

procedure TStklstBtr.First;
begin
  oBtrTable.First;
end;

procedure TStklstBtr.Last;
begin
  oBtrTable.Last;
end;

procedure TStklstBtr.Insert;
begin
  oBtrTable.Insert;
end;

procedure TStklstBtr.Edit;
begin
  oBtrTable.Edit;
end;

procedure TStklstBtr.Post;
begin
  oBtrTable.Post;
end;

procedure TStklstBtr.Delete;
begin
  oBtrTable.Delete;
end;

procedure TStklstBtr.SwapIndex;
begin
  oBtrTable.SwapIndex;
end;

procedure TStklstBtr.RestoreIndex;
begin
  oBtrTable.RestoreIndex;
end;

procedure TStklstBtr.SwapStatus;
begin
  oBtrTable.SwapStatus;
end;

procedure TStklstBtr.RestoreStatus;
begin
  oBtrTable.RestoreStatus;
end;

procedure TStklstBtr.EnableControls;
begin
  oBtrTable.EnableControls;
end;

procedure TStklstBtr.DisableControls;
begin
  oBtrTable.DisableControls;
end;

end.
