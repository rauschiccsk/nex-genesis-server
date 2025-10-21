unit VPict_;

interface

uses
  LangForm, IcTools, IcConv,
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, jpeg, ExtCtrls, StdCtrls, Buttons, ActnList, IcActionList;

type
  TF_ViewPicture = class(TLangForm)
    Panel1: TPanel;
    SB_ZoomToFit: TSpeedButton;
    SB_ZoomTo100: TSpeedButton;
    SB_ZoomToWidth: TSpeedButton;
    CB_Zoom: TComboBox;
    I_Image: TImage;
    ScB_Image: TScrollBox;
    IcActionList1: TIcActionList;
    A_Exit: TAction;
    procedure CB_ZoomExit(Sender: TObject);
    procedure CB_ZoomClick(Sender: TObject);
    procedure CB_ZoomKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure SB_ZoomToFitClick(Sender: TObject);
    procedure SB_ZoomTo100Click(Sender: TObject);
    procedure SB_ZoomToWidthClick(Sender: TObject);
    procedure FormResize(Sender: TObject);
    procedure I_ImageMouseDown(Sender: TObject; Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
    procedure I_ImageMouseUp(Sender: TObject; Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
    procedure I_ImageMouseMove(Sender: TObject; Shift: TShiftState; X,Y: Integer);
    procedure A_ExitExecute(Sender: TObject);
  private
    oMove    :boolean;
    oX       :longint;
    oY       :longint;
    { Private declarations }
  public
    procedure Execute (pFile:string);
    { Public declarations }
  end;

var
  F_ViewPicture: TF_ViewPicture;

implementation

{$R *.dfm}
procedure TF_ViewPicture.Execute (pFile:string);
begin
  try
    I_Image.Picture.LoadFromFile(pFile);
  except end;
  ShowModal;
end;

procedure TF_ViewPicture.CB_ZoomExit(Sender: TObject);
begin
  CB_ZoomClick(Sender);
end;

procedure TF_ViewPicture.CB_ZoomClick(Sender: TObject);
var mS:string; mVal:longint;
begin
  mS := CB_Zoom.Text;
  mS := ReplaceStr (mS,' ','');
  mS := ReplaceStr (mS,'%','');
  mVal := ValInt (mS);
  CB_Zoom.Text := StrInt (mVal,0)+'%';
  I_Image.Width := Round (I_Image.Picture.Width*mVal/100);
  I_Image.Height := Round (I_Image.Picture.Height*mVal/100);
  If I_Image.Width>=ScB_Image.ClientWidth
    then I_Image.Left := -ScB_Image.HorzScrollBar.Position
    else I_Image.Left := (ScB_Image.ClientWidth-I_Image.Width) div 2;
  If I_Image.Height>=ScB_Image.ClientHeight
    then I_Image.Top := -ScB_Image.VertScrollBar.Position
    else I_Image.Top := (ScB_Image.ClientHeight-I_Image.Height) div 2;
  CB_Zoom.SelectAll;
end;

procedure TF_ViewPicture.CB_ZoomKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  If Key=VK_RETURN then CB_ZoomClick(Sender);
end;

procedure TF_ViewPicture.SB_ZoomToFitClick(Sender: TObject);
var mVal,mVal2:longint;
begin
  I_Image.Width := 0;
  I_Image.Height := 0;
  mVal := 100*ScB_Image.ClientWidth div I_Image.Picture.Width;
  mVal2 := 100*ScB_Image.ClientHeight div I_Image.Picture.Height;
  If mVal>mVal2 then mVal := mVal2;
  CB_Zoom.Text := StrInt(mVal,0);
  CB_ZoomClick(Sender);
end;

procedure TF_ViewPicture.SB_ZoomTo100Click(Sender: TObject);
begin
  CB_Zoom.Text := '100';
  CB_ZoomClick(Sender);
end;

procedure TF_ViewPicture.SB_ZoomToWidthClick(Sender: TObject);
var mVal:longint;
begin
  mVal := 100*ScB_Image.ClientWidth div I_Image.Picture.Width;
  CB_Zoom.Text := StrInt(mVal,0);
  CB_ZoomClick(Sender);
  mVal := 100*ScB_Image.ClientWidth div I_Image.Picture.Width;
  CB_Zoom.Text := StrInt(mVal,0);
  CB_ZoomClick(Sender);
end;

procedure TF_ViewPicture.FormResize(Sender: TObject);
begin
  CB_ZoomClick(Sender);
end;

procedure TF_ViewPicture.I_ImageMouseDown(Sender: TObject;
  Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
begin
  oMove := TRUE;
  oX := X;
  oY := Y;
end;

procedure TF_ViewPicture.I_ImageMouseUp(Sender: TObject;
  Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
begin
  oMove := FALSE;
end;

procedure TF_ViewPicture.I_ImageMouseMove(Sender: TObject;
  Shift: TShiftState; X, Y: Integer);
var mPosX,mPosY,mRange:longint;
begin
  If oMove then begin
    mPosX := ScB_Image.HorzScrollBar.Position+2*(oX-X);
    If mPosX<0 then  mPosX := 0;
    mRange := ScB_Image.HorzScrollBar.Range-ScB_Image.ClientWidth;
    If mPosX>mRange then mPosX := mRange;
    mPosY := ScB_Image.VertScrollBar.Position+2*(oY-Y);
    If mPosY<0 then  mPosY := 0;
    mRange := ScB_Image.VertScrollBar.Range-ScB_Image.ClientHeight;
    If mPosY>mRange then mPosY := mRange;
    If ScB_Image.HorzScrollBar.Position<>mPosX then begin
      ScB_Image.HorzScrollBar.Position := mPosX;
      oX := X+2*(oX-X);
    end else oX := X;
    If ScB_Image.VertScrollBar.Position<>mPosY then begin
      ScB_Image.VertScrollBar.Position := mPosY;
      oY := Y+2*(oY-Y);
    end else oY := Y;
  end;
end;

procedure TF_ViewPicture.A_ExitExecute(Sender: TObject);
begin
  Close;
end;

end.
