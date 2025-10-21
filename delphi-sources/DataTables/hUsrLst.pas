unit hUSRLST;

interface

uses
  IcTypes, NexPath, NexGlob, bUSRLST,
  Forms, Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Dialogs;

type
  TUsrlstHnd = class (TUsrlstBtr)
  private
  public
  published
  end;

function GetLoginNameGroup(pLogName:Str8; pUsrLst:TUSrLstHnd; pCheck:boolean):word;

implementation

function GetLoginNameGroup;
begin
  Result:=0;
  If pUsrLst<>NIL then begin
    If not pUsrLst.Active then pUsrLst.Open;
    If (pUsrLst.LoginName=pLogName) or pUsrLst.LocateLoginName(pLogName) then Result:=pUsrLst.GrpNum;
  end;
end;

end.
