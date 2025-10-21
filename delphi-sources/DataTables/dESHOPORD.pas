unit dESHOPORD;

interface

uses
  IcTypes, IcConv, NexPath, NexGlob,
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls,
  Dialogs, DB, NexBtrTable, DBTables, NexPxTable;

const
  ixDocumentId='DocumentId';
  ixDocumentYear='DocumentYear';
  ixOchDocNum='OchDocNum';

type
  TEshopordDat=class(TComponent)
    constructor Create; overload;
    destructor Destroy; override;
  private
    oTable:TNexBtrTable;
    function GetCount:integer;
    function FieldExist(pFieldName:Str20):boolean;
    // Prístup k databázovým poliam
    function GetDocumentId:Str10;        procedure SetDocumentId(pValue:Str10);
    function GetDocumentYear:Str2;       procedure SetDocumentYear(pValue:Str2);
    function GetDocumentNum:longint;     procedure SetDocumentNum(pValue:longint);
    function GetEshopOrderId:Str20;      procedure SetEshopOrderId(pValue:Str20);
    function GetOchDocNum:Str12;         procedure SetOchDocNum(pValue:Str12);
    function GetOrderedDate:TDatetime;   procedure SetOrderedDate(pValue:TDatetime);
    function GetCreatedDate:TDatetime;   procedure SetCreatedDate(pValue:TDatetime);
    function GetCustomerId:longint;      procedure SetCustomerId(pValue:longint);
    function GetCustomerName:Str100;     procedure SetCustomerName(pValue:Str100);
    function GetCustomerAddr:Str100;     procedure SetCustomerAddr(pValue:Str100);
    function GetCustomerZip:Str10;       procedure SetCustomerZip(pValue:Str10);
    function GetCustomerCity:Str30;      procedure SetCustomerCity(pValue:Str30);
    function GetCustomerCountry:Str3;    procedure SetCustomerCountry(pValue:Str3);
    function GetCustomerIno:Str10;       procedure SetCustomerIno(pValue:Str10);
    function GetCustomerTin:Str12;       procedure SetCustomerTin(pValue:Str12);
    function GetCustomerVin:Str14;       procedure SetCustomerVin(pValue:Str14);
    function GetCustomerPerson:Str50;    procedure SetCustomerPerson(pValue:Str50);
    function GetCustomerEmail:Str50;     procedure SetCustomerEmail(pValue:Str50);
    function GetCustomerMobil:Str30;     procedure SetCustomerMobil(pValue:Str30);
    function GetCustomerNote:Str200;     procedure SetCustomerNote(pValue:Str200);
    function GetDeliveryId:longint;      procedure SetDeliveryId(pValue:longint);
    function GetDeliveryName:Str100;     procedure SetDeliveryName(pValue:Str100);
    function GetDeliveryAddr:Str100;     procedure SetDeliveryAddr(pValue:Str100);
    function GetDeliveryZip:Str10;       procedure SetDeliveryZip(pValue:Str10);
    function GetDeliveryCity:Str30;      procedure SetDeliveryCity(pValue:Str30);
    function GetDeliveryCountry:Str3;    procedure SetDeliveryCountry(pValue:Str3);
    function GetDeliveryPerson:Str50;    procedure SetDeliveryPerson(pValue:Str50);
    function GetDeliveryEmail:Str50;     procedure SetDeliveryEmail(pValue:Str50);
    function GetDeliveryMobil:Str30;     procedure SetDeliveryMobil(pValue:Str30);
    function GetOcdSaleValue:double;     procedure SetOcdSaleValue(pValue:double);
    function GetEshSaleValue:double;     procedure SetEshSaleValue(pValue:double);
    function GetDataFileName:Str50;      procedure SetDataFileName(pValue:Str50);
    function GetOrderStatus:Str1;        procedure SetOrderStatus(pValue:Str1);
  public
    constructor Create(pPath:ShortString); overload;
    // Základné databázové operácie
    function Eof:boolean;
    function IsFirst:boolean;
    function IsLast:boolean;
    function Active:boolean;
    function ActPos:longint;
    function GotoPos(pActPos:longint):boolean;
    function FieldNum(pFieldName:Str20):Str3;
    function LocDocumentId(pDocumentId:Str10):boolean;
    function LocDocumentYear(pDocumentYear:Str2):boolean;
    function LocOchDocNum(pOchDocNum:Str12):boolean;
    function NearDocumentId(pDocumentId:Str10):boolean;
    function NearDocumentYear(pDocumentYear:Str2):boolean;
    function NearOchDocNum(pOchDocNum:Str12):boolean;

    procedure SetIndex(pIndexName:Str20);
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
    procedure RestIndex;
    procedure SwapStatus;
    procedure RestStatus;
    procedure EnabCont;
    procedure DisabCont;
  published
    property Table:TNexBtrTable read oTable;
    property Count:integer read GetCount;
    // Prístup k databázovým poliam
    property DocumentId:Str10 read GetDocumentId write SetDocumentId;
    property DocumentYear:Str2 read GetDocumentYear write SetDocumentYear;
    property DocumentNum:longint read GetDocumentNum write SetDocumentNum;
    property EshopOrderId:Str20 read GetEshopOrderId write SetEshopOrderId;
    property OchDocNum:Str12 read GetOchDocNum write SetOchDocNum;
    property OrderedDate:TDatetime read GetOrderedDate write SetOrderedDate;
    property CreatedDate:TDatetime read GetCreatedDate write SetCreatedDate;
    property CustomerId:longint read GetCustomerId write SetCustomerId;
    property CustomerName:Str100 read GetCustomerName write SetCustomerName;
    property CustomerAddr:Str100 read GetCustomerAddr write SetCustomerAddr;
    property CustomerZip:Str10 read GetCustomerZip write SetCustomerZip;
    property CustomerCity:Str30 read GetCustomerCity write SetCustomerCity;
    property CustomerCountry:Str3 read GetCustomerCountry write SetCustomerCountry;
    property CustomerIno:Str10 read GetCustomerIno write SetCustomerIno;
    property CustomerTin:Str12 read GetCustomerTin write SetCustomerTin;
    property CustomerVin:Str14 read GetCustomerVin write SetCustomerVin;
    property CustomerPerson:Str50 read GetCustomerPerson write SetCustomerPerson;
    property CustomerEmail:Str50 read GetCustomerEmail write SetCustomerEmail;
    property CustomerMobil:Str30 read GetCustomerMobil write SetCustomerMobil;
    property CustomerNote:Str200 read GetCustomerNote write SetCustomerNote;
    property DeliveryId:longint read GetDeliveryId write SetDeliveryId;
    property DeliveryName:Str100 read GetDeliveryName write SetDeliveryName;
    property DeliveryAddr:Str100 read GetDeliveryAddr write SetDeliveryAddr;
    property DeliveryZip:Str10 read GetDeliveryZip write SetDeliveryZip;
    property DeliveryCity:Str30 read GetDeliveryCity write SetDeliveryCity;
    property DeliveryCountry:Str3 read GetDeliveryCountry write SetDeliveryCountry;
    property DeliveryPerson:Str50 read GetDeliveryPerson write SetDeliveryPerson;
    property DeliveryEmail:Str50 read GetDeliveryEmail write SetDeliveryEmail;
    property DeliveryMobil:Str30 read GetDeliveryMobil write SetDeliveryMobil;
    property OcdSaleValue:double read GetOcdSaleValue write SetOcdSaleValue;
    property EshSaleValue:double read GetEshSaleValue write SetEshSaleValue;
    property DataFileName:Str50 read GetDataFileName write SetDataFileName;
    property OrderStatus:Str1 read GetOrderStatus write SetOrderStatus;
  end;

