unit ViewForm;

interface

uses
  IcTypes, IcTools, LangForm, NexBtrTable, BtrTable, NexMsg, NexPath,TableView, ApplicView,
  Windows, Messages, SysUtils, Classes, Graphics, Controls,
  Forms, Dialogs, DB, ExtCtrls, AdvGrid, SrchGrid, xpComp, ActnList,
  IcActionList;

type
  // Definicia formulara
  TF_ViewForm = class(TLangForm)
    ApplicView: TApplicView;
    StatusLine: TxpStatusLine;
    ActionList: TIcActionList;
    A_Exi: TAction;
    procedure A_ExiExecute(Sender: TObject);
  private
    oRecordSelect: boolean;
    procedure MyOnSelected(Sender: TObject);
    procedure MyOnKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure MyOnDataChange(Sender: TObject; Field: TField);
    procedure MyOnDelPressed(Sender: TObject);
    procedure MyOnExitPrg(Sender: TObject);
    procedure MyOnFilter(Sender: TObject);
    procedure MyOnInsPressed(Sender: TObject);
    procedure MyOnModPressed(Sender: TObject);
    procedure MyOnPrint(Sender: TObject);
    procedure SetSelectIntStr(pField,pIndex:Str20;pStr:Str200);
  public
    eOnSelected: TNotifyEvent;
    eOnInsPressed: TNotifyEvent;
    eOnModPressed: TNotifyEvent;
    eOnDelPressed: TNotifyEvent;
    eOnKeyDown: TKeyEvent;
    eOnDataChange: TDataChangeEvent;
    eOnPrint: TNotifyEvent;
    eOnFilter: TNotifyEvent;
    eOnExitPrg: TNotifyEvent;
    procedure Execute (pDataSet: TBtrieveTable; pDgdName:Str8);
    procedure ExecuteIntStr(pDataSet: TBtrieveTable; pDgdName:Str8;pField,pIndex:Str20;pStr:Str200);
  published
    property RecordSelect: boolean read oRecordSelect;
    {Events}
    property OnSelected: TNotifyEvent read eOnSelected write eOnSelected;
    property OnInsPressed: TNotifyEvent read eOnInsPressed write eOnInsPressed;
    property OnModPressed: TNotifyEvent read eOnModPressed write eOnModPressed;
    property OnDelPressed: TNotifyEvent read eOnDelPressed write eOnDelPressed;
    property OnKeyDown: TKeyEvent read eOnKeyDown write eOnKeyDown;
    property OnDataChange: TDataChangeEvent read eOnDataChange write eOnDataChange;
    property OnPrint: TNotifyEvent read eOnPrint write eOnPrint;
    property OnFilter: TNotifyEvent read eOnFilter write eOnFilter;
    property OnExitPrg: TNotifyEvent read eOnExitPrg write eOnExitPrg;
  end;


  // Definicia nevizualneho komponentu
  TViewForm = class (TComponent)
  public
    oForm: TF_ViewForm;
    eOnSelected: TNotifyEvent;
    eOnInsPressed: TNotifyEvent;
    eOnModPressed: TNotifyEvent;
    eOnDelPressed: TNotifyEvent;
    eOnKeyDown: TKeyEvent;
    eOnDataChange: TDataChangeEvent;
    eOnPrint: TNotifyEvent;
    eOnFilter: TNotifyEvent;
    eOnExitPrg: TNotifyEvent;
    constructor Create (pOwner:TComponent); override;
    destructor Destroy; override;
    procedure Execute;
    procedure ExecuteIntStr(pField,pIndex:Str20;pStr:Str200);
    procedure ExecuteAndRefreshGrid;
    function  GetSelectIntStr(pField,pIndex:Str20):Str200;
  private
    oDataSet: TBtrieveTable;
    oDgdName: Str8;
    oRecordSelect: boolean; // TRUE ak bola vybrana niektora polozka
    oField  : Str20;
    oIndex  : Str20;
    oStr    : Str200;
  published
    property DataSet: TBtrieveTable read oDataSet write oDataSet;
    property DgdName: Str8 read oDgdName write oDgdName;
    property RecordSelect: boolean read oRecordSelect;
    {Events}
    property OnSelected: TNotifyEvent read eOnSelected write eOnSelected;
    property OnInsPressed: TNotifyEvent read eOnInsPressed write eOnInsPressed;
    property OnModPressed: TNotifyEvent read eOnModPressed write eOnModPressed;
    property OnDelPressed: TNotifyEvent read eOnDelPressed write eOnDelPressed;
    property OnKeyDown: TKeyEvent read eOnKeyDown write eOnKeyDown;
    property OnDataChange: TDataChangeEvent read eOnDataChange write eOnDataChange;
    property OnPrint: TNotifyEvent read eOnPrint write eOnPrint;
    property OnFilter: TNotifyEvent read eOnFilter write eOnFilter;
    property OnExitPrg: TNotifyEvent read eOnExitPrg write eOnExitPrg;
  end;

