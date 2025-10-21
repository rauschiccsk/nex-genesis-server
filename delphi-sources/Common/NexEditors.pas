unit NexEditors;

interface

uses
  IcVariab, IcLabels, IcEditors, IcTypes, IcConv, IcStand,
  LangForm, NexMsg, IcButtons,
  CmpTools, Windows, Messages, SysUtils, Classes, Graphics, Controls,
  Forms, Dialogs, StdCtrls, ExtCtrls, ComCtrls, Buttons;

type

// ************** Editor analytickeho uctu *************
  TAccAnlEdit = class(TWinControl)
    Bevel: TBevel;
    E_AccSnt: TNameEdit;
    E_AccAnl: TNameEdit;
    L_AnlName: TSpecLabel;
    B_Slct: TSpecButton;
  private
    oShowAnlName: boolean;
    oStatusLine: TStatusLine;
    eOnEnter: TNotifyEvent;
    eOnExit: TNotifyEvent;
    eOnKeyDown: TKeyEvent;
    eOnChanged: TNotifyEvent;
    procedure SetAccSnt(pValue: Str3);
    function  GetAccSnt: Str3;
    procedure SetAccAnl(pValue: Str6);
    function  GetAccAnl: Str6;
    procedure SetAnlName(pValue: Str30);
    function  GetAnlName: Str30;
    procedure SetShowAnlName(pValue: boolean);

    procedure MyKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure MyOnEnter (Sender: TObject);
    procedure MyOnExit (Sender: TObject);
    procedure SearchData;
    procedure ShowViewForm (Sender: TObject);
  public
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
    procedure Loaded; override;
  published
    property AccSnt:Str3 read GetAccSnt write SetAccSnt;
    property AccAnl:Str6 read GetAccAnl write SetAccAnl;
    property AnlName:Str30 read GetAnlName write SetAnlName;
    property StatusLine:TStatusLine read oStatusLine write oStatusLine;
    property ShowAnlName:boolean read oShowAnlName write SetShowAnlName;
    property TabOrder;
    property Anchors;
    {Events}
    property OnEnter: TNotifyEvent read eOnEnter write eOnEnter;
    property OnExit: TNotifyEvent read eOnExit write eOnExit;
    property OnKeyDown: TKeyEvent read eOnKeyDown write eOnKeyDown;
    property OnChanged: TNotifyEvent read eOnChanged write eOnChanged;
  end;

// ************* Editor meny a kurzoveho listku *************
  TCourseType = (ctBuy,ctSal,ctMid);
  TDvzNameEdit = class(TWinControl)
    Bevel: TBevel;
    E_DvzName: TNameEdit;
    E_Course: TDoubEdit;
    L_DvzDesc: TSpecLabel;
    B_Slct: TSpecButton;
  private
    oShowStaName: boolean;
    oStatusLine: TStatusLine;
    eOnEnter: TNotifyEvent;
    eOnExit: TNotifyEvent;
    eOnKeyDown: TKeyEvent;
    eOnChanged: TNotifyEvent;
    procedure SetDvzName(pValue: Str3);
    function  GetDvzName: Str3;
    procedure SetDvzDesc(pValue: Str30);
    function  GetDvzDesc: Str30;
    procedure SetCourse(pValue: double);
    function  GetCourse: double;
    procedure SetShowStaName(pValue: boolean);

    procedure MyKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure MyOnEnter (Sender: TObject);
    procedure MyOnExit (Sender: TObject);
    procedure OnDvzNameExit (Sender: TObject);
    procedure ShowViewForm (Sender: TObject);
  public
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
    procedure Loaded; override;
    procedure SetFocus;
    procedure SearchData;
  published
    property DvzName:Str3 read GetDvzName write SetDvzName;
    property DvzDesc:Str30 read GetDvzDesc write SetDvzDesc;
    property Course:double read GetCourse write SetCourse;
    property StatusLine:TStatusLine read oStatusLine write oStatusLine;
    property ShowStaName:boolean read oShowStaName write SetShowStaName;
    property TabOrder;
    property Anchors;
    property Visible;
    {Events}
    property OnEnter: TNotifyEvent read eOnEnter write eOnEnter;
    property OnExit: TNotifyEvent read eOnExit write eOnExit;
    property OnKeyDown: TKeyEvent read eOnKeyDown write eOnKeyDown;
    property OnChanged: TNotifyEvent read eOnChanged write eOnChanged;
  end;

// ************** Editor analytickeho uctu *************
  TMyContoSlct = class(TWinControl)
    Bevel1: TBevel;
    Bevel2: TBevel;
    L_IBAN: TSpecLabel;
    L_SWIFT: TSpecLabel;
    B_Slct: TSpecButton;
  private
    oShowBankName: boolean;
    oContoNum: Str30;
    oBankName: Str30;
    oBankCode: Str4;
    procedure SetIBAN(pValue: Str34);
    function  GetIBAN: Str34;
    procedure SetContoNum(pValue: Str30);
    function  GetContoNum: Str30;
    procedure SetSwift(pValue: Str30);
    function  GetSwift: Str30;
    function  GetBankName: Str30;
    function  GetBankCode: Str4;
    procedure SetShowBankName(pValue: boolean);
    procedure LoadMyConto;
    procedure ShowViewForm (Sender: TObject);
  public
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
    procedure Loaded; override;
    procedure ClearMyConto;
  published
    property IBAN:Str34 read GetIBAN write SetIBAN;
    property ContoNum:Str30 read GetContoNum write SetContoNum;
    property Swift:Str30 read GetSwift write SetSwift;
    property BankName:Str30 read GetBankName;
    property BankCode:Str4 read GetBankCode;
    property ShowBankName:boolean read oShowBankName write SetShowBankName;
    property Anchors;
  end;

// ************** Editor zoznamov *************
  TLstEditType = (ltPls,ltStk,ltWri,ltPAB,ltPAC,ltDlr);

  TLstEdit = class(TWinControl)
    Bevel: TBevel;
    E_Long: TLongEdit;
    L_Text: TSpecLabel;
    B_Slct: TSpecButton;
  private
    oStatusLine: TStatusLine;
    eOnEnter: TNotifyEvent;
    eOnExit: TNotifyEvent;
    eOnKeyDown: TKeyEvent;
    eOnChanged: TNotifyEvent;
    procedure SetLong(pValue: longint);
    function  GetLong: longint;
    procedure SetText(pValue: Str30);
    function  GetText: Str30;
    procedure SetShowText(pValue: boolean);
    function  GetShowText: boolean;
    procedure SetWidthLong(pValue: word);
    function  GetWidthLong: word;
    procedure SetWidthText(pValue: word);
    function  GetWidthText: word;

    procedure MyKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure MyOnEnter (Sender: TObject);
    procedure MyOnExit (Sender: TObject);
    procedure SetSize; // Nastavi rozmer editora pdola jeho komponentov
    procedure SearchData (Sender: TObject); virtual;
    procedure ShowLst (Sender: TObject); virtual;
  public
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
    procedure Loaded; override;
    procedure SetFocus; override;
  published
    property Long:longint read GetLong write SetLong;
    property Text:Str30 read GetText write SetText;
    property StatusLine:TStatusLine read oStatusLine write oStatusLine;
    property ShowText:boolean read GetShowText write SetShowText;
    property WidthLong:word read GetWidthLong write SetWidthLong;
    property WidthText:word read GetWidthText write SetWidthText;

    property TabOrder;
    property Anchors;
    {Events}
    property OnEnter: TNotifyEvent read eOnEnter write eOnEnter;
    property OnExit: TNotifyEvent read eOnExit write eOnExit;
    property OnKeyDown: TKeyEvent read eOnKeyDown write eOnKeyDown;
    property OnChanged: TNotifyEvent read eOnChanged write eOnChanged;
  end;

  TLstEditTp = class(TLstEdit)
  private
    oBookNum:word;
    oBefNum:word;
    oRegName:Str60;
    oRegIno:Str15;
    oRegTin:Str15;
    oRegVin:Str15;
    oRegAddr:Str30;
    oRegSta:Str2;
    oRegCty:Str3;
    oRegCtn:Str30;
    oRegZip:Str15;
    oRegTel:Str20;
    oRegFax:Str20;
    oRegEml:Str30;
    oPayCode:Str3;
    oPayName:Str20;
    oTrsCode:Str3;
    oTrsName:Str20;
    eOnEnter: TNotifyEvent;
    FLstType: TLstEditType;
    procedure LoadPACData;
    procedure SearchData (Sender: TObject); override;
    procedure ShowLst (Sender: TObject); override;
    procedure MyOnEnter (Sender: TObject);
    procedure SetLstType (pType: TLstEditType);
  public
    constructor Create(AOwner: TComponent); override;
  published
    property BookNum:word read oBookNum write oBookNum;
    property OnEnter: TNotifyEvent read eOnEnter write eOnEnter;
    property LstType: TLstEditType read FLstType write SetLstType;
    property RegName:Str60 read oRegName;
    property RegIno:Str15 read oRegIno;
    property RegTin:Str15 read oRegTin;
    property RegVin:Str15 read oRegVin;
    property RegAddr:Str30 read oRegAddr;
    property RegSta:Str2 read oRegSta;
    property RegCty:Str3 read oRegCty;
    property RegCtn:Str30 read oRegCtn;
    property RegZip:Str15 read oRegZip;
    property RegTel:Str20 read oRegTel;
    property RegFax:Str20 read oRegFax;
    property RegEml:Str30 read oRegEml;
    property PayCode:Str3 read oPayCode;
    property PayName:Str20 read oPayName;
    property TrsCode:Str3 read oTrsCode;
    property TrsName:Str20 read oTrsName;
  end;

// ************** Editor knih *************
  TBookEdit = class(TWinControl)
    Bevel: TBevel;
    E_BookNum: TNameEdit;
    L_BookName: TSpecLabel;
    B_Slct: TSpecButton;
  private
    oStatusLine: TStatusLine;
    eOnEnter: TNotifyEvent;
    eOnExit: TNotifyEvent;
    eOnKeyDown: TKeyEvent;
    eOnChanged: TNotifyEvent;
    procedure SetBookNum(pValue: Str5);
    function  GetBookNum: Str5;
    procedure SetBookName(pValue: Str30);
    function  GetBookName: Str30;

    procedure MyKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure MyOnEnter (Sender: TObject);
    procedure MyOnExit (Sender: TObject);
    procedure SearchData (Sender: TObject); virtual;
    procedure ShowBook (Sender: TObject); virtual;
  public
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
    procedure Loaded; override;
    procedure SetFocus; override;
  published
    property BookNum:Str5 read GetBookNum write SetBookNum;
    property BookName:Str30 read GetBookName write SetBookName;
    property StatusLine:TStatusLine read oStatusLine write oStatusLine;

    property TabOrder;
    property Anchors;
    {Events}
    property OnEnter: TNotifyEvent read eOnEnter write eOnEnter;
    property OnExit: TNotifyEvent read eOnExit write eOnExit;
    property OnKeyDown: TKeyEvent read eOnKeyDown write eOnKeyDown;
    property OnChanged: TNotifyEvent read eOnChanged write eOnChanged;
  end;

// ************** Editor knih *************
  TBookEditType = (tCMB,tBAN);
  TBookEditTp = class(TBookEdit)
  private
    FBookType: TBookEditType;

    procedure SearchData (Sender: TObject); override;
    procedure ShowBook (Sender: TObject); override;
    procedure SetBookType (pType: TBookEditType);
  published
    property BookType: TBookEditType read FBookType write SetBookType;
  end;

// ************** Editor skladov *************
  TStkEdit = class(TLstEdit)
  private
    oBefStkNum:word;
    eOnEnter: TNotifyEvent;
    procedure SearchData (Sender: TObject); override;
    procedure ShowLst (Sender: TObject); override;
    procedure MyOnEnter (Sender: TObject);
  public
    constructor Create(AOwner: TComponent); override;
  published
    property OnEnter: TNotifyEvent read eOnEnter write eOnEnter;
  end;

  TWriEdit = class(TLstEdit)
  private
    procedure SearchData (Sender: TObject); override;
    procedure ShowLst (Sender: TObject); override;
  public
  published
    property OnEnter: TNotifyEvent read eOnEnter write eOnEnter;
  end;

