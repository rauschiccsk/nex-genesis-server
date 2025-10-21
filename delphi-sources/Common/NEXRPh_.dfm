object F_NEXRPh: TF_NEXRPh
  Left = 207
  Top = 133
  Width = 476
  Height = 335
  Caption = 'Telefonick'#225' registr'#225'cia - len pre IdentCode Consulting s.r.o.'
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  PixelsPerInch = 96
  TextHeight = 13
  object Bevel4: TBevel
    Left = 149
    Top = 129
    Width = 143
    Height = 30
    Shape = bsFrame
    Style = bsRaised
  end
  object Bevel5: TBevel
    Left = 149
    Top = 173
    Width = 278
    Height = 27
    Shape = bsFrame
    Style = bsRaised
  end
  object Bevel6: TBevel
    Left = 149
    Top = 213
    Width = 317
    Height = 27
    Shape = bsFrame
    Style = bsRaised
  end
  object Label11: TLabel
    Left = 8
    Top = 134
    Width = 136
    Height = 20
    Alignment = taRightJustify
    AutoSize = False
    Caption = 'S'#233'riov'#233' '#269#237'slo'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clBlack
    Font.Height = -16
    Font.Name = 'MS Sans Serif'
    Font.Style = [fsBold]
    ParentFont = False
  end
  object Label12: TLabel
    Left = 8
    Top = 176
    Width = 136
    Height = 20
    Alignment = taRightJustify
    AutoSize = False
    Caption = 'Kontroln'#253' k'#243'd'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clBlack
    Font.Height = -16
    Font.Name = 'MS Sans Serif'
    Font.Style = [fsBold]
    ParentFont = False
  end
  object Label13: TLabel
    Left = 8
    Top = 216
    Width = 136
    Height = 20
    Alignment = taRightJustify
    AutoSize = False
    Caption = 'Registra'#269'n'#253' k'#243'd'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clBlack
    Font.Height = -16
    Font.Name = 'MS Sans Serif'
    Font.Style = [fsBold]
    ParentFont = False
  end
  object StatusBar1: TStatusBar
    Left = 0
    Top = 289
    Width = 468
    Height = 19
    Panels = <>
    SimplePanel = False
  end
  object ME_PrgSerNum: TMaskEdit
    Left = 152
    Top = 132
    Width = 137
    Height = 24
    TabStop = False
    BorderStyle = bsNone
    CharCase = ecUpperCase
    EditMask = 'AA-00-00000;1;_'
    Font.Charset = EASTEUROPE_CHARSET
    Font.Color = clBlack
    Font.Height = -19
    Font.Name = 'Arial'
    Font.Style = [fsBold]
    MaxLength = 11
    ParentFont = False
    TabOrder = 0
    Text = '  -  -     '
    OnKeyDown = ME_PrgSerNumKeyDown
  end
  object ME_VerifyCode: TMaskEdit
    Left = 152
    Top = 176
    Width = 272
    Height = 21
    BorderStyle = bsNone
    CharCase = ecUpperCase
    EditMask = 'AA AA AA AA AA AA AA;1;_'
    Font.Charset = ANSI_CHARSET
    Font.Color = clBlack
    Font.Height = -19
    Font.Name = 'Arial'
    Font.Style = [fsBold]
    MaxLength = 20
    ParentFont = False
    TabOrder = 1
    Text = '                    '
    OnExit = ME_VerifyCodeExit
    OnKeyDown = ME_PrgSerNumKeyDown
  end
  object ME_RegCode: TMaskEdit
    Left = 152
    Top = 216
    Width = 311
    Height = 21
    TabStop = False
    BorderStyle = bsNone
    CharCase = ecUpperCase
    EditMask = 'AA AA AA AA AA AA AA AA;1;_'
    Font.Charset = EASTEUROPE_CHARSET
    Font.Color = clBlack
    Font.Height = -19
    Font.Name = 'Arial'
    Font.Style = [fsBold]
    MaxLength = 23
    ParentFont = False
    ReadOnly = True
    TabOrder = 2
    Text = '                       '
    OnKeyDown = ME_PrgSerNumKeyDown
  end
  object BB_OK: TBitBtn
    Left = 192
    Top = 260
    Width = 89
    Height = 25
    Caption = 'Ulo'#382'i'#357
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -13
    Font.Name = 'MS Sans Serif'
    Font.Style = [fsBold]
    ParentFont = False
    TabOrder = 4
    OnClick = BB_OKClick
    Glyph.Data = {
      BE060000424DBE06000000000000360400002800000024000000120000000100
      0800000000008802000000000000000000000001000000000000000000000000
      80000080000000808000800000008000800080800000C0C0C000B17A5800DCC3
      B400000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000EDE1DA00A4A0A000808080000000
      FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFFFF00030303030303
      0303030303030303030303030303030303030303030303030303030303030303
      03030303030303030303030303030303030303030303FF030303030303030303
      03030303030303040403030303030303030303030303030303F8F8FF03030303
      03030303030303030303040202040303030303030303030303030303F80303F8
      FF030303030303030303030303040202020204030303030303030303030303F8
      03030303F8FF0303030303030303030304020202020202040303030303030303
      0303F8030303030303F8FF030303030303030304020202FA0202020204030303
      0303030303F8FF0303F8FF030303F8FF03030303030303020202FA03FA020202
      040303030303030303F8FF03F803F8FF0303F8FF03030303030303FA02FA0303
      03FA0202020403030303030303F8FFF8030303F8FF0303F8FF03030303030303
      FA0303030303FA0202020403030303030303F80303030303F8FF0303F8FF0303
      0303030303030303030303FA0202020403030303030303030303030303F8FF03
      03F8FF03030303030303030303030303FA020202040303030303030303030303
      0303F8FF0303F8FF03030303030303030303030303FA02020204030303030303
      03030303030303F8FF0303F8FF03030303030303030303030303FA0202020403
      030303030303030303030303F8FF0303F8FF03030303030303030303030303FA
      0202040303030303030303030303030303F8FF03F8FF03030303030303030303
      03030303FA0202030303030303030303030303030303F8FFF803030303030303
      030303030303030303FA0303030303030303030303030303030303F803030303
      0303030303030303030303030303030303030303030303030303030303030303
      0303}
    NumGlyphs = 2
  end
  object Panel1: TPanel
    Left = 4
    Top = 4
    Width = 461
    Height = 117
    BevelInner = bvLowered
    TabOrder = 5
    object Label1: TLabel
      Left = 12
      Top = 12
      Width = 160
      Height = 16
      Alignment = taRightJustify
      AutoSize = False
      Caption = 'Licen'#269'n'#225' verzia'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -13
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      ParentFont = False
    end
    object Label2: TLabel
      Left = 12
      Top = 38
      Width = 160
      Height = 16
      Alignment = taRightJustify
      AutoSize = False
      Caption = 'Po'#269'et pracovn'#253'ch stan'#237'c'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -13
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      ParentFont = False
    end
    object Label3: TLabel
      Left = 12
      Top = 64
      Width = 160
      Height = 16
      Alignment = taRightJustify
      AutoSize = False
      Caption = #268'asov'#253' limit'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -13
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      ParentFont = False
    end
    object Label4: TLabel
      Left = 12
      Top = 89
      Width = 160
      Height = 16
      Alignment = taRightJustify
      AutoSize = False
      Caption = 'Zaregistrovan'#233' moduly'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -13
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      ParentFont = False
    end
    object E_Version: TEdit
      Left = 180
      Top = 8
      Width = 29
      Height = 24
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -13
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      ParentFont = False
      TabOrder = 0
    end
    object E_WSQnt: TEdit
      Left = 180
      Top = 34
      Width = 29
      Height = 24
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -13
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      ParentFont = False
      TabOrder = 1
    end
    object E_TimeLimit: TEdit
      Left = 180
      Top = 60
      Width = 69
      Height = 24
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -13
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      ParentFont = False
      TabOrder = 2
    end
    object E_PrgList: TEdit
      Left = 180
      Top = 85
      Width = 149
      Height = 24
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -13
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      ParentFont = False
      TabOrder = 3
    end
  end
end
