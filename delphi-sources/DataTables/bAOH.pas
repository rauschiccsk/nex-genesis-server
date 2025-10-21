unit bAOH;

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
  ixAmdNum = 'AmdNum';
  ixAldNum = 'AldNum';
  ixStatus = 'Status';

type
  TAohBtr = class (TComponent)
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
    function  ReadBegDate:TDatetime;     procedure WriteBegDate (pValue:TDatetime);
    function  ReadEndDate:TDatetime;     procedure WriteEndDate (pValue:TDatetime);
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
    function  ReadAmdNum:Str12;          procedure WriteAmdNum (pValue:Str12);
    function  ReadAldNum:Str12;          procedure WriteAldNum (pValue:Str12);
    function  ReadCanNum:word;           procedure WriteCanNum (pValue:word);
    function  ReadCanTxt:Str30;          procedure WriteCanTxt (pValue:Str30);
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
    function LocateDoDate (pDocDate:TDatetime):boolean;
    function LocatePaCode (pPaCode:longint):boolean;
    function LocatePaName (pPaName_:Str30):boolean;
    function LocateAmdNum (pAmdNum:Str12):boolean;
    function LocateAldNum (pAldNum:Str12):boolean;
    function LocateStatus (pStatus:Str1):boolean;
    function NearestYearSerNum (pYear:Str2;pSerNum:longint):boolean;
    function NearestDocNum (pDocNum:Str12):boolean;
    function NearestDoDate (pDocDate:TDatetime):boolean;
    function NearestPaCode (pPaCode:longint):boolean;
    function NearestPaName (pPaName_:Str30):boolean;
    function NearestAmdNum (pAmdNum:Str12):boolean;
    function NearestAldNum (pAldNum:Str12):boolean;
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
    property BegDate:TDatetime read ReadBegDate write WriteBegDate;
    property EndDate:TDatetime read ReadEndDate write WriteEndDate;
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
    property AmdNum:Str12 read ReadAmdNum write WriteAmdNum;
    property AldNum:Str12 read ReadAldNum write WriteAldNum;
    property CanNum:word read ReadCanNum write WriteCanNum;
    property CanTxt:Str30 read ReadCanTxt write WriteCanTxt;
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

constructor TAohBtr.Create;
begin
  oBtrTable := BtrInit ('AOH',gPath.StkPath,Self);
end;

constructor TAohBtr.Create(pPath:ShortString);
begin
  oBtrTable := BtrInit ('AOH',pPath,Self);
end;

destructor TAohBtr.Destroy;
begin
  oBtrTable.Close;  FreeAndNil (oBtrTable);
end;

// *************************************** PRIVATE ********************************************

function TAohBtr.ReadCount:integer;
begin
  Result := oBtrTable.RecordCount;
end;

function TAohBtr.FieldExist (pFieldName:ShortString): boolean;
begin
  Result := oBtrTable.FindField(pFieldName)<>nil;
end;

function TAohBtr.ReadSerNum:longint;
begin
  Result := oBtrTable.FieldByName('SerNum').AsInteger;
end;

procedure TAohBtr.WriteSerNum(pValue:longint);
begin
  oBtrTable.FieldByName('SerNum').AsInteger := pValue;
end;

function TAohBtr.ReadDocNum:Str12;
begin
  Result := oBtrTable.FieldByName('DocNum').AsString;
end;

procedure TAohBtr.WriteDocNum(pValue:Str12);
begin
  oBtrTable.FieldByName('DocNum').AsString := pValue;
end;

function TAohBtr.ReadExtNum:Str12;
begin
  Result := oBtrTable.FieldByName('ExtNum').AsString;
end;

procedure TAohBtr.WriteExtNum(pValue:Str12);
begin
  oBtrTable.FieldByName('ExtNum').AsString := pValue;
end;

function TAohBtr.ReadDocDate:TDatetime;
begin
  Result := oBtrTable.FieldByName('DocDate').AsDateTime;
