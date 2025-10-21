unit bCRDTRN;

interface

uses
  IcTypes, IcConv, NexPath, NexGlob,
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls,
  Dialogs, DB, NexBtrTable, DBTables, NexPxTable;

const
  ixBlkNum = 'BlkNum';
  ixDocNum = 'DocNum';
  ixCrdNum = 'CrdNum';

type
  TCrdtrnBtr = class (TComponent)
    constructor Create; overload;
    destructor  Destroy; override;
  private
    oBtrTable: TNexBtrTable;
    function ReadCount:integer;
    function FieldExist (pFieldName:ShortString): boolean;
    // Pristup k databazovym poliam
    function  ReadBlkNum:Str10;          procedure WriteBlkNum (pValue:Str10);
    function  ReadCrdNum:Str20;          procedure WriteCrdNum (pValue:Str20);
    function  ReadBlkDate:TDatetime;     procedure WriteBlkDate (pValue:TDatetime);
    function  ReadBlkTime:TDatetime;     procedure WriteBlkTime (pValue:TDatetime);
    function  ReadBlkVal:double;         procedure WriteBlkVal (pValue:double);
    function  ReadCrtUser:Str8;          procedure WriteCrtUser (pValue:Str8);
    function  ReadCrtDate:TDatetime;     procedure WriteCrtDate (pValue:TDatetime);
    function  ReadCrtTime:TDatetime;     procedure WriteCrtTime (pValue:TDatetime);
    function  ReadDocNum:Str12;          procedure WriteDocNum (pValue:Str12);
  public
    constructor Create(pPath:ShortString); overload;
    // Elementarne databazove operacie
    function Eof: boolean;
    function IsFirstRec: boolean;
    function IsLastRec: boolean;
    function Active: boolean;
    function ActPos: longint;
    function GotoPos (pActPos:longint): boolean;
    function LocateBlkNum (pBlkNum:Str10):boolean;
    function LocateDocNum (pDocNum:Str12):boolean;
    function LocateCrdNum (pCrdNum:Str20):boolean;
    function NearestBlkNum (pBlkNum:Str10):boolean;
    function NearestDocNum (pDocNum:Str12):boolean;
    function NearestCrdNum (pCrdNum:Str20):boolean;

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
    property BlkNum:Str10 read ReadBlkNum write WriteBlkNum;
    property CrdNum:Str20 read ReadCrdNum write WriteCrdNum;
    property BlkDate:TDatetime read ReadBlkDate write WriteBlkDate;
    property BlkTime:TDatetime read ReadBlkTime write WriteBlkTime;
    property BlkVal:double read ReadBlkVal write WriteBlkVal;
    property CrtUser:Str8 read ReadCrtUser write WriteCrtUser;
    property CrtDate:TDatetime read ReadCrtDate write WriteCrtDate;
    property CrtTime:TDatetime read ReadCrtTime write WriteCrtTime;
    property DocNum:Str12 read ReadDocNum write WriteDocNum;
  end;

implementation

constructor TCrdtrnBtr.Create;
begin
  oBtrTable := BtrInit ('CRDTRN',gPath.CabPath,Self);
end;

constructor TCrdtrnBtr.Create(pPath:ShortString);
begin
  oBtrTable := BtrInit ('CRDTRN',pPath,Self);
end;

destructor TCrdtrnBtr.Destroy;
begin
  oBtrTable.Close;  FreeAndNil (oBtrTable);
end;

// *************************************** PRIVATE ********************************************

function TCrdtrnBtr.ReadCount:integer;
begin
  Result := oBtrTable.RecordCount;
end;

function TCrdtrnBtr.FieldExist (pFieldName:ShortString): boolean;
begin
  Result := oBtrTable.FindField(pFieldName)<>nil;
end;

function TCrdtrnBtr.ReadBlkNum:Str10;
begin
  Result := oBtrTable.FieldByName('BlkNum').AsString;
end;

procedure TCrdtrnBtr.WriteBlkNum(pValue:Str10);
begin
  oBtrTable.FieldByName('BlkNum').AsString := pValue;
end;

function TCrdtrnBtr.ReadCrdNum:Str20;
begin
  Result := oBtrTable.FieldByName('CrdNum').AsString;
end;

procedure TCrdtrnBtr.WriteCrdNum(pValue:Str20);
begin
  oBtrTable.FieldByName('CrdNum').AsString := pValue;
end;

function TCrdtrnBtr.ReadBlkDate:TDatetime;
begin
  Result := oBtrTable.FieldByName('BlkDate').AsDateTime;
end;

procedure TCrdtrnBtr.WriteBlkDate(pValue:TDatetime);
begin
  oBtrTable.FieldByName('BlkDate').AsDateTime := pValue;
end;

function TCrdtrnBtr.ReadBlkTime:TDatetime;
begin
  Result := oBtrTable.FieldByName('BlkTime').AsDateTime;
end;

procedure TCrdtrnBtr.WriteBlkTime(pValue:TDatetime);
begin
  oBtrTable.FieldByName('BlkTime').AsDateTime := pValue;
end;

function TCrdtrnBtr.ReadBlkVal:double;
begin
  Result := oBtrTable.FieldByName('BlkVal').AsFloat;
end;

