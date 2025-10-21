unit hMCN;

interface

uses
  IcTypes, NexPath, NexGlob, bMCN,
  Forms, Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Dialogs;

type
  TMcnHnd = class (TMcnBtr)
  private
  public
    procedure Del(pDocNum:Str12);
  published
  end;

implementation

{ TMcnHnd }

procedure TMcnHnd.Del(pDocNum: Str12);
begin
  while LocateDocNum(pDocNum) do Delete;
end;

end.
