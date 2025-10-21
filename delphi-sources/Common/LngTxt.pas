unit LngTxt;
{$F+}

// *****************************************************************************
//                                SYSTEMOVE TEXTY
// *****************************************************************************
//
// Programové funkcia:
// ---------------
// *****************************************************************************


interface

uses
  IcTypes, IcConst, IcConv, IcTools, IcVariab, hLNGTXT,
  ComCtrls, SysUtils, Classes, Forms;

type
  TLngTxt = class(TComponent)
    constructor Create(AOwner: TComponent);
    destructor  Destroy; override;
    private
      ohSYSTXT:TLngTxtHnd;
    public
      function GetTxt(pKey:Str10;pDef:Str100):ShortString; overload;
      function GetTxt(pKey:Str10;pDef:Str100;pPar1:Str30):ShortString; overload;
      function GetTxt(pKey:Str10;pDef:Str100;pPar1,pPar2:Str30):ShortString; overload;
      function GetTxt(pKey:Str10;pDef:Str100;pPar1,pPar2,pPar3:Str30):ShortString; overload;
      function GetTxt(pKey:Str10;pDef:Str100;pPar1,pPar2,pPar3,pPar4:Str30):ShortString; overload;
      function GetTxt(pKey:Str10;pDef:Str100;pPar1,pPar2,pPar3,pPar4,pPar5:Str30):ShortString; overload;
  end;

function GetTxt(pKey:Str10;pDef:Str100):ShortString; overload;
function GetTxt(pKey:Str10;pDef:Str100;pPar1:Str30):ShortString; overload;
function GetTxt(pKey:Str10;pDef:Str100;pPar1,pPar2:Str30):ShortString; overload;
function GetTxt(pKey:Str10;pDef:Str100;pPar1,pPar2,pPar3:Str30):ShortString; overload;
function GetTxt(pKey:Str10;pDef:Str100;pPar1,pPar2,pPar3,pPar4:Str30):ShortString; overload;
function GetTxt(pKey:Str10;pDef:Str100;pPar1,pPar2,pPar3,pPar4,pPar5:Str30):ShortString; overload;

implementation

function GetTxt(pKey:Str10;pDef:Str100):ShortString;
var mSysTxt:TLngTxt;
begin
  mSysTxt := TLngTxt.Create(nil);
  Result := mSysTxt.GetTxt(pKey,pDef);
  FreeAndNil(mSysTxt)
end;

function GetTxt(pKey:Str10;pDef:Str100;pPar1:Str30):ShortString; overload;
var mSysTxt:TLngTxt;
begin
  If pPar1='' then pPar1 := ' ';
  mSysTxt := TLngTxt.Create(nil);
  Result := mSysTxt.GetTxt(pKey,pDef,pPar1);
  FreeAndNil(mSysTxt)
end;

function GetTxt(pKey:Str10;pDef:Str100;pPar1,pPar2:Str30):ShortString; overload;
var mSysTxt:TLngTxt;
begin
  If pPar1='' then pPar1 := ' ';
  If pPar2='' then pPar2 := ' ';
  mSysTxt := TLngTxt.Create(nil);
  Result := mSysTxt.GetTxt(pKey,pDef,pPar1,pPar2);
  FreeAndNil(mSysTxt)
end;

function GetTxt(pKey:Str10;pDef:Str100;pPar1,pPar2,pPar3:Str30):ShortString; overload;
var mSysTxt:TLngTxt;
begin
  If pPar1='' then pPar1 := ' ';
  If pPar2='' then pPar2 := ' ';
  If pPar3='' then pPar3 := ' ';
  mSysTxt := TLngTxt.Create(nil);
  Result := mSysTxt.GetTxt(pKey,pDef,pPar1,pPar2,pPar3);
  FreeAndNil(mSysTxt)
end;

