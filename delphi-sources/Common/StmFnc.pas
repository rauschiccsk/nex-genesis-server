unit StmFnc;
// =============================================================================
//                      FUNKCIE PRE SKLADOV� HOSPOD�RSTVO
// -----------------------------------------------------------------------------
//
// -----------------------------------------------------------------------------
// ************************* POU�IT� DATAB�ZOV� S�BORY *************************
// -----------------------------------------------------------------------------
// PROCAT.BTR - produktov� katal�g
// STKCRD.BTR - skladov� karty z�sob
// STKMOV.BTR - denn�k skladov�ch pohybov
// STKFIF.BTR - denn�k fifo kariet
// STKPOS.BTR - pozi�n� karty z�sob
// STKCRD.DB  - skladov� karty z�sob
// STKMOV.DB  - hist�ria skladov�ch pohybov vybranej skladovej karty
// STKFIF.DB  - fifo karty vybranej polo�ky
// STKPOS.DB  - pozi�n� karty vybranej polo�ky
// -----------------------------------------------------------------------------
// *********************** POPIS PRIVATE FUNKCI� OBJEKTU ***********************
// -----------------------------------------------------------------------------
// OutSTKFIF - t�to funkcia vytvor� zoznam FiFo kariet pod�a z ktor�ch zadan�
//             mno�stvo v�daja bude uskuto�nen�.
//             Funkcia pou��va parameter:
//             � gPrp.oStm.OutPri - priorita vyd�vania (D-pod�a poradia d�tumu
//               pr�jmu; R-najprv vlastn� z�sobu a potom konsigna�n�; K-najprv
//               konsigna�n� z�sobu a potom vlastn�)
// AddFifInc - vytvor� fifo kartu na zadan� pr�jem
// AddStmInc - vytvor� pohyb na zadan� pr�jem
// AddStcInc - pripo��ta zadan� pr�jem na skladov� kartu z�sob
// AddStcOut - pripo��ta zadan� v8daj zo skladovej karty z�sob
// -----------------------------------------------------------------------------
// ************************ POPIS PUBLIC FUNKCI� OBJEKTU ***********************
// -----------------------------------------------------------------------------
// ClrBufDat - funkcia vynuluje buffer (d�ta objektu)
// ExeStkOut - t�to funkcia uskuto�n� v�daj produktu zo zadan�ho skladu
//             Popis parametrov funkcie:
//             � pStkNum - ��slo skladu odkial produkt bude vydan�
//             � pDocDte - d�tum dokladu v�daja
//             � pDocNum - intern���slo dokladu v�daja
//             � pItmNum - poradov� ��slo polo�ky dokladu v�daja
//             � pProNum - PLU vydan�ho produktu
//             � pScmNum - ��slo skladov�ho pohybu
//             � pOutPrq - vydan� mno�stvo
//             Funkcia e�te pou��va nasleovn� nepovinn� parametre (property):
//             � pParNum - k�d firmy, ktor�mu produkt bol vydan�
//             � pIncTyp - typ pr�jmu (R-riadny;K-konsigna�n�). Ak je zadan�
//               pr�znak konsignan�n� potom v�daj syst�m uskuto�n� v�hradne
//               z konsigna�nej z�soby, z riadnej z�soby tak�to polo�ku nevyd�.
//               Jedn� sa o konsignan�n� vr�tenku.
// ExeStkInc - t�to funkcia uskuto�n� pr�jem produktu do zadan�ho skladu
//             Popis parametrov funkcie:
//             � pStkNum - ��slo skladu kde bude produkt prijat�
//             � pDocDte - d�tum dokladu pr�jmu
//             � pDocNum - intern���slo dokladu pr�jmu
//             � pItmNum - poradov� ��slo polo�ky dokladu pr�jmu
//             � pProNum - PLU prijat�ho produktu
//             � pScmNum - ��slo skladov�ho pohybu
//             � pIncPrq - prijat� mno�stvo
//             � pIncApc - cena pr�jmu
//             Funkcia e�te pou��va nasleovn� nepovinn� parametre (property):
//             � pParNum - k�d firmy, od ktor�ho produkt bol k�pen�
//             � pIncTyp - typ pr�jmu (R-riadny;K-konsigna�n�;C-vysporiadan� kons.)
//             � pRbaCod - k�d v�robnej �ar�e
//             � pRbaDte - d�tum v�robnej �ar�e
//             � pDurDte - d�tum ukon�enia trvanlivosti produktu
//             � pRmiStn - ��slo skladu odkial bol produkt presunut�
//             � pRmoStn - ��slo skladu kam bol produkt presunut�
// LodStmTmp - na��ta hist�riu skladov�ch pohybov vybranej karty do do�asn�ho
//             s�boru.
//             � pStkNum - ��slo skladu
//             � pProNum - PLU produktu
// LodFifTmp - na��ta fifo karty vybranej polo�ky do do�asn�ho s�boru.
//             � pStkNum - ��slo skladu
//             � pProNum - PLU produktu
// LodStpTmp - na��ta pozi�n� karty vybranej polo�ky do do�asn�ho s�boru.
//             � pStkNum - ��slo skladu
//             � pProNum - PLU produktu
// LodStpHis - na��ta hist�riu pohybov vybranej pozi�n� karty do do�asn�ho s�boru.
//             � pStkNum - ��slo skladu
//             � pProNum - PLU produktu
//             � pPosCod - pozi�n� miesto
// -----------------------------------------------------------------------------
// ********************************* POZN�MKY **********************************
// -----------------------------------------------------------------------------
//
// -----------------------------------------------------------------------------
// ****************************** HIST�RIA ZMIEN *******************************
// -----------------------------------------------------------------------------
// 21.03[24.12.2018] - Nov� funkcia (RZ)
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
    oActStk:word;         // Aktu�ln� sklad
    oParNum:longint;
    oIncTyp:Str1;
    oRbaCod:Str30;
    oRbaDte:TDate;
    oDurDte:TDate;
    oRmiStn:word;
    oRmoStn:word;
    oFifNum:longint;  // Poradov� ��slo fifo karty
    oStmNum:longint;  // Poradov� ��slo pohybu
    oCanOut:boolean;  // TRUE ak v�daj je mo�n� uskuto�ni�
//    oSTKFIF:TSTKFIF;  // Zoznam fifo kariet na v�daj
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
  end else begin // Prekontrolujeme skladov� kartu a ke� nem� spr�vne aktu�lne mno�stvo oprav�me

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
    // Ulo��me pohyby do do�asn�ho s�boru
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
    // Vypo��tame aktu�lnu z�sobu po ka�dom pohybe
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


