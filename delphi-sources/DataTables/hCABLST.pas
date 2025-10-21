unit hCABLST;

interface

uses
  IcTypes, NexPath, NexGlob, bCABLST,
  Forms, Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Dialogs;

type
  TCablstHnd = class (TCablstBtr)
  private
  public
    procedure Del; // Vymze vsetky zaznamy
  published
  end;

implementation

procedure TCablstHnd.Del; // Vymze vsetky zaznamy
begin
  While Count<>0 do Delete;
end;

end.
