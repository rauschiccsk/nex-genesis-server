unit NexCls;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, ComCtrls, StdCtrls, xpComp, ExtCtrls;

type
  TF_NexCls = class(TForm)
    P_Main: TxpSinglePanel;
    L_Head: TxpLabel;
    L_Title: TxpLabel;
    PB_Ind: TProgressBar;
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  F_NexCls: TF_NexCls;

implementation

{$R *.dfm}

end.
