unit tPQH;

interface

uses
  IcTypes, IcConv, NexPath, NexGlob, DocHand, 
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls,
  Dialogs, DB, NexBtrTable, DBTables, NexPxTable;

const
  ixDocNum = '';
  ixSerNum = 'SerNum';
  ixDocDate = 'DocDate';
  ixDocVal = 'DocVal';

type
  TPqhTmp = class (TComponent)
    constructor Create;
    destructor  Destroy; override;
  private
    oTmpTable: TNexPxTable;
    function ReadCount:integer;
    function FieldExist (pFieldName:ShortString): boolean;
    // Pristup k databazovym poliam
    function  ReadDocNum:Str12;          procedure WriteDocNum (pValue:Str12);
    function  ReadYear:Str2;             procedure WriteYear (pValue:Str2);
    function  ReadSerNum:longint;        procedure WriteSerNum (pValue:longint);
    function  ReadDocDate:TDatetime;     procedure WriteDocDate (pValue:TDatetime);
    function  ReadDocVal:double;         procedure WriteDocVal (pValue:double);
    function  ReadCrtUser:Str8;          procedure WriteCrtUser (pValue:Str8);
    function  ReadCrtDate:TDatetime;     procedure WriteCrtDate (pValue:TDatetime);
    function  ReadCrtTime:TDatetime;     procedure WriteCrtTime (pValue:TDatetime);
    function  ReadModUser:Str8;          procedure WriteModUser (pValue:Str8);
    function  ReadModDate:TDatetime;     procedure WriteModDate (pValue:TDatetime);
    function  ReadModTime:TDatetime;     procedure WriteModTime (pValue:TDatetime);
    function  ReadItmQnt:word;           procedure WriteItmQnt (pValue:word);
    function  ReadPrnCnt:byte;           procedure WritePrnCnt (pValue:byte);
    function  ReadAboStat:Str1;          procedure WriteAboStat (pValue:Str1);
    function  ReadAboDate:TDatetime;     procedure WriteAboDate (pValue:TDatetime);
    function  ReadAboTime:TDatetime;     procedure WriteAboTime (pValue:TDatetime);
  public
    // Elementarne databazove operacie
    function Eof: boolean;
    function Active: boolean;
    function LocateDocNum (pDocNum:Str12):boolean;
    function LocateSerNum (pSerNum:longint):boolean;
    function LocateDocDate (pDocDate:TDatetime):boolean;
    function LocateDocVal (pDocVal:double):boolean;

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
    procedure DisableControls;
    procedure EnableControls;
  published
    property TmpTable:TNexPxTable read oTmpTable write oTmpTable;
    property Count:integer read ReadCount;
    property DocNum:Str12 read ReadDocNum write WriteDocNum;
    property Year:Str2 read ReadYear write WriteYear;
    property SerNum:longint read ReadSerNum write WriteSerNum;
    property DocDate:TDatetime read ReadDocDate write WriteDocDate;
    property DocVal:double read ReadDocVal write WriteDocVal;
    property CrtUser:Str8 read ReadCrtUser write WriteCrtUser;
    property CrtDate:TDatetime read ReadCrtDate write WriteCrtDate;
    property CrtTime:TDatetime read ReadCrtTime write WriteCrtTime;
    property ModUser:Str8 read ReadModUser write WriteModUser;
    property ModDate:TDatetime read ReadModDate write WriteModDate;
    property ModTime:TDatetime read ReadModTime write WriteModTime;
    property ItmQnt:word read ReadItmQnt write WriteItmQnt;
    property PrnCnt:byte read ReadPrnCnt write WritePrnCnt;
    property AboStat:Str1 read ReadAboStat write WriteAboStat;
    property AboDate:TDatetime read ReadAboDate write WriteAboDate;
    property AboTime:TDatetime read ReadAboTime write WriteAboTime;
  end;

implementation

constructor TPqhTmp.Create;
begin
  oTmpTable := TmpInit ('PQH',Self);
end;

