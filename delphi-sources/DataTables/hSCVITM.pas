unit hSCVITM;

interface

uses
  IcTypes, NexPath, NexGlob, SavClc, bSCVITM,
  Forms, Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Dialogs;

type
  TScvitmHnd = class (TScvitmBtr)
  private
  public
    procedure SetBValue(pBValue,pDscPrc:double); // Zad�me konecnu cenu s DPH a ostatn� hodnoty vypo��ta
  published
  end;

implementation

procedure TScvitmHnd.SetBValue(pBValue,pDscPrc:double); // Zad�me jednotkov� cenu a ostatn� hodnoty vypo��ta
var mSav:TSavClc;
begin
  mSav:=TSavClc.Create;
  mSav.GsQnt:=GsQnt;
  mSav.VatPrc:=VatPrc;
  mSav.DscPrc:=pDscPrc;
  mSav.FgCourse:=1;
  mSav.FgBValue:=pBValue;
  DValue:=mSav.AcDValue;
  HValue:=mSav.AcHValue;
  AValue:=mSav.AcAValue;
  BValue:=mSav.AcBValue;
  FreeAndNil (mSav);
end;

end.
{MOD 1916001}
