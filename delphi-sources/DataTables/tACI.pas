unit tACI;

interface

uses
  IcTypes, IcConv, NexPath, NexGlob, DocHand, 
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls,
  Dialogs, DB, NexBtrTable, DBTables, NexPxTable;

const
  ixDoGs = '';
  ixGsCode = 'GsCode';
  ixGsName_ = 'GsName_';
  ixBarCode = 'BarCode';
  ixStkCode = 'StkCode';

type
  TAciTmp = class (TComponent)
    constructor Create;
    destructor  Destroy; override;
  private
    oTmpTable: TNexPxTable;
    function ReadCount:integer;
    function FieldExist (pFieldName:ShortString): boolean;
    // Pristup k databazovym poliam
    function  ReadDocNum:Str12;          procedure WriteDocNum (pValue:Str12);
    function  ReadGsCode:longint;        procedure WriteGsCode (pValue:longint);
    function  ReadMgCode:longint;        procedure WriteMgCode (pValue:longint);
    function  ReadGsName:Str30;          procedure WriteGsName (pValue:Str30);
    function  ReadGsName_:Str30;         procedure WriteGsName_ (pValue:Str30);
    function  ReadBarCode:Str15;         procedure WriteBarCode (pValue:Str15);
    function  ReadStkCode:Str15;         procedure WriteStkCode (pValue:Str15);
    function  ReadMsName:Str10;          procedure WriteMsName (pValue:Str10);
    function  ReadVatPrc:byte;           procedure WriteVatPrc (pValue:byte);
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
    function  ReadActPos:longint;        procedure WriteActPos (pValue:longint);
  public
    // Elementarne databazove operacie
    function Eof: boolean;
    function Active: boolean;
    function LocateDoGs (pDocNum:Str12;pGsCode:longint):boolean;
    function LocateGsCode (pGsCode:longint):boolean;
    function LocateGsName_ (pGsName_:Str30):boolean;
    function LocateBarCode (pBarCode:Str15):boolean;
    function LocateStkCode (pStkCode:Str15):boolean;

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
    property GsCode:longint read ReadGsCode write WriteGsCode;
    property MgCode:longint read ReadMgCode write WriteMgCode;
    property GsName:Str30 read ReadGsName write WriteGsName;
    property GsName_:Str30 read ReadGsName_ write WriteGsName_;
    property BarCode:Str15 read ReadBarCode write WriteBarCode;
    property StkCode:Str15 read ReadStkCode write WriteStkCode;
    property MsName:Str10 read ReadMsName write WriteMsName;
    property VatPrc:byte read ReadVatPrc write WriteVatPrc;
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
    property ActPos:longint read ReadActPos write WriteActPos;
  end;

implementation

constructor TAciTmp.Create;
begin
  oTmpTable := TmpInit ('ACI',Self);
end;

destructor TAciTmp.Destroy;
begin
  If oTmpTable.Active then oTmpTable.Close;
  FreeAndNil (oTmpTable);
end;

// *************************************** PRIVATE ********************************************

function TAciTmp.ReadCount:integer;
begin
  Result := oTmpTable.RecordCount;
end;

function TAciTmp.FieldExist (pFieldName:ShortString): boolean;
begin
  Result := oTmpTable.FindField(pFieldName)<>nil;
end;

function TAciTmp.ReadDocNum:Str12;
begin
  Result := oTmpTable.FieldByName('DocNum').AsString;
end;

procedure TAciTmp.WriteDocNum(pValue:Str12);
begin
  oTmpTable.FieldByName('DocNum').AsString := pValue;
end;

function TAciTmp.ReadGsCode:longint;
begin
  Result := oTmpTable.FieldByName('GsCode').AsInteger;
end;

procedure TAciTmp.WriteGsCode(pValue:longint);
begin
  oTmpTable.FieldByName('GsCode').AsInteger := pValue;
end;

function TAciTmp.ReadMgCode:longint;
begin
  Result := oTmpTable.FieldByName('MgCode').AsInteger;
end;

procedure TAciTmp.WriteMgCode(pValue:longint);
begin
  oTmpTable.FieldByName('MgCode').AsInteger := pValue;
end;

function TAciTmp.ReadGsName:Str30;
begin
  Result := oTmpTable.FieldByName('GsName').AsString;
end;

procedure TAciTmp.WriteGsName(pValue:Str30);
begin
  oTmpTable.FieldByName('GsName').AsString := pValue;
end;

function TAciTmp.ReadGsName_:Str30;
begin
  Result := oTmpTable.FieldByName('GsName_').AsString;
end;

procedure TAciTmp.WriteGsName_(pValue:Str30);
begin
  oTmpTable.FieldByName('GsName_').AsString := pValue;
