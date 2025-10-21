unit IcEditors;

interface

uses
  BarCode, IcDate, Variants, TxtCut, NexText, IcLabels,
  IcTypes, IcConv, IcTools, IcText, IcVariab, IcStand, CmpTools, NexBtrTable,
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls, ExtCtrls, ComCtrls, Buttons;

type
  // Vseobecny editor textov
  TNameEdit = class(TEdit)
  private
    FAlignment: TAlignment;
    eOnEnter: TNotifyEvent;
    eOnExit: TNotifyEvent;
    eOnShowLst: TNotifyEvent;
    oStatusLine: TStatusLine;
    oFixedFont: boolean;
    oBefText: TCaption;
    oColor: TColor; // Na zapametanie farby aby po opusteni bolo mozne nastavit povodnu farbu editoru

    procedure MyOnEnter (Sender: TObject);
    procedure MyOnExit (Sender: TObject);
    procedure MyKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure MyOnShowLst (Sender:TObject);
  protected
    procedure KeyDown(var Key: Word; Shift: TShiftState); override;
    procedure CreateParams(var Params: TCreateParams); override;
    procedure SetAlignment(Value: TAlignment);
  public
    function GetControlsAlignment: TAlignment; override;
    constructor Create(AOwner: TComponent); override;
    procedure SetText (pText:TCaption);
    function GetText:TCaption;
    function GetChanged: boolean;
  published
    property Alignment: TAlignment read FAlignment write SetAlignment default taLeftJustify;
    property StatusLine: TStatusLine read oStatusLine write oStatusLine;
    property FixedFont: boolean read oFixedFont write oFixedFont;

    property Text: TCaption read GetText write SetText;
    property Changed: boolean read GetChanged;

    property OnEnter: TNotifyEvent read eOnEnter write eOnEnter;
    property OnExit: TNotifyEvent read eOnExit write eOnExit;
    property OnShowLst: TNotifyEvent read eOnShowLst write eOnShowLst;
  end;

  // Editor pre cele cisla
  TLongEdit = class(TNameEdit)
    procedure SetLong(pValue: longint);
    function  GetLong: longint;
    procedure SetBefLong(pValue: longint);
    function  GetBefLong: longint;
  public
    constructor Create(AOwner: TComponent); override;
  published
    property Long: longint read GetLong write SetLong;
    property BefLong: longint read GetBefLong write SetBefLong;
  end;

  // Editor pre ciarovy kod
  TBarCodeEdit = class(TNameEdit)
  private
    eOnExit: TNotifyEvent;
    oVerifyCheckSum:boolean;

    procedure MyOnExit (Sender: TObject);
  public
    constructor Create(AOwner: TComponent); override;
  published
    property OnExit: TNotifyEvent read eOnExit write eOnExit;
    property VerifyCheckSum:boolean read oVerifyCheckSum write oVerifyCheckSum;
  end;

  // Editor pre spojeny zaznam Code + Name
  TCodeEdit = class(TWinControl)
    E_Code: TLongEdit;
    Bevel: TBevel;
    L_Name: TLabel;
    B_Slct: TSpeedButton;
  private
    oStatusLine: TStatusLine;
    oLastCode  :string;
    eOnEnter: TNotifyEvent;
    eOnKeyDown: TKeyEvent;
    eOnAddItem: TNotifyEvent;
    eOnModItem: TNotifyEvent;
    eOnChanged: TNotifyEvent;
    eOnShowLst: TNotifyEvent;
    eOnExit: TNotifyEvent;
    procedure SetLong(pValue: longint);
    function  GetLong: longint;
    procedure SetBefLong(pValue: longint);
    function  GetBefLong: longint;
    procedure SetCode(pValue: Str15);
    function  GetCode: Str15;
    procedure SetText(pValue: Str30);
    function  GetText: Str30;
    function  GetChanged: boolean;
    procedure MyKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure MyOnEnter (Sender: TObject);
    procedure MyOnAddItem (Sender: TObject);
    procedure MyOnModItem (Sender: TObject);
    procedure MyOnShowLst (Sender: TObject);
    procedure MyOnExit (Sender: TObject);
  public
    oDataSet: TNexBtrTable;
    oCodeField: Str20;
    oNameField: Str20;
    oDgdName: string;   // Nazov Grid suboru kde su nastavenia
    oKeyNum: word;      // Index podla ktoreho sa hlada oCodeField
    oSearch: boolean;   // Ak je true program hlada zadany kod v databaze DataSet
    oFixedFont: boolean; // Ak je TRUE program pouz9va nastavenia fontov z DFM v opacnom pripade sa pouzivaju systemove nastavenia fontov gvSys
    oFixedPos: boolean; // Ak je TRUE potom kurzor databzaoveho suboru zostane zafixovany v opacnom pripade nastavi sa na identifikovany riadok
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
    procedure Loaded; override;
    procedure SetFocus; override;
  published
    property DataSet: TNexBtrTable read oDataSet write oDataSet;
    property BefLong: longint read GetBefLong write SetBefLong;
    property Long: longint read GetLong write SetLong;
    property Code: Str15 read GetCode write SetCode;
    property Text: Str30 read GetText write SetText;
    property Search: boolean read oSearch write oSearch;
    property CodeField: Str20 read oCodeField write oCodeField;
    property NameField: Str20 read oNameField write oNameField;
    property KeyNum: word read oKeyNum write oKeyNum;
    property StatusLine: TStatusLine read oStatusLine write oStatusLine;
    property DgdName: string read oDgdName write oDgdName;
    property FixedFont: boolean read oFixedFont write oFixedFont;
    property FixedPos: boolean read oFixedPos write oFixedPos;
    property Changed: boolean read GetChanged;
    property TabOrder;
    property Anchors;
    {Events}
    property OnExit: TNotifyEvent read eOnExit write eOnExit;
    property OnEnter: TNotifyEvent read eOnEnter write eOnEnter;
    property OnKeyDown: TKeyEvent read eOnKeyDown write eOnKeyDown;
    property OnAddItem: TNotifyEvent read eOnAddItem write eOnAddItem;
    property OnModItem: TNotifyEvent read eOnModItem write eOnModItem;
    property OnChanged: TNotifyEvent read eOnChanged write eOnChanged;
    property OnShowLst: TNotifyEvent read eOnShowLst write eOnShowLst;
  end;

  // Editor pre Spojene nazvy FirstCode,LastCode + Name
  TEditType = (cePartner,ceAccanl);

  TDblCodeEdit = class(TWinControl)
    E_Code1: TNameEdit;
    E_Code2: TNameEdit;
    Bevel: TBevel;
    L_Text: TSpecLabel;
    B_Slct: TSpeedButton;
  private
    oLastVal1:string;
    oLastVal2:string;
    oEditType: TEditType;
    oStatusLine: TStatusLine;
    eOnEnter: TNotifyEvent;
    eOnExit: TNotifyEvent;
    eOnKeyDown: TKeyEvent;
    eOnChanged: TNotifyEvent;
    procedure SetLong1(pValue: longint);
    function  GetLong1: longint;
    procedure SetLong2(pValue: longint);
    function  GetLong2: longint;
    procedure SetCode1(pValue: string);
    function  GetCode1: string;
    procedure SetCode2(pValue: string);
    function  GetCode2: string;
    procedure SetText(pValue: string);
    function  GetText: string;
    procedure SetEditType(pValue: TEditType);
    procedure MyKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure MyOnEnter (Sender: TObject);
    procedure MyOnExit (Sender: TObject);
    procedure SearchData;
    procedure ShowViewForm (Sender: TObject);
  public
    oDataSet: TNexBtrTable;
    oFieldNameCode1: string;
    oFieldNameCode2: string;
    oFieldNameText: string;
    oDgdName: string;   // Nazov Grid suboru kde su nastavenia
    oKeyNum: word;      // Index podla ktoreho sa hlada oCodeField
    oSearch: boolean;   // Ak je true program hlada zadany kod v databaze DataSet
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
    procedure Loaded; override;
  published
    property DataSet: TNexBtrTable read oDataSet write oDataSet;
    property Long1: longint read GetLong1 write SetLong1;
    property Long2: longint read GetLong2 write SetLong2;
    property Code1: string read GetCode1 write SetCode1;
    property Code2: string read GetCode2 write SetCode2;
    property Text: string read GetText write SetText;
    property Search: boolean read oSearch write oSearch;
    property FieldNameCode1: string read oFieldNameCode1 write oFieldNameCode1;
    property FieldNameCode2: string read oFieldNameCode2 write oFieldNameCode2;
    property FieldNameText: string read oFieldNameText write oFieldNameText;
    property KeyNum: word read oKeyNum write oKeyNum;
    property StatusLine: TStatusLine read oStatusLine write oStatusLine;
    property DgdName: string read oDgdName write oDgdName;
    property EditType: TEditType read oEditType write SetEditType default ceAccanl;
    property TabOrder;
    property Anchors;
    {Events}
    property OnEnter: TNotifyEvent read eOnEnter write eOnEnter;
    property OnExit: TNotifyEvent read eOnExit write eOnExit;
    property OnKeyDown: TKeyEvent read eOnKeyDown write eOnKeyDown;
    property OnChanged: TNotifyEvent read eOnChanged write eOnChanged;
  end;

  // Editor intervalov hodnot
  TIntervals = record
                 ValFr:  longint;
                 ValTo: longint;
               end;

  TIntervalEdit = class(TNameEdit)
  private
    oIntvQnt: word;
    oIntervals: array [1..100] of TIntervals;
  public
    constructor Create(AOwner: TComponent); override;
    destructor  Destroy; override;
    procedure   EditStringCut;
    function    GetIntvQnt:word;   // PocËt zadan˝ch intervalov napr. 1-10,15 hodnota funkcie bude 2
    function    GetItemQnt:word;   // PocËt zadan˝ch poloziek napr. 1-10,15 hodnota funkcie bude 11
    function    GetIntvValFr (pIndex:word): longint;  // Zaciatok vybraneho intervalu
    function    GetIntvValTo (pIndex:word): longint;  // Koniec vybraneho intervalu

    function    DateInInt (pValue:TDate):boolean;
    function    StrInInt (pValue:string):boolean;
    function    FloatInInt (pValue:double):boolean;
    function    LongInInt (pValue:longint):boolean;

    function    GetFirstDate:TDate;
    function    GetLastDate:TDate;
    function    GetFirstStr:string;
    function    GetLastStr:string;
    function    GetFirstFloat:double;
    function    GetLastFloat:double;
    function    GetFirstLong:longint;
    function    GetLastLong:longint;

  end;

  // Editor datumu a casu
  TDateTimeEdit = class(TDateTimePicker)
  private
    oStatusLine: TStatusLine;
    eOnEnter: TNotifyEvent;
    eOnExit: TNotifyEvent;
    eOnKeyDown: TKeyEvent;
    procedure MyOnEnter (Sender: TObject);
    procedure MyOnExit (Sender: TObject);
  protected
    procedure KeyDown(var Key: Word; Shift: TShiftState); override;
  public
    constructor Create (AOwner:TComponent); override;
  published
    property StatusLine: TStatusLine read oStatusLine write oStatusLine;
    {Events}
    property OnEnter: TNotifyEvent read eOnEnter write eOnEnter;
    property OnExit: TNotifyEvent read eOnExit write eOnExit;
  end;

  // Datumovy editor
  TDateEdit = class(TEdit)
  protected
    procedure CreateWnd; override;
  public
    constructor Create (AOwner:TComponent); override;
  private
    oStatusLine: TStatusLine;
    oChecked   : boolean;
    oShowCheckbox: boolean;
    oFixedFont: boolean; // Ak je TRUE program pouz9va nastavenia fontov z DFM v opacnom pripade sa pouzivaju systemove nastavenia fontov gvSys
    oBefDate: TDate;  // Nacitana hodnota z databaze
    eOnEnter: TNotifyEvent;
    eOnExit: TNotifyEvent;

    function  GetDate:TDate;
    procedure SetDate (Value:TDate);
    function  GetBefDate:TDate;
    procedure SetBefDate (Value:TDate);
    function  GetChanged:boolean;


    procedure MyOnEnter (Sender: TObject);
    procedure MyOnExit (Sender: TObject);
  protected
    procedure KeyDown(var Key: Word; Shift: TShiftState); override;
  published
    property BefDate:TDate read GetBefDate write SetBefDate;
    property Date:TDate read GetDate write SetDate;
    property StatusLine: TStatusLine read oStatusLine write oStatusLine;
    property Checked:boolean read oChecked write oChecked;
    property ShowCheckbox:boolean read oShowCheckbox write oShowCheckbox;
    property FixedFont: boolean read oFixedFont write oFixedFont;
    property Changed: boolean read GetChanged;
    property OnEnter: TNotifyEvent read eOnEnter write eOnEnter;
    property OnExit: TNotifyEvent read eOnExit write eOnExit;
  end;

  // Editor casu
  TTimeEdit = class(TDateTimeEdit)
  protected
    procedure CreateWnd; override;
  private
    oFixedFont: boolean; // Ak je TRUE program pouz9va nastavenia fontov z DFM v opacnom pripade sa pouzivaju systemove nastavenia fontov gvSys
  public
    constructor Create (AOwner:TComponent); override;
  published
    property FixedFont: boolean read oFixedFont write oFixedFont;
  end;

  // Editor s Alignment funkciou
  TMyEdit = class (TEdit)
  private
    oColor: TColor; // Na zapametanie farby aby po opusteni bolo mozne nastavit povodnu farbu editoru
    eOnEnter: TNotifyEvent;
    eOnExit: TNotifyEvent;
    oStatusLine: TStatusLine;
    oEnterVal: string; // Hodnota ktora bola pri vstupu do editoru
    oChanged: boolean; // TRUE ak hodnota editoru bola zmenena
    FAlignment: TAlignment;
    procedure MyOnEnter (Sender: TObject);
    procedure MyOnExit (Sender: TObject);
  protected
    procedure CreateParams(var Params: TCreateParams); override;
    procedure SetAlignment(Value: TAlignment);
  public
    constructor Create(AOwner: TComponent); override;
    function GetControlsAlignment: TAlignment; override;
  published
    property Alignment: TAlignment read FAlignment write SetAlignment default taLeftJustify;
    property OnEnter: TNotifyEvent read eOnEnter write eOnEnter;
    property OnExit: TNotifyEvent read eOnExit write eOnExit;
    property StatusLine: TStatusLine read oStatusLine write oStatusLine;
    property Changed:boolean read oChanged write oChanged;
  end;

  // Editor realnych cisiel
  TDoubEdit = class (TMyEdit)
    procedure SetValue(pValue: double);
    function  GetValue: double;
    procedure SetFract(pValue: byte);
  public
    constructor Create (AOwner:TComponent); override;
  private
    oStatusLine: TStatusLine;
    oDoub: double;
    oFract: byte; // Pocet desatinnych miest zobrazovaneho cisla
  protected
    procedure KeyDown(var Key: Word; Shift: TShiftState); override;
  published
    { Properties }
    property Value: double read GetValue write SetValue;
    property Fract: byte read oFract write SetFract;
    property StatusLine: TStatusLine read oStatusLine write oStatusLine;
    property Font;
    property Visible;
    property TabOrder;
    property Align;
    property Anchors;
  end;

  // Specialny editor s pridavnym textom
  TSpecEdit = class(TWinControl)
    P_Background: TDinamicPanel;
    E_Value: TMyEdit;
    L_SpecText: TLabel;
    procedure SetAutoSelect(pValue: boolean);
    function  GetAutoSelect: boolean; // Autoselect Editora
    procedure SetValue(pValue: double);
    function  GetValue: double;
    procedure SetBefValue(pValue: double);
    function  GetBefValue: double;
    procedure SetSpecText(pValue: Str10);
    function  GetSpecText: Str10;
    procedure SetFract(pValue: byte);
    function  GetFract: byte;
    procedure SetText(pValue: string);
    function  GetText: string;
    procedure SetEnabled(pValue: boolean);
    function  GetEnabled: boolean;
    function  GetChanged: boolean; // TRUE ak nacitana hodnota bola zmenena
  private
    oLastVal   :string;
    { Properties }
    oStatusLine: TStatusLine;
    oFract: byte; // Pocet desatinnych miest zobrazovaneho cisla
    oFixedFont: boolean; // Ak je TRUE program pouz9va nastavenia fontov z DFM v opacnom pripade sa pouzivaju systemove nastavenia fontov gvSys
    oBefValue: double;
    oEnterValue: double;
    { Events }
    eOnKeyDown: TKeyEvent;
    eOnEnter  : TNotifyEvent;
    eOnExit   : TNotifyEvent;
    eOnChanged: TNotifyEvent;
    procedure MyOnEnter (Sender: TObject);
    procedure MyOnExit (Sender: TObject);
    procedure MyKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    function  GetModified:boolean;
    procedure SetModified (pValue:boolean);
  public
    constructor Create(AOwner: TComponent); override;
    destructor  Destroy; override;
    procedure   Loaded; override;
    procedure   SetFocus; override;
    procedure   Undo;
    procedure   ClearUndo;
  published
    { Properties }
    property BefValue: double read GetBefValue write SetBefValue;
    property Value: double read GetValue write SetValue;
    property SpecText: Str10 read GetSpecText write SetSpecText;
    property Extend: Str10 read GetSpecText write SetSpecText;
    property Enabled: boolean read GetEnabled write SetEnabled;
    property Fract: byte read GetFract write SetFract;
    property Text: string read GetText write SetText;
    property StatusLine: TStatusLine read oStatusLine write oStatusLine;
    property FixedFont: boolean read oFixedFont write oFixedFont;
    property Changed: boolean read GetChanged;
    property Font;
    property Visible;
    property TabOrder;
    property Align;
    property Anchors;
    { Events }
    property OnKeyDown: TKeyEvent read eOnKeyDown write eOnKeyDown;
    property OnEnter:TNotifyEvent read eOnEnter write eOnEnter;
    property OnExit:TNotifyEvent read eOnExit write eOnExit;
    property OnChanged: TNotifyEvent read eOnChanged write eOnChanged;
    property Modified:boolean read GetModified write SetModified;
    property Autoselect: boolean read GetAutoselect write SetAutoSelect;
  end;

  // Editor cenny za mernu jednotku
  TPriceEdit = class(TSpecEdit)
    procedure SetIntCoin(pValue: string);
    function  GetIntCoin: string;
    procedure SetMeasure(pValue: string);
    function  GetMeasure: string;
  private
    oIntCoin: string;
    oMeasure: string;
  public
    constructor Create(AOwner: TComponent); override;
    procedure Loaded; override;
  published
    property IntCoin: string read GetIntCoin write SetIntCoin;
    property Measure: string read GetMeasure write SetMeasure;
  end;

  // Editor penaznych hodnot
  TValueEdit = class(TSpecEdit)
  public
    constructor Create(AOwner: TComponent); override;
    procedure Loaded; override;
  end;

  // Editor mnozstva
  TQuantEdit = class(TSpecEdit)
    procedure SetQuant(pValue: double);
    function  GetQuant: double;
  public
    constructor Create(AOwner: TComponent); override;
    procedure Loaded; override;
  published
    property Quant: double read GetQuant write SetQuant;
  end;

  // Editor percentualnych hodnot
  TPrcEdit = class(TSpecEdit)
  public
    constructor Create(AOwner: TComponent); override;
  end;

  // Editor DPH
  TVatEdit = class(TPrcEdit)
  public
    constructor Create(AOwner: TComponent); override;
  end;

  TCodeNameEdit = class(TWinControl)
    E_Name: TNameEdit;
    Bevel: TBevel;
    L_Code: TLabel;
    B_Slct: TSpeedButton;
  private
    oLastVal:string;
    oStatusLine: TStatusLine;
    eOnEnter: TNotifyEvent;
    eOnExit: TNotifyEvent;
    eOnKeyDown: TKeyEvent;
    eOnAddItem: TNotifyEvent;
    eOnChanged: TNotifyEvent;
    eOnShowLst: TNotifyEvent;
    procedure SetCode(pValue: Str10);
    function  GetCode: Str10;
    procedure SetText(pValue: Str30);
    function  GetText: Str30;
    procedure SetShowCode(pValue: boolean);
    procedure MyKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure MyOnEnter (Sender: TObject);
    procedure MyOnExit (Sender: TObject);
    procedure MyOnAddItem (Sender: TObject);
    procedure MyOnResize (Sender:TObject);
    procedure MyOnShowLst (Sender:TObject);
    procedure MySearch;
  public
    oDataSet: TNexBtrTable;
    oCodeField: Str20;
    oNameField: Str20;
    oSrchField: Str80;
    oDgdName: string;   // Nazov Grid suboru kde su nastavenia
    oSearch: boolean;   // Ak je true program hlada zadany kod v databaze DataSet
    oShowCode: boolean;   // Ak je true je zobrazeny aj kod
    oFixedFont: boolean; // Ak je TRUE program pouz9va nastavenia fontov z DFM v opacnom pripade sa pouzivaju systemove nastavenia fontov gvSys
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
  published
    property DataSet: TNexBtrTable read oDataSet write oDataSet;
    property Code: Str10 read GetCode write SetCode;
    property Text: Str30 read GetText write SetText;
    property Search: boolean read oSearch write oSearch;
    property CodeField: Str20 read oCodeField write oCodeField;
    property NameField: Str20 read oNameField write oNameField;
    property SrchField: Str80 read oSrchField write oSrchField;
    property StatusLine: TStatusLine read oStatusLine write oStatusLine;
    property DgdName: string read oDgdName write oDgdName;
    property FixedFont: boolean read oFixedFont write oFixedFont;
    property ShowCode: boolean read oShowCode write SetShowCode;// Ak je true je zobrazeny aj kod
    property TabOrder;
    property Anchors;
    {Events}
    property OnEnter: TNotifyEvent read eOnEnter write eOnEnter;
    property OnExit: TNotifyEvent read eOnExit write eOnExit;
    property OnKeyDown: TKeyEvent read eOnKeyDown write eOnKeyDown;
    property OnAddItem: TNotifyEvent read eOnAddItem write eOnAddItem;
    property OnChanged: TNotifyEvent read eOnChanged write eOnChanged;
    property OnShowLst: TNotifyEvent read eOnShowLst write eOnShowLst;
  end;

  TFLongEdit = class(TWinControl)
  private
    oLongEdit1: TLongEdit;
    oLongEdit2: TLongEdit;
    oLabel1   : TLabel;

    function  GetLong1:longint;
    procedure SetLong1 (Value:longint);
    function  GetLong2:longint;
    procedure SetLong2 (Value:longint);
    function  GetMaxLength:longint;
    procedure SetMaxLength (Value:longint);
    function  GetReadOnly:boolean;
    procedure SetReadOnly (Value:boolean);
    function  GetHint1:string;
    procedure SetHint1 (Value:string);
    function  GetHint2:string;
    procedure SetHint2 (Value:string);
    function  GetStatusLine:TStatusLine;
    procedure SetStatusLine (Value:TStatusLine);

    procedure MyOnResize (Sender:TObject);
  public
    constructor Create(AOwner: TComponent); override;
    destructor  Destroy; override;
    procedure   SetFocus; override;
    procedure   SetFocus2;

  published
    property Font;
    property Enabled;
    property Visible;
    property TabOrder;
    property Anchors;

    property Long1:longint read GetLong1 write SetLong1;
    property Long2:longint read GetLong2 write SetLong2;
    property MaxLength:longint read GetMaxLength write SetMaxLength;
    property ReadOnly:boolean read GetReadOnly write SetReadOnly;
    property Hint1:string read GetHint1 write SetHint1;
    property Hint2:string read GetHint2 write SetHint2;
    property StatusLine:TStatusLine read GetStatusLine write SetStatusLine;
  end;

  TFPriceEdit = class(TWinControl)
  private
    oPriceEdit1: TPriceEdit;
    oPriceEdit2: TPriceEdit;
    oLabel1    : TLabel;

    function  GetValue1:double;
    procedure SetValue1 (Value:double);
    function  GetValue2:double;
    procedure SetValue2 (Value:double);
    function  GetHint1:string;
    procedure SetHint1 (Value:string);
    function  GetHint2:string;
    procedure SetHint2 (Value:string);
    function  GetStatusLine:TStatusLine;
    procedure SetStatusLine (Value:TStatusLine);
    function  GetIntCoin:string;
    procedure SetIntCoin (Value:string);
    function  GetMeasure:string;
    procedure SetMeasure (Value:string);
    function  GetFract:byte;
    procedure SetFract (Value:byte);

    procedure MyOnResize (Sender:TObject);
  public
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
    procedure Loaded; override;
    procedure SetFocus; override;
    procedure SetFocus2;

  published
    property Font;
    property Enabled;
    property Visible;
    property TabOrder;
    property Anchors;

    property Value1:double read GetValue1 write SetValue1;
    property Value2:double read GetValue2 write SetValue2;
    property Hint1:string read GetHint1 write SetHint1;
    property Hint2:string read GetHint2 write SetHint2;
    property StatusLine:TStatusLine read GetStatusLine write SetStatusLine;
    property IntCoin:string read GetIntCoin write SetIntCoin;
    property Measure:string read GetMeasure write SetMeasure;
    property Fract:byte read GetFract write SetFract;
  end;

  TFValueEdit = class(TWinControl)
  private
    oValueEdit1: TValueEdit;
    oValueEdit2: TValueEdit;
    oLabel1    : TLabel;

    function  GetValue1:double;
    procedure SetValue1 (Value:double);
    function  GetValue2:double;
    procedure SetValue2 (Value:double);
    function  GetHint1:string;
    procedure SetHint1 (Value:string);
    function  GetHint2:string;
    procedure SetHint2 (Value:string);
    function  GetStatusLine:TStatusLine;
    procedure SetStatusLine (Value:TStatusLine);
    function  GetSpecText:Str10;
    procedure SetSpecText (Value:Str10);
    function  GetFract:byte;
    procedure SetFract (Value:byte);

    procedure MyOnResize (Sender:TObject);
  public
    constructor Create(AOwner: TComponent); override;
    destructor  Destroy; override;
    procedure Loaded; override;
    procedure   SetFocus; override;
    procedure   SetFocus2;
  published
    property Font;
    property Enabled;
    property Visible;
    property TabOrder;
    property Anchors;

    property Value1:double read GetValue1 write SetValue1;
    property Value2:double read GetValue2 write SetValue2;
    property Hint1:string read GetHint1 write SetHint1;
    property Hint2:string read GetHint2 write SetHint2;
    property StatusLine:TStatusLine read GetStatusLine write SetStatusLine;
    property SpecText:Str10 read GetSpecText write SetSpecText;
    property Fract:byte read GetFract write SetFract;
  end;

  TFQuantEdit = class(TWinControl)
  private
    oQuantEdit1: TQuantEdit;
    oQuantEdit2: TQuantEdit;
    oLabel1    : TLabel;

    function  GetValue1:double;
    procedure SetValue1 (Value:double);
    function  GetValue2:double;
    procedure SetValue2 (Value:double);
    function  GetHint1:string;
    procedure SetHint1 (Value:string);
    function  GetHint2:string;
    procedure SetHint2 (Value:string);
    function  GetStatusLine:TStatusLine;
    procedure SetStatusLine (Value:TStatusLine);
    function  GetSpecText:Str10;
    procedure SetSpecText (Value:Str10);
    function  GetFract:byte;
    procedure SetFract (Value:byte);

    procedure MyOnResize (Sender:TObject);
  public
    constructor Create(AOwner: TComponent); override;
    destructor  Destroy; override;
    procedure Loaded; override;
    procedure   SetFocus; override;
    procedure   SetFocus2;
  published
    property Font;
    property Enabled;
    property Visible;
    property TabOrder;
    property Anchors;

    property Value1:double read GetValue1 write SetValue1;
    property Value2:double read GetValue2 write SetValue2;
    property Hint1:string read GetHint1 write SetHint1;
    property Hint2:string read GetHint2 write SetHint2;
    property StatusLine:TStatusLine read GetStatusLine write SetStatusLine;
    property SpecText:Str10 read GetSpecText write SetSpecText;
    property Fract:byte read GetFract write SetFract;
  end;

  TFPrcEdit = class(TWinControl)
  private
    oPrcEdit1: TPrcEdit;
    oPrcEdit2: TPrcEdit;
    oLabel1  : TLabel;

    function  GetValue1:double;
    procedure SetValue1 (Value:double);
    function  GetValue2:double;
    procedure SetValue2 (Value:double);
    function  GetHint1:string;
    procedure SetHint1 (Value:string);
    function  GetHint2:string;
    procedure SetHint2 (Value:string);
    function  GetStatusLine:TStatusLine;
    procedure SetStatusLine (Value:TStatusLine);

    procedure MyOnResize (Sender:TObject);
  public
    constructor Create(AOwner: TComponent); override;
    destructor  Destroy; override;
    procedure   SetFocus; override;
    procedure   SetFocus2;

  published
    property Font;
    property Enabled;
    property Visible;
    property TabOrder;
    property Anchors;

    property Value1:double read GetValue1 write SetValue1;
    property Value2:double read GetValue2 write SetValue2;
    property Hint1:string read GetHint1 write SetHint1;
    property Hint2:string read GetHint2 write SetHint2;
    property StatusLine:TStatusLine read GetStatusLine write SetStatusLine;
  end;

  TFDateEdit = class(TWinControl)
  private
    oDateEdit1: TDateEdit;
    oDateEdit2: TDateEdit;
    oLabel1   : TLabel;

    function  GetDate1:TDate;
    procedure SetDate1 (Value:TDate);
    function  GetDate2:TDate;
    procedure SetDate2 (Value:TDate);
    function  GetHint1:string;
    procedure SetHint1 (Value:string);
    function  GetHint2:string;
    procedure SetHint2 (Value:string);
    function  GetStatusLine:TStatusLine;
    procedure SetStatusLine (Value:TStatusLine);
    function  GetChecked1:boolean;
    procedure SetChecked1 (Value:boolean);
    function  GetChecked2:boolean;
    procedure SetChecked2 (Value:boolean);
    function  GetShowCheckbox1:boolean;
    procedure SetShowCheckbox1 (Value:boolean);
    function  GetShowCheckbox2:boolean;
    procedure SetShowCheckbox2 (Value:boolean);

    procedure MyOnResize (Sender:TObject);

  protected
    procedure CreateWnd; override;
  public
    constructor Create(AOwner: TComponent); override;
    destructor  Destroy; override;
    procedure   SetFocus; override;
    procedure   SetFocus2;
    function    InInterval (pDate:TDateTime): boolean; // TRUE ak zadany datum je z intervalu

  published
    property Font;
    property Enabled;
    property Visible;
    property TabOrder;

    property Date1:TDate read GetDate1 write SetDate1;
    property Date2:TDate read GetDate2 write SetDate2;
    property Hint1:string read GetHint1 write SetHint1;
    property Hint2:string read GetHint2 write SetHint2;
    property StatusLine:TStatusLine read GetStatusLine write SetStatusLine;
    property Checked1:boolean read GetChecked1 write SetChecked1;
    property Checked2:boolean read GetChecked2 write SetChecked2;
    property ShowCheckbox1:boolean read GetShowCheckbox1 write SetShowCheckbox1;
    property ShowCheckbox2:boolean read GetShowCheckbox2 write SetShowCheckbox2;
  end;

  TFTimeEdit = class(TWinControl)
  private
    oTimeEdit1: TTimeEdit;
    oTimeEdit2: TTimeEdit;
    oLabel1   : TLabel;

    function  GetTime1:TTime;
    procedure SetTime1 (Value:TTime);
    function  GetTime2:TTime;
    procedure SetTime2 (Value:TTime);
    function  GetHint1:string;
    procedure SetHint1 (Value:string);
    function  GetHint2:string;
    procedure SetHint2 (Value:string);
    function  GetStatusLine:TStatusLine;
    procedure SetStatusLine (Value:TStatusLine);
    function  GetChecked1:boolean;
    procedure SetChecked1 (Value:boolean);
    function  GetChecked2:boolean;
    procedure SetChecked2 (Value:boolean);
    function  GetShowCheckbox1:boolean;
    procedure SetShowCheckbox1 (Value:boolean);
    function  GetShowCheckbox2:boolean;
    procedure SetShowCheckbox2 (Value:boolean);

    procedure MyOnResize (Sender:TObject);

  protected
    procedure CreateWnd; override;
  public
    constructor Create(AOwner: TComponent); override;
    destructor  Destroy; override;
    procedure   SetFocus; override;
    procedure   SetFocus2;

  published
    property Font;
    property Enabled;
    property Visible;
    property TabOrder;
    property Anchors;

    property Time1:TTime read GetTime1 write SetTime1;
    property Time2:TTime read GetTime2 write SetTime2;
    property Hint1:string read GetHint1 write SetHint1;
    property Hint2:string read GetHint2 write SetHint2;
    property StatusLine:TStatusLine read GetStatusLine write SetStatusLine;
    property Checked1:boolean read GetChecked1 write SetChecked1;
    property Checked2:boolean read GetChecked2 write SetChecked2;
    property ShowCheckbox1:boolean read GetShowCheckbox1 write SetShowCheckbox1;
    property ShowCheckbox2:boolean read GetShowCheckbox2 write SetShowCheckbox2;
  end;

  // Editor ComboBox
  TComboEdit = class(TComboBox)
  private
    FAlignment: TAlignment;
    eOnEnter: TNotifyEvent;
    eOnExit: TNotifyEvent;
    oStatusLine: TStatusLine;
    oColor: TColor; // Na zapametanie farby aby po opusteni bolo mozne nastavit povodnu farbu editoru
    oFixedFont: boolean;
    oBefText: TCaption;

    procedure MyOnEnter (Sender: TObject);
    procedure MyOnExit (Sender: TObject); virtual;
  protected
    procedure KeyDown(var Key: Word; Shift: TShiftState); override;
    procedure CreateParams(var Params: TCreateParams); override;
    procedure SetAlignment(Value: TAlignment);
  public
    function GetControlsAlignment: TAlignment; override;
    constructor Create(AOwner: TComponent); override;
    procedure SetBefText (pText:TCaption);
    function GetBefText: TCaption;
    procedure SetChanged (pValue:boolean);
    function GetChanged: boolean;
  published
    property Alignment: TAlignment read FAlignment write SetAlignment default taLeftJustify;
    property StatusLine: TStatusLine read oStatusLine write oStatusLine;
    property FixedFont: boolean read oFixedFont write oFixedFont;

    property BefText: TCaption read GetBefText write SetBeftext;
    property Changed: boolean read GetChanged write SetChanged;

    property OnEnter: TNotifyEvent read eOnEnter write eOnEnter;
    property OnExit: TNotifyEvent read eOnExit write eOnExit;
  end;

  // Memo s moznostou nastavenai limitu pre dlzku a pocet riadkov
  TLimitMemo = class(TMemo)
  private
    eOnEnter: TNotifyEvent;
    eOnExit: TNotifyEvent;
    oStatusLine: TStatusLine;
    oColor: TColor; // Na zapametanie farby aby po opusteni bolo mozne nastavit povodnu farbu editoru
    oLineLength: integer;
    oLineCount : integer;

    procedure MyOnEnter (Sender: TObject);
    procedure MyOnExit (Sender: TObject);
  protected
    procedure KeyDown (var Key: Word; Shift: TShiftState); override;
    procedure KeyPress(var Key: char);
  public
    constructor Create(AOwner: TComponent); override;
  published
    property StatusLine: TStatusLine read oStatusLine write oStatusLine;
    property LineLength: integer read oLineLength write oLineLength;
    property LineCount : integer read oLineCount  write oLineCount;

    property OnEnter: TNotifyEvent read eOnEnter write eOnEnter;
    property OnExit: TNotifyEvent read eOnExit write eOnExit;
  end;

  TComboSlctEdit = class (TComboEdit)
  private
    LastKey     : word;                 // kod naposledy stlacenej klavesy
    LastFStr    : string;               // posledny existujuci text
    procedure MyOnExit (Sender: TObject); override;
  protected
    procedure   KeyDown(var key:word; Shift:TShiftState); override;
    procedure   Change; override;       // vlastne spracovanie udalosti pri zmene texte
    procedure   SetText(value:string);  // vlastne spracovanie udalosti vkladania property TEXT
    function    GetText:string;         // vlastne spracovanie udalosti pre nacitanie property TEXT
  published
    property Text:string read GetText write SetText;
    property OnExit: TNotifyEvent read eOnExit write eOnExit;
  end;

  TIntervalSlctEdit = class(TNameEdit)
  private
    oIntvQnt: word;
    oIntervals: array [1..100] of TIntervals;
    procedure ShowViewForm;    // zobrazenie pomocneho zoznamu pre vyber pola intervalu z databazy
  protected
    procedure KeyDown (var Key: Word; Shift: TShiftState); override;
    procedure Dblclick; override;
