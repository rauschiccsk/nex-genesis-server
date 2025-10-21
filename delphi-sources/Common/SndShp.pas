unit SndShp;

interface

uses IcConv, IdHTTP, Classes, SysUtils;

const
  Codes64 = 'ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789+/';

type
  TSndShp = class
  private
    oGsCode:longint;
    oGsName:string;
    oBarCode:string;
    oGscNot1:string;
    oGscNot2:string;
    oGscNot3:string;
    oGscNot4:string;
    oGscNot5:string;
    oGscNot6:string;
    oAPrice:double;
    oBPrice:double;
    oVatPrc:byte;
    oMsName:string;
    oMgCode:longint;
    oFgCode:longint;
    oSgCode:longint;
    oOsdCode:string;
    oSpcCode:string;
    oPict1:string;
    oPict2:string;
    oPict3:string;
    oPict4:string;
    oEShop:byte;

    oHTTPCode:longint;
    oHTTPText:string;
    oStatus:longint;
    oStatusStr:string;

    function GetDescrStr:string;
    function LoadFileToStr(pFileName:string):string;
    function EncodeBase64(pStr:string):string;
    function DecodeBase64(pStr: string):string;
  public
    constructor Create;
    destructor  Destroy; override;

    procedure ClearData;
    function  SndGsc:boolean;
    function  DelGsc:boolean;
    function  LoadPict(pNum:byte;pFileName:string):boolean;
    procedure SetDeletePict(pNum:byte);
    procedure SetNoChangePict(pNum:byte);
  published
    property GsCode:longint read oGsCode write oGsCode;
    property GsName:string read oGsName write oGsName;
    property BarCode:string read oBarCode write oBarCode;
    property GscNot1:string read oGscNot1 write oGscNot1;
    property GscNot2:string read oGscNot2 write oGscNot2;
    property GscNot3:string read oGscNot3 write oGscNot3;
    property GscNot4:string read oGscNot4 write oGscNot4;
    property GscNot5:string read oGscNot5 write oGscNot5;
    property GscNot6:string read oGscNot6 write oGscNot6;
    property APrice:double read oAPrice write oAPrice;
    property BPrice:double read oBPrice write oBPrice;
    property VatPrc:byte read oVatPrc write oVatPrc;
    property MsName:string read oMsName write oMsName;
    property MgCode:longint read oMgCode write oMgCode;
    property FgCode:longint read oFgCode write oFgCode;
    property SgCode:longint read oSgCode write oSgCode;
    property OsdCode:string read oOsdCode write oOsdCode;
    property SpcCode:string read oSpcCode write oSpcCode;
    property EShop:byte read oEShop write oEShop;
    property Pict1:string read oPict1 write oPict1;
    property Pict2:string read oPict2 write oPict2;
    property Pict3:string read oPict3 write oPict3;
    property Pict4:string read oPict4 write oPict4;

    property HTTPCode:longint read oHTTPCode write oHTTPCode;
    property HTTPText:string read oHTTPText write oHTTPText;
    property Status:longint read oStatus write oStatus;
    property StatusStr:string read oStatusStr write oStatusStr;
  end;

