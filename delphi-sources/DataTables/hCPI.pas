unit hCPI;

interface

uses
  IcTypes, IcVariab, NexPath, NexGlob, bCPI,
  Forms, Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Dialogs;

type
  TCpiHnd = class (TCpiBtr)
  private
  public
    procedure Post; overload;
  published
  end;

implementation

procedure TCpiHnd.Post;
begin
  If MgCode<gvSys.SecMgc 
    then ItmType := 'C'
    else ItmType := 'W';
  inherited ;
end;

end.
