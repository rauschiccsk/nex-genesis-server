unit AppFnc;

interface

uses
  IcTypes, IcConv, IcTools, IcFiles, IcVariab,
  BtrTable, NexBtrTable, Math, Classes, SysUtils;

  function DetBicCod(pIbaCod:Str30):Str10;

implementation


function DetBicCod(pIbaCod:Str30):Str10;
var mBanCod:Str4;
begin
  Result:='';
  If pIbaCod<>'' then begin
    If Pos(' ',pIbaCod)>0
      then mBanCod:=LineElement(pIbaCod,1,' ')
      else mBanCod:=copy(pIbaCod,5,4);
    Result:=gBankCodeSwift.Values[mBanCod];
  end;  
end;

end.


