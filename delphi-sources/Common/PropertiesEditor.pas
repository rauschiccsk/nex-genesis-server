unit PropertiesEditor;

interface

uses
  QuickRep,IcVariab, 
  DBTables, PropTools, QUICKRPT, QRPrnTR, QrCtrls,
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, Buttons, ComCtrls, ExtCtrls, Spin, db, IcButtons,
  ActnList;


type
  TRWCommand = (Read, Write);

  TF_PropertiesEditor = class(TForm)
    PC_PropEditor: TPageControl;
    TS_Main: TTabSheet;
    FontDialog: TFontDialog;
    ColorDialog: TColorDialog;
    Panel2: TPanel;
    CB_Components: TComboBox;
    TS_Properties: TTabSheet;
    GB_AutoSize: TGroupBox;
    CB_AutoSize: TCheckBox;
    GB_PenWidth: TGroupBox;
    SE_Penwidth: TSpinEdit;
    GB_QRSData: TGroupBox;
    CB_QRSData: TComboBox;
    GB_Shape: TGroupBox;
    CB_Shape: TComboBox;
    GB_BandType: TGroupBox;
    CB_BandType: TComboBox;
    GB_DataBaseName: TGroupBox;
    CB_DataBaseName: TComboBox;
    GB_DataSource: TGroupBox;
    CB_DataSource: TComboBox;
    GB_TableName: TGroupBox;
    CB_TableName: TComboBox;
    GB_DataSet: TGroupBox;
    CB_DataSet: TComboBox;
    GB_DataField: TGroupBox;
    CB_DataField: TComboBox;
    GB_Left: TGroupBox;
    SE_Left: TSpinEdit;
    GB_Top: TGroupBox;
    SE_Top: TSpinEdit;
    GB_Width: TGroupBox;
    SE_Width: TSpinEdit;
    GB_Height: TGroupBox;
    SE_Height: TSpinEdit;
    GB_Text: TGroupBox;
    E_Text: TEdit;
    GB_Font: TGroupBox;
    P_Font: TPanel;
    GB_Color: TGroupBox;
    P_Color: TPanel;
    GB_PenColor: TGroupBox;
    P_PenColor: TPanel;
    ActionList1: TActionList;
    WriteComponentChange: TAction;
    GB_CompType: TGroupBox;
    GB_CompName: TGroupBox;
    E_Type: TEdit;
    E_Name: TEdit;
    GB_Owner: TGroupBox;
    L_Owner: TLabel;
    GB_Parent: TGroupBox;
    L_Parent: TLabel;
    GB_Alignment: TGroupBox;
    CB_Alignment: TComboBox;
    procedure BB_OkClick(Sender: TObject);
    procedure BB_CancelClick(Sender: TObject);
    procedure P_FontClick(Sender: TObject);
    procedure P_ColorClick(Sender: TObject);
    procedure E_TextChange(Sender: TObject);
    procedure CB_ComponentsChange(Sender: TObject);
    procedure CB_DataSetClick(Sender: TObject);
    procedure P_PenColorClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure WriteComponentChangeExecute(Sender: TObject);
  private
    { Private declarations }
    oSender: TObject;
    oForm: TForm;
    oActive     : boolean;

    //1999.7.13.
    procedure ClearProperties;
    //1999.9.27.
    function  SG_Text(pCmd: TRWCommand; pText: string): string;
    function  SG_Font(pCmd: TRWCommand; pFont: TFont): TFont;
    function  SG_Color(pCmd: TRWCommand; pColor: TColor): TColor;
    function  SG_PenColor(pCmd: TRWCommand; pColor: TColor): TColor;
    function  SG_AutoSize(pCmd: TRWCommand; pAutoSize: boolean): boolean;
    function  SG_PenWidth(pCmd: TRWCommand; pPenwidth: integer): integer;
    //1999.9.29. Meg nnincs meg a baba
    function  SG_DataSet(pCmd: TRWCommand; pDataSet: TDataSet): TDataSet;
    function  SG_DataField(pCmd: TRWCommand; pDataField: string): string;
    function  SG_BandType (pCmd: TRWCommand; pBandtype: TQRBandType): TQrBandType;
    function  SG_QRSData  (pCmd: TRWCommand; pData: Tqrsysdatatype): Tqrsysdatatype;
    function  SG_Shape    (pCmd: TRWCommand; pShape: TQrShapeType): TQrShapeType;
    function  SG_Alignment (pCmd: TRWCommand; pData: TAlignment): TAlignment;
    //1999.9.28.
    procedure SetControl(pControl: TControl);
    procedure GetControl(pControl: TControl);
    procedure RWComponent(pCmd: TRWCommand);
    //1999.9.29.
    procedure SetComponentsList;

  public
    { Public declarations }
    function  Execute(var pSender: TObject): boolean;
    procedure EndExecute;
  end;

