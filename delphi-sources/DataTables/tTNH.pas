unit tTNH;

interface

uses
  IcTypes, IcConv, NexPath, NexGlob, DocHand, 
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls,
  Dialogs, DB, NexBtrTable, DBTables, NexPxTable;

const
  ixTentNum = '';
  ixTnRn = 'TnRn';
  ixStatus = 'Status';
  ixResNum = 'ResNum';
  ixGroup = 'Group';
  ixMdtCode = 'MdtCode';

type
  TTnhTmp = class (TComponent)
    constructor Create;
    destructor  Destroy; override;
  private
    oTmpTable: TNexPxTable;
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
    function  ReadRooms:Str50;           procedure WriteRooms (pValue:Str50);
    function  ReadExtNum:Str20;          procedure WriteExtNum (pValue:Str20);
    function  ReadIcdNum:Str12;          procedure WriteIcdNum (pValue:Str12);
    function  ReadActPos:longint;        procedure WriteActPos (pValue:longint);
    function  ReadDvzName:Str3;          procedure WriteDvzName (pValue:Str3);
    function  ReadResNum:longint;        procedure WriteResNum (pValue:longint);
    function  ReadMdtCode:longint;       procedure WriteMdtCode (pValue:longint);
    function  ReadPayCard:Str30;         procedure WritePayCard (pValue:Str30);
  public
    // Elementarne databazove operacie
    function Eof: boolean;
    function Active: boolean;
    function LocateTentNum (pTentNum:longint):boolean;
    function LocateTnRn (pTentNum:longint;pRoomNum:longint):boolean;
    function LocateStatus (pStatus:Str1):boolean;
    function LocateResNum (pResNum:longint):boolean;
    function LocateGroup (pGroup:longint):boolean;
    function LocateMdtCode (pMdtCode:longint):boolean;

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
    property Rooms:Str50 read ReadRooms write WriteRooms;
    property ExtNum:Str20 read ReadExtNum write WriteExtNum;
    property IcdNum:Str12 read ReadIcdNum write WriteIcdNum;
    property ActPos:longint read ReadActPos write WriteActPos;
    property DvzName:Str3 read ReadDvzName write WriteDvzName;
    property ResNum:longint read ReadResNum write WriteResNum;
    property MdtCode:longint read ReadMdtCode write WriteMdtCode;
    property PayCard:Str30 read ReadPayCard write WritePayCard;
  end;

implementation

constructor TTnhTmp.Create;
begin
  oTmpTable := TmpInit ('TNH',Self);
end;

destructor TTnhTmp.Destroy;
begin
  If oTmpTable.Active then oTmpTable.Close;
  FreeAndNil (oTmpTable);
end;

// *************************************** PRIVATE ********************************************

function TTnhTmp.ReadCount:integer;
begin
  Result := oTmpTable.RecordCount;
end;

function TTnhTmp.FieldExist (pFieldName:ShortString): boolean;
begin
  Result := oTmpTable.FindField(pFieldName)<>nil;
end;

function TTnhTmp.ReadTentNum:longint;
begin
  Result := oTmpTable.FieldByName('TentNum').AsInteger;
end;

procedure TTnhTmp.WriteTentNum(pValue:longint);
begin
  oTmpTable.FieldByName('TentNum').AsInteger := pValue;
end;

function TTnhTmp.ReadRoomNum:longint;
begin
  Result := oTmpTable.FieldByName('RoomNum').AsInteger;
end;

procedure TTnhTmp.WriteRoomNum(pValue:longint);
begin
  oTmpTable.FieldByName('RoomNum').AsInteger := pValue;
end;

function TTnhTmp.ReadDateI:TDatetime;
begin
  Result := oTmpTable.FieldByName('DateI').AsDateTime;
end;

procedure TTnhTmp.WriteDateI(pValue:TDatetime);
begin
  oTmpTable.FieldByName('DateI').AsDateTime := pValue;
end;

function TTnhTmp.ReadDateO:TDatetime;
begin
  Result := oTmpTable.FieldByName('DateO').AsDateTime;
end;

procedure TTnhTmp.WriteDateO(pValue:TDatetime);
begin
  oTmpTable.FieldByName('DateO').AsDateTime := pValue;
end;

function TTnhTmp.ReadGroup:longint;
begin
  Result := oTmpTable.FieldByName('Group').AsInteger;
end;

procedure TTnhTmp.WriteGroup(pValue:longint);
begin
  oTmpTable.FieldByName('Group').AsInteger := pValue;