destructor TPqhTmp.Destroy;
begin
  If oTmpTable.Active then oTmpTable.Close;
  FreeAndNil (oTmpTable);
end;

// *************************************** PRIVATE ********************************************

function TPqhTmp.ReadCount:integer;
begin
  Result := oTmpTable.RecordCount;
end;

function TPqhTmp.FieldExist (pFieldName:ShortString): boolean;
begin
  Result := oTmpTable.FindField(pFieldName)<>nil;
end;

function TPqhTmp.ReadDocNum:Str12;
begin
  Result := oTmpTable.FieldByName('DocNum').AsString;
end;

procedure TPqhTmp.WriteDocNum(pValue:Str12);
begin
  oTmpTable.FieldByName('DocNum').AsString := pValue;
end;

function TPqhTmp.ReadYear:Str2;
begin
  Result := oTmpTable.FieldByName('Year').AsString;
end;

procedure TPqhTmp.WriteYear(pValue:Str2);
begin
  oTmpTable.FieldByName('Year').AsString := pValue;
end;

function TPqhTmp.ReadSerNum:longint;
begin
  Result := oTmpTable.FieldByName('SerNum').AsInteger;
end;

procedure TPqhTmp.WriteSerNum(pValue:longint);
begin
  oTmpTable.FieldByName('SerNum').AsInteger := pValue;
end;

function TPqhTmp.ReadDocDate:TDatetime;
begin
  Result := oTmpTable.FieldByName('DocDate').AsDateTime;
end;

procedure TPqhTmp.WriteDocDate(pValue:TDatetime);
begin
  oTmpTable.FieldByName('DocDate').AsDateTime := pValue;
end;

function TPqhTmp.ReadDocVal:double;
begin
  Result := oTmpTable.FieldByName('DocVal').AsFloat;
end;

procedure TPqhTmp.WriteDocVal(pValue:double);
begin
  oTmpTable.FieldByName('DocVal').AsFloat := pValue;
end;

function TPqhTmp.ReadCrtUser:Str8;
begin
  Result := oTmpTable.FieldByName('CrtUser').AsString;
end;

procedure TPqhTmp.WriteCrtUser(pValue:Str8);
begin
  oTmpTable.FieldByName('CrtUser').AsString := pValue;
end;

function TPqhTmp.ReadCrtDate:TDatetime;
begin
  Result := oTmpTable.FieldByName('CrtDate').AsDateTime;
end;

procedure TPqhTmp.WriteCrtDate(pValue:TDatetime);
begin
  oTmpTable.FieldByName('CrtDate').AsDateTime := pValue;
end;

function TPqhTmp.ReadCrtTime:TDatetime;
begin
  Result := oTmpTable.FieldByName('CrtTime').AsDateTime;
end;

procedure TPqhTmp.WriteCrtTime(pValue:TDatetime);
begin
  oTmpTable.FieldByName('CrtTime').AsDateTime := pValue;
end;

function TPqhTmp.ReadModUser:Str8;
begin
  Result := oTmpTable.FieldByName('ModUser').AsString;
end;

procedure TPqhTmp.WriteModUser(pValue:Str8);
begin
  oTmpTable.FieldByName('ModUser').AsString := pValue;
end;

function TPqhTmp.ReadModDate:TDatetime;
begin
  Result := oTmpTable.FieldByName('ModDate').AsDateTime;
end;

procedure TPqhTmp.WriteModDate(pValue:TDatetime);
begin
  oTmpTable.FieldByName('ModDate').AsDateTime := pValue;
end;

function TPqhTmp.ReadModTime:TDatetime;
begin
  Result := oTmpTable.FieldByName('ModTime').AsDateTime;
end;

procedure TPqhTmp.WriteModTime(pValue:TDatetime);
begin
  oTmpTable.FieldByName('ModTime').AsDateTime := pValue;
end;

function TPqhTmp.ReadItmQnt:word;
begin
  Result := oTmpTable.FieldByName('ItmQnt').AsInteger;
end;

procedure TPqhTmp.WriteItmQnt(pValue:word);
begin
  oTmpTable.FieldByName('ItmQnt').AsInteger := pValue;
