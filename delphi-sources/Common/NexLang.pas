unit NexLang;

interface

uses
  IcTypes, IcVariab, IcEditors, IcInfoFields, IcConv, TxtWrap, TxtCut,
  BookList, NexPath, NexText, NexMsg, IniHand,
  Classes, Forms, Buttons, Menus, StdCtrls, QuickRpt, ActnList,
  QRCtrls, Controls, ComCtrls;

procedure LoadFormText (pForm:TForm; pSection:string); // Nacitanie textov formulára
procedure LoadReportText (pReport:TQuickRep; pSection:string);
function  IntUpCase (pChar:Char): Char;
function  IntUpperCase (pString:string): string;
function  GetFormFileName (pTag:longint):string; // Je to meno suboru, v ktorom su ukladane formulara - urci sa podla vlastnosti Tag

implementation

procedure LoadFormText (pForm:TForm; pSection:string);
var I:word;  mLabel: TLabel;     mBitBtn: TBitBtn;
    mBookList: TBookList;        mSpeedButton: TSpeedButton;
    mAction: TAction;            mCheckBox: TCheckBox;
    mRadioButton: TRadioButton;  mEdit: TEdit;
    mCodeEdit: TCodeEdit;        mSpecEdit: TSpecEdit;
    mGroupBox: TGroupBox;        mName:string;
    mTimeEdit: TTimeEdit;        mDateEdit: TDateEdit;
    mNT: TNexText;               mMenuItem: TMenuItem;