// ************** Editor cennikov *************
  TPlsEdit = class(TLstEdit)
  private
    procedure SearchData (Sender: TObject); override;
    procedure ShowLst (Sender: TObject); override;
  public
    constructor Create(AOwner: TComponent); override;
  published
  end;

// ************** Editor knih partnerov *************
  TPabEdit = class(TLstEdit)
  private
    procedure SearchData (Sender: TObject); override;
    procedure ShowLst (Sender: TObject); override;
  public
  published
  end;

// ***************** Editor firiem ****************
  TPacEdit = class(TLstEdit)
  private
    oBookNum:word;
    oRegName:Str60;
    oRegIno:Str15;
    oRegTin:Str15;
    oRegVin:Str15;
    oRegAddr:Str30;
    oRegSta:Str2;
    oRegCty:Str3;
    oRegCtn:Str30;
    oRegZip:Str15;
    oRegTel:Str20;
    oRegFax:Str20;
    oRegEml:Str30;
    oPayCode:Str3;
    oPayName:Str20;
    oTrsCode:Str3;
    oTrsName:Str20;
    procedure LoadData;
    procedure SearchData (Sender: TObject); override;
    procedure ShowLst (Sender: TObject); override;
  public
  published
    property BookNum:word read oBookNum write oBookNum;
    property RegName:Str60 read oRegName;
    property RegIno:Str15 read oRegIno;
    property RegTin:Str15 read oRegTin;
    property RegVin:Str15 read oRegVin;
    property RegAddr:Str30 read oRegAddr;
    property RegSta:Str2 read oRegSta;
    property RegCty:Str3 read oRegCty;
    property RegCtn:Str30 read oRegCtn;
    property RegZip:Str15 read oRegZip;
    property RegTel:Str20 read oRegTel;
    property RegFax:Str20 read oRegFax;
    property RegEml:Str30 read oRegEml;
    property PayCode:Str3 read oPayCode;
    property PayName:Str20 read oPayName;
    property TrsCode:Str3 read oTrsCode;
    property TrsName:Str20 read oTrsName;
  end;

// *********** Editor miest a obci ***********
  TCtyEdit = class(TWinControl)
    Bevel: TBevel;
    E_CtyCode: TNameEdit;
    L_CtyName: TSpecLabel;
    B_Slct: TSpecButton;
  private
    oSearch: boolean;
    oZipCode: Str15;
    oStaCode: Str2;
    oStatusLine: TStatusLine;
    eOnEnter: TNotifyEvent;
    eOnExit: TNotifyEvent;
    eOnKeyDown: TKeyEvent;
    eOnChanged: TNotifyEvent;
    procedure SetCtyCode(pValue: Str3);
    function  GetCtyCode: Str3;
    procedure SetCtyName(pValue: Str30);
    function  GetCtyName: Str30;

    procedure MyKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure MyOnEnter (Sender: TObject);
    procedure MyOnExit (Sender: TObject);
    procedure SearchData (Sender: TObject); virtual;
    procedure ShowLst (Sender: TObject); virtual;
  public
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
    procedure Loaded; override;
    procedure SetFocus; override;
  published
    property Search:boolean write oSearch;
    property CtyCode:Str3 read GetCtyCode write SetCtyCode;
    property CtyName:Str30 read GetCtyName write SetCtyName;
    property ZipCode:Str15 read oZipCode write oZipCode;
    property StaCode:Str2 read oStaCode write oStaCode;
    property StatusLine:TStatusLine read oStatusLine write oStatusLine;

    property TabOrder;
    property Anchors;
    {Events}
    property OnEnter: TNotifyEvent read eOnEnter write eOnEnter;
    property OnExit: TNotifyEvent read eOnExit write eOnExit;
    property OnKeyDown: TKeyEvent read eOnKeyDown write eOnKeyDown;
    property OnChanged: TNotifyEvent read eOnChanged write eOnChanged;
  end;

// *********** Editor statu ***********
  TStaEdit = class(TWinControl)
    Bevel: TBevel;
    E_StaCode: TNameEdit;
    L_StaName: TSpecLabel;
    B_Slct: TSpecButton;
  private
    oSearch: boolean;
    oStatusLine: TStatusLine;
    eOnEnter: TNotifyEvent;
    eOnExit: TNotifyEvent;
    eOnKeyDown: TKeyEvent;
    eOnChanged: TNotifyEvent;
    procedure SetStaCode(pValue: Str2);
    function  GetStaCode: Str2;
    procedure SetStaName(pValue: Str30);
    function  GetStaName: Str30;

    procedure MyKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure MyOnEnter (Sender: TObject);
    procedure MyOnExit (Sender: TObject);
    procedure SearchData (Sender: TObject); virtual;
    procedure ShowLst (Sender: TObject); virtual;
  public
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
    procedure Loaded; override;
    procedure SetFocus; override;
  published
    property Search:boolean write oSearch;
    property StaCode:Str2 read GetStaCode write SetStaCode;
    property StaName:Str30 read GetStaName write SetStaName;
    property StatusLine:TStatusLine read oStatusLine write oStatusLine;

    property TabOrder;
    property Anchors;
    {Events}
    property OnEnter: TNotifyEvent read eOnEnter write eOnEnter;
    property OnExit: TNotifyEvent read eOnExit write eOnExit;
    property OnKeyDown: TKeyEvent read eOnKeyDown write eOnKeyDown;
    property OnChanged: TNotifyEvent read eOnChanged write eOnChanged;
  end;

// *********** Editor penaznych ustavov ***********
  TBanEdit = class(TBookEdit)
  private
    procedure SearchData (Sender: TObject); override;
    procedure ShowBook (Sender: TObject); override;
  public
  published
  end;

// ********** Editor obchodnych partnerov **********
  TDlrEdit = class(TLstEdit)
  private
    oBefDlrCode:word;
    eOnEnter: TNotifyEvent;
    procedure SearchData (Sender: TObject); override;
    procedure ShowLst (Sender: TObject); override;
    procedure MyOnEnter (Sender: TObject);
  public
    constructor Create(AOwner: TComponent); override;
  published
    property OnEnter: TNotifyEvent read eOnEnter write eOnEnter;
  end;

// ***** Editor prevadzkovych miest partnerov *****
  TWpaEdit = class(TWinControl)
    Bevel: TBevel;
    E_PaCode: TLongEdit;
    E_WpaCode: TLongEdit;
    L_WpaName: TSpecLabel;
    B_Slct: TSpecButton;
  private
    oSearch: boolean;
    oBookNum: word;
    oWpaAddr: Str30;
    oWpaSta: Str2;
    oWpaCty: Str3;
    oWpaCtn: Str30;
    oWpaZip: Str15;
    oWpaTel: Str20;
    oWpaFax: Str20;
    oWpaEml: Str30;
    oTrsCode: Str3;
    oTrsName: Str30;
    oChanged:boolean;

    oStatusLine: TStatusLine;
    eOnEnter: TNotifyEvent;
    eOnExit: TNotifyEvent;
    eOnKeyDown: TKeyEvent;
    eOnChanged: TNotifyEvent;
    procedure SetPaCode(pValue: longint);
    function  GetPaCode: longint;
    procedure SetWpaCode(pValue: word);
    function  GetWpaCode: word;
    procedure SetWpaName(pValue: Str30);
    function  GetWpaName: Str30;
    procedure SetShowText(pValue: boolean);
    function  GetShowText: boolean;
    procedure SetWidthLong(pValue: word);
    function  GetWidthLong: word;
    procedure SetWidthText(pValue: word);
    function  GetWidthText: word;
    function  GetChanged: boolean;

    procedure MyKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure MyOnEnter (Sender: TObject);
    procedure MyOnExit (Sender: TObject);
    procedure ShowLst (Sender: TObject); virtual;
  public
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
    procedure Loaded; override;
    procedure SetFocus; override;
    procedure SearchData (Sender: TObject); virtual;
  published
    property Search:boolean write oSearch;
    property BookNum:word read oBookNum write oBookNum;
    property PaCode:longint read GetPaCode write SetPaCode;
    property WpaCode:word read GetWpaCode write SetWpaCode;
    property WpaName:Str30 read GetWpaName write SetWpaName;
    property WpaAddr:Str30 read oWpaAddr;
    property WpaSta:Str2 read oWpaSta;
    property WpaCty:Str3 read oWpaCty;
    property WpaCtn:Str30 read oWpaCtn;
    property WpaZip:Str15 read oWpaZip;
    property WpaTel:Str20 read oWpaTel;
    property WpaFax:Str20 read oWpaFax;
    property WpaEml:Str30 read oWpaEml;
    property TrsCode:Str3 read oTrsCode;
    property TrsName:Str30 read oTrsName;

    property StatusLine:TStatusLine read oStatusLine write oStatusLine;
    property ShowText:boolean read GetShowText write SetShowText;
    property WidthLong:word read GetWidthLong write SetWidthLong;
    property WidthText:word read GetWidthText write SetWidthText;
    property Changed:boolean read GetChanged;

    property TabOrder;
    property Anchors;
    {Events}
    property OnEnter: TNotifyEvent read eOnEnter write eOnEnter;
    property OnExit: TNotifyEvent read eOnExit write eOnExit;
    property OnKeyDown: TKeyEvent read eOnKeyDown write eOnKeyDown;
    property OnChanged: TNotifyEvent read eOnChanged write eOnChanged;
  end;

procedure Register;

implementation

uses
  DM_LDGDAT, DM_STKDAT, DM_CABDAT, DM_DLSDAT, DM_SYSTEM,
  BtrTable, NexError, Sys_MyConto_V,
  Acc_AccAnl_V, Sys_CrsLst_V, Sys_PlsLst_V, Sys_StkLst_V,
  Sys_WriLst_V, Sys_PabLst_V, Pab_PacLst_V, Pab_WpaLst_V,
  Sys_DlrLst_V, Pab_CtyLst_V, Pab_StaLst_V, Pab_BankLst_V;

// ************** Editor analytickeho uctu *************
constructor TAccAnlEdit.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  inherited OnEnter := MyOnEnter;
  inherited OnExit := MyOnExit;
  Width := 100;
  Height := 20;

  oStatusLine := nil;
  oShowAnlName := FALSE;
  E_AccSnt := TNameEdit.Create (Self);
  E_AccSnt.Parent := Self;
  E_AccSnt.Width := 28;
  E_AccSnt.OnKeyDown := MyKeyDown;

  E_AccAnl := TNameEdit.Create (Self);
  E_AccAnl.Parent := Self;
  E_AccAnl.Left := 30;
  E_AccAnl.Width := 48;
  E_AccAnl.OnKeyDown := MyKeyDown;

  L_AnlName := TSpecLabel.Create (Self);
  L_AnlName.Parent := Self;
  L_AnlName.Top := 2;
  L_AnlName.Left := 88;
  L_AnlName.Caption := '';
  L_AnlName.Font.Color := clNavy;
  L_AnlName.Font.Style := [fsBold];
  L_AnlName.Font.Charset := gvSys.FontCharset;

  Bevel := TBevel.Create (Self);
  Bevel.Parent := Self;
  Bevel.Left := 84;
  Bevel.Width := 238;
  Bevel.Height := 20;
  Bevel.Style := bsLowered;
  Bevel.Shape := bsBox;

  B_Slct := TSpecButton.Create (Self);
  B_Slct.Parent := Self;
  B_Slct.Width := 20;
  B_Slct.Height := 20;
  B_Slct.Align := alRight;
  B_Slct.ButtonType := btSelect;
  B_Slct.NumGlyphs := 2;
  B_Slct.TabStop := FALSE;
  B_Slct.OnClick := ShowViewForm;