implementation

constructor TEshopordDat.Create;
begin
  oTable:=DatInit('ESHOPORD',gPath.StkPath,Self);
end;

constructor TEshopordDat.Create(pPath:ShortString);
begin
  oTable:=DatInit('ESHOPORD',pPath,Self);
end;

destructor TEshopordDat.Destroy;
begin
  oTable.Close;
  FreeAndNil(oTable);
end;

// *************************************** PRIVATE ********************************************

function TEshopordDat.GetCount:integer;
begin
  Open;
  Result:=oTable.RecordCount;
end;

function TEshopordDat.FieldExist(pFieldName:Str20):boolean;
begin
  Result:=oTable.FindField(pFieldName)<>nil;
end;

// ********************* FIELDS *********************

function TEshopordDat.GetDocumentId:Str10;
begin
  Result:=oTable.FieldByName('DocumentId').AsString;
end;

procedure TEshopordDat.SetDocumentId(pValue:Str10);
begin
  oTable.FieldByName('DocumentId').AsString:=pValue;
end;

function TEshopordDat.GetDocumentYear:Str2;
begin
  Result:=oTable.FieldByName('DocumentYear').AsString;
end;

procedure TEshopordDat.SetDocumentYear(pValue:Str2);
begin
  oTable.FieldByName('DocumentYear').AsString:=pValue;
