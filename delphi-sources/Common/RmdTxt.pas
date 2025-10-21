unit RmdTxt;
{$F+}

interface

uses
  IcTypes, IcConv, IcTools, IniFiles, SysUtils, NexPath, NexIni,
  TxtWrap, TxtCut, StkCanc, DocHand, TxtDoc, Forms;

type
  TRmdTxt = class
    constructor Create;
    destructor  Destroy; override;
    private
      oDocNum: Str12; // Cislo dokladu ktorym pracujeme
      procedure LoadTxtToRmh; // Nacita udaje z prenosoveho suboru a vytvori alebo opravy hlavicku prijemky
      procedure LoadTxtToTmp; // Nacita poloky z prenosoveho suboru do docasneh databaze ptRMI
      procedure DeleteRmi; // Vymaze polozky doacieho listu, ktore nie su v docasnej databaze
      procedure AddNewItmToRmi; // Prida nove polozky do prijemky
    public
      oCount:word;
      oTxtDoc: TTxtDoc;
      procedure SaveToFIle (pDocNum:Str12);  // Ulozi zadany doklad do textoveho suboru
      procedure LoadFromFile (pDocNum:Str12);  // Nacita doklad z textoveho suboru
    published
      property Count:word read oCount;
  end;

implementation

uses
   DM_STKDAT;

constructor TRmdTxt.Create;
begin
end;

destructor TRmdTxt.Destroy;
begin
end;

procedure TRmdTxt.SaveToFile (pDocNum:Str12);  // Ulozi zadany doklad do textoveho suboru
var mFileName:string;  mPdnQnt:word;   mWrap:TTxtWrap;
begin
  mFileName := gIni.GetZipPath+pDocNum+'.TXT';
  oTxtDoc := TTxtDoc.Create;
  If FileExists (mFileName) then DeleteFile (mFileName);
  // Ulozime hlacivku dokladu
  oTxtDoc.WriteInteger ('SerNum',dmSTK.btRMH.FieldByName('SerNum').AsInteger);
  oTxtDoc.WriteString ('DocNum',dmSTK.btRMH.FieldByName('DocNum').AsString);
  oTxtDoc.WriteInteger ('ScStkNum',dmSTK.btRMH.FieldByName('ScStkNum').AsInteger);
  oTxtDoc.WriteInteger ('TgStkNum',dmSTK.btRMH.FieldByName('TgStkNum').AsInteger);
  oTxtDoc.WriteDate ('DocDate',dmSTK.btRMH.FieldByName('DocDate').AsDateTime);
  oTxtDoc.WriteString ('Describe',dmSTK.btRMH.FieldByName('Describe').AsString);
  oTxtDoc.WriteString ('RspName',dmSTK.btRMH.FieldByName('RspName').AsString);
  oTxtDoc.WriteInteger ('PlsNum',dmSTK.btRMH.FieldByName('PlsNum').AsInteger);
  oTxtDoc.WriteInteger ('ScSmCode',dmSTK.btRMH.FieldByName('ScSmCode').AsInteger);
  oTxtDoc.WriteInteger ('TgSmCode',dmSTK.btRMH.FieldByName('TgSmCode').AsInteger);
  oTxtDoc.WriteInteger ('VatPrc1',Round(dmSTK.btRMH.FieldByName('VatPrc1').AsFloat));
  oTxtDoc.WriteInteger ('VatPrc2',Round(dmSTK.btRMH.FieldByName('VatPrc2').AsFloat));
  oTxtDoc.WriteInteger ('VatPrc3',Round(dmSTK.btRMH.FieldByName('VatPrc3').AsFloat));
  oTxtDoc.WriteString ('ModUser',dmSTK.btRMH.FieldByName('ModUser').AsString);
  oTxtDoc.WriteDate ('ModDate',dmSTK.btRMH.FieldByName('ModDate').AsDateTime);
  oTxtDoc.WriteDate ('ModTime',dmSTK.btRMH.FieldByName('ModTime').AsDateTime);
  oTxtDoc.WriteString ('Year',dmSTK.btRMH.FieldByName('Year').AsString);
  // Ulozime vyrobne cisla
  mPdnQnt := 0;
  If dmSTK.btRMP.IndexName<>'DoIt' then dmSTK.btRMP.IndexName := 'DoIt';
  dmSTK.btRMP.FindNearest ([pDocNum,0]);
  If dmSTK.btRMP.FieldByName ('DocNum').AsString=dmSTK.btRMH.FieldByName ('DocNum').AsString then begin
    mWrap := TTxtWrap.Create;
    mWrap.SetDelimiter('');
    Repeat
      Inc (mPdnQnt);
      mWrap.ClearWrap;
      mWrap.SetNum(dmSTK.btRMP.FieldByName('ItmNum').AsInteger,0);
      mWrap.SetNum(dmSTK.btRMP.FieldByName('GsCode').AsInteger,0);
      mWrap.SetText(dmSTK.btRMP.FieldByName('ProdNum').AsString,0);
