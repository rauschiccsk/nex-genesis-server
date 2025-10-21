unit bPLN;

interface

uses
  IcTypes, IcConv, NexPath, NexGlob,
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls,
  Dialogs, DB, NexBtrTable, DBTables, NexPxTable;

const
  ixEdEt = 'EdEt';
  ixEdEn = 'EdEn';
  ixLnEdEn = 'LnEdEn';
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
  TPlnBtr = class (TComponent)
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
    function  ReadLoginName:Str8;        procedure WriteLoginName (pValue:Str8);
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
    function LocateLnEdEn (pLoginName:Str8;pEvDate:TDatetime;pEvNum:longint):boolean;
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
    function NearestLnEdEn (pLoginName:Str8;pEvDate:TDatetime;pEvNum:longint):boolean;
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
    property LoginName:Str8 read ReadLoginName write WriteLoginName;
  end;

implementation

constructor TPlnBtr.Create;
begin
  oBtrTable := BtrInit ('PLN',gPath.HtlPath,Self);
end;

constructor TPlnBtr.Create(pPath:ShortString);
begin
  oBtrTable := BtrInit ('PLN',pPath,Self);
end;

destructor TPlnBtr.Destroy;
begin
  oBtrTable.Close;  FreeAndNil (oBtrTable);
end;

// *************************************** PRIVATE ********************************************

function TPlnBtr.ReadCount:integer;
begin
  Result := oBtrTable.RecordCount;
end;

function TPlnBtr.FieldExist (pFieldName:ShortString): boolean;
begin
  Result := oBtrTable.FindField(pFieldName)<>nil;
end;

function TPlnBtr.ReadEvDate:TDatetime;
begin
  Result := oBtrTable.FieldByName('EvDate').AsDateTime;
end;

procedure TPlnBtr.WriteEvDate(pValue:TDatetime);
begin
  oBtrTable.FieldByName('EvDate').AsDateTime := pValue;
end;

function TPlnBtr.ReadEvTime:TDatetime;
begin
  Result := oBtrTable.FieldByName('EvTime').AsDateTime;
end;

procedure TPlnBtr.WriteEvTime(pValue:TDatetime);
begin
  oBtrTable.FieldByName('EvTime').AsDateTime := pValue;
end;

function TPlnBtr.ReadEvTimeO:TDatetime;
begin
  Result := oBtrTable.FieldByName('EvTimeO').AsDateTime;
end;

procedure TPlnBtr.WriteEvTimeO(pValue:TDatetime);
begin
  oBtrTable.FieldByName('EvTimeO').AsDateTime := pValue;
end;

function TPlnBtr.ReadEvTimeB:TDatetime;
begin
  Result := oBtrTable.FieldByName('EvTimeB').AsDateTime;
end;

procedure TPlnBtr.WriteEvTimeB(pValue:TDatetime);
begin
  oBtrTable.FieldByName('EvTimeB').AsDateTime := pValue;
end;

function TPlnBtr.ReadEvNum:longint;
begin
  Result := oBtrTable.FieldByName('EvNum').AsInteger;
end;

procedure TPlnBtr.WriteEvNum(pValue:longint);
begin
  oBtrTable.FieldByName('EvNum').AsInteger := pValue;
end;

function TPlnBtr.ReadTentNum:longint;
begin
  Result := oBtrTable.FieldByName('TentNum').AsInteger;
end;

procedure TPlnBtr.WriteTentNum(pValue:longint);
begin
  oBtrTable.FieldByName('TentNum').AsInteger := pValue;
end;

function TPlnBtr.ReadRoomNum:longint;
begin
  Result := oBtrTable.FieldByName('RoomNum').AsInteger;
end;

procedure TPlnBtr.WriteRoomNum(pValue:longint);
begin
  oBtrTable.FieldByName('RoomNum').AsInteger := pValue;
end;

function TPlnBtr.ReadVisNum:longint;
begin
  Result := oBtrTable.FieldByName('VisNum').AsInteger;
end;

procedure TPlnBtr.WriteVisNum(pValue:longint);
begin
  oBtrTable.FieldByName('VisNum').AsInteger := pValue;
end;

function TPlnBtr.ReadEvType:Str1;
begin
  Result := oBtrTable.FieldByName('EvType').AsString;
end;

procedure TPlnBtr.WriteEvType(pValue:Str1);
begin
  oBtrTable.FieldByName('EvType').AsString := pValue;
