unit hCPH;

interface

uses
  IcTypes, IcTools, IcVariab, NexPath, NexGlob, Key, Plc, bCPH, hCPI,
  Forms, Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Dialogs;

type
  TCphHnd = class (TCphBtr)
  private
  public
    procedure Clc(phCPI:TCpiHnd);
  published
  end;

implementation

uses bCPI;

procedure TCphHnd.Clc(phCPI:TCpiHnd);
var mItmQnt:longint;  mCpiVal,mCpsVal,mBPrice:double;
begin
  mItmQnt := 0;  mCpiVal := 0;  mCpsVal := 0;  mBPrice := 0;
  phCPI.SwapIndex;
  If phCPI.LocatePdCode(PdCode) then begin
    Repeat
      Inc (mItmQnt);
      If phCPI.MgCode<gvSys.SecMgc
        then mCpiVal := mCpiVal+phCPI.CValue
        else mCpsVal := mCpsVal+phCPI.CValue;
      mBPrice := mBPrice+phCPI.BPrice*phCPI.CpGsQnt;
      phCPI.Next;
    until (phCPI.Eof) or (phCPI.PdCode<>PdCode);
  end;
  phCPI.RestoreIndex;
  // Ulozime vypocitane hodnoty do hlavicky dokladu
  Edit;
  CpiVal := mCpiVal;
  CpsVal := mCpsVal;
  CValue := mCpiVal+mCpsVal;
  CPrice := RdX(CValue/PdGsQnt,gKey.StpRndFrc);
  BPrice := mBPrice;
  APrice := gPlc.ClcAPrice(VatPrc,BPrice);
  AValue := APrice*PdGsQnt;
  PrfPrc := gPlc.ClcPrfPrc(CValue,AValue);
  ItmQnt := mItmQnt;
  Post;
end;

end.
