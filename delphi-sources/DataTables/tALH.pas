unit tALH;

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
  ixStatus = 'Status';

type
  TAlhTmp = class (TComponent)
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
    function  ReadEndDate:TDatetime;     procedure WriteEndDate (pValue:TDatetime);
    function  ReadRetDate:TDatetime;     procedure WriteRetDate (pValue:TDatetime);
    function  ReadIcdDate:TDatetime;     procedure WriteIcdDate (pValue:TDatetime);
    function  ReadPaCode:longint;        procedure WritePaCode (pValue:longint);
    function  ReadPaName:Str30;          procedure WritePaName (pValue:Str30);
    function  ReadPaName_:Str30;         procedure WritePaName_ (pValue:Str30);
    function  ReadRegName:Str60;         procedure WriteRegName (pValue:Str60);
    function  ReadRegAddr:Str30;         procedure WriteRegAddr (pValue:Str30);
    function  ReadRegZip:Str15;          procedure WriteRegZip (pValue:Str15);
    function  ReadRegCty:Str3;           procedure WriteRegCty (pValue:Str3);
    function  ReadRegCtn:Str30;          procedure WriteRegCtn (pValue:Str30);
    function  ReadRegSta:Str2;           procedure WriteRegSta (pValue:Str2);
    function  ReadRegTel:Str15;          procedure WriteRegTel (pValue:Str15);
    function  ReadRegFax:Str15;          procedure WriteRegFax (pValue:Str15);
    function  ReadRegEml:Str15;          procedure WriteRegEml (pValue:Str15);
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
    function  ReadAgBValue:double;       procedure WriteAgBValue (pValue:double);
    function  ReadAsDValue:double;       procedure WriteAsDValue (pValue:double);
    function  ReadAsHValue:double;       procedure WriteAsHValue (pValue:double);
    function  ReadAsDdsVal:double;       procedure WriteAsDdsVal (pValue:double);
    function  ReadAsHdsVal:double;       procedure WriteAsHdsVal (pValue:double);
    function  ReadAsAValue:double;       procedure WriteAsAValue (pValue:double);
    function  ReadAsBvalue:double;       procedure WriteAsBvalue (pValue:double);
    function  ReadInSurVal:double;       procedure WriteInSurVal (pValue:double);
    function  ReadReSurVal:double;       procedure WriteReSurVal (pValue:double);
    function  ReadCsiDoc:Str12;          procedure WriteCsiDoc (pValue:Str12);
    function  ReadCseDoc:Str12;          procedure WriteCseDoc (pValue:Str12);
    function  ReadAmdNum:Str12;          procedure WriteAmdNum (pValue:Str12);
    function  ReadAodNum:Str12;          procedure WriteAodNum (pValue:Str12);
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
  public
    // Elementarne databazove operacie
    function Eof: boolean;
    function Active: boolean;
    function LocateDocNum (pDocNum:Str12):boolean;
    function LocateSerNum (pSerNum:longint):boolean;
    function LocateDocDate (pDocDate:TDatetime):boolean;
    function LocatePaCode (pPaCode:longint):boolean;
    function LocatePaName_ (pPaName_:Str30):boolean;
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
    property EndDate:TDatetime read ReadEndDate write WriteEndDate;
    property RetDate:TDatetime read ReadRetDate write WriteRetDate;
    property IcdDate:TDatetime read ReadIcdDate write WriteIcdDate;
    property PaCode:longint read ReadPaCode write WritePaCode;
    property PaName:Str30 read ReadPaName write WritePaName;
    property PaName_:Str30 read ReadPaName_ write WritePaName_;
    property RegName:Str60 read ReadRegName write WriteRegName;
    property RegAddr:Str30 read ReadRegAddr write WriteRegAddr;
    property RegZip:Str15 read ReadRegZip write WriteRegZip;
    property RegCty:Str3 read ReadRegCty write WriteRegCty;
    property RegCtn:Str30 read ReadRegCtn write WriteRegCtn;
    property RegSta:Str2 read ReadRegSta write WriteRegSta;
    property RegTel:Str15 read ReadRegTel write WriteRegTel;
    property RegFax:Str15 read ReadRegFax write WriteRegFax;
    property RegEml:Str15 read ReadRegEml write WriteRegEml;
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
    property AgBValue:double read ReadAgBValue write WriteAgBValue;
    property AsDValue:double read ReadAsDValue write WriteAsDValue;
    property AsHValue:double read ReadAsHValue write WriteAsHValue;
    property AsDdsVal:double read ReadAsDdsVal write WriteAsDdsVal;
    property AsHdsVal:double read ReadAsHdsVal write WriteAsHdsVal;
    property AsAValue:double read ReadAsAValue write WriteAsAValue;
    property AsBvalue:double read ReadAsBvalue write WriteAsBvalue;
    property InSurVal:double read ReadInSurVal write WriteInSurVal;
    property ReSurVal:double read ReadReSurVal write WriteReSurVal;
    property CsiDoc:Str12 read ReadCsiDoc write WriteCsiDoc;
    property CseDoc:Str12 read ReadCseDoc write WriteCseDoc;
    property AmdNum:Str12 read ReadAmdNum write WriteAmdNum;
    property AodNum:Str12 read ReadAodNum write WriteAodNum;
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
  end;