end;

function TAciTmp.ReadBarCode:Str15;
begin
  Result := oTmpTable.FieldByName('BarCode').AsString;
end;

procedure TAciTmp.WriteBarCode(pValue:Str15);
begin
  oTmpTable.FieldByName('BarCode').AsString := pValue;
end;

function TAciTmp.ReadStkCode:Str15;
begin
  Result := oTmpTable.FieldByName('StkCode').AsString;
end;

procedure TAciTmp.WriteStkCode(pValue:Str15);
begin
  oTmpTable.FieldByName('StkCode').AsString := pValue;
end;

function TAciTmp.ReadMsName:Str10;
begin
  Result := oTmpTable.FieldByName('MsName').AsString;
end;

procedure TAciTmp.WriteMsName(pValue:Str10);
begin
  oTmpTable.FieldByName('MsName').AsString := pValue;
end;

function TAciTmp.ReadVatPrc:byte;
begin
  Result := oTmpTable.FieldByName('VatPrc').AsInteger;
end;

procedure TAciTmp.WriteVatPrc(pValue:byte);
begin
  oTmpTable.FieldByName('VatPrc').AsInteger := pValue;
end;

function TAciTmp.ReadStkCPrice:double;
begin
  Result := oTmpTable.FieldByName('StkCPrice').AsFloat;
end;

procedure TAciTmp.WriteStkCPrice(pValue:double);
begin
  oTmpTable.FieldByName('StkCPrice').AsFloat := pValue;
end;

function TAciTmp.ReadBefBPrice:double;
begin
  Result := oTmpTable.FieldByName('BefBPrice').AsFloat;
end;

procedure TAciTmp.WriteBefBPrice(pValue:double);
begin
  oTmpTable.FieldByName('BefBPrice').AsFloat := pValue;
end;

function TAciTmp.ReadNewBPrice:double;
begin
  Result := oTmpTable.FieldByName('NewBPrice').AsFloat;
end;

procedure TAciTmp.WriteNewBPrice(pValue:double);
begin
  oTmpTable.FieldByName('NewBPrice').AsFloat := pValue;
end;

function TAciTmp.ReadAftBPrice:double;
begin
  Result := oTmpTable.FieldByName('AftBPrice').AsFloat;
end;

procedure TAciTmp.WriteAftBPrice(pValue:double);
begin
  oTmpTable.FieldByName('AftBPrice').AsFloat := pValue;
end;

function TAciTmp.ReadBefProfit:double;
begin
  Result := oTmpTable.FieldByName('BefProfit').AsFloat;
end;

procedure TAciTmp.WriteBefProfit(pValue:double);
begin
  oTmpTable.FieldByName('BefProfit').AsFloat := pValue;
end;

function TAciTmp.ReadNewProfit:double;
begin
  Result := oTmpTable.FieldByName('NewProfit').AsFloat;
end;

procedure TAciTmp.WriteNewProfit(pValue:double);
begin
  oTmpTable.FieldByName('NewProfit').AsFloat := pValue;
end;

function TAciTmp.ReadAftProfit:double;
begin
  Result := oTmpTable.FieldByName('AftProfit').AsFloat;
end;

procedure TAciTmp.WriteAftProfit(pValue:double);
begin
  oTmpTable.FieldByName('AftProfit').AsFloat := pValue;
end;

function TAciTmp.ReadBegDate:TDatetime;
begin
  Result := oTmpTable.FieldByName('BegDate').AsDateTime;
end;

procedure TAciTmp.WriteBegDate(pValue:TDatetime);
begin
  oTmpTable.FieldByName('BegDate').AsDateTime := pValue;
end;

function TAciTmp.ReadEndDate:TDatetime;
begin
  Result := oTmpTable.FieldByName('EndDate').AsDateTime;
end;

procedure TAciTmp.WriteEndDate(pValue:TDatetime);
begin
  oTmpTable.FieldByName('EndDate').AsDateTime := pValue;
end;

function TAciTmp.ReadStatus:Str1;
begin
  Result := oTmpTable.FieldByName('Status').AsString;
end;

procedure TAciTmp.WriteStatus(pValue:Str1);
begin
  oTmpTable.FieldByName('Status').AsString := pValue;
end;

function TAciTmp.ReadCrtUser:Str8;
begin
  Result := oTmpTable.FieldByName('CrtUser').AsString;
end;

procedure TAciTmp.WriteCrtUser(pValue:Str8);
begin
  oTmpTable.FieldByName('CrtUser').AsString := pValue;
end;

function TAciTmp.ReadCrtDate:TDatetime;
begin
  Result := oTmpTable.FieldByName('CrtDate').AsDateTime;
