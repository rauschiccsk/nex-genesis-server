unit ParLst;
// =============================================================================
//                           VÝBEROVÝ ZOZNAM PARTNEROV
// -----------------------------------------------------------------------------
// Táto umožní vybra potrebného obchodného partnera z výberového zoznamu.
// -----------------------------------------------------------------------------
// ************************* POUŽITÉ DATABÁZOVÉ SÚBORY *************************
// -----------------------------------------------------------------------------
// -----------------------------------------------------------------------------
// *********************** POPIS PRIVATE FUNKCIÍ OBJEKTU ***********************
// -----------------------------------------------------------------------------
// -----------------------------------------------------------------------------
// ************************ POPIS PUBLIC FUNKCIÍ OBJEKTU ***********************
// -----------------------------------------------------------------------------
//
// -----------------------------------------------------------------------------
// ********************************* POZNÁMKY **********************************
// -----------------------------------------------------------------------------
//
// -----------------------------------------------------------------------------
// ****************************** HISTÓRIA ZMIEN *******************************
// -----------------------------------------------------------------------------
// 21.04[08.03.2019] - Nová funkcia (RZ)
// =============================================================================

interface

uses
  LangForm, IcTypes, IcTools, IcConv, NexMsg, NexError, NexIni, NexGlob, hPARCAT,
  IcStand, IcButtons, IcEditors, CmpTools, DbSrGrid, Controls, ExtCtrls, Classes, StdCtrls, Buttons, Windows, Messages, SysUtils, Graphics, Forms, Dialogs, ComCtrls,
  IcLabels, IcInfoFields, AdvGrid, SrchGrid, TableView, ActnList, DB, xpComp, ToolWin, Tabs;

type
  TParLst=class(TLangForm)
    ActionList: TActionList;
    A_Exit: TAction;
    A_ItmInfo: TAction;
    A_Insert: TAction;
    A_Edit: TAction;
    A_StcLst: TAction;
    A_PlsSlct: TAction;
    A_FifLst: TAction;
    A_StmLst: TAction;
    A_BcSrch: TAction;
    A_TreeView: TAction;
    xpStatusLine1: TxpStatusLine;
    P_Inf: TxpSinglePanel;
    P_Txt: TPanel;
    H_Txt: TLabel;
    T_Txt: TLabel;
    P_Ico: TxpSinglePanel;
    I_Ico: TImage;
    P_EmlHis: TxpSinglePanel;
    P_DocNum: TxpSinglePanel;
    L_HedTxt: TxpLabel;
    Tv_ParLst: TTableView;
    procedure FormCreate(Sender:TObject);
    procedure FormDestroy(Sender:TObject);
    procedure A_ExitExecute(Sender:TObject);
    procedure FormShow(Sender:TObject);
    procedure Tv_ParLstSelected(Sender: TObject);
  private
    procedure LodLasSet;  // Nacita posledne nastavenia
    procedure SavLasSet;  // Ulozi posledne nastavenia
  public
    ohPARCAT:TParcatHnd;
    procedure Execute(pParNum:longint);
  end;

implementation

{$R *.DFM}

procedure TParLst.FormCreate(Sender:TObject);
begin
  ohPARCAT:=TParcatHnd.Create;
end;

procedure TParLst.FormShow(Sender: TObject);
begin
  //
end;

procedure TParLst.FormDestroy(Sender: TObject);
begin
  FreeAndNil(ohPARCAT);
end;

procedure TParLst.Execute(pParNum:longint);
begin
  Accept:=FALSE;
  LodLasSet; // Nacita posledne nastavenia
  If not ohPARCAT.Active then ohPARCAT.Open;
  If pParNum>0 then ohPARCAT.LocParNum(pParNum);
  Tv_ParLst.DataSet:=ohPARCAT.Table;
  ShowModal;
  SavLasSet; // Ulozi posledne nastavenia
end;

// ******************************** PRIVATE ************************************

procedure TParLst.LodLasSet;
begin
//  Pc_Pro.ActivePageIndex:=gSet.ReadInteger('PROLST','Pc_Pro.ActivePageIndex',Pc_Pro.ActivePageIndex);
end;

procedure TParLst.SavLasSet;
begin
//  gSet.WriteInteger('PROLST','Pc_Pro.ActivePageIndex',Pc_Pro.ActivePageIndex);
end;

procedure TParLst.A_ExitExecute(Sender: TObject);
begin
  Accept:=FALSE;
  Close;
end;

procedure TParLst.Tv_ParLstSelected(Sender: TObject);
begin
  Accept:=TRUE;
  Close;
end;

end.

