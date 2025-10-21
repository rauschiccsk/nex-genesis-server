unit bAMH;

interface

uses
  IcTypes, IcConv, NexPath, NexGlob,
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls,
  Dialogs, DB, NexBtrTable, DBTables, NexPxTable;

const
  ixYearSerNum = 'YearSerNum';
  ixDocNum = 'DocNum';
  ixDocDate = 'DocDate';
  ixExpDate = 'ExpDate';
  ixPaCode = 'PaCode';
  ixPaName = 'PaName';
  ixRefNum = 'RefNum';
  ixStatus = 'Status';

type
  TAmhBtr = class (TComponent)
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
    function  ReadDocDate:TDatetime;     procedure WriteDocDate (pValue:TDatetime);
    function  ReadExpDate:TDatetime;     procedure WriteExpDate (pValue:TDatetime);
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
    function  ReadRegTel:Str20;          procedure WriteRegTel (pValue:Str20);
    function  ReadRegFax:Str20;          procedure WriteRegFax (pValue:Str20);
    function  ReadRegEml:Str30;          procedure WriteRegEml (pValue:Str30);
    function  ReadDscPrc:double;         procedure WriteDscPrc (pValue:double);
    function  ReadSurPrc:double;         procedure WriteSurPrc (pValue:double);
    function  ReadPenPrc:double;         procedure WritePenPrc (pValue:double);
    function  ReadRdiPrc:double;         procedure WriteRdiPrc (pValue:double);
    function  ReadRduPrc:double;         procedure WriteRduPrc (pValue:double);
    function  ReadSurVal:double;         procedure WriteSurVal (pValue:double);
    function  ReadAgAValue:double;       procedure WriteAgAValue (pValue:double);
    function  ReadAgBvalue:double;       procedure WriteAgBvalue (pValue:double);
    function  ReadAsDValue:double;       procedure WriteAsDValue (pValue:double);
    function  ReadAsHValue:double;       procedure WriteAsHValue (pValue:double);
    function  ReadAsDdsVal:double;       procedure WriteAsDdsVal (pValue:double);
    function  ReadAsHdsVal:double;       procedure WriteAsHdsVal (pValue:double);
    function  ReadAsAValue:double;       procedure WriteAsAValue (pValue:double);
    function  ReadAsBvalue:double;       procedure WriteAsBvalue (pValue:double);
    function  ReadItmQnt:word;           procedure WriteItmQnt (pValue:word);
    function  ReadPrnCnt:byte;           procedure WritePrnCnt (pValue:byte);
    function  ReadDstLck:byte;           procedure WriteDstLck (pValue:byte);
    function  ReadAodNum:Str12;          procedure WriteAodNum (pValue:Str12);
    function  ReadRefNum:word;           procedure WriteRefNum (pValue:word);
    function  ReadRefTxt:Str30;          procedure WriteRefTxt (pValue:Str30);
    function  ReadStatus:Str1;           procedure WriteStatus (pValue:Str1);
    function  ReadCrtUser:Str8;          procedure WriteCrtUser (pValue:Str8);
    function  ReadCrtDate:TDatetime;     procedure WriteCrtDate (pValue:TDatetime);
    function  ReadCrtTime:TDatetime;     procedure WriteCrtTime (pValue:TDatetime);
    function  ReadModUser:Str8;          procedure WriteModUser (pValue:Str8);
    function  ReadModDate:TDatetime;     procedure WriteModDate (pValue:TDatetime);
    function  ReadModTime:TDatetime;     procedure WriteModTime (pValue:TDatetime);
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
    function LocateDocDate (pDocDate:TDatetime):boolean;
    function LocateExpDate (pExpDate:TDatetime):boolean;
    function LocatePaCode (pPaCode:longint):boolean;
    function LocatePaName (pPaName_:Str30):boolean;
    function LocateRefNum (pRefNum:word):boolean;
    function LocateStatus (pStatus:Str1):boolean;
    function NearestYearSerNum (pYear:Str2;pSerNum:longint):boolean;
    function NearestDocNum (pDocNum:Str12):boolean;
    function NearestDocDate (pDocDate:TDatetime):boolean;
    function NearestExpDate (pExpDate:TDatetime):boolean;
    function NearestPaCode (pPaCode:longint):boolean;
    function NearestPaName (pPaName_:Str30):boolean;
    function NearestRefNum (pRefNum:word):boolean;
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
    property DocDate:TDatetime read ReadDocDate write WriteDocDate;
    property ExpDate:TDatetime read ReadExpDate write WriteExpDate;
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
    property RegTel:Str20 read ReadRegTel write WriteRegTel;
    property RegFax:Str20 read ReadRegFax write WriteRegFax;
    property RegEml:Str30 read ReadRegEml write WriteRegEml;
    property DscPrc:double read ReadDscPrc write WriteDscPrc;
    property SurPrc:double read ReadSurPrc write WriteSurPrc;
    property PenPrc:double read ReadPenPrc write WritePenPrc;
    property RdiPrc:double read ReadRdiPrc write WriteRdiPrc;
    property RduPrc:double read ReadRduPrc write WriteRduPrc;
    property SurVal:double read ReadSurVal write WriteSurVal;
    property AgAValue:double read ReadAgAValue write WriteAgAValue;
    property AgBvalue:double read ReadAgBvalue write WriteAgBvalue;
    property AsDValue:double read ReadAsDValue write WriteAsDValue;
    property AsHValue:double read ReadAsHValue write WriteAsHValue;
    property AsDdsVal:double read ReadAsDdsVal write WriteAsDdsVal;
    property AsHdsVal:double read ReadAsHdsVal write WriteAsHdsVal;
    property AsAValue:double read ReadAsAValue write WriteAsAValue;
    property AsBvalue:double read ReadAsBvalue write WriteAsBvalue;
    property ItmQnt:word read ReadItmQnt write WriteItmQnt;
    property PrnCnt:byte read ReadPrnCnt write WritePrnCnt;
    property DstLck:byte read ReadDstLck write WriteDstLck;
    property AodNum:Str12 read ReadAodNum write WriteAodNum;
    property RefNum:word read ReadRefNum write WriteRefNum;
    property RefTxt:Str30 read ReadRefTxt write WriteRefTxt;
    property Status:Str1 read ReadStatus write WriteStatus;
    property CrtUser:Str8 read ReadCrtUser write WriteCrtUser;
    property CrtDate:TDatetime read ReadCrtDate write WriteCrtDate;
    property CrtTime:TDatetime read ReadCrtTime write WriteCrtTime;
    property ModUser:Str8 read ReadModUser write WriteModUser;
    property ModDate:TDatetime read ReadModDate write WriteModDate;
    property ModTime:TDatetime read ReadModTime write WriteModTime;
    property Year:Str2 read ReadYear write WriteYear;
  end;

