unit GscLst;
// *****************************************************************************
//                        ZOZNAM TOVAROVYCH POLOZIEK
// *****************************************************************************
//
// Program umozni:
// ---------------
// *****************************************************************************

interface

uses
  LangForm, IcTypes, IcTools, IcConv, NexMsg, NexError, NexIni, NexGlob, Key,
  hBARCODE, hGSCAT, hSTK, hPLS, hGSNAME, tGSCLST,
  StkGlob, CasIni, IcStand, IcButtons, IcEditors, CmpTools, DbSrGrid,
  Controls, ExtCtrls, Classes, StdCtrls, Buttons, Windows, Messages,
  SysUtils, Graphics, Forms, Dialogs, ComCtrls, IcLabels, IcInfoFields,
  AdvGrid, SrchGrid, TableView, ActnList, DB, xpComp, ToolWin;

type
  TGscLstV = class(TLangForm)
    ActionList1: TActionList;
    A_Exit: TAction;
    A_ItmInfo: TAction;
    A_Insert: TAction;
    A_Edit: TAction;
    A_StcLst: TAction;
    A_PlsSlct: TAction;
    A_FifLst: TAction;
    A_StmLst: TAction;
    A_BcSrch: TAction;
    Splitter1: TSplitter;
    ToolBar1: TToolBar;
    ToolButton1: TToolButton;
    B_TreeView: TToolButton;
    ToolButton3: TToolButton;
    P_TreeView: TxpSinglePanel;
    TV_MgTree: TTreeView;
    SystemLine1: TSystemLine;
    A_TreeView: TAction;
    Pc_Gsl: TxpPageControl;
    Ts_GslGsc: TxpTabSheet;
    Ts_GslPlc: TxpTabSheet;
    Ts_GslStc: TxpTabSheet;
    Ts_GslSlc: TxpTabSheet;
    Tv_GslSrc: TTableView;
    E_SrcTxt: TxpEdit;
    Tv_GslGsc: TTableView;
    Tv_GslPlc: TTableView;
    Tv_GslStc: TTableView;
    E_NonDia: TxpCheckBox;
    E_Upper: TxpCheckBox;
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure A_ExitExecute(Sender: TObject);
    procedure B_TreeViewClick(Sender: TObject);
    procedure E_SrcTxtModified(Sender: TObject);
    procedure Tv_GslSrcSelected(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure Pc_GslChange(Sender: TObject);
    procedure Tv_GslStcDrawColorRow(Sender: TObject; var pRowColor: TColor; pField: TField; pFirstFld: Boolean);
  private
    oSrcTxt:TStrings;
    oStkNum:word;
    oPlsNum:word;
    oGscFind:boolean;  // TRUE ak vybrana polozka je v evidencii tovaru
    oPlcFind:boolean;  // TRUE ak vybrana polozka je v predajnom cenniku
    oStcFind:boolean;  // TRUE ak vybrana polozka je v skladovych kartach zasob
    ohSTK:TStkHnd;
    ohPLS:TPlsHnd;
    ohGSCAT:TGscatHnd;
    ohGSNAME:TGsnameHnd;
    ohBARCODE:TBarcodeHnd;
    otGSCLST:TGsclstTmp;

    function GetGsCode:longint;
    function GetGsName:Str30;
    function GetMgCode:longint;
    function GetFgCode:longint;
    function GetBarCode:Str15;
    function GetStkCode:Str15;
    function GetOsdCode:Str15;
    function GetMsName:Str10;
    function GetPackGs:longint;
    function GetGsType:Str1;
    function GetDrbMust:boolean;
    function GetRbaTrc:boolean;
    function GetDrbDay:word;
    function GetPdnMust:boolean;
    function GetGrcMth:word;
    function GetVatPrc:byte;
    function GetVolume:double;
    function GetWeight:double;
    function GetMsuQnt:double;
    function GetMsuName:Str5;
    function GetDisFlag:boolean;
    function GetLinDate:TDateTime;
    function GetLinPce:double;
    function GetLinStk:word;
    function GetLinPac:longint;
    function GetSupPac:longint;
    function GetBasGsc:longint;
    function GetGscKfc:word;
    function GetGspKfc:word;
    function GetQliKfc:double;
    function GetCPrice:double;
    function GetAPrice:double;
    function GetBPrice:double;
    function GetActQnt:double;
    function GetFreQnt:double;
    function GetAction:Str1;

    procedure LoadLastSet; // Nacita posledne nastavenia
    procedure SaveLastSet; // Ulozi posledne nastavenia

    procedure SetStkNum (pValue:word);
    procedure SetPlsNum (pValue:word);
    procedure SetSrcTxt (pValue:Str60);
    procedure Search; // Vyhlada za zobrazi v zozname polozky ktore maju v nazve zadane slovo
  public
    procedure Execute;
    procedure ExecuteGPS(pPageIndex:byte);
    function  Locate(pCode:Str15):boolean;
    function  LocateGsCode(pGsCode:longint):boolean;
    function  GetLevAPrice(pGsCode:longint;pLevNum:byte):double; // Predajna cena zadanej cenovej hladiny
    function  GetLevBPrice(pGsCode:longint;pLevNum:byte):double; // Predajna cena zadanej cenovej hladiny

    property SrcTxt:Str60 write SetSrcTxt;
    property StkNum:word read oStkNum write SetStkNum;
    property PlsNum:word read oPlsNum write SetPlsNum;

    property GsCode:longint read GetGsCode;
    property GsName:Str30 read GetGsName;
    property MgCode:longint read GetMgCode;
    property FgCode:longint read GetFgCode;
    property BarCode:Str15 read GetBarCode;
    property StkCode:Str15 read GetStkCode;
    property OsdCode:Str15 read GetOsdCode;
    property MsName:Str10 read GetMsName;
    property PackGs:longint read GetPackGs;
    property GsType:Str1 read GetGsType;
    property DrbMust:boolean read GetDrbMust;
    property RbaTrc:boolean read GetRbaTrc;
    property DrbDay:word read GetDrbDay;
    property PdnMust:boolean read GetPdnMust;
    property GrcMth:word read GetGrcMth;
    property VatPrc:byte read GetVatPrc;
    property Volume:double read GetVolume;
    property Weight:double read GetWeight;
    property MsuQnt:double read GetMsuQnt;
    property MsuName:Str5 read GetMsuName;
    property DisFlag:boolean read GetDisFlag;
    property LinDate:TDateTime read GetLinDate;
    property LinPce:double read GetLinPce;
    property LinStk:word read GetLinStk;
    property LinPac:longint read GetLinPac;
    property SupPac:longint read GetSupPac;
    property BasGsc:longint read GetBasGsc;
    property GscKfc:word read GetGscKfc;
    property GspKfc:word read GetGspKfc;
    property QliKfc:double read GetQliKfc;
    property CPrice:double read GetCPrice;
    property APrice:double read GetAPrice;
    property BPrice:double read GetBPrice;
    property ActQnt:double read GetActQnt;
    property FreQnt:double read GetFreQnt;
    property Action:Str1 read GetAction;
  end;

implementation

uses DM_STKDAT, bGSCAT;

{$R *.DFM}

procedure TGscLstV.FormCreate(Sender: TObject);
begin
  oStkNum:=gIni.MainStk;
  oPlsNum:=gIni.MainPls;
  oSrcTxt:=TStringList.Create;
  ohGSCAT:=TGscatHnd.Create;ohGSCAT.Open;
  ohSTK:=TStkHnd.Create;   ohSTK.Open(oStkNum);
  ohPLS:=TPlsHnd.Create;   ohPLS.Open(oPlsNum);
  otGSCLST:=TGsclstTmp.Create;   otGSCLST.Open;
  ohGSNAME:=TGsnameHnd.Create;  //  ohGSNAME.Open;
  ohBARCODE:=TBarcodeHnd.Create; //  ohBARCODE.Open;

  E_Upper.Checked:=gSet.ReadBool('GSCLST','E_Upper',True);
  E_NonDia.Checked:=gSet.ReadBool('GSCLST','E_NonDia',True);
end;

procedure TGscLstV.FormShow(Sender: TObject);
begin
  Pc_GslChange(Sender);
  Search; // Vyhlada za zobrazi v zozname polozky ktore maju v nazve zadane slovo
end;

procedure TGscLstV.FormDestroy(Sender: TObject);
begin
  gSet.WriteBool ('GSCLST','E_Upper', E_Upper.Checked);
  gSet.WriteBool ('GSCLST','E_NonDia',E_NonDia.Checked);
  otGSCLST.Close;  FreeAndNil (otGSCLST);
  ohBARCODE.Close; FreeAndNil (ohBARCODE);
  ohGSNAME.Close;  FreeAndNil (ohGSNAME);
  ohGSCAT.Close;   FreeAndNil (ohGSCAT);
  ohPLS.Close;     FreeAndNil (ohPLS);
  ohSTK.Close;     FreeAndNil (ohSTK);
  FreeAndNil (oSrcTxt);
end;

procedure TGscLstV.Execute;
begin
  LoadLastSet; // Nacita posledne nastavenia
  ShowModal;
  SaveLastSet; // Ulozi posledne nastavenia
end;

procedure TGscLstV.ExecuteGps;
begin
  Pc_Gsl.ActivePageIndex:=pPageIndex;
  ShowModal;
end;

function TGscLstV.Locate(pCode:Str15):boolean;
var mGsCode:longint;
begin
  try
    Result:=FALSE;
    ohGSCAT.SwapIndex;
    If pCode<>'' then begin
      If (pCode[1]='.') or (pCode[1]=',') then begin // Identifikacia podla PLU
        Delete (pCode,1,1);
        mGsCode:=ValInt (pCode);
        Result:=ohGSCAT.LocateGsCode (mGsCode);
      end
      else begin // Identifikacie podla ciaroveho kodu
        If (pCode[1]='/') then begin // Identifikacia podla StkCode
          Delete (pCode,1,1);
          Result:=ohGSCAT.LocateStkCode(pCode);
        end;
        If (pCode[1]='-') then begin // Identifikacia podla StkCode
          Delete (pCode,1,1);
          Result:=ohGSCAT.LocateSpcCode(pCode);
        end;
        If not Result then begin
          If not ohGSCAT.LocateBarCode(pCode) then begin
            If not ohGSNAME.Active then ohGSNAME.Open;
            Result:=ohBARCODE.LocateBarCode(pCode);
            If Result then Result:=ohGSCAT.LocateGsCode(ohBARCODE.GsCode);
          end else Result:=TRUE;
        end;
      end;
    end;
  finally
    ohGSCAT.RestoreIndex;
  end;
  ohPLS.SwapIndex; oPlcFind:=ohPLS.LocateGsCode(ohGSCAT.GsCode); ohPLS.RestoreIndex;
  ohStk.SwapIndex; oStcFind:=ohSTK.LocateGsCode(ohGSCAT.GsCode); ohSTK.RestoreIndex;
end;

function TGscLstV.LocateGsCode(pGsCode:longint):boolean;
begin
  Result:=ohGSCAT.LocateGsCode(pGsCode);
  If Result then begin
    ohPLS.SwapIndex; oPlcFind:=ohPLS.LocateGsCode(ohGSCAT.GsCode); ohPLS.RestoreIndex;
    ohStk.SwapIndex; oStcFind:=ohSTK.LocateGsCode(ohGSCAT.GsCode); ohSTK.RestoreIndex;
  end else begin
    oPlcFind:=FALSE;
    oStcFind:=FALSE;
  end;
end;

// ******************************** PRIVATE ************************************

function TGscLstV.GetGsCode:longint;
begin
  Result:=ohGSCAT.GsCode;
end;

function TGscLstV.GetGsName:Str30;
begin
  Result:=ohGSCAT.GsName;
end;

function TGscLstV.GetMgCode:longint;
begin
  Result:=ohGSCAT.MgCode;
end;

function TGscLstV.GetFgCode:longint;
begin
  Result:=ohGSCAT.FgCode;
end;

function TGscLstV.GetBarCode:Str15;
begin
  Result:=ohGSCAT.BarCode;
end;

function TGscLstV.GetStkCode:Str15;
begin
  Result:=ohGSCAT.StkCode;
end;

function TGscLstV.GetOsdCode:Str15;
begin
  Result:=ohGSCAT.OsdCode;
end;

function TGscLstV.GetMsName:Str10;
begin
  Result:=ohGSCAT.MsName;
end;

function TGscLstV.GetPackGs:longint;
begin
  Result:=ohGSCAT.PackGs;
end;

function TGscLstV.GetGsType:Str1;
begin
  Result:=ohGSCAT.GsType;
end;

function TGscLstV.GetDrbMust:boolean;
begin
  Result:=ohGSCAT.DrbMust;
end;

function TGscLstV.GetRbaTrc:boolean;
begin
  Result:=boolean(ohGSCAT.RbaTrc);
end;

function TGscLstV.GetDrbDay:word;
begin
  Result:=ohGSCAT.DrbDay;
end;

function TGscLstV.GetPdnMust:boolean;
begin
  Result:=ohGSCAT.PdnMust;
end;

function TGscLstV.GetGrcMth:word;
begin
  Result:=ohGSCAT.GrcMth;
end;

function TGscLstV.GetVatPrc:byte;
begin
  Result:=ohGSCAT.VatPrc;
end;

function TGscLstV.GetVolume:double;
begin
  Result:=ohGSCAT.Volume;
end;

function TGscLstV.GetWeight:double;
begin
  Result:=ohGSCAT.Weight;
end;

function TGscLstV.GetMsuQnt:double;
begin
  Result:=ohGSCAT.MsuQnt;
end;

function TGscLstV.GetMsuName:Str5;
begin
  Result:=ohGSCAT.MsuName;
end;

function TGscLstV.GetDisFlag:boolean;
begin
  Result:=ohGSCAT.DisFlag;
end;

function TGscLstV.GetLinDate:TDateTime;
begin
  Result:=ohGSCAT.LinDate;
end;

function TGscLstV.GetLinPce:double;
begin
  Result:=ohGSCAT.LinPrice;
end;

function TGscLstV.GetLinStk:word;
begin
  Result:=ohGSCAT.LinStk;
end;

function TGscLstV.GetLinPac:longint;
begin
  Result:=ohGSCAT.LinPac;
end;

function TGscLstV.GetSupPac:longint;
begin
  Result:=ohGSCAT.SupPac;
end;

function TGscLstV.GetBasGsc:longint;
begin
  Result:=ohGSCAT.BasGsc;
end;

function TGscLstV.GetGscKfc:word;
begin
  Result:=ohGSCAT.GscKfc;
end;

function TGscLstV.GetGspKfc:word;
begin
  Result:=ohGSCAT.GspKfc;
end;

function TGscLstV.GetQliKfc:double;
begin
  Result:=ohGSCAT.QliKfc;
end;

function TGscLstV.GetCPrice:double;
begin
  If oStcFind
    then Result:=ohSTK.LastPrice
    else Result:=ohGSCAT.LinPrice;
end;

function TGscLstV.GetAPrice:double;
begin
  If oPlcFind
    then Result:=ohPLS.APrice
    else Result:=0;
end;

function TGscLstV.GetBPrice:double;
begin
  If oPlcFind
    then Result:=ohPLS.BPrice
    else Result:=0;
end;

function TGscLstV.GetActQnt:double;
begin
  If oStcFind
    then Result:=ohSTK.ActQnt
    else Result:=0;
end;

function TGscLstV.GetFreQnt:double;
begin
  If oStcFind
    then Result:=ohSTK.FreQnt
    else Result:=0;
end;

function TGscLstV.GetAction:Str1;
begin
  If oPlcFind
    then Result:=ohPLS.Action
    else Result:='';
end;

procedure TGscLstV.LoadLastSet; // Nacita posledne nastavenia
begin
  Pc_Gsl.ActivePageIndex:=gSet.ReadInteger('GSCLST','Pc_Gsl.ActivePageIndex',Pc_Gsl.ActivePageIndex);
end;

procedure TGscLstV.SaveLastSet; // Ulozi posledne nastavenia
begin
  gSet.WriteInteger ('GSCLST','Pc_Gsl.ActivePageIndex',Pc_Gsl.ActivePageIndex);
end;

procedure TGscLstV.SetStkNum (pValue:word);
begin
  If oStkNum<>pValue then begin
    oStkNum:=pValue;
    ohSTK.Open (oStkNum);
  end;
end;

procedure TGscLstV.SetPlsNum (pValue:word);
begin
  If oPlsNum<>pValue then begin
    oPlsNum:=pValue;
    If oPlsNum=0 then oPlsNum:=1;
    ohPLS.Open (oPlsNum);
  end;
end;

procedure TGscLstV.SetSrcTxt (pValue:Str60);
begin
  E_SrcTxt.Text:=pValue;
//  Search; // Vyhlada za zobrazi v zozname polozky ktore maju v nazve zadane slovo
end;

procedure TGscLstV.Search; // Vyhlada za zobrazi v zozname polozky ktore maju v nazve zadane slovo
var mGsCode:longint;  mCnt:integer;  mWrdQnt,I:byte;   mSpcSrch,mOk:boolean;   mSpcCode:Str30;
    mPos:string; mSrchStr:Str50;mUpper:byte;
begin
  If E_SrcTxt.Text<>'' then begin
    otGSCLST.Close;  otGSCLST.Open;
    case gKey.SysGsnSrc of
      0: begin // Sekvencialne vyhladavanie
           mSpcSrch:=E_SrcTxt.Text[1]='-';
           If mSpcSrch then begin
             mSpcCode:=E_SrcTxt.Text;
             Delete(mSpcCode,1,1);
             E_SrcTxt.Text:=mSpcCode;
           end;
           mSrchStr:=E_SrcTxt.Text;mUpper:=0;
           If E_NonDia.Checked then begin
             mSrchStr:=ConvToNoDiakr(mSrchStr);mUpper:=1;
           end;
           If E_Upper.Checked then begin
             mSrchStr:=UpString(mSrchStr);mUpper:=mUpper+2;
           end;
           If mSpcSrch
             then GSCAT_SearchFields(0,0,'SpcCode',mSrchStr,mPos,mCnt,mUpper)
             else GSCAT_SearchFields(0,0,'GsName', mSrchStr,mPos,mCnt,mUpper);
           If mCnt>0 then begin
             otGSCLST.DisableControls;
             while mPos<>'' do begin
               If Pos('|',mPos)>0 then begin
                 mGsCode:=Valint(Copy(mPos,1,Pos('|',mPos)-1));
                 mPos:=Copy(mPos,Pos('|',mPos)+1,Length(mPos));
               end else begin
                 mGsCode:=Valint(mPos);
                 mPos:='';
               end;
               ohGSCAT.GotoPos(mGsCode);
               If not otGSCLST.LocateGsCode(ohGSCAT.GsCode) then begin
                 otGSCLST.Insert;
                 BTR_To_PX (ohGSCAT.BtrTable,otGSCLST.TmpTable);
                 If ohSTK.LocateGsCode(ohGSCAT.GsCode) then begin
                   otGSCLST.LinPce:=ohSTK.LastPrice;
                   otGSCLST.ActQnt:=ohSTK.ActQnt;
                   otGSCLST.FreQnt:=ohSTK.FreQnt;
                 end;
                 If ohPLS.LocateGsCode(ohGSCAT.GsCode) then begin
                   otGSCLST.APrice:=ohPLS.APrice;
                   otGSCLST.BPrice:=ohPLS.BPrice;
                   otGSCLST.Action:=ohPLS.Action;
                 end;
                 If IsNul (otGSCLST.LinPce) then otGSCLST.LinPce:=ohGSCAT.LinPrice;
                 otGSCLST.Post;
               end;
               Application.ProcessMessages;
             end;
             otGSCLST.EnableControls;
           end;
(*
           ohGSCAT.First;
           Repeat
             If mSpcSrch
               then mOk:=Pos(UpString(E_SrcTxt.Text),UpString(ohGSCAT.SpcCode))>0
               else mOk:=Pos(UpString(E_SrcTxt.Text),UpString(ohGSCAT.GsName))>0;
             If mOk then begin
               otGSCLST.Insert;
               BTR_To_PX (ohGSCAT.BtrTable,otGSCLST.TmpTable);
               If ohSTK.LocateGsCode(ohGSCAT.GsCode) then begin
                 otGSCLST.LinPce:=ohSTK.LastPrice;
                 otGSCLST.ActQnt:=ohSTK.ActQnt;
                 otGSCLST.FreQnt:=ohSTK.FreQnt;
               end;
               If ohPLS.LocateGsCode(ohGSCAT.GsCode) then begin
                 otGSCLST.APrice:=ohPLS.APrice;
                 otGSCLST.BPrice:=ohPLS.BPrice;
                 otGSCLST.Action:=ohPLS.Action;
               end;
               If IsNul (otGSCLST.LinPce) then otGSCLST.LinPce:=ohGSCAT.LinPrice;
               otGSCLST.Post;
             end;
             Application.ProcessMessages;
             ohGSCAT.Next;
           until ohGSCAT.Eof;
*)
         end;
      1: begin // Zrychlene vyhladavanie
           // Rozbijeme retazec na slova
           oSrcTxt.Clear;
           mWrdQnt:=LineElementNum(E_SrcTxt.Text,' ');
           If mWrdQnt>1 then begin
             For I:=1 to mWrdQnt do
               oSrcTxt.Add (LineElement(E_SrcTxt.Text,I,' '));
           end
           else oSrcTxt.Add(E_SrcTxt.Text);
           // Vyhladame vsetky slova
           If oSrcTxt.Count>0 then begin
             For I:=0 to oSrcTxt.Count-1 do begin
               If not ohGSNAME.Active then ohGSNAME.Open;
               ohGSNAME.Src (oSrcTxt.Strings[I]);
               If ohGSNAME.GscLst.Count>0 then begin
                 mCnt:=0;
                 otGSCLST.SwapIndex;
                 otGSCLST.SetIndex(tGSCLST.ixGsCode);
                 Repeat
                   mGsCode:=ValInt(ohGSNAME.GscLst.Strings[mCnt]);
                   If ohGSCAT.LocateGsCode(mGsCode) then begin
                     If not otGSCLST.LocateGsCode(ohGSCAT.GsCode) then begin
                       otGSCLST.Insert;
                       BTR_To_PX (ohGSCAT.BtrTable,otGSCLST.TmpTable);
                       If ohSTK.LocateGsCode(ohGSCAT.GsCode) then begin
                         otGSCLST.LinPce:=ohSTK.LastPrice;
                         otGSCLST.ActQnt:=ohSTK.ActQnt;
                         otGSCLST.FreQnt:=ohSTK.FreQnt;
                       end;
                       If ohPLS.LocateGsCode(ohGSCAT.GsCode) then begin
                         otGSCLST.APrice:=ohPLS.APrice;
                         otGSCLST.BPrice:=ohPLS.BPrice;
                         otGSCLST.Action:=ohPLS.Action;
                       end;
                       If IsNul (otGSCLST.LinPce) then otGSCLST.LinPce:=ohGSCAT.LinPrice;
                       otGSCLST.Post;
                     end;
                   end;
                   Inc (mCnt)
                 until (mCnt=ohGSNAME.GscLst.Count);
                 otGSCLST.RestoreIndex;
               end;
             end;
           end;
         end;
    end;
  end;
end;

procedure TGscLstV.A_ExitExecute(Sender: TObject);
begin
  Close;
end;

procedure TGscLstV.B_TreeViewClick(Sender: TObject);
begin
  P_TreeView.Visible:= not P_TreeView.Visible;
end;

procedure TGscLstV.E_SrcTxtModified(Sender: TObject);
begin
  Search; // Vyhlada za zobrazi v zoznamepolozky ktore maju v nazve zadane slovo
end;

procedure TGscLstV.Tv_GslSrcSelected(Sender: TObject);
var mGsCode:longint;
begin
  Accept:=TRUE;
  oPlcFind:=FALSE;   oStcFind:=FALSE;
  case Pc_Gsl.ActivePageIndex of
    0: mGsCode:=ohGSCAT.GsCode;
    1: mGsCode:=ohPLS.GsCode;
    2: mGsCode:=ohSTK.GsCode;
    3: mGsCode:=otGSCLST.GsCode;
  end;
  ohGSCAT.SwapIndex; oGscFind:=ohGSCAT.LocateGsCode(mGsCode); ohGSCAT.RestoreIndex;
  ohPLS.SwapIndex;   oPlcFind:=ohPLS.LocateGsCode(mGsCode);   ohPLS.RestoreIndex;
  ohStk.SwapIndex;   oStcFind:=ohSTK.LocateGsCode(mGsCode);   ohSTK.RestoreIndex;
  Close;
end;

procedure TGscLstV.Pc_GslChange(Sender: TObject);
begin
  case Pc_Gsl.ActivePageIndex of
    0: begin
         If Tv_GslGsc.DataSet=nil then Tv_GslGsc.DataSet:=ohGSCAT.BtrTable;
         Tv_GslGsc.SetFocus;
       end;
    1: begin
         If Tv_GslPlc.DataSet=nil then Tv_GslPlc.DataSet:=ohPLS.BtrTable;
         Tv_GslPlc.SetFocus;
       end;
    2: begin
         If Tv_GslStc.DataSet=nil then Tv_GslStc.DataSet:=ohSTK.BtrTable;
         Tv_GslStc.SetFocus;
       end;
    3: begin
         If Tv_GslSrc.DataSet=nil then Tv_GslSrc.DataSet:=otGSCLST.TmpTable;
         Tv_GslSrc.SetFocus;
       end;
  end;
end;

function TGscLstV.GetLevAPrice(pGsCode: Integer; pLevNum: byte): double;
begin
  Result:=0;
  If oPlcFind and ohPLS.LocateGsCode(pGsCode) then begin
    case pLevNum of
      1: Result:=ohPLS.APrice1;
      2: Result:=ohPLS.APrice2;
      3: Result:=ohPLS.APrice3;
      else Result:=ohPLS.APrice;
    end;
  end;
end;

function TGscLstV.GetLevBPrice(pGsCode: Integer; pLevNum: byte): double;
begin
  Result:=0;
  If oPlcFind and ohPLS.LocateGsCode(pGsCode) then begin
    case pLevNum of
      1: Result:=ohPLS.BPrice1;
      2: Result:=ohPLS.BPrice2;
      3: Result:=ohPLS.BPrice3;
      else Result:=ohPLS.BPrice;
    end;
  end;
end;

procedure TGscLstV.Tv_GslStcDrawColorRow(Sender: TObject; var pRowColor: TColor; pField: TField; pFirstFld: Boolean);
begin
  If pFirstFld then begin
    pRowColor:=clBlack;
    If IsNul(ohSTK.ActQnt) then pRowColor:=clGray;
    If ohSTK.DisFlag then pRowColor:=clSilver;
  end;
end;

end.
{MOD 1805024}
{MOD 1807015}
{MOD 1809005}
{MOD 1809009}

