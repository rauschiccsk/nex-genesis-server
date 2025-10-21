unit bTNE;

interface

uses
  IcTypes, IcConv, NexPath, NexGlob,
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls,
  Dialogs, DB, NexBtrTable, DBTables, NexPxTable;

const
  ixEvNum = 'EvNum';
  ixTentNum = 'TentNum';
  ixRoomNum = 'RoomNum';
  ixVisNum = 'VisNum';
  ixEdEt = 'EdEt';
  ixEvTime = 'EvTime';
  ixEvType = 'EvType';

type
  TTneBtr = class (TComponent)
    constructor Create; overload;
    destructor  Destroy; override;
  private
    oBtrTable: TNexBtrTable;
    function ReadCount:integer;
    function FieldExist (pFieldName:ShortString): boolean;
    // Pristup k databazovym poliam
    function  ReadEvNum:longint;         procedure WriteEvNum (pValue:longint);
    function  ReadTentNum:longint;       procedure WriteTentNum (pValue:longint);
    function  ReadRoomNum:longint;       procedure WriteRoomNum (pValue:longint);
    function  ReadVisNum:longint;        procedure WriteVisNum (pValue:longint);
    function  ReadBegDate:TDatetime;     procedure WriteBegDate (pValue:TDatetime);
    function  ReadEndDate:TDatetime;     procedure WriteEndDate (pValue:TDatetime);
    function  ReadEvType:Str1;           procedure WriteEvType (pValue:Str1);
    function  ReadEvView:Str1;           procedure WriteEvView (pValue:Str1);
    function  ReadEvDay:Str20;           procedure WriteEvDay (pValue:Str20);
    function  ReadEvDate:TDatetime;      procedure WriteEvDate (pValue:TDatetime);
    function  ReadEvTime:TDatetime;      procedure WriteEvTime (pValue:TDatetime);
    function  ReadEvBeft:TDatetime;      procedure WriteEvBeft (pValue:TDatetime);
    function  ReadEvMsg:Str250;          procedure WriteEvMsg (pValue:Str250);
    function  ReadEvFile:Str250;         procedure WriteEvFile (pValue:Str250);
    function  ReadEvTel:Str30;           procedure WriteEvTel (pValue:Str30);
    function  ReadEvMail:Str60;          procedure WriteEvMail (pValue:Str60);
    function  ReadEvDev:Str30;           procedure WriteEvDev (pValue:Str30);
    function  ReadEvNoti:Str60;          procedure WriteEvNoti (pValue:Str60);
    function  ReadEvSta:Str1;            procedure WriteEvSta (pValue:Str1);
    function  ReadRoomCode:Str15;        procedure WriteRoomCode (pValue:Str15);
    function  ReadVisName:Str50;         procedure WriteVisName (pValue:Str50);
    function  ReadCrtUser:Str8;          procedure WriteCrtUser (pValue:Str8);
    function  ReadCrtDate:TDatetime;     procedure WriteCrtDate (pValue:TDatetime);
    function  ReadCrtTime:TDatetime;     procedure WriteCrtTime (pValue:TDatetime);
    function  ReadModUser:Str8;          procedure WriteModUser (pValue:Str8);
    function  ReadModDate:TDatetime;     procedure WriteModDate (pValue:TDatetime);
    function  ReadModTime:TDatetime;     procedure WriteModTime (pValue:TDatetime);
  public
    constructor Create(pPath:ShortString); overload;
    // Elementarne databazove operacie
    function Eof: boolean;
    function IsFirstRec: boolean;
    function IsLastRec: boolean;
    function Active: boolean;
    function ActPos: longint;
    function GotoPos (pActPos:longint): boolean;
    function LocateEvNum (pEvNum:longint):boolean;
    function LocateTentNum (pTentNum:longint):boolean;
    function LocateRoomNum (pRoomNum:longint):boolean;
    function LocateVisNum (pVisNum:longint):boolean;
    function LocateEdEt (pEvDate:TDatetime;pEvTime:TDatetime):boolean;
    function LocateEvTime (pEvTime:TDatetime):boolean;
    function LocateEvType (pEvType:Str1):boolean;
    function NearestEvNum (pEvNum:longint):boolean;
    function NearestTentNum (pTentNum:longint):boolean;
    function NearestRoomNum (pRoomNum:longint):boolean;
    function NearestVisNum (pVisNum:longint):boolean;
    function NearestEdEt (pEvDate:TDatetime;pEvTime:TDatetime):boolean;
    function NearestEvTime (pEvTime:TDatetime):boolean;
    function NearestEvType (pEvType:Str1):boolean;

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
    property EvNum:longint read ReadEvNum write WriteEvNum;
    property TentNum:longint read ReadTentNum write WriteTentNum;
    property RoomNum:longint read ReadRoomNum write WriteRoomNum;
    property VisNum:longint read ReadVisNum write WriteVisNum;
    property BegDate:TDatetime read ReadBegDate write WriteBegDate;
    property EndDate:TDatetime read ReadEndDate write WriteEndDate;
    property EvType:Str1 read ReadEvType write WriteEvType;
    property EvView:Str1 read ReadEvView write WriteEvView;
    property EvDay:Str20 read ReadEvDay write WriteEvDay;
    property EvDate:TDatetime read ReadEvDate write WriteEvDate;
    property EvTime:TDatetime read ReadEvTime write WriteEvTime;
    property EvBeft:TDatetime read ReadEvBeft write WriteEvBeft;
    property EvMsg:Str250 read ReadEvMsg write WriteEvMsg;
    property EvFile:Str250 read ReadEvFile write WriteEvFile;
    property EvTel:Str30 read ReadEvTel write WriteEvTel;
    property EvMail:Str60 read ReadEvMail write WriteEvMail;
    property EvDev:Str30 read ReadEvDev write WriteEvDev;
    property EvNoti:Str60 read ReadEvNoti write WriteEvNoti;
    property EvSta:Str1 read ReadEvSta write WriteEvSta;
    property RoomCode:Str15 read ReadRoomCode write WriteRoomCode;
    property VisName:Str50 read ReadVisName write WriteVisName;
    property CrtUser:Str8 read ReadCrtUser write WriteCrtUser;
    property CrtDate:TDatetime read ReadCrtDate write WriteCrtDate;
    property CrtTime:TDatetime read ReadCrtTime write WriteCrtTime;
    property ModUser:Str8 read ReadModUser write WriteModUser;
    property ModDate:TDatetime read ReadModDate write WriteModDate;
    property ModTime:TDatetime read ReadModTime write WriteModTime;
  end;

