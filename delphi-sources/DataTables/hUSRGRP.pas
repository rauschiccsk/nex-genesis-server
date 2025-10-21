unit hUsrgrp;

interface

uses
  IcTypes, IcVariab, NexPath, NexGlob, bUsrgrp,
  Forms, Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Dialogs;


type
  TUsrgrpHnd = class (TUsrgrpBtr)
  private
  public
    procedure InsAdmin;
  published
  end;

implementation

{ TUsrgrpHnd }

procedure TUsrgrpHnd.InsAdmin;
begin
  Insert;
  GrpNum   := 0;
  GrpName  := 'Administrator';
  Language := gvSys.Language;
  GrpLev   := 0;
  MaxDsc   := 0;
  MinPrf   := 0;
  DefSet1  := 65535;
  DefSet2  := 65535;
  DefSet3  := 65535;
  DefSet4  := 255;
  Post;
end;

end.
