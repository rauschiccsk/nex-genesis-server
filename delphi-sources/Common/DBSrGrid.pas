unit DBSrGrid;

interface

uses
  BtrTable, NexPath, ProcInd_, Variants,
  IcDate, IcVariab, FreeExcelSylk,
  DbSrGrid_GridSum, MarkGrid,
  IcConv, IcTools, CompTxt, FileCtrl,
  Menus, Grids, DB, DBTables, DBGrids, StdCtrls, Graphics,
  Windows, Messages, SysUtils, Classes, Controls, Forms, Dialogs;

type
  TSelChangeEvent = procedure (Sender: TObject;pSelRecQnt:longint) of object;

  TRangeValues = array[1..10] of string;

//28.9.2016 Tibi - TFldReadOnly po4et poloziek som zvysil z 200 na 400
  TFldReadOnly = array [1..400] of record
                   Fld     : string;
                   ReadOnly: boolean;
                 end;

  TIndexColor = class (TGraphicsObject)
  private
    oIndexBadColor  : TColor;
    oIndexEmptyColor: TColor;
    oIndexFindColor : TColor;
    oIndexSelColor  : TColor;

    eOnChange       : TNotifyEvent;

    procedure SetIndexBadColor (Value:TColor);
    procedure SetIndexEmptyColor (Value:TColor);
    procedure SetIndexFindColor (Value:TColor);
    procedure SetIndexSelColor (Value:TColor);
    { Private declarations }
  public
    constructor Create;
    destructor  Destroy; override;
    { Public declarations }
  published
    property IndexBadColor:TColor read oIndexBadColor write SetIndexBadColor;
    property IndexEmptyColor:TColor read oIndexEmptyColor write SetIndexEmptyColor;
    property IndexFindColor:TColor read oIndexFindColor write SetIndexFindColor;
    property IndexSelColor:TColor read oIndexSelColor write SetIndexSelColor;

    property OnChange:TNotifyEvent read eOnChange write eOnChange;
  end;

  TDBSrchGrid = class(TWinControl)
    oDBGrid      : TMarkGrid;
    oStringGrid  : TStringGrid;
    oPMIndex     : TMenuItem;
    procedure  IndexChange (Sender: TObject);
    procedure  MyPMIndexOnClick (Sender: TObject);
    procedure  SummaryAllClick(Sender: TObject);
    procedure  SummaryFromClick(Sender: TObject);
    procedure  SummaryToClick(Sender: TObject);

    procedure  SummarySelClick(Sender: TObject);
    procedure  SelActClick(Sender: TObject);
    procedure  SelAllClick(Sender: TObject);
    procedure  DeselAllClick(Sender: TObject);

    procedure  CopyToClipboardClick(Sender: TObject);
    procedure  CopyToXLSClick(Sender: TObject);
  private
