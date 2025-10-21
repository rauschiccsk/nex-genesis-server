unit Std;
{$F+}
// *****************************************************************************
// **********           DATABÁZOVÉ SÚBORY SKLADOVEJ ZÁSOBY            **********
// *****************************************************************************
// ResAnl - analýza možnosti rezervácie - výsledok: StrQnt,OsrQnt a tSTR položky
//          Analýza rezervácie prebieha nasledovne:
//          1. Najprv h¾adáme možnos rezervácie z objednávok (STU). Snažíme sa
//             vždy z najneskôršej dodávky rezervova, pod¾a požadovaného termínu
//             dodávaky zákazníka.
//          2. To èo nebolo možné rezervova z objednávok zarezervujeme z volnej
//             zásoby.
//          3. Na ostatné množstvo generujeme požiadavku na objednanie
//         Výsledok:
//         - systém vypoèíta hore uvedené množstvá pod¾a bodu 1,2 a 3
//           - SrsQnt - rezervované zo zásoby
//           - OrsQnt - rezervované z dodávate¾skej objednávky
//           - NrsQnt - požiadavka na objednanie
//         - jednotlivé rezervácie položkovite sú uložené do doèasného súboru RES.DB
//
// ResItm - rezervácia položky zákazkového dokladu
// *****************************************************************************
// Chybové kódy:
// 201001 - Zadané PLU neexistuje v bázovej evidencii
// 201002 - Na zadané PLU neexistuje skladová karta zásob
// 201003 - Záznam o objednaní tovaru nie je možné prida lebo už existuje v STU
//
// *****************************************************************************

interface

uses // hOCI, 
  IcTypes, IcConv, IcTools, IcVariab, IniFiles, SysUtils, NexGlob,
  hGSCAT, hSTKLST, hSTK, hSTM, hSTU, hSTR, hSTS, hSTB, hSPC, hSPM, hFIF, tRES,
  Classes, Forms;

type
  PDat=^TDat;
  TDat=record
    rhSTK:TStkHnd;     // Skladové kasrty zásob
    rhSTM:TStmHnd;     // Denník skladových pohybov
//    rhSTO:TStoHnd;     //
    rhSTU:TStuHnd;     // Dodávate¾ské objednávky
    rhSTR:TStrHnd;     // Rezervácie odberate¾ských zákaziek
    rhSTS:TStsHnd;     // Neodpoèítaný maloobchodný predaj
    rhSTB:TStbHnd;     // Poèiatoèné stavy
    rhSPC:TSpcHnd;     // Pozièné skladové karty
    rhSPM:TSpmHnd;     // Pohyby na pozièných skladových kartách
    rhFIF:TFifHnd;     // FIFO karty
  end;

  TStd=class
    constructor Create;
    destructor Destroy; override;
    private
      oLst:TList;     // Zoznam otvorených skladov
      oErrCod:longint;// Chybový kód
      oStkNum:word;   // Èíslo aktuálneho skladu
      oSrsQnt:double; // Rezervácia zo zásoby
      oOrsQnt:double; // Rezervácia z došlých objednávok
      oNrsQnt:double; // Požadavka na objednanie
      procedure Activate(pIndex:word); // Aktivuje databazu, ktora je otvorena pod poradovym cislom pIndex
      procedure StkRes(pDocNum:Str12;pItmNum,pGsCode,pPaCode:longint;pOrdQnt:double;pReqDat:TDateTime); // Rezervuje zo zásoby
      procedure OsdRes(pDocNum:Str12;pItmNum,pGsCode,pPaCode:longint; var pOrdQnt:double;pReqDat:TDateTime); // Rezervuje z objednávky
    public
      ohGSCAT:TGscatHnd;
      ohSTKLST:TStklstHnd;  // Zoznam všetkých skladov
      ohSTK:TStkHnd;  // Skladové karty zásob
      ohSTM:TStmHnd;  // Skladové pohyby
