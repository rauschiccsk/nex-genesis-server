unit bCPBLST;

interface

uses
  IcTypes, IcConv, NexPath, NexGlob,
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls,
  Dialogs, DB, NexBtrTable, DBTables, NexPxTable;

const
  ixCpbNum = 'CpbNum';

type
  TCpblstBtr = class (TComponent)
    constructor Create; overload;
    destructor  Destroy; override;
  private
    oBtrTable: TNexBtrTable;
    function ReadCount:integer;
    function FieldExist (pFieldName:ShortString): boolean;
    // Pristup k databazovym poliam
    function  ReadCpbNum:longint;        procedure WriteCpbNum (pValue:longint);
    function  ReadCpbName:Str30;         procedure WriteCpbName (pValue:Str30);
    function  ReadWriNum:word;           procedure WriteWriNum (pValue:word);
    function  ReadPdStkNum:word;         procedure WritePdStkNum (pValue:word);
    function  ReadCpStkNum:word;         procedure WriteCpStkNum (pValue:word);
    function  ReadPdPlsNum:word;         procedure WritePdPlsNum (pValue:word);
    function  ReadRndType:byte;          procedure WriteRndType (pValue:byte);
    function  ReadPlsSave:byte;          procedure WritePlsSave (pValue:byte);
    function  ReadAvgClc:byte;           procedure WriteAvgClc (pValue:byte);
    function  ReadItmQnt:word;           procedure WriteItmQnt (pValue:word);
    function  ReadShared:boolean;        procedure WriteShared (pValue:boolean);
    function  ReadCrtUser:Str8;          procedure WriteCrtUser (pValue:Str8);
    function  ReadCrtDate:TDatetime;     procedure WriteCrtDate (pValue:TDatetime);
    function  ReadCrtTime:TDatetime;     procedure WriteCrtTime (pValue:TDatetime);
    function  ReadModNum:word;           procedure WriteModNum (pValue:word);
    function  ReadModUser:Str8;          procedure WriteModUser (pValue:Str8);
    function  ReadModDate:TDatetime;     procedure WriteModDate (pValue:TDatetime);
    function  ReadModTime:TDatetime;     procedure WriteModTime (pValue:TDatetime);
    function  ReadFrmNum:byte;           procedure WriteFrmNum (pValue:byte);
  public
    constructor Create(pPath:ShortString); overload;
    // Elementarne databazove operacie
    function Eof: boolean;
    function IsFirstRec: boolean;
    function IsLastRec: boolean;
    function Active: boolean;
    function ActPos: longint;
    function GotoPos (pActPos:longint): boolean;
    function LocateCpbNum (pCpbNum:longint):boolean;
    function NearestCpbNum (pCpbNum:longint):boolean;

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
    property CpbNum:longint read ReadCpbNum write WriteCpbNum;
    property CpbName:Str30 read ReadCpbName write WriteCpbName;
    property WriNum:word read ReadWriNum write WriteWriNum;
    property PdStkNum:word read ReadPdStkNum write WritePdStkNum;
    property CpStkNum:word read ReadCpStkNum write WriteCpStkNum;
    property PdPlsNum:word read ReadPdPlsNum write WritePdPlsNum;
    property RndType:byte read ReadRndType write WriteRndType;
    property PlsSave:byte read ReadPlsSave write WritePlsSave;
    property AvgClc:byte read ReadAvgClc write WriteAvgClc;
    property ItmQnt:word read ReadItmQnt write WriteItmQnt;
    property Shared:boolean read ReadShared write WriteShared;
    property CrtUser:Str8 read ReadCrtUser write WriteCrtUser;
    property CrtDate:TDatetime read ReadCrtDate write WriteCrtDate;
    property CrtTime:TDatetime read ReadCrtTime write WriteCrtTime;
    property ModNum:word read ReadModNum write WriteModNum;
    property ModUser:Str8 read ReadModUser write WriteModUser;
    property ModDate:TDatetime read ReadModDate write WriteModDate;
    property ModTime:TDatetime read ReadModTime write WriteModTime;
    property FrmNum:byte read ReadFrmNum write WriteFrmNum;
  end;

implementation

constructor TCpblstBtr.Create;
begin
  oBtrTable := BtrInit ('CPBLST',gPath.StkPath,Self);
end;

constructor TCpblstBtr.Create(pPath:ShortString);
begin
  oBtrTable := BtrInit ('CPBLST',pPath,Self);
end;

destructor TCpblstBtr.Destroy;
begin
  oBtrTable.Close;  FreeAndNil (oBtrTable);
end;

