unit hPQI;

interface

uses
  IcTypes, NexPath, NexGlob, bPQI,
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Dialogs;

type
  TPqiHnd = class (TPqiBtr)
  private
  public
    function LastitmNum (pDocNum:Str12):word;
  published
  end;

implementation

// *************************************** PRIVATE ********************************************

// **************************************** PUBLIC ********************************************

function TPqiHnd.LastitmNum (pDocNum:Str12):word;
begin
  Result := 0;
  SwapStatus;
  SetIndex (ixDoIt);
  If LocateDocNum (pDocNum) then begin
    Repeat
      If ItmNum>Result then Result := ItmNum;
      Next;
    until Eof or (DocNum<>pDocNum)
  end;
  RestoreStatus;
end;

end.
