unit bWAE;

interface

uses
  IcTypes, IcConv, NexPath, NexGlob,
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls,
  Dialogs, DB, NexBtrTable, DBTables, NexPxTable;

const
  ixDocNum = 'DocNum';
  ixDoEc = 'DoEc';

type
  TWaeBtr = class (TComponent)
    constructor Create; overload;
    destructor  Destroy; override;
  private
    oBookNum: Str5;
    oBtrTable: TNexBtrTable;
    function ReadCount:integer;
    function FieldExist (pFieldName:ShortString): boolean;
    // Pristup k databazovym poliam
    function  ReadDocNum:Str12;          procedure WriteDocNum (pValue:Str12);
    function  ReadEpcNum:word;           procedure WriteEpcNum (pValue:word);
    function  ReadEpcName:Str30;         procedure WriteEpcName (pValue:Str30);
    function  ReadLogName:Str8;          procedure WriteLogName (pValue:Str8);
    function  ReadDlrCode:word;          procedure WriteDlrCode (pValue:word);
    function  ReadTrmNum:word;           procedure WriteTrmNum (pValue:word);
    function  ReadEpgNum:word;           procedure WriteEpgNum (pValue:word);
    function  ReadBasVal:double;         procedure WriteBasVal (pValue:double);
    function  ReadTrnVal:double;         procedure WriteTrnVal (pValue:double);
    function  ReadPrmVal:double;         procedure WritePrmVal (pValue:double);
    function  ReadAddVal:double;         procedure WriteAddVal (pValue:double);
    function  ReadPenVal:double;         procedure WritePenVal (pValue:double);
    function  ReadBegDate:TDatetime;     procedure WriteBegDate (pValue:TDatetime);
    function  ReadEndDate:TDatetime;     procedure WriteEndDate (pValue:TDatetime);
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
    function LocateDocNum (pDocNum:Str12):boolean;
    function LocateDoEc (pDocNum:Str12;pEpcNum:word):boolean;
    function NearestDocNum (pDocNum:Str12):boolean;
    function NearestDoEc (pDocNum:Str12;pEpcNum:word):boolean;

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
    property EpcNum:word read ReadEpcNum write WriteEpcNum;
    property EpcName:Str30 read ReadEpcName write WriteEpcName;
    property LogName:Str8 read ReadLogName write WriteLogName;
    property DlrCode:word read ReadDlrCode write WriteDlrCode;
    property TrmNum:word read ReadTrmNum write WriteTrmNum;
    property EpgNum:word read ReadEpgNum write WriteEpgNum;
    property BasVal:double read ReadBasVal write WriteBasVal;
    property TrnVal:double read ReadTrnVal write WriteTrnVal;
    property PrmVal:double read ReadPrmVal write WritePrmVal;
    property AddVal:double read ReadAddVal write WriteAddVal;
    property PenVal:double read ReadPenVal write WritePenVal;
    property BegDate:TDatetime read ReadBegDate write WriteBegDate;
    property EndDate:TDatetime read ReadEndDate write WriteEndDate;
    property CrtUser:Str8 read ReadCrtUser write WriteCrtUser;
    property CrtDate:TDatetime read ReadCrtDate write WriteCrtDate;
    property CrtTime:TDatetime read ReadCrtTime write WriteCrtTime;
    property ModUser:Str8 read ReadModUser write WriteModUser;
    property ModDate:TDatetime read ReadModDate write WriteModDate;
    property ModTime:TDatetime read ReadModTime write WriteModTime;
  end;

implementation

constructor TWaeBtr.Create;
begin
  oBtrTable := BtrInit ('WAE',gPath.LdgPath,Self);
end;

constructor TWaeBtr.Create(pPath:ShortString);
begin
  oBtrTable := BtrInit ('WAE',pPath,Self);
end;

destructor TWaeBtr.Destroy;
begin
  oBtrTable.Close;  FreeAndNil (oBtrTable);
end;

// *************************************** PRIVATE ********************************************

function TWaeBtr.ReadCount:integer;
begin
  Result := oBtrTable.RecordCount;
end;

function TWaeBtr.FieldExist (pFieldName:ShortString): boolean;
begin
  Result := oBtrTable.FindField(pFieldName)<>nil;
end;

function TWaeBtr.ReadDocNum:Str12;
begin
  Result := oBtrTable.FieldByName('DocNum').AsString;
end;

procedure TWaeBtr.WriteDocNum(pValue:Str12);
begin
  oBtrTable.FieldByName('DocNum').AsString := pValue;
end;

