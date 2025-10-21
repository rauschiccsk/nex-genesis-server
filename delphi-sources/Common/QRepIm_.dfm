object F_ImageList: TF_ImageList
  Left = 199
  Top = 114
  Width = 307
  Height = 149
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
  object LV_ImageList: TListView
    Left = 0
    Top = 0
    Width = 299
    Height = 122
    Align = alClient
    Columns = <>
    ColumnClick = False
    TabOrder = 0
    OnDblClick = LV_ImageListDblClick
    OnKeyDown = LV_ImageListKeyDown
  end
end