var
  F_PropertiesEditor: TF_PropertiesEditor;

implementation

{$R *.DFM}

procedure TF_PropertiesEditor.EndExecute;
begin
  oActive:=FALSE;
  Hide;
end;

function  TF_PropertiesEditor.Execute(var pSender: TObject): boolean;
  begin
    E_Text.Font.Charset := gvSys.FontCharset;
    oActive:=FALSE;
    oSender := pSender;
    if (oSender as TControl).Owner is TForm
      then oForm := ((oSender as TControl).Owner as TForm)
      else oForm := nil;
    SetComponentsList;
    CB_Components.Text := (oSender as TControl).Name;
    CB_ComponentsChange(nil);
    PC_PropEditor.ActivePage := TS_Properties;
    oActive:=TRUE;
    Show;
    Execute := TRUE;
  end;

procedure TF_PropertiesEditor.ClearProperties;
  var
    i: integer;
  begin
    if ComponentCount > 0 then begin
      for i := 0 to  ComponentCount -1 do begin
        if (Components[i] is TGroupBox) then begin
          If (Components[i] as TGroupBox).Parent.Name = 'TS_Properties' then
          (Components[i] as TGroupBox).Visible := FALSE;
        end;
      end;
    end;
  end;

procedure TF_PropertiesEditor.SetComponentsList;
  var
    i: integer;
  begin
    if oSender is TControl then begin
      if (oSender as TControl).Owner is TForm then begin
        with ((oSender as TControl).Owner as TForm) do begin
          if (ComponentCount > 0) then begin
            Self.CB_Components.Items.Clear;
            for i:= 0 to ComponentCount-1 do begin
              Self.CB_Components.Items.Add(Components[i].Name);
            end;
          end;
        end;
      end;
    end;
  end;

procedure TF_PropertiesEditor.SetControl(pControl: TControl);
  begin
    E_Type.Text := pControl.ClassName;
    E_Name.Text := pControl.Name;
    if pControl.Owner <> nil
      then L_Owner.Caption := pControl.Owner.Name
      else L_Owner.Caption := 'nil';

    if pControl.Parent <> nil
      then L_Parent.Caption := pControl.Parent.Name
      else L_Parent.Caption := 'nil';


    SE_Left.Value := pControl.Left;
    GB_Left.Visible := TRUE;
    SE_Top.Value := pControl.Top;
    GB_Top.Visible := TRUE;
    SE_Width.Value := pControl.Width;
    GB_Width.Visible := TRUE;
    SE_Height.Value := pControl.Height;
    GB_Height.Visible := TRUE;
  end;

procedure  TF_PropertiesEditor.GetControl(pControl: TControl);
  begin
    try
    pControl.Name   := E_Name.Text;
    pControl.Left   := SE_Left.Value;
    pControl.Top    := SE_Top.Value;
    pControl.Width  := SE_Width.Value;
    pControl.Height := SE_Height.Value;
    finally
    //
    end;
  end;

