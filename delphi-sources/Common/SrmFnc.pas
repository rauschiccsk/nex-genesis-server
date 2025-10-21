unit SrmFnc;
// =============================================================================
//                      FUNKCIE MODULU - SKLADOV� PRESUNY
// -----------------------------------------------------------------------------
//
// -----------------------------------------------------------------------------
// ************************* POU�IT� DATAB�ZOV� S�BORY *************************
// -----------------------------------------------------------------------------
// SRDLST.BTR - hlavi�ky dokladov skladov�ch presunov
// SRDITM.BTR - polo�ky dokladov skladov�ch presunov
// SRDNOT.BTR - pozn�mky dokladov skladov�ch presunov
// SRDITM.DB  - do�asn� s�bor polo�iek vybran�ho dokladu
// -----------------------------------------------------------------------------
// *********************** POPIS PRIVATE FUNKCI� OBJEKTU ***********************
// -----------------------------------------------------------------------------
// -----------------------------------------------------------------------------
// ************************ POPIS PUBLIC FUNKCI� OBJEKTU ***********************
// -----------------------------------------------------------------------------
// NewSerNum - Hodnota funkcie je nasleduj�ce poradov� ��slo dokladu pre dan� rok
//             � pDocYer - rok (yy) do ktor�ho bude zaevidovan� doklad
// CrtDocNum - Hodnota funkcie je intern� ��slo dokladu, ktor� vygeneruje na z�k-
//             lade zadan�ch parametrov.
//             � pDocYer - rok do ktor�ho patr� doklad
//             � pBokNum - ��slo knihy, do ktor�ho bude zaevidovan� doklad
//             � pSerNum - poradov� ��slo dokladu
// TmpItmRef - Obnov� �daje aktu�lnej polo�ky docasn�ho suboru z BTR
// SrdItmTmp - Na��ta polo�ky zadan�ho dokladu do do�asn�ho s�boru.
//             � pDocNum - intern� ��slo dokladu, polo�ky ktor�ho bud� na��tan�.
// ClcSlcDoc - Prepo��ta hlavi�kov� �daje dokladu na z�klade jeho polo�iek.
//             Okrem prepo�tu ��seln�ch �dajov funkcia overuje hlavi�kov� �daje
//             v polo�k�ch a v pr�padn� nes�lady automaticky oprav�.
//             � pDocNum - intern� ��slo dokladu
// AddDocLst - Prid� ��slo dokladu do zoznamu dokladov, ktor� boli zmenen�.
//             � pDocNum - intern� ��slo dokladu
// ClcDocLst - Prepo��ta v�etky hlavi�ky zoznamu vytvore�n pomocou AddDocLst.
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
  IcTypes, IcConv, IcVariab, IcTools, IcDate, BasFnc, NexClc, eSRDLST, eSRDITM, eSRDNOT, tSRDITM,
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Dialogs, Forms, DateUtils;

type
  TSrmFnc=class
    constructor Create;
    destructor Destroy; override;
  private
    oActBok:Str3;         // Aktu�lna kniha dokladov
    oDocLst:TStrings;     // Zoznam dokladov, ktor� boli zmenen�
  public
    oxSRDLST:TSrdlstHne;
    ohSRDLST:TSrdlstHne;
    ohSRDITM:TSrditmHne;
    ohSRDNOT:TSrdnotHne;
    otSRDITM:TSrditmTmp;
    function CrtDocNum(pDocYer:Str2;pBokNum:Str3;pSerNum:longint):Str12;

    procedure TmpItmRef;  // Obnov� �daje aktu�lnej polo�ky docasn�ho suboru
    procedure SrdItmTmp(pDocNum:Str12); // Na��ta polo�ky zadan�ho dokladu do do�asn�ho s�boru
    procedure AddDocLst(pDocNum:Str12);  // Prid� adresu hlavi�ky do zoznamu z�kaziek, ktor� boli zmenen�
    procedure ClcSlcDoc(pDocNum:Str12);  // Prepo��ta hlavi�kov� �daje dokladu na z�klade jeho polo�iek - pritom overuje hlavi�kov� �daje v polo�k�ch
    procedure ClcDocLst;  // Prepo��ta v�etky hlavi�ky zoznamu vytvoren� pomocou AddDocLst
  published
    property ActBok:Str3 read oActBok write oActBok;     // Aktu�lna kniha dokladov
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

procedure TSrmFnc.TmpItmRef;  // Obnov� �daje aktu�lnej polo�ky docasn�ho suboru
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

procedure TSrmFnc.AddDocLst(pDocNum:Str12);  // Prid� adresu hlavi�ky do zoznamu z�kaziek, ktor� boli zmenen�
var mExist:boolean;  I:word;
begin
  mExist:=FALSE;
  If oDocLst.Count>0 then begin  // Zoznam nie je pr�zdny
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
    // Ulo��me �daje do hlavi�ky dokladu
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

procedure TSrmFnc.ClcDocLst;  // Prepo��ta v�etky hlavi�ky zoznamu vytvore�n pomocou AddDocLst
var I:word;
begin
  If oDocLst.Count>0 then begin  // Zoznam nie je pr�zdny
    For I:=0 to oDocLst.Count-1 do begin
      Application.ProcessMessages;
      ClcSlcDoc(oDocLst.Strings[I]);
    end;
    oDocLst.Clear;
  end;
end;

end.


