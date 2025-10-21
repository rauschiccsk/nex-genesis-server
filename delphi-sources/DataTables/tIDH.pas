unit tIDH;

interface

uses
  IcTypes, IcConv, NexPath, NexGlob, DocHand, 
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls,
  Dialogs, DB, NexBtrTable, DBTables, NexPxTable;

const
  ixDocNum = '';
  ixExtNum = 'ExtNum';
  ixDescribe_ = 'Describe_';
  ixDocDate = 'DocDate';
  ixDocVal = 'DocVal';
  ixConDoc = 'ConDoc';
  ixSerNum = 'SerNum';

type
  TIdhTmp = class (TComponent)
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
    function  ReadWriNum:word;           procedure WriteWriNum (pValue:word);
    function  ReadPaCode:longint;        procedure WritePaCode (pValue:longint);
    function  ReadPaName:Str30;          procedure WritePaName (pValue:Str30);
    function  ReadDescribe:Str30;        procedure WriteDescribe (pValue:Str30);
    function  ReadDescribe_:Str30;       procedure WriteDescribe_ (pValue:Str30);
    function  ReadItmQnt:longint;        procedure WriteItmQnt (pValue:longint);
    function  ReadDocVal:double;         procedure WriteDocVal (pValue:double);
    function  ReadPrnCnt:word;           procedure WritePrnCnt (pValue:word);
    function  ReadCredVal:double;        procedure WriteCredVal (pValue:double);
    function  ReadDebVal:double;         procedure WriteDebVal (pValue:double);
    function  ReadVtcSpc:byte;           procedure WriteVtcSpc (pValue:byte);
    function  ReadVatPrc1:byte;          procedure WriteVatPrc1 (pValue:byte);
    function  ReadVatPrc2:byte;          procedure WriteVatPrc2 (pValue:byte);
    function  ReadVatPrc3:byte;          procedure WriteVatPrc3 (pValue:byte);
    function  ReadVatPrc4:byte;          procedure WriteVatPrc4 (pValue:byte);
    function  ReadVatPrc5:byte;          procedure WriteVatPrc5 (pValue:byte);
    function  ReadAcAValue1:double;      procedure WriteAcAValue1 (pValue:double);
    function  ReadAcAValue2:double;      procedure WriteAcAValue2 (pValue:double);
    function  ReadAcAValue3:double;      procedure WriteAcAValue3 (pValue:double);
    function  ReadAcAValue4:double;      procedure WriteAcAValue4 (pValue:double);
    function  ReadAcAValue5:double;      procedure WriteAcAValue5 (pValue:double);
    function  ReadAcVatVal1:double;      procedure WriteAcVatVal1 (pValue:double);
    function  ReadAcVatVal2:double;      procedure WriteAcVatVal2 (pValue:double);
    function  ReadAcVatVal3:double;      procedure WriteAcVatVal3 (pValue:double);
    function  ReadAcVatVal4:double;      procedure WriteAcVatVal4 (pValue:double);
    function  ReadAcVatVal5:double;      procedure WriteAcVatVal5 (pValue:double);
    function  ReadAcAValue:double;       procedure WriteAcAValue (pValue:double);
    function  ReadAcVatVal:double;       procedure WriteAcVatVal (pValue:double);
    function  ReadAcBValue:double;       procedure WriteAcBValue (pValue:double);
    function  ReadDocType:byte;          procedure WriteDocType (pValue:byte);
    function  ReadDstLck:byte;           procedure WriteDstLck (pValue:byte);
    function  ReadDstAcc:Str1;           procedure WriteDstAcc (pValue:Str1);
    function  ReadConDoc:Str12;          procedure WriteConDoc (pValue:Str12);
    function  ReadCAccSnt:Str3;          procedure WriteCAccSnt (pValue:Str3);
    function  ReadCAccAnl:Str6;          procedure WriteCAccAnl (pValue:Str6);
    function  ReadDAccSnt:Str3;          procedure WriteDAccSnt (pValue:Str3);
    function  ReadDAccAnl:Str6;          procedure WriteDAccAnl (pValue:Str6);
    function  ReadAccUser:Str8;          procedure WriteAccUser (pValue:Str8);
    function  ReadAccDate:TDatetime;     procedure WriteAccDate (pValue:TDatetime);
    function  ReadCrtUser:Str8;          procedure WriteCrtUser (pValue:Str8);
    function  ReadCrtDate:TDatetime;     procedure WriteCrtDate (pValue:TDatetime);
    function  ReadCrtTime:TDatetime;     procedure WriteCrtTime (pValue:TDatetime);
    function  ReadModNum:word;           procedure WriteModNum (pValue:word);
    function  ReadModUser:Str8;          procedure WriteModUser (pValue:Str8);
    function  ReadModDate:TDatetime;     procedure WriteModDate (pValue:TDatetime);
    function  ReadModTime:TDatetime;     procedure WriteModTime (pValue:TDatetime);
    function  ReadActPos:longint;        procedure WriteActPos (pValue:longint);
  public
    // Elementarne databazove operacie
    function Eof: boolean;
    function Active: boolean;
    function LocateDocNum (pDocNum:Str12):boolean;
    function LocateExtNum (pExtNum:Str12):boolean;
    function LocateDescribe_ (pDescribe_:Str30):boolean;
    function LocateDocDate (pDocDate:TDatetime):boolean;
    function LocateDocVal (pDocVal:double):boolean;
    function LocateConDoc (pConDoc:Str12):boolean;
    function LocateSerNum (pSerNum:longint):boolean;

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
    property WriNum:word read ReadWriNum write WriteWriNum;
    property PaCode:longint read ReadPaCode write WritePaCode;
    property PaName:Str30 read ReadPaName write WritePaName;
    property Describe:Str30 read ReadDescribe write WriteDescribe;
    property Describe_:Str30 read ReadDescribe_ write WriteDescribe_;
    property ItmQnt:longint read ReadItmQnt write WriteItmQnt;
    property DocVal:double read ReadDocVal write WriteDocVal;
    property PrnCnt:word read ReadPrnCnt write WritePrnCnt;
    property CredVal:double read ReadCredVal write WriteCredVal;
    property DebVal:double read ReadDebVal write WriteDebVal;
    property VtcSpc:byte read ReadVtcSpc write WriteVtcSpc;
    property VatPrc1:byte read ReadVatPrc1 write WriteVatPrc1;
    property VatPrc2:byte read ReadVatPrc2 write WriteVatPrc2;
    property VatPrc3:byte read ReadVatPrc3 write WriteVatPrc3;
    property VatPrc4:byte read ReadVatPrc4 write WriteVatPrc4;
    property VatPrc5:byte read ReadVatPrc5 write WriteVatPrc5;
    property AcAValue1:double read ReadAcAValue1 write WriteAcAValue1;
    property AcAValue2:double read ReadAcAValue2 write WriteAcAValue2;
    property AcAValue3:double read ReadAcAValue3 write WriteAcAValue3;
    property AcAValue4:double read ReadAcAValue4 write WriteAcAValue4;
    property AcAValue5:double read ReadAcAValue5 write WriteAcAValue5;
    property AcVatVal1:double read ReadAcVatVal1 write WriteAcVatVal1;
    property AcVatVal2:double read ReadAcVatVal2 write WriteAcVatVal2;
    property AcVatVal3:double read ReadAcVatVal3 write WriteAcVatVal3;
    property AcVatVal4:double read ReadAcVatVal4 write WriteAcVatVal4;
    property AcVatVal5:double read ReadAcVatVal5 write WriteAcVatVal5;
    property AcAValue:double read ReadAcAValue write WriteAcAValue;
    property AcVatVal:double read ReadAcVatVal write WriteAcVatVal;
    property AcBValue:double read ReadAcBValue write WriteAcBValue;
    property DocType:byte read ReadDocType write WriteDocType;
    property DstLck:byte read ReadDstLck write WriteDstLck;
    property DstAcc:Str1 read ReadDstAcc write WriteDstAcc;
    property ConDoc:Str12 read ReadConDoc write WriteConDoc;
    property CAccSnt:Str3 read ReadCAccSnt write WriteCAccSnt;
    property CAccAnl:Str6 read ReadCAccAnl write WriteCAccAnl;
    property DAccSnt:Str3 read ReadDAccSnt write WriteDAccSnt;
    property DAccAnl:Str6 read ReadDAccAnl write WriteDAccAnl;
    property AccUser:Str8 read ReadAccUser write WriteAccUser;
    property AccDate:TDatetime read ReadAccDate write WriteAccDate;
    property CrtUser:Str8 read ReadCrtUser write WriteCrtUser;
    property CrtDate:TDatetime read ReadCrtDate write WriteCrtDate;
    property CrtTime:TDatetime read ReadCrtTime write WriteCrtTime;
    property ModNum:word read ReadModNum write WriteModNum;
    property ModUser:Str8 read ReadModUser write WriteModUser;
    property ModDate:TDatetime read ReadModDate write WriteModDate;
    property ModTime:TDatetime read ReadModTime write WriteModTime;
    property ActPos:longint read ReadActPos write WriteActPos;
  end;

