unit SpvTxt;
// *****************************************************************************
// Popis:
// Tento objekt ulozi zmenene doklady zadanej knihy alebo nacita ich
// do zadanej knihy faktur.
// *****************************************************************************
interface

uses
  IcVariab, IcTypes, IcConv, IcConst, IcTools, NexPath, NexIni,
  TxtDoc, DocHand,
  Controls, ExtCtrls, Classes, StdCtrls, Buttons, Windows, Messages,
  SysUtils, Graphics, Forms, Dialogs, ComCtrls, LangForm, IcLabels,
  DBTables, PxTable, NexBtrTable, BtrTable, DB;

type
  TSpvTxt = class(TLangForm)
    btSPV: TNexBtrTable;
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormCreate(Sender: TObject);
  private
    oTxtDoc: TTxtDoc;
  public
    procedure SaveToFile (pBookNum:Str5; var pDocCnt:TNumLabel); // Ulozim zadane polozky do textoveho suboru
    procedure LoadFromFile (pBookNum:Str5; var pDocCnt:TNumLabel); // Nacita doklady do zadanej knihy z textoveho suboru
  end;

implementation

uses
  DM_LDGDAT, DM_SYSTEM;

{$R *.DFM}

procedure TSpvTxt.FormCreate(Sender: TObject);
begin
  oTxtDoc := TTxtDoc.Create;
end;

procedure TSpvTxt.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  FreeAndNil (oTxtDoc);
end;

procedure TSpvTxt.SaveToFile (pBookNum:Str5; var pDocCnt:TNumLabel); // Ulozim zmenene doklady zo otovrenej knihy do textoveho suboru
var mFileName:ShortString;
begin
  dmLDG.OpenBook(btSPV,pBookNum);
  btSPV.IndexName := 'Sended';
  btSPV.Sended := FALSE;
  While btSPV.FindKey ([0]) do begin
    pDocCnt.Long := pDocCnt.Long+1;
    oTxtDoc.Insert;
    oTxtDoc.WriteInteger ('SerNum',btSPV.FieldByName('SerNum').AsInteger);
    oTxtDoc.WriteString ('DocNum',btSPV.FieldByName('DocNum').AsString);
    oTxtDoc.WriteDate ('DocDate',btSPV.FieldByName('DocDate').AsDateTime);
    oTxtDoc.WriteInteger ('PaCode',btSPV.FieldByName('PaCode').AsInteger);
    oTxtDoc.WriteString ('PaName',btSPV.FieldByName('PaName').AsString);
    oTxtDoc.WriteInteger ('VatPrc1',btSPV.FieldByName('VatPrc1').AsInteger);
    oTxtDoc.WriteInteger ('VatPrc2',btSPV.FieldByName('VatPrc2').AsInteger);
    oTxtDoc.WriteInteger ('VatPrc3',btSPV.FieldByName('VatPrc3').AsInteger);
    oTxtDoc.WriteFloat ('AValue',btSPV.FieldByName('AValue').AsFloat);
    oTxtDoc.WriteFloat ('AValue1',btSPV.FieldByName('AValue1').AsFloat);
    oTxtDoc.WriteFloat ('AValue2',btSPV.FieldByName('AValue2').AsFloat);
    oTxtDoc.WriteFloat ('AValue3',btSPV.FieldByName('AValue3').AsFloat);
    oTxtDoc.WriteFloat ('VatVal',btSPV.FieldByName('VatVal').AsFloat);
    oTxtDoc.WriteFloat ('VatVal1',btSPV.FieldByName('VatVal1').AsFloat);
    oTxtDoc.WriteFloat ('VatVal2',btSPV.FieldByName('VatVal2').AsFloat);
    oTxtDoc.WriteFloat ('VatVal3',btSPV.FieldByName('VatVal3').AsFloat);
    oTxtDoc.WriteFloat ('BValue',btSPV.FieldByName('BValue').AsFloat);
    oTxtDoc.WriteFloat ('BValue1',btSPV.FieldByName('BValue1').AsFloat);
    oTxtDoc.WriteFloat ('BValue2',btSPV.FieldByName('BValue2').AsFloat);
    oTxtDoc.WriteFloat ('BValue3',btSPV.FieldByName('BValue3').AsFloat);
    oTxtDoc.WriteString ('ConDoc',btSPV.FieldByName('ConDoc').AsString);
    oTxtDoc.WriteString ('OcdNum',btSPV.FieldByName('OcdNum').AsString);
    oTxtDoc.WriteString ('PayMode',btSPV.FieldByName('PayMode').AsString);
    oTxtDoc.WriteString ('RspName',btSPV.FieldByName('RspName').AsString);
    oTxtDoc.Post;
    btSPV.Edit;
    btSPV.FieldByName ('Sended').AsInteger := 1;
    btSPV.Post;
    Application.ProcessMessages;
  end;
  btSPV.Close;
  // Ulozime udaje do textoveho suboru
  If oTxtDoc.ItemCount>0 then begin
    mFileName := gIni.GetZipPath+'SPV'+dmLDG.btSVBLST.FieldByName('BookNum').AsString+'.TXT';
    If FileExists (mFileName) then DeleteFile (mFileName);
    oTxtDoc.SaveToFile(mFileName);
  end;
