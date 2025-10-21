object F_GridDef: TF_GridDef
  Left = 214
  Top = 470
  Width = 407
  Height = 324
  Caption = 'Definovanie zakladnych parametrov poli databaz'
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Arial'
  Font.Style = []
  OldCreateOrder = False
  Position = poOwnerFormCenter
  OnCreate = FormCreate
  PixelsPerInch = 96
  TextHeight = 14
  object L_Show: TLabel
    Left = 4
    Top = 2
    Width = 150
    Height = 13
    Alignment = taCenter
    AutoSize = False
    Caption = 'Datab'#225'za'
    Color = clGray
    ParentColor = False
  end
  object SB_Up: TSpeedButton
    Left = 48
    Top = 192
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
    Left = 84
    Top = 192
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
  object LB_Default: TListBox
    Left = 4
    Top = 16
    Width = 150
    Height = 169
    DragMode = dmAutomatic
    ItemHeight = 14
    MultiSelect = True
    TabOrder = 0
    OnClick = LB_DefaultClick
    OnDragDrop = LB_DefaultDragDrop
    OnDragOver = LB_DefaultDragOver
    OnKeyDown = FldEditKeyDown
  end
  object BB_Save: TBitBtn
    Left = 236
    Top = 257
    Width = 75
    Height = 25
    Caption = 'Ulo'#382'i'#357
    TabOrder = 1
    OnClick = BB_SaveClick
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
  object BB_Exit: TBitBtn
    Left = 318
    Top = 257
    Width = 75
    Height = 25
    Caption = 'Opusti'#357
    TabOrder = 2
    OnClick = BB_ExitClick
    Glyph.Data = {
      76010000424D7601000000000000760000002800000020000000100000000100
      04000000000000010000120B0000120B00001000000000000000000000000000
      800000800000008080008000000080008000808000007F7F7F00BFBFBF000000
      FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFFFF00330000000000
      03333377777777777F333301BBBBBBBB033333773F3333337F3333011BBBBBBB
      0333337F73F333337F33330111BBBBBB0333337F373F33337F333301110BBBBB
      0333337F337F33337F333301110BBBBB0333337F337F33337F333301110BBBBB
      0333337F337F33337F333301110BBBBB0333337F337F33337F333301110BBBBB
      0333337F337F33337F333301110BBBBB0333337F337FF3337F33330111B0BBBB
      0333337F337733337F333301110BBBBB0333337F337F33337F333301110BBBBB
      0333337F3F7F33337F333301E10BBBBB0333337F7F7F33337F333301EE0BBBBB
      0333337F777FFFFF7F3333000000000003333377777777777333}
    NumGlyphs = 2
  end
  object GB_DGD: TGroupBox
    Left = 160
    Top = 4
    Width = 237
    Height = 181
    Font.Charset = EASTEUROPE_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'MS Sans Serif'
    Font.Style = []
    ParentFont = False
    TabOrder = 3
    object L_ReadOnly: TLabel
      Left = 8
      Top = 158
      Width = 98
      Height = 13
      Caption = 'Modifikovatelne pole'
    end
    object L_Format: TLabel
      Left = 8
      Top = 130
      Width = 32
      Height = 13
      Caption = 'Format'
    end
    object L_Alignment: TLabel
      Left = 8
      Top = 102
      Width = 84
      Height = 13
      Caption = 'Zarovnavat udaje'
    end
    object L_Width: TLabel
      Left = 8
      Top = 73
      Width = 24
      Height = 13
      Caption = 'Sirka'
    end
    object L_Name: TLabel
      Left = 8
      Top = 21
      Width = 31
      Height = 13
      Caption = 'Nazov'
      OnDblClick = L_NameDblClick
    end
    object Bevel5: TBevel
      Left = 48
      Top = 18
      Width = 180
      Height = 20
      Shape = bsFrame
      Style = bsRaised
    end
    object Bevel6: TBevel
      Left = 93
      Top = 70
      Width = 51
      Height = 20
      Shape = bsFrame
      Style = bsRaised
    end
    object Bevel7: TBevel
      Left = 189
      Top = 70
      Width = 36
      Height = 20
      Shape = bsFrame
      Style = bsRaised
    end
    object L_DisplayWidth: TLabel
      Left = 64
      Top = 73
      Width = 23
      Height = 13
      Caption = 'body'
    end
    object L_DisplayWidthChar: TLabel
      Left = 156
      Top = 73
      Width = 28
      Height = 13
      Caption = 'znaky'
    end
    object E_DisplayName: TEdit
      Left = 50
      Top = 20
      Width = 175
      Height = 15
      BorderStyle = bsNone
      TabOrder = 0
      OnExit = FldEditExit
      OnKeyDown = FldEditKeyDown
    end
    object E_DisplayWidth: TEdit
      Left = 96
      Top = 72
      Width = 45
      Height = 15
      TabStop = False
      BorderStyle = bsNone
      TabOrder = 1
      OnExit = E_DisplayWidthExit
      OnKeyDown = FldEditKeyDown
    end
    object CB_Alignment: TComboBox
      Left = 144
      Top = 98
      Width = 85
      Height = 21
      Style = csDropDownList
      ItemHeight = 13
      TabOrder = 2
      OnExit = FldEditExit
      OnKeyDown = FldEditKeyDown
    end
    object CB_Format: TComboBox
      Left = 112
      Top = 126
      Width = 117
      Height = 21
      ItemHeight = 13
      TabOrder = 3
      OnExit = FldEditExit
      OnKeyDown = FldEditKeyDown
      Items.Strings = (
        ''
        '### ### ##0.00'
        '### ### ##0.000')
    end
    object CB_EditFld: TComboBox
      Left = 168
      Top = 154
      Width = 61
      Height = 21
      Style = csDropDownList
      ItemHeight = 13
      TabOrder = 4
      OnExit = FldEditExit
      OnKeyDown = CB_EditFldKeyDown
    end
    object E_DisplayWidthChar: TEdit
      Left = 192
      Top = 72
      Width = 30
      Height = 15
      BorderStyle = bsNone
      TabOrder = 5
      OnExit = E_DisplayWidthCharExit
      OnKeyDown = FldEditKeyDown
    end
    object NI_FullName: TNameInfo
      Left = 8
      Top = 42
      Width = 219
      Height = 20
      Alignment = taLeftJustify
      Color = clBtnFace
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clNavy
      Font.Height = -11
      Font.Name = 'Arial'
      Font.Style = []
    end
  end
  object BB_RefreshFld: TButton
    Left = 8
    Top = 226
    Width = 145
    Height = 25
    Caption = 'Obnova pol'#237
    TabOrder = 4
    OnClick = BB_RefreshFldClick
  end
  object B_ColText: TButton
    Left = 8
    Top = 256
    Width = 145
    Height = 25
    Caption = 'Informa'#269'n'#233' texty farieb'
    TabOrder = 5
    OnClick = B_ColTextClick
  end
  object ActionList1: TActionList
    Left = 352
    Top = 204
    object Action1: TAction
      Caption = 'Action1'
      ShortCut = 27
      OnExecute = Action1Execute
    end
  end
end