//      ohSTO:TStoHnd;  //
      ohSTU:TStuHnd;  // Dodávate¾ské objednávky
      ohSTR:TStrHnd;  // Rezervácie odberate¾ských zákaziek
      ohSTS:TStsHnd;  // Neodpoèítaný maloobchodný predaj
      ohSTB:TStbHnd;  // Poèiatoèné stavy
      ohSPC:TSpcHnd;  // Pozièná zásoba
      ohSPM:TSpmHnd;  // Pozièné pohzby
      ohFIF:TFifHnd;  // FIFO karty
      otRES:TResTmp;  // Rezervácie
      function Open(pStkNum:word):boolean;  // Otvorí skladové karty zásob
      procedure OpenAll;  // Otvorí všetky súbory na aktuálne èíslo skladu
      procedure OpenStm;  // Otvorí ak nie sú otvorené skaldové pohyby na aktuálne èíslo skladu
//      procedure OpenSto;  //
      procedure OpenStu;  // Otvorí ak nie sú otvorené objednávky na aktuálne èíslo skladu
      procedure OpenStr;  // Otvorí ak nie sú otvorené rezervácie
      procedure OpenSts;  // Otvorí ak nie sú otvorené MO predaj na aktuálne èíslo skladu
      procedure OpenStb;  // Otvorí ak nie sú otvorené poèiatoèné stavy na aktuálne èíslo skladu
      procedure OpenSpc;  // Otvorí ak nie je otvorené pozièná zásoba
      procedure OpenSpm;  // Otvorí ak nie je otvorené pozièné pohyby
      procedure OpenFif;  // Otvorí ak nie sú otvorené FIFO karty na aktuálne èíslo skladu
      procedure OpenGsc;  // Otvorí ak nie sú otvorené GSCAT

      procedure ClcStu(pGsCode:longint); // Prepoèíta údaje doškých objednávok(STU) a uloží na skladovej karte(STK)
      procedure ClcStr(pGsCode:longint); // Prepoèíta údaje rezervacie a uloží na skladovú kartu(STK)
      procedure AddStk(pGsCode:longint); // Pridá prázdnu skladovú kartu do STK
      procedure AddStu(pDocNum:Str12;pItmNum,pGsCode,pPaCode:longint;pOrdQnt:double;pCtmDat:TDateTime); // Pridá položku do STU - dodávate¾ské objednávky
      procedure AddStr(pDocNum:Str12;pItmNum,pGsCode,pPaCode:longint;pOrdQnt:double;pReqDat:TDateTime;pStkRes:boolean); // Zarezervuje položku zákazky
                // pStkRes=TRUE  - rezervácia len z volného množstva skladovej zásoby
                // pStkRes=FALSE - rezervácia z objednávky alebo zo zásoby pod¾a požadovanho termínu a dátumu dodania
//      procedure ClcOcr(phOCI:TOciHnd); // Prepoèíta rezervácie a uloží do položky zákazky

      function GetOrsQnt(pGsCode:longint;pReqDat:TDateTime):double;  // Množstvo, ktoré sa dá rezervova z objednávky na požadovaný dátum dodávky
    published
      property StkNum:word read oStkNum;
      property ErrCod:longint read oErrCod;
  end;

implementation

uses bSTU, bSTK;

constructor TStd.Create;
begin
  oErrCod:=0;
  ohGSCAT:=TGscatHnd.Create;
  ohSTKLST:=TStklstHnd.Create;
  oLst:=TList.Create;  oLst.Clear;
  otRES:=TResTmp.Create;
end;

destructor TStd.Destroy;
var I:word;
begin
  If oLst.Count>0 then begin
    For I:=1 to oLst.Count do begin
      Activate(I);
      FreeAndNil(ohSTK);
      FreeAndNil(ohSTM);
//      FreeAndNil(ohSTO);
      FreeAndNil(ohSTU);
      FreeAndNil(ohSTR);
      FreeAndNil(ohSTS);
      FreeAndNil(ohSTB);
      FreeAndNil(ohSPC);
      FreeAndNil(ohSPM);
      FreeAndNil(ohFIF);
    end;
  end;
  FreeAndNil(oLst);
  FreeAndNil(otRES);
  FreeAndNil(ohSTKLST);
  FreeAndNil(ohGSCAT);
