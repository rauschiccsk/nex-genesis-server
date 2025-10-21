unit IcForm;

interface

  uses
    Dialogs,
    IcVariab,
    EncodeIni, NexPath, xpComp, IcConv, IcTools, DsgnUtils,
    Forms, Classes, SysUtils, Controls, Graphics, StdCtrls,
    Messages, Windows, Menus;

  const
    cEnableFormDesign: boolean = TRUE;
    cUserFormLevel: longint = 0;

type
  TIcForm = class(TForm)
    procedure AfterConstruction; override;
    procedure BeforeDestruction; override;
  private
    oFormNum     : byte;
    oColorScheme : string;
    oAccept      : boolean;
    oCompData    : TCompData;
    oSaveDefForm : boolean;
    oTabOrders   : TStringList;
    oPopup       : TPopupMenu;
    oEnableDesigner: boolean;

    procedure WMSysCommand(var Msg: TWMSysCommand) ; message WM_SYSCOMMAND;
    procedure AddTabOrder (pTabOrder:longint;pComp:string);
    procedure SetTabOrders;

    function  SetFormComp (pComp:TForm;mParam:string):boolean;
    function  SetxpSinglePanelComp (pComp:TxpSinglePanel;mParam:string):boolean;
    function  SetxpGroupBoxComp (pComp:TxpGroupBox;mParam:string):boolean;
    function  SetxpPageControlComp (pComp:TxpPageControl;mParam:string):boolean;
    function  SetxpTabSheetComp (pComp:TxpTabSheet;mParam:string):boolean;
    function  SetxpButtonComp (pComp:TxpBitBtn;mParam:string):boolean;
    function  SetxpEditComp (pComp:TxpEdit;mParam:string):boolean;
    function  SetxpLabelComp (pComp:TxpLabel;mParam:string):boolean;
    function  SetxpCheckBoxComp (pComp:TxpCheckBox;mParam:string):boolean;
    function  SetxpComboBoxComp (pComp:TxpComboBox;mParam:string):boolean;
    function  SetxpRadioButtonComp (pComp:TxpRadioButton;mParam:string):boolean;
    function  SetxpMemoComp (pComp:TxpMemo;mParam:string):boolean;
    function  SetxpRichEditComp (pComp:TxpRichEdit;mParam:string):boolean;
    function  SetxpStatusLine (pComp:TxpStatusLine;mParam:string):boolean;
    function  SetBasicComp (pComp:TControl;mParam:string):boolean;

    procedure SaveFormData (pFormNum:byte);
    function  GetCompParams (pComp:TComponent):string;
    function  GetFormParams (pComp:TForm):string;
    function  GetxpSinglePanelCompParams (pComp:TxpSinglePanel):string;
    function  GetxpGroupBoxCompParams (pComp:TxpGroupBox):string;
    function  GetxpPageControlCompParams (pComp:TxpPageControl):string;
    function  GetxpTabSheetCompParams (pComp:TxpTabSheet):string;
    function  GetxpButtonCompParams (pComp:TxpBitBtn):string;
    function  GetxpEditCompParams (pComp:TxpEdit):string;
    function  GetxpLabelCompParams (pComp:TxpLabel):string;
    function  GetxpCheckBoxCompParams (pComp:TxpCheckBox):string;
    function  GetxpComboBoxCompParams (pComp:TxpComboBox):string;
    function  GetxpRadioButtonCompParams (pComp:TxpRadioButton):string;
    function  GetxpMemoCompParams (pComp:TxpMemo):string;
    function  GetxpRichEditCompParams (pComp:TxpRichEdit):string;
    function  GetxpStatusLineCompParams (pComp:TxpStatusLine):string;
    function  GetBasicCompParams (pComp:TControl):string;

    procedure DesignerForm;
    procedure WriteDefForm;

    procedure SaveFormPos;
    function  LoadFormPos (var pLeft,pTop,pWidth,pHeight:longint;var pWindowState:TWindowState):boolean;

    procedure FillPopupMenu;
    procedure CheckFormMenuItem;
  published
    constructor Create(AOwner: TComponent); override;
    constructor CreateType(AOwner: TComponent;pFormType:byte);
    destructor  Destroy; override;
    procedure   LoadFormData (pFormNum:byte);
  public
    property Accept:boolean read oAccept write oAccept;
    property EnableDesigner:boolean read oEnableDesigner write oEnableDesigner;
  end;

  TMoveForm = class(TForm)
  private
      procedure WMMove(var Message: TMessage) ; message WM_MOVE;
  published
    constructor Create(AOwner: TComponent); override;
  end;

implementation

uses DsgnForm;

procedure TIcForm.AfterConstruction;
var SysMenu:HMenu; mMyPos:boolean;
  mLeft,mTop,mWidth,mHeight:longint;mWindowState:TWindowState;
begin
  inherited AfterConstruction;
  If oEnableDesigner then begin
    SysMenu := GetSystemMenu(Handle, FALSE);
    oPopup := TPopupMenu.Create(Self);
    If cEnableFormDesign then begin
      AppendMenu(SysMenu, MF_SEPARATOR, WM_USER+3, '') ;
      AppendMenu(SysMenu, MF_STRING, WM_USER+1, 'N·vrh formul·ra') ;
      AppendMenu(SysMenu, MF_UNCHECKED, WM_USER+2, 'Uloûiù z·kladn˝ formul·r') ;
    end;
    WriteDefForm;
  end;
  mMyPos := LoadFormPos (mLeft,mTop,mWidth,mHeight,mWindowState);
  LoadFormData (oFormNum);
  If mMyPos then begin
    Left := mLeft;
    Top := mTop;
    Width := mWidth;
    Height := mHeight;
    WindowState := mWindowState;
  end;
end;

procedure TIcForm.BeforeDestruction;
begin
  SaveFormPos;
  inherited ;
end;

procedure TIcForm.WMSysCommand(var Msg: TWMSysCommand) ;
var SysMenu:HMenu; mIni:TEncodeIniFile; mFile:string; mFind:boolean; I:longint;
begin
  If oEnableDesigner then begin
    case Msg.CmdType of
      WM_USER+1: DesignerForm;
      WM_USER+2: begin
        oSaveDefForm := not oSaveDefForm;
        SysMenu := GetSystemMenu(Handle, FALSE);
        If oSaveDefForm
          then CheckMenuItem(SysMenu, WM_USER+2, MF_BYCOMMAND+MF_CHECKED)
          else CheckMenuItem(SysMenu, WM_USER+2, MF_BYCOMMAND+MF_UNCHECKED);
        mFile := gPath.LngPath+Name+'.SFD';
        mIni := TEncodeIniFile.Create(mFile,FALSE);
        mIni.Encode := FALSE;
        mIni.WriteBool('SYSTEM','SaveDefault',oSaveDefForm);
        FreeAndNil (mIni);
      end
      else begin
        mFind := FALSE;
        SysMenu := GetSystemMenu(Handle, FALSE);
        I := GetMenuItemID (SysMenu,0);
        If oPopup<>nil then begin
          If oPopup.Items.Count>0 then begin
            For I:=0 to oPopup.Items.Count-1 do begin
              mFind := (Msg.CmdType=oPopup.Items[I].Command);
              If mFind then begin
                oFormNum := ValInt (Copy (oPopup.Items[I].Caption,1,Pos (' ',oPopup.Items[I].Caption)-1));
                LoadFormData(oFormNum);
                FillPopupMenu;
                CheckFormMenuItem;
                Break;
              end;
            end;
          end;
        end;
        If not mFind then inherited;
      end;
    end;
  end else inherited;
end;

procedure TIcForm.AddTabOrder (pTabOrder:longint;pComp:string);
begin
  oTabOrders.Add(StrIntZero (pTabOrder,5)+' '+pComp);
end;

procedure TIcForm.SetTabOrders;
var I,mTabOrder:longint;mCompname:string;mComp:TComponent;
begin
  If oTabOrders.Count>0 then begin
    oTabOrders.Sort;
    For I:=0 to oTabOrders.Count-1 do begin
      mTabOrder := ValInt (Copy (oTabOrders.Strings[I],1,Pos (' ',oTabOrders.Strings[I])-1));
      mCompName := Copy (oTabOrders.Strings[I],Pos (' ',oTabOrders.Strings[I])+1,Length (oTabOrders.Strings[I]));
      mComp := FindComponent(mCompName);
      If mComp<>nil then begin
        If mComp is TWinControl then (mComp as TWinControl).TabOrder := mTabOrder;
      end;
    end;
  end;
end;

