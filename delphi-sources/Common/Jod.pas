unit Jod;
{$F+}

// *****************************************************************************
//                     OBJEKT NA PRACU S PRACOVNÝMI PRIKAZMI
// *****************************************************************************
// Tento objekt obsahuje funkcie, ktoré umožnia naèíta položky dokladov a
// uloži ich do iného dokladu
//
// Programové funkcia:
// -------------------
// *****************************************************************************


interface

uses
  IcTypes, IcConst, IcVariab, IcConv, IcTools, NexGlob, NexPath, NexMsg, NexError,
  IcValue, DocHand, SavClc, LinLst, Bok, Rep, Key,
  hSYSTEM, hPAB, hJOB, bJOB, hJOBITM, hJOBPER, hJOBREM, hJOBTXT,
  ComCtrls, SysUtils, Classes, Forms, MxArrays;

type
  PDat=^TDat;
  TDat=record
    rhJOB:TJobHnd;
  end;

  TJod = class(TComponent)
    constructor Create(AOwner: TComponent);
    destructor  Destroy; override;
    private
      oFrmName:Str15;
      oDocClc:TStrings;
      oOpnBok:TStrings;
      oInd:TProgressBar;
      oLst:TList;
      function GetOpenCount:word;
    public
      ohPAB:TPabHnd;
      ohJOB:TJobHnd;
      ohJOBHED:TJobHnd;
      ohJOBITM:TJobitmHnd;
      ohJOBPER:TJobperHnd;
      ohJOBREM:TJobremHnd;
      ohJOBTXT:TJobtxtHnd;
      function GetBokNum:Str5;
      function GenDocNum(pSerNum:longint):Str12; // Vygeneruje interne cislo dokladu
      function NextDocNum:Str12; // Vygeneruje nasledujuce cislo dokladu
      procedure Activate(pIndex:word); // Aktivuje databazu, ktora je otvorena pod poradovym cislom pIndex
      procedure Open(pBokNum:Str5); // Otvori vsetky databazove subory

      procedure OpenLst(pBokLst:ShortString); // Otvori vsetky knihy ktore su zadane v retazci
      procedure ClcDoc; overload; // Prepocita hlavicku aktualneho dokladu
      procedure ClcDoc(pDocNum:Str12); overload; // Prepocita hlavicku zadaneho dokladu podla jeho poloziek
      procedure PrnDoc; overload; // Vytlaèí aktualny doklad
      procedure PrnDoc(pDocNum:Str12); overload; // Vytlaèí zadany doklad
      procedure SlcItm(pDocNum:Str12); // Nacita polozky zadaneho dokladu do PX
      procedure AddItm; // Prida novu polozku na aktulany doklad
      procedure DelItm;
      procedure DelJob(pDocNum:Str12;pEpcNum:word); // Vymaze hlavicku pracovneho prikazu u zadaneho uzivatela
      procedure LstClc; // Prepocita hlavicky zakazkovych dokladov ktore su uvedene v zozname oDocClc
      procedure AddClc(pDocNum:Str12); // Prida doklad do zoznamu, hlavicky ktorych treba prepocitat
      procedure SaveTxt(pDocNum:Str12;pItmNum:word;pTxtTyp:Str1;pTxtLst:TStrings);
      procedure LoadTxt(pDocNum:Str12;pItmNum:word;pTxtTyp:Str1; pTxtVal:TStrings);
      procedure Refresh; // Obnovy hlavicku u ostatnych uzivatelov, ktoremu je prideleny ukol
    published
      property OpenCount:word read GetOpenCount;
      property BokNum:Str5 read GetBokNum;
      property OpnBok:TStrings read oOpnBok;
      property Ind:TProgressBar read oInd write oInd;
  end;

implementation

