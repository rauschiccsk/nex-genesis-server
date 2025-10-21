unit tPACEVL;

interface

uses
  IcTypes, IcConv, NexPath, NexGlob, DocHand, 
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls,
  Dialogs, DB, NexBtrTable, DBTables, NexPxTable;

const
  ixPaCode = '';
  ixPaName = 'PaName';
  ixStatus = 'Status';

type
  TPacevlTmp = class (TComponent)
    constructor Create;
    destructor  Destroy; override;
  private
    oTmpTable: TNexPxTable;
    function ReadCount:integer;
    function FieldExist (pFieldName:ShortString): boolean;
    // Pristup k databazovym poliam
    function  ReadPaCode:longint;        procedure WritePaCode (pValue:longint);
    function  ReadPaName:Str30;          procedure WritePaName (pValue:Str30);
    function  ReadPaName_:Str30;         procedure WritePaName_ (pValue:Str30);
    function  ReadRegName:Str60;         procedure WriteRegName (pValue:Str60);
    function  ReadResNum:longint;        procedure WriteResNum (pValue:longint);
    function  ReadTentNum:longint;       procedure WriteTentNum (pValue:longint);
    function  ReadDateIt:TDatetime;      procedure WriteDateIt (pValue:TDatetime);
    function  ReadDateOt:TDatetime;      procedure WriteDateOt (pValue:TDatetime);
    function  ReadDateIr:TDatetime;      procedure WriteDateIr (pValue:TDatetime);
    function  ReadDateOr:TDatetime;      procedure WriteDateOr (pValue:TDatetime);
    function  ReadStatus:Str1;           procedure WriteStatus (pValue:Str1);
    function  ReadCrtUser:Str8;          procedure WriteCrtUser (pValue:Str8);
    function  ReadCrtDate:TDatetime;     procedure WriteCrtDate (pValue:TDatetime);
    function  ReadCrtTime:TDatetime;     procedure WriteCrtTime (pValue:TDatetime);
    function  ReadModUser:Str8;          procedure WriteModUser (pValue:Str8);
    function  ReadModDate:TDatetime;     procedure WriteModDate (pValue:TDatetime);
    function  ReadModTime:TDatetime;     procedure WriteModTime (pValue:TDatetime);
    function  ReadResCnt:longint;        procedure WriteResCnt (pValue:longint);
    function  ReadResLas:longint;        procedure WriteResLas (pValue:longint);
    function  ReadTentCnt:longint;       procedure WriteTentCnt (pValue:longint);
    function  ReadTentLas:longint;       procedure WriteTentLas (pValue:longint);
    function  ReadDayLasT:longint;       procedure WriteDayLasT (pValue:longint);
    function  ReadDaySumT:longint;       procedure WriteDaySumT (pValue:longint);
    function  ReadSrvLasT:double;        procedure WriteSrvLasT (pValue:double);
    function  ReadSrvSumT:double;        procedure WriteSrvSumT (pValue:double);
    function  ReadGscLasT:double;        procedure WriteGscLasT (pValue:double);
    function  ReadGscSumT:double;        procedure WriteGscSumT (pValue:double);
    function  ReadAPaValT:double;        procedure WriteAPaValT (pValue:double);
    function  ReadNPaValT:double;        procedure WriteNPaValT (pValue:double);
    function  ReadVisValT:double;        procedure WriteVisValT (pValue:double);
    function  ReadGrpValT:double;        procedure WriteGrpValT (pValue:double);
    function  ReadPayValT:double;        procedure WritePayValT (pValue:double);
    function  ReadEndValT:double;        procedure WriteEndValT (pValue:double);
    function  ReadDayLasR:longint;       procedure WriteDayLasR (pValue:longint);
    function  ReadDaySumR:longint;       procedure WriteDaySumR (pValue:longint);
    function  ReadSrvLasR:double;        procedure WriteSrvLasR (pValue:double);
    function  ReadSrvSumR:double;        procedure WriteSrvSumR (pValue:double);
    function  ReadGscLasR:double;        procedure WriteGscLasR (pValue:double);
    function  ReadGscSumR:double;        procedure WriteGscSumR (pValue:double);
    function  ReadAPaValR:double;        procedure WriteAPaValR (pValue:double);
    function  ReadNPaValR:double;        procedure WriteNPaValR (pValue:double);
    function  ReadRoomValR:double;       procedure WriteRoomValR (pValue:double);
    function  ReadFoodValR:double;       procedure WriteFoodValR (pValue:double);
    function  ReadSrvValR:double;        procedure WriteSrvValR (pValue:double);
    function  ReadPayValR:double;        procedure WritePayValR (pValue:double);
    function  ReadEndValR:double;        procedure WriteEndValR (pValue:double);
    function  ReadActPos:longint;        procedure WriteActPos (pValue:longint);
  public
    // Elementarne databazove operacie
    function Eof: boolean;
    function Active: boolean;
    function LocatePaCode (pPaCode:longint):boolean;
    function LocatePaName (pPaName_:Str30):boolean;
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
    property PaCode:longint read ReadPaCode write WritePaCode;
    property PaName:Str30 read ReadPaName write WritePaName;
    property PaName_:Str30 read ReadPaName_ write WritePaName_;
    property RegName:Str60 read ReadRegName write WriteRegName;
    property ResNum:longint read ReadResNum write WriteResNum;
    property TentNum:longint read ReadTentNum write WriteTentNum;
    property DateIt:TDatetime read ReadDateIt write WriteDateIt;
    property DateOt:TDatetime read ReadDateOt write WriteDateOt;
    property DateIr:TDatetime read ReadDateIr write WriteDateIr;
    property DateOr:TDatetime read ReadDateOr write WriteDateOr;
    property Status:Str1 read ReadStatus write WriteStatus;
    property CrtUser:Str8 read ReadCrtUser write WriteCrtUser;
    property CrtDate:TDatetime read ReadCrtDate write WriteCrtDate;
    property CrtTime:TDatetime read ReadCrtTime write WriteCrtTime;
    property ModUser:Str8 read ReadModUser write WriteModUser;
    property ModDate:TDatetime read ReadModDate write WriteModDate;
    property ModTime:TDatetime read ReadModTime write WriteModTime;
    property ResCnt:longint read ReadResCnt write WriteResCnt;
    property ResLas:longint read ReadResLas write WriteResLas;
    property TentCnt:longint read ReadTentCnt write WriteTentCnt;
    property TentLas:longint read ReadTentLas write WriteTentLas;
    property DayLasT:longint read ReadDayLasT write WriteDayLasT;
    property DaySumT:longint read ReadDaySumT write WriteDaySumT;
    property SrvLasT:double read ReadSrvLasT write WriteSrvLasT;
    property SrvSumT:double read ReadSrvSumT write WriteSrvSumT;
    property GscLasT:double read ReadGscLasT write WriteGscLasT;
    property GscSumT:double read ReadGscSumT write WriteGscSumT;
    property APaValT:double read ReadAPaValT write WriteAPaValT;
    property NPaValT:double read ReadNPaValT write WriteNPaValT;
    property VisValT:double read ReadVisValT write WriteVisValT;
    property GrpValT:double read ReadGrpValT write WriteGrpValT;
    property PayValT:double read ReadPayValT write WritePayValT;
    property EndValT:double read ReadEndValT write WriteEndValT;
    property DayLasR:longint read ReadDayLasR write WriteDayLasR;
    property DaySumR:longint read ReadDaySumR write WriteDaySumR;
    property SrvLasR:double read ReadSrvLasR write WriteSrvLasR;
    property SrvSumR:double read ReadSrvSumR write WriteSrvSumR;
    property GscLasR:double read ReadGscLasR write WriteGscLasR;
    property GscSumR:double read ReadGscSumR write WriteGscSumR;
    property APaValR:double read ReadAPaValR write WriteAPaValR;
    property NPaValR:double read ReadNPaValR write WriteNPaValR;
    property RoomValR:double read ReadRoomValR write WriteRoomValR;
    property FoodValR:double read ReadFoodValR write WriteFoodValR;
    property SrvValR:double read ReadSrvValR write WriteSrvValR;
    property PayValR:double read ReadPayValR write WritePayValR;
    property EndValR:double read ReadEndValR write WriteEndValR;
    property ActPos:longint read ReadActPos write WriteActPos;
  end;

