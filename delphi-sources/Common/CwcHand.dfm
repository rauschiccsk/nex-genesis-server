object Cwc: TCwc
  Left = 243
  Top = 138
  Width = 544
  Height = 77
  Caption = 'Cwc'
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  OnCreate = FormCreate
  OnDestroy = FormDestroy
  PixelsPerInch = 96
  TextHeight = 13
  object btCWC: TNexBtrTable
    DelToTXT = True
    BtrErrorLogfile = 0
    ShowErrMsg = True
    OpenMode = 0
    RecNo = 0
    FixedName = 'CWC'
    DOSStrings = True
    AutoCreate = True
    CrtDat = True
    Modify = True
    Sended = True
    Archive = True
    FieldDefs = <>
    Left = 16
    Top = 8
  end
  object ptCWC: TNexPxTable
    Active = False
    TableName = 'CWC'
    DefName = 'CWC.TDF'
    AutoCreate = True
    AutoDelete = True
    AutoTableName = True
    Left = 56
    Top = 8
  end
end
