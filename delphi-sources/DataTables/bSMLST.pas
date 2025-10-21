unit bSMLST;

interface

uses
  IcTypes, IcConv, NexPath, NexGlob,
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls,
  Dialogs, DB, NexBtrTable, DBTables, NexPxTable;

const
  ixSmCode = 'SmCode';
  ixSmName = 'SmName';
  ixSended = 'Sended';

type
  TSmlstBtr = class (TComponent)
    constructor Create; overload;
    destructor  Destroy; override;
  private
    oBtrTable: TNexBtrTable;
    function ReadCount:integer;
    function FieldExist (pFieldName:ShortString): boolean;
    // Pristup k databazovym poliam
    function  ReadSmCode:longint;        procedure WriteSmCode (pValue:longint);
    function  ReadSmName:Str30;          procedure WriteSmName (pValue:Str30);
    function  ReadSmName_:Str30;         procedure WriteSmName_ (pValue:Str30);
    function  ReadSmSign:Str1;           procedure WriteSmSign (pValue:Str1);
    function  ReadAcSign:Str1;           procedure WriteAcSign (pValue:Str1);
    function  ReadCAccSnt:Str3;          procedure WriteCAccSnt (pValue:Str3);
    function  ReadCAccAnl:Str6;          procedure WriteCAccAnl (pValue:Str6);
    function  ReadCAccStk:byte;          procedure WriteCAccStk (pValue:byte);
    function  ReadCAccWri:byte;          procedure WriteCAccWri (pValue:byte);
    function  ReadCAccCen:byte;          procedure WriteCAccCen (pValue:byte);
    function  ReadDAccSnt:Str3;          procedure WriteDAccSnt (pValue:Str3);
    function  ReadDAccAnl:Str6;          procedure WriteDAccAnl (pValue:Str6);
    function  ReadDAccStk:byte;          procedure WriteDAccStk (pValue:byte);
    function  ReadDAccWri:byte;          procedure WriteDAccWri (pValue:byte);
    function  ReadDAccCen:byte;          procedure WriteDAccCen (pValue:byte);
    function  ReadSended:boolean;        procedure WriteSended (pValue:boolean);
    function  ReadModNum:word;           procedure WriteModNum (pValue:word);
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
    function LocateSmCode (pSmCode:longint):boolean;
    function LocateSmName (pSmName_:Str30):boolean;
    function LocateSended (pSended:byte):boolean;
    function NearestSmCode (pSmCode:longint):boolean;
    function NearestSmName (pSmName_:Str30):boolean;
    function NearestSended (pSended:byte):boolean;

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
    property SmCode:longint read ReadSmCode write WriteSmCode;
    property SmName:Str30 read ReadSmName write WriteSmName;
    property SmName_:Str30 read ReadSmName_ write WriteSmName_;
    property SmSign:Str1 read ReadSmSign write WriteSmSign;
    property AcSign:Str1 read ReadAcSign write WriteAcSign;
    property CAccSnt:Str3 read ReadCAccSnt write WriteCAccSnt;
    property CAccAnl:Str6 read ReadCAccAnl write WriteCAccAnl;
    property CAccStk:byte read ReadCAccStk write WriteCAccStk;
    property CAccWri:byte read ReadCAccWri write WriteCAccWri;
    property CAccCen:byte read ReadCAccCen write WriteCAccCen;
    property DAccSnt:Str3 read ReadDAccSnt write WriteDAccSnt;
    property DAccAnl:Str6 read ReadDAccAnl write WriteDAccAnl;
    property DAccStk:byte read ReadDAccStk write WriteDAccStk;
    property DAccWri:byte read ReadDAccWri write WriteDAccWri;
    property DAccCen:byte read ReadDAccCen write WriteDAccCen;
    property Sended:boolean read ReadSended write WriteSended;
    property ModNum:word read ReadModNum write WriteModNum;
    property ModUser:Str8 read ReadModUser write WriteModUser;
    property ModDate:TDatetime read ReadModDate write WriteModDate;
    property ModTime:TDatetime read ReadModTime write WriteModTime;
  end;

implementation

constructor TSmlstBtr.Create;
begin
  oBtrTable := BtrInit ('SMLST',gPath.StkPath,Self);
end;

constructor TSmlstBtr.Create(pPath:ShortString);
begin
  oBtrTable := BtrInit ('SMLST',pPath,Self);
end;

destructor TSmlstBtr.Destroy;
begin
  oBtrTable.Close;  FreeAndNil (oBtrTable);
end;

// *************************************** PRIVATE ********************************************

function TSmlstBtr.ReadCount:integer;
begin
  Result := oBtrTable.RecordCount;
end;

function TSmlstBtr.FieldExist (pFieldName:ShortString): boolean;
begin
  Result := oBtrTable.FindField(pFieldName)<>nil;
end;