begin
  mNT := TNexText.Create (GetFormFileName(pForm.Tag)+'.TXT');
  mNT.SetSection (pSection);

  gvSys.EditFontSize := mNT.GetLong (pForm.Name+'.EditFontSize',gvSys.EditFontSize);
  gvSys.LabelFontSize := mNT.GetLong (pForm.Name+'.LabelFontSize',gvSys.LabelFontSize);
  gvSys.ButtonFontSize := mNT.GetLong (pForm.Name+'.ButtonFontSize',gvSys.ButtonFontSize);

  //  pForm.Font.Size := gNT.GetLong (pForm.Name+'.FontSize',pForm.Font.Size);
  pForm.Caption := mNT.GetText (pForm.Name+'.Caption',pForm.Caption);
  pForm.Font.Charset := gvSys.FontCharset;
  For I := 0 to pForm.ComponentCount-1 do begin
    // TLabel
    If (pForm.Components[I] is TLabel) then begin
      mLabel := (pForm.Components[I] as TLabel);
      If (Pos('Label',mLabel.Name)>0) then begin
        (pForm.Components[I] as TLabel).Caption := mNT.GetText (pForm.Name+'.'+mLabel.Name+'.Caption',mLabel.Caption);
        (pForm.Components[I] as TLabel).Font.Charset := gvSys.FontCharset;
        If (mLabel.Tag=0) then (pForm.Components[I] as TLabel).Font.Size := gvSys.LabelFontSize;
      end;
    end;
    // TBitBtn
    If (pForm.Components[I] is TBitBtn) then begin
      mBitBtn := (pForm.Components[I] as TBitBtn);
      If UpString(mBitBtn.Name)='B_SAVE' then begin
        gNT.SetSection ('GLOBAL');
        (pForm.Components[I] as TBitBtn).Caption := gNT.GetText ('B_Save.Caption',mBitBtn.Caption);
        (pForm.Components[I] as TBitBtn).Font.Charset := gvSys.FontCharset;
        gNT.SetSection (pSection);
      end
      else begin
        If UpString(mBitBtn.Name)='B_CANCEL' then begin
          gNT.SetSection ('GLOBAL');
          (pForm.Components[I] as TBitBtn).Caption := gNT.GetText ('B_Cancel.Caption',mBitBtn.Caption);
          (pForm.Components[I] as TBitBtn).Font.Charset := gvSys.FontCharset;
          gNT.SetSection (pSection);
        end
        else begin
          If UpString(mBitBtn.Name)='B_OK' then begin
            gNT.SetSection ('GLOBAL');
            (pForm.Components[I] as TBitBtn).Caption := gNT.GetText ('B_Ok.Caption',mBitBtn.Caption);
            (pForm.Components[I] as TBitBtn).Font.Charset := gvSys.FontCharset;
          end
          else begin
            (pForm.Components[I] as TBitBtn).Caption := mNT.GetText (pForm.Name+'.'+mBitBtn.Name+'.Caption',mBitBtn.Caption);
            (pForm.Components[I] as TBitBtn).Font.Charset := gvSys.FontCharset;
          end;
        end;
      end;
      mBitBtn.Font.Size := gvSys.ButtonFontSize;
    end;
    // TSpeedButton
    If (pForm.Components[I] is TSpeedButton) then begin
      mSpeedButton := (pForm.Components[I] as TSpeedButton);
      (pForm.Components[I] as TSpeedButton).Caption := '';
      (pForm.Components[I] as TSpeedButton).Hint := mNT.GetText (pForm.Name+'.'+mSpeedButton.Name+'.Hint',mSpeedButton.Hint);
      (pForm.Components[I] as TSpeedButton).Font.Charset := gvSys.FontCharset;
    end;
    // TBookList
    If (pForm.Components[I] is TBookList) then begin
      mBookList := (pForm.Components[I] as TBookList);
     (pForm.Components[I] as TBookList).Head := mNT.GetText (pForm.Name+'.'+mBookList.Name+'.Head',mBookList.Head);
    end;
    // TAction
    If (pForm.Components[I] is TAction) then begin
      mAction := (pForm.Components[I] as TAction);
     (pForm.Components[I] as TAction).Caption := mNT.GetText (pForm.Name+'.'+mAction.Name+'.Caption',mAction.Caption);
     (pForm.Components[I] as TAction).Hint := mNT.GetText (pForm.Name+'.'+mAction.Name+'.Hint',mAction.Hint);
    end;
    // TMenuItem
    If (pForm.Components[I] is TMenuItem) then begin
      mMenuItem := (pForm.Components[I] as TMenuItem);
      If mMenuItem.Action=nil then (pForm.Components[I] as TMenuItem).Caption := mNT.GetText (pForm.Name+'.'+mMenuItem.Name+'.Caption',mMenuItem.Caption);
    end;
    // TCheckBox
    If (pForm.Components[I] is TCheckBox) then begin
      mCheckBox := (pForm.Components[I] as TCheckBox);
     (pForm.Components[I] as TCheckBox).Caption := mNT.GetText (pForm.Name+'.'+mCheckBox.Name+'.Caption',mCheckBox.Caption);
     (pForm.Components[I] as TCheckBox).Font.Charset := gvSys.FontCharset;
    end;
    // TRadioButton
    If (pForm.Components[I] is TRadioButton) then begin
      mRadioButton := (pForm.Components[I] as TRadioButton);
     (pForm.Components[I] as TRadioButton).Caption := mNT.GetText (pForm.Name+'.'+mRadioButton.Name+'.Caption',mRadioButton.Caption);
     (pForm.Components[I] as TRadioButton).Font.Charset := gvSys.FontCharset;
    end;
    // TGroupBox
    If (pForm.Components[I] is TGroupBox) then begin
      mGroupBox := (pForm.Components[I] as TGroupBox);
     (pForm.Components[I] as TGroupBox).Caption := mNT.GetText (pForm.Name+'.'+mGroupBox.Name+'.Caption',mGroupBox.Caption);
     (pForm.Components[I] as TGroupBox).Font.Size := gvSys.LabelFontSize;
     (pForm.Components[I] as TGroupBox).Font.Charset := gvSys.FontCharset;
    end;

    // Editory
    mName := pForm.Components[I].ClassName;
    If (mName='TNameEdit') or (mName='TLongEdit')  or (mName='TBarCodeEdit') or (mName='TIntervalEdit') then begin
      mEdit := (pForm.Components[I] as TEdit);
      (pForm.Components[I] as TEdit).Hint := mNT.GetText (pForm.Name+'.'+mEdit.Name+'.Hint',mEdit.Hint);
      (pForm.Components[I] as TEdit).Font.Charset := gvSys.FontCharset;
    end;
    If (mName='TDateEdit') then begin
      mDateEdit := (pForm.Components[I] as TDateEdit);
      (pForm.Components[I] as TDateEdit).Hint := mNT.GetText (pForm.Name+'.'+mDateEdit.Name+'.Hint',mDateEdit.Hint);
    end;
    If (mName='TTimeEdit') then begin
      mTimeEdit := (pForm.Components[I] as TTimeEdit);
      (pForm.Components[I] as TTimeEdit).Hint := mNT.GetText (pForm.Name+'.'+mTimeEdit.Name+'.Hint',mTimeEdit.Hint);
    end;

    If mName='TCodeEdit' then begin
      mCodeEdit := (pForm.Components[I] as TCodeEdit);
     (pForm.Components[I] as TCodeEdit).Hint := mNT.GetText (pForm.Name+'.'+mCodeEdit.Name+'.Hint',mCodeEdit.Hint);
    end;
    If (mName='TVatEdit') or (mName='TPriceEdit') or (mName='TValueEdit') or (mName='TQuantEdit') or (mName='TPrcEdit')then begin
      mSpecEdit := (pForm.Components[I] as TSpecEdit);
     (pForm.Components[I] as TSpecEdit).Hint := mNT.GetText (pForm.Name+'.'+mSpecEdit.Name+'.Hint',mSpecEdit.Hint);
    end;
  end;
  mNT.Free;
