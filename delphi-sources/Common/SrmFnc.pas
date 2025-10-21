unit SrmFnc;
// =============================================================================
//                      FUNKCIE MODULU - SKLADOVÉ PRESUNY
// -----------------------------------------------------------------------------
//
// -----------------------------------------------------------------------------
// ************************* POUŽITÉ DATABÁZOVÉ SÚBORY *************************
// -----------------------------------------------------------------------------
// SRDLST.BTR - hlavièky dokladov skladových presunov
// SRDITM.BTR - položky dokladov skladových presunov
// SRDNOT.BTR - poznámky dokladov skladových presunov
// SRDITM.DB  - doèasný súbor položiek vybraného dokladu
// -----------------------------------------------------------------------------
// *********************** POPIS PRIVATE FUNKCIÍ OBJEKTU ***********************
// -----------------------------------------------------------------------------
// -----------------------------------------------------------------------------
// ************************ POPIS PUBLIC FUNKCIÍ OBJEKTU ***********************
// -----------------------------------------------------------------------------
// NewSerNum - Hodnota funkcie je nasledujúce poradové èíslo dokladu pre daný rok
//             › pDocYer - rok (yy) do ktorého bude zaevidovaný doklad
// CrtDocNum - Hodnota funkcie je interné èíslo dokladu, ktoré vygeneruje na zák-
//             lade zadaných parametrov.
//             › pDocYer - rok do ktorého patrí doklad
//             › pBokNum - èíslo knihy, do ktorého bude zaevidovaný doklad
//             › pSerNum - poradové èíslo dokladu
// TmpItmRef - Obnoví údaje aktuálnej položky docasného suboru z BTR
// SrdItmTmp - Naèíta položky zadaného dokladu do doèasného súboru.
//             › pDocNum - interné èíslo dokladu, položky ktorého budú naèítané.
// ClcSlcDoc - Prepoèíta hlavièkové údaje dokladu na základe jeho položiek.
//             Okrem prepoètu èíselných údajov funkcia overuje hlavièkové údaje
//             v položkách a v prípadné nesúlady automaticky opraví.
//             › pDocNum - interné èíslo dokladu
// AddDocLst - Pridá èíslo dokladu do zoznamu dokladov, ktoré boli zmenené.
//             › pDocNum - interné èíslo dokladu
// ClcDocLst - Prepoèíta všetky hlavièky zoznamu vytvoreén pomocou AddDocLst.
// -----------------------------------------------------------------------------
// ********************************* POZNÁMKY **********************************
// -----------------------------------------------------------------------------
//
// -----------------------------------------------------------------------------
// ****************************** HISTÓRIA ZMIEN *******************************
// -----------------------------------------------------------------------------
// 21.03[24.12.2018] - Nová funkcia (RZ)
// =============================================================================

interface

uses
  IcTypes, IcConv, IcVariab, IcTools, IcDate, BasFnc, NexClc, eSRDLST, eSRDITM, eSRDNOT, tSRDITM,
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Dialogs, Forms, DateUtils;

type
  TSrmFnc=class
    constructor Create;
    destructor Destroy; override;
  private
    oActBok:Str3;         // Aktuálna kniha dokladov
    oDocLst:TStrings;     // Zoznam dokladov, ktoré boli zmenené
  public
    oxSRDLST:TSrdlstHne;
    ohSRDLST:TSrdlstHne;
    ohSRDITM:TSrditmHne;
    ohSRDNOT:TSrdnotHne;
    otSRDITM:TSrditmTmp;
    function CrtDocNum(pDocYer:Str2;pBokNum:Str3;pSerNum:longint):Str12;

    procedure TmpItmRef;  // Obnoví údaje aktuálnej položky docasného suboru
    procedure SrdItmTmp(pDocNum:Str12); // Naèíta položky zadaného dokladu do doèasného súboru
    procedure AddDocLst(pDocNum:Str12);  // Pridá adresu hlavièky do zoznamu zákaziek, ktoré boli zmenené
    procedure ClcSlcDoc(pDocNum:Str12);  // Prepoèíta hlavièkové údaje dokladu na základe jeho položiek - pritom overuje hlavièkové údaje v položkách
    procedure ClcDocLst;  // Prepoèíta všetky hlavièky zoznamu vytvorené pomocou AddDocLst
  published
    property ActBok:Str3 read oActBok write oActBok;     // Aktuálna kniha dokladov
    property DocLst:TStrings read oDocLst;
  end;

implementation

// ********************************** OBJECT ***********************************

constructor TSrmFnc.Create;
begin
  oDocLst:=TStringList.Create;  oDocLst.Clear;
  oxSRDLST:=TSrdlstHne.Create;
  ohSRDLST:=TSrdlstHne.Create;
  ohSRDITM:=TSrditmHne.Create;
  ohSRDNOT:=TSrdnotHne.Create;
  otSRDITM:=TSrditmTmp.Create;
