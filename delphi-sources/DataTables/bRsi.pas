unit bRSI;

interface

uses
  IcTypes, IcConv, NexPath, NexGlob,
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls,
  Dialogs, DB, NexBtrTable, DBTables, NexPxTable;

const
  ixResNum = 'ResNum';
  ixReRo = 'ReRo';

type
  TRsiBtr = class (TComponent)
    constructor Create; overload;
    destructor  Destroy; override;
  private
    oBtrTable: TNexBtrTable;
    function ReadCount:integer;
    function FieldExist (pFieldName:ShortString): boolean;
    // Pristup k databazovym poliam
    function  ReadResNum:longint;        procedure WriteResNum (pValue:longint);
    function  ReadRoomNum:longint;       procedure WriteRoomNum (pValue:longint);
    function  ReadDateI:TDatetime;       procedure WriteDateI (pValue:TDatetime);
    function  ReadDateO:TDatetime;       procedure WriteDateO (pValue:TDatetime);
    function  ReadBedCnt:longint;        procedure WriteBedCnt (pValue:longint);
    function  ReadAdbCnt:longint;        procedure WriteAdbCnt (pValue:longint);
    function  ReadBedPrice:double;       procedure WriteBedPrice (pValue:double);
    function  ReadAdbPrice:double;       procedure WriteAdbPrice (pValue:double);
    function  ReadRoomPrice:double;      procedure WriteRoomPrice (pValue:double);
    function  ReadAdultCnt:longint;      procedure WriteAdultCnt (pValue:longint);
    function  ReadChildCnt:longint;      procedure WriteChildCnt (pValue:longint);
    function  ReadCrtUser:Str8;          procedure WriteCrtUser (pValue:Str8);
    function  ReadCrtDate:TDatetime;     procedure WriteCrtDate (pValue:TDatetime);
    function  ReadCrtTime:TDatetime;     procedure WriteCrtTime (pValue:TDatetime);
    function  ReadModUser:Str8;          procedure WriteModUser (pValue:Str8);
    function  ReadModDate:TDatetime;     procedure WriteModDate (pValue:TDatetime);
    function  ReadModTime:TDatetime;     procedure WriteModTime (pValue:TDatetime);
    function  ReadRoomPriceF:double;     procedure WriteRoomPriceF (pValue:double);
    function  ReadDevice1:Str1;          procedure WriteDevice1 (pValue:Str1);
    function  ReadDevice2:Str1;          procedure WriteDevice2 (pValue:Str1);
    function  ReadDevice3:Str1;          procedure WriteDevice3 (pValue:Str1);
    function  ReadDevice4:Str1;          procedure WriteDevice4 (pValue:Str1);
    function  ReadDevice5:Str1;          procedure WriteDevice5 (pValue:Str1);
    function  ReadDevice6:Str1;          procedure WriteDevice6 (pValue:Str1);
    function  ReadDevice7:Str1;          procedure WriteDevice7 (pValue:Str1);
    function  ReadDevice8:Str1;          procedure WriteDevice8 (pValue:Str1);
    function  ReadDevice9:Str1;          procedure WriteDevice9 (pValue:Str1);
    function  ReadDevice10:Str1;         procedure WriteDevice10 (pValue:Str1);
    function  ReadRoomCode:Str15;        procedure WriteRoomCode (pValue:Str15);
    function  ReadExtension:Str5;        procedure WriteExtension (pValue:Str5);
    function  ReadRoomDscPrc:double;     procedure WriteRoomDscPrc (pValue:double);
    function  ReadActPos:longint;        procedure WriteActPos (pValue:longint);
    function  ReadIncTime:TDatetime;     procedure WriteIncTime (pValue:TDatetime);
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
    function LocateReRo (pResNum:longint;pRoomNum:longint):boolean;
    function NearestResNum (pResNum:longint):boolean;
    function NearestReRo (pResNum:longint;pRoomNum:longint):boolean;

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
    property RoomNum:longint read ReadRoomNum write WriteRoomNum;
    property DateI:TDatetime read ReadDateI write WriteDateI;
    property DateO:TDatetime read ReadDateO write WriteDateO;
    property BedCnt:longint read ReadBedCnt write WriteBedCnt;
    property AdbCnt:longint read ReadAdbCnt write WriteAdbCnt;
    property BedPrice:double read ReadBedPrice write WriteBedPrice;
    property AdbPrice:double read ReadAdbPrice write WriteAdbPrice;
    property RoomPrice:double read ReadRoomPrice write WriteRoomPrice;
    property AdultCnt:longint read ReadAdultCnt write WriteAdultCnt;
    property ChildCnt:longint read ReadChildCnt write WriteChildCnt;
    property CrtUser:Str8 read ReadCrtUser write WriteCrtUser;
    property CrtDate:TDatetime read ReadCrtDate write WriteCrtDate;
    property CrtTime:TDatetime read ReadCrtTime write WriteCrtTime;
    property ModUser:Str8 read ReadModUser write WriteModUser;
    property ModDate:TDatetime read ReadModDate write WriteModDate;
    property ModTime:TDatetime read ReadModTime write WriteModTime;
    property RoomPriceF:double read ReadRoomPriceF write WriteRoomPriceF;
    property Device1:Str1 read ReadDevice1 write WriteDevice1;
    property Device2:Str1 read ReadDevice2 write WriteDevice2;
    property Device3:Str1 read ReadDevice3 write WriteDevice3;
    property Device4:Str1 read ReadDevice4 write WriteDevice4;
    property Device5:Str1 read ReadDevice5 write WriteDevice5;
    property Device6:Str1 read ReadDevice6 write WriteDevice6;
    property Device7:Str1 read ReadDevice7 write WriteDevice7;
    property Device8:Str1 read ReadDevice8 write WriteDevice8;
    property Device9:Str1 read ReadDevice9 write WriteDevice9;
    property Device10:Str1 read ReadDevice10 write WriteDevice10;
    property RoomCode:Str15 read ReadRoomCode write WriteRoomCode;
    property Extension:Str5 read ReadExtension write WriteExtension;
    property RoomDscPrc:double read ReadRoomDscPrc write WriteRoomDscPrc;
    property ActPosM:longint read ReadActPos write WriteActPos;
    property IncTime:TDatetime read ReadIncTime write WriteIncTime;
  end;

