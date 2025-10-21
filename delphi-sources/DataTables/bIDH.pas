unit bIDH;

interface

uses
  IcTypes, IcConv, NexPath, NexGlob,
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls,
  Dialogs, DB, NexBtrTable, DBTables, NexPxTable;

const
  ixDocNum = 'DocNum';
  ixExtNum = 'ExtNum';
  ixDescribe = 'Describe';
  ixDocVal = 'DocVal';
  ixPaCode = 'PaCode';
  ixPaName = 'PaName';
  ixConDoc = 'ConDoc';
  ixYearSerNum = 'YearSerNum';
  ixDocDate = 'DocDate';
  ixDstAcc = 'DstAcc';

type
  TIdhBtr = class (TComponent)
    constructor Create; overload;
    destructor  Destroy; override;
  private
    oBookNum: Str5;
    oBtrTable: TNexBtrTable;
    function ReadCount:integer;
    function FieldExist (pFieldName:ShortString): boolean;
    // Pristup k databazovym poliam
    function  Readx_AccMth:Str4;         procedure Writex_AccMth (pValue:Str4);
    function  ReadWriNum:word;           procedure WriteWriNum (pValue:word);
    function  ReadSerNum:longint;        procedure WriteSerNum (pValue:longint);
    function  ReadDocNum:Str12;          procedure WriteDocNum (pValue:Str12);
    function  ReadExtNum:Str12;          procedure WriteExtNum (pValue:Str12);
    function  ReadDocDate:TDatetime;     procedure WriteDocDate (pValue:TDatetime);
    function  ReadPaCode:longint;        procedure WritePaCode (pValue:longint);
    function  Readx_PaSCode:longint;     procedure Writex_PaSCode (pValue:longint);
    function  ReadPaName:Str30;          procedure WritePaName (pValue:Str30);
    function  ReadPaName_:Str30;         procedure WritePaName_ (pValue:Str30);
    function  ReadDescribe:Str30;        procedure WriteDescribe (pValue:Str30);
    function  ReadDescribe_:Str30;       procedure WriteDescribe_ (pValue:Str30);
    function  ReadItmQnt:longint;        procedure WriteItmQnt (pValue:longint);
    function  ReadDocVal:double;         procedure WriteDocVal (pValue:double);
    function  ReadPrnCnt:word;           procedure WritePrnCnt (pValue:word);
    function  Readx_Reserve:Str1;        procedure Writex_Reserve (pValue:Str1);
    function  ReadVatCls:byte;           procedure WriteVatCls (pValue:byte);
    function  ReadCredVal:double;        procedure WriteCredVal (pValue:double);
    function  ReadDebVal:double;         procedure WriteDebVal (pValue:double);
    function  ReadSndStat:Str1;          procedure WriteSndStat (pValue:Str1);
    function  Readx_Status10:Str1;       procedure Writex_Status10 (pValue:Str1);
    function  Readx_Status11:Str1;       procedure Writex_Status11 (pValue:Str1);
    function  Readx_Status12:Str1;       procedure Writex_Status12 (pValue:Str1);
    function  ReadDstDif:Str1;           procedure WriteDstDif (pValue:Str1);
    function  ReadDstAcc:Str1;           procedure WriteDstAcc (pValue:Str1);
    function  ReadModNum:word;           procedure WriteModNum (pValue:word);
    function  ReadDocType:byte;          procedure WriteDocType (pValue:byte);
    function  ReadCrtUser:Str8;          procedure WriteCrtUser (pValue:Str8);
    function  ReadCrtDate:TDatetime;     procedure WriteCrtDate (pValue:TDatetime);
    function  ReadCrtTime:TDatetime;     procedure WriteCrtTime (pValue:TDatetime);
    function  ReadModUser:Str8;          procedure WriteModUser (pValue:Str8);
    function  ReadModDate:TDatetime;     procedure WriteModDate (pValue:TDatetime);
    function  ReadModTime:TDatetime;     procedure WriteModTime (pValue:TDatetime);
    function  Readx_IBkNum:Str5;         procedure Writex_IBkNum (pValue:Str5);
    function  ReadDstLck:byte;           procedure WriteDstLck (pValue:byte);
    function  ReadConDoc:Str12;          procedure WriteConDoc (pValue:Str12);
    function  ReadCAccSnt:Str3;          procedure WriteCAccSnt (pValue:Str3);
    function  ReadCAccAnl:Str6;          procedure WriteCAccAnl (pValue:Str6);
    function  ReadDAccSnt:Str3;          procedure WriteDAccSnt (pValue:Str3);
    function  ReadDAccAnl:Str6;          procedure WriteDAccAnl (pValue:Str6);
    function  ReadAccUser:Str8;          procedure WriteAccUser (pValue:Str8);
    function  ReadAccDate:TDatetime;     procedure WriteAccDate (pValue:TDatetime);
    function  ReadVtcSpc:byte;           procedure WriteVtcSpc (pValue:byte);
    function  ReadVatPrc1:byte;          procedure WriteVatPrc1 (pValue:byte);
    function  ReadVatPrc2:byte;          procedure WriteVatPrc2 (pValue:byte);
    function  ReadVatPrc3:byte;          procedure WriteVatPrc3 (pValue:byte);
    function  ReadAcAValue1:double;      procedure WriteAcAValue1 (pValue:double);
    function  ReadAcAValue2:double;      procedure WriteAcAValue2 (pValue:double);
    function  ReadAcAValue3:double;      procedure WriteAcAValue3 (pValue:double);
    function  ReadAcVatVal1:double;      procedure WriteAcVatVal1 (pValue:double);
    function  ReadAcVatVal2:double;      procedure WriteAcVatVal2 (pValue:double);
    function  ReadAcVatVal3:double;      procedure WriteAcVatVal3 (pValue:double);
    function  ReadAcAValue:double;       procedure WriteAcAValue (pValue:double);
    function  ReadAcVatVal:double;       procedure WriteAcVatVal (pValue:double);
    function  ReadAcBValue:double;       procedure WriteAcBValue (pValue:double);
    function  ReadYear:Str2;             procedure WriteYear (pValue:Str2);
    function  ReadVatPrc4:byte;          procedure WriteVatPrc4 (pValue:byte);
    function  ReadAcAValue4:double;      procedure WriteAcAValue4 (pValue:double);
    function  ReadAcVatVal4:double;      procedure WriteAcVatVal4 (pValue:double);
    function  ReadVatPrc5:byte;          procedure WriteVatPrc5 (pValue:byte);
    function  ReadAcAValue5:double;      procedure WriteAcAValue5 (pValue:double);
    function  ReadAcVatVal5:double;      procedure WriteAcVatVal5 (pValue:double);
  public
    constructor Create(pPath:ShortString); overload;
    // Elementarne databazove operacie
    function Eof: boolean;
    function IsFirstRec: boolean;
    function IsLastRec: boolean;
    function Active: boolean;
    function ActPos: longint;
    function GotoPos (pActPos:longint): boolean;
    function LocateDocNum (pDocNum:Str12):boolean;
    function LocateExtNum (pExtNum:Str12):boolean;
    function LocateDescribe (pDescribe_:Str30):boolean;
    function LocateDocVal (pDocVal:double):boolean;
    function LocatePaCode (pPaCode:longint):boolean;
    function LocatePaName (pPaName_:Str30):boolean;
    function LocateConDoc (pConDoc:Str12):boolean;
    function LocateYearSerNum (pYear:Str2;pSerNum:longint):boolean;
    function LocateDocDate (pDocDate:TDatetime):boolean;
    function LocateDstAcc (pDstAcc:Str1):boolean;
    function NearestDocNum (pDocNum:Str12):boolean;
    function NearestExtNum (pExtNum:Str12):boolean;
    function NearestDescribe (pDescribe_:Str30):boolean;
    function NearestDocVal (pDocVal:double):boolean;
    function NearestPaCode (pPaCode:longint):boolean;
    function NearestPaName (pPaName_:Str30):boolean;
    function NearestConDoc (pConDoc:Str12):boolean;
    function NearestYearSerNum (pYear:Str2;pSerNum:longint):boolean;
    function NearestDocDate (pDocDate:TDatetime):boolean;
    function NearestDstAcc (pDstAcc:Str1):boolean;

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
    property x_AccMth:Str4 read Readx_AccMth write Writex_AccMth;
    property WriNum:word read ReadWriNum write WriteWriNum;
    property SerNum:longint read ReadSerNum write WriteSerNum;
    property DocNum:Str12 read ReadDocNum write WriteDocNum;
    property ExtNum:Str12 read ReadExtNum write WriteExtNum;
    property DocDate:TDatetime read ReadDocDate write WriteDocDate;
    property PaCode:longint read ReadPaCode write WritePaCode;
    property x_PaSCode:longint read Readx_PaSCode write Writex_PaSCode;
    property PaName:Str30 read ReadPaName write WritePaName;
    property PaName_:Str30 read ReadPaName_ write WritePaName_;
    property Describe:Str30 read ReadDescribe write WriteDescribe;
    property Describe_:Str30 read ReadDescribe_ write WriteDescribe_;
    property ItmQnt:longint read ReadItmQnt write WriteItmQnt;
    property DocVal:double read ReadDocVal write WriteDocVal;
    property PrnCnt:word read ReadPrnCnt write WritePrnCnt;
    property x_Reserve:Str1 read Readx_Reserve write Writex_Reserve;
    property VatCls:byte read ReadVatCls write WriteVatCls;
    property CredVal:double read ReadCredVal write WriteCredVal;
    property DebVal:double read ReadDebVal write WriteDebVal;
    property SndStat:Str1 read ReadSndStat write WriteSndStat;
    property x_Status10:Str1 read Readx_Status10 write Writex_Status10;
    property x_Status11:Str1 read Readx_Status11 write Writex_Status11;
    property x_Status12:Str1 read Readx_Status12 write Writex_Status12;
    property DstDif:Str1 read ReadDstDif write WriteDstDif;
    property DstAcc:Str1 read ReadDstAcc write WriteDstAcc;
    property ModNum:word read ReadModNum write WriteModNum;
    property DocType:byte read ReadDocType write WriteDocType;
    property CrtUser:Str8 read ReadCrtUser write WriteCrtUser;
    property CrtDate:TDatetime read ReadCrtDate write WriteCrtDate;
    property CrtTime:TDatetime read ReadCrtTime write WriteCrtTime;
    property ModUser:Str8 read ReadModUser write WriteModUser;
    property ModDate:TDatetime read ReadModDate write WriteModDate;
    property ModTime:TDatetime read ReadModTime write WriteModTime;
    property x_IBkNum:Str5 read Readx_IBkNum write Writex_IBkNum;
    property DstLck:byte read ReadDstLck write WriteDstLck;
    property ConDoc:Str12 read ReadConDoc write WriteConDoc;
    property CAccSnt:Str3 read ReadCAccSnt write WriteCAccSnt;
    property CAccAnl:Str6 read ReadCAccAnl write WriteCAccAnl;
    property DAccSnt:Str3 read ReadDAccSnt write WriteDAccSnt;
    property DAccAnl:Str6 read ReadDAccAnl write WriteDAccAnl;
    property AccUser:Str8 read ReadAccUser write WriteAccUser;
    property AccDate:TDatetime read ReadAccDate write WriteAccDate;
    property VtcSpc:byte read ReadVtcSpc write WriteVtcSpc;
    property VatPrc1:byte read ReadVatPrc1 write WriteVatPrc1;
    property VatPrc2:byte read ReadVatPrc2 write WriteVatPrc2;
    property VatPrc3:byte read ReadVatPrc3 write WriteVatPrc3;
    property AcAValue1:double read ReadAcAValue1 write WriteAcAValue1;
    property AcAValue2:double read ReadAcAValue2 write WriteAcAValue2;
    property AcAValue3:double read ReadAcAValue3 write WriteAcAValue3;
    property AcVatVal1:double read ReadAcVatVal1 write WriteAcVatVal1;
    property AcVatVal2:double read ReadAcVatVal2 write WriteAcVatVal2;
    property AcVatVal3:double read ReadAcVatVal3 write WriteAcVatVal3;
    property AcAValue:double read ReadAcAValue write WriteAcAValue;
    property AcVatVal:double read ReadAcVatVal write WriteAcVatVal;
    property AcBValue:double read ReadAcBValue write WriteAcBValue;
    property Year:Str2 read ReadYear write WriteYear;
    property VatPrc4:byte read ReadVatPrc4 write WriteVatPrc4;
    property AcAValue4:double read ReadAcAValue4 write WriteAcAValue4;
    property AcVatVal4:double read ReadAcVatVal4 write WriteAcVatVal4;
    property VatPrc5:byte read ReadVatPrc5 write WriteVatPrc5;
    property AcAValue5:double read ReadAcAValue5 write WriteAcAValue5;
    property AcVatVal5:double read ReadAcVatVal5 write WriteAcVatVal5;
  end;

