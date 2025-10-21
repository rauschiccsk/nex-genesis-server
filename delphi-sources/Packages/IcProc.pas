unit IcProc;

interface
  uses ExtCtrls, Classes, Graphics, Types, Windows, SysUtils;

  type
    TIcProcess = class (TImage)

    public
      constructor Create(AOwner: TComponent); override;
      destructor  Destroy; override;

      procedure StartProc;
      procedure EndProc;
      procedure Step;

    private
      oTimer: TTimer;

      oPos       : longint;
      oStepBy    : longint;
      oStartRed  : byte;
      oStartGreen: byte;
      oEndColor  : TColor;
      oEndRed    : byte;
      oEndGreen  : byte;
      oEndBlue   : byte;

      procedure DrawSign;
      procedure SetRefreshTime (Value:longint);
      function  GetRefreshTime:longint;
      procedure MyOnResize (Sender: TObject);
      procedure MyOnTimer (Sender: TObject);
    published
     property  StepBy:longint read oStepBy write oStepBy;
     property  RefreshTime:longint read GetRefreshTime write SetRefreshTime;
    end;

procedure Register;

implementation

uses Controls;

constructor TIcProcess.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  OnResize := MyOnResize;
  Width := 100;
  Height := 16;
  Picture.Bitmap.Dormant;
  oStartRed := Round (GetBValue(clBlue) div 2);
  oStartGreen := Round (GetBValue(clBlue) div 2);
  oEndColor := clBlue;
  oEndRed := GetRValue(oEndColor);
  oEndBlue := GetBValue(oEndColor);
  oEndGreen := GetGValue(oEndColor);
  oPos := 0;
  oStepBy := 5;
  MyOnResize (nil);

  oTimer := TTimer.Create(AOwner);
  oTimer.Enabled := FALSE;
  oTimer.Interval := 10;
  oTimer.OnTimer := MyOnTimer;
end;

destructor TIcProcess.Destroy;
begin
  FreeAndNil (oTimer);
  inherited Destroy;
end;

procedure TIcProcess.DrawSign;
var I:longint;
  tmpColor: TColor;
  NewRed,NewGreen,NewBlue: byte;
  mX:longint;
begin
  oStartRed := Round (oEndBlue div 2);
  oStartGreen := Round (oEndBlue div 2);
  tmpColor := RGB(oStartRed,oStartGreen,oEndBlue);

  For I:=0 to oStepBy do begin
    Picture.Bitmap.Canvas.Pen.Color := RGB(oStartRed,oStartGreen,GetBValue(clBlue));
    mX := oPos-I;
    If mX>Width then mX := mX-Width;
    Picture.Bitmap.Canvas.MoveTo(mX,0);
    Picture.Bitmap.Canvas.LineTo(mX,Height);
  end;

  For I:=1 to 40 do begin
    NewRed := oStartRed-I*(oStartRed div 40);
    NewGreen := oStartGreen-I*(oStartGreen div 40);
    tmpColor := RGB(NewRed,NewGreen,oEndBlue);

    Picture.Bitmap.Canvas.Pen.Color := tmpColor;
    mX := oPos+I;
    If mX>Width then mX := mX-Width;
    Picture.Bitmap.Canvas.MoveTo(mX,0);
    Picture.Bitmap.Canvas.LineTo(mX,Height);
  end;

  For I:=1 to 20 do begin
    Picture.Bitmap.Canvas.Pen.Color := oEndColor;
    mX := oPos+40+I;
    If mX>Width then mX := mX-Width;
    Picture.Bitmap.Canvas.MoveTo(mX,0);
    Picture.Bitmap.Canvas.LineTo(mX,Height);
  end;

  For I:=1 to 40 do begin
    NewRed := oStartRed-(40-I)*(oStartRed div 40);
    NewGreen := oStartGreen-(40-I)*(oStartGreen div 40);
    tmpColor := RGB(NewRed,NewGreen,oEndBlue);

    Picture.Bitmap.Canvas.Pen.Color := tmpColor;
    mX := oPos+60+I;
    If mX>Width then mX := mX-Width;
    Picture.Bitmap.Canvas.MoveTo(mX,0);
    Picture.Bitmap.Canvas.LineTo(mX,Height);
  end;
end;

procedure TIcProcess.SetRefreshTime (Value:longint);
begin
  oTimer.Interval := Value;
end;

function  TIcProcess.GetRefreshTime:longint;
begin
  Result := oTimer.Interval;
end;

procedure TIcProcess.MyOnResize (Sender: TObject);
var mRect:TRect;
begin
  If (Width>0) and (Height>0) then begin
    Picture.Bitmap.Width := Width;
    Picture.Bitmap.Height := Height;
    Picture.Bitmap.Canvas.Brush.Color := RGB(oStartRed,oStartGreen,GetBValue(clBlue));
    mRect.Left := 0;
    mRect.Top := 0;
    mRect.Right := Width;
    mRect.Bottom := Height;
    Picture.Bitmap.Canvas.FillRect(mRect);
    DrawSign;
  end;
end;

procedure TIcProcess.MyOnTimer (Sender: TObject);
begin
  oPos := oPos+StepBy;
  If oPos>Width then oPos := 0;
  DrawSign;
end;

procedure TIcProcess.StartProc;
begin
  oTimer.Enabled := TRUE;
end;

procedure TIcProcess.EndProc;
begin
  oTimer.Enabled := FALSE;
end;

procedure TIcProcess.Step;
begin
  oPos := oPos+StepBy;
  If oPos>Width then oPos := 0;
  DrawSign;
end;

procedure Register;
begin
  RegisterComponents('IcStandard', [TIcProcess]);
end;

end.
