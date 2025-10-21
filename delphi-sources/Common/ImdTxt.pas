unit ImdTxt;
{$F+}

interface

uses
  IcTypes, IcConv, IcTools, IniFiles, SysUtils, NexPath, NexIni, NexGlob, Key,
  TxtWrap, TxtCut, StkCanc, DocHand, TxtDoc, Forms;

type
  TImdTxt = class
    constructor Create;
    destructor  Destroy; override;
    private
      oDocNum: Str12; // Cislo dokladu ktorym pracujeme
      procedure LoadTxtToImh; // Nacita udaje z prenosoveho suboru a vytvori alebo opravy hlavicku prijemky
      procedure LoadTxtToImp; // Nacita vyrobne cisla daneho dokladu
      procedure LoadTxtToTmp; // Nacita poloky z prenosoveho suboru do docasneh databaze ptIMI
      procedure DeleteImi; // Vymaze polozky doacieho listu, ktore nie su v docasnej databaze
      procedure AddNewItmToImi; // Prida nove polozky do prijemky
    public
      oCount: word;
      oTxtDoc: TTxtDoc;
      procedure SaveToFile (pDocNum:Str12);  // Ulozi zadany doklad do textoveho suboru
      procedure LoadFromFile (pFileName:string);  // Nacita doklad z textoveho suboru
    published
      property Count:word read oCount;
  end;

implementation

uses
   DM_STKDAT;

constructor TImdTxt.Create;
begin
end;

destructor TImdTxt.Destroy;
begin
end;