implementation

constructor TAlhTmp.Create;
begin
  oTmpTable := TmpInit ('ALH',Self);
end;

destructor TAlhTmp.Destroy;
begin
  If oTmpTable.Active then oTmpTable.Close;
  FreeAndNil (oTmpTable);
end;

// *************************************** PRIVATE ********************************************

function TAlhTmp.ReadCount:integer;
begin
  Result := oTmpTable.RecordCount;
end;

function TAlhTmp.FieldExist (pFieldName:ShortString): boolean;
begin
  Result := oTmpTable.FindField(pFieldName)<>nil;
end;

function TAlhTmp.ReadDocNum:Str12;
begin
  Result := oTmpTable.FieldByName('DocNum').AsString;
end;

procedure TAlhTmp.WriteDocNum(pValue:Str12);
begin
  oTmpTable.FieldByName('DocNum').AsString := pValue;
end;

function TAlhTmp.ReadYear:Str2;
begin
  Result := oTmpTable.FieldByName('Year').AsString;
end;

procedure TAlhTmp.WriteYear(pValue:Str2);
begin
  oTmpTable.FieldByName('Year').AsString := pValue;
end;

function TAlhTmp.ReadSerNum:longint;
begin
  Result := oTmpTable.FieldByName('SerNum').AsInteger;
end;

procedure TAlhTmp.WriteSerNum(pValue:longint);
begin
  oTmpTable.FieldByName('SerNum').AsInteger := pValue;
end;

function TAlhTmp.ReadExtNum:Str12;
begin
  Result := oTmpTable.FieldByName('ExtNum').AsString;
end;

procedure TAlhTmp.WriteExtNum(pValue:Str12);
begin
  oTmpTable.FieldByName('ExtNum').AsString := pValue;
end;

function TAlhTmp.ReadDocDate:TDatetime;
begin
  Result := oTmpTable.FieldByName('DocDate').AsDateTime;
end;

procedure TAlhTmp.WriteDocDate(pValue:TDatetime);
begin
  oTmpTable.FieldByName('DocDate').AsDateTime := pValue;
end;

function TAlhTmp.ReadEndDate:TDatetime;
begin
  Result := oTmpTable.FieldByName('EndDate').AsDateTime;
end;

procedure TAlhTmp.WriteEndDate(pValue:TDatetime);
begin
  oTmpTable.FieldByName('EndDate').AsDateTime := pValue;
end;

function TAlhTmp.ReadRetDate:TDatetime;
begin
  Result := oTmpTable.FieldByName('RetDate').AsDateTime;
end;

procedure TAlhTmp.WriteRetDate(pValue:TDatetime);
begin
  oTmpTable.FieldByName('RetDate').AsDateTime := pValue;
end;

function TAlhTmp.ReadIcdDate:TDatetime;
begin
  Result := oTmpTable.FieldByName('IcdDate').AsDateTime;
end;

procedure TAlhTmp.WriteIcdDate(pValue:TDatetime);
begin
  oTmpTable.FieldByName('IcdDate').AsDateTime := pValue;
end;

function TAlhTmp.ReadPaCode:longint;
begin
  Result := oTmpTable.FieldByName('PaCode').AsInteger;
end;

procedure TAlhTmp.WritePaCode(pValue:longint);
begin
  oTmpTable.FieldByName('PaCode').AsInteger := pValue;
end;

function TAlhTmp.ReadPaName:Str30;
begin
  Result := oTmpTable.FieldByName('PaName').AsString;
end;

procedure TAlhTmp.WritePaName(pValue:Str30);
begin
  oTmpTable.FieldByName('PaName').AsString := pValue;
end;

