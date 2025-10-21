unit bRCIS;

interface

uses
  IcTypes, IcConv, NexPath, NexGlob,
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls,
  Dialogs, DB, NexBtrTable, DBTables, NexPxTable;

const
  ixFgDvzName = 'FgDvzName';
  ixDocNum = 'DocNum';
  ixExtNum = 'ExtNum';

type
  TRcisBtr = class (TComponent)
    constructor Create; overload;
    destructor  Destroy; override;
  private
    oBtrTable: TNexBtrTable;
    function ReadCount:integer;
    function FieldExist (pFieldName:ShortString): boolean;
    // Pristup k databazovym poliam
    function  ReadFgDvzName:Str3;        procedure WriteFgDvzName (pValue:Str3);
    function  ReadDocNum:Str12;          procedure WriteDocNum (pValue:Str12);
    function  ReadExtNum:Str12;          procedure WriteExtNum (pValue:Str12);
    function  ReadPaCode:longint;        procedure WritePaCode (pValue:longint);
    function  ReadPaName:Str30;          procedure WritePaName (pValue:Str30);
    function  ReadRegName:Str60;         procedure WriteRegName (pValue:Str60);
    function  ReadRegIno:Str10;          procedure WriteRegIno (pValue:Str10);
    function  ReadRegTin:Str14;          procedure WriteRegTin (pValue:Str14);
    function  ReadFgEndVal:double;       procedure WriteFgEndVal (pValue:double);
    function  ReadFgCourse:double;       procedure WriteFgCourse (pValue:double);
    function  ReadAcEndVal:double;       procedure WriteAcEndVal (pValue:double);
    function  ReadEyCourse:double;       procedure WriteEyCourse (pValue:double);
    function  ReadEyEndVal:double;       procedure WriteEyEndVal (pValue:double);
    function  ReadEyCrdVal:double;       procedure WriteEyCrdVal (pValue:double);
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
    function LocateDocNum (pDocNum:Str12):boolean;
    function LocateExtNum (pExtNum:Str12):boolean;
    function NearestFgDvzName (pFgDvzName:Str3):boolean;
    function NearestDocNum (pDocNum:Str12):boolean;
    function NearestExtNum (pExtNum:Str12):boolean;

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
    property DocNum:Str12 read ReadDocNum write WriteDocNum;
    property ExtNum:Str12 read ReadExtNum write WriteExtNum;
    property PaCode:longint read ReadPaCode write WritePaCode;
    property PaName:Str30 read ReadPaName write WritePaName;
    property RegName:Str60 read ReadRegName write WriteRegName;
    property RegIno:Str10 read ReadRegIno write WriteRegIno;
    property RegTin:Str14 read ReadRegTin write WriteRegTin;
    property FgEndVal:double read ReadFgEndVal write WriteFgEndVal;
    property FgCourse:double read ReadFgCourse write WriteFgCourse;
    property AcEndVal:double read ReadAcEndVal write WriteAcEndVal;
    property EyCourse:double read ReadEyCourse write WriteEyCourse;
    property EyEndVal:double read ReadEyEndVal write WriteEyEndVal;
    property EyCrdVal:double read ReadEyCrdVal write WriteEyCrdVal;
    property CrtUser:Str8 read ReadCrtUser write WriteCrtUser;
    property CrtDate:TDatetime read ReadCrtDate write WriteCrtDate;
    property CrtTime:TDatetime read ReadCrtTime write WriteCrtTime;
    property ModUser:Str8 read ReadModUser write WriteModUser;
    property ModDate:TDatetime read ReadModDate write WriteModDate;
    property ModTime:TDatetime read ReadModTime write WriteModTime;
  end;

implementation

constructor TRcisBtr.Create;
begin
  oBtrTable := BtrInit ('RCIS',gPath.LdgPath,Self);
end;

constructor TRcisBtr.Create(pPath:ShortString);
begin
  oBtrTable := BtrInit ('RCIS',pPath,Self);
end;

destructor TRcisBtr.Destroy;
begin
  oBtrTable.Close;  FreeAndNil (oBtrTable);
end;

// *************************************** PRIVATE ********************************************

function TRcisBtr.ReadCount:integer;
begin
  Result := oBtrTable.RecordCount;
end;

function TRcisBtr.FieldExist (pFieldName:ShortString): boolean;
begin
  Result := oBtrTable.FindField(pFieldName)<>nil;
end;

function TRcisBtr.ReadFgDvzName:Str3;
begin
  Result := oBtrTable.FieldByName('FgDvzName').AsString;
end;

procedure TRcisBtr.WriteFgDvzName(pValue:Str3);
begin
  oBtrTable.FieldByName('FgDvzName').AsString := pValue;
end;

