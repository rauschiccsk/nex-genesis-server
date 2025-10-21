unit hCRDLST;

interface

uses
  IcTypes, IcTools, NexPath, NexGlob, Key, bCRDLST, hCRDMOV,
  Forms, Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Dialogs;

type
  TCrdlstHnd=class (TCrdlstBtr)
  private
  public
    procedure Post; override;
  published
  end;

implementation

procedure TCrdlstHnd.Post;
var mBonQnt:integer;
begin
  If CrdType<>'D' then begin
    NouVal:=BegVal+DocVal-BonVal;
    NebVal:=BonTrn-NouVal;
    ActBon:=BegBon+InpBon-OutBon;
  end;
  inherited;
end;

end.
