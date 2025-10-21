unit bSRDOC;

interface

uses
  IcTypes, IcConv, NexPath, NexGlob,
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls,
  Dialogs, DB, NexBtrTable, DBTables, NexPxTable;

const
  ixMthNum = 'MthNum';
  ixSerNum = 'SerNum';

type
  TSrdocBtr = class (TComponent)
    constructor Create; overload;
    destructor  Destroy; override;
  private
    oBtrTable: TNexBtrTable;
    function ReadCount:integer;
    function FieldExist (pFieldName:ShortString): boolean;
    // Pristup k databazovym poliam
    function  ReadMthNum:byte;           procedure WriteMthNum (pValue:byte);
    function  ReadDocDate:TDatetime;     procedure WriteDocDate (pValue:TDatetime);
    function  ReadNotice:Str28;          procedure WriteNotice (pValue:Str28);
    function  ReadVersion:Str1;          procedure WriteVersion (pValue:Str1);
    function  ReadGivName:Str30;         procedure WriteGivName (pValue:Str30);
    function  ReadGivTel:Str15;          procedure WriteGivTel (pValue:Str15);
    function  ReadGivFax:Str15;          procedure WriteGivFax (pValue:Str15);
    function  ReadGivMail:Str30;         procedure WriteGivMail (pValue:Str30);
    function  ReadRspName:Str30;         procedure WriteRspName (pValue:Str30);
    function  ReadRspTel:Str15;          procedure WriteRspTel (pValue:Str15);
    function  ReadRspFax:Str15;          procedure WriteRspFax (pValue:Str15);
    function  ReadRspMail:Str30;         procedure WriteRspMail (pValue:Str30);
    function  ReadSrsCnt:word;           procedure WriteSrsCnt (pValue:word);
    function  ReadSriCnt:word;           procedure WriteSriCnt (pValue:word);
    function  ReadSroCnt:word;           procedure WriteSroCnt (pValue:word);
    function  ReadCrtUser:Str8;          procedure WriteCrtUser (pValue:Str8);
    function  ReadCrtDate:TDatetime;     procedure WriteCrtDate (pValue:TDatetime);
    function  ReadCrtTime:TDatetime;     procedure WriteCrtTime (pValue:TDatetime);
    function  ReadModNum:word;           procedure WriteModNum (pValue:word);
    function  ReadModUser:Str8;          procedure WriteModUser (pValue:Str8);
    function  ReadModDate:TDatetime;     procedure WriteModDate (pValue:TDatetime);
    function  ReadModTime:TDatetime;     procedure WriteModTime (pValue:TDatetime);
    function  ReadBegQnt:double;         procedure WriteBegQnt (pValue:double);
    function  ReadIncQnt:double;         procedure WriteIncQnt (pValue:double);
    function  ReadOutQnt:double;         procedure WriteOutQnt (pValue:double);
    function  ReadEndQnt:double;         procedure WriteEndQnt (pValue:double);
    function  ReadRepType:Str1;          procedure WriteRepType (pValue:Str1);
    function  ReadSerNum:longint;        procedure WriteSerNum (pValue:longint);
  public
    constructor Create(pPath:ShortString); overload;
    // Elementarne databazove operacie
    function Eof: boolean;
    function IsFirstRec: boolean;
    function IsLastRec: boolean;
    function Active: boolean;
    function ActPos: longint;
    function GotoPos (pActPos:longint): boolean;
    function LocateMthNum (pMthNum:byte):boolean;
    function LocateSerNum (pSerNum:longint):boolean;
    function NearestMthNum (pMthNum:byte):boolean;
    function NearestSerNum (pSerNum:longint):boolean;

    procedure SetIndex (pIndexName:ShortString);
    procedure Open;
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
    property MthNum:byte read ReadMthNum write WriteMthNum;
    property DocDate:TDatetime read ReadDocDate write WriteDocDate;
    property Notice:Str28 read ReadNotice write WriteNotice;
    property Version:Str1 read ReadVersion write WriteVersion;
    property GivName:Str30 read ReadGivName write WriteGivName;
    property GivTel:Str15 read ReadGivTel write WriteGivTel;
    property GivFax:Str15 read ReadGivFax write WriteGivFax;
    property GivMail:Str30 read ReadGivMail write WriteGivMail;
    property RspName:Str30 read ReadRspName write WriteRspName;
    property RspTel:Str15 read ReadRspTel write WriteRspTel;
    property RspFax:Str15 read ReadRspFax write WriteRspFax;
    property RspMail:Str30 read ReadRspMail write WriteRspMail;
    property SrsCnt:word read ReadSrsCnt write WriteSrsCnt;
    property SriCnt:word read ReadSriCnt write WriteSriCnt;
    property SroCnt:word read ReadSroCnt write WriteSroCnt;
    property CrtUser:Str8 read ReadCrtUser write WriteCrtUser;
    property CrtDate:TDatetime read ReadCrtDate write WriteCrtDate;
    property CrtTime:TDatetime read ReadCrtTime write WriteCrtTime;
    property ModNum:word read ReadModNum write WriteModNum;
    property ModUser:Str8 read ReadModUser write WriteModUser;
    property ModDate:TDatetime read ReadModDate write WriteModDate;
    property ModTime:TDatetime read ReadModTime write WriteModTime;
    property BegQnt:double read ReadBegQnt write WriteBegQnt;
    property IncQnt:double read ReadIncQnt write WriteIncQnt;
    property OutQnt:double read ReadOutQnt write WriteOutQnt;
    property EndQnt:double read ReadEndQnt write WriteEndQnt;
    property RepType:Str1 read ReadRepType write WriteRepType;
    property SerNum:longint read ReadSerNum write WriteSerNum;
  end;

