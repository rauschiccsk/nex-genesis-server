unit ProLst;
// *****************************************************************************
//                              ZOZNAM PRODUKTOV
// *****************************************************************************
//
// Program umozni:
// ---------------
// *****************************************************************************

interface

uses
  LangForm, IcTypes, IcTools, IcConv, NexMsg, NexError, NexIni, NexGlob, ProFnc, 
  IcStand, IcButtons, IcEditors, CmpTools, DbSrGrid, Controls, ExtCtrls, Classes,
  StdCtrls, Buttons, Windows, Messages, SysUtils, Graphics, Forms, Dialogs, ComCtrls,
  IcLabels, IcInfoFields, AdvGrid, SrchGrid, TableView, ActnList, DB, xpComp, ToolWin;

type
  TProLst=class(TLangForm)
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
    Splitter: TSplitter;
    Tv_Grp: TxpSinglePanel;
    TV_MgTree: TTreeView;
    SystemLine1: TSystemLine;
    A_TreeView: TAction;
    Pc_Pro: TxpPageControl;
    Ts_GscLst: TxpTabSheet;
    Ts_SvcLst: TxpTabSheet;
    Ts_PlcLst: TxpTabSheet;
    Ts_StcLst: TxpTabSheet;
    Tv_StcLst: TTableView;
    E_SrcTxt: TxpEdit;
    Tv_GscLst: TTableView;
    Tv_SvcLst: TTableView;
    Tv_PlcLst: TTableView;
    Ts_ApcLst: TxpTabSheet;
    Tv_ApcLst: TTableView;
    Ts_ProCat: TxpTabSheet;
    Tv_ProCat: TTableView;
    procedure FormCreate(Sender:TObject);
    procedure FormDestroy(Sender:TObject);
    procedure A_ExitExecute(Sender:TObject);
    procedure FormShow(Sender:TObject);
    procedure Pc_ProChange(Sender:TObject);
    procedure Tv_PlcLstDrawColorRow(Sender:TObject; var pRowColor:TColor; pField:TField; pFirstFld:Boolean);
    procedure Tv_StcLstDrawColorRow(Sender:TObject; var pRowColor:TColor; pField:TField; pFirstFld:Boolean);
    procedure Tv_ApcLstDrawColorRow(Sender:TObject; var pRowColor:TColor; pField:TField; pFirstFld:Boolean);
    procedure Tv_GscLstSelected(Sender:TObject);
    procedure Tv_SvcLstSelected(Sender:TObject);
    procedure Tv_PlcLstSelected(Sender:TObject);
    procedure Tv_StcLstSelected(Sender:TObject);
    procedure Tv_ApcLstSelected(Sender: TObject);
    procedure Tv_ProCatSelected(Sender: TObject);
  private
    oParNum:longint;
    oPlsNum:word;
    oStkNum:word;
    oSecPgr:longint;  // Èíslo tovarovej skupiny, ktrým sa zaèínaju služby
    procedure LodLasSet;  // Nacita posledne nastavenia
    procedure SavLasSet;  // Ulozi posledne nastavenia
  public
    oPro:TProFnc;
    procedure Execute(pParNum:longint;pStkNum:word);
    function Locate(pParNum:longint;pStkNum:word;pCode:Str15):boolean;
  end;

implementation

{$R *.DFM}

procedure TProLst.FormCreate(Sender:TObject);
begin
  inherited;
  oPro:=TProFnc.Create;
  oSecPgr:=gIni.ServiceMg;
end;

procedure TProLst.FormShow(Sender: TObject);
begin
  case Pc_Pro.ActivePageIndex of
    0: Tv_ProCat.SetFocus;
    1: Tv_GscLst.SetFocus;
    2: Tv_SvcLst.SetFocus;
    3: Tv_PlcLst.SetFocus;
    4: Tv_StcLst.SetFocus;
    5: Tv_ApcLst.SetFocus;
  end;
end;

procedure TProLst.FormDestroy(Sender: TObject);
begin
  FreeAndNil(oPro);
  inherited;
end;

procedure TProLst.Execute(pParNum:longint;pStkNum:word);
begin
  LodLasSet; // Nacita posledne nastavenia
  oParNum:=pParNum;
  oPlsNum:=oPro.oPar.PlsNum[pParNum];
  oStkNum:=pStkNum;
  Pc_ProChange(Self);
  ShowModal;
  SavLasSet; // Ulozi posledne nastavenia
end;

function TProLst.Locate(pParNum:longint;pStkNum:word;pCode:Str15):boolean;
var mProNum:longint;
begin
  oParNum:=pParNum;
  oPlsNum:=oPro.oPar.PlsNum[pParNum];
  oStkNum:=pStkNum;
  With oPro do begin
    try
      Result:=FALSE;
      If pCode<>'' then begin
        If (pCode[1]='.') or (pCode[1]=',') then begin // Identifikacia podla PLU
          Delete(pCode,1,1);
          mProNum:=ValInt(pCode);
          Result:=LocProNum(pParNum,oStkNum,mProNum);
        end else begin // Identifikacie podla ciaroveho kodu
          If (pCode[1]='/') then begin // Identifikacia podla StkCode
            Delete(pCode,1,1);
            Result:=ohPROCAT.LocStkCod(pCode);
            If Result then Result:=LocProNum(pParNum,oStkNum,ohPROCAT.ProNum);
          end;
          If (pCode[1]='-') then begin // Identifikacia podla ShpCode
            Delete(pCode,1,1);
            Result:=ohPROCAT.LocShpCod(pCode);
            If Result then Result:=LocProNum(pParNum,oStkNum,ohPROCAT.ProNum);
          end;
          If not Result then begin
            If not ohPROCAT.LocBarCod(pCode) then begin
              Result:=ohPROCOD.LocBarCod(pCode);
              If Result then Result:=LocProNum(pParNum,oStkNum,ohPROCOD.ProNum);
            end else Result:=LocProNum(pParNum,oStkNum,ohPROCAT.ProNum);
          end;
        end;
      end;
    finally
    end;
  end;