function TF_PropertiesEditor.SG_Text(pCmd: TRWCommand; pText: string): string;
  begin
    GB_Text.Visible := TRUE;
    if pCmd = Read then E_Text.Text := pText;
    Result := E_Text.Text;
  end;

function  TF_PropertiesEditor.SG_Font(pCmd: TRWCommand; pFont: TFont): TFont;
  begin
    GB_Font.Visible := TRUE;
    if pCmd = Read then P_Font.Font := pFont;
    Result := P_Font.Font;
  end;

function  TF_PropertiesEditor.SG_Color(pCmd: TRWCommand; pColor: TColor): TColor;
  begin
    GB_Color.Visible := TRUE;
    if pCmd = Read then P_Color.Color := pColor;
    Result := P_Color.Color;
  end;

function  TF_PropertiesEditor.SG_PenColor(pCmd: TRWCommand; pColor: TColor): TColor;
  begin
    GB_PenColor.Visible := TRUE;
    if pCmd = Read then P_PenColor.Color := pColor;
    Result := P_PenColor.Color;
  end;

function  TF_PropertiesEditor.SG_AutoSize(pCmd: TRWCommand; pAutoSize: boolean): boolean;
  begin
    GB_AutoSize.Visible := TRUE;
    if pCmd = Read then CB_AutoSize.Checked := pAutoSize;
    Result := CB_AutoSize.Checked;
  end;

function  TF_PropertiesEditor.SG_PenWidth;
  begin
    GB_PenWidth.Visible := TRUE;
    if pCmd = Read then SE_PenWidth.Value := pPenWidth;
    Result := SE_PenWidth.Value;
  end;

function  TF_PropertiesEditor.SG_BandType;
  begin
    GB_BandType.Visible := TRUE;
    if pCmd = Read then begin
      case pBandType of
        rbTitle       : CB_BandType.ItemIndex:=0;
        rbPageHeader  : CB_BandType.ItemIndex:=1;
        rbDetail      : CB_BandType.ItemIndex:=2;
        rbPageFooter  : CB_BandType.ItemIndex:=3;
        rbSummary     : CB_BandType.ItemIndex:=4;
        rbGroupHeader : CB_BandType.ItemIndex:=5;
        rbGroupFooter : CB_BandType.ItemIndex:=6;
        rbSubDetail   : CB_BandType.ItemIndex:=7;
        rbColumnHeader: CB_BandType.ItemIndex:=8;
        rbOverlay     : CB_BandType.ItemIndex:=9;
        rbChild       : CB_BandType.ItemIndex:=10;
      end;
    end;
    Result := TQRBandType(CB_BandType.ItemIndex);
  end;

function  TF_PropertiesEditor.SG_QRSData;
  begin
    GB_QRSData.Visible := TRUE;
    if pCmd = Read then begin
      case pData of
        qrstime       : CB_QRSData.ItemIndex:=0;
        qrsdate       : CB_QRSData.ItemIndex:=1;
        qrsdatetime   : CB_QRSData.ItemIndex:=2;
        qrsPageNumber : CB_QRSData.ItemIndex:=3;
        qrsReportTitle: CB_QRSData.ItemIndex:=4;
        qrsDetailCount: CB_QRSData.ItemIndex:=5;
        qrsDetailNo   : CB_QRSData.ItemIndex:=6;
      end; {case}
    end;
    Result := TQRSysDataType(CB_QRSData.ItemIndex);
  end;

function  TF_PropertiesEditor.SG_Alignment;
  begin
    GB_Alignment.Visible := TRUE;
    if pCmd = Read then begin
      case pData of
        taLeftJustify : CB_Alignment.ItemIndex:=0;
        taRightJustify: CB_Alignment.ItemIndex:=1;
        taCenter      : CB_Alignment.ItemIndex:=2;
      end; {case}
    end;
    Result := TAlignment(CB_Alignment.ItemIndex);
  end;

