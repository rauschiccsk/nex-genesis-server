unit NxcCom;
{$F+}

// *****************************************************************************
//                           NEX CLIENT COMMUNICATOR
// *****************************************************************************

interface

uses
  UniHnd,
  ComCtrls, SysUtils, Classes, Forms;

type
  TNxcCom = class
    constructor Create(pMod:string);
    destructor  Destroy; override;
    private
      oMod:string;
      oFld:TStrings;
    public
      procedure Com(pCom:string); overload;
      procedure Com(pCom,pVal:string); overload;
      procedure AddFld(pFld,pVal:string);
      function GetText(pFld:string):string;
      function GetLong(pFld:string):longint;
    published
  end;

implementation

constructor TNxcCom.Create(pMod:string);
begin
  oMod := pMod;
  oFld := TStringList.Create;
  oFld.Clear;
end;

destructor TNxcCom.Destroy;
begin
  FreeAndNil(oFld)
end;

// ********************************* PRIVATE ***********************************

// ********************************** PUBLIC ***********************************

procedure TNxcCom.Com(pCom:string);
begin
end;

procedure TNxcCom.Com(pCom,pVal:string);
begin
end;

procedure TNxcCom.AddFld(pFld,pVal:string);
begin
  oFld.Add(pFld+';'+pVal);
end;

function TNxcCom.GetText(pFld:string):string;
begin
end;

function TNxcCom.GetLong(pFld:string):longint;
begin
end;

end.

