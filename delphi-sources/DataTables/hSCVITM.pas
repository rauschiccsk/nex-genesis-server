unit hSCVITM;

interface

uses
  IcTypes, NexPath, NexGlob, SavClc, bSCVITM,
  Forms, Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Dialogs;

type
  TScvitmHnd = class (TScvitmBtr)
  private
  public
    procedure SetBValue(pBValue,pDscPrc:double); // Zadáme konecnu cenu s DPH a ostatné hodnoty vypoèíta
  published
  end;

implementation

procedure TScvitmHnd.SetBValue(pBValue,pDscPrc:double); // Zadáme jednotkovú cenu a ostatné hodnoty vypoèíta
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