implementation

constructor TIdhBtr.Create;
begin
  oBtrTable := BtrInit ('IDH',gPath.LdgPath,Self);
end;

constructor TIdhBtr.Create(pPath:ShortString);
begin
  oBtrTable := BtrInit ('IDH',pPath,Self);
end;

destructor TIdhBtr.Destroy;
begin
  oBtrTable.Close;  FreeAndNil (oBtrTable);
end;

// *************************************** PRIVATE ********************************************

function TIdhBtr.ReadCount:integer;
begin
  Result := oBtrTable.RecordCount;
end;

function TIdhBtr.FieldExist (pFieldName:ShortString): boolean;
begin
  Result := oBtrTable.FindField(pFieldName)<>nil;
end;

function TIdhBtr.Readx_AccMth:Str4;
begin
  Result := oBtrTable.FieldByName('x_AccMth').AsString;
end;

procedure TIdhBtr.Writex_AccMth(pValue:Str4);
begin
  oBtrTable.FieldByName('x_AccMth').AsString := pValue;
end;

function TIdhBtr.ReadWriNum:word;
begin
  Result := oBtrTable.FieldByName('WriNum').AsInteger;
end;

procedure TIdhBtr.WriteWriNum(pValue:word);
begin
  oBtrTable.FieldByName('WriNum').AsInteger := pValue;
