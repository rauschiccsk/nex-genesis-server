unit tRSI;

interface

uses
  IcTypes, IcConv, NexPath, NexGlob, DocHand, 
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls,
  Dialogs, DB, NexBtrTable, DBTables, NexPxTable;

const
  ixReRo = '';
  ixResNum = 'ResNum';

type
  TRsiTmp = class (TComponent)
    constructor Create;
    destructor  Destroy; override;
  private
    oTmpTable: TNexPxTable;
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
    function  ReadIncTime:TDatetime;     procedure WriteIncTime (pValue:TDatetime);
    function  ReadActPos:longint;        procedure WriteActPos (pValue:longint);
  public
    // Elementarne databazove operacie
    function Eof: boolean;
    function Active: boolean;
    function LocateReRo (pResNum:longint;pRoomNum:longint):boolean;
    function LocateResNum (pResNum:longint):boolean;

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
    property IncTime:TDatetime read ReadIncTime write WriteIncTime;
    property ActPos:longint read ReadActPos write WriteActPos;
  end;

implementation

constructor TRsiTmp.Create;
begin
  oTmpTable := TmpInit ('RSI',Self);
end;

destructor TRsiTmp.Destroy;
begin
  If oTmpTable.Active then oTmpTable.Close;
  FreeAndNil (oTmpTable);
end;

// *************************************** PRIVATE ********************************************

function TRsiTmp.ReadCount:integer;
begin
  Result := oTmpTable.RecordCount;
end;

function TRsiTmp.FieldExist (pFieldName:ShortString): boolean;
begin
  Result := oTmpTable.FindField(pFieldName)<>nil;
end;

function TRsiTmp.ReadResNum:longint;
begin
  Result := oTmpTable.FieldByName('ResNum').AsInteger;
end;

procedure TRsiTmp.WriteResNum(pValue:longint);
begin
  oTmpTable.FieldByName('ResNum').AsInteger := pValue;
end;

function TRsiTmp.ReadRoomNum:longint;
begin
  Result := oTmpTable.FieldByName('RoomNum').AsInteger;
end;

procedure TRsiTmp.WriteRoomNum(pValue:longint);
begin
  oTmpTable.FieldByName('RoomNum').AsInteger := pValue;
end;

function TRsiTmp.ReadDateI:TDatetime;
begin
  Result := oTmpTable.FieldByName('DateI').AsDateTime;
end;

procedure TRsiTmp.WriteDateI(pValue:TDatetime);
begin
  oTmpTable.FieldByName('DateI').AsDateTime := pValue;
end;

function TRsiTmp.ReadDateO:TDatetime;
begin
  Result := oTmpTable.FieldByName('DateO').AsDateTime;
end;

procedure TRsiTmp.WriteDateO(pValue:TDatetime);
begin
  oTmpTable.FieldByName('DateO').AsDateTime := pValue;
end;

function TRsiTmp.ReadBedCnt:longint;
begin
  Result := oTmpTable.FieldByName('BedCnt').AsInteger;
end;

procedure TRsiTmp.WriteBedCnt(pValue:longint);
begin
  oTmpTable.FieldByName('BedCnt').AsInteger := pValue;
end;

function TRsiTmp.ReadAdbCnt:longint;
begin
  Result := oTmpTable.FieldByName('AdbCnt').AsInteger;
end;

procedure TRsiTmp.WriteAdbCnt(pValue:longint);
begin
  oTmpTable.FieldByName('AdbCnt').AsInteger := pValue;
end;

function TRsiTmp.ReadBedPrice:double;
begin
  Result := oTmpTable.FieldByName('BedPrice').AsFloat;
end;

procedure TRsiTmp.WriteBedPrice(pValue:double);
begin
  oTmpTable.FieldByName('BedPrice').AsFloat := pValue;
end;

function TRsiTmp.ReadAdbPrice:double;
begin
  Result := oTmpTable.FieldByName('AdbPrice').AsFloat;
end;

procedure TRsiTmp.WriteAdbPrice(pValue:double);
begin
  oTmpTable.FieldByName('AdbPrice').AsFloat := pValue;
end;

function TRsiTmp.ReadRoomPrice:double;
begin
  Result := oTmpTable.FieldByName('RoomPrice').AsFloat;
end;

procedure TRsiTmp.WriteRoomPrice(pValue:double);
begin
  oTmpTable.FieldByName('RoomPrice').AsFloat := pValue;
end;

function TRsiTmp.ReadAdultCnt:longint;
begin
  Result := oTmpTable.FieldByName('AdultCnt').AsInteger;
end;

procedure TRsiTmp.WriteAdultCnt(pValue:longint);
begin
  oTmpTable.FieldByName('AdultCnt').AsInteger := pValue;