implementation
(*
Pri komunikácií vysledok komunikácie vráti property Status:
1 - nová položka zaevidovaná
2 - existujúca položka zmenená
3 - položka zrušená
4 - položka neexistuje pri zrušení
-1 - chyba pri vykonaní operácie

Stav HTTP komunikácie vráti property HTTPCode a HTTPText.
Ak HTTPCode=200, komunikácia prebehla v poriadku.

Príklad na odoslanie položky:

var mR:TSndShp;
begin
  mR:=TSndShp.Create;
  mR.GsCode:=ValInt (E_GsCode.Text);
  mR.GsName:=E_Name.Text;
  mR.Descr1:=E_Descr1.Text;
  mR.Descr2:=E_Descr2.Text;
  mR.APrice:=ValDoub(E_APrice.Text);
  mR.BPrice:=ValDoub(E_Price.Text);
  mR.VatPrc:=ValInt(E_VatPrc.Text);
  mR.BarCode:=E_BarCode.Text;
  mR.MsName:=E_Meas.Text;
  mR.MgCode:=ValInt (E_MgCode.Text);
  mR.FgCode:=ValInt (E_FgCode.Text);
  mR.SgCode:=ValInt (E_SgCode.Text);
  mR.OsdCode:=E_OsdCode.Text;
  mR.SpcCode:=E_SpcCode.Text;
  mR.EShop:=ValInt(E_eshop.Text);

Práca s obrázkami od 1 do 4
  mR.LoadPict(1, E_Pict.Text); - naèíta obrázok zo súboru
  mR.SetDeletePict(1);         - nastaví vymazanie obrázku
  mR.SetNoChangePict(1);       - obrázok nebude poslaný

  If not mR.SendGs then begin
    Ak je problém pri odoslaní údajov, tieto property vrtátia chybový stav
    mR.Status
    mR.StatusStr
    mR.HTTPCode
    mR.HTTPText
  end;
  FreeAndNil (mR);
end;


Príklad na zrušenie položky:

var mR:TSndShp;
begin
  mR:=TSndShp.Create;
  mR.GsCode:=ValInt(E_GsCode.Text);
  If not mR.DeleteGs then begin
    Ak je problém pri odoslaní údajov, tieto property vrtátia chybový stav
    mR.Status
    mR.StatusStr
    mR.HTTPCode
    mR.HTTPText
  end;
  FreeAndNil(mR);
end;

*)


function TSndShp.GetDescrStr:string;
begin
  Result := oGscNot1+'#13'+oGscNot2+'#13'+oGscNot3+'#13'+oGscNot4+'#13'+oGscNot5+'#13'+oGscNot6+'#13';
end;

function TSndShp.LoadFileToStr(pFileName: string):string;
var mFileStream:TFileStream;
begin
  Result:= '';
  If (pFileName<>'')  and FileExists (pFileName) then begin
    mFileStream:= TFileStream.Create(pFileName, fmOpenRead or fmShareDenyWrite);
    try
      If mFileStream.Size>0 then begin
        SetLength(Result, mFileStream.Size);
        mFileStream.Read(Pointer(Result)^, mFileStream.Size);
      end;
    finally
      mFileStream.Free;
    end;
  end;
end;

function TSndShp.EncodeBase64(pStr:string):string;
var i,a,x,b: integer;
begin
  Result:='';
  a:=0; b:=0;
  For i:=1 to Length(pStr) do begin
    x:=Ord(pStr[i]);
    b:=b*256+x;
    a:=a+8;
    while a>=6 do begin
      a:=a-6;
      x:=b div (1 shl a);
      b:=b mod (1 shl a);
      Result:=Result+Codes64[x+1];
    end;
  end;
  If a>0 then begin
    x:=b shl (6-a);
    Result:=Result+Codes64[x+1];
  end;
end;

function TSndShp.DecodeBase64(pStr:string):string;
var i,a,x,b:integer;
begin
  Result:='';
  a:=0; b:=0;
  For i:=1 to Length(pStr) do begin
    x:=Pos(pStr[i],codes64)-1;
    If x >= 0 then begin
      b:=b*64+x;
      a:=a+6;
      If a>=8 then begin
        a:=a-8;
        x:=b shr a;
        b:=b mod (1 shl a);
        x:=x mod 256;
        Result:=Result+chr(x);
      end;
    end else Exit;
  end;
end;

constructor TSndShp.Create;
begin
  ClearData;
end;

destructor TSndShp.Destroy;
begin
  inherited;
end;

procedure TSndShp.ClearData;
begin
  oGsCode:=0;
  oGsName:='';
  oBarCode:='';
  oGscNot1:=''; oGscNot2:=''; oGscNot3:=''; oGscNot4:=''; oGscNot5:=''; oGscNot6:='';
  oAPrice:= 0; oBPrice:= 0; oVatPrc:= 0;
  oMsName  := '';
  oMgCode  := 0; oFgCode  := 0; oSgCode  := 0;
  oOsdCode := ''; oSpcCode := '';
  oPict1 := ''; oPict2 := ''; oPict3 := ''; oPict4 := '';
  oEShop:= 1;
