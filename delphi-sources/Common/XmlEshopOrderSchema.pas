
{*********************************************************************************************}
{                                                                                             }
{                                   Delphi XML Data Binding                                   }
{                                                                                             }
{         Generated on: 6.6.2024 19:47:51                                                     }
{       Generated from: C:\TEST\NEX_DEV\YEARACT\ESHORD\DATASUN-EshopOrderData-240606001.xml   }
{   Settings stored in: C:\TEST\NEX_DEV\YEARACT\ESHORD\DATASUN-EshopOrderData-240606001.xdb   }
{                                                                                             }
{*********************************************************************************************}
unit XmlEshopOrderSchema;

interface

uses xmldom, XMLDoc, XMLIntf;

type

{ Forward Decls }

  IXMLEshopOrderType = interface;
  IXMLCustomerDataType = interface;
  IXMLPersonDataType = interface;
  IXMLCompanyDataType = interface;
  IXMLAddressDataType = interface;
  IXMLStreetDataType = interface;
  IXMLCityDataType = interface;
  IXMLCountryDataType = interface;
  IXMLRecipientDataType = interface;
  IXMLOrderItemsType = interface;
  IXMLItemDataType = interface;
  IXMLGoodsDataType = interface;

{ IXMLEshopOrderType }

  IXMLEshopOrderType = interface(IXMLNode)
    ['{CF3A4BC1-0CA8-48C9-A63E-233627C25A9F}']
    { Property Accessors }
    function Get_OrderId: WideString;
    function Get_DeliveryComplet: WideString;
    function Get_DeliveryPersonal: WideString;
    function Get_CashOnDelivery: WideString;
    function Get_OrderNumber: WideString;
    function Get_CreateDateTime: WideString;
    function Get_CustomerData: IXMLCustomerDataType;
    function Get_RecipientData: IXMLRecipientDataType;
    function Get_OrderStatus: WideString;
    function Get_OrderItems: IXMLOrderItemsType;
    procedure Set_OrderId(Value: WideString);
    procedure Set_DeliveryComplet(Value: WideString);
    procedure Set_DeliveryPersonal(Value: WideString);
    procedure Set_CashOnDelivery(Value: WideString);
    procedure Set_OrderNumber(Value: WideString);
    procedure Set_CreateDateTime(Value: WideString);
    procedure Set_OrderStatus(Value: WideString);
    { Methods & Properties }
    property OrderId: WideString read Get_OrderId write Set_OrderId;
    property DeliveryComplet: WideString read Get_DeliveryComplet write Set_DeliveryComplet;
    property DeliveryPersonal: WideString read Get_DeliveryPersonal write Set_DeliveryPersonal;
    property CashOnDelivery: WideString read Get_CashOnDelivery write Set_CashOnDelivery;
    property OrderNumber: WideString read Get_OrderNumber write Set_OrderNumber;
    property CreateDateTime: WideString read Get_CreateDateTime write Set_CreateDateTime;
    property CustomerData: IXMLCustomerDataType read Get_CustomerData;
    property RecipientData: IXMLRecipientDataType read Get_RecipientData;
    property OrderStatus: WideString read Get_OrderStatus write Set_OrderStatus;
    property OrderItems: IXMLOrderItemsType read Get_OrderItems;
  end;

{ IXMLCustomerDataType }

  IXMLCustomerDataType = interface(IXMLNode)
    ['{1474DBE1-B641-4C9D-87B0-C14932E5723E}']
    { Property Accessors }
    function Get_PersonData: IXMLPersonDataType;
    function Get_CompanyData: IXMLCompanyDataType;
    function Get_AddressData: IXMLAddressDataType;
    { Methods & Properties }
    property PersonData: IXMLPersonDataType read Get_PersonData;
    property CompanyData: IXMLCompanyDataType read Get_CompanyData;
    property AddressData: IXMLAddressDataType read Get_AddressData;
  end;

