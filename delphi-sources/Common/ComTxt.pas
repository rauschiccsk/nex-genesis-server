unit ComTxt;
{$F+}
// *****************************************************************************
// Ovladac textoveho suboru, ktory skuzi na prenos dodavatelskych
// faktur medzi roznymi firmami.
// *****************************************************************************

interface

uses
  IcVariab, IcTypes, IcConv, IcTools, IniFiles, SysUtils, NexMsg, NexPath, NexError,
  NexIni, TxtWrap, TxtCut, StkCanc, DocHand, TxtDoc, Icd, hSYSTEM, hGSCAT, hPLS,
  ProcInd_, Key, Forms, IcProgressBar, NexPxTable;

type
  TComTxt = class
    constructor Create;
    destructor  Destroy; override;
    private
      oDocNum: Str12; // Cislo dokladu ktorym pracujeme
    public
      ohGSCAT:TGscatHnd;
      ohPLS:TPlsHnd;
      oIcd:TIcd;
      oCount:word;
      procedure SaveToFile (pDocNum:Str12;pComPath:ShortString;pIndicator:TIcProgressBar);  // Ulozi zadany doklad do textoveho suboru
      procedure LoadDocFromFiles (pBokNum:Str5;ptTSH:TNexPxTable);  // Nacita doklady z textovych suborov do zadaneho suboru
      procedure LoadNidFromFile (ptTSI:TNexPxTable;pExtNum:Str12);  // Nacita polozky zadaneho doklad z textoveho suboru
      procedure LoadItmFromFile (ptTSI:TNexPxTable;pExtNum:Str12);  // Nacita polozky zadaneho doklad z textoveho suboru
    published
      property Count:word read oCount;
  end;

implementation

uses
   DM_STKDAT, DM_LDGDAT, DM_DLSDAT, DM_SYSTEM, BtrTable;

constructor TComTxt.Create;
begin
  ohGSCAT := TGscatHnd.Create;  ohGSCAT.Open;
  ohPLS := TPlsHnd.Create; ohPLS.Open(gIni.MainPls);
  oIcd := TIcd.Create(nil);
end;

destructor TComTxt.Destroy;
begin
  FreeAndNil(oIcd);
  FreeAndNil(ohPLS);
  FreeAndNil(ohGSCAT);
end;

