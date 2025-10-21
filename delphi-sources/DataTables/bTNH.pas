unit bTNH;

interface

uses
  IcTypes, IcConv, NexPath, NexGlob,
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls,
  Dialogs, DB, NexBtrTable, DBTables, NexPxTable;

const
  ixTentNum = 'TentNum';
  ixTnRn = 'TnRn';
  ixStatus = 'Status';
  ixResNum = 'ResNum';
  ixGroup = 'Group';
  ixMdtCode = 'MdtCode';

type
  TTnhBtr = class (TComponent)
    constructor Create; overload;
    destructor  Destroy; override;
  private
    oBtrTable: TNexBtrTable;
    function ReadCount:integer;
    function FieldExist (pFieldName:ShortString): boolean;
    // Pristup k databazovym poliam
    function  ReadTentNum:longint;       procedure WriteTentNum (pValue:longint);
    function  ReadRoomNum:longint;       procedure WriteRoomNum (pValue:longint);
    function  ReadDateI:TDatetime;       procedure WriteDateI (pValue:TDatetime);
    function  ReadDateO:TDatetime;       procedure WriteDateO (pValue:TDatetime);
    function  ReadGroup:longint;         procedure WriteGroup (pValue:longint);
    function  ReadStatus:Str1;           procedure WriteStatus (pValue:Str1);
    function  ReadVisVal:double;         procedure WriteVisVal (pValue:double);
    function  ReadGrpVal:double;         procedure WriteGrpVal (pValue:double);
    function  ReadPayVal:double;         procedure WritePayVal (pValue:double);
    function  ReadEndVal:double;         procedure WriteEndVal (pValue:double);
    function  ReadCrtUser:Str8;          procedure WriteCrtUser (pValue:Str8);
    function  ReadCrtDate:TDatetime;     procedure WriteCrtDate (pValue:TDatetime);
    function  ReadCrtTime:TDatetime;     procedure WriteCrtTime (pValue:TDatetime);
    function  ReadModUser:Str8;          procedure WriteModUser (pValue:Str8);
    function  ReadModDate:TDatetime;     procedure WriteModDate (pValue:TDatetime);
    function  ReadModTime:TDatetime;     procedure WriteModTime (pValue:TDatetime);
    function  ReadExtNum:Str20;          procedure WriteExtNum (pValue:Str20);
    function  ReadIcdNum:Str12;          procedure WriteIcdNum (pValue:Str12);
    function  ReadActPos:longint;        procedure WriteActPos (pValue:longint);
    function  ReadDvzName:Str3;          procedure WriteDvzName (pValue:Str3);
    function  ReadResNum:longint;        procedure WriteResNum (pValue:longint);
    function  ReadMdtCode:longint;       procedure WriteMdtCode (pValue:longint);
    function  ReadPayCard:Str30;         procedure WritePayCard (pValue:Str30);
  public
    constructor Create(pPath:ShortString); overload;
    // Elementarne databazove operacie
    function Eof: boolean;
    function IsFirstRec: boolean;
    function IsLastRec: boolean;
    function Active: boolean;
    function ActPos: longint;
    function GotoPos (pActPos:longint): boolean;
    function LocateTentNum (pTentNum:longint):boolean;
    function LocateTnRn (pTentNum:longint;pRoomNum:longint):boolean;
    function LocateStatus (pStatus:Str1):boolean;
    function LocateResNum (pResNum:longint):boolean;
    function LocateGroup (pGroup:longint):boolean;
    function LocateMdtCode (pMdtCode:longint):boolean;
    function NearestTentNum (pTentNum:longint):boolean;
    function NearestTnRn (pTentNum:longint;pRoomNum:longint):boolean;
    function NearestStatus (pStatus:Str1):boolean;
    function NearestResNum (pResNum:longint):boolean;
    function NearestGroup (pGroup:longint):boolean;
    function NearestMdtCode (pMdtCode:longint):boolean;

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
    property TentNum:longint read ReadTentNum write WriteTentNum;
    property RoomNum:longint read ReadRoomNum write WriteRoomNum;
    property DateI:TDatetime read ReadDateI write WriteDateI;
    property DateO:TDatetime read ReadDateO write WriteDateO;
    property Group:longint read ReadGroup write WriteGroup;
    property Status:Str1 read ReadStatus write WriteStatus;
    property VisVal:double read ReadVisVal write WriteVisVal;
    property GrpVal:double read ReadGrpVal write WriteGrpVal;
    property PayVal:double read ReadPayVal write WritePayVal;
    property EndVal:double read ReadEndVal write WriteEndVal;
    property CrtUser:Str8 read ReadCrtUser write WriteCrtUser;
    property CrtDate:TDatetime read ReadCrtDate write WriteCrtDate;
    property CrtTime:TDatetime read ReadCrtTime write WriteCrtTime;
    property ModUser:Str8 read ReadModUser write WriteModUser;
    property ModDate:TDatetime read ReadModDate write WriteModDate;
    property ModTime:TDatetime read ReadModTime write WriteModTime;
    property ExtNum:Str20 read ReadExtNum write WriteExtNum;
    property IcdNum:Str12 read ReadIcdNum write WriteIcdNum;
    property ActPosM:longint read ReadActPos write WriteActPos;
    property DvzName:Str3 read ReadDvzName write WriteDvzName;
    property ResNum:longint read ReadResNum write WriteResNum;
    property MdtCode:longint read ReadMdtCode write WriteMdtCode;
    property PayCard:Str30 read ReadPayCard write WritePayCard;
  end;

