unit tRSR;

interface

uses
  IcTypes, IcConv, NexPath, NexGlob, DocHand, 
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls,
  Dialogs, DB, NexBtrTable, DBTables, NexPxTable;

const
  ixRnRtBcAcFlBl = '';
  ixRtBcAcFlBl = 'RtBcAcFlBl';

type
  TRsrTmp = class (TComponent)
    constructor Create;
    destructor  Destroy; override;
  private
    oTmpTable: TNexPxTable;
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
    function  ReadActPos:longint;        procedure WriteActPos (pValue:longint);
  public
    // Elementarne databazove operacie
    function Eof: boolean;
    function Active: boolean;
    function LocateRnRtBcAcFlBl (pResNum:longint;pRoomType:Str1;pBedCnt:longint;pAdbCnt:longint;pFloor:longint;pBlok:longint):boolean;
    function LocateRtBcAcFlBl (pRoomType:Str1;pBedCnt:longint;pAdbCnt:longint;pFloor:longint;pBlok:longint):boolean;

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
    property ActPos:longint read ReadActPos write WriteActPos;
  end;

implementation

constructor TRsrTmp.Create;
begin
  oTmpTable := TmpInit ('RSR',Self);
end;

destructor TRsrTmp.Destroy;
begin
  If oTmpTable.Active then oTmpTable.Close;
  FreeAndNil (oTmpTable);
end;

// *************************************** PRIVATE ********************************************

function TRsrTmp.ReadCount:integer;
begin
  Result := oTmpTable.RecordCount;
end;

function TRsrTmp.FieldExist (pFieldName:ShortString): boolean;
begin
  Result := oTmpTable.FindField(pFieldName)<>nil;
end;

function TRsrTmp.ReadResNum:longint;
begin
  Result := oTmpTable.FieldByName('ResNum').AsInteger;
end;

procedure TRsrTmp.WriteResNum(pValue:longint);
begin
  oTmpTable.FieldByName('ResNum').AsInteger := pValue;
end;

function TRsrTmp.ReadRoomType:Str1;
begin
  Result := oTmpTable.FieldByName('RoomType').AsString;
end;

procedure TRsrTmp.WriteRoomType(pValue:Str1);
begin
  oTmpTable.FieldByName('RoomType').AsString := pValue;
end;

function TRsrTmp.ReadBedCnt:longint;
begin
  Result := oTmpTable.FieldByName('BedCnt').AsInteger;
end;

procedure TRsrTmp.WriteBedCnt(pValue:longint);
begin
  oTmpTable.FieldByName('BedCnt').AsInteger := pValue;
end;

function TRsrTmp.ReadAdbCnt:longint;
begin
  Result := oTmpTable.FieldByName('AdbCnt').AsInteger;
end;

procedure TRsrTmp.WriteAdbCnt(pValue:longint);
begin
  oTmpTable.FieldByName('AdbCnt').AsInteger := pValue;
end;

function TRsrTmp.ReadFloor:longint;
begin
  Result := oTmpTable.FieldByName('Floor').AsInteger;
end;

procedure TRsrTmp.WriteFloor(pValue:longint);
begin
  oTmpTable.FieldByName('Floor').AsInteger := pValue;
end;

function TRsrTmp.ReadBlok:longint;
begin
  Result := oTmpTable.FieldByName('Blok').AsInteger;
end;

procedure TRsrTmp.WriteBlok(pValue:longint);
begin
  oTmpTable.FieldByName('Blok').AsInteger := pValue;
end;

function TRsrTmp.ReadDateI:TDatetime;
begin
  Result := oTmpTable.FieldByName('DateI').AsDateTime;
end;

procedure TRsrTmp.WriteDateI(pValue:TDatetime);
begin
  oTmpTable.FieldByName('DateI').AsDateTime := pValue;
end;

function TRsrTmp.ReadDateO:TDatetime;
begin
  Result := oTmpTable.FieldByName('DateO').AsDateTime;
end;

procedure TRsrTmp.WriteDateO(pValue:TDatetime);
begin
  oTmpTable.FieldByName('DateO').AsDateTime := pValue;
end;

function TRsrTmp.ReadItmCnt:longint;
begin
  Result := oTmpTable.FieldByName('ItmCnt').AsInteger;
end;

procedure TRsrTmp.WriteItmCnt(pValue:longint);
begin
  oTmpTable.FieldByName('ItmCnt').AsInteger := pValue;
end;

function TRsrTmp.ReadResCnt:longint;
begin
  Result := oTmpTable.FieldByName('ResCnt').AsInteger;
end;

procedure TRsrTmp.WriteResCnt(pValue:longint);
begin
  oTmpTable.FieldByName('ResCnt').AsInteger := pValue;
end;

function TRsrTmp.ReadAdultCnt:longint;
begin
  Result := oTmpTable.FieldByName('AdultCnt').AsInteger;
end;

procedure TRsrTmp.WriteAdultCnt(pValue:longint);
begin
  oTmpTable.FieldByName('AdultCnt').AsInteger := pValue;
end;

function TRsrTmp.ReadChildCnt:longint;
begin
  Result := oTmpTable.FieldByName('ChildCnt').AsInteger;
end;

procedure TRsrTmp.WriteChildCnt(pValue:longint);
begin
  oTmpTable.FieldByName('ChildCnt').AsInteger := pValue;
end;

function TRsrTmp.ReadBedPrice:double;
begin
  Result := oTmpTable.FieldByName('BedPrice').AsFloat;
end;

procedure TRsrTmp.WriteBedPrice(pValue:double);
begin
  oTmpTable.FieldByName('BedPrice').AsFloat := pValue;
