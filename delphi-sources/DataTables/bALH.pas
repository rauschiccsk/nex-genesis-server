unit bALH;

interface

uses
  IcTypes, IcConv, NexPath, NexGlob,
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls,
  Dialogs, DB, NexBtrTable, DBTables, NexPxTable;

const
  ixYearSerNum = 'YearSerNum';
  ixDocNum = 'DocNum';
  ixDoDate = 'DoDate';
  ixPaCode = 'PaCode';
  ixPaName = 'PaName';
  ixStatus = 'Status';

type
  TAlhBtr = class (TComponent)
    constructor Create; overload;
    destructor  Destroy; override;
  private
    oBookNum: Str5;
    oBtrTable: TNexBtrTable;
    function ReadCount:integer;
    function FieldExist (pFieldName:ShortString): boolean;
    // Pristup k databazovym poliam
    function  ReadSerNum:longint;        procedure WriteSerNum (pValue:longint);
    function  ReadDocNum:Str12;          procedure WriteDocNum (pValue:Str12);
    function  ReadExtNum:Str12;          procedure WriteExtNum (pValue:Str12);
    function  ReadDocDate:TDatetime;     procedure WriteDocDate (pValue:TDatetime);
    function  ReadEndDate:TDatetime;     procedure WriteEndDate (pValue:TDatetime);
    function  ReadRetDate:TDatetime;     procedure WriteRetDate (pValue:TDatetime);
    function  ReadPaCode:longint;        procedure WritePaCode (pValue:longint);
    function  ReadPaName:Str30;          procedure WritePaName (pValue:Str30);
    function  ReadPaName_:Str30;         procedure WritePaName_ (pValue:Str30);
    function  ReadRegName:Str60;         procedure WriteRegName (pValue:Str60);
    function  ReadRegAddr:Str30;         procedure WriteRegAddr (pValue:Str30);
    function  ReadRegZip:Str15;          procedure WriteRegZip (pValue:Str15);
    function  ReadRegCty:Str3;           procedure WriteRegCty (pValue:Str3);
    function  ReadRegCtn:Str30;          procedure WriteRegCtn (pValue:Str30);
    function  ReadRegSta:Str2;           procedure WriteRegSta (pValue:Str2);
    function  ReadRegIno:Str15;          procedure WriteRegIno (pValue:Str15);
    function  ReadRegTin:Str15;          procedure WriteRegTin (pValue:Str15);
    function  ReadRegVin:Str15;          procedure WriteRegVin (pValue:Str15);
    function  ReadBaCont:Str30;          procedure WriteBaCont (pValue:Str30);
    function  ReadBaName:Str30;          procedure WriteBaName (pValue:Str30);
    function  ReadDscPrc:double;         procedure WriteDscPrc (pValue:double);
    function  ReadSurPrc:double;         procedure WriteSurPrc (pValue:double);
    function  ReadPenPrc:double;         procedure WritePenPrc (pValue:double);
    function  ReadRdiPrc:double;         procedure WriteRdiPrc (pValue:double);
    function  ReadRduPrc:double;         procedure WriteRduPrc (pValue:double);
    function  ReadSurVal:double;         procedure WriteSurVal (pValue:double);
    function  ReadChPenVal:double;       procedure WriteChPenVal (pValue:double);
    function  ReadChRdiVal:double;       procedure WriteChRdiVal (pValue:double);
    function  ReadChRduVal:double;       procedure WriteChRduVal (pValue:double);
    function  ReadAgAValue:double;       procedure WriteAgAValue (pValue:double);
    function  ReadAgBvalue:double;       procedure WriteAgBvalue (pValue:double);
    function  ReadAsAValue:double;       procedure WriteAsAValue (pValue:double);
    function  ReadAsBvalue:double;       procedure WriteAsBvalue (pValue:double);
    function  ReadCsiDoc:Str12;          procedure WriteCsiDoc (pValue:Str12);
    function  ReadCseDoc:Str12;          procedure WriteCseDoc (pValue:Str12);
    function  ReadIcdNum:Str12;          procedure WriteIcdNum (pValue:Str12);
    function  ReadItmQnt:word;           procedure WriteItmQnt (pValue:word);
    function  ReadPrnCnt:byte;           procedure WritePrnCnt (pValue:byte);
    function  ReadDstLck:byte;           procedure WriteDstLck (pValue:byte);
    function  ReadStatus:Str1;           procedure WriteStatus (pValue:Str1);
    function  ReadCrtUser:Str8;          procedure WriteCrtUser (pValue:Str8);
    function  ReadCrtDate:TDatetime;     procedure WriteCrtDate (pValue:TDatetime);
    function  ReadCrtTime:TDatetime;     procedure WriteCrtTime (pValue:TDatetime);
    function  ReadModUser:Str8;          procedure WriteModUser (pValue:Str8);
    function  ReadModDate:TDatetime;     procedure WriteModDate (pValue:TDatetime);
    function  ReadModTime:TDatetime;     procedure WriteModTime (pValue:TDatetime);
    function  ReadIcdDate:TDatetime;     procedure WriteIcdDate (pValue:TDatetime);
    function  ReadAmdNum:Str12;          procedure WriteAmdNum (pValue:Str12);
    function  ReadAodNum:Str12;          procedure WriteAodNum (pValue:Str12);
    function  ReadAsDValue:double;       procedure WriteAsDValue (pValue:double);
    function  ReadAsHValue:double;       procedure WriteAsHValue (pValue:double);
    function  ReadAsDdsVal:double;       procedure WriteAsDdsVal (pValue:double);
    function  ReadAsHdsVal:double;       procedure WriteAsHdsVal (pValue:double);
    function  ReadInSurVal:double;       procedure WriteInSurVal (pValue:double);
    function  ReadReSurVal:double;       procedure WriteReSurVal (pValue:double);
    function  ReadYear:Str2;             procedure WriteYear (pValue:Str2);
  public
    constructor Create(pPath:ShortString); overload;
    // Elementarne databazove operacie
    function Eof: boolean;
    function IsFirstRec: boolean;
    function IsLastRec: boolean;
    function Active: boolean;
    function ActPos: longint;
    function GotoPos (pActPos:longint): boolean;
    function LocateYearSerNum (pYear:Str2;pSerNum:longint):boolean;
    function LocateDocNum (pDocNum:Str12):boolean;
    function LocateDoDate (pDocDate:TDatetime):boolean;
    function LocatePaCode (pPaCode:longint):boolean;
    function LocatePaName (pPaName_:Str30):boolean;
    function LocateStatus (pStatus:Str1):boolean;
    function NearestYearSerNum (pYear:Str2;pSerNum:longint):boolean;
    function NearestDocNum (pDocNum:Str12):boolean;
    function NearestDoDate (pDocDate:TDatetime):boolean;
    function NearestPaCode (pPaCode:longint):boolean;
    function NearestPaName (pPaName_:Str30):boolean;
    function NearestStatus (pStatus:Str1):boolean;

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
    property SerNum:longint read ReadSerNum write WriteSerNum;
    property DocNum:Str12 read ReadDocNum write WriteDocNum;
    property ExtNum:Str12 read ReadExtNum write WriteExtNum;
    property DocDate:TDatetime read ReadDocDate write WriteDocDate;
    property EndDate:TDatetime read ReadEndDate write WriteEndDate;
    property RetDate:TDatetime read ReadRetDate write WriteRetDate;
    property PaCode:longint read ReadPaCode write WritePaCode;
    property PaName:Str30 read ReadPaName write WritePaName;
    property PaName_:Str30 read ReadPaName_ write WritePaName_;
    property RegName:Str60 read ReadRegName write WriteRegName;
    property RegAddr:Str30 read ReadRegAddr write WriteRegAddr;
    property RegZip:Str15 read ReadRegZip write WriteRegZip;
    property RegCty:Str3 read ReadRegCty write WriteRegCty;
    property RegCtn:Str30 read ReadRegCtn write WriteRegCtn;
    property RegSta:Str2 read ReadRegSta write WriteRegSta;
    property RegIno:Str15 read ReadRegIno write WriteRegIno;
    property RegTin:Str15 read ReadRegTin write WriteRegTin;
    property RegVin:Str15 read ReadRegVin write WriteRegVin;
    property BaCont:Str30 read ReadBaCont write WriteBaCont;
    property BaName:Str30 read ReadBaName write WriteBaName;
    property DscPrc:double read ReadDscPrc write WriteDscPrc;
    property SurPrc:double read ReadSurPrc write WriteSurPrc;
    property PenPrc:double read ReadPenPrc write WritePenPrc;
    property RdiPrc:double read ReadRdiPrc write WriteRdiPrc;
    property RduPrc:double read ReadRduPrc write WriteRduPrc;
    property SurVal:double read ReadSurVal write WriteSurVal;
    property ChPenVal:double read ReadChPenVal write WriteChPenVal;
    property ChRdiVal:double read ReadChRdiVal write WriteChRdiVal;
    property ChRduVal:double read ReadChRduVal write WriteChRduVal;
    property AgAValue:double read ReadAgAValue write WriteAgAValue;
    property AgBvalue:double read ReadAgBvalue write WriteAgBvalue;
    property AsAValue:double read ReadAsAValue write WriteAsAValue;
    property AsBvalue:double read ReadAsBvalue write WriteAsBvalue;
    property CsiDoc:Str12 read ReadCsiDoc write WriteCsiDoc;
    property CseDoc:Str12 read ReadCseDoc write WriteCseDoc;
    property IcdNum:Str12 read ReadIcdNum write WriteIcdNum;
    property ItmQnt:word read ReadItmQnt write WriteItmQnt;
    property PrnCnt:byte read ReadPrnCnt write WritePrnCnt;
    property DstLck:byte read ReadDstLck write WriteDstLck;
    property Status:Str1 read ReadStatus write WriteStatus;
    property CrtUser:Str8 read ReadCrtUser write WriteCrtUser;
    property CrtDate:TDatetime read ReadCrtDate write WriteCrtDate;
    property CrtTime:TDatetime read ReadCrtTime write WriteCrtTime;
    property ModUser:Str8 read ReadModUser write WriteModUser;
    property ModDate:TDatetime read ReadModDate write WriteModDate;
    property ModTime:TDatetime read ReadModTime write WriteModTime;
    property IcdDate:TDatetime read ReadIcdDate write WriteIcdDate;
    property AmdNum:Str12 read ReadAmdNum write WriteAmdNum;
    property AodNum:Str12 read ReadAodNum write WriteAodNum;
    property AsDValue:double read ReadAsDValue write WriteAsDValue;
    property AsHValue:double read ReadAsHValue write WriteAsHValue;
    property AsDdsVal:double read ReadAsDdsVal write WriteAsDdsVal;
    property AsHdsVal:double read ReadAsHdsVal write WriteAsHdsVal;
    property InSurVal:double read ReadInSurVal write WriteInSurVal;
    property ReSurVal:double read ReadReSurVal write WriteReSurVal;
    property Year:Str2 read ReadYear write WriteYear;
  end;

