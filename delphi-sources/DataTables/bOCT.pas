unit bOCT;

interface

uses
  IcTypes, IcConv, NexPath, NexGlob,
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls,
  Dialogs, DB, NexBtrTable, DBTables, NexPxTable;

const
  ixDoItTdTi = 'DoItTdTi';
  ixDoIt = 'DoIt';
  ixTdTi = 'TdTi';

type
  TOctBtr = class (TComponent)
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
    function  ReadDlvDoc:Str12;          procedure WriteDlvDoc (pValue:Str12);
    function  ReadDlvItm:word;           procedure WriteDlvItm (pValue:word);
    function  ReadDlvDate:TDatetime;     procedure WriteDlvDate (pValue:TDatetime);
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
    function LocateDoItTdTi (pDocNum:Str12;pItmNum:word;pDlvDoc:Str12;pDlvItm:word):boolean;
    function LocateDoIt (pDocNum:Str12;pItmNum:word):boolean;
    function LocateTdTi (pDlvDoc:Str12;pDlvItm:word):boolean;
    function NearestDoItTdTi (pDocNum:Str12;pItmNum:word;pDlvDoc:Str12;pDlvItm:word):boolean;
    function NearestDoIt (pDocNum:Str12;pItmNum:word):boolean;
    function NearestTdTi (pDlvDoc:Str12;pDlvItm:word):boolean;

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
    property DocNum:Str12 read ReadDocNum write WriteDocNum;
    property ItmNum:word read ReadItmNum write WriteItmNum;
    property DlvDoc:Str12 read ReadDlvDoc write WriteDlvDoc;
    property DlvItm:word read ReadDlvItm write WriteDlvItm;
    property DlvDate:TDatetime read ReadDlvDate write WriteDlvDate;
    property GsCode:longint read ReadGsCode write WriteGsCode;
    property DlvQnt:double read ReadDlvQnt write WriteDlvQnt;
    property CrtUser:Str8 read ReadCrtUser write WriteCrtUser;
    property CrtDate:TDatetime read ReadCrtDate write WriteCrtDate;
    property CrtTime:TDatetime read ReadCrtTime write WriteCrtTime;
  end;

implementation

constructor TOctBtr.Create;
begin
  oBtrTable := BtrInit ('OCT',gPath.StkPath,Self);
end;

constructor TOctBtr.Create(pPath:ShortString);
begin
  oBtrTable := BtrInit ('OCT',pPath,Self);
end;

destructor TOctBtr.Destroy;
begin
  oBtrTable.Close;  FreeAndNil (oBtrTable);
end;

// *************************************** PRIVATE ********************************************

function TOctBtr.ReadCount:integer;
begin
  Result := oBtrTable.RecordCount;
end;

function TOctBtr.FieldExist (pFieldName:ShortString): boolean;
begin
  Result := oBtrTable.FindField(pFieldName)<>nil;
end;

function TOctBtr.ReadDocNum:Str12;
begin
  Result := oBtrTable.FieldByName('DocNum').AsString;
end;

procedure TOctBtr.WriteDocNum(pValue:Str12);
begin
  oBtrTable.FieldByName('DocNum').AsString := pValue;
end;

function TOctBtr.ReadItmNum:word;
begin
  Result := oBtrTable.FieldByName('ItmNum').AsInteger;
end;

procedure TOctBtr.WriteItmNum(pValue:word);
begin
  oBtrTable.FieldByName('ItmNum').AsInteger := pValue;
end;

function TOctBtr.ReadDlvDoc:Str12;
begin
  Result := oBtrTable.FieldByName('DlvDoc').AsString;
end;

procedure TOctBtr.WriteDlvDoc(pValue:Str12);
begin
  oBtrTable.FieldByName('DlvDoc').AsString := pValue;
end;

function TOctBtr.ReadDlvItm:word;
begin
  Result := oBtrTable.FieldByName('DlvItm').AsInteger;
end;

procedure TOctBtr.WriteDlvItm(pValue:word);
begin
  oBtrTable.FieldByName('DlvItm').AsInteger := pValue;
end;

function TOctBtr.ReadDlvDate:TDatetime;
begin
  Result := oBtrTable.FieldByName('DlvDate').AsDateTime;
end;

procedure TOctBtr.WriteDlvDate(pValue:TDatetime);
begin
  oBtrTable.FieldByName('DlvDate').AsDateTime := pValue;
end;

function TOctBtr.ReadGsCode:longint;
begin
  Result := oBtrTable.FieldByName('GsCode').AsInteger;
end;

procedure TOctBtr.WriteGsCode(pValue:longint);
begin
  oBtrTable.FieldByName('GsCode').AsInteger := pValue;
end;

function TOctBtr.ReadDlvQnt:double;
begin
  Result := oBtrTable.FieldByName('DlvQnt').AsFloat;
end;

procedure TOctBtr.WriteDlvQnt(pValue:double);
begin
  oBtrTable.FieldByName('DlvQnt').AsFloat := pValue;