implementation

constructor TRsiBtr.Create;
begin
  oBtrTable := BtrInit ('RSI',gPath.HtlPath,Self);
end;

constructor TRsiBtr.Create(pPath:ShortString);
begin
  oBtrTable := BtrInit ('RSI',pPath,Self);
end;

destructor TRsiBtr.Destroy;
begin
  oBtrTable.Close;  FreeAndNil (oBtrTable);
end;

// *************************************** PRIVATE ********************************************

function TRsiBtr.ReadCount:integer;
begin
  Result := oBtrTable.RecordCount;
end;

function TRsiBtr.FieldExist (pFieldName:ShortString): boolean;
begin
  Result := oBtrTable.FindField(pFieldName)<>nil;
end;

function TRsiBtr.ReadResNum:longint;
begin
  Result := oBtrTable.FieldByName('ResNum').AsInteger;
end;

procedure TRsiBtr.WriteResNum(pValue:longint);
begin
  oBtrTable.FieldByName('ResNum').AsInteger := pValue;
end;

function TRsiBtr.ReadRoomNum:longint;
begin
  Result := oBtrTable.FieldByName('RoomNum').AsInteger;
end;

procedure TRsiBtr.WriteRoomNum(pValue:longint);
begin
  oBtrTable.FieldByName('RoomNum').AsInteger := pValue;
end;

function TRsiBtr.ReadDateI:TDatetime;
begin
  Result := oBtrTable.FieldByName('DateI').AsDateTime;
end;

procedure TRsiBtr.WriteDateI(pValue:TDatetime);
begin
  oBtrTable.FieldByName('DateI').AsDateTime := pValue;
end;

function TRsiBtr.ReadDateO:TDatetime;
begin
  Result := oBtrTable.FieldByName('DateO').AsDateTime;
end;

