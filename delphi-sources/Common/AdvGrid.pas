unit AdvGrid;

interface

uses
  BaseUtils,
  BtrTable,
  IcConv, IcTools, IcVariab, TxtWrap, DefRgh,
  AdvGrid_GridDG, AdvGrid_GrActSet, AdvGrid_GridSet, AdvGrid_InfCol,
  MarkGrid, CompTxt,

  DBSrGrid,
  FileCtrl, IniFiles, DBGrids, StdCtrls, Extctrls, Tabs, Menus, DB, DBTables,
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs;

type
  TTabSetChanged = procedure (Sender:TObject; pTabSetName:ShortString) of object;
  TRowColors = array[1..10] of longint;


  TAdvGrid = class(TCustomPanel)
    oDBSrGrid: TDBSrchGrid;
    oHead    : TLabel;
    oBPanel  : TPanel;
  private
    oColorGrp : string;
    oColorType: byte;
    oRowColors: TRowColors;
    oEnableMultiSelect:boolean;
    oRecQnt  : TLabel;
    oPanel   : TPanel;
    oTabSet  : TTabSet;
    oToolBarHeight: integer;
    oShowRecNo  : boolean;
    oSetPath    : string;
    oDGDPath    : string;
    oDGDName    : string;
    oLoginName  : string;
    oDefIndex   : string;
    oGridChange : boolean;
    oOnlyUserSet: boolean;
    oServiceMode: boolean;
    oGDChange   : boolean;
    oTabPopup   : TPopupMenu;
    oGridModify : boolean;
    oTabStop    : boolean;
    oSearchLnClear: boolean;
    oEnabledReadActSet:boolean;
    oGridSet    : TGridSet;
    oLastOpenWin: string;
    oColorRow   : TColor;
    oSelRecQnt  : longint;


    eOnChangeIndex: TNotifyEvent;
    eOnColEnter   : TNotifyEvent;
    eOnColExit    : TNotifyEvent;
    eOnCRPressed  : TNotifyEvent;
    eOnCtrlDelPressed: TNotifyEvent;
    eOnDataChange : TDataChangeEvent;
    eOnDelPressed : TNotifyEvent;
    eOnEscPressed : TNotifyEvent;
    eOnF3Pressed  : TNotifyEvent;
    eOnF7Pressed  : TNotifyEvent;
    eOnInsPressed : TNotifyEvent;
    eOnCtrlInsPressed : TNotifyEvent;
    eOnModPressed : TNotifyEvent;
    eOnKeyDown    : TKeyEvent;
    eOnSelected   : TNotifyEvent;
    eOnDrawColorRow: TDrawColorRowEvent;
    eOnFocusedCHange: TNotifyEvent;
    eOnTabSetChanged: TTabSetChanged;
    eOnWriteCelText: TWriteCelText;
    

    procedure SetPositions;
    procedure ShowRecordCount;
    procedure LoadDefGrid;
    procedure LoadGridSet (pSetNum:string);
    procedure WriteActGrid;
    procedure SetTabs (pActSet:string);
    function  ConvStrToBookmark (pStr:string):string;
    function  ConvBookmarkToStr (pStr:string):string;
    procedure SetShortCutTabSet (var Key: Word; Shift: TShiftState);
    procedure FillTabSet (pTabIndex:integer);
    function  GetFieldIndex (pFld:string):integer;
    procedure VerifyDefGridSet;

    procedure SetGridFont (Value:TFont);
    function  GetGridFont:TFont;
    function  GetDataSet:TDataSet;
    procedure SetDataSet (Value:TDataSet);
    function  GetHead:string;
    procedure SetHead (Value:string);
    function  GetHeadFont:TFont;
    procedure SetHeadFont (Value:TFont);
    procedure SetToolBarHeight (Value:integer);
    procedure SetShowRecNo (Value:boolean);
    procedure SetSetPath (Value:string);
    procedure SetDGDPath (Value:string);
    procedure SetDGDName (Value:string);
    procedure SetLoginName (Value:string);
    procedure SetOnlyUserSet (Value:boolean);
    procedure SetServiceMode (Value:boolean);
    procedure SetGDChange (Value:boolean);
    function  GetTabSet:integer;
    procedure SetTabSet (Value:integer);
    procedure SetGridModify (Value:boolean);
    procedure SetTabStop (Value:boolean);
    procedure SetSearchLnClear (Value:boolean);

    procedure DeleteGridSet (Sender:TObject);
    procedure ModifyGridSet (Sender:TObject);
    procedure SaveGridSet (Sender:TObject);
    procedure ColorInfo (Sender:TObject);

    function  GetSearchLnFocused: boolean;
    procedure SetSearchLnFocused (Value:boolean);

    procedure MyHeadFontChange (Sender: TObject);