end;

procedure TAohBtr.WriteDocDate(pValue:TDatetime);
begin
  oBtrTable.FieldByName('DocDate').AsDateTime := pValue;
end;

function TAohBtr.ReadBegDate:TDatetime;
begin
  Result := oBtrTable.FieldByName('BegDate').AsDateTime;
end;

procedure TAohBtr.WriteBegDate(pValue:TDatetime);
begin
  oBtrTable.FieldByName('BegDate').AsDateTime := pValue;
end;

function TAohBtr.ReadEndDate:TDatetime;
begin
  Result := oBtrTable.FieldByName('EndDate').AsDateTime;
end;

procedure TAohBtr.WriteEndDate(pValue:TDatetime);
begin
  oBtrTable.FieldByName('EndDate').AsDateTime := pValue;
end;

function TAohBtr.ReadPaCode:longint;
begin
  Result := oBtrTable.FieldByName('PaCode').AsInteger;
end;

procedure TAohBtr.WritePaCode(pValue:longint);
begin
  oBtrTable.FieldByName('PaCode').AsInteger := pValue;
end;

function TAohBtr.ReadPaName:Str30;
begin
  Result := oBtrTable.FieldByName('PaName').AsString;
end;

procedure TAohBtr.WritePaName(pValue:Str30);
begin
  oBtrTable.FieldByName('PaName').AsString := pValue;
end;

function TAohBtr.ReadPaName_:Str30;
begin
  Result := oBtrTable.FieldByName('PaName_').AsString;
end;

procedure TAohBtr.WritePaName_(pValue:Str30);
begin
  oBtrTable.FieldByName('PaName_').AsString := pValue;
end;

function TAohBtr.ReadRegName:Str60;
begin
  Result := oBtrTable.FieldByName('RegName').AsString;
end;

procedure TAohBtr.WriteRegName(pValue:Str60);
begin
  oBtrTable.FieldByName('RegName').AsString := pValue;
end;

function TAohBtr.ReadRegAddr:Str30;
begin
  Result := oBtrTable.FieldByName('RegAddr').AsString;
end;

procedure TAohBtr.WriteRegAddr(pValue:Str30);
begin
  oBtrTable.FieldByName('RegAddr').AsString := pValue;
end;

function TAohBtr.ReadRegZip:Str15;
begin
  Result := oBtrTable.FieldByName('RegZip').AsString;
end;

procedure TAohBtr.WriteRegZip(pValue:Str15);
begin
  oBtrTable.FieldByName('RegZip').AsString := pValue;
end;

function TAohBtr.ReadRegCty:Str3;
begin
  Result := oBtrTable.FieldByName('RegCty').AsString;
end;

procedure TAohBtr.WriteRegCty(pValue:Str3);
begin
  oBtrTable.FieldByName('RegCty').AsString := pValue;
end;

function TAohBtr.ReadRegCtn:Str30;
begin
  Result := oBtrTable.FieldByName('RegCtn').AsString;
end;

procedure TAohBtr.WriteRegCtn(pValue:Str30);
begin
  oBtrTable.FieldByName('RegCtn').AsString := pValue;
end;

function TAohBtr.ReadRegSta:Str2;
begin
  Result := oBtrTable.FieldByName('RegSta').AsString;
end;

procedure TAohBtr.WriteRegSta(pValue:Str2);
begin
  oBtrTable.FieldByName('RegSta').AsString := pValue;
end;

function TAohBtr.ReadRegIno:Str15;
begin
  Result := oBtrTable.FieldByName('RegIno').AsString;
end;

procedure TAohBtr.WriteRegIno(pValue:Str15);
begin
  oBtrTable.FieldByName('RegIno').AsString := pValue;
end;

function TAohBtr.ReadRegTin:Str15;
begin
  Result := oBtrTable.FieldByName('RegTin').AsString;
end;

