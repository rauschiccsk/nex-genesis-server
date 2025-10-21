unit Ocf;
{$F+}
// *****************************************************************************
// **********             FUNKCIE NA PR¡CU SO Z¡KAZKAMI               **********
// *****************************************************************************
interface

uses
  IcTypes, IcConv, IcTools, IcVariab, IniFiles, IcDate, SysUtils, NexGlob, DocHand,
  NexPath, NexIni, Key, Dat, Stf, Plc, SavClc, Forms;

type
  TTof=class
    constructor Create(pDat:TDat;pStf:TStf);
    destructor Destroy; override;
    private
      oDat:TDat;
      oStf:TStf;
      function NewItmNum(pDocNum:Str12;pFreItm:boolean):word; // »Ìslo novej poloûky - pEndNum=TRIE - na konci dokladu v opaËnom prÌpade hæad· vynechanÈ ËÌsla
    public
      procedure NewDoc(pTrmNum,pPaCode:longint;pPaName:Str30);  // VytvorÈ nov˝ doklad
      procedure ClsDoc(pDocNum:Str12);  // UkncËÌ doklad
      procedure EcdGen(pDocNum:Str12);  // Vygeneruje a uloûÌ doklad pre fiök·lny server

      procedure AddItm(pDocNum:Str12;pItmNum:word;pGsCode:longint;pGsQnt,pHprice,pBprice:double;pHpcSrc:Str3);
      procedure ModItm(pDocNum:Str12;pItmNum:word;pGsQnt,pHprice,pBprice:double;pHpcSrc:Str3);
    published
  end;

implementation

uses bTOH, Gsd;

constructor TTof.Create(pDat:TDat;pStf:TStf);
begin
  oDat:=pDat;
  oStf:=pStf;
end;

destructor TTof.Destroy;
begin
end;

// ********************************* PRIVATE ***********************************

function TTof.NewItmNum(pDocNum:Str12;pFreItm:boolean):word;
var mItmNum:word;  mFind:boolean;
begin
  Result:=0;
  With oDat.oDod.oTod do begin
    If pFreItm then begin  // Hæad· vynechanÈ poradovÈ ËÌsla
      ohTOI.SwapIndex;
      If ohTOI.LocateDoIt(pDocNum,1) then begin
        mItmNum:=0;
        Repeat
          Inc(mItmNum);
          mFind:=mItmNum<ohTOI.ItmNum;
          If mItmNum>ohTOI.ItmNum then mItmNum:=ohTOI.ItmNum;
          ohTOI.Next;
        until Eof or mFind or (ohTOI.DocNum<>pDocNum);
        If mFind
          then Result:=mItmNum
          else Result:=mItmNum+1;
      end
      else Result:=1;
      ohTOI.RestoreIndex;
    end else begin // Vygeneruje novÈ ËÌslo na konci dokladu
      If not ohTOI.NearestDoIt(pDocNum,65000) then ohTOI.Last;
      If not ohTOI.IsLastRec or (ohTOI.DocNum<>pDocNum) then ohTOI.Prior;
      If ohTOI.DocNum=pDocNum
        then Result:=ohTOI.ItmNum+1
        else Result:=1;
    end;
  end;
end;

// ********************************** PUBLIC ***********************************
procedure TTof.NewDoc(pTrmNum,pPaCode:longint;pPaName:Str30);
var mSerNum:word;  mDocNum:Str12;
begin
  With oDat.oDod.oTod do begin
    mSerNum:=ohTOH.NextSerNum; // Ak nie je zadane poradove cislo OD vygenerujeme nasledujuce
    mDocNum:=ohTOH.GenDocNum(SysYear,mSerNum);
    If not ohTOH.LocateDocNum(mDocNum) then begin // Ak neexistuje vyvorime hlacicku dokladu OD
      ohTOH.Insert;
      ohTOH.TrmNum:=pTrmNum;
      ohTOH.SerNum:=mSerNum;
      ohTOH.DocNum:=mDocNum;
      ohTOH.DocDate:=Date;
      ohTOH.PaCode:=pPaCode;
      ohTOH.PaName:=pPaName;
      ohTOH.WriNum:=gKey.TobWriNum[ohTOH.BtrTable.BookNum];
      ohTOH.StkNum:=gKey.TobStkNum[ohTOH.BtrTable.BookNum];
      If pPaCode=0
        then ohTOH.PlsNum:=1
        else ohTOH.PlsNum:=2;
      ohTOH.Status:='O';
      ohTOH.Post;
    end;
  end;
