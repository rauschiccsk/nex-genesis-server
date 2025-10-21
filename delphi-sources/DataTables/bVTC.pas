unit bVTC;

interface

uses
  IcTypes, IcConv, NexPath, NexGlob,
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls,
  Dialogs, DB, NexBtrTable, DBTables, NexPxTable;

const
  ixRowNum = 'RowNum';

type
  TVtcBtr = class (TComponent)
    constructor Create; overload;
    destructor  Destroy; override;
  private
    oBookNum: Str5;
    oBtrTable: TNexBtrTable;
    function ReadCount:integer;
    function FieldExist (pFieldName:ShortString): boolean;
    // Pristup k databazovym poliam
    function  ReadRowNum:Str5;           procedure WriteRowNum (pValue:Str5);
    function  ReadDescribe:Str150;       procedure WriteDescribe (pValue:Str150);
    function  ReadRowType:Str1;          procedure WriteRowType (pValue:Str1);
    function  ReadValType:Str1;          procedure WriteValType (pValue:Str1);
    function  ReadPozVal:byte;           procedure WritePozVal (pValue:byte);
    function  ReadNegVal:byte;           procedure WriteNegVal (pValue:byte);
    function  ReadCalcul:Str200;         procedure WriteCalcul (pValue:Str200);
    function  ReadCrtUser:Str8;          procedure WriteCrtUser (pValue:Str8);
    function  ReadCrtDate:TDatetime;     procedure WriteCrtDate (pValue:TDatetime);
    function  ReadCrtTime:TDatetime;     procedure WriteCrtTime (pValue:TDatetime);
    function  ReadModUser:Str8;          procedure WriteModUser (pValue:Str8);
    function  ReadModDate:TDatetime;     procedure WriteModDate (pValue:TDatetime);
    function  ReadModTime:TDatetime;     procedure WriteModTime (pValue:TDatetime);
    function  ReadVatGrp:byte;           procedure WriteVatGrp (pValue:byte);
    function  ReadVatPrcLst:Str30;       procedure WriteVatPrcLst (pValue:Str30);
  public
    constructor Create(pPath:ShortString); overload;
    // Elementarne databazove operacie
    function Eof: boolean;
    function IsFirstRec: boolean;
    function IsLastRec: boolean;
    function Active: boolean;
    function ActPos: longint;
    function GotoPos (pActPos:longint): boolean;
    function LocateRowNum (pRowNum:Str5):boolean;
    function NearestRowNum (pRowNum:Str5):boolean;

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
    property RowNum:Str5 read ReadRowNum write WriteRowNum;
    property Describe:Str150 read ReadDescribe write WriteDescribe;
    property RowType:Str1 read ReadRowType write WriteRowType;
    property ValType:Str1 read ReadValType write WriteValType;
    property PozVal:byte read ReadPozVal write WritePozVal;
    property NegVal:byte read ReadNegVal write WriteNegVal;
    property Calcul:Str200 read ReadCalcul write WriteCalcul;
    property CrtUser:Str8 read ReadCrtUser write WriteCrtUser;
    property CrtDate:TDatetime read ReadCrtDate write WriteCrtDate;
    property CrtTime:TDatetime read ReadCrtTime write WriteCrtTime;
    property ModUser:Str8 read ReadModUser write WriteModUser;
    property ModDate:TDatetime read ReadModDate write WriteModDate;
    property ModTime:TDatetime read ReadModTime write WriteModTime;
    property VatGrp:byte read ReadVatGrp write WriteVatGrp;
    property VatPrcLst:Str30 read ReadVatPrcLst write WriteVatPrcLst;
  end;

implementation

constructor TVtcBtr.Create;
begin
  oBtrTable := BtrInit ('VTC',gPath.LdgPath,Self);
end;

constructor TVtcBtr.Create(pPath:ShortString);
begin
  oBtrTable := BtrInit ('VTC',pPath,Self);
end;

