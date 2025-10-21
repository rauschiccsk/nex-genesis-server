object F_QRNewSpec: TF_QRNewSpec
  Left = 168
  Top = 39
  Width = 639
  Height = 543
  Caption = 'Vygenerovanie tla'#269'ovej masky'
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
  object Label7: TLabel
    Left = 12
    Top = 6
    Width = 104
    Height = 13
    Caption = 'N'#225'zov tla'#269'ovej masky'
  end
  object GroupBox1: TGroupBox
    Left = 0
    Top = 114
    Width = 429
    Height = 85
    Caption = 'Tla'#269'i'#357' '#250'dajov do p'#228'ti'#269'ky'
    TabOrder = 2
    object CB_PrintActPgNum: TCheckBox
      Left = 12
      Top = 20
      Width = 213
      Height = 17
      Caption = #268#237'slo aktu'#225'lnej strany'
      Checked = True
      State = cbChecked
      TabOrder = 0
      OnClick = CB_PrintActPgNumClick
    end
    object CB_PrintActPgQnt: TCheckBox
      Left = 12
      Top = 40
      Width = 201
      Height = 17
      Caption = #268#237'slo aktu'#225'lnej strany a po'#269'et str'#225'n'
      TabOrder = 1
      OnClick = CB_PrintActPgQntClick
    end
    object CB_PrintRepFile: TCheckBox
      Left = 12
      Top = 60
      Width = 257
      Height = 17
      Caption = 'N'#225'zov s'#250'boru tla'#269'ovej masky'
      Checked = True
      State = cbChecked
      TabOrder = 2
    end
  end
  object GroupBox2: TGroupBox
    Left = 0
    Top = 26
    Width = 429
    Height = 85
    Caption = 'Tla'#269'i'#357' '#250'dajov v hlavi'#269'ke '
    TabOrder = 1
    object CB_PrintFirmaName: TCheckBox
      Left = 12
      Top = 16
      Width = 177
      Height = 17
      Caption = 'N'#225'zov firmy'
      Checked = True
      State = cbChecked
      TabOrder = 0
    end
    object CB_PrintDate: TCheckBox
      Left = 12
      Top = 36
      Width = 61
      Height = 17
      Caption = 'D'#225'tum '
      Checked = True
      State = cbChecked
      TabOrder = 1
    end
    object CB_PrintTitle: TCheckBox
      Left = 12
      Top = 56
      Width = 69
      Height = 17
      Caption = 'Hlavi'#269'ka'
      Checked = True
      State = cbChecked
      TabOrder = 2
    end
    object E_Title: TEdit
      Left = 84
      Top = 54
      Width = 337
      Height = 21
      TabOrder = 3
      OnKeyDown = KeyDown
    end
  end
  object GroupBox3: TGroupBox
    Left = 434
    Top = 26
    Width = 187
    Height = 85
    Caption = 'Typ tla'#269'ovej masky'
    TabOrder = 3
    object RB_NoFrame: TRadioButton
      Left = 8
      Top = 20
      Width = 113
      Height = 17
      Caption = 'bez r'#225'm'#269'eka'
      TabOrder = 0
    end
    object RB_WithFrame: TRadioButton
      Left = 8
      Top = 60
      Width = 113
      Height = 17
      Caption = 's r'#225'm'#269'ekmi'
      Checked = True
      TabOrder = 1
      TabStop = True
    end
    object RB_MinFrame: TRadioButton
      Left = 8
      Top = 40
      Width = 149
      Height = 17
      Caption = 's minim'#225'lnym r'#225'm'#269'ekom'
      TabOrder = 2
    end
  end
  object BB_Create: TBitBtn
    Left = 476
    Top = 124
    Width = 101
    Height = 25
    Caption = 'Vygenerova'#357
    TabOrder = 5
    OnClick = BB_CreateClick
    Glyph.Data = {
      66010000424D6601000000000000760000002800000014000000140000000100
      040000000000F000000000000000000000001000000000000000000000000000
      80000080000000808000800000008000800080800000C0C0C000808080000000
      FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFFFF00777777777777
      7777777700007777777777777777777700007777777777777777777700007777
      7777777777777777000077770000000000077777000077770FFFFFFFFF077777
      000077770F00F0000F077777000077770FFFFFFFFF077777000077770F00F000
      0F077777000077770FFFFFFFFF077777000077770FFFFFFFFF07777700007777
      0F00F0000F077777000077770FFFFFFFFF077777000077770FFFFFF000077777
      000077770F0000F0F0777777000077770FFFFFF0077777770000777700000000
      7777777700007777777777777777777700007777777777777777777700007777
      77777777777777770000}
  end
  object BB_Cancel: TBitBtn
    Left = 476
    Top = 164
    Width = 101
    Height = 25
    Caption = 'Storno'
    TabOrder = 6
    OnClick = BB_CancelClick
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
  object GroupBox4: TGroupBox
    Left = 0
    Top = 202
    Width = 623
    Height = 301
    Caption = 'Polo'#382'ky'
    TabOrder = 4
    object Label1: TLabel
      Left = 16
      Top = 20
      Width = 86
      Height = 13
      Caption = 'Datab'#225'zov'#253' s'#250'bor'
    end
    object SB_CopySelItm: TSpeedButton
      Left = 178
      Top = 120
      Width = 23
      Height = 22
      Hint = 'Zobrazit vybrane polozky'
      Glyph.Data = {
        76010000424D7601000000000000760000002800000020000000100000000100
        04000000000000010000C40E0000C40E00001000000000000000000000000000
        800000800000008080008000000080008000808000007F7F7F00BFBFBF000000
        FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFFFF00333333333333
        3333333333333333333333333333333333333333333333333333333333333333
        3333333333333333333333333333333333333333333FF3333333333333003333
        3333333333773FF3333333333300003333333333337F773FF333333333000000
        33333FFFFF7F33773FF30000000000000033777777733333773F000000000000
        00007FFFFFFF33333F7700000000000000337777777F333F7733333333000000
        33333333337F3F77333333333300003333333333337F77333333333333003333
        3333333333773333333333333333333333333333333333333333333333333333
        3333333333333333333333333333333333333333333333333333}
      NumGlyphs = 2
      ParentShowHint = False
      ShowHint = True
      OnClick = SB_CopySelItmClick
    end
    object SB_RemoveSelItm: TSpeedButton
      Left = 178
      Top = 148
      Width = 23
      Height = 22
      Hint = 'Skryt vybrane polozky'
      Glyph.Data = {
        76010000424D7601000000000000760000002800000020000000100000000100
        04000000000000010000C40E0000C40E00001000000000000000000000000000
        800000800000008080008000000080008000808000007F7F7F00BFBFBF000000
        FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFFFF00333333333333
        3333333333333333333333333333333333333333333333333333333333333333
        3333333333333FF3333333333333003333333333333F77F33333333333000033
        333333333F7737F333333333000000333333333F773337FFFFFF330000000000
        00003F773333377777770000000000000000773FF33333FFFFF7330000000000
        000033773FF33777777733330000003333333333773FF7F33333333333000033
        33333333337737F3333333333333003333333333333377333333333333333333
        3333333333333333333333333333333333333333333333333333333333333333
        3333333333333333333333333333333333333333333333333333}
      NumGlyphs = 2
      ParentShowHint = False
      ShowHint = True
      OnClick = SB_RemoveSelItmClick
    end
    object SB_CopyAllItm: TSpeedButton
      Left = 178
      Top = 184
      Width = 23
      Height = 22
      Hint = 'Zobrazit vsetkych poloziek'
      Glyph.Data = {
        F6000000424DF600000000000000760000002800000010000000100000000100
        04000000000080000000C40E0000C40E00001000000000000000000000000000
        800000800000008080008000000080008000808000007F7F7F00BFBFBF000000
        FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFFFF00333333333333
        3333303333330333333330033333003333333000333300033333300003330000
        3333300000330000033330000003000000333000000000000003300000000000
        0003300000030000003330000033000003333000033300003333300033330003
        3333300333330033333330333333033333333333333333333333}
      ParentShowHint = False
      ShowHint = True
      OnClick = SB_CopyAllItmClick
    end
    object SB_RemoveAllItm: TSpeedButton
      Left = 178
      Top = 212
      Width = 23
      Height = 22
      Hint = 'Skryt vsetkych poloziek'
      Glyph.Data = {
        F6000000424DF600000000000000760000002800000010000000100000000100
        04000000000080000000C40E0000C40E00001000000000000000000000000000
        800000800000008080008000000080008000808000007F7F7F00BFBFBF000000
        FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFFFF00333333333333
        3333333333303333330333333300333330033333300033330003333300003330
        0003333000003300000333000000300000033000000000000003300000000000
        0003330000003000000333300000330000033333000033300003333330003333
        0003333333003333300333333330333333033333333333333333}
      ParentShowHint = False
      ShowHint = True
      OnClick = SB_RemoveAllItmClick
    end
    object SB_Up: TSpeedButton
      Left = 256
      Top = 272
      Width = 23
      Height = 22
      Hint = 'Posun smerom hore'
      Glyph.Data = {
        76010000424D7601000000000000760000002800000020000000100000000100
        04000000000000010000C40E0000C40E00001000000000000000000000000000
        800000800000008080008000000080008000808000007F7F7F00BFBFBF000000
        FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFFFF00333333000333
        3333333333777F33333333333300033333333333337F7F333333333333000333
        33333333337F7F33333333333300033333333333337F7F333333333333000333
        33333333337F7F33333333333300033333333333FF7F7FFFF333333000000000
        3333333777737777F333333000000000333333373F3333373333333300000003
        333333337F33337F33333333000000033333333373F333733333333330000033
        3333333337F337F3333333333000003333333333373F37333333333333000333
        33333333337F7F33333333333300033333333333337373333333333333303333
        333333333337F333333333333330333333333333333733333333}
      NumGlyphs = 2
      ParentShowHint = False
      ShowHint = True
      OnClick = SB_UpClick
    end
    object SB_Down: TSpeedButton
      Left = 292
      Top = 272
      Width = 23
      Height = 22
      Hint = 'Posun smerom dole'
      Glyph.Data = {
        76010000424D7601000000000000760000002800000020000000100000000100
        04000000000000010000C40E0000C40E00001000000000000000000000000000
        800000800000008080008000000080008000808000007F7F7F00BFBFBF000000
        FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFFFF00333333303333
        333333333337F33333333333333033333333333333373F333333333333000333
        33333333337F7F33333333333300033333333333337373F33333333330000033
        3333333337F337F33333333330000033333333333733373F3333333300000003
        333333337F33337F33333333000000033333333373333373F333333000000000
        33333337FFFF3FF7F33333300000000033333337777F77773333333333000333
        33333333337F7F33333333333300033333333333337F7F333333333333000333
        33333333337F7F33333333333300033333333333337F7F333333333333000333
        33333333337F7F33333333333300033333333333337773333333}
      NumGlyphs = 2
      ParentShowHint = False
      ShowHint = True
      OnClick = SB_DownClick
    end
    object Label2: TLabel
      Left = 12
      Top = 52
      Width = 160
      Height = 13
      Alignment = taCenter
      AutoSize = False
      Caption = 'Zoznam v'#353'etk'#253'ch pol'#237
    end
    object Label3: TLabel
      Left = 208
      Top = 52
      Width = 160
      Height = 13
      Alignment = taCenter
      AutoSize = False
      Caption = 'Zoznam vytla'#269'en'#253'ch pol'#237
    end
    object CB_DataSet: TComboBox
      Left = 220
      Top = 16
      Width = 149
      Height = 21
      Style = csDropDownList
      ItemHeight = 13
      TabOrder = 0
      OnChange = CB_DataSetChange
    end
    object P_Data: TPanel
      Left = 380
      Top = 68
      Width = 237
      Height = 201
      BevelInner = bvRaised
      BevelOuter = bvLowered
      Enabled = False
      TabOrder = 3
      object L_Format: TLabel
        Left = 8
        Top = 146
        Width = 32
        Height = 13
        Caption = 'Form'#225't'
      end
      object L_Alignment: TLabel
        Left = 8
        Top = 90
        Width = 88
        Height = 13
        Caption = 'Zarovn'#225'va'#357' n'#225'zov'
      end
      object L_Width: TLabel
        Left = 12
        Top = 41
        Width = 25
        Height = 13
        Caption = #352#237'rka'
      end
      object L_Name: TLabel
        Left = 8
        Top = 17
        Width = 31
        Height = 13
        Caption = 'N'#225'zov'
      end
      object Bevel5: TBevel
        Left = 48
        Top = 14
        Width = 180
        Height = 20
        Shape = bsFrame
        Style = bsRaised
      end
      object Bevel6: TBevel
        Left = 89
        Top = 38
        Width = 51
        Height = 20
        Shape = bsFrame
        Style = bsRaised
      end
      object Bevel7: TBevel
        Left = 195
        Top = 38
        Width = 36
        Height = 20
        Shape = bsFrame
        Style = bsRaised
      end
      object L_DisplayWidth: TLabel
        Left = 52
        Top = 41
        Width = 23
        Height = 13
        Caption = 'body'
      end
      object L_DisplayWidthChar: TLabel
        Left = 162
        Top = 41
        Width = 28
        Height = 13
        Caption = 'znaky'
      end
      object Label4: TLabel
        Left = 8
        Top = 118
        Width = 85
        Height = 13
        Caption = 'Zarovn'#225'va'#357' '#250'daje'
      end
      object L_Fld: TLabel
        Left = 8
        Top = 4
        Width = 26
        Height = 13
        Caption = 'L_Fld'
        Visible = False
      end
      object Bevel1: TBevel
        Left = 89
        Top = 62
        Width = 36
        Height = 20
        Shape = bsFrame
        Style = bsRaised
      end
      object Label5: TLabel
        Left = 42
        Top = 66
        Width = 32
        Height = 13
        Caption = '1 znak'
      end
      object Label6: TLabel
        Left = 134
        Top = 66
        Width = 30
        Height = 13
        Caption = 'bodov'
      end
      object E_DisplayName: TEdit
        Left = 50
        Top = 16
        Width = 175
        Height = 15
        BorderStyle = bsNone
        TabOrder = 0
        OnExit = E_DisplayNameExit
        OnKeyDown = KeyDown
      end
      object E_DisplayWidth: TEdit
        Left = 92
        Top = 40
        Width = 45
        Height = 15
        BorderStyle = bsNone
        TabOrder = 1
        OnExit = E_DisplayWidthExit
        OnKeyDown = KeyDown
      end
      object CB_NameAlign: TComboBox
        Left = 144
        Top = 86
        Width = 85
        Height = 21
        Style = csDropDownList
        ItemHeight = 13
        TabOrder = 4
        OnExit = CB_NameAlignExit
        OnKeyDown = KeyDown
        Items.Strings = (
          'do '#318'ava'
          'v strede'
          'do prava')
      end
      object CB_Format: TComboBox
        Left = 52
        Top = 142
        Width = 177
        Height = 21
        ItemHeight = 13
        TabOrder = 6
        OnExit = CB_FormatExit
        OnKeyDown = KeyDown
        Items.Strings = (
          ''
          '### ### ##0.00'
          '### ### ##0.000')
      end
      object E_DisplayWidthChar: TEdit
        Left = 198
        Top = 40
        Width = 30
        Height = 15
        TabStop = False
        BorderStyle = bsNone
        TabOrder = 2
        OnExit = E_DisplayWidthCharExit
        OnKeyDown = KeyDown
      end
      object CB_Summary: TCheckBox
        Left = 8
        Top = 172
        Width = 97
        Height = 17
        Caption = 'Zosumarizova'#357
        TabOrder = 7
        OnExit = CB_SummaryExit
        OnKeyDown = CB_SummaryKeyDown
      end
      object CB_FldAlign: TComboBox
        Left = 144
        Top = 114
        Width = 85
        Height = 21
        Style = csDropDownList
        ItemHeight = 13
        TabOrder = 5
        OnExit = CB_FldAlignExit
        OnKeyDown = KeyDown
        Items.Strings = (
          'do '#318'ava'
          'v strede'
          'do prava')
      end
      object E_CharWidth: TEdit
        Left = 92
        Top = 64
        Width = 30
        Height = 15
        TabStop = False
        BorderStyle = bsNone
        TabOrder = 3
        Text = '8'
        OnKeyDown = KeyDown
      end
    end
    object LB_AllFields: TListBox
      Left = 12
      Top = 68
      Width = 160
      Height = 200
      DragMode = dmAutomatic
      ItemHeight = 13
      MultiSelect = True
      TabOrder = 1
      OnDblClick = LB_AllFieldsDblClick
      OnDragDrop = LB_AllFieldsDragDrop
      OnDragOver = LB_AllFieldsDragOver
      OnKeyDown = LB_AllFieldsKeyDown
    end
    object LB_PrintFields: TListBox
      Left = 208
      Top = 68
      Width = 160
      Height = 200
      DragMode = dmAutomatic
      ItemHeight = 13
      MultiSelect = True
      TabOrder = 2
      OnClick = LB_PrintFieldsClick
      OnDblClick = LB_PrintFieldsDblClick
      OnDragDrop = LB_PrintFieldsDragDrop
      OnDragOver = LB_PrintFieldsDragOver
      OnExit = LB_PrintFieldsExit
      OnKeyDown = LB_PrintFieldsKeyDown
    end
    object CB_DataModule: TComboBox
      Left = 120
      Top = 16
      Width = 90
      Height = 21
      Hint = 'DataModule'
      Style = csDropDownList
      ItemHeight = 13
      ParentShowHint = False
      ShowHint = True
      Sorted = True
      TabOrder = 4
      OnChange = CB_DataModuleChange
    end
  end
  object E_RepName: TEdit
    Left = 132
    Top = 2
    Width = 485
    Height = 21
    TabOrder = 0
    OnKeyDown = KeyDown
  end
end