function TAlhTmp.ReadPaName_:Str30;
begin
  Result := oTmpTable.FieldByName('PaName_').AsString;
end;

procedure TAlhTmp.WritePaName_(pValue:Str30);
begin
  oTmpTable.FieldByName('PaName_').AsString := pValue;
end;

function TAlhTmp.ReadRegName:Str60;
begin
  Result := oTmpTable.FieldByName('RegName').AsString;
end;

procedure TAlhTmp.WriteRegName(pValue:Str60);
begin
  oTmpTable.FieldByName('RegName').AsString := pValue;
end;

function TAlhTmp.ReadRegAddr:Str30;
begin
  Result := oTmpTable.FieldByName('RegAddr').AsString;
end;

procedure TAlhTmp.WriteRegAddr(pValue:Str30);
begin
  oTmpTable.FieldByName('RegAddr').AsString := pValue;
end;

function TAlhTmp.ReadRegZip:Str15;
begin
  Result := oTmpTable.FieldByName('RegZip').AsString;
end;

procedure TAlhTmp.WriteRegZip(pValue:Str15);
begin
  oTmpTable.FieldByName('RegZip').AsString := pValue;
end;

function TAlhTmp.ReadRegCty:Str3;
begin
  Result := oTmpTable.FieldByName('RegCty').AsString;
end;

procedure TAlhTmp.WriteRegCty(pValue:Str3);
begin
  oTmpTable.FieldByName('RegCty').AsString := pValue;
end;

function TAlhTmp.ReadRegCtn:Str30;
begin
  Result := oTmpTable.FieldByName('RegCtn').AsString;
end;

procedure TAlhTmp.WriteRegCtn(pValue:Str30);
begin
  oTmpTable.FieldByName('RegCtn').AsString := pValue;
end;

function TAlhTmp.ReadRegSta:Str2;
begin
  Result := oTmpTable.FieldByName('RegSta').AsString;
end;

procedure TAlhTmp.WriteRegSta(pValue:Str2);
begin
  oTmpTable.FieldByName('RegSta').AsString := pValue;
end;

function TAlhTmp.ReadRegTel:Str15;
begin
  Result := oTmpTable.FieldByName('RegTel').AsString;
end;

procedure TAlhTmp.WriteRegTel(pValue:Str15);
begin
  oTmpTable.FieldByName('RegTel').AsString := pValue;
end;

function TAlhTmp.ReadRegFax:Str15;
begin
  Result := oTmpTable.FieldByName('RegFax').AsString;
end;

procedure TAlhTmp.WriteRegFax(pValue:Str15);
begin
  oTmpTable.FieldByName('RegFax').AsString := pValue;
end;

function TAlhTmp.ReadRegEml:Str15;
begin
  Result := oTmpTable.FieldByName('RegEml').AsString;
end;

procedure TAlhTmp.WriteRegEml(pValue:Str15);
begin
  oTmpTable.FieldByName('RegEml').AsString := pValue;
end;

function TAlhTmp.ReadRegIno:Str15;
begin
  Result := oTmpTable.FieldByName('RegIno').AsString;
end;

procedure TAlhTmp.WriteRegIno(pValue:Str15);
begin
  oTmpTable.FieldByName('RegIno').AsString := pValue;
end;

function TAlhTmp.ReadRegTin:Str15;
begin
  Result := oTmpTable.FieldByName('RegTin').AsString;
end;

procedure TAlhTmp.WriteRegTin(pValue:Str15);
begin
  oTmpTable.FieldByName('RegTin').AsString := pValue;
end;

function TAlhTmp.ReadRegVin:Str15;
begin
  Result := oTmpTable.FieldByName('RegVin').AsString;
end;

procedure TAlhTmp.WriteRegVin(pValue:Str15);
begin
  oTmpTable.FieldByName('RegVin').AsString := pValue;
end;

function TAlhTmp.ReadBaCont:Str30;
begin
  Result := oTmpTable.FieldByName('BaCont').AsString;
end;

procedure TAlhTmp.WriteBaCont(pValue:Str30);
begin
  oTmpTable.FieldByName('BaCont').AsString := pValue;
end;

function TAlhTmp.ReadBaName:Str30;
begin
  Result := oTmpTable.FieldByName('BaName').AsString;
end;

procedure TAlhTmp.WriteBaName(pValue:Str30);
begin
  oTmpTable.FieldByName('BaName').AsString := pValue;
end;

function TAlhTmp.ReadDscPrc:double;
begin
  Result := oTmpTable.FieldByName('DscPrc').AsFloat;
