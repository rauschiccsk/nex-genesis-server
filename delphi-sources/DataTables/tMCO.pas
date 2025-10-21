unit tMCO;

interface

uses
  IcTypes, IcConv, NexPath, NexGlob, DocHand, 
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls,
  Dialogs, DB, NexBtrTable, DBTables, NexPxTable;

const
  ixRowNum = '';

type
  TMcoTmp = class (TComponent)
    constructor Create;
    destructor  Destroy; override;
  private
    oTmpTable: TNexPxTable;
    function ReadCount:integer;
    function FieldExist (pFieldName:ShortString): boolean;
    // Pristup k databazovym poliam
    function  ReadRowNum:longint;        procedure WriteRowNum (pValue:longint);
    function  ReadOcdNum:Str12;          procedure WriteOcdNum (pValue:Str12);
    function  ReadOcdItm:word;           procedure WriteOcdItm (pValue:word);
    function  ReadOcdDat:TDatetime;      procedure WriteOcdDat (pValue:TDatetime);
    function  ReadGsCode:longint;        procedure WriteGsCode (pValue:longint);
    function  ReadDlvQnt:double;         procedure WriteDlvQnt (pValue:double);
    function  ReadCrtUser:Str8;          procedure WriteCrtUser (pValue:Str8);
    function  ReadCrtDate:TDatetime;     procedure WriteCrtDate (pValue:TDatetime);
    function  ReadCrtTime:TDatetime;     procedure WriteCrtTime (pValue:TDatetime);
  public
    // Elementarne databazove operacie
    function Eof: boolean;
    function Active: boolean;
    function LocateRowNum (pRowNum:longint):boolean;

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
    property RowNum:longint read ReadRowNum write WriteRowNum;
    property OcdNum:Str12 read ReadOcdNum write WriteOcdNum;
    property OcdItm:word read ReadOcdItm write WriteOcdItm;
    property OcdDat:TDatetime read ReadOcdDat write WriteOcdDat;
    property GsCode:longint read ReadGsCode write WriteGsCode;
    property DlvQnt:double read ReadDlvQnt write WriteDlvQnt;
    property CrtUser:Str8 read ReadCrtUser write WriteCrtUser;
    property CrtDate:TDatetime read ReadCrtDate write WriteCrtDate;
    property CrtTime:TDatetime read ReadCrtTime write WriteCrtTime;
  end;

implementation

constructor TMcoTmp.Create;
begin
  oTmpTable := TmpInit ('MCO',Self);
end;

destructor TMcoTmp.Destroy;
begin
  If oTmpTable.Active then oTmpTable.Close;
  FreeAndNil (oTmpTable);
end;

// *************************************** PRIVATE ********************************************

function TMcoTmp.ReadCount:integer;
begin
  Result := oTmpTable.RecordCount;
end;

function TMcoTmp.FieldExist (pFieldName:ShortString): boolean;
begin
  Result := oTmpTable.FindField(pFieldName)<>nil;
end;

function TMcoTmp.ReadRowNum:longint;
begin
  Result := oTmpTable.FieldByName('RowNum').AsInteger;
end;

procedure TMcoTmp.WriteRowNum(pValue:longint);
begin
  oTmpTable.FieldByName('RowNum').AsInteger := pValue;
end;

function TMcoTmp.ReadOcdNum:Str12;
begin
  Result := oTmpTable.FieldByName('OcdNum').AsString;
end;

procedure TMcoTmp.WriteOcdNum(pValue:Str12);
begin
  oTmpTable.FieldByName('OcdNum').AsString := pValue;
end;

function TMcoTmp.ReadOcdItm:word;
begin
  Result := oTmpTable.FieldByName('OcdItm').AsInteger;
end;

procedure TMcoTmp.WriteOcdItm(pValue:word);
begin
  oTmpTable.FieldByName('OcdItm').AsInteger := pValue;
end;

function TMcoTmp.ReadOcdDat:TDatetime;
begin
  Result := oTmpTable.FieldByName('OcdDat').AsDateTime;