end;

destructor TAccAnlEdit.Destroy;
begin
  Bevel.Free;
  L_AnlName.Free;
  E_AccSnt.Free;
  E_AccAnl.Free;
  B_Slct.Free;
  inherited;
end;

procedure TAccAnlEdit.Loaded;
begin
  inherited;
  L_AnlName.Font.Charset := gvSys.FontCharset;
end;

procedure TAccAnlEdit.SetAccSnt(pValue: Str3);
begin
  E_AccSnt.Text := pValue;
end;

function TAccAnlEdit.GetAccSnt: Str3;
begin
  Result := E_AccSnt.Text;
end;

procedure TAccAnlEdit.SetAccAnl(pValue: Str6);
begin
  E_AccAnl.Text := pValue;
end;

function TAccAnlEdit.GetAccAnl: Str6;
begin
  Result := E_AccAnl.Text;
end;

procedure TAccAnlEdit.SetAnlName(pValue: Str30);
begin
  L_AnlName.Caption := pValue;
end;

function TAccAnlEdit.GetAnlName: Str30;
begin
  Result := L_AnlName.Caption
end;

procedure TAccAnlEdit.SetShowAnlName(pValue: boolean);
begin
  oShowAnlName := pValue;
  If oShowAnlName
    then Width := 345
    else Width := 100;
  RecreateWnd;
end;

procedure TAccAnlEdit.MyKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
begin
//  If (Key=VK_RETURN) or (Key=VK_DOWN) or (Key=VK_UP) or (Key=VK_END) then SearchData;
  If Key=VK_F7 then  ShowViewForm (Sender);
  If Assigned (eOnKeyDown) then eOnKeyDown (Sender,Key,Shift);
end;

procedure TAccAnlEdit.MyOnEnter (Sender: TObject);
begin
  If oStatusLine<>nil then begin
    oStatusLine.TabPosition := TabOrder;
    oStatusLine.CursorPosition := 0;
    oStatusLine.Description := Hint;
  end;
  If Assigned (eOnEnter) then eOnEnter (Sender);
end;

procedure TAccAnlEdit.MyOnExit (Sender: TObject);
begin
  SearchData;
  If Assigned (eOnExit) then eOnExit (Sender);
end;

procedure TAccAnlEdit.SearchData;
var mSpcAnl:boolean;  mMyOp:boolean;
begin
  L_AnlName.Caption:='';
  If (E_AccSnt.Text<>'') and (E_AccAnl.Text<>'') then begin
    mMyOp:=not dmLDG.btACCANL.Active;
    If mMyOp then dmLDG.btACCANL.Open;
    If dmLDG.btACCANL.IndexName<>'SnAn' then dmLDG.btACCANL.IndexName:='SnAn';
    If dmLDG.btACCANL.FindKey ([E_AccSnt.Text,E_AccAnl.Text])
      then L_AnlName.Caption:=dmLDG.btACCANL.FieldByname ('AnlName').AsString
      else begin
        mSpcAnl:=(Pos('v',E_AccAnl.Text)>0) or (Pos('V',E_AccAnl.Text)>0) or
                 (Pos('p',E_AccAnl.Text)>0) or (Pos('P',E_AccAnl.Text)>0);
        If not mSpcAnl then ShowMsg (100011,E_AccSnt.Text+' '+E_AccAnl.Text);
      end;
    If mMyOp then dmLDG.btACCANL.Close;
  end;
end;

procedure TAccAnlEdit.ShowViewForm (Sender: TObject);
begin
  F_AccAccAnlV:=TF_AccAccAnlV.Create (Self);
  F_AccAccAnlV.ShowModal (cView);
  If F_AccAccAnlV.Accept then begin
    E_AccSnt.Text:=F_AccAccAnlV.AccSnt;
    E_AccAnl.Text:=F_AccAccAnlV.AccAnl;
    L_AnlName.Caption:=F_AccAccAnlV.AnlName;
    If Assigned(eOnChanged) then eOnChanged (Sender);
  end;
  FreeAndNil (F_AccAccAnlV);
end;

// ************* Editor meny a kurzoveho listku *************
constructor TDvzNameEdit.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  inherited OnEnter := MyOnEnter;
  inherited OnExit := MyOnExit;
  Width := 114;
  Height := 20;

  oStatusLine := nil;
  oShowStaName := FALSE;
  E_DvzName := TNameEdit.Create (Self);
  E_DvzName.Parent := Self;
  E_DvzName.Width := 32;
  E_DvzName.OnKeyDown := MyKeyDown;
  E_DvzName.OnExit := OnDvzNameExit;

  E_Course := TDoubEdit.Create (Self);
  E_Course.Parent := Self;
  E_Course.Left := 34;
  E_Course.Width := 60;
  E_Course.Fract := 5;
  E_Course.OnKeyDown := MyKeyDown;

  Bevel := TBevel.Create (Self);
  Bevel.Parent := Self;
  Bevel.Left := 76;
  Bevel.Width := 238;
  Bevel.Height := 20;
  Bevel.Style := bsLowered;
  Bevel.Shape := bsBox;

  L_DvzDesc := TSpecLabel.Create (Self);
  L_DvzDesc.Parent := Self;
  L_DvzDesc.Top := 2;
  L_DvzDesc.Left := 100;
  L_DvzDesc.Caption := '';
  L_DvzDesc.Font.Color := clNavy;
  L_DvzDesc.Font.Style := [fsBold];
  L_DvzDesc.Font.Charset := gvSys.FontCharset;

  B_Slct := TSpecButton.Create (Self);
  B_Slct.Parent := Self;
  B_Slct.Width := 20;
  B_Slct.Height := 20;
  B_Slct.Align := alRight;
  B_Slct.ButtonType := btSelect;
  B_Slct.NumGlyphs := 2;
  B_Slct.TabStop := FALSE;
  B_Slct.OnClick := ShowViewForm;
end;

destructor TDvzNameEdit.Destroy;
begin
  Bevel.Free;
  L_DvzDesc.Free;
  E_DvzName.Free;
  E_Course.Free;
  B_Slct.Free;
  inherited;
end;

procedure TDvzNameEdit.Loaded;
begin
  inherited;
  L_DvzDesc.Font.Charset := gvSys.FontCharset;
end;

procedure TDvzNameEdit.SetFocus;
begin
  E_DvzName.SetFocus;
end;

procedure TDvzNameEdit.SetDvzName(pValue: Str3);
begin
  E_DvzName.Text := pValue;
end;

function TDvzNameEdit.GetDvzName: Str3;
begin
  Result := E_DvzName.Text;
end;

procedure TDvzNameEdit.SetDvzDesc(pValue: Str30);
begin
  L_DvzDesc.Caption := pValue;
end;

function TDvzNameEdit.GetDvzDesc: Str30;
begin
  Result := L_DvzDesc.Caption
end;

procedure TDvzNameEdit.SetCourse(pValue: double);
begin
  E_Course.Value := pValue;
end;

function TDvzNameEdit.GetCourse: double;
begin
  Result := E_Course.Value;
end;

procedure TDvzNameEdit.SetShowStaName(pValue: boolean);
begin
  oShowStaName := pValue;
  If oShowStaName
    then Width := 297
    else Width := 114;
  RecreateWnd;
end;

procedure TDvzNameEdit.MyKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
begin
//  If (Key=VK_RETURN) or (Key=VK_DOWN) or (Key=VK_UP) or (Key=VK_END) then SearchData;
  If Key=VK_F7 then  ShowViewForm (Sender);
  If Assigned (eOnKeyDown) then eOnKeyDown (Sender,Key,Shift);
end;

procedure TDvzNameEdit.MyOnEnter (Sender: TObject);
begin
  If oStatusLine<>nil then begin
    oStatusLine.TabPosition := TabOrder;
    oStatusLine.CursorPosition := 0;
    oStatusLine.Description := Hint;
  end;
  If Assigned (eOnEnter) then eOnEnter (Sender);
end;

procedure TDvzNameEdit.MyOnExit (Sender: TObject);
begin
  If Assigned (eOnExit) then eOnExit (Sender);
end;

procedure TDvzNameEdit.OnDvzNameExit (Sender: TObject);
begin
  SearchData;
end;

procedure TDvzNameEdit.SearchData;
var mMyOp:boolean;
begin
  L_DvzDesc.Caption := '';
  If (E_DvzName.Text<>'') then begin
    mMyOp := not dmLDG.btCRSLST.Active;
    If mMyOp then dmLDG.btCRSLST.Open;
    If dmLDG.btCRSLST.IndexName<>'DvzName' then dmLDG.btCRSLST.IndexName := 'DvzName';
    If dmLDG.btCRSLST.FindKey ([E_DvzName.Text])then begin
      L_DvzDesc.Caption := dmLDG.btCRSLST.FieldByname ('DvzDesc').AsString;
      E_Course.Value := dmLDG.btCRSLST.FieldByname ('Course').AsFloat;
    end
    else ShowMsg (100013,E_DvzName.Text);
    If mMyOp then dmLDG.btCRSLST.Close;
  end;
end;

procedure TDvzNameEdit.ShowViewForm (Sender: TObject);
begin
  E_Course.SetFocus;
  F_SysCrsLstV := TF_SysCrsLstV.Create (Self);
  F_SysCrsLstV.ShowModal (cView);
  If F_SysCrsLstV.Accept then begin
    E_DvzName.Text := F_SysCrsLstV.DvzName;
    L_DvzDesc.Caption := F_SysCrsLstV.DvzDesc;
    E_Course.Value := F_SysCrsLstV.Course;
  end;
  FreeAndNil (F_SysCrsLstV);
end;

// ************** Vyber vlastnych uctov *************
constructor TMyContoSlct.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  Width := 304;
  Height := 20;

  oShowBankName := TRUE;

  Bevel1 := TBevel.Create (Self);
  Bevel1.Parent := Self;
  Bevel1.Left := 0;
  Bevel1.Width := 200;
  Bevel1.Height := 20;
  Bevel1.Style := bsLowered;
  Bevel1.Shape := bsBox;

  Bevel2 := TBevel.Create (Self);
  Bevel2.Parent := Self;
  Bevel2.Left := 202;
  Bevel2.Width := 80;
  Bevel2.Height := 20;
  Bevel2.Style := bsLowered;
  Bevel2.Shape := bsBox;

  L_IBAN := TSpecLabel.Create (Self);
  L_IBAN.Parent := Self;
  L_IBAN.Top := 3;
  L_IBAN.Height := 14;
  L_IBAN.Left := 2;
  L_IBAN.Width := 196;
  L_IBAN.Caption := '';
  L_IBAN.AutoSize := FALSE;
  L_IBAN.Alignment := taCenter;
  L_IBAN.Font.Size := 9;
  L_IBAN.Font.Color := clNavy;
  L_IBAN.Font.Style := [fsBold];
  L_IBAN.Font.Charset := gvSys.FontCharset;

  L_SWIFT := TSpecLabel.Create (Self);
  L_SWIFT.Parent := Self;
  L_SWIFT.Top := 3;
  L_SWIFT.Height := 14;
  L_SWIFT.Left := 204;
  L_SWIFT.Width := 76;
  L_SWIFT.Caption := '';
  L_SWIFT.AutoSize := FALSE;
  L_SWIFT.Alignment := taCenter;
  L_SWIFT.Font.Size := 9;
  L_SWIFT.Font.Color := clNavy;
  L_SWIFT.Font.Style := [fsBold];
  L_SWIFT.Font.Charset := gvSys.FontCharset;


  B_Slct := TSpecButton.Create (Self);
  B_Slct.Parent := Self;
  B_Slct.Width := 20;
  B_Slct.Height := 20;
  B_Slct.Align := alRight;
  B_Slct.ButtonType := btSelect;
  B_Slct.NumGlyphs := 2;
  B_Slct.TabStop := FALSE;
  B_Slct.OnClick := ShowViewForm;