procedure TIcForm.LoadFormData (pFormNum:byte);
var mIni:TEncodeIniFile; mFile,mCom, mParam:string; I:longint; mSect:TStrings; mComp:TComponent; mFind:boolean;
begin
  oformNum := pFormNum;
  oTabOrders.Clear;
  mFile := GetFormDefFileName (gPath.LngPath+Name,pFormNum);
  mSect := TStringList.Create;
  mIni := TEncodeIniFile.Create(mFile,FALSE);
  mIni.ReadSectionValues(StrInt (pFormNum,0),mSect);
  If mSect.Count>0 then begin
    For I:=0 to mSect.Count-1 do begin
      mParam := mSect.Strings[I];
      mCom := Copy (mParam,1,Pos ('=',mParam)-1);
      Delete (mParam,1,Pos ('=',mParam));
      mParam := mIni.ReadString(StrInt (pFormNum,0),mCom,'');
      If (mCom<>'') and (mParam<>'') then begin
        If mCom=Name
          then mComp := Self
          else mComp := FindComponent(mCom);
        If mComp<>nil then begin
          mFind := FALSE;
          If mComp is TForm then mFind := SetFormComp (mComp as TForm,mParam);
          If not mFind and (mComp is TxpSinglePanel) then mFind := SetxpSinglePanelComp (mComp as TxpSinglePanel,mParam);
          If not mFind and (mComp is TxpGroupBox) then mFind := SetxpGroupBoxComp (mComp as TxpGroupBox,mParam);
          If not mFind and (mComp is TxpBitBtn) then mFind := SetxpButtonComp (mComp as TxpBitBtn,mParam);
          If not mFind and (mComp is TxpEdit) then mFind := SetxpEditComp (mComp as TxpEdit,mParam);
          If not mFind and (mComp is TxpLabel) then mFind := SetxpLabelComp (mComp as TxpLabel,mParam);
          If not mFind and (mComp is TxpCheckBox) then mFind := SetxpCheckBoxComp (mComp as TxpCheckBox,mParam);
          If not mFind and (mComp is TxpComboBox) then mFind := SetxpComboBoxComp (mComp as TxpComboBox,mParam);
          If not mFind and (mComp is TxpRadioButton) then mFind := SetxpRadioButtonComp (mComp as TxpRadioButton,mParam);
          If not mFind and (mComp is TxpMemo) then mFind := SetxpMemoComp (mComp as TxpMemo,mParam);
          If not mFind and (mComp is TxpRichEdit) then mFind := SetxpRichEditComp (mComp as TxpRichEdit,mParam);
          If not mFind and (mComp is TxpPageControl) then mFind := SetxpPageControlComp (mComp as TxpPageControl,mParam);
          If not mFind and (mComp is TxpTabSheet) then mFind := SetxpTabSheetComp (mComp as TxpTabSheet,mParam);
          If not mFind and (mComp is TxpStatusLine) then mFind := SetxpStatusLine (mComp as TxpStatusLine,mParam);
          If not mFind and (mComp is TControl) then mFind := SetBasicComp (mComp as TControl,mParam);
        end;
      end;
    end;
  end;
  FreeAndNil (mIni);
  FreeAndNil (mSect);
  SetTabOrders;
end;

function  TIcForm.SetFormComp (pComp:TForm;mParam:string):boolean;
begin
  Result := TRUE;
  oCompData.SetCompData(mParam);
  pComp.Left := oCompData.GetLeft(pComp.Left);
  pComp.Top := oCompData.GetTop(pComp.Top);
  pComp.Height := oCompData.GetHeight(pComp.Height);
  pComp.Width := oCompData.GetWidth(pComp.Width);
  pComp.Align := oCompData.GetAlign(pComp.Align);
  pComp.Caption := oCompData.GetCaption(pComp.Caption);
  pComp.Color := oCompData.GetColor(pComp.Color);
end;

function  TIcForm.SetxpSinglePanelComp (pComp:TxpSinglePanel;mParam:string):boolean;
begin
  Result := TRUE;
  oCompData.SetCompData(mParam);
  pComp.Left := oCompData.GetLeft(pComp.Left);
  pComp.Top := oCompData.GetTop(pComp.Top);
  pComp.Height := oCompData.GetHeight(pComp.Height);
  pComp.Width := oCompData.GetWidth(pComp.Width);
  pComp.Visible := oCompData.GetVisible(pComp.Visible);
  pComp.Enabled := oCompData.GetEnabled(pComp.Enabled);
  pComp.Align := oCompData.GetAlign(pComp.Align);
  pComp.Anchors := oCompData.GetAnchors(pComp.Anchors);
  pComp.Head := oCompData.GetHead(pComp.Head);
  pComp.Hint := oCompData.GetHint(pComp.Hint);
  pComp.ShowHint := oCompData.GetShowHint(pComp.ShowHint);
  pComp.TabOrder := oCompData.GetTabOrder(pComp.TabOrder);
  AddTabOrder (pComp.TabOrder,pComp.Name);
  pComp.TabStop := oCompData.GetTabStop(pComp.TabStop);
  pComp.SystemColor := oCompData.GetSystemColor(pComp.SystemColor);
  pComp.BasicColor := oCompData.GetBasicColor(pComp.BasicColor);
  pComp.Color := oCompData.GetColor(pComp.Color);
  pComp.BorderColor := oCompData.GetBorderColor(pComp.BorderColor);
  ConvHEXToBitmap (oCompData.GetBGImage(ConvBitmapToHEX(pComp.BGImage)),pComp.BGImage);
  pComp.BGStyle := oCompData.GetBGStyle (pComp.BGStyle);
  pComp.GradStartColor := oCompData.GetGradStartColor (pComp.GradStartColor);
  pComp.GradEndColor := oCompData.GetGradEndColor (pComp.GradEndColor);
  pComp.GradFillDir := oCompData.GetGradFillDir (pComp.GradFillDir);
  pComp.Font.Color := oCompData.GetFontColor(pComp.Font.Color);
  pComp.Font.Name := oCompData.GetFontName(pComp.Font.Name);
  pComp.Font.Size := oCompData.GetFontSize(pComp.Font.Size);
  pComp.Font.Style := oCompData.GetFontStyle(pComp.Font.Style);
  pComp.Font.Charset := oCompData.GetFontCharset(pComp.Font.Charset);
end;

function  TIcForm.SetxpGroupBoxComp (pComp:TxpGroupBox;mParam:string):boolean;
begin
  Result := TRUE;
  oCompData.SetCompData(mParam);
  pComp.Left := oCompData.GetLeft(pComp.Left);
  pComp.Top := oCompData.GetTop(pComp.Top);
  pComp.Height := oCompData.GetHeight(pComp.Height);
  pComp.Width := oCompData.GetWidth(pComp.Height);
  pComp.Visible := oCompData.GetVisible(pComp.Visible);
  pComp.Enabled := oCompData.GetEnabled(pComp.Enabled);
  pComp.Align := oCompData.GetAlign(pComp.Align);
  pComp.Anchors := oCompData.GetAnchors(pComp.Anchors);
  pComp.Caption := oCompData.GetCaption(pComp.Caption);
  pComp.Hint := oCompData.GetHint(pComp.Hint);
  pComp.ShowHint := oCompData.GetShowHint(pComp.ShowHint);
  pComp.TabOrder := oCompData.GetTabOrder(pComp.TabOrder);
  AddTabOrder (pComp.TabOrder,pComp.Name);
  pComp.TabStop := oCompData.GetTabStop(pComp.TabStop);
  pComp.SystemColor := oCompData.GetSystemColor(pComp.SystemColor);
  pComp.BasicColor := oCompData.GetBasicColor(pComp.BasicColor);
  pComp.Color := oCompData.GetColor(pComp.Color);
  pComp.BorderColor := oCompData.GetBorderColor(pComp.BorderColor);
  pComp.Font.Color := oCompData.GetFontColor(pComp.Font.Color);
  pComp.Font.Name := oCompData.GetFontName(pComp.Font.Name);
  pComp.Font.Size := oCompData.GetFontSize(pComp.Font.Size);
  pComp.Font.Style := oCompData.GetFontStyle(pComp.Font.Style);
  pComp.Font.Charset := oCompData.GetFontCharset(pComp.Font.Charset);
end;

