unit tTNI;

interface

uses
  IcTypes, IcConv, NexPath, NexGlob, DocHand, 
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls,
  Dialogs, DB, NexBtrTable, DBTables, NexPxTable;

const
  ixTnRn = '';
  ixTentNum = 'TentNum';
  ixRoomNum = 'RoomNum';
  ixStatus = 'Status';

type
  TTniTmp = class (TComponent)
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
    // Elementarne databazove operacie
    function Eof: boolean;
    function Active: boolean;
    function LocateTnRn (pTentNum:longint;pRoomNum:longint):boolean;
    function LocateTentNum (pTentNum:longint):boolean;
    function LocateRoomNum (pRoomNum:longint):boolean;
    function LocateStatus (pStatus:Str1):boolean;

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
    property ActPos:longint read ReadActPos write WriteActPos;
  end;

implementation

constructor TTniTmp.Create;
begin
  oTmpTable := TmpInit ('TNI',Self);
end;

destructor TTniTmp.Destroy;
begin
  If oTmpTable.Active then oTmpTable.Close;
  FreeAndNil (oTmpTable);
end;

// *************************************** PRIVATE ********************************************

function TTniTmp.ReadCount:integer;
begin
  Result := oTmpTable.RecordCount;
end;

function TTniTmp.FieldExist (pFieldName:ShortString): boolean;
begin
  Result := oTmpTable.FindField(pFieldName)<>nil;
end;

function TTniTmp.ReadTentNum:longint;
begin
  Result := oTmpTable.FieldByName('TentNum').AsInteger;
end;

procedure TTniTmp.WriteTentNum(pValue:longint);
begin
  oTmpTable.FieldByName('TentNum').AsInteger := pValue;
end;

function TTniTmp.ReadRoomNum:longint;
begin
  Result := oTmpTable.FieldByName('RoomNum').AsInteger;
end;

procedure TTniTmp.WriteRoomNum(pValue:longint);
begin
  oTmpTable.FieldByName('RoomNum').AsInteger := pValue;
end;

function TTniTmp.ReadDateI:TDatetime;
begin
  Result := oTmpTable.FieldByName('DateI').AsDateTime;
end;

procedure TTniTmp.WriteDateI(pValue:TDatetime);
begin
  oTmpTable.FieldByName('DateI').AsDateTime := pValue;
end;

function TTniTmp.ReadDateO:TDatetime;
begin
  Result := oTmpTable.FieldByName('DateO').AsDateTime;
end;

procedure TTniTmp.WriteDateO(pValue:TDatetime);
begin
  oTmpTable.FieldByName('DateO').AsDateTime := pValue;
end;

function TTniTmp.ReadBedCnt:longint;
begin
  Result := oTmpTable.FieldByName('BedCnt').AsInteger;
end;

procedure TTniTmp.WriteBedCnt(pValue:longint);
begin
  oTmpTable.FieldByName('BedCnt').AsInteger := pValue;
end;

function TTniTmp.ReadAdbCnt:longint;
begin
  Result := oTmpTable.FieldByName('AdbCnt').AsInteger;
end;

procedure TTniTmp.WriteAdbCnt(pValue:longint);
begin
  oTmpTable.FieldByName('AdbCnt').AsInteger := pValue;
end;

function TTniTmp.ReadBedPrice:double;
begin
  Result := oTmpTable.FieldByName('BedPrice').AsFloat;
end;

procedure TTniTmp.WriteBedPrice(pValue:double);
begin
  oTmpTable.FieldByName('BedPrice').AsFloat := pValue;
end;

function TTniTmp.ReadAdbPrice:double;
begin
  Result := oTmpTable.FieldByName('AdbPrice').AsFloat;
end;

procedure TTniTmp.WriteAdbPrice(pValue:double);
begin
  oTmpTable.FieldByName('AdbPrice').AsFloat := pValue;
end;

function TTniTmp.ReadRoomPrice:double;
begin
  Result := oTmpTable.FieldByName('RoomPrice').AsFloat;
end;

procedure TTniTmp.WriteRoomPrice(pValue:double);
begin
  oTmpTable.FieldByName('RoomPrice').AsFloat := pValue;
end;

function TTniTmp.ReadAdultCnt:longint;
begin
  Result := oTmpTable.FieldByName('AdultCnt').AsInteger;
