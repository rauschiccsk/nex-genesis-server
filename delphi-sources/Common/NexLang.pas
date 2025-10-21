unit NexLang;

interface

uses
  IcTypes, IcVariab, IcEditors, IcInfoFields, IcConv, TxtWrap, TxtCut,
  BookList, NexPath, NexText, NexMsg, IniHand,
  Classes, Forms, Buttons, Menus, StdCtrls, QuickRpt, ActnList,
  QRCtrls, Controls, ComCtrls;

procedure LoadFormText (pForm:TForm; pSection:string); // Nacitanie textov formul�ra
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
    1001: mModulName := 'USR';  // Evidencia u��vate�ov
    1002: mModulName := 'DBS';  // �dr�ba datab�zov�ch s�borov
    1003: mModulName := 'UPG';  // Aktualiz�cia syst�mu
    1010: mModulName := 'EML';  // Intern� elektronick� po�ta

    1101: mModulName := 'STL';  // Evidencia skladov
    1102: mModulName := 'WRL';  // Evidencia prev�dzok
    1103: mModulName := 'CEL';  // Evidencia stred�sk
    1104: mModulName := 'MFL';  // Evidencia z�vodov
    1105: mModulName := 'GSB';  // Evidencia tovaru
    1106: mModulName := 'PAB';  // Evidencia partnerov
    1107: mModulName := 'PLB';  // Tvorba predajn�ch cien
    1108: mModulName := 'STM';  // Evidencia skladov�ch pohybov
    1109: mModulName := 'STK';  // Skladov� karty z�sob
    1110: mModulName := 'IMB';  // Pr�jem tovaru na sklad
    1111: mModulName := 'OMB';  // V�daj tovaru zo skladu
    1112: mModulName := 'RMB';  // Medziskladov� presun
    1113: mModulName := 'PKL';  // Preba�ovacie koeficienty
    1114: mModulName := 'MPK';  // Prebalenie tovaru
    1115: mModulName := 'OSB';  // Odoslan� objedn�vky
    1116: mModulName := 'TSB';  // Do�l� dodacie listy
    1117: mModulName := 'IVB';  // Inventariz�cia skladov
    1118: mModulName := 'KOM';  // Komision�lny tovar

    1201: mModulName := 'OCB';  // Do�l� objedn�vky
    1202: mModulName := 'TCB';  // Odoslan� dodacie listy
    1203: mModulName := 'ICB';  // Odoslan� da�ov� fakt�ry
    1204: mModulName := 'PCB';  // Odoslan� z�lohov� fakt�ry

    1301: mModulName := 'SAB';  // Knihy registra�n�ch pokladn�c
    1302: mModulName := 'SAI';  // Inform�cie pokladni�n�ho predaja
    1303: mModulName := 'SAP';  // Spracovanie pokladni�n�ho predaja
    1304: mModulName := 'SAD';  // Doklady pokladni�n�ho predaja

    1401: mModulName := 'MPL';  // Evidencia recept�r jed�l
    1402: mModulName := 'MPP';  // Pl�novanie a v�roba jed�l
    1403: mModulName := 'MPB';  // Doklady v�roby jed�l

    1501: mModulName := 'SNT';  // ��tovn� osnova synt. ��tov
    1502: mModulName := 'ANL';  // ��tovn� osnova anal. ��tov
    1503: mModulName := 'IDB';  // Denn�k intern�ch dokladov
    1504: mModulName := 'CSB';  // Hotovostne pokladne
    1505: mModulName := 'SOB';  // Bankov� v�pisy
    1506: mModulName := 'PAB';  // Prevodn� pr�kazy
    1507: mModulName := 'PSB';  // Do�l� z�lohov� fakt�ry
    1508: mModulName := 'ISB';  // Do�l� da�ov� fakt�ry
    1509: mModulName := 'VAT';  // Evidencia DPH
    1510: mModulName := 'JRN';  // Denn�k ��tovn�ch z�pisov
    1511: mModulName := 'ACB';  // Hlavn� kniha ��tov
    1512: mModulName := 'ACC';  // Obratov� predvaha
    1513: mModulName := 'BLC';  // Tvorba ��tovn�ch v�kazov
    1514: mModulName := 'PYC';  // Poh�ad�vky k zadan�mu d�tumu
    1515: mModulName := 'PYS';  // Z�v�zky k zadan�mu d�tumu

    1601: mModulName := 'EPB';  // Evidencia zamestnancov
    1602: mModulName := 'IOC';  // Sledovanie vstupu a v�stupu zamestnancov
    1603: mModulName := 'WEG';  // Mzdov� agenda

    1701: mModulName := 'FXA';  // Investi�n� majetok
    1702: mModulName := 'SMA';  // Drobn� majetok

    3201: mModulName := 'MAB';  // Katalog vyrobnych materialov
    3202: mModulName := 'PDB';  // Katalog vlastnych vyrobkov
    3203: mModulName := '';  // Vyrobne zakazky
    3204: mModulName := 'OPB';  // Operativne planovanie vyroby
    3205: mModulName := 'EQB';  // Evidencia v�robn�ch zariaden�
  end;
  If gPath<>nil
    then Result := gPath.LngPath+mModulName+'FORM'
    else Result := mModulName+'FORM';
end;

end.