end;

function TEshopordDat.GetDocumentNum:longint;
begin
  Result:=oTable.FieldByName('DocumentNum').AsInteger;
end;

procedure TEshopordDat.SetDocumentNum(pValue:longint);
begin
  oTable.FieldByName('DocumentNum').AsInteger:=pValue;
end;

function TEshopordDat.GetEshopOrderId:Str20;
begin
  Result:=oTable.FieldByName('EshopOrderId').AsString;
end;

procedure TEshopordDat.SetEshopOrderId(pValue:Str20);
begin
  oTable.FieldByName('EshopOrderId').AsString:=pValue;
end;

function TEshopordDat.GetOchDocNum:Str12;
begin
  Result:=oTable.FieldByName('OchDocNum').AsString;
end;

procedure TEshopordDat.SetOchDocNum(pValue:Str12);
begin
  oTable.FieldByName('OchDocNum').AsString:=pValue;
end;

function TEshopordDat.GetOrderedDate:TDatetime;
begin
  Result:=oTable.FieldByName('OrderedDate').AsDateTime;
end;

procedure TEshopordDat.SetOrderedDate(pValue:TDatetime);
begin
  oTable.FieldByName('OrderedDate').AsDateTime:=pValue;
end;

function TEshopordDat.GetCreatedDate:TDatetime;
begin
  Result:=oTable.FieldByName('CreatedDate').AsDateTime;
end;

procedure TEshopordDat.SetCreatedDate(pValue:TDatetime);
begin
  oTable.FieldByName('CreatedDate').AsDateTime:=pValue;
end;

function TEshopordDat.GetCustomerId:longint;
begin
  Result:=oTable.FieldByName('CustomerId').AsInteger;
end;

procedure TEshopordDat.SetCustomerId(pValue:longint);
begin
  oTable.FieldByName('CustomerId').AsInteger:=pValue;
end;

function TEshopordDat.GetCustomerName:Str100;
begin
  Result:=oTable.FieldByName('CustomerName').AsString;
end;

procedure TEshopordDat.SetCustomerName(pValue:Str100);
begin
  oTable.FieldByName('CustomerName').AsString:=pValue;
end;

function TEshopordDat.GetCustomerAddr:Str100;
begin
  Result:=oTable.FieldByName('CustomerAddr').AsString;
end;

procedure TEshopordDat.SetCustomerAddr(pValue:Str100);
begin
  oTable.FieldByName('CustomerAddr').AsString:=pValue;
end;

function TEshopordDat.GetCustomerZip:Str10;
begin
  Result:=oTable.FieldByName('CustomerZip').AsString;
end;

procedure TEshopordDat.SetCustomerZip(pValue:Str10);
begin
  oTable.FieldByName('CustomerZip').AsString:=pValue;
end;

function TEshopordDat.GetCustomerCity:Str30;
begin
  Result:=oTable.FieldByName('CustomerCity').AsString;
end;

procedure TEshopordDat.SetCustomerCity(pValue:Str30);
begin
  oTable.FieldByName('CustomerCity').AsString:=pValue;
end;

function TEshopordDat.GetCustomerCountry:Str3;
begin
  Result:=oTable.FieldByName('CustomerCountry').AsString;
end;

procedure TEshopordDat.SetCustomerCountry(pValue:Str3);
begin
  oTable.FieldByName('CustomerCountry').AsString:=pValue;
end;

function TEshopordDat.GetCustomerIno:Str10;
begin
  Result:=oTable.FieldByName('CustomerIno').AsString;
end;

procedure TEshopordDat.SetCustomerIno(pValue:Str10);
begin
  oTable.FieldByName('CustomerIno').AsString:=pValue;
end;

function TEshopordDat.GetCustomerTin:Str12;
begin
  Result:=oTable.FieldByName('CustomerTin').AsString;
end;

procedure TEshopordDat.SetCustomerTin(pValue:Str12);
begin
  oTable.FieldByName('CustomerTin').AsString:=pValue;
end;

function TEshopordDat.GetCustomerVin:Str14;
begin
  Result:=oTable.FieldByName('CustomerVin').AsString;
end;

procedure TEshopordDat.SetCustomerVin(pValue:Str14);
begin
  oTable.FieldByName('CustomerVin').AsString:=pValue;
end;

function TEshopordDat.GetCustomerPerson:Str50;
begin
  Result:=oTable.FieldByName('CustomerPerson').AsString;
end;

