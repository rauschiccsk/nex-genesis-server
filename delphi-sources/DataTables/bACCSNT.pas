unit bACCSNT;

interface

uses
  IcTypes, IcConv, NexPath, NexGlob,
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls,
  Dialogs, DB, NexBtrTable, DBTables, NexPxTable;

const
  ixAccSnt = 'AccSnt';
  ixSntName = 'SntName';

type
  TAccsntBtr = class (TComponent)
    constructor Create; overload;
    destructor  Destroy; override;
  private
    oBtrTable: TNexBtrTable;
    function ReadCount:integer;
    function FieldExist (pFieldName:ShortString): boolean;
    // Pristup k databazovym poliam
    function  ReadAccSnt:str3;           procedure WriteAccSnt (pValue:str3);
    function  ReadSntName:Str30;         procedure WriteSntName (pValue:Str30);
    function  ReadSntName_:Str30;        procedure WriteSntName_ (pValue:Str30);
    function  ReadSntType:Str1;          procedure WriteSntType (pValue:Str1);
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
    function LocateAccSnt (pAccSnt:str3):boolean;
    function LocateSntName (pSntName_:Str30):boolean;
    function NearestAccSnt (pAccSnt:str3):boolean;
    function NearestSntName (pSntName_:Str30):boolean;

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
    property AccSnt:str3 read ReadAccSnt write WriteAccSnt;
    property SntName:Str30 read ReadSntName write WriteSntName;
    property SntName_:Str30 read ReadSntName_ write WriteSntName_;
    property SntType:Str1 read ReadSntType write WriteSntType;
    property CrtName:str8 read ReadCrtName write WriteCrtName;
    property CrtDate:TDatetime read ReadCrtDate write WriteCrtDate;
    property CrtTime:TDatetime read ReadCrtTime write WriteCrtTime;
    property ModNum:word read ReadModNum write WriteModNum;
    property ModUser:Str8 read ReadModUser write WriteModUser;
    property ModDate:TDatetime read ReadModDate write WriteModDate;
    property ModTime:TDatetime read ReadModTime write WriteModTime;
  end;

implementation

constructor TAccsntBtr.Create;
begin
  oBtrTable := BtrInit ('ACCSNT',gPath.LdgPath,Self);
end;

constructor TAccsntBtr.Create(pPath:ShortString);
begin
  oBtrTable := BtrInit ('ACCSNT',pPath,Self);
end;

destructor TAccsntBtr.Destroy;
begin
  oBtrTable.Close;  FreeAndNil (oBtrTable);
end;

// *************************************** PRIVATE ********************************************

function TAccsntBtr.ReadCount:integer;
begin
  Result := oBtrTable.RecordCount;
end;

function TAccsntBtr.FieldExist (pFieldName:ShortString): boolean;
begin
  Result := oBtrTable.FindField(pFieldName)<>nil;
end;

function TAccsntBtr.ReadAccSnt:str3;
begin
  Result := oBtrTable.FieldByName('AccSnt').AsString;
end;

procedure TAccsntBtr.WriteAccSnt(pValue:str3);
begin
  oBtrTable.FieldByName('AccSnt').AsString := pValue;
end;

function TAccsntBtr.ReadSntName:Str30;
begin
  Result := oBtrTable.FieldByName('SntName').AsString;
end;

procedure TAccsntBtr.WriteSntName(pValue:Str30);
begin
  oBtrTable.FieldByName('SntName').AsString := pValue;
end;

function TAccsntBtr.ReadSntName_:Str30;
begin
  Result := oBtrTable.FieldByName('SntName_').AsString;
end;

procedure TAccsntBtr.WriteSntName_(pValue:Str30);
begin
  oBtrTable.FieldByName('SntName_').AsString := pValue;
end;

function TAccsntBtr.ReadSntType:Str1;
begin
  Result := oBtrTable.FieldByName('SntType').AsString;
end;

procedure TAccsntBtr.WriteSntType(pValue:Str1);
begin
  oBtrTable.FieldByName('SntType').AsString := pValue;
end;

function TAccsntBtr.ReadCrtName:str8;
begin
  Result := oBtrTable.FieldByName('CrtName').AsString;
end;

procedure TAccsntBtr.WriteCrtName(pValue:str8);
begin
  oBtrTable.FieldByName('CrtName').AsString := pValue;
end;

function TAccsntBtr.ReadCrtDate:TDatetime;
begin
  Result := oBtrTable.FieldByName('CrtDate').AsDateTime;
end;

procedure TAccsntBtr.WriteCrtDate(pValue:TDatetime);
begin
  oBtrTable.FieldByName('CrtDate').AsDateTime := pValue;
end;

function TAccsntBtr.ReadCrtTime:TDatetime;
begin
  Result := oBtrTable.FieldByName('CrtTime').AsDateTime;
