object TblRefF: TTblRefF
  Left = 248
  Top = 152
  Width = 433
  Height = 365
  Caption = 'TblRefF'
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  OnDestroy = FormDestroy
  PixelsPerInch = 96
  TextHeight = 13
  object Tv_TblLst: TTreeView
    Left = 0
    Top = 0
    Width = 425
    Height = 331
    Align = alClient
    Indent = 19
    TabOrder = 0
  end
  object Timer: TTimer
    OnTimer = TimerTimer
    Left = 16
    Top = 16
  end
end
