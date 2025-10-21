unit Std;
{$F+}
// *****************************************************************************
// **********           DATAB�ZOV� S�BORY SKLADOVEJ Z�SOBY            **********
// *****************************************************************************
// ResAnl - anal�za mo�nosti rezerv�cie - v�sledok: StrQnt,OsrQnt a tSTR polo�ky
//          Anal�za rezerv�cie prebieha nasledovne:
//          1. Najprv h�ad�me mo�nos� rezerv�cie z objedn�vok (STU). Sna��me sa
//             v�dy z najnesk�r�ej dod�vky rezervova�, pod�a po�adovan�ho term�nu
//             dod�vaky z�kazn�ka.
//          2. To �o nebolo mo�n� rezervova� z objedn�vok zarezervujeme z volnej
//             z�soby.
//          3. Na ostatn� mno�stvo generujeme po�iadavku na objednanie
//         V�sledok:
//         - syst�m vypo��ta hore uveden� mno�stv� pod�a bodu 1,2 a 3
//           - SrsQnt - rezervovan� zo z�soby
//           - OrsQnt - rezervovan� z dod�vate�skej objedn�vky
//           - NrsQnt - po�iadavka na objednanie
//         - jednotliv� rezerv�cie polo�kovite s� ulo�en� do do�asn�ho s�boru RES.DB
//
// ResItm - rezerv�cia polo�ky z�kazkov�ho dokladu
// *****************************************************************************
// Chybov� k�dy:
// 201001 - Zadan� PLU neexistuje v b�zovej evidencii
// 201002 - Na zadan� PLU neexistuje skladov� karta z�sob
// 201003 - Z�znam o objednan� tovaru nie je mo�n� prida� lebo u� existuje v STU
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
    rhSTK:TStkHnd;     // Skladov� kasrty z�sob
    rhSTM:TStmHnd;     // Denn�k skladov�ch pohybov
//    rhSTO:TStoHnd;     //
    rhSTU:TStuHnd;     // Dod�vate�sk� objedn�vky
    rhSTR:TStrHnd;     // Rezerv�cie odberate�sk�ch z�kaziek
    rhSTS:TStsHnd;     // Neodpo��tan� maloobchodn� predaj
    rhSTB:TStbHnd;     // Po�iato�n� stavy
    rhSPC:TSpcHnd;     // Pozi�n� skladov� karty
    rhSPM:TSpmHnd;     // Pohyby na pozi�n�ch skladov�ch kart�ch
    rhFIF:TFifHnd;     // FIFO karty
  end;

  TStd=class
    constructor Create;
    destructor Destroy; override;
    private
      oLst:TList;     // Zoznam otvoren�ch skladov
      oErrCod:longint;// Chybov� k�d
      oStkNum:word;   // ��slo aktu�lneho skladu
      oSrsQnt:double; // Rezerv�cia zo z�soby
      oOrsQnt:double; // Rezerv�cia z do�l�ch objedn�vok
      oNrsQnt:double; // Po�adavka na objednanie
      procedure Activate(pIndex:word); // Aktivuje databazu, ktora je otvorena pod poradovym cislom pIndex
      procedure StkRes(pDocNum:Str12;pItmNum,pGsCode,pPaCode:longint;pOrdQnt:double;pReqDat:TDateTime); // Rezervuje zo z�soby
      procedure OsdRes(pDocNum:Str12;pItmNum,pGsCode,pPaCode:longint; var pOrdQnt:double;pReqDat:TDateTime); // Rezervuje z objedn�vky
    public
      ohGSCAT:TGscatHnd;
      ohSTKLST:TStklstHnd;  // Zoznam v�etk�ch skladov
      ohSTK:TStkHnd;  // Skladov� karty z�sob
      ohSTM:TStmHnd;  // Skladov� pohyby
//      ohSTO:TStoHnd;  //
      ohSTU:TStuHnd;  // Dod�vate�sk� objedn�vky
      ohSTR:TStrHnd;  // Rezerv�cie odberate�sk�ch z�kaziek
      ohSTS:TStsHnd;  // Neodpo��tan� maloobchodn� predaj
      ohSTB:TStbHnd;  // Po�iato�n� stavy
      ohSPC:TSpcHnd;  // Pozi�n� z�soba
      ohSPM:TSpmHnd;  // Pozi�n� pohzby
      ohFIF:TFifHnd;  // FIFO karty
      otRES:TResTmp;  // Rezerv�cie
      function Open(pStkNum:word):boolean;  // Otvor� skladov� karty z�sob
      procedure OpenAll;  // Otvor� v�etky s�bory na aktu�lne ��slo skladu
      procedure OpenStm;  // Otvor� ak nie s� otvoren� skaldov� pohyby na aktu�lne ��slo skladu
