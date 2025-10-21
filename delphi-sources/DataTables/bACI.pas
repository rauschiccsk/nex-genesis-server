unit bACI;

interface

uses
  IcTypes, IcConv, NexPath, NexGlob,
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls,
  Dialogs, DB, NexBtrTable, DBTables, NexPxTable;

const
  ixDocNum = 'DocNum';
  ixDoGs = 'DoGs';
  ixGsCode = 'GsCode';
  ixGsName = 'GsName';
  ixBarCode = 'BarCode';
  ixStkCode = 'StkCode';
  ixStatus = 'Status';

type
  TAciBtr = class (TComponent)
    constructor Create; overload;
    destructor  Destroy; override;
  private
    oBookNum: Str5;
    oBtrTable: TNexBtrTable;
    function ReadCount:integer;
    function FieldExist (pFieldName:ShortString): boolean;
    // Pristup k databazovym poliam
    function  ReadDocNum:Str12;          procedure WriteDocNum (pValue:Str12);
    function  ReadGsCode:longint;        procedure WriteGsCode (pValue:longint);
    function  ReadMgCode:word;           procedure WriteMgCode (pValue:word);
    function  ReadGsName:Str30;          procedure WriteGsName (pValue:Str30);
    function  ReadGsName_:Str30;         procedure WriteGsName_ (pValue:Str30);
    function  ReadBarCode:Str15;         procedure WriteBarCode (pValue:Str15);
    function  ReadStkCode:Str15;         procedure WriteStkCode (pValue:Str15);
    function  ReadMsName:Str10;          procedure WriteMsName (pValue:Str10);
    function  ReadStkCPrice:double;      procedure WriteStkCPrice (pValue:double);
    function  ReadBefBPrice:double;      procedure WriteBefBPrice (pValue:double);
    function  ReadNewBPrice:double;      procedure WriteNewBPrice (pValue:double);
    function  ReadAftBPrice:double;      procedure WriteAftBPrice (pValue:double);
    function  ReadBefProfit:double;      procedure WriteBefProfit (pValue:double);
    function  ReadNewProfit:double;      procedure WriteNewProfit (pValue:double);
    function  ReadAftProfit:double;      procedure WriteAftProfit (pValue:double);
    function  ReadBegDate:TDatetime;     procedure WriteBegDate (pValue:TDatetime);
    function  ReadEndDate:TDatetime;     procedure WriteEndDate (pValue:TDatetime);
    function  ReadStatus:Str1;           procedure WriteStatus (pValue:Str1);
    function  ReadCrtUser:Str8;          procedure WriteCrtUser (pValue:Str8);
    function  ReadCrtDate:TDatetime;     procedure WriteCrtDate (pValue:TDatetime);
    function  ReadCrtTime:TDatetime;     procedure WriteCrtTime (pValue:TDatetime);
    function  ReadModUser:Str8;          procedure WriteModUser (pValue:Str8);
    function  ReadModDate:TDatetime;     procedure WriteModDate (pValue:TDatetime);
    function  ReadModTime:TDatetime;     procedure WriteModTime (pValue:TDatetime);
    function  ReadVatPrc:byte;           procedure WriteVatPrc (pValue:byte);
    function  ReadActPos:Str2;           procedure WriteActPos (pValue:Str2);
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
    function LocateDoGs (pDocNum:Str12;pGsCode:longint):boolean;
    function LocateGsCode (pGsCode:longint):boolean;
    function LocateGsName (pGsName_:Str30):boolean;
    function LocateBarCode (pBarCode:Str15):boolean;
    function LocateStkCode (pStkCode:Str15):boolean;
    function LocateStatus (pStatus:Str1):boolean;
    function NearestDocNum (pDocNum:Str12):boolean;
    function NearestDoGs (pDocNum:Str12;pGsCode:longint):boolean;
    function NearestGsCode (pGsCode:longint):boolean;
    function NearestGsName (pGsName_:Str30):boolean;
    function NearestBarCode (pBarCode:Str15):boolean;
    function NearestStkCode (pStkCode:Str15):boolean;
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
    property DocNum:Str12 read ReadDocNum write WriteDocNum;
    property GsCode:longint read ReadGsCode write WriteGsCode;
    property MgCode:word read ReadMgCode write WriteMgCode;
    property GsName:Str30 read ReadGsName write WriteGsName;
    property GsName_:Str30 read ReadGsName_ write WriteGsName_;
    property BarCode:Str15 read ReadBarCode write WriteBarCode;
    property StkCode:Str15 read ReadStkCode write WriteStkCode;
    property MsName:Str10 read ReadMsName write WriteMsName;
    property StkCPrice:double read ReadStkCPrice write WriteStkCPrice;
    property BefBPrice:double read ReadBefBPrice write WriteBefBPrice;
    property NewBPrice:double read ReadNewBPrice write WriteNewBPrice;
    property AftBPrice:double read ReadAftBPrice write WriteAftBPrice;
    property BefProfit:double read ReadBefProfit write WriteBefProfit;
    property NewProfit:double read ReadNewProfit write WriteNewProfit;
    property AftProfit:double read ReadAftProfit write WriteAftProfit;
    property BegDate:TDatetime read ReadBegDate write WriteBegDate;
    property EndDate:TDatetime read ReadEndDate write WriteEndDate;
    property Status:Str1 read ReadStatus write WriteStatus;
    property CrtUser:Str8 read ReadCrtUser write WriteCrtUser;
    property CrtDate:TDatetime read ReadCrtDate write WriteCrtDate;
    property CrtTime:TDatetime read ReadCrtTime write WriteCrtTime;
    property ModUser:Str8 read ReadModUser write WriteModUser;
    property ModDate:TDatetime read ReadModDate write WriteModDate;
    property ModTime:TDatetime read ReadModTime write WriteModTime;
    property VatPrc:byte read ReadVatPrc write WriteVatPrc;
    property ActPosM:Str2 read ReadActPos write WriteActPos;
  end;

