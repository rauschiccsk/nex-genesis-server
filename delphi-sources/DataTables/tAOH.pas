unit tAOH;

interface

uses
  IcTypes, IcConv, NexPath, NexGlob, DocHand, 
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls,
  Dialogs, DB, NexBtrTable, DBTables, NexPxTable;

const
  ixDocNum = '';
  ixSerNum = 'SerNum';
  ixDocDate = 'DocDate';
  ixPaCode = 'PaCode';
  ixPaName_ = 'PaName_';
  ixAmdNum = 'AmdNum';
  ixAldNum = 'AldNum';
  ixStatus = 'Status';

type
  TAohTmp = class (TComponent)
    constructor Create;
    destructor  Destroy; override;
  private
    oTmpTable: TNexPxTable;
    function ReadCount:integer;
    function FieldExist (pFieldName:ShortString): boolean;
    // Pristup k databazovym poliam
    function  ReadDocNum:Str12;          procedure WriteDocNum (pValue:Str12);
    function  ReadYear:Str2;             procedure WriteYear (pValue:Str2);
    function  ReadSerNum:longint;        procedure WriteSerNum (pValue:longint);
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
  public
    // Elementarne databazove operacie
    function Eof: boolean;
    function Active: boolean;
    function LocateDocNum (pDocNum:Str12):boolean;
    function LocateSerNum (pSerNum:longint):boolean;
    function LocateDocDate (pDocDate:TDatetime):boolean;
    function LocatePaCode (pPaCode:longint):boolean;
    function LocatePaName_ (pPaName_:Str30):boolean;
    function LocateAmdNum (pAmdNum:Str12):boolean;
    function LocateAldNum (pAldNum:Str12):boolean;
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
    property DocNum:Str12 read ReadDocNum write WriteDocNum;
    property Year:Str2 read ReadYear write WriteYear;
    property SerNum:longint read ReadSerNum write WriteSerNum;
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
  end;

implementation

constructor TAohTmp.Create;
begin
  oTmpTable := TmpInit ('AOH',Self);
end;

destructor TAohTmp.Destroy;
begin
  If oTmpTable.Active then oTmpTable.Close;
  FreeAndNil (oTmpTable);
end;

// *************************************** PRIVATE ********************************************

function TAohTmp.ReadCount:integer;
begin
  Result := oTmpTable.RecordCount;
end;

function TAohTmp.FieldExist (pFieldName:ShortString): boolean;
begin
  Result := oTmpTable.FindField(pFieldName)<>nil;
end;

function TAohTmp.ReadDocNum:Str12;
begin
  Result := oTmpTable.FieldByName('DocNum').AsString;
end;

procedure TAohTmp.WriteDocNum(pValue:Str12);
begin
  oTmpTable.FieldByName('DocNum').AsString := pValue;
end;

function TAohTmp.ReadYear:Str2;
begin
  Result := oTmpTable.FieldByName('Year').AsString;
end;

procedure TAohTmp.WriteYear(pValue:Str2);
begin
  oTmpTable.FieldByName('Year').AsString := pValue;
end;

function TAohTmp.ReadSerNum:longint;
begin
  Result := oTmpTable.FieldByName('SerNum').AsInteger;
end;

procedure TAohTmp.WriteSerNum(pValue:longint);
begin
  oTmpTable.FieldByName('SerNum').AsInteger := pValue;
end;

function TAohTmp.ReadExtNum:Str12;
begin
  Result := oTmpTable.FieldByName('ExtNum').AsString;
end;

procedure TAohTmp.WriteExtNum(pValue:Str12);
begin
  oTmpTable.FieldByName('ExtNum').AsString := pValue;
end;

function TAohTmp.ReadDocDate:TDatetime;
begin
  Result := oTmpTable.FieldByName('DocDate').AsDateTime;
end;

procedure TAohTmp.WriteDocDate(pValue:TDatetime);
begin
  oTmpTable.FieldByName('DocDate').AsDateTime := pValue;
end;

function TAohTmp.ReadBegDate:TDatetime;
begin
  Result := oTmpTable.FieldByName('BegDate').AsDateTime;
end;

