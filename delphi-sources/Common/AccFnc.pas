unit AccFnc;
// =============================================================================
//                        FUNKCIE PODVOJN�HO ��TOVN�CTVA
// -----------------------------------------------------------------------------
// AccAnlCom - Hodnota funkcie je analytick� ��et, ktor� je kompletizovan� pod�a
//             zadan�ch parametrov:
//             � pAccMas - maska (ako m� vyzare� analytick� ��et)
//             � pAccVar - premenn� (napr. v-DPH,p-k�d partnera a pod.)
//             � pAccVal - hodnota, ktor� bude dosaden� na miesto premennej
// -----------------------------------------------------------------------------
// ************************* POU�IT� DATAB�ZOV� S�BORY *************************
// -----------------------------------------------------------------------------
// ACCSNT.BTR - ��tovn� osnova syntetick�ch ��tov
// ACCANL.BTR - ��tovn� osnova analytick�ch ��tov
// ACCJRN.BTR - Denn�k ��tovn�ch z�pisov
// ACCLDG.BTR - Hlavn� kniha ��tov
// -----------------------------------------------------------------------------
// *********************** POPIS PRIVATE FUNKCI� OBJEKTU ***********************
// -----------------------------------------------------------------------------
// -----------------------------------------------------------------------------
// ************************ POPIS PUBLIC FUNKCI� OBJEKTU ***********************
// CrtAccDat - Vytvor� predkonta�n� predpis pod�a predvolen�ch nastaveniach:
//             1. Najvy��iu prioritu m� zadn� ��et na riadku fakt�ry.
//             2. Potom nasleduje ��et, ktor� je zadan� v produktovom katal�gu.
//             3. Potom nasleduje ��et, ktor� je zadan� vo vlastnostiach knihy,
//                kde je evidovan� fakt�ra.
//             4. Posledn� v prioritnom zozname s� ��tu zadan� vo v�eobecn�ch
//                predvolen�ch nastaveniach podvojn�ho ��tovn�ctva.
//             Popis parametrov funkcie:
//             � pAccSnt - syntetick� �as� ��tu, ktor� je evidovan� v riadku FA
//             � pAccAnl - analityck� �as� ��tu, ktor� je evidovan� v riadku FA
//             � pProNum - produktov� ��slo (PLU) polo�ky fakt�ry
//             � pParNum - registra�n� ��slo firmy na ktor� je vystaven� fakt�ra
//             � pDocTyp - typ dokladu (OF alebo DF)
//             � pBokNum - ��slo knihy, v ktorej je evidovan� fakt�ra
// -----------------------------------------------------------------------------
// -----------------------------------------------------------------------------
// ********************************* POZN�MKY **********************************
// -----------------------------------------------------------------------------
// � Acm_F      - ��tovn� denn�ky
// � Acm_AccSnt - Syntetick� ��tu
// � Acm_AccAnl - Analytick� ��ty
// � Acm_AccJrn - ��tovn� z�znamy
// � Acm_AccLdg - Hlavn� kniha
// � Acm_AccDoc - Za��tovanie dokladu - Bsm_DocAcc 
// -----------------------------------------------------------------------------
// ****************************** HIST�RIA ZMIEN *******************************
// -----------------------------------------------------------------------------
// 21.04[28.02.2019] - Nov� funkcia (RZ)
// =============================================================================

interface

uses
  IcTypes, IcConv, IcVariab, IcTools, IcDate, Key, Prp, BasFnc, UsrFnc, hPROCAT, hPARCAT, eACCSNT, eACCANL, eACCJRN,
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Dialogs, Forms, DateUtils;