procedure TRsiBtr.WriteDateO(pValue:TDatetime);
begin
  oBtrTable.FieldByName('DateO').AsDateTime := pValue;
end;

function TRsiBtr.ReadBedCnt:longint;
begin
  Result := oBtrTable.FieldByName('BedCnt').AsInteger;
end;

procedure TRsiBtr.WriteBedCnt(pValue:longint);
begin
  oBtrTable.FieldByName('BedCnt').AsInteger := pValue;
end;

function TRsiBtr.ReadAdbCnt:longint;
begin
  Result := oBtrTable.FieldByName('AdbCnt').AsInteger;
end;

procedure TRsiBtr.WriteAdbCnt(pValue:longint);
begin
  oBtrTable.FieldByName('AdbCnt').AsInteger := pValue;
end;

function TRsiBtr.ReadBedPrice:double;
begin
  Result := oBtrTable.FieldByName('BedPrice').AsFloat;
end;

procedure TRsiBtr.WriteBedPrice(pValue:double);
begin
  oBtrTable.FieldByName('BedPrice').AsFloat := pValue;
end;

function TRsiBtr.ReadAdbPrice:double;
begin
  Result := oBtrTable.FieldByName('AdbPrice').AsFloat;
end;

procedure TRsiBtr.WriteAdbPrice(pValue:double);
begin
  oBtrTable.FieldByName('AdbPrice').AsFloat := pValue;
end;

function TRsiBtr.ReadRoomPrice:double;
begin
  Result := oBtrTable.FieldByName('RoomPrice').AsFloat;
end;

procedure TRsiBtr.WriteRoomPrice(pValue:double);
begin
  oBtrTable.FieldByName('RoomPrice').AsFloat := pValue;
end;

function TRsiBtr.ReadAdultCnt:longint;
begin
  Result := oBtrTable.FieldByName('AdultCnt').AsInteger;
end;

procedure TRsiBtr.WriteAdultCnt(pValue:longint);
begin
  oBtrTable.FieldByName('AdultCnt').AsInteger := pValue;
end;

function TRsiBtr.ReadChildCnt:longint;
begin
  Result := oBtrTable.FieldByName('ChildCnt').AsInteger;
end;

procedure TRsiBtr.WriteChildCnt(pValue:longint);
begin
  oBtrTable.FieldByName('ChildCnt').AsInteger := pValue;
end;

function TRsiBtr.ReadCrtUser:Str8;
begin
  Result := oBtrTable.FieldByName('CrtUser').AsString;
end;

procedure TRsiBtr.WriteCrtUser(pValue:Str8);
begin
  oBtrTable.FieldByName('CrtUser').AsString := pValue;
end;

function TRsiBtr.ReadCrtDate:TDatetime;
begin
  Result := oBtrTable.FieldByName('CrtDate').AsDateTime;
end;

procedure TRsiBtr.WriteCrtDate(pValue:TDatetime);
begin
  oBtrTable.FieldByName('CrtDate').AsDateTime := pValue;
end;

function TRsiBtr.ReadCrtTime:TDatetime;
begin
  Result := oBtrTable.FieldByName('CrtTime').AsDateTime;
end;

procedure TRsiBtr.WriteCrtTime(pValue:TDatetime);
begin
  oBtrTable.FieldByName('CrtTime').AsDateTime := pValue;
end;

function TRsiBtr.ReadModUser:Str8;
begin
  Result := oBtrTable.FieldByName('ModUser').AsString;
end;

procedure TRsiBtr.WriteModUser(pValue:Str8);
begin
  oBtrTable.FieldByName('ModUser').AsString := pValue;
end;

function TRsiBtr.ReadModDate:TDatetime;
begin
  Result := oBtrTable.FieldByName('ModDate').AsDateTime;
end;

procedure TRsiBtr.WriteModDate(pValue:TDatetime);
begin
  oBtrTable.FieldByName('ModDate').AsDateTime := pValue;
end;

function TRsiBtr.ReadModTime:TDatetime;
begin
  Result := oBtrTable.FieldByName('ModTime').AsDateTime;