procedure TAohBtr.WriteRegTin(pValue:Str15);
begin
  oBtrTable.FieldByName('RegTin').AsString := pValue;
end;

function TAohBtr.ReadRegVin:Str15;
begin
  Result := oBtrTable.FieldByName('RegVin').AsString;
end;

procedure TAohBtr.WriteRegVin(pValue:Str15);
begin
  oBtrTable.FieldByName('RegVin').AsString := pValue;
end;

function TAohBtr.ReadRegTel:Str20;
begin
  Result := oBtrTable.FieldByName('RegTel').AsString;
end;

procedure TAohBtr.WriteRegTel(pValue:Str20);
begin
  oBtrTable.FieldByName('RegTel').AsString := pValue;
end;

function TAohBtr.ReadRegFax:Str20;
begin
  Result := oBtrTable.FieldByName('RegFax').AsString;
end;

procedure TAohBtr.WriteRegFax(pValue:Str20);
begin
  oBtrTable.FieldByName('RegFax').AsString := pValue;
end;

function TAohBtr.ReadRegEml:Str30;
begin
  Result := oBtrTable.FieldByName('RegEml').AsString;
end;

procedure TAohBtr.WriteRegEml(pValue:Str30);
begin
  oBtrTable.FieldByName('RegEml').AsString := pValue;
end;

function TAohBtr.ReadDscPrc:double;
begin
  Result := oBtrTable.FieldByName('DscPrc').AsFloat;
end;

procedure TAohBtr.WriteDscPrc(pValue:double);
begin
  oBtrTable.FieldByName('DscPrc').AsFloat := pValue;
end;

function TAohBtr.ReadSurPrc:double;
begin
  Result := oBtrTable.FieldByName('SurPrc').AsFloat;
end;

procedure TAohBtr.WriteSurPrc(pValue:double);
begin
  oBtrTable.FieldByName('SurPrc').AsFloat := pValue;
end;

function TAohBtr.ReadPenPrc:double;
begin
  Result := oBtrTable.FieldByName('PenPrc').AsFloat;
end;

procedure TAohBtr.WritePenPrc(pValue:double);
begin
  oBtrTable.FieldByName('PenPrc').AsFloat := pValue;
end;

function TAohBtr.ReadRdiPrc:double;
begin
  Result := oBtrTable.FieldByName('RdiPrc').AsFloat;
end;

procedure TAohBtr.WriteRdiPrc(pValue:double);
begin
  oBtrTable.FieldByName('RdiPrc').AsFloat := pValue;
end;

function TAohBtr.ReadRduPrc:double;
begin
  Result := oBtrTable.FieldByName('RduPrc').AsFloat;
end;

procedure TAohBtr.WriteRduPrc(pValue:double);
begin
  oBtrTable.FieldByName('RduPrc').AsFloat := pValue;
end;

function TAohBtr.ReadSurVal:double;
begin
  Result := oBtrTable.FieldByName('SurVal').AsFloat;
end;

procedure TAohBtr.WriteSurVal(pValue:double);
begin
  oBtrTable.FieldByName('SurVal').AsFloat := pValue;
end;

function TAohBtr.ReadAgAValue:double;
begin
  Result := oBtrTable.FieldByName('AgAValue').AsFloat;
end;

procedure TAohBtr.WriteAgAValue(pValue:double);
begin
  oBtrTable.FieldByName('AgAValue').AsFloat := pValue;
end;

function TAohBtr.ReadAgBvalue:double;
begin
  Result := oBtrTable.FieldByName('AgBvalue').AsFloat;
end;

procedure TAohBtr.WriteAgBvalue(pValue:double);
begin
  oBtrTable.FieldByName('AgBvalue').AsFloat := pValue;
end;

function TAohBtr.ReadAsDValue:double;
begin
  Result := oBtrTable.FieldByName('AsDValue').AsFloat;
end;

procedure TAohBtr.WriteAsDValue(pValue:double);
begin
  oBtrTable.FieldByName('AsDValue').AsFloat := pValue;