procedure TComTxt.SaveToFile (pDocNum:Str12;pComPath:ShortString;pIndicator:TIcProgressBar);  // Ulozi zadany doklad do textoveho suboru
var mFileName:ShortString; mWrap:TTxtWrap;  mTxtDoc: TTxtDoc;  mBokNum:Str5;  mhSYSTEM:TSystemHnd;
begin
  mBokNum := BookNumFromDocNum(pDocNum);
  oIcd.Open(mBokNum,TRUE,TRUE,FALSE);
  With oIcd do begin
    If ohICH.LocateDocNum(pDocNum) then begin
      mFileName := pComPath+dmLDG.btICH.FieldByName('ExtNum').AsString+'.TXT';
      mTxtDoc := TTxtDoc.Create;
      If FileExists (mFileName) then DeleteFile (mFileName);
      // Ulozime hlacivku dokladu
      mTxtDoc.WriteString ('ExtNum',ohICH.ExtNum);
      mTxtDoc.WriteDate ('DocDate',ohICH.DocDate);
      mTxtDoc.WriteDate ('ExpDate',ohICH.ExpDate);
      mTxtDoc.WriteDate ('TaxDate',ohICH.VatDate);
      mTxtDoc.WriteString ('ContoNum',ohICH.MyConto);
      mTxtDoc.WriteString ('FgDvzName',ohICH.FgDvzName);
      mTxtDoc.WriteFloat ('FgAValue',ohICH.FgAValue);
      mTxtDoc.WriteFloat ('FgBValue',ohICH.FgBValue);
      mTxtDoc.WriteInteger ('ItmQnt',ohICH.ItmQnt);
      mhSYSTEM := TSystemHnd.Create;  mhSYSTEM.Open;
      mTxtDoc.WriteString ('RegIno',mhSYSTEM.MyPaIno);
      mTxtDoc.WriteString ('RegTin',mhSYSTEM.MyPaTin);
      mTxtDoc.WriteString ('RegVin',mhSYSTEM.MyPaVin);
      mTxtDoc.WriteString ('RegName',mhSYSTEM.MyPaName);
      mTxtDoc.WriteString ('RegCtn',mhSYSTEM.MyCtyName);
      mTxtDoc.WriteString ('RegZip',mhSYSTEM.MyZipCode);
      FreeAndNil(mhSYSTEM);
      // Ulozime poloziek dokladu
      If ohICI.LocateDocNum(pDocNum) then begin
        pIndicator.Max := ohICH.ItmQnt;
        pIndicator.Position := 0;
        Repeat
          pIndicator.StepBy(1);
          mTxtDoc.Insert;
          mTxtDoc.WriteString ('BarCode',ohICI.BarCode);
          mTxtDoc.WriteString ('GsName',ohICI.GsName);
          If ohGSCAT.LocateGsCode(ohICI.GsCode) then begin
            mTxtDoc.WriteString ('MsName',ohGSCAT.MsName);
            mTxtDoc.WriteString ('GaName',ohGSCAT.GaName);
            mTxtDoc.WriteString ('SpcCode',ohGSCAT.SpcCode);
            mTxtDoc.WriteString ('OsdCode',ohGSCAT.OsdCode);
          end
          else begin
            mTxtDoc.WriteString ('MsName','');
            mTxtDoc.WriteString ('GaName','');
            mTxtDoc.WriteString ('SpcCode','');
            mTxtDoc.WriteString ('OsdCode','');
          end;
          mTxtDoc.WriteInteger ('VatPrc',ohICI.VatPrc);
          mTxtDoc.WriteFloat ('GsQnt',ohICI.GsQnt);
          mTxtDoc.WriteFloat ('DscPrc',ohICI.DscPrc);
          mTxtDoc.WriteFloat ('FgDValue',ohICI.FgDValue);
          mTxtDoc.WriteFloat ('FgDscVal',ohICI.FgDscVal);
          mTxtDoc.WriteFloat ('FgAValue',ohICI.FgAValue);
          mTxtDoc.WriteFloat ('FgBValue',ohICI.FgBValue);
          If ohPLS.LocateGsCode(ohICI.GsCode)
            then mTxtDoc.WriteFloat ('EuBPrice',ohPLS.BPrice)
            else mTxtDoc.WriteFloat ('EuBPrice',0);
          mTxtDoc.WriteInteger ('MgCode',ohICI.MgCode);
          mTxtDoc.Post;
          ohICI.Next;
          Application.ProcessMessages;
        until (ohICI.Eof) or (ohICI.DocNum<>ohICH.DocNum);
      end;
      mTxtDoc.SaveToFile (mFileName);
      FreeAndNil (mTxtDoc);
    end
    else ShowMsg(eCom.DocIsNoExist,pDocNum);
  end;
end;

procedure TComTxt.LoadDocFromFiles (pBokNum:Str5;ptTSH:TNexPxTable);  // Nacita doklady z textovych suborov do zadaneho suboru
var mSearchRec:TSearchRec;  mFileName:string;  mSerNum:longint;  mTxtDoc: TTxtDoc;
    mMyOp:boolean;
