unit ProcInd_;

interface

uses
  LangForm, 
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, Buttons, ComCtrls, ExtCtrls;

type
  TF_ProcInd = class(TLangForm)
    Panel1: TPanel;
    PB_Ind: TProgressBar;
    BB_Cancel: TBitBtn;
    procedure BB_CancelClick(Sender: TObject);
  private
    oExit    : boolean;
    { Private declarations }
  public
    { Public declarations }
  end;

var
  F_ProcInd: TF_ProcInd;

procedure ShowProcInd (pHead:string;pMax:longint);
procedure StepProcInd;
function  GetProcIndExit:boolean;
procedure CloseProcInd;

implementation

{$R *.dfm}

procedure ShowProcInd (pHead:string;pMax:longint);
begin
  F_ProcInd := TF_ProcInd.Create(nil);
  F_ProcInd.PB_Ind.Max := pMax;
  F_ProcInd.PB_Ind.Position := 0;
  F_ProcInd.Caption := pHead;
  F_ProcInd.oExit := FALSE;
  F_ProcInd.Show;
end;

procedure StepProcInd;
begin
  F_ProcInd.PB_Ind.Position := F_ProcInd.PB_Ind.Position+1;
end;

function  GetProcIndExit:boolean;
begin
  Result := F_ProcInd.oExit;
end;

procedure CloseProcInd;
begin
  FreeandNil (F_ProcInd);
end;

procedure TF_ProcInd.BB_CancelClick(Sender: TObject);
begin
  oExit := TRUE;
end;

end.