end;

function TAohBtr.ReadAsHValue:double;
begin
  Result := oBtrTable.FieldByName('AsHValue').AsFloat;
end;

procedure TAohBtr.WriteAsHValue(pValue:double);
begin
  oBtrTable.FieldByName('AsHValue').AsFloat := pValue;
end;

function TAohBtr.ReadAsDdsVal:double;
begin
  Result := oBtrTable.FieldByName('AsDdsVal').AsFloat;
end;

procedure TAohBtr.WriteAsDdsVal(pValue:double);
begin
  oBtrTable.FieldByName('AsDdsVal').AsFloat := pValue;
end;

function TAohBtr.ReadAsHdsVal:double;
begin
  Result := oBtrTable.FieldByName('AsHdsVal').AsFloat;
end;

procedure TAohBtr.WriteAsHdsVal(pValue:double);
begin
  oBtrTable.FieldByName('AsHdsVal').AsFloat := pValue;
end;

function TAohBtr.ReadAsAValue:double;
begin
  Result := oBtrTable.FieldByName('AsAValue').AsFloat;
end;

procedure TAohBtr.WriteAsAValue(pValue:double);
begin
  oBtrTable.FieldByName('AsAValue').AsFloat := pValue;
end;

function TAohBtr.ReadAsBvalue:double;
begin
  Result := oBtrTable.FieldByName('AsBvalue').AsFloat;
end;

procedure TAohBtr.WriteAsBvalue(pValue:double);
begin
  oBtrTable.FieldByName('AsBvalue').AsFloat := pValue;
end;

function TAohBtr.ReadItmQnt:word;
begin
  Result := oBtrTable.FieldByName('ItmQnt').AsInteger;
end;

procedure TAohBtr.WriteItmQnt(pValue:word);
begin
  oBtrTable.FieldByName('ItmQnt').AsInteger := pValue;
end;

function TAohBtr.ReadPrnCnt:byte;
begin
  Result := oBtrTable.FieldByName('PrnCnt').AsInteger;
end;

procedure TAohBtr.WritePrnCnt(pValue:byte);
begin
  oBtrTable.FieldByName('PrnCnt').AsInteger := pValue;
end;

function TAohBtr.ReadDstLck:byte;
begin
  Result := oBtrTable.FieldByName('DstLck').AsInteger;
end;

procedure TAohBtr.WriteDstLck(pValue:byte);
begin
  oBtrTable.FieldByName('DstLck').AsInteger := pValue;
end;

function TAohBtr.ReadAmdNum:Str12;
begin
  Result := oBtrTable.FieldByName('AmdNum').AsString;
end;

procedure TAohBtr.WriteAmdNum(pValue:Str12);
begin
  oBtrTable.FieldByName('AmdNum').AsString := pValue;
end;

function TAohBtr.ReadAldNum:Str12;
begin
  Result := oBtrTable.FieldByName('AldNum').AsString;
end;

procedure TAohBtr.WriteAldNum(pValue:Str12);
begin
  oBtrTable.FieldByName('AldNum').AsString := pValue;
end;

function TAohBtr.ReadCanNum:word;
begin
  Result := oBtrTable.FieldByName('CanNum').AsInteger;
end;

procedure TAohBtr.WriteCanNum(pValue:word);
begin
  oBtrTable.FieldByName('CanNum').AsInteger := pValue;
end;

function TAohBtr.ReadCanTxt:Str30;
begin
  Result := oBtrTable.FieldByName('CanTxt').AsString;
end;

procedure TAohBtr.WriteCanTxt(pValue:Str30);
begin
  oBtrTable.FieldByName('CanTxt').AsString := pValue;
end;

function TAohBtr.ReadStatus:Str1;
begin
  Result := oBtrTable.FieldByName('Status').AsString;
end;