function TRcisBtr.ReadDocNum:Str12;
begin
  Result := oBtrTable.FieldByName('DocNum').AsString;
end;

procedure TRcisBtr.WriteDocNum(pValue:Str12);
begin
  oBtrTable.FieldByName('DocNum').AsString := pValue;
end;

function TRcisBtr.ReadExtNum:Str12;
begin
  Result := oBtrTable.FieldByName('ExtNum').AsString;
end;

procedure TRcisBtr.WriteExtNum(pValue:Str12);
begin
  oBtrTable.FieldByName('ExtNum').AsString := pValue;
end;

function TRcisBtr.ReadPaCode:longint;
begin
  Result := oBtrTable.FieldByName('PaCode').AsInteger;
end;

procedure TRcisBtr.WritePaCode(pValue:longint);
begin
  oBtrTable.FieldByName('PaCode').AsInteger := pValue;
end;

function TRcisBtr.ReadPaName:Str30;
begin
  Result := oBtrTable.FieldByName('PaName').AsString;
end;

procedure TRcisBtr.WritePaName(pValue:Str30);
begin
  oBtrTable.FieldByName('PaName').AsString := pValue;
end;

function TRcisBtr.ReadRegName:Str60;
begin
  Result := oBtrTable.FieldByName('RegName').AsString;
end;

procedure TRcisBtr.WriteRegName(pValue:Str60);
begin
  oBtrTable.FieldByName('RegName').AsString := pValue;
end;

function TRcisBtr.ReadRegIno:Str10;
begin
  Result := oBtrTable.FieldByName('RegIno').AsString;
end;

procedure TRcisBtr.WriteRegIno(pValue:Str10);
begin
  oBtrTable.FieldByName('RegIno').AsString := pValue;
end;

function TRcisBtr.ReadRegTin:Str14;
begin
  Result := oBtrTable.FieldByName('RegTin').AsString;
end;

procedure TRcisBtr.WriteRegTin(pValue:Str14);
begin
  oBtrTable.FieldByName('RegTin').AsString := pValue;
end;

function TRcisBtr.ReadFgEndVal:double;
begin
  Result := oBtrTable.FieldByName('FgEndVal').AsFloat;
end;

procedure TRcisBtr.WriteFgEndVal(pValue:double);
begin
  oBtrTable.FieldByName('FgEndVal').AsFloat := pValue;
end;

function TRcisBtr.ReadFgCourse:double;
begin
  Result := oBtrTable.FieldByName('FgCourse').AsFloat;
end;

procedure TRcisBtr.WriteFgCourse(pValue:double);
begin
  oBtrTable.FieldByName('FgCourse').AsFloat := pValue;
end;

function TRcisBtr.ReadAcEndVal:double;
begin
  Result := oBtrTable.FieldByName('AcEndVal').AsFloat;
end;

procedure TRcisBtr.WriteAcEndVal(pValue:double);
begin
  oBtrTable.FieldByName('AcEndVal').AsFloat := pValue;
end;

function TRcisBtr.ReadEyCourse:double;
begin
  Result := oBtrTable.FieldByName('EyCourse').AsFloat;
end;

procedure TRcisBtr.WriteEyCourse(pValue:double);
begin
  oBtrTable.FieldByName('EyCourse').AsFloat := pValue;
end;

function TRcisBtr.ReadEyEndVal:double;
begin
  Result := oBtrTable.FieldByName('EyEndVal').AsFloat;
end;

procedure TRcisBtr.WriteEyEndVal(pValue:double);
begin
  oBtrTable.FieldByName('EyEndVal').AsFloat := pValue;
end;

function TRcisBtr.ReadEyCrdVal:double;
begin
  Result := oBtrTable.FieldByName('EyCrdVal').AsFloat;
end;

procedure TRcisBtr.WriteEyCrdVal(pValue:double);
begin
  oBtrTable.FieldByName('EyCrdVal').AsFloat := pValue;
end;

function TRcisBtr.ReadCrtUser:Str8;
begin
  Result := oBtrTable.FieldByName('CrtUser').AsString;
end;

procedure TRcisBtr.WriteCrtUser(pValue:Str8);
begin
  oBtrTable.FieldByName('CrtUser').AsString := pValue;
end;

function TRcisBtr.ReadCrtDate:TDatetime;
begin
  Result := oBtrTable.FieldByName('CrtDate').AsDateTime;
end;

procedure TRcisBtr.WriteCrtDate(pValue:TDatetime);
begin
  oBtrTable.FieldByName('CrtDate').AsDateTime := pValue;
end;

function TRcisBtr.ReadCrtTime:TDatetime;
begin
  Result := oBtrTable.FieldByName('CrtTime').AsDateTime;