function TWaeBtr.ReadEpcNum:word;
begin
  Result := oBtrTable.FieldByName('EpcNum').AsInteger;
end;

procedure TWaeBtr.WriteEpcNum(pValue:word);
begin
  oBtrTable.FieldByName('EpcNum').AsInteger := pValue;
end;

function TWaeBtr.ReadEpcName:Str30;
begin
  Result := oBtrTable.FieldByName('EpcName').AsString;
end;

procedure TWaeBtr.WriteEpcName(pValue:Str30);
begin
  oBtrTable.FieldByName('EpcName').AsString := pValue;
end;

function TWaeBtr.ReadLogName:Str8;
begin
  Result := oBtrTable.FieldByName('LogName').AsString;
end;

procedure TWaeBtr.WriteLogName(pValue:Str8);
begin
  oBtrTable.FieldByName('LogName').AsString := pValue;
end;

function TWaeBtr.ReadDlrCode:word;
begin
  Result := oBtrTable.FieldByName('DlrCode').AsInteger;
end;

procedure TWaeBtr.WriteDlrCode(pValue:word);
begin
  oBtrTable.FieldByName('DlrCode').AsInteger := pValue;
end;

function TWaeBtr.ReadTrmNum:word;
begin
  Result := oBtrTable.FieldByName('TrmNum').AsInteger;
end;

procedure TWaeBtr.WriteTrmNum(pValue:word);
begin
  oBtrTable.FieldByName('TrmNum').AsInteger := pValue;
end;

function TWaeBtr.ReadEpgNum:word;
begin
  Result := oBtrTable.FieldByName('EpgNum').AsInteger;
end;

procedure TWaeBtr.WriteEpgNum(pValue:word);
begin
  oBtrTable.FieldByName('EpgNum').AsInteger := pValue;
end;

function TWaeBtr.ReadBasVal:double;
begin
  Result := oBtrTable.FieldByName('BasVal').AsFloat;
end;

procedure TWaeBtr.WriteBasVal(pValue:double);
begin
  oBtrTable.FieldByName('BasVal').AsFloat := pValue;
end;

function TWaeBtr.ReadTrnVal:double;
begin
  Result := oBtrTable.FieldByName('TrnVal').AsFloat;
end;

procedure TWaeBtr.WriteTrnVal(pValue:double);
begin
  oBtrTable.FieldByName('TrnVal').AsFloat := pValue;
end;

function TWaeBtr.ReadPrmVal:double;
begin
  Result := oBtrTable.FieldByName('PrmVal').AsFloat;
end;

procedure TWaeBtr.WritePrmVal(pValue:double);
begin
  oBtrTable.FieldByName('PrmVal').AsFloat := pValue;
end;

function TWaeBtr.ReadAddVal:double;
begin
  Result := oBtrTable.FieldByName('AddVal').AsFloat;
end;

procedure TWaeBtr.WriteAddVal(pValue:double);
begin
  oBtrTable.FieldByName('AddVal').AsFloat := pValue;
end;

function TWaeBtr.ReadPenVal:double;
begin
  Result := oBtrTable.FieldByName('PenVal').AsFloat;
end;

procedure TWaeBtr.WritePenVal(pValue:double);
begin
  oBtrTable.FieldByName('PenVal').AsFloat := pValue;
end;

function TWaeBtr.ReadBegDate:TDatetime;
begin
  Result := oBtrTable.FieldByName('BegDate').AsDateTime;
end;

procedure TWaeBtr.WriteBegDate(pValue:TDatetime);
begin
  oBtrTable.FieldByName('BegDate').AsDateTime := pValue;
end;

function TWaeBtr.ReadEndDate:TDatetime;
begin
  Result := oBtrTable.FieldByName('EndDate').AsDateTime;
end;

procedure TWaeBtr.WriteEndDate(pValue:TDatetime);
begin
  oBtrTable.FieldByName('EndDate').AsDateTime := pValue;
end;

function TWaeBtr.ReadCrtUser:Str8;
begin
  Result := oBtrTable.FieldByName('CrtUser').AsString;
end;

procedure TWaeBtr.WriteCrtUser(pValue:Str8);
begin
  oBtrTable.FieldByName('CrtUser').AsString := pValue;
end;

function TWaeBtr.ReadCrtDate:TDatetime;
begin
  Result := oBtrTable.FieldByName('CrtDate').AsDateTime;
end;

procedure TWaeBtr.WriteCrtDate(pValue:TDatetime);
begin
  oBtrTable.FieldByName('CrtDate').AsDateTime := pValue;
end;

