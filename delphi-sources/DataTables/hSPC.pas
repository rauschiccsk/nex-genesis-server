unit hSPC;

interface       

uses
  IcTypes, NexPath, NexGlob, bSPC, hSPM,
  Forms, Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Dialogs;

type
  TSpcHnd = class (TSpcBtr)
  private
  public
    procedure Del(pGsCode:longint;phSPM:TSpmHnd);
    procedure Clc(pPoCode:Str15;pGsCode:longint;phSPM:TSpmHnd);
  published
  end;

implementation

procedure TSpcHnd.Del(pGsCode:longint;phSPM:TSpmHnd);
var mMyOp:boolean;
begin
  mMyOp:=phSPM=nil;
  If mMyOp then begin
    phSPM:=TSpmHnd.Create;   phSPM.Open(BtrTable.ListNum);
  end;
  While LocateGsCode(pGsCode) do begin
    Application.ProcessMessages;
    Delete;
  end;
  While phSPM.LocateGsCode(pGsCode) do begin
    Application.ProcessMessages;
    phSPM.Delete;
  end;
  If mMyOp then FreeAndNil(phSPM);
end;

procedure TSpcHnd.Clc(pPoCode:Str15;pGsCode:longint;phSPM:TSpmHnd);
var mMyOp:boolean;  mActQnt,mResQnt:double;  mIncDate,mOutDate:TDateTime;
begin
  mMyOp:=phSPM=nil;
  If mMyOp then begin
    phSPM:=TSpmHnd.Create;   phSPM.Open(BtrTable.ListNum);
  end;
  mActQnt:=0;
  If phSPM.LocatePoGs(pPoCode,pGsCode) then begin
    Repeat
      mActQnt:=mActQnt+phSPM.MovQnt;
      phSPM.Next;
    until phSPM.Eof or (phSPM.PoCode<>pPoCode) or (phSPM.GsCode<>pGsCode);
  end;
  SwapStatus;
  If LocatePoGs(pPoCode,pGsCode) then begin
    If (ActQnt<>mActQnt) then begin
      Edit;
      ActQnt:=mActQnt;
      Post;
    end;
  end
  else begin
    Insert;
    PoCode:=pPoCode;
    GsCode:=pGsCode;
    ActQnt:=mActQnt;
    Post;
  end;
  RestoreStatus;
  If mMyOp then FreeAndNil(phSPM);
end;

end.