begin
  If FindFirst (gIni.GetComPath+'*.TXT',faAnyFile,mSearchRec)=0 then begin
    mMyOp := not dmDLS.btPAB.Active;
    If mMyOp then dmDLS.OpenList(dmDLS.btPAB,0);
    dmDLS.btPAB.IndexName := 'RegIno';
    mSerNum := 0;
    Repeat
      Inc (mSerNum);
      mFileName := gIni.GetComPath+mSearchRec.Name;
      mTxtDoc := TTxtDoc.Create;
      mTxtDoc.LoadFromFile (mFileName);
      ptTSH.Insert;
      ptTSH.FieldByName('SerNum').AsInteger := mSerNum;
      ptTSH.FieldByName('DocNum').AsString := StrInt (mSerNum,0);
      ptTSH.FieldByName('ExtNum').AsString := mTxtDoc.ReadString ('ExtNum');
      ptTSH.FieldByName('StkNum').AsInteger := gKey.TsbStkNum[pBokNum];
      ptTSH.FieldByName('PlsNum').AsInteger := gKey.TsbPlsNum[pBokNum];
      ptTSH.FieldByName('SmCode').AsInteger := gKey.TsbSmCode[pBokNum];
      ptTSH.FieldByName('DocDate').AsDateTime := mTxtDoc.ReadDate ('DocDate');
      ptTSH.FieldByName('CrtUser').AsString := gvSys.LoginName;
      If dmDLS.btPAB.FindKey([mTxtDoc.ReadString ('RegIno')]) then begin
        ptTSH.FieldByName('PaCode').AsInteger := dmDLS.btPAB.FieldByName('PaCode').AsInteger;
        ptTSH.FieldByName('PaName').AsString := dmDLS.btPAB.FieldByName('PaName').AsString;
        ptTSH.FieldByName('RegName').AsString := dmDLS.btPAB.FieldByName('RegName').AsString;
        ptTSH.FieldByName('RegIno').AsString := dmDLS.btPAB.FieldByName('RegIno').AsString;
        ptTSH.FieldByName('RegTin').AsString := dmDLS.btPAB.FieldByName('RegTin').AsString;
        ptTSH.FieldByName('RegVin').AsString := dmDLS.btPAB.FieldByName('RegVin').AsString;
        ptTSH.FieldByName('RegAddr').AsString := dmDLS.btPAB.FieldByName('RegAddr').AsString;
        ptTSH.FieldByName('RegSta').AsString := dmDLS.btPAB.FieldByName('RegSta').AsString;
        ptTSH.FieldByName('RegCty').AsString := dmDLS.btPAB.FieldByName('RegCty').AsString;
        ptTSH.FieldByName('RegCtn').AsString := dmDLS.btPAB.FieldByName('RegCtn').AsString;
        ptTSH.FieldByName('RegZip').AsString := dmDLS.btPAB.FieldByName('RegZip').AsString;
        ptTSH.FieldByName('PayCode').AsString := dmDLS.btPAB.FieldByName('IsPayCode').AsString;
        ptTSH.FieldByName('PayName').AsString := dmDLS.btPAB.FieldByName('IsPayName').AsString;
        ptTSH.FieldByName('WpaCode').AsInteger := dmDLS.btPAB.FieldByName('PaCode').AsInteger;
        ptTSH.FieldByName('WpaName').AsString := dmDLS.btPAB.FieldByName('RegName').AsString;;
        ptTSH.FieldByName('WpaAddr').AsString := dmDLS.btPAB.FieldByName('RegAddr').AsString;
        ptTSH.FieldByName('WpaSta').AsString := dmDLS.btPAB.FieldByName('RegSta').AsString;
        ptTSH.FieldByName('WpaCty').AsString := dmDLS.btPAB.FieldByName('RegCty').AsString;
        ptTSH.FieldByName('WpaCtn').AsString := dmDLS.btPAB.FieldByName('RegCtn').AsString;
        ptTSH.FieldByName('WpaZip').AsString := dmDLS.btPAB.FieldByName('RegZip').AsString;
        ptTSH.FieldByName('TrsCode').AsString := dmDLS.btPAB.FieldByName('IsTrsCode').AsString;
        ptTSH.FieldByName('TrsName').AsString := dmDLS.btPAB.FieldByName('IsTrsName').AsString;
      end;
      ptTSH.FieldByName('AcDvzName').AsString := gIni.SelfDvzName;
      ptTSH.FieldByName('FgDvzName').AsString := gIni.SelfDvzName;
      ptTSH.FieldByName('FgDValue').AsFloat := mTxtDoc.ReadFloat('FgDValue');
      ptTSH.FieldByName('FgDscVal').AsFloat := mTxtDoc.ReadFloat('FgDscVal');
      ptTSH.FieldByName('FgCValue').AsFloat := mTxtDoc.ReadFloat('FgAValue');
      ptTSH.FieldByName('FgEValue').AsFloat := mTxtDoc.ReadFloat('FgBValue');
      ptTSH.FieldByName('FgVatVal').AsFloat := ptTSH.FieldByName('FgEValue').AsFloat-ptTSH.FieldByName('FgCValue').AsFloat;
      ptTSH.FieldByName('VatPrc1').AsFloat := gIni.GetVatPrc(1);
      ptTSH.FieldByName('VatPrc2').AsFloat := gIni.GetVatPrc(2);
      ptTSH.FieldByName('VatPrc3').AsFloat := gIni.GetVatPrc(3);
      ptTSH.FieldByName('VatPrc4').AsFloat := gIni.GetVatPrc(4);
      ptTSH.FieldByName('VatPrc5').AsFloat := gIni.GetVatPrc(5);
      ptTSH.FieldByName('Sended').AsInteger := 1;
      ptTSH.Post;
      Application.ProcessMessages;
      FreeAndNil (mTxtDoc);
    until FindNext(mSearchRec)<>0;
    FindClose(mSearchRec);
    If mMyOp then dmDLS.btPAB.Close;
  end;
