unit Mcf;
{$F+}
// *****************************************************************************
// **********       FUNKCIE NA PR�CU S TERMIN�LOV�MI V�DAJKAMI        **********
// *****************************************************************************
interface

uses
  IcTypes, IcConv, IcTools, IcVariab, IniFiles, IcDate, SysUtils, NexGlob, DocHand,
  NexPath, NexIni, Key, Dat, Plc, SavClc, Forms;

type
  TMcf=class
    constructor Create(pDat:TDat);
    destructor Destroy; override;
    private
      oDat:TDat;
      function NewItmNum(pDocNum:Str12;pFreItm:boolean):word; // ��slo novej polo�ky - pEndNum=TRIE - na konci dokladu v opa�nom pr�pade h�ad� vynechan� ��sla
    public
      procedure NewDoc(pTrmNum,pPaCode:longint;pPaName:Str30;pPlsNum:word;pCusCrd:Str20);  // Vytvor� nov� doklad
      procedure AddItm(pDocNum:Str12;pItmNum:word;pGsCode:longint;pGsQnt,pHprice,pBprice:double;pHpcSrc:Str3);
      procedure ModItm(pDocNum:Str12;pItmNum:word;pGsQnt,pHprice,pBprice:double;pHpcSrc:Str3);
    published
  end;

implementation

constructor TMcf.Create(pDat:TDat);
begin
  oDat:=pDat;
end;

destructor TMcf.Destroy;
begin
end;

// ********************************* PRIVATE ***********************************

function TMcf.NewItmNum(pDocNum:Str12;pFreItm:boolean):word;
var mItmNum:word;  mFind:boolean;
begin
  Result:=0;
  With oDat.oDod.oMcd do begin
    If pFreItm then begin  // H�ad� vynechan� poradov� ��sla
      ohMCI.SwapIndex;
      If ohMCI.LocateDoIt(pDocNum,1) then begin
        mItmNum:=0;
        Repeat
          Inc(mItmNum);
          mFind:=mItmNum<ohMCI.ItmNum;
          If mItmNum>ohMCI.ItmNum then mItmNum:=ohMCI.ItmNum;
          ohMCI.Next;
        until Eof or mFind or (ohMCI.DocNum<>pDocNum);
        If mFind
          then Result:=mItmNum
          else Result:=mItmNum+1;
      end
      else Result:=1;
      ohMCI.RestoreIndex;
    end else begin // Vygeneruje nov� ��slo na konci dokladu
      If not ohMCI.NearestDoIt(pDocNum,65000) then ohMCI.Last;
      If not ohMCI.IsLastRec or (ohMCI.DocNum<>pDocNum) then ohMCI.Prior;
      If ohMCI.DocNum=pDocNum
        then Result:=ohMCI.ItmNum+1
        else Result:=1;
    end;
  end;
end;

// ********************************** PUBLIC ***********************************
procedure TMcf.NewDoc(pTrmNum,pPaCode:longint;pPaName:Str30;pPlsNum:word;pCusCrd:Str20);
var mSerNum:word;  mDocNum:Str12;
begin
  With oDat.oDod.oMcd do begin
    mSerNum:=ohMCH.NextSerNum(SysYear); // Ak nie je zadane poradove cislo OD vygenerujeme nasledujuce
    mDocNum:=ohMCH.GenDocNum(SysYear,mSerNum);
    If not ohMCH.LocateDocNum(mDocNum) then begin // Ak neexistuje vyvorime hlacicku dokladu OD
      ohMCH.Insert;
      ohMCH.TrmNum:=pTrmNum;
      ohMCH.SerNum:=mSerNum;
      ohMCH.DocNum:=mDocNum;
      ohMCH.ExtNum:=GenExtNum(Date,'',gKey.McbExnFmt[ohMCH.BokNum],mSerNum,ohMCH.BokNum,ohMCH.StkNum);
      ohMCH.DocDate:=Date;
      ohMCH.PaCode:=pPaCode;
      ohMCH.PaName:=pPaName;
      ohMCH.CusCard:=pCusCrd;
      ohMCH.StkNum:=gKey.McbStkNum[ohMCH.BokNum];
      ohMCH.PlsNum:=pPlsNum;
      ohMCH.Post;
    end;
  end;
end;

