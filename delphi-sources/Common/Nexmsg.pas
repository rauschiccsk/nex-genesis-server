unit NexMsg;

interface

uses
  IcVariab, IcTypes, IcConv, IcTools, IcLabels, NexText, NexPath, NexIni,
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls, ComCtrls, ExtCtrls, Buttons, MPlayer, ToolWin,
  RichEdit, ImgList, IcStand, ActnList, IcActionList;

type
  TF_NexMsg = class(TForm)
    Image: TImage;
    RichEdit: TRichEdit;
    BB_1: TBitBtn;
    BB_2: TBitBtn;
    BB_3: TBitBtn;
    BB_4: TBitBtn;
    BB_6: TBitBtn;
    BB_5: TBitBtn;
    Label1: TLabel;
    Bevel1: TBevel;
    MediaPlayer: TMediaPlayer;
    Bevel2: TBevel;
    L_ErrorText: TLabel;
    L_ErrorCode: TNumLabel;
    ToolbarImages: TImageList;
    ToolBar: TToolBar;
    B_Save: TToolButton;
    ToolButton10: TToolButton;
    FontName: TComboBox;
    ToolButton11: TToolButton;
    FontSize: TEdit;
    UpDown1: TUpDown;
    ToolButton2: TToolButton;
    B_Bold: TToolButton;
    B_Italic: TToolButton;
    B_Underline: TToolButton;
    ToolButton16: TToolButton;
    B_LeftAlign: TToolButton;
    B_CenterAlign: TToolButton;
    B_RightAlign: TToolButton;
    ToolButton20: TToolButton;
    B_Bullets: TToolButton;
    ToolButton1: TToolButton;
    B_Undo: TToolButton;
    IcActionList1: TIcActionList;
    A_Exit: TAction;
    P_MsgDis: TPanel;
    E_MsgDis: TCheckBox;
    procedure BB_3Click(Sender: TObject);
    procedure BB_1Click(Sender: TObject);
    procedure BB_2Click(Sender: TObject);
    procedure BB_4Click(Sender: TObject);
    procedure BB_6Click(Sender: TObject);
    procedure BB_5Click(Sender: TObject);
    procedure FormActivate(Sender: TObject);
    procedure KeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure B_SaveClick(Sender: TObject);
    procedure B_BoldClick(Sender: TObject);
    procedure B_ItalicClick(Sender: TObject);
    procedure B_UnderlineClick(Sender: TObject);
    procedure B_AlignClick(Sender: TObject);
    procedure B_UndoClick(Sender: TObject);
    procedure FontNameChange(Sender: TObject);
    procedure B_BulletsClick(Sender: TObject);
    procedure FontSizeChange(Sender: TObject);
    procedure SelectionChange(Sender: TObject);
    procedure A_ExitExecute(Sender: TObject);
  private
    oExecute: integer;
    oErrorCode: longint;
    oErrorText: string;
    oFileRTF: string;

    function CurrText: TTextAttributes;
    procedure ReadFontNames;
    procedure SetMsgDisShow (pValue:boolean);
    procedure SaveMsgDis; // Ak bol oznaceny zakaz zobrazenia hlasenia ulozi do MSGDIS
  public
    function  Execute: integer;
    procedure SetHeader(pHeader: string);
    procedure SetRTF(pFileRTF: string);
    procedure SetBMP(pFileBMP: string);
    procedure SetWAV(pFileWAV: string);
    procedure SetStrings(pStr: string);
    procedure SetButtons(pStr,pButtonName: string);

    property ErrorCode: longint read oErrorCode write oErrorCode;
    property ErrorText: string read oErrorText write oErrorText;
  end;

function  AskYes (pCode:integer; pParam:Str200): boolean; overload;
function  AskYes (pCode:integer): boolean; overload;
procedure ShowMsg (pCode:integer; pParam:Str200); overload;
procedure ShowMsg (pCode:integer); overload;

var F_NexMsg: TF_NexMsg;

implementation

uses  Execwait, DM_SYSTEM;

{$R *.DFM}

