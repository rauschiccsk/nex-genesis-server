unit CsdGen;

interface

uses
  IcVariab, IcTypes, IcConv, IcDate, IcTools, NexPath, NexIni,
  DocHand, Account,
  NexMsg, IcStand, IcButtons, IcEditors, CmpTools, BtrHand,
  Controls, ExtCtrls, Classes, StdCtrls, Buttons, Windows, Messages,
  SysUtils, Graphics, Forms, Dialogs, ComCtrls, IcLabels, IcInfoFields,
  AdvGrid, SrchGrid, TableView, ActnList, DB, BtrTable, NexBtrTable,
  NexEditors;

type
  TCsdGenF = class(TForm)
    btPMI: TNexBtrTable;
    btCSH: TNexBtrTable;
    btCSI: TNexBtrTable;
    procedure FormShow(Sender: TObject);
    procedure B_SaveClick(Sender: TObject);
    procedure B_CancelClick(Sender: TObject);
    procedure E_CsdBookExit(Sender: TObject);
  private
    oBookNum:Str5;     // Cislo knihy kde doklad bude zalozeny

    oSerNum:longint;   // Chronologicke poradove cislo pokladnicneho dokladu
    oDocCnt:word;      // Typove poradove cislo dokladu
    oDocType:Str1;     // Typ pokladnicneho dokladu (I-prijmovy,E-vydajovy)
    oDocDate:DateType; // Datum zauctovania pokladnicneho dokladu
    oWriNum:word;      // Cislo prevadzkovej jednotky
    oPaCode:longint;   // Cisleny kod odberatela
    oPaName:Str30;     // Pracovny nazov odberatela
    oRegName:Str60;    // Registrovany nazov firmy
    oRegIno:Str15;     // ICO partnera
    oRegTin:Str15;     // DIC partnera
    oRegVin:Str15;     // IC pre DPH
    oRegAddr:Str30;    // Registrovana adreda firmy
    oRegSta:Str2;      // Kod statu registrovanej adresy
    oRegCty:Str3;      // Kod obce registrovanej adresy
    oRegCtn:Str30;     // Nazov mesta registrovanej adresy
    oRegZip:Str15;     // PSC registrovanej adresy
    oNotice:Str30;     // Poznamka k pokladnicnemu dokladu
    oAcDvzName:Str3;   // Nazov uctovnej meny
    oPyDvzName:Str3;   // Nazov vyuctovacej meny
    oPyCourse:double;  // Pokladnicna mena zo dna vystavenia dokladu
    oDocSpc:byte;      // Specifikacia dokladu z hladiska vyplnenia
    oDrvCode:word;     // Kod vodièa
    oDrvName:Str30;    // Meno a priezvisko vodièa
    oCarMark:Str10;    // ŠPZ vozidla
    oOcdNum:Str12;     // Cislo odberatelskej objednavky

  public
    procedure NewDoc (pNookNum:Str5);
    procedure AccDoc; // Rozuctuje dany doklad
    procedure PrnDoc; // Vytlaci dany doklad

    procedure AddItem; // Prida polozku
  published
    property BookNum:Str5 write oBookNum;
  end;

Tsb_TsdPrn_F

  mCsdGen.BookNum :=
  mCsdGen.NewDoc

implementation

uses  Csb_DocPrn_F;

{$R *.DFM}

// ************************** PRIVATE *****************************

