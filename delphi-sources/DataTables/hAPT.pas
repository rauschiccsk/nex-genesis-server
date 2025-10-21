unit hAPT;

interface

uses
  IcTypes, NexPath, NexGlob, bAPT,
  Forms, Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Dialogs;

type
  TAptHnd = class (TAptBtr)
  private
  public
    procedure Del(pDocNum:Str12;pTxtTyp:Str12);
  published
  end;

implementation

procedure TAptHnd.Del(pDocNum:Str12;pTxtTyp:Str12);
begin
  If LocateDnTt(pDocNum,pTxtTyp) then begin
    Repeat
      Delete;
    until Eof or (pDocNum<>DocNum) or (pTxtTyp<>TxtTyp);
  end;
end;

end.