end;

function TIdhBtr.ReadSerNum:longint;
begin
  Result := oBtrTable.FieldByName('SerNum').AsInteger;
end;

procedure TIdhBtr.WriteSerNum(pValue:longint);
begin
  oBtrTable.FieldByName('SerNum').AsInteger := pValue;
end;

function TIdhBtr.ReadDocNum:Str12;
begin
  Result := oBtrTable.FieldByName('DocNum').AsString;
end;

procedure TIdhBtr.WriteDocNum(pValue:Str12);
begin
  oBtrTable.FieldByName('DocNum').AsString := pValue;
end;

function TIdhBtr.ReadExtNum:Str12;
begin
  Result := oBtrTable.FieldByName('ExtNum').AsString;
end;

procedure TIdhBtr.WriteExtNum(pValue:Str12);
begin
  oBtrTable.FieldByName('ExtNum').AsString := pValue;
end;

function TIdhBtr.ReadDocDate:TDatetime;
begin
  Result := oBtrTable.FieldByName('DocDate').AsDateTime;
end;

procedure TIdhBtr.WriteDocDate(pValue:TDatetime);
begin
  oBtrTable.FieldByName('DocDate').AsDateTime := pValue;
end;

function TIdhBtr.ReadPaCode:longint;
begin
  Result := oBtrTable.FieldByName('PaCode').AsInteger;