end;

procedure TTniTmp.WriteAdultCnt(pValue:longint);
begin
  oTmpTable.FieldByName('AdultCnt').AsInteger := pValue;
end;

function TTniTmp.ReadChildCnt:longint;
begin
  Result := oTmpTable.FieldByName('ChildCnt').AsInteger;
end;

procedure TTniTmp.WriteChildCnt(pValue:longint);
begin
  oTmpTable.FieldByName('ChildCnt').AsInteger := pValue;
end;

function TTniTmp.ReadStatus:Str1;
begin
  Result := oTmpTable.FieldByName('Status').AsString;
end;

procedure TTniTmp.WriteStatus(pValue:Str1);
begin
  oTmpTable.FieldByName('Status').AsString := pValue;
end;

function TTniTmp.ReadVisVal:double;
begin
  Result := oTmpTable.FieldByName('VisVal').AsFloat;
end;

procedure TTniTmp.WriteVisVal(pValue:double);
begin
  oTmpTable.FieldByName('VisVal').AsFloat := pValue;
end;

function TTniTmp.ReadGrpVal:double;
begin
  Result := oTmpTable.FieldByName('GrpVal').AsFloat;
end;

procedure TTniTmp.WriteGrpVal(pValue:double);
begin
  oTmpTable.FieldByName('GrpVal').AsFloat := pValue;
end;

function TTniTmp.ReadPayVal:double;
begin
  Result := oTmpTable.FieldByName('PayVal').AsFloat;
end;

procedure TTniTmp.WritePayVal(pValue:double);
begin
  oTmpTable.FieldByName('PayVal').AsFloat := pValue;
end;

function TTniTmp.ReadEndVal:double;
begin
  Result := oTmpTable.FieldByName('EndVal').AsFloat;
end;

procedure TTniTmp.WriteEndVal(pValue:double);
begin
  oTmpTable.FieldByName('EndVal').AsFloat := pValue;
end;

function TTniTmp.ReadCrtUser:Str8;
begin
  Result := oTmpTable.FieldByName('CrtUser').AsString;
end;

procedure TTniTmp.WriteCrtUser(pValue:Str8);
begin
  oTmpTable.FieldByName('CrtUser').AsString := pValue;
end;

function TTniTmp.ReadCrtDate:TDatetime;
begin
  Result := oTmpTable.FieldByName('CrtDate').AsDateTime;
end;

procedure TTniTmp.WriteCrtDate(pValue:TDatetime);
begin
  oTmpTable.FieldByName('CrtDate').AsDateTime := pValue;
end;

function TTniTmp.ReadCrtTime:TDatetime;
begin
  Result := oTmpTable.FieldByName('CrtTime').AsDateTime;
end;

procedure TTniTmp.WriteCrtTime(pValue:TDatetime);
begin
  oTmpTable.FieldByName('CrtTime').AsDateTime := pValue;
end;

function TTniTmp.ReadModUser:Str8;
begin
  Result := oTmpTable.FieldByName('ModUser').AsString;
end;

procedure TTniTmp.WriteModUser(pValue:Str8);
begin
  oTmpTable.FieldByName('ModUser').AsString := pValue;
end;

function TTniTmp.ReadModDate:TDatetime;
begin
  Result := oTmpTable.FieldByName('ModDate').AsDateTime;
end;

procedure TTniTmp.WriteModDate(pValue:TDatetime);
begin
  oTmpTable.FieldByName('ModDate').AsDateTime := pValue;
end;

function TTniTmp.ReadModTime:TDatetime;
begin
  Result := oTmpTable.FieldByName('ModTime').AsDateTime;
end;

procedure TTniTmp.WriteModTime(pValue:TDatetime);
begin
  oTmpTable.FieldByName('ModTime').AsDateTime := pValue;
end;

function TTniTmp.ReadRoomPriceF:double;
begin
  Result := oTmpTable.FieldByName('RoomPriceF').AsFloat;
end;

procedure TTniTmp.WriteRoomPriceF(pValue:double);
begin
  oTmpTable.FieldByName('RoomPriceF').AsFloat := pValue;
end;

function TTniTmp.ReadDevice1:Str1;
begin
  Result := oTmpTable.FieldByName('Device1').AsString;