{ IXMLPersonDataType }

  IXMLPersonDataType = interface(IXMLNode)
    ['{AC38C5AF-846B-4F88-8A08-ADC006E96DB0}']
    { Property Accessors }
    function Get_FirstName: WideString;
    function Get_LastName: WideString;
    function Get_PhoneNumber: WideString;
    function Get_EmailAddress: WideString;
    procedure Set_FirstName(Value: WideString);
    procedure Set_LastName(Value: WideString);
    procedure Set_PhoneNumber(Value: WideString);
    procedure Set_EmailAddress(Value: WideString);
    { Methods & Properties }
    property FirstName: WideString read Get_FirstName write Set_FirstName;
    property LastName: WideString read Get_LastName write Set_LastName;
    property PhoneNumber: WideString read Get_PhoneNumber write Set_PhoneNumber;
    property EmailAddress: WideString read Get_EmailAddress write Set_EmailAddress;
  end;

{ IXMLCompanyDataType }

  IXMLCompanyDataType = interface(IXMLNode)
    ['{DED783E6-3CA5-450A-AF6B-378B87297496}']
    { Property Accessors }
    function Get_CompanyName: WideString;
    function Get_OrgIdNumber: WideString;
    function Get_TaxIdNumber: WideString;
    function Get_VatIdNumber: WideString;
    procedure Set_CompanyName(Value: WideString);
    procedure Set_OrgIdNumber(Value: WideString);
    procedure Set_TaxIdNumber(Value: WideString);
    procedure Set_VatIdNumber(Value: WideString);
    { Methods & Properties }
    property CompanyName: WideString read Get_CompanyName write Set_CompanyName;
    property OrgIdNumber: WideString read Get_OrgIdNumber write Set_OrgIdNumber;
    property TaxIdNumber: WideString read Get_TaxIdNumber write Set_TaxIdNumber;
    property VatIdNumber: WideString read Get_VatIdNumber write Set_VatIdNumber;
  end;

{ IXMLAddressDataType }

  IXMLAddressDataType = interface(IXMLNode)
    ['{258A9A77-37AB-47A6-95D3-95FE4BB060E1}']
    { Property Accessors }
    function Get_StreetData: IXMLStreetDataType;
    function Get_CityData: IXMLCityDataType;
    function Get_CountryData: IXMLCountryDataType;
    { Methods & Properties }
    property StreetData: IXMLStreetDataType read Get_StreetData;
    property CityData: IXMLCityDataType read Get_CityData;
    property CountryData: IXMLCountryDataType read Get_CountryData;
  end;

{ IXMLStreetDataType }

  IXMLStreetDataType = interface(IXMLNode)
    ['{79D4BE6E-0487-4E04-862C-0D77C08D6C00}']
    { Property Accessors }
    function Get_Name: WideString;
    function Get_Number: WideString;
    procedure Set_Name(Value: WideString);
    procedure Set_Number(Value: WideString);
    { Methods & Properties }
    property Name: WideString read Get_Name write Set_Name;
    property Number: WideString read Get_Number write Set_Number;
  end;

{ IXMLCityDataType }

  IXMLCityDataType = interface(IXMLNode)
    ['{63938EA6-9545-4202-8D15-D3E14C1569A2}']
    { Property Accessors }
    function Get_Name: WideString;
    function Get_PostCode: WideString;
    procedure Set_Name(Value: WideString);
    procedure Set_PostCode(Value: WideString);
    { Methods & Properties }
    property Name: WideString read Get_Name write Set_Name;
    property PostCode: WideString read Get_PostCode write Set_PostCode;
  end;

{ IXMLCountryDataType }

  IXMLCountryDataType = interface(IXMLNode)
    ['{456A202A-F713-470B-A715-C5A2C5C9C540}']
    { Property Accessors }
    function Get_Name: WideString;
    function Get_Code: WideString;
    procedure Set_Name(Value: WideString);
    procedure Set_Code(Value: WideString);
    { Methods & Properties }
    property Name: WideString read Get_Name write Set_Name;
    property Code: WideString read Get_Code write Set_Code;
  end;

