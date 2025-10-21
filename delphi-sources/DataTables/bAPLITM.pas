unit bAPLITM;

interface

uses
  IcTypes, IcConv, NexPath, NexGlob,
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls,
  Dialogs, DB, NexBtrTable, DBTables, NexPxTable;

const
  ixAnGs = 'AnGs';
  ixGsCode = 'GsCode';
  ixGsName = 'GsName';
  ixBarCode = 'BarCode';
  ixSended = 'Sended';
  ixActName = 'ActName';
  ixScdNum = 'ScdNum';
  ixSnGs = 'SnGs';

type
  TAplitmBtr = class (TComponent)
    constructor Create; overload;
    destructor  Destroy; override;
  private
    oBtrTable: TNexBtrTable;
    function ReadCount:integer;
    function FieldExist (pFieldName:ShortString): boolean;
    // Pristup k databazovym poliam
    function  ReadAplNum:word;           procedure WriteAplNum (pValue:word);
    function  ReadGsCode:longint;        procedure WriteGsCode (pValue:longint);
    function  ReadGsName:Str30;          procedure WriteGsName (pValue:Str30);
    function  ReadGsName_:Str20;         procedure WriteGsName_ (pValue:Str20);
    function  ReadBarCode:Str15;         procedure WriteBarCode (pValue:Str15);
    function  ReadBegDate:TDatetime;     procedure WriteBegDate (pValue:TDatetime);
    function  ReadEndDate:TDatetime;     procedure WriteEndDate (pValue:TDatetime);
    function  ReadVatPrc:byte;           procedure WriteVatPrc (pValue:byte);
    function  ReadPcAPrice:double;       procedure WritePcAPrice (pValue:double);
    function  ReadPcBPrice:double;       procedure WritePcBPrice (pValue:double);
    function  ReadAcAPrice:double;       procedure WriteAcAPrice (pValue:double);
    function  ReadAcBPrice:double;       procedure WriteAcBPrice (pValue:double);
    function  ReadDifPrc:double;         procedure WriteDifPrc (pValue:double);
    function  ReadSended:boolean;        procedure WriteSended (pValue:boolean);
    function  ReadCrtUser:Str8;          procedure WriteCrtUser (pValue:Str8);
    function  ReadCrtDate:TDatetime;     procedure WriteCrtDate (pValue:TDatetime);
    function  ReadCrtTime:TDatetime;     procedure WriteCrtTime (pValue:TDatetime);
    function  ReadModNum:word;           procedure WriteModNum (pValue:word);
    function  ReadModUser:Str8;          procedure WriteModUser (pValue:Str8);
    function  ReadModDate:TDatetime;     procedure WriteModDate (pValue:TDatetime);
    function  ReadModTime:TDatetime;     procedure WriteModTime (pValue:TDatetime);
    function  ReadActName:Str10;         procedure WriteActName (pValue:Str10);
    function  ReadScdNum:Str12;          procedure WriteScdNum (pValue:Str12);
    function  ReadBegTime:TDatetime;     procedure WriteBegTime (pValue:TDatetime);
    function  ReadEndTime:TDatetime;     procedure WriteEndTime (pValue:TDatetime);
    function  ReadTimeInt:byte;          procedure WriteTimeInt (pValue:byte);
    function  ReadMinQnt:double;         procedure WriteMinQnt (pValue:double);
    function  ReadPeriod:Str7;           procedure WritePeriod (pValue:Str7);
    function  ReadAcType:Str1;           procedure WriteAcType (pValue:Str1);
  public
    constructor Create(pPath:ShortString); overload;
    // Elementarne databazove operacie
    function Eof: boolean;
    function IsFirstRec: boolean;
    function IsLastRec: boolean;
    function Active: boolean;
    function ActPos: longint;
    function GotoPos (pActPos:longint): boolean;
    function LocateAnGs (pAplNum:word;pGsCode:longint):boolean;
    function LocateGsCode (pGsCode:longint):boolean;
    function LocateGsName (pGsName_:Str20):boolean;
    function LocateBarCode (pBarCode:Str15):boolean;
    function LocateSended (pSended:byte):boolean;
    function LocateActName (pActName:Str10):boolean;
    function LocateScdNum (pScdNum:Str12):boolean;
    function LocateSnGs (pScdNum:Str12;pGsCode:longint):boolean;
    function NearestAnGs (pAplNum:word;pGsCode:longint):boolean;
    function NearestGsCode (pGsCode:longint):boolean;
    function NearestGsName (pGsName_:Str20):boolean;
    function NearestBarCode (pBarCode:Str15):boolean;
    function NearestSended (pSended:byte):boolean;
    function NearestActName (pActName:Str10):boolean;
    function NearestScdNum (pScdNum:Str12):boolean;
    function NearestSnGs (pScdNum:Str12;pGsCode:longint):boolean;

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
    procedure EnableControls;
    procedure DisableControls;
  published
    property BtrTable:TNexBtrTable read oBtrTable;
    property Count:integer read ReadCount;
    // Pristup k databazovym poliam
    property AplNum:word read ReadAplNum write WriteAplNum;
    property GsCode:longint read ReadGsCode write WriteGsCode;
    property GsName:Str30 read ReadGsName write WriteGsName;
    property GsName_:Str20 read ReadGsName_ write WriteGsName_;
    property BarCode:Str15 read ReadBarCode write WriteBarCode;
    property BegDate:TDatetime read ReadBegDate write WriteBegDate;
    property EndDate:TDatetime read ReadEndDate write WriteEndDate;
    property VatPrc:byte read ReadVatPrc write WriteVatPrc;
    property PcAPrice:double read ReadPcAPrice write WritePcAPrice;
    property PcBPrice:double read ReadPcBPrice write WritePcBPrice;
    property AcAPrice:double read ReadAcAPrice write WriteAcAPrice;
    property AcBPrice:double read ReadAcBPrice write WriteAcBPrice;
    property DifPrc:double read ReadDifPrc write WriteDifPrc;
    property Sended:boolean read ReadSended write WriteSended;
    property CrtUser:Str8 read ReadCrtUser write WriteCrtUser;
    property CrtDate:TDatetime read ReadCrtDate write WriteCrtDate;
    property CrtTime:TDatetime read ReadCrtTime write WriteCrtTime;
    property ModNum:word read ReadModNum write WriteModNum;
    property ModUser:Str8 read ReadModUser write WriteModUser;
    property ModDate:TDatetime read ReadModDate write WriteModDate;
    property ModTime:TDatetime read ReadModTime write WriteModTime;
    property ActName:Str10 read ReadActName write WriteActName;
    property ScdNum:Str12 read ReadScdNum write WriteScdNum;
    property BegTime:TDatetime read ReadBegTime write WriteBegTime;
    property EndTime:TDatetime read ReadEndTime write WriteEndTime;
    property TimeInt:byte read ReadTimeInt write WriteTimeInt;
    property MinQnt:double read ReadMinQnt write WriteMinQnt;
    property Period:Str7 read ReadPeriod write WritePeriod;
    property AcType:Str1 read ReadAcType write WriteAcType;
  end;

