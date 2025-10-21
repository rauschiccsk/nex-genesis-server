unit Grw;
// *****************************************************************************
// ****************** VŠEOBECNÝ VIEWER NA ZOBRAZENIE ZOZNAMOV ******************
// *****************************************************************************
interface

uses
  IcVariab, IcTypes, IcConv, IcDate, IcTools, NexPath, NexIni, NexError, NexSys,
  NexGlob,
  BtrHand, LangForm, NexMsg, IcStand, IcButtons, IcEditors, CmpTools, Controls,
  ExtCtrls, Classes, StdCtrls, Buttons, Windows, Messages, SysUtils, Graphics,
  Forms, Dialogs, ComCtrls, IcLabels, IcInfoFields, AdvGrid, SrchGrid, TableView,
  ToolWin, Menus, ActnList, IcActionList, ProcInd_, RefFile, IcProgressBar, DB,
  NexEditors,Barcode, xpComp, BtrTable, NexBtrTable, NexPxTable;

type
  TGrwF = class(TLangForm)
    P_Back: TDinamicPanel;
    TV_Grw: TTableView;
    ActionList: TActionList;
    StatusLine: TxpStatusLine;
    B_Exi: TSpecSpeedButton;
    B_Ins: TSpecSpeedButton;
    B_Edi: TSpecSpeedButton;
    B_Del: TSpecSpeedButton;
    A_Ins: TAction;
    A_Exi: TAction;
    A_Del: TAction;
    procedure FormCreate(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure B_ExiClick(Sender: TObject);
    procedure TV_GrwDrawColorRow(Sender: TObject; var pRowColor: TColor; pField:TField; pFirstFld:Boolean);
    procedure B_InsClick(Sender: TObject);
    procedure B_EdiClick(Sender: TObject);
    procedure B_DelClick(Sender: TObject);
  private
    oChanged:boolean; // TRUE ak polozky dokladu boli nejako zmenene
  public
    procedure Execute(pTable:TNexPxTable;pDgd:ShortString); overload;
    procedure Execute(pTable:TNexBtrTable;pDgd:ShortString); overload;

    property Changed: boolean read oChanged;
  end;

implementation

{$R *.DFM}

procedure TGrwF.FormCreate(Sender: TObject);
begin
  oChanged := FALSE; // TRUE ak polozky dokladu boli nejako zmenene
end;

procedure TGrwF.FormShow(Sender: TObject);
begin
  TV_Grw.SetFocus;
end;

procedure TGrwF.Execute(pTable:TNexPxTable;pDgd:ShortString);
begin
  TV_Grw.DataSet := pTable;
  TV_Grw.DgdName := pDgd;
  ShowModal;
end;

procedure TGrwF.Execute(pTable:TNexBtrTable;pDgd:ShortString);
begin
  TV_Grw.DataSet := pTable;
  TV_Grw.DgdName := pDgd;
  ShowModal;
end;

//***************************** ACTIONS ****************************
procedure TGrwF.B_ExiClick(Sender: TObject);
begin
  Close;
end;

procedure TGrwF.TV_GrwDrawColorRow(Sender: TObject; var pRowColor: TColor; pField: TField; pFirstFld: Boolean);
begin
  If pFirstFld then begin
    pRowColor := clBlack;
  end;
end;

procedure TGrwF.B_InsClick(Sender: TObject);
begin
  //
end;

procedure TGrwF.B_EdiClick(Sender: TObject);
begin
  //
end;

procedure TGrwF.B_DelClick(Sender: TObject);
begin
  //
end;

end.