constructor TJod.Create(AOwner: TComponent);
begin
  oFrmName := AOwner.Name;
  oDocClc := TStringList.Create;  oDocClc.Clear;
  oOpnBok := TStringList.Create;  oOpnBok.Clear;
  oLst := TList.Create;  oLst.Clear;
  ohPAB := TPabHnd.Create;  ohPAB.Open(0);
  ohJOBHED := TJobHnd.Create;  ohJOBHED.Open('00000');
  ohJOBITM := TJobitmHnd.Create;  ohJOBITM.Open;
  ohJOBPER := TJobperHnd.Create;  ohJOBPER.Open;
  ohJOBREM := TJobremHnd.Create;  ohJOBREM.Open;
  ohJOBTXT := TJobtxtHnd.Create;  ohJOBTXT.Open;
end;

destructor TJod.Destroy;
var I:word;
begin
  If oLst.Count>0 then begin
    For I:=1 to oLst.Count do begin
      Activate (I);
      FreeAndNil (ohJOB);
    end;
  end;
  FreeAndNil (oLst);
  FreeAndNil (oDocClc);
  FreeAndNil (oOpnBok);
  FreeAndNil (ohPAB);
  FreeAndNil (ohJOBHED);
  FreeAndNil (ohJOBITM);
  FreeAndNil (ohJOBPER);
  FreeAndNil (ohJOBREM);
  FreeAndNil (ohJOBTXT);
end;

// ********************************* PRIVATE ***********************************

function TJod.GetOpenCount:word;
begin
  Result := oLst.Count;
end;

procedure TJod.Activate(pIndex:word); // Aktivuje databazu, ktora je otvorena pod poradovym cislom pIndex
var mDat:PDat;
begin
  mDat := oLst.Items[pIndex-1];
  ohJOB := mDat.rhJOB;
end;

// ********************************** PUBLIC ***********************************

function TJod.GetBokNum:Str5;
begin
  Result := '';
  If ohJOB.Active then Result := ohJOB.BokNum;
end;

function TJod.GenDocNum(pSerNum:longint):Str12; // Vygeneruje interne cislo dokladu
begin
  Result := 'JD'+BokNum+StrIntZero(pSerNum,5);
end;

function TJod.NextDocNum:Str12; // Vygeneruje nasledujuce cislo dokladu
var mSerNum:word;
begin
  ohJOB.SwapStatus;
  ohJOB.SetIndex(bJOB.ixDocNum);
  ohJOB.Last;
  mSerNum := ValInt(copy(ohJOB.DocNum,8,5))+1;
  ohJOB.RestoreStatus;
  Result := GenDocNum(mSerNum);
end;

procedure TJod.Open(pBokNum:Str5); // Otvori zadanu knihu prikazov
var mFind:boolean;  mCnt:word;  mDat:PDat;
begin
  mFind := FALSE;
  If oLst.Count>0 then begin
    mCnt := 0;
    Repeat
      Inc (mCnt);
      Activate(mCnt);
      mFind := BokNum=pBokNum;
    until mFind or (mCnt=oLst.Count);
  end;
  If not mFind then begin // Ak dana kniha este nie je otvorena potomotvorime
    ohJOB := TJobHnd.Create;
    ohJOB.Open(pBokNum);
    // Ulozime objekty do zoznamu
    GetMem (mDat,SizeOf(TDat));
    mDat^.rhJOB := ohJOB;
    oLst.Add(mDat);
  end;
end;

procedure TJod.OpenLst(pBokLst:ShortString); // Otvori vsetky knihy ktore su zadane v retazci
var mLinLst:TLinLst;
begin
  oOpnBok.Clear;
  mLinLst := TLinLst.Create;
  mLinLst.AddLst(pBokLst);
  If mLinLst.Count>0 then begin
    mLinLst.First;
    Repeat
      If gBok.BokExist('JOB',mLinLst.Itm,TRUE) then Open(mLinLst.Itm);
      Application.ProcessMessages;
      mLinLst.Next;
    until mLinLst.Eof;
  end
  else begin  // Otvorime vsetky knihy
    gBok.LoadBokLst('JOB','');
    If gBok.BokLst.Count>0 then begin
      gBok.BokLst.First;
      Repeat
        Open (gBok.BokLst.Itm);
        Application.ProcessMessages;
        gBok.BokLst.Next;
      until gBok.BokLst.Eof;
    end;
  end;
  FreeAndNil (mLinLst);