end;

procedure TSpvTxt.LoadFromFile (pBookNum:Str5; var pDocCnt:TNumLabel); // Nacita doklady do zadanej knihy z textoveho suboru
var mFileName:ShortString;
begin
  try
    mFileName := gIni.GetZipPath+'SPV'+pBookNum+'.TXT';
    If FileExists (mFileName) then begin
      dmLDG.OpenBook(btSPV,pBookNum);
      btSPV.IndexName := 'DocNum';
      btSPV.Sended := FALSE;
      oTxtDoc.LoadFromFile (mFileName);
      // Nacitame cisla faktur z prenosoveho suboru
      oTxtDoc.First;
      Repeat
        If btSPV.FindKey ([oTxtDoc.ReadString('DocNum')])
          then btSPV.Edit
          else begin
            btSPV.Insert;
            btSPV.FieldByName('SerNum').AsInteger := oTxtDoc.ReadInteger ('SerNum');
            btSPV.FieldByName('DocNum').AsString := oTxtDoc.ReadString ('DocNum');
          end;
        btSPV.FieldByName('DocDate').AsDateTime := oTxtDoc.ReadDate ('DocDate');
        btSPV.FieldByName('PaCode').AsInteger := oTxtDoc.ReadInteger ('PaCode');
        btSPV.FieldByName('PaName').AsString := oTxtDoc.ReadString ('PaName');
        btSPV.FieldByName('VatPrc1').AsInteger := oTxtDoc.ReadInteger ('VatPrc1');
        btSPV.FieldByName('VatPrc2').AsInteger := oTxtDoc.ReadInteger ('VatPrc2');
        btSPV.FieldByName('VatPrc3').AsInteger := oTxtDoc.ReadInteger ('VatPrc3');
        btSPV.FieldByName('AValue').AsFloat := oTxtDoc.ReadFloat ('AValue');
        btSPV.FieldByName('AValue1').AsFloat := oTxtDoc.ReadFloat ('AValue1');
        btSPV.FieldByName('AValue2').AsFloat := oTxtDoc.ReadFloat ('AValue2');
        btSPV.FieldByName('AValue3').AsFloat := oTxtDoc.ReadFloat ('AValue3');
        btSPV.FieldByName('VatVal').AsFloat := oTxtDoc.ReadFloat ('VatVal');
        btSPV.FieldByName('VatVal1').AsFloat := oTxtDoc.ReadFloat ('VatVal1');
        btSPV.FieldByName('VatVal2').AsFloat := oTxtDoc.ReadFloat ('VatVal2');
        btSPV.FieldByName('VatVal3').AsFloat := oTxtDoc.ReadFloat ('VatVal3');
        btSPV.FieldByName('BValue').AsFloat := oTxtDoc.ReadFloat ('BValue');
        btSPV.FieldByName('BValue1').AsFloat := oTxtDoc.ReadFloat ('BValue1');
        btSPV.FieldByName('BValue2').AsFloat := oTxtDoc.ReadFloat ('BValue2');
        btSPV.FieldByName('BValue3').AsFloat := oTxtDoc.ReadFloat ('BValue3');
        btSPV.FieldByName('ConDoc').AsString := oTxtDoc.ReadString ('ConDoc');
        btSPV.FieldByName('OcdNum').AsString := oTxtDoc.ReadString ('OcdNum');
        btSPV.FieldByName('PayMode').AsString := oTxtDoc.ReadString ('PayMode');
        btSPV.FieldByName('RspName').AsString := oTxtDoc.ReadString ('RspName');
        btSPV.Post;
        pDocCnt.Long := pDocCnt.Long+1;
        Application.ProcessMessages;
        oTxtDoc.Next;
      until oTxtDoc.Eof;
      btSPV.Close;
    end;
  except
  end;
end;

end.