implementation

constructor TSrdocBtr.Create;
begin
  oBtrTable := BtrInit ('SRDOC',gPath.LdgPath,Self);
end;

constructor TSrdocBtr.Create(pPath:ShortString);
begin
  oBtrTable := BtrInit ('SRDOC',pPath,Self);
end;

destructor TSrdocBtr.Destroy;
begin
  oBtrTable.Close;  FreeAndNil (oBtrTable);
end;

// *************************************** PRIVATE ********************************************

function TSrdocBtr.ReadCount:integer;
begin
  Result := oBtrTable.RecordCount;
end;

function TSrdocBtr.FieldExist (pFieldName:ShortString): boolean;
begin
  Result := oBtrTable.FindField(pFieldName)<>nil;
end;

function TSrdocBtr.ReadMthNum:byte;
begin
  Result := oBtrTable.FieldByName('MthNum').AsInteger;
end;

procedure TSrdocBtr.WriteMthNum(pValue:byte);
begin
  oBtrTable.FieldByName('MthNum').AsInteger := pValue;
end;

function TSrdocBtr.ReadDocDate:TDatetime;
begin
  Result := oBtrTable.FieldByName('DocDate').AsDateTime;
end;

procedure TSrdocBtr.WriteDocDate(pValue:TDatetime);
begin
  oBtrTable.FieldByName('DocDate').AsDateTime := pValue;
end;

function TSrdocBtr.ReadNotice:Str28;
begin
  Result := oBtrTable.FieldByName('Notice').AsString;
end;

procedure TSrdocBtr.WriteNotice(pValue:Str28);
begin
  oBtrTable.FieldByName('Notice').AsString := pValue;
end;

function TSrdocBtr.ReadVersion:Str1;
begin
  Result := oBtrTable.FieldByName('Version').AsString;
end;

procedure TSrdocBtr.WriteVersion(pValue:Str1);
begin
  oBtrTable.FieldByName('Version').AsString := pValue;
end;

function TSrdocBtr.ReadGivName:Str30;
begin
  Result := oBtrTable.FieldByName('GivName').AsString;
end;

procedure TSrdocBtr.WriteGivName(pValue:Str30);
begin
  oBtrTable.FieldByName('GivName').AsString := pValue;
end;

function TSrdocBtr.ReadGivTel:Str15;
begin
  Result := oBtrTable.FieldByName('GivTel').AsString;
end;

procedure TSrdocBtr.WriteGivTel(pValue:Str15);
begin
  oBtrTable.FieldByName('GivTel').AsString := pValue;
end;

function TSrdocBtr.ReadGivFax:Str15;
begin
  Result := oBtrTable.FieldByName('GivFax').AsString;
end;

procedure TSrdocBtr.WriteGivFax(pValue:Str15);
begin
  oBtrTable.FieldByName('GivFax').AsString := pValue;
end;

function TSrdocBtr.ReadGivMail:Str30;
begin
  Result := oBtrTable.FieldByName('GivMail').AsString;
end;

procedure TSrdocBtr.WriteGivMail(pValue:Str30);
begin
  oBtrTable.FieldByName('GivMail').AsString := pValue;
end;

function TSrdocBtr.ReadRspName:Str30;
begin
  Result := oBtrTable.FieldByName('RspName').AsString;
end;

procedure TSrdocBtr.WriteRspName(pValue:Str30);
begin
  oBtrTable.FieldByName('RspName').AsString := pValue;
