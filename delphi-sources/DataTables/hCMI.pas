unit hCMI;

interface

uses
  IcTypes, IcVariab, NexPath, NexGlob, bCMI,
  Forms, Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Dialogs;

type
  TCmiHnd = class (TCmiBtr)
  private
  public
    procedure Post; overload;
  published
  end;

implementation

procedure TCmiHnd.Post;
begin
  If MgCode<gvSys.SecMgc
    then ItmType := 'C'
    else ItmType := 'W';
  inherited ;
end;

end.
