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
    Caption = 'Tla�'
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
      
        'Programov� modul PrintQR je pr�klad na pou��vanie tla�ov�ho mana' +
        '�era.'
      ''
      
        'Hlavn� modul tla�ov�ho mana�era je PQRep_. Tento modul �alej pou' +
        '��va moduly: PQRepR_ a Preview_.'
      
        'Tla�ov� mana�er nasledovne treba zaintegrova� do vlastn�ho progr' +
        'amu:'
      ''
      'uses PQRep_;'
      ''
      'Spustenie:   F_PQRep.Execute ('#39'c:\report\GSCAT);'
      
        'kde parameter je n�zov tla�ovej masky  s cestou, ale boz roz��re' +
        'nia.'
      ''
      
        'Pou��van� datab�zov� s�bory musia by� na componente TDataModul, ' +
        'ktor� mus� by� vytvoren� vaplik�ci�, napr.:'
      'Application.CreateForm(TDataModule1, DataModule1);'
      ''
      
        'Pred spusten�m tla�ov�ho mana�era treba nastavi� nasledovn� kon�' +
        'tanty:'
      
        'cUserRepLevel - �rove� prihlasovan�ho u��vate�a. M��e by� od 0 d' +
        'o 5. Pri spusteni tla�ov�ho mana�era bud� na��tan� len tla�ov� m' +
        'asky, ktor� maju �rove� (level) <= cUserRepLevel'
      'cFirmaName - N�zov firmy'
      
        'cUserName - prihlasovacie meno u��vate�a. Inicializa�n� �daje s�' +
        ' ulo�en� do s�boru UserName s roz��ren�m QRI (QuickReportIni) . ' +
        'Tento s�bor obsahuje pre jednotliv� tla�ov� masky pou��van� tla�' +
        'iare�, po�et kop� a naposledy pou��van� maska pre a jednotliv�ch' +
        ' typy.'
      
        'cPrivatPath - Pracovn� adres�r prihl�sen�ho u��vate�a. Sem ulo�i' +
        ' QRI s�bor.'
      
        'cPrintDemo - prep�na�, �i treba tla�i� riadok DEMO. (v pripade D' +
        'EMO verzi�)'
      
        'cPrintAbout - prep�na�, �i treba tla�i� text do p�ti�ky, napr.: ' +
        's�riov� ��slo, n�zov na�ej firmy a n�zov programu: NO-00-00300, ' +
        ' NEX Office od firmy IdentCode Consulting s.r.o.'
      'cAbout - text, ktor� treba vytla�i� do p�ti�ky.'
      ''
      ''
      '****************************************************'
      ''
      
        'Programov� modul QRep je pr�klad na pou��vanie navrhova�a tla�ov' +
        'ej masky. '
      
        'Pre pr�klad, s� pou��van� dve DataModul-i: DataModule1 - obsahuj' +
        'e tabu�ku Table1 s datab�zov�m s�borom GSCat.DB a DataModule2 - ' +
        'obsahuje tabu�ku DBFTable  s datab�zov�m s�borom animals.dbf.'
      
        'Pri aplik�ci� na vlastn� program, treba odstr�ni� tieto DataModu' +
        'l-i a prida� vlastn� (ich po�et nie je limitovan�), podmienkou j' +
        'e, �e treba vytvori� na aplik�ciu, napr.:'
      'Application.CreateForm(TDataModule1, DataModule1);'
      ''
      
        'Komponenty maj� vlastnosti toto�n� s komponentami QuickReport, a' +
        ' s� pridan� nasledovn� premenn�:'
      'PAGECOUNT - po�et str�n'
      'FIRMANAME - n�zov firmy'
      'PRINTDATE - syst�mov� d�tum'
      'PRINTTIME - syst�mov� �as'
      'REPFILE - n�zov s�boru tla�ovej masky'
      ''
      
        'Tento zoznam sa d� editova� pri vlastnoti tla�ovej masky (typ: Q' +
        'uickRep) tla��tko Functions.'
      
        'Pou��va� t�chto premenn�ch sa d� cez vzorcov� pole (Expr) tak, �' +
        'e do editora Expression treba nap�sa� n�zov premennej.'
      
        'Ak v tla�ovej maske je pou��van� premenn� PAGECOUNT, treba po��t' +
        'a� s t�m, �e pred vytla�en� alebo prezeran�m automaticky urob� p' +
        'repo�et str�n, ale st�m spomal� pr�cu.'
      ''
      
        'Pri komponente QuickRep pri tla��tku Description je mo�n� zada� ' +
        'n�zov tla�ovej masky, pod�a ktor�ho m��e u��vate� vybra� tla�ov�' +
        ' masku v tla�ovom mana�eri.')
    ScrollBars = ssBoth
    TabOrder = 9
  end
end