implementation

constructor TAlhBtr.Create;
begin
  oBtrTable := BtrInit ('ALH',gPath.StkPath,Self);
end;

constructor TAlhBtr.Create(pPath:ShortString);
begin
  oBtrTable := BtrInit ('ALH',pPath,Self);
end;

destructor TAlhBtr.Destroy;
begin
  oBtrTable.Close;  FreeAndNil (oBtrTable);
end;

// *************************************** PRIVATE ********************************************

function TAlhBtr.ReadCount:integer;
begin
  Result := oBtrTable.RecordCount;
end;

function TAlhBtr.FieldExist (pFieldName:ShortString): boolean;
begin
  Result := oBtrTable.FindField(pFieldName)<>nil;
end;

function TAlhBtr.ReadSerNum:longint;
begin
  Result := oBtrTable.FieldByName('SerNum').AsInteger;
end;

procedure TAlhBtr.WriteSerNum(pValue:longint);
begin
  oBtrTable.FieldByName('SerNum').AsInteger := pValue;
end;

function TAlhBtr.ReadDocNum:Str12;
begin
  Result := oBtrTable.FieldByName('DocNum').AsString;
end;

procedure TAlhBtr.WriteDocNum(pValue:Str12);
begin
  oBtrTable.FieldByName('DocNum').AsString := pValue;
