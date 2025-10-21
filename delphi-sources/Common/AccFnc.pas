unit AccFnc;
// =============================================================================
//                        FUNKCIE PODVOJN…HO ⁄»TOVNÕCTVA
// -----------------------------------------------------------------------------
// AccAnlCom - Hodnota funkcie je analytick˝ ˙Ëet, ktor˝ je kompletizovan˝ podæa
//             zadan˝ch parametrov:
//             õ pAccMas - maska (ako m· vyzareù analytick˝ ˙Ëet)
//             õ pAccVar - premenn· (napr. v-DPH,p-kÛd partnera a pod.)
//             õ pAccVal - hodnota, ktor· bude dosaden· na miesto premennej
// -----------------------------------------------------------------------------
// ************************* POUéIT… DATAB¡ZOV… S⁄BORY *************************
// -----------------------------------------------------------------------------
// ACCSNT.BTR - ⁄Ëtovn· osnova syntetick˝ch ˙Ëtov
// ACCANL.BTR - ⁄Ëtovn· osnova analytick˝ch ˙Ëtov
// ACCJRN.BTR - DennÌk ˙Ëtovn˝ch z·pisov
// ACCLDG.BTR - Hlavn· kniha ˙Ëtov
// -----------------------------------------------------------------------------
// *********************** POPIS PRIVATE FUNKCIÕ OBJEKTU ***********************
// -----------------------------------------------------------------------------
// -----------------------------------------------------------------------------
// ************************ POPIS PUBLIC FUNKCIÕ OBJEKTU ***********************
// CrtAccDat - VytvorÌ predkontaËn˝ predpis podæa predvolen˝ch nastaveniach:
//             1. Najvyööiu prioritu m· zadn˝ ˙Ëet na riadku fakt˙ry.
//             2. Potom nasleduje ˙Ëet, ktor˝ je zadan˝ v produktovom katalÛgu.
//             3. Potom nasleduje ˙Ëet, ktor˝ je zadan˝ vo vlastnostiach knihy,
//                kde je evidovan· fakt˙ra.
//             4. Posledn˝ v prioritnom zozname s˙ ˙Ëtu zadanÈ vo vöeobecn˝ch
//                predvolen˝ch nastaveniach podvojnÈho ˙ËtovnÌctva.
//             Popis parametrov funkcie:
//             õ pAccSnt - syntetick· Ëasù ˙Ëtu, ktor· je evidovan· v riadku FA
//             õ pAccAnl - analityck· Ëasù ˙Ëtu, ktor· je evidovan· v riadku FA
//             õ pProNum - produktovÈ ËÌslo (PLU) poloûky fakt˙ry
//             õ pParNum - registraËnÈ ËÌslo firmy na ktor˙ je vystaven· fakt˙ra
//             õ pDocTyp - typ dokladu (OF alebo DF)
//             õ pBokNum - ËÌslo knihy, v ktorej je evidovan· fakt˙ra
// -----------------------------------------------------------------------------
// -----------------------------------------------------------------------------
// ********************************* POZN¡MKY **********************************
// -----------------------------------------------------------------------------
// õ Acm_F      - ⁄ËtovnÈ dennÌky
// õ Acm_AccSnt - SyntetickÈ ˙Ëtu
// õ Acm_AccAnl - AnalytickÈ ˙Ëty
// õ Acm_AccJrn - ⁄ËtovnÈ z·znamy
// õ Acm_AccLdg - Hlavn· kniha
// õ Acm_AccDoc - Za˙Ëtovanie dokladu - Bsm_DocAcc 
// -----------------------------------------------------------------------------
// ****************************** HIST”RIA ZMIEN *******************************
// -----------------------------------------------------------------------------
// 21.04[28.02.2019] - Nov· funkcia (RZ)
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
    If oAccSnt='' then begin // Hæad·me predkont·ciu v katolÛgu produktov
      If ohPROCAT.LocProNum(pProNum) then begin
        oAccSnt:=ohPROCAT.IciSnt;
        oAccAnl:=ohPROCAT.IciAnl;
        If oAccSnt='' then begin // NastavÌme predvolan˙ predkont·ciu vlastnosti fakturaËnej knihy
          If ohPROCAT.ProTyp='S' then begin // Je to sluûba
            oAccSnt:=gKey.IcbSecSnt[pBokNum];
            oAccAnl:=gKey.IcbSecAnl[pBokNum];
            If oAccSnt='' then begin // NastavÌme predvolan˙ predkont·ciu podæa glob·lnych parametrov ˙ËtovnÌctva
              oAccSnt:=gPrp.Acc.IcsSnt;
              oAccAnl:=gPrp.Acc.IcsAnl;
            end;
          end else begin // OstatnÈ prÌpady zatiaæ povaûujeme za tovar, neskÙr keÔ mater·l bude zabudvan˝ oöetrÌme aj ten prÌpad
            oAccSnt:=gKey.IcbGscSnt[pBokNum];
            oAccAnl:=gKey.IcbGscAnl[pBokNum];
            If oAccSnt='' then begin // NastavÌme predvolan˙ predkont·ciu podæa glob·lnych parametrov ˙ËtovnÌctva
              oAccSnt:=gPrp.Acc.IcgSnt;
              oAccAnl:=gPrp.Acc.IcgAnl;
            end;
          end;
        end;
      end;
    end;
    If oAccSnt='' then begin // NastavÌme predvolan˙ predkont·ciu na tovar
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
  If Pos(pAccAnl,'p')>0 then begin // Analitick· Ëasù ˙Ëtu obshuje kÛd firmy
    mParNum:=StrInt(oParNum,0);
    If Length(mParNum)<=gPrp.Acc.AnlChr then pAccAnl:=StrIntZero(oParNum,gPrp.Acc.AnlChr); // Len vtedy ak za smestÌ kÛd firmy do analytiky
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


