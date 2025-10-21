unit bMCO;

interface

uses
  IcTypes, IcConv, NexPath, NexGlob,
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls,
  Dialogs, DB, NexBtrTable, DBTables, NexPxTable;

const
  ixDoItOdOi = 'DoItOdOi';
  ixDoIt = 'DoIt';
  ixOdOi = 'OdOi';

type
  TMcoBtr = class (TComponent)
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
    function  ReadOcdNum:Str12;          procedure WriteOcdNum (pValue:Str12);
    function  ReadOcdItm:word;           procedure WriteOcdItm (pValue:word);
    function  ReadOcdDat:TDatetime;      procedure WriteOcdDat (pValue:TDatetime);
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
    function LocateDoItOdOi (pDocNum:Str12;pItmNum:word;pOcdNum:Str12;pOcdItm:word):boolean;
    function LocateDoIt (pDocNum:Str12;pItmNum:word):boolean;
    function LocateOdOi (pOcdNum:Str12;pOcdItm:word):boolean;
    function NearestDoItOdOi (pDocNum:Str12;pItmNum:word;pOcdNum:Str12;pOcdItm:word):boolean;
    function NearestDoIt (pDocNum:Str12;pItmNum:word):boolean;
    function NearestOdOi (pOcdNum:Str12;pOcdItm:word):boolean;

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

constructor TMcoBtr.Create;
begin
  oBtrTable := BtrInit ('MCO',gPath.StkPath,Self);
end;

constructor TMcoBtr.Create(pPath:ShortString);
begin
  oBtrTable := BtrInit ('MCO',pPath,Self);
end;

destructor TMcoBtr.Destroy;
begin
  oBtrTable.Close;  FreeAndNil (oBtrTable);
end;

// *************************************** PRIVATE ********************************************

function TMcoBtr.ReadCount:integer;
begin
  Result := oBtrTable.RecordCount;
end;

function TMcoBtr.FieldExist (pFieldName:ShortString): boolean;
begin
  Result := oBtrTable.FindField(pFieldName)<>nil;
end;

function TMcoBtr.ReadDocNum:Str12;
begin
  Result := oBtrTable.FieldByName('DocNum').AsString;
end;

procedure TMcoBtr.WriteDocNum(pValue:Str12);
begin
  oBtrTable.FieldByName('DocNum').AsString := pValue;
end;

function TMcoBtr.ReadItmNum:word;
begin
  Result := oBtrTable.FieldByName('ItmNum').AsInteger;
end;

procedure TMcoBtr.WriteItmNum(pValue:word);
begin
  oBtrTable.FieldByName('ItmNum').AsInteger := pValue;
end;

function TMcoBtr.ReadOcdNum:Str12;
begin
  Result := oBtrTable.FieldByName('OcdNum').AsString;
end;

procedure TMcoBtr.WriteOcdNum(pValue:Str12);
begin
  oBtrTable.FieldByName('OcdNum').AsString := pValue;
end;

function TMcoBtr.ReadOcdItm:word;
begin
  Result := oBtrTable.FieldByName('OcdItm').AsInteger;
end;

procedure TMcoBtr.WriteOcdItm(pValue:word);
begin
  oBtrTable.FieldByName('OcdItm').AsInteger := pValue;
end;

function TMcoBtr.ReadOcdDat:TDatetime;
begin
  Result := oBtrTable.FieldByName('OcdDat').AsDateTime;
end;

procedure TMcoBtr.WriteOcdDat(pValue:TDatetime);
begin
  oBtrTable.FieldByName('OcdDat').AsDateTime := pValue;
end;

function TMcoBtr.ReadGsCode:longint;
begin
  Result := oBtrTable.FieldByName('GsCode').AsInteger;
end;

procedure TMcoBtr.WriteGsCode(pValue:longint);
begin
  oBtrTable.FieldByName('GsCode').AsInteger := pValue;
end;

function TMcoBtr.ReadDlvQnt:double;
begin
  Result := oBtrTable.FieldByName('DlvQnt').AsFloat;
end;

procedure TMcoBtr.WriteDlvQnt(pValue:double);
begin
  oBtrTable.FieldByName('DlvQnt').AsFloat := pValue;
end;

function TMcoBtr.ReadCrtUser:Str8;
begin
  Result := oBtrTable.FieldByName('CrtUser').AsString;
end;

procedure TMcoBtr.WriteCrtUser(pValue:Str8);
begin
  oBtrTable.FieldByName('CrtUser').AsString := pValue;
end;

function TMcoBtr.ReadCrtDate:TDatetime;
begin
  Result := oBtrTable.FieldByName('CrtDate').AsDateTime;