end;

// ********************************* PRIVATE ***********************************
procedure TStd.Activate(pIndex:word);
var mDat:PDat;
begin
  mDat:=oLst.Items[pIndex-1];
  ohSTK:=mDat.rhSTK;
  ohSTM:=mDat.rhSTM;
//  ohSTO:=mDat.rhSTO;
  ohSTU:=mDat.rhSTU;
  ohSTR:=mDat.rhSTR;
  ohSTS:=mDat.rhSTS;
  ohSTB:=mDat.rhSTB;
  ohSPC:=mDat.rhSPC;
  ohSPM:=mDat.rhSPM;
  ohFIF:=mDat.rhFIF;
end;

// ********************************** PUBLIC ***********************************

function TStd.Open(pStkNum:word):boolean;
var mFind:boolean;  mCnt:word;  mDat:PDat;
begin
  mFind:=FALSE;
  If pStkNum=0 then pStkNum:=1;
  If not ohSTKLST.Active then ohSTKLST.Open;
  Result:=ohSTKLST.LocateStkNum(pStkNum);
  If Result then begin
    oStkNum:=pStkNum;
    If oLst.Count>0 then begin
      mCnt:=0;
      Repeat
        Inc(mCnt);
        Activate(mCnt);
        mFind:=(ValInt(ohSTK.BtrTable.BookNum)=pStkNum);
      until mFind or (mCnt=oLst.Count);
    end;
    If not mFind then begin // Ak dana kniha este nie je otvorena potomotvorime
      // Vytvorime objekty
      ohSTK:=TStkHnd.Create;
      ohSTM:=TStmHnd.Create;
//      ohSTO:=TStoHnd.Create;
      ohSTU:=TStuHnd.Create;
      ohSTR:=TStrHnd.Create;
      ohSTS:=TStsHnd.Create;
      ohSTB:=TStbHnd.Create;
      ohSPC:=TSpcHnd.Create;
      ohSPM:=TSpmHnd.Create;
      ohFIF:=TFifHnd.Create;
      // Otvorime databazove subory
      ohSTK.Open(pStkNum);
      ohSPC.Open(pStkNum); //TIBI !!!
      // Ulozime objekty do zoznamu
      GetMem(mDat,SizeOf(TDat));
      mDat^.rhSTK:=ohSTK;
      mDat^.rhSTM:=ohSTM;
//      mDat^.rhSTO:=ohSTO;
      mDat^.rhSTU:=ohSTU;
      mDat^.rhSTR:=ohSTR;
      mDat^.rhSTS:=ohSTS;
      mDat^.rhSTB:=ohSTB;
      mDat^.rhSPC:=ohSPC;
      mDat^.rhSPM:=ohSPM;
      mDat^.rhFIF:=ohFIF;
      oLst.Add(mDat);
    end;
  end;
end;

procedure TStd.OpenAll;
begin
  OpenStm;
  OpenStu;
  OpenStr;
  OpenSts;
  OpenStb;
  OpenSpc;
  OpenSpm;
  OpenFif;
end;

procedure TStd.OpenStm;
begin
  If not ohSTM.Active then ohSTM.Open(oStkNum);
end;
(*
procedure TStd.OpenSto;
begin
  If not ohSTO.Active then ohSTO.Open(oStkNum);
end;
*)
procedure TStd.OpenStu;
begin
  If not ohSTU.Active then ohSTU.Open(oStkNum);
end;

procedure TStd.OpenStr;
begin
  If not ohSTR.Active then ohSTR.Open(oStkNum);
end;

procedure TStd.OpenSts;
begin
  If not ohSTS.Active then ohSTS.Open(oStkNum);
end;

procedure TStd.OpenStb;
begin
  If not ohSTB.Active then ohSTB.Open(oStkNum);
