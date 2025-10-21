unit PayFnc;
// =============================================================================
//                        FUNKCIE DENN�KU �HRADY FAKT�R
// -----------------------------------------------------------------------------
// -----------------------------------------------------------------------------
// ************************* POU�IT� DATAB�ZOV� S�BORY *************************
// -----------------------------------------------------------------------------
// PAYJRN.BTR - denn�k �hrady fakt�r
// -----------------------------------------------------------------------------
// *********************** POPIS PRIVATE FUNKCI� OBJEKTU ***********************
// -----------------------------------------------------------------------------
// -----------------------------------------------------------------------------
// ************************ POPIS PUBLIC FUNKCI� OBJEKTU ***********************
// -----------------------------------------------------------------------------
// AddPayJrn - funkcia prid� do denn�ka �hrady fakt�r z�znam aktu�lnej polo�ky
//             bankov�ho v�pisu
//             � phBSMITM - datab�za polo�iek bankov�ch v�pisov
// DelPayJrn - funkcia vyma�e denn�ka �hrady fakt�r z�znam aktu�lnej polo�ky
//             bankov�ho v�pisu
//             � phBSMITM - datab�za polo�iek bankov�ch v�pisov
// ClcInvPay - funkcia prepo��ta �hradu zadanej fakt�ry. Automaticky z intern�-
//             ho ��sla fakt�ry ur�� typ fakt�ry (DF alebo OF)
//             � pDocNum - intern� ��slo dod�vate�skej fakt�ry
// LodPayHis - z denn�ku �hrad na��ta v�etky �hrady zadanej fakt�ry
//             � pDocNum - intern� ��slo fakt�ry
// -----------------------------------------------------------------------------
// ********************************* POZN�MKY **********************************
// -----------------------------------------------------------------------------
//
// -----------------------------------------------------------------------------
// ****************************** HIST�RIA ZMIEN *******************************
// -----------------------------------------------------------------------------
// 21.04[28.02.2019] - Nov� funkcia (RZ)
// =============================================================================

interface

uses
  hISH, hICH, hMCH, Key,
  IcTypes, IcConv, IcVariab, IcTools, IcDate, BasFnc, UsrFnc, ParCat, ePAYJRN, tPAYJRN, eBSMITM, hPARCAT,
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Dialogs, Forms, DateUtils;

type
  TPayFnc=class
    constructor Create;
    destructor Destroy; override;
  private
    oPayDte:TDate;
    oInvVal:double;
    oInvAcv:double;
    oAfpVal:double;
    oAfpAcv:double;
  public
    oPar:TParCat;
    ohPARCAT:TParcatHnd;
    ohPAYJRN:TPayjrnHne;
    otPAYJRN:TPayjrnTmp;
    procedure ClcPayVal(pDocNum:Str12;pEndDte,pExpDte:TDate);
    procedure ClcInvPay(pDocNum:Str12);
    procedure AddPayJrn(phBSMITM:TBsmItmHne); overload;
    procedure AddPayJrn(pDocNum:Str12;pItmNum:word;pVarSym,pInvDoc:Str12;pPayDte:TDate;pParNum:longint;pPayVal:double;pWriNum:word;pPayDes:Str60); overload;
    procedure DelPayJrn(pDocNum:Str12;pItmNum,pCitNum:word);
    procedure LodPayHis(pDocNum:Str12);
  published
    property PayDte:TDate read oPayDte;   // D�tum poslednej �hrady
    property InvVal:double read oInvVal;  // Uhraden� �iastka v bankovej mene
    property InvAcv:double read oInvAcv;  // Uhraden� �iastka v ��tovnej mene
    property AfpVal:double read oAfpVal;  // Uhraden� �iastka po splatnosti v bankovej mene
    property AfpAcv:double read oAfpAcv;  // Uhraden� �iastka po splatnosti v bankovej mene
  end;

implementation

// ********************************** OBJECT ***********************************

constructor TPayFnc.Create;
begin
  oPar:=TParCat.Create;
  ohPARCAT:=TParcatHnd.Create;
  ohPAYJRN:=TPayjrnHne.Create;
  otPAYJRN:=TPayjrnTmp.Create;
end;

destructor TPayFnc.Destroy;
begin
  FreeAndNil(otPAYJRN);
  FreeAndNil(ohPAYJRN);
  FreeAndNil(ohPARCAT);
  FreeAndNil(oPar);
end;

// ******************************** PRIVATE ************************************

// ******************************** PUBLIC *************************************

procedure TPayFnc.ClcPayVal(pDocNum:Str12;pEndDte,pExpDte:TDate);
var mSigVal:double;
begin
  // Vypo��tame �hradu zadanej fakt�ry
  oPayDte:=0; oInvVal:=0; oInvAcv:=0; oAfpVal:=0; oAfpAcv:=0;
  If ohPAYJRN.LocInvDoc(pDocNum) then begin
    Repeat
      mSigVal:=1;
      If ohPAYJRN.InvTyp='S' then mSigVal:=(-1);
      If ohPAYJRN.PayDte>pEndDte then begin  //TIBI 26.04.2019