//      procedure OpenSto;  //
      procedure OpenStu;  // Otvor� ak nie s� otvoren� objedn�vky na aktu�lne ��slo skladu
      procedure OpenStr;  // Otvor� ak nie s� otvoren� rezerv�cie
      procedure OpenSts;  // Otvor� ak nie s� otvoren� MO predaj na aktu�lne ��slo skladu
      procedure OpenStb;  // Otvor� ak nie s� otvoren� po�iato�n� stavy na aktu�lne ��slo skladu
      procedure OpenSpc;  // Otvor� ak nie je otvoren� pozi�n� z�soba
      procedure OpenSpm;  // Otvor� ak nie je otvoren� pozi�n� pohyby
      procedure OpenFif;  // Otvor� ak nie s� otvoren� FIFO karty na aktu�lne ��slo skladu
      procedure OpenGsc;  // Otvor� ak nie s� otvoren� GSCAT

      procedure ClcStu(pGsCode:longint); // Prepo��ta �daje do�k�ch objedn�vok(STU) a ulo�� na skladovej karte(STK)
      procedure ClcStr(pGsCode:longint); // Prepo��ta �daje rezervacie a ulo�� na skladov� kartu(STK)
      procedure AddStk(pGsCode:longint); // Prid� pr�zdnu skladov� kartu do STK
      procedure AddStu(pDocNum:Str12;pItmNum,pGsCode,pPaCode:longint;pOrdQnt:double;pCtmDat:TDateTime); // Prid� polo�ku do STU - dod�vate�sk� objedn�vky
      procedure AddStr(pDocNum:Str12;pItmNum,pGsCode,pPaCode:longint;pOrdQnt:double;pReqDat:TDateTime;pStkRes:boolean); // Zarezervuje polo�ku z�kazky
                // pStkRes=TRUE  - rezerv�cia len z voln�ho mno�stva skladovej z�soby
                // pStkRes=FALSE - rezerv�cia z objedn�vky alebo zo z�soby pod�a po�adovanho term�nu a d�tumu dodania
//      procedure ClcOcr(phOCI:TOciHnd); // Prepo��ta rezerv�cie a ulo�� do polo�ky z�kazky

      function GetOrsQnt(pGsCode:longint;pReqDat:TDateTime):double;  // Mno�stvo, ktor� sa d� rezervova� z objedn�vky na po�adovan� d�tum dod�vky
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

procedure TStd.ClcStu(pGsCode:longint); // Prepo��ta �daje do�k�ch objedn�vok(STU) na skladovej karte(STK)
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

procedure TStd.ClcStr(pGsCode:longint); // Prepo��ta �daje rezervacii na skladovej karte(STK)
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
//    ohSTK.StrQnt:=mStrQnt;      Nedalo sa kompiliva� 08.12.2016
    ohSTK.NrsQnt:=mNrsQnt;
    ohSTK.FroQnt:=ohSTK.OsdQnt-ohSTK.OsrQnt;
//    ohSTK.FreQnt:=ohSTK.ActQnt-ohSTK.StrQnt;    Nedalo sa kompiliva� 08.12.2016
    ohSTK.Post;
  end else oErrCod:=201002;
end;

procedure TStd.AddStk(pGsCode:longint); // Prid� pr�zdnu skladov� kartu do STK
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

procedure TStd.AddStu(pDocNum:Str12;pItmNum,pGsCode,pPaCode:longint;pOrdQnt:double;pCtmDat:TDateTime); // Prid� polo�ku do STU - dod�vate�sk� objedn�vky
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

procedure TStd.StkRes(pDocNum:Str12;pItmNum,pGsCode,pPaCode:longint;pOrdQnt:double;pReqDat:TDateTime); // Rezervuje zo z�soby
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

procedure TStd.OsdRes(pDocNum:Str12;pItmNum,pGsCode,pPaCode:longint; var pOrdQnt:double;pReqDat:TDateTime); // Rezervuje z objedn�vky
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
        otRES.ResQnt:=ohSTU.OrdQnt-ohSTU.ResQnt; // Maxim�ln� mno�stvo �o sa d� rezervova�
        otRES.CtmDat:=ohSTU.CtmDat;
        otRES.Post;
      end;
      ohSTU.Next;
    until ohSTU.Eof or (ohSTU.GsCode<>pGsCode);
    // Zotried�me pod�a potvrden�ho term�nu dodania
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

procedure TStd.AddStr(pDocNum:Str12;pItmNum,pGsCode,pPaCode:longint;pOrdQnt:double;pReqDat:TDateTime;pStkRes:boolean); // Zarezervuje polo�ku z�kazky
var mOrdQnt:double;
begin
  oErrCod:=0;
  mOrdQnt:=pOrdQnt;
  OpenSTU; OpenSTR;
  If ohSTR.LocateDoIt(pDocNum,pItmNum) then begin // Ak existuje z�znam, zru��me a prepo��tame rezerv�ciu na karte
    ohSTR.Delete;
    ClcStr(pGsCode);
  end;
  If pStkRes then begin  // Rezerv�cia len z voln�ho mno�stva skladovej z�soby
    StkRes(pDocNum,pItmNum,pGsCode,pPaCode,pOrdQnt,pReqDat); // Rezervuje zo z�soby
  end else begin // Rezerv�cia z objedn�vky alebo zo z�soby pod�a po�adovanho term�nu a d�tumu dodania
    OsdRes(pDocNum,pItmNum,pGsCode,pPaCode,mOrdQnt,pReqDat); // Rezervuje z objedn�vky  end;
    If IsNotNul(mOrdQnt) then StkRes(pDocNum,pItmNum,pGsCode,pPaCode,mOrdQnt,pReqDat); // Rezervuje zo z�soby
  end;
  ClcStr(pGsCode);
end;

(*
procedure TStd.ClcOcr(phOCI:TOciHnd); // Prepo��ta rezerv�cie a ulo�� do polo�ky z�kazky
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