function TSmlstBtr.ReadSmCode:longint;
begin
  Result := oBtrTable.FieldByName('SmCode').AsInteger;
end;

procedure TSmlstBtr.WriteSmCode(pValue:longint);
begin
  oBtrTable.FieldByName('SmCode').AsInteger := pValue;
end;

function TSmlstBtr.ReadSmName:Str30;
begin
  Result := oBtrTable.FieldByName('SmName').AsString;
end;

procedure TSmlstBtr.WriteSmName(pValue:Str30);
begin
  oBtrTable.FieldByName('SmName').AsString := pValue;
end;

function TSmlstBtr.ReadSmName_:Str30;
begin
  Result := oBtrTable.FieldByName('SmName_').AsString;
end;

procedure TSmlstBtr.WriteSmName_(pValue:Str30);
begin
  oBtrTable.FieldByName('SmName_').AsString := pValue;
end;

function TSmlstBtr.ReadSmSign:Str1;
begin
  Result := oBtrTable.FieldByName('SmSign').AsString;
end;

procedure TSmlstBtr.WriteSmSign(pValue:Str1);
begin
  oBtrTable.FieldByName('SmSign').AsString := pValue;
end;

function TSmlstBtr.ReadAcSign:Str1;
begin
  Result := oBtrTable.FieldByName('AcSign').AsString;
end;

procedure TSmlstBtr.WriteAcSign(pValue:Str1);
begin
  oBtrTable.FieldByName('AcSign').AsString := pValue;
end;

function TSmlstBtr.ReadCAccSnt:Str3;
begin
  Result := oBtrTable.FieldByName('CAccSnt').AsString;
end;

procedure TSmlstBtr.WriteCAccSnt(pValue:Str3);
begin
  oBtrTable.FieldByName('CAccSnt').AsString := pValue;
end;

function TSmlstBtr.ReadCAccAnl:Str6;
begin
  Result := oBtrTable.FieldByName('CAccAnl').AsString;
end;

procedure TSmlstBtr.WriteCAccAnl(pValue:Str6);
begin
  oBtrTable.FieldByName('CAccAnl').AsString := pValue;
end;

function TSmlstBtr.ReadCAccStk:byte;
begin
  Result := oBtrTable.FieldByName('CAccStk').AsInteger;
end;

procedure TSmlstBtr.WriteCAccStk(pValue:byte);
begin
  oBtrTable.FieldByName('CAccStk').AsInteger := pValue;
end;

function TSmlstBtr.ReadCAccWri:byte;
begin
  Result := oBtrTable.FieldByName('CAccWri').AsInteger;
end;

procedure TSmlstBtr.WriteCAccWri(pValue:byte);
begin
  oBtrTable.FieldByName('CAccWri').AsInteger := pValue;
end;

function TSmlstBtr.ReadCAccCen:byte;
begin
  Result := oBtrTable.FieldByName('CAccCen').AsInteger;
end;

procedure TSmlstBtr.WriteCAccCen(pValue:byte);
begin
  oBtrTable.FieldByName('CAccCen').AsInteger := pValue;
end;

function TSmlstBtr.ReadDAccSnt:Str3;
begin
  Result := oBtrTable.FieldByName('DAccSnt').AsString;
end;

procedure TSmlstBtr.WriteDAccSnt(pValue:Str3);
begin
  oBtrTable.FieldByName('DAccSnt').AsString := pValue;
end;

function TSmlstBtr.ReadDAccAnl:Str6;
begin
  Result := oBtrTable.FieldByName('DAccAnl').AsString;
end;

procedure TSmlstBtr.WriteDAccAnl(pValue:Str6);
begin
  oBtrTable.FieldByName('DAccAnl').AsString := pValue;
end;

function TSmlstBtr.ReadDAccStk:byte;
begin
  Result := oBtrTable.FieldByName('DAccStk').AsInteger;
end;

procedure TSmlstBtr.WriteDAccStk(pValue:byte);
begin
  oBtrTable.FieldByName('DAccStk').AsInteger := pValue;
end;

function TSmlstBtr.ReadDAccWri:byte;
begin
  Result := oBtrTable.FieldByName('DAccWri').AsInteger;
end;

procedure TSmlstBtr.WriteDAccWri(pValue:byte);
begin
  oBtrTable.FieldByName('DAccWri').AsInteger := pValue;
end;

function TSmlstBtr.ReadDAccCen:byte;
begin
  Result := oBtrTable.FieldByName('DAccCen').AsInteger;
end;

procedure TSmlstBtr.WriteDAccCen(pValue:byte);
begin
  oBtrTable.FieldByName('DAccCen').AsInteger := pValue;
end;

function TSmlstBtr.ReadSended:boolean;
begin
  Result := ByteToBool(oBtrTable.FieldByName('Sended').AsInteger);
end;

procedure TSmlstBtr.WriteSended(pValue:boolean);
begin
  oBtrTable.FieldByName('Sended').AsInteger := BoolToByte(pValue);
