unit bCPH;

interface

uses
  IcTypes, IcConv, NexPath, NexGlob,
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls,
  Dialogs, DB, NexBtrTable, DBTables, NexPxTable;

const
  ixPdCode = 'PdCode';
  ixPdName = 'PdName';
  ixSended = 'Sended';

type
  TCphBtr = class (TComponent)
    constructor Create; overload;
    destructor  Destroy; override;
  private
    oBookNum: Str5;
    oBtrTable: TNexBtrTable;
    function ReadCount:integer;
    function FieldExist (pFieldName:ShortString): boolean;
    // Pristup k databazovym poliam
    function  ReadPdCode:longint;        procedure WritePdCode (pValue:longint);
    function  ReadPdName:Str30;          procedure WritePdName (pValue:Str30);
    function  ReadPdName_:Str30;         procedure WritePdName_ (pValue:Str30);
    function  ReadBarCode:Str15;         procedure WriteBarCode (pValue:Str15);
    function  ReadVatPrc:byte;           procedure WriteVatPrc (pValue:byte);
    function  ReadPdGsQnt:double;        procedure WritePdGsQnt (pValue:double);
    function  ReadMsName:Str10;          procedure WriteMsName (pValue:Str10);
    function  ReadCValue:double;         procedure WriteCValue (pValue:double);
    function  ReadCPrice:double;         procedure WriteCPrice (pValue:double);
    function  ReadPrfPrc:double;         procedure WritePrfPrc (pValue:double);
    function  ReadAPrice:double;         procedure WriteAPrice (pValue:double);
    function  ReadBPrice:double;         procedure WriteBPrice (pValue:double);
    function  ReadItmQnt:word;           procedure WriteItmQnt (pValue:word);
    function  ReadSended:boolean;        procedure WriteSended (pValue:boolean);
    function  ReadCrtUser:Str8;          procedure WriteCrtUser (pValue:Str8);
    function  ReadCrtDate:TDatetime;     procedure WriteCrtDate (pValue:TDatetime);
    function  ReadCrtTime:TDatetime;     procedure WriteCrtTime (pValue:TDatetime);
    function  ReadModNum:word;           procedure WriteModNum (pValue:word);
    function  ReadModUser:Str8;          procedure WriteModUser (pValue:Str8);
    function  ReadModDate:TDatetime;     procedure WriteModDate (pValue:TDatetime);
    function  ReadModTime:TDatetime;     procedure WriteModTime (pValue:TDatetime);
    function  ReadDValue:double;         procedure WriteDValue (pValue:double);
    function  ReadHValue:double;         procedure WriteHValue (pValue:double);
    function  ReadDscPrc:double;         procedure WriteDscPrc (pValue:double);
    function  ReadDscAvl:double;         procedure WriteDscAvl (pValue:double);
    function  ReadDscBvl:double;         procedure WriteDscBvl (pValue:double);
    function  ReadAValue:double;         procedure WriteAValue (pValue:double);
    function  ReadBValue:double;         procedure WriteBValue (pValue:double);
    function  ReadCpiVal:double;         procedure WriteCpiVal (pValue:double);
    function  ReadCpsVal:double;         procedure WriteCpsVal (pValue:double);
  public
    constructor Create(pPath:ShortString); overload;
    // Elementarne databazove operacie
    function Eof: boolean;
    function IsFirstRec: boolean;
    function IsLastRec: boolean;
    function Active: boolean;
    function ActPos: longint;
    function GotoPos (pActPos:longint): boolean;
    function LocatePdCode (pPdCode:longint):boolean;
    function LocatePdName (pPdName_:Str30):boolean;
    function LocateSended (pSended:byte):boolean;
    function NearestPdCode (pPdCode:longint):boolean;
    function NearestPdName (pPdName_:Str30):boolean;
    function NearestSended (pSended:byte):boolean;

    procedure SetIndex (pIndexName:ShortString);
    procedure Open (pBookNum:Str5);
    procedure Close;
    procedure Prior;
    procedure Next;
    procedure First;
    procedure Last;
    procedure Insert;
    procedure Edit;
    procedure Post; virtual;
    procedure Delete;
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
    property PdCode:longint read ReadPdCode write WritePdCode;
    property PdName:Str30 read ReadPdName write WritePdName;
    property PdName_:Str30 read ReadPdName_ write WritePdName_;
    property BarCode:Str15 read ReadBarCode write WriteBarCode;
    property VatPrc:byte read ReadVatPrc write WriteVatPrc;
    property PdGsQnt:double read ReadPdGsQnt write WritePdGsQnt;
    property MsName:Str10 read ReadMsName write WriteMsName;
    property CValue:double read ReadCValue write WriteCValue;
    property CPrice:double read ReadCPrice write WriteCPrice;
    property PrfPrc:double read ReadPrfPrc write WritePrfPrc;
    property APrice:double read ReadAPrice write WriteAPrice;
    property BPrice:double read ReadBPrice write WriteBPrice;
    property ItmQnt:word read ReadItmQnt write WriteItmQnt;
    property Sended:boolean read ReadSended write WriteSended;
    property CrtUser:Str8 read ReadCrtUser write WriteCrtUser;
    property CrtDate:TDatetime read ReadCrtDate write WriteCrtDate;
    property CrtTime:TDatetime read ReadCrtTime write WriteCrtTime;
    property ModNum:word read ReadModNum write WriteModNum;
    property ModUser:Str8 read ReadModUser write WriteModUser;
    property ModDate:TDatetime read ReadModDate write WriteModDate;
    property ModTime:TDatetime read ReadModTime write WriteModTime;
    property DValue:double read ReadDValue write WriteDValue;
    property HValue:double read ReadHValue write WriteHValue;
    property DscPrc:double read ReadDscPrc write WriteDscPrc;
    property DscAvl:double read ReadDscAvl write WriteDscAvl;
    property DscBvl:double read ReadDscBvl write WriteDscBvl;
    property AValue:double read ReadAValue write WriteAValue;
    property BValue:double read ReadBValue write WriteBValue;
    property CpiVal:double read ReadCpiVal write WriteCpiVal;
    property CpsVal:double read ReadCpsVal write WriteCpsVal;
  end;