end;

function TSrdocBtr.ReadRspTel:Str15;
begin
  Result := oBtrTable.FieldByName('RspTel').AsString;
end;

procedure TSrdocBtr.WriteRspTel(pValue:Str15);
begin
  oBtrTable.FieldByName('RspTel').AsString := pValue;
end;

function TSrdocBtr.ReadRspFax:Str15;
begin
  Result := oBtrTable.FieldByName('RspFax').AsString;
end;

procedure TSrdocBtr.WriteRspFax(pValue:Str15);
begin
  oBtrTable.FieldByName('RspFax').AsString := pValue;
end;

function TSrdocBtr.ReadRspMail:Str30;
begin
  Result := oBtrTable.FieldByName('RspMail').AsString;
end;

procedure TSrdocBtr.WriteRspMail(pValue:Str30);
begin
  oBtrTable.FieldByName('RspMail').AsString := pValue;
end;

function TSrdocBtr.ReadSrsCnt:word;
begin
  Result := oBtrTable.FieldByName('SrsCnt').AsInteger;
end;

procedure TSrdocBtr.WriteSrsCnt(pValue:word);
begin
  oBtrTable.FieldByName('SrsCnt').AsInteger := pValue;
end;

function TSrdocBtr.ReadSriCnt:word;
begin
  Result := oBtrTable.FieldByName('SriCnt').AsInteger;
end;

procedure TSrdocBtr.WriteSriCnt(pValue:word);
begin
  oBtrTable.FieldByName('SriCnt').AsInteger := pValue;
end;

function TSrdocBtr.ReadSroCnt:word;
begin
  Result := oBtrTable.FieldByName('SroCnt').AsInteger;
end;

procedure TSrdocBtr.WriteSroCnt(pValue:word);
begin
  oBtrTable.FieldByName('SroCnt').AsInteger := pValue;
end;

function TSrdocBtr.ReadCrtUser:Str8;
begin
  Result := oBtrTable.FieldByName('CrtUser').AsString;
end;

procedure TSrdocBtr.WriteCrtUser(pValue:Str8);
begin
  oBtrTable.FieldByName('CrtUser').AsString := pValue;
end;

function TSrdocBtr.ReadCrtDate:TDatetime;
begin
  Result := oBtrTable.FieldByName('CrtDate').AsDateTime;
end;

procedure TSrdocBtr.WriteCrtDate(pValue:TDatetime);
begin
  oBtrTable.FieldByName('CrtDate').AsDateTime := pValue;
end;

function TSrdocBtr.ReadCrtTime:TDatetime;
begin
  Result := oBtrTable.FieldByName('CrtTime').AsDateTime;
end;

procedure TSrdocBtr.WriteCrtTime(pValue:TDatetime);
begin
  oBtrTable.FieldByName('CrtTime').AsDateTime := pValue;
end;

function TSrdocBtr.ReadModNum:word;
begin
  Result := oBtrTable.FieldByName('ModNum').AsInteger;
end;

procedure TSrdocBtr.WriteModNum(pValue:word);
begin
  oBtrTable.FieldByName('ModNum').AsInteger := pValue;
end;

function TSrdocBtr.ReadModUser:Str8;
begin
  Result := oBtrTable.FieldByName('ModUser').AsString;
end;

procedure TSrdocBtr.WriteModUser(pValue:Str8);
begin
  oBtrTable.FieldByName('ModUser').AsString := pValue;
end;

function TSrdocBtr.ReadModDate:TDatetime;
begin
  Result := oBtrTable.FieldByName('ModDate').AsDateTime;
end;

procedure TSrdocBtr.WriteModDate(pValue:TDatetime);
begin
  oBtrTable.FieldByName('ModDate').AsDateTime := pValue;
end;

function TSrdocBtr.ReadModTime:TDatetime;
begin
  Result := oBtrTable.FieldByName('ModTime').AsDateTime;
end;

procedure TSrdocBtr.WriteModTime(pValue:TDatetime);
begin
  oBtrTable.FieldByName('ModTime').AsDateTime := pValue;
end;

function TSrdocBtr.ReadBegQnt:double;
begin
  Result := oBtrTable.FieldByName('BegQnt').AsFloat;
end;

procedure TSrdocBtr.WriteBegQnt(pValue:double);
begin
  oBtrTable.FieldByName('BegQnt').AsFloat := pValue;
end;

function TSrdocBtr.ReadIncQnt:double;
begin
  Result := oBtrTable.FieldByName('IncQnt').AsFloat;
end;

