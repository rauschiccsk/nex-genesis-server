unit bRCHC;

interface

uses
  IcTypes, IcConv, NexPath, NexGlob,
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls,
  Dialogs, DB, NexBtrTable, DBTables, NexPxTable;

const
  ixFgDvzName = 'FgDvzName';

type
  TRchcBtr = class (TComponent)
    constructor Create; overload;
    destructor  Destroy; override;
  private
    oBtrTable: TNexBtrTable;
    function ReadCount:integer;
    function FieldExist (pFieldName:ShortString): boolean;
    // Pristup k databazovym poliam
    function  ReadFgDvzName:Str3;        procedure WriteFgDvzName (pValue:Str3);
    function  ReadFgEndVal:double;       procedure WriteFgEndVal (pValue:double);
    function  ReadAcEndVal:double;       procedure WriteAcEndVal (pValue:double);
    function  ReadEyCourse:double;       procedure WriteEyCourse (pValue:double);
    function  ReadEyEndVal:double;       procedure WriteEyEndVal (pValue:double);
    function  ReadEyCrdVal:double;       procedure WriteEyCrdVal (pValue:double);
    function  ReadIdDocNum:Str12;        procedure WriteIdDocNum (pValue:Str12);
    function  ReadDocQnt:longint;        procedure WriteDocQnt (pValue:longint);
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
    function LocateFgDvzName (pFgDvzName:Str3):boolean;
    function NearestFgDvzName (pFgDvzName:Str3):boolean;

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
    property FgDvzName:Str3 read ReadFgDvzName write WriteFgDvzName;
    property FgEndVal:double read ReadFgEndVal write WriteFgEndVal;
    property AcEndVal:double read ReadAcEndVal write WriteAcEndVal;
    property EyCourse:double read ReadEyCourse write WriteEyCourse;
    property EyEndVal:double read ReadEyEndVal write WriteEyEndVal;
    property EyCrdVal:double read ReadEyCrdVal write WriteEyCrdVal;
    property IdDocNum:Str12 read ReadIdDocNum write WriteIdDocNum;
    property DocQnt:longint read ReadDocQnt write WriteDocQnt;
    property CrtUser:Str8 read ReadCrtUser write WriteCrtUser;
    property CrtDate:TDatetime read ReadCrtDate write WriteCrtDate;
    property CrtTime:TDatetime read ReadCrtTime write WriteCrtTime;
    property ModUser:Str8 read ReadModUser write WriteModUser;
    property ModDate:TDatetime read ReadModDate write WriteModDate;
    property ModTime:TDatetime read ReadModTime write WriteModTime;
  end;

implementation

constructor TRchcBtr.Create;
begin
  oBtrTable := BtrInit ('RCHC',gPath.LdgPath,Self);
end;

constructor TRchcBtr.Create(pPath:ShortString);
begin
  oBtrTable := BtrInit ('RCHC',pPath,Self);
end;

destructor TRchcBtr.Destroy;
begin
  oBtrTable.Close;  FreeAndNil (oBtrTable);
end;

// *************************************** PRIVATE ********************************************

function TRchcBtr.ReadCount:integer;
begin
  Result := oBtrTable.RecordCount;
end;

function TRchcBtr.FieldExist (pFieldName:ShortString): boolean;
begin
  Result := oBtrTable.FindField(pFieldName)<>nil;
end;

function TRchcBtr.ReadFgDvzName:Str3;
begin
  Result := oBtrTable.FieldByName('FgDvzName').AsString;
end;

procedure TRchcBtr.WriteFgDvzName(pValue:Str3);
begin
  oBtrTable.FieldByName('FgDvzName').AsString := pValue;
end;

function TRchcBtr.ReadFgEndVal:double;
begin
  Result := oBtrTable.FieldByName('FgEndVal').AsFloat;
end;

procedure TRchcBtr.WriteFgEndVal(pValue:double);
begin
  oBtrTable.FieldByName('FgEndVal').AsFloat := pValue;
end;

function TRchcBtr.ReadAcEndVal:double;
begin
  Result := oBtrTable.FieldByName('AcEndVal').AsFloat;
end;

procedure TRchcBtr.WriteAcEndVal(pValue:double);
begin
  oBtrTable.FieldByName('AcEndVal').AsFloat := pValue;
end;

function TRchcBtr.ReadEyCourse:double;
begin
  Result := oBtrTable.FieldByName('EyCourse').AsFloat;
end;

procedure TRchcBtr.WriteEyCourse(pValue:double);
begin
  oBtrTable.FieldByName('EyCourse').AsFloat := pValue;
end;

function TRchcBtr.ReadEyEndVal:double;
begin
  Result := oBtrTable.FieldByName('EyEndVal').AsFloat;
end;

procedure TRchcBtr.WriteEyEndVal(pValue:double);
begin
  oBtrTable.FieldByName('EyEndVal').AsFloat := pValue;
end;

function TRchcBtr.ReadEyCrdVal:double;
begin
  Result := oBtrTable.FieldByName('EyCrdVal').AsFloat;
end;

procedure TRchcBtr.WriteEyCrdVal(pValue:double);
begin
  oBtrTable.FieldByName('EyCrdVal').AsFloat := pValue;
end;