function AskYes (pCode:integer; pParam:Str200): boolean;
var mAsk: TF_NexMsg;   mName: string;
begin
  mAsk := TF_NexMsg.Create (nil);
  mName := gPath.MsgPath+'A'+StrIntZero(pCode,7);
  gNT.SetSection ('MESSAGES');
  mAsk.ErrorCode := pCode;
  mAsk.ErrorText := gNT.GetText('ErrorText','Ciselny kod hlasenia');
  mAsk.SetRTF (mName+'.RTF');
  mAsk.SetBMP ('');
  mAsk.SetWAV (mName+'.WAV');
  mAsk.SetButtons(gNT.GetText('Button.No','&Nie')+'|'+gNT.GetText('Button.Yes','&Ano'),'CANCELBUTTON'+'|'+'OKBUTTON');
  mAsk.SetStrings (pParam);
  Result := mAsk.Execute=2;
  mAsk.Free;
end;

function AskYes (pCode:integer): boolean;
begin
  Result := AskYes (pCode,'');
end;

procedure ShowMsg (pCode:integer; pParam:Str200);
var mAsk: TF_NexMsg;   mName: string; mOk:boolean;
begin
  mAsk := TF_NexMsg.Create (nil);
  mName := gPath.MsgPath+'M'+StrIntZero(pCode,7);
  gNT.SetSection ('MESSAGES');
  mAsk.ErrorText := gNT.GetText('ErrorText','Ciselny kod hlasenia');
  mAsk.ErrorCode := pCode;
  mAsk.SetRTF (mName+'.RTF');
  mAsk.SetBMP ('');
  mAsk.SetWAV (mName+'.WAV');
  mAsk.SetButtons('&OK','OKBUTTON');
  mAsk.SetStrings (pParam);
  mAsk.Execute;
  mAsk.Free;
end;

procedure ShowMsg (pCode:integer);
begin
  ShowMsg (pCode,'');
end;

//***************** OBJECT *********************

function  TF_NexMsg.Execute: integer;
begin
  oExecute := 0;
  If gIni<>nil
    then SetMsgDisShow (gIni.MsgDisShow)
    else SetMsgDisShow (FALSE);
  If (dmSYS<>nil) and (dmSYS.btMSGDIS<>nil) then begin
    If dmSYS.btMSGDIS.Active then begin
      If not dmSYS.btMSGDIS.FindKey([gvSys.LoginName,oErrorCode]) then begin
        L_ErrorCode.ValueInt := oErrorCode;
        L_ErrorText.Caption := gNT.GetText (L_ErrorText.Caption,L_ErrorText.Caption);
        ReadFontNames;
        ShowModal;
        Result := oExecute;
      end
      else Result := dmSYS.btMSGDIS.FieldByName ('SlctBut').AsInteger;
    end
    else begin
      L_ErrorCode.ValueInt := oErrorCode;
      L_ErrorText.Caption := gNT.GetText (L_ErrorText.Caption,L_ErrorText.Caption);
      ReadFontNames;
      ShowModal;
      Result := oExecute;
    end;
  end;
end;

function TF_NexMsg.CurrText: TTextAttributes;
begin
  If RichEdit.SelLength > 0 then Result := RichEdit.SelAttributes
  else Result := RichEdit.DefAttributes;
end;

function EnumFontsProc(var LogFont: TLogFont; var TextMetric: TTextMetric;
                       FontType: Integer; Data: Pointer): Integer; stdcall;
begin
  TStrings(Data).Add(LogFont.lfFaceName);
  Result := 1;
end;

procedure TF_NexMsg.ReadFontNames;
var DC: HDC;
begin
  DC := GetDC(0);
  EnumFonts(DC, nil, @EnumFontsProc, Pointer(FontName.Items));
  ReleaseDC(0, DC);
  FontName.Sorted := True;
end;

procedure TF_NexMsg.SetMsgDisShow (pValue:boolean);
begin
  E_MsgDis.Visible := pValue;
  P_MsgDis.Visible := pValue;
  E_MsgDis.Enabled := pValue;
  P_MsgDis.Enabled := pValue;
end;

procedure TF_NexMsg.SaveMsgDis; // Ak bol oznaceny zakaz zobrazenia hlasenia ulozi do MSGDIS
begin
  If E_MsgDis.Checked then begin
    If dmSYS.btMSGDIS.Active then begin
      If not dmSYS.btMSGDIS.FindKey([gvSys.LoginName,oErrorCode]) then begin
        dmSYS.btMSGDIS.Insert;
        dmSYS.btMSGDIS.FieldByName('LogUser').AsString := gvSys.LoginName;
        dmSYS.btMSGDIS.FieldByName('MsgCode').AsInteger := oErrorCode;
        dmSYS.btMSGDIS.FieldByName('SlctBut').AsInteger := oExecute;
        dmSYS.btMSGDIS.Post;
      end;
    end;
  end;