implementation

constructor TIdhTmp.Create;
begin
  oTmpTable := TmpInit ('IDH',Self);
end;

destructor TIdhTmp.Destroy;
begin
  If oTmpTable.Active then oTmpTable.Close;
  FreeAndNil (oTmpTable);
end;

// *************************************** PRIVATE ********************************************

function TIdhTmp.ReadCount:integer;
begin
  Result := oTmpTable.RecordCount;
end;

function TIdhTmp.FieldExist (pFieldName:ShortString): boolean;
begin
  Result := oTmpTable.FindField(pFieldName)<>nil;
end;

function TIdhTmp.ReadDocNum:Str12;
begin
  Result := oTmpTable.FieldByName('DocNum').AsString;
end;

procedure TIdhTmp.WriteDocNum(pValue:Str12);
begin
  oTmpTable.FieldByName('DocNum').AsString := pValue;
end;

function TIdhTmp.ReadYear:Str2;
begin
  Result := oTmpTable.FieldByName('Year').AsString;
end;

procedure TIdhTmp.WriteYear(pValue:Str2);
begin
  oTmpTable.FieldByName('Year').AsString := pValue;
end;

function TIdhTmp.ReadSerNum:longint;
begin
  Result := oTmpTable.FieldByName('SerNum').AsInteger;
