object Nxp: TNxp
  Left = 231
  Top = 173
  Width = 696
  Height = 79
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
  object btNXPDEF: TNexBtrTable
    ShowErrMsg = True
    OpenMode = 0
    RecNo = 0
    FixedName = 'NXPDEF'
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
  object ptNXPDEF: TNexPxTable
    Active = False
    TableName = 'NXPDEF'
    FixName = 'NXPDEF'
    DefName = 'NXPDEF.TDF'
    AutoCreate = True
    AutoDelete = True
    AutoTableName = True
    Left = 48
    Top = 8
  end
end
