unit IcInd;

interface

uses
  IcConv,
  Windows, Types, Graphics, SysUtils, Classes, Controls, StdCtrls;

type
  TIcInd = class(TLabel)
  private
    oMin     : longint;
    oMax     : longint;
    oStep    : longint;
    oPosition: longint;
    oShowText: boolean;

    procedure SetMin (Value:longint);
    procedure SetMax (Value:longint);
    procedure SetPosition (Value:longint);
    procedure SetShowText (Value:boolean);
    procedure ChangeCaption;
    procedure ShowIndState;
    { Private declarations }
  protected
    procedure Paint; override;
    { Protected declarations }
  public
      constructor Create(AOwner: TComponent); override;
      destructor  Destroy; override;

      procedure StepBy (Value:longint);
      procedure StepIt;
    { Public declarations }
  published
    property Min:longint read oMin write SetMin;
    property Max:longint read oMax write SetMax;
    property Position:longint read oPosition write SetPosition;
    property Step:longint read oStep write oStep;
    property ShowText:boolean read oShowText write SetShowText;

    { Published declarations }
  end;

procedure Register;

implementation

constructor TIcInd.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  Width := 150;
  Height := 17;
  AutoSize := FALSE;
  Alignment := taCenter;
  Layout := tlCenter;
  Transparent := TRUE;
  Constraints.MinHeight := 14;
  Constraints.MinWidth := 50;
  oMin      := 0;
  oMax      := 100;
  oStep     := 1;
  oPosition := 0;
  oShowText := TRUE;
end;

destructor TIcInd.Destroy;
begin
  inherited Destroy;
end;

procedure TIcInd.StepBy (Value:longint);
begin
  Position := Position+Value;
end;

procedure TIcInd.StepIt;
begin
  Position := Position+oStep;
end;

procedure TIcInd.Paint;
begin
  If (Width>0) and (Height>0) then begin
    Canvas.Pen.Color := clBlack;
    Canvas.MoveTo(3,0);
    Canvas.LineTo(Width-4,0);
    Canvas.LineTo(Width-1,3);
    Canvas.LineTo(Width-1,Height-4);
    Canvas.LineTo(Width-4,Height-1);
    Canvas.LineTo(3,Height-1);
    Canvas.LineTo(0,Height-4);
    Canvas.LineTo(0,3);
    Canvas.LineTo(3,0);

    Canvas.Brush.Color := clWhite;
    Canvas.FillRect(Rect(1,3,Width-1,Height-3));

    Canvas.Pen.Color := clWhite;
    Canvas.MoveTo(3,1);
    Canvas.LineTo(Width-3,1);
    Canvas.MoveTo(2,2);
    Canvas.LineTo(Width-2,2);
    Canvas.MoveTo(2,Height-3);
    Canvas.LineTo(Width-2,Height-3);
    Canvas.MoveTo(3,Height-2);
    Canvas.LineTo(Width-3,Height-2);

    Canvas.Pen.Color := clGray;

    Canvas.MoveTo(4,2);
    Canvas.LineTo(1,5);
    Canvas.MoveTo(2,Height-5);
    Canvas.LineTo(5,Height-2);

    Canvas.MoveTo(Width-5,2);
    Canvas.LineTo(Width-2,5);
    Canvas.MoveTo(Width-3,Height-5);
    Canvas.LineTo(Width-6,Height-2);
    ShowIndState;
    inherited Paint;
  end;
end;

procedure TIcInd.SetMin (Value:longint);
begin
  oMin := Value;
  ChangeCaption;
  Paint;
end;

procedure TIcInd.SetMax (Value:longint);
begin
  oMax := Value;
  ChangeCaption;
  Paint;
end;

procedure TIcInd.SetPosition (Value:longint);
begin
  oPosition := Value;
  If oPosition<oMin then oPosition := oMin;
  If oPosition>oMax then oPosition := oMax;
  ChangeCaption;
  Paint;
end;

procedure TIcInd.SetShowText (Value:boolean);
begin
 oShowText := Value;
 ChangeCaption;
 Paint;
end;

procedure TIcInd.ChangeCaption;
var mPos:longint;
begin
  Caption := '';
  If oMax-oMin>0 then begin
    mPos := (oPosition-oMin)*100 div (oMax-oMin);
    If mPos<0 then mPos := 0;
    If mPos>100 then mPos := 100;
    If oShowText then Caption := StrInt (mPos,0)+' %';
  end;
end;

procedure TIcInd.ShowIndState;
var I:longint;
  tmpColor: TColor;
  mStepRed,mStepGreen,mStepBlue: double;
  mNewRed,mNewGreen,mNewBlue: double;
  mEndRed,mEndGreen,mEndBlue: byte;
  mEndColor:TColor;
  mXPos:longint;
  mH:byte;
begin
  If oMax-oMin>0 then begin
    mXPos := ((Width+40-4)*(oPosition - oMin)) div (oMax-oMin);

    mEndColor := clSkyBlue;
    mEndRed := GetRValue(mEndColor);
    mEndBlue := GetBValue(mEndColor);
    mEndGreen := GetGValue(mEndColor);
    mStepRed := (255-mEndRed) / 40;
    mStepGreen := (255-mEndGreen) / 40;
    mStepBlue := (255-mEndBlue) / 40;

    mNewRed := mEndRed+40*mStepRed;
    mNewGreen := mEndGreen+40*mStepGreen;
    mNewBlue := mEndBlue+40*mStepBlue;
    For I:=mXPos downto 2 do begin
      If (mXPos-I)<40 then begin
        mNewRed := mNewRed-mStepRed;
        mNewGreen := mNewGreen-mStepGreen;
        mNewBlue := mNewBlue-mStepBlue;
        tmpColor := RGB(Round (mNewRed),Round (mNewGreen),Round (mNewBlue));
      end;
      Canvas.Pen.Color := tmpColor;
      If I<Width-2 then begin
        mH := 2;
        If I=2 then mH := 4;
        If I=3 then mH := 3;
        If I=Width-3 then mH := 4;
        If I=Width-4 then mH := 3;

        Canvas.MoveTo(I,mH);
        Canvas.LineTo(I,Height-mH);
      end;
    end;
  end;
end;

procedure Register;
begin
  RegisterComponents('IcStandard', [TIcInd]);
end;

end.