end;

function TSndShp.SndGsc:boolean;
var mParameters: TStrings; mIdHTTP:TIdHttp; mS:string;
begin
  mParameters := TStringList.Create;
  mParameters.Add('plu_tovar='+StrInt (oGSCode,0));
  mParameters.Add('nazov_produktu='+oGsName);
  mParameters.Add('popis='+GetDescrStr);
  mParameters.Add('kod_produktu='+oBarCode);
  mParameters.Add('cena='+StrDoub (oBPrice,0,2));
  mParameters.Add('cena_bez_dph='+StrDoub(oAPrice,0,2));
  mParameters.Add('dph='+StrInt (oVatPrc,0));
  mParameters.Add('merna_jednotka='+oMsName);
  mParameters.Add('id_kategorie='+StrInt(oMgCode,0));
  mParameters.Add('financna_skupina='+StrInt (oFgCode,0));
  mParameters.Add('specifikacna_skupina='+StrInt (oSgCode,0));
  mParameters.Add('objednavkovy_kod='+oOsdCode);
  mParameters.Add('specifikacny_kod='+oSpcCode);
  mParameters.Add('e_shop='+StrInt(oEShop,0));
  mParameters.Add('deleted=0');
  mParameters.Add('foto1='+oPict1);
  mParameters.Add('foto2='+oPict2);
  mParameters.Add('foto3='+oPict3);
  mParameters.Add('foto4='+oPict4);

  mIdHTTP:=TIdHTTP.Create;
  Result:=FALSE;
  try
    mS:=mIdHTTP.Post('http://www.asuan.sk/import-dat/script1.php', mParameters);
    oStatusStr:=mS;
    Delete(mS,1,3);
    oStatus:=ValInt(mS);
    Result:=oStatus>0;
  except end;
  try
    oHTTPCode:=mIdHTTP.ResponseCode;
    oHTTPText:=mIdHTTP.ResponseText;
  except end;
  FreeAndNil(mIdHTTP);
  FreeAndNil(mParameters);
end;

function  TSndShp.DelGsc:boolean;
var mParameters:TStrings; mIdHTTP:TIdHttp; mS:string;
begin
  mParameters:=TStringList.Create;
  mParameters.Add('plu_tovar='+StrInt(oGSCode,0));
  mParameters.Add('deleted=1');

  mIdHTTP:=TIdHTTP.Create;
  Result:=FALSE;
  try
    mS:=mIdHTTP.Post('http://www.asuan.sk/import-dat/script1.php', mParameters);
    oStatusStr:=mS;
    Delete(mS,1,3);
    oStatus:=ValInt(mS);
    Result:=oStatus>0;
  except end;
  try
    oHTTPCode:=mIdHTTP.ResponseCode;
    oHTTPText:=mIdHTTP.ResponseText;
  except end;
  FreeAndNil(mIdHTTP);
  FreeAndNil(mParameters);
end;

function  TSndShp.LoadPict(pNum:byte;pFileName:string):boolean;
var mPict:string;
begin
  If pNum in [1..4] then begin
    mPict:=EncodeBase64((LoadFileToStr(pFileName)));
    If pNum=1 then oPict1:=mPict;
    If pNum=2 then oPict2:=mPict;
    If pNum=3 then oPict3:=mPict;
    If pNum=4 then oPict4:=mPict;
  end;
end;

procedure TSndShp.SetDeletePict(pNum:byte);
begin
  If pNum in [1..4] then begin
    If pNum=1 then oPict1:='-';
    If pNum=2 then oPict2:='-';
    If pNum=3 then oPict3:='-';
    If pNum=4 then oPict4:='-';
  end;
end;

procedure TSndShp.SetNoChangePict(pNum:byte);
begin
  If pNum in [1..4] then begin
    If pNum=1 then oPict1:='';
    If pNum=2 then oPict2:='';
    If pNum=3 then oPict3:='';
    If pNum=4 then oPict4:='';
  end;
end;

end.
{MOD 1904013}
{MOD 1904023}