implementation

constructor TAciBtr.Create;
begin
  oBtrTable := BtrInit ('ACI',gPath.StkPath,Self);
end;

constructor TAciBtr.Create(pPath:ShortString);
begin
  oBtrTable := BtrInit ('ACI',pPath,Self);
end;

destructor TAciBtr.Destroy;
begin
  oBtrTable.Close;  FreeAndNil (oBtrTable);
end;

// *************************************** PRIVATE ********************************************

function TAciBtr.ReadCount:integer;
begin
  Result := oBtrTable.RecordCount;
end;

function TAciBtr.FieldExist (pFieldName:ShortString): boolean;
begin
  Result := oBtrTable.FindField(pFieldName)<>nil;
end;

function TAciBtr.ReadDocNum:Str12;
begin
  Result := oBtrTable.FieldByName('DocNum').AsString;
end;

procedure TAciBtr.WriteDocNum(pValue:Str12);
begin
  oBtrTable.FieldByName('DocNum').AsString := pValue;
end;

function TAciBtr.ReadGsCode:longint;
begin
  Result := oBtrTable.FieldByName('GsCode').AsInteger;
end;

procedure TAciBtr.WriteGsCode(pValue:longint);
begin
  oBtrTable.FieldByName('GsCode').AsInteger := pValue;
end;

function TAciBtr.ReadMgCode:word;
begin
  Result := oBtrTable.FieldByName('MgCode').AsInteger;
end;

procedure TAciBtr.WriteMgCode(pValue:word);
begin
  oBtrTable.FieldByName('MgCode').AsInteger := pValue;
end;

function TAciBtr.ReadGsName:Str30;
begin
  Result := oBtrTable.FieldByName('GsName').AsString;
end;

procedure TAciBtr.WriteGsName(pValue:Str30);
begin
  oBtrTable.FieldByName('GsName').AsString := pValue;
end;

