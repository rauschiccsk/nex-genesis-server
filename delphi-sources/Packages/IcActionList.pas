unit IcActionList;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  ComCtrls,ActnList;

type
  TIcActionList = class(TActionList)
  private
  public
    procedure DisableActions;  // Nastavi parameter Enabled kazdej akcie na FALSE okrem stlacenej
    procedure EnableActions;   // Nastavi parameter Enabled kazdej akcie na TRUE okrem stlacenej
    procedure DisableAction(pActionName:string);  // Nastavi parameter Enabled zadanej akcie na FALSE
    procedure EnableAction(pActionName:string);   // Nastavi parameter Enabled zadane akcie na TRUE
  published
  end;

procedure Register;

implementation

procedure TIcActionList.DisableActions;
var mCnt:word;
begin
  If ActionCount>0 then begin
    mCnt := 0;
    Repeat
      (Actions[mCnt] as TAction).Enabled := FALSE;
      Inc (mCnt)
    until  mCnt=ActionCount;
  end;
end;

procedure TIcActionList.EnableActions;
var mCnt:word;
begin
  If ActionCount>0 then begin
    mCnt := 0;
    Repeat
      (Actions[mCnt] as TAction).Enabled := TRUE;
      Inc (mCnt)
    until  mCnt=ActionCount;
  end;
end;

procedure TIcActionList.DisableAction(pActionName:string);  // Nastavi parameter Enabled zadanej akcie na FALSE
var mAction:TAction;  mCnt:word;
begin
  If ActionCount>0 then begin
    mCnt := 0;
    Repeat
      mAction := (Actions[mCnt] as TAction);
      If mAction.Name = pActionName then mAction.Enabled := FALSE;
      Inc (mCnt)
    until  mCnt=ActionCount;
  end;
end;

procedure TIcActionList.EnableAction(pActionName:string);   // Nastavi parameter Enabled zadane akcie na TRUE
var mAction:TAction;  mCnt:word;
begin
  If ActionCount>0 then begin
    mCnt := 0;
    Repeat
      mAction := (Actions[mCnt] as TAction);
      If mAction.Name = pActionName then mAction.Enabled := TRUE;
      Inc (mCnt)
    until  mCnt=ActionCount;
  end;
end;


procedure Register;
begin
  RegisterComponents('IcStandard', [TIcActionList]);
end;

end.
