object F_FldEditSlct: TF_FldEditSlct
  Left = 197
  Top = 107
  Width = 316
  Height = 141
  Caption = 'F_FldEditSlct'
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  PixelsPerInch = 96
  TextHeight = 13
  object Label1: TLabel
    Left = 16
    Top = 8
    Width = 60
    Height = 15
    AutoSize = False
    Caption = 'Pole è.1 :'
    Font.Charset = EASTEUROPE_CHARSET
    Font.Color = clWindowText
    Font.Height = -13
    Font.Name = 'Times New Roman'
    Font.Style = [fsBold]
    ParentFont = False
  end
  object Label2: TLabel
    Left = 16
    Top = 32
    Width = 60
    Height = 15
    AutoSize = False
    Caption = 'Pole è.2 :'
    Font.Charset = EASTEUROPE_CHARSET
    Font.Color = clWindowText
    Font.Height = -13
    Font.Name = 'Times New Roman'
    Font.Style = [fsBold]
    ParentFont = False
  end
  object Label3: TLabel
    Left = 80
    Top = 8
    Width = 221
    Height = 15
    AutoSize = False
    Caption = '******************************'
    Font.Charset = EASTEUROPE_CHARSET
    Font.Color = clWindowText
    Font.Height = -13
    Font.Name = 'Times New Roman'
    Font.Style = [fsBold]
    ParentFont = False
  end
  object Label4: TLabel
    Left = 80
    Top = 32
    Width = 221
    Height = 15
    AutoSize = False
    Caption = '******************************'
    Font.Charset = EASTEUROPE_CHARSET
    Font.Color = clWindowText
    Font.Height = -13
    Font.Name = 'Times New Roman'
    Font.Style = [fsBold]
    ParentFont = False
  end
  object ComboBox1: TComboBox
    Left = 16
    Top = 80
    Width = 273
    Height = 21
    Style = csDropDownList
    ItemHeight = 13
    TabOrder = 0
    OnDblClick = ComboBox1DblClick
    OnKeyDown = ComboBox1KeyDown
    Items.Strings = (
      'Pole è .1 ako PriceEdit'
      'Pole è .1 ako ValueEdit'
      'Pole è .1 ako QuantEdit'
      'Pole è .1 ako BarCodeEdit'
      'Pole è .1 ako VatEdit'
      'Pole è .1 ako NameEdit'
      'Polia è .1 a 2 spolu ako CodeEdit'
      'Pole è .1 ako LongEdit'
      'Pole è .1 ako Edit'
      'neimportovat'
      'Pole è .1 ako PrcEdit')
  end
  object CheckBox1: TCheckBox
    Left = 16
    Top = 56
    Width = 273
    Height = 17
    Caption = 'Vzdy pouzit tento typ editora pre toto pole'
    TabOrder = 1
    OnClick = CheckBox1Click
  end
end