end;

function TTnhTmp.ReadStatus:Str1;
begin
  Result := oTmpTable.FieldByName('Status').AsString;
end;

procedure TTnhTmp.WriteStatus(pValue:Str1);
begin
  oTmpTable.FieldByName('Status').AsString := pValue;
end;

function TTnhTmp.ReadVisVal:double;
begin
  Result := oTmpTable.FieldByName('VisVal').AsFloat;
end;

procedure TTnhTmp.WriteVisVal(pValue:double);
begin
  oTmpTable.FieldByName('VisVal').AsFloat := pValue;
end;

function TTnhTmp.ReadGrpVal:double;
begin
  Result := oTmpTable.FieldByName('GrpVal').AsFloat;
end;

procedure TTnhTmp.WriteGrpVal(pValue:double);
begin
  oTmpTable.FieldByName('GrpVal').AsFloat := pValue;
end;

function TTnhTmp.ReadPayVal:double;
begin
  Result := oTmpTable.FieldByName('PayVal').AsFloat;
end;

procedure TTnhTmp.WritePayVal(pValue:double);
begin
  oTmpTable.FieldByName('PayVal').AsFloat := pValue;
end;

function TTnhTmp.ReadEndVal:double;
begin
  Result := oTmpTable.FieldByName('EndVal').AsFloat;
end;

procedure TTnhTmp.WriteEndVal(pValue:double);
begin
  oTmpTable.FieldByName('EndVal').AsFloat := pValue;
end;

function TTnhTmp.ReadCrtUser:Str8;
begin
  Result := oTmpTable.FieldByName('CrtUser').AsString;
end;

procedure TTnhTmp.WriteCrtUser(pValue:Str8);
begin
  oTmpTable.FieldByName('CrtUser').AsString := pValue;
end;

function TTnhTmp.ReadCrtDate:TDatetime;
begin
  Result := oTmpTable.FieldByName('CrtDate').AsDateTime;
end;

procedure TTnhTmp.WriteCrtDate(pValue:TDatetime);
begin
  oTmpTable.FieldByName('CrtDate').AsDateTime := pValue;
end;

function TTnhTmp.ReadCrtTime:TDatetime;
begin
  Result := oTmpTable.FieldByName('CrtTime').AsDateTime;
end;

procedure TTnhTmp.WriteCrtTime(pValue:TDatetime);
begin
  oTmpTable.FieldByName('CrtTime').AsDateTime := pValue;
end;

function TTnhTmp.ReadModUser:Str8;
begin
  Result := oTmpTable.FieldByName('ModUser').AsString;
end;

procedure TTnhTmp.WriteModUser(pValue:Str8);
begin
  oTmpTable.FieldByName('ModUser').AsString := pValue;
end;

function TTnhTmp.ReadModDate:TDatetime;
begin
  Result := oTmpTable.FieldByName('ModDate').AsDateTime;
end;

procedure TTnhTmp.WriteModDate(pValue:TDatetime);
begin
  oTmpTable.FieldByName('ModDate').AsDateTime := pValue;
end;

function TTnhTmp.ReadModTime:TDatetime;
begin
  Result := oTmpTable.FieldByName('ModTime').AsDateTime;
end;

procedure TTnhTmp.WriteModTime(pValue:TDatetime);
begin
  oTmpTable.FieldByName('ModTime').AsDateTime := pValue;
end;

function TTnhTmp.ReadRooms:Str50;
begin
  Result := oTmpTable.FieldByName('Rooms').AsString;
end;

procedure TTnhTmp.WriteRooms(pValue:Str50);
begin
  oTmpTable.FieldByName('Rooms').AsString := pValue;
end;

function TTnhTmp.ReadExtNum:Str20;
begin
  Result := oTmpTable.FieldByName('ExtNum').AsString;
end;

procedure TTnhTmp.WriteExtNum(pValue:Str20);
begin
  oTmpTable.FieldByName('ExtNum').AsString := pValue;
end;

function TTnhTmp.ReadIcdNum:Str12;
begin
  Result := oTmpTable.FieldByName('IcdNum').AsString;
end;

procedure TTnhTmp.WriteIcdNum(pValue:Str12);
begin
  oTmpTable.FieldByName('IcdNum').AsString := pValue;
end;

function TTnhTmp.ReadActPos:longint;
begin
  Result := oTmpTable.FieldByName('ActPos').AsInteger;
end;