end;

procedure TIdhBtr.WritePaCode(pValue:longint);
begin
  oBtrTable.FieldByName('PaCode').AsInteger := pValue;
end;

function TIdhBtr.Readx_PaSCode:longint;
begin
  Result := oBtrTable.FieldByName('x_PaSCode').AsInteger;
end;

procedure TIdhBtr.Writex_PaSCode(pValue:longint);
begin
  oBtrTable.FieldByName('x_PaSCode').AsInteger := pValue;
end;

function TIdhBtr.ReadPaName:Str30;
begin
  Result := oBtrTable.FieldByName('PaName').AsString;
end;

procedure TIdhBtr.WritePaName(pValue:Str30);
begin
  oBtrTable.FieldByName('PaName').AsString := pValue;
end;

function TIdhBtr.ReadPaName_:Str30;
begin
  Result := oBtrTable.FieldByName('PaName_').AsString;
end;

procedure TIdhBtr.WritePaName_(pValue:Str30);
begin
  oBtrTable.FieldByName('PaName_').AsString := pValue;
end;

function TIdhBtr.ReadDescribe:Str30;
begin
  Result := oBtrTable.FieldByName('Describe').AsString;
end;

procedure TIdhBtr.WriteDescribe(pValue:Str30);
begin
  oBtrTable.FieldByName('Describe').AsString := pValue;
end;

function TIdhBtr.ReadDescribe_:Str30;
begin
  Result := oBtrTable.FieldByName('Describe_').AsString;
end;

procedure TIdhBtr.WriteDescribe_(pValue:Str30);
begin
  oBtrTable.FieldByName('Describe_').AsString := pValue;
end;

function TIdhBtr.ReadItmQnt:longint;
begin
  Result := oBtrTable.FieldByName('ItmQnt').AsInteger;
end;

procedure TIdhBtr.WriteItmQnt(pValue:longint);
begin
  oBtrTable.FieldByName('ItmQnt').AsInteger := pValue;
end;

function TIdhBtr.ReadDocVal:double;
begin
  Result := oBtrTable.FieldByName('DocVal').AsFloat;
end;

procedure TIdhBtr.WriteDocVal(pValue:double);
begin
  oBtrTable.FieldByName('DocVal').AsFloat := pValue;
end;

function TIdhBtr.ReadPrnCnt:word;
begin
  Result := oBtrTable.FieldByName('PrnCnt').AsInteger;
end;

procedure TIdhBtr.WritePrnCnt(pValue:word);
begin
  oBtrTable.FieldByName('PrnCnt').AsInteger := pValue;
end;

function TIdhBtr.Readx_Reserve:Str1;
begin
  Result := oBtrTable.FieldByName('x_Reserve').AsString;
end;

procedure TIdhBtr.Writex_Reserve(pValue:Str1);
begin
  oBtrTable.FieldByName('x_Reserve').AsString := pValue;
end;

function TIdhBtr.ReadVatCls:byte;
begin
  Result := oBtrTable.FieldByName('VatCls').AsInteger;
end;

procedure TIdhBtr.WriteVatCls(pValue:byte);
begin
  oBtrTable.FieldByName('VatCls').AsInteger := pValue;
end;

function TIdhBtr.ReadCredVal:double;
begin
  Result := oBtrTable.FieldByName('CredVal').AsFloat;
end;

procedure TIdhBtr.WriteCredVal(pValue:double);
begin
  oBtrTable.FieldByName('CredVal').AsFloat := pValue;
end;

function TIdhBtr.ReadDebVal:double;
begin
  Result := oBtrTable.FieldByName('DebVal').AsFloat;
end;

procedure TIdhBtr.WriteDebVal(pValue:double);
begin
  oBtrTable.FieldByName('DebVal').AsFloat := pValue;
end;

function TIdhBtr.ReadSndStat:Str1;
begin
  Result := oBtrTable.FieldByName('SndStat').AsString;
