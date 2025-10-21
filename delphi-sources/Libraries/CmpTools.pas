unit CmpTools;
//langform
interface

uses
  IcTools, FPTools, IcConv, BtrTools,
  Forms, Classes, Controls, Grids, SysUtils, DbGrids, StdCtrls,
  Messages, ComCtrls, ExtCtrls, Windows, Graphics, Buttons;

  procedure SpecKeyDownhandle (Sender: TObject; var Key: Word; Shift: TShiftState);

  //** Tools metods **//
  function  GetFreeComponentName(pForm: TForm; pName: string): string; //2000.1.20.
  function  GetNewComponentName(pForm:TForm; pName: string): string; //2000.12.1.
  procedure SetPropertyNameAndValue(pPropertyes: string; pI: integer; var pPropertyName, pPropertyVal: string); //2000.2.2.

  //** Property manipulation **//
  procedure SetProperty(pObject: TObject; pName, pValue: string);//2000.2.2.
  procedure SetPropertyes(pObject: TObject; pPropertyes: string);{pl. "Top=23;Left=45;Visible=TRUE"}//2000.2.2.

  //** Component creations **//
  function  CreateStringGrid(pOwner: TComponent; pParent: TWinControl; pName: string; pPropertyes: string): TStringGrid;
  function  CreateDBGrid(pOwner: TComponent; pParent: TWinControl; pName: string; pPropertyes: string): TDBGrid; //2000.2.1.
  function  CreateLabel(pOwner: TComponent; pParent: TWinControl; pName: string; pPropertyes: string): TLabel; //2000.2.2.
  function  CreateEdit(pOwner: TComponent; pParent: TWinControl; pName: string; pPropertyes: string): TEdit; //2000.2.2.
  function  CreateTabSheet(pOwner: TComponent; pParent: TWinControl; pName: string; pPropertyes: string): TTabSheet; //2000.2.2.
  function  CreatePageControl(pOwner: TComponent; pParent: TWinControl; pName: string; pPropertyes: string): TPageControl; //2000.2.2.
  function  CreateShape(pOwner: TComponent; pParent: TWinControl; pName: string; pPropertyes: string): TShape; //2000.2.3.
  function  CreatePanel(pOwner: TComponent; pParent: TWinControl; pName: string; pPropertyes: string): TPanel; //2000.2.11.
//  function  CreateAgyDBSearchComp(pOwner: TComponent; pParent: TWinControl; pName: string; pPropertyes: string): TPanel; //2000.2.11.

  //** Property conversions **//
  function  StrToAlign(pAlignStr: string): TAlign;
  function  StrToBorderStyle(pBorderStyleStr: string): TBorderStyle;
  function  StrToFormBorderStyle(pBorderStyleStr: string): TFormBorderStyle;
  function  StrToColor(pColor: string): TColor;

implementation

procedure SpecKeyDownhandle (Sender: TObject; var Key: Word; Shift: TShiftState);
var mForm:TCustomForm;  mButton: TBitBtn; Mgs:TMsg;
begin
  mForm := GetParentForm(((Sender as TComponent).Owner as TControl));
  try
    If (Key=VK_RETURN) or (Key=VK_DOWN) then begin
      If (mForm <> nil ) then begin
        SendMessage(mForm.Handle, WM_NEXTDLGCTL, 0, 0);
        // Vypnutie sysutils.beep po opusteni pola formulara inou klavesou ako TAB
        PeekMessage(Mgs, 0, WM_CHAR, WM_CHAR, PM_REMOVE);
      end;
    end;
    If (Key=VK_UP) then begin
      If (mForm <> nil ) then begin
        SendMessage(mForm.Handle, WM_NEXTDLGCTL, 1, 0);
        // Vypnutie sysutils.beep po opusteni pola formulara inou klavesou ako TAB
        PeekMessage(Mgs, 0, WM_CHAR, WM_CHAR, PM_REMOVE);
      end;
    end;
  except end;