procedure TImdTxt.SaveToFile (pDocNum:Str12);  // Ulozi zadany doklad do textoveho suboru
var mFileName:string;  mTxtDoc:TTxtDoc;  mPdnQnt:word;  mWrap:TTxtWrap;
begin
  If not DirectoryExists (gIni.GetZipPath) then ForceDirectories (gIni.GetZipPath);
  mFileName := gIni.GetZipPath+pDocNum+'.TXT';
  mTxtDoc := TTxtDoc.Create;
  If FileExists (mFileName) then DeleteFile (mFileName);
  // Ulozime hlacivku dokladu
  mTxtDoc.WriteInteger ('SerNum',dmSTK.btIMH.FieldByName('SerNum').AsInteger);
  mTxtDoc.WriteString ('DocNum',dmSTK.btIMH.FieldByName('DocNum').AsString);
  mTxtDoc.WriteInteger ('StkNum',dmSTK.btIMH.FieldByName('StkNum').AsInteger);
  mTxtDoc.WriteDate ('DocDate',dmSTK.btIMH.FieldByName('DocDate').AsDateTime);
  mTxtDoc.WriteString ('Describe',dmSTK.btIMH.FieldByName('Describe').AsString);
  mTxtDoc.WriteString ('CrtUser',dmSTK.btIMH.FieldByName('CrtUser').AsString);
  mTxtDoc.WriteInteger ('PlsNum',dmSTK.btIMH.FieldByName('PlsNum').AsInteger);
  mTxtDoc.WriteInteger ('SmCode',dmSTK.btIMH.FieldByName('SmCode').AsInteger);
  mTxtDoc.WriteInteger ('VatPrc1',Round(dmSTK.btIMH.FieldByName('VatPrc1').AsFloat));
  mTxtDoc.WriteInteger ('VatPrc2',Round(dmSTK.btIMH.FieldByName('VatPrc2').AsFloat));
  mTxtDoc.WriteInteger ('VatPrc3',Round(dmSTK.btIMH.FieldByName('VatPrc3').AsFloat));
  mTxtDoc.WriteString ('ModUser',dmSTK.btIMH.FieldByName('ModUser').AsString);
  mTxtDoc.WriteDate ('ModDate',dmSTK.btIMH.FieldByName('ModDate').AsDateTime);
  mTxtDoc.WriteTime ('ModTime',dmSTK.btIMH.FieldByName('ModTime').AsDateTime);
  mTxtDoc.WriteString ('Year',dmSTK.btIMH.FieldByName('Year').AsString);
  // Ulozime vyrobne cisla
  mPdnQnt := 0;
  If dmSTK.btIMP.IndexName<>'DoIt' then dmSTK.btIMP.IndexName := 'DoIt';
  dmSTK.btIMP.FindNearest ([pDocNum,0]);
  If dmSTK.btIMP.FieldByName ('DocNum').AsString=dmSTK.btIMH.FieldByName ('DocNum').AsString then begin
    mWrap := TTxtWrap.Create;
    mWrap.SetDelimiter('');
    Repeat
      Inc (mPdnQnt);
      mWrap.ClearWrap;
      mWrap.SetNum(dmSTK.btIMP.FieldByName('ItmNum').AsInteger,0);
      mWrap.SetNum(dmSTK.btIMP.FieldByName('GsCode').AsInteger,0);
      mWrap.SetText(dmSTK.btIMP.FieldByName('ProdNum').AsString,0);
      mWrap.SetNum(dmSTK.btIMP.FieldByName('StkNum').AsInteger,0);
      mTxtDoc.WriteString ('ProdNum'+StrInt(mPdnQnt,0),mWrap.GetWrapText);
      Application.ProcessMessages;
      dmSTK.btIMP.Next;
    until (dmSTK.btIMP.Eof) or (dmSTK.btIMP.FieldByName('DocNum').AsString<>pDocNum);
    FreeAndNil (mWrap);
  end;
  mTxtDoc.WriteInteger ('PdnQnt',mPdnQnt);
  // Ulozime poloziek dokladu
  If dmSTK.btIMI.IndexName<>'DoIt' then dmSTK.btIMI.IndexName := 'DoIt';
  dmSTK.btIMI.FindNearest ([pDocNum,0]);
  If dmSTK.btIMI.FieldByName ('DocNum').AsString=dmSTK.btIMH.FieldByName ('DocNum').AsString then begin
    Repeat
      mTxtDoc.Insert;
      mTxtDoc.WriteInteger ('ItmNum',dmSTK.btIMI.FieldByName('ItmNum').AsInteger);
      mTxtDoc.WriteInteger ('GsCode',dmSTK.btIMI.FieldByName('GsCode').AsInteger);
      mTxtDoc.WriteInteger ('MgCode',dmSTK.btIMI.FieldByName('MgCode').AsInteger);
      mTxtDoc.WriteString ('GsName',dmSTK.btIMI.FieldByName('GsName').AsString);
      mTxtDoc.WriteString ('BarCode',dmSTK.btIMI.FieldByName('BarCode').AsString);
      mTxtDoc.WriteString ('StkCode',dmSTK.btIMI.FieldByName('StkCode').AsString);
      mTxtDoc.WriteInteger ('StkNum',dmSTK.btIMI.FieldByName('StkNum').AsInteger);
      mTxtDoc.WriteFloat ('GsQnt',dmSTK.btIMI.FieldByName('GsQnt').AsFloat);
      mTxtDoc.WriteString ('MsName',dmSTK.btIMI.FieldByName('MsName').AsString);
      mTxtDoc.WriteFloat ('VatPrc',dmSTK.btIMI.FieldByName('VatPrc').AsFloat);
      mTxtDoc.WriteFloat ('CPrice',dmSTK.btIMI.FieldByName('CPrice').AsFloat);
      mTxtDoc.WriteFloat ('EPrice',dmSTK.btIMI.FieldByName('EPrice').AsFloat);
      mTxtDoc.WriteFloat ('CValue',dmSTK.btIMI.FieldByName('CValue').AsFloat);
      mTxtDoc.WriteFloat ('EValue',dmSTK.btIMI.FieldByName('EValue').AsFloat);
      mTxtDoc.WriteFloat ('AValue',dmSTK.btIMI.FieldByName('AValue').AsFloat);
      mTxtDoc.WriteFloat ('BValue',dmSTK.btIMI.FieldByName('BValue').AsFloat);
      mTxtDoc.WriteFloat ('Rndval',dmSTK.btIMI.FieldByName('RndVal').AsFloat);
      mTxtDoc.WriteString ('StkStat',dmSTK.btIMI.FieldByName('StkStat').AsString);
      mTxtDoc.WriteString ('ModUser',dmSTK.btIMI.FieldByName('ModUser').AsString);
      mTxtDoc.WriteDate ('ModDate',dmSTK.btIMI.FieldByName('ModDate').AsDateTime);
      mTxtDoc.WriteTime ('ModTime',dmSTK.btIMI.FieldByName('ModTime').AsDateTime);
      mTxtDoc.Post;
      Application.ProcessMessages;
      dmSTK.btIMI.Next;
    until (dmSTK.btIMI.Eof) or (dmSTK.btIMI.FieldByName('DocNum').AsString<>pDocNum);
  end;  
{
    // Ulozime poznamky dokladu
    If dmSTK.btIMN.IndexName<>'DoNtLn' then dmSTK.btIMN.IndexName:='DoNtLn';
    dmSTK.btIMN.FindNearest ([pDocNum,'',0]);
    If dmSTK.btIMI.FieldByName ('DocNum').AsString=dmSTK.btIMH.FieldByName ('DocNum').AsString then begin
      mLine := 0;
      Repeat
        Inc (mLine);
        oFile.WriteString ('NOTICES','Line'+StrInt(mLine,0),dmSTK.btIMN.FieldByName('Notice').AsString);
      until (dmSTK.btTSN.Eof) or (dmSTK.btIMN.FieldByName('DocNum').AsString<>pDocNum);
    end;
  end;
}
  mTxtDoc.SaveToFile (mFileName);
  FreeAndNil (mTxtDoc);