function TRchcBtr.ReadIdDocNum:Str12;
begin
  Result := oBtrTable.FieldByName('IdDocNum').AsString;
end;

procedure TRchcBtr.WriteIdDocNum(pValue:Str12);
begin
  oBtrTable.FieldByName('IdDocNum').AsString := pValue;
end;

function TRchcBtr.ReadDocQnt:longint;
begin
  Result := oBtrTable.FieldByName('DocQnt').AsInteger;
end;

procedure TRchcBtr.WriteDocQnt(pValue:longint);
begin
  oBtrTable.FieldByName('DocQnt').AsInteger := pValue;
end;

function TRchcBtr.ReadCrtUser:Str8;
begin
  Result := oBtrTable.FieldByName('CrtUser').AsString;
end;

procedure TRchcBtr.WriteCrtUser(pValue:Str8);
begin
  oBtrTable.FieldByName('CrtUser').AsString := pValue;
end;

function TRchcBtr.ReadCrtDate:TDatetime;
begin
  Result := oBtrTable.FieldByName('CrtDate').AsDateTime;
end;

procedure TRchcBtr.WriteCrtDate(pValue:TDatetime);
begin
  oBtrTable.FieldByName('CrtDate').AsDateTime := pValue;
end;

function TRchcBtr.ReadCrtTime:TDatetime;
begin
  Result := oBtrTable.FieldByName('CrtTime').AsDateTime;
end;

procedure TRchcBtr.WriteCrtTime(pValue:TDatetime);
begin
  oBtrTable.FieldByName('CrtTime').AsDateTime := pValue;
end;

function TRchcBtr.ReadModUser:Str8;
begin
  Result := oBtrTable.FieldByName('ModUser').AsString;
end;

procedure TRchcBtr.WriteModUser(pValue:Str8);
begin
  oBtrTable.FieldByName('ModUser').AsString := pValue;
end;

function TRchcBtr.ReadModDate:TDatetime;
begin
  Result := oBtrTable.FieldByName('ModDate').AsDateTime;
end;

procedure TRchcBtr.WriteModDate(pValue:TDatetime);
begin
  oBtrTable.FieldByName('ModDate').AsDateTime := pValue;
end;

function TRchcBtr.ReadModTime:TDatetime;
begin
  Result := oBtrTable.FieldByName('ModTime').AsDateTime;
end;

procedure TRchcBtr.WriteModTime(pValue:TDatetime);
begin
  oBtrTable.FieldByName('ModTime').AsDateTime := pValue;
end;

// **************************************** PUBLIC ********************************************

function TRchcBtr.Eof: boolean;
begin
  Result := oBtrTable.Eof;
end;

function TRchcBtr.IsFirstRec: boolean;
begin
  Result := oBtrTable.Bof;
end;

function TRchcBtr.IsLastRec: boolean;
begin
  Result := oBtrTable.Eof;
end;

function TRchcBtr.Active: boolean;
begin
  Result := oBtrTable.Active;
end;

function TRchcBtr.ActPos: longint;
begin
  Result := oBtrTable.ActPos;
end;

function TRchcBtr.GotoPos (pActPos:longint): boolean;
begin
  Result := oBtrTable.GotoPos(pActPos);
end;

function TRchcBtr.LocateFgDvzName (pFgDvzName:Str3):boolean;
begin
  SetIndex (ixFgDvzName);
  Result := oBtrTable.FindKey([pFgDvzName]);
end;

function TRchcBtr.NearestFgDvzName (pFgDvzName:Str3):boolean;
begin
  SetIndex (ixFgDvzName);
  Result := oBtrTable.FindNearest([pFgDvzName]);
end;

procedure TRchcBtr.SetIndex (pIndexName:ShortString);
begin
  If oBtrTable.IndexName<>pIndexName then oBtrTable.IndexName := pIndexName;
end;

procedure TRchcBtr.Open;
begin
  oBtrTable.Open;
end;

procedure TRchcBtr.Close;
begin
  If oBtrTable.Active then oBtrTable.Close;
end;

procedure TRchcBtr.Prior;
begin
  oBtrTable.Prior;
end;

procedure TRchcBtr.Next;
begin
  oBtrTable.Next;
end;

procedure TRchcBtr.First;
begin
  oBtrTable.First;
end;

procedure TRchcBtr.Last;
begin
  oBtrTable.Last;
end;

procedure TRchcBtr.Insert;
begin
  oBtrTable.Insert;
end;

procedure TRchcBtr.Edit;
begin
  oBtrTable.Edit;
end;

procedure TRchcBtr.Post;
begin
  oBtrTable.Post;
end;

procedure TRchcBtr.Delete;
begin
  oBtrTable.Delete;
end;

procedure TRchcBtr.SwapIndex;
begin
  oBtrTable.SwapIndex;
end;

procedure TRchcBtr.RestoreIndex;
begin
  oBtrTable.RestoreIndex;
end;

procedure TRchcBtr.SwapStatus;
begin
  oBtrTable.SwapStatus;
end;

procedure TRchcBtr.RestoreStatus;
begin
  oBtrTable.RestoreStatus;
end;

procedure TRchcBtr.EnableControls;
begin
  oBtrTable.EnableControls;
end;

procedure TRchcBtr.DisableControls;
begin
  oBtrTable.DisableControls;
end;

end.