(* 28.09.2007 RZ
  mButton := mForm.FindComponent('B_Save') as TBitBtn;
  If (Key=VK_END) then begin
    If mButton<>nil
      then mButton.SetFocus
      else begin
        mButton := mForm.FindComponent('B_Ok') as TBitBtn;
        If mButton<>nil then mButton.SetFocus;
      end;
  end;
*)  
  If (Key=VK_ESCAPE) then mForm.Close;
end;

procedure SetPropertyes(pObject: TObject; pPropertyes: string);
var I,mPropertyNum: integer;
    mPropertyName,mPropertyVal: string;
begin
  mPropertyNum := LineElementNum(pPropertyes, ';');
  if (mPropertyNum > 0) then for i := 0 to mPropertyNum -1 do begin
    SetPropertyNameAndValue(pPropertyes, i, mPropertyName, mPropertyVal);
    SetProperty(pObject, mPropertyName, mPropertyVal);
  end;
end;

procedure SetProperty(pObject: TObject; pName, pValue: string);
begin
  if pObject is TControl then with (pObject as TControl) do begin
    if pName = 'Top'    then Top    := StrToInt(pValue);
    if pName = 'Left'   then Left   := StrToInt(pValue);
    if pName = 'Width'  then Width  := StrToInt(pValue);
    if pName = 'Height' then Height := StrToInt(pValue);
  end;

  if pObject is TPanel then with (pObject as TPanel) do begin
    if pName = 'Caption'     then Caption     := pValue;
    if pName = 'Align'       then Align       := StrToAlign(pValue);
    if pName = 'Color'       then Color       := StrToColor(pValue);
  end;

  if pObject is TShape then with (pObject as TShape) do begin
    if pName = 'Pen.Width'   then Pen.Width   := StrToInt(pValue);
    if pName = 'Brush.Color' then Brush.Color := StrToColor(pValue);
  end;

  if pObject is TPageControl then with (pObject as TPageControl) do begin
    if pName = 'Align'  then Align  := StrToAlign(pValue);
  end;

  if pObject is TTabSheet then with (pObject as TTabSheet) do begin
    if pName = 'Caption' then Caption := pValue;
  end;

  if pObject is TLabel then with (pObject as TLabel) do begin
    if pName = 'Caption' then Caption := pValue;
  end;

  if pObject is TEdit then with (pObject as TEdit) do begin
    if pName = 'Text' then Text := pValue;
  end;

  if pObject is TStringGrid then with (pObject as TStringGrid) do begin
    if pName = 'ColCount'    then ColCount    := StrToInt(pValue);
    if pName = 'RowCount'    then RowCount    := StrToInt(pValue);
    if pName = 'FixedCols'   then FixedCols   := StrToInt(pValue);
    if pName = 'FixedRows'   then FixedRows   := StrToInt(pValue);
    if pName = 'Align'       then Align       := StrToAlign(pValue);
    if pName = 'BorderStyle' then BorderStyle := StrToBorderStyle(pValue);
  end;

  if pObject is TDBGrid then with (pObject as TDBGrid) do begin
    if pName = 'Align'       then Align       := StrToAlign(pValue);
    if pName = 'BorderStyle' then BorderStyle := StrToBorderStyle(pValue);
  end;
end;

procedure SetPropertyNameAndValue(pPropertyes: string; pI: integer; var pPropertyName, pPropertyVal: string); //2000.2.2.
var
  mPropertyStr: string;
begin
  mPropertyStr  := LineElement(pPropertyes, pI, ';');
  pPropertyName := LineElement(mPropertyStr,0,'=');
  pPropertyVal  := LineElement(mPropertyStr,1,'=');
end;

function  StrToAlign(pAlignStr: string): TAlign;
begin
  Result := alNone;
  if pAlignStr = 'alTop'    then Result := alTop;
  if pAlignStr = 'alBottom' then Result := alBottom;
  if pAlignStr = 'alLeft'   then Result := alLeft;
  if pAlignStr = 'alRight'  then Result := alRight;
  if pAlignStr = 'alClient' then Result := alClient;
end;