end;

function TAlhBtr.ReadExtNum:Str12;
begin
  Result := oBtrTable.FieldByName('ExtNum').AsString;
end;

procedure TAlhBtr.WriteExtNum(pValue:Str12);
begin
  oBtrTable.FieldByName('ExtNum').AsString := pValue;
end;

function TAlhBtr.ReadDocDate:TDatetime;
begin
  Result := oBtrTable.FieldByName('DocDate').AsDateTime;
end;

procedure TAlhBtr.WriteDocDate(pValue:TDatetime);
begin
  oBtrTable.FieldByName('DocDate').AsDateTime := pValue;
end;

function TAlhBtr.ReadEndDate:TDatetime;
begin
  Result := oBtrTable.FieldByName('EndDate').AsDateTime;
end;

procedure TAlhBtr.WriteEndDate(pValue:TDatetime);
begin
  oBtrTable.FieldByName('EndDate').AsDateTime := pValue;
end;

function TAlhBtr.ReadRetDate:TDatetime;
begin
  Result := oBtrTable.FieldByName('RetDate').AsDateTime;
end;

procedure TAlhBtr.WriteRetDate(pValue:TDatetime);
begin
  oBtrTable.FieldByName('RetDate').AsDateTime := pValue;
end;

function TAlhBtr.ReadPaCode:longint;
begin
  Result := oBtrTable.FieldByName('PaCode').AsInteger;