implementation

constructor TTneBtr.Create;
begin
  oBtrTable := BtrInit ('TNE',gPath.HtlPath,Self);
end;

constructor TTneBtr.Create(pPath:ShortString);
begin
  oBtrTable := BtrInit ('TNE',pPath,Self);
end;

destructor TTneBtr.Destroy;
begin
  oBtrTable.Close;  FreeAndNil (oBtrTable);
end;

// *************************************** PRIVATE ********************************************

function TTneBtr.ReadCount:integer;
begin
  Result := oBtrTable.RecordCount;
end;

function TTneBtr.FieldExist (pFieldName:ShortString): boolean;
begin
  Result := oBtrTable.FindField(pFieldName)<>nil;
end;

function TTneBtr.ReadEvNum:longint;
begin
  Result := oBtrTable.FieldByName('EvNum').AsInteger;
end;

procedure TTneBtr.WriteEvNum(pValue:longint);
begin
  oBtrTable.FieldByName('EvNum').AsInteger := pValue;
end;

function TTneBtr.ReadTentNum:longint;
begin
  Result := oBtrTable.FieldByName('TentNum').AsInteger;
end;

procedure TTneBtr.WriteTentNum(pValue:longint);
begin
  oBtrTable.FieldByName('TentNum').AsInteger := pValue;
end;

function TTneBtr.ReadRoomNum:longint;
begin
  Result := oBtrTable.FieldByName('RoomNum').AsInteger;
end;

procedure TTneBtr.WriteRoomNum(pValue:longint);
begin
  oBtrTable.FieldByName('RoomNum').AsInteger := pValue;
end;

