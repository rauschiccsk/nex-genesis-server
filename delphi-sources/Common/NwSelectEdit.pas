unit NwSelectEdit;

interface

uses
  IcStand, IcDate, IcTypes, IcConv, IcTools, IcText, IcVariab, NexMsg, NexGlob, NexError,
  ViewTmp, ViewForm, Bok,
  hCTYLST, hSTALST, hCSOINC, hCSOEXP, hEPCLST, hEPGLST, hACCANL, hIDMLST,
  hTRSLST, hPAYLST, hPASUBC, hGRPLST, hUsrGrp,
  NwEditors, NwInfoFIelds, LangForm, Variants, IcButtons, CmpTools,
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls, ExtCtrls, ComCtrls, Buttons, XpComp;

type
  TLstType = (ltGsl,ltMgl,ltFgl,ltSml,ltPls,ltApl,ltStk,ltWri,ltPab,ltPal,ltDlr,ltEpc,ltRef,ltDrv,ltCnt,ltWpa,ltCoi,ltCoe,ltEpg,ltIdm,ltPay,ltTrs,ltUsg,ltSgl);
  // *************************** Editor zoznamu knih ***************************
  TBokEdi = class(TWinControl)
  private
    oBokNum:TXpEdit;
    oBokName:TXpEdit;
    oBokYear:Str4;
    oBokOwnr:boolean; // Ak je TRUE zobrazi len khihy zadaneho uzivatela
    oPmdMark:Str3;
    oLogName:Str8; // Prihlasovacie meno uzivatela
    oBokLst:TSpecSpeedButton;
    oStatusLine:TStatusLine;
    eOnEnter:TNotifyEvent;
    eOnExit:TNotifyEvent;
    eOnKeyDown:TKeyEvent;
    eOnChanged:TNotifyEvent;
    eOnModified:TNotifyEvent;
    procedure SetBokNum(pValue:Str5);      function  GetBokNum:Str5;
    procedure SetBokName(pValue:Str30);    function  GetBokName:Str30;

    procedure SetInfoField (AValue:boolean);
    function  GetInfoField:boolean;
    procedure SetEnabled (AValue:boolean);
    function  GetEnabled:boolean;

    procedure MyKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure MyOnEnter (Sender: TObject);
    procedure MyOnExit (Sender: TObject);
    procedure MyOnResize (Sender:TObject);
    procedure MyOnModified (Sender:TObject);
    procedure SrchData (Sender: TObject); virtual;
    procedure ShowList (Sender: TObject); virtual;
  public
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
    procedure SetFocus; override;
  published
    {Events}
    property InfoField:boolean read GetInfoField write SetInfoField;
    property Enabled read GetEnabled write SetEnabled;
    property StatusLine:TStatusLine read oStatusLine write oStatusLine;
    property BokNum:Str5 read GetBokNum write SetBokNum;
    property BokName:Str30 read GetBokName write SetBokName;
    property BokYear:Str4 read oBokYear write oBokYear;
    property BokOwnr:boolean read oBokOwnr write oBokOwnr;
    property PmdMark:Str3 read oPmdMark write oPmdMark;
    property LogName:Str8 read oLogName write oLogName;
    property TabOrder;
    property Anchors;
    {Notify}
    property OnModified: TNotifyEvent read eOnModified write eOnModified;
  end;

  // *************************** Editor zoznamov ***************************
  TLstEdi=class(TWinControl)
  private
    oLstNum:TXpEdit;
    oLstName:TXpEdit;
    oPaCode:longint;
    oLstOwnr:boolean; // Ak je TRUE zobrazi len khihy zadaneho uzivatela
    oPmdMark:Str3;
    oLogName:Str8; // Prihlasovacie meno uzivatela
    oBokLst:TSpecSpeedButton;
    oLstType:TLstType;
    oStatusLine:TStatusLine;
    eOnEnter:TNotifyEvent;
    eOnExit:TNotifyEvent;
    eOnKeyDown:TKeyEvent;
    eOnChanged:TNotifyEvent;
    eOnModified:TNotifyEvent;
    procedure SetLstStr(pValue:Str3);      function  GetLstStr:Str3;
    procedure SetLstNum(pValue:longint);      function  GetLstNum:longint;
    procedure SetLstName(pValue:Str30);    function  GetLstName:Str30;
    procedure SetLstType(pValue:TLstType);
    procedure SetInfoField(AValue:boolean);
    function  GetInfoField:boolean;
    procedure SetEnabled(AValue:boolean);
    function  GetEnabled:boolean;

    procedure MyKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure MyOnEnter(Sender: TObject);
    procedure MyOnExit(Sender: TObject);
    procedure MyOnResize(Sender:TObject);
    procedure MyOnModified(Sender:TObject);
    procedure SrchData(Sender: TObject); virtual;
    procedure ShowList(Sender: TObject); virtual;
    procedure SetLstNameVisibled(pValue:boolean);
  public
    oLstNameVisibled:boolean;
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
    procedure SetFocus; override;
  protected
    procedure CreateWnd; override;
  published
    {Events}
    property LstType:TLstType read oLstType write SetLstType;
    property InfoField:boolean read GetInfoField write SetInfoField;
    property Enabled read GetEnabled write SetEnabled;
    property StatusLine:TStatusLine read oStatusLine write oStatusLine;
    property LstNum:longint read GetLstNum write SetLstNum;
    property LstStr:Str3 read GetLstStr write SetLstStr;
    property LstName:Str30 read GetLstName write SetLstName;
    property LstOwnr:boolean read oLstOwnr write oLstOwnr;
    property PmdMark:Str3 read oPmdMark write oPmdMark;
    property LogName:Str8 read oLogName write oLogName;
    property PaCode:longint read oPaCode write oPaCode;
    property TabOrder;
    property Anchors;
    property OnExit;
    property LstNameVisibled:boolean read oLstNameVisibled write SetLstNameVisibled;
    {Notify}
    property OnModified: TNotifyEvent read eOnModified write eOnModified;
  end;

  // *************************** Editor miest a obci ***************************
  TCtyEdi = class(TWinControl)
  private
    oZipCode:TXpEdit;
    oCtyCode:TXpEdit;
    oCtyName:TXpEdit;
    oStaCode:Str2;
    oCtyLst:TSpecSpeedButton;
    oStatusLine:TStatusLine;
    eOnEnter:TNotifyEvent;
    eOnExit:TNotifyEvent;
    eOnKeyDown:TKeyEvent;
    eOnChanged:TNotifyEvent;
    eOnModified:TNotifyEvent;
    ohCTYLST:TCtylstHnd;
    procedure SetZipCode(pValue:Str6);     function  GetZipCode:Str6;
    procedure SetCtyCode(pValue:Str3);     function  GetCtyCode:Str3;
    procedure SetCtyName(pValue:Str30);    function  GetCtyName:Str30;

    procedure SetInfoField (pValue:boolean);
    function  GetInfoField:boolean;
    procedure SetEnabled (pValue:boolean);
    function  GetEnabled:boolean;

    procedure MyKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure MyOnEnter (Sender: TObject);
    procedure MyOnExit (Sender: TObject);
    procedure MyOnResize (Sender:TObject);
    procedure MyOnModified (Sender:TObject);
    procedure MyOnInsEditor (Sender:TObject);
  public
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
    procedure SetFocus; override;
    procedure SrchData (Sender: TObject); virtual;
    procedure ShowList (Sender: TObject); virtual;
  published
    {Events}
    property InfoField:boolean read GetInfoField write SetInfoField;
    property Enabled read GetEnabled write SetEnabled;
    property StatusLine:TStatusLine read oStatusLine write oStatusLine;
    property ZipCode:Str6 read GetZipCode write SetZipCode;
    property CtyCode:Str3 read GetCtyCode write SetCtyCode;
    property CtyName:Str30 read GetCtyName write SetCtyName;
    property StaCode:Str2 read oStaCode;
    property TabOrder;
    property Anchors;
    {Notify}
    property OnModified: TNotifyEvent read eOnModified write eOnModified;
  end;

  // *************************** Editor statov ***************************
  TStaEdi = class(TWinControl)
  private
    oStaCode:TXpEdit;
    oStaName:TXpEdit;
    oStaLst:TSpecSpeedButton;
    oStatusLine:TStatusLine;
    eOnEnter:TNotifyEvent;
    eOnExit:TNotifyEvent;
    eOnKeyDown:TKeyEvent;
    eOnChanged:TNotifyEvent;
    eOnModified:TNotifyEvent;
    procedure SetStaCode(pValue:Str2);     function  GetStaCode:Str2;
    procedure SetStaName(pValue:Str30);    function  GetStaName:Str30;

    procedure SetInfoField (pValue:boolean);
    function  GetInfoField:boolean;
    procedure SetEnabled (pValue:boolean);
    function  GetEnabled:boolean;

    procedure MyKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure MyOnEnter (Sender: TObject);
    procedure MyOnExit (Sender: TObject);
    procedure MyOnResize (Sender:TObject);
    procedure MyOnModified (Sender:TObject);
    procedure SrchCode;
  public
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
    procedure SetFocus; override;
    procedure SrchData (Sender: TObject); virtual;
    procedure ShowList (Sender: TObject); virtual;
  published
    {Events}
    property InfoField:boolean read GetInfoField write SetInfoField;
    property Enabled read GetEnabled write SetEnabled;
    property StatusLine:TStatusLine read oStatusLine write oStatusLine;
    property StaCode:Str2 read GetStaCode write SetStaCode;
    property StaName:Str30 read GetStaName write SetStaName;
    property TabOrder;
    property Anchors;
    {Notify}
    property OnModified: TNotifyEvent read eOnModified write eOnModified;
  end;

  TAccEdi = class(TWinControl)
  private
    oAccSnt:TXpEdit;
    oAccAnl:TXpEdit;
    oAccName:TXpEdit;
    oAccLst:TSpecSpeedButton;
    oStatusLine:TStatusLine;
    eOnEnter:TNotifyEvent;
    eOnExit:TNotifyEvent;
    eOnKeyDown:TKeyEvent;
    eOnChanged:TNotifyEvent;
    eOnModified:TNotifyEvent;
    procedure SetAccSnt(pValue:Str3);      function  GetAccSnt:Str3;
    procedure SetAccAnl(pValue:Str6);      function  GetAccAnl:Str6;
    procedure SetAccName(pValue:Str30);    function  GetAccName:Str30;

    procedure SetInfoField (pValue:boolean);
    function  GetInfoField:boolean;
    procedure SetEnabled (pValue:boolean);
    function  GetEnabled:boolean;

    procedure MyKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure MyOnEnter (Sender: TObject);
    procedure MyOnExit (Sender: TObject);
    procedure MyOnResize (Sender:TObject);
    procedure MyOnModified (Sender:TObject);
  public
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
    procedure SetFocus; override;
    procedure SrchData (Sender: TObject); virtual;
    procedure ShowList (Sender: TObject); virtual;
  published
    {Events}
    property InfoField:boolean read GetInfoField write SetInfoField;
    property Enabled read GetEnabled write SetEnabled;
    property StatusLine:TStatusLine read oStatusLine write oStatusLine;
    property AccSnt:Str3 read GetAccSnt write SetAccSnt;
    property AccAnl:Str6 read GetAccAnl write SetAccAnl;
    property AccName:Str30 read GetAccName write SetAccName;
    property TabOrder;
    property Anchors;
    {Notify}
    property OnModified: TNotifyEvent read eOnModified write eOnModified;
  end;

  // ********** Vseobecny editor vyberovych zoznamov ***********
  TSelectEdit = class(TWinControl)
    oEdit: TNwLongEdit;
    oInfo: TNwNameInfo;
    oButt: TSpecSpeedButton;
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

  // ************** Editor zoznamu skladov *************
  TNwStkLstEdit = class(TSelectEdit)
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

// ************** Editor predajnych cennikov *************
  TNwPlsLstEdit = class(TSelectEdit)
  private
    procedure SearchData (Sender: TObject); override;
    procedure ShowLst (Sender: TObject); override;
  public
  published
  end;

// ************** Editor akciovych cennikov *************
  TNwAplLstEdit = class(TSelectEdit)
  private
    procedure SearchData (Sender: TObject); override;
    procedure ShowLst (Sender: TObject); override;
  public
  published
  end;

// ************** Editor skladovych pohybov *************
  TNwSmLstEdit = class(TSelectEdit)
  private
    procedure SearchData (Sender: TObject); override;
    procedure ShowLst (Sender: TObject); override;
  public
  published
  end;

// ************** Editor obchodnych zastupcov *************
  TNwDlrLstEdit = class(TSelectEdit)
  private
    procedure SearchData (Sender: TObject); override;
    procedure ShowLst (Sender: TObject); override;
  public
  published
  end;

