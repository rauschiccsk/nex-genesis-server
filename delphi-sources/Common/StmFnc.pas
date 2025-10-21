unit StmFnc;
// =============================================================================
//                      FUNKCIE PRE SKLADOVÉ HOSPODÁRSTVO
// -----------------------------------------------------------------------------
//
// -----------------------------------------------------------------------------
// ************************* POUŽITÉ DATABÁZOVÉ SÚBORY *************************
// -----------------------------------------------------------------------------
// PROCAT.BTR - produktový katalóg
// STKCRD.BTR - skladové karty zásob
// STKMOV.BTR - denník skladových pohybov
// STKFIF.BTR - denník fifo kariet
// STKPOS.BTR - pozièné karty zásob
// STKCRD.DB  - skladové karty zásob
// STKMOV.DB  - história skladových pohybov vybranej skladovej karty
// STKFIF.DB  - fifo karty vybranej položky
// STKPOS.DB  - pozièné karty vybranej položky
// -----------------------------------------------------------------------------
// *********************** POPIS PRIVATE FUNKCIÍ OBJEKTU ***********************
// -----------------------------------------------------------------------------
// OutSTKFIF - táto funkcia vytvorí zoznam FiFo kariet pod¾a z ktorých zadané
//             množstvo výdaja bude uskutoènené.
//             Funkcia používa parameter:
//             › gPrp.oStm.OutPri - priorita vydávania (D-pod¾a poradia dátumu
//               príjmu; R-najprv vlastnú zásobu a potom konsignaènú; K-najprv
//               konsignaènú zásobu a potom vlastnú)
// AddFifInc - vytvorí fifo kartu na zadaný príjem
// AddStmInc - vytvorí pohyb na zadaný príjem
// AddStcInc - pripoèíta zadaný príjem na skladovú kartu zásob
// AddStcOut - pripoèíta zadaný v8daj zo skladovej karty zásob
// -----------------------------------------------------------------------------
// ************************ POPIS PUBLIC FUNKCIÍ OBJEKTU ***********************
// -----------------------------------------------------------------------------
// ClrBufDat - funkcia vynuluje buffer (dáta objektu)
// ExeStkOut - táto funkcia uskutoèní výdaj produktu zo zadaného skladu
//             Popis parametrov funkcie:
//             › pStkNum - èíslo skladu odkial produkt bude vydaný
//             › pDocDte - dátum dokladu výdaja
//             › pDocNum - internéèíslo dokladu výdaja
//             › pItmNum - poradové èíslo položky dokladu výdaja
//             › pProNum - PLU vydaného produktu
//             › pScmNum - èíslo skladového pohybu
//             › pOutPrq - vydané množstvo
//             Funkcia ešte používa nasleovné nepovinné parametre (property):
//             › pParNum - kód firmy, ktorému produkt bol vydaný
//             › pIncTyp - typ príjmu (R-riadny;K-konsignaèný). Ak je zadaný
//               príznak konsignanèný potom výdaj systém uskutoèní výhradne
//               z konsignaènej zásoby, z riadnej zásoby takúto položku nevydá.
//               Jedná sa o konsignanènú vrátenku.
// ExeStkInc - táto funkcia uskutoèní príjem produktu do zadaného skladu
//             Popis parametrov funkcie:
//             › pStkNum - èíslo skladu kde bude produkt prijatý
//             › pDocDte - dátum dokladu príjmu
//             › pDocNum - internéèíslo dokladu príjmu
//             › pItmNum - poradové èíslo položky dokladu príjmu
//             › pProNum - PLU prijatého produktu
//             › pScmNum - èíslo skladového pohybu
//             › pIncPrq - prijaté množstvo
//             › pIncApc - cena príjmu
//             Funkcia ešte používa nasleovné nepovinné parametre (property):
//             › pParNum - kód firmy, od ktorého produkt bol kúpený
//             › pIncTyp - typ príjmu (R-riadny;K-konsignaèný;C-vysporiadaný kons.)
//             › pRbaCod - kód výrobnej šarže
//             › pRbaDte - dátum výrobnej šarže
//             › pDurDte - dátum ukonèenia trvanlivosti produktu
//             › pRmiStn - èíslo skladu odkial bol produkt presunutý
//             › pRmoStn - èíslo skladu kam bol produkt presunutý
// LodStmTmp - naèíta históriu skladových pohybov vybranej karty do doèasného
//             súboru.
//             › pStkNum - èíslo skladu
//             › pProNum - PLU produktu
// LodFifTmp - naèíta fifo karty vybranej položky do doèasného súboru.
//             › pStkNum - èíslo skladu
//             › pProNum - PLU produktu
// LodStpTmp - naèíta pozièné karty vybranej položky do doèasného súboru.
//             › pStkNum - èíslo skladu
//             › pProNum - PLU produktu
// LodStpHis - naèíta históriu pohybov vybranej pozièné karty do doèasného súboru.
//             › pStkNum - èíslo skladu
//             › pProNum - PLU produktu
//             › pPosCod - pozièné miesto
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
  hPROCAT, hPARCAT,  
  IcTypes, IcConv, IcVariab, IcTools, IcDate, BasFnc, FifLst, NexClc, Prp,
  eSTKLST, eSTKCRD, eSTKMOV, eSTKFIF, eSTKPOS, eSTKPOH, tSTKCRD, tSTKMOV, tSTKFIF, tSTKPOS, tSTKPOH,
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Dialogs, Forms, DateUtils;

