unit bPRH;

interface

uses
  IcTypes, IcConv, NexPath, NexGlob,
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls,
  Dialogs, DB, NexBtrTable, DBTables, NexPxTable;

const
  ixYearSerNum = 'YearSerNum';
  ixDocNum = 'DocNum';
  ixPrjName = 'PrjName';

type
  TPrhBtr = class (TComponent)
    constructor Create; overload;
    destructor  Destroy; override;
  private
    oBookNum: Str5;
    oBtrTable: TNexBtrTable;
    function ReadCount:integer;
    function FieldExist (pFieldName:ShortString): boolean;
    // Pristup k databazovym poliam
    function  ReadYear:Str2;             procedure WriteYear (pValue:Str2);
    function  ReadDocNum:Str12;          procedure WriteDocNum (pValue:Str12);
    function  ReadSerNum:word;           procedure WriteSerNum (pValue:word);
    function  ReadPrjName:Str120;        procedure WritePrjName (pValue:Str120);
    function  ReadPrjName_:Str120;       procedure WritePrjName_ (pValue:Str120);
    function  ReadDocDate:TDatetime;     procedure WriteDocDate (pValue:TDatetime);
    function  ReadBegDate:TDatetime;     procedure WriteBegDate (pValue:TDatetime);
    function  ReadEndDate:TDatetime;     procedure WriteEndDate (pValue:TDatetime);
    function  ReadRspNum:word;           procedure WriteRspNum (pValue:word);
    function  ReadRspUser:Str8;          procedure WriteRspUser (pValue:Str8);
    function  ReadRspName:Str30;         procedure WriteRspName (pValue:Str30);
    function  ReadWrkDay:byte;           procedure WriteWrkDay (pValue:byte);
    function  ReadWrkWek:byte;           procedure WriteWrkWek (pValue:byte);
    function  ReadUniQnt:word;           procedure WriteUniQnt (pValue:word);
    function  ReadDurDay:word;           procedure WriteDurDay (pValue:word);
    function  ReadDurHor:byte;           procedure WriteDurHor (pValue:byte);
    function  ReadDurMin:byte;           procedure WriteDurMin (pValue:byte);
    function  ReadSpcPrc:double;         procedure WriteSpcPrc (pValue:double);
    function  ReadDocPrc:double;         procedure WriteDocPrc (pValue:double);
    function  ReadPrgPrc:double;         procedure WritePrgPrc (pValue:double);
    function  ReadTesPrc:double;         procedure WriteTesPrc (pValue:double);
    function  ReadDebPrc:double;         procedure WriteDebPrc (pValue:double);
    function  ReadAcpPrc:double;         procedure WriteAcpPrc (pValue:double);
    function  ReadAdmPrc:double;         procedure WriteAdmPrc (pValue:double);
    function  ReadResPrc:double;         procedure WriteResPrc (pValue:double);
    function  ReadSpcPce:double;         procedure WriteSpcPce (pValue:double);
    function  ReadDocPce:double;         procedure WriteDocPce (pValue:double);
    function  ReadPrgPce:double;         procedure WritePrgPce (pValue:double);
    function  ReadTesPce:double;         procedure WriteTesPce (pValue:double);
    function  ReadDebPce:double;         procedure WriteDebPce (pValue:double);
    function  ReadAcpPce:double;         procedure WriteAcpPce (pValue:double);
    function  ReadAdmPce:double;         procedure WriteAdmPce (pValue:double);
    function  ReadResPce:double;         procedure WriteResPce (pValue:double);
    function  ReadSumDur:double;         procedure WriteSumDur (pValue:double);
    function  ReadSpcDur:double;         procedure WriteSpcDur (pValue:double);
    function  ReadDocDur:double;         procedure WriteDocDur (pValue:double);
    function  ReadPrgDur:double;         procedure WritePrgDur (pValue:double);
    function  ReadTesDur:double;         procedure WriteTesDur (pValue:double);
    function  ReadDebDur:double;         procedure WriteDebDur (pValue:double);
    function  ReadAcpDur:double;         procedure WriteAcpDur (pValue:double);
    function  ReadAdmDur:double;         procedure WriteAdmDur (pValue:double);
    function  ReadResDur:double;         procedure WriteResDur (pValue:double);
    function  ReadSumVal:double;         procedure WriteSumVal (pValue:double);
    function  ReadSpcVal:double;         procedure WriteSpcVal (pValue:double);
    function  ReadDocVal:double;         procedure WriteDocVal (pValue:double);
    function  ReadPrgVal:double;         procedure WritePrgVal (pValue:double);
    function  ReadTesVal:double;         procedure WriteTesVal (pValue:double);
    function  ReadDebVal:double;         procedure WriteDebVal (pValue:double);
    function  ReadAcpVal:double;         procedure WriteAcpVal (pValue:double);
    function  ReadAdmVal:double;         procedure WriteAdmVal (pValue:double);
    function  ReadResVal:double;         procedure WriteResVal (pValue:double);
    function  ReadPrfPrc:double;         procedure WritePrfPrc (pValue:double);
    function  ReadPrfval:double;         procedure WritePrfval (pValue:double);
    function  ReadAValue:double;         procedure WriteAValue (pValue:double);
    function  ReadItmQnt:word;           procedure WriteItmQnt (pValue:word);
    function  ReadCrtUser:Str8;          procedure WriteCrtUser (pValue:Str8);
    function  ReadCrtDate:TDatetime;     procedure WriteCrtDate (pValue:TDatetime);
    function  ReadCrtTime:TDatetime;     procedure WriteCrtTime (pValue:TDatetime);
    function  ReadModUser:Str8;          procedure WriteModUser (pValue:Str8);
    function  ReadModDate:TDatetime;     procedure WriteModDate (pValue:TDatetime);
    function  ReadModTime:TDatetime;     procedure WriteModTime (pValue:TDatetime);
    function  ReadCmpPrc:double;         procedure WriteCmpPrc (pValue:double);
    function  ReadSpcCmp:double;         procedure WriteSpcCmp (pValue:double);
    function  ReadDocCmp:double;         procedure WriteDocCmp (pValue:double);
    function  ReadPrgCmp:double;         procedure WritePrgCmp (pValue:double);
    function  ReadPrgQnt:word;           procedure WritePrgQnt (pValue:word);
    function  ReadTesCmp:double;         procedure WriteTesCmp (pValue:double);
    function  ReadDebCmp:double;         procedure WriteDebCmp (pValue:double);
    function  ReadAcpCmp:double;         procedure WriteAcpCmp (pValue:double);
    function  ReadAdmCmp:double;         procedure WriteAdmCmp (pValue:double);
    function  ReadResCmp:double;         procedure WriteResCmp (pValue:double);
    function  ReadPrjCmp:double;         procedure WritePrjCmp (pValue:double);
  public
    constructor Create(pPath:ShortString); overload;
    // Elementarne databazove operacie
    function Eof: boolean;
    function IsFirstRec: boolean;
    function IsLastRec: boolean;
    function Active: boolean;
    function ActPos: longint;
    function GotoPos (pActPos:longint): boolean;
    function LocateYearSerNum (pYear:Str2;pSerNum:word):boolean;
    function LocateDocNum (pDocNum:Str12):boolean;
    function LocatePrjName (pPrjName_:Str120):boolean;
    function NearestYearSerNum (pYear:Str2;pSerNum:word):boolean;
    function NearestDocNum (pDocNum:Str12):boolean;
    function NearestPrjName (pPrjName_:Str120):boolean;

    procedure SetIndex (pIndexName:ShortString);
    procedure Open (pBookNum:Str5);
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
    property Year:Str2 read ReadYear write WriteYear;
    property DocNum:Str12 read ReadDocNum write WriteDocNum;
    property SerNum:word read ReadSerNum write WriteSerNum;
    property PrjName:Str120 read ReadPrjName write WritePrjName;
    property PrjName_:Str120 read ReadPrjName_ write WritePrjName_;
    property DocDate:TDatetime read ReadDocDate write WriteDocDate;
    property BegDate:TDatetime read ReadBegDate write WriteBegDate;
    property EndDate:TDatetime read ReadEndDate write WriteEndDate;
    property RspNum:word read ReadRspNum write WriteRspNum;
    property RspUser:Str8 read ReadRspUser write WriteRspUser;
    property RspName:Str30 read ReadRspName write WriteRspName;
    property WrkDay:byte read ReadWrkDay write WriteWrkDay;
    property WrkWek:byte read ReadWrkWek write WriteWrkWek;
    property UniQnt:word read ReadUniQnt write WriteUniQnt;
    property DurDay:word read ReadDurDay write WriteDurDay;
    property DurHor:byte read ReadDurHor write WriteDurHor;
    property DurMin:byte read ReadDurMin write WriteDurMin;
    property SpcPrc:double read ReadSpcPrc write WriteSpcPrc;
    property DocPrc:double read ReadDocPrc write WriteDocPrc;
    property PrgPrc:double read ReadPrgPrc write WritePrgPrc;
    property TesPrc:double read ReadTesPrc write WriteTesPrc;
    property DebPrc:double read ReadDebPrc write WriteDebPrc;
    property AcpPrc:double read ReadAcpPrc write WriteAcpPrc;
    property AdmPrc:double read ReadAdmPrc write WriteAdmPrc;
    property ResPrc:double read ReadResPrc write WriteResPrc;
    property SpcPce:double read ReadSpcPce write WriteSpcPce;
    property DocPce:double read ReadDocPce write WriteDocPce;
    property PrgPce:double read ReadPrgPce write WritePrgPce;
    property TesPce:double read ReadTesPce write WriteTesPce;
    property DebPce:double read ReadDebPce write WriteDebPce;
    property AcpPce:double read ReadAcpPce write WriteAcpPce;
    property AdmPce:double read ReadAdmPce write WriteAdmPce;
    property ResPce:double read ReadResPce write WriteResPce;
    property SumDur:double read ReadSumDur write WriteSumDur;
    property SpcDur:double read ReadSpcDur write WriteSpcDur;
    property DocDur:double read ReadDocDur write WriteDocDur;
    property PrgDur:double read ReadPrgDur write WritePrgDur;
    property TesDur:double read ReadTesDur write WriteTesDur;
    property DebDur:double read ReadDebDur write WriteDebDur;
    property AcpDur:double read ReadAcpDur write WriteAcpDur;
    property AdmDur:double read ReadAdmDur write WriteAdmDur;
    property ResDur:double read ReadResDur write WriteResDur;
    property SumVal:double read ReadSumVal write WriteSumVal;
    property SpcVal:double read ReadSpcVal write WriteSpcVal;
    property DocVal:double read ReadDocVal write WriteDocVal;
    property PrgVal:double read ReadPrgVal write WritePrgVal;
    property TesVal:double read ReadTesVal write WriteTesVal;
    property DebVal:double read ReadDebVal write WriteDebVal;
    property AcpVal:double read ReadAcpVal write WriteAcpVal;
    property AdmVal:double read ReadAdmVal write WriteAdmVal;
    property ResVal:double read ReadResVal write WriteResVal;
    property PrfPrc:double read ReadPrfPrc write WritePrfPrc;
    property Prfval:double read ReadPrfval write WritePrfval;
    property AValue:double read ReadAValue write WriteAValue;
    property ItmQnt:word read ReadItmQnt write WriteItmQnt;
    property CrtUser:Str8 read ReadCrtUser write WriteCrtUser;
    property CrtDate:TDatetime read ReadCrtDate write WriteCrtDate;
    property CrtTime:TDatetime read ReadCrtTime write WriteCrtTime;
    property ModUser:Str8 read ReadModUser write WriteModUser;
    property ModDate:TDatetime read ReadModDate write WriteModDate;
    property ModTime:TDatetime read ReadModTime write WriteModTime;
    property CmpPrc:double read ReadCmpPrc write WriteCmpPrc;
    property SpcCmp:double read ReadSpcCmp write WriteSpcCmp;
    property DocCmp:double read ReadDocCmp write WriteDocCmp;
    property PrgCmp:double read ReadPrgCmp write WritePrgCmp;
    property PrgQnt:word read ReadPrgQnt write WritePrgQnt;
    property TesCmp:double read ReadTesCmp write WriteTesCmp;
    property DebCmp:double read ReadDebCmp write WriteDebCmp;
    property AcpCmp:double read ReadAcpCmp write WriteAcpCmp;
    property AdmCmp:double read ReadAdmCmp write WriteAdmCmp;
    property ResCmp:double read ReadResCmp write WriteResCmp;
    property PrjCmp:double read ReadPrjCmp write WritePrjCmp;
  end;