procedure TAohTmp.WriteBegDate(pValue:TDatetime);
begin
  oTmpTable.FieldByName('BegDate').AsDateTime := pValue;
end;

function TAohTmp.ReadEndDate:TDatetime;
begin
  Result := oTmpTable.FieldByName('EndDate').AsDateTime;
end;

procedure TAohTmp.WriteEndDate(pValue:TDatetime);
begin
  oTmpTable.FieldByName('EndDate').AsDateTime := pValue;
end;

function TAohTmp.ReadPaCode:longint;
begin
  Result := oTmpTable.FieldByName('PaCode').AsInteger;
end;

procedure TAohTmp.WritePaCode(pValue:longint);
begin
  oTmpTable.FieldByName('PaCode').AsInteger := pValue;
end;

function TAohTmp.ReadPaName:Str30;
begin
  Result := oTmpTable.FieldByName('PaName').AsString;
end;

procedure TAohTmp.WritePaName(pValue:Str30);
begin
  oTmpTable.FieldByName('PaName').AsString := pValue;
end;

function TAohTmp.ReadPaName_:Str30;
begin
  Result := oTmpTable.FieldByName('PaName_').AsString;
end;

procedure TAohTmp.WritePaName_(pValue:Str30);
begin
  oTmpTable.FieldByName('PaName_').AsString := pValue;
end;

function TAohTmp.ReadRegName:Str60;
begin
  Result := oTmpTable.FieldByName('RegName').AsString;
end;

procedure TAohTmp.WriteRegName(pValue:Str60);
begin
  oTmpTable.FieldByName('RegName').AsString := pValue;
end;

function TAohTmp.ReadRegAddr:Str30;
begin
  Result := oTmpTable.FieldByName('RegAddr').AsString;
end;

procedure TAohTmp.WriteRegAddr(pValue:Str30);
begin
  oTmpTable.FieldByName('RegAddr').AsString := pValue;
end;

function TAohTmp.ReadRegZip:Str15;
begin
  Result := oTmpTable.FieldByName('RegZip').AsString;
end;

procedure TAohTmp.WriteRegZip(pValue:Str15);
begin
  oTmpTable.FieldByName('RegZip').AsString := pValue;
end;

function TAohTmp.ReadRegCty:Str3;
begin
  Result := oTmpTable.FieldByName('RegCty').AsString;
end;

procedure TAohTmp.WriteRegCty(pValue:Str3);
begin
  oTmpTable.FieldByName('RegCty').AsString := pValue;
end;

function TAohTmp.ReadRegCtn:Str30;
begin
  Result := oTmpTable.FieldByName('RegCtn').AsString;
end;

procedure TAohTmp.WriteRegCtn(pValue:Str30);
begin
  oTmpTable.FieldByName('RegCtn').AsString := pValue;
end;

function TAohTmp.ReadRegSta:Str2;
begin
  Result := oTmpTable.FieldByName('RegSta').AsString;
end;

procedure TAohTmp.WriteRegSta(pValue:Str2);
begin
  oTmpTable.FieldByName('RegSta').AsString := pValue;
end;

function TAohTmp.ReadRegIno:Str15;
begin
  Result := oTmpTable.FieldByName('RegIno').AsString;
end;

procedure TAohTmp.WriteRegIno(pValue:Str15);
begin
  oTmpTable.FieldByName('RegIno').AsString := pValue;
end;

function TAohTmp.ReadRegTin:Str15;
begin
  Result := oTmpTable.FieldByName('RegTin').AsString;
end;

procedure TAohTmp.WriteRegTin(pValue:Str15);
begin
  oTmpTable.FieldByName('RegTin').AsString := pValue;
end;

function TAohTmp.ReadRegVin:Str15;
begin
  Result := oTmpTable.FieldByName('RegVin').AsString;
end;

procedure TAohTmp.WriteRegVin(pValue:Str15);
begin
  oTmpTable.FieldByName('RegVin').AsString := pValue;
end;

function TAohTmp.ReadRegTel:Str20;
begin
  Result := oTmpTable.FieldByName('RegTel').AsString;
end;

procedure TAohTmp.WriteRegTel(pValue:Str20);
begin
  oTmpTable.FieldByName('RegTel').AsString := pValue;
