unit hSCVDOC;

interface

uses
  IcTypes, IcVariab, IcConv, NexPath, NexGlob, bSCVDOC,
  Forms, Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Dialogs;

type
  TScvdocHnd=class(TScvdocBtr)
  private
  public
    function NextSerNum(pYear:Str2):longint; // Sasledujúce volne poradové èíslo dokladu
    function GenDocNum(pYear:Str2;pSerNum:longint):Str12; // Interné èíslo servisnej zákazky
  published
  end;

implementation

function TScvdocHnd.NextSerNum;
var mFilter:ShortString;
begin
  If BtrTable.Filtered then begin
    BtrTable.DisableControls;
    mFilter:=BtrTable.Filter;
    BtrTable.Filtered:=FALSE;
    Result:=GetDocNextYearSerNum(BtrTable,pYear);
    BtrTable.Filter:=mFilter;
    BtrTable.Filtered:=TRUE;
    BtrTable.EnableControls;
  end else Result:=GetDocNextYearSerNum(BtrTable,pYear);
end;

function TScvdocHnd.GenDocNum(pYear:Str2;pSerNum:longint):Str12; 
begin
  If pYear='' then pYear:=gvSys.ActYear2;
  Result:='SO'+pYear+'000'+StrIntZero(pSerNum,5);
end;

end.
{MOD 1916001}