function  TIcForm.SetxpPageControlComp (pComp:TxpPageControl;mParam:string):boolean;
begin
  Result := TRUE;
  oCompData.SetCompData(mParam);
  pComp.Left := oCompData.GetLeft(pComp.Left);
  pComp.Top := oCompData.GetTop(pComp.Top);
  pComp.Height := oCompData.GetHeight(pComp.Height);
  pComp.Width := oCompData.GetWidth(pComp.Width);
  pComp.Visible := oCompData.GetVisible(pComp.Visible);
  pComp.Enabled := oCompData.GetEnabled(pComp.Enabled);
  pComp.Align := oCompData.GetAlign(pComp.Align);
  pComp.Anchors := oCompData.GetAnchors(pComp.Anchors);
  pComp.Hint := oCompData.GetHint(pComp.Hint);
  pComp.ShowHint := oCompData.GetShowHint(pComp.ShowHint);
  pComp.TabOrder := oCompData.GetTabOrder(pComp.TabOrder);
  AddTabOrder (pComp.TabOrder,pComp.Name);
  pComp.TabStop := oCompData.GetTabStop(pComp.TabStop);
  pComp.TabsShow := oCompData.GetTabsShow(pComp.TabsShow);
  pComp.TabHeight := oCompData.GetTabHeight(pComp.TabHeight);
  pComp.MultiLine := oCompData.GetMultiLine(pComp.MultiLine);
  pComp.SystemColor := oCompData.GetSystemColor(pComp.SystemColor);
  pComp.BasicColor := oCompData.GetBasicColor(pComp.BasicColor);
  pComp.Color := oCompData.GetColor(pComp.Color);
  pComp.BorderColor := oCompData.GetBorderColor(pComp.BorderColor);
  pComp.Font.Color := oCompData.GetFontColor(pComp.Font.Color);
  pComp.Font.Name := oCompData.GetFontName(pComp.Font.Name);
  pComp.Font.Size := oCompData.GetFontSize(pComp.Font.Size);
  pComp.Font.Style := oCompData.GetFontStyle(pComp.Font.Style);
  pComp.Font.Charset := oCompData.GetFontCharset(pComp.Font.Charset);
end;

function  TIcForm.SetxpTabSheetComp (pComp:TxpTabSheet;mParam:string):boolean;
begin
  Result := TRUE;
  oCompData.SetCompData(mParam);
  pComp.Left := oCompData.GetLeft(pComp.Left);
  pComp.Top := oCompData.GetTop(pComp.Top);
  pComp.Height := oCompData.GetHeight(pComp.Height);
  pComp.Width := oCompData.GetWidth(pComp.Width);
  pComp.TabVisible := oCompData.GetVisible(pComp.TabVisible);
  pComp.Enabled := oCompData.GetEnabled(pComp.Enabled);
  pComp.Caption := oCompData.GetCaption(pComp.Caption);
  pComp.PageIndex := oCompData.GetPageIndex(pComp.PageIndex);
  pComp.Hint := oCompData.GetHint(pComp.Hint);
  pComp.ShowHint := oCompData.GetShowHint(pComp.ShowHint);
  pComp.SystemColor := oCompData.GetSystemColor(pComp.SystemColor);
  pComp.BasicColor := oCompData.GetBasicColor(pComp.BasicColor);
  pComp.Color := oCompData.GetColor(pComp.Color);
  ConvHEXToBitmap (oCompData.GetBGImage(ConvBitmapToHEX(pComp.BGImage)),pComp.BGImage);
  pComp.BGStyle := oCompData.GetBGStyle (pComp.BGStyle);
  pComp.GradientStartColor := oCompData.GetGradStartColor (pComp.GradientStartColor);
  pComp.GradientEndColor := oCompData.GetGradEndColor (pComp.GradientEndColor);
  pComp.GradientFillDir := oCompData.GetGradFillDir (pComp.GradientFillDir);
  pComp.Font.Color := oCompData.GetFontColor(pComp.Font.Color);
  pComp.Font.Name := oCompData.GetFontName(pComp.Font.Name);
  pComp.Font.Size := oCompData.GetFontSize(pComp.Font.Size);
  pComp.Font.Style := oCompData.GetFontStyle(pComp.Font.Style);
  pComp.Font.Charset := oCompData.GetFontCharset(pComp.Font.Charset);
end;

function  TIcForm.SetxpButtonComp (pComp:TxpBitBtn;mParam:string):boolean;
begin
  Result := TRUE;
  oCompData.SetCompData(mParam);
  pComp.Left := oCompData.GetLeft(pComp.Left);
  pComp.Top := oCompData.GetTop(pComp.Top);
  pComp.Height := oCompData.GetHeight(pComp.Height);
  pComp.Width := oCompData.GetWidth(pComp.Width);
  pComp.Visible := oCompData.GetVisible(pComp.Visible);
  pComp.Enabled := oCompData.GetEnabled(pComp.Enabled);
  pComp.Caption := oCompData.GetCaption(pComp.Caption);
  pComp.Anchors := oCompData.GetAnchors(pComp.Anchors);
  pComp.AlignText := oCompData.GetAlignText(pComp.AlignText);
  pComp.Hint := oCompData.GetHint(pComp.Hint);
  pComp.ShowHint := oCompData.GetShowHint(pComp.ShowHint);
  pComp.TabOrder := oCompData.GetTabOrder(pComp.TabOrder);
  AddTabOrder (pComp.TabOrder,pComp.Name);
  pComp.TabStop := oCompData.GetTabStop(pComp.TabStop);
  pComp.SystemColor := oCompData.GetSystemColor(pComp.SystemColor);
  pComp.BasicColor := oCompData.GetBasicColor(pComp.BasicColor);
  pComp.Layout := oCompData.GetButtLayout(pComp.Layout);
  ConvHEXToBitmap (oCompData.GetGlyph(ConvBitmapToHEX(pComp.Glyph)),pComp.Glyph);
  pComp.Font.Color := oCompData.GetFontColor(pComp.Font.Color);
  pComp.Font.Name := oCompData.GetFontName(pComp.Font.Name);
  pComp.Font.Size := oCompData.GetFontSize(pComp.Font.Size);
  pComp.Font.Style := oCompData.GetFontStyle(pComp.Font.Style);
  pComp.Font.Charset := oCompData.GetFontCharset(pComp.Font.Charset);
end;

function  TIcForm.SetxpEditComp (pComp:TxpEdit;mParam:string):boolean;
begin
  Result := TRUE;
  oCompData.SetCompData(mParam);
  pComp.Left := oCompData.GetLeft(pComp.Left);
  pComp.Top := oCompData.GetTop(pComp.Top);
  pComp.Height := oCompData.GetHeight(pComp.Height);
  pComp.Width := oCompData.GetWidth(pComp.Width);
  pComp.Visible := oCompData.GetVisible(pComp.Visible);
  pComp.Enabled := oCompData.GetEnabled(pComp.Enabled);
  pComp.ReadOnly := oCompData.GetReadOnly(pComp.ReadOnly);
  pComp.Anchors := oCompData.GetAnchors(pComp.Anchors);
  pComp.Alignment := oCompData.GetAlignment(pComp.Alignment);
  pComp.Align := oCompData.GetAlign(pComp.Align);
  pComp.Hint := oCompData.GetHint(pComp.Hint);
  pComp.ShowHint := oCompData.GetShowHint(pComp.ShowHint);
  pComp.TabOrder := oCompData.GetTabOrder(pComp.TabOrder);
  AddTabOrder (pComp.TabOrder,pComp.Name);
  pComp.TabStop := oCompData.GetTabStop(pComp.TabStop);
  pComp.MaxLength := oCompData.GetMaxLength(pComp.MaxLength);
  pComp.NumSepar := oCompData.GetNumSepar(pComp.NumSepar);
  pComp.Frac := oCompData.GetFrac(pComp.Frac);
  pComp.EditorType := oCompData.GetEditorType(pComp.EditorType);
  pComp.ExtTextShow := oCompData.GetExtTextShow(pComp.ExtTextShow);
  pComp.SystemColor := oCompData.GetSystemColor(pComp.SystemColor);
  pComp.BasicColor := oCompData.GetBasicColor(pComp.BasicColor);
  pComp.Color := oCompData.GetColor(pComp.Color);
  pComp.InfoField := oCompData.GetInfoField(pComp.InfoField);
  pComp.Font.Color := oCompData.GetFontColor(pComp.Font.Color);
  pComp.Font.Name := oCompData.GetFontName(pComp.Font.Name);
  pComp.Font.Size := oCompData.GetFontSize(pComp.Font.Size);
  pComp.Font.Style := oCompData.GetFontStyle(pComp.Font.Style);
  pComp.Font.Charset := oCompData.GetFontCharset(pComp.Font.Charset);
end;

