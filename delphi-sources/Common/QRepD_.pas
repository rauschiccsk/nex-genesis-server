unit QRepD_;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls, Buttons, ExtCtrls;

type
  TF_Description = class(TForm)
    GroupBox1: TGroupBox;
    GroupBox2: TGroupBox;
    E_ReportTitle: TEdit;
    M_Description: TMemo;
    Panel1: TPanel;
    BB_OK: TBitBtn;
    BB_Cancel: TBitBtn;
    procedure BB_OKClick(Sender: TObject);
    procedure BB_CancelClick(Sender: TObject);
    procedure E_ReportTitleKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
  private
    oSave   : boolean;
    { Private declarations }
  public
    function  Execute:boolean;
    { Public declarations }
  end;

var
  F_Description: TF_Description;

implementation

{$R *.DFM}

function  TF_Description.Execute:boolean;
begin
  oSave := FALSE;
  ShowModal;
  Result := oSave;
end;

procedure TF_Description.BB_OKClick(Sender: TObject);
begin
  oSave := TRUE;
  Close;
end;

procedure TF_Description.BB_CancelClick(Sender: TObject);
begin
  oSave := FALSE;
  Close;
end;

procedure TF_Description.E_ReportTitleKeyDown(Sender: TObject;
  var Key: Word; Shift: TShiftState);
begin
  If Key=VK_RETURN then M_Description.SetFocus;
end;

end.