end;

procedure TF_NexMsg.SetHeader(pHeader: string);
begin
  Caption := pHeader;
end;

procedure TF_NexMsg.SetRTF(pFileRTF: string);
begin
  try
    oFileRTF := pFileRTF;
    If FileExists(pFileRTF) then RichEdit.Lines.LoadFromFile(pFileRTF);
  except end;
end;

procedure TF_NexMsg.SetBMP(pFileBMP: string);
begin
  try
    if FileExists(pFileBMP) then Image.Picture.LoadFromFile(pFileBMP);
  except end;
end;

procedure TF_NexMsg.SetWAV(pFileWAV: string);
begin
  try
    If FileExists(pFileWAV) then begin
      MediaPlayer.Filename := pFileWAV;
      MediaPlayer.Visible := TRUE;
    end;
  except end;
end;

procedure TF_NexMsg.SetStrings(pStr: string);
var I, mLineElementNum: integer;
begin
  mLineElementNum := LineElementNum (pStr,'|');
  if mLineElementNum > 0 then begin
    If RichEdit.Lines.Count=0 then begin
      for i:=0 to mLineElementNum-1 do
        RichEdit.Lines.Add (LineElement(pStr,i,'|'));
    end else begin
      for i:=0 to mLineElementNum-1 do begin
        RichEdit.SelStart := RichEdit.FindText('%s', 0, RichEdit.GetTextLen, []); //???
        If RichEdit.SelStart<RichEdit.GetTextLen then begin
          RichEdit.SelLength := 2;
          RichEdit.SelText := LineElement(pStr,i,'|');
        end;
      end;
      repeat
        RichEdit.SelStart := RichEdit.FindText('%s', 0, RichEdit.GetTextLen, []);
        If RichEdit.SelStart<RichEdit.GetTextLen then begin
          RichEdit.SelLength := 2;
          RichEdit.SelText := '';
        end;
      until (RichEdit.SelStart >= RichEdit.GetTextLen);
    end;
  end;
  While RichEdit.FindText('%s', 0, RichEdit.GetTextLen, [])>-1 do begin
    RichEdit.SelStart := RichEdit.FindText('%s', 0, RichEdit.GetTextLen, []);
    If RichEdit.SelStart<RichEdit.GetTextLen then begin
      RichEdit.SelLength := 2;
      RichEdit.SelText := '';
    end;
  end;
end;

procedure TF_NexMsg.SetButtons(pStr,pButtonName: string);
var I, mLineElementNum: integer;
    mComponent: TComponent;
    mButton: TBitBtn;   mButtonname: string;
begin
  mLineElementNum := LineElementNum(pStr,'|');
  if mLineElementNum > 0 then begin
    for i:=0 to mLineElementNum-1 do begin
      mComponent := FindComponent('BB_'+IntToStr(i+1));
      if (mComponent <> nil) and (mComponent is TBitBtn) then begin
        mButton := (mComponent as TBitBtn);
        mButton.Caption := LineElement(pStr,i,'|');
        mButton.Visible := TRUE;
        mButtonName := LineElement(pButtonName,i,'|');
        If mButtonName<>'' then mButton.Glyph.LoadFromResourceName (HInstance,mButtonName);
      end;
    end;
  end;
end;

procedure TF_NexMsg.BB_3Click(Sender: TObject);
begin
  oExecute := 3;
  SaveMsgDis; // Ak bol oznaceny zakaz zobrazenia hlasenia ulozi do MSGDIS
  Close;
end;

procedure TF_NexMsg.BB_1Click(Sender: TObject);
begin
  oExecute := 1;
  SaveMsgDis; // Ak bol oznaceny zakaz zobrazenia hlasenia ulozi do MSGDIS
  Close;
end;

procedure TF_NexMsg.BB_2Click(Sender: TObject);
begin
  oExecute := 2;
  SaveMsgDis; // Ak bol oznaceny zakaz zobrazenia hlasenia ulozi do MSGDIS
  Close;
end;

procedure TF_NexMsg.BB_4Click(Sender: TObject);
begin
  oExecute := 4;
  SaveMsgDis; // Ak bol oznaceny zakaz zobrazenia hlasenia ulozi do MSGDIS
  Close;
end;