implementation

constructor TCphBtr.Create;
begin
  oBtrTable := BtrInit ('CPH',gPath.StkPath,Self);
end;

constructor TCphBtr.Create(pPath:ShortString);
begin
  oBtrTable := BtrInit ('CPH',pPath,Self);
end;

destructor TCphBtr.Destroy;
begin
  oBtrTable.Close;  FreeAndNil (oBtrTable);
end;

// *************************************** PRIVATE ********************************************

function TCphBtr.ReadCount:integer;
begin
  Result := oBtrTable.RecordCount;
end;

function TCphBtr.FieldExist (pFieldName:ShortString): boolean;
begin
  Result := oBtrTable.FindField(pFieldName)<>nil;
end;

function TCphBtr.ReadPdCode:longint;
begin
  Result := oBtrTable.FieldByName('PdCode').AsInteger;
end;

procedure TCphBtr.WritePdCode(pValue:longint);
begin
  oBtrTable.FieldByName('PdCode').AsInteger := pValue;
end;

function TCphBtr.ReadPdName:Str30;
begin
  Result := oBtrTable.FieldByName('PdName').AsString;
end;

procedure TCphBtr.WritePdName(pValue:Str30);
begin
  oBtrTable.FieldByName('PdName').AsString := pValue;
end;

function TCphBtr.ReadPdName_:Str30;
begin
  Result := oBtrTable.FieldByName('PdName_').AsString;
end;

procedure TCphBtr.WritePdName_(pValue:Str30);
begin
  oBtrTable.FieldByName('PdName_').AsString := pValue;