end;

procedure TAlhBtr.WritePaCode(pValue:longint);
begin
  oBtrTable.FieldByName('PaCode').AsInteger := pValue;
end;

function TAlhBtr.ReadPaName:Str30;
begin
  Result := oBtrTable.FieldByName('PaName').AsString;
end;

procedure TAlhBtr.WritePaName(pValue:Str30);
begin
  oBtrTable.FieldByName('PaName').AsString := pValue;
end;

function TAlhBtr.ReadPaName_:Str30;
begin
  Result := oBtrTable.FieldByName('PaName_').AsString;
end;

procedure TAlhBtr.WritePaName_(pValue:Str30);
begin
  oBtrTable.FieldByName('PaName_').AsString := pValue;
end;

function TAlhBtr.ReadRegName:Str60;
begin
  Result := oBtrTable.FieldByName('RegName').AsString;
end;

procedure TAlhBtr.WriteRegName(pValue:Str60);
begin
  oBtrTable.FieldByName('RegName').AsString := pValue;
end;

function TAlhBtr.ReadRegAddr:Str30;
begin
  Result := oBtrTable.FieldByName('RegAddr').AsString;
end;

procedure TAlhBtr.WriteRegAddr(pValue:Str30);
begin
  oBtrTable.FieldByName('RegAddr').AsString := pValue;
end;

function TAlhBtr.ReadRegZip:Str15;
begin
  Result := oBtrTable.FieldByName('RegZip').AsString;
end;

procedure TAlhBtr.WriteRegZip(pValue:Str15);
begin
  oBtrTable.FieldByName('RegZip').AsString := pValue;
end;

function TAlhBtr.ReadRegCty:Str3;
begin
  Result := oBtrTable.FieldByName('RegCty').AsString;
end;

procedure TAlhBtr.WriteRegCty(pValue:Str3);
begin
  oBtrTable.FieldByName('RegCty').AsString := pValue;
end;

function TAlhBtr.ReadRegCtn:Str30;
begin
  Result := oBtrTable.FieldByName('RegCtn').AsString;
end;

procedure TAlhBtr.WriteRegCtn(pValue:Str30);
begin
  oBtrTable.FieldByName('RegCtn').AsString := pValue;
end;

function TAlhBtr.ReadRegSta:Str2;
begin
  Result := oBtrTable.FieldByName('RegSta').AsString;
end;

procedure TAlhBtr.WriteRegSta(pValue:Str2);
begin
  oBtrTable.FieldByName('RegSta').AsString := pValue;
end;

function TAlhBtr.ReadRegIno:Str15;
begin
  Result := oBtrTable.FieldByName('RegIno').AsString;
end;

procedure TAlhBtr.WriteRegIno(pValue:Str15);
begin
  oBtrTable.FieldByName('RegIno').AsString := pValue;
end;

function TAlhBtr.ReadRegTin:Str15;
begin
  Result := oBtrTable.FieldByName('RegTin').AsString;
end;