// ******************** Editor skupin *********************
  TGrpEdi = class(TWinControl)
  private
    oGrpTyp:Str3;
    oGrpNum:TXpEdit;
    oGrpName:TXpEdit;
    oGrpLst:TSpecSpeedButton;
    oStatusLine:TStatusLine;
    eOnEnter:TNotifyEvent;
    eOnExit:TNotifyEvent;
    eOnKeyDown:TKeyEvent;
    eOnChanged:TNotifyEvent;
    eOnModified:TNotifyEvent;
    procedure SetGrpNum(pValue:word);      function  GetGrpNum:word;
    procedure SetGrpName(pValue:Str30);    function  GetGrpName:Str30;
    procedure SetInfoField (AValue:boolean);
    function  GetInfoField:boolean;
    procedure SetEnabled (AValue:boolean);
    function  GetEnabled:boolean;
    procedure MyKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure MyOnEnter (Sender: TObject);
    procedure MyOnExit (Sender: TObject);
    procedure MyOnResize (Sender:TObject);
    procedure MyOnModified (Sender:TObject);
    procedure SrchData (Sender: TObject); virtual;
    procedure ShowList (Sender: TObject); virtual;
  public
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
    procedure SetFocus; override;
  protected
    procedure CreateWnd; override;
  published
    property Enabled read GetEnabled write SetEnabled;
    property StatusLine:TStatusLine read oStatusLine write oStatusLine;
    property GrpTyp:Str3 read oGrpTyp write oGrpTyp;
    property GrpNum:word read GetGrpNum write SetGrpNum;
    property GrpName:Str30 read GetGrpName write SetGrpName;
    property TabOrder;
    property Anchors;
    {Notify}
    property OnModified: TNotifyEvent read eOnModified write eOnModified;
  end;

  // ************** Editor pre vsetky zoznamy *************
  TNwLstEdit = class(TSelectEdit)
  private
    oLstType: TLstType;
    procedure SearchData (Sender: TObject); override;
    procedure ShowLst (Sender: TObject); override;
  public
  published
    property LstType: TLstType read oLstType write oLstType;
  end;

procedure Register;

implementation

uses
  DM_STKDAT, DM_DLSDAT,
  pBOKLST, hNXBDEF,
  Acc_AccAnl_V, Sys_CrsLst_V, Sys_PlsLst_V, Sys_StkLst_V,
  Sys_WriLst_V, Sys_PabLst_V, Pab_PacLst_V, Pab_WpaLst_V,
  Sys_EpcLst_V, Sys_EpgLst_V, Stk_SmLst_V,  Gsc_MgLst_V, Gsc_SgLst_V,
  Gsc_FgLst_V,  Sys_AplLst_V, Sys_RefLst_V, Sys_DrvLst_V,
  Gsc_GsLst_V,  Sys_DlrLst_V, Pab_CtyLst_V, Pab_StaLst_V,
  Sys_TrsLst_V, Sys_PayLst_V, Pab_CtyLst_F, Pab_BankLst_V,
  Sys_CntLst_V, Sys_GrpLst,   Sys_UsrGrp,   CsoInc_V,     CsoExp_V,
  bEPCLST, bACCANL, bTRSLST, bPASUBC;


// *************************** Editor zoznamu knih ***************************

constructor TBokEdi.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  inherited OnEnter := MyOnEnter;
  inherited OnExit := MyOnExit;
  inherited OnResize := MyOnResize;
  Width := 320;
  Height := 18;
  oStatusLine := nil;

  oBokNum := TXpEdit.Create (Self);
  oBokNum.Parent := Self;
  oBokNum.Width := 50;
  oBokNum.MaxLength := 5;
  oBokNum.OnKeyDown := MyKeyDown;
  oBokNum.OnModified := MyOnModified;

  oBokName := TXpEdit.Create (Self);
  oBokName.Parent := Self;
  oBokName.Left := oBokNum.Width+1;
  oBokName.Width := 250;
  oBokName.InfoField := TRUE;
  oBokName.Text := '';

  oBokLst := TSpecSpeedButton.Create (Self);
  oBokLst.Parent := Self;
  oBokLst.Width := 18;
  oBokLst.Height := 18;
  oBokLst.Align := alRight;
  oBokLst.ButtonType := btNwSelect;
  oBokLst.NumGlyphs := 2;
//  oButt.TabStop := FALSE;
  oBokLst.OnClick := ShowList;
end;

destructor TBokEdi.Destroy;
begin
  FreeAndNil (oBokNum);
  FreeAndNil (oBokName);
  FreeAndNil (oBokLst);
  inherited;
end;

procedure TBokEdi.SetFocus;
begin
  oBokNum.SetFocus;
end;

procedure TBokEdi.SetBokNum(pValue:Str5);
begin
  oBokNum.Text := pValue;
  SrchData (Self); 
end;

function TBokEdi.GetBokNum:Str5;
begin
  Result := oBokNum.Text;
end;

procedure TBokEdi.SetBokName(pValue:Str30);
begin
  oBokName.Text := pValue
end;

function TBokEdi.GetBokName:Str30;
begin
  Result := oBokName.Text;
end;

procedure TBokEdi.SetInfoField (AValue:boolean);
begin
  oBokNum.InfoField := AValue;
  oBokLst.Visible := not AValue;
end;

function  TBokEdi.GetInfoField:boolean;
begin
  Result := oBokNum.InfoField;
end;

procedure TBokEdi.SetEnabled (AValue:boolean);
begin
  oBokNum.Enabled := AValue;
  oBokName.Enabled := AValue;
  oBokLst.Enabled := AValue;
end;

function  TBokEdi.GetEnabled:boolean;
begin
  Result := oBokNum.Enabled
end;

procedure TBokEdi.MyKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
begin
  If Key=vk_F7 then  ShowList (Sender);
  If (Key=vk_Return) and (BokNum='') then  ShowList (Sender);
  If Assigned (eOnKeyDown) then eOnKeyDown (Sender,Key,Shift);
end;

procedure TBokEdi.MyOnEnter (Sender: TObject);
begin
  If oStatusLine<>nil then begin
    oStatusLine.TabPosition := TabOrder;
    oStatusLine.CursorPosition := 0;
    oStatusLine.Description := Hint;
  end;
  If Assigned (eOnEnter) then eOnEnter (Sender);
end;

procedure TBokEdi.MyOnExit (Sender: TObject);
begin
  SrchData (Sender);
  If Assigned (eOnExit) then eOnExit (Sender);
end;

procedure TBokEdi.MyOnResize (Sender:TObject);
begin
  oBokName.Width := Width-oBokNum.Width-oBokLst.Width-2;
end;

procedure TBokEdi.MyOnModified (Sender:TObject);
begin
  If Assigned (eOnModified) then eOnModified (Sender);
end;

procedure TBokEdi.SrchData (Sender: TObject);
begin
  oBokName.Text := '';
  If oPmdMark<>'' then begin
    If oBokNum.Text<>'' then begin
      If gBok.BokExist(oPmdMark,oBokNum.Text,TRUE) then begin
        If oBokOwnr then begin // Ak je nastavenie zobrazenie vlastnych knih zadaneho uzivatela
          If gBok.BokAcces(gvSys.LoginGroup,oPmdMark,oBokNum.Text) then begin
            oBokName.Text := gBok.BokName(oPmdMark,oBokNum.Text);
          end
          else begin
            ShowMsg(eCom.BokIsNoAcces,oBokNum.Text);
            oBokNum.Text := '';
          end;
        end
        else oBokName.Text := gBok.BokName(oPmdMark,oBokNum.Text);
      end
      else begin
        ShowMsg(eCom.BokIsNoExist,oBokNum.Text);
    //    oBokNum.Text := '';
      end;
    end;
  end else ShowMsg(eCom.PmdMarkIsEmp,'');
end;

procedure TBokEdi.ShowList (Sender: TObject);
var mViewTmp:TF_ViewTmp; mtBOKLST:TBoklstTmp; mbNXBDEF:TNxbdefHnd;  mModified:boolean;
begin
  mtBOKLST := TBoklstTmp.Create;  mtBOKLST.Open;
  If oBokOwnr then begin // Ak je nastavenie zobrazenie vlastnych knih zadaneho uzivatela
    If oLogName='' then oLogName := gvSys.LoginName;
    mtBOKLST.LoadToTmp(oLogName,oPmdMark);
  end
  else begin
    mtBOKLST.LoadToTmp(oPmdMark);
  end;
  mViewTmp := TF_ViewTmp.Create (Self);
  mViewTmp.Execute(mtBOKLST.TmpTable,'BOKLST');
  If mViewTmp.RecordSelect then begin
    mModified := oBokNum.Text<>mtBOKLST.BokNum;
    oBokNum.Text := mtBOKLST.BokNum;
    oBokName.Text := mtBOKLST.BokName;
    If mModified then MyOnModified (Self);
  end;
  FreeAndNil (mViewTmp);
  FreeAndNil (mtBOKLST);
end;

// *************************** Editor zoznamov ***************************

constructor TLstEdi.Create(AOwner: TComponent);
begin
  oLstNameVisibled:=True;
  inherited Create(AOwner);
  inherited OnEnter := MyOnEnter;
  inherited OnExit := MyOnExit;
  inherited OnResize := MyOnResize;
  Width := 320;
  Height := 18;
  oStatusLine := nil;

  oLstNum := TXpEdit.Create (Self);
  oLstNum.Parent := Self;
  oLstNum.Width := 50;
  oLstNum.MaxLength := 7;
  oLstNum.NumSepar := FALSE;
  oLstNum.OnKeyDown := MyKeyDown;
  oLstNum.OnModified := MyOnModified;

  oLstName := TXpEdit.Create (Self);
  oLstName.Parent := Self;
  oLstName.Left := oLstNum.Width+1;
  oLstName.Width := 250;
  oLstName.InfoField := TRUE;
  oLstName.Text := '';

  oBokLst := TSpecSpeedButton.Create (Self);
  oBokLst.Parent := Self;
  oBokLst.Width := 18;
  oBokLst.Height := 18;
  oBokLst.Align := alRight;
  oBokLst.ButtonType := btNwSelect;
  oBokLst.NumGlyphs := 2;
//  oButt.TabStop := FALSE;
  oBokLst.OnClick := ShowList;
end;

destructor TLstEdi.Destroy;
begin
  FreeAndNil (oLstNum);
  FreeAndNil (oLstName);
  FreeAndNil (oBokLst);
  inherited;
end;

procedure TLstEdi.SetFocus;
begin
  oLstNum.SetFocus;
end;

procedure TLstEdi.CreateWnd;
begin
  inherited CreateWnd;
  If LstType in [ltTrs,ltPay]
    then oLstNum.EditorType := etString
    else oLstNum.EditorType := etInteger;
end;

procedure TLstEdi.SetLstNum(pValue:longint);
begin
  oLstNum.AsInteger := pValue;
  SrchData(Self);
end;

function TLstEdi.GetLstNum:longint;
begin
  Result := oLstNum.AsInteger;
end;

procedure TLstEdi.SetLstStr(pValue:Str3);
begin
  oLstNum.AsString := pValue;
  oLstNum.AsInteger := ValInt(pValue); 
  SrchData(Self);
end;

procedure TLstEdi.SetLstType(pValue:TLstType);
begin
  oLstType:=pValue;
  If oLstType in [ltTrs,ltPay]
    then oLstNum.EditorType := etString
    else oLstNum.EditorType := etInteger;
end;

function TLstEdi.GetLstStr:Str3;
begin
  Result := oLstNum.AsString;
end;

procedure TLstEdi.SetLstName(pValue:Str30);
begin
  oLstName.Text := pValue
end;

function TLstEdi.GetLstName:Str30;
begin
  Result := oLstName.Text;
end;

procedure TLstEdi.SetInfoField (AValue:boolean);
begin
  oLstNum.InfoField := AValue;
  oBokLst.Visible := not AValue;
end;

function  TLstEdi.GetInfoField:boolean;
begin
  Result := oLstNum.InfoField;
end;

procedure TLstEdi.SetEnabled (AValue:boolean);
begin
  oLstNum.Enabled := AValue;
  oLstName.Enabled := AValue;
  oBokLst.Enabled := AValue;
end;

function  TLstEdi.GetEnabled:boolean;
begin
  Result := oLstNum.Enabled
end;

procedure TLstEdi.MyKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
begin
  If Key=vk_F7 then  ShowList (Sender);
  If (Key=vk_Return) and (LstNum=0) then  begin
    Key := VK_NONAME;
    ShowList (Sender);
  end;
  If Assigned (eOnKeyDown) then eOnKeyDown (Sender,Key,Shift);
end;

procedure TLstEdi.MyOnEnter (Sender: TObject);
begin
  If oStatusLine<>nil then begin
    oStatusLine.TabPosition := TabOrder;
    oStatusLine.CursorPosition := 0;
    oStatusLine.Description := Hint;
  end;
  If Assigned (eOnEnter) then eOnEnter (Sender);
end;

procedure TLstEdi.MyOnExit (Sender: TObject);
begin
  SrchData (Sender);
  If Assigned (eOnExit) then eOnExit (Sender);
end;

procedure TLstEdi.MyOnResize (Sender:TObject);
begin
  If not oLstNameVisibled then begin
    oLstName.Width := 0;
    oLstName.Visible := False;
  end else If oBokLst<>nil then begin
    oLstName.Width := Width-oLstNum.Width-oBokLst.Width-2;
    oLstName.Visible := True;
  end;
end;

procedure TLstEdi.MyOnModified (Sender:TObject);
begin
  If Assigned (eOnModified) then eOnModified (Sender);
end;

procedure TLstEdi.SrchData (Sender: TObject);
var mMyOp:boolean; mhCSOINC:TCsoincHnd;  mhCSOEXP:TCsoexpHnd;   mhEPCLST:TEpclstHnd;
    mhEPGLST:TEpglstHnd;  mhIDMLST:TIdmlstHnd;  mhUsrGrp:TUsrGrpHnd; mhGrpLST:TGrplstHnd;
    mhTRSLST:TTrslstHnd;  mhPAYLST:TPaylstHnd;  mhPASUBC:TPasubcHnd; mI:integer;
