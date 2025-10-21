unit tPKH;

interface

uses
  IcTypes, IcConv, NexPath, NexGlob, DocHand, 
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls,
  Dialogs, DB, NexBtrTable, DBTables, NexPxTable;

const
  ixStYnSn = '';
  ixSerNum = 'SerNum';
  ixDocNum = 'DocNum';
  ixDocDate = 'DocDate';
  ixOcdNum = 'OcdNum';
  ixSended = 'Sended';

type
  TPkhTmp = class (TComponent)
    constructor Create;
    destructor  Destroy; override;
  private
    oTmpTable: TNexPxTable;
    function ReadCount:integer;
    function FieldExist (pFieldName:ShortString): boolean;
    // Pristup k databazovym poliam
    function  ReadStkNum:word;           procedure WriteStkNum (pValue:word);
    function  ReadYear:Str2;             procedure WriteYear (pValue:Str2);
    function  ReadSerNum:longint;        procedure WriteSerNum (pValue:longint);
    function  ReadDocNum:Str12;          procedure WriteDocNum (pValue:Str12);
    function  ReadDescribe:Str30;        procedure WriteDescribe (pValue:Str30);
    function  ReadDocDate:TDatetime;     procedure WriteDocDate (pValue:TDatetime);
    function  ReadSndStat:Str1;          procedure WriteSndStat (pValue:Str1);
    function  ReadSended:boolean;        procedure WriteSended (pValue:boolean);
    function  ReadDstStk:Str1;           procedure WriteDstStk (pValue:Str1);
    function  ReadItmQnt:word;           procedure WriteItmQnt (pValue:word);
    function  ReadDstLck:byte;           procedure WriteDstLck (pValue:byte);
    function  ReadCrtUser:Str8;          procedure WriteCrtUser (pValue:Str8);
    function  ReadCrtDate:TDatetime;     procedure WriteCrtDate (pValue:TDatetime);
    function  ReadCrtTime:TDatetime;     procedure WriteCrtTime (pValue:TDatetime);
    function  ReadModUser:Str8;          procedure WriteModUser (pValue:Str8);
    function  ReadModDate:TDatetime;     procedure WriteModDate (pValue:TDatetime);
    function  ReadModTime:TDatetime;     procedure WriteModTime (pValue:TDatetime);
    function  ReadOcdNum:Str20;          procedure WriteOcdNum (pValue:Str20);
    function  ReadActPos:longint;        procedure WriteActPos (pValue:longint);
    function  ReadScSmCode:word;         procedure WriteScSmCode (pValue:word);
    function  ReadTgSmCode:word;         procedure WriteTgSmCode (pValue:word);
  public
    // Elementarne databazove operacie
    function Eof: boolean;
    function Active: boolean;
    function LocateStYnSn (pStkNum:word;pYear:Str2;pSerNum:longint):boolean;
    function LocateSerNum (pSerNum:longint):boolean;
    function LocateDocNum (pDocNum:Str12):boolean;
    function LocateDocDate (pDocDate:TDatetime):boolean;
    function LocateOcdNum (pOcdNum:Str20):boolean;
    function LocateSended (pSended:byte):boolean;

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
    property StkNum:word read ReadStkNum write WriteStkNum;
    property Year:Str2 read ReadYear write WriteYear;
    property SerNum:longint read ReadSerNum write WriteSerNum;
    property DocNum:Str12 read ReadDocNum write WriteDocNum;
    property Describe:Str30 read ReadDescribe write WriteDescribe;
    property DocDate:TDatetime read ReadDocDate write WriteDocDate;
    property SndStat:Str1 read ReadSndStat write WriteSndStat;
    property Sended:boolean read ReadSended write WriteSended;
    property DstStk:Str1 read ReadDstStk write WriteDstStk;
    property ItmQnt:word read ReadItmQnt write WriteItmQnt;
    property DstLck:byte read ReadDstLck write WriteDstLck;
    property CrtUser:Str8 read ReadCrtUser write WriteCrtUser;
    property CrtDate:TDatetime read ReadCrtDate write WriteCrtDate;
    property CrtTime:TDatetime read ReadCrtTime write WriteCrtTime;
    property ModUser:Str8 read ReadModUser write WriteModUser;
    property ModDate:TDatetime read ReadModDate write WriteModDate;
    property ModTime:TDatetime read ReadModTime write WriteModTime;
    property OcdNum:Str20 read ReadOcdNum write WriteOcdNum;
    property ActPos:longint read ReadActPos write WriteActPos;
    property ScSmCode:word read ReadScSmCode write WriteScSmCode;
    property TgSmCode:word read ReadTgSmCode write WriteTgSmCode;
  end;

implementation

constructor TPkhTmp.Create;
begin
  oTmpTable := TmpInit ('PKH',Self);
end;

destructor TPkhTmp.Destroy;
begin
  If oTmpTable.Active then oTmpTable.Close;
  FreeAndNil (oTmpTable);