type
  TStmFnc=class
    constructor Create;
    destructor Destroy;
  private
    oActStk:word;         // Aktuálný sklad
    oParNum:longint;
    oIncTyp:Str1;
    oRbaCod:Str30;
    oRbaDte:TDate;
    oDurDte:TDate;
    oRmiStn:word;
    oRmoStn:word;
    oFifNum:longint;  // Poradové èíslo fifo karty
    oStmNum:longint;  // Poradové èíslo pohybu
    oCanOut:boolean;  // TRUE ak výdaj je možné uskutoèni
//    oSTKFIF:TSTKFIF;  // Zoznam fifo kariet na výdaj
    function GetActStk:word;
    procedure OutSTKFIF;
    procedure AddFifInc;
    procedure AddStmInc;
    procedure AddStcInc;
    procedure AddStmOut;
    procedure AddStcOut;
  public
    ohPROCAT:TProcatHnd;
    ohPARCAT:TParcatHnd;
    ohSTKLST:TStklstHne;
    oxSTKCRD:TStkcrdHne;
    ohSTKCRD:TStkcrdHne;
    ohSTKMOV:TStkmovHne;
    ohSTKFIF:TStkfifHne;
    ohSTKPOS:TStkposHne;
    ohSTKPOH:TStkpohHne;
    otSTKCRD:TStkcrdTmp;
    otSTKMOV:TStkmovTmp;
    otSTKFIF:TStkfifTmp;
    otSTKPOS:TStkposTmp;
    otSTKPOH:TStkpohTmp;
    procedure ClrBufDat;
    procedure ExeStkOut(pStkNum:word;pDocDte:TDate;pDocNum:Str12;pItmNum,pProNum,pScmNum:longint;pOutPrq:double);
    procedure ExeStkInc(pStkNum:word;pDocDte:TDate;pDocNum:Str12;pItmNum,pProNum,pScmNum:longint;pIncPrq,pIncApc:double);
    procedure LodStmTmp(pStkNum:word;pProNum:longint);
    procedure LodFifTmp(pStkNum:word;pProNum:longint;pNotNul:boolean);
    procedure LodStpTmp(pStkNum:word;pProNum:longint;pNotNul:boolean);
    procedure LodStkPoh(pStkNum:word;pProNum:longint;pPosCod:Str15);
  published
    property ActStk:word read GetActStk write oActStk;

    property ParNum:longint write oParNum;
    property IncTyp:Str1 write oIncTyp;
    property RbaCod:Str30 write oRbaCod;
    property RbaDte:TDate write oRbaDte;
    property DurDte:TDate write oDurDte;
    property RmiStn:word  write oRmiStn;
    property RmoStn:word  write oRmoStn;

    property FifNum:longint read oFifNum;
    property StmNum:longint read oStmNum;
  end;

