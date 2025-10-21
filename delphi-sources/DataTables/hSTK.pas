unit hSTK;

interface

uses
  IcTypes, IcConv, NexPath, NexGlob, bSTK,
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Dialogs;

type
  TStkHnd=class(TStkBtr)
  private
  public
    function StkNum:word;
    procedure Post; overload;
  published
  end;

implementation

// *************************************** PRIVATE ********************************************

// **************************************** PUBLIC ********************************************

function TStkHnd.StkNum:word;
begin
  Result:=ValInt(Btrtable.BookNum);
end;

procedure TStkHnd.Post;
begin
  ActQnt:=BegQnt+InQnt-OutQnt;
  ActVal:=BegVal+InVal-OutVal;
  FreQnt:=ActQnt-OcdQnt-SalQnt-ImrQnt;
  FroQnt:=OsdQnt-OsrQnt;
  If (FreQnt<0) then FreQnt:=0;
  If (ActQnt>0)
    then AvgPrice:=ActVal/ActQnt
    else AvgPrice:=LastPrice;
  If (MaxQnt>0) and (FreQnt>MaxQnt) then MinMax:='X';
  If (MinQnt>0) and (FreQnt<=MinQnt) then MinMax:='N';
  inherited ;
end;

end.
