unit xpSelectEdit;

interface

uses
  BarCode, IcDate, Variants, IcButtons, NwEditors, NwInfoFields,
  LangForm, IcStand, NexMsg, xpComp,
  IcTypes, IcConv, IcTools, IcText, IcVariab, CmpTools, NexBtrTable,
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls, ExtCtrls, ComCtrls, Buttons;

type

  // ********** Vseobecny editor vyberovych zoznamov XP ***********
  TxpSelectEdit = class(TWinControl)
    oEdit: TxpEdit;
    oInfo: TxpEdit;
    oButt: TxpBitBtn;
  private
    eOnEnter: TNotifyEvent;
    eOnExit: TNotifyEvent;
    eOnKeyDown: TKeyEvent;
    eOnChanged: TNotifyEvent;
    procedure SetLong(pValue: longint);
    function  GetLong: longint;
    procedure SetText(pValue: Str30);
    function  GetText: Str30;
    procedure SetShowText(pValue: boolean);
    function  GetShowText: boolean;
    procedure SetWidthLong(pValue: word);
    function  GetWidthLong: word;
    procedure SetWidthText(pValue: word);
    function  GetWidthText: word;

    procedure MyKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure MyOnEnter (Sender: TObject);
    procedure MyOnExit (Sender: TObject);
    procedure SetSize; // Nastavi rozmer editora pdola jeho komponentov
    procedure SearchData (Sender: TObject); virtual;
    procedure ShowLst (Sender: TObject); virtual;
  public
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
    procedure Loaded; override;
    procedure SetFocus; override;
  published
    property Long:longint read GetLong write SetLong;
    property Text:Str30 read GetText write SetText;
    property ShowText:boolean read GetShowText write SetShowText;
    property WidthLong:word read GetWidthLong write SetWidthLong;
    property WidthText:word read GetWidthText write SetWidthText;

    property TabOrder;
    property Anchors;
    {Events}
    property OnEnter: TNotifyEvent read eOnEnter write eOnEnter;
    property OnExit: TNotifyEvent read eOnExit write eOnExit;
    property OnKeyDown: TKeyEvent read eOnKeyDown write eOnKeyDown;
    property OnChanged: TNotifyEvent read eOnChanged write eOnChanged;
  end;
  // ************** Editor pre vsetky zoznamy *************
  TXPLstType = (ltGsl,ltMgl,ltFgl,ltSml,ltPls,ltApl,ltStk,ltWri,ltPab,ltPal,ltDlr,ltEpl,ltRef,ltDrv,ltCnt,ltWpa);
  TXPLstEdit = class(TXPSelectEdit)
  private
    oLstType: TXPLstType;
    procedure SearchData (Sender: TObject); override;
    procedure ShowLst (Sender: TObject); override;
  public
  published
    property LstType: TXPLstType read oLstType write oLstType;
  end;

procedure Register;

implementation

uses
  DM_STKDAT, DM_DLSDAT,
  Acc_AccAnl_V, Sys_CrsLst_V, Sys_PlsLst_V, Sys_StkLst_V,
  Sys_WriLst_V, Sys_PabLst_V, Pab_PacLst_V, Pab_WpaLst_V,
  Sys_EpcLst_V, Stk_SmLst_V,  Gsc_MgLst_V,  Gsc_FgLst_V,
  Sys_AplLst_V, Sys_RefLst_V, Sys_DrvLst_V, Gsc_GsLst_V,
  Sys_DlrLst_V, Sys_CsbLst_V, Pab_CtyLst_V, Pab_StaLst_V,
  Sys_CntLst_V, Pab_BankLst_V;

