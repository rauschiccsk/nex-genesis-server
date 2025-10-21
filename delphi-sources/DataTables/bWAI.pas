unit bWAI;

interface

uses
  IcTypes, IcConv, NexPath, NexGlob,
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls,
  Dialogs, DB, NexBtrTable, DBTables, NexPxTable;

const
  ixDocNum = 'DocNum';
  ixDoEc = 'DoEc';
  ixDoEcEg = 'DoEcEg';

type
  TWaiBtr = class (TComponent)
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
    function  ReadEpgNum:word;           procedure WriteEpgNum (pValue:word);
    function  ReadWpsCode:word;          procedure WriteWpsCode (pValue:word);
    function  ReadWpsName:Str120;        procedure WriteWpsName (pValue:Str120);
    function  ReadWpsPrc:double;         procedure WriteWpsPrc (pValue:double);
    function  ReadItmType:Str1;          procedure WriteItmType (pValue:Str1);
    function  ReadValType:Str1;          procedure WriteValType (pValue:Str1);
    function  ReadLogName:Str8;          procedure WriteLogName (pValue:Str8);
    function  ReadDlrCode:word;          procedure WriteDlrCode (pValue:word);
    function  ReadTrmNum:word;           procedure WriteTrmNum (pValue:word);
    function  ReadWriNum:word;           procedure WriteWriNum (pValue:word);
    function  ReadBasVal:double;         procedure WriteBasVal (pValue:double);
    function  ReadTrnVal:double;         procedure WriteTrnVal (pValue:double);
    function  ReadPrmVal:double;         procedure WritePrmVal (pValue:double);
    function  ReadAddVal:double;         procedure WriteAddVal (pValue:double);
    function  ReadPenVal:double;         procedure WritePenVal (pValue:double);
    function  ReadCrtUser:Str8;          procedure WriteCrtUser (pValue:Str8);
    function  ReadCrtDate:TDatetime;     procedure WriteCrtDate (pValue:TDatetime);
    function  ReadCrtTime:TDatetime;     procedure WriteCrtTime (pValue:TDatetime);
    function  ReadModUser:Str8;          procedure WriteModUser (pValue:Str8);
    function  ReadModDate:TDatetime;     procedure WriteModDate (pValue:TDatetime);
    function  ReadModTime:TDatetime;     procedure WriteModTime (pValue:TDatetime);
    function  ReadItmSrc:Str2;           procedure WriteItmSrc (pValue:Str2);
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
    function LocateDoEcEg (pDocNum:Str12;pEpcNum:word;pEpgNum:word):boolean;
    function NearestDocNum (pDocNum:Str12):boolean;
    function NearestDoEc (pDocNum:Str12;pEpcNum:word):boolean;
    function NearestDoEcEg (pDocNum:Str12;pEpcNum:word;pEpgNum:word):boolean;

    procedure SetIndex (pIndexName:ShortString);
    procedure Open (pBookNum:Str5);
    procedure Close;
    procedure Prior; virtual;
    procedure Next; virtual;
    procedure First; virtual;
    procedure Last; virtual;
    procedure Insert; virtual;
    procedure Edit; virtual;
    procedure Post; virtual;
    procedure Delete; virtual;
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
    property EpgNum:word read ReadEpgNum write WriteEpgNum;
    property WpsCode:word read ReadWpsCode write WriteWpsCode;
    property WpsName:Str120 read ReadWpsName write WriteWpsName;
    property WpsPrc:double read ReadWpsPrc write WriteWpsPrc;
    property ItmType:Str1 read ReadItmType write WriteItmType;
    property ValType:Str1 read ReadValType write WriteValType;
    property LogName:Str8 read ReadLogName write WriteLogName;
    property DlrCode:word read ReadDlrCode write WriteDlrCode;
    property TrmNum:word read ReadTrmNum write WriteTrmNum;
    property WriNum:word read ReadWriNum write WriteWriNum;
    property BasVal:double read ReadBasVal write WriteBasVal;
    property TrnVal:double read ReadTrnVal write WriteTrnVal;
    property PrmVal:double read ReadPrmVal write WritePrmVal;
    property AddVal:double read ReadAddVal write WriteAddVal;
    property PenVal:double read ReadPenVal write WritePenVal;
    property CrtUser:Str8 read ReadCrtUser write WriteCrtUser;
    property CrtDate:TDatetime read ReadCrtDate write WriteCrtDate;
    property CrtTime:TDatetime read ReadCrtTime write WriteCrtTime;
    property ModUser:Str8 read ReadModUser write WriteModUser;
    property ModDate:TDatetime read ReadModDate write WriteModDate;
    property ModTime:TDatetime read ReadModTime write WriteModTime;
    property ItmSrc:Str2 read ReadItmSrc write WriteItmSrc;
  end;

