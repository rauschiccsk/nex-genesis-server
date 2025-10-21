unit Tid;
{$F+}

// *****************************************************************************
//                               OBJEKT NA PRACU S OB
// *****************************************************************************
// Tento objekt obsahuje funkcie, ktoré umožnia naèíta položky dokladov a
// uloži ich do iného dokladu
//
// Programové funkcia:
// ---------------
// *****************************************************************************


interface

uses
  IcTypes, IcConst, IcConv, IcTools, IcValue, IcVariab, NexGlob, NexPath, IcFiles,
  DocHand, SavClc, LinLst, ItgLog, Bok, Rep, Key, Stk, hTIH, hTII, hTIO,
  ComCtrls, SysUtils, Classes, Forms, MxArrays;

type
  PDat=^TDat;
  TDat=record
    rhTIH:TTihHnd;
    rhTII:TTiiHnd;
    rhTIO:TTioHnd;
  end;

  TTid=class(TComponent)
    constructor Create(AOwner: TComponent);
    destructor  Destroy; override;
    private
      oYear:Str2;
      oBokNum:Str5;
      oSerNum:longint;
      oDocNum:Str12;
      oPaCode:longint;
      oDocDate:TDateTime;
      oDocClc:TStrings;
      oOpnBok:TStrings;
      oInd:TProgressBar;
      oStk:TStk;
      oLst:TList;
      function GetBokNum:Str5;
      procedure SetBokNum(pBokNum:Str5);
      function GetOpenCount:word;
    public
      ohTIH:TTihHnd;
      ohTII:TTiiHnd;
      ohTIO:TTioHnd;
      function ActBok:Str5;
      procedure Activate(pIndex:word); // Aktivuje databazu, ktora je otvorena pod poradovym cislom pIndex
      procedure Open(pBokNum:Str5); overload; // Otvori vsetky databazove subory
      procedure Open(pBokNum:Str5;pTIH,pTII,pTIO:boolean); overload;// Otvori zadane databazove subory
      procedure OpenLst(pBokLst:ShortString); // Otvori vsetky knihy ktore su zadane v retazci
      procedure NewDoc(pPaCode:longint;pPaName:ShortString); // Vygeneruje novu hlavicku dokladu

      procedure DocClc(pDocNum:Str12); // Prepocita hlavicku zadaneho dokladu podla jeho poloziek
      procedure DocPrn(pDocNum:Str12); // Vytlaèí zadany doklad
      procedure LstClc; // Prepocita hlavicky dokladov ktore su uvedene v zozname oDocClc
      procedure AddClc(pDocNum:Str12); // Prida doklad do zoznamu, hlavicky ktorych treba prepocitat

      function LocateOnOi  (pTsdNum:Str12;pTsdItm:longint;pActBok:boolean):boolean; // Najde polozku zakazky
      function Docdel(pDocNum:Str12;pHedDel:boolean):boolean;  // Zrusi zadany doklad
    published
      property phTIH:TTIHHnd read ohTIH write ohTIH;
      property phTII:TTIIHnd read ohTII write ohTII;
      property OpenCount:word read GetOpenCount;
      property BokNum:Str5 read GetBokNum write SetBokNum;
      property Year:Str2 read oYear write oYear;
      property SerNum:longint read oSerNum write oSerNum;
      property DocNum:Str12 read oDocNum;
      property PaCode:longint write oPaCode;
      property DocDate:TDateTime write oDocDate;
      property OpnBok:TStrings read oOpnBok;
      property Ind:TProgressBar read oInd write oInd;
  end;

implementation

uses bTII;

constructor TTid.Create(AOwner: TComponent);
begin
  oDocClc:=TStringList.Create;  oDocClc.Clear;
  oOpnBok:=TStringList.Create;  oOpnBok.Clear;
  oStk:=TStk.Create;
  oLst:=TList.Create;  oLst.Clear;
end;

destructor TTid.Destroy;
var I:word;
begin
  If oLst.Count>0 then begin
    For I:=1 to oLst.Count do begin
      Activate(I);
      FreeAndNil(ohTIH);
      FreeAndNil(ohTII);
      FreeAndNil(ohTIO);
    end;
  end;
  FreeAndNil(oLst);
  FreeAndNil(oStk);
  FreeAndNil(oDocClc);
  FreeAndNil(oOpnBok);
end;

// ********************************* PRIVATE ***********************************

function TTid.GetBokNum:Str5;
begin
  Result:=ohTIH.BtrTable.BookNum;
end;

procedure TTid.SetBokNum (pBokNum:Str5);
begin
  Open(pBokNum);
end;

function TTid.GetOpenCount:word;
begin
  Result:=oLst.Count;
end;

procedure TTid.Activate(pIndex:word); // Aktivuje databazu, ktora je otvorena pod poradovym cislom pIndex
var mDat:PDat;
begin
  mDat:=oLst.Items[pIndex-1];
  ohTIH:=mDat.rhTIH;
  ohTII:=mDat.rhTII;
  ohTIO:=mDat.rhTIO;
