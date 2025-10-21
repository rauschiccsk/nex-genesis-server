unit Gsd;  
{$F+}
// *****************************************************************************
// **********               DATABÁZOVÉ SÚBORY TOVAROV                 **********
// *****************************************************************************
interface

uses
  IcTypes, IcConv, IcTools, IcVariab, SysUtils, Std, Pld,
  hGSCAT, hBARCODE, hFGLST, hMGLST, hSGLST,
  Forms;

type
  TGsd=class
    constructor Create;
    destructor Destroy; override;
    private
      function GetGsCode:longint;
    public
      oPld:TPld;          // Predajné cenníky
      oStd:TStd;          // Skladové karty zásob
      ohGSC:TGscatHnd;    // Evidennèné karty tovarov
      ohBAC:TBarCodeHnd;  // Druhotné identifikaèné kódy
      ohMGC:TMglstHnd;    // Tovarové skupiny
      ohFGC:TFglstHnd;    // Finanèné skupiny
      ohSGC:TSglstHnd;    // Špeciálne skupiny
      procedure OpenGSC;
      procedure OpenBAC;
      procedure OpenMGC;
      procedure OpenFGC;
      procedure OpenSGC;
      function LocGsCode(pGsCode:longint):boolean;  // Vyh¾adávanie pod¾a tovarového èísla (PLU)
      function LocBaCode(pBaCode:Str15):boolean;    // Vyh¾adávanie pod¾a èiarového kódu
      function LocSpCode(pSpCode:Str30):boolean;    // Vyh¾adávanie pod¾a Špecifikaèného kódu
      function LocOsCode(pOsCode:Str30):boolean;    // Vyh¾adávanie pod¾a objednávkového kódu
      function LocIdCode(pIdCode:Str30):boolean;    // Vyh¾adávanie pod¾a všetkých kódov
    published
      property GsCode:longint read GetGsCode;
  end;

implementation

constructor TGsd.Create;
begin
  ohGSC:=nil;
  ohBAC:=nil;
  ohMGC:=nil;
  ohFGC:=nil;
  ohSGC:=nil;
  oPld:=TPld.Create;
  oStd:=TStd.Create;
end;

destructor TGsd.Destroy;
begin
  FreeAndnil(oStd);
  FreeAndnil(oPld);
  If ohSGC<>nil then FreeAndnil(ohSGC);
  If ohFGC<>nil then FreeAndnil(ohFGC);
  If ohMGC<>nil then FreeAndnil(ohMGC);
  If ohBAC<>nil then FreeAndnil(ohBAC);
  If ohGSC<>nil then FreeAndnil(ohGSC);
end;

// ********************************* PRIVATE ***********************************

function TGsd.GetGsCode:longint;
begin
  OpenGSC;
  Result:=ohGSC.GsCode;
end;

// ********************************** PUBLIC ***********************************

procedure TGsd.OpenGSC;
begin
  If ohGSC=nil then begin
    ohGSC:=TGscatHnd.Create;  ohGSC.Open;
  end;
end;

procedure TGsd.OpenBAC;
begin
  If ohBAC=nil then begin
    ohBAC:=TBarcodeHnd.Create;  ohBAC.Open;
  end;
end;

procedure TGsd.OpenMGC;
begin
  If ohMGC=nil then begin
    ohMGC:=TMglstHnd.Create;  ohMGC.Open;
  end;
end;

procedure TGsd.OpenFGC;
begin
  If ohFGC=nil then begin
    ohFGC:=TFglstHnd.Create;  ohFGC.Open;
  end;
end;

procedure TGsd.OpenSGC;
begin
  If ohSGC=nil then begin
    ohSGC:=TSglstHnd.Create;  ohSGC.Open;
  end;
end;

function TGsd.LocGsCode(pGsCode:longint):boolean;
begin
  OpenGsc;
  Result:=ohGSC.LocateGsCode(pGsCode);
end;

function TGsd.LocBaCode(pBaCode:Str15):boolean;
begin
  OpenGsc;
  Result:=ohGSC.LocateBarCode(pBaCode);
  If not Result then begin
    OpenBac;
    If ohBAC.LocateBarCode(pBaCode) then Result:=ohGSC.LocateGsCode(ohBAC.GsCode);
  end;
end;

function TGsd.LocSpCode(pSpCode:Str30):boolean;
begin
  OpenGsc;
  Result:=ohGSC.LocateSpcCode(pSpCode);
end;

function TGsd.LocOsCode(pOsCode:Str30):boolean;
begin
  OpenGsc;
  Result:=ohGSC.LocateOsdCode(pOsCode);
end;

function TGsd.LocIdCode(pIdCode:Str30):boolean;
begin
  Result:=FALSE;
  If (pIdCode[1]='.') or (pIdCode[1]=',') then begin
    Delete(pIdCode,1,1);
    Result:=LocGsCode(ValInt(pIdCode));
  end else begin
    Result:=LocSpCode(pIdCode);
    If not Result then Result:=LocOsCode(pIdCode);
    If not Result then Result:=LocBaCode(pIdCode);
  end;
end;

end.