procedure TSrdocBtr.WriteIncQnt(pValue:double);
begin
  oBtrTable.FieldByName('IncQnt').AsFloat := pValue;
end;

function TSrdocBtr.ReadOutQnt:double;
begin
  Result := oBtrTable.FieldByName('OutQnt').AsFloat;
end;

procedure TSrdocBtr.WriteOutQnt(pValue:double);
begin
  oBtrTable.FieldByName('OutQnt').AsFloat := pValue;
end;

function TSrdocBtr.ReadEndQnt:double;
begin
  Result := oBtrTable.FieldByName('EndQnt').AsFloat;
end;

procedure TSrdocBtr.WriteEndQnt(pValue:double);
begin
  oBtrTable.FieldByName('EndQnt').AsFloat := pValue;
end;

function TSrdocBtr.ReadRepType:Str1;
begin
  Result := oBtrTable.FieldByName('RepType').AsString;
end;

procedure TSrdocBtr.WriteRepType(pValue:Str1);
begin
  oBtrTable.FieldByName('RepType').AsString := pValue;
end;

function TSrdocBtr.ReadSerNum:longint;
begin
  Result := oBtrTable.FieldByName('SerNum').AsInteger;
end;

procedure TSrdocBtr.WriteSerNum(pValue:longint);
begin
  oBtrTable.FieldByName('SerNum').AsInteger := pValue;
end;

// **************************************** PUBLIC ********************************************

function TSrdocBtr.Eof: boolean;
begin
  Result := oBtrTable.Eof;
end;

function TSrdocBtr.IsFirstRec: boolean;
begin
  Result := oBtrTable.Bof;
end;

function TSrdocBtr.IsLastRec: boolean;
begin
  Result := oBtrTable.Eof;
end;

function TSrdocBtr.Active: boolean;
begin
  Result := oBtrTable.Active;
end;

function TSrdocBtr.ActPos: longint;
begin
  Result := oBtrTable.ActPos;
end;

function TSrdocBtr.GotoPos (pActPos:longint): boolean;
begin
  Result := oBtrTable.GotoPos(pActPos);
end;

function TSrdocBtr.LocateMthNum (pMthNum:byte):boolean;
begin
  SetIndex (ixMthNum);
  Result := oBtrTable.FindKey([pMthNum]);
end;

function TSrdocBtr.LocateSerNum (pSerNum:longint):boolean;
begin
  SetIndex (ixSerNum);
  Result := oBtrTable.FindKey([pSerNum]);
end;

function TSrdocBtr.NearestMthNum (pMthNum:byte):boolean;
begin
  SetIndex (ixMthNum);
  Result := oBtrTable.FindNearest([pMthNum]);
end;

function TSrdocBtr.NearestSerNum (pSerNum:longint):boolean;
begin
  SetIndex (ixSerNum);
  Result := oBtrTable.FindNearest([pSerNum]);
end;

procedure TSrdocBtr.SetIndex (pIndexName:ShortString);
begin
  If oBtrTable.IndexName<>pIndexName then oBtrTable.IndexName := pIndexName;
end;

procedure TSrdocBtr.Open;
begin
  oBtrTable.Open;
end;

procedure TSrdocBtr.Close;
begin
  If oBtrTable.Active then oBtrTable.Close;
end;

procedure TSrdocBtr.Prior;
begin
  oBtrTable.Prior;
end;

procedure TSrdocBtr.Next;
begin
  oBtrTable.Next;
end;

procedure TSrdocBtr.First;
begin
  oBtrTable.First;
end;

procedure TSrdocBtr.Last;
begin
  oBtrTable.Last;
end;

procedure TSrdocBtr.Insert;
begin
  oBtrTable.Insert;
end;

procedure TSrdocBtr.Edit;
begin
  oBtrTable.Edit;
end;

procedure TSrdocBtr.Post;
begin
  oBtrTable.Post;
end;

procedure TSrdocBtr.Delete;
begin
  oBtrTable.Delete;
end;

procedure TSrdocBtr.SwapIndex;
begin
  oBtrTable.SwapIndex;
end;

procedure TSrdocBtr.RestoreIndex;
begin
  oBtrTable.RestoreIndex;
end;

procedure TSrdocBtr.SwapStatus;
begin
  oBtrTable.SwapStatus;
end;

procedure TSrdocBtr.RestoreStatus;
begin
  oBtrTable.RestoreStatus;
end;

procedure TSrdocBtr.EnableControls;
begin
  oBtrTable.EnableControls;
end;

procedure TSrdocBtr.DisableControls;
begin
  oBtrTable.DisableControls;
end;

end.
