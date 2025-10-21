unit hCRDMOV;

interface

uses
  IcTypes, IcTools, NexPath, NexGlob, bCRDMOV,
  Forms, Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Dialogs;


type
  TCrdmovHnd=class (TCrdmovBtr)
  private
    function GetBonVal:double;
    function GetNouVal:double;
    function GetNebVal:double;
  public
  published
    property BonVal:double read GetBonVal;
    property NouVal:double read GetNouVal;
    property NebVal:double read GetNebVal;
  end;

implementation

function TCrdmovHnd.GetBonVal:double;
begin
  Result:=0;
  If BonQnt>0 then Result:=BonTrn*BonQnt;
end;

function TCrdmovHnd.GetNouVal:double;
begin
  Result:=BegVal+DocVal-BonVal;
end;

function TCrdmovHnd.GetNebVal:double;
begin
  Result:=BonTrn-NouVal;
end;

end.
{MOD 1920001}