procedure TEshopordDat.SetCustomerPerson(pValue:Str50);
begin
  oTable.FieldByName('CustomerPerson').AsString:=pValue;
end;

function TEshopordDat.GetCustomerEmail:Str50;
begin
  Result:=oTable.FieldByName('CustomerEmail').AsString;
end;

procedure TEshopordDat.SetCustomerEmail(pValue:Str50);
begin
  oTable.FieldByName('CustomerEmail').AsString:=pValue;
end;

function TEshopordDat.GetCustomerMobil:Str30;
begin
  Result:=oTable.FieldByName('CustomerMobil').AsString;
end;

procedure TEshopordDat.SetCustomerMobil(pValue:Str30);
begin
  oTable.FieldByName('CustomerMobil').AsString:=pValue;
end;

function TEshopordDat.GetCustomerNote:Str200;
begin
  Result:=oTable.FieldByName('CustomerNote').AsString;
end;

procedure TEshopordDat.SetCustomerNote(pValue:Str200);
begin
  oTable.FieldByName('CustomerNote').AsString:=pValue;
end;

function TEshopordDat.GetDeliveryId:longint;
begin
  Result:=oTable.FieldByName('DeliveryId').AsInteger;
end;

procedure TEshopordDat.SetDeliveryId(pValue:longint);
begin
  oTable.FieldByName('DeliveryId').AsInteger:=pValue;
end;

function TEshopordDat.GetDeliveryName:Str100;
begin
  Result:=oTable.FieldByName('DeliveryName').AsString;
end;

procedure TEshopordDat.SetDeliveryName(pValue:Str100);
begin
  oTable.FieldByName('DeliveryName').AsString:=pValue;
end;

function TEshopordDat.GetDeliveryAddr:Str100;
begin
  Result:=oTable.FieldByName('DeliveryAddr').AsString;
end;

procedure TEshopordDat.SetDeliveryAddr(pValue:Str100);
begin
  oTable.FieldByName('DeliveryAddr').AsString:=pValue;
end;

function TEshopordDat.GetDeliveryZip:Str10;
begin
  Result:=oTable.FieldByName('DeliveryZip').AsString;
end;

procedure TEshopordDat.SetDeliveryZip(pValue:Str10);
begin
  oTable.FieldByName('DeliveryZip').AsString:=pValue;
end;

function TEshopordDat.GetDeliveryCity:Str30;
begin
  Result:=oTable.FieldByName('DeliveryCity').AsString;
end;

procedure TEshopordDat.SetDeliveryCity(pValue:Str30);
begin
  oTable.FieldByName('DeliveryCity').AsString:=pValue;
end;

function TEshopordDat.GetDeliveryCountry:Str3;
begin
  Result:=oTable.FieldByName('DeliveryCountry').AsString;
end;

procedure TEshopordDat.SetDeliveryCountry(pValue:Str3);
begin
  oTable.FieldByName('DeliveryCountry').AsString:=pValue;
end;

function TEshopordDat.GetDeliveryPerson:Str50;
begin
  Result:=oTable.FieldByName('DeliveryPerson').AsString;
end;

procedure TEshopordDat.SetDeliveryPerson(pValue:Str50);
begin
  oTable.FieldByName('DeliveryPerson').AsString:=pValue;
end;

function TEshopordDat.GetDeliveryEmail:Str50;
begin
  Result:=oTable.FieldByName('DeliveryEmail').AsString;
end;

procedure TEshopordDat.SetDeliveryEmail(pValue:Str50);
begin
  oTable.FieldByName('DeliveryEmail').AsString:=pValue;
end;

function TEshopordDat.GetDeliveryMobil:Str30;
begin
  Result:=oTable.FieldByName('DeliveryMobil').AsString;
end;

procedure TEshopordDat.SetDeliveryMobil(pValue:Str30);
begin
  oTable.FieldByName('DeliveryMobil').AsString:=pValue;
end;

function TEshopordDat.GetOcdSaleValue:double;
begin
  Result:=oTable.FieldByName('OcdSaleValue').AsFloat;
end;

procedure TEshopordDat.SetOcdSaleValue(pValue:double);
begin
  oTable.FieldByName('OcdSaleValue').AsFloat:=pValue;
end;

function TEshopordDat.GetEshSaleValue:double;
begin
  Result:=oTable.FieldByName('EshSaleValue').AsFloat;
end;

procedure TEshopordDat.SetEshSaleValue(pValue:double);
begin
  oTable.FieldByName('EshSaleValue').AsFloat:=pValue;
end;