end;

procedure TComTxt.LoadNidFromFile (ptTSI:TNexPxTable;pExtNum:Str12);  // Nacita polozky, ktore nie su v evidencii tovaru
var mFileName:ShortString;  mTxtDoc: TTxtDoc; mFind:boolean; mStr:String; mLine:integer;
begin
  // Ulozime polozky do docasneho suboru
  dmSTK.btGSCAT.SwapStatus;
  dmSTK.btGSCAT.IndexName := 'BarCode';
  mFileName := gIni.GetComPath+pExtNum+'.TXT';
  mTxtDoc := TTxtDoc.Create;
  mTxtDoc.LoadFromFile (mFileName);
  ShowProcInd(mFileName,mTxtDoc.ItemCount);
  mTxtDoc.First;
  mStr:=''; mLine:= 0;
  Repeat
    StepProcInd;
    Inc(mLine);
    mFind := dmSTK.btGSCAT.FindKey ([mTxtDoc.ReadString ('BarCode')]);
    If not mFind then begin
      mFind := dmSTK.btBARCODE.FindKey ([mTxtDoc.ReadString ('BarCode')]);
      If mFind then begin

      end;
    end;
    If IsNul(mTxtDoc.ReadFloat ('GsQnt')) then begin
      If mStr<>''
        then mStr:=mStr+';'+IntToStr(mLine)
        else mStr:='Riadok: '+IntToStr(mLine);
    end;
    If not mFind then begin // Ulozime do zoznamu neidentifikovanych poloziek
      ptTSI.Insert;
      ptTSI.FieldByName('RowNum').AsInteger := ptTSI.RecordCount+1;
      ptTSI.FieldByName('ItmNum').AsInteger := ptTSI.FieldByName('RowNum').AsInteger;
      ptTSI.FieldByName('BarCode').AsString := mTxtDoc.ReadString ('BarCode');
      ptTSI.FieldByName('GsName').AsString := mTxtDoc.ReadString ('GsName');
      ptTSI.FieldByName('MsName').AsString := mTxtDoc.ReadString ('MsName');
      ptTSI.FieldByName('GsQnt').AsFloat := mTxtDoc.ReadFloat ('GsQnt');
      ptTSI.FieldByName('VatPrc').AsFloat := mTxtDoc.ReadFloat ('VatPrc');
      ptTSI.FieldByName('DscPrc').AsFloat := mTxtDoc.ReadFloat ('DscPrc');
      ptTSI.FieldByName('FgDValue').AsFloat := mTxtDoc.ReadFloat ('FgDValue');
      ptTSI.FieldByName('FgDscVal').AsFloat := mTxtDoc.ReadFloat ('FgDscVal');
      ptTSI.FieldByName('FgCValue').AsFloat := mTxtDoc.ReadFloat ('FgAValue');
      ptTSI.FieldByName('FgEValue').AsFloat := mTxtDoc.ReadFloat ('FgBValue');
      ptTSI.FieldByName('AcBPrice').AsFloat := mTxtDoc.ReadFloat ('EuBPrice');
      ptTSI.FieldByName('AcBValue').AsFloat := Rd2(mTxtDoc.ReadFloat ('EuBPrice')*mTxtDoc.ReadFloat ('GsQnt'));
      If IsNotNul(mTxtDoc.ReadFloat ('GsQnt')) then begin
        ptTSI.FieldByName('FgDPrice').AsFloat := RoundCPrice(ptTSI.FieldByName('FgDValue').AsFloat/ptTSI.FieldByName('GsQnt').AsFloat);
        ptTSI.FieldByName('FgCPrice').AsFloat := RoundCPrice(ptTSI.FieldByName('FgCValue').AsFloat/ptTSI.FieldByName('GsQnt').AsFloat);
        ptTSI.FieldByName('FgEPrice').AsFloat := RoundCPrice(ptTSI.FieldByName('FgEValue').AsFloat/ptTSI.FieldByName('GsQnt').AsFloat);
      end else begin
        ptTSI.FieldByName('FgDPrice').AsFloat := ptTSI.FieldByName('FgDValue').AsFloat;
        ptTSI.FieldByName('FgCPrice').AsFloat := ptTSI.FieldByName('FgCValue').AsFloat;
        ptTSI.FieldByName('FgEPrice').AsFloat := ptTSI.FieldByName('FgEValue').AsFloat;
      end;
      ptTSI.FieldByName('FgRndVal').AsFloat := ptTSI.FieldByName('FgCValue').AsFloat-Rd2(ptTSI.FieldByName('FgCPrice').AsFloat*ptTSI.FieldByName('GsQnt').AsFloat);
      ptTSI.FieldByName('AcSPrice').AsFloat := ptTSI.FieldByName('FgCPrice').AsFloat;
      ptTSI.FieldByName('AcDValue').AsFloat := ptTSI.FieldByName('FgDValue').AsFloat;
      ptTSI.FieldByName('AcDscVal').AsFloat := ptTSI.FieldByName('FgDscVal').AsFloat;
      ptTSI.FieldByName('AcCValue').AsFloat := ptTSI.FieldByName('FgCValue').AsFloat;
      ptTSI.FieldByName('AcEValue').AsFloat := ptTSI.FieldByName('FgEValue').AsFloat;
      ptTSI.FieldByName('AcSValue').AsFloat := ptTSI.FieldByName('FgCValue').AsFloat;
      ptTSI.FieldByName('AcRndVal').AsFloat := ptTSI.FieldByName('FgRndVal').AsFloat;
      ptTSI.Post;
    end;
    Application.ProcessMessages;
    mTxtDoc.Next;
  until mTxtDoc.Eof;
  CloseProcInd;
  FreeAndNil (mTxtDoc);
  dmSTK.btGSCAT.RestoreStatus;
  If mStr<>'' then ShowMsg(ecSysNulCValOccur,mStr);