function GetSelectIntStr(pTable,pField,pIndex:Str20;pStr:Str200):Str200;
// vrati zoznam vybranych zaznamov zadanej databazy zoradenych podla zadenho pola
// pTable = nazov tabulky aj DGD;
// pField = vyberove pole; pIndex = nazov inedxu na zoradenie databazy
// pStr = aktualny uz vybrany retaz ak by nebol vykonany vyber ale opustime zoznam s ESC

procedure Register;

var uVF_Field,uVF_Index:Str20; uVF_Str:Str200;

implementation

function GetSelectIntStr(pTable,pField,pIndex:Str20;pStr:Str200):Str200;
var
  mTable:TNexBtrTable;
  mViewForm: TViewForm;
begin
  mTable:=TNexBtrTable.Create(NIL);
  mTable.DefPath:=gPath.DefPath;
  //mTable.DefName:=pTable;
  mTable.FixedName:=ictools.RemEndNumsDef(pTable);mTable.TableName:=pTable;
  mTable.Open;
  mTable.IndexName:=pIndex;
  mViewForm := TViewForm.Create (NIL);
  mViewForm.DataSet := mTable;
  mViewForm.DgdName := mTable.FixedName; //pTable;
  mViewForm.DataSet := mTable;
  mViewForm.DataSet.IndexName := pIndex;
  mViewForm.ExecuteIntStr(pField,pIndex,pStr);
  If mViewForm.RecordSelect then begin
    Result   := mViewForm.GetSelectIntStr(pField,pField);
  end else Result:=pStr;
  FreeAndNil(mViewForm);
  mTable.Close;FreeAndNil(mTable);
end;

// ************* Definicia komponentu ***************

constructor TViewForm.Create (pOwner:TComponent);
begin
  inherited Create (pOwner);
  oField:='';
  oIndex:='';
  oStr:='';
end;

destructor TViewForm.Destroy;
begin
  If Assigned (oForm) then oForm.Destroy;
  inherited;
end;

procedure TViewForm.ExecuteAndRefreshGrid;
var mProba: integer;
begin
  If not Assigned(oForm) then begin
    oForm := TF_ViewForm.Create (Self);
    oForm.OnSelected := OnSelected;
    oForm.OnInsPressed := OnInsPressed;
    oForm.OnModPressed := OnModPressed;
    oForm.OnDelPressed := OnDelPressed;
    oForm.OnKeyDown := OnKeyDown;
    oForm.OnDataChange := OnDataChange;
    oForm.OnPrint := OnPrint;
    oForm.OnFilter := OnFilter;
    oForm.OnExitPrg := OnExitPrg;
  end;
  oForm.Execute (DataSet,DgdName);
  oForm.ApplicView.oDBSrGrid.RefreshGrid;
  oForm.ShowModal;
  oRecordSelect := oForm.RecordSelect;
end;