function TEshopordDat.GetDataFileName:Str50;
begin
  Result:=oTable.FieldByName('DataFileName').AsString;
end;

procedure TEshopordDat.SetDataFileName(pValue:Str50);
begin
  oTable.FieldByName('DataFileName').AsString:=pValue;
end;

function TEshopordDat.GetOrderStatus:Str1;
begin
  Result:=oTable.FieldByName('OrderStatus').AsString;
end;

procedure TEshopordDat.SetOrderStatus(pValue:Str1);
begin
  oTable.FieldByName('OrderStatus').AsString:=pValue;
end;

// **************************************** PUBLIC ********************************************

function TEshopordDat.Eof:boolean;
begin
  Result:=oTable.Eof;
end;

function TEshopordDat.IsFirst:boolean;
begin
  Open;
  Result:=oTable.Bof;
end;

function TEshopordDat.IsLast:boolean;
begin
  Open;
  Result:=oTable.Eof;
end;

function TEshopordDat.Active:boolean;
begin
  Result:=oTable.Active;
end;

function TEshopordDat.ActPos:longint;
begin
  Result:=oTable.ActPos;
end;

function TEshopordDat.GotoPos(pActPos:longint): boolean;
begin
  Open;
  If oTable.Filtered and (Count=0) then begin
    oTable.Filtered:=FALSE;
    oTable.Filtered:=TRUE;
  end;
  oTable.Refresh;
  Result:=oTable.GotoPos(pActPos);
end;

function TEshopordDat.FieldNum(pFieldName:Str20):Str3;
begin
  Open;
  Result:=StrInt(oTable.FieldByName(pFieldName).FieldNo-1,0);
end;

function TEshopordDat.LocDocumentId(pDocumentId:Str10):boolean;
begin
  SetIndex(ixDocumentId);
  Result:=oTable.FindKey([pDocumentId]);
end;

function TEshopordDat.LocDocumentYear(pDocumentYear:Str2):boolean;
begin
  SetIndex(ixDocumentYear);
  Result:=oTable.FindKey([pDocumentYear]);
end;

function TEshopordDat.LocOchDocNum(pOchDocNum:Str12):boolean;
begin
  SetIndex(ixOchDocNum);
  Result:=oTable.FindKey([pOchDocNum]);
end;

function TEshopordDat.NearDocumentId(pDocumentId:Str10):boolean;
begin
  SetIndex(ixDocumentId);
  Result:=oTable.FindNearest([pDocumentId]);
end;

function TEshopordDat.NearDocumentYear(pDocumentYear:Str2):boolean;
begin
  SetIndex(ixDocumentYear);
  Result:=oTable.FindNearest([pDocumentYear]);
end;

function TEshopordDat.NearOchDocNum(pOchDocNum:Str12):boolean;
begin
  SetIndex(ixOchDocNum);
  Result:=oTable.FindNearest([pOchDocNum]);
end;

procedure TEshopordDat.SetIndex(pIndexName:Str20);
begin
  Open;
  If oTable.IndexName<>pIndexName then oTable.IndexName:=pIndexName;
end;

procedure TEshopordDat.Open;
begin
  If not oTable.Active then oTable.Open;
end;

procedure TEshopordDat.Close;
begin
  If oTable.Active then oTable.Close;
end;

procedure TEshopordDat.Prior;
begin
  oTable.Prior;
end;

procedure TEshopordDat.Next;
begin
  oTable.Next;
end;

procedure TEshopordDat.First;
begin
  Open;
  oTable.First;
end;

procedure TEshopordDat.Last;
begin
  Open;
  oTable.Last;
end;

procedure TEshopordDat.Insert;
begin
  Open;
  oTable.Insert;
end;

procedure TEshopordDat.Edit;
begin
  oTable.Edit;
end;

procedure TEshopordDat.Post;
begin
  oTable.Post;
end;

procedure TEshopordDat.Delete;
begin
  oTable.Delete;
end;

procedure TEshopordDat.SwapIndex;
begin
  Open;
  oTable.SwapIndex;
end;

procedure TEshopordDat.RestIndex;
begin
  oTable.RestoreIndex;
end;

procedure TEshopordDat.SwapStatus;
begin
  Open;
  oTable.SwapStatus;
end;

procedure TEshopordDat.RestStatus;
begin
  oTable.RestoreStatus;
end;

procedure TEshopordDat.EnabCont;
begin
  oTable.EnableControls;
end;

procedure TEshopordDat.DisabCont;
begin
  oTable.DisableControls;
end;

end.
{MOD 2202001}
