unit bEPCLST;

interface

uses
  IcTypes, IcConv, NexPath, NexGlob,
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls,
  Dialogs, DB, NexBtrTable, DBTables, NexPxTable;

const
  ixEpcNum = 'EpcNum';
  ixEpcName = 'EpcName';
  ixLogName = 'LogName';

type
  TEpclstBtr = class (TComponent)
    constructor Create; overload;
    destructor  Destroy; override;
  private
    oBtrTable: TNexBtrTable;
    function ReadCount:integer;
    function FieldExist (pFieldName:ShortString): boolean;
    // Pristup k databazovym poliam
    function  ReadEpcNum:word;           procedure WriteEpcNum (pValue:word);
    function  ReadEpcName:Str30;         procedure WriteEpcName (pValue:Str30);
    function  ReadEpcName_:Str30;        procedure WriteEpcName_ (pValue:Str30);
    function  ReadLogName:Str8;          procedure WriteLogName (pValue:Str8);
    function  ReadDlrCode:word;          procedure WriteDlrCode (pValue:word);
    function  ReadWriNum:word;           procedure WriteWriNum (pValue:word);
    function  ReadTrmNum:word;           procedure WriteTrmNum (pValue:word);
    function  ReadEpgNum:word;           procedure WriteEpgNum (pValue:word);
    function  ReadBasVal:double;         procedure WriteBasVal (pValue:double);
    function  ReadAddVag:double;         procedure WriteAddVag (pValue:double);
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
    function LocateEpcNum (pEpcNum:word):boolean;
    function LocateEpcName (pEpcName_:Str30):boolean;
    function LocateLogName (pLogName:Str8):boolean;
    function NearestEpcNum (pEpcNum:word):boolean;
    function NearestEpcName (pEpcName_:Str30):boolean;
    function NearestLogName (pLogName:Str8):boolean;

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
    property EpcNum:word read ReadEpcNum write WriteEpcNum;
    property EpcName:Str30 read ReadEpcName write WriteEpcName;
    property EpcName_:Str30 read ReadEpcName_ write WriteEpcName_;
    property LogName:Str8 read ReadLogName write WriteLogName;
    property DlrCode:word read ReadDlrCode write WriteDlrCode;
    property WriNum:word read ReadWriNum write WriteWriNum;
    property TrmNum:word read ReadTrmNum write WriteTrmNum;
    property EpgNum:word read ReadEpgNum write WriteEpgNum;
    property BasVal:double read ReadBasVal write WriteBasVal;
    property AddVag:double read ReadAddVag write WriteAddVag;
    property CrtUser:Str8 read ReadCrtUser write WriteCrtUser;
    property CrtDate:TDatetime read ReadCrtDate write WriteCrtDate;
    property CrtTime:TDatetime read ReadCrtTime write WriteCrtTime;
    property ModUser:Str8 read ReadModUser write WriteModUser;
    property ModDate:TDatetime read ReadModDate write WriteModDate;
    property ModTime:TDatetime read ReadModTime write WriteModTime;
  end;

implementation

constructor TEpclstBtr.Create;
begin
  oBtrTable := BtrInit ('EPCLST',gPath.DlsPath,Self);
end;

constructor TEpclstBtr.Create(pPath:ShortString);
begin
  oBtrTable := BtrInit ('EPCLST',pPath,Self);
end;

destructor TEpclstBtr.Destroy;
begin
  oBtrTable.Close;  FreeAndNil (oBtrTable);
end;

// *************************************** PRIVATE ********************************************

function TEpclstBtr.ReadCount:integer;
begin
  Result := oBtrTable.RecordCount;
end;

function TEpclstBtr.FieldExist (pFieldName:ShortString): boolean;
begin
  Result := oBtrTable.FindField(pFieldName)<>nil;
end;

function TEpclstBtr.ReadEpcNum:word;
begin
  Result := oBtrTable.FieldByName('EpcNum').AsInteger;
end;

procedure TEpclstBtr.WriteEpcNum(pValue:word);
begin
  oBtrTable.FieldByName('EpcNum').AsInteger := pValue;
end;