//    procedure KeyPress(var Key: char);override;
  public
    oDataSet    : TNexBtrTable; // databaza z ktorej sa budu zobrazovat zoznamy pre vyber intervalov
    oDgdName    : string;       // Nazov Grid suboru kde su nastavenia
    oKeyNum     : word;         // Index podla ktoreho sa hlada oCodeField
    oSearch     : boolean;      // Ak je true program hlada zadany kod v databaze DataSet
    oFieldName  : string;       // pole databazy ktore sluzi na vyber poloziek intervalu
    oSlctText   : string;       // posledne vybrana polozka intervalu z databazy
    eOnExit     : TNotifyEvent;
    eOnKeyDown  : TKeyEvent;

    constructor Create(AOwner: TComponent); override;
    destructor  Destroy; override;
    procedure   EditStringCut;
    procedure   CheckInterval;     // kontrola a doplnenie vybraneho pola intervalu z databazy
    function    GetIntvQnt:word;   // Pocet zadan˝ch intervalov napr. 1-10,15 hodnota funkcie bude 2
    function    GetItemQnt:word;   // Pocet zadan˝ch poloziek napr. 1-10,15 hodnota funkcie bude 11
    function    GetIntvValFr (pIndex:word): longint;  // Zaciatok vybraneho intervalu
    function    GetIntvValTo (pIndex:word): longint;  // Koniec vybraneho intervalu

    function    DateInInt (pValue:TDate):boolean;
    function    StrInInt (pValue:string):boolean;
    function    FloatInInt (pValue:double):boolean;
    function    LongInInt (pValue:longint):boolean;

    function    GetFirstDate:TDate;
    function    GetLastDate:TDate;
    function    GetFirstStr:string;
    function    GetLastStr:string;
    function    GetFirstFloat:double;
    function    GetLastFloat:double;
    function    GetFirstLong:longint;
    function    GetLastLong:longint;

  published

    property DataSet  : TNexBtrTable read oDataSet   write oDataSet;
    property Search   : boolean      read oSearch    write oSearch;
    property FieldName: string       read oFieldName write oFieldName;
    property KeyNum   : word         read oKeyNum    write oKeyNum;
    property DgdName  : string       read oDgdName   write oDgdName;
  end;

  TMgIntEdit = class(TIntervalSlctEdit)
  public
    constructor Create(AOwner: TComponent); override;
  private
    property DataSet  : TNexBtrTable read oDataSet   write oDataSet;
    property FieldName: string       read oFieldName write oFieldName;
    property KeyNum   : word         read oKeyNum    write oKeyNum;
    property DgdName  : string       read oDgdName   write oDgdName;
  end;


  TWriIntEdit = class(TIntervalSlctEdit)
  public
    constructor Create(AOwner: TComponent); override;
  private
    property DataSet  : TNexBtrTable read oDataSet   write oDataSet;
    property FieldName: string       read oFieldName write oFieldName;
    property KeyNum   : word         read oKeyNum    write oKeyNum;
    property DgdName  : string       read oDgdName   write oDgdName;
  end;

  TStkIntEdit = class(TIntervalSlctEdit)
  public
    constructor Create(AOwner: TComponent); override;
  private
    property DataSet  : TNexBtrTable read oDataSet   write oDataSet;
    property FieldName: string       read oFieldName write oFieldName;
    property KeyNum   : word         read oKeyNum    write oKeyNum;
    property DgdName  : string       read oDgdName   write oDgdName;
  end;

  TCasIntEdit = class(TIntervalSlctEdit)
  public
    constructor Create(AOwner: TComponent); override;
  private
    property DataSet  : TNexBtrTable read oDataSet   write oDataSet;
    property FieldName: string       read oFieldName write oFieldName;
    property KeyNum   : word         read oKeyNum    write oKeyNum;
    property DgdName  : string       read oDgdName   write oDgdName;
  end;

  // Casovy editor
  TTimeEdit2 = class(TEdit)
  protected
    procedure CreateWnd; override;
  public
    constructor Create (AOwner:TComponent); override;
  private
    oStatusLine: TStatusLine;
    oChecked   : boolean;
    oShowCheckbox: boolean;
    oFixedFont: boolean; // Ak je TRUE program pouz9va nastavenia fontov z DFM v opacnom pripade sa pouzivaju systemove nastavenia fontov gvSys
    oBefTime: TTime;  // Nacitana hodnota z databaze
    eOnEnter: TNotifyEvent;
    eOnExit: TNotifyEvent;

    function  GetTime:TTime;
    procedure SetTime (Value:TTime);
    function  GetBefTime:TTime;
    procedure SetBefTime (Value:TTime);
    function  GetChanged:boolean;


    procedure MyOnEnter (Sender: TObject);
    procedure MyOnExit (Sender: TObject);
  protected
    procedure KeyDown(var Key: Word; Shift: TShiftState); override;
  published
    property BefTime:TTime read GetBefTime write SetBefTime;
    property Time:TTime read GetTime write SetTime;
    property StatusLine: TStatusLine read oStatusLine write oStatusLine;
    property Checked:boolean read oChecked write oChecked;
    property ShowCheckbox:boolean read oShowCheckbox write oShowCheckbox;
    property FixedFont: boolean read oFixedFont write oFixedFont;
    property Changed: boolean read GetChanged;
    property OnEnter: TNotifyEvent read eOnEnter write eOnEnter;
    property OnExit: TNotifyEvent read eOnExit write eOnExit;
  end;




