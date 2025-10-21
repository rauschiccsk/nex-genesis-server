unit bSPV;

interface

uses
  IcTypes, IcConv, NexPath, NexGlob,
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls,
  Dialogs, DB, NexBtrTable, DBTables, NexPxTable;

const
  ixYearSerNum = 'YearSerNum';
  ixDocNum = 'DocNum';
  ixDocDate = 'DocDate';
  ixPaCode = 'PaCode';
  ixPaName = 'PaName';
  ixPayMode = 'PayMode';
  ixSended = 'Sended';

type
  TSpvBtr = class (TComponent)
    constructor Create; overload;
    destructor  Destroy; override;
  private
    oBookNum: Str5;
    oBtrTable: TNexBtrTable;
    function ReadCount:integer;
    function FieldExist (pFieldName:ShortString): boolean;
    // Pristup k databazovym poliam
    function  ReadSerNum:word;           procedure WriteSerNum (pValue:word);
    function  ReadDocNum:Str12;          procedure WriteDocNum (pValue:Str12);
    function  ReadDocDate:TDatetime;     procedure WriteDocDate (pValue:TDatetime);
    function  ReadPaCode:longint;        procedure WritePaCode (pValue:longint);
    function  ReadPaName:Str30;          procedure WritePaName (pValue:Str30);
    function  ReadPaName_:Str20;         procedure WritePaName_ (pValue:Str20);
    function  ReadVatPrc1:byte;          procedure WriteVatPrc1 (pValue:byte);
    function  ReadVatPrc2:byte;          procedure WriteVatPrc2 (pValue:byte);
    function  ReadVatPrc3:byte;          procedure WriteVatPrc3 (pValue:byte);
    function  ReadAValue:double;         procedure WriteAValue (pValue:double);
    function  ReadAValue1:double;        procedure WriteAValue1 (pValue:double);
    function  ReadAValue2:double;        procedure WriteAValue2 (pValue:double);
    function  ReadAValue3:double;        procedure WriteAValue3 (pValue:double);
    function  ReadVatVal:double;         procedure WriteVatVal (pValue:double);
    function  ReadVatVal1:double;        procedure WriteVatVal1 (pValue:double);
    function  ReadVatVal2:double;        procedure WriteVatVal2 (pValue:double);
    function  ReadVatVal3:double;        procedure WriteVatVal3 (pValue:double);
    function  ReadBValue:double;         procedure WriteBValue (pValue:double);
    function  ReadBValue1:double;        procedure WriteBValue1 (pValue:double);
    function  ReadBValue2:double;        procedure WriteBValue2 (pValue:double);
    function  ReadBValue3:double;        procedure WriteBValue3 (pValue:double);
    function  ReadConDoc:Str12;          procedure WriteConDoc (pValue:Str12);
    function  ReadOcdNum:Str12;          procedure WriteOcdNum (pValue:Str12);
    function  ReadPayMode:Str1;          procedure WritePayMode (pValue:Str1);
    function  ReadRspName:Str30;         procedure WriteRspName (pValue:Str30);
    function  ReadModNum:word;           procedure WriteModNum (pValue:word);
    function  ReadModUser:Str8;          procedure WriteModUser (pValue:Str8);
    function  ReadModDate:TDatetime;     procedure WriteModDate (pValue:TDatetime);
    function  ReadModTime:TDatetime;     procedure WriteModTime (pValue:TDatetime);
    function  ReadSended:boolean;        procedure WriteSended (pValue:boolean);
    function  ReadVatCls:byte;           procedure WriteVatCls (pValue:byte);
    function  ReadYear:Str2;             procedure WriteYear (pValue:Str2);
    function  ReadVatPrc4:byte;          procedure WriteVatPrc4 (pValue:byte);
    function  ReadVatPrc5:byte;          procedure WriteVatPrc5 (pValue:byte);
    function  ReadAValue4:double;        procedure WriteAValue4 (pValue:double);
    function  ReadAValue5:double;        procedure WriteAValue5 (pValue:double);
    function  ReadBValue4:double;        procedure WriteBValue4 (pValue:double);
    function  ReadBValue5:double;        procedure WriteBValue5 (pValue:double);
    function  ReadVatVal4:double;        procedure WriteVatVal4 (pValue:double);
    function  ReadVatVal5:double;        procedure WriteVatVal5 (pValue:double);
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
    function LocateDocDate (pDocDate:TDatetime):boolean;
    function LocatePaCode (pPaCode:longint):boolean;
    function LocatePaName (pPaName_:Str20):boolean;
    function LocatePayMode (pPayMode:Str1):boolean;
    function LocateSended (pSended:byte):boolean;
    function NearestYearSerNum (pYear:Str2;pSerNum:word):boolean;
    function NearestDocNum (pDocNum:Str12):boolean;
    function NearestDocDate (pDocDate:TDatetime):boolean;
    function NearestPaCode (pPaCode:longint):boolean;
    function NearestPaName (pPaName_:Str20):boolean;
    function NearestPayMode (pPayMode:Str1):boolean;
    function NearestSended (pSended:byte):boolean;

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
    property SerNum:word read ReadSerNum write WriteSerNum;
    property DocNum:Str12 read ReadDocNum write WriteDocNum;
    property DocDate:TDatetime read ReadDocDate write WriteDocDate;
    property PaCode:longint read ReadPaCode write WritePaCode;
    property PaName:Str30 read ReadPaName write WritePaName;
    property PaName_:Str20 read ReadPaName_ write WritePaName_;
    property VatPrc1:byte read ReadVatPrc1 write WriteVatPrc1;
    property VatPrc2:byte read ReadVatPrc2 write WriteVatPrc2;
    property VatPrc3:byte read ReadVatPrc3 write WriteVatPrc3;
    property AValue:double read ReadAValue write WriteAValue;
    property AValue1:double read ReadAValue1 write WriteAValue1;
    property AValue2:double read ReadAValue2 write WriteAValue2;
    property AValue3:double read ReadAValue3 write WriteAValue3;
    property VatVal:double read ReadVatVal write WriteVatVal;
    property VatVal1:double read ReadVatVal1 write WriteVatVal1;
    property VatVal2:double read ReadVatVal2 write WriteVatVal2;
    property VatVal3:double read ReadVatVal3 write WriteVatVal3;
    property BValue:double read ReadBValue write WriteBValue;
    property BValue1:double read ReadBValue1 write WriteBValue1;
    property BValue2:double read ReadBValue2 write WriteBValue2;
    property BValue3:double read ReadBValue3 write WriteBValue3;
    property ConDoc:Str12 read ReadConDoc write WriteConDoc;
    property OcdNum:Str12 read ReadOcdNum write WriteOcdNum;
    property PayMode:Str1 read ReadPayMode write WritePayMode;
    property RspName:Str30 read ReadRspName write WriteRspName;
    property ModNum:word read ReadModNum write WriteModNum;
    property ModUser:Str8 read ReadModUser write WriteModUser;
    property ModDate:TDatetime read ReadModDate write WriteModDate;
    property ModTime:TDatetime read ReadModTime write WriteModTime;
    property Sended:boolean read ReadSended write WriteSended;
    property VatCls:byte read ReadVatCls write WriteVatCls;
    property Year:Str2 read ReadYear write WriteYear;
    property VatPrc4:byte read ReadVatPrc4 write WriteVatPrc4;
    property VatPrc5:byte read ReadVatPrc5 write WriteVatPrc5;
    property AValue4:double read ReadAValue4 write WriteAValue4;
    property AValue5:double read ReadAValue5 write WriteAValue5;
    property BValue4:double read ReadBValue4 write WriteBValue4;
    property BValue5:double read ReadBValue5 write WriteBValue5;
    property VatVal4:double read ReadVatVal4 write WriteVatVal4;
    property VatVal5:double read ReadVatVal5 write WriteVatVal5;
  end;