end;

procedure TComTxt.LoadItmFromFile (ptTSI:TNexPxTable;pExtNum:Str12);  // Nacita polozky zadaneho doklad z textoveho suboru
var mFileName:ShortString;  mTxtDoc: TTxtDoc;   mFind:boolean; mStr:String; mLine:integer;
begin
  // Ulozime polozky do docasneho suboru
  dmSTK.btGSCAT.SwapStatus;
  dmSTK.btGSCAT.IndexName := 'BarCode';
  mFileName := gIni.GetComPath+pExtNum+'.TXT';
  mTxtDoc := TTxtDoc.Create;
  mTxtDoc.LoadFromFile (mFileName);
  ShowProcInd(mFileName,mTxtDoc.ItemCount);
  mTxtDoc.First;
  mStr:=''; mLine:= 0;
  Repeat
    StepProcInd;
    Inc(mLine);
    If IsNotNul(mTxtDoc.ReadFloat ('GsQnt')) then begin
      ptTSI.Insert;
      ptTSI.FieldByName('RowNum').AsInteger := ptTSI.RecordCount+1;
      ptTSI.FieldByName('ItmNum').AsInteger := ptTSI.FieldByName('RowNum').AsInteger;
      ptTSI.FieldByName('BarCode').AsString := mTxtDoc.ReadString ('BarCode');
      ptTSI.FieldByName('VatPrc').AsFloat := mTxtDoc.ReadFloat ('VatPrc');
      mFind := dmSTK.btGSCAT.FindKey ([mTxtDoc.ReadString ('BarCode')]);
      If not mFind then begin
        mFind := dmSTK.btBARCODE.FindKey ([mTxtDoc.ReadString ('BarCode')]);
        If mFind then begin

        end;
      end;
      If mFind then begin // Ulozime do zoznamu neidentifikovanych poloziek
        ptTSI.FieldByName('GsCode').AsInteger := dmSTK.btGSCAT.FieldByName('GsCode').AsInteger;
        ptTSI.FieldByName('MgCode').AsInteger := dmSTK.btGSCAT.FieldByName('MgCode').AsInteger;
        ptTSI.FieldByName('GsName').AsString := dmSTK.btGSCAT.FieldByName('GsName').AsString;
        ptTSI.FieldByName('StkCode').AsString := dmSTK.btGSCAT.FieldByName('StkCode').AsString;
        ptTSI.FieldByName('MsName').AsString := dmSTK.btGSCAT.FieldByName('MsName').AsString;
        ptTSI.FieldByName('VatPrc').AsFloat := dmSTK.btGSCAT.FieldByName('VatPrc').AsFloat;
      end;
      ptTSI.FieldByName('StkNum').AsInteger := mTxtDoc.ReadInteger ('StkNum');
      ptTSI.FieldByName('GsQnt').AsFloat := mTxtDoc.ReadFloat ('GsQnt');
      ptTSI.FieldByName('DscPrc').AsFloat := mTxtDoc.ReadFloat ('DscPrc');
      ptTSI.FieldByName('FgDValue').AsFloat := mTxtDoc.ReadFloat ('FgDValue');
      ptTSI.FieldByName('FgDscVal').AsFloat := mTxtDoc.ReadFloat ('FgDscVal');
      ptTSI.FieldByName('FgCValue').AsFloat := mTxtDoc.ReadFloat ('FgAValue');
      ptTSI.FieldByName('FgEValue').AsFloat := mTxtDoc.ReadFloat ('FgBValue');
      ptTSI.FieldByName('AcBPrice').AsFloat := mTxtDoc.ReadFloat ('EuBPrice');
      ptTSI.FieldByName('AcBValue').AsFloat := Rd2(mTxtDoc.ReadFloat ('EuBPrice')*mTxtDoc.ReadFloat ('GsQnt'));
      ptTSI.FieldByName('FgDPrice').AsFloat := RoundCPrice(ptTSI.FieldByName('FgDValue').AsFloat/ptTSI.FieldByName('GsQnt').AsFloat);
      ptTSI.FieldByName('FgCPrice').AsFloat := RoundCPrice(ptTSI.FieldByName('FgCValue').AsFloat/ptTSI.FieldByName('GsQnt').AsFloat);
      ptTSI.FieldByName('FgEPrice').AsFloat := RoundCPrice(ptTSI.FieldByName('FgEValue').AsFloat/ptTSI.FieldByName('GsQnt').AsFloat);
      ptTSI.FieldByName('FgRndVal').AsFloat := ptTSI.FieldByName('FgCValue').AsFloat-Rd2(ptTSI.FieldByName('FgCPrice').AsFloat*ptTSI.FieldByName('GsQnt').AsFloat);
      ptTSI.FieldByName('AcSPrice').AsFloat := ptTSI.FieldByName('FgCPrice').AsFloat;
      ptTSI.FieldByName('AcDValue').AsFloat := ptTSI.FieldByName('FgDValue').AsFloat;
      ptTSI.FieldByName('AcDscVal').AsFloat := ptTSI.FieldByName('FgDscVal').AsFloat;
      ptTSI.FieldByName('AcCValue').AsFloat := ptTSI.FieldByName('FgCValue').AsFloat;
      ptTSI.FieldByName('AcEValue').AsFloat := ptTSI.FieldByName('FgEValue').AsFloat;
      ptTSI.FieldByName('AcSValue').AsFloat := ptTSI.FieldByName('FgCValue').AsFloat;
      ptTSI.FieldByName('AcRndVal').AsFloat := ptTSI.FieldByName('FgRndVal').AsFloat;
      ptTSI.Post;
    end else begin
      If mStr<>''
        then mStr:=mStr+';'+IntToStr(mLine)
        else mStr:='Riadok: '+IntToStr(mLine);
    end;
    Application.ProcessMessages;
    mTxtDoc.Next;
  until mTxtDoc.Eof;
  CloseProcInd;
  FreeAndNil (mTxtDoc);
  dmSTK.btGSCAT.RestoreStatus;
  If mStr<>'' then ShowMsg(ecSysNulCValOccur,mStr);
end;

end.