procedure Register;

implementation

uses
  DM_DLSDAT, DM_CPDDAT, DM_STKDAT, DM_LDGDAT, DM_CABDAT,ViewForm;

//***************** TNameEdit *******************
procedure TNameEdit.CreateParams(var Params: TCreateParams);
const Alignments: array[Boolean, TAlignment] of DWORD = ((ES_LEFT, ES_RIGHT, ES_CENTER),(ES_RIGHT, ES_LEFT, ES_CENTER));
begin
  inherited CreateParams(Params);
  with Params do
  begin
    Style := Style or Alignments[FALSE, FAlignment];
  end;
end;

procedure TNameEdit.SetAlignment(Value: TAlignment);
begin
  if FAlignment <> Value then
  begin
    FAlignment := Value;
    RecreateWnd;
  end;
end;

function TNameEdit.GetControlsAlignment: TAlignment;
begin
  Result := FAlignment;
end;

constructor TNameEdit.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  inherited OnEnter := MyOnEnter;
  inherited OnExit := MyOnExit;
  inherited OnKeyDown := MyKeyDown;
  AutoSize := FALSE;
  MaxLength := 30;
  Height := 20;
  Width := 250;
  If not FixedFont then begin
    Font.Name := gvSys.EditFontName;
    Font.Size := gvSys.EditFontSize;
  end;
end;

procedure TNameEdit.SetText (pText:TCaption);
begin
  inherited Text := pText;
  oBefText := pText;
end;

function  TNameEdit.GetText: TCaption;
begin
  Result := inherited Text;
end;

function  TNameEdit.GetChanged: boolean;
begin       
  Result := Text<>oBefText;
end;

procedure TNameEdit.KeyDown(var Key: Word; Shift: TShiftState);
begin
  SpecKeyDownHandle (Self,Key,Shift);
  inherited;
end;

procedure TNameEdit.MyOnEnter (Sender: TObject);
begin
  Modified := FALSE;
  oBefText := Text;
  oColor := Color;
  Color := clAqua;
  If oStatusLine<>nil then begin
    oStatusLine.TabPosition := TabOrder;
    oStatusLine.CursorPosition := 0;
    oStatusLine.Description := Hint;
  end;
  SetFocus;
  If Assigned (eOnEnter) then eOnEnter (Sender);
end;

procedure TNameEdit.MyOnExit (Sender: TObject);
begin
  Color := oColor;
  If Assigned (eOnExit) then eOnExit (Sender);
end;

procedure TNameEdit.MyKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
begin
  If Key=VK_F7 then  MyOnShowLst (Sender);
end;

procedure TNameEdit.MyOnShowLst (Sender: TObject);
begin
  If Assigned (eOnShowLst) then eOnShowLst (Sender);
end;


//***************** TLongEdit *******************
constructor TLongEdit.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  AutoSize := FALSE;
  Height := 20;
  Width := 50;
  SetLong (0);
  Alignment := taRightJustify;
end;

procedure TLongEdit.SetLong(pValue: longint);
begin
  Text := StrInt(pValue,0);
end;

function TLongEdit.GetLong: longint;
begin
  Result := ValInt (Text);
end;

procedure TLongEdit.SetBefLong(pValue: longint);
begin
  Text := StrInt(pValue,0);
end;

function TLongEdit.GetBefLong: longint;
begin
  Result := ValInt (Text);
end;

//***************** TBarCodeEdit *******************
constructor TBarCodeEdit.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  inherited OnExit := MyOnExit;
  AutoSize := FALSE;
  MaxLength := 15;
  Height := 20;
  Width := 125;
end;

procedure TBarCodeEdit.MyOnExit (Sender: TObject);
begin
//  inherited;
  If oVerifyCheckSum then begin
    If not CheckSumVerify (Text, BarCodeType (Text)) then begin
      Text :=  CheckSumCalc (Text, BarCodeType (Text));
      // vypÌsaù upozornenie
    end;
  end;
  If Assigned (eOnExit) then eOnExit (Sender);
end;


//***************** TCodeEdit *******************
constructor TCodeEdit.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  inherited OnEnter := MyOnEnter;
  inherited OnExit := MyOnExit;
  Width := 304;
  Height := 20;

  E_Code := TLongEdit.Create (Self);
  E_Code.Parent := Self;
  E_Code.OnKeyDown := MyKeyDown;

  L_Name := TLabel.Create (Self);
  L_Name.Parent := Self;
  L_Name.Top := 2;
  L_Name.Left := 58;
  L_Name.Caption := '';
  If not FixedFont then begin
    L_Name.Font.Name := gvSys.LabelFontName;
    L_Name.Font.Size := gvSys.LabelFontSize;
  end;
  L_Name.Font.Charset := gvSys.FontCharset;
  L_Name.Font.Color := clNavy;
  L_Name.Font.Style := [fsBold];

  Bevel := TBevel.Create (Self);
  Bevel.Parent := Self;
  Bevel.Left := 54;
  Bevel.Width := 228;
  Bevel.Height := 20;
  Bevel.Style := bsLowered;
  Bevel.Shape := bsBox;

  B_Slct := TSpeedButton.Create (Self);
  B_Slct.Parent := Self;
  B_Slct.Width := 20;
  B_Slct.Height := 20;
  B_Slct.Align := alRight;
  B_Slct.Glyph.LoadFromResourceName (HInstance,'SELECTBUTTON');
  B_Slct.NumGlyphs := 2;
  B_Slct.OnClick := MyOnShowLst;

  oSearch := FALSE;
  oLastCode := '';
end;

destructor TCodeEdit.Destroy;
begin
  Bevel.Free;
  L_Name.Free;
  E_Code.Free;
  inherited;
end;

procedure TCodeEdit.Loaded;
begin
  inherited;
  L_Name.Font.Charset := gvSys.FontCharset;
end;

procedure TCodeEdit.SetFocus;
begin
  E_Code.SetFocus;
  E_Code.SelectAll;
end;

procedure TCodeEdit.SetLong(pValue: longint);
begin
  SetCode (StrInt(pValue,0));
end;

function TCodeEdit.GetLong: longint;
begin
  Result := E_Code.Long;
end;

procedure TCodeEdit.SetBefLong(pValue: longint);
begin
  E_Code.BefLong := pValue;
  SetCode (StrInt(pValue,0));
end;

function TCodeEdit.GetBefLong: longint;
begin
  Result := E_Code.BefLong;
end;

procedure TCodeEdit.SetCode(pValue: Str15);
var mMyOp: boolean;
begin
  E_Code.Text := pValue;
  If Search then begin
    If (E_Code.Text<>'') and (E_Code.Long<>0) then begin
      If Assigned (oDataSet) then begin
        mMyOp := not oDataSet.Active;
        If mMyOp then oDataSet.Open;
        oDataSet.SwapIndex;
        If oKeyNum<>oDataSet.IndexNumber then oDataSet.SetKeyNum (oKeyNum);
        If oFixedPos then oDataSet.SwapStatus;
        If not oDataSet.FindKey ([E_Code.Text]) then begin
          L_Name.Caption := '???';
        end
        else begin
          If oNameField=''
            then L_Name.Caption := 'Chyba: NameField nie je zadanÏ'
            else L_Name.Caption := oDataSet.FieldByName(oNameField).AsString;
        end;
        If oFixedPos then oDataSet.RestoreStatus;
        oDataSet.RestoreIndex;
        If mMyOp then oDataSet.Close;
      end
      else L_Name.Caption := 'Chyba: DataSet nie je zadanÏ'
    end
    else L_Name.Caption := ' ';
  end;
  If (oLastCode<>E_Code.Text) and Assigned (eOnChanged) then eOnChanged (Self);
  oLastCode := E_Code.Text;
end;

function TCodeEdit.GetCode: Str15;
begin
  Result := E_Code.Text;
end;

procedure TCodeEdit.SetText(pValue: Str30);
begin
  L_Name.Caption := pValue;
end;

function TCodeEdit.GetText: Str30;
begin
  Result := L_Name.Caption
end;

function  TCodeEdit.GetChanged: boolean;
begin
  Result := E_Code.Changed;
end;

procedure TCodeEdit.MyKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
begin
  If (Key=VK_RETURN) or (Key=VK_DOWN) or (Key=VK_UP) or (Key=VK_END) then SetCode (E_Code.Text);
  If Key=VK_F7 then  MyOnShowLst (Sender);
  If Assigned (eOnKeyDown) then eOnKeyDown (Sender,Key,Shift);