end;

function TPlnBtr.ReadEvView:Str1;
begin
  Result := oBtrTable.FieldByName('EvView').AsString;
end;

procedure TPlnBtr.WriteEvView(pValue:Str1);
begin
  oBtrTable.FieldByName('EvView').AsString := pValue;
end;

function TPlnBtr.ReadEvMsg:Str250;
begin
  Result := oBtrTable.FieldByName('EvMsg').AsString;
end;

procedure TPlnBtr.WriteEvMsg(pValue:Str250);
begin
  oBtrTable.FieldByName('EvMsg').AsString := pValue;
end;

function TPlnBtr.ReadEvFile:Str250;
begin
  Result := oBtrTable.FieldByName('EvFile').AsString;
end;

procedure TPlnBtr.WriteEvFile(pValue:Str250);
begin
  oBtrTable.FieldByName('EvFile').AsString := pValue;
end;

function TPlnBtr.ReadEvTel:Str30;
begin
  Result := oBtrTable.FieldByName('EvTel').AsString;
end;

procedure TPlnBtr.WriteEvTel(pValue:Str30);
begin
  oBtrTable.FieldByName('EvTel').AsString := pValue;
end;

function TPlnBtr.ReadEvMail:Str60;
begin
  Result := oBtrTable.FieldByName('EvMail').AsString;
end;

procedure TPlnBtr.WriteEvMail(pValue:Str60);
begin
  oBtrTable.FieldByName('EvMail').AsString := pValue;
end;

function TPlnBtr.ReadEvDev:Str30;
begin
  Result := oBtrTable.FieldByName('EvDev').AsString;
end;

procedure TPlnBtr.WriteEvDev(pValue:Str30);
begin
  oBtrTable.FieldByName('EvDev').AsString := pValue;
end;

function TPlnBtr.ReadEvNoti:Str60;
begin
  Result := oBtrTable.FieldByName('EvNoti').AsString;
end;

procedure TPlnBtr.WriteEvNoti(pValue:Str60);
begin
  oBtrTable.FieldByName('EvNoti').AsString := pValue;
end;

function TPlnBtr.ReadVieSta:Str1;
begin
  Result := oBtrTable.FieldByName('VieSta').AsString;
end;

procedure TPlnBtr.WriteVieSta(pValue:Str1);
begin
  oBtrTable.FieldByName('VieSta').AsString := pValue;
end;

function TPlnBtr.ReadCnfSta:Str1;
begin
  Result := oBtrTable.FieldByName('CnfSta').AsString;
end;

procedure TPlnBtr.WriteCnfSta(pValue:Str1);
begin
  oBtrTable.FieldByName('CnfSta').AsString := pValue;
end;

function TPlnBtr.ReadEvSta:Str1;
begin
  Result := oBtrTable.FieldByName('EvSta').AsString;
end;

procedure TPlnBtr.WriteEvSta(pValue:Str1);
begin
  oBtrTable.FieldByName('EvSta').AsString := pValue;
end;

function TPlnBtr.ReadRoomCode:Str15;
begin
  Result := oBtrTable.FieldByName('RoomCode').AsString;
end;

procedure TPlnBtr.WriteRoomCode(pValue:Str15);
begin
  oBtrTable.FieldByName('RoomCode').AsString := pValue;
end;

function TPlnBtr.ReadVisName:Str50;
begin
  Result := oBtrTable.FieldByName('VisName').AsString;
end;

procedure TPlnBtr.WriteVisName(pValue:Str50);
begin
  oBtrTable.FieldByName('VisName').AsString := pValue;
end;

function TPlnBtr.ReadCrtUser:Str8;
begin
  Result := oBtrTable.FieldByName('CrtUser').AsString;
end;

procedure TPlnBtr.WriteCrtUser(pValue:Str8);
begin
  oBtrTable.FieldByName('CrtUser').AsString := pValue;
end;

function TPlnBtr.ReadCrtDate:TDatetime;
begin
  Result := oBtrTable.FieldByName('CrtDate').AsDateTime;
end;

procedure TPlnBtr.WriteCrtDate(pValue:TDatetime);
begin
  oBtrTable.FieldByName('CrtDate').AsDateTime := pValue;
end;

function TPlnBtr.ReadCrtTime:TDatetime;
begin
  Result := oBtrTable.FieldByName('CrtTime').AsDateTime;
end;