end;

function TRsiTmp.ReadChildCnt:longint;
begin
  Result := oTmpTable.FieldByName('ChildCnt').AsInteger;
end;

procedure TRsiTmp.WriteChildCnt(pValue:longint);
begin
  oTmpTable.FieldByName('ChildCnt').AsInteger := pValue;
end;

function TRsiTmp.ReadCrtUser:Str8;
begin
  Result := oTmpTable.FieldByName('CrtUser').AsString;
end;

procedure TRsiTmp.WriteCrtUser(pValue:Str8);
begin
  oTmpTable.FieldByName('CrtUser').AsString := pValue;
end;

function TRsiTmp.ReadCrtDate:TDatetime;
begin
  Result := oTmpTable.FieldByName('CrtDate').AsDateTime;
end;

procedure TRsiTmp.WriteCrtDate(pValue:TDatetime);
begin
  oTmpTable.FieldByName('CrtDate').AsDateTime := pValue;
end;

function TRsiTmp.ReadCrtTime:TDatetime;
begin
  Result := oTmpTable.FieldByName('CrtTime').AsDateTime;
end;

procedure TRsiTmp.WriteCrtTime(pValue:TDatetime);
begin
  oTmpTable.FieldByName('CrtTime').AsDateTime := pValue;
end;

function TRsiTmp.ReadModUser:Str8;
begin
  Result := oTmpTable.FieldByName('ModUser').AsString;
end;

procedure TRsiTmp.WriteModUser(pValue:Str8);
begin
  oTmpTable.FieldByName('ModUser').AsString := pValue;
end;

function TRsiTmp.ReadModDate:TDatetime;
begin
  Result := oTmpTable.FieldByName('ModDate').AsDateTime;
end;

procedure TRsiTmp.WriteModDate(pValue:TDatetime);
begin
  oTmpTable.FieldByName('ModDate').AsDateTime := pValue;
end;

function TRsiTmp.ReadModTime:TDatetime;
begin
  Result := oTmpTable.FieldByName('ModTime').AsDateTime;
end;

procedure TRsiTmp.WriteModTime(pValue:TDatetime);
begin
  oTmpTable.FieldByName('ModTime').AsDateTime := pValue;
end;

function TRsiTmp.ReadRoomPriceF:double;
begin
  Result := oTmpTable.FieldByName('RoomPriceF').AsFloat;
end;

procedure TRsiTmp.WriteRoomPriceF(pValue:double);
begin
  oTmpTable.FieldByName('RoomPriceF').AsFloat := pValue;
end;

function TRsiTmp.ReadDevice1:Str1;
begin
  Result := oTmpTable.FieldByName('Device1').AsString;
end;

procedure TRsiTmp.WriteDevice1(pValue:Str1);
begin
  oTmpTable.FieldByName('Device1').AsString := pValue;
end;

function TRsiTmp.ReadDevice2:Str1;
begin
  Result := oTmpTable.FieldByName('Device2').AsString;
end;

procedure TRsiTmp.WriteDevice2(pValue:Str1);
begin
  oTmpTable.FieldByName('Device2').AsString := pValue;
end;

function TRsiTmp.ReadDevice3:Str1;
begin
  Result := oTmpTable.FieldByName('Device3').AsString;
end;

procedure TRsiTmp.WriteDevice3(pValue:Str1);
begin
  oTmpTable.FieldByName('Device3').AsString := pValue;
end;

function TRsiTmp.ReadDevice4:Str1;
begin
  Result := oTmpTable.FieldByName('Device4').AsString;
end;

procedure TRsiTmp.WriteDevice4(pValue:Str1);
begin
  oTmpTable.FieldByName('Device4').AsString := pValue;
end;

function TRsiTmp.ReadDevice5:Str1;
begin
  Result := oTmpTable.FieldByName('Device5').AsString;
end;

procedure TRsiTmp.WriteDevice5(pValue:Str1);
begin
  oTmpTable.FieldByName('Device5').AsString := pValue;
end;

function TRsiTmp.ReadDevice6:Str1;
begin
  Result := oTmpTable.FieldByName('Device6').AsString;
end;

procedure TRsiTmp.WriteDevice6(pValue:Str1);
begin
  oTmpTable.FieldByName('Device6').AsString := pValue;
end;

function TRsiTmp.ReadDevice7:Str1;
begin
  Result := oTmpTable.FieldByName('Device7').AsString;
end;

procedure TRsiTmp.WriteDevice7(pValue:Str1);
begin
  oTmpTable.FieldByName('Device7').AsString := pValue;
end;

function TRsiTmp.ReadDevice8:Str1;
begin
  Result := oTmpTable.FieldByName('Device8').AsString;