end;

procedure LoadReportText (pReport:TQuickRep; pSection:string);
var I:word;  mLabel: TQRLabel;
begin
  gNT.SetSection (pSection);
  For I := 0 to pReport.ComponentCount-1 do begin
    // TQRLabel
    If (pReport.Components[I] is TQRLabel) then begin
      mLabel := (pReport.Components[I] as TQRLabel);
      If Pos('Label',mLabel.Name)>0 then begin
        (pReport.Components[I] as TQRLabel).Caption := gNT.GetText (pReport.Name+'.'+mLabel.Name+'.Caption',mLabel.Caption);
     //   (pReport.Components[I] as TQRLabel).Font.Size := pReport.Font.Size;
      end;
      If mLabel.Name='QL_FirmaName' then begin
        (pReport.Components[I] as TQRLabel).Caption := gvSys.FirmaName;
      end;
    end;
  end;
end;

function  IntUpCase (pChar:Char): Char;
begin
  Result := pChar;
  If Ord(pChar) in [224..255]
    then Result := Chr(Ord(pChar)-32)
    else Result := UpCase (pChar);
end;

function  IntUpperCase (pString:string): string;
var I:byte;
begin
  Result := pString;
  For I:=1 to Length(pString) do
    Result[I] := IntUpCase(pString[I]);
end;

