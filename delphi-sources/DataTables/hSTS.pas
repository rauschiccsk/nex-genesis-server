unit hSTS;

interface

uses
  IcTypes, NexPath, NexGlob, bSTS,
  Forms, Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Dialogs;


type
  TStsHnd = class (TStsBtr)
  private
  public
    function SalQntSum(pGsCode:longint):double;
  published
  end;

implementation

function TStsHnd.SalQntSum(pGsCode:longint):double;
begin
  Result := 0;
  If LocateGsCode(pGsCode) then begin
    Repeat
      Result := Result+SalQnt;
      Next;
    until Eof or (GsCode<>pGsCode);
  end;
end;

end.