(*        If (pExpDte=0) or (ohPAYJRN.PayDte<=pExpDte) then begin // Fakt�ra bola zaplaten� do d�tumu splatnosti
          oInvVal:=oInvVal+Rd2(ohPAYJRN.InvVal*mSigVal);
          oInvAcv:=oInvAcv+Rd2(ohPAYJRN.InvAcv*mSigVal);
        end else begin // Fakt�ra bola zaplaten� po d�tumu splatnosti
          oAfpVal:=oAfpVal+Rd2(ohPAYJRN.InvVal*mSigVal);
          oAfpAcv:=oAfpAcv+Rd2(ohPAYJRN.InvAcv*mSigVal);
        end;
        If ohPAYJRN.PayDte>oPayDte then oPayDte:=ohPAYJRN.PayDte;*)
      end else begin
        // TIBI 26.04.2019
        oInvVal:=oInvVal+Rd2(ohPAYJRN.InvVal*mSigVal);
        oInvAcv:=oInvAcv+Rd2(ohPAYJRN.InvAcv*mSigVal);
        If ohPAYJRN.PayDte>oPayDte then oPayDte:=ohPAYJRN.PayDte;
      end;
      Application.ProcessMessages;
      ohPAYJRN.Next;
    until ohPAYJRN.Eof or (ohPAYJRN.InvDoc<>pDocNum);
  end;
end;

procedure TPayFnc.ClcInvPay(pDocNum:Str12);
var mDocYer:Str2; mBokNum:Str5; mSigVal,mPayFgv,mPayAcv:double; mPayDte:TDateTime; mhISH:TIshHnd; mhICH:TIchHnd;  mhMCH:TMchHnd;
begin
  // Vypo��tame �hradu zadanej fakt�ry
  oInvVal:=0; oInvAcv:=0; oPayDte:=0;
  If ohPAYJRN.LocInvDoc(pDocNum) then begin
    Repeat
      mSigVal:=1;
      If ohPAYJRN.InvTyp='S' then mSigVal:=(-1);
      oInvVal:=oInvVal+Rd2(ohPAYJRN.InvVal*mSigVal);
      oInvAcv:=oInvAcv+Rd2(ohPAYJRN.InvAcv*mSigVal);
      If ohPAYJRN.PayDte>oPayDte then oPayDte:=ohPAYJRN.PayDte;
      ohPAYJRN.Next;
    until ohPAYJRN.Eof or (ohPAYJRN.InvDoc<>pDocNum);
  end;
  // Ur��me ��slo knihy fakt�ry
  mDocYer:=copy(pDocNum,3,2);
  If mDocYer<=gKey.Sys.SavYer
    then mBokNum:='P-'+copy(pDocNum,5,3)
    else mBokNum:='A-'+copy(pDocNum,5,3);
  // Ulo��me �daje �hrady do dod�vate�skej fakt�ry
  If copy(pDocNum,1,2)='DF' then begin
    mhISH:=TIshHnd.Create;  mhISH.Open(mBokNum);
    If mhISH.LocateDocNum(pDocNum) then begin
      mhISH.Edit;
      mhISH.FgPayVal:=oInvVal;
      mhISH.AcPayVal:=oInvAcv;
      mhISH.FgEndVal:=mhISH.FgEValue-mhISH.FgPayVal;
      mhISH.AcEndVal:=mhISH.AcEValue-mhISH.AcPayVal;
      mhISH.PayDate:=oPayDte;
      mhISH.Post;
    end;
    FreeAndNil(mhISH);
  end;
  // Ulo��me �daje �hrady do odberate�skej fakt�ry
  If copy(pDocNum,1,2)='OF' then begin
    mhICH:=TIchHnd.Create;  mhICH.Open(mBokNum);
    If mhICH.LocateDocNum(pDocNum) then begin
      mhICH.Edit;
      mhICH.FgPayVal:=oInvVal;
      mhICH.AcPayVal:=oInvAcv;
      mhICH.FgEndVal:=mhICH.FgBValue-mhICH.FgPayVal;
      mhICH.AcEndVal:=mhICH.AcBValue-mhICH.AcPayVal;
      mhICH.PayDate:=oPayDte;
      If IsNul(mhICH.FgEndVal) and IsNul(mhICH.AcEndVal) then mhICH.DstPay:=1 else mhICH.DstPay:=0;
      mhICH.Post;
    end;
    FreeAndNil(mhICH);
  end;
  // Ulo��me �daje �hrady do odberate�skej z�lohy
  If copy(pDocNum,1,2)='CP' then begin
    mhMCH:=TMchHnd.Create;  mhMCH.Open(mBokNum);
    If mhMCH.LocateDocNum(pDocNum) then begin
      mhMCH.Edit;
      mhMCH.FgPayVal:=oInvVal;
      mhMCH.AcPayVal:=oInvAcv;
      mhMCH.FgEndVal:=mhMCH.FgPValue-mhMCH.FgPayVal;
      mhMCH.AcEndVal:=mhMCH.AcPValue-mhMCH.AcPayVal;
      mhMCH.PayDate:=oPayDte;
      mhMCH.Post;
    end;
    FreeAndNil(mhMCH);
  end;