//    procedure MyDataSourceDataChange (Sender: TObject; Field: TField);
    procedure MyTabSetOnChange (Sender: TObject; NewTab: Integer; var AllowChange: Boolean);
    procedure MyDataSetAfterOpen (DataSet: TDataSet);
    procedure MyDataSetBeforeClose (DataSet: TDataSet);
    procedure MyOnMouseUp (Sender: TObject; Button: TMouseButton ; Shift: TShiftState; X, Y: Integer);
    procedure MyOnEnter (Sender: TObject);
    procedure MyTabsPopup (Sender: TObject);

    procedure MyDBSrGridOnChangeIndex (Sender: TObject);
    procedure MyDBSrGridOnColEnter (Sender: TObject);
    procedure MyDBSrGridOnColExit (Sender: TObject);
    procedure MyDBSrGridOnCRPressed (Sender: TObject);
    procedure MyDBSrGridOnCtrlDelPressed (Sender: TObject);
    procedure MyDBSrGridOnDataChange (Sender: TObject; Field: TField);
    procedure MyDBSrGridOnDelPressed (Sender: TObject);
    procedure MyDBSrGridOnEscPressed (Sender: TObject);
    procedure MyDBSrGridOnF3Pressed (Sender: TObject);
    procedure MyDBSrGridOnF7Pressed (Sender: TObject);
    procedure MyDBSrGridOnInsPressed (Sender: TObject);
    procedure MyDBSrGridOnCtrlInsPressed (Sender: TObject);
    procedure MyDBSrGridOnModPressed (Sender: TObject);
    procedure MyDBSrGridOnKeyDown (Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure MyDBSrGridOnSelected (Sender: TObject);
    procedure MyDBSrGridOnSrchKeyDown (Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure MyDBSrGridOnFocusedChange (Sender: TObject);
    procedure MyWriteCelText (pField:TField;var pText:string);

    procedure MyDBSrGridOnGridChange (Sender: TObject);
    procedure MyOnDrawColorRow (Sender:TObject;var pColorRow:TColor; pField:TField;pFirstFld:boolean);
    procedure MyOnSelChange (Sender: TObject;pSelRecQnt:longint);

    function  GetReadOnly:boolean;
    procedure SetReadOnly (Value:boolean);
    function  GetEnabled:boolean;
    procedure SetEnabled (Value:boolean);
    function  GetMultiSelect:boolean;
    procedure SetMultiSelect (Value:boolean);
    function  GetPopup:TPopupMenu;
    procedure SetPopup (Value:TPopupMenu);
    function  GetMarkData:TMarkData;
    procedure SetMarkData (Value:TMarkData);
    function  GetIndexColor:TIndexColor;
    procedure SetIndexColor (Value:TIndexColor);
    function  GetFixIndexFields:string;
    procedure SetFixIndexFields (Value:string);
    function  GetActIndexFields:string;
    procedure SetActIndexFields (Value:string);
    function  GetActIndexDispText:string;
    procedure SetActIndexDispText (Value:string);

    function  GetEnableMultiSelect:boolean;
    procedure SetEnableMultiSelect (pValue:boolean);

    function  GetBevelOuter:TBevelCut;
    procedure SetBevelOuter (Value:TBevelCut);
    function  GetBevelInner:TBevelCut;
    procedure SetBevelInner (Value:TBevelCut);
    function  GetBorderWidth:integer;
    procedure SetBorderWidth (Value:integer);
    function  GetBevelWidth:integer;
    procedure SetBevelWidth (Value:integer);

    function  GetImageParams: String;
    procedure SetImageParams (Value:String);
    function GetFixSrchField: string;
    procedure SetFixSrchField(const Value: string);

    { Private declarations }
  protected
    { Protected declarations }
  public
    oSavePos : boolean;
    oSelTable: TTable;
    constructor Create(AOwner: TComponent); override;
    destructor  Destroy; override;

    procedure SetSelTableParam (pTable:TTable);
    procedure SetFocus;
    function  GetActDGDName:string;
    procedure ClearSrchData;

    procedure Loaded; override;
    procedure MyOnResize (Sender: TObject); virtual;
    procedure WriteActSettings;
    procedure ReadActSettings;

    procedure  SetDBPos (pPos:string);
    function   GetDBPos:string;

    procedure  RowCnd (pType,pColorIndex:byte;pCnd:boolean;var pColor:TColor);

    property   RowColors:TRowColors read oRowColors write oRowColors;
    property   ColorType:byte read oColorType write oColorType;
  published
    property ImageParams:String read GetImageParams write SetImageParams;
    property Anchors;
    property GridFont:TFont read GetGridFont write SetGridFont;
    property BorderStyle;
    property Align;
    property TabStop:boolean read oTabStop write SetTabStop;
    property SearchLnClear:boolean read oSearchLnClear write SetSearchLnClear;
    property TabOrder;

    property EnableMultiSelect:boolean read GetEnableMultiSelect write SetEnableMultiSelect;

    property BevelOuter: TBevelCut read GetBevelOuter write SetBevelOuter;
    property BevelInner: TBevelCut read GetBevelInner write SetBevelInner;
    property BorderWidth: integer read GetBorderWidth write SetBorderWidth;
    property BevelWidth: integer read GetBevelWidth write SetBevelWidth;

    property DataSet:TDataSet read GetDataSet write SetDataSet;
    property Head:string read GetHead write SetHead;
    property HeadFont:TFont read GetHeadFont write SetHeadFont;
    property ToolBarHeight:integer read oToolBarHeight write SetToolBarHeight;
    property ShowRecNo:boolean read oShowRecNo write SetShowRecNo;
    property SetPath:string read oSetPath write SetSetPath;
    property DGDPath:string read oDGDPath write SetDGDPath;
    property DGDName:string read oDGDName write SetDGDName;
    property LoginName:string read oLoginName write SetLoginName;
    property ShowOnlyUserSet:boolean read oOnlyUserSet write SetOnlyUserSet;
    property ServiceMode:boolean read oServiceMode write SetServiceMode;
    property GDChange:boolean read oGDChange write SetGDChange;
    property TabSet:integer read GetTabSet write SetTabSet;
    property GridModify:boolean read oGridModify write SetGridModify;

    property ReadOnly:boolean read GetReadOnly write SetReadOnly;
    property Enabled:boolean read GetEnabled write SetEnabled;
    property MultiSelect:boolean read GetMultiSelect write SetMultiSelect;
    property PopupMenu:TPopupMenu read GetPopup write SetPopup;
    property MarkData:TMarkData read GetMarkData write SetMarkData;
    property IndexColor:TIndexColor read GetIndexColor write SetIndexColor;
    property FixIndexFields:string read GetFixIndexFields write SetFixIndexFields;
    property ActIndexFields:string read GetActIndexFields write SetActIndexFields;
    property ActIndexDispText:string read GetActIndexDispText write SetActIndexDispText;
    property SearchLnFocused: boolean read GetSearchLnFocused write SetSearchLnFocused;
    property EnabledReadActSet:boolean read oEnabledReadActSet write oEnabledReadActSet;

    property OnChangeIndex:TNotifyEvent read eOnChangeIndex write eOnChangeIndex;
    property OnColEnter: TNotifyEvent read eOnColEnter write eOnColEnter;
    property OnColExit: TNotifyEvent read eOnColExit write eOnColExit;
    property OnCRPressed: TNotifyEvent read eOnCRPressed write eOnCRPressed;
    property OnCtrlDelPressed: TNotifyEvent read eOnCtrlDelPressed write eOnCtrlDelPressed;
    property OnDataChange:TDataChangeEvent read eOnDataChange write eOnDataChange;
    property OnDelPressed: TNotifyEvent read eOnDelPressed write eOnDelPressed;
    property OnEscPressed: TNotifyEvent read eOnEscPressed write eOnEscPressed;
    property OnF3Pressed: TNotifyEvent read eOnF3Pressed write eOnF3Pressed;
    property OnF7Pressed: TNotifyEvent read eOnF7Pressed write eOnF7Pressed;
    property OnInsPressed: TNotifyEvent read eOnInsPressed write eOnInsPressed;
    property OnCtrlInsPressed: TNotifyEvent read eOnCtrlInsPressed write eOnCtrlInsPressed;
    property OnModPressed: TNotifyEvent read eOnModPressed write eOnModPressed;
    property OnKeyDown:TKeyEvent read eOnKeyDown write eOnKeyDown;
    property OnSelected: TNotifyEvent read eOnSelected write eOnSelected;
    property OnDrawColorRow:TDrawColorRowEvent read eOnDrawColorRow write eOnDrawColorRow;
    property OnWriteCelText:TWriteCelText read eOnWriteCelText write eOnWriteCelText;
    property OnFocusedChange: TNotifyEvent read eOnFocusedChange write eOnFocusedChange;
    property OnTabSetChanged: TTabSetChanged read eOnTabSetChanged write eOnTabSetChanged;
    property OnClick;
    property OnEnter;
    property FixSrchField:string read GetFixSrchField write SetFixSrchField;
  end;

procedure Register;

implementation

procedure Register;
begin
  RegisterComponents('Wirt', [TAdvGrid]);
end;

constructor TAdvGrid.Create(AOwner: TComponent);
var I:longint;
begin
  inherited Create (AOwner);
  inherited TabStop:=FALSE;
  Width      :=320;
  Height     :=163;
  BorderStyle:=bsSingle;
  OnResize :=MyOnResize;
  OnEnter  :=MyOnEnter;

  Font.Name:='Arial';
  Color:=clIccPanelBG;
  EnabledReadActSet:=TRUE;
  oEnableMultiSelect:=FALSE;
  oSelRecQnt:=0;

  oGridSet:=TGridSet.Create;

  oHead:= TLabel.Create (Self);
  oHead.Parent:=Self;
  oHead.AutoSize:=FALSE;
  oHead.Alignment:=taCenter;
//  oHead.Color:=clBlue;
  oHead.Color:=$00FF5E5E;
  oHead.Font.Size:=12;
  oHead.Font.Name:='Times New Roman';
  oHead.Font.Color:=clWhite;
  oHead.Font.Style:=[fsBold];
  oHead.Font.OnChange:=MyHeadFontChange;
  oHead.OnMouseUp:=MyOnMouseUp;

  oSearchLnClear:=TRUE;
  oDBSrGrid:=TDBSrchGrid.Create (Self);
  oDBSrGrid.Parent:=Self;
  oDBSrGrid.BorderStyle:=bsNone;
  oDBSrGrid.ReadOnly:=FALSE;
//  oDBSrGrid.oDBGrid.DataSource.OnDataChange:=MyDataSourceDataChange;

  oDBSrGrid.OnChangeIndex  :=MyDBSrGridOnChangeIndex;
  oDBSrGrid.OnColEnter     :=MyDBSrGridOnColEnter;
  oDBSrGrid.OnColExit      :=MyDBSrGridOnColExit;
  oDBSrGrid.OnCRPressed    :=MyDBSrGridOnCRPressed;
  oDBSrGrid.OnCtrlDelPressed:= MyDBSrGridOnCtrlDelPressed;
  oDBSrGrid.OnDataChange   :=MyDBSrGridOnDataChange;
  oDBSrGrid.OnDelPressed   :=MyDBSrGridOnDelPressed;
  oDBSrGrid.OnEscPressed   :=MyDBSrGridOnEscPressed;
  oDBSrGrid.OnF7Pressed    :=MyDBSrGridOnF7Pressed;
  oDBSrGrid.OnF3Pressed    :=MyDBSrGridOnF3Pressed;
  oDBSrGrid.OnInsPressed   :=MyDBSrGridOnInsPressed;
  oDBSrGrid.OnCtrlInsPressed:=MyDBSrGridOnCtrlInsPressed;
  oDBSrGrid.OnModPressed   :=MyDBSrGridOnModPressed;
  oDBSrGrid.OnKeyDown      :=MyDBSrGridOnKeyDown;
  oDBSrGrid.OnSelected     :=MyDBSrGridOnSelected;
  oDBSrGrid.OnFocusedChange:=MyDBSrGridOnFocusedChange;
  oDBSrGrid.oDBGrid.OnWriteCelText:=MyWriteCelText;

  oDBSrGrid.OnSrchKeyDown:=MyDBSrGridOnSrchKeyDown;
  oDBSrGrid.OnGridChange :=MyDBSrGridOnGridChange;
  oDBSrGrid.OnDrawColorRow:=MyOnDrawColorRow;
  oDBSrGrid.OnSelChange:=MyOnSelChange;

  oPanel:=TPanel.Create (Self);
  oPanel.Parent:=Self;
  oPanel.Height:=22;
  oPanel.BevelInner:=bvLowered;
  oPanel.BevelOuter:=bvRaised;
  oPanel.OnMouseUp:=MyOnMouseUp;
  oPanel.TabStop:=FALSE;
  oPanel.Color:=clIccPanelBG;

  oBPanel:=TPanel.Create (Self);
  oBPanel.Parent:=Self;
  oBPanel.Top:=0;
  oBPanel.Height:=0;
  oBPanel.BevelInner:=bvNone;
  oBPanel.BevelOuter:=bvNone;
  oBPanel.Color:=clIccPanelBG;

  oRecQnt:= TLabel.Create (oPanel);
  oRecQnt.Parent:=oPanel;
  oRecQnt.Font.Size:=10;
  oRecQnt.Font.Name:='Times New Roman';
  oRecQnt.Font.Style:=[fsBold];
  oRecQnt.AutoSize:=FALSE;
  oRecQnt.Top:=4;
  oRecQnt.Caption:='0';
  oRecQnt.Width:=50;
  oRecQnt.OnMouseUp:=MyOnMouseUp;

  oTabPopup:=TPopupMenu.Create (Self);
  oTabPopup.OnPopup:=MyTabsPopup;
  oTabPopup.Items.Add (NewItem(ctAdvGrid_ViewerSetEdit,0,FALSE,True,ModifyGridSet,0,'ModifyGridSet'));
  oTabPopup.Items.Add (NewItem(ctAdvGrid_ViewerSetSave,0,FALSE,True,SaveGridSet,0,'SaveGridSet'));
  oTabPopup.Items.Add (NewItem(ctAdvGrid_ViewerSetDel,0,FALSE,True,DeleteGridSet,0,'DeleteGridSet'));
  oTabPopup.Items.Add (NewItem(ctAdvGrid_ColorInfo,0,FALSE,True,ColorInfo,0,'ColorInfo'));

  oTabSet:=TTabSet.Create (Self);
  oTabSet.Parent:=Self;
  oTabSet.Font.Name:='Arial';
  oTabSet.TabStop:=FALSE;
  oTabSet.OnChange:=MyTabSetOnChange;
  oTabSet.OnMouseUp:=MyOnMouseUp;
  oTabSet.BackgroundColor:=clIccPanelBG;

  oSelTable:=TTable.Create(Self);

  oToolBarHeight:=0;
  oShowRecNo:=TRUE;

  oSetPath:='';
  oDGDPath:='';
  oDefIndex:='';
  oColorGrp:=''; oColorType:=0;
  For I:=1 to 10 do oRowColors[I]:=clBlack;
  oOnlyUserSet:=FALSE;
  oServiceMode:=FALSE;
  oGDChange:=TRUE;
  oGridModify :=TRUE;
  oLastOpenWin:='';
  SetTabStop (TRUE);
  SetPositions;
end;

destructor  TAdvGrid.Destroy;
begin
  WriteActSettings;
  oTabPopup.Items.Delete (0);
  oTabPopup.Items.Delete (0);
  oTabPopup.Items.Delete (0);
  If (oSelTable.TableName<>'') and oSelTable.Active then oSelTable.Active:=FALSE;

  If oDBSrGrid.DataSet<>nil then begin
    oDBSrGrid.DataSet.AfterOpen:=nil;
    oDBSrGrid.DataSet.BeforeClose:=nil;
  end;
  FreeAndNil (oTabPopup);
  FreeAndNil (oHead);
  FreeAndNil (oDBSrGrid);
  FreeAndNil (oGridSet);
  FreeAndNil (oRecQnt);
  FreeAndNil (oPanel);
  FreeAndNil (oBPanel);
  FreeAndNil (oTabSet);
  FreeAndNil (oSelTable);
  inherited Destroy;
end;

function  TAdvGrid.GetImageParams: String;
begin
  GetImageParams:=oDBSrGrid.ImageParams;
end;

procedure TAdvGrid.SetImageParams (Value:String);
begin
  oDBSrGrid.ImageParams:=Value;
end;

procedure TAdvGrid.SetSelTableParam (pTable:TTable);
begin
  oDBSrGrid.SetSelTableParam (pTable);
end;

procedure TAdvGrid.SetFocus;
begin
  oDBSrGrid.oStringGrid.SetFocus;
end;

function  TAdvGrid.GetActDGDName:string;
begin
  Result:=oGridSet.GetListItName (oTabSet.TabIndex);
end;

procedure TAdvGrid.ClearSrchData;
begin
  oDBSrGrid.ResetSearchData;
end;

procedure TAdvGrid.Loaded;
begin
  inherited;
  IndexColor.IndexFindColor:=clLime;
end;

procedure TAdvGrid.SetDBPos (pPos:string);
var mPos:string;  mOldBM:string;  mBM:TBookmark;
begin
  If oDBSrGrid.DataSet is TBtrieveTable then begin
//    (oDBSrGrid.DataSet as TBtrieveTable).RecordCount;
    (oDBSrGrid.DataSet as TBtrieveTable).GotoPos (ValInt (pPos));
    oDBSrGrid.DataSet.Refresh;
  end else begin
    If pPos<>'' then begin
      If oDBSrGrid.DataSet.Active then begin
        If oDBSrGrid.DataSet.RecordCount>0 then begin
          mPos:=ConvStrToBookmark (pPos);
          mBM:=oDBSrGrid.DataSet.GetBookmark;
          try
//            oDBSrGrid.DataSet.Bookmark:=mPos;
// 5.11.2005 Tibi - Vypol som, lebo zatial nevieme kontrolovat spravnost bookmarku,
//a preto niekedy vypise chybu corrupt file  
          except
            oDBSrGrid.DataSet.GotoBookmark (mBM);
          end;
          oDBSrGrid.DataSet.FreeBookmark (mBM);
        end;
      end;
    end;
  end;
end;

function  TAdvGrid.GetDBPos:string;
begin
  If oDBSrGrid.DataSet is TBtrieveTable then begin
    Result:=StrInt ((oDBSrGrid.DataSet as TBtrieveTable).ActPos,0)
  end else begin
    Result:=ConvBookmarkToStr (oDBSrGrid.DataSet.Bookmark);
  end;
end;

procedure  TAdvGrid.RowCnd (pType,pColorIndex:byte;pCnd:boolean;var pColor:TColor);
begin
  If (pType=oColorType) and pCnd then begin
    If pColorIndex in [1..10] then pColor:=RowColors[pColorIndex];
  end;
end;

procedure TAdvGrid.SetPositions;
var
  mBorderSize:integer;
  mBevelSize:integer;
begin
  mBorderSize:=0;
  mBevelSize:=BorderWidth;
  If BorderStyle=bsSingle then mBorderSize:=4;
  If BevelInner<>bvNone then mBevelSize:=mBevelSize+BevelWidth;
  If BevelOuter<>bvNone then mBevelSize:=mBevelSize+BevelWidth;
  If oHead.Caption=''
    then oHead.Height:=0
    else oHead.Height:=GetTextHeight(oHead.Font,Self)+4;
  oHead.Top:=mBevelSize;
  oHead.Left:=mBevelSize;
  oHead.Width:=Width-mBorderSize-2*mBevelSize;

  oRecQnt.Alignment:=taRightJustify;
  oPanel.Left:=mBevelSize;
  oPanel.Top:=Height-oPanel.Height-mBorderSize-mBevelSize;
  oRecQnt.Left:=10;
  If oShowRecNo then begin
    oPanel.Width:=200;
    oRecQnt.Width:=180;
  end else begin
    If oSelRecQnt=0 then begin
      oPanel.Width:=100;
      oRecQnt.Width:=80;
    end else begin
      oPanel.Width:=200;
      oRecQnt.Width:=180;
    end;
  end;

  oDBSrGrid.Left:=mBevelSize;
  oDBSrGrid.Top:=oHead.Height+oToolBarHeight+mBevelSize;
  oDBSrGrid.Width:=Width-mBorderSize-2*mBevelSize;
  oDBSrGrid.Height:=Height-oHead.Height-oToolBarHeight-oPanel.Height-mBorderSize-2*mBevelSize;

  oTabSet.Top:=oPanel.Top;
  oTabSet.Left:=oPanel.Left+oPanel.Width;
  oTabSet.Width:=Width-oPanel.Width-mBorderSize-2*mBevelSize;

  oBPanel.Left:=oDBSrGrid.Left;
  oBPanel.Top:=oHead.Top+oHead.Height;
  oBPanel.Height:=ToolBarHeight;
//  oBPanel.Width:=oDBSrGrid.Width;
  oBPanel.Width:=0;
end;

procedure TAdvGrid.ShowRecordCount;
var mS:string;
begin
  If Assigned (oDBSrGrid) and Assigned (oDBSrGrid.DataSet) and oDBSrGrid.DataSet.Active then begin
    If oShowRecNo then begin
      mS:='';
      If oDBSrGrid.DataSet.RecNo>-1 then mS:=StrIntSepar (oDBSrGrid.DataSet.RecNo,0,TRUE);
      oRecQnt.Caption:=mS+' / '+StrIntSepar (oDBSrGrid.DataSet.RecordCount,0,TRUE);
    end else begin
      If oSelRecQnt=0
        then oRecQnt.Caption:=StrIntSepar (oDBSrGrid.DataSet.RecordCount,0,TRUE)
        else begin
          oRecQnt.Caption:=StrIntSepar (oDBSrGrid.DataSet.RecordCount,0,TRUE)+'  ( '+StrIntSepar (oSelRecQnt,0,TRUE)+' )';
        end;
    end;
  end;
end;

procedure TAdvGrid.LoadDefGrid;
var
  I:longint;
  mFld:string;
  mDispLabel:string;
  mDispFormat:string;
  mAlign:string;
  mDispWidth:integer;
  mReadOnly:boolean;
  mAlignment:TAlignment;
  mFldNum:integer;
  mFullname:string;
begin
  oGridSet.SetDGDName (oDGDPath+oDGDName);
  If oGridSet.LoadSet ('DEFAULT') then begin
    If oGridSet.GetGridItCount>0 then begin
      I:=0;
      While (I<oGridSet.GetGridItCount) do begin
        If Pos ('FIELD',UpString (oGridSet.GetGridItName(I)))=1 then begin
          oGridSet.GetGridFieldParam(I,mFld,mDispLabel,mAlign,mDispFormat,mFldNum,mDispWidth,mReadOnly,mFullname);
          If oDBSrGrid.oDBGrid.DataSource.DataSet.FindField (mFld)<>nil then begin
            mAlignment:=taRightJustify;
            If mAlign='L' then mAlignment:=taLeftJustify;
            If mAlign='C' then mAlignment:=taCenter;
            If oDBSrGrid.oDBGrid.DataSource.DataSet.FieldByName(mFld).DataType in [ftSmallint,ftInteger,ftWord,ftFloat,ftCurrency,ftBytes,ftVarBytes,ftLargeint] then begin
              (oDBSrGrid.oDBGrid.DataSource.DataSet.FieldByName(mFld) as TNumericField).DisplayFormat:=mDispFormat;
              (oDBSrGrid.oDBGrid.DataSource.DataSet.FieldByName(mFld) as TNumericField).EditFormat:=ReplaceStr (mDispFormat,' ','');
              (oDBSrGrid.oDBGrid.DataSource.DataSet.FieldByName(mFld) as TNumericField).EditFormat:='########0.#####';
            end;
            If (oDBSrGrid.oDBGrid.DataSource.DataSet.FieldByName(mFld).DataType in [ftDate])
              then (oDBSrGrid.oDBGrid.DataSource.DataSet.FieldByName(mFld) as TDateField).DisplayFormat:=mDispFormat;
            If (oDBSrGrid.oDBGrid.DataSource.DataSet.FieldByName(mFld).DataType in [ftTime])
              then (oDBSrGrid.oDBGrid.DataSource.DataSet.FieldByName(mFld) as TTimeField).DisplayFormat:=mDispFormat;
            oDBSrGrid.oDBGrid.DataSource.DataSet.FieldByName(mFld).Alignment:=mAlignment;
          end;
        end;
        Inc (I);
      end;
    end;
  end;
end;

procedure TAdvGrid.LoadGridSet (pSetNum:string);
var
  I:integer;
  mFld:string;
  mCom,mS:string;
  mFontType:string;
  mDispLabel:string;
  mDispFormat:string;
  mAlign:string;
  mFullName:String;
  mDispWidth:integer;
  mReadOnly:boolean;
  mAlignment:TAlignment;
  mFldNum:integer;
  mFontWidth:integer;
  mHeadFont:TFont;
  mGridFont:TFont;
begin
  If oLastOpenWin<>pSetNum then begin
    If Assigned (oDBSrGrid) and Assigned (oDBSrGrid.DataSet) and oDBSrGrid.DataSet.Active then begin
      oDBSrGrid.ActualizedGrid:=FALSE;
      oDBSrGrid.Visible:=FALSE;  //Tibi 13.06.2018
//      oDBSrGrid.Hide; //Tibi 19.05.2018
      If oDGDName<>'' then begin
        If oGridSet.GetListItCount>0 then begin
          oColorGrp:= ''; oColorType:=0;
          For I:=1 to 10 do oRowColors[I]:=clBlack;
          oHead.Caption:='';
          mHeadFont:=TFont.Create;
          mGridFont:=TFont.Create;
          mHeadFont.Name:='Times New Roman';
          mHeadFont.Size:=12;
          mHeadFont.Style:=[fsBold];
          mGridFont.Name:='Arial';
          mGridFont.Size:=10;
          mGridFont.Style:=[];
          oGridSet.SetDGDName (oDGDPath+oDGDName);
          oGridSet.LoadSet (pSetNum);
          If oGridSet.GetGridItCount>0 then begin
            For I:=0 to oDBSrGrid.DataSet.FieldCount-1 do begin
              If oDBSrGrid.DataSet.Fields[I].Visible then oDBSrGrid.DataSet.Fields[I].Visible:=FALSE;
            end;
            I:=0;
            mFontWidth:=GetTextWidth('0',oDBSrGrid.oDBGrid.Font,Self);
            oDBSrGrid.oFldQnt:=0;
            While (I<oGridSet.GetGridItCount) do begin
              mCom:=UpString (oGridSet.GetGridItName(I));
              If mCom='COLORGRP' then oColorGrp:=oGridSet.GetGridItText(I);
              If mCom='HEAD' then oHead.Caption:=oGridSet.GetGridItText(I);
              If mCom='HEADFONT' then begin
                mHeadFont.Name:=GetParamString (oGridSet.GetGridItText(I), 1);
                mHeadFont.Size:=ValInt (GetParamString (oGridSet.GetGridItText(I), 2));
                mFontType:=GetParamString (oGridSet.GetGridItText(I), 3);
                mHeadFont.Style:=[];
                If Pos ('B',mFontType)>0 then mHeadFont.Style:=mHeadFont.Style+[fsBold];
                If Pos ('I',mFontType)>0 then mHeadFont.Style:=mHeadFont.Style+[fsItalic];
              end;
              If mCom='GRIDFONT' then begin
                mGridFont.Name:=GetParamString (oGridSet.GetGridItText(I), 1);
                mGridFont.Size:=ValInt (GetParamString (oGridSet.GetGridItText(I), 2));
                mFontType:=GetParamString (oGridSet.GetGridItText(I), 3);
                mGridFont.Style:=[];
                If Pos ('B',mFontType)>0 then mGridFont.Style:=mGridFont.Style+[fsBold];
                If Pos ('I',mFontType)>0 then mGridFont.Style:=mGridFont.Style+[fsItalic];
                mFontWidth:=GetTextWidth('0',mGridFont,Self);
              end;
              If Copy (mCom,1,5)='FIELD' then begin
                oGridSet.GetGridFieldParam(I,mFld,mDispLabel,mAlign,mDispFormat,mFldNum,mDispWidth,mReadOnly,mFullname);
                If UpString (mFld)<>'LOGINOWNR' then begin
                  If oDBSrGrid.oDBGrid.DataSource.DataSet.FindField (mFld)<>nil then begin
                    mAlignment:=taRightJustify;
                    If mAlign='L' then mAlignment:=taLeftJustify;
                    If mAlign='C' then mAlignment:=taCenter;
                    If oDBSrGrid.oDBGrid.DataSource.DataSet.FieldByName(mFld).DataType in [ftSmallint,ftInteger,ftWord,ftFloat,ftCurrency,ftBytes,ftVarBytes,ftLargeint] then begin
                      (oDBSrGrid.oDBGrid.DataSource.DataSet.FieldByName(mFld) as TNumericField).DisplayFormat:=mDispFormat;
                      (oDBSrGrid.oDBGrid.DataSource.DataSet.FieldByName(mFld) as TNumericField).EditFormat:=ReplaceStr (mDispFormat,' ','');
                      (oDBSrGrid.oDBGrid.DataSource.DataSet.FieldByName(mFld) as TNumericField).EditFormat:='########0.#####';
                    end;
                    If (oDBSrGrid.oDBGrid.DataSource.DataSet.FieldByName(mFld).DataType in [ftDate])
                      then (oDBSrGrid.oDBGrid.DataSource.DataSet.FieldByName(mFld) as TDateField).DisplayFormat:=mDispFormat;
                    If (oDBSrGrid.oDBGrid.DataSource.DataSet.FieldByName(mFld).DataType in [ftTime])
                      then (oDBSrGrid.oDBGrid.DataSource.DataSet.FieldByName(mFld) as TTimeField).DisplayFormat:=mDispFormat;
                    oDBSrGrid.oDBGrid.DataSource.DataSet.FieldByName(mFld).Index:=mFldNum;
                    oDBSrGrid.oDBGrid.DataSource.DataSet.FieldByName(mFld).DisplayLabel:=mDispLabel;
                    oDBSrGrid.oDBGrid.DataSource.DataSet.FieldByName(mFld).Alignment:=mAlignment;
                    Inc (oDBSrGrid.oFldQnt);
                    oDBSrGrid.oFldReadOnly[oDBSrGrid.oFldQnt].Fld:=mFld;
                    oDBSrGrid.oFldReadOnly[oDBSrGrid.oFldQnt].ReadOnly:=mReadOnly;
    //                oDBSrGrid.oDBGrid.DataSource.DataSet.FieldByName(mFld).ReadOnly:=mReadOnly;
                    oDBSrGrid.oDBGrid.DataSource.DataSet.FieldByName(mFld).DisplayWidth:=(mDispWidth div mFontWidth);
                    oDBSrGrid.oDBGrid.DataSource.DataSet.FieldByName(mFld).Visible:=TRUE;
                    oDBSrGrid.oDBGrid.Columns.Items[GetFieldIndex (mFld)].Width:=mDispWidth;
                  end;
                end;
              end;
              Inc (I);
            end;
            HeadFont.Name:=mHeadFont.Name;
            HeadFont.Size:=mHeadFont.Size;
            HeadFont.Style:=mHeadFont.Style;
            GridFont.Name:=mGridFont.Name;
            GridFont.Size:=mGridFont.Size;
            GridFont.Style:=mGridFont.Style;
          end;
          mHeadFont.Free;
          mGridFont.Free;
          If oColorGrp<>'' then begin
            If oGridSet.LoadColorGrp(oColorGrp) then begin
              oColorType:=ValInt (oGridSet.oColorGrp.Values['Type']);
              For I:=1 to 10 do begin
                mS:=oGridSet.oColorGrp.Values['Color'+StrInt (I,0)];
                If mS<>'' then oRowColors[I]:=ValInt (mS);
              end;
            end;
          end;
          oTabPopup.Items.Items[3].Visible:=(oColorGrp<>'');
        end;
      end;
      oDBSrGrid.SetExtIndexName (oDefIndex);
      oDBSrGrid.ActualizedGrid:=TRUE;
//      oDBSrGrid.Show; //Tibi 19.05.2018
      oDBSrGrid.Visible:=TRUE; //Tibi 13.06.2018
      SetPositions;
      oDBSrGrid.Height:=oDBSrGrid.Height-1; // Tibi 21.05.2018 (aby automaticky aktualizoval v˝öku gridu)
      oDBSrGrid.Height:=oDBSrGrid.Height+1;
      oLastOpenWin:=pSetNum;
    end;
  end;
end;

procedure TAdvGrid.WriteActSettings;
var
  mPos:string;
  mGrActSet:TGrActSet;
  mTableName:string;
begin
  If Assigned (oDBSrGrid) and Assigned (oDBSrGrid.DataSet) and oDBSrGrid.DataSet.Active then begin
//    WriteActGrid;
    If DirectoryExists (oSetPath) then begin
//      mTableName:=ExtractFileName ((oDBSrGrid.oDBGrid.DataSource.DataSet as TTable).TableName);
//      If Pos ('.',mTableName)>0 then mTableName:=Copy (mTableName,1,Pos ('.',mTableName)-1);
//      mGrActSet:=TGrActSet.Create (oSetPath+oLoginName,oDGDName+'.'+mTableName);
      mGrActSet:=TGrActSet.Create (oSetPath+oLoginName,oDGDName);
      If oSavePos
        then mPos:=GetDBPos
        else mPos:='';
      mGrActSet.SaveActSet (oGridSet.GetListItName (oTabSet.TabIndex),oDBSrGrid.GetIndexName,mPos,oDBSrGrid.oDBGrid.LeftCol);
      mGrActSet.Free;
    end;
  end;
end;

procedure TAdvGrid.WriteActGrid;
var
  I:integer;
  mFld:string;
  mAlignment:string;
  mDisplayFormat:string;
  mReadOnly:string;
  mSection:string;
  mSect:string;
  mFontType:string;
begin
  If oGridChange then begin
    If Assigned (oDBSrGrid) and Assigned (oDBSrGrid.DataSet) and oDBSrGrid.DataSet.Active then begin
      oGridSet.oSetGrid.Clear;
      oGridSet.oSetGrid.Add ('Head='+oHead.Caption);
      mFontType:='';
      If fsBold in HeadFont.Style then mFontType:=mFontType+'B';
      If fsItalic in HeadFont.Style then mFontType:=mFontType+'I';
      oGridSet.oSetGrid.Add ('HeadFont='+HeadFont.Name+','+StrInt (HeadFont.Size,0)+','+mFontType);
      mFontType:='';
      If fsBold in GridFont.Style then mFontType:=mFontType+'B';
      If fsItalic in GridFont.Style then mFontType:=mFontType+'I';
      oGridSet.oSetGrid.Add ('GridFont='+GridFont.Name+','+StrInt (GridFont.Size,0)+','+mFontType);
      If oColorGrp<>'' then oGridSet.oSetGrid.Add ('ColorGrp='+oColorGrp);
      If oDBSrGrid.oDBGrid.FieldCount>0 then begin
        For I:=0 to oDBSrGrid.oDBGrid.FieldCount-1 do begin
          mFld:=oDBSrGrid.oDBGrid.Columns.Items[I].Field.FieldName;
          mAlignment:='R';
          If oDBSrGrid.oDBGrid.DataSource.DataSet.FieldByName(mFld).Alignment=taLeftJustify then mAlignment:='L';
          If oDBSrGrid.oDBGrid.DataSource.DataSet.FieldByName(mFld).Alignment=taCenter then mAlignment:='C';
//          If oDBSrGrid.oDBGrid.DataSource.DataSet.FieldByName(mFld).ReadOnly
          If oDBSrGrid.GetFldReadOnly (mFld)
            then mReadOnly:='TRUE'
            else mReadOnly:='FALSE';
          mDisplayFormat:='';
          If oDBSrGrid.oDBGrid.DataSource.DataSet.FieldByName(mFld).DataType in [ftSmallint,ftInteger,ftWord,ftFloat,ftCurrency,ftBytes,ftVarBytes,ftLargeint] then begin
            mDisplayFormat:=(oDBSrGrid.oDBGrid.DataSource.DataSet.FieldByName(mFld) as TNumericField).DisplayFormat;
          end;
          oGridSet.oSetGrid.Add ('Field'+StrInt (I,0)+'='+mFld
            +','+oDBSrGrid.oDBGrid.DataSource.DataSet.FieldByName(mFld).DisplayName
            +','+StrInt (oDBSrGrid.oDBGrid.Columns.Items[GetFieldIndex (mFld)].Width,0)
            +','+mAlignment+','+mDisplayFormat+','+mReadOnly);
        end;
      end;
      mSection:=oGridSet.GetListItName (oTabSet.TabIndex);
      mSect:=mSection;
      If not oServiceMode and (Copy (mSection,1,1)<>'U') then mSection:= oGridSet.GetNewSection (oServiceMode);
      oGridSet.SaveGridSet (mSection);
      oGridChange:=FALSE;
      If mSect<>mSection then begin
        FillTabSet (-1);
        If oTabSet.Tabs.Count>0 then begin
          I:=0;
          While (I<oTabSet.Tabs.Count-1) and (mSection<>oTabSet.Tabs.Strings[I]) do
            Inc (I);
          If mSection=oTabSet.Tabs.Strings[I] then oTabSet.TabIndex:=I;
        end;
      end;
    end;
  end;
end;

procedure TAdvGrid.ReadActSettings;
var mActSet:string;  mPos:string; mGrActSet:TGrActSet;  mLeftCol:longint;  mTableName:string;
    mTabSetName:ShortString;
begin
  If EnabledReadActSet then begin
    oDefIndex:='';
    oGridChange:=FALSE;
    If Assigned (oDBSrGrid) and Assigned (oDBSrGrid.DataSet) and oDBSrGrid.DataSet.Active then begin
      If DirectoryExists (oSetPath) then begin
//        mTableName:=ExtractFileName ((oDBSrGrid.oDBGrid.DataSource.DataSet as TTable).TableName);
//        If Pos ('.',mTableName)>0 then mTableName:=Copy (mTableName,1,Pos ('.',mTableName)-1);
//        mGrActSet:=TGrActSet.Create (oSetPath+oLoginName,oDGDName+'.'+mTableName);
        mGrActSet:=TGrActSet.Create (oSetPath+oLoginName,oDGDName);
        mGrActSet.ReadData;
        mActSet:=mGrActSet.GetActSet;
        oDefIndex:=mGrActSet.GetActIndex;
        mPos:=mGrActSet.GetActPos;
        mLeftCol:=mGrActSet.GetFirstCol;
        mGrActSet.Free;
        oDBSrGrid.SetExtIndexName (oDefIndex);
        SetTabs (mActSet);
        LoadDefGrid;
        LoadGridSet(mActSet);
        SetDBPos (mPos);
        If mLeftCol=0 then mLeftCol:=1;
        oDBSrGrid.oDBGrid.LeftCol:=mLeftCol;
        oDBSrGrid.oStringGrid.LeftCol:=mLeftCol-1;
        If Assigned (eOnTabSetChanged) then begin
          mTabSetName:=oGridSet.GetListItName (TabSet);
          eOnTabSetChanged (nil,mTabSetName);
        end;
      end;
    end;
  end;
  oSavePos:=TRUE;
end;

procedure TAdvGrid.SetTabs (pActSet:string);
var
  I:integer;
  mOK:boolean;
begin
  I:=0;
  mOK:=FALSE;
  While (I<oGridSet.GetListItCount) and not mOK do begin
    mOK:=(oGridSet.GetListItName (I)=pActSet);
    If not mOK then Inc (I);
  end;
  If mOK and (oTabSet.Tabs.Count>0) then oTabSet.TabIndex:=I;
end;

function  TAdvGrid.ConvStrToBookmark (pStr:string):string;
var mS:string;
begin
  Result:='';
  While pStr<>'' do begin
    If Pos ('-',pStr)>0 then begin
      mS:=Copy (pStr,1,Pos ('-',pStr)-1);
      Delete (pStr,1,Pos ('-',pStr));
    end else begin
      mS:=pStr;
      pStr:='';
    end;
    Result:=Result+Chr (ValInt (mS));
  end;
end;

function  TAdvGrid.ConvBookmarkToStr (pStr:string):string;
var I:integer;
begin
  Result:='';
  For I:=1 to Length (pStr) do begin
    If I=1
      then Result:=Result+StrInt (Ord (pStr [I]),0)
      else Result:=Result+'-'+StrInt (Ord (pStr [I]),0);
  end;
end;

procedure TAdvGrid.SetShortCutTabSet (var Key: Word; Shift: TShiftState);
begin
  If (ssAlt in Shift) then begin
    case Key of
      Ord ('1')..Ord ('9') : begin
        If ValInt (Chr (Key))<=oTabSet.Tabs.Count then begin
          If oTabSet.TabIndex<>ValInt (Chr (Key))-1 then begin
            oTabSet.TabIndex:=ValInt (Chr (Key))-1;
//            oDBSrGrid.SetFocus;
            Key:=0;
          end;
        end;
      end;
    end;
  end;
end;

procedure TAdvGrid.FillTabSet (pTabIndex:integer);
var
  I:integer;
  mFile:TIniFile;
begin
  If Assigned (oDBSrGrid) and Assigned (oDBSrGrid.DataSet) and oDBSrGrid.DataSet.Active then begin
    mFile:=TIniFile.Create (oDGDPath+oDGDName+cDefType);
    oOnlyUserSet:=mFile.ReadBool ('SETTINGS','ShowOnlyUserSet',FALSE);
    mFile.Free;

    While oTabSet.Tabs.Count>0 do
      oTabSet.Tabs.Delete (0);
    If DirectoryExists (oDGDPath) then begin
      oGridSet.SetDGDName (oDGDPath+oDGDName);
      oGridSet.ReadList (oOnlyUserSet,oServiceMode);
      If oGridSet.GetListItCount>0 then begin
        For I:=0 to oGridSet.GetListItCount-1 do
          oTabSet.Tabs.Add (oGridSet.GetListItText (I));
        If pTabIndex>=0 then begin
          If pTabIndex>oTabSet.Tabs.Count
            then oTabSet.TabIndex:=oTabSet.Tabs.Count-1
            else oTabSet.TabIndex:=pTabIndex;
          LoadGridSet (oGridSet.GetListItName (oTabSet.TabIndex));
        end;
      end;
    end;
  end;
end;

function  TAdvGrid.GetFieldIndex (pFld:string):integer;
var
  I:byte;
  mFind:boolean;
begin
  mFind:=FALSE;
  Result:=0;
  I:=0;
  While (I<oDBSrGrid.oDBGrid.FieldCount) and not mFind do begin
    mFind:=(oDBSrGrid.oDBGrid.Columns.Items[I].Field.FieldName = pFld);
    If not mFind then Inc (I);
  end;
  If mFind then Result:=I;
end;

procedure TAdvGrid.VerifyDefGridSet;
begin
  try
    If oGridSet<>nil then begin
      oGridSet.SetDGDName (oDGDPath+oDGDName);
      If not oGridSet.DefaultExists then oGridSet.CreateDefaultGridSet (oDBSrGrid.DataSet);
      If not oGridSet.VerifyD01 then FillTabSet (0);
    end;
  except end;
end;

procedure TAdvGrid.SetGridFont (Value:TFont);
begin
  oDBSrGrid.oDBGrid.Font:=Value;
end;

function  TAdvGrid.GetGridFont:TFont;
begin
  Result:=oDBSrGrid.oDBGrid.Font;
end;

function  TAdvGrid.GetDataSet:TDataSet;
begin
  Result:=oDBSrGrid.DataSet;
end;

procedure TAdvGrid.SetDataSet (Value:TDataSet);
var I:longint;
begin
  If oDBSrGrid.DataSet<>Value then begin
    oLastOpenWin:='';
    oDBSrGrid.Visible:=FALSE; //TIBI 10.01.2019
    If Value<>nil then begin
      For I:=0 to Value.FieldCount-1 do begin
        Value.Fields[I].Visible:=FALSE;
      end;
    end;
    oDBSrGrid.DataSet:=Value;
    If Assigned (Value) then oDBSrGrid.DataSet.AfterOpen:=MyDataSetAfterOpen;
    If Assigned (Value) then oDBSrGrid.DataSet.BeforeClose:=MyDataSetBeforeClose;
    VerifyDefGridSet;
    If oTabSet<>nil then FillTabSet (oTabSet.TabIndex);
    If FixIndexFields='' then ReadActSettings;
  end;
end;

function  TAdvGrid.GetHead:string;
begin
  Result:=oHead.Caption;
end;

procedure TAdvGrid.SetHead (Value:string);
begin
  If oHead.Caption<>Value then begin
    oHead.Caption:=Value;
    SetPositions;
  end;
end;

function  TAdvGrid.GetHeadFont:TFont;
begin
  Result:=oHead.Font;
end;

procedure TAdvGrid.SetHeadFont (Value:TFont);
begin
  oHead.Font.Assign (Value);
end;

procedure TAdvGrid.SetToolBarHeight (Value:integer);
begin
  If oToolBarHeight<>Value then begin
    oToolBarHeight:=Value;
    SetPositions;
  end;
end;

procedure TAdvGrid.SetShowRecNo (Value:boolean);
begin
  If oShowRecNo<>Value then begin
    oShowRecNo:=Value;
    ShowRecordCount;
    SetPositions;
  end;
end;
            
procedure TAdvGrid.SetSetPath (Value:string);
begin
  If (oSetPath<>Value) and (DirectoryExists(Value)) then begin
    oSetPath:=Value;
    If (Length (oSetPath)>2) and (oSetPath[Length (oSetPath)]<>'\') then oSetPath:=oSetPath+'\';
    If oTabSet<>nil then FillTabSet (oTabSet.TabIndex);
  end;
end;

procedure TAdvGrid.SetDGDPath (Value:string);
begin
  If (oDGDPath<>Value) and (DirectoryExists(Value)) then begin
    oDGDPath:=Value;
    If (Length (oDGDPath)>2) and (oDGDPath[Length (oDGDPath)]<>'\') then oDGDPath:=oDGDPath+'\';
    If oTabSet<>nil then FillTabSet (oTabSet.TabIndex);
  end;
end;

procedure TAdvGrid.SetDGDName (Value:string);
begin
  If oDGDName<>Value then begin
    oDGDName:=Value;
    If oTabSet<>nil then FillTabSet (oTabSet.TabIndex);
  end;
end;

procedure TAdvGrid.SetLoginName (Value:string);
begin
  oLoginName:=Value;
  If FixIndexFields='' then ReadActSettings;
end;

procedure TAdvGrid.SetOnlyUserSet (Value:boolean);
begin
  If oOnlyUserSet<>Value then begin
    oOnlyUserSet:=Value;
    If oTabSet<>nil then FillTabSet (oTabSet.TabIndex);
  end;
end;

procedure TAdvGrid.SetServiceMode (Value:boolean);
begin
  If oServiceMode<>Value then begin
    oServiceMode:=Value;
    If oServiceMode then begin
      SetOnlyUserSet (FALSE);
      oTabSet.PopupMenu:=oTabPopup;
      oDBSrGrid.oDBGrid.Options:=oDBSrGrid.oDBGrid.Options+[dgColumnResize];
      oGridModify:=TRUE;
    end;
  end;
end;

procedure TAdvGrid.SetGDChange (Value:boolean);
begin
  oGDChange:=Value;
  oTabPopup.Items.Items[0].Enabled:=Value;
  oTabPopup.Items.Items[2].Enabled:=Value;
end;

function  TAdvGrid.GetTabSet:integer;
begin
  GetTabSet:=oTabSet.TabIndex;
end;

procedure TAdvGrid.SetTabSet (Value:integer);
begin
  If (oTabSet.TabIndex<>Value) and (Value>=0) and (Value<=oTabSet.Tabs.Count-1) and (oTabSet.Tabs.Count>0) then begin
    oTabSet.TabIndex:=Value;
    LoadGridSet (oGridSet.GetListItName (Value));
  end;
end;

procedure TAdvGrid.SetGridModify (Value:boolean);
begin
  oGridModify:=Value;
  If not oGridModify then begin
    oServiceMode:=FALSE;
    oTabSet.PopupMenu:=nil;
    oDBSrGrid.oDBGrid.Options:=oDBSrGrid.oDBGrid.Options-[dgColumnResize];
  end else begin
    oTabSet.PopupMenu:=oTabPopup;
    oDBSrGrid.oDBGrid.Options:=oDBSrGrid.oDBGrid.Options+[dgColumnResize];
  end;
end;

procedure TAdvGrid.SetTabStop (Value:boolean);
begin
  inherited TabStop:=FALSE;
  oTabStop:=Value;
  oDBSrGrid.TabStop:=Value;
end;

procedure TAdvGrid.SetSearchLnClear (Value:boolean);
begin
//  inherited TabStop:=FALSE;
  oSearchLnClear:=Value;
  oDBSrGrid.SearchLnClear:=Value;
end;

procedure TAdvGrid.DeleteGridSet (Sender:TObject);
var mTabIndex:integer;
begin
  If MessageDlg ('Naozaj chcete zruöiù?', mtWarning,[mbYes,mbNo], 0)=mrYes then begin
    mTabIndex:=oTabSet.TabIndex;
    oGridSet.DeleteGridSet (oGridSet.GetListItName (oTabSet.TabIndex));
    If mTabIndex=oTabSet.Tabs.Count-1 then Dec (mTabIndex);
    If oTabSet<>nil then FillTabSet (mTabIndex);
  end;
end;

procedure TAdvGrid.ModifyGridSet (Sender:TObject);
var
  mF:TF_GridDG;
  mNum:integer;
begin
  If DirectoryExists (oDGDPath) then begin
    mF:=TF_GridDG.Create (Self);
    mNum:=mF.Execute (oTabSet.TabIndex,oOnlyUserSet,oServiceMode,oDGDPath+oDGDName,oDBSrGrid.DataSet,GetTextWidth('0',oDBSrGrid.oDBGrid.Font,Self));
    mF.Free;
    oLastOpenWin:='';
    FillTabSet (mNum);
    SetFocus;
//    oDBSrGrid.SetFocus;
  end;
end;

procedure TAdvGrid.SaveGridSet (Sender:TObject);
begin
  WriteActGrid;
end;

procedure TAdvGrid.ColorInfo (Sender:TObject);
begin
  F_AdvGridInfCol:=TF_AdvGridInfCol.Create(Self);
  F_AdvGridInfCol.Execute (oDGDPath+oDGDName,oColorGrp);
  FreeAndNil (F_AdvGridInfCol);
end;

function  TAdvGrid.GetSearchLnFocused: boolean;
begin
  GetSearchLnFocused:=oDBSrGrid.SearchLnFocused;
end;

procedure TAdvGrid.SetSearchLnFocused (Value:boolean);
begin
  oDBSrGrid.SearchLnFocused:=GetSearchLnFocused;
end;

procedure TAdvGrid.MyDBSrGridOnKeyDown (Sender: TObject; var Key: Word; Shift: TShiftState);
begin
  SetShortCutTabSet (Key,Shift);
  If Assigned(eOnKeyDown) then eOnKeyDown (Self, Key, Shift);
end;

procedure TAdvGrid.MyDBSrGridOnChangeIndex (Sender: TObject);
begin
  If Assigned (eOnChangeIndex) then eOnChangeIndex (Sender);
end;

procedure TAdvGrid.MyDBSrGridOnColEnter (Sender: TObject);
begin
  If Assigned (eOnColEnter) then eOnColEnter (Sender);
end;

procedure TAdvGrid.MyDBSrGridOnColExit (Sender: TObject);
begin
  If Assigned (eOnColExit) then eOnColExit (Sender);
end;

procedure TAdvGrid.MyDBSrGridOnCRPressed (Sender: TObject);
begin
  If Assigned (eOnCRPressed) then eOnCRPressed (Sender);
end;

procedure TAdvGrid.MyDBSrGridOnCtrlDelPressed (Sender: TObject);
var mT:TextFile; I,mIORes:longint; mFile:string; mTxtWrap:TTxtWrap;
begin
  If DataSet.RecordCount>0 then begin
    If Assigned (eOnCtrlDelPressed)
      then eOnCtrlDelPressed (Sender)
      else If gRgh.Service then begin
        try
          If oDBSrGrid.DataSet is TBtrieveTable then begin
            mFile:=(DataSet as TBtrieveTable).DatabaseName+ExtractFileName ((DataSet as TBtrieveTable).TableName)+'.DTX';
            AssignFile (mT, mFile);
            {$I-}
            If FileExists(mFile) then Append (mT) else Rewrite (mT);
            {$I+} mIORes:=IOResult;
            If mIORes=0 then begin
              mTxtWrap:=TTxtWrap.Create;
              mTxtWrap.SetDelimiter ('');
              mTxtWrap.SetSeparator (';');
              mTxtWrap.ClearWrap;
              mTxtWrap.SetText(LoginName,0);
              mTxtWrap.SetDate(Date);
              mTxtWrap.SetTime(Time);
              mTxtWrap.SetText(cPrgVer,0);
              mTxtWrap.SetText('P',0);
              For I:=0 to DataSet.FieldCount-1 do begin
                mTxtWrap.SetText(DataSet.FieldByName (DataSet.FieldDefs[I].Name).AsString,0);
              end;
              {$I-} WriteLn (mT, mTxtWrap.GetWrapText);
              {$I+} mIORes:=IOResult;
              {$I-} CloseFile (mT); {$I+} mIORes:=IOResult;
            end;
            FreeAndNil (mTxtWrap);
          end;
        except end;
        DataSet.Delete;
      end;
  end;
end;

procedure TAdvGrid.MyDBSrGridOnDataChange (Sender: TObject; Field: TField);
begin
  ShowRecordCount;
  If Assigned (eOnDataChange) then eOnDataChange (Sender, Field);
end;

procedure TAdvGrid.MyDBSrGridOnDelPressed (Sender: TObject);
begin
  oDBSrGrid.ResetSearchData;
  If Assigned (eOnDelPressed) then eOnDelPressed (Sender);
end;

procedure TAdvGrid.MyDBSrGridOnEscPressed (Sender: TObject);
begin
  oDBSrGrid.ResetSearchData;
  If Assigned (eOnEscPressed) then begin
    If DataSet.State=dsBrowse
      then eOnEscPressed (Sender)
      else DataSet.Cancel;
  end;
end;

procedure TAdvGrid.MyDBSrGridOnF3Pressed (Sender: TObject);
begin
  If Assigned (eOnF3Pressed) then eOnF3Pressed (Sender);
end;

procedure TAdvGrid.MyDBSrGridOnF7Pressed (Sender: TObject);
begin
  If Assigned (eOnF7Pressed) then eOnF7Pressed (Sender);
end;

procedure TAdvGrid.MyDBSrGridOnInsPressed (Sender: TObject);
begin
  SearchLnFocused:=FALSE;
  oDBSrGrid.oDBGrid.SetFocus;
  oDBSrGrid.ResetSearchData;
  If Assigned (eOnInsPressed) then eOnInsPressed (Sender);
end;

procedure TAdvGrid.MyDBSrGridOnCtrlInsPressed (Sender: TObject);
begin
  oDBSrGrid.ResetSearchData;
  If Assigned (eOnCtrlInsPressed) then eOnCtrlInsPressed (Sender);
end;

procedure TAdvGrid.MyDBSrGridOnModPressed (Sender: TObject);
begin
  oDBSrGrid.ResetSearchData;
  If Assigned (eOnModPressed) then eOnModPressed (Sender);
end;

procedure TAdvGrid.MyDBSrGridOnSelected (Sender: TObject);
begin
  oDBSrGrid.ResetSearchData;
  If Assigned (eOnSelected) then eOnSelected (Sender);
end;

procedure TAdvGrid.MyDBSrGridOnSrchKeyDown (Sender: TObject; var Key: Word; Shift: TShiftState);
begin
  SetShortCutTabSet (Key,Shift);
  If Assigned(eOnKeyDown) then eOnKeyDown (Self, Key, Shift);
end;

procedure TAdvGrid.MyDBSrGridOnFocusedChange (Sender: TObject);
begin
  If Assigned (eOnFocusedChange) then eOnFocusedChange (Sender);
end;

procedure TAdvGrid.MyWriteCelText (pField:TField;var pText:string);
begin
  If Assigned (eOnWriteCelText) then eOnWriteCelText (pField,pText);
end;

procedure TAdvGrid.MyDBSrGridOnGridChange (Sender: TObject);
begin
  oGridChange:=TRUE;
end;

procedure TAdvGrid.MyOnDrawColorRow (Sender:TObject;var pColorRow:TColor; pField:TField;pFirstFld:boolean);
begin
  pColorRow:=oColorRow;
  If Assigned (eOnDrawColorRow) then eOnDrawColorRow (Sender, pColorRow, pField, pFirstFld);
  oColorRow:=pColorRow;
end;

procedure TAdvGrid.MyOnSelChange (Sender: TObject;pSelRecQnt:longint);
begin
  oSelRecQnt:=pSelRecQnt;
  If (oSelTable.TableName='') and (oDBSrGrid.oSelTable.TableName<>'') then begin
    oDBSrGrid.SetSelTableParam (oSelTable);
    oSelTable.Active:=TRUE;
  end;
  If oSelTable.Active then oSelTable.Refresh; 
  SetPositions;
  ShowRecordCount;
end;

procedure TAdvGrid.MyOnResize (Sender: TObject);
begin
  SetPositions;
end;

procedure TAdvGrid.MyHeadFontChange (Sender: TObject);
begin
  SetPositions;
  Repaint;
end;
(*
procedure TAdvGrid.MyDataSourceDataChange;
begin
  ShowRecordCount;
end;
*)
procedure TAdvGrid.MyTabSetOnChange (Sender: TObject; NewTab: Integer; var AllowChange: Boolean);
var mTabSetName:ShortString;
begin
  If oTabSet.TabIndex>=0 then begin
//    WriteActGrid;
    If oGridSet.VerifyListItName (oGridSet.GetListItName (NewTab)) then begin
        LoadGridSet (oGridSet.GetListItName (NewTab));
      end else begin
        If oTabSet.TabIndex>=0 then AllowChange:=FALSE;
      end;
    If Assigned (eOnTabSetChanged) then begin
      mTabSetName:=oGridSet.GetListItName (NewTab);
      eOnTabSetChanged (Sender,mTabSetName);
    end;
  end;
end;

procedure TAdvGrid.MyDataSetAfterOpen (DataSet: TDataSet);
begin
  try
    If DataSet.Active then begin
//      LoadGridSet (oGridSet.GetListItName (oTabSet.TabIndex));
      oLastOpenWin:='';
      VerifyDefGridSet;
      If oTabSet<>nil then FillTabSet (oTabSet.TabIndex);
      If FixIndexFields='' then ReadActSettings;
    end;
  except end;
end;

procedure TAdvGrid.MyDataSetBeforeClose (DataSet: TDataSet);
begin
  oDBSrGrid.ActualizedGrid:=FALSE;
  WriteActSettings;
end;

procedure TAdvGrid.MyOnMouseUp (Sender: TObject; Button: TMouseButton ; Shift: TShiftState; X, Y: Integer);
begin
  oDBSrGrid.SetDBGridFocus;
end;

procedure TAdvGrid.MyOnEnter (Sender: TObject);
begin
  oDBSrGrid.SetDBGridFocus;
end;

procedure TAdvGrid.MyTabsPopup (Sender: TObject);
var
  mS:string;
  mOK:boolean;
begin
  mOK:=FALSE;
  If oServiceMode
  then mOK:=TRUE
  else begin
    If oTabSet.TabIndex>=0 then begin
      mS:=oTabSet.Tabs.Strings[oTabSet.TabIndex];
      mOK:=(Copy (mS,1,1)='U');
    end;
  end;
  oTabPopup.Items.Items[1].Enabled:=oGridChange;
  oTabPopup.Items.Items[2].Enabled:=mOK and oGDChange;
end;

function  TAdvGrid.GetEnabled:boolean;
begin
  GetEnabled:=oDBSrGrid.Enabled;
end;

procedure TAdvGrid.SetEnabled (Value:boolean);
begin
  oDBSrGrid.Enabled:=Value;
  oHead.Enabled:=Value;
  oPanel.Enabled:=Value;
  oRecQnt.Enabled:=Value;
  oTabSet.Enabled:=Value;
end;

function  TAdvGrid.GetReadOnly:boolean;
begin
  GetReadOnly:=oDBSrGrid.ReadOnly;
end;

procedure TAdvGrid.SetReadOnly (Value:boolean);
begin
  oDBSrGrid.ReadOnly:=Value;
end;

function  TAdvGrid.GetMultiSelect:boolean;
begin
  GetMultiSelect:=oDBSrGrid.MultiSelect;
end;

procedure TAdvGrid.SetMultiSelect (Value:boolean);
begin
  oDBSrGrid.MultiSelect:=Value;
end;

function  TAdvGrid.GetPopup:TPopupMenu;
begin
  GetPopup:=oDBSrGrid.PopupMenu;
end;

procedure TAdvGrid.SetPopup (Value:TPopupMenu);
begin
  oDBSrGrid.PopupMenu:=Value;
end;

function  TAdvGrid.GetMarkData:TMarkData;
begin
  GetMarkData:=oDBSrGrid.MarkData;
end;

procedure TAdvGrid.SetMarkData (Value:TMarkData);
begin
  oDBSrGrid.MarkData:=Value;
end;

function  TAdvGrid.GetIndexColor:TIndexColor;
begin
  GetIndexColor:=oDBSrGrid.IndexColor;
end;

procedure TAdvGrid.SetIndexColor (Value:TIndexColor);
begin
  oDBSrGrid.IndexColor:=Value;
end;

function  TAdvGrid.GetFixIndexFields:string;
begin
  If oDBSrGrid<>nil then GetFixIndexFields:=oDBSrGrid.FixIndexFields;
end;

procedure TAdvGrid.SetFixIndexFields (Value:string);
begin
  oDBSrGrid.FixIndexFields:=Value;
end;

function  TAdvGrid.GetActIndexFields:string;
begin
  GetActIndexFields:=oDBSrGrid.ActIndexFields;
end;

procedure TAdvGrid.SetActIndexFields (Value:string);
begin
  oDBSrGrid.ActIndexFields:=Value;
end;

function  TAdvGrid.GetActIndexDispText:string;
begin
  GetActIndexDispText:=oDBSrGrid.ActIndexFields;
end;

procedure TAdvGrid.SetActIndexDispText (Value:string);
begin
  oDBSrGrid.ActIndexFields:=Value;
end;

function  TAdvGrid.GetEnableMultiSelect:boolean;
begin
  GetEnableMultiSelect:=oDBSrGrid.EnableMultiSelect;
end;

procedure TAdvGrid.SetEnableMultiSelect (pValue:boolean);
begin
  oDBSrGrid.EnableMultiSelect:=pValue;
end;

function  TAdvGrid.GetBevelOuter:TBevelCut;
begin
  GetBevelOuter:=inherited BevelOuter;
end;

procedure TAdvGrid.SetBevelOuter (Value:TBevelCut);
begin
  inherited BevelOuter:=Value;
  SetPositions;
end;

function  TAdvGrid.GetBevelInner:TBevelCut;
begin
  GetBevelInner:=inherited BevelInner;
end;

procedure TAdvGrid.SetBevelInner (Value:TBevelCut);
begin
  inherited BevelInner:=Value;
  SetPositions;
end;

function  TAdvGrid.GetBorderWidth:integer;
begin
  GetBorderWidth:=inherited BorderWidth;
end;

procedure TAdvGrid.SetBorderWidth (Value:integer);
begin
  inherited BorderWidth:=Value;
  SetPositions;
end;

function  TAdvGrid.GetBevelWidth:integer;
begin
  GetBevelWidth:=inherited BevelWidth;
end;

procedure TAdvGrid.SetBevelWidth (Value:integer);
begin
  inherited BevelWidth:=Value;
  SetPositions;
end;

function TAdvGrid.GetFixSrchField: string;
begin
  Result:=oDBSrGrid.FixSrchField;
end;

procedure TAdvGrid.SetFixSrchField(const Value: string);
begin
  oDBSrGrid.FixSrchField:=Value;
end;

end.
