unit tSPV;

interface

uses
  IcTypes, IcConv, NexPath, NexGlob, DocHand, 
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls,
  Dialogs, DB, NexBtrTable, DBTables, NexPxTable;

const
  ixRowNum = '';
  ixYearSerNum = 'YearSerNum';
  ixSerNum = 'SerNum';
  ixDocNum = 'DocNum';
  ixDocDate = 'DocDate';
  ixPaCode = 'PaCode';
  ixPaName_ = 'PaName_';
  ixPayMode = 'PayMode';

type
  TSpvTmp = class (TComponent)
    constructor Create;
    destructor  Destroy; override;
  private
    oTmpTable: TNexPxTable;
    function ReadCount:integer;
    function FieldExist (pFieldName:ShortString): boolean;
    // Pristup k databazovym poliam
    function  ReadRowNum:word;           procedure WriteRowNum (pValue:word);
    function  ReadYear:Str2;             procedure WriteYear (pValue:Str2);
    function  ReadSerNum:word;           procedure WriteSerNum (pValue:word);
    function  ReadDocNum:Str12;          procedure WriteDocNum (pValue:Str12);
    function  ReadDocDate:TDatetime;     procedure WriteDocDate (pValue:TDatetime);
    function  ReadPaCode:longint;        procedure WritePaCode (pValue:longint);
    function  ReadPaName:Str30;          procedure WritePaName (pValue:Str30);
    function  ReadPaName_:Str30;         procedure WritePaName_ (pValue:Str30);
    function  ReadVatPrc1:byte;          procedure WriteVatPrc1 (pValue:byte);
    function  ReadVatPrc2:byte;          procedure WriteVatPrc2 (pValue:byte);
    function  ReadVatPrc3:byte;          procedure WriteVatPrc3 (pValue:byte);
    function  ReadVatPrc4:byte;          procedure WriteVatPrc4 (pValue:byte);
    function  ReadVatPrc5:byte;          procedure WriteVatPrc5 (pValue:byte);
    function  ReadAValue:double;         procedure WriteAValue (pValue:double);
    function  ReadAValue1:double;        procedure WriteAValue1 (pValue:double);
    function  ReadAValue2:double;        procedure WriteAValue2 (pValue:double);
    function  ReadAValue3:double;        procedure WriteAValue3 (pValue:double);
    function  ReadAValue4:double;        procedure WriteAValue4 (pValue:double);
    function  ReadAValue5:double;        procedure WriteAValue5 (pValue:double);
    function  ReadVatVal:double;         procedure WriteVatVal (pValue:double);
    function  ReadVatVal1:double;        procedure WriteVatVal1 (pValue:double);
    function  ReadVatVal2:double;        procedure WriteVatVal2 (pValue:double);
    function  ReadVatVal3:double;        procedure WriteVatVal3 (pValue:double);
    function  ReadVatVal4:double;        procedure WriteVatVal4 (pValue:double);
    function  ReadVatVal5:double;        procedure WriteVatVal5 (pValue:double);
    function  ReadBValue:double;         procedure WriteBValue (pValue:double);
    function  ReadBValue1:double;        procedure WriteBValue1 (pValue:double);
    function  ReadBValue2:double;        procedure WriteBValue2 (pValue:double);
    function  ReadBValue3:double;        procedure WriteBValue3 (pValue:double);
    function  ReadBValue4:double;        procedure WriteBValue4 (pValue:double);
    function  ReadBValue5:double;        procedure WriteBValue5 (pValue:double);
    function  ReadConDoc:Str12;          procedure WriteConDoc (pValue:Str12);
    function  ReadOcdNum:Str12;          procedure WriteOcdNum (pValue:Str12);
    function  ReadPayMode:Str1;          procedure WritePayMode (pValue:Str1);
    function  ReadRspName:Str30;         procedure WriteRspName (pValue:Str30);
    function  ReadSended:boolean;        procedure WriteSended (pValue:boolean);
    function  ReadVatCls:byte;           procedure WriteVatCls (pValue:byte);
    function  ReadModNum:word;           procedure WriteModNum (pValue:word);
    function  ReadModUser:Str8;          procedure WriteModUser (pValue:Str8);
    function  ReadModDate:TDatetime;     procedure WriteModDate (pValue:TDatetime);
    function  ReadModTime:TDatetime;     procedure WriteModTime (pValue:TDatetime);
    function  ReadActPos:longint;        procedure WriteActPos (pValue:longint);
  public
    // Elementarne databazove operacie
    function Eof: boolean;
    function Active: boolean;
    function LocateRowNum (pRowNum:word):boolean;
    function LocateYearSerNum (pYear:Str2;pSerNum:word):boolean;
    function LocateSerNum (pSerNum:word):boolean;
    function LocateDocNum (pDocNum:Str12):boolean;
    function LocateDocDate (pDocDate:TDatetime):boolean;
    function LocatePaCode (pPaCode:longint):boolean;
    function LocatePaName_ (pPaName_:Str30):boolean;
    function LocatePayMode (pPayMode:Str1):boolean;

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
    property RowNum:word read ReadRowNum write WriteRowNum;
    property Year:Str2 read ReadYear write WriteYear;
    property SerNum:word read ReadSerNum write WriteSerNum;
    property DocNum:Str12 read ReadDocNum write WriteDocNum;
    property DocDate:TDatetime read ReadDocDate write WriteDocDate;
    property PaCode:longint read ReadPaCode write WritePaCode;
    property PaName:Str30 read ReadPaName write WritePaName;
    property PaName_:Str30 read ReadPaName_ write WritePaName_;
    property VatPrc1:byte read ReadVatPrc1 write WriteVatPrc1;
    property VatPrc2:byte read ReadVatPrc2 write WriteVatPrc2;
    property VatPrc3:byte read ReadVatPrc3 write WriteVatPrc3;
    property VatPrc4:byte read ReadVatPrc4 write WriteVatPrc4;
    property VatPrc5:byte read ReadVatPrc5 write WriteVatPrc5;
    property AValue:double read ReadAValue write WriteAValue;
    property AValue1:double read ReadAValue1 write WriteAValue1;
    property AValue2:double read ReadAValue2 write WriteAValue2;
    property AValue3:double read ReadAValue3 write WriteAValue3;
    property AValue4:double read ReadAValue4 write WriteAValue4;
    property AValue5:double read ReadAValue5 write WriteAValue5;
    property VatVal:double read ReadVatVal write WriteVatVal;
    property VatVal1:double read ReadVatVal1 write WriteVatVal1;
    property VatVal2:double read ReadVatVal2 write WriteVatVal2;
    property VatVal3:double read ReadVatVal3 write WriteVatVal3;
    property VatVal4:double read ReadVatVal4 write WriteVatVal4;
    property VatVal5:double read ReadVatVal5 write WriteVatVal5;
    property BValue:double read ReadBValue write WriteBValue;
    property BValue1:double read ReadBValue1 write WriteBValue1;
    property BValue2:double read ReadBValue2 write WriteBValue2;
    property BValue3:double read ReadBValue3 write WriteBValue3;
    property BValue4:double read ReadBValue4 write WriteBValue4;
    property BValue5:double read ReadBValue5 write WriteBValue5;
    property ConDoc:Str12 read ReadConDoc write WriteConDoc;
    property OcdNum:Str12 read ReadOcdNum write WriteOcdNum;
    property PayMode:Str1 read ReadPayMode write WritePayMode;
    property RspName:Str30 read ReadRspName write WriteRspName;
    property Sended:boolean read ReadSended write WriteSended;
    property VatCls:byte read ReadVatCls write WriteVatCls;
    property ModNum:word read ReadModNum write WriteModNum;
    property ModUser:Str8 read ReadModUser write WriteModUser;
    property ModDate:TDatetime read ReadModDate write WriteModDate;
    property ModTime:TDatetime read ReadModTime write WriteModTime;
    property ActPos:longint read ReadActPos write WriteActPos;
  end;