function  TIcForm.SetxpLabelComp (pComp:TxpLabel;mParam:string):boolean;
begin
  Result := TRUE;
  oCompData.SetCompData(mParam);
  pComp.Left := oCompData.GetLeft(pComp.Left);
  pComp.Top := oCompData.GetTop(pComp.Top);
  pComp.Height := oCompData.GetHeight(pComp.Height);
  pComp.Width := oCompData.GetWidth(pComp.Width);
  pComp.Visible := oCompData.GetVisible(pComp.Visible);
  pComp.Enabled := oCompData.GetEnabled(pComp.Enabled);
  pComp.Align := oCompData.GetAlign(pComp.Align);
  pComp.Alignment := oCompData.GetAlignment(pComp.Alignment);
  pComp.Anchors := oCompData.GetAnchors(pComp.Anchors);
  pComp.AutoSize := oCompData.GetAutoSize(pComp.AutoSize);
  pComp.Layout := oCompData.GetTextLayout(pComp.Layout);
  pComp.Hint := oCompData.GetHint(pComp.Hint);
  pComp.ShowHint := oCompData.GetShowHint(pComp.ShowHint);
  pComp.Transparent := oCompData.GetTransparent(pComp.Transparent);
  pComp.WordWrap := oCompData.GetWordWrap(pComp.WordWrap);
  pComp.Caption := oCompData.GetCaption(pComp.Caption);
  pComp.SystemColor := oCompData.GetSystemColor(pComp.SystemColor);
  pComp.Color := oCompData.GetColor(pComp.Color);
  pComp.Font.Color := oCompData.GetFontColor(pComp.Font.Color);
  pComp.Font.Name := oCompData.GetFontName(pComp.Font.Name);
  pComp.Font.Size := oCompData.GetFontSize(pComp.Font.Size);
  pComp.Font.Style := oCompData.GetFontStyle(pComp.Font.Style);
  pComp.Font.Charset := oCompData.GetFontCharset(pComp.Font.Charset);
end;

function  TIcForm.SetxpCheckBoxComp (pComp:TxpCheckBox;mParam:string):boolean;
begin
  Result := TRUE;
  oCompData.SetCompData(mParam);
  pComp.Left := oCompData.GetLeft(pComp.Left);
  pComp.Top := oCompData.GetTop(pComp.Top);
  pComp.Height := oCompData.GetHeight(pComp.Height);
  pComp.Width := oCompData.GetWidth(pComp.Width);
  pComp.Visible := oCompData.GetVisible(pComp.Visible);
  pComp.Enabled := oCompData.GetEnabled(pComp.Enabled);
  pComp.Anchors := oCompData.GetAnchors(pComp.Anchors);
  pComp.Caption := oCompData.GetCaption(pComp.Caption);
  pComp.Hint := oCompData.GetHint(pComp.Hint);
  pComp.ShowHint := oCompData.GetShowHint(pComp.ShowHint);
  pComp.TabOrder := oCompData.GetTabOrder(pComp.TabOrder);
  AddTabOrder (pComp.TabOrder,pComp.Name);
  pComp.TabStop := oCompData.GetTabStop(pComp.TabStop);
  pComp.SystemColor := oCompData.GetSystemColor(pComp.SystemColor);
  pComp.BasicColor := oCompData.GetBasicColor(pComp.BasicColor);
  pComp.CheckColor := oCompData.GetCheckColor(pComp.CheckColor);
  pComp.Font.Color := oCompData.GetFontColor(pComp.Font.Color);
  pComp.Font.Name := oCompData.GetFontName(pComp.Font.Name);
  pComp.Font.Size := oCompData.GetFontSize(pComp.Font.Size);
  pComp.Font.Style := oCompData.GetFontStyle(pComp.Font.Style);
  pComp.Font.Charset := oCompData.GetFontCharset(pComp.Font.Charset);
end;

function  TIcForm.SetxpComboBoxComp (pComp:TxpComboBox;mParam:string):boolean;
begin
  Result := TRUE;
  oCompData.SetCompData(mParam);
  pComp.Left := oCompData.GetLeft(pComp.Left);
  pComp.Top := oCompData.GetTop(pComp.Top);
  pComp.Height := oCompData.GetHeight(pComp.Height);
  pComp.Width := oCompData.GetWidth(pComp.Width);
  pComp.Visible := oCompData.GetVisible(pComp.Visible);
  pComp.Enabled := oCompData.GetEnabled(pComp.Enabled);
  pComp.Anchors := oCompData.GetAnchors(pComp.Anchors);
  pComp.Hint := oCompData.GetHint(pComp.Hint);
  pComp.ShowHint := oCompData.GetShowHint(pComp.ShowHint);
  pComp.TabOrder := oCompData.GetTabOrder(pComp.TabOrder);
  AddTabOrder (pComp.TabOrder,pComp.Name);
  pComp.TabStop := oCompData.GetTabStop(pComp.TabStop);
  pComp.Items.Text := oCompData.GetLines(pComp.Items.Text);
  pComp.MaxLength := oCompData.GetMaxLength(pComp.MaxLength);
  pComp.SystemColor := oCompData.GetSystemColor(pComp.SystemColor);
  pComp.BasicColor := oCompData.GetBasicColor(pComp.BasicColor);
  pComp.Color := oCompData.GetColor(pComp.Color);
  pComp.Font.Color := oCompData.GetFontColor(pComp.Font.Color);
  pComp.Font.Name := oCompData.GetFontName(pComp.Font.Name);
  pComp.Font.Size := oCompData.GetFontSize(pComp.Font.Size);
  pComp.Font.Style := oCompData.GetFontStyle(pComp.Font.Style);
  pComp.Font.Charset := oCompData.GetFontCharset(pComp.Font.Charset);
end;

function  TIcForm.SetxpRadioButtonComp (pComp:TxpRadioButton;mParam:string):boolean;
begin
  Result := TRUE;
  oCompData.SetCompData(mParam);
  pComp.Left := oCompData.GetLeft(pComp.Left);
  pComp.Top := oCompData.GetTop(pComp.Top);
  pComp.Height := oCompData.GetHeight(pComp.Height);
  pComp.Width := oCompData.GetWidth(pComp.Width);
  pComp.Visible := oCompData.GetVisible(pComp.Visible);
  pComp.Enabled := oCompData.GetEnabled(pComp.Enabled);
  pComp.Anchors := oCompData.GetAnchors(pComp.Anchors);
  pComp.Caption := oCompData.GetCaption(pComp.Caption);
  pComp.Hint := oCompData.GetHint(pComp.Hint);
  pComp.ShowHint := oCompData.GetShowHint(pComp.ShowHint);
  pComp.TabOrder := oCompData.GetTabOrder(pComp.TabOrder);
  AddTabOrder (pComp.TabOrder,pComp.Name);
  pComp.TabStop := oCompData.GetTabStop(pComp.TabStop);
  pComp.SystemColor := oCompData.GetSystemColor(pComp.SystemColor);
  pComp.BasicColor := oCompData.GetBasicColor(pComp.BasicColor);
  pComp.CheckColor := oCompData.GetCheckColor(pComp.CheckColor);
  pComp.Font.Color := oCompData.GetFontColor(pComp.Font.Color);
  pComp.Font.Name := oCompData.GetFontName(pComp.Font.Name);
  pComp.Font.Size := oCompData.GetFontSize(pComp.Font.Size);
  pComp.Font.Style := oCompData.GetFontStyle(pComp.Font.Style);
  pComp.Font.Charset := oCompData.GetFontCharset(pComp.Font.Charset);
end;

function  TIcForm.SetxpMemoComp (pComp:TxpMemo;mParam:string):boolean;
begin
  Result := TRUE;
  oCompData.SetCompData(mParam);
  pComp.Left := oCompData.GetLeft(pComp.Left);
  pComp.Top := oCompData.GetTop(pComp.Top);
  pComp.Height := oCompData.GetHeight(pComp.Height);
  pComp.Width := oCompData.GetWidth(pComp.Width);
  pComp.Visible := oCompData.GetVisible(pComp.Visible);
  pComp.Enabled := oCompData.GetEnabled(pComp.Enabled);
  pComp.ReadOnly := oCompData.GetReadOnly(pComp.ReadOnly);
  pComp.Align := oCompData.GetAlign(pComp.Align);
  pComp.Alignment := oCompData.GetAlignment(pComp.Alignment);
  pComp.Anchors := oCompData.GetAnchors(pComp.Anchors);
  pComp.Hint := oCompData.GetHint(pComp.Hint);
  pComp.ShowHint := oCompData.GetShowHint(pComp.ShowHint);
  pComp.TabOrder := oCompData.GetTabOrder(pComp.TabOrder);
  AddTabOrder (pComp.TabOrder,pComp.Name);
  pComp.TabStop := oCompData.GetTabStop(pComp.TabStop);
  pComp.Lines.Text := oCompData.GetLines(pComp.Lines.Text);
  pComp.MaxLength := oCompData.GetMaxLength(pComp.MaxLength);
  pComp.WordWrap := oCompData.GetWordWrap(pComp.WordWrap);
  pComp.SystemColor := oCompData.GetSystemColor(pComp.SystemColor);
  pComp.BasicColor := oCompData.GetBasicColor(pComp.BasicColor);
  pComp.Color := oCompData.GetColor(pComp.Color);
  pComp.Font.Color := oCompData.GetFontColor(pComp.Font.Color);
  pComp.Font.Name := oCompData.GetFontName(pComp.Font.Name);
  pComp.Font.Size := oCompData.GetFontSize(pComp.Font.Size);
  pComp.Font.Style := oCompData.GetFontStyle(pComp.Font.Style);
  pComp.Font.Charset := oCompData.GetFontCharset(pComp.Font.Charset);
