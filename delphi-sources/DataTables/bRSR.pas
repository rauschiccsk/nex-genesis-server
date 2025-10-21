unit bRSR;

interface

uses
  IcTypes, IcConv, NexPath, NexGlob,
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls,
  Dialogs, DB, NexBtrTable, DBTables, NexPxTable;

const
  ixResNum = 'ResNum';
  ixRnRtBcAcFlBl = 'RnRtBcAcFlBl';

type
  TRsrBtr = class (TComponent)
    constructor Create; overload;
    destructor  Destroy; override;
  private
    oBtrTable: TNexBtrTable;
    function ReadCount:integer;
    function FieldExist (pFieldName:ShortString): boolean;
    // Pristup k databazovym poliam
    function  ReadResNum:longint;        procedure WriteResNum (pValue:longint);
    function  ReadRoomType:Str1;         procedure WriteRoomType (pValue:Str1);
    function  ReadBedCnt:longint;        procedure WriteBedCnt (pValue:longint);
    function  ReadAdbCnt:longint;        procedure WriteAdbCnt (pValue:longint);
    function  ReadFloor:longint;         procedure WriteFloor (pValue:longint);
    function  ReadBlok:longint;          procedure WriteBlok (pValue:longint);
    function  ReadDateI:TDatetime;       procedure WriteDateI (pValue:TDatetime);
    function  ReadDateO:TDatetime;       procedure WriteDateO (pValue:TDatetime);
    function  ReadItmCnt:longint;        procedure WriteItmCnt (pValue:longint);
    function  ReadResCnt:longint;        procedure WriteResCnt (pValue:longint);
    function  ReadAdultCnt:longint;      procedure WriteAdultCnt (pValue:longint);
    function  ReadChildCnt:longint;      procedure WriteChildCnt (pValue:longint);
    function  ReadBedPrice:double;       procedure WriteBedPrice (pValue:double);
    function  ReadAdbPrice:double;       procedure WriteAdbPrice (pValue:double);
    function  ReadRoomPrice:double;      procedure WriteRoomPrice (pValue:double);
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
    function LocateResNum (pResNum:longint):boolean;
    function LocateRnRtBcAcFlBl (pResNum:longint;pRoomType:Str1;pBedCnt:longint;pAdbCnt:longint;pFloor:longint;pBlok:longint):boolean;
    function NearestResNum (pResNum:longint):boolean;
    function NearestRnRtBcAcFlBl (pResNum:longint;pRoomType:Str1;pBedCnt:longint;pAdbCnt:longint;pFloor:longint;pBlok:longint):boolean;

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
    property ResNum:longint read ReadResNum write WriteResNum;
    property RoomType:Str1 read ReadRoomType write WriteRoomType;
    property BedCnt:longint read ReadBedCnt write WriteBedCnt;
    property AdbCnt:longint read ReadAdbCnt write WriteAdbCnt;
    property Floor:longint read ReadFloor write WriteFloor;
    property Blok:longint read ReadBlok write WriteBlok;
    property DateI:TDatetime read ReadDateI write WriteDateI;
    property DateO:TDatetime read ReadDateO write WriteDateO;
    property ItmCnt:longint read ReadItmCnt write WriteItmCnt;
    property ResCnt:longint read ReadResCnt write WriteResCnt;
    property AdultCnt:longint read ReadAdultCnt write WriteAdultCnt;
    property ChildCnt:longint read ReadChildCnt write WriteChildCnt;
    property BedPrice:double read ReadBedPrice write WriteBedPrice;
    property AdbPrice:double read ReadAdbPrice write WriteAdbPrice;
    property RoomPrice:double read ReadRoomPrice write WriteRoomPrice;
    property CrtUser:Str8 read ReadCrtUser write WriteCrtUser;
    property CrtDate:TDatetime read ReadCrtDate write WriteCrtDate;
    property CrtTime:TDatetime read ReadCrtTime write WriteCrtTime;
    property ModUser:Str8 read ReadModUser write WriteModUser;
    property ModDate:TDatetime read ReadModDate write WriteModDate;
    property ModTime:TDatetime read ReadModTime write WriteModTime;
  end;

implementation

constructor TRsrBtr.Create;
begin
  oBtrTable := BtrInit ('RSR',gPath.HtlPath,Self);
end;

constructor TRsrBtr.Create(pPath:ShortString);
begin
  oBtrTable := BtrInit ('RSR',pPath,Self);
end;

destructor TRsrBtr.Destroy;
begin
  oBtrTable.Close;  FreeAndNil (oBtrTable);
end;

// *************************************** PRIVATE ********************************************

function TRsrBtr.ReadCount:integer;
begin
  Result := oBtrTable.RecordCount;
end;

function TRsrBtr.FieldExist (pFieldName:ShortString): boolean;
begin
  Result := oBtrTable.FindField(pFieldName)<>nil;
end;

function TRsrBtr.ReadResNum:longint;
begin
  Result := oBtrTable.FieldByName('ResNum').AsInteger;