end;

procedure TJod.ClcDoc; // prepocita hlavicku zadaneho dokladu
begin
end;

procedure TJod.ClcDoc(pDocNum:Str12); // prepocita hlavicku zadaneho dokladu
begin
//  If ohJOH.LocateDocNum(pDocNum) then ohOCH.Clc(ohOCI);
end;

procedure TJod.PrnDoc; // Vytlaèí aktualny doklad
//var mRep:TRep;  mtOCH:TOchTmp;  mhSYSTEM:TSystemHnd;
begin
(*
  mhSYSTEM := TSystemHnd.Create;  mhSYSTEM.Open;
  mtOCH := TOchTmp.Create;  mtOCH.Open;
  mtOCH.Insert;
  BTR_To_PX (ohOCH.BtrTable,mtOCH.TmpTable);
  mtOCH.FgVatVal1 := ohOCH.FgBValue1-ohOCH.FgAValue1;
  mtOCH.FgVatVal2 := ohOCH.FgBValue2-ohOCH.FgAValue2;
  mtOCH.FgVatVal3 := ohOCH.FgBValue3-ohOCH.FgAValue3;
  mtOCH.Post;
  SlcItm(ohOCH.DocNum); // Nacita polozky zadaneho dokladu do PX
  mRep := TRep.Create(Self);
  mRep.SysBtr := mhSYSTEM.BtrTable;
  mRep.HedTmp := mtOCH.TmpTable;
  mRep.ItmTmp := otOCI.TmpTable;
  mRep.Execute('OCD');
  FreeAndNil (mRep);
  FreeAndNil (mtOCH);
  FreeAndNil (mhSYSTEM);
*)
end;

procedure TJod.PrnDoc(pDocNum:Str12); // Vytlaèí zadany doklad
begin
//  Open (BookNumFromDocNum(pDocNum));
//  If ohOCH.LocateDocNum(pDocNum) then PrnDoc; // Vytlaèí aktualny doklad
end;

procedure TJod.SlcItm(pDocNum:Str12); // Nacita polozky zadaneho dokladu do PX
begin
(*
  oAValue := 0;   oBValue := 0;
  If otOCI.Active then otOCI.Close;
  otOCI.Open;
  If ohOCI.LocateDocNum(pDocNum) then begin
    Repeat
      otOCI.Insert;
      BTR_To_PX (ohOCI.BtrTable,otOCI.TmpTable);
      otOCI.Post;
      oAValue := oAValue+ohOCI.FgAValue;
      oBValue := oBValue+ohOCI.FgBValue;
      Application.ProcessMessages;
      ohOCI.Next;
    until ohOCI.Eof or (ohOCI.DocNum<>pDocNum);
  end;
*)
end;

procedure TJod.AddItm; // Prida novu polozku na zadany dodaci lsit
begin
end;

procedure TJod.DelItm;
begin
end;

procedure TJod.DelJob(pDocNum:Str12;pEpcNum:word); // Vymaze hlavicku pracovneho prikazu u zadaneho uzivatela
var mBokNum:Str5;   mDocNum:Str12;
begin
  mBokNum := ohJOB.BokNum;
  mDocNum := ohJOB.DocNum;
  // ---------------------------------------------
  Open(StrIntZero(pEpcNum,5));
  If ohJOB.LocateDocNum(mDocNum) then ohJOB.Delete;
  // ---------------------------------------------
  Open(mBokNum);
  ohJOB.LocateDocNum(mDocNum)
end;

procedure TJod.AddClc(pDocNum: Str12);
var mExist:boolean;  I:word;
begin
  mExist := FALSE;
  If oDocClc.Count>0 then begin  // Mame doklady na prepocitanie
    For I:=0 to oDocClc.Count-1 do begin
      If oDocClc.Strings[I]=pDocNum then mExist := TRUE;
    end
  end;
  If not mExist then oDocClc.Add(pDocNum);