procedure TPlnBtr.WriteCrtTime(pValue:TDatetime);
begin
  oBtrTable.FieldByName('CrtTime').AsDateTime := pValue;
end;

function TPlnBtr.ReadModUser:Str8;
begin
  Result := oBtrTable.FieldByName('ModUser').AsString;
end;

procedure TPlnBtr.WriteModUser(pValue:Str8);
begin
  oBtrTable.FieldByName('ModUser').AsString := pValue;
end;

function TPlnBtr.ReadModDate:TDatetime;
begin
  Result := oBtrTable.FieldByName('ModDate').AsDateTime;
end;

procedure TPlnBtr.WriteModDate(pValue:TDatetime);
begin
  oBtrTable.FieldByName('ModDate').AsDateTime := pValue;
end;

function TPlnBtr.ReadModTime:TDatetime;
begin
  Result := oBtrTable.FieldByName('ModTime').AsDateTime;
end;

procedure TPlnBtr.WriteModTime(pValue:TDatetime);
begin
  oBtrTable.FieldByName('ModTime').AsDateTime := pValue;
end;

function TPlnBtr.ReadLoginName:Str8;
begin
  Result := oBtrTable.FieldByName('LoginName').AsString;
end;

procedure TPlnBtr.WriteLoginName(pValue:Str8);
begin
  oBtrTable.FieldByName('LoginName').AsString := pValue;
end;

// **************************************** PUBLIC ********************************************

function TPlnBtr.Eof: boolean;
begin
  Result := oBtrTable.Eof;
end;

function TPlnBtr.IsFirstRec: boolean;
begin
  Result := oBtrTable.Bof;
end;

function TPlnBtr.IsLastRec: boolean;
begin
  Result := oBtrTable.Eof;
end;

function TPlnBtr.Active: boolean;
begin
  Result := oBtrTable.Active;
end;

function TPlnBtr.ActPos: longint;
begin
  Result := oBtrTable.ActPos;
end;

function TPlnBtr.GotoPos (pActPos:longint): boolean;
begin
  Result := oBtrTable.GotoPos(pActPos);
end;

function TPlnBtr.LocateEdEt (pEvDate:TDatetime;pEvTime:TDatetime):boolean;
begin
  SetIndex (ixEdEt);
  Result := oBtrTable.FindKey([pEvDate,pEvTime]);
end;

function TPlnBtr.LocateEdEn (pEvDate:TDatetime;pEvNum:longint):boolean;
begin
  SetIndex (ixEdEn);
  Result := oBtrTable.FindKey([pEvDate,pEvNum]);
end;

function TPlnBtr.LocateLnEdEn (pLoginName:Str8;pEvDate:TDatetime;pEvNum:longint):boolean;
begin
  SetIndex (ixLnEdEn);
  Result := oBtrTable.FindKey([pLoginName,pEvDate,pEvNum]);
end;

function TPlnBtr.LocateTentNum (pTentNum:longint):boolean;
begin
  SetIndex (ixTentNum);
  Result := oBtrTable.FindKey([pTentNum]);
end;

function TPlnBtr.LocateEvNum (pEvNum:longint):boolean;
begin
  SetIndex (ixEvNum);
  Result := oBtrTable.FindKey([pEvNum]);
end;

function TPlnBtr.LocateRoomNum (pRoomNum:longint):boolean;
begin
  SetIndex (ixRoomNum);
  Result := oBtrTable.FindKey([pRoomNum]);
end;

function TPlnBtr.LocateVisNum (pVisNum:longint):boolean;
begin
  SetIndex (ixVisNum);
  Result := oBtrTable.FindKey([pVisNum]);
end;

function TPlnBtr.LocateEvDate (pEvDate:TDatetime):boolean;
begin
  SetIndex (ixEvDate);
  Result := oBtrTable.FindKey([pEvDate]);
end;

function TPlnBtr.LocateEvTime (pEvTime:TDatetime):boolean;
begin
  SetIndex (ixEvTime);
  Result := oBtrTable.FindKey([pEvTime]);
end;

function TPlnBtr.LocateEvType (pEvType:Str1):boolean;
begin
  SetIndex (ixEvType);
  Result := oBtrTable.FindKey([pEvType]);
end;

function TPlnBtr.LocateVieSta (pVieSta:Str1):boolean;
begin
  SetIndex (ixVieSta);
  Result := oBtrTable.FindKey([pVieSta]);
end;