{ IXMLRecipientDataType }

  IXMLRecipientDataType = interface(IXMLNode)
    ['{E52A2867-9B23-4D9A-BF17-3E1942507A6F}']
    { Property Accessors }
    function Get_PersonData: IXMLPersonDataType;
    function Get_CompanyData: IXMLCompanyDataType;
    function Get_AddressData: IXMLAddressDataType;
    { Methods & Properties }
    property PersonData: IXMLPersonDataType read Get_PersonData;
    property CompanyData: IXMLCompanyDataType read Get_CompanyData;
    property AddressData: IXMLAddressDataType read Get_AddressData;
  end;

{ IXMLOrderItemsType }

  IXMLOrderItemsType = interface(IXMLNodeCollection)
    ['{9528E44E-E910-453F-B2D9-57014D438D76}']
    { Property Accessors }
    function Get_ItemData(Index: Integer): IXMLItemDataType;
    { Methods & Properties }
    function Add: IXMLItemDataType;
    function Insert(const Index: Integer): IXMLItemDataType;
    property ItemData[Index: Integer]: IXMLItemDataType read Get_ItemData; default;
  end;

{ IXMLItemDataType }

  IXMLItemDataType = interface(IXMLNode)
    ['{8D844EBB-746B-418E-AC9F-76AC0D8947BC}']
    { Property Accessors }
    function Get_ItemId: WideString;
    function Get_GoodsData: IXMLGoodsDataType;
    function Get_SaleAmount: WideString;
    function Get_UnitPrice: WideString;
    function Get_DeliveryValue: WideString;
    function Get_ItemStatus: WideString;
    procedure Set_ItemId(Value: WideString);
    procedure Set_SaleAmount(Value: WideString);
    procedure Set_UnitPrice(Value: WideString);
    procedure Set_DeliveryValue(Value: WideString);
    procedure Set_ItemStatus(Value: WideString);
    { Methods & Properties }
    property ItemId: WideString read Get_ItemId write Set_ItemId;
    property GoodsData: IXMLGoodsDataType read Get_GoodsData;
    property SaleAmount: WideString read Get_SaleAmount write Set_SaleAmount;
    property UnitPrice: WideString read Get_UnitPrice write Set_UnitPrice;
    property DeliveryValue: WideString read Get_DeliveryValue write Set_DeliveryValue;
    property ItemStatus: WideString read Get_ItemStatus write Set_ItemStatus;
  end;

{ IXMLGoodsDataType }

  IXMLGoodsDataType = interface(IXMLNode)
    ['{CAD8A2F7-8410-4763-A8DC-C51FBC3CD075}']
    { Property Accessors }
    function Get_GoodsCode: Integer;
    function Get_GoodsName: WideString;
    procedure Set_GoodsCode(Value: Integer);
    procedure Set_GoodsName(Value: WideString);
    { Methods & Properties }
    property GoodsCode: Integer read Get_GoodsCode write Set_GoodsCode;
    property GoodsName: WideString read Get_GoodsName write Set_GoodsName;
  end;

{ Forward Decls }

  TXMLEshopOrderType = class;
  TXMLCustomerDataType = class;
  TXMLPersonDataType = class;
  TXMLCompanyDataType = class;
  TXMLAddressDataType = class;
  TXMLStreetDataType = class;
  TXMLCityDataType = class;
  TXMLCountryDataType = class;
  TXMLRecipientDataType = class;
  TXMLOrderItemsType = class;
  TXMLItemDataType = class;
  TXMLGoodsDataType = class;