end;

procedure TStd.OpenSpc;
begin
  If not ohSPC.Active then ohSPC.Open(oStkNum);
end;

procedure TStd.OpenSpm;
begin
  If not ohSPM.Active then ohSPM.Open(oStkNum);
end;

procedure TStd.OpenFif;
begin
  If not ohFIF.Active then ohFIF.Open(oStkNum);
end;

procedure TStd.OpenGsc;
begin
  If not ohGSCAT.Active then ohGSCAT.Open;
end;

procedure TStd.ClcStu(pGsCode:longint); // Prepoèíta údaje doškých objednávok(STU) na skladovej karte(STK)
var mOrdQnt,mResQnt:double;
begin
  oErrCod:=0;
  If not ohSTK.LocateGsCode(pGsCode) then AddStk(pGsCode);
  If ohSTK.LocateGsCode(pGsCode) then begin
    OpenSTU;
    If ohSTU.LocateGsCode(pGsCode) then begin
      Repeat
        mOrdQnt:=mOrdQnt+ohSTU.OrdQnt;
        mResQnt:=mResQnt+ohSTU.ResQnt;
        ohSTU.Next;
      until ohSTU.Eof or (ohSTU.GsCode<>pGsCode);
    end;
    ohSTK.Edit;
    ohSTK.OsdQnt:=mOrdQnt;
    ohSTK.OsrQnt:=mResQnt;
    ohSTK.Post;
  end else oErrCod:=201002;
end;

procedure TStd.ClcStr(pGsCode:longint); // Prepoèíta údaje rezervacii na skladovej karte(STK)
var mOsrQnt,mStrQnt,mNrsQnt:double;
begin
  oErrCod:=0;
  mOsrQnt:=0; mStrQnt:=0; mNrsQnt:=0;
  If not ohSTK.LocateGsCode(pGsCode) then AddStk(pGsCode);
  If ohSTK.LocateGsCode(pGsCode) then begin
    OpenSTR;
    If ohSTR.LocateGsCode(pGsCode) then begin
      Repeat
        If ohSTR.ResSta='O' then mOsrQnt:=mOsrQnt+ohSTR.ResQnt;
        If ohSTR.ResSta='Z' then mStrQnt:=mStrQnt+ohSTR.ResQnt;
        If ohSTR.ResSta='P' then mNrsQnt:=mNrsQnt+ohSTR.ResQnt;
        ohSTR.Next;
      until ohSTR.Eof or (ohSTR.GsCode<>pGsCode);
    end;
    ohSTK.Edit;
    ohSTK.OcdQnt:=mOsrQnt+mStrQnt+mNrsQnt;
    ohSTK.OsrQnt:=mOsrQnt;
//    ohSTK.StrQnt:=mStrQnt;      Nedalo sa kompiliva 08.12.2016
    ohSTK.NrsQnt:=mNrsQnt;
    ohSTK.FroQnt:=ohSTK.OsdQnt-ohSTK.OsrQnt;
//    ohSTK.FreQnt:=ohSTK.ActQnt-ohSTK.StrQnt;    Nedalo sa kompiliva 08.12.2016
    ohSTK.Post;
  end else oErrCod:=201002;
end;

procedure TStd.AddStk(pGsCode:longint); // Pridá prázdnu skladovú kartu do STK
begin
  If not ohSTK.LocateGsCode(pGsCode) then begin
    OpenGsc;
    If ohGSCAT.LocateGsCode(pGsCode) then begin
      ohSTK.Insert;
      Btr_To_Btr(ohGSCAT.BtrTable,ohSTK.BtrTable);
      ohSTK.Post;
    end else oErrCod:=201001;
  end;
end;

