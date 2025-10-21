unit V_FormDB;

interface

uses
  IcTypes, LangForm, DBTables, NexMsg, TableView, ApplicView,
  Windows, Messages, SysUtils, Classes, Graphics, Controls,
  Forms, Dialogs, DB, ExtCtrls, AdvGrid, SrchGrid;

type
  // Definicia formulara
  TF_V_FormDB = class(TLangForm)
    ApplicView: TApplicView;
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
    procedure Execute (pDataSet: TTable; pDgdName:Str8);
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
  TV_FormDB = class (TComponent)
  public
    oForm: TF_V_FormDB;
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
    procedure ExecuteAndRefreshGrid;
  private
    oDataSet: TTable;
    oDgdName: Str8;
    oRecordSelect: boolean; // TRUE ak bola vybrana niektora polozka
  published
    property DataSet: TTable read oDataSet write oDataSet;
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


procedure Register;

implementation

// ************* Definicia komponentu ***************

constructor TV_FormDB.Create (pOwner:TComponent);
begin
  inherited Create (pOwner);
end;

destructor TV_FormDB.Destroy;
begin
  If Assigned (oForm) then oForm.Destroy;
  inherited;
end;

procedure TV_FormDB.ExecuteAndRefreshGrid;
var mProba: integer;
begin
  If not Assigned(oForm) then begin
    oForm := TF_V_FormDB.Create (Self);
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


procedure TV_FormDB.Execute;
var mProba: integer;
begin
  If not Assigned(oForm) then begin
    oForm := TF_V_FormDB.Create (Self);
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

// *************** Definicia formulara ***************

{$R *.DFM}

procedure TF_V_FormDB.Execute (pDataSet: TTable; pDgdName:Str8);
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

procedure TF_V_FormDB.MyOnSelected(Sender: TObject);
begin
  oRecordSelect := TRUE;;
  If Assigned (eOnSelected) then eOnSelected(Sender);
  Close;
end;

procedure TF_V_FormDB.MyOnKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
begin
  If Assigned (eOnKeyDown) then eOnKeyDown(Sender,Key,Shift);
  If (Key=VK_ESCAPE) then begin
    oRecordSelect := FALSE;
    Close;
  end;
end;

procedure TF_V_FormDB.MyOnInsPressed(Sender: TObject);
begin
  If Assigned (eOnInsPressed) then eOnInsPressed(Sender);
end;

procedure TF_V_FormDB.MyOnModPressed(Sender: TObject);
begin
  If Assigned (eOnModPressed) then eOnModPressed(Sender);
end;

procedure TF_V_FormDB.MyOnDelPressed(Sender: TObject);
begin
  If not Assigned (eOnDelPressed) then begin
//    If AskYes (1,'') then ApplicView.DataSet.Delete;
  end
  else eOnDelPressed(Sender);
end;

procedure TF_V_FormDB.MyOnDataChange(Sender: TObject; Field: TField);
begin
  If Assigned (eOnDataChange) then eOnDataChange(Sender,Field);
end;

procedure TF_V_FormDB.MyOnPrint(Sender: TObject);
begin
  If Assigned (eOnPrint) then eOnPrint(Sender);
end;

procedure TF_V_FormDB.MyOnFilter(Sender: TObject);
begin
  If Assigned (eOnFilter) then eOnFilter(Sender);
end;

procedure TF_V_FormDB.MyOnExitPrg(Sender: TObject);
begin
  If Assigned (eOnExitPrg) then eOnExitPrg(Sender);
end;


//***************************************************
procedure Register;
begin
  RegisterComponents('IcDataAccess', [TV_FormDB]);
end;

end.