// *********************** Editor pre vsetky zoznamy ***********************
procedure TXPLstEdit.SearchData (Sender: TObject);
var mMyOp:boolean;
begin
  Text := '';
  If (Long<>0) then begin
    case oLstType of
      ltGsl: begin // Zoznam tovarov z bazovej evidencie
               mMyOp := not dmSTK.btGSCAT.Active;
               If mMyOp then dmSTK.btGSCAT.Open;
               If dmSTK.btGSCAT.IndexName<>'GsCode' then dmSTK.btGSCAT.IndexName := 'GsCode';
               If dmSTK.btGSCAT.FindKey ([Long]) then begin
                 Text := dmSTK.btGSCAT.FieldByname ('GsName').AsString;
                 If Assigned (eOnChanged) then eOnChanged (Sender);
               end
               else ShowMsg (110702,StrInt(Long,0));
               If mMyOp then dmSTK.btGSCAT.Close;
             end;
      ltMgl: begin // Zoznam tovarovych skupin
               mMyOp := not dmSTK.btMGLST.Active;
               If mMyOp then dmSTK.btMGLST.Open;
               If dmSTK.btMGLST.IndexName<>'MgCode' then dmSTK.btMGLST.IndexName := 'MgCode';
               If dmSTK.btMGLST.FindKey ([Long]) then begin
                 Text := dmSTK.btMGLST.FieldByname ('MgName').AsString;
                 If Assigned (eOnChanged) then eOnChanged (Sender);
               end
               else ShowMsg (100015,StrInt(Long,0));
               If mMyOp then dmSTK.btMGLST.Close;
             end;
      ltFgl: begin // Zoznam financnych skupin
               mMyOp := not dmSTK.btFGLST.Active;
               If mMyOp then dmSTK.btFGLST.Open;
               If dmSTK.btFGLST.IndexName<>'FgCode' then dmSTK.btFGLST.IndexName := 'FgCode';
               If dmSTK.btFGLST.FindKey ([Long]) then begin
                 Text := dmSTK.btFGLST.FieldByname ('FgName').AsString;
                 If Assigned (eOnChanged) then eOnChanged (Sender);
               end
               else ShowMsg (100015,StrInt(Long,0));
               If mMyOp then dmSTK.btFGLST.Close;
             end;
      ltSml: begin // Zoznam skladovych pohybov
               mMyOp := not dmSTK.btSMLST.Active;
               If mMyOp then dmSTK.btSMLST.Open;
               If dmSTK.btSMLST.IndexName<>'SmCode' then dmSTK.btSMLST.IndexName := 'SmCode';
               If dmSTK.btSMLST.FindKey ([Long]) then begin
                 Text := dmSTK.btSMLST.FieldByname ('SmName').AsString;
                 If Assigned (eOnChanged) then eOnChanged (Sender);
               end
               else ShowMsg (100015,StrInt(Long,0));
               If mMyOp then dmSTK.btSMLST.Close;
             end;
      ltPls: begin // Zoznam predajnych cennikov
               mMyOp := not dmSTK.btPLSLST.Active;
               If mMyOp then dmSTK.btPLSLST.Open;
               If dmSTK.btPLSLST.IndexName<>'PlsNum' then dmSTK.btPLSLST.IndexName := 'PlsNum';
               If dmSTK.btPLSLST.FindKey ([Long]) then begin
                 Text := dmSTK.btPLSLST.FieldByname ('PlsName').AsString;
                 If Assigned (eOnChanged) then eOnChanged (Sender);
               end
               else ShowMsg (100015,StrInt(Long,0));
               If mMyOp then dmSTK.btPLSLST.Close;
             end;
      ltApl: begin  // Zoznam akciovych cennikov
               mMyOp := not dmSTK.btAPLLST.Active;
               If mMyOp then dmSTK.btAPLLST.Open;
               If dmSTK.btAPLLST.IndexName<>'AplNum' then dmSTK.btAPLLST.IndexName := 'AplNum';
               If dmSTK.btAPLLST.FindKey ([Long]) then begin
                 Text := dmSTK.btAPLLST.FieldByname ('AplName').AsString;
                 If Assigned (eOnChanged) then eOnChanged (Sender);
               end
               else ShowMsg (100015,StrInt(Long,0));
               If mMyOp then dmSTK.btAPLLST.Close;
             end;
      ltStk: begin // Zoznam tovarovych skladov
               mMyOp := not dmSTK.btSTKLST.Active;
               If mMyOp then dmSTK.btSTKLST.Open;
               If dmSTK.btSTKLST.IndexName<>'StkNum' then dmSTK.btSTKLST.IndexName := 'StkNum';
               If dmSTK.btSTKLST.FindKey ([Long]) then begin
                 Text := dmSTK.btSTKLST.FieldByname ('StkName').AsString;
                 If Assigned (eOnChanged) then eOnChanged (Sender);
               end
               else ShowMsg (100015,StrInt(Long,0));
               If mMyOp then dmSTK.btSTKLST.Close;
             end;
      ltWri: begin // Zoznam prevadzkovych jednotiek
               mMyOp := not dmDLS.btWRILST.Active;
               If mMyOp then dmDLS.btWRILST.Open;
               If dmDLS.btWRILST.IndexName<>'WriNum' then dmDLS.btWRILST.IndexName := 'WriNum';
               If dmDLS.btWRILST.FindKey ([Long]) then begin
                 Text := dmDLS.btWRILST.FieldByname ('WriName').AsString;
                 If Assigned (eOnChanged) then eOnChanged (Sender);
               end
               else ShowMsg (100015,StrInt(Long,0));
               If mMyOp then dmDLS.btWRILST.Close;
             end;
      ltPab: begin // Zoznam knih partnerov
             end;
      ltPal: begin // Zoznam ocbhodnych partnerov
               mMyOp := not dmDLS.btPAB.Active;
               If mMyOp then dmDLS.btPAB.Open;
               If dmDLS.btPAB.IndexName<>'PaCode' then dmDLS.btPAB.IndexName := 'PaCode';
               If dmDLS.btPAB.FindKey ([Long]) then begin
                 Text := dmDLS.btPAB.FieldByname ('PaName').AsString;
                 If Assigned (eOnChanged) then eOnChanged (Sender);
               end
               else ShowMsg (100015,StrInt(Long,0));
               If mMyOp then dmDLS.btPAB.Close;
             end;
      ltWpa: begin // Zoznam ocbhodnych partnerov
             end;
      ltDlr: begin // Zoznam obchodnych zastupcov
               mMyOp := not dmDLS.btDLRLST.Active;
               If mMyOp then dmDLS.btDLRLST.Open;
               If dmDLS.btDLRLST.IndexName<>'DlrCode' then dmDLS.btDLRLST.IndexName := 'DlrCode';
               If dmDLS.btDLRLST.FindKey ([Long]) then begin
                 Text := dmDLS.btDLRLST.FieldByname ('DlrName').AsString;
                 If Assigned (eOnChanged) then eOnChanged (Sender);
               end
               else ShowMsg (100015,StrInt(Long,0));
               If mMyOp then dmDLS.btDLRLST.Close;
             end;
      ltEpl: begin // Zoznam zamestnancov
             end;
      ltRef: begin // Zoznam obchodnych referencii
               mMyOp := not dmDLS.btREFLST.Active;
               If mMyOp then dmDLS.btREFLST.Open;
               If dmDLS.btREFLST.IndexName<>'RefCode' then dmDLS.btREFLST.IndexName := 'RefCode';
               If dmDLS.btREFLST.FindKey ([Long]) then begin
                 Text := dmDLS.btREFLST.FieldByname ('RefName').AsString;
                 If Assigned (eOnChanged) then eOnChanged (Sender);
               end
               else ShowMsg (100015,StrInt(Long,0));
               If mMyOp then dmDLS.btREFLST.Close;
             end;
      ltDrv: begin // Zoznam obchodnych referencii
               mMyOp := not dmDLS.btDRVLST.Active;
               If mMyOp then dmDLS.btDRVLST.Open;
               If dmDLS.btDRVLST.IndexName<>'DrvCode' then dmDLS.btDRVLST.IndexName := 'DrvCode';
               If dmDLS.btDRVLST.FindKey ([Long]) then begin
                 Text := dmDLS.btDRVLST.FieldByname ('DrvName').AsString;
                 If Assigned (eOnChanged) then eOnChanged (Sender);
               end
               else ShowMsg (100015,StrInt(Long,0));
               If mMyOp then dmDLS.btDRVLST.Close;
             end;
      ltCnt: begin // Zoznam hospodarskych stredisk
               mMyOp := not dmDLS.btCNTLST.Active;
               If mMyOp then dmDLS.btCNTLST.Open;
               If dmDLS.btCNTLST.IndexName<>'CntNum' then dmDLS.btCNTLST.IndexName := 'CntNum';
               If dmDLS.btCNTLST.FindKey ([Long]) then begin
                 Text := dmDLS.btCNTLST.FieldByname ('CntName').AsString;
                 If Assigned (eOnChanged) then eOnChanged (Sender);
               end
               else ShowMsg (100015,StrInt(Long,0));
               If mMyOp then dmDLS.btCNTLST.Close;
             end;
    end;
  end;
