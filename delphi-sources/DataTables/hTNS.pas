unit hTns;

interface

uses
  IcTypes, NexPath, NexGlob, bTns,
  Forms, Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Dialogs;


type
  TTnsHnd = class (TTnsBtr)
  private
  public
    function TnsGscCnt(pGsCode:longint;pTentNum,pRoomNum,pVisNum:longint;pDate:TDate):integer;
  published
  end;

implementation

{ TTnsHnd }

function TTnsHnd.TnsGscCnt(pGsCode, pTentNum, pRoomNum, pVisNum: Integer;
  pDate: TDate): integer;
begin
  SwapStatus;
  Result:=0;
  NearestTnRnVi(pTentNum,pRoomNum,pVisNum);
  while not EOF and ((TentNum=pTentNum)or(pTentNum=0)) and ((RoomNum=pRoomNum)or(pRoomNum=0))
                and ((VisNum=pVisNum)or(pVisNum=0)) do
  begin
    If (pGsCode=GsCode)and((pDate=0) or (Date=CasDate)) then Result:=Result+1;
    Next;
  end;
  RestoreStatus;
end;

end.