function  StrToBorderStyle(pBorderStyleStr: string): TBorderStyle;
begin
  if pBorderStyleStr = 'bsNone'   then Result := bsNone;
  if pBorderStyleStr = 'bsSingle' then Result := bsSingle;
end;

function  StrToFormBorderStyle(pBorderStyleStr: string): TFormBorderStyle;
begin
  if pBorderStyleStr = 'bsNone'        then Result := bsNone;
  if pBorderStyleStr = 'bsSingle'      then Result := bsSingle;
  if pBorderStyleStr = 'bsSizeable'    then Result := bsSizeable;
  if pBorderStyleStr = 'bsDialog'      then Result := bsDialog;
  if pBorderStyleStr = 'bsToolWindow'  then Result := bsToolWindow;
  if pBorderStyleStr = 'bsSizeToolWin' then Result := bsSizeToolWin;
end;

function  StrToColor(pColor: string): TColor;
begin
  if pColor = 'clAqua'    then Result := clAqua;
  if pColor = 'clBlack'   then Result := clBlack;
  if pColor = 'clBlue'    then Result := clBlue;
  if pColor = 'clDkGray'  then Result := clDkGray;
  if pColor = 'clFuchsia' then Result := clFuchsia;
  if pColor = 'clGray'    then Result := clGray;
  if pColor = 'clGreen'   then Result := clGreen;
  if pColor = 'clLime'    then Result := clLime;
  if pColor = 'clLtGray'  then Result := clLtGray;
  if pColor = 'clMaroon'  then Result := clMaroon;
  if pColor = 'clNavy'    then Result := clNavy;
  if pColor = 'clOlive'   then Result := clOlive;
  if pColor = 'clPurple'  then Result := clPurple;
  if pColor = 'clRed'     then Result := clRed;
  if pColor = 'clSilver'  then Result := clSilver;
  if pColor = 'clTeal'    then Result := clTeal;
  if pColor = 'clWhite'   then Result := clWhite;
  if pColor = 'clYellow'  then Result := clYellow;

  if pColor = 'clInactiveCaptionText' then Result := clInactiveCaptionText;
  if pColor = 'clBackground'      then Result := clBackground;
  if pColor = 'clActiveCaption'   then Result := clActiveCaption;
  if pColor = 'clInactiveCaption' then Result := clInactiveCaption;
  if pColor = 'clMenu'            then Result := clMenu;
  if pColor = 'clWindow'          then Result := clWindow;
  if pColor = 'clWindowFrame'     then Result := clWindowFrame;
  if pColor = 'clMenuText'        then Result := clMenuText;
  if pColor = 'clWindowText'      then Result := clWindowText;
  if pColor = 'clCaptionText'     then Result := clCaptionText;
  if pColor = 'clActiveBorder'    then Result := clActiveBorder;
  if pColor = 'clInactiveBorder'  then Result := clInactiveBorder;
  if pColor = 'clAppWorkSpace'    then Result := clAppWorkSpace;
  if pColor = 'clHighlight'       then Result := clHighlight;
  if pColor = 'clHighlightText'   then Result := clHighlightText;
  if pColor = 'clBtnFace'         then Result := clBtnFace;
  if pColor = 'clBtnShadow'       then Result := clBtnShadow;
  if pColor = 'clGrayText'        then Result := clGrayText;
  if pColor = 'clBtnText'         then Result := clBtnText;
  if pColor = 'clBtnHighlight'    then Result := clBtnHighlight;
  if pColor = 'cl3DDkShadow'      then Result := cl3DDkShadow;
  if pColor = 'cl3DLight'         then Result := cl3DLight;
  if pColor = 'clInfoText'        then Result := clInfoText;
  if pColor = 'clInfoBk'          then Result := clInfoBk;
end;


function  GetNewComponentName(pForm:TForm; pName: string): string;
begin
  if pName = '' then begin
    Result := GetFreeComponentName(pForm, 'StringGrid')
  end else begin
    if pForm.FindComponent(pName) = nil then begin
      Result := pName;
    end else begin
      Result := GetFreeComponentName(pForm, pName)
    end;
  end;
end;

