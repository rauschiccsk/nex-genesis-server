unit MsgLst;

interface

uses
  IcVariab, IcEditors, IcStand, IcConv, LangForm, NexMsg, TxtCut,
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms,
  Dialogs, ExtCtrls, StdCtrls, IcLabels, IcInfoFields, Registry, Buttons,
  IcButtons, jpeg, ActnList, IcActionList, xpComp;

type
  TF_MsgLstF = class(TLangForm)
    P_Des: TDinamicPanel;
    B_Ok: TOkButton;
    M_MsgLines: TMemo;
    L_MsgTitle: TCenterLabel;
    LB_LstLines: TListBox;
    L_LstTitle: TCenterLabel;
    ActionList: TIcActionList;
    A_Exit: TAction;
    P_Image: TxpSinglePanel;
    Image: TImage;
    procedure B_OkClick(Sender: TObject);
    procedure A_ExitExecute(Sender: TObject);
  private
    { Private declarations }
  public
     procedure SetWinTitle (pValue:string);
     procedure SetMsgTitle (pValue:string);
     procedure SetLstTitle (pValue:string);
     procedure AddMsgLine (pValue:string);
     procedure Execute (pLst:TStrings);
  end;

var
  F_MsgLstF: TF_MsgLstF;

implementation

{$R *.DFM}

procedure TF_MsgLstF.SetWinTitle (pValue:string);
begin
  Caption := pValue;
end;

procedure TF_MsgLstF.SetMsgTitle (pValue:string);
begin
  L_MsgTitle.Caption := pValue;
end;

procedure TF_MsgLstF.SetLstTitle (pValue:string);
begin
  L_LstTitle.Caption := pValue;
end;

procedure TF_MsgLstF.AddMsgLine (pValue:string);
begin
  M_MsgLines.Lines.Add (pValue);
end;

procedure TF_MsgLstF.Execute (pLst:TStrings);
begin
  LB_LstLines.Items := pLst;
  ShowModal;
end;


procedure TF_MsgLstF.B_OkClick(Sender: TObject);
begin
  Close;
end;

procedure TF_MsgLstF.A_ExitExecute(Sender: TObject);
begin
  Close;
end;

end.