end;

function TSmlstBtr.ReadModNum:word;
begin
  Result := oBtrTable.FieldByName('ModNum').AsInteger;
end;

procedure TSmlstBtr.WriteModNum(pValue:word);
begin
  oBtrTable.FieldByName('ModNum').AsInteger := pValue;
end;

function TSmlstBtr.ReadModUser:Str8;
begin
  Result := oBtrTable.FieldByName('ModUser').AsString;
end;

procedure TSmlstBtr.WriteModUser(pValue:Str8);
begin
  oBtrTable.FieldByName('ModUser').AsString := pValue;
end;

function TSmlstBtr.ReadModDate:TDatetime;
begin
  Result := oBtrTable.FieldByName('ModDate').AsDateTime;
end;

procedure TSmlstBtr.WriteModDate(pValue:TDatetime);
begin
  oBtrTable.FieldByName('ModDate').AsDateTime := pValue;
end;

function TSmlstBtr.ReadModTime:TDatetime;
begin
  Result := oBtrTable.FieldByName('ModTime').AsDateTime;
end;

procedure TSmlstBtr.WriteModTime(pValue:TDatetime);
begin
  oBtrTable.FieldByName('ModTime').AsDateTime := pValue;
end;

// **************************************** PUBLIC ********************************************

function TSmlstBtr.Eof: boolean;
begin
  Result := oBtrTable.Eof;
end;

function TSmlstBtr.IsFirstRec: boolean;
begin
  Result := oBtrTable.Bof;
end;

function TSmlstBtr.IsLastRec: boolean;
begin
  Result := oBtrTable.Eof;
end;

function TSmlstBtr.Active: boolean;
begin
  Result := oBtrTable.Active;
end;

function TSmlstBtr.ActPos: longint;
begin
  Result := oBtrTable.ActPos;
end;

function TSmlstBtr.GotoPos (pActPos:longint): boolean;
begin
  Result := oBtrTable.GotoPos(pActPos);
end;

function TSmlstBtr.LocateSmCode (pSmCode:longint):boolean;
begin
  SetIndex (ixSmCode);
  Result := oBtrTable.FindKey([pSmCode]);
end;

function TSmlstBtr.LocateSmName (pSmName_:Str30):boolean;
begin
  SetIndex (ixSmName);
  Result := oBtrTable.FindKey([StrToAlias(pSmName_)]);
end;

function TSmlstBtr.LocateSended (pSended:byte):boolean;
begin
  SetIndex (ixSended);
  Result := oBtrTable.FindKey([pSended]);
end;

function TSmlstBtr.NearestSmCode (pSmCode:longint):boolean;
begin
  SetIndex (ixSmCode);
  Result := oBtrTable.FindNearest([pSmCode]);
end;

function TSmlstBtr.NearestSmName (pSmName_:Str30):boolean;
begin
  SetIndex (ixSmName);
  Result := oBtrTable.FindNearest([pSmName_]);
end;

function TSmlstBtr.NearestSended (pSended:byte):boolean;
begin
  SetIndex (ixSended);
  Result := oBtrTable.FindNearest([pSended]);
end;

procedure TSmlstBtr.SetIndex (pIndexName:ShortString);
begin
  If oBtrTable.IndexName<>pIndexName then oBtrTable.IndexName := pIndexName;
end;

procedure TSmlstBtr.Open;
begin
  oBtrTable.Open;
end;

procedure TSmlstBtr.Close;
begin
  If oBtrTable.Active then oBtrTable.Close;
end;

procedure TSmlstBtr.Prior;
begin
  oBtrTable.Prior;
end;

procedure TSmlstBtr.Next;
begin
  oBtrTable.Next;
end;

procedure TSmlstBtr.First;
begin
  oBtrTable.First;
end;

procedure TSmlstBtr.Last;
begin
  oBtrTable.Last;
end;

procedure TSmlstBtr.Insert;
begin
  oBtrTable.Insert;
end;

procedure TSmlstBtr.Edit;
begin
  oBtrTable.Edit;
end;

procedure TSmlstBtr.Post;
begin
  oBtrTable.Post;
end;

procedure TSmlstBtr.Delete;
begin
  oBtrTable.Delete;
end;

procedure TSmlstBtr.SwapIndex;
begin
  oBtrTable.SwapIndex;
end;

procedure TSmlstBtr.RestoreIndex;
begin
  oBtrTable.RestoreIndex;
end;

procedure TSmlstBtr.SwapStatus;
begin
  oBtrTable.SwapStatus;
end;

procedure TSmlstBtr.RestoreStatus;
begin
  oBtrTable.RestoreStatus;
end;

procedure TSmlstBtr.EnableControls;
begin
  oBtrTable.EnableControls;
end;

procedure TSmlstBtr.DisableControls;
begin
  oBtrTable.DisableControls;
end;

end.