implementation

constructor TTnhBtr.Create;
begin
  oBtrTable := BtrInit ('TNH',gPath.HtlPath,Self);
end;

constructor TTnhBtr.Create(pPath:ShortString);
begin
  oBtrTable := BtrInit ('TNH',pPath,Self);
end;

destructor TTnhBtr.Destroy;
begin
  oBtrTable.Close;  FreeAndNil (oBtrTable);
end;

// *************************************** PRIVATE ********************************************

function TTnhBtr.ReadCount:integer;
begin
  Result := oBtrTable.RecordCount;
end;

function TTnhBtr.FieldExist (pFieldName:ShortString): boolean;
begin
  Result := oBtrTable.FindField(pFieldName)<>nil;
end;

function TTnhBtr.ReadTentNum:longint;
begin
  Result := oBtrTable.FieldByName('TentNum').AsInteger;
end;

procedure TTnhBtr.WriteTentNum(pValue:longint);
begin
  oBtrTable.FieldByName('TentNum').AsInteger := pValue;
end;

function TTnhBtr.ReadRoomNum:longint;
begin
  Result := oBtrTable.FieldByName('RoomNum').AsInteger;
end;

procedure TTnhBtr.WriteRoomNum(pValue:longint);
begin
  oBtrTable.FieldByName('RoomNum').AsInteger := pValue;
end;

function TTnhBtr.ReadDateI:TDatetime;
begin
  Result := oBtrTable.FieldByName('DateI').AsDateTime;
end;

procedure TTnhBtr.WriteDateI(pValue:TDatetime);
begin
  oBtrTable.FieldByName('DateI').AsDateTime := pValue;
end;

function TTnhBtr.ReadDateO:TDatetime;
begin
  Result := oBtrTable.FieldByName('DateO').AsDateTime;
end;

procedure TTnhBtr.WriteDateO(pValue:TDatetime);
begin
  oBtrTable.FieldByName('DateO').AsDateTime := pValue;
end;

function TTnhBtr.ReadGroup:longint;
begin
  Result := oBtrTable.FieldByName('Group').AsInteger;
end;

procedure TTnhBtr.WriteGroup(pValue:longint);
begin
  oBtrTable.FieldByName('Group').AsInteger := pValue;
end;

function TTnhBtr.ReadStatus:Str1;
begin
  Result := oBtrTable.FieldByName('Status').AsString;
end;

procedure TTnhBtr.WriteStatus(pValue:Str1);
begin
  oBtrTable.FieldByName('Status').AsString := pValue;
end;

function TTnhBtr.ReadVisVal:double;
begin
  Result := oBtrTable.FieldByName('VisVal').AsFloat;
end;

procedure TTnhBtr.WriteVisVal(pValue:double);
begin
  oBtrTable.FieldByName('VisVal').AsFloat := pValue;
end;

function TTnhBtr.ReadGrpVal:double;
begin
  Result := oBtrTable.FieldByName('GrpVal').AsFloat;
end;

procedure TTnhBtr.WriteGrpVal(pValue:double);
begin
  oBtrTable.FieldByName('GrpVal').AsFloat := pValue;
end;

function TTnhBtr.ReadPayVal:double;
begin
  Result := oBtrTable.FieldByName('PayVal').AsFloat;
end;

procedure TTnhBtr.WritePayVal(pValue:double);
begin
  oBtrTable.FieldByName('PayVal').AsFloat := pValue;
end;

