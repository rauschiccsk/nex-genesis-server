unit RpcFnc;
{$F+}

// *****************************************************************************
//                  ZBIERKA FUNKCII PO+ZIADAVIEK NA ZMENY CIEN
// *****************************************************************************
// Tento objekt obsahuje funkcie, ktoré umožnia prístup k požiadavkám na zmeny
// predajných cien.
//
// Programové funkcia:
// ---------------
// Add - založí pre zadaneho pracovnikanovy pracovny ukol
// *****************************************************************************


interface

uses
  IcTypes, IcConv, IcTools, IcVariab, IniFiles, SysUtils, NexGlob, Bok, Key,
  hRPC, hGSCAT, hABKDEF,
  NexPath, NexIni, TxtWrap, TxtCut, StkCanc, DocHand, TxtDoc, Forms;

type
  TRpcFnc = class
    constructor Create;
    destructor  Destroy; override;
    private
      oSerNum: longint; // Poradove cislo naposledy ulozenej poziadavky
      ohGSCAT: TGscatHnd;
      ohRPC: TRpcHnd;
      function Access (pPlsNum:word):boolean;
    public
      procedure Add (pPlsNum,pGsCode:longint;pAPrice,pBPrice:double;pSrcPmd:Str3);
    published
      property phRPC:TRpcHnd read ohRPC;
      property SerNum:longint read oSerNum write oSerNum;
  end;

implementation

uses bGSCAT;

constructor TRpcFnc.Create;
begin
  oSerNum := 0;
  ohGSCAT := TGscatHnd.Create;  ohGSCAT.Open;
  ohRPC := TRpcHnd.Create;
end;

destructor TRpcFnc.Destroy;
begin
  FreeAndNil (ohRPC);
  FreeAndNil (ohGSCAT);
end;

// ********************************* PRIVATE ***********************************

function TRpcFnc.Access (pPlsNum:word):boolean;
begin
  Result := TRUE;
//  gAfc.GrpNum := gvSys.LoginGroup;
//  gAfc.BookNum := StrInt(pPlsNum,0);
//  gAfc.RpcItmAdd;
end;

// ********************************** PUBLIC ***********************************

procedure TRpcFnc.Add (pPlsNum,pGsCode:longint;pAPrice,pBPrice:double;pSrcPmd:Str3);
begin
  If Access(pPlsNum) then begin // Nasli sme knihy pracovnych ukolov uzivatela komu chcema zalozit novy ukol
    If not ohRPC.Active or (ohRPC.BtrTable.ListNum<>pPlsNum) then ohRPC.Open(pPlsNum);
    If oSerNum=0 then oSerNum := ohRPC.NextSerNum;
    ohRPC.Insert;
    ohRPC.SerNum := oSerNum;
    ohRPC.GsCode := pGsCode;
    ohRPC.SrcPmd := pSrcPmd;
    If ohGSCAT.LocateGsCode(pGsCode) then begin
      ohRPC.GsName := ohGSCAT.GsName;
      ohRPC.MgCode := ohGSCAT.MgCode;
      ohRPC.FgCode := ohGSCAT.FgCode;
      ohRPC.BarCode := ohGSCAT.BarCode;
      ohRPC.StkCode := ohGSCAT.StkCode;
      ohRPC.MsName := ohGSCAT.MsName;
      ohRPC.VatPrc := ohGSCAT.VatPrc;
    end;
    ohRPC.BPrice := pBPrice;
    If IsNul(pAPrice)
      then ohRPC.APrice := Rd2(pBPrice/(1+ohRPC.VatPrc/100))
      else ohRPC.APrice := pAPrice;
    ohRPC.Post;
    oSerNum := 0;
  end;
end;

end.
