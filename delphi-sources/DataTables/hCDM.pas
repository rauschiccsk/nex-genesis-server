unit hCDM;

interface  

uses
  IcTypes, IcVariab, NexPath, NexGlob, bCDM,
  Forms, Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Dialogs;

type
  TCdmHnd = class (TCdmBtr)
  private
  public
    procedure Post; overload;
  published
  end;

implementation

procedure TCdmHnd.Post;
begin
  If MgCode<gvSys.SecMgc
    then ItmType := 'C'
    else ItmType := 'W';
  inherited ;
end;

end.
