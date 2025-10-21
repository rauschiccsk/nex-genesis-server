object F_NexCls: TF_NexCls
  Left = 454
  Top = 250
  BorderStyle = bsNone
  Caption = 'Ukon'#269'enie NEX'
  ClientHeight = 95
  ClientWidth = 727
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
  object P_Main: TxpSinglePanel
    Left = 0
    Top = 0
    Width = 727
    Height = 95
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
    object L_Head: TxpLabel
      Left = 8
      Top = 16
      Width = 713
      Height = 24
      SystemColor = False
      Alignment = taCenter
      AutoSize = False
      Caption = 'Ukon'#269'enie informa'#269'n'#233'ho syst'#233'mu NEX'
      Font.Charset = EASTEUROPE_CHARSET
      Font.Color = 13107200
      Font.Height = -21
      Font.Name = 'Arial'
      Font.Style = [fsBold]
      ParentFont = False
    end
    object L_Title: TxpLabel
      Left = 6
      Top = 40
      Width = 713
      Height = 24
      SystemColor = False
      Alignment = taCenter
      AutoSize = False
      Caption = 'NEX'
      Font.Charset = EASTEUROPE_CHARSET
      Font.Color = 13107200
      Font.Height = -21
      Font.Name = 'Arial'
      Font.Style = [fsBold]
      ParentFont = False
    end
    object PB_Ind: TProgressBar
      Left = 8
      Top = 72
      Width = 713
      Height = 17
      Min = 0
      Max = 100
      TabOrder = 0
    end
  end
end