implementation

constructor TWaiBtr.Create;
begin
  oBtrTable := BtrInit ('WAI',gPath.LdgPath,Self);
end;

constructor TWaiBtr.Create(pPath:ShortString);
begin
  oBtrTable := BtrInit ('WAI',pPath,Self);
end;

destructor TWaiBtr.Destroy;
begin
  oBtrTable.Close;  FreeAndNil (oBtrTable);
end;

// *************************************** PRIVATE ********************************************

function TWaiBtr.ReadCount:integer;
begin
  Result := oBtrTable.RecordCount;
end;

function TWaiBtr.FieldExist (pFieldName:ShortString): boolean;
begin
  Result := oBtrTable.FindField(pFieldName)<>nil;
end;

function TWaiBtr.ReadDocNum:Str12;
begin
  Result := oBtrTable.FieldByName('DocNum').AsString;
end;

procedure TWaiBtr.WriteDocNum(pValue:Str12);
begin
  oBtrTable.FieldByName('DocNum').AsString := pValue;
end;

function TWaiBtr.ReadEpcNum:word;
begin
  Result := oBtrTable.FieldByName('EpcNum').AsInteger;
end;

procedure TWaiBtr.WriteEpcNum(pValue:word);
begin
  oBtrTable.FieldByName('EpcNum').AsInteger := pValue;
end;

function TWaiBtr.ReadEpgNum:word;
begin
  Result := oBtrTable.FieldByName('EpgNum').AsInteger;
end;

procedure TWaiBtr.WriteEpgNum(pValue:word);
begin
  oBtrTable.FieldByName('EpgNum').AsInteger := pValue;
end;

function TWaiBtr.ReadWpsCode:word;
begin
  Result := oBtrTable.FieldByName('WpsCode').AsInteger;
end;

procedure TWaiBtr.WriteWpsCode(pValue:word);
begin
  oBtrTable.FieldByName('WpsCode').AsInteger := pValue;
end;

function TWaiBtr.ReadWpsName:Str120;
begin
  Result := oBtrTable.FieldByName('WpsName').AsString;
end;

procedure TWaiBtr.WriteWpsName(pValue:Str120);
begin
  oBtrTable.FieldByName('WpsName').AsString := pValue;
end;

function TWaiBtr.ReadWpsPrc:double;
begin
  Result := oBtrTable.FieldByName('WpsPrc').AsFloat;
end;

procedure TWaiBtr.WriteWpsPrc(pValue:double);
begin
  oBtrTable.FieldByName('WpsPrc').AsFloat := pValue;
end;

function TWaiBtr.ReadItmType:Str1;
begin
  Result := oBtrTable.FieldByName('ItmType').AsString;
end;

procedure TWaiBtr.WriteItmType(pValue:Str1);
begin
  oBtrTable.FieldByName('ItmType').AsString := pValue;
end;

function TWaiBtr.ReadValType:Str1;
begin
  Result := oBtrTable.FieldByName('ValType').AsString;
end;

procedure TWaiBtr.WriteValType(pValue:Str1);
begin
  oBtrTable.FieldByName('ValType').AsString := pValue;
end;

function TWaiBtr.ReadLogName:Str8;
begin
  Result := oBtrTable.FieldByName('LogName').AsString;
end;

procedure TWaiBtr.WriteLogName(pValue:Str8);
begin
  oBtrTable.FieldByName('LogName').AsString := pValue;
end;

function TWaiBtr.ReadDlrCode:word;
begin
  Result := oBtrTable.FieldByName('DlrCode').AsInteger;
end;