implementation

constructor TAmhBtr.Create;
begin
  oBtrTable := BtrInit ('AMH',gPath.StkPath,Self);
end;

constructor TAmhBtr.Create(pPath:ShortString);
begin
  oBtrTable := BtrInit ('AMH',pPath,Self);
end;

destructor TAmhBtr.Destroy;
begin
  oBtrTable.Close;  FreeAndNil (oBtrTable);
end;

// *************************************** PRIVATE ********************************************

function TAmhBtr.ReadCount:integer;
begin
  Result := oBtrTable.RecordCount;
end;

function TAmhBtr.FieldExist (pFieldName:ShortString): boolean;
begin
  Result := oBtrTable.FindField(pFieldName)<>nil;
end;

function TAmhBtr.ReadSerNum:longint;
begin
  Result := oBtrTable.FieldByName('SerNum').AsInteger;
end;

procedure TAmhBtr.WriteSerNum(pValue:longint);
begin
  oBtrTable.FieldByName('SerNum').AsInteger := pValue;
end;

function TAmhBtr.ReadDocNum:Str12;
begin
  Result := oBtrTable.FieldByName('DocNum').AsString;
end;

procedure TAmhBtr.WriteDocNum(pValue:Str12);
begin
  oBtrTable.FieldByName('DocNum').AsString := pValue;