end;

procedure TRsiBtr.WriteModTime(pValue:TDatetime);
begin
  oBtrTable.FieldByName('ModTime').AsDateTime := pValue;
end;

function TRsiBtr.ReadRoomPriceF:double;
begin
  Result := oBtrTable.FieldByName('RoomPriceF').AsFloat;
end;

procedure TRsiBtr.WriteRoomPriceF(pValue:double);
begin
  oBtrTable.FieldByName('RoomPriceF').AsFloat := pValue;
end;

function TRsiBtr.ReadDevice1:Str1;
begin
  Result := oBtrTable.FieldByName('Device1').AsString;
end;

procedure TRsiBtr.WriteDevice1(pValue:Str1);
begin
  oBtrTable.FieldByName('Device1').AsString := pValue;
end;

function TRsiBtr.ReadDevice2:Str1;
begin
  Result := oBtrTable.FieldByName('Device2').AsString;
end;

procedure TRsiBtr.WriteDevice2(pValue:Str1);
begin
  oBtrTable.FieldByName('Device2').AsString := pValue;
end;

function TRsiBtr.ReadDevice3:Str1;
begin
  Result := oBtrTable.FieldByName('Device3').AsString;
end;

procedure TRsiBtr.WriteDevice3(pValue:Str1);
begin
  oBtrTable.FieldByName('Device3').AsString := pValue;
end;

function TRsiBtr.ReadDevice4:Str1;
begin
  Result := oBtrTable.FieldByName('Device4').AsString;
end;

procedure TRsiBtr.WriteDevice4(pValue:Str1);
begin
  oBtrTable.FieldByName('Device4').AsString := pValue;
end;

function TRsiBtr.ReadDevice5:Str1;
begin
  Result := oBtrTable.FieldByName('Device5').AsString;
end;

procedure TRsiBtr.WriteDevice5(pValue:Str1);
begin
  oBtrTable.FieldByName('Device5').AsString := pValue;
end;

function TRsiBtr.ReadDevice6:Str1;
begin
  Result := oBtrTable.FieldByName('Device6').AsString;
end;

procedure TRsiBtr.WriteDevice6(pValue:Str1);
begin
  oBtrTable.FieldByName('Device6').AsString := pValue;
end;

function TRsiBtr.ReadDevice7:Str1;
begin
  Result := oBtrTable.FieldByName('Device7').AsString;
end;

procedure TRsiBtr.WriteDevice7(pValue:Str1);
begin
  oBtrTable.FieldByName('Device7').AsString := pValue;
end;

function TRsiBtr.ReadDevice8:Str1;
begin
  Result := oBtrTable.FieldByName('Device8').AsString;
end;

procedure TRsiBtr.WriteDevice8(pValue:Str1);
begin
  oBtrTable.FieldByName('Device8').AsString := pValue;
end;

function TRsiBtr.ReadDevice9:Str1;
begin
  Result := oBtrTable.FieldByName('Device9').AsString;
end;

procedure TRsiBtr.WriteDevice9(pValue:Str1);
begin
  oBtrTable.FieldByName('Device9').AsString := pValue;
end;

function TRsiBtr.ReadDevice10:Str1;
begin
  Result := oBtrTable.FieldByName('Device10').AsString;
end;

procedure TRsiBtr.WriteDevice10(pValue:Str1);
begin
  oBtrTable.FieldByName('Device10').AsString := pValue;
end;

function TRsiBtr.ReadRoomCode:Str15;
begin
  Result := oBtrTable.FieldByName('RoomCode').AsString;
end;

procedure TRsiBtr.WriteRoomCode(pValue:Str15);
begin
  oBtrTable.FieldByName('RoomCode').AsString := pValue;
end;

function TRsiBtr.ReadExtension:Str5;
begin
  Result := oBtrTable.FieldByName('Extension').AsString;
end;

procedure TRsiBtr.WriteExtension(pValue:Str5);
begin
  oBtrTable.FieldByName('Extension').AsString := pValue;
end;

function TRsiBtr.ReadRoomDscPrc:double;
begin
  Result := oBtrTable.FieldByName('RoomDscPrc').AsFloat;