end;

procedure TTniTmp.WriteDevice1(pValue:Str1);
begin
  oTmpTable.FieldByName('Device1').AsString := pValue;
end;

function TTniTmp.ReadDevice2:Str1;
begin
  Result := oTmpTable.FieldByName('Device2').AsString;
end;

procedure TTniTmp.WriteDevice2(pValue:Str1);
begin
  oTmpTable.FieldByName('Device2').AsString := pValue;
end;

function TTniTmp.ReadDevice3:Str1;
begin
  Result := oTmpTable.FieldByName('Device3').AsString;
end;

procedure TTniTmp.WriteDevice3(pValue:Str1);
begin
  oTmpTable.FieldByName('Device3').AsString := pValue;
end;

function TTniTmp.ReadDevice4:Str1;
begin
  Result := oTmpTable.FieldByName('Device4').AsString;
end;

procedure TTniTmp.WriteDevice4(pValue:Str1);
begin
  oTmpTable.FieldByName('Device4').AsString := pValue;
end;

function TTniTmp.ReadDevice5:Str1;
begin
  Result := oTmpTable.FieldByName('Device5').AsString;
end;

procedure TTniTmp.WriteDevice5(pValue:Str1);
begin
  oTmpTable.FieldByName('Device5').AsString := pValue;
end;

function TTniTmp.ReadDevice6:Str1;
begin
  Result := oTmpTable.FieldByName('Device6').AsString;
end;

procedure TTniTmp.WriteDevice6(pValue:Str1);
begin
  oTmpTable.FieldByName('Device6').AsString := pValue;
end;

function TTniTmp.ReadDevice7:Str1;
begin
  Result := oTmpTable.FieldByName('Device7').AsString;
end;

procedure TTniTmp.WriteDevice7(pValue:Str1);
begin
  oTmpTable.FieldByName('Device7').AsString := pValue;
end;

function TTniTmp.ReadDevice8:Str1;
begin
  Result := oTmpTable.FieldByName('Device8').AsString;
end;

procedure TTniTmp.WriteDevice8(pValue:Str1);
begin
  oTmpTable.FieldByName('Device8').AsString := pValue;
end;

function TTniTmp.ReadDevice9:Str1;
begin
  Result := oTmpTable.FieldByName('Device9').AsString;
end;

procedure TTniTmp.WriteDevice9(pValue:Str1);
begin
  oTmpTable.FieldByName('Device9').AsString := pValue;
end;

function TTniTmp.ReadDevice10:Str1;
begin
  Result := oTmpTable.FieldByName('Device10').AsString;
end;

procedure TTniTmp.WriteDevice10(pValue:Str1);
begin
  oTmpTable.FieldByName('Device10').AsString := pValue;
end;

function TTniTmp.ReadRoomCode:Str15;
begin
  Result := oTmpTable.FieldByName('RoomCode').AsString;
end;

procedure TTniTmp.WriteRoomCode(pValue:Str15);
begin
  oTmpTable.FieldByName('RoomCode').AsString := pValue;
end;

function TTniTmp.ReadExtension:Str5;
begin
  Result := oTmpTable.FieldByName('Extension').AsString;
end;

procedure TTniTmp.WriteExtension(pValue:Str5);
begin
  oTmpTable.FieldByName('Extension').AsString := pValue;
end;

function TTniTmp.ReadTimeI:TDatetime;
begin
  Result := oTmpTable.FieldByName('TimeI').AsDateTime;
end;

procedure TTniTmp.WriteTimeI(pValue:TDatetime);
begin
  oTmpTable.FieldByName('TimeI').AsDateTime := pValue;
end;

function TTniTmp.ReadTimeO:TDatetime;
begin
  Result := oTmpTable.FieldByName('TimeO').AsDateTime;
end;

procedure TTniTmp.WriteTimeO(pValue:TDatetime);
begin
  oTmpTable.FieldByName('TimeO').AsDateTime := pValue;
end;

function TTniTmp.ReadRoomDscPrc:double;
begin
  Result := oTmpTable.FieldByName('RoomDscPrc').AsFloat;
end;

procedure TTniTmp.WriteRoomDscPrc(pValue:double);
begin
  oTmpTable.FieldByName('RoomDscPrc').AsFloat := pValue;