end;

function TAmhBtr.ReadDocDate:TDatetime;
begin
  Result := oBtrTable.FieldByName('DocDate').AsDateTime;
end;

procedure TAmhBtr.WriteDocDate(pValue:TDatetime);
begin
  oBtrTable.FieldByName('DocDate').AsDateTime := pValue;
end;

function TAmhBtr.ReadExpDate:TDatetime;
begin
  Result := oBtrTable.FieldByName('ExpDate').AsDateTime;
end;

procedure TAmhBtr.WriteExpDate(pValue:TDatetime);
begin
  oBtrTable.FieldByName('ExpDate').AsDateTime := pValue;
end;

function TAmhBtr.ReadPaCode:longint;
begin
  Result := oBtrTable.FieldByName('PaCode').AsInteger;
end;

procedure TAmhBtr.WritePaCode(pValue:longint);
begin
  oBtrTable.FieldByName('PaCode').AsInteger := pValue;
end;

function TAmhBtr.ReadPaName:Str30;
begin
  Result := oBtrTable.FieldByName('PaName').AsString;
end;

procedure TAmhBtr.WritePaName(pValue:Str30);
begin
  oBtrTable.FieldByName('PaName').AsString := pValue;
end;

function TAmhBtr.ReadPaName_:Str30;
begin
  Result := oBtrTable.FieldByName('PaName_').AsString;
end;

procedure TAmhBtr.WritePaName_(pValue:Str30);
begin
  oBtrTable.FieldByName('PaName_').AsString := pValue;
end;

function TAmhBtr.ReadRegName:Str60;
begin
  Result := oBtrTable.FieldByName('RegName').AsString;
end;

procedure TAmhBtr.WriteRegName(pValue:Str60);
begin
  oBtrTable.FieldByName('RegName').AsString := pValue;
end;

function TAmhBtr.ReadRegAddr:Str30;
begin
  Result := oBtrTable.FieldByName('RegAddr').AsString;
end;

procedure TAmhBtr.WriteRegAddr(pValue:Str30);
begin
  oBtrTable.FieldByName('RegAddr').AsString := pValue;
end;

function TAmhBtr.ReadRegZip:Str15;
begin
  Result := oBtrTable.FieldByName('RegZip').AsString;
end;

procedure TAmhBtr.WriteRegZip(pValue:Str15);
begin
  oBtrTable.FieldByName('RegZip').AsString := pValue;
end;

function TAmhBtr.ReadRegCty:Str3;
begin
  Result := oBtrTable.FieldByName('RegCty').AsString;
end;

procedure TAmhBtr.WriteRegCty(pValue:Str3);
begin
  oBtrTable.FieldByName('RegCty').AsString := pValue;
end;

function TAmhBtr.ReadRegCtn:Str30;
begin
  Result := oBtrTable.FieldByName('RegCtn').AsString;
end;

procedure TAmhBtr.WriteRegCtn(pValue:Str30);
begin
  oBtrTable.FieldByName('RegCtn').AsString := pValue;
end;

function TAmhBtr.ReadRegSta:Str2;
begin
  Result := oBtrTable.FieldByName('RegSta').AsString;
end;

procedure TAmhBtr.WriteRegSta(pValue:Str2);
begin
  oBtrTable.FieldByName('RegSta').AsString := pValue;
end;

function TAmhBtr.ReadRegIno:Str15;
begin
  Result := oBtrTable.FieldByName('RegIno').AsString;
end;

procedure TAmhBtr.WriteRegIno(pValue:Str15);
begin
  oBtrTable.FieldByName('RegIno').AsString := pValue;
end;