procedure TAohBtr.WriteStatus(pValue:Str1);
begin
  oBtrTable.FieldByName('Status').AsString := pValue;
end;

function TAohBtr.ReadCrtUser:Str8;
begin
  Result := oBtrTable.FieldByName('CrtUser').AsString;
end;

procedure TAohBtr.WriteCrtUser(pValue:Str8);
begin
  oBtrTable.FieldByName('CrtUser').AsString := pValue;
end;

function TAohBtr.ReadCrtDate:TDatetime;
begin
  Result := oBtrTable.FieldByName('CrtDate').AsDateTime;
end;

procedure TAohBtr.WriteCrtDate(pValue:TDatetime);
begin
  oBtrTable.FieldByName('CrtDate').AsDateTime := pValue;
end;

function TAohBtr.ReadCrtTime:TDatetime;
begin
  Result := oBtrTable.FieldByName('CrtTime').AsDateTime;
end;

procedure TAohBtr.WriteCrtTime(pValue:TDatetime);
begin
  oBtrTable.FieldByName('CrtTime').AsDateTime := pValue;
end;

function TAohBtr.ReadModUser:Str8;
begin
  Result := oBtrTable.FieldByName('ModUser').AsString;
end;

procedure TAohBtr.WriteModUser(pValue:Str8);
begin
  oBtrTable.FieldByName('ModUser').AsString := pValue;
end;

function TAohBtr.ReadModDate:TDatetime;
begin
  Result := oBtrTable.FieldByName('ModDate').AsDateTime;
end;

procedure TAohBtr.WriteModDate(pValue:TDatetime);
begin
  oBtrTable.FieldByName('ModDate').AsDateTime := pValue;
end;

function TAohBtr.ReadModTime:TDatetime;
begin
  Result := oBtrTable.FieldByName('ModTime').AsDateTime;
end;

procedure TAohBtr.WriteModTime(pValue:TDatetime);
begin
  oBtrTable.FieldByName('ModTime').AsDateTime := pValue;
end;

function TAohBtr.ReadYear:Str2;
begin
  Result := oBtrTable.FieldByName('Year').AsString;
end;

procedure TAohBtr.WriteYear(pValue:Str2);
begin
  oBtrTable.FieldByName('Year').AsString := pValue;
end;

// **************************************** PUBLIC ********************************************

function TAohBtr.Eof: boolean;
begin
  Result := oBtrTable.Eof;
end;

function TAohBtr.IsFirstRec: boolean;
begin
  Result := oBtrTable.Bof;
end;

function TAohBtr.IsLastRec: boolean;
begin
  Result := oBtrTable.Eof;
end;

function TAohBtr.Active: boolean;
begin
  Result := oBtrTable.Active;
end;

function TAohBtr.ActPos: longint;
begin
  Result := oBtrTable.ActPos;
end;

function TAohBtr.GotoPos (pActPos:longint): boolean;
begin
  Result := oBtrTable.GotoPos(pActPos);
end;

function TAohBtr.LocateYearSerNum (pYear:Str2;pSerNum:longint):boolean;
begin
  SetIndex (ixYearSerNum);
  Result := oBtrTable.FindKey([pYear,pSerNum]);
end;

function TAohBtr.LocateDocNum (pDocNum:Str12):boolean;
begin
  SetIndex (ixDocNum);
  Result := oBtrTable.FindKey([pDocNum]);
end;

function TAohBtr.LocateDoDate (pDocDate:TDatetime):boolean;
begin
  SetIndex (ixDoDate);
  Result := oBtrTable.FindKey([pDocDate]);
end;

function TAohBtr.LocatePaCode (pPaCode:longint):boolean;
begin
  SetIndex (ixPaCode);
  Result := oBtrTable.FindKey([pPaCode]);
end;

function TAohBtr.LocatePaName (pPaName_:Str30):boolean;
begin
  SetIndex (ixPaName);
  Result := oBtrTable.FindKey([StrToAlias(pPaName_)]);
