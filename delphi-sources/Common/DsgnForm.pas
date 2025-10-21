unit DsgnForm;

interface

uses
  IcForm, 
  EncodeIni, IcTools, IcConv, DsgnUtils, DsgnOpen, DsgnSave,
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, xpComp, ExtCtrls, ComCtrls, StdCtrls;

type
  TF_DsgnForm = class(TIcForm)
    xpSinglePanel1: TxpSinglePanel;
    xpPageControl1: TxpPageControl;
    xpTabSheet1: TxpTabSheet;
    xpTabSheet2: TxpTabSheet;
    xpSinglePanel2: TxpSinglePanel;
    BB_OpenForm: TxpBitBtn;
    BB_SaveForm: TxpBitBtn;
    CB_HideCompList: TxpComboBox;
    B_ShowSel: TxpBitBtn;
    BB_NewForm: TxpBitBtn;
    B_ShowLabel: TxpBitBtn;
    B_ShowEdit: TxpBitBtn;
    B_ShowBitBtn: TxpBitBtn;
    B_ShowRadioButton: TxpBitBtn;
    B_ShowCheckBox: TxpBitBtn;
    B_ShowComboBox: TxpBitBtn;
    B_ShowMemo: TxpBitBtn;
    B_ShowRichEdit: TxpBitBtn;
    B_ShowSinglePanel: TxpBitBtn;
    B_ShowGroupBox: TxpBitBtn;
    B_ShowPageControl: TxpBitBtn;
    B_CompCopy: TxpBitBtn;
    B_CompPaste: TxpBitBtn;
    B_ShowBasic: TxpBitBtn;
    B_ShowAct: TxpBitBtn;
    B_CompDel: TxpBitBtn;
    B_ToFront: TxpBitBtn;
    B_ToBack: TxpBitBtn;
    xpBitBtn1: TxpBitBtn;
    xpBitBtn2: TxpBitBtn;
    procedure BB_NewFormClick(Sender: TObject);
    procedure BB_OpenFormClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure B_CompPastelick(Sender: TObject);
    procedure BB_SaveFormClick(Sender: TObject);
    procedure B_CompCopyClick(Sender: TObject);
    procedure B_CompDelClick(Sender: TObject);
    procedure B_ShowSwitchClick(Sender: TObject);
    procedure B_ShowActClick(Sender: TObject);
    procedure B_ShowSelClick(Sender: TObject);
    procedure B_ToFrontClick(Sender: TObject);
    procedure B_ToBackClick(Sender: TObject);
  published
    constructor Create(AOwner: TComponent); override;
    destructor  Destroy; override;
    procedure   Execute;
  private
    oFirst       : boolean;
    oFileName    : string;
    oReadedForm  : byte;
    oFormNum     : byte;
    oFormName    : string;
    oLevel       : longint;
    oSelMode     : boolean;

    oMouseX      : longint;
    oMouseY      : longint;
    oShiftPress  : boolean;
    oMouseDown   : boolean;
    oSizingType  : byte;
    oShift       : TShiftState;       // stav naposledy stalcenej klavesy
    oCompLstPos  : TStringList;
    oHideCompFilt: longint;
    oCompData    : TCompData;

    procedure MyCompOnClick (Sender: TObject);
    procedure MyCompMouseDown(Sender: TObject; Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
    procedure MyCompMouseMove(Sender: TObject; Shift: TShiftState; X,Y: Integer);
    procedure MyCompMouseUp(Sender: TObject; Button: TMouseButton; Shift: TShiftState; X, Y: Integer);

    procedure MyCompOnKeyDown (Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure MyCompOnKeyUp (Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure MyCompOnEnter (Sender: TObject);

    procedure MyFormResize (Sender: TObject);

    procedure ChangeTopPos (pSender:TObject;pChange:longint);
    procedure ChangeLeftPos (pSender:TObject;pChange:longint);
    procedure ChangeHeight (pSender:TObject;pChange:longint);
    procedure ChangeWidth (pSender:TObject;pChange:longint);
    procedure SelectComp (Sender:TObject);
    procedure SelectNextComp (pSender:TObject;pDirection:word);
    procedure RepaintAll;
    procedure FillCompListByPos (pDirection:word);

    procedure SetCompSelected (pComp:TComponent;pSelected:boolean);
    function  CompIsVisibled (pComp:TComponent):boolean;
    procedure SetShowComp (pComp:TComponent);
    procedure SetHideComp (pParent:string);
    function  GetDefParent (pParam:string):string;

    function  GetDefProp(pComp:string;pIni:TEncodeIniFile):string;
    procedure HideSelComps;

    procedure LoadFormComp (pSect:TStrings);
    procedure ClearAllSelect (pOnlyComp:boolean);

    procedure ClearDefCompList;
    procedure AddDefCompList (pName,pCompFlds:string);

    function  GetTabOrder (pComp:TComponent):longint;
    procedure SetTabOrder (pComp:TComponent;pVal:longint);
    function  IsTabOrder (pComp:TComponent):boolean;
    procedure TabPressed (Sender:TObject;pShift:TShiftState);
    function  CompIsTabStop (pComp:TComponent):boolean;
  public
    oForm        : TMoveForm;
    oSelCnt      : longint;
    oDefCompList : TStringList;
    oFirstSelComp: string;
    procedure SetCompSelectByName (pComp:string);
    procedure FillHideCompList;
    function  ParentVerify (pParent:string):boolean;
    function  CompIsSelected (pComp:TComponent):boolean;
    procedure RecalcTabOrder (pParent,pCompName:string;pVal:longint);

    procedure OpenFormComp;
    procedure PasteFormComp;
    function  CrtForm (pName,pParam:string):boolean;
    function  CrtxpSinglePanel (pName,pParam,pDefParent:string):boolean;
    function  CrtxpGroupBox (pName,pParam,pDefParent:string):boolean;
    function  CrtxpPageControl (pName,pParam,pDefParent:string):boolean;
    function  CrtxpTabSheet (pName,pParam,pDefParent:string):boolean;
    function  CrtxpButton (pName,pParam,pDefParent:string):boolean;
    function  CrtxpEdit (pName,pParam,pDefParent:string):boolean;
    function  CrtxpLabel (pName,pParam,pDefParent:string):boolean;
    function  CrtxpCheckBox (pName,pParam,pDefParent:string):boolean;
    function  CrtxpComboBox (pName,pParam,pDefParent:string):boolean;
    function  CrtxpRadioButton (pName,pParam,pDefParent:string):boolean;
    function  CrtxpMemo (pName,pParam,pDefParent:string):boolean;
    function  CrtxpRichEdit (pName,pParam,pDefParent:string):boolean;
    function  CrtxpStatusLine (pName,pParam,pDefParent:string):boolean;
    function  CrtBasic (pName,pParam,pDefParent:string):boolean;

    procedure SaveFormComp;
    procedure CopyFormComp;
    function  GetCompParams (pComp:TComponent;pDefProp:string):string;
    function  GetFormParams (pComp:TForm;pDefProp:string):string;
    function  GetxpSinglePanelCompParams (pComp:TxpSinglePanel;pDefProp:string):string;
    function  GetxpGroupBoxCompParams (pComp:TxpGroupBox;pDefProp:string):string;
    function  GetxpPageControlCompParams (pComp:TxpPageControl;pDefProp:string):string;
    function  GetxpTabSheetCompParams (pComp:TxpTabSheet;pDefProp:string):string;
    function  GetxpButtonCompParams (pComp:TxpUniComp;pDefProp:string):string;
    function  GetxpEditCompParams (pComp:TxpUniComp;pDefProp:string):string;
    function  GetxpLabelCompParams (pComp:TxpUniComp;pDefProp:string):string;
    function  GetxpCheckBoxCompParams (pComp:TxpUniComp;pDefProp:string):string;
    function  GetxpComboBoxCompParams (pComp:TxpUniComp;pDefProp:string):string;
    function  GetxpRadioButtonCompParams (pComp:TxpUniComp;pDefProp:string):string;
    function  GetxpMemoCompParams (pComp:TxpUniComp;pDefProp:string):string;
    function  GetxpRichEditCompParams (pComp:TxpUniComp;pDefProp:string):string;
    function  GetxpStatusLineCompParams (pComp:TxpStatusLine;pDefProp:string):string;
    function  GetBasicCompParams (pComp:TxpUniComp;pDefProp:string):string;

    property FileName:string read oFileName write oFileName;
    property FormNum:byte read oFormNum write oFormNum;
  end;

var
  uCompSect : TStrings;

implementation

{$R *.dfm}

  uses DsgnInsp;

// TF_DsgnForm
procedure TF_DsgnForm.MyCompOnClick (Sender: TObject);
var mS:string; mAdd:boolean; mChangePos:boolean; mComp:TComponent;
begin
  If oSelMode
    then SelectComp (Sender)
    else begin
      If (Sender is TForm) or (Sender is TxpSinglePanel) or (Sender is TxpGroupBox) or (Sender is TxpPageControl) or (Sender is TxpTabSheet) then begin
        If CB_HideCompList.ItemIndex>-1 then begin
          mS := CB_HideCompList.Items.Strings[CB_HideCompList.ItemIndex];
          mS := Copy (mS,1,Pos (' ',mS)-1);
          mChangePos := FALSE;
          mComp := oForm.FindComponent(mS);
          mAdd := (mComp as TWinControl).Parent=Sender;
          If mAdd
            then mChangePos := TRUE
            else mAdd := MessageDlg('Vybraný objekt je súèasou iného komponentu!'+#13+'Chcete vloži na pôvodné miesto?', mtConfirmation, [mbYes, mbNo], 0) = mrYes;
          If mAdd then SetShowComp(mComp);
          If mAdd then begin
            ClearAllSelect (TRUE);
            FillHideCompList;
            SetCompSelected (mComp,TRUE);
            If mChangePos then begin
              (mComp as TWinControl).Left := oMouseX;
              (mComp as TWinControl).Top := oMouseY;
            end;
          end;
        end;
      end else SelectComp (Sender);
    end;
end;

procedure TF_DsgnForm.MyCompMouseDown(Sender: TObject; Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
var mW,mH:longint;
begin
  oSizingType := 0;
  If not oMouseDown then begin
    oMouseX := X;
    oMouseY := Y;
    mW := (Sender as TControl).Width;
    mH := (Sender as TControl).Height;
    If (X>=0) and (X<=5) and (Y>=0) and (Y<=5) then oSizingType := 1;
    If (X>=0) and (X<=5) and (Y>=(mH div 2 -2)) and (Y<=(mH div 2 +3)) then oSizingType := 2;
    If (X>=0) and (X<=5) and (Y>=mH-5) and (Y<=mH) then oSizingType := 3;
    If (X>=(mW div 2 -2)) and (X<=(mW div 2 +3)) and (Y>=0) and (Y<=5) then oSizingType := 4;
    If (X>=(mW div 2 -2)) and (X<=(mW div 2 +3)) and (Y>=mH-5) and (Y<=mH) then oSizingType := 5;
    If (X>=mW-5) and (X<=mW) and (Y>=0) and (Y<=5) then oSizingType := 6;
    If (X>=mW-5) and (X<=mW) and (Y>=(mH div 2 -2)) and (Y<=(mH div 2 +3)) then oSizingType := 7;
    If (X>=mW-5) and (X<=mW) and (Y>=mH-5) and (Y<=mH) then oSizingType := 8;
  end;
  oMouseDown := TRUE;
  oShift := Shift;
end;

procedure TF_DsgnForm.MyCompMouseMove(Sender: TObject; Shift: TShiftState; X,Y: Integer);
var mSelected:boolean;
  I:longint;
  mW,mH:longint;
  mX,mY:longint;
begin
  (Sender as TControl).Cursor := crDefault;
  mSelected := CompIsSelected(Sender as TComponent);

  If mSelected and not cUniMultiSelect then begin
    mW := (Sender as TControl).Width;
    mH := (Sender as TControl).Height;
    // nastavenie typu kurzora mysi pre zmenu velksti komponentu
    If (X>=0) and (X<=5) and (Y>=0) and (Y<=5) then (Sender as TControl).Cursor := crSizeNWSE;
    If (X>=0) and (X<=5) and (Y>=(mH div 2 -2)) and (Y<=(mH div 2 +3)) then (Sender as TControl).Cursor := crSizeWE;
    If (X>=0) and (X<=5) and (Y>=mH-5) and (Y<=mH) then (Sender as TControl).Cursor := crSizeNESW;
    If (X>=(mW div 2 -2)) and (X<=(mW div 2 +3)) and (Y>=0) and (Y<=5) then (Sender as TControl).Cursor := crSizeNS;
    If (X>=(mW div 2 -2)) and (X<=(mW div 2 +3)) and (Y>=mH-5) and (Y<=mH) then (Sender as TControl).Cursor := crSizeNS;
    If (X>=mW-5) and (X<=mW) and (Y>=0) and (Y<=5) then (Sender as TControl).Cursor := crSizeNESW;
    If (X>=mW-5) and (X<=mW) and (Y>=(mH div 2 -2)) and (Y<=(mH div 2 +3)) then (Sender as TControl).Cursor := crSizeWE;
    If (X>=mW-5) and (X<=mW) and (Y>=mH-5) and (Y<=mH) then (Sender as TControl).Cursor := crSizeNWSE;

    If oMouseDown then begin
      case oSizingType of
        0: begin
             (Sender as TControl).Left := (Sender as TControl).Left+X-oMouseX;
             (Sender as TControl).Top := (Sender as TControl).Top+Y-oMouseY;
           end;
        1: begin
             (Sender as TControl).Left := (Sender as TControl).Left+X-oMouseX;
             (Sender as TControl).Top := (Sender as TControl).Top+Y-oMouseY;
             (Sender as TControl).Width := (Sender as TControl).Width-(X-oMouseX);
             (Sender as TControl).Height := (Sender as TControl).Height-(Y-oMouseY);
           end;
        2: begin
             (Sender as TControl).Left := (Sender as TControl).Left+X-oMouseX;
             (Sender as TControl).Width := (Sender as TControl).Width-(X-oMouseX);
           end;
        3: begin
             (Sender as TControl).Left := (Sender as TControl).Left+X-oMouseX;
             (Sender as TControl).Width := (Sender as TControl).Width-(X-oMouseX);
             (Sender as TControl).Height := (Sender as TControl).Height+(Y-oMouseY);
             oMouseY := Y;
           end;
        4: begin
             (Sender as TControl).Top := (Sender as TControl).Top+Y-oMouseY;
             (Sender as TControl).Height := (Sender as TControl).Height-(Y-oMouseY);
           end;
        5: begin
             (Sender as TControl).Height := (Sender as TControl).Height+(Y-oMouseY);
             oMouseY := Y;
           end;
        6: begin
             (Sender as TControl).Top := (Sender as TControl).Top+Y-oMouseY;
             (Sender as TControl).Height := (Sender as TControl).Height-(Y-oMouseY);
             (Sender as TControl).Width := (Sender as TControl).Width+(X-oMouseX);
             oMouseX := X;
           end;
        7: begin
             (Sender as TControl).Width := (Sender as TControl).Width+(X-oMouseX);
             oMouseX := X;
           end;
        8: begin
             (Sender as TControl).Width := (Sender as TControl).Width+(X-oMouseX);
             (Sender as TControl).Height := (Sender as TControl).Height+(Y-oMouseY);
             oMouseY := Y;
             oMouseX := X;
           end;
      end;
    end;
  end else begin
    If mSelected and cUniMultiSelect and oMouseDown then begin
      (Sender as TControl).Cursor := crDefault;
      If ParentVerify((Sender as TWinControl).Parent.Name) then begin
        mX := (Sender as TControl).Left;
        mY := (Sender as TControl).Top;
        (Sender as TControl).Left := (Sender as TControl).Left+X-oMouseX;
        (Sender as TControl).Top := (Sender as TControl).Top+Y-oMouseY;
        If (mX<>(Sender as TControl).Left) or (mY<>(Sender as TControl).Top) then begin
          For I:=0 to oForm.ComponentCount-1 do begin
            If oForm.Components[I].Name<>(Sender as TControl).Name then begin
              mSelected := CompIsSelected(oForm.Components[I]);
              If mSelected then begin
                If ParentVerify((oForm.Components[I] as TWinControl).Parent.Name) then begin
                  (oForm.Components[I] as TControl).Left := (oForm.Components[I] as TControl).Left+X-oMouseX;
                  (oForm.Components[I] as TControl).Top := (oForm.Components[I] as TControl).Top+Y-oMouseY;
                end;
              end;
            end;
          end;
        end;
      end;
    end;
  end;
end;

procedure TF_DsgnForm.MyCompMouseUp(Sender: TObject; Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
begin
  oMouseDown := FALSE;
  oShift := [];
end;

procedure TF_DsgnForm.MyCompOnKeyDown (Sender: TObject; var Key: Word; Shift: TShiftState);
begin
  oShiftPress := (ssShift in Shift);
  case Key of
    VK_DELETE: If Shift=[] then HideSelComps;
    VK_UP    : begin
                 If Shift=[ssShift]
                   then ChangeHeight (Sender,-1)
                   else begin
                     If Shift=[ssCtrl]
                       then ChangeTopPos (Sender,-1)
                       else SelectNextComp (Sender,VK_UP);
                   end;
                 Key := 0;
               end;
    VK_DOWN  : begin
                 If Shift=[ssShift]
                   then ChangeHeight (Sender,1)
                   else begin
                     If Shift=[ssCtrl]
                       then ChangeTopPos (Sender,1)
                       else SelectNextComp (Sender,VK_DOWN);
                   end;
                 Key := 0;
               end;
    VK_LEFT  : begin
                 If Shift=[ssShift]
                   then ChangeWidth (Sender,-1)
                   else begin
                     If Shift=[ssCtrl]
                       then ChangeLeftPos (Sender,-1)
                       else SelectNextComp (Sender,VK_LEFT);
                   end;
                 Key := 0;
               end;
    VK_RIGHT : begin
                 If Shift=[ssShift]
                   then ChangeWidth (Sender,1)
                   else begin
                     If Shift=[ssCtrl]
                       then ChangeLeftPos (Sender,1)
                       else SelectNextComp (Sender,VK_RIGHT);
                   end;
                 Key := 0;
               end;
  end;
end;

procedure TF_DsgnForm.MyCompOnKeyUp (Sender: TObject; var Key: Word; Shift: TShiftState);
begin
  If Key=VK_SHIFT then oShiftPress := FALSE;
  case Key of
    VK_TAB   : begin
      oShiftPress := FALSE;
      TabPressed (Sender,Shift);
    end;
  end;  
end;

procedure TF_DsgnForm.MyCompOnEnter (Sender: TObject);
begin
  If oForm.ActiveControl<>nil then oForm.ActiveControl := nil;
end;

procedure TF_DsgnForm.MyFormResize (Sender: TObject);
begin
  If oSelCnt=0 then F_DsgnInsp.FillObjInsp;
end;

procedure TF_DsgnForm.ChangeTopPos (pSender:TObject;pChange:longint);
var I:longint;
begin
  If oForm.ComponentCount>0 then begin
    For I:=0 to oForm.ComponentCount-1 do begin
      If CompIsSelected(oForm.Components[I]) then begin
        If ParentVerify ((oForm.Components[I] as TWinControl).Parent.Name) then begin
          If (oForm.Components[I] is TxpUniComp) then (oForm.Components[I] as TxpUniComp).Top := (oForm.Components[I] as TxpUniComp).Top+pChange;
          If (oForm.Components[I] is TxpSinglePanel) then (oForm.Components[I] as TxpSinglePanel).Top := (oForm.Components[I] as TxpSinglePanel).Top+pChange;
          If (oForm.Components[I] is TxpGroupBox) then (oForm.Components[I] as TxpGroupBox).Top := (oForm.Components[I] as TxpGroupBox).Top+pChange;
          If (oForm.Components[I] is TxpPageControl) then (oForm.Components[I] as TxpPageControl).Top := (oForm.Components[I] as TxpPageControl).Top+pChange;
          If (oForm.Components[I] is TxpTabSheet) then (oForm.Components[I] as TxpTabSheet).Top := (oForm.Components[I] as TxpTabSheet).Top+pChange;
          If oSelCnt<=1 then F_DsgnInsp.FillObjInsp;
        end;
      end;
    end;
  end;
end;

procedure TF_DsgnForm.ChangeLeftPos (pSender:TObject;pChange:longint);
var I:longint;
begin
  If oForm.ComponentCount>0 then begin
    For I:=0 to oForm.ComponentCount-1 do begin
      If CompIsSelected(oForm.Components[I]) then begin
        If ParentVerify ((oForm.Components[I] as TWinControl).Parent.Name) then begin
          If (oForm.Components[I] is TxpUniComp) then (oForm.Components[I] as TxpUniComp).Left := (oForm.Components[I] as TxpUniComp).Left+pChange;
          If (oForm.Components[I] is TxpSinglePanel) then (oForm.Components[I] as TxpSinglePanel).Left := (oForm.Components[I] as TxpSinglePanel).Left+pChange;
          If (oForm.Components[I] is TxpGroupBox) then (oForm.Components[I] as TxpGroupBox).Left := (oForm.Components[I] as TxpGroupBox).Left+pChange;
          If (oForm.Components[I] is TxpPageControl) then (oForm.Components[I] as TxpPageControl).Left := (oForm.Components[I] as TxpPageControl).Left+pChange;
          If (oForm.Components[I] is TxpTabSheet) then (oForm.Components[I] as TxpTabSheet).Left := (oForm.Components[I] as TxpTabSheet).Left+pChange;
          If oSelCnt<=1 then F_DsgnInsp.FillObjInsp;
        end;
      end;
    end;
  end;
end;

procedure TF_DsgnForm.ChangeHeight (pSender:TObject;pChange:longint);
var I:longint;
begin
  If oForm.ComponentCount>0 then begin
    For I:=0 to oForm.ComponentCount-1 do begin
      If CompIsSelected(oForm.Components[I]) then begin
        If (oForm.Components[I] is TxpUniComp) then (oForm.Components[I] as TxpUniComp).Height := (oForm.Components[I] as TxpUniComp).Height+pChange;
        If (oForm.Components[I] is TxpSinglePanel) then (oForm.Components[I] as TxpSinglePanel).Height := (oForm.Components[I] as TxpSinglePanel).Height+pChange;
        If (oForm.Components[I] is TxpGroupBox) then (oForm.Components[I] as TxpGroupBox).Height := (oForm.Components[I] as TxpGroupBox).Height+pChange;
        If (oForm.Components[I] is TxpPageControl) then (oForm.Components[I] as TxpPageControl).Height := (oForm.Components[I] as TxpPageControl).Height+pChange;
        If (oForm.Components[I] is TxpTabSheet) then (oForm.Components[I] as TxpTabSheet).Height := (oForm.Components[I] as TxpTabSheet).Height+pChange;
        If oSelCnt<=1 then F_DsgnInsp.FillObjInsp;
      end;
    end;
  end;
end;

procedure TF_DsgnForm.ChangeWidth (pSender:TObject;pChange:longint);
var I:longint;
begin
  If oForm.ComponentCount>0 then begin
    For I:=0 to oForm.ComponentCount-1 do begin
      If CompIsSelected(oForm.Components[I]) then begin
        If (oForm.Components[I] is TxpUniComp) then (oForm.Components[I] as TxpUniComp).Width := (oForm.Components[I] as TxpUniComp).Width+pChange;
        If (oForm.Components[I] is TxpSinglePanel) then (oForm.Components[I] as TxpSinglePanel).Width := (oForm.Components[I] as TxpSinglePanel).Width+pChange;
        If (oForm.Components[I] is TxpGroupBox) then (oForm.Components[I] as TxpGroupBox).Width := (oForm.Components[I] as TxpGroupBox).Width+pChange;
        If (oForm.Components[I] is TxpPageControl) then (oForm.Components[I] as TxpPageControl).Width := (oForm.Components[I] as TxpPageControl).Width+pChange;
        If (oForm.Components[I] is TxpTabSheet) then (oForm.Components[I] as TxpTabSheet).Width := (oForm.Components[I] as TxpTabSheet).Width+pChange;
        If oSelCnt<=1 then F_DsgnInsp.FillObjInsp;
      end;
    end;
  end;
end;

procedure TF_DsgnForm.SelectComp (Sender:TObject);
var mFind,mSelected:boolean; mCompName:string;I,mOldSelCnt:longint;
begin
  mFind := FALSE; mOldSelCnt := oSelCnt;
  If (Sender is TxpSinglePanel) then begin
    mFind := TRUE;
    mSelected := (Sender as TxpSinglePanel).Selected;
    If oShiftPress then begin
      (Sender as TxpSinglePanel).Selected := not (Sender as TxpSinglePanel).Selected;
      If (Sender as TxpSinglePanel).Selected
        then Inc (oSelCnt)
        else Dec (oSelCnt);
      cUniMultiSelect := (oSelCnt>1);
    end else begin
      If not mSelected then begin
        ClearAllSelect (TRUE);
        oSelCnt := 1;
        cUniMultiSelect := FALSE;
        (Sender as TxpSinglePanel).Selected := TRUE;
      end;
    end;
  end;
  If (Sender is TxpGroupBox) then begin
    mFind := TRUE;
    mSelected := (Sender as TxpGroupBox).Selected;
    If oShiftPress then begin
      (Sender as TxpGroupBox).Selected := not (Sender as TxpGroupBox).Selected;
      If (Sender as TxpGroupBox).Selected
        then Inc (oSelCnt)
        else Dec (oSelCnt);
      cUniMultiSelect := (oSelCnt>1);
    end else begin
      If not mSelected then begin
        ClearAllSelect (TRUE);
        oSelCnt := 1;
        cUniMultiSelect := FALSE;
        (Sender as TxpGroupBox).Selected := TRUE;
      end;
    end;
  end;
  If (Sender is TxpPageControl) then begin
    mFind := TRUE;
    mSelected := (Sender as TxpPageControl).Selected;
    If oShiftPress then begin
      (Sender as TxpPageControl).Selected := not (Sender as TxpPageControl).Selected;
      If (Sender as TxpPageControl).Selected
        then Inc (oSelCnt)
        else Dec (oSelCnt);
      cUniMultiSelect := (oSelCnt>1);
    end else begin
      If not mSelected then begin
        ClearAllSelect (TRUE);
        oSelCnt := 1;
        cUniMultiSelect := FALSE;
        (Sender as TxpPageControl).Selected := TRUE;
      end;
    end;
  end;
  If (Sender is TxpTabSheet) then begin
    mFind := TRUE;
    mSelected := (Sender as TxpTabSheet).Selected;
    If oShiftPress then begin
      (Sender as TxpTabSheet).Selected := not (Sender as TxpTabSheet).Selected;
      If (Sender as TxpTabSheet).Selected
        then Inc (oSelCnt)
        else Dec (oSelCnt);
      cUniMultiSelect := (oSelCnt>1);
    end else begin
      If not mSelected then begin
        ClearAllSelect (TRUE);
        oSelCnt := 1;
        cUniMultiSelect := FALSE;
        (Sender as TxpTabSheet).Selected := TRUE;
      end;
    end;
  end;
  If (Sender is TxpUniComp) then begin
    mFind := TRUE;
    mSelected := (Sender as TxpUniComp).Selected;
    If oShiftPress then begin
      (Sender as TxpUniComp).Selected := not (Sender as TxpUniComp).Selected;
      If (Sender as TxpUniComp).Selected
        then Inc (oSelCnt)
        else Dec (oSelCnt);
      cUniMultiSelect := (oSelCnt>1);
    end else begin
      If not mSelected then begin
        ClearAllSelect (TRUE);
        oSelCnt := 1;
        cUniMultiSelect := FALSE;
        (Sender as TxpUniComp).Selected := TRUE;
      end;
    end;
  end;
  If not mFind or (oSelCnt=0) then begin
    ClearAllSelect (FALSE);
  end else begin
    If (oSelCnt=1) or (oSelCnt<mOldSelCnt) then begin
      For I:=0 to oForm.ComponentCount-1 do begin
        If CompIsSelected(oForm.Components[I]) then mCompName := oForm.Components[I].Name;
      end;
    end else begin
      mCompName := (Sender as TComponent).Name;
    end;
    If oSelCnt=1 then oFirstSelComp := mCompName;
    F_DsgnInsp.SetSelectedComp(mCompName);
    F_DsgnInsp.FillObjInsp;
  end;
  RepaintAll;
end;

procedure TF_DsgnForm.SelectNextComp (pSender:TObject;pDirection:word);
var mComp:TComponent; mCompName:string;
begin
  FillCompListByPos (pDirection);
  If oCompLstPos.Count>0 then begin
    mCompName := oCompLstPos.Strings[0];
    mCompName := Copy (mCompName, Pos (' ',mCompName)+1,Length (mCompName));
    mComp := oForm.FindComponent(mCompName);
    ClearAllSelect (TRUE);
    SelectComp(mComp);
  end;
  RepaintAll;
end;

procedure TF_DsgnForm.RepaintAll;
var I:longint;
begin
  If oForm<>nil then begin
    If oForm.ComponentCount>0 then begin
      For I:=0 to oForm.ComponentCount-1 do begin
        If (oForm.Components[I] is TxpUniComp) then (oForm.Components[I] as TxpUniComp).Repaint;
        If (oForm.Components[I] is TxpSinglePanel) then (oForm.Components[I] as TxpSinglePanel).Repaint;
        If (oForm.Components[I] is TxpGroupBox) then (oForm.Components[I] as TxpGroupBox).Repaint;
        If (oForm.Components[I] is TxpPageControl) then begin
          If (oForm.Components[I] as TxpPageControl).Visible then begin
            (oForm.Components[I] as TxpPageControl).Visible := FALSE;
            (oForm.Components[I] as TxpPageControl).Visible := TRUE;
          end;
        end;
        If (oForm.Components[I] is TxpTabSheet) then (oForm.Components[I] as TxpTabSheet).Repaint;
      end;
    end;
  end;
end;

procedure TF_DsgnForm.FillCompListByPos (pDirection:word);
var I:longint; mSelected:boolean; mSelComp:TControl; mOK:boolean; mName:string;
    mWidth,mHeight,mLeft,mRight,mTop,mBottom,mDelta,mCenterX,mCenterY,mActCenterX,mActCenterY:longint;
    mDeltaW,mDeltaH,mNearSide:longint;
begin
  oCompLstPos.Clear;
  oCompLstPos.Sorted := FALSE;
  mSelComp := nil;
  For I:=0 to oForm.ComponentCount-1 do begin
    mSelected := CompIsSelected(oForm.Components[I]);
    If mSelected then begin
      mSelComp := oForm.Components[I] as TControl;
      mLeft := mSelComp.Left;
      mRight := mSelComp.Left+mSelComp.Width;
      mTop := mSelComp.Top;
      mBottom := mSelComp.Top+mSelComp.Height;
      mCenterX := mSelComp.Width div 2;
      mCenterY := mSelComp.Height div 2;
    end;
  end;
  If mSelComp<>nil then begin
    For I:=0 to oForm.ComponentCount-1 do begin
      If (oForm.Components[I] as TWinControl).Visible then begin
        mSelected := CompIsSelected(oForm.Components[I]);
        If not mSelected then begin
          If mSelComp.Name<>oForm.Components[I].Name then begin
            If mSelComp.Parent=(oForm.Components[I] as TControl).Parent then begin
              mOK := FALSE;
              If (oForm.Components[I] is TxpUniComp)
                then mName := (oForm.Components[I] as TxpUniComp).Caption
                else mName := (oForm.Components[I] as TControl).Name;
              mActCenterX := (oForm.Components[I] as TControl).Width div 2;
              mActCenterY := (oForm.Components[I] as TControl).Height div 2;
              case pDirection of
                VK_UP   : begin
                            mOK := (mTop+mCenterY>(oForm.Components[I] as TControl).Top+(oForm.Components[I] as TControl).Height);
                            mDeltaW := Abs ((oForm.Components[I] as TControl).Left+mActCenterX-mLeft-mCenterX);
                            mDeltaH := Abs ((oForm.Components[I] as TControl).Top+mActCenterY-mTop-mCenterY);
                            mNearSide := ((oForm.Components[I] as TControl).Top+(oForm.Components[I] as TControl).Height);
                            mDelta := mDeltaW*mDeltaH+Sqr (mTop-mNearSide);
                          end;
                VK_DOWN : begin
                            mOK := (mTop+mCenterY<(oForm.Components[I] as TControl).Top);
                            mDeltaW := Abs ((oForm.Components[I] as TControl).Left+mActCenterX-mLeft-mCenterX);
                            mDeltaH := Abs ((oForm.Components[I] as TControl).Top+mActCenterY-mTop-mCenterY);
                            mNearSide := (oForm.Components[I] as TControl).Top;
                            mDelta := mDeltaW*mDeltaH+Sqr (mNearSide-mBottom);
                          end;
                VK_LEFT : begin
                            mOK := (mLeft+mCenterX>(oForm.Components[I] as TControl).Left+(oForm.Components[I] as TControl).Width);
                            mDeltaW := Abs ((oForm.Components[I] as TControl).Left+mActCenterX-mLeft-mCenterX);
                            mDeltaH := Abs ((oForm.Components[I] as TControl).Top+mActCenterY-mTop-mCenterY);
                            mNearSide := (oForm.Components[I] as TControl).Left+(oForm.Components[I] as TControl).Width;
                            mDelta := mDeltaW*mDeltaH+Sqr (mLeft-mNearSide);
                          end;
                VK_RIGHT: begin
                            mOK := (mLeft+mCenterX<(oForm.Components[I] as TControl).Left);
                            mDeltaW := Abs ((oForm.Components[I] as TControl).Left+mActCenterX-mLeft-mCenterX);
                            mDeltaH := Abs ((oForm.Components[I] as TControl).Top+mActCenterY-mTop-mCenterY);
                            mNearSide := (oForm.Components[I] as TControl).Left;
                            mDelta := mDeltaW*mDeltaH+Sqr (mNearSide-mRight);
                          end;
              end;
              If mOK then oCompLstPos.Add(StrIntZero (mDelta,9)+' '+oForm.Components[I].Name);
            end;
          end;
        end;
      end;
    end;
  end;
  oCompLstPos.Sorted := TRUE;
end;

procedure TF_DsgnForm.SetCompSelected (pComp:TComponent;pSelected:boolean);
begin
  If pComp is TxpUniComp then (pComp as TxpUniComp).Selected := pSelected;
  If pComp is TxpSinglePanel then (pComp as TxpSinglePanel).Selected := pSelected;
  If pComp is TxpGroupBox then (pComp as TxpGroupBox).Selected := pSelected;
  If pComp is TxpPageControl then (pComp as TxpPageControl).Selected := pSelected;
  If pComp is TxpTabSheet then (pComp as TxpTabSheet).Selected := pSelected;
  (pComp as TWinControl).Repaint;
  oSelCnt := 1;
  cUniMultiSelect := FALSE;
  oFirstSelComp := pComp.Name;
  F_DsgnInsp.SetSelectedComp(pComp.Name);
  F_DsgnInsp.FillObjInsp;
end;

function  TF_DsgnForm.CompIsVisibled (pComp:TComponent):boolean;
begin
  Result := FALSE;
  If pComp is TxpUniComp then Result := (pComp as TxpUniComp).Visible;
  If pComp is TxpSinglePanel then Result := (pComp as TxpSinglePanel).Visible;
  If pComp is TxpGroupBox then Result := (pComp as TxpGroupBox).Visible;
  If pComp is TxpPageControl then Result := (pComp as TxpPageControl).Visible;
  If pComp is TxpTabSheet then Result := (pComp as TxpTabSheet).TabVisible;
end;

procedure TF_DsgnForm.SetShowComp (pComp:TComponent);
var mFind:boolean; mParent:TComponent;
begin
  mFind := FALSE;
  If (pComp is TxpSinglePanel) then begin
    (pComp as TxpSinglePanel).Visible := TRUE;
    mParent := (pComp as TxpSinglePanel).Parent;
    mFind := TRUE;
  end;
  If not mFind and (pComp is TxpGroupBox) then begin
    (pComp as TxpGroupBox).Visible := TRUE;
    mParent := (pComp as TxpGroupBox).Parent;
    mFind := TRUE;
  end;
  If not mFind and (pComp is TxpPageControl) then begin
    (pComp as TxpPageControl).Visible := TRUE;
    mParent := (pComp as TxpPageControl).Parent;
    mFind := TRUE;
  end;
  If not mFind and (pComp is TxpTabSheet) then begin
    (pComp as TxpTabSheet).TabVisible := TRUE;
    mParent := (pComp as TxpTabSheet).Parent;
    mFind := TRUE;
  end;
  If not mFind and (pComp is TxpUniComp) then begin
    (pComp as TxpUniComp).Visible := TRUE;
    mParent := (pComp as TxpUniComp).Parent;
  end;
  If mParent.Name<>oForm.Name then begin
    If not CompIsVisibled(mParent) then SetShowComp (mParent);
  end;
  RecalcTabOrder((pComp as TWinControl).Parent.Name,pComp.Name,99999);
end;

procedure TF_DsgnForm.SetHideComp (pParent:string);
var I:longint; mComp:TControl; mFind:boolean;
begin
  For I:=0 to oForm.ComponentCount-1 do begin
    mComp := oForm.Components[I] as TControl;
    If mComp.Parent.Name=pParent then begin
      If CompIsVisibled(mComp) then begin
        mFind := FALSE;
        If (mComp is TxpSinglePanel) then begin
          (mComp as TxpSinglePanel).Visible := FALSE;
          mFind := TRUE;
        end;
        If not mFind and (mComp is TxpGroupBox) then begin
          (mComp as TxpGroupBox).Visible := FALSE;
          mFind := TRUE;
        end;
        If not mFind and (mComp is TxpPageControl) then begin
          (mComp as TxpPageControl).Visible := FALSE;
          mFind := TRUE;
        end;
        If not mFind and (mComp is TxpTabSheet) then begin
          (mComp as TxpTabSheet).TabVisible := FALSE;
          mFind := TRUE;
        end;
        If not mFind and (mComp is TxpUniComp) then (mComp as TxpUniComp).Visible := FALSE;
      end;
      If mFind then SetHideComp (mComp.Name);
    end;
  end;
//  ClearAllSelect (FALSE);
end;

function  TF_DsgnForm.GetDefParent (pParam:string):string;
var mFind:boolean; mCom,mVal:string;
begin
  Result := '-'; mFind := FALSE;
  Repeat
    CutNextParam(pParam,mCom,mVal);
    If mCom='Parent' then begin
      Result := mVal;
      mFind := TRUE;
    end;
  until mFind or (pParam='');
end;

function  TF_DsgnForm.GetDefProp(pComp:string;pIni:TEncodeIniFile):string;
var mS:string; mProp:string;
begin
  Result := ';';
  mS := pIni.ReadString('255',pComp,'');
  Repeat
    If Pos (zETX,mS)>0 then begin
      mProp := Copy (mS,1,Pos (zETX,mS)-1);
      Delete (mS,1,Pos (zETX,mS));
    end else begin
      mProp := mS;
      mS := '';
    end;
    Result := Result+Copy (mProp,1,Pos (zTAB,mProp)-1)+';';
  until mS='';
end;

procedure TF_DsgnForm.HideSelComps;
var I:longint; mComp:TComponent; mFind:boolean;
begin
  For I:=0 to oForm.ComponentCount-1 do begin
     mComp := oForm.Components[I];
     mFind := FALSE;
     If CompIsSelected(mComp) then begin
       If (mComp is TxpSinglePanel) then begin
         (mComp as TxpSinglePanel).Visible := FALSE;
         mFind := TRUE;
       end;
       If not mFind and (mComp is TxpGroupBox) then begin
         (mComp as TxpGroupBox).Visible := FALSE;
         mFind := TRUE;
       end;
       If not mFind and (mComp is TxpPageControl) then begin
         (mComp as TxpPageControl).Visible := FALSE;
         mFind := TRUE;
       end;
       If not mFind and (mComp is TxpTabSheet) then begin
         (mComp as TxpTabSheet).TabVisible := FALSE;
         mFind := TRUE;
       end;
       If not mFind and (mComp is TxpUniComp) then begin
         (mComp as TxpUniComp).Visible := FALSE;
         mFind := TRUE;
       end;
       If mFind then begin
         SetHideComp(mComp.Name);
         RecalcTabOrder((mComp as TWinControl).Parent.Name ,'',-1);
       end;
     end;
  end;
  ClearAllSelect (FALSE);
  FillHideCompList;
end;

procedure TF_DsgnForm.ClearAllSelect (pOnlyComp:boolean);
var I:longint;
begin
  If oForm.ComponentCount>0 then begin
    For I:=0 to oForm.ComponentCount-1 do begin
      If (oForm.Components[I] is TxpUniComp) then (oForm.Components[I] as TxpUniComp).Selected := FALSE;
      If (oForm.Components[I] is TxpSinglePanel) then (oForm.Components[I] as TxpSinglePanel).Selected := FALSE;
      If (oForm.Components[I] is TxpGroupBox) then (oForm.Components[I] as TxpGroupBox).Selected := FALSE;
      If (oForm.Components[I] is TxpPageControl) then (oForm.Components[I] as TxpPageControl).Selected := FALSE;
      If (oForm.Components[I] is TxpTabSheet) then (oForm.Components[I] as TxpTabSheet).Selected := FALSE;
      (oForm.Components[I] as TWincontrol).Repaint;
    end;
  end;
  If not pOnlyComp then begin
    oFirstSelComp := oForm.Name;
    oSelCnt := 0;
    cUniMultiSelect := FALSE;
    F_DsgnInsp.SetSelectedComp(oForm.Name);
    F_DsgnInsp.FillObjInsp;
  end;
end;

procedure TF_DsgnForm.LoadFormComp (pSect:TStrings);
var I:longint; mS,mName,mParam,mType,mCom:string; mFind:boolean;
begin
  If pSect.Count>0 then begin
    For I:=0 to pSect.Count-1 do begin
      mParam := pSect.Strings[I];
      mName := Copy (mParam,1,Pos ('=',mParam)-1);
      Delete (mParam,1,Pos ('=',mParam));
      If (mName<>'') and (mParam<>'') then begin
        mS := mParam;
        CutNextParam(mS,mCom,mType);
        mFind := FALSE;
        If (mType='Form') then mFind := CrtForm (mName,mParam);
        If mType='xpSinglePanel' then mFind := CrtxpSinglePanel (mName,mParam,'');
        If mType='xpGroupBox' then mFind := CrtxpGroupBox (mName,mParam,'');
        If mType='xpPageControl' then mFind := CrtxpPageControl (mName,mParam,'');
        If mType='xpTabSheet' then mFind := CrtxpTabSheet (mName,mParam,'');
        If mType='xpBitBtn' then mFind := CrtxpButton (mName,mParam,'');
        If mType='xpLabel' then mFind := CrtxpLabel (mName,mParam,'');
        If mType='xpEdit' then mFind := CrtxpEdit (mName,mParam,'');
        If mType='xpCheckBox' then mFind := CrtxpCheckBox (mName,mParam,'');
        If mType='xpComboBox' then mFind := CrtxpComboBox (mName,mParam,'');
        If mType='xpRadioButton' then mFind := CrtxpRadioButton (mName,mParam,'');
        If mType='xpMemo' then mFind := CrtxpMemo (mName,mParam,'');
        If mType='xpRichEdit' then mFind := CrtxpRichEdit (mName,mParam,'');
        If mType='xpStatusLine' then mFind := CrtxpStatusLine (mName,mParam,'');
        If not mFind then mFind := CrtBasic(mName,mParam,'');
      end;
    end;
  end;
end;

procedure TF_DsgnForm.ClearDefCompList;
begin
  oDefCompList.Clear;
end;

procedure TF_DsgnForm.AddDefCompList (pName,pCompFlds:string);
begin
  If oReadedForm=255 then oDefCompList.Add(pName+'='+pCompFlds);
end;

function  TF_DsgnForm.GetTabOrder (pComp:TComponent):longint;
begin
  Result := 99999;
  If pComp is TxpSinglePanel then Result := (pComp as TxpSinglePanel).TabOrderExt;
  If pComp is TxpGroupBox then Result := (pComp as TxpGroupBox).TabOrderExt;
  If pComp is TxpPageControl then Result := (pComp as TxpPageControl).TabOrderExt;
  If pComp is TxpUniComp then begin
     If (pComp as TxpUniComp).CompType in [ucButton,ucEditor,ucCheckBox,ucComboBox,ucRadioButton,ucMemo,ucRichEdit]
       then Result := (pComp as TxpUniComp).TabOrderExt;
  end;
end;

procedure TF_DsgnForm.SetTabOrder (pComp:TComponent;pVal:longint);
begin
  If pComp is TxpSinglePanel then (pComp as TxpSinglePanel).TabOrderExt := pVal;
  If pComp is TxpGroupBox then (pComp as TxpGroupBox).TabOrderExt := pVal;
  If pComp is TxpPageControl then (pComp as TxpPageControl).TabOrderExt := pVal;
  If pComp is TxpUniComp then begin
     If (pComp as TxpUniComp).CompType in [ucButton,ucEditor,ucCheckBox,ucComboBox,ucRadioButton,ucMemo,ucRichEdit]
       then (pComp as TxpUniComp).TabOrderExt := pVal;
  end;
end;

function  TF_DsgnForm.IsTabOrder (pComp:TComponent):boolean;
begin
  Result := FALSE;
  If pComp is TxpSinglePanel then Result := TRUE;
  If pComp is TxpGroupBox then Result := TRUE;
  If pComp is TxpPageControl then Result := TRUE;
  If pComp is TxpUniComp then begin
     If (pComp as TxpUniComp).CompType in [ucButton,ucEditor,ucCheckBox,ucComboBox,ucRadioButton,ucMemo,ucRichEdit]
       then Result := TRUE;
  end;
end;

procedure TF_DsgnForm.TabPressed (Sender:TObject;pShift:TShiftState);
var mComp:TWinControl; mTab,I,mIndex:longint;mCompName,mParent:string; mTabList:TStringList;
begin
  If oSelCnt=1 then begin
    mComp := nil;
    For I:=0 to oForm.ComponentCount-1 do begin
      If CompIsSelected(oForm.Components[I]) then begin
        mComp := oForm.Components[I] as TWinControl;
        Break;
      end;
    end;
    If mComp<>nil then begin
      If IsTabOrder(mComp) then begin
        mCompName := mComp.Name;
        mParent := mComp.Parent.Name;
        mTab := GetTabOrder(mComp);
        mTabList := TStringList.Create;
        For I:=0 to oForm.ComponentCount-1 do begin
          If mParent=(oForm.Components[I] as TWinControl).Parent.Name then begin
            If CompIsVisibled(oForm.Components[I]) then begin
              If CompIsTabStop (oForm.Components[I]) then begin
                If IsTabOrder(oForm.Components[I]) then begin
                  mTabList.Add(StrIntZero (GetTabOrder(oForm.Components[I]),5)+' '+oForm.Components[I].Name);
                end;
              end;
            end;
          end;
        end;
        mTabList.Sort;
        mIndex := -1;
        mComp := nil;
        If mTabList.Count>0 then begin
          For I:=0 to mTabList.Count-1 do begin
            If Copy (mTabList.Strings[I],Pos (' ',mTabList.Strings[I])+1,Length (mTabList.Strings[I]))=mCompName then begin
              mIndex := I;
              Break;
            end;
          end;
          If ssShift in pShift then begin
            Dec (mIndex);
            If mIndex<0 then mIndex := mTabList.Count-1;
          end else begin
            Inc (mIndex);
            If mIndex>mTabList.Count-1 then mIndex := 0;
          end;
          mCompName := Copy (mTabList.Strings[mIndex],Pos (' ',mTabList.Strings[mIndex])+1,Length (mTabList.Strings[mIndex]));
          mComp := oForm.FindComponent (mCompName) as TWinControl;
          ClearAllSelect(TRUE);
          If mComp<>nil then SelectComp(mComp);
        end;
        FreeAndNil (mTabList);
      end;
    end;
  end;
end;

function  TF_DsgnForm.CompIsTabStop (pComp:TComponent):boolean;
begin
  Result := FALSE;
  If pComp is TxpSinglePanel then Result := (pComp as TxpSinglePanel).TabStopExt;
  If pComp is TxpGroupBox then Result := (pComp as TxpGroupBox).TabStopExt;
  If pComp is TxpPageControl then Result := (pComp as TxpPageControl).TabStopExt;
  If pComp is TxpUniComp then begin
     If (pComp as TxpUniComp).CompType in [ucButton,ucEditor,ucCheckBox,ucComboBox,ucRadioButton,ucMemo,ucRichEdit]
       then Result := (pComp as TxpUniComp).TabStopExt;
  end;
end;

procedure TF_DsgnForm.SetCompSelectByName (pComp:string);
var mComp:TComponent;
begin
  ClearAllSelect (TRUE);
  If pComp=oForm.Name
    then mComp := oForm
    else mComp :=  oForm.FindComponent(pComp);
  If mComp<>nil then SetCompSelected (mComp,TRUE);
end;

procedure TF_DsgnForm.OpenFormComp;
var mComp:TComponent; mS:string; mIni:TEncodeIniFile; mSect:TStrings;
begin
  If oForm<>nil then begin
    oForm.Close; FreeAndNil (oForm);
  end;
//Naèítanie základních nastavení
  mSect := TStringList.Create;
  oReadedForm := 255;
  ClearDefCompList;
  mIni := TEncodeIniFile.Create(GetFormDefFileName(oFileName,oReadedForm),FALSE);
  mIni.ReadSectionValues(StrInt (oReadedForm,0),mSect);
  FreeAndNil (mIni);
  LoadFormComp (mSect);
//Naèítanie vybraného formulára
  mSect.Clear;
  mIni := TEncodeIniFile.Create(GetFormDefFileName(oFileName,oFormNum),FALSE);
  oReadedForm := oFormNum;
  mS := mIni.ReadString('List',StrInt (oReadedForm,0),'');
  oFormName := LineElement (mS, 0, ';');
  oLevel := ValInt (LineElement (mS, 1, ';'));
  mIni.ReadSectionValues(StrInt (oReadedForm,0),mSect);
  FreeAndNil (mIni);
  LoadFormComp (mSect);
  FreeAndNil (mSect);
  FillHideCompList;
end;

procedure TF_DsgnForm.FillHideCompList;
var I:longint; mAdd:boolean;
begin
  CB_HideCompList.Clear;
  F_DsgnInsp.CB_CompList.Clear;
  If oForm<>nil then begin
    F_DsgnInsp.CB_CompList.Items.Add(oForm.Name);
    For I:=0 to oForm.ComponentCount-1 do begin
      If not CompIsVisibled(oForm.Components[I]) then begin
        mAdd := TRUE;
        If oHideCompFilt>0 then begin
          mAdd := FALSE;
          If oForm.Components[I] is TxpUniComp then begin
           If oHideCompFilt=1 then mAdd := (oForm.Components[I] as TxpUniComp).CompType=ucLabel;
           If oHideCompFilt=2 then mAdd := (oForm.Components[I] as TxpUniComp).CompType=ucEditor;
           If oHideCompFilt=3 then mAdd := (oForm.Components[I] as TxpUniComp).CompType=ucButton;
           If oHideCompFilt=4 then mAdd := (oForm.Components[I] as TxpUniComp).CompType=ucRadioButton;
           If oHideCompFilt=5 then mAdd := (oForm.Components[I] as TxpUniComp).CompType=ucCheckBox;
           If oHideCompFilt=6 then mAdd := (oForm.Components[I] as TxpUniComp).CompType=ucComboBox;
           If oHideCompFilt=7 then mAdd := (oForm.Components[I] as TxpUniComp).CompType=ucMemo;
           If oHideCompFilt=8 then mAdd := (oForm.Components[I] as TxpUniComp).CompType=ucRichEdit;
           If oHideCompFilt=9 then mAdd := (oForm.Components[I] as TxpUniComp).CompType=ucBasic;
          end;
          If oForm.Components[I] is TxpSinglePanel then mAdd := (oHideCompFilt=21);
          If oForm.Components[I] is TxpGroupBox then mAdd := (oHideCompFilt=22);
          If oForm.Components[I] is TxpPageControl then mAdd := (oHideCompFilt=23);
          If oForm.Components[I] is TxpTabSheet then mAdd := (oHideCompFilt=23);
        end;
        If mAdd then mAdd := not (oForm.Components[I] is TxpStatusLine);
        If mAdd then CB_HideCompList.Items.Add (oForm.Components[I].Name+' ');
      end else begin
        F_DsgnInsp.CB_CompList.Items.Add(oForm.Components[I].Name);
      end;
    end;
  end;
  If CB_HideCompList.Items.Count>0 then CB_HideCompList.ItemIndex := 0;
  ClearAllSelect (FALSE);
end;

function  TF_DsgnForm.ParentVerify (pParent:string):boolean;
var mFirstParent:string;
begin
  mFirstParent := '';
  If oForm.FindComponent(oFirstSelComp)<>nil then mFirstParent := (oForm.FindComponent(oFirstSelComp) as TWinControl).Parent.Name;
  Result := (mFirstParent='') or (pParent=mFirstParent);
end;

function  TF_DsgnForm.CompIsSelected (pComp:TComponent):boolean;
begin
  Result := FALSE;
  If pComp is TxpUniComp then Result := (pComp as TxpUniComp).Selected;
  If pComp is TxpSinglePanel then Result := (pComp as TxpSinglePanel).Selected;
  If pComp is TxpGroupBox then Result := (pComp as TxpGroupBox).Selected;
  If pComp is TxpPageControl then Result := (pComp as TxpPageControl).Selected;
  If pComp is TxpTabSheet then Result := (pComp as TxpTabSheet).Selected;
end;

procedure TF_DsgnForm.RecalcTabOrder (pParent,pCompName:string;pVal:longint);
var mSList:TStringList; I:longint;mS:string;mComp:TComponent;
begin
  mSList := TStringList.Create;
  For I:=0 to oForm.ComponentCount-1 do begin
    If (oForm.Components[I] as TWinControl).Parent.Name=pParent then begin
      If CompIsVisibled(oForm.Components[I]) and IsTabOrder(oForm.Components[I]) then begin
        mSList.Add(StrIntZero (GetTabOrder(oForm.Components[I]),5)+' '+oForm.Components[I].Name);
      end;
    end;
  end;
  mSList.Sort;
  If pVal<>-1 then begin
    For I:=0 to mSList.Count-1 do begin
      mS := Copy (mSList.Strings[I],Pos (' ',mSList.Strings[I])+1, Length (mSList.Strings[I]));
      If mS=pCompName then begin
        If (pVal<>-1) and (pVal<>I) then begin
          mSList.Delete(I);
          If mSList.Count-1<pVal
            then mSList.Add(StrIntZero (pVal,4)+' '+pCompName)
            else mSList.Insert(pVal, StrIntZero (pVal,4)+' '+pCompName);
        end;
        Break;
      end;
    end;
  end;
  For I:=0 to mSList.Count-1 do begin
    mS := Copy (mSList.Strings[I],Pos (' ',mSList.Strings[I])+1,Length (mSList.Strings[I]));
    mComp := oForm.FindComponent(mS);
    If mComp<>nil then SetTabOrder(mComp,I);
  end;
  FreeAndNil (mSList);
end;

procedure TF_DsgnForm.PasteFormComp;
var mName,mType,mCom,mParam,mS,mDefParent:string; I:longint; mFind:boolean;
    mIni:TEncodeIniFile; mComp:TComponent;
begin
  If uCompSect.Count>0 then begin
    mIni := TEncodeIniFile.Create(GetFormDefFileName(oFileName,oFormNum),FALSE);
    For I:=0 to uCompSect.Count-1 do begin
      mParam := uCompSect.Strings[I];
      mName := Copy (mParam,1,Pos ('=',mParam)-1);
      Delete (mParam,1,Pos ('=',mParam));
      If (mName<>'') and (mParam<>'') then begin
        If mIni.ValueExists('255',mName) then begin
          mDefParent := GetDefParent (mIni.ReadString('255',mName,''));
          mS := mParam;
          CutNextParam(mS,mCom,mType);
          mFind := FALSE;
          If mType='xpSinglePanel' then mFind := CrtxpSinglePanel (mName,mParam,mDefParent);
          If mType='xpGroupBox' then mFind := CrtxpGroupBox (mName,mParam,mDefParent);
          If mType='xpPageControl' then mFind := CrtxpPageControl (mName,mParam,mDefParent);
          If mType='xpTabSheet' then mFind := CrtxpTabSheet (mName,mParam,mDefParent);
          If mType='xpBitBtn' then mFind := CrtxpButton (mName,mParam,mDefParent);
          If mType='xpLabel' then mFind := CrtxpLabel (mName,mParam,mDefParent);
          If mType='xpEdit' then mFind := CrtxpEdit (mName,mParam,mDefParent);
          If mType='xpCheckBox' then mFind := CrtxpCheckBox (mName,mParam,mDefParent);
          If mType='xpComboBox' then mFind := CrtxpComboBox (mName,mParam,mDefParent);
          If mType='xpRadioButton' then mFind := CrtxpRadioButton (mName,mParam,mDefParent);
          If mType='xpMemo' then mFind := CrtxpMemo (mName,mParam,mDefParent);
          If mType='xpRichEdit' then mFind := CrtxpRichEdit (mName,mParam,mDefParent);
          If mType='xpStatusLine' then mFind := CrtxpStatusLine (mName,mParam,mDefParent);
          If not mFind then mFind := CrtBasic(mName,mParam,mDefParent);
          If mFind then begin
            mComp := oForm.FindComponent(mName);
            If mComp<>nil then RecalcTabOrder ((mComp as TWinControl).Parent.Name,mComp.Name,99999);
          end;
        end;
      end;
    end;
    FreeAndNil (mIni);
  end;
  FillHideCompList;
end;

function  TF_DsgnForm.CrtForm (pName,pParam:string):boolean;
begin
  Result := TRUE;
  If oForm=nil then oForm := TMoveForm.Create(Self);
  oForm.Name := pName;
  oCompData.SetCompData(pParam);
  AddDefCompList (pName,oCompData.CompFlds);
  oForm.Left := oCompData.GetLeft (oForm.Left);
  oForm.Top := oCompData.GetTop (oForm.Top);
  oForm.Height := oCompData.GetHeight (oForm.Height);
  oForm.Width := oCompData.GetWidth (oForm.Width);
  oForm.Align := oCompData.GetAlign (oForm.Align);
  oForm.Caption := oCompData.GetCaption (oForm.Caption);
  oForm.Color := oCompData.GetColor (oForm.Color);
  oForm.OnClick := MyCompOnClick;
  oForm.OnMouseDown := MyCompMouseDown;
  oForm.OnResize := MyFormResize;
  oForm.OnMouseUp := MyCompMouseUp;
  oForm.OnKeyDown := MyCompOnKeyDown;
  oForm.OnKeyUp := MyCompOnKeyUp;
end;

function  TF_DsgnForm.CrtxpSinglePanel (pName,pParam,pDefParent:string):boolean;
var mC:TComponent; mComp:TxpSinglePanel; mParent:TWincontrol;
begin
  Result := TRUE;
  oCompData.SetCompData(pParam);
  AddDefCompList (pName,oCompData.CompFlds);
  mParent := GetParentObj(oForm,oCompData.GetParent);
  If mParent<>nil then begin
    mC := oForm.FindComponent (pName); mComp := nil;
    If mC is TxpSinglePanel then mComp := mC as TxpSinglePanel;
    If mComp=nil then begin
      mComp := TxpSinglePanel.Create(oForm);
      mComp.Name := pName;
    end;
    mComp.OnClick := MyCompOnClick;
    mComp.OnKeyDown := MyCompOnKeyDown;
    mComp.OnKeyUp := MyCompOnKeyUp;
    mComp.OnMouseMove := MyCompMouseMove;
    mComp.OnMouseDown := MyCompMouseDown;
    mComp.OnMouseUp := MyCompMouseUp;
    mComp.OnEnter := MyCompOnEnter;
    mComp.Parent := mParent;
    mComp.Left := oCompData.GetLeft (mComp.Left);
    mComp.Top := oCompData.GetTop(mComp.Top);
    mComp.Height := oCompData.GetHeight(mComp.Height);
    mComp.Width := oCompData.GetWidth(mComp.Width);
    mComp.Visible := oCompData.GetVisible(mComp.Visible);
    mComp.EnabledExt := oCompData.GetEnabled(mComp.EnabledExt);
    mComp.Align := oCompData.GetAlign(mComp.Align);
    mComp.Anchors := oCompData.GetAnchors(mComp.Anchors);
    mComp.Head := oCompData.GetHead(mComp.Head);
    mComp.HintExt := oCompData.GetHint(mComp.HintExt);
    mComp.ShowHintExt := oCompData.GetShowHint(mComp.ShowHintExt);
    mComp.TabOrderExt := oCompData.GetTabOrder(mComp.TabOrderExt);
    mComp.TabStopExt := oCompData.GetTabStop(mComp.TabStopExt);
    mComp.SystemColor := oCompData.GetSystemColor(mComp.SystemColor);
    mComp.BasicColor := oCompData.GetBasicColor(mComp.BasicColor);
    mComp.Color := oCompData.GetColor(mComp.Color);
    mComp.BorderColor := oCompData.GetBorderColor(mComp.BorderColor);
    ConvHEXToBitmap (oCompData.GetBGImage(ConvBitmapToHEX(mComp.BGImage)),mComp.BGImage);
    mComp.BGStyle := oCompData.GetBGStyle(mComp.BGStyle);
    mComp.GradStartColor := oCompData.GetGradStartColor (mComp.GradStartColor);
    mComp.GradEndColor := oCompData.GetGradEndColor (mComp.GradEndColor);
    mComp.GradFillDir := oCompData.GetGradFillDir (mComp.GradFillDir);
    mComp.Font.Color := oCompData.GetFontColor(mComp.Font.Color);
    mComp.Font.Name := oCompData.GetFontName(mComp.Font.Name);
    mComp.Font.Size := oCompData.GetFontSize(mComp.Font.Size);
    mComp.Font.Style := oCompData.GetFontStyle(mComp.Font.Style);
    mComp.Font.Charset := oCompData.GetFontCharset(mComp.Font.Charset);
    mComp.ShowHint := TRUE;
    mComp.Hint := mComp.Name;
    If mComp.Head<>'' then mComp.Hint := mComp.Hint+#13+mComp.Head;
  end;
end;

function  TF_DsgnForm.CrtxpGroupBox (pName,pParam,pDefParent:string):boolean;
var mC:TComponent; mComp:TxpGroupBox; mParent:TWinControl;
begin
  Result := TRUE;
  oCompData.SetCompData(pParam);
  AddDefCompList (pName,oCompData.CompFlds);
  mParent := GetParentObj(oForm,oCompData.GetParent);
  If mParent<>nil then begin
    mC := oForm.FindComponent (pName); mComp := nil;
    If mC is TxpGroupBox then mComp := mC as TxpGroupBox;
    If mComp=nil then begin
      mComp := TxpGroupBox.Create(oForm);
      mComp.Name := pName;
    end;
    mComp.OnClick := MyCompOnClick;
    mComp.OnKeyDown := MyCompOnKeyDown;
    mComp.OnKeyUp := MyCompOnKeyUp;
    mComp.OnMouseMove := MyCompMouseMove;
    mComp.OnMouseDown := MyCompMouseDown;
    mComp.OnMouseUp := MyCompMouseUp;
    mComp.OnEnter := MyCompOnEnter;
    mComp.Parent := mParent;
    mComp.Left := oCompData.GetLeft(mComp.Left);
    mComp.Top := oCompData.GetTop(mComp.Top);
    mComp.Height := oCompData.GetHeight(mComp.Height);
    mComp.Width := oCompData.GetWidth(mComp.Width);
    mComp.Visible := oCompData.GetVisible(mComp.Visible);
    mComp.EnabledExt := oCompData.GetEnabled(mComp.EnabledExt);
    mComp.Align := oCompData.GetAlign(mComp.Align);
    mComp.Anchors := oCompData.GetAnchors(mComp.Anchors);
    mComp.Caption := oCompData.GetCaption(mComp.Caption);
    mComp.HintExt := oCompData.GetHint(mComp.HintExt);
    mComp.ShowHintExt := oCompData.GetShowHint(mComp.ShowHintExt);
    mComp.TabOrderExt := oCompData.GetTabOrder(mComp.TabOrderExt);
    mComp.TabStopExt := oCompData.GetTabStop(mComp.TabStopExt);
    mComp.SystemColor := oCompData.GetSystemColor(mComp.SystemColor);
    mComp.BasicColor := oCompData.GetBasicColor(mComp.BasicColor);
    mComp.Color := oCompData.GetColor(mComp.Color);
    mComp.BorderColor := oCompData.GetBorderColor(mComp.BorderColor);
    mComp.Font.Color := oCompData.GetFontColor(mComp.Font.Color);
    mComp.Font.Name := oCompData.GetFontName(mComp.Font.Name);
    mComp.Font.Size := oCompData.GetFontSize(mComp.Font.Size);
    mComp.Font.Style := oCompData.GetFontStyle(mComp.Font.Style);
    mComp.Font.Charset := oCompData.GetFontCharset(mComp.Font.Charset);
    mComp.ShowHint := TRUE;
    mComp.Hint := mComp.Name+#13+mComp.Caption;
  end;
end;

function  TF_DsgnForm.CrtxpPageControl (pName,pParam,pDefParent:string):boolean;
var mC:TComponent; mComp:TxpPageControl; mParent:TWinControl;
begin
  Result := TRUE;
  oCompData.SetCompData(pParam);
  AddDefCompList (pName,oCompData.CompFlds);
  mParent := GetParentObj(oForm,oCompData.GetParent);
  If mParent<>nil then begin
    mC := oForm.FindComponent (pName); mComp := nil;
    If mC is TxpPageControl then mComp := mC as TxpPageControl;
    If mComp=nil then begin
      mComp := TxpPageControl.Create(oForm);
      mComp.Name := pName;
    end;
    mComp.OnClick := MyCompOnClick;
    mComp.OnChange := MyCompOnClick;
    mComp.OnKeyDown := MyCompOnKeyDown;
    mComp.OnKeyUp := MyCompOnKeyUp;
    mComp.OnMouseMove := MyCompMouseMove;
    mComp.OnMouseDown := MyCompMouseDown;
    mComp.OnMouseUp := MyCompMouseUp;
    mComp.OnEnter := MyCompOnEnter;
    mComp.Parent := mParent;
    mComp.Left := oCompData.GetLeft(mComp.Left);
    mComp.Top := oCompData.GetTop(mComp.Top);
    mComp.Height := oCompData.GetHeight(mComp.Height);
    mComp.Width := oCompData.GetWidth(mComp.Width);
    mComp.Visible := oCompData.GetVisible(mComp.Visible);
    mComp.EnabledExt := oCompData.GetEnabled(mComp.EnabledExt);
    mComp.Align := oCompData.GetAlign(mComp.Align);
    mComp.Anchors := oCompData.GetAnchors(mComp.Anchors);
    mComp.HintExt := oCompData.GetHint(mComp.HintExt);
    mComp.ShowHintExt := oCompData.GetShowHint(mComp.ShowHintExt);
    mComp.TabOrderExt := oCompData.GetTabOrder(mComp.TabOrderExt);
    mComp.TabStopExt := oCompData.GetTabStop(mComp.TabStopExt);
    mComp.TabsShow := oCompData.GetTabsShow(mComp.TabsShow);
    mComp.TabHeight := oCompData.GetTabHeight(mComp.TabHeight);
    mComp.MultiLine := oCompData.GetMultiLine(mComp.MultiLine);
    mComp.SystemColor := oCompData.GetSystemColor(mComp.SystemColor);
    mComp.BasicColor := oCompData.GetBasicColor(mComp.BasicColor);
    mComp.Color := oCompData.GetColor(mComp.Color);
    mComp.BorderColor := oCompData.GetBorderColor(mComp.BorderColor);
    mComp.Font.Color := oCompData.GetFontColor(mComp.Font.Color);
    mComp.Font.Name := oCompData.GetFontName(mComp.Font.Name);
    mComp.Font.Size := oCompData.GetFontSize(mComp.Font.Size);
    mComp.Font.Style := oCompData.GetFontStyle(mComp.Font.Style);
    mComp.Font.Charset := oCompData.GetFontCharset(mComp.Font.Charset);
    mComp.ShowHint := TRUE;
    mComp.Hint := mComp.Name;
  end;
end;

function  TF_DsgnForm.CrtxpTabSheet (pName,pParam,pDefParent:string):boolean;
var mC:TComponent; mComp:TxpTabSheet; mParent:TWinControl;
begin
  Result := TRUE;
  oCompData.SetCompData(pParam);
  AddDefCompList (pName,oCompData.CompFlds);
  mParent := GetParentObj(oForm,oCompData.GetParent);
  If mParent<>nil then begin
    mC := oForm.FindComponent (pName); mComp := nil;
    If mC is TxpTabSheet then mComp := mC as TxpTabSheet;
    If mComp=nil then begin
      mComp := TxpTabSheet.Create(oForm);
      mComp.Name := pName;
    end;
    mComp.OnClick := MyCompOnClick;
    mComp.OnKeyDown := MyCompOnKeyDown;
    mComp.OnKeyUp := MyCompOnKeyUp;
    mComp.OnMouseMove := MyCompMouseMove;
    mComp.OnMouseDown := MyCompMouseDown;
    mComp.OnMouseUp := MyCompMouseUp;
    mComp.OnEnter := MyCompOnEnter;
    mComp.Parent := mParent;
    mComp.PageControl := mComp.Parent as TPageControl;
    mComp.Left := oCompData.GetLeft(mComp.Left);
    mComp.Top := oCompData.GetTop(mComp.Top);
    mComp.Height := oCompData.GetHeight(mComp.Height);
    mComp.Width := oCompData.GetWidth(mComp.Width);
    mComp.TabVisible := oCompData.GetVisible(mComp.TabVisible);
    mComp.EnabledExt := oCompData.GetEnabled(mComp.EnabledExt);
    mComp.Caption := oCompData.GetCaption(mComp.Caption);
    mComp.PageIndex := oCompData.GetPageIndex(mComp.PageIndex);
    mComp.HintExt := oCompData.GetHint(mComp.HintExt);
    mComp.ShowHintExt := oCompData.GetShowHint(mComp.ShowHintExt);
    mComp.SystemColor := oCompData.GetSystemColor(mComp.SystemColor);
    mComp.BasicColor := oCompData.GetBasicColor(mComp.BasicColor);
    mComp.Color := oCompData.GetColor(mComp.Color);
    ConvHEXToBitmap (oCompData.GetBGImage(ConvBitmapToHEX(mComp.BGImage)),mComp.BGImage);
    mComp.BGStyle := oCompData.GetBGStyle (mComp.BGStyle);
    mComp.GradientStartColor := oCompData.GetGradStartColor (mComp.GradientStartColor);
    mComp.GradientEndColor := oCompData.GetGradEndColor (mComp.GradientEndColor);
    mComp.GradientFillDir := oCompData.GetGradFillDir (mComp.GradientFillDir);
    mComp.Font.Color := oCompData.GetFontColor(mComp.Font.Color);
    mComp.Font.Name := oCompData.GetFontName(mComp.Font.Name);
    mComp.Font.Size := oCompData.GetFontSize(mComp.Font.Size);
    mComp.Font.Style := oCompData.GetFontStyle(mComp.Font.Style);
    mComp.Font.Charset := oCompData.GetFontCharset(mComp.Font.Charset);
    If mComp.TabVisible then (mComp.Parent as TxpPageControl).ActivePage := mComp;
    mComp.ShowHint := TRUE;
    mComp.Hint := mComp.Name+#13+mComp.Caption;
  end;
end;

function  TF_DsgnForm.CrtxpButton (pName,pParam,pDefParent:string):boolean;
var mC:TComponent; mComp:TxpUniComp; mParent:TWinControl;
begin
  Result := TRUE;
  oCompData.SetCompData(pParam);
  AddDefCompList (pName,oCompData.CompFlds);
  mParent := GetParentObj(oForm,oCompData.GetParent);
  If mParent<>nil then begin
    mC := oForm.FindComponent (pName); mComp := nil;
    If mC is TxpUniComp then mComp := mC as TxpUniComp;
    If mComp=nil then begin
      mComp := TxpUniComp.Create(oForm);
      mComp.Name := pName;
    end;
    mComp.CompType := ucButton;
    mComp.OnClick := MyCompOnClick;
    mComp.OnKeyDown := MyCompOnKeyDown;
    mComp.OnKeyUp := MyCompOnKeyUp;
    mComp.OnMouseMove := MyCompMouseMove;
    mComp.OnMouseDown := MyCompMouseDown;
    mComp.OnMouseUp := MyCompMouseUp;
    mComp.OnEnter := MyCompOnEnter;
    mComp.Parent := mParent;
    mComp.Left := oCompData.GetLeft(mComp.Left);
    mComp.Top := oCompData.GetTop(mComp.Top);
    mComp.Height := oCompData.GetHeight(mComp.Height);
    mComp.Width := oCompData.GetWidth(mComp.Width);
    mComp.Visible := oCompData.GetVisible(mComp.Visible);
    mComp.EnabledExt := oCompData.GetEnabled(mComp.EnabledExt);
    mComp.Anchors := oCompData.GetAnchors(mComp.Anchors);
    mComp.Caption := oCompData.GetCaption(mComp.Caption);
    mComp.AlignText := oCompData.GetAlignText(mComp.AlignText);
    mComp.HintExt := oCompData.GetHint(mComp.HintExt);
    mComp.ShowHintExt := oCompData.GetShowHint(mComp.ShowHintExt);
    mComp.TabOrderExt := oCompData.GetTabOrder(mComp.TabOrderExt);
    mComp.TabStopExt := oCompData.GetTabStop(mComp.TabStopExt);
    mComp.SystemColor := oCompData.GetSystemColor(mComp.SystemColor);
    mComp.BasicColor := oCompData.GetBasicColor(mComp.BasicColor);
    mComp.ButtLayout := oCompData.GetButtLayout(mComp.ButtLayout);
    ConvHEXToBitmap (oCompData.GetGlyph(ConvBitmapToHEX(mComp.Glyph)),mComp.Glyph);
    mComp.Font.Color := oCompData.GetFontColor(mComp.Font.Color);
    mComp.Font.Name := oCompData.GetFontName(mComp.Font.Name);
    mComp.Font.Size := oCompData.GetFontSize(mComp.Font.Size);
    mComp.Font.Style := oCompData.GetFontStyle(mComp.Font.Style);
    mComp.Font.Charset := oCompData.GetFontCharset(mComp.Font.Charset);
    mComp.ShowHint := TRUE;
    mComp.Hint := mComp.Name+#13+mComp.Caption;
  end;
end;

function  TF_DsgnForm.CrtxpEdit (pName,pParam,pDefParent:string):boolean;
var mC:TComponent; mComp:TxpUniComp; mParent:TWinControl;
begin
  Result := TRUE;
  oCompData.SetCompData(pParam);
  AddDefCompList (pName,oCompData.CompFlds);
  mParent := GetParentObj(oForm,oCompData.GetParent);
  If mParent<>nil then begin
    mC := oForm.FindComponent (pName); mComp := nil;
    If mC is TxpUniComp then mComp := mC as TxpUniComp;
    If mComp=nil then begin
      mComp := TxpUniComp.Create(oForm);
      mComp.Name := pName;
    end;
    mComp.ParentFont := FALSE;
    mComp.CompType := ucEditor;
    mComp.OnClick := MyCompOnClick;
    mComp.OnKeyDown := MyCompOnKeyDown;
    mComp.OnKeyUp := MyCompOnKeyUp;
    mComp.OnMouseMove := MyCompMouseMove;
    mComp.OnMouseDown := MyCompMouseDown;
    mComp.OnMouseUp := MyCompMouseUp;
    mComp.OnEnter := MyCompOnEnter;
    mComp.Parent := mParent;
    mComp.Left := oCompData.GetLeft(mComp.Left);
    mComp.Top := oCompData.GetTop(mComp.Top);
    mComp.Height := oCompData.GetHeight(mComp.Height);
    mComp.Width := oCompData.GetWidth(mComp.Width);
    mComp.Visible := oCompData.GetVisible(mComp.Visible);
    mComp.EnabledExt := oCompData.GetEnabled(mComp.EnabledExt);
    mComp.ReadOnly := oCompData.GetReadOnly(mComp.ReadOnly);
    mComp.Anchors := oCompData.GetAnchors(mComp.Anchors);
    mComp.Align := oCompData.GetAlign(mComp.Align);
    mComp.Alignment := oCompData.GetAlignment(mComp.Alignment);
    mComp.HintExt := oCompData.GetHint(mComp.HintExt);
    mComp.ShowHintExt := oCompData.GetShowHint(mComp.ShowHintExt);
    mComp.TabOrderExt := oCompData.GetTabOrder(mComp.TabOrderExt);
    mComp.TabStopExt := oCompData.GetTabStop(mComp.TabStopExt);
    mComp.MaxLength := oCompData.GetMaxLength(mComp.MaxLength);
    mComp.NumSepar := oCompData.GetNumSepar(mComp.NumSepar);
    mComp.Frac := oCompData.GetFrac(mComp.Frac);
    mComp.EditorType := oCompData.GetEditorType(mComp.EditorType);
    mComp.ExtTextShow := oCompData.GetExtTextShow(mComp.ExtTextShow);
    mComp.SystemColor := oCompData.GetSystemColor(mComp.SystemColor);
    mComp.BasicColor := oCompData.GetBasicColor(mComp.BasicColor);
    mComp.Color := oCompData.GetColor(mComp.Color);
    mComp.InfoField := oCompData.GetInfoField(mComp.InfoField);
    mComp.Font.Color := oCompData.GetFontColor(mComp.Font.Color);
    mComp.Font.Name := oCompData.GetFontName(mComp.Font.Name);
    mComp.Font.Size := oCompData.GetFontSize(mComp.Font.Size);
    mComp.Font.Style := oCompData.GetFontStyle(mComp.Font.Style);
    mComp.Font.Charset := oCompData.GetFontCharset(mComp.Font.Charset);
    mComp.ShowHint := TRUE;
    mComp.Hint := mComp.Name;
  end;
end;

function  TF_DsgnForm.CrtxpLabel (pName,pParam,pDefParent:string):boolean;
var mC:TComponent; mComp:TxpUniComp; mParent:TWinControl;
begin
  Result := TRUE;
  oCompData.SetCompData(pParam);
  AddDefCompList (pName,oCompData.CompFlds);
  mParent := GetParentObj(oForm,oCompData.GetParent);
  If mParent<>nil then begin
    mC := oForm.FindComponent (pName); mComp := nil;
    If mC is TxpUniComp then mComp := mC as TxpUniComp;
    If mComp=nil then begin
      mComp := TxpUniComp.Create(oForm);
      mComp.Name := pName;
    end;
    mComp.CompType := ucLabel;
    mComp.OnClick := MyCompOnClick;
    mComp.OnKeyDown := MyCompOnKeyDown;
    mComp.OnKeyUp := MyCompOnKeyUp;
    mComp.OnMouseMove := MyCompMouseMove;
    mComp.OnMouseDown := MyCompMouseDown;
    mComp.OnMouseUp := MyCompMouseUp;
    mComp.OnEnter := MyCompOnEnter;
    mComp.Parent := mParent;
    mComp.Left := oCompData.GetLeft(mComp.Left);
    mComp.Top := oCompData.GetTop(mComp.Top);
    mComp.Height := oCompData.GetHeight(mComp.Height);
    mComp.Width := oCompData.GetWidth(mComp.Width);
    mComp.Visible := oCompData.GetVisible(mComp.Visible);
    mComp.EnabledExt := oCompData.GetEnabled(mComp.EnabledExt);
    mComp.Align := oCompData.GetAlign(mComp.Align);
    mComp.Alignment := oCompData.GetAlignment(mComp.Alignment);
    mComp.Anchors := oCompData.GetAnchors(mComp.Anchors);
    mComp.AutoSize := oCompData.GetAutoSize(mComp.AutoSize);
    mComp.Layout := oCompData.GetTextLayout(mComp.Layout);
    mComp.HintExt := oCompData.GetHint(mComp.HintExt);
    mComp.ShowHintExt:= oCompData.GetShowHint(mComp.ShowHintExt);
    mComp.Transparent := oCompData.GetTransparent(mComp.Transparent);
    mComp.WordWrap := oCompData.GetWordWrap(mComp.WordWrap);
    mComp.Caption := oCompData.GetCaption(mComp.Caption);
    mComp.SystemColor := oCompData.GetSystemColor(mComp.SystemColor);
    mComp.Color := oCompData.GetColor(mComp.Color);
    mComp.Font.Color := oCompData.GetFontColor(mComp.Font.Color);
    mComp.Font.Name := oCompData.GetFontName(mComp.Font.Name);
    mComp.Font.Size := oCompData.GetFontSize(mComp.Font.Size);
    mComp.Font.Style := oCompData.GetFontStyle(mComp.Font.Style);
    mComp.Font.Charset := oCompData.GetFontCharset(mComp.Font.Charset);
    mComp.ShowHint := TRUE;
    mComp.Hint := mComp.Name+#13+mComp.Caption;
  end;
end;

function  TF_DsgnForm.CrtxpCheckBox (pName,pParam,pDefParent:string):boolean;
var mC:TComponent; mComp:TxpUniComp; mParent:TWinControl;
begin
  Result := TRUE;
  oCompData.SetCompData(pParam);
  AddDefCompList (pName,oCompData.CompFlds);
  mParent := GetParentObj(oForm,oCompData.GetParent);
  If mParent<>nil then begin
    mC := oForm.FindComponent (pName); mComp := nil;
    If mC is TxpUniComp then mComp := mC as TxpUniComp;
    If mComp=nil then begin
      mComp := TxpUniComp.Create(oForm);
      mComp.Name := pName;
    end;
    mComp.CompType := ucCheckBox;
    mComp.OnClick := MyCompOnClick;
    mComp.OnKeyDown := MyCompOnKeyDown;
    mComp.OnKeyUp := MyCompOnKeyUp;
    mComp.OnMouseMove := MyCompMouseMove;
    mComp.OnMouseDown := MyCompMouseDown;
    mComp.OnMouseUp := MyCompMouseUp;
    mComp.OnEnter := MyCompOnEnter;
    mComp.Parent := mParent;
    mComp.Left := oCompData.GetLeft(mComp.Left);
    mComp.Top := oCompData.GetTop(mComp.Top);
    mComp.Height := oCompData.GetHeight(mComp.Height);
    mComp.Width := oCompData.GetWidth(mComp.Width);
    mComp.Visible := oCompData.GetVisible(mComp.Visible);
    mComp.EnabledExt := oCompData.GetEnabled(mComp.EnabledExt);
    mComp.Anchors := oCompData.GetAnchors(mComp.Anchors);
    mComp.Caption := oCompData.GetCaption(mComp.Caption);
    mComp.HintExt := oCompData.GetHint(mComp.HintExt);
    mComp.ShowHintExt := oCompData.GetShowHint(mComp.ShowHintExt);
    mComp.TabOrderExt := oCompData.GetTabOrder(mComp.TabOrderExt);
    mComp.TabStopExt := oCompData.GetTabStop(mComp.TabStopExt);
    mComp.SystemColor := oCompData.GetSystemColor(mComp.SystemColor);
    mComp.BasicColor := oCompData.GetBasicColor(mComp.BasicColor);
    mComp.CheckColor := oCompData.GetCheckColor(mComp.CheckColor);
    mComp.Font.Color := oCompData.GetFontColor(mComp.Font.Color);
    mComp.Font.Name := oCompData.GetFontName(mComp.Font.Name);
    mComp.Font.Size := oCompData.GetFontSize(mComp.Font.Size);
    mComp.Font.Style := oCompData.GetFontStyle(mComp.Font.Style);
    mComp.Font.Charset := oCompData.GetFontCharset(mComp.Font.Charset);
    mComp.ShowHint := TRUE;
    mComp.Hint := mComp.Name+#13+mComp.Caption;
  end;
end;

function  TF_DsgnForm.CrtxpComboBox (pName,pParam,pDefParent:string):boolean;
var mC:TComponent; mComp:TxpUniComp; mParent:TWinControl;
begin
  Result := TRUE;
  oCompData.SetCompData(pParam);
  AddDefCompList (pName,oCompData.CompFlds);
  mParent := GetParentObj(oForm,oCompData.GetParent);
  If mParent<>nil then begin
    mC := oForm.FindComponent (pName); mComp := nil;
    If mC is TxpUniComp then mComp := mC as TxpUniComp;
    If mComp=nil then begin
      mComp := TxpUniComp.Create(oForm);
      mComp.Name := pName;
    end;
    mComp.CompType := ucComboBox;
    mComp.OnClick := MyCompOnClick;
    mComp.OnKeyDown := MyCompOnKeyDown;
    mComp.OnKeyUp := MyCompOnKeyUp;
    mComp.OnMouseMove := MyCompMouseMove;
    mComp.OnMouseDown := MyCompMouseDown;
    mComp.OnMouseUp := MyCompMouseUp;
    mComp.OnEnter := MyCompOnEnter;
    mComp.Parent := mParent;
    mComp.Left := oCompData.GetLeft(mComp.Left);
    mComp.Top := oCompData.GetTop(mComp.Top);
    mComp.Height := oCompData.GetHeight(mComp.Height);
    mComp.Width := oCompData.GetWidth(mComp.Width);
    mComp.Visible := oCompData.GetVisible(mComp.Visible);
    mComp.EnabledExt := oCompData.GetEnabled(mComp.EnabledExt);
    mComp.Anchors := oCompData.GetAnchors(mComp.Anchors);
    mComp.HintExt := oCompData.GetHint(mComp.HintExt);
    mComp.ShowHintExt := oCompData.GetShowHint(mComp.ShowHintExt);
    mComp.TabOrderExt := oCompData.GetTabOrder(mComp.TabOrderExt);
    mComp.TabStopExt := oCompData.GetTabStop(mComp.TabStopExt);
    mComp.Lines := oCompData.GetLines(mComp.Lines);
    mComp.MaxLength := oCompData.GetMaxLength(mComp.MaxLength);
    mComp.SystemColor := oCompData.GetSystemColor(mComp.SystemColor);
    mComp.BasicColor := oCompData.GetBasicColor(mComp.BasicColor);
    mComp.Font.Color := oCompData.GetFontColor(mComp.Font.Color);
    mComp.Color := oCompData.GetColor(mComp.Color);
    mComp.Font.Name := oCompData.GetFontName(mComp.Font.Name);
    mComp.Font.Size := oCompData.GetFontSize(mComp.Font.Size);
    mComp.Font.Style := oCompData.GetFontStyle(mComp.Font.Style);
    mComp.Font.Charset := oCompData.GetFontCharset(mComp.Font.Charset);
    mComp.ShowHint := TRUE;
    mComp.Hint := mComp.Name;
  end;
end;

function  TF_DsgnForm.CrtxpRadioButton (pName,pParam,pDefParent:string):boolean;
var mC:TComponent; mComp:TxpUniComp; mParent:TWinControl;
begin
  Result := TRUE;
  oCompData.SetCompData(pParam);
  AddDefCompList (pName,oCompData.CompFlds);
  mParent := GetParentObj(oForm,oCompData.GetParent);
  If mParent<>nil then begin
    mC := oForm.FindComponent (pName); mComp := nil;
    If mC is TxpUniComp then mComp := mC as TxpUniComp;
    If mComp=nil then begin
      mComp := TxpUniComp.Create(oForm);
      mComp.Name := pName;
    end;
    mComp.CompType := ucRadioButton;
    mComp.OnClick := MyCompOnClick;
    mComp.OnKeyDown := MyCompOnKeyDown;
    mComp.OnKeyUp := MyCompOnKeyUp;
    mComp.OnMouseMove := MyCompMouseMove;
    mComp.OnMouseDown := MyCompMouseDown;
    mComp.OnMouseUp := MyCompMouseUp;
    mComp.OnEnter := MyCompOnEnter;
    mComp.Parent := mParent;
    mComp.Left := oCompData.GetLeft(mComp.Left);
    mComp.Top := oCompData.GetTop(mComp.Top);
    mComp.Height := oCompData.GetHeight(mComp.Height);
    mComp.Width := oCompData.GetWidth(mComp.Width);
    mComp.Visible := oCompData.GetVisible(mComp.Visible);
    mComp.EnabledExt := oCompData.GetEnabled(mComp.EnabledExt);
    mComp.Anchors := oCompData.GetAnchors(mComp.Anchors);
    mComp.Caption := oCompData.GetCaption(mComp.Caption);
    mComp.HintExt := oCompData.GetHint(mComp.HintExt);
    mComp.ShowHintExt := oCompData.GetShowHint(mComp.ShowHintExt);
    mComp.TabOrderExt := oCompData.GetTabOrder(mComp.TabOrderExt);
    mComp.TabStopExt := oCompData.GetTabStop(mComp.TabStopExt);
    mComp.SystemColor := oCompData.GetSystemColor(mComp.SystemColor);
    mComp.BasicColor := oCompData.GetBasicColor(mComp.BasicColor);
    mComp.CheckColor := oCompData.GetCheckColor(mComp.CheckColor);
    mComp.Font.Color := oCompData.GetFontColor(mComp.Font.Color);
    mComp.Font.Name := oCompData.GetFontName(mComp.Font.Name);
    mComp.Font.Size := oCompData.GetFontSize(mComp.Font.Size);
    mComp.Font.Style := oCompData.GetFontStyle(mComp.Font.Style);
    mComp.Font.Charset := oCompData.GetFontCharset(mComp.Font.Charset);
    mComp.ShowHint := TRUE;
    mComp.Hint := mComp.Name+#13+mComp.Caption;
  end;
end;

function  TF_DsgnForm.CrtxpMemo (pName,pParam,pDefParent:string):boolean;
var mC:TComponent; mComp:TxpUniComp; mParent:TWinControl;
begin
  Result := TRUE;
  oCompData.SetCompData(pParam);
  AddDefCompList (pName,oCompData.CompFlds);
  mParent := GetParentObj(oForm,oCompData.GetParent);
  If mParent<>nil then begin
    mC := oForm.FindComponent (pName); mComp := nil;
    If mC is TxpUniComp then mComp := mC as TxpUniComp;
    If mComp=nil then begin
      mComp := TxpUniComp.Create(oForm);
      mComp.Name := pName;
    end;
    mComp.CompType := ucMemo;
    mComp.OnClick := MyCompOnClick;
    mComp.OnKeyDown := MyCompOnKeyDown;
    mComp.OnKeyUp := MyCompOnKeyUp;
    mComp.OnMouseMove := MyCompMouseMove;
    mComp.OnMouseDown := MyCompMouseDown;
    mComp.OnMouseUp := MyCompMouseUp;
    mComp.OnEnter := MyCompOnEnter;
    mComp.Parent := mParent;
    mComp.Left := oCompData.GetLeft(mComp.Left);
    mComp.Top := oCompData.GetTop(mComp.Top);
    mComp.Height := oCompData.GetHeight(mComp.Height);
    mComp.Width := oCompData.GetWidth(mComp.Width);
    mComp.Visible := oCompData.GetVisible(mComp.Visible);
    mComp.EnabledExt := oCompData.GetEnabled(mComp.EnabledExt);
    mComp.ReadOnly := oCompData.GetReadOnly(mComp.ReadOnly);
    mComp.Align := oCompData.GetAlign(mComp.Align);
    mComp.Alignment := oCompData.GetAlignment(mComp.Alignment);
    mComp.Anchors := oCompData.GetAnchors(mComp.Anchors);
    mComp.HintExt := oCompData.GetHint(mComp.HintExt);
    mComp.ShowHintExt := oCompData.GetShowHint(mComp.ShowHintExt);
    mComp.TabOrderExt := oCompData.GetTabOrder(mComp.TabOrderExt);
    mComp.TabStopExt := oCompData.GetTabStop(mComp.TabStopExt);
    mComp.Lines := oCompData.GetLines(mComp.Lines);
    mComp.MaxLength := oCompData.GetMaxLength(mComp.MaxLength);
    mComp.WordWrap := oCompData.GetWordWrap(mComp.WordWrap);
    mComp.SystemColor := oCompData.GetSystemColor(mComp.SystemColor);
    mComp.BasicColor := oCompData.GetBasicColor(mComp.BasicColor);
    mComp.Color := oCompData.GetColor(mComp.Color);
    mComp.Font.Color := oCompData.GetFontColor(mComp.Font.Color);
    mComp.Font.Name := oCompData.GetFontName(mComp.Font.Name);
    mComp.Font.Size := oCompData.GetFontSize(mComp.Font.Size);
    mComp.Font.Style := oCompData.GetFontStyle(mComp.Font.Style);
    mComp.Font.Charset := oCompData.GetFontCharset(mComp.Font.Charset);
    mComp.ShowHint := TRUE;
    mComp.Hint := mComp.Name;
  end;
end;

function  TF_DsgnForm.CrtxpRichEdit (pName,pParam,pDefParent:string):boolean;
var mC:TComponent; mComp:TxpUniComp; mParent:TWinControl;
begin
  Result := TRUE;
  oCompData.SetCompData(pParam);
  AddDefCompList (pName,oCompData.CompFlds);
  mParent := GetParentObj(oForm,oCompData.GetParent);
  If mParent<>nil then begin
    mC := oForm.FindComponent (pName); mComp := nil;
    If mC is TxpUniComp then mComp := mC as TxpUniComp;
    If mComp=nil then begin
      mComp := TxpUniComp.Create(oForm);
      mComp.Name := pName;
    end;
    mComp.CompType := ucRichEdit;
    mComp.OnClick := MyCompOnClick;
    mComp.OnKeyDown := MyCompOnKeyDown;
    mComp.OnKeyUp := MyCompOnKeyUp;
    mComp.OnMouseMove := MyCompMouseMove;
    mComp.OnMouseDown := MyCompMouseDown;
    mComp.OnMouseUp := MyCompMouseUp;
    mComp.OnEnter := MyCompOnEnter;
    mComp.Parent := mParent;
    mComp.Left := oCompData.GetLeft(mComp.Left);
    mComp.Top := oCompData.GetTop(mComp.Top);
    mComp.Height := oCompData.GetHeight(mComp.Height);
    mComp.Width := oCompData.GetWidth(mComp.Width);
    mComp.Visible := oCompData.GetVisible(mComp.Visible);
    mComp.EnabledExt := oCompData.GetEnabled(mComp.EnabledExt);
    mComp.ReadOnly := oCompData.GetReadOnly(mComp.ReadOnly);
    mComp.Align := oCompData.GetAlign(mComp.Align);
    mComp.Alignment := oCompData.GetAlignment(mComp.Alignment);
    mComp.Anchors := oCompData.GetAnchors(mComp.Anchors);
    mComp.HintExt := oCompData.GetHint(mComp.HintExt);
    mComp.ShowHintExt := oCompData.GetShowHint(mComp.ShowHintExt);
    mComp.TabOrderExt := oCompData.GetTabOrder(mComp.TabOrderExt);
    mComp.TabStopExt := oCompData.GetTabStop(mComp.TabStopExt);
    mComp.Lines := oCompData.GetLines(mComp.Lines);
    mComp.MaxLength := oCompData.GetMaxLength(mComp.MaxLength);
    mComp.WordWrap := oCompData.GetWordWrap(mComp.WordWrap);
    mComp.SystemColor := oCompData.GetSystemColor(mComp.SystemColor);
    mComp.BasicColor := oCompData.GetBasicColor(mComp.BasicColor);
    mComp.Color := oCompData.GetColor(mComp.Color);
    mComp.Font.Color := oCompData.GetFontColor(mComp.Font.Color);
    mComp.Font.Name := oCompData.GetFontName(mComp.Font.Name);
    mComp.Font.Size := oCompData.GetFontSize(mComp.Font.Size);
    mComp.Font.Style := oCompData.GetFontStyle(mComp.Font.Style);
    mComp.Font.Charset := oCompData.GetFontCharset(mComp.Font.Charset);
    mComp.ShowHint := TRUE;
    mComp.Hint := mComp.Name;
  end;
end;

function  TF_DsgnForm.CrtxpStatusLine (pName,pParam,pDefParent:string):boolean;
var mC:TComponent; mComp:TxpStatusLine; mParent:TWinControl;
begin
  Result := TRUE;
  oCompData.SetCompData(pParam);
  AddDefCompList (pName,oCompData.CompFlds);
  mParent := GetParentObj(oForm,oCompData.GetParent);
  If mParent<>nil then begin
    mC := oForm.FindComponent (pName); mComp := nil;
    If mC is TxpStatusLine then mComp := mC as TxpStatusLine;
    If mComp=nil then begin
      mComp := TxpStatusLine.Create(oForm);
      mComp.Name := pName;
    end;
    mComp.Parent := mParent;
    mComp.Visible := oCompData.GetVisible(mComp.Visible);
  end;
end;

function  TF_DsgnForm.CrtBasic (pName,pParam,pDefParent:string):boolean;
var mC:TComponent; mComp:TxpUniComp; mParent:TWinControl;
begin
  Result := TRUE;
  oCompData.SetCompData(pParam);
  AddDefCompList (pName,oCompData.CompFlds);
  mParent := GetParentObj(oForm,oCompData.GetParent);
  If mParent<>nil then begin
    mC := oForm.FindComponent (pName); mComp := nil;
    If mC is TxpUniComp then mComp := mC as TxpUniComp;
    If mComp=nil then begin
      mComp := TxpUniComp.Create(oForm);
      mComp.Name := pName;
    end;
    mComp.Caption := pName;
    mComp.CompType := ucBasic;
    mComp.OnClick := MyCompOnClick;
    mComp.OnKeyDown := MyCompOnKeyDown;
    mComp.OnKeyUp := MyCompOnKeyUp;
    mComp.OnMouseMove := MyCompMouseMove;
    mComp.OnMouseDown := MyCompMouseDown;
    mComp.OnMouseUp := MyCompMouseUp;
    mComp.OnEnter := MyCompOnEnter;
    mComp.Parent := mParent;
    mComp.Left := oCompData.GetLeft(mComp.Left);
    mComp.Top := oCompData.GetTop(mComp.Top);
    mComp.Height := oCompData.GetHeight(mComp.Height);
    mComp.Width := oCompData.GetWidth(mComp.Width);
    mComp.Align := oCompData.GetAlign(mComp.Align);
    mComp.Visible := oCompData.GetVisible(mComp.Visible);
    mComp.ShowHint := TRUE;
    mComp.Hint := mComp.Name;
  end;
end;

procedure TF_DsgnForm.SaveFormComp;
var mIni:TEncodeIniFile; I:longint;
begin
  mIni := TEncodeIniFile.Create(GetFormDefFileName(oFileName,oFormNum),FALSE);
  mIni.Encode := FALSE;
  mIni.WriteString('List',StrInt (oFormNum,0), oFormName+';'+StrInt (oLevel,0));
  If mIni.SectionExists(StrInt (oFormNum,0)) then mIni.EraseSection(StrInt (oFormNum,0));
  mIni.WriteString(StrInt (FormNum,0),oForm.Name,GetCompParams (oForm,GetDefProp (oForm.Name,mIni)));
  For I:=0 to oForm.ComponentCount-1 do begin
    mIni.WriteString(StrInt (FormNum,0),oForm.Components[I].Name,GetCompParams (oForm.Components[I],GetDefProp (oForm.Components[I].Name,mIni)));
  end;
  FreeAndNil (mIni);
end;

procedure TF_DsgnForm.CopyFormComp;
var I:longint;
begin
  uCompSect.Clear;
  For I:=0 to oForm.ComponentCount-1 do begin
    If CompIsSelected(oForm.Components[I])
      then uCompSect.Add (oForm.Components[I].Name+'='+GetCompParams (oForm.Components[I],''));
  end;
end;

function  TF_DsgnForm.GetCompParams (pComp:TComponent;pDefProp:string):string;
begin
  Result := '';
  If pComp is TForm then Result := GetFormParams (pComp as TForm,pDefProp);
  If (Result='') and (pComp is TxpSinglePanel) then Result := GetxpSinglePanelCompParams (pComp as TxpSinglePanel,pDefProp);
  If (Result='') and (pComp is TxpGroupBox) then Result := GetxpGroupBoxCompParams (pComp as TxpGroupBox,pDefProp);
  If (Result='') and (pComp is TxpPageControl) then Result := GetxpPageControlCompParams (pComp as TxpPageControl,pDefProp);
  If (Result='') and (pComp is TxpTabSheet) then Result := GetxpTabSheetCompParams (pComp as TxpTabSheet,pDefProp);
  If (Result='') and (pComp is TxpStatusLine) then Result := GetxpStatusLineCompParams (pComp as TxpStatusLine,pDefProp);
  If (Result='') and (pComp is TxpUniComp) then begin
    If (pComp as TxpUniComp).CompType=ucButton then Result := GetxpButtonCompParams (pComp as TxpUniComp,pDefProp);
  end;
  If (Result='') and (pComp is TxpUniComp) then begin
    If (pComp as TxpUniComp).CompType=ucEditor then Result := GetxpEditCompParams (pComp as TxpUniComp,pDefProp);
  end;
  If (Result='') and (pComp is TxpUniComp) then begin
    If (pComp as TxpUniComp).CompType=ucLabel then Result := GetxpLabelCompParams (pComp as TxpUniComp,pDefProp);
  end;
  If (Result='') and (pComp is TxpUniComp) then begin
    If (pComp as TxpUniComp).CompType=ucCheckBox then Result := GetxpCheckBoxCompParams (pComp as TxpUniComp,pDefProp);
  end;
  If (Result='') and (pComp is TxpUniComp) then begin
    If (pComp as TxpUniComp).CompType=ucComboBox then Result := GetxpComboBoxCompParams (pComp as TxpUniComp,pDefProp);
  end;
  If (Result='') and (pComp is TxpUniComp) then begin
    If (pComp as TxpUniComp).CompType=ucRadioButton then Result := GetxpRadioButtonCompParams (pComp as TxpUniComp,pDefProp);
  end;
  If (Result='') and (pComp is TxpUniComp) then begin
    If (pComp as TxpUniComp).CompType=ucMemo then Result := GetxpMemoCompParams (pComp as TxpUniComp,pDefProp);
  end;
  If (Result='') and (pComp is TxpUniComp) then begin
    If (pComp as TxpUniComp).CompType=ucRichEdit then Result := GetxpRichEditCompParams (pComp as TxpUniComp,pDefProp);
  end;
  If (Result='') and (pComp is TxpUniComp) then begin
    If (pComp as TxpUniComp).CompType=ucBasic then Result := GetBasicCompParams (pComp as TxpUniComp,pDefProp);
  end;
end;

function  TF_DsgnForm.GetFormParams (pComp:TForm;pDefProp:string):string;
begin
  oCompData.SaveOnlySelected := TRUE;
  oCompData.ClearCompData;
  oCompData.SetDefPropList(pDefProp);
  oCompData.SetCompType ('Form');
  oCompData.SetTop (pComp.Top);
  oCompData.SetLeft (pComp.Left);
  oCompData.SetHeight (pComp.Height);
  oCompData.SetWidth (pComp.Width);
  oCompData.SetCaption (pComp.Caption);
  oCompData.SetColor (pComp.Color);
  oCompData.SetAlign (pComp.Align);
  Result := oCompData.GetCompData;
end;

function  TF_DsgnForm.GetxpSinglePanelCompParams (pComp:TxpSinglePanel;pDefProp:string):string;
begin
  oCompData.SaveOnlySelected := TRUE;
  oCompData.ClearCompData;
  oCompData.SetDefPropList(pDefProp);
  oCompData.SetCompType ('xpSinglePanel');
  oCompData.SetParent (pComp.Parent.Name);
  oCompData.SetTop (pComp.Top);
  oCompData.SetLeft (pComp.Left);
  oCompData.SetHeight (pComp.Height);
  oCompData.SetWidth (pComp.Width);
  oCompData.SetVisible (pComp.Visible);
  oCompData.SetEnabled (pComp.EnabledExt);
  oCompData.SetAlign (pComp.Align);
  oCompData.SetAnchors (pComp.Anchors);
  oCompData.SetHead (pComp.Head);
  oCompData.SetHint (pComp.HintExt);
  oCompData.SetTabOrder (pComp.TabOrderExt);
  oCompData.SetTabStop (pComp.TabStopExt);
  oCompData.SetShowHint (pComp.ShowHintExt);
  oCompData.SetSystemColor (pComp.SystemColor);
  oCompData.SetBasicColor (pComp.BasicColor);
  oCompData.SetBorderColor (pComp.BorderColor);
  oCompData.SetColor (pComp.Color);
  oCompData.SetBGImage (ConvBitmapToHEX(pComp.BGImage));
  oCompData.SetBGStyle (pComp.BGStyle);
  oCompData.SetGradStartColor (pComp.GradStartColor);
  oCompData.SetGradEndColor (pComp.GradEndColor);
  oCompData.SetGradFillDir (pComp.GradFillDir);
  oCompData.SetFontColor (pComp.Font.Color);
  oCompData.SetFontName (pComp.Font.Name);
  oCompData.SetFontSize (pComp.Font.Size);
  oCompData.SetFontStyle (pComp.Font.Style);
  oCompData.SetFontCharset (pComp.Font.Charset);
  Result := oCompData.GetCompData;
end;

function  TF_DsgnForm.GetxpGroupBoxCompParams (pComp:TxpGroupBox;pDefProp:string):string;
begin
  oCompData.SaveOnlySelected := TRUE;
  oCompData.ClearCompData;
  oCompData.SetDefPropList(pDefProp);
  oCompData.SetCompType ('xpGroupBox');
  oCompData.SetParent (pComp.Parent.Name);
  oCompData.SetTop (pComp.Top);
  oCompData.SetLeft (pComp.Left);
  oCompData.SetHeight (pComp.Height);
  oCompData.SetWidth (pComp.Width);
  oCompData.SetVisible (pComp.Visible);
  oCompData.SetEnabled (pComp.EnabledExt);
  oCompData.SetAlign (pComp.Align);
  oCompData.SetAnchors (pComp.Anchors);
  oCompData.SetCaption (pComp.Caption);
  oCompData.SetHint (pComp.HintExt);
  oCompData.SetShowHint (pComp.ShowHintExt);
  oCompData.SetTabOrder (pComp.TabOrderExt);
  oCompData.SetTabStop (pComp.TabStopExt);
  oCompData.SetSystemColor (pComp.SystemColor);
  oCompData.SetBasicColor (pComp.BasicColor);
  oCompData.SetColor (pComp.Color);
  oCompData.SetBorderColor (pComp.BorderColor);
  oCompData.SetFontColor (pComp.Font.Color);
  oCompData.SetFontName (pComp.Font.Name);
  oCompData.SetFontSize (pComp.Font.Size);
  oCompData.SetFontStyle (pComp.Font.Style);
  oCompData.SetFontCharset (pComp.Font.Charset);
  Result := oCompData.GetCompData;
end;

function  TF_DsgnForm.GetxpPageControlCompParams (pComp:TxpPageControl;pDefProp:string):string;
begin
  oCompData.SaveOnlySelected := TRUE;
  oCompData.ClearCompData;
  oCompData.SetDefPropList(pDefProp);
  oCompData.SetCompType ('xpPageControl');
  oCompData.SetParent (pComp.Parent.Name);
  oCompData.SetTop (pComp.Top);
  oCompData.SetLeft (pComp.Left);
  oCompData.SetHeight (pComp.Height);
  oCompData.SetWidth (pComp.Width);
  oCompData.SetVisible (pComp.Visible);
  oCompData.SetEnabled (pComp.EnabledExt);
  oCompData.SetAlign (pComp.Align);
  oCompData.SetAnchors (pComp.Anchors);
  oCompData.SetHint (pComp.HintExt);
  oCompData.SetShowHint (pComp.ShowHintExt);
  oCompData.SetTabOrder (pComp.TabOrderExt);
  oCompData.SetTabStop (pComp.TabStopExt);
  oCompData.SetTabsShow (pComp.TabsShow);
  oCompData.SetTabHeight (pComp.TabHeight);
  oCompData.SetMultiLine (pComp.MultiLine);
  oCompData.SetSystemColor (pComp.SystemColor);
  oCompData.SetBasicColor (pComp.BasicColor);
  oCompData.SetColor (pComp.Color);
  oCompData.SetBorderColor (pComp.BorderColor);
  oCompData.SetFontColor (pComp.Font.Color);
  oCompData.SetFontName (pComp.Font.Name);
  oCompData.SetFontSize (pComp.Font.Size);
  oCompData.SetFontStyle (pComp.Font.Style);
  oCompData.SetFontCharset (pComp.Font.Charset);
  Result := oCompData.GetCompData;
end;

function  TF_DsgnForm.GetxpTabSheetCompParams (pComp:TxpTabSheet;pDefProp:string):string;
begin
  oCompData.SaveOnlySelected := TRUE;
  oCompData.ClearCompData;
  oCompData.SetDefPropList(pDefProp);
  oCompData.SetCompType ('xpTabSheet');
  oCompData.SetParent (pComp.Parent.Name);
  oCompData.SetTop (pComp.Top);
  oCompData.SetLeft (pComp.Left);
  oCompData.SetHeight (pComp.Height);
  oCompData.SetWidth (pComp.Width);
  oCompData.SetVisible (pComp.TabVisible);
  oCompData.SetEnabled (pComp.EnabledExt);
  oCompData.SetCaption (pComp.Caption);
  oCompData.SetPageIndex (pComp.PageIndex);
  oCompData.SetHint (pComp.HintExt);
  oCompData.SetShowHint (pComp.ShowHintExt);
  oCompData.SetSystemColor (pComp.SystemColor);
  oCompData.SetBasicColor (pComp.BasicColor);
  oCompData.SetColor (pComp.Color);
  oCompData.SetBGImage (ConvBitmapToHEX(pComp.BGImage));
  oCompData.SetBGStyle (pComp.BGStyle);
  oCompData.SetGradStartColor (pComp.GradientStartColor);
  oCompData.SetGradEndColor (pComp.GradientEndColor);
  oCompData.SetGradFillDir (pComp.GradientFillDir);
  oCompData.SetFontColor (pComp.Font.Color);
  oCompData.SetFontName (pComp.Font.Name);
  oCompData.SetFontSize (pComp.Font.Size);
  oCompData.SetFontStyle (pComp.Font.Style);
  oCompData.SetFontCharset (pComp.Font.Charset);
  Result := oCompData.GetCompData;
end;

function  TF_DsgnForm.GetxpButtonCompParams (pComp:TxpUniComp;pDefProp:string):string;
begin
  oCompData.SaveOnlySelected := TRUE;
  oCompData.ClearCompData;
  oCompData.SetDefPropList(pDefProp);
  oCompData.SetCompType ('xpBitBtn');
  oCompData.SetParent (pComp.Parent.Name);
  oCompData.SetTop (pComp.Top);
  oCompData.SetLeft (pComp.Left);
  oCompData.SetHeight (pComp.Height);
  oCompData.SetWidth (pComp.Width);
  oCompData.SetVisible (pComp.Visible);
  oCompData.SetEnabled (pComp.EnabledExt);
  oCompData.SetCaption (pComp.Caption);
  oCompData.SetAnchors (pComp.Anchors);
  oCompData.SetAlignText (pComp.AlignText);
  oCompData.SetHint (pComp.HintExt);
  oCompData.SetShowHint (pComp.ShowHintExt);
  oCompData.SetTabOrder (pComp.TabOrderExt);
  oCompData.SetTabStop (pComp.TabStopExt);
  oCompData.SetSystemColor (pComp.SystemColor);
  oCompData.SetBasicColor (pComp.BasicColor);
  oCompData.SetButtLayout (pComp.ButtLayout);
  oCompData.SetGlyph (ConvBitmapToHEX (pComp.Glyph));
  oCompData.SetFontColor (pComp.Font.Color);
  oCompData.SetFontName (pComp.Font.Name);
  oCompData.SetFontSize (pComp.Font.Size);
  oCompData.SetFontStyle (pComp.Font.Style);
  oCompData.SetFontCharset (pComp.Font.Charset);
  Result := oCompData.GetCompData;
end;

function  TF_DsgnForm.GetxpEditCompParams (pComp:TxpUniComp;pDefProp:string):string;
begin
  oCompData.SaveOnlySelected := TRUE;
  oCompData.ClearCompData;
  oCompData.SetDefPropList(pDefProp);
  oCompData.SetCompType ('xpEdit');
  oCompData.SetParent (pComp.Parent.Name);
  oCompData.SetTop (pComp.Top);
  oCompData.SetLeft (pComp.Left);
  oCompData.SetHeight (pComp.Height);
  oCompData.SetWidth (pComp.Width);
  oCompData.SetVisible (pComp.Visible);
  oCompData.SetEnabled (pComp.Enabled);
  oCompData.SetReadOnly (pComp.ReadOnly);
  oCompData.SetAlign (pComp.Align);
  oCompData.SetAlignment (pComp.Alignment);
  oCompData.SetAnchors (pComp.Anchors);
  oCompData.SetHint (pComp.HintExt);
  oCompData.SetShowHint (pComp.ShowHintExt);
  oCompData.SetTabOrder (pComp.TabOrderExt);
  oCompData.SetTabStop (pComp.TabStopExt);
  oCompData.SetMaxLength (pComp.MaxLength);
  oCompData.SetNumSepar (pComp.NumSepar);
  oCompData.SetFrac (pComp.Frac);
  oCompData.SetEditorType (pComp.EditorType);
  oCompData.SetExtTextShow (pComp.ExtTextShow);
  oCompData.SetSystemColor (pComp.SystemColor);
  oCompData.SetBasicColor (pComp.BasicColor);
  oCompData.SetColor (pComp.Color);
  oCompData.SetInfoField (pComp.InfoField);
  oCompData.SetFontColor (pComp.Font.Color);
  oCompData.SetFontName (pComp.Font.Name);
  oCompData.SetFontSize (pComp.Font.Size);
  oCompData.SetFontStyle (pComp.Font.Style);
  oCompData.SetFontCharset (pComp.Font.Charset);
  Result := oCompData.GetCompData;
end;

function  TF_DsgnForm.GetxpLabelCompParams (pComp:TxpUniComp;pDefProp:string):string;
begin
  oCompData.SaveOnlySelected := TRUE;
  oCompData.ClearCompData;
  oCompData.SetDefPropList(pDefProp);
  oCompData.SetCompType ('xpLabel');
  oCompData.SetParent (pComp.Parent.Name);
  oCompData.SetTop (pComp.Top);
  oCompData.SetLeft (pComp.Left);
  oCompData.SetHeight (pComp.Height);
  oCompData.SetWidth (pComp.Width);
  oCompData.SetVisible (pComp.Visible);
  oCompData.SetEnabled (pComp.EnabledExt);
  oCompData.SetAnchors (pComp.Anchors);
  oCompData.SetAlign (pComp.Align);
  oCompData.SetAlignment (pComp.Alignment);
  oCompData.SetAutoSize (pComp.AutoSize);
  oCompData.SetCaption (pComp.Caption);
  oCompData.SetColor (pComp.Color);
  oCompData.SetHint (pComp.HintExt);
  oCompData.SetShowHint (pComp.ShowHintExt);
  oCompData.SetTextLayout (pComp.Layout);
  oCompData.SetSystemColor (pComp.SystemColor);
  oCompData.SetTransparent (pComp.Transparent);
  oCompData.SetWordWrap (pComp.WordWrap);
  oCompData.SetFontColor (pComp.Font.Color);
  oCompData.SetFontName (pComp.Font.Name);
  oCompData.SetFontSize (pComp.Font.Size);
  oCompData.SetFontStyle (pComp.Font.Style);
  oCompData.SetFontCharset (pComp.Font.Charset);
  Result := oCompData.GetCompData;
end;

function  TF_DsgnForm.GetxpCheckBoxCompParams (pComp:TxpUniComp;pDefProp:string):string;
begin
  oCompData.SaveOnlySelected := TRUE;
  oCompData.ClearCompData;
  oCompData.SetDefPropList(pDefProp);
  oCompData.SetCompType ('xpCheckBox');
  oCompData.SetParent (pComp.Parent.Name);
  oCompData.SetTop (pComp.Top);
  oCompData.SetLeft (pComp.Left);
  oCompData.SetHeight (pComp.Height);
  oCompData.SetWidth (pComp.Width);
  oCompData.SetVisible (pComp.Visible);
  oCompData.SetEnabled (pComp.EnabledExt);
  oCompData.SetAnchors (pComp.Anchors);
  oCompData.SetCaption (pComp.Caption);
  oCompData.SetHint (pComp.HintExt);
  oCompData.SetShowHint (pComp.ShowHintExt);
  oCompData.SetTabOrder (pComp.TabOrderExt);
  oCompData.SetTabStop (pComp.TabStopExt);
  oCompData.SetSystemColor (pComp.SystemColor);
  oCompData.SetBasicColor (pComp.BasicColor);
  oCompData.SetCheckColor (pComp.CheckColor);
  oCompData.SetFontColor (pComp.Font.Color);
  oCompData.SetFontName (pComp.Font.Name);
  oCompData.SetFontSize (pComp.Font.Size);
  oCompData.SetFontStyle (pComp.Font.Style);
  oCompData.SetFontCharset (pComp.Font.Charset);
  Result := oCompData.GetCompData;
end;

function  TF_DsgnForm.GetxpComboBoxCompParams (pComp:TxpUniComp;pDefProp:string):string;
begin
  oCompData.SaveOnlySelected := TRUE;
  oCompData.ClearCompData;
  oCompData.SetDefPropList(pDefProp);
  oCompData.SetCompType ('xpComboBox');
  oCompData.SetParent (pComp.Parent.Name);
  oCompData.SetTop (pComp.Top);
  oCompData.SetLeft (pComp.Left);
  oCompData.SetHeight (pComp.Height);
  oCompData.SetWidth (pComp.Width);
  oCompData.SetVisible (pComp.Visible);
  oCompData.SetEnabled (pComp.EnabledExt);
  oCompData.SetAnchors (pComp.Anchors);
  oCompData.SetHint (pComp.HintExt);
  oCompData.SetShowHint (pComp.ShowHintExt);
  oCompData.SetTabOrder (pComp.TabOrderExt);
  oCompData.SetTabStop (pComp.TabStopExt);
  oCompData.SetLines (pComp.Lines);
  oCompData.SetMaxLength (pComp.MaxLength);
  oCompData.SetSystemColor (pComp.SystemColor);
  oCompData.SetBasicColor (pComp.BasicColor);
  oCompData.SetColor (pComp.Color);
  oCompData.SetFontColor (pComp.Font.Color);
  oCompData.SetFontName (pComp.Font.Name);
  oCompData.SetFontSize (pComp.Font.Size);
  oCompData.SetFontStyle (pComp.Font.Style);
  oCompData.SetFontCharset (pComp.Font.Charset);
  Result := oCompData.GetCompData;
end;

function  TF_DsgnForm.GetxpRadioButtonCompParams (pComp:TxpUniComp;pDefProp:string):string;
begin
  oCompData.SaveOnlySelected := TRUE;
  oCompData.ClearCompData;
  oCompData.SetDefPropList(pDefProp);
  oCompData.SetCompType ('xpRadioButton');
  oCompData.SetParent (pComp.Parent.Name);
  oCompData.SetTop (pComp.Top);
  oCompData.SetLeft (pComp.Left);
  oCompData.SetHeight (pComp.Height);
  oCompData.SetWidth (pComp.Width);
  oCompData.SetVisible (pComp.Visible);
  oCompData.SetEnabled (pComp.EnabledExt);
  oCompData.SetAnchors (pComp.Anchors);
  oCompData.SetCaption (pComp.Caption);
  oCompData.SetHint (pComp.HintExt);
  oCompData.SetShowHint (pComp.ShowHintExt);
  oCompData.SetTabOrder (pComp.TabOrderExt);
  oCompData.SetTabStop (pComp.TabStopExt);
  oCompData.SetSystemColor (pComp.SystemColor);
  oCompData.SetBasicColor (pComp.BasicColor);
  oCompData.SetCheckColor (pComp.CheckColor);
  oCompData.SetFontColor (pComp.Font.Color);
  oCompData.SetFontName (pComp.Font.Name);
  oCompData.SetFontSize (pComp.Font.Size);
  oCompData.SetFontStyle (pComp.Font.Style);
  oCompData.SetFontCharset (pComp.Font.Charset);
  Result := oCompData.GetCompData;
end;

function  TF_DsgnForm.GetxpMemoCompParams (pComp:TxpUniComp;pDefProp:string):string;
begin
  oCompData.SaveOnlySelected := TRUE;
  oCompData.ClearCompData;
  oCompData.SetDefPropList(pDefProp);
  oCompData.SetCompType ('xpMemo');
  oCompData.SetParent (pComp.Parent.Name);
  oCompData.SetTop (pComp.Top);
  oCompData.SetLeft (pComp.Left);
  oCompData.SetHeight (pComp.Height);
  oCompData.SetWidth (pComp.Width);
  oCompData.SetVisible (pComp.Visible);
  oCompData.SetEnabled (pComp.EnabledExt);
  oCompData.SetReadOnly (pComp.ReadOnly);
  oCompData.SetAlign (pComp.Align);
  oCompData.SetAlignment (pComp.Alignment);
  oCompData.SetAnchors (pComp.Anchors);
  oCompData.SetHint (pComp.HintExt);
  oCompData.SetShowHint (pComp.ShowHintExt);
  oCompData.SetTabOrder (pComp.TabOrderExt);
  oCompData.SetTabStop (pComp.TabStopExt);
  oCompData.SetLines (pComp.Lines);
  oCompData.SetMaxLength (pComp.MaxLength);
  oCompData.SetWordWrap (pComp.WordWrap);
  oCompData.SetSystemColor (pComp.SystemColor);
  oCompData.SetBasicColor (pComp.BasicColor);
  oCompData.SetColor (pComp.Color);
  oCompData.SetFontColor (pComp.Font.Color);
  oCompData.SetFontName (pComp.Font.Name);
  oCompData.SetFontSize (pComp.Font.Size);
  oCompData.SetFontStyle (pComp.Font.Style);
  oCompData.SetFontCharset (pComp.Font.Charset);
  Result := oCompData.GetCompData;
end;

function  TF_DsgnForm.GetxpRichEditCompParams (pComp:TxpUniComp;pDefProp:string):string;
begin
  oCompData.SaveOnlySelected := TRUE;
  oCompData.ClearCompData;
  oCompData.SetDefPropList(pDefProp);
  oCompData.SetCompType ('xpRichEdit');
  oCompData.SetParent (pComp.Parent.Name);
  oCompData.SetTop (pComp.Top);
  oCompData.SetLeft (pComp.Left);
  oCompData.SetHeight (pComp.Height);
  oCompData.SetWidth (pComp.Width);
  oCompData.SetVisible (pComp.Visible);
  oCompData.SetEnabled (pComp.EnabledExt);
  oCompData.SetReadOnly (pComp.ReadOnly);
  oCompData.SetAlign (pComp.Align);
  oCompData.SetAlignment (pComp.Alignment);
  oCompData.SetAnchors (pComp.Anchors);
  oCompData.SetHint (pComp.HintExt);
  oCompData.SetShowHint (pComp.ShowHintExt);
  oCompData.SetTabOrder (pComp.TabOrderExt);
  oCompData.SetTabStop (pComp.TabStopExt);
  oCompData.SetLines (pComp.Lines);
  oCompData.SetMaxLength (pComp.MaxLength);
  oCompData.SetWordWrap (pComp.WordWrap);
  oCompData.SetSystemColor (pComp.SystemColor);
  oCompData.SetBasicColor (pComp.BasicColor);
  oCompData.SetColor (pComp.Color);
  oCompData.SetFontColor (pComp.Font.Color);
  oCompData.SetFontName (pComp.Font.Name);
  oCompData.SetFontSize (pComp.Font.Size);
  oCompData.SetFontStyle (pComp.Font.Style);
  oCompData.SetFontCharset (pComp.Font.Charset);
  Result := oCompData.GetCompData;
end;

function  TF_DsgnForm.GetxpStatusLineCompParams (pComp:TxpStatusLine;pDefProp:string):string;
begin
  oCompData.SaveOnlySelected := TRUE;
  oCompData.ClearCompData;
  oCompData.SetDefPropList(pDefProp);
  oCompData.SetCompType ('xpStatusLine');
  oCompData.SetParent (pComp.Parent.Name);
  oCompData.SetVisible (pComp.Visible);
  Result := oCompData.GetCompData;
end;

function  TF_DsgnForm.GetBasicCompParams (pComp:TxpUniComp;pDefProp:string):string;
begin
  oCompData.SaveOnlySelected := TRUE;
  oCompData.ClearCompData;
  oCompData.SetDefPropList(pDefProp);
  oCompData.SetCompType ('Basic');
  oCompData.SetParent (pComp.Parent.Name);
  oCompData.SetTop (pComp.Top);
  oCompData.SetLeft (pComp.Left);
  oCompData.SetHeight (pComp.Height);
  oCompData.SetWidth (pComp.Width);
  oCompData.SetVisible (pComp.Visible);
  oCompData.SetAlign (pComp.Align);
  Result := oCompData.GetCompData;
end;

constructor TF_DsgnForm.Create(AOwner: TComponent);
begin
  inherited;
  oCompLstPos := TStringList.Create;
  If uCompSect=nil then uCompSect := TStringList.Create;
  oFirst := TRUE;
  oSelMode := TRUE;
  Left := 1; Top := 1;
  oCompData :=TCompData.Create;
  F_DsgnInsp := TF_DsgnInsp.Create(nil);
  F_DsgnInsp.Left := 1;
  F_DsgnInsp.Top := Top+Height+1;
  F_DsgnInsp.oF_DsgnForm := Self;
  oDefCompList := TStringList.Create;
  oFirstSelComp := '';
end;

destructor  TF_DsgnForm.Destroy;
begin
  If oForm<>nil then begin
    oForm.Close;
    FreeAndNil (oForm);
  end;
  F_DsgnInsp.Close;
  FreeAndNil (F_DsgnInsp);
  FreeAndNil(oCompLstPos);
  FreeAndNil(oCompData);
  FreeAndNil (oDefCompList);
  inherited;
end;

procedure  TF_DsgnForm.Execute;
begin
  OpenFormComp;
  ShowModal;
end;

procedure TF_DsgnForm.BB_NewFormClick(Sender: TObject);
var I:longint; mComp:TComponent; mFind:boolean;
begin
  If oForm<>nil then begin
    oForm.Close;
    FreeAndNil (oForm);
  end;
  oFormNum := 255;
  OpenFormComp;
  For I:=0 to oForm.ComponentCount-1 do begin
   mComp := oForm.Components[I];
   mFind := FALSE;
   If (mComp is TxpSinglePanel) then begin
     (mComp as TxpSinglePanel).Visible := TRUE; mFind := TRUE;
   end;
   If not mFind and (mComp is TxpGroupBox) then begin
     (mComp as TxpGroupBox).Visible := TRUE; mFind := TRUE;
   end;
   If not mFind and (mComp is TxpPageControl) then begin
     (mComp as TxpPageControl).Visible := TRUE; mFind := TRUE;
   end;
   If not mFind and (mComp is TxpTabSheet) then begin
     (mComp as TxpTabSheet).TabVisible := TRUE; mFind := TRUE;
   end;
   If not mFind and (mComp is TxpStatusLine) then begin
     (mComp as TxpStatusLine).Visible := TRUE; mFind := TRUE;
   end;
   If not mFind and (mComp is TWinControl) then begin
     (mComp as TWinControl).Visible := FALSE;
   end;
  end;
  If oForm<>nil then oForm.Show;
end;

procedure TF_DsgnForm.BB_OpenFormClick(Sender: TObject);
var mDsgnOpen:TF_DsgnOpen; mFormNum:longint;
begin
  mDsgnOpen := TF_DsgnOpen.Create(nil);
  mFormNum := mDsgnOpen.Execute(oFileName);
  FreeAndNil (mDsgnOpen);
  If mFormNum>-1 then begin
    oFormNum := mFormNum;
    OpenFormComp;
    If oForm<>nil then oForm.Show;
  end;
end;

procedure TF_DsgnForm.FormShow(Sender: TObject);
begin
  If oFirst then begin
    If (oForm<>nil) then oForm.Show;
    F_DsgnInsp.Show;
    F_DsgnInsp.SG_ObjInsp.Repaint;
    oFirst := FALSE;
  end;
end;

procedure TF_DsgnForm.B_CompPastelick(Sender: TObject);
begin
  PasteFormComp;
end;

procedure TF_DsgnForm.BB_SaveFormClick(Sender: TObject);
var mDsgnSave:TF_DsgnSave; mFormNum:longint;
begin
  mDsgnSave := TF_DsgnSave.Create(nil);
  If mDsgnSave.Execute(oFileName,oFormNum) then begin
    oFormNum := mDsgnSave.E_FormNum.AsInteger;
    oFormName := mDsgnSave.E_FormName.Text;
    oLevel := mDsgnSave.E_FormLevel.AsInteger;
    SaveFormComp;
  end;
  FreeAndNil (mDsgnSave);
end;

procedure TF_DsgnForm.B_CompCopyClick(Sender: TObject);
begin
  CopyFormComp;
end;

procedure TF_DsgnForm.B_CompDelClick(Sender: TObject);
begin
  HideSelComps;
end;

procedure TF_DsgnForm.B_ShowSwitchClick(Sender: TObject);
var mButt:TxpBitBtn;
begin
  If Sender is TxpBitBtn then begin
    mButt := Sender as TxpBitBtn;
    oHideCompFilt := 0;
    If mButt.Down then oHideCompFilt := mButt.Tag;
    FillHideCompList;
    If CB_HideCompList.Items.Count>0
      then B_ShowSel.Down := FALSE
      else B_ShowSel.Down := TRUE;
  end;
end;

procedure TF_DsgnForm.B_ShowActClick(Sender: TObject);
var mS:string;
begin
  If CB_HideCompList.ItemIndex>-1 then begin
    ClearAllSelect (TRUE);
    mS := CB_HideCompList.Items.Strings[CB_HideCompList.ItemIndex];
    mS := Copy (mS,1,Pos (' ',mS)-1);
    SetShowComp(oForm.FindComponent(mS));
    FillHideCompList;
    SetCompSelected (oForm.FindComponent(mS),TRUE);
    F_DsgnInsp.FillObjInsp;
  end;
  oForm.Show;
end;

procedure TF_DsgnForm.B_ShowSelClick(Sender: TObject);
begin
  oSelMode := B_ShowSel.Down;
end;

procedure TF_DsgnForm.B_ToFrontClick(Sender: TObject);
var I:longint; mComp:TComponent;
begin
  For I:=0 to oForm.ComponentCount-1 do begin
     mComp := oForm.Components[I];
     If CompIsSelected(mComp) then begin
       If (mComp is TWinControl) then begin
         (mComp as TWinControl).BringToFront;
       end;
     end;
  end;
end;

procedure TF_DsgnForm.B_ToBackClick(Sender: TObject);
var I:longint; mComp:TComponent;
begin
  For I:=0 to oForm.ComponentCount-1 do begin
     mComp := oForm.Components[I];
     If CompIsSelected(mComp) then begin
       If (mComp is TWinControl) then begin
         (mComp as TWinControl).SendToBack;
       end;
     end;
  end;
end;

end.