implementation

constructor TPrhBtr.Create;
begin
  oBtrTable := BtrInit ('PRH',gPath.DlsPath,Self);
end;

constructor TPrhBtr.Create(pPath:ShortString);
begin
  oBtrTable := BtrInit ('PRH',pPath,Self);
end;

destructor TPrhBtr.Destroy;
begin
  oBtrTable.Close;  FreeAndNil (oBtrTable);
end;

// *************************************** PRIVATE ********************************************

function TPrhBtr.ReadCount:integer;
begin
  Result := oBtrTable.RecordCount;
end;

function TPrhBtr.FieldExist (pFieldName:ShortString): boolean;
begin
  Result := oBtrTable.FindField(pFieldName)<>nil;
end;

function TPrhBtr.ReadYear:Str2;
begin
  Result := oBtrTable.FieldByName('Year').AsString;
end;

procedure TPrhBtr.WriteYear(pValue:Str2);
begin
  oBtrTable.FieldByName('Year').AsString := pValue;
end;

function TPrhBtr.ReadDocNum:Str12;
begin
  Result := oBtrTable.FieldByName('DocNum').AsString;
end;

procedure TPrhBtr.WriteDocNum(pValue:Str12);
begin
  oBtrTable.FieldByName('DocNum').AsString := pValue;