begin
  oLstName.AsString := '';
  If (oLstNum.AsInteger<>0) or ((LstType in [ltTrs,ltPay])and(oLstNum.AsString<>'')) then begin
    case oLstType of
      ltGsl: begin // Zoznam tovarov z bazovej evidencie
               mMyOp := not dmSTK.btGSCAT.Active;
               If mMyOp then dmSTK.btGSCAT.Open;
               If dmSTK.btGSCAT.IndexName<>'GsCode' then dmSTK.btGSCAT.IndexName := 'GsCode';
               If dmSTK.btGSCAT.FindKey ([oLstNum.AsInteger]) then begin
                 oLstName.AsString := dmSTK.btGSCAT.FieldByname ('GsName').AsString;
                 If Assigned (eOnChanged) then eOnChanged (Sender);
               end
               else begin
                 ShowMsg (eCom.GscIsNoExist,StrInt(oLstNum.AsInteger,0));
                 oLstNum.AsInteger := 0;
               end;
               If mMyOp then dmSTK.btGSCAT.Close;
             end;
      ltMgl: begin // Zoznam tovarovych skupin
               mMyOp := not dmSTK.btMGLST.Active;
               If mMyOp then dmSTK.btMGLST.Open;
               If dmSTK.btMGLST.IndexName<>'MgCode' then dmSTK.btMGLST.IndexName := 'MgCode';
               If dmSTK.btMGLST.FindKey ([oLstNum.AsInteger]) then begin
                 oLstName.AsString := dmSTK.btMGLST.FieldByname ('MgName').AsString;
                 If Assigned (eOnChanged) then eOnChanged (Sender);
               end
               else begin
                 ShowMsg (eCom.MgcIsNoExist,StrInt(oLstNum.AsInteger,0));
                 oLstNum.AsInteger := 0;
               end;
               If mMyOp then dmSTK.btMGLST.Close;
             end;
      ltFgl: begin // Zoznam financnych skupin
               mMyOp := not dmSTK.btFGLST.Active;
               If mMyOp then dmSTK.btFGLST.Open;
               If dmSTK.btFGLST.IndexName<>'FgCode' then dmSTK.btFGLST.IndexName := 'FgCode';
               If dmSTK.btFGLST.FindKey ([oLstNum.AsInteger]) then begin
                 oLstName.AsString := dmSTK.btFGLST.FieldByname ('FgName').AsString;
                 If Assigned (eOnChanged) then eOnChanged (Sender);
               end
               else begin
                 ShowMsg (eCom.FgcIsNoExist,StrInt(oLstNum.AsInteger,0));
                 oLstNum.AsInteger := 0;
               end;
               If mMyOp then dmSTK.btFGLST.Close;
             end;
      ltSgl: begin // Zoznam financnych skupin
               mMyOp := not dmSTK.btSGLST.Active;
               If mMyOp then dmSTK.btSGLST.Open;
               If dmSTK.btSGLST.IndexName<>'SgCode' then dmSTK.btSGLST.IndexName := 'SgCode';
               If dmSTK.btSGLST.FindKey ([oLstNum.AsInteger]) then begin
                 oLstName.AsString := dmSTK.btSGLST.FieldByname ('SgName').AsString;
                 If Assigned (eOnChanged) then eOnChanged (Sender);
               end
               else begin
                 ShowMsg (eCom.SgcIsNoExist,StrInt(oLstNum.AsInteger,0));
                 oLstNum.AsInteger := 0;
               end;
               If mMyOp then dmSTK.btSGLST.Close;
             end;
      ltSml: begin // Zoznam skladovych pohybov
               mMyOp := not dmSTK.btSMLST.Active;
               If mMyOp then dmSTK.btSMLST.Open;
               If dmSTK.btSMLST.IndexName<>'SmCode' then dmSTK.btSMLST.IndexName := 'SmCode';
               If dmSTK.btSMLST.FindKey ([oLstNum.AsInteger]) then begin
                 oLstName.AsString := dmSTK.btSMLST.FieldByname ('SmName').AsString;
                 If Assigned (eOnChanged) then eOnChanged (Sender);
               end
               else begin
                 ShowMsg (eCom.MovIsNoExist,StrInt(oLstNum.AsInteger,0));
                 oLstNum.AsInteger := 0;
               end;
               If mMyOp then dmSTK.btSMLST.Close;
             end;
      ltPls: begin // Zoznam predajnych cennikov
               If cNexStart then begin
                 oLstNum.AsInteger:=1;
               end;
               mMyOp := not dmSTK.btPLSLST.Active;
               If mMyOp then dmSTK.btPLSLST.Open;
               If dmSTK.btPLSLST.IndexName<>'PlsNum' then dmSTK.btPLSLST.IndexName := 'PlsNum';
               If dmSTK.btPLSLST.FindKey ([oLstNum.AsInteger]) then begin
                 oLstName.AsString := dmSTK.btPLSLST.FieldByname ('PlsName').AsString;
                 If Assigned (eOnChanged) then eOnChanged (Sender);
               end
               else begin
                 ShowMsg (eCom.PlsIsNoExist,StrInt(oLstNum.AsInteger,0));
                 oLstNum.AsInteger := 0;
               end;
               If mMyOp then dmSTK.btPLSLST.Close;
             end;
      ltApl: begin  // Zoznam akciovych cennikov
               If cNexStart then begin
                 oLstNum.AsInteger:=1;
               end;
               mMyOp := not dmSTK.btAPLLST.Active;
               If mMyOp then dmSTK.btAPLLST.Open;
               If dmSTK.btAPLLST.IndexName<>'AplNum' then dmSTK.btAPLLST.IndexName := 'AplNum';
               If dmSTK.btAPLLST.FindKey ([oLstNum.AsInteger]) then begin
                 oLstName.AsString := dmSTK.btAPLLST.FieldByname ('AplName').AsString;
                 If Assigned (eOnChanged) then eOnChanged (Sender);
               end
               else begin
                 ShowMsg (eCom.AplIsNoExist,StrInt(oLstNum.AsInteger,0));
                 oLstNum.AsInteger := 0;
               end;
               If mMyOp then dmSTK.btAPLLST.Close;
             end;
      ltStk: begin // Zoznam tovarovych skladov
               If cNexStart then begin
                 oLstNum.AsInteger:=1;
               end;
               mMyOp := not dmSTK.btSTKLST.Active;
               If mMyOp then dmSTK.btSTKLST.Open;
               If dmSTK.btSTKLST.IndexName<>'StkNum' then dmSTK.btSTKLST.IndexName := 'StkNum';
               If dmSTK.btSTKLST.FindKey ([oLstNum.AsInteger]) then begin
                 oLstName.AsString := dmSTK.btSTKLST.FieldByname ('StkName').AsString;
                 If Assigned (eOnChanged) then eOnChanged (Sender);
               end
               else begin
                 ShowMsg (eCom.StkIsNoExist,StrInt(oLstNum.AsInteger,0));
                 oLstNum.AsInteger := 0;
               end;
               If mMyOp then dmSTK.btSTKLST.Close;
             end;
      ltWri: begin // Zoznam prevadzkovych jednotiek
               mMyOp := not dmDLS.btWRILST.Active;
               If mMyOp then dmDLS.btWRILST.Open;
               If dmDLS.btWRILST.IndexName<>'WriNum' then dmDLS.btWRILST.IndexName := 'WriNum';
               If dmDLS.btWRILST.FindKey ([oLstNum.AsInteger]) then begin
                 oLstName.AsString := dmDLS.btWRILST.FieldByname ('WriName').AsString;
                 If Assigned (eOnChanged) then eOnChanged (Sender);
               end
               else begin
                 ShowMsg (eCom.WriIsNoExist,StrInt(oLstNum.AsInteger,0));
                 oLstNum.AsInteger := 0;
               end;
               If mMyOp then dmDLS.btWRILST.Close;
             end;
      ltPab: begin // Zoznam knih partnerov
             end;
      ltPal: begin // Zoznam ocbhodnych partnerov
               mI:=Tag;
               mMyOp := not dmDLS.btPAB.Active;
               If not mMyOp then mI:=ValInt(Copy(dmDLS.btPAB.TableName,3,5));
               If mMyOp or(mI<>Tag) then dmDLS.OpenPAB(Tag);
               If dmDLS.btPAB.IndexName<>'PaCode' then dmDLS.btPAB.IndexName := 'PaCode';
               If dmDLS.btPAB.FindKey([oLstNum.AsInteger]) then begin
                 oLstName.AsString := dmDLS.btPAB.FieldByname ('PaName').AsString;
                 If Assigned (eOnChanged) then eOnChanged (Sender);
               end
               else begin
                 ShowMsg (eCom.BokIsNoExist,StrInt(oLstNum.AsInteger,0));
                 oLstNum.AsInteger := 0;
               end;
               If (mI<>Tag) then dmDLS.OpenPAB(mI);
               If mMyOp then dmDLS.btPAB.Close;
             end;
      ltWpa: begin // Zoznam ocbhodnych partnerov
               mhPaSubc:=TPasubcHnd.Create;mhPaSubc.Open;
               If (PaCode>0) then begin
                 If  mhPaSubc.LocatePaWp(PaCode,oLstNum.AsInteger) then begin
                   oLstName.AsString := mhPaSubc.WpaName;
                   If Assigned (eOnChanged) then eOnChanged (Sender);
                 end else begin
                   ShowMsg (ecPabWpaCodeIsExist,StrInt(oLstNum.AsInteger,0));
                 end;
               end else begin

               end;
               mhPaSubc.Close;FreeAndNil(mhPaSubc);
             end;
      ltDlr: begin // Zoznam obchodnych zastupcov
               mMyOp := not dmDLS.btDLRLST.Active;
               If mMyOp then dmDLS.btDLRLST.Open;
               If dmDLS.btDLRLST.IndexName<>'DlrCode' then dmDLS.btDLRLST.IndexName := 'DlrCode';
               If dmDLS.btDLRLST.FindKey ([oLstNum.AsInteger]) then begin
                 oLstName.AsString := dmDLS.btDLRLST.FieldByname ('DlrName').AsString;
                 If Assigned (eOnChanged) then eOnChanged (Sender);
               end
               else begin
                 ShowMsg (100015,StrInt(oLstNum.AsInteger,0));
                 oLstNum.AsInteger := 0;
               end;
               If mMyOp then dmDLS.btDLRLST.Close;
             end;
      ltRef: begin // Zoznam obchodnych referencii
               mMyOp := not dmDLS.btREFLST.Active;
               If mMyOp then dmDLS.btREFLST.Open;
               If dmDLS.btREFLST.IndexName<>'RefCode' then dmDLS.btREFLST.IndexName := 'RefCode';
               If dmDLS.btREFLST.FindKey ([oLstNum.AsInteger]) then begin
                 oLstName.AsString := dmDLS.btREFLST.FieldByname ('RefName').AsString;
                 If Assigned (eOnChanged) then eOnChanged (Sender);
               end
               else begin
                 ShowMsg (100015,StrInt(oLstNum.AsInteger,0));
                 oLstNum.AsInteger := 0;
               end;
               If mMyOp then dmDLS.btREFLST.Close;
             end;
      ltDrv: begin // Zoznam obchodnych referencii
               mMyOp := not dmDLS.btDRVLST.Active;
               If mMyOp then dmDLS.btDRVLST.Open;
               If dmDLS.btDRVLST.IndexName<>'DrvCode' then dmDLS.btDRVLST.IndexName := 'DrvCode';
               If dmDLS.btDRVLST.FindKey ([oLstNum.AsInteger]) then begin
                 oLstName.AsString := dmDLS.btDRVLST.FieldByname ('DrvName').AsString;
                 If Assigned (eOnChanged) then eOnChanged (Sender);
               end
               else begin
                 ShowMsg (100015,StrInt(oLstNum.AsInteger,0));
                 oLstNum.AsInteger := 0;
               end;
               If mMyOp then dmDLS.btDRVLST.Close;
             end;
      ltCnt: begin // Zoznam hospodarskych stredisk
               mMyOp := not dmDLS.btCNTLST.Active;
               If mMyOp then dmDLS.btCNTLST.Open;
               If dmDLS.btCNTLST.IndexName<>'CntNum' then dmDLS.btCNTLST.IndexName := 'CntNum';
               If dmDLS.btCNTLST.FindKey ([oLstNum.AsInteger]) then begin
                 oLstName.AsString := dmDLS.btCNTLST.FieldByname ('CntName').AsString;
                 If Assigned (eOnChanged) then eOnChanged (Sender);
               end
               else begin
                 ShowMsg (eCom.CntIsNoExist,StrInt(oLstNum.AsInteger,0));
                 oLstNum.AsInteger := 0;
               end;
               If mMyOp then dmDLS.btCNTLST.Close;
             end;
      ltCoi: begin // Zoznam prijmovych hotovostnych operacii
               mhCSOINC := TCsoincHnd.Create;  mhCSOINC.Open;
               If mhCSOINC.LocateCsoNum(oLstNum.AsInteger) then begin
                 oLstName.AsString := mhCSOINC.CsoName;
                 If Assigned (eOnChanged) then eOnChanged (Sender);
               end
               else begin
                 ShowMsg (eCom.MovIsNoExist,StrInt(oLstNum.AsInteger,0));
                 oLstNum.AsInteger := 0;
               end;
               FreeAndNil(mhCSOINC);
             end;
      ltCoe: begin // Zoznam vydajovych hotovostnych operacii
               mhCSOEXP := TCsoexpHnd.Create;  mhCSOEXP.Open;
               If mhCSOEXP.LocateCsoNum(oLstNum.AsInteger) then begin
                 oLstName.AsString := mhCSOEXP.CsoName;
                 If Assigned (eOnChanged) then eOnChanged (Sender);
               end
               else begin
                 ShowMsg (eCom.MovIsNoExist,StrInt(oLstNum.AsInteger,0));
                 oLstNum.AsInteger := 0;
               end;
               FreeAndNil(mhCSOEXP);
             end;
      ltIdm: begin // Uctovne operacie
               mhIDMLST := TIdmlstHnd.Create;  mhIDMLST.Open;
               If mhIDMLST.LocateIdmNum(oLstNum.AsInteger) then begin
                 oLstName.AsString := mhIDMLST.IdmName;
                 If Assigned (eOnChanged) then eOnChanged (Sender);
               end
               else begin
                 ShowMsg (eCom.MovIsNoExist,StrInt(oLstNum.AsInteger,0));
                 oLstNum.AsInteger := 0;
               end;
               FreeAndNil(mhIDMLST);
             end;
      ltEpc: begin // Zoznam zamestnancov
               mhEPCLST := TEpclstHnd.Create;  mhEPCLST.Open;
               If mhEPCLST.LocateEpcNum(oLstNum.AsInteger) then begin
                 oLstName.AsString := mhEPCLST.EpcName;
                 If Assigned (eOnChanged) then eOnChanged (Sender);
               end
               else begin
                 ShowMsg (100015,StrInt(oLstNum.AsInteger,0));
                 oLstNum.AsInteger := 0;  oLstNum.AsString := '';
               end;
               FreeAndNil(mhEPCLST);
             end;
      ltEpg: begin // Zoznam zamestnancov
               mhEPGLST := TEpglstHnd.Create;  mhEPGLST.Open;
               If mhEPGLST.LocateEpgNum(oLstNum.AsInteger) then begin
                 oLstName.AsString := mhEPGLST.EpgName;
                 If Assigned (eOnChanged) then eOnChanged (Sender);
               end
               else begin
                 ShowMsg (100015,StrInt(oLstNum.AsInteger,0));
                 oLstNum.AsInteger := 0;  oLstNum.AsString := '';
               end;
               FreeAndNil(mhEPGLST);
             end;
      ltTrs: begin // Zoznam sposobov dopravy
               mhTRSLST := TTrsLstHnd.Create;  mhTRSLST.Open;
               If mhTRSLST.LocateTrsCode (oLstNum.AsString) then begin
                 oLstName.AsString := mhTRSLST.TrsName;
                 If Assigned (eOnChanged) then eOnChanged (Sender);
               end
               else begin
                 ShowMsg (100015,oLstNum.AsString);
                 oLstNum.AsInteger := 0;  oLstNum.AsString := '';
               end;
               FreeAndNil(mhTRSLST);
             end;
      ltPay: begin // Zoznam sposobov platby
               mhPAYLST := TPayLstHnd.Create;  mhPAYLST.Open;
               If mhPAYLST.LocatePayCode (oLstNum.AsString) then begin
                 oLstName.AsString := mhPAYLST.PayName;
                 If Assigned (eOnChanged) then eOnChanged (Sender);
               end
               else begin
                 ShowMsg (100015,oLstNum.AsString);
                 oLstNum.AsInteger := 0;  oLstNum.AsString := '';
               end;
               FreeAndNil(mhPAYLST);
             end;
      ltUsg: begin // Zoznam skupin
               mhUsrGrp := TUsrGrpHnd.Create;  mhUsrGrp.Open;
               If mhUsrGrp.LocateGrpNum (oLstNum.AsInteger) then begin
                 oLstName.AsString := mhUsrGrp.GrpName;
                 If Assigned (eOnChanged) then eOnChanged (Sender);
               end
               else begin
                 ShowMsg (100015,oLstNum.AsString);
                 oLstNum.AsInteger := 0;
               end;
               mhUsrGrp.Close;FreeAndNil(mhUsrGrp);
             end;
    end;
  end;
