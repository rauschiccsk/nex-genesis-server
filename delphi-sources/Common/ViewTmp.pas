unit ViewTmp;

interface

uses
  IcTypes, LangForm, BtrTable, NexMsg, TableView, ApplicView, NexPxTable, PxTable,
  Windows, Messages, SysUtils, Classes, Graphics, Controls,
  Forms, Dialogs, DB, ExtCtrls, AdvGrid, SrchGrid, ActnList, IcActionList;

type
  // Definicia formulara
  TF_ViewTmp = class(TLangForm)
    ApplicView: TApplicView;
    IcActionList1: TIcActionList;
    A_Exit: TAction;
    procedure A_ExitExecute(Sender: TObject);
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
    procedure Execute (pDataSet:TNexPxTable; pDgdName:Str8);overload;
    procedure Execute (pDataSet:TPxTable; pDgdName:Str8);overload;
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

implementation

{$R *.DFM}

procedure TF_ViewTmp.Execute (pDataSet:TNexPxTable; pDgdName:Str8);
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
  ShowModal;
end;

procedure TF_ViewTmp.Execute (pDataSet:TPxTable; pDgdName:Str8);
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
  ShowModal;
end;

procedure TF_ViewTmp.MyOnSelected(Sender: TObject);
begin
  oRecordSelect := TRUE;;
  If Assigned (eOnSelected) then eOnSelected(Sender);
  Close;
end;

procedure TF_ViewTmp.MyOnKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
begin
  If Assigned (eOnKeyDown) then eOnKeyDown(Sender,Key,Shift);
  If (Key=VK_ESCAPE) then begin
    oRecordSelect := FALSE;
    Close;
  end;
end;

procedure TF_ViewTmp.MyOnInsPressed(Sender: TObject);
begin
  If Assigned (eOnInsPressed) then eOnInsPressed(Sender);
end;

procedure TF_ViewTmp.MyOnModPressed(Sender: TObject);
begin
  If Assigned (eOnModPressed) then eOnModPressed(Sender);
end;

procedure TF_ViewTmp.MyOnDelPressed(Sender: TObject);
begin
  If not Assigned (eOnDelPressed) then begin
//    If AskYes (1,'') then ApplicView.DataSet.Delete;
  end
  else eOnDelPressed(Sender);
end;

procedure TF_ViewTmp.MyOnDataChange(Sender: TObject; Field: TField);
begin
  If Assigned (eOnDataChange) then eOnDataChange(Sender,Field);
end;

procedure TF_ViewTmp.MyOnPrint(Sender: TObject);
begin
  If Assigned (eOnPrint) then eOnPrint(Sender);
end;

procedure TF_ViewTmp.MyOnFilter(Sender: TObject);
begin
  If Assigned (eOnFilter) then eOnFilter(Sender);
end;

procedure TF_ViewTmp.MyOnExitPrg(Sender: TObject);
begin
  If Assigned (eOnExitPrg) then eOnExitPrg(Sender);
end;

procedure TF_ViewTmp.A_ExitExecute(Sender: TObject);
begin
  Close;
end;

end.
