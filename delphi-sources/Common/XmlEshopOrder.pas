unit XmlEshopOrder;
/// ******************************************************************************************************************************
///                                               ACCESS TO XML ESHOP ORDER DATTA
/// ******************************************************************************************************************************
///
///                                                 Copyright(c) 2024 ICC, s.r.o.
///                                                      All rights reserved
///
/// ----------------------------------------------------- UNIT DESCRIPTION -------------------------------------------------------
/// XmlEshopOrderTemplate -
/// XmlEshopOrderExtended -
/// ==============================================================================================================================
/// ----------------------------------------------------- RELATED DOCUMENTS ------------------------------------------------------
/// WORD: NEX Kompendium
/// ------------------------------------------------------ VERSION HISTPRY -------------------------------------------------------
/// 1.0 - Initial version (created by: Zoltan Rausch) on 01.06.2024
/// ==============================================================================================================================

interface

uses
  XmlEshopOrderSchema, NexXml, IcConv,
  Classes, SysUtils, XmlDoc, XmlUtil, XmlIntf;

type
  TXmlEshopOrderHand = class
  private
    function GetOrderId:Integer;
    function GetDeliveryComplet:Boolean;
    function GetDeliveryPersonal:Boolean;
    function GetCashOnDelivery:Boolean;
    function GetOrderNumber:String;
    function GetCreateDateTime:TDateTime;

    function GetCustomerName:String;
    function GetCustomerAddress:String;
    function GetCustomerZipCode:String;
    function GetCustomerCityName:String;
    function GetCustomerCountryCode:String;
    function GetCustomerCountryName:String;
    function GetCustomerPersonName:String;
    function GetCustomerPhoneNumber:String;
    function GetCustomerEmailAddress:String;
    function GetOrgIdNumber:String;
    function GetTaxIdNumber:String;
    function GetVatIdNumber:String;

    function GetDeliveryName:String;
    function GetDeliveryAddress:String;
    function GetDeliveryZipCode:String;
    function GetDeliveryCityName:String;
    function GetDeliveryCountryCode:String;
    function GetDeliveryCountryName:String;
    function GetDeliveryPersonName:String;
    function GetDeliveryPhoneNumber:String;
    function GetDeliveryEmailAddress:String;
    function GetOrderValue:Double;

    function GetItemCount:Longint;
  public
    oXmlEshopOrder: IXMLEshopOrderType;
    constructor Create;
    procedure LoadXmlFromFile(pFileName:String);

    property OrderId:Integer read GetOrderId;
    property DeliveryComplet:Boolean read GetDeliveryComplet;
    property DeliveryPersonal:Boolean read GetDeliveryPersonal;
    property CashOnDelivery:Boolean read GetCashOnDelivery;
    property OrderNumber:String read GetOrderNumber;
    property CreateDateTime:TDateTime read GetCreateDateTime;

    property CustomerName:String read GetCustomerName;
    property CustomerAddress:String read GetCustomerAddress;
    property CustomerZipCode:String read GetCustomerZipCode;
    property CustomerCityName:String read GetCustomerCityName;
    property CustomerCountryCode:String read GetCustomerCountryCode;
    property CustomerCountryName:String read GetCustomerCountryName;
    property CustomerPersonName:String read GetCustomerPersonName;
    property CustomerPhoneNumber:String read GetCustomerPhoneNumber;
    property CustomerEmailAddress:String read GetCustomerEmailAddress;
    property OrgIdNumber:String read GetOrgIdNumber;
    property TaxIdNumber:String read GetTaxIdNumber;
    property VatIdNumber:String read GetVatIdNumber;
    property DeliveryName:String read GetDeliveryName;
    property DeliveryAddress:String read GetDeliveryAddress;
    property DeliveryZipCode:String read GetDeliveryZipCode;
    property DeliveryCityName:String read GetDeliveryCityName;
    property DeliveryCountryCode:String read GetDeliveryCountryCode;
    property DeliveryCountryName:String read GetDeliveryCountryName;
    property DeliveryPersonName:String read GetDeliveryPersonname;
    property DeliveryPhoneNumber:String read GetDeliveryPhoneNumber;
    property DeliveryEmailAddress:String read GetDeliveryEmailAddress;
    property OrderValue:Double read GetOrderValue;

    property ItemCount:Longint read GetItemCount;
  end;

implementation

// -------------------------------------------------- PUBLIC METHODS ---------------------------------------------------

constructor TXmlEshopOrderHand.Create;
begin
  inherited Create;
end;

procedure TXmlEshopOrderHand.LoadXmlFromFile(pFileName:String);
begin
  oXmlEshopOrder := LoadEshopOrder(pFileName);
end;

// -------------------------------------------------- PRIVATE METHODS --------------------------------------------------

function TXmlEshopOrderHand.GetOrderId:Integer;
begin
  Result := StrToInt(oXmlEshopOrder.OrderId);
end;

function TXmlEshopOrderHand.GetDeliveryComplet:Boolean;
begin
  Result := UpString(oXmlEshopOrder.DeliveryComplet)='TRUE';
end;

function TXmlEshopOrderHand.GetDeliveryPersonal:Boolean;
begin
  Result := UpString(oXmlEshopOrder.DeliveryPersonal)='TRUE';
end;

function TXmlEshopOrderHand.GetCashOnDelivery:Boolean;
begin
  Result := UpString(oXmlEshopOrder.CashOnDelivery)='TRUE';
