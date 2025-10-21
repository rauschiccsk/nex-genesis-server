unit Gsi;
{$F+}

// *****************************************************************************
//                  ZBIERKA FUNKCII NA PRACU S EVIDENCIOU TOVARU
// *****************************************************************************
// Programové funkcia:
// ---------------
// *****************************************************************************


interface

uses
  IcTypes, IcConv, IcTools, IcVariab, IniFiles, SysUtils, NexGlob,
  hGSCAT, bGSCAT, hBARCODE,
  NexPath, NexIni, TxtWrap, TxtCut, StkCanc, DocHand, TxtDoc, Forms;

type
  TGsi=class
    constructor Create;
    destructor  Destroy; override;
    private
    public
      ohGSCAT:TGscatHnd;
      ohBARCODE:TBarcodeHnd;
      function  Locate(pCode:Str30):boolean;

      function  LocateGsCode(pGsCode:longint):boolean;
      function  LocateSpcCode(pSpcCode:Str30):boolean;
      function  LocateBarCode(pBarCode:Str15):boolean;
      function  NextGsCode:longint;
      procedure ImportRef(pPath:Str60;pImpFld:byte;pOnlyNew:boolean);
      // pImfld = 0(podla GsCode) 1(podla BarCode) 2(podla SpcCode)
    published
  end;

implementation

constructor TGsi.Create;
begin
  ohGSCAT:=TGscatHnd.Create;  ohGSCAT.Open;
  ohBARCODE:=TBarcodeHnd.Create;  ohBARCODE.Open;
end;

destructor TGsi.Destroy;
begin
  FreeAndNil(ohBARCODE);
  FreeAndNil(ohGSCAT);
end;

// ********************************* PRIVATE ***********************************


// ********************************** PUBLIC ***********************************

function TGsi.Locate(pCode:Str30):boolean;
var mGsCode:longint;
begin
  Result:=FALSE;
  If (pCode[1]='.') or (pCode[1]=',') then begin
    Delete(pCode,1,1);
    mGsCode:=ValInt(pCode);
    Result:=LocateGsCode(mGsCode);
  end else Result:=LocateBarCode(pCode);
end;

function TGsi.LocateGsCode(pGsCode:longint):boolean;
begin
  Result:=ohGSCAT.LocateGsCode(pGsCode);
end;

function TGsi.LocateSpcCode(pSpcCode:Str30):boolean;
begin
  Result:=ohGSCAT.LocateSpcCode(pSpcCode);
end;

function TGsi.LocateBarCode(pBarCode:Str15):boolean;
begin
  Result:=FALSE;
  If not ohGSCAT.LocateBarCode(pBarCode) then begin
    If ohBARCODE.LocateBarCode(pBarCode) then begin
      If ohGSCAT.LocateGsCode(ohBARCODE.GsCode) then Result:=TRUE;
    end;
  end
  else Result:=TRUE;
end;

function TGsi.NextGsCode:longint;
begin
  ohGSCAT.SwapIndex;
  ohGSCAT.SetIndex(ixGsCode);
  ohGSCAT.Last;
  Result:=ohGSCAT.GsCode+1;
  ohGSCAT.RestoreIndex;
end;

procedure TGsi.ImportRef;
var mTF:TextFile;
    mStr:String;
    mcut:TTxtCut;
    mFind:boolean;
    mGSCode:longint;
  procedure ImpData;
  begin
    ohGSCAT.GsCode  := mGSCode;
    ohGSCAT.GsName  := mCut.GetText ( 3);
    ohGSCAT.MgCode  := mCut.GetNum  ( 4);
    ohGSCAT.FgCode  := mCut.GetNum  ( 5);
    ohGSCAT.BarCode := mCut.GetText ( 6);
    ohGSCAT.StkCode := mCut.GetText ( 7);
    ohGSCAT.MsName  := mCut.GetText ( 8);
    ohGSCAT.PackGs  := mCut.GetNum  ( 9);
    ohGSCAT.GsType  := mCut.GetText (10);
    ohGSCAT.DrbMust := mCut.GetNum  (11)=1;
    ohGSCAT.PdnMust := mCut.GetNum  (12)=1;
    ohGSCAT.GrcMth  := mCut.GetNum  (13);
    ohGSCAT.VatPrc  := mCut.GetNum  (14);
    ohGSCAT.Volume  := mCut.GetReal (15);
    ohGSCAT.Weight  := mCut.GetReal (16);
    ohGSCAT.MsuQnt  := mCut.GetReal (17);
    ohGSCAT.MsuName := mCut.GetText (18);
    ohGSCAT.SbcCnt  := mCut.GetNum  (19);
    ohGSCAT.DisFlag := mCut.GetNum  (20)=1;
    ohGSCAT.LinPrice:= mCut.GetReal (21);
    ohGSCAT.LinDate := mCut.GetDate (22);
    ohGSCAT.LinStk  := mCut.GetNum  (23);
    ohGSCAT.LinPac  := mCut.GetNum  (24);
//    ohGSCAT.SecNum  := mCut.GetNum  (25);  RZ - nepouzivame
//    ohGSCAT.WgCode  := mCut.GetNum  (26);  RZ - nepouzivame
    ohGSCAT.BasGsc  := mCut.GetNum  (27);
    ohGSCAT.GscKfc  := mCut.GetNum  (28);
    ohGSCAT.GspKfc  := mCut.GetNum  (29);
    ohGSCAT.QliKfc  := mCut.GetReal (30);
    ohGSCAT.DrbDay  := mCut.GetNum  (31);
    ohGSCAT.OsdCode := mCut.GetText (32);
    ohGSCAT.MinOsq  := mCut.GetReal (33);
    ohGSCAT.SpcCode := mCut.GetText (34);
    ohGSCAT.PrdPac  := mCut.GetNum  (35);
    ohGSCAT.SupPac  := mCut.GetNum  (36);
    ohGSCAT.SpirGs  := mCut.GetNum  (37);
    ohGSCAT.GaName  := mCut.GetText (38);
    ohGSCAT.DivSet  := mCut.GetNum  (39);
  end;
begin
  // reffile
  if FileExists(pPath+'GSCAT.REF') then begin
    mcut:=TTxtCut.Create;
    AssignFile(mTF,pPath+'GSCAT.REF');Reset(mTF);
    while not Eof(mTF) do begin
      Readln(mTF,mStr);
      mcut.SetStr(mStr);
      If (mcut.GetText(1)='M') and
      (((pImpFld=0)and(mCut.Getnum(2)>0))or((pImpFld=1)and(mCut.GetText(5)<>''))or((pImpFld=2)and(mCut.GetText(34)<>'')))then begin
        case pImpFld of
          0: mFind:=ohGSCAT.LocateGsCode(mCut.Getnum(2));
          1: mFind:=ohGSCAT.LocateBarCode(mCut.GetText(5));
          2: mFind:=ohGSCAT.LocateSpcCode(mCut.GetText(34));
        end;
        If mFind and not pOnlyNew then begin
          mGSCode:=ohGSCAT.GsCode;
          ohGSCAT.Edit;
          ImpData;
          ohGSCAT.Post;
        end else If not mFind then begin
          If pImpFld >0
            then mGSCode:=ohGSCAT.NextGsCode
            else mGSCode:=mcut.GetNum(2);
          ohGSCAT.Insert;
          ImpData;
          ohGSCAT.Post;
        end;
      end;
    end;
    FreeAndNil(mcut);
    CloseFile(mTF);
  end;
end;

end.