procedure TCsdGenF.NewDoc;
begin
  dmLDG.btCSBLST.FindKey([E_CsdBook.BookNum]);
  dmLDG.OpenBook (dmLDG.btCSH,dmLDG.btCSBLST.FieldByName('BookNum').AsString);
  // Urcime nasledujece cislo prijmoveho dokladu
  dmLDG.btCSH.IndexName := 'YearSerNum';
  dmLDG.btCSH.Last;
  E_SerNum.Long := dmLDG.btCSH.FieldByName ('SerNum').AsInteger+1;
  L_DocNum.Text := GenCsDocNum(dmLDG.btCSBLST.FieldByName('BookNum').AsString+StrIntZero(E_SerNum.Long,5);
  oDocCnt := 1;
  dmLDG.btCSH.SwapStatus;
  dmLDG.btCSH.First;
  Result:=1;
  while not dmLDG.btCSH.Eof do begin
    If (dmLDG.btCSH.FieldByName ('Year').AsString=gvsys.actyear2{YearSLong(E_Year.AsInteger)})and(dmLDG.btCSH.FieldByName ('DocType').AsString='I')
    and(dmLDG.btCSH.FieldByName ('DocCnt').AsInteger>=oDocCnt) then oDocCnt:=dmLDG.btCSH.FieldByName ('DocCnt').AsInteger+1;
    dmLDG.btCSH.Next;
  end;
  dmLDG.btCSH.RestoreStatus;
end;

// ****************************************************************

procedure TCsdGenF.B_SaveClick(Sender: TObject);
var mPyBegVal:double;
begin
  A_Save.Enabled := FALSE;
  B_Save.Enabled := FALSE;
  // Urcime pociatocny stav
  dmLDG.btCSH.SwapStatus;
  dmLDG.btCSH.IndexName := 'SerNum';
  dmLDG.btCSH.Last;
  mPyBegVal := dmLDG.btCSH.FieldByName ('PyEndVal').AsFloat;
  dmLDG.btCSH.RestoreStatus;
  try BtrBegTrans;
    // Vytvorime hlavicku pokladnicneho dokladu
    dmLDG.btCSH.Insert;
    dmLDG.btCSH.FieldByName ('SerNum').AsInteger := E_SerNum.Long;
    dmLDG.btCSH.FieldByName ('DocNum').AsString := L_DocNum.Text;
    dmLDG.btCSH.FieldByName ('DocCnt').AsInteger := L_DocCnt.Long;
    dmLDG.btCSH.FieldByName ('DocType').AsString := 'I';
    dmLDG.btCSH.FieldByName ('DocDate').AsDateTime := E_DocDate.Date;
    dmLDG.btCSH.FieldByName ('WriNum').AsInteger := dmLDG.btICH.FieldByName ('WriNum').AsInteger;
    dmLDG.btCSH.FieldByName ('PaCode').AsInteger := dmLDG.btICH.FieldByName ('PaCode').AsInteger;
    dmLDG.btCSH.FieldByName ('PaName').AsString := dmLDG.btICH.FieldByName ('PaName').AsString;
    dmLDG.btCSH.FieldByName ('RegName').AsString := dmLDG.btICH.FieldByName ('RegName').AsString;
    dmLDG.btCSH.FieldByName ('RegIno').AsString := dmLDG.btICH.FieldByName ('RegIno').AsString;
    dmLDG.btCSH.FieldByName ('RegTin').AsString := dmLDG.btICH.FieldByName ('RegTin').AsString;
    dmLDG.btCSH.FieldByName ('RegVin').AsString := dmLDG.btICH.FieldByName ('RegVin').AsString;
    dmLDG.btCSH.FieldByName ('RegAddr').AsString := dmLDG.btICH.FieldByName ('RegAddr').AsString;
    dmLDG.btCSH.FieldByName ('RegSta').AsString := dmLDG.btICH.FieldByName ('RegSta').AsString;
    dmLDG.btCSH.FieldByName ('RegCty').AsString := dmLDG.btICH.FieldByName ('RegCty').AsString;
    dmLDG.btCSH.FieldByName ('RegCtn').AsString := dmLDG.btICH.FieldByName ('RegCtn').AsString;
    dmLDG.btCSH.FieldByName ('RegZip').AsString := dmLDG.btICH.FieldByName ('RegZip').AsString;
    dmLDG.btCSH.FieldByName ('Notice').AsString := 'Úhrada faktúry '+dmLDG.btICH.FieldByName ('ExtNum').AsString;
    dmLDG.btCSH.FieldByName ('VatPrc1').AsInteger := dmLDG.btICH.FieldByName ('VatPrc1').AsInteger;
    dmLDG.btCSH.FieldByName ('VatPrc2').AsInteger := dmLDG.btICH.FieldByName ('VatPrc2').AsInteger;
    dmLDG.btCSH.FieldByName ('VatPrc3').AsInteger := dmLDG.btICH.FieldByName ('VatPrc3').AsInteger;
    dmLDG.btCSH.FieldByName ('AcDvzName').AsString := dmLDG.btICH.FieldByName ('AcDvzName').AsString;
    dmLDG.btCSH.FieldByName ('PyDvzName').AsString := dmLDG.btCSBLST.FieldByName ('PyDvzName').AsString;
    dmLDG.btCSH.FieldByName ('PyCourse').AsFloat := 1;
    dmLDG.btCSH.FieldByName ('PyBegVal').AsFloat := mPyBegVal;
    dmLDG.btCSH.FieldByName ('DocSpc').AsInteger := dmLDG.btCSBLST.FieldByName ('DocSpc').AsInteger;
    dmLDG.btCSH.Post;
    // Vytvorime polozku pokladnicneho dokladu
    dmLDG.OpenBook (dmLDG.btCSI,dmLDG.btCSBLST.FieldByName('BookNum').AsString);
    dmLDG.btCSI.Insert;
    dmLDG.btCSI.FieldByName ('DocNum').AsString := L_DocNum.Text;
    dmLDG.btCSI.FieldByName ('ItmNum').AsInteger := 1;
    dmLDG.btCSI.FieldByName ('DocDate').AsDateTime := E_DocDate.Date;
    dmLDG.btCSI.FieldByName ('Describe').AsString := dmLDG.btCSH.FieldByName ('Notice').AsString;
    dmLDG.btCSI.FieldByName ('DocType').AsString := dmLDG.btCSH.FieldByName ('DocType').AsString;
    dmLDG.btCSI.FieldByName ('VatPrc').AsInteger := 0;
    dmLDG.btCSI.FieldByName ('PyDvzName').AsString := dmLDG.btCSH.FieldByName ('PyDvzName').AsString;
    dmLDG.btCSI.FieldByName ('PyCourse').AsFloat := 1;
    dmLDG.btCSI.FieldByName ('PyAValue').AsFloat := E_PayVal.Value;
    dmLDG.btCSI.FieldByName ('PyBValue').AsFloat := E_PayVal.Value;
    dmLDG.btCSI.FieldByName ('AcDvzName').AsString := dmLDG.btCSH.FieldByName ('AcDvzName').AsString;
    dmLDG.btCSI.FieldByName ('AcAValue').AsFloat := E_PayVal.Value;
    dmLDG.btCSI.FieldByName ('AcBValue').AsFloat := E_PayVal.Value;
    dmLDG.btCSI.FieldByName ('FgDvzName').AsString := dmLDG.btICH.FieldByName ('FgDvzName').AsString;
    dmLDG.btCSI.FieldByName ('FgCourse').AsFloat := 1;
    dmLDG.btCSI.FieldByName ('FgPayVal').AsFloat := E_PayVal.Value;
    dmLDG.btCSI.FieldByName ('ConDoc').AsString := L_IcDocNum.Text;
    dmLDG.btCSI.FieldByName ('ConExt').AsString := dmLDG.btICH.FieldByName ('ExtNum').AsString;
    dmLDG.btCSI.FieldByName ('WriNum').AsInteger := dmLDG.btICH.FieldByName ('WriNum').AsInteger;
    dmLDG.btCSI.FieldByName ('PaCode').AsInteger := dmLDG.btICH.FieldByName ('PaCode').AsInteger;
    dmLDG.btCSI.FieldByName ('CentNum').AsInteger := dmLDG.btICH.FieldByName ('WriNum').AsInteger;
    dmLDG.btCSI.FieldByName ('AccSnt').AsString := dmLDG.btICBLST.FieldByName('DocSnt').AsString;
    dmLDG.btCSI.FieldByName ('AccAnl').AsString := AccAnlGen (dmLDG.btICBLST.FieldByName ('DocAnl').AsString,dmLDG.btICH.FieldByName ('PaCode').AsInteger);
    dmLDG.btCSI.Post;
    // Ulozime zaznam do dennika uhrady FA
    dmLDG.OpenBook(btPMI,YearL(dmLDG.btCSH.FieldByName ('DocDate').AsDateTime));
    btPMI.IndexName := 'DoItSt';
    If btPMI.FindKey ([dmLDG.btCSI.FieldByName ('DocNum').AsString,1,''])
      then btPMI.Edit
      else btPMI.Insert;
    btPMI.FieldByName ('DocNum').AsString := dmLDG.btCSI.FieldByName ('DocNum').AsString;
    btPMI.FieldByName ('ItmNum').AsInteger := dmLDG.btCSI.FieldByName ('ItmNum').AsInteger;
    btPMI.FieldByName ('ExtNum').AsString := dmLDG.btCSI.FieldByName ('ConExt').AsString;
    btPMI.FieldByName ('PayDate').AsDateTime := dmLDG.btCSI.FieldByName ('DocDate').AsDateTime;
    btPMI.FieldByName ('PaCode').AsInteger := dmLDG.btCSH.FieldByName ('PaCode').AsInteger;
    btPMI.FieldByName ('PaName').AsString := dmLDG.btCSH.FieldByName ('PaName').AsString;
    btPMI.FieldByName ('ConDoc').AsString := dmLDG.btCSI.FieldByName ('ConDoc').AsString;
    btPMI.FieldByName ('WriNum').AsInteger := dmLDG.btCSI.FieldByName ('WriNum').AsInteger;
    btPMI.FieldByName ('AcDvzName').AsString := dmLDG.btCSI.FieldByName ('AcDvzName').AsString;
    btPMI.FieldByName ('AcPayVal').AsFloat := dmLDG.btCSI.FieldByName ('AcBValue').AsFloat;
    btPMI.FieldByName ('AcCrdVal').AsFloat := dmLDG.btCSI.FieldByName ('AcCrdVal').AsFloat;
    btPMI.FieldByName ('PyDvzName').AsString := dmLDG.btCSI.FieldByName ('PyDvzName').AsString;
    btPMI.FieldByName ('PyCourse').AsFloat := dmLDG.btCSI.FieldByName ('PyCourse').AsFloat;
    btPMI.FieldByName ('PyPayVal').AsFloat := dmLDG.btCSI.FieldByName ('PyBValue').AsFloat;
    btPMI.FieldByName ('PyPdfVal').AsFloat := dmLDG.btCSI.FieldByName ('PyPdfVal').AsFloat;
    btPMI.FieldByName ('FgDvzName').AsString := dmLDG.btCSI.FieldByName ('FgDvzName').AsString;
    btPMI.FieldByName ('FgCourse').AsFloat := dmLDG.btCSI.FieldByName ('FgCourse').AsFloat;
    btPMI.FieldByName ('FgPayVal').AsFloat := dmLDG.btCSI.FieldByName ('FgPayVal').AsFloat;
    btPMI.FieldByName ('Status').AsString := '';
    btPMI.Post;
    CshRecalc (dmLDG.btCSH,dmLDG.btCSI);
    IchPayValRecalc (dmLDG.btICH); // Vypocita hodnotu uhrady na zakladen dennika uhrady faktur a ulozi do hlavicky FA
    dmLDG.btCSI.Close;
    btPMI.Close;
  BtrEndTrans;
  except BtrAbortTrans; end;
  If dmLDG.btCSBLST.FieldByName('AutoAcc').AsInteger=1 then DocAccount (dmLDG.btCSH,TRUE);
  // Tlac pokladnicneho dokladu
  If E_DocPrn.Checked then begin
    F_CsbDocPrnF := TF_CsbDocPrnF.Create (Self);
    F_CsbDocPrnF.PrintDoc; // Vytlaci doklad, na ktorom je databazovy kurzor CSH
    FreeAndNil (F_CsbDocPrnF);
  end;
  Close;
end;

procedure TCsdGenF.B_CancelClick(Sender: TObject);
begin
  Close;
end;

procedure TCsdGenF.E_CsdBookExit(Sender: TObject);
begin
  NewDoc;
end;

end.