//      mWrap.SetNum(dmSTK.btRMP.FieldByName('StkNum').AsInteger,0);
      oTxtDoc.WriteString ('ProdNum'+StrInt(mPdnQnt,0),mWrap.GetWrapText);
      Application.ProcessMessages;
      dmSTK.btRMP.Next;
    until (dmSTK.btRMP.Eof) or (dmSTK.btRMP.FieldByName('DocNum').AsString<>pDocNum);
    FreeAndNil (mWrap);
  end;
  oTxtDoc.WriteInteger ('PdnQnt',mPdnQnt);

  // Ulozime poloziek dokladu
  If dmSTK.btRMI.IndexName<>'DoIt' then dmSTK.btRMI.IndexName := 'DoIt';
  dmSTK.btRMI.FindNearest ([pDocNum,0]);
  If dmSTK.btRMI.FieldByName ('DocNum').AsString=dmSTK.btRMH.FieldByName ('DocNum').AsString then begin
    Repeat
      oTxtDoc.Insert;
      oTxtDoc.WriteInteger ('ItmNum',dmSTK.btRMI.FieldByName('ItmNum').AsInteger);
      oTxtDoc.WriteInteger ('GsCode',dmSTK.btRMI.FieldByName('GsCode').AsInteger);
      oTxtDoc.WriteInteger ('MgCode',dmSTK.btRMI.FieldByName('MgCode').AsInteger);
      oTxtDoc.WriteString ('GsName',dmSTK.btRMI.FieldByName('GsName').AsString);
      oTxtDoc.WriteString ('BarCode',dmSTK.btRMI.FieldByName('BarCode').AsString);
      oTxtDoc.WriteString ('StkCode',dmSTK.btRMI.FieldByName('StkCode').AsString);
      oTxtDoc.WriteInteger ('ScStkNum',dmSTK.btRMI.FieldByName('ScStkNum').AsInteger);
      oTxtDoc.WriteInteger ('TgStkNum',dmSTK.btRMI.FieldByName('TgStkNum').AsInteger);
      oTxtDoc.WriteFloat ('GsQnt',dmSTK.btRMI.FieldByName('GsQnt').AsFloat);
      oTxtDoc.WriteString ('MsName',dmSTK.btRMI.FieldByName('MsName').AsString);
      oTxtDoc.WriteInteger ('VatPrc',Round(dmSTK.btRMI.FieldByName('VatPrc').AsFloat));
      oTxtDoc.WriteFloat ('CPrice',dmSTK.btRMI.FieldByName('CPrice').AsFloat);
      oTxtDoc.WriteFloat ('EPrice',dmSTK.btRMI.FieldByName('EPrice').AsFloat);
      oTxtDoc.WriteFloat ('CValue',dmSTK.btRMI.FieldByName('CValue').AsFloat);
      oTxtDoc.WriteFloat ('EValue',dmSTK.btRMI.FieldByName('EValue').AsFloat);
      oTxtDoc.WriteFloat ('AValue',dmSTK.btRMI.FieldByName('AValue').AsFloat);
      oTxtDoc.WriteFloat ('BValue',dmSTK.btRMI.FieldByName('BValue').AsFloat);
      oTxtDoc.WriteString ('StkStat',dmSTK.btRMI.FieldByName('StkStat').AsString);
      oTxtDoc.WriteString ('ModUser',dmSTK.btRMI.FieldByName('ModUser').AsString);
      oTxtDoc.WriteDate ('ModDate',dmSTK.btRMI.FieldByName('ModDate').AsDateTime);
      oTxtDoc.WriteTime ('ModTime',dmSTK.btRMI.FieldByName('ModTime').AsDateTime);
      oTxtDoc.Post;
      Application.ProcessMessages;
      dmSTK.btRMI.Next;
    until (dmSTK.btRMI.Eof) or (dmSTK.btRMI.FieldByName('DocNum').AsString<>pDocNum);
{
    // Ulozime poznamky dokladu
    If dmSTK.btIMN.IndexName<>'DoNtLn' then dmSTK.btIMN.IndexName:='DoNtLn';
    dmSTK.btIMN.FindNearest ([pDocNum,'',0]);
    If dmSTK.btOMI.FieldByName ('DocNum').AsString=dmSTK.btOMH.FieldByName ('DocNum').AsString then begin
      mLine := 0;
      Repeat
        Inc (mLine);
        oFile.WriteString ('NOTICES','Line'+StrInt(mLine,0),dmSTK.btIMN.FieldByName('Notice').AsString);
      until (dmSTK.btTSN.Eof) or (dmSTK.btIMN.FieldByName('DocNum').AsString<>pDocNum);
    end;
}
  end;
  oTxtDoc.SaveToFile (mFileName);
  FreeAndNil (oTxtDoc);