function TTneBtr.ReadVisNum:longint;
begin
  Result := oBtrTable.FieldByName('VisNum').AsInteger;
end;

procedure TTneBtr.WriteVisNum(pValue:longint);
begin
  oBtrTable.FieldByName('VisNum').AsInteger := pValue;
end;

function TTneBtr.ReadBegDate:TDatetime;
begin
  Result := oBtrTable.FieldByName('BegDate').AsDateTime;
end;

procedure TTneBtr.WriteBegDate(pValue:TDatetime);
begin
  oBtrTable.FieldByName('BegDate').AsDateTime := pValue;
end;

function TTneBtr.ReadEndDate:TDatetime;
begin
  Result := oBtrTable.FieldByName('EndDate').AsDateTime;
end;

procedure TTneBtr.WriteEndDate(pValue:TDatetime);
begin
  oBtrTable.FieldByName('EndDate').AsDateTime := pValue;
end;

function TTneBtr.ReadEvType:Str1;
begin
  Result := oBtrTable.FieldByName('EvType').AsString;
end;

procedure TTneBtr.WriteEvType(pValue:Str1);
begin
  oBtrTable.FieldByName('EvType').AsString := pValue;
end;

function TTneBtr.ReadEvView:Str1;
begin
  Result := oBtrTable.FieldByName('EvView').AsString;
end;

procedure TTneBtr.WriteEvView(pValue:Str1);
begin
  oBtrTable.FieldByName('EvView').AsString := pValue;
end;

function TTneBtr.ReadEvDay:Str20;
begin
  Result := oBtrTable.FieldByName('EvDay').AsString;
end;

procedure TTneBtr.WriteEvDay(pValue:Str20);
begin
  oBtrTable.FieldByName('EvDay').AsString := pValue;
end;

function TTneBtr.ReadEvDate:TDatetime;
begin
  Result := oBtrTable.FieldByName('EvDate').AsDateTime;
end;

procedure TTneBtr.WriteEvDate(pValue:TDatetime);
begin
  oBtrTable.FieldByName('EvDate').AsDateTime := pValue;
end;

function TTneBtr.ReadEvTime:TDatetime;
begin
  Result := oBtrTable.FieldByName('EvTime').AsDateTime;
end;

procedure TTneBtr.WriteEvTime(pValue:TDatetime);
begin
  oBtrTable.FieldByName('EvTime').AsDateTime := pValue;
end;

function TTneBtr.ReadEvBeft:TDatetime;
begin
  Result := oBtrTable.FieldByName('EvBeft').AsDateTime;
end;

procedure TTneBtr.WriteEvBeft(pValue:TDatetime);
begin
  oBtrTable.FieldByName('EvBeft').AsDateTime := pValue;
end;

function TTneBtr.ReadEvMsg:Str250;
begin
  Result := oBtrTable.FieldByName('EvMsg').AsString;
end;

procedure TTneBtr.WriteEvMsg(pValue:Str250);
begin
  oBtrTable.FieldByName('EvMsg').AsString := pValue;
end;

function TTneBtr.ReadEvFile:Str250;
begin
  Result := oBtrTable.FieldByName('EvFile').AsString;
end;

procedure TTneBtr.WriteEvFile(pValue:Str250);
begin
  oBtrTable.FieldByName('EvFile').AsString := pValue;
end;

function TTneBtr.ReadEvTel:Str30;
begin
  Result := oBtrTable.FieldByName('EvTel').AsString;
end;

procedure TTneBtr.WriteEvTel(pValue:Str30);
begin
  oBtrTable.FieldByName('EvTel').AsString := pValue;
end;

function TTneBtr.ReadEvMail:Str60;
begin
  Result := oBtrTable.FieldByName('EvMail').AsString;
end;

procedure TTneBtr.WriteEvMail(pValue:Str60);
begin
  oBtrTable.FieldByName('EvMail').AsString := pValue;
end;

function TTneBtr.ReadEvDev:Str30;
begin
  Result := oBtrTable.FieldByName('EvDev').AsString;
end;

procedure TTneBtr.WriteEvDev(pValue:Str30);
begin
  oBtrTable.FieldByName('EvDev').AsString := pValue;
