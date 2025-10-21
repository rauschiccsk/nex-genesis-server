unit PacLst;

interface

uses
  LangForm, IcTypes, IcConv, NexMsg, NexSys, hPAB,
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  TableView, ApplicView, ExtCtrls, AdvGrid, SrchGrid, Buttons, IcButtons,
  ActnList;

type
  TPacLstV = class(TLangForm)
    TV_PacLst: TTableView;
    B_Exit: TSpecSpeedButton;
    B_Insert: TSpecSpeedButton;
    B_Edit: TSpecSpeedButton;
    ActionList1: TActionList;
    A_Edit: TAction;
    A_Exit: TAction;
    A_Insert: TAction;
    procedure B_ExitClick(Sender: TObject);
    procedure TV_PacLstSelected(Sender: TObject);
    procedure B_InsertClick(Sender: TObject);
    procedure B_EditClick(Sender: TObject);
  private
    oPaCode:longint;
    oPaName:Str50;
  public
    ohPAB:TPabHnd;
    function Execute(phPAB:TPabHnd):longint;
    procedure OpenPAB;
    procedure ClosePAB;
  published
    property PaCode:longint read oPaCode;
    property PaName:Str50 read oPaName;
  end;

implementation

uses DM_DLSDAT,
     Pab_PacEdit_F;     // Evidencna karta partnera

{$R *.DFM}

function TPacLstV.Execute(phPAB:TPabHnd):longint;
var mMyOp,mMyCr:boolean;
begin
  ohPAB:=phPAB;
  mMyCr:=ohPAB=nil;
  If mMyCr then ohPAB:=TPabHnd.Create;
  mMyOp:=not ohPAB.Active;
  If mMyOp then ohPAB.Open(0);
  TV_PacLst.DataSet:=ohPAB.BtrTable;
  ShowModal;
  If mMyOp then ohPAB.Close;
  If mMyCr then FreeAndNil(ohPAB);
end;

procedure TPacLstV.OpenPAB;
begin
  dmDLS.btPAGLST.Open;
  dmDLS.btSTALST.Open;
  dmDLS.btCTYLST.Open;
  dmDLS.btPAYLST.Open;
  dmDLS.btTRSLST.Open;
  dmDLS.btBANKLST.Open;
  dmDLS.btPABCAT.Open;
  dmDLS.btPABACC.Open;
  dmDLS.btPACNTC.Open;
  dmDLS.btPASUBC.Open;
  dmDLS.btPANOTI.Open;
  dmDLS.btPABLST.Open;
  dmDLS.btPABLST.FindKey ([ValInt(GetLastBook('PAB','0'))]);
  dmDLS.OpenPAB(dmDLS.btPABLST.FieldByName('BookNum').AsInteger);
end;

procedure TPacLstV.ClosePAB;
begin
  dmDLS.btPAB.Close;
  dmDLS.btBANKLST.Close;
  dmDLS.btTRSLST.Close;
  dmDLS.btPAYLST.Close;
  dmDLS.btCTYLST.Close;
  dmDLS.btSTALST.Close;
  dmDLS.btPAGLST.Close;
  dmDLS.btPANOTI.Close;
  dmDLS.btPASUBC.Close;
  dmDLS.btPACNTC.Close;
  dmDLS.btPABACC.Close;
  dmDLS.btPABCAT.Close;
  dmDLS.btPABLST.Close;
end;

procedure TPacLstV.B_ExitClick(Sender: TObject);
begin
  Close;
end;

procedure TPacLstV.TV_PacLstSelected(Sender: TObject);
begin
  Accept:=TRUE;
  oPaCode:=ohPAB.PaCode;
  oPaName:=ohPAB.PaName;
  Close;
end;

procedure TPacLstV.B_InsertClick(Sender: TObject);
begin
  OpenPAB;
  F_PabPacEditF:=TF_PabPacEditF.Create (Self);
  F_PabPacEditF.NewItm;
  F_PabPacEditF.ShowModal;
  ohPAB.LocatePaCode(dmDLS.btPAB.FieldByName('PaCode').AsInteger);
  FreeAndNil(F_PabPacEditF);
  ClosePAB;
end;

procedure TPacLstV.B_EditClick(Sender: TObject);
begin
  OpenPAB;
  dmDLS.btPAB.IndexName:='PaCode';;
  If dmDLS.btPAB.FindKey([ohPAB.PaCode]) then begin
    F_PabPacEditF:=TF_PabPacEditF.Create (Self);
    F_PabPacEditF.LoadData;
    F_PabPacEditF.ShowModal;
    FreeAndNil(F_PabPacEditF);
    ohPAB.BtrTable.Refresh;
  end;
  ClosePAB;
end;

end.
{MOD 1907001}
{MOD 1915001 Vytvorit objekt PAB ak je nil }