function TAmhBtr.ReadRegTin:Str15;
begin
  Result := oBtrTable.FieldByName('RegTin').AsString;
end;

procedure TAmhBtr.WriteRegTin(pValue:Str15);
begin
  oBtrTable.FieldByName('RegTin').AsString := pValue;
end;

function TAmhBtr.ReadRegVin:Str15;
begin
  Result := oBtrTable.FieldByName('RegVin').AsString;
end;

procedure TAmhBtr.WriteRegVin(pValue:Str15);
begin
  oBtrTable.FieldByName('RegVin').AsString := pValue;
end;

function TAmhBtr.ReadRegTel:Str20;
begin
  Result := oBtrTable.FieldByName('RegTel').AsString;
end;

procedure TAmhBtr.WriteRegTel(pValue:Str20);
begin
  oBtrTable.FieldByName('RegTel').AsString := pValue;
end;

function TAmhBtr.ReadRegFax:Str20;
begin
  Result := oBtrTable.FieldByName('RegFax').AsString;
end;

procedure TAmhBtr.WriteRegFax(pValue:Str20);
begin
  oBtrTable.FieldByName('RegFax').AsString := pValue;
end;

function TAmhBtr.ReadRegEml:Str30;
begin
  Result := oBtrTable.FieldByName('RegEml').AsString;
end;

procedure TAmhBtr.WriteRegEml(pValue:Str30);
begin
  oBtrTable.FieldByName('RegEml').AsString := pValue;
end;

function TAmhBtr.ReadDscPrc:double;
begin
  Result := oBtrTable.FieldByName('DscPrc').AsFloat;
end;

procedure TAmhBtr.WriteDscPrc(pValue:double);
begin
  oBtrTable.FieldByName('DscPrc').AsFloat := pValue;
end;

function TAmhBtr.ReadSurPrc:double;
begin
  Result := oBtrTable.FieldByName('SurPrc').AsFloat;
end;

procedure TAmhBtr.WriteSurPrc(pValue:double);
begin
  oBtrTable.FieldByName('SurPrc').AsFloat := pValue;
end;

function TAmhBtr.ReadPenPrc:double;
begin
  Result := oBtrTable.FieldByName('PenPrc').AsFloat;
end;

procedure TAmhBtr.WritePenPrc(pValue:double);
begin
  oBtrTable.FieldByName('PenPrc').AsFloat := pValue;
end;

function TAmhBtr.ReadRdiPrc:double;
begin
  Result := oBtrTable.FieldByName('RdiPrc').AsFloat;
end;

procedure TAmhBtr.WriteRdiPrc(pValue:double);
begin
  oBtrTable.FieldByName('RdiPrc').AsFloat := pValue;
end;

function TAmhBtr.ReadRduPrc:double;
begin
  Result := oBtrTable.FieldByName('RduPrc').AsFloat;
end;

procedure TAmhBtr.WriteRduPrc(pValue:double);
begin
  oBtrTable.FieldByName('RduPrc').AsFloat := pValue;
end;

function TAmhBtr.ReadSurVal:double;
begin
  Result := oBtrTable.FieldByName('SurVal').AsFloat;
end;

procedure TAmhBtr.WriteSurVal(pValue:double);
begin
  oBtrTable.FieldByName('SurVal').AsFloat := pValue;
end;

function TAmhBtr.ReadAgAValue:double;
begin
  Result := oBtrTable.FieldByName('AgAValue').AsFloat;
end;

procedure TAmhBtr.WriteAgAValue(pValue:double);
begin
  oBtrTable.FieldByName('AgAValue').AsFloat := pValue;
end;

function TAmhBtr.ReadAgBvalue:double;
begin
  Result := oBtrTable.FieldByName('AgBvalue').AsFloat;
end;

procedure TAmhBtr.WriteAgBvalue(pValue:double);
begin
  oBtrTable.FieldByName('AgBvalue').AsFloat := pValue;
end;

