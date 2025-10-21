unit bTNI;

interface

uses
  IcTypes, IcConv, NexPath, NexGlob,
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls,
  Dialogs, DB, NexBtrTable, DBTables, NexPxTable;

const
  ixTentNum = 'TentNum';
  ixTnRn = 'TnRn';
  ixRoomNum = 'RoomNum';
  ixStatus = 'Status';

type
  TTniBtr = class (TComponent)
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
    function  ReadBedCnt:longint;        procedure WriteBedCnt (pValue:longint);
    function  ReadAdbCnt:longint;        procedure WriteAdbCnt (pValue:longint);
    function  ReadBedPrice:double;       procedure WriteBedPrice (pValue:double);
    function  ReadAdbPrice:double;       procedure WriteAdbPrice (pValue:double);
    function  ReadRoomPrice:double;      procedure WriteRoomPrice (pValue:double);
    function  ReadAdultCnt:longint;      procedure WriteAdultCnt (pValue:longint);
    function  ReadChildCnt:longint;      procedure WriteChildCnt (pValue:longint);
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
    function  ReadTimeI:TDatetime;       procedure WriteTimeI (pValue:TDatetime);
    function  ReadTimeO:TDatetime;       procedure WriteTimeO (pValue:TDatetime);
    function  ReadRoomDscPrc:double;     procedure WriteRoomDscPrc (pValue:double);
    function  ReadIcdNum:Str12;          procedure WriteIcdNum (pValue:Str12);
    function  ReadEmptStat:Str1;         procedure WriteEmptStat (pValue:Str1);
    function  ReadEmptDate:TDatetime;    procedure WriteEmptDate (pValue:TDatetime);
    function  ReadEmptTime:TDatetime;    procedure WriteEmptTime (pValue:TDatetime);
    function  ReadActPos:longint;        procedure WriteActPos (pValue:longint);
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
    function LocateRoomNum (pRoomNum:longint):boolean;
    function LocateStatus (pStatus:Str1):boolean;
    function NearestTentNum (pTentNum:longint):boolean;
    function NearestTnRn (pTentNum:longint;pRoomNum:longint):boolean;
    function NearestRoomNum (pRoomNum:longint):boolean;
    function NearestStatus (pStatus:Str1):boolean;

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
    property BedCnt:longint read ReadBedCnt write WriteBedCnt;
    property AdbCnt:longint read ReadAdbCnt write WriteAdbCnt;
    property BedPrice:double read ReadBedPrice write WriteBedPrice;
    property AdbPrice:double read ReadAdbPrice write WriteAdbPrice;
    property RoomPrice:double read ReadRoomPrice write WriteRoomPrice;
    property AdultCnt:longint read ReadAdultCnt write WriteAdultCnt;
    property ChildCnt:longint read ReadChildCnt write WriteChildCnt;
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
    property TimeI:TDatetime read ReadTimeI write WriteTimeI;
    property TimeO:TDatetime read ReadTimeO write WriteTimeO;
    property RoomDscPrc:double read ReadRoomDscPrc write WriteRoomDscPrc;
    property IcdNum:Str12 read ReadIcdNum write WriteIcdNum;
    property EmptStat:Str1 read ReadEmptStat write WriteEmptStat;
    property EmptDate:TDatetime read ReadEmptDate write WriteEmptDate;
    property EmptTime:TDatetime read ReadEmptTime write WriteEmptTime;
    property ActPosM:longint read ReadActPos write WriteActPos;
  end;

implementation

constructor TTniBtr.Create;
begin
  oBtrTable := BtrInit ('TNI',gPath.HtlPath,Self);
end;

constructor TTniBtr.Create(pPath:ShortString);
begin
  oBtrTable := BtrInit ('TNI',pPath,Self);
end;

destructor TTniBtr.Destroy;
begin
  oBtrTable.Close;  FreeAndNil (oBtrTable);
end;

// *************************************** PRIVATE ********************************************

function TTniBtr.ReadCount:integer;
begin
  Result := oBtrTable.RecordCount;
end;

function TTniBtr.FieldExist (pFieldName:ShortString): boolean;
begin
  Result := oBtrTable.FindField(pFieldName)<>nil;
end;