end;

function TTid.ActBok:Str5;
begin
  Result:='';
  If ohTIH.BtrTable.Active
    then Result:=ohTIH.BtrTable.BookNum
    else begin
      If ohTII.BtrTable.Active
        then Result:=ohTII.BtrTable.BookNum
        else begin
          If ohTIO.BtrTable.Active then Result:=ohTIO.BtrTable.BookNum
        end;
    end;
end;

procedure TTid.Open(pBokNum:Str5); // Otvori vsetky databazove subory
begin
  Open(pBokNum,TRUE,TRUE,TRUE);
end;

procedure TTid.Open(pBokNum:Str5;pTIH,pTII,pTIO:boolean); // Otvori zadane databazove subory
var mFind:boolean;  mCnt:word;  mDat:PDat;
begin
  oBokNum:=pBokNum;
  mFind:=FALSE;
  If oLst.Count>0 then begin
    mCnt:=0;
    Repeat
      Inc(mCnt);
      Activate(mCnt);
      mFind:=ActBok=pBokNum;
    until mFind or (mCnt=oLst.Count);
  end;
  If not mFind then begin // Ak dana kniha este nie je otvorena potomotvorime
    oOpnBok.Add(pBokNum);  // <<< Zistit ci treba tuto premennu pouzivat >>>
    // Vytvorime objekty
    ohTIH:=TTihHnd.Create;
    ohTII:=TTiiHnd.Create;
    ohTIO:=TTioHnd.Create;
    // Otvorime databazove subory
    If pTIH then ohTIH.Open(pBokNum);
    If pTII then ohTII.Open(pBokNum);
    If pTIO then ohTIO.Open(pBokNum);
    // Ulozime objekty do zoznamu
    GetMem(mDat,SizeOf(TDat));
    mDat^.rhTIH:=ohTIH;
    mDat^.rhTII:=ohTII;
    mDat^.rhTIO:=ohTIO;
    oLst.Add(mDat);
  end;
end;

// ********************************** PUBLIC ***********************************

procedure TTid.OpenLst(pBokLst:ShortString); // Otvori vsetky knihy ktore su zadane v retazci
var mLinLst:TLinLst;
begin
  oOpnBok.Clear;
  mLinLst:=TLinLst.Create;
  mLinLst.AddLst(pBokLst);
  If mLinLst.Count>0 then begin
    mLinLst.First;
    Repeat
      If gBok.BokExist('TIB',mLinLst.Itm,TRUE) then begin
        BokNum:=mLinLst.Itm;
      end;
      Application.ProcessMessages;
      mLinLst.Next;
    until mLinLst.Eof;
  end
  else begin  // Otvorime vsetky knihy
    gBok.LoadBokLst('TIB','');
    If gBok.BokLst.Count>0 then begin
      gBok.BokLst.First;
      Repeat
        BokNum:=gBok.BokLst.Itm;
        Application.ProcessMessages;
        gBok.BokLst.Next;
      until gBok.BokLst.Eof;
    end;
  end;
  FreeAndNil(mLinLst);
end;

procedure TTid.NewDoc(pPaCode:longint;pPaName:ShortString); // Vygeneruje novu hlavicku dokladu
begin
  oSerNum:=ohTIH.NextSerNum; // Ak nie je zadane poradove cislo OD vygenerujeme nasledujuce
  oDocDate:=Date; // Ak nie je zadany datum nastavime aktualny den
  oDocNum:=ohTIH.GenDocNum(Year,oSerNum);
  If not ohTIH.LocateDocNum(oDocNum) then begin // Ak neexistuje vyvorime hlacicku dokladu OD
    ohTIH.Insert;
    ohTIH.DocNum:=oDocNum;
    ohTIH.SerNum:=oSerNum;
    ohTIH.DocDate:=oDocDate;
//    ohTIH.StkNum:=gKey.st
//    ohTIH.WriNum:=gKey.StkWriNum();
    ohTIH.StkNum:=20;  //Treba nastavit 
    ohTIH.WriNum:=1;
    ohTIH.PaCode:=pPaCode;
    ohTIH.PaName:=pPaName;
    ohTIH.Status:='O';
    ohTIH.Post;
  end;
end;

procedure TTid.DocClc(pDocNum:Str12); // PrepTIIta hlavicku zadaneho dokladu podla jeho poloziek
var mItmQnt:longint; mCValue,mEValue:double; mXXXValue:TValue8;    I:byte;
begin
  If ohTIH.LocateDocNum(pDocNum) then begin
    mItmQnt := 0;
    mCValue:= 0; mEValue:= 0;
