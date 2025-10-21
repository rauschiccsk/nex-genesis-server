object F_CalcFldInfo: TF_CalcFldInfo
  Left = 338
  Top = 191
  Width = 361
  Height = 179
  Caption = 'Súèet položiek od vybraného záznamu'
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  PixelsPerInch = 96
  TextHeight = 13
  object Bevel1: TBevel
    Left = 9
    Top = 8
    Width = 337
    Height = 106
  end
  object Label1: TLabel
    Left = 20
    Top = 16
    Width = 104
    Height = 17
    AutoSize = False
    Caption = 'Pole databázy è.'
    Font.Charset = EASTEUROPE_CHARSET
    Font.Color = clWindowText
    Font.Height = -15
    Font.Name = 'Times New Roman'
    Font.Style = []
    ParentFont = False
  end
  object Label2: TLabel
    Left = 20
    Top = 40
    Width = 150
    Height = 17
    AutoSize = False
    Caption = 'Poèet záznamov :'
    Font.Charset = EASTEUROPE_CHARSET
    Font.Color = clWindowText
    Font.Height = -15
    Font.Name = 'Times New Roman'
    Font.Style = []
    ParentFont = False
  end
  object Label3: TLabel
    Left = 20
    Top = 64
    Width = 150
    Height = 17
    AutoSize = False
    Caption = 'Celková hodnota :'
    Font.Charset = EASTEUROPE_CHARSET
    Font.Color = clWindowText
    Font.Height = -15
    Font.Name = 'Times New Roman'
    Font.Style = []
    ParentFont = False
  end
  object Label4: TLabel
    Left = 20
    Top = 88
    Width = 150
    Height = 17
    AutoSize = False
    Caption = 'Aritmetický priemer :'
    Font.Charset = EASTEUROPE_CHARSET
    Font.Color = clWindowText
    Font.Height = -15
    Font.Name = 'Times New Roman'
    Font.Style = []
    ParentFont = False
  end
  object Label5: TLabel
    Left = 180
    Top = 16
    Width = 68
    Height = 17
    Caption = 'Fieldname'
    Font.Charset = EASTEUROPE_CHARSET
    Font.Color = clWindowText
    Font.Height = -15
    Font.Name = 'Times New Roman'
    Font.Style = [fsBold]
    ParentFont = False
  end
  object Label6: TLabel
    Left = 180
    Top = 40
    Width = 66
    Height = 17
    Caption = 'RecCount'
    Font.Charset = EASTEUROPE_CHARSET
    Font.Color = clWindowText
    Font.Height = -15
    Font.Name = 'Times New Roman'
    Font.Style = [fsBold]
    ParentFont = False
  end
  object Label7: TLabel
    Left = 180
    Top = 64
    Width = 60
    Height = 17
    Caption = 'Summary'
    Font.Charset = EASTEUROPE_CHARSET
    Font.Color = clWindowText
    Font.Height = -15
    Font.Name = 'Times New Roman'
    Font.Style = [fsBold]
    ParentFont = False
  end
  object Label8: TLabel
    Left = 180
    Top = 88
    Width = 56
    Height = 17
    Caption = 'Average'
    Font.Charset = EASTEUROPE_CHARSET
    Font.Color = clWindowText
    Font.Height = -15
    Font.Name = 'Times New Roman'
    Font.Style = [fsBold]
    ParentFont = False
  end
  object Label9: TLabel
    Left = 129
    Top = 16
    Width = 40
    Height = 17
    AutoSize = False
    Caption = '1 :'
    Font.Charset = EASTEUROPE_CHARSET
    Font.Color = clWindowText
    Font.Height = -15
    Font.Name = 'Times New Roman'
    Font.Style = []
    ParentFont = False
  end
  object Button1: TButton
    Left = 131
    Top = 124
    Width = 90
    Height = 22
    Caption = 'OK'
    ModalResult = 1
    TabOrder = 0
    OnClick = Button1Click
    OnKeyDown = Button1KeyDown
  end
end
