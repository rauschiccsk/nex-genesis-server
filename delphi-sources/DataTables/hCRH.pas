unit hCRH;                      

interface

uses
  IcTypes, NexPath, NexGlob, bCRH,
  Forms, Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Dialogs;


type
  TCrhHnd = class (TCrhBtr)
  private
  public
    function NextSerNum(pYear:Str2):longint; // Najde nasledujuce volne cislo dokladu
  published
  end;

implementation

function TCrhHnd.NextSerNum; // Najde nasledujuce volne cislo dokladu
begin
  Result := GetDocNextYearSerNum(Btrtable,pYear);
end;

end.
{MOD 1901005}