end;

function TPqhTmp.ReadPrnCnt:byte;
begin
  Result := oTmpTable.FieldByName('PrnCnt').AsInteger;
end;

procedure TPqhTmp.WritePrnCnt(pValue:byte);
begin
  oTmpTable.FieldByName('PrnCnt').AsInteger := pValue;
end;

function TPqhTmp.ReadAboStat:Str1;
begin
  Result := oTmpTable.FieldByName('AboStat').AsString;
end;

procedure TPqhTmp.WriteAboStat(pValue:Str1);
begin
  oTmpTable.FieldByName('AboStat').AsString := pValue;
end;

function TPqhTmp.ReadAboDate:TDatetime;
begin
  Result := oTmpTable.FieldByName('AboDate').AsDateTime;
end;

procedure TPqhTmp.WriteAboDate(pValue:TDatetime);
begin
  oTmpTable.FieldByName('AboDate').AsDateTime := pValue;
end;

function TPqhTmp.ReadAboTime:TDatetime;
begin
  Result := oTmpTable.FieldByName('AboTime').AsDateTime;
end;

procedure TPqhTmp.WriteAboTime(pValue:TDatetime);
begin
  oTmpTable.FieldByName('AboTime').AsDateTime := pValue;
end;

// **************************************** PUBLIC ********************************************

function TPqhTmp.Eof: boolean;
begin
  Result := oTmpTable.Eof;
end;

function TPqhTmp.Active: boolean;
begin
  Result := oTmpTable.Active;
end;

function TPqhTmp.LocateDocNum (pDocNum:Str12):boolean;
begin
  SetIndex (ixDocNum);
  Result := oTmpTable.FindKey([pDocNum]);
end;

function TPqhTmp.LocateSerNum (pSerNum:longint):boolean;
begin
  SetIndex (ixSerNum);
  Result := oTmpTable.FindKey([pSerNum]);
end;

function TPqhTmp.LocateDocDate (pDocDate:TDatetime):boolean;
begin
  SetIndex (ixDocDate);
  Result := oTmpTable.FindKey([pDocDate]);
end;

function TPqhTmp.LocateDocVal (pDocVal:double):boolean;
begin
  SetIndex (ixDocVal);
  Result := oTmpTable.FindKey([pDocVal]);
end;

procedure TPqhTmp.SetIndex (pIndexName:ShortString);
begin
  If oTmpTable.IndexName<>pIndexName then oTmpTable.IndexName := pIndexName;
end;

procedure TPqhTmp.Open;
begin
  oTmpTable.Open;
end;

procedure TPqhTmp.Close;
begin
  If oTmpTable.Active then oTmpTable.Close;
end;

procedure TPqhTmp.Prior;
begin
  oTmpTable.Prior;
end;

procedure TPqhTmp.Next;
begin
  oTmpTable.Next;
end;

procedure TPqhTmp.First;
begin
  oTmpTable.First;
end;

procedure TPqhTmp.Last;
begin
  oTmpTable.Last;
end;

procedure TPqhTmp.Insert;
begin
  oTmpTable.Insert;
end;

procedure TPqhTmp.Edit;
begin
  oTmpTable.Edit;
end;

procedure TPqhTmp.Post;
var mEdit:boolean;
begin
  oTmpTable.Post;
end;

procedure TPqhTmp.Delete;
begin
  oTmpTable.Delete;
end;

procedure TPqhTmp.SwapIndex;
begin
  oTmpTable.SwapIndex;
end;

procedure TPqhTmp.RestoreIndex;
begin
  oTmpTable.RestoreIndex;
end;

procedure TPqhTmp.SwapStatus;
begin
  oTmpTable.SwapStatus;
end;

procedure TPqhTmp.RestoreStatus;
begin
  oTmpTable.RestoreStatus;
end;

procedure TPqhTmp.EnableControls;
begin
  oTmpTable.EnableControls;
end;

procedure TPqhTmp.DisableControls;
begin
  oTmpTable.DisableControls;
end;

end.