end;

// *************************************** PRIVATE ********************************************

function TPkhTmp.ReadCount:integer;
begin
  Result := oTmpTable.RecordCount;
end;

function TPkhTmp.FieldExist (pFieldName:ShortString): boolean;
begin
  Result := oTmpTable.FindField(pFieldName)<>nil;
end;

function TPkhTmp.ReadStkNum:word;
begin
  Result := oTmpTable.FieldByName('StkNum').AsInteger;
end;

procedure TPkhTmp.WriteStkNum(pValue:word);
begin
  oTmpTable.FieldByName('StkNum').AsInteger := pValue;
end;

function TPkhTmp.ReadYear:Str2;
begin
  Result := oTmpTable.FieldByName('Year').AsString;
end;

procedure TPkhTmp.WriteYear(pValue:Str2);
begin
  oTmpTable.FieldByName('Year').AsString := pValue;
end;

function TPkhTmp.ReadSerNum:longint;
begin
  Result := oTmpTable.FieldByName('SerNum').AsInteger;
end;

procedure TPkhTmp.WriteSerNum(pValue:longint);
begin
  oTmpTable.FieldByName('SerNum').AsInteger := pValue;
end;

function TPkhTmp.ReadDocNum:Str12;
begin
  Result := oTmpTable.FieldByName('DocNum').AsString;
end;

procedure TPkhTmp.WriteDocNum(pValue:Str12);
begin
  oTmpTable.FieldByName('DocNum').AsString := pValue;
end;

function TPkhTmp.ReadDescribe:Str30;
begin
  Result := oTmpTable.FieldByName('Describe').AsString;
end;

procedure TPkhTmp.WriteDescribe(pValue:Str30);
begin
  oTmpTable.FieldByName('Describe').AsString := pValue;
end;

function TPkhTmp.ReadDocDate:TDatetime;
begin
  Result := oTmpTable.FieldByName('DocDate').AsDateTime;
end;

procedure TPkhTmp.WriteDocDate(pValue:TDatetime);
begin
  oTmpTable.FieldByName('DocDate').AsDateTime := pValue;
end;

function TPkhTmp.ReadSndStat:Str1;
begin
  Result := oTmpTable.FieldByName('SndStat').AsString;
end;

procedure TPkhTmp.WriteSndStat(pValue:Str1);
begin
  oTmpTable.FieldByName('SndStat').AsString := pValue;
end;

function TPkhTmp.ReadSended:boolean;
begin
  Result := ByteToBool(oTmpTable.FieldByName('Sended').AsInteger);
end;

procedure TPkhTmp.WriteSended(pValue:boolean);
begin
  oTmpTable.FieldByName('Sended').AsInteger := BoolToByte(pValue);
end;

function TPkhTmp.ReadDstStk:Str1;
begin
  Result := oTmpTable.FieldByName('DstStk').AsString;
end;

procedure TPkhTmp.WriteDstStk(pValue:Str1);
begin
  oTmpTable.FieldByName('DstStk').AsString := pValue;
end;

function TPkhTmp.ReadItmQnt:word;
begin
  Result := oTmpTable.FieldByName('ItmQnt').AsInteger;
end;

procedure TPkhTmp.WriteItmQnt(pValue:word);
begin
  oTmpTable.FieldByName('ItmQnt').AsInteger := pValue;
end;

function TPkhTmp.ReadDstLck:byte;
begin
  Result := oTmpTable.FieldByName('DstLck').AsInteger;
end;

procedure TPkhTmp.WriteDstLck(pValue:byte);
begin
  oTmpTable.FieldByName('DstLck').AsInteger := pValue;
end;

function TPkhTmp.ReadCrtUser:Str8;
begin
  Result := oTmpTable.FieldByName('CrtUser').AsString;
end;

procedure TPkhTmp.WriteCrtUser(pValue:Str8);
begin
  oTmpTable.FieldByName('CrtUser').AsString := pValue;
end;

function TPkhTmp.ReadCrtDate:TDatetime;
begin
  Result := oTmpTable.FieldByName('CrtDate').AsDateTime;
end;

procedure TPkhTmp.WriteCrtDate(pValue:TDatetime);
begin
  oTmpTable.FieldByName('CrtDate').AsDateTime := pValue;
end;

function TPkhTmp.ReadCrtTime:TDatetime;
begin
  Result := oTmpTable.FieldByName('CrtTime').AsDateTime;
end;

procedure TPkhTmp.WriteCrtTime(pValue:TDatetime);
begin
  oTmpTable.FieldByName('CrtTime').AsDateTime := pValue;
end;

function TPkhTmp.ReadModUser:Str8;
begin
  Result := oTmpTable.FieldByName('ModUser').AsString;
end;

procedure TPkhTmp.WriteModUser(pValue:Str8);
begin
  oTmpTable.FieldByName('ModUser').AsString := pValue;
end;

function TPkhTmp.ReadModDate:TDatetime;
begin
  Result := oTmpTable.FieldByName('ModDate').AsDateTime;