end;

function  TIcForm.SetxpRichEditComp (pComp:TxpRichEdit;mParam:string):boolean;
begin
  Result := TRUE;
  oCompData.SetCompData(mParam);
  pComp.Left := oCompData.GetLeft(pComp.Left);
  pComp.Top := oCompData.GetTop(pComp.Top);
  pComp.Height := oCompData.GetHeight(pComp.Height);
  pComp.Width := oCompData.GetWidth(pComp.Width);
  pComp.Visible := oCompData.GetVisible(pComp.Visible);
  pComp.Enabled := oCompData.GetEnabled(pComp.Enabled);
  pComp.ReadOnly := oCompData.GetReadOnly(pComp.ReadOnly);
  pComp.Align := oCompData.GetAlign(pComp.Align);
  pComp.Alignment := oCompData.GetAlignment(pComp.Alignment);
  pComp.Anchors := oCompData.GetAnchors(pComp.Anchors);
  pComp.Hint := oCompData.GetHint(pComp.Hint);
  pComp.ShowHint := oCompData.GetShowHint(pComp.ShowHint);
  pComp.TabOrder := oCompData.GetTabOrder(pComp.TabOrder);
  AddTabOrder (pComp.TabOrder,pComp.Name);
  pComp.TabStop := oCompData.GetTabStop(pComp.TabStop);
  pComp.Lines.Text := oCompData.GetLines(pComp.Lines.Text);
  pComp.MaxLength := oCompData.GetMaxLength(pComp.MaxLength);
  pComp.WordWrap := oCompData.GetWordWrap(pComp.WordWrap);
  pComp.SystemColor := oCompData.GetSystemColor(pComp.SystemColor);
  pComp.BasicColor := oCompData.GetBasicColor(pComp.BasicColor);
  pComp.Color := oCompData.GetColor(pComp.Color);
  pComp.Font.Color := oCompData.GetFontColor(pComp.Font.Color);
  pComp.Font.Name := oCompData.GetFontName(pComp.Font.Name);
  pComp.Font.Size := oCompData.GetFontSize(pComp.Font.Size);
  pComp.Font.Style := oCompData.GetFontStyle(pComp.Font.Style);
  pComp.Font.Charset := oCompData.GetFontCharset(pComp.Font.Charset);
end;

function  TIcForm.SetxpStatusLine (pComp:TxpStatusLine;mParam:string):boolean;
begin
  Result := TRUE;
  oCompData.SetCompData(mParam);
end;

function  TIcForm.SetBasicComp (pComp:TControl;mParam:string):boolean;
begin
  Result := TRUE;
  oCompData.SetCompData(mParam);
  pComp.Left := oCompData.GetLeft(pComp.Left);
  pComp.Top := oCompData.GetTop(pComp.Top);
  pComp.Height := oCompData.GetHeight(pComp.Height);
  pComp.Width := oCompData.GetWidth(pComp.Width);
  pComp.Visible := oCompData.GetVisible(pComp.Visible);
  pComp.Align := oCompData.GetAlign(pComp.Align);
end;

procedure TIcForm.SaveFormData (pFormNum:byte);
var mIni:TEncodeIniFile; mFile:string; I:longint;
begin
  mFile := GetFormDefFileName (gPath.LngPath+Name,pFormNum);
  mIni := TEncodeIniFile.Create(mFile,FALSE);
  mIni.Encode := FALSE;
  If mIni.SectionExists(StrInt (pFormNum,0)) then mIni.EraseSection(StrInt (pFormNum,0));
  mIni.WriteString(StrInt (pFormNum,0),Name,GetCompParams (Self));
  For I:=0 to ComponentCount-1 do begin
    If (Components[I] is TControl) and not (Components[I] is TForm)
      then mIni.WriteString(StrInt (pFormNum,0),Components[I].Name,GetCompParams (Components[I]));
  end;
  FreeAndNil (mIni);
end;

function  TIcForm.GetCompParams (pComp:TComponent):string;
begin
  Result := '';
  If pComp is TForm then Result := GetFormParams (pComp as TForm);
  If (Result='') and (pComp is TxpSinglePanel) then Result := GetxpSinglePanelCompParams (pComp as TxpSinglePanel);
  If (Result='') and (pComp is TxpGroupBox) then Result := GetxpGroupBoxCompParams (pComp as TxpGroupBox);
  If (Result='') and (pComp is TxpPageControl) then Result := GetxpPageControlCompParams (pComp as TxpPageControl);
  If (Result='') and (pComp is TxpTabSheet) then Result := GetxpTabSheetCompParams (pComp as TxpTabSheet);
  If (Result='') and (pComp is TxpBitBtn) then Result := GetxpButtonCompParams (pComp as TxpBitBtn);
  If (Result='') and (pComp is TxpEdit) then Result := GetxpEditCompParams (pComp as TxpEdit);
  If (Result='') and (pComp is TxpLabel) then Result := GetxpLabelCompParams (pComp as TxpLabel);
  If (Result='') and (pComp is TxpCheckBox) then Result := GetxpCheckBoxCompParams (pComp as TxpCheckBox);
  If (Result='') and (pComp is TxpComboBox) then Result := GetxpComboBoxCompParams (pComp as TxpComboBox);
  If (Result='') and (pComp is TxpRadioButton) then Result := GetxpRadioButtonCompParams (pComp as TxpRadioButton);
  If (Result='') and (pComp is TxpMemo) then Result := GetxpMemoCompParams (pComp as TxpMemo);
  If (Result='') and (pComp is TxpRichEdit) then Result := GetxpRichEditCompParams (pComp as TxpRichEdit);
  If (Result='') and (pComp is TxpStatusLine) then Result := GetxpStatusLineCompParams (pComp as TxpStatusLine);
  If (Result='') and (pComp is TControl) then Result := GetBasicCompParams (pComp as TControl);
end;

function  TIcForm.GetFormParams (pComp:TForm):string;
begin
  oCompData.ClearCompData;
  oCompData.SetCompType ('Form');
  oCompData.SetTop (pComp.Top);
  oCompData.SetLeft (pComp.Left);
  oCompData.SetHeight (pComp.Height);
  oCompData.SetWidth (pComp.Width);
  oCompData.SetCaption (pComp.Caption);
  oCompData.SetColor (pComp.Color);
  oCompData.SetAlign (pComp.Align);
  Result := oCompData.GetCompData;
end;

function  TIcForm.GetxpSinglePanelCompParams (pComp:TxpSinglePanel):string;
begin
  oCompData.ClearCompData;
  oCompData.SetCompType ('xpSinglePanel');
  oCompData.SetParent (pComp.Parent.Name);
  oCompData.SetTop (pComp.Top);
  oCompData.SetLeft (pComp.Left);
  oCompData.SetHeight (pComp.Height);
  oCompData.SetWidth (pComp.Width);
  oCompData.SetVisible (pComp.Visible);
  oCompData.SetEnabled (pComp.Enabled);
  oCompData.SetAlign (pComp.Align);
  oCompData.SetAnchors (pComp.Anchors);
  oCompData.SetHead (pComp.Head);
  oCompData.SetHint (pComp.Hint);
  oCompData.SetShowHint (pComp.ShowHint);
  oCompData.SetTabOrder (pComp.TabOrder);
  oCompData.SetTabStop (pComp.TabStop);
  oCompData.SetSystemColor (pComp.SystemColor);
  oCompData.SetBasicColor (pComp.BasicColor);
  oCompData.SetColor (pComp.Color);
  oCompData.SetBorderColor (pComp.BorderColor);
  oCompData.SetBGImage (ConvBitmapToHEX(pComp.BGImage));
  oCompData.SetBGStyle (pComp.BGStyle);
  oCompData.SetGradStartColor (pComp.GradStartColor);
  oCompData.SetGradEndColor (pComp.GradEndColor);
  oCompData.SetGradFillDir (pComp.GradFillDir);
  oCompData.SetFontColor (pComp.Font.Color);
  oCompData.SetFontName (pComp.Font.Name);
  oCompData.SetFontSize (pComp.Font.Size);
  oCompData.SetFontStyle (pComp.Font.Style);
  oCompData.SetFontCharset (pComp.Font.Charset);
  Result := oCompData.GetCompData;