(*
    mAcAValue := TValue8.Create;  mXXXValue.Clear;
    For I:=1 to 3 do begin
      mXXXValue.VatPrc[I] := ohTIH.BtrTable.FieldByName('VatPrc'+StrInt(I,0)).AsInteger;
    end;
*)
    ohTII.SwapIndex;
    If ohTII.LocateDocNum(ohTIH.DocNum) then begin
      Repeat
        Inc (mItmQnt);
        // TII.bdf TIH.bdf
        mCValue := mCValue+ohTII.CValue;
        mEValue := mEValue+ohTII.EValue;
//        mXXXValue.Add (ohTII.VatPrc,ohTII.AcAValue);
        ohTII.Next;
      until (ohTII.Eof) or (ohTII.DocNum<>pDocNum);
    end;
    ohTII.RestoreIndex;
    // Ulozime vypTIItane hodnoty do hlavicky objednavky
    ohTIH.Edit;
    ohTIH.CValue := mCValue;
    ohTIH.EValue := mCValue;
(*
    ohTIH.AcBValue1 := mXXXValue.Value[1];
    ohTIH.AcBValue2 := mXXXValue.Value[2];
    ohTIH.AcBValue3 := mXXXValue.Value[3];
*)
    ohTIH.ItmQnt := mItmQnt;
    ohTIH.Post;
//    FreeAndNil (mXXXValue);
  end;
end;

procedure TTid.DocPrn(pDocNum:Str12); // Vytlaèí zadany dodaci list
var mRep:TRep;
begin
  BokNum := BookNumFromDocNum(pDocNum);
  If ohTIH.LocateDocNum(pDocNum) then begin
    mRep := TRep.Create(Self);
    mRep.HedBtr := ohTIH.BtrTable;
//    mRep.ItmTmp :=
    mRep.Execute('Tid');
    FreeAndNil (mRep);
  end;
end;

procedure TTid.AddClc(pDocNum: Str12);
var mExist:boolean;  I:word;
begin
  mExist := FALSE;
  If oDocClc.Count>0 then begin  // Mame doklady na prepTIItanie
    For I:=0 to oDocClc.Count-1 do begin
      If oDocClc.Strings[I]=pDocNum then mExist := TRUE;
    end
  end;
  If not mExist then oDocClc.Add(pDocNum);
end;

procedure TTid.LstClc; // PrepTIIta hlavicky zakazkovych dokladov ktore su uvedene v zozname oDocClc
var I:word;
begin
  If oDocClc.Count>0 then begin  // Mame doklady na prepTIItanie
    For I:=0 to oDocClc.Count-1 do begin
      BokNum := BookNumFromDocNum(oDocClc.Strings[I]);
      DocClc(oDocClc.Strings[I]);
    end
  end;
end;

function TTid.LocateOnOi  (pTsdNum:Str12;pTsdItm:longint;pActBok:boolean):boolean; // Najde polozku zakazky
var mCnt:word;
begin
  Result := FALSE;
  If pActBok then begin // Hladat len v aktualnej knihe
//  Result := ohTII.LocateOnOi (pOcdNum,pOcdItm);
    ohTII.First;
    while not ohTII.Eof and (ohTII.StdNum<>pTsdNum)and (ohTII.StdItm<>pTsdItm) do begin
      ohTII.Next;
    end;
    Result:=not ohTII.Eof and (ohTII.StdNum=pTsdNum)and (ohTII.StdItm=pTsdItm)
  end
  else begin // Hladat vo vsetkych knihach
    mCnt := 0;
    Repeat
      Activate(mCnt);
//      Result := ohTII.LocateOnOi (pOcdNum,pOcdItm);
      ohTII.First;
      while not ohTII.Eof and (ohTII.StdNum<>pTsdNum)and (ohTII.StdItm<>pTsdItm) do begin
        ohTII.Next;
      end;
      Result:=not ohTII.Eof and (ohTII.StdNum=pTsdNum)and (ohTII.StdItm=pTsdItm);
      Inc (mCnt);
    until Result or (mCnt=oLst.Count);
  end;
end;

function TTid.DocDel(pDocNum:Str12;pHedDel:boolean):boolean;  // Zrusi zadany doklad
begin
(*
  Result := TRUE;
  If ohTIH.LocateDocNum(pDocNum) then begin
    If DocUnr(pDocNum) then begin
      If ohTII.LocateDocNum(pDocNum) then begin
        Repeat
          Application.ProcessMessages;
          If ohTII.StkStat='N'
            then ohTII.Delete
            else begin
              Result := FALSE;
              ohTII.Next;
            end;
        until ohTII.Eof or (ohTII.Count=0) or (ohTII.DocNum<>pDocNum);
      end;
    end;
    ohTIH.Clc(ohTII);
    Result := ohTIH.ItmQnt=0; // Je to v poriadku ak doklad nema ziadne polozky
    If Result and pHedDel then ohTIH.Delete;  // Ak je nastavene zrusenie hlavicky a bola vymazana kazda polozka zrusime hlavicku dokladu
  end;
*)
end;

end.