end;

function TAohTmp.ReadRegFax:Str20;
begin
  Result := oTmpTable.FieldByName('RegFax').AsString;
end;

procedure TAohTmp.WriteRegFax(pValue:Str20);
begin
  oTmpTable.FieldByName('RegFax').AsString := pValue;
end;

function TAohTmp.ReadRegEml:Str30;
begin
  Result := oTmpTable.FieldByName('RegEml').AsString;
end;

procedure TAohTmp.WriteRegEml(pValue:Str30);
begin
  oTmpTable.FieldByName('RegEml').AsString := pValue;
end;

function TAohTmp.ReadDscPrc:double;
begin
  Result := oTmpTable.FieldByName('DscPrc').AsFloat;
end;

procedure TAohTmp.WriteDscPrc(pValue:double);
begin
  oTmpTable.FieldByName('DscPrc').AsFloat := pValue;
end;

function TAohTmp.ReadSurPrc:double;
begin
  Result := oTmpTable.FieldByName('SurPrc').AsFloat;
end;

procedure TAohTmp.WriteSurPrc(pValue:double);
begin
  oTmpTable.FieldByName('SurPrc').AsFloat := pValue;
end;

function TAohTmp.ReadPenPrc:double;
begin
  Result := oTmpTable.FieldByName('PenPrc').AsFloat;
end;

procedure TAohTmp.WritePenPrc(pValue:double);
begin
  oTmpTable.FieldByName('PenPrc').AsFloat := pValue;
end;

function TAohTmp.ReadRdiPrc:double;
begin
  Result := oTmpTable.FieldByName('RdiPrc').AsFloat;
end;

procedure TAohTmp.WriteRdiPrc(pValue:double);
begin
  oTmpTable.FieldByName('RdiPrc').AsFloat := pValue;
end;

function TAohTmp.ReadRduPrc:double;
begin
  Result := oTmpTable.FieldByName('RduPrc').AsFloat;
end;

procedure TAohTmp.WriteRduPrc(pValue:double);
begin
  oTmpTable.FieldByName('RduPrc').AsFloat := pValue;
end;

function TAohTmp.ReadSurVal:double;
begin
  Result := oTmpTable.FieldByName('SurVal').AsFloat;
end;

procedure TAohTmp.WriteSurVal(pValue:double);
begin
  oTmpTable.FieldByName('SurVal').AsFloat := pValue;
end;

function TAohTmp.ReadAgAValue:double;
begin
  Result := oTmpTable.FieldByName('AgAValue').AsFloat;
end;

procedure TAohTmp.WriteAgAValue(pValue:double);
begin
  oTmpTable.FieldByName('AgAValue').AsFloat := pValue;
end;

function TAohTmp.ReadAgBvalue:double;
begin
  Result := oTmpTable.FieldByName('AgBvalue').AsFloat;
end;

procedure TAohTmp.WriteAgBvalue(pValue:double);
begin
  oTmpTable.FieldByName('AgBvalue').AsFloat := pValue;
end;

function TAohTmp.ReadAsDValue:double;
begin
  Result := oTmpTable.FieldByName('AsDValue').AsFloat;
end;

procedure TAohTmp.WriteAsDValue(pValue:double);
begin
  oTmpTable.FieldByName('AsDValue').AsFloat := pValue;
end;

function TAohTmp.ReadAsHValue:double;
begin
  Result := oTmpTable.FieldByName('AsHValue').AsFloat;
end;

procedure TAohTmp.WriteAsHValue(pValue:double);
begin
  oTmpTable.FieldByName('AsHValue').AsFloat := pValue;
end;

function TAohTmp.ReadAsDdsVal:double;
begin
  Result := oTmpTable.FieldByName('AsDdsVal').AsFloat;
end;

procedure TAohTmp.WriteAsDdsVal(pValue:double);
begin
  oTmpTable.FieldByName('AsDdsVal').AsFloat := pValue;
end;

function TAohTmp.ReadAsHdsVal:double;
begin
  Result := oTmpTable.FieldByName('AsHdsVal').AsFloat;
end;

procedure TAohTmp.WriteAsHdsVal(pValue:double);
begin
  oTmpTable.FieldByName('AsHdsVal').AsFloat := pValue;
