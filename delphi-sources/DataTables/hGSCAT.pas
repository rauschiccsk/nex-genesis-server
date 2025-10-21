unit hGSCAT;

interface

uses
  IcVariab, IcTypes, NexPath, NexGlob, bGSCAT, hBARCODE,
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Dialogs;

type
  TGscatHnd = class (TGscatbtr)
    destructor  Destroy; override;
  private
    ohBARCODE: TBarcodeHnd;
  public
    function NextGsCode:longint;
    function FreeGsCode:longint;
    function LocateGsCode(pBarCode:Str15):boolean; overload;
    function LocateBaCode(pBarCode:Str15):boolean;
  published
  end;

implementation

destructor TGscatHnd.Destroy;
begin
  If ohBARCODE<>nil then FreeAndNil(ohBARCODE);
  inherited ;
end;

// *************************************** PRIVATE ********************************************

// **************************************** PUBLIC ********************************************

function TGscatHnd.NextGsCode:longint;
begin
  SwapIndex;
  SetIndex (ixGsCode);
  If gvSys.EndGsCode=0 then begin
    Last;
    Result := GsCode+1;
  end
  else begin // Je zadany interval poradovych ciesiel
    NearestGsCode(gvSys.EndGsCode);
    If not IsLastRec or (GsCode>gvSys.EndGsCode) then Prior;
    Result := GsCode+1;
  end;
  If Result<gvSys.BegGsCode then Result := gvSys.BegGsCode;
  If LocateGsCode(result) then Result := 0;
  RestoreIndex;
end;

function TGscatHnd.LocateGsCode(pBarCode:Str15):boolean;
begin
  Result := LocateBarCode(pBarCode);
  If not Result then begin
    If ohBARCODE=nil then begin
      ohBARCODE := TBarcodeHnd.Create;  ohBARCODE.Open;
    end;
    If ohBARCODE.Active then begin
      If ohBARCODE.LocateBarCode(pBarCode) then begin
        Result := LocateGsCode(ohBARCODE.GsCode);
      end;
    end;
  end;
end;

function TGscatHnd.LocateBaCode(pBarCode:Str15):boolean;
begin
  Result := LocateBarCode(pBarCode);
  If not Result then begin
    If ohBARCODE=nil then begin
      ohBARCODE := TBarcodeHnd.Create;  ohBARCODE.Open;
    end;
    If ohBARCODE.Active then begin
      If ohBARCODE.LocateBarCode(pBarCode) then begin
        Result := LocateGsCode(ohBARCODE.GsCode);
      end;
    end;
  end;
end;

function TGscatHnd.FreeGsCode: longint;
var mGsCode:longint;
begin
  Result:=0;
  SwapIndex;
  SetIndex (ixGsCode);
  mGsCode:=gvSys.BegGsCode;
  If mGsCode=0 then mGsCode:=1;
  NearestGsCode(mGsCode);
  While (mGsCode=GsCode) and not Eof and((mGsCode<=gvSys.EndGsCode) or (gvSys.EndGsCode=0)) do
  begin
    Inc(mGsCode);Next;
  end;
  Result:=mGsCode;
  If (Result>gvSys.EndGsCode) and (gvSys.EndGsCode<>0) then Result:=gvSys.EndGsCode;
  RestoreIndex;
end;

end.
{MOD 1805021}
{MOD 1809008}