implementation

// ********************************** OBJECT ***********************************

constructor TStmFnc.Create;
begin
  ohPROCAT:=TProcatHnd.Create;
  ohPARCAT:=TParcatHnd.Create;
  ohSTKLST:=TStklstHne.Create;
  oxSTKCRD:=TStkcrdHne.Create;
  ohSTKCRD:=TStkcrdHne.Create;
  ohSTKMOV:=TStkmovHne.Create;
  ohSTKFIF:=TStkfifHne.Create;
  ohSTKPOS:=TStkposHne.Create;
  ohSTKPOH:=TStkpohHne.Create;
  otSTKCRD:=TStkcrdTmp.Create;
  otSTKMOV:=TStkmovTmp.Create;
  otSTKFIF:=TStkfifTmp.Create;
  otSTKPOS:=TStkposTmp.Create;
  otSTKPOH:=TStkpohTmp.Create;
  ClrBufDat;
end;

destructor TStmFnc.Destroy;
begin
  FreeAndNil(ohPROCAT);
  FreeAndNil(ohPARCAT);
  FreeAndNil(ohSTKLST);
  FreeAndNil(oxSTKCRD);
  FreeAndNil(ohSTKCRD);
  FreeAndNil(ohSTKMOV);
  FreeAndNil(ohSTKFIF);
  FreeAndNil(ohSTKPOS);
  FreeAndNil(otSTKCRD);
  FreeAndNil(otSTKMOV);
  FreeAndNil(otSTKFIF);
  FreeAndNil(otSTKPOS);
end;

// ******************************** PRIVATE ************************************

function TStmFnc.GetActStk:word;
begin
  Result:=oActStk;
  If Result=0 then Result:=gPrp.Stm.MaiStk;
end;

procedure TStmFnc.OutSTKFIF;
begin
end;

procedure TStmFnc.AddFifInc;
begin
end;

procedure TStmFnc.AddStmInc;
begin
end;

procedure TStmFnc.AddStcInc;
begin
end;

procedure TStmFnc.AddStmOut;
begin
end;

procedure TStmFnc.AddStcOut;
begin
end;

// ******************************** PUBLIC *************************************

procedure TStmFnc.ClrBufDat;
begin
  oCanOut:=FALSE;
  oParNum:=0;
  oIncTyp:='R'; oRbaCod:='';
  oRbaDte:=0;   oDurDte:=0;
  oRmiStn:=0;   oRmoStn:=0;
  oFifNum:=0;   oStmNum:=0;
end;

procedure TStmFnc.ExeStkOut(pStkNum:word;pDocDte:TDate;pDocNum:Str12;pItmNum,pProNum,pScmNum:longint;pOutPrq:double);
begin
  OutSTKFIF;
  If oCanOut then begin
    AddStmOut;
    AddStcOut;
  end else begin // Prekontrolujeme skladovú kartu a keï nemá správne aktuálne množstvo opravíme

  end;
end;

procedure TStmFnc.ExeStkInc(pStkNum:word;pDocDte:TDate;pDocNum:Str12;pItmNum,pProNum,pScmNum:longint;pIncPrq,pIncApc:double);
begin
  AddFifInc;
  AddStmInc;
  AddStcInc;
end;