type
  TAccFnc=class
    constructor Create;
    destructor Destroy; override;
  private
    oDocNum:Str12;
    oExtNum:Str12;
    oDocDte:TDate;
    oWriNum:word;
    oEcuNum:word;
    oStkNum:word;
    oSmcNum:word;
    oParNum:longint;
    oSpaNum:longint;
    oConDoc:Str12;
    oDocCrs:double;
    oDocFgv:double;
    oDocDvz:Str3;
    oBegRec:byte;
    oAccSnt:Str3;
    oAccAnl:Str6;
  public
    ohPROCAT:TProcatHnd;
    ohPARCAT:TParcatHnd;
    ohACCSNT:TAccsntHne;
    ohACCANL:TAccanlHne;
    oxACCJRN:TAccjrnHne;
    ohACCJRN:TAccjrnHne;
    procedure CrtAccDat(pAccSnt:Str3;pAccAnl:Str6;pProNum,pParNum:longint;pDocTyp:Str2;pBokNum:Str5);
    procedure DelDocAcc(pDocNum:Str12);
    procedure AddAccRec(pItmNum:word;pAccSnt:Str3;pAccAnl:Str6;pDocDes:Str60;pCrdAcv,pDebAcv:double);
  published
    property DocNum:Str12 write oDocNum;
    property ExtNum:Str12 write oExtNum;
    property DocDte:TDate write oDocDte;
    property WriNum:word write oWriNum;
    property EcuNum:word write oEcuNum;
    property StkNum:word write oStkNum;
    property SmcNum:word write oSmcNum;
    property ParNum:longint write oParNum;
    property SpaNum:longint write oSpaNum;
    property ConDoc:Str12 write oConDoc;
    property DocCrs:double write oDocCrs;
    property DocFgv:double write oDocFgv;
    property DocDvz:Str3 write oDocDvz;
    property BegRec:byte write oBegRec;

    property AccSnt:Str3 read oAccSnt;
    property AccAnl:Str6 read oAccAnl;
  end;

  function AccAnlCom(pAnlMas:Str6;pAccVar:Str1;pAccVal:longint):Str6;

implementation

// ********************************** GLOBAL ***********************************

function AccAnlCom(pAnlMas:Str6;pAccVar:Str1;pAccVal:longint):Str6;
var mBegPos,mVarLen,I:byte; mVarDat:Str6;
begin
  Result:=pAnlMas;
  mBegPos:=Pos(pAccVar,pAnlMas);
  If mBegPos>0 then begin
    mVarLen:=0;
    For I:=mBegPos to Length(pAnlMas) do
      If UpChar(pAnlMas[I])=UpChar(pAccVar[1]) then Inc(mVarLen);
    Delete(pAnlMas,mBegPos,mVarLen);
    mVarDat:=StrIntZero(pAccVal,mVarLen);
    Insert(mVarDat,pAnlMas,mBegPos);
    Result:=pAnlMas;
  end;
end;

// ********************************** OBJECT ***********************************

constructor TAccFnc.Create;
begin
  ohPROCAT:=TProcatHnd.Create;
  ohPARCAT:=TParcatHnd.Create;
  ohACCSNT:=TAccsntHne.Create;
  ohACCANL:=TAccanlHne.Create;
  oxACCJRN:=TAccjrnHne.Create;
  ohACCJRN:=TAccjrnHne.Create;
end;

destructor TAccFnc.Destroy;
begin
  FreeAndNil(ohPROCAT);
  FreeAndNil(ohPARCAT);
  FreeAndNil(ohACCJRN);
  FreeAndNil(oxACCJRN);
  FreeAndNil(ohACCANL);
  FreeAndNil(ohACCSNT);
end;

// ******************************** PUBLIC *************************************