end;

procedure TRsrBtr.WriteResNum(pValue:longint);
begin
  oBtrTable.FieldByName('ResNum').AsInteger := pValue;
end;

function TRsrBtr.ReadRoomType:Str1;
begin
  Result := oBtrTable.FieldByName('RoomType').AsString;
end;

procedure TRsrBtr.WriteRoomType(pValue:Str1);
begin
  oBtrTable.FieldByName('RoomType').AsString := pValue;
end;

function TRsrBtr.ReadBedCnt:longint;
begin
  Result := oBtrTable.FieldByName('BedCnt').AsInteger;
end;

procedure TRsrBtr.WriteBedCnt(pValue:longint);
begin
  oBtrTable.FieldByName('BedCnt').AsInteger := pValue;
end;

function TRsrBtr.ReadAdbCnt:longint;
begin
  Result := oBtrTable.FieldByName('AdbCnt').AsInteger;
end;

procedure TRsrBtr.WriteAdbCnt(pValue:longint);
begin
  oBtrTable.FieldByName('AdbCnt').AsInteger := pValue;
end;

function TRsrBtr.ReadFloor:longint;
begin
  Result := oBtrTable.FieldByName('Floor').AsInteger;
end;

procedure TRsrBtr.WriteFloor(pValue:longint);
begin
  oBtrTable.FieldByName('Floor').AsInteger := pValue;
end;

function TRsrBtr.ReadBlok:longint;
begin
  Result := oBtrTable.FieldByName('Blok').AsInteger;
end;

procedure TRsrBtr.WriteBlok(pValue:longint);
begin
  oBtrTable.FieldByName('Blok').AsInteger := pValue;
end;

function TRsrBtr.ReadDateI:TDatetime;
begin
  Result := oBtrTable.FieldByName('DateI').AsDateTime;
end;

procedure TRsrBtr.WriteDateI(pValue:TDatetime);
begin
  oBtrTable.FieldByName('DateI').AsDateTime := pValue;
end;

function TRsrBtr.ReadDateO:TDatetime;
begin
  Result := oBtrTable.FieldByName('DateO').AsDateTime;
end;

procedure TRsrBtr.WriteDateO(pValue:TDatetime);
begin
  oBtrTable.FieldByName('DateO').AsDateTime := pValue;
end;

function TRsrBtr.ReadItmCnt:longint;
begin
  Result := oBtrTable.FieldByName('ItmCnt').AsInteger;
end;

procedure TRsrBtr.WriteItmCnt(pValue:longint);
begin
  oBtrTable.FieldByName('ItmCnt').AsInteger := pValue;
end;

function TRsrBtr.ReadResCnt:longint;
begin
  Result := oBtrTable.FieldByName('ResCnt').AsInteger;
end;

procedure TRsrBtr.WriteResCnt(pValue:longint);
begin
  oBtrTable.FieldByName('ResCnt').AsInteger := pValue;
end;

function TRsrBtr.ReadAdultCnt:longint;
begin
  Result := oBtrTable.FieldByName('AdultCnt').AsInteger;
end;

procedure TRsrBtr.WriteAdultCnt(pValue:longint);
begin
  oBtrTable.FieldByName('AdultCnt').AsInteger := pValue;
end;

function TRsrBtr.ReadChildCnt:longint;
begin
  Result := oBtrTable.FieldByName('ChildCnt').AsInteger;
end;

procedure TRsrBtr.WriteChildCnt(pValue:longint);
begin
  oBtrTable.FieldByName('ChildCnt').AsInteger := pValue;
end;

function TRsrBtr.ReadBedPrice:double;
begin
  Result := oBtrTable.FieldByName('BedPrice').AsFloat;
end;

procedure TRsrBtr.WriteBedPrice(pValue:double);
begin
  oBtrTable.FieldByName('BedPrice').AsFloat := pValue;
end;

function TRsrBtr.ReadAdbPrice:double;
begin
  Result := oBtrTable.FieldByName('AdbPrice').AsFloat;
end;

procedure TRsrBtr.WriteAdbPrice(pValue:double);
begin
  oBtrTable.FieldByName('AdbPrice').AsFloat := pValue;
end;

function TRsrBtr.ReadRoomPrice:double;
begin
  Result := oBtrTable.FieldByName('RoomPrice').AsFloat;
end;

procedure TRsrBtr.WriteRoomPrice(pValue:double);
begin
  oBtrTable.FieldByName('RoomPrice').AsFloat := pValue;
end;

function TRsrBtr.ReadCrtUser:Str8;
begin
  Result := oBtrTable.FieldByName('CrtUser').AsString;
end;

procedure TRsrBtr.WriteCrtUser(pValue:Str8);
begin
  oBtrTable.FieldByName('CrtUser').AsString := pValue;
end;

function TRsrBtr.ReadCrtDate:TDatetime;
begin
  Result := oBtrTable.FieldByName('CrtDate').AsDateTime;
end;