end;

destructor TSrmFnc.Destroy;
begin
  FreeAndNil(oDocLst);
  FreeAndNil(oxSRDLST);
  FreeAndNil(ohSRDLST);
  FreeAndNil(ohSRDITM);
  FreeAndNil(ohSRDNOT);
  FreeAndNil(otSRDITM);
end;

// ******************************** PRIVATE ************************************

// ******************************** PUBLIC *************************************

function TSrmFnc.CrtDocNum(pDocYer:Str2;pBokNum:Str3;pSerNum:longint):Str12;
begin
  Result:='MP'+pDocYer+pBokNum+StrIntZero(pSerNum,5);
end;

procedure TSrmFnc.TmpItmRef;  // Obnoví údaje aktuálnej položky docasného suboru
begin
  If ohSRDITM.GotoPos(otSRDITM.ActPos) then begin
    otSRDITM.Edit;
    BtrCpyTmp(ohSRDITM.Table,otSRDITM.TmpTable);
    otSRDITM.Post;
  end;
end;

procedure TSrmFnc.SrdItmTmp(pDocNum:Str12);
begin
  If otSRDITM.Count>0 then ClrTmpTab(otSRDITM.TmpTable);
  If ohSRDITM.LocDocNum(pDocNum) then begin
    Repeat
      otSRDITM.Insert;
      BtrCpyTmp(ohSRDITM.Table,otSRDITM.TmpTable);
      otSRDITM.Post;
      ohSRDITM.Next;
    until ohSRDITM.Eof or (ohSRDITM.DocNum<>pDocNum);
  end;
end;

procedure TSrmFnc.AddDocLst(pDocNum:Str12);  // Pridá adresu hlavièky do zoznamu zákaziek, ktoré boli zmenené
var mExist:boolean;  I:word;
begin
  mExist:=FALSE;
  If oDocLst.Count>0 then begin  // Zoznam nie je prázdny
    For I:=0 to oDocLst.Count-1 do begin
      If oDocLst.Strings[I]=pDocNum then mExist:=TRUE;
    end
  end;
  If not mExist then oDocLst.Add(pDocNum);
end;

procedure TSrmFnc.ClcSlcDoc(pDocNum:Str12);
var mProVol,mProWgh,mStkAva,mMovPrq,mOutPrq:double; mItmQnt:word;
begin
  ohSRDLST.SwapIndex;
  If ohSRDLST.DocNum<>pDocNum then ohSRDLST.LocDocNum(pDocNum);
  If ohSRDLST.DocNum=pDocNum then begin
    mProVol:=0;  mProWgh:=0;  mStkAva:=0;  mMovPrq:=0;  mOutPrq:=0;  mItmQnt:=0;
    ohSRDITM.SwapStatus;
    If ohSRDITM.LocDocNum(pDocNum) then begin
      Repeat
        Inc(mItmQnt);
        mProVol:=mProVol+ohSRDITM.ProVol*ohSRDITM.MovPrq;
        mProWgh:=mProWgh+ohSRDITM.ProWgh*ohSRDITM.MovPrq;
        mStkAva:=mStkAva+ohSRDITM.StkAva;
        mMovPrq:=mMovPrq+ohSRDITM.MovPrq;
        mOutPrq:=mOutPrq+ohSRDITM.OutPrq;
        Application.ProcessMessages;
        ohSRDITM.Next;
      until ohSRDITM.Eof or (ohSRDITM.DocNum<>pDocNum);
    end;
    ohSRDITM.RestStatus;
    // Uložíme údaje do hlavièky dokladu
    ohSRDLST.Edit;
    ohSRDLST.ItmQnt:=mItmQnt;
    ohSRDLST.ProVol:=mProVol;
    ohSRDLST.ProWgh:=mProWgh;
    ohSRDLST.StkAva:=RndBas(mStkAva);
    ohSRDLST.MovPrq:=RndBas(mMovPrq);
    ohSRDLST.OutPrq:=RndBas(mOutPrq);
//    If ohSRDITM.DstLck='R' then ohSRDITM.DstLck:='';
    ohSRDITM.Post;
  end;
  ohSRDLST.RestIndex;
end;

procedure TSrmFnc.ClcDocLst;  // Prepoèíta všetky hlavièky zoznamu vytvoreén pomocou AddDocLst
var I:word;
begin
  If oDocLst.Count>0 then begin  // Zoznam nie je prázdny
    For I:=0 to oDocLst.Count-1 do begin
      Application.ProcessMessages;
      ClcSlcDoc(oDocLst.Strings[I]);
    end;
    oDocLst.Clear;
  end;
end;

end.