end;

procedure TIdhBtr.WriteSndStat(pValue:Str1);
begin
  oBtrTable.FieldByName('SndStat').AsString := pValue;
end;

function TIdhBtr.Readx_Status10:Str1;
begin
  Result := oBtrTable.FieldByName('x_Status10').AsString;
end;

procedure TIdhBtr.Writex_Status10(pValue:Str1);
begin
  oBtrTable.FieldByName('x_Status10').AsString := pValue;
end;

function TIdhBtr.Readx_Status11:Str1;
begin
  Result := oBtrTable.FieldByName('x_Status11').AsString;
end;

procedure TIdhBtr.Writex_Status11(pValue:Str1);
begin
  oBtrTable.FieldByName('x_Status11').AsString := pValue;
end;

function TIdhBtr.Readx_Status12:Str1;
begin
  Result := oBtrTable.FieldByName('x_Status12').AsString;
end;

procedure TIdhBtr.Writex_Status12(pValue:Str1);
begin
  oBtrTable.FieldByName('x_Status12').AsString := pValue;
end;

function TIdhBtr.ReadDstDif:Str1;
begin
  Result := oBtrTable.FieldByName('DstDif').AsString;
end;

procedure TIdhBtr.WriteDstDif(pValue:Str1);
begin
  oBtrTable.FieldByName('DstDif').AsString := pValue;
end;

function TIdhBtr.ReadDstAcc:Str1;
begin
  Result := oBtrTable.FieldByName('DstAcc').AsString;
end;

procedure TIdhBtr.WriteDstAcc(pValue:Str1);
begin
  oBtrTable.FieldByName('DstAcc').AsString := pValue;
end;

function TIdhBtr.ReadModNum:word;
begin
  Result := oBtrTable.FieldByName('ModNum').AsInteger;
end;

procedure TIdhBtr.WriteModNum(pValue:word);
begin
  oBtrTable.FieldByName('ModNum').AsInteger := pValue;
end;

function TIdhBtr.ReadDocType:byte;
begin
  Result := oBtrTable.FieldByName('DocType').AsInteger;
end;

procedure TIdhBtr.WriteDocType(pValue:byte);
begin
  oBtrTable.FieldByName('DocType').AsInteger := pValue;
end;

function TIdhBtr.ReadCrtUser:Str8;
begin
  Result := oBtrTable.FieldByName('CrtUser').AsString;
end;

procedure TIdhBtr.WriteCrtUser(pValue:Str8);
begin
  oBtrTable.FieldByName('CrtUser').AsString := pValue;
end;

function TIdhBtr.ReadCrtDate:TDatetime;
begin
  Result := oBtrTable.FieldByName('CrtDate').AsDateTime;
end;

procedure TIdhBtr.WriteCrtDate(pValue:TDatetime);
begin
  oBtrTable.FieldByName('CrtDate').AsDateTime := pValue;
end;

function TIdhBtr.ReadCrtTime:TDatetime;
begin
  Result := oBtrTable.FieldByName('CrtTime').AsDateTime;
end;

procedure TIdhBtr.WriteCrtTime(pValue:TDatetime);
begin
  oBtrTable.FieldByName('CrtTime').AsDateTime := pValue;
end;

function TIdhBtr.ReadModUser:Str8;
begin
  Result := oBtrTable.FieldByName('ModUser').AsString;
end;

procedure TIdhBtr.WriteModUser(pValue:Str8);
begin
  oBtrTable.FieldByName('ModUser').AsString := pValue;
end;

function TIdhBtr.ReadModDate:TDatetime;
begin
  Result := oBtrTable.FieldByName('ModDate').AsDateTime;
end;

procedure TIdhBtr.WriteModDate(pValue:TDatetime);
begin
  oBtrTable.FieldByName('ModDate').AsDateTime := pValue;
end;

function TIdhBtr.ReadModTime:TDatetime;
begin
  Result := oBtrTable.FieldByName('ModTime').AsDateTime;
end;

procedure TIdhBtr.WriteModTime(pValue:TDatetime);
begin
  oBtrTable.FieldByName('ModTime').AsDateTime := pValue;
end;

function TIdhBtr.Readx_IBkNum:Str5;
begin
  Result := oBtrTable.FieldByName('x_IBkNum').AsString;
end;

procedure TIdhBtr.Writex_IBkNum(pValue:Str5);
begin
  oBtrTable.FieldByName('x_IBkNum').AsString := pValue;
end;

function TIdhBtr.ReadDstLck:byte;
begin
  Result := oBtrTable.FieldByName('DstLck').AsInteger;
end;

procedure TIdhBtr.WriteDstLck(pValue:byte);
begin
  oBtrTable.FieldByName('DstLck').AsInteger := pValue;
end;

function TIdhBtr.ReadConDoc:Str12;
begin
  Result := oBtrTable.FieldByName('ConDoc').AsString;
end;