end;

function TPrhBtr.ReadSerNum:word;
begin
  Result := oBtrTable.FieldByName('SerNum').AsInteger;
end;

procedure TPrhBtr.WriteSerNum(pValue:word);
begin
  oBtrTable.FieldByName('SerNum').AsInteger := pValue;
end;

function TPrhBtr.ReadPrjName:Str120;
begin
  Result := oBtrTable.FieldByName('PrjName').AsString;
end;

procedure TPrhBtr.WritePrjName(pValue:Str120);
begin
  oBtrTable.FieldByName('PrjName').AsString := pValue;
end;

function TPrhBtr.ReadPrjName_:Str120;
begin
  Result := oBtrTable.FieldByName('PrjName_').AsString;
end;

procedure TPrhBtr.WritePrjName_(pValue:Str120);
begin
  oBtrTable.FieldByName('PrjName_').AsString := pValue;
end;

function TPrhBtr.ReadDocDate:TDatetime;
begin
  Result := oBtrTable.FieldByName('DocDate').AsDateTime;
end;

procedure TPrhBtr.WriteDocDate(pValue:TDatetime);
begin
  oBtrTable.FieldByName('DocDate').AsDateTime := pValue;
end;

function TPrhBtr.ReadBegDate:TDatetime;
begin
  Result := oBtrTable.FieldByName('BegDate').AsDateTime;
