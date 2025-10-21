unit bTNEPLN;

interface

uses
  IcTypes, IcConv, NexPath, NexGlob,
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls,
  Dialogs, DB, NexBtrTable, DBTables, NexPxTable;

const
  ixEdEt = 'EdEt';
  ixEdEn = 'EdEn';
  ixTentNum = 'TentNum';
  ixEvNum = 'EvNum';
  ixRoomNum = 'RoomNum';
  ixVisNum = 'VisNum';
  ixEvDate = 'EvDate';
  ixEvTime = 'EvTime';
  ixEvType = 'EvType';
  ixVieSta = 'VieSta';
  ixCnfSta = 'CnfSta';

type
  TTneplnBtr = class (TComponent)
    constructor Create; overload;
    destructor  Destroy; override;
  private
    oBtrTable: TNexBtrTable;
    function ReadCount:integer;
    function FieldExist (pFieldName:ShortString): boolean;
    // Pristup k databazovym poliam
    function  ReadEvDate:TDatetime;      procedure WriteEvDate (pValue:TDatetime);
    function  ReadEvTime:TDatetime;      procedure WriteEvTime (pValue:TDatetime);
    function  ReadEvTimeO:TDatetime;     procedure WriteEvTimeO (pValue:TDatetime);
    function  ReadEvTimeB:TDatetime;     procedure WriteEvTimeB (pValue:TDatetime);
    function  ReadEvNum:longint;         procedure WriteEvNum (pValue:longint);
    function  ReadTentNum:longint;       procedure WriteTentNum (pValue:longint);
    function  ReadRoomNum:longint;       procedure WriteRoomNum (pValue:longint);
    function  ReadVisNum:longint;        procedure WriteVisNum (pValue:longint);
    function  ReadEvType:Str1;           procedure WriteEvType (pValue:Str1);
    function  ReadEvView:Str1;           procedure WriteEvView (pValue:Str1);
    function  ReadEvMsg:Str250;          procedure WriteEvMsg (pValue:Str250);
    function  ReadEvFile:Str250;         procedure WriteEvFile (pValue:Str250);
    function  ReadEvTel:Str30;           procedure WriteEvTel (pValue:Str30);
    function  ReadEvMail:Str60;          procedure WriteEvMail (pValue:Str60);
    function  ReadEvDev:Str30;           procedure WriteEvDev (pValue:Str30);
    function  ReadEvNoti:Str60;          procedure WriteEvNoti (pValue:Str60);
    function  ReadVieSta:Str1;           procedure WriteVieSta (pValue:Str1);
    function  ReadCnfSta:Str1;           procedure WriteCnfSta (pValue:Str1);
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
    function LocateEdEt (pEvDate:TDatetime;pEvTime:TDatetime):boolean;
    function LocateEdEn (pEvDate:TDatetime;pEvNum:longint):boolean;
    function LocateTentNum (pTentNum:longint):boolean;
    function LocateEvNum (pEvNum:longint):boolean;
    function LocateRoomNum (pRoomNum:longint):boolean;
    function LocateVisNum (pVisNum:longint):boolean;
    function LocateEvDate (pEvDate:TDatetime):boolean;
    function LocateEvTime (pEvTime:TDatetime):boolean;
    function LocateEvType (pEvType:Str1):boolean;
    function LocateVieSta (pVieSta:Str1):boolean;
    function LocateCnfSta (pCnfSta:Str1):boolean;
    function NearestEdEt (pEvDate:TDatetime;pEvTime:TDatetime):boolean;
    function NearestEdEn (pEvDate:TDatetime;pEvNum:longint):boolean;
    function NearestTentNum (pTentNum:longint):boolean;
    function NearestEvNum (pEvNum:longint):boolean;
    function NearestRoomNum (pRoomNum:longint):boolean;
    function NearestVisNum (pVisNum:longint):boolean;
    function NearestEvDate (pEvDate:TDatetime):boolean;
    function NearestEvTime (pEvTime:TDatetime):boolean;
    function NearestEvType (pEvType:Str1):boolean;
    function NearestVieSta (pVieSta:Str1):boolean;
    function NearestCnfSta (pCnfSta:Str1):boolean;

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
    property EvDate:TDatetime read ReadEvDate write WriteEvDate;
    property EvTime:TDatetime read ReadEvTime write WriteEvTime;
    property EvTimeO:TDatetime read ReadEvTimeO write WriteEvTimeO;
    property EvTimeB:TDatetime read ReadEvTimeB write WriteEvTimeB;
    property EvNum:longint read ReadEvNum write WriteEvNum;
    property TentNum:longint read ReadTentNum write WriteTentNum;
    property RoomNum:longint read ReadRoomNum write WriteRoomNum;
    property VisNum:longint read ReadVisNum write WriteVisNum;
    property EvType:Str1 read ReadEvType write WriteEvType;
    property EvView:Str1 read ReadEvView write WriteEvView;
    property EvMsg:Str250 read ReadEvMsg write WriteEvMsg;
    property EvFile:Str250 read ReadEvFile write WriteEvFile;
    property EvTel:Str30 read ReadEvTel write WriteEvTel;
    property EvMail:Str60 read ReadEvMail write WriteEvMail;
    property EvDev:Str30 read ReadEvDev write WriteEvDev;
    property EvNoti:Str60 read ReadEvNoti write WriteEvNoti;
    property VieSta:Str1 read ReadVieSta write WriteVieSta;
    property CnfSta:Str1 read ReadCnfSta write WriteCnfSta;
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