procedure TIdhBtr.WriteConDoc(pValue:Str12);
begin
  oBtrTable.FieldByName('ConDoc').AsString := pValue;
end;

function TIdhBtr.ReadCAccSnt:Str3;
begin
  Result := oBtrTable.FieldByName('CAccSnt').AsString;
end;

procedure TIdhBtr.WriteCAccSnt(pValue:Str3);
begin
  oBtrTable.FieldByName('CAccSnt').AsString := pValue;
end;

function TIdhBtr.ReadCAccAnl:Str6;
begin
  Result := oBtrTable.FieldByName('CAccAnl').AsString;
end;

procedure TIdhBtr.WriteCAccAnl(pValue:Str6);
begin
  oBtrTable.FieldByName('CAccAnl').AsString := pValue;
end;

function TIdhBtr.ReadDAccSnt:Str3;
begin
  Result := oBtrTable.FieldByName('DAccSnt').AsString;
end;

procedure TIdhBtr.WriteDAccSnt(pValue:Str3);
begin
  oBtrTable.FieldByName('DAccSnt').AsString := pValue;
end;

function TIdhBtr.ReadDAccAnl:Str6;
begin
  Result := oBtrTable.FieldByName('DAccAnl').AsString;
end;

procedure TIdhBtr.WriteDAccAnl(pValue:Str6);
begin
  oBtrTable.FieldByName('DAccAnl').AsString := pValue;
end;

function TIdhBtr.ReadAccUser:Str8;
begin
  Result := oBtrTable.FieldByName('AccUser').AsString;
end;

procedure TIdhBtr.WriteAccUser(pValue:Str8);
begin
  oBtrTable.FieldByName('AccUser').AsString := pValue;
end;

function TIdhBtr.ReadAccDate:TDatetime;
begin
  Result := oBtrTable.FieldByName('AccDate').AsDateTime;
end;

procedure TIdhBtr.WriteAccDate(pValue:TDatetime);
begin
  oBtrTable.FieldByName('AccDate').AsDateTime := pValue;
end;

function TIdhBtr.ReadVtcSpc:byte;
begin
  Result := oBtrTable.FieldByName('VtcSpc').AsInteger;
end;

procedure TIdhBtr.WriteVtcSpc(pValue:byte);
begin
  oBtrTable.FieldByName('VtcSpc').AsInteger := pValue;
end;

function TIdhBtr.ReadVatPrc1:byte;
begin
  Result := oBtrTable.FieldByName('VatPrc1').AsInteger;
end;

procedure TIdhBtr.WriteVatPrc1(pValue:byte);
begin
  oBtrTable.FieldByName('VatPrc1').AsInteger := pValue;
end;

function TIdhBtr.ReadVatPrc2:byte;
begin
  Result := oBtrTable.FieldByName('VatPrc2').AsInteger;
end;

procedure TIdhBtr.WriteVatPrc2(pValue:byte);
begin
  oBtrTable.FieldByName('VatPrc2').AsInteger := pValue;
end;

function TIdhBtr.ReadVatPrc3:byte;
begin
  Result := oBtrTable.FieldByName('VatPrc3').AsInteger;
end;

procedure TIdhBtr.WriteVatPrc3(pValue:byte);
begin
  oBtrTable.FieldByName('VatPrc3').AsInteger := pValue;
end;

function TIdhBtr.ReadAcAValue1:double;
begin
  Result := oBtrTable.FieldByName('AcAValue1').AsFloat;
end;

procedure TIdhBtr.WriteAcAValue1(pValue:double);
begin
  oBtrTable.FieldByName('AcAValue1').AsFloat := pValue;
end;

function TIdhBtr.ReadAcAValue2:double;
begin
  Result := oBtrTable.FieldByName('AcAValue2').AsFloat;
end;

procedure TIdhBtr.WriteAcAValue2(pValue:double);
begin
  oBtrTable.FieldByName('AcAValue2').AsFloat := pValue;
end;

function TIdhBtr.ReadAcAValue3:double;
begin
  Result := oBtrTable.FieldByName('AcAValue3').AsFloat;
end;

procedure TIdhBtr.WriteAcAValue3(pValue:double);
begin
  oBtrTable.FieldByName('AcAValue3').AsFloat := pValue;
end;

function TIdhBtr.ReadAcVatVal1:double;
begin
  Result := oBtrTable.FieldByName('AcVatVal1').AsFloat;
end;

procedure TIdhBtr.WriteAcVatVal1(pValue:double);
begin
  oBtrTable.FieldByName('AcVatVal1').AsFloat := pValue;
end;

function TIdhBtr.ReadAcVatVal2:double;
begin
  Result := oBtrTable.FieldByName('AcVatVal2').AsFloat;
end;

procedure TIdhBtr.WriteAcVatVal2(pValue:double);
begin
  oBtrTable.FieldByName('AcVatVal2').AsFloat := pValue;
end;

function TIdhBtr.ReadAcVatVal3:double;
begin
  Result := oBtrTable.FieldByName('AcVatVal3').AsFloat;