procedure TWaiBtr.WriteDlrCode(pValue:word);
begin
  oBtrTable.FieldByName('DlrCode').AsInteger := pValue;
end;

function TWaiBtr.ReadTrmNum:word;
begin
  Result := oBtrTable.FieldByName('TrmNum').AsInteger;
end;

procedure TWaiBtr.WriteTrmNum(pValue:word);
begin
  oBtrTable.FieldByName('TrmNum').AsInteger := pValue;
end;

function TWaiBtr.ReadWriNum:word;
begin
  Result := oBtrTable.FieldByName('WriNum').AsInteger;
end;

procedure TWaiBtr.WriteWriNum(pValue:word);
begin
  oBtrTable.FieldByName('WriNum').AsInteger := pValue;
end;

function TWaiBtr.ReadBasVal:double;
begin
  Result := oBtrTable.FieldByName('BasVal').AsFloat;
end;

procedure TWaiBtr.WriteBasVal(pValue:double);
begin
  oBtrTable.FieldByName('BasVal').AsFloat := pValue;
end;

function TWaiBtr.ReadTrnVal:double;
begin
  Result := oBtrTable.FieldByName('TrnVal').AsFloat;
end;

procedure TWaiBtr.WriteTrnVal(pValue:double);
begin
  oBtrTable.FieldByName('TrnVal').AsFloat := pValue;
end;

function TWaiBtr.ReadPrmVal:double;
begin
  Result := oBtrTable.FieldByName('PrmVal').AsFloat;
end;

procedure TWaiBtr.WritePrmVal(pValue:double);
begin
  oBtrTable.FieldByName('PrmVal').AsFloat := pValue;
end;

function TWaiBtr.ReadAddVal:double;
begin
  Result := oBtrTable.FieldByName('AddVal').AsFloat;
end;

procedure TWaiBtr.WriteAddVal(pValue:double);
begin
  oBtrTable.FieldByName('AddVal').AsFloat := pValue;
end;

function TWaiBtr.ReadPenVal:double;
begin
  Result := oBtrTable.FieldByName('PenVal').AsFloat;
end;

procedure TWaiBtr.WritePenVal(pValue:double);
begin
  oBtrTable.FieldByName('PenVal').AsFloat := pValue;
end;

function TWaiBtr.ReadCrtUser:Str8;
begin
  Result := oBtrTable.FieldByName('CrtUser').AsString;
end;

procedure TWaiBtr.WriteCrtUser(pValue:Str8);
begin
  oBtrTable.FieldByName('CrtUser').AsString := pValue;
end;

function TWaiBtr.ReadCrtDate:TDatetime;
begin
  Result := oBtrTable.FieldByName('CrtDate').AsDateTime;
end;

procedure TWaiBtr.WriteCrtDate(pValue:TDatetime);
begin
  oBtrTable.FieldByName('CrtDate').AsDateTime := pValue;
end;

function TWaiBtr.ReadCrtTime:TDatetime;
begin
  Result := oBtrTable.FieldByName('CrtTime').AsDateTime;
end;

procedure TWaiBtr.WriteCrtTime(pValue:TDatetime);
begin
  oBtrTable.FieldByName('CrtTime').AsDateTime := pValue;
end;

function TWaiBtr.ReadModUser:Str8;
begin
  Result := oBtrTable.FieldByName('ModUser').AsString;
end;

procedure TWaiBtr.WriteModUser(pValue:Str8);
begin
  oBtrTable.FieldByName('ModUser').AsString := pValue;
end;

function TWaiBtr.ReadModDate:TDatetime;
begin
  Result := oBtrTable.FieldByName('ModDate').AsDateTime;
end;

procedure TWaiBtr.WriteModDate(pValue:TDatetime);
begin
  oBtrTable.FieldByName('ModDate').AsDateTime := pValue;
end;

function TWaiBtr.ReadModTime:TDatetime;
begin
  Result := oBtrTable.FieldByName('ModTime').AsDateTime;
end;

procedure TWaiBtr.WriteModTime(pValue:TDatetime);
begin
  oBtrTable.FieldByName('ModTime').AsDateTime := pValue;
end;

