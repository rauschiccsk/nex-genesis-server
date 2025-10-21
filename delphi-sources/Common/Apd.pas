unit Apd;
{$F+}

// *****************************************************************************
//                       ZIADOSTI BEZHOTOVOSTNEHO STYKU
// *****************************************************************************

interface

uses
  IcTypes, IcConst, IcVariab, IcConv, IcTools, NexGlob, NexPath, NexMsg, NexError,
  IcValue, DocHand, SavClc, LinLst, Bok, Rep, Key,  Sig,
  hSYSTEM, hPAB, hAPH, bAPH, hAPC, tAPC, hAPT,
  ComCtrls, SysUtils, Classes, Forms, MxArrays;

type
  PDat=^TDat;
  TDat=record
    rhAPH:TAphHnd;
    rhAPC:TApcHnd;
    rhAPT:TAptHnd;
  end;

  TApd = class(TComponent)
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
      ohAPH:TAphHnd;
      ohAPC:TApcHnd;
      ohAPT:TAptHnd;
      otAPC:TApcTmp;
      function GetBokNum:Str5;
      function GenDocNum(pSerNum:longint):Str12; // Vygeneruje interne cislo dokladu
      function NextDocNum:Str12; // Vygeneruje nasledujuce cislo dokladu
      procedure Activate(pIndex:word); // Aktivuje databazu, ktora je otvorena pod poradovym cislom pIndex
      procedure Open(pBokNum:Str5); overload; // Otvori vsetky databazove subory
      procedure Open(pBokNum:Str5;pAPH,pAPC,pAPT:boolean); overload; // Otvori vsetky databazove subory

      procedure OpenLst(pBokLst:ShortString); // Otvori vsetky knihy ktore su zadane v retazci
      procedure ClcDoc; overload; // Prepocita hlavicku aktualneho dokladu
      procedure ClcDoc(pDocNum:Str12); overload; // Prepocita hlavicku zadaneho dokladu podla jeho poloziek
      procedure PrnDoc; overload; // Vytlaèí aktualny doklad
      procedure PrnDoc(pDocNum:Str12); overload; // Vytlaèí zadany doklad
      procedure SlcItm(pDocNum:Str12); // Nacita polozky zadaneho dokladu do PX
      procedure AddItm; // Prida novu polozku na aktulany doklad
      procedure DelItm;
      procedure LstClc; // Prepocita hlavicky zakazkovych dokladov ktore su uvedene v zozname oDocClc
      procedure AddClc(pDocNum:Str12); // Prida doklad do zoznamu, hlavicky ktorych treba prepocitat
      procedure SaveTxt(pDocNum:Str12;pTxtTyp:Str1;pTxtLst:TStrings);
      procedure LoadTxt(pDocNum:Str12;pTxtTyp:Str1; pTxtVal:TStrings);
      procedure LoadApc(pDocNum:Str12);
    published
      property OpenCount:word read GetOpenCount;
      property BokNum:Str5 read GetBokNum;
      property OpnBok:TStrings read oOpnBok;
      property Ind:TProgressBar read oInd write oInd;
  end;

implementation

constructor TApd.Create(AOwner: TComponent);
begin
  oFrmName := AOwner.Name;
  oDocClc := TStringList.Create;  oDocClc.Clear;
  oOpnBok := TStringList.Create;  oOpnBok.Clear;
  oLst := TList.Create;  oLst.Clear;
  ohPAB := TPabHnd.Create;  ohPAB.Open(0);
  otAPC := TApcTmp.Create;
end;

destructor TApd.Destroy;
var I:word;
begin
  If oLst.Count>0 then begin
    For I:=1 to oLst.Count do begin
      Activate (I);
      FreeAndNil (ohAPH);
      FreeAndNil (ohAPC);
      FreeAndNil (ohAPT);
    end;
  end;
  FreeAndNil (oLst);
  FreeAndNil (oDocClc);
  FreeAndNil (oOpnBok);
  FreeAndNil (ohPAB);
  FreeAndNil (otAPC);
end;

// ********************************* PRIVATE ***********************************

function TApd.GetOpenCount:word;
begin
  Result := oLst.Count;
end;

procedure TApd.Activate(pIndex:word); // Aktivuje databazu, ktora je otvorena pod poradovym cislom pIndex
var mDat:PDat;
begin
  mDat := oLst.Items[pIndex-1];
  ohAPH := mDat.rhAPH;
  ohAPC := mDat.rhAPC;
  ohAPT := mDat.rhAPT;
end;

// ********************************** PUBLIC ***********************************

function TApd.GetBokNum:Str5;
begin
  Result := '';
  If ohAPH.Active then Result := ohAPH.BokNum;
end;

function TApd.GenDocNum(pSerNum:longint):Str12; // Vygeneruje interne cislo dokladu
begin
  Result := 'JD'+BokNum+StrIntZero(pSerNum,5);