end;

destructor TMyContoSlct.Destroy;
begin
  Bevel1.Free;
  Bevel2.Free;
  L_SWIFT.Free;
  L_IBAN.Free;
  B_Slct.Free;
  inherited;
end;

procedure TMyContoSlct.Loaded;
begin
  inherited;
  L_IBAN.Font.Charset := gvSys.FontCharset;
  L_SWIFT.Font.Charset := gvSys.FontCharset;
end;

procedure TMyContoSlct.SetIBAN(pValue: Str34);
var mMyOp:boolean;mFind:boolean;
begin
  If pValue='' then Exit;
  L_IBAN.Caption := pValue;
  mMyOp := not dmSYS.btMYCONTO.Active;
  If mMyOp then dmSYS.btMYCONTO.Open;
  mFind:=False;
  dmSYS.btMYCONTO.First;
  while not mFind and not dmSYS.btMYCONTO.Eof do begin
    mFind := (dmSYS.btMYCONTO.FieldByname ('IbanCode').AsString=pValue)
    or (dmSYS.btMYCONTO.FieldByname ('ContoNum').AsString=pValue);
    If not mFind then dmSYS.btMYCONTO.Next;
  end;
  If mFind then LoadMyConto;
  If mMyOp then dmSYS.btMYCONTO.Close;
end;

function TMyContoSlct.GetIBAN: Str34;
begin
  Result := L_IBAN.Caption;
end;

procedure TMyContoSlct.SetContoNum(pValue: Str30);
var mMyOp:boolean;
begin
  If pValue='' then Exit;
  oContoNum := pValue;
  mMyOp := not dmSYS.btMYCONTO.Active;
  If mMyOp then dmSYS.btMYCONTO.Open;
  If dmSYS.btMYCONTO.FindKey ([oContoNum]) then LoadMyConto;
  If mMyOp then dmSYS.btMYCONTO.Close;
end;

function TMyContoSlct.GetContoNum: Str30;
begin
  Result := oContoNum;
end;

procedure TMyContoSlct.SetSWIFT(pValue: Str30);
begin
  If pValue='' then Exit;
  L_SWIFT.Caption := pValue;
end;

function TMyContoSlct.GetSWIFT: Str30;
begin
  Result := L_SWIFT.Caption;
end;

function TMyContoSlct.GetBankName: Str30;
begin
  Result := oBankName;
end;

function TMyContoSlct.GetBankCode: Str4;
begin
  Result := oBankName;
end;

procedure TMyContoSlct.SetShowBankName(pValue: boolean);
begin
  oShowBankName := pValue;
  If oShowBankName
    then Width := 304
    else Width := 180;
  RecreateWnd;
end;

procedure TMyContoSlct.LoadMyConto;
begin
  L_IBAN.Caption  := dmSYS.btMYCONTO.FieldByname ('IbanCode').AsString;
  L_SWIFT.Caption := dmSYS.btMYCONTO.FieldByname ('SwftCode').AsString;
  oContoNum := dmSYS.btMYCONTO.FieldByname ('ContoNum').AsString;
  oBankName := dmSYS.btMYCONTO.FieldByname ('BankName').AsString;
  oBankCode := dmSYS.btMYCONTO.FieldByname ('BankCode').AsString;
end;

procedure TMyContoSlct.ClearMyConto;
begin
  L_IBAN.Caption  := ''; L_SWIFT.Caption := '';
  oContoNum := ''; oBankName := ''; oBankCode := '';
end;

procedure TMyContoSlct.ShowViewForm (Sender: TObject);
begin
  F_SysMyContoV := TF_SysMyContoV.Create (Self);
  F_SysMyContoV.ShowModal (cView);
  If F_SysMyContoV.Accept then begin
    L_IBAN.Caption := F_SysMyContoV.IbanCode;
    L_SWIFT.Caption := F_SysMyContoV.SwftCode;
    oContoNum := F_SysMyContoV.ContoNum;
    oBankName := F_SysMyContoV.BankName;
    oBankCode := F_SysMyContoV.BankCode;
  end;
  FreeAndNil (F_SysMyContoV);
end;

// ************** Editor zoznamov *************
constructor TLstEdit.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  inherited OnEnter := MyOnEnter;
  inherited OnExit := MyOnExit;
  Width := 304;
  Height := 20;

  oStatusLine := nil;
  E_Long := TLongEdit.Create (Self);
  E_Long.Parent := Self;
  E_Long.Width := 50;
  E_Long.OnKeyDown := MyKeyDown;

  L_Text := TSpecLabel.Create (Self);
  L_Text.Parent := Self;
  L_Text.Top := 2;
  L_Text.Left := 58;
  L_Text.Caption := '';
  L_Text.Font.Color := clNavy;
  L_Text.Font.Style := [fsBold];
  L_Text.Font.Charset := gvSys.FontCharset;

  Bevel := TBevel.Create (Self);
  Bevel.Parent := Self;
  Bevel.Left := 54;
  Bevel.Width := 228;
  Bevel.Height := 20;
  Bevel.Style := bsLowered;
  Bevel.Shape := bsBox;

  B_Slct := TSpecButton.Create (Self);
  B_Slct.Parent := Self;
  B_Slct.Width := 20;
  B_Slct.Height := 20;
  B_Slct.Align := alRight;
  B_Slct.ButtonType := btSelect;
  B_Slct.NumGlyphs := 2;
  B_Slct.TabStop := FALSE;
  B_Slct.OnClick := ShowLst;
end;

destructor TLstEdit.Destroy;
begin
  Bevel.Free;
  L_Text.Free;
  E_Long.Free;
  B_Slct.Free;
  inherited;
end;

procedure TLstEdit.Loaded;
begin
  inherited;
  L_Text.Font.Charset := gvSys.FontCharset;
  SetSize; // Nastavi rozmer editora pdola jeho komponentov
end;

procedure TLstEdit.SetFocus;
begin
  E_Long.SetFocus;
end;

procedure TLstEdit.SetLong(pValue:longint);
begin
  E_Long.Long := pValue;
  SearchData (Self);
end;

function TLstEdit.GetLong:longint;
begin
  Result := E_Long.Long;
end;

procedure TLstEdit.SetText(pValue: Str30);
begin
  L_Text.Caption := pValue;
end;

function TLstEdit.GetText: Str30;
begin
  Result := L_Text.Caption
end;

procedure TLstEdit.SetShowText(pValue: boolean);
begin
  L_Text.Visible := pValue;
  SetSize; // Nastavi rozmer editora pdola jeho komponentov
end;

function TLstEdit.GetShowText: boolean;
begin
  Result := L_Text.Visible;
end;

procedure TLstEdit.SetWidthLong(pValue: word);
begin
  E_Long.Width := pValue;
  SetSize; // Nastavi rozmer editora pdola jeho komponentov
end;

function TLstEdit.GetWidthLong: word;
begin
  Result := E_Long.Width;
end;

procedure TLstEdit.SetWidthText(pValue: word);
begin
  L_Text.Width := pValue;
  SetSize; // Nastavi rozmer editora pdola jeho komponentov
end;

function TLstEdit.GetWidthText: word;
begin
  Result := L_Text.Width;
end;

procedure TLstEdit.MyKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
begin
//  SpecKeyDownHandle (Self,Key,Shift);
  If Key=VK_F7 then  ShowLst (Sender);
  If Assigned (eOnKeyDown) then eOnKeyDown (Sender,Key,Shift);
end;

procedure TLstEdit.MyOnEnter (Sender: TObject);
begin
  If oStatusLine<>nil then begin
    oStatusLine.TabPosition := TabOrder;
    oStatusLine.CursorPosition := 0;
    oStatusLine.Description := Hint;
  end;
  If Assigned (eOnEnter) then eOnEnter (Sender);
end;

procedure TLstEdit.MyOnExit (Sender: TObject);
begin
  SearchData (Sender);
  If Assigned (eOnExit) then eOnExit (Sender);
end;

procedure TLstEdit.SetSize; // Nastavi rozmer editora pdola jeho komponentov
begin
  If L_Text.Visible
    then Width := E_Long.Width+2+Bevel.Width+4+B_Slct.Width
    else Width := E_Long.Width+2+B_Slct.Width;
  Bevel.Left := E_Long.Width+4;
  L_Text.Left := E_Long.Width+8;
  RecreateWnd;
end;

procedure TLstEdit.SearchData (Sender: TObject);
begin
end;

procedure TLstEdit.ShowLst (Sender: TObject);
begin
end;

// ************** Editor zoznamov *************
constructor TBookEdit.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  inherited OnEnter := MyOnEnter;
  inherited OnExit := MyOnExit;
  Width := 304;
  Height := 20;

  oStatusLine := nil;
  E_BookNum := TNameEdit.Create (Self);
  E_BookNum.MaxLength := 5;
  E_BookNum.Parent := Self;
  E_BookNum.Width := 50;
  E_BookNum.OnKeyDown := MyKeyDown;

  L_BookName := TSpecLabel.Create (Self);
  L_BookName.Parent := Self;
  L_BookName.Top := 2;
  L_BookName.Left := 58;
  L_BookName.Caption := '';
  L_BookName.Font.Color := clNavy;
  L_BookName.Font.Style := [fsBold];
  L_BookName.Font.Charset := gvSys.FontCharset;

  Bevel := TBevel.Create (Self);
  Bevel.Parent := Self;
  Bevel.Left := 54;
  Bevel.Width := 228;
  Bevel.Height := 20;
  Bevel.Style := bsLowered;
  Bevel.Shape := bsBox;
  Bevel.Anchors := [akLeft,akRight];

  B_Slct := TSpecButton.Create (Self);
  B_Slct.Parent := Self;
  B_Slct.Width := 20;
  B_Slct.Height := 20;
  B_Slct.Align := alRight;
  B_Slct.ButtonType := btSelect;
  B_Slct.NumGlyphs := 2;
  B_Slct.TabStop := FALSE;
  B_Slct.OnClick := ShowBook;
end;

destructor TBookEdit.Destroy;
begin
  Bevel.Free;
  E_BookNum.Free;
  L_BookName.Free;
  B_Slct.Free;
  inherited;
end;

procedure TBookEdit.Loaded;
begin
  inherited;
  L_BookName.Font.Charset := gvSys.FontCharset;
end;

procedure TBookEdit.SetFocus;
begin
  E_BookNum.SetFocus;
end;

procedure TBookEdit.SetBookNum(pValue:Str5);
begin
  E_BookNum.Text := pValue;
  SearchData (Self);
end;

function TBookEdit.GetBookNum:Str5;
begin
  Result := E_BookNum.Text;
end;

procedure TBookEdit.SetBookName(pValue: Str30);
begin
  L_BookName.Caption := pValue;
end;

function TBookEdit.GetBookName: Str30;
begin
  Result := L_BookName.Caption
end;

procedure TBookEdit.MyKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
begin
//  SpecKeyDownHandle (Self,Key,Shift);
  If Key=VK_F7 then  ShowBook (Sender);
  If Assigned (eOnKeyDown) then eOnKeyDown (Sender,Key,Shift);
end;

procedure TBookEdit.MyOnEnter (Sender: TObject);
begin
  If oStatusLine<>nil then begin
    oStatusLine.TabPosition := TabOrder;
    oStatusLine.CursorPosition := 0;
    oStatusLine.Description := Hint;
  end;
  If Assigned (eOnEnter) then eOnEnter (Sender);
end;

procedure TBookEdit.MyOnExit (Sender: TObject);
begin
  SearchData (Sender);
  If Assigned (eOnExit) then eOnExit (Sender);
end;

procedure TBookEdit.SearchData (Sender: TObject);
begin
end;

procedure TBookEdit.ShowBook (Sender: TObject);
begin
end;

// *********************** Editor skladov ***********************

constructor TStkEdit.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  inherited OnEnter := MyOnEnter;
  If cNexStart then begin
    E_Long.Long := 1;
    Text := 'Sklad';
  end;