end;

procedure TRmdTxt.LoadFromFile (pDocNum:Str12);  // Nacita doklad z textoveho suboru
var mFileName:string;
begin
(*
  oDocNum := pDocNum;
  If not DirectoryExists (gIni.GetZipPath) then ForceDirectories (gIni.GetZipPath);
  mFileName := gIni.GetZipPath+pDocNum+'.TXT';
  If FileExists (mFileName) then begin
    oTxtDoc := TTxtDoc.Create;
    oTxtDoc.LoadFromFile (mFileName);
    LoadTxtToRmh; // Nacita udaje z prenosoveho suboru a vytvori alebo opravy hlavicku prijemky
    If dmSTK.btRMH.FieldByName('ItmQnt').AsInteger>0 then begin  // Ak doklad ma polozky
      // Polozky dokladu
      dmSTK.ptRMI.Open;
      LoadTxtToTmp; // Nacita poloky z prenosoveho suboru do docasneh databaze ptOMI
      DeleteRmi; // Vymaze polozky vydajky, ktore nie su v docasnej databaze
      AddNewItmToRmi; // Prida nove polozky do vydajky
      dmSTK.ptRMI.Close;
      If (dmSTK.btRMBLST.FieldByName('Online').AsInteger=1) then begin
        F_DocHand := TF_DocHand.Create(Application);
        F_DocHand.OutputRmDoc (dmSTK.btRMH.FieldByName('DocNum').AsString);  //  Realizácia zadaného dosleho dodacieho listu
// Doplnit vydaj
        FreeAndNil (F_DocHand);
      end;
      RmhRecalc (dmSTK.btRMH,dmSTK.btRMI);  // Prepocita hlavicku zadaneho dodacieho listu podla jeho poloziek
    end;
    // Poznamky k dokladu

    FreeAndNil (oTxtDoc);
    DeleteFile (mFileName);
  end;
*)
end;