end;

function TTneBtr.ReadEvNoti:Str60;
begin
  Result := oBtrTable.FieldByName('EvNoti').AsString;
end;

procedure TTneBtr.WriteEvNoti(pValue:Str60);
begin
  oBtrTable.FieldByName('EvNoti').AsString := pValue;
end;

function TTneBtr.ReadEvSta:Str1;
begin
  Result := oBtrTable.FieldByName('EvSta').AsString;
end;

procedure TTneBtr.WriteEvSta(pValue:Str1);
begin
  oBtrTable.FieldByName('EvSta').AsString := pValue;
end;

function TTneBtr.ReadRoomCode:Str15;
begin
  Result := oBtrTable.FieldByName('RoomCode').AsString;
end;

procedure TTneBtr.WriteRoomCode(pValue:Str15);
begin
  oBtrTable.FieldByName('RoomCode').AsString := pValue;
end;

function TTneBtr.ReadVisName:Str50;
begin
  Result := oBtrTable.FieldByName('VisName').AsString;
end;

procedure TTneBtr.WriteVisName(pValue:Str50);
begin
  oBtrTable.FieldByName('VisName').AsString := pValue;
end;

function TTneBtr.ReadCrtUser:Str8;
begin
  Result := oBtrTable.FieldByName('CrtUser').AsString;
end;

procedure TTneBtr.WriteCrtUser(pValue:Str8);
begin
  oBtrTable.FieldByName('CrtUser').AsString := pValue;
end;

function TTneBtr.ReadCrtDate:TDatetime;
begin
  Result := oBtrTable.FieldByName('CrtDate').AsDateTime;
end;

procedure TTneBtr.WriteCrtDate(pValue:TDatetime);
begin
  oBtrTable.FieldByName('CrtDate').AsDateTime := pValue;
end;

function TTneBtr.ReadCrtTime:TDatetime;
begin
  Result := oBtrTable.FieldByName('CrtTime').AsDateTime;
end;

procedure TTneBtr.WriteCrtTime(pValue:TDatetime);
begin
  oBtrTable.FieldByName('CrtTime').AsDateTime := pValue;
end;

function TTneBtr.ReadModUser:Str8;
begin
  Result := oBtrTable.FieldByName('ModUser').AsString;
end;

procedure TTneBtr.WriteModUser(pValue:Str8);
begin
  oBtrTable.FieldByName('ModUser').AsString := pValue;
end;

function TTneBtr.ReadModDate:TDatetime;
begin
  Result := oBtrTable.FieldByName('ModDate').AsDateTime;
end;

procedure TTneBtr.WriteModDate(pValue:TDatetime);
begin
  oBtrTable.FieldByName('ModDate').AsDateTime := pValue;
end;

function TTneBtr.ReadModTime:TDatetime;
begin
  Result := oBtrTable.FieldByName('ModTime').AsDateTime;
end;

procedure TTneBtr.WriteModTime(pValue:TDatetime);
begin
  oBtrTable.FieldByName('ModTime').AsDateTime := pValue;
end;

// **************************************** PUBLIC ********************************************

function TTneBtr.Eof: boolean;
begin
  Result := oBtrTable.Eof;
end;

function TTneBtr.IsFirstRec: boolean;
begin
  Result := oBtrTable.Bof;
end;

function TTneBtr.IsLastRec: boolean;
begin
  Result := oBtrTable.Eof;
end;

function TTneBtr.Active: boolean;
begin
  Result := oBtrTable.Active;
end;

function TTneBtr.ActPos: longint;
begin
  Result := oBtrTable.ActPos;
end;

function TTneBtr.GotoPos (pActPos:longint): boolean;
begin
  Result := oBtrTable.GotoPos(pActPos);
end;

function TTneBtr.LocateEvNum (pEvNum:longint):boolean;
begin
  SetIndex (ixEvNum);
  Result := oBtrTable.FindKey([pEvNum]);
end;

function TTneBtr.LocateTentNum (pTentNum:longint):boolean;
begin
  SetIndex (ixTentNum);
  Result := oBtrTable.FindKey([pTentNum]);