end;

function TRsrTmp.ReadAdbPrice:double;
begin
  Result := oTmpTable.FieldByName('AdbPrice').AsFloat;
end;

procedure TRsrTmp.WriteAdbPrice(pValue:double);
begin
  oTmpTable.FieldByName('AdbPrice').AsFloat := pValue;
end;

function TRsrTmp.ReadRoomPrice:double;
begin
  Result := oTmpTable.FieldByName('RoomPrice').AsFloat;
end;

procedure TRsrTmp.WriteRoomPrice(pValue:double);
begin
  oTmpTable.FieldByName('RoomPrice').AsFloat := pValue;
end;

function TRsrTmp.ReadCrtUser:Str8;
begin
  Result := oTmpTable.FieldByName('CrtUser').AsString;
end;

procedure TRsrTmp.WriteCrtUser(pValue:Str8);
begin
  oTmpTable.FieldByName('CrtUser').AsString := pValue;
end;

function TRsrTmp.ReadCrtDate:TDatetime;
begin
  Result := oTmpTable.FieldByName('CrtDate').AsDateTime;
end;

procedure TRsrTmp.WriteCrtDate(pValue:TDatetime);
begin
  oTmpTable.FieldByName('CrtDate').AsDateTime := pValue;
end;

function TRsrTmp.ReadCrtTime:TDatetime;
begin
  Result := oTmpTable.FieldByName('CrtTime').AsDateTime;
end;

procedure TRsrTmp.WriteCrtTime(pValue:TDatetime);
begin
  oTmpTable.FieldByName('CrtTime').AsDateTime := pValue;
end;

function TRsrTmp.ReadModUser:Str8;
begin
  Result := oTmpTable.FieldByName('ModUser').AsString;
end;

procedure TRsrTmp.WriteModUser(pValue:Str8);
begin
  oTmpTable.FieldByName('ModUser').AsString := pValue;
end;

function TRsrTmp.ReadModDate:TDatetime;
begin
  Result := oTmpTable.FieldByName('ModDate').AsDateTime;
end;

procedure TRsrTmp.WriteModDate(pValue:TDatetime);
begin
  oTmpTable.FieldByName('ModDate').AsDateTime := pValue;
end;

function TRsrTmp.ReadModTime:TDatetime;
begin
  Result := oTmpTable.FieldByName('ModTime').AsDateTime;
end;

procedure TRsrTmp.WriteModTime(pValue:TDatetime);
begin
  oTmpTable.FieldByName('ModTime').AsDateTime := pValue;
end;

function TRsrTmp.ReadActPos:longint;
begin
  Result := oTmpTable.FieldByName('ActPos').AsInteger;
end;

procedure TRsrTmp.WriteActPos(pValue:longint);
begin
  oTmpTable.FieldByName('ActPos').AsInteger := pValue;
end;

// **************************************** PUBLIC ********************************************

function TRsrTmp.Eof: boolean;
begin
  Result := oTmpTable.Eof;
end;

function TRsrTmp.Active: boolean;
begin
  Result := oTmpTable.Active;
end;

function TRsrTmp.LocateRnRtBcAcFlBl (pResNum:longint;pRoomType:Str1;pBedCnt:longint;pAdbCnt:longint;pFloor:longint;pBlok:longint):boolean;
begin
  SetIndex (ixRnRtBcAcFlBl);
  Result := oTmpTable.FindKey([pResNum,pRoomType,pBedCnt,pAdbCnt,pFloor,pBlok]);
end;

function TRsrTmp.LocateRtBcAcFlBl (pRoomType:Str1;pBedCnt:longint;pAdbCnt:longint;pFloor:longint;pBlok:longint):boolean;
begin
  SetIndex (ixRtBcAcFlBl);
  Result := oTmpTable.FindKey([pRoomType,pBedCnt,pAdbCnt,pFloor,pBlok]);
end;

procedure TRsrTmp.SetIndex (pIndexName:ShortString);
begin
  If oTmpTable.IndexName<>pIndexName then oTmpTable.IndexName := pIndexName;
end;

procedure TRsrTmp.Open;
begin
  oTmpTable.Open;
end;

procedure TRsrTmp.Close;
begin
  If oTmpTable.Active then oTmpTable.Close;
end;

procedure TRsrTmp.Prior;
begin
  oTmpTable.Prior;
end;

procedure TRsrTmp.Next;
begin
  oTmpTable.Next;
end;

procedure TRsrTmp.First;
begin
  oTmpTable.First;
end;

procedure TRsrTmp.Last;
begin
  oTmpTable.Last;
end;

procedure TRsrTmp.Insert;
begin
  oTmpTable.Insert;
end;

procedure TRsrTmp.Edit;
begin
  oTmpTable.Edit;
end;

procedure TRsrTmp.Post;
var mEdit:boolean;
begin
  oTmpTable.Post;
end;

procedure TRsrTmp.Delete;
begin
  oTmpTable.Delete;
end;

procedure TRsrTmp.SwapIndex;
begin
  oTmpTable.SwapIndex;
end;

procedure TRsrTmp.RestoreIndex;
begin
  oTmpTable.RestoreIndex;
end;

procedure TRsrTmp.SwapStatus;
begin
  oTmpTable.SwapStatus;
end;

procedure TRsrTmp.RestoreStatus;
begin
  oTmpTable.RestoreStatus;
end;

procedure TRsrTmp.EnableControls;
begin
  oTmpTable.EnableControls;
end;

procedure TRsrTmp.DisableControls;
begin
  oTmpTable.DisableControls;
end;

end.