end;

procedure TXPLstEdit.ShowLst (Sender: TObject);
var mKey:word; mShift: TShiftState;
begin
  SetFocus;
  case oLstType of
    ltGsl: begin // Zoznam tovarov z bazovej evidencie
             F_GscGsLstV := TF_GscGsLstV.Create (Self);
             F_GscGsLstV.SetBase(cGsc);
             F_GscGsLstV.ShowGsLst;
             If F_GscGsLstV.Accept then begin
               Long := F_GscGsLstV.GsCode;
               Text := F_GscGsLstV.GsName;
               If Assigned (eOnChanged) then eOnChanged (Sender);
               mKey := vk_Return;
               SpecKeyDownHandle (Self,mKey,mShift);
             end;
             FreeAndNil (F_GscGsLstV);
           end;
    ltMgl: begin // Zoznam tovarovych skupin
             F_GscMgLstV := TF_GscMgLstV.Create (Self);
             F_GscMgLstV.ShowModal (cView);
             If F_GscMgLstV.Accept then begin
               Long := F_GscMgLstV.MgCode;
               Text := F_GscMgLstV.MgName;
               If Assigned (eOnChanged) then eOnChanged (Sender);
               mKey := vk_Return;
               SpecKeyDownHandle (Self,mKey,mShift);
             end;
             FreeAndNil (F_GscMgLstV);
           end;
    ltFgl: begin // Zoznam financnych skupin
             F_GscFgLstV := TF_GscFgLstV.Create (Self);
             F_GscFgLstV.ShowModal (cView);
             If F_GscFgLstV.Accept then begin
               Long := F_GscFgLstV.FgCode;
               Text := F_GscFgLstV.FgName;
               If Assigned (eOnChanged) then eOnChanged (Sender);
               mKey := vk_Return;
               SpecKeyDownHandle (Self,mKey,mShift);
             end;
             FreeAndNil (F_GscFgLstV);
           end;
    ltSml: begin // Zoznam skladovych pohybov
             F_StkSmLstV := TF_StkSmLstV.Create (Self);
             F_StkSmLstV.ShowModal (cView);
             If F_StkSmLstV.Accept then begin
               Long := F_StkSmLstV.SmCode;
               Text := F_StkSmLstV.SmName;
               If Assigned (eOnChanged) then eOnChanged (Sender);
               mKey := vk_Return;
               SpecKeyDownHandle (Self,mKey,mShift);
             end;
             FreeAndNil (F_StkSmLstV);
           end;
    ltPls: begin // Zoznam predajnych cennikov
             F_SysPlsLstV := TF_SysPlsLstV.Create (Self);
             F_SysPlsLstV.ShowModal (cView);
             If F_SysPlsLstV.Accept then begin
               Long := F_SysPlsLstV.PlsNum;
               Text := F_SysPlsLstV.PlsName;
               If Assigned (eOnChanged) then eOnChanged (Sender);
               mKey := vk_Return;
              SpecKeyDownHandle (Self,mKey,mShift);
             end;
             FreeAndNil (F_SysPlsLstV);
           end;
    ltApl: begin  // Zoznam akciovych cennikov
             F_SysAplLstV := TF_SysAplLstV.Create (Self);
             F_SysAplLstV.ShowModal (cView);
             If F_SysAplLstV.Accept then begin
               Long := F_SysAplLstV.AplNum;
               Text := F_SysAplLstV.AplName;
               If Assigned (eOnChanged) then eOnChanged (Sender);
               mKey := vk_Return;
              SpecKeyDownHandle (Self,mKey,mShift);
             end;
             FreeAndNil (F_SysAplLstV);
           end;
    ltStk: begin // Zoznam tovarovych skladov
             F_SysStkLstV := TF_SysStkLstV.Create (Self);
             F_SysStkLstV.ShowModal (cView);
             If F_SysStkLstV.Accept then begin
               Long := F_SysStkLstV.StkNum;
               Text := F_SysStkLstV.StkName;
               If Assigned (eOnChanged) then eOnChanged (Sender);
               mKey := vk_Return;
              SpecKeyDownHandle (Self,mKey,mShift);
             end;
             FreeAndNil (F_SysStkLstV);
           end;
    ltWri: begin // Zoznam prevadzkovych jednotiek
             F_SysWriLstV := TF_SysWriLstV.Create (Self);
             F_SysWriLstV.ShowModal (cView);
             If F_SysWriLstV.Accept then begin
               Long := F_SysWriLstV.WriNum;
               Text := F_SysWriLstV.WriName;
               If Assigned (eOnChanged) then eOnChanged (Sender);
               mKey := vk_Return;
              SpecKeyDownHandle (Self,mKey,mShift);
             end;
             FreeAndNil (F_SysWriLstV);
           end;
    ltPab: begin // Zoznam knih partnerov
           end;
    ltPal: begin // Zoznam ocbhodnych partnerov
             F_PabPacLstV := TF_PabPacLstV.Create (Self);
             F_PabPacLstV.ShowModal (cView);
             If F_PabPacLstV.Accept then begin
               Long := F_PabPacLstV.PaCode;
               Text := F_PabPacLstV.PaName;
               If Assigned (eOnChanged) then eOnChanged (Sender);
               mKey := vk_Return;
               SpecKeyDownHandle (Self,mKey,mShift);
             end;
             FreeAndNil (F_PabPacLstV);
           end;
    ltDlr: begin // Zoznam obchodnych zastupcov
             F_SysDlrLstV := TF_SysDlrLstV.Create (Self);
             F_SysDlrLstV.ShowModal (cView);
             If F_SysDlrLstV.Accept then begin
               Long := F_SysDlrLstV.DlrCode;
               Text := F_SysDlrLstV.DlrName;
               If Assigned (eOnChanged) then eOnChanged (Sender);
               mKey := vk_Return;
               SpecKeyDownHandle (Self,mKey,mShift);
             end;
             FreeAndNil (F_SysDlrLstV);
           end;
    ltEpl: begin // Zoznam zamestnancov
             F_SysEpcLstV := TF_SysEpcLstV.Create (Self);
             F_SysEpcLstV.ShowModal (cView);
             If F_SysEpcLstV.Accept then begin