end;

procedure TCodeEdit.MyOnEnter (Sender: TObject);
begin
  If oStatusLine<>nil then begin
    oStatusLine.TabPosition := TabOrder;
    oStatusLine.CursorPosition := 0;
    oStatusLine.Description := Hint;
  end;
  If Assigned (eOnEnter) then eOnEnter (Sender);
end;

procedure TCodeEdit.MyOnAddItem (Sender: TObject);
begin
  If Assigned (eOnAddItem) then eOnAddItem (Sender);
end;

procedure TCodeEdit.MyOnModItem (Sender: TObject);
begin
  If Assigned (eOnModItem) then eOnModItem (Sender);
end;

procedure TCodeEdit.MyOnShowLst (Sender: TObject);
begin
  If Assigned (eOnShowLst) then eOnShowLst (Sender);
end;


procedure TCodeEdit.MyOnExit(Sender: TObject);
begin
  SetCode (E_Code.Text);
  If Assigned (eOnExit) then eOnExit (Sender);
end;

//***************** TDblCodeEdit *******************
constructor TDblCodeEdit.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  inherited OnEnter := MyOnEnter;
  inherited OnExit := MyOnExit;
  Width := 345;
  Height := 20;

  E_Code1 := TLongEdit.Create (Self);
  E_Code1.Parent := Self;
  E_Code1.OnKeyDown := MyKeyDown;

  E_Code2 := TLongEdit.Create (Self);
  E_Code2.Parent := Self;
  E_Code2.OnKeyDown := MyKeyDown;
  SetEditType (ceAccanl);

  L_Text := TSpecLabel.Create (Self);
  L_Text.Parent := Self;
  L_Text.Top := 2;
  L_Text.Left := 88;
  L_Text.Caption := '';
  L_Text.Font.Color := clNavy;
  L_Text.Font.Style := [fsBold];
  L_Text.Font.Charset := gvSys.FontCharset;

  Bevel := TBevel.Create (Self);
  Bevel.Parent := Self;
  Bevel.Left := 84;
  Bevel.Width := 238;
  Bevel.Height := 20;
  Bevel.Style := bsLowered;
  Bevel.Shape := bsBox;

  B_Slct := TSpeedButton.Create (Self);
  B_Slct.Parent := Self;
  B_Slct.Width := 20;
  B_Slct.Height := 20;
  B_Slct.Align := alRight;
  B_Slct.Glyph.LoadFromResourceName (HInstance,'SELECTBUTTON');
  B_Slct.NumGlyphs := 2;
  B_Slct.OnClick := ShowViewForm;

  oSearch := FALSE;
  oLastVal1 := '';
  oLastVal2 := '';
end;

destructor TDblCodeEdit.Destroy;
begin
  Bevel.Free;
  L_Text.Free;
  E_Code1.Free;
  E_Code2.Free;
  inherited;
end;

procedure TDblCodeEdit.Loaded;
begin
  Inherited;
  L_Text.Font.Charset := gvSys.FontCharset;
end;

procedure TDblCodeEdit.SetLong1(pValue: longint);
begin
  SetCode1 (StrInt(pValue,0));
end;

function TDblCodeEdit.GetLong1: longint;
begin
  Result := ValInt(E_Code1.Text);
end;

procedure TDblCodeEdit.SetLong2(pValue: longint);
begin
  SetCode2 (StrInt(pValue,0));
end;

function TDblCodeEdit.GetLong2: longint;
begin
  Result := ValInt(E_Code2.Text);
end;

procedure TDblCodeEdit.SetCode1(pValue: string);
begin
  E_Code1.Text := pValue;
  SearchData;
end;

function TDblCodeEdit.GetCode1: string;
begin
  Result := E_Code1.Text;
end;

procedure TDblCodeEdit.SetCode2(pValue: string);
begin
  E_Code2.Text := pValue;
  SearchData;
end;

function TDblCodeEdit.GetCode2: string;
begin
  Result := E_Code2.Text;
end;

procedure TDblCodeEdit.SetText(pValue: string);
begin
  L_Text.Caption := pValue;
end;

function TDblCodeEdit.GetText: string;
begin
  Result := L_Text.Caption
end;

procedure TDblCodeEdit.SetEditType (pValue:TEditType);
begin
  oEditType := pValue;
  If oEditType=ceAccanl then begin
    // Prvy editor
    E_Code1.Width := 30;
    E_Code1.MaxLength := 3;
    // Druhy editor
    E_Code2.Left := 31;
    E_Code2.Width := 50;
    E_Code2.MaxLength := 6;
  end
  else begin {Partner alebi iny typ}
    // Prvy editor
    E_Code1.Width := 50;
    // Druhy editor
    E_Code2.Left := 51;
    E_Code2.Width := 30;
  end;
  RecreateWnd;
end;

procedure TDblCodeEdit.MyKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
begin
  If (Key=VK_RETURN) or (Key=VK_DOWN) or (Key=VK_UP) or (Key=VK_END) then SearchData;
  If Key=VK_F7 then  ShowViewForm (Sender);
  If Assigned (eOnKeyDown) then eOnKeyDown (Sender,Key,Shift);
end;

procedure TDblCodeEdit.MyOnEnter (Sender: TObject);
begin
  If oStatusLine<>nil then begin
    oStatusLine.TabPosition := TabOrder;
    oStatusLine.CursorPosition := 0;
    oStatusLine.Description := Hint;
  end;
  If Assigned (eOnEnter) then eOnEnter (Sender);
end;

procedure TDblCodeEdit.MyOnExit (Sender: TObject);
begin
  SearchData;
  If Assigned (eOnExit) then eOnExit (Sender);
end;

procedure TDblCodeEdit.SearchData;
var mMyOp: boolean;
begin
  If oSearch then begin
    If (E_Code1.Text<>'') and (E_Code1.Text<>'') then begin
      If Assigned (oDataSet) then begin
        mMyOp := not oDataSet.Active;
        If mMyOp then oDataSet.Open;
        If oKeyNum>0 then oDataSet.SetKeyNum (oKeyNum);
        If not oDataSet.FindKey ([E_Code1.Text,E_Code2.Text]) then begin
          If oFieldNameText=''
            then L_Text.Caption := gNt.GetText ('CodeEdit.EmptyFieldNameText','Chyba: FieldNameText nie je zadan˝')
            else L_Text.Caption := oDataSet.FieldByName(oFieldNameText).AsString;
        end
        else L_Text.Caption := '???';
        If mMyOp then oDataSet.Close;
        If ((oLastVal1<>E_Code1.Text) or (oLastVal2<>E_Code2.Text))and Assigned (eOnChanged) then eOnChanged (Self);
        oLastVal1 := E_Code1.Text;
        oLastVal2 := E_Code2.Text;
      end
      else L_Text.Caption := gNt.GetText ('CodeEdit.EmptyDataSet','Chyba: DataSet nie je zadan˝');
    end
    else L_Text.Caption := ' ';
  end;
end;

procedure TDblCodeEdit.ShowViewForm (Sender: TObject);
var
  mViewForm: TViewForm;
  mMyOp: boolean;
begin
  mMyOp := not oDataSet.Active;
  If mMyOp then oDataSet.Open;
  mViewForm := TViewForm.Create (Self);
  mViewForm.DataSet := oDataSet;
  mViewForm.DgdName := oDgdName;
  mViewForm.Execute;
  If mViewForm.RecordSelect then begin
    E_Code1.Text := oDataSet.FieldByName (oFieldNameCode1).AsString;
    E_Code2.Text := oDataSet.FieldByName (oFieldNameCode2).AsString;
    L_Text.Caption := oDataSet.FieldByName (oFieldNameText).AsString;
  end;
  mViewForm.Free;
  If mMyOp then oDataSet.Close;
  If ((oLastVal1<>E_Code1.Text) or (oLastVal2<>E_Code2.Text))and Assigned (eOnChanged) then eOnChanged (Self);
  oLastVal1 := E_Code1.Text;
  oLastVal2 := E_Code2.Text;
end;

//***************** TIntervalEdit *******************
constructor TIntervalEdit.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  MaxLength := 0;
  Name := 'E_Interval';
end;

destructor TIntervalEdit.Destroy;
begin
  inherited Destroy;
end;

procedure TIntervalEdit.EditStringCut;
var mCut:TTxtCut;  mStr:string;  mPos,I:byte;
begin
  mCut := TTxtCut.Create;
  mCut.SetDelimiter ('');
  mCut.SetStr(Text);
  oIntvQnt := mCut.GetFldNum;
  For I:=1 to oIntvQnt do begin
    mStr := mCut.GetText(I);
    mPos := Pos('..',mStr);
    If mPos>0 then begin
      oIntervals[I].ValFr := StrToInt (copy(mStr,1,mPos-1));
      oIntervals[I].ValTo := StrToInt (copy(mStr,mPos+2,Length(mStr)-mPos+1));
    end
    else begin
      mPos := Pos('-',mStr);
      If mPos>0 then begin
        oIntervals[I].ValFr := StrToInt (copy(mStr,1,mPos-1));
        oIntervals[I].ValTo := StrToInt (copy(mStr,mPos+1,Length(mStr)-mPos));
      end
      else begin
        oIntervals[I].ValFr := mCut.GetNum(I);
        oIntervals[I].ValTo := oIntervals[I].ValFr;
      end;
    end;
  end;
  mCut.Free;
end;

function TIntervalEdit.GetIntvQnt: word;
begin
  EditStringCut;
  GetIntvQnt := oIntvQnt;
end;

function TIntervalEdit.GetItemQnt: word;
var mItemQnt,I:longint;
begin
  If (oIntvQnt=0) then EditStringCut;
  mItemQnt := 0;
  For I:=1 to oIntvQnt do
    mItemQnt := mItemQnt+GetIntvValTo(I)-GetIntvValFr(I)+1;
  Result := mItemQnt;
end;

function TIntervalEdit.GetIntvValFr;
begin
  Result := 0;
  If (oIntvQnt=0) then EditStringCut;
  If (oIntvQnt>0) then Result := oIntervals[pIndex].ValFr;
end;

function TIntervalEdit.GetIntvValTo;
begin
  Result := 0;
  If (oIntvQnt=0) then EditStringCut;
  If (oIntvQnt>0) then Result := oIntervals[pIndex].ValTo;
end;

function TIntervalEdit.DateInInt (pValue:TDate):boolean;
begin
  Result := DateInInterval(pValue,Text);
end;

function TIntervalEdit.StrInInt (pValue:string):boolean;
begin
  Result := StrInInterval(pValue,Text);
end;

function TIntervalEdit.FloatInInt (pValue:double):boolean;
begin
  Result := FloatInInterval(pValue,Text);
end;

function TIntervalEdit.LongInInt (pValue:longint):boolean;
begin
  Result := LongInInterval(pValue,Text);
end;

function TIntervalEdit.GetFirstDate:TDate;
var mFirst,mLast:TDate;
begin
  GetDateIntFirstLast (Text,mFirst,mLast);
  Result := mFirst;
end;

function TIntervalEdit.GetLastDate:TDate;
var mFirst,mLast:TDate;
begin
  GetDateIntFirstLast (Text,mFirst,mLast);
  Result := mLast;
end;

function TIntervalEdit.GetFirstStr:string;
var mFirst,mLast:string;
begin
  GetStrIntFirstLast (Text,mFirst,mLast);
  Result := mFirst;
end;

function TIntervalEdit.GetLastStr:string;
var mFirst,mLast:string;
begin
  GetStrIntFirstLast (Text,mFirst,mLast);
  Result := mLast;
end;

function TIntervalEdit.GetFirstFloat:double;
var mFirst,mLast:double;
begin
  GetFloatIntFirstLast (Text,mFirst,mLast);
  Result := mFirst;
end;

function TIntervalEdit.GetLastFloat:double;
var mFirst,mLast:double;
begin
  GetFloatIntFirstLast (Text,mFirst,mLast);
  Result := mLast;
end;

function TIntervalEdit.GetFirstLong:longint;
var mFirst,mLast:longint;
begin
  GetLongIntFirstLast (Text,mFirst,mLast);
  Result := mFirst;
end;

function TIntervalEdit.GetLastLong:longint;
var mFirst,mLast:longint;
begin
  GetLongIntFirstLast (Text,mFirst,mLast);
  Result := mLast;
end;

//***************** TMyEdit *******************

constructor TMyEdit.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  inherited OnEnter := MyOnEnter;
  inherited OnExit := MyOnExit;
  AutoSize := FALSE;
end;

procedure TMyEdit.MyOnEnter (Sender: TObject);
begin
  oEnterVal := Text;
  oColor := Color;
  Color := clAqua;
  If oStatusLine<>nil then begin
    oStatusLine.TabPosition := TabOrder;
    oStatusLine.CursorPosition := 0;
    oStatusLine.Description := Hint;
  end;
  SetFocus;
  If Assigned (eOnEnter) then eOnEnter (Sender);
end;

procedure TMyEdit.MyOnExit (Sender: TObject);
begin
  oChanged := oEnterVal<>Text;
  Color := oColor;
  If Assigned (eOnExit) then eOnExit (Sender);
end;

procedure TMyEdit.CreateParams(var Params: TCreateParams);
const Alignments: array[Boolean, TAlignment] of DWORD = ((ES_LEFT, ES_RIGHT, ES_CENTER),(ES_RIGHT, ES_LEFT, ES_CENTER));
begin
  inherited CreateParams(Params);
  with Params do
  begin
    Style := Style or Alignments[FALSE, FAlignment];
  end;
end;

procedure TMyEdit.SetAlignment(Value: TAlignment);
begin
  if FAlignment <> Value then
  begin
    FAlignment := Value;
    RecreateWnd;
  end;
end;

function TMyEdit.GetControlsAlignment: TAlignment;
begin
  Result := FAlignment;
end;

//***************** TDoubEdit *******************
constructor TDoubEdit.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  AutoSize := FALSE;
  oFract := 3;
  Height := 20;
  Width := 60;
  SetValue (0);
  Alignment := taRightJustify;
end;

procedure TDoubEdit.KeyDown(var Key: Word; Shift: TShiftState);
begin
  SpecKeyDownHandle (Self,Key,Shift);
  inherited;
end;

procedure TDoubEdit.SetValue(pValue: double);
begin
  Text := StrRealSepar (pValue,0,Fract,TRUE);
end;

function TDoubEdit.GetValue: double;
begin
  Result := ValDoub (ReplaceStr (Text,' ',''));
  end;

procedure TDoubEdit.SetFract(pValue: byte);
begin
  oFract := pValue;
  SetValue (GetValue);
end;


//***************** TSpecEdit *******************
constructor TSpecEdit.Create(AOwner: TComponent);
begin
  oFract := 3;
  inherited Create(AOwner);
  inherited OnEnter := MyOnEnter;
  inherited OnExit := MyOnExit;
  Height := 20;
  Width := 130;

  P_Background := TDinamicPanel.Create (Self);
  P_BackGround.Parent := Self;
  P_BackGround.BevelInner := bvNone;
  P_BackGround.BevelOuter := bvNone;
  P_BackGround.BorderStyle := bsSingle;
  P_BackGround.Align := alClient;
  P_BackGround.ColorThemes := acsStandard;
  P_BackGround.AutoExpand := TRUE;

  {Value Editor}
  E_Value := TMyEdit.Create (Self);
  E_Value.Parent := P_BackGround;
  E_Value.Align := alClient;
  E_Value.BorderStyle := bsNone;
  E_Value.MaxLength := 14;
//  If not FixedFont then begin
//    E_Value.Font.Name := gvSys.EditFontName;
//    E_Value.Font.Size := gvSys.EditFontSize;
//  end;
  E_Value.OnKeyDown := MyKeyDown;
  SetValue (0);

  {Info Label}
  L_SpecText := TLabel.Create (Self);
  L_SpecText.Parent := P_BackGround;
  L_SpecText.AutoSize := TRUE;
  L_SpecText.Align := alRight;
  L_SpecText.Alignment := taCenter;
  L_SpecText.Color := clBtnFace;
//  If not FixedFont then begin
//    L_SpecText.Font.Size := gvSys.LabelFontSize;
//    L_SpecText.Font.Name := gvSys.LabelFontName;
//  end;
  L_SpecText.Width := 0;
  L_SpecText.Caption := '';
  oLastVal := '';
end;

destructor TSpecEdit.Destroy;
begin
  L_SpecText.Free;
  E_Value.Free;
  inherited;
end;

procedure TSpecEdit.Loaded;
begin
  inherited;
  P_BackGround.ParentFont := TRUE;
  E_Value.ParentFont := TRUE;
  L_SpecText.ParentFont := TRUE;
(*
  If not E_Value.Enabled then begin
    E_Value.Color := clGray;
    E_Value.Font.Color := clWhite;
  end;
*)
end;