function TAmhBtr.ReadAsDValue:double;
begin
  Result := oBtrTable.FieldByName('AsDValue').AsFloat;
end;

procedure TAmhBtr.WriteAsDValue(pValue:double);
begin
  oBtrTable.FieldByName('AsDValue').AsFloat := pValue;
end;

function TAmhBtr.ReadAsHValue:double;
begin
  Result := oBtrTable.FieldByName('AsHValue').AsFloat;
end;

procedure TAmhBtr.WriteAsHValue(pValue:double);
begin
  oBtrTable.FieldByName('AsHValue').AsFloat := pValue;
end;

function TAmhBtr.ReadAsDdsVal:double;
begin
  Result := oBtrTable.FieldByName('AsDdsVal').AsFloat;
end;

procedure TAmhBtr.WriteAsDdsVal(pValue:double);
begin
  oBtrTable.FieldByName('AsDdsVal').AsFloat := pValue;
end;

function TAmhBtr.ReadAsHdsVal:double;
begin
  Result := oBtrTable.FieldByName('AsHdsVal').AsFloat;
end;

procedure TAmhBtr.WriteAsHdsVal(pValue:double);
begin
  oBtrTable.FieldByName('AsHdsVal').AsFloat := pValue;
end;

function TAmhBtr.ReadAsAValue:double;
begin
  Result := oBtrTable.FieldByName('AsAValue').AsFloat;
end;

procedure TAmhBtr.WriteAsAValue(pValue:double);
begin
  oBtrTable.FieldByName('AsAValue').AsFloat := pValue;
end;

function TAmhBtr.ReadAsBvalue:double;
begin
  Result := oBtrTable.FieldByName('AsBvalue').AsFloat;
end;

procedure TAmhBtr.WriteAsBvalue(pValue:double);
begin
  oBtrTable.FieldByName('AsBvalue').AsFloat := pValue;
end;

function TAmhBtr.ReadItmQnt:word;
begin
  Result := oBtrTable.FieldByName('ItmQnt').AsInteger;
end;

procedure TAmhBtr.WriteItmQnt(pValue:word);
begin
  oBtrTable.FieldByName('ItmQnt').AsInteger := pValue;
end;

function TAmhBtr.ReadPrnCnt:byte;
begin
  Result := oBtrTable.FieldByName('PrnCnt').AsInteger;
end;

procedure TAmhBtr.WritePrnCnt(pValue:byte);
begin
  oBtrTable.FieldByName('PrnCnt').AsInteger := pValue;
end;

function TAmhBtr.ReadDstLck:byte;
begin
  Result := oBtrTable.FieldByName('DstLck').AsInteger;
end;

procedure TAmhBtr.WriteDstLck(pValue:byte);
begin
  oBtrTable.FieldByName('DstLck').AsInteger := pValue;
end;

function TAmhBtr.ReadAodNum:Str12;
begin
  Result := oBtrTable.FieldByName('AodNum').AsString;
end;

procedure TAmhBtr.WriteAodNum(pValue:Str12);
begin
  oBtrTable.FieldByName('AodNum').AsString := pValue;
end;

function TAmhBtr.ReadRefNum:word;
begin
  Result := oBtrTable.FieldByName('RefNum').AsInteger;
end;

procedure TAmhBtr.WriteRefNum(pValue:word);
begin
  oBtrTable.FieldByName('RefNum').AsInteger := pValue;
end;

function TAmhBtr.ReadRefTxt:Str30;
begin
  Result := oBtrTable.FieldByName('RefTxt').AsString;
end;

procedure TAmhBtr.WriteRefTxt(pValue:Str30);
begin
  oBtrTable.FieldByName('RefTxt').AsString := pValue;
end;

function TAmhBtr.ReadStatus:Str1;
begin
  Result := oBtrTable.FieldByName('Status').AsString;
end;

procedure TAmhBtr.WriteStatus(pValue:Str1);
begin
  oBtrTable.FieldByName('Status').AsString := pValue;