end;

procedure TIdhTmp.WriteSerNum(pValue:longint);
begin
  oTmpTable.FieldByName('SerNum').AsInteger := pValue;
end;

function TIdhTmp.ReadExtNum:Str12;
begin
  Result := oTmpTable.FieldByName('ExtNum').AsString;
end;

procedure TIdhTmp.WriteExtNum(pValue:Str12);
begin
  oTmpTable.FieldByName('ExtNum').AsString := pValue;
end;

function TIdhTmp.ReadDocDate:TDatetime;
begin
  Result := oTmpTable.FieldByName('DocDate').AsDateTime;
end;

procedure TIdhTmp.WriteDocDate(pValue:TDatetime);
begin
  oTmpTable.FieldByName('DocDate').AsDateTime := pValue;
end;

function TIdhTmp.ReadWriNum:word;
begin
  Result := oTmpTable.FieldByName('WriNum').AsInteger;
end;

procedure TIdhTmp.WriteWriNum(pValue:word);
begin
  oTmpTable.FieldByName('WriNum').AsInteger := pValue;
end;

function TIdhTmp.ReadPaCode:longint;
begin
  Result := oTmpTable.FieldByName('PaCode').AsInteger;
end;

procedure TIdhTmp.WritePaCode(pValue:longint);
begin
  oTmpTable.FieldByName('PaCode').AsInteger := pValue;
end;

function TIdhTmp.ReadPaName:Str30;
begin
  Result := oTmpTable.FieldByName('PaName').AsString;
end;

procedure TIdhTmp.WritePaName(pValue:Str30);
begin
  oTmpTable.FieldByName('PaName').AsString := pValue;
end;

function TIdhTmp.ReadDescribe:Str30;
begin
  Result := oTmpTable.FieldByName('Describe').AsString;
end;

procedure TIdhTmp.WriteDescribe(pValue:Str30);
begin
  oTmpTable.FieldByName('Describe').AsString := pValue;
end;