end;

procedure TLstEdi.ShowList (Sender: TObject);
var mKey:word; mShift: TShiftState;  mMyOp:boolean; mI:integer;
    mCsoInc:TCsoIncV;  mCsoExp:TCsoExpV;  mEpcLst:TSysEpclstV;  mEpgLst:TSysEpglstV;
    mSysUsrGrpF:TSysUsrGrpF;
begin
  oLstNum.SetFocus;
  case oLstType of
    ltGsl: begin // Zoznam tovarov z bazovej evidencie
             mMyOp := not dmSTK.btGSCAT.Active;
             If mMyOp then dmSTK.btGSCAT.Open;
             F_GscGsLstV := TF_GscGsLstV.Create (Self);
             F_GscGsLstV.SetBase(cGsc);
             F_GscGsLstV.ShowGsLst;
             If F_GscGsLstV.Accept then begin
               oLstNum.AsInteger := F_GscGsLstV.GsCode;
               oLstName.AsString := F_GscGsLstV.GsName;
               If Assigned (eOnChanged) then eOnChanged (Sender);
               mKey := vk_Return;
               SpecKeyDownHandle (Self,mKey,mShift);
             end;
             FreeAndNil (F_GscGsLstV);
             If mMyOp then dmSTK.btGSCAT.Close;
           end;
    ltMgl: begin // Zoznam tovarovych skupin
             F_GscMgLstV := TF_GscMgLstV.Create (Self);
             F_GscMgLstV.ShowModal (cView);
             If F_GscMgLstV.Accept then begin
               oLstNum.AsInteger := F_GscMgLstV.MgCode;
               oLstName.AsString := F_GscMgLstV.MgName;
               If Assigned (eOnChanged) then eOnChanged (Sender);
               mKey := vk_Return;
               SpecKeyDownHandle (Self,mKey,mShift);
             end;
             FreeAndNil (F_GscMgLstV);
           end;
    ltFgl: begin // Zoznam financnych skupin
             F_GscFgLstV := TF_GscFgLstV.Create (Self);
             F_GscFgLstV.ShowModal (cView);
             If F_GscFgLstV.Accept then begin
               oLstNum.AsInteger := F_GscFgLstV.FgCode;
               oLstName.AsString := F_GscFgLstV.FgName;
               If Assigned (eOnChanged) then eOnChanged (Sender);
               mKey := vk_Return;
               SpecKeyDownHandle (Self,mKey,mShift);
             end;
             FreeAndNil (F_GscFgLstV);
           end;
    ltSgl: begin // Zoznam špecifikaèných skupin
             F_GscSgLstV := TF_GscSgLstV.Create (Self);
             F_GscSgLstV.ShowModal (cView);
             If F_GscSgLstV.Accept then begin
               oLstNum.AsInteger := F_GscSgLstV.SgCode;
               oLstName.AsString := F_GscSgLstV.SgName;
               If Assigned (eOnChanged) then eOnChanged (Sender);
               mKey := vk_Return;
               SpecKeyDownHandle (Self,mKey,mShift);
             end;
             FreeAndNil (F_GscFgLstV);
           end;
    ltSml: begin // Zoznam skladovych pohybov
             F_StkSmLstV := TF_StkSmLstV.Create (Self);
             F_StkSmLstV.ShowModal (cView);
             If F_StkSmLstV.Accept then begin
               oLstNum.AsInteger := F_StkSmLstV.SmCode;
               oLstName.AsString := F_StkSmLstV.SmName;
               If Assigned (eOnChanged) then eOnChanged (Sender);
               mKey := vk_Return;
               SpecKeyDownHandle (Self,mKey,mShift);
             end;
             FreeAndNil (F_StkSmLstV);
           end;
    ltPls: begin // Zoznam predajnych cennikov
             If cNexStart then begin
               oLstNum.AsInteger := 1;
               oLstName.AsString := 'Cennik';
               If Assigned (eOnChanged) then eOnChanged (Sender);
               mKey := vk_Return;
               SpecKeyDownHandle (Self,mKey,mShift);
             end else begin
               F_SysPlsLstV := TF_SysPlsLstV.Create (Self);
               F_SysPlsLstV.ShowModal (cView);
               If F_SysPlsLstV.Accept then begin
                 oLstNum.AsInteger := F_SysPlsLstV.PlsNum;
                 oLstName.AsString := F_SysPlsLstV.PlsName;
                 If Assigned (eOnChanged) then eOnChanged (Sender);
                 mKey := vk_Return;
                SpecKeyDownHandle (Self,mKey,mShift);
               end;
               FreeAndNil (F_SysPlsLstV);
             end;
           end;
    ltApl: begin  // Zoznam akciovych cennikov
             If cNexStart then begin
               oLstNum.AsInteger := 1;
               oLstName.AsString := 'Cennik';
               If Assigned (eOnChanged) then eOnChanged (Sender);
               mKey := vk_Return;
               SpecKeyDownHandle (Self,mKey,mShift);
             end else begin
               F_SysAplLstV := TF_SysAplLstV.Create (Self);
               F_SysAplLstV.ShowModal (cView);
               If F_SysAplLstV.Accept then begin
                 oLstNum.AsInteger := F_SysAplLstV.AplNum;
                 oLstName.AsString := F_SysAplLstV.AplName;
                 If Assigned (eOnChanged) then eOnChanged (Sender);
                 mKey := vk_Return;
                SpecKeyDownHandle (Self,mKey,mShift);
               end;
               FreeAndNil (F_SysAplLstV);
             end;
           end;
    ltStk: begin // Zoznam tovarovych skladov
             If cNexStart then begin
               oLstNum.AsInteger := 1;
               oLstName.AsString := 'Sklad';
               If Assigned (eOnChanged) then eOnChanged (Sender);
               mKey := vk_Return;
               SpecKeyDownHandle (Self,mKey,mShift);
             end else begin
               F_SysStkLstV := TF_SysStkLstV.Create (Self);
               F_SysStkLstV.ShowModal (cView);
               If F_SysStkLstV.Accept then begin
                 oLstNum.AsInteger := F_SysStkLstV.StkNum;
                 oLstName.AsString := F_SysStkLstV.StkName;
                 If Assigned (eOnChanged) then eOnChanged (Sender);
                 mKey := vk_Return;
                SpecKeyDownHandle (Self,mKey,mShift);
               end;
               FreeAndNil (F_SysStkLstV);
             end;
           end;
    ltWri: begin // Zoznam prevadzkovych jednotiek
             F_SysWriLstV := TF_SysWriLstV.Create (Self);
             F_SysWriLstV.ShowModal (cView);
             If F_SysWriLstV.Accept then begin
               oLstNum.AsInteger := F_SysWriLstV.WriNum;
               oLstName.AsString := F_SysWriLstV.WriName;
               If Assigned (eOnChanged) then eOnChanged (Sender);
               mKey := vk_Return;
              SpecKeyDownHandle (Self,mKey,mShift);
             end;
             FreeAndNil (F_SysWriLstV);
           end;
    ltPab: begin // Zoznam knih partnerov
           end;
    ltPal: begin // Zoznam ocbhodnych partnerov
             mI:=Tag;
             mMyOp := not dmDLS.btPAB.Active;
             If not mMyOp then mI:=ValInt(Copy(dmDLS.btPAB.TableName,3,5));
             If mMyOp or(mI<>Tag) then dmDLS.OpenPAB(Tag);
             F_PabPacLstV := TF_PabPacLstV.Create (Self);
             F_PabPacLstV.ShowModal (cView);
             If F_PabPacLstV.Accept then begin
               oLstNum.AsInteger := F_PabPacLstV.PaCode;
               oLstName.AsString := F_PabPacLstV.PaName;
               If Assigned (eOnChanged) then eOnChanged (Sender);
               mKey := vk_Return;
               SpecKeyDownHandle (Self,mKey,mShift);
               MyOnModified (Sender);
             end;
             FreeAndNil (F_PabPacLstV);
             If (mI<>Tag) then dmDLS.OpenPAB(mI);
             If mMyOp then dmDLS.btPAB.Close;
           end;
    ltDlr: begin // Zoznam obchodnych zastupcov
             F_SysDlrLstV := TF_SysDlrLstV.Create (Self);
             F_SysDlrLstV.ShowModal (cView);
             If F_SysDlrLstV.Accept then begin
               oLstNum.AsInteger := F_SysDlrLstV.DlrCode;
               oLstName.AsString := F_SysDlrLstV.DlrName;
               If Assigned (eOnChanged) then eOnChanged (Sender);
               mKey := vk_Return;
               SpecKeyDownHandle (Self,mKey,mShift);
             end;
             FreeAndNil (F_SysDlrLstV);
           end;
    ltRef: begin // Zoznam obchodnych referencii
             F_SysRefLstV := TF_SysRefLstV.Create (Self);
             F_SysRefLstV.ShowModal (cView);
             If F_SysRefLstV.Accept then begin
               oLstNum.AsInteger := F_SysRefLstV.RefCode;
               oLstName.AsString := F_SysRefLstV.RefName;
               If Assigned (eOnChanged) then eOnChanged (Sender);
               mKey := vk_Return;
               SpecKeyDownHandle (Self,mKey,mShift);
             end;
             FreeAndNil (F_SysRefLstV);
           end;
    ltDrv: begin // Zoznam vodicov sluzobnych vozidiel
             F_SysDrvLstV := TF_SysDrvLstV.Create (Self);
             F_SysDrvLstV.ShowModal (cView);
             If F_SysDrvLstV.Accept then begin
               oLstNum.AsInteger := F_SysDrvLstV.DrvCode;
               oLstName.AsString := F_SysDrvLstV.DrvName;
               If Assigned (eOnChanged) then eOnChanged (Sender);
               mKey := vk_Return;
               SpecKeyDownHandle (Self,mKey,mShift);
             end;
             FreeAndNil (F_SysDrvLstV);
           end;
    ltCnt: begin // Zoznam prevadzkovych jednotiek
             F_SysCntLstV := TF_SysCntLstV.Create (Self);
             F_SysCntLstV.ShowModal (cView);
             If F_SysCntLstV.Accept then begin
               oLstNum.AsInteger := F_SysCntLstV.CntNum;
               oLstName.AsString := F_SysCntLstV.CntName;
               If Assigned (eOnChanged) then eOnChanged (Sender);
               mKey := vk_Return;
               SpecKeyDownHandle (Self,mKey,mShift);
             end;
             FreeAndNil (F_SysCntLstV);
           end;
    ltCoi: begin // Zoznam prijmovych hotovostnych pohybov
             mCsoInc := TCsoIncV.Create (Self);
             mCsoInc.ShowModal (cView);
             If mCsoInc.Accept then begin
               oLstNum.AsInteger := mCsoInc.CsoNum;
               oLstName.AsString := mCsoInc.CsoName;
               If Assigned (eOnChanged) then eOnChanged (Sender);
               mKey := vk_Return;
               SpecKeyDownHandle (Self,mKey,mShift);
             end;
             FreeAndNil (mCsoInc);
           end;
    ltCoe: begin // Zoznam prijmovych hotovostnych pohybov
             mCsoExp := TCsoExpV.Create (Self);
             mCsoExp.ShowModal (cView);
             If mCsoExp.Accept then begin
               oLstNum.AsInteger := mCsoExp.CsoNum;
               oLstName.AsString := mCsoExp.CsoName;
               If Assigned (eOnChanged) then eOnChanged (Sender);
               mKey := vk_Return;
               SpecKeyDownHandle (Self,mKey,mShift);
             end;
             FreeAndNil (mCsoExp);
           end;
    ltEpc: begin // Zoznam zamestnancov
             mEpcLst := TSysEpcLstV.Create(Self);
             mEpcLst.Execute(cView);
             If mEpcLst.Accept then begin
               oLstNum.AsInteger := mEpcLst.EpcNum;
               oLstName.AsString := mEpcLst.EpcName;
               If Assigned (eOnChanged) then eOnChanged (Sender);
               mKey := vk_Return;
               SpecKeyDownHandle (Self,mKey,mShift);
             end;
             FreeAndNil (mEpcLst);
           end;
    ltEpg: begin // Zoznam zamestnaneckých skupin
             mEpgLst := TSysEpgLstV.Create(Self);
             mEpgLst.Execute(cView);
             If mEpgLst.Accept then begin
               oLstNum.AsInteger := mEpgLst.EpgNum;
               oLstName.AsString := mEpgLst.EpgName;
               If Assigned (eOnChanged) then eOnChanged (Sender);
               mKey := vk_Return;
               SpecKeyDownHandle (Self,mKey,mShift);
             end;
             FreeAndNil (mEpgLst);
           end;
    ltTrs: begin // Zoznam sposobov dopravy
             F_SysTrsLstV := TF_SysTrsLstV.Create (Self);
             F_SysTrsLstV.ShowModal (cView);
             If F_SysTrsLstV.Accept then begin
               oLstNum.AsString := F_SysTrsLstV.TrsCode;
               oLstName.AsString := F_SysTrsLstV.TrsName;
               If Assigned (eOnChanged) then eOnChanged (Sender);
               mKey := vk_Return;
               SpecKeyDownHandle (Self,mKey,mShift);
             end;
             FreeAndNil (F_SysTrsLstV);
           end;
    ltPay: begin // Zoznam sposobov platby
             F_SysPayLstV := TF_SysPayLstV.Create (Self);
             F_SysPayLstV.ShowModal(cView);
             If F_SysPayLstV.Accept then begin
               oLstNum.AsString := F_SysPayLstV.PayCode;
               oLstName.AsString := F_SysPayLstV.PayName;
               If Assigned (eOnChanged) then eOnChanged (Sender);
               mKey := vk_Return;
               SpecKeyDownHandle (Self,mKey,mShift);
             end;
             FreeAndNil (F_SysPayLstV);
           end;
    ltUsg: begin // Zoznam skupin prihlasenia
             mSysUsrGrpF := TSysUsrGrpF.Create (Self);
             mSysUsrGrpF.Execute(gvSys.LoginGroup);
             If mSysUsrGrpF.Accept then begin
               oLstNum.AsInteger  := mSysUsrGrpF.GrpNum;
               oLstName.AsString  := mSysUsrGrpF.GrpName;
               If Assigned (eOnChanged) then eOnChanged (Sender);
               mKey := vk_Return;
               SpecKeyDownHandle (Self,mKey,mShift);
             end;
             FreeAndNil (mSysUsrGrpF);
           end;
    ltWpa: begin
              F_PabWpaLstV := TF_PabWpaLstV.Create (Self);
              F_PabWpaLstV.PaCode := Pacode;
              F_PabWpaLstV.ShowModal(cView);
              If F_PabWpaLstV.Accept then begin
                oLstNum.AsInteger := F_PabWpaLstV.WpaCode;
                oLstName.AsString := F_PabWpaLstV.WpaName;
{
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
}
                If Assigned (eOnChanged) then eOnChanged (Sender);
                mKey := vk_Return;
                SpecKeyDownHandle (Self,mKey,mShift);
              end;
              FreeAndNil (F_PabWpaLstV);
           end;
  end;
