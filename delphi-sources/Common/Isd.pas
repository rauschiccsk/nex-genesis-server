unit Isd;
{$F+}

// *****************************************************************************
//                               OBJEKT NA PRACU S DF
// *****************************************************************************
// Programové funkcia:
// ---------------
// Gen - vygeneruje dodávate¾skú faktúru zo zadaného zdrojového dokladu.
//       Zdrojový doklad može by:
//       - Dodávate¾ský dodací list
// *****************************************************************************


interface

uses
  IcTypes, IcConst, IcConv, IcTools, DocHand, NexGlob, NexPath, NexIni,
  TxtDoc, TxtWrap, Key, hPAB, hPLS, hTSH, hTSI, hISH, hISI, hISN, PayFnc,
  SysUtils, Classes, Forms;

type
  PDat=^TDat;
  TDat=record
    rhISH:TIshHnd;
    rhISI:TIsiHnd;
    rhISN:TIsnHnd;
  end;

  TIsd = class(TComponent)
    constructor Create(AOwner: TComponent);
    destructor  Destroy; override;
    private
      oFrmName:Str15;
      oBokNum:Str5;
      oLst:TList;

      oSerNum: longint;
      oYear: Str2;
      oDocNum: Str12;
      oPlsNum: word;
      oPaCode: longint;
      oDocDate: TDateTime;
      ohPAB: TPabHnd;
      procedure Activate(pIndex:word); // Aktivuje databazu, ktora je otvorena pod poradovym cislom pIndex
      procedure IsdFromTsd(pTsdNum:Str12); // Vyhgeneruje DF z DD
    public
      ohISH: TIshHnd;
      ohISI: TIsiHnd;
      ohISN: TIsnHnd;
      procedure Open(pBokNum:Str5); overload; // Otvori vsetky databazove subory
      procedure Open(pBokNum:Str5;pISH,pISI,pISN:boolean); overload;// Otvori zadane databazove subory
      procedure Gen(pSrcDoc:Str12); // Vytvori OF na zaklade zadaneho zdrojoveho dokladu
      procedure Prn; // Vytlaèí aktualnu fakturu
    published
      property BokNum:Str5 read oBokNum;

      property Year:Str2 write oYear;
      property SerNum:longint write oSerNum;
      property DocNum:Str12 read oDocNum;
      property PlsNum:word write oPlsNum;
      property PaCode:longint write oPaCode;
      property DocDate:TDateTime write oDocDate;
  end;

implementation

uses bTSH;

constructor TIsd.Create(AOwner: TComponent);
begin
  oFrmName := AOwner.Name;
  oPlsNum := 1;
  oLst := TList.Create;  oLst.Clear;
  ohPAB := TPabHnd.Create;  ohPAB.Open(0);
  oYear := '';
end;

destructor TIsd.Destroy;
var I:word;
begin
  If oLst.Count>0 then begin
    For I:=1 to oLst.Count do begin
      Activate (I);
      FreeAndNil (ohISN);
      FreeAndNil (ohISI);
      FreeAndNil (ohISH);
    end;
  end;
  FreeAndNil (oLst);
  FreeAndNil (ohPAB);
end;

// ********************************* PRIVATE ***********************************

procedure TIsd.Activate(pIndex:word); // Aktivuje databazu, ktora je otvorena pod poradovym cislom pIndex
var mDat:PDat;
begin
  mDat := oLst.Items[pIndex-1];
  ohISH := mDat.rhISH;
  ohISI := mDat.rhISI;
  ohISN := mDat.rhISN;
end;

procedure TIsd.IsdFromTsd(pTsdNum:Str12); // Vyhgeneruje DF z DD
var mTsbNum:Str5;  mItmNum:word;  mhTSH:TTshHnd;  mhTSI:TTsiHnd;
begin
  mTsbNum := BookNumFromDocNum (pTsdNum);
  mhTSH := TTshHnd.Create;  mhTSH.Open(mTsbNum);
  mhTSI := TTsiHnd.Create;  mhTSI.Open(mTsbNum);
  If mhTSH.LocateDocNum(pTsdNum) then begin
    If mhTSI.LocateDocNum(pTsdNum) then begin
      If mhTSH.IsdNum='' then begin
        If oYear='' then oYear:=mhTSH.Year;
        If oSerNum=0 then oSerNum := ohISH.NextSerNum(oYear); // Ak nie je zadane poradove cislo OD vygenerujeme nasledujuce
        If oDocDate=0 then oDocDate := Date; // Ak nie je zadany datum nastavime aktualny den
        oDocNum := ohISH.GenDocNum(oYear,oSerNum);
      end
      else oDocNum := mhTSH.IsdNum;
      If not ohISH.LocateDocNum(oDocNum) then begin // Ak neexistuje vyvorime hlacicku dokladu OD
        ohISH.Insert;
        BTR_To_BTR (mhTSH.BtrTable,ohISH.BtrTable);
        ohISH.SerNum := oSerNum;
        ohISH.Year   := oYear;
        ohISH.DocNum := oDocNum;
        ohISH.ExtNum := GenExtNum(oDocDate,'',gKey.IcbExnFrm[ohISH.BtrTable.BookNum],oSerNum,ohISH.BtrTable.BookNum,gKey.TcbStkNum[ohISH.BtrTable.BookNum]);
        ohISH.IncNum := ohIsh.ExtNum;
        ohISH.WriNum := gKey.IcbWriNum[ohISH.BtrTable.BookNum];
        ohISH.StkNum := gKey.TcbStkNum[ohISH.BtrTable.BookNum];
        ohISH.CsyCode := gKey.IcbCoSymb[ohISH.BtrTable.BookNum];
        ohISH.FgCourse := 1;
        ohISH.DocDate := oDocDate;
        ohISH.SndDate := oDocDate;
        ohISH.VatDate := oDocDate;
        If ohPAB.LocatePaCode(mhTSH.PaCode) then begin
          ohISH.ExpDate := oDocDate+ohPAB.IcExpDay;
        end;
