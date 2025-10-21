unit ShowInfo;

interface

uses
  LangForm, 
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, Buttons, ComCtrls, ExtCtrls, xpComp;

type
  TF_ShowInfo = class(TLangForm)
    xpStatusLine1: TxpStatusLine;
    Panel1: TxpSinglePanel;
    PB_Ind: TProgressBar;
    BB_Cancel: TxpBitBtn;
    Label1: TxpLabel;
    procedure BB_CancelClick(Sender: TObject);
  private
    oExit    : boolean;
    { Private declarations }
  public
    { Public declarations }
  end;

var
  F_ShowInfo: TF_ShowInfo;

procedure ShowInfoInd (pFormHead,pHead:string;pMax:longint);
procedure StepInfoInd (pHead:string);
procedure ShowInfoTxt (pHead:string;pMax:longint);
function  GetInfoIndExit:boolean;
procedure CloseInfoInd;

implementation

{$R *.dfm}

Procedure ShowInfoInd (pFormHead,pHead:string;pMax:longint);
begin
  F_ShowInfo := TF_ShowInfo.Create(nil);
  F_ShowInfo.PB_Ind.Max      := pMax;
  F_ShowInfo.PB_Ind.Position := 0;
  F_ShowInfo.Caption         := pFormHead;
  F_ShowInfo.Panel1.Head     := pHead;
  F_ShowInfo.Label1.Caption  := pHead;
  F_ShowInfo.oExit           := FALSE;
  F_ShowInfo.Show;
end;

procedure ShowInfoTxt(pHead:string;pMax:longint);
begin
  F_ShowInfo.Panel1.Head      := pHead;
  F_ShowInfo.Label1.Caption   := pHead;
  F_ShowInfo.PB_Ind.Max       := pMax;
  F_ShowInfo.PB_Ind.Position  := 0;
end;

Procedure StepInfoInd;
begin
  If pHead<>'' then F_ShowInfo.Label1.Caption   := pHead;
  F_ShowInfo.PB_Ind.Position := F_ShowInfo.PB_Ind.Position+1;
end;

function  GetInfoIndExit:boolean;
begin
  Result := F_ShowInfo.oExit;
end;

Procedure CloseInfoInd;
begin
  FreeandNil (F_ShowInfo);
end;

Procedure TF_ShowInfo.BB_CancelClick(Sender: TObject);
begin
  oExit := TRUE;
end;

end.
