unit bFXC;

interface

uses
  IcTypes, IcConv, NexPath, NexGlob,
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls,
  Dialogs, DB, NexBtrTable, DBTables, NexPxTable;

const
  ixChgDate = 'ChgDate';
  ixDocNum = 'DocNum';
  ixDoCy = 'DoCy';
  ixDoCyCm = 'DoCyCm';

type
  TFxcBtr = class (TComponent)
    constructor Create; overload;
    destructor  Destroy; override;
  private
    oBookNum: Str5;
    oBtrTable: TNexBtrTable;
    function ReadCount:integer;
    function FieldExist (pFieldName:ShortString): boolean;
    // Pristup k databazovym poliam
    function  ReadChgDate:TDatetime;     procedure WriteChgDate (pValue:TDatetime);
    function  ReadDescrib:Str30;         procedure WriteDescrib (pValue:Str30);
    function  ReadChgVal:double;         procedure WriteChgVal (pValue:double);
    function  ReadDocNum:Str12;          procedure WriteDocNum (pValue:Str12);
    function  ReadChgYear:word;          procedure WriteChgYear (pValue:word);
    function  ReadChgMth:byte;           procedure WriteChgMth (pValue:byte);
    function  ReadCrtName:Str8;          procedure WriteCrtName (pValue:Str8);
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
    function LocateChgDate (pChgDate:TDatetime):boolean;
    function LocateDocNum (pDocNum:Str12):boolean;
    function LocateDoCy (pDocNum:Str12;pChgYear:word):boolean;
    function LocateDoCyCm (pDocNum:Str12;pChgYear:word;pChgMth:byte):boolean;
    function NearestChgDate (pChgDate:TDatetime):boolean;
    function NearestDocNum (pDocNum:Str12):boolean;
    function NearestDoCy (pDocNum:Str12;pChgYear:word):boolean;
    function NearestDoCyCm (pDocNum:Str12;pChgYear:word;pChgMth:byte):boolean;

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
    property ChgDate:TDatetime read ReadChgDate write WriteChgDate;
    property Describ:Str30 read ReadDescrib write WriteDescrib;
    property ChgVal:double read ReadChgVal write WriteChgVal;
    property DocNum:Str12 read ReadDocNum write WriteDocNum;
    property ChgYear:word read ReadChgYear write WriteChgYear;
    property ChgMth:byte read ReadChgMth write WriteChgMth;
    property CrtName:Str8 read ReadCrtName write WriteCrtName;
    property CrtDate:TDatetime read ReadCrtDate write WriteCrtDate;
    property CrtTime:TDatetime read ReadCrtTime write WriteCrtTime;
    property ModUser:Str8 read ReadModUser write WriteModUser;
    property ModDate:TDatetime read ReadModDate write WriteModDate;
    property ModTime:TDatetime read ReadModTime write WriteModTime;
  end;

implementation

constructor TFxcBtr.Create;
begin
  oBtrTable := BtrInit ('FXC',gPath.LdgPath,Self);
end;

constructor TFxcBtr.Create(pPath:ShortString);
begin
  oBtrTable := BtrInit ('FXC',pPath,Self);
end;

destructor TFxcBtr.Destroy;
begin
  oBtrTable.Close;  FreeAndNil (oBtrTable);
end;

// *************************************** PRIVATE ********************************************

function TFxcBtr.ReadCount:integer;
begin
  Result := oBtrTable.RecordCount;
end;

function TFxcBtr.FieldExist (pFieldName:ShortString): boolean;
begin
  Result := oBtrTable.FindField(pFieldName)<>nil;
end;

function TFxcBtr.ReadChgDate:TDatetime;
begin
  Result := oBtrTable.FieldByName('ChgDate').AsDateTime;
end;

procedure TFxcBtr.WriteChgDate(pValue:TDatetime);
begin
  oBtrTable.FieldByName('ChgDate').AsDateTime := pValue;
end;

function TFxcBtr.ReadDescrib:Str30;
begin
  Result := oBtrTable.FieldByName('Describ').AsString;
end;

procedure TFxcBtr.WriteDescrib(pValue:Str30);
begin
  oBtrTable.FieldByName('Describ').AsString := pValue;
end;

function TFxcBtr.ReadChgVal:double;
begin
  Result := oBtrTable.FieldByName('ChgVal').AsFloat;
end;

procedure TFxcBtr.WriteChgVal(pValue:double);
begin
  oBtrTable.FieldByName('ChgVal').AsFloat := pValue;
end;

function TFxcBtr.ReadDocNum:Str12;
begin
  Result := oBtrTable.FieldByName('DocNum').AsString;
end;

procedure TFxcBtr.WriteDocNum(pValue:Str12);
begin
  oBtrTable.FieldByName('DocNum').AsString := pValue;
end;

function TFxcBtr.ReadChgYear:word;
begin
  Result := oBtrTable.FieldByName('ChgYear').AsInteger;
end;

procedure TFxcBtr.WriteChgYear(pValue:word);
begin
  oBtrTable.FieldByName('ChgYear').AsInteger := pValue;
end;

function TFxcBtr.ReadChgMth:byte;
begin
  Result := oBtrTable.FieldByName('ChgMth').AsInteger;
end;

procedure TFxcBtr.WriteChgMth(pValue:byte);
begin
  oBtrTable.FieldByName('ChgMth').AsInteger := pValue;
end;

function TFxcBtr.ReadCrtName:Str8;
begin
  Result := oBtrTable.FieldByName('CrtName').AsString;
end;

procedure TFxcBtr.WriteCrtName(pValue:Str8);
begin
  oBtrTable.FieldByName('CrtName').AsString := pValue;
end;

function TFxcBtr.ReadCrtDate:TDatetime;
begin
  Result := oBtrTable.FieldByName('CrtDate').AsDateTime;