end;

procedure TLstEdi.SetLstNameVisibled(pValue:boolean);
begin
  oLstNameVisibled:=pValue;
  MyOnResize(Self);
end;

// *************************** Editor miest a obci ***************************

constructor TCtyEdi.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  inherited OnEnter := MyOnEnter;
  inherited OnExit := MyOnExit;
  inherited OnResize := MyOnResize;
  Width := 320;
  Height := 18;
  oStatusLine := nil;

  oZipCode := TXpEdit.Create (Self);
  oZipCode.Parent := Self;
  oZipCode.Width := 58;
  oZipCode.MaxLength := 15;
  oZipCode.OnKeyDown := MyKeyDown;
  oZipCode.OnModified := MyOnModified;

  oCtyCode := TXpEdit.Create (Self);
  oCtyCode.Parent := Self;
  oCtyCode.Left := oZipCode.Width+1;
  oCtyCode.Width := 34;
  oCtyCode.InfoField := TRUE;
  oCtyCode.Text := '';

  oCtyName := TXpEdit.Create (Self);
  oCtyName.Parent := Self;
  oCtyName.Left := oCtyCode.Left+oCtyCode.Width+1;
  oCtyName.Width := 207;
  oCtyName.InfoField := TRUE;
  oCtyName.Text := '';

  oCtyLst := TSpecSpeedButton.Create (Self);
  oCtyLst.Parent := Self;
  oCtyLst.Width := 18;
  oCtyLst.Height := 18;
  oCtyLst.Align := alRight;
  oCtyLst.ButtonType := btNwSelect;
  oCtyLst.NumGlyphs := 2;
  oCtyLst.OnClick := ShowList;
end;

destructor TCtyEdi.Destroy;
begin
  FreeAndNil (oZipCode);
  FreeAndNil (oCtyCode);
  FreeAndNil (oCtyName);
  FreeAndNil (oCtyLst);
  inherited;
end;

procedure TCtyEdi.SetFocus;
begin
  oZipCode.SetFocus;
end;

procedure TCtyEdi.SetZipCode(pValue:Str6);
begin
  oZipCode.Text := pValue
end;

function TCtyEdi.GetZipCode:Str6;
begin
  Result := oZipCode.Text;
end;

procedure TCtyEdi.SetCtyCode(pValue:Str3);
begin
  oCtyCode.Text := pValue
end;

function TCtyEdi.GetCtyCode:Str3;
begin
  Result := oCtyCode.Text;
end;

procedure TCtyEdi.SetCtyName(pValue:Str30);
begin
  oCtyName.Text := pValue
end;

function TCtyEdi.GetCtyName:Str30;
begin
  Result := oCtyName.Text;
end;

procedure TCtyEdi.SetInfoField (pValue:boolean);
begin
  oZipCode.InfoField := pValue;
  oCtyLst.Visible := not pValue;
end;

function  TCtyEdi.GetInfoField:boolean;
begin
  Result := oZipCode.InfoField;
end;

procedure TCtyEdi.SetEnabled (pValue:boolean);
begin
  oZipCode.Enabled := pValue;
  oCtyCode.Enabled := pValue;
  oCtyName.Enabled := pValue;
  oCtyLst.Enabled := pValue;
end;

function  TCtyEdi.GetEnabled:boolean;
begin
  Result := oZipCode.Enabled
end;

procedure TCtyEdi.MyKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
begin
  If Key=vk_F7 then  ShowList (Sender);
//  If (Key=vk_Return) and (ZipCode='') then  ShowList (Sender);
  If Assigned (eOnKeyDown) then eOnKeyDown (Sender,Key,Shift);
end;

procedure TCtyEdi.MyOnEnter (Sender: TObject);
begin
  If oStatusLine<>nil then begin
    oStatusLine.TabPosition := TabOrder;
    oStatusLine.CursorPosition := 0;
    oStatusLine.Description := Hint;
  end;
  If Assigned (eOnEnter) then eOnEnter (Sender);
end;

procedure TCtyEdi.MyOnExit (Sender: TObject);
begin
  SrchData (Sender);
  If Assigned (eOnExit) then eOnExit (Sender);
end;

procedure TCtyEdi.MyOnResize (Sender:TObject);
begin
  oCtyName.Width := Width-oZipCode.Width-oCtyCode.Width-oCtyLst.Width-3;
end;

procedure TCtyEdi.MyOnModified (Sender:TObject);
begin
  If Assigned (eOnModified) then eOnModified (Sender);
end;

procedure TCtyEdi.SrchData (Sender: TObject);
var mhCTYLST:TCtylstHnd;
begin
  If oZipCode.Text<>'' then begin
    mhCTYLST := TCtylstHnd.Create;  mhCTYLST.Open;
    If mhCTYLST.LocateCtyCode (oZipCode.Text) then begin
      oZipCode.Text := mhCTYLST.ZipCode;
      oCtyCode.Text := mhCTYLST.CtyCode;
      oCtyName.Text := mhCTYLST.CtyName;
      oStaCode := mhCTYLST.StaCode;
    end else begin
      If mhCTYLST.LocateZipCode (oZipCode.Text) then begin
        oZipCode.Text := mhCTYLST.ZipCode;
        oCtyCode.Text := mhCTYLST.CtyCode;
        oCtyName.Text := mhCTYLST.CtyName;
        oStaCode := mhCTYLST.StaCode;
      end;
    end;
    FreeAndNil (mhCTYLST);
  end else begin
    oCtyCode.Text := '';
    oCtyName.Text := '';
  end;
end;

procedure TCtyEdi.ShowList (Sender: TObject);
var mViewBtr:TViewForm;mModified:boolean;
begin
  ohCTYLST := TCtylstHnd.Create;  ohCTYLST.Open;
  mViewBtr := TViewForm.Create (Self);
  mViewBtr.DgdName := 'CTYLST';
  mViewBtr.DataSet := ohCTYLST.BtrTable;
  mViewBtr.eOnInsPressed:=MyOnInsEditor;
  mViewBtr.Execute;
  If mViewBtr.RecordSelect then begin
    mModified:=oZipCode.Text <> ohCTYLST.ZipCode;
    oZipCode.Text := ohCTYLST.ZipCode;
    oCtyCode.Text := ohCTYLST.CtyCode;
    oCtyName.Text := ohCTYLST.CtyName;
    oStaCode := ohCTYLST.StaCode;
    If mModified then MyOnModified(Self);
  end;
  FreeAndNil (mViewBtr);
  FreeAndNil (ohCTYLST);
end;

procedure TCtyEdi.MyOnInsEditor(Sender: TObject);
var mCtyEdi:TPabCtyEdiF;
begin
  mCtyEdi := TPabCtyEdiF.Create(Self);
  mCtyEdi.ExecNew(ohCTYLST);
  FreeAndNil (mCtyEdi);
end;

// *************************** Editor statov ***************************

constructor TStaEdi.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  inherited OnEnter := MyOnEnter;
  inherited OnExit := MyOnExit;
  inherited OnResize := MyOnResize;
  Width := 320;
  Height := 18;
  oStatusLine := nil;

  oStaCode := TXpEdit.Create (Self);
  oStaCode.Parent := Self;
  oStaCode.Width := 30;
  oStaCode.MaxLength := 2;
  oStaCode.OnKeyDown := MyKeyDown;
  oStaCode.OnModified := MyOnModified;

  oStaName := TXpEdit.Create (Self);
  oStaName.Parent := Self;
  oStaName.Left := oStaCode.Width+1;
  oStaName.Width := 270;
  oStaName.InfoField := TRUE;
  oStaName.Text := '';

  oStaLst := TSpecSpeedButton.Create (Self);
  oStaLst.Parent := Self;
  oStaLst.Width := 18;
  oStaLst.Height := 18;
  oStaLst.Align := alRight;
  oStaLst.ButtonType := btNwSelect;
  oStaLst.NumGlyphs := 2;
  oStaLst.OnClick := ShowList;
end;

destructor TStaEdi.Destroy;
begin
  FreeAndNil (oStaCode);
  FreeAndNil (oStaName);
  FreeAndNil (oStaLst);
  inherited;
end;

procedure TStaEdi.SetFocus;
begin
  oStaCode.SetFocus;
end;

procedure TStaEdi.SetStaCode(pValue:Str2);
begin
  oStaCode.Text := pValue;
  SrchCode;