implementation

constructor TSpvBtr.Create;
begin
  oBtrTable := BtrInit ('SPV',gPath.LdgPath,Self);
end;

constructor TSpvBtr.Create(pPath:ShortString);
begin
  oBtrTable := BtrInit ('SPV',pPath,Self);
end;

destructor TSpvBtr.Destroy;
begin
  oBtrTable.Close;  FreeAndNil (oBtrTable);
end;

// *************************************** PRIVATE ********************************************

function TSpvBtr.ReadCount:integer;
begin
  Result := oBtrTable.RecordCount;
end;

function TSpvBtr.FieldExist (pFieldName:ShortString): boolean;
begin
  Result := oBtrTable.FindField(pFieldName)<>nil;
end;

function TSpvBtr.ReadSerNum:word;
begin
  Result := oBtrTable.FieldByName('SerNum').AsInteger;
end;

procedure TSpvBtr.WriteSerNum(pValue:word);
begin
  oBtrTable.FieldByName('SerNum').AsInteger := pValue;
end;

function TSpvBtr.ReadDocNum:Str12;
begin
  Result := oBtrTable.FieldByName('DocNum').AsString;
end;

procedure TSpvBtr.WriteDocNum(pValue:Str12);
begin
  oBtrTable.FieldByName('DocNum').AsString := pValue;