function TIdhTmp.ReadDescribe_:Str30;
begin
  Result := oTmpTable.FieldByName('Describe_').AsString;
end;

procedure TIdhTmp.WriteDescribe_(pValue:Str30);
begin
  oTmpTable.FieldByName('Describe_').AsString := pValue;
end;

function TIdhTmp.ReadItmQnt:longint;
begin
  Result := oTmpTable.FieldByName('ItmQnt').AsInteger;
end;

procedure TIdhTmp.WriteItmQnt(pValue:longint);
begin
  oTmpTable.FieldByName('ItmQnt').AsInteger := pValue;
end;

function TIdhTmp.ReadDocVal:double;
begin
  Result := oTmpTable.FieldByName('DocVal').AsFloat;
end;

procedure TIdhTmp.WriteDocVal(pValue:double);
begin
  oTmpTable.FieldByName('DocVal').AsFloat := pValue;
end;

function TIdhTmp.ReadPrnCnt:word;
begin
  Result := oTmpTable.FieldByName('PrnCnt').AsInteger;
end;

procedure TIdhTmp.WritePrnCnt(pValue:word);
begin
  oTmpTable.FieldByName('PrnCnt').AsInteger := pValue;
end;

function TIdhTmp.ReadCredVal:double;
begin
  Result := oTmpTable.FieldByName('CredVal').AsFloat;
end;

procedure TIdhTmp.WriteCredVal(pValue:double);
begin
  oTmpTable.FieldByName('CredVal').AsFloat := pValue;
end;

function TIdhTmp.ReadDebVal:double;
begin
  Result := oTmpTable.FieldByName('DebVal').AsFloat;
end;

procedure TIdhTmp.WriteDebVal(pValue:double);
begin
  oTmpTable.FieldByName('DebVal').AsFloat := pValue;
end;

function TIdhTmp.ReadVtcSpc:byte;
begin
  Result := oTmpTable.FieldByName('VtcSpc').AsInteger;
end;

procedure TIdhTmp.WriteVtcSpc(pValue:byte);
begin
  oTmpTable.FieldByName('VtcSpc').AsInteger := pValue;
end;

function TIdhTmp.ReadVatPrc1:byte;
begin
  Result := oTmpTable.FieldByName('VatPrc1').AsInteger;
end;

procedure TIdhTmp.WriteVatPrc1(pValue:byte);
begin
  oTmpTable.FieldByName('VatPrc1').AsInteger := pValue;
end;

function TIdhTmp.ReadVatPrc2:byte;
begin
  Result := oTmpTable.FieldByName('VatPrc2').AsInteger;
end;

procedure TIdhTmp.WriteVatPrc2(pValue:byte);
begin
  oTmpTable.FieldByName('VatPrc2').AsInteger := pValue;
end;

function TIdhTmp.ReadVatPrc3:byte;
begin
  Result := oTmpTable.FieldByName('VatPrc3').AsInteger;
end;

procedure TIdhTmp.WriteVatPrc3(pValue:byte);
begin
  oTmpTable.FieldByName('VatPrc3').AsInteger := pValue;
end;

function TIdhTmp.ReadVatPrc4:byte;
begin
  Result := oTmpTable.FieldByName('VatPrc4').AsInteger;
end;

procedure TIdhTmp.WriteVatPrc4(pValue:byte);
begin
  oTmpTable.FieldByName('VatPrc4').AsInteger := pValue;
end;

function TIdhTmp.ReadVatPrc5:byte;
begin
  Result := oTmpTable.FieldByName('VatPrc5').AsInteger;
end;

procedure TIdhTmp.WriteVatPrc5(pValue:byte);
begin
  oTmpTable.FieldByName('VatPrc5').AsInteger := pValue;
end;

function TIdhTmp.ReadAcAValue1:double;
begin
  Result := oTmpTable.FieldByName('AcAValue1').AsFloat;
end;

procedure TIdhTmp.WriteAcAValue1(pValue:double);
begin
  oTmpTable.FieldByName('AcAValue1').AsFloat := pValue;
end;

function TIdhTmp.ReadAcAValue2:double;
begin
  Result := oTmpTable.FieldByName('AcAValue2').AsFloat;
end;