end;

function TOctBtr.ReadCrtUser:Str8;
begin
  Result := oBtrTable.FieldByName('CrtUser').AsString;
end;

procedure TOctBtr.WriteCrtUser(pValue:Str8);
begin
  oBtrTable.FieldByName('CrtUser').AsString := pValue;
end;

function TOctBtr.ReadCrtDate:TDatetime;
begin
  Result := oBtrTable.FieldByName('CrtDate').AsDateTime;
end;

procedure TOctBtr.WriteCrtDate(pValue:TDatetime);
begin
  oBtrTable.FieldByName('CrtDate').AsDateTime := pValue;
end;

function TOctBtr.ReadCrtTime:TDatetime;
begin
  Result := oBtrTable.FieldByName('CrtTime').AsDateTime;
end;

procedure TOctBtr.WriteCrtTime(pValue:TDatetime);
begin
  oBtrTable.FieldByName('CrtTime').AsDateTime := pValue;
end;

// **************************************** PUBLIC ********************************************

function TOctBtr.Eof: boolean;
begin
  Result := oBtrTable.Eof;
end;

function TOctBtr.IsFirstRec: boolean;
begin
  Result := oBtrTable.Bof;
end;

function TOctBtr.IsLastRec: boolean;
begin
  Result := oBtrTable.Eof;
end;

function TOctBtr.Active: boolean;
begin
  Result := oBtrTable.Active;
end;

function TOctBtr.ActPos: longint;
begin
  Result := oBtrTable.ActPos;
end;

function TOctBtr.GotoPos (pActPos:longint): boolean;
begin
  Result := oBtrTable.GotoPos(pActPos);
end;

function TOctBtr.LocateDoItTdTi (pDocNum:Str12;pItmNum:word;pDlvDoc:Str12;pDlvItm:word):boolean;
begin
  SetIndex (ixDoItTdTi);
  Result := oBtrTable.FindKey([pDocNum,pItmNum,pDlvDoc,pDlvItm]);
end;

function TOctBtr.LocateDoIt (pDocNum:Str12;pItmNum:word):boolean;
begin
  SetIndex (ixDoIt);
  Result := oBtrTable.FindKey([pDocNum,pItmNum]);
end;

function TOctBtr.LocateTdTi (pDlvDoc:Str12;pDlvItm:word):boolean;
begin
  SetIndex (ixTdTi);
  Result := oBtrTable.FindKey([pDlvDoc,pDlvItm]);
end;

function TOctBtr.NearestDoItTdTi (pDocNum:Str12;pItmNum:word;pDlvDoc:Str12;pDlvItm:word):boolean;
begin
  SetIndex (ixDoItTdTi);
  Result := oBtrTable.FindNearest([pDocNum,pItmNum,pDlvDoc,pDlvItm]);
end;

function TOctBtr.NearestDoIt (pDocNum:Str12;pItmNum:word):boolean;
begin
  SetIndex (ixDoIt);
  Result := oBtrTable.FindNearest([pDocNum,pItmNum]);
end;

function TOctBtr.NearestTdTi (pDlvDoc:Str12;pDlvItm:word):boolean;
begin
  SetIndex (ixTdTi);
  Result := oBtrTable.FindNearest([pDlvDoc,pDlvItm]);
end;

procedure TOctBtr.SetIndex (pIndexName:ShortString);
begin
  If oBtrTable.IndexName<>pIndexName then oBtrTable.IndexName := pIndexName;
end;

procedure TOctBtr.Open(pBookNum:Str5);
begin
  oBookNum := pBookNum;
  oBtrTable.Open(pBookNum);
end;

procedure TOctBtr.Close;
begin
  If oBtrTable.Active then oBtrTable.Close;
end;

procedure TOctBtr.Prior;
begin
  oBtrTable.Prior;
end;

procedure TOctBtr.Next;
begin
  oBtrTable.Next;
end;

procedure TOctBtr.First;
begin
  oBtrTable.First;
end;

procedure TOctBtr.Last;
begin
  oBtrTable.Last;
end;

procedure TOctBtr.Insert;
begin
  oBtrTable.Insert;
end;

procedure TOctBtr.Edit;
begin
  oBtrTable.Edit;
end;

procedure TOctBtr.Post;
begin
  oBtrTable.Post;
end;

procedure TOctBtr.Delete;
begin
  oBtrTable.Delete;
end;

procedure TOctBtr.SwapIndex;
begin
  oBtrTable.SwapIndex;
end;

procedure TOctBtr.RestoreIndex;
begin
  oBtrTable.RestoreIndex;
end;

procedure TOctBtr.SwapStatus;
begin
  oBtrTable.SwapStatus;
end;

procedure TOctBtr.RestoreStatus;
begin
  oBtrTable.RestoreStatus;
end;

procedure TOctBtr.EnableControls;
begin
  oBtrTable.EnableControls;
end;

procedure TOctBtr.DisableControls;
begin
  oBtrTable.DisableControls;
end;

end.
