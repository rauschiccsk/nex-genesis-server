unit eOSHLST;

interface

uses
  IcTypes, IcConv, dOSHLST,
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Dialogs;

type
  TOshlstHne=class(TOshlstDat)
  private
  public
    procedure Post; overload;
  published
  end;

implementation

// *************************************** PRIVATE ********************************************

// **************************************** PUBLIC ********************************************

procedure TOshlstHne.Post;
begin
  inherited ;
end;

end.