procedure TViewForm.Execute;
var mProba: integer;
begin
  If not Assigned(oForm) then begin
    oForm := TF_ViewForm.Create (Self);
    oForm.OnSelected := OnSelected;
    oForm.OnInsPressed := OnInsPressed;
    oForm.OnModPressed := OnModPressed;
    oForm.OnDelPressed := OnDelPressed;
    oForm.OnKeyDown := OnKeyDown;
    oForm.OnDataChange := OnDataChange;
    oForm.OnPrint := OnPrint;
    oForm.OnFilter := OnFilter;
    oForm.OnExitPrg := OnExitPrg;
    oForm.Execute (DataSet,DgdName);
  end;
  oForm.ShowModal;
  oRecordSelect := oForm.RecordSelect;
end;

procedure TViewForm.ExecuteIntStr;
var mProba: integer;
begin
  If not Assigned(oForm) then begin
    oForm := TF_ViewForm.Create (Self);
    oForm.OnSelected := OnSelected;
    oForm.OnInsPressed := OnInsPressed;
    oForm.OnModPressed := OnModPressed;
    oForm.OnDelPressed := OnDelPressed;
    oForm.OnKeyDown := OnKeyDown;
    oForm.OnDataChange := OnDataChange;
    oForm.OnPrint := OnPrint;
    oForm.OnFilter := OnFilter;
    oForm.OnExitPrg := OnExitPrg;
    oForm.ExecuteIntStr (DataSet,DgdName,pField,pIndex,pStr);
  end;
  oForm.ShowModal;
  oRecordSelect := oForm.RecordSelect;
end;

function  TViewForm.GetSelectIntStr(pField,pIndex:Str20):Str200;
var
  mJ,mK,mF,mL: longint;
BEGIN
  oDataset.SwapStatus;
  oDataset.indexName:=pIndex;
  oForm.ApplicView.DataSet.DisableControls;
  oForm.ApplicView.DataSet.First;
  Result:='';
  mF:=-1;mL:=-1;
  While not oForm.ApplicView.DataSet.Eof and (length (Result)<200)do begin
    If oForm.ApplicView.oDBSrGrid.oDBGrid.GetSelectedRow then begin
      mJ:=oForm.ApplicView.DataSet.FieldByName(pField).AsInteger;
      If mF=-1 then begin
        mF:=mJ;
        mL:=mJ-1;
      end;
      If mJ=mL+1 then begin
        mL:= mJ;
      end else begin
        If mL-mF=0
          then Result:=Result+IntToStr (mF)+','
          else Result:=Result+IntToStr (mF)+'..'+IntToStr(mL)+',';
        mF:=mJ;
        mL:=mJ;
      end;
    end;
    oForm.ApplicView.DataSet.Next;
  end;
  If mL-mF>0
    then Result:=Result+IntToStr(mF)+'..'+IntToStr(mL)+','
    else If mF>0 then Result:=Result+IntToStr(mF)+',';
  If Result<>'' then Result:=Copy(Result,1,Length(Result)-1);
  oForm.ApplicView.DataSet.enableControls;
  oDataset.restoreStatus;
  If Result='' then Result:=oDataSet.FieldByName(pField).AsString
end;

// *************** Definicia formulara ***************

{$R *.DFM}

procedure TF_ViewForm.SetSelectIntStr(pField,pIndex:Str20;pStr:Str200);
var
  mJ,mK,mF,mL: longint;
BEGIN
  If (pField='') or (pStr='') or (ApplicView.DataSet.FindField(pField)=NIL) then Exit;
//  ApplicView.Dataset.indexName:=pIndex;
  ApplicView.DataSet.DisableControls;
  ApplicView.DataSet.First;
  While not ApplicView.DataSet.Eof do begin
    If LongInInterval(ApplicView.DataSet.FieldByName(pField).AsInteger,pStr)
      then ApplicView.oDBSrGrid.SelActClick(Self);
    ApplicView.DataSet.Next;
  end;
  ApplicView.DataSet.enableControls;