procedure TStd.AddStu(pDocNum:Str12;pItmNum,pGsCode,pPaCode:longint;pOrdQnt:double;pCtmDat:TDateTime); // Pridá položku do STU - dodávate¾ské objednávky
begin
  oErrCod:=0;
  OpenSTU;
  If not ohSTU.LocateDoIt(pDocNum,pItmNum) then begin
    ohSTU.Insert;
    ohSTU.DocNum:=pDocNum;
    ohSTU.ItmNum:=pItmNum;
    ohSTU.GsCode:=pGsCode;
    ohSTU.PaCode:=pPaCode;
    ohSTU.OrdQnt:=pOrdQnt;
    ohSTU.CtmDat:=pCtmDat;
    ohSTU.Post;
  end else oErrCod:=201003;
end;

procedure TStd.StkRes(pDocNum:Str12;pItmNum,pGsCode,pPaCode:longint;pOrdQnt:double;pReqDat:TDateTime); // Rezervuje zo zásoby
var mResQnt,mOrdQnt:double;
begin
  mOrdQnt:=pOrdQnt;
  If ohSTK.LocateGsCode(pGsCode) then begin
    If ohSTK.FreQnt>0 then begin
      If ohSTK.FreQnt<pOrdQnt then begin
        mResQnt:=ohSTK.FreQnt;
        mOrdQnt:=mOrdQnt-ohSTK.FreQnt;
      end else begin
        mResQnt:=mOrdQnt;
        mOrdQnt:=0;
      end;
      ohSTR.Insert;
      ohSTR.DocNum:=pDocNum;
      ohSTR.ItmNum:=pItmNum;
      ohSTR.GsCode:=pGsCode;
      ohSTR.PaCode:=pPaCode;
      ohSTR.OrdQnt:=pOrdQnt;
      ohSTR.ResQnt:=mResQnt;
      ohSTR.ReqDat:=pReqDat;
      ohSTR.ResSta:='Z';
      ohSTR.Post;
    end;
  end else AddStk(pGsCode);
  If IsNotNul(mOrdQnt) then begin
    ohSTR.Insert;
    ohSTR.DocNum:=pDocNum;
    ohSTR.ItmNum:=pItmNum;
    ohSTR.GsCode:=pGsCode;
    ohSTR.PaCode:=pPaCode;
    ohSTR.OrdQnt:=pOrdQnt;
    ohSTR.ResQnt:=mOrdQnt;
    ohSTR.ReqDat:=pReqDat;
    ohSTR.ResSta:='P';
    ohSTR.Post;
  end;
end;

procedure TStd.OsdRes(pDocNum:Str12;pItmNum,pGsCode,pPaCode:longint; var pOrdQnt:double;pReqDat:TDateTime); // Rezervuje z objednávky
var mResQnt,mOrdQnt:double;
begin
  mOrdQnt:=pOrdQnt;
  If ohSTU.LocateGsCode(pGsCode) then begin
    otRES.Open;
    Repeat
      If (ohSTU.OrdQnt-ohSTU.ResQnt>0) and (ohSTU.CtmDat<=pReqDat) then begin
        otRES.Insert;
        otRES.DocNum:=ohSTU.DocNum;
        otRES.ItmNum:=ohSTU.ItmNum;
        otRES.ResQnt:=ohSTU.OrdQnt-ohSTU.ResQnt; // Maximálné množstvo èo sa dá rezervova
        otRES.CtmDat:=ohSTU.CtmDat;
        otRES.Post;
      end;
      ohSTU.Next;
    until ohSTU.Eof or (ohSTU.GsCode<>pGsCode);
    // Zotriedíme pod¾a potvrdeného termínu dodania
    If otRES.Count>0 then begin
      otRES.SetIndex(ixCtmDat);
      Repeat
        If otRES.ResQnt<mOrdQnt then begin
          mResQnt:=otRES.ResQnt;
          mOrdQnt:=mOrdQnt-otRES.ResQnt;
        end else begin
          mResQnt:=mOrdQnt;
          mOrdQnt:=0;
        end;
        ohSTR.Insert;
        ohSTR.DocNum:=pDocNum;
        ohSTR.ItmNum:=pItmNum;
        ohSTR.GsCode:=pGsCode;
        ohSTR.PaCode:=pPaCode;
        ohSTR.OrdQnt:=pOrdQnt;
        ohSTR.ResQnt:=mResQnt;
        ohSTR.ResDoc:=otRES.DocNum;
        ohSTR.ResItm:=otRES.ItmNum;
        ohSTR.ReqDat:=pReqDat;
        ohSTR.ResSta:='O';
        ohSTR.Post;
        If ohSTU.LocateDoIt(otRES.DocNum,otRES.ItmNum) then begin
          ohSTU.Edit;
          ohSTU.ResQnt:=ohSTU.ResQnt+mResQnt;
          ohSTU.Post;
        end;
        otRES.Next;
      until otRES.Eof or IsNul(mOrdQnt);
    end;
    otRES.Close;
  end;