end;

procedure TAlhTmp.WriteDscPrc(pValue:double);
begin
  oTmpTable.FieldByName('DscPrc').AsFloat := pValue;
end;

function TAlhTmp.ReadSurPrc:double;
begin
  Result := oTmpTable.FieldByName('SurPrc').AsFloat;
end;

procedure TAlhTmp.WriteSurPrc(pValue:double);
begin
  oTmpTable.FieldByName('SurPrc').AsFloat := pValue;
end;

function TAlhTmp.ReadPenPrc:double;
begin
  Result := oTmpTable.FieldByName('PenPrc').AsFloat;
end;

procedure TAlhTmp.WritePenPrc(pValue:double);
begin
  oTmpTable.FieldByName('PenPrc').AsFloat := pValue;
end;

function TAlhTmp.ReadRdiPrc:double;
begin
  Result := oTmpTable.FieldByName('RdiPrc').AsFloat;
end;

procedure TAlhTmp.WriteRdiPrc(pValue:double);
begin
  oTmpTable.FieldByName('RdiPrc').AsFloat := pValue;
end;

function TAlhTmp.ReadRduPrc:double;
begin
  Result := oTmpTable.FieldByName('RduPrc').AsFloat;
end;

procedure TAlhTmp.WriteRduPrc(pValue:double);
begin
  oTmpTable.FieldByName('RduPrc').AsFloat := pValue;
end;

function TAlhTmp.ReadSurVal:double;
begin
  Result := oTmpTable.FieldByName('SurVal').AsFloat;
end;

procedure TAlhTmp.WriteSurVal(pValue:double);
begin
  oTmpTable.FieldByName('SurVal').AsFloat := pValue;
end;

function TAlhTmp.ReadChPenVal:double;
begin
  Result := oTmpTable.FieldByName('ChPenVal').AsFloat;
end;

procedure TAlhTmp.WriteChPenVal(pValue:double);
begin
  oTmpTable.FieldByName('ChPenVal').AsFloat := pValue;
end;

function TAlhTmp.ReadChRdiVal:double;
begin
  Result := oTmpTable.FieldByName('ChRdiVal').AsFloat;
end;

procedure TAlhTmp.WriteChRdiVal(pValue:double);
begin
  oTmpTable.FieldByName('ChRdiVal').AsFloat := pValue;
end;

function TAlhTmp.ReadChRduVal:double;
begin
  Result := oTmpTable.FieldByName('ChRduVal').AsFloat;
end;

procedure TAlhTmp.WriteChRduVal(pValue:double);
begin
  oTmpTable.FieldByName('ChRduVal').AsFloat := pValue;
end;

function TAlhTmp.ReadAgAValue:double;
begin
  Result := oTmpTable.FieldByName('AgAValue').AsFloat;
end;

procedure TAlhTmp.WriteAgAValue(pValue:double);
begin
  oTmpTable.FieldByName('AgAValue').AsFloat := pValue;
end;

function TAlhTmp.ReadAgBValue:double;
begin
  Result := oTmpTable.FieldByName('AgBValue').AsFloat;
end;

procedure TAlhTmp.WriteAgBValue(pValue:double);
begin
  oTmpTable.FieldByName('AgBValue').AsFloat := pValue;
end;

function TAlhTmp.ReadAsDValue:double;
begin
  Result := oTmpTable.FieldByName('AsDValue').AsFloat;
end;

procedure TAlhTmp.WriteAsDValue(pValue:double);
begin
  oTmpTable.FieldByName('AsDValue').AsFloat := pValue;
end;

function TAlhTmp.ReadAsHValue:double;
begin
  Result := oTmpTable.FieldByName('AsHValue').AsFloat;
end;

procedure TAlhTmp.WriteAsHValue(pValue:double);
begin
  oTmpTable.FieldByName('AsHValue').AsFloat := pValue;
end;

function TAlhTmp.ReadAsDdsVal:double;
begin
  Result := oTmpTable.FieldByName('AsDdsVal').AsFloat;
end;

procedure TAlhTmp.WriteAsDdsVal(pValue:double);
begin
  oTmpTable.FieldByName('AsDdsVal').AsFloat := pValue;
end;

function TAlhTmp.ReadAsHdsVal:double;
begin
  Result := oTmpTable.FieldByName('AsHdsVal').AsFloat;
end;

procedure TAlhTmp.WriteAsHdsVal(pValue:double);
begin
  oTmpTable.FieldByName('AsHdsVal').AsFloat := pValue;