end;

function TSpvBtr.ReadDocDate:TDatetime;
begin
  Result := oBtrTable.FieldByName('DocDate').AsDateTime;
end;

procedure TSpvBtr.WriteDocDate(pValue:TDatetime);
begin
  oBtrTable.FieldByName('DocDate').AsDateTime := pValue;
end;

function TSpvBtr.ReadPaCode:longint;
begin
  Result := oBtrTable.FieldByName('PaCode').AsInteger;
end;

procedure TSpvBtr.WritePaCode(pValue:longint);
begin
  oBtrTable.FieldByName('PaCode').AsInteger := pValue;
end;

function TSpvBtr.ReadPaName:Str30;
begin
  Result := oBtrTable.FieldByName('PaName').AsString;
end;

procedure TSpvBtr.WritePaName(pValue:Str30);
begin
  oBtrTable.FieldByName('PaName').AsString := pValue;
end;

function TSpvBtr.ReadPaName_:Str20;
begin
  Result := oBtrTable.FieldByName('PaName_').AsString;
end;

procedure TSpvBtr.WritePaName_(pValue:Str20);
begin
  oBtrTable.FieldByName('PaName_').AsString := pValue;
end;

function TSpvBtr.ReadVatPrc1:byte;
begin
  Result := oBtrTable.FieldByName('VatPrc1').AsInteger;
end;

procedure TSpvBtr.WriteVatPrc1(pValue:byte);
begin
  oBtrTable.FieldByName('VatPrc1').AsInteger := pValue;
end;

function TSpvBtr.ReadVatPrc2:byte;
begin
  Result := oBtrTable.FieldByName('VatPrc2').AsInteger;
end;

procedure TSpvBtr.WriteVatPrc2(pValue:byte);
begin
  oBtrTable.FieldByName('VatPrc2').AsInteger := pValue;
end;

function TSpvBtr.ReadVatPrc3:byte;
begin
  Result := oBtrTable.FieldByName('VatPrc3').AsInteger;
end;

procedure TSpvBtr.WriteVatPrc3(pValue:byte);
begin
  oBtrTable.FieldByName('VatPrc3').AsInteger := pValue;
end;

function TSpvBtr.ReadAValue:double;
begin
  Result := oBtrTable.FieldByName('AValue').AsFloat;
end;

procedure TSpvBtr.WriteAValue(pValue:double);
begin
  oBtrTable.FieldByName('AValue').AsFloat := pValue;
end;

function TSpvBtr.ReadAValue1:double;
begin
  Result := oBtrTable.FieldByName('AValue1').AsFloat;
end;

procedure TSpvBtr.WriteAValue1(pValue:double);
begin
  oBtrTable.FieldByName('AValue1').AsFloat := pValue;
end;

function TSpvBtr.ReadAValue2:double;
begin
  Result := oBtrTable.FieldByName('AValue2').AsFloat;
end;

procedure TSpvBtr.WriteAValue2(pValue:double);
begin
  oBtrTable.FieldByName('AValue2').AsFloat := pValue;
end;

function TSpvBtr.ReadAValue3:double;
begin
  Result := oBtrTable.FieldByName('AValue3').AsFloat;
end;

procedure TSpvBtr.WriteAValue3(pValue:double);
begin
  oBtrTable.FieldByName('AValue3').AsFloat := pValue;
end;

function TSpvBtr.ReadVatVal:double;
begin
  Result := oBtrTable.FieldByName('VatVal').AsFloat;
end;

procedure TSpvBtr.WriteVatVal(pValue:double);
begin
  oBtrTable.FieldByName('VatVal').AsFloat := pValue;
end;

function TSpvBtr.ReadVatVal1:double;
begin
  Result := oBtrTable.FieldByName('VatVal1').AsFloat;
