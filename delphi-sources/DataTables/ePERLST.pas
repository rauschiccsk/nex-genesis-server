unit ePERLST;

interface

uses
  IcTypes, IcConv, Cnt, dPERLST,
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Dialogs;

type
  TPerlstHne=class(TPerlstDat)
  private
  public
    procedure Post; overload;
  published
  end;

implementation

// *************************************** PRIVATE ********************************************

// **************************************** PUBLIC ********************************************

procedure TPerlstHne.Post;
begin
  If PerNum=0 then PerNum:=gCnt.NewDocSer('','PE','');
  If UsrLng='' then UsrLng:='SK';
  If UsrLog<>'' then UsrSta:='X';
  inherited ;
end;

end.