destructor TVtcBtr.Destroy;
begin
  oBtrTable.Close;  FreeAndNil (oBtrTable);
end;

// *************************************** PRIVATE ********************************************

function TVtcBtr.ReadCount:integer;
begin
  Result := oBtrTable.RecordCount;
end;

function TVtcBtr.FieldExist (pFieldName:ShortString): boolean;
begin
  Result := oBtrTable.FindField(pFieldName)<>nil;
end;

function TVtcBtr.ReadRowNum:Str5;
begin
  Result := oBtrTable.FieldByName('RowNum').AsString;
end;

procedure TVtcBtr.WriteRowNum(pValue:Str5);
begin
  oBtrTable.FieldByName('RowNum').AsString := pValue;
end;

function TVtcBtr.ReadDescribe:Str150;
begin
  Result := oBtrTable.FieldByName('Describe').AsString;
end;

procedure TVtcBtr.WriteDescribe(pValue:Str150);
begin
  oBtrTable.FieldByName('Describe').AsString := pValue;
end;

function TVtcBtr.ReadRowType:Str1;
begin
  Result := oBtrTable.FieldByName('RowType').AsString;
end;

procedure TVtcBtr.WriteRowType(pValue:Str1);
begin
  oBtrTable.FieldByName('RowType').AsString := pValue;
end;

function TVtcBtr.ReadValType:Str1;
begin
  Result := oBtrTable.FieldByName('ValType').AsString;
end;

procedure TVtcBtr.WriteValType(pValue:Str1);
begin
  oBtrTable.FieldByName('ValType').AsString := pValue;
end;

function TVtcBtr.ReadPozVal:byte;
begin
  Result := oBtrTable.FieldByName('PozVal').AsInteger;
end;

procedure TVtcBtr.WritePozVal(pValue:byte);
begin
  oBtrTable.FieldByName('PozVal').AsInteger := pValue;
end;

function TVtcBtr.ReadNegVal:byte;
begin
  Result := oBtrTable.FieldByName('NegVal').AsInteger;
end;

procedure TVtcBtr.WriteNegVal(pValue:byte);
begin
  oBtrTable.FieldByName('NegVal').AsInteger := pValue;
end;

function TVtcBtr.ReadCalcul:Str200;
begin
  Result := oBtrTable.FieldByName('Calcul').AsString;
end;

procedure TVtcBtr.WriteCalcul(pValue:Str200);
begin
  oBtrTable.FieldByName('Calcul').AsString := pValue;
end;

function TVtcBtr.ReadCrtUser:Str8;
begin
  Result := oBtrTable.FieldByName('CrtUser').AsString;
end;

procedure TVtcBtr.WriteCrtUser(pValue:Str8);
begin
  oBtrTable.FieldByName('CrtUser').AsString := pValue;
end;

function TVtcBtr.ReadCrtDate:TDatetime;
begin
  Result := oBtrTable.FieldByName('CrtDate').AsDateTime;
end;

procedure TVtcBtr.WriteCrtDate(pValue:TDatetime);
begin
  oBtrTable.FieldByName('CrtDate').AsDateTime := pValue;
end;

function TVtcBtr.ReadCrtTime:TDatetime;
begin
  Result := oBtrTable.FieldByName('CrtTime').AsDateTime;
end;

procedure TVtcBtr.WriteCrtTime(pValue:TDatetime);
begin
  oBtrTable.FieldByName('CrtTime').AsDateTime := pValue;
end;

function TVtcBtr.ReadModUser:Str8;
begin
  Result := oBtrTable.FieldByName('ModUser').AsString;
end;

procedure TVtcBtr.WriteModUser(pValue:Str8);
begin
  oBtrTable.FieldByName('ModUser').AsString := pValue;
end;

function TVtcBtr.ReadModDate:TDatetime;
begin
  Result := oBtrTable.FieldByName('ModDate').AsDateTime;
end;

