unit hEmlren;

interface

uses
  IcConv, IcTypes, IcVariab, NexPath, NexGlob, bEmlren,
  Dochand,
  Forms, Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Dialogs;


type
  TEmlrenHnd = class (TEmlrenBtr)
  private
  public
    function GetNextDocnum(pYear:Str2;pCntNum:longint):Str12;
  published
  end;

implementation

{ TEmlrenHnd }

function TEmlrenHnd.GetNextDocnum(pYear: Str2; pCntNum: Integer): Str12;
var mI:longint;mCnt:Str3;
begin
  If Count=0 then Result:=GenEpDocNum(gvSys.ActYear2,pCntNum,1)
  else begin
    mCnt:=StrIntZero(pCntNum,3);
    NearestEmlNum('EP'+pYear+mCnt+'00001');mI:=1;
    while Not Eof and (Copy(EmlNum,5,3)=mCnt) do begin
      mI:=ValInt(Copy(EmlNum,8,5))+1;
      Next;
    end;
    Result:=GenEpDocNum(gvSys.ActYear2,pCntNum,mI);
  end;
end;

end.