implementation

constructor TSpvTmp.Create;
begin
  oTmpTable := TmpInit ('SPV',Self);
end;

destructor TSpvTmp.Destroy;
begin
  If oTmpTable.Active then oTmpTable.Close;
  FreeAndNil (oTmpTable);
end;

// *************************************** PRIVATE ********************************************

function TSpvTmp.ReadCount:integer;
begin
  Result := oTmpTable.RecordCount;
end;

function TSpvTmp.FieldExist (pFieldName:ShortString): boolean;
begin
  Result := oTmpTable.FindField(pFieldName)<>nil;
end;

function TSpvTmp.ReadRowNum:word;
begin
  Result := oTmpTable.FieldByName('RowNum').AsInteger;
end;

procedure TSpvTmp.WriteRowNum(pValue:word);
begin
  oTmpTable.FieldByName('RowNum').AsInteger := pValue;
end;

function TSpvTmp.ReadYear:Str2;
begin
  Result := oTmpTable.FieldByName('Year').AsString;
end;

procedure TSpvTmp.WriteYear(pValue:Str2);
begin
  oTmpTable.FieldByName('Year').AsString := pValue;
end;

function TSpvTmp.ReadSerNum:word;
begin
  Result := oTmpTable.FieldByName('SerNum').AsInteger;