end;

procedure TMcoTmp.WriteOcdDat(pValue:TDatetime);
begin
  oTmpTable.FieldByName('OcdDat').AsDateTime := pValue;
end;

function TMcoTmp.ReadGsCode:longint;
begin
  Result := oTmpTable.FieldByName('GsCode').AsInteger;
end;

procedure TMcoTmp.WriteGsCode(pValue:longint);
begin
  oTmpTable.FieldByName('GsCode').AsInteger := pValue;
end;

function TMcoTmp.ReadDlvQnt:double;
begin
  Result := oTmpTable.FieldByName('DlvQnt').AsFloat;
end;

procedure TMcoTmp.WriteDlvQnt(pValue:double);
begin
  oTmpTable.FieldByName('DlvQnt').AsFloat := pValue;
end;

function TMcoTmp.ReadCrtUser:Str8;
begin
  Result := oTmpTable.FieldByName('CrtUser').AsString;
end;

procedure TMcoTmp.WriteCrtUser(pValue:Str8);
begin
  oTmpTable.FieldByName('CrtUser').AsString := pValue;
end;

function TMcoTmp.ReadCrtDate:TDatetime;
begin
  Result := oTmpTable.FieldByName('CrtDate').AsDateTime;
end;

procedure TMcoTmp.WriteCrtDate(pValue:TDatetime);
begin
  oTmpTable.FieldByName('CrtDate').AsDateTime := pValue;
end;

function TMcoTmp.ReadCrtTime:TDatetime;
begin
  Result := oTmpTable.FieldByName('CrtTime').AsDateTime;
end;

procedure TMcoTmp.WriteCrtTime(pValue:TDatetime);
begin
  oTmpTable.FieldByName('CrtTime').AsDateTime := pValue;
end;

// **************************************** PUBLIC ********************************************

function TMcoTmp.Eof: boolean;
begin
  Result := oTmpTable.Eof;
end;

function TMcoTmp.Active: boolean;
begin
  Result := oTmpTable.Active;
end;

function TMcoTmp.LocateRowNum (pRowNum:longint):boolean;
begin
  SetIndex (ixRowNum);
  Result := oTmpTable.FindKey([pRowNum]);
end;

procedure TMcoTmp.SetIndex (pIndexName:ShortString);
begin
  If oTmpTable.IndexName<>pIndexName then oTmpTable.IndexName := pIndexName;
end;

procedure TMcoTmp.Open;
begin
  oTmpTable.Open;
end;

procedure TMcoTmp.Close;
begin
  If oTmpTable.Active then oTmpTable.Close;
end;

procedure TMcoTmp.Prior;
begin
  oTmpTable.Prior;
end;

procedure TMcoTmp.Next;
begin
  oTmpTable.Next;
end;

procedure TMcoTmp.First;
begin
  oTmpTable.First;
end;

procedure TMcoTmp.Last;
begin
  oTmpTable.Last;
end;

procedure TMcoTmp.Insert;
begin
  oTmpTable.Insert;
end;

procedure TMcoTmp.Edit;
begin
  oTmpTable.Edit;
end;

procedure TMcoTmp.Post;
var mEdit:boolean;
begin
  oTmpTable.Post;
end;

procedure TMcoTmp.Delete;
begin
  oTmpTable.Delete;
end;

procedure TMcoTmp.SwapIndex;
begin
  oTmpTable.SwapIndex;
end;

procedure TMcoTmp.RestoreIndex;
begin
  oTmpTable.RestoreIndex;
end;

procedure TMcoTmp.SwapStatus;
begin
  oTmpTable.SwapStatus;
end;

procedure TMcoTmp.RestoreStatus;
begin
  oTmpTable.RestoreStatus;
end;

procedure TMcoTmp.EnableControls;
begin
  oTmpTable.EnableControls;
end;

procedure TMcoTmp.DisableControls;
begin
  oTmpTable.DisableControls;
end;

end.
{MOD 1930001}