procedure TSpecEdit.SetFocus;
begin
  E_Value.SetFocus;
  If E_Value.AutoSelect then  E_Value.SelectAll;
end;

procedure TSpecEdit.Undo;
begin
  E_Value.Undo;
end;

procedure TSpecEdit.ClearUndo;
begin
  E_Value.ClearUndo;
end;

procedure TSpecEdit.MyOnEnter (Sender: TObject);
begin
  Modified := FALSE;
  E_Value.Color := clAqua;
//  E_Value.Font.Color := clBlack;
  If oStatusLine<>nil then begin
    oStatusLine.TabPosition := TabOrder;
    oStatusLine.CursorPosition := 0;
    oStatusLine.Description := Hint;
  end;
  E_Value.SetFocus;
  oEnterValue:= ValDoub (E_Value.Text);
  If Assigned (eOnEnter) then eOnEnter (Sender);
  oLastVal := E_Value.Text;
end;

procedure TSpecEdit.MyOnExit (Sender: TObject);
begin
//  E_Value.Text := StrDoub(ValInt (E_Value.Text),0,Fract);
  E_Value.Color := clWhite;
//  E_Value.Font.Color := clWhite;
  If (oLastVal<>E_Value.Text) and Assigned (eOnChanged) then eOnChanged (Self);
  If Assigned (eOnExit) then eOnExit (Sender);
  oLastVal := E_Value.Text;
end;

procedure TSpecEdit.MyKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
begin
  SpecKeyDownHandle (Self,Key,Shift);
  If Assigned(eOnKeyDown) then eOnKeyDown (Sender,Key,Shift);
end;

function  TSpecEdit.GetModified:boolean;
begin
  Result := E_Value.Modified;
end;

procedure TSpecEdit.SetModified (pValue:boolean);
begin
  E_Value.Modified := pValue;
end;

function  TSpecEdit.GetAutoSelect:boolean;
begin
  Result := E_Value.AutoSelect;
end;

procedure TSpecEdit.SetAutoSelect (pValue:boolean);
begin
  E_Value.AutoSelect := pValue;
end;

procedure TSpecEdit.SetValue(pValue: double);
begin
  E_Value.Text := StrDoub(pValue,0,Fract);
  If (oLastVal<>E_Value.Text) and Assigned (eOnChanged) then eOnChanged (Self);
  oLastVal := E_Value.Text;
end;

function TSpecEdit.GetValue: double;
begin
  Result := ValDoub (E_Value.Text);
end;

procedure TSpecEdit.SetBefValue(pValue: double);
begin
  SetValue (pValue);
  oBefvalue := pValue;
  oEnterValue:= ValDoub (E_Value.Text);
end;

function TSpecEdit.GetBefValue: double;
begin
  Result := oBefValue;
end;

procedure TSpecEdit.SetSpecText(pValue: Str10);
begin
  If pValue[1]<>' ' then pValue := ' '+pValue+' ';
  L_SpecText.Caption := pValue;
end;

function TSpecEdit.GetSpecText: Str10;
begin
  Result := L_SpecText.Caption;
end;

procedure TSpecEdit.SetFract(pValue: byte);
begin
  oFract := pValue;
  SetValue (GetValue);
end;

function TSpecEdit.GetFract: byte;
begin
  Result := oFract;
end;

procedure TSpecEdit.SetText(pValue: string);
begin
  E_Value.Text := pValue;
  If (oLastVal<>E_Value.Text) and Assigned (eOnChanged) then eOnChanged (Self);
  oLastVal := E_Value.Text;
end;

function TSpecEdit.GetText: string;
begin
  Result := E_Value.Text;
end;

procedure TSpecEdit.SetEnabled(pValue: boolean);
begin
  E_Value.Enabled := pValue;
end;

function TSpecEdit.GetEnabled: boolean;
begin
  Result := E_Value.Enabled;
end;

function TSpecEdit.GetChanged: boolean;
begin
  Result := GetValue<>oBefValue;
end;

//***************** TPriceEdit *******************
constructor TPriceEdit.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  Fract := 2;
  IntCoin := ctIntCoin;
  Measure := ctMeasure;
  E_Value.Alignment := taRightJustify;
end;

procedure TPriceEdit.Loaded;
begin
  inherited;
  IntCoin := ctIntCoin;
  Measure := ctMeasure;
end;

procedure TPriceEdit.SetIntCoin(pValue:string);
begin
  oIntCoin := pValue;
  SpecText := oIntCoin+'/'+oMeasure;
end;

function TPriceEdit.GetIntCoin: string;
begin
  Result := oIntCoin;
end;

procedure TPriceEdit.SetMeasure(pValue:string);
begin
  oMeasure := pValue;
  SpecText := oIntCoin+'/'+oMeasure;
end;

function TPriceEdit.GetMeasure: string;
begin
  Result := oMeasure;
end;

//***************** TValueEdit *******************
constructor TValueEdit.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  Width := 110;
  Fract := 2;
  SpecText := ctIntCoin;
  E_Value.Alignment := taRightJustify;
end;

procedure TValueEdit.Loaded;
begin
  inherited;
  SpecText := ctIntCoin;
end;

//***************** TQuantEdit *******************
constructor TQuantEdit.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  Width := 90;
  Fract := 3;
  SpecText := ctMeasure;
  SetQuant (0);
  E_Value.Alignment := taRightJustify;
end;

procedure TQuantEdit.Loaded;
begin
  inherited;
  SpecText := ctMeasure;
end;

procedure TQuantEdit.SetQuant(pValue: double);
begin
  Text := StrDoub(pValue,0,3);
end;

function TQuantEdit.GetQuant: double;
begin
  Result := ValDoub (Text);
end;

//***************** TPrcEdit *******************
constructor TPrcEdit.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  Width := 60;
  Fract := 2;
  SpecText := '%';
  E_Value.Alignment := taRightJustify;
end;

//***************** TVatEdit *******************
constructor TVatEdit.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  E_Value.Alignment := taRightJustify;
end;

//***************** TDateTimeEdit *******************
constructor TDateTimeEdit.Create (AOwner:TComponent);
begin
  inherited Create (AOwner);
  inherited OnEnter := MyOnEnter;
  inherited OnExit := MyOnExit;
  AutoSize := FALSE;
  Height := 20;
end;

procedure TDateTimeEdit.MyOnEnter (Sender: TObject);
begin
  Color := clAqua;
  If oStatusLine<>nil then begin
    oStatusLine.TabPosition := TabOrder;
    oStatusLine.CursorPosition := 0;
    oStatusLine.Description := Hint;
  end;
  SetFocus;
  If Assigned (eOnEnter) then eOnEnter (Sender);
end;

procedure TDateTimeEdit.MyOnExit (Sender: TObject);
begin
  Color := clWhite;
  If Assigned (eOnExit) then eOnExit (Sender);
end;

procedure TDateTimeEdit.KeyDown(var Key: Word; Shift: TShiftState);
begin
  SpecKeyDownHandle (Self,Key,Shift);
  If (Key=VK_DOWN) or (Key=VK_UP)then Key := 0;
  inherited;
end;

//***************** TDateEdit *******************
constructor TDateEdit.Create (AOwner:TComponent);
begin
  inherited Create (AOwner);
  inherited OnEnter := MyOnEnter;
  inherited OnExit := MyOnExit;
  Font.Name := gvSys.EditFontName;
  Font.Size := gvSys.EditFontSize;
  AutoSize := FALSE;
  Height := 20;
  Width := 70;
end;

procedure TDateEdit.CreateWnd;
begin
  inherited CreateWnd;
  If not FixedFont then begin
    Font.Name := gvSys.EditFontName;
    Font.Size := gvSys.EditFontSize;
  end;
end;

function  TDateEdit.GetDate:TDate;
begin
  try
    If Text=''
      then Result := 0
      else Result := StrToDate (Text);
  except GetDate := 0 end;
end;

procedure TDateEdit.SetDate (Value:TDate);
begin
  If Value=0
    then Text := ''
    else Text := DateToStr (Value);
end;

function  TDateEdit.GetBefDate:TDate;
begin
  Result := oBefDate;
end;

procedure TDateEdit.SetBefDate (Value:TDate);
begin
  oBefDate := Value;
  SetDate (Value);
end;

function TDateEdit.GetChanged:boolean;
begin
  Result := GetDate<>oBefDate;
end;

procedure TDateEdit.MyOnEnter (Sender: TObject);
begin
  Color := clAqua;
  If oStatusLine<>nil then begin
    oStatusLine.TabPosition := TabOrder;
    oStatusLine.CursorPosition := 0;
    oStatusLine.Description := Hint;
  end;
  If Assigned (eOnEnter) then eOnEnter (Sender);
end;

procedure TDateEdit.MyOnExit (Sender: TObject);
begin
  Color := clWhite;
  Text := VerifyDate (Text);
  If Assigned (eOnExit) then eOnExit (Sender);
end;

procedure TDateEdit.KeyDown(var Key: Word; Shift: TShiftState);
begin
  SpecKeyDownHandle (Self,Key,Shift);
  inherited;
end;


//***************** TTimeEdit *******************
constructor TTimeEdit.Create (AOwner:TComponent);
begin
  inherited Create (AOwner);
  Width := 90;
  Kind := dtkTime;
end;

procedure TTimeEdit.CreateWnd;
begin
  inherited CreateWnd;
  Time:=SysUtils.Time;
  If not FixedFont then begin
    Font.Name := gvSys.EditFontName;
    Font.Size := gvSys.EditFontSize;
  end;
  Height := 20;
end;
//***************** TCodeNameEdit *******************
constructor TCodeNameEdit.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  inherited OnEnter := MyOnEnter;
  inherited OnExit := MyOnExit;
  inherited OnResize := MyOnResize;
  Width := 304;
  Height := 20;

  E_Name := TNameEdit.Create (Self);
  E_Name.Parent := Self;
  E_Name.OnKeyDown := MyKeyDown;
  E_Name.Left := 54;
  E_Name.Width := 228;

  L_Code := TLabel.Create (Self);
  L_Code.Parent := Self;
  L_Code.Top := 2;
  L_Code.Left := 4;
  L_Code.Width := 46;
  L_Code.Caption := '';
  If not FixedFont then begin
    L_Code.Font.Name := gvSys.LabelFontName;
    L_Code.Font.Size := gvSys.LabelFontSize;
  end;
  L_Code.Font.Color := clNavy;
  L_Code.Font.Style := [fsBold];

  Bevel := TBevel.Create (Self);
  Bevel.Parent := Self;
  Bevel.Left := 0;
  Bevel.Width := 50;
  Bevel.Height := 20;
  Bevel.Style := bsLowered;
  Bevel.Shape := bsBox;

  B_Slct := TSpeedButton.Create (Self);
  B_Slct.Parent := Self;
  B_Slct.Width := 20;
  B_Slct.Height := 20;
  B_Slct.Align := alRight;
  B_Slct.Glyph.LoadFromResourceName (HInstance,'SELECTBUTTON');
  B_Slct.NumGlyphs := 2;
  B_Slct.OnClick := MyOnShowLst;

  oShowCode := TRUE;
  oSearch := FALSE;
  oLastVal := '';
end;

destructor TCodeNameEdit.Destroy;
begin
  Bevel.Free;
  L_Code.Free;
  E_Name.Free;
  inherited;
end;

procedure TCodeNameEdit.SetCode(pValue: Str10);
begin
  L_Code.Caption := pValue;
end;

function TCodeNameEdit.GetCode: Str10;
begin
  Result := L_Code.Caption;
end;

procedure TCodeNameEdit.SetText(pValue: Str30);
begin
  E_Name.Text := pValue;
  If (oLastVal<>E_Name.Text) then begin
    MySearch;
    oLastVal := E_Name.Text;
    If Assigned (eOnChanged) then eOnChanged (Self);
  end;
end;

function TCodeNameEdit.GetText: Str30;
begin
  Result := E_Name.Text;
end;

procedure TCodeNameEdit.SetShowCode(pValue: boolean);
begin
  oShowCode := pValue;
  MyOnResize (Self);
end;

procedure TCodeNameEdit.MyKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
begin
  If (Key=VK_RETURN) or (Key=VK_DOWN) or (Key=VK_UP) or (Key=VK_END) then SetText (E_Name.Text);
  If Key=VK_F7 then  MyOnShowLst (Sender);
  If Assigned (eOnKeyDown) then eOnKeyDown (Sender,Key,Shift);
end;

procedure TCodeNameEdit.MyOnEnter (Sender: TObject);
begin
  If oStatusLine<>nil then begin
    oStatusLine.TabPosition := TabOrder;
    oStatusLine.CursorPosition := 0;
    oStatusLine.Description := Hint;
  end;
  If Assigned (eOnEnter) then eOnEnter (Sender);
end;

procedure TCodeNameEdit.MyOnExit (Sender: TObject);
begin
  If (oLastVal<>E_Name.Text) then begin
    MySearch;
    oLastVal := E_Name.Text;
    If Assigned (eOnChanged) then eOnChanged (Self);
  end;
  If Assigned (eOnExit) then eOnExit (Sender);
end;

procedure TCodeNameEdit.MyOnResize(Sender:TObject);
begin
  If oShowCode then begin
    E_Name.Left := 54;
    E_Name.Width := Width-74;
  end
  else begin
    E_Name.Left := 0;
    E_Name.Width := Width-20;
  end;
end;

procedure TCodeNameEdit.MyOnAddItem (Sender: TObject);
begin
  If Assigned (eOnAddItem) then eOnAddItem (Sender);
end;

procedure TCodeNameEdit.MyOnShowLst (Sender: TObject);
begin
  If Assigned (eOnShowLst) then eOnShowLst (Sender);
end;

procedure TCodeNameEdit.MySearch;
var mMyOp, mFind: boolean;  mI: byte;
begin
  If oSearch then begin
    If (E_Name.Text<>'') then begin
      If Assigned (oDataSet) then begin
        mMyOp := not oDataSet.Active;
        If mMyOp then oDataSet.Open;
        If (oSrchField<>'') then begin
          mFind:=FALSE;mI:=0;
          while not mFind and (mI<=LineElementNum (oSrchField,';')) do begin
            If Pos('_',LineElement (oSrchField,mI,';'))>0
              then mFind:= oDataSet.Locate (LineElement (oSrchField,mI,';'),VarArrayOf([StrToAlias(E_Name.Text)]),[])
              else mFind:= oDataSet.Locate (LineElement (oSrchField,mI,';'),VarArrayOf([E_Name.Text]),[]);
            If not mFind then Inc (mI);
          end;
          If mFind then begin
            If oCodeField=''
              then L_Code.Caption := 'Chyba: CodeField nie je zadanÏ'
              else L_Code.Caption := oDataSet.FieldByName(oCodeField).AsString;
            If oNameField=''
              then E_Name.Text := ''//'Chyba: NameField nie je zadanÏ'
              else E_Name.Text := oDataSet.FieldByName(oNameField).AsString;
          end;
        end else L_Code.Caption := 'Chyba: SrchField nie je zadanÏ';
        If mMyOp then oDataSet.Close;
      end
      else L_Code.Caption := 'Chyba: DataSet nie je zadanÏ'
    end
    else L_Code.Caption := ' ';
  end;
  oLastVal := E_Name.Text;
end;

//***************** TFLongEdit *******************
constructor TFLongEdit.Create(AOwner: TComponent);
begin
  inherited;
  Font.Name := 'Arial';
  oLongEdit1 := TLongEdit.Create (Self);
  oLongEdit1.Parent := Self;
  oLongEdit1.ParentFont := TRUE;
  oLongEdit1.Left := 0;
  oLongEdit1.Top := 0;
  oLabel1 := TLabel.Create (Self);
  oLabel1.Parent := Self;
  oLabel1.Caption := '  -  ';
  oLabel1.Left := oLongEdit1.Left+oLongEdit1.Width;
  oLabel1.Top := (oLongEdit1.Height-oLabel1.Height) div 2;
  oLongEdit2 := TLongEdit.Create (Self);
  oLongEdit2.Parent := Self;
  oLongEdit2.ParentFont := TRUE;
  oLongEdit2.Left := oLabel1.Left+oLabel1.Width;
  oLongEdit2.Top := 0;
  Width := oLongEdit2.Left+oLongEdit2.Width;
  Height := oLongEdit2.Height;
  OnResize := MyOnResize;
  Font.OnChange := MyOnResize;
end;

destructor  TFLongEdit.Destroy;
begin
  oLongEdit1.Free;
  oLongEdit2.Free;
  oLabel1.Free;
  inherited;
end;

procedure TFLongEdit.SetFocus;
begin
  oLongEdit1.SetFocus;
  oLongEdit1.SelectAll;
end;

procedure TFLongEdit.SetFocus2;
begin
  oLongEdit2.SetFocus;
  oLongEdit2.SelectAll;
end;

function  TFLongEdit.GetLong1:longint;
begin
  GetLong1 := oLongEdit1.Long;
end;