procedure TTnhTmp.WriteActPos(pValue:longint);
begin
  oTmpTable.FieldByName('ActPos').AsInteger := pValue;
end;

function TTnhTmp.ReadDvzName:Str3;
begin
  Result := oTmpTable.FieldByName('DvzName').AsString;
end;

procedure TTnhTmp.WriteDvzName(pValue:Str3);
begin
  oTmpTable.FieldByName('DvzName').AsString := pValue;
end;

function TTnhTmp.ReadResNum:longint;
begin
  Result := oTmpTable.FieldByName('ResNum').AsInteger;
end;

procedure TTnhTmp.WriteResNum(pValue:longint);
begin
  oTmpTable.FieldByName('ResNum').AsInteger := pValue;
end;

function TTnhTmp.ReadMdtCode:longint;
begin
  Result := oTmpTable.FieldByName('MdtCode').AsInteger;
end;

procedure TTnhTmp.WriteMdtCode(pValue:longint);
begin
  oTmpTable.FieldByName('MdtCode').AsInteger := pValue;
end;

function TTnhTmp.ReadPayCard:Str30;
begin
  Result := oTmpTable.FieldByName('PayCard').AsString;
end;

procedure TTnhTmp.WritePayCard(pValue:Str30);
begin
  oTmpTable.FieldByName('PayCard').AsString := pValue;
end;

// **************************************** PUBLIC ********************************************

function TTnhTmp.Eof: boolean;
begin
  Result := oTmpTable.Eof;
end;

function TTnhTmp.Active: boolean;
begin
  Result := oTmpTable.Active;
end;

function TTnhTmp.LocateTentNum (pTentNum:longint):boolean;
begin
  SetIndex (ixTentNum);
  Result := oTmpTable.FindKey([pTentNum]);
end;

function TTnhTmp.LocateTnRn (pTentNum:longint;pRoomNum:longint):boolean;
begin
  SetIndex (ixTnRn);
  Result := oTmpTable.FindKey([pTentNum,pRoomNum]);
end;

function TTnhTmp.LocateStatus (pStatus:Str1):boolean;
begin
  SetIndex (ixStatus);
  Result := oTmpTable.FindKey([pStatus]);
end;

function TTnhTmp.LocateResNum (pResNum:longint):boolean;
begin
  SetIndex (ixResNum);
  Result := oTmpTable.FindKey([pResNum]);
end;

function TTnhTmp.LocateGroup (pGroup:longint):boolean;
begin
  SetIndex (ixGroup);
  Result := oTmpTable.FindKey([pGroup]);
end;

function TTnhTmp.LocateMdtCode (pMdtCode:longint):boolean;
begin
  SetIndex (ixMdtCode);
  Result := oTmpTable.FindKey([pMdtCode]);
end;

procedure TTnhTmp.SetIndex (pIndexName:ShortString);
begin
  If oTmpTable.IndexName<>pIndexName then oTmpTable.IndexName := pIndexName;
end;

procedure TTnhTmp.Open;
begin
  oTmpTable.Open;
end;

procedure TTnhTmp.Close;
begin
  If oTmpTable.Active then oTmpTable.Close;
end;

procedure TTnhTmp.Prior;
begin
  oTmpTable.Prior;
end;

procedure TTnhTmp.Next;
begin
  oTmpTable.Next;
end;

procedure TTnhTmp.First;
begin
  oTmpTable.First;
end;

procedure TTnhTmp.Last;
begin
  oTmpTable.Last;
end;

procedure TTnhTmp.Insert;
begin
  oTmpTable.Insert;
end;

procedure TTnhTmp.Edit;
begin
  oTmpTable.Edit;
end;

procedure TTnhTmp.Post;
var mEdit:boolean;
begin
  oTmpTable.Post;
end;

procedure TTnhTmp.Delete;
begin
  oTmpTable.Delete;
end;

procedure TTnhTmp.SwapIndex;
begin
  oTmpTable.SwapIndex;
end;

procedure TTnhTmp.RestoreIndex;
begin
  oTmpTable.RestoreIndex;
end;

procedure TTnhTmp.SwapStatus;
begin
  oTmpTable.SwapStatus;
end;

procedure TTnhTmp.RestoreStatus;
begin
  oTmpTable.RestoreStatus;
end;

procedure TTnhTmp.EnableControls;
begin
  oTmpTable.EnableControls;
end;

procedure TTnhTmp.DisableControls;
begin
  oTmpTable.DisableControls;
end;

end.
{MOD 1906001}