procedure TAlhBtr.WriteRegTin(pValue:Str15);
begin
  oBtrTable.FieldByName('RegTin').AsString := pValue;
end;

function TAlhBtr.ReadRegVin:Str15;
begin
  Result := oBtrTable.FieldByName('RegVin').AsString;
end;

procedure TAlhBtr.WriteRegVin(pValue:Str15);
begin
  oBtrTable.FieldByName('RegVin').AsString := pValue;
end;

function TAlhBtr.ReadBaCont:Str30;
begin
  Result := oBtrTable.FieldByName('BaCont').AsString;
end;

procedure TAlhBtr.WriteBaCont(pValue:Str30);
begin
  oBtrTable.FieldByName('BaCont').AsString := pValue;
end;

function TAlhBtr.ReadBaName:Str30;
begin
  Result := oBtrTable.FieldByName('BaName').AsString;
end;

procedure TAlhBtr.WriteBaName(pValue:Str30);
begin
  oBtrTable.FieldByName('BaName').AsString := pValue;
end;

function TAlhBtr.ReadDscPrc:double;
begin
  Result := oBtrTable.FieldByName('DscPrc').AsFloat;
end;

procedure TAlhBtr.WriteDscPrc(pValue:double);
begin
  oBtrTable.FieldByName('DscPrc').AsFloat := pValue;
end;

function TAlhBtr.ReadSurPrc:double;
begin
  Result := oBtrTable.FieldByName('SurPrc').AsFloat;
end;

procedure TAlhBtr.WriteSurPrc(pValue:double);
begin
  oBtrTable.FieldByName('SurPrc').AsFloat := pValue;
end;

function TAlhBtr.ReadPenPrc:double;
begin
  Result := oBtrTable.FieldByName('PenPrc').AsFloat;
end;

procedure TAlhBtr.WritePenPrc(pValue:double);
begin
  oBtrTable.FieldByName('PenPrc').AsFloat := pValue;
end;

function TAlhBtr.ReadRdiPrc:double;
begin
  Result := oBtrTable.FieldByName('RdiPrc').AsFloat;
end;

procedure TAlhBtr.WriteRdiPrc(pValue:double);
begin
  oBtrTable.FieldByName('RdiPrc').AsFloat := pValue;
end;

function TAlhBtr.ReadRduPrc:double;
begin
  Result := oBtrTable.FieldByName('RduPrc').AsFloat;
end;

procedure TAlhBtr.WriteRduPrc(pValue:double);
begin
  oBtrTable.FieldByName('RduPrc').AsFloat := pValue;
end;

function TAlhBtr.ReadSurVal:double;
begin
  Result := oBtrTable.FieldByName('SurVal').AsFloat;
end;

procedure TAlhBtr.WriteSurVal(pValue:double);
begin
  oBtrTable.FieldByName('SurVal').AsFloat := pValue;
end;

function TAlhBtr.ReadChPenVal:double;
begin
  Result := oBtrTable.FieldByName('ChPenVal').AsFloat;
end;

procedure TAlhBtr.WriteChPenVal(pValue:double);
begin
  oBtrTable.FieldByName('ChPenVal').AsFloat := pValue;
end;

function TAlhBtr.ReadChRdiVal:double;
begin
  Result := oBtrTable.FieldByName('ChRdiVal').AsFloat;
end;

procedure TAlhBtr.WriteChRdiVal(pValue:double);
begin
  oBtrTable.FieldByName('ChRdiVal').AsFloat := pValue;
end;

function TAlhBtr.ReadChRduVal:double;
begin
  Result := oBtrTable.FieldByName('ChRduVal').AsFloat;
end;

procedure TAlhBtr.WriteChRduVal(pValue:double);
begin
  oBtrTable.FieldByName('ChRduVal').AsFloat := pValue;
end;

function TAlhBtr.ReadAgAValue:double;
begin
  Result := oBtrTable.FieldByName('AgAValue').AsFloat;
end;

procedure TAlhBtr.WriteAgAValue(pValue:double);
begin
  oBtrTable.FieldByName('AgAValue').AsFloat := pValue;
end;

function TAlhBtr.ReadAgBvalue:double;
begin
  Result := oBtrTable.FieldByName('AgBvalue').AsFloat;
end;

