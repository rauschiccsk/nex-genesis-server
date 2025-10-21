unit Txt;

interface

uses
  IcTypes, IcVariab, IcConv, NexVar, NexMsg, NexError, LinLst, hSYSTXT,
  IniFiles, Classes, SysUtils;

type
  TTxt=class
    constructor Create;
    destructor  Destroy; override;
  private
    ohSYSTXT:TSystxtHnd;
  public
    function GetTxt(pKeyVal:Str20;pTxtVal:ShortString):ShortString;
  end;

function SysTxt(pKeyVal:Str20;pTxtVal:ShortString):ShortString;

var gTxt:TTxt;

implementation

function SysTxt(pKeyVal:Str20;pTxtVal:ShortString):ShortString;
begin
  If gTxt=nil then gTxt:=TTxt.Create;
  Result:=gTxt.GetTxt(pKeyVal,pTxtVal);
end;

constructor TTxt.Create;
begin
  ohSYSTXT:=TSystxtHnd.Create;   ohSYSTXT.Open;
end;

destructor TTxt.Destroy;
begin
  FreeAndNil (ohSYSTXT);
end;

// *********************************** PRIVATE *********************************

// *********************************** PUBLIC **********************************

function TTxt.GetTxt(pKeyVal:Str20;pTxtVal:ShortString):ShortString;
begin
  Result:='';
  If not ohSYSTXT.LocateKeyVal(UpString(pKeyVal)) then begin
    ohSYSTXT.Insert;
    ohSYSTXT.KeyVal:=pKeyVal;
    ohSYSTXT.TxtVal:=pTxtVal;
    ohSYSTXT.Post;
    Result:=pTxtVal;
  end else Result:=ohSYSTXT.TxtVal;
end;

end.

{MOD 1915001}