end;

function TStaEdi.GetStaCode:Str2;
begin
  Result := oStaCode.Text;
end;

procedure TStaEdi.SetStaName(pValue:Str30);
begin
  oStaName.Text := pValue
end;

function TStaEdi.GetStaName:Str30;
begin
  Result := oStaName.Text;
end;

procedure TStaEdi.SetInfoField (pValue:boolean);
begin
  oStaCode.InfoField := pValue;
  oStaLst.Visible := not pValue;
end;

function  TStaEdi.GetInfoField:boolean;
begin
  Result := oStaCode.InfoField;
end;

procedure TStaEdi.SetEnabled (pValue:boolean);
begin
  oStaCode.Enabled := pValue;
  oStaName.Enabled := pValue;
  oStaLst.Enabled := pValue;
end;

function  TStaEdi.GetEnabled:boolean;
begin
  Result := oStaCode.Enabled
end;

procedure TStaEdi.MyKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
begin
  If Key=vk_F7 then  ShowList (Sender);
//  If (Key=vk_Return) and (StaCode='') then  ShowList (Sender);
  If Assigned (eOnKeyDown) then eOnKeyDown (Sender,Key,Shift);
end;

procedure TStaEdi.MyOnEnter (Sender: TObject);
begin
  If oStatusLine<>nil then begin
    oStatusLine.TabPosition := TabOrder;
    oStatusLine.CursorPosition := 0;
    oStatusLine.Description := Hint;
  end;
  If Assigned (eOnEnter) then eOnEnter (Sender);
end;

procedure TStaEdi.MyOnExit (Sender: TObject);
begin
  SrchData (Sender);
  If Assigned (eOnExit) then eOnExit (Sender);
end;

procedure TStaEdi.MyOnResize (Sender:TObject);
begin
  oStaName.Width := Width-oStaCode.Width-oStaLst.Width-2;
end;

procedure TStaEdi.MyOnModified (Sender:TObject);
begin
  If Assigned (eOnModified) then eOnModified (Sender);
end;

procedure TStaEdi.SrchCode;
var mhSTALST:TStalstHnd;
begin
  If oStaCode.Text<>'' then begin
    mhSTALST := TStalstHnd.Create;  mhSTALST.Open;
    If mhSTALST.LocateStaCode (oStaCode.Text) then begin
      oStaCode.Text := mhSTALST.StaCode;
      oStaName.Text := mhSTALST.StaName;
    end
    else oStaCode.Text := '';
    FreeAndNil (mhSTALST);
  end
  else oStaName.Text := '';
end;

procedure TStaEdi.SrchData (Sender: TObject);
begin
  SrchCode;
end;

procedure TStaEdi.ShowList (Sender: TObject);
var mViewBtr:TViewForm; mhSTALST:TStalstHnd;
begin
  mhSTALST := TStalstHnd.Create;  mhSTALST.Open;
  mViewBtr := TViewForm.Create (Self);
  mViewBtr.DgdName := 'STALST';
  mViewBtr.DataSet := mhStaLST.BtrTable;
  mViewBtr.Execute;
  If mViewBtr.RecordSelect then begin
    oStaCode.Text := mhSTALST.StaCode;
    oStaName.Text := mhSTALST.StaName;
  end;
  FreeAndNil (mViewBtr);
  FreeAndNil (mhSTALST);
end;

// *************************** Editor analytickeho uctu ***************************

constructor TAccEdi.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  inherited OnEnter := MyOnEnter;
  inherited OnExit := MyOnExit;
  inherited OnResize := MyOnResize;
  Width := 320;
  Height := 18;
  oStatusLine := nil;

  oAccSnt := TXpEdit.Create (Self);
  oAccSnt.Parent := Self;
  oAccSnt.Width := 34;
  oAccSnt.MaxLength := 3;
  oAccSnt.Text := '';
  oAccSnt.OnKeyDown := MyKeyDown;
  oAccSnt.OnModified := MyOnModified;

  oAccAnl := TXpEdit.Create (Self);
  oAccAnl.Parent := Self;
  oAccAnl.Left := oAccSnt.Width+1;
  oAccAnl.Width := 58;
  oAccAnl.Text := '';
  oAccAnl.OnKeyDown := MyKeyDown;
  oAccAnl.OnModified := MyOnModified;

  oAccName := TXpEdit.Create (Self);
  oAccName.Parent := Self;
  oAccName.Left := oAccSnt.Left+oAccSnt.Width+oAccAnl.Width+2;
  oAccName.Width := 207;
  oAccName.InfoField := TRUE;
  oAccName.Text := '';

  oAccLst := TSpecSpeedButton.Create (Self);
  oAccLst.Parent := Self;
  oAccLst.Width := 18;
  oAccLst.Height := 18;
  oAccLst.Align := alRight;
  oAccLst.ButtonType := btNwSelect;
  oAccLst.NumGlyphs := 2;
  oAccLst.OnClick := ShowList;
end;

destructor TAccEdi.Destroy;
begin
  FreeAndNil (oAccSnt);
  FreeAndNil (oAccAnl);
  FreeAndNil (oAccName);
  inherited;
end;

procedure TAccEdi.SetFocus;
begin
  oAccSnt.SetFocus;
end;

procedure TAccEdi.SetAccSnt(pValue:Str3);
begin
  oAccSnt.AsString := pValue
end;

function TAccEdi.GetAccSnt:Str3;
begin
  Result := oAccSnt.AsString;
end;

procedure TAccEdi.SetAccAnl(pValue:Str6);
begin
  oAccAnl.Text := pValue
end;

function TAccEdi.GetAccAnl:Str6;
begin
  Result := oAccAnl.Text;
end;

procedure TAccEdi.SetAccName(pValue:Str30);
begin
  oAccName.Text := pValue
end;

function TAccEdi.GetAccName:Str30;
begin
  Result := oAccName.Text;
end;

procedure TAccEdi.SetInfoField (pValue:boolean);
begin
  oAccSnt.InfoField := pValue;
  oAccAnl.InfoField := pValue;
  oAccLst.Visible := not pValue;
end;

function  TAccEdi.GetInfoField:boolean;
begin
  Result := oAccSnt.InfoField;
end;

procedure TAccEdi.SetEnabled (pValue:boolean);
begin
  oAccSnt.Enabled := pValue;
  oAccAnl.Enabled := pValue;
  oAccName.Enabled := pValue;
  oAccLst.Enabled := pValue;
end;

function  TAccEdi.GetEnabled:boolean;
begin
  Result := oAccSnt.Enabled
end;

procedure TAccEdi.MyKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
begin
  If Key=vk_F7 then  ShowList (Sender);
  If Assigned (eOnKeyDown) then eOnKeyDown (Sender,Key,Shift);
end;

procedure TAccEdi.MyOnEnter (Sender: TObject);
begin
  If oStatusLine<>nil then begin
    oStatusLine.TabPosition := TabOrder;
    oStatusLine.CursorPosition := 0;
    oStatusLine.Description := Hint;
  end;
  If Assigned (eOnEnter) then eOnEnter (Sender);
end;

procedure TAccEdi.MyOnExit (Sender: TObject);
begin
  SrchData (Sender);
  If Assigned (eOnExit) then eOnExit (Sender);
end;

procedure TAccEdi.MyOnResize (Sender:TObject);
begin
  oAccName.Width := Width-oAccSnt.Width-oAccAnl.Width-oAccLst.Width-3;
end;

procedure TAccEdi.MyOnModified (Sender:TObject);
begin
  If Assigned (eOnModified) then eOnModified (Sender);
end;

procedure TAccEdi.SrchData (Sender: TObject);
var mhACCANL:TAccanlHnd;
begin
  If oAccSnt.Text<>'' then begin
    mhACCANL := TAccanlHnd.Create;  mhACCANL.Open;
    If mhACCANL.LocateSnAn(oAccSnt.AsString,oAccAnl.AsString) then begin
      oAccName.Text := mhACCANL.AnlName;
    end
    else oAccName.Text := '';
    FreeAndNil (mhACCANL);
  end;
end;

procedure TAccEdi.ShowList (Sender: TObject);
var mViewBtr:TViewForm;  mhACCANL:TAccanlHnd;
begin
  mhACCANL := TAccanlHnd.Create;  mhACCANL.Open;
  mViewBtr := TViewForm.Create (Self);
  mViewBtr.DgdName := 'ACCANL';
  mViewBtr.DataSet := mhACCANL.BtrTable;
  mViewBtr.Execute;
  If mViewBtr.RecordSelect then begin
    oAccSnt.AsString := mhACCANL.AccSnt;
    oAccAnl.AsString := mhACCANL.AccAnl;
    oAccName.AsString := mhACCANL.AnlName;
  end;
  FreeAndNil (mViewBtr);
  FreeAndNil (mhACCANL);
end;

// ************** Editor zoznamov *************
constructor TSelectEdit.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  inherited OnEnter := MyOnEnter;
  inherited OnExit := MyOnExit;
  Width := 281;
  Height := 17;

  oStatusLine := nil;
  oEdit := TNwLongEdit.Create (Self);
  oEdit.Parent := Self;
  oEdit.Width := 40;
  oEdit.OnKeyDown := MyKeyDown;

  oInfo := TNwNameInfo.Create (Self);
  oInfo.Parent := Self;
  oInfo.Top := 0;
  oInfo.Left := 42;
  oInfo.Text := '';

  oButt := TSpecSpeedButton.Create (Self);
  oButt.Parent := Self;
  oButt.Width := 17;
  oButt.Height := 17;
  oButt.Align := alRight;
  oButt.ButtonType := btNwSelect;
  oButt.NumGlyphs := 2;
//  oButt.TabStop := FALSE;
  oButt.OnClick := ShowLst;
end;

destructor TSelectEdit.Destroy;
begin
  oInfo.Free;
  oEdit.Free;
  oButt.Free;
  inherited;
end;

procedure TSelectEdit.Loaded;
begin
  inherited;
//  L_Text.Font.Charset := gvSys.FontCharset;
//  SetSize; // Nastavi rozmer editora pdola jeho komponentov
end;

procedure TSelectEdit.SetFocus;
begin
  oEdit.SetFocus;
end;

procedure TSelectEdit.SetLong(pValue:longint);
begin
  oEdit.Long := pValue;
  SearchData (Self);
end;

function TSelectEdit.GetLong:longint;
begin
  Result := oEdit.Long;
end;

procedure TSelectEdit.SetText(pValue: Str30);
begin
  oInfo.Text := pValue;
end;

function TSelectEdit.GetText: Str30;
begin
  Result := oInfo.Text;
end;

procedure TSelectEdit.SetShowText(pValue: boolean);
begin
  oInfo.Visible := pValue;
  SetSize; // Nastavi rozmer editora pdola jeho komponentov
end;

function TSelectEdit.GetShowText: boolean;
begin
  Result := oInfo.Visible;
end;

procedure TSelectEdit.SetWidthLong(pValue: word);
begin
  oEdit.Width := pValue;
  SetSize; // Nastavi rozmer editora pdola jeho komponentov
end;

function TSelectEdit.GetWidthLong: word;
begin
  Result := oEdit.Width;
end;

procedure TSelectEdit.SetWidthText(pValue: word);
begin
  oInfo.Width := pValue;
  SetSize; // Nastavi rozmer editora pdola jeho komponentov
end;

function TSelectEdit.GetWidthText: word;
begin
  Result := oInfo.Width;
end;

procedure TSelectEdit.MyKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
begin
//  SpecKeyDownHandle (Self,Key,Shift);
  If Key=vk_F7 then  ShowLst (Sender);
//  If (Key=vk_Return) and (Long=0) then  ShowLst (Sender);
  If Assigned (eOnKeyDown) then eOnKeyDown (Sender,Key,Shift);
end;

procedure TSelectEdit.MyOnEnter (Sender: TObject);
begin
  If oStatusLine<>nil then begin
    oStatusLine.TabPosition := TabOrder;
    oStatusLine.CursorPosition := 0;
    oStatusLine.Description := Hint;
  end;
  If Assigned (eOnEnter) then eOnEnter (Sender);
end;

procedure TSelectEdit.MyOnExit (Sender: TObject);
begin
  SearchData (Sender);
  If Assigned (eOnExit) then eOnExit (Sender);
end;

procedure TSelectEdit.SetSize; // Nastavi rozmer editora pdola jeho komponentov
begin
  If oInfo.Visible
    then Width := oEdit.Width+2+oInfo.Width+2+oButt.Width
    else Width := oEdit.Width+2+oButt.Width;
  oInfo.Left := oEdit.Width+2;
  RecreateWnd;
end;

procedure TSelectEdit.SearchData (Sender: TObject);
begin
end;

procedure TSelectEdit.ShowLst (Sender: TObject);
begin
end;

// ******************** Editor zoznamu skladov ********************
constructor TNwStkLstEdit.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  inherited OnEnter := MyOnEnter;
end;

procedure TNwStkLstEdit.SearchData (Sender: TObject);
var mMyOp:boolean;
begin
  Text := '';
  If (Long<>0) then begin
    If cNexStart then begin
      oEdit.Long := 1;
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
        oEdit.Long := oBefStkNum; // Ak sklad neexistuje nastavime hodnotu ktora bola pred zmenou
      end;
      If mMyOp then dmSTK.btSTKLST.Close;
    end;
  end;
end;

procedure TNwStkLstEdit.ShowLst (Sender: TObject);
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

procedure TNwStkLstEdit.MyOnEnter (Sender: TObject);
begin
  oBefStkNum := Long;
  If Assigned (eOnEnter) then eOnEnter (Sender);
