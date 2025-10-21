object F_AddSet: TF_AddSet
  Left = 194
  Top = 118
  Width = 600
  Height = 304
  Hint = 'TableView'
  Caption = 'F_AddSet'
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  Scaled = False
  OnActivate = FormActivate
  OnCreate = FormCreate
  OnDestroy = FormDestroy
  OnKeyDown = KeyDown
  PixelsPerInch = 96
  TextHeight = 13
  object P_AddSet: TDinamicPanel
    Left = 0
    Top = 0
    Width = 592
    Height = 277
    Align = alClient
    BevelOuter = bvNone
    Caption = ' '
    TabOrder = 0
    ColorThemes = acsStandard
    AutoExpand = False
    object Bevel1: TBevel
      Left = 7
      Top = 5
      Width = 580
      Height = 50
    end
    object Label3: TLabel
      Left = 249
      Top = 9
      Width = 330
      Height = 13
      Alignment = taCenter
      AutoSize = False
      Caption = 'Hlavicka tabulky'
    end
    object Bevel2: TBevel
      Left = 6
      Top = 61
      Width = 580
      Height = 173
    end
    object L_VBoxHead: TLabel
      Left = 16
      Top = 71
      Width = 110
      Height = 14
      Alignment = taCenter
      AutoSize = False
      Caption = 'Databaza'
      Color = clGrayText
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clCaptionText
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      ParentColor = False
      ParentFont = False
    end
    object L_DBoxHead: TLabel
      Left = 179
      Top = 71
      Width = 110
      Height = 15
      Alignment = taCenter
      AutoSize = False
      Caption = 'Zobrazit'
      Color = clGrayText
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clCaptionText
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      ParentColor = False
      ParentFont = False
    end
    object Label4: TLabel
      Left = 299
      Top = 80
      Width = 24
      Height = 13
      Caption = 'Text:'
    end
    object Label5: TLabel
      Left = 299
      Top = 104
      Width = 25
      Height = 13
      Caption = 'Sírka'
    end
    object Bevel3: TBevel
      Left = 17
      Top = 25
      Width = 49
      Height = 20
    end
    object Label1: TLabel
      Left = 16
      Top = 9
      Width = 51
      Height = 13
      Alignment = taCenter
      AutoSize = False
      Caption = 'Oznacenie'
    end
    object Label2: TLabel
      Left = 73
      Top = 8
      Width = 170
      Height = 13
      Alignment = taCenter
      AutoSize = False
      Caption = 'Nazov nastavenia'
    end
    object L_SetNum: TLabel
      Left = 31
      Top = 28
      Width = 24
      Height = 13
      Caption = 'D01'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = [fsBold]
      ParentFont = False
    end
    object Label6: TLabel
      Left = 11
      Top = 240
      Width = 120
      Height = 13
      Alignment = taCenter
      AutoSize = False
      Caption = 'Databaza'
      Visible = False
    end
    object Label7: TLabel
      Left = 175
      Top = 240
      Width = 120
      Height = 13
      Alignment = taCenter
      AutoSize = False
      Caption = 'Zobrazit'
      Visible = False
    end
    object B_Save: TBitBtn
      Left = 380
      Top = 243
      Width = 100
      Height = 25
      Caption = '&Ulozit'
      TabOrder = 10
      OnClick = B_SaveClick
      OnKeyDown = KeyDown
      Glyph.Data = {
        76010000424D7601000000000000760000002800000020000000100000000100
        04000000000000010000120B0000120B00001000000000000000000000000000
        800000800000008080008000000080008000808000007F7F7F00BFBFBF000000
        FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFFFF00333333333333
        333333FFFFFFFFFFFFF33000077777770033377777777777773F000007888888
        00037F3337F3FF37F37F00000780088800037F3337F77F37F37F000007800888
        00037F3337F77FF7F37F00000788888800037F3337777777337F000000000000
        00037F3FFFFFFFFFFF7F00000000000000037F77777777777F7F000FFFFFFFFF
        00037F7F333333337F7F000FFFFFFFFF00037F7F333333337F7F000FFFFFFFFF
        00037F7F333333337F7F000FFFFFFFFF00037F7F333333337F7F000FFFFFFFFF
        00037F7F333333337F7F000FFFFFFFFF07037F7F33333333777F000FFFFFFFFF
        0003737FFFFFFFFF7F7330099999999900333777777777777733}
      NumGlyphs = 2
    end
    object B_Cancel: TBitBtn
      Left = 486
      Top = 243
      Width = 100
      Height = 25
      Caption = '&Opustit'
      TabOrder = 2
      OnClick = B_CancelClick
      OnKeyDown = KeyDown
      Glyph.Data = {
        CE070000424DCE07000000000000360000002800000024000000120000000100
        1800000000009807000000000000000000000000000000000000007F7F007F7F
        007F7F007F7F007F7F007F7F007F7F007F7F007F7F007F7F007F7F007F7F007F
        7F007F7F007F7F007F7F007F7F007F7F007F7F007F7F007F7F007F7F007F7F00
        7F7F007F7F007F7F007F7F007F7F007F7F007F7F007F7F007F7F007F7F007F7F
        007F7F007F7F007F7F007F7F007F7F007F7F7F7F7F7F7F7F007F7F007F7F007F
        7F007F7F007F7F007F7F007F7F007F7F007F7F007F7F007F7F007F7F007F7F00
        7F7F007F7F007F7F007F7FFFFFFF007F7F007F7F007F7F007F7F007F7F007F7F
        007F7F007F7F007F7F007F7F007F7F007F7F007F7F007F7F007F7F0000FF0000
        7F00007F7F7F7F007F7F007F7F007F7F007F7F007F7F0000FF7F7F7F007F7F00
        7F7F007F7F007F7F007F7F007F7F007F7F007F7F7F7F7F7F7F7FFFFFFF007F7F
        007F7F007F7F007F7F007F7F007F7FFFFFFF007F7F007F7F007F7F007F7F007F
        7F007F7F007F7F0000FF00007F00007F00007F7F7F7F007F7F007F7F007F7F00
        00FF00007F00007F7F7F7F007F7F007F7F007F7F007F7F007F7F007F7F7F7F7F
        FFFFFF007F7F7F7F7FFFFFFF007F7F007F7F007F7FFFFFFF7F7F7F7F7F7FFFFF
        FF007F7F007F7F007F7F007F7F007F7F007F7F0000FF00007F00007F00007F00
        007F7F7F7F007F7F0000FF00007F00007F00007F00007F7F7F7F007F7F007F7F
        007F7F007F7F007F7F7F7F7FFFFFFF007F7F007F7F7F7F7FFFFFFF007F7FFFFF
        FF7F7F7F007F7F007F7F7F7F7FFFFFFF007F7F007F7F007F7F007F7F007F7F00
        7F7F0000FF00007F00007F00007F00007F7F7F7F00007F00007F00007F00007F
        00007F7F7F7F007F7F007F7F007F7F007F7F007F7F7F7F7FFFFFFF007F7F007F
        7F007F7F7F7F7FFFFFFF7F7F7F007F7F007F7F007F7F007F7F7F7F7FFFFFFF00
        7F7F007F7F007F7F007F7F007F7F007F7F0000FF00007F00007F00007F00007F
        00007F00007F00007F00007F7F7F7F007F7F007F7F007F7F007F7F007F7F007F
        7F007F7F7F7F7FFFFFFF007F7F007F7F007F7F7F7F7F007F7F007F7F007F7F00
        7F7FFFFFFF7F7F7F007F7F007F7F007F7F007F7F007F7F007F7F007F7F007F7F
        0000FF00007F00007F00007F00007F00007F00007F7F7F7F007F7F007F7F007F
        7F007F7F007F7F007F7F007F7F007F7F007F7F7F7F7FFFFFFF007F7F007F7F00
        7F7F007F7F007F7F007F7FFFFFFF7F7F7F007F7F007F7F007F7F007F7F007F7F
        007F7F007F7F007F7F007F7F007F7F00007F00007F00007F00007F00007F7F7F
        7F007F7F007F7F007F7F007F7F007F7F007F7F007F7F007F7F007F7F007F7F00
        7F7F7F7F7FFFFFFF007F7F007F7F007F7F007F7F007F7F7F7F7F007F7F007F7F
        007F7F007F7F007F7F007F7F007F7F007F7F007F7F007F7F007F7F0000FF0000
        7F00007F00007F00007F7F7F7F007F7F007F7F007F7F007F7F007F7F007F7F00
        7F7F007F7F007F7F007F7F007F7F007F7F7F7F7FFFFFFF007F7F007F7F007F7F
        7F7F7F007F7F007F7F007F7F007F7F007F7F007F7F007F7F007F7F007F7F007F
        7F007F7F0000FF00007F00007F00007F00007F00007F7F7F7F007F7F007F7F00
        7F7F007F7F007F7F007F7F007F7F007F7F007F7F007F7F007F7F007F7F7F7F7F
        007F7F007F7F007F7F007F7F7F7F7FFFFFFF007F7F007F7F007F7F007F7F007F
        7F007F7F007F7F007F7F007F7F0000FF00007F00007F00007F7F7F7F00007F00
        007F00007F7F7F7F007F7F007F7F007F7F007F7F007F7F007F7F007F7F007F7F
        007F7F007F7F7F7F7F007F7F007F7F007F7F007F7F007F7F7F7F7FFFFFFF007F
        7F007F7F007F7F007F7F007F7F007F7F007F7F007F7F0000FF00007F00007F00
        007F7F7F7F007F7F0000FF00007F00007F00007F7F7F7F007F7F007F7F007F7F
        007F7F007F7F007F7F007F7F007F7F7F7F7F007F7F007F7F007F7F7F7F7FFFFF
        FF007F7F007F7F7F7F7FFFFFFF007F7F007F7F007F7F007F7F007F7F007F7F00
        7F7F0000FF00007F00007F7F7F7F007F7F007F7F007F7F0000FF00007F00007F
        00007F7F7F7F007F7F007F7F007F7F007F7F007F7F007F7F7F7F7FFFFFFF007F
        7F007F7F7F7F7F007F7F7F7F7FFFFFFF007F7F007F7F7F7F7FFFFFFF007F7F00
        7F7F007F7F007F7F007F7F007F7F007F7F0000FF00007F007F7F007F7F007F7F
        007F7F007F7F0000FF00007F00007F00007F007F7F007F7F007F7F007F7F007F
        7F007F7F7F7F7FFFFFFFFFFFFF7F7F7F007F7F007F7F007F7F7F7F7FFFFFFF00
        7F7F007F7F7F7F7FFFFFFF007F7F007F7F007F7F007F7F007F7F007F7F007F7F
        007F7F007F7F007F7F007F7F007F7F007F7F007F7F0000FF00007F0000FF007F
        7F007F7F007F7F007F7F007F7F007F7F007F7F7F7F7F7F7F7F007F7F007F7F00
        7F7F007F7F007F7F7F7F7FFFFFFFFFFFFFFFFFFF7F7F7F007F7F007F7F007F7F
        007F7F007F7F007F7F007F7F007F7F007F7F007F7F007F7F007F7F007F7F007F
        7F007F7F007F7F007F7F007F7F007F7F007F7F007F7F007F7F007F7F007F7F00
        7F7F007F7F007F7F007F7F007F7F007F7F007F7F007F7F7F7F7F7F7F7F7F7F7F
        007F7F007F7F007F7F007F7F007F7F007F7F007F7F007F7F007F7F007F7F007F
        7F007F7F007F7F007F7F007F7F007F7F007F7F007F7F007F7F007F7F007F7F00
        7F7F007F7F007F7F007F7F007F7F007F7F007F7F007F7F007F7F007F7F007F7F
        007F7F007F7F007F7F007F7F007F7F007F7F}
      NumGlyphs = 2
    end
    object E_SetHead: TEdit
      Left = 249
      Top = 25
      Width = 330
      Height = 20
      AutoSize = False
      MaxLength = 50
      TabOrder = 4
      OnKeyDown = KeyDown
    end
    object E_SetName: TEdit
      Left = 73
      Top = 25
      Width = 170
      Height = 20
      AutoSize = False
      TabOrder = 3
      OnKeyDown = KeyDown
    end
    object LB_Database: TListBox
      Left = 16
      Top = 85
      Width = 110
      Height = 140
      ItemHeight = 13
      MultiSelect = True
      TabOrder = 5
      OnDblClick = B_AddFieldClick
      OnEnter = LB_DatabaseEnter
      OnExit = LB_DatabaseExit
      OnKeyDown = LB_DatabaserKeyDown
    end
    object LB_Viewer: TListBox
      Left = 180
      Top = 85
      Width = 110
      Height = 140
      ItemHeight = 13
      TabOrder = 6
      OnClick = LB_ViewerClick
      OnEnter = LB_ViewerEnter
      OnExit = LB_ViewerExit
      OnKeyDown = LB_ViewerKeyDown
    end
    object B_AddField: TBitBtn
      Left = 133
      Top = 169
      Width = 40
      Height = 25
      Caption = '>>'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -20
      Font.Name = 'MS Sans Serif'
      Font.Style = [fsBold]
      ParentFont = False
      TabOrder = 1
      OnClick = B_AddFieldClick
      OnKeyDown = KeyDown
    end
    object B_RemoveField: TBitBtn
      Left = 133
      Top = 200
      Width = 40
      Height = 25
      Caption = '<<'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -20
      Font.Name = 'MS Sans Serif'
      Font.Style = [fsBold]
      ParentFont = False
      TabOrder = 0
      OnClick = B_RemoveFieldClick
      OnKeyDown = KeyDown
    end
    object GroupBox1: TGroupBox
      Left = 305
      Top = 126
      Width = 271
      Height = 99
      Caption = 'Zarovnávanie  udajov'
      TabOrder = 9
      object RB_AlignRight: TRadioButton
        Left = 12
        Top = 22
        Width = 250
        Height = 17
        Caption = 'Zarovnavat do prava'
        TabOrder = 0
        OnClick = RB_AligntClick
        OnKeyDown = KeyDown
      end
      object RB_AlignLeft: TRadioButton
        Left = 12
        Top = 46
        Width = 250
        Height = 17
        Caption = 'Zarovnavat do ¾ava'
        TabOrder = 1
        OnClick = RB_AligntClick
        OnKeyDown = KeyDown
      end
      object RB_AlignCenter: TRadioButton
        Left = 12
        Top = 70
        Width = 250
        Height = 17
        Caption = 'Zarovnavat do stred'
        TabOrder = 2
        OnClick = RB_AligntClick
        OnKeyDown = KeyDown
      end
    end
    object E_CollumnName: TNameEdit
      Left = 339
      Top = 76
      Width = 240
      Height = 20
      AutoSize = False
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -13
      Font.Name = 'Arial'
      Font.Style = []
      MaxLength = 30
      ParentFont = False
      TabOrder = 7
      OnExit = E_CollumnNameSizeExit
      OnKeyDown = KeyDown
    end
    object E_CollumnSize: TLongEdit
      Left = 339
      Top = 99
      Width = 30
      Height = 20
      AutoSize = False
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -13
      Font.Name = 'Arial'
      Font.Style = []
      MaxLength = 7
      ParentFont = False
      TabOrder = 8
      Text = '0'
      OnExit = E_CollumnNameSizeExit
      OnKeyDown = KeyDown
      Long = 0
    end
    object BitBtn1: TBitBtn
      Left = 133
      Top = 86
      Width = 40
      Height = 25
      Caption = '->'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -20
      Font.Name = 'MS Sans Serif'
      Font.Style = [fsBold]
      ParentFont = False
      TabOrder = 11
      OnClick = B_AddFieldClick
      OnKeyDown = KeyDown
    end
    object BitBtn2: TBitBtn
      Left = 133
      Top = 117
      Width = 40
      Height = 25
      Caption = '<-'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -20
      Font.Name = 'MS Sans Serif'
      Font.Style = [fsBold]
      ParentFont = False
      TabOrder = 12
      OnClick = B_RemoveFieldClick
      OnKeyDown = KeyDown
    end
  end
end