end;

function TTniTmp.ReadIcdNum:Str12;
begin
  Result := oTmpTable.FieldByName('IcdNum').AsString;
end;

procedure TTniTmp.WriteIcdNum(pValue:Str12);
begin
  oTmpTable.FieldByName('IcdNum').AsString := pValue;
end;

function TTniTmp.ReadEmptStat:Str1;
begin
  Result := oTmpTable.FieldByName('EmptStat').AsString;
end;

procedure TTniTmp.WriteEmptStat(pValue:Str1);
begin
  oTmpTable.FieldByName('EmptStat').AsString := pValue;
end;

function TTniTmp.ReadEmptDate:TDatetime;
begin
  Result := oTmpTable.FieldByName('EmptDate').AsDateTime;
end;

procedure TTniTmp.WriteEmptDate(pValue:TDatetime);
begin
  oTmpTable.FieldByName('EmptDate').AsDateTime := pValue;
end;

function TTniTmp.ReadEmptTime:TDatetime;
begin
  Result := oTmpTable.FieldByName('EmptTime').AsDateTime;
end;

procedure TTniTmp.WriteEmptTime(pValue:TDatetime);
begin
  oTmpTable.FieldByName('EmptTime').AsDateTime := pValue;
end;

function TTniTmp.ReadActPos:longint;
begin
  Result := oTmpTable.FieldByName('ActPos').AsInteger;
end;

procedure TTniTmp.WriteActPos(pValue:longint);
begin
  oTmpTable.FieldByName('ActPos').AsInteger := pValue;
end;

// **************************************** PUBLIC ********************************************

function TTniTmp.Eof: boolean;
begin
  Result := oTmpTable.Eof;
end;

function TTniTmp.Active: boolean;
begin
  Result := oTmpTable.Active;
end;

function TTniTmp.LocateTnRn (pTentNum:longint;pRoomNum:longint):boolean;
begin
  SetIndex (ixTnRn);
  Result := oTmpTable.FindKey([pTentNum,pRoomNum]);
end;

function TTniTmp.LocateTentNum (pTentNum:longint):boolean;
begin
  SetIndex (ixTentNum);
  Result := oTmpTable.FindKey([pTentNum]);
end;

function TTniTmp.LocateRoomNum (pRoomNum:longint):boolean;
begin
  SetIndex (ixRoomNum);
  Result := oTmpTable.FindKey([pRoomNum]);
end;

function TTniTmp.LocateStatus (pStatus:Str1):boolean;
begin
  SetIndex (ixStatus);
  Result := oTmpTable.FindKey([pStatus]);
end;

procedure TTniTmp.SetIndex (pIndexName:ShortString);
begin
  If oTmpTable.IndexName<>pIndexName then oTmpTable.IndexName := pIndexName;
end;

procedure TTniTmp.Open;
begin
  oTmpTable.Open;
end;

procedure TTniTmp.Close;
begin
  If oTmpTable.Active then oTmpTable.Close;
end;

procedure TTniTmp.Prior;
begin
  oTmpTable.Prior;
end;

procedure TTniTmp.Next;
begin
  oTmpTable.Next;
end;

procedure TTniTmp.First;
begin
  oTmpTable.First;
end;

procedure TTniTmp.Last;
begin
  oTmpTable.Last;
end;

procedure TTniTmp.Insert;
begin
  oTmpTable.Insert;
end;

procedure TTniTmp.Edit;
begin
  oTmpTable.Edit;
end;

procedure TTniTmp.Post;
var mEdit:boolean;
begin
  oTmpTable.Post;
end;

procedure TTniTmp.Delete;
begin
  oTmpTable.Delete;
end;

procedure TTniTmp.SwapIndex;
begin
  oTmpTable.SwapIndex;
end;

procedure TTniTmp.RestoreIndex;
begin
  oTmpTable.RestoreIndex;
end;

procedure TTniTmp.SwapStatus;
begin
  oTmpTable.SwapStatus;
end;

procedure TTniTmp.RestoreStatus;
begin
  oTmpTable.RestoreStatus;
end;

procedure TTniTmp.EnableControls;
begin
  oTmpTable.EnableControls;
end;

procedure TTniTmp.DisableControls;
begin
  oTmpTable.DisableControls;
end;

end.
