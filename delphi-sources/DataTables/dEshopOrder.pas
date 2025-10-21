unit dEshopOrder;

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
  TEshopOrderDat=class(TComponent)
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
    function GetCustomerEmail:Str50;     procedure SetCustomerEmail(pValue:Str50);
    function GetCustomerMobil:Str30;     procedure SetCustomerMobil(pValue:Str30);
    function GetCustomerNote:Str200;     procedure SetCustomerNote(pValue:Str200);
    function GetDeliveryId:longint;      procedure SetDeliveryId(pValue:longint);
    function GetDeliveryName:Str100;     procedure SetDeliveryName(pValue:Str100);
    function GetDeliveryAddr:Str100;     procedure SetDeliveryAddr(pValue:Str100);
    function GetDeliveryZip:Str10;       procedure SetDeliveryZip(pValue:Str10);
    function GetDeliveryCity:Str30;      procedure SetDeliveryCity(pValue:Str30);
    function GetDeliveryCountry:Str3;    procedure SetDeliveryCountry(pValue:Str3);
    function GetDeliveryEmail:Str50;     procedure SetDeliveryEmail(pValue:Str50);
    function GetDeloveryMobil:Str30;     procedure SetDeloveryMobil(pValue:Str30);
    function GetBilBasedValue:double;    procedure SetBilBasedValue(pValue:double);
    function GetBilTaxedValue:double;    procedure SetBilTaxedValue(pValue:double);
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
    property CustomerEmail:Str50 read GetCustomerEmail write SetCustomerEmail;
    property CustomerMobil:Str30 read GetCustomerMobil write SetCustomerMobil;
    property CustomerNote:Str200 read GetCustomerNote write SetCustomerNote;
    property DeliveryId:longint read GetDeliveryId write SetDeliveryId;
    property DeliveryName:Str100 read GetDeliveryName write SetDeliveryName;
    property DeliveryAddr:Str100 read GetDeliveryAddr write SetDeliveryAddr;
    property DeliveryZip:Str10 read GetDeliveryZip write SetDeliveryZip;
    property DeliveryCity:Str30 read GetDeliveryCity write SetDeliveryCity;
    property DeliveryCountry:Str3 read GetDeliveryCountry write SetDeliveryCountry;
    property DeliveryEmail:Str50 read GetDeliveryEmail write SetDeliveryEmail;
    property DeloveryMobil:Str30 read GetDeloveryMobil write SetDeloveryMobil;
    property BilBasedValue:double read GetBilBasedValue write SetBilBasedValue;
    property BilTaxedValue:double read GetBilTaxedValue write SetBilTaxedValue;
    property DataFileName:Str50 read GetDataFileName write SetDataFileName;
    property OrderStatus:Str1 read GetOrderStatus write SetOrderStatus;
  end;

implementation

constructor TEshopOrderDat.Create;
begin
  oTable:=DatInit('ESHOPORD',gPath.StkPath,Self);
end;

constructor TEshopOrderDat.Create(pPath:ShortString);
begin
  oTable:=DatInit('ESHOPORD',pPath,Self);
end;

destructor TEshopOrderDat.Destroy;
begin
  oTable.Close;
  FreeAndNil(oTable);
end;

// *************************************** PRIVATE ********************************************

function TEshopOrderDat.GetCount:integer;
begin
  Open;
  Result:=oTable.RecordCount;
end;

function TEshopOrderDat.FieldExist(pFieldName:Str20):boolean;
begin
  Result:=oTable.FindField(pFieldName)<>nil;
end;

// ********************* FIELDS *********************

function TEshopOrderDat.GetDocumentId:Str10;
begin
  Result:=oTable.FieldByName('DocumentId').AsString;
end;

procedure TEshopOrderDat.SetDocumentId(pValue:Str10);
begin
  oTable.FieldByName('DocumentId').AsString:=pValue;
end;

function TEshopOrderDat.GetDocumentYear:Str2;
begin
  Result:=oTable.FieldByName('DocumentYear').AsString;
end;

procedure TEshopOrderDat.SetDocumentYear(pValue:Str2);
begin
  oTable.FieldByName('DocumentYear').AsString:=pValue;
end;

function TEshopOrderDat.GetDocumentNum:longint;
begin
  Result:=oTable.FieldByName('DocumentNum').AsInteger;
end;