implementation

constructor TPacevlTmp.Create;
begin
  oTmpTable := TmpInit ('PACEVL',Self);
end;

destructor TPacevlTmp.Destroy;
begin
  If oTmpTable.Active then oTmpTable.Close;
  FreeAndNil (oTmpTable);
end;

// *************************************** PRIVATE ********************************************

function TPacevlTmp.ReadCount:integer;
begin
  Result := oTmpTable.RecordCount;
end;

function TPacevlTmp.FieldExist (pFieldName:ShortString): boolean;
begin
  Result := oTmpTable.FindField(pFieldName)<>nil;
end;

function TPacevlTmp.ReadPaCode:longint;
begin
  Result := oTmpTable.FieldByName('PaCode').AsInteger;
end;

procedure TPacevlTmp.WritePaCode(pValue:longint);
begin
  oTmpTable.FieldByName('PaCode').AsInteger := pValue;
end;

function TPacevlTmp.ReadPaName:Str30;
begin
  Result := oTmpTable.FieldByName('PaName').AsString;
end;

procedure TPacevlTmp.WritePaName(pValue:Str30);
begin
  oTmpTable.FieldByName('PaName').AsString := pValue;
end;

function TPacevlTmp.ReadPaName_:Str30;
begin
  Result := oTmpTable.FieldByName('PaName_').AsString;