end;

function TXmlEshopOrderHand.GetOrderNumber:String;
begin
  Result := oXmlEshopOrder.OrderNumber;
end;

function TXmlEshopOrderHand.GetCreateDateTime:TDateTime;
begin
  Result := XmlTimeToDateTime(oXmlEshopOrder.CreateDateTime);
end;

function TXmlEshopOrderHand.GetCustomerName:String;
begin
  if oXmlEshopOrder.CustomerData.CompanyData.CompanyName<>''
    then Result := oXmlEshopOrder.CustomerData.CompanyData.CompanyName
    else Result := GetCustomerPersonName;
end;

function TXmlEshopOrderHand.GetCustomerAddress:String;
begin
  Result := oXmlEshopOrder.CustomerData.AddressData.StreetData.Name+' '+oXmlEshopOrder.CustomerData.AddressData.StreetData.Number;
end;

function TXmlEshopOrderHand.GetCustomerZipCode:String;
begin
  Result := oXmlEshopOrder.CustomerData.AddressData.CityData.PostCode;
end;

function TXmlEshopOrderHand.GetCustomerCityName:String;
begin
  Result := oXmlEshopOrder.CustomerData.AddressData.CityData.Name;
end;

function TXmlEshopOrderHand.GetCustomerCountryCode:String;
begin
  Result := oXmlEshopOrder.CustomerData.AddressData.CountryData.Code;
end;

function TXmlEshopOrderHand.GetCustomerCountryName:String;
begin
  Result := oXmlEshopOrder.CustomerData.AddressData.CountryData.Name;
end;

function TXmlEshopOrderHand.GetCustomerPersonName:String;
begin
  Result := oXmlEshopOrder.CustomerData.PersonData.FirstName+' '+oXmlEshopOrder.CustomerData.PersonData.LastName;
end;

function TXmlEshopOrderHand.GetCustomerPhoneNumber:String;
begin
  Result := oXmlEshopOrder.CustomerData.PersonData.PhoneNumber;
end;

function TXmlEshopOrderHand.GetCustomerEmailAddress:String;
begin
  Result := oXmlEshopOrder.CustomerData.PersonData.EmailAddress;
end;

function TXmlEshopOrderHand.GetOrgIdNumber:String;
begin
  if oXmlEshopOrder.CustomerData.CompanyData.OrgIdNumber<>''
    then Result := oXmlEshopOrder.CustomerData.CompanyData.OrgIdNumber
    else Result := GetCustomerPhoneNumber;
end;

function TXmlEshopOrderHand.GetTaxIdNumber:String;
begin
  Result := oXmlEshopOrder.CustomerData.CompanyData.TaxIdNumber;
end;

function TXmlEshopOrderHand.GetVatIdNumber:String;
begin
  Result := oXmlEshopOrder.CustomerData.CompanyData.VatIdNumber;
end;

function TXmlEshopOrderHand.GetDeliveryName:String;
begin
  if oXmlEshopOrder.RecipientData.CompanyData.CompanyName<>''
    then Result := oXmlEshopOrder.RecipientData.CompanyData.CompanyName
    else Result := GetDeliveryPersonName;
end;

function TXmlEshopOrderHand.GetDeliveryAddress:String;
begin
  Result := oXmlEshopOrder.RecipientData.AddressData.StreetData.Name+' '+oXmlEshopOrder.RecipientData.AddressData.StreetData.Number;
end;

function TXmlEshopOrderHand.GetDeliveryZipCode:String;
begin
  Result := oXmlEshopOrder.RecipientData.AddressData.CityData.PostCode;
end;

function TXmlEshopOrderHand.GetDeliveryCityName:String;
begin
  Result := oXmlEshopOrder.RecipientData.AddressData.CityData.Name;
end;

function TXmlEshopOrderHand.GetDeliveryCountryCode:String;
begin
  Result := oXmlEshopOrder.RecipientData.AddressData.CountryData.Code;
end;

function TXmlEshopOrderHand.GetDeliveryCountryName:String;
begin
  Result := oXmlEshopOrder.RecipientData.AddressData.CountryData.Name;
end;

function TXmlEshopOrderHand.GetDeliveryPersonName:String;
begin
  Result := oXmlEshopOrder.RecipientData.PersonData.FirstName+' '+oXmlEshopOrder.RecipientData.PersonData.LastName;
end;

function TXmlEshopOrderHand.GetDeliveryPhoneNumber:String;
begin
  Result := oXmlEshopOrder.RecipientData.PersonData.PhoneNumber;
end;

function TXmlEshopOrderHand.GetDeliveryEmailAddress:String;
begin
  Result := oXmlEshopOrder.RecipientData.PersonData.EmailAddress;
end;

function TXmlEshopOrderHand.GetOrderValue:Double;
var mIndex:Integer; mValue,mAmout,mPrice:Double;
begin
  mValue := 0;
  for mIndex := 0 to ItemCount-1 do begin
    mAmout := ValDoub(oXmlEshopOrder.OrderItems.ItemData[mIndex].SaleAmount);
    mPrice := ValDoub(oXmlEshopOrder.OrderItems.ItemData[mIndex].UnitPrice);
    mValue := mValue+mAmout*mPrice;
  end;
  Result := mValue;
end;

function TXmlEshopOrderHand.GetItemCount:Longint;
begin
  Result := oXmlEshopOrder.OrderItems.Count;
end;

end.

