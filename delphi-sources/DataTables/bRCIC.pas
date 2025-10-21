unit bRCIC;

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
  TRcicBtr = class (TComponent)
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

constructor TRcicBtr.Create;
begin
  oBtrTable := BtrInit ('RCIC',gPath.LdgPath,Self);
end;

constructor TRcicBtr.Create(pPath:ShortString);
begin
  oBtrTable := BtrInit ('RCIC',pPath,Self);
end;

destructor TRcicBtr.Destroy;
begin
  oBtrTable.Close;  FreeAndNil (oBtrTable);
end;

// *************************************** PRIVATE ********************************************

function TRcicBtr.ReadCount:integer;
begin
  Result := oBtrTable.RecordCount;
end;

function TRcicBtr.FieldExist (pFieldName:ShortString): boolean;
begin
  Result := oBtrTable.FindField(pFieldName)<>nil;
end;

function TRcicBtr.ReadFgDvzName:Str3;
begin
  Result := oBtrTable.FieldByName('FgDvzName').AsString;
end;

procedure TRcicBtr.WriteFgDvzName(pValue:Str3);
begin
  oBtrTable.FieldByName('FgDvzName').AsString := pValue;
end;

function TRcicBtr.ReadDocNum:Str12;
begin
  Result := oBtrTable.FieldByName('DocNum').AsString;
end;

procedure TRcicBtr.WriteDocNum(pValue:Str12);
begin
  oBtrTable.FieldByName('DocNum').AsString := pValue;
end;

function TRcicBtr.ReadExtNum:Str12;
begin
  Result := oBtrTable.FieldByName('ExtNum').AsString;
end;

procedure TRcicBtr.WriteExtNum(pValue:Str12);
begin
  oBtrTable.FieldByName('ExtNum').AsString := pValue;
end;

function TRcicBtr.ReadPaCode:longint;
begin
  Result := oBtrTable.FieldByName('PaCode').AsInteger;
end;

procedure TRcicBtr.WritePaCode(pValue:longint);
begin
  oBtrTable.FieldByName('PaCode').AsInteger := pValue;
end;

function TRcicBtr.ReadPaName:Str30;
begin
  Result := oBtrTable.FieldByName('PaName').AsString;
end;

procedure TRcicBtr.WritePaName(pValue:Str30);
begin
  oBtrTable.FieldByName('PaName').AsString := pValue;
end;

function TRcicBtr.ReadRegName:Str60;
begin
  Result := oBtrTable.FieldByName('RegName').AsString;
end;

procedure TRcicBtr.WriteRegName(pValue:Str60);
begin
  oBtrTable.FieldByName('RegName').AsString := pValue;
end;

function TRcicBtr.ReadRegIno:Str10;
begin
  Result := oBtrTable.FieldByName('RegIno').AsString;
end;

procedure TRcicBtr.WriteRegIno(pValue:Str10);
begin
  oBtrTable.FieldByName('RegIno').AsString := pValue;
end;

function TRcicBtr.ReadRegTin:Str14;
begin
  Result := oBtrTable.FieldByName('RegTin').AsString;
end;

procedure TRcicBtr.WriteRegTin(pValue:Str14);
begin
  oBtrTable.FieldByName('RegTin').AsString := pValue;
end;

function TRcicBtr.ReadFgEndVal:double;
begin
  Result := oBtrTable.FieldByName('FgEndVal').AsFloat;
end;

procedure TRcicBtr.WriteFgEndVal(pValue:double);
begin
  oBtrTable.FieldByName('FgEndVal').AsFloat := pValue;
end;

function TRcicBtr.ReadFgCourse:double;
begin
  Result := oBtrTable.FieldByName('FgCourse').AsFloat;
end;

procedure TRcicBtr.WriteFgCourse(pValue:double);
begin
  oBtrTable.FieldByName('FgCourse').AsFloat := pValue;
end;

function TRcicBtr.ReadAcEndVal:double;
begin
  Result := oBtrTable.FieldByName('AcEndVal').AsFloat;
end;

procedure TRcicBtr.WriteAcEndVal(pValue:double);
begin
  oBtrTable.FieldByName('AcEndVal').AsFloat := pValue;
end;

function TRcicBtr.ReadEyCourse:double;
begin
  Result := oBtrTable.FieldByName('EyCourse').AsFloat;
end;

procedure TRcicBtr.WriteEyCourse(pValue:double);
begin
  oBtrTable.FieldByName('EyCourse').AsFloat := pValue;
end;

function TRcicBtr.ReadEyEndVal:double;
begin
  Result := oBtrTable.FieldByName('EyEndVal').AsFloat;
end;

procedure TRcicBtr.WriteEyEndVal(pValue:double);
begin
  oBtrTable.FieldByName('EyEndVal').AsFloat := pValue;
end;

function TRcicBtr.ReadEyCrdVal:double;
begin
  Result := oBtrTable.FieldByName('EyCrdVal').AsFloat;
end;

procedure TRcicBtr.WriteEyCrdVal(pValue:double);
begin
  oBtrTable.FieldByName('EyCrdVal').AsFloat := pValue;
end;

function TRcicBtr.ReadCrtUser:Str8;
begin
  Result := oBtrTable.FieldByName('CrtUser').AsString;
end;

