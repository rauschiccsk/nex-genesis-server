unit hSPM;

interface

uses
  IcTypes, IcVariab, NexPath, NexGlob, bSPM,
  Forms, Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Dialogs;

type
  TSpmHnd=class (TSpmBtr)
  private
  public
    procedure Add(pPoCode:Str15;pGsCode:longint;pMovQnt:double);
  published
  end;

implementation

procedure TSpmHnd.Add(pPoCode:Str15;pGsCode:longint;pMovQnt:double);
begin
  Insert;
  PoCode:=pPoCode;
  GsCode:=pGsCode;
  MovQnt:=pMovQnt;
  MovUsr:=gvSys.LoginName;
  MovDat:=Date;
  MovTim:=Time;
  Post;
end;

end.