procedure  TFLongEdit.SetLong1 (Value:longint);
begin
  oLongEdit1.Long := Value;
end;

function  TFLongEdit.GetLong2:longint;
begin
  GetLong2 := oLongEdit2.Long;
end;

procedure TFLongEdit.SetLong2 (Value:longint);
begin
  oLongEdit2.Long := Value;
end;

function  TFLongEdit.GetMaxLength:longint;
begin
  GetMaxLength := oLongEdit1.MaxLength;
end;

procedure TFLongEdit.SetMaxLength (Value:longint);
begin
  oLongEdit1.MaxLength := Value;
  oLongEdit2.MaxLength := Value;
end;

function  TFLongEdit.GetReadOnly:boolean;
begin
 GetReadOnly := oLongEdit1.ReadOnly;
end;

procedure TFLongEdit.SetReadOnly (Value:boolean);
begin
  oLongEdit1.ReadOnly := Value;
  oLongEdit2.ReadOnly := Value;
end;

function  TFLongEdit.GetHint1:string;
begin
  GetHint1 := oLongEdit1.Hint;
end;

procedure TFLongEdit.SetHint1 (Value:string);
begin
  oLongEdit1.Hint := Value;
end;

function  TFLongEdit.GetHint2:string;
begin
  GetHint2 := oLongEdit2.Hint;
end;

procedure TFLongEdit.SetHint2 (Value:string);
begin
  oLongEdit2.Hint := Value;
end;

function  TFLongEdit.GetStatusLine:TStatusLine;
begin
  GetStatusLine := oLongEdit1.StatusLine;
end;

procedure TFLongEdit.SetStatusLine (Value:TStatusLine);
begin
  oLongEdit1.StatusLine := Value;
  oLongEdit2.StatusLine := Value;
end;

procedure TFLongEdit.MyOnResize (Sender:TObject);
begin
  oLongEdit1.Font := Font;
  oLongEdit2.Font := Font;
  oLabel1.Font := Font;

  oLongEdit1.Height := Height;
  oLongEdit2.Height := Height;
  oLongEdit1.Width := (Width-oLabel1.Width) div 2;
  oLongEdit2.Width := oLongEdit1.Width;

  oLongEdit1.Top := 0;
  oLabel1.Top := (oLongEdit1.Height-oLabel1.Height) div 2;
  oLongEdit2.Top := 0;

  oLongEdit1.Left := 0;
  oLabel1.Left := oLongEdit1.Left+oLongEdit1.Width;
  oLongEdit2.Left := oLabel1.Left+oLabel1.Width;
end;

//***************** TFPriceEdit *******************
constructor TFPriceEdit.Create(AOwner: TComponent);
begin
  inherited;
  Font.Name := 'Arial';
  oPriceEdit1 := TPriceEdit.Create (Self);
  oPriceEdit1.Parent := Self;
  oPriceEdit1.ParentFont := TRUE;
  oPriceEdit1.Left := 0;
  oPriceEdit1.Top := 0;
  oLabel1 := TLabel.Create (Self);
  oLabel1.Parent := Self;
  oLabel1.Caption := '  -  ';
  oLabel1.Left := oPriceEdit1.Left+oPriceEdit1.Width;
  oLabel1.Top := (oPriceEdit1.Height-oLabel1.Height) div 2;
  oLabel1.Font.Charset := gvSys.FontCharset;
  oPriceEdit2 := TPriceEdit.Create (Self);
  oPriceEdit2.Parent := Self;
  oPriceEdit2.ParentFont := TRUE;
  oPriceEdit2.Left := oLabel1.Left+oLabel1.Width;
  oPriceEdit2.Top := 0;
  Width := oPriceEdit2.Left+oPriceEdit2.Width;
  Height := oPriceEdit2.Height;
  OnResize := MyOnResize;
  Font.OnChange := MyOnResize;
end;

destructor  TFPriceEdit.Destroy;
begin
  oPriceEdit1.Free;
  oPriceEdit2.Free;
  oLabel1.Free;
  inherited;
end;

procedure TFPriceEdit.SetFocus;
begin
  oPriceEdit1.SetFocus;
end;

procedure TFPriceEdit.SetFocus2;
begin
  oPriceEdit2.SetFocus;
end;

procedure  TFPriceEdit.Loaded;
begin
  inherited;
  oLabel1.Font.Charset := gvSys.FontCharset;
end;

function  TFPriceEdit.GetValue1:double;
begin
  GetValue1 := oPriceEdit1.Value;
end;

procedure  TFPriceEdit.SetValue1 (Value:double);
begin
  oPriceEdit1.Value := Value;
end;

function  TFPriceEdit.GetValue2:double;
begin
  GetValue2 := oPriceEdit2.Value;
end;

procedure TFPriceEdit.SetValue2 (Value:double);
begin
  oPriceEdit2.Value := Value;
end;

function  TFPriceEdit.GetHint1:string;
begin
  GetHint1 := oPriceEdit1.Hint;
end;

procedure TFPriceEdit.SetHint1 (Value:string);
begin
  oPriceEdit1.Hint := Value;
end;

function  TFPriceEdit.GetHint2:string;
begin
  GetHint2 := oPriceEdit2.Hint;
end;

procedure TFPriceEdit.SetHint2 (Value:string);
begin
  oPriceEdit2.Hint := Value;
end;

function  TFPriceEdit.GetStatusLine:TStatusLine;
begin
  GetStatusLine := oPriceEdit1.StatusLine;
end;

procedure TFPriceEdit.SetStatusLine (Value:TStatusLine);
begin
  oPriceEdit1.StatusLine := Value;
  oPriceEdit2.StatusLine := Value;
end;

function  TFPriceEdit.GetIntCoin:string;
begin
  GetIntCoin := oPriceEdit1.IntCoin;
end;

procedure TFPriceEdit.SetIntCoin (Value:string);
begin
  oPriceEdit1.IntCoin := Value;
  oPriceEdit2.IntCoin := Value;
end;

function  TFPriceEdit.GetMeasure:string;
begin
  GetMeasure := oPriceEdit1.Measure;
end;

procedure TFPriceEdit.SetMeasure (Value:string);
begin
  oPriceEdit1.Measure := Value;
  oPriceEdit2.Measure := Value;
end;

function  TFPriceEdit.GetFract:byte;
begin
  GetFract := oPriceEdit1.Fract;
end;

procedure TFPriceEdit.SetFract (Value:byte);
begin
  oPriceEdit1.Fract := Value;
  oPriceEdit2.Fract := Value;
end;

procedure TFPriceEdit.MyOnResize (Sender:TObject);
begin
  oPriceEdit1.Font := Font;
  oPriceEdit2.Font := Font;
  oLabel1.Font := Font;

  oPriceEdit1.Height := Height;
  oPriceEdit2.Height := Height;
  oPriceEdit1.Width := (Width-oLabel1.Width) div 2;
  oPriceEdit2.Width := oPriceEdit1.Width;

  oPriceEdit1.Top := 0;
  oLabel1.Top := (oPriceEdit1.Height-oLabel1.Height) div 2;
  oPriceEdit2.Top := 0;

  oPriceEdit1.Left := 0;
  oLabel1.Left := oPriceEdit1.Left+oPriceEdit1.Width;
  oPriceEdit2.Left := oLabel1.Left+oLabel1.Width;
end;

//***************** TFValueEdit *******************
constructor TFValueEdit.Create(AOwner: TComponent);
begin
  inherited;
  Font.Name := 'Arial';
  oValueEdit1 := TValueEdit.Create (Self);
  oValueEdit1.Parent := Self;
  oValueEdit1.ParentFont := TRUE;
  oValueEdit1.Left := 0;
  oValueEdit1.Top := 0;
  oLabel1 := TLabel.Create (Self);
  oLabel1.Parent := Self;
  oLabel1.Caption := '  -  ';
  oLabel1.Left := oValueEdit1.Left+oValueEdit1.Width;
  oLabel1.Top := (oValueEdit1.Height-oLabel1.Height) div 2;
  oLabel1.Font.Charset := gvSys.FontCharset;
  oValueEdit2 := TValueEdit.Create (Self);
  oValueEdit2.Parent := Self;
  oValueEdit2.ParentFont := TRUE;
  oValueEdit2.Left := oLabel1.Left+oLabel1.Width;
  oValueEdit2.Top := 0;
  Width := oValueEdit2.Left+oValueEdit2.Width;
  Height := oValueEdit2.Height;
  OnResize := MyOnResize;
  Font.OnChange := MyOnResize;
end;

destructor  TFValueEdit.Destroy;
begin
  oValueEdit1.Free;
  oValueEdit2.Free;
  oLabel1.Free;
  inherited;
end;

procedure TFvalueEdit.SetFocus;
begin
  oValueEdit1.SetFocus;
end;

procedure TFvalueEdit.SetFocus2;
begin
  oValueEdit2.SetFocus;
end;

procedure  TFvalueEdit.Loaded;
begin
  inherited;
  oLabel1.Font.Charset := gvSys.FontCharset;
end;

function  TFValueEdit.GetValue1:double;
begin
  GetValue1 := oValueEdit1.Value;
end;

procedure  TFvalueEdit.SetValue1 (Value:double);
begin
  oValueEdit1.Value := Value;
end;

function  TFValueEdit.GetValue2:double;
begin
  GetValue2 := oValueEdit2.Value;
end;

procedure TFValueEdit.SetValue2 (Value:double);
begin
  oValueEdit2.Value := Value;
end;

function  TFValueEdit.GetHint1:string;
begin
  GetHint1 := oValueEdit1.Hint;
end;

procedure TFValueEdit.SetHint1 (Value:string);
begin
  oValueEdit1.Hint := Value;
end;

function  TFValueEdit.GetHint2:string;
begin
  GetHint2 := oValueEdit2.Hint;
end;

procedure TFValueEdit.SetHint2 (Value:string);
begin
  oValueEdit2.Hint := Value;
end;

function  TFValueEdit.GetStatusLine:TStatusLine;
begin
  GetStatusLine := oValueEdit1.StatusLine;
end;

procedure TFvalueEdit.SetStatusLine (Value:TStatusLine);
begin
  oValueEdit1.StatusLine := Value;
  oValueEdit2.StatusLine := Value;
end;

function  TFValueEdit.GetSpecText:Str10;
begin
  GetSpecText := oValueEdit1.SpecText;
end;

procedure TFValueEdit.SetSpecText (Value:Str10);
begin
  oValueEdit1.SpecText := Value;
  oValueEdit2.SpecText := Value;
end;

function  TFValueEdit.GetFract:byte;
begin
  GetFract := oValueEdit1.Fract;
end;

procedure TFValueEdit.SetFract (Value:byte);
begin
  oValueEdit1.Fract := Value;
  oValueEdit2.Fract := Value;
end;

procedure TFValueEdit.MyOnResize (Sender:TObject);
begin
  oValueEdit1.Font := Font;
  oValueEdit2.Font := Font;
  oLabel1.Font := Font;

  oValueEdit1.Height := Height;
  oValueEdit2.Height := Height;
  ovalueEdit1.Width := (Width-oLabel1.Width) div 2;
  oValueEdit2.Width := oValueEdit1.Width;

  oValueEdit1.Top := 0;
  oLabel1.Top := (oValueEdit1.Height-oLabel1.Height) div 2;
  oValueEdit2.Top := 0;

  oValueEdit1.Left := 0;
  oLabel1.Left := oValueEdit1.Left+oValueEdit1.Width;
  oValueEdit2.Left := oLabel1.Left+oLabel1.Width;
end;

//***************** TFQuantEdit *******************
constructor TFQuantEdit.Create(AOwner: TComponent);
begin
  inherited;
  Font.Name := 'Arial';
  oQuantEdit1 := TQuantEdit.Create (Self);
  oQuantEdit1.Parent := Self;
  oQuantEdit1.ParentFont := TRUE;
  oQuantEdit1.Left := 0;
  oQuantEdit1.Top := 0;
  oLabel1 := TLabel.Create (Self);
  oLabel1.Parent := Self;
  oLabel1.Caption := '  -  ';
  oLabel1.Left := oQuantEdit1.Left+oQuantEdit1.Width;
  oLabel1.Top := (oQuantEdit1.Height-oLabel1.Height) div 2;
  oLabel1.Font.Charset := gvSys.FontCharset;
  oQuantEdit2 := TQuantEdit.Create (Self);
  oQuantEdit2.Parent := Self;
  oQuantEdit2.ParentFont := TRUE;
  oQuantEdit2.Left := oLabel1.Left+oLabel1.Width;
  oQuantEdit2.Top := 0;
  Width := oQuantEdit2.Left+oQuantEdit2.Width;
  Height := oQuantEdit2.Height;
  OnResize := MyOnResize;
  Font.OnChange := MyOnResize;
end;

destructor  TFQuantEdit.Destroy;
begin
  oQuantEdit1.Free;
  oQuantEdit2.Free;
  oLabel1.Free;
  inherited;
end;

procedure TFQuantEdit.SetFocus;
begin
  oQuantEdit1.SetFocus;
end;

procedure TFQuantEdit.SetFocus2;
begin
  oQuantEdit2.SetFocus;
end;

procedure  TFQuantEdit.Loaded;
begin
  inherited;
  oLabel1.Font.Charset := gvSys.FontCharset;
end;

function  TFQuantEdit.GetValue1:double;
begin
  GetValue1 := oQuantEdit1.Value;
end;

procedure  TFQuantEdit.SetValue1 (Value:double);
begin
  oQuantEdit1.Value := Value;
end;

function  TFQuantEdit.GetValue2:double;
begin
  GetValue2 := oQuantEdit2.Value;
end;

procedure TFQuantEdit.SetValue2 (Value:double);
begin
  oQuantEdit2.Value := Value;
end;

function  TFQuantEdit.GetHint1:string;
begin
  GetHint1 := oQuantEdit1.Hint;
end;

procedure TFQuantEdit.SetHint1 (Value:string);
begin
  oQuantEdit1.Hint := Value;
end;

function  TFQuantEdit.GetHint2:string;
begin
  GetHint2 := oQuantEdit2.Hint;
end;

procedure TFQuantEdit.SetHint2 (Value:string);
begin
  oQuantEdit2.Hint := Value;
end;

function  TFQuantEdit.GetStatusLine:TStatusLine;
begin
  GetStatusLine := oQuantEdit1.StatusLine;
end;

procedure TFQuantEdit.SetStatusLine (Value:TStatusLine);
begin
  oQuantEdit1.StatusLine := Value;
  oQuantEdit2.StatusLine := Value;
end;

function  TFQuantEdit.GetSpecText:Str10;
begin
  GetSpecText := oQuantEdit1.SpecText;
end;

procedure TFQuantEdit.SetSpecText (Value:Str10);
begin
  oQuantEdit1.SpecText := Value;
  oQuantEdit2.SpecText := Value;
end;

function  TFQuantEdit.GetFract:byte;
begin
  GetFract := oQuantEdit1.Fract;
end;

procedure TFQuantEdit.SetFract (Value:byte);
begin
  oQuantEdit1.Fract := Value;
  oQuantEdit2.Fract := Value;
end;

procedure TFQuantEdit.MyOnResize (Sender:TObject);
begin
  oQuantEdit1.Font := Font;
  oQuantEdit2.Font := Font;
  oLabel1.Font := Font;

  oQuantEdit1.Height := Height;
  oQuantEdit2.Height := Height;
  oQuantEdit1.Width := (Width-oLabel1.Width) div 2;
  oQuantEdit2.Width := oQuantEdit1.Width;

  oQuantEdit1.Top := 0;
  oLabel1.Top := (oQuantEdit1.Height-oLabel1.Height) div 2;
  oQuantEdit2.Top := 0;

  oQuantEdit1.Left := 0;
  oLabel1.Left := oQuantEdit1.Left+oQuantEdit1.Width;
  oQuantEdit2.Left := oLabel1.Left+oLabel1.Width;
end;

//***************** TFPrcEdit *******************
constructor TFPrcEdit.Create(AOwner: TComponent);
begin
  inherited;
  Font.Name := 'Arial';
  oPrcEdit1 := TPrcEdit.Create (Self);
  oPrcEdit1.Parent := Self;
  oPrcEdit1.ParentFont := TRUE;
  oPrcEdit1.Left := 0;
  oPrcEdit1.Top := 0;
  oLabel1 := TLabel.Create (Self);
  oLabel1.Parent := Self;
  oLabel1.Caption := '  -  ';
  oLabel1.Left := oPrcEdit1.Left+oPrcEdit1.Width;
  oLabel1.Top := (oPrcEdit1.Height-oLabel1.Height) div 2;
  oPrcEdit2 := TPrcEdit.Create (Self);
  oPrcEdit2.Parent := Self;
  oPrcEdit2.ParentFont := TRUE;
  oPrcEdit2.Left := oLabel1.Left+oLabel1.Width;
  oPrcEdit2.Top := 0;
  Width := oPrcEdit2.Left+oPrcEdit2.Width;
  Height := oPrcEdit2.Height;
  OnResize := MyOnResize;
  Font.OnChange := MyOnResize;