end;

procedure TPacevlTmp.WritePaName_(pValue:Str30);
begin
  oTmpTable.FieldByName('PaName_').AsString := pValue;
end;

function TPacevlTmp.ReadRegName:Str60;
begin
  Result := oTmpTable.FieldByName('RegName').AsString;
end;

procedure TPacevlTmp.WriteRegName(pValue:Str60);
begin
  oTmpTable.FieldByName('RegName').AsString := pValue;
end;

function TPacevlTmp.ReadResNum:longint;
begin
  Result := oTmpTable.FieldByName('ResNum').AsInteger;
end;

procedure TPacevlTmp.WriteResNum(pValue:longint);
begin
  oTmpTable.FieldByName('ResNum').AsInteger := pValue;
end;

function TPacevlTmp.ReadTentNum:longint;
begin
  Result := oTmpTable.FieldByName('TentNum').AsInteger;
end;

procedure TPacevlTmp.WriteTentNum(pValue:longint);
begin
  oTmpTable.FieldByName('TentNum').AsInteger := pValue;
end;

function TPacevlTmp.ReadDateIt:TDatetime;
begin
  Result := oTmpTable.FieldByName('DateIt').AsDateTime;
end;

procedure TPacevlTmp.WriteDateIt(pValue:TDatetime);
begin
  oTmpTable.FieldByName('DateIt').AsDateTime := pValue;
end;

function TPacevlTmp.ReadDateOt:TDatetime;
begin
  Result := oTmpTable.FieldByName('DateOt').AsDateTime;
end;

procedure TPacevlTmp.WriteDateOt(pValue:TDatetime);
begin
  oTmpTable.FieldByName('DateOt').AsDateTime := pValue;
end;

function TPacevlTmp.ReadDateIr:TDatetime;
begin
  Result := oTmpTable.FieldByName('DateIr').AsDateTime;
end;

procedure TPacevlTmp.WriteDateIr(pValue:TDatetime);
begin
  oTmpTable.FieldByName('DateIr').AsDateTime := pValue;
end;

function TPacevlTmp.ReadDateOr:TDatetime;
begin
  Result := oTmpTable.FieldByName('DateOr').AsDateTime;
end;

procedure TPacevlTmp.WriteDateOr(pValue:TDatetime);
begin
  oTmpTable.FieldByName('DateOr').AsDateTime := pValue;
end;

function TPacevlTmp.ReadStatus:Str1;
begin
  Result := oTmpTable.FieldByName('Status').AsString;
end;

procedure TPacevlTmp.WriteStatus(pValue:Str1);
begin
  oTmpTable.FieldByName('Status').AsString := pValue;
end;

function TPacevlTmp.ReadCrtUser:Str8;
begin
  Result := oTmpTable.FieldByName('CrtUser').AsString;
end;

procedure TPacevlTmp.WriteCrtUser(pValue:Str8);
begin
  oTmpTable.FieldByName('CrtUser').AsString := pValue;
end;

function TPacevlTmp.ReadCrtDate:TDatetime;
begin
  Result := oTmpTable.FieldByName('CrtDate').AsDateTime;
end;

procedure TPacevlTmp.WriteCrtDate(pValue:TDatetime);
begin
  oTmpTable.FieldByName('CrtDate').AsDateTime := pValue;
end;