// *************************************** PRIVATE ********************************************

function TCpblstBtr.ReadCount:integer;
begin
  Result := oBtrTable.RecordCount;
end;

function TCpblstBtr.FieldExist (pFieldName:ShortString): boolean;
begin
  Result := oBtrTable.FindField(pFieldName)<>nil;
end;

function TCpblstBtr.ReadCpbNum:longint;
begin
  Result := oBtrTable.FieldByName('CpbNum').AsInteger;
end;

procedure TCpblstBtr.WriteCpbNum(pValue:longint);
begin
  oBtrTable.FieldByName('CpbNum').AsInteger := pValue;
end;

function TCpblstBtr.ReadCpbName:Str30;
begin
  Result := oBtrTable.FieldByName('CpbName').AsString;
end;

procedure TCpblstBtr.WriteCpbName(pValue:Str30);
begin
  oBtrTable.FieldByName('CpbName').AsString := pValue;
end;

function TCpblstBtr.ReadWriNum:word;
begin
  Result := oBtrTable.FieldByName('WriNum').AsInteger;
end;

procedure TCpblstBtr.WriteWriNum(pValue:word);
begin
  oBtrTable.FieldByName('WriNum').AsInteger := pValue;
end;

function TCpblstBtr.ReadPdStkNum:word;
begin
  Result := oBtrTable.FieldByName('PdStkNum').AsInteger;
end;

procedure TCpblstBtr.WritePdStkNum(pValue:word);
begin
  oBtrTable.FieldByName('PdStkNum').AsInteger := pValue;
end;

function TCpblstBtr.ReadCpStkNum:word;
begin
  Result := oBtrTable.FieldByName('CpStkNum').AsInteger;
end;

procedure TCpblstBtr.WriteCpStkNum(pValue:word);
begin
  oBtrTable.FieldByName('CpStkNum').AsInteger := pValue;
end;

function TCpblstBtr.ReadPdPlsNum:word;
begin
  Result := oBtrTable.FieldByName('PdPlsNum').AsInteger;
end;

procedure TCpblstBtr.WritePdPlsNum(pValue:word);
begin
  oBtrTable.FieldByName('PdPlsNum').AsInteger := pValue;
end;

function TCpblstBtr.ReadRndType:byte;
begin
  Result := oBtrTable.FieldByName('RndType').AsInteger;
end;

procedure TCpblstBtr.WriteRndType(pValue:byte);
begin
  oBtrTable.FieldByName('RndType').AsInteger := pValue;
end;

function TCpblstBtr.ReadPlsSave:byte;
begin
  Result := oBtrTable.FieldByName('PlsSave').AsInteger;
end;

procedure TCpblstBtr.WritePlsSave(pValue:byte);
begin
  oBtrTable.FieldByName('PlsSave').AsInteger := pValue;
end;

function TCpblstBtr.ReadAvgClc:byte;
begin
  Result := oBtrTable.FieldByName('AvgClc').AsInteger;
end;

procedure TCpblstBtr.WriteAvgClc(pValue:byte);
begin
  oBtrTable.FieldByName('AvgClc').AsInteger := pValue;
end;

function TCpblstBtr.ReadItmQnt:word;
begin
  Result := oBtrTable.FieldByName('ItmQnt').AsInteger;
end;

procedure TCpblstBtr.WriteItmQnt(pValue:word);
begin
  oBtrTable.FieldByName('ItmQnt').AsInteger := pValue;
end;

function TCpblstBtr.ReadShared:boolean;
begin
  Result := ByteToBool(oBtrTable.FieldByName('Shared').AsInteger);
end;

procedure TCpblstBtr.WriteShared(pValue:boolean);
begin
  oBtrTable.FieldByName('Shared').AsInteger := BoolToByte(pValue);
end;

function TCpblstBtr.ReadCrtUser:Str8;
begin
  Result := oBtrTable.FieldByName('CrtUser').AsString;
end;

procedure TCpblstBtr.WriteCrtUser(pValue:Str8);
begin
  oBtrTable.FieldByName('CrtUser').AsString := pValue;
end;

function TCpblstBtr.ReadCrtDate:TDatetime;
begin
  Result := oBtrTable.FieldByName('CrtDate').AsDateTime;
end;

procedure TCpblstBtr.WriteCrtDate(pValue:TDatetime);
begin
  oBtrTable.FieldByName('CrtDate').AsDateTime := pValue;
end;

function TCpblstBtr.ReadCrtTime:TDatetime;
begin
  Result := oBtrTable.FieldByName('CrtTime').AsDateTime;
end;