end;

procedure TTof.ClsDoc(pDocNum:Str12);  // UkncËÌ doklad
begin
  With oDat.oDod.oTod do begin
    If ohTOH.DocNum<>pDocNum then ohTOH.LocateDocNum(pDocNum);
    If ohTOH.DocNum=pDocNum then begin
      ohTOH.Edit;
      ohTOH.Status:='E';
      ohTOH.Post;
    end;
  end;
end;

procedure TTof.EcdGen(pDocNum:Str12);  // Vygeneruje a uloûÌ doklad pre fiök·lny server
begin
  With oDat.oDod.oTod do begin
    If ohTOH.DocNum<>pDocNum then ohTOH.LocateDocNum(pDocNum);
    If ohTOH.DocNum=pDocNum then begin

    end;
  end;
end;

procedure TTof.AddItm(pDocNum:Str12;pItmNum:word;pGsCode:longint;pGsQnt,pHprice,pBprice:double;pHpcSrc:Str3);
var mBokNum:Str5;  mSav:TSavClc;
begin
  mBokNum:=BookNumFromDocNum(pDocNum);
  oDat.oDod.oTod.OpenTOI;
  If pItmNum=0 then pItmNum:=NewItmNum(pDocNum,FALSE);
  If oDat.oGsd.GsCode<>pGsCode then oDat.oGsd.LocGsCode(pGsCode);
  If oDat.oGsd.GsCode=pGsCode then begin
    With oDat.oDod.oTod do begin
      If ohTOH.DocNum<>pDocNum then ohTOH.LocateDocNum(pDocNum);
      If ohTOH.DocNum=pDocNum then begin
        mSav:=TSavClc.Create;
        mSav.GsQnt:=pGsQnt;
        mSav.VatPrc:=oDat.oGsd.ohGSC.VatPrc;
        mSav.DscPrc:=gPlc.ClcDscPrc(pHprice,pBprice);
        mSav.FgBValue:=pBPrice*pGsQnt;
        ohTOI.Insert;
        BTR_To_BTR(oDat.oGsd.ohGSC.BtrTable,ohTOI.BtrTable);
        ohTOI.DocNum:=pDocNum;
        ohTOI.ItmNum:=pItmNum;
        ohTOI.WriNum:=ohTOH.WriNum;
        ohTOI.StkNum:=ohTOH.StkNum;
        ohTOI.PaCode:=ohTOH.PaCode;
        ohTOI.DocDate:=ohTOH.DocDate;
        ohTOI.GsQnt:=pGsQnt;
        ohTOI.DscPrc:=mSav.DscPrc;
        ohTOI.HPrice:=mSav.FgHPrice;
        ohTOI.BPrice:=mSav.FgBPrice;
        ohTOI.DValue:=mSav.FgDValue;
        ohTOI.HValue:=mSav.FgHValue;
        ohTOI.AValue:=mSav.FgAValue;
        ohTOI.BValue:=mSav.FgBValue;
        ohTOI.PrcDst:=pHpcSrc;
        ohTOI.Post;
        // ZapÌöeme ˙daje do hlaviËky dokladu
        ohTOH.Edit;
        ohTOH.DValue:=ohTOH.DValue+ohTOI.DValue;
        ohTOH.HValue:=ohTOH.HValue+ohTOI.HValue;
        ohTOH.AValue:=ohTOH.AValue+ohTOI.AValue;
        ohTOH.BValue:=ohTOH.BValue+ohTOI.BValue;
        ohTOH.ItmQnt:=ohTOH.ItmQnt+1;
        ohTOH.Post;
        FreeAndNil(mSav);
        oStf.AddSts(ohTOH.StkNum,pGsCode,pGsQnt,ohTOH.DocNum,ohTOI.ItmNum); // Zarezervovaù poloûku na sklade
      end else ; // Neexistuj˙ci doklad
    end;
  end else ; // Neexistuj˙ci tovar