end;

procedure TStkEdit.SearchData (Sender: TObject);
var mMyOp:boolean;
begin
  Text := '';
  If (Long<>0) then begin
    If cNexStart then begin
      E_Long.Long := 1;
      Text := 'Sklad';
    end else begin
      mMyOp := not dmSTK.btSTKLST.Active;
      If mMyOp then dmSTK.btSTKLST.Open;
      If dmSTK.btSTKLST.IndexName<>'StkNum' then dmSTK.btSTKLST.IndexName := 'StkNum';
      If dmSTK.btSTKLST.FindKey ([Long]) then begin
        Text := dmSTK.btSTKLST.FieldByname ('StkName').AsString;
        If Assigned (eOnChanged) then eOnChanged (Sender);
      end
      else begin
        ShowMsg (100014,StrInt(Long,0));
        E_Long.Long := oBefStkNum; // Ak sklad neexistuje nastavime hodnotu ktora bola pred zmenou
      end;
      If mMyOp then dmSTK.btSTKLST.Close;
    end;
  end;
end;

procedure TStkEdit.ShowLst (Sender: TObject);
var mKey:word; mShift: TShiftState;
begin
  SetFocus;
  If cNexStart then begin
    Long:=1;
    Text:='Sklad';
    If Assigned (eOnChanged) then eOnChanged (Sender);
    mKey := vk_Return;
    SpecKeyDownHandle (Self,mKey,mShift);
  end else begin
    F_SysStkLstV := TF_SysStkLstV.Create (Self);
    F_SysStkLstV.ShowModal (cView);
    If F_SysStkLstV.Accept then begin
      Long := F_SysStkLstV.StkNum;
      Text := F_SysStkLstV.StkName;
      If Assigned (eOnChanged) then eOnChanged (Sender);
      mKey := vk_Return;
      SpecKeyDownHandle (Self,mKey,mShift);
    end;
    FreeAndNil (F_SysStkLstV);
  end;
end;

procedure TStkEdit.MyOnEnter (Sender: TObject);
begin
  oBefStkNum := Long;
  If Assigned (eOnEnter) then eOnEnter (Sender);
end;


procedure TWriEdit.SearchData (Sender: TObject);
var mMyOp:boolean;
begin
  Text := '';
  If (Long<>0) then begin
    mMyOp := not dmDLS.btWRILST.Active;
    If mMyOp then dmDLS.btWRILST.Open;
    If dmDLS.btWRILST.IndexName<>'WriNum' then dmDLS.btWRILST.IndexName := 'WriNum';
    If dmDLS.btWRILST.FindKey ([Long]) then begin
      Text := dmDLS.btWRILST.FieldByname ('WriName').AsString;
      If Assigned (eOnChanged) then eOnChanged (Sender);
    end
    else ShowMsg (100014,StrInt(Long,0));
    If mMyOp then dmDLS.btWRILST.Close;
  end;
end;

procedure TWriEdit.ShowLst (Sender: TObject);
var mKey:word; mShift: TShiftState;
begin
  SetFocus;
  F_SysWriLstV := TF_SysWriLstV.Create (Self);
  F_SysWriLstV.ShowModal (cView);
  If F_SysWriLstV.Accept then begin
    Long := F_SysWriLstV.WriNum;
    Text := F_SysWriLstV.WriName;
    If Assigned (eOnChanged) then eOnChanged (Sender);
    mKey := vk_Return;
    SpecKeyDownHandle (Self,mKey,mShift);
  end;
  FreeAndNil (F_SysWriLstV);
end;

// *********************** Editor cennikov ***********************
constructor TPlsEdit.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  If cNexStart then begin
    E_Long.Long := 1;
    Text := 'Cennik';
  end;
end;

procedure TPlsEdit.SearchData (Sender: TObject);
var mMyOp:boolean;
begin
  Text := '';
  If (Long<>0) then begin
    If cNexStart then begin
      E_Long.Long := 1;
      Text := 'Cennik';
    end else begin
      mMyOp := not dmSTK.btPLSLST.Active;
      If mMyOp then dmSTK.btPLSLST.Open;
      If dmSTK.btPLSLST.IndexName<>'PlsNum' then dmSTK.btPLSLST.IndexName := 'PlsNum';
      If dmSTK.btPLSLST.FindKey ([Long]) then begin
        Text := dmSTK.btPLSLST.FieldByname ('PlsName').AsString;
        If Assigned (eOnChanged) then eOnChanged (Sender);
      end
      else ShowMsg (100015,StrInt(Long,0));
      If mMyOp then dmSTK.btPLSLST.Close;
    end;
  end;
end;

procedure TPlsEdit.ShowLst (Sender: TObject);
var mKey:word; mShift: TShiftState;
begin
  SetFocus;
  If cNexStart then begin
    Long:=1;
    Text:='Cennik';
    If Assigned (eOnChanged) then eOnChanged (Sender);
    mKey := vk_Return;
    SpecKeyDownHandle (Self,mKey,mShift);
  end else begin
    F_SysPlsLstV := TF_SysPlsLstV.Create (Self);
    F_SysPlsLstV.ShowModal (cView);
    If F_SysPlsLstV.Accept then begin
      Long := F_SysPlsLstV.PlsNum;
      Text := F_SysPlsLstV.PlsName;
      If Assigned (eOnChanged) then eOnChanged (Sender);
      mKey := vk_Return;
      SpecKeyDownHandle (Self,mKey,mShift);
    end;
    FreeAndNil (F_SysPlsLstV);
  end;
end;

// ************** Editor knih partnerov *****************
procedure TPabEdit.SearchData (Sender: TObject);
var mMyOp:boolean;
begin
  Text := '';
  If (Long<>0) then begin
    mMyOp := not dmDLS.btPABLST.Active;
    If mMyOp then dmDLS.btPABLST.Open;
    If dmDLS.btPABLST.IndexName<>'BookNum' then dmDLS.btPABLST.IndexName := 'BookNum';
    If dmDLS.btPABLST.FindKey ([Long]) then begin
      Text := dmDLS.btPABLST.FieldByname ('BookName').AsString;
      If Assigned (eOnChanged) then eOnChanged (Sender);
    end
    else ShowMsg (100016,StrInt(Long,0));
    If mMyOp then dmDLS.btPABLST.Close;
  end;
end;

procedure TPabEdit.ShowLst (Sender: TObject);
var mKey:word; mShift: TShiftState;
begin
  SetFocus;
  F_SysPabLstV := TF_SysPabLstV.Create (Self);
  F_SysPabLstV.ShowModal (cView);
  If F_SysPabLstV.Accept then begin
    Long := F_SysPabLstV.BookNum;
    Text := F_SysPabLstV.BookName;
    If Assigned (eOnChanged) then eOnChanged (Sender);
    mKey := vk_Return;
    SpecKeyDownHandle (Self,mKey,mShift);
  end;
  FreeAndNil (F_SysPabLstV);
end;

// ************ Vyberovy editor firiem **************

procedure TPacEdit.LoadData;
begin
  oRegName := dmDLS.btPAB.FieldByname ('RegName').AsString;
  oRegIno := dmDLS.btPAB.FieldByname ('RegIno').AsString;
  oRegTin := dmDLS.btPAB.FieldByname ('RegTin').AsString;
  oRegVin := dmDLS.btPAB.FieldByname ('RegVin').AsString;
  oRegAddr := dmDLS.btPAB.FieldByname ('RegAddr').AsString;
  oRegSta := dmDLS.btPAB.FieldByname ('RegSta').AsString;
  oRegCty := dmDLS.btPAB.FieldByname ('RegCty').AsString;
  oRegCtn := dmDLS.btPAB.FieldByname ('RegCtn').AsString;
  oRegZip := dmDLS.btPAB.FieldByname ('RegZip').AsString;
  oRegTel := dmDLS.btPAB.FieldByname ('RegTel').AsString;
  oRegFax := dmDLS.btPAB.FieldByname ('RegFax').AsString;
  oRegEml := dmDLS.btPAB.FieldByname ('RegEml').AsString;
  oPayCode := dmDLS.btPAB.FieldByname ('IcPayCode').AsString;
  oPayName := dmDLS.btPAB.FieldByname ('IcPayName').AsString;
  oTrsCode := dmDLS.btPAB.FieldByname ('IcTrsCode').AsString;
  oTrsName := dmDLS.btPAB.FieldByname ('IcTrsName').AsString;
end;

procedure TPacEdit.SearchData (Sender: TObject);
var mMyOp:boolean;
begin
  Text := '';
  If (Long<>0) then begin
    mMyOp := not dmDLS.btPAB.Active;
    If mMyOp then dmDLS.OpenList(dmDLS.btPAB,BookNum);
    If dmDLS.btPAB.IndexName<>'PaCode' then dmDLS.btPAB.IndexName := 'PaCode';
    If dmDLS.btPAB.FindKey ([Long]) then begin
      Text := dmDLS.btPAB.FieldByname ('PaName').AsString;
      LoadData;
      If Assigned (eOnChanged) then eOnChanged (Sender);
    end
    else ShowMsg (100016,StrInt(Long,0));
    If mMyOp then dmDLS.btPAB.Close;
  end;
end;

procedure TPacEdit.ShowLst (Sender: TObject);
var mKey:word; mShift: TShiftState;  mMyOp:boolean;
begin
  SetFocus;
  mMyOp := not dmDLS.btPAB.Active;
  If mMyOp then dmDLS.OpenList(dmDLS.btPAB,BookNum);
  F_PabPacLstV := TF_PabPacLstV.Create (Self);
  F_PabPacLstV.ShowModal(cView);
  If F_PabPacLstV.Accept then begin
    Long := dmDLS.btPAB.FieldByName ('PaCode').AsInteger;
    Text := dmDLS.btPAB.FieldByName ('PaName').AsString;
    LoadData;
    If Assigned (eOnChanged) then eOnChanged (Sender);
    mKey := vk_Return;
    SpecKeyDownHandle (Self,mKey,mShift);
  end;
  FreeAndNil (F_PabPacLstV);
  If mMyOp then dmDLS.btPAB.Close;
end;

// ********** Editor miest a obci ***********

constructor TCtyEdit.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  inherited OnEnter := MyOnEnter;
  inherited OnExit := MyOnExit;
  Width := 304;
  Height := 20;

  oSearch := TRUE;
  oZipCode := '';
  oStatusLine := nil;
  E_CtyCode := TNameEdit.Create (Self);
  E_CtyCode.MaxLength := 3;
  E_CtyCode.Parent := Self;
  E_CtyCode.Width := 30;
  E_CtyCode.OnKeyDown := MyKeyDown;

  L_CtyName := TSpecLabel.Create (Self);
  L_CtyName.Parent := Self;
  L_CtyName.Top := 2;
  L_CtyName.Left := 38;
  L_CtyName.Caption := '';
  L_CtyName.Font.Color := clNavy;
  L_CtyName.Font.Style := [fsBold];
  L_CtyName.Font.Charset := gvSys.FontCharset;

  Bevel := TBevel.Create (Self);
  Bevel.Parent := Self;
  Bevel.Left := 34;
  Bevel.Width := 248;
  Bevel.Height := 20;
  Bevel.Style := bsLowered;
  Bevel.Shape := bsBox;
  Bevel.Anchors := [akLeft,akRight];

  B_Slct := TSpecButton.Create (Self);
  B_Slct.Parent := Self;
  B_Slct.Width := 20;
  B_Slct.Height := 20;
  B_Slct.Align := alRight;
  B_Slct.ButtonType := btSelect;
  B_Slct.NumGlyphs := 2;
  B_Slct.TabStop := FALSE;
  B_Slct.OnClick := ShowLst;
end;

destructor TCtyEdit.Destroy;
begin
  Bevel.Free;
  E_CtyCode.Free;
  L_CtyName.Free;
  B_Slct.Free;
  inherited;
end;

