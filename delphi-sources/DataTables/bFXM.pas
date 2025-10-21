unit bFXM;

interface

uses
  IcTypes, IcConv, NexPath, NexGlob,
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls,
  Dialogs, DB, NexBtrTable, DBTables, NexPxTable;

const
  ixDocNum = 'DocNum';
  ixDocDate = 'DocDate';
  ixDoDy = 'DoDy';
  ixDoDyDm = 'DoDyDm';

type
  TFxmBtr = class (TComponent)
    constructor Create; overload;
    destructor  Destroy; override;
  private
    oBookNum: Str5;
    oBtrTable: TNexBtrTable;
    function ReadCount:integer;
    function FieldExist (pFieldName:ShortString): boolean;
    // Pristup k databazovym poliam
    function  ReadDocNum:Str12;          procedure WriteDocNum (pValue:Str12);
    function  ReadDocDate:TDatetime;     procedure WriteDocDate (pValue:TDatetime);
    function  ReadDocYear:word;          procedure WriteDocYear (pValue:word);
    function  ReadDocMth:byte;           procedure WriteDocMth (pValue:byte);
    function  ReadDescrib:Str30;         procedure WriteDescrib (pValue:Str30);
    function  ReadDocVal:double;         procedure WriteDocVal (pValue:double);
    function  ReadCrtName:str8;          procedure WriteCrtName (pValue:str8);
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
    function LocateDocNum (pDocNum:Str12):boolean;
    function LocateDocDate (pDocDate:TDatetime):boolean;
    function LocateDoDy (pDocNum:Str12;pDocYear:word):boolean;
    function LocateDoDyDm (pDocNum:Str12;pDocYear:word;pDocMth:byte):boolean;
    function NearestDocNum (pDocNum:Str12):boolean;
    function NearestDocDate (pDocDate:TDatetime):boolean;
    function NearestDoDy (pDocNum:Str12;pDocYear:word):boolean;
    function NearestDoDyDm (pDocNum:Str12;pDocYear:word;pDocMth:byte):boolean;

    procedure SetIndex (pIndexName:ShortString);
    procedure Open (pBookNum:Str5);
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
    property DocNum:Str12 read ReadDocNum write WriteDocNum;
    property DocDate:TDatetime read ReadDocDate write WriteDocDate;
    property DocYear:word read ReadDocYear write WriteDocYear;
    property DocMth:byte read ReadDocMth write WriteDocMth;
    property Describ:Str30 read ReadDescrib write WriteDescrib;
    property DocVal:double read ReadDocVal write WriteDocVal;
    property CrtName:str8 read ReadCrtName write WriteCrtName;
    property CrtDate:TDatetime read ReadCrtDate write WriteCrtDate;
    property CrtTime:TDatetime read ReadCrtTime write WriteCrtTime;
    property ModNum:word read ReadModNum write WriteModNum;
    property ModUser:Str8 read ReadModUser write WriteModUser;
    property ModDate:TDatetime read ReadModDate write WriteModDate;
    property ModTime:TDatetime read ReadModTime write WriteModTime;
  end;

implementation

constructor TFxmBtr.Create;
begin
  oBtrTable := BtrInit ('FXM',gPath.LdgPath,Self);
end;

constructor TFxmBtr.Create(pPath:ShortString);
begin
  oBtrTable := BtrInit ('FXM',pPath,Self);
end;

destructor TFxmBtr.Destroy;
begin
  oBtrTable.Close;  FreeAndNil (oBtrTable);
end;

// *************************************** PRIVATE ********************************************

function TFxmBtr.ReadCount:integer;
begin
  Result := oBtrTable.RecordCount;
end;

function TFxmBtr.FieldExist (pFieldName:ShortString): boolean;
begin
  Result := oBtrTable.FindField(pFieldName)<>nil;
end;

function TFxmBtr.ReadDocNum:Str12;
begin
  Result := oBtrTable.FieldByName('DocNum').AsString;
end;