end;

procedure TSpvTmp.WriteSerNum(pValue:word);
begin
  oTmpTable.FieldByName('SerNum').AsInteger := pValue;
end;

function TSpvTmp.ReadDocNum:Str12;
begin
  Result := oTmpTable.FieldByName('DocNum').AsString;
end;

procedure TSpvTmp.WriteDocNum(pValue:Str12);
begin
  oTmpTable.FieldByName('DocNum').AsString := pValue;
end;

function TSpvTmp.ReadDocDate:TDatetime;
begin
  Result := oTmpTable.FieldByName('DocDate').AsDateTime;
end;

procedure TSpvTmp.WriteDocDate(pValue:TDatetime);
begin
  oTmpTable.FieldByName('DocDate').AsDateTime := pValue;
end;

function TSpvTmp.ReadPaCode:longint;
begin
  Result := oTmpTable.FieldByName('PaCode').AsInteger;
end;

procedure TSpvTmp.WritePaCode(pValue:longint);
begin
  oTmpTable.FieldByName('PaCode').AsInteger := pValue;
end;

function TSpvTmp.ReadPaName:Str30;
begin
  Result := oTmpTable.FieldByName('PaName').AsString;
end;

procedure TSpvTmp.WritePaName(pValue:Str30);
begin
  oTmpTable.FieldByName('PaName').AsString := pValue;
end;

function TSpvTmp.ReadPaName_:Str30;
begin
  Result := oTmpTable.FieldByName('PaName_').AsString;
end;

procedure TSpvTmp.WritePaName_(pValue:Str30);
begin
  oTmpTable.FieldByName('PaName_').AsString := pValue;
end;

function TSpvTmp.ReadVatPrc1:byte;
begin
  Result := oTmpTable.FieldByName('VatPrc1').AsInteger;
end;

procedure TSpvTmp.WriteVatPrc1(pValue:byte);
begin
  oTmpTable.FieldByName('VatPrc1').AsInteger := pValue;
end;

function TSpvTmp.ReadVatPrc2:byte;
begin
  Result := oTmpTable.FieldByName('VatPrc2').AsInteger;
end;

procedure TSpvTmp.WriteVatPrc2(pValue:byte);
begin
  oTmpTable.FieldByName('VatPrc2').AsInteger := pValue;
end;

function TSpvTmp.ReadVatPrc3:byte;
begin
  Result := oTmpTable.FieldByName('VatPrc3').AsInteger;
end;

procedure TSpvTmp.WriteVatPrc3(pValue:byte);
begin
  oTmpTable.FieldByName('VatPrc3').AsInteger := pValue;
end;

function TSpvTmp.ReadVatPrc4:byte;
begin
  Result := oTmpTable.FieldByName('VatPrc4').AsInteger;
end;

procedure TSpvTmp.WriteVatPrc4(pValue:byte);
begin
  oTmpTable.FieldByName('VatPrc4').AsInteger := pValue;
end;

function TSpvTmp.ReadVatPrc5:byte;
begin
  Result := oTmpTable.FieldByName('VatPrc5').AsInteger;