function TAciBtr.ReadGsName_:Str30;
begin
  Result := oBtrTable.FieldByName('GsName_').AsString;
end;

procedure TAciBtr.WriteGsName_(pValue:Str30);
begin
  oBtrTable.FieldByName('GsName_').AsString := pValue;
end;

function TAciBtr.ReadBarCode:Str15;
begin
  Result := oBtrTable.FieldByName('BarCode').AsString;
end;

procedure TAciBtr.WriteBarCode(pValue:Str15);
begin
  oBtrTable.FieldByName('BarCode').AsString := pValue;
end;

function TAciBtr.ReadStkCode:Str15;
begin
  Result := oBtrTable.FieldByName('StkCode').AsString;
end;

procedure TAciBtr.WriteStkCode(pValue:Str15);
begin
  oBtrTable.FieldByName('StkCode').AsString := pValue;
end;

function TAciBtr.ReadMsName:Str10;
begin
  Result := oBtrTable.FieldByName('MsName').AsString;
end;

procedure TAciBtr.WriteMsName(pValue:Str10);
begin
  oBtrTable.FieldByName('MsName').AsString := pValue;
end;

function TAciBtr.ReadStkCPrice:double;
begin
  Result := oBtrTable.FieldByName('StkCPrice').AsFloat;
end;

procedure TAciBtr.WriteStkCPrice(pValue:double);
begin
  oBtrTable.FieldByName('StkCPrice').AsFloat := pValue;
end;

function TAciBtr.ReadBefBPrice:double;
begin
  Result := oBtrTable.FieldByName('BefBPrice').AsFloat;
end;

procedure TAciBtr.WriteBefBPrice(pValue:double);
begin
  oBtrTable.FieldByName('BefBPrice').AsFloat := pValue;
end;

function TAciBtr.ReadNewBPrice:double;
begin
  Result := oBtrTable.FieldByName('NewBPrice').AsFloat;
end;

procedure TAciBtr.WriteNewBPrice(pValue:double);
begin
  oBtrTable.FieldByName('NewBPrice').AsFloat := pValue;
end;

function TAciBtr.ReadAftBPrice:double;
begin
  Result := oBtrTable.FieldByName('AftBPrice').AsFloat;
end;

procedure TAciBtr.WriteAftBPrice(pValue:double);
begin
  oBtrTable.FieldByName('AftBPrice').AsFloat := pValue;
end;

function TAciBtr.ReadBefProfit:double;
begin
  Result := oBtrTable.FieldByName('BefProfit').AsFloat;
end;

procedure TAciBtr.WriteBefProfit(pValue:double);
begin
  oBtrTable.FieldByName('BefProfit').AsFloat := pValue;
end;

function TAciBtr.ReadNewProfit:double;
begin
  Result := oBtrTable.FieldByName('NewProfit').AsFloat;
end;

procedure TAciBtr.WriteNewProfit(pValue:double);
begin
  oBtrTable.FieldByName('NewProfit').AsFloat := pValue;
end;

function TAciBtr.ReadAftProfit:double;
begin
  Result := oBtrTable.FieldByName('AftProfit').AsFloat;
end;

procedure TAciBtr.WriteAftProfit(pValue:double);
begin
  oBtrTable.FieldByName('AftProfit').AsFloat := pValue;
end;

function TAciBtr.ReadBegDate:TDatetime;
begin
  Result := oBtrTable.FieldByName('BegDate').AsDateTime;
end;

procedure TAciBtr.WriteBegDate(pValue:TDatetime);
begin
  oBtrTable.FieldByName('BegDate').AsDateTime := pValue;
end;

function TAciBtr.ReadEndDate:TDatetime;
begin
  Result := oBtrTable.FieldByName('EndDate').AsDateTime;
end;

procedure TAciBtr.WriteEndDate(pValue:TDatetime);
begin
  oBtrTable.FieldByName('EndDate').AsDateTime := pValue;
end;