end;

procedure TImdTxt.LoadFromFile (pFileName:string);  // Nacita doklad z textoveho suboru
var mFileName:string;
begin
  oDocNum := copy(pFileName,1,12);;
  mFileName := gIni.GetZipPath+pFileName;
  If FileExists (mFileName) then begin
    oTxtDoc := TTxtDoc.Create;
    oTxtDoc.LoadFromFile (mFileName);
    LoadTxtToImh; // Nacita udaje z prenosoveho suboru a vytvori alebo opravy hlavicku prijemky
    LoadTxtToImp; // Nacita vyrobne cisla daneho dokladu
    If dmSTK.btIMH.FieldByName('ItmQnt').AsInteger>0 then begin  // Ak doklad ma polozky
      // Polozky dokladu
      dmSTK.ptIMI.Open;
      dmSTK.ptIMI.IndexName := 'ItmNum';
      LoadTxtToTmp; // Nacita poloky z prenosoveho suboru do docasneh databaze ptIMI
      DeleteImi; // Vymaze polozky prijemky, ktore nie su v docasnej databaze
      AddNewItmToImi; // Prida nove polozky do prijemky
      dmSTK.ptIMI.Close;
      ImhRecalc (dmSTK.btIMH,dmSTK.btIMI);  // Prepocita hlavicku zadaneho dodacieho listu podla jeho poloziek
    end;
    FreeAndNil (oTxtDoc);
    DeleteFile (mFileName);
  end;
end;

