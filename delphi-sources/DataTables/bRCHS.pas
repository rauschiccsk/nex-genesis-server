unit bRCHS;

interface

uses
  IcTypes, IcConv, NexPath, NexGlob,
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls,
  Dialogs, DB, NexBtrTable, DBTables, NexPxTable;

const
  ixFgDvzName = 'FgDvzName';

type
  TRchsBtr = class (TComponent)
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

constructor TRchsBtr.Create;
begin
  oBtrTable := BtrInit ('RCHS',gPath.LdgPath,Self);
end;

constructor TRchsBtr.Create(pPath:ShortString);
begin
  oBtrTable := BtrInit ('RCHS',pPath,Self);
end;

destructor TRchsBtr.Destroy;
begin
  oBtrTable.Close;  FreeAndNil (oBtrTable);
end;

// *************************************** PRIVATE ********************************************

function TRchsBtr.ReadCount:integer;
begin
  Result := oBtrTable.RecordCount;
end;

function TRchsBtr.FieldExist (pFieldName:ShortString): boolean;
begin
  Result := oBtrTable.FindField(pFieldName)<>nil;
end;

function TRchsBtr.ReadFgDvzName:Str3;
begin
  Result := oBtrTable.FieldByName('FgDvzName').AsString;
end;

procedure TRchsBtr.WriteFgDvzName(pValue:Str3);
begin
  oBtrTable.FieldByName('FgDvzName').AsString := pValue;
end;

function TRchsBtr.ReadFgEndVal:double;
begin
  Result := oBtrTable.FieldByName('FgEndVal').AsFloat;
end;

procedure TRchsBtr.WriteFgEndVal(pValue:double);
begin
  oBtrTable.FieldByName('FgEndVal').AsFloat := pValue;
end;

function TRchsBtr.ReadAcEndVal:double;
begin
  Result := oBtrTable.FieldByName('AcEndVal').AsFloat;
end;

procedure TRchsBtr.WriteAcEndVal(pValue:double);
begin
  oBtrTable.FieldByName('AcEndVal').AsFloat := pValue;
end;

function TRchsBtr.ReadEyCourse:double;
begin
  Result := oBtrTable.FieldByName('EyCourse').AsFloat;
end;

procedure TRchsBtr.WriteEyCourse(pValue:double);
begin
  oBtrTable.FieldByName('EyCourse').AsFloat := pValue;
end;

function TRchsBtr.ReadEyEndVal:double;
begin
  Result := oBtrTable.FieldByName('EyEndVal').AsFloat;
end;

procedure TRchsBtr.WriteEyEndVal(pValue:double);
begin
  oBtrTable.FieldByName('EyEndVal').AsFloat := pValue;
end;

function TRchsBtr.ReadEyCrdVal:double;
begin
  Result := oBtrTable.FieldByName('EyCrdVal').AsFloat;
end;

procedure TRchsBtr.WriteEyCrdVal(pValue:double);
begin
  oBtrTable.FieldByName('EyCrdVal').AsFloat := pValue;
end;

function TRchsBtr.ReadIdDocNum:Str12;
begin
  Result := oBtrTable.FieldByName('IdDocNum').AsString;
end;

procedure TRchsBtr.WriteIdDocNum(pValue:Str12);
begin
  oBtrTable.FieldByName('IdDocNum').AsString := pValue;
end;

function TRchsBtr.ReadDocQnt:longint;
begin
  Result := oBtrTable.FieldByName('DocQnt').AsInteger;
end;

procedure TRchsBtr.WriteDocQnt(pValue:longint);
begin
  oBtrTable.FieldByName('DocQnt').AsInteger := pValue;
end;

function TRchsBtr.ReadCrtUser:Str8;
begin
  Result := oBtrTable.FieldByName('CrtUser').AsString;
end;

procedure TRchsBtr.WriteCrtUser(pValue:Str8);
begin
  oBtrTable.FieldByName('CrtUser').AsString := pValue;
end;

function TRchsBtr.ReadCrtDate:TDatetime;
begin
  Result := oBtrTable.FieldByName('CrtDate').AsDateTime;
end;

