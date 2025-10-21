object F_DsgnOpen: TF_DsgnOpen
  Left = 276
  Top = 226
  Width = 364
  Height = 422
  Caption = 'Otvori'#357
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  Position = poScreenCenter
  PixelsPerInch = 96
  TextHeight = 13
  object xpSinglePanel1: TxpSinglePanel
    Left = 0
    Top = 0
    Width = 356
    Height = 388
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
    TabOrder = 0
    object L_File: TxpLabel
      Left = 4
      Top = 8
      Width = 28
      Height = 13
      SystemColor = False
      Caption = 'L_File'
    end
    object LB_Forms: TListBox
      Left = 4
      Top = 28
      Width = 350
      Height = 309
      BevelOuter = bvNone
      BorderStyle = bsNone
      Font.Charset = EASTEUROPE_CHARSET
      Font.Color = clWindowText
      Font.Height = -13
      Font.Name = 'Courier New'
      Font.Style = []
      ItemHeight = 16
      ParentFont = False
      TabOrder = 0
      OnDblClick = LB_FormsDblClick
      OnKeyDown = LB_FormsKeyDown
    end
    object B_Open: TxpBitBtn
      Left = 88
      Top = 348
      Width = 75
      Height = 29
      SystemColor = True
      Caption = 'Otvori'#357
      Font.Charset = DEFAULT_CHARSET
      Font.Color = 13107200
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      TabOrder = 1
      BasicColor = 16769505
      MarginLeft = 8
      MarginRight = 8
      MarginTop = 8
      MarginBottom = 8
      GlyphSpace = 10
      LineSpace = 2
      Layout = blGlyphLeft
      AlignText = atCenter
      Down = False
      GroupIndex = 0
      OnClick = B_OpenClick
    end
    object B_Cancel: TxpBitBtn
      Left = 184
      Top = 348
      Width = 75
      Height = 29
      SystemColor = True
      Caption = 'Storno'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = 13107200
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      TabOrder = 2
      BasicColor = 16769505
      MarginLeft = 8
      MarginRight = 8
      MarginTop = 8
      MarginBottom = 8
      GlyphSpace = 10
      LineSpace = 2
      Layout = blGlyphLeft
      AlignText = atCenter
      Down = False
      GroupIndex = 0
      OnClick = B_CancelClick
    end
  end
end