end;

function TCphBtr.ReadBarCode:Str15;
begin
  Result := oBtrTable.FieldByName('BarCode').AsString;
end;

procedure TCphBtr.WriteBarCode(pValue:Str15);
begin
  oBtrTable.FieldByName('BarCode').AsString := pValue;
end;

function TCphBtr.ReadVatPrc:byte;
begin
  Result := oBtrTable.FieldByName('VatPrc').AsInteger;
end;

procedure TCphBtr.WriteVatPrc(pValue:byte);
begin
  oBtrTable.FieldByName('VatPrc').AsInteger := pValue;
end;

function TCphBtr.ReadPdGsQnt:double;
begin
  Result := oBtrTable.FieldByName('PdGsQnt').AsFloat;
end;

procedure TCphBtr.WritePdGsQnt(pValue:double);
begin
  oBtrTable.FieldByName('PdGsQnt').AsFloat := pValue;
end;

function TCphBtr.ReadMsName:Str10;
begin
  Result := oBtrTable.FieldByName('MsName').AsString;
end;

procedure TCphBtr.WriteMsName(pValue:Str10);
begin
  oBtrTable.FieldByName('MsName').AsString := pValue;
end;

function TCphBtr.ReadCValue:double;
begin
  Result := oBtrTable.FieldByName('CValue').AsFloat;
end;

procedure TCphBtr.WriteCValue(pValue:double);
begin
  oBtrTable.FieldByName('CValue').AsFloat := pValue;
end;

function TCphBtr.ReadCPrice:double;
begin
  Result := oBtrTable.FieldByName('CPrice').AsFloat;
end;

procedure TCphBtr.WriteCPrice(pValue:double);
begin
  oBtrTable.FieldByName('CPrice').AsFloat := pValue;
end;

function TCphBtr.ReadPrfPrc:double;
begin
  Result := oBtrTable.FieldByName('PrfPrc').AsFloat;
end;

procedure TCphBtr.WritePrfPrc(pValue:double);
begin
  oBtrTable.FieldByName('PrfPrc').AsFloat := pValue;
end;

function TCphBtr.ReadAPrice:double;
begin
  Result := oBtrTable.FieldByName('APrice').AsFloat;
end;

procedure TCphBtr.WriteAPrice(pValue:double);
begin
  oBtrTable.FieldByName('APrice').AsFloat := pValue;
end;

function TCphBtr.ReadBPrice:double;
begin
  Result := oBtrTable.FieldByName('BPrice').AsFloat;
end;

procedure TCphBtr.WriteBPrice(pValue:double);
begin
  oBtrTable.FieldByName('BPrice').AsFloat := pValue;
end;

function TCphBtr.ReadItmQnt:word;
begin
  Result := oBtrTable.FieldByName('ItmQnt').AsInteger;
end;

procedure TCphBtr.WriteItmQnt(pValue:word);
begin
  oBtrTable.FieldByName('ItmQnt').AsInteger := pValue;
end;

function TCphBtr.ReadSended:boolean;
begin
  Result := ByteToBool(oBtrTable.FieldByName('Sended').AsInteger);
end;

procedure TCphBtr.WriteSended(pValue:boolean);
begin
  oBtrTable.FieldByName('Sended').AsInteger := BoolToByte(pValue);
end;

function TCphBtr.ReadCrtUser:Str8;
begin
  Result := oBtrTable.FieldByName('CrtUser').AsString;
end;

procedure TCphBtr.WriteCrtUser(pValue:Str8);
begin
  oBtrTable.FieldByName('CrtUser').AsString := pValue;
end;

function TCphBtr.ReadCrtDate:TDatetime;
begin
  Result := oBtrTable.FieldByName('CrtDate').AsDateTime;
end;

procedure TCphBtr.WriteCrtDate(pValue:TDatetime);
begin
  oBtrTable.FieldByName('CrtDate').AsDateTime := pValue;
