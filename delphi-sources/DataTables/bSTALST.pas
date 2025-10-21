unit bStalst;

interface

uses
  IcTypes, NexPath, NexGlob,
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls,
  Dialogs, DB, NexBtrTable, DBTables, NexPxTable;

const
  ixStaCode = 'StaCode';
  ixStaName = 'StaName';
  ixStaTel = 'StaTel';
  ixDvzName = 'DvzName';

type
  TStalstBtr = class (TComponent)
    constructor Create;
    destructor  Destroy; override;
  private
    oBtrTable: TNexBtrTable;
    function ReadCount:integer;
    function FieldExist (pFieldName:ShortString): boolean;
    // Pristup k databazovym poliam
    function  ReadStaCode:Str2;          procedure WriteStaCode (pValue:Str2);
    function  ReadStaName:Str30;         procedure WriteStaName (pValue:Str30);
    function  ReadStaName_:Str30;        procedure WriteStaName_ (pValue:Str30);
    function  ReadStaTel:Str6;           procedure WriteStaTel (pValue:Str6);
    function  ReadDvzName:Str3;          procedure WriteDvzName (pValue:Str3);
    function  ReadCryName:Str30;         procedure WriteCryName (pValue:Str30);
    function  ReadCrtUser:Str8;          procedure WriteCrtUser (pValue:Str8);
    function  ReadCrtDate:TDatetime;     procedure WriteCrtDate (pValue:TDatetime);
    function  ReadCrtTime:TDatetime;     procedure WriteCrtTime (pValue:TDatetime);
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
    function LocateStaCode (pStaCode:Str2):boolean;
    function LocateStaName (pStaName_:Str30):boolean;
    function LocateStaTel (pStaTel:Str6):boolean;
    function LocateDvzName (pDvzName:Str3):boolean;

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
    property StaCode:Str2 read ReadStaCode write WriteStaCode;
    property StaName:Str30 read ReadStaName write WriteStaName;
    property StaName_:Str30 read ReadStaName_ write WriteStaName_;
    property StaTel:Str6 read ReadStaTel write WriteStaTel;
    property DvzName:Str3 read ReadDvzName write WriteDvzName;
    property CryName:Str30 read ReadCryName write WriteCryName;
    property CrtUser:Str8 read ReadCrtUser write WriteCrtUser;
    property CrtDate:TDatetime read ReadCrtDate write WriteCrtDate;
    property CrtTime:TDatetime read ReadCrtTime write WriteCrtTime;
    property ModNum:word read ReadModNum write WriteModNum;
    property ModUser:Str8 read ReadModUser write WriteModUser;
    property ModDate:TDatetime read ReadModDate write WriteModDate;
    property ModTime:TDatetime read ReadModTime write WriteModTime;
  end;

implementation

constructor TStalstBtr.Create;
begin
  oBtrTable := BtrInit ('Stalst',gPath.DlsPath,Self);
end;

destructor  TStalstBtr.Destroy;
begin
    oBtrTable.Close;  FreeAndNil (oBtrTable);
end;

// *************************************** PRIVATE ********************************************

function TStalstBtr.ReadCount:integer;
begin
  Result := oBtrTable.RecordCount;
end;

function TStalstBtr.FieldExist (pFieldName:ShortString): boolean;
begin
  Result := oBtrTable.FindField(pFieldName)<>nil;
end;

function TStalstBtr.ReadStaCode:Str2;
begin
  Result := oBtrTable.FieldByName('StaCode').AsString;
end;

procedure TStalstBtr.WriteStaCode(pValue:Str2);
begin
  oBtrTable.FieldByName('StaCode').AsString := pValue;
end;

function TStalstBtr.ReadStaName:Str30;
begin
  Result := oBtrTable.FieldByName('StaName').AsString;
end;

procedure TStalstBtr.WriteStaName(pValue:Str30);
begin
  oBtrTable.FieldByName('StaName').AsString := pValue;
end;

function TStalstBtr.ReadStaName_:Str30;
begin
  Result := oBtrTable.FieldByName('StaName_').AsString;
end;

procedure TStalstBtr.WriteStaName_(pValue:Str30);
begin
  oBtrTable.FieldByName('StaName_').AsString := pValue;
end;

function TStalstBtr.ReadStaTel:Str6;
begin
  Result := oBtrTable.FieldByName('StaTel').AsString;
end;

procedure TStalstBtr.WriteStaTel(pValue:Str6);
begin
  oBtrTable.FieldByName('StaTel').AsString := pValue;
end;

function TStalstBtr.ReadDvzName:Str3;
begin
  Result := oBtrTable.FieldByName('DvzName').AsString;
end;

procedure TStalstBtr.WriteDvzName(pValue:Str3);
begin
  oBtrTable.FieldByName('DvzName').AsString := pValue;
end;

function TStalstBtr.ReadCryName:Str30;
begin
  Result := oBtrTable.FieldByName('CryName').AsString;
end;

procedure TStalstBtr.WriteCryName(pValue:Str30);
begin
  oBtrTable.FieldByName('CryName').AsString := pValue;
end;

