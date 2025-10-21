unit hColitm;

interface

uses 
  IcTypes, NexPath, NexGlob, bColitm,
  Forms, Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Dialogs;


type
  TColitmHnd = class (TColitmBtr)
  private
  public
    function NextColNum:word;
  published
  end;

implementation

{ TColitmHnd }

function TColitmHnd.NextColNum: word;
begin
  SwapIndex;
  NearestColNum (0);
  Last;
  Result := ColNum+1;
  RestoreIndex;
end;

end.