end;

function TCphBtr.ReadCrtTime:TDatetime;
begin
  Result := oBtrTable.FieldByName('CrtTime').AsDateTime;
end;

procedure TCphBtr.WriteCrtTime(pValue:TDatetime);
begin
  oBtrTable.FieldByName('CrtTime').AsDateTime := pValue;
end;

function TCphBtr.ReadModNum:word;
begin
  Result := oBtrTable.FieldByName('ModNum').AsInteger;
end;

procedure TCphBtr.WriteModNum(pValue:word);
begin
  oBtrTable.FieldByName('ModNum').AsInteger := pValue;
end;

function TCphBtr.ReadModUser:Str8;
begin
  Result := oBtrTable.FieldByName('ModUser').AsString;
end;

procedure TCphBtr.WriteModUser(pValue:Str8);
begin
  oBtrTable.FieldByName('ModUser').AsString := pValue;
end;

function TCphBtr.ReadModDate:TDatetime;
begin
  Result := oBtrTable.FieldByName('ModDate').AsDateTime;
end;

procedure TCphBtr.WriteModDate(pValue:TDatetime);
begin
  oBtrTable.FieldByName('ModDate').AsDateTime := pValue;
end;

function TCphBtr.ReadModTime:TDatetime;
begin
  Result := oBtrTable.FieldByName('ModTime').AsDateTime;
end;

procedure TCphBtr.WriteModTime(pValue:TDatetime);
begin
  oBtrTable.FieldByName('ModTime').AsDateTime := pValue;
end;

function TCphBtr.ReadDValue:double;
begin
  Result := oBtrTable.FieldByName('DValue').AsFloat;
end;

procedure TCphBtr.WriteDValue(pValue:double);
begin
  oBtrTable.FieldByName('DValue').AsFloat := pValue;
end;

function TCphBtr.ReadHValue:double;
begin
  Result := oBtrTable.FieldByName('HValue').AsFloat;
end;

procedure TCphBtr.WriteHValue(pValue:double);
begin
  oBtrTable.FieldByName('HValue').AsFloat := pValue;
end;

function TCphBtr.ReadDscPrc:double;
begin
  Result := oBtrTable.FieldByName('DscPrc').AsFloat;
end;

procedure TCphBtr.WriteDscPrc(pValue:double);
begin
  oBtrTable.FieldByName('DscPrc').AsFloat := pValue;
end;

function TCphBtr.ReadDscAvl:double;
begin
  Result := oBtrTable.FieldByName('DscAvl').AsFloat;
end;

procedure TCphBtr.WriteDscAvl(pValue:double);
begin
  oBtrTable.FieldByName('DscAvl').AsFloat := pValue;
end;

function TCphBtr.ReadDscBvl:double;
begin
  Result := oBtrTable.FieldByName('DscBvl').AsFloat;
end;

procedure TCphBtr.WriteDscBvl(pValue:double);
begin
  oBtrTable.FieldByName('DscBvl').AsFloat := pValue;
end;

function TCphBtr.ReadAValue:double;
begin
  Result := oBtrTable.FieldByName('AValue').AsFloat;
end;

procedure TCphBtr.WriteAValue(pValue:double);
begin
  oBtrTable.FieldByName('AValue').AsFloat := pValue;
end;

function TCphBtr.ReadBValue:double;
begin
  Result := oBtrTable.FieldByName('BValue').AsFloat;
end;

procedure TCphBtr.WriteBValue(pValue:double);
begin
  oBtrTable.FieldByName('BValue').AsFloat := pValue;
end;

function TCphBtr.ReadCpiVal:double;
begin
  Result := oBtrTable.FieldByName('CpiVal').AsFloat;
end;

procedure TCphBtr.WriteCpiVal(pValue:double);
begin
  oBtrTable.FieldByName('CpiVal').AsFloat := pValue;