function  TF_PropertiesEditor.SG_Shape;
  begin
    GB_Shape.Visible := TRUE;
    if pCmd = Read then begin
      case pShape of
        qrsRectangle    : CB_Shape.ItemIndex:=0;
        qrsCircle       : CB_Shape.ItemIndex:=1;
        qrsVertLine     : CB_Shape.ItemIndex:=2;
        qrsHorLine      : CB_Shape.ItemIndex:=3;
        qrsTopAndBottom : CB_Shape.ItemIndex:=4;
        qrsRightAndLeft : CB_Shape.ItemIndex:=5;
      end; {case}
    end;
    Result := TQRShapeType(CB_Shape.ItemIndex);
  end;

function  TF_PropertiesEditor.SG_DataSet(pCmd: TRWCommand; pDataSet: TDataSet): TDataSet;
  var
    i,j,l       : integer;
    mname       : String;
    Temp        : TComponent;
    mForm       : TForm;
    mFrame,mF   : TFrame;
    mDM         : TDATAModule;
  begin
    GB_DataSet.Visible := TRUE;
    if pCmd = Read then begin
      if pDataSet = nil
        then CB_DataSet.Text :=  ''
        else CB_DataSet.Text := pDataSet.Name;
      CB_DataSet.Items.Clear;
{
        for i := 0 to oForm.ComponentCount -1 do
          if oForm.Components[i] is TDataSet then
            CB_DataSet.Items.Add(oForm.Components[i].Name);
}
      for I := Application.ComponentCount - 1 downto 0 do begin
        Temp := Application.Components[I];
        if (Temp is TForm) then begin
          mForm := (Temp as TForm);
          for j := mForm.ComponentCount - 1 downto 0 do begin
            Temp := mForm.Components[j];
            if (Temp is TDATASET) then begin

              mName:= (Temp as TDataSet).Name;
              If (Temp as TDataSet).Owner<> oForm
                then mname := (Temp as TDataSet).Owner.Name+'.'+mname;
              CB_DataSet.Items.Add(mName);
            end else if (Temp is TFrame) then begin
              mFrame := (Temp as TFrame);
              for l := mFrame.ComponentCount - 1 downto 0 do begin
                Temp := mFrame.Components[l];
                if (Temp is TDATASET) then begin

                  mName:= (Temp as TDataSet).Name;
                  If (Temp as TDataSet).Owner<> oForm then begin
                    mF:= (Temp as TDataSet).Owner as TFrame;
                    mname := mF.Owner.Name+'.'+(Temp as TDataSet).Owner.Name+'.'+mname;
                  end;
                  CB_DataSet.Items.Add(mName);
                end;
              end;
            end;
          end;
        end else if (Temp is TFrame) then begin
          mFrame := (Temp as TFrame);
          for j := mFrame.ComponentCount - 1 downto 0 do begin
            Temp := mFrame.Components[j];
            if (Temp is TDATASET) then begin

              mName:= (Temp as TDataSet).Name;
              If (Temp as TDataSet).Owner<> oForm then begin
                mF:= (Temp as TDataSet).Owner as TFrame;
                mname := mF.Owner.Name+'.'+(Temp as TDataSet).Owner.Name+'.'+mname;
              end;
              CB_DataSet.Items.Add(mName);
            end;
          end;
        end else if (Temp is TDataModule) then begin
          mDM := (Temp as TDATAModule);
          for j := mDM.ComponentCount - 1 downto 0 do begin
            Temp := mDM.Components[j];
            if (Temp is TDATASET) then begin

              mName:= (Temp as TDataSet).Name;
              If (Temp as TDataSet).Owner<> oForm then begin
                mname := (Temp as TDataSet).Owner.Name+'.'+mname;
              end;
              CB_DataSet.Items.Add(mName);
            end;
          end;
        end;
      end;
{
        with Session do
        for I:= 0 to DatabaseCount - 1 do
          For J:=0 to Databases[I].DataSetCount-1 do begin
            mName:= Databases[I].DataSets[J].Name;
            If Databases[I].DataSets[J].Owner<> oForm
              then mname := Databases[I].DataSets[J].Owner.Name+'.'+mname;
            CB_DataSet.Items.Add(mName);
          end;
}
    end;
    Temp:= FindComp(oForm,CB_DataSet.Text);
    If (Temp = NIL) and (Pos('.',CB_DataSet.Text)=0) then begin
      for I:=0 to CB_DataSet.Items.Count-1 do begin
        If Pos (CB_DataSet.Text,CB_DataSet.Items[i])>0
          then CB_DataSet.Text:=CB_DataSet.Items[i];
      end;
      Temp:= FindComp(oForm,CB_DataSet.Text);
    end;
    Result := temp as TDataSet;