end;

procedure TSpvTmp.WriteVatPrc5(pValue:byte);
begin
  oTmpTable.FieldByName('VatPrc5').AsInteger := pValue;
end;

function TSpvTmp.ReadAValue:double;
begin
  Result := oTmpTable.FieldByName('AValue').AsFloat;
end;

procedure TSpvTmp.WriteAValue(pValue:double);
begin
  oTmpTable.FieldByName('AValue').AsFloat := pValue;
end;

function TSpvTmp.ReadAValue1:double;
begin
  Result := oTmpTable.FieldByName('AValue1').AsFloat;
end;

procedure TSpvTmp.WriteAValue1(pValue:double);
begin
  oTmpTable.FieldByName('AValue1').AsFloat := pValue;
end;

function TSpvTmp.ReadAValue2:double;
begin
  Result := oTmpTable.FieldByName('AValue2').AsFloat;
end;

procedure TSpvTmp.WriteAValue2(pValue:double);
begin
  oTmpTable.FieldByName('AValue2').AsFloat := pValue;
end;

function TSpvTmp.ReadAValue3:double;
begin
  Result := oTmpTable.FieldByName('AValue3').AsFloat;
end;

procedure TSpvTmp.WriteAValue3(pValue:double);
begin
  oTmpTable.FieldByName('AValue3').AsFloat := pValue;
end;

function TSpvTmp.ReadAValue4:double;
begin
  Result := oTmpTable.FieldByName('AValue4').AsFloat;
end;

procedure TSpvTmp.WriteAValue4(pValue:double);
begin
  oTmpTable.FieldByName('AValue4').AsFloat := pValue;
end;

function TSpvTmp.ReadAValue5:double;
begin
  Result := oTmpTable.FieldByName('AValue5').AsFloat;
end;

procedure TSpvTmp.WriteAValue5(pValue:double);
begin
  oTmpTable.FieldByName('AValue5').AsFloat := pValue;
end;

function TSpvTmp.ReadVatVal:double;
begin
  Result := oTmpTable.FieldByName('VatVal').AsFloat;
end;

procedure TSpvTmp.WriteVatVal(pValue:double);
begin
  oTmpTable.FieldByName('VatVal').AsFloat := pValue;
end;

function TSpvTmp.ReadVatVal1:double;
begin
  Result := oTmpTable.FieldByName('VatVal1').AsFloat;
end;

procedure TSpvTmp.WriteVatVal1(pValue:double);
begin
  oTmpTable.FieldByName('VatVal1').AsFloat := pValue;
end;

function TSpvTmp.ReadVatVal2:double;
begin
  Result := oTmpTable.FieldByName('VatVal2').AsFloat;
end;

procedure TSpvTmp.WriteVatVal2(pValue:double);
begin
  oTmpTable.FieldByName('VatVal2').AsFloat := pValue;
end;

function TSpvTmp.ReadVatVal3:double;
begin
  Result := oTmpTable.FieldByName('VatVal3').AsFloat;
end;

procedure TSpvTmp.WriteVatVal3(pValue:double);
begin
  oTmpTable.FieldByName('VatVal3').AsFloat := pValue;
end;

function TSpvTmp.ReadVatVal4:double;
begin
  Result := oTmpTable.FieldByName('VatVal4').AsFloat;
end;

procedure TSpvTmp.WriteVatVal4(pValue:double);
begin
  oTmpTable.FieldByName('VatVal4').AsFloat := pValue;
end;

function TSpvTmp.ReadVatVal5:double;
begin
  Result := oTmpTable.FieldByName('VatVal5').AsFloat;
end;

procedure TSpvTmp.WriteVatVal5(pValue:double);
begin
  oTmpTable.FieldByName('VatVal5').AsFloat := pValue;
end;

function TSpvTmp.ReadBValue:double;
begin
  Result := oTmpTable.FieldByName('BValue').AsFloat;
end;

procedure TSpvTmp.WriteBValue(pValue:double);
begin
  oTmpTable.FieldByName('BValue').AsFloat := pValue;
end;

function TSpvTmp.ReadBValue1:double;
begin
  Result := oTmpTable.FieldByName('BValue1').AsFloat;