end;

procedure TPrhBtr.WriteBegDate(pValue:TDatetime);
begin
  oBtrTable.FieldByName('BegDate').AsDateTime := pValue;
end;

function TPrhBtr.ReadEndDate:TDatetime;
begin
  Result := oBtrTable.FieldByName('EndDate').AsDateTime;
end;

procedure TPrhBtr.WriteEndDate(pValue:TDatetime);
begin
  oBtrTable.FieldByName('EndDate').AsDateTime := pValue;
end;

function TPrhBtr.ReadRspNum:word;
begin
  Result := oBtrTable.FieldByName('RspNum').AsInteger;
end;

procedure TPrhBtr.WriteRspNum(pValue:word);
begin
  oBtrTable.FieldByName('RspNum').AsInteger := pValue;
end;

function TPrhBtr.ReadRspUser:Str8;
begin
  Result := oBtrTable.FieldByName('RspUser').AsString;
end;

procedure TPrhBtr.WriteRspUser(pValue:Str8);
begin
  oBtrTable.FieldByName('RspUser').AsString := pValue;
end;

function TPrhBtr.ReadRspName:Str30;
begin
  Result := oBtrTable.FieldByName('RspName').AsString;
end;

procedure TPrhBtr.WriteRspName(pValue:Str30);
begin
  oBtrTable.FieldByName('RspName').AsString := pValue;
end;

function TPrhBtr.ReadWrkDay:byte;
begin
  Result := oBtrTable.FieldByName('WrkDay').AsInteger;
end;

procedure TPrhBtr.WriteWrkDay(pValue:byte);
begin
  oBtrTable.FieldByName('WrkDay').AsInteger := pValue;
end;

function TPrhBtr.ReadWrkWek:byte;
begin
  Result := oBtrTable.FieldByName('WrkWek').AsInteger;
end;

procedure TPrhBtr.WriteWrkWek(pValue:byte);
begin
  oBtrTable.FieldByName('WrkWek').AsInteger := pValue;
end;

function TPrhBtr.ReadUniQnt:word;
begin
  Result := oBtrTable.FieldByName('UniQnt').AsInteger;
end;

procedure TPrhBtr.WriteUniQnt(pValue:word);
begin
  oBtrTable.FieldByName('UniQnt').AsInteger := pValue;
end;

function TPrhBtr.ReadDurDay:word;
begin
  Result := oBtrTable.FieldByName('DurDay').AsInteger;
end;

procedure TPrhBtr.WriteDurDay(pValue:word);
begin
  oBtrTable.FieldByName('DurDay').AsInteger := pValue;
end;

function TPrhBtr.ReadDurHor:byte;
begin
  Result := oBtrTable.FieldByName('DurHor').AsInteger;
end;

procedure TPrhBtr.WriteDurHor(pValue:byte);
begin
  oBtrTable.FieldByName('DurHor').AsInteger := pValue;
end;

function TPrhBtr.ReadDurMin:byte;
begin
  Result := oBtrTable.FieldByName('DurMin').AsInteger;
end;

procedure TPrhBtr.WriteDurMin(pValue:byte);
begin
  oBtrTable.FieldByName('DurMin').AsInteger := pValue;
end;

function TPrhBtr.ReadSpcPrc:double;
begin
  Result := oBtrTable.FieldByName('SpcPrc').AsFloat;
end;

procedure TPrhBtr.WriteSpcPrc(pValue:double);
begin
  oBtrTable.FieldByName('SpcPrc').AsFloat := pValue;
end;

function TPrhBtr.ReadDocPrc:double;
begin
  Result := oBtrTable.FieldByName('DocPrc').AsFloat;
end;

procedure TPrhBtr.WriteDocPrc(pValue:double);
begin
  oBtrTable.FieldByName('DocPrc').AsFloat := pValue;
end;

function TPrhBtr.ReadPrgPrc:double;
begin
  Result := oBtrTable.FieldByName('PrgPrc').AsFloat;
end;

procedure TPrhBtr.WritePrgPrc(pValue:double);
begin
  oBtrTable.FieldByName('PrgPrc').AsFloat := pValue;