function TTniBtr.ReadTentNum:longint;
begin
  Result := oBtrTable.FieldByName('TentNum').AsInteger;
end;

procedure TTniBtr.WriteTentNum(pValue:longint);
begin
  oBtrTable.FieldByName('TentNum').AsInteger := pValue;
end;

function TTniBtr.ReadRoomNum:longint;
begin
  Result := oBtrTable.FieldByName('RoomNum').AsInteger;
end;

procedure TTniBtr.WriteRoomNum(pValue:longint);
begin
  oBtrTable.FieldByName('RoomNum').AsInteger := pValue;
end;

function TTniBtr.ReadDateI:TDatetime;
begin
  Result := oBtrTable.FieldByName('DateI').AsDateTime;
end;

procedure TTniBtr.WriteDateI(pValue:TDatetime);
begin
  oBtrTable.FieldByName('DateI').AsDateTime := pValue;
end;

function TTniBtr.ReadDateO:TDatetime;
begin
  Result := oBtrTable.FieldByName('DateO').AsDateTime;
end;

procedure TTniBtr.WriteDateO(pValue:TDatetime);
begin
  oBtrTable.FieldByName('DateO').AsDateTime := pValue;
end;

function TTniBtr.ReadBedCnt:longint;
begin
  Result := oBtrTable.FieldByName('BedCnt').AsInteger;
end;

procedure TTniBtr.WriteBedCnt(pValue:longint);
begin
  oBtrTable.FieldByName('BedCnt').AsInteger := pValue;
end;

function TTniBtr.ReadAdbCnt:longint;
begin
  Result := oBtrTable.FieldByName('AdbCnt').AsInteger;
end;

procedure TTniBtr.WriteAdbCnt(pValue:longint);
begin
  oBtrTable.FieldByName('AdbCnt').AsInteger := pValue;
end;

function TTniBtr.ReadBedPrice:double;
begin
  Result := oBtrTable.FieldByName('BedPrice').AsFloat;
end;

procedure TTniBtr.WriteBedPrice(pValue:double);
begin
  oBtrTable.FieldByName('BedPrice').AsFloat := pValue;
end;

function TTniBtr.ReadAdbPrice:double;
begin
  Result := oBtrTable.FieldByName('AdbPrice').AsFloat;
end;

procedure TTniBtr.WriteAdbPrice(pValue:double);
begin
  oBtrTable.FieldByName('AdbPrice').AsFloat := pValue;
end;

function TTniBtr.ReadRoomPrice:double;
begin
  Result := oBtrTable.FieldByName('RoomPrice').AsFloat;
end;

procedure TTniBtr.WriteRoomPrice(pValue:double);
begin
  oBtrTable.FieldByName('RoomPrice').AsFloat := pValue;
end;

function TTniBtr.ReadAdultCnt:longint;
begin
  Result := oBtrTable.FieldByName('AdultCnt').AsInteger;
end;

procedure TTniBtr.WriteAdultCnt(pValue:longint);
begin
  oBtrTable.FieldByName('AdultCnt').AsInteger := pValue;
end;

function TTniBtr.ReadChildCnt:longint;
begin
  Result := oBtrTable.FieldByName('ChildCnt').AsInteger;
end;

procedure TTniBtr.WriteChildCnt(pValue:longint);
begin
  oBtrTable.FieldByName('ChildCnt').AsInteger := pValue;
end;

function TTniBtr.ReadStatus:Str1;
begin
  Result := oBtrTable.FieldByName('Status').AsString;
end;

procedure TTniBtr.WriteStatus(pValue:Str1);
begin
  oBtrTable.FieldByName('Status').AsString := pValue;
end;

function TTniBtr.ReadVisVal:double;
begin
  Result := oBtrTable.FieldByName('VisVal').AsFloat;
end;

procedure TTniBtr.WriteVisVal(pValue:double);
begin
  oBtrTable.FieldByName('VisVal').AsFloat := pValue;
end;

function TTniBtr.ReadGrpVal:double;
begin
  Result := oBtrTable.FieldByName('GrpVal').AsFloat;
end;

procedure TTniBtr.WriteGrpVal(pValue:double);
begin
  oBtrTable.FieldByName('GrpVal').AsFloat := pValue;