//        ohISH.FgDvzName := gKey.IsbDvName[ohISH.BtrTable.BookNum];
        ohISH.Post;
      end;
      // Vytvorime polozky OD na zaklade DD
      mItmNum := ohISI.NextItmNum(ohISH.DocNum);
      Repeat
        If mhTSI.IsdNum='' then begin
          ohISI.Insert;
          BTR_To_BTR (mhTSI.BtrTable,ohISI.BtrTable);
          ohISI.DocNum := oDocNum;
          ohISI.ItmNum := mItmNum;
          ohISI.TsdNum := mhTSI.DocNum;
          ohISI.TsdItm := mhTSI.ItmNum;
          ohISI.TsdDate := mhTSI.DocDate;
          ohISI.DocDate := ohISH.DocDate;
          ohISI.Status := 'Q';
          ohISI.FgCValue := RoundCValue(ohISI.FgCValue);
          ohISI.FgEValue := RoundCValue(ohISI.FgEValue);
          ohISI.AcCValue := RoundCValue(ohISI.AcCValue);
          ohISI.AcEValue := RoundCValue(ohISI.AcEValue);
          ohISI.Post;
          // Uložíme odkaz do OD na OF
          mhTSI.Edit;
          mhTSI.IsdNum := ohISI.DocNum;
          mhTSI.IsdItm := ohISI.ItmNum;
          mhTSI.IsdDate := ohISI.DocDate;
          mhTSI.Post;
          Inc (mItmNum);
        end;
        Application.ProcessMessages;
        mhTSI.Next;
      until mhTSI.Eof or (mhTSI.DocNum<>pTsdNum);
      ohISH.Clc(ohISI);
    end;
  end;
  FreeAndNil (mhTSI);
  FreeAndNil (mhTSH);
end;

// ********************************** PUBLIC ***********************************

procedure TIsd.Open(pBokNum:Str5); // Otvori vsetky databazove subory
begin
  Open (pBokNum,TRUE,TRUE,TRUE);
end;

procedure TIsd.Open(pBokNum:Str5;pISH,pISI,pISN:boolean); // Otvori zadane databazove subory
var mFind:boolean;  mCnt:word;  mDat:PDat;
begin
  oBokNum := pBokNum;
  mFind := FALSE;
  If oLst.Count>0 then begin
    mCnt := 0;
    Repeat
      Inc (mCnt);
      Activate(mCnt);
      mFind := ohISH.BtrTable.BookNum=pBokNum;
    until mFind or (mCnt=oLst.Count);
  end;
  If not mFind then begin // Ak dana kniha este nie je otvorena potomotvorime
    // Vytvorime objekty
    ohISH := TIshHnd.Create;
    ohISI := TIsiHnd.Create;
    ohISN := TIsnHnd.Create;
    // Otvorime databazove subory
    If pISH then ohISH.Open(pBokNum);
    If pISI then ohISI.Open(pBokNum);
    If pISN then ohISN.Open(pBokNum);
    // Ulozime objekty do zoznamu
    GetMem (mDat,SizeOf(TDat));
    mDat^.rhISH := ohISH;
    mDat^.rhISI := ohISI;
    mDat^.rhISN := ohISN;
    oLst.Add(mDat);
  end;
end;

procedure TIsd.Gen(pSrcDoc:Str12); // Vytvori OF na zaklade zadaneho zdrojoveho dokladu
var mDocType:byte;
begin
  mDocType := GetDocType (pSrcDoc);
  case mDocType of
    dtTS: IsdFromTsd(pSrcDoc); // Vyggeneruje OF z DD
  end;
end;

procedure TIsd.Prn; // Vytlaèí aktualnu fakturu
begin
end;

end.