end;

function TAmhBtr.ReadCrtUser:Str8;
begin
  Result := oBtrTable.FieldByName('CrtUser').AsString;
end;

procedure TAmhBtr.WriteCrtUser(pValue:Str8);
begin
  oBtrTable.FieldByName('CrtUser').AsString := pValue;
end;

function TAmhBtr.ReadCrtDate:TDatetime;
begin
  Result := oBtrTable.FieldByName('CrtDate').AsDateTime;
end;

procedure TAmhBtr.WriteCrtDate(pValue:TDatetime);
begin
  oBtrTable.FieldByName('CrtDate').AsDateTime := pValue;
end;

function TAmhBtr.ReadCrtTime:TDatetime;
begin
  Result := oBtrTable.FieldByName('CrtTime').AsDateTime;
end;

procedure TAmhBtr.WriteCrtTime(pValue:TDatetime);
begin
  oBtrTable.FieldByName('CrtTime').AsDateTime := pValue;
end;

function TAmhBtr.ReadModUser:Str8;
begin
  Result := oBtrTable.FieldByName('ModUser').AsString;
end;

procedure TAmhBtr.WriteModUser(pValue:Str8);
begin
  oBtrTable.FieldByName('ModUser').AsString := pValue;
end;

function TAmhBtr.ReadModDate:TDatetime;
begin
  Result := oBtrTable.FieldByName('ModDate').AsDateTime;
end;

procedure TAmhBtr.WriteModDate(pValue:TDatetime);
begin
  oBtrTable.FieldByName('ModDate').AsDateTime := pValue;
end;

function TAmhBtr.ReadModTime:TDatetime;
begin
  Result := oBtrTable.FieldByName('ModTime').AsDateTime;
end;

procedure TAmhBtr.WriteModTime(pValue:TDatetime);
begin
  oBtrTable.FieldByName('ModTime').AsDateTime := pValue;
end;

function TAmhBtr.ReadYear:Str2;
begin
  Result := oBtrTable.FieldByName('Year').AsString;
end;

procedure TAmhBtr.WriteYear(pValue:Str2);
begin
  oBtrTable.FieldByName('Year').AsString := pValue;
end;

// **************************************** PUBLIC ********************************************

function TAmhBtr.Eof: boolean;
begin
  Result := oBtrTable.Eof;
end;

function TAmhBtr.IsFirstRec: boolean;
begin
  Result := oBtrTable.Bof;
end;

function TAmhBtr.IsLastRec: boolean;
begin
  Result := oBtrTable.Eof;
end;

function TAmhBtr.Active: boolean;
begin
  Result := oBtrTable.Active;
end;

function TAmhBtr.ActPos: longint;
begin
  Result := oBtrTable.ActPos;
end;

function TAmhBtr.GotoPos (pActPos:longint): boolean;
begin
  Result := oBtrTable.GotoPos(pActPos);
end;

function TAmhBtr.LocateYearSerNum (pYear:Str2;pSerNum:longint):boolean;
begin
  SetIndex (ixYearSerNum);
  Result := oBtrTable.FindKey([pYear,pSerNum]);
end;

function TAmhBtr.LocateDocNum (pDocNum:Str12):boolean;
begin
  SetIndex (ixDocNum);
  Result := oBtrTable.FindKey([pDocNum]);
end;

function TAmhBtr.LocateDocDate (pDocDate:TDatetime):boolean;
begin
  SetIndex (ixDocDate);
  Result := oBtrTable.FindKey([pDocDate]);
end;

function TAmhBtr.LocateExpDate (pExpDate:TDatetime):boolean;
begin
  SetIndex (ixExpDate);
  Result := oBtrTable.FindKey([pExpDate]);
end;

function TAmhBtr.LocatePaCode (pPaCode:longint):boolean;
begin
  SetIndex (ixPaCode);
  Result := oBtrTable.FindKey([pPaCode]);
end;

