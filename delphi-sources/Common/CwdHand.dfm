object Cwd: TCwd
  Left = 243
  Top = 138
  Width = 544
  Height = 77
  Caption = 'Cwd'
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
  object btCWH: TNexBtrTable
    ShowErrMsg = True
    OpenMode = 0
    RecNo = 0
    FixedName = 'CWH'
    DOSStrings = True
    AutoCreate = True
    CrtDat = True
    Modify = True
    Sended = True
    Archive = True
    FieldDefs = <>
    Left = 42
    Top = 8
  end
  object btCWBLST: TNexBtrTable
    ShowErrMsg = True
    OpenMode = 0
    RecNo = 0
    FixedName = 'CWBLST'
    DOSStrings = True
    AutoCreate = True
    CrtDat = True
    Modify = True
    Sended = True
    Archive = True
    FieldDefs = <>
    Left = 8
    Top = 8
  end
end
