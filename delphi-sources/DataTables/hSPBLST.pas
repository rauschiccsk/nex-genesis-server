unit hSPBLST;

interface

uses
  IcTypes, NexPath, NexGlob, IcValue, bSPBLST, hSPD, bSPD,
  Forms, Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Dialogs;

type
  TSpblstHnd=class(TSpblstBtr)
  private
  public
    procedure Clc(pPaCode:longint);
  published
  end;

implementation

procedure TSpblstHnd.Clc(pPaCode:longint);
var mhSPD:TSpdHnd;  mIncVal,mPrfVal:TValue8;
begin
  mIncVal:=TValue8.Create;
  mPrfVal:=TValue8.Create;
  mIncVal.VatPrc[1]:=VatPrc1;   mPrfVal.VatPrc[1]:=VatPrc1;
  mIncVal.VatPrc[2]:=VatPrc2;   mPrfVal.VatPrc[2]:=VatPrc2;
  mIncVal.VatPrc[3]:=VatPrc3;   mPrfVal.VatPrc[3]:=VatPrc3;
  mIncVal.VatPrc[4]:=VatPrc4;   mPrfVal.VatPrc[4]:=VatPrc4;
  mIncVal.VatPrc[5]:=VatPrc5;   mPrfVal.VatPrc[5]:=VatPrc5;
  mIncVal.VatPrc[6]:=VatPrc6;   mPrfVal.VatPrc[6]:=VatPrc6;
  mhSPD:=TSpdHnd.Create;  mhSPD.Open(pPaCode);
  mhSPD.SetIndex(ixSerNum);
  mhSPD.First;
  Repeat
    mIncVal.Add(mhSPD.VatPrc1,mhSPD.DocVal1);
    mIncVal.Add(mhSPD.VatPrc2,mhSPD.DocVal2);
    mIncVal.Add(mhSPD.VatPrc3,mhSPD.DocVal3);
    mPrfVal.Add(mhSPD.VatPrc1,mhSPD.PrfVal1);
    mPrfVal.Add(mhSPD.VatPrc2,mhSPD.PrfVal2);
    mPrfVal.Add(mhSPD.VatPrc3,mhSPD.PrfVal3);
    Application.ProcessMessages;
    mhSPD.Next;
  until mhSPD.Eof;
  Edit;
  IncVal1:=mIncVal.Value[1];
  IncVal2:=mIncVal.Value[2];
  IncVal3:=mIncVal.Value[3];
  IncVal4:=mIncVal.Value[4];
  IncVal5:=mIncVal.Value[5];
  IncVal6:=mIncVal.Value[6];
  PrfVal1:=mPrfVal.Value[1];
  PrfVal2:=mPrfVal.Value[2];
  PrfVal3:=mPrfVal.Value[3];
  PrfVal4:=mPrfVal.Value[4];
  PrfVal5:=mPrfVal.Value[5];
  PrfVal6:=mPrfVal.Value[6];
  IncVal:=IncVal1+IncVal2+IncVal3+IncVal4+IncVal5+IncVal6;
  PrfVal:=PrfVal1+PrfVal2+PrfVal3+PrfVal4+PrfVal5+PrfVal6;
  EndVal:=IncVal-ExpVal;
  Post;
  FreeAndNil(mhSPD);
  FreeAndNil(mIncVal);
  FreeAndNil(mPrfVal);
end;

end.
