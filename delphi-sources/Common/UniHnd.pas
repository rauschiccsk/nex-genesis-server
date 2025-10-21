unit UniHnd;
{$F+}

// *****************************************************************************
//                           NEX CLIENT COMMUNICATOR
// *****************************************************************************

interface

uses
  IcTypes, FxmHnd,
  ComCtrls, SysUtils, Classes, Forms;

type
  TUniHnd = class
    constructor Create;
    destructor  Destroy; override;
    private
      oFxm:TFxmHnd;
      function Text(pFld:string;pDat:TStrings):string;
      procedure Fxm(pCom:string;pDat:TStrings);
    public
      procedure Run(pMod:Str3;pCom:string;pDat:TStrings);
    published
  end;

implementation

constructor TUniHnd.Create;
begin
  oFxm := nil;
end;

destructor TUniHnd.Destroy;
begin
  If oFxm<>nil then FreeAndNil(oFxm);
end;

// ********************************* PRIVATE ***********************************

function TUniHnd.Text(pFld:string;pDat:TStrings):string;
begin
end;

procedure TUniHnd.Fxm(pCom:string;pDat:TStrings);
begin
  If oFxm=nil then oFxm := TFxmHnd.Create;
  If pCom='DocLoc' then oFxm.DocLoc(Text('DocNum',pDat));
end;

// ********************************** PUBLIC ***********************************

procedure TUniHnd.Run(pMod:Str3;pCom:string;pDat:TStrings);
begin
  If pMod='FXM' then Fxm(pCom,pDat);
end;

end.

