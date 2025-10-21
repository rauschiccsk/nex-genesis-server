unit CntWin;

interface

uses
  LangForm,
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  IcLabels, StdCtrls, ComCtrls, IcStand, ExtCtrls;

type
  TF_CntWinF = class(TLangForm)
    DinamicPanel1: TDinamicPanel;
    ProgressBar1: TProgressBar;
    Animate1: TAnimate;
    StatusLine1: TStatusLine;
    LeftLabel1: TLeftLabel;
    LeftLabel2: TLeftLabel;
    NumLabel1: TNumLabel;
    NumLabel2: TNumLabel;
    DinamicPanel2: TDinamicPanel;
  private
    oMaxValue: longint;
    oActValue: longint;
  public
    procedure Execute(pCount:longint;pText:String);
    procedure RefCnt;
    procedure AddCnt(pCount:longint);
  end;

var
  F_CntWinF: TF_CntWinF;

implementation

{$R *.DFM}

procedure TF_CntWinF.Execute;
begin
  ProgressBar1.Max:=pCount;
  ProgressBar1.Min:=0;
  ProgressBar1.Position:=0;
  ProgressBar1.Step:=1;
  NumLabel1.ValueInt:=pCount;
  NumLabel2.ValueInt:=0;
  Animate1.Play(0,0,0);
  Show;
  DinamicPanel2.Caption:=pText;
end;

procedure TF_CntWinF.RefCnt;
begin
  NumLabel2.ValueInt:=NumLabel2.ValueInt+1;
  ProgressBar1.StepIt;
end;

procedure TF_CntWinF.AddCnt(pCount:longint);
begin
  NumLabel2.ValueInt:=NumLabel2.ValueInt+pCount;
  ProgressBar1.StepBy(pCount);
end;

end.