end;

procedure TSpvBtr.WriteVatVal1(pValue:double);
begin
  oBtrTable.FieldByName('VatVal1').AsFloat := pValue;
end;

function TSpvBtr.ReadVatVal2:double;
begin
  Result := oBtrTable.FieldByName('VatVal2').AsFloat;
end;

procedure TSpvBtr.WriteVatVal2(pValue:double);
begin
  oBtrTable.FieldByName('VatVal2').AsFloat := pValue;
end;

function TSpvBtr.ReadVatVal3:double;
begin
  Result := oBtrTable.FieldByName('VatVal3').AsFloat;
end;

procedure TSpvBtr.WriteVatVal3(pValue:double);
begin
  oBtrTable.FieldByName('VatVal3').AsFloat := pValue;
end;

function TSpvBtr.ReadBValue:double;
begin
  Result := oBtrTable.FieldByName('BValue').AsFloat;
end;

procedure TSpvBtr.WriteBValue(pValue:double);
begin
  oBtrTable.FieldByName('BValue').AsFloat := pValue;
end;

function TSpvBtr.ReadBValue1:double;
begin
  Result := oBtrTable.FieldByName('BValue1').AsFloat;
end;

procedure TSpvBtr.WriteBValue1(pValue:double);
begin
  oBtrTable.FieldByName('BValue1').AsFloat := pValue;
end;

function TSpvBtr.ReadBValue2:double;
begin
  Result := oBtrTable.FieldByName('BValue2').AsFloat;
end;

procedure TSpvBtr.WriteBValue2(pValue:double);
begin
  oBtrTable.FieldByName('BValue2').AsFloat := pValue;
end;

function TSpvBtr.ReadBValue3:double;
begin
  Result := oBtrTable.FieldByName('BValue3').AsFloat;
end;

procedure TSpvBtr.WriteBValue3(pValue:double);
begin
  oBtrTable.FieldByName('BValue3').AsFloat := pValue;
end;

function TSpvBtr.ReadConDoc:Str12;
begin
  Result := oBtrTable.FieldByName('ConDoc').AsString;
end;

procedure TSpvBtr.WriteConDoc(pValue:Str12);
begin
  oBtrTable.FieldByName('ConDoc').AsString := pValue;
end;

function TSpvBtr.ReadOcdNum:Str12;
begin
  Result := oBtrTable.FieldByName('OcdNum').AsString;
end;

procedure TSpvBtr.WriteOcdNum(pValue:Str12);
begin
  oBtrTable.FieldByName('OcdNum').AsString := pValue;
end;

function TSpvBtr.ReadPayMode:Str1;
begin
  Result := oBtrTable.FieldByName('PayMode').AsString;
end;

procedure TSpvBtr.WritePayMode(pValue:Str1);
begin
  oBtrTable.FieldByName('PayMode').AsString := pValue;
end;

function TSpvBtr.ReadRspName:Str30;
begin
  Result := oBtrTable.FieldByName('RspName').AsString;
end;

procedure TSpvBtr.WriteRspName(pValue:Str30);
begin
  oBtrTable.FieldByName('RspName').AsString := pValue;
end;

function TSpvBtr.ReadModNum:word;
begin
  Result := oBtrTable.FieldByName('ModNum').AsInteger;
end;

procedure TSpvBtr.WriteModNum(pValue:word);
begin
  oBtrTable.FieldByName('ModNum').AsInteger := pValue;
end;

function TSpvBtr.ReadModUser:Str8;
begin
  Result := oBtrTable.FieldByName('ModUser').AsString;
end;

procedure TSpvBtr.WriteModUser(pValue:Str8);
begin
  oBtrTable.FieldByName('ModUser').AsString := pValue;
end;

function TSpvBtr.ReadModDate:TDatetime;
begin
  Result := oBtrTable.FieldByName('ModDate').AsDateTime;
end;

procedure TSpvBtr.WriteModDate(pValue:TDatetime);
begin
  oBtrTable.FieldByName('ModDate').AsDateTime := pValue;
end;

function TSpvBtr.ReadModTime:TDatetime;
begin
  Result := oBtrTable.FieldByName('ModTime').AsDateTime;
end;

procedure TSpvBtr.WriteModTime(pValue:TDatetime);
begin
  oBtrTable.FieldByName('ModTime').AsDateTime := pValue;