function TTnhBtr.ReadEndVal:double;
begin
  Result := oBtrTable.FieldByName('EndVal').AsFloat;
end;

procedure TTnhBtr.WriteEndVal(pValue:double);
begin
  oBtrTable.FieldByName('EndVal').AsFloat := pValue;
end;

function TTnhBtr.ReadCrtUser:Str8;
begin
  Result := oBtrTable.FieldByName('CrtUser').AsString;
end;

procedure TTnhBtr.WriteCrtUser(pValue:Str8);
begin
  oBtrTable.FieldByName('CrtUser').AsString := pValue;
end;

function TTnhBtr.ReadCrtDate:TDatetime;
begin
  Result := oBtrTable.FieldByName('CrtDate').AsDateTime;
end;

procedure TTnhBtr.WriteCrtDate(pValue:TDatetime);
begin
  oBtrTable.FieldByName('CrtDate').AsDateTime := pValue;
end;

function TTnhBtr.ReadCrtTime:TDatetime;
begin
  Result := oBtrTable.FieldByName('CrtTime').AsDateTime;
end;

procedure TTnhBtr.WriteCrtTime(pValue:TDatetime);
begin
  oBtrTable.FieldByName('CrtTime').AsDateTime := pValue;
end;

function TTnhBtr.ReadModUser:Str8;
begin
  Result := oBtrTable.FieldByName('ModUser').AsString;
end;

procedure TTnhBtr.WriteModUser(pValue:Str8);
begin
  oBtrTable.FieldByName('ModUser').AsString := pValue;
end;

function TTnhBtr.ReadModDate:TDatetime;
begin
  Result := oBtrTable.FieldByName('ModDate').AsDateTime;
end;

procedure TTnhBtr.WriteModDate(pValue:TDatetime);
begin
  oBtrTable.FieldByName('ModDate').AsDateTime := pValue;
end;

function TTnhBtr.ReadModTime:TDatetime;
begin
  Result := oBtrTable.FieldByName('ModTime').AsDateTime;
end;

procedure TTnhBtr.WriteModTime(pValue:TDatetime);
begin
  oBtrTable.FieldByName('ModTime').AsDateTime := pValue;
end;

function TTnhBtr.ReadExtNum:Str20;
begin
  Result := oBtrTable.FieldByName('ExtNum').AsString;
end;

procedure TTnhBtr.WriteExtNum(pValue:Str20);
begin
  oBtrTable.FieldByName('ExtNum').AsString := pValue;
end;

function TTnhBtr.ReadIcdNum:Str12;
begin
  Result := oBtrTable.FieldByName('IcdNum').AsString;
end;

procedure TTnhBtr.WriteIcdNum(pValue:Str12);
begin
  oBtrTable.FieldByName('IcdNum').AsString := pValue;
end;

function TTnhBtr.ReadActPos:longint;
begin
  Result := oBtrTable.FieldByName('ActPos').AsInteger;
end;

procedure TTnhBtr.WriteActPos(pValue:longint);
begin
  oBtrTable.FieldByName('ActPos').AsInteger := pValue;
end;

function TTnhBtr.ReadDvzName:Str3;
begin
  Result := oBtrTable.FieldByName('DvzName').AsString;
end;

procedure TTnhBtr.WriteDvzName(pValue:Str3);
begin
  oBtrTable.FieldByName('DvzName').AsString := pValue;
end;

function TTnhBtr.ReadResNum:longint;
begin
  Result := oBtrTable.FieldByName('ResNum').AsInteger;
end;

procedure TTnhBtr.WriteResNum(pValue:longint);
begin
  oBtrTable.FieldByName('ResNum').AsInteger := pValue;
end;

function TTnhBtr.ReadMdtCode:longint;
begin
  Result := oBtrTable.FieldByName('MdtCode').AsInteger;
end;

procedure TTnhBtr.WriteMdtCode(pValue:longint);
begin
  oBtrTable.FieldByName('MdtCode').AsInteger := pValue;
end;

function TTnhBtr.ReadPayCard:Str30;
begin
  Result := oBtrTable.FieldByName('PayCard').AsString;
end;

procedure TTnhBtr.WritePayCard(pValue:Str30);
begin
  oBtrTable.FieldByName('PayCard').AsString := pValue;
end;

// **************************************** PUBLIC ********************************************

function TTnhBtr.Eof: boolean;
begin
  Result := oBtrTable.Eof;
end;

function TTnhBtr.IsFirstRec: boolean;
begin
  Result := oBtrTable.Bof;
end;