end;

procedure TMcoBtr.WriteCrtDate(pValue:TDatetime);
begin
  oBtrTable.FieldByName('CrtDate').AsDateTime := pValue;
end;

function TMcoBtr.ReadCrtTime:TDatetime;
begin
  Result := oBtrTable.FieldByName('CrtTime').AsDateTime;
end;

procedure TMcoBtr.WriteCrtTime(pValue:TDatetime);
begin
  oBtrTable.FieldByName('CrtTime').AsDateTime := pValue;
end;

// **************************************** PUBLIC ********************************************

function TMcoBtr.Eof: boolean;
begin
  Result := oBtrTable.Eof;
end;

function TMcoBtr.IsFirstRec: boolean;
begin
  Result := oBtrTable.Bof;
end;

function TMcoBtr.IsLastRec: boolean;
begin
  Result := oBtrTable.Eof;
end;

function TMcoBtr.Active: boolean;
begin
  Result := oBtrTable.Active;
end;

function TMcoBtr.ActPos: longint;
begin
  Result := oBtrTable.ActPos;
end;

function TMcoBtr.GotoPos (pActPos:longint): boolean;
begin
  Result := oBtrTable.GotoPos(pActPos);
end;

function TMcoBtr.LocateDoItOdOi (pDocNum:Str12;pItmNum:word;pOcdNum:Str12;pOcdItm:word):boolean;
begin
  SetIndex (ixDoItOdOi);
  Result := oBtrTable.FindKey([pDocNum,pItmNum,pOcdNum,pOcdItm]);
end;

function TMcoBtr.LocateDoIt (pDocNum:Str12;pItmNum:word):boolean;
begin
  SetIndex (ixDoIt);
  Result := oBtrTable.FindKey([pDocNum,pItmNum]);
end;

function TMcoBtr.LocateOdOi (pOcdNum:Str12;pOcdItm:word):boolean;
begin
  SetIndex (ixOdOi);
  Result := oBtrTable.FindKey([pOcdNum,pOcdItm]);
end;

function TMcoBtr.NearestDoItOdOi (pDocNum:Str12;pItmNum:word;pOcdNum:Str12;pOcdItm:word):boolean;
begin
  SetIndex (ixDoItOdOi);
  Result := oBtrTable.FindNearest([pDocNum,pItmNum,pOcdNum,pOcdItm]);
end;

function TMcoBtr.NearestDoIt (pDocNum:Str12;pItmNum:word):boolean;
begin
  SetIndex (ixDoIt);
  Result := oBtrTable.FindNearest([pDocNum,pItmNum]);
end;

function TMcoBtr.NearestOdOi (pOcdNum:Str12;pOcdItm:word):boolean;
begin
  SetIndex (ixOdOi);
  Result := oBtrTable.FindNearest([pOcdNum,pOcdItm]);
end;

procedure TMcoBtr.SetIndex (pIndexName:ShortString);
begin
  If oBtrTable.IndexName<>pIndexName then oBtrTable.IndexName := pIndexName;
end;

procedure TMcoBtr.Open(pBookNum:Str5);
begin
  oBookNum := pBookNum;
  oBtrTable.Open(pBookNum);
end;

procedure TMcoBtr.Close;
begin
  If oBtrTable.Active then oBtrTable.Close;
end;

procedure TMcoBtr.Prior;
begin
  oBtrTable.Prior;
end;

procedure TMcoBtr.Next;
begin
  oBtrTable.Next;
end;

procedure TMcoBtr.First;
begin
  oBtrTable.First;
end;

procedure TMcoBtr.Last;
begin
  oBtrTable.Last;
end;

procedure TMcoBtr.Insert;
begin
  oBtrTable.Insert;
end;

procedure TMcoBtr.Edit;
begin
  oBtrTable.Edit;
end;

procedure TMcoBtr.Post;
begin
  oBtrTable.Post;
end;

procedure TMcoBtr.Delete;
begin
  oBtrTable.Delete;
end;

procedure TMcoBtr.SwapIndex;
begin
  oBtrTable.SwapIndex;
end;

procedure TMcoBtr.RestoreIndex;
begin
  oBtrTable.RestoreIndex;
end;

procedure TMcoBtr.SwapStatus;
begin
  oBtrTable.SwapStatus;
end;

procedure TMcoBtr.RestoreStatus;
begin
  oBtrTable.RestoreStatus;
end;

procedure TMcoBtr.EnableControls;
begin
  oBtrTable.EnableControls;
end;

procedure TMcoBtr.DisableControls;
begin
  oBtrTable.DisableControls;
end;

end.
{MOD 1930001}