procedure TStmFnc.LodStmTmp(pStkNum:word;pProNum:longint);
var mActPrq:double;
begin
  If otSTKMOV.Active then ClrTmpTab(otSTKMOV.TmpTable) else otSTKMOV.Open;
  If ohSTKMOV.LocSnPn(pStkNum,pProNum) then begin
    // Uložíme pohyby do doèasného súboru
    Repeat
      otSTKMOV.Insert;
      BtrCpyTmp(ohSTKMOV.Table,otSTKMOV.TmpTable);
      If (ohSTKMOV.BpaNum>0) and ohPARCAT.LocParNum(ohSTKMOV.BpaNum) then otSTKMOV.BpaNam:=ohPARCAT.ParNam;
      If (ohSTKMOV.ParNum>0) and ohPARCAT.LocParNum(ohSTKMOV.ParNum) then otSTKMOV.ParNam:=ohPARCAT.ParNam;
      If IsNotNul(ohSTKMOV.MovPrq) then otSTKMOV.MovCpc:=RndBas(ohSTKMOV.MovCva/ohSTKMOV.MovPrq);
      otSTKMOV.Post;
      Application.ProcessMessages;
      ohSTKMOV.Next;
    until ohSTKMOV.Eof or (ohSTKMOV.StkNum<>pStkNum) or (ohSTKMOV.ProNum<>pProNum);
    // Vypoèítame aktuálnu zásobu po každom pohybe
    mActPrq:=0;
    otSTKMOV.SwapIndex;
    otSTKMOV.SetIndex('DocDte');
    otSTKMOV.First;
    Repeat
      mActPrq:=mActPrq+otSTKMOV.MovPrq;
      otSTKMOV.Edit;
      otSTKMOV.ActPrq:=mActPrq;
      otSTKMOV.Post;
      otSTKMOV.Next;
    until otSTKMOV.Eof;
    otSTKMOV.RestIndex;
  end;
end;

procedure TStmFnc.LodFifTmp(pStkNum:word;pProNum:longint;pNotNul:boolean);
begin
  If otSTKFIF.Active then ClrTmpTab(otSTKFIF.TmpTable) else otSTKFIF.Open;
  If ohSTKFIF.LocSnPn(pStkNum,pProNum) then begin
    Repeat
      If IsNotNul(ohSTKFIF.ActPrq) or (IsNul(ohSTKFIF.ActPrq) and not pNotNul) then begin
        otSTKFIF.Insert;
        BtrCpyTmp(ohSTKFIF.Table,otSTKFIF.TmpTable);
        If (ohSTKFIF.ParNum>0) and ohPARCAT.LocParNum(ohSTKFIF.ParNum) then otSTKFIF.ParNam:=ohPARCAT.ParNam;
        otSTKFIF.Post;
      end;
      Application.ProcessMessages;
      ohSTKFIF.Next;
    until ohSTKFIF.Eof or (ohSTKFIF.StkNum<>pStkNum) or (ohSTKFIF.ProNum<>pProNum);
  end;
end;

procedure TStmFnc.LodStpTmp(pStkNum:word;pProNum:longint;pNotNul:boolean);
begin
  If otSTKPOS.Active then ClrTmpTab(otSTKPOS.TmpTable) else otSTKPOS.Open;
  If ohSTKPOS.LocSnPn(pStkNum,pProNum) then begin
    Repeat
      If IsNotNul(ohSTKPOS.ActPrq) or (IsNul(ohSTKPOS.ActPrq) and not pNotNul) then begin
        otSTKPOS.Insert;
        BtrCpyTmp(ohSTKPOS.Table,otSTKPOS.TmpTable);
        otSTKPOS.Post;
      end;
      Application.ProcessMessages;
      ohSTKPOS.Next;
    until ohSTKPOS.Eof or (ohSTKPOS.StkNum<>pStkNum) or (ohSTKPOS.ProNum<>pProNum);
  end;
end;

procedure TStmFnc.LodStkPoh(pStkNum:word;pProNum:longint;pPosCod:Str15);
begin
  If otSTKPOH.Active then ClrTmpTab(otSTKPOH.TmpTable) else otSTKPOH.Open;
  If ohSTKPOH.LocSnPnPc(pStkNum,pProNum,pPosCod) then begin
    Repeat
      otSTKPOH.Insert;
      BtrCpyTmp(ohSTKPOH.Table,otSTKPOH.TmpTable);
      otSTKPOH.Post;
      Application.ProcessMessages;
      ohSTKPOH.Next;
    until ohSTKPOH.Eof or (ohSTKPOH.StkNum<>pStkNum) or (ohSTKPOH.ProNum<>pProNum) or (ohSTKPOH.PosCod<>pPosCod);
  end;
end;

end.