end;

procedure TAciTmp.WriteCrtDate(pValue:TDatetime);
begin
  oTmpTable.FieldByName('CrtDate').AsDateTime := pValue;
end;

function TAciTmp.ReadCrtTime:TDatetime;
begin
  Result := oTmpTable.FieldByName('CrtTime').AsDateTime;
end;

procedure TAciTmp.WriteCrtTime(pValue:TDatetime);
begin
  oTmpTable.FieldByName('CrtTime').AsDateTime := pValue;
end;

function TAciTmp.ReadModUser:Str8;
begin
  Result := oTmpTable.FieldByName('ModUser').AsString;
end;

procedure TAciTmp.WriteModUser(pValue:Str8);
begin
  oTmpTable.FieldByName('ModUser').AsString := pValue;
end;

function TAciTmp.ReadModDate:TDatetime;
begin
  Result := oTmpTable.FieldByName('ModDate').AsDateTime;
end;

procedure TAciTmp.WriteModDate(pValue:TDatetime);
begin
  oTmpTable.FieldByName('ModDate').AsDateTime := pValue;
end;

function TAciTmp.ReadModTime:TDatetime;
begin
  Result := oTmpTable.FieldByName('ModTime').AsDateTime;
end;

procedure TAciTmp.WriteModTime(pValue:TDatetime);
begin
  oTmpTable.FieldByName('ModTime').AsDateTime := pValue;
end;

function TAciTmp.ReadActPos:longint;
begin
  Result := oTmpTable.FieldByName('ActPos').AsInteger;
end;

procedure TAciTmp.WriteActPos(pValue:longint);
begin
  oTmpTable.FieldByName('ActPos').AsInteger := pValue;
end;

// **************************************** PUBLIC ********************************************

function TAciTmp.Eof: boolean;
begin
  Result := oTmpTable.Eof;
end;

function TAciTmp.Active: boolean;
begin
  Result := oTmpTable.Active;
end;

function TAciTmp.LocateDoGs (pDocNum:Str12;pGsCode:longint):boolean;
begin
  SetIndex (ixDoGs);
  Result := oTmpTable.FindKey([pDocNum,pGsCode]);
end;

function TAciTmp.LocateGsCode (pGsCode:longint):boolean;
begin
  SetIndex (ixGsCode);
  Result := oTmpTable.FindKey([pGsCode]);
end;

function TAciTmp.LocateGsName_ (pGsName_:Str30):boolean;
begin
  SetIndex (ixGsName_);
  Result := oTmpTable.FindKey([pGsName_]);
end;

function TAciTmp.LocateBarCode (pBarCode:Str15):boolean;
begin
  SetIndex (ixBarCode);
  Result := oTmpTable.FindKey([pBarCode]);
end;

function TAciTmp.LocateStkCode (pStkCode:Str15):boolean;
begin
  SetIndex (ixStkCode);
  Result := oTmpTable.FindKey([pStkCode]);
end;

procedure TAciTmp.SetIndex (pIndexName:ShortString);
begin
  If oTmpTable.IndexName<>pIndexName then oTmpTable.IndexName := pIndexName;
end;

procedure TAciTmp.Open;
begin
  oTmpTable.Open;
end;

procedure TAciTmp.Close;
begin
  If oTmpTable.Active then oTmpTable.Close;
end;

procedure TAciTmp.Prior;
begin
  oTmpTable.Prior;
end;

procedure TAciTmp.Next;
begin
  oTmpTable.Next;
end;

procedure TAciTmp.First;
begin
  oTmpTable.First;
end;

procedure TAciTmp.Last;
begin
  oTmpTable.Last;
end;

procedure TAciTmp.Insert;
begin
  oTmpTable.Insert;
end;

procedure TAciTmp.Edit;
begin
  oTmpTable.Edit;
end;

procedure TAciTmp.Post;
var mEdit:boolean;
begin
  oTmpTable.Post;
end;

procedure TAciTmp.Delete;
begin
  oTmpTable.Delete;
end;

procedure TAciTmp.SwapIndex;
begin
  oTmpTable.SwapIndex;
end;

procedure TAciTmp.RestoreIndex;
begin
  oTmpTable.RestoreIndex;
end;

procedure TAciTmp.SwapStatus;
begin
  oTmpTable.SwapStatus;
end;

procedure TAciTmp.RestoreStatus;
begin
  oTmpTable.RestoreStatus;
end;

procedure TAciTmp.EnableControls;
begin
  oTmpTable.EnableControls;
end;

procedure TAciTmp.DisableControls;
begin
  oTmpTable.DisableControls;
end;

end.