end;

function TAohTmp.ReadAsAValue:double;
begin
  Result := oTmpTable.FieldByName('AsAValue').AsFloat;
end;

procedure TAohTmp.WriteAsAValue(pValue:double);
begin
  oTmpTable.FieldByName('AsAValue').AsFloat := pValue;
end;

function TAohTmp.ReadAsBvalue:double;
begin
  Result := oTmpTable.FieldByName('AsBvalue').AsFloat;
end;

procedure TAohTmp.WriteAsBvalue(pValue:double);
begin
  oTmpTable.FieldByName('AsBvalue').AsFloat := pValue;
end;

function TAohTmp.ReadItmQnt:word;
begin
  Result := oTmpTable.FieldByName('ItmQnt').AsInteger;
end;

procedure TAohTmp.WriteItmQnt(pValue:word);
begin
  oTmpTable.FieldByName('ItmQnt').AsInteger := pValue;
end;

function TAohTmp.ReadPrnCnt:byte;
begin
  Result := oTmpTable.FieldByName('PrnCnt').AsInteger;
end;

procedure TAohTmp.WritePrnCnt(pValue:byte);
begin
  oTmpTable.FieldByName('PrnCnt').AsInteger := pValue;
end;

function TAohTmp.ReadDstLck:byte;
begin
  Result := oTmpTable.FieldByName('DstLck').AsInteger;
end;

procedure TAohTmp.WriteDstLck(pValue:byte);
begin
  oTmpTable.FieldByName('DstLck').AsInteger := pValue;
end;

function TAohTmp.ReadAmdNum:Str12;
begin
  Result := oTmpTable.FieldByName('AmdNum').AsString;
end;

procedure TAohTmp.WriteAmdNum(pValue:Str12);
begin
  oTmpTable.FieldByName('AmdNum').AsString := pValue;
end;

function TAohTmp.ReadAldNum:Str12;
begin
  Result := oTmpTable.FieldByName('AldNum').AsString;
end;

procedure TAohTmp.WriteAldNum(pValue:Str12);
begin
  oTmpTable.FieldByName('AldNum').AsString := pValue;
end;

function TAohTmp.ReadCanNum:word;
begin
  Result := oTmpTable.FieldByName('CanNum').AsInteger;
end;

procedure TAohTmp.WriteCanNum(pValue:word);
begin
  oTmpTable.FieldByName('CanNum').AsInteger := pValue;
end;

function TAohTmp.ReadCanTxt:Str30;
begin
  Result := oTmpTable.FieldByName('CanTxt').AsString;
end;

procedure TAohTmp.WriteCanTxt(pValue:Str30);
begin
  oTmpTable.FieldByName('CanTxt').AsString := pValue;
end;

function TAohTmp.ReadStatus:Str1;
begin
  Result := oTmpTable.FieldByName('Status').AsString;
end;

procedure TAohTmp.WriteStatus(pValue:Str1);
begin
  oTmpTable.FieldByName('Status').AsString := pValue;
end;

function TAohTmp.ReadCrtUser:Str8;
begin
  Result := oTmpTable.FieldByName('CrtUser').AsString;
end;

procedure TAohTmp.WriteCrtUser(pValue:Str8);
begin
  oTmpTable.FieldByName('CrtUser').AsString := pValue;
end;

function TAohTmp.ReadCrtDate:TDatetime;
begin
  Result := oTmpTable.FieldByName('CrtDate').AsDateTime;
end;

procedure TAohTmp.WriteCrtDate(pValue:TDatetime);
begin
  oTmpTable.FieldByName('CrtDate').AsDateTime := pValue;
end;

function TAohTmp.ReadCrtTime:TDatetime;
begin
  Result := oTmpTable.FieldByName('CrtTime').AsDateTime;
end;

procedure TAohTmp.WriteCrtTime(pValue:TDatetime);
begin
  oTmpTable.FieldByName('CrtTime').AsDateTime := pValue;
end;

function TAohTmp.ReadModUser:Str8;
begin
  Result := oTmpTable.FieldByName('ModUser').AsString;
end;