procedure TRcicBtr.WriteCrtUser(pValue:Str8);
begin
  oBtrTable.FieldByName('CrtUser').AsString := pValue;
end;

function TRcicBtr.ReadCrtDate:TDatetime;
begin
  Result := oBtrTable.FieldByName('CrtDate').AsDateTime;
end;

procedure TRcicBtr.WriteCrtDate(pValue:TDatetime);
begin
  oBtrTable.FieldByName('CrtDate').AsDateTime := pValue;
end;

function TRcicBtr.ReadCrtTime:TDatetime;
begin
  Result := oBtrTable.FieldByName('CrtTime').AsDateTime;
end;

procedure TRcicBtr.WriteCrtTime(pValue:TDatetime);
begin
  oBtrTable.FieldByName('CrtTime').AsDateTime := pValue;
end;

function TRcicBtr.ReadModUser:Str8;
begin
  Result := oBtrTable.FieldByName('ModUser').AsString;
end;

procedure TRcicBtr.WriteModUser(pValue:Str8);
begin
  oBtrTable.FieldByName('ModUser').AsString := pValue;
end;

function TRcicBtr.ReadModDate:TDatetime;
begin
  Result := oBtrTable.FieldByName('ModDate').AsDateTime;
end;

procedure TRcicBtr.WriteModDate(pValue:TDatetime);
begin
  oBtrTable.FieldByName('ModDate').AsDateTime := pValue;
end;

function TRcicBtr.ReadModTime:TDatetime;
begin
  Result := oBtrTable.FieldByName('ModTime').AsDateTime;
end;

procedure TRcicBtr.WriteModTime(pValue:TDatetime);
begin
  oBtrTable.FieldByName('ModTime').AsDateTime := pValue;
end;

// **************************************** PUBLIC ********************************************

function TRcicBtr.Eof: boolean;
begin
  Result := oBtrTable.Eof;
end;

function TRcicBtr.IsFirstRec: boolean;
begin
  Result := oBtrTable.Bof;
end;

function TRcicBtr.IsLastRec: boolean;
begin
  Result := oBtrTable.Eof;
end;

function TRcicBtr.Active: boolean;
begin
  Result := oBtrTable.Active;
end;

function TRcicBtr.ActPos: longint;
begin
  Result := oBtrTable.ActPos;
end;

function TRcicBtr.GotoPos (pActPos:longint): boolean;
begin
  Result := oBtrTable.GotoPos(pActPos);
end;

function TRcicBtr.LocateFgDvzName (pFgDvzName:Str3):boolean;
begin
  SetIndex (ixFgDvzName);
  Result := oBtrTable.FindKey([pFgDvzName]);
end;

function TRcicBtr.LocateDocNum (pDocNum:Str12):boolean;
begin
  SetIndex (ixDocNum);
  Result := oBtrTable.FindKey([pDocNum]);
end;

function TRcicBtr.LocateExtNum (pExtNum:Str12):boolean;
begin
  SetIndex (ixExtNum);
  Result := oBtrTable.FindKey([pExtNum]);
end;

function TRcicBtr.NearestFgDvzName (pFgDvzName:Str3):boolean;
begin
  SetIndex (ixFgDvzName);
  Result := oBtrTable.FindNearest([pFgDvzName]);
end;

function TRcicBtr.NearestDocNum (pDocNum:Str12):boolean;
begin
  SetIndex (ixDocNum);
  Result := oBtrTable.FindNearest([pDocNum]);
end;

function TRcicBtr.NearestExtNum (pExtNum:Str12):boolean;
begin
  SetIndex (ixExtNum);
  Result := oBtrTable.FindNearest([pExtNum]);
end;

procedure TRcicBtr.SetIndex (pIndexName:ShortString);
begin
  If oBtrTable.IndexName<>pIndexName then oBtrTable.IndexName := pIndexName;
end;

procedure TRcicBtr.Open;
begin
  oBtrTable.Open;
end;

procedure TRcicBtr.Close;
begin
  If oBtrTable.Active then oBtrTable.Close;
end;

procedure TRcicBtr.Prior;
begin
  oBtrTable.Prior;
end;

procedure TRcicBtr.Next;
begin
  oBtrTable.Next;
end;

procedure TRcicBtr.First;
begin
  oBtrTable.First;
end;

procedure TRcicBtr.Last;
begin
  oBtrTable.Last;
end;

procedure TRcicBtr.Insert;
begin
  oBtrTable.Insert;
end;

procedure TRcicBtr.Edit;
begin
  oBtrTable.Edit;
end;

procedure TRcicBtr.Post;
begin
  oBtrTable.Post;
end;

procedure TRcicBtr.Delete;
begin
  oBtrTable.Delete;
end;

procedure TRcicBtr.SwapIndex;
begin
  oBtrTable.SwapIndex;
end;

procedure TRcicBtr.RestoreIndex;
begin
  oBtrTable.RestoreIndex;
end;

procedure TRcicBtr.SwapStatus;
begin
  oBtrTable.SwapStatus;
end;

procedure TRcicBtr.RestoreStatus;
begin
  oBtrTable.RestoreStatus;
end;

procedure TRcicBtr.EnableControls;
begin
  oBtrTable.EnableControls;
end;

procedure TRcicBtr.DisableControls;
begin
  oBtrTable.DisableControls;
end;

end.