implementation

constructor TAplitmBtr.Create;
begin
  oBtrTable := BtrInit ('APLITM',gPath.StkPath,Self);
end;

constructor TAplitmBtr.Create(pPath:ShortString);
begin
  oBtrTable := BtrInit ('APLITM',pPath,Self);
end;

destructor TAplitmBtr.Destroy;
begin
  oBtrTable.Close;  FreeAndNil (oBtrTable);
end;

// *************************************** PRIVATE ********************************************

function TAplitmBtr.ReadCount:integer;
begin
  Result := oBtrTable.RecordCount;
end;

function TAplitmBtr.FieldExist (pFieldName:ShortString): boolean;
begin
  Result := oBtrTable.FindField(pFieldName)<>nil;
end;

function TAplitmBtr.ReadAplNum:word;
begin
  Result := oBtrTable.FieldByName('AplNum').AsInteger;
end;

procedure TAplitmBtr.WriteAplNum(pValue:word);
begin
  oBtrTable.FieldByName('AplNum').AsInteger := pValue;
end;

function TAplitmBtr.ReadGsCode:longint;
begin
  Result := oBtrTable.FieldByName('GsCode').AsInteger;
end;

procedure TAplitmBtr.WriteGsCode(pValue:longint);
begin
  oBtrTable.FieldByName('GsCode').AsInteger := pValue;
end;

function TAplitmBtr.ReadGsName:Str30;
begin
  Result := oBtrTable.FieldByName('GsName').AsString;
end;

procedure TAplitmBtr.WriteGsName(pValue:Str30);
begin
  oBtrTable.FieldByName('GsName').AsString := pValue;
end;

function TAplitmBtr.ReadGsName_:Str20;
begin
  Result := oBtrTable.FieldByName('GsName_').AsString;
end;

procedure TAplitmBtr.WriteGsName_(pValue:Str20);
begin
  oBtrTable.FieldByName('GsName_').AsString := pValue;