function TEpclstBtr.ReadEpcName:Str30;
begin
  Result := oBtrTable.FieldByName('EpcName').AsString;
end;

procedure TEpclstBtr.WriteEpcName(pValue:Str30);
begin
  oBtrTable.FieldByName('EpcName').AsString := pValue;
end;

function TEpclstBtr.ReadEpcName_:Str30;
begin
  Result := oBtrTable.FieldByName('EpcName_').AsString;
end;

procedure TEpclstBtr.WriteEpcName_(pValue:Str30);
begin
  oBtrTable.FieldByName('EpcName_').AsString := pValue;
end;

function TEpclstBtr.ReadLogName:Str8;
begin
  Result := oBtrTable.FieldByName('LogName').AsString;
end;

procedure TEpclstBtr.WriteLogName(pValue:Str8);
begin
  oBtrTable.FieldByName('LogName').AsString := pValue;
end;

function TEpclstBtr.ReadDlrCode:word;
begin
  Result := oBtrTable.FieldByName('DlrCode').AsInteger;
end;

procedure TEpclstBtr.WriteDlrCode(pValue:word);
begin
  oBtrTable.FieldByName('DlrCode').AsInteger := pValue;
end;

function TEpclstBtr.ReadWriNum:word;
begin
  Result := oBtrTable.FieldByName('WriNum').AsInteger;
end;

procedure TEpclstBtr.WriteWriNum(pValue:word);
begin
  oBtrTable.FieldByName('WriNum').AsInteger := pValue;
end;

function TEpclstBtr.ReadTrmNum:word;
begin
  Result := oBtrTable.FieldByName('TrmNum').AsInteger;
end;

procedure TEpclstBtr.WriteTrmNum(pValue:word);
begin
  oBtrTable.FieldByName('TrmNum').AsInteger := pValue;
end;

function TEpclstBtr.ReadEpgNum:word;
begin
  Result := oBtrTable.FieldByName('EpgNum').AsInteger;
end;

procedure TEpclstBtr.WriteEpgNum(pValue:word);
begin
  oBtrTable.FieldByName('EpgNum').AsInteger := pValue;
end;

function TEpclstBtr.ReadBasVal:double;
begin
  Result := oBtrTable.FieldByName('BasVal').AsFloat;
end;

procedure TEpclstBtr.WriteBasVal(pValue:double);
begin
  oBtrTable.FieldByName('BasVal').AsFloat := pValue;
end;

function TEpclstBtr.ReadAddVag:double;
begin
  Result := oBtrTable.FieldByName('AddVag').AsFloat;
end;

procedure TEpclstBtr.WriteAddVag(pValue:double);
begin
  oBtrTable.FieldByName('AddVag').AsFloat := pValue;
end;

function TEpclstBtr.ReadCrtUser:Str8;
begin
  Result := oBtrTable.FieldByName('CrtUser').AsString;
end;

procedure TEpclstBtr.WriteCrtUser(pValue:Str8);
begin
  oBtrTable.FieldByName('CrtUser').AsString := pValue;
end;

function TEpclstBtr.ReadCrtDate:TDatetime;
begin
  Result := oBtrTable.FieldByName('CrtDate').AsDateTime;
end;

procedure TEpclstBtr.WriteCrtDate(pValue:TDatetime);
begin
  oBtrTable.FieldByName('CrtDate').AsDateTime := pValue;
end;

function TEpclstBtr.ReadCrtTime:TDatetime;
begin
  Result := oBtrTable.FieldByName('CrtTime').AsDateTime;
end;

procedure TEpclstBtr.WriteCrtTime(pValue:TDatetime);
begin
  oBtrTable.FieldByName('CrtTime').AsDateTime := pValue;
end;

function TEpclstBtr.ReadModUser:Str8;
begin
  Result := oBtrTable.FieldByName('ModUser').AsString;
end;

procedure TEpclstBtr.WriteModUser(pValue:Str8);
begin
  oBtrTable.FieldByName('ModUser').AsString := pValue;
end;

function TEpclstBtr.ReadModDate:TDatetime;
begin
  Result := oBtrTable.FieldByName('ModDate').AsDateTime;
end;