procedure TAohTmp.WriteModUser(pValue:Str8);
begin
  oTmpTable.FieldByName('ModUser').AsString := pValue;
end;

function TAohTmp.ReadModDate:TDatetime;
begin
  Result := oTmpTable.FieldByName('ModDate').AsDateTime;
end;

procedure TAohTmp.WriteModDate(pValue:TDatetime);
begin
  oTmpTable.FieldByName('ModDate').AsDateTime := pValue;
end;

function TAohTmp.ReadModTime:TDatetime;
begin
  Result := oTmpTable.FieldByName('ModTime').AsDateTime;
end;

procedure TAohTmp.WriteModTime(pValue:TDatetime);
begin
  oTmpTable.FieldByName('ModTime').AsDateTime := pValue;
end;

// **************************************** PUBLIC ********************************************

function TAohTmp.Eof: boolean;
begin
  Result := oTmpTable.Eof;
end;

function TAohTmp.Active: boolean;
begin
  Result := oTmpTable.Active;
end;

function TAohTmp.LocateDocNum (pDocNum:Str12):boolean;
begin
  SetIndex (ixDocNum);
  Result := oTmpTable.FindKey([pDocNum]);
end;

function TAohTmp.LocateSerNum (pSerNum:longint):boolean;
begin
  SetIndex (ixSerNum);
  Result := oTmpTable.FindKey([pSerNum]);
end;

function TAohTmp.LocateDocDate (pDocDate:TDatetime):boolean;
begin
  SetIndex (ixDocDate);
  Result := oTmpTable.FindKey([pDocDate]);
end;

function TAohTmp.LocatePaCode (pPaCode:longint):boolean;
begin
  SetIndex (ixPaCode);
  Result := oTmpTable.FindKey([pPaCode]);
end;

function TAohTmp.LocatePaName_ (pPaName_:Str30):boolean;
begin
  SetIndex (ixPaName_);
  Result := oTmpTable.FindKey([pPaName_]);
end;

function TAohTmp.LocateAmdNum (pAmdNum:Str12):boolean;
begin
  SetIndex (ixAmdNum);
  Result := oTmpTable.FindKey([pAmdNum]);
end;

function TAohTmp.LocateAldNum (pAldNum:Str12):boolean;
begin
  SetIndex (ixAldNum);
  Result := oTmpTable.FindKey([pAldNum]);
end;

function TAohTmp.LocateStatus (pStatus:Str1):boolean;
begin
  SetIndex (ixStatus);
  Result := oTmpTable.FindKey([pStatus]);
end;

procedure TAohTmp.SetIndex (pIndexName:ShortString);
begin
  If oTmpTable.IndexName<>pIndexName then oTmpTable.IndexName := pIndexName;
end;

procedure TAohTmp.Open;
begin
  oTmpTable.Open;
end;

procedure TAohTmp.Close;
begin
  If oTmpTable.Active then oTmpTable.Close;
end;

procedure TAohTmp.Prior;
begin
  oTmpTable.Prior;
end;

procedure TAohTmp.Next;
begin
  oTmpTable.Next;
end;

procedure TAohTmp.First;
begin
  oTmpTable.First;
end;

procedure TAohTmp.Last;
begin
  oTmpTable.Last;
end;

procedure TAohTmp.Insert;
begin
  oTmpTable.Insert;
end;

procedure TAohTmp.Edit;
begin
  oTmpTable.Edit;
end;

procedure TAohTmp.Post;
var mEdit:boolean;
begin
  oTmpTable.Post;
end;

procedure TAohTmp.Delete;
begin
  oTmpTable.Delete;
end;

procedure TAohTmp.SwapIndex;
begin
  oTmpTable.SwapIndex;
end;

procedure TAohTmp.RestoreIndex;
begin
  oTmpTable.RestoreIndex;
end;

procedure TAohTmp.SwapStatus;
begin
  oTmpTable.SwapStatus;
end;

procedure TAohTmp.RestoreStatus;
begin
  oTmpTable.RestoreStatus;
end;

procedure TAohTmp.EnableControls;
begin
  oTmpTable.EnableControls;
end;

procedure TAohTmp.DisableControls;
begin
  oTmpTable.DisableControls;
end;

end.
