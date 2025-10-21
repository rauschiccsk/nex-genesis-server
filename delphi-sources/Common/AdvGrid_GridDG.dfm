object F_GridDG: TF_GridDG
  Left = 196
  Top = 117
  BorderStyle = bsDialog
  Caption = 'Zmena nastavenia zoznamov'
  ClientHeight = 540
  ClientWidth = 606
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Arial'
  Font.Style = []
  OldCreateOrder = False
  Position = poOwnerFormCenter
  OnCreate = FormCreate
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 14
  object Bevel1: TBevel
    Left = 7
    Top = 83
    Width = 591
    Height = 83
  end
  object L_ViewerHead: TLabel
    Left = 254
    Top = 92
    Width = 335
    Height = 14
    Alignment = taCenter
    AutoSize = False
    Caption = 'Hlavicka tabulky'
  end
  object Bevel3: TBevel
    Left = 20
    Top = 110
    Width = 50
    Height = 20
  end
  object L_SetNumTxt: TLabel
    Left = 15
    Top = 92
    Width = 52
    Height = 14
    Alignment = taCenter
    Caption = 'Oznacenie'
  end
  object L_SetName: TLabel
    Left = 71
    Top = 92
    Width = 176
    Height = 14
    Alignment = taCenter
    AutoSize = False
    Caption = 'Nazov nastavenia'
  end
  object L_SetNum: TLabel
    Left = 30
    Top = 112
    Width = 23
    Height = 16
    Caption = 'D01'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -13
    Font.Name = 'Arial'
    Font.Style = [fsBold]
    ParentFont = False
  end
  object L_SetList: TLabel
    Left = 12
    Top = 18
    Width = 164
    Height = 14
    Caption = 'Vyber nadefinovanych zoznamov'
  end
  object Bevel2: TBevel
    Left = 73
    Top = 110
    Width = 176
    Height = 20
    Shape = bsFrame
    Style = bsRaised
  end
  object Bevel4: TBevel
    Left = 254
    Top = 110
    Width = 335
    Height = 20
    Shape = bsFrame
    Style = bsRaised
  end
  object L_Database: TLabel
    Left = 8
    Top = 175
    Width = 150
    Height = 13
    Alignment = taCenter
    AutoSize = False
    Caption = 'Databaza'
    Color = clGray
    ParentColor = False
  end
  object L_Show: TLabel
    Left = 200
    Top = 175
    Width = 150
    Height = 13
    Alignment = taCenter
    AutoSize = False
    Caption = 'Zobrazit'
    Color = clGray
    ParentColor = False
  end
  object SB_CopySelItm: TSpeedButton
    Left = 172
    Top = 193
    Width = 19
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
    Left = 168
    Top = 221
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
    Left = 168
    Top = 257
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
    Left = 168
    Top = 285
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
    Left = 244
    Top = 343
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
    Left = 280
    Top = 343
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
  object SB_HeadFontBold: TSpeedButton
    Left = 500
    Top = 136
    Width = 23
    Height = 22
    AllowAllUp = True
    GroupIndex = 1
    Caption = 'B'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -16
    Font.Name = 'Courier'
    Font.Style = [fsBold]
    ParentFont = False
  end
  object SB_HeadFontItalic: TSpeedButton
    Left = 532
    Top = 136
    Width = 23
    Height = 22
    AllowAllUp = True
    GroupIndex = 2
    Caption = 'I'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -16
    Font.Name = 'Courier'
    Font.Style = [fsItalic]
    ParentFont = False
  end
  object Label1: TLabel
    Left = 152
    Top = 140
    Width = 91
    Height = 14
    Caption = 'Typ p'#237'sma hlavi'#269'ky'
  end
  object Label2: TLabel
    Left = 8
    Top = 374
    Width = 96
    Height = 14
    Caption = 'Typ p'#237'sma zoznamu'
  end
  object SB_GridFontBold: TSpeedButton
    Left = 302
    Top = 370
    Width = 23
    Height = 22
    AllowAllUp = True
    GroupIndex = 4
    Caption = 'B'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -16
    Font.Name = 'Courier'
    Font.Style = [fsBold]
    ParentFont = False
  end
  object SB_GridFontItalic: TSpeedButton
    Left = 326
    Top = 370
    Width = 23
    Height = 22
    AllowAllUp = True
    GroupIndex = 5
    Caption = 'I'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -16
    Font.Name = 'Courier'
    Font.Style = [fsItalic]
    ParentFont = False
  end
  object L_DGD: TLabel
    Left = 360
    Top = 175
    Width = 236
    Height = 13
    Alignment = taCenter
    AutoSize = False
    Caption = 'Databaza'
    Color = clSilver
    ParentColor = False
  end
  object L_FldInfo: TLabel
    Left = 8
    Top = 344
    Width = 149
    Height = 14
    Alignment = taCenter
    AutoSize = False
    Caption = '_'
    Color = 13756137
    ParentColor = False
    ParentShowHint = False
    ShowHint = True
  end
  object CB_SetList: TComboBox
    Left = 182
    Top = 14
    Width = 211
    Height = 22
    Style = csDropDownList
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'Arial'
    Font.Style = [fsBold]
    ItemHeight = 14
    ParentFont = False
    TabOrder = 0
    OnChange = CB_SetListChange
    OnKeyDown = FldEditKeyDown
  end
  object E_SetHead: TEdit
    Left = 256
    Top = 112
    Width = 330
    Height = 15
    AutoSize = False
    BorderStyle = bsNone
    TabOrder = 2
    OnKeyDown = FldEditKeyDown
  end
  object E_SetName: TEdit
    Left = 76
    Top = 112
    Width = 170
    Height = 15
    AutoSize = False
    BorderStyle = bsNone
    TabOrder = 1
    OnExit = E_SetNameExit
    OnKeyDown = FldEditKeyDown
  end
  object LB_AllFields: TListBox
    Left = 8
    Top = 189
    Width = 150
    Height = 149
    DragMode = dmAutomatic
    ItemHeight = 14
    MultiSelect = True
    TabOrder = 3
    OnClick = LB_AllFieldsClick
    OnDblClick = LB_AllFieldsDblClick
    OnDragDrop = LB_AllFieldsDragDrop
    OnDragOver = LB_AllFieldsDragOver
    OnEnter = LB_AllFieldsEnter
    OnExit = LB_AllFieldsExit
    OnKeyDown = LB_AllFieldsKeyDown
  end
  object LB_Viewer: TListBox
    Left = 200
    Top = 189
    Width = 150
    Height = 149
    DragMode = dmAutomatic
    ItemHeight = 14
    MultiSelect = True
    TabOrder = 4
    OnClick = LB_ViewerClick
    OnDblClick = LB_ViewerDblClick
    OnDragDrop = LB_ViewerDragDrop
    OnDragOver = LB_ViewerDragOver
    OnEnter = LB_ViewerEnter
    OnKeyDown = LB_ViewerKeyDown
  end
  object GB_DGD: TPanel
    Left = 360
    Top = 189
    Width = 237
    Height = 296
    BevelInner = bvRaised
    BevelOuter = bvLowered
    TabOrder = 5
    object L_ReadOnly: TLabel
      Left = 8
      Top = 130
      Width = 97
      Height = 14
      Caption = 'Modifikovatelne pole'
    end
    object L_Format: TLabel
      Left = 8
      Top = 106
      Width = 33
      Height = 14
      Caption = 'Format'
    end
    object L_Alignment: TLabel
      Left = 8
      Top = 82
      Width = 85
      Height = 14
      Caption = 'Zarovnavat udaje'
    end
    object L_Width: TLabel
      Left = 8
      Top = 57
      Width = 24
      Height = 14
      Caption = 'Sirka'
    end
    object L_Name: TLabel
      Left = 8
      Top = 9
      Width = 31
      Height = 14
      Caption = 'Nazov'
    end
    object Bevel5: TBevel
      Left = 48
      Top = 6
      Width = 180
      Height = 20
      Shape = bsFrame
      Style = bsRaised
    end
    object Bevel6: TBevel
      Left = 93
      Top = 54
      Width = 51
      Height = 20
      Shape = bsFrame
      Style = bsRaised
    end
    object Bevel7: TBevel
      Left = 189
      Top = 54
      Width = 36
      Height = 20
      Shape = bsFrame
      Style = bsRaised
    end
    object L_DisplayWidth: TLabel
      Left = 64
      Top = 57
      Width = 24
      Height = 14
      Caption = 'body'
    end
    object L_DisplayWidthChar: TLabel
      Left = 156
      Top = 57
      Width = 29
      Height = 14
      Caption = 'znaky'
    end
    object E_DisplayName: TEdit
      Left = 50
      Top = 8
      Width = 175
      Height = 15
      BorderStyle = bsNone
      TabOrder = 0
      OnExit = FldEditExit
      OnKeyDown = FldEditKeyDown
    end
    object E_DisplayWidth: TEdit
      Left = 96
      Top = 56
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
      Top = 78
      Width = 85
      Height = 22
      Style = csDropDownList
      ItemHeight = 14
      TabOrder = 3
      OnExit = FldEditExit
      OnKeyDown = FldEditKeyDown
    end
    object CB_Format: TComboBox
      Left = 112
      Top = 102
      Width = 117
      Height = 22
      ItemHeight = 14
      TabOrder = 4
      OnExit = FldEditExit
      OnKeyDown = CB_FormatKeyDown
      Items.Strings = (
        ''
        '### ### ##0.00'
        '### ### ##0.000')
    end
    object CB_EditFld: TComboBox
      Left = 168
      Top = 126
      Width = 61
      Height = 22
      Style = csDropDownList
      ItemHeight = 14
      TabOrder = 5
      OnExit = FldEditExit
      OnKeyDown = CB_EditFldKeyDown
    end
    object E_DisplayWidthChar: TEdit
      Left = 192
      Top = 56
      Width = 30
      Height = 15
      BorderStyle = bsNone
      TabOrder = 2
      OnExit = E_DisplayWidthCharExit
      OnKeyDown = FldEditKeyDown
    end
    object BB_SetDefField: TButton
      Left = 20
      Top = 169
      Width = 193
      Height = 25
      Caption = 'Na'#269#237'tat z'#225'kladn'#233' parametre po'#318'a'
      TabOrder = 6
      OnClick = BB_SetDefFieldClick
    end
    object NI_FullName: TNameInfo
      Left = 8
      Top = 30
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
    object B_SetUniField: TButton
      Left = 20
      Top = 200
      Width = 193
      Height = 25
      Caption = 'Na'#269#237'ta'#357' univerz'#225'lne parametre po'#318'a'
      TabOrder = 8
      OnClick = B_SetUniFieldClick
    end
    object B_SaveDefField: TButton
      Left = 20
      Top = 230
      Width = 193
      Height = 25
      Caption = 'Ulo'#382'i'#357' ako z'#225'kladn'#233' nastavenie'
      TabOrder = 9
      OnClick = B_SaveDefFieldClick
    end
    object B_SaveUniField: TButton
      Left = 20
      Top = 260
      Width = 193
      Height = 25
      Caption = 'Ulo'#382'i'#357' ako univerz'#225'lne nastavenie'
      TabOrder = 10
      OnClick = B_SaveUniFieldClick
    end
  end
  object BB_NewDef: TBitBtn
    Left = 404
    Top = 4
    Width = 121
    Height = 25
    Caption = 'Nove zakladne'
    TabOrder = 8
    OnClick = BB_NewDefClick
    Glyph.Data = {
      76010000424D7601000000000000760000002800000020000000100000000100
      04000000000000010000130B0000130B00001000000000000000000000000000
      800000800000008080008000000080008000808000007F7F7F00BFBFBF000000
      FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFFFF00333333333333
      33333333FF33333333FF333993333333300033377F3333333777333993333333
      300033F77FFF3333377739999993333333333777777F3333333F399999933333
      33003777777333333377333993333333330033377F3333333377333993333333
      3333333773333333333F333333333333330033333333F33333773333333C3333
      330033333337FF3333773333333CC333333333FFFFF77FFF3FF33CCCCCCCCCC3
      993337777777777F77F33CCCCCCCCCC3993337777777777377333333333CC333
      333333333337733333FF3333333C333330003333333733333777333333333333
      3000333333333333377733333333333333333333333333333333}
    NumGlyphs = 2
  end
  object BB_Save: TBitBtn
    Left = 448
    Top = 510
    Width = 75
    Height = 25
    Caption = 'Ulo'#382'it'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'Arial'
    Font.Style = [fsBold]
    ParentFont = False
    TabOrder = 6
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
    Left = 524
    Top = 510
    Width = 75
    Height = 25
    Caption = 'Opusti'#357
    TabOrder = 7
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
  object BB_Delete: TBitBtn
    Left = 532
    Top = 16
    Width = 65
    Height = 25
    Caption = 'Zrusit'
    TabOrder = 9
    OnClick = BB_DeleteClick
    Glyph.Data = {
      76010000424D7601000000000000760000002800000020000000100000000100
      04000000000000010000130B0000130B00001000000000000000000000000000
      800000800000008080008000000080008000808000007F7F7F00BFBFBF000000
      FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFFFF00333333333333
      333333333333333333FF33333333333330003333333333333777333333333333
      300033FFFFFF3333377739999993333333333777777F3333333F399999933333
      3300377777733333337733333333333333003333333333333377333333333333
      3333333333333333333F333333333333330033333F33333333773333C3333333
      330033337F3333333377333CC3333333333333F77FFFFFFF3FF33CCCCCCCCCC3
      993337777777777F77F33CCCCCCCCCC399333777777777737733333CC3333333
      333333377F33333333FF3333C333333330003333733333333777333333333333
      3000333333333333377733333333333333333333333333333333}
    NumGlyphs = 2
  end
  object BB_DefEdit: TBitBtn
    Left = 13
    Top = 457
    Width = 336
    Height = 25
    Caption = 'Zmena z'#225'kladn'#253'ch '#250'dajov'
    TabOrder = 10
    OnClick = BB_DefEditClick
    Glyph.Data = {
      76010000424D7601000000000000760000002800000020000000100000000100
      04000000000000010000120B0000120B00001000000000000000000000000000
      800000800000008080008000000080008000808000007F7F7F00BFBFBF000000
      FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFFFF00333333000000
      000033333377777777773333330FFFFFFFF03FF3FF7FF33F3FF700300000FF0F
      00F077F777773F737737E00BFBFB0FFFFFF07773333F7F3333F7E0BFBF000FFF
      F0F077F3337773F3F737E0FBFBFBF0F00FF077F3333FF7F77F37E0BFBF00000B
      0FF077F3337777737337E0FBFBFBFBF0FFF077F33FFFFFF73337E0BF0000000F
      FFF077FF777777733FF7000BFB00B0FF00F07773FF77373377373330000B0FFF
      FFF03337777373333FF7333330B0FFFF00003333373733FF777733330B0FF00F
      0FF03333737F37737F373330B00FFFFF0F033337F77F33337F733309030FFFFF
      00333377737FFFFF773333303300000003333337337777777333}
    NumGlyphs = 2
  end
  object CB_HeadFont: TComboBox
    Left = 256
    Top = 136
    Width = 185
    Height = 22
    Hint = 'FontCharacterSet'
    ItemHeight = 14
    ParentShowHint = False
    ShowHint = True
    TabOrder = 11
    Items.Strings = (
      'ANSI_CHARSET'
      'DEFAULT_CHARSET'
      'SYMBOL_CHARSET'
      'MAC_CHARSET'
      'SHIFTJIS_CHARSET'
      'HANGEUL_CHARSET'
      'JOHAB_CHARSET'
      'GB2312_CHARSET'
      'CHINESEBIG5_CHARSET'
      'GREEK_CHARSET'
      'TURKISH_CHARSET'
      'VIETNAMESE_CHARSET'
      'HEBREW_CHARSET'
      'ARABIC_CHARSET'
      'BALTIC_CHARSET'
      'RUSSIAN_CHARSET'
      'THAI_CHARSET'
      'EASTEUROPE_CHARSET'
      'OEM_CHARSET')
  end
  object CB_GridFont: TComboBox
    Left = 108
    Top = 370
    Width = 151
    Height = 22
    Hint = 'FontCharacterSet'
    ItemHeight = 14
    ParentShowHint = False
    ShowHint = True
    TabOrder = 12
    Items.Strings = (
      'ANSI_CHARSET'
      'DEFAULT_CHARSET'
      'SYMBOL_CHARSET'
      'MAC_CHARSET'
      'SHIFTJIS_CHARSET'
      'HANGEUL_CHARSET'
      'JOHAB_CHARSET'
      'GB2312_CHARSET'
      'CHINESEBIG5_CHARSET'
      'GREEK_CHARSET'
      'TURKISH_CHARSET'
      'VIETNAMESE_CHARSET'
      'HEBREW_CHARSET'
      'ARABIC_CHARSET'
      'BALTIC_CHARSET'
      'RUSSIAN_CHARSET'
      'THAI_CHARSET'
      'EASTEUROPE_CHARSET'
      'OEM_CHARSET')
  end
  object BB_SetDefViewFields: TButton
    Left = 12
    Top = 398
    Width = 219
    Height = 25
    Caption = 'Nastavi'#357' z'#225'kl. parametrov zobrazen'#253'ch pol'#237
    TabOrder = 13
    OnClick = BB_SetDefViewFieldsClick
  end
  object CB_HeadFontSize: TComboBox
    Left = 448
    Top = 136
    Width = 40
    Height = 21
    Hint = 'FontSize'
    Font.Charset = EASTEUROPE_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'MS Sans Serif'
    Font.Style = []
    ItemHeight = 13
    ParentFont = False
    ParentShowHint = False
    ShowHint = True
    TabOrder = 14
    Items.Strings = (
      '8'
      '9'
      '10'
      '11'
      '12'
      '13'
      '14'
      '15'
      '16'
      '17'
      '18'
      '19'
      '20'
      '22'
      '24'
      '26'
      '28'
      '30'
      '34'
      '38'
      '42'
      '46'
      '50')
  end
  object CB_GridFontSize: TComboBox
    Left = 262
    Top = 370
    Width = 40
    Height = 21
    Hint = 'FontSize'
    Font.Charset = EASTEUROPE_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'MS Sans Serif'
    Font.Style = []
    ItemHeight = 13
    ParentFont = False
    ParentShowHint = False
    ShowHint = True
    TabOrder = 15
    Items.Strings = (
      '8'
      '9'
      '10'
      '11'
      '12'
      '13'
      '14'
      '15'
      '16'
      '17'
      '18'
      '19'
      '20'
      '22'
      '24'
      '26'
      '28'
      '30'
      '34'
      '38'
      '42'
      '46'
      '50')
  end
  object BB_NewUser: TBitBtn
    Left = 404
    Top = 32
    Width = 121
    Height = 25
    Caption = 'Nove uzivatelske'
    TabOrder = 16
    OnClick = BB_NewUserClick
    Glyph.Data = {
      76010000424D7601000000000000760000002800000020000000100000000100
      04000000000000010000130B0000130B00001000000000000000000000000000
      800000800000008080008000000080008000808000007F7F7F00BFBFBF000000
      FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFFFF00333333333333
      33333333FF33333333FF333993333333300033377F3333333777333993333333
      300033F77FFF3333377739999993333333333777777F3333333F399999933333
      33003777777333333377333993333333330033377F3333333377333993333333
      3333333773333333333F333333333333330033333333F33333773333333C3333
      330033333337FF3333773333333CC333333333FFFFF77FFF3FF33CCCCCCCCCC3
      993337777777777F77F33CCCCCCCCCC3993337777777777377333333333CC333
      333333333337733333FF3333333C333330003333333733333777333333333333
      3000333333333333377733333333333333333333333333333333}
    NumGlyphs = 2
  end
  object ChB_ShowOnlyUserSet: TCheckBox
    Left = 12
    Top = 46
    Width = 185
    Height = 17
    Caption = 'Zobrazit len vlastne zoznamy'
    TabOrder = 17
  end
  object P_ColorGrp: TxpSinglePanel
    Left = 8
    Top = 491
    Width = 437
    Height = 44
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
    Font.Name = 'Arial'
    Font.Style = []
    TabOrder = 18
    object L_ColorGrp: TxpLabel
      Left = 4
      Top = 15
      Width = 93
      Height = 14
      SystemColor = False
      Caption = 'Farebn'#233' ozna'#269'enia'
    end
    object CB_ColorGrp: TxpComboBox
      Left = 104
      Top = 11
      Width = 261
      Height = 22
      Style = csDropDownList
      ItemHeight = 16
      Sorted = True
      TabOrder = 0
      Items.Strings = (
        'ziadn'#233)
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
    object B_AddColorGrp: TxpBitBtn
      Left = 368
      Top = 8
      Width = 65
      Height = 29
      SystemColor = True
      Caption = 'Prida'#357
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
      FocusWhenClick = True
      OnClick = B_AddColorGrpClick
    end
  end
  object ChB_ServiceOnly: TCheckBox
    Left = 220
    Top = 46
    Width = 169
    Height = 17
    Caption = 'Len pre servisn'#233' '#250#269'ely'
    TabOrder = 19
  end
  object ChB_CopyDGD: TCheckBox
    Left = 404
    Top = 60
    Width = 189
    Height = 17
    Caption = 'Kop'#237'rovat aktu'#225'lne nastavenie'
    TabOrder = 20
  end
  object B_SaveDefFields: TButton
    Left = 12
    Top = 428
    Width = 245
    Height = 25
    Caption = 'Ulo'#382'i'#357' pre z'#225'kladn'#233' nastavenie'
    TabOrder = 21
    OnClick = B_SaveDefFieldsClick
  end
  object ChB_SaveDefFieldsNew: TCheckBox
    Left = 264
    Top = 432
    Width = 77
    Height = 17
    Caption = 'Len nov'#233
    Checked = True
    State = cbChecked
    TabOrder = 22
  end
  object ChB_SaveUniFields: TCheckBox
    Left = 448
    Top = 490
    Width = 149
    Height = 17
    Caption = 'Ulo'#382'i'#357' aj pre univerz'#225'lne'
    TabOrder = 23
  end
  object B_DelNotExist: TButton
    Left = 238
    Top = 398
    Width = 112
    Height = 25
    Caption = 'Zru'#353'i'#357' neexist. polia'
    TabOrder = 24
    OnClick = B_DelNotExistClick
  end
  object ActionList1: TActionList
    Left = 536
    Top = 48
    object Action1: TAction
      Caption = 'Action1'
      ShortCut = 27
      OnExecute = Action1Execute
    end
  end
end
