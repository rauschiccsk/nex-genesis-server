unit eBWDITM;

interface

uses
  IcTypes, IcConv, dBWDITM,
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Dialogs;

type
  TBwditmHne=class(TBwditmDat)
  private
  public
    procedure Post; overload;
  published
  end;

implementation

// *************************************** PRIVATE ********************************************

// **************************************** PUBLIC ********************************************

procedure TBwditmHne.Post;
begin
  If ExpDte<>0 then DayQnt:=Trunc(ExpDte)-Trunc(BegDte);
  If RetDte<>0 then DayQnt:=Trunc(RetDte)-Trunc(BegDte);
  BrwBva:=BrwBpc*DayQnt;
  inherited ;
end;

end.