end;

function TAplitmBtr.ReadBarCode:Str15;
begin
  Result := oBtrTable.FieldByName('BarCode').AsString;
end;

procedure TAplitmBtr.WriteBarCode(pValue:Str15);
begin
  oBtrTable.FieldByName('BarCode').AsString := pValue;
end;

function TAplitmBtr.ReadBegDate:TDatetime;
begin
  Result := oBtrTable.FieldByName('BegDate').AsDateTime;
end;

procedure TAplitmBtr.WriteBegDate(pValue:TDatetime);
begin
  oBtrTable.FieldByName('BegDate').AsDateTime := pValue;
end;

function TAplitmBtr.ReadEndDate:TDatetime;
begin
  Result := oBtrTable.FieldByName('EndDate').AsDateTime;
end;

procedure TAplitmBtr.WriteEndDate(pValue:TDatetime);
begin
  oBtrTable.FieldByName('EndDate').AsDateTime := pValue;
end;

function TAplitmBtr.ReadVatPrc:byte;
begin
  Result := oBtrTable.FieldByName('VatPrc').AsInteger;
end;

procedure TAplitmBtr.WriteVatPrc(pValue:byte);
begin
  oBtrTable.FieldByName('VatPrc').AsInteger := pValue;
end;

function TAplitmBtr.ReadPcAPrice:double;
begin
  Result := oBtrTable.FieldByName('PcAPrice').AsFloat;
end;

procedure TAplitmBtr.WritePcAPrice(pValue:double);
begin
  oBtrTable.FieldByName('PcAPrice').AsFloat := pValue;
end;

function TAplitmBtr.ReadPcBPrice:double;
begin
  Result := oBtrTable.FieldByName('PcBPrice').AsFloat;
end;

procedure TAplitmBtr.WritePcBPrice(pValue:double);
begin
  oBtrTable.FieldByName('PcBPrice').AsFloat := pValue;
end;

function TAplitmBtr.ReadAcAPrice:double;
begin
  Result := oBtrTable.FieldByName('AcAPrice').AsFloat;
end;

procedure TAplitmBtr.WriteAcAPrice(pValue:double);
begin
  oBtrTable.FieldByName('AcAPrice').AsFloat := pValue;
end;

function TAplitmBtr.ReadAcBPrice:double;
begin
  Result := oBtrTable.FieldByName('AcBPrice').AsFloat;
end;

procedure TAplitmBtr.WriteAcBPrice(pValue:double);
begin
  oBtrTable.FieldByName('AcBPrice').AsFloat := pValue;
end;

function TAplitmBtr.ReadDifPrc:double;
begin
  Result := oBtrTable.FieldByName('DifPrc').AsFloat;
end;

procedure TAplitmBtr.WriteDifPrc(pValue:double);
begin
  oBtrTable.FieldByName('DifPrc').AsFloat := pValue;
end;

function TAplitmBtr.ReadSended:boolean;
begin
  Result := ByteToBool(oBtrTable.FieldByName('Sended').AsInteger);
end;

procedure TAplitmBtr.WriteSended(pValue:boolean);
begin
  oBtrTable.FieldByName('Sended').AsInteger := BoolToByte(pValue);
end;

function TAplitmBtr.ReadCrtUser:Str8;
begin
  Result := oBtrTable.FieldByName('CrtUser').AsString;
end;

procedure TAplitmBtr.WriteCrtUser(pValue:Str8);
begin
  oBtrTable.FieldByName('CrtUser').AsString := pValue;
end;

function TAplitmBtr.ReadCrtDate:TDatetime;
begin
  Result := oBtrTable.FieldByName('CrtDate').AsDateTime;
end;

procedure TAplitmBtr.WriteCrtDate(pValue:TDatetime);
begin
  oBtrTable.FieldByName('CrtDate').AsDateTime := pValue;
end;

function TAplitmBtr.ReadCrtTime:TDatetime;
begin
  Result := oBtrTable.FieldByName('CrtTime').AsDateTime;
end;

procedure TAplitmBtr.WriteCrtTime(pValue:TDatetime);
begin
  oBtrTable.FieldByName('CrtTime').AsDateTime := pValue;
end;

function TAplitmBtr.ReadModNum:word;
begin
  Result := oBtrTable.FieldByName('ModNum').AsInteger;
end;

procedure TAplitmBtr.WriteModNum(pValue:word);
begin
  oBtrTable.FieldByName('ModNum').AsInteger := pValue;
end;