function TAciBtr.ReadStatus:Str1;
begin
  Result := oBtrTable.FieldByName('Status').AsString;
end;

procedure TAciBtr.WriteStatus(pValue:Str1);
begin
  oBtrTable.FieldByName('Status').AsString := pValue;
end;

function TAciBtr.ReadCrtUser:Str8;
begin
  Result := oBtrTable.FieldByName('CrtUser').AsString;
end;

procedure TAciBtr.WriteCrtUser(pValue:Str8);
begin
  oBtrTable.FieldByName('CrtUser').AsString := pValue;
end;

function TAciBtr.ReadCrtDate:TDatetime;
begin
  Result := oBtrTable.FieldByName('CrtDate').AsDateTime;
end;

procedure TAciBtr.WriteCrtDate(pValue:TDatetime);
begin
  oBtrTable.FieldByName('CrtDate').AsDateTime := pValue;
end;

function TAciBtr.ReadCrtTime:TDatetime;
begin
  Result := oBtrTable.FieldByName('CrtTime').AsDateTime;
end;

procedure TAciBtr.WriteCrtTime(pValue:TDatetime);
begin
  oBtrTable.FieldByName('CrtTime').AsDateTime := pValue;
end;

function TAciBtr.ReadModUser:Str8;
begin
  Result := oBtrTable.FieldByName('ModUser').AsString;
end;

procedure TAciBtr.WriteModUser(pValue:Str8);
begin
  oBtrTable.FieldByName('ModUser').AsString := pValue;
end;

function TAciBtr.ReadModDate:TDatetime;
begin
  Result := oBtrTable.FieldByName('ModDate').AsDateTime;
end;

procedure TAciBtr.WriteModDate(pValue:TDatetime);
begin
  oBtrTable.FieldByName('ModDate').AsDateTime := pValue;
end;

function TAciBtr.ReadModTime:TDatetime;
begin
  Result := oBtrTable.FieldByName('ModTime').AsDateTime;
end;

procedure TAciBtr.WriteModTime(pValue:TDatetime);
begin
  oBtrTable.FieldByName('ModTime').AsDateTime := pValue;
end;

function TAciBtr.ReadVatPrc:byte;
begin
  Result := oBtrTable.FieldByName('VatPrc').AsInteger;
end;

procedure TAciBtr.WriteVatPrc(pValue:byte);
begin
  oBtrTable.FieldByName('VatPrc').AsInteger := pValue;
end;

function TAciBtr.ReadActPos:Str2;
begin
  Result := oBtrTable.FieldByName('ActPos').AsString;
end;

procedure TAciBtr.WriteActPos(pValue:Str2);
begin
  oBtrTable.FieldByName('ActPos').AsString := pValue;
end;

// **************************************** PUBLIC ********************************************

function TAciBtr.Eof: boolean;
begin
  Result := oBtrTable.Eof;
end;

function TAciBtr.IsFirstRec: boolean;
begin
  Result := oBtrTable.Bof;
end;

function TAciBtr.IsLastRec: boolean;
begin
  Result := oBtrTable.Eof;
end;

function TAciBtr.Active: boolean;
begin
  Result := oBtrTable.Active;
end;

function TAciBtr.ActPos: longint;
begin
  Result := oBtrTable.ActPos;
end;

function TAciBtr.GotoPos (pActPos:longint): boolean;
begin
  Result := oBtrTable.GotoPos(pActPos);
end;

function TAciBtr.LocateDocNum (pDocNum:Str12):boolean;
begin
  SetIndex (ixDocNum);
  Result := oBtrTable.FindKey([pDocNum]);
end;

function TAciBtr.LocateDoGs (pDocNum:Str12;pGsCode:longint):boolean;
begin
  SetIndex (ixDoGs);
  Result := oBtrTable.FindKey([pDocNum,pGsCode]);
end;

function TAciBtr.LocateGsCode (pGsCode:longint):boolean;
begin
  SetIndex (ixGsCode);
  Result := oBtrTable.FindKey([pGsCode]);