{ TXMLEshopOrderType }

  TXMLEshopOrderType = class(TXMLNode, IXMLEshopOrderType)
  protected
    { IXMLEshopOrderType }
    function Get_OrderId: WideString;
    function Get_DeliveryComplet: WideString;
    function Get_DeliveryPersonal: WideString;
    function Get_CashOnDelivery: WideString;
    function Get_OrderNumber: WideString;
    function Get_CreateDateTime: WideString;
    function Get_CustomerData: IXMLCustomerDataType;
    function Get_RecipientData: IXMLRecipientDataType;
    function Get_OrderStatus: WideString;
    function Get_OrderItems: IXMLOrderItemsType;
    procedure Set_OrderId(Value: WideString);
    procedure Set_DeliveryComplet(Value: WideString);
    procedure Set_DeliveryPersonal(Value: WideString);
    procedure Set_CashOnDelivery(Value: WideString);
    procedure Set_OrderNumber(Value: WideString);
    procedure Set_CreateDateTime(Value: WideString);
    procedure Set_OrderStatus(Value: WideString);
  public
    procedure AfterConstruction; override;
  end;

{ TXMLCustomerDataType }

  TXMLCustomerDataType = class(TXMLNode, IXMLCustomerDataType)
  protected
    { IXMLCustomerDataType }
    function Get_PersonData: IXMLPersonDataType;
    function Get_CompanyData: IXMLCompanyDataType;
    function Get_AddressData: IXMLAddressDataType;
  public
    procedure AfterConstruction; override;
  end;

{ TXMLPersonDataType }

  TXMLPersonDataType = class(TXMLNode, IXMLPersonDataType)
  protected
    { IXMLPersonDataType }
    function Get_FirstName: WideString;
    function Get_LastName: WideString;
    function Get_PhoneNumber: WideString;
    function Get_EmailAddress: WideString;
    procedure Set_FirstName(Value: WideString);
    procedure Set_LastName(Value: WideString);
    procedure Set_PhoneNumber(Value: WideString);
    procedure Set_EmailAddress(Value: WideString);
  end;

{ TXMLCompanyDataType }

  TXMLCompanyDataType = class(TXMLNode, IXMLCompanyDataType)
  protected
    { IXMLCompanyDataType }
    function Get_CompanyName: WideString;
    function Get_OrgIdNumber: WideString;
    function Get_TaxIdNumber: WideString;
    function Get_VatIdNumber: WideString;
    procedure Set_CompanyName(Value: WideString);
    procedure Set_OrgIdNumber(Value: WideString);
    procedure Set_TaxIdNumber(Value: WideString);
    procedure Set_VatIdNumber(Value: WideString);
  end;

{ TXMLAddressDataType }

  TXMLAddressDataType = class(TXMLNode, IXMLAddressDataType)
  protected
    { IXMLAddressDataType }
    function Get_StreetData: IXMLStreetDataType;
    function Get_CityData: IXMLCityDataType;
    function Get_CountryData: IXMLCountryDataType;
  public
    procedure AfterConstruction; override;
  end;

{ TXMLStreetDataType }

  TXMLStreetDataType = class(TXMLNode, IXMLStreetDataType)
  protected
    { IXMLStreetDataType }
    function Get_Name: WideString;
    function Get_Number: WideString;
    procedure Set_Name(Value: WideString);
    procedure Set_Number(Value: WideString);
  end;

{ TXMLCityDataType }

  TXMLCityDataType = class(TXMLNode, IXMLCityDataType)
  protected
    { IXMLCityDataType }
    function Get_Name: WideString;
    function Get_PostCode: WideString;
    procedure Set_Name(Value: WideString);
    procedure Set_PostCode(Value: WideString);
  end;

{ TXMLCountryDataType }

  TXMLCountryDataType = class(TXMLNode, IXMLCountryDataType)
  protected
    { IXMLCountryDataType }
    function Get_Name: WideString;
    function Get_Code: WideString;
    procedure Set_Name(Value: WideString);
    procedure Set_Code(Value: WideString);
  end;

{ TXMLRecipientDataType }

  TXMLRecipientDataType = class(TXMLNode, IXMLRecipientDataType)
  protected
    { IXMLRecipientDataType }
    function Get_PersonData: IXMLPersonDataType;
    function Get_CompanyData: IXMLCompanyDataType;
    function Get_AddressData: IXMLAddressDataType;
  public
    procedure AfterConstruction; override;
  end;