//komponenty
    oDataSource  : TDataSource;
    oButt        : TButton;
    oAllIndexs   : TStringList;
    oActIndexs   : TStringList;

    oBorderStyle : TBorderStyle;
    oFixSrchField: string;
    oFixIndexFields: string;
    oActIndexFields: string;
    oActIndexDispText: string;
    oSetData     : TRangeValues;
    oSelFldQnt   : integer;
    oActIndex    : integer;
    oStrGridColor: array [0..250] of TColor;
    eOnChangeIndex: TNotifyEvent;
    oLastPrevIndex:string;
    oDataRange   : TRangeValues;
    oFixData     : byte;
    oTabStop     : boolean;
    oSearchLnClear  : boolean;
    oSearchLnFocused: boolean;
    oOnlyOneIndex: string;

    eOnDataChange: TDataChangeEvent;
    eOnSelected  : TNotifyEvent;
    eOnEscPressed: TNotifyEvent;
    eOnColExit   : TNotifyEvent;
    eOnColEnter  : TNotifyEvent;
    eOnDrawColumnCell  : TDrawColumnCellEvent;
    eOnInsPressed: TNotifyEvent;
    eOnCtrlInsPressed: TNotifyEvent;
    eOnModPressed: TNotifyEvent;
    eOnDelPressed: TNotifyEvent;
    eOnCtrlDelPressed: TNotifyEvent;
    eOnF3Pressed  : TNotifyEvent;
    eOnF7Pressed  : TNotifyEvent;
    eOnCRPressed  : TNotifyEvent;
    eOnKeyDown    : TKeyEvent;
    eOnSrchKeyDown: TKeyEvent;
    eOnGridChange : TNotifyEvent;
    eOnDrawColorRow: TDrawColorRowEvent;
    eOnFocusedChange: TNotifyEvent;
    eOnSelChange  : TSelChangeEvent; 

    oMouseX       : integer;
    oMouseY       : integer;

    oRange        : array of TVarRec;
    oIndexColor   : TIndexColor;

    oPopupMenu    : TPopupMenu;
    ePopupMenu    : TPopupMenu;
    oFillDefPopup : boolean;
    oBefState     : TDataSetState;
    oActualizedGrid:boolean;
    oEnableMultiSelect:boolean;
    oFindBegin    : boolean;

    procedure SetFont (Value:TFont);
    function  GetFont:TFont;
    procedure SetDataSet(Value: TDataSet);
    function  GetDataSet: TDataSet;
    procedure SetBorderStyle(Value: TBorderStyle);
    procedure CMCtl3DChanged(var Message: TMessage); message CM_CTL3DCHANGED;

    procedure DataSourceAfterOpen (DataSet: TDataSet);

    procedure StringGridOnEnter (Sender: TObject);
    procedure StringGridOnExit (Sender: TObject);
    procedure StringGridTopLeftChanged (Sender: TObject);
    procedure StringGridKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure StringGridKeyPress (Sender: TObject; var Key: Char);
    procedure StringGridRightPress;
    procedure StringGridLeftPress;
    procedure StringGridBackPress;
    procedure StringGridCtrlBackPress;
    procedure StringGridMouseUp(Sender: TObject; Button: TMouseButton;Shift: TShiftState; X, Y: Integer);

    procedure DBGridOnEnter (Sender: TObject);
    procedure DBGridOnColEnter (Sender: TObject);
    procedure DBGridOnDrawColumnCell (Sender: TObject; const Rect: TRect; DataCol: Integer; Column: TColumn; State: TGridDrawState);
    procedure DBGridColumnMoved(Sender: TObject; FromIndex, ToIndex: Integer);
    procedure DBSrGridResize (Sender: TObject);
    procedure DBGridColWidthsChanged (Sender: TObject);
    procedure DBGridKeyPress (Sender: TObject; var Key: Char);
    procedure DBGridKeyDown (Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure DBGridMouseUp (Sender: TObject; Button: TMouseButton;Shift: TShiftState; X, Y: Integer);
    procedure DBGridMouseDblClick (Sender: TObject);

    function  MyGetSelectedRow:boolean;
    procedure MyOnMouseWheelDown (Sender: TObject; Shift: TShiftState; MousePos: TPoint; var Handled: Boolean);
    procedure MyOnMouseWheelUp (Sender: TObject; Shift: TShiftState; MousePos: TPoint; var Handled: Boolean);

    procedure SetCompParam;

    procedure ReadIndexs;
    procedure GetIndexPosition (var pInd:string;pFields:string);
    function  FindFieldInGrid (pFld:string;var pNum:integer):boolean;
    function  CutLastCol (pFld:string):string;
    procedure SetNextIndexFields (pSelectedFlds:string);
    procedure SetIndexField;
    procedure SetIndexColor;
    procedure SetPopupMenu (Value:TPopupMenu);
    procedure SetTabStop (Value:boolean);

    procedure FindData (pStr:string);

    procedure ClearSearchData;
    procedure StringGridDrawCell (Sender: TObject; ACol, ARow: Longint; Rect: TRect; State: TGridDrawState);
    procedure ReDrawStringGrid;

    procedure SetDBGridReadOnly (pValue:boolean);

    procedure FillFixData;

    function  GetMarkData: TMarkData;
    procedure SetMarkData (Value:TMarkData);

    function  GetImageParams: String;
    procedure SetImageParams (Value:String);

    procedure MyOnColExit (Sender: TObject);
    procedure MyDataChange (Sender: TObject; Field: TField);
    procedure AddPopupIndex;
    procedure FillDefPopupMenu (Sender: TObject);
    procedure RemoveDefItemsInPopup;
    function  VerifyFindData (var pRV:TRangeValues):boolean;
    function  CutFldInSrchFld (pFld:string):string;

    procedure MyButtOnClick (Sender: TObject);
    procedure MyOnEnter (Sender: TObject);
    procedure MyOnExit (Sender: TObject);
    procedure MyOnDBGridStateChange (Sender: TObject);
    procedure MyIndexColorOnChange (Sender: TObject);
    procedure MyOnDrawColorRow (Sender:TObject;var pColorRow:TColor; pField:TField;pFirstFld:boolean);

    procedure ShowSumData (pSumType:TSumType);
    procedure CalcSumAll  (pFld:string; var pIt:integer;var pVal,pMin,pMax:double);
    procedure CalcSumTo   (pFld:string; var pIt:integer;var pVal,pMin,pMax:double);
    procedure CalcSumFrom (pFld:string; var pIt:integer;var pVal,pMin,pMax:double);

    procedure CreateSelectTable;
    procedure ActRecSelect;
    procedure AllRecSelect;
    procedure AllRecDeselect;
    function  DataInSelTable:boolean;

    procedure CalcSelSum(pFld:string; var pIt:integer;var pVal,pMin,pMax:double);
    procedure ShowSelSum;

    procedure FillFixSrchFld;
    procedure RepaintGrid;
    { Private declarations }
  protected
    procedure CreateParams(var Params: TCreateParams); override;
    procedure Notification(AComponent: TComponent; Operation: TOperation); override;
    { Protected declarations }
  public
    oDBGridReadOnly: boolean;
    oDBGridMultiSelect: boolean;
    oFldReadOnly: TFldReadOnly;
    oFldQnt     : longint;
    oDelEnabled : boolean;
    oSelTable: TTable;

    constructor Create(AOwner: TComponent); override;
    destructor  Destroy; override;

    procedure AddDataToSelTable;
    procedure SetSelTableParam (pTable:TTable);
    procedure ResetSearchData;

    procedure RefreshGrid;
    procedure SetExtIndexName (pIndex:string);
    procedure SetRange (const pRV:array of const);
    procedure SetRangeS (const pRV1,pRV2:array of const);
    procedure SetDBGridFocus;

    function  GetFldReadOnly (pFld:string):boolean;

    function  GetIndexs:TIndexDefs;
    procedure SetIndexName (pIndexName:string);
    function  GetIndexName:string;
    procedure FindNearest(pDataSet: TDataSet; pIndexSegment: integer;pRV:TRangeValues);
    procedure CalcSum (pSumType:TSumType;pFld:string;var pIt:integer;var pVal,pMin,pMax:double);

    { Public declarations }
  published
    property EnableMultiSelect:boolean read oEnableMultiSelect write oEnableMultiSelect;
    property GridFont:TFont read GetFont write SetFont;
    property Align;

    property Ctl3D;
    property DataSet: TDataSet read GetDataSet write SetDataSet;
    property BorderStyle: TBorderStyle read oBorderStyle write SetBorderStyle default bsSingle;
    property TabOrder;

    property TabStop:boolean read oTabStop write SetTabStop;
    property SearchLnClear:boolean read oSearchLnClear write oSearchLnClear;

    property FixSrchField:string read oFixSrchField write oFixSrchField;
    property FixIndexFields:string read oFixIndexFields write oFixIndexFields;
    property ActIndexFields:string read oActIndexFields write oActIndexFields;
    property ActIndexDispText:string read oActIndexDispText write oActIndexDispText;
    property OnChangeIndex:TNotifyEvent read eOnChangeIndex write eOnChangeIndex;
    property ReadOnly: boolean read oDBGridReadOnly write SetDBGridReadOnly;
    property MultiSelect: boolean read oDBGridMultiSelect write oDBGridMultiSelect;
    property SearchLnFocused: boolean read oSearchLnFocused write oSearchLnFocused;
    property OnlyOneIndex:string read oOnlyOneIndex write oOnlyOneIndex;

    property IndexColor: TIndexColor read oIndexColor write oIndexColor;
    property PopupMenu:TPopupMenu read ePopupMenu write SetPopupMenu;

    property Enabled;

    property ActualizedGrid:boolean read oActualizedGrid write oActualizedGrid;
    property MarkData:TMarkData read GetMarkData write SetMarkData;
    property ImageParams:String read GetImageParams write SetImageParams;
    property OnSelected: TNotifyEvent read eOnSelected write eOnSelected;
    property OnEscPressed: TNotifyEvent read eOnEscPressed write eOnEscPressed;
    property OnColExit: TNotifyEvent read eOnColExit write eOnColExit;
    property OnColEnter: TNotifyEvent read eOnColEnter write eOnColEnter;
    property OnDrawColumnCell: TDrawColumnCellEvent read eOnDrawColumnCell write eOnDrawColumnCell;
    property OnInsPressed: TNotifyEvent read eOnInsPressed write eOnInsPressed;
    property OnCtrlInsPressed: TNotifyEvent read eOnCtrlInsPressed write eOnCtrlInsPressed;
    property OnModPressed: TNotifyEvent read eOnModPressed write eOnModPressed;
    property OnDelPressed: TNotifyEvent read eOnDelPressed write eOnDelPressed;
    property OnCtrlDelPressed: TNotifyEvent read eOnCtrlDelPressed write eOnCtrlDelPressed;
    property OnF3Pressed: TNotifyEvent read eOnF3Pressed write eOnF3Pressed;
    property OnF7Pressed: TNotifyEvent read eOnF7Pressed write eOnF7Pressed;
    property OnCRPressed: TNotifyEvent read eOnCRPressed write eOnCRPressed;
    property OnKeyDown:TKeyEvent read eOnKeyDown write eOnKeyDown;
    property OnSrchKeyDown:TKeyEvent read eOnSrchKeyDown write eOnSrchKeyDown;
    property OnDataChange:TDataChangeEvent read eOnDataChange write eOnDataChange;
    property OnGridChange:TNotifyEvent read eOnGridChange write eOnGridChange;
    property OnDrawColorRow:TDrawColorRowEvent read eOnDrawColorRow write eOnDrawColorRow;
    property OnFocusedChange:TNotifyEvent read eOnFocusedChange write eOnFocusedChange;
    property OnSelChange:TSelChangeEvent read eOnSelChange write eOnSelChange;

    { Published declarations }
  end;

procedure Register;

implementation

procedure Register;
begin
  RegisterComponents('Wirt', [TDBSrchGrid]);
end;


constructor TIndexColor.Create;
begin
  inherited Create;
  oIndexBadColor   := clRed;
  oIndexEmptyColor := clWindow;
  oIndexFindColor  := clLime;
  oIndexSelColor   := clYellow;
end;

destructor TIndexColor.Destroy;
begin
  inherited Destroy;
end;

procedure TIndexColor.SetIndexBadColor (Value:TColor);
begin
  oIndexBadColor := Value;
  If Assigned (eOnChange) then eOnChange (Self);
end;

procedure TIndexColor.SetIndexEmptyColor (Value:TColor);
begin
  oIndexEmptyColor := Value;
  If Assigned (eOnChange) then eOnChange (Self);
end;

procedure TIndexColor.SetIndexFindColor (Value:TColor);
begin
  oIndexFindColor := Value;
  If Assigned (eOnChange) then eOnChange (Self);
end;

procedure TIndexColor.SetIndexSelColor (Value:TColor);
begin
  oIndexSelColor := Value;
  If Assigned (eOnChange) then eOnChange (Self);
end;

// ******* public *******

constructor TDBSrchGrid.Create(AOwner: TComponent);
var I:longint;
begin
  inherited Create(AOwner);
  inherited TabStop := FALSE;
  oSearchLnClear:= TRUE;
//Nastavenia základného panelu TWinControl
  Width       := 320;
  Height      := 163;
  oBorderStyle := bsSingle;
  OnEnter      := MyOnEnter;
  OnExit       := MyOnExit;
  OnResize     := DBSrGridResize;
  eOnSelected   := nil;
  eOnEscPressed := nil;

  oActualizedGrid := TRUE;
  oDelEnabled := TRUE;

  oPopupMenu := TPopupMenu.Create (Self);
  oPMIndex := TMenuItem.Create (Self);
  oPMIndex := NewSubMenu (ctDBSrGrid_Index,0,'Indexs',oPMIndex,TRUE);
  oPMIndex.OnClick := MyPMIndexOnClick;
  oPopupMenu.OnPopup := FillDefPopupMenu;
  oFillDefPopup := FALSE;

  oEnableMultiSelect := FALSE;
  oIndexColor := TIndexColor.Create;
  oIndexColor.OnChange := MyIndexColorOnChange;

//Nastavenia DataSource
  oDataSource := TDataSource.Create (Self);
  oDataSource.OnDataChange := MyDataChange;
//Nastavenia databázovej tabu¾ky
  oDBGrid := TMarkGrid.Create(self);
  oDBGrid.Parent := Self;
  oDBGrid.Name := 'WOGrid';
  oDBGrid.Font.Name := 'Arial';
  oDBGrid.Canvas.Font.Name := 'Arial';
  oDBGrid.TitleFont.Name := 'Arial';
  oDBGrid.BorderStyle := bsNone;
  oDBGrid.Options := [dgEditing, dgTitles, dgIndicator, dgColumnResize, dgColLines, dgRowLines, dgConfirmDelete, dgAlwaysShowSelection, dgCancelOnExit];
  oDBGrid.ScrollBars := ssNone;
  oDBGrid.Focused := FALSE;
  oDBGrid.DataSource := oDataSource;
  oDBGrid.OnColumnMoved := DBGridColumnMoved;
  oDBGrid.OnEnter := DBGridOnEnter;
  oDBGrid.OnColEnter := DBGridOnColEnter;
  oDBGrid.OnDrawColumnCell := DBGridOnDrawColumnCell;
  oDBGrid.OnColWidthsChanged := DBGridColWidthsChanged;
  oDBGrid.OnKeyPress := DBGridKeyPress;
  oDBGrid.OnKeyDown := DBGridKeyDown;
  oDBGrid.OnMouseUp := DBGridMouseUp;
  oDBGrid.OnDblClick := DBGridMouseDblClick;
  oDBGrid.OnColExit  := MyOnColExit;
  oDBGrid.PopupMenu  := oPopupMenu;
  If oSearchLnClear then oDBGrid.RowSelect  := FALSE else oDBGrid.RowSelect  := TRUE;
  oDBGrid.Datasource.OnStateChange := MyOnDBGridStateChange;
  oDBGrid.OnDrawColorRow := MyOnDrawColorRow;
  oDBGrid.OnMouseWheelDown := MyOnMouseWheelDown;
  oDBGrid.OnMouseWheelUp := MyOnMouseWheelUp;
  oDBGrid.OnGetSelectedRow := MyGetSelectedRow;

//Nastavenia vyh¾adávacieho riadku
  oStringGrid := TStringGrid.Create(Self);
  oStringGrid.Parent := Self;
  oStringGrid.Font.Name := 'Arial';
  oStringGrid.Canvas.Font.Name := 'Arial';
  oStringGrid.ColCount := 1;
  oStringGrid.RowCount := 1;
  oStringGrid.FixedCols := 0;
  oStringGrid.FixedRows := 0;
  oStringGrid.RowHeights[0] := 16;
  oStringGrid.Height := 16;
  oStringGrid.BorderStyle := bsNone;
  oStringGrid.Options := [goAlwaysShowEditor, goFixedVertLine, goFixedHorzLine, goDrawFocusSelected, goVertLine, goHorzLine];
  oStringGrid.OnKeyDown := StringGridKeyDown;
  oStringGrid.OnKeyPress := StringGridKeyPress;
  oStringGrid.OnTopLeftChanged := StringGridTopLeftChanged;
  oStringGrid.OnEnter := StringGridOnEnter;
  oStringGrid.OnExit := StringGridOnExit;
  oStringGrid.OnDrawCell := StringGridDrawCell;
  oStringGrid.OnMouseUp := StringGridMouseUp;
  oStringGrid.OnMouseWheelDown := MyOnMouseWheelDown;
  oStringGrid.OnMouseWheelUp := MyOnMouseWheelUp;
//Nastavenia tlaèítka
  oButt := TButton.Create (Self);
  oButt.Parent := Self;
  oButt.TabStop := FALSE;
  oButt.OnClick := MyButtOnClick;
//Zoznam všetkých indexov
  oAllIndexs := TStringList.Create;
  oAllIndexs.Sorted := TRUE;
//Zoznam aktívnych indexov
  oActIndexs := TStringList.Create;
  oActIndexs.Sorted := TRUE;

  oSelTable := TTable.Create(Self);

  ClearSearchData;

  oFixSrchField := '';
  oFixIndexFields := '';
  oSelFldQnt := 0;
  oActIndex := 1;
  oActIndexFields := '';
  oActIndexDispText := '';
  oLastPrevIndex := '';

  oDBGridReadOnly    := FALSE;
  oDBGridMultiSelect := FALSE;

  For I:=1 to 10 do
    oDataRange[I] := '';

  For I:=0 to 250 do
    oStrGridColor[I] := oIndexColor.oIndexEmptyColor;

  oFixData := 0;
  oStringGrid.TabStop := FALSE;

  oFldQnt := 0;
  For I:=1 to 400 do begin
    oFldReadOnly[I].Fld := '';
    oFldReadOnly[I].ReadOnly := FALSE;
  end;

  oBefState := dsInactive;
end;

destructor  TDBSrchGrid.Destroy;
begin
  If oDataSource.DataSet<>nil then oDataSource.DataSet.AfterOpen := nil;
  oPMIndex.Free;
  oPopupMenu.Free;
  If oSelTable.TableName<>'' then begin
    If oSelTable.Exists then begin
      If oSelTable.Active then oSelTable.Active := FALSE;
      try oSelTable.DeleteTable; except end;
    end;
  end;

  FreeAndNil (oDataSource);
  FreeAndNil (oDBGrid);
  FreeAndNil (oButt);
  FreeAndNil (oAllIndexs);
  FreeAndNil (oActIndexs);
  FreeAndNil (oIndexColor);
  FreeAndNil (oStringGrid);
  FreeAndNil (oSelTable);
  inherited Destroy;
end;

procedure TDBSrchGrid.SetSelTableParam (pTable:TTable);
begin
  pTable.TableName := oSelTable.TableName;
  pTable.DatabaseName := oSelTable.DatabaseName;
  pTable.IndexName := oSelTable.IndexName;
end;

procedure TDBSrchGrid.ResetSearchData;
var mNum:longint;
begin
  ClearSearchData;
  If oActIndexs.Count>0 then begin
//    If FindFieldInGrid (CutLastCol (oActIndexs.Strings[oActIndex-1]),mNum) then oStringGrid.Col := mNum;
    FillFixSrchFld;
    SetIndexColor;
    ReDrawStringGrid;
  end;
end;

procedure   TDBSrchGrid.RefreshGrid;
var mIndex:longint;
begin
  If oDBGrid.DataSource.DataSet<>nil then begin
    mIndex := oActIndex;
    SetCompParam;
    ReadIndexs;
    oActIndex := mIndex;
    SetIndexField;
    ResetSearchData;
  end;
end;

procedure   TDBSrchGrid.SetExtIndexName (pIndex:string);
var
  mS:string;
  mName:string;
  mOK:boolean;
  I:integer;
begin
  If oDBGrid.DataSource.DataSet<>nil then begin
    SetCompParam;
    ReadIndexs;
    mOK := FALSE;
    I := 0;
//12.05.2010 Tibi - upravené nastavenie viac segmentových indexov
//    While (I<oAllIndexs.Count) and not mOK do begin
//      mS := oAllIndexs.Strings[I];
//      mName := Copy (mS,Pos ('*',mS)+1,Pos ('|',mS)-Pos ('*',mS)-1);
//      mOK := (mName=pIndex);
//      If not mOk then Inc (I);
//    end;
    While (I<oActIndexs.Count) and not mOK do begin
      mS := oActIndexs.Strings[I];
      mName := Copy (mS,Pos ('*',mS)+1,Pos ('|',mS)-Pos ('*',mS)-1);
      mOK := (mName=pIndex);
      If not mOk then Inc (I);
    end;
    If mOK
      then oActIndex := I+1
      else oActIndex := 1;
    SetIndexField;
  end;
end;

procedure   TDBSrchGrid.SetRange (const pRV:array of const);
var
  I:byte;
  mNum:integer;
  mS,mFld:string;
begin
  oFixData := 0;
  If High (pRV)<255 then begin
    oFixData := High (pRV)+1;
    SetLength (oRange,High (pRV)+1);
    FillTVarRec (pRV,oRange);
    (oDBGrid.DataSource.DataSet as TTable).CancelRange;
    (oDBGrid.DataSource.DataSet as TTable).SetRange (oRange,oRange);
    SetCompParam;
    For I:=1 to 10 do begin
      oDataRange[I] := '';
      oSetData[I] := '';
    end;
    mS := '';
    If oActIndexs.Count>0 then mS := oActIndexs.Strings[oActIndex-1];
    mS := Copy (mS,Pos ('|',mS)+1,Length (mS));
    For I:=1 to oFixData do begin
      oDataRange[I] := VarDataAsString (pRV,I);
      oSetData[I] := oDataRange[I];
      CutNextParamSepar (mS,mFld,';');
      If FindFieldInGrid (mFld,mNum) then oStringGrid.Cells[mNum,0] := oSetData[I];
    end;
    oSelFldQnt := oFixData+1;
    If oActIndexs.Count>0 then FindData ('');
  end;
end;

procedure   TDBSrchGrid.SetRangeS (const pRV1,pRV2:array of const);
var
  I:byte;
  mNum:integer;
  mS,mFld:string;
  mRange2: array of TVarRec;
begin
  If (oDBGrid.DataSource.DataSet<>nil) and (oDBGrid.DataSource.DataSet.Active ) then begin
    oFixData := 0;
    If High (pRV1)<255 then begin
      oFixData := High (pRV1)+1;
      SetLength (oRange,High (pRV1)+1);
      SetLength (mRange2,High (pRV2)+1);
      FillTVarRec (pRV1,oRange);
      FillTVarRec (pRV2,mRange2);
      (oDBGrid.DataSource.DataSet as TTable).CancelRange;
      (oDBGrid.DataSource.DataSet as TTable).SetRange (oRange,mRange2);
      SetCompParam;
      For I:=1 to 10 do begin
        oDataRange[I] := '';
        oSetData[I] := '';
      end;
      If oActIndexs.Count>0 then mS := oActIndexs.Strings[oActIndex-1];
      mS := Copy (mS,Pos ('|',mS)+1,Length (mS));
      For I:=1 to oFixData do begin
        oDataRange[I] := VarDataAsString (pRV1,I);
        oSetData[I] := oDataRange[I];
        CutNextParamSepar (mS,mFld,';');
        If FindFieldInGrid (mFld,mNum) then oStringGrid.Cells[mNum,0] := oSetData[I];
      end;
      oSelFldQnt := oFixData+1;
    end;
    If oActIndexs.Count>0 then FindData ('');
  end;
end;

procedure   TDBSrchGrid.SetDBGridFocus;
begin
  oDBGrid.EditorMode := FALSE;
  oDBGrid.Focused := TRUE;
  SetIndexColor;
  oStringGrid.TabStop := FALSE;
  oDBGrid.TabStop := TRUE;
  oDBGrid.Repaint;
  ReDrawStringGrid;
  If Visible then oStringGrid.SetFocus;
//  oDBGrid.SetFocus;
//Vypnuté Tibi 21.10.2009 - Aby fókusoval hned na Grid  oStringGrid.SetFocus;
end;

function  TDBSrchGrid.GetFldReadOnly (pFld:string):boolean;
var
  mFind:boolean;
  I:longint;
begin
  I := 1;
  mFind := FALSE;
  pFld := UpString (pFld);
  Result := FALSE;
  While (I<=oFldQnt) and not mFind do begin
    mFind := UpString (oFldReadOnly[I].Fld)=pFld;
    If mFind then Result := oFldReadOnly[I].ReadOnly;
    Inc (I);
  end;
end;

function   TDBSrchGrid.GetIndexs:TIndexDefs;
begin
  If oDBGrid.DataSource.DataSet is TBtrieveTable then begin
    If oDBGrid.DataSource.DataSet<>nil then begin
      (oDBGrid.DataSource.DataSet as TBtrieveTable).IndexDefs.Update;
      Result := (oDBGrid.DataSource.DataSet as TBtrieveTable).IndexDefs;
    end;
  end else begin
    If oDBGrid.DataSource.DataSet<>nil then begin
      If (oDBGrid.DataSource.DataSet as TTable).Exists then begin
        try
          (oDBGrid.DataSource.DataSet as TTable).IndexDefs.Update;
        except end;
        Result := (oDBGrid.DataSource.DataSet as TTable).IndexDefs;
      end else Result := nil;
    end else Result := nil;
  end;
end;

procedure   TDBSrchGrid.SetIndexName (pIndexName:string);
begin
  If oDBGrid.DataSource.DataSet is TBtrieveTable then begin
    If oDBGrid.DataSource.DataSet<>nil then begin
      (oDBGrid.DataSource.DataSet as TBtrieveTable).IndexName := pIndexName;
    end;
  end else begin
    If oDBGrid.DataSource.DataSet<>nil then begin
      (oDBGrid.DataSource.DataSet as TTable).IndexName := pIndexName;
    end;
  end;
end;

function    TDBSrchGrid.GetIndexName:string;
begin
  If oDBGrid.DataSource.DataSet is TBtrieveTable then begin
    If oDBGrid.DataSource.DataSet<>nil then begin
      Result := (oDBGrid.DataSource.DataSet as TBtrieveTable).IndexName;
    end;
  end else begin
    If oDBGrid.DataSource.DataSet<>nil then Result := (oDBGrid.DataSource.DataSet as TTable).IndexName;
  end;
end;

procedure TDBSrchGrid.FindNearest(pDataSet: TDataSet; pIndexSegment: integer;pRV:TRangeValues);
begin
  If oDBGrid.DataSource.DataSet is TBtrieveTable then begin
    If oDBGrid.DataSource.DataSet<>nil then begin
      case pIndexSegment of
        1 : (pDataSet as TBtrieveTable).FindNearest([pRV[1]]);
        2 : (pDataSet as TBtrieveTable).FindNearest([pRV[1],pRV[2]]);
        3 : (pDataSet as TBtrieveTable).FindNearest([pRV[1],pRV[2],pRV[3]]);
        4 : (pDataSet as TBtrieveTable).FindNearest([pRV[1],pRV[2],pRV[3],pRV[4]]);
        5 : (pDataSet as TBtrieveTable).FindNearest([pRV[1],pRV[2],pRV[3],pRV[4],pRV[5]]);
        6 : (pDataSet as TBtrieveTable).FindNearest([pRV[1],pRV[2],pRV[3],pRV[4],pRV[5],pRV[6]]);
        7 : (pDataSet as TBtrieveTable).FindNearest([pRV[1],pRV[2],pRV[3],pRV[4],pRV[5],pRV[6],pRV[7]]);
        8 : (pDataSet as TBtrieveTable).FindNearest([pRV[1],pRV[2],pRV[3],pRV[4],pRV[5],pRV[6],pRV[7],pRV[8]]);
        9 : (pDataSet as TBtrieveTable).FindNearest([pRV[1],pRV[2],pRV[3],pRV[4],pRV[5],pRV[6],pRV[7],pRV[8],pRV[9]]);
        10: (pDataSet as TBtrieveTable).FindNearest([pRV[1],pRV[2],pRV[3],pRV[4],pRV[5],pRV[6],pRV[7],pRV[8],pRV[9],pRV[10]]);
      end;
    end;
  end else begin
    If oDBGrid.DataSource.DataSet<>nil then begin
      case pIndexSegment of
        1 : (pDataSet as TTable).FindNearest([pRV[1]]);
        2 : (pDataSet as TTable).FindNearest([pRV[1],pRV[2]]);
        3 : (pDataSet as TTable).FindNearest([pRV[1],pRV[2],pRV[3]]);
        4 : (pDataSet as TTable).FindNearest([pRV[1],pRV[2],pRV[3],pRV[4]]);
        5 : (pDataSet as TTable).FindNearest([pRV[1],pRV[2],pRV[3],pRV[4],pRV[5]]);
        6 : (pDataSet as TTable).FindNearest([pRV[1],pRV[2],pRV[3],pRV[4],pRV[5],pRV[6]]);
        7 : (pDataSet as TTable).FindNearest([pRV[1],pRV[2],pRV[3],pRV[4],pRV[5],pRV[6],pRV[7]]);
        8 : (pDataSet as TTable).FindNearest([pRV[1],pRV[2],pRV[3],pRV[4],pRV[5],pRV[6],pRV[7],pRV[8]]);
        9 : (pDataSet as TTable).FindNearest([pRV[1],pRV[2],pRV[3],pRV[4],pRV[5],pRV[6],pRV[7],pRV[8],pRV[9]]);
        10: (pDataSet as TTable).FindNearest([pRV[1],pRV[2],pRV[3],pRV[4],pRV[5],pRV[6],pRV[7],pRV[8],pRV[9],pRV[10]]);
      end;
    end;
  end;
end;


procedure TDBSrchGrid.IndexChange (Sender: TObject);
var I:integer;
begin
  oActIndex := (Sender as TMenuItem).MenuIndex+1;
  oLastPrevIndex := oAllIndexs.Strings[oActIndex-1];
  SetNextIndexFields (oFixIndexFields);
  I := 0;
  oActIndex := 0;
  While (I<oActIndexs.Count) and (oActIndex=0) do begin
    If oActIndexs.Strings[I]=oLastPrevIndex then oActIndex := I+1;
    Inc (I);
  end;
  SetIndexField;
  oSearchLnFocused := TRUE;
  If Assigned (eOnFocusedChange) then eOnFocusedChange (Sender);
  oStringGrid.SetFocus;
  FillFixSrchFld;
end;

// ******* protected *******

procedure TDBSrchGrid.CreateParams(var Params: TCreateParams);
const BorderStyles: array[TBorderStyle] of DWORD = (0, WS_BORDER);
begin
  inherited CreateParams(Params);
  with Params do begin
    Style := Style or BorderStyles[oBorderStyle];
    If NewStyleControls and Ctl3D and (oBorderStyle = bsSingle) then begin
      Style := Style and not WS_BORDER;
      ExStyle := ExStyle or WS_EX_CLIENTEDGE;
    end;
  end;
end;

// ******* private *******


procedure TDBSrchGrid.SetFont (Value:TFont);
begin
  oDBGrid.Font := Value;
end;

function  TDBSrchGrid.GetFont:TFont;
begin
  Result := oDBGrid.Font;
end;

procedure TDBSrchGrid.SetDataSet(Value: TDataSet);
begin
  oDataSource.DataSet := Value;
  If oDBGrid.DataSource.DataSet<>nil then begin
    oDataSource.DataSet.AfterOpen := DataSourceAfterOpen;
    SetCompParam;
    ReadIndexs;
    oActIndex := 1;
    SetIndexField;
  end;
end;

function  TDBSrchGrid.GetDataSet: TDataSet;
begin
  try
    If oDataSource<>nil
      then Result := oDataSource.DataSet
      else Result := nil;
  except Result := nil; end;
end;

procedure TDBSrchGrid.SetBorderStyle(Value: TBorderStyle);
begin
  If Value <> oBorderStyle then begin
    oBorderStyle := Value;
    RecreateWnd;
  end;
end;

procedure TDBSrchGrid.CMCtl3DChanged(var Message: TMessage);
begin
  If NewStyleControls and (oBorderStyle = bsSingle) then RecreateWnd;
  inherited;
end;

procedure TDBSrchGrid.DataSourceAfterOpen (DataSet: TDataSet);
begin
  SetCompParam;
  ReadIndexs;
  oActIndex := 1;
  SetIndexField;
end;

procedure TDBSrchGrid.StringGridOnEnter (Sender: TObject);
begin
  oDBGrid.RowSelect  := TRUE;
  oDBGrid.Options := oDBGrid.Options- [dgMultiSelect];
  oDBGrid.LeftCol := oStringGrid.LeftCol+1;
  oSearchLnFocused := TRUE;
  If Assigned (eOnFocusedChange) then eOnFocusedChange (Sender);
  oStringGrid.SetFocus;
  If oSearchLnClear then begin
    ClearSearchData;
    SetIndexField;
  end;
end;

procedure TDBSrchGrid.StringGridOnExit (Sender: TObject);
begin
 If not oDBGridReadOnly then begin
    oDBGrid.Options := oDBGrid.Options+[dgEditing];
    oDBGrid.ReadOnly := FALSE;
  end;
  If oDBGridMultiSelect then oDBGrid.Options := oDBGrid.Options+[dgMultiSelect];
  If oSearchLnClear then
  begin
    ClearSearchData;
    SetIndexColor;
    ReDrawStringGrid;
  end;
end;

procedure TDBSrchGrid.StringGridTopLeftChanged(Sender: TObject);
begin
  oDBGrid.LeftCol := oStringGrid.LeftCol+1;
end;

procedure TDBSrchGrid.StringGridKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
begin
  If (Key in [VK_F1..VK_F19,VK_INSERT,VK_DELETE]) or (ssCtrl in Shift) then ResetSearchData;
  If Assigned (oDBGrid.DataSource.DataSet) and oDataSource.DataSet.Active then begin
    case Key of
      VK_UP    : begin oDataSource.DataSet.Prior; ResetSearchData; Key := 0; RepaintGrid; end;
      VK_DOWN  : begin oDataSource.DataSet.Next;  ResetSearchData; Key := 0; RepaintGrid; end;
      VK_HOME  : begin oDataSource.DataSet.First; ResetSearchData; oDBGrid.LeftCol := oStringGrid.LeftCol+1; Key := 0; end;
      VK_END   : begin oDataSource.DataSet.Last;  ResetSearchData; oDBGrid.LeftCol := oStringGrid.LeftCol+1; Key := 0; end;
      VK_PRIOR : begin oDataSource.DataSet.MoveBy (-oDBGrid.VisibleRowCount); ResetSearchData; Key := 0; end;
      VK_NEXT  : begin oDataSource.DataSet.MoveBy (oDBGrid.VisibleRowCount); ResetSearchData; Key := 0; end;
      VK_RIGHT : begin StringGridRightPress; Key := 0; end;
      VK_LEFT  : begin StringGridLeftPress; Key := 0; end;
      VK_DELETE: begin
                   If (ssCtrl in Shift) then begin
                     If Assigned(eOnCtrlDelPressed) then eOnCtrlDelPressed (Self);
                   end else begin
                     If Assigned(eOnDelPressed) then eOnDelPressed (Self);
                   end;
                 end;
      VK_BACK  : begin
                   If (ssCtrl in Shift)
                     then StringGridCtrlBackPress
                     else StringGridBackPress;
                   Key := 0;
                 end;
      VK_RETURN: begin
                   If (ssCtrl in Shift) then begin
                     If Assigned(eOnModPressed) then eOnModPressed (Self);
                   end else begin
                     If Assigned(eOnSelected) then eOnSelected (Self);
                   end;
                 end;
      VK_ESCAPE: begin
                   If Assigned(eOnEscPressed) then begin
                     eOnEscPressed (Self);
                     Key := 0;
                   end;
                 end;
      VK_INSERT: begin
                   If (ssCtrl in Shift) then begin
                     If Assigned(eOnCtrlInsPressed) then eOnCtrlInsPressed (Self);
                   end else begin
                     If Assigned(eOnInsPressed) then eOnInsPressed (Self);
                   end;
                 end;
      VK_F3    : If Assigned(eOnF3Pressed) then eOnF3Pressed (Self);
      VK_F7    : If Assigned(eOnF7Pressed) then begin
                   oDBGrid.SetFocus;
                   eOnF7Pressed (Self);
                 end;
      Ord ('z'),Ord ('Z'): begin
        If (ssCtrl in Shift) then begin
          oSearchLnFocused := FALSE;
          If Assigned (eOnFocusedChange) then eOnFocusedChange (Sender);
          oDBGrid.SetFocus;
        end;
      end;
      Ord ('x'),Ord ('X'): begin
        If (ssCtrl in Shift) then begin
          ActRecSelect;
          Key := 0;
        end;
      end;
      Ord ('a'),Ord ('A'): begin
        If (ssCtrl in Shift) then begin
          If (ssShift in Shift)
            then AllRecDeselect
            else AllRecSelect;
        end;
      end;
    end;
    If Assigned(eOnSrchKeyDown) then eOnSrchKeyDown (Self, Key, Shift);
  end;
end;

procedure TDBSrchGrid.StringGridKeyPress (Sender: TObject; var Key: Char);
var
  mStr:string;
  mFld:string;
  mChanged:boolean;
begin
  If oDBGrid.DataSource.DataSet<>nil then begin
    If oDataSource.DataSet.Active then begin
      mChanged := FALSE;
      mStr := oStringGrid.Cells[oStringGrid.Col,oStringGrid.Row];
      mFld := oDBGrid.Columns.Items[oStringGrid.Col].FieldName;
      case oDataSource.DataSet.FieldByName (mFld).DataType of
        ftSmallint, ftInteger, ftWord, ftBytes, ftVarBytes, ftAutoInc,ftLargeint: begin
          If Ord (Key) in [45,48..57]
            then mChanged := TRUE
            else Beep;
        end;
        ftFloat, ftCurrency: begin
          If Ord (Key) in [44,45,46,48..57] then begin
             If Key='.' then Key := ',';
             mChanged := TRUE
          end else Beep;
        end;
        ftDate: begin
          If Ord (Key) in [Ord (DateSeparator),48..57]
            then mChanged := TRUE
            else Beep;
        end;
        ftTime: begin
          If Ord (Key) in [Ord (TimeSeparator),48..57]
            then mChanged := TRUE
            else Beep;
        end;
        ftDateTime: begin
          If Ord (Key) in [Ord (TimeSeparator),Ord (DateSeparator),48..57]
            then mChanged := TRUE
            else Beep;
        end;
        ftString,ftFixedChar, ftWideString: begin
          If Ord (Key) in [32..255]
            then mChanged := TRUE
            else Beep;
        end;
      end;
      If mChanged then begin
        mStr := mStr+Key;
        FindData (mStr);
      end;
    end;
  end;
end;

procedure TDBSrchGrid.StringGridRightPress;
var mFld, mS, mStr:string; I, mNum, mSegQnt:integer;
begin
  If oDBGrid.DataSource.DataSet<>nil then begin
    If oStringGrid.Cells[oStringGrid.Col,oStringGrid.Row]<>'' then begin
      mFld := oDBGrid.Columns.Items[oStringGrid.Col].FieldName;
      mS := oActIndexs.Strings[oActIndex-1];
      mStr := oActIndexs.Strings[oActIndex-1];
      mS := Copy (mS,Pos ('|',mS)+1,Length (mS));
      mSegQnt := 1;
      For I:=1 to Length (mS) do
        If Copy (mS, I, 1)=';' then Inc (mSegQnt);
      If (oSelFldQnt<mSegQnt) and (UpString (oDataSource.DataSet.FieldByName (mFld).AsString)=UpString (oSetData[oSelFldQnt])) then begin
        SetNextIndexFields (GetNParams (mS,oSelFldQnt,';'));
        If oActIndexs.Count=0 then begin
          Dec (oSelFldQnt,2);
          oLastPrevIndex := mStr;
          SetNextIndexFields (GetNParams (mS,oSelFldQnt,';'));
          mNum := oStringGrid.Col;
          oStringGrid.Col := 1;
          oStringGrid.Col := mNum;
        end;
        If oLastPrevIndex<>'' then begin
          oActIndex := 1;
          While (oActIndex<oActIndexs.Count) and (oActIndexs.Strings[oActIndex-1]<>oLastPrevIndex) do
            Inc (oActIndex);
        end;
//      end else Beep;
      {2004-09-21 EK}
      end else begin
        oSetData[oSelFldQnt] := '';
        oStringGrid.Cells[oStringGrid.Col,oStringGrid.Row] := '';
        If (oFixSrchField<>'')and (oSelFldQnt=2) then begin
          mS := oActIndexs.Strings[oActIndex-1];
          mS := Copy (mS,Pos ('|',mS)+1,Length (mS));
          If Copy (mS, 1, Length (oFixSrchField)+1)=oFixSrchField+';' then begin
            oSelFldQnt := 1;
            oSetData[1] := '';
            If FindFieldInGrid (oFixSrchField, mNum) then oStringGrid.Cells[mNum,0] := '';
          end;
        end;
        Inc (oActIndex);
        If oActIndex>oActIndexs.Count then oActIndex := 1;
      end;
    end else begin
      oSetData[oSelFldQnt] := '';
      oStringGrid.Cells[oStringGrid.Col,oStringGrid.Row] := '';
      If (oFixSrchField<>'')and (oSelFldQnt=2) then begin
        mS := oActIndexs.Strings[oActIndex-1];
        mS := Copy (mS,Pos ('|',mS)+1,Length (mS));
        If Copy (mS, 1, Length (oFixSrchField)+1)=oFixSrchField+';' then begin
          oSelFldQnt := 1;
          oSetData[1] := '';
          If FindFieldInGrid (oFixSrchField, mNum) then oStringGrid.Cells[mNum,0] := '';
        end;
      end;
      Inc (oActIndex);
      If oActIndex>oActIndexs.Count then oActIndex := 1;
    end;
    SetIndexField;
  end;
end;

procedure TDBSrchGrid.StringGridLeftPress;
var mS, mFld:string; mNum:longint;
begin
  oLastPrevIndex := '';
  If (oSelFldQnt>oFixData+1) then begin
    oSetData[oSelFldQnt] := '';
    oStringGrid.Cells[oStringGrid.Col,oStringGrid.Row] := '';
    oLastPrevIndex := oActIndexs.Strings[oActIndex-1];
    mS := Copy (oLastPrevIndex,Pos ('|',oLastPrevIndex)+1,Length (oLastPrevIndex));
    mFld := '';
    If oSelFldQnt=2 then mFld := GetNParams (mS, 1, ';');
    Dec (oSelFldQnt,1); //??
    Dec (oSelFldQnt,2);
    SetNextIndexFields (GetNParams (mS,oSelFldQnt,';'));
    If (oFixSrchField<>'') and (oFixSrchField=mFld) then begin
      oSetData[1] := '';
      If FindFieldInGrid (mFld, mNum) then oStringGrid.Cells[mNum,0] := '';
    end;
  end else begin
    oSetData[oSelFldQnt] := '';
    oStringGrid.Cells[oStringGrid.Col,oStringGrid.Row] := '';
    Dec (oActIndex);
    If oActIndex<=0 then oActIndex := oActIndexs.Count;
  end;
  SetIndexField;
end;

procedure TDBSrchGrid.StringGridBackPress;
var mStr:string;
begin
  If oDBGrid.DataSource.DataSet<>nil then begin
    If oDataSource.DataSet.Active then begin
      mStr := oStringGrid.Cells[oStringGrid.Col,oStringGrid.Row];
      Delete(mStr, Length(mStr),1);
      oStringGrid.Cells[oStringGrid.Col,oStringGrid.Row] := mStr;
      FindData (mStr);
    end;
  end;
end;

procedure TDBSrchGrid.StringGridCtrlBackPress;
begin
  oStringGrid.Cells[oStringGrid.Col,oStringGrid.Row] := '';
  FindData ('');
end;

procedure TDBSrchGrid.StringGridMouseUp(Sender: TObject; Button: TMouseButton;Shift: TShiftState; X, Y: Integer);
var
  I:integer;
  mFind:boolean;
  mNum:integer;
  mSS,mS:string;
begin
  If oDBGrid.DataSource.DataSet<>nil then begin
    If oDataSource.DataSet.Active then begin
      ClearSearchData;
      SetNextIndexFields (oFixIndexFields);
      I := 0;
      mFind := FALSE;
      If oFixIndexFields<>''
        then mS := oFixIndexFields+';'+oDBGrid.Fields[oStringGrid.Col].FieldName
        else mS := oDBGrid.Fields[oStringGrid.Col].FieldName;
      While (I<oActIndexs.Count) and not mFind do begin
        mSS := oActIndexs.Strings[I];
//        mSS := Copy (mSS,Pos ('*',mSS)+1,Pos ('|',mSS)-Pos ('*',mSS)-1);
        mSS := Copy (mSS,Pos ('|',mSS)+1,100);
        If (mSS<>'') and (mSS[Length(mSS)]='_') then Delete(mSS,Length(mSS),1);
        If (mS<>'') and (mS[Length(mS)]='_') then Delete(mS,Length(mS),1);
        mFind := (Pos (UpString (mS+';'), UpString (mSS+';'))=1);
//        mFind := (UpString (mS)=UpString (mSS));
//        mFind := (Pos ('|'+UpString (mS), UpString (oActIndexs.Strings[I]))>0);
        Inc (I);
      end;
      If mFind
        then oActIndex := I
        else oActIndex := 1;
//      If FindFieldInGrid (CutLastCol (oActIndexs.Strings[oActIndex-1]),mNum) then oStringGrid.Col := mNum;
      SetIndexField;
    end;
  end;
end;

function  TDBSrchGrid.MyGetSelectedRow:boolean;
begin
 Result :=  DataInSelTable;
end;

procedure TDBSrchGrid.MyOnMouseWheelDown (Sender: TObject; Shift: TShiftState; MousePos: TPoint; var Handled: Boolean);
var mQ:double;mI:Integer;
begin
  Handled := TRUE;
  If ssctrl in Shift then begin
    mQ:=GetTextWidth('0',oDBGrid.Font,Self);
    oDBGrid.Font.Size:=oDBGrid.Font.Size-1;
    oStringGrid.Font.Size:=oDBGrid.Font.Size;
    mQ:=GetTextWidth('0',oDBGrid.Font,Self)/mQ;
    If oDBGrid.DataSource.DataSet<>nil then begin
      For mI:=0 to oDBGrid.Columns.Count-1 do oDBGrid.Columns[mI].Width:=round(oDBGrid.Columns[mI].Width*mQ);
    end;
  end;
  If oDBGrid.DataSource.DataSet<>nil then begin
    If oDBGrid.DataSource.DataSet.Active and (oDBGrid.DataSource.DataSet.State=dsBrowse) and not oDBGrid.DataSource.DataSet.Eof then begin
      oDBGrid.DataSource.DataSet.Next;
      RepaintGrid;
    end;
  end;
end;

procedure TDBSrchGrid.MyOnMouseWheelUp (Sender: TObject; Shift: TShiftState; MousePos: TPoint; var Handled: Boolean);
var mQ:double;mI:Integer;
begin
  Handled := TRUE;
  If ssctrl in Shift then begin
    mQ:=GetTextWidth('0',oDBGrid.Font,Self);
    oDBGrid.Font.Size:=oDBGrid.Font.Size+1;
    oStringGrid.Font.Size:=oDBGrid.Font.Size;
    mQ:=GetTextWidth('0',oDBGrid.Font,Self)/mQ;
    If oDBGrid.DataSource.DataSet<>nil then begin
      For mI:=0 to oDBGrid.Columns.Count-1 do oDBGrid.Columns[mI].Width:=round(oDBGrid.Columns[mI].Width*mQ);
    end;
  end;
  If oDBGrid.DataSource.DataSet<>nil then begin
    If oDBGrid.DataSource.DataSet.Active and (oDBGrid.DataSource.DataSet.State=dsBrowse) and not oDBGrid.DataSource.DataSet.Bof then begin
      oDBGrid.DataSource.DataSet.Prior;
      RepaintGrid;
    end;
  end;
end;

procedure TDBSrchGrid.DBGridOnEnter (Sender: TObject);
begin
  If not oDBGridReadOnly then begin
    oDBGrid.Options := oDBGrid.Options+[dgEditing];
    oDBGrid.ReadOnly := FALSE;
  end;
  oDBGrid.RowSelect  := FALSE;
  If oDBGridMultiSelect then oDBGrid.Options := oDBGrid.Options+[dgMultiSelect];
  oDBGrid.LeftCol := oStringGrid.LeftCol+1;
  SetCompParam;
  oSearchLnFocused := FALSE;
  If Assigned (eOnFocusedChange) then eOnFocusedChange (Sender);
  oDBGrid.SetFocus;
end;

procedure TDBSrchGrid.DBGridOnColEnter (Sender: TObject);
begin
  oStringGrid.LeftCol := oDBGrid.LeftCol-1;
  If Assigned (eOnColEnter) then eOnColEnter (Sender);
end;

procedure TDBSrchGrid.DBGridOnDrawColumnCell;
begin
  oStringGrid.LeftCol := oDBGrid.LeftCol-1;
  If Assigned (eOnDrawColumnCell) then eOnDrawColumnCell (Sender, Rect, DataCol, Column, State);
end;

procedure TDBSrchGrid.DBGridColumnMoved(Sender: TObject; FromIndex, ToIndex: Integer);
begin
  If oActualizedGrid then begin
    SetCompParam;
    ReadIndexs;
    If Assigned (eOnGridChange) then eOnGridChange (Sender);
  end;
end;

procedure TDBSrchGrid.DBSrGridResize (Sender: TObject);
begin
  If oActualizedGrid then SetCompParam;
end;

procedure TDBSrchGrid.DBGridColWidthsChanged (Sender: TObject);
begin
  If oActualizedGrid then begin
    SetCompParam;
    If Assigned (eOnGridChange) then eOnGridChange (Sender);
  end;
end;

procedure TDBSrchGrid.DBGridKeyPress (Sender: TObject; var Key: Char);
var
  I:integer;
  mFind:boolean;
  mNum:integer;
  mS:string;
begin
  If oDBGrid.DataSource.DataSet<>nil then begin
    If oDBGridReadOnly then begin
      If Ord (Key) in [32..255] then begin
        If oDataSource.DataSet.Active then begin
          oStringGrid.Col := oDBGrid.SelectedIndex;
          ClearSearchData;
          SetNextIndexFields (oFixIndexFields);
          I := 0;
          mFind := FALSE;
          If oFixIndexFields<>''
            then mS := oFixIndexFields+';'+oDBGrid.Fields[oStringGrid.Col].FieldName
            else mS := oDBGrid.Fields[oStringGrid.Col].FieldName;
          While (I<oActIndexs.Count) and not mFind do begin
            mFind := (Pos ('|'+UpString (mS), UpString (oActIndexs.Strings[I]))>0);
            Inc (I);
          end;
          If mFind
            then oActIndex := I
            else oActIndex := 1;
//          If FindFieldInGrid (CutLastCol (oActIndexs.Strings[oActIndex-1]),mNum) then oStringGrid.Col := mNum;
          SetIndexField;
        end;
        oSearchLnFocused := TRUE;
        If Assigned (eOnFocusedChange) then eOnFocusedChange (Sender);
        oStringGrid.SetFocus;
        oStringGrid.Cells[oStringGrid.Col,oStringGrid.Row] := '';
        FindData (Key);
        Key := #0;
      end;
    end else begin
      If Key<>#13 then begin
        If GetFldReadOnly (oDBGrid.SelectedField.FieldName) then Key := #0;
      end;
    end;
  end;
end;

procedure TDBSrchGrid.DBGridKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
begin
  If oDBGrid.DataSource.DataSet<>nil then begin
    If oDataSource.DataSet.Active then begin
      case Key of
        VK_UP    : begin oDataSource.DataSet.Prior; Key := 0; RepaintGrid; end;
        VK_DOWN  : begin oDataSource.DataSet.Next;  Key := 0; RepaintGrid; end;
        VK_HOME  : begin oDataSource.DataSet.First; Key := 0; end;
        VK_END   : begin oDataSource.DataSet.Last;  Key := 0; end;
        VK_ESCAPE: begin
                     If Assigned(eOnEscPressed) then begin
                       eOnEscPressed (Self);
                       Key := 0;
                     end;
                   end;
        VK_DELETE: begin
                     If not oDBGrid.EditorMode then begin
                       If (ssCtrl in Shift) then begin
                         Key := 0;
                         If oDelEnabled then begin
                           If Assigned(eOnCtrlDelPressed)
                             then eOnCtrlDelPressed (Self)
                             else oDataSource.DataSet.Delete;
                         end;
                       end else begin
                         If Assigned(eOnDelPressed) then begin
                           Key := 0;
                           eOnDelPressed (Self);
                         end;
                       end;
                     end else begin
                       If GetFldReadOnly (oDBGrid.SelectedField.FieldName) then begin
                         oDBGrid.EditorMode := FALSE;
                       end;
                     end;
                   end;
        VK_INSERT: begin
                     Key := 0;
                     If (ssCtrl in Shift) then begin
                       If Assigned(eOnCtrlInsPressed) then eOnCtrlInsPressed (Self);
                     end else begin
                       If Assigned(eOnInsPressed)
                         then eOnInsPressed (Self)
                         else DataSet.Insert;
                     end;
                   end;
        VK_F3    : If Assigned(eOnF3Pressed) then eOnF3Pressed (Self);
        VK_F7    : If Assigned(eOnF7Pressed) then eOnF7Pressed (Self);
        VK_RETURN: begin
                     If not oDBGrid.EditorMode then begin
                       If (ssCtrl in Shift) then begin
                         If Assigned(eOnModPressed) then eOnModPressed (Self);
                       end else begin
                         If DataSet.State=dsBrowse then begin
                           If Assigned(eOnCRPressed) then eOnCRPressed (Self);
                           If Assigned(eOnSelected) then eOnSelected (Self);
                         end;
                       end;
                       oDBGrid.EditorMode := FALSE;
                     end else begin
                       If GetFldReadOnly (oDBGrid.SelectedField.FieldName) then begin
                         oDBGrid.EditorMode := FALSE;
//                         Key := 0;
                       end;
                     end;
                   end;
        Ord ('s'),Ord ('S'): begin
          If (Shift=[ssCtrl]) then begin
            If (ssShift in Shift)
              then ShowSelSum
              else ShowSumData (stAll);
          end;
        end;
        Ord ('d'),Ord ('D'): If (Shift=[ssCtrl]) then ShowSumData (stTo);
        Ord ('o'),Ord ('O'): If (Shift=[ssCtrl]) then ShowSumData (stFrom);
        Ord ('z'),Ord ('Z'): begin
          If (ssCtrl in Shift) then begin
            oSearchLnFocused := TRUE;
            If Assigned (eOnFocusedChange) then eOnFocusedChange (Sender);
            oStringGrid.SetFocus;
          end;
        end;
        Ord ('x'),Ord ('X'): begin
          If (ssCtrl in Shift) then ActRecSelect;
        end;
        Ord ('a'),Ord ('A'): begin
          If (ssCtrl in Shift) then begin
            If (ssShift in Shift)
              then AllRecDeselect
              else AllRecSelect;
          end;
        end;
      end;
    end;
  end;
  If Assigned(eOnKeyDown) then eOnKeyDown (Self, Key, Shift);
end;

procedure TDBSrchGrid.DBGridMouseUp(Sender: TObject; Button: TMouseButton;Shift: TShiftState; X, Y: Integer);
begin
  oMouseX := X;
  oMouseY := Y;
end;

procedure TDBSrchGrid.DBGridMouseDblClick (Sender: TObject);
var
  I:integer;
  mFind:boolean;
  mNum:integer;
  mStrGridColor: array [0..250] of TColor;
  mSelFldQnt:integer;
  mActIndex:integer;
  mActIndexs:TStringList;
  mCoord:TGridCoord;
  mS:string;
begin
  If oDBGrid.DataSource.DataSet<>nil then begin
    If oDataSource.DataSet.Active then begin
      mCoord := oDBGrid.MouseCoord (oMouseX, oMouseY);
      If (mCoord.X=0) and (mCoord.Y>0) then begin
        If EnableMultiSelect then begin
          If oDataSource.DataSet.RecordCount>0 then ActRecSelect;
        end;
      end;
      If (mCoord.Y=0) and (mCoord.X>0) then begin
        oStringGrid.Col := mCoord.X-1;
        For I:=0 to 250 do
          mStrGridColor[I] := oStrGridColor[I];
        mSelFldQnt := oSelFldQnt;
        mActIndex := oActIndex;
        mActIndexs := TStringList.Create;
        mActIndexs.Clear;
        For I:=0 to oActIndexs.Count-1 do
          mActIndexs.Add (oActIndexs.Strings[I]);

        ClearSearchData;
        SetNextIndexFields (oFixIndexFields);
        I := 0;
        mFind := FALSE;
        If oFixIndexFields<>''
          then mS := oFixIndexFields+';'+oDBGrid.Fields[oStringGrid.Col].FieldName
          else mS := oDBGrid.Fields[oStringGrid.Col].FieldName;
        While (I<oActIndexs.Count) and not mFind do begin
          mFind := (Pos ('|'+UpString (mS), UpString (oActIndexs.Strings[I]))>0);
          Inc (I);
        end;
        If mFind then begin
          oActIndex := I;
//          If FindFieldInGrid (CutLastCol (oActIndexs.Strings[oActIndex-1]),mNum) then oStringGrid.Col := mNum;
          SetIndexField;
        end else begin
          For I:=0 to 250 do
            oStrGridColor[I] := mStrGridColor[I];
          oSelFldQnt := mSelFldQnt;
          oActIndex := mActIndex;
          oActIndexs.Clear;
          For I:=0 to mActIndexs.Count-1 do
            oActIndexs.Add (mActIndexs.Strings[I]);
        end;
        mActIndexs.Free;
        oSearchLnFocused := TRUE;
        If Assigned (eOnFocusedChange) then eOnFocusedChange (Sender);
        oStringGrid.SetFocus;
      end else begin
        If Assigned (eOnSelected) then eOnSelected (Self);
      end;
    end;
  end;
end;

procedure TDBSrchGrid.SetCompParam;
var
  mSize:integer;
  I:integer;
begin
  mSize := 0;
  If oBorderStyle=bsSingle then mSize := 4;
  oStringGrid.ColCount := oDBGrid.Columns.Count;
  For I:=0 to oStringGrid.ColCount-1 do
    oStringGrid.ColWidths[I] := oDBGrid.Columns[I].Width;

  If oDBGrid.DataSource.DataSet<>nil then begin
    If oStringGrid.VisibleColCount=oStringGrid.ColCount
      then oStringGrid.Height := 16
      else oStringGrid.Height := 32;
  end;
  oStringGrid.Left := 12;
  oStringGrid.Top := Height-oStringGrid.Height-mSize;
  oStringGrid.Width := Width-12-mSize;
  If (oDBGrid.DataSource.DataSet<>nil) and oDBGrid.DataSource.DataSet.Active then begin
    If (oFixData>0) or ((oDBGrid.VisibleRowCount<oDBGrid.DataSource.DataSet.RecordCount)) then oStringGrid.Width := Width-12-16-mSize;
  end;

  oButt.Left := 0;
  oButt.Top := oStringGrid.Top;
  oButt.Width := 12;
  oButt.Height := oStringGrid.Height;
  oButt.Enabled := TRUE;

  oDBGrid.Left := 0;
  oDBGrid.Top := 0;
  oDBGrid.Width := Width-mSize;
  oDBGrid.Height := oStringGrid.Top-1;
  If oTabStop then oDBGrid.TabStop := TRUE;
end;

procedure TDBSrchGrid.ReadIndexs;
var
  I:integer;
  mIndexs:TIndexDefs;
  mInd:string;
  mS:string;
  mOK:boolean;
  mTable:TTable;
begin
  oActIndex := 1;
//  If DirectoryExists ((oDBGrid.DataSource.DataSet as TTable).DatabaseName) then begin
//    If (oDBGrid.DataSource.DataSet as TTable).Exists then begin
      mIndexs := GetIndexs;
      oAllIndexs.Clear;
      If mIndexs<>nil then begin
        If mIndexs.Count>0 then begin
          For I:=0 to mIndexs.Count-1 do begin
            If (oOnlyOneIndex='') or (oOnlyOneIndex=mIndexs.Items[I].Name) then begin
              If oFixIndexFields<>''
                then mOK := Pos (oFixIndexFields, mIndexs.Items[I].Fields)=1
                else mOK := TRUE;
              If mOK then begin
                mInd := '';
                mS := mIndexs.Items[I].Fields;
                GetIndexPosition (mInd,mS);
                If mInd<>'' then oAllIndexs.Add (mInd+'*'+mIndexs.Items[I].Name+'|'+mS);
              end;
            end;
          end;
        end;
      end;
      SetNextIndexFields (oFixIndexFields);
      SetIndexColor;
      AddPopupIndex;
//    end;
//  end;
end;

procedure TDBSrchGrid.GetIndexPosition (var pInd:string;pFields:string);
var
  mS:string;
  mNum:integer;
  mSect:byte;
  mSS:string;
begin
  pInd := '';
  mSect := 0;
  If oFixIndexFields<>'' then Delete (pFields,1,Length (oFixIndexFields)+1);
  While pFields<>'' do begin
    Inc (mSect);
    CutNextParamSepar (pFields,mS,';');
    mNum := 0;
    If oDBGrid.Columns.Count>0 then begin
      If FindFieldInGrid (mS,mNum) then begin
        If pInd='' then pInd := FillStr (pInd,30,'0');
        mSS := StrIntZero (mNum,3);
        Insert (mSS,pInd,(mSect-1)*3+1);
        Delete (pInd,mSect*3+1,3);
      end else begin
        pFields := '';
        pInd := '';
      end;
    end else pInd := '';
  end;
end;

function  TDBSrchGrid.FindFieldInGrid (pFld:string;var pNum:integer):boolean;
var
  I:integer;
  mOK:boolean;
begin
  mOK := FALSE;
  pNum := -1;
  I := 0;
  If oDBGrid.DataSource.DataSet<>nil then begin
    If oDataSource.DataSet.Active then begin
      While (I<=oDBGrid.Columns.Count-1) and (pNum=-1) do begin
        pFld := CutFldInSrchFld (pFld);
        If oDBGrid.Columns.Items[I].Field<>nil then begin
          If UpString (oDBGrid.Columns.Items[I].Field.FieldName)=UpString (pFld) then begin
            If oDBGrid.Columns.Items[I].Field.Visible then begin
              pNum := I;
              mOK := TRUE;
            end;
          end;
        end;
        Inc (I);
      end;
      If pNum>250 then begin
        pNum := -1;
        mOK := FALSE;
      end;
    end;
  end;
  Result := mOK;
end;

function  TDBSrchGrid.CutLastCol (pFld:string):string;
var mS:string;
begin
  mS := '';
  If Pos ('|',pFld)>0 then pFld := Copy (pFld,Pos ('|',pFld)+1,Length (pFld));
  While pFld<>'' do
    CutNextParamSepar (pFld,mS,';');
  CutLastCol := mS;
end;

procedure TDBSrchGrid.SetNextIndexFields (pSelectedFlds:string);
var
  I,J, mSelFldQnt:integer;
  mS:string;
  mSS:string;
  mOK:boolean;
  mFind:boolean;
  mAllIndexs:string;
begin
  oActIndex := 1;
  oActIndexs.Clear;
  oSelFldQnt := 1;
  If pSelectedFlds<>'' then begin
    For I:=1 to Length (pSelectedFlds) do
      If pSelectedFlds[I]=';' then Inc (oSelFldQnt);
    Inc (oSelFldQnt);
  end;
{ TODO -oERICH : osetrit vyber indexov ak sa zhoduje prvy segment indexu napr zoznam prebalovacich koeficientov z vyroby }
  If oAllIndexs.Count>0 then begin
    mSelFldQnt := oSelFldQnt;
    If (oFixSrchField<>'') and (pSelectedFlds=oFixSrchField) then begin
      mSelFldQnt := 1;
      pSelectedFlds:= '';
    end;
    For I:=0 to oAllIndexs.Count-1 do begin
      mAllIndexs := oAllIndexs.Strings[I];
      mAllIndexs := Copy (mAllIndexs,Pos ('|',mAllIndexs)+1, Length (mAllIndexs));
      If pSelectedFlds<>''
        then mOK := (Pos (pSelectedFlds,mAllIndexs)=1)
        else mOK := TRUE;
      If mOK then begin
{ TODO : EK 2008-11-06 - zistit ci je to takto dobre aby pozbieral vsetky dobre indexy }
        mS := mAllIndexs;
//28.01.2018 Tibi - aby nevynechal viac segmentové indexy zo spoloènými poliamy       mS := GetNParams (mAllIndexs, mSelFldQnt, ';');
        If mS<>'' then begin
          If (oActIndexs.Count=0) and (oLastPrevIndex<>'') then oActIndexs.Add (oLastPrevIndex);
          mFind := FALSE;
          J := 0;
          While (J<oActIndexs.Count) and not mFind do begin
            mSS := Copy (oActIndexs.Strings[J],Pos ('|',oActIndexs.Strings[J])+1,Length (oActIndexs.Strings[J]));
            mFind := (Pos (UpString (mS),UpString (mSS))=1);
            mFind := (UpString (mS)=UpString (mSS));
            If oLastPrevIndex<>'' then begin
              If oLastPrevIndex=(oAllIndexs.Strings[I]) then oActIndex := J+1;
            end;
            Inc (J);
          end;
          If not mFind then oActIndexs.Add (oAllIndexs.Strings[I]);
        end;
      end;
    end;
  end;
end;

procedure TDBSrchGrid.SetIndexField;
var mS, mFld, mName:string; I, mNum:longint; 
begin
  If oDBGrid.DataSource.DataSet<>nil then begin
    If oDataSource.DataSet.Active and (oActIndexs.Count>0) then begin
      If oActIndex>oActIndexs.Count then oActIndex := oActIndexs.Count;
      mS := oActIndexs.Strings[oActIndex-1];
      mName := Copy (mS,Pos ('*',mS)+1,Pos ('|',mS)-Pos ('*',mS)-1);
      mS := Copy (mS,Pos ('|',mS)+1,Length (mS));
      If oActIndexFields<>mS then begin
        SetIndexName (mName);
        ClearSearchData;
        If oFixData>0 then begin
          (oDBGrid.DataSource.DataSet as TTable).CancelRange;
          (oDBGrid.DataSource.DataSet as TTable).SetRange (oRange,oRange);
          SetCompParam;
        end;
        oActIndexFields := mS;
        If Pos (oFixIndexFields,mS)>0 then Delete (mS,1,Length (oFixIndexFields)+1);
        oActIndexDispText := '';
        While mS<>'' do begin
          CutNextParamSepar (mS,mFld,';');
          If mFld<>'' then begin
            If oActIndexDispText='' then begin
              oActIndexDispText := oDBGrid.DataSource.DataSet.FieldByName (mFld).DisplayName;
              If (oFixSrchField<>'') and (oFixSrchField=mFld) then begin
                oSetData[1] := oDBGrid.DataSource.DataSet.FieldByName (mFld).AsString;
                If oSetData[1]<>'' then begin
                  If FindFieldInGrid (oFixSrchField, mNum) then oStringGrid.Cells[mNum, 0] := oSetData[1];
                  SetNextIndexFields (oFixSrchField);
                end;
              end;
            end else oActIndexDispText := oActIndexDispText+' - '+oDBGrid.DataSource.DataSet.FieldByName (mFld).DisplayName;
          end;
        end;
      end;
      SetIndexColor;
      ReDrawStringGrid;
      If Assigned(eOnChangeIndex) then eOnChangeIndex (Self);
    end;
  end;
end;

procedure TDBSrchGrid.SetIndexColor;
var
  I:integer;
  mS:string;
  mFld:string;
  mNum:integer;
  mDT:TDateTime;
begin
  If oDBGrid.DataSource.DataSet<>nil then begin
    For I:=0 to 250 do
      oStrGridColor[I] := oIndexColor.oIndexEmptyColor;
    If oDataSource.DataSet.Active and (oActIndexs.Count>0) then begin
      I := 0;
      mS := Copy (oActIndexs.Strings[oActIndex-1],Pos ('|',oActIndexs.Strings[oActIndex-1])+1,Length (oActIndexs.Strings[oActIndex-1]));
      While mS<>'' do begin
        Inc (I);
        CutNextParamSepar (mS,mFld,';');
        If FindFieldInGrid (mFld,mNum) then begin
          If I>oSelFldQnt then begin
            If oDBGrid.Focused
              then oStrGridColor[mNum] := oIndexColor.oIndexSelColor
              else oStrGridColor[mNum] := oDBGrid.MarkData.SelInactRowColor;
          end else begin
            If (I=oSelFldQnt) then oStringGrid.Col := mNum;
            If (I=oSelFldQnt) and (oSetData[I]='') then begin
              If oDBGrid.Focused
                then oStrGridColor[mNum] := oIndexColor.oIndexSelColor
                else oStrGridColor[mNum] := oDBGrid.MarkData.SelInactRowColor;
            end else begin
              mFld := oDBGrid.Columns.Items[mNum].FieldName;
              case oDataSource.DataSet.FieldByName (mFld).DataType of
                ftString: begin
                  If Pos (StrToAlias (oSetData[I]),StrToAlias (oDataSource.DataSet.FieldByName (mFld).AsString))=1
                    then oStrGridColor[mNum] := oIndexColor.oIndexFindColor
                    else oStrGridColor[mNum] := oIndexColor.oIndexBadColor;
                end;
                ftDate, ftTime, ftDateTime: begin
                  try
//                    mDT := StrToDateTime(oSetData[I]);
                    If oSetData[I]=oDataSource.DataSet.FieldByName (mFld).AsString
                      then oStrGridColor[mNum] := oIndexColor.oIndexFindColor
                      else oStrGridColor[mNum] := oIndexColor.oIndexBadColor;
                  except oStrGridColor[mNum] := oIndexColor.oIndexBadColor; end;
                end;
                ftFloat: begin
                  If ValDoub (oDataSource.DataSet.FieldByName (mFld).AsString)=ValDoub (oSetData[I])
                    then oStrGridColor[mNum] := oIndexColor.oIndexFindColor
                    else oStrGridColor[mNum] := oIndexColor.oIndexBadColor;
                end
                else begin
                  If UpString (oDataSource.DataSet.FieldByName (mFld).AsString)=UpString (oSetData[I])
                    then oStrGridColor[mNum] := oIndexColor.oIndexFindColor
                    else oStrGridColor[mNum] := oIndexColor.oIndexBadColor;
                end;
              end;
            end;
          end;
        end;
      end;
    end;
  end;
end;

procedure TDBSrchGrid.SetPopupMenu (Value:TPopupMenu);
begin
  ePopupMenu := Value;
  If Assigned (Value) then begin
    ePopupMenu.OnPopup := FillDefPopupMenu;
    oDBGrid.PopupMenu := ePopupMenu;
  end else begin
    ePopupMenu := nil;
    oDBGrid.PopupMenu := oPopupMenu;
  end;
  oFillDefPopup := FALSE;
end;

procedure TDBSrchGrid.SetTabStop (Value:boolean);
begin
  oStringGrid.TabStop := FALSE;
  oDBGrid.TabStop := FALSE;
  If Value then begin
    If oDBGridReadOnly
    then oStringGrid.TabStop := TRUE
    else oDBGrid.TabStop := TRUE;
  end;
  oTabStop := Value;
end;

procedure TDBSrchGrid.FindData (pStr:string);
var
  mRV:TRangeValues;
  I:integer;
  mFld:string;
  mStr:string;
begin
  oFindBegin := TRUE;
  If oDBGrid.DataSource.DataSet<>nil then begin
    mFld := oDBGrid.Columns.Items[oStringGrid.Col].FieldName;
    If (oDataSource.DataSet.FindField ('_'+mFld)<>nil) or (oDataSource.DataSet.FindField (mFld+'_')<>nil)
      then pStr := StrToAlias (pStr);
    oSetData[oSelFldQnt] := pStr;
    For I:=1 to 10 do
      mRV[I] := '';
    For I:=1 to oSelFldQnt do
      mRV[I] := oSetData[I];
    If VerifyFindData (mRV)
      then FindNearest (oDBGrid.Datasource.DataSet, oSelFldQnt, mRV);
    If oDataSource.DataSet.FieldByName (mFld).DataType=ftString then begin
      mStr := oDataSource.DataSet.FieldByName (mFld).AsString;
      If (oDataSource.DataSet.FindField ('_'+mFld)<>nil) or (oDataSource.DataSet.FindField (mFld+'_')<>nil)
        then mStr := StrToAlias (mStr);
      If Pos (pStr,mStr)=1
        then oStringGrid.Cells[oStringGrid.Col,oStringGrid.Row] := pStr
        else begin
          Delete(oSetData[oSelFldQnt], Length(oSetData[oSelFldQnt]),1);
          mRV[oSelFldQnt] := oSetData[oSelFldQnt];
          If oSetData[oSelFldQnt]<>'' then begin
            If VerifyFindData (mRV)
              then FindNearest (oDBGrid.Datasource.DataSet, oSelFldQnt, mRV);
          end;
          Beep;
        end;
    end else oStringGrid.Cells[oStringGrid.Col,oStringGrid.Row] := pStr;
    SetIndexColor;
    ReDrawStringGrid;
  end;
  oFindBegin := FALSE;
end;

procedure TDBSrchGrid.ClearSearchData;
var I:integer;
begin
  oFindBegin := FALSE;
  For I:=0 to 250 do
    oStrGridColor[I] := oIndexColor.oIndexEmptyColor;
  For I:=1 to 10 do
    oSetData[I] := '';
  For I:=0 to oStringGrid.ColCount do
    oStringGrid.Cells[I,0] := '';
  oSelFldQnt := 1;
  FillFixData;
end;

procedure TDBSrchGrid.StringGridDrawCell (Sender: TObject; ACol, ARow: Longint; Rect: TRect; State: TGridDrawState);
begin
  oStringGrid.Canvas.Brush.Color := oStrGridColor[ACol];
  oStringGrid.Canvas.FillRect (Rect);
  oStringGrid.Canvas.Font.Color := clBlack;
  oStringGrid.Canvas.TextOut (Rect.Left+2, Rect.Top+2, oStringGrid.Cells[ACol, ARow]);
  oStringGrid.Canvas.Brush.Color := oIndexColor.oIndexEmptyColor;
end;

procedure TDBSrchGrid.ReDrawStringGrid;
begin
  oStringGrid.Repaint;
  oDBGrid.LeftCol := oStringGrid.LeftCol+1;
end;

procedure TDBSrchGrid.SetDBGridReadOnly (pValue:boolean);
begin
  oDBGridReadOnly := pValue;
  If pValue then begin
    oDBGrid.Options := oDBGrid.Options-[dgEditing];
    oDBGrid.ReadOnly := TRUE;
  end else begin
    oDBGrid.Options := oDBGrid.Options+[dgEditing];
    oDBGrid.ReadOnly := FALSE;
  end;
end;

procedure TDBSrchGrid.FillFixData;
var
  I:byte;
  mNum:integer;
  mS,mFld:string;
begin
  If oFixData>0 then begin
    mS := oFixIndexFields;
    For I:=1 to oFixData do begin
      oSetData[I] := oDataRange[I];
      CutNextParamSepar (mS,mFld,';');
      If FindFieldInGrid (mFld,mNum) then oStringGrid.Cells[mNum,0] := oSetData[I];
    end;
    oSelFldQnt := oFixData+1;
    ReDrawStringGrid;
  end;
end;

function  TDBSrchGrid.GetMarkData: TMarkData;
begin
  GetMarkData := oDBGrid.MarkData;
end;

procedure TDBSrchGrid.SetMarkData (Value:TMarkData);
begin
  oDBGrid.MarkData := Value;
end;

function  TDBSrchGrid.GetImageParams: String;
begin
  GetImageParams := oDBGrid.ImageParams;
end;

procedure TDBSrchGrid.SetImageParams (Value:String);
begin
  oDBGrid.ImageParams := Value;
end;

procedure TDBSrchGrid.MyOnColExit (Sender: TObject);
begin
  If Assigned (eOnColExit) then eOnColExit (Sender);
end;

procedure TDBSrchGrid.MyDataChange (Sender: TObject; Field: TField);
begin
  If Assigned (eOnDataChange) then eOnDataChange (Sender,Field);
  FillFixSrchFld;
end;

procedure TDBSrchGrid.MyPMIndexOnClick (Sender: TObject);
var I:integer;
begin
  If Sender is TMenuItem then begin
    If (Sender as TMenuItem).Name='Indexs' then begin
      If oPMIndex.Count>0 then begin
        For I:=0 to oPMIndex.Count-1 do
          oPMIndex.Items[I].Checked := (oAllIndexs.Strings[I]=oActIndexs.Strings[oActIndex-1]);
      end;
    end;
  end;
end;

procedure TDBSrchGrid.AddPopupIndex;
var
  I:integer;
  mS,mFld,mDisp:string;
begin
  If oPMIndex.Count>0 then oPMIndex.Clear;
  If oAllIndexs.Count>0 then begin
    For I:=0 to oAllIndexs.Count-1 do begin
      mDisp := '';
      mS := oAllIndexs.Strings[I];
      mS := Copy (mS,Pos ('|',mS)+1,Length (mS));
      If (oFixIndexFields<>'') and (Pos (oFixIndexFields,mS)>0) then Delete (mS,1,Length (oFixIndexFields)+1);
      While mS<>'' do begin
        CutNextParamSepar (mS,mFld,';');
        mFld := CutFldInSrchFld (mFld);
        If mFld<>'' then begin
          If mDisp=''
            then mDisp := oDBGrid.DataSource.DataSet.FieldByName (mFld).DisplayName
            else mDisp := mDisp+' - '+oDBGrid.DataSource.DataSet.FieldByName (mFld).DisplayName;
        end;
      end;
      oPMIndex.Add (NewItem(mDisp,0,FALSE,True,IndexChange,0,'Index'+StrInt(I,0)));
    end;
  end;
end;

procedure TDBSrchGrid.Notification(AComponent: TComponent;
  Operation: TOperation);
begin
  inherited Notification(AComponent, Operation);
  if Operation = opRemove then
    if AComponent = PopupMenu then PopupMenu := nil;
end;

procedure TDBSrchGrid.FillDefPopupMenu (Sender: TObject);
var mLine:TMenuItem;
begin
  If oDBGrid.PopupMenu<>nil then begin
    If not oFillDefPopup then begin
      RemoveDefItemsInPopup;
      If oDBGrid.PopupMenu.Items.Count>0 then begin
        mLine := NewLine;
        mLine.Name := 'Line1';
        oDBGrid.PopupMenu.Items.Add (mLine);
      end;
      oDBGrid.PopupMenu.Items.Add (oPMIndex);
      mLine := NewLine;
      mLine.Name := 'Line2';

      oDBGrid.PopupMenu.Items.Add (mLine);
      oDBGrid.PopupMenu.Items.Add(NewItem(ctGridSum_All, TextToShortCut('Ctrl+S'),False,True,SummaryAllClick, 0,'MenuItemSumAll'));
      oDBGrid.PopupMenu.Items.Add(NewItem(ctGridSum_To, TextToShortCut('Ctrl+D'),False,True,SummaryToClick,0,'MenuItemSumTo'));
      oDBGrid.PopupMenu.Items.Add(NewItem(ctGridSum_From, TextToShortCut('Ctrl+O'),False,True,SummaryFromClick,  0,'MenuItemSumFrom'));
      If EnableMultiSelect then begin
        mLine := NewLine;
        mLine.Name := 'Line3';
        oDBGrid.PopupMenu.Items.Add (mLine);
        oDBGrid.PopupMenu.Items.Add(NewItem(ctGridSum_Sel, TextToShortCut('Ctrl+Shift+S'),False,True,SummarySelClick,  0,'MenuItemSumSel'));
        mLine := NewLine;
        mLine.Name := 'Line4';
        oDBGrid.PopupMenu.Items.Add (mLine);
        oDBGrid.PopupMenu.Items.Add(NewItem(ctGridSum_SelectItm, TextToShortCut('Ctrl+Alt+X'),False,True,SelActClick,  0,'MenuItemSelAct'));
        oDBGrid.PopupMenu.Items.Add(NewItem(ctGridSum_SelectAll, TextToShortCut('Ctrl+Alt+A'),False,True,SelAllClick,  0,'MenuItemSelAll'));
        oDBGrid.PopupMenu.Items.Add(NewItem(ctGridSum_DeselectAll, TextToShortCut('Ctrl+Shift+A'),False,True,DeselAllClick,  0,'MenuItemDeselAll'));
      end;

      mLine := NewLine;
      mLine.Name := 'Line5';
      oDBGrid.PopupMenu.Items.Add (mLine);
      oDBGrid.PopupMenu.Items.Add(NewItem(ctGridSum_Clipb, TextToShortCut(''),False,True,CopyToClipboardClick,  0,'MenuItemClipboard'));
      oDBGrid.PopupMenu.Items.Add(NewItem(ctGridSum_XLS, TextToShortCut(''),False,True,CopyToXLSClick,  0,'MenuItemXLS'));
      oFillDefPopup := TRUE;
    end;
  end;
end;

procedure TDBSrchGrid.RemoveDefItemsInPopup;
var
  I:integer;
  mName:string;
begin
  If Assigned (oDBGrid.PopupMenu) and (oDBGrid.PopupMenu<>nil) then begin
    If oDBGrid.PopupMenu.Items.Count>0 then begin
      I := 0;
      While (I<oDBGrid.PopupMenu.Items.Count) do begin
        mName := oDBGrid.PopupMenu.Items[I].Name;
        If (mName=oPMIndex.Name)
           or (mName='MenuItemSumAll')
           or (mName='MenuItemSumTo')
           or (mName='MenuItemSumFrom')
           or (mName='Line1')
           or (mName='Line2')
          then begin
            oDBGrid.PopupMenu.Items.Remove (oDBGrid.PopupMenu.Items[I]);
          end else Inc (I);
      end;
    end;
  end;
end;

function  TDBSrchGrid.VerifyFindData (var pRV:TRangeValues):boolean;
var
  mIndexFlds:string;
  mFld:string;
  mOK :boolean;
  mCnt:integer;
  mInt:integer;
  mDoub:double;
  mCode:integer;
begin
  mOK := TRUE;
  mCnt := 0;
  mIndexFlds := oActIndexs.Strings[oActIndex-1];
  mIndexFlds := Copy (mIndexFlds,Pos ('|',mIndexFlds)+1,Length (mIndexFlds));
  While (mIndexFlds<>'') and (mCnt<oSelFldQnt) and mOK do begin
    CutNextParamSepar (mIndexFlds,mFld,';');
    case oDataSource.DataSet.FieldByName (mFld).DataType of
      ftSmallint, ftInteger, ftWord, ftBytes, ftVarBytes, ftAutoInc,ftLargeint: begin
        Val (pRV[mCnt+1],mInt,mCode);
        mOK := (mCode=0);
      end;
      ftFloat, ftCurrency: begin
        If Pos (',',pRV[mCnt+1])>0 then pRV[mCnt+1] := ReplaceStr (pRV[mCnt+1],',','.');
        Val (pRV[mCnt+1],mDoub,mCode);
        mOK := (mCode=0);
      end;
      ftDate: begin
        If pRV[mCnt+1]<>'' then begin
          try
//            StrToDate(pRV[mCnt+1]);
            pRV[mCnt+1] := VerifyDate (pRV[mCnt+1]);
          except mOK := FALSE; end;
        end;
      end;
      ftTime: begin
        If pRV[mCnt+1]<>'' then begin
          try
            StrToTime(pRV[mCnt+1]);
          except mOK := FALSE; end;
        end;
      end;
      ftDateTime: begin
        If pRV[mCnt+1]<>'' then begin
          try
            StrToDateTime(pRV[mCnt+1]);
          except mOK := FALSE; end;
        end;
      end;
    end;
    Inc (mCnt);
  end;
  VerifyFindData := mOK;
end;

function  TDBSrchGrid.CutFldInSrchFld (pFld:string):string;
begin
  If pFld<>'' then begin
    If Copy (pFld,1,1)='_' then pFld := Copy (pFld,2,Length (pFld));
    If Copy (pFld,Length (pFld),1)='_' then pFld := Copy (pFld,1,Length (pFld)-1);
  end;
  Result := pFld;
end;

procedure TDBSrchGrid.MyButtOnClick (Sender: TObject);
begin
  oSearchLnFocused := TRUE;
  If Assigned (eOnFocusedChange) then eOnFocusedChange (Sender);
  oStringGrid.SetFocus;
end;

procedure TDBSrchGrid.MyOnEnter (Sender: TObject);
begin
  oSearchLnFocused := TRUE;
  If Assigned (eOnFocusedChange) then eOnFocusedChange (Sender);
  SetDBGridFocus;
end;

procedure TDBSrchGrid.MyOnExit (Sender: TObject);
begin
  oDBGrid.Focused := FALSE;
//  oDBGrid.Options := oDBGrid.Options - [dgMultiSelect];
  oDBGrid.LeftCol := oStringGrid.LeftCol+1;
  If oSearchLnClear then
  begin
    ClearSearchData;
    oDBGrid.Repaint;
    SetIndexField;
    If not oTabStop then begin
      oDBGrid.TabStop := FALSE;
      oStringGrid.TabStop := FALSE;
    end;
  end;
end;

procedure TDBSrchGrid.MyOnDBGridStateChange (Sender: TObject);
begin
  If oBefState=dsInactive then begin
    SetCompParam;
    ReadIndexs;
    oActIndex := 1;
    SetIndexField;
    oBefState := oDBGrid.DataSource.State;
  end;
end;

procedure TDBSrchGrid.MyIndexColorOnChange (Sender: TObject);
begin
  SetIndexColor;
  oStringGrid.Repaint;
end;

procedure TDBSrchGrid.MyOnDrawColorRow (Sender:TObject;var pColorRow:TColor; pField:TField;pFirstFld:boolean);
begin
  If Assigned (eOnDrawColorRow) then eOnDrawColorRow (Sender, pColorRow, pField, pFirstFld);
end;

procedure TDBSrchGrid.SummaryAllClick(Sender: TObject);
begin
  ShowSumData (stAll);
end;

procedure TDBSrchGrid.SummaryFromClick(Sender: TObject);
begin
  ShowSumData (stFrom);
end;

procedure TDBSrchGrid.SummaryToClick(Sender: TObject);
begin
  ShowSumData (stTo);
end;

procedure  TDBSrchGrid.SummarySelClick(Sender: TObject);
begin
  ShowSelSum;
end;

procedure  TDBSrchGrid.SelActClick(Sender: TObject);
begin
  ActRecSelect;
end;

procedure  TDBSrchGrid.SelAllClick(Sender: TObject);
begin
  AllRecSelect;
end;

procedure  TDBSrchGrid.DeselAllClick(Sender: TObject);
begin
  AllRecDeselect;
end;

procedure TDBSrchGrid.CopyToClipboardClick(Sender: TObject);
var mBM:TBookMark;
    mStandard:boolean;
    mS:string;
    I:longint;
    mMemo:TMemo;
begin
  If oDBGrid.DataSource.DataSet is TBtrieveTable then begin
    If oDBGrid.FieldCount>0 then begin
      (oDBGrid.DataSource.DataSet as TBtrieveTable).SwapStatus;
      oDBGrid.DataSource.DataSet.DisableControls;
      mMemo := TMemo.Create(Self);
      mMemo.Width := 0;
      mMemo.Height := 0;
      mMemo.Parent := Self;
      mMemo.Clear;
      oDBGrid.DataSource.DataSet.First;
      Repeat
        mS := '';
        For I:=0 to oDBGrid.FieldCount-1 do begin
          If I>0 then mS := mS+Chr (VK_TAB);
          mS := mS+oDBGrid.Fields[I].AsString;
        end;
        mMemo.Lines.Add(mS);
        oDBGrid.DataSource.DataSet.Next;
      until oDBGrid.DataSource.DataSet.EOF;
      mMemo.SelectAll;
      mMemo.CopyToClipboard;
      FreeAndNil (mMemo);
      (oDBGrid.DataSource.DataSet as TBtrieveTable).RestoreStatus;
      oDBGrid.DataSource.DataSet.EnableControls;
    end;
  end else begin
    If oDBGrid.FieldCount>0 then begin
      mMemo := TMemo.Create(Self);
      mMemo.Width := 0;
      mMemo.Height := 0;
      mMemo.Parent := Self;
      mMemo.Clear;
      mBM := oDBGrid.DataSource.DataSet.GetBookmark;
      oDBGrid.DataSource.DataSet.DisableControls;
      oDBGrid.DataSource.DataSet.First;
      Repeat
        mS := '';
        For I:=0 to oDBGrid.FieldCount-1 do begin
          If I>0 then mS := mS+Chr (VK_TAB);
          mS := mS+oDBGrid.Fields[I].AsString;
        end;
        mMemo.Lines.Add(mS);
        oDBGrid.DataSource.DataSet.Next;
      until oDBGrid.DataSource.DataSet.EOF;
      mMemo.SelectAll;
      mMemo.CopyToClipboard;
      oDBGrid.DataSource.DataSet.GotoBookmark(mBM);
      oDBGrid.DataSource.DataSet.FreeBookmark(mBM);
      oDBGrid.DataSource.DataSet.EnableControls;
      FreeAndNil (mMemo);
    end;
  end;
end;

procedure TDBSrchGrid.CopyToXLSClick(Sender: TObject);
var mBM:TBookMark;
    mStandard:boolean;
    mS:string;
    I,J:longint;
    mXLS:TFreeExcelS;
begin
  If oDBGrid.DataSource.DataSet is TBtrieveTable then begin
    If oDBGrid.FieldCount>0 then begin
      mXls:=TFreeExcelS.Create(gpath.ExpPath+(oDBGrid.DataSource.DataSet as TBtrieveTable).TableName+'.SLK');
      mXLS.SetFont(Arial,12,[B]);
      (oDBGrid.DataSource.DataSet as TBtrieveTable).SwapStatus;
      oDBGrid.DataSource.DataSet.DisableControls;
      For I:=0 to oDBGrid.FieldCount-1 do
      begin
        mXLS.SirkaSloupce(I+1,{oDBGrid.Columns[I].Width}oDBGrid.Fields[I].Size);
        mXLS.SetBorder([BoLeft,BoRight,BoTop,BoBottom]);
        mXLS.TextPosition(TP_Center);
        mXLS.Retezec(1,I+1,oDBGrid.Fields[I].DisplayName,oDBGrid.Fields[I].FullName);
      end;
      mXLS.SetFont(Arial,12,[]);
      mXLS.SetBorder([]);
      oDBGrid.DataSource.DataSet.First;
      J:=1;
      Repeat
        Inc(J);
        For I:=0 to oDBGrid.FieldCount-1 do
        begin
          case oDBGrid.Fields[I].DataType of
            ftString      : begin mXLS.TextPosition(TP_Left);mXLS.Retezec(J,I+1,oDBGrid.Fields[I].AsString,'');end;
            ftSmallint,
            ftInteger,
            ftWord        : begin mXLS.TextPosition(TP_Right);mXLS.NumericType(J,I+1,oDBGrid.Fields[I].AsFloat,0,'');end;
            ftBoolean     : begin mXLS.TextPosition(TP_Center);mXLS.Retezec(J,I+1,oDBGrid.Fields[I].AsString,'');end;
            ftFloat       : begin mXLS.TextPosition(TP_Right);mXLS.Float(J,I+1,oDBGrid.Fields[I].AsFloat,'');end;
            ftCurrency    : begin mXLS.TextPosition(TP_Right);mXLS.Float(J,I+1,oDBGrid.Fields[I].AsFloat,'');end;
            ftDate        : begin mXLS.TextPosition(TP_Right);mXLS.Date(J,I+1,oDBGrid.Fields[I].AsDateTime,'');end;
            ftTime        : begin mXLS.TextPosition(TP_Right);mXLS.DateTime(J,I+1,oDBGrid.Fields[I].AsDateTime,'');end;
            ftDateTime    : begin mXLS.TextPosition(TP_Right);mXLS.DateTime(J,I+1,oDBGrid.Fields[I].AsDateTime,'');end;
            else begin mXLS.TextPosition(TP_Right);mXLS.Retezec(J,I+1,oDBGrid.Fields[I].AsString,'');end;
          end;
        end;
        oDBGrid.DataSource.DataSet.Next;
      until oDBGrid.DataSource.DataSet.EOF;
      (oDBGrid.DataSource.DataSet as TBtrieveTable).RestoreStatus;
      oDBGrid.DataSource.DataSet.EnableControls;
    end;
  end else begin
    If oDBGrid.FieldCount>0 then begin
      mXls:=TFreeExcelS.Create(gpath.ExpPath+oDBGrid.DataSource.DataSet.Name+'.XLS');
      mXLS.SetFont(Arial,12,[B]);
      mBM := oDBGrid.DataSource.DataSet.GetBookmark;
      oDBGrid.DataSource.DataSet.DisableControls;
      For I:=0 to oDBGrid.FieldCount-1 do
      begin
        mXLS.SirkaSloupce(I+1,{oDBGrid.Columns[I].Width}oDBGrid.Fields[I].Size);
        mXLS.SetBorder([BoLeft,BoRight,BoTop,BoBottom]);
        mXLS.TextPosition(TP_Center);
        mXLS.Retezec(1,I+1,oDBGrid.Fields[I].DisplayName,oDBGrid.Fields[I].FullName);
      end;
      mXLS.SetFont(Arial,12,[]);
      mXLS.SetBorder([]);
      oDBGrid.DataSource.DataSet.First;
      J:=1;
      Repeat
        Inc(J);
        For I:=0 to oDBGrid.FieldCount-1 do begin
          case oDBGrid.Fields[I].DataType of
            ftString      : begin mXLS.TextPosition(TP_Left);mXLS.Retezec(J,I+1,oDBGrid.Fields[I].AsString,'');end;
            ftSmallint,
            ftInteger,
            ftWord        : begin mXLS.TextPosition(TP_Right);mXLS.NumericType(J,I+1,oDBGrid.Fields[I].AsFloat,0,'');end;
            ftBoolean     : begin mXLS.TextPosition(TP_Center);mXLS.Retezec(J,I+1,oDBGrid.Fields[I].AsString,'');end;
            ftFloat       : begin mXLS.TextPosition(TP_Right);mXLS.Float(J,I+1,oDBGrid.Fields[I].AsFloat,'');end;
            ftCurrency    : begin mXLS.TextPosition(TP_Right);mXLS.Float(J,I+1,oDBGrid.Fields[I].AsFloat,'');end;
            ftDate        : begin mXLS.TextPosition(TP_Right);mXLS.Date(J,I+1,oDBGrid.Fields[I].AsDateTime,'');end;
            ftTime        : begin mXLS.TextPosition(TP_Right);mXLS.DateTime(J,I+1,oDBGrid.Fields[I].AsDateTime,'');end;
            ftDateTime    : begin mXLS.TextPosition(TP_Right);mXLS.DateTime(J,I+1,oDBGrid.Fields[I].AsDateTime,'');end;
            else begin mXLS.TextPosition(TP_Right);mXLS.Retezec(J,I+1,oDBGrid.Fields[I].AsString,'');end;
          end;
        end;
        oDBGrid.DataSource.DataSet.Next;
      until oDBGrid.DataSource.DataSet.EOF;
      oDBGrid.DataSource.DataSet.GotoBookmark(mBM);
      oDBGrid.DataSource.DataSet.FreeBookmark(mBM);
      oDBGrid.DataSource.DataSet.EnableControls;
    end;
  end;
  FreeandNIL(mXls);
end;

procedure TDBSrchGrid.ShowSumData (pSumType:TSumType);
var
  mIt           :longint;
  mVal,mMin,mMax:double;
begin
  If oDBGrid.SelectedField is TNumericField then begin
    ShowProcInd(ctGridSum_HeadPISum,oDBGrid.DataSource.DataSet.RecordCount);
    CalcSum (pSumType,oDBGrid.SelectedField.FieldName,mIt,mVal,mMin,mMax);
    If not GetProcIndExit then begin
      CloseProcInd;
      ExecuteGridSum (pSumType,oDBGrid.SelectedField.DisplayName,mIt,mVal,mMin,mMax);
    end else begin
      CloseProcInd;
    end;
  end else MessageDlg (ctGridSum_BadField, mtWarning,[mbOK], 0);
end;

procedure TDBSrchGrid.CalcSum (pSumType:TSumType;pFld:string;var pIt:integer;var pVal,pMin,pMax:double);
var mBM:TBookMark;
begin
  If oDBGrid.DataSource.DataSet is TBtrieveTable then begin
    (oDBGrid.DataSource.DataSet as TBtrieveTable).SwapStatus;
  end else begin
    mBM := oDBGrid.DataSource.DataSet.GetBookmark;
  end;
    oDBGrid.DataSource.DataSet.DisableControls;
  case pSumType of
    stAll : CalcSumAll  (pFld,pIt,pVal,pMin,pMax);
    stTo  : CalcSUmTo   (pFld,pIt,pVal,pMin,pMax);
    stFrom: CalcSumFrom (pFld,pIt,pVal,pMin,pMax);
  end;
  If oDBGrid.DataSource.DataSet is TBtrieveTable then begin
    (oDBGrid.DataSource.DataSet as TBtrieveTable).RestoreStatus;
  end else begin
    oDBGrid.DataSource.DataSet.GotoBookmark(mBM);
    oDBGrid.DataSource.DataSet.FreeBookmark(mBM);
  end;
  oDBGrid.DataSource.DataSet.EnableControls;
end;

procedure TDBSrchGrid.CalcSumAll (pFld:string; var pIt:integer;var pVal,pMin,pMax:double);
begin
  pVal := 0;
  pMin := oDBGrid.DataSource.DataSet.FieldByName (pFld).AsFloat;
  pMax := oDBGrid.DataSource.DataSet.FieldByName (pFld).AsFloat;
  pIt  := 0;
  oDBGrid.DataSource.DataSet.First;
  Repeat
    pVal := pVal+oDBGrid.DataSource.DataSet.FieldByName (pFld).AsFloat;
    If pMin>oDBGrid.DataSource.DataSet.FieldByName (pFld).AsFloat then pMin := oDBGrid.DataSource.DataSet.FieldByName (pFld).AsFloat;
    If pMax<oDBGrid.DataSource.DataSet.FieldByName (pFld).AsFloat then pMax := oDBGrid.DataSource.DataSet.FieldByName (pFld).AsFloat;
    StepProcInd;
    Application.ProcessMessages;
    oDBGrid.DataSource.DataSet.Next;
    Inc (pIt);
  until oDBGrid.DataSource.DataSet.EOF or GetProcIndExit;
end;

procedure TDBSrchGrid.CalcSumTo (pFld:string; var pIt:integer;var pVal,pMin,pMax:double);
begin
  pVal := 0;
  pMin := oDBGrid.DataSource.DataSet.FieldByName (pFld).AsFloat;
  pMax := oDBGrid.DataSource.DataSet.FieldByName (pFld).AsFloat;
  pIt  := 0;
  Repeat
    pVal := pVal+oDBGrid.DataSource.DataSet.FieldByName (pFld).AsFloat;
    If pMin>oDBGrid.DataSource.DataSet.FieldByName (pFld).AsFloat then pMin := oDBGrid.DataSource.DataSet.FieldByName (pFld).AsFloat;
    If pMax<oDBGrid.DataSource.DataSet.FieldByName (pFld).AsFloat then pMax := oDBGrid.DataSource.DataSet.FieldByName (pFld).AsFloat;
    StepProcInd;
    Application.ProcessMessages;
    oDBGrid.DataSource.DataSet.Prior;
    Inc (pIt);
  until oDBGrid.DataSource.DataSet.BOF or GetProcIndExit;
end;

procedure TDBSrchGrid.CalcSumFrom (pFld:string; var pIt:integer;var pVal,pMin,pMax:double);
begin
  pVal := 0;
  pMin := oDBGrid.DataSource.DataSet.FieldByName (pFld).AsFloat;
  pMax := oDBGrid.DataSource.DataSet.FieldByName (pFld).AsFloat;
  pIt  := 0;
  Repeat
    pVal := pVal+oDBGrid.DataSource.DataSet.FieldByName (pFld).AsFloat;
    If pMin>oDBGrid.DataSource.DataSet.FieldByName (pFld).AsFloat then pMin := oDBGrid.DataSource.DataSet.FieldByName (pFld).AsFloat;
    If pMax<oDBGrid.DataSource.DataSet.FieldByName (pFld).AsFloat then pMax := oDBGrid.DataSource.DataSet.FieldByName (pFld).AsFloat;
    StepProcInd;
    Application.ProcessMessages;
    oDBGrid.DataSource.DataSet.Next;
    Inc (pIt);
  until oDBGrid.DataSource.DataSet.EOF or GetProcIndExit;
end;

procedure TDBSrchGrid.CreateSelectTable;
var mCnt:longint; I:longint;
begin
  If oDBGrid.DataSource.DataSet<>nil then begin
    oSelTable.DatabaseName := gPath.SubPrivPath;
    mCnt := 0;
    Repeat
      Inc (mCnt);
      oSelTable.TableName := '_MS'+StrIntZero (mCnt,5)+'.DB'
    until not oSelTable.Exists;

    oSelTable.FieldDefs.Clear;
    oSelTable.IndexDefs.Clear;
    If oDBGrid.DataSource.DataSet is TBtrieveTable then begin
      If oDBGrid.DataSource.DataSet.FieldDefs.Count>0 then begin
        oSelTable.FieldDefs.Add('RecActPos',ftInteger,0,FALSE);
        For I:=0 to oDBGrid.DataSource.DataSet.FieldDefs.Count-1 do begin
          oSelTable.FieldDefs.Add(oDBGrid.DataSource.DataSet.FieldDefs.Items[I].Name, oDBGrid.DataSource.DataSet.FieldDefs.Items[I].DataType, oDBGrid.DataSource.DataSet.FieldDefs.Items[I].Size,FALSE);
        end;
      end;
      If (oDBGrid.DataSource.DataSet as TBtrieveTable).IndexDefs.Count>0 then begin
        oSelTable.IndexDefs.Add('','RecActPos',[ixPrimary]);
        For I:=0 to (oDBGrid.DataSource.DataSet as TBtrieveTable).IndexDefs.Count-1 do begin
          oSelTable.IndexDefs.Add((oDBGrid.DataSource.DataSet as TBtrieveTable).IndexDefs.Items[I].Name,(oDBGrid.DataSource.DataSet as TBtrieveTable).IndexDefs.Items[I].Fields,(oDBGrid.DataSource.DataSet as TBtrieveTable).IndexDefs.Items[I].Options);
        end;
      end;
    end else begin
      If oDBGrid.DataSource.DataSet.FieldDefs.Count>0 then begin
        For I:=0 to oDBGrid.DataSource.DataSet.FieldDefs.Count-1 do begin
          oSelTable.FieldDefs.Add(oDBGrid.DataSource.DataSet.FieldDefs.Items[I].Name, oDBGrid.DataSource.DataSet.FieldDefs.Items[I].DataType, oDBGrid.DataSource.DataSet.FieldDefs.Items[I].Size,FALSE);
        end;
      end;
      If (oDBGrid.DataSource.DataSet as TTable).IndexDefs.Count>0 then begin
        For I:=0 to (oDBGrid.DataSource.DataSet as TTable).IndexDefs.Count-1 do begin
          oSelTable.IndexDefs.Add((oDBGrid.DataSource.DataSet as TTable).IndexDefs.Items[I].Name,(oDBGrid.DataSource.DataSet as TTable).IndexDefs.Items[I].Fields,(oDBGrid.DataSource.DataSet as TTable).IndexDefs.Items[I].Options);
        end;
      end;
    end;

    oSelTable.CreateTable;
    oSelTable.Active := TRUE;
  end;
end;

procedure TDBSrchGrid.ActRecSelect;
begin
  If EnableMultiSelect then begin
    If oDBGrid.DataSource.DataSet<>nil then begin
      If oDBGrid.DataSource.DataSet.RecordCount>0 then begin
        If oSelTable.TableName='' then CreateSelectTable;
        If oSelTable.Active then begin
          If not DataInSelTable
            then AddDataToSelTable
            else oSelTable.Delete;
          oDBGrid.Repaint;
          If Assigned (eOnSelChange) then eOnSelChange (Self,oSelTable.RecordCount);
        end;
      end;
    end;
  end;
end;

procedure TDBSrchGrid.AllRecSelect;
begin
  If EnableMultiSelect then begin
    If oDBGrid.DataSource.DataSet<>nil then begin
      If oDBGrid.DataSource.DataSet.RecordCount>0 then begin
        If oSelTable.TableName='' then CreateSelectTable;
        If oSelTable.Active then begin
          oDBGrid.DataSource.DataSet.DisableControls;
          oDBGrid.DataSource.DataSet.First;
          ShowProcInd(ctGridSum_HeadPISel,oDBGrid.DataSource.DataSet.RecordCount);
          Repeat
            If not DataInSelTable then AddDataToSelTable;
            StepProcInd;
            Application.ProcessMessages;
            oDBGrid.DataSource.DataSet.Next;
          until oDBGrid.DataSource.DataSet.Eof or GetProcIndExit;
          CloseProcInd;
          oDBGrid.DataSource.DataSet.EnableControls;
          oDBGrid.Repaint;
          If Assigned (eOnSelChange) then eOnSelChange (Self,oSelTable.RecordCount);
        end;
      end;
    end;
  end;
end;

procedure TDBSrchGrid.AllRecDeselect;
begin
  If EnableMultiSelect then begin
    If oDBGrid.DataSource.DataSet<>nil then begin
      If oSelTable.TableName<>'' then begin
        oSelTable.Active := FALSE;
        oSelTable.EmptyTable;
        oSelTable.Active := TRUE;
      end;
      oDBGrid.Repaint;
      If Assigned (eOnSelChange) then eOnSelChange (Self,oSelTable.RecordCount);
    end;
  end;
end;

function  TDBSrchGrid.DataInSelTable:boolean;
var mData: array [1..10] of string; I:longint; mIndexQnt:byte;
begin
  Result := FALSE;
  If (oDBGrid.DataSource.DataSet<>nil) and oDBGrid.DataSource.DataSet.Active then begin
    If oSelTable.Active then begin
      oSelTable.IndexName := '';
      If oDBGrid.DataSource.DataSet is TBtrieveTable then begin
        Result := (oSelTable.RecordCount>0) and  oSelTable.FindKey ([(oDBGrid.DataSource.DataSet as TBtrieveTable).ActPos]);
      end else begin
//        mIndexQnt := (oDBGrid.DataSource.DataSet as TTable).IndexFieldCount+1; Tibi 08.03.2006 Zle urèil poèet polí v indexe
        mIndexQnt := oSelTable.IndexFieldCount;
        For I:=1 to mIndexQnt do begin
          If I<=10 then mData[I] := oDBGrid.DataSource.DataSet.FieldByName (oDBGrid.DataSource.DataSet.FieldDefs.Items[I-1].Name).AsString;
        end;
        case mIndexQnt of
          1 : Result := oSelTable.FindKey([mData[1]]);
          2 : Result := oSelTable.FindKey([mData[1],mData[2]]);
          3 : Result := oSelTable.FindKey([mData[1],mData[2],mData[3]]);
          4 : Result := oSelTable.FindKey([mData[1],mData[2],mData[3],mData[4]]);
          5 : Result := oSelTable.FindKey([mData[1],mData[2],mData[3],mData[4],mData[5]]);
          6 : Result := oSelTable.FindKey([mData[1],mData[2],mData[3],mData[4],mData[5],mData[6]]);
          7 : Result := oSelTable.FindKey([mData[1],mData[2],mData[3],mData[4],mData[5],mData[6],mData[7]]);
          8 : Result := oSelTable.FindKey([mData[1],mData[2],mData[3],mData[4],mData[5],mData[6],mData[7],mData[8]]);
          9 : Result := oSelTable.FindKey([mData[1],mData[2],mData[3],mData[4],mData[5],mData[6],mData[7],mData[8],mData[9]]);
          10: Result := oSelTable.FindKey([mData[1],mData[2],mData[3],mData[4],mData[5],mData[6],mData[7],mData[8],mData[9],mData[10]]);
        end;
      end;
    end;
  end;
end;

procedure TDBSrchGrid.AddDataToSelTable;
var I:longint;
begin
  try
    oSelTable.Insert;
    If oDBGrid.DataSource.DataSet is TBtrieveTable then begin
      oSelTable.FieldByName ('RecActPos').AsInteger := (oDBGrid.DataSource.DataSet as TBtrieveTable).ActPos;
    end;
    For I:=0 to oDBGrid.DataSource.DataSet.FieldCount-1 do begin
      oSelTable.FieldByName (oDBGrid.DataSource.DataSet.Fields[I].FieldName).AsString := oDBGrid.DataSource.DataSet.Fields[I].AsString;
    end;
    oSelTable.Post;
  except end;
end;

procedure TDBSrchGrid.CalcSelSum(pFld:string; var pIt:integer;var pVal,pMin,pMax:double);
var mTable:TTable;
begin
  If oSelTable.Active and (oSelTable.RecordCount>0) then begin
    mTable := TTable.Create(Self);
    SetSelTableParam (mTable);
    mTable.Active := TRUE;
    mTable.First;
    pVal := 0;
    pMin := mTable.FieldByName (pFld).AsFloat;
    pMax := mTable.FieldByName (pFld).AsFloat;
    pIt  := 0;
    Repeat
      pVal := pVal+mTable.FieldByName (pFld).AsFloat;
      If pMin>mTable.FieldByName (pFld).AsFloat then pMin := mTable.FieldByName (pFld).AsFloat;
      If pMax<mTable.FieldByName (pFld).AsFloat then pMax := mTable.FieldByName (pFld).AsFloat;
      StepProcInd;
      Application.ProcessMessages;
      mTable.Next;
      Inc (pIt);
    until mTable.EOF or GetProcIndExit;
    mTable.Active := FALSE;
    FreeAndNil (mTable);
  end;
end;

procedure TDBSrchGrid.ShowSelSum;
var
  mIt           :longint;
  mVal,mMin,mMax:double;
begin
  If oDBGrid.SelectedField is TNumericField then begin
    ShowProcInd(ctGridSum_HeadPISum,oSelTable.RecordCount);
    CalcSelSum(oDBGrid.SelectedField.FieldName,mIt,mVal,mMin,mMax);
    If not GetProcIndExit then begin
      CloseProcInd;
      ExecuteGridSum (stSel,oDBGrid.SelectedField.DisplayName,mIt,mVal,mMin,mMax);
    end else begin
      CloseProcInd;
    end;
  end else MessageDlg (ctGridSum_BadField, mtWarning,[mbOK], 0);
end;

procedure TDBSrchGrid.FillFixSrchFld;
var I, mNum:longint; mS:string;
begin
  If (oFixSrchField<>'') and not oFindBegin then begin
    If Copy (oActIndexFields, 1, Length (oFixSrchField)+1)=oFixSrchField+';' then begin
      If FindFieldInGrid (oFixSrchField, mNum) then begin
        If oStringGrid.ColCount>mNum then begin
          If oSetData[2]='' then begin
            mS := oDBGrid.DataSource.DataSet.FieldByName (oFixSrchField).AsString;
            oSetData[1] := mS;
            For I:=0 to oStringGrid.ColCount do
              oStringGrid.Cells[I,0] := '';
            oStringGrid.Cells[mNum, 0] := oSetData[1];
            If mS<>'' then oSelFldQnt := 2;
            SetIndexColor;
          end;
        end;
      end;
    end;
  end;
end;

procedure TDBSrchGrid.RepaintGrid;
begin
  If cGridPairRowSelect then oDBGrid.Repaint;
end;

end.