procedure TCrdtrnBtr.WriteBlkVal(pValue:double);
begin
  oBtrTable.FieldByName('BlkVal').AsFloat := pValue;
end;

function TCrdtrnBtr.ReadCrtUser:Str8;
begin
  Result := oBtrTable.FieldByName('CrtUser').AsString;
end;

procedure TCrdtrnBtr.WriteCrtUser(pValue:Str8);
begin
  oBtrTable.FieldByName('CrtUser').AsString := pValue;
end;

function TCrdtrnBtr.ReadCrtDate:TDatetime;
begin
  Result := oBtrTable.FieldByName('CrtDate').AsDateTime;
end;

procedure TCrdtrnBtr.WriteCrtDate(pValue:TDatetime);
begin
  oBtrTable.FieldByName('CrtDate').AsDateTime := pValue;
end;

function TCrdtrnBtr.ReadCrtTime:TDatetime;
begin
  Result := oBtrTable.FieldByName('CrtTime').AsDateTime;
end;

procedure TCrdtrnBtr.WriteCrtTime(pValue:TDatetime);
begin
  oBtrTable.FieldByName('CrtTime').AsDateTime := pValue;
end;

function TCrdtrnBtr.ReadDocNum:Str12;
begin
  Result := oBtrTable.FieldByName('DocNum').AsString;
end;

procedure TCrdtrnBtr.WriteDocNum(pValue:Str12);
begin
  oBtrTable.FieldByName('DocNum').AsString := pValue;
end;

// **************************************** PUBLIC ********************************************

function TCrdtrnBtr.Eof: boolean;
begin
  Result := oBtrTable.Eof;
end;

function TCrdtrnBtr.IsFirstRec: boolean;
begin
  Result := oBtrTable.Bof;
end;

function TCrdtrnBtr.IsLastRec: boolean;
begin
  Result := oBtrTable.Eof;
end;

function TCrdtrnBtr.Active: boolean;
begin
  Result := oBtrTable.Active;
end;

function TCrdtrnBtr.ActPos: longint;
begin
  Result := oBtrTable.ActPos;
end;

function TCrdtrnBtr.GotoPos (pActPos:longint): boolean;
begin
  Result := oBtrTable.GotoPos(pActPos);
end;

function TCrdtrnBtr.LocateBlkNum (pBlkNum:Str10):boolean;
begin
  SetIndex (ixBlkNum);
  Result := oBtrTable.FindKey([pBlkNum]);
end;

function TCrdtrnBtr.LocateDocNum (pDocNum:Str12):boolean;
begin
  SetIndex (ixDocNum);
  Result := oBtrTable.FindKey([pDocNum]);
end;

function TCrdtrnBtr.LocateCrdNum (pCrdNum:Str20):boolean;
begin
  SetIndex (ixCrdNum);
  Result := oBtrTable.FindKey([pCrdNum]);
end;

function TCrdtrnBtr.NearestBlkNum (pBlkNum:Str10):boolean;
begin
  SetIndex (ixBlkNum);
  Result := oBtrTable.FindNearest([pBlkNum]);
end;

function TCrdtrnBtr.NearestDocNum (pDocNum:Str12):boolean;
begin
  SetIndex (ixDocNum);
  Result := oBtrTable.FindNearest([pDocNum]);
end;

function TCrdtrnBtr.NearestCrdNum (pCrdNum:Str20):boolean;
begin
  SetIndex (ixCrdNum);
  Result := oBtrTable.FindNearest([pCrdNum]);
end;

procedure TCrdtrnBtr.SetIndex (pIndexName:ShortString);
begin
  If oBtrTable.IndexName<>pIndexName then oBtrTable.IndexName := pIndexName;
end;

procedure TCrdtrnBtr.Open;
begin
  oBtrTable.Open;
end;

procedure TCrdtrnBtr.Close;
begin
  If oBtrTable.Active then oBtrTable.Close;
end;

procedure TCrdtrnBtr.Prior;
begin
  oBtrTable.Prior;
end;

procedure TCrdtrnBtr.Next;
begin
  oBtrTable.Next;
end;

procedure TCrdtrnBtr.First;
begin
  oBtrTable.First;
end;

procedure TCrdtrnBtr.Last;
begin
  oBtrTable.Last;
end;

procedure TCrdtrnBtr.Insert;
begin
  oBtrTable.Insert;
end;

procedure TCrdtrnBtr.Edit;
begin
  oBtrTable.Edit;
end;

procedure TCrdtrnBtr.Post;
begin
  oBtrTable.Post;
end;

procedure TCrdtrnBtr.Delete;
begin
  oBtrTable.Delete;
end;

procedure TCrdtrnBtr.SwapIndex;
begin
  oBtrTable.SwapIndex;
end;

procedure TCrdtrnBtr.RestoreIndex;
begin
  oBtrTable.RestoreIndex;
end;

procedure TCrdtrnBtr.SwapStatus;
begin
  oBtrTable.SwapStatus;
end;

procedure TCrdtrnBtr.RestoreStatus;
begin
  oBtrTable.RestoreStatus;
end;

procedure TCrdtrnBtr.EnableControls;
begin
  oBtrTable.EnableControls;
end;

procedure TCrdtrnBtr.DisableControls;
begin
  oBtrTable.DisableControls;
end;

end.
{MOD 1920001}