end;

// *********************** Editor cennikov ***********************
procedure TNwPlsLstEdit.SearchData (Sender: TObject);
var mMyOp:boolean;
begin
  Text := '';
  If (Long<>0) then begin
    If cNexStart then begin
      oEdit.Long := 1;
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

procedure TNwPlsLstEdit.ShowLst (Sender: TObject);
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

// *********************** Editor akciovych cennikov ***********************
procedure TNwAplLstEdit.SearchData (Sender: TObject);
var mMyOp:boolean;
begin
  Text := '';
  If (Long<>0) then begin
    If cNexStart then begin
      oEdit.Long := 1;
      Text := 'Cennik';
    end else begin
      mMyOp := not dmSTK.btAPLLST.Active;
      If mMyOp then dmSTK.btAPLLST.Open;
      If dmSTK.btAPLLST.IndexName<>'AplNum' then dmSTK.btAPLLST.IndexName := 'AplNum';
      If dmSTK.btAPLLST.FindKey ([Long]) then begin
        Text := dmSTK.btAPLLST.FieldByname ('AplName').AsString;
        If Assigned (eOnChanged) then eOnChanged (Sender);
      end
      else ShowMsg (100015,StrInt(Long,0));
      If mMyOp then dmSTK.btAPLLST.Close;
    end;
  end;
end;

procedure TNwAplLstEdit.ShowLst (Sender: TObject);
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
    F_SysAplLstV := TF_SysAplLstV.Create (Self);
    F_SysAplLstV.ShowModal (cView);
    If F_SysAplLstV.Accept then begin
      Long := F_SysAplLstV.AplNum;
      Text := F_SysAplLstV.AplName;
      If Assigned (eOnChanged) then eOnChanged (Sender);
      mKey := vk_Return;
      SpecKeyDownHandle (Self,mKey,mShift);
    end;
    FreeAndNil (F_SysAplLstV);
  end;
end;

// *********************** Editor skladovych pohybov ***********************
procedure TNwSmLstEdit.SearchData (Sender: TObject);
var mMyOp:boolean;
begin
  Text := '';
  If (Long<>0) then begin
    mMyOp := not dmSTK.btSMLST.Active;
    If mMyOp then dmSTK.btSMLST.Open;
    If dmSTK.btSMLST.IndexName<>'SmCode' then dmSTK.btSMLST.IndexName := 'SmCode';
    If dmSTK.btSMLST.FindKey ([Long]) then begin
      Text := dmSTK.btSMLST.FieldByname ('SmName').AsString;
      If Assigned (eOnChanged) then eOnChanged (Sender);
    end
    else ShowMsg (100015,StrInt(Long,0));
    If mMyOp then dmSTK.btSMLST.Close;
  end;
end;

procedure TNwSmLstEdit.ShowLst (Sender: TObject);
var mKey:word; mShift: TShiftState;
begin
  SetFocus;
  F_StkSmLstV := TF_StkSmLstV.Create (Self);
  F_StkSmLstV.ShowModal (cView);
  If F_StkSmLstV.Accept then begin
    Long := F_StkSmLstV.SmCode;
    Text := F_StkSmLstV.SmName;
    If Assigned (eOnChanged) then eOnChanged (Sender);
    mKey := vk_Return;
    SpecKeyDownHandle (Self,mKey,mShift);
  end;
  FreeAndNil (F_StkSmLstV);
end;

// *********************** Editor obchodnych zastupcov ***********************
procedure TNwDlrLstEdit.SearchData (Sender: TObject);
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
    else ShowMsg (100015,StrInt(Long,0));
    If mMyOp then dmDLS.btDLRLST.Close;
  end;
end;

procedure TNwDlrLstEdit.ShowLst (Sender: TObject);
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

// *********************** Editor skupin ***********************
constructor TGrpEdi.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  inherited OnEnter := MyOnEnter;
  inherited OnExit := MyOnExit;
  inherited OnResize := MyOnResize;
  Width := 320;
  Height := 18;
  oStatusLine := nil;

  oGrpNum := TXpEdit.Create (Self);
  oGrpNum.Parent := Self;
  oGrpNum.Width := 50;
  oGrpNum.MaxLength := 5;
  oGrpNum.NumSepar := FALSE;
  oGrpNum.OnKeyDown := MyKeyDown;
  oGrpNum.OnModified := MyOnModified;

  oGrpName := TXpEdit.Create (Self);
  oGrpName.Parent := Self;
  oGrpName.Left := oGrpNum.Width+1;
  oGrpName.Width := 250;
  oGrpName.InfoField := TRUE;
  oGrpName.Text := '';

  oGrpLst := TSpecSpeedButton.Create (Self);
  oGrpLst.Parent := Self;
  oGrpLst.Width := 18;
  oGrpLst.Height := 18;
  oGrpLst.Align := alRight;
  oGrpLst.ButtonType := btNwSelect;
  oGrpLst.NumGlyphs := 2;
  oGrpLst.OnClick := ShowList;
end;

destructor TGrpEdi.Destroy;
begin
  FreeAndNil (oGrpNum);
  FreeAndNil (oGrpName);
  FreeAndNil (oGrpLst);
  inherited;
end;

procedure TGrpEdi.SetFocus;
begin
  oGrpNum.SetFocus;
end;

procedure TGrpEdi.CreateWnd;
begin
  inherited CreateWnd;
  oGrpNum.EditorType := etInteger;
end;

procedure TGrpEdi.SetGrpNum(pValue:word);
begin
  oGrpNum.AsInteger := pValue;
  SrchData (Self);
end;

function TGrpEdi.GetGrpNum:word;
begin
  Result := oGrpNum.AsInteger;
end;

procedure TGrpEdi.SetGrpName(pValue:Str30);
begin
  oGrpName.AsString := pValue
end;

function TGrpEdi.GetGrpName:Str30;
begin
  Result := oGrpName.AsString;
end;

procedure TGrpEdi.SetInfoField (AValue:boolean);
begin
  oGrpNum.InfoField := AValue;
  oGrpLst.Visible := not AValue;
end;

function  TGrpEdi.GetInfoField:boolean;
begin
  Result := oGrpNum.InfoField;
end;

procedure TGrpEdi.SetEnabled (AValue:boolean);
begin
  oGrpNum.Enabled := AValue;
  oGrpName.Enabled := AValue;
  oGrpLst.Enabled := AValue;
end;

function  TGrpEdi.GetEnabled:boolean;
begin
  Result := oGrpNum.Enabled
end;

procedure TGrpEdi.MyKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
begin
  If Key=vk_F7 then  ShowList (Sender);
  If (Key=vk_Return) and (GrpNum=0) then  ShowList (Sender);
  If Assigned (eOnKeyDown) then eOnKeyDown (Sender,Key,Shift);
end;

procedure TGrpEdi.MyOnEnter (Sender: TObject);
begin
  If oStatusLine<>nil then begin
    oStatusLine.TabPosition := TabOrder;
    oStatusLine.CursorPosition := 0;
    oStatusLine.Description := Hint;
  end;
  If Assigned (eOnEnter) then eOnEnter (Sender);
end;

procedure TGrpEdi.MyOnExit (Sender: TObject);
begin
  SrchData (Sender);
  If Assigned (eOnExit) then eOnExit (Sender);
end;

procedure TGrpEdi.MyOnResize (Sender:TObject);
begin
  oGrpName.Width := Width-oGrpNum.Width-oGrpLst.Width-2;
end;

procedure TGrpEdi.MyOnModified (Sender:TObject);
begin
  If Assigned (eOnModified) then eOnModified (Sender);
end;

procedure TGrpEdi.SrchData (Sender: TObject);
var mhGRPLST:TGRPLSTHnd;
begin
  oGrpName.AsString := '';
  If oGrpNum.AsInteger<>0 then begin
    mhGRPLST := TGRPLSTHnd.Create;  mhGRPLST.Open;
    If mhGRPLST.LocateGtGn(oGrpTyp,oGrpNum.AsInteger)  then begin
      oGrpName.AsString := mhGRPLST.GrpName;
      If Assigned (eOnChanged) then eOnChanged (Sender);
    end
    else ShowMsg (100015,StrInt(oGrpNum.AsInteger,0));
    FreeAndNil(mhGRPLST);
  end;
end;

procedure TGrpEdi.ShowList (Sender: TObject);
var mModified:boolean; mKey:word; mShift:TShiftState; mGRPLST:TSysGRPLSTF;
begin
  SetFocus;
  mGRPLST := TSysGRPLSTF.Create(Self);
  mGRPLST.Execute(oGrpTyp);
  If mGRPLST.Accept then begin
    mModified := oGrpNum.AsInteger<>mGRPLST.GrpNum;
    oGrpNum.AsInteger := mGRPLST.GrpNum;
    oGrpName.AsString := mGRPLST.GrpName;
    If mModified then MyOnModified (Self);
    mKey := vk_Return;
    SpecKeyDownHandle (Self,mKey,mShift);
  end;
  FreeAndNil (mGRPLST);
end;