end;

function  TIcForm.GetxpGroupBoxCompParams (pComp:TxpGroupBox):string;
begin
  oCompData.ClearCompData;
  oCompData.SetCompType ('xpGroupBox');
  oCompData.SetParent (pComp.Parent.Name);
  oCompData.SetTop (pComp.Top);
  oCompData.SetLeft (pComp.Left);
  oCompData.SetHeight (pComp.Height);
  oCompData.SetWidth (pComp.Width);
  oCompData.SetVisible (pComp.Visible);
  oCompData.SetEnabled (pComp.Enabled);
  oCompData.SetAlign (pComp.Align);
  oCompData.SetAnchors (pComp.Anchors);
  oCompData.SetCaption (pComp.Caption);
  oCompData.SetHint (pComp.Hint);
  oCompData.SetShowHint (pComp.ShowHint);
  oCompData.SetTabOrder (pComp.TabOrder);
  oCompData.SetTabStop (pComp.TabStop);
  oCompData.SetSystemColor (pComp.SystemColor);
  oCompData.SetBasicColor (pComp.BasicColor);
  oCompData.SetColor (pComp.Color);
  oCompData.SetBorderColor (pComp.BorderColor);
  oCompData.SetFontColor (pComp.Font.Color);
  oCompData.SetFontName (pComp.Font.Name);
  oCompData.SetFontSize (pComp.Font.Size);
  oCompData.SetFontStyle (pComp.Font.Style);
  oCompData.SetFontCharset (pComp.Font.Charset);
  Result := oCompData.GetCompData;
end;

function  TIcForm.GetxpPageControlCompParams (pComp:TxpPageControl):string;
begin
  oCompData.ClearCompData;
  oCompData.SetCompType ('xpPageControl');
  oCompData.SetParent (pComp.Parent.Name);
  oCompData.SetTop (pComp.Top);
  oCompData.SetLeft (pComp.Left);
  oCompData.SetHeight (pComp.Height);
  oCompData.SetWidth (pComp.Width);
  oCompData.SetVisible (pComp.Visible);
  oCompData.SetEnabled (pComp.Enabled);
  oCompData.SetAlign (pComp.Align);
  oCompData.SetAnchors (pComp.Anchors);
  oCompData.SetHint (pComp.Hint);
  oCompData.SetShowHint (pComp.ShowHint);
  oCompData.SetTabOrder (pComp.TabOrder);
  oCompData.SetTabStop (pComp.TabStop);
  oCompData.SetTabsShow (pComp.TabsShow);
  oCompData.SetTabHeight (pComp.TabHeight);
  oCompData.SetMultiLine (pComp.MultiLine);
  oCompData.SetSystemColor (pComp.SystemColor);
  oCompData.SetBasicColor (pComp.BasicColor);
  oCompData.SetColor (pComp.Color);
  oCompData.SetBorderColor (pComp.BorderColor);
  oCompData.SetFontColor (pComp.Font.Color);
  oCompData.SetFontName (pComp.Font.Name);
  oCompData.SetFontSize (pComp.Font.Size);
  oCompData.SetFontStyle (pComp.Font.Style);
  oCompData.SetFontCharset (pComp.Font.Charset);
  Result := oCompData.GetCompData;
end;

function  TIcForm.GetxpTabSheetCompParams (pComp:TxpTabSheet):string;
begin
  oCompData.ClearCompData;
  oCompData.SetCompType ('xpTabSheet');
  oCompData.SetParent (pComp.Parent.Name);
  oCompData.SetTop (pComp.Top);
  oCompData.SetLeft (pComp.Left);
  oCompData.SetHeight (pComp.Height);
  oCompData.SetWidth (pComp.Width);
  oCompData.SetVisible (pComp.TabVisible);
  oCompData.SetEnabled (pComp.Enabled);
  oCompData.SetCaption (pComp.Caption);
  oCompData.SetPageIndex (pComp.PageIndex);
  oCompData.SetHint (pComp.Hint);
  oCompData.SetShowHint (pComp.ShowHint);
  oCompData.SetSystemColor (pComp.SystemColor);
  oCompData.SetBasicColor (pComp.BasicColor);
  oCompData.SetColor (pComp.Color);
  oCompData.SetBGImage (ConvBitmapToHEX(pComp.BGImage));
  oCompData.SetBGStyle (pComp.BGStyle);
  oCompData.SetGradStartColor (pComp.GradientStartColor);
  oCompData.SetGradEndColor (pComp.GradientEndColor);
  oCompData.SetGradFillDir (pComp.GradientFillDir);
  oCompData.SetFontColor (pComp.Font.Color);
  oCompData.SetFontName (pComp.Font.Name);
  oCompData.SetFontSize (pComp.Font.Size);
  oCompData.SetFontStyle (pComp.Font.Style);
  oCompData.SetFontCharset (pComp.Font.Charset);
  Result := oCompData.GetCompData;
end;

function  TIcForm.GetxpButtonCompParams (pComp:TxpBitBtn):string;
begin
  oCompData.ClearCompData;
  oCompData.SetCompType ('xpBitBtn');
  oCompData.SetParent (pComp.Parent.Name);
  oCompData.SetTop (pComp.Top);
  oCompData.SetLeft (pComp.Left);
  oCompData.SetHeight (pComp.Height);
  oCompData.SetWidth (pComp.Width);
  oCompData.SetVisible (pComp.Visible);
  oCompData.SetEnabled (pComp.Enabled);
  oCompData.SetCaption (pComp.Caption);
  oCompData.SetAnchors (pComp.Anchors);
  oCompData.SetAlignText (pComp.AlignText);
  oCompData.SetHint (pComp.Hint);
  oCompData.SetShowHint (pComp.ShowHint);
  oCompData.SetTabOrder (pComp.TabOrder);
  oCompData.SetTabStop (pComp.TabStop);
  oCompData.SetSystemColor (pComp.SystemColor);
  oCompData.SetBasicColor (pComp.BasicColor);
  oCompData.SetButtLayout (pComp.Layout);
  oCompData.SetGlyph (ConvBitmapToHEX (pComp.Glyph));
  oCompData.SetFontColor (pComp.Font.Color);
  oCompData.SetFontName (pComp.Font.Name);
  oCompData.SetFontSize (pComp.Font.Size);
  oCompData.SetFontStyle (pComp.Font.Style);
  oCompData.SetFontCharset (pComp.Font.Charset);
  Result := oCompData.GetCompData;
end;

function  TIcForm.GetxpEditCompParams (pComp:TxpEdit):string;
begin
  oCompData.ClearCompData;
  oCompData.SetCompType ('xpEdit');
  oCompData.SetParent (pComp.Parent.Name);
  oCompData.SetTop (pComp.Top);
  oCompData.SetLeft (pComp.Left);
  oCompData.SetHeight (pComp.Height);
  oCompData.SetWidth (pComp.Width);
  oCompData.SetVisible (pComp.Visible);
  oCompData.SetEnabled (pComp.Enabled);
  oCompData.SetReadOnly (pComp.ReadOnly);
  oCompData.SetAnchors (pComp.Anchors);
  oCompData.SetAlignment (pComp.Alignment);
  oCompData.SetAlign (pComp.Align);
  oCompData.SetHint (pComp.Hint);
  oCompData.SetShowHint (pComp.ShowHint);
  oCompData.SetTabOrder (pComp.TabOrder);
  oCompData.SetTabStop (pComp.TabStop);
  oCompData.SetMaxLength (pComp.MaxLength);
  oCompData.SetNumSepar (pComp.NumSepar);
  oCompData.SetFrac (pComp.Frac);
  oCompData.SetEditorType (pComp.EditorType);
  oCompData.SetExtTextShow (pComp.ExtTextShow);
  oCompData.SetSystemColor (pComp.SystemColor);
  oCompData.SetBasicColor (pComp.BasicColor);
  oCompData.SetColor (pComp.Color);
  oCompData.SetInfoField (pComp.InfoField);
  oCompData.SetFontColor (pComp.Font.Color);
  oCompData.SetFontName (pComp.Font.Name);
  oCompData.SetFontSize (pComp.Font.Size);
  oCompData.SetFontStyle (pComp.Font.Style);
  oCompData.SetFontCharset (pComp.Font.Charset);
  Result := oCompData.GetCompData;