procedure TRchsBtr.WriteCrtDate(pValue:TDatetime);
begin
  oBtrTable.FieldByName('CrtDate').AsDateTime := pValue;
end;

function TRchsBtr.ReadCrtTime:TDatetime;
begin
  Result := oBtrTable.FieldByName('CrtTime').AsDateTime;
end;

procedure TRchsBtr.WriteCrtTime(pValue:TDatetime);
begin
  oBtrTable.FieldByName('CrtTime').AsDateTime := pValue;
end;

function TRchsBtr.ReadModUser:Str8;
begin
  Result := oBtrTable.FieldByName('ModUser').AsString;
end;

procedure TRchsBtr.WriteModUser(pValue:Str8);
begin
  oBtrTable.FieldByName('ModUser').AsString := pValue;
end;

function TRchsBtr.ReadModDate:TDatetime;
begin
  Result := oBtrTable.FieldByName('ModDate').AsDateTime;
end;

procedure TRchsBtr.WriteModDate(pValue:TDatetime);
begin
  oBtrTable.FieldByName('ModDate').AsDateTime := pValue;
end;

function TRchsBtr.ReadModTime:TDatetime;
begin
  Result := oBtrTable.FieldByName('ModTime').AsDateTime;
end;

procedure TRchsBtr.WriteModTime(pValue:TDatetime);
begin
  oBtrTable.FieldByName('ModTime').AsDateTime := pValue;
end;

// **************************************** PUBLIC ********************************************

function TRchsBtr.Eof: boolean;
begin
  Result := oBtrTable.Eof;
end;

function TRchsBtr.IsFirstRec: boolean;
begin
  Result := oBtrTable.Bof;
end;

function TRchsBtr.IsLastRec: boolean;
begin
  Result := oBtrTable.Eof;
end;

function TRchsBtr.Active: boolean;
begin
  Result := oBtrTable.Active;
end;

function TRchsBtr.ActPos: longint;
begin
  Result := oBtrTable.ActPos;
end;

function TRchsBtr.GotoPos (pActPos:longint): boolean;
begin
  Result := oBtrTable.GotoPos(pActPos);
end;

function TRchsBtr.LocateFgDvzName (pFgDvzName:Str3):boolean;
begin
  SetIndex (ixFgDvzName);
  Result := oBtrTable.FindKey([pFgDvzName]);
end;

function TRchsBtr.NearestFgDvzName (pFgDvzName:Str3):boolean;
begin
  SetIndex (ixFgDvzName);
  Result := oBtrTable.FindNearest([pFgDvzName]);
end;

procedure TRchsBtr.SetIndex (pIndexName:ShortString);
begin
  If oBtrTable.IndexName<>pIndexName then oBtrTable.IndexName := pIndexName;
end;

procedure TRchsBtr.Open;
begin
  oBtrTable.Open;
end;

procedure TRchsBtr.Close;
begin
  If oBtrTable.Active then oBtrTable.Close;
end;

procedure TRchsBtr.Prior;
begin
  oBtrTable.Prior;
end;

procedure TRchsBtr.Next;
begin
  oBtrTable.Next;
end;

procedure TRchsBtr.First;
begin
  oBtrTable.First;
end;

procedure TRchsBtr.Last;
begin
  oBtrTable.Last;
end;

procedure TRchsBtr.Insert;
begin
  oBtrTable.Insert;
end;

procedure TRchsBtr.Edit;
begin
  oBtrTable.Edit;
end;

procedure TRchsBtr.Post;
begin
  oBtrTable.Post;
end;

procedure TRchsBtr.Delete;
begin
  oBtrTable.Delete;
end;

procedure TRchsBtr.SwapIndex;
begin
  oBtrTable.SwapIndex;
end;

procedure TRchsBtr.RestoreIndex;
begin
  oBtrTable.RestoreIndex;
end;

procedure TRchsBtr.SwapStatus;
begin
  oBtrTable.SwapStatus;
end;

procedure TRchsBtr.RestoreStatus;
begin
  oBtrTable.RestoreStatus;
end;

procedure TRchsBtr.EnableControls;
begin
  oBtrTable.EnableControls;
end;

procedure TRchsBtr.DisableControls;
begin
  oBtrTable.DisableControls;
end;

end.