end;

function TPrhBtr.ReadTesPrc:double;
begin
  Result := oBtrTable.FieldByName('TesPrc').AsFloat;
end;

procedure TPrhBtr.WriteTesPrc(pValue:double);
begin
  oBtrTable.FieldByName('TesPrc').AsFloat := pValue;
end;

function TPrhBtr.ReadDebPrc:double;
begin
  Result := oBtrTable.FieldByName('DebPrc').AsFloat;
end;

procedure TPrhBtr.WriteDebPrc(pValue:double);
begin
  oBtrTable.FieldByName('DebPrc').AsFloat := pValue;
end;

function TPrhBtr.ReadAcpPrc:double;
begin
  Result := oBtrTable.FieldByName('AcpPrc').AsFloat;
end;

procedure TPrhBtr.WriteAcpPrc(pValue:double);
begin
  oBtrTable.FieldByName('AcpPrc').AsFloat := pValue;
end;

function TPrhBtr.ReadAdmPrc:double;
begin
  Result := oBtrTable.FieldByName('AdmPrc').AsFloat;
end;

procedure TPrhBtr.WriteAdmPrc(pValue:double);
begin
  oBtrTable.FieldByName('AdmPrc').AsFloat := pValue;
end;

function TPrhBtr.ReadResPrc:double;
begin
  Result := oBtrTable.FieldByName('ResPrc').AsFloat;
end;

procedure TPrhBtr.WriteResPrc(pValue:double);
begin
  oBtrTable.FieldByName('ResPrc').AsFloat := pValue;
end;

function TPrhBtr.ReadSpcPce:double;
begin
  Result := oBtrTable.FieldByName('SpcPce').AsFloat;
end;

procedure TPrhBtr.WriteSpcPce(pValue:double);
begin
  oBtrTable.FieldByName('SpcPce').AsFloat := pValue;
end;

function TPrhBtr.ReadDocPce:double;
begin
  Result := oBtrTable.FieldByName('DocPce').AsFloat;
end;

procedure TPrhBtr.WriteDocPce(pValue:double);
begin
  oBtrTable.FieldByName('DocPce').AsFloat := pValue;
end;

function TPrhBtr.ReadPrgPce:double;
begin
  Result := oBtrTable.FieldByName('PrgPce').AsFloat;
end;

procedure TPrhBtr.WritePrgPce(pValue:double);
begin
  oBtrTable.FieldByName('PrgPce').AsFloat := pValue;
end;

function TPrhBtr.ReadTesPce:double;
begin
  Result := oBtrTable.FieldByName('TesPce').AsFloat;
end;

procedure TPrhBtr.WriteTesPce(pValue:double);
begin
  oBtrTable.FieldByName('TesPce').AsFloat := pValue;
end;

function TPrhBtr.ReadDebPce:double;
begin
  Result := oBtrTable.FieldByName('DebPce').AsFloat;
end;

procedure TPrhBtr.WriteDebPce(pValue:double);
begin
  oBtrTable.FieldByName('DebPce').AsFloat := pValue;
end;

function TPrhBtr.ReadAcpPce:double;
begin
  Result := oBtrTable.FieldByName('AcpPce').AsFloat;
end;

procedure TPrhBtr.WriteAcpPce(pValue:double);
begin
  oBtrTable.FieldByName('AcpPce').AsFloat := pValue;
end;

function TPrhBtr.ReadAdmPce:double;
begin
  Result := oBtrTable.FieldByName('AdmPce').AsFloat;
end;

procedure TPrhBtr.WriteAdmPce(pValue:double);
begin
  oBtrTable.FieldByName('AdmPce').AsFloat := pValue;
end;

function TPrhBtr.ReadResPce:double;
begin
  Result := oBtrTable.FieldByName('ResPce').AsFloat;
end;

procedure TPrhBtr.WriteResPce(pValue:double);
begin
  oBtrTable.FieldByName('ResPce').AsFloat := pValue;
end;

function TPrhBtr.ReadSumDur:double;
begin
  Result := oBtrTable.FieldByName('SumDur').AsFloat;
end;

procedure TPrhBtr.WriteSumDur(pValue:double);
begin
  oBtrTable.FieldByName('SumDur').AsFloat := pValue;
end;

function TPrhBtr.ReadSpcDur:double;
begin
  Result := oBtrTable.FieldByName('SpcDur').AsFloat;
end;

procedure TPrhBtr.WriteSpcDur(pValue:double);
begin
  oBtrTable.FieldByName('SpcDur').AsFloat := pValue;
end;

function TPrhBtr.ReadDocDur:double;
begin
  Result := oBtrTable.FieldByName('DocDur').AsFloat;
end;

procedure TPrhBtr.WriteDocDur(pValue:double);
begin
  oBtrTable.FieldByName('DocDur').AsFloat := pValue;
end;