procedure TCtyEdit.Loaded;
begin
  inherited;
  L_CtyName.Font.Charset := gvSys.FontCharset;
end;

procedure TCtyEdit.SetFocus;
begin
  E_CtyCode.SetFocus;
end;

procedure TCtyEdit.SetCtyCode(pValue:Str3);
begin
  E_CtyCode.Text := pValue;
  SearchData (Self);
end;

function TCtyEdit.GetCtyCode:Str3;
begin
  Result := E_CtyCode.Text;
end;

procedure TCtyEdit.SetCtyName(pValue: Str30);
begin
  L_CtyName.Caption := pValue;
end;

function TCtyEdit.GetCtyName: Str30;
begin
  Result := L_CtyName.Caption
end;

procedure TCtyEdit.MyKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
begin
//  SpecKeyDownHandle (Self,Key,Shift);
  If Key=VK_F7 then  ShowLst (Sender);
  If Assigned (eOnKeyDown) then eOnKeyDown (Sender,Key,Shift);
end;

procedure TCtyEdit.MyOnEnter (Sender: TObject);
begin
  If oStatusLine<>nil then begin
    oStatusLine.TabPosition := TabOrder;
    oStatusLine.CursorPosition := 0;
    oStatusLine.Description := Hint;
  end;
  If Assigned (eOnEnter) then eOnEnter (Sender);
end;

procedure TCtyEdit.MyOnExit (Sender: TObject);
begin
  SearchData (Sender);
  If Assigned (eOnExit) then eOnExit (Sender);
end;

procedure TCtyEdit.SearchData (Sender: TObject);
var mMyOp:boolean;
begin
  If oSearch then begin
    CtyName := '';
    If (CtyCode<>'') then begin
      mMyOp := not dmDLS.btCTYLST.Active;
      If mMyOp then dmDLS.btCTYLST.Open;
      If dmDLS.btCTYLST.IndexName<>'CtyCode' then dmDLS.btCTYLST.IndexName := 'CtyCode';
      If dmDLS.btCTYLST.FindKey ([CtyCode]) then begin
        CtyName := dmDLS.btCTYLST.FieldByname ('CtyName').AsString;
        oZipCode := dmDLS.btCTYLST.FieldByname ('ZipCode').AsString;
        oStaCode := dmDLS.btCTYLST.FieldByname ('StaCode').AsString;
        If Assigned (eOnChanged) then eOnChanged (Sender);
      end;
//      else ShowMsg (110606,CtyCode);
      If mMyOp then dmDLS.btCTYLST.Close;
    end;
  end;
end;

procedure TCtyEdit.ShowLst (Sender: TObject);
var mKey:word; mShift: TShiftState;
begin
  SetFocus;
  F_PabCtyLstV := TF_PabCtyLstV.Create (Self);
  F_PabCtyLstV.ShowModal(cView);
  If F_PabCtyLstV.Accept then begin
    CtyCode := F_PabCtyLstV.CtyCode;
    CtyName := F_PabCtyLstV.CtyName;
    oZipCode := F_PabCtyLstV.ZipCode;
    oStaCode := F_PabCtyLstV.StaCode;
    If Assigned (eOnChanged) then eOnChanged (Sender);
    mKey := vk_Return;
    SpecKeyDownHandle (Self,mKey,mShift);
  end;
  FreeAndNil (F_PabCtyLstV);
end;

// ********** Editor statu ***********

constructor TStaEdit.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  inherited OnEnter := MyOnEnter;
  inherited OnExit := MyOnExit;
  Width := 304;
  Height := 20;

  oSearch := TRUE;
  oStatusLine := nil;
  E_StaCode := TNameEdit.Create (Self);
  E_StaCode.MaxLength := 3;
  E_StaCode.Parent := Self;
  E_StaCode.Width := 30;
  E_StaCode.OnKeyDown := MyKeyDown;

  L_StaName := TSpecLabel.Create (Self);
  L_StaName.Parent := Self;
  L_StaName.Top := 2;
  L_StaName.Left := 38;
  L_StaName.Caption := '';
  L_StaName.Font.Color := clNavy;
  L_StaName.Font.Style := [fsBold];
  L_StaName.Font.Charset := gvSys.FontCharset;

  Bevel := TBevel.Create (Self);
  Bevel.Parent := Self;
  Bevel.Left := 34;
  Bevel.Width := 248;
  Bevel.Height := 20;
  Bevel.Style := bsLowered;
  Bevel.Shape := bsBox;
  Bevel.Anchors := [akLeft,akRight];

  B_Slct := TSpecButton.Create (Self);
  B_Slct.Parent := Self;
  B_Slct.Width := 20;
  B_Slct.Height := 20;
  B_Slct.Align := alRight;
  B_Slct.ButtonType := btSelect;
  B_Slct.NumGlyphs := 2;
  B_Slct.TabStop := FALSE;
  B_Slct.OnClick := ShowLst;
end;

destructor TStaEdit.Destroy;
begin
  Bevel.Free;
  E_StaCode.Free;
  L_StaName.Free;
  B_Slct.Free;
  inherited;
end;

procedure TStaEdit.Loaded;
begin
  inherited;
  L_StaName.Font.Charset := gvSys.FontCharset;
end;

procedure TStaEdit.SetFocus;
begin
  E_StaCode.SetFocus;
end;

procedure TStaEdit.SetStaCode(pValue:Str2);
begin
  E_StaCode.Text := pValue;
  SearchData (Self);
end;

function TStaEdit.GetStaCode:Str2;
begin
  Result := E_StaCode.Text;
end;

procedure TStaEdit.SetStaName(pValue: Str30);
begin
  L_StaName.Caption := pValue;
end;

function TStaEdit.GetStaName: Str30;
begin
  Result := L_StaName.Caption
end;

procedure TStaEdit.MyKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
begin
//  SpecKeyDownHandle (Self,Key,Shift);
  If Key=VK_F7 then  ShowLst (Sender);
  If Assigned (eOnKeyDown) then eOnKeyDown (Sender,Key,Shift);
end;

procedure TStaEdit.MyOnEnter (Sender: TObject);
begin
  If oStatusLine<>nil then begin
    oStatusLine.TabPosition := TabOrder;
    oStatusLine.CursorPosition := 0;
    oStatusLine.Description := Hint;
  end;
  If Assigned (eOnEnter) then eOnEnter (Sender);
end;

procedure TStaEdit.MyOnExit (Sender: TObject);
begin
  SearchData (Sender);
  If Assigned (eOnExit) then eOnExit (Sender);
end;

procedure TStaEdit.SearchData (Sender: TObject);
var mMyOp:boolean;
begin
  If oSearch then begin
    StaName := '';
    If (StaCode<>'') then begin
      mMyOp := not dmDLS.btSTALST.Active;
      If mMyOp then dmDLS.btSTALST.Open;
      If dmDLS.btSTALST.IndexName<>'StaCode' then dmDLS.btSTALST.IndexName := 'StaCode';
      If dmDLS.btSTALST.FindKey ([StaCode]) then begin
        StaName := dmDLS.btSTALST.FieldByname ('StaName').AsString;
        If Assigned (eOnChanged) then eOnChanged (Sender);
      end
      else ShowMsg (110607,StaCode);
      If mMyOp then dmDLS.btSTALST.Close;
    end;
  end;
end;

procedure TStaEdit.ShowLst (Sender: TObject);
var mKey:word; mShift: TShiftState;
begin
  SetFocus;
  F_PabStaLstV := TF_PabStaLstV.Create (Self);
  F_PabStaLstV.ShowModal(cView);
  If F_PabStaLstV.Accept then begin
    StaCode := F_PabStaLstV.StaCode;
    StaName := F_PabStaLstV.StaName;
    If Assigned (eOnChanged) then eOnChanged (Sender);
    mKey := vk_Return;
    SpecKeyDownHandle (Self,mKey,mShift);
  end;
  FreeAndNil (F_PabStaLstV);
end;

// ********** Editor penaznych ustavov ***********
procedure TBanEdit.SearchData (Sender: TObject);
var mMyOp:boolean;
begin
  BookName := '';
  If (BookNum<>'') then begin
    mMyOp := not dmDLS.btBANKLST.Active;
    If mMyOp then dmDLS.btBANKLST.Open;
    If dmDLS.btBANKLST.IndexName<>'BankCode' then dmDLS.btBANKLST.IndexName := 'BankCode';
    If dmDLS.btBANKLST.FindKey ([BookNum]) then begin
      BookName := dmDLS.btBANKLST.FieldByname ('BankName').AsString;
      If Assigned (eOnChanged) then eOnChanged (Sender);
    end
    else ShowMsg (100116,BookNum);
    If mMyOp then dmDLS.btBANKLST.Close;
  end;
end;

procedure TBanEdit.ShowBook (Sender: TObject);
var mKey:word; mShift: TShiftState;
begin
  SetFocus;
  F_PabBankLstV := TF_PabBankLstV.Create (Self);
  F_PabBankLstV.ShowModal(cView);
  If F_PabBankLstV.Accept then begin
    BookNum := F_PabBankLstV.BankCode;
    BookName := F_PabBankLstV.BankName;
    If Assigned (eOnChanged) then eOnChanged (Sender);
    mKey := vk_Return;
    SpecKeyDownHandle (Self,mKey,mShift);
  end;
  FreeAndNil (F_PabBankLstV);
end;

// ********* Editor obchdonych zastupcov *********

constructor TDlrEdit.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  inherited OnEnter := MyOnEnter;
end;

procedure TDlrEdit.SearchData (Sender: TObject);
var mMyOp:boolean;
begin
  Text := '';
  If (Long<>0) then begin
    mMyOp := not dmDLS.btDLRLST.Active;
    If mMyOp then dmDLS.btDLRLST.Open;
    If dmDLS.btDLRLST.IndexName<>'DlrCode' then dmDLS.btDLRLST.IndexName := 'DlrCode';
    If dmDLS.btDLRLST.FindKey ([Long]) then begin
      Text := dmDLS.btDLRLST.FieldByname ('DlrName').AsString;
      If Assigned (eOnChanged) then eOnChanged (Sender);
    end
    else begin
      ShowMsg (100014,StrInt(Long,0));
      E_Long.Long := oBefDlrCode; // Ak kod neexistuje nastavime hodnotu ktora bola pred zmenou
    end;
    If mMyOp then dmDLS.btDLRLST.Close;
  end;
end;

procedure TDlrEdit.ShowLst (Sender: TObject);
var mKey:word; mShift: TShiftState;
begin
  SetFocus;
  F_SysDlrLstV := TF_SysDlrLstV.Create (Self);
  F_SysDlrLstV.ShowModal (cView);
  If F_SysDlrLstV.Accept then begin
    Long := F_SysDlrLstV.DlrCode;
    Text := F_SysDlrLstV.DlrName;
    If Assigned (eOnChanged) then eOnChanged (Sender);
    mKey := vk_Return;
    SpecKeyDownHandle (Self,mKey,mShift);
  end;
  FreeAndNil (F_SysDlrLstV);
end;

procedure TDlrEdit.MyOnEnter (Sender: TObject);
begin
  oBefDlrCode := Long;
  If Assigned (eOnEnter) then eOnEnter (Sender);
end;

