unit NexXml;
// *******************************************************************************************************************************
//                                                           LOG METHODS
// *******************************************************************************************************************************
//                                                   Copyright(c) 2024 ICC s.r.o.
//                                                       All rights reserved
//
// ------------------------------------------------------- UNIT DESCRIPTION ------------------------------------------------------
// ------------------------------------------------------ METODS DESCRIPTION -----------------------------------------------------
// ----------------------------------------------------- UNIT VERSION HISTPRY ----------------------------------------------------
// 1.0 - Initial version created by: Zoltan Rausch on 2024-04-26
// =======================================================================================================-=======================

interface

uses
  {Delphi} StdCtrls, SysUtils, SyncObjs, XmlDoc, XmlUtil, XmlIntf, XSBuiltIns,
  {NEX}    IcDate, NexPath;


  function XmlTimeToDateTime(pXmlDateTime:string):TDateTime;
  function DateTimeToXmlTime(pDateTime:TDateTime):string;
  function GetXmlChildNode(pXmlNode:IXmlNode;pName:string):IXmlNode;

implementation

function XmlTimeToDateTime(pXmlDateTime:string):TDateTime;
begin
  Result:=0;
  with TXSDateTime.Create() do
    try
      XSToNative(pXmlDateTime); // convert from WideString
      Result:=AsDateTime; // convert to TDateTime
    finally
      Free;
    end;
end;

function DateTimeToXmlTime(pDateTime:TDateTime):string;
begin
  Result:='';
  with TXSDateTime.Create() do
    try
      AsDateTime:=pDateTime; // convert from TDateTime
      Result:=NativeToXS; // convert to WideString
    finally
      Free;
    end;
end;

function GetXmlChildNode(pXmlNode:IXmlNode;pName:string):IXmlNode;
var I, mIndex:longint;
begin
  Result:=nil;
  If pXmlNode<>nil then begin
    If pXmlNode.ChildNodes.Count>0 then begin
      mIndex := -1;
      For I:=0 to pXmlNode.ChildNodes.Count-1 do begin
        If pXmlNode.ChildNodes[I].NodeName=pName then begin
          mIndex:=I;
          Break;
        end;
      end;
      If mIndex>-1 then Result := pXmlNode.ChildNodes[mIndex];
    end;
  end;
  If Result=nil then Result := pXmlNode.ChildNodes[pName];
end;

initialization

finalization

end.

