object FF_CompEdit: TFF_CompEdit
  Left = 595
  Top = 78
  AutoScroll = False
  BorderIcons = [biSystemMenu, biMinimize]
  Caption = 'Object Properties'
  ClientHeight = 371
  ClientWidth = 209
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = True
  OnActivate = FormActivate
  OnClose = FormClose
  OnResize = FormResize
  PixelsPerInch = 96
  TextHeight = 13
  object StringGrid1: TStringGrid
    Left = 0
    Top = 25
    Width = 209
    Height = 325
    Align = alClient
    Color = clBtnFace
    ColCount = 2
    DefaultColWidth = 90
    DefaultRowHeight = 18
    FixedCols = 0
    RowCount = 20
    FixedRows = 0
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clBlack
    Font.Height = -12
    Font.Name = 'Arial'
    Font.Style = []
    Options = [goVertLine, goHorzLine, goColSizing]
    ParentFont = False
    TabOrder = 0
    OnDblClick = StringGrid1DblClick
    OnKeyPress = StringGrid1KeyPress
    OnSelectCell = StringGrid1SelectCell
  end
  object StatusBar1: TStatusBar
    Left = 0
    Top = 350
    Width = 209
    Height = 21
    Panels = <>
    SimplePanel = True
    SimpleText = ' Double Click To Edit A Property'
  end
  object Panel1: TPanel
    Left = 0
    Top = 0
    Width = 209
    Height = 25
    Align = alTop
    BevelOuter = bvNone
    TabOrder = 2
    OnResize = Panel1Resize
    object ComponentBox: TComboBox
      Left = 0
      Top = 0
      Width = 189
      Height = 23
      Hint = 'Change Form & Application with <ENTER>'
      TabStop = False
      Style = csDropDownList
      DropDownCount = 20
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlack
      Font.Height = -12
      Font.Name = 'Arial'
      Font.Style = []
      ItemHeight = 15
      ParentFont = False
      ParentShowHint = False
      ShowHint = True
      Sorted = True
      TabOrder = 0
      OnChange = ComponentBoxChange
      OnKeyDown = ComponentBoxKeyDown
    end
    object BitBtn1: TBitBtn
      Left = 188
      Top = 0
      Width = 21
      Height = 25
      Hint = 'Refresh'
      ParentShowHint = False
      ShowHint = True
      TabOrder = 1
      OnClick = BitBtn1Click
      Glyph.Data = {
        DE010000424DDE01000000000000760000002800000024000000120000000100
        04000000000068010000CE0E0000C40E00001000000000000000000000000000
        80000080000000808000800000008000800080800000C0C0C000808080000000
        FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFFFF00333333000000
        33333333333F8888883F33330000300330FEFEFE003333388F3833333388F333
        000030E00FEFEFEFEF033338F8833FFFFF338F33000030FEFEF00000FEF03338
        F333F88888F338F3000030EFEF0333330FEF0338F33F8333338F338F000030FE
        FE03333330FE0338F33833333338F38F000030EFEFE0333330000338FFFF8F33
        3338888300003000000033333333333888888833333333330000333333333333
        333333333333333333FFFFFF000033333333333000000033FFFF333333888888
        0000300003333330EFEFE038888F333338F33338000030FE033333330EFEF038
        F38F3333338333380000330FE03333300FEFE0338338FFFFF88333380000330E
        FE00000EFEFEF0338F3388888333FF3800003330EFEFEFEFEF00E03338FF3333
        33FF88F80000333300FEFEFE003300333388FFFFFF8833830000333333000000
        3333333333338888883333330000333333333333333333333333333333333333
        0000}
      NumGlyphs = 2
    end
  end
  object EditStr: TEdit
    Left = 92
    Top = 27
    Width = 90
    Height = 23
    TabStop = False
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clBlack
    Font.Height = -12
    Font.Name = 'Arial'
    Font.Style = []
    ParentFont = False
    TabOrder = 3
    Text = 'EditStr'
    Visible = False
    OnExit = FixUpOnExit
    OnKeyDown = EditkeyDown
    OnKeyPress = EditStrKeyPress
  end
  object ComboEnum: TComboBox
    Left = 92
    Top = 46
    Width = 90
    Height = 23
    TabStop = False
    Style = csDropDownList
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clBlack
    Font.Height = -12
    Font.Name = 'Arial'
    Font.Style = []
    ItemHeight = 15
    ParentFont = False
    TabOrder = 4
    Visible = False
    OnExit = FixUpOnExit
    OnKeyDown = EditkeyDown
  end
  object SetEdit: TListBox
    Left = 0
    Top = 64
    Width = 185
    Height = 97
    TabStop = False
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clBlack
    Font.Height = -12
    Font.Name = 'Arial'
    Font.Style = []
    ItemHeight = 15
    MultiSelect = True
    ParentFont = False
    TabOrder = 5
    Visible = False
    OnExit = FixUpOnExit
    OnKeyDown = EditkeyDown
  end
end