//    Result := oForm.FindComponent(CB_DataSet.Text) as TDataSet;
  end;

function  TF_PropertiesEditor.SG_DataField(pCmd: TRWCommand; pDataField: string): string;
  begin
    GB_DataField.Visible := TRUE;
    if pCmd = Read then begin
      CB_DataField.Text :=  pDataField;
      CB_DataField.Items.Clear;
      if oSender is TIcQRDBText then begin
        if (oSender as TIcQRDBText).DataSet <> nil then begin
          (oSender as TIcQRDBText).DataSet.GetFieldNames(CB_DataField.Items);
        end;
      end;
    end;
    Result := CB_DataField.Text;
  end;

procedure TF_PropertiesEditor.RWComponent(pCmd: TRWCommand);
  begin
    //********************* TControl ***********************//
    if (oSender is TControl) then begin
      if pCmd = Read
        then SetControl(oSender as TControl)
        else GetControl(oSender as TControl);
    end;

    //********************** TLabel ************************//
    if (oSender is TLabel) then with (oSender as TLabel) do begin
      Caption  := SG_Text(pCmd, Caption);
      Font     := SG_Font(pCmd, Font);
      Color    := SG_Color(pCmd, Color);
      AutoSize := SG_AutoSize(pCmd, AutoSize);
    end;

    //********************** TEdit **************************//
    if (oSender is TEdit) then with (oSender as TEdit) do begin
      Text     := SG_Text(pCmd, Text);
      Font     := SG_Font(pCmd, Font);
      Color    := SG_Color(pCmd, Color);
      AutoSize := SG_AutoSize(pCmd, AutoSize);
    end;

    //********************** TShape *************************//
    if (oSender is TShape) then with (oSender as TShape) do begin
      Brush.Color := SG_Color(pCmd, Brush.Color);
    end;

    //********************* TPanel *************************//
    if (oSender is TPanel) then with (oSender as TPanel) do begin
      Caption := SG_Text (pCmd, Caption);
      Font    := SG_Font (pCmd, Font);
      Color   := SG_Color(pCmd, Color);
    end;

    //********************* TAgyQRLabel ********************//
    if (oSender is TIcQRLabel) then with (oSender as TIcQRLabel) do begin
      Caption  := SG_Text(pCmd, Caption);
      Font     := SG_Font(pCmd, Font);
      Color    := SG_Color(pCmd, Color);
      AutoSize := SG_AutoSize(pCmd, AutoSize);
      Alignment:= SG_Alignment(pCmd, Alignment);
    end;

    //********************* TAgyDBText ********************//
    if (oSender is TIcQRDBText) then with (oSender as TIcQRDBText) do begin
      Font     := SG_Font(pCmd, Font);
      Color    := SG_Color(pCmd, Color);
      AutoSize := SG_AutoSize(pCmd, AutoSize);
      DataSet  := SG_DataSet(pCmd, DataSet);
      DataField:= SG_DataField(pCmd, DataField);
      Alignment:= SG_Alignment(pCmd, Alignment);
    end;

    //********************** TShape *************************//
    if (oSender is TIcQRShape) then with (oSender as TIcQRShape) do begin
      Brush.Color := SG_Color   (pCmd, Brush.Color);
      Pen.Width   := SG_penWidth(pCmd, Pen.Width);
      Pen.Color   := SG_PenColor(pCmd, Pen.Color);
      Shape       := SG_Shape   (pCmd, Shape);
    end;

    //********************** TAgyQRBand *************************//
    if (oSender is TIcQRband) then with (oSender as TIcQRBand) do begin
      BandType  := SG_bandType(pCmd, bandType);
    end;

    //********************** TAgyQRExpr *************************//
    if (oSender is TIcQRExpr) then with (oSender as TIcQRExpr) do begin
      Font     := SG_Font(pCmd, Font);
      Color    := SG_Color(pCmd, Color);
      Expression  := SG_Text(pCmd, Expression);
      Alignment:= SG_Alignment(pCmd, Alignment);
      AutoSize := SG_AutoSize(pCmd, AutoSize);
    end;

    //********************** TAgyQRSysData *************************//
    if (oSender is TIcQRSysData) then with (oSender as TIcQRSysData) do begin
      Font     := SG_Font(pCmd, Font);
      Color    := SG_Color(pCmd, Color);
      Data  := SG_QRSData(pCmd, Data);
      Alignment:= SG_Alignment(pCmd, Alignment);
      AutoSize := SG_AutoSize(pCmd, AutoSize);
    end;

  end;