constructor TTneplnBtr.Create;
begin
  oBtrTable := BtrInit ('TNEPLN',gPath.HtlPath,Self);
end;

constructor TTneplnBtr.Create(pPath:ShortString);
begin
  oBtrTable := BtrInit ('TNEPLN',pPath,Self);
end;

destructor TTneplnBtr.Destroy;
begin
  oBtrTable.Close;  FreeAndNil (oBtrTable);
end;

// *************************************** PRIVATE ********************************************

function TTneplnBtr.ReadCount:integer;
begin
  Result := oBtrTable.RecordCount;
end;

function TTneplnBtr.FieldExist (pFieldName:ShortString): boolean;
begin
  Result := oBtrTable.FindField(pFieldName)<>nil;
end;

function TTneplnBtr.ReadEvDate:TDatetime;
begin
  Result := oBtrTable.FieldByName('EvDate').AsDateTime;
end;

procedure TTneplnBtr.WriteEvDate(pValue:TDatetime);
begin
  oBtrTable.FieldByName('EvDate').AsDateTime := pValue;
end;

function TTneplnBtr.ReadEvTime:TDatetime;
begin
  Result := oBtrTable.FieldByName('EvTime').AsDateTime;
end;

procedure TTneplnBtr.WriteEvTime(pValue:TDatetime);
begin
  oBtrTable.FieldByName('EvTime').AsDateTime := pValue;
end;

function TTneplnBtr.ReadEvTimeO:TDatetime;
begin
  Result := oBtrTable.FieldByName('EvTimeO').AsDateTime;
end;

procedure TTneplnBtr.WriteEvTimeO(pValue:TDatetime);
begin
  oBtrTable.FieldByName('EvTimeO').AsDateTime := pValue;
end;

function TTneplnBtr.ReadEvTimeB:TDatetime;
begin
  Result := oBtrTable.FieldByName('EvTimeB').AsDateTime;
end;

procedure TTneplnBtr.WriteEvTimeB(pValue:TDatetime);
begin
  oBtrTable.FieldByName('EvTimeB').AsDateTime := pValue;
end;

function TTneplnBtr.ReadEvNum:longint;
begin
  Result := oBtrTable.FieldByName('EvNum').AsInteger;
end;

procedure TTneplnBtr.WriteEvNum(pValue:longint);
begin
  oBtrTable.FieldByName('EvNum').AsInteger := pValue;
end;

function TTneplnBtr.ReadTentNum:longint;
begin
  Result := oBtrTable.FieldByName('TentNum').AsInteger;
end;

procedure TTneplnBtr.WriteTentNum(pValue:longint);
begin
  oBtrTable.FieldByName('TentNum').AsInteger := pValue;
end;

function TTneplnBtr.ReadRoomNum:longint;
begin
  Result := oBtrTable.FieldByName('RoomNum').AsInteger;
end;

procedure TTneplnBtr.WriteRoomNum(pValue:longint);
begin
  oBtrTable.FieldByName('RoomNum').AsInteger := pValue;
end;

function TTneplnBtr.ReadVisNum:longint;
begin
  Result := oBtrTable.FieldByName('VisNum').AsInteger;