end;

procedure TIdhBtr.WriteAcVatVal3(pValue:double);
begin
  oBtrTable.FieldByName('AcVatVal3').AsFloat := pValue;
end;

function TIdhBtr.ReadAcAValue:double;
begin
  Result := oBtrTable.FieldByName('AcAValue').AsFloat;
end;

procedure TIdhBtr.WriteAcAValue(pValue:double);
begin
  oBtrTable.FieldByName('AcAValue').AsFloat := pValue;
end;

function TIdhBtr.ReadAcVatVal:double;
begin
  Result := oBtrTable.FieldByName('AcVatVal').AsFloat;
end;

procedure TIdhBtr.WriteAcVatVal(pValue:double);
begin
  oBtrTable.FieldByName('AcVatVal').AsFloat := pValue;
end;

function TIdhBtr.ReadAcBValue:double;
begin
  Result := oBtrTable.FieldByName('AcBValue').AsFloat;
end;

procedure TIdhBtr.WriteAcBValue(pValue:double);
begin
  oBtrTable.FieldByName('AcBValue').AsFloat := pValue;
end;

function TIdhBtr.ReadYear:Str2;
begin
  Result := oBtrTable.FieldByName('Year').AsString;
end;

procedure TIdhBtr.WriteYear(pValue:Str2);
begin
  oBtrTable.FieldByName('Year').AsString := pValue;
end;

function TIdhBtr.ReadVatPrc4:byte;
begin
  Result := oBtrTable.FieldByName('VatPrc4').AsInteger;
end;

procedure TIdhBtr.WriteVatPrc4(pValue:byte);
begin
  oBtrTable.FieldByName('VatPrc4').AsInteger := pValue;
end;

function TIdhBtr.ReadAcAValue4:double;
begin
  Result := oBtrTable.FieldByName('AcAValue4').AsFloat;
end;

procedure TIdhBtr.WriteAcAValue4(pValue:double);
begin
  oBtrTable.FieldByName('AcAValue4').AsFloat := pValue;
end;

function TIdhBtr.ReadAcVatVal4:double;
begin
  Result := oBtrTable.FieldByName('AcVatVal4').AsFloat;
end;

procedure TIdhBtr.WriteAcVatVal4(pValue:double);
begin
  oBtrTable.FieldByName('AcVatVal4').AsFloat := pValue;
end;

function TIdhBtr.ReadVatPrc5:byte;
begin
  Result := oBtrTable.FieldByName('VatPrc5').AsInteger;
end;

procedure TIdhBtr.WriteVatPrc5(pValue:byte);
begin
  oBtrTable.FieldByName('VatPrc5').AsInteger := pValue;
end;

function TIdhBtr.ReadAcAValue5:double;
begin
  Result := oBtrTable.FieldByName('AcAValue5').AsFloat;
end;

procedure TIdhBtr.WriteAcAValue5(pValue:double);
begin
  oBtrTable.FieldByName('AcAValue5').AsFloat := pValue;
end;

function TIdhBtr.ReadAcVatVal5:double;
begin
  Result := oBtrTable.FieldByName('AcVatVal5').AsFloat;
end;

procedure TIdhBtr.WriteAcVatVal5(pValue:double);
begin
  oBtrTable.FieldByName('AcVatVal5').AsFloat := pValue;
end;

// **************************************** PUBLIC ********************************************

function TIdhBtr.Eof: boolean;
begin
  Result := oBtrTable.Eof;
end;

function TIdhBtr.IsFirstRec: boolean;
begin
  Result := oBtrTable.Bof;
end;

function TIdhBtr.IsLastRec: boolean;
begin
  Result := oBtrTable.Eof;
end;

function TIdhBtr.Active: boolean;
begin
  Result := oBtrTable.Active;
end;

function TIdhBtr.ActPos: longint;
begin
  Result := oBtrTable.ActPos;
end;

function TIdhBtr.GotoPos (pActPos:longint): boolean;
begin
  Result := oBtrTable.GotoPos(pActPos);
end;

function TIdhBtr.LocateDocNum (pDocNum:Str12):boolean;
begin
  SetIndex (ixDocNum);
  Result := oBtrTable.FindKey([pDocNum]);
end;

function TIdhBtr.LocateExtNum (pExtNum:Str12):boolean;
begin
  SetIndex (ixExtNum);
  Result := oBtrTable.FindKey([pExtNum]);
end;

function TIdhBtr.LocateDescribe (pDescribe_:Str30):boolean;
begin
  SetIndex (ixDescribe);
  Result := oBtrTable.FindKey([StrToAlias(pDescribe_)]);
end;

function TIdhBtr.LocateDocVal (pDocVal:double):boolean;
begin
  SetIndex (ixDocVal);
  Result := oBtrTable.FindKey([pDocVal]);
end;