end;

procedure TSpvTmp.WriteBValue1(pValue:double);
begin
  oTmpTable.FieldByName('BValue1').AsFloat := pValue;
end;

function TSpvTmp.ReadBValue2:double;
begin
  Result := oTmpTable.FieldByName('BValue2').AsFloat;
end;

procedure TSpvTmp.WriteBValue2(pValue:double);
begin
  oTmpTable.FieldByName('BValue2').AsFloat := pValue;
end;

function TSpvTmp.ReadBValue3:double;
begin
  Result := oTmpTable.FieldByName('BValue3').AsFloat;
end;

procedure TSpvTmp.WriteBValue3(pValue:double);
begin
  oTmpTable.FieldByName('BValue3').AsFloat := pValue;
end;

function TSpvTmp.ReadBValue4:double;
begin
  Result := oTmpTable.FieldByName('BValue4').AsFloat;
end;

procedure TSpvTmp.WriteBValue4(pValue:double);
begin
  oTmpTable.FieldByName('BValue4').AsFloat := pValue;
end;

function TSpvTmp.ReadBValue5:double;
begin
  Result := oTmpTable.FieldByName('BValue5').AsFloat;
end;

procedure TSpvTmp.WriteBValue5(pValue:double);
begin
  oTmpTable.FieldByName('BValue5').AsFloat := pValue;
end;

function TSpvTmp.ReadConDoc:Str12;
begin
  Result := oTmpTable.FieldByName('ConDoc').AsString;
end;

procedure TSpvTmp.WriteConDoc(pValue:Str12);
begin
  oTmpTable.FieldByName('ConDoc').AsString := pValue;
end;

function TSpvTmp.ReadOcdNum:Str12;
begin
  Result := oTmpTable.FieldByName('OcdNum').AsString;
end;

procedure TSpvTmp.WriteOcdNum(pValue:Str12);
begin
  oTmpTable.FieldByName('OcdNum').AsString := pValue;
end;

function TSpvTmp.ReadPayMode:Str1;
begin
  Result := oTmpTable.FieldByName('PayMode').AsString;
end;

procedure TSpvTmp.WritePayMode(pValue:Str1);
begin
  oTmpTable.FieldByName('PayMode').AsString := pValue;
end;

function TSpvTmp.ReadRspName:Str30;
begin
  Result := oTmpTable.FieldByName('RspName').AsString;
end;

procedure TSpvTmp.WriteRspName(pValue:Str30);
begin
  oTmpTable.FieldByName('RspName').AsString := pValue;
end;

function TSpvTmp.ReadSended:boolean;
begin
  Result := ByteToBool(oTmpTable.FieldByName('Sended').AsInteger);
end;

procedure TSpvTmp.WriteSended(pValue:boolean);
begin
  oTmpTable.FieldByName('Sended').AsInteger := BoolToByte(pValue);
end;

function TSpvTmp.ReadVatCls:byte;
begin
  Result := oTmpTable.FieldByName('VatCls').AsInteger;
end;

procedure TSpvTmp.WriteVatCls(pValue:byte);
begin
  oTmpTable.FieldByName('VatCls').AsInteger := pValue;
end;

function TSpvTmp.ReadModNum:word;
begin
  Result := oTmpTable.FieldByName('ModNum').AsInteger;
end;

procedure TSpvTmp.WriteModNum(pValue:word);
begin
  oTmpTable.FieldByName('ModNum').AsInteger := pValue;
end;

function TSpvTmp.ReadModUser:Str8;
begin
  Result := oTmpTable.FieldByName('ModUser').AsString;
end;

procedure TSpvTmp.WriteModUser(pValue:Str8);
begin
  oTmpTable.FieldByName('ModUser').AsString := pValue;
end;

function TSpvTmp.ReadModDate:TDatetime;
begin
  Result := oTmpTable.FieldByName('ModDate').AsDateTime;
end;

procedure TSpvTmp.WriteModDate(pValue:TDatetime);
begin
  oTmpTable.FieldByName('ModDate').AsDateTime := pValue;
end;