{ TXMLOrderItemsType }

  TXMLOrderItemsType = class(TXMLNodeCollection, IXMLOrderItemsType)
  protected
    { IXMLOrderItemsType }
    function Get_ItemData(Index: Integer): IXMLItemDataType;
    function Add: IXMLItemDataType;
    function Insert(const Index: Integer): IXMLItemDataType;
  public
    procedure AfterConstruction; override;
  end;

{ TXMLItemDataType }

  TXMLItemDataType = class(TXMLNode, IXMLItemDataType)
  protected
    { IXMLItemDataType }
    function Get_ItemId: WideString;
    function Get_GoodsData: IXMLGoodsDataType;
    function Get_SaleAmount: WideString;
    function Get_UnitPrice: WideString;
    function Get_DeliveryValue: WideString;
    function Get_ItemStatus: WideString;
    procedure Set_ItemId(Value: WideString);
    procedure Set_SaleAmount(Value: WideString);
    procedure Set_UnitPrice(Value: WideString);
    procedure Set_DeliveryValue(Value: WideString);
    procedure Set_ItemStatus(Value: WideString);
  public
    procedure AfterConstruction; override;
  end;

{ TXMLGoodsDataType }

  TXMLGoodsDataType = class(TXMLNode, IXMLGoodsDataType)
  protected
    { IXMLGoodsDataType }
    function Get_GoodsCode: Integer;
    function Get_GoodsName: WideString;
    procedure Set_GoodsCode(Value: Integer);
    procedure Set_GoodsName(Value: WideString);
  end;

{ Global Functions }

function GetEshopOrder(Doc: IXMLDocument): IXMLEshopOrderType;
function LoadEshopOrder(const FileName: WideString): IXMLEshopOrderType;
function NewEshopOrder: IXMLEshopOrderType;

implementation

{ Global Functions }

function GetEshopOrder(Doc: IXMLDocument): IXMLEshopOrderType;
begin
  Result := Doc.GetDocBinding('EshopOrder', TXMLEshopOrderType) as IXMLEshopOrderType;
end;
function LoadEshopOrder(const FileName: WideString): IXMLEshopOrderType;
begin
  Result := LoadXMLDocument(FileName).GetDocBinding('EshopOrder', TXMLEshopOrderType) as IXMLEshopOrderType;
end;

function NewEshopOrder: IXMLEshopOrderType;
begin
  Result := NewXMLDocument.GetDocBinding('EshopOrder', TXMLEshopOrderType) as IXMLEshopOrderType;
end;

{ TXMLEshopOrderType }

procedure TXMLEshopOrderType.AfterConstruction;
begin
  RegisterChildNode('CustomerData', TXMLCustomerDataType);
  RegisterChildNode('RecipientData', TXMLRecipientDataType);
  RegisterChildNode('OrderItems', TXMLOrderItemsType);
  inherited;
end;

function TXMLEshopOrderType.Get_OrderId: WideString;
begin
  Result := AttributeNodes['OrderId'].Text;
end;

function TXMLEshopOrderType.Get_DeliveryComplet: WideString;
begin
  Result := AttributeNodes['DeliveryComplet'].Text;
end;

function TXMLEshopOrderType.Get_DeliveryPersonal: WideString;
begin
  Result := AttributeNodes['DeliveryPersonal'].Text;
end;

function TXMLEshopOrderType.Get_CashOnDelivery: WideString;
begin
  Result := AttributeNodes['CashOnDelivery'].Text;
end;

procedure TXMLEshopOrderType.Set_OrderId(Value: WideString);
begin
  SetAttribute('OrderId', Value);
end;

procedure TXMLEshopOrderType.Set_DeliveryComplet(Value: WideString);
begin
  SetAttribute('DeliveryComplet', Value);
end;