function GetTxt(pKey:Str10;pDef:Str100;pPar1,pPar2,pPar3,pPar4:Str30):ShortString; overload;
var mSysTxt:TLngTxt;
begin
  If pPar1='' then pPar1 := ' ';
  If pPar2='' then pPar2 := ' ';
  If pPar3='' then pPar3 := ' ';
  If pPar4='' then pPar4 := ' ';
  mSysTxt := TLngTxt.Create(nil);
  Result := mSysTxt.GetTxt(pKey,pDef,pPar1,pPar2,pPar3,pPar4);
  FreeAndNil(mSysTxt)
end;

function GetTxt(pKey:Str10;pDef:Str100;pPar1,pPar2,pPar3,pPar4,pPar5:Str30):ShortString; overload;
var mSysTxt:TLngTxt;
begin
  If pPar1='' then pPar1 := ' ';
  If pPar2='' then pPar2 := ' ';
  If pPar3='' then pPar3 := ' ';
  If pPar4='' then pPar4 := ' ';
  If pPar5='' then pPar5 := ' ';
  mSysTxt := TLngTxt.Create(nil);
  Result := mSysTxt.GetTxt(pKey,pDef,pPar1,pPar2,pPar3,pPar4,pPar5);
  FreeAndNil(mSysTxt)
end;

// ********************************** OBJEKT ***********************************

constructor TLngTxt.Create(AOwner: TComponent);
begin
  ohSYSTXT := TLngTxtHnd.Create;  ohSYSTXT.Open;
end;

destructor TLngTxt.Destroy;
begin
  FreeAndNil(ohSYSTXT);
end;

// ********************************* PRIVATE ***********************************

// ********************************** PUBLIC ***********************************

function TLngTxt.GetTxt(pKey:Str10;pDef:Str100):ShortString;
begin
  Result := GetTxt(pKey,pDef,'','','','','');
end;

function TLngTxt.GetTxt(pKey:Str10;pDef:Str100;pPar1:Str30):ShortString;
begin
  Result := GetTxt(pKey,pDef,pPar1,'','','','');
end;

function TLngTxt.GetTxt(pKey:Str10;pDef:Str100;pPar1,pPar2:Str30):ShortString;
begin
  Result := GetTxt(pKey,pDef,pPar1,pPar2,'','','');
end;

function TLngTxt.GetTxt(pKey:Str10;pDef:Str100;pPar1,pPar2,pPar3:Str30):ShortString;
begin
  Result := GetTxt(pKey,pDef,pPar1,pPar2,pPar3,'','');
end;

function TLngTxt.GetTxt(pKey:Str10;pDef:Str100;pPar1,pPar2,pPar3,pPar4:Str30):ShortString;
begin
  Result := GetTxt(pKey,pDef,pPar1,pPar2,pPar3,pPar4,'');
end;

function TLngTxt.GetTxt(pKey:Str10;pDef:Str100;pPar1,pPar2,pPar3,pPar4,pPar5:Str30):ShortString;
begin
  If not ohSYSTXT.LocateKylg(UpString(pKey),gvSys.Language) then begin
    Result := pDef;
    ohSYSTXT.Insert;
    ohSYSTXT.Key := UpString(pKey);
    ohSYSTXT.Lng := gvSys.Language;
    ohSYSTXT.Txt := pDef;
    ohSYSTXT.Post
  end
  else Result := ohSYSTXT.Txt;
  If pPar1<>'' then Result := ReplaceStr (Result,'#1',pPar1);
  If pPar2<>'' then Result := ReplaceStr (Result,'#2',pPar2);
  If pPar3<>'' then Result := ReplaceStr (Result,'#3',pPar3);
  If pPar4<>'' then Result := ReplaceStr (Result,'#4',pPar4);
  If pPar5<>'' then Result := ReplaceStr (Result,'#5',pPar5);
  If Result='' then Result := pPar1+' '+pPar2+' '+pPar3+' '+pPar4+' '+pPar5;
end;

end.