function TWaiBtr.ReadItmSrc:Str2;
begin
  Result := oBtrTable.FieldByName('ItmSrc').AsString;
end;

procedure TWaiBtr.WriteItmSrc(pValue:Str2);
begin
  oBtrTable.FieldByName('ItmSrc').AsString := pValue;
end;

// **************************************** PUBLIC ********************************************

function TWaiBtr.Eof: boolean;
begin
  Result := oBtrTable.Eof;
end;

function TWaiBtr.IsFirstRec: boolean;
begin
  Result := oBtrTable.Bof;
end;

function TWaiBtr.IsLastRec: boolean;
begin
  Result := oBtrTable.Eof;
end;

function TWaiBtr.Active: boolean;
begin
  Result := oBtrTable.Active;
end;

function TWaiBtr.ActPos: longint;
begin
  Result := oBtrTable.ActPos;
end;

function TWaiBtr.GotoPos (pActPos:longint): boolean;
begin
  Result := oBtrTable.GotoPos(pActPos);
end;

function TWaiBtr.LocateDocNum (pDocNum:Str12):boolean;
begin
  SetIndex (ixDocNum);
  Result := oBtrTable.FindKey([pDocNum]);
end;

function TWaiBtr.LocateDoEc (pDocNum:Str12;pEpcNum:word):boolean;
begin
  SetIndex (ixDoEc);
  Result := oBtrTable.FindKey([pDocNum,pEpcNum]);
end;

function TWaiBtr.LocateDoEcEg (pDocNum:Str12;pEpcNum:word;pEpgNum:word):boolean;
begin
  SetIndex (ixDoEcEg);
  Result := oBtrTable.FindKey([pDocNum,pEpcNum,pEpgNum]);
end;

function TWaiBtr.NearestDocNum (pDocNum:Str12):boolean;
begin
  SetIndex (ixDocNum);
  Result := oBtrTable.FindNearest([pDocNum]);
end;

function TWaiBtr.NearestDoEc (pDocNum:Str12;pEpcNum:word):boolean;
begin
  SetIndex (ixDoEc);
  Result := oBtrTable.FindNearest([pDocNum,pEpcNum]);
end;

function TWaiBtr.NearestDoEcEg (pDocNum:Str12;pEpcNum:word;pEpgNum:word):boolean;
begin
  SetIndex (ixDoEcEg);
  Result := oBtrTable.FindNearest([pDocNum,pEpcNum,pEpgNum]);
end;

procedure TWaiBtr.SetIndex (pIndexName:ShortString);
begin
  If oBtrTable.IndexName<>pIndexName then oBtrTable.IndexName := pIndexName;
end;

procedure TWaiBtr.Open(pBookNum:Str5);
begin
  oBookNum := pBookNum;
  oBtrTable.Open(pBookNum);
end;

procedure TWaiBtr.Close;
begin
  If oBtrTable.Active then oBtrTable.Close;
end;

procedure TWaiBtr.Prior;
begin
  oBtrTable.Prior;
end;

procedure TWaiBtr.Next;
begin
  oBtrTable.Next;
end;

procedure TWaiBtr.First;
begin
  oBtrTable.First;
end;

procedure TWaiBtr.Last;
begin
  oBtrTable.Last;
end;

procedure TWaiBtr.Insert;
begin
  oBtrTable.Insert;
end;

procedure TWaiBtr.Edit;
begin
  oBtrTable.Edit;
end;

procedure TWaiBtr.Post;
begin
  oBtrTable.Post;
end;

procedure TWaiBtr.Delete;
begin
  oBtrTable.Delete;
end;

procedure TWaiBtr.SwapIndex;
begin
  oBtrTable.SwapIndex;
end;

procedure TWaiBtr.RestoreIndex;
begin
  oBtrTable.RestoreIndex;
end;

procedure TWaiBtr.SwapStatus;
begin
  oBtrTable.SwapStatus;
end;

procedure TWaiBtr.RestoreStatus;
begin
  oBtrTable.RestoreStatus;
end;

procedure TWaiBtr.EnableControls;
begin
  oBtrTable.EnableControls;
end;

procedure TWaiBtr.DisableControls;
begin
  oBtrTable.DisableControls;
end;

end.