function TStalstBtr.ReadCrtUser:Str8;
begin
  Result := oBtrTable.FieldByName('CrtUser').AsString;
end;

procedure TStalstBtr.WriteCrtUser(pValue:Str8);
begin
  oBtrTable.FieldByName('CrtUser').AsString := pValue;
end;

function TStalstBtr.ReadCrtDate:TDatetime;
begin
  Result := oBtrTable.FieldByName('CrtDate').AsDateTime;
end;

procedure TStalstBtr.WriteCrtDate(pValue:TDatetime);
begin
  oBtrTable.FieldByName('CrtDate').AsDateTime := pValue;
end;

function TStalstBtr.ReadCrtTime:TDatetime;
begin
  Result := oBtrTable.FieldByName('CrtTime').AsDateTime;
end;

procedure TStalstBtr.WriteCrtTime(pValue:TDatetime);
begin
  oBtrTable.FieldByName('CrtTime').AsDateTime := pValue;
end;

function TStalstBtr.ReadModNum:word;
begin
  Result := oBtrTable.FieldByName('ModNum').AsInteger;
end;

procedure TStalstBtr.WriteModNum(pValue:word);
begin
  oBtrTable.FieldByName('ModNum').AsInteger := pValue;
end;

function TStalstBtr.ReadModUser:Str8;
begin
  Result := oBtrTable.FieldByName('ModUser').AsString;
end;

procedure TStalstBtr.WriteModUser(pValue:Str8);
begin
  oBtrTable.FieldByName('ModUser').AsString := pValue;
end;

function TStalstBtr.ReadModDate:TDatetime;
begin
  Result := oBtrTable.FieldByName('ModDate').AsDateTime;
end;

procedure TStalstBtr.WriteModDate(pValue:TDatetime);
begin
  oBtrTable.FieldByName('ModDate').AsDateTime := pValue;
end;

function TStalstBtr.ReadModTime:TDatetime;
begin
  Result := oBtrTable.FieldByName('ModTime').AsDateTime;
end;

procedure TStalstBtr.WriteModTime(pValue:TDatetime);
begin
  oBtrTable.FieldByName('ModTime').AsDateTime := pValue;
end;

// **************************************** PUBLIC ********************************************

function TStalstBtr.Eof: boolean;
begin
  Result := oBtrTable.Eof;
end;

function TStalstBtr.Active: boolean;
begin
  Result := oBtrTable.Active;
end;

function TStalstBtr.ActPos: longint;
begin
  Result := oBtrTable.ActPos;
end;

function TStalstBtr.GotoPos (pActPos:longint): boolean;
begin
  Result := oBtrTable.GotoPos(pActPos);
end;

function TStalstBtr.LocateStaCode (pStaCode:Str2):boolean;
begin
  SetIndex (ixStaCode);
  Result := oBtrTable.FindKey([pStaCode]);
end;

function TStalstBtr.LocateStaName (pStaName_:Str30):boolean;
begin
  SetIndex (ixStaName);
  Result := oBtrTable.FindKey([pStaName_]);
end;

function TStalstBtr.LocateStaTel (pStaTel:Str6):boolean;
begin
  SetIndex (ixStaTel);
  Result := oBtrTable.FindKey([pStaTel]);
end;

function TStalstBtr.LocateDvzName (pDvzName:Str3):boolean;
begin
  SetIndex (ixDvzName);
  Result := oBtrTable.FindKey([pDvzName]);
end;

procedure TStalstBtr.SetIndex (pIndexName:ShortString);
begin
  If oBtrTable.IndexName<>pIndexName then oBtrTable.IndexName := pIndexName;
end;

procedure TStalstBtr.Open;
begin
  oBtrTable.Open;
end;

procedure TStalstBtr.Close;
begin
  If oBtrTable.Active then oBtrTable.Close;
end;

procedure TStalstBtr.Prior;
begin
  oBtrTable.Prior;
end;

procedure TStalstBtr.Next;
begin
  oBtrTable.Next;
end;

procedure TStalstBtr.First;
begin
  oBtrTable.First;
end;

procedure TStalstBtr.Last;
begin
  oBtrTable.Last;
end;

procedure TStalstBtr.Insert;
begin
  oBtrTable.Insert;
end;

procedure TStalstBtr.Edit;
begin
  oBtrTable.Edit;
end;

procedure TStalstBtr.Post;
begin
  oBtrTable.Post;
end;

procedure TStalstBtr.Delete;
begin
  oBtrTable.Delete;
end;

procedure TStalstBtr.SwapIndex;
begin
  oBtrTable.SwapIndex;
end;

procedure TStalstBtr.RestoreIndex;
begin
  oBtrTable.RestoreIndex;
end;

procedure TStalstBtr.SwapStatus;
begin
  oBtrTable.SwapStatus;
end;

procedure TStalstBtr.RestoreStatus;
begin
  oBtrTable.RestoreStatus;
end;

procedure TStalstBtr.EnableControls;
begin
  oBtrTable.EnableControls;
end;

procedure TStalstBtr.DisableControls;
begin
  oBtrTable.DisableControls;
end;

end.