end;

function TTneBtr.LocateRoomNum (pRoomNum:longint):boolean;
begin
  SetIndex (ixRoomNum);
  Result := oBtrTable.FindKey([pRoomNum]);
end;

function TTneBtr.LocateVisNum (pVisNum:longint):boolean;
begin
  SetIndex (ixVisNum);
  Result := oBtrTable.FindKey([pVisNum]);
end;

function TTneBtr.LocateEdEt (pEvDate:TDatetime;pEvTime:TDatetime):boolean;
begin
  SetIndex (ixEdEt);
  Result := oBtrTable.FindKey([pEvDate,pEvTime]);
end;

function TTneBtr.LocateEvTime (pEvTime:TDatetime):boolean;
begin
  SetIndex (ixEvTime);
  Result := oBtrTable.FindKey([pEvTime]);
end;

function TTneBtr.LocateEvType (pEvType:Str1):boolean;
begin
  SetIndex (ixEvType);
  Result := oBtrTable.FindKey([pEvType]);
end;

function TTneBtr.NearestEvNum (pEvNum:longint):boolean;
begin
  SetIndex (ixEvNum);
  Result := oBtrTable.FindNearest([pEvNum]);
end;

function TTneBtr.NearestTentNum (pTentNum:longint):boolean;
begin
  SetIndex (ixTentNum);
  Result := oBtrTable.FindNearest([pTentNum]);
end;

function TTneBtr.NearestRoomNum (pRoomNum:longint):boolean;
begin
  SetIndex (ixRoomNum);
  Result := oBtrTable.FindNearest([pRoomNum]);
end;

function TTneBtr.NearestVisNum (pVisNum:longint):boolean;
begin
  SetIndex (ixVisNum);
  Result := oBtrTable.FindNearest([pVisNum]);
end;

function TTneBtr.NearestEdEt (pEvDate:TDatetime;pEvTime:TDatetime):boolean;
begin
  SetIndex (ixEdEt);
  Result := oBtrTable.FindNearest([pEvDate,pEvTime]);
end;

function TTneBtr.NearestEvTime (pEvTime:TDatetime):boolean;
begin
  SetIndex (ixEvTime);
  Result := oBtrTable.FindNearest([pEvTime]);
end;

function TTneBtr.NearestEvType (pEvType:Str1):boolean;
begin
  SetIndex (ixEvType);
  Result := oBtrTable.FindNearest([pEvType]);
end;

procedure TTneBtr.SetIndex (pIndexName:ShortString);
begin
  If oBtrTable.IndexName<>pIndexName then oBtrTable.IndexName := pIndexName;
end;

procedure TTneBtr.Open;
begin
  oBtrTable.Open;
end;

procedure TTneBtr.Close;
begin
  If oBtrTable.Active then oBtrTable.Close;
end;

procedure TTneBtr.Prior;
begin
  oBtrTable.Prior;
end;

procedure TTneBtr.Next;
begin
  oBtrTable.Next;
end;

procedure TTneBtr.First;
begin
  oBtrTable.First;
end;

procedure TTneBtr.Last;
begin
  oBtrTable.Last;
end;

procedure TTneBtr.Insert;
begin
  oBtrTable.Insert;
end;

procedure TTneBtr.Edit;
begin
  oBtrTable.Edit;
end;

procedure TTneBtr.Post;
begin
  oBtrTable.Post;
end;

procedure TTneBtr.Delete;
begin
  oBtrTable.Delete;
end;

procedure TTneBtr.SwapIndex;
begin
  oBtrTable.SwapIndex;
end;

procedure TTneBtr.RestoreIndex;
begin
  oBtrTable.RestoreIndex;
end;

procedure TTneBtr.SwapStatus;
begin
  oBtrTable.SwapStatus;
end;

procedure TTneBtr.RestoreStatus;
begin
  oBtrTable.RestoreStatus;
end;

procedure TTneBtr.EnableControls;
begin
  oBtrTable.EnableControls;
end;

procedure TTneBtr.DisableControls;
begin
  oBtrTable.DisableControls;
end;

end.
{MOD 1905010}