end;

function TCphBtr.ReadCpsVal:double;
begin
  Result := oBtrTable.FieldByName('CpsVal').AsFloat;
end;

procedure TCphBtr.WriteCpsVal(pValue:double);
begin
  oBtrTable.FieldByName('CpsVal').AsFloat := pValue;
end;

// **************************************** PUBLIC ********************************************

function TCphBtr.Eof: boolean;
begin
  Result := oBtrTable.Eof;
end;

function TCphBtr.IsFirstRec: boolean;
begin
  Result := oBtrTable.Bof;
end;

function TCphBtr.IsLastRec: boolean;
begin
  Result := oBtrTable.Eof;
end;

function TCphBtr.Active: boolean;
begin
  Result := oBtrTable.Active;
end;

function TCphBtr.ActPos: longint;
begin
  Result := oBtrTable.ActPos;
end;

function TCphBtr.GotoPos (pActPos:longint): boolean;
begin
  Result := oBtrTable.GotoPos(pActPos);
end;

function TCphBtr.LocatePdCode (pPdCode:longint):boolean;
begin
  SetIndex (ixPdCode);
  Result := oBtrTable.FindKey([pPdCode]);
end;

function TCphBtr.LocatePdName (pPdName_:Str30):boolean;
begin
  SetIndex (ixPdName);
  Result := oBtrTable.FindKey([StrToAlias(pPdName_)]);
end;

function TCphBtr.LocateSended (pSended:byte):boolean;
begin
  SetIndex (ixSended);
  Result := oBtrTable.FindKey([pSended]);
end;

function TCphBtr.NearestPdCode (pPdCode:longint):boolean;
begin
  SetIndex (ixPdCode);
  Result := oBtrTable.FindNearest([pPdCode]);
end;

function TCphBtr.NearestPdName (pPdName_:Str30):boolean;
begin
  SetIndex (ixPdName);
  Result := oBtrTable.FindNearest([pPdName_]);
end;

function TCphBtr.NearestSended (pSended:byte):boolean;
begin
  SetIndex (ixSended);
  Result := oBtrTable.FindNearest([pSended]);
end;

procedure TCphBtr.SetIndex (pIndexName:ShortString);
begin
  If oBtrTable.IndexName<>pIndexName then oBtrTable.IndexName := pIndexName;
end;

procedure TCphBtr.Open(pBookNum:Str5);
begin
  oBookNum := pBookNum;
  oBtrTable.Open(pBookNum);
end;

procedure TCphBtr.Close;
begin
  If oBtrTable.Active then oBtrTable.Close;
end;

procedure TCphBtr.Prior;
begin
  oBtrTable.Prior;
end;

procedure TCphBtr.Next;
begin
  oBtrTable.Next;
end;

procedure TCphBtr.First;
begin
  oBtrTable.First;
end;

procedure TCphBtr.Last;
begin
  oBtrTable.Last;
end;

procedure TCphBtr.Insert;
begin
  oBtrTable.Insert;
end;

procedure TCphBtr.Edit;
begin
  oBtrTable.Edit;
end;

procedure TCphBtr.Post;
begin
  oBtrTable.Post;
end;

procedure TCphBtr.Delete;
begin
  oBtrTable.Delete;
end;

procedure TCphBtr.SwapIndex;
begin
  oBtrTable.SwapIndex;
end;

procedure TCphBtr.RestoreIndex;
begin
  oBtrTable.RestoreIndex;
end;

procedure TCphBtr.SwapStatus;
begin
  oBtrTable.SwapStatus;
end;

procedure TCphBtr.RestoreStatus;
begin
  oBtrTable.RestoreStatus;
end;

procedure TCphBtr.EnableControls;
begin
  oBtrTable.EnableControls;
end;

procedure TCphBtr.DisableControls;
begin
  oBtrTable.DisableControls;
end;

end.