procedure TEshopOrderDat.SetDocumentNum(pValue:longint);
begin
  oTable.FieldByName('DocumentNum').AsInteger:=pValue;
end;

function TEshopOrderDat.GetEshopOrderId:Str20;
begin
  Result:=oTable.FieldByName('EshopOrderId').AsString;
end;

procedure TEshopOrderDat.SetEshopOrderId(pValue:Str20);
begin
  oTable.FieldByName('EshopOrderId').AsString:=pValue;
end;

function TEshopOrderDat.GetOchDocNum:Str12;
begin
  Result:=oTable.FieldByName('OchDocNum').AsString;
end;

procedure TEshopOrderDat.SetOchDocNum(pValue:Str12);
begin
  oTable.FieldByName('OchDocNum').AsString:=pValue;
end;

function TEshopOrderDat.GetOrderedDate:TDatetime;
begin
  Result:=oTable.FieldByName('OrderedDate').AsDateTime;
end;

procedure TEshopOrderDat.SetOrderedDate(pValue:TDatetime);
begin
  oTable.FieldByName('OrderedDate').AsDateTime:=pValue;
end;

function TEshopOrderDat.GetCreatedDate:TDatetime;
begin
  Result:=oTable.FieldByName('CreatedDate').AsDateTime;
end;

procedure TEshopOrderDat.SetCreatedDate(pValue:TDatetime);
begin
  oTable.FieldByName('CreatedDate').AsDateTime:=pValue;
end;

function TEshopOrderDat.GetCustomerId:longint;
begin
  Result:=oTable.FieldByName('CustomerId').AsInteger;
end;

procedure TEshopOrderDat.SetCustomerId(pValue:longint);
begin
  oTable.FieldByName('CustomerId').AsInteger:=pValue;
end;

function TEshopOrderDat.GetCustomerName:Str100;
begin
  Result:=oTable.FieldByName('CustomerName').AsString;
end;

procedure TEshopOrderDat.SetCustomerName(pValue:Str100);
begin
  oTable.FieldByName('CustomerName').AsString:=pValue;
end;

function TEshopOrderDat.GetCustomerAddr:Str100;
begin
  Result:=oTable.FieldByName('CustomerAddr').AsString;
end;

procedure TEshopOrderDat.SetCustomerAddr(pValue:Str100);
begin
  oTable.FieldByName('CustomerAddr').AsString:=pValue;
end;

function TEshopOrderDat.GetCustomerZip:Str10;
begin
  Result:=oTable.FieldByName('CustomerZip').AsString;
end;

procedure TEshopOrderDat.SetCustomerZip(pValue:Str10);
begin
  oTable.FieldByName('CustomerZip').AsString:=pValue;
end;

function TEshopOrderDat.GetCustomerCity:Str30;
begin
  Result:=oTable.FieldByName('CustomerCity').AsString;
end;

procedure TEshopOrderDat.SetCustomerCity(pValue:Str30);
begin
  oTable.FieldByName('CustomerCity').AsString:=pValue;
end;

function TEshopOrderDat.GetCustomerCountry:Str3;
begin
  Result:=oTable.FieldByName('CustomerCountry').AsString;
end;

procedure TEshopOrderDat.SetCustomerCountry(pValue:Str3);
begin
  oTable.FieldByName('CustomerCountry').AsString:=pValue;
end;

function TEshopOrderDat.GetCustomerIno:Str10;
begin
  Result:=oTable.FieldByName('CustomerIno').AsString;
end;

procedure TEshopOrderDat.SetCustomerIno(pValue:Str10);
begin
  oTable.FieldByName('CustomerIno').AsString:=pValue;
end;

function TEshopOrderDat.GetCustomerTin:Str12;
begin
  Result:=oTable.FieldByName('CustomerTin').AsString;
end;

procedure TEshopOrderDat.SetCustomerTin(pValue:Str12);
begin
  oTable.FieldByName('CustomerTin').AsString:=pValue;
end;

function TEshopOrderDat.GetCustomerVin:Str14;
begin
  Result:=oTable.FieldByName('CustomerVin').AsString;
end;

procedure TEshopOrderDat.SetCustomerVin(pValue:Str14);
begin
  oTable.FieldByName('CustomerVin').AsString:=pValue;
end;

function TEshopOrderDat.GetCustomerEmail:Str50;
begin
  Result:=oTable.FieldByName('CustomerEmail').AsString;
end;