procedure TVtcBtr.WriteModDate(pValue:TDatetime);
begin
  oBtrTable.FieldByName('ModDate').AsDateTime := pValue;
end;

function TVtcBtr.ReadModTime:TDatetime;
begin
  Result := oBtrTable.FieldByName('ModTime').AsDateTime;
end;

procedure TVtcBtr.WriteModTime(pValue:TDatetime);
begin
  oBtrTable.FieldByName('ModTime').AsDateTime := pValue;
end;

function TVtcBtr.ReadVatGrp:byte;
begin
  Result := oBtrTable.FieldByName('VatGrp').AsInteger;
end;

procedure TVtcBtr.WriteVatGrp(pValue:byte);
begin
  oBtrTable.FieldByName('VatGrp').AsInteger := pValue;
end;

function TVtcBtr.ReadVatPrcLst:Str30;
begin
  Result := oBtrTable.FieldByName('VatPrcLst').AsString;
end;

procedure TVtcBtr.WriteVatPrcLst(pValue:Str30);
begin
  oBtrTable.FieldByName('VatPrcLst').AsString := pValue;
end;

// **************************************** PUBLIC ********************************************

function TVtcBtr.Eof: boolean;
begin
  Result := oBtrTable.Eof;
end;

function TVtcBtr.IsFirstRec: boolean;
begin
  Result := oBtrTable.Bof;
end;

function TVtcBtr.IsLastRec: boolean;
begin
  Result := oBtrTable.Eof;
end;

function TVtcBtr.Active: boolean;
begin
  Result := oBtrTable.Active;
end;

function TVtcBtr.ActPos: longint;
begin
  Result := oBtrTable.ActPos;
end;

function TVtcBtr.GotoPos (pActPos:longint): boolean;
begin
  Result := oBtrTable.GotoPos(pActPos);
end;

function TVtcBtr.LocateRowNum (pRowNum:Str5):boolean;
begin
  SetIndex (ixRowNum);
  Result := oBtrTable.FindKey([pRowNum]);
end;

function TVtcBtr.NearestRowNum (pRowNum:Str5):boolean;
begin
  SetIndex (ixRowNum);
  Result := oBtrTable.FindNearest([pRowNum]);
end;

procedure TVtcBtr.SetIndex (pIndexName:ShortString);
begin
  If oBtrTable.IndexName<>pIndexName then oBtrTable.IndexName := pIndexName;
end;

procedure TVtcBtr.Open(pBookNum:Str5);
begin
  oBookNum := pBookNum;
  oBtrTable.Open(pBookNum);
end;

procedure TVtcBtr.Close;
begin
  If oBtrTable.Active then oBtrTable.Close;
end;

procedure TVtcBtr.Prior;
begin
  oBtrTable.Prior;
end;

procedure TVtcBtr.Next;
begin
  oBtrTable.Next;
end;

procedure TVtcBtr.First;
begin
  oBtrTable.First;
end;

procedure TVtcBtr.Last;
begin
  oBtrTable.Last;
end;

procedure TVtcBtr.Insert;
begin
  oBtrTable.Insert;
end;

procedure TVtcBtr.Edit;
begin
  oBtrTable.Edit;
end;

procedure TVtcBtr.Post;
begin
  oBtrTable.Post;
end;

procedure TVtcBtr.Delete;
begin
  oBtrTable.Delete;
end;

procedure TVtcBtr.SwapIndex;
begin
  oBtrTable.SwapIndex;
end;

procedure TVtcBtr.RestoreIndex;
begin
  oBtrTable.RestoreIndex;
end;

procedure TVtcBtr.SwapStatus;
begin
  oBtrTable.SwapStatus;
end;

procedure TVtcBtr.RestoreStatus;
begin
  oBtrTable.RestoreStatus;
end;

procedure TVtcBtr.EnableControls;
begin
  oBtrTable.EnableControls;
end;

procedure TVtcBtr.DisableControls;
begin
  oBtrTable.DisableControls;
end;

end.
{MOD 2209001}
