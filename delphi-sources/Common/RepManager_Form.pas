unit RepManager_Form;

interface

uses
  IcVariab,NexPath, IcTools,BtrTools,FpTools, IcConv, IniHandle, NexMsg,
  QuickRep, CmpTools, PropertiesEditor, PropEditor,
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms,
  Dialogs, IniFiles, StdCtrls, Buttons, ExtCtrls, ComCtrls, Menus,
  DB,FileCtrl, IcButtons;

const
  cSeparator = ',';
  cBorderSize= 2;  // sirka okraja v ktorom sa meni kurzor {kvoli zmene velkosti komponentu}
  // Command Constants
  cNONE = 0;
  cOK   = 1;
  cMOVE = 2;
  cFONT = 3;
  cSIZE = 4;

  // Standard Components
  cAddLabel       = 10;
  cAddShape       = 11;
  cAddVertLine    = 12;
  cAddHorLine     = 13;
  cAddEdit        = 14;
  cAddPageControl = 15;
  cAddTabSheet    = 16;

  // Quick Report componnents
  cAddQuickRep    = 101;
  cAddQRBand      = 102;
  cAddQRChildBand = 103;
  cAddQRLabel     = 104;
  cAddQRDbText    = 105;
  cAddQRExpr      = 106;
  cAddQRSysData   = 107;
  cAddQRShape     = 108;