end;

procedure TTof.ModItm(pDocNum:Str12;pItmNum:word;pGsQnt,pHprice,pBprice:double;pHpcSrc:Str3);
var mBokNum:Str5;  mSav:TSavClc;  mDValue,mHValue,mAValue,mBValue:double;
begin
  mBokNum:=BookNumFromDocNum(pDocNum);
  oDat.oDod.oTod.OpenTOI;
  If pItmNum>0 then begin
    With oDat.oDod.oTod do begin
      If ohTOH.DocNum<>pDocNum then ohTOH.LocateDocNum(pDocNum);
      If ohTOH.DocNum=pDocNum then begin
        If ohTOI.LocateDoIt(pDocNum,pItmNum) then begin
          oStf.AddSts(ohTOH.StkNum,ohTOI.GsCode,pGsQnt,ohTOH.DocNum,ohTOI.ItmNum); // Zarezervovaù poloûku na sklade
          If IsNotNul(pGsQnt) then begin
            If not Eq3(pGsQnt,ohTOI.GsQnt) then begin
              mSav:=TSavClc.Create;
              mSav.GsQnt:=pGsQnt;
              mSav.VatPrc:=ohTOI.VatPrc;
              mSav.DscPrc:=gPlc.ClcDscPrc(pHprice,pBprice);
              mSav.FgBValue:=pBPrice*pGsQnt;
              // Zapam‰t·me pÙvodnÈ hodnoy poloûky
              mDValue:=ohTOI.DValue;
              mHValue:=ohTOI.HValue;
              mAValue:=ohTOI.AValue;
              mBValue:=ohTOI.BValue;
              // UloûÌme zmany poloûky
              ohTOI.Edit;
              ohTOI.GsQnt:=pGsQnt;
              ohTOI.DscPrc:=mSav.DscPrc;
              ohTOI.HPrice:=mSav.FgHPrice;
              ohTOI.BPrice:=mSav.FgBPrice;
              ohTOI.DValue:=mSav.FgDValue;
              ohTOI.HValue:=mSav.FgHValue;
              ohTOI.AValue:=mSav.FgAValue;
              ohTOI.BValue:=mSav.FgBValue;
              ohTOI.PrcDst:=pHpcSrc;
              ohTOI.Post;
              // ZapÌöeme zmwny do hlaviËky dokladu
              ohTOH.Edit;
              ohTOH.DValue:=ohTOH.DValue-mDValue+ohTOI.DValue;
              ohTOH.HValue:=ohTOH.HValue-mHValue+ohTOI.HValue;
              ohTOH.AValue:=ohTOH.AValue-mAValue+ohTOI.AValue;
              ohTOH.BValue:=ohTOH.BValue-mBValue+ohTOI.BValue;
              ohTOH.Post;
              FreeAndNil(mSav);
            end;
          end else begin
            // OdpoËÌtame poloûku z hlaviËky dokladu
            ohTOH.Edit;
            ohTOH.DValue:=ohTOH.DValue-ohTOI.DValue;
            ohTOH.HValue:=ohTOH.HValue-ohTOI.HValue;
            ohTOH.AValue:=ohTOH.AValue-ohTOI.AValue;
            ohTOH.BValue:=ohTOH.BValue-ohTOI.BValue;
            ohTOH.ItmQnt:=ohTOH.ItmQnt-1;
            ohTOH.Post;
            ohTOI.Delete;
          end;
        end else ;  // Neexistuj˙ca ploûka
      end else ; // Neexistuj˙ci doklad
    end; // Neexistuj˙ci tovar
  end;
end;

end.
