object F_DsgnInsp: TF_DsgnInsp
  Left = 622
  Top = 116
  Width = 198
  Height = 688
  Caption = 'Object in'#353'pektor'
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  OnCreate = FormCreate
  PixelsPerInch = 96
  TextHeight = 13
  object P_CompPanel: TxpSinglePanel
    Left = 0
    Top = 0
    Width = 190
    Height = 36
    SystemColor = True
    BasicColor = 16769505
    BorderColor = 16754085
    GradEndColor = 16769505
    GradStartColor = 16769505
    GradFillDir = fdXP
    BGStyle = bgsNone
    Color = 16769505
    Font.Charset = DEFAULT_CHARSET
    Font.Color = 13107200
    Font.Height = -11
    Font.Name = 'MS Sans Serif'
    Font.Style = []
    Align = alTop
    TabOrder = 0
    object CB_CompList: TxpComboBox
      Left = 4
      Top = 8
      Width = 181
      Height = 22
      Style = csDropDownList
      ItemHeight = 16
      Sorted = True
      TabOrder = 0
      TabStop = False
      OnClick = CB_CompListClick
      SystemColor = True
      BasicColor = 16769505
      XPStyle.AutoSearch = True
      XPStyle.ButtonWidth = 20
      XPStyle.ButtonStyle = cbsXP
      XPStyle.BGStyle = cbgsGradient
      XPStyle.ActiveBorderColor = 16743805
      XPStyle.InActiveBorderColor = 16754085
      XPStyle.ActiveButtonColor = 16759225
      XPStyle.InActiveButtonColor = 16764365
      XPStyle.BGStartColor = clWhite
      XPStyle.BGEndColor = 16764365
      XPStyle.BGGradientFillDir = fdRightToLeft
      XPStyle.SelStartColor = 16759225
      XPStyle.SelEndColor = 16766935
      XPStyle.SelGradientFillDir = fdVerticalFromCenter
    end
  end
  object P_PropPanel: TxpSinglePanel
    Left = 0
    Top = 36
    Width = 190
    Height = 618
    SystemColor = True
    BasicColor = 16769505
    BorderColor = 16754085
    GradEndColor = 16769505
    GradStartColor = 16769505
    GradFillDir = fdXP
    BGStyle = bgsNone
    Color = 16769505
    Font.Charset = DEFAULT_CHARSET
    Font.Color = 13107200
    Font.Height = -11
    Font.Name = 'MS Sans Serif'
    Font.Style = []
    Align = alClient
    TabOrder = 1
    object SG_ObjInsp: TStringGrid
      Left = 0
      Top = 0
      Width = 190
      Height = 618
      Align = alClient
      BorderStyle = bsNone
      Color = 16769505
      ColCount = 2
      DefaultRowHeight = 19
      FixedColor = 16769505
      FixedCols = 0
      RowCount = 20
      FixedRows = 0
      Options = [goFixedVertLine, goFixedHorzLine, goVertLine, goHorzLine, goEditing, goAlwaysShowEditor]
      TabOrder = 0
      OnClick = SG_ObjInspClick
      OnDblClick = SG_ObjInspDblClick
      OnDrawCell = SG_ObjInspDrawCell
      OnExit = SG_ObjInspExit
      OnKeyDown = SG_ObjInspKeyDown
      OnSelectCell = SG_ObjInspSelectCell
      ColWidths = (
        92
        94)
      RowHeights = (
        20
        19
        19
        19
        19
        19
        19
        19
        18
        19
        19
        19
        19
        19
        19
        19
        19
        19
        19
        19)
    end
    object CB_Prop: TxpComboBox
      Left = 20
      Top = 431
      Width = 73
      Height = 22
      Style = csDropDownList
      ItemHeight = 16
      TabOrder = 1
      OnClick = CB_PropClick
      OnExit = CB_PropExit
      OnKeyDown = CB_PropKeyDown
      SystemColor = False
      BasicColor = 16769505
      XPStyle.AutoSearch = True
      XPStyle.ButtonWidth = 20
      XPStyle.ButtonStyle = cbsXP
      XPStyle.BGStyle = cbgsGradient
      XPStyle.ActiveBorderColor = 16743805
      XPStyle.InActiveBorderColor = 16754085
      XPStyle.ActiveButtonColor = 16759225
      XPStyle.InActiveButtonColor = 16764365
      XPStyle.BGStartColor = clWhite
      XPStyle.BGEndColor = 16764365
      XPStyle.BGGradientFillDir = fdRightToLeft
      XPStyle.SelStartColor = 16759225
      XPStyle.SelEndColor = 16766935
      XPStyle.SelGradientFillDir = fdVerticalFromCenter
    end
  end
end