end;

procedure TPayFnc.AddPayJrn(phBSMITM:TBsmItmHne);
begin
  If ohPAYJRN.LocDoItCn(phBSMITM.DocNum,phBSMITM.ItmNum,phBSMITM.CitNum) then ohPAYJRN.Edit else ohPAYJRN.Insert;
  BtrCpyBtr(phBSMITM.Table,ohPAYJRN.Table);
  ohPAYJRN.ParNam:=oPar.ParNam[ohPAYJRN.ParNum];
  ohPAYJRN.Post;
  // TODO: Kontrola z�pisu polo�ky
  ClcInvPay(phBSMITM.InvDoc);
end;

procedure TPayFnc.AddPayJrn(pDocNum:Str12;pItmNum:word;pVarSym,pInvDoc:Str12;pPayDte:TDate;pParNum:longint;pPayVal:double;pWriNum:word;pPayDes:Str60);
begin
  If ohPAYJRN.LocDoItCn(pDocNum,pItmNum,0) then begin
    ohPAYJRN.Edit;
    ohPAYJRN.ModUsr:=gUsr.UsrLog;
    ohPAYJRN.ModUsn:=gUsr.UsrNam;
    ohPAYJRN.ModDte:=Date;
    ohPAYJRN.ModTim:=Time;
  end else  begin
    ohPAYJRN.Insert;
    ohPAYJRN.DocNum:=pDocNum;
    ohPAYJRN.ItmNum:=pItmNum;
    ohPAYJRN.DocYer:=copy(pDocNum,3,2);
    ohPAYJRN.CrtUsr:=gvSys.LoginName;
    ohPAYJRN.CrtUsn:=gvSys.Username;
    ohPAYJRN.CrtDte:=Date;
    ohPAYJRN.CrtTim:=Time;
  end;
  ohPAYJRN.VarSym:=pVarSym;
  ohPAYJRN.PayDte:=pPayDte;
  ohPAYJRN.PayDes:=pPayDes;
  ohPAYJRN.ParNum:=pParNum;
  If pParNum<>0 then begin
    If ohPARCAT.LocParNum(pParNum) then ohPAYJRN.ParNam:=ohPARCAT.ParNam;
  end;
  ohPAYJRN.PayDvz:='EUR';
  ohPAYJRN.PayCrs:=1;
  ohPAYJRN.PayVal:=pPayVal;
  ohPAYJRN.PayAcv:=pPayVal;
  ohPAYJRN.InvDoc:=pInvDoc;
  If copy(pInvDoc,1,2)='DF' then ohPAYJRN.InvTyp:='S' else ohPAYJRN.InvTyp:='C';
  ohPAYJRN.InvDvz:='EUR';
  ohPAYJRN.InvCrs:=1;
  ohPAYJRN.InvVal:=pPayVal;
  ohPAYJRN.InvAcv:=pPayVal;
  ohPAYJRN.WriNum:=pWriNum;
  ohPAYJRN.Post;
  // TODO: Kontrola z�pisu polo�ky
  ClcInvPay(pInvDoc);
end;

procedure TPayFnc.DelPayJrn(pDocNum:Str12;pItmNum,pCitNum:word);
var mInvDoc:Str12;
begin
  If ohPAYJRN.LocDoItCn(pDocNum,pItmNum,pCitNum) then begin
    mInvDoc:=ohPAYJRN.InvDoc;
    ohPAYJRN.Delete;
    ClcInvPay(mInvDoc);
    // TODO: Kontrola vymazania z�znamu
  end;
end;

procedure TPayFnc.LodPayHis(pDocNum:Str12);
var mSigVal:double;
begin
  If not otPAYJRN.Active then otPAYJRN.Open;
  oInvVal:=0; oInvAcv:=0; oPayDte:=0;
  ClrTmpTab(otPAYJRN.TmpTable);
  If ohPAYJRN.LocInvDoc(pDocNum) then begin
    Repeat
      If not otPAYJRN.LocDoItCn(ohPAYJRN.DocNum,ohPAYJRN.ItmNum,ohPAYJRN.CitNum) then begin
        otPAYJRN.Insert;
        BtrCpyTmp(ohPAYJRN.Table,otPAYJRN.TmpTable);
        otPAYJRN.Post;
        mSigVal:=1;
        If otPAYJRN.InvTyp='S' then mSigVal:=(-1);
        oInvVal:=oInvVal+Rd2(otPAYJRN.InvVal*mSigVal);
        oInvAcv:=oInvAcv+Rd2(otPAYJRN.InvAcv*mSigVal);
        If oPayDte<otPAYJRN.PayDte then oPayDte:=otPAYJRN.PayDte;
      end;
      ohPAYJRN.Next;
    until ohPAYJRN.Eof or (ohPAYJRN.InvDoc<>pDocNum);
  end;
end;
//        oInvAcv:=oInvAcv+Rd2((otPAYJRN.InvAcv+otPAYJRN.CdvAcv+otPAYJRN.PdvAcv)*mSigVal);

end.