function TPrhBtr.ReadPrgDur:double;
begin
  Result := oBtrTable.FieldByName('PrgDur').AsFloat;
end;

procedure TPrhBtr.WritePrgDur(pValue:double);
begin
  oBtrTable.FieldByName('PrgDur').AsFloat := pValue;
end;

function TPrhBtr.ReadTesDur:double;
begin
  Result := oBtrTable.FieldByName('TesDur').AsFloat;
end;

procedure TPrhBtr.WriteTesDur(pValue:double);
begin
  oBtrTable.FieldByName('TesDur').AsFloat := pValue;
end;

function TPrhBtr.ReadDebDur:double;
begin
  Result := oBtrTable.FieldByName('DebDur').AsFloat;
end;

procedure TPrhBtr.WriteDebDur(pValue:double);
begin
  oBtrTable.FieldByName('DebDur').AsFloat := pValue;
end;

function TPrhBtr.ReadAcpDur:double;
begin
  Result := oBtrTable.FieldByName('AcpDur').AsFloat;
end;

procedure TPrhBtr.WriteAcpDur(pValue:double);
begin
  oBtrTable.FieldByName('AcpDur').AsFloat := pValue;
end;

function TPrhBtr.ReadAdmDur:double;
begin
  Result := oBtrTable.FieldByName('AdmDur').AsFloat;
end;

procedure TPrhBtr.WriteAdmDur(pValue:double);
begin
  oBtrTable.FieldByName('AdmDur').AsFloat := pValue;
end;

function TPrhBtr.ReadResDur:double;
begin
  Result := oBtrTable.FieldByName('ResDur').AsFloat;
end;

procedure TPrhBtr.WriteResDur(pValue:double);
begin
  oBtrTable.FieldByName('ResDur').AsFloat := pValue;
end;

function TPrhBtr.ReadSumVal:double;
begin
  Result := oBtrTable.FieldByName('SumVal').AsFloat;
end;

procedure TPrhBtr.WriteSumVal(pValue:double);
begin
  oBtrTable.FieldByName('SumVal').AsFloat := pValue;
end;

function TPrhBtr.ReadSpcVal:double;
begin
  Result := oBtrTable.FieldByName('SpcVal').AsFloat;
end;

procedure TPrhBtr.WriteSpcVal(pValue:double);
begin
  oBtrTable.FieldByName('SpcVal').AsFloat := pValue;
end;

function TPrhBtr.ReadDocVal:double;
begin
  Result := oBtrTable.FieldByName('DocVal').AsFloat;
end;

procedure TPrhBtr.WriteDocVal(pValue:double);
begin
  oBtrTable.FieldByName('DocVal').AsFloat := pValue;
end;

function TPrhBtr.ReadPrgVal:double;
begin
  Result := oBtrTable.FieldByName('PrgVal').AsFloat;
end;

procedure TPrhBtr.WritePrgVal(pValue:double);
begin
  oBtrTable.FieldByName('PrgVal').AsFloat := pValue;
end;

function TPrhBtr.ReadTesVal:double;
begin
  Result := oBtrTable.FieldByName('TesVal').AsFloat;
end;

procedure TPrhBtr.WriteTesVal(pValue:double);
begin
  oBtrTable.FieldByName('TesVal').AsFloat := pValue;
end;

function TPrhBtr.ReadDebVal:double;
begin
  Result := oBtrTable.FieldByName('DebVal').AsFloat;
end;

procedure TPrhBtr.WriteDebVal(pValue:double);
begin
  oBtrTable.FieldByName('DebVal').AsFloat := pValue;
end;

function TPrhBtr.ReadAcpVal:double;
begin
  Result := oBtrTable.FieldByName('AcpVal').AsFloat;
end;

procedure TPrhBtr.WriteAcpVal(pValue:double);
begin
  oBtrTable.FieldByName('AcpVal').AsFloat := pValue;
end;

function TPrhBtr.ReadAdmVal:double;
begin
  Result := oBtrTable.FieldByName('AdmVal').AsFloat;
end;

procedure TPrhBtr.WriteAdmVal(pValue:double);
begin
  oBtrTable.FieldByName('AdmVal').AsFloat := pValue;
end;

function TPrhBtr.ReadResVal:double;
begin
  Result := oBtrTable.FieldByName('ResVal').AsFloat;
end;

procedure TPrhBtr.WriteResVal(pValue:double);
begin
  oBtrTable.FieldByName('ResVal').AsFloat := pValue;
end;

function TPrhBtr.ReadPrfPrc:double;
begin
  Result := oBtrTable.FieldByName('PrfPrc').AsFloat;
end;

procedure TPrhBtr.WritePrfPrc(pValue:double);
begin
  oBtrTable.FieldByName('PrfPrc').AsFloat := pValue;
end;

function TPrhBtr.ReadPrfval:double;
begin
  Result := oBtrTable.FieldByName('Prfval').AsFloat;
end;