end;

// ******************************** PRIVATE ************************************

procedure TProLst.LodLasSet;
begin
  Pc_Pro.ActivePageIndex:=gSet.ReadInteger('PROLST','Pc_Pro.ActivePageIndex',Pc_Pro.ActivePageIndex);
end;

procedure TProLst.SavLasSet;
begin
  gSet.WriteInteger('PROLST','Pc_Pro.ActivePageIndex',Pc_Pro.ActivePageIndex);
end;

procedure TProLst.A_ExitExecute(Sender: TObject);
begin
  Close;
end;

procedure TProLst.Pc_ProChange(Sender: TObject);
begin
  case Pc_Pro.ActivePageIndex of
    0: begin
         oPro.ohPROCAT.Open;
         If Tv_ProCat.DataSet=nil then Tv_ProCat.DataSet:=oPro.ohPROCAT.Table;
         If Visible then Tv_ProCat.SetFocus;
       end;
    1: begin
         oPro.ohGSCLST.FltGsc(oSecPgr);
         If Tv_GscLst.DataSet=nil then begin
           Tv_GscLst.DataSet:=oPro.ohGSCLST.Table;
         end;
         If Visible then Tv_GscLst.SetFocus;
       end;
    2: begin
         oPro.ohSVCLST.FltSec(oSecPgr);
         If Tv_SvcLst.DataSet=nil then begin
           Tv_SvcLst.DataSet:=oPro.ohSVCLST.Table;
         end;
         If Visible then Tv_SvcLst.SetFocus;
       end;
    3: begin
         oPro.ohPLCLST.Open(oPlsNum);
         If Tv_PlcLst.DataSet=nil then Tv_PlcLst.DataSet:=oPro.ohPLCLST.Table[oPlsNum];
         If Visible then Tv_PlcLst.SetFocus;
       end;
    4: begin
         oPro.ohSTCLST.Open(oStkNum);
         If Tv_StcLst.DataSet=nil then Tv_StcLst.DataSet:=oPro.ohSTCLST.Table[oStkNum];
         If Visible then Tv_StcLst.SetFocus;
       end;
    5: begin
         oPro.ohAPCLST.AplNum:=0;
         If Tv_ApcLst.DataSet=nil then Tv_ApcLst.DataSet:=oPro.ohAPCLST.Table;
         If Visible then Tv_ApcLst.SetFocus;
       end;
  end;
end;

procedure TProLst.Tv_PlcLstDrawColorRow(Sender: TObject; var pRowColor: TColor; pField: TField; pFirstFld: Boolean);
begin
  If pFirstFld then begin
    pRowColor:=clBlack;
  end;
end;

procedure TProLst.Tv_StcLstDrawColorRow(Sender: TObject; var pRowColor: TColor; pField: TField; pFirstFld: Boolean);
begin
  If pFirstFld then begin
    pRowColor:=clBlack;
    If IsNul(oPro.ohSTCLST.FrePrq) then pRowColor:=clGray;
  end;
end;

procedure TProLst.Tv_ApcLstDrawColorRow(Sender: TObject; var pRowColor: TColor; pField: TField; pFirstFld: Boolean);
begin
  If pFirstFld then begin
    pRowColor:=clBlack;
    If InDateInterval(oPro.ohAPCLST.BegDte,oPro.ohAPCLST.EndDte,Date) then begin
      If InTimeInterval(oPro.ohAPCLST.BegTim,oPro.ohAPCLST.EndTim,Time)
        then pRowColor:=clGreen
        else pRowColor:=clRed;
    end else pRowColor:=clGreen;
  end;
end;

procedure TProLst.Tv_ProCatSelected(Sender: TObject);
begin
  Accept:=oPro.LocProNum(oParNum,oStkNum,oPro.ohPROCAT.ProNum);
  Close;
end;

procedure TProLst.Tv_GscLstSelected(Sender: TObject);
begin
  Accept:=oPro.LocProNum(oParNum,oStkNum,oPro.ohGSCLST.ProNum);
  Close;
end;

procedure TProLst.Tv_SvcLstSelected(Sender: TObject);
begin
  Accept:=oPro.LocProNum(oParNum,oStkNum,oPro.ohSVCLST.ProNum);
  Close;
end;

procedure TProLst.Tv_PlcLstSelected(Sender: TObject);
begin
  Accept:=oPro.LocProNum(oParNum,oStkNum,oPro.ohPLCLST.ProNum);
  Close;
end;

procedure TProLst.Tv_StcLstSelected(Sender: TObject);
begin
  Accept:=oPro.LocProNum(oParNum,oStkNum,oPro.ohSTCLST.ProNum);
  Close;
end;

procedure TProLst.Tv_ApcLstSelected(Sender: TObject);
begin
  Accept:=oPro.LocProNum(oParNum,oStkNum,oPro.ohAPCLST.ProNum);
  Close;
end;

end.
{MOD 2001}

