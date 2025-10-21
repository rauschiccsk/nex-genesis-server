unit hIvi;

interface

uses
  IcTypes, NexPath, NexGlob, bIVI,
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Dialogs;


type
  TIviHnd=class (TIviBtr)
  private
  public
    function NextItmNum(pIvlNum:integer):word;
  published
  end;

implementation


{ TIviHnd }

function TIviHnd.NextItmNum(pIvlNum: integer): word;
begin
  If not NearestIlIt(pIvlNum,65000) then Last;
  If not IsLastRec or (IvlNum<>pIvlNum) then Prior;
  If IvlNum=pIvlNum
    then Result := ItmNum+1
    else Result := 1;
end;

end.
