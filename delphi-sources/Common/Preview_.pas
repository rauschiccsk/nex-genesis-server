unit Preview_;

interface

uses
  IcConv, IcTools,
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  ExtCtrls, Buttons, QRPrntr, StdCtrls, ComCtrls, ActnList, IcActionList;

type
  TF_Preview = class(TForm)
    ControlBar1: TControlBar;
    Panel1: TPanel;
    QP_Preview: TQRPreview;
    Panel2: TPanel;
    Panel3: TPanel;
    SB_ZoomToFit: TSpeedButton;
    SB_ZoomTo100: TSpeedButton;
    SB_ZoomToWidth: TSpeedButton;
    SB_FirstPage: TSpeedButton;
    SB_PrevPage: TSpeedButton;
    SB_NextPage: TSpeedButton;
    SB_LastPage: TSpeedButton;
    CB_Zoom: TComboBox;
    SBa_Status: TStatusBar;
    Label1: TLabel;
    E_PageNum: TEdit;
    SB_Save: TSpeedButton;
    SB_Open: TSpeedButton;
    SB_Print: TSpeedButton;
    BB_Cancel: TBitBtn;
    OD_Open: TOpenDialog;
    SD_Save: TSaveDialog;
    IcActionList1: TIcActionList;
    A_Exit: TAction;
    A_Print: TAction;
    procedure SB_ZoomToFitClick(Sender: TObject);
    procedure SB_ZoomTo100Click(Sender: TObject);
    procedure SB_ZoomToWidthClick(Sender: TObject);
    procedure CB_ZoomExit(Sender: TObject);
    procedure QP_PreviewCanResize(Sender: TObject; var NewWidth,
      NewHeight: Integer; var Resize: Boolean);
    procedure SB_FirstPageClick(Sender: TObject);
    procedure SB_PrevPageClick(Sender: TObject);
    procedure SB_NextPageClick(Sender: TObject);
    procedure SB_LastPageClick(Sender: TObject);
    procedure QP_PreviewPageAvailable(Sender: TObject; PageNum: Integer);
    procedure E_PageNumExit(Sender: TObject);
    procedure SB_PrintClick(Sender: TObject);
    procedure BB_CancelClick(Sender: TObject);
    procedure SB_SaveClick(Sender: TObject);
    procedure SB_OpenClick(Sender: TObject);
    procedure CB_ZoomKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure E_PageNumKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure FormShow(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
  private
    oPrinted   : boolean; //Vráti, èi bol vytlaèený dokument
    oPrintedQnt: longint; //Poèet vytlaèených kópií

    procedure RefreshPageNum;
    { Private declarations }
  public
    property Printed:boolean read oPrinted write oPrinted;
    property PrintedQnt:longint read oPrintedQnt write oPrintedQnt;
    { Public declarations }
  end;

var
  F_Preview: TF_Preview;

implementation

{$R *.DFM}

procedure TF_Preview.RefreshPageNum;
begin
  SBa_Status.Panels.Items[0].Text := StrInt (QP_Preview.PageNumber,0)+'/'+StrInt (QP_Preview.QRPrinter.PageCount,0);
  E_PageNum.Text := StrInt (QP_Preview.PageNumber, 0);
end;

procedure TF_Preview.SB_ZoomToFitClick(Sender: TObject);
begin
  QP_Preview.ZoomToFit;
  CB_Zoom.Text := StrInt (QP_Preview.Zoom,0)+'%';
  QP_Preview.QRPrinter.Preview;
end;

procedure TF_Preview.SB_ZoomTo100Click(Sender: TObject);
begin
  QP_Preview.Zoom := 100;
  CB_Zoom.Text := StrInt (QP_Preview.Zoom,0)+'%';
  QP_Preview.QRPrinter.Preview;
end;

procedure TF_Preview.SB_ZoomToWidthClick(Sender: TObject);
begin
  QP_Preview.ZoomToWidth;
  CB_Zoom.Text := StrInt (QP_Preview.Zoom,0)+'%';
  QP_Preview.QRPrinter.Preview;
end;

procedure TF_Preview.CB_ZoomExit(Sender: TObject);
var mS:string;
begin
  mS := CB_Zoom.Text;
  ReplaceStr (mS,' ','');
  ReplaceStr (mS,'%','');
  QP_Preview.Zoom := ValInt (mS);
  CB_Zoom.Text := StrInt (QP_Preview.Zoom,0)+'%';
  QP_Preview.QRPrinter.Preview;
  RefreshPageNum;
end;

procedure TF_Preview.QP_PreviewCanResize(Sender: TObject; var NewWidth,
  NewHeight: Integer; var Resize: Boolean);
begin
  CB_Zoom.Text := StrInt (QP_Preview.Zoom,0)+'%';
end;

procedure TF_Preview.SB_FirstPageClick(Sender: TObject);
begin
  QP_Preview.PageNumber := 1;
  RefreshPageNum;
end;

procedure TF_Preview.SB_PrevPageClick(Sender: TObject);
begin
  QP_Preview.PageNumber := QP_Preview.PageNumber-1;
  RefreshPageNum;
end;

procedure TF_Preview.SB_NextPageClick(Sender: TObject);
begin
  QP_Preview.PageNumber := QP_Preview.PageNumber+1;
  RefreshPageNum;
end;

procedure TF_Preview.SB_LastPageClick(Sender: TObject);
begin
  QP_Preview.PageNumber := QP_Preview.QRPrinter.PageCount;
  RefreshPageNum;
end;

procedure TF_Preview.QP_PreviewPageAvailable(Sender: TObject;
  PageNum: Integer);
begin
  RefreshPageNum;
end;

procedure TF_Preview.E_PageNumExit(Sender: TObject);
begin
  QP_Preview.PageNumber := ValInt (E_PageNum.Text);
  RefreshPageNum;
end;

procedure TF_Preview.SB_PrintClick(Sender: TObject);
begin
  QP_Preview.QRPrinter.Print;
  oPrinted := TRUE;
  oPrintedQnt := oPrintedQnt+1;
end;

procedure TF_Preview.BB_CancelClick(Sender: TObject);
begin
  Close;
end;

procedure TF_Preview.SB_SaveClick(Sender: TObject);
begin
  If SD_Save.Execute then begin
    QP_Preview.QRPrinter.Save (SD_Save.FileName);
  end;
end;

procedure TF_Preview.SB_OpenClick(Sender: TObject);
begin
  If OD_Open.Execute then begin
    try
      QP_Preview.QRPrinter.Load (OD_Open.FileName);
      QP_Preview.QRPrinter.Preview;
      RefreshPageNum;
      Caption := QP_Preview.QRPrinter.Title;
    except end;
  end;
end;

procedure TF_Preview.CB_ZoomKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  If Key=VK_RETURN then E_PageNum.SetFocus;
end;

procedure TF_Preview.E_PageNumKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  If Key=VK_RETURN then CB_Zoom.SetFocus;
end;

procedure TF_Preview.FormShow(Sender: TObject);
begin
  oPrinted := FALSE;
  oPrintedQnt := 0;
  If QP_Preview.QRPrinter<>nil then Caption := QP_Preview.QRPrinter.Title;
end;

procedure TF_Preview.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  QP_Preview.QRPrinter.Free; QP_Preview.QRPrinter := nil;
end;

end.