end;

procedure TTneplnBtr.WriteVisNum(pValue:longint);
begin
  oBtrTable.FieldByName('VisNum').AsInteger := pValue;
end;

function TTneplnBtr.ReadEvType:Str1;
begin
  Result := oBtrTable.FieldByName('EvType').AsString;
end;

procedure TTneplnBtr.WriteEvType(pValue:Str1);
begin
  oBtrTable.FieldByName('EvType').AsString := pValue;
end;

function TTneplnBtr.ReadEvView:Str1;
begin
  Result := oBtrTable.FieldByName('EvView').AsString;
end;

procedure TTneplnBtr.WriteEvView(pValue:Str1);
begin
  oBtrTable.FieldByName('EvView').AsString := pValue;
end;

function TTneplnBtr.ReadEvMsg:Str250;
begin
  Result := oBtrTable.FieldByName('EvMsg').AsString;
end;

procedure TTneplnBtr.WriteEvMsg(pValue:Str250);
begin
  oBtrTable.FieldByName('EvMsg').AsString := pValue;
end;

function TTneplnBtr.ReadEvFile:Str250;
begin
  Result := oBtrTable.FieldByName('EvFile').AsString;
end;

procedure TTneplnBtr.WriteEvFile(pValue:Str250);
begin
  oBtrTable.FieldByName('EvFile').AsString := pValue;
end;

function TTneplnBtr.ReadEvTel:Str30;
begin
  Result := oBtrTable.FieldByName('EvTel').AsString;
end;

procedure TTneplnBtr.WriteEvTel(pValue:Str30);
begin
  oBtrTable.FieldByName('EvTel').AsString := pValue;
end;

function TTneplnBtr.ReadEvMail:Str60;
begin
  Result := oBtrTable.FieldByName('EvMail').AsString;
end;

procedure TTneplnBtr.WriteEvMail(pValue:Str60);
begin
  oBtrTable.FieldByName('EvMail').AsString := pValue;
end;

function TTneplnBtr.ReadEvDev:Str30;
begin
  Result := oBtrTable.FieldByName('EvDev').AsString;
end;

procedure TTneplnBtr.WriteEvDev(pValue:Str30);
begin
  oBtrTable.FieldByName('EvDev').AsString := pValue;
end;

function TTneplnBtr.ReadEvNoti:Str60;
begin
  Result := oBtrTable.FieldByName('EvNoti').AsString;
end;

procedure TTneplnBtr.WriteEvNoti(pValue:Str60);
begin
  oBtrTable.FieldByName('EvNoti').AsString := pValue;
end;

function TTneplnBtr.ReadVieSta:Str1;
begin
  Result := oBtrTable.FieldByName('VieSta').AsString;
end;

procedure TTneplnBtr.WriteVieSta(pValue:Str1);
begin
  oBtrTable.FieldByName('VieSta').AsString := pValue;
end;

function TTneplnBtr.ReadCnfSta:Str1;
begin
  Result := oBtrTable.FieldByName('CnfSta').AsString;
end;

procedure TTneplnBtr.WriteCnfSta(pValue:Str1);
begin
  oBtrTable.FieldByName('CnfSta').AsString := pValue;
end;

function TTneplnBtr.ReadEvSta:Str1;
begin
  Result := oBtrTable.FieldByName('EvSta').AsString;
end;

procedure TTneplnBtr.WriteEvSta(pValue:Str1);
begin
  oBtrTable.FieldByName('EvSta').AsString := pValue;
end;

function TTneplnBtr.ReadRoomCode:Str15;
begin
  Result := oBtrTable.FieldByName('RoomCode').AsString;
end;

procedure TTneplnBtr.WriteRoomCode(pValue:Str15);
begin
  oBtrTable.FieldByName('RoomCode').AsString := pValue;
end;

function TTneplnBtr.ReadVisName:Str50;
begin
  Result := oBtrTable.FieldByName('VisName').AsString;
end;

procedure TTneplnBtr.WriteVisName(pValue:Str50);
begin
  oBtrTable.FieldByName('VisName').AsString := pValue;
end;

function TTneplnBtr.ReadCrtUser:Str8;
begin
  Result := oBtrTable.FieldByName('CrtUser').AsString;
end;

procedure TTneplnBtr.WriteCrtUser(pValue:Str8);
begin
  oBtrTable.FieldByName('CrtUser').AsString := pValue;