procedure TRsrBtr.WriteCrtDate(pValue:TDatetime);
begin
  oBtrTable.FieldByName('CrtDate').AsDateTime := pValue;
end;

function TRsrBtr.ReadCrtTime:TDatetime;
begin
  Result := oBtrTable.FieldByName('CrtTime').AsDateTime;
end;

procedure TRsrBtr.WriteCrtTime(pValue:TDatetime);
begin
  oBtrTable.FieldByName('CrtTime').AsDateTime := pValue;
end;

function TRsrBtr.ReadModUser:Str8;
begin
  Result := oBtrTable.FieldByName('ModUser').AsString;
end;

procedure TRsrBtr.WriteModUser(pValue:Str8);
begin
  oBtrTable.FieldByName('ModUser').AsString := pValue;
end;

function TRsrBtr.ReadModDate:TDatetime;
begin
  Result := oBtrTable.FieldByName('ModDate').AsDateTime;
end;

procedure TRsrBtr.WriteModDate(pValue:TDatetime);
begin
  oBtrTable.FieldByName('ModDate').AsDateTime := pValue;
end;

function TRsrBtr.ReadModTime:TDatetime;
begin
  Result := oBtrTable.FieldByName('ModTime').AsDateTime;
end;

procedure TRsrBtr.WriteModTime(pValue:TDatetime);
begin
  oBtrTable.FieldByName('ModTime').AsDateTime := pValue;
end;

// **************************************** PUBLIC ********************************************

function TRsrBtr.Eof: boolean;
begin
  Result := oBtrTable.Eof;
end;

function TRsrBtr.IsFirstRec: boolean;
begin
  Result := oBtrTable.Bof;
end;

function TRsrBtr.IsLastRec: boolean;
begin
  Result := oBtrTable.Eof;
end;

function TRsrBtr.Active: boolean;
begin
  Result := oBtrTable.Active;
end;

function TRsrBtr.ActPos: longint;
begin
  Result := oBtrTable.ActPos;
end;

function TRsrBtr.GotoPos (pActPos:longint): boolean;
begin
  Result := oBtrTable.GotoPos(pActPos);
end;

function TRsrBtr.LocateResNum (pResNum:longint):boolean;
begin
  SetIndex (ixResNum);
  Result := oBtrTable.FindKey([pResNum]);
end;

function TRsrBtr.LocateRnRtBcAcFlBl (pResNum:longint;pRoomType:Str1;pBedCnt:longint;pAdbCnt:longint;pFloor:longint;pBlok:longint):boolean;
begin
  SetIndex (ixRnRtBcAcFlBl);
  Result := oBtrTable.FindKey([pResNum,pRoomType,pBedCnt,pAdbCnt,pFloor,pBlok]);
end;

function TRsrBtr.NearestResNum (pResNum:longint):boolean;
begin
  SetIndex (ixResNum);
  Result := oBtrTable.FindNearest([pResNum]);
end;

function TRsrBtr.NearestRnRtBcAcFlBl (pResNum:longint;pRoomType:Str1;pBedCnt:longint;pAdbCnt:longint;pFloor:longint;pBlok:longint):boolean;
begin
  SetIndex (ixRnRtBcAcFlBl);
  Result := oBtrTable.FindNearest([pResNum,pRoomType,pBedCnt,pAdbCnt,pFloor,pBlok]);
end;

procedure TRsrBtr.SetIndex (pIndexName:ShortString);
begin
  If oBtrTable.IndexName<>pIndexName then oBtrTable.IndexName := pIndexName;
end;

procedure TRsrBtr.Open;
begin
  oBtrTable.Open;
end;

procedure TRsrBtr.Close;
begin
  If oBtrTable.Active then oBtrTable.Close;
end;

procedure TRsrBtr.Prior;
begin
  oBtrTable.Prior;
end;

procedure TRsrBtr.Next;
begin
  oBtrTable.Next;
end;

procedure TRsrBtr.First;
begin
  oBtrTable.First;
end;

procedure TRsrBtr.Last;
begin
  oBtrTable.Last;
end;

procedure TRsrBtr.Insert;
begin
  oBtrTable.Insert;
end;

procedure TRsrBtr.Edit;
begin
  oBtrTable.Edit;
end;

procedure TRsrBtr.Post;
begin
  oBtrTable.Post;
end;

procedure TRsrBtr.Delete;
begin
  oBtrTable.Delete;
end;

procedure TRsrBtr.SwapIndex;
begin
  oBtrTable.SwapIndex;
end;

procedure TRsrBtr.RestoreIndex;
begin
  oBtrTable.RestoreIndex;
end;

procedure TRsrBtr.SwapStatus;
begin
  oBtrTable.SwapStatus;
end;

procedure TRsrBtr.RestoreStatus;
begin
  oBtrTable.RestoreStatus;
end;

procedure TRsrBtr.EnableControls;
begin
  oBtrTable.EnableControls;
end;

procedure TRsrBtr.DisableControls;
begin
  oBtrTable.DisableControls;
end;

end.
