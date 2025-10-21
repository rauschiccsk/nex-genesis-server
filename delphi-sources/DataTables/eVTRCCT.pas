unit eVTRCCT;

interface

uses
  IcTypes, IcConv, IcTools, NexClc, dVTRCCT,
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Dialogs;

type
  TVtrcctHne=class(TVtrcctDat)
  private
  public
    procedure Post; overload;
  published
  end;

implementation

// *************************************** PRIVATE ********************************************

// **************************************** PUBLIC ********************************************

procedure TVtrcctHne.Post;
begin

  inherited ;
end;

end.