procedure TCpblstBtr.WriteCrtTime(pValue:TDatetime);
begin
  oBtrTable.FieldByName('CrtTime').AsDateTime := pValue;
end;

function TCpblstBtr.ReadModNum:word;
begin
  Result := oBtrTable.FieldByName('ModNum').AsInteger;
end;

procedure TCpblstBtr.WriteModNum(pValue:word);
begin
  oBtrTable.FieldByName('ModNum').AsInteger := pValue;
end;

function TCpblstBtr.ReadModUser:Str8;
begin
  Result := oBtrTable.FieldByName('ModUser').AsString;
end;

procedure TCpblstBtr.WriteModUser(pValue:Str8);
begin
  oBtrTable.FieldByName('ModUser').AsString := pValue;
end;

function TCpblstBtr.ReadModDate:TDatetime;
begin
  Result := oBtrTable.FieldByName('ModDate').AsDateTime;
end;

procedure TCpblstBtr.WriteModDate(pValue:TDatetime);
begin
  oBtrTable.FieldByName('ModDate').AsDateTime := pValue;
end;

function TCpblstBtr.ReadModTime:TDatetime;
begin
  Result := oBtrTable.FieldByName('ModTime').AsDateTime;
end;

procedure TCpblstBtr.WriteModTime(pValue:TDatetime);
begin
  oBtrTable.FieldByName('ModTime').AsDateTime := pValue;
end;

function TCpblstBtr.ReadFrmNum:byte;
begin
  Result := oBtrTable.FieldByName('FrmNum').AsInteger;
end;

procedure TCpblstBtr.WriteFrmNum(pValue:byte);
begin
  oBtrTable.FieldByName('FrmNum').AsInteger := pValue;
end;

// **************************************** PUBLIC ********************************************

function TCpblstBtr.Eof: boolean;
begin
  Result := oBtrTable.Eof;
end;

function TCpblstBtr.IsFirstRec: boolean;
begin
  Result := oBtrTable.Bof;
end;

function TCpblstBtr.IsLastRec: boolean;
begin
  Result := oBtrTable.Eof;
end;

function TCpblstBtr.Active: boolean;
begin
  Result := oBtrTable.Active;
end;

function TCpblstBtr.ActPos: longint;
begin
  Result := oBtrTable.ActPos;
end;

function TCpblstBtr.GotoPos (pActPos:longint): boolean;
begin
  Result := oBtrTable.GotoPos(pActPos);
end;

function TCpblstBtr.LocateCpbNum (pCpbNum:longint):boolean;
begin
  SetIndex (ixCpbNum);
  Result := oBtrTable.FindKey([pCpbNum]);
end;

function TCpblstBtr.NearestCpbNum (pCpbNum:longint):boolean;
begin
  SetIndex (ixCpbNum);
  Result := oBtrTable.FindNearest([pCpbNum]);
end;

procedure TCpblstBtr.SetIndex (pIndexName:ShortString);
begin
  If oBtrTable.IndexName<>pIndexName then oBtrTable.IndexName := pIndexName;
end;

procedure TCpblstBtr.Open;
begin
  oBtrTable.Open;
end;

procedure TCpblstBtr.Close;
begin
  If oBtrTable.Active then oBtrTable.Close;
end;

procedure TCpblstBtr.Prior;
begin
  oBtrTable.Prior;
end;

procedure TCpblstBtr.Next;
begin
  oBtrTable.Next;
end;

procedure TCpblstBtr.First;
begin
  oBtrTable.First;
end;

procedure TCpblstBtr.Last;
begin
  oBtrTable.Last;
end;

procedure TCpblstBtr.Insert;
begin
  oBtrTable.Insert;
end;

procedure TCpblstBtr.Edit;
begin
  oBtrTable.Edit;
end;

procedure TCpblstBtr.Post;
begin
  oBtrTable.Post;
end;

procedure TCpblstBtr.Delete;
begin
  oBtrTable.Delete;
end;

procedure TCpblstBtr.SwapIndex;
begin
  oBtrTable.SwapIndex;
end;

procedure TCpblstBtr.RestoreIndex;
begin
  oBtrTable.RestoreIndex;
end;

procedure TCpblstBtr.SwapStatus;
begin
  oBtrTable.SwapStatus;
end;

procedure TCpblstBtr.RestoreStatus;
begin
  oBtrTable.RestoreStatus;
end;

procedure TCpblstBtr.EnableControls;
begin
  oBtrTable.EnableControls;
end;

procedure TCpblstBtr.DisableControls;
begin
  oBtrTable.DisableControls;
end;

end.