procedure TIdhTmp.WriteAcAValue2(pValue:double);
begin
  oTmpTable.FieldByName('AcAValue2').AsFloat := pValue;
end;

function TIdhTmp.ReadAcAValue3:double;
begin
  Result := oTmpTable.FieldByName('AcAValue3').AsFloat;
end;

procedure TIdhTmp.WriteAcAValue3(pValue:double);
begin
  oTmpTable.FieldByName('AcAValue3').AsFloat := pValue;
end;

function TIdhTmp.ReadAcAValue4:double;
begin
  Result := oTmpTable.FieldByName('AcAValue4').AsFloat;
end;

procedure TIdhTmp.WriteAcAValue4(pValue:double);
begin
  oTmpTable.FieldByName('AcAValue4').AsFloat := pValue;
end;

function TIdhTmp.ReadAcAValue5:double;
begin
  Result := oTmpTable.FieldByName('AcAValue5').AsFloat;
end;

procedure TIdhTmp.WriteAcAValue5(pValue:double);
begin
  oTmpTable.FieldByName('AcAValue5').AsFloat := pValue;
end;

function TIdhTmp.ReadAcVatVal1:double;
begin
  Result := oTmpTable.FieldByName('AcVatVal1').AsFloat;
end;

procedure TIdhTmp.WriteAcVatVal1(pValue:double);
begin
  oTmpTable.FieldByName('AcVatVal1').AsFloat := pValue;
end;

function TIdhTmp.ReadAcVatVal2:double;
begin
  Result := oTmpTable.FieldByName('AcVatVal2').AsFloat;
end;

procedure TIdhTmp.WriteAcVatVal2(pValue:double);
begin
  oTmpTable.FieldByName('AcVatVal2').AsFloat := pValue;
end;

function TIdhTmp.ReadAcVatVal3:double;
begin
  Result := oTmpTable.FieldByName('AcVatVal3').AsFloat;
end;

procedure TIdhTmp.WriteAcVatVal3(pValue:double);
begin
  oTmpTable.FieldByName('AcVatVal3').AsFloat := pValue;
end;

function TIdhTmp.ReadAcVatVal4:double;
begin
  Result := oTmpTable.FieldByName('AcVatVal4').AsFloat;
end;

procedure TIdhTmp.WriteAcVatVal4(pValue:double);
begin
  oTmpTable.FieldByName('AcVatVal4').AsFloat := pValue;
end;

function TIdhTmp.ReadAcVatVal5:double;
begin
  Result := oTmpTable.FieldByName('AcVatVal5').AsFloat;
end;

procedure TIdhTmp.WriteAcVatVal5(pValue:double);
begin
  oTmpTable.FieldByName('AcVatVal5').AsFloat := pValue;
end;

function TIdhTmp.ReadAcAValue:double;
begin
  Result := oTmpTable.FieldByName('AcAValue').AsFloat;
end;

procedure TIdhTmp.WriteAcAValue(pValue:double);
begin
  oTmpTable.FieldByName('AcAValue').AsFloat := pValue;
end;

function TIdhTmp.ReadAcVatVal:double;
begin
  Result := oTmpTable.FieldByName('AcVatVal').AsFloat;
end;

procedure TIdhTmp.WriteAcVatVal(pValue:double);
begin
  oTmpTable.FieldByName('AcVatVal').AsFloat := pValue;
end;

function TIdhTmp.ReadAcBValue:double;
begin
  Result := oTmpTable.FieldByName('AcBValue').AsFloat;
end;

procedure TIdhTmp.WriteAcBValue(pValue:double);
begin
  oTmpTable.FieldByName('AcBValue').AsFloat := pValue;
end;

function TIdhTmp.ReadDocType:byte;
begin
  Result := oTmpTable.FieldByName('DocType').AsInteger;
end;

procedure TIdhTmp.WriteDocType(pValue:byte);
begin
  oTmpTable.FieldByName('DocType').AsInteger := pValue;
end;

function TIdhTmp.ReadDstLck:byte;
begin
  Result := oTmpTable.FieldByName('DstLck').AsInteger;
end;

procedure TIdhTmp.WriteDstLck(pValue:byte);
begin
  oTmpTable.FieldByName('DstLck').AsInteger := pValue;
