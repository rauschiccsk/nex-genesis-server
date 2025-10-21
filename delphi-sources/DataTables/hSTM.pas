unit hSTM;

interface

uses
  IcTypes, NexPath, NexGlob, bSTM,
  Forms, Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Dialogs;

type
  TStmHnd = class (TStmBtr)
  private
  public
    function NextStmNum:longint;
  published
  end;

implementation

function TStmHnd.NextStmNum:longint;
begin
  SwapIndex;
  SetIndex (ixStmNum);
  Last;
  Result := StmNum+1;
  RestoreIndex;
end;

end.