end;

function TTneplnBtr.ReadCrtDate:TDatetime;
begin
  Result := oBtrTable.FieldByName('CrtDate').AsDateTime;
end;

procedure TTneplnBtr.WriteCrtDate(pValue:TDatetime);
begin
  oBtrTable.FieldByName('CrtDate').AsDateTime := pValue;
end;

function TTneplnBtr.ReadCrtTime:TDatetime;
begin
  Result := oBtrTable.FieldByName('CrtTime').AsDateTime;
end;

procedure TTneplnBtr.WriteCrtTime(pValue:TDatetime);
begin
  oBtrTable.FieldByName('CrtTime').AsDateTime := pValue;
end;

function TTneplnBtr.ReadModUser:Str8;
begin
  Result := oBtrTable.FieldByName('ModUser').AsString;
end;

procedure TTneplnBtr.WriteModUser(pValue:Str8);
begin
  oBtrTable.FieldByName('ModUser').AsString := pValue;
end;

function TTneplnBtr.ReadModDate:TDatetime;
begin
  Result := oBtrTable.FieldByName('ModDate').AsDateTime;
end;

procedure TTneplnBtr.WriteModDate(pValue:TDatetime);
begin
  oBtrTable.FieldByName('ModDate').AsDateTime := pValue;
end;

function TTneplnBtr.ReadModTime:TDatetime;
begin
  Result := oBtrTable.FieldByName('ModTime').AsDateTime;
end;

procedure TTneplnBtr.WriteModTime(pValue:TDatetime);
begin
  oBtrTable.FieldByName('ModTime').AsDateTime := pValue;
end;

// **************************************** PUBLIC ********************************************

function TTneplnBtr.Eof: boolean;
begin
  Result := oBtrTable.Eof;
end;

function TTneplnBtr.IsFirstRec: boolean;
begin
  Result := oBtrTable.Bof;
end;

function TTneplnBtr.IsLastRec: boolean;
begin
  Result := oBtrTable.Eof;
end;

function TTneplnBtr.Active: boolean;
begin
  Result := oBtrTable.Active;
end;

function TTneplnBtr.ActPos: longint;
begin
  Result := oBtrTable.ActPos;
end;

function TTneplnBtr.GotoPos (pActPos:longint): boolean;
begin
  Result := oBtrTable.GotoPos(pActPos);
end;

function TTneplnBtr.LocateEdEt (pEvDate:TDatetime;pEvTime:TDatetime):boolean;
begin
  SetIndex (ixEdEt);
  Result := oBtrTable.FindKey([pEvDate,pEvTime]);
end;

function TTneplnBtr.LocateEdEn (pEvDate:TDatetime;pEvNum:longint):boolean;
begin
  SetIndex (ixEdEn);
  Result := oBtrTable.FindKey([pEvDate,pEvNum]);
end;

function TTneplnBtr.LocateTentNum (pTentNum:longint):boolean;
begin
  SetIndex (ixTentNum);
  Result := oBtrTable.FindKey([pTentNum]);
end;

function TTneplnBtr.LocateEvNum (pEvNum:longint):boolean;
begin
  SetIndex (ixEvNum);
  Result := oBtrTable.FindKey([pEvNum]);
end;

function TTneplnBtr.LocateRoomNum (pRoomNum:longint):boolean;
begin
  SetIndex (ixRoomNum);
  Result := oBtrTable.FindKey([pRoomNum]);
end;

function TTneplnBtr.LocateVisNum (pVisNum:longint):boolean;
begin
  SetIndex (ixVisNum);
  Result := oBtrTable.FindKey([pVisNum]);
end;

function TTneplnBtr.LocateEvDate (pEvDate:TDatetime):boolean;
begin
  SetIndex (ixEvDate);
  Result := oBtrTable.FindKey([pEvDate]);
end;

function TTneplnBtr.LocateEvTime (pEvTime:TDatetime):boolean;
begin
  SetIndex (ixEvTime);
  Result := oBtrTable.FindKey([pEvTime]);
end;

function TTneplnBtr.LocateEvType (pEvType:Str1):boolean;
begin
  SetIndex (ixEvType);
  Result := oBtrTable.FindKey([pEvType]);
end;

function TTneplnBtr.LocateVieSta (pVieSta:Str1):boolean;
begin
  SetIndex (ixVieSta);
  Result := oBtrTable.FindKey([pVieSta]);
