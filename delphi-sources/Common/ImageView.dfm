object FF_Image: TFF_Image
  Left = 291
  Top = 103
  ActiveControl = FileEdit
  BorderIcons = [biSystemMenu]
  BorderStyle = bsSingle
  Caption = 'Image Viewer'
  ClientHeight = 353
  ClientWidth = 502
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clBlack
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = [fsBold]
  Icon.Data = {
    0000010001002020100000000000E80200001600000028000000200000004000
    0000010004000000000080020000000000000000000000000000000000000000
    000000008000008000000080800080000000800080008080000080808000C0C0
    C0000000FF0000FF000000FFFF00FF000000FF00FF00FFFF8000FFFFFF000000
    0000777777777777777777777000000000000000000000000000000000000000
    0000000000000000000000000000000000000000000000000000000000000000
    0000000000000000000000000000000000000000000000000000000000000000
    0003333333330000000000000000000000033CCCCC3300000000000000000000
    0003CCCCCCC3000000000000000000000003CCCCCCC300000000000000000000
    0003CCCCCCC30000000000000000000000033CCCCC3300000000000000000000
    0003333333330000000000000000000000000000000000000000000000000000
    0000000000000000000000000000000000000000000000000000000000000000
    0000000000000000000000000000000000000000000000000000000000000000
    0000000000000000000000000000000000000000000000000000000000000000
    00000000000000000000000000000000000000000000FF000000000000000000
    000000000000FFF000000000000000000000000000000FFF0000000000000000
    00000000000000FFF000000000000000000000000000000FFF00000000000000
    0000000000000000FFF000000000000000000000000000000FFF000000000000
    000000000000000000FFF000000000000000000000000000000F000000000000
    000000000000000000000000000000000000000000000000000000000000FF00
    0007FC00001FFC00001FFFF803FFFF80E1FFFE0070FFFE00F83FFE00FC3FFE00
    FE1FFE00FF1FFE00FF0FFE00FF8FFE00FF87FFFFFF87FFFC7F87FFFC6F87FFFC
    470FFFF80F0FFFF81E1FFFF83C3FFFF0187FFFE000FFFFC401FFFFEE03FFFFFF
    01FFFFFF80FFFFFFC07FFFFFE03FFFFFF01FFFFFF81FFFFFFC0FFFFFFEDF}
  OldCreateOrder = True
  Position = poScreenCenter
  OnClose = FormClose
  OnCreate = FormCreate
  OnHide = FormHide
  PixelsPerInch = 96
  TextHeight = 13
  object Bevel1: TBevel
    Left = 316
    Top = 5
    Width = 171
    Height = 121
  end
  object Bevel2: TBevel
    Left = 317
    Top = 132
    Width = 170
    Height = 177
  end
  object Label2: TLabel
    Left = 324
    Top = 290
    Width = 113
    Height = 13
    Caption = '&Number of Glyphs - '
    Enabled = False
    FocusControl = UpDown1
  end
  object DirectoryListBox1: TDirectoryListBox
    Left = 8
    Top = 13
    Width = 148
    Height = 292
    FileList = FileListBox1
    IntegralHeight = True
    ItemHeight = 16
    TabOrder = 1
  end
  object DriveComboBox1: TDriveComboBox
    Left = 8
    Top = 322
    Width = 148
    Height = 19
    DirList = DirectoryListBox1
    TabOrder = 3
  end
  object FileEdit: TEdit
    Left = 166
    Top = 13
    Width = 139
    Height = 21
    TabOrder = 0
    Text = '*.bmp;*.ico;*.wmf;*.emf'
    OnKeyPress = FileEditKeyPress
  end
  object UpDownGroup: TGroupBox
    Left = 323
    Top = 158
    Width = 154
    Height = 60
    Caption = 'Up / Down'
    TabOrder = 5
    object SpeedButton1: TSpeedButton
      Left = 116
      Top = 26
      Width = 25
      Height = 25
      AllowAllUp = True
      GroupIndex = 1
    end
    object BitBtn1: TBitBtn
      Left = 12
      Top = 18
      Width = 92
      Height = 33
      TabOrder = 0
    end
  end
  object DisabledGrp: TGroupBox
    Left = 323
    Top = 220
    Width = 154
    Height = 60
    Caption = 'Disabled'
    TabOrder = 7
    object SpeedButton2: TSpeedButton
      Left = 116
      Top = 25
      Width = 25
      Height = 25
      Enabled = False
    end
    object BitBtn2: TBitBtn
      Left = 11
      Top = 18
      Width = 92
      Height = 33
      Enabled = False
      TabOrder = 0
    end
  end
  object Panel1: TPanel
    Left = 324
    Top = 12
    Width = 153
    Height = 80
    BevelInner = bvLowered
    TabOrder = 8
    object Image1: TImage
      Left = 2
      Top = 2
      Width = 149
      Height = 76
      Align = alClient
    end
  end
  object FileListBox1: TFileListBox
    Left = 166
    Top = 41
    Width = 139
    Height = 264
    FileEdit = FileEdit
    ItemHeight = 13
    Mask = '*.bmp;*.ico;*.wmf;*.emf'
    TabOrder = 2
    OnClick = FileListBox1Click
  end
  object ViewBtn: TBitBtn
    Left = 325
    Top = 98
    Width = 63
    Height = 24
    Caption = '&Full View'
    TabOrder = 6
    OnClick = ViewBtnClick
  end
  object FilterComboBox1: TFilterComboBox
    Left = 168
    Top = 322
    Width = 140
    Height = 21
    FileList = FileListBox1
    Filter = 
      'Image Files (*.bmp, *.ico, *.wmf, *.emf)|*.bmp;*.ico;*.wmf;*.emf' +
      '|Bitmap Files (*.bmp)|*.bmp|Icons (*.ico)|*.ico|Metafiles (*.wmf' +
      ', *.emf)|*.wmf;*.emf|All files (*.*)|*.*'
    TabOrder = 4
  end
  object GlyphCheck: TCheckBox
    Left = 327
    Top = 137
    Width = 104
    Height = 17
    Caption = '&View as Glyph'
    TabOrder = 9
    OnClick = GlyphCheckClick
  end
  object StretchCheck: TCheckBox
    Left = 413
    Top = 96
    Width = 64
    Height = 17
    Caption = '&Stretch'
    TabOrder = 11
    OnClick = StretchCheckClick
  end
  object UpDownEdit: TEdit
    Left = 439
    Top = 286
    Width = 24
    Height = 21
    Enabled = False
    TabOrder = 10
    Text = '1'
    OnChange = UpDownEditChange
  end
  object UpDown1: TUpDown
    Left = 463
    Top = 286
    Width = 15
    Height = 21
    Associate = UpDownEdit
    Enabled = False
    Min = 0
    Position = 1
    TabOrder = 12
    Wrap = False
  end
  object OkBtn: TBitBtn
    Left = 317
    Top = 320
    Width = 75
    Height = 25
    TabOrder = 13
    Kind = bkOK
  end
  object CancelBtn: TBitBtn
    Left = 412
    Top = 320
    Width = 75
    Height = 25
    TabOrder = 14
    Kind = bkCancel
  end
end
