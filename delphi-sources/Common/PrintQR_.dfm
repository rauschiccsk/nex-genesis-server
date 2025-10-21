object Form1: TForm1
  Left = 195
  Top = 109
  Width = 655
  Height = 523
  Caption = 'Form1'
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  Scaled = False
  OnCreate = FormCreate
  PixelsPerInch = 96
  TextHeight = 13
  object Label1: TLabel
    Left = 8
    Top = 8
    Width = 84
    Height = 13
    AutoSize = False
    Caption = 'ReportName'
  end
  object Label2: TLabel
    Left = 8
    Top = 32
    Width = 85
    Height = 13
    AutoSize = False
    Caption = 'Level'
  end
  object Label3: TLabel
    Left = 8
    Top = 56
    Width = 85
    Height = 13
    AutoSize = False
    Caption = 'FirmaName'
  end
  object Label4: TLabel
    Left = 8
    Top = 80
    Width = 85
    Height = 13
    AutoSize = False
    Caption = 'UserName'
  end
  object Label5: TLabel
    Left = 8
    Top = 104
    Width = 85
    Height = 13
    AutoSize = False
    Caption = 'PrivatPath'
  end
  object L_About: TLabel
    Left = 8
    Top = 128
    Width = 85
    Height = 13
    AutoSize = False
    Caption = 'About'
  end
  object E_RepName: TEdit
    Left = 96
    Top = 4
    Width = 541
    Height = 21
    TabOrder = 0
    Text = 'PROBA'
  end
  object Button1: TButton
    Left = 200
    Top = 148
    Width = 189
    Height = 41
    Caption = 'TlaË'
    TabOrder = 1
    OnClick = Button1Click
  end
  object CB_Level: TComboBox
    Left = 96
    Top = 28
    Width = 57
    Height = 21
    ItemHeight = 13
    TabOrder = 2
    Items.Strings = (
      '0'
      '1'
      '2'
      '3'
      '4'
      '5')
  end
  object E_FirmaName: TEdit
    Left = 96
    Top = 52
    Width = 545
    Height = 21
    TabOrder = 3
  end
  object E_UserName: TEdit
    Left = 96
    Top = 76
    Width = 121
    Height = 21
    TabOrder = 4
  end
  object E_PrivatPath: TEdit
    Left = 96
    Top = 100
    Width = 545
    Height = 21
    TabOrder = 5
  end
  object CB_PrintDemo: TCheckBox
    Left = 96
    Top = 148
    Width = 97
    Height = 17
    Caption = 'Print DEMO'
    TabOrder = 6
  end
  object CB_PrintAbout: TCheckBox
    Left = 96
    Top = 168
    Width = 97
    Height = 17
    Caption = 'Print About'
    TabOrder = 7
  end
  object E_About: TEdit
    Left = 96
    Top = 124
    Width = 545
    Height = 21
    TabOrder = 8
  end
  object Memo1: TMemo
    Left = 4
    Top = 192
    Width = 633
    Height = 301
    Lines.Strings = (
      
        'Programov˝ modul PrintQR je prÌklad na pouûÌvanie tlaËovÈho mana' +
        'ûera.'
      ''
      
        'Hlavn˝ modul tlaËovÈho manaûera je PQRep_. Tento modul Ôalej pou' +
        'ûÌva moduly: PQRepR_ a Preview_.'
      
        'TlaËov˝ manaûer nasledovne treba zaintegrovaù do vlastnÈho progr' +
        'amu:'
      ''
      'uses PQRep_;'
      ''
      'Spustenie:   F_PQRep.Execute ('#39'c:\report\GSCAT);'
      
        'kde parameter je n·zov tlaËovej masky  s cestou, ale boz rozöÌre' +
        'nia.'
      ''
      
        'PouûÌvanÈ datab·zovÈ s˙bory musia byù na componente TDataModul, ' +
        'ktor˝ musÌ byù vytvoren˝ vaplik·ciÌ, napr.:'
      'Application.CreateForm(TDataModule1, DataModule1);'
      ''
      
        'Pred spustenÌm tlaËovÈho manaûera treba nastaviù nasledovnÈ konö' +
        'tanty:'
      
        'cUserRepLevel - ˙roveÚ prihlasovanÈho uûÌvateæa. MÙûe byù od 0 d' +
        'o 5. Pri spusteni tlaËovÈho manaûera bud˙ naËÌtanÈ len tlaËovÈ m' +
        'asky, ktorÈ maju ˙roveÚ (level) <= cUserRepLevel'
      'cFirmaName - N·zov firmy'
      
        'cUserName - prihlasovacie meno uûÌvateæa. InicializaËnÈ ˙daje s˙' +
        ' uloûenÈ do s˙boru UserName s rozöÌrenÌm QRI (QuickReportIni) . ' +
        'Tento s˙bor obsahuje pre jednotlivÈ tlaËovÈ masky pouûÌvan˝ tlaË' +
        'iareÚ, poËet kopÌ a naposledy pouûÌvan· maska pre a jednotliv˝ch' +
        ' typy.'
      
        'cPrivatPath - Pracovn˝ adres·r prihl·senÈho uûÌvateæa. Sem uloûi' +
        ' QRI s˙bor.'
      
        'cPrintDemo - prepÌnaË, Ëi treba tlaËiù riadok DEMO. (v pripade D' +
        'EMO verziÌ)'
      
        'cPrintAbout - prepÌnaË, Ëi treba tlaËiù text do p‰tiËky, napr.: ' +
        'sÈriovÈ ËÌslo, n·zov naöej firmy a n·zov programu: NO-00-00300, ' +
        ' NEX Office od firmy IdentCode Consulting s.r.o.'
      'cAbout - text, ktor˙ treba vytlaËiù do p‰tiËky.'
      ''
      ''
      '****************************************************'
      ''
      
        'Programov˝ modul QRep je prÌklad na pouûÌvanie navrhovaËa tlaËov' +
        'ej masky. '
      
        'Pre prÌklad, s˙ pouûÌvanÈ dve DataModul-i: DataModule1 - obsahuj' +
        'e tabuæku Table1 s datab·zov˝m s˙borom GSCat.DB a DataModule2 - ' +
        'obsahuje tabuæku DBFTable  s datab·zov˝m s˙borom animals.dbf.'
      
        'Pri aplik·ciÌ na vlastn˝ program, treba odstr·niù tieto DataModu' +
        'l-i a pridaù vlastnÈ (ich poËet nie je limitovanÈ), podmienkou j' +
        'e, ûe treba vytvoriù na aplik·ciu, napr.:'
      'Application.CreateForm(TDataModule1, DataModule1);'
      ''
      
        'Komponenty maj˙ vlastnosti totoûnÈ s komponentami QuickReport, a' +
        ' s˙ pridanÈ nasledovnÈ premennÈ:'
      'PAGECOUNT - poËet str·n'
      'FIRMANAME - n·zov firmy'
      'PRINTDATE - systÈmov˝ d·tum'
      'PRINTTIME - systÈmov˝ Ëas'
      'REPFILE - n·zov s˙boru tlaËovej masky'
      ''
      
        'Tento zoznam sa d· editovaù pri vlastnoti tlaËovej masky (typ: Q' +
        'uickRep) tlaËÌtko Functions.'
      
        'PouûÌvaù t˝chto premenn˝ch sa d· cez vzorcovÈ pole (Expr) tak, û' +
        'e do editora Expression treba napÌsaù n·zov premennej.'
      
        'Ak v tlaËovej maske je pouûÌvanÈ premennÈ PAGECOUNT, treba poËÌt' +
        'aù s t˝m, ûe pred vytlaËenÌ alebo prezeranÌm automaticky urobÌ p' +
        'repoËet str·n, ale st˝m spomal˝ pr·cu.'
      ''
      
        'Pri komponente QuickRep pri tlaËÌtku Description je moûnÈ zadaù ' +
        'n·zov tlaËovej masky, podæa ktorÈho mÙûe uûÌvateæ vybraù tlaËov˙' +
        ' masku v tlaËovom manaûeri.')
    ScrollBars = ssBoth
    TabOrder = 9
  end
end