end;

function TTneplnBtr.LocateCnfSta (pCnfSta:Str1):boolean;
begin
  SetIndex (ixCnfSta);
  Result := oBtrTable.FindKey([pCnfSta]);
end;

function TTneplnBtr.NearestEdEt (pEvDate:TDatetime;pEvTime:TDatetime):boolean;
begin
  SetIndex (ixEdEt);
  Result := oBtrTable.FindNearest([pEvDate,pEvTime]);
end;

function TTneplnBtr.NearestEdEn (pEvDate:TDatetime;pEvNum:longint):boolean;
begin
  SetIndex (ixEdEn);
  Result := oBtrTable.FindNearest([pEvDate,pEvNum]);
end;

function TTneplnBtr.NearestTentNum (pTentNum:longint):boolean;
begin
  SetIndex (ixTentNum);
  Result := oBtrTable.FindNearest([pTentNum]);
end;

function TTneplnBtr.NearestEvNum (pEvNum:longint):boolean;
begin
  SetIndex (ixEvNum);
  Result := oBtrTable.FindNearest([pEvNum]);
end;

function TTneplnBtr.NearestRoomNum (pRoomNum:longint):boolean;
begin
  SetIndex (ixRoomNum);
  Result := oBtrTable.FindNearest([pRoomNum]);
end;

function TTneplnBtr.NearestVisNum (pVisNum:longint):boolean;
begin
  SetIndex (ixVisNum);
  Result := oBtrTable.FindNearest([pVisNum]);
end;

function TTneplnBtr.NearestEvDate (pEvDate:TDatetime):boolean;
begin
  SetIndex (ixEvDate);
  Result := oBtrTable.FindNearest([pEvDate]);
end;

function TTneplnBtr.NearestEvTime (pEvTime:TDatetime):boolean;
begin
  SetIndex (ixEvTime);
  Result := oBtrTable.FindNearest([pEvTime]);
end;

function TTneplnBtr.NearestEvType (pEvType:Str1):boolean;
begin
  SetIndex (ixEvType);
  Result := oBtrTable.FindNearest([pEvType]);
end;

function TTneplnBtr.NearestVieSta (pVieSta:Str1):boolean;
begin
  SetIndex (ixVieSta);
  Result := oBtrTable.FindNearest([pVieSta]);
end;

function TTneplnBtr.NearestCnfSta (pCnfSta:Str1):boolean;
begin
  SetIndex (ixCnfSta);
  Result := oBtrTable.FindNearest([pCnfSta]);
end;

procedure TTneplnBtr.SetIndex (pIndexName:ShortString);
begin
  If oBtrTable.IndexName<>pIndexName then oBtrTable.IndexName := pIndexName;
end;

procedure TTneplnBtr.Open;
begin
  oBtrTable.Open;
end;

procedure TTneplnBtr.Close;
begin
  If oBtrTable.Active then oBtrTable.Close;
end;

procedure TTneplnBtr.Prior;
begin
  oBtrTable.Prior;
end;

procedure TTneplnBtr.Next;
begin
  oBtrTable.Next;
end;

procedure TTneplnBtr.First;
begin
  oBtrTable.First;
end;

procedure TTneplnBtr.Last;
begin
  oBtrTable.Last;
end;

procedure TTneplnBtr.Insert;
begin
  oBtrTable.Insert;
end;

procedure TTneplnBtr.Edit;
begin
  oBtrTable.Edit;
end;

procedure TTneplnBtr.Post;
begin
  oBtrTable.Post;
end;

procedure TTneplnBtr.Delete;
begin
  oBtrTable.Delete;
end;

procedure TTneplnBtr.SwapIndex;
begin
  oBtrTable.SwapIndex;
end;

procedure TTneplnBtr.RestoreIndex;
begin
  oBtrTable.RestoreIndex;
end;

procedure TTneplnBtr.SwapStatus;
begin
  oBtrTable.SwapStatus;
end;

procedure TTneplnBtr.RestoreStatus;
begin
  oBtrTable.RestoreStatus;
end;

procedure TTneplnBtr.EnableControls;
begin
  oBtrTable.EnableControls;
end;

procedure TTneplnBtr.DisableControls;
begin
  oBtrTable.DisableControls;
end;

end.
{MOD 1905010}
