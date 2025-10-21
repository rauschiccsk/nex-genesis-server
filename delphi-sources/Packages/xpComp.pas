unit xpComp;

interface

  uses
    BaseUtils, DB, Consts, Grids,
    Menus, DesignIntf, DesignEditors, TypInfo, ExtCtrls, ComCtrls, ActnList,
    StdCtrls, Controls, Forms, Classes, Messages, Windows, SysUtils, Graphics;

  const
    cUniMultiSelect:boolean = FALSE;

    BorderStyles: array[TBorderStyle] of DWORD = (0, WS_BORDER);
    crcRadius : Byte = 3;

  crSystemHand : TCursor = 10;
  cTitleButtonSize : Integer = 20;
  cCornerRadius : Integer = 10;
  wmNCPaintOnlyBorder : LongInt = 666;

    TCM_FIRST               = $1300;      { Tab control messages }
    TCM_SETIMAGELIST       = TCM_FIRST + 3;
    TCM_SETITEMA             = TCM_FIRST + 6;
    TCM_ADJUSTRECT         = TCM_FIRST + 40;
    TCM_GETITEMRECT        = TCM_FIRST + 10;
    TCM_GETCURSEL          = TCM_FIRST + 11;
    TCM_HITTEST            = TCM_FIRST + 13;
    TCS_TABS              = $0000;
    TCS_BUTTONS           = $0100;
    TCS_FLATBUTTONS       = $0008;
    TCS_OWNERDRAWFIXED    = $2000;
    TCS_BOTTOM            = $0002;
    TCS_VERTICAL          = $0080;
    TCS_RIGHT             = $0002;
    TCIF_IMAGE      = $0002;

    TCM_SETITEM             = TCM_SETITEMA;

  {$EXTERNALSYM SBARS_SIZEGRIP}
  SBARS_SIZEGRIP          = $0100;
  {$EXTERNALSYM CCS_TOP}
  CCS_TOP                 = $00000001;
  {$EXTERNALSYM ICC_BAR_CLASSES}
  ICC_BAR_CLASSES        = $00000004; // toolbar, statusbar, trackbar, tooltips
  {$EXTERNALSYM STATUSCLASSNAME}
  STATUSCLASSNAME = 'msctls_statusbar32';
  {$EXTERNALSYM CCM_FIRST}
  CCM_FIRST               = $2000;      { Common control shared messages }
  {$EXTERNALSYM CCM_SETBKCOLOR}
  CCM_SETBKCOLOR          = CCM_FIRST + 1; // lParam is bkColor
  {$EXTERNALSYM SB_SETBKCOLOR}
  SB_SETBKCOLOR            = CCM_SETBKCOLOR;      // lParam = bkColor
  {$EXTERNALSYM SB_SETTEXTA}
  SB_SETTEXTA             = WM_USER+1;
  {$EXTERNALSYM SB_SETTEXT}
  SB_SETTEXT             = SB_SETTEXTA;
  {$EXTERNALSYM SB_SIMPLE}
  SB_SIMPLE               = WM_USER+9;
  {$EXTERNALSYM SBT_RTLREADING}
  SBT_RTLREADING           = $0400;
  {$EXTERNALSYM SB_GETRECT}
  SB_GETRECT              = WM_USER + 10;
  {$EXTERNALSYM SBT_NOBORDERS}
  SBT_NOBORDERS            = $0100;
  {$EXTERNALSYM SBT_POPOUT}
  SBT_POPOUT               = $0200;
  {$EXTERNALSYM SBT_OWNERDRAW}
  SBT_OWNERDRAW            = $1000;
  {$EXTERNALSYM SB_SETPARTS}
  SB_SETPARTS             = WM_USER+4;

  {$EXTERNALSYM PGM_FIRST}
  PGM_FIRST               = $1400;      { Pager control messages }
  {$EXTERNALSYM PGM_SETBORDER}
  PGM_SETBORDER              = PGM_FIRST + 6;
  {$EXTERNALSYM PGM_GETBORDER}
  PGM_GETBORDER              = PGM_FIRST + 7;

  type
    TEditCharCase = (ecNormal, ecUpperCase, ecLowerCase);
    TEditorType = (etString, etFloat, etInteger, etDate, etTime, etDateTime);
    TButtonLayout = (blGlyphLeft, blGlyphRight, blGlyphTop, blGlyphBottom);
    TAlignText = (atLeft, atCenter, atRight);

    TFillDirection = (fdTopToBottom, fdBottomToTop, fdLeftToRight, fdRightToLeft, fdVerticalFromCenter, fdHorizFromCenter, fdXP, fdDown);

    TSelection = record
      StartPos, EndPos: Integer;
    end;

    TStringListProperty = class(TStringProperty)
    public
      function GetAttributes: TPropertyAttributes; override;
      procedure GetValueList(List: TStrings); virtual;
      procedure GetValues(Proc: TGetStrProc); override;
    end;

    TFieldNameProperty = class(TStringListProperty)
    public
      procedure GetValueList(List: TStrings); override;
    end;

    TxpPageControlEditor = class(TDefaultEditor)
      procedure ExecuteVerb(Index: Integer); override;
      function GetVerb(Index: Integer): string; override;
      function GetVerbCount: Integer; override;
    end;

    TDataTable = class(TDataSource)
    private
      FAutoUpdate: boolean;
      FldList: TStringList;
    public
      constructor Create(AOwner: TComponent); override;
      destructor Destroy; override;

      procedure ClearData;
      procedure ReadData;
      procedure SaveData;
      procedure AddField (pField:string);

    published
      property AutoUpdate: Boolean read FAutoUpdate write FAutoUpdate;
    end;

//TColorStringGrid

  TDrawColorCellEvent = procedure (Sender: TObject; ACol, ARow: Longint; ARect: TRect;AState: TGridDrawState; var pColor:TColor) of object;

  TColorStringGrid = class (TStringGrid)
    private
     eDrawColorCell: TDrawColorCellEvent;
    protected
      procedure DrawCell(ACol, ARow: Longint; ARect: TRect;AState: TGridDrawState); override;
    published
      property    OnDrawColorCell: TDrawColorCellEvent read eDrawColorCell write eDrawColorCell;
  end;


// TxpEditColors
    TxpEdit = class;

    TxpEditColors = class (TPersistent)
    private
      FChanged    : boolean;
      FBGNormal   : TColor;
      FBGReadOnly : TColor;
      FBGInfoField: TColor;
      FBGActive   : TColor;
      FBGModify   : TColor;
      FBGExtText  : TColor;
      FInactBorder: TColor;
      FActBorder  : TColor;

      procedure SetBGNormal (AValue:TColor);
      procedure SetBGReadOnly (AValue:TColor);
      procedure SetBGInfoField (AValue:TColor);
      procedure SetBGActive (AValue:TColor);
      procedure SetBGModify (AValue:TColor);
      procedure SetBGExtText (AValue:TColor);
      procedure SetInactBorder (AValue:TColor);
      procedure SetActBorder (AValue:TColor);
    public
      constructor Create;
    published
      property Changed:boolean read FCHanged write FChanged;
      property BGNormal:TColor read FBGNormal write SetBGNormal;
      property BGReadOnly:TColor read FBGReadOnly write SetBGReadOnly;
      property BGInfoField:TColor read FBGInfoField write SetBGInfoField;
      property BGActive:TColor read FBGActive write SetBGActive;
      property BGModify:TColor read FBGModify write SetBGModify;
      property BGExtText:TColor read FBGExtText write SetBGExtText;
      property InactBorder:TColor read FInactBorder write SetInactBorder;
      property ActBorder:TColor read FActBorder write SetActBorder;
    end;

// TxpEdit
    TxpEdit = class(TWinControl)
    private
      FMaxLength: Integer;
      FPasswordChar: Char;
      FReadOnly: Boolean;
      FAutoSelect: Boolean;
      FHideSelection: Boolean;
      FOEMConvert: Boolean;
      FCharCase: TEditCharCase;
      FCreating: Boolean;
      FModified: Boolean;
      FOnChange: TNotifyEvent;
      FOnModified: TNotifyEvent;

      FActive  : Boolean;
      FFocused : Boolean;
      FRoundRadius : Integer;
      FRounded : Boolean;
      FMarginLeft : Word;
      FMarginRight : Word;
      FAlignment : TAlignment;
      FEditorType: TEditorType;
      FFrac      : longint;
      FInteger   : longint;
      FFloat     : double;
      FDateTime  : TDateTime;
      FAutoFieldSet: boolean;
      FDataSource: TDataSource;
      FFieldName : string;
      FAutoCR    : boolean;
      FVerifyDate  : boolean;
      FNumSepar  : boolean;

      FOldValue  : string;

      FExtTextShow: boolean;
      FExtText   : string;
      FExtFieldName: string;
      FExtMargin : word;
      FInfoField : boolean;

      FSystemColor: boolean;
      FEditColors :TxpEditColors;
      oBasicColor : TColor;

      procedure PaintExtText;
      procedure DataConvert2;
      procedure DataConvert;
      procedure DataConvertToText;
      function  GetModified: Boolean;
      function  GetCanUndo: Boolean;
      procedure SetCharCase(Value: TEditCharCase);
      procedure SetHideSelection(Value: Boolean);
      procedure SetMaxLength(Value: Integer);
      procedure SetModified(Value: Boolean);
      procedure SetOEMConvert(Value: Boolean);
      procedure SetPasswordChar(Value: Char);
      procedure SetReadOnly(Value: Boolean);
      procedure SetSelText(const Value: string);
      procedure WMSetFont(var Message: TWMSetFont); message WM_SETFONT;
      procedure CMEnter(var Message: TCMGotFocus); message CM_ENTER;
      procedure CMExit(var Message: TCMExit); message CM_EXIT;
      procedure CNCommand(var Message: TWMCommand); message CN_COMMAND;
      procedure CMTextChanged(var Message: TMessage); message CM_TEXTCHANGED;
      procedure WMContextMenu(var Message: TWMContextMenu); message WM_CONTEXTMENU;

      procedure SetRounded (AValue : Boolean);
      procedure SetRoundRadius (AValue : Integer);
      procedure SetShape (ARounded : Boolean);
      procedure SetMarginLeft (AValue : Word);
      procedure SetMarginRight (AValue : Word);
      procedure SetAlignment (AValue : TAlignment);
      procedure SetEditorType (AValue: TEditorType);
      procedure SetFrac (AValue:longint);
      procedure SetAsInteger (AValue:longint);
      procedure SetAsFloat (AValue:double);
      procedure SetAsDateTime (AValue:TDateTime);
      function  GetDataSource:TDataSource;
      procedure SetDataSource (AValue:TDataSource);
      function  GetFieldName:string;
      procedure SetFieldName (AValue:string);

      procedure SetFieldSize;
      procedure SetFieldType;

      procedure SetAutoFieldSet (AValue:boolean);
      procedure SetExtTextShow (AValue:boolean);
      procedure SetExtText(AValue:string);
      procedure SetExtFieldName (AValue:string);
      procedure SetExtMargin (AValue:word);
      procedure SetExtTextDef;
      procedure SetEditColors (AValue:TxpEditColors);
      procedure SetInfoField (AValue:boolean);
      function  GetAsString:string;
      procedure SetAsString (AValue:string);
      procedure SetBasicColor (pValue:TColor);

      procedure RefreshSystemColor;
    protected
      procedure Change; dynamic;
      procedure CreateParams(var Params: TCreateParams); override;
      procedure CreateWindowHandle(const Params: TCreateParams); override;
      procedure CreateWnd; override;
      procedure DestroyWnd; override;
      procedure DoSetMaxLength(Value: Integer); virtual;
      function  GetSelLength: Integer; virtual;
      function  GetSelStart: Integer; virtual;
      function  GetSelText: string; virtual;
      procedure SetSelLength(Value: Integer); virtual;
      procedure SetSelStart(Value: Integer); virtual;

      procedure WMPaint(var Message: TWMPaint); message WM_PAINT;
      procedure WMNCPaint (var Message : TWMNCPaint); message WM_NCPAINT;
      procedure WMNCCalcSize (var Message : TWMNCCalcSize); message WM_NCCALCSIZE;
      procedure MouseEnter (var Message : TMessage); message CM_MOUSEENTER;
      procedure MouseLeave (var Message : TMessage); message CM_MOUSELEAVE;
      procedure WMSize(var Message: TWMSize); message WM_SIZE;
      procedure KeyDown(var Key: Word; Shift: TShiftState); override;
      procedure KeyUp(var Key: Word; Shift: TShiftState); override;

      procedure Loaded; override;
      procedure SetEditRect;
    public
      constructor Create(AOwner: TComponent); override;
      destructor Destroy; override;
      procedure Clear; virtual;
      procedure ShowEditorData;

      procedure ClearSelection;
      procedure CopyToClipboard;
      procedure CutToClipboard;
      procedure DefaultHandler(var Message); override;
      procedure PasteFromClipboard;
      procedure Undo;
      procedure ClearUndo;
      function GetSelTextBuf(Buffer: PChar; BufSize: Integer): Integer; virtual;
      procedure SelectAll;
      procedure SetSelTextBuf(Buffer: PChar);
      procedure NoModified;

      property CanUndo: Boolean read GetCanUndo;
      property Modified: Boolean read GetModified write SetModified;
      property SelLength: Integer read GetSelLength write SetSelLength;
      property SelStart: Integer read GetSelStart write SetSelStart;
      property SelText: string read GetSelText write SetSelText;
    published
      property NumSepar:boolean read FNumSepar write FNumSepar;
      property AsString:string read GetAsString write SetAsString;
      property SystemColor:boolean read FSystemColor write FSystemColor;
      property EditColors:TxpEditColors read FEditColors write SetEditColors;
      property BasicColor: TColor read oBasicColor write SetBasicColor;
      property Rounded : Boolean read FRounded write SetRounded default FALSE;
      property RoundRadius : Integer read FRoundRadius write SetRoundRadius;
      property MarginLeft : Word read FMarginLeft write SetMarginLeft;
      property MarginRight : Word read FMarginRight write SetMarginRight;
      property Alignment : TAlignment read FAlignment write SetAlignment;
      property EditorType:TEditorType read FEditorType write SetEditorType;
      property Frac:longint read FFrac write SetFrac;
      property AsInteger:longint read FInteger write SetAsInteger;
      property AsFloat:double read FFloat write SetAsFloat;
      property AsDateTime:TDateTime read FDateTime write SetAsDateTime;
      property AutoFieldSet:boolean read FAutoFieldSet write SetAutoFieldSet;
      property DataSource:TDataSource read GetDataSource write SetDataSource;
      property FieldName:string read GetFieldName write SetFieldName;
      property AutoCR:boolean read FAutoCR write FAutoCR;
      property ExtTextShow:boolean read FExtTextShow write SetExtTextShow;
      property ExtMargin:word read FExtMargin write SetExtMargin;
      property ExtText:string read FExtText write SetExtText;
      property ExtFieldName:string read FExtFieldName write SetExtFieldName;
      property InfoField:boolean read FInfoField write SetInfoField;

      property AutoSelect: Boolean read FAutoSelect write FAutoSelect default TRUE;
      property CharCase: TEditCharCase read FCharCase write SetCharCase default ecNormal;
      property HideSelection: Boolean read FHideSelection write SetHideSelection default TRUE;
      property MaxLength: Integer read FMaxLength write SetMaxLength default 0;
      property OEMConvert: Boolean read FOEMConvert write SetOEMConvert default FALSE;
      property PasswordChar: Char read FPasswordChar write SetPasswordChar default #0;
      property ReadOnly: Boolean read FReadOnly write SetReadOnly default FALSE;
      property PVerifyDate: Boolean read FVerifyDate write FVerifyDate default TRUE;
      property OldValue: string read FOldValue;
      property Align;
      property Anchors;
      property Color;
      property Constraints;
      property Enabled;
      property Font;
      property ParentColor default FALSE;
      property ParentFont;
      property ParentShowHint;
      property PopupMenu;
      property ShowHint;
      property TabOrder;
      property TabStop default TRUE;
      property Visible;
      property Text;
      property OnChange: TNotifyEvent read FOnChange write FOnChange;
      property OnModified: TNotifyEvent read FOnModified write FOnModified;
      property OnClick;
      property OnContextPopup;
      property OnDblClick;
      property OnDragDrop;
      property OnDragOver;
      property OnEndDock;
      property OnEndDrag;
      property OnEnter;
      property OnExit;
      property OnKeyDown;
      property OnKeyPress;
      property OnKeyUp;
      property OnMouseDown;
      property OnMouseMove;
      property OnMouseUp;
      property OnStartDock;
      property OnStartDrag;
    end;

//TxpLabel

  TxpLabel = class(TCustomLabel)
  private
    FDataSource: TDataSource;
    FFieldName : string;

    FSystemColor: boolean;

    function  GetDataSource:TDataSource;
    procedure SetDataSource (AValue:TDataSource);
    function  GetFieldName:string;
    procedure SetFieldName (Value:string);
  published
    property SystemColor:boolean read FSystemColor write FSystemColor;
    property DataSource:TDataSource read GetDataSource write SetDataSource;
    property FieldName:string read GetFieldName write SetFieldName;

    property Align;
    property Alignment;
    property Anchors;
    property AutoSize;
    property Caption;
    property Color;
    property Constraints;
    property Enabled;
    property FocusControl;
    property Font;
    property ParentColor;
    property ParentFont;
    property ParentShowHint;
    property PopupMenu;
    property ShowHint;
    property Transparent;
    property Layout;
    property Visible;
    property WordWrap;
    property OnClick;
    property OnContextPopup;
    property OnDblClick;
    property OnDragDrop;
    property OnDragOver;
    property OnEndDock;
    property OnEndDrag;
    property OnMouseDown;
    property OnMouseMove;
    property OnMouseUp;
    property OnMouseEnter;
    property OnMouseLeave;
    property OnStartDock;
    property OnStartDrag;
  end;

  TButtColors =  record
    ActBorder       : TColor;
    BackGroud       : TColor;
    ButtonFrameTop  : TColor;
    ButtonFrame     : TColor;
    ButtonFrameBot  : TColor;
    ButtonGradBeg   : TColor;
    ButtonGradEnd   : TColor;
    ButtonFont      : TColor;
    ButtonFontShad  : TColor;
    ButtonFontDis   : TColor;
    ButtonSelected  : TColor;
    ButtonBorderDis : TColor;
    ButtonDis       : TColor;
  end;

// TxpBitBtn
  TxpBitBtn = class(TCustomControl)
  private
    FCaption : TCaption;
    FActive  : Boolean;
    FEnabled : Boolean;
    FFont    : TFont;
    FFocused : Boolean;
    FModalResult : TModalResult;
    FHotKey  : Char;
    FCancel  : Boolean;
    FDefault : Boolean;

    FOnClick : TNotifyEvent;
    FOnRClick: TNotifyEvent;
    FOnEnter : TNotifyEvent;
    FOnExit  : TNotifyEvent;
    FOnKeyDown : TKeyEvent;
    FOnKeyUp : TKeyEvent;

    FGlyph   : TBitmap;
    FMonoGlyph : TBitmap;

    FImageList : TImageList;
    FImageIndex: Integer;

    FMarginLeft : word;
    FMarginRight: word;
    FMarginTop  : word;
    FMarginBottom: word;
    FGlyphSpace : word;
    FLineSpace  : word;
    FLayout     : TButtonLayout;
    FAlignText  : TAlignText;
    FGroupIndex : word;
    FDown       : boolean;
    FSystemColor: boolean;
    oBasicColor : TColor;
    oButColors  : TButtColors;
    oFocusWhenClick: boolean; //TRUE - pri kliknutÌ s myöou nastavÌ fokus na tlaËÌtko
    oMouseDown  : boolean;

    procedure SetCaption (ACaption : TCaption);
    function  GetCaption : TCaption;
    procedure SetFont (AFont : TFont);
    function  GetFont : TFont;
    procedure OnFontChange (Sender : TObject);
    procedure SetModalResult (AModalResult : TModalResult);
    function  GetModalResult : TModalResult;
    procedure SetEnabled (AEnabled : Boolean);
    procedure SetGlyph (AGlyph : TBitmap);
    function  GetGlyph : TBitmap;
    procedure SetImageList (AList : TImageList);
    function GetImageList : TImageList;
    procedure SetImageIndex (AIndex : Integer);
    function GetImageIndex : Integer;

    procedure SetMarginLeft (AValue : Word);
    procedure SetMarginRight (AValue : Word);
    procedure SetMarginTop (AValue : Word);
    procedure SetMarginBottom (AValue : Word);
    procedure SetGlyphSpace (AValue : Word);
    procedure SetLineSpace (AValue : Word);
    procedure SetLayout (AValue : TButtonLayout);
    procedure SetAlignText (AValue : TAlignText);
    procedure SetDown (AValue : Boolean);
    procedure SetGroupIndex (AValue : word);
    procedure SetBasicColor (pColor:TColor);

    procedure FOnButtonClick;
    procedure FOnButtonRClick;

    procedure SwitchOffButtons;
    procedure RefreshSystemColor;
  protected
    procedure Paint; override;
    procedure MouseEnter (var Message : TMessage); message CM_MOUSEENTER;
    procedure MouseLeave (var Message : TMessage); message CM_MOUSELEAVE;
    procedure LMouseDown  (var Message : TMessage); message WM_LBUTTONDOWN;
    procedure RMouseDown  (var Message : TMessage); message WM_RBUTTONDOWN;
    procedure LMouseUp  (var Message : TMessage); message WM_LBUTTONUP;
    procedure RMouseUp  (var Message : TMessage); message WM_RBUTTONUP;
    procedure LMouseDblClick  (var Message : TMessage); message WM_LBUTTONDBLCLK;
    procedure CMEnter(var Message: TCMGotFocus); message CM_ENTER;
    procedure CMExit(var Message: TCMLostFocus); message CM_EXIT;
    procedure WMSetFocus(var Message: TMessage); message WM_SETFOCUS;
    procedure WMKillFocus(var Message: TMessage); message WM_KILLFOCUS;
    procedure WMKeyDown(var Message: TMessage); message WM_KEYDOWN;
    procedure WMKeyUp(var Message: TMessage); message WM_KEYUP;
    procedure CMDialogChar(var Message : TCMDialogChar);  message CM_DIALOGCHAR;
    procedure CMDialogKey(var Message : TCMDialogKey);  message CM_DIALOGKEY;

    procedure Loaded; override;

  public
    constructor Create (AOwner : TComponent); override;
    destructor Destroy; override;
  published
    property SystemColor:boolean read FSystemColor write FSystemColor;
    property Action;
    property Anchors;
    property Caption : TCaption read GetCaption write SetCaption;
    property Font : TFont read GetFont write SetFont;
    property Glyph : TBitmap read GetGlyph write SetGlyph;
    property ImageList : TImageList read GetImageList write SetImageList;
    property ImageIndex : Integer read GetImageIndex write SetImageIndex default -1;
    property Enabled read FENabled write SetEnabled;
    property ParentFont;
    property Hint;
    property ShowHint;
    property TabOrder;
    property TabStop default TRUE;
    property Visible;
    property DragCursor;
    property DragMode;
    property Align;

    property BasicColor  : TColor read oBasicColor write SetBasicColor;
    property MarginLeft  : Word read FMarginLeft write SetMarginLeft;
    property MarginRight : Word read FMarginRight write SetMarginRight;
    property MarginTop   : Word read FMarginTop write SetMarginTop;
    property MarginBottom: Word read FMarginBottom write SetMarginBottom;
    property GlyphSpace  : Word read FGlyphSpace write SetGlyphSpace;
    property LineSpace   : Word read FLineSpace write SetLineSpace;

    property Layout : TButtonLayout read FLayout write SetLayout;
    property AlignText: TAlignText read FAlignText write SetAlignText;

    property Down:boolean read FDown write SetDown;
    property GroupIndex:word read FGroupIndex write SetGroupIndex;

    property FocusWhenClick:boolean read oFocusWhenClick write oFocusWhenClick;

    property Cancel : Boolean read FCancel write FCancel default FALSE;
    property Default : Boolean read FDefault write FDefault default FALSE;
    property ModalResult : TModalResult read GetModalResult write SetModalResult default mrNone;
    property OnClick: TNotifyEvent read FOnClick write FOnClick;
    property OnRClick: TNotifyEvent read FOnRClick write FOnRClick;
    property OnEnter: TNotifyEvent read FOnEnter write FOnEnter;
    property OnExit: TNotifyEvent read FOnExit write FOnExit;
    property OnDragDrop;
    property OnDragOver;
    property OnStartDrag;
    property OnEndDrag;
    property OnMouseDown;
    property OnMouseUp;
    property OnMouseMove;
  end;

// TxpCheckBox
  TxpCheckBox = class(TCustomControl)
  private
    FCaption : TCaption;
    FActive  : Boolean;
    FChecked : Boolean;
    FEnabled : Boolean;
    FDowned  : Boolean;
    FFont    : TFont;
    FFocused : Boolean;
    FHotKey  : Char;
    FColor   : TColor;
    FShadowText : Boolean;
    FCheckColor : TColor;
    FTransparent : Boolean;
    FDataSource: TDataSource;
    FFieldName : string;
    FCheckData : string;
    FOldValue  : boolean;
    FOnModified: TNotifyEvent;
    FAutoCR    : boolean;

    FOnClick : TNotifyEvent;
    FOnEnter : TNotifyEvent;
    FOnExit  : TNotifyEvent;
    FSystemColor: boolean;
    oBasicColor : TColor;
    oActGradBeg : TColor;
    oActGradEnd : TColor;
    oDownGradBeg: TColor;
    oDownGradEnd: TColor;
    oInactGradBeg: TColor;
    oInactGradEnd: TColor;
    oActBorder   : TColor;

    procedure SetCaption (ACaption : TCaption);
    function  GetCaption : TCaption;
    procedure SetFont (AFont : TFont);
    function  GetFont : TFont;
    procedure OnFontChange (Sender : TObject);
    procedure SetColor (AColor : TColor);
    function  GetColor : TColor;
    procedure SetCheckColor (AColor : TColor);
    function  GetCheckColor : TColor;
    procedure SetChecked (AChecked : Boolean);
    function  GetChecked : Boolean;
    procedure SetTransparent (Value : Boolean);
    procedure SetEnabled (AValue : Boolean);
    procedure SetShadowText (AValue : Boolean);
    function  GetDataSource:TDataSource;
    procedure SetDataSource (AValue:TDataSource);
    function  GetFieldName:string;
    procedure SetFieldName (Value:string);
    procedure SetBasicColor (pValue:TColor);

    procedure RefreshSystemColor;
  protected
    procedure Paint; override;
    procedure CreateParams(var Params: TCreateParams); override;

    procedure DrawCheckArea (ACanvas : TCanvas);
    procedure MouseEnter (var Message : TMessage); message CM_MOUSEENTER;
    procedure MouseLeave (var Message : TMessage); message CM_MOUSELEAVE;
    procedure LMouseDown  (var Message : TMessage); message WM_LBUTTONDOWN;
    procedure RMouseDown  (var Message : TMessage); message WM_RBUTTONDOWN;
    procedure LMouseUp  (var Message : TMessage); message WM_LBUTTONUP;
    procedure RMouseUp  (var Message : TMessage); message WM_RBUTTONUP;
    procedure LMouseDblClick  (var Message : TMessage); message WM_LBUTTONDBLCLK;
    procedure WMSetFocus(var Message: TMessage); message WM_SETFOCUS;
    procedure WMKillFocus(var Message: TMessage); message WM_KILLFOCUS;
    procedure CMDialogChar(var Message : TCMDialogChar);  message CM_DIALOGCHAR;
    procedure WMKeyDown(var Message: TMessage); message WM_KEYDOWN;
    procedure WMKeyUp(var Message: TMessage); message WM_KEYUP;
    procedure CMEnter(var Message: TCMGotFocus); message CM_ENTER;
    procedure CMExit(var Message: TCMLostFocus); message CM_EXIT;

    procedure FOnCheckBoxClick;
  public
    constructor Create (AOwner : TComponent); override;
    destructor Destroy; override;
  published
    property SystemColor:boolean read FSystemColor write FSystemColor;
    property AutoCR:boolean read FAutoCR write FAutoCR;
    property Caption : TCaption read GetCaption write SetCaption;
    property Font : TFont read GetFont write SetFont;
    property Enabled : Boolean read FEnabled write SetEnabled default TRUE;
    property Anchors;
    property ParentFont;
    property ParentColor;
    property Hint;
    property ShowHint;
    property TabOrder;
    property TabStop;
    property Transparent : Boolean read FTransparent write SetTransparent default TRUE;
    property ShadowText : Boolean read FShadowText write SetShadowText default TRUE;
    property BasicColor: TColor read oBasicColor write SetBasicColor;
    property Color : TColor read GetColor write SetColor;
    property CheckColor : TColor read GetCheckColor write SetCheckColor;
    property Checked : Boolean read GetChecked write SetChecked default FALSE;
    property DataSource:TDataSource read GetDataSource write SetDataSource;
    property FieldName:string read GetFieldName write SetFieldName;
    property CheckData:string read FCheckData write FCheckData;

    property OnClick: TNotifyEvent read FOnClick write FOnClick;
    property OnEnter: TNotifyEvent read FOnEnter write FOnEnter;
    property OnExit: TNotifyEvent read FOnExit write FOnExit;
    property OnModified: TNotifyEvent read FOnModified write FOnModified;
  end;


// TxpComboStyle
  TxpComboBox = class;

  TComboBGStyle = (cbgsNone, cbgsGradient, cbgsTiledImage, cbgsStretchedImage);
  TxpComboButtonStyle = (cbsFlat, cbsXP);

  TxpComboStyle = class (TPersistent)
  private
    FActive      : Boolean;
    FAutoSearch  : Boolean;

    FxpComboBox  : TxpComboBox;
    FImageList   : TImageList;
    FButtonWidth : Integer;
    FButtonStyle : TxpComboButtonStyle;
    FAutoHeight  : Boolean;

    FBGStyle     : TComboBGStyle;
    FBGStartColor: TColor;
    FBGEndColor  : TColor;
    FBGGradientFillDir : TFillDirection;
    FBGImage     : TBitmap;
    FDefaultImageIndex : Integer;
    FActiveBorderColor : TColor;
    FInactiveBorderColor : TColor;
    FDefaultListImageIndex : Integer;

    FActiveButtonColor : TColor;
    FInActiveButtonColor : TColor;

    FSelStartColor : TColor;
    FSelEndColor : TColor;
    FSelGradientFillDir : TFillDirection;

    procedure SetImageList (AValue : TImageList);
    procedure ImageListOnChange (Sender : TObject);
    procedure SetButtonWidth (AValue : Integer);
    procedure SetButtonStyle (AValue : TxpComboButtonStyle);
    procedure SetAutoHeight (AValue : Boolean);
    procedure SetBGStyle (AValue : TComboBGStyle);
    procedure SetDefaultImageIndex (AValue : Integer);

    procedure SetActiveBorderColor (AValue : TColor);
    procedure SetInactiveBorderColor (AValue : TColor);

    procedure SetActiveButtonColor (AValue : TColor);
    procedure SetInActiveButtonColor (AValue : TColor);

    procedure SetSelStartColor (AValue : TColor);
    procedure SetSelEndColor (AValue : TColor);
    procedure SetSelGradientFillDir (AValue : TFillDirection);

    procedure SetBGStartColor (AValue : TColor);
    procedure SetBGEndColor (AValue : TColor);
    procedure SetBGGradientFillDir (AValue : TFillDirection);
    procedure SetBGImage (AValue : TBitmap);

    procedure SetDefaultListImageIndex (AValue : Integer);

    procedure SetAutoSearch (Value : Boolean);

  protected
    procedure SetActive (AValue : Boolean); virtual;
  public
    constructor Create (AOwner : TxpComboBox);
    destructor  Destroy; override;
  published
    property Active : Boolean read FActive write SetActive default true;
    property AutoHeight : Boolean read FAutoHeight write SetAutoHeight default False;
    property AutoSearch : Boolean read FAutoSearch write SetAutoSearch default False;
    property ButtonWidth : Integer read FButtonWidth write SetButtonWidth;
    property ButtonStyle : TxpComboButtonStyle read FButtonStyle write SetButtonStyle;
    property Images : TImageList read FImageList write SetImageList;
    property BGStyle : TComboBGStyle read FBGStyle write SetBGStyle default cbgsNone;

    property ActiveBorderColor : TColor read FActiveBorderColor write SetActiveBorderColor;
    property InActiveBorderColor : TColor read FInactiveBorderColor write SetInactiveBorderColor;
    property ActiveButtonColor : TColor read FActiveButtonColor write SetActiveButtonColor;
    property InActiveButtonColor : TColor read FInActiveButtonColor write SetInActiveButtonColor;

    property BGStartColor : TColor read FBGStartColor write SetBGStartColor;
    property BGEndColor : TColor read FBGEndColor write SetBGEndColor;
    property BGGradientFillDir : TFillDirection read FBGGradientFillDir write SetBGGradientFillDir;
    property BGImage : TBitmap read FBGImage write SetBGImage;
    property DefaultImageIndex : Integer read FDefaultImageIndex write SetDefaultImageIndex default -1;
    property DefaultListImageIndex : Integer read FDefaultListImageIndex write SetDefaultListImageIndex default -1;

    property SelStartColor : TColor read FSelStartColor write SetSelStartColor;
    property SelEndColor : TColor read FSelEndColor write SetSelEndColor;
    property SelGradientFillDir : TFillDirection read FSelGradientFillDir write SetSelGradientFillDir;

  end;

// TxpComboBox
  TxpComboBox = class(TComboBox)
  private
    { Private declarations }
    FCanvas  : TControlCanvas;
    FActive  : Boolean;
    FFocused : Boolean;
    FBackground : TBitmap;
    FxpStyle : TxpComboStyle;

    FLocating : Boolean;
    FOldText  : String;

    FDataSource: TDataSource;
    FFieldName : string;
    FOldValue  : string;
    FAutoCR    : boolean;
    FOnModified: TNotifyEvent;
    FSystemColor: boolean;
    oBasicColor : TColor;
    oFocusColor : TColor;
    oBackColor  : TColor;

    function LocateItem (AStartStr : string) : Integer;

    function  GetDataSource:TDataSource;
    procedure SetDataSource (AValue:TDataSource);
    procedure SetBasicColor (pAValue:TColor);
    procedure RefreshSystemColor;
  protected
    procedure CreateParams (var Params: TCreateParams); override;

    procedure WMPaint (var Message: TWMPaint); message WM_PAINT;
    procedure WMNCPaint (var Message : TWMNCPaint); message WM_NCPAINT;
    procedure NCHitTest (var Message : TWMNCHitTest); message WM_NCHITTEST;
    procedure WMNCCalcSize (var Message : TWMNCCalcSize); message WM_NCCALCSIZE;
    procedure MouseDown (var Message : TWMLBUTTONDOWN); message WM_LBUTTONDOWN;
    procedure MouseEnter (var Message : TMessage); message CM_MOUSEENTER;
    procedure MouseLeave (var Message : TMessage); message CM_MOUSELEAVE;
    procedure WMDrawItem (var Message : TWMDrawItem); message WM_DRAWITEM;
    procedure WMMeasureItem (var Message : TWMMeasureItem); message WM_MEASUREITEM;
    procedure WMSetFocus (var Message : TMessage); message WM_SETFOCUS;
    procedure WMKillFocus (var Message : TMessage); message WM_KILLFOCUS;
    procedure CNCommand (var Message : TWMCOMMAND); message CN_COMMAND;
    procedure WMCommand (var Message : TWMCOMMAND); message WM_COMMAND;
    procedure CMEnabledChanged (var Message: TMessage); message CM_ENABLEDCHANGED;
    procedure CMEnter(var Message: TCMGotFocus); message CM_ENTER;
    procedure CMExit(var Message: TCMExit); message CM_EXIT;
    procedure KeyDown(var Key: Word; Shift: TShiftState); override;

    procedure DrawBorder (DC : hDC); virtual;
    procedure DrawFlatButton (DC : hDC; AButtonRect : TRect);
    procedure DrawXPButton (DC : hDC; AButtonRect : TRect);
    procedure DrawButton (DC : hDC; AButtonRect : TRect; AStyle : TxpComboButtonStyle); virtual;
    procedure DrawEditText (ACanvas : TCanvas; ARect : TRect; AItemIndex : Integer; IsSelected : Boolean); virtual;

    procedure Notification (AComponent: TComponent; Operation: TOperation); override;
  public
    constructor Create(AOwner: TComponent); override;
    destructor  Destroy; override;

    function   FindData (AValue:string):boolean;
    function   GetItemIndex (pText:string):longint;
  published
    property SystemColor:boolean read FSystemColor write FSystemColor;
    property BasicColor: TColor read oBasicColor write SetBasicColor;
    property XPStyle : TxpComboStyle read FxpStyle write FxpStyle;
    property OnModified: TNotifyEvent read FOnModified write FOnModified;
    property DataSource:TDataSource read GetDataSource write SetDataSource;
    property FieldName:string read FFieldName write FFieldName;
 end;

  TGlyphMapEvent = procedure(Control: TWinControl; PageIndex : integer; var GlyphIndex : integer) of object;
  TxpTabPosition = (tpTop, tpBottom, tpLeft, tpRight);
  TxpPageControlStyle = (pcsTabs, pcsButtons, pcsFlatButtons, pcsXP);
  TxpTabBGStyle = (bgsNone, bgsGradient, bgsTileImage, bgsStrechImage);

  tagTCITEMA = packed record
    mask: UINT;
    dwState: UINT;
    dwStateMask: UINT;
    pszText: PAnsiChar;
    cchTextMax: Integer;
    iImage: Integer;
    lParam: LPARAM;
  end;

  PTCHitTestInfo = ^TTCHitTestInfo;
  tagTCHITTESTINFO = packed record
    pt: TPoint;
    flags: UINT;
  end;

  TTCHitTestInfo = tagTCHITTESTINFO;

  TTCItemA = tagTCITEMA;
  TTCItem = TTCItemA;

// TxpPageControl
  TxpPageControl = class (TPageControl)
  private
    FCanvas : TControlCanvas;      // canvas for drawing on with tabOwnerDraw
    FImageList : TImageList;          // link to a TImageList component
    FOnDrawItem : TDrawItemEvent;  // Owner draw event
    FOnGlyphMap : TGlyphMapEvent;  // glyph mapping event

    FBorderColor : TColor;
    FHotTrackTab : Integer;
    FBorderRect  : TRect;
    FTabPosition : TxpTabPosition;
    oTabsShow    : boolean;

    FOwnerDraw : Boolean;
    FStyle : TxpPageControlStyle;

    FTabTextAlignment : TAlignment;
    FSystemColor: boolean;
    oSelected    : boolean;
    oBasicColor  : TColor;
    oHintExt     : string;
    oShowHintExt : boolean;
    oTabOrderExt : longint;
    oTabStopExt  : boolean;
    oEnabledExt  : boolean;

    function  PageIndexToWin (AIndex : Integer) : Integer;
    function  WinIndexToPage (AIndex : Integer) : Integer;
    procedure SetGlyphs (Value : TImageList);
    function GetMultiline : boolean;
    procedure CNDrawItem (var Msg : TWMDrawItem); message CN_DRAWITEM;
    procedure WMAdjasment (var Msg : TMessage); message TCM_ADJUSTRECT;
    procedure WMNCPaint (var Message : TWMNCPaint); message WM_NCPAINT;
    procedure WMNCCalcSize (var Message : TWMNCCalcSize); message WM_NCCALCSIZE;
    procedure WMPaint (var Message : TWMPaint); message WM_PAINT;
    procedure WMMouseMove (var Message : TWMMouseMove); message WM_MOUSEMOVE;
    procedure WMSIZE (var Message : TWMSIZE); message WM_SIZE;
    procedure CMDialogChar(var Message : TCMDialogChar);  message CM_DIALOGCHAR;
    procedure MouseLeave (var Message : TMessage); message CM_MOUSELEAVE;
    procedure CMHintShow(var Message: TMessage); message CM_HINTSHOW;
    procedure GlyphsChanged (Sender : TObject);

    procedure SetTabPosition (Value : TxpTabPosition);
    procedure SetTabTextAlignment (Value : TAlignment);

    procedure SetBorderColor (Value : TColor);
    procedure SetStyle (Value : TxpPageControlStyle);
    procedure SetOwnerDraw (AValue : Boolean);
    procedure SetTabsShow (pValue:boolean);
    procedure SetBasicColor (pAValue:TColor);

    procedure RefreshSystemColor;
  protected
    procedure CreateParams(var Params: TCreateParams); override;
    procedure CreateWnd; override;
    procedure DrawItem(Index: Integer; Rect: TRect; State: TOwnerDrawState); virtual;
    procedure DrawItemInside (AIndex : Integer; ACanvas : TCanvas; ARect : TRect); virtual;
    procedure DrawBorder (ACanvas : TCanvas); virtual;

    procedure DrawTopTab (TabRect : TRect; ACanvas : TCanvas; AIndex, AVisibleIndex : Integer);
    procedure DrawBottomTab (TabRect : TRect; ACanvas : TCanvas; AIndex, AVisibleIndex : Integer);
    procedure DrawLeftTab (TabRect : TRect; ACanvas : TCanvas; AIndex, AVisibleIndex : Integer);
    procedure DrawRightTab (TabRect : TRect; ACanvas : TCanvas; AIndex, AVisibleIndex : Integer);

    procedure DrawHotTrackTab (ATabIndex : Integer; AHotTrack : Boolean);
    procedure Loaded; override;
    // for owner draw
    property Canvas : TControlCanvas read FCanvas write FCanvas;
    // republish Multiline as read only
    property MultiLine : boolean read GetMultiline;

  public
    procedure UpdateGlyphs; virtual;

    property HintExt: string read oHintExt write oHintExt;
    property ShowHintExt: boolean read oShowHintExt write oShowHintExt;
    property TabOrderExt: longint read oTabOrderExt write oTabOrderExt;
    property TabStopExt: boolean read oTabStopExt write oTabStopExt;
    property EnabledExt: boolean read oEnabledExt write oEnabledExt;
    property Selected:boolean read oSelected write oSelected;
  published
    constructor Create (AOwner : TComponent); override;
    destructor Destroy; override;
    // link to TImageList
    property ImageList : TImageList Read FImageList write SetGlyphs;
    // owner draw event
    property OnDrawItem : TDrawItemEvent read FOnDrawItem write FOnDrawItem;
    // glyph map event
    property OnGlyphMap : TGlyphMapEvent read FOnGlyphMap write FOnGlyphMap;

    property OwnerDraw : Boolean read FOwnerDraw write SetOwnerDraw default False;
    property TabPosition : TxpTabPosition read FTabPosition write SetTabPosition;
    property TabTextAlignment : TAlignment read FTabTextAlignment write SetTabTextAlignment;
    property Style : TxpPageControlStyle read FStyle write SetStyle;
    property TabsShow:boolean read oTabsShow write SetTabsShow;
    property SystemColor:boolean read FSystemColor write FSystemColor;
    property BasicColor: TColor read oBasicColor write SetBasicColor;
    property BorderColor : TColor read FBorderColor write SetBorderColor;

    property Color;
    property OnClick;
    property OnMouseDown;
    property OnMouseUp;
    property OnMouseMove;
    property OnKeyDown;
    property OnKeyUp;
    property OnEnter;
  end;

// TxpTabSheet
  TxpTabSheet = class (TTabSheet)
  private
    FCanvas : TControlCanvas;
    FColor : TColor;
    FGradientStartColor : TColor;
    FGradientEndColor : TColor;
    FGradientFillDir : TFillDirection;
    FImageIndex : Integer;
    FShowTabHint : Boolean;
    FTabHint : String;
    FBGImage : TBitmap;
    FBGStyle : TxpTabBGStyle;
    FSystemColor: boolean;
    oSelected   : boolean;
    oEnabledExt : boolean;
    oHintExt    : string;
    oShowHintExt: boolean;
    oBasicColor : TColor;

    procedure SetColor (AValue : TColor);
    procedure WMNCPaint (var Message : TWMNCPaint); message WM_NCPAINT;
    procedure WMPaint (var Message : TWMPaint); message WM_PAINT;
    procedure WMEraseBkgnd(var Message: TWMEraseBkgnd); message WM_ERASEBKGND;
    procedure SetImageIndex (AIndex : Integer);

    procedure SetBGImage (AValue : TBitmap);
    procedure SetBGStyle (AValue : TxpTabBGStyle);
    procedure SetGradientStartColor (AValue : TColor);
    procedure SetGradientEndColor (AValue : TColor);
    procedure SetGradientFillDir (AValue : TFillDirection);
    procedure SetBasicColor (pAValue:TColor);

    procedure RefreshSystemColor;
  public
    constructor Create(AOwner: TComponent); override;
    destructor  Destroy;

    property EnabledExt:boolean read oEnabledExt write oEnabledExt;
    property HintExt:string read oHintExt write oHintExt;
    property ShowHintExt:boolean read oShowHintExt write oShowHintExt;
    property Selected:boolean read oSelected write oSelected;
  published
    property SystemColor:boolean read FSystemColor write FSystemColor;
    property BasicColor:TColor read oBasicColor write SetBasicColor;
    property Color : TColor read FColor write SetColor;
    property ImageIndex : Integer read FImageIndex write SetImageIndex default -1;
    property ShowTabHint : Boolean read FShowTabHint write FShowTabHint default False;
    property TabHint : String read FTabHint write FTabHint;
    property BGImage : TBitmap read FBGImage write SetBGImage;
    property BGStyle : TxpTabBGStyle read FBGStyle write SetBGStyle;
    property GradientStartColor : TColor read FGradientStartColor write SetGradientStartColor;
    property GradientEndColor : TColor read FGradientEndColor write SetGradientEndColor;
    property GradientFillDir : TFillDirection read FGradientFillDir write SetGradientFillDir;

    property OnClick;
    property OnMouseDown;
    property OnMouseUp;
    property OnMouseMove;
    property OnKeyDown;
    property OnKeyUp;
    property OnEnter;
  end;

  TTitleImageAlign = (tiaCenter, tiaLeft, tiaRight, tiaStretch, tiaTile);
  TTitleButton = (tbClose, tbMinimize, tbMaximize);
  TTitleButtons = Set of TTitleButton;
  TRoundedCorner = (rcTopLeft, rcTopRight, rcBottomLeft, rcBottomRight);
  TRoundedCorners = Set of TRoundedCorner;
  TBGImageAlign = (iaCenter, iaStretch, iaTile);

  TxpPanel = class;

  TAfterSizeChanged = procedure (Sender : TxpPanel; ASizeRestored : Boolean) of object;

//TFixMinPanel

  TFixMinPanel = class (TScrollBox)
  private
    oPanel    : TPanel;
    oMinHeight: longint;
    oMinWidth : longint;

    procedure MyOnResize (Sender: TObject);
    procedure SetMinWidth(pValue:longint);
    procedure SetMinHeight(pValue:longint);
  public
    constructor Create(AOwner: TComponent); override;
    destructor  Destroy; override;

  published
    property MinWidth:longint read oMinWidth write SetMinWidth;
    property MinHeight:longint read oMinHeight write SetMinHeight;
  end;

// TxpSinglePanel
  TxpSinglePanel = class (TCustomPanel)
  private
    FBorderColor : TColor;
    FSystemColor : boolean;
    oHead        : string;
    oSelected    : boolean;
    oBasicColor  : TColor;
    oEnabledExt  : boolean;
    oHintExt     : string;
    oShowHintExt : boolean;
    oTabOrderExt : longint;
    oTabStopExt  : boolean;
    oGradEndColor: TColor;
    oGradStartColor: TColor;
    oGradFillDir : TFillDirection;
    oBGImage     : TBitmap;
    oBGStyle     : TxpTabBGStyle;

    procedure RefreshSystemColor;
    procedure SetBorderColor (AValue:TColor);
    procedure SetSystemColor (AValue:boolean);
    procedure SetHead (pHead:string);
    procedure SetBasicColor (pValue:TColor);
    procedure SetGradEndColor (pValue:TColor);
    procedure SetGradStartColor (pValue:TColor);
    procedure SetGradFillDir (pValue:TFillDirection);
    procedure SetBGImage (pValue:TBitmap);
    procedure SetBGStyle (pValue:TxpTabBGStyle);

    procedure MyOnResize (Sender: TObject);
  public
    constructor Create(AOwner: TComponent); override;
    destructor  Destroy; override;
    procedure WMPaint (var Message : TWMPaint); message WM_PAINT;
    procedure Paint; override;

    property EnabledExt: boolean read oEnabledExt write oEnabledExt;
    property HintExt: string read oHintExt write oHintExt;
    property ShowHintExt: boolean read oShowHintExt write oShowHintExt;
    property TabOrderExt: longint read oTabOrderExt write oTabOrderExt;
    property TabStopExt: boolean read oTabStopExt write oTabStopExt;
    property Selected:boolean read oSelected write oSelected;
  published
    property SystemColor:boolean read FSystemColor write SetSystemColor;
    property BasicColor:TColor read oBasicColor write SetBasicColor;
    property BorderColor: TColor read FBorderColor write SetBorderColor;
    property Head:string read oHead write SetHead;
    property GradEndColor: TColor read oGradEndColor write SetGradEndColor;
    property GradStartColor: TColor read oGradStartColor write SetGradStartColor;
    property GradFillDir: TFillDirection read oGradFillDir write SetGradFillDir;
    property BGImage: TBitmap read oBGImage write SetBGImage;
    property BGStyle: TxpTabBGStyle read oBGStyle write SetBGStyle;

    property Hint;
    property ShowHint;
    property Color;
    property Font;
    property Align;
    property Visible;
    property Enabled;
    property Anchors;
    property TabOrder;
    property TabStop;
    property OnClick;
    property OnMouseDown;
    property OnMouseUp;
    property OnMouseMove;
    property OnKeyDown;
    property OnKeyUp;
    property OnEnter;
    property OnResize;
  end;

// TxpPanel
  TxpPanel = class(TCustomPanel)
  private
    FCloseBtnRect : TRect;
    FMaxBtnRect   : TRect;
    FMinBtnRect   : TRect;
    FOldBounds    : TRect;
    FOldAlign     : TAlign;
    FOldMinimize  : Boolean;
    FMinimizing   : Boolean;

    FGradientFill : Boolean;
    FStartColor   : TColor;
    FEndColor     : TColor;
    FFillDirection: TFillDirection;
    FShadow       : Boolean;
    FShadowDist   : Integer;
    FHeight       : Integer;

    FDefaultHeight : Integer;
    FShowHeader : Boolean;
    FCaption    : String;
    FTitle      : String;
    FTitleFont  : TFont;
    FTitleHeight: Integer;
    FTitleAlignment : TAlignment;
    FTitleShadowOnMouseEnter : Boolean;
    FTitleGradient : Boolean;
    FTitleStartColor : TColor;
    FTitleEndColor : TColor;
    FTitleColor : TColor;
    FTitleFillDirect : TFillDirection;
    FTitleImage : TBitmap;
    FTitleImageAlign : TTitleImageAlign;
    FTitleImageTransparent : Boolean;
    FTitleCursor : TCursor;
    FTitleButtons : TTitleButtons;
    FAnimation : Boolean;

    FMovable : Boolean;
    FSizable : Boolean;

    FMinimized : Boolean;
    FMaximized : Boolean;

    FBorderSize : Integer;
    FBorderColor: TColor;
    FShowBorder : Boolean;
    FRoundedCorner : TRoundedCorners;

    FBGImage : TBitmap;
    FBGImageAlign : TBGImageAlign;
    FBGImageTransparent : Boolean;

    FMouseOnHeader : Boolean;

    FOnTitleClick : TNotifyEvent;
    FOnTitleDblClick : TNotifyEvent;
    FOnTitleMouseDown : TMouseEvent;
    FOnTitleMouseUp : TMouseEvent;
    FOnTitleMouseEnter: TNotifyEvent;
    FOnTitleMouseExit : TNotifyEvent;
    FOnMouseEnter     : TNotifyEvent;
    FOnMouseExit      : TNotifyEvent;
    FAfterMinimized   : TAfterSizeChanged;
    FAfterMaximized   : TAfterSizeChanged;
    FBeforeMoving     : TNotifyEvent;
    FAfterMoving      : TNotifyEvent;
    FAfterClose       : TNotifyEvent;
    FSystemColor      : boolean;

    procedure SetGradientFill (AValue : Boolean);
    procedure SetStartColor (AColor : TColor);
    procedure SetEndColor (AColor : TColor);
    procedure SetFillDirection (AFillDirection : TFillDirection);
    procedure SetShadow (AValue : Boolean);
    procedure SetShadowDist (AValue : Integer);

    procedure SetShowHeader (AValue : Boolean);
    procedure SetCaption (ACaption : String);
    procedure SetTitle (ATitle : String);
    procedure SetTitleFont (AFont : TFont);
    procedure OnTitleFontChange (Sender : TObject);
    procedure SetDefaultHeight (AValue : Integer);

    procedure SetTitleHeight (AHeight : Integer);
    procedure SetTitleAlignment (AValue : TAlignment);
    procedure SetShadowTitleOnMouseEnter (AShadow : Boolean);
    procedure SetTitleGradient (AValue : Boolean);
    procedure SetTitleStartColor (AValue : TColor);
    procedure SetTitleEndColor (AValue : TColor);
    procedure SetTitleFillDirect (AValue : TFillDirection);
    procedure SetTitleColor (AValue : TColor);
    procedure SetTitleImage (AValue : TBitmap);
    procedure SetTitleCursor (AValue : TCursor);
    procedure SetTitleImageAlign (AValue : TTitleImageAlign);
    procedure SetTitleImageTransparent (AValue : Boolean);
    procedure SetTitleButtons (AValue : TTitleButtons);

    procedure SetAnimation (AValue : Boolean);
    procedure SetBorderSize (AValue : Integer);
    procedure SetBorderColor (AValue : TColor);
    procedure SetShowBorder (AValue : Boolean);
    procedure SetRoundedCorner (AValue : TRoundedCorners);

    procedure SetMovable (AValue : Boolean);
    procedure SetSIzable (AValue : Boolean);
    procedure SetMinimized (AValue : Boolean);
    procedure SetMaximized (AValue : Boolean);

    procedure SetBGImage (AImage : TBitmap);
    procedure SetBGImageAlign (AImageAlign : TBGImageAlign);
    procedure SetBGImageTransparent (ATrans : Boolean);

    procedure RefreshSystemColor;
  protected
    procedure DrawTitle (ACanvas : TCanvas; ATitleRect : TRect);
    procedure DrawAllTitleButtons (ACanvas : TCanvas; ATitleRect : TRect);
    procedure DrawTitleButton (ACanvas : TCanvas; AButtonRect : TRect; ABtnType : TTitleButton);
    procedure DrawBorder (ACanvas : TCanvas; ARect : TRect; AClient : Boolean); //AClient = true - draw client area border only
    procedure DrawBGImage (ACanvas : TCanvas);
    procedure ForceReDraw;
    procedure Loaded; override;
    procedure SetShape (ARounded : TRoundedCorners);

    procedure WMSize (var Message : TMessage); message WM_SIZE;

    procedure MouseEnter (var Message : TMessage); message CM_MOUSEENTER;
    procedure MouseLeave (var Message : TMessage); message CM_MOUSELEAVE;
    procedure NCHitTest (var Message : TWMNCHitTest); message WM_NCHITTEST;
    procedure NCMouseDown (var Message : TWMNCLBUTTONDOWN); message WM_NCLBUTTONDOWN;
    procedure NCMouseUp (var Message : TWMNCLBUTTONUP); message WM_NCLBUTTONUP;
    procedure NCMouseDblClick (var Message : TWMNCLButtonDblClk); message WM_NCLBUTTONDBLCLK;

    procedure WMNCPaint (var Message : TWMNCPaint); message WM_NCPAINT;
    procedure WMNCCalcSize (var Message : TWMNCCalcSize); message WM_NCCALCSIZE;
    procedure WMNCACTIVATE (var Message : TWMNCActivate); message WM_NCACTIVATE;
    procedure Paint; override;

  public
    constructor Create(AOwner: TComponent); override;
    destructor  Destroy; override;
  published
    { Published declarations }
    property SystemColor:boolean read FSystemColor write FSystemColor;
    property GradientFill : Boolean read FGradientFill write SetGradientFill default True;
    property StartColor : TColor read FStartColor write SetStartColor;
    property EndColor : TColor read FEndColor write SetEndColor;
    property FillDirection : TFillDirection read FFillDirection write SetFillDirection;
    property TitleShow : Boolean read FShowHeader write SetShowHeader default True;
    property Caption : String read FCaption write SetCaption;
    //property Shadow : Boolean read FShadow write SetShadow default true;
    //property ShadowDist : Integer read FShadowDist write SetShadowDist default 5;

    property Minimized : Boolean read FMinimized write SetMinimized default False;
    property Maximized : Boolean read FMaximized write SetMaximized default False;
    property Title : String read FTitle write SetTitle;
    property TitleFont : TFont read FTitleFont write SetTitleFont;
    property TitleHeight : Integer read FTitleHeight write SetTitleHeight default  30;
    property TitleAlignment : TAlignment read FTitleAlignment write SetTitleAlignment;
    property TitleShadowOnMoseEnter : Boolean read FTitleShadowOnMouseEnter write SetShadowTitleOnMouseEnter default True;
    property TitleGradient : Boolean read FTitleGradient write SetTitleGradient default True;
    property TitleStartColor : TColor read FTitleStartColor write SetTitleStartColor;
    property TitleEndColor : TColor read FTitleEndColor write SetTitleEndColor;
    property TitleColor : TColor read FTitleColor write SetTitleColor;
    //property TitleCursor : TCursor read FTitleCursor write SetTitleCursor;
    property TitleImage : TBitmap read FTitleImage write SetTitleImage;
    property TitleFillDirect : TFillDirection read FTitleFillDirect write SetTitleFillDirect;
    property TitleImageAlign : TTitleImageAlign read FTitleImageAlign write SetTitleImageAlign;
    property TitleImageTransparent : Boolean read FTitleImageTransparent write SetTitleImageTransparent default True;
    property TitleButtons : TTitleButtons read FTitleButtons write SetTitleButtons;

    //property BorderSize  : Integer read FBorderSize write SetBorderSize default 1;
    property Animation : Boolean read FAnimation write SetAnimation default True;
    property DefaultHeight : Integer read FDefaultHeight write SetDefaultHeight;
    property Movable : Boolean read FMovable write SetMovable default False;
    property Sizable : Boolean read FSizable write SetSizable default False;
    property ShowBorder  : Boolean read FShowBorder write SetShowBorder default True;
    property BorderColor : TColor read FBorderColor write SetBorderColor;
    property RoundedCorner : TRoundedCorners read FRoundedCorner write SetRoundedCorner default [rcTopLeft, rcTopRight];
    property BGImage : TBitmap read FBGImage write SetBGImage;
    property BGImageAlign : TBGImageAlign read FBGImageAlign write SetBGImageAlign;
    property BGImageTransparent : Boolean read FBGImageTransparent write SetBGImageTransparent default True;
    property Color;
    property Align;
    property Visible;
    property TabOrder;
    property TabStop;
    property DragMode;

    //Events
    property OnResize;
    property OnClick;
    property OnDblClick;
    property OnDragDrop;
    property OnDragOver;
    property OnEndDrag;
    property OnMouseDown;
    property OnMouseMove;
    property OnMouseUp;
    property OnStartDrag;
    property OnEnter;
    property OnExit;
    //
    property AfterMinimized : TAfterSizeChanged read FAfterMinimized write FAfterMinimized;
    property AfterMaximized : TAfterSizeChanged read FAfterMaximized write FAfterMaximized;
    property BeforeMove     : TNotifyEvent read FBeforeMoving write FBeforeMoving;
    property AfterMove      : TNotifyEvent read FAfterMoving write FAfterMoving;
    property AfterClose : TNotifyEvent read FAfterClose write FAfterClose;
    property OnTitleClick : TNotifyEvent read FOnTitleClick write FOnTitleClick;
    property OnTitleDblClick : TNotifyEvent read FOnTitleDblClick write FOnTitleDblClick;
    property OnTitleMouseDown : TMouseEvent read FOnTitleMouseDown write FOnTitleMouseDown;
    property OnTitleMouseUp : TMouseEvent read FOnTitleMouseUp write FOnTitleMouseUp;
    property OnTitleMouseEnter: TNotifyEvent read FOnTitleMouseEnter write FOnTitleMouseEnter;
    property OnTitleMouseExit : TNotifyEvent read FOnTitleMouseExit write FOnTitleMouseExit;
    property OnMouseEnter : TNotifyEvent read FOnMouseEnter write FOnMouseEnter;
    property OnMouseExit : TNotifyEvent read FOnMouseExit write FOnMouseExit;
    //
  end;

// TxpGroupBox

  TxpGroupBox = class (TCustomGroupBox)
  private
    FBorderColor : TColor;
    FSystemColor : boolean;
    oSelected    : boolean;
    oBasicColor  : TColor;
    oEnabledExt  : boolean;
    oHintExt     : string;
    oShowHintExt : boolean;
    oTabOrderExt : longint;
    oTabStopExt  : boolean;

    procedure RefreshSystemColor;
    procedure SetBorderColor (AValue:TColor);
    procedure SetSystemColor (AValue:boolean);
    procedure SetBasicColor (pValue:TColor);
  public
    constructor Create(AOwner: TComponent); override;
    destructor  Destroy; override;
    procedure   Paint; override;

    property HintExt: string read oHintExt write oHintExt;
    property ShowHintExt: boolean read oShowHintExt write oShowHintExt;
    property TabOrderExt: longint read oTabOrderExt write oTabOrderExt;
    property TabStopExt: boolean read oTabStopExt write oTabStopExt;
    property EnabledExt: boolean read oEnabledExt write oEnabledExt;
    property Selected:boolean read oSelected write oSelected;
  published
    property SystemColor:boolean read FSystemColor write SetSystemColor;
    property BasicColor: TColor read oBasicColor write SetBasicColor;
    property BorderColor: TColor read FBorderColor write SetBorderColor;

    property Color;
    property Caption;
    property Hint;
    property ShowHint;
    property Font;
    property Align;
    property Visible;
    property Anchors;
    property OnClick;
    property OnMouseDown;
    property OnMouseUp;
    property OnMouseMove;
    property OnKeyDown;
    property OnKeyUp;
    property OnEnter;
  end;

// TxpRadioButton
  TxpRadioButton = class(TCustomControl)
  private
    FCaption    : TCaption;
    FChecked    : Boolean;
    FOnClick    : TNotifyEvent;
    FHotKey     : Char;
    FDataSource : TDataSource;
    FFieldName  : string;
    FCheckData  : string;
    FShadowText : boolean;
    oSystemColor: boolean;
    oCheckColor : TColor;
    oBasicColor : TColor;
    oBorderColor: TColor;
    oGradBeg    : TColor;
    oGradEnd    : TColor;

    MouseOnControl : Boolean;
    FOnMouseEnter  : TNotifyEvent;
    FOnMouseLeave  : TNotifyEvent;
    procedure FocusRect(X1,Y1,X2,Y2 : Integer);


    procedure SetCaption(Value:TCaption);
    function  GetCaption : TCaption;
    function  GetDataSource:TDataSource;
    procedure SetDataSource (AValue:TDataSource);
    function  GetFieldName:string;
    procedure SetFieldName (AValue:string);
    procedure SetShadowText (AValue : Boolean);

    procedure SetChecked(Value:Boolean);
    procedure SetSystemColor (pValue:boolean);
    procedure SetCheckColor (pValue:TColor);
    procedure SetBasicColor (pValue:TColor);

    procedure RefreshSystemColor;
  protected
    procedure MouseEnter(var Msg : TMessage); message CM_MOUSEENTER;
    procedure MouseLeave(var Msg : TMessage); message CM_MOUSELEAVE;
    procedure SetCtrlHasFocus(var Msg : TMessage); message WM_SETFOCUS;
    procedure KillCtrlHasFocus(var Msg : TMessage); message WM_KILLFOCUS;
    procedure Click; override;
    procedure CMDialogChar(var Message : TCMDialogChar);  message CM_DIALOGCHAR;

    procedure DrawCheckMark; virtual;
    procedure Paint; override;
    procedure KeyPress(var Key : Char); override;
  public
    constructor Create(AOwner: TComponent); override;
  published
    property DataSource:TDataSource read GetDataSource write SetDataSource;
    property FieldName:string read GetFieldName write SetFieldName;
    property CheckData:string read FCheckData write FCheckData;
    property ShadowText : Boolean read FShadowText write SetShadowText default TRUE;
    property SystemColor: boolean read oSystemColor write SetSystemColor;
    property CheckColor: TColor read oCheckColor write SetCheckColor;
    property BasicColor: TColor read oBasicColor write SetBasicColor;

    property Anchors;
    property Caption: TCaption read GetCaption write SetCaption;
    property Checked: Boolean read FChecked write SetChecked;
    property Color;
    property Cursor;
    property DragCursor;
    property DragMode;
    property Enabled;
    property Font;
    property HelpContext;
    property ShowHint;
    property TabOrder;
    property TabStop;
    property Visible;

    property OnClick : TNotifyEvent read FOnClick write FOnClick;
    property OnDragDrop;
    property OnDragOver;
    property OnEndDrag;
    property OnEnter;
    property OnExit;
    property OnKeyDown;
    property OnKeyPress;
    property OnKeyUp;
    property OnMouseEnter : TNotifyEvent read FOnMouseEnter write FOnMouseEnter;
    property OnMouseLeave : TNotifyEvent read FOnMouseLeave write FOnMouseLeave;
    property OnMouseDown;
    property OnMouseUp;
    property OnMouseMove;
    property OnStartDrag;
  end;


// TxpMemoColors
    TxpMemo = class;

    TxpMemoColors = class (TPersistent)
    private
      FxpMemo     : TxpMemo;
      FBGNormal   : TColor;
      FBGActive   : TColor;
      FBGModify   : TColor;
      FBorderL    : TColor;
      FInactBorder: TColor;
      FActBorder  : TColor;

      procedure SetBGNormal (AValue:TColor);
      procedure SetBGActive (AValue:TColor);
      procedure SetBGModify (AValue:TColor);
      procedure SetInactBorder (AValue:TColor);
      procedure SetActBorder (AValue:TColor);
    public
      constructor Create (AOwner : TxpMemo);
    published
      property BGNormal:TColor read FBGNormal write SetBGNormal;
      property BGActive:TColor read FBGActive write SetBGActive;
      property BGModify:TColor read FBGModify write SetBGModify;
      property InactBorder:TColor read FInactBorder write SetInactBorder;
      property ActBorder:TColor read FActBorder write SetActBorder;
    end;

// TxpMemo
  TxpMemo = class(TCustomMemo)
  private
    FDataSource : TDataSource;
    FFieldName  : string;
    FSystemColor: boolean;
    FActive     : Boolean;
    FFocused    : Boolean;
    FOldValue   : string;
    FOnModified : TNotifyEvent;
    FMemoColors : TxpMemoColors;
    oBasicColor : TColor;

    procedure SetDataSource (AValue:TDataSource);
    function  GetDataSource:TDataSource;
    function  GetFieldName:string;
    procedure SetFieldName (AValue:string);
    procedure SetSystemColor(AValue:boolean);
    procedure SetBasicColor(pValue:TColor);

    procedure RefreshSystemColor;
  protected
    procedure WMPaint(var Message: TWMPaint); message WM_PAINT;
    procedure WMNCPaint (var Message : TWMNCPaint); message WM_NCPAINT;
    procedure MouseEnter (var Message : TMessage); message CM_MOUSEENTER;
    procedure MouseLeave (var Message : TMessage); message CM_MOUSELEAVE;
    procedure CMEnter(var Message: TCMGotFocus); message CM_ENTER;
    procedure CMExit(var Message: TCMExit); message CM_EXIT;
    procedure KeyUp(var Key: Word; Shift: TShiftState); override;
  public
    constructor Create(AOwner: TComponent); override;
    destructor  Destroy; override;
  published
    property DataSource:TDataSource read GetDataSource write SetDataSource;
    property FieldName:string read GetFieldName write SetFieldName;
    property OnModified: TNotifyEvent read FOnModified write FOnModified;
    property SystemColor:boolean read FSystemColor write SetSystemColor;
    property MemoColors:TxpMemoColors read FMemoColors write FMemoColors;
    property BasicColor:TColor read oBasicColor write SetBasicColor;

    property Align;
    property Alignment;
    property Anchors;
    property Color;
    property Constraints;
    property Enabled;
    property Font;
    property HideSelection;
    property Lines;
    property MaxLength;
    property OEMConvert;
    property ParentColor;
    property ParentFont;
    property ParentShowHint;
    property PopupMenu;
    property ReadOnly;
    property ScrollBars;
    property ShowHint;
    property TabOrder;
    property TabStop;
    property Visible;
    property WantReturns;
    property WantTabs;
    property WordWrap;
    property OnChange;
    property OnClick;
    property OnContextPopup;
    property OnDblClick;
    property OnDragDrop;
    property OnDragOver;
    property OnEndDock;
    property OnEndDrag;
    property OnEnter;
    property OnExit;
    property OnKeyDown;
    property OnKeyPress;
    property OnKeyUp;
    property OnMouseDown;
    property OnMouseMove;
    property OnMouseUp;
    property OnStartDock;
    property OnStartDrag;
  end;

// TxpStatusLine
  TxpStatusLine = class (TPanel)
  private
    FText        : string;
    FBorderColorL: TColor;
    FBorderColorD: TColor;
    FLineColor   : TColor;
    FSystemColor : boolean;

    procedure SetText (AValue:string);

    procedure SetBorderColorL (AValue:TColor);
    procedure SetBorderColorD (AValue:TColor);
    procedure SetLineColor (AValue:TColor);
    procedure RefreshSystemColor;
    function  GetSubText (pS:string;pNum:byte):string;
  protected
    procedure Paint; override;
  public
    constructor Create(AOwner: TComponent); override;
    destructor  Destroy; override;
  published
    property BorderColorL:TColor read FBorderColorL write SetBorderColorL;
    property BorderColorD:TColor read FBorderColorD write SetBorderColorD;
    property LineColor:TColor read FLineColor write SetLineColor;
    property SystemColor:boolean read FSystemColor write FSystemColor;
    property Text:string read FText write SetText;
  end;

  TxpRichEdit = class (TRichEdit)
  private
    FBorderColor: TColor;
    FSystemColor: boolean;
    oBasicColor : TColor;

    procedure RefreshSystemColor;
    procedure SetBorderColor (AValue:TColor);
    procedure SetSystemColor (AValue:boolean);
    procedure AddColorText (pStr:string;const pItm,pColorA: array of const;pColor:TColor;pColorType:byte);
    procedure SetBasicColor (pValue:TColor);
  protected
    procedure WMPaint(var Message: TWMPaint); message WM_PAINT;
    procedure WMNCPaint (var Message : TWMNCPaint); message WM_NCPAINT;
  public
    constructor Create(AOwner: TComponent); override;
    destructor  Destroy; override;

    procedure   Add(pStr:string;const pItm,pColor: array of const); overload;
    procedure   Add(pStr:string;const pItm: array of const;pColor:TColor); overload;
    procedure   Add(pStr:string;pDefColor:TColor;const pItm: array of const); overload;
    procedure   Add(pStr:string;pDefColor:TColor); overload;
  published
    property SystemColor:boolean read FSystemColor write SetSystemColor;
    property BasicColor:TColor read oBasicColor write SetBasicColor;
    property BorderColor:TColor read FBorderColor write SetBorderColor;
  end;
// xpRichEdit obsahuje prÌkaz, kde sa d· v˝razniù farebne riadok alebo parametr:
//  xpRichEdit1.Add ('Text1 #1 Text2 #2 Text3 #3',clBlack ,['111111111','2222','333333333'],[clRed,clBlue,ClGreen]);
//  - kaûd˝ parameter mÙûe maù vlastn˙ farbu
//
//  xpRichEdit1.Add ('Text1 #1 Text2 #2 Text3 #3',clBlack ,['111111111','2222','333333333'],clLime);
//  - parametere maj˙ zadan˙ farbu
//
//  xpRichEdit1.Add ('Text1 #1 Text2 #2 Text3 #3',clGreen, ['111111111','2222','333333333']);
//  - cel˝ riadok m· zadan˙ farbu a automaticky doplnÌ parametre
//
//  xpRichEdit1.Add ('Jednoduch˝ text',clGreen);
//  - cel˝ riadok m· zadan˙ farbu

  TCompType = (ucLabel,ucEditor,ucRadioButton,ucCheckBox,ucComboBox,ucBookList,ucSelectionList,ucButton,ucMemo,ucRichEdit,ucBasic);

  TxpUniComp = class(TCustomControl)
    private
      FAlignment  : TAlignment;
      FFrac       : longint;
      FChecked    : boolean;
      oSelected   : boolean;
      oCompType   : TCompType;
      oLayout     : TTextLayout;
      FButtLayout : TButtonLayout;
      oSystemColor: boolean;
      FAlignText  : TAlignText;
      FGlyph      : TBitmap;
      oButColors  : TButtColors;
      oEnabledExt : boolean;
      oMaxLength  : longint;
      oReadOnly   : boolean;
      oLines      : string;
      oWordWrap   : boolean;
      oHintExt    : string;
      oShowHintExt: boolean;
      oTabOrderExt: longint;
      oTabStopExt : boolean;
      oInfoField  : boolean;
      oNumSepar   : boolean;
      oAutoSize   : boolean;
      oParentColor: boolean;
      oTransparent: boolean;
      oCheckColor : TColor;
      oEditorType : TEditorType;
      oExtTextShow: boolean;

      oBasicColor : TColor;
      oBGNormal   : TColor;
      oBGReadOnly : TColor;
      oBGInfoField: TColor;
      oBGActive   : TColor;
      oBGModify   : TColor;
      oBGExtText  : TColor;
      oInactBorder: TColor;
      oActBorder  : TColor;
      oBorderColor: TColor;
      oGradBeg    : TColor;
      oGradEnd    : TColor;
      oActGradBeg   : TColor;
      oActGradEnd   : TColor;
      oDownGradBeg  : TColor;
      oDownGradEnd  : TColor;
      oInactGradBeg : TColor;
      oInactGradEnd : TColor;
      oBackColor    : TColor;

      oDateTime   : TDateTime;

      procedure DoDrawText(var pRect:TRect; pFlags:Longint);
      procedure PaintLabel;
      procedure PaintEdit;
      procedure PaintRadioButton;
      procedure PaintBitBtn (pLeft,pTop,pHeight,pWidth:longint);
      procedure PaintCheckBox;
      procedure PaintComboBox;
      procedure PaintSelect;
      procedure PaintEditButt;
      procedure PaintMemo;
      procedure PaintRichEdit;
      procedure PaintBasic;

      procedure SetAlignment (pValue:TAlignment);
      procedure SetLayout (pValue:TTextLayout);
      procedure SetButtLayout (AValue : TButtonLayout);
      procedure SetGlyph (AGlyph : TBitmap);
      function  GetGlyph : TBitmap;
      procedure SetBasicColor (pColor:TColor);
      procedure SetCheckColor (pColor:TColor);
      procedure SetTransparent (pValue:boolean);
      procedure SetAutoSize (pValue:boolean);

      procedure RefreshSystemColor;
    protected
      procedure WMPaint(var Message: TWMPaint); message WM_PAINT;
    public
      constructor Create (AOwner : TComponent); override;
      destructor Destroy; override;
    published
      property Font;
      property Color;
      property Canvas;
      property Caption;
      property TabStop;
      property TabOrder;
      property ParentFont;
      property Alignment : TAlignment read FAlignment write SetAlignment;
      property EditorType:TEditorType read oEditorType write oEditorType;
      property Frac:longint read FFrac write FFrac;
      property Checked:boolean read FChecked write FChecked;
      property Selected:boolean read oSelected write oSelected;
      property CompType:TCompType read oCompType write oCompType;
      property Layout:TTextLayout read oLayout write SetLayout;
      property SystemColor:boolean read oSystemColor write oSystemColor;
      property AlignText:TAlignText read FAlignText write FAlignText;
      property Glyph : TBitmap read GetGlyph write SetGlyph;
      property ButtLayout : TButtonLayout read FButtLayout write SetButtLayout;
      property BasicColor: TColor read oBasicColor write SetBasicColor;
      property CheckColor: TColor read oCheckColor write SetCheckColor;
      property EnabledExt: boolean read oEnabledExt write oEnabledExt;
      property ReadOnly: boolean read oReadOnly write oReadOnly;
      property MaxLength: longint read oMaxLength write oMaxLength;
      property Lines: string read oLines write oLines;
      property WordWrap: boolean read oWordWrap write oWordWrap;
      property HintExt: string read oHintExt write oHintExt;
      property ShowHintExt: boolean read oShowHintExt write oShowHintExt;
      property TabOrderExt: longint read oTabOrderExt write oTabOrderExt;
      property TabStopExt: boolean read oTabStopExt write oTabStopExt;
      property InfoField:boolean read oInfoField write oInfoField;
      property NumSepar:boolean read oNumSepar write oNumSepar;
      property AutoSize:boolean read oAutoSize write SetAutoSize;
      property ParentColor:boolean read oParentColor write oParentColor;
      property Transparent:boolean read oTransparent write SetTransparent;
      property ExtTextShow: boolean read oExtTextShow write oExtTextShow;

      property OnClick;
      property OnKeyDown;
      property OnKeyUp;
      property OnMouseMove;
      property OnMouseDown;
      property OnMouseUp;
      property OnEnter;
  end;


procedure StretchBitmapTransparent(Dest: TCanvas; Bitmap: TBitmap;
  TransparentColor: TColor; DstX, DstY, DstW, DstH, SrcX, SrcY,
  SrcW, SrcH: Integer);
procedure DrawBitmapTransparent(Dest: TCanvas; DstX, DstY: Integer;
Bitmap: TBitmap; TransparentColor: TColor);
procedure GradientXPFillRect (ACanvas : TCanvas; ARect : TRect; LightColor : TColor; DarkColor : TColor; Colors : Byte);
procedure ConvertBitmapToGrayscale (const Bmp: TBitmap);
procedure GradientFillRect(Canvas: TCanvas; ARect: TRect; StartColor,
  EndColor: TColor; Direction: TFillDirection; Colors: Byte);

function WidthOf(R: TRect): Integer;
function HeightOf(R: TRect): Integer;

function Max (Value1, Value2 : Integer) : Integer;
function Min (Value1, Value2 : Integer) : Integer;

procedure TileImage(Canvas: TCanvas; Rect: TRect; Image: TGraphic);


procedure Register;

implementation

uses Types;

const
  PaletteMask = $02000000;

function PaletteColor(Color: TColor): Longint;
begin
  Result := ColorToRGB(Color) or PaletteMask;
end;

procedure StretchBltTransparent(DstDC: HDC; DstX, DstY, DstW, DstH: Integer;
  SrcDC: HDC; SrcX, SrcY, SrcW, SrcH: Integer; Palette: HPalette;
  TransparentColor: TColorRef);
var
  Color: TColorRef;
  bmAndBack, bmAndObject, bmAndMem, bmSave: HBitmap;
  bmBackOld, bmObjectOld, bmMemOld, bmSaveOld: HBitmap;
  MemDC, BackDC, ObjectDC, SaveDC: HDC;
  palDst, palMem, palSave, palObj: HPalette;
begin
  { Create some DCs to hold temporary data }
  BackDC := CreateCompatibleDC(DstDC);
  ObjectDC := CreateCompatibleDC(DstDC);
  MemDC := CreateCompatibleDC(DstDC);
  SaveDC := CreateCompatibleDC(DstDC);
  { Create a bitmap for each DC }
  bmAndObject := CreateBitmap(SrcW, SrcH, 1, 1, nil);
  bmAndBack := CreateBitmap(SrcW, SrcH, 1, 1, nil);
  bmAndMem := CreateCompatibleBitmap(DstDC, DstW, DstH);
  bmSave := CreateCompatibleBitmap(DstDC, SrcW, SrcH);
  { Each DC must select a bitmap object to store pixel data }
  bmBackOld := SelectObject(BackDC, bmAndBack);
  bmObjectOld := SelectObject(ObjectDC, bmAndObject);
  bmMemOld := SelectObject(MemDC, bmAndMem);
  bmSaveOld := SelectObject(SaveDC, bmSave);
  { Select palette }
  palDst := 0; palMem := 0; palSave := 0; palObj := 0;
  If Palette <> 0 then begin
    palDst := SelectPalette(DstDC, Palette, TRUE);
    RealizePalette(DstDC);
    palSave := SelectPalette(SaveDC, Palette, FALSE);
    RealizePalette(SaveDC);
    palObj := SelectPalette(ObjectDC, Palette, FALSE);
    RealizePalette(ObjectDC);
    palMem := SelectPalette(MemDC, Palette, TRUE);
    RealizePalette(MemDC);
  end;
  { Set proper mapping mode }
  SetMapMode(SrcDC, GetMapMode(DstDC));
  SetMapMode(SaveDC, GetMapMode(DstDC));
  { Save the bitmap sent here }
  BitBlt(SaveDC, 0, 0, SrcW, SrcH, SrcDC, SrcX, SrcY, SRCCOPY);
  { Set the background color of the source DC to the color,         }
  { contained in the parts of the bitmap that should be transparent }
  Color := SetBkColor(SaveDC, PaletteColor(TransparentColor));
  { Create the object mask for the bitmap by performing a BitBlt()  }
  { from the source bitmap to a monochrome bitmap                   }
  BitBlt(ObjectDC, 0, 0, SrcW, SrcH, SaveDC, 0, 0, SRCCOPY);
  { Set the background color of the source DC back to the original  }
  SetBkColor(SaveDC, Color);
  { Create the inverse of the object mask }
  BitBlt(BackDC, 0, 0, SrcW, SrcH, ObjectDC, 0, 0, NOTSRCCOPY);
  { Copy the background of the main DC to the destination }
  BitBlt(MemDC, 0, 0, DstW, DstH, DstDC, DstX, DstY, SRCCOPY);
  { Mask out the places where the bitmap will be placed }
  StretchBlt(MemDC, 0, 0, DstW, DstH, ObjectDC, 0, 0, SrcW, SrcH, SRCAND);
  { Mask out the transparent colored pixels on the bitmap }
  BitBlt(SaveDC, 0, 0, SrcW, SrcH, BackDC, 0, 0, SRCAND);
  { XOR the bitmap with the background on the destination DC }
  StretchBlt(MemDC, 0, 0, DstW, DstH, SaveDC, 0, 0, SrcW, SrcH, SRCPAINT);
  { Copy the destination to the screen }
  BitBlt(DstDC, DstX, DstY, DstW, DstH, MemDC, 0, 0,
    SRCCOPY);
  { Restore palette }
  If Palette <> 0 then begin
    SelectPalette(MemDC, palMem, FALSE);
    SelectPalette(ObjectDC, palObj, FALSE);
    SelectPalette(SaveDC, palSave, FALSE);
    SelectPalette(DstDC, palDst, TRUE);
  end;
  { Delete the memory bitmaps }
  DeleteObject(SelectObject(BackDC, bmBackOld));
  DeleteObject(SelectObject(ObjectDC, bmObjectOld));
  DeleteObject(SelectObject(MemDC, bmMemOld));
  DeleteObject(SelectObject(SaveDC, bmSaveOld));
  { Delete the memory DCs }
  DeleteDC(MemDC);
  DeleteDC(BackDC);
  DeleteDC(ObjectDC);
  DeleteDC(SaveDC);
end;

procedure StretchBitmapTransparent(Dest: TCanvas; Bitmap: TBitmap;
  TransparentColor: TColor; DstX, DstY, DstW, DstH, SrcX, SrcY,
  SrcW, SrcH: Integer);
var
  CanvasChanging: TNotifyEvent;
begin
  If DstW <= 0 then DstW := Bitmap.Width;
  If DstH <= 0 then DstH := Bitmap.Height;
  If (SrcW <= 0) or (SrcH <= 0) then begin
    SrcX := 0; SrcY := 0;
    SrcW := Bitmap.Width;
    SrcH := Bitmap.Height;
  end;
  If not Bitmap.Monochrome then
    SetStretchBltMode(Dest.Handle, STRETCH_DELETESCANS);
  CanvasChanging := Bitmap.Canvas.OnChanging;
{$IFDEF VER100}
  Bitmap.Canvas.Lock;
{$ENDIF}
  try
    Bitmap.Canvas.OnChanging := nil;
    If TransparentColor = clNone then begin
      StretchBlt(Dest.Handle, DstX, DstY, DstW, DstH, Bitmap.Canvas.Handle,
        SrcX, SrcY, SrcW, SrcH, Dest.CopyMode);
    end else begin
{$IFDEF VER100}
      If TransparentColor = clDefault then
        TransparentColor := Bitmap.Canvas.Pixels[0, Bitmap.Height - 1];
{$ENDIF}
      If Bitmap.Monochrome then TransparentColor := clWhite
      else TransparentColor := ColorToRGB(TransparentColor);
      StretchBltTransparent(Dest.Handle, DstX, DstY, DstW, DstH,
        Bitmap.Canvas.Handle, SrcX, SrcY, SrcW, SrcH, Bitmap.Palette,
        TransparentColor);
    end;
  finally
    Bitmap.Canvas.OnChanging := CanvasChanging;
{$IFDEF VER100}
    Bitmap.Canvas.Unlock;
{$ENDIF}
  end;
end;

procedure DrawBitmapTransparent(Dest: TCanvas; DstX, DstY: Integer;
  Bitmap: TBitmap; TransparentColor: TColor);
begin
  StretchBitmapTransparent(Dest, Bitmap, TransparentColor, DstX, DstY,
    Bitmap.Width, Bitmap.Height, 0, 0, Bitmap.Width, Bitmap.Height);
end;

procedure ConvertBitmapToGrayscale (const Bmp: TBitmap);
type
  TRGBArray = array[0..32767] of TRGBTriple;
  PRGBArray = ^TRGBArray;
var
  x, y, Gray: Integer;
  Row: PRGBArray;
begin
  Bmp.PixelFormat := pf24Bit;
  for y := 0 to Bmp.Height - 1 do
  begin
    Row := Bmp.ScanLine[y];
    for x := 0 to Bmp.Width - 1 do
    begin
      Gray           := (Row[x].rgbtRed + Row[x].rgbtGreen + Row[x].rgbtBlue) div 3;
      Row[x].rgbtRed := Gray;
      Row[x].rgbtGreen := Gray;
      Row[x].rgbtBlue := Gray;
    end;
  end;
end;

procedure GradientSimpleFillRect(Canvas: TCanvas; ARect: TRect; StartColor,
  EndColor: TColor; Direction: TFillDirection; Colors: Byte);
var
  StartRGB: array[0..2] of Byte;    { Start RGB values }
  RGBDelta: array[0..2] of Integer; { Difference between start and end RGB values }
  ColorBand: TRect;                 { Color band rectangular coordinates }
  I, Delta: Integer;
  Brush: HBrush;
begin
  If IsRectEmpty(ARect) then Exit;
  If Colors < 2 then begin
    Brush := CreateSolidBrush(ColorToRGB(StartColor));
    FillRect(Canvas.Handle, ARect, Brush);
    DeleteObject(Brush);
    Exit;
  end;
  StartColor := ColorToRGB(StartColor);
  EndColor := ColorToRGB(EndColor);
  case Direction of
    fdTopToBottom, fdLeftToRight: begin
      { Set the Red, Green and Blue colors }
      StartRGB[0] := GetRValue(StartColor);
      StartRGB[1] := GetGValue(StartColor);
      StartRGB[2] := GetBValue(StartColor);
      { Calculate the difference between begin and end RGB values }
      RGBDelta[0] := GetRValue(EndColor) - StartRGB[0];
      RGBDelta[1] := GetGValue(EndColor) - StartRGB[1];
      RGBDelta[2] := GetBValue(EndColor) - StartRGB[2];
    end;
    fdBottomToTop, fdRightToLeft: begin
      { Set the Red, Green and Blue colors }
      { Reverse of TopToBottom and LeftToRight directions }
      StartRGB[0] := GetRValue(EndColor);
      StartRGB[1] := GetGValue(EndColor);
      StartRGB[2] := GetBValue(EndColor);
      { Calculate the difference between begin and end RGB values }
      { Reverse of TopToBottom and LeftToRight directions }
      RGBDelta[0] := GetRValue(StartColor) - StartRGB[0];
      RGBDelta[1] := GetGValue(StartColor) - StartRGB[1];
      RGBDelta[2] := GetBValue(StartColor) - StartRGB[2];
    end;
  end; {case}
  { Calculate the color band's coordinates }
  ColorBand := ARect;
  If Direction in [fdTopToBottom, fdBottomToTop] then begin
    Colors := Max(2, Min(Colors, HeightOf(ARect)));
    Delta := HeightOf(ARect) div Colors;
  end
  else begin
    Colors := Max(2, Min(Colors, WidthOf(ARect)));
    Delta := WidthOf(ARect) div Colors;
  end;
  with Canvas.Pen do begin { Set the pen style and mode }
    Style := psSolid;
    Mode := pmCopy;
  end;
  { Perform the fill }
  If Delta > 0 then begin
    For I := 0 to Colors-1 do begin
      case Direction of
        { Calculate the color band's top and bottom coordinates }
        fdTopToBottom, fdBottomToTop: begin
          ColorBand.Top := ARect.Top + I * Delta;
          ColorBand.Bottom := ColorBand.Top + Delta;
        end;
        { Calculate the color band's left and right coordinates }
        fdLeftToRight, fdRightToLeft: begin
          ColorBand.Left := ARect.Left + I * Delta;
          ColorBand.Right := ColorBand.Left + Delta;
        end;
      end; {case}
      { Calculate the color band's color }
      Brush := CreateSolidBrush(RGB(
        StartRGB[0] + MulDiv(I, RGBDelta[0], Colors - 1),
        StartRGB[1] + MulDiv(I, RGBDelta[1], Colors - 1),
        StartRGB[2] + MulDiv(I, RGBDelta[2], Colors - 1)));
      FillRect(Canvas.Handle, ColorBand, Brush);
      DeleteObject(Brush);
    end;
  end;
  If Direction in [fdTopToBottom, fdBottomToTop] then
    Delta := HeightOf(ARect) mod Colors
  else Delta := WidthOf(ARect) mod Colors;
  If Delta > 0 then begin
    case Direction of
      { Calculate the color band's top and bottom coordinates }
      fdTopToBottom, fdBottomToTop: begin
        ColorBand.Top := ARect.Bottom - Delta;
        ColorBand.Bottom := ColorBand.Top + Delta;
      end;
      { Calculate the color band's left and right coordinates }
      fdLeftToRight, fdRightToLeft: begin
        ColorBand.Left := ARect.Right - Delta;
        ColorBand.Right := ColorBand.Left + Delta;
      end;
    end; {case}
    case Direction of
      fdTopToBottom, fdLeftToRight:
        Brush := CreateSolidBrush(EndColor);
      else {fdBottomToTop, fdRightToLeft }
        Brush := CreateSolidBrush(StartColor);
    end;
    FillRect(Canvas.Handle, ColorBand, Brush);
    DeleteObject(Brush);
  end;
end;

procedure GradientXPFillRect (ACanvas : TCanvas; ARect : TRect; LightColor : TColor; DarkColor : TColor; Colors : Byte);
const
  cLightColorOffset : Integer = 30;
  cMainBarOffset : Integer = 6;
var
  DRect : TRect;
  I : Integer;
  mLColor,mDColor:TColor;
begin
  If IsRectEmpty(ARect) then Exit;

  ACanvas.Brush.Style := bsSolid;
  ACanvas.Brush.Color := DarkColor;
  ACanvas.FrameRect (ARect);
  //InflateRect (ARect, -1, -1);

  //Main center rect
  DRect := ARect;
  DRect.Left := DRect.Left + cMainBarOffset;
  DRect.Top := DRect.Top + cMainBarOffset;
  DRect.Bottom := DRect.Bottom - cMainBarOffset;
  GradientSimpleFillRect (ACanvas, DRect, DarkColor, LightColor, fdTopToBottom, Colors);

  //Bottom rect
  DRect := ARect;
  DRect.Left := DRect.Left + cMainBarOffset;
  DRect.Top := ARect.Bottom - cMainBarOffset;
  GradientSimpleFillRect (ACanvas, DRect, LightColor, DarkColor, fdTopToBottom, Colors);

  //Second left rect
  DRect := ARect;
  DRect := Rect (ARect.Left + cMainBarOffset div 4, 0, ARect.Left + cMainBarOffset, 1);
  For I := ARect.Top + cMainBarOffset to ARect.Bottom do begin
    DRect.Top := I;
    DRect.Bottom := I+1;
    GradientSimpleFillRect (ACanvas, DRect, ACanvas.Pixels [DRect.Left-1, DRect.Top],
      ACanvas.Pixels [DRect.Right + 1, DRect.Top], fdLeftToRight, 8);
  end;

  //Top light rect
  DRect := ARect;
  DRect.Left := DRect.Left + cMainBarOffset;
  DRect.Bottom := DRect.Top + cMainBarOffset div 4;
  GradientSimpleFillRect (ACanvas, DRect, MakeDarkColor (LightColor, -cLightColorOffset), LightColor, fdTopToBottom, 8);

  //Second top rect
  DRect := ARect;
  DRect.Left := DRect.Left + cMainBarOffset;
  DRect.Top := DRect.Top + cMainBarOffset div 4;
  DRect.Bottom := ARect.Top + cMainBarOffset;
  GradientSimpleFillRect (ACanvas, DRect, LightColor, DarkColor, fdTopToBottom, 8);

  //Left light rect
  DRect := ARect;
  DRect.Top := DRect.Top + cMainBarOffset;
  DRect.Right := DRect.Left + cMainBarOffset div 4;
  GradientSimpleFillRect (ACanvas, DRect, MakeDarkColor (LightColor, -cLightColorOffset), LightColor, fdLeftToRight, 8);

  //Second left rect
  DRect := ARect;
  DRect := Rect (ARect.Left + cMainBarOffset div 4, 0, ARect.Left + cMainBarOffset, 1);
  For I := ARect.Top + cMainBarOffset to ARect.Bottom do begin
    DRect.Top := I;
    DRect.Bottom := I+1;
    mLColor := ACanvas.Pixels [DRect.Left-1, DRect.Top];
    mDColor := ACanvas.Pixels [DRect.Right + 1, DRect.Top];
    If mLColor=-1 then mLColor := LightColor;
    If mDColor=-1 then mDColor := DarkColor;
    GradientSimpleFillRect (ACanvas, DRect, mLColor,
      mDColor, fdLeftToRight, 8);
//    GradientSimpleFillRect (ACanvas, DRect, ACanvas.Pixels [DRect.Left-1, DRect.Top],
//      ACanvas.Pixels [DRect.Right + 1, DRect.Top], fdLeftToRight, 8);
//    GradientSimpleFillRect (ACanvas, DRect, -1, -1, fdLeftToRight, 8);
  end;

  For I := 0 to cMainBarOffset do begin
    ACanvas.Pen.Color := ACanvas.Pixels [ARect.Left + I, ARect.Top + cMainBarOffset+1];
    ACanvas.LineTo (ARect.Left + I, ARect.Top + I);
    ACanvas.LineTo (ARect.Left + cMainBarOffset, ARect.Top + I);
  end;
end;

procedure GradientFillRect(Canvas: TCanvas; ARect: TRect; StartColor,
  EndColor: TColor; Direction: TFillDirection; Colors: Byte);
var
  BRect : TRect;   Brush: HBrush;
begin
  case Direction of
    fdVerticalFromCenter:
      begin
        BRect := ARect;
        BRect.Bottom := BRect.Top +  HeightOf (ARect) div 2;
        GradientSimpleFillRect(Canvas, BRect, StartColor, EndColor, fdTopToBottom, Colors);
        BRect.Top := (BRect.Top + HeightOf (ARect) div 2);
        BRect.Bottom := ARect.Bottom;
        GradientSimpleFillRect(Canvas, BRect, StartColor, EndColor, fdBottomToTop, Colors);
      end;
    fdHorizFromCenter:
      begin
        BRect := ARect;
        BRect.Right := BRect.Left +  WidthOf (ARect) div 2;
        GradientSimpleFillRect(Canvas, BRect, StartColor, EndColor, fdLeftToRight, Colors);
        BRect.Left := (BRect.Left + WidthOf (ARect) div 2);
        BRect.Right := ARect.Right;
        GradientSimpleFillRect(Canvas, BRect, StartColor, EndColor, fdRightToLeft, Colors);
      end;
    fdXP:
      begin
        GradientXPFillRect (Canvas, ARect, StartColor, EndColor, Colors);
      end;
    fdDown:
      begin
       Brush := CreateSolidBrush(ColorToRGB(clCream));
       FillRect(Canvas.Handle, ARect, Brush);
       DeleteObject(Brush);
      end
    else
      GradientSimpleFillRect(Canvas, ARect, StartColor, EndColor, Direction, Colors);
  end;
end;

function HeightOf(R: TRect): Integer;
begin
  Result := R.Bottom - R.Top;
end;

function WidthOf(R: TRect): Integer;
begin
  Result := R.Right - R.Left;
end;

function Max (Value1, Value2 : Integer) : Integer;
begin
  If Value1 > Value2 then Result := Value1 else Result := Value2;
end;

function Min (Value1, Value2 : Integer) : Integer;
begin
  If Value1 < Value2 then Result := Value1 else Result := Value2;
end;

procedure TileImage(Canvas: TCanvas; Rect: TRect; Image: TGraphic);
var
  X, Y: Integer;
  SaveIndex: Integer;
begin
  if (Image.Width = 0) or (Image.Height = 0) then Exit;
  SaveIndex := SaveDC(Canvas.Handle);
  try
    with Rect do
      IntersectClipRect(Canvas.Handle, Left, Top, Right, Bottom);
    for X := 0 to (WidthOf(Rect) div Image.Width) do
      for Y := 0 to (HeightOf(Rect) div Image.Height) do
        Canvas.Draw(Rect.Left + X * Image.Width,
          Rect.Top + Y * Image.Height, Image);
  finally
    RestoreDC(Canvas.Handle, SaveIndex);
  end;
end;


// TStringListProperty
function TStringListProperty.GetAttributes: TPropertyAttributes;
begin
  Result := [paValueList, paSortList, paMultiSelect];
end;

procedure TStringListProperty.GetValueList(List: TStrings);
begin
end;

procedure TStringListProperty.GetValues(Proc: TGetStrProc);
var
  I: Integer;
  Values: TStringList;
begin
  Values := TStringList.Create;
  try
    GetValueList(Values);
    for I := 0 to Values.Count - 1 do Proc(Values[I]);
  finally
    Values.Free;
  end;
end;

// TFieldNameProperty
procedure TFieldNameProperty.GetValueList(List: TStrings);
var mDataTable: TDataTable;
begin
  mDataTable := GetObjectProp(GetComponent(0), 'DataSource') as TDataTable;
  If (mDataTable <> nil) and (mDataTable.DataSet <> nil)
    then mDataTable.DataSet.GetFieldNames(List)
    else begin
      List.Clear;
      List.Add('GSCode');
      List.Add('GSName');
      List.Add('Quant');
      List.Add('Prc');
      List.Add('Price');
      List.Add('Value');
      List.Add('Date');
      List.Add('Time');
    end;
end;

// TxpPageControlEditor
procedure TxpPageControlEditor.ExecuteVerb(Index: Integer);
var
  PageControl: TxpPageControl;
  Page: TxpTabSheet;
  ADesigner: IDesigner;
begin
  if Component is TTabSheet then
    PageControl := TxpTabSheet(Component).PageControl as TxpPageControl
  else
    PageControl := TxpPageControl(Component);
  if PageControl <> nil then
  begin
    ADesigner := Self.Designer;
    if Index = 0 then
    begin
      Page := TxpTabSheet.Create(ADesigner.Root);
      try
        Page.Name := ADesigner.UniqueName(TxpTabSheet.ClassName);
        Page.Parent := PageControl;
        Page.PageControl := PageControl
      except
        Page.Free;
        raise
      end;
      PageControl.ActivePage := Page;
      PageControl.UpdateGlyphs
    end else begin
      Page := PageControl.FindNextPage(PageControl.ActivePage,Index = 1, False) as TxpTabSheet;
      if (Page <> nil) and (Page <> PageControl.ActivePage) then
        PageControl.ActivePage := Page
    end;

    ADesigner.SelectComponent(Page);
    ADesigner.Modified
  end
end;

function TxpPageControlEditor.GetVerb(Index: Integer): string;
begin
  case Index of
    0 : Result := 'New XP page';
    1 : Result := 'Next page';
    2 : Result := 'Previous page'
  end
end;

function TxpPageControlEditor.GetVerbCount: Integer;
begin
  Result := 3
end;

// TDataTable

constructor TDataTable.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  FAutoUpdate := TRUE;
  FldList := TStringList.Create;
  FldList.Clear;
end;

destructor TDataTable.Destroy;
begin
  FreeAndNil (FldList);
  inherited Destroy;
end;

procedure TDataTable.ClearData;
var
  mComp:TComponent; I:longint;
  mOwn, mCmp, mFld, mS:string;
begin
  If FldList.Count>0 then begin
    For I:= 0 to FldList.Count-1 do begin
      mOwn := Copy (FldList[I],1,Pos ('.',FldList[I])-1);
      mCmp := Copy (FldList[I],Pos ('.',FldList[I])+1,Pos (',',FldList[I])-Pos ('.',FldList[I])-1);
      mComp := Application.FindComponent(mOwn).FindComponent(mCmp);
      If mComp<>nil then begin
        If mComp is TxpEdit then begin
          (mComp as TxpEdit).Text := '';
          (mComp as TxpEdit).AsFloat := 0;
          (mComp as TxpEdit).AsInteger := 0;
          (mComp as TxpEdit).AsDateTime := 0;

          If (mComp as TxpEdit).ExtTextShow then begin
            mS := UpperCase ((mComp as TxpEdit).ExtFieldName);
            If (mComp as TxpEdit).ExtFieldName<>'' then begin
              mFld := UpperCase((mComp as TxpEdit).FieldName);
              If (Pos ('QNT',mFld)>0) or (Pos ('QUANT',mFld)>0) then (mComp as TxpEdit).ExtText := 'MJ';
              If (Pos ('PRICE',mFld)>0) then (mComp as TxpEdit).ExtText := cCoin+'/MJ';
            end;
          end;
        end;

        If mComp is TxpLabel then begin
          (mComp as TxpLabel).Caption := '';
        end;
        If mComp is TxpMemo then begin
          (mComp as TxpMemo).Text := '';
        end;
      end;
    end;
  end;
end;

procedure TDataTable.ReadData;
var
  mComp:TComponent; I:longint;
  mOwn, mCmp, mFld, mS:string; mDvz, mMsName:string;
begin
  If FldList.Count>0 then begin
//    DataSet.Refresh;
    For I:= 0 to FldList.Count-1 do begin
      mOwn := Copy (FldList[I],1,Pos ('.',FldList[I])-1);
      mCmp := Copy (FldList[I],Pos ('.',FldList[I])+1,Pos (',',FldList[I])-Pos ('.',FldList[I])-1);
      mFld := Copy (FldList[I],Pos (',',FldList[I])+1, Length (FldList[I]));
      mComp := Application.FindComponent(mOwn).FindComponent(mCmp);
      If mComp<>nil then begin
        If mComp is TxpEdit then begin
          case (mComp as TxpEdit).EditorType of
            etString: (mComp as TxpEdit).Text := DataSet.FieldByName(mFld).AsString;
            etFloat : (mComp as TxpEdit).AsFloat := DataSet.FieldByName(mFld).AsFloat;
            etInteger: (mComp as TxpEdit).AsInteger := DataSet.FieldByName(mFld).AsInteger;
            etDate, etTime, etDateTime: begin
              If DataSet.FieldByName(mFld).AsString=''
                then (mComp as TxpEdit).AsDateTime := 0
                else (mComp as TxpEdit).AsDateTime := DataSet.FieldByName(mFld).AsDateTime;
            end;
          end;
          If (mComp as TxpEdit).ExtTextShow then begin
            mS := UpperCase ((mComp as TxpEdit).ExtFieldName);
            If (mComp as TxpEdit).ExtFieldName<>'' then begin
              If (Pos ('QNT',UpperCase (mFld))>0) or (Pos ('QUANT',UpperCase (mFld))>0) then (mComp as TxpEdit).ExtText := DataSet.FieldByName((mComp as TxpEdit).ExtFieldName).AsString;
              If (Pos ('PRICE',UpperCase (mFld))>0) then begin
                If Pos ('DVZ',UpperCase ((mComp as TxpEdit).ExtFieldName))>0 then begin
                  If Pos (',', (mComp as TxpEdit).ExtFieldName)>0 then begin
                    mDvz := Copy ((mComp as TxpEdit).ExtFieldName,1,Pos (',', (mComp as TxpEdit).ExtFieldName)-1);
                    mMsName := Copy ((mComp as TxpEdit).ExtFieldName,Pos (',', (mComp as TxpEdit).ExtFieldName)+1, Length ((mComp as TxpEdit).ExtFieldName));
                    (mComp as TxpEdit).ExtText := DataSet.FieldByName(mDvz).AsString+'/'+DataSet.FieldByName(mMsName).AsString;
                  end else begin
                    mDvz := (mComp as TxpEdit).ExtFieldName;
                    (mComp as TxpEdit).ExtText := DataSet.FieldByName(mDvz).AsString;
                  end;
                end else (mComp as TxpEdit).ExtText := cCoin+'/'+DataSet.FieldByName((mComp as TxpEdit).ExtFieldName).AsString;
              end;
              If (Pos ('VAL',UpperCase (mFld))>0) or (Pos ('VALUE',UpperCase (mFld))>0) then begin
                If Pos ('DVZ',UpperCase ((mComp as TxpEdit).ExtFieldName))>0 then begin
                  (mComp as TxpEdit).ExtText := DataSet.FieldByName((mComp as TxpEdit).ExtFieldName).AsString;
                end;
              end;
            end;
          end;
        end;

        If mComp is TxpLabel then begin
          (mComp as TxpLabel).Caption := DataSet.FieldByName(mFld).AsString;
        end;

        If mComp is TxpMemo then begin
          (mComp as TxpMemo).Text := DataSet.FieldByName(mFld).AsString;
        end;

        If mComp is TxpCheckBox then begin
          (mComp as TxpCheckBox).Checked := DataSet.FieldByName(mFld).AsString=(mComp as TxpCheckBox).CheckData;
        end;

        If mComp is TxpComboBox then begin
          (mComp as TxpComboBox).FindData (DataSet.FieldByName(mFld).AsString);
          (mComp as TxpComboBox).Text := DataSet.FieldByName(mFld).AsString;
        end;
      end;
    end;
  end;
end;

procedure TDataTable.SaveData;
var
  mComp:TComponent; I:longint;
  mOwn, mCmp, mFld:string; mFloat:double;
begin
  If FAutoUpdate then DataSet.Edit;
  If DataSet.State in [dsEdit, dsInsert] then begin
    If FldList.Count>0 then begin
      For I:= 0 to FldList.Count-1 do begin
        mOwn := Copy (FldList[I],1,Pos ('.',FldList[I])-1);
        mCmp := Copy (FldList[I],Pos ('.',FldList[I])+1,Pos (',',FldList[I])-Pos ('.',FldList[I])-1);
        mFld := Copy (FldList[I],Pos (',',FldList[I])+1, Length (FldList[I]));
        mComp := Application.FindComponent(mOwn).FindComponent(mCmp);
        If mComp<>nil then begin
          If mComp is TxpEdit then begin
            mFloat := (mComp as TxpEdit).AsFloat;
            case (mComp as TxpEdit).EditorType of
              etString: DataSet.FieldByName(mFld).AsString := (mComp as TxpEdit).Text;
              etFloat : DataSet.FieldByName(mFld).AsFloat := (mComp as TxpEdit).AsFloat;
              etInteger: DataSet.FieldByName(mFld).AsInteger := (mComp as TxpEdit).AsInteger;
              etDate, etTime, etDateTime: begin
                If (mComp as TxpEdit).Text=''
                  then DataSet.FieldByName(mFld).AsString := ''
                  else DataSet.FieldByName(mFld).AsDateTime := (mComp as TxpEdit).AsDateTime;
              end;
            end;
          end;
          If mComp is TxpMemo then begin
            DataSet.FieldByName(mFld).AsString := (mComp as TxpMemo).Text;
          end;
        end;
      end;
    end;
    If FAutoUpdate then DataSet.Post;
  end;
end;

procedure TDataTable.AddField (pField:string);
begin
  FldList.Add(pField);
end;

// TColorStringGrid
procedure TColorStringGrid.DrawCell(ACol, ARow: Longint; ARect: TRect;AState: TGridDrawState);
var mColor:TColor;
begin
  If Assigned (eDrawColorCell) then begin
    eDrawColorCell (Self, ACol, ARow, ARect, AState, mColor);
    Canvas.Font.Color := mColor;
  end;
  inherited;
end;



// TxpEditColors

constructor TxpEditColors.Create;
begin
  inherited Create;
  FChanged := FALSE;
end;

procedure TxpEditColors.SetBGNormal (AValue:TColor);
begin
  If FBGNormal<>AValue then begin
    FBGNormal := AValue;
    FChanged := TRUE;
  end;
end;

procedure TxpEditColors.SetBGReadOnly (AValue:TColor);
begin
  If FBGReadOnly<>AValue then begin
    FBGReadOnly := AValue;
    FChanged := TRUE;
  end;
end;

procedure TxpEditColors.SetBGInfoField (AValue:TColor);
begin
  If FBGInfoField<>AValue then begin
    FBGInfoField := AValue;
    FChanged := TRUE;
  end;
end;

procedure TxpEditColors.SetBGActive (AValue:TColor);
begin
  If FBGActive<>AValue then begin
    FBGActive := AValue;
    FChanged := TRUE;
  end;
end;

procedure TxpEditColors.SetBGModify (AValue:TColor);
begin
  If FBGModify<>AValue then begin
    FBGModify := AValue;
    FChanged := TRUE;
  end;
end;

procedure TxpEditColors.SetBGExtText (AValue:TColor);
begin
  If FBGExtText<>AValue then begin
    FBGExtText := AValue;
    FChanged := TRUE;
  end;
end;

procedure TxpEditColors.SetInactBorder (AValue:TColor);
begin
  If FInactBorder<>AValue then begin
    FInactBorder := AValue;
    FChanged := TRUE;
  end;
end;

procedure TxpEditColors.SetActBorder (AValue:TColor);
begin
  If FActBorder<>AValue then begin
    FActBorder := AValue;
    FChanged := TRUE;
  end;
end;

{ TxpEdit }
constructor TxpEdit.Create(AOwner: TComponent);
const
  EditStyle = [csClickEvents, csSetCaption, csDoubleClicks];
begin
  inherited Create(AOwner);
//  Parent:=TWinControl(AOwner);
  FEditColors := TxpEditColors.Create;

  ControlStyle := EditStyle;
  Width := 121;
  Height := 18;
  TabStop := TRUE;
  ParentFont := FALSE;
  Font.Size := 10;
  Font.Name := 'Courier New';
  ParentColor := FALSE;
  FAutoSelect := TRUE;
  FHideSelection := TRUE;
  FSystemColor := TRUE;
  Color := clIccEditorBGNormal;
//  RefreshSystemColor;
  FActive := FALSE;
  FFocused := FALSE;
  FVerifyDate:= TRUE;
  FRounded := TRUE;
  FRoundRadius := crcRadius;
  FMarginLeft := 2;
  FMarginRight := 2;
  FExtMargin := 0;
  FAlignment := taLeftJustify;
  FAutoFieldSet := TRUE;
  FAutoCR := TRUE;
  FNumSepar := TRUE;
  oBasicColor := cbcBasicColor;

  FOldValue := Text;
end;

destructor  TxpEdit.Destroy;
begin
  Brush.Bitmap.Free;
  FreeAndNil (FEditColors);
  inherited;
end;

procedure TxpEdit.DoSetMaxLength(Value: Integer);
begin
  SendMessage(Handle, EM_LIMITTEXT, Value, 0)
end;

procedure TxpEdit.SetCharCase(Value: TEditCharCase);
begin
  If FCharCase <> Value then begin
    FCharCase := Value;
    RecreateWnd;
  end;
end;

procedure TxpEdit.SetHideSelection(Value: Boolean);
begin
  If FHideSelection <> Value then begin
    FHideSelection := Value;
    RecreateWnd;
  end;
end;

procedure TxpEdit.SetMaxLength(Value: Integer);
begin
  If FMaxLength <> Value then begin
    FMaxLength := Value;
    If HandleAllocated then DoSetMaxLength(Value);
  end;
end;

procedure TxpEdit.SetOEMConvert(Value: Boolean);
begin
  If FOEMConvert <> Value then begin
    FOEMConvert := Value;
    RecreateWnd;
  end;
end;

function TxpEdit.GetModified: Boolean;
begin
  Result := FModified;
  If HandleAllocated then Result := SendMessage(Handle, EM_GETMODIFY, 0, 0) <> 0;
end;

function TxpEdit.GetCanUndo: Boolean;
begin
  Result := FALSE;
  If HandleAllocated then Result := SendMessage(Handle, EM_CANUNDO, 0, 0) <> 0;
end;

procedure TxpEdit.SetModified(Value: Boolean);
begin
  If HandleAllocated
    then SendMessage(Handle, EM_SETMODIFY, Byte(Value), 0)
    else FModified := Value;
end;

procedure TxpEdit.SetPasswordChar(Value: Char);
begin
  If FPasswordChar <> Value then begin
    FPasswordChar := Value;
    If HandleAllocated then begin
      SendMessage(Handle, EM_SETPASSWORDCHAR, Ord(FPasswordChar), 0);
      SetTextBuf(PChar(Text));
    end;
  end;
end;

procedure TxpEdit.SetReadOnly(Value: Boolean);
begin
  If FReadOnly <> Value then begin
    FReadOnly := Value;
    If FReadOnly
      then Color := FEditColors.FBGReadOnly
      else Color := FEditColors.FBGNormal;
    If HandleAllocated then
      SendMessage(Handle, EM_SETREADONLY, Ord(Value), 0);
  end;
end;

function TxpEdit.GetSelStart: Integer;
begin
  SendMessage(Handle, EM_GETSEL, Longint(@Result), 0);
end;

procedure TxpEdit.SetSelStart(Value: Integer);
begin
  SendMessage(Handle, EM_SETSEL, Value, Value);
end;

procedure TxpEdit.WMPaint(var Message: TWMPaint);
begin
  inherited;
  If FSystemColor then RefreshSystemColor;
  If FReadOnly then begin
    If FInfoField
      then Color := FEditColors.FBGInfoField
      else Color := FEditColors.FBGReadOnly;
  end;
  PaintExtText;
end;

procedure TxpEdit.WMNCPaint (var Message : TWMNCPaint);
var
  DC : hDC;
  Brush : hBrush;
  Pen : hPen;
  lBrush : TLogBrush;
  UpdateRect : TRect;
  AColor : TColor;
  Rgn : hRgn;
begin
  inherited;
  If FSystemColor then RefreshSystemColor;
  If FReadOnly then begin
    If FInfoField
      then Color := FEditColors.FBGInfoField
      else Color := FEditColors.FBGReadOnly;
  end;
  DC := GetWindowDC (Handle);
  GetWindowRect (Handle, UpdateRect);
  OffsetRect (UpdateRect, - UpdateRect.Left, - UpdateRect.Top);
  If FActive or FFocused
    then AColor := FEditColors.ActBorder
    else AColor := FEditColors.InactBorder;

  If FRounded then Rgn := CreateRoundRectRgn (0,0,Width+1, Height+1, FRoundRadius, FRoundRadius);
  If FRounded then begin
    Brush := CreateSolidBrush (ColorToRGB (AColor));
    FrameRgn (DC, Rgn, Brush, 1, 1);
    DeleteObject (Brush);
    DeleteObject (Rgn);

    Rgn := CreateRoundRectRgn (1,1,Width, Height, FRoundRadius, FRoundRadius);
    Brush := CreateSolidBrush (ColorToRGB (Color));
    FrameRgn (DC, Rgn, Brush, 1, 1);
    DeleteObject (Brush);
  end else begin
    Brush := CreateSolidBrush (ColorToRGB (AColor));
    FrameRect (DC, UpdateRect, Brush);
    DeleteObject (Brush);

    InflateRect (UpdateRect, -1, -1);
    Brush := CreateSolidBrush (ColorToRGB (Color));
    FrameRect (DC, UpdateRect, Brush);
    DeleteObject (Brush);
  end;
  ReleaseDC (Handle, DC);

  If FRounded then DeleteObject(Rgn);
  PaintExtText;
end;

procedure TxpEdit.WMNCCalcSize (var Message : TWMNCCalcSize);
begin
  InflateRect (Message.CalcSize_Params^.rgrc[0], -2, -2);
end;

procedure TxpEdit.MouseEnter (var Message : TMessage);
begin
  If not FActive then begin
    FActive := TRUE;
//    FOldValue := Text;
    SendMessage (Handle, WM_NCPAINT, 0, 0);
  end;
end;

procedure TxpEdit.MouseLeave (var Message : TMessage);
begin
  If FActive then begin
    FActive := FALSE;
    SendMessage (Handle, WM_NCPAINT, 0, 0);
  end;
end;

procedure TxpEdit.WMSize(var Message: TWMSize);
begin
  inherited;
  SetShape (FRounded);
  SetEditRect;
end;

procedure TxpEdit.KeyDown(var Key: Word; Shift: TShiftState);
var Msg: TMsg; mForm:TCustomForm;
begin
  DataConvert2;
  inherited KeyDown(Key, Shift);
  mForm := GetParentForm (Self);
  If Key in [VK_ESCAPE] then begin
    If FOldValue<>Text then begin
      Text := FOldValue;
      Key := 0;
      SelectAll;
    end else begin
//      (Owner as TForm).Close;
      mForm.Close;
    end;
  end;
  If (Key in [VK_RETURN])  and FAutoCR then begin
//    SendMessage((Owner as TForm).Handle, WM_NEXTDLGCTL, 0, 0);
    SendMessage(mForm.Handle, WM_NEXTDLGCTL, 0, 0);
    // Vypnutie sysutils.beep po opusteni pola formulara inou klavesou ako TAB
    PeekMessage(Msg, 0, WM_CHAR, WM_CHAR, PM_REMOVE);
  end;
  If (Key = VK_DOWN) then begin
//    SendMessage((Owner as TForm).Handle, WM_NEXTDLGCTL, 0, 0);
    SendMessage(mForm.Handle, WM_NEXTDLGCTL, 0, 0);
    // Vypnutie sysutils.beep po opusteni pola formulara inou klavesou ako TAB
    PeekMessage(Msg, 0, WM_CHAR, WM_CHAR, PM_REMOVE);
  end;
  If (Key = VK_UP) then begin
//    SendMessage ((Owner as TForm).Handle,WM_NEXTDLGCTL,1,0);
    SendMessage (mForm.Handle,WM_NEXTDLGCTL,1,0);
    // Vypnutie sysutils.beep po opusteni pola formulara inou klavesou ako TAB
    PeekMessage(Msg, 0, WM_CHAR, WM_CHAR, PM_REMOVE);
  end;
end;

procedure TxpEdit.KeyUp(var Key: Word; Shift: TShiftState);
begin
  If FOldValue<>Text then begin
    If not FReadOnly and not FInfoField then Color := FEditColors.BGModify;
    SendMessage (Handle, WM_NCPAINT, 0, 0);
  end else begin
    If not FReadOnly and not FInfoField then Color := FEditColors.BGActive;
    SendMessage (Handle, WM_NCPAINT, 0, 0);
  end;
end;

procedure TxpEdit.Loaded;
begin
  inherited;
  SetShape (FRounded);
  SetEditRect;
end;

procedure TxpEdit.SetEditRect;
begin
  If FExtTextShow and (FMarginRight+FExtMargin-3>0)
    then SendMessage(Handle, EM_SETMARGINS, EC_LEFTMARGIN or EC_RIGHTMARGIN, MakeLong (FMarginLeft, FMarginRight+FExtMargin-3))
    else SendMessage(Handle, EM_SETMARGINS, EC_LEFTMARGIN or EC_RIGHTMARGIN, MakeLong (FMarginLeft, FMarginRight));
end;

function TxpEdit.GetSelLength: Integer;
var
  Selection: TSelection;
begin
  SendMessage(Handle, EM_GETSEL, Longint(@Selection.StartPos), Longint(@Selection.EndPos));
  Result := Selection.EndPos - Selection.StartPos;
end;

procedure TxpEdit.SetSelLength(Value: Integer);
var
  Selection: TSelection;
begin
  SendMessage(Handle, EM_GETSEL, Longint(@Selection.StartPos), Longint(@Selection.EndPos));
  Selection.EndPos := Selection.StartPos + Value;
  SendMessage(Handle, EM_SETSEL, Selection.StartPos, Selection.EndPos);
  SendMessage(Handle, EM_SCROLLCARET, 0,0);
end;

procedure TxpEdit.Clear;
begin
  SetWindowText(Handle, '');
  FInteger := 0;
  FFloat := 0;
  FDateTime := 0;
  FOldValue := '';
  ShowEditorData;
end;

procedure TxpEdit.ShowEditorData;
begin
  case FEditorType of
    etDate    :
      begin
        If FDateTime=0
          then Text := ''
          else Text := DateToStr (FDateTime);
      end;
    etTime    : Text := TimeToStr (FDateTime);
    etDateTime:
      begin
        If FDateTime=0
          then Text := ''
          else Text := DateTimeToStr (FDateTime);
      end;
    etInteger :
      begin
        If FNumSepar
          then Text := StrDoubSepar (AsInteger, 0, 0)
          else Text := StrDoub (AsInteger, 0, 0);
      end;
    etFloat   :
      begin
        If FNumSepar
          then Text := StrDoubSepar (AsFloat, 0, FFrac)
          else Text := StrDoub (AsFloat, 0, FFrac);
      end;
  end;
  AsString := Text;
end;

procedure TxpEdit.ClearSelection;
begin
  SendMessage(Handle, WM_CLEAR, 0, 0);
end;

procedure TxpEdit.CopyToClipboard;
begin
  SendMessage(Handle, WM_COPY, 0, 0);
end;

procedure TxpEdit.CutToClipboard;
begin
  SendMessage(Handle, WM_CUT, 0, 0);
end;

procedure TxpEdit.PasteFromClipboard;
begin
  SendMessage(Handle, WM_PASTE, 0, 0);
end;

procedure TxpEdit.Undo;
begin
  SendMessage(Handle, WM_UNDO, 0, 0);
end;

procedure TxpEdit.ClearUndo;
begin
  SendMessage(Handle, EM_EMPTYUNDOBUFFER, 0, 0);
end;

procedure TxpEdit.SelectAll;
begin
  SendMessage(Handle, EM_SETSEL, 0, -1);
end;

function TxpEdit.GetSelTextBuf(Buffer: PChar; BufSize: Integer): Integer;
var
  P: PChar;
  StartPos: Integer;
begin
  StartPos := GetSelStart;
  Result := GetSelLength;
  P := StrAlloc(GetTextLen + 1);
  try
    GetTextBuf(P, StrBufSize(P));
    if Result >= BufSize then Result := BufSize - 1;
    StrLCopy(Buffer, P + StartPos, Result);
  finally
    StrDispose(P);
  end;
end;

procedure TxpEdit.SetSelTextBuf(Buffer: PChar);
begin
  SendMessage(Handle, EM_REPLACESEL, 0, LongInt(Buffer));
end;

procedure TxpEdit.NoModified;
begin
  FOldValue := Text;
end;

function TxpEdit.GetSelText: string;
var
  P: PChar;
  SelStart, Len: Integer;
begin
  SelStart := GetSelStart;
  Len := GetSelLength;
  SetString(Result, PChar(nil), Len);
  If Len <> 0 then begin
    P := StrAlloc(GetTextLen + 1);
    try
      GetTextBuf(P, StrBufSize(P));
      Move(P[SelStart], Pointer(Result)^, Len);
    finally
      StrDispose(P);
    end;
  end;
end;

procedure TxpEdit.SetSelText(const Value: String);
begin
  SendMessage(Handle, EM_REPLACESEL, 0, Longint(PChar(Value)));
end;

procedure TxpEdit.CreateParams(var Params: TCreateParams);
const
  Passwords: array[Boolean] of DWORD = (0, ES_PASSWORD);
  ReadOnlys: array[Boolean] of DWORD = (0, ES_READONLY);
  CharCases: array[TEditCharCase] of DWORD = (0, ES_UPPERCASE, ES_LOWERCASE);
  HideSelections: array[Boolean] of DWORD = (ES_NOHIDESEL, 0);
  OEMConverts: array[Boolean] of DWORD = (0, ES_OEMCONVERT);
begin
  inherited CreateParams(Params);
  CreateSubClass(Params, 'EDIT');
  with Params do begin
    Style := Style or (ES_AUTOHSCROLL or ES_AUTOVSCROLL) or
      Passwords[FPasswordChar <> #0] or
      ReadOnlys[FReadOnly] or CharCases[FCharCase] or
      HideSelections[FHideSelection] or OEMConverts[FOEMConvert];
    If NewStyleControls then begin
      Style := Style and not WS_BORDER;
      ExStyle := ExStyle or WS_EX_CLIENTEDGE;
    end;
  end;
 case FAlignment of
    taLeftJustify: Params.Style := Params.Style or ES_LEFT and not ES_MULTILINE;
    taRightJustify: Params.Style := Params.Style or ES_RIGHT and not ES_MULTILINE;
    taCenter: Params.Style := Params.Style or ES_CENTER and not ES_MULTILINE;
  end;
end;

procedure TxpEdit.CreateWindowHandle(const Params: TCreateParams);
var
  P: TCreateParams;
begin
  If SysLocale.FarEast and (Win32Platform <> VER_PLATFORM_WIN32_NT) and
    ((Params.Style and ES_READONLY) <> 0) then begin
    // Work around Far East Win95 API/IME bug.
    P := Params;
    P.Style := P.Style and (not ES_READONLY);
    inherited CreateWindowHandle(P);
    If WindowHandle <> 0 then
      SendMessage(WindowHandle, EM_SETREADONLY, Ord(TRUE), 0);
  end else
    inherited CreateWindowHandle(Params);
end;

procedure TxpEdit.CreateWnd;
begin
  FCreating := TRUE;
  try
    inherited CreateWnd;
  finally
    FCreating := FALSE;
  end;
  DoSetMaxLength(FMaxLength);
  Modified := FModified;
  If FPasswordChar <> #0 then SendMessage(Handle, EM_SETPASSWORDCHAR, Ord(FPasswordChar), 0);
  SetShape (TRUE);
  SetEditRect;
end;

procedure TxpEdit.DestroyWnd;
begin
  FModified := Modified;
  inherited DestroyWnd;
end;

procedure TxpEdit.PaintExtText;
var
  DC : hDC;
  NCCanvas:TCanvas;
  mRect:TRect;
begin
  If FExtTextShow then begin
    DC := GetWindowDC (Handle);
    NCCanvas := TCanvas.Create;
    try
      NCCanvas.Handle := DC;
      NCCanvas.Lock;
      NCCanvas.Font.Assign(Font);
//      NCCanvas.Brush.Color := FEditColors.BGNormal;
//      mRect.Left := Width-FExtMargin+2;
//      mRect.Top := 1;
//      mRect.Right := Width-1;
//      mRect.Bottom := Height-1;
//      NCCanvas.FillRect(TRect(mRect));
      NCCanvas.Brush.Color := FEditColors.BGExtText;
      mRect.Left := Width-FExtMargin+3;
      mRect.Top := 2;
      mRect.Right := Width-2;
      mRect.Bottom := Height-2;
      NCCanvas.FillRect(TRect(mRect));
      NCCanvas.Font.Color := Font.Color;
      NCCanvas.TextOut (Width-FExtMargin+6,2,FExtText);
      NCCanvas.Pen.Color := FEditColors.InactBorder;
      NCCanvas.MoveTo(Width-FExtMargin+1,1);
      NCCanvas.LineTo(Width-FExtMargin+1,Height-1);
      NCCanvas.Brush.Color := Color;
      mRect.Left := Width-FExtMargin+2;
      mRect.Top := 1;
      mRect.Right := Width-1;
      mRect.Bottom := Height-1;
      NCCanvas.FrameRect(TRect(mRect));
      If FActive or FFocused
        then NCCanvas.Pen.Color := FEditColors.ActBorder
        else NCCanvas.Pen.Color := FEditColors.InactBorder;
      NCCanvas.MoveTo(Width-FExtMargin+1,Height-1);
      NCCanvas.LineTo(Width-3,Height-1);
      NCCanvas.Unlock;
    except end;
    NCCanvas.Free;
    ReleaseDC (Handle, DC);
  end;
end;

procedure TxpEdit.DataConvert2;
begin
  try
    case FEditorType of
      etInteger : FInteger := ValInt (ReplaceStr (Text,' ', ''));
      etFloat   : begin
                    FFloat := ValDoub (ReplaceStr (ReplaceStr (Text, ',', '.'),' ', ''));
                  end;
    end;
  except end;
end;

procedure TxpEdit.DataConvert;
begin
  try
    case FEditorType of
      etInteger : FInteger := ValInt (ReplaceStr (Text,' ', ''));
      etFloat   : begin
                    Text := ReplaceStr (Text, ',', '.');
                    FFloat := ValDoub (ReplaceStr (Text,' ', ''));
                  end;
      etDate    :
        begin
          If Text<>'' then begin
            try
              If FVerifyDate then Text := VerifyDate(Text);
              FDateTime := StrToDate (Text);
            except end;
          end else FDateTime := 0;
        end;
      etTime    : FDateTime := StrToTime (Text);
      etDateTime: begin
          If Text<>'' then begin
            try
              FDateTime := StrToDateTime (Text);
            except end;
          end else FDateTime := 0;
      end;
    end;
  except end;
end;

procedure TxpEdit.DataConvertToText;
var mSS:byte;
begin
  try
    mSS:=SelStart;
    case FEditorType of
      etInteger : begin
                    If FNumSepar
                      then Text := StrDoubSepar (FInteger, 0, 0)
                      else Text := StrDoub (FInteger, 0, 0);
                  end;
      etFloat   : begin
                    If FNumSepar
                      then Text := StrDoubSepar (FFloat, 0, FFrac)
                      else Text := StrDoub (FFloat, 0, FFrac);
                  end;
    end;
    If GetSelText='' then SelStart:=mSS;
  except end;
end;

procedure TxpEdit.Change;
begin
  inherited Changed;
  If Assigned(FOnChange) then FOnChange(Self);
end;

procedure TxpEdit.DefaultHandler(var Message);
begin
  case TMessage(Message).Msg of
    WM_SETFOCUS:
      If (Win32Platform = VER_PLATFORM_WIN32_WINDOWS) and
        not IsWindow(TWMSetFocus(Message).FocusedWnd) then
        TWMSetFocus(Message).FocusedWnd := 0;
  end;
  inherited;
end;

procedure TxpEdit.WMSetFont(var Message: TWMSetFont);
begin
  inherited;
  If NewStyleControls and (GetWindowLong(Handle, GWL_STYLE) and ES_MULTILINE = 0) then begin
//    SendMessage(Handle, EM_SETMARGINS, EC_LEFTMARGIN or EC_RIGHTMARGIN, 0);
    SetEditRect;
  end;
end;

procedure TxpEdit.CNCommand(var Message: TWMCommand);
begin
  If (Message.NotifyCode = EN_CHANGE) and not FCreating then Change;
end;

procedure TxpEdit.CMEnter(var Message: TCMGotFocus);
begin
  If FAutoSelect and not (csLButtonDown in ControlState) and
    (GetWindowLong(Handle, GWL_STYLE) and ES_MULTILINE = 0) then SelectAll;
  inherited;
  If not FFocused then begin
    If not FReadOnly and not FInfoField then begin
      If FSystemColor then RefreshSystemColor;
      Color := FEditColors.FBGActive;
    end;
    FFocused := TRUE;
    If  (EditorType=etFloat) or (EditorType=etInteger) then begin
      Text := ReplaceStr (Text, ' ', '');
      If FAutoSelect then SelectAll;
    end;
    SendMessage (Handle, WM_NCPAINT, 0, 0);
  end;
  FOldValue := Text;
end;

procedure TxpEdit.CMExit(var Message: TCMExit);
var mText:string;
begin
  If FFocused then begin
    Color := FEditColors.BGNormal;
    FFocused := FALSE;
    DataConvert;
    DataConvertToText;
    SendMessage (Handle, WM_NCPAINT, 0, 0);
  end;
  inherited;
  mText := Text;
  If  (EditorType=etFloat) or (EditorType=etInteger) then mText := ReplaceStr (mText, ' ', '');
  If (FOldValue<>mText) and Assigned(FOnModified) then FOnModified(Self);
end;

procedure TxpEdit.CMTextChanged(var Message: TMessage);
begin
  inherited;
  If not HandleAllocated or (GetWindowLong(Handle, GWL_STYLE) and
    ES_MULTILINE <> 0) then Change;
end;

procedure TxpEdit.WMContextMenu(var Message: TWMContextMenu);
begin
  SetFocus;
  inherited;
end;

procedure TxpEdit.SetRounded (AValue : Boolean);
begin
  If AValue <> FRounded then begin
    FRounded := AValue;
    SetShape (FRounded);
    Invalidate;
  end;
end;

procedure TxpEdit.SetRoundRadius (AValue : Integer);
begin
  If AValue < 1 then AValue := 1;
  If FRoundRadius <> AValue then begin
    FRoundRadius := AValue;
    SendMessage (Handle, WM_SIZE, 0, 0);
  end;
end;

procedure TxpEdit.SetShape (ARounded : Boolean);
var
  WinRgn : hRgn;
begin
  WinRgn := 0;
  GetWindowRgn (Handle, WinRgn);
  DeleteObject(WinRgn);
  If ARounded
    then WinRgn := CreateRoundRectRgn (0,0,Width+1, Height+1, FRoundRadius, FRoundRadius)
    else WinRgn := CreateRectRgn (0,0,Width+1, Height+1);
  SetWindowRgn (Handle, WinRgn, TRUE);
end;

procedure TxpEdit.SetMarginLeft (AValue : Word);
begin
  If FMarginLeft <> AValue then begin
    FMarginLeft := AValue;
    SetEditRect;
  end;
end;

procedure TxpEdit.SetMarginRight (AValue : Word);
begin
  If FMarginRight <> AValue then begin
    FMarginRight := AValue;
    SetEditRect;
  end;
end;

procedure TxpEdit.SetAlignment (AValue : TAlignment);
var
  dwStyle : longint;   mHandle:HWND;
begin
  If AValue <> FAlignment then begin
    FAlignment := AValue;

    mHandle := Handle;
    dwStyle := GetWindowLong(mHandle, GWL_STYLE);
    case FAlignment of
      taLeftJustify: dwStyle := dwStyle or ES_LEFT and not ES_MULTILINE and not ES_RIGHT and not ES_CENTER;
      taRightJustify: dwStyle := dwStyle or ES_RIGHT and not ES_MULTILINE and not ES_LEFT and not ES_CENTER;
      taCenter: dwStyle := dwStyle or ES_CENTER and not ES_MULTILINE and not ES_RIGHT and not ES_LEFT;
    end;
    SetWindowLong(mHandle, GWL_STYLE, dwStyle);
    RecreateWnd;
  end;
end;

procedure TxpEdit.SetEditorType (AValue: TEditorType);
begin
  If FEditorType<>AValue then begin
    case AValue of
      etString, etDate, etTime, etDateTime: Alignment := taLeftJustify;
      etFloat, etInteger: Alignment := taRightJustify;
    end;
    FEditorType := AValue;
    ShowEditorData;
  end;
end;

procedure TxpEdit.SetFrac (AValue:longint);
begin
  If FFrac<>AValue then begin
    FFrac := AValue;
    ShowEditorData;
  end;
end;

procedure TxpEdit.SetAsInteger (AValue:longint);
begin
//  If FInteger<>AValue then begin
    FInteger := AValue;
    ShowEditorData;
//  end;
end;

procedure TxpEdit.SetAsFloat (AValue:double);
begin
//  If FFloat<>AValue then begin
    If Abs(AValue) < 0.0000000001 then FFloat := 0 else FFloat:=AValue;
//    FFloat := AValue;
    ShowEditorData;
//  end;
end;

procedure TxpEdit.SetAsDateTime (AValue:TDateTime);
begin
//  If FDateTime<>AValue then begin
    FDateTime := AValue;
    ShowEditorData;
//  end;
end;

function  TxpEdit.GetDataSource:TDataSource;
begin
  Result := FDataSource;
end;

procedure TxpEdit.SetDataSource (AValue:TDataSource);
begin
  If FDataSource<>AValue then begin
    FDataSource := AValue;
    If (AValue<>nil) and (FFieldName<>'') then (FDataSource as TDataTable).AddField(Owner.Name+'.'+Name+','+FieldName);
(*
    If FExtTextShow then begin
      If FAutoFieldSet then SetFieldSize;
      SetExtTextDef;
      SetExtText(FExtText);
      Repaint;
      SendMessage (Handle, WM_NCPAINT, 0, 0);
    end;
*)
  end;
end;

function  TxpEdit.GetFieldName:string;
begin
  Result := FFieldName;
end;

procedure TxpEdit.SetFieldName (AValue:string);
begin
  If FFieldName<>AValue then begin
    FFieldName := AValue;
    SetFieldType;
    If FAutoFieldSet then begin
      SetFieldSize;
      If FExtTextShow then SetExtTextDef;
    end;
    ShowEditorData;
    Clear;
    Repaint;
    SendMessage (Handle, WM_NCPAINT, 0, 0);
  end;
end;

procedure TxpEdit.SetFieldSize;
var mFld:string;
begin
  mFld := UpperCase(FFieldName);
  If FExtTextShow then begin
    If FExtFieldName<>'' then begin
      If (Pos ('QNT',mFld)>0) or (Pos ('QUANT',mFld)>0) then Width := 119;
      If (Pos ('PRICE',mFld)>0)  then Width := 140;
    end else begin
      If (Pos ('QNT',mFld)>0) or (Pos ('QUANT',mFld)>0) then Width := 103;
      If (Pos ('PRICE',mFld)>0)  then Width := 124;
    end;
    If (Pos ('VAL',mFld)>0) or (Pos ('VALUE',mFld)>0)  then Width := 105;
    If (Pos ('PRC',mFld)>0)  then Width := 61;
  end else begin
    If (Pos ('QNT',mFld)>0) or (Pos ('QUANT',mFld)>0) then Width := 79;
    If (Pos ('VAL',mFld)>0) or (Pos ('VALUE',mFld)>0)  then Width := 79;
    If (Pos ('PRICE',mFld)>0)  then Width := 79;
    If (Pos ('PRC',mFld)>0)  then Width := 43;
  end;
  If mFld='GSCODE' then Width := 45;
  If mFld='GSNAME' then Width := 200;
  If (mFld='BARCODE') or (mFld='STKCODE') then Width := 115;
end;

procedure TxpEdit.SetFieldType;
var mFld:string; mFieldType:TFieldType; mSetDef:boolean;
begin
  mFld := UpperCase(FFieldName);
  mSetDef := TRUE;
  If FDataSource<>nil then begin
    If FDataSource.DataSet.FindField(FFieldName)<>nil then begin
      mFieldType := FDataSource.DataSet.FindField(FFieldName).DataType;
      case mFieldType of
        ftString: SetEditorType (etString);
        ftSmallint, ftInteger, ftWord, ftBytes: begin
            SetEditorType (etInteger);
            SetAsInteger (FInteger);
          end;
        ftFloat, ftCurrency: begin
            SetEditorType (etFloat);
            If FAutoFieldSet then begin
              If (Pos ('QNT',mFld)>0) or (Pos ('QUANT',mFld)>0)
                then FFrac := 3
                else FFrac := 2;
            end;
          end;
        ftDate: begin
            SetEditorType (etDate);
            SetAsDateTime(FDateTime);
          end;
        ftTime: begin
            SetEditorType (etTime);
            SetAsDateTime(FDateTime);
          end;
        ftDateTime: begin
            SetEditorType (etDateTime);
            SetAsDateTime(FDateTime);
          end;
      end;
      mSetDef := FALSE;
    end;
  end;
  If mSetDef then begin
    If mFld='GSCODE' then begin
      SetEditorType (etInteger);
      SetAsInteger (FInteger);
    end;
    If (mFld='GSNAME') or (mFld='BARCODE') or (mFld='STKCODE') then begin
      SetEditorType (etString);
    end;
    If (Pos ('QNT',mFld)>0) or (Pos ('QUANT',mFld)>0) then begin
      SetEditorType (etFloat);
      If FAutoFieldSet then FFrac := 3;
    end;
    If (Pos ('VAL',mFld)>0) or (Pos ('VALUE',mFld)>0)
      or (Pos ('PRICE',mFld)>0) or (Pos ('PRC',mFld)>0) then begin
      SetEditorType (etFloat);
      If FAutoFieldSet then FFrac := 2;
      SetAsFloat (FFloat);
    end;
    If (Pos ('Date',mFld)>0) then begin
      SetEditorType (etDate);
      SetAsDateTime(FDateTime);
    end;
    If (Pos ('Time',mFld)>0) then begin
      SetEditorType (etTime);
      SetAsDateTime(FDateTime);
    end;
    If (Pos ('DateTime',mFld)>0) then begin
      SetEditorType (etDateTime);
      SetAsDateTime(FDateTime);
    end;
  end;
  ShowEditorData;
end;

procedure TxpEdit.SetAutoFieldSet (AValue:boolean);
begin
  FAutoFieldSet := AValue;
  SetFieldType;
  SetFieldSize;
  If FExtTextShow then SetExtTextDef;
  ShowEditorData;
  Clear;
  Repaint;
  SendMessage (Handle, WM_NCPAINT, 0, 0);
end;

procedure TxpEdit.SetExtTextShow (AValue:boolean);
begin
  If FExtTextShow<>AValue then begin
    FExtTextShow := AValue;
    If FAutoFieldSet then begin
      SetFieldSize;
      If FExtTextShow then begin
        SetExtTextDef;
      end else begin
        FExtFieldName := '';
        FExtText := '';
        ExtMargin := 0;
      end;
    end else begin
      FExtText := '';
      ExtMargin := 30;
    end;
    Repaint;
    SendMessage (Handle, WM_NCPAINT, 0, 0);
  end;
end;

procedure TxpEdit.SetExtText(AValue:string);
var mCanvas : TBitmap;
begin
  If FExtText<>AValue then begin
    FExtText := AValue;
    If FExtText='' then begin
      If FAutoFieldSet then ExtMargin := 0
    end else begin
      If (FAutoFieldSet or (ExtMargin=0)) and (FExtFieldName='') then begin
        mCanvas := TBitmap.Create;
        mCanvas.Canvas.Font.Assign (Font);
        If FAutoFieldSet then ExtMargin := mCanvas.Canvas.TextWidth (FExtText)+12;
        mCanvas.Free;
      end;
    end;
    Repaint;
    SendMessage (Handle, WM_NCPAINT, 0, 0);
  end;
end;

procedure TxpEdit.SetExtFieldName (AValue:string);
begin
  If FExtFieldName<>AValue then begin
    FExtFieldName := AValue;
    If FAutoFieldSet then begin
      SetFieldSize;
      If FExtTextShow then SetExtTextDef;
    end;
    ShowEditorData;
    Repaint;
    SendMessage (Handle, WM_NCPAINT, 0, 0);
  end;
end;

procedure TxpEdit.SetExtMargin (AValue:word);
begin
  FExtMargin := AValue;
  SetEditRect;
  Repaint;
  SendMessage (Handle, WM_NCPAINT, 0, 0);
end;

procedure TxpEdit.SetExtTextDef;
var mFld:string;
begin
  mFld := UpperCase(FFieldName);
  FExtText := '';
  If FAutoFieldSet then ExtMargin := 30;
  If FExtFieldName='' then begin
    If (Pos ('QNT',mFld)>0) or (Pos ('QUANT',mFld)>0) then begin
      FExtText := 'MJ';
      If FAutoFieldSet then ExtMargin := 26;
    end;
    If (Pos ('PRICE',mFld)>0)  then begin
      FExtText := cCoin+'/MJ';
      If FAutoFieldSet then ExtMargin := 47;
    end;
  end else begin
    If (Pos ('QNT',mFld)>0) or (Pos ('QUANT',mFld)>0) then begin
      FExtText := 'MJ';
      If FAutoFieldSet then ExtMargin := 42;
    end;
    If (Pos ('PRICE',mFld)>0)  then begin
      FExtText := cCoin+'/MJ';
      If FAutoFieldSet then ExtMargin := 63;
    end;
  end;
  If (Pos ('VAL',mFld)>0) or (Pos ('VALUE',mFld)>0) then begin
    FExtText := cCoin;
    If FAutoFieldSet then ExtMargin := 28;
  end;
  If (Pos ('PRC',mFld)>0)  then begin
    FExtText := '%';
    If FAutoFieldSet then ExtMargin := 20;
  end;
  SetExtText(FExtText);
end;

procedure TxpEdit.SetEditColors (AValue:TxpEditColors);
begin
  FEditColors := AValue;
end;

procedure TxpEdit.SetInfoField (AValue:boolean);
begin
  FInfoField := AValue;
  If AValue then begin
    ReadOnly := TRUE;
    TabStop := FALSE;
    Color := FEditColors.FBGInfoField;
  end else begin
    ReadOnly := FALSE;
    TabStop := TRUE;
  end;
end;

function  TxpEdit.GetAsString:string;
begin
  Result := Text;
end;

procedure TxpEdit.SetAsString (AValue:string);
begin
  Text := AValue;
  FOldValue := AValue;
end;

procedure TxpEdit.SetBasicColor (pValue:TColor);
begin
  oBasicColor := pValue;
  Color := clIccEditorBGNormal;
  FEditColors.BGNormal := clIccEditorBGNormal;
  FEditColors.BGReadOnly := IccCompHueColor (oBasicColor, TclIccEditorBGReadOnly);
  FEditColors.BGInfoField := IccCompHueColor (oBasicColor, TclIccEditorBGInfoField);
  FEditColors.BGActive := IccCompHueColor (oBasicColor, TclIccBGActive);
  FEditColors.BGModify := IccCompHueColor (oBasicColor, TclIccBGModify);
  FEditColors.BGExtText := IccCompHueColor (oBasicColor, TclIccEditorBGExtText);
  FEditColors.InactBorder := IccCompHueColor (oBasicColor, TclIccInactBorder);
  FEditColors.ActBorder := IccCompHueColor (oBasicColor, TclIccActBorder);
  Font.Color := clIccEditorFont;
  Repaint;
end;

procedure TxpEdit.RefreshSystemColor;
begin
  FEditColors.BGNormal := clIccEditorBGNormal;
  FEditColors.BGReadOnly := clIccEditorBGReadOnly;
  FEditColors.BGInfoField := clIccEditorBGInfoField;
  FEditColors.BGActive := clIccBGActive;
  FEditColors.BGModify := clIccBGModify;
  FEditColors.BGExtText := clIccEditorBGExtText;
  FEditColors.InactBorder := clIccInactBorder;
  FEditColors.ActBorder := clIccActBorder;
  Font.Color := clIccEditorFont;
end;

// TxpLabel


function  TxpLabel.GetDataSource:TDataSource;
begin
  Result := FDataSource;
end;

procedure TxpLabel.SetDataSource (AValue:TDataSource);
begin
  If FDataSource<>AValue then begin
    FDataSource := AValue;
    If (AValue<>nil) and (FFieldName<>'') then (FDataSource as TDataTable).AddField(Owner.Name+'.'+Name+','+FieldName);
  end;
end;

function  TxpLabel.GetFieldName:string;
begin
  Result := FFieldName;
end;

procedure TxpLabel.SetFieldName (Value:string);
begin
  FFieldName := Value;
end;

// TxpBitBtn

constructor TxpBitBtn.Create (AOwner : TComponent);
begin
  Inherited Create (AOwner);
  Width := 75;
  Height := 29;
  TabStop := TRUE;
  FFont := TFont.Create;
//  FFont.Style := [fsBold];
  FFont.Color := clIccButtonFont;
  FFont.OnChange := OnFontChange;
  FSystemColor := TRUE;
  oBasicColor := cbcBasicColor;
  oFocusWhenClick := TRUE;
  oMouseDown := FALSE;

  FCaption := '';
  Enabled := TRUE;
  FEnabled := TRUE;
  FActive := FALSE;
  FDown := FALSE;
  FFocused := FALSE;
  FGlyph := TBitmap.Create;
  FGlyph.TransparentMode := tmAuto;
  FGlyph.Transparent := TRUE;

  FMonoGlyph := TBitmap.Create;
  FMonoGlyph.TransparentMode := tmAuto;
  FMonoGlyph.Transparent := TRUE;

  FMarginLeft  := 8;
  FMarginRight := 8;
  FMarginTop   := 8;
  FMarginBottom := 8;
  FGlyphSpace  := 10;
  FLineSpace   := 2;
  FLayout      := blGlyphLeft;
  FAlignText   := atCenter;

  FImageIndex := -1;
  FImageList := nil;
end;

destructor TxpBitBtn.Destroy;
begin
  FFont.Free;
  FGlyph.Free;
  FMonoGlyph.Free;
  inherited;
end;

procedure TxpBitBtn.Loaded;
begin
  inherited Loaded;
  FMonoGlyph.Assign (FGlyph as TBitmap);
  ConvertBitmapToGrayscale (FMonoGlyph);
  FMonoGlyph.Transparent := TRUE;
  FMonoGlyph.TransparentMode := tmAuto;
end;

procedure TxpBitBtn.CMDialogKey(var Message : TCMDialogKey);
begin
  if Enabled and  ((FCancel and (Message.CharCode = VK_ESCAPE)) or
  (FDefault and (Message.CharCode = VK_RETURN))) then
    FOnButtonClick;
end;

procedure TxpBitBtn.Paint;
var
  AText : array [1..10] of string;
  mS:string;
  I, mCnt:longint;
  AImageWidth : Integer;
  AImageHeigth : Integer;
  ACanvas : TBitmap;
  mTextX, mTextY:longint;
  mGlyphX, mGlyphY:longint;
  mMaxWidth:longint;
  mHeight: longint;   mX,mY:longint;
  mImagePos:longint;
begin
  If FSystemColor then RefreshSystemColor;
  ACanvas := TBitmap.Create;
  ACanvas.Canvas.Font.Assign (FFont);
  ACanvas.Canvas.Brush.Style := bsClear;

  mS := FCaption;
  If Pos ('&', FCaption) <> 0 then Delete (mS, Pos ('&', mS), 1);
  mCnt := 0;
  mMaxWidth := 0;
  Repeat
    Inc (mCnt);
    If Pos ('#', mS)>0 then begin
      AText[mCnt] := Copy (mS, 1, Pos ('#', mS)-1);
      Delete (mS, 1, Pos ('#', mS));
    end else begin
      AText[mCnt] := mS;
      mS := '';
    end;
    If mMaxWidth<ACanvas.Canvas.TextWidth (AText[mCnt]) then mMaxWidth := ACanvas.Canvas.TextWidth (AText[mCnt]);
  until mS='';
  mHeight := (ACanvas.Canvas.TextHeight (AText[1]));
  If mCnt>1 then mHeight := mHeight+(ACanvas.Canvas.TextHeight (AText[1])+FLineSpace)*(mCnt-1);

  try
    ACanvas.Width := ClientWidth;
    ACanvas.Height := ClientHeight;

    If Assigned (FImageList) then begin
      AImageWidth := FImageList.Width;
      AImageHeigth := FImageList.Height;
    end else begin
      AImageWidth := FGlyph.Width;
      AImageHeigth := FGlyph.Height;
    end;
//VypoËÌta pozÌciu textu a obr·zku
    If FCaption='' then begin
      mGlyphX := FMarginLeft+(Width-FMarginLeft-FMarginRight-AImageWidth) div 2 + Integer (FDown);
      mGlyphY := FMarginTop+(Height-FMarginTop-FMarginBottom-AImageHeigth) div 2 + Integer (FDown);
    end else begin
      If FGlyph.Empty then begin
        case FAlignText of
          atLeft  : mTextX := FMarginLeft+Integer (FDown);
          atCenter: mTextX := FMarginLeft+(Width-FMarginLeft-FMarginRight-mMaxWidth) div 2 + Integer (FDown);
          atRight : mTextX := Width-mMaxWidth-FMarginRight+Integer (FDown);
        end;
        mTextY := (Height - mHeight) div 2 + Integer (FDown);
      end else begin
        case FLayout of
          blGlyphLeft  : begin
                           mGlyphX := FMarginLeft+Integer (FDown);
                           mGlyphY := FMarginTop+(Height-FMarginTop-FMarginBottom-AImageHeigth) div 2 + Integer (FDown);
                           mImagePos := AImageWidth+FGlyphSpace;
                           case FAlignText of
                             atLeft  : mTextX := mImagePos+FMarginLeft+ Integer (FDown);
                             atCenter: mTextX := FMarginLeft+mImagePos+(Width-mImagePos-FMarginLeft-FMarginRight-mMaxWidth) div 2 + Integer (FDown);
                             atRight : mTextX := Width-mMaxWidth-FMarginRight+Integer (FDown);
                           end;
                           mTextY := FMarginTop+(Height-FMarginTop-FMarginBottom-mHeight) div 2 + Integer (FDown);
                         end;
          blGlyphRight : begin
                           mGlyphX := Width-FMarginRight-AImageWidth-Integer (FDown);
                           mGlyphY := FMarginTop+(Height-FMarginTop-FMarginBottom-AImageHeigth) div 2 + Integer (FDown);
                           mImagePos := AImageWidth+FGlyphSpace;
                           case FAlignText of
                             atLeft  : mTextX := FMarginLeft;
                             atCenter: mTextX := FMarginLeft+(Width-mImagePos-FMarginLeft-FMarginRight-mMaxWidth) div 2 + Integer (FDown);
                             atRight : mTextX := Width-mImagePos-FMarginRight-mMaxWidth-Integer (FDown);
                           end;
                           mTextY := FMarginTop+(Height-FMarginTop-FMarginBottom-mHeight) div 2 + Integer (FDown);
                         end;
          blGlyphTop   : begin
                           mGlyphX := FMarginLeft+(Width-FMarginLeft-FMarginRight-AImageWidth) div 2 + Integer (FDown);
                           mGlyphY := FMarginTop;
                           case FAlignText of
                             atLeft  : mTextX := FMarginLeft;
                             atCenter: mTextX := FMarginLeft+(Width-FMarginLeft-FMarginRight-mMaxWidth) div 2 + Integer (FDown);
                             atRight : mTextX := Width-mMaxWidth-FMarginRight-Integer (FDown);
                           end;
                           mTextY := FMarginTop+AImageHeigth+FGlyphSpace+(Height-FMarginTop-FMarginBottom-mHeight-AImageHeigth-FGlyphSpace) div 2 + Integer (FDown);
                         end;
          blGlyphBottom: begin
                           mGlyphX := FMarginLeft+(Width-FMarginLeft-FMarginRight-AImageWidth) div 2 + Integer (FDown);
                           mGlyphY := Height-FMarginBottom-AImageHeigth;
                           case FAlignText of
                             atLeft  : mTextX := FMarginLeft;
                             atCenter: mTextX := FMarginLeft+(Width-FMarginLeft-FMarginRight-mMaxWidth) div 2 + Integer (FDown);
                             atRight : mTextX := Width-mMaxWidth-FMarginRight-Integer (FDown);
                           end;
                           mTextY := FMarginTop+(Height-FMarginTop-FMarginBottom-mHeight-AImageHeigth-FGlyphSpace) div 2 + Integer (FDown);
                         end;
        end;
      end;
    end;

    If Enabled then begin
      ACanvas.Canvas.Pen.Color := clWhite;
      ACanvas.Canvas.Rectangle(0, 0, Width, Height);

      ACanvas.Canvas.Pen.Width := 1;
      ACanvas.Canvas.Brush.Style := bsSolid;
//      ACanvas.Canvas.Brush.Color := RGB (214, 211, 211);
//      ACanvas.Canvas.Pen.Color := RGB (214, 211, 211);
      ACanvas.Canvas.Brush.Color := oButColors.BackGroud;
      ACanvas.Canvas.Pen.Color := oButColors.BackGroud;
      ACanvas.Canvas.RoundRect (0, 0, Width, Height, 3, 3);

      ACanvas.Canvas.Brush.Style := bsClear;
//      ACanvas.Canvas.Pen.Color := RGB (0, 60, 116);
      ACanvas.Canvas.Pen.Color := oButColors.ActBorder;
      ACanvas.Canvas.RoundRect (1, 1, Width-1, Height-1, 5, 5);

      If FDown then begin
        If FGroupIndex>0
          then GradientFillRect (ACanvas.Canvas, Rect (4, 4, Width-4, Height-4), oButColors.ButtonGradBeg,
                  oButColors.ButtonGradEnd, fdDown, HeightOf (ClientRect) div 2)
          else GradientFillRect (ACanvas.Canvas, Rect (4, 4, Width-4, Height-4), oButColors.ButtonGradBeg,
                  oButColors.ButtonGradEnd, fdBottomToTop, HeightOf (ClientRect) div 2);
      end else begin
//        GradientFillRect (ACanvas.Canvas, Rect (4, 4, Width-4, Height-4), RGB (253, 253, 253),
//             RGB (205, 204, 223), fdTopToBottom, HeightOf (ClientRect) div 3);
        GradientFillRect (ACanvas.Canvas, Rect (4, 4, Width-4, Height-4), oButColors.ButtonGradBeg,
             oButColors.ButtonGradEnd, fdTopToBottom, HeightOf (ClientRect) div 3);
      end;

//      ACanvas.Canvas.Pen.Color := RGB (206, 231, 255);
      ACanvas.Canvas.Pen.Color := oButColors.ButtonFrameTop;
      ACanvas.Canvas.MoveTo (3, 2);
      ACanvas.Canvas.LineTo (Width - 3, 2);

//      ACanvas.Canvas.Pen.Color := RGB (105, 130, 238);
      ACanvas.Canvas.Pen.Color := oButColors.ButtonFrameBot;
      ACanvas.Canvas.MoveTo (3, Height-3);
      ACanvas.Canvas.LineTo (Width - 3, Height-3);

//      ACanvas.Canvas.Pen.Color := RGB (188, 212, 246);
      ACanvas.Canvas.Pen.Color := oButColors.ButtonFrame;
      ACanvas.Canvas.Rectangle (2, 3, Width-2, Height-3);

      ACanvas.Canvas.Pen.Color := clWhite;
      ACanvas.Canvas.MoveTo (3, 4);
      ACanvas.Canvas.LineTo (3, Height-4);

      ACanvas.Canvas.Pen.Color := clWhite;
      ACanvas.Canvas.MoveTo (Width-4, 4);
      ACanvas.Canvas.LineTo (Width-4, Height-4);

      ACanvas.Canvas.Pen.Color := clWhite;
      ACanvas.Canvas.MoveTo (3, Height-1);
      ACanvas.Canvas.LineTo (Width-3, Height-1);
      ACanvas.Canvas.MoveTo (Width-1, Height-4);
      ACanvas.Canvas.LineTo (Width-1, 2);

      If FActive then begin
        ACanvas.Canvas.Brush.Style := bsClear;
        ACanvas.Canvas.Pen.Color := oButColors.ButtonSelected;
        ACanvas.Canvas.Pen.Width := 1;
        ACanvas.Canvas.RoundRect (3, 3, Width-3, Height-3, 2, 2);
      end;

///////////////////////////////////////

//VykreslÌ obr·zok
      If Assigned (FImageList)
        then FImageList.Draw (ACanvas.Canvas, mGlyphX, mGlyphY, FImageIndex)
        else DrawBitmapTransparent (ACanvas.Canvas, mGlyphX, mGlyphY, FGlyph, FGlyph.Canvas.Pixels [0, 0]);

//VypÌöe text
      mY := 0;
      mX := 0;
      For I:=1 to mCnt do begin
        case FAlignText of
          atCenter: mX := (mMaxWidth-ACanvas.Canvas.TextWidth (AText[I])) div 2;
          atRight : mX := mMaxWidth-ACanvas.Canvas.TextWidth (AText[I]);
        end;
        ACanvas.Canvas.Font.Color := clLtGray;
        ACanvas.Canvas.Font.Color := oButColors.ButtonFontShad;
        ACanvas.Canvas.TextRect (Rect (4, 4, Width-4, Height-4), mX+mTextX + 1, mY+mTextY + 1, AText[I]);
        ACanvas.Canvas.Font.Color := oButColors.ButtonFont;
        ACanvas.Canvas.TextRect (Rect (4, 4, Width-4, Height-4), mX+mTextX, mY+mTextY, AText[I]);
        mY := mY+ACanvas.Canvas.TextHeight (AText[1])+FLineSpace;
      end;

      If FFocused then begin
        ACanvas.Canvas.Brush.Style := bsSolid;
        ACanvas.Canvas.Pen.Color := clWhite;
        ACanvas.Canvas.Pen.Width := 2;
        ACanvas.Canvas.DrawFocusRect (Rect (4, 4, Width - 4, Height - 4));
      end;

    end else begin // not Enabled
      ACanvas.Canvas.Brush.Color := oButColors.ButtonDis;
      ACanvas.Canvas.Pen.Color := oButColors.ButtonBorderDis;
      ACanvas.Canvas.RoundRect (0, 0, Width, Height, 3, 3);
      ACanvas.Canvas.Pixels [0, 0] := clWhite;
      ACanvas.Canvas.Pixels [Width-1, 0] := clWhite;
      ACanvas.Canvas.Pixels [Width-1, Height-1] := clWhite;
      ACanvas.Canvas.Pixels [0, Height-1] := clWhite;

      ACanvas.Canvas.Brush.Style := bsClear;
      ACanvas.Canvas.Pen.Color := oButColors.ButtonDis;
      ACanvas.Canvas.RoundRect (1, 1, Width-1, Height-1, 5, 5);

      ACanvas.Canvas.Font := FFont;
//      ACanvas.Canvas.Font.Color := RGB (161, 161, 146);
      ACanvas.Canvas.Font.Color := oButColors.ButtonFontDis;

      If Assigned (FImageList) then begin
        FImageList.GetBitmap (FImageIndex, FMonoGlyph);
        ConvertBitmapToGrayscale (FMonoGlyph);
      end else begin
        FGlyph.Transparent := TRUE;
      end;

//VykreslÌ obr·zok
      DrawBitmapTransparent (ACanvas.Canvas, mGlyphX, mGlyphY, FMonoGlyph, FMonoGlyph.Canvas.Pixels [0, 0]);

//VypÌöe text
      mY := 0;
      mX := 0;
      For I:=1 to mCnt do begin
        case FAlignText of
          atCenter: mX := (mMaxWidth-ACanvas.Canvas.TextWidth (AText[I])) div 2;
          atRight : mX := mMaxWidth-ACanvas.Canvas.TextWidth (AText[I]);
        end;
        ACanvas.Canvas.TextRect (Rect (4, 4, Width-4, Height-4), mX+mTextX, mY+mTextY, AText[I]);
        mY := mY+ACanvas.Canvas.TextHeight (AText[1])+FLineSpace;
      end;
    end;

    If Pos ('&', FCaption) <> 0 then begin
      ACanvas.Canvas.Pen.Color := ACanvas.Canvas.Font.Color;
      ACanvas.Canvas.Pen.Width := 1;
      ACanvas.Canvas.MoveTo (((Width - mMaxWidth) div 2) + ACanvas.Canvas.TextWidth (Copy (AText[1], 1, Pos ('&', FCaption)-1)) + Integer (FDown),
                     ((Height - mHeight) div 2) + ACanvas.Canvas.TextHeight (AText[1]) + Integer (FDown));
      ACanvas.Canvas.LineTo (((Width - mMaxWidth) div 2) + ACanvas.Canvas.TextWidth (Copy (AText[1], 1, Pos ('&', FCaption))) + Integer (FDown),
                     ((Height - mHeight) div 2) + ACanvas.Canvas.TextHeight (AText[1]) + Integer (FDown));
    end;

    BitBlt(Canvas.Handle, 0, 0, ACanvas.Width, ACanvas.Height,
      ACanvas.Canvas.Handle, 0, 0, SRCCOPY);

  finally
    ACanvas.Free;
  end;
end;

procedure TxpBitBtn.MouseEnter (var Message : TMessage);
begin
  If (FActive) or (not FEnabled) then Exit;
  FActive := TRUE;
  Repaint;
end;

procedure TxpBitBtn.MouseLeave (var Message : TMessage);
begin
  If FActive and (FEnabled) then begin
    If FGroupIndex=0 then FDown := FALSE;
    FActive := FALSE;
    Repaint;
  end;
end;

procedure TxpBitBtn.SetCaption (ACaption : TCaption);
begin
  If FCaption <> ACaption then begin
    FCaption := ACaption;
    If (Pos ('&', FCaption) <> 0) and (Pos ('&', FCaption) < Length (FCaption)) then
      FHotKey := UpperCase (String (Copy (FCaption, Pos ('&', FCaption)+1, 1)))[1]
    else
      FHotKey := #0;
    Repaint;
  end;
end;

function  TxpBitBtn.GetCaption : TCaption;
begin
  Result := FCaption;
end;

procedure TxpBitBtn.SetDown (AValue : Boolean);
begin
  If FDown <> AValue then begin
    FDown := AValue;
    If FDown and (FGroupIndex>0) then SwitchOffButtons;
    Repaint;
  end;
end;

procedure TxpBitBtn.SetGroupIndex (AValue : word);
begin
  If FGroupIndex <> AValue then begin
    FGroupIndex := AValue;
    Repaint;
  end;
end;

procedure TxpBitBtn.SetBasicColor (pColor:TColor);
begin
  oBasicColor := pColor;
  oButColors.ActBorder       := IccCompHueColor (pColor, TclIccActBorder);
  oButColors.BackGroud       := clIccBG;
  oButColors.ButtonFrameTop  := IccCompHueColor (pColor, TclIccButtonFrameTop);
  oButColors.ButtonFrame     := IccCompHueColor (pColor, TclIccButtonFrame);
  oButColors.ButtonFrameBot  := IccCompHueColor (pColor, TclIccButtonFrameBot);
  oButColors.ButtonGradBeg   := IccCompHueColor (pColor, TclIccButtonGradBeg);
  oButColors.ButtonGradEnd   := IccCompHueColor (pColor, TclIccButtonGradEnd);
  oButColors.ButtonFont      := IccCompHueColor (pColor, TclIccButtonFont);
  oButColors.ButtonFontShad  := clIccButtonFontShad;
  oButColors.ButtonFontDis   := clIccButtonFontDis;
  oButColors.ButtonSelected  := clIccButtonSelected;
  oButColors.ButtonBorderDis := clIccButtonBorderDis;
  oButColors.ButtonDis       := clIccButtonDis;
  FFont.Color := oButColors.ButtonFont;
  Repaint;
end;

procedure TxpBitBtn.SetFont (AFont : TFont);
begin
  FFont.Assign (AFont);
  RePaint;
end;

function  TxpBitBtn.GetFont : TFont;
begin
  Result := FFont;
end;

procedure TxpBitBtn.OnFontChange (Sender : TObject);
begin
  Invalidate;
end;


procedure TxpBitBtn.SetGlyph (AGlyph : TBitmap);
begin
  FGlyph.Assign (AGlyph as TBitmap);
  FMonoGlyph.Assign (FGlyph as TBitmap);
  ConvertBitmapToGrayscale (FMonoGlyph);
  FMonoGlyph.Transparent := TRUE;

  If FImageList <> nil then begin
    FImageList := nil;
    FImageIndex := -1;
  end;

  Invalidate;
end;

function  TxpBitBtn.GetGlyph : TBitmap;
begin
  Result := FGlyph as TBitmap;
end;

procedure TxpBitBtn.SetImageList (AList : TImageList);
begin
  If FImageList <> AList then begin
    FImageList := AList;

    FGlyph.ReleaseHandle;
    
    Invalidate;
  end;
end;

function  TxpBitBtn.GetImageList : TImageList;
begin
  Result := FImageList;
end;


procedure TxpBitBtn.SetImageIndex (AIndex : Integer);
begin
  If FImageIndex <> AIndex then begin
    FImageIndex := AIndex;
    Invalidate;
  end;
end;

function  TxpBitBtn.GetImageIndex : Integer;
begin
  Result := FImageIndex;
end;

procedure TxpBitBtn.SetMarginLeft (AValue : Word);
begin
  If FMarginLeft <> AValue then begin
    FMarginLeft := AValue;
    Repaint;
  end;
end;

procedure TxpBitBtn.SetMarginRight (AValue : Word);
begin
  If FMarginRight <> AValue then begin
    FMarginRight := AValue;
    Repaint;
  end;
end;

procedure TxpBitBtn.SetMarginTop (AValue : Word);
begin
  If FMarginTop <> AValue then begin
    FMarginTop := AValue;
    Repaint;
  end;
end;

procedure TxpBitBtn.SetMarginBottom (AValue : Word);
begin
  If FMarginBottom <> AValue then begin
    FMarginBottom := AValue;
    Repaint;
  end;
end;

procedure TxpBitBtn.SetGlyphSpace (AValue : Word);
begin
  If FGlyphSpace <> AValue then begin
    FGlyphSpace := AValue;
    Repaint;
  end;
end;

procedure TxpBitBtn.SetLineSpace (AValue : Word);
begin
  If FLineSpace <> AValue then begin
    FLineSpace := AValue;
    Repaint;
  end;
end;

procedure TxpBitBtn.SetLayout (AValue : TButtonLayout);
begin
  If FLayout <> AValue then begin
    FLayout := AValue;
    Repaint;
  end;
end;

procedure TxpBitBtn.SetAlignText (AValue : TAlignText);
begin
  If FAlignText <> AValue then begin
    FAlignText := AValue;
    Repaint;
  end;
end;

procedure TxpBitBtn.LMouseDblClick  (var Message : TMessage);
begin
  FOnButtonClick;
end;

procedure TxpBitBtn.LMouseDown  (var Message : TMessage);
begin
  If FEnabled then begin
    If FGroupIndex>0 then begin
      FDown := not FDown;
      If FDown and (FGroupIndex>0) then SwitchOffButtons;
    end else FDown := TRUE;
    If (not Focused) and Enabled and oFocusWhenClick then SetFocus;
    oMouseDown := TRUE;
    Repaint;
  end;
end;

procedure TxpBitBtn.RMouseDown  (var Message : TMessage);
begin

end;

procedure TxpBitBtn.LMouseUp  (var Message : TMessage);
begin
  If FEnabled then begin
    If oMouseDown then begin
      oMouseDown := FALSE;
      If FGroupIndex=0 then FDown := not FDown;
      Repaint;
      FOnButtonClick;
    end;
  end;
end;

procedure TxpBitBtn.RMouseUp  (var Message : TMessage);
begin
  If FEnabled then FOnButtonRClick;
end;

procedure TxpBitBtn.CMEnter(var Message: TCMGotFocus);
begin
  inherited;
  If Assigned (FOnEnter) then FOnEnter (self);
end;

procedure TxpBitBtn.CMExit(var Message: TCMLostFocus);
begin
  inherited;
  If Assigned (FOnExit) then FOnExit (self);
end;

procedure TxpBitBtn.WMSetFocus(var Message: TMessage);
begin
  If not FFocused then begin
    FFocused := TRUE;
    Invalidate;
  end;
end;

procedure TxpBitBtn.WMKillFocus(var Message: TMessage);
begin
  If FFocused then begin
    FFocused := FALSE;
    Invalidate;
  end;
end;

procedure TxpBitBtn.WMKeyDown (var Message: TMessage);
var Msg: TMsg; mTabStop:boolean;
begin
  If ((Message.WParam = VK_RETURN) or (Message.WParam = VK_SPACE)) then begin
    If FGroupIndex>0 then begin
      FDown := not FDown;
      If FDown and (FGroupIndex>0) then SwitchOffButtons;
    end else FDown := TRUE;
    Invalidate;
  end;
(*  If (Message.WParam = VK_DOWN) then begin
    mTabStop := TabStop;
    If not TabStop then TabStop := TRUE;
    SendMessage((Owner as TForm).Handle, WM_NEXTDLGCTL, 0, 0);
    // Vypnutie sysutils.beep po opusteni pola formulara inou klavesou ako TAB
    PeekMessage(Msg, 0, WM_CHAR, WM_CHAR, PM_REMOVE);
    TabStop := mTabStop;
  end;
  If (Message.WParam = VK_UP) then begin
    mTabStop := TabStop;
    If not TabStop then TabStop := TRUE;
    SendMessage ((Owner as TForm).Handle,WM_NEXTDLGCTL,1,0);
    // Vypnutie sysutils.beep po opusteni pola formulara inou klavesou ako TAB
    PeekMessage(Msg, 0, WM_CHAR, WM_CHAR, PM_REMOVE);
    TabStop := mTabStop;
  end;*)
  inherited;
end;

procedure TxpBitBtn.WMKeyUp (var Message: TMessage);
begin
  If FDown then begin
    If FGroupIndex=0 then FDown := FALSE;
    Invalidate;
    FOnButtonClick;
  end;
  If Message.WParam = VK_ESCAPE then begin
//    (Owner as TForm).Close;
  end;
  inherited;
end;

procedure TxpBitBtn.SetModalResult (AModalResult : TModalResult);
begin
  FModalResult := AModalResult;
end;

function  TxpBitBtn.GetModalResult : TModalResult;
begin
  Result := FModalResult;
end;

procedure TxpBitBtn.FOnButtonClick;
var mComp:TComponent;
begin
  If Assigned (Action) then begin
    Action.Execute;
  end else begin
    If (FEnabled) and (Assigned (FOnClick)) then FOnClick (Self);
  end;
  If (FEnabled) and (FModalResult <> mrNone) and (Owner.InheritsFrom (TCustomForm))
    then (Owner as TCustomForm).ModalResult := FModalResult;
end;

procedure TxpBitBtn.FOnButtonRClick;
begin
  If (FEnabled) and (Assigned (FOnRClick)) then FOnRClick (Self);
end;

procedure TxpBitBtn.SwitchOffButtons;
var I:word; mBitBtn: TxpBitBtn;
begin
  For I:=0 to Owner.ComponentCount-1 do begin
    If (Owner.Components[I] is TxpBitBtn) then begin
      mBitBtn := Owner.Components[I] as TxpBitBtn;
      If mBitBtn.Name<>Name then begin
        If mBitBtn.GroupIndex=GroupIndex then mBitBtn.Down := FALSE;
      end;
    end;
  end;
end;

procedure TxpBitBtn.RefreshSystemColor;
begin
  FFont.Color := clIccButtonFont;
  oButColors.ActBorder       := clIccActBorder;
  oButColors.BackGroud       := clIccBG;
  oButColors.ButtonFrameTop  := clIccButtonFrameTop;
  oButColors.ButtonFrame     := clIccButtonFrame;
  oButColors.ButtonFrameBot  := clIccButtonFrameBot;
  oButColors.ButtonGradBeg   := clIccButtonGradBeg;
  oButColors.ButtonGradEnd   := clIccButtonGradEnd;
  oButColors.ButtonFont      := clIccButtonFont;
  oButColors.ButtonFontShad  := clIccButtonFontShad;
  oButColors.ButtonFontDis   := clIccButtonFontDis;
  oButColors.ButtonSelected  := clIccButtonSelected;
  oButColors.ButtonBorderDis := clIccButtonBorderDis;
  oButColors.ButtonDis       := clIccButtonDis;
end;

procedure TxpBitBtn.CMDialogChar(var Message : TCMDialogChar);
begin
  If IsAccel (Message.CharCode, FCaption) and (KeyDataToShiftState(Message.KeyData) = [ssAlt]) then
    FOnButtonClick;
end;


procedure TxpBitBtn.SetEnabled (AEnabled : Boolean);
begin
  If FEnabled <> AEnabled then begin
    FEnabled := AEnabled;
    Invalidate;
  end;
end;

// TxpCheckBox

constructor TxpCheckBox.Create (AOwner : TComponent);
begin
  inherited Create (AOwner);
  Width := 97;
  Height := 17;
  FFont := TFont.Create;
  FFont.OnChange := OnFontChange;
  FSystemColor := TRUE;

  FCaption := 'XP Checkbox';
  FEnabled := TRUE;
  FChecked := FALSE;
  FFocused := FALSE;
  FDowned := FALSE;

  FColor := clBtnFace;

  FCheckColor := clIccChBoxCheck;
  FShadowText := TRUE;
  TabStop := TRUE;
  FCheckData := 'A';
  FOldValue := FChecked;
  FAutoCR := TRUE;
  oBasicColor := cbcBasicColor;
end;

destructor TxpCheckBox.Destroy;
begin
  FFont.Free;
  inherited;
end;

procedure TxpCheckBox.SetCaption (ACaption : TCaption);
begin
  If FCaption <> ACaption then begin
    FCaption := ACaption;
    If (Pos ('&', FCaption) <> 0) and (Pos ('&', FCaption) < Length (FCaption))
      then FHotKey := UpperCase (string (Copy (FCaption, Pos ('&', FCaption)+1, 1)))[1]
      else FHotKey := #0;
    Repaint;
  end;
end;

function  TxpCheckBox.GetCaption : TCaption;
begin
  Result := FCaption;
end;

procedure TxpCheckBox.SetFont (AFont : TFont);
begin
  FFont.Assign (AFont);
  RePaint;
end;

function  TxpCheckBox.GetFont : TFont;
begin
  Result := FFont;
end;

procedure TxpCheckBox.OnFontChange (Sender : TObject);
begin
  Invalidate;
end;

procedure TxpCheckBox.SetColor (AColor : TColor);
begin
  If FColor <> AColor then begin
    FColor := AColor;
    ParentColor := FALSE;
    Invalidate;
  end;
end;

function  TxpCheckBox.GetColor : TColor;
begin
  Result := FColor;
end;

procedure TxpCheckBox.SetCheckColor (AColor : TColor);
begin
  If FCheckColor <> AColor then begin
    FCheckColor := AColor;
    Invalidate;
  end;
end;

function  TxpCheckBox.GetCheckColor : TColor;
begin
  Result := FCheckColor;
end;


procedure TxpCheckBox.SetChecked (AChecked : Boolean);
begin
  If FChecked <> AChecked then begin
    FChecked := AChecked;
    Repaint;
    If Assigned (FOnModified) then FOnModified (self);
  end;
end;

function  TxpCheckBox.GetChecked : Boolean;
begin
 Result := FChecked;
end;


procedure TxpCheckBox.SetTransparent (Value : Boolean);
begin
  If FTransparent <> Value then begin
    FTransparent := Value;
    If FTransparent
      then ControlStyle := ControlStyle - [csOpaque]
      else ControlStyle := ControlStyle + [csOpaque];
    Invalidate;
  end;
end;

procedure TxpCheckBox.SetEnabled (AValue : Boolean);
begin
  If FEnabled <> AValue then begin
    FEnabled := AValue;
    Enabled := AValue;
    Invalidate;
  end;
end;


procedure TxpCheckBox.SetShadowText (AValue : Boolean);
begin
  If FShadowText <> AValue then begin
    FShadowText := AValue;
    Invalidate;
  end;
end;

function  TxpCheckBox.GetDataSource:TDataSource;
begin
  Result := FDataSource;
end;

procedure TxpCheckBox.SetDataSource (AValue:TDataSource);
begin
  FDataSource := AValue;
  If (AValue<>nil) and (FFieldName<>'') then (FDataSource as TDataTable).AddField(Owner.Name+'.'+Name+','+FieldName);
end;

function  TxpCheckBox.GetFieldName:string;
begin
  Result := FFieldName;
end;

procedure TxpCheckBox.SetFieldName (Value:string);
begin
  FFieldName := Value;
end;

procedure TxpCheckBox.SetBasicColor (pValue:TColor);
begin
  oBasicColor := pValue;
  FCheckColor := clIccChBoxCheck;
  oActGradBeg := IccCompHueColor (pValue, TclIccChBoxActGradBeg);
  oActGradEnd := IccCompHueColor (pValue, TclIccChBoxActGradEnd);
  oDownGradBeg := IccCompHueColor (pValue, TclIccChBoxDownGradBeg);
  oDownGradEnd := IccCompHueColor (pValue, TclIccChBoxDownGradEnd);
  oInactGradBeg := IccCompHueColor (pValue, TclIccChBoxInactGradBeg);
  oInactGradEnd := IccCompHueColor (pValue, TclIccChBoxInactGradEnd);
  oActBorder := IccCompHueColor (pValue, TclIccActBorder);
  Repaint;
end;

procedure TxpCheckBox.RefreshSystemColor;
begin
  FCheckColor := clIccChBoxCheck;
  oActGradBeg := clIccChBoxActGradBeg;
  oActGradEnd := clIccChBoxActGradEnd;
  oDownGradBeg := clIccChBoxDownGradBeg;
  oDownGradEnd := clIccChBoxDownGradEnd;
  oInactGradBeg := clIccChBoxInactGradBeg;
  oInactGradEnd := clIccChBoxInactGradEnd;
  oActBorder := clIccActBorder;
end;

procedure TxpCheckBox.FOnCheckBoxClick;
begin
  FChecked := not FChecked;
  Invalidate;

  If Assigned (FOnClick) then FOnClick (self);
end;

procedure TxpCheckBox.CMDialogChar(var Message : TCMDialogChar);
begin
  If FEnabled and (IsAccel (Message.CharCode, FCaption)) and (KeyDataToShiftState(Message.KeyData) = [ssAlt]) then begin
    If not FFocused then SetFocus;
    FOnCheckBoxClick;
  end;
end;

procedure TxpCheckBox.MouseEnter (var Message : TMessage);
begin
  If not FActive and FEnabled then begin
    FActive := TRUE;
    Invalidate;
  end;
end;

procedure TxpCheckBox.MouseLeave (var Message : TMessage);
begin
  If FActive then begin
    FActive := FALSE;
    Invalidate;
  end;
end;

procedure TxpCheckBox.LMouseDblClick  (var Message : TMessage);
begin
  If FEnabled then FOnCheckBoxClick;
end;

procedure TxpCheckBox.LMouseDown  (var Message : TMessage);
begin
  If not FDowned  and FEnabled then begin
    FDowned := TRUE;
    If (not Focused) and (Enabled) then SetFocus;
    Invalidate;
  end;
end;

procedure TxpCheckBox.RMouseDown  (var Message : TMessage);
begin

end;

procedure TxpCheckBox.LMouseUp  (var Message : TMessage);
begin
  If FDowned and FEnabled then begin
    FDowned := FALSE;
    Invalidate;
    FOnCheckBoxClick;
  end;
end;

procedure TxpCheckBox.RMouseUp  (var Message : TMessage);
begin

end;

procedure TxpCheckBox.WMSetFocus(var Message: TMessage);
begin
  If not FFocused and FEnabled then begin
    FFocused := TRUE;
    Invalidate;
  end;
end;

procedure TxpCheckBox.WMKillFocus(var Message: TMessage);
begin
  If FFocused then begin
    FFocused := FALSE;
    Invalidate;
  end;
end;

procedure TxpCheckBox.WMKeyDown(var Message: TMessage);
var Msg: TMsg;
begin
  If (not FDowned) and (FEnabled) and (Message.WParam = VK_SPACE)then begin
    FDowned := TRUE;
    Invalidate;
  end;
  If (Message.WParam = VK_RETURN)  and FAutoCR then begin
    SendMessage((Owner as TForm).Handle, WM_NEXTDLGCTL, 0, 0);
    // Vypnutie sysutils.beep po opusteni pola formulara inou klavesou ako TAB
    PeekMessage(Msg, 0, WM_CHAR, WM_CHAR, PM_REMOVE);
  end;
  inherited;
end;

procedure TxpCheckBox.WMKeyUp(var Message: TMessage);
begin
  If FDowned then begin
    FDowned := FALSE;
    FOnCheckBoxClick;
  end;
end;

procedure TxpCheckBox.CMEnter(var Message: TCMGotFocus);
begin
  FOldValue := FChecked;
  If Assigned (FOnEnter) and FEnabled then FOnEnter (self);
end;

procedure TxpCheckBox.CMExit(var Message: TCMLostFocus);
begin
  If (FOldValue<>FChecked) and Assigned(FOnModified) then FOnModified(Self);
  If Assigned (FOnExit) and FEnabled then FOnExit (self);
end;

procedure TxpCheckBox.DrawCheckArea  (ACanvas : TCanvas);
var CheckRect: TRect; mSize:longint;
begin
  ACanvas.Font.Assign (Font);
  mSize := ACanvas.TextHeight ('A') div 4;
  If mSize<7 then mSize := 7;
  CheckRect := Rect (1, HeightOf (ClientRect) div 2 - mSize,
                     1+2*mSize, HeightOf (ClientRect) div 2 + mSize);

  If Enabled then begin
    If FDowned then begin
      GradientFillRect (ACanvas, CheckRect, oDownGradBeg, oDownGradEnd,
        fdTopToBottom, 10);
    end else begin // not FDowned
      If FActive then begin
        GradientFillRect (ACanvas, CheckRect, oActGradBeg, oActGradEnd, fdTopToBottom, 10);
        ACanvas.Brush.Style := bsSolid;
        ACanvas.Pen.Style := psClear;
        ACanvas.Pen.Color := clBtnFace;
        ACanvas.Rectangle (CheckRect.Left+2, CheckRect.Top+2, CheckRect.Right-2, CheckRect.Bottom-2);
        ACanvas.Pen.Style := psSolid;
      end else begin
        GradientFillRect (ACanvas, CheckRect, RGB (220, 220, 215), RGB (255, 255, 255),
          fdTopToBottom, 10);
        GradientFillRect (ACanvas, CheckRect, oInactGradBeg, oInactGradEnd, fdTopToBottom, 10);
      end;
    end;
  end;

  ACanvas.Pen.Width := 1;
  If Enabled then begin
    ACanvas.Pen.Color := oActBorder;
    ACanvas.Brush.Style := bsClear;
  end else begin
    ACanvas.Pen.Style := psSolid;
    ACanvas.Pen.Color := clGray;
    ACanvas.Brush.Style := bsSolid;
    ACanvas.Brush.Color := clWhite;
  end;
  ACanvas.Rectangle (CheckRect.Left, CheckRect.Top, CheckRect.Right, CheckRect.Bottom);

  If FChecked then begin
    ACanvas.Pen.Width := 3;
    If Enabled
      then ACanvas.Pen.Color := FCheckColor
      else ACanvas.Pen.Color := clIccChBoxCheckDis;
    ACanvas.MoveTo (CheckRect.Left + 3, CheckRect.Top+(CheckRect.Bottom-CheckRect.Top) div 2-1);
    ACanvas.LineTo (CheckRect.Left+(CheckRect.Right-CheckRect.Left) div 3+1, CheckRect.Bottom - 5);
    ACanvas.LineTo (CheckRect.Right-5, CheckRect.Top + 4);
  end;

end;

procedure TxpCheckBox.Paint;
var
  AText : String;  mTextLeft:longint;
  ACanvas : TBitmap;
begin
  If FSystemColor then RefreshSystemColor;
  ACanvas := TBitmap.Create;

  try
    ACanvas.Width := ClientWidth;
    ACanvas.Height := ClientHeight;

  If ParentColor
    then ACanvas.Canvas.Brush.Assign (Parent.Brush)
    else ACanvas.Canvas.Brush.Color := FColor;

  ACanvas.Canvas.Brush.Style := bsSolid;
  ACanvas.Canvas.Pen.Style := psClear;
  If not FTransparent then ACanvas.Canvas.FillRect (ClientRect);

  DrawCheckArea (ACanvas.Canvas);

  AText := FCaption;
  If Pos ('&', FCaption) <> 0 then Delete (AText, Pos ('&', AText), 1);

  ACanvas.Canvas.Font.Assign (FFont);
  mTextLeft := ACanvas.Canvas.TextHeight ('A') div 4;
  If mTextLeft<7 then mTextLeft := 7;
  mTextLeft := 12+2*mTextLeft;

  //ACanvas.Canvas.Brush.Color := FColor;
  If not Enabled then ACanvas.Canvas.Font.Color := clGray;

  ACanvas.Canvas.Brush.Style := bsClear;

  //Shadow
  If FShadowText then begin
    ACanvas.Canvas.Font.Color := clLtGray;
    ACanvas.Canvas.TextOut(mTextLeft+1, (Height - ACanvas.Canvas.TextHeight (AText)) div 2+1, AText);
  end;
  //Text
  If  Enabled
    then ACanvas.Canvas.Font.Color := FFont.Color
    else ACanvas.Canvas.Font.Color := clDkGray;
  ACanvas.Canvas.TextOut(mTextLeft, (Height - ACanvas.Canvas.TextHeight (AText)) div 2, AText);

  If Pos ('&', FCaption) <> 0 then begin
    ACanvas.Canvas.Pen.Color := ACanvas.Canvas.Font.Color;
    ACanvas.Canvas.Pen.Width := 1;
    ACanvas.Canvas.MoveTo (mTextLeft + ACanvas.Canvas.TextWidth (Copy (AText, 1, Pos ('&', FCaption)-1)),
                   (Height - ACanvas.Canvas.TextHeight (AText)) div 2+ACanvas.Canvas.TextHeight (AText)-1);
    ACanvas.Canvas.LineTo (mTextLeft + ACanvas.Canvas.TextWidth (Copy (AText, 1, Pos ('&', FCaption))),
                   (Height - ACanvas.Canvas.TextHeight (AText)) div 2+ACanvas.Canvas.TextHeight (AText)-1);
  end;

  If Enabled and FFocused then begin
    ACanvas.Canvas.Brush.Style := bsSolid;
    ACanvas.Canvas.DrawFocusRect (Rect (mTextLeft-5, (Height - ACanvas.Canvas.TextHeight (AText)) div 2, ACanvas.Canvas.TextWidth (AText)+mTextLeft+5, (Height - ACanvas.Canvas.TextHeight (AText)) div 2 + ACanvas.Canvas.TextHeight (AText)+1))
  end;
    BitBlt(Canvas.Handle, 0, 0, ACanvas.Width, ACanvas.Height,
      ACanvas.Canvas.Handle, 0, 0, SRCCOPY); //SRCCOPY

  finally
    ACanvas.Free;
  end;
end;

procedure TxpCheckBox.CreateParams(var Params: TCreateParams);
begin
  inherited CreateParams(Params);
  Params.ExStyle:=Params.ExStyle;
end;

// TxpComboStyle
constructor TxpComboStyle.Create (AOwner : TxpComboBox);
begin
  inherited Create;

  FActive := True;
  FxpComboBox := AOwner;
  FImageList := nil;
  FButtonWidth := 20;
  FButtonStyle := cbsXP;
  FDefaultImageIndex := -1;
  FDefaultListImageIndex := -1;

  FBGStyle := cbgsNone;
  FBGStartColor := clWhite;
  FBGStartColor := clIccComboBoxGradBeg;
  FBGEndColor := $00F0E2C1;
  FBGEndColor := clIccComboBoxGradEnd;
  FBGGradientFillDir := fdLeftToRight;

  FAutoSearch := TRUE;

  FBGStyle := cbgsGradient;
  FBGGradientFillDir := fdRightToLeft;

//  FActiveBorderColor := $00C56A31;
  FActiveBorderColor := clIccActBorder;
  FInactiveBorderColor := clBlue;
  FInactiveBorderColor := clIccInactBorder;

//  FActiveButtonColor := $00EED2C1;
  FActiveButtonColor := $00EED2C1;
  FActiveButtonColor := clIccComboBoxActButton;
  FInActiveButtonColor := $00EED2C1;
  FInActiveButtonColor := clIccComboBoxInactButton;

  FSelStartColor := $00FFAA77;
  FSelStartColor := clIccComboBoxSelBeg;
  FSelEndColor := $00EED2C1;
  FSelEndColor := clIccComboBoxSelEnd;
  FSelGradientFillDir := fdVerticalFromCenter;

  FBGImage := TBitmap.Create;
end;

destructor  TxpComboStyle.Destroy;
begin
  If Assigned (FImageList) then begin
    try
      FImageList.OnChange := nil;
    except end;
  end;
  If Assigned (FBGImage) then begin
    try
      FBGImage.Free;
      FBGImage := nil;
    except end;
  end;

  inherited;
end;

procedure TxpComboStyle.SetActive (AValue : Boolean);
begin
  FActive := AValue;
  FxpComboBox.RecreateWnd;
  FxpComboBox.Invalidate;
end;

procedure TxpComboStyle.SetImageList (AValue : TImageList);
begin
  FImageList := AValue;
  If Assigned(FImageList) then begin
    FImageList.OnChange := ImageListOnChange;
    FxpComboBox.RecreateWnd;
  end else FxpComboBox.Invalidate;
end;

procedure TxpComboStyle.ImageListOnChange (Sender : TObject);
begin
  FxpComboBox.Invalidate;
end;

procedure TxpComboStyle.SetButtonWidth (AValue : Integer);
begin
  If FButtonWidth <> AValue then begin
    FButtonWidth := AValue;
    FxpComboBox.RecreateWnd;
  end;
end;

procedure TxpComboStyle.SetAutoHeight (AValue : Boolean);
begin
  If FAutoHeight <> AValue then begin
    FAutoHeight := AValue;
    FxpComboBox.RecreateWnd;
  end;
end;

procedure TxpComboStyle.SetActiveBorderColor (AValue : TColor);
begin
  If FActiveBorderColor <> AValue then begin
    FActiveBorderColor := AValue;
    SendMessage (FxpComboBox.Handle, WM_NCPAINT, 0, 0);
  end;
end;

procedure TxpComboStyle.SetInactiveBorderColor (AValue : TColor);
begin
  If FInActiveBorderColor <> AValue then begin
    FInActiveBorderColor := AValue;
    SendMessage (FxpComboBox.Handle, WM_NCPAINT, 0, 0);
  end;
end;


procedure TxpComboStyle.SetActiveButtonColor (AValue : TColor);
begin
  If FActiveButtonColor <> AValue then begin
    FActiveButtonColor := AValue;
    SendMessage (FxpComboBox.Handle, WM_NCPAINT, 0, 0);
  end;
end;

procedure TxpComboStyle.SetInActiveButtonColor (AValue : TColor);
begin
  If FInActiveButtonColor <> AValue then begin
    FInActiveButtonColor := AValue;
    SendMessage (FxpComboBox.Handle, WM_NCPAINT, 0, 0);
  end;
end;

procedure TxpComboStyle.SetSelStartColor (AValue : TColor);
begin
  If FSelStartColor <> AValue then begin
    FSelStartColor := AValue;
  end;
end;

procedure TxpComboStyle.SetSelEndColor (AValue : TColor);
begin
  If FSelEndColor <> AValue then begin
    FSelEndColor := AValue;
  end;
end;

procedure TxpComboStyle.SetSelGradientFillDir (AValue : TFillDirection);
begin
  If FSelGradientFillDir <> AValue then begin
    FSelGradientFillDir := AValue;
  end;
end;

procedure TxpComboStyle.SetBGStyle (AValue: TComboBGStyle);
begin
  If FBGStyle <> AValue then begin
    FBGStyle := AValue;
  end;
end;

procedure TxpComboStyle.SetBGStartColor (AValue : TColor);
begin
  If FBGStartColor <> AValue then begin
    FBGStartColor := AValue;
  end;
end;

procedure TxpComboStyle.SetBGEndColor (AValue : TColor);
begin
  If FBGEndColor <> AValue then begin
    FBGEndColor := AValue;
  end;
end;

procedure TxpComboStyle.SetBGGradientFillDir (AValue : TFillDirection);
begin
  If FBGGradientFillDir <> AValue then begin
    FBGGradientFillDir := AValue;
  end;
end;

procedure TxpComboStyle.SetBGImage (AValue : TBitmap);
begin
  If not FBGImage.Empty then begin
    try
      FBGImage.FreeImage;
    except end;
  end;
  FBGImage.Assign (AValue);
end;

procedure TxpComboStyle.SetDefaultImageIndex (AValue : Integer);
begin
  If FDefaultImageIndex <> AValue then begin
    If AValue < -1 then AValue := -1;
    FDefaultImageIndex := AValue;
    SendMessage (FxpComboBox.Handle, WM_NCPAINT, 0, 0);
  end;
end;

procedure TxpComboStyle.SetDefaultListImageIndex (AValue : Integer);
begin
  If FDefaultListImageIndex <> AValue then begin
    If AValue < -1 then AValue := -1;
    FDefaultListImageIndex := AValue;
    SendMessage (FxpComboBox.Handle, WM_NCPAINT, 0, 0);
  end;
end;

procedure TxpComboStyle.SetButtonStyle (AValue : TxpComboButtonStyle);
begin
  If FButtonStyle <> AValue then begin
    FButtonStyle := AValue;
    SendMessage (FxpComboBox.Handle, WM_NCPAINT, 0, 0);
  end;
end;

procedure TxpComboStyle.SetAutoSearch (Value : Boolean);
begin
  If FAutoSearch <> Value then begin
    FAutoSearch := Value;
  end;
end;

// TxpComboBox
constructor TxpComboBox.Create(AOwner: TComponent);
begin
  inherited Create (AOwner);
  FCanvas := TControlCanvas.Create;
  FCanvas.Control := Self;

  FActive := False;
  FFocused := False;

  FxpStyle := TxpComboStyle.Create (self);

  FBackground := TBitmap.Create;

  FLocating := False;
  FOldText := '';
  FOldValue := '';

  FSystemColor := TRUE;
  oBasicColor := cbcBasicColor;
end;

destructor TxpComboBox.Destroy;
begin
  try FCanvas.Free; except end;
  try FxpStyle.Free; except end;
  try FBackground.Free; except end;
  inherited;
end;

function  TxpComboBox.FindData (AValue:string):boolean;
var mItm:longint;
begin
  mItm := LocateItem(AValue);
  ItemIndex := mItm;
  Result := (mItm>=0);
end;

function   TxpComboBox.GetItemIndex (pText:string):longint;
var I:longint;
begin
  Result := -1;
  If Items.Count>0 then begin
    For I:=0 to Items.Count-1 do begin
      If Items.Strings [I]=pText then begin
        Result := I;
        Break;
      end;
    end;
  end;
end;

function TxpComboBox.LocateItem (AStartStr : String) : Integer;
var
  I : Integer;
begin
  Result := -1;
  If AStartStr = '' then Exit;
  I := 0;
  While I < Items.Count do begin
    If UpperCase (Copy (Items.Strings [I], 1, Length (AStartStr))) = UpperCase (AStartStr) then begin
      Result := I;
      I := Items.Count;
    end;
    Inc (I);
  end;
end;

function  TxpComboBox.GetDataSource:TDataSource;
begin
  Result := FDataSource;
end;

procedure TxpComboBox.SetDataSource (AValue:TDataSource);
begin
  FDataSource := AValue;
  If (AValue<>nil) and (FFieldName<>'') then (FDataSource as TDataTable).AddField(Owner.Name+'.'+Name+','+FieldName);
end;

procedure TxpComboBox.SetBasicColor (pAValue:TColor);
begin
  oBasicColor := pAValue;
  FxpStyle.FBGStartColor := IccCompHueColor (pAValue, TclIccComboBoxGradBeg);
  FxpStyle.FBGEndColor   := IccCompHueColor (pAValue, TclIccComboBoxGradEnd);
  FxpStyle.FActiveBorderColor := IccCompHueColor (pAValue, TclIccActBorder);
  FxpStyle.FInactiveBorderColor := IccCompHueColor (pAValue, TclIccInactBorder);
  FxpStyle.FActiveButtonColor := IccCompHueColor (pAValue, TclIccComboBoxActButton);
  FxpStyle.FInActiveButtonColor := IccCompHueColor (pAValue, TclIccComboBoxInactButton);
  FxpStyle.FSelStartColor := IccCompHueColor (pAValue, TclIccComboBoxSelBeg);
  FxpStyle.FSelEndColor := IccCompHueColor (pAValue, TclIccComboBoxSelEnd);
  oFocusColor := IccCompHueColor (pAValue, TclIccBGActive);
  oBackColor  := IccCompHueColor (pAValue, TclIccBG);
end;

procedure TxpComboBox.RefreshSystemColor;
begin
  FxpStyle.FBGStartColor := clIccComboBoxGradBeg;
  FxpStyle.FBGEndColor   := clIccComboBoxGradEnd;
  FxpStyle.FActiveBorderColor := clIccActBorder;
  FxpStyle.FInactiveBorderColor := clIccInactBorder;
  FxpStyle.FActiveButtonColor := clIccComboBoxActButton;
  FxpStyle.FInActiveButtonColor := clIccComboBoxInactButton;
  FxpStyle.FSelStartColor := clIccComboBoxSelBeg;
  FxpStyle.FSelEndColor := clIccComboBoxSelEnd;
  oFocusColor := clIccBGActive;
  oBackColor  := clIccBG;
end;

procedure TxpComboBox.CreateParams (var Params: TCreateParams);
begin
  ControlStyle := ControlStyle - [csFixedHeight];
  inherited CreateParams (Params);

  If FxpStyle.Active then begin
    If Style = csOwnerDrawVariable
      then Params.Style := Params.Style or CBS_OWNERDRAWVARIABLE
      else Params.Style := Params.Style or CBS_OWNERDRAWFIXED;
  end;
end;

procedure TxpComboBox.WMPaint(var Message: TWMPaint);
var
  DC : hDC;
  PS : TPaintStruct;
begin
  If FSystemColor then RefreshSystemColor;
  If (not FxpStyle.Active) then begin
    inherited;
    exit;
  end;

  If Message.DC = 0 then DC := BeginPaint(Handle, PS) else DC := Message.DC;
  try
    Canvas.Handle := DC;
    DrawEditText (Canvas, ClientRect, Self.ItemIndex, FFocused);
  finally
    If Message.DC = 0 then EndPaint(Handle, PS);
  end;
  ReleaseDC (Handle, DC);
end;


procedure TxpComboBox.WMNCPaint (var Message : TWMNCPaint);
var
  DC : hDC;
  Pen : hPen;
  Brush : hBrush;
  UpdateRect : TRect;
  Bmp : TBitmap;
begin
  If FSystemColor then RefreshSystemColor;
  If not FxpStyle.Active then begin
    inherited;
    exit;
  end;

  DC := GetWindowDC (Handle);
  GetWindowRect (Handle, UpdateRect);
  OffsetRect (UpdateRect, - UpdateRect.Left, - UpdateRect.Top);
  DrawBorder (DC);

  If Assigned (FxpStyle.Images) then begin
    Canvas.Handle := DC;
    Brush := CreateSolidBrush (ColorToRGB (Color));
    FillRect (DC, Rect (1, 1, FxpStyle.Images.Width + 5, Height-1), Brush);
    DeleteObject (Brush);

    Bmp := TBitmap.Create;
    try
      Bmp.Width := FxpStyle.Images.Width;
      Bmp.Height := FxpStyle.Images.Height;

      If (ItemIndex >= 0) and (ItemIndex < FxpStyle.Images.Count)
        then FxpStyle.Images.GetBitmap (Self.ItemIndex, Bmp)
        else begin
          If (ItemIndex < 0) then begin
            If FxpStyle.FDefaultImageIndex >= 0
              then FxpStyle.Images.GetBitmap (FxpStyle.FDefaultImageIndex, Bmp);
          end else begin
            If FxpStyle.FDefaultListImageIndex >= 0
              then FxpStyle.Images.GetBitmap (FxpStyle.FDefaultListImageIndex, Bmp);
          end;
        end;

      If not Enabled then ConvertBitmapToGrayscale (Bmp);

      Canvas.Draw (2, (Height - FxpStyle.Images.Height) div 2, Bmp);
    finally
      Bmp.Free;
    end;
  end;

  If Style <> csSimple
    then DrawButton (DC, Rect (UpdateRect.Right - FxpStyle.ButtonWidth - 2, UpdateRect.Top+1,
           UpdateRect.Right- 1, UpdateRect.Bottom-1), FxpStyle.ButtonStyle);

  ReleaseDC (Handle, DC);
end;

procedure TxpComboBox.MouseDown (var Message : TWMLBUTTONDOWN);
var OldState : Boolean;
begin
  If not FxpStyle.Active then begin
    inherited;
    exit;
  end;
  FFocused := TRUE;
  SendMessage (Handle, WM_PAINT, 0, 0);
  OldState := Self.DroppedDown;
  inherited;
  If OldState = Self.DroppedDown then Self.DroppedDown := not OldState;
  FOldValue := Text;
end;

procedure TxpComboBox.WMNCCalcSize (var Message : TWMNCCalcSize);
begin
  inherited;
  If not FxpStyle.Active then exit;

  If Assigned (FxpStyle.Images)
    then Inc (Message.CalcSize_Params^.rgrc[0].Left, FxpStyle.Images.Width + 4);

  InflateRect (Message.CalcSize_Params^.rgrc[0], -1, -1);
  If Style <> csSimple then begin
    Dec (Message.CalcSize_Params^.rgrc[0].Right, FxpStyle.FButtonWidth + 1);
  end;
end;

procedure TxpComboBox.WMMeasureItem (var Message : TWMMeasureItem);
begin
  inherited;
  If (not FxpStyle.Active) or (not FxpStyle.AutoHeight) then exit;

  If Assigned (FxpStyle.Images) then begin
    If FxpStyle.Images.Height + 2 > Message.MeasureItemStruct.itemHeight
      then Message.MeasureItemStruct.itemHeight := FxpStyle.Images.Height + 2;
  end;
  Message.Result := 1;
end;

procedure TxpComboBox.WMDrawItem (var Message : TWMDrawItem);
var
  ItemRect : TRect;
  EditRect : TRect;
  EditCanvas : TCanvas;
  DropRect : TRect;
  mRect:TRect;
begin
  If not FxpStyle.Active then begin
    inherited;
    exit;
  end;

  case Message.DrawItemStruct.CtlType of
    ODT_LISTBOX:
    begin
      ItemRect := Message.DrawItemStruct.rcItem;
      Canvas.Handle := Message.DrawItemStruct.hDC;

      If FxpStyle.BGStyle = cbgsNone then begin
        Canvas.Brush.Color := Color;
        Canvas.FillRect (Message.DrawItemStruct.rcItem);
        Canvas.Brush.Style := bsClear;
      end else begin
        SendMessage (Handle, CB_GETDROPPEDCONTROLRECT, 0, LongInt (@DropRect));
        OffsetRect (DropRect, -DropRect.Left, -DropRect.Top);
        If Items.Count = 0 then ItemRect := DropRect;

        BitBlt(Canvas.Handle, ItemRect.Left, ItemRect.Top,
               ItemRect.Right - ItemRect.Left, ItemRect.Bottom -ItemRect.Top,
               FBackground.Canvas.Handle, ItemRect.Left, ItemRect.Top,
               SRCCOPY);
      end;

      If Message.DrawItemStruct.itemAction in [ODA_SELECT, ODA_FOCUS] then begin
        Dec ( ItemRect.Bottom );
        If Message.DrawItemStruct.itemState and ODS_SELECTED = ODS_SELECTED
          then GradientFillRect (Canvas, ItemRect, FxpStyle.SelStartColor,
                FxpStyle.SelEndColor, FxpStyle.SelGradientFillDir, (ItemRect.Right - ItemRect.Left) div 2);
      end;

      If Assigned (FxpStyle.Images) then begin
        If (Message.DrawItemStruct.itemID >= 0) and (Message.DrawItemStruct.itemID < FxpStyle.Images.Count)
          then FxpStyle.Images.Draw (Canvas, ItemRect.Left + 2, ItemRect.Top+2,  Message.DrawItemStruct.itemID)
          else FxpStyle.Images.Draw (Canvas, ItemRect.Left + 2, ItemRect.Top+2,  FxpStyle.DefaultListImageIndex);
        Inc (ItemRect.Left, FxpStyle.Images.Width);
      end;

      Inc (ItemRect.Left, 4);

      Canvas.Brush.Color := clNone;
      Canvas.Brush.Style := BSCLEAR;
      SelectObject (Canvas.Handle, Font.Handle);

      SetTextColor (Canvas.Handle, ColorToRGB (Font.Color));
      If (Message.DrawItemStruct.itemID>-1) and (Message.DrawItemStruct.itemID<Items.Count) 
        then DrawText (Canvas.Handle, PChar (Items [Message.DrawItemStruct.itemID]),
               Length(Items [Message.DrawItemStruct.itemID]),
               ItemRect,
               DT_VCENTER or DT_END_ELLIPSIS or DT_SINGLELINE or DT_Left);


      //Hottracking items

//    If (FxpStyle.FHotTrack) and (Style in [csDropDownList, csOwnerDrawFixed, csOwnerDrawVariable]) then begin
  Canvas.Handle := GetWindowDC (Handle);
  Canvas.Brush.Color := Color;
  Canvas.FillRect (Message.DrawItemStruct.rcItem);
  Canvas.Brush.Style := bsClear;
  ReleaseDC (Handle, Canvas.Handle);

        SendMessage (Handle, WM_NCPAINT, 0, 0);

// Tibi

        EditCanvas := TCanvas.Create;
        try
          EditCanvas.Handle := GetWindowDC (Handle);
          EditRect := ClientRect;
          If Assigned (FxpStyle.Images) then OffsetRect (EditRect, FxpStyle.Images.Width + 4, 0);
          InflateRect (EditRect, -2, -2);
          If (Message.DrawItemStruct.itemID>-1) and (Message.DrawItemStruct.itemID<Items.Count)
            then DrawEditText (EditCanvas, EditRect, Message.DrawItemStruct.itemID, False);
          ReleaseDC (Handle, EditCanvas.Handle);
        finally
          EditCanvas.Free;
        end;
//    end;

    end;
  end;
// ****
  mRect := Message.DrawItemStruct.rcItem;
  mRect := ClientRect;
  OffsetRect(mRect,1,1);
  Canvas.Handle := GetWindowDC (Handle);
  Canvas.Brush.Color := Color;
  Canvas.FillRect (mRect);
  Canvas.Brush.Style := bsClear;
  Canvas.Font.Assign (Self.Font);
  OffsetRect(mRect,3,0);
      DrawText (Canvas.Handle, PChar (Text),
               Length (Text),
               mRect,
               DT_VCENTER or DT_END_ELLIPSIS or DT_SINGLELINE or DT_Left);

  ReleaseDC (Handle, Canvas.Handle);
//  SendMessage (Handle, WM_NCPAINT, 0, 0);
end;

procedure TxpComboBox.DrawEditText (ACanvas : TCanvas; ARect : TRect; AItemIndex : Integer; IsSelected : Boolean);
begin
  ACanvas.Brush.Color := Color;
  InflateRect (ARect, 1, 1);
  ACanvas.FillRect (ARect);
  InflateRect (ARect, -3, -3);
  Inc (ARect.Left);
  Inc (ARect.Top);
  If not (Style in [csSimple, csDropDown]) then begin
    ACanvas.Brush.Color := clNone;
    ACanvas.Brush.Style := BSCLEAR;
    ACanvas.Font.Assign (Self.Font);
    InflateRect (ARect, -2, 0);

    If not Enabled then ACanvas.Font.Color := clGrayText;

    SelectObject (ACanvas.Handle, Self.Font.Handle);
    SetTextColor (ACanvas.Handle, ColorToRGB (ACanvas.Font.Color));
    DrawText (ACanvas.Handle, PChar (Items [AItemIndex]),
              Length(Items [AItemIndex]),
              ARect,
              DT_VCENTER or DT_END_ELLIPSIS or DT_SINGLELINE or DT_LEFT);
    end;

end;

procedure TxpComboBox.DrawBorder (DC : hDC);
var
  Brush : hBrush;
  BoundRect : TRect;
begin
  GetWindowRect (Handle, BoundRect);
  OffsetRect (BoundRect, - BoundRect.Left, - BoundRect.Top);

  If FFocused or FActive
    then Brush := CreateSolidBrush (ColorToRGB (FxpStyle.ActiveBorderColor))
    else Brush := CreateSolidBrush (ColorToRGB (FxpStyle.InActiveBorderColor));

  try
    FrameRect (DC, BoundRect, Brush);
  finally
    DeleteObject (Brush);
  end;
end;


procedure TxpComboBox.DrawFlatButton (DC : hDC; AButtonRect : TRect);
var
  Brush : hBrush;
  Pen : hPen;
  SepPen : hPen;
begin
  If FFocused or FActive then begin
    //left separating line color
    SepPen := CreatePen (PS_SOLID, 1, ColorToRGB (FxpStyle.ActiveBorderColor));
    //Create brush
    Brush := CreateSolidBrush (ColorToRGB (FxpStyle.ActiveButtonColor));
    Pen := CreatePen (PS_SOLID, 1, ColorToRGB (FxpStyle.ActiveButtonColor));
  end else begin
    //left separating line color
    SepPen := CreatePen (PS_SOLID, 1, ColorToRGB (Color));
    //Create brush
    Brush := CreateSolidBrush (ColorToRGB (FxpStyle.InActiveButtonColor));
    Pen := CreatePen (PS_SOLID, 1, ColorToRGB (Color));
  end;
  SelectObject(DC, Brush);
  SelectObject(DC, Pen);
  SelectObject(DC, SepPen);

  //Draw left separating line
  MoveToEx (DC, AButtonRect.Left, AButtonRect.Top, nil);
  LineTo (DC, AButtonRect.Left, AButtonRect.Bottom);
  DeleteObject (SepPen);

  If (FFocused or FActive) then begin
    Inc (AButtonRect.Right);
    Inc (AButtonRect.Bottom);
    Dec (AButtonRect.Top);
  end;

  Rectangle (DC, AButtonRect.Left, AButtonRect.Top, AButtonRect.Right, AButtonRect.Bottom);
  DeleteObject (Brush);
  DeleteObject (Pen);

  //Draw arrow
  Pen := CreatePen (PS_SOLID, 1, ColorToRGB (clBlack));
  SelectObject(DC, Pen);
  MoveToEx (DC, (AButtonRect.Right + AButtonRect.Left - 5) div 2, (AButtonRect.Top + AButtonRect.Bottom) div 2, nil);
  LineTo (DC, (AButtonRect.Right + AButtonRect.Left - 5) div 2 + 5, (AButtonRect.Top + AButtonRect.Bottom) div 2);

  MoveToEx (DC, (AButtonRect.Right + AButtonRect.Left - 5) div 2+1, (AButtonRect.Top + AButtonRect.Bottom) div 2+1, nil);
  LineTo (DC, (AButtonRect.Right + AButtonRect.Left - 5) div 2 + 4, (AButtonRect.Top + AButtonRect.Bottom) div 2+1);

  MoveToEx (DC, (AButtonRect.Right + AButtonRect.Left - 5) div 2+2, (AButtonRect.Top + AButtonRect.Bottom) div 2+2, nil);
  LineTo (DC, (AButtonRect.Right + AButtonRect.Left - 5) div 2 + 3, (AButtonRect.Top + AButtonRect.Bottom) div 2+2);

  DeleteObject (Pen);
end;


procedure TxpComboBox.DrawXPButton (DC : hDC; AButtonRect : TRect);
var
  ACanvas : TCanvas;
begin
  ACanvas := TCanvas.Create;
  try
    ACanvas.Handle := DC;

    ACanvas.Brush.Color := Color;
    ACanvas.Pen.Color := Color;
    ACanvas.FillRect (AButtonRect);

    Inc (AButtonRect.Top);
    Dec (AButtonRect.Bottom);
    Dec (AButtonRect.Right);

    If FFocused or FActive then begin
      ACanvas.Brush.Color := FxpStyle.ActiveButtonColor;
      ACanvas.Pen.Color := MakeDarkColor (FxpStyle.ActiveButtonColor, 20);
      ACanvas.RoundRect (AButtonRect.Left, AButtonRect.Top, AButtonRect.Right, AButtonRect.Bottom, 2, 2);
      InflateRect (AButtonRect, -2, -2);
      GradientFillRect (ACanvas, AButtonRect, FxpStyle.ActiveButtonColor, MakeDarkColor (FxpStyle.ActiveButtonColor, 10), fdTopToBottom, 5);
    end else begin
      ACanvas.Brush.Color := FxpStyle.InActiveButtonColor;
      ACanvas.Pen.Color := MakeDarkColor (FxpStyle.InActiveButtonColor, 20);
      ACanvas.RoundRect (AButtonRect.Left, AButtonRect.Top, AButtonRect.Right, AButtonRect.Bottom, 2, 2);
      InflateRect (AButtonRect, -2, -2);
      GradientFillRect (ACanvas, AButtonRect, FxpStyle.InActiveButtonColor, MakeDarkColor (FxpStyle.InActiveButtonColor, 10), fdTopToBottom, 5);
    end;

    //Arrow drawing
    ACanvas.Pen.Color := FxpStyle.ActiveBorderColor;
    ACanvas.MoveTo ((AButtonRect.Right + AButtonRect.Left - 5) div 2, (AButtonRect.Top + AButtonRect.Bottom) div 2);
    ACanvas.LineTo ((AButtonRect.Right + AButtonRect.Left - 5) div 2 + 5, (AButtonRect.Top + AButtonRect.Bottom) div 2);
    ACanvas.MoveTo ((AButtonRect.Right + AButtonRect.Left - 5) div 2+1, (AButtonRect.Top + AButtonRect.Bottom) div 2+1);
    ACanvas.LineTo ((AButtonRect.Right + AButtonRect.Left - 5) div 2 + 4, (AButtonRect.Top + AButtonRect.Bottom) div 2+1);
    ACanvas.MoveTo ((AButtonRect.Right + AButtonRect.Left - 5) div 2+2, (AButtonRect.Top + AButtonRect.Bottom) div 2+2);
    ACanvas.LineTo ((AButtonRect.Right + AButtonRect.Left - 5) div 2 + 3, (AButtonRect.Top + AButtonRect.Bottom) div 2+2);

  finally
    ACanvas.Free;
  end;
end;



procedure TxpComboBox.DrawButton (DC : hDC; AButtonRect : TRect; AStyle : TxpComboButtonStyle);
begin
  case AStyle of
    cbsFlat : DrawFlatButton (DC, AButtonRect);
    cbsXP   : DrawXPButton (DC, AButtonRect);
  end;
end;

procedure TxpComboBox.NCHitTest (var Message : TWMNCHitTest);
var
  WinRct : TRect;
begin
  If (not FxpStyle.Active) or (csDesigning in ComponentState) then begin
    inherited;
    exit;
  end;

  GetWindowRect (Handle, WinRct);

  Message.Result := 0;

  case Style of
    csDropDown:
      If PtInRect (Rect (WinRct.Right - FxpStyle.ButtonWidth - 2, WinRct.Top+1,
         WinRct.Right- 1, WinRct.Bottom-1), Point (Message.XPos, Message.YPos))
      then
      Message.Result := 1;
    csDropDownList, csOwnerDrawFixed, csOwnerDrawVariable:
      Message.Result := 1;
    csSimple:
      Message.Result := 0;
  end;

end;

procedure TxpComboBox.MouseEnter (var Message : TMessage);
begin
  If (not FActive) then begin
    FActive := true;
    If not DroppedDown then SendMessage (Handle, WM_NCPAINT, 0, 0);
  end;
end;            

procedure TxpComboBox.MouseLeave (var Message : TMessage);
begin
  If FActive then begin
    FActive := False;
    If not DroppedDown then SendMessage (Handle, WM_NCPAINT, 0, 0);
  end;
end;

procedure TxpComboBox.WMSetFocus(var Message : TMessage);
begin
  inherited;
  If not FxpStyle.Active then exit;
  FFocused := true;
  SendMessage (Handle, WM_NCPAINT, 0, 0);
end;

procedure TxpComboBox.WMKillFocus(var Message : TMessage);
begin
  inherited;
  If not FxpStyle.Active then exit;
  FFocused := False;
end;

procedure TxpComboBox.WMCommand (var Message : TWMCOMMAND);
begin
  inherited;

  If Message.NotIfyCode = EN_CHANGE then begin
    SendMessage (Handle, WM_NCPAINT, 0, 0);
  end;
end;

procedure TxpComboBox.CNCommand (var Message : TWMCOMMAND);
var
  AItemIndex : Integer;
  AStr : String;
  DropRect : TRect;
begin
  inherited;
  If not FxpStyle.Active then Exit;

  case Message.NotIfyCode of
    CBN_SELCHANGE:
      begin
        FOldText := Text;
        SendMessage (Handle, WM_NCPAINT, 0, 0);
        Invalidate;
      end;
    CBN_EDITUPDATE: //CBN_EDITCHANGE:
      begin
        If FxpStyle.FAutoSearch then begin
          If (not FLocating) and (Length (FOldText) < Length (Text)) then begin
            FLocating := true;
            try
              AItemIndex := LocateItem (Text);
              If AItemIndex <> -1 then begin
                AStr := Text;
                FOldText := Copy (Text, 1, Length (AStr));
                Self.ItemIndex := AItemIndex;
                SelStart := Length (AStr);
                SelLength := Length (Text) - Length (AStr);
                SendMessage (Handle, WM_NCPAINT, 0, 0);
              end;
            finally
              FLocating := False;
            end;
          end else FOldText := Copy (Text, 1, SelStart+1);
        end;

    end;
    CBN_CLOSEUP:
      begin
        try FBackground.FreeImage; except end;
        SendMessage (Handle, WM_NCPAINT, 0, 0);
      end;

    CBN_DROPDOWN:
      begin
          SendMessage (Handle, CB_GETDROPPEDCONTROLRECT, 0, LongInt (@DropRect));
          OffsetRect (DropRect, -DropRect.Left, -DropRect.Top);

          try FBackground.FreeImage; except end;
          FBackground.Width := DropRect.Right;
          FBackground.Height := DropRect.Bottom;

            case FxpStyle.BGStyle of
              cbgsGradient:
                begin
                  GradientFillRect (FBackground.Canvas, DropRect, FxpStyle.BGStartColor,
                      FxpStyle.BGEndColor, FxpStyle.BGGradientFillDir, 60);
                end;
              cbgsTiledImage:
                begin
                  If not FxpStyle.BGImage.Empty
                    then TileImage (FBackground.Canvas, DropRect, FxpStyle.BGImage)
                    else begin
                      FBackground.Canvas.Brush.Color := Color;
                      FBackground.Canvas.FillRect (DropRect);
                    end;
                end;
              cbgsStretchedImage:
                begin
                  If not FxpStyle.BGImage.Empty
                    then FBackground.Canvas.StretchDraw (DropRect, FxpStyle.BGImage)
                    else begin
                      FBackground.Canvas.Brush.Color := Color;
                      FBackground.Canvas.FillRect (DropRect);
                    end;
                end;
            end;

      end;
    CBN_SETFOCUS:
      begin
        FFocused := true;
        SendMessage (Handle, WM_NCPAINT, 0, 0);
        Invalidate;
  Color := oFocusColor;
  SendMessage (Handle, WM_NCPAINT, 0, 0);
  FOldValue := Text;
      end;
    CBN_KILLFOCUS:
      begin
        If FxpStyle.AutoSearch then begin
          AItemIndex := Perform (CB_FINDSTRINGEXACT, 0, LongInt (PChar (Text)));
          If AItemIndex >= 0 then ItemIndex := AItemIndex;
        end;
        FFocused := False;
        SendMessage (Handle, WM_NCPAINT, 0, 0);
  Color := oBackColor;
  SendMessage (Handle, WM_NCPAINT, 0, 0);
  If (FOldValue<>Text) and Assigned(FOnModified) then FOnModified(Self);
      end;
  end;
  
end;

procedure TxpComboBox.CMEnter(var Message: TCMGotFocus);
begin
  inherited;
//  Color := oFocusColor;
//  SendMessage (Handle, WM_NCPAINT, 0, 0);
//  FOldValue := Text;
end;

procedure TxpComboBox.CMExit(var Message: TCMExit);
begin
  inherited;
//  Color := oBackColor;
//  SendMessage (Handle, WM_NCPAINT, 0, 0);
//  If (FOldValue<>Text) and Assigned(FOnModified) then FOnModified(Self);
end;

procedure TxpComboBox.KeyDown(var Key: Word; Shift: TShiftState);
var Msg: TMsg; mKeyFilt:boolean;
begin
  inherited KeyDown(Key, Shift);
  If not Self.DroppedDown then begin
    If (Key = VK_DOWN) and (Shift <> [ssShift]) then begin
      SendMessage((Owner as TForm).Handle, WM_NEXTDLGCTL, 0, 0);
      // Vypnutie sysutils.beep po opusteni pola formulara inou klavesou ako TAB
      PeekMessage(Msg, 0, WM_CHAR, WM_CHAR, PM_REMOVE);
      Key := 0;
    end;
    If (Key = VK_UP) and (Shift <> [ssShift]) then begin
      SendMessage ((Owner as TForm).Handle,WM_NEXTDLGCTL,1,0);
      // Vypnutie sysutils.beep po opusteni pola formulara inou klavesou ako TAB
      PeekMessage(Msg, 0, WM_CHAR, WM_CHAR, PM_REMOVE);
      Key := 0;
    end;
  end;
  If Key in [VK_RETURN] then begin
    SendMessage((Owner as TForm).Handle, WM_NEXTDLGCTL, 0, 0);
    // Vypnutie sysutils.beep po opusteni pola formulara inou klavesou ako TAB
    PeekMessage(Msg, 0, WM_CHAR, WM_CHAR, PM_REMOVE);
  end;

  If (Key in [VK_F7]) and (SendMessage(Handle, CB_GETDROPPEDSTATE, 0, 0) <> 1) then begin
    SendMessage(Handle, CB_SHOWDROPDOWN, 1, 0);
    SelectItem(Text);
    SelectAll;
  end;
end;

procedure TxpComboBox.NotIfication(AComponent: TComponent;
  Operation: TOperation);
begin
  inherited NotIfication(AComponent, Operation);
  If Operation = opRemove then begin
    If AComponent = FxpStyle.Images then FxpStyle.Images := nil;
  end;
end;

procedure TxpComboBox.CMEnabledChanged (var Message: TMessage);
begin
  inherited;
  SendMessage (Handle, WM_NCPAINT, 0, 0);
  Invalidate;
end;

// TxpPageControl
constructor TxpPageControl.Create (AOwner : TComponent);
begin
  inherited Create (AOwner);
  FCanvas := TControlCanvas.Create;

  FTabPosition := tpTop;

  FHotTrackTab := -1;

  ShowHint := true;
  FStyle := pcsXP;

  FTabTextAlignment := taCenter;
  FOwnerDraw := False;
  oTabsShow := TRUE;

  ParentColor := FALSE;
  Color := clIccPageBG;
  FBorderColor := clIccInactBorder;
  oBasicColor := cbcBasicColor;
end;

// remove link with glyphs and free the canvas

destructor TxpPageControl.Destroy;
begin
  try
    FCanvas.Free;
  except
  end;
  if Assigned (FImageList) then
  try
    FImageList.OnChange := nil;
  except
  end;
  inherited Destroy;
end;

// CreateParams called to set the additional style bits

procedure TxpPageControl.CreateParams(var Params: TCreateParams);
begin
  inherited CreateParams (Params);

  with Params do
  begin
    case FStyle of
      pcsTabs: Style:= Style or TCS_TABS;
      pcsButtons: Style:= Style or TCS_BUTTONS;
      pcsFlatButtons: Style := Style or TCS_BUTTONS or TCS_FLATBUTTONS;
      pcsXP: begin end;
    end;
    if FOwnerDraw then Style := Style or TCS_OWNERDRAWFIXED;

    case FTabPosition of
      tpTop:
      begin
        //Style := Style and (not TCS_VERTICAL) and (not TCS_BOTTOM);
      end;
      tpBottom:
      begin
        Style := Style or TCS_BOTTOM;
      end;
      tpLeft:
      begin
        Style := Style or TCS_VERTICAL;
      end;
      tpRight:
      begin
        Style := Style or TCS_VERTICAL or TCS_RIGHT;
      end;
    end;
  end;
end;

// CreateWnd also must set links to the glyphs

procedure TxpPageControl.CreateWnd;
begin
  inherited CreateWnd;
  if Assigned (FImageList) then SetGlyphs (FImageList);
end;

// if the glyphs should change then update the tabs

procedure TxpPageControl.GlyphsChanged (Sender : TObject);
begin
  if Assigned (FImageList) then UpdateGlyphs;
end;

// multiline property redefined as readonly, this makes it
// disappear from the object inspector

function TxpPageControl.GetMultiline : boolean;
begin
  Result := inherited Multiline
end;

// link the tabs to the glyph list
// nil parameter removes link

procedure TxpPageControl.SetGlyphs (Value : TImageList);
var
  I : Integer;
begin
  FImageList := Value;
  if Assigned(FImageList) then
    begin
      SendMessage (Handle, TCM_SETIMAGELIST, 0, FImageList.Handle);
      For I := 0 to PageCount - 1 do
        (Pages[I] as TxpTabSheet).ImageIndex := I;
      FImageList.OnChange := GlyphsChanged
    end
  else
  begin
    SendMessage (Handle, TCM_SETIMAGELIST, 0, 0);
    For I := 0 to PageCount - 1 do
      (Pages[I] as TxpTabSheet).ImageIndex := -1;
  end;
  UpdateGlyphs;
  SendMessage (Handle, WM_SIZE, 0, 0);
end;


// determine properties whenever the tab styles are changed

procedure TxpPageControl.SetOwnerDraw (AValue : Boolean);
begin
  if FOwnerDraw <> AValue then
  begin
    FOwnerDraw := AValue;
    ReCreateWnd;
    SendMessage (Handle, WM_SIZE, 0, 0);
    if (Self.PageCount > 0) and (ActivePage <> nil) then
      ActivePage.Invalidate;
  end
end;

procedure TxpPageControl.SetTabsShow (pValue:boolean);
begin
  oTabsShow := pValue;
  If oTabsShow
    then TabHeight := 0  // automatick· veækost
    else TabHeight := 1;
end;

procedure TxpPageControl.SetBasicColor (pAValue:TColor);
begin
  If not FSystemColor then begin
    FBorderColor := IccCompHueColor (pAValue, TclIccInactBorder);
    Color := IccCompHueColor (pAValue, TclIccPageBG);
  end;
end;

procedure TxpPageControl.RefreshSystemColor;
begin
  FBorderColor := clIccInactBorder;
  Color := clIccPageBG;
end;

// update the glyphs linked to the tab

procedure TxpPageControl.UpdateGlyphs;
var
  TCItem : TTCItem;
  Control,
  Loop : integer;
begin
  if FImageList <> nil then
  begin
    for Loop := 0 to pred(PageCount) do
    begin
      TCItem.Mask := TCIF_IMAGE;
      TCItem.iImage := Loop;
      Control := Loop;
      // OnGlyphMap allows the user to reselect the glyph linked to a
      // particular tab
      if Assigned (FOnGlyphMap) then
        FOnGlyphMap (Self, Control, TCItem.iImage);

      if SendMessage (Handle, TCM_SETITEM, Control, longint(@TCItem)) = 0 then;
        //raise EListError.Create ('TxpPageControl error in setting tab glyph')
    end
  end
end;

// called when Owner Draw style is selected:
// retrieve the component style, set up the canvas and
// call the DrawItem method

procedure TxpPageControl.CNDrawItem (var Msg : TWMDrawItem);
var
  State: TOwnerDrawState;
begin
  with Msg.DrawItemStruct^ do
  begin
    //State := TOwnerDrawState (WordRec (LongRec (itemState).Lo).Lo);
    //!!
    FCanvas.Handle := hDC;
    FCanvas.Font := Font;
    FCanvas.Brush := Brush;
    if integer (itemID) >= 0 then
      DrawItem (itemID, rcItem, State)
    else
      FCanvas.FillRect (rcItem);
    FCanvas.Handle := 0
  end;
end;

// default DrawItem method

procedure TxpPageControl.DrawItem (Index: Integer; Rect: TRect; State: TOwnerDrawState);
begin
  if Assigned(FOnDrawItem) then
    FOnDrawItem (Self, Index, Rect, State)
  else begin
    GradientFillRect (FCanvas, Rect, clWhite, RGB (220,220,220), fdVerticalFromCenter, (Rect.Bottom - Rect.Top) div 2);
    FCanvas.Brush.Style := BSCLEAR;
    if odSelected in State then
      FCanvas.TextOut (Rect.Left + 16, Rect.Top + (Rect.Bottom - Rect.Top - FCanvas.TextHeight ('A')) div 2, Tabs[Index])
    else
      FCanvas.TextOut (Rect.Left + 12, Rect.Top + (Rect.Bottom - Rect.Top - FCanvas.TextHeight ('A')) div 2, Tabs[Index])
  end
end;

procedure TxpPageControl.WMAdjasment (var Msg : TMessage);
begin
  inherited;
  if Msg.WParam = 0 then
  begin
    InflateRect(PRect(Msg.LParam)^, 3, 3);
    Dec(PRect(Msg.LParam)^.Top, 1);
  end;
end;

procedure TxpPageControl.WMNCPaint (var Message : TWMNCPaint);
var DC:hDC;
begin
  If FSystemColor then RefreshSystemColor;
  inherited;
end;

procedure TxpPageControl.DrawHotTrackTab (ATabIndex : Integer; AHotTrack : Boolean);
var
  ItemRect    : TRect;
  DrawRect    : TRect;
  StartColor  : TColor;
  EndColor    : TColor;
begin
  if SendMessage (Handle, TCM_GETITEMRECT, ATabIndex, LongInt (@ItemRect)) <> 0 then
  begin
    DrawRect := ItemRect;
    case TabPosition of
      tpTop:    begin
                  DrawRect.Left := ItemRect.Left + 2;
                  DrawRect.Right := ItemRect.Right - 3;
                  DrawRect.Bottom := ItemRect.Top + 1;
                  if AHotTrack then
                  begin
                    StartColor := $2C8BE6;
                    EndColor := $3CC7FF;
                  end
                  else
                  begin
                    StartColor := FBorderColor;
                    EndColor := MakeDarkColor ((Pages[ATabIndex] as TxpTabSheet).FColor, 5);
                  end;
                end;
      tpBottom: begin
                  DrawRect.Top := ItemRect.Bottom - 3;
                  DrawRect.Bottom := ItemRect.Bottom - 2;
                  DrawRect.Left := ItemRect.Left + 2;
                  DrawRect.Right := ItemRect.Right - 3;
                  if AHotTrack then
                  begin
                    StartColor := $3CC7FF;
                    EndColor := $2C8BE6;
                  end
                  else
                  begin
                    StartColor := MakeDarkColor ((Pages[ATabIndex] as TxpTabSheet).FColor, 20);
                    EndColor := FBorderColor;
                  end;
                end;
      tpLeft:   begin
                  DrawRect.Left := ItemRect.Left;
                  DrawRect.Top := ItemRect.Top+2;
                  DrawRect.Bottom := ItemRect.Bottom - 3;
                  DrawRect.Right := ItemRect.Left+1;
                  if AHotTrack then
                  begin
                    StartColor := $3CC7FF;
                    EndColor := $2C8BE6;
                  end
                  else
                  begin
                    StartColor := FBorderColor;
                    EndColor := MakeDarkColor ((Pages[ATabIndex] as TxpTabSheet).FColor, 20);
                  end;
                end;
      tpRight:  begin
                  DrawRect.Left := ItemRect.Right-1;
                  DrawRect.Top := ItemRect.Top+2;
                  DrawRect.Bottom := ItemRect.Bottom - 3;
                  DrawRect.Right := ItemRect.Right;
                  if AHotTrack then
                  begin
                    StartColor := $3CC7FF;
                    EndColor := $2C8BE6;
                  end
                  else
                  begin
                    StartColor := FBorderColor;
                    EndColor := MakeDarkColor ((Pages[ATabIndex] as TxpTabSheet).FColor, 20);
                  end;
                end;
    end;
    FCanvas.Handle := GetWindowDC (Handle);

    case TabPosition of
     tpTop, tpBottom:
       begin
         FCanvas.Pen.Color := StartColor;
         FCanvas.MoveTo (DrawRect.Left, DrawRect.Top );
         FCanvas.LineTo (DrawRect.Right, DrawRect.Top );
         FCanvas.Pen.Color := EndColor;
         FCanvas.MoveTo (DrawRect.Left, DrawRect.Bottom);
         FCanvas.LineTo (DrawRect.Right, DrawRect.Bottom);
       end;
     tpLeft,tpRight:
       begin
         FCanvas.Pen.Color := StartColor;
         FCanvas.MoveTo (DrawRect.Left, DrawRect.Top );
         FCanvas.LineTo (DrawRect.Left, DrawRect.Bottom);
         FCanvas.Pen.Color := EndColor;
         FCanvas.MoveTo (DrawRect.Right, DrawRect.Top);
         FCanvas.LineTo (DrawRect.Right, DrawRect.Bottom);
       end;
    end;
    ReleaseDC (Handle, FCanvas.Handle);
  end;
end;


procedure TxpPageControl.DrawItemInside (AIndex : Integer; ACanvas : TCanvas; ARect : TRect);
var
  dX       : Integer;
  ACaption : String;
  AFormat  : Integer;
  DrawRect : TRect;
begin
  ACanvas.Brush.Style := BSCLEAR;
  ACanvas.Font.Assign (Self.Pages[AIndex].Font);
  If Assigned (FImageList) then dX := FImageList.Width + 6 else dX := 0;

  DrawRect := ARect;
  InflateRect (DrawRect, -2, -2);
  DrawRect.Left := DrawRect.Left + dX;

  ACaption := Self.Pages[AIndex].Caption;

  AFormat := DT_VCENTER or DT_END_ELLIPSIS or DT_SINGLELINE;

  case FTabTextAlignment of
    taLeftJustify: AFormat := AFormat or DT_LEFT;
    taRightJustify: AFormat := AFormat or DT_RIGHT;
    taCenter: AFormat := AFormat or DT_CENTER;
  end;

  ACanvas.Font.Color := MakeDarkColor ( (TxpTabSheet(Self.Pages[AIndex]).FColor), 30);
  OffsetRect (DrawRect, 1, 1);
  DrawText (ACanvas.Handle, PChar (ACaption), Length(ACaption), DrawRect, AFormat);

  ACanvas.Font.Color := Self.Pages[AIndex].Font.Color;
  OffsetRect (DrawRect, -1,-1);
  DrawText (ACanvas.Handle, PChar (ACaption), Length(ACaption), DrawRect, AFormat);

  if Assigned (FImageList) then
  begin
    FImageList.Draw (ACanvas, ARect.Left + 3,
                              (ARect.Top + ARect.Bottom - FImageList.Height) div 2,
                              (Self.Pages[AIndex] as TxpTabSheet).ImageIndex);
  end;

end;


procedure TxpPageControl.DrawTopTab (TabRect : TRect; ACanvas : TCanvas; AIndex, AVisibleIndex : Integer);
var
  AActiveTab : Boolean;
  ATabColor  : TColor;
begin
  Dec (TabRect.Bottom,2);
  AActiveTab := (SendMessage (Handle, TCM_GETCURSEL, 0, 0) = AVisibleIndex);
  ATabColor := (Self.Pages [AIndex] as TxpTabSheet).FColor;
//  ATabColor := clIccPageTab;
  If AActiveTab then begin
    Dec (TabRect.Top, 2);
    Dec (TabRect.Left, 2);
    Inc (TabRect.Right, 1);
    ATabColor := MakeDarkColor (ATabColor, 10);
  end else begin
    Dec (TabRect.Right);
    Dec (TabRect.Bottom);
    ATabColor := MakeDarkColor (ATabColor, -30);
  end;
  Inc (TabRect.Bottom, 1);

  ACanvas.Brush.Color := ATabColor;
  ACanvas.Pen.Color := FBorderColor;
  ACanvas.Rectangle (TabRect.Left, TabRect.Top + 6, TabRect.Right, TabRect.Bottom);
  ACanvas.RoundRect (TabRect.Left, TabRect.Top, TabRect.Right, TabRect.Bottom - 7, 6, 6);
  ACanvas.FillRect (Rect (TabRect.Left+1, TabRect.Top + 5, TabRect.Right-1, TabRect.Bottom));

  If AActiveTab then begin
    ACanvas.Brush.Color := ATabColor;
    ACanvas.Pen.Color := ATabColor;
    ACanvas.Rectangle (TabRect.Left+1, TabRect.Bottom-1, TabRect.Right-1, TabRect.Bottom+2);

    If HotTrack then begin
      FCanvas.Pen.Color := $2C8BE6;
      FCanvas.MoveTo (TabRect.Left + 2, TabRect.Top );
      FCanvas.LineTo (TabRect.Right - 2, TabRect.Top );
      FCanvas.Pen.Color := $3CC7FF;
      FCanvas.MoveTo (TabRect.Left + 2, TabRect.Top + 1);
      FCanvas.LineTo (TabRect.Right - 2, TabRect.Top + 1);
    end;
  end else begin
    //Draw tab vertical right shadow line
    ACanvas.Pen.Color := MakeDarkColor (ATabColor, 20);
    ACanvas.Brush.Color := ATabColor;
    ACanvas.MoveTo (TabRect.Right-2, TabRect.Top+2);
    ACanvas.LineTo (TabRect.Right-2, TabRect.Bottom-1);

    ACanvas.Pen.Color := MakeDarkColor (ATabColor, 10);
    ACanvas.MoveTo (TabRect.Right-3, TabRect.Top+4);
    ACanvas.LineTo (TabRect.Right-3, TabRect.Bottom-2);

    //Draw tab horizontal bottom shadow line
    ACanvas.Pen.Color := MakeDarkColor (ATabColor, 20);
    ACanvas.Brush.Color := ATabColor;
    ACanvas.MoveTo (TabRect.Left+2, TabRect.Bottom-1);
    ACanvas.LineTo (TabRect.Right-2, TabRect.Bottom-1);

    ACanvas.Pen.Color := MakeDarkColor (ATabColor, 10);
    ACanvas.MoveTo (TabRect.Left + 3, TabRect.Bottom - 2);
    ACanvas.LineTo (TabRect.Right-3, TabRect.Bottom-2);

  end;
  //Draw text and image
  DrawItemInside (AIndex, ACanvas, TabRect);
end;

procedure TxpPageControl.DrawBottomTab (TabRect : TRect; ACanvas : TCanvas; AIndex, AVisibleIndex : Integer);
var
  AActiveTab : Boolean;
  ATabColor  : TColor;
begin
  Dec (TabRect.Bottom,2);
  AActiveTab := (SendMessage (Handle, TCM_GETCURSEL, 0, 0) = AVisibleIndex);
  ATabColor := (Self.Pages [AIndex] as TxpTabSheet).FColor;
  if AActiveTab then begin
    Inc (TabRect.Bottom, 1);
    Dec (TabRect.Left, 2);
    Inc (TabRect.Right, 1);
    ATabColor := MakeDarkColor (ATabColor, 10);
  end else begin
    Dec (TabRect.Right);
    Inc (TabRect.Top);
    ATabColor := MakeDarkColor (ATabColor, -30);
  end;

  Inc (TabRect.Bottom, 1);

  ACanvas.Brush.Color := ATabColor;
  ACanvas.Pen.Color := FBorderColor;
  ACanvas.Rectangle (TabRect.Left, TabRect.Top, TabRect.Right, TabRect.Bottom - 6);
  ACanvas.RoundRect (TabRect.Left, TabRect.Top+6, TabRect.Right, TabRect.Bottom, 6, 6);
  ACanvas.FillRect (Rect (TabRect.Left+1, TabRect.Top+6, TabRect.Right-1, TabRect.Bottom-3));

  if AActiveTab then begin
    ACanvas.Brush.Color := ATabColor;
    ACanvas.Pen.Color := ATabColor;
    ACanvas.Rectangle (TabRect.Left+1, TabRect.Top-1, TabRect.Right-1, TabRect.Top+2);

    if HotTrack then begin
      FCanvas.Pen.Color := $2C8BE6;
      FCanvas.MoveTo (TabRect.Left + 2, TabRect.Bottom -1);
      FCanvas.LineTo (TabRect.Right - 2, TabRect.Bottom -1);
      FCanvas.Pen.Color := $3CC7FF;
      FCanvas.MoveTo (TabRect.Left + 2, TabRect.Bottom);
      FCanvas.LineTo (TabRect.Right - 2, TabRect.Bottom);
    end;
  end else begin
    //Draw tab vertical right shadow line
    ACanvas.Pen.Color := MakeDarkColor (ATabColor, 20);
    ACanvas.Brush.Color := ATabColor;
    ACanvas.MoveTo (TabRect.Right-2, TabRect.Top+2);
    ACanvas.LineTo (TabRect.Right-2, TabRect.Bottom-2);

    ACanvas.Pen.Color := MakeDarkColor (ATabColor, 10);
    ACanvas.MoveTo (TabRect.Right-3, TabRect.Top+4);
    ACanvas.LineTo (TabRect.Right-3, TabRect.Bottom-3);

    //Draw tab horizontal bottom shadow line
    ACanvas.Pen.Color := MakeDarkColor (ATabColor, 20);
    ACanvas.Brush.Color := ATabColor;
    ACanvas.MoveTo (TabRect.Left+2, TabRect.Bottom-2);
    ACanvas.LineTo (TabRect.Right-2, TabRect.Bottom-2);

    ACanvas.Pen.Color := MakeDarkColor (ATabColor, 10);
    ACanvas.MoveTo (TabRect.Left + 3, TabRect.Bottom - 3);
    ACanvas.LineTo (TabRect.Right-3, TabRect.Bottom-3);
  end;

  //Draw text and image
  DrawItemInside (AIndex, ACanvas, TabRect);

end;

procedure TxpPageControl.DrawLeftTab (TabRect : TRect; ACanvas : TCanvas; AIndex, AVisibleIndex : Integer);
var
  AActiveTab : Boolean;
  ATabColor  : TColor;
begin
  Dec (TabRect.Bottom,2);
  AActiveTab := (SendMessage (Handle, TCM_GETCURSEL, 0, 0) = AVisibleIndex);
  ATabColor := (Self.Pages [AIndex] as TxpTabSheet).FColor;
  if AActiveTab then begin
    Dec (TabRect.Left, 2);
    Dec (TabRect.Top, 1);
    Inc (TabRect.Bottom, 1);
    ATabColor := MakeDarkColor (ATabColor, 10);
  end else begin
    Dec (TabRect.Right);
    ATabColor := MakeDarkColor (ATabColor, -30);
  end;
  Inc (TabRect.Bottom, 1);

  ACanvas.Brush.Color := ATabColor;
  ACanvas.Pen.Color := FBorderColor;
  ACanvas.Rectangle (TabRect.Left+6, TabRect.Top, TabRect.Right, TabRect.Bottom);
  ACanvas.RoundRect (TabRect.Left, TabRect.Top, TabRect.Left+8, TabRect.Bottom, 6, 6);
  ACanvas.FillRect (Rect (TabRect.Left+5, TabRect.Top + 1, TabRect.Right-1, TabRect.Bottom-1));

  if AActiveTab then begin
    if HotTrack then begin
      FCanvas.Pen.Color := $2C8BE6;
      FCanvas.MoveTo (TabRect.Left, TabRect.Top + 2);
      FCanvas.LineTo (TabRect.Left, TabRect.Bottom -2);
      FCanvas.Pen.Color := $3CC7FF;
      FCanvas.MoveTo (TabRect.Left + 1, TabRect.Top + 1);
      FCanvas.LineTo (TabRect.Left + 1, TabRect.Bottom - 1);
    end;
  end else begin
    //Draw tab vertical right shadow line
    ACanvas.Pen.Color := MakeDarkColor (ATabColor, 20);
    ACanvas.Brush.Color := ATabColor;
    ACanvas.MoveTo (TabRect.Right-2, TabRect.Top+2);
    ACanvas.LineTo (TabRect.Right-2, TabRect.Bottom-1);

    ACanvas.Pen.Color := MakeDarkColor (ATabColor, 10);
    ACanvas.MoveTo (TabRect.Right-3, TabRect.Top+4);
    ACanvas.LineTo (TabRect.Right-3, TabRect.Bottom-2);

    //Draw tab horizontal bottom shadow line
    ACanvas.Pen.Color := MakeDarkColor (ATabColor, 20);
    ACanvas.Brush.Color := ATabColor;
    ACanvas.MoveTo (TabRect.Left+2, TabRect.Bottom-2);
    ACanvas.LineTo (TabRect.Right-2, TabRect.Bottom-2);

    ACanvas.Pen.Color := MakeDarkColor (ATabColor, 10);
    ACanvas.MoveTo (TabRect.Left + 3, TabRect.Bottom - 3);
    ACanvas.LineTo (TabRect.Right-3, TabRect.Bottom-4);
  end;

  //Draw text and image
  DrawItemInside (AIndex, ACanvas, TabRect);
end;


procedure TxpPageControl.DrawRightTab (TabRect : TRect; ACanvas : TCanvas; AIndex, AVisibleIndex : Integer);
var
  AActiveTab : Boolean;
  ATabColor  : TColor;
begin
  Dec (TabRect.Bottom,2);
  AActiveTab := (SendMessage (Handle, TCM_GETCURSEL, 0, 0) = AVisibleIndex);
  ATabColor := (Self.Pages [AIndex] as TxpTabSheet).FColor;
  if AActiveTab then begin
    Inc (TabRect.Right, 2);
    Dec (TabRect.Top, 1);
    Inc (TabRect.Bottom, 1);
    ATabColor := MakeDarkColor (ATabColor, 10);
  end else begin
    Inc (TabRect.Left);
    ATabColor := MakeDarkColor (ATabColor, -30);
  end;
  Inc (TabRect.Bottom, 1);

  ACanvas.Brush.Color := ATabColor;
  ACanvas.Pen.Color := FBorderColor;
  ACanvas.Rectangle (TabRect.Left, TabRect.Top, TabRect.Right-6, TabRect.Bottom);
  ACanvas.RoundRect (TabRect.Right-8, TabRect.Top, TabRect.Right, TabRect.Bottom, 6, 6);
  ACanvas.FillRect (Rect (TabRect.Right-8, TabRect.Top + 1, TabRect.Right-3, TabRect.Bottom-1));

  if AActiveTab then begin

    if HotTrack then begin
      FCanvas.Pen.Color := $2C8BE6;
      FCanvas.MoveTo (TabRect.Right-2, TabRect.Top + 2);
      FCanvas.LineTo (TabRect.Right-2, TabRect.Bottom -2);
      FCanvas.Pen.Color := $3CC7FF;
      FCanvas.MoveTo (TabRect.Right-1, TabRect.Top + 1);
      FCanvas.LineTo (TabRect.Right-1, TabRect.Bottom - 1);
    end;
  end else begin
    //Draw tab vertical right shadow line
    ACanvas.Pen.Color := MakeDarkColor (ATabColor, 20);
    ACanvas.Brush.Color := ATabColor;
    ACanvas.MoveTo (TabRect.Right-2, TabRect.Top+2);
    ACanvas.LineTo (TabRect.Right-2, TabRect.Bottom-1);

    ACanvas.Pen.Color := MakeDarkColor (ATabColor, 10);
    ACanvas.MoveTo (TabRect.Right-3, TabRect.Top+4);
    ACanvas.LineTo (TabRect.Right-3, TabRect.Bottom-2);

    //Draw tab horizontal bottom shadow line
    ACanvas.Pen.Color := MakeDarkColor (ATabColor, 20);
    ACanvas.Brush.Color := ATabColor;
    ACanvas.MoveTo (TabRect.Left+2, TabRect.Bottom-2);
    ACanvas.LineTo (TabRect.Right-2, TabRect.Bottom-2);

    ACanvas.Pen.Color := MakeDarkColor (ATabColor, 10);
    ACanvas.MoveTo (TabRect.Left + 3, TabRect.Bottom - 3);
    ACanvas.LineTo (TabRect.Right-3, TabRect.Bottom-4);
  end;

  //Draw text and image
  DrawItemInside (AIndex, ACanvas, TabRect);
end;

procedure TxpPageControl.DrawBorder (ACanvas : TCanvas);
begin
//  ACanvas.Brush.Style := BSCLEAR;
  ACanvas.Brush.Style := bsSolid;
  ACanvas.Pen.Color := FBorderColor;
  ACanvas.Rectangle (FBorderRect.Left, FBorderRect.Top, FBorderRect.Right, FBorderRect.Bottom);
end;

procedure TxpPageControl.WMPaint (var Message : TWMPaint);
var
  DC : hDC;
  PS : TPaintStruct;
  ItemRect : TRect;
  I : Integer;
  Index : Integer;
begin
  if FStyle <> pcsXP then begin
    inherited;
    Exit;
  end;
  If Message.DC = 0 then DC := BeginPaint(Handle, PS) else DC := Message.DC;
  try
    FCanvas.Handle := DC;
    If oTabsShow then begin
      DrawBorder (FCanvas);
      If Self.PageCount > 0 then begin
        Index := 0;
        For I := 0 to Self.PageCount - 1 do begin
          if Pages [I].TabVisible then begin
            SendMessage (Handle, TCM_GETITEMRECT, Index, LongInt (@ItemRect));
            if (FOwnerDraw) and (Assigned (OnDrawItem)) then begin
              OnDrawItem (Self, I, ItemRect, []);
            end else begin
              Case TabPosition of
                tpTop: DrawTopTab (ItemRect, FCanvas, I, Index);
                tpBottom: DrawBottomTab (ItemRect, FCanvas, I, Index);
                tpLeft: DrawLeftTab (ItemRect, FCanvas, I, Index);
                tpRight: DrawRightTab (ItemRect, FCanvas, I, Index);
              end;
            end;
            Inc (Index);
          end;
        end;
      end;
    end;

  If oSelected then begin
    If cUniMultiSelect
      then FCanvas.Brush.Color := clSilver
      else begin
        FCanvas.Brush.Color := clBlack;
        FCanvas.FillRect(Rect((Width div 2)-2,0,(Width div 2)+3,5));
        FCanvas.FillRect(Rect((Width div 2)-2,Height-5,(Width div 2)+3,Height));
        FCanvas.FillRect(Rect(0,(Height div 2)-2,5,(Height div 2)+3));
        FCanvas.FillRect(Rect(Width-5,(Height div 2)-2,Width,(Height div 2)+3));
      end;

    FCanvas.FillRect(Rect(0,0,5,5));
    FCanvas.FillRect(Rect(0,Height-5,5,Height));
    FCanvas.FillRect(Rect(Width-5,0,Width,5));
    FCanvas.FillRect(Rect(Width-5,Height-5,Width,Height));
  end;
  finally
    if Message.DC = 0 then EndPaint(Handle, PS);
  end;
end;

procedure TxpPageControl.WMSIZE (var Message : TWMSIZE);
var
  ActivePage : Integer;
begin
  inherited;
  FBorderRect := Self.BoundsRect;
  OffsetRect (FBorderRect, -FBorderRect.Left, -FBorderRect.Top);
  SendMessage (Handle, TCM_ADJUSTRECT, 0, LongInt (@FBorderRect));
  InflateRect (FBorderRect, 1, 1);
  Inc (FBorderRect.Top);
end;

procedure TxpPageControl.CMDialogChar(var Message : TCMDialogChar);
begin
  If (KeyDataToShiftState(Message.KeyData) = [ssAlt]) then Inherited;
end;

procedure TxpPageControl.WMMouseMove (var Message : TWMMouseMove);
var
  HitTest : TTCHitTestInfo;
  AActiveTab : Integer;
begin
  if FStyle <> pcsXP then
  begin
    inherited;
    Exit;
  end;
  If not HotTrack then exit;

  HitTest.pt := Point (Message.XPos, Message.YPos);
  AActiveTab := SendMessage (Handle, TCM_HITTEST, 0, LongInt (@HitTest));
  if AActiveTab <> FHotTrackTab then
  begin
    if (FHotTrackTab <> SendMessage (Handle, TCM_GETCURSEL, 0, 0)) then
      DrawHotTrackTab (FHotTrackTab, False);

    FHotTrackTab := AActiveTab;

    if (FHotTrackTab <> -1) and (FHotTrackTab <> SendMessage (Handle, TCM_GETCURSEL, 0, 0)) then
      DrawHotTrackTab (FHotTrackTab, True);
  end;
end;


procedure TxpPageControl.MouseLeave (var Message : TMessage);
begin
  If HotTrack and (FHotTrackTab <> -1) and (FHotTrackTab <> SendMessage (Handle, TCM_GETCURSEL, 0, 0)) then
  begin
    DrawHotTrackTab (FHotTrackTab, False);
    FHotTrackTab := -1;
  end;
end;


procedure TxpPageControl.WMNCCalcSize (var Message : TWMNCCalcSize);
begin
  inherited;
end;

procedure TxpPageControl.CMHintShow(var Message: TMessage);
var
  Tab   : TxpTabsheet;
  ItemRect : TRect;
  HitTest : TTCHitTestInfo;
  AActiveTab : Integer;
  AWinActiveTab : Integer;
begin
  inherited;
  if TCMHintShow (Message).Result=1 then exit; // CanShow = false?

  with TCMHintShow(Message).HintInfo^ do
  begin
    if TControl(Self) <> HintControl then exit;

    HitTest.pt := Point (CursorPos.X, CursorPos.Y);
    AWinActiveTab := SendMessage (Handle, TCM_HITTEST, 0, LongInt (@HitTest));
    AActiveTab := WinIndexToPage (AWinActiveTab);
    Tab := nil;
    if (AActiveTab >= 0) and (AActiveTab < Self.PageCount) then
    begin
       Tab := (Self.Pages [AActiveTab] as TxpTabSheet);
       if not (Assigned(Tab) and (Tab.ShowTabHint) and (Tab.TabHint <> '')) then Exit;
    end
    else
      Exit;

     HintStr := GetShortHint(Tab.TabHint);
     SendMessage (Handle, TCM_GETITEMRECT, AWinActiveTab, LongInt (@ItemRect));
     CursorRect := ItemRect;
  end; //with
end;


function TxpPageControl.PageIndexToWin (AIndex : Integer) : Integer;
var
  I : Integer;
begin
  Result := -1;
  if (Self.PageCount <= 0) or (AIndex >= Self.PageCount) then Exit;
  if not Self.Pages[AIndex].TabVisible then Exit;
  For I := 0 to AIndex do
    if Self.Pages[I].TabVisible then Inc (Result);
end;


function TxpPageControl.WinIndexToPage (AIndex : Integer) : Integer;
var
  I : Integer;
begin
  Result := -1;
  if (Self.PageCount <= 0) or (AIndex >= Self.PageCount) then Exit;
  I := 0;
  Result := 0;
  While (I <= AIndex) and (Result < Self.PageCount) do
  begin
    if Self.Pages[Result].TabVisible then Inc (I);
    Inc (Result);
  end;
  Dec (Result);
end;


procedure TxpPageControl.Loaded;
begin
  inherited;
  SendMessage (Handle, WM_SIZE, 0, 0);
end;

procedure TxpPageControl.SetBorderColor (Value : TColor);
begin
  if FBorderColor <> Value then
  begin
    FBorderColor := Value;
    Invalidate;
  end;
end;

procedure TxpPageControl.SetTabPosition (Value : TxpTabPosition);
var
  Style : LongInt;
  OldSize : LongInt;
  Size : LongInt;
begin
  if FTabPosition <> Value then
  begin
    if (FStyle in [pcsButtons, pcsFlatButtons]) and (Value <> tpTop) then
      raise Exception.Create ('Tab position incompatible with current tab style');
    FTabPosition := Value;
    RecreateWnd;
    SendMessage (Handle, WM_SIZE, 0, 0);
    if (Self.PageCount > 0) and (ActivePage <> nil) then
      ActivePage.Invalidate;
  end;
end;

procedure TxpPageControl.SetTabTextAlignment (Value : TAlignment);
begin
  if Value <> FTabTextAlignment then
  begin
    FTabTextAlignment := Value;
    Invalidate;
  end;
end;


procedure TxpPageControl.SetStyle (Value : TxpPageControlStyle);
begin
  if FStyle <> Value then
  begin
    if (Value in [pcsButtons, pcsFlatButtons]) then TabPosition := tpTop;
    FStyle := Value;
    RecreateWnd;
    SendMessage (Handle, WM_SIZE, 0, 0);
    if (Self.PageCount > 0) and (ActivePage <> nil) then
      ActivePage.Invalidate;
  end;
end;

// TxpTabSheet
constructor TxpTabSheet.Create(AOwner: TComponent);
begin
  inherited;
  FImageIndex := -1;
  FShowTabHint := False;
  FTabHint := '';
  FCanvas := TControlCanvas.Create;
  FBGImage := TBitmap.Create;
  FBGStyle := bgsGradient;
  FGradientStartColor := clIccPageBGBeg;
  FGradientEndColor := clIccPageBGEnd;
  FGradientFillDir := fdBottomToTop;
  FColor := clWhite;
  Color := clWhite;
  FSystemColor := TRUE;
  oBasicColor := cbcBasicColor;
end;

destructor TxpTabSheet.Destroy;
begin
  try FCanvas.Free; except end;
  try FBGImage.Free; except end;
  inherited;
end;

procedure TxpTabSheet.SetBGImage (AValue : TBitmap);
begin
  FBGImage.Assign (AValue);
  Invalidate;
  if (FBGImage.Empty) and (FBGStyle in [bgsTileImage, bgsStrechImage]) then
    FBGStyle := bgsNone;
end;

procedure TxpTabSheet.SetBGStyle (AValue : TxpTabBGStyle);
begin
  if FBGStyle <> AValue then
  begin
    FBGStyle := AValue;
    Invalidate;
  end;
end;

procedure TxpTabSheet.SetColor (AValue : TColor);
begin
  if FColor <> AValue then
  begin
    FColor := AValue;
    Invalidate;
    if Assigned (PageControl) then
    try
      PageControl.Invalidate;
    except
    end;
  end;
end;

procedure TxpTabSheet.SetGradientStartColor (AValue : TColor);
begin
  if FGradientStartColor <> AValue then
  begin
    FGradientStartColor := AValue;
    Invalidate;
  end;
end;

procedure TxpTabSheet.SetGradientEndColor (AValue : TColor);
begin
  if FGradientEndColor <> AValue then
  begin
    FGradientEndColor := AValue;
    Invalidate;
  end;
end;

procedure TxpTabSheet.SetGradientFillDir (AValue : TFillDirection);
begin
  if FGradientFillDir <> AValue then
  begin
    FGradientFillDir := AValue;
    Invalidate;
  end;
end;

procedure TxpTabSheet.SetBasicColor (pAValue:TColor);
begin
  If not FSystemColor then begin
    FGradientStartColor := IccCompHueColor (pAValue, TclIccPageBGBeg);
    FGradientEndColor := IccCompHueColor (pAValue, TclIccPageBGEnd);
    FColor := IccCompHueColor (pAValue, TclIccPageTab);
    Color := IccCompHueColor (pAValue, TclIccPageTab);
  end;
end;

procedure TxpTabSheet.RefreshSystemColor;
begin
  FGradientStartColor := clIccPageBGBeg;
  FGradientEndColor := clIccPageBGEnd;
  FColor := clIccPageTab;
  Color := clIccPageTab;
end;

procedure TxpTabSheet.WMNCPaint (var Message : TWMNCPaint);
begin
  If FSystemColor then RefreshSystemColor;
  Brush.Color := FColor;
  inherited;
end;

procedure TxpTabSheet.WMPaint (var Message : TWMPaint);
begin
  If FSystemColor then RefreshSystemColor;
  Brush.Color := FColor;
  inherited;
end;

procedure TxpTabSheet.WMEraseBkgnd (var Message : TWMEraseBkgnd);
var
  DC : hDC;
  PS : TPaintStruct;
begin
  if Message.DC = 0 then DC := BeginPaint(Handle, PS) else DC := Message.DC;
  try
    FCanvas.Handle := DC;
    Brush.Color := FColor;
    case FBGStyle of
      bgsNone: begin
                 FCanvas.Brush.Color := FColor;
                 FCanvas.FillRect (ClientRect);
               end;
      bgsGradient:
               begin
                 GradientFillRect (FCanvas, ClientRect, FGradientStartColor, FGradientEndColor, FGradientFillDir, 60);
               end;
      bgsTileImage:
               if not FBGImage.Empty then
               begin
                 TileImage(FCanvas, ClientRect, FBGImage);
               end
               else
               begin
                 FCanvas.Brush.Color := FColor;
                 FCanvas.FillRect (ClientRect);
               end;
      bgsStrechImage:
               if not FBGImage.Empty then
               begin
                 FCanvas.StretchDraw (ClientRect, FBGImage);
               end
               else
               begin
                 FCanvas.Brush.Color := FColor;
                 FCanvas.FillRect (ClientRect);
               end;
    end;
  finally
    if Message.DC = 0 then EndPaint(Handle, PS);
  end;
  If oSelected then begin
    If cUniMultiSelect
      then FCanvas.Brush.Color := clSilver
      else begin
        FCanvas.Brush.Color := clBlack;
        FCanvas.FillRect(Rect((Width div 2)-2,0,(Width div 2)+3,5));
        FCanvas.FillRect(Rect((Width div 2)-2,Height-5,(Width div 2)+3,Height));
        FCanvas.FillRect(Rect(0,(Height div 2)-2,5,(Height div 2)+3));
        FCanvas.FillRect(Rect(Width-5,(Height div 2)-2,Width,(Height div 2)+3));
      end;

    FCanvas.FillRect(Rect(0,0,5,5));
    FCanvas.FillRect(Rect(0,Height-5,5,Height));
    FCanvas.FillRect(Rect(Width-5,0,Width,5));
    FCanvas.FillRect(Rect(Width-5,Height-5,Width,Height));
  end;
end;

procedure TxpTabSheet.SetImageIndex (AIndex : Integer);
var
  Item : TTCItem;
begin
  if AIndex < -1 then AIndex := -1;
  if (FImageIndex <> AIndex) and Assigned (PageControl) then
  begin
    FImageIndex := AIndex;
    Item.iImage := FImageIndex;
    Item.mask := TCIF_IMAGE;
    SendMessage (PageControl.Handle, TCM_SETITEM, PageIndex, LongInt (@Item));
  end;
end;

//TFixMinPanel
constructor TFixMinPanel.Create(AOwner: TComponent);
begin
  inherited;
  BevelInner:=bvNone;
  BevelKind:=bkNone;
  BevelOuter:=bvNone;
  BorderStyle:=bsNone;
  oMinWidth:=0;
  oMinHeight:=0;
  oPanel:=TPanel.Create(Self);
  oPanel.Parent:=Self;
  oPanel.ControlStyle :=oPanel. ControlStyle - [csAcceptsControls] + [csNoDesignVisible];
  oPanel.BorderStyle:=bsNone;
  oPanel.BevelInner:=bvNone;
  oPanel.BevelOuter:=bvNone;
  OnResize:=MyOnResize;
end;

destructor  TFixMinPanel.Destroy;
begin
  FreeAndNil(oPanel);
  inherited;
end;

procedure TFixMinPanel.MyOnResize (Sender: TObject);
var mWidth, mHeight:longint;
begin
  mWidth:=ClientWidth;
  mHeight:=ClientHeight;
  If (oMinWidth>0) and (ClientWidth<oMinWidth)then mWidth:=oMinWidth;
  If (oMinHeight>0) and (ClientHeight<oMinHeight) then mHeight:=oMinHeight;
  oPanel.Width:=mWidth;
  oPanel.Height:=mHeight;
end;

procedure TFixMinPanel.SetMinWidth(pValue:longint);
begin
  oMinWidth:=pValue;
  MyOnResize(nil);
end;

procedure TFixMinPanel.SetMinHeight(pValue:longint);
begin
  oMinHeight:=pValue;
  MyOnResize(nil);
end;


// TxpSinglePanel
constructor TxpSinglePanel.Create(AOwner: TComponent);
begin
  inherited Create (AOwner);
  FSystemColor := TRUE;
  oBasicColor := cbcBasicColor;
  oGradEndColor := cbcBasicColor;
  oGradStartColor := cbcBasicColor;
  Width := 180;
  Height := 60;
  Color := clIccPanelBG;
  FBorderColor := clIccInactBorder;
  Caption := ' ';
  BorderStyle := bsNone;
  BevelOuter := bvNone;
  ParentColor := FALSE;
  oBGStyle := bgsNone;
  oGradFillDir := fdXP;
  oBGImage := TBitmap.Create;
  OnResize := MyOnResize;
end;


destructor  TxpSinglePanel.Destroy;
begin
  If Assigned (oBGImage) then FreeAndNil (oBGImage);
  inherited;
end;

procedure TxpSinglePanel.WMPaint (var Message : TWMPaint);
var mClientRect:TRect;
begin
  inherited;
  If FSystemColor then RefreshSystemColor;
  Canvas.Brush.Style := bsSolid;
  If oHead<>'' then begin
    Canvas.Font := Font;
    Canvas.Brush.Color := FBorderColor;
    Canvas.FillRect(Rect (0,0,Width,Canvas.TextHeight(oHead)+6));
    Canvas.TextOut((Width-Canvas.TextWidth(oHead)) div 2,3,oHead);
  end;
//??  Canvas.Brush.Style := BSCLEAR;
  Canvas.Brush.Style := bsSolid;
  Canvas.Pen.Color := FBorderColor;
  Canvas.Pen.Width := 1;
  Canvas.MoveTo(0,0);
  Canvas.LineTo(Width-1,0);
  Canvas.LineTo(Width-1,Height-1);
  Canvas.LineTo(0,Height-1);
  Canvas.LineTo(0,0);

  If oSelected then begin
    If cUniMultiSelect
      then Canvas.Brush.Color := clSilver
      else begin
        Canvas.Brush.Color := clBlack;
        Canvas.FillRect(Rect((Width div 2)-2,0,(Width div 2)+3,5));
        Canvas.FillRect(Rect((Width div 2)-2,Height-5,(Width div 2)+3,Height));
        Canvas.FillRect(Rect(0,(Height div 2)-2,5,(Height div 2)+3));
        Canvas.FillRect(Rect(Width-5,(Height div 2)-2,Width,(Height div 2)+3));
      end;

    Canvas.FillRect(Rect(0,0,5,5));
    Canvas.FillRect(Rect(0,Height-5,5,Height));
    Canvas.FillRect(Rect(Width-5,0,Width,5));
    Canvas.FillRect(Rect(Width-5,Height-5,Width,Height));
  end;
end;

procedure TxpSinglePanel.Paint;
var mClientRect:TRect;
begin
  If FSystemColor then RefreshSystemColor;
  If oHead<>'' then begin
    Canvas.Font := Font;
    mClientRect := Rect(1,Canvas.TextHeight(oHead)+6,Width-1,Height-1)
  end else mClientRect := Rect(1,1,Width-1,Height-1);
  case oBGStyle of
    bgsNone: begin
      Canvas.Brush.Color := Color;
      Canvas.FillRect (mClientRect);
    end;
    bgsGradient: GradientFillRect (Canvas, mClientRect, oGradStartColor, oGradEndColor, oGradFillDir, 60);
    bgsTileImage: begin
      If not oBGImage.Empty
        then TileImage(Canvas, mClientRect, BGImage)
        else begin
          Canvas.Brush.Color := Color;
          Canvas.FillRect (mClientRect);
        end;
    end;
    bgsStrechImage: begin
      If not BGImage.Empty
        then Canvas.StretchDraw (mClientRect, BGImage)
        else begin
          Canvas.Brush.Color := Color;
          Canvas.FillRect (mClientRect);
        end;
    end;
  end;
end;

procedure TxpSinglePanel.RefreshSystemColor;
begin
  Color := clIccPanelBG;
  FBorderColor := clIccInactBorder;
  Font.Color := clIccButtonFont;
  oGradEndColor := clIccPanelBG;
  oGradStartColor := clIccPanelBG;
end;

procedure TxpSinglePanel.SetBorderColor (AValue:TColor);
begin
  If AValue<>FBorderColor then begin
    FBorderColor := AValue;
    Repaint;
  end;
end;

procedure TxpSinglePanel.SetSystemColor (AValue:boolean);
begin
  FSystemColor := AValue;
  Repaint;
end;

procedure TxpSinglePanel.SetHead (pHead:string);
begin
  oHead := pHead;
  Repaint;
end;

procedure TxpSinglePanel.SetBasicColor (pValue:TColor);
begin
  If not FSystemColor then begin
    oBasicColor := pValue;
    Color := IccCompHueColor (oBasicColor, TclIccPanelBG);
    oGradEndColor := Color;
    oGradStartColor := Color;
    FBorderColor := IccCompHueColor (oBasicColor, TclIccInactBorder);
    Font.Color := IccCompHueColor (oBasicColor, TclIccButtonFont);
  end;
end;

procedure TxpSinglePanel.SetGradEndColor (pValue:TColor);
begin
  oGradEndColor := pValue;
  Repaint;
end;

procedure TxpSinglePanel.SetGradStartColor (pValue:TColor);
begin
  oGradStartColor := pValue;
  Repaint;
end;

procedure TxpSinglePanel.SetGradFillDir (pValue:TFillDirection);
begin
  oGradFillDir := pValue;
  Repaint;
end;

procedure TxpSinglePanel.SetBGImage (pValue:TBitmap);
begin
  If not oBGImage.Empty then begin
    try
      oBGImage.FreeImage;
    except end;
  end;
  oBGImage.Assign (pValue);
  Repaint;
end;

procedure TxpSinglePanel.SetBGStyle (pValue:TxpTabBGStyle);
begin
  oBGStyle := pValue;
  Repaint;
end;

procedure TxpSinglePanel.MyOnResize (Sender: TObject);
begin
  Repaint;
end;

// TxpPanel
constructor TxpPanel.Create(AOwner: TComponent);
begin
  inherited Create (AOwner);

  FGradientFill := TRUE;
  FStartColor := clIccPanelBGBeg;
  FEndColor := clIccPanelBGEnd;
  FFillDirection := fdLeftToRight;
  FShadow := true;
  FShadowDist := 5;
  FSystemColor := TRUE;

  Width := 180;
  Height := 60;

  Color := clIccPanelBG;

  FShowHeader := True;
  FCaption := 'xpPanel';
  FDefaultHeight := 60;

  FTitle := 'xpPanelTitle';
  FTitleHeight := 30;
  FTitleAlignment := taCenter;
  FTitleShadowOnMouseEnter := true;
  FTitleGradient := true;
  FTitleStartColor := clIccPanelTitleBeg;
  FTitleEndColor := clIccPanelTitleEnd;
  FTitleColor := clIccPanelTitleBeg;
  FTitleFillDirect := fdLeftToRight;

  FTitleImage := TBitmap.Create;
  FTitleCursor := crSystemHand;
  FTitleImageTransparent := true;
  FTitleImageAlign := tiaLeft;

  FTitleFont := TFont.Create;
  FTitleFont.Style := [fsBold];
  FTitleFont.Color := clIccPanelTitleFont;
  FTitleFont.OnChange := OnTitleFontChange;
  TitleButtons := [tbMinimize];

  FMouseOnHeader := False;

  FBorderSize := 1;
  FShowBorder := True;
  FBorderColor := clIccPanelBorder;
  FRoundedCorner := [rcTopLeft, rcTopRight];

  FBGImage := TBitmap.Create;
  FBGImageAlign := iaStretch;
  FBGImageTransparent := TRUE;

  FOnTitleClick := nil;
  FOnTitleDblClick := nil;
  FOnTitleMouseDown := nil;
  FOnTitleMouseUp := nil;
  FOnTitleMouseEnter := nil;
  FOnTitleMouseExit := nil;
  FOnMouseEnter := nil;
  FOnMouseExit := nil;

  FAfterMinimized   := nil;
  FAfterMaximized   := nil;
  FBeforeMoving     := nil;
  FAfterMoving      := nil;
  FAfterClose       := nil;

  BorderStyle := bsNone;

  FMovable := False;
  FSizable := False;
  FMinimized := False;
  FAnimation := True;

  FMinimizing := False;
  //FullRepaint := False;
end;

destructor  TxpPanel.Destroy;
begin
  try FTitleFont.Free; except end;
  try FBGImage.Free; except end;
  try FTitleImage.Free; except end;
  inherited;
end;

procedure TxpPanel.DrawTitle (ACanvas : TCanvas; ATitleRect : TRect);
var
  X, Y : Integer;
  AGrayImage : TBitmap;
  ATextFormat : Integer;
  ATextRect : TRect;
  ABtnOffset : Integer;
begin
  if FTitleGradient then
    GradientFillRect (ACanvas, ATitleRect, FTitleStartColor, FTitleEndColor, FTitleFillDirect, 50)
  else
  begin
    ACanvas.Brush.Style := bsSolid;
    ACanvas.Brush.Color := FTitleColor;
    ACanvas.FillRect (ATitleRect);
  end;

  ATextRect := ATitleRect;

  InflateRect (ATextRect, -2, -2);

  ABtnOffset := ATextRect.Right;

  if tbMinimize in FTitleButtons then ABtnOffset := FMinBtnRect.Left - 4 else
    if tbMaximize in FTitleButtons then ABtnOffset := FMaxBtnRect.Left - 4 else
      if tbClose in FTitleButtons then ABtnOffset := FCloseBtnRect.Left - 4;

  if not FTitleImage.Empty then
  begin
    FTitleImage.TransparentMode := tmAuto;
    FTitleImage.Transparent := False;

    if (FTitleImageAlign in [tiaLeft, tiaRight, tiaCenter]) then
    begin
      case FTitleImageAlign of
        tiaLeft:
        begin
          X := 2;
          Y := (ATitleRect.Bottom + ATitleRect.Top - FTitleImage.Height) div 2;
          ATextRect.Left := ATextRect.Left + FTitleImage.Width + 8;
        end;
        tiaRight:
        begin
          X := ABtnOffset - FTitleImage.Width;
          Y := (ATitleRect.Bottom + ATitleRect.Top - FTitleImage.Height) div 2;
          ABtnOffset := X - 4;
        end;
        tiaCenter:
        begin
          X := (ATitleRect.Right + ATitleRect.Left - FTitleImage.Width) div 2;
          Y := (ATitleRect.Bottom + ATitleRect.Top - FTitleImage.Height) div 2;
        end;
      end;
      //Image Shadow
      if FMouseOnHeader then
      begin
        AGrayImage := TBitmap.Create;
        try
          AGrayImage.Assign (FTitleImage);
          AGrayImage.TransparentMode := tmAuto;
          AGrayImage.Transparent := true;
          ConvertBitmapToGrayscale (AGrayImage);
          if FTitleImageTransparent then
            DrawBitmapTransparent (ACanvas, X, Y, AGrayImage, AGrayImage.Canvas.Pixels [0,0])
          else
            ACanvas.Draw (X, Y, AGrayImage);
        finally
          AGrayImage.Free;
        end;
      end;
      //Image
      if FTitleImageTransparent then
        DrawBitmapTransparent (ACanvas, X - Integer (FMouseOnHeader), Y - Integer (FMouseOnHeader),
          FTitleImage, FTitleImage.Canvas.Pixels [0,0])
      else
        ACanvas.Draw (X - Integer (FMouseOnHeader),  Y - Integer (FMouseOnHeader), FTitleImage);
    end else begin
      FTitleImage.TransparentMode := tmAuto;
      FTitleImage.Transparent := FTitleImageTransparent;
      case FTitleImageAlign of
        tiaStretch:
          ACanvas.StretchDraw (ATitleRect, FTitleImage);
        tiaTile:
          TileImage (ACanvas, ATitleRect, FTitleImage);
      end;
    end;

  end;

  if FTitle <> '' then
  begin
    ATextRect.Right := ABtnOffset;

    ATextFormat := DT_VCENTER or DT_END_ELLIPSIS or DT_SINGLELINE;
    ACanvas.Font.Assign (FTitleFont);
    case FTitleAlignment of
      taLeftJustify: ATextFormat := ATextFormat or DT_LEFT;
      taRightJustify: ATextFormat := ATextFormat or DT_RIGHT;
      taCenter: ATextFormat := ATextFormat or DT_CENTER;
    end;
    ACanvas.Brush.Style := bsClear;

    //Shadow
    ACanvas.Font.Color := clIccPanelTitleFontSh;
    DrawText (ACanvas.Handle, PChar (FTitle), Length(FTitle), ATextRect, ATextFormat);

    //Text
    ACanvas.Font.Assign (FTitleFont);
    OffsetRect (ATextRect, -1, -1);
    if FMouseOnHeader then OffsetRect (ATextRect, -1, -1);
    DrawText (ACanvas.Handle, PChar (FTitle), Length(FTitle), ATextRect, ATextFormat);
  end;
end;


procedure TxpPanel.DrawAllTitleButtons (ACanvas : TCanvas; ATitleRect : TRect);
const
  XOffset : Integer = 22;
var
  AButtonRect : TRect;
begin
  if FTitleButtons = [] then Exit;

  AButtonRect.Left := ATitleRect.Right - cTitleButtonSize - 5 + XOffset;
  AButtonRect.Right := ATitleRect.Right - 5 + XOffset;
  AButtonRect.Top := (ATitleRect.Bottom + ATitleRect.Top) div 2 - (cTitleButtonSize div 2)+1;
  AButtonRect.Bottom := (ATitleRect.Bottom + ATitleRect.Top) div 2 + (cTitleButtonSize div 2);

  if tbClose in FTitleButtons then begin
    AButtonRect.Left := AButtonRect.Left - XOffset;
    AButtonRect.Right := AButtonRect.Right- XOffset;
    FCloseBtnRect := AButtonRect;
    DrawTitleButton (ACanvas, AButtonRect, tbClose);
  end;

  if tbMaximize in FTitleButtons then begin
    AButtonRect.Left := AButtonRect.Left - XOffset;
    AButtonRect.Right := AButtonRect.Right- XOffset;
    FMaxBtnRect := AButtonRect;
    DrawTitleButton (ACanvas, AButtonRect, tbMaximize);
  end;

  if tbMinimize in FTitleButtons then begin
    AButtonRect.Left := AButtonRect.Left - XOffset;
    AButtonRect.Right := AButtonRect.Right- XOffset;
    FMinBtnRect := AButtonRect;
    DrawTitleButton (ACanvas, AButtonRect, tbMinimize);
  end;
end;

procedure TxpPanel.DrawTitleButton (ACanvas : TCanvas; AButtonRect : TRect; ABtnType : TTitleButton);
var
  XCenter, YCenter, Radius : Integer;
begin
  ACanvas.Pen.Color := clIccPanelCircle;
  ACanvas.Pen.Width := 1;
  ACanvas.Brush.Color := clIccPanelCircle;
  ACanvas.Ellipse (AButtonRect.Left-1, AButtonRect.Top-1, AButtonRect.Right+1, AButtonRect.Bottom+1);
  ACanvas.Brush.Color := clWhite;
  ACanvas.Ellipse (AButtonRect.Left, AButtonRect.Top, AButtonRect.Right, AButtonRect.Bottom);

  XCenter := (AButtonRect.Right + AButtonRect.Left) div 2;
  YCenter := (AButtonRect.Bottom + AButtonRect.Top) div 2;

  if XCenter < YCenter then
    Radius := (XCenter - AButtonRect.Left)-4
  else
    Radius := (YCenter - AButtonRect.Top)-4;

  ACanvas.Pen.Width := 2;

  if FMouseOnHeader and FShowHeader then
    ACanvas.Pen.Color := clIccPanelArrowAct
  else
    ACanvas.Pen.Color := clIccPanelArrowInact;

  case ABtnType of
    tbClose:
      begin
          ACanvas.Polyline ([Point (XCenter - Radius + 2, YCenter - Radius + 2),
                       Point (XCenter + Radius - 2, YCenter + Radius - 2)    ]);

          ACanvas.Polyline ([Point (XCenter + Radius - 2, YCenter - Radius + 2),
                       Point (XCenter - Radius + 2, YCenter + Radius - 2)    ]);
      end;
    tbMaximize:
      begin
        ACanvas.Pen.Width := 1;
        if FMaximized then begin
          ACanvas.Rectangle (XCenter - Radius + 1, YCenter - Radius + 1,
                             XCenter + Radius-1, YCenter + Radius-2);
          ACanvas.Rectangle (XCenter - Radius + 3, YCenter - Radius + 3,
                             XCenter + Radius+1, YCenter + Radius);
        end else begin
          ACanvas.Rectangle (XCenter - Radius + 1, YCenter - Radius + 1,
                             XCenter + Radius, YCenter + Radius);
          ACanvas.Rectangle (XCenter - Radius + 1, YCenter - Radius + 2,
                             XCenter + Radius, YCenter + Radius);
        end;
      end;
    tbMinimize:
      begin
        if FMinimized then begin
          //Drawing down arrows
          ACanvas.Polyline ([Point (XCenter - Radius + 2, YCenter - Radius + 1),
                       Point (XCenter, YCenter-1),
                       Point (XCenter + Radius - 2, YCenter - Radius + 1)    ]);

          ACanvas.Polyline ([Point (XCenter - Radius + 2, YCenter+1),
                       Point (XCenter, YCenter + Radius - 1),
                       Point (XCenter + Radius - 2, YCenter+1)    ]);
        end else begin
          //Drawing up arrows
          ACanvas.Polyline ([Point (XCenter - Radius + 2, YCenter - 1),
                       Point (XCenter, YCenter - Radius + 1),
                       Point (XCenter + Radius - 2, YCenter - 1)    ]);

          ACanvas.Polyline ([Point (XCenter - Radius + 2, YCenter + Radius - 1),
                       Point (XCenter, YCenter+1),
                       Point (XCenter + Radius - 2, YCenter + Radius - 1)    ]);
        end;
    end;
  end;
end;




procedure TxpPanel.DrawBorder (ACanvas : TCanvas; ARect : TRect; AClient : Boolean);
var
  ARoundedCorner : TRoundedCorners;
begin
  ACanvas.Brush.Style := BSCLEAR;
  ACanvas.Pen.Color := FBorderColor;
  ACanvas.Pen.Width := FBorderSize;

  ACanvas.Rectangle (ARect.Left, ARect.Top, ARect.Right, ARect.Bottom);

  if FRoundedCorner = [] then Exit;

  ARoundedCorner := FRoundedCorner;

  if AClient then ARoundedCorner := ARoundedCorner - [rcTopLeft, rcTopRight];

  if (rcTopLeft in ARoundedCorner) and (rcTopRight in ARoundedCorner) and
      (rcBottomLeft in ARoundedCorner) and (rcBottomRight in ARoundedCorner) then begin
    ACanvas.RoundRect (ARect.Left, ARect.Top, ARect.Right, ARect.Bottom, cCornerRadius, cCornerRadius);
    ARoundedCorner := [];
  end
  else
  if (rcTopLeft in ARoundedCorner) and (rcTopRight in ARoundedCorner) then begin
    ACanvas.RoundRect (ARect.Left, ARect.Top, ARect.Right, ARect.Bottom + cCornerRadius*2, cCornerRadius, cCornerRadius);
    ARoundedCorner := ARoundedCorner - [rcTopLeft, rcTopRight];
  end
  else
  if (rcBottomLeft in ARoundedCorner) and (rcBottomRight in ARoundedCorner) then begin
    ACanvas.RoundRect (ARect.Left, ARect.Top - cCornerRadius*2, ARect.Right, ARect.Bottom, cCornerRadius, cCornerRadius);
    ARoundedCorner := ARoundedCorner - [rcBottomLeft, rcBottomRight];
  end
  else
  if (rcTopLeft in ARoundedCorner) and (rcBottomLeft in ARoundedCorner) then begin
    ACanvas.RoundRect (ARect.Left, ARect.Top, ARect.Right + cCornerRadius*2, ARect.Bottom, cCornerRadius, cCornerRadius);
    ARoundedCorner := ARoundedCorner - [rcTopLeft, rcBottomLeft];
  end
  else
  if (rcTopRight in ARoundedCorner) and (rcBottomRight in ARoundedCorner) then begin
    ACanvas.RoundRect (ARect.Left - cCornerRadius*2, ARect.Top, ARect.Right, ARect.Bottom, cCornerRadius, cCornerRadius);
    ARoundedCorner := ARoundedCorner - [rcTopRight, rcBottomRight];
  end;

  if ARoundedCorner = [] then Exit;

  if (rcTopLeft in ARoundedCorner) then
    ACanvas.RoundRect (ARect.Left, ARect.Top, ARect.Right + cCornerRadius*2, ARect.Bottom + cCornerRadius*2, cCornerRadius, cCornerRadius);
  if (rcTopRight in ARoundedCorner) then
    ACanvas.RoundRect (ARect.Left - cCornerRadius*2, ARect.Top, ARect.Right, ARect.Bottom + cCornerRadius*2, cCornerRadius, cCornerRadius);
  if (rcBottomLeft in ARoundedCorner) then
    ACanvas.RoundRect (ARect.Left, ARect.Top - cCornerRadius*2, ARect.Right + cCornerRadius*2, ARect.Bottom, cCornerRadius, cCornerRadius);
  if (rcBottomRight in ARoundedCorner) then
    ACanvas.RoundRect (ARect.Left - cCornerRadius*2, ARect.Top - cCornerRadius*2, ARect.Right, ARect.Bottom, cCornerRadius, cCornerRadius);
end;

procedure TxpPanel.DrawBGImage (ACanvas : TCanvas);
begin
  FBGImage.TransparentMode := tmAuto;
  FBGImage.Transparent := FBGImageTransparent;
  case FBGImageAlign of
    iaStretch:
      begin
        ACanvas.StretchDraw (ClientRect, FBGImage);
      end;
    iaCenter:
      begin
        ACanvas.Draw (
          (ClientWidth - FBGImage.Width) div 2,
          (ClientHeight - FBGImage.Height) div 2,
          FBGImage);
      end;
    iaTile:
      begin
        TileImage (ACanvas, ClientRect, FBGImage);
      end;
  end;
end;


//Draw client area

procedure TxpPanel.Paint;
var
  TempCanvas : TBitmap;
  WinRect : TRect;
begin
  TempCanvas := TBitmap.Create;
  try
    TempCanvas.Width := ClientWidth;
    TempCanvas.Height := ClientHeight;
    if FGradientFill then begin
      GradientFillRect (TempCanvas.Canvas, ClientRect, FStartColor, FEndColor, FFillDirection, 60);
    end else begin
      TempCanvas.Canvas.Brush.Style := bsSolid;
      TempCanvas.Canvas.Brush.Color := Color;
      TempCanvas.Canvas.FillRect (ClientRect);
    end;

    if not FBGImage.Empty then DrawBGImage (TempCanvas.Canvas);

    BitBlt(Canvas.Handle, 0, 0, TempCanvas.Width, TempCanvas.Height,
      TempCanvas.Canvas.Handle, 0, 0, SRCCOPY);

    if FShowBorder then begin
      SendMessage (Handle, WM_NCPAINT, wmNCPaintOnlyBorder, 0);
      //SendMessage (Handle, WM_NCPAINT, 0, 0);
    end;

  finally
    TempCanvas.Free;
  end;
end;

//Calculate nonclient area
procedure TxpPanel.WMNCCalcSize (var Message : TWMNCCalcSize);
begin
  if FShowBorder then begin
    InflateRect (Message.CalcSize_Params^.rgrc[0], -FBorderSize, -FBorderSize);
    if FShowHeader then
      Inc (Message.CalcSize_Params^.rgrc[0].Top, FTitleHeight);
  end else begin
    if FShowHeader then
      Inc (Message.CalcSize_Params^.rgrc[0].Top, FTitleHeight+1);
  end;

  inherited;
end;

procedure TxpPanel.WMNCACTIVATE (var Message : TWMNCActivate);
begin
  inherited;
end;


procedure TxpPanel.NCHitTest (var Message : TWMNCHitTest);
var
  WinRect : TRect;
  ClientPoint : TPoint;
  PanelPoint : TPoint;
  ABottom : Integer;
  ATitleHeight : Integer;
  ABorderSize : Integer;
begin
  inherited;
  Message.Result := HTCLIENT;

  GetWindowRect (Handle, WinRect);
  ABottom := WinRect.Bottom;

  if FShowHeader then ATitleHeight := FTitleHeight else ATitleHeight := 0;

  if FShowBorder then
  begin
    ABorderSize := FBorderSize;
    if ABorderSize < 5 then ABorderSize := 5;
  end else ABorderSize := 0;

  WinRect.Bottom := WinRect.Top + ATitleHeight;

  ClientPoint := Point (Message.XPos, Message.YPos);

  PanelPoint := ScreenToClient (ClientPoint);

  if PtInRect (WinRect, Point (Message.XPos, Message.YPos)) then
    Message.Result := HTOBJECT;

  if FTitleShadowOnMouseEnter then begin
    if (not FMouseOnHeader) and ((PtInRect (WinRect, Point (Message.XPos, Message.YPos)))) then
    begin
      FMouseOnHeader := true;
      SendMessage (Handle, WM_NCPAINT, 0, 0);

      if Assigned (FOnTitleMouseEnter) then FOnTitleMouseEnter (self);
    end
    else
    if (not ((PtInRect (WinRect, Point (Message.XPos, Message.YPos))))) and (FMouseOnHeader) then begin
      FMouseOnHeader := False;
      SendMessage (Handle, WM_NCPAINT, 0, 0);
      if Assigned (FOnTitleMouseExit) then FOnTitleMouseExit (self);
    end;
  end;

  Inc (PanelPoint.y, FTitleHeight);

  if tbClose in FTitleButtons then begin
    if PtInRect (FCloseBtnRect, PanelPoint) then
      Message.Result := HTCLOSE;
  end;

  if tbMaximize in FTitleButtons then begin
    if PtInRect (FMaxBtnRect, PanelPoint) then
      Message.Result := HTMAXBUTTON;
  end;

  if tbMinimize in FTitleButtons then begin
    if PtInRect (FMinBtnRect, PanelPoint) then
      Message.Result := HTMINBUTTON;
  end;

  if (csDesigning in ComponentState) then Exit;

  WinRect.Bottom := ABottom;
  if FSizable and not FMinimized and not Maximized then
  begin
    if PtInRect (Rect (WinRect.Left, WinRect.Top, WinRect.Left + ABorderSize+5, WinRect.Top + ABorderSize + 5), ClientPoint) then
      Message.Result := HTTOPLEFT
    else
    //Check mouse on TopRight border
    if PtInRect (Rect (WinRect.Right - 5, WinRect.Top, WinRect.Right+1, WinRect.Top + 5), ClientPoint) then
      Message.Result := HTTOPRIGHT
    //Check mouse on BottomLeft border
    else
    if PtInRect (Rect (WinRect.Left, WinRect.Bottom - ABorderSize-5, WinRect.Left+5, WinRect.Bottom), ClientPoint) then
      Message.Result := HTBOTTOMLEFT
    //Check mouse on BottomRight border
    else
    if PtInRect (Rect (WinRect.Right-5, WinRect.Bottom - ABorderSize-5, WinRect.Right, WinRect.Bottom), ClientPoint) then
      Message.Result := HTBOTTOMRIGHT
    else
    //Check mouse on Left border
    if PtInRect (Rect (WinRect.Left, WinRect.Top + 5, WinRect.Left + ABorderSize, WinRect.Right - ABorderSize), ClientPoint) then
      Message.Result := HTLEFT
    else
    //Check mouse on Right border
    if PtInRect (Rect (WinRect.Right - ABorderSize, WinRect.Top + 5, WinRect.Right+1, WinRect.Bottom - 5), ClientPoint) then
      Message.Result := HTRIGHT
    else
    //Check mouse on Top border
    if PtInRect (Rect (WinRect.Left+5, WinRect.Top, WinRect.Right-5, WinRect.Top + ABorderSize), ClientPoint) then
      Message.Result := HTTOP
    //Check mouse on Bottom border
    else
    if PtInRect (Rect (WinRect.Left+5, WinRect.Bottom - ABorderSize, WinRect.Right-5, WinRect.Bottom), ClientPoint) then
      Message.Result := HTBOTTOM;
  end;


  if FMovable and PtInRect (WinRect, ClientPoint) and
     not (Message.Result in [HTCLOSE, HTMINBUTTON, HTMAXBUTTON]) then
  begin
    WinRect.Bottom := WinRect.Top + ATitleHeight;
    InflateRect (WinRect, -ABorderSize, -ABorderSize);
    if PtInRect (WinRect, ClientPoint) then Message.Result := HTCAPTION;
  end;

end;


//Draw nonclient area
procedure TxpPanel.WMNCPaint(var Message : TWMNCPaint);
var
  UpdateRect : TRect;
  HeaderRect : TRect;
  DC : hDC;
  NCCanvas : TCanvas;
  TempCanvas : TBitmap;
begin
  If FSystemColor then RefreshSystemColor;
  DC := GetWindowDC (Handle);
  NCCanvas := TCanvas.Create;
  try
    NCCanvas.Handle := DC;
    GetWindowRect (Handle, UpdateRect);

    OffsetRect (UpdateRect, - UpdateRect.Left, - UpdateRect.Top);

    HeaderRect := UpdateRect;
    HeaderRect.Bottom := FTitleHeight + FBorderSize;

    if FShowBorder then begin
      HeaderRect.Bottom := FTitleHeight + FBorderSize;
      InflateRect (HeaderRect, -FBorderSize, 0);
    end;

    if (FShowHeader) and (Message.Unused <> wmNCPaintOnlyBorder) then begin
      TempCanvas := TBitmap.Create;
      try
        //Title Drawing
        TempCanvas.Width := HeaderRect.Right - HeaderRect.Left;
        TempCanvas.Height := HeaderRect.Bottom - HeaderRect.Top;
        DrawTitle (TempCanvas.Canvas, HeaderRect);

        //Title Butons Drawing
        DrawAllTitleButtons (TempCanvas.Canvas, HeaderRect);

        BitBlt(DC, HeaderRect.Left, HeaderRect.Top, TempCanvas.Width, TempCanvas.Height,
          TempCanvas.Canvas.Handle, 0, 0, SRCCOPY);
      finally
        TempCanvas.Free;
      end;
    end;

    if FShowBorder then begin
      //DrawBorder (NCCanvas, UpdateRect, (Message.Unused[0] = wmNCPaintOnlyBorder));
      DrawBorder (NCCanvas, UpdateRect, False);
    end;


  finally
    NCCanvas.Free;
    ReleaseDC (Handle, DC);
  end;
  Message.Result := 0;

  inherited;
end;

procedure TxpPanel.WMSize (var Message : TMessage);
begin
  FullRepaint := (FGradientFill and FBGImage.Empty) or
    ((not FBGImage.Empty) and (FBGImageAlign <> iaTile )) or
    (FGradientFill and (not FBGImage.Empty) and (FBGImageAlign <> iaTile)) ;
  SetShape (FRoundedCorner);
  inherited;
end;


procedure TxpPanel.SetShape (ARounded : TRoundedCorners);
var
  WinRgn : hRgn;
  WinRgn1 : hRgn;
  ShadowRgn : hRgn;
  Rectn : TRect;
  RTop, RBottom : Integer;
  AWidth, AHeight : Integer;
begin
  WinRgn := 0;
  GetWindowRect (Handle, Rectn);
  OffsetRect (Rectn, -Rectn.Left, -Rectn.Top);

  //Delete old window region
  GetWindowRgn (Handle, WinRgn);
  DeleteObject(WinRgn);

  AWidth := Width;
  AHeight := Height;

  {if FShadow then
  begin
    Dec (AWidth, FShadowDist);
    Dec (AHeight, FShadowDist);
  end;}

  if ARounded <> [] then
  begin
    RTop := 0;
    RBottom := AHeight;
    if (rcTopLeft in ARounded) or (rcTopRight in ARounded) then RTop := cCornerRadius div 2;
    if (rcBottomLeft in ARounded) or (rcBottomRight in ARounded) then RBottom := AHeight - cCornerRadius div 2;

    WinRgn := CreateRectRgn (0, RTop, AWidth, RBottom);

    //Create topleft rounded corner
    if  rcTopLeft in ARounded then begin
      WinRgn1 := CreateRectRgn (cCornerRadius div 2, cCornerRadius div 2, cCornerRadius, cCornerRadius);
      CombineRgn (WinRgn1, WinRgn1, CreateEllipticRgn (0,0,cCornerRadius+1,cCornerRadius+1), RGN_OR);
      CombineRgn (WinRgn, WinRgn, WinRgn1, RGN_OR);
      DeleteObject(WinRgn1);

      //Create result region
      if rcTopRight in ARounded then
        CombineRgn (WinRgn, WinRgn, CreateRectRgn (cCornerRadius div 2, 0, AWidth - cCornerRadius div 2, cCornerRadius), RGN_OR)
      else
        CombineRgn (WinRgn, WinRgn, CreateRectRgn (cCornerRadius div 2, 0, AWidth, cCornerRadius), RGN_OR);
    end;

    //Create topright rounded corner
    if  rcTopRight in ARounded then begin
      WinRgn1 := CreateRectRgn (AWidth - cCornerRadius, 0, AWidth - cCornerRadius div 2, cCornerRadius);
      CombineRgn (WinRgn1, WinRgn1, CreateEllipticRgn (AWidth - cCornerRadius + 1, 0, AWidth+1, cCornerRadius), RGN_OR);
      CombineRgn (WinRgn, WinRgn, WinRgn1, RGN_OR);
      DeleteObject(WinRgn1);

      //Create result region
      if rcTopLeft in ARounded then
        CombineRgn (WinRgn, WinRgn, CreateRectRgn (cCornerRadius div 2, 0, AWidth - cCornerRadius div 2, cCornerRadius), RGN_OR)
      else
        CombineRgn (WinRgn, WinRgn, CreateRectRgn (0, 0, AWidth - cCornerRadius, cCornerRadius), RGN_OR);
    end;

    //Create bottomleft rounded corner
    if  rcBottomLeft in ARounded then begin
      WinRgn1 := CreateRectRgn (cCornerRadius div 2, AHeight - cCornerRadius, cCornerRadius, AHeight - cCornerRadius div 2);
      CombineRgn (WinRgn1, WinRgn1, CreateEllipticRgn (0, AHeight - cCornerRadius, cCornerRadius,AHeight+1), RGN_OR);
      CombineRgn (WinRgn, WinRgn, WinRgn1, RGN_OR);
      DeleteObject(WinRgn1);

      //Create result region
      if rcBottomRight in ARounded then
        CombineRgn (WinRgn, WinRgn, CreateRectRgn (cCornerRadius div 2, AHeight - cCornerRadius div 2, AWidth - cCornerRadius div 2, AHeight), RGN_OR)
      else
        CombineRgn (WinRgn, WinRgn, CreateRectRgn (cCornerRadius div 2, AHeight - cCornerRadius div 2, AWidth, AHeight), RGN_OR);
    end;

    //Create bottomright rounded corner
    if  rcBottomRight in ARounded then begin
      WinRgn1 := CreateRectRgn (AWidth - cCornerRadius, AHeight - cCornerRadius,
        AWidth - cCornerRadius div 2, AHeight);
      CombineRgn (WinRgn1, WinRgn1, CreateEllipticRgn (AWidth - cCornerRadius + 1, AHeight-cCornerRadius+1, AWidth+1, AHeight+1), RGN_OR);
      CombineRgn (WinRgn, WinRgn, WinRgn1, RGN_OR);
      DeleteObject(WinRgn1);

      //Create result region
      if rcBottomLeft in ARounded then
        CombineRgn (WinRgn, WinRgn, CreateRectRgn (cCornerRadius div 2, AHeight - cCornerRadius div 2, AWidth - cCornerRadius div 2+1, AHeight), RGN_OR)
      else
        CombineRgn (WinRgn, WinRgn, CreateRectRgn (0, AHeight - cCornerRadius div 2, AWidth - cCornerRadius div 2+1, AHeight), RGN_OR);
    end;


  end else WinRgn := CreateRectRgn (0, 0, AWidth, AHeight);
  {if FShadow then
  begin
    //Create shadow region
    ShadowRgn := CreateRectRgn (-cCornerRadius, -cCornerRadius, Width+cCornerRadius, Height+cCornerRadius);
    //Making shadow and main regions are same
    CombineRgn (ShadowRgn, ShadowRgn, WinRgn, RGN_AND);
    //Offset shadow region
    OffsetRgn (ShadowRgn, FShadowDist, FShadowDist);
    //Making result region
    CombineRgn (WinRgn, ShadowRgn, WinRgn, RGN_OR);
  end;}

  SetWindowRgn (Handle, WinRgn, true);
  DeleteObject(WinRgn);
end;

procedure TxpPanel.ForceReDraw;
begin
  SendMessage (Handle, WM_NCPAINT, 0, 0);
  Invalidate;
end;

procedure TxpPanel.Loaded;
begin
  inherited;
  if FRoundedCorner <> [] then SetShape (FRoundedCorner);
  SendMessage (Handle, WM_NCPAINT, 0, 0);

  if Minimized then
    FHeight := DefaultHeight
  else
    FHeight := Height;
  FOldBounds := BoundsRect;
  if Align = alClient then begin
    FOldAlign := alNone;
    FMaximized := true;
  end
  else
    FMaximized := false;
end;

procedure TxpPanel.MouseEnter (var Message : TMessage);
begin
  inherited;
  if Assigned (FOnMouseEnter) then FOnMouseEnter (self);
end;

procedure TxpPanel.MouseLeave (var Message : TMessage);
begin
  inherited;
  if FMouseOnHeader then begin
    FMouseOnHeader := False;
    FullRepaint := False;
    SendMessage (Handle, WM_NCPAINT, 0, 0);

    if Assigned (FOnTitleMouseExit) then FOnTitleMouseExit (self);
  end;

  if Assigned (FOnMouseExit) then FOnMouseExit (self);
end;

procedure TxpPanel.NCMouseDown (var Message : TWMNCLBUTTONDOWN);
var
  ATitleHeight : Integer;
begin
  if not (Message.HitTest in [HTCLOSE, HTMINBUTTON, HTMAXBUTTON]) then begin
    if Message.HitTest = HTCAPTION then begin
      if Assigned (FBeforeMoving) then FBeforeMoving (self);
    end;

    inherited;

    Invalidate;
    if Message.HitTest in [HTTOP, HTLEFT, HTRIGHT, HTBOTTOM,
          HTTOPLEFT, HTTOPRIGHT, HTBOTTOMLEFT, HTBOTTOMRIGHT] then begin
      Invalidate;
    end;

    if Message.HitTest = HTCAPTION then begin
      if Assigned (FAfterMoving) then FAfterMoving (self);
    end;

    try Parent.Realign; except end;
  end;

  ATitleHeight := 0;
  if FShowHeader then ATitleHeight := FTitleHeight;
  if FShowBorder then ATitleHeight := ATitleHeight + 1;

  if Assigned (FOnTitleMouseDown) then
    FOnTitleMouseDown (Self, mbLeft, [],
      ScreenToClient (Point (Message.XCursor, Message.YCursor)).x,
      ScreenToClient (Point (Message.XCursor, Message.YCursor)).y + ATitleHeight);

end;

procedure TxpPanel.NCMouseUp (var Message : TWMNCLBUTTONUP);
var
  ATitleHeight : Integer;
begin
  inherited;
  Parent.Realign;
  if Assigned (FOnTitleClick) and
     not (Message.HitTest in [HTCLOSE, HTMINBUTTON, HTMAXBUTTON]) then FOnTitleClick (Self);

  ATitleHeight := 0;
  if FShowHeader then ATitleHeight := FTitleHeight;
  if FShowBorder then ATitleHeight := ATitleHeight + 1;

  if Assigned (FOnTitleMouseUp) then
    FOnTitleMouseUp (Self, mbLeft, [],
      ScreenToClient (Point (Message.XCursor, Message.YCursor)).x,
      ScreenToClient (Point (Message.XCursor, Message.YCursor)).y + ATitleHeight);

  case Message.HitTest of
    HTCLOSE:
    begin
      Visible := False;
      if Assigned (FAfterClose) then FAfterClose (Self);
    end;
    HTMAXBUTTON:
    begin
      Maximized := not Maximized;
    end;
    HTMINBUTTON:
    begin
      Minimized := not Minimized;
    end;
  end;
end;

procedure TxpPanel.NCMouseDblClick (var Message : TWMNCLButtonDblClk);
begin
  if Assigned (FOnTitleDblClick) then FOnTitleDblClick (self);
  if tbMinimize in FTitleButtons then Minimized := not Minimized else
    if tbMaximize in FTitleButtons then Maximized := not Maximized;
end;


procedure TxpPanel.SetGradientFill (AValue : Boolean);
begin
  if FGradientFill <> AValue then begin
    FGradientFill := AValue;
    ForceReDraw;
  end;
end;

procedure TxpPanel.SetStartColor (AColor : TColor);
begin
  if FStartColor <> AColor then begin
    FStartColor := AColor;
    ForceReDraw;
  end;
end;

procedure TxpPanel.SetEndColor (AColor : TColor);
begin
  if FEndColor <> AColor then begin
    FEndColor := AColor;
    ForceReDraw;
  end;
end;

procedure TxpPanel.SetFillDirection (AFillDirection : TFillDirection);
begin
  if FFillDirection <> AFillDirection then begin
    FFillDirection := AFillDirection;
    ForceReDraw;
  end;
end;

procedure TxpPanel.SetShadow (AValue : Boolean);
begin
  if FShadow <> AValue then begin
    FShadow := AValue;
    SetShape (FRoundedCorner);
  end;
end;


procedure TxpPanel.SetShadowDist (AValue : Integer);
begin
  if AValue < 1 then AValue := 1;
  if (FShadowDist <> AValue) then begin
    FShadowDist := AValue;
    ForceReDraw;
  end;
end;


procedure TxpPanel.SetShowHeader (AValue : Boolean);
begin
  if FShowHeader <> AValue then begin
    FShowHeader := AValue;
    SendMessage (Handle, WM_SIZE, 0, 0);
  end;
end;

procedure TxpPanel.SetCaption (ACaption : String);
begin
  if FCaption <> ACaption then begin
    FCaption := ACaption;
    ForceReDraw;
  end;
end;

procedure TxpPanel.SetTitle (ATitle : String);
begin
  if FTitle <> ATitle then begin
    FTitle := ATitle;
    ForceReDraw;
  end;
end;

procedure TxpPanel.SetTitleAlignment (AValue : TAlignment);
begin
  FTitleAlignment := AValue;
  ForceReDraw;
end;

procedure TxpPanel.SetTitleGradient (AValue : Boolean);
begin
  if FTitleGradient <> AValue then begin
    FTitleGradient := AValue;
    ForceReDraw;
  end;
end;

procedure TxpPanel.SetTitleStartColor (AValue : TColor);
begin
  if FTitleStartColor <> AValue then begin
    FTitleStartColor := AValue;
    ForceReDraw;
  end;
end;

procedure TxpPanel.SetTitleEndColor (AValue : TColor);
begin
  if FTitleEndColor <> AValue then begin
    FTitleEndColor := AValue;
    ForceReDraw;
  end;
end;

procedure TxpPanel.SetTitleFillDirect (AValue : TFillDirection);
begin
  if FTitleFillDirect <> AValue then begin
    FTitleFillDirect := AValue;
    ForceReDraw;
  end;
end;

procedure TxpPanel.SetTitleColor (AValue : TColor);
begin
  if FTitleColor <> AValue then begin
    FTitleColor := AValue;
    ForceReDraw;
  end;
end;

procedure TxpPanel.SetTitleImage (AValue : TBitmap);
begin
  if not FTitleImage.Empty then FTitleImage.FreeImage;
  FTitleImage.Assign (AValue);
  ForceReDraw;
end;

procedure TxpPanel.SetTitleFont (AFont : TFont);
begin
  FTitleFont.Assign (AFont);
  ForceReDraw;
end;


procedure TxpPanel.OnTitleFontChange (Sender : TObject);
begin
  ForceReDraw;
end;


procedure TxpPanel.SetTitleHeight (AHeight : Integer);
begin
  if FTitleHeight <> AHeight then begin
    FTitleHeight := AHeight;
    ForceReDraw;
  end;
end;

procedure TxpPanel.SetTitleCursor (AValue : TCursor);
begin
  if FTitleCursor <> AValue then begin
    FTitleCursor := AValue;
  end;
end;


procedure TxpPanel.SetBorderSize (AValue : Integer);
begin
  If AValue < 0 then AValue := 0;
  if FBorderSize <> AValue then begin
    FBorderSize := AValue;
    ForceReDraw;
  end;
end;

procedure TxpPanel.SetBorderColor (AValue : TColor);
begin
  if FBorderColor <> AValue then begin
    FBorderColor := AValue;
    ForceReDraw;
  end;
end;

procedure TxpPanel.SetShowBorder (AValue : Boolean);
begin
  if FShowBorder <> AValue then begin
    FShowBorder := AValue;
    SetShape (FRoundedCorner);
  end;
end;

procedure TxpPanel.SetBGImage (AImage : TBitmap);
begin
  FBGImage.Assign (AImage);
  ForceReDraw;
end;

procedure TxpPanel.SetBGImageAlign (AImageAlign : TBGImageAlign);
begin
  if FBGImageAlign <> AImageAlign then begin
    FBGImageAlign := AImageAlign;
    if (FBGImageAlign = iaTile) or (FBGImageAlign = iaStretch) then FGradientFill := False;
    ForceReDraw;
  end;
end;

procedure TxpPanel.SetTitleImageAlign (AValue : TTitleImageAlign);
begin
  if FTitleImageAlign <> AValue then begin
    FTitleImageAlign := AValue;
    ForceReDraw;
  end;
end;

procedure TxpPanel.SetTitleImageTransparent (AValue : Boolean);
begin
  if FTitleImageTransparent <> AValue then begin
    FTitleImageTransparent := AValue;
    ForceReDraw;
  end;
end;


procedure TxpPanel.SetBGImageTransparent (Atrans : Boolean);
begin
  if FBGImageTransparent <> ATrans then begin
    FBGImageTransparent := ATrans;
    ForceReDraw;
  end;
end;

procedure TxpPanel.RefreshSystemColor;
begin
  FBorderColor := clIccPanelBorder;
  Color := clIccPanelBG;
  FStartColor := clIccPanelBGBeg;
  FEndColor := clIccPanelBGEnd;
  FTitleColor := clIccPanelTitleBeg;
  FTitleEndColor := clIccPanelTitleEnd;
  FTitleFont.Color := clIccPanelTitleFont;
end;

procedure TxpPanel.SetShadowTitleOnMouseEnter (AShadow : Boolean);
begin
  if FTitleShadowOnMouseEnter <> AShadow then begin
    FTitleShadowOnMouseEnter := AShadow;
  end;
end;

procedure TxpPanel.SetRoundedCorner (AValue : TRoundedCorners);
begin
  if FRoundedCorner <> AValue then begin
    FRoundedCorner := AValue;
    FullRepaint := true;
    SetShape (FRoundedCorner);
    FullRepaint := False;
  end;
end;

procedure TxpPanel.SetMovable (AValue : Boolean);
begin
  if FMovable <> AValue then begin
    FMovable := AValue;
  end;
end;

procedure TxpPanel.SetSizable (AValue : Boolean);
begin
  if FSizable <> AValue then begin
    FSizable := AValue;
  end;
end;



procedure TxpPanel.SetMinimized (AValue : Boolean);
{/*****************************/*}
  procedure Anime (NewSize : Integer);
  var
    I, Step, Iteration : Integer;
    YStart, YEnd : Integer;
    OldFRepaint : Boolean;
  begin
      //Animation
      if FAnimation then begin
        Step := 0;
        if Height > NewSize then begin
          YStart := newSize;
          YEnd := Height;
        end else begin
          YStart := Height;
          YEnd := newSize;
        end;
        Iteration := (YEnd - YStart) div 10;
        if Iteration = 0 then Iteration := 1;
        OldFRepaint := FullRepaint;
        FullRepaint := False;
        For I := YStart to YEnd do begin
          if Step = Iteration then begin
            if Height < NewSize then Height := Height + Step
            else Height := Height - Step;
            Application.ProcessMessages;
            Step := 0;
          end;
          Inc (Step);
        end;
        FullRepaint := OldFRepaint;
      end;
  end;
{/*****************************/*}

begin
  if (FMinimized <> AValue) and (not FMinimizing ) then begin
    Maximized := False;
    FMinimized := AValue;

    if AValue then begin
      try
        FMinimizing := True;
        FHeight := Height;
        if FAnimation then Anime (FTitleHeight + FBorderSize);
        Height := FTitleHeight + FBorderSize;
      finally
        FMinimizing := False;
      end;
    end else begin
      try
        FMinimizing := true;
        if Height = FHeight then FHeight := FDefaultHeight;
        if FAnimation then Anime (FHeight);
        Height := FHeight;
      finally
        FMinimizing := false;
      end;
    end;

    Invalidate;
    if Assigned (FAfterMinimized) then
      FAfterMinimized (Self, FMinimized);
  end;
end;

procedure TxpPanel.SetMaximized (AValue : Boolean);
begin
  if FMaximized <> AValue then begin
    FMaximized := AValue;

    if FMaximized then begin
      FOldBounds := BoundsRect;
      FOldAlign := Align;
      Align := alClient;
    end else begin
      Align := FOldAlign;
      BoundsRect := FOldBounds;
    end;

    Invalidate;
    if Assigned (FAfterMaximized) then
      FAfterMaximized (Self, FMaximized);
  end;
end;


procedure TxpPanel.SetTitleButtons (AValue : TTitleButtons);
begin
  if FTitleButtons <> AValue then begin
    FTitleButtons := AValue;
    if Parent <> nil then begin
      SendMessage (Handle, WM_NCPAINT, 0, 0);
      SendMessage (Handle, WM_SIZE, 0, 0);
    end;
  end;
end;

procedure TxpPanel.SetAnimation (AValue : Boolean);
begin
  if FAnimation <> AValue then
  begin
    FAnimation := AValue;
  end;
end;

procedure TxpPanel.SetDefaultHeight (AValue : Integer);
begin
  if AValue <> FDefaultHeight then begin
    FDefaultHeight := AValue;
    if Minimized then FHeight := FDefaultHeight;
  end;
end;

// TxpGroupBox

constructor TxpGroupBox.Create(AOwner: TComponent);
begin
  inherited Create (AOwner);
  FSystemColor := TRUE;
  oBasicColor := cbcBasicColor;
   Width := 180;
  Height := 60;
  Color := clIccPanelBG;
  FBorderColor := clIccInactBorder;
  ParentColor := FALSE;
end;

destructor  TxpGroupBox.Destroy;
begin
  inherited;
end;

procedure   TxpGroupBox.Paint;
var
  H: Integer;
  R: TRect;
  Flags: Longint;
begin
  If FSystemColor then RefreshSystemColor;
  with Canvas do begin
    Font := Self.Font;
    H := TextHeight('0');
    R := Rect(0, H div 2 - 1, Width, Height);
    Pen.Color := FBorderColor;
    Brush.Color := Color;
//    FrameRect(R);
    RoundRect(R.Left,R.Top,R.Right,R.Bottom,5,5);
    if Text <> '' then begin
      if not UseRightToLeftAlignment
        then R := Rect(8, 0, 0, H)
        else R := Rect(R.Right - Canvas.TextWidth(' '+Text+' ') - 8, 0, 0, H);
      Flags := DrawTextBiDiModeFlags(DT_SINGLELINE);
      DrawText(Handle, PChar(' '+Text+' '), Length(' '+Text+' '), R, Flags or DT_CALCRECT);
      Brush.Color := Color;
      DrawText(Handle, PChar(' '+Text+' '), Length(' '+Text+' '), R, Flags);
    end;
  end;
  If oSelected then begin
    If cUniMultiSelect
      then Canvas.Brush.Color := clSilver
      else begin
        Canvas.Brush.Color := clBlack;
       Canvas.FillRect(Rect((Width div 2)-2,0,(Width div 2)+3,5));
       Canvas.FillRect(Rect((Width div 2)-2,Height-5,(Width div 2)+3,Height));
       Canvas.FillRect(Rect(0,(Height div 2)-2,5,(Height div 2)+3));
       Canvas.FillRect(Rect(Width-5,(Height div 2)-2,Width,(Height div 2)+3));
    end;

    Canvas.FillRect(Rect(0,0,5,5));
    Canvas.FillRect(Rect(0,Height-5,5,Height));
    Canvas.FillRect(Rect(Width-5,0,Width,5));
    Canvas.FillRect(Rect(Width-5,Height-5,Width,Height));
  end;
end;

procedure TxpGroupBox.RefreshSystemColor;
begin
  Color := clIccPanelBG;
  FBorderColor := clIccInactBorder;
end;

procedure TxpGroupBox.SetBorderColor (AValue:TColor);
begin
  If AValue<>FBorderColor then begin
    FBorderColor := AValue;
    Repaint;
  end;
end;

procedure TxpGroupBox.SetSystemColor (AValue:boolean);
begin
  FSystemColor := AValue;
  Repaint;
end;

procedure TxpGroupBox.SetBasicColor (pValue:TColor);
begin
  If not FSystemColor then begin
    oBasicColor := pValue;
    Color := IccCompHueColor (oBasicColor, TclIccPanelBG);
    FBorderColor := IccCompHueColor (oBasicColor, TclIccInactBorder);
  end;
end;

// TxpRadioButton

constructor TxpRadioButton.Create(AOwner : TComponent);
begin
  inherited;
  MouseOnControl:=False;
  Enabled:=True;
  FCaption:='';
  FChecked:=False;
  TabStop:=True;
  Width:=100;
  Height:=20;
  FShadowText := TRUE;
  FCheckData := 'A';
  oSystemColor := TRUE;
  oBasicColor := cbcBasicColor;
end;

procedure TxpRadioButton.DrawCheckmark;
var mSize, mWidth:word;
begin
  with Canvas do begin
    Brush.Color := oCheckColor;
    Pen.Color := oCheckColor;
    mSize := TextHeight(FCaption) div 2;
    mWidth := 3;
    If mSize>14 then mWidth := 4;
    If mSize<11 then mSize := 11;
    Ellipse(mWidth,((Height-mSize) div 2)+mWidth, mSize-mWidth, ((Height-mSize) div 2)+mSize-mWidth);
    Brush.Color := Color;
  end;
end;

procedure TxpRadioButton.Click;
var
  Counter : Integer;
begin
  inherited;
  if (Enabled and TabStop and CanFocus) then SetFocus;
  Invalidate;
  if Enabled then begin
    with (Parent as TWinControl) do begin
      for Counter:=0 to (ControlCount - 1) do begin
        if Controls[Counter] is TxpRadioButton
        then (Controls[Counter] as TxpRadioButton).Checked:=False;
      end;
    end;
    SetFocus;
    FChecked:=True;
    if Assigned(FOnClick) then FOnClick(Self);
  end;
  Invalidate;
end;

procedure TxpRadioButton.CMDialogChar(var Message : TCMDialogChar);
begin
  If Enabled and IsAccel (Message.CharCode, FCaption) and (KeyDataToShiftState(Message.KeyData) = [ssAlt]) then begin
    If not Focused then SetFocus;
    Click;
  end;
end;

procedure TxpRadioButton.KeyPress(var Key : Char);
var Counter : Integer; Msg: TMsg;
begin
  inherited;
// Tibi 02.10.2009
  If (Key = #13) then begin
    SendMessage((Owner as TForm).Handle, WM_NEXTDLGCTL, 0, 0);
    PeekMessage(Msg, 0, WM_CHAR, WM_CHAR, PM_REMOVE);
  end;
  if Enabled and (Key = #32) then begin
    with (Parent as TWinControl) do begin
      for Counter:=0 to (ControlCount - 1) do begin
        if Controls[Counter] is TxpRadioButton
        then (Controls[Counter] as TxpRadioButton).Checked:=False;
      end;
    end;
    FChecked:=True;
    if Assigned(FOnClick) then FOnClick(Self);
  end;
  Invalidate;
end;

procedure TxpRadioButton.FocusRect(X1,Y1,X2,Y2 : Integer);
var mLeft:longint; mText:string;
begin
  mText := ReplaceStr (FCaption, '&', '');
  mLeft := Canvas.TextWidth('A');
  If mLeft<13 then mLeft := 13;
  mLeft := mLeft+mLeft div 3;
  Canvas.Brush.Style := bsSolid;
//  Canvas.DrawFocusRect (Rect (mLeft-5, (Height - Canvas.TextHeight (mText)) div 2-1, Canvas.TextWidth (mText)+mLeft+5, (Height - Canvas.TextHeight (mText)) div 2 + Canvas.TextHeight (mText)+2))
  Canvas.DrawFocusRect (Rect (mLeft-3, (Height - Canvas.TextHeight (mText)) div 2, Canvas.TextWidth (mText)+mLeft+3, (Height - Canvas.TextHeight (mText)) div 2 + Canvas.TextHeight (mText)))
end;

procedure TxpRadioButton.SetCaption(Value:TCaption);
begin
  If FCaption<>Value then begin
    FCaption:=Value;
    If (Pos ('&', FCaption) <> 0) and (Pos ('&', FCaption) < Length (FCaption))
      then FHotKey := UpperCase (string (Copy (FCaption, Pos ('&', FCaption)+1, 1)))[1]
      else FHotKey := #0;
    Repaint;
//    Invalidate;
  end;
end;

function  TxpRadioButton.GetCaption:TCaption;
begin
  Result := FCaption;
end;

function  TxpRadioButton.GetDataSource:TDataSource;
begin
  Result := FDataSource;
end;

procedure TxpRadioButton.SetDataSource (AValue:TDataSource);
begin
  FDataSource := AValue;
  If (AValue<>nil) and (FFieldName<>'') then (FDataSource as TDataTable).AddField(Owner.Name+'.'+Name+','+FieldName);
end;

function  TxpRadioButton.GetFieldName:string;
begin
  Result := FFieldName;
end;

procedure TxpRadioButton.SetFieldName (AValue:string);
begin
  FFieldName := AValue;
end;

procedure TxpRadioButton.SetShadowText (AValue : Boolean);
begin
  If FShadowText <> AValue then begin
    FShadowText := AValue;
    Invalidate;
  end;
end;

procedure TxpRadioButton.SetChecked(Value : Boolean);
begin
  FChecked:=Value;
  Invalidate;
end;

procedure TxpRadioButton.SetSystemColor (pValue:boolean);
begin
  oSystemColor := pValue;
  Repaint;
end;

procedure TxpRadioButton.SetCheckColor (pValue:TColor);
begin
  oCheckColor := pValue;
  Repaint;
end;

procedure TxpRadioButton.SetBasicColor (pValue:TColor);
begin
  oBasicColor := pValue;
  oBorderColor := IccCompHueColor (pValue, TclIccInactBorder);
  oGradBeg := IccCompHueColor (pValue, TclIccChBoxActGradBeg);
  oGradEnd := IccCompHueColor (pValue, TclIccChBoxActGradEnd);
  Repaint;
end;

procedure TxpRadioButton.RefreshSystemColor;
begin
  oCheckColor := clIccChBoxCheck;
  oBorderColor := clIccInactBorder;
  oGradBeg := clIccChBoxActGradBeg;
  oGradEnd := clIccChBoxActGradEnd;
end;

procedure TxpRadioButton.MouseEnter(var Msg : TMessage);
begin
  MouseOnControl:=True;
  Msg.Result:=1;
  if Enabled and Assigned(FOnMouseEnter) then FOnMouseEnter(Self);
  Invalidate;
end;

procedure TxpRadioButton.MouseLeave(var Msg : TMessage);
begin
  MouseOnControl:=False;
  Msg.Result:=1;
  if Enabled and Assigned(FOnMouseLeave) then FOnMouseLeave(Self);
  Invalidate;
end;

procedure TxpRadioButton.SetCtrlHasFocus(var Msg : TMessage);
begin
  if (TabStop and Enabled and CanFocus) then SetFocus;
  Msg.Result:=1;
  Invalidate;
end;

procedure TxpRadioButton.KillCtrlHasFocus(var Msg : TMessage);
begin
  Msg.Result:=1;
  Invalidate;
end;

procedure TxpRadioButton.Paint;
var X1,Y1,X2,Y2 : Integer; mSize, mWidth:word; mLeft:word; mText:string;
begin
  If oSystemColor then RefreshSystemColor;
  inherited;
  with Canvas do begin
    Brush.Color:=Self.Color;
    Brush.Style:=bsSolid;
    Font:=Self.Font;
    mText := ReplaceStr (FCaption, '&', '');
    mSize := TextHeight(mText) div 2;
    mWidth := 1;
    If mSize>14 then mWidth := 2;
    If mSize<11 then mSize := 11;
    If MouseOnControl then begin
      Brush.Color := oBorderColor;
      Pen.Color := oBorderColor;
      Ellipse(0,((Height - mSize) div 2), mSize, ((Height - mSize) div 2)+mSize);
      Brush.Color := oGradEnd;
      Pen.Color := oGradEnd;
      Ellipse(mWidth,((Height - mSize) div 2)+mWidth, mSize-mWidth, ((Height - mSize) div 2)+mSize-mWidth);
      Brush.Color := oGradBeg;
      Pen.Color := oGradBeg;
      Ellipse(mWidth,((Height - mSize) div 2)+mWidth, mSize-mWidth-2, ((Height - mSize) div 2)+mSize-mWidth-2);
      Brush.Color := clWhite;
      Pen.Color := clWhite;
      Ellipse(mWidth+2,((Height - mSize) div 2)+mWidth+1, mSize-mWidth-2, ((Height - mSize) div 2)+mSize-mWidth-2);
    end else begin
      Brush.Color := oBorderColor;
      Pen.Color := oBorderColor;
      Ellipse(0,((Height - mSize) div 2), mSize, ((Height - mSize) div 2)+mSize);
      Brush.Color := clWhite;
      Pen.Color := clWhite;
      Ellipse(mWidth,((Height - mSize) div 2)+mWidth, mSize-mWidth, ((Height - mSize) div 2)+mSize-mWidth);
    end;
    Brush.Color := Color;
    Pen.Color := clBlack;
    if (Enabled and FChecked) then DrawCheckmark;
    mLeft := TextWidth('A');
    If mLeft<13 then mLeft := 13;
    mLeft := mLeft+mLeft div 3;
//
    If Enabled then begin
      Brush.Style:=bsSolid;
      If FShadowText then begin
        Font.Color := clLtGray;
        TextOut(mLeft+1,(Height - TextHeight(mText)) div 2+1,mText);
        Brush.Style:=bsClear;
      end;
      Font.Color := clBlack;
      TextOut(mLeft,(Height - TextHeight(mText)) div 2,mText)
    end else begin
      Brush.Style:=bsClear;
      Font.Color:=clBtnHighLight;
      TextOut(mLeft+1,((Height - TextHeight(mText)) div 2) + 1,mText);
      Font.Color:=clBtnshadow;
      TextOut(mLeft,(Height - TextHeight(mText)) div 2,mText);
    end;
    If Pos ('&', FCaption) <> 0 then begin
      Canvas.Pen.Color := Canvas.Font.Color;
      Canvas.Pen.Width := 1;
      Canvas.MoveTo (mLeft + Canvas.TextWidth (Copy (mText, 1, Pos ('&', FCaption)-1)),
                     (Height - Canvas.TextHeight (mText)) div 2+Canvas.TextHeight (mText)-2);
      Canvas.LineTo (mLeft + Canvas.TextWidth (Copy (mText, 1, Pos ('&', FCaption))),
                     (Height - Canvas.TextHeight (mText)) div 2+Canvas.TextHeight (mText)-2);
    end;
    If Focused then begin
      X1:=18;
      Y1:=((Height - TextHeight(mText)) div 2) - 2;
      X2:=X1 + TextWidth(mText) + 4;
      Y2:=Y1 + TextHeight(mText) + 4;
      Pen.Color:=clHighLight;
      FocusRect(X1,Y1,X2,Y2);
    end;
  end;
end;


// TxpMemoColors
constructor TxpMemoColors.Create (AOwner : TxpMemo);
begin
  inherited Create;
  FxpMemo := AOwner;
  FBGNormal := clIccBG;
  FBGActive := clIccBGActive;
  FBGModify := clIccBGModify;
  FInactBorder := clIccInactBorder;
  FActBorder := clIccActBorder;
end;

procedure TxpMemoColors.SetBGNormal (AValue:TColor);
begin
  If FBGNormal<>AValue then begin
    FBGNormal := AValue;
    FxpMemo.Color := AValue;
    FxpMemo.Invalidate;
  end;
end;

procedure TxpMemoColors.SetBGActive (AValue:TColor);
begin
  If FBGActive<>AValue then begin
    FBGActive := AValue;
    FxpMemo.Invalidate;
  end;
end;

procedure TxpMemoColors.SetBGModify (AValue:TColor);
begin
  If FBGModify<>AValue then begin
    FBGModify := AValue;
    FxpMemo.Invalidate;
  end;
end;

procedure TxpMemoColors.SetInactBorder (AValue:TColor);
begin
  If FInactBorder<>AValue then begin
    FInactBorder := AValue;
    FxpMemo.Invalidate;
  end;
end;

procedure TxpMemoColors.SetActBorder (AValue:TColor);
begin
  If FActBorder<>AValue then begin
    FActBorder := AValue;
    FxpMemo.Invalidate;
  end;
end;

// TxpMemo
constructor TxpMemo.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  FMemoColors := TxpMemoColors.Create (Self);
  BorderStyle := bsNone;
  BorderWidth := 3;
  FActive := FALSE;
  FFocused := FALSE;
  FSystemColor := TRUE;
  Color := clIccBG;
  Font.Color := clIccMemoFont;
  oBasicColor := cbcBasicColor;
end;

destructor  TxpMemo.Destroy;
begin
  try FreeAndNil (FMemoColors); except end;
  inherited;
end;

procedure TxpMemo.WMPaint(var Message: TWMPaint);
var  Rgn: hRgn;  mBrush: HBrush; DC: hDC; NCanvas:TCanvas;
begin
  If FSystemColor then RefreshSystemColor;
  inherited;
  DC := GetWindowDC (Handle);
  NCanvas := TCanvas.Create;
  NCanvas.Handle := DC;
  NCanvas.Brush.Style := bsClear;
  NCanvas.Pen.Color := FMemoColors.BGNormal;
  NCanvas.Rectangle(1,1,Width-1,Height-1);
  NCanvas.Rectangle(2,2,Width-2,Height-2);
  FreeAndNil (NCanvas);
  Rgn := CreateRoundRectRgn (0,0,Width+1, Height+1, 2, 2);
  If FActive
    then mBrush := CreateSolidBrush (ColorToRGB (FMemoColors.ActBorder))
    else mBrush := CreateSolidBrush (ColorToRGB (FMemoColors.InactBorder));
  FrameRgn (DC, Rgn, mBrush, 1, 1);
  DeleteObject (mBrush);
  DeleteObject (Rgn);
  ReleaseDC (Handle, DC);
end;

procedure TxpMemo.WMNCPaint (var Message : TWMNCPaint);
var  Rgn: hRgn;  mBrush: HBrush; DC: hDC; NCanvas:TCanvas;
begin
  If FSystemColor then RefreshSystemColor;
  inherited;
  DC := GetWindowDC (Handle);
  NCanvas := TCanvas.Create;
  NCanvas.Handle := DC;
  NCanvas.Brush.Style := bsClear;
  NCanvas.Pen.Color := FMemoColors.BGNormal;
  NCanvas.Rectangle(1,1,Width-1,Height-1);
  NCanvas.Rectangle(2,2,Width-2,Height-2);
  FreeAndNil (NCanvas);
  Rgn := CreateRoundRectRgn (0,0,Width+1, Height+1, 2, 2);
  If FActive
    then mBrush := CreateSolidBrush (ColorToRGB (FMemoColors.ActBorder))
    else mBrush := CreateSolidBrush (ColorToRGB (FMemoColors.InactBorder));
  FrameRgn (DC, Rgn, mBrush, 1, 1);
  DeleteObject (mBrush);
  DeleteObject (Rgn);
  ReleaseDC (Handle, DC);
end;

procedure TxpMemo.MouseEnter (var Message : TMessage);
begin
  inherited;
  If not FActive then begin
    FActive := TRUE;
    FOldValue := Text;
    Invalidate;
  end;
end;

procedure TxpMemo.MouseLeave (var Message : TMessage);
begin
  inherited;
  If FActive then begin
    FActive := FALSE;
    Invalidate;
  end;
end;

procedure TxpMemo.CMEnter(var Message: TCMGotFocus);
begin
  inherited;
  If not FFocused then begin
    Color := FMemoColors.BGActive;
    FFocused := TRUE;
    Invalidate;
  end;
  FOldValue := Text;
end;

procedure TxpMemo.CMExit(var Message: TCMExit);
begin
  inherited;
  If FFocused then begin
    Color := FMemoColors.BGNormal;
    FFocused := FALSE;
    Invalidate;
  end;
  If (FOldValue<>Text) and Assigned(FOnModified) then FOnModified(Self);
end;

procedure TxpMemo.KeyUp(var Key: Word; Shift: TShiftState);
begin
  inherited;
  If FOldValue<>Text then begin
    Color := FMemoColors.BGModify;
    Invalidate;
  end else begin
    Color := FMemoColors.BGActive;
    Invalidate;
  end;
end;

procedure TxpMemo.SetDataSource (AValue:TDataSource);
begin
  FDataSource := AValue;
  If (AValue<>nil) and (FFieldName<>'') then (FDataSource as TDataTable).AddField(Owner.Name+'.'+Name+','+FieldName);
end;

function  TxpMemo.GetDataSource:TDataSource;
begin
  Result := FDataSource;
end;

function  TxpMemo.GetFieldName:string;
begin
  Result := FFieldName;
end;

procedure TxpMemo.SetFieldName (AValue:string);
begin
  FFieldName := AValue;
end;

procedure TxpMemo.SetSystemColor(AValue:boolean);
begin
  FSystemColor := AValue;
  If AValue then RefreshSystemColor;
  Invalidate;
end;

procedure TxpMemo.SetBasicColor(pValue:TColor);
begin
  Color := IccCompHueColor (pValue, TclIccBG);
  FMemoColors.FBGNormal := IccCompHueColor (pValue, TclIccBG);
  FMemoColors.FBGActive := IccCompHueColor (pValue, TclIccBGActive);
  FMemoColors.FBGModify := IccCompHueColor (pValue, TclIccBGModify);
  FMemoColors.FInactBorder := IccCompHueColor (pValue, TclIccInactBorder);
  FMemoColors.FActBorder := IccCompHueColor (pValue, TclIccActBorder);
  Repaint;
end;

procedure TxpMemo.RefreshSystemColor;
begin
  Color := clIccBG;
  FMemoColors.FBGNormal := clIccBG;
  FMemoColors.FBGActive := clIccBGActive;
  FMemoColors.FBGModify := clIccBGModify;
  FMemoColors.FInactBorder := clIccInactBorder;
  FMemoColors.FActBorder := clIccActBorder;
  Font.Color := clIccMemoFont;
//  Repaint;
end;

// TxpStatusLine
constructor TxpStatusLine.Create(AOwner: TComponent);
begin
  inherited Create (AOwner);
  Caption := '';
  Color := clIccStatusLineBG;
  FBorderColorL := clIccStatusLineBorderL;
  FBorderColorD := clIccStatusLineBorderD;
  FLineColor    := clIccStatusLineLn;
  Font.Color    := clIccStatusLineFont;

  Align := alBottom;
  BevelOuter := bvNone;
  BorderStyle := bsNone;
  Height := 19;
  FText := ctSLYear+';'+ctSLFirmaNum+';'+ctSLFirmaName+';'+ctSLUserName;
  FSystemColor := TRUE;
end;

destructor  TxpStatusLine.Destroy;
begin
  inherited Destroy;
end;

procedure TxpStatusLine.SetText (AValue:string);
begin
  If FText<>AValue then begin
    FText := AValue;
    Invalidate;
  end;
end;

procedure TxpStatusLine.SetBorderColorL (AValue:TColor);
begin
  If FBorderColorL<>AValue then begin
    FBorderColorL := AValue;
    Invalidate;
  end;
end;

procedure TxpStatusLine.SetBorderColorD (AValue:TColor);
begin
  If FBorderColorD<>AValue then begin
    FBorderColorD := AValue;
    Invalidate;
  end;
end;

procedure TxpStatusLine.SetLineColor (AValue:TColor);
begin
  If FLineColor<>AValue then begin
    FLineColor := AValue;
    Invalidate;
  end;
end;

procedure TxpStatusLine.RefreshSystemColor;
begin
  FBorderColorL := clIccStatusLineBorderL;
  FBorderColorD := clIccStatusLineBorderD;
  FLineColor    := clIccStatusLineLn;
  Font.Color    := clIccStatusLineFont;
  Color         := clIccStatusLineBG;
  FText := ctSLYear+';'+ctSLFirmaNum+';'+ctSLFirmaName+';'+ctSLUserName;
end;

function  TxpStatusLine.GetSubText (pS:string;pNum:byte):string;
var I:byte;
begin
  Result := '';
  If pNum>4 then pNum := 4;
  If (pS<>'') and (pNum>1) then begin
    For I:=1 to pNum-1 do
      Delete (pS,1,Pos (';',pS));
  end;
  If pS<>'' then begin
    If Pos (';',pS)=0
      then Result := pS
      else Result := Copy (pS,1,Pos (';',pS)-1);
  end;
end;

procedure TxpStatusLine.Paint;
var DC:hDC; NCCanvas:TCanvas; mRect:TRect;
begin
  If FSystemColor then RefreshSystemColor;
  DC := GetWindowDC (Handle);
  NCCanvas := TCanvas.Create;
  try
    NCCanvas.Handle := DC;
    NCCanvas.Brush.Color := Color;
    mRect.Left := 2; mRect.Top := 4; mRect.Right := Width-14; mRect.Bottom := Height-2;
    mRect.Left := 0; mRect.Top := 0; mRect.Right := Width; mRect.Bottom := Height;
    NCCanvas.FillRect(mRect);
    NCCanvas.Font.Color := Font.Color;
    NCCanvas.TextOut (4,Height-15,GetSubText(FText,1));
    NCCanvas.TextOut (38,Height-15,GetSubText(FText,2));
    NCCanvas.TextOut (66,Height-15,GetSubText(FText,3));
    NCCanvas.TextOut (Width-145,Height-15,GetSubText(FText,4));

    NCCanvas.Pen.Color := FLineColor;
    NCCanvas.MoveTo(33,2);
    NCCanvas.LineTo(33,Height-1);
    NCCanvas.MoveTo(62,2);
    NCCanvas.LineTo(62,Height-1);
    NCCanvas.MoveTo(Width-150,2);
    NCCanvas.LineTo(Width-150,Height-1);

    NCCanvas.Pen.Color := FBorderColorL;
    NCCanvas.MoveTo(0,0);
    NCCanvas.LineTo(Width-1,0);
    NCCanvas.Pen.Color := FBorderColorD;
    NCCanvas.MoveTo(0,2);
    NCCanvas.LineTo(Width-1,2);
    NCCanvas.Pen.Color := FBorderColorL;
    NCCanvas.LineTo(Width-1,Height-1);
    NCCanvas.LineTo(0,Height-1);
    NCCanvas.LineTo(0,3);
    NCCanvas.Pen.Color := FLineColor;
    NCCanvas.MoveTo(Width-4,Height-2);
    NCCanvas.LineTo(Width-2,Height-4);
    NCCanvas.MoveTo(Width-8,Height-2);
    NCCanvas.LineTo(Width-2,Height-8);
    NCCanvas.MoveTo(Width-12,Height-2);
    NCCanvas.LineTo(Width-2,Height-12);
  except end;
  FreeAndNil (NCCanvas);
  ReleaseDC (Handle, DC);
end;

// TxpRichEdit

constructor TxpRichEdit.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  BorderStyle := bsNone;
  BevelInner := bvNone;
  BevelOuter := bvNone;
  BorderStyle := bsNone;
  Ctl3D := FALSE;
  BorderWidth := 3;
  FSystemColor := TRUE;
  FBorderColor := clIccActBorder;
  oBasicColor := cbcBasicColor;
end;

destructor  TxpRichEdit.Destroy;
begin
  inherited;
end;

procedure TxpRichEdit.Add(pStr:string;const pItm,pColor: array of const);
begin
  AddColorText (pStr,pItm,pColor,0,0);
end;

procedure TxpRichEdit.Add(pStr:string;const pItm: array of const;pColor:TColor);
begin
  AddColorText (pStr,pItm,[],pColor,1);
end;

procedure TxpRichEdit.Add(pStr:string;pDefColor:TColor;const pItm: array of const);
begin
  AddColorText (pStr,pItm,[],pDefColor,2);
end;

procedure TxpRichEdit.Add(pStr:string;pDefColor:TColor);
begin
  AddColorText (pStr,[],[],pDefColor,3);
end;

procedure TxpRichEdit.WMPaint(var Message: TWMPaint);
var  Rgn: hRgn;  mBrush: HBrush; DC: hDC; NCanvas:TCanvas;
begin
  If FSystemColor then RefreshSystemColor;
  inherited;
  DC := GetWindowDC (Handle);
  NCanvas := TCanvas.Create;
  NCanvas.Handle := DC;
  NCanvas.Brush.Style := bsClear;
  NCanvas.Pen.Color := Color;
  NCanvas.Rectangle(1,1,Width-1,Height-1);
  NCanvas.Rectangle(2,2,Width-2,Height-2);
  FreeAndNil (NCanvas);
  Rgn := CreateRoundRectRgn (0,0,Width+1, Height+1, 2, 2);
  mBrush := CreateSolidBrush (ColorToRGB (FBorderColor));
  FrameRgn (DC, Rgn, mBrush, 1, 1);
  DeleteObject (mBrush);
  DeleteObject (Rgn);
  ReleaseDC (Handle, DC);
end;

procedure TxpRichEdit.WMNCPaint (var Message : TWMNCPaint);
var  Rgn: hRgn;  mBrush: HBrush; DC: hDC; NCanvas:TCanvas;
begin
  If FSystemColor then RefreshSystemColor;
  inherited;
  DC := GetWindowDC (Handle);
  NCanvas := TCanvas.Create;
  NCanvas.Handle := DC;
  NCanvas.Brush.Style := bsClear;
  NCanvas.Pen.Color := Color;
  NCanvas.Rectangle(1,1,Width-1,Height-1);
  NCanvas.Rectangle(2,2,Width-2,Height-2);
  FreeAndNil (NCanvas);
  Rgn := CreateRoundRectRgn (0,0,Width+1, Height+1, 2, 2);
  mBrush := CreateSolidBrush (ColorToRGB (FBorderColor));
  FrameRgn (DC, Rgn, mBrush, 1, 1);
  DeleteObject (mBrush);
  DeleteObject (Rgn);
  ReleaseDC (Handle, DC);
end;

procedure TxpRichEdit.RefreshSystemColor;
begin
  Color := clIccBG;
  FBorderColor := clIccActBorder;
end;

procedure TxpRichEdit.SetBorderColor (AValue:TColor);
begin
  If AValue<>FBorderColor then begin
    FBorderColor := AValue;
    Repaint;
  end;
end;

procedure TxpRichEdit.SetSystemColor (AValue:boolean);
begin
  FSystemColor := AValue;
  Repaint;
end;

procedure TxpRichEdit.AddColorText (pStr:string;const pItm,pColorA: array of const;pColor:TColor;pColorType:byte);
var I:longint; mStart, mLen, mItmCnt, mPrevSize, mColor:longint; mSLSort,mSLColor:TStringList; mPosS,mSubStr:string;
begin
  If pColorType in [0..2] then begin
    mSLSort := TStringList.Create;
    mSLColor := TStringList.Create;
    For I:=1 to 9 do begin
      mStart := Pos ('#'+StrInt (I,0),pStr);
      If mStart>0 then begin
        mSLSort.Add(StrIntZero (mStart,4)+';'+StrInt (I,0));
      end;
    end;
    If mSLSort.Count>0 then begin
      mSLSort.Sort;
      mSubStr := '';
      For I:=0 to mSLSort.Count-1 do begin
        mItmCnt := ValInt (LineElement (mSLSort.Strings[I],1,';'));
        mPosS := '#'+StrInt (mItmCnt,0);
        mStart := Pos (mPosS,pStr);
        If mStart>0 then begin
          If mItmCnt<=High(pItm)+1 then begin
            mSubStr := string (pItm[mItmCnt-1].VPChar);
            If pItm[mItmCnt-1].VType=4 then mSubStr := Copy (mSubStr,2,Ord (mSubStr[1]));
          end;
          mLen := Length (mSubStr);
          Delete (pStr,mStart,Length (mPosS));
          Insert (mSubStr, pStr, mStart);
          case pColorType of
           0: mColor := pColorA[mItmCnt-1].VInteger;
           1: mColor := pColor;
          end;
          mSLColor.Add(StrInt (mStart,0)+';'+StrInt (mLen,0)+';'+StrInt (mColor,0));
        end;
      end;
    end;
    mPrevSize := Length (Text)-1;
  end;
  If pColorType in [2,3] then begin
    SelStart := Length (Text);
    SelAttributes.Color := pColor;
  end;
  Lines.Add(pStr);
  If pColorType in [0..2] then begin
    If pColorType in [0,1] then begin
      If mSLColor.Count>0 then begin
        For I:=0 to mSLColor.Count-1 do begin
          SelStart := mPrevSize+ValInt (LineElement (mSLColor.Strings[I],0,';'));
          SelLength := ValInt (LineElement (mSLColor.Strings[I],1,';'));
          SelAttributes.Color := ValInt (LineElement (mSLColor.Strings[I],2,';'));
          SelStart := 0;
          SelLength := 0;
        end;
      end;
    end;
    FreeAndNil (mSLSort);
    FreeAndNil (mSLColor);
  end;
end;

procedure TxpRichEdit.SetBasicColor (pValue:TColor);
begin
  oBasicColor := pValue;
  Color := clIccBG;
  FBorderColor := IccCompHueColor (pValue, TclIccActBorder);
  Repaint;
end;

// TxpUniComp

(*
procedure TxpUniComp.PaintLabel;
var mLeft, mTop:longint; mSList:TStringList;mS,mWord:string;
begin
  Canvas.Brush.Color := Color;
  Canvas.Brush.Style := bsSolid;
  Canvas.Font := Font;
  mSList := TStringList.Create;
  If oWordWrap then begin
    mS := Caption;
    While mS<>'' do begin
      If Canvas.TextWidth(mS)>Width then begin
        If Pos (' ',mS)>0 then begin

        end else begin
          mSList.Add(mS);
          mS := '';
        end;
      end else begin
        mSList.Add(mS);
        mS := '';
      end;
    end;
  end else mSList.Add(Caption);

  mLeft := 0; mTop := 0;
  case FAlignment of
    taCenter      : mLeft := (Width-Canvas.TextWidth(Caption)) div 2;
    taRightJustify: mLeft := Width-Canvas.TextWidth(Caption);
  end;
  case oLayout of
    tlCenter: mTop := 1+(Height-Canvas.TextHeight(Caption)) div 2;
    tlBottom: mTop := 1+Height-Canvas.TextHeight(Caption);
  end;
  Canvas.TextOut (mLeft, mTop, Caption);
  DrawText(Canvas.Handle, PChar(Text), Length(Text), Rect, Flags);
  FreeAndNil (mSList);
end;
*)

procedure TxpUniComp.DoDrawText(var pRect:TRect; pFlags:Longint);
var
  Text: string;
begin
  Text := Caption;
  pFlags := DrawTextBiDiModeFlags(pFlags);
  Canvas.Font := Font;
  If not Enabled then begin
    OffsetRect(pRect, 1, 1);
    Canvas.Font.Color := clBtnHighlight;
    DrawText(Canvas.Handle, PChar(Text), Length(Text), pRect, pFlags);
    OffsetRect(pRect, -1, -1);
    Canvas.Font.Color := clBtnShadow;
    DrawText(Canvas.Handle, PChar(Text), Length(Text), pRect, pFlags);
  end else DrawText(Canvas.Handle, PChar(Text), Length(Text), pRect, pFlags);
end;

procedure TxpUniComp.PaintLabel;
const
  Alignments: array[TAlignment] of Word = (DT_LEFT, DT_RIGHT, DT_CENTER);
  WordWraps: array[Boolean] of Word = (0, DT_WORDBREAK);
var
  Rect, CalcRect: TRect;
  DrawStyle: Longint;
begin
  with Canvas do begin
    Brush.Color := Self.Color;
    Brush.Style := bsSolid;
    FillRect(ClientRect);
    Brush.Style := bsSolid;
    Rect := ClientRect;
    { DoDrawText takes care of BiDi alignments }
    DrawStyle := DT_EXPANDTABS or WordWraps[oWordWrap] or Alignments[FAlignment];
    { Calculate vertical layout }
    if oLayout <> tlTop then
    begin
      CalcRect := Rect;
      DoDrawText(CalcRect, DrawStyle or DT_CALCRECT);
      If oLayout = tlBottom
        then OffsetRect(Rect, 0, Height - CalcRect.Bottom)
        else OffsetRect(Rect, 0, (Height - CalcRect.Bottom) div 2);
    end;
    DoDrawText(Rect, DrawStyle);
  end;
end;

procedure TxpUniComp.PaintEdit;
var DC : hDC; Brush : hBrush; lBrush : TLogBrush; UpdateRect,mRect: TRect;
  AColor : TColor; Rgn : hRgn; mLeft:longint;
begin
  If oInfoField then begin
    Canvas.Brush.Color := oBGInfoField;
  end else begin
    If oReadOnly
      then Canvas.Brush.Color := oBGReadOnly
      else Canvas.Brush.Color := oBGNormal;
  end;
  Canvas.Pen.Color := Color;
  Canvas.Font := Font;
  case oEditorType of
    etString  : Caption := Name;
    etFloat   : Caption := StrDoub (0,0,FFrac);
    etInteger : Caption := '0';
    etDate    : Caption := DateToStr (oDateTime);
    etTime    : Caption := TimeToStr (oDateTime);
    etDateTime: Caption := DateTimeToStr (oDateTime);
  end;
  mLeft := 5;
  case FAlignment of
    taCenter      : begin
                      If oExtTextShow
                        then mLeft := (Width-Canvas.TextWidth(Caption)-32) div 2
                        else mLeft := (Width-Canvas.TextWidth(Caption)-2) div 2;
                    end;
    taRightJustify: begin
                      If oExtTextShow
                        then mLeft := Width-Canvas.TextWidth(Caption)-32
                        else mLeft := Width-Canvas.TextWidth(Caption)-2;
                    end;
  end;
  Canvas.TextOut (mLeft,2,Caption);
  DC := GetWindowDC (Handle);
  GetWindowRect (Handle, UpdateRect);
  OffsetRect (UpdateRect, - UpdateRect.Left, - UpdateRect.Top);
  Rgn := CreateRoundRectRgn (0,0,Width+1, Height+1, crcRadius, crcRadius);
  Brush := CreateSolidBrush (ColorToRGB (oInactBorder));
  FrameRgn (DC, Rgn, Brush, 1, 1);
  DeleteObject (Brush);
  DeleteObject (Rgn);
  Rgn := CreateRoundRectRgn (1,1,Width, Height, crcRadius, crcRadius);
  Brush := CreateSolidBrush (ColorToRGB (Color));
  FrameRgn (DC, Rgn, Brush, 1, 1);
  DeleteObject (Brush );
  ReleaseDC (Handle, DC);
  DeleteObject(Rgn);

  If oExtTextShow then begin
    Canvas.Brush.Color := oBGExtText;
    mRect.Left := Width-30+3;
    mRect.Top := 2;
    mRect.Right := Width-2;
    mRect.Bottom := Height-2;
    Canvas.FillRect(TRect(mRect));
    Canvas.Pen.Color := oBGExtText;
    Canvas.MoveTo(Width-30+1,1);
    Canvas.LineTo(Width-30+1,Height-1);
    Canvas.Brush.Color := clWhite;
    mRect.Left := Width-30+2;
    mRect.Top := 1;
    mRect.Right := Width-1;
    mRect.Bottom := Height-1;
    Canvas.FrameRect(TRect(mRect));
    Canvas.Pen.Color := oBGExtText;
  end;
end;

procedure TxpUniComp.PaintRadioButton;
var X1,Y1,X2,Y2 : Integer; mSize, mWidth:word; mLeft:word; mText:string;
    mChSize, mChWidth:word;
begin
  If oSystemColor then RefreshSystemColor;
  inherited;
  with Canvas do begin
    Brush.Color:=Self.Color;
    Brush.Style:=bsSolid;
    Font:=Self.Font;
    mText := ReplaceStr (Caption, '&', '');
    mSize := TextHeight(mText) div 2;
    mWidth := 1;
    If mSize>14 then mWidth := 2;
    If mSize<11 then mSize := 11;
    Brush.Color := oBorderColor;
    Pen.Color := oBorderColor;
    Ellipse(0,((Height - mSize) div 2), mSize, ((Height - mSize) div 2)+mSize);
    Brush.Color := clWhite;
    Pen.Color := clWhite;
    Ellipse(mWidth,((Height - mSize) div 2)+mWidth, mSize-mWidth, ((Height - mSize) div 2)+mSize-mWidth);
    Brush.Color := Color;
    Pen.Color := clBlack;
    If Checked then begin
      Brush.Color := clIccChBoxCheck;
      Pen.Color := clIccChBoxCheck;
      mChSize := TextHeight(Caption) div 2;
      mChWidth := 3;
      If mChSize>14 then mChWidth := 4;
      If mChSize<11 then mChSize := 11;
      Ellipse(mChWidth,((Height-mChSize) div 2)+mChWidth, mChSize-mChWidth, ((Height-mChSize) div 2)+mChSize-mChWidth);
    end;
    mLeft := TextWidth('A');
    If mLeft<13 then mLeft := 13;
    mLeft := mLeft+mLeft div 3;
//
    Brush.Style:=bsSolid;
    Font.Color := clBlack;
    TextOut(mLeft,(Height - TextHeight(mText)) div 2,mText);
    If Pos ('&', Caption) <> 0 then begin
      Canvas.Pen.Color := Canvas.Font.Color;
      Canvas.Pen.Width := 1;
      Canvas.MoveTo (mLeft + Canvas.TextWidth (Copy (mText, 1, Pos ('&', Caption)-1)),
                     (Height - Canvas.TextHeight (mText)) div 2+Canvas.TextHeight (mText)-2);
      Canvas.LineTo (mLeft + Canvas.TextWidth (Copy (mText, 1, Pos ('&', Caption))),
                     (Height - Canvas.TextHeight (mText)) div 2+Canvas.TextHeight (mText)-2);
    end;
  end;
end;

procedure TxpUniComp.PaintBitBtn (pLeft,pTop,pHeight,pWidth:longint);
var
  AText : array [1..10] of string;
  mS:string;
  I, mCnt:longint;
  AImageWidth : Integer;
  AImageHeigth : Integer;
  ACanvas : TBitmap;
  mTextX, mTextY:longint;
  mGlyphX, mGlyphY:longint;
  mMaxWidth:longint;
  mHeight: longint;   mX,mY:longint;
  mImagePos:longint;
begin

  If oSystemColor then RefreshSystemColor;
  ACanvas := TBitmap.Create;
  ACanvas.Canvas.Font.Assign (Font);
  ACanvas.Canvas.Brush.Style := bsClear;

  mS := Caption;
  If Pos ('&', Caption) <> 0 then Delete (mS, Pos ('&', mS), 1);
  mCnt := 0;
  mMaxWidth := 0;
  Repeat
    Inc (mCnt);
    If Pos ('#', mS)>0 then begin
      AText[mCnt] := Copy (mS, 1, Pos ('#', mS)-1);
      Delete (mS, 1, Pos ('#', mS));
    end else begin
      AText[mCnt] := mS;
      mS := '';
    end;
    If mMaxWidth<ACanvas.Canvas.TextWidth (AText[mCnt]) then mMaxWidth := ACanvas.Canvas.TextWidth (AText[mCnt]);
  until mS='';
  mHeight := (ACanvas.Canvas.TextHeight (AText[1]));
  If mCnt>1 then mHeight := mHeight+(ACanvas.Canvas.TextHeight (AText[1])+2)*(mCnt-1);

  try
    ACanvas.Width := ClientWidth;
    ACanvas.Height := ClientHeight;

    AImageWidth := FGlyph.Width;
    AImageHeigth := FGlyph.Height;
//VypoËÌta pozÌciu textu a obr·zku
    If Caption='' then begin
      mGlyphX := 8+(Width-8-8-AImageWidth) div 2 + Integer (FALSE);
      mGlyphY := 8+(Height-8-8-AImageHeigth) div 2 + Integer (FALSE);
    end else begin
      If FGlyph.Empty then begin
        case FAlignText of
          atLeft  : mTextX := 8+Integer (FALSE);
          atCenter: mTextX := 8+(Width-8-8-mMaxWidth) div 2 + Integer (FALSE);
          atRight : mTextX := Width-8-8+Integer (FALSE);
        end;
        mTextY := (Height - mHeight) div 2 + Integer (FALSE);
      end else begin
        case FButtLayout of
          blGlyphLeft  : begin
                           mGlyphX := 8+Integer (FALSE);
                           mGlyphY := 8+(Height-8-8-AImageHeigth) div 2 + Integer (FALSE);
                           mImagePos := AImageWidth+10;
                           case FAlignText of
                             atLeft  : mTextX := mImagePos+8+ Integer (FALSE);
                             atCenter: mTextX := 8+mImagePos+(Width-mImagePos-8-8-mMaxWidth) div 2 + Integer (FALSE);
                             atRight : mTextX := Width-mMaxWidth-8+Integer (FALSE);
                           end;
                           mTextY := 8+(Height-8-8-mHeight) div 2 + Integer (FALSE);
                         end;
          blGlyphRight : begin
                           mGlyphX := Width-8-AImageWidth-Integer (FALSE);
                           mGlyphY := 8+(Height-8-8-AImageHeigth) div 2 + Integer (FALSE);
                           mImagePos := AImageWidth+10;
                           case FAlignText of
                             atLeft  : mTextX := 8;
                             atCenter: mTextX := 8+(Width-mImagePos-8-8-mMaxWidth) div 2 + Integer (FALSE);
                             atRight : mTextX := Width-mImagePos-8-mMaxWidth-Integer (FALSE);
                           end;
                           mTextY := 8+(Height-8-8-mHeight) div 2 + Integer (FALSE);
                         end;
          blGlyphTop   : begin
                           mGlyphX := 8+(Width-8-8-AImageWidth) div 2 + Integer (FALSE);
                           mGlyphY := 8;
                           case FAlignText of
                             atLeft  : mTextX := 8;
                             atCenter: mTextX := 8+(Width-8-8-mMaxWidth) div 2 + Integer (FALSE);
                             atRight : mTextX := Width-mMaxWidth-8-Integer (FALSE);
                           end;
                           mTextY := 8+AImageHeigth+10+(Height-8-8-mHeight-AImageHeigth-10) div 2 + Integer (FALSE);
                         end;
          blGlyphBottom: begin
                           mGlyphX := 8+(Width-8-8-AImageWidth) div 2 + Integer (FALSE);
                           mGlyphY := Height-8-AImageHeigth;
                           case FAlignText of
                             atLeft  : mTextX := 8;
                             atCenter: mTextX := 8+(Width-8-8-mMaxWidth) div 2 + Integer (FALSE);
                             atRight : mTextX := Width-mMaxWidth-8-Integer (FALSE);
                           end;
                           mTextY := 8+(Height-8-8-mHeight-AImageHeigth-10) div 2 + Integer (FALSE);
                         end;
        end;
      end;
    end;

    ACanvas.Canvas.Pen.Color := clWhite;
    ACanvas.Canvas.Rectangle(0, 0, Width, Height);

    ACanvas.Canvas.Pen.Width := 1;
    ACanvas.Canvas.Brush.Style := bsSolid;
    ACanvas.Canvas.Brush.Color := oButColors.BackGroud;
    ACanvas.Canvas.Pen.Color := oButColors.BackGroud;
    ACanvas.Canvas.RoundRect (0, 0, Width, Height, 3, 3);

    ACanvas.Canvas.Brush.Style := bsClear;
    ACanvas.Canvas.Pen.Color := oButColors.ActBorder;
    ACanvas.Canvas.RoundRect (1, 1, Width-1, Height-1, 5, 5);

    GradientFillRect (ACanvas.Canvas, Rect (4, 4, Width-4, Height-4), oButColors.ButtonGradBeg,
         oButColors.ButtonGradEnd, fdTopToBottom, HeightOf (ClientRect) div 3);

    ACanvas.Canvas.Pen.Color := oButColors.ButtonFrameTop;
    ACanvas.Canvas.MoveTo (3, 2);
    ACanvas.Canvas.LineTo (Width - 3, 2);

    ACanvas.Canvas.Pen.Color := oButColors.ButtonFrameBot;
    ACanvas.Canvas.MoveTo (3, Height-3);
    ACanvas.Canvas.LineTo (Width - 3, Height-3);

    ACanvas.Canvas.Pen.Color := oButColors.ButtonFrame;
    ACanvas.Canvas.Rectangle (2, 3, Width-2, Height-3);

    ACanvas.Canvas.Pen.Color := clWhite;
    ACanvas.Canvas.MoveTo (3, 4);
    ACanvas.Canvas.LineTo (3, Height-4);

    ACanvas.Canvas.Pen.Color := clWhite;
    ACanvas.Canvas.MoveTo (Width-4, 4);
    ACanvas.Canvas.LineTo (Width-4, Height-4);

    ACanvas.Canvas.Pen.Color := clWhite;
    ACanvas.Canvas.MoveTo (3, Height-1);
    ACanvas.Canvas.LineTo (Width-3, Height-1);
    ACanvas.Canvas.MoveTo (Width-1, Height-4);
    ACanvas.Canvas.LineTo (Width-1, 2);


///////////////////////////////////////

//VykreslÌ obr·zok
      DrawBitmapTransparent (ACanvas.Canvas, mGlyphX, mGlyphY, FGlyph, FGlyph.Canvas.Pixels [0, 0]);

//VypÌöe text
      mY := 0;
      mX := 0;
      For I:=1 to mCnt do begin
        case FAlignText of
          atCenter: mX := (mMaxWidth-ACanvas.Canvas.TextWidth (AText[I])) div 2;
          atRight : mX := mMaxWidth-ACanvas.Canvas.TextWidth (AText[I]);
        end;
        ACanvas.Canvas.Font.Color := clLtGray;
        ACanvas.Canvas.Font.Color := oButColors.ButtonFontShad;
        ACanvas.Canvas.TextRect (Rect (4, 4, Width-4, Height-4), mX+mTextX + 1, mY+mTextY + 1, AText[I]);
        ACanvas.Canvas.Font.Color := oButColors.ButtonFont;
        ACanvas.Canvas.TextRect (Rect (4, 4, Width-4, Height-4), mX+mTextX, mY+mTextY, AText[I]);
        mY := mY+ACanvas.Canvas.TextHeight (AText[1])+2;
      end;

    If Pos ('&', Caption) <> 0 then begin
      ACanvas.Canvas.Pen.Color := ACanvas.Canvas.Font.Color;
      ACanvas.Canvas.Pen.Width := 1;
      ACanvas.Canvas.MoveTo (((Width - mMaxWidth) div 2) + ACanvas.Canvas.TextWidth (Copy (AText[1], 1, Pos ('&', Caption)-1)) + Integer (FALSE),
                     ((Height - mHeight) div 2) + ACanvas.Canvas.TextHeight (AText[1]) + Integer (FALSE));
      ACanvas.Canvas.LineTo (((Width - mMaxWidth) div 2) + ACanvas.Canvas.TextWidth (Copy (AText[1], 1, Pos ('&', Caption))) + Integer (FALSE),
                     ((Height - mHeight) div 2) + ACanvas.Canvas.TextHeight (AText[1]) + Integer (FALSE));
    end;

    BitBlt(Canvas.Handle, 0, 0, ACanvas.Width, ACanvas.Height, ACanvas.Canvas.Handle, 0, 0, SRCCOPY);
  finally
    ACanvas.Free;
  end;
end;
(*
procedure TxpUniComp.PaintCheckBox;
var AText:string;  mTextLeft:longint; CheckRect: TRect; mSize:longint;
begin
  Canvas.Brush.Color := Parent.Brush.Color;
  Canvas.Brush.Style := bsSolid;
  Canvas.FillRect(ClientRect);

  Canvas.Brush.Style := bsClear;
  Canvas.Pen.Style := psClear;

  mSize := Canvas.TextHeight ('A') div 4;
  If mSize<7 then mSize := 7;
  CheckRect := Rect (1, HeightOf (ClientRect) div 2 - mSize,
                     1+2*mSize, HeightOf (ClientRect) div 2 + mSize);

  GradientFillRect (Canvas, CheckRect, RGB (220, 220, 215), RGB (255, 255, 255),
    fdTopToBottom, 10);
  GradientFillRect (Canvas, CheckRect, clIccChBoxInactGradBeg, clIccChBoxInactGradEnd,
    fdTopToBottom, 10);

  Canvas.Pen.Width := 1;
  Canvas.Pen.Color := RGB (28, 81, 128);
  Canvas.Pen.Color := clIccActBorder;
  Canvas.Brush.Style := bsClear;
  Canvas.Rectangle (CheckRect.Left, CheckRect.Top, CheckRect.Right, CheckRect.Bottom);

  If FChecked then begin
    Canvas.Pen.Width := 3;
    Canvas.Pen.Color := clIccChBoxCheck;
    Canvas.MoveTo (CheckRect.Left + 3, CheckRect.Top+(CheckRect.Bottom-CheckRect.Top) div 2-1);
    Canvas.LineTo (CheckRect.Left+(CheckRect.Right-CheckRect.Left) div 3+1, CheckRect.Bottom - 5);
    Canvas.LineTo (CheckRect.Right-5, CheckRect.Top + 4);
  end;

  AText := Caption;
  If Pos ('&', Caption) <> 0 then Delete (AText, Pos ('&', AText), 1);

  mTextLeft := Canvas.TextHeight ('A') div 4;
  If mTextLeft<7 then mTextLeft := 7;
  mTextLeft := 12+2*mTextLeft;

  Canvas.Brush.Style := bsClear;
  Canvas.Font.Color := clLtGray;
  Canvas.TextOut(mTextLeft+1, (Height - Canvas.TextHeight (AText)) div 2+1, AText);

  //Text
  Canvas.Font.Color := Font.Color;
  Canvas.TextOut(mTextLeft, (Height - Canvas.TextHeight (AText)) div 2, AText);

  If Pos ('&', Caption) <> 0 then begin
    Canvas.Pen.Color := Canvas.Font.Color;
    Canvas.Pen.Width := 1;
    Canvas.MoveTo (mTextLeft + Canvas.TextWidth (Copy (AText, 1, Pos ('&', Caption)-1)),
                   (Height - Canvas.TextHeight (AText)) div 2+Canvas.TextHeight (AText)-1);
    Canvas.LineTo (mTextLeft + Canvas.TextWidth (Copy (AText, 1, Pos ('&', Caption))),
                   (Height - Canvas.TextHeight (AText)) div 2+Canvas.TextHeight (AText)-1);
  end;

  BitBlt(Canvas.Handle, 0, 0, Width, Height,Canvas.Handle, 0, 0, SRCCOPY); //SRCCOPY
end;

*)

procedure TxpUniComp.PaintCheckBox;
var
  AText : String;  mTextLeft:longint;
  ACanvas : TBitmap;
  CheckRect: TRect; mSize:longint;
begin
  If oSystemColor then RefreshSystemColor;
  ACanvas := TBitmap.Create;

  try
    ACanvas.Width := ClientWidth;
    ACanvas.Height := ClientHeight;

  If ParentColor
    then ACanvas.Canvas.Brush.Assign (Parent.Brush)
    else ACanvas.Canvas.Brush.Color := Color;

  ACanvas.Canvas.Brush.Style := bsSolid;
  ACanvas.Canvas.Pen.Style := psClear;
  ACanvas.Canvas.FillRect (ClientRect);

// CheckArea
  ACanvas.Canvas.Font.Assign (Font);
  mSize := ACanvas.Canvas.TextHeight ('A') div 4;
  If mSize<7 then mSize := 7;
  CheckRect := Rect (1, HeightOf (ClientRect) div 2 - mSize,
                     1+2*mSize, HeightOf (ClientRect) div 2 + mSize);

  GradientFillRect (ACanvas.Canvas, CheckRect, RGB (220, 220, 215), RGB (255, 255, 255), fdTopToBottom, 10);
  GradientFillRect (ACanvas.Canvas, CheckRect, oInactGradBeg, oInactGradEnd, fdTopToBottom, 10);

  ACanvas.Canvas.Pen.Width := 1;
  ACanvas.Canvas.Pen.Color := oActBorder;
  ACanvas.Canvas.Brush.Style := bsClear;
  ACanvas.Canvas.Rectangle (CheckRect.Left, CheckRect.Top, CheckRect.Right, CheckRect.Bottom);

  If FChecked then begin
    ACanvas.Canvas.Pen.Width := 3;
    ACanvas.Canvas.Pen.Color := oCheckColor;
    ACanvas.Canvas.MoveTo (CheckRect.Left + 3, CheckRect.Top+(CheckRect.Bottom-CheckRect.Top) div 2-1);
    ACanvas.Canvas.LineTo (CheckRect.Left+(CheckRect.Right-CheckRect.Left) div 3+1, CheckRect.Bottom - 5);
    ACanvas.Canvas.LineTo (CheckRect.Right-5, CheckRect.Top + 4);
  end;

//*************

  AText := Caption;
  If Pos ('&', Caption) <> 0 then Delete (AText, Pos ('&', AText), 1);

  ACanvas.Canvas.Font.Assign (Font);
  mTextLeft := ACanvas.Canvas.TextHeight ('A') div 4;
  If mTextLeft<7 then mTextLeft := 7;
  mTextLeft := 12+2*mTextLeft;

  If not Enabled then ACanvas.Canvas.Font.Color := clGray;

  ACanvas.Canvas.Brush.Style := bsClear;

  ACanvas.Canvas.Font.Color := Font.Color;
  ACanvas.Canvas.TextOut(mTextLeft, (Height - ACanvas.Canvas.TextHeight (AText)) div 2, AText);

  If Pos ('&', Caption) <> 0 then begin
    ACanvas.Canvas.Pen.Color := ACanvas.Canvas.Font.Color;
    ACanvas.Canvas.Pen.Width := 1;
    ACanvas.Canvas.MoveTo (mTextLeft + ACanvas.Canvas.TextWidth (Copy (AText, 1, Pos ('&', Caption)-1)),
                   (Height - ACanvas.Canvas.TextHeight (AText)) div 2+ACanvas.Canvas.TextHeight (AText)-1);
    ACanvas.Canvas.LineTo (mTextLeft + ACanvas.Canvas.TextWidth (Copy (AText, 1, Pos ('&', Caption))),
                   (Height - ACanvas.Canvas.TextHeight (AText)) div 2+ACanvas.Canvas.TextHeight (AText)-1);
  end;

  BitBlt(Canvas.Handle, 0, 0, ACanvas.Width, ACanvas.Height, ACanvas.Canvas.Handle, 0, 0, SRCCOPY); //SRCCOPY

  finally
    ACanvas.Free;
  end;
end;

(*
procedure TxpUniComp.PaintComboBox;
var
  DC : hDC;
  Pen : hPen;
  Brush : hBrush;
  UpdateRect : TRect;
  AButtonRect: TRect;
  BoundRect : TRect;
begin
  Color := clWhite;
  GetWindowRect (Handle, BoundRect);
  OffsetRect (BoundRect, - BoundRect.Left, - BoundRect.Top);

  GetWindowRect (Handle, BoundRect);
  OffsetRect (BoundRect, - BoundRect.Left, - BoundRect.Top);

  DC := GetWindowDC (Handle);
  Brush := CreateSolidBrush (ColorToRGB (clIccInactBorder));
  try
    FrameRect (DC, BoundRect, Brush);
  finally
    DeleteObject (Brush);
  end;

  GetWindowRect (Handle, UpdateRect);
  OffsetRect (UpdateRect, - UpdateRect.Left, - UpdateRect.Top);

  AButtonRect := Rect (UpdateRect.Right - 20 - 2, UpdateRect.Top+1,UpdateRect.Right- 1, UpdateRect.Bottom-1);
  Canvas.Brush.Color := Color;
  Canvas.Pen.Color := Color;
  Canvas.FillRect (AButtonRect);

  Inc (AButtonRect.Top);
  Dec (AButtonRect.Bottom);
  Dec (AButtonRect.Right);

  Canvas.Brush.Color := $00EED2C1;
  Canvas.Pen.Color := MakeDarkColor ($00EED2C1, 20);
  Canvas.RoundRect (AButtonRect.Left, AButtonRect.Top, AButtonRect.Right, AButtonRect.Bottom, 2, 2);
  InflateRect (AButtonRect, -2, -2);
  GradientFillRect (Canvas, AButtonRect, $00EED2C1, MakeDarkColor ($00EED2C1, 10), fdTopToBottom, 5);

  //Arrow drawing
  Canvas.Pen.Color := clNavy;
  Canvas.MoveTo ((AButtonRect.Right + AButtonRect.Left - 5) div 2, (AButtonRect.Top + AButtonRect.Bottom) div 2);
  Canvas.LineTo ((AButtonRect.Right + AButtonRect.Left - 5) div 2 + 5, (AButtonRect.Top + AButtonRect.Bottom) div 2);
  Canvas.MoveTo ((AButtonRect.Right + AButtonRect.Left - 5) div 2+1, (AButtonRect.Top + AButtonRect.Bottom) div 2+1);
  Canvas.LineTo ((AButtonRect.Right + AButtonRect.Left - 5) div 2 + 4, (AButtonRect.Top + AButtonRect.Bottom) div 2+1);
  Canvas.MoveTo ((AButtonRect.Right + AButtonRect.Left - 5) div 2+2, (AButtonRect.Top + AButtonRect.Bottom) div 2+2);
  Canvas.LineTo ((AButtonRect.Right + AButtonRect.Left - 5) div 2 + 3, (AButtonRect.Top + AButtonRect.Bottom) div 2+2);

  Canvas.Brush.Color := Color;
  Canvas.Font.Color := Font.Color;
  Canvas.TextOut(4, 4, Caption);
  ReleaseDC (Handle, DC);
end;
*)

procedure TxpUniComp.PaintComboBox;
var
  DC : hDC;
  Pen : hPen;
  Brush : hBrush;
  BoundRect, UpdateRect, AButtonRect: TRect;
  Bmp : TBitmap;
begin
  If oSystemColor then RefreshSystemColor;

  Color := oBackColor;
  DC := GetWindowDC (Handle);
  GetWindowRect (Handle, UpdateRect);
  OffsetRect (UpdateRect, - UpdateRect.Left, - UpdateRect.Top);

  GetWindowRect (Handle, BoundRect);
  OffsetRect (BoundRect, - BoundRect.Left, - BoundRect.Top);
  Brush := CreateSolidBrush (ColorToRGB (oInactBorder));
  try
    FrameRect (DC, BoundRect, Brush);
  finally
    DeleteObject (Brush);
  end;
  AButtonRect := Rect (UpdateRect.Right - 20 - 2, UpdateRect.Top+1,UpdateRect.Right- 1, UpdateRect.Bottom-1);
  Canvas.Brush.Color := Color;
  Canvas.Pen.Color := Color;
  Canvas.FillRect (AButtonRect);
  Inc (AButtonRect.Top);
  Dec (AButtonRect.Bottom);
  Dec (AButtonRect.Right);

  Canvas.Brush.Color := oInactBorder;
  Canvas.Pen.Color := MakeDarkColor (oInactBorder, 20);
  Canvas.RoundRect (AButtonRect.Left, AButtonRect.Top, AButtonRect.Right, AButtonRect.Bottom, 2, 2);
  InflateRect (AButtonRect, -2, -2);
  GradientFillRect (Canvas, AButtonRect, oInactBorder, MakeDarkColor (oInactBorder, 10), fdTopToBottom, 5);

  //Arrow drawing
  Canvas.Pen.Color := oActBorder;
  Canvas.MoveTo ((AButtonRect.Right + AButtonRect.Left - 5) div 2, (AButtonRect.Top + AButtonRect.Bottom) div 2);
  Canvas.LineTo ((AButtonRect.Right + AButtonRect.Left - 5) div 2 + 5, (AButtonRect.Top + AButtonRect.Bottom) div 2);
  Canvas.MoveTo ((AButtonRect.Right + AButtonRect.Left - 5) div 2+1, (AButtonRect.Top + AButtonRect.Bottom) div 2+1);
  Canvas.LineTo ((AButtonRect.Right + AButtonRect.Left - 5) div 2 + 4, (AButtonRect.Top + AButtonRect.Bottom) div 2+1);
  Canvas.MoveTo ((AButtonRect.Right + AButtonRect.Left - 5) div 2+2, (AButtonRect.Top + AButtonRect.Bottom) div 2+2);
  Canvas.LineTo ((AButtonRect.Right + AButtonRect.Left - 5) div 2 + 3, (AButtonRect.Top + AButtonRect.Bottom) div 2+2);

  ReleaseDC (Handle, DC);
end;

procedure TxpUniComp.PaintSelect;
begin
  If oSelected then begin
    If cUniMultiSelect
      then Canvas.Brush.Color := clSilver
      else begin
        Canvas.Brush.Color := clBlack;
        Canvas.FillRect(Rect((Width div 2)-2,0,(Width div 2)+3,5));
        Canvas.FillRect(Rect((Width div 2)-2,Height-5,(Width div 2)+3,Height));
        Canvas.FillRect(Rect(0,(Height div 2)-2,5,(Height div 2)+3));
        Canvas.FillRect(Rect(Width-5,(Height div 2)-2,Width,(Height div 2)+3));
      end;

    Canvas.FillRect(Rect(0,0,5,5));
    Canvas.FillRect(Rect(0,Height-5,5,Height));
    Canvas.FillRect(Rect(Width-5,0,Width,5));
    Canvas.FillRect(Rect(Width-5,Height-5,Width,Height));
    Canvas.Brush.Color := Color;
  end;
end;

procedure TxpUniComp.PaintEditButt;
begin
  Color := Parent.Brush.Color;
  Canvas.Pen.Width := 1;
  Canvas.Brush.Style := bsSolid;
  Canvas.Brush.Color := clWhite;
  Canvas.Pen.Color := clIccInactBorder;
  Canvas.RoundRect (0, 1, Width-Height, Height-1, 5, 5);
  PaintBitBtn(Width-Height,0,Height,Height);
end;

procedure TxpUniComp.PaintMemo;
var  Rgn: hRgn;  mBrush: HBrush; DC: hDC; mLeft,mTop:longint;
begin
  DC := GetWindowDC (Handle);
  Color := oBGNormal;
  Canvas.Brush.Style := bsClear;
  Canvas.Pen.Color := oBGNormal;
  Canvas.Rectangle(1,1,Width-1,Height-1);
  Canvas.Rectangle(2,2,Width-2,Height-2);
  Rgn := CreateRoundRectRgn (0,0,Width+1, Height+1, 2, 2);
  mBrush := CreateSolidBrush (ColorToRGB (oActBorder));
  FrameRgn (DC, Rgn, mBrush, 1, 1);
  DeleteObject (mBrush);
  DeleteObject (Rgn);
  ReleaseDC (Handle, DC);

  Canvas.Font := Font;
  mLeft := (Width-Canvas.TextWidth(Caption)) div 2;
  mTop := 1+(Height-Canvas.TextHeight(Caption)) div 2;
  Canvas.TextOut (mLeft, mTop, Caption);
end;

procedure TxpUniComp.PaintRichEdit;
var  Rgn: hRgn;  mBrush: HBrush; DC: hDC; mLeft,mTop:longint;
begin
  DC := GetWindowDC (Handle);
  Color := oBGNormal;
  Canvas.Brush.Style := bsClear;
  Canvas.Pen.Color := clIccBG;
  Canvas.Rectangle(1,1,Width-1,Height-1);
  Canvas.Rectangle(2,2,Width-2,Height-2);
  Rgn := CreateRoundRectRgn (0,0,Width+1, Height+1, 2, 2);
  mBrush := CreateSolidBrush (ColorToRGB (oActBorder));
  FrameRgn (DC, Rgn, mBrush, 1, 1);
  DeleteObject (mBrush);
  DeleteObject (Rgn);
  ReleaseDC (Handle, DC);

  Canvas.Font.Color := clBlack;
  mLeft := (Width-Canvas.TextWidth(Caption)) div 2;
  mTop := 1+(Height-Canvas.TextHeight(Caption)) div 2;
  Canvas.TextOut (mLeft, mTop, Caption);
end;

procedure TxpUniComp.PaintBasic;
var mLeft,mTop:longint;
begin
  Canvas.Pen.Width := 1;
  Canvas.Brush.Style := bsSolid;
  Canvas.Brush.Color := clWhite;
  Canvas.Pen.Color := clBlack;
  Canvas.Rectangle (0, 0, Width, Height);

  mLeft := (Width-Canvas.TextWidth(Caption)) div 2;
  mTop := 1+(Height-Canvas.TextHeight(Caption)) div 2;
  Canvas.TextOut (mLeft, mTop, Caption);
end;

procedure TxpUniComp.SetAlignment (pValue:TAlignment);
begin
  FAlignment := pValue;
  Repaint;
end;

procedure TxpUniComp.SetLayout (pValue:TTextLayout);
begin
  oLayout := pValue;
  Repaint;
end;

procedure TxpUniComp.SetButtLayout (AValue : TButtonLayout);
begin
  If FButtLayout <> AValue then begin
    FButtLayout := AValue;
    Repaint;
  end;
end;

procedure TxpUniComp.SetGlyph (AGlyph : TBitmap);
begin
  FGlyph.Assign (AGlyph as TBitmap);
  Invalidate;
end;

function  TxpUniComp.GetGlyph : TBitmap;
begin
  Result := FGlyph as TBitmap;
end;

procedure TxpUniComp.SetBasicColor (pColor:TColor);
begin
  oBasicColor := pColor;
  case oCompType of
    ucEditor  : begin
                  Color := clIccEditorBGNormal;
                  oBGNormal := clIccEditorBGNormal;
                  oBGReadOnly := IccCompHueColor (oBasicColor, TclIccEditorBGReadOnly);
                  oBGInfoField := IccCompHueColor (oBasicColor, TclIccEditorBGInfoField);
                  oBGActive := IccCompHueColor (oBasicColor, TclIccBGActive);
                  oBGModify := IccCompHueColor (oBasicColor, TclIccBGModify);
                  oBGExtText := IccCompHueColor (oBasicColor, TclIccEditorBGExtText);
                  oInactBorder := IccCompHueColor (oBasicColor, TclIccInactBorder);
                  oActBorder := IccCompHueColor (oBasicColor, TclIccActBorder);
                  Font.Color := clIccEditorFont;
                end;
    ucButton  : begin
                  oButColors.ActBorder       := IccCompHueColor (oBasicColor, TclIccActBorder);
                  oButColors.BackGroud       := clIccBG;
                  oButColors.ButtonFrameTop  := IccCompHueColor (oBasicColor, TclIccButtonFrameTop);
                  oButColors.ButtonFrame     := IccCompHueColor (oBasicColor, TclIccButtonFrame);
                  oButColors.ButtonFrameBot  := IccCompHueColor (oBasicColor, TclIccButtonFrameBot);
                  oButColors.ButtonGradBeg   := IccCompHueColor (oBasicColor, TclIccButtonGradBeg);
                  oButColors.ButtonGradEnd   := IccCompHueColor (oBasicColor, TclIccButtonGradEnd);
                  oButColors.ButtonFont      := IccCompHueColor (oBasicColor, TclIccButtonFont);
                  oButColors.ButtonFontShad  := clIccButtonFontShad;
                  oButColors.ButtonFontDis   := clIccButtonFontDis;
                  oButColors.ButtonSelected  := clIccButtonSelected;
                  oButColors.ButtonBorderDis := clIccButtonBorderDis;
                  oButColors.ButtonDis       := clIccButtonDis;
                  Font.Color := oButColors.ButtonFont;
                end;
      ucRadioButton : begin
                        oBorderColor := IccCompHueColor (oBasicColor, TclIccInactBorder);
                        oGradBeg := IccCompHueColor (oBasicColor, TclIccChBoxActGradBeg);
                        oGradEnd := IccCompHueColor (oBasicColor, TclIccChBoxActGradEnd);
                      end;
      ucCheckBox    : begin
                        oCheckColor := clIccChBoxCheck;
                        oActGradBeg := IccCompHueColor (oBasicColor, TclIccChBoxActGradBeg);
                        oActGradEnd := IccCompHueColor (oBasicColor, TclIccChBoxActGradEnd);
                        oDownGradBeg := IccCompHueColor (oBasicColor, TclIccChBoxDownGradBeg);
                        oDownGradEnd := IccCompHueColor (oBasicColor, TclIccChBoxDownGradEnd);
                        oInactGradBeg := IccCompHueColor (oBasicColor, TclIccChBoxInactGradBeg);
                        oInactGradEnd := IccCompHueColor (oBasicColor, TclIccChBoxInactGradEnd);
                        oActBorder := IccCompHueColor (oBasicColor, TclIccActBorder);
                      end;
      ucComboBox    : begin
                        oActBorder := IccCompHueColor (oBasicColor, TclIccActBorder);
                        oInactBorder := IccCompHueColor (oBasicColor, TclIccInactBorder);
                        oBackColor  := IccCompHueColor (oBasicColor, TclIccBG);
                      end;
      ucMemo        : begin
                       oBGNormal := IccCompHueColor (oBasicColor, TclIccBG);
                       oInactBorder := IccCompHueColor (oBasicColor, TclIccInactBorder);
                       oActBorder := IccCompHueColor (oBasicColor, TclIccActBorder);
                      end;
      ucRichEdit    : begin
                       oBGNormal := IccCompHueColor (oBasicColor, TclIccBG);
                       oInactBorder := IccCompHueColor (oBasicColor, TclIccInactBorder);
                       oActBorder := IccCompHueColor (oBasicColor, TclIccActBorder);
                      end;

  end;
end;

procedure TxpUniComp.SetCheckColor (pColor:TColor);
begin
  oCheckColor := pColor;
end;

procedure TxpUniComp.SetTransparent (pValue:boolean);
begin
  oTransparent := pValue;
(*  If pValue
    then ControlStyle := ControlStyle - [csOpaque]
    else ControlStyle := ControlStyle + [csOpaque];
  Invalidate;*)
end;

procedure TxpUniComp.SetAutoSize (pValue:boolean);

  procedure AdjustBounds;
  const
    WordWraps: array[Boolean] of Word = (0, DT_WORDBREAK);
  var
    DC: HDC;
    X: Integer;
    Rect: TRect;
    AAlignment: TAlignment;
  begin
    If not (csReading in ComponentState) and oAutoSize then begin
      Rect := ClientRect;
      DC := GetDC(0);
      Canvas.Handle := DC;
      DoDrawText(Rect, (DT_EXPANDTABS or DT_CALCRECT) or WordWraps[oWordWrap]);
      Canvas.Handle := 0;
      ReleaseDC(0, DC);
      X := Left;
      AAlignment := FAlignment;
      If UseRightToLeftAlignment then ChangeBiDiModeAlignment(AAlignment);
      If AAlignment = taRightJustify then Inc(X, Width - Rect.Right);
      SetBounds(X, Top, Rect.Right, Rect.Bottom);
    end;
  end;

begin
  oAutoSize := pValue;
  AdjustBounds;
end;

procedure TxpUniComp.RefreshSystemColor;
begin
  case oCompType of
    ucLabel        : begin
                     end;
    ucEditor       : begin
                       oBGNormal    := clIccEditorBGNormal;
                       oBGReadOnly  := clIccEditorBGReadOnly;
                       oBGInfoField := clIccEditorBGInfoField;
                       oBGActive    := clIccBGActive;
                       oBGModify    := clIccBGModify;
                       oBGExtText   := clIccEditorBGExtText;
                       oInactBorder := clIccInactBorder;
                       oActBorder   := clIccActBorder;
                       Font.Color := clIccEditorFont;
                     end;
    ucRadioButton  : begin
                       oCheckColor := clIccChBoxCheck;
                       oBorderColor := clIccInactBorder;
                       oGradBeg := clIccChBoxActGradBeg;
                       oGradEnd := clIccChBoxActGradEnd;
                     end;
    ucCheckBox     : begin
                       oCheckColor := clIccChBoxCheck;
                       oActGradBeg := clIccChBoxActGradBeg;
                       oActGradEnd := clIccChBoxActGradEnd;
                       oDownGradBeg := clIccChBoxDownGradBeg;
                       oDownGradEnd := clIccChBoxDownGradEnd;
                       oInactGradBeg := clIccChBoxInactGradBeg;
                       oInactGradEnd := clIccChBoxInactGradEnd;
                       oActBorder := clIccActBorder;
                     end;
    ucComboBox     : begin
                       oActBorder := clIccActBorder;
                       oInactBorder := clIccInactBorder;
                       oBackColor  := clIccBG;
                     end;
    ucBookList     : begin
                     end;
    ucSelectionList: begin
                     end;
    ucButton       : begin
                       Font.Color := clIccButtonFont;
                       oButColors.ActBorder       := clIccActBorder;
                       oButColors.BackGroud       := clIccBG;
                       oButColors.ButtonFrameTop  := clIccButtonFrameTop;
                       oButColors.ButtonFrame     := clIccButtonFrame;
                       oButColors.ButtonFrameBot  := clIccButtonFrameBot;
                       oButColors.ButtonGradBeg   := clIccButtonGradBeg;
                       oButColors.ButtonGradEnd   := clIccButtonGradEnd;
                       oButColors.ButtonFont      := clIccButtonFont;
                       oButColors.ButtonFontShad  := clIccButtonFontShad;
                       oButColors.ButtonFontDis   := clIccButtonFontDis;
                       oButColors.ButtonSelected  := clIccButtonSelected;
                       oButColors.ButtonBorderDis := clIccButtonBorderDis;
                       oButColors.ButtonDis       := clIccButtonDis;
                     end;
    ucMemo         : begin
                       oBGNormal := clIccBG;
                       oInactBorder := clIccInactBorder;
                       oActBorder := clIccActBorder;
                       Font.Color := clIccMemoFont;
                     end;
    ucRichEdit     : begin
                       oBGNormal := clIccBG;
                       oInactBorder := clIccInactBorder;
                       oActBorder := clIccActBorder;
                       Font.Color := clIccMemoFont;
                     end;
    ucBasic        : begin
                     end;
  end;
end;

procedure TxpUniComp.WMPaint(var Message: TWMPaint);
begin
(*  If oTransparent then begin
    Brush.Style:= bsClear;
    SetWindowlong(Handle, GWL_EXSTYLE, WS_EX_TRANSPARENT);
  end;
*)  
  inherited;
  If oSystemColor then RefreshSystemColor;
  If oCompType=ucLabel then PaintLabel;
  If oCompType=ucEditor then PaintEdit;
  If oCompType=ucRadioButton then PaintRadioButton;
  If oCompType=ucButton then PaintBitBtn (0, 0, Height, Width);
  If oCompType=ucCheckBox then PaintCheckBox;
  If oCompType=ucComboBox then PaintComboBox;
  If (oCompType in [ucBookList,ucSelectionList]) then PaintEditButt;
  If oCompType=ucMemo then PaintMemo;
  If oCompType=ucRichEdit then PaintRichEdit;
  If oCompType=ucBasic then PaintBasic;
  PaintSelect;
end;

constructor TxpUniComp.Create (AOwner : TComponent);
begin
  inherited;
  FGlyph := TBitmap.Create;
  FGlyph.TransparentMode := tmAuto;
  FGlyph.Transparent := TRUE;
  oBasicColor := cbcBasicColor;
  ParentFont := FALSE;
  oDateTime := Now;
end;

destructor TxpUniComp.Destroy;
begin
  FGlyph.Free;
  inherited;
end;


procedure Register;
begin
  RegisterComponents('xpComp', [TxpEdit]);
  RegisterComponents('xpComp', [TxpBitBtn]);
  RegisterComponents('xpComp', [TxpLabel]);
  RegisterComponents('xpComp', [TxpCheckBox]);
  RegisterComponents('xpComp', [TDataTable]);
  RegisterComponents('xpComp', [TxpComboBox]);
  RegisterPropertyEditor(TypeInfo(string), TxpEdit, 'FieldName', TFieldNameProperty);
  RegisterPropertyEditor(TypeInfo(string), TxpEdit, 'ExtFieldName', TFieldNameProperty);
  RegisterPropertyEditor(TypeInfo(string), TxpLabel, 'FieldName', TFieldNameProperty);
  RegisterPropertyEditor(TypeInfo(string), TxpCheckBox, 'FieldName', TFieldNameProperty);
  RegisterPropertyEditor(TypeInfo(string), TxpComboBox, 'FieldName', TFieldNameProperty);
  RegisterPropertyEditor(TypeInfo(string), TxpRadioButton, 'FieldName', TFieldNameProperty);
  RegisterPropertyEditor(TypeInfo(string), TxpMemo, 'FieldName', TFieldNameProperty);

  RegisterClasses([TxpTabSheet]);
  RegisterComponents ('xpComp', [TxpPageControl]);
  RegisterComponentEditor(TxpPageControl, TxpPageControlEditor);
  RegisterComponentEditor(TxpTabSheet, TxpPageControlEditor);

  RegisterComponents('xpComp', [TxpSinglePanel]);
  RegisterComponents('xpComp', [TxpPanel]);
  RegisterComponents('xpComp', [TxpGroupBox]);
  RegisterComponents('xpComp', [TxpRadioButton]);
  RegisterComponents('xpComp', [TxpMemo]);
  RegisterComponents('xpComp', [TxpStatusLine]);
  RegisterComponents('xpComp', [TColorStringGrid]);
  RegisterComponents('xpComp', [TxpRichEdit]);
  RegisterComponents('xpComp', [TFixMinPanel]);
end;


end.
