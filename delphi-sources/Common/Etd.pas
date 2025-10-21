unit Etd;
{$F+}
// *****************************************************************************
// Ovladac textoveho suboru, ktory skuzi na prenos dodavatelskych
// faktur medzi roznymi firmami.
// *****************************************************************************

interface

uses
  IcVariab, IcTypes, IcConv, IcTools, NexGlob, NexMsg, NexPath, NexError, NexIni,
  TxtWrap, TxtCut, TxtDoc, Key, Gsi, PlsFnc, Doc, hPAB, tEDH, tEDI,
  SysUtils, Forms, IcProgressBar, NexPxTable;

type
  TEtd = class
    constructor Create;
    destructor  Destroy; override;
    private
      oGsi:TGsi;
      oPls:TPlsFnc;
      ohPAB:TPabHnd;
    public
      otEDH:TEdhTmp;
      otEDI:TEdiTmp;
      procedure LoadDoc(pFileName:ShortString);
      procedure NewGsc; // Ak doklad obsahuje novu polozku zaeviduje do bazovej evidencii
    published
  end;

implementation

constructor TEtd.Create;
begin
  oGsi:=TGsi.Create;
  oPls:=TPlsFnc.Create;
  ohPAB:=TPabHnd.Create;  ohPAB.Open(0);
  otEDH:=TEdhTmp.Create;  otEDH.Open;
  otEDI:=TEdiTmp.Create;  otEDI.Open;
end;

destructor TEtd.Destroy;
begin
  FreeAndNil(otEDI);
  FreeAndNil(otEDH);
  FreeAndNil(ohPAB);
  FreeAndNil(oPls);
  FreeAndNil(oGsi);
end;

// ********************************* PUBLIC ************************************

procedure TEtd.LoadDoc(pFileName:ShortString);
var mTxtDoc:TTxtDoc;   mFind:boolean;
begin
  mTxtDoc:=TTxtDoc.Create;
  mTxtDoc.LoadFromFile (pFileName);
  // Nacitanie hlavicky elektronickej faktury
  ClrTbl(otEDH.TmpTable);
  mFind:=ohPAB.LocateRegIno(mTxtDoc.ReadString('RegIno'));
  otEDH.Insert;
  otEDH.ExtNum:=mTxtDoc.ReadString('ExtNum');
  otEDH.DocDate:=mTxtDoc.ReadDate ('DocDate');
  otEDH.ExpDate:=mTxtDoc.ReadDate ('ExpDate');
  otEDH.TaxDate:=mTxtDoc.ReadDate ('TaxDate');
  otEDH.RegIno:=mTxtDoc.ReadString('RegIno');
  otEDH.RegTin:=mTxtDoc.ReadString('RegTin');
  otEDH.RegVin:=mTxtDoc.ReadString('RegVin');
  otEDH.RegName:=mTxtDoc.ReadString('RegName');
  otEDH.RegCtn:=mTxtDoc.ReadString('RegCtn');
  otEDH.RegZip:=mTxtDoc.ReadString('RegZip');
  otEDH.ContoNum:=mTxtDoc.ReadString('ContoNum');
  otEDH.FgDvzName:=mTxtDoc.ReadString('FgDvzName');
  otEDH.FgDValue:=mTxtDoc.ReadFloat('FgDValue');
  otEDH.FgDscVal:=mTxtDoc.ReadFloat('FgDscVal');
  otEDH.FgAValue:=mTxtDoc.ReadFloat('FgAValue');
  otEDH.FgBValue:=mTxtDoc.ReadFloat('FgBValue');
  otEDH.ItmQnt:=mTxtDoc.ReadInteger('ItmQnt');
  If mFind then BTR_To_PX(ohPAB.BtrTable,otEDH.TmpTable);
  otEDH.Post;
  // Nacitanie poloziek elektronickej faktury
  ClrTbl(otEDI.TmpTable);
  mTxtDoc.First;
  Repeat
    If gKey.SysEdiSpc
      then mFind:=oGsi.LocateSpcCode(mTxtDoc.ReadString('SpcCode'))
      else mFind:=oGsi.LocateBarCode(mTxtDoc.ReadString('BarCode'));
    otEDI.Insert;
    otEDI.ItmNum:=otEDI.Count+1;
    otEDI.BarCode:=mTxtDoc.ReadString('BarCode');
    otEDI.SpcCode:=mTxtDoc.ReadString('SpcCode');
    otEDI.OsdCode:=mTxtDoc.ReadString('OsdCode');
    otEDI.GsName:=mTxtDoc.ReadString('GsName');
    otEDI.GaName:=mTxtDoc.ReadString('GaName');
    otEDI.VatPrc:=mTxtDoc.ReadInteger('VatPrc');
    otEDI.MsName:=mTxtDoc.ReadString('MsName');
    otEDI.GsQnt:=mTxtDoc.ReadFloat('GsQnt');
    otEDI.DscPrc:=mTxtDoc.ReadFloat('DscPrc');
    otEDI.FgDValue:=mTxtDoc.ReadFloat('FgDValue');
    otEDI.FgDscVal:=mTxtDoc.ReadFloat('FgDscVal');
    otEDI.FgAValue:=mTxtDoc.ReadFloat('FgAValue');
    otEDI.FgBValue:=mTxtDoc.ReadFloat('FgBValue');
    otEDI.EuBPrice:=mTxtDoc.ReadFloat('EuBPrice');
    otEDI.MgCode:=mTxtDoc.ReadInteger('MgCode');
    If mFind then BTR_To_PX(oGsi.ohGSCAT.BtrTable,otEDI.TmpTable);
    otEDI.Post;
    mTxtDoc.Next;
  until mTxtDoc.Eof;
  FreeAndNil (mTxtDoc);
end;

procedure TEtd.NewGsc; // Ak doklad obsahuje novu polozku zaeviduje do bazovej evidencii
var mGsCode:longint;  mPlsNum:word;
begin
  If otEDI.Count>0 then begin
    mPlsNum:=gIni.MainPls;
    otEDI.First;
    Repeat
      If otEDI.GsCode=0 then begin
        mGsCode:=oGsi.NextGsCode;
        // Zalozime novu tovarovu kartu
        oGsi.ohGSCAT.Insert;
        oGsi.ohGSCAT.GsCode:=mGsCode;
        oGsi.ohGSCAT.GsName:=otEDI.GsName;
        oGsi.ohGSCAT.GaName:=otEDI.GaName;
        oGsi.ohGSCAT.MgCode:=otEDI.MgCode;
        oGsi.ohGSCAT.MsName:=otEDI.MsName;
        oGsi.ohGSCAT.BarCode:=otEDI.BarCode;
        oGsi.ohGSCAT.SpcCode:=otEDI.SpcCode;
        oGsi.ohGSCAT.OsdCode:=otEDI.OsdCode;
        oGsi.ohGSCAT.VatPrc:=otEDI.VatPrc;
        oGsi.ohGSCAT.Post;
        // Ulozime PLU novej karty do zoznamu polozkiek elektronickeho dokladu
        otEDI.Edit;
        otEDI.GsCode:=mGsCode;
        otEDI.Post;
      end;
      // Ak tovar ma inu predajnu cenu zmenime ak nie je v cenniku pridame
      If gKey.SysEdiPce then begin
        oPls.SrcPmd:='EDI';
        oPls.BPrice:=otEDI.EuBPrice;
        oPls.Add(mPlsNum,otEDI.GsCode);
      end;
      Application.ProcessMessages;
      otEDI.Next;
    until otEDI.Eof;
  end;
end;

// ********************************* PRIVATE ***********************************

end.
