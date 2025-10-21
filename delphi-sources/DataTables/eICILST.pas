unit eICILST;

interface

uses
  IcTypes, IcConv, IcTools, NexClc, dICILST,
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Dialogs;

type
  TIcilstHne=class(TIcilstDat)
  private
  public
    procedure Post; overload;
  published
  end;

implementation

// *************************************** PRIVATE ********************************************

// **************************************** PUBLIC ********************************************

procedure TIcilstHne.Post;
begin

  inherited ;
end;

end.