end;

function TAlhTmp.ReadAsAValue:double;
begin
  Result := oTmpTable.FieldByName('AsAValue').AsFloat;
end;

procedure TAlhTmp.WriteAsAValue(pValue:double);
begin
  oTmpTable.FieldByName('AsAValue').AsFloat := pValue;
end;

function TAlhTmp.ReadAsBvalue:double;
begin
  Result := oTmpTable.FieldByName('AsBvalue').AsFloat;
end;

procedure TAlhTmp.WriteAsBvalue(pValue:double);
begin
  oTmpTable.FieldByName('AsBvalue').AsFloat := pValue;
end;

function TAlhTmp.ReadInSurVal:double;
begin
  Result := oTmpTable.FieldByName('InSurVal').AsFloat;
end;

procedure TAlhTmp.WriteInSurVal(pValue:double);
begin
  oTmpTable.FieldByName('InSurVal').AsFloat := pValue;
end;

function TAlhTmp.ReadReSurVal:double;
begin
  Result := oTmpTable.FieldByName('ReSurVal').AsFloat;
end;

procedure TAlhTmp.WriteReSurVal(pValue:double);
begin
  oTmpTable.FieldByName('ReSurVal').AsFloat := pValue;
end;

function TAlhTmp.ReadCsiDoc:Str12;
begin
  Result := oTmpTable.FieldByName('CsiDoc').AsString;
end;

procedure TAlhTmp.WriteCsiDoc(pValue:Str12);
begin
  oTmpTable.FieldByName('CsiDoc').AsString := pValue;
end;

function TAlhTmp.ReadCseDoc:Str12;
begin
  Result := oTmpTable.FieldByName('CseDoc').AsString;
end;

procedure TAlhTmp.WriteCseDoc(pValue:Str12);
begin
  oTmpTable.FieldByName('CseDoc').AsString := pValue;
end;

function TAlhTmp.ReadAmdNum:Str12;
begin
  Result := oTmpTable.FieldByName('AmdNum').AsString;
end;

procedure TAlhTmp.WriteAmdNum(pValue:Str12);
begin
  oTmpTable.FieldByName('AmdNum').AsString := pValue;
end;

function TAlhTmp.ReadAodNum:Str12;
begin
  Result := oTmpTable.FieldByName('AodNum').AsString;
end;

procedure TAlhTmp.WriteAodNum(pValue:Str12);
begin
  oTmpTable.FieldByName('AodNum').AsString := pValue;
end;

function TAlhTmp.ReadIcdNum:Str12;
begin
  Result := oTmpTable.FieldByName('IcdNum').AsString;
end;

procedure TAlhTmp.WriteIcdNum(pValue:Str12);
begin
  oTmpTable.FieldByName('IcdNum').AsString := pValue;
end;

function TAlhTmp.ReadItmQnt:word;
begin
  Result := oTmpTable.FieldByName('ItmQnt').AsInteger;
end;

procedure TAlhTmp.WriteItmQnt(pValue:word);
begin
  oTmpTable.FieldByName('ItmQnt').AsInteger := pValue;
end;

function TAlhTmp.ReadPrnCnt:byte;
begin
  Result := oTmpTable.FieldByName('PrnCnt').AsInteger;
end;

procedure TAlhTmp.WritePrnCnt(pValue:byte);
begin
  oTmpTable.FieldByName('PrnCnt').AsInteger := pValue;
end;

function TAlhTmp.ReadDstLck:byte;
begin
  Result := oTmpTable.FieldByName('DstLck').AsInteger;
end;

procedure TAlhTmp.WriteDstLck(pValue:byte);
begin
  oTmpTable.FieldByName('DstLck').AsInteger := pValue;
end;

function TAlhTmp.ReadStatus:Str1;
begin
  Result := oTmpTable.FieldByName('Status').AsString;
end;

procedure TAlhTmp.WriteStatus(pValue:Str1);
begin
  oTmpTable.FieldByName('Status').AsString := pValue;
end;

function TAlhTmp.ReadCrtUser:Str8;
begin
  Result := oTmpTable.FieldByName('CrtUser').AsString;
end;

procedure TAlhTmp.WriteCrtUser(pValue:Str8);
begin
  oTmpTable.FieldByName('CrtUser').AsString := pValue;
end;

function TAlhTmp.ReadCrtDate:TDatetime;
begin
  Result := oTmpTable.FieldByName('CrtDate').AsDateTime;
end;

