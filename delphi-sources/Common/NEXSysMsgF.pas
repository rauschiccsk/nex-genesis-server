unit NEXSysMsgF;

interface

uses
  NexPath,
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, xpComp, StdCtrls, ExtCtrls;

type
  TF_NEXSysMsg = class(TForm)
    P_Butt: TxpSinglePanel;
    P_Msg: TxpSinglePanel;
    M_Msg: TxpMemo;
    B_OK: TxpBitBtn;
    procedure B_OKClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  F_NEXSysMsg: TF_NEXSysMsg;

implementation

{$R *.dfm}

procedure TF_NEXSysMsg.B_OKClick(Sender: TObject);
begin
  Close;
end;

procedure TF_NEXSysMsg.FormCreate(Sender: TObject);
begin
  M_Msg.Lines.LoadFromFile(gPath.SysPath+'NEXSYSMSG.CMD');
end;

end.