procedure TImdTxt.LoadTxtToImh; // Nacita udaje z prenosoveho suboru a vytvori alebo opravy hlavicku dodacieho listu
begin
  If dmSTK.btIMH.IndexName<>'DocNum' then dmSTK.btIMH.IndexName:='DocNum';
  If dmSTK.btIMH.FindKey ([oDocNum])
    then dmSTK.btIMH.Edit     // Uprava hlavicky dokladu
    else dmSTK.btIMH.Insert;  // Novy doklad
  dmSTK.btIMH.FieldByName('Year').AsString := oTxtDoc.ReadString ('Year');
  dmSTK.btIMH.FieldByName('SerNum').AsInteger := oTxtDoc.ReadInteger ('SerNum');
  dmSTK.btIMH.FieldByName('DocNum').AsString := oTxtDoc.ReadString ('DocNum');
  dmSTK.btIMH.FieldByName('StkNum').AsInteger := gKey.ImbStkNum[dmSTK.btIMH.BookNum];
  dmSTK.btIMH.FieldByName('SmCode').AsInteger := gKey.ImbSmCode[dmSTK.btIMH.BookNum];
  dmSTK.btIMH.FieldByName('DocDate').AsDateTime := oTxtDoc.ReadDate ('DocDate');
  dmSTK.btIMH.FieldByName('Describe').AsString := oTxtDoc.ReadString ('Describe');
  dmSTK.btIMH.FieldByName('CrtUser').AsString := oTxtDoc.ReadString ('CrtUser');
  dmSTK.btIMH.FieldByName('PlsNum').AsInteger := oTxtDoc.ReadInteger ('PlsNum');
  dmSTK.btIMH.FieldByName('VatPrc1').AsFloat := oTxtDoc.ReadInteger ('VatPrc1');
  dmSTK.btIMH.FieldByName('VatPrc2').AsFloat := oTxtDoc.ReadInteger ('VatPrc2');
  dmSTK.btIMH.FieldByName('VatPrc3').AsFloat := oTxtDoc.ReadInteger ('VatPrc3');
  dmSTK.btIMH.FieldByName('ModUser').AsString := oTxtDoc.ReadString ('ModUser');
  dmSTK.btIMH.FieldByName('ModDate').AsDateTime := oTxtDoc.ReadDate ('ModDate');
  dmSTK.btIMH.FieldByName('ModTime').AsDateTime := oTxtDoc.ReadTime ('ModTime');
  dmSTK.btIMH.FieldByName('ItmQnt').AsInteger := oTxtDoc.ReadInteger ('ItmQnt');
  dmSTK.btIMH.Post;
end;

procedure TImdTxt.LoadTxtToImp; // Nacita vyrobne cisla daneho dokladu
var mItmNum,mPdnQnt,I:word;  mCut:TTxtCut;
begin
  // IMP - Vymazeme vsetky vyrobne cisla daneho dokladu
  dmSTK.btIMP.SwapIndex;
  dmSTK.btIMP.IndexName := 'DocNum';
  While dmSTK.btIMP.FindKey ([dmSTK.btIMH.FieldByName('DocNum').AsString]) do dmSTK.btIMP.Delete;
  // STP - Vymazeme vsetky vyrobne cisla daneho dokladu
  dmSTK.OpenList(dmSTK.btSTP,dmSTK.btIMH.FieldByName('StkNum').AsInteger);
  dmSTK.btSTP.IndexName := 'InDoIt';
  dmSTK.btSTP.FindNearest ([dmSTK.btIMH.FieldByName('DocNum').AsString,0]);
  If dmSTK.btSTP.FieldByName ('InDocNum').AsString=dmSTK.btIMH.FieldByName('DocNum').AsString then begin
    Repeat
      dmSTK.btSTP.Delete;
    until (dmSTK.btSTP.Eof) or (dmSTK.btSTP.RecordCount=0) or (dmSTK.btSTP.FieldByName ('InDocNum').AsString<>dmSTK.btIMH.FieldByName('DocNum').AsString);
  end;

  // Ulozime vyrobne cisla daneho dokladu
  mPdnQnt := oTxtDoc.ReadInteger ('PdnQnt');
  If mPdnQnt>0 then begin
    mCut := TTxtCut.Create;
    mCut.SetDelimiter('');
    For I:=1 to mPdnQnt do begin
      mCut.SetStr(oTxtDoc.ReadString('ProdNum'+StrInt(I,0)));
      dmSTK.btIMP.Insert;
      dmSTK.btIMP.FieldByName ('DocNum').AsString := dmSTK.btIMH.FieldByName('DocNum').AsString;
      dmSTK.btIMP.FieldByName ('ItmNum').AsInteger := mCut.GetNum(1);
      dmSTK.btIMP.FieldByName ('GsCode').AsInteger := mCut.GetNum(2);
      dmSTK.btIMP.FieldByName ('ProdNum').AsString := mCut.GetText(3);
      dmSTK.btIMP.FieldByName ('StkNum').AsInteger := mCut.GetNum(4);
      dmSTK.btIMP.FieldByName ('DocDate').AsDateTime := dmSTK.btIMH.FieldByName('DocDate').AsDateTime;
      dmSTK.btIMP.Post;

      dmSTK.btSTP.Insert;
      dmSTK.btSTP.FieldByName ('GsCode').AsInteger := dmSTK.btIMP.FieldByName ('GsCode').AsInteger;
      dmSTK.btSTP.FieldByName ('ProdNum').AsString := dmSTK.btIMP.FieldByName ('ProdNum').AsString;
      dmSTK.btSTP.FieldByName ('InDocDate').AsDateTime := dmSTK.btIMP.FieldByName ('DocDate').AsDateTime;
      dmSTK.btSTP.FieldByName ('InDocNum').AsString := dmSTK.btIMP.FieldByName ('DocNum').AsString;
      dmSTK.btSTP.FieldByName ('InItmNum').AsInteger := dmSTK.btIMP.FieldByName ('ItmNum').AsInteger;
      dmSTK.btSTP.FieldByName ('Status').AsString := 'A';
      dmSTK.btSTP.Post;
    end;
    FreeAndNil (mCut);
  end;
  dmSTK.btSTP.Close;