procedure TF_NexMsg.BB_6Click(Sender: TObject);
begin
  oExecute := 6;
  SaveMsgDis; // Ak bol oznaceny zakaz zobrazenia hlasenia ulozi do MSGDIS
  Close;
end;

procedure TF_NexMsg.BB_5Click(Sender: TObject);
begin
  oExecute := 5;
  SaveMsgDis; // Ak bol oznaceny zakaz zobrazenia hlasenia ulozi do MSGDIS
  Close;
end;

procedure TF_NexMsg.FormActivate(Sender: TObject);
begin
  try
    If FileExists(MediaPlayer.FileName) then begin
      MediaPlayer.Open;
      MediaPlayer.Play;
    end;
  except end;
end;

procedure TF_NexMsg.KeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
var mForm:TCustomForm;
begin
  If RichEdit.ReadOnly and ((Key=VK_RETURN) or (Key=VK_DOWN)) then begin
    mForm := GetParentForm(((Sender as TComponent).Owner as TControl));
    if (mForm <> nil ) then SendMessage(mForm.Handle, WM_NEXTDLGCTL, 0, 0);
  end;
  If (Key=VK_F4) then begin
    RichEdit.Enabled := True;
    RichEdit.ReadOnly := False;
    ToolBar.Visible := True;
    RichEdit.SetFocus;
  end;
  If (Key=VK_F8) then begin
    ExecAppWait(oFileRTF,'');
  end;
  If (Key=VK_ESCAPE) then Close;
end;

procedure TF_NexMsg.B_SaveClick(Sender: TObject);
begin
  RichEdit.Enabled := False;
  RichEdit.ReadOnly := True;
  RichEdit.Lines.SaveToFile(oFileRTF);
  ToolBar.Visible := False;
end;

procedure TF_NexMsg.B_BoldClick(Sender: TObject);
begin
  If B_Bold.Down
    then CurrText.Style := CurrText.Style+[fsBold]
    else CurrText.Style := CurrText.Style-[fsBold];
end;

procedure TF_NexMsg.B_ItalicClick(Sender: TObject);
begin
  If B_Italic.Down
    then CurrText.Style := CurrText.Style+[fsItalic]
    else CurrText.Style := CurrText.Style-[fsItalic];
end;

procedure TF_NexMsg.B_UnderlineClick(Sender: TObject);
begin
  If B_Underline.Down
    then CurrText.Style := CurrText.Style+[fsUnderline]
    else CurrText.Style := CurrText.Style-[fsUnderline];
end;

procedure TF_NexMsg.B_AlignClick(Sender: TObject);
begin
  RichEdit.Paragraph.Alignment := TAlignment(TControl(Sender).Tag);
end;

procedure TF_NexMsg.B_UndoClick(Sender: TObject);
begin
  With RichEdit do
    If HandleAllocated then SendMessage(Handle,EM_UNDO,0,0);
end;

procedure TF_NexMsg.FontNameChange(Sender: TObject);
begin
  CurrText.Name := FontName.Items[FontName.ItemIndex];
  RichEdit.SetFocus;
end;

procedure TF_NexMsg.B_BulletsClick(Sender: TObject);
begin
  RichEdit.Paragraph.Numbering := TNumberingStyle(B_Bullets.Down);
end;

procedure TF_NexMsg.FontSizeChange(Sender: TObject);
begin
  CurrText.Size := StrToInt(FontSize.Text);
end;

procedure TF_NexMsg.SelectionChange(Sender: TObject);
var CharPos: TPoint;
begin
  with RichEdit.Paragraph do
  try
    B_Bold.Down := fsBold in RichEdit.SelAttributes.Style;
    B_Italic.Down := fsItalic in RichEdit.SelAttributes.Style;
    B_Underline.Down := fsUnderline in RichEdit.SelAttributes.Style;
    B_Bullets.Down := Boolean(Numbering);
    FontSize.Text := IntToStr(RichEdit.SelAttributes.Size);
    FontName.Text := RichEdit.SelAttributes.Name;
    case Ord(Alignment) of
      0: B_LeftAlign.Down := True;
      1: B_RightAlign.Down := True;
      2: B_CenterAlign.Down := True;
    end;
//    UpdateCursorPos;
  finally
//    FUpdating := False;
  end;
end;

procedure TF_NexMsg.A_ExitExecute(Sender: TObject);
begin
  Close;
end;

end.
{MOD 1807029}