function TIdhBtr.LocatePaCode (pPaCode:longint):boolean;
begin
  SetIndex (ixPaCode);
  Result := oBtrTable.FindKey([pPaCode]);
end;

function TIdhBtr.LocatePaName (pPaName_:Str30):boolean;
begin
  SetIndex (ixPaName);
  Result := oBtrTable.FindKey([StrToAlias(pPaName_)]);
end;

function TIdhBtr.LocateConDoc (pConDoc:Str12):boolean;
begin
  SetIndex (ixConDoc);
  Result := oBtrTable.FindKey([pConDoc]);
end;

function TIdhBtr.LocateYearSerNum (pYear:Str2;pSerNum:longint):boolean;
begin
  SetIndex (ixYearSerNum);
  Result := oBtrTable.FindKey([pYear,pSerNum]);
end;

function TIdhBtr.LocateDocDate (pDocDate:TDatetime):boolean;
begin
  SetIndex (ixDocDate);
  Result := oBtrTable.FindKey([pDocDate]);
end;

function TIdhBtr.LocateDstAcc (pDstAcc:Str1):boolean;
begin
  SetIndex (ixDstAcc);
  Result := oBtrTable.FindKey([pDstAcc]);
end;

function TIdhBtr.NearestDocNum (pDocNum:Str12):boolean;
begin
  SetIndex (ixDocNum);
  Result := oBtrTable.FindNearest([pDocNum]);
end;

function TIdhBtr.NearestExtNum (pExtNum:Str12):boolean;
begin
  SetIndex (ixExtNum);
  Result := oBtrTable.FindNearest([pExtNum]);
end;

function TIdhBtr.NearestDescribe (pDescribe_:Str30):boolean;
begin
  SetIndex (ixDescribe);
  Result := oBtrTable.FindNearest([pDescribe_]);
end;

function TIdhBtr.NearestDocVal (pDocVal:double):boolean;
begin
  SetIndex (ixDocVal);
  Result := oBtrTable.FindNearest([pDocVal]);
end;

function TIdhBtr.NearestPaCode (pPaCode:longint):boolean;
begin
  SetIndex (ixPaCode);
  Result := oBtrTable.FindNearest([pPaCode]);
end;

function TIdhBtr.NearestPaName (pPaName_:Str30):boolean;
begin
  SetIndex (ixPaName);
  Result := oBtrTable.FindNearest([pPaName_]);
end;

function TIdhBtr.NearestConDoc (pConDoc:Str12):boolean;
begin
  SetIndex (ixConDoc);
  Result := oBtrTable.FindNearest([pConDoc]);
end;

function TIdhBtr.NearestYearSerNum (pYear:Str2;pSerNum:longint):boolean;
begin
  SetIndex (ixYearSerNum);
  Result := oBtrTable.FindNearest([pYear,pSerNum]);
end;

function TIdhBtr.NearestDocDate (pDocDate:TDatetime):boolean;
begin
  SetIndex (ixDocDate);
  Result := oBtrTable.FindNearest([pDocDate]);
end;

function TIdhBtr.NearestDstAcc (pDstAcc:Str1):boolean;
begin
  SetIndex (ixDstAcc);
  Result := oBtrTable.FindNearest([pDstAcc]);
end;

procedure TIdhBtr.SetIndex (pIndexName:ShortString);
begin
  If oBtrTable.IndexName<>pIndexName then oBtrTable.IndexName := pIndexName;
end;

procedure TIdhBtr.Open(pBookNum:Str5);
begin
  oBookNum := pBookNum;
  oBtrTable.Open(pBookNum);
end;

procedure TIdhBtr.Close;
begin
  If oBtrTable.Active then oBtrTable.Close;
end;

procedure TIdhBtr.Prior;
begin
  oBtrTable.Prior;
end;

procedure TIdhBtr.Next;
begin
  oBtrTable.Next;
end;

procedure TIdhBtr.First;
begin
  oBtrTable.First;
end;

procedure TIdhBtr.Last;
begin
  oBtrTable.Last;
end;

procedure TIdhBtr.Insert;
begin
  oBtrTable.Insert;
end;

procedure TIdhBtr.Edit;
begin
  oBtrTable.Edit;
end;

procedure TIdhBtr.Post;
begin
  oBtrTable.Post;
end;

procedure TIdhBtr.Delete;
begin
  oBtrTable.Delete;
end;

procedure TIdhBtr.SwapIndex;
begin
  oBtrTable.SwapIndex;
end;

procedure TIdhBtr.RestoreIndex;
begin
  oBtrTable.RestoreIndex;
end;

procedure TIdhBtr.SwapStatus;
begin
  oBtrTable.SwapStatus;
end;

procedure TIdhBtr.RestoreStatus;
begin
  oBtrTable.RestoreStatus;
end;

procedure TIdhBtr.EnableControls;
begin
  oBtrTable.EnableControls;
end;

procedure TIdhBtr.DisableControls;
begin
  oBtrTable.DisableControls;
end;

end.
{MOD 2202001}
