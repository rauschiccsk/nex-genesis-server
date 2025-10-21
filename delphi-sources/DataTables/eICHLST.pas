unit eICHLST;

interface

uses
  IcTypes, IcConv, IcTools, dICHLST,
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Dialogs;

type
  TIchlstHne=class(TIchlstDat)
  private
  public
    procedure Post; overload;
  published
  end;

implementation

// *************************************** PRIVATE ********************************************

// **************************************** PUBLIC ********************************************

procedure TIchlstHne.Post;
begin

  inherited ;
end;

end.