procedure TRmdTxt.LoadTxtToRmh; // Nacita udaje z prenosoveho suboru a vytvori alebo opravy hlavicku dodacieho listu
begin
  If dmSTK.btRMH.IndexName<>'DocNum' then dmSTK.btRMH.IndexName:='DocNum';
  If dmSTK.btRMH.FindKey ([oDocNum])
    then dmSTK.btRMH.Edit     // Uprava hlavicky dokladu
    else dmSTK.btRMH.Insert;  // Novy doklad
  dmSTK.btRMH.FieldByName('SerNum').AsInteger := oTxtDoc.ReadInteger ('SerNum');
  dmSTK.btRMH.FieldByName('Year').AsString := oTxtDoc.ReadString ('Year');
  dmSTK.btRMH.FieldByName('DocNum').AsString := oTxtDoc.ReadString ('DocNum');
  dmSTK.btRMH.FieldByName('ScStkNum').AsInteger := oTxtDoc.ReadInteger ('ScStkNum');
  dmSTK.btRMH.FieldByName('TgStkNum').AsInteger := oTxtDoc.ReadInteger ('TgStkNum');
  dmSTK.btRMH.FieldByName('DocDate').AsDateTime := oTxtDoc.ReadDate ('DocDate');
  dmSTK.btRMH.FieldByName('Describe').AsString := oTxtDoc.ReadString ('Describe');
  dmSTK.btRMH.FieldByName('RspUser').AsString := oTxtDoc.ReadString ('RspUser');
  dmSTK.btRMH.FieldByName('PlsNum').AsInteger := oTxtDoc.ReadInteger ('PlsNum');
  dmSTK.btRMH.FieldByName('ScSmCode').AsInteger := oTxtDoc.ReadInteger ('ScSmCode');
  dmSTK.btRMH.FieldByName('TgSmCode').AsInteger := oTxtDoc.ReadInteger ('TgSmCode');
  dmSTK.btRMH.FieldByName('VatPrc1').AsFloat := oTxtDoc.ReadInteger ('VatPrc1');
  dmSTK.btRMH.FieldByName('VatPrc2').AsFloat := oTxtDoc.ReadInteger ('VatPrc2');
  dmSTK.btRMH.FieldByName('VatPrc3').AsFloat := oTxtDoc.ReadInteger ('VatPrc3');
  dmSTK.btRMH.FieldByName('ModUser').AsString := oTxtDoc.ReadString ('ModUser');
  dmSTK.btRMH.FieldByName('ModDate').AsDateTime := oTxtDoc.ReadDate ('ModDate');
//  dmSTK.btRMH.FieldByName('ModTime').AsDateTime := oTxtDoc.ReadTime ('ModTime');
  dmSTK.btRMH.FieldByName('ItmQnt').AsInteger := oTxtDoc.ReadInteger ('ItmQnt');
  dmSTK.btRMH.Post;
end;

procedure TRmdTxt.LoadTxtToTmp; // Nacita poloky z prenosoveho suboru do docasneh databaze ptRMI
begin
  // Ulozime polozky do docasneho suboru
  oTxtDoc.First;
  Repeat
    dmSTK.ptRMI.Insert;
    dmSTK.ptRMI.FieldByName('ItmNum').AsInteger := oTxtDoc.ReadInteger ('ItmNum');
    dmSTK.ptRMI.FieldByName('GsCode').AsInteger := oTxtDoc.ReadInteger ('GsCode');
    dmSTK.ptRMI.FieldByName('MgCode').AsInteger := oTxtDoc.ReadInteger ('MgCode');
    dmSTK.ptRMI.FieldByName('GsName').AsString := oTxtDoc.ReadString ('GsName');
    dmSTK.ptRMI.FieldByName('BarCode').AsString := oTxtDoc.ReadString ('BarCode');
    dmSTK.ptRMI.FieldByName('StkCode').AsString := oTxtDoc.ReadString ('StkCode');
    dmSTK.ptRMI.FieldByName('ScStkNum').AsInteger := oTxtDoc.ReadInteger ('ScStkNum');
    dmSTK.ptRMI.FieldByName('TgStkNum').AsInteger := oTxtDoc.ReadInteger ('TgStkNum');
    dmSTK.ptRMI.FieldByName('GsQnt').AsFloat := oTxtDoc.ReadFloat ('GsQnt');
    dmSTK.ptRMI.FieldByName('MsName').AsString := oTxtDoc.ReadString ('MsName');
    dmSTK.ptRMI.FieldByName('VatPrc').AsFloat := oTxtDoc.ReadFloat ('VatPrc');
    dmSTK.ptRMI.FieldByName('CPrice').AsFloat := oTxtDoc.ReadFloat ('CPrice');
    dmSTK.ptRMI.FieldByName('EPrice').AsFloat := oTxtDoc.ReadFloat ('EPrice');
    dmSTK.ptRMI.FieldByName('CValue').AsFloat := oTxtDoc.ReadFloat ('CValue');
    dmSTK.ptRMI.FieldByName('EValue').AsFloat := oTxtDoc.ReadFloat ('EValue');
    dmSTK.ptRMI.FieldByName('AValue').AsFloat := oTxtDoc.ReadFloat ('AValue');
    dmSTK.ptRMI.FieldByName('BValue').AsFloat := oTxtDoc.ReadFloat ('BValue');
    dmSTK.ptRMI.FieldByName('ModUser').AsString := oTxtDoc.ReadString ('ModUser');
    dmSTK.ptRMI.FieldByName('ModDate').AsDateTime := oTxtDoc.ReadDate ('ModDate');
    dmSTK.ptRMI.FieldByName('ModTime').AsDateTime := oTxtDoc.ReadTime ('ModTime');
    dmSTK.ptRMI.Post;
    otxtDoc.Next;
    Application.ProcessMessages;
  until oTxtDoc.Eof;