procedure TPrhBtr.WritePrfval(pValue:double);
begin
  oBtrTable.FieldByName('Prfval').AsFloat := pValue;
end;

function TPrhBtr.ReadAValue:double;
begin
  Result := oBtrTable.FieldByName('AValue').AsFloat;
end;

procedure TPrhBtr.WriteAValue(pValue:double);
begin
  oBtrTable.FieldByName('AValue').AsFloat := pValue;
end;

function TPrhBtr.ReadItmQnt:word;
begin
  Result := oBtrTable.FieldByName('ItmQnt').AsInteger;
end;

procedure TPrhBtr.WriteItmQnt(pValue:word);
begin
  oBtrTable.FieldByName('ItmQnt').AsInteger := pValue;
end;

function TPrhBtr.ReadCrtUser:Str8;
begin
  Result := oBtrTable.FieldByName('CrtUser').AsString;
end;

procedure TPrhBtr.WriteCrtUser(pValue:Str8);
begin
  oBtrTable.FieldByName('CrtUser').AsString := pValue;
end;

function TPrhBtr.ReadCrtDate:TDatetime;
begin
  Result := oBtrTable.FieldByName('CrtDate').AsDateTime;
end;

procedure TPrhBtr.WriteCrtDate(pValue:TDatetime);
begin
  oBtrTable.FieldByName('CrtDate').AsDateTime := pValue;
end;

function TPrhBtr.ReadCrtTime:TDatetime;
begin
  Result := oBtrTable.FieldByName('CrtTime').AsDateTime;
end;

procedure TPrhBtr.WriteCrtTime(pValue:TDatetime);
begin
  oBtrTable.FieldByName('CrtTime').AsDateTime := pValue;
end;

function TPrhBtr.ReadModUser:Str8;
begin
  Result := oBtrTable.FieldByName('ModUser').AsString;
end;

procedure TPrhBtr.WriteModUser(pValue:Str8);
begin
  oBtrTable.FieldByName('ModUser').AsString := pValue;
end;

function TPrhBtr.ReadModDate:TDatetime;
begin
  Result := oBtrTable.FieldByName('ModDate').AsDateTime;
end;

procedure TPrhBtr.WriteModDate(pValue:TDatetime);
begin
  oBtrTable.FieldByName('ModDate').AsDateTime := pValue;
end;

function TPrhBtr.ReadModTime:TDatetime;
begin
  Result := oBtrTable.FieldByName('ModTime').AsDateTime;
end;

procedure TPrhBtr.WriteModTime(pValue:TDatetime);
begin
  oBtrTable.FieldByName('ModTime').AsDateTime := pValue;
end;

function TPrhBtr.ReadCmpPrc:double;
begin
  Result := oBtrTable.FieldByName('CmpPrc').AsFloat;
end;

procedure TPrhBtr.WriteCmpPrc(pValue:double);
begin
  oBtrTable.FieldByName('CmpPrc').AsFloat := pValue;
end;

function TPrhBtr.ReadSpcCmp:double;
begin
  Result := oBtrTable.FieldByName('SpcCmp').AsFloat;
end;

procedure TPrhBtr.WriteSpcCmp(pValue:double);
begin
  oBtrTable.FieldByName('SpcCmp').AsFloat := pValue;
end;

function TPrhBtr.ReadDocCmp:double;
begin
  Result := oBtrTable.FieldByName('DocCmp').AsFloat;
end;

procedure TPrhBtr.WriteDocCmp(pValue:double);
begin
  oBtrTable.FieldByName('DocCmp').AsFloat := pValue;
end;

function TPrhBtr.ReadPrgCmp:double;
begin
  Result := oBtrTable.FieldByName('PrgCmp').AsFloat;
end;

procedure TPrhBtr.WritePrgCmp(pValue:double);
begin
  oBtrTable.FieldByName('PrgCmp').AsFloat := pValue;
end;

function TPrhBtr.ReadPrgQnt:word;
begin
  Result := oBtrTable.FieldByName('PrgQnt').AsInteger;
end;

procedure TPrhBtr.WritePrgQnt(pValue:word);
begin
  oBtrTable.FieldByName('PrgQnt').AsInteger := pValue;
end;

function TPrhBtr.ReadTesCmp:double;
begin
  Result := oBtrTable.FieldByName('TesCmp').AsFloat;
end;

procedure TPrhBtr.WriteTesCmp(pValue:double);
begin
  oBtrTable.FieldByName('TesCmp').AsFloat := pValue;
end;

function TPrhBtr.ReadDebCmp:double;
begin
  Result := oBtrTable.FieldByName('DebCmp').AsFloat;
end;

procedure TPrhBtr.WriteDebCmp(pValue:double);
begin
  oBtrTable.FieldByName('DebCmp').AsFloat := pValue;
end;

function TPrhBtr.ReadAcpCmp:double;
begin
  Result := oBtrTable.FieldByName('AcpCmp').AsFloat;