function TPacevlTmp.ReadCrtTime:TDatetime;
begin
  Result := oTmpTable.FieldByName('CrtTime').AsDateTime;
end;

procedure TPacevlTmp.WriteCrtTime(pValue:TDatetime);
begin
  oTmpTable.FieldByName('CrtTime').AsDateTime := pValue;
end;

function TPacevlTmp.ReadModUser:Str8;
begin
  Result := oTmpTable.FieldByName('ModUser').AsString;
end;

procedure TPacevlTmp.WriteModUser(pValue:Str8);
begin
  oTmpTable.FieldByName('ModUser').AsString := pValue;
end;

function TPacevlTmp.ReadModDate:TDatetime;
begin
  Result := oTmpTable.FieldByName('ModDate').AsDateTime;
end;

procedure TPacevlTmp.WriteModDate(pValue:TDatetime);
begin
  oTmpTable.FieldByName('ModDate').AsDateTime := pValue;
end;

function TPacevlTmp.ReadModTime:TDatetime;
begin
  Result := oTmpTable.FieldByName('ModTime').AsDateTime;
end;

procedure TPacevlTmp.WriteModTime(pValue:TDatetime);
begin
  oTmpTable.FieldByName('ModTime').AsDateTime := pValue;
end;

function TPacevlTmp.ReadResCnt:longint;
begin
  Result := oTmpTable.FieldByName('ResCnt').AsInteger;
end;

procedure TPacevlTmp.WriteResCnt(pValue:longint);
begin
  oTmpTable.FieldByName('ResCnt').AsInteger := pValue;
end;

function TPacevlTmp.ReadResLas:longint;
begin
  Result := oTmpTable.FieldByName('ResLas').AsInteger;
end;

procedure TPacevlTmp.WriteResLas(pValue:longint);
begin
  oTmpTable.FieldByName('ResLas').AsInteger := pValue;
end;

function TPacevlTmp.ReadTentCnt:longint;
begin
  Result := oTmpTable.FieldByName('TentCnt').AsInteger;
end;

procedure TPacevlTmp.WriteTentCnt(pValue:longint);
begin
  oTmpTable.FieldByName('TentCnt').AsInteger := pValue;
end;

function TPacevlTmp.ReadTentLas:longint;
begin
  Result := oTmpTable.FieldByName('TentLas').AsInteger;
end;

procedure TPacevlTmp.WriteTentLas(pValue:longint);
begin
  oTmpTable.FieldByName('TentLas').AsInteger := pValue;
end;

function TPacevlTmp.ReadDayLasT:longint;
begin
  Result := oTmpTable.FieldByName('DayLasT').AsInteger;
end;

procedure TPacevlTmp.WriteDayLasT(pValue:longint);
begin
  oTmpTable.FieldByName('DayLasT').AsInteger := pValue;
end;

function TPacevlTmp.ReadDaySumT:longint;
begin
  Result := oTmpTable.FieldByName('DaySumT').AsInteger;
end;

procedure TPacevlTmp.WriteDaySumT(pValue:longint);
begin
  oTmpTable.FieldByName('DaySumT').AsInteger := pValue;
end;

function TPacevlTmp.ReadSrvLasT:double;
begin
  Result := oTmpTable.FieldByName('SrvLasT').AsFloat;
end;

procedure TPacevlTmp.WriteSrvLasT(pValue:double);
begin
  oTmpTable.FieldByName('SrvLasT').AsFloat := pValue;
end;

function TPacevlTmp.ReadSrvSumT:double;
begin
  Result := oTmpTable.FieldByName('SrvSumT').AsFloat;
end;

procedure TPacevlTmp.WriteSrvSumT(pValue:double);
begin
  oTmpTable.FieldByName('SrvSumT').AsFloat := pValue;
end;

function TPacevlTmp.ReadGscLasT:double;
begin
  Result := oTmpTable.FieldByName('GscLasT').AsFloat;
end;

procedure TPacevlTmp.WriteGscLasT(pValue:double);
begin
  oTmpTable.FieldByName('GscLasT').AsFloat := pValue;
end;

function TPacevlTmp.ReadGscSumT:double;
begin
  Result := oTmpTable.FieldByName('GscSumT').AsFloat;
end;

procedure TPacevlTmp.WriteGscSumT(pValue:double);
begin
  oTmpTable.FieldByName('GscSumT').AsFloat := pValue;
end;

