unit bTOT;

interface

uses
  IcTypes, IcConv, NexPath, NexGlob,
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls,
  Dialogs, DB, NexBtrTable, DBTables, NexPxTable;

const
  ixDoItTdTi = 'DoItTdTi';
  ixDoIt = 'DoIt';

type
  TTotBtr = class (TComponent)
    constructor Create; overload;
    destructor  Destroy; override;
  private
    oBookNum: Str5;
    oBtrTable: TNexBtrTable;
    function ReadCount:integer;
    function FieldExist (pFieldName:ShortString): boolean;
    // Pristup k databazovym poliam
    function  ReadDocNum:Str12;          procedure WriteDocNum (pValue:Str12);
    function  ReadItmNum:word;           procedure WriteItmNum (pValue:word);
    function  ReadTcdNum:Str12;          procedure WriteTcdNum (pValue:Str12);
    function  ReadTcdItm:word;           procedure WriteTcdItm (pValue:word);
    function  ReadTcdDate:TDatetime;     procedure WriteTcdDate (pValue:TDatetime);
    function  ReadGsCode:longint;        procedure WriteGsCode (pValue:longint);
    function  ReadDlvQnt:double;         procedure WriteDlvQnt (pValue:double);
    function  ReadCrtUser:Str8;          procedure WriteCrtUser (pValue:Str8);
    function  ReadCrtDate:TDatetime;     procedure WriteCrtDate (pValue:TDatetime);
    function  ReadCrtTime:TDatetime;     procedure WriteCrtTime (pValue:TDatetime);
  public
    constructor Create(pPath:ShortString); overload;
    // Elementarne databazove operacie
    function Eof: boolean;
    function IsFirstRec: boolean;
    function IsLastRec: boolean;
    function Active: boolean;
    function ActPos: longint;
    function GotoPos (pActPos:longint): boolean;
    function LocateDoItTdTi (pDocNum:Str12;pItmNum:word;pTcdNum:Str12;pTcdItm:word):boolean;
    function LocateDoIt (pDocNum:Str12;pItmNum:word):boolean;
    function NearestDoItTdTi (pDocNum:Str12;pItmNum:word;pTcdNum:Str12;pTcdItm:word):boolean;
    function NearestDoIt (pDocNum:Str12;pItmNum:word):boolean;

    procedure SetIndex (pIndexName:ShortString);
    procedure Open (pBookNum:Str5);
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
    property DocNum:Str12 read ReadDocNum write WriteDocNum;
    property ItmNum:word read ReadItmNum write WriteItmNum;
    property TcdNum:Str12 read ReadTcdNum write WriteTcdNum;
    property TcdItm:word read ReadTcdItm write WriteTcdItm;
    property TcdDate:TDatetime read ReadTcdDate write WriteTcdDate;
    property GsCode:longint read ReadGsCode write WriteGsCode;
    property DlvQnt:double read ReadDlvQnt write WriteDlvQnt;
    property CrtUser:Str8 read ReadCrtUser write WriteCrtUser;
    property CrtDate:TDatetime read ReadCrtDate write WriteCrtDate;
    property CrtTime:TDatetime read ReadCrtTime write WriteCrtTime;
  end;

implementation

constructor TTotBtr.Create;
begin
  oBtrTable := BtrInit ('TOT',gPath.StkPath,Self);
end;

constructor TTotBtr.Create(pPath:ShortString);
begin
  oBtrTable := BtrInit ('TOT',pPath,Self);
end;

destructor TTotBtr.Destroy;
begin
  oBtrTable.Close;  FreeAndNil (oBtrTable);
end;

// *************************************** PRIVATE ********************************************

function TTotBtr.ReadCount:integer;
begin
  Result := oBtrTable.RecordCount;
end;

function TTotBtr.FieldExist (pFieldName:ShortString): boolean;
begin
  Result := oBtrTable.FindField(pFieldName)<>nil;
end;

function TTotBtr.ReadDocNum:Str12;
begin
  Result := oBtrTable.FieldByName('DocNum').AsString;
end;

procedure TTotBtr.WriteDocNum(pValue:Str12);
begin
  oBtrTable.FieldByName('DocNum').AsString := pValue;
end;

function TTotBtr.ReadItmNum:word;
begin
  Result := oBtrTable.FieldByName('ItmNum').AsInteger;
end;

procedure TTotBtr.WriteItmNum(pValue:word);
begin
  oBtrTable.FieldByName('ItmNum').AsInteger := pValue;
end;

function TTotBtr.ReadTcdNum:Str12;
begin
  Result := oBtrTable.FieldByName('TcdNum').AsString;
end;

procedure TTotBtr.WriteTcdNum(pValue:Str12);
begin
  oBtrTable.FieldByName('TcdNum').AsString := pValue;
end;

function TTotBtr.ReadTcdItm:word;
begin
  Result := oBtrTable.FieldByName('TcdItm').AsInteger;
end;

procedure TTotBtr.WriteTcdItm(pValue:word);
begin
  oBtrTable.FieldByName('TcdItm').AsInteger := pValue;
end;

function TTotBtr.ReadTcdDate:TDatetime;
begin
  Result := oBtrTable.FieldByName('TcdDate').AsDateTime;
end;