end;

procedure TRmdTxt.DeleteRmi; // Vymaze polozky doacieho listu, ktore nie su v docasnej databaze
var mStkCanc: TStkCanc;
begin
(*
  mStkCanc := TStkCanc.Create;
  If dmSTK.btOMI.IndexName<>'DocNum' then dmSTK.btOMI.IndexName:='DocNum';
  If dmSTK.btOMI.FindKey ([oDocNum]) then begin
    Repeat
      If dmSTK.ptOMI.FindKey ([dmSTK.btOMI.FieldByName('ItmNum').AsInteger]) then begin
        // Overime ci na danom poradovom cisle je ten isty tovar a to iste mnozstvo
        If (dmSTK.btOMI.FieldByName('GsCode').AsInteger<>dmSTK.ptOMI.FieldByName('GsCode').AsInteger) or not Eq3 (dmSTK.btOMI.FieldByName('GsQnt').AsFloat,dmSTK.ptOMI.FieldByName('GsQnt').AsFloat) then begin
          // Zrusime polozku dodacieho listu
          If (dmSTK.btOMBLST.FieldByName('Online').AsInteger=1) then begin
            If mStkCanc.Cancel (dmSTK.btOMI.FieldByName('DocNum').AsString,dmSTK.btOMI.FieldByName('ItmNum').AsInteger) then dmSTK.btOMI.Delete;
          end
          else dmSTK.btOMI.Delete;
        end
        else dmSTK.btOMI.Next; // Polozka sa zhoduje - ideme dalej
      end
      else begin // Zrusime polozku dodacieho listu
        If dmSTK.btOMI.FieldByName('StkStat').AsString='S' then begin
          // Tovar uz bol odpocitany zo skladu preto pred zrusenim traba stornovat skaldovy prijem
          If (dmSTK.btOMBLST.FieldByName('Online').AsInteger=1) then begin
            dmSTK.OpenStkFiles (dmSTK.btOMI.FieldByName('StkNum').AsInteger);
            If mStkCanc.Cancel (dmSTK.btOMI.FieldByName('DocNum').AsString,dmSTK.btOMI.FieldByName('ItmNum').AsInteger) then dmSTK.btOMI.Delete;
            dmSTK.CloseStkFiles;
          end
          else dmSTK.btOMI.Delete;
        end
        else dmSTK.btOMI.Delete;
      end;
      Application.ProcessMessages;
    until (dmSTK.btOMI.Eof) or (dmSTK.btOMI.RecordCount=0) or (dmSTK.btOMI.FieldByName('DocNum').AsString<>oDocNum);
  end;
  FreeAndNil (mStkCanc);
*)
end;