end;

procedure TAccsntBtr.WriteCrtTime(pValue:TDatetime);
begin
  oBtrTable.FieldByName('CrtTime').AsDateTime := pValue;
end;

function TAccsntBtr.ReadModNum:word;
begin
  Result := oBtrTable.FieldByName('ModNum').AsInteger;
end;

procedure TAccsntBtr.WriteModNum(pValue:word);
begin
  oBtrTable.FieldByName('ModNum').AsInteger := pValue;
end;

function TAccsntBtr.ReadModUser:Str8;
begin
  Result := oBtrTable.FieldByName('ModUser').AsString;
end;

procedure TAccsntBtr.WriteModUser(pValue:Str8);
begin
  oBtrTable.FieldByName('ModUser').AsString := pValue;
end;

function TAccsntBtr.ReadModDate:TDatetime;
begin
  Result := oBtrTable.FieldByName('ModDate').AsDateTime;
end;

procedure TAccsntBtr.WriteModDate(pValue:TDatetime);
begin
  oBtrTable.FieldByName('ModDate').AsDateTime := pValue;
end;

function TAccsntBtr.ReadModTime:TDatetime;
begin
  Result := oBtrTable.FieldByName('ModTime').AsDateTime;
end;

procedure TAccsntBtr.WriteModTime(pValue:TDatetime);
begin
  oBtrTable.FieldByName('ModTime').AsDateTime := pValue;
end;

// **************************************** PUBLIC ********************************************

function TAccsntBtr.Eof: boolean;
begin
  Result := oBtrTable.Eof;
end;

function TAccsntBtr.IsFirstRec: boolean;
begin
  Result := oBtrTable.Bof;
end;

function TAccsntBtr.IsLastRec: boolean;
begin
  Result := oBtrTable.Eof;
end;

function TAccsntBtr.Active: boolean;
begin
  Result := oBtrTable.Active;
end;

function TAccsntBtr.ActPos: longint;
begin
  Result := oBtrTable.ActPos;
end;

function TAccsntBtr.GotoPos (pActPos:longint): boolean;
begin
  Result := oBtrTable.GotoPos(pActPos);
end;

function TAccsntBtr.LocateAccSnt (pAccSnt:str3):boolean;
begin
  SetIndex (ixAccSnt);
  Result := oBtrTable.FindKey([pAccSnt]);
end;

function TAccsntBtr.LocateSntName (pSntName_:Str30):boolean;
begin
  SetIndex (ixSntName);
  Result := oBtrTable.FindKey([StrToAlias(pSntName_)]);
end;

function TAccsntBtr.NearestAccSnt (pAccSnt:str3):boolean;
begin
  SetIndex (ixAccSnt);
  Result := oBtrTable.FindNearest([pAccSnt]);
end;

function TAccsntBtr.NearestSntName (pSntName_:Str30):boolean;
begin
  SetIndex (ixSntName);
  Result := oBtrTable.FindNearest([pSntName_]);
end;

procedure TAccsntBtr.SetIndex (pIndexName:ShortString);
begin
  If oBtrTable.IndexName<>pIndexName then oBtrTable.IndexName := pIndexName;
end;

procedure TAccsntBtr.Open;
begin
  oBtrTable.Open;
end;

procedure TAccsntBtr.Close;
begin
  If oBtrTable.Active then oBtrTable.Close;
end;

procedure TAccsntBtr.Prior;
begin
  oBtrTable.Prior;
end;

procedure TAccsntBtr.Next;
begin
  oBtrTable.Next;
end;

procedure TAccsntBtr.First;
begin
  oBtrTable.First;
end;

procedure TAccsntBtr.Last;
begin
  oBtrTable.Last;
end;

procedure TAccsntBtr.Insert;
begin
  oBtrTable.Insert;
end;

procedure TAccsntBtr.Edit;
begin
  oBtrTable.Edit;
end;

procedure TAccsntBtr.Post;
begin
  oBtrTable.Post;
end;

procedure TAccsntBtr.Delete;
begin
  oBtrTable.Delete;
end;

procedure TAccsntBtr.SwapIndex;
begin
  oBtrTable.SwapIndex;
end;

procedure TAccsntBtr.RestoreIndex;
begin
  oBtrTable.RestoreIndex;
end;

procedure TAccsntBtr.SwapStatus;
begin
  oBtrTable.SwapStatus;
end;

procedure TAccsntBtr.RestoreStatus;
begin
  oBtrTable.RestoreStatus;
end;

procedure TAccsntBtr.EnableControls;
begin
  oBtrTable.EnableControls;
end;

procedure TAccsntBtr.DisableControls;
begin
  oBtrTable.DisableControls;
end;

end.