procedure TTotBtr.WriteTcdDate(pValue:TDatetime);
begin
  oBtrTable.FieldByName('TcdDate').AsDateTime := pValue;
end;

function TTotBtr.ReadGsCode:longint;
begin
  Result := oBtrTable.FieldByName('GsCode').AsInteger;
end;

procedure TTotBtr.WriteGsCode(pValue:longint);
begin
  oBtrTable.FieldByName('GsCode').AsInteger := pValue;
end;

function TTotBtr.ReadDlvQnt:double;
begin
  Result := oBtrTable.FieldByName('DlvQnt').AsFloat;
end;

procedure TTotBtr.WriteDlvQnt(pValue:double);
begin
  oBtrTable.FieldByName('DlvQnt').AsFloat := pValue;
end;

function TTotBtr.ReadCrtUser:Str8;
begin
  Result := oBtrTable.FieldByName('CrtUser').AsString;
end;

procedure TTotBtr.WriteCrtUser(pValue:Str8);
begin
  oBtrTable.FieldByName('CrtUser').AsString := pValue;
end;

function TTotBtr.ReadCrtDate:TDatetime;
begin
  Result := oBtrTable.FieldByName('CrtDate').AsDateTime;
end;

procedure TTotBtr.WriteCrtDate(pValue:TDatetime);
begin
  oBtrTable.FieldByName('CrtDate').AsDateTime := pValue;
end;

function TTotBtr.ReadCrtTime:TDatetime;
begin
  Result := oBtrTable.FieldByName('CrtTime').AsDateTime;
end;

procedure TTotBtr.WriteCrtTime(pValue:TDatetime);
begin
  oBtrTable.FieldByName('CrtTime').AsDateTime := pValue;
end;

// **************************************** PUBLIC ********************************************

function TTotBtr.Eof: boolean;
begin
  Result := oBtrTable.Eof;
end;

function TTotBtr.IsFirstRec: boolean;
begin
  Result := oBtrTable.Bof;
end;

function TTotBtr.IsLastRec: boolean;
begin
  Result := oBtrTable.Eof;
end;

function TTotBtr.Active: boolean;
begin
  Result := oBtrTable.Active;
end;

function TTotBtr.ActPos: longint;
begin
  Result := oBtrTable.ActPos;
end;

function TTotBtr.GotoPos (pActPos:longint): boolean;
begin
  Result := oBtrTable.GotoPos(pActPos);
end;

function TTotBtr.LocateDoItTdTi (pDocNum:Str12;pItmNum:word;pTcdNum:Str12;pTcdItm:word):boolean;
begin
  SetIndex (ixDoItTdTi);
  Result := oBtrTable.FindKey([pDocNum,pItmNum,pTcdNum,pTcdItm]);
end;

function TTotBtr.LocateDoIt (pDocNum:Str12;pItmNum:word):boolean;
begin
  SetIndex (ixDoIt);
  Result := oBtrTable.FindKey([pDocNum,pItmNum]);
end;

function TTotBtr.NearestDoItTdTi (pDocNum:Str12;pItmNum:word;pTcdNum:Str12;pTcdItm:word):boolean;
begin
  SetIndex (ixDoItTdTi);
  Result := oBtrTable.FindNearest([pDocNum,pItmNum,pTcdNum,pTcdItm]);
end;

function TTotBtr.NearestDoIt (pDocNum:Str12;pItmNum:word):boolean;
begin
  SetIndex (ixDoIt);
  Result := oBtrTable.FindNearest([pDocNum,pItmNum]);
end;

procedure TTotBtr.SetIndex (pIndexName:ShortString);
begin
  If oBtrTable.IndexName<>pIndexName then oBtrTable.IndexName := pIndexName;
end;

procedure TTotBtr.Open(pBookNum:Str5);
begin
  oBookNum := pBookNum;
  oBtrTable.Open(pBookNum);
end;

procedure TTotBtr.Close;
begin
  If oBtrTable.Active then oBtrTable.Close;
end;

procedure TTotBtr.Prior;
begin
  oBtrTable.Prior;
end;

procedure TTotBtr.Next;
begin
  oBtrTable.Next;
end;

procedure TTotBtr.First;
begin
  oBtrTable.First;
end;

procedure TTotBtr.Last;
begin
  oBtrTable.Last;
end;

procedure TTotBtr.Insert;
begin
  oBtrTable.Insert;
end;

procedure TTotBtr.Edit;
begin
  oBtrTable.Edit;
end;

procedure TTotBtr.Post;
begin
  oBtrTable.Post;
end;

procedure TTotBtr.Delete;
begin
  oBtrTable.Delete;
end;

procedure TTotBtr.SwapIndex;
begin
  oBtrTable.SwapIndex;
end;

procedure TTotBtr.RestoreIndex;
begin
  oBtrTable.RestoreIndex;
end;

procedure TTotBtr.SwapStatus;
begin
  oBtrTable.SwapStatus;
end;

procedure TTotBtr.RestoreStatus;
begin
  oBtrTable.RestoreStatus;
end;

procedure TTotBtr.EnableControls;
begin
  oBtrTable.EnableControls;
end;

procedure TTotBtr.DisableControls;
begin
  oBtrTable.DisableControls;
end;

end.