end;

function TApd.NextDocNum:Str12; // Vygeneruje nasledujuce cislo dokladu
var mSerNum:word;
begin
  ohAPH.SwapStatus;
  ohAPH.SetIndex(bAPH.ixDocNum);
  ohAPH.Last;
  mSerNum := ohAPH.SerNum+1;
  ohAPH.RestoreStatus;
  Result := GenDocNum(mSerNum);
end;

procedure TApd.Open(pBokNum:Str5); // Otvori vsetky databazove subory
begin
  Open (pBokNum,TRUE,TRUE,TRUE);
end;

procedure TApd.Open(pBokNum:Str5;pAPH,pAPC,pAPT:boolean); // Otvori zadanu knihu prikazov
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
    ohAPH := TAphHnd.Create;
    ohAPC := TApcHnd.Create;
    ohAPT := TAptHnd.Create;
    If pAPH then ohAPH.Open(pBokNum);
    If pAPC then ohAPC.Open(pBokNum);
    If pAPT then ohAPT.Open(pBokNum);
    // Ulozime objekty do zoznamu
    GetMem (mDat,SizeOf(TDat));
    mDat^.rhAPH := ohAPH;
    mDat^.rhAPC := ohAPC;
    mDat^.rhAPT := ohAPT;
    oLst.Add(mDat);
  end;
end;

procedure TApd.OpenLst(pBokLst:ShortString); // Otvori vsetky knihy ktore su zadane v retazci
var mLinLst:TLinLst;
begin
  oOpnBok.Clear;
  mLinLst := TLinLst.Create;
  mLinLst.AddLst(pBokLst);
  If mLinLst.Count>0 then begin
    mLinLst.First;
    Repeat
      If gBok.BokExist('APB',mLinLst.Itm,TRUE) then Open(mLinLst.Itm);
      Application.ProcessMessages;
      mLinLst.Next;
    until mLinLst.Eof;
  end
  else begin  // Otvorime vsetky knihy
    gBok.LoadBokLst('APB','');
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

procedure TApd.ClcDoc; // prepocita hlavicku zadaneho dokladu
begin
end;

procedure TApd.ClcDoc(pDocNum:Str12); // prepocita hlavicku zadaneho dokladu
begin
//  If ohJOH.LocateDocNum(pDocNum) then ohOCH.Clc(ohOCI);
end;

procedure TApd.PrnDoc; // Vytlaèí aktualny doklad
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

procedure TApd.PrnDoc(pDocNum:Str12); // Vytlaèí zadany doklad
begin
//  Open (BookNumFromDocNum(pDocNum));
//  If ohOCH.LocateDocNum(pDocNum) then PrnDoc; // Vytlaèí aktualny doklad
end;

procedure TApd.SlcItm(pDocNum:Str12); // Nacita polozky zadaneho dokladu do PX
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

procedure TApd.AddItm; // Prida novu polozku na zadany dodaci lsit
begin
end;

procedure TApd.DelItm;
begin
end;

procedure TApd.AddClc(pDocNum: Str12);
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

procedure TApd.SaveTxt(pDocNum:Str12;pTxtTyp:Str1;pTxtLst:TStrings);
var mCnt:word;
begin
  ohAPT.Del(pDocNum,pTxtTyp);            
  If pTxtLst.Count>0 then begin
    mCnt := 0;
    Repeat
      ohAPT.Insert;
      ohAPT.DocNum := pDocNum;
      ohAPT.TxtTyp := pTxtTyp;
      ohAPT.TxtLin := mCnt+1;
      ohAPT.TxtVal := pTxtLst.Strings[mCnt];
      ohAPT.Post;
      Inc(mCnt);
    until mCnt=pTxtLst.Count;
  end;
end;

procedure TApd.LoadTxt(pDocNum:Str12;pTxtTyp:Str1; pTxtVal:TStrings);
begin
  pTxtVal.Clear;
  If ohAPT.LocateDnTt(pDocNum,pTxtTyp) then begin
    Repeat
      pTxtVal.Add(ohAPT.TxtVal);
      ohAPT.Next;
    until ohAPT.Eof or (pDocNum<>ohAPT.DocNum) or (pTxtTyp<>ohAPT.TxtTyp);
  end;
end;

procedure TApd.LoadApc(pDocNum:Str12);
begin
  otAPC.Open;
  If ohAPC.LocateDocNum(pDocNum) then begin
    Repeat
      otAPC.Insert;
      BTR_To_PX(ohAPC.BtrTable,otAPC.TmpTable);
      otAPC.ActPos := ohAPC.ActPos;
      otAPC.Post;
      ohAPC.Next;
    until ohAPC.Eof or (ohAPC.DocNum<>pDocNum);
  end;
end;

procedure TApd.LstClc; // Prepocita hlavicky zakazkovych dokladov ktore su uvedene v zozname oDocClc
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