function TAmhBtr.LocatePaName (pPaName_:Str30):boolean;
begin
  SetIndex (ixPaName);
  Result := oBtrTable.FindKey([StrToAlias(pPaName_)]);
end;

function TAmhBtr.LocateRefNum (pRefNum:word):boolean;
begin
  SetIndex (ixRefNum);
  Result := oBtrTable.FindKey([pRefNum]);
end;

function TAmhBtr.LocateStatus (pStatus:Str1):boolean;
begin
  SetIndex (ixStatus);
  Result := oBtrTable.FindKey([pStatus]);
end;

function TAmhBtr.NearestYearSerNum (pYear:Str2;pSerNum:longint):boolean;
begin
  SetIndex (ixYearSerNum);
  Result := oBtrTable.FindNearest([pYear,pSerNum]);
end;

function TAmhBtr.NearestDocNum (pDocNum:Str12):boolean;
begin
  SetIndex (ixDocNum);
  Result := oBtrTable.FindNearest([pDocNum]);
end;

function TAmhBtr.NearestDocDate (pDocDate:TDatetime):boolean;
begin
  SetIndex (ixDocDate);
  Result := oBtrTable.FindNearest([pDocDate]);
end;

function TAmhBtr.NearestExpDate (pExpDate:TDatetime):boolean;
begin
  SetIndex (ixExpDate);
  Result := oBtrTable.FindNearest([pExpDate]);
end;

function TAmhBtr.NearestPaCode (pPaCode:longint):boolean;
begin
  SetIndex (ixPaCode);
  Result := oBtrTable.FindNearest([pPaCode]);
end;

function TAmhBtr.NearestPaName (pPaName_:Str30):boolean;
begin
  SetIndex (ixPaName);
  Result := oBtrTable.FindNearest([pPaName_]);
end;

function TAmhBtr.NearestRefNum (pRefNum:word):boolean;
begin
  SetIndex (ixRefNum);
  Result := oBtrTable.FindNearest([pRefNum]);
end;

function TAmhBtr.NearestStatus (pStatus:Str1):boolean;
begin
  SetIndex (ixStatus);
  Result := oBtrTable.FindNearest([pStatus]);
end;

procedure TAmhBtr.SetIndex (pIndexName:ShortString);
begin
  If oBtrTable.IndexName<>pIndexName then oBtrTable.IndexName := pIndexName;
end;

procedure TAmhBtr.Open(pBookNum:Str5);
begin
  oBookNum := pBookNum;
  oBtrTable.Open(pBookNum);
end;

procedure TAmhBtr.Close;
begin
  If oBtrTable.Active then oBtrTable.Close;
end;

procedure TAmhBtr.Prior;
begin
  oBtrTable.Prior;
end;

procedure TAmhBtr.Next;
begin
  oBtrTable.Next;
end;

procedure TAmhBtr.First;
begin
  oBtrTable.First;
end;

procedure TAmhBtr.Last;
begin
  oBtrTable.Last;
end;

procedure TAmhBtr.Insert;
begin
  oBtrTable.Insert;
end;

procedure TAmhBtr.Edit;
begin
  oBtrTable.Edit;
end;

procedure TAmhBtr.Post;
begin
  oBtrTable.Post;
end;

procedure TAmhBtr.Delete;
begin
  oBtrTable.Delete;
end;

procedure TAmhBtr.SwapIndex;
begin
  oBtrTable.SwapIndex;
end;

procedure TAmhBtr.RestoreIndex;
begin
  oBtrTable.RestoreIndex;
end;

procedure TAmhBtr.SwapStatus;
begin
  oBtrTable.SwapStatus;
end;

procedure TAmhBtr.RestoreStatus;
begin
  oBtrTable.RestoreStatus;
end;

procedure TAmhBtr.EnableControls;
begin
  oBtrTable.EnableControls;
end;

procedure TAmhBtr.DisableControls;
begin
  oBtrTable.DisableControls;
end;

end.