//               Long := F_SysEpcLstV.EpCode;
               Text := F_SysEpcLstV.EpName;
               If Assigned (eOnChanged) then eOnChanged (Sender);
               mKey := vk_Return;
               SpecKeyDownHandle (Self,mKey,mShift);
             end;
             FreeAndNil (F_SysEpcLstV);
           end;
    ltRef: begin // Zoznam obchodnych referencii
             F_SysRefLstV := TF_SysRefLstV.Create (Self);
             F_SysRefLstV.ShowModal (cView);
             If F_SysRefLstV.Accept then begin
               Long := F_SysRefLstV.RefCode;
               Text := F_SysRefLstV.RefName;
               If Assigned (eOnChanged) then eOnChanged (Sender);
               mKey := vk_Return;
               SpecKeyDownHandle (Self,mKey,mShift);
             end;
             FreeAndNil (F_SysRefLstV);
           end;
    ltDrv: begin // Zoznam vodicov sluzobnych vozidiel
             F_SysDrvLstV := TF_SysDrvLstV.Create (Self);
             F_SysDrvLstV.ShowModal (cView);
             If F_SysDrvLstV.Accept then begin
               Long := F_SysDrvLstV.DrvCode;
               Text := F_SysDrvLstV.DrvName;
               If Assigned (eOnChanged) then eOnChanged (Sender);
               mKey := vk_Return;
               SpecKeyDownHandle (Self,mKey,mShift);
             end;
             FreeAndNil (F_SysDrvLstV);
           end;
    ltCnt: begin // Zoznam prevadzkovych jednotiek
             F_SysCntLstV := TF_SysCntLstV.Create (Self);
             F_SysCntLstV.ShowModal (cView);
             If F_SysCntLstV.Accept then begin
               Long := F_SysCntLstV.CntNum;
               Text := F_SysCntLstV.CntName;
               If Assigned (eOnChanged) then eOnChanged (Sender);
               mKey := vk_Return;
               SpecKeyDownHandle (Self,mKey,mShift);
             end;
             FreeAndNil (F_SysCntLstV);
           end;
  end;