end;

procedure TRsiBtr.WriteRoomDscPrc(pValue:double);
begin
  oBtrTable.FieldByName('RoomDscPrc').AsFloat := pValue;
end;

function TRsiBtr.ReadActPos:longint;
begin
  Result := oBtrTable.FieldByName('ActPos').AsInteger;
end;

procedure TRsiBtr.WriteActPos(pValue:longint);
begin
  oBtrTable.FieldByName('ActPos').AsInteger := pValue;
end;

function TRsiBtr.ReadIncTime:TDatetime;
begin
  Result := oBtrTable.FieldByName('IncTime').AsDateTime;
end;

procedure TRsiBtr.WriteIncTime(pValue:TDatetime);
begin
  oBtrTable.FieldByName('IncTime').AsDateTime := pValue;
end;

// **************************************** PUBLIC ********************************************

function TRsiBtr.Eof: boolean;
begin
  Result := oBtrTable.Eof;
end;

function TRsiBtr.IsFirstRec: boolean;
begin
  Result := oBtrTable.Bof;
end;

function TRsiBtr.IsLastRec: boolean;
begin
  Result := oBtrTable.Eof;
end;

function TRsiBtr.Active: boolean;
begin
  Result := oBtrTable.Active;
end;

function TRsiBtr.ActPos: longint;
begin
  Result := oBtrTable.ActPos;
end;

function TRsiBtr.GotoPos (pActPos:longint): boolean;
begin
  Result := oBtrTable.GotoPos(pActPos);
end;

function TRsiBtr.LocateResNum (pResNum:longint):boolean;
begin
  SetIndex (ixResNum);
  Result := oBtrTable.FindKey([pResNum]);
end;

function TRsiBtr.LocateReRo (pResNum:longint;pRoomNum:longint):boolean;
begin
  SetIndex (ixReRo);
  Result := oBtrTable.FindKey([pResNum,pRoomNum]);
end;

function TRsiBtr.NearestResNum (pResNum:longint):boolean;
begin
  SetIndex (ixResNum);
  Result := oBtrTable.FindNearest([pResNum]);
end;

function TRsiBtr.NearestReRo (pResNum:longint;pRoomNum:longint):boolean;
begin
  SetIndex (ixReRo);
  Result := oBtrTable.FindNearest([pResNum,pRoomNum]);
end;

procedure TRsiBtr.SetIndex (pIndexName:ShortString);
begin
  If oBtrTable.IndexName<>pIndexName then oBtrTable.IndexName := pIndexName;
end;

procedure TRsiBtr.Open;
begin
  oBtrTable.Open;
end;

procedure TRsiBtr.Close;
begin
  If oBtrTable.Active then oBtrTable.Close;
end;

procedure TRsiBtr.Prior;
begin
  oBtrTable.Prior;
end;

procedure TRsiBtr.Next;
begin
  oBtrTable.Next;
end;

procedure TRsiBtr.First;
begin
  oBtrTable.First;
end;

procedure TRsiBtr.Last;
begin
  oBtrTable.Last;
end;

procedure TRsiBtr.Insert;
begin
  oBtrTable.Insert;
end;

procedure TRsiBtr.Edit;
begin
  oBtrTable.Edit;
end;

procedure TRsiBtr.Post;
begin
  oBtrTable.Post;
end;

procedure TRsiBtr.Delete;
begin
  oBtrTable.Delete;
end;

procedure TRsiBtr.SwapIndex;
begin
  oBtrTable.SwapIndex;
end;

procedure TRsiBtr.RestoreIndex;
begin
  oBtrTable.RestoreIndex;
end;

procedure TRsiBtr.SwapStatus;
begin
  oBtrTable.SwapStatus;
end;

procedure TRsiBtr.RestoreStatus;
begin
  oBtrTable.RestoreStatus;
end;

procedure TRsiBtr.EnableControls;
begin
  oBtrTable.EnableControls;
end;

procedure TRsiBtr.DisableControls;
begin
  oBtrTable.DisableControls;
end;

end.