procedure TAlhBtr.WriteAgBvalue(pValue:double);
begin
  oBtrTable.FieldByName('AgBvalue').AsFloat := pValue;
end;

function TAlhBtr.ReadAsAValue:double;
begin
  Result := oBtrTable.FieldByName('AsAValue').AsFloat;
end;

procedure TAlhBtr.WriteAsAValue(pValue:double);
begin
  oBtrTable.FieldByName('AsAValue').AsFloat := pValue;
end;

function TAlhBtr.ReadAsBvalue:double;
begin
  Result := oBtrTable.FieldByName('AsBvalue').AsFloat;
end;

procedure TAlhBtr.WriteAsBvalue(pValue:double);
begin
  oBtrTable.FieldByName('AsBvalue').AsFloat := pValue;
end;

function TAlhBtr.ReadCsiDoc:Str12;
begin
  Result := oBtrTable.FieldByName('CsiDoc').AsString;
end;

procedure TAlhBtr.WriteCsiDoc(pValue:Str12);
begin
  oBtrTable.FieldByName('CsiDoc').AsString := pValue;
end;

function TAlhBtr.ReadCseDoc:Str12;
begin
  Result := oBtrTable.FieldByName('CseDoc').AsString;
end;

procedure TAlhBtr.WriteCseDoc(pValue:Str12);
begin
  oBtrTable.FieldByName('CseDoc').AsString := pValue;
end;

function TAlhBtr.ReadIcdNum:Str12;
begin
  Result := oBtrTable.FieldByName('IcdNum').AsString;
end;

procedure TAlhBtr.WriteIcdNum(pValue:Str12);
begin
  oBtrTable.FieldByName('IcdNum').AsString := pValue;
end;

function TAlhBtr.ReadItmQnt:word;
begin
  Result := oBtrTable.FieldByName('ItmQnt').AsInteger;
end;

procedure TAlhBtr.WriteItmQnt(pValue:word);
begin
  oBtrTable.FieldByName('ItmQnt').AsInteger := pValue;
end;

function TAlhBtr.ReadPrnCnt:byte;
begin
  Result := oBtrTable.FieldByName('PrnCnt').AsInteger;
end;

procedure TAlhBtr.WritePrnCnt(pValue:byte);
begin
  oBtrTable.FieldByName('PrnCnt').AsInteger := pValue;
end;

function TAlhBtr.ReadDstLck:byte;
begin
  Result := oBtrTable.FieldByName('DstLck').AsInteger;
end;

procedure TAlhBtr.WriteDstLck(pValue:byte);
begin
  oBtrTable.FieldByName('DstLck').AsInteger := pValue;
end;

function TAlhBtr.ReadStatus:Str1;
begin
  Result := oBtrTable.FieldByName('Status').AsString;
end;

procedure TAlhBtr.WriteStatus(pValue:Str1);
begin
  oBtrTable.FieldByName('Status').AsString := pValue;
end;

function TAlhBtr.ReadCrtUser:Str8;
begin
  Result := oBtrTable.FieldByName('CrtUser').AsString;
end;

procedure TAlhBtr.WriteCrtUser(pValue:Str8);
begin
  oBtrTable.FieldByName('CrtUser').AsString := pValue;
end;

function TAlhBtr.ReadCrtDate:TDatetime;
begin
  Result := oBtrTable.FieldByName('CrtDate').AsDateTime;
end;

procedure TAlhBtr.WriteCrtDate(pValue:TDatetime);
begin
  oBtrTable.FieldByName('CrtDate').AsDateTime := pValue;
end;

function TAlhBtr.ReadCrtTime:TDatetime;
begin
  Result := oBtrTable.FieldByName('CrtTime').AsDateTime;
end;

procedure TAlhBtr.WriteCrtTime(pValue:TDatetime);
begin
  oBtrTable.FieldByName('CrtTime').AsDateTime := pValue;
end;

function TAlhBtr.ReadModUser:Str8;
begin
  Result := oBtrTable.FieldByName('ModUser').AsString;
end;

procedure TAlhBtr.WriteModUser(pValue:Str8);
begin
  oBtrTable.FieldByName('ModUser').AsString := pValue;
end;

function TAlhBtr.ReadModDate:TDatetime;
begin
  Result := oBtrTable.FieldByName('ModDate').AsDateTime;