// *********************** Editor pre vsetky zoznamy ***********************
procedure TNwLstEdit.SearchData (Sender: TObject);
var mMyOp:boolean;  mhEPCLST:TEpclstHnd;  mhEPGLST:TEpglstHnd;
begin
  Text := '';
  If (Long<>0) then begin
    case oLstType of
      ltGsl: begin // Zoznam tovarov z bazovej evidencie
               mMyOp := not dmSTK.btGSCAT.Active;
               If mMyOp then dmSTK.btGSCAT.Open;
               If dmSTK.btGSCAT.IndexName<>'GsCode' then dmSTK.btGSCAT.IndexName := 'GsCode';
               If dmSTK.btGSCAT.FindKey ([Long]) then begin
                 Text := dmSTK.btGSCAT.FieldByname ('GsName').AsString;
                 If Assigned (eOnChanged) then eOnChanged (Sender);
               end
               else ShowMsg (110702,StrInt(Long,0));
               If mMyOp then dmSTK.btGSCAT.Close;
             end;
      ltMgl: begin // Zoznam tovarovych skupin
               mMyOp := not dmSTK.btMGLST.Active;
               If mMyOp then dmSTK.btMGLST.Open;
               If dmSTK.btMGLST.IndexName<>'MgCode' then dmSTK.btMGLST.IndexName := 'MgCode';
               If dmSTK.btMGLST.FindKey ([Long]) then begin
                 Text := dmSTK.btMGLST.FieldByname ('MgName').AsString;
                 If Assigned (eOnChanged) then eOnChanged (Sender);
               end
               else ShowMsg (100015,StrInt(Long,0));
               If mMyOp then dmSTK.btMGLST.Close;
             end;
      ltFgl: begin // Zoznam financnych skupin
               mMyOp := not dmSTK.btFGLST.Active;
               If mMyOp then dmSTK.btFGLST.Open;
               If dmSTK.btFGLST.IndexName<>'FgCode' then dmSTK.btFGLST.IndexName := 'FgCode';
               If dmSTK.btFGLST.FindKey ([Long]) then begin
                 Text := dmSTK.btFGLST.FieldByname ('FgName').AsString;
                 If Assigned (eOnChanged) then eOnChanged (Sender);
               end
               else ShowMsg (100015,StrInt(Long,0));
               If mMyOp then dmSTK.btFGLST.Close;
             end;
      ltSml: begin // Zoznam skladovych pohybov
               mMyOp := not dmSTK.btSMLST.Active;
               If mMyOp then dmSTK.btSMLST.Open;
               If dmSTK.btSMLST.IndexName<>'SmCode' then dmSTK.btSMLST.IndexName := 'SmCode';
               If dmSTK.btSMLST.FindKey ([Long]) then begin
                 Text := dmSTK.btSMLST.FieldByname ('SmName').AsString;
                 If Assigned (eOnChanged) then eOnChanged (Sender);
               end
               else ShowMsg (100015,StrInt(Long,0));
               If mMyOp then dmSTK.btSMLST.Close;
             end;
      ltPls: begin // Zoznam predajnych cennikov
               If cNexStart then begin
                 oEdit.Long := 1;
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
      ltApl: begin  // Zoznam akciovych cennikov
               If cNexStart then begin
                 oEdit.Long := 1;
                 Text := 'Cennik';
               end else begin
                 mMyOp := not dmSTK.btAPLLST.Active;
                 If mMyOp then dmSTK.btAPLLST.Open;
                 If dmSTK.btAPLLST.IndexName<>'AplNum' then dmSTK.btAPLLST.IndexName := 'AplNum';
                 If dmSTK.btAPLLST.FindKey ([Long]) then begin
                   Text := dmSTK.btAPLLST.FieldByname ('AplName').AsString;
                   If Assigned (eOnChanged) then eOnChanged (Sender);
                 end
                 else ShowMsg (100015,StrInt(Long,0));
                 If mMyOp then dmSTK.btAPLLST.Close;
               end;
             end;
      ltStk: begin // Zoznam tovarovych skladov
               If cNexStart then begin
                 oEdit.Long := 1;
                 Text := 'Sklad';
               end else begin
                 mMyOp := not dmSTK.btSTKLST.Active;
                 If mMyOp then dmSTK.btSTKLST.Open;
                 If dmSTK.btSTKLST.IndexName<>'StkNum' then dmSTK.btSTKLST.IndexName := 'StkNum';
                 If dmSTK.btSTKLST.FindKey ([Long]) then begin
                   Text := dmSTK.btSTKLST.FieldByname ('StkName').AsString;
                   If Assigned (eOnChanged) then eOnChanged (Sender);
                 end
                 else ShowMsg (100015,StrInt(Long,0));
                 If mMyOp then dmSTK.btSTKLST.Close;
               end;
             end;
      ltWri: begin // Zoznam prevadzkovych jednotiek
               mMyOp := not dmDLS.btWRILST.Active;
               If mMyOp then dmDLS.btWRILST.Open;
               If dmDLS.btWRILST.IndexName<>'WriNum' then dmDLS.btWRILST.IndexName := 'WriNum';
               If dmDLS.btWRILST.FindKey ([Long]) then begin
                 Text := dmDLS.btWRILST.FieldByname ('WriName').AsString;
                 If Assigned (eOnChanged) then eOnChanged (Sender);
               end
               else ShowMsg (100015,StrInt(Long,0));
               If mMyOp then dmDLS.btWRILST.Close;
             end;
      ltPab: begin // Zoznam knih partnerov
             end;
      ltPal: begin // Zoznam ocbhodnych partnerov
               mMyOp := not dmDLS.btPAB.Active;
               If dmDLS.btPAB.TableName='PAB' then dmDLS.btPAB.TableName:='PAB00000';
               If mMyOp then dmDLS.OpenPab(0);
               If dmDLS.btPAB.IndexName<>'PaCode' then dmDLS.btPAB.IndexName := 'PaCode';
               If dmDLS.btPAB.FindKey ([Long]) then begin
                 Text := dmDLS.btPAB.FieldByname ('PaName').AsString;
                 If Assigned (eOnChanged) then eOnChanged (Sender);
               end
               else ShowMsg (100015,StrInt(Long,0));
               If mMyOp then dmDLS.btPAB.Close;
             end;
      ltWpa: begin // Zoznam ocbhodnych partnerov
             end;
      ltDlr: begin // Zoznam obchodnych zastupcov
               mMyOp := not dmDLS.btDLRLST.Active;
               If mMyOp then dmDLS.btDLRLST.Open;
               If dmDLS.btDLRLST.IndexName<>'DlrCode' then dmDLS.btDLRLST.IndexName := 'DlrCode';
               If dmDLS.btDLRLST.FindKey ([Long]) then begin
                 Text := dmDLS.btDLRLST.FieldByname ('DlrName').AsString;
                 If Assigned (eOnChanged) then eOnChanged (Sender);
               end
               else ShowMsg (100015,StrInt(Long,0));
               If mMyOp then dmDLS.btDLRLST.Close;
             end;
      ltEpc: begin // Zoznam zamestnancov
               mhEPCLST := TEpclstHnd.Create;  mhEPCLST.Open;
               If mhEPCLST.LocateEpcNum(Long)
                 then Text := mhEPCLST.EpcName
                 else ShowMsg (100015,StrInt(Long,0));
               FreeAndNil(mhEPCLST);
             end;
      ltEpg: begin // Zoznam zamestnancov
               mhEPGLST := TEpglstHnd.Create;  mhEPGLST.Open;
               If mhEPGLST.LocateEpgNum(Long)
                 then Text := mhEPGLST.EpgName
                 else ShowMsg (100015,StrInt(Long,0));
               FreeAndNil(mhEPGLST);
             end;
      ltRef: begin // Zoznam obchodnych referencii
               mMyOp := not dmDLS.btREFLST.Active;
               If mMyOp then dmDLS.btREFLST.Open;
               If dmDLS.btREFLST.IndexName<>'RefCode' then dmDLS.btREFLST.IndexName := 'RefCode';
               If dmDLS.btREFLST.FindKey ([Long]) then begin
                 Text := dmDLS.btREFLST.FieldByname ('RefName').AsString;
                 If Assigned (eOnChanged) then eOnChanged (Sender);
               end
               else ShowMsg (100015,StrInt(Long,0));
               If mMyOp then dmDLS.btREFLST.Close;
             end;
      ltDrv: begin // Zoznam obchodnych referencii
               mMyOp := not dmDLS.btDRVLST.Active;
               If mMyOp then dmDLS.btDRVLST.Open;
               If dmDLS.btDRVLST.IndexName<>'DrvCode' then dmDLS.btDRVLST.IndexName := 'DrvCode';
               If dmDLS.btDRVLST.FindKey ([Long]) then begin
                 Text := dmDLS.btDRVLST.FieldByname ('DrvName').AsString;
                 If Assigned (eOnChanged) then eOnChanged (Sender);
               end
               else ShowMsg (100015,StrInt(Long,0));
               If mMyOp then dmDLS.btDRVLST.Close;
             end;
      ltCnt: begin // Zoznam hospodarskych stredisk
               mMyOp := not dmDLS.btCNTLST.Active;
               If mMyOp then dmDLS.btCNTLST.Open;
               If dmDLS.btCNTLST.IndexName<>'CntNum' then dmDLS.btCNTLST.IndexName := 'CntNum';
               If dmDLS.btCNTLST.FindKey ([Long]) then begin
                 Text := dmDLS.btCNTLST.FieldByname ('CntName').AsString;
                 If Assigned (eOnChanged) then eOnChanged (Sender);
               end
               else ShowMsg (100015,StrInt(Long,0));
               If mMyOp then dmDLS.btCNTLST.Close;
             end;
    end;
  end;
end;

procedure TNwLstEdit.ShowLst (Sender: TObject);
var mKey:word; mShift: TShiftState;  mMyOp:boolean;  mEpcLst:TSysEpcLstV;  mEpgLst:TSysEpgLstV;
begin
  SetFocus;
  case oLstType of
    ltGsl: begin // Zoznam tovarov z bazovej evidencie
               mMyOp := not dmSTK.btGSCAT.Active;
               If mMyOp then dmSTK.btGSCAT.Open;
                 F_GscGsLstV := TF_GscGsLstV.Create (Self);
                 F_GscGsLstV.SetBase(cGsc);
                 F_GscGsLstV.ShowGsLst;
                 If F_GscGsLstV.Accept then begin
                   Long := F_GscGsLstV.GsCode;
                   Text := F_GscGsLstV.GsName;
                   If Assigned (eOnChanged) then eOnChanged (Sender);
                   mKey := vk_Return;
                   SpecKeyDownHandle (Self,mKey,mShift);
                 end;
                 FreeAndNil (F_GscGsLstV);
               If mMyOp then dmSTK.btGSCAT.Close;
           end;
    ltMgl: begin // Zoznam tovarovych skupin
             F_GscMgLstV := TF_GscMgLstV.Create (Self);
             F_GscMgLstV.ShowModal (cView);
             If F_GscMgLstV.Accept then begin
               Long := F_GscMgLstV.MgCode;
               Text := F_GscMgLstV.MgName;
               If Assigned (eOnChanged) then eOnChanged (Sender);
               mKey := vk_Return;
               SpecKeyDownHandle (Self,mKey,mShift);
             end;
             FreeAndNil (F_GscMgLstV);
           end;
    ltFgl: begin // Zoznam financnych skupin
             F_GscFgLstV := TF_GscFgLstV.Create (Self);
             F_GscFgLstV.ShowModal (cView);
             If F_GscFgLstV.Accept then begin
               Long := F_GscFgLstV.FgCode;
               Text := F_GscFgLstV.FgName;
               If Assigned (eOnChanged) then eOnChanged (Sender);
               mKey := vk_Return;
               SpecKeyDownHandle (Self,mKey,mShift);
             end;
             FreeAndNil (F_GscFgLstV);
           end;
    ltSml: begin // Zoznam skladovych pohybov
             F_StkSmLstV := TF_StkSmLstV.Create (Self);
             F_StkSmLstV.ShowModal (cView);
             If F_StkSmLstV.Accept then begin
               Long := F_StkSmLstV.SmCode;
               Text := F_StkSmLstV.SmName;
               If Assigned (eOnChanged) then eOnChanged (Sender);
               mKey := vk_Return;
               SpecKeyDownHandle (Self,mKey,mShift);
             end;
             FreeAndNil (F_StkSmLstV);
           end;
    ltPls: begin // Zoznam predajnych cennikov
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
    ltApl: begin  // Zoznam akciovych cennikov
             If cNexStart then begin
               Long:=1;
               Text:='Cennik';
               If Assigned (eOnChanged) then eOnChanged (Sender);
               mKey := vk_Return;
               SpecKeyDownHandle (Self,mKey,mShift);
             end else begin
               F_SysAplLstV := TF_SysAplLstV.Create (Self);
               F_SysAplLstV.ShowModal (cView);
               If F_SysAplLstV.Accept then begin
                 Long := F_SysAplLstV.AplNum;
                 Text := F_SysAplLstV.AplName;
                 If Assigned (eOnChanged) then eOnChanged (Sender);
                 mKey := vk_Return;
                SpecKeyDownHandle (Self,mKey,mShift);
               end;
               FreeAndNil (F_SysAplLstV);
             end;
           end;
    ltStk: begin // Zoznam tovarovych skladov
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
    ltWri: begin // Zoznam prevadzkovych jednotiek
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
    ltPab: begin // Zoznam knih partnerov
           end;
    ltPal: begin // Zoznam ocbhodnych partnerov
               mMyOp := not dmDLS.btPAB.Active;
               If mMyOp then dmDLS.OpenPab(0);
                 F_PabPacLstV := TF_PabPacLstV.Create (Self);
                 F_PabPacLstV.ShowModal (cView);
                 If F_PabPacLstV.Accept then begin
                   Long := F_PabPacLstV.PaCode;
                   Text := F_PabPacLstV.PaName;
                   If Assigned (eOnChanged) then eOnChanged (Sender);
                   mKey := vk_Return;
                   SpecKeyDownHandle (Self,mKey,mShift);
                 end;
                 FreeAndNil (F_PabPacLstV);
               If mMyOp then dmDLS.btPAB.Close;
           end;
    ltDlr: begin // Zoznam obchodnych zastupcov
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
    ltEpc: begin // Zoznam zamestnancov
             mEpcLst := TSysEpcLstV.Create(Self);
             mEpcLst.Execute(cView);
             If mEpcLst.Accept then begin
               Long := mEpcLst.EpcNum;
               Text := mEpcLst.EpcName;
               If Assigned (eOnChanged) then eOnChanged (Sender);
               mKey := vk_Return;
               SpecKeyDownHandle (Self,mKey,mShift);
             end;
             FreeAndNil (mEpcLst);
           end;
    ltEpg: begin // Zoznam zamestnaneckých skupin
             mEpgLst := TSysEpgLstV.Create(Self);
             mEpgLst.Execute(cView);
             If mEpgLst.Accept then begin
               Long := mEpgLst.EpgNum;
               Text := mEpgLst.EpgName;
               If Assigned (eOnChanged) then eOnChanged (Sender);
               mKey := vk_Return;
               SpecKeyDownHandle (Self,mKey,mShift);
             end;
             FreeAndNil (mEpgLst);
           end;
    ltRef: begin // Zoznam obchodnych referencii
             F_SysRefLstV := TF_SysRefLstV.Create (Self);
             F_SysRefLstV.ShowModal (cView);
             If F_SysRefLstV.Accept then begin
               Long := F_SysRefLstV.RefCode;
               Text := F_SysRefLstV.RefName;
               If Assigned (eOnChanged) then eOnChanged (Sender);
               mKey := vk_Return;
               SpecKeyDownHandle (Self,mKey,mShift);
             end;
             FreeAndNil (F_SysRefLstV);
           end;
    ltDrv: begin // Zoznam vodicov sluzobnych vozidiel
             F_SysDrvLstV := TF_SysDrvLstV.Create (Self);
             F_SysDrvLstV.ShowModal (cView);
             If F_SysDrvLstV.Accept then begin
               Long := F_SysDrvLstV.DrvCode;
               Text := F_SysDrvLstV.DrvName;
               If Assigned (eOnChanged) then eOnChanged (Sender);
               mKey := vk_Return;
               SpecKeyDownHandle (Self,mKey,mShift);
             end;
             FreeAndNil (F_SysDrvLstV);
           end;
    ltCnt: begin // Zoznam prevadzkovych jednotiek
             F_SysCntLstV := TF_SysCntLstV.Create (Self);
             F_SysCntLstV.ShowModal (cView);
             If F_SysCntLstV.Accept then begin
               Long := F_SysCntLstV.CntNum;
               Text := F_SysCntLstV.CntName;
               If Assigned (eOnChanged) then eOnChanged (Sender);
               mKey := vk_Return;
               SpecKeyDownHandle (Self,mKey,mShift);
             end;
             FreeAndNil (F_SysCntLstV);
           end;
    ltWpa: begin
           end;
  end;
end;

// ********************** Register ************************
procedure Register;
begin
  RegisterComponents('NwSelectEdit', [TNwStkLstEdit]);
  RegisterComponents('NwSelectEdit', [TNwPlsLstEdit]);
  RegisterComponents('NwSelectEdit', [TNwAplLstEdit]);
  RegisterComponents('NwSelectEdit', [TNwSmLstEdit]);
  RegisterComponents('NwSelectEdit', [TNwDlrLstEdit]);
  RegisterComponents('NwSelectEdit', [TNwLstEdit]);
  // Nove editory
  RegisterComponents('NwSelectEdit', [TBokEdi]);
  RegisterComponents('NwSelectEdit', [TLstEdi]);
  RegisterComponents('NwSelectEdit', [TCtyEdi]);
  RegisterComponents('NwSelectEdit', [TStaEdi]);
  RegisterComponents('NwSelectEdit', [TAccEdi]);
  RegisterComponents('NwSelectEdit', [TGrpEdi]);
end;

end.
{MOD 1804001}
{MOD 1807015}
