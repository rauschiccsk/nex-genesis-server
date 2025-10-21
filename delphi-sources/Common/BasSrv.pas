unit BasSrv;

interface

uses IcTools, EncodeIni, Forms, ExtCtrls, Classes, SysUtils;

type
  TAppInfo=record
    StartTime:TDateTime;
    ProcCnt:longint;
    LastTime:TDateTime;
    LastProc:string;
  end;

  TBasSrv=class(TObject)
    constructor Create;
    destructor Destroy; override;
  private
    oTimer:TTimer;
    procedure MyOnTimer(Sender:TObject);
  public
    procedure SetTimer(pInterval:longint);
    procedure TimerProc; virtual;
  end;

var gAppInfo:TAppInfo;
    gAppClose:boolean;

procedure SetLastProc(pLastProc:string);

implementation

procedure SetLastProc(pLastProc:string);
begin
  Inc(gAppInfo.ProcCnt);
  gAppInfo.LastTime:=Now;
  gAppInfo.LastProc:=pLastProc;
end;

// ********** TBasSrv **********
constructor TBasSrv.Create;
begin
  inherited;
  oTimer:=TTimer.Create(nil);
  oTimer.Interval:=0;
  oTimer.OnTimer:=MyOnTimer;
end;

destructor TBasSrv.Destroy;
begin
  oTimer.Enabled:=FALSE;
  FreeAndNil(oTimer);
  inherited;
end;

procedure TBasSrv.MyOnTimer(Sender: TObject);
begin
  oTimer.Enabled:=FALSE;
  TimerProc;
  If not gAppClose then oTimer.Enabled:=TRUE;
end;

procedure TBasSrv.SetTimer (pInterval:longint);
begin
  oTimer.Interval:=pInterval;
  oTimer.Enabled:=TRUE;
end;

procedure TBasSrv.TimerProc;
begin
end;

end.