end;

// ************** xpEditor zoznamov *************
constructor TxpSelectEdit.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  inherited OnEnter := MyOnEnter;
  inherited OnExit := MyOnExit;
  Width := 281;
  Height := 17;

  oEdit := TxpEdit.Create (Self);
  oEdit.Parent := Self;
  oEdit.Width := 40;
//  oEdit.EditorType:= etInteger;
  oEdit.OnKeyDown := MyKeyDown;

  oInfo := TxpEdit.Create (Self);
  oInfo.Parent := Self;
  oInfo.Top := 0;
  oInfo.Left := 42;
//  oInfo.EditorType:= etString;
  oInfo.Enabled:= False;
  oInfo.Text := '';

  // xpcomp
  oButt := TxpBitBtn.Create (Self);
  oButt.Parent := Self;
  oButt.Width := 17;
  oButt.Height := 17;
  oButt.Align := alRight;
  oButt.Caption:='';
//  oButt.ButtonType := btNwSelect;
//  oButt.NumGlyphs := 2;
//  oButt.TabStop := FALSE;
  oButt.OnClick := ShowLst;

  oEdit.EditorType:= etInteger;
  oInfo.EditorType:= etString;
end;

destructor TxpSelectEdit.Destroy;
begin
  oInfo.Free;
  oEdit.Free;
  oButt.Free;
  inherited;