end;

procedure TRsiTmp.WriteDevice8(pValue:Str1);
begin
  oTmpTable.FieldByName('Device8').AsString := pValue;
end;

function TRsiTmp.ReadDevice9:Str1;
begin
  Result := oTmpTable.FieldByName('Device9').AsString;
end;

procedure TRsiTmp.WriteDevice9(pValue:Str1);
begin
  oTmpTable.FieldByName('Device9').AsString := pValue;
end;

function TRsiTmp.ReadDevice10:Str1;
begin
  Result := oTmpTable.FieldByName('Device10').AsString;
end;

procedure TRsiTmp.WriteDevice10(pValue:Str1);
begin
  oTmpTable.FieldByName('Device10').AsString := pValue;
end;

function TRsiTmp.ReadRoomCode:Str15;
begin
  Result := oTmpTable.FieldByName('RoomCode').AsString;
end;

procedure TRsiTmp.WriteRoomCode(pValue:Str15);
begin
  oTmpTable.FieldByName('RoomCode').AsString := pValue;
end;

function TRsiTmp.ReadExtension:Str5;
begin
  Result := oTmpTable.FieldByName('Extension').AsString;
end;

procedure TRsiTmp.WriteExtension(pValue:Str5);
begin
  oTmpTable.FieldByName('Extension').AsString := pValue;
end;

function TRsiTmp.ReadRoomDscPrc:double;
begin
  Result := oTmpTable.FieldByName('RoomDscPrc').AsFloat;
end;

procedure TRsiTmp.WriteRoomDscPrc(pValue:double);
begin
  oTmpTable.FieldByName('RoomDscPrc').AsFloat := pValue;
end;

function TRsiTmp.ReadIncTime:TDatetime;
begin
  Result := oTmpTable.FieldByName('IncTime').AsDateTime;
end;

procedure TRsiTmp.WriteIncTime(pValue:TDatetime);
begin
  oTmpTable.FieldByName('IncTime').AsDateTime := pValue;
end;

function TRsiTmp.ReadActPos:longint;
begin
  Result := oTmpTable.FieldByName('ActPos').AsInteger;
end;

procedure TRsiTmp.WriteActPos(pValue:longint);
begin
  oTmpTable.FieldByName('ActPos').AsInteger := pValue;
end;

// **************************************** PUBLIC ********************************************

function TRsiTmp.Eof: boolean;
begin
  Result := oTmpTable.Eof;
end;

function TRsiTmp.Active: boolean;
begin
  Result := oTmpTable.Active;
end;

function TRsiTmp.LocateReRo (pResNum:longint;pRoomNum:longint):boolean;
begin
  SetIndex (ixReRo);
  Result := oTmpTable.FindKey([pResNum,pRoomNum]);
end;

function TRsiTmp.LocateResNum (pResNum:longint):boolean;
begin
  SetIndex (ixResNum);
  Result := oTmpTable.FindKey([pResNum]);
end;

procedure TRsiTmp.SetIndex (pIndexName:ShortString);
begin
  If oTmpTable.IndexName<>pIndexName then oTmpTable.IndexName := pIndexName;
end;

procedure TRsiTmp.Open;
begin
  oTmpTable.Open;
end;

procedure TRsiTmp.Close;
begin
  If oTmpTable.Active then oTmpTable.Close;
end;

procedure TRsiTmp.Prior;
begin
  oTmpTable.Prior;
end;

procedure TRsiTmp.Next;
begin
  oTmpTable.Next;
end;

procedure TRsiTmp.First;
begin
  oTmpTable.First;
end;

procedure TRsiTmp.Last;
begin
  oTmpTable.Last;
end;

procedure TRsiTmp.Insert;
begin
  oTmpTable.Insert;
end;

procedure TRsiTmp.Edit;
begin
  oTmpTable.Edit;
end;

procedure TRsiTmp.Post;
var mEdit:boolean;
begin
  oTmpTable.Post;
end;

procedure TRsiTmp.Delete;
begin
  oTmpTable.Delete;
end;

procedure TRsiTmp.SwapIndex;
begin
  oTmpTable.SwapIndex;
end;

procedure TRsiTmp.RestoreIndex;
begin
  oTmpTable.RestoreIndex;
end;

procedure TRsiTmp.SwapStatus;
begin
  oTmpTable.SwapStatus;
end;

procedure TRsiTmp.RestoreStatus;
begin
  oTmpTable.RestoreStatus;
end;

procedure TRsiTmp.EnableControls;
begin
  oTmpTable.EnableControls;
end;

procedure TRsiTmp.DisableControls;
begin
  oTmpTable.DisableControls;
end;

end.