function  GetFormFileName (pTag:longint):string; // Je to meno suboru, v ktorom su ukladane formulara - urci sa podla vlastnosti Tag
var mModulName:Str3;
begin
  mModulName := 'SYS';
  case pTag of
    1000: mModulName := 'NEX';  // Menu systemu NEX
    1001: mModulName := 'USR';  // Evidencia užívate¾ov
    1002: mModulName := 'DBS';  // Údržba databázových súborov
    1003: mModulName := 'UPG';  // Aktualizácia systému
    1010: mModulName := 'EML';  // Interná elektronická pošta

    1101: mModulName := 'STL';  // Evidencia skladov
    1102: mModulName := 'WRL';  // Evidencia prevádzok
    1103: mModulName := 'CEL';  // Evidencia stredísk
    1104: mModulName := 'MFL';  // Evidencia závodov
    1105: mModulName := 'GSB';  // Evidencia tovaru
    1106: mModulName := 'PAB';  // Evidencia partnerov
    1107: mModulName := 'PLB';  // Tvorba predajných cien
    1108: mModulName := 'STM';  // Evidencia skladových pohybov
    1109: mModulName := 'STK';  // Skladové karty zásob
    1110: mModulName := 'IMB';  // Príjem tovaru na sklad
    1111: mModulName := 'OMB';  // Výdaj tovaru zo skladu
    1112: mModulName := 'RMB';  // Medziskladový presun
    1113: mModulName := 'PKL';  // Preba¾ovacie koeficienty
    1114: mModulName := 'MPK';  // Prebalenie tovaru
    1115: mModulName := 'OSB';  // Odoslané objednávky
    1116: mModulName := 'TSB';  // Došlé dodacie listy
    1117: mModulName := 'IVB';  // Inventarizácia skladov
    1118: mModulName := 'KOM';  // Komisionálny tovar

    1201: mModulName := 'OCB';  // Došlé objednávky
    1202: mModulName := 'TCB';  // Odoslané dodacie listy
    1203: mModulName := 'ICB';  // Odoslané daòové faktúry
    1204: mModulName := 'PCB';  // Odoslané zálohové faktúry

    1301: mModulName := 'SAB';  // Knihy registraèných pokladníc
    1302: mModulName := 'SAI';  // Informácie pokladnièného predaja
    1303: mModulName := 'SAP';  // Spracovanie pokladnièného predaja
    1304: mModulName := 'SAD';  // Doklady pokladnièného predaja

    1401: mModulName := 'MPL';  // Evidencia receptúr jedál
    1402: mModulName := 'MPP';  // Plánovanie a výroba jedál
    1403: mModulName := 'MPB';  // Doklady výroby jedál

    1501: mModulName := 'SNT';  // Úètovná osnova synt. úètov
    1502: mModulName := 'ANL';  // Úètovná osnova anal. úètov
    1503: mModulName := 'IDB';  // Denník interných dokladov
    1504: mModulName := 'CSB';  // Hotovostne pokladne
    1505: mModulName := 'SOB';  // Bankové výpisy
    1506: mModulName := 'PAB';  // Prevodné príkazy
    1507: mModulName := 'PSB';  // Došlé zálohové faktúry
    1508: mModulName := 'ISB';  // Došlé daòové faktúry
    1509: mModulName := 'VAT';  // Evidencia DPH
    1510: mModulName := 'JRN';  // Denník úètovných zápisov
    1511: mModulName := 'ACB';  // Hlavná kniha úètov
    1512: mModulName := 'ACC';  // Obratová predvaha
    1513: mModulName := 'BLC';  // Tvorba úètovných výkazov
    1514: mModulName := 'PYC';  // Poh¾adávky k zadanému dátumu
    1515: mModulName := 'PYS';  // Záväzky k zadanému dátumu

    1601: mModulName := 'EPB';  // Evidencia zamestnancov
    1602: mModulName := 'IOC';  // Sledovanie vstupu a výstupu zamestnancov
    1603: mModulName := 'WEG';  // Mzdová agenda

    1701: mModulName := 'FXA';  // Investièný majetok
    1702: mModulName := 'SMA';  // Drobný majetok

    3201: mModulName := 'MAB';  // Katalog vyrobnych materialov
    3202: mModulName := 'PDB';  // Katalog vlastnych vyrobkov
    3203: mModulName := '';  // Vyrobne zakazky
    3204: mModulName := 'OPB';  // Operativne planovanie vyroby
    3205: mModulName := 'EQB';  // Evidencia výrobných zariadení
  end;
  If gPath<>nil
    then Result := gPath.LngPath+mModulName+'FORM'
    else Result := mModulName+'FORM';
end;

end.