// ***** Editor prevadzkovych miest partnerov ******
constructor TWpaEdit.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  inherited OnEnter := MyOnEnter;
  inherited OnExit := MyOnExit;
  Width := 304;
  Height := 20;

  oSearch := TRUE;
  oChanged := FALSE;
  oStatusLine := nil;
  E_PaCode := TLongEdit.Create (Self);
  E_PaCode.Parent := Self;
  E_PaCode.Width := 50;
  E_PaCode.OnKeyDown := MyKeyDown;

  E_WpaCode := TLongEdit.Create (Self);
  E_WpaCode.Parent := Self;
  E_WpaCode.Left := 52;
  E_WpaCode.Width := 30;
  E_WpaCode.OnKeyDown := MyKeyDown;

  L_WpaName := TSpecLabel.Create (Self);
  L_WpaName.Parent := Self;
  L_WpaName.Top := 2;
  L_WpaName.Left := 88;
  L_WpaName.Caption := '';
  L_WpaName.Font.Color := clNavy;
  L_WpaName.Font.Style := [fsBold];
  L_WpaName.Font.Charset := gvSys.FontCharset;

  Bevel := TBevel.Create (Self);
  Bevel.Parent := Self;
  Bevel.Left := 84;
  Bevel.Width := 198;
  Bevel.Height := 20;
  Bevel.Style := bsLowered;
  Bevel.Shape := bsBox;

  B_Slct := TSpecButton.Create (Self);
  B_Slct.Parent := Self;
  B_Slct.Width := 20;
  B_Slct.Height := 20;
  B_Slct.Align := alRight;
  B_Slct.ButtonType := btSelect;
  B_Slct.NumGlyphs := 2;
  B_Slct.TabStop := FALSE;
  B_Slct.OnClick := ShowLst;
end;

destructor TWpaEdit.Destroy;
begin
  Bevel.Free;
  E_PaCode.Free;
  E_WpaCode.Free;
  L_WpaName.Free;
  B_Slct.Free;
  inherited;
end;

procedure TWpaEdit.Loaded;
begin
  inherited;
  L_WpaName.Font.Charset := gvSys.FontCharset;
end;

procedure TWpaEdit.SetFocus;
begin
  E_PaCode.SetFocus;
end;

procedure TWpaEdit.SetPaCode(pValue:longint);
begin
  E_PaCode.Long := pValue;
//  SearchData (Self);
end;

function TWpaEdit.GetPaCode:longint;
begin
  Result := E_PaCode.Long;
end;

procedure TWpaEdit.SetWpaCode(pValue:word);
begin
  E_WpaCode.Long := pValue;
//  SearchData (Self);
end;

function TWpaEdit.GetWpaCode:word;
begin
  Result := E_WpaCode.Long;
end;

procedure TWpaEdit.SetWpaName(pValue: Str30);
begin
  L_WpaName.Caption := pValue;
end;

function TWpaEdit.GetWpaName: Str30;
begin
  Result := L_WpaName.Caption
end;

procedure TWpaEdit.SetShowText(pValue: boolean);
begin
  L_WpaName.Visible := pValue;
//  SetSize; // Nastavi rozmer editora pdola jeho komponentov
end;

function TWpaEdit.GetShowText: boolean;
begin
  Result := L_WpaName.Visible;
end;

procedure TWpaEdit.SetWidthLong(pValue: word);
begin
  E_PaCode.Width := pValue;
//  SetSize; // Nastavi rozmer editora pdola jeho komponentov
end;

function TWpaEdit.GetWidthLong: word;
begin
  Result := E_PaCode.Width;
end;

procedure TWpaEdit.SetWidthText(pValue: word);
begin
  L_WpaName.Width := pValue;
//  SetSize; // Nastavi rozmer editora pdola jeho komponentov
end;

function TWpaEdit.GetWidthText: word;
begin
  Result := L_WpaName.Width;
end;

function  TWpaEdit.GetChanged: boolean;
begin
  Result := E_PaCode.Changed or E_WpaCode.Changed or oChanged;
end;

procedure TWpaEdit.MyKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
begin
  If Key=VK_F7 then  ShowLst (Sender);
  If Assigned (eOnKeyDown) then eOnKeyDown (Sender,Key,Shift);
end;

procedure TWpaEdit.MyOnEnter (Sender: TObject);
begin
  If oStatusLine<>nil then begin
    oStatusLine.TabPosition := TabOrder;
    oStatusLine.CursorPosition := 0;
    oStatusLine.Description := Hint;
  end;
  If Assigned (eOnEnter) then eOnEnter (Sender);
end;

procedure TWpaEdit.MyOnExit (Sender: TObject);
begin
//  If E_PaCode.Changed or E_WpaCode.Changed then SearchData (Sender);
  SearchData (Sender);
  If Assigned (eOnExit) then eOnExit (Sender);
end;

procedure TWpaEdit.SearchData (Sender: TObject);
var mMyOp:boolean;
begin
  If oSearch then begin  // Ak je zapnute vyhladavanie
    WpaName := '';
    If (PaCode<>0) and (WpaCode=0) then begin
      mMyOp := not dmDLS.btPAB.Active;
      If mMyOp then dmDLS.OpenList(dmDLS.btPAB,BookNum);
      If dmDLS.btPAB.IndexName<>'PaCode' then dmDLS.btPAB.IndexName := 'PaCode';
      If dmDLS.btPAB.FindKey ([PaCode]) then begin
        WpaName := dmDLS.btPAB.FieldByname ('PaName').AsString;
        oWpaAddr := dmDLS.btPAB.FieldByname ('RegAddr').AsString;
        oWpaSta := dmDLS.btPAB.FieldByname ('RegSta').AsString;
        oWpaCty := dmDLS.btPAB.FieldByname ('RegCty').AsString;
        oWpaCtn := dmDLS.btPAB.FieldByname ('RegCtn').AsString;
        oWpaZip := dmDLS.btPAB.FieldByname ('RegZip').AsString;
        oWpaTel := dmDLS.btPAB.FieldByname ('RegTel').AsString;
        oWpaFax := dmDLS.btPAB.FieldByname ('RegFax').AsString;
        oWpaEml := dmDLS.btPAB.FieldByname ('RegEml').AsString;
        If Assigned (eOnChanged) then eOnChanged (Sender);
      end
      else begin
        ShowMsg (110602,StrInt(PaCode,0));
        E_PaCode.Undo;
      end;
      If mMyOp then dmDLS.btPAB.Close;
    end;
    If (PaCode<>0) and (WpaCode<>0) then begin
      mMyOp := not dmDLS.btPASUBC.Active;
      If mMyOp then dmDLS.OpenBase(dmDLS.btPASUBC);
      dmDLS.btPASUBC.SwapStatus;
      If dmDLS.btPASUBC.IndexName<>'PaWp' then dmDLS.btPASUBC.IndexName := 'PaWp';
      If dmDLS.btPASUBC.FindKey ([PaCode,WpaCode]) then begin
        WpaName := dmDLS.btPASUBC.FieldByname ('WpaName').AsString;
        oWpaAddr := dmDLS.btPASUBC.FieldByname ('WpaAddr').AsString;
        oWpaSta := dmDLS.btPASUBC.FieldByname ('WpaSta').AsString;
        oWpaCty := dmDLS.btPASUBC.FieldByname ('WpaCty').AsString;
        oWpaCtn := dmDLS.btPASUBC.FieldByname ('WpaCtn').AsString;
        oWpaZip := dmDLS.btPASUBC.FieldByname ('WpaZip').AsString;
        oWpaTel := dmDLS.btPASUBC.FieldByname ('WpaTel').AsString;
        oWpaFax := dmDLS.btPASUBC.FieldByname ('WpaFax').AsString;
        oWpaEml := dmDLS.btPASUBC.FieldByname ('WpaEml').AsString;
        oTrsCode := dmDLS.btPASUBC.FieldByname ('TrsCode').AsString;
        oTrsName := dmDLS.btPASUBC.FieldByname ('TrsName').AsString;
        If Assigned (eOnChanged) then eOnChanged (Sender);
      end
      else begin
        ShowMsg (110605,StrInt(WpaCode,0));
        E_WpaCode.Undo;
      end;
      dmDLS.btPASUBC.RestoreStatus;
      If mMyOp then dmDLS.btPASUBC.Close;
    end;
  end;
end;

procedure TWpaEdit.ShowLst (Sender: TObject);
var mKey:word; mShift: TShiftState;  mMyOp:boolean;
begin
  If E_PaCode.Focused or (E_PaCode.Long=0) then begin
    mMyOp := not dmDLS.btPAB.Active;
    If mMyOp then dmDLS.OpenList(dmDLS.btPAB,BookNum);
    F_PabPacLstV := TF_PabPacLstV.Create (Self);
    F_PabPacLstV.ShowModal(cView);
    If F_PabPacLstV.Accept then begin
      oChanged := TRUE;
      E_PaCode.Long := dmDLS.btPAB.FieldByName ('PaCode').AsInteger;
      WpaName := dmDLS.btPAB.FieldByName ('PaName').AsString;
      If Assigned (eOnChanged) then eOnChanged (Sender);
      mKey := vk_Return;
      SpecKeyDownHandle (Self,mKey,mShift);
    end;
    FreeAndNil (F_PabPacLstV);
    If mMyOp then dmDLS.btPAB.Close;
  end
  else begin
    F_PabWpaLstV := TF_PabWpaLstV.Create (Self);
    F_PabWpaLstV.PaCode := E_PaCode.Long;
    F_PabWpaLstV.ShowModal(cView);
    If F_PabWpaLstV.Accept then begin
      oChanged := TRUE;
      E_PaCode.Long := F_PabWpaLstV.PaCode;
      E_WpaCode.Long := F_PabWpaLstV.WpaCode;
      WpaName := F_PabWpaLstV.WpaName;
      oWpaAddr := F_PabWpaLstV.WpaAddr;
      oWpaSta := F_PabWpaLstV.WpaSta;
      oWpaCty := F_PabWpaLstV.WpaCty;
      oWpaCtn := F_PabWpaLstV.WpaCtn;
      oWpaZip := F_PabWpaLstV.WpaZip;
      oWpaTel := F_PabWpaLstV.WpaTel;
      oWpaFax := F_PabWpaLstV.WpaFax;
      oWpaEml := F_PabWpaLstV.WpaEml;
      oTrsCode := F_PabWpaLstV.TrsCode;
      oTrsName := F_PabWpaLstV.TrsName;
      If Assigned (eOnChanged) then eOnChanged (Sender);
      mKey := vk_Return;
      SpecKeyDownHandle (Self,mKey,mShift);
    end;
    FreeAndNil (F_PabWpaLstV);
  end;
end;

// *********************** Vseobecny Editor ciselnikov ***********************
constructor TLstEditTp.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  inherited OnEnter := MyOnEnter;
end;