function TPlnBtr.LocateCnfSta (pCnfSta:Str1):boolean;
begin
  SetIndex (ixCnfSta);
  Result := oBtrTable.FindKey([pCnfSta]);
end;

function TPlnBtr.NearestEdEt (pEvDate:TDatetime;pEvTime:TDatetime):boolean;
begin
  SetIndex (ixEdEt);
  Result := oBtrTable.FindNearest([pEvDate,pEvTime]);
end;

function TPlnBtr.NearestEdEn (pEvDate:TDatetime;pEvNum:longint):boolean;
begin
  SetIndex (ixEdEn);
  Result := oBtrTable.FindNearest([pEvDate,pEvNum]);
end;

function TPlnBtr.NearestLnEdEn (pLoginName:Str8;pEvDate:TDatetime;pEvNum:longint):boolean;
begin
  SetIndex (ixLnEdEn);
  Result := oBtrTable.FindNearest([pLoginName,pEvDate,pEvNum]);
end;

function TPlnBtr.NearestTentNum (pTentNum:longint):boolean;
begin
  SetIndex (ixTentNum);
  Result := oBtrTable.FindNearest([pTentNum]);
end;

function TPlnBtr.NearestEvNum (pEvNum:longint):boolean;
begin
  SetIndex (ixEvNum);
  Result := oBtrTable.FindNearest([pEvNum]);
end;

function TPlnBtr.NearestRoomNum (pRoomNum:longint):boolean;
begin
  SetIndex (ixRoomNum);
  Result := oBtrTable.FindNearest([pRoomNum]);
end;

function TPlnBtr.NearestVisNum (pVisNum:longint):boolean;
begin
  SetIndex (ixVisNum);
  Result := oBtrTable.FindNearest([pVisNum]);
end;

function TPlnBtr.NearestEvDate (pEvDate:TDatetime):boolean;
begin
  SetIndex (ixEvDate);
  Result := oBtrTable.FindNearest([pEvDate]);
end;

function TPlnBtr.NearestEvTime (pEvTime:TDatetime):boolean;
begin
  SetIndex (ixEvTime);
  Result := oBtrTable.FindNearest([pEvTime]);
end;

function TPlnBtr.NearestEvType (pEvType:Str1):boolean;
begin
  SetIndex (ixEvType);
  Result := oBtrTable.FindNearest([pEvType]);
end;

function TPlnBtr.NearestVieSta (pVieSta:Str1):boolean;
begin
  SetIndex (ixVieSta);
  Result := oBtrTable.FindNearest([pVieSta]);
end;

function TPlnBtr.NearestCnfSta (pCnfSta:Str1):boolean;
begin
  SetIndex (ixCnfSta);
  Result := oBtrTable.FindNearest([pCnfSta]);
end;

procedure TPlnBtr.SetIndex (pIndexName:ShortString);
begin
  If oBtrTable.IndexName<>pIndexName then oBtrTable.IndexName := pIndexName;
end;

procedure TPlnBtr.Open;
begin
  oBtrTable.Open;
end;

procedure TPlnBtr.Close;
begin
  If oBtrTable.Active then oBtrTable.Close;
end;

procedure TPlnBtr.Prior;
begin
  oBtrTable.Prior;
end;

procedure TPlnBtr.Next;
begin
  oBtrTable.Next;
end;

procedure TPlnBtr.First;
begin
  oBtrTable.First;
end;

procedure TPlnBtr.Last;
begin
  oBtrTable.Last;
end;

procedure TPlnBtr.Insert;
begin
  oBtrTable.Insert;
end;

procedure TPlnBtr.Edit;
begin
  oBtrTable.Edit;
end;

procedure TPlnBtr.Post;
begin
  oBtrTable.Post;
end;

procedure TPlnBtr.Delete;
begin
  oBtrTable.Delete;
end;

procedure TPlnBtr.SwapIndex;
begin
  oBtrTable.SwapIndex;
end;

procedure TPlnBtr.RestoreIndex;
begin
  oBtrTable.RestoreIndex;
end;

procedure TPlnBtr.SwapStatus;
begin
  oBtrTable.SwapStatus;
end;

procedure TPlnBtr.RestoreStatus;
begin
  oBtrTable.RestoreStatus;
end;

procedure TPlnBtr.EnableControls;
begin
  oBtrTable.EnableControls;
end;

procedure TPlnBtr.DisableControls;
begin
  oBtrTable.DisableControls;
end;

end.
{MOD 1906001}