end;

function  TIcForm.GetxpLabelCompParams (pComp:TxpLabel):string;
begin
  oCompData.ClearCompData;
  oCompData.SetCompType ('xpLabel');
  oCompData.SetParent (pComp.Parent.Name);
  oCompData.SetTop (pComp.Top);
  oCompData.SetLeft (pComp.Left);
  oCompData.SetHeight (pComp.Height);
  oCompData.SetWidth (pComp.Width);
  oCompData.SetVisible (pComp.Visible);
  oCompData.SetEnabled (pComp.Enabled);
  oCompData.SetAlign (pComp.Align);
  oCompData.SetAlignment (pComp.Alignment);
  oCompData.SetAnchors (pComp.Anchors);
  oCompData.SetAutoSize (pComp.AutoSize);
  oCompData.SetTextLayout (pComp.Layout);
  oCompData.SetHint (pComp.Hint);
  oCompData.SetShowHint (pComp.ShowHint);
  oCompData.SetTransparent (pComp.Transparent);
  oCompData.SetWordWrap (pComp.WordWrap);
  oCompData.SetCaption (pComp.Caption);
  oCompData.SetSystemColor (pComp.SystemColor);
  oCompData.SetColor (pComp.Color);
  oCompData.SetFontColor (pComp.Font.Color);
  oCompData.SetFontName (pComp.Font.Name);
  oCompData.SetFontSize (pComp.Font.Size);
  oCompData.SetFontStyle (pComp.Font.Style);
  oCompData.SetFontCharset (pComp.Font.Charset);
  Result := oCompData.GetCompData;
end;

function  TIcForm.GetxpCheckBoxCompParams (pComp:TxpCheckBox):string;
begin
  oCompData.ClearCompData;
  oCompData.SetCompType ('xpCheckBox');
  oCompData.SetParent (pComp.Parent.Name);
  oCompData.SetTop (pComp.Top);
  oCompData.SetLeft (pComp.Left);
  oCompData.SetHeight (pComp.Height);
  oCompData.SetWidth (pComp.Width);
  oCompData.SetVisible (pComp.Visible);
  oCompData.SetEnabled (pComp.Enabled);
  oCompData.SetAnchors (pComp.Anchors);
  oCompData.SetCaption (pComp.Caption);
  oCompData.SetHint (pComp.Hint);
  oCompData.SetShowHint (pComp.ShowHint);
  oCompData.SetTabOrder (pComp.TabOrder);
  oCompData.SetTabStop (pComp.TabStop);
  oCompData.SetSystemColor (pComp.SystemColor);
  oCompData.SetBasicColor (pComp.BasicColor);
  oCompData.SetCheckColor (pComp.CheckColor);
  oCompData.SetFontColor (pComp.Font.Color);
  oCompData.SetFontName (pComp.Font.Name);
  oCompData.SetFontSize (pComp.Font.Size);
  oCompData.SetFontStyle (pComp.Font.Style);
  oCompData.SetFontCharset (pComp.Font.Charset);
  Result := oCompData.GetCompData;
end;

function  TIcForm.GetxpComboBoxCompParams (pComp:TxpComboBox):string;
begin
  oCompData.ClearCompData;
  oCompData.SetCompType ('xpComboBox');
  oCompData.SetParent (pComp.Parent.Name);
  oCompData.SetTop (pComp.Top);
  oCompData.SetLeft (pComp.Left);
  oCompData.SetHeight (pComp.Height);
  oCompData.SetWidth (pComp.Width);
  oCompData.SetVisible (pComp.Visible);
  oCompData.SetEnabled (pComp.Enabled);
  oCompData.SetAnchors (pComp.Anchors);
  oCompData.SetHint (pComp.Hint);
  oCompData.SetShowHint (pComp.ShowHint);
  oCompData.SetTabOrder (pComp.TabOrder);
  oCompData.SetTabStop (pComp.TabStop);
  oCompData.SetLines (pComp.Items.Text);
  oCompData.SetMaxLength (pComp.MaxLength);
  oCompData.SetSystemColor (pComp.SystemColor);
  oCompData.SetBasicColor (pComp.BasicColor);
  oCompData.SetColor (pComp.Color);
  oCompData.SetFontColor (pComp.Font.Color);
  oCompData.SetFontName (pComp.Font.Name);
  oCompData.SetFontSize (pComp.Font.Size);
  oCompData.SetFontStyle (pComp.Font.Style);
  oCompData.SetFontCharset (pComp.Font.Charset);
  Result := oCompData.GetCompData;
end;

function  TIcForm.GetxpRadioButtonCompParams (pComp:TxpRadioButton):string;
begin
  oCompData.ClearCompData;
  oCompData.SetCompType ('xpRadioButton');
  oCompData.SetParent (pComp.Parent.Name);
  oCompData.SetTop (pComp.Top);
  oCompData.SetLeft (pComp.Left);
  oCompData.SetHeight (pComp.Height);
  oCompData.SetWidth (pComp.Width);
  oCompData.SetVisible (pComp.Visible);
  oCompData.SetEnabled (pComp.Enabled);
  oCompData.SetAnchors (pComp.Anchors);
  oCompData.SetCaption (pComp.Caption);
  oCompData.SetHint (pComp.Hint);
  oCompData.SetShowHint (pComp.ShowHint);
  oCompData.SetTabOrder (pComp.TabOrder);
  oCompData.SetTabStop (pComp.TabStop);
  oCompData.SetSystemColor (pComp.SystemColor);
  oCompData.SetBasicColor (pComp.BasicColor);
  oCompData.SetCheckColor (pComp.CheckColor);
  oCompData.SetFontColor (pComp.Font.Color);
  oCompData.SetFontName (pComp.Font.Name);
  oCompData.SetFontSize (pComp.Font.Size);
  oCompData.SetFontStyle (pComp.Font.Style);
  oCompData.SetFontCharset (pComp.Font.Charset);
  Result := oCompData.GetCompData;
end;

function  TIcForm.GetxpMemoCompParams (pComp:TxpMemo):string;
begin
  oCompData.ClearCompData;
  oCompData.SetCompType ('xpMemo');
  oCompData.SetParent (pComp.Parent.Name);
  oCompData.SetTop (pComp.Top);
  oCompData.SetLeft (pComp.Left);
  oCompData.SetHeight (pComp.Height);
  oCompData.SetWidth (pComp.Width);
  oCompData.SetVisible (pComp.Visible);
  oCompData.SetEnabled (pComp.Enabled);
  oCompData.SetReadOnly (pComp.ReadOnly);
  oCompData.SetAlign (pComp.Align);
  oCompData.SetAlignment (pComp.Alignment);
  oCompData.SetAnchors (pComp.Anchors);
  oCompData.SetHint (pComp.Hint);
  oCompData.SetShowHint (pComp.ShowHint);
  oCompData.SetTabOrder (pComp.TabOrder);
  oCompData.SetTabStop (pComp.TabStop);
  oCompData.SetLines (pComp.Lines.Text);
  oCompData.SetMaxLength (pComp.MaxLength);
  oCompData.SetWordWrap (pComp.WordWrap);
  oCompData.SetSystemColor (pComp.SystemColor);
  oCompData.SetBasicColor (pComp.BasicColor);
  oCompData.SetColor (pComp.Color);
  oCompData.SetFontColor (pComp.Font.Color);
  oCompData.SetFontName (pComp.Font.Name);
  oCompData.SetFontSize (pComp.Font.Size);
  oCompData.SetFontStyle (pComp.Font.Style);
  oCompData.SetFontCharset (pComp.Font.Charset);
  Result := oCompData.GetCompData;
end;

function  TIcForm.GetxpRichEditCompParams (pComp:TxpRichEdit):string;
begin
  oCompData.ClearCompData;
  oCompData.SetCompType ('xpRichEdit');
  oCompData.SetParent (pComp.Parent.Name);
  oCompData.SetTop (pComp.Top);
  oCompData.SetLeft (pComp.Left);
  oCompData.SetHeight (pComp.Height);
  oCompData.SetWidth (pComp.Width);
  oCompData.SetVisible (pComp.Visible);
  oCompData.SetEnabled (pComp.Enabled);
  oCompData.SetReadOnly (pComp.ReadOnly);
  oCompData.SetAlign (pComp.Align);
  oCompData.SetAlignment (pComp.Alignment);
  oCompData.SetAnchors (pComp.Anchors);
  oCompData.SetHint (pComp.Hint);
  oCompData.SetShowHint (pComp.ShowHint);
  oCompData.SetTabOrder (pComp.TabOrder);
  oCompData.SetTabStop (pComp.TabStop);
  oCompData.SetLines (pComp.Lines.Text);
  oCompData.SetMaxLength (pComp.MaxLength);
  oCompData.SetWordWrap (pComp.WordWrap);
  oCompData.SetSystemColor (pComp.SystemColor);
  oCompData.SetBasicColor (pComp.BasicColor);
  oCompData.SetColor (pComp.Color);
  oCompData.SetFontColor (pComp.Font.Color);
  oCompData.SetFontName (pComp.Font.Name);
  oCompData.SetFontSize (pComp.Font.Size);
  oCompData.SetFontStyle (pComp.Font.Style);
  oCompData.SetFontCharset (pComp.Font.Charset);
  Result := oCompData.GetCompData;