procedure TXMLEshopOrderType.Set_DeliveryPersonal(Value: WideString);
begin
  SetAttribute('DeliveryPersonal', Value);
end;

procedure TXMLEshopOrderType.Set_CashOnDelivery(Value: WideString);
begin
  SetAttribute('CashOnDelivery', Value);
end;

function TXMLEshopOrderType.Get_OrderNumber: WideString;
begin
  Result := ChildNodes['OrderNumber'].Text;
end;

procedure TXMLEshopOrderType.Set_OrderNumber(Value: WideString);
begin
  ChildNodes['OrderNumber'].NodeValue := Value;
end;

function TXMLEshopOrderType.Get_CreateDateTime: WideString;
begin
  Result := ChildNodes['CreateDateTime'].Text;
end;

procedure TXMLEshopOrderType.Set_CreateDateTime(Value: WideString);
begin
  ChildNodes['CreateDateTime'].NodeValue := Value;
end;

function TXMLEshopOrderType.Get_CustomerData: IXMLCustomerDataType;
begin
  Result := ChildNodes['CustomerData'] as IXMLCustomerDataType;
end;

function TXMLEshopOrderType.Get_RecipientData: IXMLRecipientDataType;
begin
  Result := ChildNodes['RecipientData'] as IXMLRecipientDataType;
end;

function TXMLEshopOrderType.Get_OrderStatus: WideString;
begin
  Result := ChildNodes['OrderStatus'].Text;
end;

procedure TXMLEshopOrderType.Set_OrderStatus(Value: WideString);
begin
  ChildNodes['OrderStatus'].NodeValue := Value;
end;

function TXMLEshopOrderType.Get_OrderItems: IXMLOrderItemsType;
begin
  Result := ChildNodes['OrderItems'] as IXMLOrderItemsType;
end;

{ TXMLCustomerDataType }

procedure TXMLCustomerDataType.AfterConstruction;
begin
  RegisterChildNode('PersonData', TXMLPersonDataType);
  RegisterChildNode('CompanyData', TXMLCompanyDataType);
  RegisterChildNode('AddressData', TXMLAddressDataType);
  inherited;
end;

function TXMLCustomerDataType.Get_PersonData: IXMLPersonDataType;
begin
  Result := ChildNodes['PersonData'] as IXMLPersonDataType;
end;

function TXMLCustomerDataType.Get_CompanyData: IXMLCompanyDataType;
begin
  Result := ChildNodes['CompanyData'] as IXMLCompanyDataType;
end;

function TXMLCustomerDataType.Get_AddressData: IXMLAddressDataType;
begin
  Result := ChildNodes['AddressData'] as IXMLAddressDataType;
end;

{ TXMLPersonDataType }

function TXMLPersonDataType.Get_FirstName: WideString;
begin
  Result := ChildNodes['FirstName'].Text;
end;

procedure TXMLPersonDataType.Set_FirstName(Value: WideString);
begin
  ChildNodes['FirstName'].NodeValue := Value;
end;

function TXMLPersonDataType.Get_LastName: WideString;
begin
  Result := ChildNodes['LastName'].Text;
end;

procedure TXMLPersonDataType.Set_LastName(Value: WideString);
begin
  ChildNodes['LastName'].NodeValue := Value;
end;

function TXMLPersonDataType.Get_PhoneNumber: WideString;
begin
  Result := ChildNodes['PhoneNumber'].Text;
end;

procedure TXMLPersonDataType.Set_PhoneNumber(Value: WideString);
begin
  ChildNodes['PhoneNumber'].NodeValue := Value;
end;

function TXMLPersonDataType.Get_EmailAddress: WideString;
begin
  Result := ChildNodes['EmailAddress'].Text;
end;

procedure TXMLPersonDataType.Set_EmailAddress(Value: WideString);
begin
  ChildNodes['EmailAddress'].NodeValue := Value;
end;

{ TXMLCompanyDataType }

