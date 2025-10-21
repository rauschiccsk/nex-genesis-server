object LogView_F: TLogView_F
  Left = 308
  Top = 165
  BorderStyle = bsDialog
  Caption = 'Prezeranie LOG suborov'
  ClientHeight = 516
  ClientWidth = 698
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = True
  Position = poScreenCenter
  OnCreate = FormCreate
  PixelsPerInch = 96
  TextHeight = 13
  object Panel1: TPanel
    Left = 0
    Top = 475
    Width = 698
    Height = 41
    Align = alBottom
    TabOrder = 0
    DesignSize = (
      698
      41)
    object BitBtn1: TBitBtn
      Left = 530
      Top = 8
      Width = 75
      Height = 25
      Anchors = [akRight, akBottom]
      Caption = '&OK'
      TabOrder = 0
      Kind = bkOK
    end
    object BitBtn2: TBitBtn
      Left = 614
      Top = 8
      Width = 75
      Height = 25
      Anchors = [akRight, akBottom]
      Caption = '&Cancel'
      TabOrder = 1
      Kind = bkCancel
    end
    object Edit1: TEdit
      Left = 4
      Top = 10
      Width = 351
      Height = 21
      ReadOnly = True
      TabOrder = 2
      Text = 'Edit1'
    end
    object Button1: TButton
      Left = 354
      Top = 9
      Width = 25
      Height = 25
      Caption = '...'
      TabOrder = 3
      OnClick = Button1Click
    end
    object E_Refresh: TCheckBox
      Left = 383
      Top = 13
      Width = 146
      Height = 17
      Caption = 'Obovovat po               s'
      Checked = True
      State = cbChecked
      TabOrder = 4
      OnClick = E_RefreshClick
      OnExit = E_RefreshClick
    end
    object E_RefTime: TSpinEdit
      Left = 468
      Top = 11
      Width = 39
      Height = 22
      MaxValue = 0
      MinValue = 0
      TabOrder = 5
      Value = 10
      OnChange = E_RefTimeChange
    end
  end
  object StrList: TMemo
    Left = 0
    Top = 0
    Width = 698
    Height = 475
    Align = alClient
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clBlack
    Font.Height = -12
    Font.Name = 'Arial'
    Font.Style = []
    ParentFont = False
    ScrollBars = ssVertical
    TabOrder = 1
    WordWrap = False
  end
  object Timer1: TTimer
    Interval = 10000
    OnTimer = Timer1Timer
    Left = 8
    Top = 16
  end
  object OpenDialog1: TOpenDialog
    DefaultExt = '*.log'
    Filter = 'LOG|*.log|TXT|*.txt|ALL|*.*|Error|*.err'
    Left = 48
    Top = 16
  end
end