end;

function TAciBtr.LocateGsName (pGsName_:Str30):boolean;
begin
  SetIndex (ixGsName);
  Result := oBtrTable.FindKey([StrToAlias(pGsName_)]);
end;

function TAciBtr.LocateBarCode (pBarCode:Str15):boolean;
begin
  SetIndex (ixBarCode);
  Result := oBtrTable.FindKey([pBarCode]);
end;

function TAciBtr.LocateStkCode (pStkCode:Str15):boolean;
begin
  SetIndex (ixStkCode);
  Result := oBtrTable.FindKey([pStkCode]);
end;

function TAciBtr.LocateStatus (pStatus:Str1):boolean;
begin
  SetIndex (ixStatus);
  Result := oBtrTable.FindKey([pStatus]);
end;

function TAciBtr.NearestDocNum (pDocNum:Str12):boolean;
begin
  SetIndex (ixDocNum);
  Result := oBtrTable.FindNearest([pDocNum]);
end;

function TAciBtr.NearestDoGs (pDocNum:Str12;pGsCode:longint):boolean;
begin
  SetIndex (ixDoGs);
  Result := oBtrTable.FindNearest([pDocNum,pGsCode]);
end;

function TAciBtr.NearestGsCode (pGsCode:longint):boolean;
begin
  SetIndex (ixGsCode);
  Result := oBtrTable.FindNearest([pGsCode]);
end;

function TAciBtr.NearestGsName (pGsName_:Str30):boolean;
begin
  SetIndex (ixGsName);
  Result := oBtrTable.FindNearest([pGsName_]);
end;

function TAciBtr.NearestBarCode (pBarCode:Str15):boolean;
begin
  SetIndex (ixBarCode);
  Result := oBtrTable.FindNearest([pBarCode]);
end;

function TAciBtr.NearestStkCode (pStkCode:Str15):boolean;
begin
  SetIndex (ixStkCode);
  Result := oBtrTable.FindNearest([pStkCode]);
end;

function TAciBtr.NearestStatus (pStatus:Str1):boolean;
begin
  SetIndex (ixStatus);
  Result := oBtrTable.FindNearest([pStatus]);
end;

procedure TAciBtr.SetIndex (pIndexName:ShortString);
begin
  If oBtrTable.IndexName<>pIndexName then oBtrTable.IndexName := pIndexName;
end;

procedure TAciBtr.Open(pBookNum:Str5);
begin
  oBookNum := pBookNum;
  oBtrTable.Open(pBookNum);
end;

procedure TAciBtr.Close;
begin
  If oBtrTable.Active then oBtrTable.Close;
end;

procedure TAciBtr.Prior;
begin
  oBtrTable.Prior;
end;

procedure TAciBtr.Next;
begin
  oBtrTable.Next;
end;

procedure TAciBtr.First;
begin
  oBtrTable.First;
end;

procedure TAciBtr.Last;
begin
  oBtrTable.Last;
end;

procedure TAciBtr.Insert;
begin
  oBtrTable.Insert;
end;

procedure TAciBtr.Edit;
begin
  oBtrTable.Edit;
end;

procedure TAciBtr.Post;
begin
  oBtrTable.Post;
end;

procedure TAciBtr.Delete;
begin
  oBtrTable.Delete;
end;

procedure TAciBtr.SwapIndex;
begin
  oBtrTable.SwapIndex;
end;

procedure TAciBtr.RestoreIndex;
begin
  oBtrTable.RestoreIndex;
end;

procedure TAciBtr.SwapStatus;
begin
  oBtrTable.SwapStatus;
end;

procedure TAciBtr.RestoreStatus;
begin
  oBtrTable.RestoreStatus;
end;

procedure TAciBtr.EnableControls;
begin
  oBtrTable.EnableControls;
end;

procedure TAciBtr.DisableControls;
begin
  oBtrTable.DisableControls;
end;

end.