end;

destructor  TFPrcEdit.Destroy;
begin
  oPrcEdit1.Free;
  oPrcEdit2.Free;
  oLabel1.Free;
  inherited;
end;

procedure TFPrcEdit.SetFocus;
begin
  oPrcEdit1.SetFocus;
end;

procedure TFPrcEdit.SetFocus2;
begin
  oPrcEdit2.SetFocus;
end;

function  TFPrcEdit.GetValue1:double;
begin
  GetValue1 := oPrcEdit1.Value;
end;

procedure  TFPrcEdit.SetValue1 (Value:double);
begin
  oPrcEdit1.Value := Value;
end;

function  TFPrcEdit.GetValue2:double;
begin
  GetValue2 := oPrcEdit2.Value;
end;

procedure TFPrcEdit.SetValue2 (Value:double);
begin
  oPrcEdit2.Value := Value;
end;

function  TFPrcEdit.GetHint1:string;
begin
  GetHint1 := oPrcEdit1.Hint;
end;

procedure TFPrcEdit.SetHint1 (Value:string);
begin
  oPrcEdit1.Hint := Value;
end;

function  TFPrcEdit.GetHint2:string;
begin
  GetHint2 := oPrcEdit2.Hint;
end;

procedure TFPrcEdit.SetHint2 (Value:string);
begin
  oPrcEdit2.Hint := Value;
end;

function  TFPrcEdit.GetStatusLine:TStatusLine;
begin
  GetStatusLine := oPrcEdit1.StatusLine;
end;

procedure TFPrcEdit.SetStatusLine (Value:TStatusLine);
begin
  oPrcEdit1.StatusLine := Value;
  oPrcEdit2.StatusLine := Value;
end;

procedure TFPrcEdit.MyOnResize (Sender:TObject);
begin
  oPrcEdit1.Font := Font;
  oPrcEdit2.Font := Font;
  oLabel1.Font := Font;

  oPrcEdit1.Height := Height;
  oPrcEdit2.Height := Height;
  oPrcEdit1.Width := (Width-oLabel1.Width) div 2;
  oPrcEdit2.Width := oPrcEdit1.Width;

  oPrcEdit1.Top := 0;
  oLabel1.Top := (oPrcEdit1.Height-oLabel1.Height) div 2;
  oPrcEdit2.Top := 0;

  oPrcEdit1.Left := 0;
  oLabel1.Left := oPrcEdit1.Left+oPrcEdit1.Width;
  oPrcEdit2.Left := oLabel1.Left+oLabel1.Width;
end;

//***************** TFDateEdit *******************
constructor TFDateEdit.Create(AOwner: TComponent);
begin
  inherited Create (AOwner);
  Font.Name := 'Arial';
  oDateEdit1 := TDateEdit.Create (Self);
//  oDateEdit1.ParentFont := TRUE;
  oDateEdit1.Left := 0;
  oDateEdit1.Top := 0;
  oLabel1 := TLabel.Create (Self);
  oLabel1.Parent := Self;
  oLabel1.Caption := '  -  ';
  oLabel1.Left := oDateEdit1.Left+oDateEdit1.Width;
  oLabel1.Top := (oDateEdit1.Height-oLabel1.Height) div 2;
  oDateEdit2 := TDateEdit.Create (Self);
//  oDateEdit2.ParentFont := TRUE;
  oDateEdit2.Left := oLabel1.Left+oLabel1.Width;
  oDateEdit2.Top := 0;
  Width := oDateEdit2.Left+oDateEdit2.Width;
  Height := oDateEdit2.Height;
end;

destructor  TFDateEdit.Destroy;
begin
  oDateEdit1.Free;
  oDateEdit2.Free;
  oLabel1.Free;
  inherited Destroy;
end;

procedure TFDateEdit.SetFocus;
begin
  oDateEdit1.SetFocus;
end;

procedure TFDateEdit.SetFocus2;
begin
  oDateEdit2.SetFocus;
end;

function TFDateEdit.InInterval (pDate:TDateTime): boolean; // TRUE ak zadany datum je z intervalu
begin
  Result := InDateInterval (Date1,Date2,pDate);
end;

procedure TFDateEdit.CreateWnd;
begin
  inherited CreateWnd;
  oDateEdit1.Parent :=  Self;
  oDateEdit2.Parent := Self;
  OnResize := MyOnResize;
  Font.OnChange := MyOnResize;
  MyOnResize (Self);
end;

function  TFDateEdit.GetDate1:TDate;
begin
  If oDateEdit1<>nil then GetDate1 := oDateEdit1.Date;
end;

procedure  TFDateEdit.SetDate1 (Value:TDate);
begin
  If oDateEdit1<>nil then oDateEdit1.Date := Value;
end;

function  TFDateEdit.GetDate2:TDate;
begin
  If oDateEdit2<>nil then GetDate2 := oDateEdit2.Date;
end;

procedure TFDateEdit.SetDate2 (Value:TDate);
begin
  If oDateEdit2<>nil then oDateEdit2.Date := Value;
end;

function  TFDateEdit.GetHint1:string;
begin
  If oDateEdit1<>nil then GetHint1 := oDateEdit1.Hint;
end;

procedure TFDateEdit.SetHint1 (Value:string);
begin
  If oDateEdit1<>nil then oDateEdit1.Hint := Value;
end;

function  TFDateEdit.GetHint2:string;
begin
  If oDateEdit2<>nil then GetHint2 := oDateEdit2.Hint;
end;

procedure TFDateEdit.SetHint2 (Value:string);
begin
  If oDateEdit2<>nil then oDateEdit2.Hint := Value;
end;

function  TFDateEdit.GetStatusLine:TStatusLine;
begin
  If oDateEdit1<>nil then GetStatusLine := oDateEdit1.StatusLine;
end;

procedure TFDateEdit.SetStatusLine (Value:TStatusLine);
begin
  If oDateEdit1<>nil then begin
    oDateEdit1.StatusLine := Value;
    oDateEdit2.StatusLine := Value;
  end;
end;

function  TFDateEdit.GetChecked1:boolean;
begin
  GetChecked1 := oDateEdit1.Checked;
end;

procedure TFDateEdit.SetChecked1 (Value:boolean);
begin
  oDateEdit1.Checked := Value;
end;

function  TFDateEdit.GetChecked2:boolean;
begin
  GetChecked2 := oDateEdit2.Checked;
end;

procedure TFDateEdit.SetChecked2 (Value:boolean);
begin
  oDateEdit2.Checked := Value;
end;

function  TFDateEdit.GetShowCheckbox1:boolean;
begin
  GetShowCheckbox1 := oDateEdit1.ShowCheckbox;
end;

procedure TFDateEdit.SetShowCheckbox1 (Value:boolean);
begin
  oDateEdit1.ShowCheckbox := Value;
end;

function  TFDateEdit.GetShowCheckbox2:boolean;
begin
  GetShowCheckbox2 := oDateEdit2.ShowCheckbox;
end;

procedure TFDateEdit.SetShowCheckbox2 (Value:boolean);
begin
  oDateEdit2.ShowCheckbox := Value;
end;

procedure TFDateEdit.MyOnResize (Sender:TObject);
begin
  oDateEdit1.Font := Font;
  oDateEdit2.Font := Font;
  oLabel1.Font := Font;

  oDateEdit1.Height := Height;
  oDateEdit2.Height := Height;
  oDateEdit1.Width := (Width-oLabel1.Width) div 2;
  oDateEdit2.Width := oDateEdit1.Width;

  oDateEdit1.Top := 0;
  oLabel1.Top := (oDateEdit1.Height-oLabel1.Height) div 2;
  oDateEdit2.Top := 0;

  oDateEdit1.Left := 0;
  oLabel1.Left := oDateEdit1.Left+oDateEdit1.Width;
  oDateEdit2.Left := oLabel1.Left+oLabel1.Width;
end;

//***************** TFTimeEdit *******************
constructor TFTimeEdit.Create(AOwner: TComponent);
begin
  inherited Create (AOwner);
  Font.Name := 'Arial';
  oTimeEdit1 := TTimeEdit.Create (Self);
  oTimeEdit1.ParentFont := TRUE;
  oTimeEdit1.Left := 0;
  oTimeEdit1.Top := 0;
  oLabel1 := TLabel.Create (Self);
  oLabel1.Parent := Self;
  oLabel1.Caption := '  -  ';
  oLabel1.Left := oTimeEdit1.Left+oTimeEdit1.Width;
  oLabel1.Top := (oTimeEdit1.Height-oLabel1.Height) div 2;
  oTimeEdit2 := TTimeEdit.Create (Self);
  oTimeEdit2.ParentFont := TRUE;
  oTimeEdit2.Left := oLabel1.Left+oLabel1.Width;
  oTimeEdit2.Top := 0;
  Width := oTimeEdit2.Left+oTimeEdit2.Width;
  Height := oTimeEdit2.Height;
end;

destructor  TFTimeEdit.Destroy;
begin
  oTimeEdit1.Free;
  oTimeEdit2.Free;
  oLabel1.Free;
  inherited Destroy;
end;

procedure TFTimeEdit.SetFocus;
begin
  oTimeEdit1.SetFocus;
end;

procedure TFTimeEdit.SetFocus2;
begin
  oTimeEdit2.SetFocus;
end;

procedure TFTimeEdit.CreateWnd;
begin
  inherited CreateWnd;
  oTimeEdit1.Parent :=  Self;
  oTimeEdit2.Parent := Self;
  OnResize := MyOnResize;
  Font.OnChange := MyOnResize;
  MyOnResize (Self);
end;

function  TFTimeEdit.GetTime1:TTime;
begin
  If oTimeEdit1<>nil then GetTime1 := oTimeEdit1.Time;
end;

procedure  TFTimeEdit.SetTime1 (Value:TTime);
begin
  If oTimeEdit1<>nil then oTimeEdit1.Time := Value;
end;

function  TFTimeEdit.GetTime2:TTime;
begin
  If oTimeEdit2<>nil then GetTime2 := oTimeEdit2.Time;
end;

procedure TFTimeEdit.SetTime2 (Value:TTime);
begin
  If oTimeEdit2<>nil then oTimeEdit2.Time := Value;
end;

function  TFTimeEdit.GetHint1:string;
begin
  If oTimeEdit1<>nil then GetHint1 := oTimeEdit1.Hint;
end;

procedure TFTimeEdit.SetHint1 (Value:string);
begin
  If oTimeEdit1<>nil then oTimeEdit1.Hint := Value;
end;

function  TFTimeEdit.GetHint2:string;
begin
  If oTimeEdit2<>nil then GetHint2 := oTimeEdit2.Hint;
end;

procedure TFTimeEdit.SetHint2 (Value:string);
begin
  If oTimeEdit2<>nil then oTimeEdit2.Hint := Value;
end;

function  TFTimeEdit.GetStatusLine:TStatusLine;
begin
  If oTimeEdit1<>nil then GetStatusLine := oTimeEdit1.StatusLine;
end;

procedure TFTimeEdit.SetStatusLine (Value:TStatusLine);
begin
  If oTimeEdit1<>nil then begin
    oTimeEdit1.StatusLine := Value;
    oTimeEdit2.StatusLine := Value;
  end;
end;

function  TFTimeEdit.GetChecked1:boolean;
begin
  GetChecked1 := oTimeEdit1.Checked;
end;

procedure TFTimeEdit.SetChecked1 (Value:boolean);
begin
  oTimeEdit1.Checked := Value;
end;

function  TFTimeEdit.GetChecked2:boolean;
begin
  GetChecked2 := oTimeEdit2.Checked;
end;

procedure TFTimeEdit.SetChecked2 (Value:boolean);
begin
  oTimeEdit2.Checked := Value;
end;

function  TFTimeEdit.GetShowCheckbox1:boolean;
begin
  GetShowCheckbox1 := oTimeEdit1.ShowCheckbox;
end;

procedure TFTimeEdit.SetShowCheckbox1 (Value:boolean);
begin
  oTimeEdit1.ShowCheckbox := Value;
end;

function  TFTimeEdit.GetShowCheckbox2:boolean;
begin
  GetShowCheckbox2 := oTimeEdit2.ShowCheckbox;
end;

procedure TFTimeEdit.SetShowCheckbox2 (Value:boolean);
begin
  oTimeEdit2.ShowCheckbox := Value;
end;

procedure TFTimeEdit.MyOnResize (Sender:TObject);
begin
  oTimeEdit1.Font := Font;
  oTimeEdit2.Font := Font;
  oLabel1.Font := Font;

  oTimeEdit1.Height := Height;
  oTimeEdit2.Height := Height;
  oTimeEdit1.Width := (Width-oLabel1.Width) div 2;
  oTimeEdit2.Width := oTimeEdit1.Width;

  oTimeEdit1.Top := 0;
  oLabel1.Top := (oTimeEdit1.Height-oLabel1.Height) div 2;
  oTimeEdit2.Top := 0;

  oTimeEdit1.Left := 0;
  oLabel1.Left := oTimeEdit1.Left+oTimeEdit1.Width;
  oTimeEdit2.Left := oLabel1.Left+oLabel1.Width;
end;

//***************** TComboEdit *******************
procedure TComboEdit.CreateParams(var Params: TCreateParams);
const Alignments: array[Boolean, TAlignment] of DWORD = ((ES_LEFT, ES_RIGHT, ES_CENTER),(ES_RIGHT, ES_LEFT, ES_CENTER));
begin
  inherited CreateParams(Params);
  with Params do
  begin
    Style := Style or Alignments[FALSE, FAlignment];
  end;
end;

procedure TComboEdit.SetAlignment(Value: TAlignment);
begin
  if FAlignment <> Value then
  begin
    FAlignment := Value;
    RecreateWnd;
  end;
end;

function TComboEdit.GetControlsAlignment: TAlignment;
begin
  Result := FAlignment;
end;

constructor TComboEdit.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  inherited OnEnter := MyOnEnter;
  inherited OnExit := MyOnExit;
  AutoSize := FALSE;
  MaxLength := 30;
  Height := 20;
  Width := 250;
  If not FixedFont then begin
    Font.Name := gvSys.EditFontName;
    Font.Size := gvSys.EditFontSize;
  end;
end;

procedure TComboEdit.SetBefText (pText:TCaption);
begin
  Text := pText;
  oBefText := pText;
end;

function TComboEdit.GetBefText: TCaption;
begin
  Result := oBefText;
end;

procedure TComboEdit.SetChanged (pValue:boolean);
begin
  If pValue
    then oBefText := Text+' ' // Umelo vytvorime zmenu nastavime inu hodnotu na zaciatocny stav
    else oBefText := Text;  // Nastavime na rovnake hodnote - ziadna zmena
end;

function  TComboEdit.GetChanged: boolean;
begin
  Result := Text<>oBeftext;
end;

procedure TComboEdit.KeyDown(var Key: Word; Shift: TShiftState);
begin
  // ak je otvoreny DropList tak nemenime FOCUS na ine pole volanim SpecKeyDownHanlde
  If (SendMessage(Handle, CB_GETDROPPEDSTATE, 0, 0) <> 1) then SpecKeyDownHandle (Self,Key,Shift);
//  If not Key in [vk_UP,vk_DOWN] then inherited;
end;

procedure TComboEdit.MyOnEnter (Sender: TObject);
begin
  oColor := Color;
  Color := clAqua;
  oBefText := Text;
  If oStatusLine<>nil then begin
    oStatusLine.TabPosition := TabOrder;
    oStatusLine.CursorPosition := 0;
    oStatusLine.Description := Hint;
  end;
  SetFocus;
  If Assigned (eOnEnter) then eOnEnter (Sender);
end;

procedure TComboEdit.MyOnExit (Sender: TObject);
begin
  Color := oColor;
  If Assigned (eOnExit) then eOnExit (Sender);
end;

//***************** TLimitMemo *******************
constructor TLimitMemo.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  inherited OnEnter := MyOnEnter;
  inherited OnExit := MyOnExit;
end;

procedure TLimitMemo.KeyDown(var Key: Word; Shift: TShiftState);
var
  mLine,mCol:integer;
begin
  If Key= VK_Delete then begin
    mLine := Perform(EM_LineFromChar,SelStart,0);
    mCol  := SelStart - Perform(EM_LineIndex,mLine,0);
    If mcol=Length(Lines[mline]) then
      If (mLine<LineCount-1) and ((Length(Lines[mLine])+Length(Lines[mLine+1]))>LineLength) then begin
        Key:=0;
      end;
  end;
end;

procedure TLimitMemo.KeyPress(var Key: char);
var
  mLine,mCol:integer;