procedure TEshopOrderDat.SetCustomerEmail(pValue:Str50);
begin
  oTable.FieldByName('CustomerEmail').AsString:=pValue;
end;

function TEshopOrderDat.GetCustomerMobil:Str30;
begin
  Result:=oTable.FieldByName('CustomerMobil').AsString;
end;

procedure TEshopOrderDat.SetCustomerMobil(pValue:Str30);
begin
  oTable.FieldByName('CustomerMobil').AsString:=pValue;
end;

function TEshopOrderDat.GetCustomerNote:Str200;
begin
  Result:=oTable.FieldByName('CustomerNote').AsString;
end;

procedure TEshopOrderDat.SetCustomerNote(pValue:Str200);
begin
  oTable.FieldByName('CustomerNote').AsString:=pValue;
end;

function TEshopOrderDat.GetDeliveryId:longint;
begin
  Result:=oTable.FieldByName('DeliveryId').AsInteger;
end;

procedure TEshopOrderDat.SetDeliveryId(pValue:longint);
begin
  oTable.FieldByName('DeliveryId').AsInteger:=pValue;
end;

function TEshopOrderDat.GetDeliveryName:Str100;
begin
  Result:=oTable.FieldByName('DeliveryName').AsString;
end;

procedure TEshopOrderDat.SetDeliveryName(pValue:Str100);
begin
  oTable.FieldByName('DeliveryName').AsString:=pValue;
end;

function TEshopOrderDat.GetDeliveryAddr:Str100;
begin
  Result:=oTable.FieldByName('DeliveryAddr').AsString;
end;

procedure TEshopOrderDat.SetDeliveryAddr(pValue:Str100);
begin
  oTable.FieldByName('DeliveryAddr').AsString:=pValue;
end;

function TEshopOrderDat.GetDeliveryZip:Str10;
begin
  Result:=oTable.FieldByName('DeliveryZip').AsString;
end;

procedure TEshopOrderDat.SetDeliveryZip(pValue:Str10);
begin
  oTable.FieldByName('DeliveryZip').AsString:=pValue;
end;

function TEshopOrderDat.GetDeliveryCity:Str30;
begin
  Result:=oTable.FieldByName('DeliveryCity').AsString;
end;

procedure TEshopOrderDat.SetDeliveryCity(pValue:Str30);
begin
  oTable.FieldByName('DeliveryCity').AsString:=pValue;
end;

function TEshopOrderDat.GetDeliveryCountry:Str3;
begin
  Result:=oTable.FieldByName('DeliveryCountry').AsString;
end;

procedure TEshopOrderDat.SetDeliveryCountry(pValue:Str3);
begin
  oTable.FieldByName('DeliveryCountry').AsString:=pValue;
end;

function TEshopOrderDat.GetDeliveryEmail:Str50;
begin
  Result:=oTable.FieldByName('DeliveryEmail').AsString;
end;

procedure TEshopOrderDat.SetDeliveryEmail(pValue:Str50);
begin
  oTable.FieldByName('DeliveryEmail').AsString:=pValue;
end;

function TEshopOrderDat.GetDeloveryMobil:Str30;
begin
  Result:=oTable.FieldByName('DeloveryMobil').AsString;
end;

procedure TEshopOrderDat.SetDeloveryMobil(pValue:Str30);
begin
  oTable.FieldByName('DeloveryMobil').AsString:=pValue;
end;

function TEshopOrderDat.GetBilBasedValue:double;
begin
  Result:=oTable.FieldByName('BilBasedValue').AsFloat;
end;

procedure TEshopOrderDat.SetBilBasedValue(pValue:double);
begin
  oTable.FieldByName('BilBasedValue').AsFloat:=pValue;
end;

function TEshopOrderDat.GetBilTaxedValue:double;
begin
  Result:=oTable.FieldByName('BilTaxedValue').AsFloat;
end;

procedure TEshopOrderDat.SetBilTaxedValue(pValue:double);
begin
  oTable.FieldByName('BilTaxedValue').AsFloat:=pValue;
end;

function TEshopOrderDat.GetDataFileName:Str50;
begin
  Result:=oTable.FieldByName('DataFileName').AsString;
end;

procedure TEshopOrderDat.SetDataFileName(pValue:Str50);
begin
  oTable.FieldByName('DataFileName').AsString:=pValue;
end;