end;

procedure TJod.SaveTxt(pDocNum:Str12;pItmNum:word;pTxtTyp:Str1;pTxtLst:TStrings);
var mCnt:word;
begin
  ohJOBTXT.Del(pDocNum,pItmNum,pTxtTyp);
  If pTxtLst.Count>0 then begin
    mCnt := 0;
    Repeat
      ohJOBTXT.Insert;
      ohJOBTXT.DocNum := pDocNum;
      ohJOBTXT.ItmNum := pItmNum;
      ohJOBTXT.TxtTyp := pTxtTyp;
      ohJOBTXT.TxtLin := mCnt+1;
      ohJOBTXT.TxtVal := pTxtLst.Strings[mCnt];
      ohJOBTXT.Post;
      Inc(mCnt);
    until mCnt=pTxtLst.Count;
  end;
end;

procedure TJod.LoadTxt(pDocNum:Str12;pItmNum:word;pTxtTyp:Str1; pTxtVal:TStrings);
begin
  pTxtVal.Clear;
  If ohJOBTXT.LocateDnInTt(pDocNum,pItmNum,pTxtTyp) then begin
    Repeat
      pTxtVal.Add(ohJOBTXT.TxtVal);
      ohJOBTXT.Next;
    until ohJOBTXT.Eof or (pDocNum<>ohJOBTXT.DocNum) or (pItmNum<>ohJOBTXT.ItmNum) or (pTxtTyp<>ohJOBTXT.TxtTyp);
  end;
end;

procedure TJod.Refresh; // Obnovy hlavicku u ostatnych uzivatelov, ktoremu je prideleny ukol
var mBokNum:Str5;   mDocNum:Str12;   mDat:PDat;
begin
  mBokNum := ohJOB.BokNum;
  mDocNum := ohJOB.DocNum;
  GetMem (mDat,SizeOf(TDat));
  mDat^.rhJOB := ohJOB;
  // ---------------------------------------------
  Open(StrIntZero(0,5));  // Vsetky ukoly
  If ohJOB.LocateDocNum(mDocNum)
    then ohJOB.Edit
    else ohJOB.Insert;
  BTR_To_BTR(mDat^.rhJOB.BtrTable,ohJOB.BtrTable);
  ohJOB.Post;
  Application.ProcessMessages;
  If ohJOB.RspEpcn<>ohJOB.RegEpcn then begin // Zodpovedny pracovnik
    Open(StrIntZero(ohJOB.RspEpcn,5));
    If ohJOB.LocateDocNum(mDocNum)
      then ohJOB.Edit
      else ohJOB.Insert;
    BTR_To_BTR(mDat^.rhJOB.BtrTable,ohJOB.BtrTable);
    ohJOB.Post;
  end;
  Application.ProcessMessages;
  If ohJOBPER.LocateDocNum(mDocNum) then begin // Ostatne priradene osoby
    Repeat
      Open(StrIntZero(ohJOBPER.EpcNum,5));
      If ohJOB.LocateDocNum(mDocNum)
        then ohJOB.Edit
        else ohJOB.Insert;
      BTR_To_BTR(mDat^.rhJOB.BtrTable,ohJOB.BtrTable);
      ohJOB.Post;
      Application.ProcessMessages;
      ohJOBPER.Next;
    until ohJOBPER.Eof or (ohJOBPER.DocNum<>mDocNum);
  end;
  FreeMem (mDat,SizeOf(TDat));
  // ---------------------------------------------
  Open(mBokNum);
  ohJOB.LocateDocNum(mDocNum)
end;

procedure TJod.LstClc; // Prepocita hlavicky zakazkovych dokladov ktore su uvedene v zozname oDocClc
var I:word;
begin
  If oDocClc.Count>0 then begin  // Mame doklady na prepocitanie
    For I:=0 to oDocClc.Count-1 do begin
      Open(BookNumFromDocNum(oDocClc.Strings[I]));
      ClcDoc(oDocClc.Strings[I]);
    end
  end;
end;

end.