function TWaeBtr.ReadCrtTime:TDatetime;
begin
  Result := oBtrTable.FieldByName('CrtTime').AsDateTime;
end;

procedure TWaeBtr.WriteCrtTime(pValue:TDatetime);
begin
  oBtrTable.FieldByName('CrtTime').AsDateTime := pValue;
end;

function TWaeBtr.ReadModUser:Str8;
begin
  Result := oBtrTable.FieldByName('ModUser').AsString;
end;

procedure TWaeBtr.WriteModUser(pValue:Str8);
begin
  oBtrTable.FieldByName('ModUser').AsString := pValue;
end;

function TWaeBtr.ReadModDate:TDatetime;
begin
  Result := oBtrTable.FieldByName('ModDate').AsDateTime;
end;

procedure TWaeBtr.WriteModDate(pValue:TDatetime);
begin
  oBtrTable.FieldByName('ModDate').AsDateTime := pValue;
end;

function TWaeBtr.ReadModTime:TDatetime;
begin
  Result := oBtrTable.FieldByName('ModTime').AsDateTime;
end;

procedure TWaeBtr.WriteModTime(pValue:TDatetime);
begin
  oBtrTable.FieldByName('ModTime').AsDateTime := pValue;
end;

// **************************************** PUBLIC ********************************************

function TWaeBtr.Eof: boolean;
begin
  Result := oBtrTable.Eof;
end;

function TWaeBtr.IsFirstRec: boolean;
begin
  Result := oBtrTable.Bof;
end;

function TWaeBtr.IsLastRec: boolean;
begin
  Result := oBtrTable.Eof;
end;

function TWaeBtr.Active: boolean;
begin
  Result := oBtrTable.Active;
end;

function TWaeBtr.ActPos: longint;
begin
  Result := oBtrTable.ActPos;
end;

function TWaeBtr.GotoPos (pActPos:longint): boolean;
begin
  Result := oBtrTable.GotoPos(pActPos);
end;

function TWaeBtr.LocateDocNum (pDocNum:Str12):boolean;
begin
  SetIndex (ixDocNum);
  Result := oBtrTable.FindKey([pDocNum]);
end;

function TWaeBtr.LocateDoEc (pDocNum:Str12;pEpcNum:word):boolean;
begin
  SetIndex (ixDoEc);
  Result := oBtrTable.FindKey([pDocNum,pEpcNum]);
end;

function TWaeBtr.NearestDocNum (pDocNum:Str12):boolean;
begin
  SetIndex (ixDocNum);
  Result := oBtrTable.FindNearest([pDocNum]);
end;

function TWaeBtr.NearestDoEc (pDocNum:Str12;pEpcNum:word):boolean;
begin
  SetIndex (ixDoEc);
  Result := oBtrTable.FindNearest([pDocNum,pEpcNum]);
end;

procedure TWaeBtr.SetIndex (pIndexName:ShortString);
begin
  If oBtrTable.IndexName<>pIndexName then oBtrTable.IndexName := pIndexName;
end;

procedure TWaeBtr.Open(pBookNum:Str5);
begin
  oBookNum := pBookNum;
  oBtrTable.Open(pBookNum);
end;

procedure TWaeBtr.Close;
begin
  If oBtrTable.Active then oBtrTable.Close;
end;

procedure TWaeBtr.Prior;
begin
  oBtrTable.Prior;
end;

procedure TWaeBtr.Next;
begin
  oBtrTable.Next;
end;

procedure TWaeBtr.First;
begin
  oBtrTable.First;
end;

procedure TWaeBtr.Last;
begin
  oBtrTable.Last;
end;

procedure TWaeBtr.Insert;
begin
  oBtrTable.Insert;
end;

procedure TWaeBtr.Edit;
begin
  oBtrTable.Edit;
end;

procedure TWaeBtr.Post;
begin
  oBtrTable.Post;
end;

procedure TWaeBtr.Delete;
begin
  oBtrTable.Delete;
end;

procedure TWaeBtr.SwapIndex;
begin
  oBtrTable.SwapIndex;
end;

procedure TWaeBtr.RestoreIndex;
begin
  oBtrTable.RestoreIndex;
end;

procedure TWaeBtr.SwapStatus;
begin
  oBtrTable.SwapStatus;
end;

procedure TWaeBtr.RestoreStatus;
begin
  oBtrTable.RestoreStatus;
end;

procedure TWaeBtr.EnableControls;
begin
  oBtrTable.EnableControls;
end;

procedure TWaeBtr.DisableControls;
begin
  oBtrTable.DisableControls;
end;

end.