function TSpvTmp.ReadModTime:TDatetime;
begin
  Result := oTmpTable.FieldByName('ModTime').AsDateTime;
end;

procedure TSpvTmp.WriteModTime(pValue:TDatetime);
begin
  oTmpTable.FieldByName('ModTime').AsDateTime := pValue;
end;

function TSpvTmp.ReadActPos:longint;
begin
  Result := oTmpTable.FieldByName('ActPos').AsInteger;
end;

procedure TSpvTmp.WriteActPos(pValue:longint);
begin
  oTmpTable.FieldByName('ActPos').AsInteger := pValue;
end;

// **************************************** PUBLIC ********************************************

function TSpvTmp.Eof: boolean;
begin
  Result := oTmpTable.Eof;
end;

function TSpvTmp.Active: boolean;
begin
  Result := oTmpTable.Active;
end;

function TSpvTmp.LocateRowNum (pRowNum:word):boolean;
begin
  SetIndex (ixRowNum);
  Result := oTmpTable.FindKey([pRowNum]);
end;

function TSpvTmp.LocateYearSerNum (pYear:Str2;pSerNum:word):boolean;
begin
  SetIndex (ixYearSerNum);
  Result := oTmpTable.FindKey([pYear,pSerNum]);
end;

function TSpvTmp.LocateSerNum (pSerNum:word):boolean;
begin
  SetIndex (ixSerNum);
  Result := oTmpTable.FindKey([pSerNum]);
end;

function TSpvTmp.LocateDocNum (pDocNum:Str12):boolean;
begin
  SetIndex (ixDocNum);
  Result := oTmpTable.FindKey([pDocNum]);
end;

function TSpvTmp.LocateDocDate (pDocDate:TDatetime):boolean;
begin
  SetIndex (ixDocDate);
  Result := oTmpTable.FindKey([pDocDate]);
end;

function TSpvTmp.LocatePaCode (pPaCode:longint):boolean;
begin
  SetIndex (ixPaCode);
  Result := oTmpTable.FindKey([pPaCode]);
end;

function TSpvTmp.LocatePaName_ (pPaName_:Str30):boolean;
begin
  SetIndex (ixPaName_);
  Result := oTmpTable.FindKey([pPaName_]);
end;

function TSpvTmp.LocatePayMode (pPayMode:Str1):boolean;
begin
  SetIndex (ixPayMode);
  Result := oTmpTable.FindKey([pPayMode]);
end;

procedure TSpvTmp.SetIndex (pIndexName:ShortString);
begin
  If oTmpTable.IndexName<>pIndexName then oTmpTable.IndexName := pIndexName;
end;

procedure TSpvTmp.Open;
begin
  oTmpTable.Open;
end;

procedure TSpvTmp.Close;
begin
  If oTmpTable.Active then oTmpTable.Close;
end;

procedure TSpvTmp.Prior;
begin
  oTmpTable.Prior;
end;

procedure TSpvTmp.Next;
begin
  oTmpTable.Next;
end;

procedure TSpvTmp.First;
begin
  oTmpTable.First;
end;

procedure TSpvTmp.Last;
begin
  oTmpTable.Last;
end;

procedure TSpvTmp.Insert;
begin
  oTmpTable.Insert;
end;

procedure TSpvTmp.Edit;
begin
  oTmpTable.Edit;
end;

procedure TSpvTmp.Post;
var mEdit:boolean;
begin
  oTmpTable.Post;
end;

procedure TSpvTmp.Delete;
begin
  oTmpTable.Delete;
end;

procedure TSpvTmp.SwapIndex;
begin
  oTmpTable.SwapIndex;
end;

procedure TSpvTmp.RestoreIndex;
begin
  oTmpTable.RestoreIndex;
end;

procedure TSpvTmp.SwapStatus;
begin
  oTmpTable.SwapStatus;
end;

procedure TSpvTmp.RestoreStatus;
begin
  oTmpTable.RestoreStatus;
end;

procedure TSpvTmp.EnableControls;
begin
  oTmpTable.EnableControls;
end;

procedure TSpvTmp.DisableControls;
begin
  oTmpTable.DisableControls;
end;

end.
{MOD 2209001}