end;

function TAohBtr.LocateAmdNum (pAmdNum:Str12):boolean;
begin
  SetIndex (ixAmdNum);
  Result := oBtrTable.FindKey([pAmdNum]);
end;

function TAohBtr.LocateAldNum (pAldNum:Str12):boolean;
begin
  SetIndex (ixAldNum);
  Result := oBtrTable.FindKey([pAldNum]);
end;

function TAohBtr.LocateStatus (pStatus:Str1):boolean;
begin
  SetIndex (ixStatus);
  Result := oBtrTable.FindKey([pStatus]);
end;

function TAohBtr.NearestYearSerNum (pYear:Str2;pSerNum:longint):boolean;
begin
  SetIndex (ixYearSerNum);
  Result := oBtrTable.FindNearest([pYear,pSerNum]);
end;

function TAohBtr.NearestDocNum (pDocNum:Str12):boolean;
begin
  SetIndex (ixDocNum);
  Result := oBtrTable.FindNearest([pDocNum]);
end;

function TAohBtr.NearestDoDate (pDocDate:TDatetime):boolean;
begin
  SetIndex (ixDoDate);
  Result := oBtrTable.FindNearest([pDocDate]);
end;

function TAohBtr.NearestPaCode (pPaCode:longint):boolean;
begin
  SetIndex (ixPaCode);
  Result := oBtrTable.FindNearest([pPaCode]);
end;

function TAohBtr.NearestPaName (pPaName_:Str30):boolean;
begin
  SetIndex (ixPaName);
  Result := oBtrTable.FindNearest([pPaName_]);
end;

function TAohBtr.NearestAmdNum (pAmdNum:Str12):boolean;
begin
  SetIndex (ixAmdNum);
  Result := oBtrTable.FindNearest([pAmdNum]);
end;

function TAohBtr.NearestAldNum (pAldNum:Str12):boolean;
begin
  SetIndex (ixAldNum);
  Result := oBtrTable.FindNearest([pAldNum]);
end;

function TAohBtr.NearestStatus (pStatus:Str1):boolean;
begin
  SetIndex (ixStatus);
  Result := oBtrTable.FindNearest([pStatus]);
end;

procedure TAohBtr.SetIndex (pIndexName:ShortString);
begin
  If oBtrTable.IndexName<>pIndexName then oBtrTable.IndexName := pIndexName;
end;

procedure TAohBtr.Open(pBookNum:Str5);
begin
  oBookNum := pBookNum;
  oBtrTable.Open(pBookNum);
end;

procedure TAohBtr.Close;
begin
  If oBtrTable.Active then oBtrTable.Close;
end;

procedure TAohBtr.Prior;
begin
  oBtrTable.Prior;
end;

procedure TAohBtr.Next;
begin
  oBtrTable.Next;
end;

procedure TAohBtr.First;
begin
  oBtrTable.First;
end;

procedure TAohBtr.Last;
begin
  oBtrTable.Last;
end;

procedure TAohBtr.Insert;
begin
  oBtrTable.Insert;
end;

procedure TAohBtr.Edit;
begin
  oBtrTable.Edit;
end;

procedure TAohBtr.Post;
begin
  oBtrTable.Post;
end;

procedure TAohBtr.Delete;
begin
  oBtrTable.Delete;
end;

procedure TAohBtr.SwapIndex;
begin
  oBtrTable.SwapIndex;
end;

procedure TAohBtr.RestoreIndex;
begin
  oBtrTable.RestoreIndex;
end;

procedure TAohBtr.SwapStatus;
begin
  oBtrTable.SwapStatus;
end;

procedure TAohBtr.RestoreStatus;
begin
  oBtrTable.RestoreStatus;
end;

procedure TAohBtr.EnableControls;
begin
  oBtrTable.EnableControls;
end;

procedure TAohBtr.DisableControls;
begin
  oBtrTable.DisableControls;
end;

end.
