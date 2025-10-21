unit hTOT;  

interface

uses
  IcTypes, NexPath, NexGlob, bTOT,
  Forms, Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Dialogs;

type
  TTotHnd = class (TTotBtr)
  private
  public
    function SumDlvQnt(pDocNum:Str12;pItmNum:word):double;
  published
  end;

implementation

function TTotHnd.SumDlvQnt(pDocNum:Str12;pItmNum:word):double;
begin
  Result := 0;
  If LocateDoIt(pDocNum,pItmNum) then begin
    Repeat
      Result := Result+DlvQnt;
      Next;
    until Eof or (DocNum<>pDocNum) or (ItmNum<>pItmNum);
  end;
end;

end.