function TXMLCompanyDataType.Get_CompanyName: WideString;
begin
  Result := ChildNodes['CompanyName'].Text;
end;

procedure TXMLCompanyDataType.Set_CompanyName(Value: WideString);
begin
  ChildNodes['CompanyName'].NodeValue := Value;
end;

function TXMLCompanyDataType.Get_OrgIdNumber: WideString;
begin
  Result := ChildNodes['OrgIdNumber'].Text;
end;

procedure TXMLCompanyDataType.Set_OrgIdNumber(Value: WideString);
begin
  ChildNodes['OrgIdNumber'].NodeValue := Value;
end;

function TXMLCompanyDataType.Get_TaxIdNumber: WideString;
begin
  Result := ChildNodes['TaxIdNumber'].Text;
end;

procedure TXMLCompanyDataType.Set_TaxIdNumber(Value: WideString);
begin
  ChildNodes['TaxIdNumber'].NodeValue := Value;
end;

function TXMLCompanyDataType.Get_VatIdNumber: WideString;
begin
  Result := ChildNodes['VatIdNumber'].Text;
end;

procedure TXMLCompanyDataType.Set_VatIdNumber(Value: WideString);
begin
  ChildNodes['VatIdNumber'].NodeValue := Value;
end;

{ TXMLAddressDataType }

procedure TXMLAddressDataType.AfterConstruction;
begin
  RegisterChildNode('StreetData', TXMLStreetDataType);
  RegisterChildNode('CityData', TXMLCityDataType);
  RegisterChildNode('CountryData', TXMLCountryDataType);
  inherited;
end;

function TXMLAddressDataType.Get_StreetData: IXMLStreetDataType;
begin
  Result := ChildNodes['StreetData'] as IXMLStreetDataType;
end;

function TXMLAddressDataType.Get_CityData: IXMLCityDataType;
begin
  Result := ChildNodes['CityData'] as IXMLCityDataType;
end;

function TXMLAddressDataType.Get_CountryData: IXMLCountryDataType;
begin
  Result := ChildNodes['CountryData'] as IXMLCountryDataType;
end;

{ TXMLStreetDataType }

function TXMLStreetDataType.Get_Name: WideString;
begin
  Result := ChildNodes['Name'].Text;
end;

procedure TXMLStreetDataType.Set_Name(Value: WideString);
begin
  ChildNodes['Name'].NodeValue := Value;
end;

function TXMLStreetDataType.Get_Number: WideString;
begin
  Result := ChildNodes['Number'].Text;
end;

procedure TXMLStreetDataType.Set_Number(Value: WideString);
begin
  ChildNodes['Number'].NodeValue := Value;
end;

{ TXMLCityDataType }

function TXMLCityDataType.Get_Name: WideString;
begin
  Result := ChildNodes['Name'].Text;
end;

procedure TXMLCityDataType.Set_Name(Value: WideString);
begin
  ChildNodes['Name'].NodeValue := Value;
end;

function TXMLCityDataType.Get_PostCode: WideString;
begin
  Result := ChildNodes['PostCode'].Text;
end;

procedure TXMLCityDataType.Set_PostCode(Value: WideString);
begin
  ChildNodes['PostCode'].NodeValue := Value;
end;

{ TXMLCountryDataType }

function TXMLCountryDataType.Get_Name: WideString;
begin
  Result := ChildNodes['Name'].Text;
end;

procedure TXMLCountryDataType.Set_Name(Value: WideString);
begin
  ChildNodes['Name'].NodeValue := Value;
end;

function TXMLCountryDataType.Get_Code: WideString;
begin
  Result := ChildNodes['Code'].Text;
end;

procedure TXMLCountryDataType.Set_Code(Value: WideString);
begin
  ChildNodes['Code'].NodeValue := Value;
end;

{ TXMLRecipientDataType }

procedure TXMLRecipientDataType.AfterConstruction;
begin
  RegisterChildNode('PersonData', TXMLPersonDataType);
  RegisterChildNode('CompanyData', TXMLCompanyDataType);
  RegisterChildNode('AddressData', TXMLAddressDataType);
  inherited;