procedure TFxmBtr.WriteDocNum(pValue:Str12);
begin
  oBtrTable.FieldByName('DocNum').AsString := pValue;
end;

function TFxmBtr.ReadDocDate:TDatetime;
begin
  Result := oBtrTable.FieldByName('DocDate').AsDateTime;
end;

procedure TFxmBtr.WriteDocDate(pValue:TDatetime);
begin
  oBtrTable.FieldByName('DocDate').AsDateTime := pValue;
end;

function TFxmBtr.ReadDocYear:word;
begin
  Result := oBtrTable.FieldByName('DocYear').AsInteger;
end;

procedure TFxmBtr.WriteDocYear(pValue:word);
begin
  oBtrTable.FieldByName('DocYear').AsInteger := pValue;
end;

function TFxmBtr.ReadDocMth:byte;
begin
  Result := oBtrTable.FieldByName('DocMth').AsInteger;
end;

procedure TFxmBtr.WriteDocMth(pValue:byte);
begin
  oBtrTable.FieldByName('DocMth').AsInteger := pValue;
end;

function TFxmBtr.ReadDescrib:Str30;
begin
  Result := oBtrTable.FieldByName('Describ').AsString;
end;

procedure TFxmBtr.WriteDescrib(pValue:Str30);
begin
  oBtrTable.FieldByName('Describ').AsString := pValue;
end;

function TFxmBtr.ReadDocVal:double;
begin
  Result := oBtrTable.FieldByName('DocVal').AsFloat;
end;

procedure TFxmBtr.WriteDocVal(pValue:double);
begin
  oBtrTable.FieldByName('DocVal').AsFloat := pValue;
end;

function TFxmBtr.ReadCrtName:str8;
begin
  Result := oBtrTable.FieldByName('CrtName').AsString;
end;

procedure TFxmBtr.WriteCrtName(pValue:str8);
begin
  oBtrTable.FieldByName('CrtName').AsString := pValue;
end;

function TFxmBtr.ReadCrtDate:TDatetime;
begin
  Result := oBtrTable.FieldByName('CrtDate').AsDateTime;
end;

procedure TFxmBtr.WriteCrtDate(pValue:TDatetime);
begin
  oBtrTable.FieldByName('CrtDate').AsDateTime := pValue;
end;

function TFxmBtr.ReadCrtTime:TDatetime;
begin
  Result := oBtrTable.FieldByName('CrtTime').AsDateTime;
end;

procedure TFxmBtr.WriteCrtTime(pValue:TDatetime);
begin
  oBtrTable.FieldByName('CrtTime').AsDateTime := pValue;
end;

function TFxmBtr.ReadModNum:word;
begin
  Result := oBtrTable.FieldByName('ModNum').AsInteger;
end;

procedure TFxmBtr.WriteModNum(pValue:word);
begin
  oBtrTable.FieldByName('ModNum').AsInteger := pValue;
end;

function TFxmBtr.ReadModUser:Str8;
begin
  Result := oBtrTable.FieldByName('ModUser').AsString;
end;

procedure TFxmBtr.WriteModUser(pValue:Str8);
begin
  oBtrTable.FieldByName('ModUser').AsString := pValue;
end;

function TFxmBtr.ReadModDate:TDatetime;
begin
  Result := oBtrTable.FieldByName('ModDate').AsDateTime;
end;

procedure TFxmBtr.WriteModDate(pValue:TDatetime);
begin
  oBtrTable.FieldByName('ModDate').AsDateTime := pValue;
end;

function TFxmBtr.ReadModTime:TDatetime;
begin
  Result := oBtrTable.FieldByName('ModTime').AsDateTime;
end;

procedure TFxmBtr.WriteModTime(pValue:TDatetime);
begin
  oBtrTable.FieldByName('ModTime').AsDateTime := pValue;
end;

// **************************************** PUBLIC ********************************************

function TFxmBtr.Eof: boolean;
begin
  Result := oBtrTable.Eof;
end;

function TFxmBtr.IsFirstRec: boolean;
begin
  Result := oBtrTable.Bof;
end;