begin
   mLine := Perform(EM_LineFromChar,SelStart,0);
   mCol  := SelStart - Perform(EM_LineIndex,mLine,0);
   If key=#8 then begin
     If (mCol=0)  and (mLine>0) then
       If (Length (Lines[mLine])+Length (Lines[mLine-1]))>LineLength then Key:=#0
   end else begin
     If Key In [#13,#10] then begin
       If Lines.Count>=LineCount then begin
         Key:=#0;
         If mLine=LineCount-1
           then SelStart:=Perform(EM_LineIndex,mLine,0)
           else SelStart:=Perform(EM_LineIndex,mLine+1,0)
       end;
     end else If Key >= ' ' then begin
       If Length(Lines[mLine]) >= LineLength then Key:=#0;
     end;
   end;
  If Key=#0 then beep;
end;

procedure TLimitMemo.MyOnEnter (Sender: TObject);
begin
  oColor := Color;
  Color := clAqua;
  If oStatusLine<>nil then begin
    oStatusLine.TabPosition := TabOrder;
    oStatusLine.CursorPosition := 0;
    oStatusLine.Description := Hint;
  end;
  SetFocus;
  If Assigned (eOnEnter) then eOnEnter (Sender);
end;

procedure TLimitMemo.MyOnExit (Sender: TObject);
begin
  Color := oColor;
  If Assigned (eOnExit) then eOnExit (Sender);
end;


//***************** TIntervalSlctEdit *******************
constructor TIntervalSlctEdit.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  MaxLength := 0;
  Name := 'E_IntervalSlct';
  oSearch := FALSE;
end;

destructor TIntervalSlctEdit.Destroy;
begin
  inherited Destroy;
end;

procedure TIntervalSlctEdit.EditStringCut;
var mCut:TTxtCut;  mStr:string;  mPos,I:byte;
begin
  mCut := TTxtCut.Create;
  mCut.SetDelimiter ('');
  mCut.SetStr(Text);
  oIntvQnt := mCut.GetFldNum;
  For I:=1 to oIntvQnt do begin
    mStr := mCut.GetText(I);
    mPos := Pos('..',mStr);
    If mPos>0 then begin
      oIntervals[I].ValFr := StrToInt (copy(mStr,1,mPos-1));
      oIntervals[I].ValTo := StrToInt (copy(mStr,mPos+2,Length(mStr)-mPos+1));
    end
    else begin
      mPos := Pos('-',mStr);
      If mPos>0 then begin
        oIntervals[I].ValFr := StrToInt (copy(mStr,1,mPos-1));
        oIntervals[I].ValTo := StrToInt (copy(mStr,mPos+1,Length(mStr)-mPos));
      end
      else begin
        oIntervals[I].ValFr := mCut.GetNum(I);
        oIntervals[I].ValTo := oIntervals[I].ValFr;
      end;
    end;
  end;
  mCut.Free;
end;

procedure TIntervalSlctEdit.CheckInterval;
var mText:String;
begin
  // ictools
  mText:=Text;
  If (mText='')then begin
    mtext:=oSlctText;
  end else If ((mtext[length(mText)] in ['0'..'9']) and ((GetLastNonNumericChar(mText)='') or (GetLastNonNumericChar(mText)=','))) then begin
    mtext:=mText+'..'+oSlctText;
  end else If (mtext[length(mText)] in ['0'..'9']) and ((GetLastNonNumericChar(mText)='.') or (GetLastNonNumericChar(mText)='-')) then begin
    mtext:=mText+','+oSlctText;
  end else If ((mtext[length(mText)] ='.')or(mtext[length(mText)] ='-')) then begin
    mtext:=mtext+'.'+oSlctText;
    If POs('...',mText)>0 then Delete(mText,POs('...',mText),1);
    If POs('-.',mText)>0 then Delete(mText,POs('-.',mText)+1,1);
  end else begin
    mtext:=mtext+oSlctText;
  end;
  (*
  If (mText<>'') and ((mText[Length(mtext)]='.')or(mText[Length(mtext)]='-'))
    then begin Text:=mText+'999999';GetIntvQnt;mText:=ReplaceStr(mText,'-','..');end
    else GetIntvQnt;
  If oIntvQnt = 0 then begin
    mText:=oslctText;
  end else If oIntvQnt = 1 then begin
    If mText[Length(mtext)]='.'
      then mText:= mText+oSlctText+','
      else begin mText:=mText+','+oSlctText;If POs(',,',mText)>0 then Delete(mText,POs(',,',mText),1);end;
  end else begin
    If mText[Length(mtext)]='.'
      then mText:= mText+oSlctText+','
      else begin mText:=mText+','+oSlctText;If POs(',,',mText)>0 then Delete(mText,POs(',,',mText),1);end;
  end;
  *)
  Text:=mText;
  SelStart:=Length(Text);
end;

function TIntervalSlctEdit.GetIntvQnt: word;
begin
  EditStringCut;
  GetIntvQnt := oIntvQnt;
end;

function TIntervalSlctEdit.GetItemQnt: word;
var mItemQnt,I:longint;
begin
  If (oIntvQnt=0) then EditStringCut;
  mItemQnt := 0;
  For I:=1 to oIntvQnt do
    mItemQnt := mItemQnt+GetIntvValTo(I)-GetIntvValFr(I)+1;
  Result := mItemQnt;
end;

function TIntervalSlctEdit.GetIntvValFr;
begin
  Result := 0;
  If (oIntvQnt=0) then EditStringCut;
  If (oIntvQnt>0) then Result := oIntervals[pIndex].ValFr;
end;

function TIntervalSlctEdit.GetIntvValTo;
begin
  Result := 0;
  If (oIntvQnt=0) then EditStringCut;
  If (oIntvQnt>0) then Result := oIntervals[pIndex].ValTo;
end;

function TIntervalSlctEdit.DateInInt (pValue:TDate):boolean;
begin
  Result := DateInInterval(pValue,Text);
end;

function TIntervalSlctEdit.StrInInt (pValue:string):boolean;
begin
  Result := StrInInterval(pValue,Text);
end;

function TIntervalSlctEdit.FloatInInt (pValue:double):boolean;
begin
  Result := FloatInInterval(pValue,Text);
end;

function TIntervalSlctEdit.LongInInt (pValue:longint):boolean;
begin
  Result := LongInInterval(pValue,Text);
end;

function TIntervalSlctEdit.GetFirstDate:TDate;
var mFirst,mLast:TDate;
begin
  GetDateIntFirstLast (Text,mFirst,mLast);
  Result := mFirst;
end;

function TIntervalSlctEdit.GetLastDate:TDate;
var mFirst,mLast:TDate;
begin
  GetDateIntFirstLast (Text,mFirst,mLast);
  Result := mLast;
end;

function TIntervalSlctEdit.GetFirstStr:string;
var mFirst,mLast:string;
begin
  GetStrIntFirstLast (Text,mFirst,mLast);
  Result := mFirst;
end;

function TIntervalSlctEdit.GetLastStr:string;
var mFirst,mLast:string;
begin
  GetStrIntFirstLast (Text,mFirst,mLast);
  Result := mLast;
end;

function TIntervalSlctEdit.GetFirstFloat:double;
var mFirst,mLast:double;
begin
  GetFloatIntFirstLast (Text,mFirst,mLast);
  Result := mFirst;
end;

function TIntervalSlctEdit.GetLastFloat:double;
var mFirst,mLast:double;
begin
  GetFloatIntFirstLast (Text,mFirst,mLast);
  Result := mLast;
end;

function TIntervalSlctEdit.GetFirstLong:longint;
var mFirst,mLast:longint;
begin
  GetLongIntFirstLast (Text,mFirst,mLast);
  Result := mFirst;
end;

function TIntervalSlctEdit.GetLastLong:longint;
var mFirst,mLast:longint;
begin
  GetLongIntFirstLast (Text,mFirst,mLast);
  Result := mLast;
end;

procedure TIntervalSlctEdit.KeyDown(var Key: Word; Shift: TShiftState);
begin
  If Key=VK_F7 then  ShowViewForm else inherited;
end;

procedure TIntervalSlctEdit.Dblclick;
begin
  ShowViewForm;
end;
(*
procedure TIntervalSlctEdit.KeyPress(var Key: char);
begin
  If ((Key='.') and ((Text<>'')and(Text[Length(Text)]='.')))
  or (Key='-') then begin ShowViewForm;Key:=#0;end else inherited;
end;
*)
procedure TIntervalSlctEdit.ShowViewForm;
var
  mViewForm: TViewForm;
  mMyOp: boolean;
begin
  oSlctText := '';
  mMyOp := not oDataSet.Active;
  If mMyOp then oDataSet.Open;
  mViewForm := TViewForm.Create (Self);
  mViewForm.DataSet := oDataSet;
  mViewForm.DgdName := oDgdName;
  oDataSet.SetKeyNum(oKeyNum);
  mViewForm.Execute;
  If mViewForm.RecordSelect then begin
    oSlctText := oDataSet.FieldByName (oFieldName).AsString;
  end;
  mViewForm.Free;
  If mMyOp then oDataSet.Close;
  If oSlctText<>'' then CheckInterval;
end;

//***************** TMGIntEdit *******************
constructor TMGIntEdit.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  MaxLength := 0;
  Name := 'E_MGInt';
  oSearch := FALSE;
  if not (csDesigning in ComponentState) then begin
    oDataSet:=dmStk.btMGLST;oDgdName:='MGLST';oKeyNum:=1;oFieldName:='MgCode';
  end;
end;

//***************** TWriIntEdit *******************
constructor TWriIntEdit.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  MaxLength := 0;
  Name := 'E_WriInt';
  oSearch := FALSE;
  if not (csDesigning in ComponentState) then begin
    oDataSet:=dmdls.btWRILST;oDgdName:='WRILST';oKeyNum:=1;oFieldName:='WriNum';
  end;
end;

//***************** TStkIntEdit *******************
constructor TStkIntEdit.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  MaxLength := 0;
  Name := 'E_StkInt';
  oSearch := FALSE;
  if not (csDesigning in ComponentState) then begin
    oDataSet:=dmSTK.btSTKLST;oDgdName:='STKLST';oKeyNum:=1;oFieldName:='StkNum';
  end;
end;

//***************** TCasIntEdit *******************
constructor TCasIntEdit.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  MaxLength := 0;
  Name := 'E_CasInt';
  oSearch := FALSE;
  if not (csDesigning in ComponentState) then begin
    oDataSet:=dmcab.btCASSAS;oDgdName:='CASSAS';oKeyNum:=1;oFieldName:='CasNum';
  end;
end;

//***************** TComboSlctEdit *******************
procedure TComboSlctEdit.Change;
var
  Srch: string;
  ix: Integer;
  SS: Integer;
begin
  Ss := SelStart;
  inherited Change;
  Srch := Text;
  if LastKey = $08 then
  begin
    LastKey := 0;
    Exit;
  end;
  LastKey := 0;
  // vyhladanie zadaneho textu v poli retazcov ComboBox-u
  ix := Perform(CB_FINDSTRING, - 1, Longint(PChar(Srch)));
  if ix > CB_ERR then
  begin
    ItemIndex := ix;
    SelStart  := ss;//Length(Srch);
    SelLength := length(Text)-ss;//(Length(Text) - Length(Srch));
    LastFStr  := Text;
  end else begin
(*    Text:=LastFStr;//Srch;
//    SelStart  := Length(Text);
//    SelLength := 0;
*)
    Text:=Srch;
    SelStart  := Length(Text);
    SelLength := 0;
    If assigned (onchange) then Onchange(self);
  end;
end;

procedure TComboSlctEdit.KeyDown(var Key: Word; Shift: TShiftState);
begin
  // ulozime si naposledy stlacenu klavesu a aj posledny najdeny text
  LastKey :=Key;
  LastFStr:=Copy(Text,1,SelStart);
  // na F7 otvorime DropList - ak este nieje otvoreny
  If (Key=VK_F7) and (SendMessage(Handle, CB_GETDROPPEDSTATE, 0, 0) <> 1)
    then SendMessage(Handle, CB_SHOWDROPDOWN, 1, 0)
    else Key := 0;
end;

procedure TComboSlctEdit.SetText;
var
  Srch: string;
  ix: Integer;
begin
  // vyhladanie retazca zadaneho do property TEXT
  Srch := Value;
  inherited Text:=Value;
  ix := Perform(CB_FINDSTRING, - 1, Longint(PChar(Srch)));
  if ix > CB_ERR then
  begin
    ItemIndex := ix;
    SelStart  := Length(Srch);
    SelLength := length(Text)-Length(Srch);
    LastFStr  := Text;
  end else begin
//    inherited Text:=LastFStr;
    inherited Text:=Srch;
    SelStart  := Length(Text);
    SelLength := 0;
  end;
end;

function  TComboSlctEdit.GetText;
begin
  Result := inherited Text;
end;

procedure TComboSlctEdit.MyOnExit;
begin
  // kontrola eixstencie textu v poli retazcov ComboBox-u nastavenim property TEXT
  Text:=Text;
  inherited;
end;

//***************** TTimeEdit *******************
constructor TTimeEdit2.Create (AOwner:TComponent);
begin
  inherited Create (AOwner);
  inherited OnEnter := MyOnEnter;
  inherited OnExit := MyOnExit;
  Font.Name := gvSys.EditFontName;
  Font.Size := gvSys.EditFontSize;
  AutoSize := FALSE;
  Height := 20;
  Width := 70;
end;

procedure TTimeEdit2.CreateWnd;
begin
  inherited CreateWnd;
  If not FixedFont then begin
    Font.Name := gvSys.EditFontName;
    Font.Size := gvSys.EditFontSize;
  end;
end;

function  TTimeEdit2.GetTime:TTime;
begin
  try
    If Text=''
      then Result := 0
      else Result := StrToTime (Text);
  except GetTime := 0 end;
end;

procedure TTimeEdit2.SetTime (Value:TTime);
begin
  If Value=0
    then Text := ''
    else Text := TimeToStr (Value);
end;

function  TTimeEdit2.GetBefTime:TTime;
begin
  Result := oBefTime;
end;

procedure TTimeEdit2.SetBefTime (Value:TTime);
begin
  oBefTime := Value;
  SetTime (Value);
end;

function TTimeEdit2.GetChanged:boolean;
begin
  Result := GetTime<>oBefTime;
end;

procedure TTimeEdit2.MyOnEnter (Sender: TObject);
begin
  Color := clAqua;
  If oStatusLine<>nil then begin
    oStatusLine.TabPosition := TabOrder;
    oStatusLine.CursorPosition := 0;
    oStatusLine.Description := Hint;
  end;
  If Assigned (eOnEnter) then eOnEnter (Sender);
end;

procedure TTimeEdit2.MyOnExit (Sender: TObject);
begin
  Color := clWhite;
  Text := VerifyTime (Text);
  If Assigned (eOnExit) then eOnExit (Sender);
end;

procedure TTimeEdit2.KeyDown(var Key: Word; Shift: TShiftState);
begin
  SpecKeyDownHandle (Self,Key,Shift);
  inherited;
end;


//**************** Register **********************
procedure Register;
begin
  RegisterComponents('IcEditors', [TNameEdit]);
  RegisterComponents('IcEditors', [TLongEdit]);
  RegisterComponents('IcEditors', [TDoubEdit]);
  RegisterComponents('IcEditors', [TBarCodeEdit]);
  RegisterComponents('IcEditors', [TCodeEdit]);
  RegisterComponents('IcEditors', [TDblCodeEdit]);
  RegisterComponents('IcEditors', [TIntervalEdit]);
  RegisterComponents('IcEditors', [TDateEdit]);
  RegisterComponents('IcEditors', [TTimeEdit]);
  RegisterComponents('IcEditors', [TVatEdit]);
  RegisterComponents('IcEditors', [TPriceEdit]);
  RegisterComponents('IcEditors', [TValueEdit]);
  RegisterComponents('IcEditors', [TQuantEdit]);
  RegisterComponents('IcEditors', [TPrcEdit]);
  RegisterComponents('IcEditors', [TCodeNameEdit]);
  RegisterComponents('IcEditors', [TComboEdit]);
  RegisterComponents('IcEditors', [TFLongEdit]);
  RegisterComponents('IcEditors', [TFPriceEdit]);
  RegisterComponents('IcEditors', [TFValueEdit]);
  RegisterComponents('IcEditors', [TFQuantEdit]);
  RegisterComponents('IcEditors', [TFPrcEdit]);
  RegisterComponents('IcEditors', [TFDateEdit]);
  RegisterComponents('IcEditors', [TFTimeEdit]);
  RegisterComponents('IcEditors', [TLimitMEMO]);
  RegisterComponents('IcEditors', [TIntervalSlctEdit]);
  RegisterComponents('IcEditors', [TMGIntEdit]);
  RegisterComponents('IcEditors', [TWriIntEdit]);
  RegisterComponents('IcEditors', [TStkIntEdit]);
  RegisterComponents('IcEditors', [TCasIntEdit]);
  RegisterComponents('IcEditors', [TComboSlctEdit]);
  RegisterComponents('IcEditors', [TTimeEdit2]);
end;

end.
{MOD 1805026}