procedure TF_PropertiesEditor.BB_OkClick(Sender: TObject);
begin
  WriteComponentChangeExecute(Sender);
end;

procedure TF_PropertiesEditor.BB_CancelClick(Sender: TObject);
begin
  ClearProperties;
  RWComponent(read);
end;

procedure TF_PropertiesEditor.P_FontClick(Sender: TObject);
begin
  FontDialog.Font := P_Font.Font;
  if FontDialog.Execute then P_Font.Font := FontDialog.Font;
  WriteComponentChangeExecute(Sender);
end;

procedure TF_PropertiesEditor.P_ColorClick(Sender: TObject);
begin
  ColorDialog.Color := P_Color.Color;
  if ColorDialog.Execute then P_Color.Color := ColorDialog.Color;
  WriteComponentChangeExecute(Sender);
end;

procedure TF_PropertiesEditor.P_PenColorClick(Sender: TObject);
begin
  ColorDialog.Color := P_PenColor.Color;
  if ColorDialog.Execute then P_PenColor.Color := ColorDialog.Color;
  WriteComponentChangeExecute(Sender);
end;

procedure TF_PropertiesEditor.E_TextChange(Sender: TObject);
begin
  P_Font.Caption := E_Text.Text;
  WriteComponentChangeExecute(sender);
end;

procedure TF_PropertiesEditor.CB_ComponentsChange(Sender: TObject);
var
  mSender: TObject;
begin
  with ((oSender as TControl).Owner as TForm) do begin
    mSender := FindComponent(CB_Components.Text);
    if nil <> mSender then begin
      oSender := mSender;
      ClearProperties;
      RWComponent(Read);
    end;
  end;
end;

procedure TF_PropertiesEditor.CB_DataSetClick(Sender: TObject);
begin
  (oSender as TIcQRDBText).DataSet  := FindComp(oForm,CB_DataSet.Text) as TDataSet;
  (oSender as TIcQRDBText).DataField:= SG_DataField(Read, (oSender as TIcQRDBText).DataField);
end;

procedure TF_PropertiesEditor.FormCreate(Sender: TObject);
begin
  Left:=10;Top:=100;
end;

procedure TF_PropertiesEditor.WriteComponentChangeExecute(Sender: TObject);
begin
  If oActive then RWComponent(Write);
end;

end.
