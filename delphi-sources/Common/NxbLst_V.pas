unit NxbLst_V;

interface

uses
  LangForm, IcTools, IcTypes, NexMsg, pBokLst,
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  TableView, ApplicView, ExtCtrls, AdvGrid, SrchGrid, Buttons, IcButtons,
  ActnList, IcActionList, DB, DBTables, NexPxTable, BtrTable, NexBtrTable;

type
  TF_NxbLstV = class(TLangForm)
    TV_NxbLst: TTableView;
    B_Exit: TSpecSpeedButton;
    IcActionList1: TIcActionList;
    A_Insert: TAction;
    A_Delete: TAction;
    A_Exit: TAction;
    procedure FormCreate(Sender: TObject);
    procedure B_ExitClick(Sender: TObject);
    procedure TV_NxbLstSelected(Sender: TObject);
  private
//    otNXBDEF: TNxbdefTmp;
    oPmdMark  : Str3;
    oBokNum  : Str5;
    oBokName : Str30;
    otBOKLST  : TBoklstTmp;
    procedure WriteHead (pValue:Str80);
  public
    procedure Execute (pBokNum:Str5;pPmdMark:Str3);
  published
    property Head:Str80 write WriteHead;
    property BokNum:Str5 read oBokNum;
    property BokName:Str30 read oBokName;
  end;

function SlctNxbLst(pBokNum:Str5;pPmdMark:Str3):Str5;

var
  uNX_BokNum:Str5;
  uNX_BokName:Str30;
  F_NxbLstV: TF_NxbLstV;

implementation

uses  DM_STKDAT;

{$R *.DFM}

function SlctNxbLst;
begin
  Result := '';
  F_NxbLstV := TF_NxbLstV.Create(NIL);
  F_NxbLstV.Execute (pBokNum,pPmdMark);
  If F_NxbLstV.Accept then begin
    Result := F_NxbLstV.BokNum;
    uNX_BokNum:=F_NxbLstV.BokNum;
    uNX_BokName:=F_NxbLstV.BokName;
  end;
  FreeAndNil (F_NxbLstV);
end;

procedure TF_NxbLstV.FormCreate(Sender: TObject);
begin
  oBokNum := '';  oBokName := '';
end;

procedure TF_NxbLstV.Execute;
begin
  oPmdMark:=pPmdMark;
  otBOKLST := TBoklstTmp.Create; otBOKLST.Open;
  otBOKLST.LoadToTmp(pPmdMark);
  If pBokNum<>'' then otBOKLST.LocateBookNum(pBokNum);
  TV_NxbLst.DataSet := otBOKLST.TmpTable;
  ShowModal;
  otBOKLST.Close;FreeAndNil(otBOKLST);
end;

procedure TF_NxbLstV.B_ExitClick(Sender: TObject);
begin
  Close;
end;

// ---------------------------------- PRIVATE -----------------------------------

procedure TF_NxbLstV.WriteHead (pValue:Str80);
begin
  TV_NxbLst.Head := pValue;
end;

procedure TF_NxbLstV.TV_NxbLstSelected(Sender: TObject);
begin
  Accept := TRUE;
  oBokNum := otBOKLST.BokNum;
  oBokName := otBOKLST.BokName;
  Close;
end;

end.