function TAplitmBtr.ReadModUser:Str8;
begin
  Result := oBtrTable.FieldByName('ModUser').AsString;
end;

procedure TAplitmBtr.WriteModUser(pValue:Str8);
begin
  oBtrTable.FieldByName('ModUser').AsString := pValue;
end;

function TAplitmBtr.ReadModDate:TDatetime;
begin
  Result := oBtrTable.FieldByName('ModDate').AsDateTime;
end;

procedure TAplitmBtr.WriteModDate(pValue:TDatetime);
begin
  oBtrTable.FieldByName('ModDate').AsDateTime := pValue;
end;

function TAplitmBtr.ReadModTime:TDatetime;
begin
  Result := oBtrTable.FieldByName('ModTime').AsDateTime;
end;

procedure TAplitmBtr.WriteModTime(pValue:TDatetime);
begin
  oBtrTable.FieldByName('ModTime').AsDateTime := pValue;
end;

function TAplitmBtr.ReadActName:Str10;
begin
  Result := oBtrTable.FieldByName('ActName').AsString;
end;

procedure TAplitmBtr.WriteActName(pValue:Str10);
begin
  oBtrTable.FieldByName('ActName').AsString := pValue;
end;

function TAplitmBtr.ReadScdNum:Str12;
begin
  Result := oBtrTable.FieldByName('ScdNum').AsString;
end;

procedure TAplitmBtr.WriteScdNum(pValue:Str12);
begin
  oBtrTable.FieldByName('ScdNum').AsString := pValue;
end;

function TAplitmBtr.ReadBegTime:TDatetime;
begin
  Result := oBtrTable.FieldByName('BegTime').AsDateTime;
end;

procedure TAplitmBtr.WriteBegTime(pValue:TDatetime);
begin
  oBtrTable.FieldByName('BegTime').AsDateTime := pValue;
end;

function TAplitmBtr.ReadEndTime:TDatetime;
begin
  Result := oBtrTable.FieldByName('EndTime').AsDateTime;
end;

procedure TAplitmBtr.WriteEndTime(pValue:TDatetime);
begin
  oBtrTable.FieldByName('EndTime').AsDateTime := pValue;
end;

function TAplitmBtr.ReadTimeInt:byte;
begin
  Result := oBtrTable.FieldByName('TimeInt').AsInteger;
end;

procedure TAplitmBtr.WriteTimeInt(pValue:byte);
begin
  oBtrTable.FieldByName('TimeInt').AsInteger := pValue;
end;

function TAplitmBtr.ReadMinQnt:double;
begin
  Result := oBtrTable.FieldByName('MinQnt').AsFloat;
end;

procedure TAplitmBtr.WriteMinQnt(pValue:double);
begin
  oBtrTable.FieldByName('MinQnt').AsFloat := pValue;
end;

function TAplitmBtr.ReadPeriod:Str7;
begin
  Result := oBtrTable.FieldByName('Period').AsString;
end;

procedure TAplitmBtr.WritePeriod(pValue:Str7);
begin
  oBtrTable.FieldByName('Period').AsString := pValue;
end;

function TAplitmBtr.ReadAcType:Str1;
begin
  Result := oBtrTable.FieldByName('AcType').AsString;
end;

procedure TAplitmBtr.WriteAcType(pValue:Str1);
begin
  oBtrTable.FieldByName('AcType').AsString := pValue;
end;
// **************************************** PUBLIC ********************************************

function TAplitmBtr.Eof: boolean;
begin
  Result := oBtrTable.Eof;
end;

function TAplitmBtr.IsFirstRec: boolean;
begin
  Result := oBtrTable.Bof;
end;

function TAplitmBtr.IsLastRec: boolean;
begin
  Result := oBtrTable.Eof;
end;

function TAplitmBtr.Active: boolean;
begin
  Result := oBtrTable.Active;
end;

function TAplitmBtr.ActPos: longint;
begin
  Result := oBtrTable.ActPos;
end;

function TAplitmBtr.GotoPos (pActPos:longint): boolean;
begin
  Result := oBtrTable.GotoPos(pActPos);
end;

function TAplitmBtr.LocateAnGs (pAplNum:word;pGsCode:longint):boolean;
begin
  SetIndex (ixAnGs);
  Result := oBtrTable.FindKey([pAplNum,pGsCode]);
end;

function TAplitmBtr.LocateGsCode (pGsCode:longint):boolean;
begin
  SetIndex (ixGsCode);
  Result := oBtrTable.FindKey([pGsCode]);
end;