end;

function TSpvBtr.ReadSended:boolean;
begin
  Result := ByteToBool(oBtrTable.FieldByName('Sended').AsInteger);
end;

procedure TSpvBtr.WriteSended(pValue:boolean);
begin
  oBtrTable.FieldByName('Sended').AsInteger := BoolToByte(pValue);
end;

function TSpvBtr.ReadVatCls:byte;
begin
  Result := oBtrTable.FieldByName('VatCls').AsInteger;
end;

procedure TSpvBtr.WriteVatCls(pValue:byte);
begin
  oBtrTable.FieldByName('VatCls').AsInteger := pValue;
end;

function TSpvBtr.ReadYear:Str2;
begin
  Result := oBtrTable.FieldByName('Year').AsString;
end;

procedure TSpvBtr.WriteYear(pValue:Str2);
begin
  oBtrTable.FieldByName('Year').AsString := pValue;
end;

function TSpvBtr.ReadVatPrc4:byte;
begin
  Result := oBtrTable.FieldByName('VatPrc4').AsInteger;
end;

procedure TSpvBtr.WriteVatPrc4(pValue:byte);
begin
  oBtrTable.FieldByName('VatPrc4').AsInteger := pValue;
end;

function TSpvBtr.ReadVatPrc5:byte;
begin
  Result := oBtrTable.FieldByName('VatPrc5').AsInteger;
end;

procedure TSpvBtr.WriteVatPrc5(pValue:byte);
begin
  oBtrTable.FieldByName('VatPrc5').AsInteger := pValue;
end;

function TSpvBtr.ReadAValue4:double;
begin
  Result := oBtrTable.FieldByName('AValue4').AsFloat;
end;

procedure TSpvBtr.WriteAValue4(pValue:double);
begin
  oBtrTable.FieldByName('AValue4').AsFloat := pValue;
end;

function TSpvBtr.ReadAValue5:double;
begin
  Result := oBtrTable.FieldByName('AValue5').AsFloat;
end;

procedure TSpvBtr.WriteAValue5(pValue:double);
begin
  oBtrTable.FieldByName('AValue5').AsFloat := pValue;
end;

function TSpvBtr.ReadBValue4:double;
begin
  Result := oBtrTable.FieldByName('BValue4').AsFloat;
end;

procedure TSpvBtr.WriteBValue4(pValue:double);
begin
  oBtrTable.FieldByName('BValue4').AsFloat := pValue;
end;

function TSpvBtr.ReadBValue5:double;
begin
  Result := oBtrTable.FieldByName('BValue5').AsFloat;
end;

procedure TSpvBtr.WriteBValue5(pValue:double);
begin
  oBtrTable.FieldByName('BValue5').AsFloat := pValue;
end;

function TSpvBtr.ReadVatVal4:double;
begin
  Result := oBtrTable.FieldByName('VatVal4').AsFloat;
end;

procedure TSpvBtr.WriteVatVal4(pValue:double);
begin
  oBtrTable.FieldByName('VatVal4').AsFloat := pValue;
end;

function TSpvBtr.ReadVatVal5:double;
begin
  Result := oBtrTable.FieldByName('VatVal5').AsFloat;
end;

procedure TSpvBtr.WriteVatVal5(pValue:double);
begin
  oBtrTable.FieldByName('VatVal5').AsFloat := pValue;
end;

// **************************************** PUBLIC ********************************************

function TSpvBtr.Eof: boolean;
begin
  Result := oBtrTable.Eof;
end;

function TSpvBtr.IsFirstRec: boolean;
begin
  Result := oBtrTable.Bof;
end;

function TSpvBtr.IsLastRec: boolean;
begin
  Result := oBtrTable.Eof;
end;

function TSpvBtr.Active: boolean;
begin
  Result := oBtrTable.Active;
end;

function TSpvBtr.ActPos: longint;
begin
  Result := oBtrTable.ActPos;
end;

function TSpvBtr.GotoPos (pActPos:longint): boolean;
begin
  Result := oBtrTable.GotoPos(pActPos);
end;

function TSpvBtr.LocateYearSerNum (pYear:Str2;pSerNum:word):boolean;
begin
  SetIndex (ixYearSerNum);
  Result := oBtrTable.FindKey([pYear,pSerNum]);
end;