end;

function TTniBtr.ReadPayVal:double;
begin
  Result := oBtrTable.FieldByName('PayVal').AsFloat;
end;

procedure TTniBtr.WritePayVal(pValue:double);
begin
  oBtrTable.FieldByName('PayVal').AsFloat := pValue;
end;

function TTniBtr.ReadEndVal:double;
begin
  Result := oBtrTable.FieldByName('EndVal').AsFloat;
end;

procedure TTniBtr.WriteEndVal(pValue:double);
begin
  oBtrTable.FieldByName('EndVal').AsFloat := pValue;
end;

function TTniBtr.ReadCrtUser:Str8;
begin
  Result := oBtrTable.FieldByName('CrtUser').AsString;
end;

procedure TTniBtr.WriteCrtUser(pValue:Str8);
begin
  oBtrTable.FieldByName('CrtUser').AsString := pValue;
end;

function TTniBtr.ReadCrtDate:TDatetime;
begin
  Result := oBtrTable.FieldByName('CrtDate').AsDateTime;
end;

procedure TTniBtr.WriteCrtDate(pValue:TDatetime);
begin
  oBtrTable.FieldByName('CrtDate').AsDateTime := pValue;
end;

function TTniBtr.ReadCrtTime:TDatetime;
begin
  Result := oBtrTable.FieldByName('CrtTime').AsDateTime;
end;

procedure TTniBtr.WriteCrtTime(pValue:TDatetime);
begin
  oBtrTable.FieldByName('CrtTime').AsDateTime := pValue;
end;

function TTniBtr.ReadModUser:Str8;
begin
  Result := oBtrTable.FieldByName('ModUser').AsString;
end;

procedure TTniBtr.WriteModUser(pValue:Str8);
begin
  oBtrTable.FieldByName('ModUser').AsString := pValue;
end;

function TTniBtr.ReadModDate:TDatetime;
begin
  Result := oBtrTable.FieldByName('ModDate').AsDateTime;
end;

procedure TTniBtr.WriteModDate(pValue:TDatetime);
begin
  oBtrTable.FieldByName('ModDate').AsDateTime := pValue;
end;

function TTniBtr.ReadModTime:TDatetime;
begin
  Result := oBtrTable.FieldByName('ModTime').AsDateTime;
end;

procedure TTniBtr.WriteModTime(pValue:TDatetime);
begin
  oBtrTable.FieldByName('ModTime').AsDateTime := pValue;
end;

function TTniBtr.ReadRoomPriceF:double;
begin
  Result := oBtrTable.FieldByName('RoomPriceF').AsFloat;
end;

procedure TTniBtr.WriteRoomPriceF(pValue:double);
begin
  oBtrTable.FieldByName('RoomPriceF').AsFloat := pValue;
end;

function TTniBtr.ReadDevice1:Str1;
begin
  Result := oBtrTable.FieldByName('Device1').AsString;
end;

procedure TTniBtr.WriteDevice1(pValue:Str1);
begin
  oBtrTable.FieldByName('Device1').AsString := pValue;
end;

function TTniBtr.ReadDevice2:Str1;
begin
  Result := oBtrTable.FieldByName('Device2').AsString;
end;

procedure TTniBtr.WriteDevice2(pValue:Str1);
begin
  oBtrTable.FieldByName('Device2').AsString := pValue;
end;

function TTniBtr.ReadDevice3:Str1;
begin
  Result := oBtrTable.FieldByName('Device3').AsString;
end;

procedure TTniBtr.WriteDevice3(pValue:Str1);
begin
  oBtrTable.FieldByName('Device3').AsString := pValue;
end;

function TTniBtr.ReadDevice4:Str1;
begin
  Result := oBtrTable.FieldByName('Device4').AsString;
end;

procedure TTniBtr.WriteDevice4(pValue:Str1);
begin
  oBtrTable.FieldByName('Device4').AsString := pValue;
end;

function TTniBtr.ReadDevice5:Str1;
begin
  Result := oBtrTable.FieldByName('Device5').AsString;
end;

procedure TTniBtr.WriteDevice5(pValue:Str1);
begin
  oBtrTable.FieldByName('Device5').AsString := pValue;
end;