end;

procedure TAlhBtr.WriteModDate(pValue:TDatetime);
begin
  oBtrTable.FieldByName('ModDate').AsDateTime := pValue;
end;

function TAlhBtr.ReadModTime:TDatetime;
begin
  Result := oBtrTable.FieldByName('ModTime').AsDateTime;
end;

procedure TAlhBtr.WriteModTime(pValue:TDatetime);
begin
  oBtrTable.FieldByName('ModTime').AsDateTime := pValue;
end;

function TAlhBtr.ReadIcdDate:TDatetime;
begin
  Result := oBtrTable.FieldByName('IcdDate').AsDateTime;
end;

procedure TAlhBtr.WriteIcdDate(pValue:TDatetime);
begin
  oBtrTable.FieldByName('IcdDate').AsDateTime := pValue;
end;

function TAlhBtr.ReadAmdNum:Str12;
begin
  Result := oBtrTable.FieldByName('AmdNum').AsString;
end;

procedure TAlhBtr.WriteAmdNum(pValue:Str12);
begin
  oBtrTable.FieldByName('AmdNum').AsString := pValue;
end;

function TAlhBtr.ReadAodNum:Str12;
begin
  Result := oBtrTable.FieldByName('AodNum').AsString;
end;

procedure TAlhBtr.WriteAodNum(pValue:Str12);
begin
  oBtrTable.FieldByName('AodNum').AsString := pValue;
end;

function TAlhBtr.ReadAsDValue:double;
begin
  Result := oBtrTable.FieldByName('AsDValue').AsFloat;
end;

procedure TAlhBtr.WriteAsDValue(pValue:double);
begin
  oBtrTable.FieldByName('AsDValue').AsFloat := pValue;
end;

function TAlhBtr.ReadAsHValue:double;
begin
  Result := oBtrTable.FieldByName('AsHValue').AsFloat;
end;

procedure TAlhBtr.WriteAsHValue(pValue:double);
begin
  oBtrTable.FieldByName('AsHValue').AsFloat := pValue;
end;

function TAlhBtr.ReadAsDdsVal:double;
begin
  Result := oBtrTable.FieldByName('AsDdsVal').AsFloat;
end;

procedure TAlhBtr.WriteAsDdsVal(pValue:double);
begin
  oBtrTable.FieldByName('AsDdsVal').AsFloat := pValue;
end;

function TAlhBtr.ReadAsHdsVal:double;
begin
  Result := oBtrTable.FieldByName('AsHdsVal').AsFloat;
end;

procedure TAlhBtr.WriteAsHdsVal(pValue:double);
begin
  oBtrTable.FieldByName('AsHdsVal').AsFloat := pValue;
end;

function TAlhBtr.ReadInSurVal:double;
begin
  Result := oBtrTable.FieldByName('InSurVal').AsFloat;
end;

procedure TAlhBtr.WriteInSurVal(pValue:double);
begin
  oBtrTable.FieldByName('InSurVal').AsFloat := pValue;
end;

function TAlhBtr.ReadReSurVal:double;
begin
  Result := oBtrTable.FieldByName('ReSurVal').AsFloat;
end;

procedure TAlhBtr.WriteReSurVal(pValue:double);
begin
  oBtrTable.FieldByName('ReSurVal').AsFloat := pValue;
end;

function TAlhBtr.ReadYear:Str2;
begin
  Result := oBtrTable.FieldByName('Year').AsString;
end;

procedure TAlhBtr.WriteYear(pValue:Str2);
begin
  oBtrTable.FieldByName('Year').AsString := pValue;
end;

// **************************************** PUBLIC ********************************************

function TAlhBtr.Eof: boolean;
begin
  Result := oBtrTable.Eof;
end;

function TAlhBtr.IsFirstRec: boolean;
begin
  Result := oBtrTable.Bof;
end;

function TAlhBtr.IsLastRec: boolean;
begin
  Result := oBtrTable.Eof;
end;

function TAlhBtr.Active: boolean;
begin
  Result := oBtrTable.Active;
end;

function TAlhBtr.ActPos: longint;
begin
  Result := oBtrTable.ActPos;
end;

function TAlhBtr.GotoPos (pActPos:longint): boolean;
begin
  Result := oBtrTable.GotoPos(pActPos);