end;

procedure TImdTxt.LoadTxtToTmp; // Nacita poloky z prenosoveho suboru do docasneh databaze ptIMI
var I:word;
begin
  If oTxtDoc.ItemCount>0 then begin
    // Ulozime polozky do docasneho suboru
    oTxtDoc.First;
    Repeat
      If not dmSTK.ptIMI.FindKey ([oTxtDoc.ReadInteger ('ItmNum')]) then begin
        dmSTK.ptIMI.Insert;
        dmSTK.ptIMI.FieldByName('DocNum').AsString   := oDocNum;
        dmSTK.ptIMI.FieldByName('ItmNum').AsInteger  := oTxtDoc.ReadInteger ('ItmNum');
        dmSTK.ptIMI.FieldByName('GsCode').AsInteger  := oTxtDoc.ReadInteger ('GsCode');
        dmSTK.ptIMI.FieldByName('MgCode').AsInteger  := oTxtDoc.ReadInteger ('MgCode');
        dmSTK.ptIMI.FieldByName('GsName').AsString   := oTxtDoc.ReadString ('GsName');
        dmSTK.ptIMI.FieldByName('BarCode').AsString  := oTxtDoc.ReadString ('BarCode');
        dmSTK.ptIMI.FieldByName('StkCode').AsString  := oTxtDoc.ReadString ('StkCode');
        dmSTK.ptIMI.FieldByName('StkNum').AsInteger  := dmSTK.btIMH.FieldByName('StkNum').AsInteger;
        dmSTK.ptIMI.FieldByName('GsQnt').AsFloat     := oTxtDoc.ReadFloat ('GsQnt');
        dmSTK.ptIMI.FieldByName('MsName').AsString   := oTxtDoc.ReadString ('MsName');
        dmSTK.ptIMI.FieldByName('VatPrc').AsFloat    := oTxtDoc.ReadFloat ('VatPrc');
        dmSTK.ptIMI.FieldByName('CPrice').AsFloat    := RoundCPrice(oTxtDoc.ReadFloat ('CPrice'));
        dmSTK.ptIMI.FieldByName('EPrice').AsFloat    := RoundCPrice(oTxtDoc.ReadFloat ('CPrice')*(1+dmSTK.ptIMI.FieldByName('VatPrc').AsFloat/100));
        dmSTK.ptIMI.FieldByName('CValue').AsFloat    := oTxtDoc.ReadFloat ('CValue');
        dmSTK.ptIMI.FieldByName('EValue').AsFloat    := Rd2(dmSTK.ptIMI.FieldByName('EPrice').AsFloat*dmSTK.ptIMI.FieldByName('GsQnt').AsFloat);
        dmSTK.ptIMI.FieldByName('AValue').AsFloat    := oTxtDoc.ReadFloat ('AValue');
        dmSTK.ptIMI.FieldByName('BValue').AsFloat    := oTxtDoc.ReadFloat ('BValue');