end;

procedure TPrhBtr.WriteAcpCmp(pValue:double);
begin
  oBtrTable.FieldByName('AcpCmp').AsFloat := pValue;
end;

function TPrhBtr.ReadAdmCmp:double;
begin
  Result := oBtrTable.FieldByName('AdmCmp').AsFloat;
end;

procedure TPrhBtr.WriteAdmCmp(pValue:double);
begin
  oBtrTable.FieldByName('AdmCmp').AsFloat := pValue;
end;

function TPrhBtr.ReadResCmp:double;
begin
  Result := oBtrTable.FieldByName('ResCmp').AsFloat;
end;

procedure TPrhBtr.WriteResCmp(pValue:double);
begin
  oBtrTable.FieldByName('ResCmp').AsFloat := pValue;
end;

function TPrhBtr.ReadPrjCmp:double;
begin
  Result := oBtrTable.FieldByName('PrjCmp').AsFloat;
end;

procedure TPrhBtr.WritePrjCmp(pValue:double);
begin
  oBtrTable.FieldByName('PrjCmp').AsFloat := pValue;
end;

// **************************************** PUBLIC ********************************************

function TPrhBtr.Eof: boolean;
begin
  Result := oBtrTable.Eof;
end;

function TPrhBtr.IsFirstRec: boolean;
begin
  Result := oBtrTable.Bof;
end;

function TPrhBtr.IsLastRec: boolean;
begin
  Result := oBtrTable.Eof;
end;

function TPrhBtr.Active: boolean;
begin
  Result := oBtrTable.Active;
end;

function TPrhBtr.ActPos: longint;
begin
  Result := oBtrTable.ActPos;
end;

function TPrhBtr.GotoPos (pActPos:longint): boolean;
begin
  Result := oBtrTable.GotoPos(pActPos);
end;

function TPrhBtr.LocateYearSerNum (pYear:Str2;pSerNum:word):boolean;
begin
  SetIndex (ixYearSerNum);
  Result := oBtrTable.FindKey([pYear,pSerNum]);
end;

function TPrhBtr.LocateDocNum (pDocNum:Str12):boolean;
begin
  SetIndex (ixDocNum);
  Result := oBtrTable.FindKey([pDocNum]);
end;

function TPrhBtr.LocatePrjName (pPrjName_:Str120):boolean;
begin
  SetIndex (ixPrjName);
  Result := oBtrTable.FindKey([StrToAlias(pPrjName_)]);
end;

function TPrhBtr.NearestYearSerNum (pYear:Str2;pSerNum:word):boolean;
begin
  SetIndex (ixYearSerNum);
  Result := oBtrTable.FindNearest([pYear,pSerNum]);
end;

function TPrhBtr.NearestDocNum (pDocNum:Str12):boolean;
begin
  SetIndex (ixDocNum);
  Result := oBtrTable.FindNearest([pDocNum]);
end;

function TPrhBtr.NearestPrjName (pPrjName_:Str120):boolean;
begin
  SetIndex (ixPrjName);
  Result := oBtrTable.FindNearest([pPrjName_]);
end;

procedure TPrhBtr.SetIndex (pIndexName:ShortString);
begin
  If oBtrTable.IndexName<>pIndexName then oBtrTable.IndexName := pIndexName;
end;

procedure TPrhBtr.Open(pBookNum:Str5);
begin
  oBookNum := pBookNum;
  oBtrTable.Open(pBookNum);
end;

procedure TPrhBtr.Close;
begin
  If oBtrTable.Active then oBtrTable.Close;
end;

procedure TPrhBtr.Prior;
begin
  oBtrTable.Prior;
end;

procedure TPrhBtr.Next;
begin
  oBtrTable.Next;
end;

procedure TPrhBtr.First;
begin
  oBtrTable.First;
end;

procedure TPrhBtr.Last;
begin
  oBtrTable.Last;
end;

procedure TPrhBtr.Insert;
begin
  oBtrTable.Insert;
end;

procedure TPrhBtr.Edit;
begin
  oBtrTable.Edit;
end;

procedure TPrhBtr.Post;
begin
  oBtrTable.Post;
end;

procedure TPrhBtr.Delete;
begin
  oBtrTable.Delete;
end;

procedure TPrhBtr.SwapIndex;
begin
  oBtrTable.SwapIndex;
end;

procedure TPrhBtr.RestoreIndex;
begin
  oBtrTable.RestoreIndex;
end;

procedure TPrhBtr.SwapStatus;
begin
  oBtrTable.SwapStatus;
end;

procedure TPrhBtr.RestoreStatus;
begin
  oBtrTable.RestoreStatus;
end;

procedure TPrhBtr.EnableControls;
begin
  oBtrTable.EnableControls;
end;

procedure TPrhBtr.DisableControls;
begin
  oBtrTable.DisableControls;
end;

end.
{MOD 1901012}