function TTnhBtr.IsLastRec: boolean;
begin
  Result := oBtrTable.Eof;
end;

function TTnhBtr.Active: boolean;
begin
  Result := oBtrTable.Active;
end;

function TTnhBtr.ActPos: longint;
begin
  Result := oBtrTable.ActPos;
end;

function TTnhBtr.GotoPos (pActPos:longint): boolean;
begin
  Result := oBtrTable.GotoPos(pActPos);
end;

function TTnhBtr.LocateTentNum (pTentNum:longint):boolean;
begin
  SetIndex (ixTentNum);
  Result := oBtrTable.FindKey([pTentNum]);
end;

function TTnhBtr.LocateTnRn (pTentNum:longint;pRoomNum:longint):boolean;
begin
  SetIndex (ixTnRn);
  Result := oBtrTable.FindKey([pTentNum,pRoomNum]);
end;

function TTnhBtr.LocateStatus (pStatus:Str1):boolean;
begin
  SetIndex (ixStatus);
  Result := oBtrTable.FindKey([pStatus]);
end;

function TTnhBtr.LocateResNum (pResNum:longint):boolean;
begin
  SetIndex (ixResNum);
  Result := oBtrTable.FindKey([pResNum]);
end;

function TTnhBtr.LocateGroup (pGroup:longint):boolean;
begin
  SetIndex (ixGroup);
  Result := oBtrTable.FindKey([pGroup]);
end;

function TTnhBtr.LocateMdtCode (pMdtCode:longint):boolean;
begin
  SetIndex (ixMdtCode);
  Result := oBtrTable.FindKey([pMdtCode]);
end;

function TTnhBtr.NearestTentNum (pTentNum:longint):boolean;
begin
  SetIndex (ixTentNum);
  Result := oBtrTable.FindNearest([pTentNum]);
end;

function TTnhBtr.NearestTnRn (pTentNum:longint;pRoomNum:longint):boolean;
begin
  SetIndex (ixTnRn);
  Result := oBtrTable.FindNearest([pTentNum,pRoomNum]);
end;

function TTnhBtr.NearestStatus (pStatus:Str1):boolean;
begin
  SetIndex (ixStatus);
  Result := oBtrTable.FindNearest([pStatus]);
end;

function TTnhBtr.NearestResNum (pResNum:longint):boolean;
begin
  SetIndex (ixResNum);
  Result := oBtrTable.FindNearest([pResNum]);
end;

function TTnhBtr.NearestGroup (pGroup:longint):boolean;
begin
  SetIndex (ixGroup);
  Result := oBtrTable.FindNearest([pGroup]);
end;

function TTnhBtr.NearestMdtCode (pMdtCode:longint):boolean;
begin
  SetIndex (ixMdtCode);
  Result := oBtrTable.FindNearest([pMdtCode]);
end;

procedure TTnhBtr.SetIndex (pIndexName:ShortString);
begin
  If oBtrTable.IndexName<>pIndexName then oBtrTable.IndexName := pIndexName;
end;

procedure TTnhBtr.Open;
begin
  oBtrTable.Open;
end;

procedure TTnhBtr.Close;
begin
  If oBtrTable.Active then oBtrTable.Close;
end;

procedure TTnhBtr.Prior;
begin
  oBtrTable.Prior;
end;

procedure TTnhBtr.Next;
begin
  oBtrTable.Next;
end;

procedure TTnhBtr.First;
begin
  oBtrTable.First;
end;

procedure TTnhBtr.Last;
begin
  oBtrTable.Last;
end;

procedure TTnhBtr.Insert;
begin
  oBtrTable.Insert;
end;

procedure TTnhBtr.Edit;
begin
  oBtrTable.Edit;
end;

procedure TTnhBtr.Post;
begin
  oBtrTable.Post;
end;

procedure TTnhBtr.Delete;
begin
  oBtrTable.Delete;
end;

procedure TTnhBtr.SwapIndex;
begin
  oBtrTable.SwapIndex;
end;

procedure TTnhBtr.RestoreIndex;
begin
  oBtrTable.RestoreIndex;
end;

procedure TTnhBtr.SwapStatus;
begin
  oBtrTable.SwapStatus;
end;

procedure TTnhBtr.RestoreStatus;
begin
  oBtrTable.RestoreStatus;
end;

procedure TTnhBtr.EnableControls;
begin
  oBtrTable.EnableControls;
end;

procedure TTnhBtr.DisableControls;
begin
  oBtrTable.DisableControls;
end;

end.
{MOD 1906001}