function TPacevlTmp.ReadAPaValT:double;
begin
  Result := oTmpTable.FieldByName('APaValT').AsFloat;
end;

procedure TPacevlTmp.WriteAPaValT(pValue:double);
begin
  oTmpTable.FieldByName('APaValT').AsFloat := pValue;
end;

function TPacevlTmp.ReadNPaValT:double;
begin
  Result := oTmpTable.FieldByName('NPaValT').AsFloat;
end;

procedure TPacevlTmp.WriteNPaValT(pValue:double);
begin
  oTmpTable.FieldByName('NPaValT').AsFloat := pValue;
end;

function TPacevlTmp.ReadVisValT:double;
begin
  Result := oTmpTable.FieldByName('VisValT').AsFloat;
end;

procedure TPacevlTmp.WriteVisValT(pValue:double);
begin
  oTmpTable.FieldByName('VisValT').AsFloat := pValue;
end;

function TPacevlTmp.ReadGrpValT:double;
begin
  Result := oTmpTable.FieldByName('GrpValT').AsFloat;
end;

procedure TPacevlTmp.WriteGrpValT(pValue:double);
begin
  oTmpTable.FieldByName('GrpValT').AsFloat := pValue;
end;

function TPacevlTmp.ReadPayValT:double;
begin
  Result := oTmpTable.FieldByName('PayValT').AsFloat;
end;

procedure TPacevlTmp.WritePayValT(pValue:double);
begin
  oTmpTable.FieldByName('PayValT').AsFloat := pValue;
end;

function TPacevlTmp.ReadEndValT:double;
begin
  Result := oTmpTable.FieldByName('EndValT').AsFloat;
end;

procedure TPacevlTmp.WriteEndValT(pValue:double);
begin
  oTmpTable.FieldByName('EndValT').AsFloat := pValue;
end;

function TPacevlTmp.ReadDayLasR:longint;
begin
  Result := oTmpTable.FieldByName('DayLasR').AsInteger;
end;

procedure TPacevlTmp.WriteDayLasR(pValue:longint);
begin
  oTmpTable.FieldByName('DayLasR').AsInteger := pValue;
end;

function TPacevlTmp.ReadDaySumR:longint;
begin
  Result := oTmpTable.FieldByName('DaySumR').AsInteger;
end;

procedure TPacevlTmp.WriteDaySumR(pValue:longint);
begin
  oTmpTable.FieldByName('DaySumR').AsInteger := pValue;
end;

function TPacevlTmp.ReadSrvLasR:double;
begin
  Result := oTmpTable.FieldByName('SrvLasR').AsFloat;
end;

procedure TPacevlTmp.WriteSrvLasR(pValue:double);
begin
  oTmpTable.FieldByName('SrvLasR').AsFloat := pValue;
end;

function TPacevlTmp.ReadSrvSumR:double;
begin
  Result := oTmpTable.FieldByName('SrvSumR').AsFloat;
end;

procedure TPacevlTmp.WriteSrvSumR(pValue:double);
begin
  oTmpTable.FieldByName('SrvSumR').AsFloat := pValue;
end;

function TPacevlTmp.ReadGscLasR:double;
begin
  Result := oTmpTable.FieldByName('GscLasR').AsFloat;
end;

procedure TPacevlTmp.WriteGscLasR(pValue:double);
begin
  oTmpTable.FieldByName('GscLasR').AsFloat := pValue;
end;

function TPacevlTmp.ReadGscSumR:double;
begin
  Result := oTmpTable.FieldByName('GscSumR').AsFloat;
end;

procedure TPacevlTmp.WriteGscSumR(pValue:double);
begin
  oTmpTable.FieldByName('GscSumR').AsFloat := pValue;
end;

function TPacevlTmp.ReadAPaValR:double;
begin
  Result := oTmpTable.FieldByName('APaValR').AsFloat;
end;

procedure TPacevlTmp.WriteAPaValR(pValue:double);
begin
  oTmpTable.FieldByName('APaValR').AsFloat := pValue;
end;

function TPacevlTmp.ReadNPaValR:double;
begin
  Result := oTmpTable.FieldByName('NPaValR').AsFloat;
end;

procedure TPacevlTmp.WriteNPaValR(pValue:double);
begin
  oTmpTable.FieldByName('NPaValR').AsFloat := pValue;
end;

