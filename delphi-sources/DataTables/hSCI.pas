unit hSCI;

interface

uses
  IcTypes, IcVariab, NexPath, NexGlob, SavClc, bSCI,
  Forms, Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Dialogs;

type
  TSciHnd = class (TSciBtr)
  private
    procedure SetSav(pSav:TSavClc);
  public
    procedure SetFgBPrice (pFgBPrice,pDscPrc,pFgCourse:double); // Zadáme jednotkovú cenu a ostatné hodnoty vypoèíta
    procedure SetFgBValue (pFgBValue,pDscPrc,pFgCourse:double); // Zadáme konecnu cenu s DPH a ostatné hodnoty vypoèíta
    procedure Del(pDocNum:Str12);
    procedure Post; overload;
  published
  end;

implementation

procedure TSciHnd.SetSav(pSav:TSavClc);
begin     
  AcDValue := pSav.AcDValue;
  AcHValue := pSav.AcHValue;
  AcAValue := pSav.AcAValue;
  AcBValue := pSav.AcBValue;
  FgDPrice := pSav.FgDPrice;
  FgHPrice := pSav.FgHPrice;
  FgAPrice := pSav.FgAPrice;
  FgBPrice := pSav.FgBPrice;
  FgDValue := pSav.FgDValue;
  FgHValue := pSav.FgHValue;
  FgDscVal := pSav.FgDscVal;
  FgHscVal := pSav.FgHscVal;
  FgAValue := pSav.FgAValue;
  FgBValue := pSav.FgBValue;
end;

procedure TSciHnd.SetFgBPrice (pFgBPrice,pDscPrc,pFgCourse:double); // Zadáme jednotkovú cenu a ostatné hodnoty vypoèíta
var mSav:TSavClc;
begin
  mSav := TSavClc.Create;
  mSav.GsQnt := GsQnt;
  mSav.VatPrc := VatPrc;
  mSav.DscPrc := pDscPrc;
  mSav.FgCourse := pFgCourse;
  mSav.FgBPrice := pFgBPrice;
  SetSav(mSav);
  FreeAndNil (mSav);
end;

procedure TSciHnd.SetFgBValue (pFgBValue,pDscPrc,pFgCourse:double); // Zadáme jednotkovú cenu a ostatné hodnoty vypoèíta
var mSav:TSavClc;
begin
  mSav := TSavClc.Create;
  mSav.GsQnt := GsQnt;
  mSav.VatPrc := VatPrc;
  mSav.DscPrc := pDscPrc;
  mSav.FgCourse := pFgCourse;
  mSav.FgBValue := pFgBValue;
  SetSav(mSav);
  FreeAndNil (mSav);
end;

procedure TSciHnd.Del(pDocNum:Str12);
begin
  While LocateDocNum(pDocNum) do begin
    Delete;
    Application.ProcessMessages;
  end;
end;

procedure TSciHnd.Post;
begin
  If MgCode<gvSys.SecMgc
    then ItType := 'M'
    else ItType := 'S';
  inherited ;
end;


end.