function TTniBtr.ReadDevice6:Str1;
begin
  Result := oBtrTable.FieldByName('Device6').AsString;
end;

procedure TTniBtr.WriteDevice6(pValue:Str1);
begin
  oBtrTable.FieldByName('Device6').AsString := pValue;
end;

function TTniBtr.ReadDevice7:Str1;
begin
  Result := oBtrTable.FieldByName('Device7').AsString;
end;

procedure TTniBtr.WriteDevice7(pValue:Str1);
begin
  oBtrTable.FieldByName('Device7').AsString := pValue;
end;

function TTniBtr.ReadDevice8:Str1;
begin
  Result := oBtrTable.FieldByName('Device8').AsString;
end;

procedure TTniBtr.WriteDevice8(pValue:Str1);
begin
  oBtrTable.FieldByName('Device8').AsString := pValue;
end;

function TTniBtr.ReadDevice9:Str1;
begin
  Result := oBtrTable.FieldByName('Device9').AsString;
end;

procedure TTniBtr.WriteDevice9(pValue:Str1);
begin
  oBtrTable.FieldByName('Device9').AsString := pValue;
end;

function TTniBtr.ReadDevice10:Str1;
begin
  Result := oBtrTable.FieldByName('Device10').AsString;
end;

procedure TTniBtr.WriteDevice10(pValue:Str1);
begin
  oBtrTable.FieldByName('Device10').AsString := pValue;
end;

function TTniBtr.ReadRoomCode:Str15;
begin
  Result := oBtrTable.FieldByName('RoomCode').AsString;
end;

procedure TTniBtr.WriteRoomCode(pValue:Str15);
begin
  oBtrTable.FieldByName('RoomCode').AsString := pValue;
end;

function TTniBtr.ReadExtension:Str5;
begin
  Result := oBtrTable.FieldByName('Extension').AsString;
end;

procedure TTniBtr.WriteExtension(pValue:Str5);
begin
  oBtrTable.FieldByName('Extension').AsString := pValue;
end;

function TTniBtr.ReadTimeI:TDatetime;
begin
  Result := oBtrTable.FieldByName('TimeI').AsDateTime;
end;

procedure TTniBtr.WriteTimeI(pValue:TDatetime);
begin
  oBtrTable.FieldByName('TimeI').AsDateTime := pValue;
end;

function TTniBtr.ReadTimeO:TDatetime;
begin
  Result := oBtrTable.FieldByName('TimeO').AsDateTime;
end;

procedure TTniBtr.WriteTimeO(pValue:TDatetime);
begin
  oBtrTable.FieldByName('TimeO').AsDateTime := pValue;
end;

function TTniBtr.ReadRoomDscPrc:double;
begin
  Result := oBtrTable.FieldByName('RoomDscPrc').AsFloat;
end;

procedure TTniBtr.WriteRoomDscPrc(pValue:double);
begin
  oBtrTable.FieldByName('RoomDscPrc').AsFloat := pValue;
end;

function TTniBtr.ReadIcdNum:Str12;
begin
  Result := oBtrTable.FieldByName('IcdNum').AsString;
end;

procedure TTniBtr.WriteIcdNum(pValue:Str12);
begin
  oBtrTable.FieldByName('IcdNum').AsString := pValue;
end;

function TTniBtr.ReadEmptStat:Str1;
begin
  Result := oBtrTable.FieldByName('EmptStat').AsString;
end;

procedure TTniBtr.WriteEmptStat(pValue:Str1);
begin
  oBtrTable.FieldByName('EmptStat').AsString := pValue;
end;

function TTniBtr.ReadEmptDate:TDatetime;
begin
  Result := oBtrTable.FieldByName('EmptDate').AsDateTime;
end;

procedure TTniBtr.WriteEmptDate(pValue:TDatetime);
begin
  oBtrTable.FieldByName('EmptDate').AsDateTime := pValue;
end;

function TTniBtr.ReadEmptTime:TDatetime;
begin
  Result := oBtrTable.FieldByName('EmptTime').AsDateTime;
end;

procedure TTniBtr.WriteEmptTime(pValue:TDatetime);
begin
  oBtrTable.FieldByName('EmptTime').AsDateTime := pValue;
end;