end;

function TAlhBtr.LocateYearSerNum (pYear:Str2;pSerNum:longint):boolean;
begin
  SetIndex (ixYearSerNum);
  Result := oBtrTable.FindKey([pYear,pSerNum]);
end;

function TAlhBtr.LocateDocNum (pDocNum:Str12):boolean;
begin
  SetIndex (ixDocNum);
  Result := oBtrTable.FindKey([pDocNum]);
end;

function TAlhBtr.LocateDoDate (pDocDate:TDatetime):boolean;
begin
  SetIndex (ixDoDate);
  Result := oBtrTable.FindKey([pDocDate]);
end;

function TAlhBtr.LocatePaCode (pPaCode:longint):boolean;
begin
  SetIndex (ixPaCode);
  Result := oBtrTable.FindKey([pPaCode]);
end;

function TAlhBtr.LocatePaName (pPaName_:Str30):boolean;
begin
  SetIndex (ixPaName);
  Result := oBtrTable.FindKey([StrToAlias(pPaName_)]);
end;

function TAlhBtr.LocateStatus (pStatus:Str1):boolean;
begin
  SetIndex (ixStatus);
  Result := oBtrTable.FindKey([pStatus]);
end;

function TAlhBtr.NearestYearSerNum (pYear:Str2;pSerNum:longint):boolean;
begin
  SetIndex (ixYearSerNum);
  Result := oBtrTable.FindNearest([pYear,pSerNum]);
end;

function TAlhBtr.NearestDocNum (pDocNum:Str12):boolean;
begin
  SetIndex (ixDocNum);
  Result := oBtrTable.FindNearest([pDocNum]);
end;

function TAlhBtr.NearestDoDate (pDocDate:TDatetime):boolean;
begin
  SetIndex (ixDoDate);
  Result := oBtrTable.FindNearest([pDocDate]);
end;

function TAlhBtr.NearestPaCode (pPaCode:longint):boolean;
begin
  SetIndex (ixPaCode);
  Result := oBtrTable.FindNearest([pPaCode]);
end;

function TAlhBtr.NearestPaName (pPaName_:Str30):boolean;
begin
  SetIndex (ixPaName);
  Result := oBtrTable.FindNearest([pPaName_]);
end;

function TAlhBtr.NearestStatus (pStatus:Str1):boolean;
begin
  SetIndex (ixStatus);
  Result := oBtrTable.FindNearest([pStatus]);
end;

procedure TAlhBtr.SetIndex (pIndexName:ShortString);
begin
  If oBtrTable.IndexName<>pIndexName then oBtrTable.IndexName := pIndexName;
end;

procedure TAlhBtr.Open(pBookNum:Str5);
begin
  oBookNum := pBookNum;
  oBtrTable.Open(pBookNum);
end;

procedure TAlhBtr.Close;
begin
  If oBtrTable.Active then oBtrTable.Close;
end;

procedure TAlhBtr.Prior;
begin
  oBtrTable.Prior;
end;

procedure TAlhBtr.Next;
begin
  oBtrTable.Next;
end;

procedure TAlhBtr.First;
begin
  oBtrTable.First;
end;

procedure TAlhBtr.Last;
begin
  oBtrTable.Last;
end;

procedure TAlhBtr.Insert;
begin
  oBtrTable.Insert;
end;

procedure TAlhBtr.Edit;
begin
  oBtrTable.Edit;
end;

procedure TAlhBtr.Post;
begin
  oBtrTable.Post;
end;

procedure TAlhBtr.Delete;
begin
  oBtrTable.Delete;
end;

procedure TAlhBtr.SwapIndex;
begin
  oBtrTable.SwapIndex;
end;

procedure TAlhBtr.RestoreIndex;
begin
  oBtrTable.RestoreIndex;
end;

procedure TAlhBtr.SwapStatus;
begin
  oBtrTable.SwapStatus;
end;

procedure TAlhBtr.RestoreStatus;
begin
  oBtrTable.RestoreStatus;
end;

procedure TAlhBtr.EnableControls;
begin
  oBtrTable.EnableControls;
end;

procedure TAlhBtr.DisableControls;
begin
  oBtrTable.DisableControls;
end;

end.