function  CreatePanel(pOwner: TComponent; pParent: TWinControl; pName: string; pPropertyes: string): TPanel; //2000.2.11.
var
  mComp: TPanel;
begin
  mComp        := TPanel.Create(pOwner);
  mComp.Parent := pParent;
  mComp.Name   := GetNewComponentName(TForm(pOwner), pName);
  SetPropertyes(mComp, pPropertyes);
  Result       := mComp;
end;


function  CreateShape(pOwner: TComponent; pParent: TWinControl; pName: string; pPropertyes: string): TShape; //2000.2.3.
var
  mComp: TShape;
begin
  mComp := TShape.Create(pOwner);
  mComp.Parent   := pParent;
  mComp.Name := GetNewComponentName(TForm(pOwner), pName);
  SetPropertyes(mComp, pPropertyes);
  Result := mComp;
end;


function  CreatePageControl(pOwner: TComponent; pParent: TWinControl; pName: string; pPropertyes: string): TPageControl; //2000.2.2.
var
  mComp: TPageControl;
begin
  mComp := TPageControl.Create(pOwner);
  mComp.Parent   := pParent;
  mComp.Name := GetNewComponentName(TForm(pOwner), pName);
  SetPropertyes(mComp, pPropertyes);
  Result := mComp;
end;


function  CreateTabSheet(pOwner: TComponent; pParent: TWinControl; pName: string; pPropertyes: string): TTabSheet; //2000.2.2.
var
  mComp: TTabSheet;
begin
  mComp := TTabSheet.Create(pOwner);
  mComp.Parent   := pParent;
  mComp.Name := GetNewComponentName(TForm(pOwner), pName);
  SetPropertyes(mComp, pPropertyes);
  Result := mComp;
end;


function  CreateEdit(pOwner: TComponent; pParent: TWinControl; pName: string; pPropertyes: string): TEdit; //2000.2.2.
var
  mComp: TEdit;
begin
  mComp := TEdit.Create(pOwner);
  mComp.Parent   := pParent;
  mComp.Name := GetNewComponentName(TForm(pOwner), pName);
  SetPropertyes(mComp, pPropertyes);
  Result := mComp;
end;

function  CreateLabel(pOwner: TComponent; pParent: TWinControl; pName: string; pPropertyes: string): TLabel; //2000.2.2.
var
  mLabel: TLabel;
begin
  mLabel := TLabel.Create(pOwner);
  mLabel.Parent   := pParent;
  mLabel.Name := GetNewComponentName(TForm(pOwner), pName);
  SetPropertyes(mLabel, pPropertyes);
  Result := mLabel;
end;

function  CreateDBGrid(pOwner: TComponent; pParent: TWinControl; pName: string; pPropertyes: string): TDBGrid;
var
  mDBGrid: TDBGrid;
begin
  mDBGrid := TDBGrid.Create(pOwner);
  mDBGrid.Parent   := pParent;
  mDBGrid.Name := GetNewComponentName(TForm(pOwner), pName);
  SetPropertyes(mDBGrid, pPropertyes);
  Result := mDBGrid;
end;


function  CreateStringGrid(pOwner: TComponent; pParent: TWinControl; pName: string; pPropertyes: string): TStringGrid;
var
  mStringGrid: TStringGrid;
begin
  mStringGrid := TStringGrid.Create(pOwner);
  mStringGrid.Parent   := pParent;
  mStringGrid.Name := GetNewComponentName(TForm(pOwner), pName);
  SetPropertyes(mStringGrid, pPropertyes);
  Result := mStringGrid;
end;

function  GetFreeComponentName(pForm: TForm; pName: string): string; //2000.1.20.
var
  i: integer;
begin
{    i := 1;
  while pForm.FindComponent(pName + IntToStr(i)) <> nil do inc(i);
  Result := pName + IntToStr(i);
}
  i := 1;
  while pForm.FindComponent(pName + IntToStr(i)) <> nil do i := 2*i;
  i := i div 2;
  while pForm.FindComponent(pName + IntToStr(i)) <> nil do inc(i);

  Result := pName + IntToStr(i);
end;

end.