end;

procedure TPkhTmp.WriteModDate(pValue:TDatetime);
begin
  oTmpTable.FieldByName('ModDate').AsDateTime := pValue;
end;

function TPkhTmp.ReadModTime:TDatetime;
begin
  Result := oTmpTable.FieldByName('ModTime').AsDateTime;
end;

procedure TPkhTmp.WriteModTime(pValue:TDatetime);
begin
  oTmpTable.FieldByName('ModTime').AsDateTime := pValue;
end;

function TPkhTmp.ReadOcdNum:Str20;
begin
  Result := oTmpTable.FieldByName('OcdNum').AsString;
end;

procedure TPkhTmp.WriteOcdNum(pValue:Str20);
begin
  oTmpTable.FieldByName('OcdNum').AsString := pValue;
end;

function TPkhTmp.ReadActPos:longint;
begin
  Result := oTmpTable.FieldByName('ActPos').AsInteger;
end;

procedure TPkhTmp.WriteActPos(pValue:longint);
begin
  oTmpTable.FieldByName('ActPos').AsInteger := pValue;
end;

function TPkhTmp.ReadScSmCode:word;
begin
  Result := oTmpTable.FieldByName('ScSmCode').AsInteger;
end;

procedure TPkhTmp.WriteScSmCode(pValue:word);
begin
  oTmpTable.FieldByName('ScSmCode').AsInteger := pValue;
end;

function TPkhTmp.ReadTgSmCode:word;
begin
  Result := oTmpTable.FieldByName('TgSmCode').AsInteger;
end;

procedure TPkhTmp.WriteTgSmCode(pValue:word);
begin
  oTmpTable.FieldByName('TgSmCode').AsInteger := pValue;
end;

// **************************************** PUBLIC ********************************************

function TPkhTmp.Eof: boolean;
begin
  Result := oTmpTable.Eof;
end;

function TPkhTmp.Active: boolean;
begin
  Result := oTmpTable.Active;
end;

function TPkhTmp.LocateStYnSn (pStkNum:word;pYear:Str2;pSerNum:longint):boolean;
begin
  SetIndex (ixStYnSn);
  Result := oTmpTable.FindKey([pStkNum,pYear,pSerNum]);
end;

function TPkhTmp.LocateSerNum (pSerNum:longint):boolean;
begin
  SetIndex (ixSerNum);
  Result := oTmpTable.FindKey([pSerNum]);
end;

function TPkhTmp.LocateDocNum (pDocNum:Str12):boolean;
begin
  SetIndex (ixDocNum);
  Result := oTmpTable.FindKey([pDocNum]);
end;

function TPkhTmp.LocateDocDate (pDocDate:TDatetime):boolean;
begin
  SetIndex (ixDocDate);
  Result := oTmpTable.FindKey([pDocDate]);
end;

function TPkhTmp.LocateOcdNum (pOcdNum:Str20):boolean;
begin
  SetIndex (ixOcdNum);
  Result := oTmpTable.FindKey([pOcdNum]);
end;

function TPkhTmp.LocateSended (pSended:byte):boolean;
begin
  SetIndex (ixSended);
  Result := oTmpTable.FindKey([pSended]);
end;

procedure TPkhTmp.SetIndex (pIndexName:ShortString);
begin
  If oTmpTable.IndexName<>pIndexName then oTmpTable.IndexName := pIndexName;
end;

procedure TPkhTmp.Open;
begin
  oTmpTable.Open;
end;

procedure TPkhTmp.Close;
begin
  If oTmpTable.Active then oTmpTable.Close;
end;

procedure TPkhTmp.Prior;
begin
  oTmpTable.Prior;
end;

procedure TPkhTmp.Next;
begin
  oTmpTable.Next;
end;

procedure TPkhTmp.First;
begin
  oTmpTable.First;
end;

procedure TPkhTmp.Last;
begin
  oTmpTable.Last;
end;

procedure TPkhTmp.Insert;
begin
  oTmpTable.Insert;
end;

procedure TPkhTmp.Edit;
begin
  oTmpTable.Edit;
end;

procedure TPkhTmp.Post;
var mEdit:boolean;
begin
  oTmpTable.Post;
end;

procedure TPkhTmp.Delete;
begin
  oTmpTable.Delete;
end;

procedure TPkhTmp.SwapIndex;
begin
  oTmpTable.SwapIndex;
end;

procedure TPkhTmp.RestoreIndex;
begin
  oTmpTable.RestoreIndex;
end;

procedure TPkhTmp.SwapStatus;
begin
  oTmpTable.SwapStatus;
end;

procedure TPkhTmp.RestoreStatus;
begin
  oTmpTable.RestoreStatus;
end;

procedure TPkhTmp.EnableControls;
begin
  oTmpTable.EnableControls;
end;

procedure TPkhTmp.DisableControls;
begin
  oTmpTable.DisableControls;
end;

end.
