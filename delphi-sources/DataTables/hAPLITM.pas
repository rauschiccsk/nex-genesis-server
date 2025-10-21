unit hAPLITM;

interface

uses
  IcTypes, NexPath, NexGlob, bAPLITM,
  Forms, Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Dialogs;

type
  TAplitmHnd = class (TAplitmBtr)
  private
  public
  published
    procedure Del; // Vymze vsetky zaznamy
  end;

implementation

procedure TAplitmHnd.Del; // Vymze vsetky zaznamy
begin
  While Count<>0 do Delete;
end;

end.