//        dmSTK.ptIMI.FieldByName('BValue').AsFloat  := Rd2(dmSTK.ptIMI.FieldByName('AValue').AsFloat*(1+dmSTK.ptIMI.FieldByName('VatPrc').AsFloat/100));
        If Isnotnul(dmSTK.ptIMI.FieldByName('GsQnt').AsFloat) then begin
          dmSTK.ptIMI.FieldByName('APrice').AsFloat    := oTxtDoc.ReadFloat ('AValue')/dmSTK.ptIMI.FieldByName('GsQnt').AsFloat;
          dmSTK.ptIMI.FieldByName('BPrice').AsFloat    := oTxtDoc.ReadFloat ('BValue')/dmSTK.ptIMI.FieldByName('GsQnt').AsFloat;
        end;
        dmSTK.ptIMI.FieldByName('RndVal').AsFloat    := oTxtDoc.ReadFloat ('RndVal');
        dmSTK.ptIMI.FieldByName('StkStat').AsString  := oTxtDoc.ReadString ('StkStat');
        dmSTK.ptIMI.FieldByName('ModUser').AsString  := oTxtDoc.ReadString ('ModUser');
        dmSTK.ptIMI.FieldByName('ModDate').AsDateTime := oTxtDoc.ReadDate ('ModDate');
        dmSTK.ptIMI.FieldByName('ModTime').AsDateTime := oTxtDoc.ReadTime ('ModTime');
        dmSTK.ptIMI.Post;
      end;
      Application.ProcessMessages;
      oTxtDoc.Next;
    until oTxtDoc.Eof;
  end;  
end;

procedure TImdTxt.DeleteImi; // Vymaze polozky doacieho listu, ktore nie su v docasnej databaze
begin
  If dmSTK.btIMI.IndexName<>'DocNum' then dmSTK.btIMI.IndexName:='DocNum';
  If dmSTK.btIMI.FindKey ([oDocNum]) then begin
    Repeat
      Application.ProcessMessages;
      If dmSTK.btIMI.FieldByName('StkStat').AsString='N'
        then dmSTK.btIMI.Delete
        else dmSTK.btIMI.Next;
    until (dmSTK.btIMI.Eof) or (dmSTK.btIMI.RecordCount=0) or (dmSTK.btIMI.FieldByName('DocNum').AsString<>oDocNum);
  end;
end;

procedure TImdTxt.AddNewItmToImi; // Prida nove polozky do dodacieho listu
begin
  dmSTK.btIMI.Modify := FALSE;
  dmSTK.btIMI.IndexName:='DoIt';
  dmSTK.ptIMI.First;
  Repeat
    If not dmSTK.btIMI.FindKey ([oDocNum,dmSTK.ptIMI.FieldByName('ItmNum').AsInteger]) then begin
      dmSTK.btIMI.Insert;
      PX_To_BTR (dmSTK.ptIMI,dmSTK.btIMI);
      dmSTK.btIMI.Post;
    end
    else begin  // Ak bola zmenena len cena vykoname zmenu

    end;
    Application.ProcessMessages;
    dmSTK.ptIMI.Next;
  until (dmSTK.ptIMI.Eof);
  dmSTK.btIMI.Modify := TRUE;
end;

end.
