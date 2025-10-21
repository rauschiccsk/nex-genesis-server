unit DocCom;

interface

uses
  IcTypes, IcConv, IcTools, NexVar, NexGlob, FileCom, NexPath, DocHand,
  StdCtrls, Buttons, IcButtons, IcInfoFields,ComCtrls, IcLabels, ExtCtrls, IcStand,
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs;

type
  TF_DocCom = class(TForm)
    DinamicPanel1: TDinamicPanel;
    DoubleBevel1: TDoubleBevel;
    DoubleBevel2: TDoubleBevel;
    PB_Item: TProgressBar;
    L_DocNum: TNameInfo;
    RightLabel1: TRightLabel;
    RightLabel2: TRightLabel;
    L_ItmQnt: TLongInfo;
    CenterLabel1: TCenterLabel;
    PB_Doc: TProgressBar;
    CancelButton1: TCancelButton;
    procedure FormCreate(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure CancelButton1Click(Sender: TObject);
  private
    oAbort: boolean;
    oFileCom: TFileCom;
  public
    procedure SaveToFileTS (pDocNum:Str12);
    procedure SaveToFileFIF (pDocNum:Str12);

    procedure LoadFromFileTS (pFileName:Str12; pWriNum,pSmCode:word; pSmName:Str30);
  end;

var
  F_DocCom: TF_DocCom;

implementation

uses
  DM_STORES, DM_DIALS;

{$R *.DFM}

procedure TF_DocCom.FormCreate(Sender: TObject);
begin
  oAbort := FALSE;
  oFileCom := TFileCom.Create;
end;

procedure TF_DocCom.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  oFileCom.Free;
end;

procedure TF_DocCom.SaveToFileTS (pDocNum:Str12);
var mFileName: Str12;
begin
  // Zapišeme hlavièku dokladu do kumunikaènej vyrovnávacej pamäte
  dmSTK.btTSH.SwapStatus;
  If dmSTK.btTSH.Locate ('DocNum',VarArrayOf([pDocNum]),[]) then begin
    L_DocNum.Text := pDocNum;
    L_ItmQnt.Long := dmSTK.btTSH.FieldByName('ItmQnt').AsInteger;
    oFileCom.SetHead (dmSTK.btTSH.FieldByName('DocNum').AsString,
                      dmSTK.btTSH.FieldByName('ExtNum').AsString,
                      dmSTK.btTSH.FieldByName('DocDate').AsDateTime,
                      dmSTK.btTSH.FieldByName('SmCode').AsInteger,
                      dmSTK.btTSH.FieldByName('SmName').AsString,
                      dmSTK.btTSH.FieldByName('WriNum').AsInteger,0,
                      dmSTK.btTSH.FieldByName('Describe').AsString,
                      dmSTK.btTSH.FieldByName('VatPrc1').AsFloat,
                      dmSTK.btTSH.FieldByName('VatPrc2').AsFloat,
                      dmSTK.btTSH.FieldByName('VatPrc3').AsFloat,
                      dmSTK.btTSH.FieldByName('AVal0').AsFloat,
                      dmSTK.btTSH.FieldByName('BVal0').AsFloat,
                      dmSTK.btTSH.FieldByName('PAVal0').AsFloat,
                      dmSTK.btTSH.FieldByName('PBVal0').AsFloat);
    oFileCom.SetPart (dmSTK.btTSH.FieldByName('PaPCode').AsInteger,
                      dmSTK.btTSH.FieldByName('PaSCode').AsInteger,
                      dmSTK.btTSH.FieldByName('PaName').AsString,
                      '','','','');

    // Zapišeme položky dokladu do kumunikaènej vyrovnávacej pamäte
    dmSTK.btTSI.SwapStatus;
    dmSTK.btTSI.IndexName := 'DocNum';
    PB_Item.Max := L_ItmQnt.Long;
    PB_Item.Position := 0;
    If dmSTK.btTSI.FindKey ([pDocNum]) then begin
      Repeat
        Application.ProcessMessages;
        PB_Item.StepBy (1);
        oFileCom.AddItem (dmSTK.btTSI.FieldByName('ItmNum').AsInteger,
                          dmSTK.btTSI.FieldByName('GsCode').AsInteger,
                          dmSTK.btTSI.FieldByName('GsName').AsString,
                          dmSTK.btTSI.FieldByName('BarCode').AsString,
                          dmSTK.btTSI.FieldByName('StCode').AsString,
                          dmSTK.btTSI.FieldByName('MsName').AsString,
                          dmSTK.btTSI.FieldByName('VatPrc').AsFloat,
                          dmSTK.btTSI.FieldByName('Qnt').AsFloat,
                          dmSTK.btTSI.FieldByName('AVal').AsFloat,
                          dmSTK.btTSI.FieldByName('BVal').AsFloat,
                          dmSTK.btTSI.FieldByName('PAVal').AsFloat,
                          dmSTK.btTSI.FieldByName('PBVal').AsFloat);
        dmSTK.btTSI.Next;
      until (dmSTK.btTSI.Eof) or (dmSTK.btTSI.FieldByName('DocNum').AsString<>pDocNum);
    end;
    dmSTK.btTSI.RestoreStatus;

    // Uložíme doklado do súboru
    mFileName := 'S'+copy(pDocNum,3,2)+copy(pDocNum,8,5)+'.'+copy(pDocNum,5,3);
    oFileCom.SaveToFile (GetExpPath+mFileName);
  end;
  dmSTK.btTSH.RestoreStatus;
end;

procedure TF_DocCom.SaveToFileFIF (pDocNum:Str12);
var mFileName: Str12;
begin
  // Zapišeme hlavièku dokladu do kumunikaènej vyrovnávacej pamäte
  dmSTK.btSTOCK.IndexName := 'GsCode';
  dmSTK.btSTOCK.First;
  oFileCom.SetHead ('','',0,54,'',1,0,'',0,10,23,0,0,0,0);

  // Zapišeme položky dokladu do kumunikaènej vyrovnávacej pamäte
  PB_Item.Max := dmSTK.btSTOCK.RecordCount;
  PB_Item.Position := 0;
  Repeat
    PB_Item.StepBy (1);
    Application.ProcessMessages;
    If dmSTK.btSTOCK.FieldByName('ActQnt').AsFloat>0.1 then begin
      L_ItmQnt.Long := L_ItmQnt.Long+1;
      oFileCom.AddItem (L_ItmQnt.Long,
                        dmSTK.btSTOCK.FieldByName('GsCode').AsInteger,
                        dmSTK.btSTOCK.FieldByName('GsName').AsString,
                        dmSTK.btSTOCK.FieldByName('BarCode').AsString,
                        dmSTK.btSTOCK.FieldByName('StCode').AsString,
                        dmSTK.btSTOCK.FieldByName('MsName').AsString,
                        dmSTK.btSTOCK.FieldByName('VatPrc').AsFloat,
                        dmSTK.btSTOCK.FieldByName('ActQnt').AsFloat,
                        dmSTK.btSTOCK.FieldByName('ActCVal').AsFloat,
                        dmSTK.btSTOCK.FieldByName('ActCVal').AsFloat*(1+dmSTK.btSTOCK.FieldByName('VatPrc').AsFloat/100),
                        0,0);
    end;
    dmSTK.btSTOCK.Next;
  until (dmSTK.btSTOCK.Eof) or oAbort;

  // Uložíme doklado do súboru
  mFileName := 'S0000001.TXT';
  oFileCom.SaveToFile (GetExpPath+mFileName);
end;

procedure TF_DocCom.LoadFromFileTS (pFileName:Str12; pWriNum,pSmCode:word; pSmName:Str30);
var mSerNum,mCnt: longint;
begin
  If FileExists (GetExpPath+pFileName) then begin
    // Nacitame doklad zo súboru
    oFileCom.LoadFromFile (GetExpPath+pFileName);

    // Vyh¾adáme nasledujúce volné poradové èíslo dokladu
    dmSTK.btTSH.SwapStatus;
    dmSTK.btTSH.IndexName := 'YearSerNum';
    dmSTK.btTSH.Last;
    mSerNum := dmSTK.btTSH.FieldByName ('SerNum').AsInteger+1;
    dmSTK.btTSH.RestoreStatus;

    // Vytvorime hlavicku nveho dokladu
    L_DocNum.Text :=GenTsDocNum ('',dmSTK.GetActTsbNum,mSerNum);
    L_ItmQnt.Long := 0;
    dmSTK.btTSH.Insert;
    dmSTK.btTSH.FieldByName('SerNum').AsInteger := mSerNum;
    dmSTK.btTSH.FieldByName('Year').AsString := copy(L_DocNum.Text,3,2);
    dmSTK.btTSH.FieldByName('DocNum').AsString := L_DocNum.Text;
    dmSTK.btTSH.FieldByName('ExtNum').AsString := oFileCom.GetExtNum;
    dmSTK.btTSH.FieldByName('DocDate').AsDateTime := oFileCom.GetDocDate;
    dmSTK.btTSH.FieldByName('SmCode').AsInteger := pSmCode;
    dmSTK.btTSH.FieldByName('SmName').AsString := pSmName;
    dmSTK.btTSH.FieldByName('WriNum').AsInteger := pWriNum;
    dmSTK.btTSH.FieldByName('Describe').AsString := oFileCom.GetDescribe;
    dmSTK.btTSH.FieldByName('VatPrc1').AsFloat := oFileCom.GetVatPrc1;
    dmSTK.btTSH.FieldByName('VatPrc2').AsFloat := oFileCom.GetVatPrc2;
    dmSTK.btTSH.FieldByName('VatPrc3').AsFloat := oFileCom.GetVatPrc3;
    dmSTK.btTSH.FieldByName('AVal1').AsFloat := oFileCom.GetAValue(1);
    dmSTK.btTSH.FieldByName('AVal2').AsFloat := oFileCom.GetAValue(2);
    dmSTK.btTSH.FieldByName('AVal3').AsFloat := oFileCom.GetAValue(3);
    dmSTK.btTSH.FieldByName('AVal0').AsFloat := oFileCom.GetAValue(0);
    dmSTK.btTSH.FieldByName('BVal1').AsFloat := oFileCom.GetBValue(1);
    dmSTK.btTSH.FieldByName('BVal2').AsFloat := oFileCom.GetBValue(2);
    dmSTK.btTSH.FieldByName('BVal3').AsFloat := oFileCom.GetBValue(3);
    dmSTK.btTSH.FieldByName('BVal0').AsFloat := oFileCom.GetBValue(0);
    dmSTK.btTSH.FieldByName('VatVal1').AsFloat := dmSTK.btTSH.FieldByName('BVal1').AsFloat-dmSTK.btTSH.FieldByName('AVal1').AsFloat;
    dmSTK.btTSH.FieldByName('VatVal2').AsFloat := dmSTK.btTSH.FieldByName('BVal2').AsFloat-dmSTK.btTSH.FieldByName('AVal2').AsFloat;
    dmSTK.btTSH.FieldByName('VatVal3').AsFloat := dmSTK.btTSH.FieldByName('BVal3').AsFloat-dmSTK.btTSH.FieldByName('AVal3').AsFloat;
    dmSTK.btTSH.FieldByName('VatVal0').AsFloat := dmSTK.btTSH.FieldByName('VatVal1').AsFloat+dmSTK.btTSH.FieldByName('VatVal2').AsFloat+dmSTK.btTSH.FieldByName('VatVal3').AsFloat;
    dmSTK.btTSH.FieldByName('PAVal1').AsFloat := oFileCom.GetPAValue(1);
    dmSTK.btTSH.FieldByName('PAVal2').AsFloat := oFileCom.GetPAValue(2);
    dmSTK.btTSH.FieldByName('PAVal3').AsFloat := oFileCom.GetPAValue(3);
    dmSTK.btTSH.FieldByName('PAVal0').AsFloat := oFileCom.GetPAValue(0);
    dmSTK.btTSH.FieldByName('PBVal1').AsFloat := oFileCom.GetPBValue(1);
    dmSTK.btTSH.FieldByName('PBVal2').AsFloat := oFileCom.GetPBValue(2);
    dmSTK.btTSH.FieldByName('PBVal3').AsFloat := oFileCom.GetPBValue(3);
    dmSTK.btTSH.FieldByName('PBVal0').AsFloat := oFileCom.GetPBValue(0);
    dmSTK.btTSH.FieldByName('PVatVal1').AsFloat := dmSTK.btTSH.FieldByName('PBVal1').AsFloat-dmSTK.btTSH.FieldByName('PAVal1').AsFloat;
    dmSTK.btTSH.FieldByName('PVatVal2').AsFloat := dmSTK.btTSH.FieldByName('PBVal2').AsFloat-dmSTK.btTSH.FieldByName('PAVal2').AsFloat;
    dmSTK.btTSH.FieldByName('PVatVal3').AsFloat := dmSTK.btTSH.FieldByName('PBVal3').AsFloat-dmSTK.btTSH.FieldByName('PAVal3').AsFloat;
    dmSTK.btTSH.FieldByName('PVatVal0').AsFloat := dmSTK.btTSH.FieldByName('PVatVal1').AsFloat+dmSTK.btTSH.FieldByName('PVatVal2').AsFloat+dmSTK.btTSH.FieldByName('PVatVal3').AsFloat;
    dmSTK.btTSH.FieldByName('PaPCode').AsInteger := oFileCom.GetPaPCode;
    dmSTK.btTSH.FieldByName('PaSCode').AsInteger := oFileCom.GetPaSCode;
    dmSTK.btTSH.FieldByName('PaName').AsString := oFileCom.GetPaName;
    dmSTK.btTSH.FieldByName('Partner').AsString := oFileCom.GetPaName;
    dmSTK.btTSH.FieldByName('PayType').AsInteger := 1;
    dmSTK.btTSH.FieldByName('PayVat').AsInteger := 1;
    dmSTK.btTSH.FieldByName('ItmQnt').AsInteger := oFileCom.GetItmQnt;
    dmSTK.btTSH.DOSStrings := FALSE;
    dmSTK.btTSH.FieldByName('Status1').AsString := #250;
    dmSTK.btTSH.FieldByName('Status2').AsString := #250;
    dmSTK.btTSH.FieldByName('Status3').AsString := #250;
    dmSTK.btTSH.FieldByName('Status4').AsString := 'A';
    dmSTK.btTSH.FieldByName('Status5').AsString := #250;
    dmSTK.btTSH.FieldByName('Status6').AsString := #250;
    dmSTK.btTSH.FieldByName('Status7').AsString := #250;
    dmSTK.btTSH.FieldByName('Status8').AsString := #250;
    dmSTK.btTSH.FieldByName('Status9').AsString := #250;
    dmSTK.btTSH.FieldByName('Status10').AsString := #250;
    dmSTK.btTSH.FieldByName('Status11').AsString := #250;
    dmSTK.btTSH.FieldByName('Status12').AsString := #250;
    dmSTK.btTSH.DOSStrings := TRUE;
    dmSTK.btTSH.Post;

    // Nahráme položky dokladu
    If oFileCom.GetItmQnt>0 then begin
      mCnt := 0;
      PB_Item.Max := oFileCom.GetItmQnt;
      PB_Item.Position := 0;
      Repeat
        Inc (mCnt);
        PB_Item.StepBy (1);
        L_ItmQnt.Long := L_ItmQnt.Long+1;
        Application.ProcessMessages;
        dmSTK.btTSI.Insert;
        dmSTK.btTSI.FieldByName('DocNum').AsString := L_DocNum.Text;
        dmSTK.btTSI.FieldByName('ItmNum').AsInteger := oFileCom.GetItmNum (mCnt);
        dmSTK.btTSI.FieldByName('GsCode').AsInteger := oFileCom.GetGsCode (mCnt);
        dmSTK.btTSI.FieldByName('GsName').AsString := oFileCom.GetGsName (mCnt);
        dmSTK.btTSI.FieldByName('BarCode').AsString := oFileCom.GetBarCode (mCnt);
        dmSTK.btTSI.FieldByName('StCode').AsString := oFileCom.GetStCode (mCnt);
        dmSTK.btTSI.FieldByName('MsName').AsString := oFileCom.GetMsName (mCnt);
        dmSTK.btTSI.FieldByName('VatPrc').AsFloat := 23;  // oFileCom.GetVatPrc (mCnt);
        dmSTK.btTSI.FieldByName('Qnt').AsFloat := oFileCom.GetGsQnt (mCnt);
        dmSTK.btTSI.FieldByName('AVal').AsFloat := oFileCom.GetGsAVal (mCnt);
        dmSTK.btTSI.FieldByName('BVal').AsFloat := oFileCom.GetGsBVal (mCnt);
        dmSTK.btTSI.FieldByName('APrice').AsFloat := Rd2 (dmSTK.btTSI.FieldByName('AVal').AsFloat/dmSTK.btTSI.FieldByName('Qnt').AsFloat);
        dmSTK.btTSI.FieldByName('BPrice').AsFloat := Rd2 (dmSTK.btTSI.FieldByName('BVal').AsFloat/dmSTK.btTSI.FieldByName('Qnt').AsFloat);
        dmSTK.btTSI.FieldByName('PAVal').AsFloat := oFileCom.GetGsPAVal (mCnt);
        dmSTK.btTSI.FieldByName('PBVal').AsFloat := oFileCom.GetGsPBVal (mCnt);
        dmSTK.btTSI.FieldByName('PAPrice').AsFloat := Rd2 (dmSTK.btTSI.FieldByName('PAVal').AsFloat/dmSTK.btTSI.FieldByName('Qnt').AsFloat);
        dmSTK.btTSI.FieldByName('PBPrice').AsFloat := Rd2 (dmSTK.btTSI.FieldByName('PBVal').AsFloat/dmSTK.btTSI.FieldByName('Qnt').AsFloat);
        dmSTK.btTSI.FieldByName('Status').AsString := 'N';
        dmSTK.btTSI.Post;
      until (mCnt=oFileCom.GetItmQnt);
    end;
  end;
end;

procedure TF_DocCom.CancelButton1Click(Sender: TObject);
begin
   oAbort := TRUE;
end;

end.
