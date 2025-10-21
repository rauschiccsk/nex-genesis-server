unit hPASUBC;

interface

uses
  IcTypes, NexPath, NexGlob, bPASUBC,
  Forms, Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Dialogs;

type
  TPasubcHnd=class(TPasubcBtr)
  private
  public
    function NextWpCode(pPaCode:longint):word;
  published
  end;

implementation

function TPasubcHnd.NextWpCode(pPaCode:longint):word;
begin
  Result:=0;
  SwapIndex;
  If LocatepaCode(pPaCode) then begin
    Repeat
      If Result<WpaCode then Result:=WpaCode;
      Application.ProcessMessages;
      Next;
    until Eof or (PaCode<>pPaCode);
    Result:=Result+1;
  end else Result:=1;
  RestoreIndex;
end;

end.
