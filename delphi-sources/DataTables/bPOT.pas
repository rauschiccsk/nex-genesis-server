unit bPOT;

interface

uses
  IcTypes, IcConv, NexPath, NexGlob,
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls,
  Dialogs, DB, NexBtrTable, DBTables, NexPxTable;

const
  ixDoItTdTi = 'DoItTdTi';
  ixDoIt = 'DoIt';

type
  TPotBtr = class (TComponent)
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

constructor TPotBtr.Create;
begin
  oBtrTable := BtrInit ('POT',gPath.StkPath,Self);
end;

constructor TPotBtr.Create(pPath:ShortString);
begin
  oBtrTable := BtrInit ('POT',pPath,Self);
end;

destructor TPotBtr.Destroy;
begin
  oBtrTable.Close;  FreeAndNil (oBtrTable);
end;

// *************************************** PRIVATE ********************************************

function TPotBtr.ReadCount:integer;
begin
  Result := oBtrTable.RecordCount;
end;

function TPotBtr.FieldExist (pFieldName:ShortString): boolean;
begin
  Result := oBtrTable.FindField(pFieldName)<>nil;
end;

function TPotBtr.ReadDocNum:Str12;
begin
  Result := oBtrTable.FieldByName('DocNum').AsString;
end;

procedure TPotBtr.WriteDocNum(pValue:Str12);
begin
  oBtrTable.FieldByName('DocNum').AsString := pValue;
end;

function TPotBtr.ReadItmNum:word;
begin
  Result := oBtrTable.FieldByName('ItmNum').AsInteger;
end;

procedure TPotBtr.WriteItmNum(pValue:word);
begin
  oBtrTable.FieldByName('ItmNum').AsInteger := pValue;
end;

function TPotBtr.ReadTcdNum:Str12;
begin
  Result := oBtrTable.FieldByName('TcdNum').AsString;
end;

procedure TPotBtr.WriteTcdNum(pValue:Str12);
begin
  oBtrTable.FieldByName('TcdNum').AsString := pValue;
end;

function TPotBtr.ReadTcdItm:word;
begin
  Result := oBtrTable.FieldByName('TcdItm').AsInteger;
end;

procedure TPotBtr.WriteTcdItm(pValue:word);
begin
  oBtrTable.FieldByName('TcdItm').AsInteger := pValue;
end;

function TPotBtr.ReadTcdDate:TDatetime;
begin
  Result := oBtrTable.FieldByName('TcdDate').AsDateTime;
end;

procedure TPotBtr.WriteTcdDate(pValue:TDatetime);
begin
  oBtrTable.FieldByName('TcdDate').AsDateTime := pValue;
end;

function TPotBtr.ReadGsCode:longint;
begin
  Result := oBtrTable.FieldByName('GsCode').AsInteger;
end;

procedure TPotBtr.WriteGsCode(pValue:longint);
begin
  oBtrTable.FieldByName('GsCode').AsInteger := pValue;
end;

function TPotBtr.ReadDlvQnt:double;
begin
  Result := oBtrTable.FieldByName('DlvQnt').AsFloat;
end;

procedure TPotBtr.WriteDlvQnt(pValue:double);
begin
  oBtrTable.FieldByName('DlvQnt').AsFloat := pValue;
end;

function TPotBtr.ReadCrtUser:Str8;
begin
  Result := oBtrTable.FieldByName('CrtUser').AsString;
end;

procedure TPotBtr.WriteCrtUser(pValue:Str8);
begin
  oBtrTable.FieldByName('CrtUser').AsString := pValue;
end;

function TPotBtr.ReadCrtDate:TDatetime;
begin
  Result := oBtrTable.FieldByName('CrtDate').AsDateTime;
end;

procedure TPotBtr.WriteCrtDate(pValue:TDatetime);
begin
  oBtrTable.FieldByName('CrtDate').AsDateTime := pValue;
end;

function TPotBtr.ReadCrtTime:TDatetime;
begin
  Result := oBtrTable.FieldByName('CrtTime').AsDateTime;
end;

procedure TPotBtr.WriteCrtTime(pValue:TDatetime);
begin
  oBtrTable.FieldByName('CrtTime').AsDateTime := pValue;
end;

// **************************************** PUBLIC ********************************************

function TPotBtr.Eof: boolean;
begin
  Result := oBtrTable.Eof;
end;

function TPotBtr.IsFirstRec: boolean;
begin
  Result := oBtrTable.Bof;
end;

function TPotBtr.IsLastRec: boolean;
begin
  Result := oBtrTable.Eof;
end;

function TPotBtr.Active: boolean;
begin
  Result := oBtrTable.Active;
end;

function TPotBtr.ActPos: longint;
begin
  Result := oBtrTable.ActPos;
end;

function TPotBtr.GotoPos (pActPos:longint): boolean;
begin
  Result := oBtrTable.GotoPos(pActPos);
end;

function TPotBtr.LocateDoItTdTi (pDocNum:Str12;pItmNum:word;pTcdNum:Str12;pTcdItm:word):boolean;
begin
  SetIndex (ixDoItTdTi);
  Result := oBtrTable.FindKey([pDocNum,pItmNum,pTcdNum,pTcdItm]);
end;

function TPotBtr.LocateDoIt (pDocNum:Str12;pItmNum:word):boolean;
begin
  SetIndex (ixDoIt);
  Result := oBtrTable.FindKey([pDocNum,pItmNum]);
end;

function TPotBtr.NearestDoItTdTi (pDocNum:Str12;pItmNum:word;pTcdNum:Str12;pTcdItm:word):boolean;
begin
  SetIndex (ixDoItTdTi);
  Result := oBtrTable.FindNearest([pDocNum,pItmNum,pTcdNum,pTcdItm]);
end;

function TPotBtr.NearestDoIt (pDocNum:Str12;pItmNum:word):boolean;
begin
  SetIndex (ixDoIt);
  Result := oBtrTable.FindNearest([pDocNum,pItmNum]);
end;

procedure TPotBtr.SetIndex (pIndexName:ShortString);
begin
  If oBtrTable.IndexName<>pIndexName then oBtrTable.IndexName := pIndexName;
end;

procedure TPotBtr.Open(pBookNum:Str5);
begin
  oBookNum := pBookNum;
  oBtrTable.Open(pBookNum);
end;

procedure TPotBtr.Close;
begin
  If oBtrTable.Active then oBtrTable.Close;
end;

procedure TPotBtr.Prior;
begin
  oBtrTable.Prior;
end;

procedure TPotBtr.Next;
begin
  oBtrTable.Next;
end;

procedure TPotBtr.First;
begin
  oBtrTable.First;
end;

procedure TPotBtr.Last;
begin
  oBtrTable.Last;
end;

procedure TPotBtr.Insert;
begin
  oBtrTable.Insert;
end;

procedure TPotBtr.Edit;
begin
  oBtrTable.Edit;
end;

procedure TPotBtr.Post;
begin
  oBtrTable.Post;
end;

procedure TPotBtr.Delete;
begin
  oBtrTable.Delete;
end;

procedure TPotBtr.SwapIndex;
begin
  oBtrTable.SwapIndex;
end;

procedure TPotBtr.RestoreIndex;
begin
  oBtrTable.RestoreIndex;
end;

procedure TPotBtr.SwapStatus;
begin
  oBtrTable.SwapStatus;
end;

procedure TPotBtr.RestoreStatus;
begin
  oBtrTable.RestoreStatus;
end;

procedure TPotBtr.EnableControls;
begin
  oBtrTable.EnableControls;
end;

procedure TPotBtr.DisableControls;
begin
  oBtrTable.DisableControls;
end;

end.