end;

procedure TxpSelectEdit.Loaded;
begin
  inherited;
//  L_Text.Font.Charset := gvSys.FontCharset;
//  SetSize; // Nastavi rozmer editora pdola jeho komponentov
end;

procedure TxpSelectEdit.SetFocus;
begin
  oEdit.SetFocus;
end;

procedure TxpSelectEdit.SetLong(pValue:longint);
begin
  oEdit.AsInteger := pValue;
  SearchData (Self);
end;

function TxpSelectEdit.GetLong:longint;
begin
  Result := oEdit.AsInteger;
end;

procedure TxpSelectEdit.SetText(pValue: Str30);
begin
  oInfo.Text := pValue;
end;

function TxpSelectEdit.GetText: Str30;
begin
  Result := oInfo.Text;
end;

procedure TxpSelectEdit.SetShowText(pValue: boolean);
begin
  oInfo.Visible := pValue;
  SetSize; // Nastavi rozmer editora pdola jeho komponentov
end;

function TxpSelectEdit.GetShowText: boolean;
begin
  Result := oInfo.Visible;
end;

procedure TxpSelectEdit.SetWidthLong(pValue: word);
begin
  oEdit.Width := pValue;
  SetSize; // Nastavi rozmer editora pdola jeho komponentov
end;

function TxpSelectEdit.GetWidthLong: word;
begin
  Result := oEdit.Width;
end;

procedure TxpSelectEdit.SetWidthText(pValue: word);
begin
  oInfo.Width := pValue;
  SetSize; // Nastavi rozmer editora pdola jeho komponentov
end;

function TxpSelectEdit.GetWidthText: word;
begin
  Result := oInfo.Width;
end;

procedure TxpSelectEdit.MyKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
begin
//  SpecKeyDownHandle (Self,Key,Shift);
  If Key=vk_F7 then  ShowLst (Sender);
  If (Key=vk_Return) and (Long=0) then  ShowLst (Sender);
  If Assigned (eOnKeyDown) then eOnKeyDown (Sender,Key,Shift);
end;

procedure TxpSelectEdit.MyOnEnter (Sender: TObject);
begin
  If Assigned (eOnEnter) then eOnEnter (Sender);
end;

procedure TxpSelectEdit.MyOnExit (Sender: TObject);
begin
  SearchData (Sender);
  If Assigned (eOnExit) then eOnExit (Sender);
end;

procedure TxpSelectEdit.SetSize; // Nastavi rozmer editora pdola jeho komponentov
begin
  If oInfo.Visible
    then Width := oEdit.Width+2+oInfo.Width+2+oButt.Width
    else Width := oEdit.Width+2+oButt.Width;
  oInfo.Left := oEdit.Width+2;
  RecreateWnd;
end;

procedure TxpSelectEdit.SearchData (Sender: TObject);
begin
end;

procedure TxpSelectEdit.ShowLst (Sender: TObject);
begin
end;


// ********************** Register ************************
procedure Register;
begin
  RegisterComponents('NwSelectEdit', [TXPLstEdit]);
end;

end.