end;

function TIdhTmp.ReadDstAcc:Str1;
begin
  Result := oTmpTable.FieldByName('DstAcc').AsString;
end;

procedure TIdhTmp.WriteDstAcc(pValue:Str1);
begin
  oTmpTable.FieldByName('DstAcc').AsString := pValue;
end;

function TIdhTmp.ReadConDoc:Str12;
begin
  Result := oTmpTable.FieldByName('ConDoc').AsString;
end;

procedure TIdhTmp.WriteConDoc(pValue:Str12);
begin
  oTmpTable.FieldByName('ConDoc').AsString := pValue;
end;

function TIdhTmp.ReadCAccSnt:Str3;
begin
  Result := oTmpTable.FieldByName('CAccSnt').AsString;
end;

procedure TIdhTmp.WriteCAccSnt(pValue:Str3);
begin
  oTmpTable.FieldByName('CAccSnt').AsString := pValue;
end;

function TIdhTmp.ReadCAccAnl:Str6;
begin
  Result := oTmpTable.FieldByName('CAccAnl').AsString;
end;

procedure TIdhTmp.WriteCAccAnl(pValue:Str6);
begin
  oTmpTable.FieldByName('CAccAnl').AsString := pValue;
end;

function TIdhTmp.ReadDAccSnt:Str3;
begin
  Result := oTmpTable.FieldByName('DAccSnt').AsString;
end;

procedure TIdhTmp.WriteDAccSnt(pValue:Str3);
begin
  oTmpTable.FieldByName('DAccSnt').AsString := pValue;
end;

function TIdhTmp.ReadDAccAnl:Str6;
begin
  Result := oTmpTable.FieldByName('DAccAnl').AsString;
end;

procedure TIdhTmp.WriteDAccAnl(pValue:Str6);
begin
  oTmpTable.FieldByName('DAccAnl').AsString := pValue;
end;

function TIdhTmp.ReadAccUser:Str8;
begin
  Result := oTmpTable.FieldByName('AccUser').AsString;
end;

procedure TIdhTmp.WriteAccUser(pValue:Str8);
begin
  oTmpTable.FieldByName('AccUser').AsString := pValue;
end;

function TIdhTmp.ReadAccDate:TDatetime;
begin
  Result := oTmpTable.FieldByName('AccDate').AsDateTime;
end;

procedure TIdhTmp.WriteAccDate(pValue:TDatetime);
begin
  oTmpTable.FieldByName('AccDate').AsDateTime := pValue;
end;

function TIdhTmp.ReadCrtUser:Str8;
begin
  Result := oTmpTable.FieldByName('CrtUser').AsString;
end;

procedure TIdhTmp.WriteCrtUser(pValue:Str8);
begin
  oTmpTable.FieldByName('CrtUser').AsString := pValue;
end;

function TIdhTmp.ReadCrtDate:TDatetime;
begin
  Result := oTmpTable.FieldByName('CrtDate').AsDateTime;
end;

procedure TIdhTmp.WriteCrtDate(pValue:TDatetime);
begin
  oTmpTable.FieldByName('CrtDate').AsDateTime := pValue;
end;

function TIdhTmp.ReadCrtTime:TDatetime;
begin
  Result := oTmpTable.FieldByName('CrtTime').AsDateTime;
end;

procedure TIdhTmp.WriteCrtTime(pValue:TDatetime);
begin
  oTmpTable.FieldByName('CrtTime').AsDateTime := pValue;
end;

function TIdhTmp.ReadModNum:word;
begin
  Result := oTmpTable.FieldByName('ModNum').AsInteger;
end;

procedure TIdhTmp.WriteModNum(pValue:word);
begin
  oTmpTable.FieldByName('ModNum').AsInteger := pValue;
end;

function TIdhTmp.ReadModUser:Str8;
begin
  Result := oTmpTable.FieldByName('ModUser').AsString;
end;

procedure TIdhTmp.WriteModUser(pValue:Str8);
begin
  oTmpTable.FieldByName('ModUser').AsString := pValue;
end;

function TIdhTmp.ReadModDate:TDatetime;
begin
  Result := oTmpTable.FieldByName('ModDate').AsDateTime;