procedure TRmdTxt.AddNewItmToRmi; // Prida nove polozky do dodacieho listu
begin
  dmSTK.btRMI.Modify := FALSE;
  dmSTK.btRMI.IndexName:='DoIt';
  dmSTK.ptRMI.First;
  Repeat
    If not dmSTK.btRMI.FindKey ([oDocNum,dmSTK.ptRMI.FieldByName('ItmNum').AsInteger]) then begin
      dmSTK.btRMI.Insert;
      dmSTK.btRMI.FieldByName ('ItmNum').AsInteger := dmSTK.ptRMI.FieldByName ('ItmNum').AsInteger;
      dmSTK.btRMI.FieldByName ('DocNum').AsString := oDocNum;
      dmSTK.btRMI.FieldByName ('MgCode').AsInteger := dmSTK.ptRMI.FieldByName ('MgCode').AsInteger;
      dmSTK.btRMI.FieldByName ('GsCode').AsInteger := dmSTK.ptRMI.FieldByName ('GsCode').AsInteger;
      dmSTK.btRMI.FieldByName ('GsName').AsString := dmSTK.ptRMI.FieldByName ('GsName').AsString;
      dmSTK.btRMI.FieldByName ('BarCode').AsString := dmSTK.ptRMI.FieldByName ('BarCode').AsString;
      dmSTK.btRMI.FieldByName ('StkCode').AsString := dmSTK.ptRMI.FieldByName ('StkCode').AsString;
      dmSTK.btRMI.FieldByName ('ScStkNum').AsInteger := dmSTK.ptRMI.FieldByName ('ScStkNum').AsInteger;
      dmSTK.btRMI.FieldByName ('TgStkNum').AsInteger := dmSTK.ptRMI.FieldByName ('TgStkNum').AsInteger;
      dmSTK.btRMI.FieldByName ('MsName').AsString := dmSTK.ptRMI.FieldByName ('MsName').AsString;
      dmSTK.btRMI.FieldByName ('GsQnt').AsFloat := dmSTK.ptRMI.FieldByName ('GsQnt').AsFloat;
      dmSTK.btRMI.FieldByName ('VatPrc').AsFloat := dmSTK.ptRMI.FieldByName ('VatPrc').AsFloat;
      dmSTK.btRMI.FieldByName ('CPrice').AsFloat := dmSTK.ptRMI.FieldByName ('CPrice').AsFloat;
      dmSTK.btRMI.FieldByName ('EPrice').AsFloat := dmSTK.ptRMI.FieldByName ('EPrice').AsFloat;
      dmSTK.btRMI.FieldByName ('CValue').AsFloat := dmSTK.ptRMI.FieldByName ('CValue').AsFloat;
      dmSTK.btRMI.FieldByName ('EValue').AsFloat := dmSTK.ptRMI.FieldByName ('EValue').AsFloat;
      dmSTK.btRMI.FieldByName ('AValue').AsFloat := dmSTK.ptRMI.FieldByName ('AValue').AsFloat;
      dmSTK.btRMI.FieldByName ('BValue').AsFloat := dmSTK.ptRMI.FieldByName ('BValue').AsFloat;
      dmSTK.btRMI.FieldByName ('StkStat').AsString := 'N';
      dmSTK.btRMI.FieldByName ('ModNum').AsInteger := dmSTK.ptRMI.FieldByName ('ModNum').AsInteger;
      dmSTK.btRMI.FieldByName ('ModUser').AsString := dmSTK.ptRMI.FieldByName ('ModUser').AsString;
      dmSTK.btRMI.FieldByName ('ModDate').AsDateTime := dmSTK.ptRMI.FieldByName ('ModDate').AsDateTime;
      dmSTK.btRMI.FieldByName ('ModTime').AsDateTime := dmSTK.ptRMI.FieldByName ('ModTime').AsDateTime;
      dmSTK.btRMI.Post;
    end
    else begin  // Ak bola zmenena len cena vykoname zmenu

    end;
    Application.ProcessMessages;
    dmSTK.ptRMI.Next;
  until (dmSTK.ptRMI.Eof);
  dmSTK.btRMI.Modify := TRUE;
end;

end.