end;

procedure TRcisBtr.WriteCrtTime(pValue:TDatetime);
begin
  oBtrTable.FieldByName('CrtTime').AsDateTime := pValue;
end;

function TRcisBtr.ReadModUser:Str8;
begin
  Result := oBtrTable.FieldByName('ModUser').AsString;
end;

procedure TRcisBtr.WriteModUser(pValue:Str8);
begin
  oBtrTable.FieldByName('ModUser').AsString := pValue;
end;

function TRcisBtr.ReadModDate:TDatetime;
begin
  Result := oBtrTable.FieldByName('ModDate').AsDateTime;
end;

procedure TRcisBtr.WriteModDate(pValue:TDatetime);
begin
  oBtrTable.FieldByName('ModDate').AsDateTime := pValue;
end;

function TRcisBtr.ReadModTime:TDatetime;
begin
  Result := oBtrTable.FieldByName('ModTime').AsDateTime;
end;

procedure TRcisBtr.WriteModTime(pValue:TDatetime);
begin
  oBtrTable.FieldByName('ModTime').AsDateTime := pValue;
end;

// **************************************** PUBLIC ********************************************

function TRcisBtr.Eof: boolean;
begin
  Result := oBtrTable.Eof;
end;

function TRcisBtr.IsFirstRec: boolean;
begin
  Result := oBtrTable.Bof;
end;

function TRcisBtr.IsLastRec: boolean;
begin
  Result := oBtrTable.Eof;
end;

function TRcisBtr.Active: boolean;
begin
  Result := oBtrTable.Active;
end;

function TRcisBtr.ActPos: longint;
begin
  Result := oBtrTable.ActPos;
end;

function TRcisBtr.GotoPos (pActPos:longint): boolean;
begin
  Result := oBtrTable.GotoPos(pActPos);
end;

function TRcisBtr.LocateFgDvzName (pFgDvzName:Str3):boolean;
begin
  SetIndex (ixFgDvzName);
  Result := oBtrTable.FindKey([pFgDvzName]);
end;

function TRcisBtr.LocateDocNum (pDocNum:Str12):boolean;
begin
  SetIndex (ixDocNum);
  Result := oBtrTable.FindKey([pDocNum]);
end;

function TRcisBtr.LocateExtNum (pExtNum:Str12):boolean;
begin
  SetIndex (ixExtNum);
  Result := oBtrTable.FindKey([pExtNum]);
end;

function TRcisBtr.NearestFgDvzName (pFgDvzName:Str3):boolean;
begin
  SetIndex (ixFgDvzName);
  Result := oBtrTable.FindNearest([pFgDvzName]);
end;

function TRcisBtr.NearestDocNum (pDocNum:Str12):boolean;
begin
  SetIndex (ixDocNum);
  Result := oBtrTable.FindNearest([pDocNum]);
end;

function TRcisBtr.NearestExtNum (pExtNum:Str12):boolean;
begin
  SetIndex (ixExtNum);
  Result := oBtrTable.FindNearest([pExtNum]);
end;

procedure TRcisBtr.SetIndex (pIndexName:ShortString);
begin
  If oBtrTable.IndexName<>pIndexName then oBtrTable.IndexName := pIndexName;
end;

procedure TRcisBtr.Open;
begin
  oBtrTable.Open;
end;

procedure TRcisBtr.Close;
begin
  If oBtrTable.Active then oBtrTable.Close;
end;

procedure TRcisBtr.Prior;
begin
  oBtrTable.Prior;
end;

procedure TRcisBtr.Next;
begin
  oBtrTable.Next;
end;

procedure TRcisBtr.First;
begin
  oBtrTable.First;
end;

procedure TRcisBtr.Last;
begin
  oBtrTable.Last;
end;

procedure TRcisBtr.Insert;
begin
  oBtrTable.Insert;
end;

procedure TRcisBtr.Edit;
begin
  oBtrTable.Edit;
end;

procedure TRcisBtr.Post;
begin
  oBtrTable.Post;
end;

procedure TRcisBtr.Delete;
begin
  oBtrTable.Delete;
end;

procedure TRcisBtr.SwapIndex;
begin
  oBtrTable.SwapIndex;
end;

procedure TRcisBtr.RestoreIndex;
begin
  oBtrTable.RestoreIndex;
end;

procedure TRcisBtr.SwapStatus;
begin
  oBtrTable.SwapStatus;
end;

procedure TRcisBtr.RestoreStatus;
begin
  oBtrTable.RestoreStatus;
end;

procedure TRcisBtr.EnableControls;
begin
  oBtrTable.EnableControls;
end;

procedure TRcisBtr.DisableControls;
begin
  oBtrTable.DisableControls;
end;

end.