end;

procedure TIdhTmp.WriteModDate(pValue:TDatetime);
begin
  oTmpTable.FieldByName('ModDate').AsDateTime := pValue;
end;

function TIdhTmp.ReadModTime:TDatetime;
begin
  Result := oTmpTable.FieldByName('ModTime').AsDateTime;
end;

procedure TIdhTmp.WriteModTime(pValue:TDatetime);
begin
  oTmpTable.FieldByName('ModTime').AsDateTime := pValue;
end;

function TIdhTmp.ReadActPos:longint;
begin
  Result := oTmpTable.FieldByName('ActPos').AsInteger;
end;

procedure TIdhTmp.WriteActPos(pValue:longint);
begin
  oTmpTable.FieldByName('ActPos').AsInteger := pValue;
end;

// **************************************** PUBLIC ********************************************

function TIdhTmp.Eof: boolean;
begin
  Result := oTmpTable.Eof;
end;

function TIdhTmp.Active: boolean;
begin
  Result := oTmpTable.Active;
end;

function TIdhTmp.LocateDocNum (pDocNum:Str12):boolean;
begin
  SetIndex (ixDocNum);
  Result := oTmpTable.FindKey([pDocNum]);
end;

function TIdhTmp.LocateExtNum (pExtNum:Str12):boolean;
begin
  SetIndex (ixExtNum);
  Result := oTmpTable.FindKey([pExtNum]);
end;

function TIdhTmp.LocateDescribe_ (pDescribe_:Str30):boolean;
begin
  SetIndex (ixDescribe_);
  Result := oTmpTable.FindKey([pDescribe_]);
end;

function TIdhTmp.LocateDocDate (pDocDate:TDatetime):boolean;
begin
  SetIndex (ixDocDate);
  Result := oTmpTable.FindKey([pDocDate]);
end;

function TIdhTmp.LocateDocVal (pDocVal:double):boolean;
begin
  SetIndex (ixDocVal);
  Result := oTmpTable.FindKey([pDocVal]);
end;

function TIdhTmp.LocateConDoc (pConDoc:Str12):boolean;
begin
  SetIndex (ixConDoc);
  Result := oTmpTable.FindKey([pConDoc]);
end;

function TIdhTmp.LocateSerNum (pSerNum:longint):boolean;
begin
  SetIndex (ixSerNum);
  Result := oTmpTable.FindKey([pSerNum]);
end;

procedure TIdhTmp.SetIndex (pIndexName:ShortString);
begin
  If oTmpTable.IndexName<>pIndexName then oTmpTable.IndexName := pIndexName;
end;

procedure TIdhTmp.Open;
begin
  oTmpTable.Open;
end;

procedure TIdhTmp.Close;
begin
  If oTmpTable.Active then oTmpTable.Close;
end;

procedure TIdhTmp.Prior;
begin
  oTmpTable.Prior;
end;

procedure TIdhTmp.Next;
begin
  oTmpTable.Next;
end;

procedure TIdhTmp.First;
begin
  oTmpTable.First;
end;

procedure TIdhTmp.Last;
begin
  oTmpTable.Last;
end;

procedure TIdhTmp.Insert;
begin
  oTmpTable.Insert;
end;

procedure TIdhTmp.Edit;
begin
  oTmpTable.Edit;
end;

procedure TIdhTmp.Post;
var mEdit:boolean;
begin
  oTmpTable.Post;
end;

procedure TIdhTmp.Delete;
begin
  oTmpTable.Delete;
end;

procedure TIdhTmp.SwapIndex;
begin
  oTmpTable.SwapIndex;
end;

procedure TIdhTmp.RestoreIndex;
begin
  oTmpTable.RestoreIndex;
end;

procedure TIdhTmp.SwapStatus;
begin
  oTmpTable.SwapStatus;
end;

procedure TIdhTmp.RestoreStatus;
begin
  oTmpTable.RestoreStatus;
end;

procedure TIdhTmp.EnableControls;
begin
  oTmpTable.EnableControls;
end;

procedure TIdhTmp.DisableControls;
begin
  oTmpTable.DisableControls;
end;

end.
{MOD 2202001}
