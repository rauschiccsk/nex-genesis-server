unit hPRH;

interface      

uses
  IcTypes, NexPath, NexGlob, bPRH,
  Forms, Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Dialogs;

type
  TPrhHnd = class (TPrhBtr)
  private
  public
    function NextSerNum(pYear:Str2):longint; // Najde nasledujuce volne cislo dokladu
  published
  end;

implementation

function TPrhHnd.NextSerNum; // Najde nasledujuce volne cislo dokladu
begin
  Result := GetDocNextYearSerNum(Btrtable,pYear);
end;

end.
{MOD 1809006}