function TFxmBtr.IsLastRec: boolean;
begin
  Result := oBtrTable.Eof;
end;

function TFxmBtr.Active: boolean;
begin
  Result := oBtrTable.Active;
end;

function TFxmBtr.ActPos: longint;
begin
  Result := oBtrTable.ActPos;
end;

function TFxmBtr.GotoPos (pActPos:longint): boolean;
begin
  Result := oBtrTable.GotoPos(pActPos);
end;

function TFxmBtr.LocateDocNum (pDocNum:Str12):boolean;
begin
  SetIndex (ixDocNum);
  Result := oBtrTable.FindKey([pDocNum]);
end;

function TFxmBtr.LocateDocDate (pDocDate:TDatetime):boolean;
begin
  SetIndex (ixDocDate);
  Result := oBtrTable.FindKey([pDocDate]);
end;

function TFxmBtr.LocateDoDy (pDocNum:Str12;pDocYear:word):boolean;
begin
  SetIndex (ixDoDy);
  Result := oBtrTable.FindKey([pDocNum,pDocYear]);
end;

function TFxmBtr.LocateDoDyDm (pDocNum:Str12;pDocYear:word;pDocMth:byte):boolean;
begin
  SetIndex (ixDoDyDm);
  Result := oBtrTable.FindKey([pDocNum,pDocYear,pDocMth]);
end;

function TFxmBtr.NearestDocNum (pDocNum:Str12):boolean;
begin
  SetIndex (ixDocNum);
  Result := oBtrTable.FindNearest([pDocNum]);
end;

function TFxmBtr.NearestDocDate (pDocDate:TDatetime):boolean;
begin
  SetIndex (ixDocDate);
  Result := oBtrTable.FindNearest([pDocDate]);
end;

function TFxmBtr.NearestDoDy (pDocNum:Str12;pDocYear:word):boolean;
begin
  SetIndex (ixDoDy);
  Result := oBtrTable.FindNearest([pDocNum,pDocYear]);
end;

function TFxmBtr.NearestDoDyDm (pDocNum:Str12;pDocYear:word;pDocMth:byte):boolean;
begin
  SetIndex (ixDoDyDm);
  Result := oBtrTable.FindNearest([pDocNum,pDocYear,pDocMth]);
end;

procedure TFxmBtr.SetIndex (pIndexName:ShortString);
begin
  If oBtrTable.IndexName<>pIndexName then oBtrTable.IndexName := pIndexName;
end;

procedure TFxmBtr.Open(pBookNum:Str5);
begin
  oBookNum := pBookNum;
  oBtrTable.Open(pBookNum);
end;

procedure TFxmBtr.Close;
begin
  If oBtrTable.Active then oBtrTable.Close;
end;

procedure TFxmBtr.Prior;
begin
  oBtrTable.Prior;
end;

procedure TFxmBtr.Next;
begin
  oBtrTable.Next;
end;

procedure TFxmBtr.First;
begin
  oBtrTable.First;
end;

procedure TFxmBtr.Last;
begin
  oBtrTable.Last;
end;

procedure TFxmBtr.Insert;
begin
  oBtrTable.Insert;
end;

procedure TFxmBtr.Edit;
begin
  oBtrTable.Edit;
end;

procedure TFxmBtr.Post;
begin
  oBtrTable.Post;
end;

procedure TFxmBtr.Delete;
begin
  oBtrTable.Delete;
end;

procedure TFxmBtr.SwapIndex;
begin
  oBtrTable.SwapIndex;
end;

procedure TFxmBtr.RestoreIndex;
begin
  oBtrTable.RestoreIndex;
end;

procedure TFxmBtr.SwapStatus;
begin
  oBtrTable.SwapStatus;
end;

procedure TFxmBtr.RestoreStatus;
begin
  oBtrTable.RestoreStatus;
end;

procedure TFxmBtr.EnableControls;
begin
  oBtrTable.EnableControls;
end;

procedure TFxmBtr.DisableControls;
begin
  oBtrTable.DisableControls;
end;

end.