function TPacevlTmp.ReadRoomValR:double;
begin
  Result := oTmpTable.FieldByName('RoomValR').AsFloat;
end;

procedure TPacevlTmp.WriteRoomValR(pValue:double);
begin
  oTmpTable.FieldByName('RoomValR').AsFloat := pValue;
end;

function TPacevlTmp.ReadFoodValR:double;
begin
  Result := oTmpTable.FieldByName('FoodValR').AsFloat;
end;

procedure TPacevlTmp.WriteFoodValR(pValue:double);
begin
  oTmpTable.FieldByName('FoodValR').AsFloat := pValue;
end;

function TPacevlTmp.ReadSrvValR:double;
begin
  Result := oTmpTable.FieldByName('SrvValR').AsFloat;
end;

procedure TPacevlTmp.WriteSrvValR(pValue:double);
begin
  oTmpTable.FieldByName('SrvValR').AsFloat := pValue;
end;

function TPacevlTmp.ReadPayValR:double;
begin
  Result := oTmpTable.FieldByName('PayValR').AsFloat;
end;

procedure TPacevlTmp.WritePayValR(pValue:double);
begin
  oTmpTable.FieldByName('PayValR').AsFloat := pValue;
end;

function TPacevlTmp.ReadEndValR:double;
begin
  Result := oTmpTable.FieldByName('EndValR').AsFloat;
end;

procedure TPacevlTmp.WriteEndValR(pValue:double);
begin
  oTmpTable.FieldByName('EndValR').AsFloat := pValue;
end;

function TPacevlTmp.ReadActPos:longint;
begin
  Result := oTmpTable.FieldByName('ActPos').AsInteger;
end;

procedure TPacevlTmp.WriteActPos(pValue:longint);
begin
  oTmpTable.FieldByName('ActPos').AsInteger := pValue;
end;

// **************************************** PUBLIC ********************************************

function TPacevlTmp.Eof: boolean;
begin
  Result := oTmpTable.Eof;
end;

function TPacevlTmp.Active: boolean;
begin
  Result := oTmpTable.Active;
end;

function TPacevlTmp.LocatePaCode (pPaCode:longint):boolean;
begin
  SetIndex (ixPaCode);
  Result := oTmpTable.FindKey([pPaCode]);
end;

function TPacevlTmp.LocatePaName (pPaName_:Str30):boolean;
begin
  SetIndex (ixPaName);
  Result := oTmpTable.FindKey([pPaName_]);
end;

function TPacevlTmp.LocateStatus (pStatus:Str1):boolean;
begin
  SetIndex (ixStatus);
  Result := oTmpTable.FindKey([pStatus]);
end;

procedure TPacevlTmp.SetIndex (pIndexName:ShortString);
begin
  If oTmpTable.IndexName<>pIndexName then oTmpTable.IndexName := pIndexName;
end;

procedure TPacevlTmp.Open;
begin
  oTmpTable.Open;
end;

procedure TPacevlTmp.Close;
begin
  If oTmpTable.Active then oTmpTable.Close;
end;

procedure TPacevlTmp.Prior;
begin
  oTmpTable.Prior;
end;

procedure TPacevlTmp.Next;
begin
  oTmpTable.Next;
end;

procedure TPacevlTmp.First;
begin
  oTmpTable.First;
end;

procedure TPacevlTmp.Last;
begin
  oTmpTable.Last;
end;

procedure TPacevlTmp.Insert;
begin
  oTmpTable.Insert;
end;

procedure TPacevlTmp.Edit;
begin
  oTmpTable.Edit;
end;

procedure TPacevlTmp.Post;
var mEdit:boolean;
begin
  oTmpTable.Post;
end;

procedure TPacevlTmp.Delete;
begin
  oTmpTable.Delete;
end;

procedure TPacevlTmp.SwapIndex;
begin
  oTmpTable.SwapIndex;
end;

procedure TPacevlTmp.RestoreIndex;
begin
  oTmpTable.RestoreIndex;
end;

procedure TPacevlTmp.SwapStatus;
begin
  oTmpTable.SwapStatus;
end;

procedure TPacevlTmp.RestoreStatus;
begin
  oTmpTable.RestoreStatus;
end;

procedure TPacevlTmp.EnableControls;
begin
  oTmpTable.EnableControls;
end;

procedure TPacevlTmp.DisableControls;
begin
  oTmpTable.DisableControls;
end;

end.
{MOD 1906001}