procedure TEpclstBtr.WriteModDate(pValue:TDatetime);
begin
  oBtrTable.FieldByName('ModDate').AsDateTime := pValue;
end;

function TEpclstBtr.ReadModTime:TDatetime;
begin
  Result := oBtrTable.FieldByName('ModTime').AsDateTime;
end;

procedure TEpclstBtr.WriteModTime(pValue:TDatetime);
begin
  oBtrTable.FieldByName('ModTime').AsDateTime := pValue;
end;

// **************************************** PUBLIC ********************************************

function TEpclstBtr.Eof: boolean;
begin
  Result := oBtrTable.Eof;
end;

function TEpclstBtr.IsFirstRec: boolean;
begin
  Result := oBtrTable.Bof;
end;

function TEpclstBtr.IsLastRec: boolean;
begin
  Result := oBtrTable.Eof;
end;

function TEpclstBtr.Active: boolean;
begin
  Result := oBtrTable.Active;
end;

function TEpclstBtr.ActPos: longint;
begin
  Result := oBtrTable.ActPos;
end;

function TEpclstBtr.GotoPos (pActPos:longint): boolean;
begin
  Result := oBtrTable.GotoPos(pActPos);
end;

function TEpclstBtr.LocateEpcNum (pEpcNum:word):boolean;
begin
  SetIndex (ixEpcNum);
  Result := oBtrTable.FindKey([pEpcNum]);
end;

function TEpclstBtr.LocateEpcName (pEpcName_:Str30):boolean;
begin
  SetIndex (ixEpcName);
  Result := oBtrTable.FindKey([StrToAlias(pEpcName_)]);
end;

function TEpclstBtr.LocateLogName (pLogName:Str8):boolean;
begin
  SetIndex (ixLogName);
  Result := oBtrTable.FindKey([pLogName]);
end;

function TEpclstBtr.NearestEpcNum (pEpcNum:word):boolean;
begin
  SetIndex (ixEpcNum);
  Result := oBtrTable.FindNearest([pEpcNum]);
end;

function TEpclstBtr.NearestEpcName (pEpcName_:Str30):boolean;
begin
  SetIndex (ixEpcName);
  Result := oBtrTable.FindNearest([pEpcName_]);
end;

function TEpclstBtr.NearestLogName (pLogName:Str8):boolean;
begin
  SetIndex (ixLogName);
  Result := oBtrTable.FindNearest([pLogName]);
end;

procedure TEpclstBtr.SetIndex (pIndexName:ShortString);
begin
  If oBtrTable.IndexName<>pIndexName then oBtrTable.IndexName := pIndexName;
end;

procedure TEpclstBtr.Open;
begin
  oBtrTable.Open;
end;

procedure TEpclstBtr.Close;
begin
  If oBtrTable.Active then oBtrTable.Close;
end;

procedure TEpclstBtr.Prior;
begin
  oBtrTable.Prior;
end;

procedure TEpclstBtr.Next;
begin
  oBtrTable.Next;
end;

procedure TEpclstBtr.First;
begin
  oBtrTable.First;
end;

procedure TEpclstBtr.Last;
begin
  oBtrTable.Last;
end;

procedure TEpclstBtr.Insert;
begin
  oBtrTable.Insert;
end;

procedure TEpclstBtr.Edit;
begin
  oBtrTable.Edit;
end;

procedure TEpclstBtr.Post;
begin
  oBtrTable.Post;
end;

procedure TEpclstBtr.Delete;
begin
  oBtrTable.Delete;
end;

procedure TEpclstBtr.SwapIndex;
begin
  oBtrTable.SwapIndex;
end;

procedure TEpclstBtr.RestoreIndex;
begin
  oBtrTable.RestoreIndex;
end;

procedure TEpclstBtr.SwapStatus;
begin
  oBtrTable.SwapStatus;
end;

procedure TEpclstBtr.RestoreStatus;
begin
  oBtrTable.RestoreStatus;
end;

procedure TEpclstBtr.EnableControls;
begin
  oBtrTable.EnableControls;
end;

procedure TEpclstBtr.DisableControls;
begin
  oBtrTable.DisableControls;
end;

end.