end;

function  TIcForm.GetxpStatusLineCompParams (pComp:TxpStatusLine):string;
begin
  oCompData.ClearCompData;
  oCompData.SetCompType ('xpStatusLine');
  oCompData.SetParent (pComp.Parent.Name);
  oCompData.SetVisible (pComp.Visible);
  Result := oCompData.GetCompData;
end;

function  TIcForm.GetBasicCompParams (pComp:TControl):string;
begin
  oCompData.ClearCompData;
  oCompData.SetCompType ('Basic');
  oCompData.SetParent (pComp.Parent.Name);
  oCompData.SetTop (pComp.Top);
  oCompData.SetLeft (pComp.Left);
  oCompData.SetHeight (pComp.Height);
  oCompData.SetWidth (pComp.Width);
  oCompData.SetVisible (pComp.Visible);
  oCompData.SetAlign (pComp.Align);
  Result := oCompData.GetCompData;
end;

procedure TIcForm.DesignerForm;
var mDesign:TF_DsgnForm;
begin
  mDesign := TF_DsgnForm.Create(Self);
  mDesign.FileName := gPath.LngPath+Name;
  mDesign.FormNum := oFormNum;
  mDesign.Execute;
  FreeAndNil (mDesign);
  LoadFormData(oFormNum);
  FillPopupMenu;
end;

procedure TIcForm.WriteDefForm;
var mIni:TEncodeIniFile; mFile:string; mSave:boolean;
begin
  mFile := gPath.LngPath+Name+'.SFD';
  mIni := TEncodeIniFile.Create(mFile,FALSE);
  mSave := not mIni.SectionExists(StrInt (255,0));
  If not mSave then mSave := mIni.ReadBool('SYSTEM','SaveDefault',FALSE);
  FreeAndNil (mIni);
  If mSave then begin
    SaveFormData (255);
    mIni := TEncodeIniFile.Create(mFile,FALSE);
    mIni.WriteString('List',StrInt (255,0), 'SystÈmov˝ formul·r;'+StrInt (10,0));
    mIni.Encode := FALSE;
    mIni.WriteBool('SYSTEM','SaveDefault',FALSE);
    FreeAndNil (mIni);
  end;
end;

procedure TIcForm.SaveFormPos;
var mIni:TEncodeIniFile; mS,mPrev:string;
begin
  mIni := TEncodeIniFile.Create(gPath.LngPath+gvSys.LoginName+'.SET',FALSE);
  mIni.Encode := FALSE;
  mS := StrInt (Left,0)+','+StrInt (Top,0)+','+StrInt (Width,0)+','
        +StrInt (Height,0)+','+cPrgVer+','+ConvWindowStateToStr(WindowState)+','
        +StrInt (oFormNum,0)+','+oColorScheme;
  mPrev := mIni.ReadString ('FORMS',Name,'');
  If mPrev<>mS then mIni.WriteString('FORMS',Name,mS);
  FreeAndNil (mIni);
end;

function  TIcForm.LoadFormPos (var pLeft,pTop,pWidth,pHeight:longint;var pWindowState:TWindowState):boolean;
var mIni:TEncodeIniFile; mS:string;
begin
  oFormNum := 0;
  mIni := TEncodeIniFile.Create(gPath.LngPath+gvSys.LoginName+'.SET',FALSE);
  mIni.Encode := FALSE;
  mS := mIni.ReadString ('FORMS',Name,'');
  Result := (mS<>'');
  If mS<>'' then begin
    pLeft := ValInt (LineElement(mS,0,','));
    pTop := ValInt (LineElement(mS,1,','));
    pWidth := ValInt (LineElement(mS,2,','));
    pHeight := ValInt (LineElement(mS,3,','));
    pWindowState := ConvStrToWindowState(LineElement(mS,5,','));
    oFormNum := ValInt (LineElement(mS,6,','));
    oColorScheme := LineElement(mS,7,',');
  end;
  FreeAndNil (mIni);
end;

procedure TIcForm.FillPopupMenu;
var mIni:TEncodeIniFile; mSect:TStringList; mName:string; I,mNum,mLevel:longint;
    SysMenu:HMenu;
begin
  oPopup.Items.Clear;
  mSect := TStringList.Create;
  mIni := TEncodeIniFile.Create(GetFormDefFileName(gPath.LngPath+Name,0),FALSE);
  mIni.ReadSectionValues('List',mSect);
  FreeAndNil (mIni);
  If mSect.Count>0 then begin
    mSect.Sort;
    For I:=0 to mSect.Count-1 do begin
      mNum := ValInt (LineElement (mSect.Strings[I],0,'='));
      mName := LineElement (mSect.Strings[I],1,'=');
      mLevel := ValInt (LineElement (mName,1,';'));
      mName := LineElement (mName,0,';');
      If mLevel<=cUserFormLevel then oPopup.Items.Add(NewItem (StrInt (mNum,0)+' '+mName,0,FALSE,TRUE,nil,0,'Form'+StrInt(mNum,0)));
    end;
  end;
  mSect.Clear;
  mIni := TEncodeIniFile.Create(GetFormDefFileName(gPath.LngPath+Name,100),FALSE);
  mIni.ReadSectionValues('List',mSect);
  FreeAndNil (mIni);
  If mSect.Count>0 then begin
    mSect.Sort;
    For I:=0 to mSect.Count-1 do begin
      mNum := ValInt (LineElement (mSect.Strings[I],0,'='));
      mName := LineElement (mSect.Strings[I],1,'=');
      mLevel := ValInt (LineElement (mName,1,';'));
      mName := LineElement (mName,0,';');
      If mLevel<=cUserFormLevel then oPopup.Items.Add(NewItem (StrInt (mNum,0)+' '+mName,0,FALSE,TRUE,nil,0,'Form'+StrInt(mNum,0)));
    end;
  end;
  FreeAndNil (mSect);
  CheckFormMenuItem;
  SysMenu := GetSystemMenu(Handle, FALSE);
  RemoveMenu(SysMenu,oPopup.Handle,MF_BYCOMMAND);
  RemoveMenu(SysMenu,WM_USER+4,MF_BYCOMMAND);
  If oPopup.Items.Count>1 then begin
    AppendMenu(SysMenu, MF_SEPARATOR, WM_USER+4, '') ;
    AppendMenu(SysMenu, MF_POPUP, oPopup.Handle, 'NaËÌtaù formul·r') ;
  end;
end;

procedure TIcForm.CheckFormMenuItem;
var I:longint;
begin
  If oPopup.Items.Count>0 then begin
    For I:=0 to oPopup.Items.Count-1 do
      oPopup.Items[I].Checked := ValInt (Copy (oPopup.Items[I].Caption,1,Pos (' ',oPopup.Items[I].Caption)-1))=oFormNum;
  end;
end;

constructor TIcForm.Create(AOwner: TComponent);
begin
  inherited;
  oFormNum := 0;
  oAccept := False;
  oCompData :=TCompData.Create;
  oSaveDefForm := FALSE;
  oTabOrders := TStringList.Create;
  oColorScheme := '';
  oEnableDesigner := TRUE;
end;

constructor TIcForm.CreateType(AOwner: TComponent;pFormType:byte);
begin
  inherited Create (AOwner);
  oFormNum := pFormType;
end;

destructor  TIcForm.Destroy;
begin
  FreeAndNil (oTabOrders);
  FreeAndNil(oCompData);
  inherited;
end;

// TMoveForm
procedure TMoveForm.WMMove(var Message: TMessage) ;
begin
  inherited;
  OnResize (Self);
end;

constructor TMoveForm.Create(AOwner: TComponent);
begin
  GlobalNameSpace.BeginWrite;
  try
    inherited CreateNew(AOwner);
  // resource-locating-loading part skipped
  finally
    GlobalNameSpace.EndWrite;
  end;
end;

end.