type
  TF_RepManager = class(TForm)
    PC_FManager: TPageControl;
    TabSheet1: TTabSheet;
    TabSheet2: TTabSheet;
    SB_MoveComponent: TSpeedButton;
    PM_: TPopupMenu;
    Properties1: TMenuItem;
    N1: TMenuItem;
    ComponentName1: TMenuItem;
    Type1: TMenuItem;
    Delete1: TMenuItem;
    SB_NewQuickRep: TSpeedButton;
    SB_NewQRBand: TSpeedButton;
    SB_NewQRChildBand: TSpeedButton;
    SB_NewQRLabel: TSpeedButton;
    SB_NewQRDBText: TSpeedButton;
    SB_NewQRExpr: TSpeedButton;
    SB_NewQRSysData: TSpeedButton;
    SB_NewQRShape: TSpeedButton;
    N2: TMenuItem;
    BringToFront1: TMenuItem;
    SendtoBack1: TMenuItem;
    L_FormSettingsFolder: TLabel;
    Button3: TButton;
    Button4: TButton;
    Button5: TButton;
    Propplus: TMenuItem;
    SB_ResizeComponent: TSpeedButton;
    AgyAppIni1: TIniHandle;
    Prop1: TPropEditor;
    CB_SettingNames: TComboBox;
    SB_NewLabel: TSpeedButton;
    SB_NewVerLine: TSpeedButton;
    SB_NewHorLine: TSpeedButton;
    SB_NewShape: TSpeedButton;
    SB_NewEdit: TSpeedButton;
    SB_NewPageControl: TSpeedButton;
    SB_NewTabSheet: TSpeedButton;
    L_AddComponent: TLabel;
    SaveButton1: TSaveButton;
    SaveButton2: TSaveButton;
    CancelButton1: TCancelButton;
    SpecButton1: TSpecButton;
    Timer1: TTimer;
    procedure BB_SaveClick(Sender: TObject);
    procedure BB_DeleteClick(Sender: TObject);
    procedure SB_NewLabelClick(Sender: TObject);
    procedure CB_SettingNamesClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormActivate(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure Properties1Click(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure Delete1Click(Sender: TObject);
    procedure BringToFront1Click(Sender: TObject);
    procedure SendtoBack1Click(Sender: TObject);
    procedure JB_FolderClick(Sender: TObject);
    procedure JB_ExtensionClick(Sender: TObject);
    procedure JetButton3Click(Sender: TObject);
    procedure PropplusClick(Sender: TObject);
    procedure BB_SaveAsClick(Sender: TObject);
    procedure Button1Click(Sender: TObject);
    procedure CancelButton1Click(Sender: TObject);
    procedure DeleteComponent;
    procedure Timer1Timer(Sender: TObject);
  private
    { Private declarations }
    oExecute: integer;
    oFormSettingsFolder: string;
    oFileNameMask: string; //1999.10.8.
    oFileExtensionMask: string; //1999.10.8.
    oAction: integer;
    oMoveComponentTop: integer;
    oMoveComponent: TObject;
    oSelectComponent: TObject;
    oMoveComponentLeft: integer;
    oForm: TForm;
    oSender: TObject;
    oMouse: TMouse;
    oReports: TStrings;
    oColor: TColor;
    oHeaddataSet: TdataSet;
    oItemdataSet: TdataSet;
    oDeleteComponent : boolean;
    oDown       : boolean;
    oCurType    : integer;

    procedure WriteForm(pForm: TForm; pFormSettingsFolder,pSettingName: string);
    procedure ReadForm(pForm: TForm; pFormSettingsFolder, pSettingName: string);
    procedure DeleteComponents(pForm: TForm);
    procedure SettingsToComboBox;
    procedure AddEvents;
    procedure DelEvents;

    procedure SetComponentColor(pSender:TObject;pColor:TColor);
    procedure GetComponentColor(pSender:TObject;var pColor:TColor);

    function  GetDefaultSettingName(pFormSettingsFolder: string): string;

    function  SearchNextRepExt(pExt:string):string;
  public
    { Public declarations }
    function  Execute(pHead,pItem:TDataSet;pForm: TForm; pFormSettingsFolder, pFileNameMask, pFileExtensionMask: string): integer;
    procedure EndExecute;
    procedure LoadSetting(pForm: TForm; pFormSettingsFolder, pSettingName: string);
    procedure LoadDefaultSetting(pForm: TForm; pFormSettingsFolder: string);
    procedure ControlMouseDown(Sender: TObject; Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
    procedure ControlMouseMove(Sender: TObject; Shift: TShiftState; X, Y: Integer);
    procedure ControlMouseUp(Sender: TObject; Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
    procedure ControlClick(Sender: TObject);
    procedure ControlKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure ControlKeyPress(Sender: TObject; var Key: Char);
    procedure ControlKeyUp(Sender: TObject; var Key: Word; Shift: TShiftState);

    function  GetFreeName(pForm: TForm; pName: string): string;

  end;


var
  F_RepManager: TF_RepManager;

implementation

{$R *.DFM}
procedure TF_RepManager.ControlClick(Sender: TObject);
begin
  oSender:=Sender;
  If oSender<>NIL then begin
    Properties1Click (Self);
    (oSender as TWinControl).SetFocus;
  end;
end;

procedure TF_RepManager.ControlKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
begin
  inherited;
end;

procedure TF_RepManager.ControlKeyPress(Sender: TObject; var Key: Char);
begin
  beep;
end;

procedure TF_RepManager.ControlKeyUp(Sender: TObject; var Key: Word; Shift: TShiftState);
begin
  If (oSender<>NIL) then begin
    case key of
      Vk_Delete: begin
                   oDeleteComponent:=TRUE;
                 end;
      vk_Left : (oSender as TWinControl).Left:=(oSender as TWinControl).Left-1;
      vk_Right: (oSender as TWinControl).Left:=(oSender as TWinControl).Left+1;
      vk_Up   : (oSender as TWinControl).Top :=(oSender as TWinControl).Top-1;
      vk_Down : (oSender as TWinControl).Top :=(oSender as TWinControl).Top+1;
       else inherited;
    end;
  end;
end;

procedure TF_RepManager.ControlMouseUp(Sender: TObject; Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
  begin
    case oAction of
      cMOVE: begin
        if oMoveComponent<>nil then oMoveComponent := nil;
      end;
      cSIZE: begin
        if oMoveComponent<>nil then oMoveComponent := nil;
      end;
    end;
    oDown:=FALSE;
  end;

procedure TF_RepManager.ControlMouseDown(Sender: TObject;
  Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
var
  mLabel: Tlabel;
  mShape: TShape;
  mEdit : TEdit;
  mPageControl: TPageControl;
  mTabSheet: TTabSheet;
  mQuickRep: TIcQuickRep;
  mQRBand: TIcQRBand;
  mQRChildBand: TIcQRChildBand;
  mQRLabel: TIcQRLabel;
  mQRDBText: TIcQRDBText;
  mQRExpr: TIcQRExpr;
  mQRSysData: TIcQRSysData;
  mQRShape: TIcQRShape;
  mColor:TColor;
begin
  if not (Sender is TControl) then exit;
  If Assigned(oSender) then begin
    SetComponentColor(oSender,oColor);
  end;
  oSender:=Sender;

  if (Button = mbRight) then begin
     PM_.Popup(oMouse.CursorPos.x, oMouse.CursorPos.y);
  end else if SB_NewTabSheet.Down then begin
    if (Sender is TPageControl) then begin
      mTabSheet := CreateTabSheet(oForm, (Sender as TWinControl), '',
        'Caption=TabSheet');

      mTabSheet.PageControl := (Sender as TPageControl);
      mTabSheet.OnMouseDown := ControlMouseDown;
      mTabSheet.OnMouseMove := ControlMouseMove;
      mTabSheet.OnMouseUp   := ControlMouseUp;
{      mTabSheet.OnClick     := ControlClick;
      mTabSheet.OnKeyDown   := ControlKeyDown;
      mTabSheet.OnKeyPress  := ControlKeyPress;
      mTabSheet.OnkeyUp     := ControlKeyUp;
}    end;
  end else if SB_NewPageControl.Down then begin
    if (Sender is TWinControl) then begin
      mPageControl := CreatePageControl(oForm, (Sender as TWinControl), '',
        'Left='+IntToStr(X)+';'+
        'Top='+IntToStr(Y)+';'+
        'Align=alNone');

      mPageControl.OnMouseDown := ControlMouseDown;
      mPageControl.OnMouseMove := ControlMouseMove;
      mPageControl.OnMouseUp   := ControlMouseUp;
{     mPageControl.OnClick     := ControlClick;
      mPageControl.OnKeyDown   := ControlKeyDown;
      mPageControl.OnKeyPress  := ControlKeyPress;
      mPageControl.OnkeyUp     := ControlKeyUp;
}
      mTabSheet := CreateTabSheet(oForm, (Sender as TWinControl), '',
        'Caption=TabSheet');

      mTabSheet.PageControl := mPageControl;
      mTabSheet.OnMouseDown := ControlMouseDown;
      mTabSheet.OnMouseMove := ControlMouseMove;
      mTabSheet.OnMouseUp   := ControlMouseUp;
{     mTabSheet.OnClick     := ControlClick;
      mTabSheet.OnKeyDown   := ControlKeyDown;
      mTabSheet.OnKeyPress  := ControlKeyPress;
      mTabSheet.OnkeyUp     := ControlKeyUp;
}   end;
  end else if SB_NewLabel.Down then begin
    if (Sender is TWinControl) then begin
      mLabel := CreateLabel(oForm, (Sender as TWinControl), '',
        'Left='+IntToStr(X)+';'+
        'Top='+IntToStr(Y)+';'+
        'Caption=NewText');

      mLabel.OnMouseDown := ControlMouseDown;
      mLabel.OnMouseMove := ControlMouseMove;
      mLabel.OnMouseUp   := ControlMouseUp;
      mLabel.OnClick     := ControlClick;
//    mLabel.OnKeyDown   := ControlKeyDown;
//    mLabel.OnKeyPress  := ControlKeyPress;
//    mLabel.OnkeyUp     := ControlKeyUp;
    end;
  end else if SB_NewEdit.Down then begin
    if (Sender is TWinControl) then begin
      mEdit := CreateEdit(oForm, (Sender as TWinControl), '',
        'Left='+IntToStr(X)+';'+
        'Top='+IntToStr(Y)+';'+
        'Text=NewText');

      mEdit.OnMouseDown := ControlMouseDown;
      mEdit.OnMouseMove := ControlMouseMove;
      mEdit.OnMouseUp   := ControlMouseUp;
      mEdit.OnClick     := ControlClick;
      mEdit.OnKeyDown   := ControlKeyDown;
      mEdit.OnKeyPress  := ControlKeyPress;
      mEdit.OnkeyUp     := ControlKeyUp;
    end;
  end else if SB_NewShape.Down or SB_NewVerLine.Down or SB_NewHorLine.Down then begin
    if (Sender is TWinControl) then begin
      mShape := CreateShape(oForm, (Sender as TWinControl), '',
        'Left='+IntToStr(X)+';'+
        'Top='+IntToStr(Y)+';'+
        'Pen.Width=0;'+
        'Brush.Color=clBlack');

      if SB_NewVerLine.Down then begin
        mShape.Width := 3;
        mShape.Height := 200;
      end;
      if SB_NewHorLine.Down then begin
        mShape.Width := 200;
        mShape.Height := 3;
      end;
      mShape.OnMouseDown := ControlMouseDown;
      mShape.OnMouseMove := ControlMouseMove;
      mShape.OnMouseUp   := ControlMouseUp;
{      mShape.OnClick     := ControlClick;
      mShape.OnKeyDown   := ControlKeyDown;
      mShape.OnKeyPress  := ControlKeyPress;
      mShape.OnkeyUp     := ControlKeyUp;
}    end;
  end else if SB_MoveComponent.Down then begin
    if oMoveComponent=nil then begin
      oMoveComponent := Sender;oSelectComponent:=Sender;
      oMoveComponentLeft := X;
      oMoveComponentTop  := Y;
    end else oMoveComponent := nil;
  end else if SB_ResizeComponent.Down then begin
    if oMoveComponent=nil then begin
      oMoveComponent := Sender;oSelectComponent:=Sender;
      oMoveComponentLeft := X;
      oMoveComponentTop  := Y;
    end else oMoveComponent := nil;

  end else if SB_NewQuickRep.Down then begin
    if (Sender is TWinControl) then begin
      mQuickRep := TIcQuickRep.Create(oForm);
      mQuickRep.Parent := (Sender as TWinControl);
      mQuickRep.Name := GetFreeName(oForm,'QuickRep');
      mQuickRep.Left := X;
      mQuickRep.Top := Y;
      mQuickRep.OnMouseDown := ControlMouseDown;
      mQuickRep.OnMouseMove := ControlMouseMove;
      mQuickRep.OnMouseUp   := ControlMouseUp;
      mQuickRep.OnClick     := ControlClick;
      mQuickRep.OnKeyDown   := ControlKeyDown;
      mQuickRep.OnKeyPress  := ControlKeyPress;
      mQuickRep.OnkeyUp     := ControlKeyUp;
    end;

  end else if SB_NewQRBand.Down then begin
    if (Sender is TWinControl) then begin
      mQRBand := TIcQRBand.Create(oForm);
      mQRBand.Parent := (Sender as TWinControl);
      mQRBand.Name   := GetFreeName(oForm,'QRBand');
      mQRBand.Left := X;
      mQRBand.Top  := Y;
      mQRBand.OnMouseDown := ControlMouseDown;
      mQRBand.OnMouseMove := ControlMouseMove;
      mQRBand.OnMouseUp   := ControlMouseUp;
      mQRBand.OnClick     := ControlClick;
      mQRBand.OnKeyDown   := ControlKeyDown;
      mQRBand.OnKeyPress  := ControlKeyPress;
      mQRBand.OnkeyUp     := ControlKeyUp;
      mQRBand.Color       := clWhite;
//      oSender:=mQRBand;
    end;

  end else if SB_NewQRChildBand.Down then begin
    if (Sender is TWinControl) then begin
      mQRChildBand := TIcQRChildBand.Create(oForm);
      mQRChildBand.Parent := (Sender as TWinControl);
      mQRChildBand.Name   := GetFreeName(oForm,'QRCildBand');
      mQRChildBand.Left := X;
      mQRChildBand.Top  := Y;
      mQRChildBand.OnMouseDown := ControlMouseDown;
      mQRChildBand.OnMouseMove := ControlMouseMove;
      mQRChildBand.OnMouseUp   := ControlMouseUp;
      mQRChildBand.OnClick     := ControlClick;
      mQRChildBand.OnKeyDown   := ControlKeyDown;
      mQRChildBand.OnKeyPress  := ControlKeyPress;
      mQRChildBand.OnkeyUp     := ControlKeyUp;
      mQRChildBand.Color       := clWhite;
//      oSender:=mQRChildBand;
    end;

  end else if SB_NewQRLabel.Down then begin
    if (Sender is TWinControl) then begin
      mQRLabel := TIcQRLabel.Create(oForm);
      If Sender is TIcQRShape then begin
        mQRLabel.Parent := ((Sender as TIcQRShape).parent as TWinControl);
        mQRLabel.Left := X + (Sender as TIcQRShape).Left;
        mQRLabel.Top  := Y + (Sender as TIcQRShape).Top;
      end else begin
        mQRLabel.Parent :=  (Sender as TWinControl);
        mQRLabel.Left := X;
        mQRLabel.Top  := Y;
      end;
      mQRLabel.Name   := GetFreeName(oForm,'QRLabel');
      mQRLabel.Height := 20;
      mQRLabel.OnMouseDown := ControlMouseDown;
      mQRLabel.OnMouseMove := ControlMouseMove;
      mQRLabel.OnMouseUp   := ControlMouseUp;
      mQRLabel.OnClick     := ControlClick;
      mQRLabel.OnKeyDown   := ControlKeyDown;
      mQRLabel.OnKeyPress  := ControlKeyPress;
      mQRLabel.OnkeyUp     := ControlKeyUp;
      mQRLabel.Color       := clWhite;
      mQRLabel.AutoSize    := FALSE;
//      oSender := mQRLabel;
    end;

  end else if SB_NewQRDBText.Down then begin
    if (Sender is TWinControl) then begin
      mQRDBText := TIcQRDBText.Create(oForm);
      If Sender is TIcQRShape then begin
        mQRDBText.Parent := ((Sender as TIcQRShape).parent as TWinControl);
        mQRDBText.Left := X + (Sender as TIcQRShape).Left;
        mQRDBText.Top  := Y + (Sender as TIcQRShape).Top;
      end else begin
        mQRDBText.Parent :=  (Sender as TWinControl);
        mQRDBText.Left := X;
        mQRDBText.Top  := Y;
      end;
      mQRDBText.Name   := GetFreeName(oForm,'QRDBText');
      mQRDBText.OnMouseDown := ControlMouseDown;
      mQRDBText.OnMouseMove := ControlMouseMove;
      mQRDBText.OnMouseUp   := ControlMouseUp;
      mQRDBText.OnClick     := ControlClick;
      mQRDBText.OnKeyDown   := ControlKeyDown;
      mQRDBText.OnKeyPress  := ControlKeyPress;
      mQRDBText.OnkeyUp     := ControlKeyUp;
      mQRDBText.Color       := clWhite;
      mQRDBText.DataSet     := oItemDataSet;
      mQRDBText.DataField   := oItemDataSet.Fields[0].FieldName;
      mQRDBText.AutoSize    := FALSE;
//      oSender := mQRDBText;
    end;

  end else if SB_NewQRExpr.Down then begin
    if (Sender is TWinControl) then begin
      mQRExpr := TIcQRExpr.Create(oForm);
      If Sender is TIcQRShape then begin
        mQRExpr.Parent := ((Sender as TIcQRShape).parent as TWinControl);
        mQRExpr.Left := X + (Sender as TIcQRShape).Left;
        mQRExpr.Top  := Y + (Sender as TIcQRShape).Top;
      end else begin
        mQRExpr.Parent :=  (Sender as TWinControl);
        mQRExpr.Left := X;
        mQRExpr.Top  := Y;
      end;
      mQRExpr.Name   := GetFreeName(oForm,'QRExpr');
      mQRExpr.OnMouseDown := ControlMouseDown;
      mQRExpr.OnMouseMove := ControlMouseMove;
      mQRExpr.OnMouseUp   := ControlMouseUp;
      mQRExpr.OnClick     := ControlClick;
      mQRExpr.OnKeyDown   := ControlKeyDown;
      mQRExpr.OnKeyPress  := ControlKeyPress;
      mQRExpr.OnkeyUp     := ControlKeyUp;
      mQRExpr.Color       := clWhite;
      mQRExpr.AutoSize    := FALSE;
//      oSender := mQRExpr;
    end;

  end else if SB_NewQRSysData.Down then begin
    if (Sender is TWinControl) then begin
      mQRSysData := TIcQRSysData.Create(oForm);
      If Sender is TIcQRShape then begin
        mQRSysData.Parent := ((Sender as TIcQRShape).parent as TWinControl);
        mQRSysData.Left := X + (Sender as TIcQRShape).Left;
        mQRSysData.Top  := Y + (Sender as TIcQRShape).Top;
      end else begin
        mQRSysData.Parent :=  (Sender as TWinControl);
        mQRSysData.Left := X;
        mQRSysData.Top  := Y;
      end;
      mQRSysData.Name   := GetFreeName(oForm,'QRSysData');
      mQRSysData.OnMouseDown := ControlMouseDown;
      mQRSysData.OnMouseMove := ControlMouseMove;
      mQRSysData.OnMouseUp   := ControlMouseUp;
      mQRSysData.OnClick     := ControlClick;
      mQRSysData.OnKeyDown   := ControlKeyDown;
      mQRSysData.OnKeyPress  := ControlKeyPress;
      mQRSysData.OnkeyUp     := ControlKeyUp;
      mQRSysData.Color       := clWhite;
      mQRSysData.AutoSize    := FALSE;
//      oSender := mQRSysData;
    end;

  end else if SB_NewQRShape.Down then begin
    if (Sender is TWinControl) then begin
      mQRShape := TIcQRShape.Create(oForm);
      If Sender is TIcQRShape then begin
        mQRShape.Parent := ((Sender as TIcQRShape).parent as TWinControl);
        mQRShape.Left := X + (Sender as TIcQRShape).Left;
        mQRShape.Top  := Y + (Sender as TIcQRShape).Top;
      end else begin
        mQRShape.Parent :=  (Sender as TWinControl);
        mQRShape.Left := X;
        mQRShape.Top  := Y;
      end;
      mQRShape.Name   := GetFreeName(oForm,'QRShape');
      mQRShape.OnMouseDown := ControlMouseDown;
      mQRShape.OnMouseMove := ControlMouseMove;
      mQRShape.OnMouseUp   := ControlMouseUp;
      mQRShape.OnClick     := ControlClick;
      mQRShape.OnKeyDown   := ControlKeyDown;
      mQRShape.OnKeyPress  := ControlKeyPress;
      mQRShape.OnkeyUp     := ControlKeyUp;
      mQRShape.Brush.Color := clWhite;
      mQRShape.SendToBack;
//      oSender:=mQRShape;
    end;
  end;

  GetComponentColor(oSender,oColor);
  SetComponentColor(oSender,clAqua);

  oDown:=TRUE;

  if not SB_ResizeComponent.Down then begin
    SB_MoveComponent.Down := TRUE;
    SB_NewLabelClick(SB_MoveComponent);
  end;
end;

function  TF_RepManager.GetDefaultSettingName(pFormSettingsFolder: string): string;
  begin
    Result := 'Default';
  end;

procedure TF_RepManager.LoadSetting(pForm: TForm; pFormSettingsFolder, pSettingName: string);
  begin
    if FileExists(pFormSettingsFolder + '\' + pSettingName) then begin
      oForm := pForm;
      DeleteComponents(pForm);
      ReadForm(pForm, pFormSettingsFolder, pSettingName);
      AddEvents;  //Itt majd olyan hivas legyen ahol szerepel a pForm paramete !!!
    end;
  end;

procedure TF_RepManager.LoadDefaultSetting(pForm: TForm; pFormSettingsFolder: string);
  begin
    oForm := pForm;
    oFormSettingsFolder := pFormSettingsFolder;
    LoadSetting(pForm, pFormSettingsFolder, GetDefaultsettingName(pFormSettingsFolder));
    CB_SettingNames.Text := GetDefaultsettingName(pFormSettingsFolder);
  end;

function  TF_RepManager.GetFreeName(pForm: TForm; pName: string): string;
  var
    i: integer;
  begin
    i := 1;
    while pForm.FindComponent(pName + IntToStr(i)) <> nil do inc(i);
    GetFreeName := pName + IntToStr(i);
  end;

procedure TF_RepManager.ControlMouseMove(Sender: TObject;
  Shift: TShiftState; X, Y: Integer);
var mL:byte;
  mCursor:TCursor;
  mNew:integer;
  mCT:integer;
begin
(*
  if Sender=nil then exit;
  case oAction of
    cMove: if (oMoveComponent = Sender) then begin
             (oMoveComponent as TControl).Left := (oMoveComponent as TControl).Left+X-oMoveComponentLeft;
             (oMoveComponent as TControl).Top := (oMoveComponent as TControl).Top+Y-oMoveComponentTop;
           end;
    cSize: if (oMoveComponent = Sender) then begin
             (oMoveComponent as TControl).Width  := (oMoveComponent as TControl).Width +X-oMoveComponentLeft;
             (oMoveComponent as TControl).Height := (oMoveComponent as TControl).Height+Y-oMoveComponentTop;
             oMoveComponentLeft:=X;oMoveComponentTop:=Y;
           end;
  end;
*)
  If oSelectComponent=Sender then begin
    If not oDown then begin
      mCursor:=crDefault;
      oCurType:=0;
      If X<cBorderSize then begin // left
        mCursor:=crSizeWE;oCurType:=1;
      end else If X>(Sender as TControl).Width-(5+cBorderSize) then begin // right
        mCursor:=crSizeWE;oCurType:=2;
      end;
      If Y<cBorderSize then begin // TOP
        case oCurType of
          0: mCursor:=crSizeNS;   // center
          1: mCursor:=crSizeNWSE; // left
          2: mCursor:=crSizeNESW; // right
        end;
        Inc(oCurType,10);
      end else If Y>(Sender as TControl).height-(5+cBorderSize) then begin // bottom
        case oCurType of
          0: mCursor:=crSizeNS;   // center
          1: mCursor:=crSizeNESW; // left
          2: mCursor:=crSizeNWSE; // right
        end;
        Inc(oCurType,20);
      end;
      If mCursor<> (Sender as TControl).Cursor then (Sender as TControl).Cursor:=mCursor;
    end else begin
      If ((Sender as TControl).Cursor = crSizeNWSE)or ((Sender as TControl).Cursor = crSIZENESW) or ((Sender as TControl).Cursor = crSIZENS) then begin
        mNew:=Y-oMoveComponentTop;
        If oCurType<20 then begin
          (Sender as TControl).Top   := (Sender as TControl).Top   +mNew;
          (Sender as TControl).Height:= (Sender as TControl).Height-mNew;
        end else begin
        // oCurType>=20 then begin
          (Sender as TControl).Height:= (Sender as TControl).Height+mNew;
        end;
        oMoveComponentTop:=Y;
      end;
      If ((Sender as TControl).Cursor = crSizeNWSE)or ((Sender as TControl).Cursor = crSIZENESW) or ((Sender as TControl).Cursor = crSIZEWE) then begin
        mCT:=oCurType mod 10;
        mNew:=X-oMoveComponentLeft;
        If mCT=1 then begin
          (Sender as TControl).Left :=  (Sender as TControl).Left+ mNew;
          (Sender as TControl).Width := (Sender as TControl).Width-mNew;
        end else begin
          (Sender as TControl).Width := (Sender as TControl).Width+mNew;
        end;
        oMoveComponentLeft:=X;
      end;
      If ((Sender as TControl).Cursor > -6)or((Sender as TControl).Cursor < -9) then begin
        (Sender as TControl).Left := (Sender as TControl).Left+X-oMoveComponentLeft;
        (Sender as TControl).Top  := (Sender as TControl).Top +Y-oMoveComponentTop;
     end;
    end;
  end;
end;

procedure TF_RepManager.EndExecute;
begin
//  SetWindowPos(Self.Handle, HWND_NoTOPMOST, Left, Top,Width, Height, 0);
  Hide;
end;

function  TF_RepManager.Execute(pHead,pItem:TDataSet;pForm: TForm; pFormSettingsFolder, pFileNameMask, pFileExtensionMask: string): integer;
var i:integer;
  begin
    oDeleteComponent:=FALSE;
    oHeadDataSet:=pHead;oItemDataSet:=pItem;
    oSender:=NIL;
    oColor:=clWhite;
//    SetWindowPos(Self.Handle, HWND_TOPMOST, Self.Left, Self.Top,Self.Width, Self.Height, 0);
    oExecute := 0;
    oForm := pForm;
    AddEvents;
    if pFormSettingsFolder = ''
      then oFormSettingsFolder := ExtractFilePath(Application.ExeName)
      else oFormSettingsFolder := pFormSettingsFolder;
    if oFormSettingsFolder[length(oFormSettingsFolder)] = '\' then delete(oFormSettingsFolder,length(oFormSettingsFolder),1);

    oFileNameMask       := pFileNameMask;
    oFileExtensionMask  := pFileExtensionMask;

    ForceDirectories(oFormSettingsFolder);
    L_FormSettingsFolder.Caption := oFormSettingsFolder;
    SettingsToComboBox;
    i:=0;
    while (i<oReports.Count-1) and (oReports[i]<>GVSys.lastRepExt) do begin
       Inc (I);
    end;
    CB_SettingNames.ItemIndex := I;

    Caption := 'Form manager ('+oForm.Caption+')';
    Show;
    Execute := oExecute;
  end;

procedure TF_RepManager.AddEvents;
  var
    i: integer;
  begin
    if oForm = nil then exit;
    if (oForm.ComponentCount>0) then begin
      for i := 0 to oForm.ComponentCount-1 do begin
        // Standard Components
        if oForm.Components[i] is TButton then with (oForm.Components[i] as TButton) do begin
          if not Assigned(OnMouseDown)  then OnMouseDown := ControlMouseDown;
          if not Assigned(OnMouseMove)  then OnMouseMove := ControlMouseMove;
          if not Assigned(OnMouseUp)    then OnMouseUp   := ControlMouseUp;
          if not Assigned(OnClick)      then OnClick     := ControlClick;
//          if not Assigned(OnKeyDown)    then OnKeyDown   := ControlKeyDown;
//          if not Assigned(OnKeyPress)   then OnKeyPress  := ControlKeyPress;
//          if not Assigned(OnKeyUp)      then OnKeyUp     := ControlKeyUp;
        end;
        if oForm.Components[i] is TLabel then with (oForm.Components[i] as TLabel) do begin
          if not Assigned(OnMouseDown)  then OnMouseDown := ControlMouseDown;
          if not Assigned(OnMouseMove)  then OnMouseMove := ControlMouseMove;
          if not Assigned(OnMouseUp)    then OnMouseUp   := ControlMouseUp;
          if not Assigned(OnClick)      then OnClick     := ControlClick;
//          if not Assigned(OnKeyDown)    then OnKeyDown   := ControlKeyDown;
//          if not Assigned(OnKeyPress)   then OnKeyPress  := ControlKeyPress;
//          if not Assigned(OnKeyUp)      then OnKeyUp     := ControlKeyUp;
        end;
        if oForm.Components[i] is TShape then with (oForm.Components[i] as TShape) do begin
          if not Assigned(OnMouseDown)  then OnMouseDown := ControlMouseDown;
          if not Assigned(OnMouseMove)  then OnMouseMove := ControlMouseMove;
          if not Assigned(OnMouseUp)    then OnMouseUp   := ControlMouseUp;
          if not Assigned(OnClick)      then OnClick     := ControlClick;
//          if not Assigned(OnKeyDown)    then OnKeyDown   := ControlKeyDown;
//          if not Assigned(OnKeyPress)   then OnKeyPress  := ControlKeyPress;
//          if not Assigned(OnKeyUp)      then OnKeyUp     := ControlKeyUp;
        end;
        if oForm.Components[i] is TPanel then with (oForm.Components[i] as TPanel) do begin
          if not Assigned(OnMouseDown)  then OnMouseDown := ControlMouseDown;
          if not Assigned(OnMouseMove)  then OnMouseMove := ControlMouseMove;
          if not Assigned(OnMouseUp)    then OnMouseUp   := ControlMouseUp;
          if not Assigned(OnClick)      then OnClick     := ControlClick;
//          if not Assigned(OnKeyDown)    then OnKeyDown   := ControlKeyDown;
//          if not Assigned(OnKeyPress)   then OnKeyPress  := ControlKeyPress;
//          if not Assigned(OnKeyUp)      then OnKeyUp     := ControlKeyUp;
        end;
        if oForm.Components[i] is TEdit then with (oForm.Components[i] as TEdit) do begin
          if not Assigned(OnMouseDown)  then OnMouseDown := ControlMouseDown;
          if not Assigned(OnMouseMove)  then OnMouseMove := ControlMouseMove;
          if not Assigned(OnMouseUp)    then OnMouseUp   := ControlMouseUp;
          if not Assigned(OnClick)      then OnClick     := ControlClick;
//          if not Assigned(OnKeyDown)    then OnKeyDown   := ControlKeyDown;
//          if not Assigned(OnKeyPress)   then OnKeyPress  := ControlKeyPress;
//          if not Assigned(OnKeyUp)      then OnKeyUp     := ControlKeyUp;
        end;
        if oForm.Components[i] is TPageControl then with (oForm.Components[i] as TPageControl) do begin
          if not Assigned(OnMouseDown)  then OnMouseDown := ControlMouseDown;
          if not Assigned(OnMouseMove)  then OnMouseMove := ControlMouseMove;
          if not Assigned(OnMouseUp)    then OnMouseUp   := ControlMouseUp;
          if not Assigned(OnClick)      then OnClick     := ControlClick;
//          if not Assigned(OnKeyDown)    then OnKeyDown   := ControlKeyDown;
//          if not Assigned(OnKeyPress)   then OnKeyPress  := ControlKeyPress;
//          if not Assigned(OnKeyUp)      then OnKeyUp     := ControlKeyUp;
        end;
        if oForm.Components[i] is TTabSheet then with (oForm.Components[i] as TTabSheet) do begin
          if not Assigned(OnMouseDown)  then OnMouseDown := ControlMouseDown;
          if not Assigned(OnMouseMove)  then OnMouseMove := ControlMouseMove;
          if not Assigned(OnMouseUp)    then OnMouseUp   := ControlMouseUp;
          if not Assigned(OnClick)      then OnClick     := ControlClick;
//          if not Assigned(OnKeyDown)    then OnKeyDown   := ControlKeyDown;
//          if not Assigned(OnKeyPress)   then OnKeyPress  := ControlKeyPress;
//          if not Assigned(OnKeyUp)      then OnKeyUp     := ControlKeyUp;
        end;

        //QuickRep components
        if oForm.Components[i] is TIcQuickRep then with (oForm.Components[i] as TIcQuickRep) do begin
          if not Assigned(OnMouseDown)  then OnMouseDown := ControlMouseDown;
          if not Assigned(OnMouseMove)  then OnMouseMove := ControlMouseMove;
          if not Assigned(OnMouseUp)    then OnMouseUp   := ControlMouseUp;
          if not Assigned(OnClick)      then OnClick     := ControlClick;
          if not Assigned(OnKeyDown)    then OnKeyDown   := ControlKeyDown;
          if not Assigned(OnKeyPress)   then OnKeyPress  := ControlKeyPress;
          if not Assigned(OnKeyUp)      then OnKeyUp     := ControlKeyUp;
        end;
        if oForm.Components[i] is TIcQRBand then with (oForm.Components[i] as TIcQRBand) do begin
          if not Assigned(OnMouseDown)  then OnMouseDown := ControlMouseDown;
          if not Assigned(OnMouseMove)  then OnMouseMove := ControlMouseMove;
          if not Assigned(OnMouseUp)    then OnMouseUp   := ControlMouseUp;
          if not Assigned(OnClick)      then OnClick     := ControlClick;
          if not Assigned(OnKeyDown)    then OnKeyDown   := ControlKeyDown;
          if not Assigned(OnKeyPress)   then OnKeyPress  := ControlKeyPress;
          if not Assigned(OnKeyUp)      then OnKeyUp     := ControlKeyUp;
        end;
        if oForm.Components[i] is TIcQRChildBand then with (oForm.Components[i] as TIcQRChildBand) do begin
          if not Assigned(OnMouseDown)  then OnMouseDown := ControlMouseDown;
          if not Assigned(OnMouseMove)  then OnMouseMove := ControlMouseMove;
          if not Assigned(OnMouseUp)    then OnMouseUp   := ControlMouseUp;
          if not Assigned(OnClick)      then OnClick     := ControlClick;
          if not Assigned(OnKeyDown)    then OnKeyDown   := ControlKeyDown;
          if not Assigned(OnKeyPress)   then OnKeyPress  := ControlKeyPress;
          if not Assigned(OnKeyUp)      then OnKeyUp     := ControlKeyUp;
        end;
        if oForm.Components[i] is TIcQRLabel then with (oForm.Components[i] as TIcQRLabel) do begin
          if not Assigned(OnMouseDown)  then OnMouseDown := ControlMouseDown;
          if not Assigned(OnMouseMove)  then OnMouseMove := ControlMouseMove;
          if not Assigned(OnMouseUp)    then OnMouseUp   := ControlMouseUp;
          if not Assigned(OnClick)      then OnClick     := ControlClick;
          if not Assigned(OnKeyDown)    then OnKeyDown   := ControlKeyDown;
          if not Assigned(OnKeyPress)   then OnKeyPress  := ControlKeyPress;
          if not Assigned(OnKeyUp)      then OnKeyUp     := ControlKeyUp;
        end;
        if oForm.Components[i] is TIcQRDBText then with (oForm.Components[i] as TIcQRDBText) do begin
          if not Assigned(OnMouseDown)  then OnMouseDown := ControlMouseDown;
          if not Assigned(OnMouseMove)  then OnMouseMove := ControlMouseMove;
          if not Assigned(OnMouseUp)    then OnMouseUp   := ControlMouseUp;
          if not Assigned(OnClick)      then OnClick     := ControlClick;
          if not Assigned(OnKeyDown)    then OnKeyDown   := ControlKeyDown;
          if not Assigned(OnKeyPress)   then OnKeyPress  := ControlKeyPress;
          if not Assigned(OnKeyUp)      then OnKeyUp     := ControlKeyUp;
        end;
        if oForm.Components[i] is TIcQRExpr then with (oForm.Components[i] as TIcQRExpr) do begin
          if not Assigned(OnMouseDown)  then OnMouseDown := ControlMouseDown;
          if not Assigned(OnMouseMove)  then OnMouseMove := ControlMouseMove;
          if not Assigned(OnMouseUp)    then OnMouseUp   := ControlMouseUp;
          if not Assigned(OnClick)      then OnClick     := ControlClick;
          if not Assigned(OnKeyDown)    then OnKeyDown   := ControlKeyDown;
          if not Assigned(OnKeyPress)   then OnKeyPress  := ControlKeyPress;
          if not Assigned(OnKeyUp)      then OnKeyUp     := ControlKeyUp;
        end;
        if oForm.Components[i] is TIcQRSysData then with (oForm.Components[i] as TIcQRSysData) do begin
          if not Assigned(OnMouseDown)  then OnMouseDown := ControlMouseDown;
          if not Assigned(OnMouseMove)  then OnMouseMove := ControlMouseMove;
          if not Assigned(OnMouseUp)    then OnMouseUp   := ControlMouseUp;
          if not Assigned(OnClick)      then OnClick     := ControlClick;
          if not Assigned(OnKeyDown)    then OnKeyDown   := ControlKeyDown;
          if not Assigned(OnKeyPress)   then OnKeyPress  := ControlKeyPress;
          if not Assigned(OnKeyUp)      then OnKeyUp     := ControlKeyUp;
        end;
        if oForm.Components[i] is TIcQRShape then with (oForm.Components[i] as TIcQRShape) do begin
          if not Assigned(OnMouseDown)  then OnMouseDown := ControlMouseDown;
          if not Assigned(OnMouseMove)  then OnMouseMove := ControlMouseMove;
          if not Assigned(OnMouseUp)    then OnMouseUp   := ControlMouseUp;
          if not Assigned(OnClick)      then OnClick     := ControlClick;
          if not Assigned(OnKeyDown)    then OnKeyDown   := ControlKeyDown;
          if not Assigned(OnKeyPress)   then OnKeyPress  := ControlKeyPress;
          if not Assigned(OnKeyUp)      then OnKeyUp     := ControlKeyUp;
        end;
      end;
    end;
//    if not Assigned(oForm.OnMouseMove) then oForm.OnMouseMove := FormMouseMove;
//    if not Assigned(oForm.OnMouseMove) then oForm.OnMouseMove := ControlMouseMove;
    if not Assigned(oForm.OnMouseDown) then oForm.OnMouseDown := ControlMouseDown;
  end;

procedure TF_RepManager.DelEvents;
  var
    i: integer;
  begin
    for i := 0 to oForm.ComponentCount-1 do begin
      if oForm.Components[i] is TLabel then begin
        if Assigned((oForm.Components[i] as TLabel).OnMouseDown)then (oForm.Components[i] as TLabel).OnMouseDown := nil;
        if Assigned((oForm.Components[i] as TLabel).OnMouseMove)then (oForm.Components[i] as TLabel).OnMouseMove := nil;
        if Assigned((oForm.Components[i] as TLabel).OnMouseUp)  then (oForm.Components[i] as TLabel).OnMouseUp   := nil;
        if Assigned((oForm.Components[i] as TLabel).OnClick)    then (oForm.Components[i] as TLabel).OnClick     := nil;
//        if Assigned((oForm.Components[i] as TLabel).OnKeyDown)  then (oForm.Components[i] as TLabel).OnKeyDown   := nil;
//        if Assigned((oForm.Components[i] as TLabel).OnKeyPress) then (oForm.Components[i] as TLabel).OnKeyPress  := nil;
//        if Assigned((oForm.Components[i] as TLabel).OnKeyUp)    then (oForm.Components[i] as TLabel).OnKeyUp     := nil;
      end;
      if oForm.Components[i] is TShape then begin
        if Assigned((oForm.Components[i] as TShape).OnMouseDown)then (oForm.Components[i] as TShape).OnMouseDown := nil;
        if Assigned((oForm.Components[i] as TShape).OnMouseMove)then (oForm.Components[i] as TShape).OnMouseMove := nil;
        if Assigned((oForm.Components[i] as TShape).OnMouseUp)  then (oForm.Components[i] as TShape).OnMouseUp   := nil;
//        if Assigned((oForm.Components[i] as TShape).OnClick)    then (oForm.Components[i] as TShape).OnClick     := nil;
//        if Assigned((oForm.Components[i] as TShape).OnKeyDown)  then (oForm.Components[i] as TShape).OnKeyDown   := nil;
//        if Assigned((oForm.Components[i] as TShape).OnKeyPress) then (oForm.Components[i] as TShape).OnKeyPress  := nil;
//        if Assigned((oForm.Components[i] as TShape).OnKeyUp)    then (oForm.Components[i] as TShape).OnKeyUp     := nil;
      end;
      if oForm.Components[i] is TEdit then begin
        if Assigned((oForm.Components[i] as TEdit).OnMouseDown) then (oForm.Components[i] as TEdit).OnMouseDown := nil;
        if Assigned((oForm.Components[i] as TEdit).OnMouseMove) then (oForm.Components[i] as TEdit).OnMouseMove := nil;
        if Assigned((oForm.Components[i] as TEdit).OnMouseUp)   then (oForm.Components[i] as TEdit).OnMouseUp := nil;
        if Assigned((oForm.Components[i] as TEdit).OnClick)     then (oForm.Components[i] as TEdit).OnClick     := nil;
        if Assigned((oForm.Components[i] as TEdit).OnKeyDown)   then (oForm.Components[i] as TEdit).OnKeyDown   := nil;
        if Assigned((oForm.Components[i] as TEdit).OnKeyPress)  then (oForm.Components[i] as TEdit).OnKeyPress  := nil;
        if Assigned((oForm.Components[i] as TEdit).OnKeyUp)     then (oForm.Components[i] as TEdit).OnKeyUp     := nil;
      end;

    end;
    if Assigned(oForm.OnMouseMove) then oForm.OnMouseMove := nil;
    if Assigned(oForm.OnMouseDown) then oForm.OnMouseDown := nil;
  end;

procedure TF_RepManager.DeleteComponents(pForm: TForm);
  begin
    pForm.DestroyComponents;
  end;


procedure TF_RepManager.SettingsToComboBox;
  var
    mSearchRec : TSearchRec;
    mItem: string;
  begin
    L_FormSettingsFolder.Caption := oFormSettingsFolder + '\' + oFileNameMask + '.' + oFileExtensionMask;
    CB_SettingNames.Items.Clear;
    oReports.Clear;
    if (0 = FindFirst(oFormSettingsFolder+'\'+oFilenamemask+'.'+oFileExtensionMask, faAnyFile-faVolumeID-faDirectory, mSearchRec)) then begin
      repeat
        mItem:=UpperCase(Copy(mSearchrec.Name,Pos('.',mSearchrec.Name)+1,255));
        If mItem[1]= 'Q' then begin
          AgyAppIni1.FileName:=oFormSettingsFolder + '\' + 'REPNAMEQ.SYS';
          AgyAppIni1.Section:=oFileNameMask;
          oReports.Add(mItem);
          mItem:=AgyAppIni1.ReadString(mItem,oForm.Caption);
          CB_SettingNames.Items.Add(mItem);
        end else If mItem[1]= 'U' then begin
          AgyAppIni1.FileName:=oFormSettingsFolder + '\' + 'REPNAMEU.SYS';
          AgyAppIni1.Section:=oFileNameMask;
          oReports.Add(mItem);
          mItem:=AgyAppIni1.ReadString(mItem,oForm.Caption);
          CB_SettingNames.Items.Add(mItem);
        end;
      until (FindNext(mSearchRec) <> 0);
    end;
    FindClose(mSearchRec);
  end;

procedure TF_RepManager.WriteForm(pForm: TForm; pFormSettingsFolder, pSettingName: string);
  begin
    SetComponentColor(oSender,oColor);
    WriteComponentResFile(pFormSettingsFolder + '\' + pSettingName, pForm);
    SetComponentColor(oSender,clAqua);
  end;


procedure TF_RepManager.ReadForm(pForm: TForm; pFormSettingsFolder, pSettingName: string);
  begin
    ReadComponentResFile(pFormSettingsFolder + '\' + pSettingName, pForm);
  end;

function  TF_RepManager.SearchNextRepExt;
var i:byte;
begin
  i:=0;
  while (i<99) and FileExists(oFormSettingsFolder + '\' + oFileNameMask+'.'+pExt+ StrIntZero(i,2))
    do Inc (I);
  Result:=pExt+StrIntZero(I,2)
end;

procedure TF_RepManager.BB_SaveClick(Sender: TObject);
var
  mname,mSettingName: string;
  mI:integer;
begin
  mSettingName := CB_SettingNames.Text;
//  if InputQuery('Save form', 'Save form ...', mSettingName) then begin
    mI:= CB_SettingNames.ItemIndex;
    CB_SettingNames.Items[mI]:=mSettingName;
    CB_SettingNames.ItemIndex:=mI;
    mname:=oReports[mI];
    If mName[1]='Q'
      then AgyAppIni1.FileName:=oFormSettingsFolder + '\' + 'REPNAMEQ.SYS'
      else AgyAppIni1.FileName:=oFormSettingsFolder + '\' + 'REPNAMEU.SYS';
    AgyAppIni1.Section:=oFileNameMask;
    AgyAppIni1.WriteString(mName,mSettingname);
    mname:=oFileNameMask+'.'+mName;
    WriteForm(oForm, oFormSettingsFolder, mname);
    CB_SettingNames.Text := mSettingName;
//  end;
end;

procedure TF_RepManager.BB_SaveAsClick(Sender: TObject);
var
  mname,mSettingName: string;
begin
  mSettingName := CB_SettingNames.Text;
  if InputQuery('Save form as', 'Save form as ...', mSettingName) then begin
    CB_SettingNames.Items.Add(mSettingName);
    mName:=SearchNextRepExt('Q');
    oReports.add(mname);
    If mname[1]= 'Q'
      then AgyAppIni1.FileName:=oFormSettingsFolder + '\' + 'REPNAMEQ.SYS'
      else AgyAppIni1.FileName:=oFormSettingsFolder + '\' + 'REPNAMEU.SYS';
    AgyAppIni1.Section:=oFileNameMask;
    AgyAppIni1.WriteString(mName,mSettingname);
    mname:=oFileNameMask+'.'+mName;
    WriteForm(oForm, oFormSettingsFolder, mname);
    CB_SettingNames.Text := mSettingName;
  end;
end;

procedure TF_RepManager.BB_DeleteClick(Sender: TObject);
var
  mName : string;
begin
  If AskYes (0200010,'') then begin
    mName:=oFileNameMask+'.'+oReports[CB_SettingNames.ItemIndex];
    if FileExists(oFormSettingsFolder+'\'+mName) then begin
      DeleteFile(oFormSettingsFolder+'\'+mName);
    end;
    SettingsToComboBox;
    CB_SettingNames.Text := '';
  end;
end;

procedure TF_RepManager.SB_NewLabelClick(Sender: TObject);
begin
  if      (Sender as TSpeedButton).Name = 'SB_NewLabel'            then oAction := cAddLabel
  else if (Sender as TSpeedButton).Name = 'SB_NewTabSheet'         then oAction := cAddTabSheet
  else if (Sender as TSpeedButton).Name = 'SB_NewPageControl'      then oAction := cAddPageControl
  else if (Sender as TSpeedButton).Name = 'SB_NewEdit'             then oAction := cAddEdit
  else if (Sender as TSpeedButton).Name = 'SB_NewVerLine'          then oAction := cAddVertLine
  else if (Sender as TSpeedButton).Name = 'SB_NewHorLine'          then oAction := cAddHorLine
  else if (Sender as TSpeedButton).Name = 'SB_NewShape'            then oAction := cAddShape
  else if (Sender as TSpeedButton).Name = 'SB_MoveComponent'       then oAction := cMove
  else if (Sender as TSpeedButton).Name = 'SB_ResizeComponent'     then oAction := cSize;

  L_AddComponent.Caption := (Sender as TSpeedButton).Hint;
end;

procedure TF_RepManager.CB_SettingNamesClick(Sender: TObject);
var
  mName : string;
begin
  mName:=oFileNameMask+'.'+oReports[CB_SettingNames.ItemIndex];
  LoadSetting(oForm, oFormSettingsFolder, mName);
  gvSys.lastRepExt:=Copy(mname,Pos('.',mName)+1,255);
//  CB_SettingNames.Text := pSettingName;
end;

procedure TF_RepManager.FormCreate(Sender: TObject);
begin
  Left:=10;Top:=10;
  Show;
  Left:=10;Top:=10;
  PC_FManager.ActivePage := TabSheet2;
  oMouse := TMouse.Create;
  oReports := TStringList.Create;
  oFileNameMask := '*'; //1999.10.8.
  oFileExtensionMask := '*'; //1999.10.8.
  oAction:=cMove;
  if F_PropertiesEditor = nil then Application.CreateForm(TF_PropertiesEditor, F_PropertiesEditor);
  F_PropertiesEditor.Show;
end;

procedure TF_RepManager.FormActivate(Sender: TObject);
begin
  AddEvents;
end;

procedure TF_RepManager.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  DelEvents;
end;

procedure TF_RepManager.SetComponentColor;
begin
  If pSender Is TIcQRLabel   then (pSender as TIcQRLabel  ).color:=pColor;
  If pSender Is TIcQRDBText  then (pSender as TIcQRDBText ).color:=pColor;
  If pSender Is TIcQRExpr    then (pSender as TIcQRExpr   ).color:=pColor;
  If pSender Is TIcQRSysData then (pSender as TIcQRSysData).color:=pColor;
  If pSender Is TIcQRShape   then (pSender as TIcQRShape  ).Brush.color:=pColor;
  If pSender Is TIcQRBand    then (pSender as TIcQRBand   ).color:=pColor;
end;

procedure TF_RepManager.GetComponentColor;
begin
  If pSender Is TIcQRLabel   then pColor:=(pSender as TIcQRLabel  ).color;
  If pSender Is TIcQRDBText  then pColor:=(pSender as TIcQRDBText ).color;
  If pSender Is TIcQRExpr    then pColor:=(pSender as TIcQRExpr   ).color;
  If pSender Is TIcQRSysData then pColor:=(pSender as TIcQRSysData).color;
  If pSender Is TIcQRShape   then pColor:=(pSender as TIcQRShape).Brush.Color;
  If pSender Is TIcQRBand    then pColor:=(pSender as TIcQRBand   ).color;
end;

procedure TF_RepManager.Properties1Click(Sender: TObject);
var mColor:TColor;
begin
  if F_PropertiesEditor = nil then Application.CreateForm(TF_PropertiesEditor, F_PropertiesEditor);
  SetComponentColor(oSender,oColor);
  F_PropertiesEditor.Execute(oSender);
  GetComponentColor(oSender,oColor);
  SetComponentColor(oSender,clAqua);
end;

procedure TF_RepManager.FormDestroy(Sender: TObject);
begin
  oMouse.Free;
  oReports.Free;
end;

procedure TF_RepManager.DeleteComponent;
var
  mControl: TControl;
begin
  try
  if (oSender <> nil) and  not(oSender is TForm)  then begin
    if (oSender is TControl) then begin
      mControl := oForm.FindComponent((oSender as TControl).Name) as TControl;
      mControl.Visible := FALSE;
      oForm.RemoveComponent(mControl);
      mControl.Free;
      oSender:=NIL;
      oForm.Refresh;
    end;
  end;
  finally
  //
  end;
end;

procedure TF_RepManager.Delete1Click(Sender: TObject);
begin
  DeleteComponent;
end;

procedure TF_RepManager.BringToFront1Click(Sender: TObject);
begin
  if oSender is TControl then (oSender as TControl).BringToFront;
end;

procedure TF_RepManager.SendtoBack1Click(Sender: TObject);
begin
  if oSender is TControl then (oSender as TControl).SendToBack;
end;

procedure TF_RepManager.JB_FolderClick(Sender: TObject);
var
  mDir: string;
begin
  if SelectDirectory('Caption', '', mDir) then begin
    oFormSettingsFolder := mDir;
    SettingsToComboBox;
  end;
end;

procedure TF_RepManager.JB_ExtensionClick(Sender: TObject);
var
  mStr: string;
begin
  mStr := oFileExtensionMask;
  if InputQuery('Input Box', 'Prompt', mStr) then begin
    oFileExtensionMask := mStr;
    SettingsToComboBox;
  end;

end;

procedure TF_RepManager.JetButton3Click(Sender: TObject);
var
  mStr: string;
begin
  mStr := oFileNameMask;
  if InputQuery('Input Box', 'Prompt', mStr) then begin
    oFileNameMask := mStr;
    SettingsToComboBox;
  end;

end;

procedure TF_RepManager.PropplusClick(Sender: TObject);
begin
  Prop1.ExecuteProp(oSender, FALSE);
end;

procedure TF_RepManager.Button1Click(Sender: TObject);
begin
  If oSender<>NIL then Properties1Click (Self);
end;

procedure TF_RepManager.CancelButton1Click(Sender: TObject);
begin
  oForm.Close;
end;

procedure TF_RepManager.Timer1Timer(Sender: TObject);
begin
  If oDeleteComponent then begin
    Timer1.Enabled  := FALSE;
    DeleteComponent;
    Timer1.Enabled  := TRUE;
    oDeleteComponent:= False;
  end;
end;

end.
