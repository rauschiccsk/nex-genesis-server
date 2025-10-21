unit hEml;

interface

uses
  IcTypes, IcVariab, NexPath, NexGlob, bEml,
  DocHand,
  Forms, Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Dialogs;


type
  TEmlHnd = class (TEmlBtr)
  private
  public
    function GetNextEODocnum:Str12;
    function GetNextEPDocnum:Str12;
  published
  end;

implementation

{ TEmlHnd }

function TEmlHnd.GetNextEODocnum: Str12;
begin
  If Count=0 then Result:=GenEoDocNum(gvSys.ActYear2,BtrTable.ListNum,1)
  else begin
    NearestEmlNum('EO');Last;
    while not BtrTable.Bof and (copy(EmlNum,1,2)='EP') do Prior;
    If (copy(EmlNum,1,2)='EP')
      then Result:=GenEoDocNum(gvSys.ActYear2,BtrTable.ListNum,1)
      else Result:=GenEoDocNum(gvSys.ActYear2,BtrTable.ListNum,StrToInt(copy(EmlNum,8,5))+1);
  end;
end;

function TEmlHnd.GetNextEPDocnum: Str12;
begin
  If Count=0 then Result:=GenEpDocNum(gvSys.ActYear2,BtrTable.ListNum,1)
  else begin
    NearestEmlNum('EP');Last;
    If (copy(EmlNum,1,2)<>'EP')
      then Result:=GenEpDocNum(gvSys.ActYear2,BtrTable.ListNum,1)
      else Result:=GenEpDocNum(gvSys.ActYear2,BtrTable.ListNum,StrToInt(copy(EmlNum,8,5))+1);
  end;
end;

end.