end;

procedure TStd.AddStr(pDocNum:Str12;pItmNum,pGsCode,pPaCode:longint;pOrdQnt:double;pReqDat:TDateTime;pStkRes:boolean); // Zarezervuje položku zíkazky
var mOrdQnt:double;
begin
  oErrCod:=0;
  mOrdQnt:=pOrdQnt;
  OpenSTU; OpenSTR;
  If ohSTR.LocateDoIt(pDocNum,pItmNum) then begin // Ak existuje záznam, zrušíme a prepoèítame rezerváciu na karte
    ohSTR.Delete;
    ClcStr(pGsCode);
  end;
  If pStkRes then begin  // Rezervácia len z volného množstva skladovej zásoby
    StkRes(pDocNum,pItmNum,pGsCode,pPaCode,pOrdQnt,pReqDat); // Rezervuje zo zásoby
  end else begin // Rezervácia z objednávky alebo zo zásoby pod¾a požadovanho termínu a dátumu dodania
    OsdRes(pDocNum,pItmNum,pGsCode,pPaCode,mOrdQnt,pReqDat); // Rezervuje z objednávky  end;
    If IsNotNul(mOrdQnt) then StkRes(pDocNum,pItmNum,pGsCode,pPaCode,mOrdQnt,pReqDat); // Rezervuje zo zásoby
  end;
  ClcStr(pGsCode);
end;

(*
procedure TStd.ClcOcr(phOCI:TOciHnd); // Prepoèíta rezervácie a uloží do položky zákazky
var mOsrQnt,mStrQnt,mNrsQnt:double;
begin
  OpenSTR;
  mOsrQnt:=0; mStrQnt:=0; mNrsQnt:=0;
  If ohSTR.LocateDoIt(phOCI.DocNum,phOCI.ItmNum) then begin
    Repeat
      If ohSTR.ResSta='O' then mOsrQnt:=mOsrQnt+ohSTR.ResQnt;
      If ohSTR.ResSta='Z' then mStrQnt:=mStrQnt+ohSTR.ResQnt;
      If ohSTR.ResSta='P' then mNrsQnt:=mNrsQnt+ohSTR.ResQnt;
      ohSTR.Next;
    until ohSTR.Eof or (ohSTR.DocNum<>phOCI.DocNum) or (ohSTR.ItmNum<>phOCI.ItmNum);
  end;
  If (phOCI.OsrQnt<>mOsrQnt) or (phOCI.ResQnt<>mStrQnt) then begin
    phOCI.Edit;
    phOCI.OsrQnt:=mOsrQnt;
    phOCI.ResQnt:=mStrQnt;
    phOCI.Post;
  end;
end;
*)

function TStd.GetOrsQnt(pGsCode:longint;pReqDat:TDateTime):double;
begin
  OpenSTU;
  Result:=0;
  If ohSTU.LocateGsCode(pGsCode) then begin
    Repeat
      If (ohSTU.OrdQnt-ohSTU.ResQnt>0) and (ohSTU.CtmDat<=pReqDat) then Result:=Result+ohSTU.OrdQnt-ohSTU.ResQnt;
      ohSTU.Next;
    until ohSTU.Eof or (ohSTU.GsCode<>pGsCode);
  end;
end;

end.