function TSpvBtr.LocateDocNum (pDocNum:Str12):boolean;
begin
  SetIndex (ixDocNum);
  Result := oBtrTable.FindKey([pDocNum]);
end;

function TSpvBtr.LocateDocDate (pDocDate:TDatetime):boolean;
begin
  SetIndex (ixDocDate);
  Result := oBtrTable.FindKey([pDocDate]);
end;

function TSpvBtr.LocatePaCode (pPaCode:longint):boolean;
begin
  SetIndex (ixPaCode);
  Result := oBtrTable.FindKey([pPaCode]);
end;

function TSpvBtr.LocatePaName (pPaName_:Str20):boolean;
begin
  SetIndex (ixPaName);
  Result := oBtrTable.FindKey([StrToAlias(pPaName_)]);
end;

function TSpvBtr.LocatePayMode (pPayMode:Str1):boolean;
begin
  SetIndex (ixPayMode);
  Result := oBtrTable.FindKey([pPayMode]);
end;

function TSpvBtr.LocateSended (pSended:byte):boolean;
begin
  SetIndex (ixSended);
  Result := oBtrTable.FindKey([pSended]);
end;

function TSpvBtr.NearestYearSerNum (pYear:Str2;pSerNum:word):boolean;
begin
  SetIndex (ixYearSerNum);
  Result := oBtrTable.FindNearest([pYear,pSerNum]);
end;

function TSpvBtr.NearestDocNum (pDocNum:Str12):boolean;
begin
  SetIndex (ixDocNum);
  Result := oBtrTable.FindNearest([pDocNum]);
end;

function TSpvBtr.NearestDocDate (pDocDate:TDatetime):boolean;
begin
  SetIndex (ixDocDate);
  Result := oBtrTable.FindNearest([pDocDate]);
end;

function TSpvBtr.NearestPaCode (pPaCode:longint):boolean;
begin
  SetIndex (ixPaCode);
  Result := oBtrTable.FindNearest([pPaCode]);
end;

function TSpvBtr.NearestPaName (pPaName_:Str20):boolean;
begin
  SetIndex (ixPaName);
  Result := oBtrTable.FindNearest([pPaName_]);
end;

function TSpvBtr.NearestPayMode (pPayMode:Str1):boolean;
begin
  SetIndex (ixPayMode);
  Result := oBtrTable.FindNearest([pPayMode]);
end;

function TSpvBtr.NearestSended (pSended:byte):boolean;
begin
  SetIndex (ixSended);
  Result := oBtrTable.FindNearest([pSended]);
end;

procedure TSpvBtr.SetIndex (pIndexName:ShortString);
begin
  If oBtrTable.IndexName<>pIndexName then oBtrTable.IndexName := pIndexName;
end;

procedure TSpvBtr.Open(pBookNum:Str5);
begin
  oBookNum := pBookNum;
  oBtrTable.Open(pBookNum);
end;

procedure TSpvBtr.Close;
begin
  If oBtrTable.Active then oBtrTable.Close;
end;

procedure TSpvBtr.Prior;
begin
  oBtrTable.Prior;
end;

procedure TSpvBtr.Next;
begin
  oBtrTable.Next;
end;

procedure TSpvBtr.First;
begin
  oBtrTable.First;
end;

procedure TSpvBtr.Last;
begin
  oBtrTable.Last;
end;

procedure TSpvBtr.Insert;
begin
  oBtrTable.Insert;
end;

procedure TSpvBtr.Edit;
begin
  oBtrTable.Edit;
end;

procedure TSpvBtr.Post;
begin
  oBtrTable.Post;
end;

procedure TSpvBtr.Delete;
begin
  oBtrTable.Delete;
end;

procedure TSpvBtr.SwapIndex;
begin
  oBtrTable.SwapIndex;
end;

procedure TSpvBtr.RestoreIndex;
begin
  oBtrTable.RestoreIndex;
end;

procedure TSpvBtr.SwapStatus;
begin
  oBtrTable.SwapStatus;
end;

procedure TSpvBtr.RestoreStatus;
begin
  oBtrTable.RestoreStatus;
end;

procedure TSpvBtr.EnableControls;
begin
  oBtrTable.EnableControls;
end;

procedure TSpvBtr.DisableControls;
begin
  oBtrTable.DisableControls;
end;

end.
{MOD 2209001}