procedure TLstEditTp.SearchData (Sender: TObject);
var mMyOp:boolean;
begin
  Text := '';
  If (Long<>0) then begin
    case FLstType of
      ltStk: begin
               If cNexStart then begin
                 E_Long.Long := 1;
                 Text := 'Sklad';
               end else begin
                 mMyOp := not dmSTK.btSTKLST.Active;
                 If mMyOp then dmSTK.btSTKLST.Open;
                 If dmSTK.btSTKLST.IndexName<>'StkNum' then dmSTK.btSTKLST.IndexName := 'StkNum';
                  If dmSTK.btSTKLST.FindKey ([Long]) then begin
                   Text := dmSTK.btSTKLST.FieldByname ('StkName').AsString;
                   If Assigned (eOnChanged) then eOnChanged (Sender);
                 end
                  else begin
                   ShowMsg (100014,StrInt(Long,0));
                   E_Long.Long := oBefNum; // Ak sklad neexistuje nastavime hodnotu ktora bola pred zmenou
                 end;
                 If mMyOp then dmSTK.btSTKLST.Close;
               end;
             end;
      ltPls: begin
               If cNexStart then begin
                 E_Long.Long := 1;
                 Text := 'Cennik';
               end else begin
                 mMyOp := not dmSTK.btPLSLST.Active;
                 If mMyOp then dmSTK.btPLSLST.Open;
                 If dmSTK.btPLSLST.IndexName<>'PlsNum' then dmSTK.btPLSLST.IndexName := 'PlsNum';
                 If dmSTK.btPLSLST.FindKey ([Long]) then begin
                    Text := dmSTK.btPLSLST.FieldByname ('PlsName').AsString;
                   If Assigned (eOnChanged) then eOnChanged (Sender);
                 end
                 else ShowMsg (100015,StrInt(Long,0));
                 If mMyOp then dmSTK.btPLSLST.Close;
               end;
             end;
      ltWri: begin
               mMyOp := not dmDLS.btWRILST.Active;
               If mMyOp then dmDLS.btWRILST.Open;
               If dmDLS.btWRILST.IndexName<>'WriNum' then dmDLS.btWRILST.IndexName := 'WriNum';
               If dmDLS.btWRILST.FindKey ([Long]) then begin
                 Text := dmDLS.btWRILST.FieldByname ('WriName').AsString;
                  If Assigned (eOnChanged) then eOnChanged (Sender);
               end
               else ShowMsg (100014,StrInt(Long,0));
               If mMyOp then dmDLS.btWRILST.Close;
             end;
      ltPAB: begin
               mMyOp := not dmDLS.btPABLST.Active;
               If mMyOp then dmDLS.btPABLST.Open;
               If dmDLS.btPABLST.IndexName<>'BookNum' then dmDLS.btPABLST.IndexName := 'BookNum';
               If dmDLS.btPABLST.FindKey ([Long]) then begin
                 Text := dmDLS.btPABLST.FieldByname ('BookName').AsString;
                 If Assigned (eOnChanged) then eOnChanged (Sender);
               end
                else ShowMsg (100016,StrInt(Long,0));
               If mMyOp then dmDLS.btPABLST.Close;
             end;
      ltPAC: begin
               mMyOp := not dmDLS.btPAB.Active;
               If mMyOp then dmDLS.OpenList(dmDLS.btPAB,BookNum);
               If dmDLS.btPAB.IndexName<>'PaCode' then dmDLS.btPAB.IndexName := 'PaCode';
               If dmDLS.btPAB.FindKey ([Long]) then begin
                 Text := dmDLS.btPAB.FieldByname ('PaName').AsString;
                  LoadPACData;
                 If Assigned (eOnChanged) then eOnChanged (Sender);
               end
               else ShowMsg (100016,StrInt(Long,0));
                If mMyOp then dmDLS.btPAB.Close;
             end;
      ltDlr: begin
               mMyOp := not dmDLS.btDLRLST.Active;
               If mMyOp then dmDLS.btDLRLST.Open;
               If dmDLS.btDLRLST.IndexName<>'DlrCode' then dmDLS.btDLRLST.IndexName := 'DlrCode';
               If dmDLS.btDLRLST.FindKey ([Long]) then begin
                  Text := dmDLS.btDLRLST.FieldByname ('DlrName').AsString;
                 If Assigned (eOnChanged) then eOnChanged (Sender);
               end
               else begin
                 ShowMsg (100014,StrInt(Long,0));
                 E_Long.Long := oBefNum; // Ak kod neexistuje nastavime hodnotu ktora bola pred zmenou
               end;
               If mMyOp then dmDLS.btDLRLST.Close;
             end;
    end;
  end;
end;

procedure TLstEditTp.ShowLst (Sender: TObject);
var mKey:word; mShift: TShiftState; mMyOp:boolean;
begin
  SetFocus;
  case FLstType of
    ltStk: begin
             If cNexStart then begin
               Long:=1;
               Text:='Sklad';
               If Assigned (eOnChanged) then eOnChanged (Sender);
               mKey := vk_Return;
               SpecKeyDownHandle (Self,mKey,mShift);
             end else begin
               F_SysStkLstV := TF_SysStkLstV.Create (Self);
               F_SysStkLstV.ShowModal (cView);
               If F_SysStkLstV.Accept then begin
                 Long := F_SysStkLstV.StkNum;
                 Text := F_SysStkLstV.StkName;
                 If Assigned (eOnChanged) then eOnChanged (Sender);
                 mKey := vk_Return;
                 SpecKeyDownHandle (Self,mKey,mShift);
               end;
               FreeAndNil (F_SysStkLstV);
             end;
           end;
    ltPls: begin
             If cNexStart then begin
               Long:=1;
               Text:='Cennik';
               If Assigned (eOnChanged) then eOnChanged (Sender);
               mKey := vk_Return;
               SpecKeyDownHandle (Self,mKey,mShift);
             end else begin
               F_SysPlsLstV := TF_SysPlsLstV.Create (Self);
               F_SysPlsLstV.ShowModal (cView);
               If F_SysPlsLstV.Accept then begin
                 Long := F_SysPlsLstV.PlsNum;
                  Text := F_SysPlsLstV.PlsName;
                 If Assigned (eOnChanged) then eOnChanged (Sender);
                 mKey := vk_Return;
                 SpecKeyDownHandle (Self,mKey,mShift);
               end;
               FreeAndNil (F_SysPlsLstV);
             end;
           end;
    ltWri: begin
             F_SysWriLstV := TF_SysWriLstV.Create (Self);
             F_SysWriLstV.ShowModal (cView);
             If F_SysWriLstV.Accept then begin
                Long := F_SysWriLstV.WriNum;
               Text := F_SysWriLstV.WriName;
               If Assigned (eOnChanged) then eOnChanged (Sender);
               mKey := vk_Return;
              SpecKeyDownHandle (Self,mKey,mShift);
              end;
             FreeAndNil (F_SysWriLstV);
           end;
    ltPAB: begin
             F_SysPabLstV := TF_SysPabLstV.Create (Self);
             F_SysPabLstV.ShowModal (cView);
             If F_SysPabLstV.Accept then begin
               Long := F_SysPabLstV.BookNum;
               Text := F_SysPabLstV.BookName;
               If Assigned (eOnChanged) then eOnChanged (Sender);
                mKey := vk_Return;
               SpecKeyDownHandle (Self,mKey,mShift);
              end;
             FreeAndNil (F_SysPabLstV);
           end;
    ltPAC: begin
             mMyOp := not dmDLS.btPAB.Active;
             If mMyOp then dmDLS.OpenList(dmDLS.btPAB,BookNum);
             F_PabPacLstV := TF_PabPacLstV.Create (Self);
             F_PabPacLstV.ShowModal(cView);
             If F_PabPacLstV.Accept then begin
               Long := dmDLS.btPAB.FieldByName ('PaCode').AsInteger;
                Text := dmDLS.btPAB.FieldByName ('PaName').AsString;
               LoadPACData;
               If Assigned (eOnChanged) then eOnChanged (Sender);
               mKey := vk_Return;
               SpecKeyDownHandle (Self,mKey,mShift);
             end;
             FreeAndNil (F_PabPacLstV);
             If mMyOp then dmDLS.btPAB.Close;
           end;
    ltDlr: begin
             F_SysDlrLstV := TF_SysDlrLstV.Create (Self);
             F_SysDlrLstV.ShowModal (cView);
             If F_SysDlrLstV.Accept then begin
               Long := F_SysDlrLstV.DlrCode;
               Text := F_SysDlrLstV.DlrName;
               If Assigned (eOnChanged) then eOnChanged (Sender);
               mKey := vk_Return;
                SpecKeyDownHandle (Self,mKey,mShift);
             end;
             FreeAndNil (F_SysDlrLstV);
           end;
  end;
end;

procedure TLstEditTp.MyOnEnter (Sender: TObject);
begin
  oBefNum := Long;
  If Assigned (eOnEnter) then eOnEnter (Sender);
end;

procedure TLstEditTp.SetLstType (pType: TLstEditType);
begin
  if FLstType <> pType then
  begin
    FLstType := pType;
  end;
  If (pType=ltStk) and cNexStart then begin
    E_Long.Long := 1;
    Text := 'Sklad';
  end;
  If (pType=ltPls) and cNexStart then begin
    E_Long.Long := 1;
    Text := 'Cennik';
  end;
end;

procedure TLstEditTp.LoadPACData;
begin
  oRegName := dmDLS.btPAB.FieldByname ('RegName').AsString;
  oRegIno := dmDLS.btPAB.FieldByname ('RegIno').AsString;
  oRegTin := dmDLS.btPAB.FieldByname ('RegTin').AsString;
  oRegVin := dmDLS.btPAB.FieldByname ('RegVin').AsString;
  oRegAddr := dmDLS.btPAB.FieldByname ('RegAddr').AsString;
  oRegSta := dmDLS.btPAB.FieldByname ('RegSta').AsString;
  oRegCty := dmDLS.btPAB.FieldByname ('RegCty').AsString;
  oRegCtn := dmDLS.btPAB.FieldByname ('RegCtn').AsString;
  oRegZip := dmDLS.btPAB.FieldByname ('RegZip').AsString;
  oRegTel := dmDLS.btPAB.FieldByname ('RegTel').AsString;
  oRegFax := dmDLS.btPAB.FieldByname ('RegFax').AsString;
  oRegEml := dmDLS.btPAB.FieldByname ('RegEml').AsString;
  oPayCode := dmDLS.btPAB.FieldByname ('IcPayCode').AsString;
  oPayName := dmDLS.btPAB.FieldByname ('IcPayName').AsString;
  oTrsCode := dmDLS.btPAB.FieldByname ('IcTrsCode').AsString;
  oTrsName := dmDLS.btPAB.FieldByname ('IcTrsName').AsString;
end;


// ************** Editor knih podla typu knihy ***************
procedure TBookEditTp.SearchData (Sender: TObject);
var mMyOp:boolean;
begin
  BookName := '';
  If (BookNum<>'') then begin
    case FBookType of
    tBAN: begin
            mMyOp := not dmDLS.btBANKLST.Active;
            If mMyOp then dmDLS.btBANKLST.Open;
            If dmDLS.btBANKLST.IndexName<>'BankCode' then dmDLS.btBANKLST.IndexName := 'BankCode';
            If dmDLS.btBANKLST.FindKey ([BookNum]) then begin
              BookName := dmDLS.btBANKLST.FieldByname ('BankName').AsString;
              If Assigned (eOnChanged) then eOnChanged (Sender);
            end
            else ShowMsg (100116,BookNum);
            If mMyOp then dmDLS.btBANKLST.Close;
          end;
    end;
  end;
end;

procedure TBookEditTp.ShowBook (Sender: TObject);
var mKey:word; mShift: TShiftState;
begin
  SetFocus;
  case FBookType of
    tBAN: begin
            F_PabBankLstV := TF_PabBankLstV.Create (Self);
            F_PabBankLstV.ShowModal(cView);
            If F_PabBankLstV.Accept then begin
              BookNum := F_PabBankLstV.BankCode;
              BookName := F_PabBankLstV.BankName;
              If Assigned (eOnChanged) then eOnChanged (Sender);
              mKey := vk_Return;
              SpecKeyDownHandle (Self,mKey,mShift);
            end;
            FreeAndNil (F_PabBankLstV);
          end;
  end;
end;

procedure TBookEditTp.SetBookType (pType: TBookEditType);
begin
  if FBookType <> pType then
  begin
    FBookType := pType;
  end;
end;

//**************** Register **********************
procedure Register;
begin
  RegisterComponents('NexEditors', [TmyContoSlct]);
  RegisterComponents('NexEditors', [TAccAnlEdit]);
  RegisterComponents('NexEditors', [TDvzNameEdit]);
  //***********************************************
  RegisterComponents('NexEditors', [TPlsEdit]);
  RegisterComponents('NexEditors', [TStkEdit]);
  RegisterComponents('NexEditors', [TWriEdit]);
  RegisterComponents('NexEditors', [TDlrEdit]);
  RegisterComponents('NexEditors', [TPabEdit]);
  RegisterComponents('NexEditors', [TPacEdit]);
  RegisterComponents('NexEditors', [TWpaEdit]);
  //***********************************************
  RegisterComponents('NexEditors', [TCtyEdit]);
  RegisterComponents('NexEditors', [TStaEdit]);
  RegisterComponents('NexEditors', [TBanEdit]);
  //***********************************************
  RegisterComponents('NexEditors', [TLstEditTp]);
  RegisterComponents('NexEditors', [TBookEditTp]);
end;

end.
{MOD 1804017}
{MOD 1806012}
{MOD 1903004}