procedure TMcf.AddItm(pDocNum:Str12;pItmNum:word;pGsCode:longint;pGsQnt,pHprice,pBprice:double;pHpcSrc:Str3);
var mBokNum:Str5;  mSav:TSavClc;
begin
  mBokNum:=BookNumFromDocNum(pDocNum);
  oDat.oDod.oMcd.OpenMCI;
  If pItmNum=0 then pItmNum:=NewItmNum(pDocNum,FALSE);
  If oDat.oGsd.GsCode<>pGsCode then oDat.oGsd.LocGsCode(pGsCode);
  If oDat.oGsd.GsCode=pGsCode then begin
    With oDat.oDod.oMcd do begin
      If ohMCH.DocNum<>pDocNum then ohMCH.LocateDocNum(pDocNum);
      If ohMCH.DocNum=pDocNum then begin
        mSav:=TSavClc.Create;
        mSav.GsQnt:=pGsQnt;
        mSav.VatPrc:=oDat.oGsd.ohGSC.VatPrc;
        mSav.DscPrc:=gPlc.ClcDscPrc(pHprice,pBprice);
        mSav.FgBValue:=pBPrice*pGsQnt;
        ohMCI.Insert;
        BTR_To_BTR(oDat.oGsd.ohGSC.BtrTable,ohMCI.BtrTable);
        ohMCI.DocNum:=pDocNum;
        ohMCI.ItmNum:=pItmNum;
        ohMCI.StkNum:=ohMCH.StkNum;
        ohMCI.PaCode:=ohMCH.PaCode;
        ohMCI.DocDate:=ohMCH.DocDate;
        ohMCI.GsQnt:=pGsQnt;
        ohMCI.DscPrc:=mSav.DscPrc;
        ohMCI.AcDValue:=mSav.FgDValue;
        ohMCI.AcAValue:=mSav.FgAValue;
        ohMCI.AcBValue:=mSav.FgBValue;
        ohMCI.FgDPrice:=mSav.FgDPrice;
        ohMCI.FgBPrice:=mSav.FgBPrice;
        ohMCI.FgDValue:=mSav.FgDValue;
        ohMCI.FgAValue:=mSav.FgAValue;
        ohMCI.FgBValue:=mSav.FgBValue;
        ohMCI.Post;
        FreeAndNil(mSav);
        // Zap�eme �daje do hlavi�ky dokladu
        ohMCH.Clc(ohMCI);
      end else ; // Neexistuj�ci doklad
    end;
  end else ; // Neexistuj�ci tovar
end;

procedure TMcf.ModItm(pDocNum:Str12;pItmNum:word;pGsQnt,pHprice,pBprice:double;pHpcSrc:Str3);
var mBokNum:Str5;  mSav:TSavClc;  mDValue,mHValue,mAValue,mBValue:double;
begin
  mBokNum:=BookNumFromDocNum(pDocNum);
  oDat.oDod.oMcd.OpenMCI;
  If pItmNum>0 then begin
    With oDat.oDod.oMcd do begin
      If ohMCH.DocNum<>pDocNum then ohMCH.LocateDocNum(pDocNum);
      If ohMCH.DocNum=pDocNum then begin
        If ohMCI.LocateDoIt(pDocNum,pItmNum) then begin
          If IsNotNul(pGsQnt) then begin
            If not Eq3(pGsQnt,ohMCI.GsQnt) then begin
              mSav:=TSavClc.Create;
              mSav.GsQnt:=pGsQnt;
              mSav.VatPrc:=ohMCI.VatPrc;
              mSav.DscPrc:=gPlc.ClcDscPrc(pHprice,pBprice);
              mSav.FgBValue:=pBPrice*pGsQnt;
              // Zapam�t�me p�vodn� hodnoy polo�ky
              mDValue:=ohMCI.FgDValue;
              mAValue:=ohMCI.FgAValue;
              mBValue:=ohMCI.FgBValue;
              // Ulo��me zmenen� polo�ky
              ohMCI.Edit;
              ohMCI.GsQnt:=pGsQnt;
              ohMCI.DscPrc:=mSav.DscPrc;
              ohMCI.FgBPrice:=mSav.FgBPrice;
              ohMCI.FgDValue:=mSav.FgDValue;
              ohMCI.FgAValue:=mSav.FgAValue;
              ohMCI.FgBValue:=mSav.FgBValue;
              ohMCI.Post;
              FreeAndNil(mSav);
            end;
          end else ohMCI.Delete;
          ohMCH.Clc(ohMCI);
        end else ;  // Neexistuj�ca plo�ka
      end else ; // Neexistuj�ci doklad
    end; // Neexistuj�ci tovar
  end;
end;

end.
