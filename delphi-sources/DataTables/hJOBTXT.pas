unit hJOBTXT;

interface

uses
  IcTypes, NexPath, NexGlob, bJOBTXT,
  Forms, Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Dialogs;

type
  TJobtxtHnd = class (TJobtxtBtr)
  private
  public
    procedure Del(pDocNum:Str12;pItmNum:word;pTxtTyp:Str12);
  published
  end;

implementation

procedure TJobtxtHnd.Del(pDocNum:Str12;pItmNum:word;pTxtTyp:Str12);
begin
  If LocateDnInTt(pDocNum,pItmNum,pTxtTyp) then begin
    Repeat
      Delete;
    until Eof or (pDocNum<>DocNum) or (pItmNum<>ItmNum) or (pTxtTyp<>TxtTyp);
  end;
end;

end.