procedure TAlhTmp.WriteCrtDate(pValue:TDatetime);
begin
  oTmpTable.FieldByName('CrtDate').AsDateTime := pValue;
end;

function TAlhTmp.ReadCrtTime:TDatetime;
begin
  Result := oTmpTable.FieldByName('CrtTime').AsDateTime;
end;

procedure TAlhTmp.WriteCrtTime(pValue:TDatetime);
begin
  oTmpTable.FieldByName('CrtTime').AsDateTime := pValue;
end;

function TAlhTmp.ReadModUser:Str8;
begin
  Result := oTmpTable.FieldByName('ModUser').AsString;
end;

procedure TAlhTmp.WriteModUser(pValue:Str8);
begin
  oTmpTable.FieldByName('ModUser').AsString := pValue;
end;

function TAlhTmp.ReadModDate:TDatetime;
begin
  Result := oTmpTable.FieldByName('ModDate').AsDateTime;
end;

procedure TAlhTmp.WriteModDate(pValue:TDatetime);
begin
  oTmpTable.FieldByName('ModDate').AsDateTime := pValue;
end;

function TAlhTmp.ReadModTime:TDatetime;
begin
  Result := oTmpTable.FieldByName('ModTime').AsDateTime;
end;

procedure TAlhTmp.WriteModTime(pValue:TDatetime);
begin
  oTmpTable.FieldByName('ModTime').AsDateTime := pValue;
end;

// **************************************** PUBLIC ********************************************

function TAlhTmp.Eof: boolean;
begin
  Result := oTmpTable.Eof;
end;

function TAlhTmp.Active: boolean;
begin
  Result := oTmpTable.Active;
end;

function TAlhTmp.LocateDocNum (pDocNum:Str12):boolean;
begin
  SetIndex (ixDocNum);
  Result := oTmpTable.FindKey([pDocNum]);
end;

function TAlhTmp.LocateSerNum (pSerNum:longint):boolean;
begin
  SetIndex (ixSerNum);
  Result := oTmpTable.FindKey([pSerNum]);
end;

function TAlhTmp.LocateDocDate (pDocDate:TDatetime):boolean;
begin
  SetIndex (ixDocDate);
  Result := oTmpTable.FindKey([pDocDate]);
end;

function TAlhTmp.LocatePaCode (pPaCode:longint):boolean;
begin
  SetIndex (ixPaCode);
  Result := oTmpTable.FindKey([pPaCode]);
end;

function TAlhTmp.LocatePaName_ (pPaName_:Str30):boolean;
begin
  SetIndex (ixPaName_);
  Result := oTmpTable.FindKey([pPaName_]);
end;

function TAlhTmp.LocateStatus (pStatus:Str1):boolean;
begin
  SetIndex (ixStatus);
  Result := oTmpTable.FindKey([pStatus]);
end;

procedure TAlhTmp.SetIndex (pIndexName:ShortString);
begin
  If oTmpTable.IndexName<>pIndexName then oTmpTable.IndexName := pIndexName;
end;

procedure TAlhTmp.Open;
begin
  oTmpTable.Open;
end;

procedure TAlhTmp.Close;
begin
  If oTmpTable.Active then oTmpTable.Close;
end;

procedure TAlhTmp.Prior;
begin
  oTmpTable.Prior;
end;

procedure TAlhTmp.Next;
begin
  oTmpTable.Next;
end;

procedure TAlhTmp.First;
begin
  oTmpTable.First;
end;

procedure TAlhTmp.Last;
begin
  oTmpTable.Last;
end;

procedure TAlhTmp.Insert;
begin
  oTmpTable.Insert;
end;

procedure TAlhTmp.Edit;
begin
  oTmpTable.Edit;
end;

procedure TAlhTmp.Post;
var mEdit:boolean;
begin
  oTmpTable.Post;
end;

procedure TAlhTmp.Delete;
begin
  oTmpTable.Delete;
end;

procedure TAlhTmp.SwapIndex;
begin
  oTmpTable.SwapIndex;
end;

procedure TAlhTmp.RestoreIndex;
begin
  oTmpTable.RestoreIndex;
end;

procedure TAlhTmp.SwapStatus;
begin
  oTmpTable.SwapStatus;
end;

procedure TAlhTmp.RestoreStatus;
begin
  oTmpTable.RestoreStatus;
end;

procedure TAlhTmp.EnableControls;
begin
  oTmpTable.EnableControls;
end;

procedure TAlhTmp.DisableControls;
begin
  oTmpTable.DisableControls;
end;

end.