end;

function TXMLRecipientDataType.Get_PersonData: IXMLPersonDataType;
begin
  Result := ChildNodes['PersonData'] as IXMLPersonDataType;
end;

function TXMLRecipientDataType.Get_CompanyData: IXMLCompanyDataType;
begin
  Result := ChildNodes['CompanyData'] as IXMLCompanyDataType;
end;

function TXMLRecipientDataType.Get_AddressData: IXMLAddressDataType;
begin
  Result := ChildNodes['AddressData'] as IXMLAddressDataType;
end;

{ TXMLOrderItemsType }

procedure TXMLOrderItemsType.AfterConstruction;
begin
  RegisterChildNode('ItemData', TXMLItemDataType);
  ItemTag := 'ItemData';
  ItemInterface := IXMLItemDataType;
  inherited;
end;

function TXMLOrderItemsType.Get_ItemData(Index: Integer): IXMLItemDataType;
begin
  Result := List[Index] as IXMLItemDataType;
end;

function TXMLOrderItemsType.Add: IXMLItemDataType;
begin
  Result := AddItem(-1) as IXMLItemDataType;
end;

function TXMLOrderItemsType.Insert(const Index: Integer): IXMLItemDataType;
begin
  Result := AddItem(Index) as IXMLItemDataType;
end;


{ TXMLItemDataType }

procedure TXMLItemDataType.AfterConstruction;
begin
  RegisterChildNode('GoodsData', TXMLGoodsDataType);
  inherited;
end;

function TXMLItemDataType.Get_ItemId: WideString;
begin
  Result := AttributeNodes['ItemId'].Text;
end;

procedure TXMLItemDataType.Set_ItemId(Value: WideString);
begin
  SetAttribute('ItemId', Value);
end;

function TXMLItemDataType.Get_GoodsData: IXMLGoodsDataType;
begin
  Result := ChildNodes['GoodsData'] as IXMLGoodsDataType;
end;

function TXMLItemDataType.Get_SaleAmount: WideString;
begin
  Result := ChildNodes['SaleAmount'].NodeValue;
end;

procedure TXMLItemDataType.Set_SaleAmount(Value: WideString);
begin
  ChildNodes['SaleAmount'].NodeValue := Value;
end;

function TXMLItemDataType.Get_UnitPrice: WideString;
begin
  Result := ChildNodes['UnitPrice'].NodeValue;
end;

procedure TXMLItemDataType.Set_UnitPrice(Value: WideString);
begin
  ChildNodes['UnitPrice'].NodeValue := Value;
end;

function TXMLItemDataType.Get_DeliveryValue: WideString;
begin
  Result := ChildNodes['DeliveryValue'].NodeValue;
end;

procedure TXMLItemDataType.Set_DeliveryValue(Value: WideString);
begin
  ChildNodes['DeliveryValue'].NodeValue := Value;
end;

function TXMLItemDataType.Get_ItemStatus: WideString;
begin
  Result := ChildNodes['ItemStatus'].Text;
end;

procedure TXMLItemDataType.Set_ItemStatus(Value: WideString);
begin
  ChildNodes['ItemStatus'].NodeValue := Value;
end;

{ TXMLGoodsDataType }

function TXMLGoodsDataType.Get_GoodsCode: Integer;
begin
  Result := ChildNodes['GoodsCode'].NodeValue;
end;

procedure TXMLGoodsDataType.Set_GoodsCode(Value: Integer);
begin
  ChildNodes['GoodsCode'].NodeValue := Value;
end;

function TXMLGoodsDataType.Get_GoodsName: WideString;
begin
  Result := ChildNodes['GoodsName'].Text;
end;

procedure TXMLGoodsDataType.Set_GoodsName(Value: WideString);
begin
  ChildNodes['GoodsName'].NodeValue := Value;
end;

end.