function TTniBtr.ReadActPos:longint;
begin
  Result := oBtrTable.FieldByName('ActPos').AsInteger;
end;

procedure TTniBtr.WriteActPos(pValue:longint);
begin
  oBtrTable.FieldByName('ActPos').AsInteger := pValue;
end;

// **************************************** PUBLIC ********************************************

function TTniBtr.Eof: boolean;
begin
  Result := oBtrTable.Eof;
end;

function TTniBtr.IsFirstRec: boolean;
begin
  Result := oBtrTable.Bof;
end;

function TTniBtr.IsLastRec: boolean;
begin
  Result := oBtrTable.Eof;
end;

function TTniBtr.Active: boolean;
begin
  Result := oBtrTable.Active;
end;

function TTniBtr.ActPos: longint;
begin
  Result := oBtrTable.ActPos;
end;

function TTniBtr.GotoPos (pActPos:longint): boolean;
begin
  Result := oBtrTable.GotoPos(pActPos);
end;

function TTniBtr.LocateTentNum (pTentNum:longint):boolean;
begin
  SetIndex (ixTentNum);
  Result := oBtrTable.FindKey([pTentNum]);
end;

function TTniBtr.LocateTnRn (pTentNum:longint;pRoomNum:longint):boolean;
begin
  SetIndex (ixTnRn);
  Result := oBtrTable.FindKey([pTentNum,pRoomNum]);
end;

function TTniBtr.LocateRoomNum (pRoomNum:longint):boolean;
begin
  SetIndex (ixRoomNum);
  Result := oBtrTable.FindKey([pRoomNum]);
end;

function TTniBtr.LocateStatus (pStatus:Str1):boolean;
begin
  SetIndex (ixStatus);
  Result := oBtrTable.FindKey([pStatus]);
end;

function TTniBtr.NearestTentNum (pTentNum:longint):boolean;
begin
  SetIndex (ixTentNum);
  Result := oBtrTable.FindNearest([pTentNum]);
end;

function TTniBtr.NearestTnRn (pTentNum:longint;pRoomNum:longint):boolean;
begin
  SetIndex (ixTnRn);
  Result := oBtrTable.FindNearest([pTentNum,pRoomNum]);
end;

function TTniBtr.NearestRoomNum (pRoomNum:longint):boolean;
begin
  SetIndex (ixRoomNum);
  Result := oBtrTable.FindNearest([pRoomNum]);
end;

function TTniBtr.NearestStatus (pStatus:Str1):boolean;
begin
  SetIndex (ixStatus);
  Result := oBtrTable.FindNearest([pStatus]);
end;

procedure TTniBtr.SetIndex (pIndexName:ShortString);
begin
  If oBtrTable.IndexName<>pIndexName then oBtrTable.IndexName := pIndexName;
end;

procedure TTniBtr.Open;
begin
  oBtrTable.Open;
end;

procedure TTniBtr.Close;
begin
  If oBtrTable.Active then oBtrTable.Close;
end;

procedure TTniBtr.Prior;
begin
  oBtrTable.Prior;
end;

procedure TTniBtr.Next;
begin
  oBtrTable.Next;
end;

procedure TTniBtr.First;
begin
  oBtrTable.First;
end;

procedure TTniBtr.Last;
begin
  oBtrTable.Last;
end;

procedure TTniBtr.Insert;
begin
  oBtrTable.Insert;
end;

procedure TTniBtr.Edit;
begin
  oBtrTable.Edit;
end;

procedure TTniBtr.Post;
begin
  oBtrTable.Post;
end;

procedure TTniBtr.Delete;
begin
  oBtrTable.Delete;
end;

procedure TTniBtr.SwapIndex;
begin
  oBtrTable.SwapIndex;
end;

procedure TTniBtr.RestoreIndex;
begin
  oBtrTable.RestoreIndex;
end;

procedure TTniBtr.SwapStatus;
begin
  oBtrTable.SwapStatus;
end;

procedure TTniBtr.RestoreStatus;
begin
  oBtrTable.RestoreStatus;
end;

procedure TTniBtr.EnableControls;
begin
  oBtrTable.EnableControls;
end;

procedure TTniBtr.DisableControls;
begin
  oBtrTable.DisableControls;
end;

end.