end;

procedure TFxcBtr.WriteCrtDate(pValue:TDatetime);
begin
  oBtrTable.FieldByName('CrtDate').AsDateTime := pValue;
end;

function TFxcBtr.ReadCrtTime:TDatetime;
begin
  Result := oBtrTable.FieldByName('CrtTime').AsDateTime;
end;

procedure TFxcBtr.WriteCrtTime(pValue:TDatetime);
begin
  oBtrTable.FieldByName('CrtTime').AsDateTime := pValue;
end;

function TFxcBtr.ReadModUser:Str8;
begin
  Result := oBtrTable.FieldByName('ModUser').AsString;
end;

procedure TFxcBtr.WriteModUser(pValue:Str8);
begin
  oBtrTable.FieldByName('ModUser').AsString := pValue;
end;

function TFxcBtr.ReadModDate:TDatetime;
begin
  Result := oBtrTable.FieldByName('ModDate').AsDateTime;
end;

procedure TFxcBtr.WriteModDate(pValue:TDatetime);
begin
  oBtrTable.FieldByName('ModDate').AsDateTime := pValue;
end;

function TFxcBtr.ReadModTime:TDatetime;
begin
  Result := oBtrTable.FieldByName('ModTime').AsDateTime;
end;

procedure TFxcBtr.WriteModTime(pValue:TDatetime);
begin
  oBtrTable.FieldByName('ModTime').AsDateTime := pValue;
end;

// **************************************** PUBLIC ********************************************

function TFxcBtr.Eof: boolean;
begin
  Result := oBtrTable.Eof;
end;

function TFxcBtr.IsFirstRec: boolean;
begin
  Result := oBtrTable.Bof;
end;

function TFxcBtr.IsLastRec: boolean;
begin
  Result := oBtrTable.Eof;
end;

function TFxcBtr.Active: boolean;
begin
  Result := oBtrTable.Active;
end;

function TFxcBtr.ActPos: longint;
begin
  Result := oBtrTable.ActPos;
end;

function TFxcBtr.GotoPos (pActPos:longint): boolean;
begin
  Result := oBtrTable.GotoPos(pActPos);
end;

function TFxcBtr.LocateChgDate (pChgDate:TDatetime):boolean;
begin
  SetIndex (ixChgDate);
  Result := oBtrTable.FindKey([pChgDate]);
end;

function TFxcBtr.LocateDocNum (pDocNum:Str12):boolean;
begin
  SetIndex (ixDocNum);
  Result := oBtrTable.FindKey([pDocNum]);
end;

function TFxcBtr.LocateDoCy (pDocNum:Str12;pChgYear:word):boolean;
begin
  SetIndex (ixDoCy);
  Result := oBtrTable.FindKey([pDocNum,pChgYear]);
end;

function TFxcBtr.LocateDoCyCm (pDocNum:Str12;pChgYear:word;pChgMth:byte):boolean;
begin
  SetIndex (ixDoCyCm);
  Result := oBtrTable.FindKey([pDocNum,pChgYear,pChgMth]);
end;

function TFxcBtr.NearestChgDate (pChgDate:TDatetime):boolean;
begin
  SetIndex (ixChgDate);
  Result := oBtrTable.FindNearest([pChgDate]);
end;

function TFxcBtr.NearestDocNum (pDocNum:Str12):boolean;
begin
  SetIndex (ixDocNum);
  Result := oBtrTable.FindNearest([pDocNum]);
end;

function TFxcBtr.NearestDoCy (pDocNum:Str12;pChgYear:word):boolean;
begin
  SetIndex (ixDoCy);
  Result := oBtrTable.FindNearest([pDocNum,pChgYear]);
end;

function TFxcBtr.NearestDoCyCm (pDocNum:Str12;pChgYear:word;pChgMth:byte):boolean;
begin
  SetIndex (ixDoCyCm);
  Result := oBtrTable.FindNearest([pDocNum,pChgYear,pChgMth]);
end;

procedure TFxcBtr.SetIndex (pIndexName:ShortString);
begin
  If oBtrTable.IndexName<>pIndexName then oBtrTable.IndexName := pIndexName;
end;

procedure TFxcBtr.Open(pBookNum:Str5);
begin
  oBookNum := pBookNum;
  oBtrTable.Open(pBookNum);
end;

procedure TFxcBtr.Close;
begin
  If oBtrTable.Active then oBtrTable.Close;
end;

procedure TFxcBtr.Prior;
begin
  oBtrTable.Prior;
end;

procedure TFxcBtr.Next;
begin
  oBtrTable.Next;
end;

procedure TFxcBtr.First;
begin
  oBtrTable.First;
end;

procedure TFxcBtr.Last;
begin
  oBtrTable.Last;
end;

procedure TFxcBtr.Insert;
begin
  oBtrTable.Insert;
end;

procedure TFxcBtr.Edit;
begin
  oBtrTable.Edit;
end;

procedure TFxcBtr.Post;
begin
  oBtrTable.Post;
end;

procedure TFxcBtr.Delete;
begin
  oBtrTable.Delete;
end;

procedure TFxcBtr.SwapIndex;
begin
  oBtrTable.SwapIndex;
end;

procedure TFxcBtr.RestoreIndex;
begin
  oBtrTable.RestoreIndex;
end;

procedure TFxcBtr.SwapStatus;
begin
  oBtrTable.SwapStatus;
end;

procedure TFxcBtr.RestoreStatus;
begin
  oBtrTable.RestoreStatus;
end;

procedure TFxcBtr.EnableControls;
begin
  oBtrTable.EnableControls;
end;

procedure TFxcBtr.DisableControls;
begin
  oBtrTable.DisableControls;
end;

end.
