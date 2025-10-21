unit hOST;

interface

uses
  IcTypes, NexPath, NexGlob, bOST,
  Forms, Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Dialogs;

type
  TOstHnd = class (TOstBtr)
  private
  public
    procedure Del(pDocNum:Str12);
  published
  end;

implementation

procedure TOstHnd.Del(pDocNum:Str12);
begin
(*
  While LocateDocNum(pDocNum) do begin
    Delete;
    Application.ProcessMessages;
  end;
*)
end;

end.