end;

procedure TF_ViewForm.Execute (pDataSet: TBtrieveTable; pDgdName:Str8);
begin
  ApplicView.OnSelected := MyOnSelected;
  ApplicView.OnKeyDown := MyOnKeyDown;
  ApplicView.OnInsPressed := MyOnInsPressed;
  ApplicView.OnModPressed := MyOnModPressed;
  ApplicView.OnDelPressed := MyOnDelPressed;
  ApplicView.OnDataChange := MyOnDataChange;
  ApplicView.OnPrint := MyOnPrint;
  ApplicView.OnFilter := MyOnFilter;
  ApplicView.OnEscPressed := MyOnExitPrg;
  ApplicView.DGDName := pDgdName;
  ApplicView.DataSet := pDataSet;
  ApplicView.AskBeforExit := FALSE;
  ApplicView.ToolBarHeight := 28;
  ApplicView.Execute;
end;

procedure TF_ViewForm.ExecuteIntStr;
begin
  ApplicView.OnSelected := MyOnSelected;
  ApplicView.OnKeyDown := MyOnKeyDown;
  ApplicView.OnInsPressed := MyOnInsPressed;
  ApplicView.OnModPressed := MyOnModPressed;
  ApplicView.OnDelPressed := MyOnDelPressed;
  ApplicView.OnDataChange := MyOnDataChange;
  ApplicView.OnPrint := MyOnPrint;
  ApplicView.OnFilter := MyOnFilter;
  ApplicView.OnEscPressed := MyOnExitPrg;
  ApplicView.DGDName := pDgdName;
  ApplicView.DataSet := pDataSet;
  ApplicView.AskBeforExit := FALSE;
  ApplicView.ToolBarHeight := 28;
  SetSelectIntStr(pField,pIndex,pStr);
  ApplicView.Execute;
end;

procedure TF_ViewForm.MyOnSelected(Sender: TObject);
begin
  oRecordSelect := TRUE;;
  If Assigned (eOnSelected) then eOnSelected(Sender);
  Close;
end;

procedure TF_ViewForm.MyOnKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
begin
  If Assigned (eOnKeyDown) then eOnKeyDown(Sender,Key,Shift);
  If (Key=VK_ESCAPE) then begin
    oRecordSelect := FALSE;
    Close;
  end;
end;

procedure TF_ViewForm.MyOnInsPressed(Sender: TObject);
begin
  If Assigned (eOnInsPressed) then eOnInsPressed(Sender);
end;

procedure TF_ViewForm.MyOnModPressed(Sender: TObject);
begin
  If Assigned (eOnModPressed) then eOnModPressed(Sender);
end;

procedure TF_ViewForm.MyOnDelPressed(Sender: TObject);
begin
  If not Assigned (eOnDelPressed) then begin
//    If AskYes (1,'') then ApplicView.DataSet.Delete;
  end
  else eOnDelPressed(Sender);
end;

procedure TF_ViewForm.MyOnDataChange(Sender: TObject; Field: TField);
begin
  If Assigned (eOnDataChange) then eOnDataChange(Sender,Field);
end;

procedure TF_ViewForm.MyOnPrint(Sender: TObject);
begin
  If Assigned (eOnPrint) then eOnPrint(Sender);
end;

procedure TF_ViewForm.MyOnFilter(Sender: TObject);
begin
  If Assigned (eOnFilter) then eOnFilter(Sender);
end;

procedure TF_ViewForm.MyOnExitPrg(Sender: TObject);
begin
  If Assigned (eOnExitPrg) then eOnExitPrg(Sender);
end;

//***************************************************
procedure Register;
begin
  RegisterComponents('IcDataAccess', [TViewForm]);
end;

procedure TF_ViewForm.A_ExiExecute(Sender: TObject);
begin
  Close;
end;

end.
{MOD 1903003}
{MOD 1904020}
{MOD 1904027}