procedure TAccFnc.CrtAccDat(pAccSnt:Str3;pAccAnl:Str6;pProNum,pParNum:longint;pDocTyp:Str2;pBokNum:Str5);
begin
  If pDocTyp='OF' then begin
    oAccSnt:=pAccSnt;
    oAccAnl:=pAccAnl;
    If oAccSnt='' then begin // H�ad�me predkont�ciu v katol�gu produktov
      If ohPROCAT.LocProNum(pProNum) then begin
        oAccSnt:=ohPROCAT.IciSnt;
        oAccAnl:=ohPROCAT.IciAnl;
        If oAccSnt='' then begin // Nastav�me predvolan� predkont�ciu vlastnosti faktura�nej knihy
          If ohPROCAT.ProTyp='S' then begin // Je to slu�ba
            oAccSnt:=gKey.IcbSecSnt[pBokNum];
            oAccAnl:=gKey.IcbSecAnl[pBokNum];
            If oAccSnt='' then begin // Nastav�me predvolan� predkont�ciu pod�a glob�lnych parametrov ��tovn�ctva
              oAccSnt:=gPrp.Acc.IcsSnt;
              oAccAnl:=gPrp.Acc.IcsAnl;
            end;
          end else begin // Ostatn� pr�pady zatia� pova�ujeme za tovar, nesk�r ke� mater�l bude zabudvan� o�etr�me aj ten pr�pad
            oAccSnt:=gKey.IcbGscSnt[pBokNum];
            oAccAnl:=gKey.IcbGscAnl[pBokNum];
            If oAccSnt='' then begin // Nastav�me predvolan� predkont�ciu pod�a glob�lnych parametrov ��tovn�ctva
              oAccSnt:=gPrp.Acc.IcgSnt;
              oAccAnl:=gPrp.Acc.IcgAnl;
            end;
          end;
        end;
      end;
    end;
    If oAccSnt='' then begin // Nastav�me predvolan� predkont�ciu na tovar
      oAccSnt:='604';
      oAccAnl:=StrIntZero(100,gPrp.Acc.AnlChr);
    end;
  end;
end;

procedure TAccFnc.DelDocAcc(pDocNum:Str12);
begin
  While ohACCJRN.LocDocNum(pDocNum) do ohACCJRN.Delete;
end;

procedure TAccFnc.AddAccRec(pItmNum:word;pAccSnt:Str3;pAccAnl:Str6;pDocDes:Str60;pCrdAcv,pDebAcv:double);
var mParNum:Str6;
begin
  If Pos(pAccAnl,'p')>0 then begin // Analitick� �as� ��tu obshuje k�d firmy
    mParNum:=StrInt(oParNum,0);
    If Length(mParNum)<=gPrp.Acc.AnlChr then pAccAnl:=StrIntZero(oParNum,gPrp.Acc.AnlChr); // Len vtedy ak za smest� k�d firmy do analytiky
  end;
  ohACCJRN.Insert;
  ohACCJRN.DocNum:=oDocNum;
  ohACCJRN.ItmNum:=pItmNum;
  ohACCJRN.ExtNum:=oExtNum;
  ohACCJRN.DocDte:=oDocDte;
  ohACCJRN.WriNum:=oWriNum;
  ohACCJRN.EcuNum:=oEcuNum;
  ohACCJRN.StkNum:=oStkNum;
  ohACCJRN.SmcNum:=oSmcNum;
  ohACCJRN.ParNum:=oParNum;
  ohACCJRN.SpaNum:=oSpaNum;
  ohACCJRN.AccSnt:=pAccSnt;
  ohACCJRN.AccAnl:=pAccAnl;
  ohACCJRN.DocDes:=pDocDes;
  ohACCJRN.CrdAcv:=Rd2(pCrdAcv);
  ohACCJRN.DebAcv:=Rd2(pDebAcv);
  ohACCJRN.ConDoc:=oConDoc;
  If oDocCrs<>1 then begin
    //ohACCJRN.DocDvz:=oDocDvz;
    ohACCJRN.DocCrs:=oDocCrs;
    ohACCJRN.DocFgv:=Rd2(oDocFgv);
  end;
  ohACCJRN.BegRec:=oBegRec;
  ohACCJRN.CrtUsr:=gUsr.UsrLog;
  ohACCJRN.CrtDte:=Date;
  ohACCJRN.CrtTim:=Time;
  ohACCJRN.Post;
end;

// ******************************** PRIVATE ************************************

end.