function TAplitmBtr.LocateGsName (pGsName_:Str20):boolean;
begin
  SetIndex (ixGsName);
  Result := oBtrTable.FindKey([StrToAlias(pGsName_)]);
end;

function TAplitmBtr.LocateBarCode (pBarCode:Str15):boolean;
begin
  SetIndex (ixBarCode);
  Result := oBtrTable.FindKey([pBarCode]);
end;

function TAplitmBtr.LocateSended (pSended:byte):boolean;
begin
  SetIndex (ixSended);
  Result := oBtrTable.FindKey([pSended]);
end;

function TAplitmBtr.LocateActName (pActName:Str10):boolean;
begin
  SetIndex (ixActName);
  Result := oBtrTable.FindKey([pActName]);
end;

function TAplitmBtr.LocateScdNum (pScdNum:Str12):boolean;
begin
  SetIndex (ixScdNum);
  Result := oBtrTable.FindKey([pScdNum]);
end;

function TAplitmBtr.LocateSnGs (pScdNum:Str12;pGsCode:longint):boolean;
begin
  SetIndex (ixSnGs);
  Result := oBtrTable.FindKey([pScdNum,pGsCode]);
end;

function TAplitmBtr.NearestAnGs (pAplNum:word;pGsCode:longint):boolean;
begin
  SetIndex (ixAnGs);
  Result := oBtrTable.FindNearest([pAplNum,pGsCode]);
end;

function TAplitmBtr.NearestGsCode (pGsCode:longint):boolean;
begin
  SetIndex (ixGsCode);
  Result := oBtrTable.FindNearest([pGsCode]);
end;

function TAplitmBtr.NearestGsName (pGsName_:Str20):boolean;
begin
  SetIndex (ixGsName);
  Result := oBtrTable.FindNearest([pGsName_]);
end;

function TAplitmBtr.NearestBarCode (pBarCode:Str15):boolean;
begin
  SetIndex (ixBarCode);
  Result := oBtrTable.FindNearest([pBarCode]);
end;

function TAplitmBtr.NearestSended (pSended:byte):boolean;
begin
  SetIndex (ixSended);
  Result := oBtrTable.FindNearest([pSended]);
end;

function TAplitmBtr.NearestActName (pActName:Str10):boolean;
begin
  SetIndex (ixActName);
  Result := oBtrTable.FindNearest([pActName]);
end;

function TAplitmBtr.NearestScdNum (pScdNum:Str12):boolean;
begin
  SetIndex (ixScdNum);
  Result := oBtrTable.FindNearest([pScdNum]);
end;

function TAplitmBtr.NearestSnGs (pScdNum:Str12;pGsCode:longint):boolean;
begin
  SetIndex (ixSnGs);
  Result := oBtrTable.FindNearest([pScdNum,pGsCode]);
end;

procedure TAplitmBtr.SetIndex (pIndexName:ShortString);
begin
  If oBtrTable.IndexName<>pIndexName then oBtrTable.IndexName := pIndexName;
end;

procedure TAplitmBtr.Open;
begin
  oBtrTable.Open;
end;

procedure TAplitmBtr.Close;
begin
  If oBtrTable.Active then oBtrTable.Close;
end;

procedure TAplitmBtr.Prior;
begin
  oBtrTable.Prior;
end;

procedure TAplitmBtr.Next;
begin
  oBtrTable.Next;
end;

procedure TAplitmBtr.First;
begin
  oBtrTable.First;
end;

procedure TAplitmBtr.Last;
begin
  oBtrTable.Last;
end;

procedure TAplitmBtr.Insert;
begin
  oBtrTable.Insert;
end;

procedure TAplitmBtr.Edit;
begin
  oBtrTable.Edit;
end;

procedure TAplitmBtr.Post;
begin
  oBtrTable.Post;
end;

procedure TAplitmBtr.Delete;
begin
  oBtrTable.Delete;
end;

procedure TAplitmBtr.SwapIndex;
begin
  oBtrTable.SwapIndex;
end;

procedure TAplitmBtr.RestoreIndex;
begin
  oBtrTable.RestoreIndex;
end;

procedure TAplitmBtr.SwapStatus;
begin
  oBtrTable.SwapStatus;
end;

procedure TAplitmBtr.RestoreStatus;
begin
  oBtrTable.RestoreStatus;
end;

procedure TAplitmBtr.EnableControls;
begin
  oBtrTable.EnableControls;
end;

procedure TAplitmBtr.DisableControls;
begin
  oBtrTable.DisableControls;
end;

end.