function TEshopOrderDat.GetOrderStatus:Str1;
begin
  Result:=oTable.FieldByName('OrderStatus').AsString;
end;

procedure TEshopOrderDat.SetOrderStatus(pValue:Str1);
begin
  oTable.FieldByName('OrderStatus').AsString:=pValue;
end;

// **************************************** PUBLIC ********************************************

function TEshopOrderDat.Eof:boolean;
begin
  Result:=oTable.Eof;
end;

function TEshopOrderDat.IsFirst:boolean;
begin
  Open;
  Result:=oTable.Bof;
end;

function TEshopOrderDat.IsLast:boolean;
begin
  Open;
  Result:=oTable.Eof;
end;

function TEshopOrderDat.Active:boolean;
begin
  Result:=oTable.Active;
end;

function TEshopOrderDat.ActPos:longint;
begin
  Result:=oTable.ActPos;
end;

function TEshopOrderDat.GotoPos(pActPos:longint): boolean;
begin
  Open;
  If oTable.Filtered and (Count=0) then begin
    oTable.Filtered:=FALSE;
    oTable.Filtered:=TRUE;
  end;
  oTable.Refresh;
  Result:=oTable.GotoPos(pActPos);
end;

function TEshopOrderDat.FieldNum(pFieldName:Str20):Str3;
begin
  Open;
  Result:=StrInt(oTable.FieldByName(pFieldName).FieldNo-1,0);
end;

function TEshopOrderDat.LocDocumentId(pDocumentId:Str10):boolean;
begin
  SetIndex(ixDocumentId);
  Result:=oTable.FindKey([pDocumentId]);
end;

function TEshopOrderDat.LocDocumentYear(pDocumentYear:Str2):boolean;
begin
  SetIndex(ixDocumentYear);
  Result:=oTable.FindKey([pDocumentYear]);
end;

function TEshopOrderDat.LocOchDocNum(pOchDocNum:Str12):boolean;
begin
  SetIndex(ixOchDocNum);
  Result:=oTable.FindKey([pOchDocNum]);
end;

function TEshopOrderDat.NearDocumentId(pDocumentId:Str10):boolean;
begin
  SetIndex(ixDocumentId);
  Result:=oTable.FindNearest([pDocumentId]);
end;

function TEshopOrderDat.NearDocumentYear(pDocumentYear:Str2):boolean;
begin
  SetIndex(ixDocumentYear);
  Result:=oTable.FindNearest([pDocumentYear]);
end;

function TEshopOrderDat.NearOchDocNum(pOchDocNum:Str12):boolean;
begin
  SetIndex(ixOchDocNum);
  Result:=oTable.FindNearest([pOchDocNum]);
end;

procedure TEshopOrderDat.SetIndex(pIndexName:Str20);
begin
  Open;
  If oTable.IndexName<>pIndexName then oTable.IndexName:=pIndexName;
end;

procedure TEshopOrderDat.Open;
begin
  If not oTable.Active then oTable.Open;
end;

procedure TEshopOrderDat.Close;
begin
  If oTable.Active then oTable.Close;
end;

procedure TEshopOrderDat.Prior;
begin
  oTable.Prior;
end;

procedure TEshopOrderDat.Next;
begin
  oTable.Next;
end;

procedure TEshopOrderDat.First;
begin
  Open;
  oTable.First;
end;

procedure TEshopOrderDat.Last;
begin
  Open;
  oTable.Last;
end;

procedure TEshopOrderDat.Insert;
begin
  Open;
  oTable.Insert;
end;

procedure TEshopOrderDat.Edit;
begin
  oTable.Edit;
end;

procedure TEshopOrderDat.Post;
begin
  oTable.Post;
end;

procedure TEshopOrderDat.Delete;
begin
  oTable.Delete;
end;

procedure TEshopOrderDat.SwapIndex;
begin
  Open;
  oTable.SwapIndex;
end;

procedure TEshopOrderDat.RestIndex;
begin
  oTable.RestoreIndex;
end;

procedure TEshopOrderDat.SwapStatus;
begin
  Open;
  oTable.SwapStatus;
end;

procedure TEshopOrderDat.RestStatus;
begin
  oTable.RestoreStatus;
end;

procedure TEshopOrderDat.EnabCont;
begin
  oTable.EnableControls;
end;

procedure TEshopOrderDat.DisabCont;
begin
  oTable.DisableControls;
end;

end.
{MOD 2201001}
