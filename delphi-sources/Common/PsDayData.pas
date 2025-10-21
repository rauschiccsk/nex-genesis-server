unit PsDayData;

interface

uses
  IcTypes, IcDate, IcConv, IcTools, TxtCut, TxtWrap, NexGlob, NexPath, NexIni,
  ComCtrls, Classes, SysUtils;

type
  TPsDayData  = class
      constructor Create; virtual;
      destructor Destroy; override;
    private
      oCut: TTxtCut;
      oWrap: TTxtWrap;
      oFileName: ShortString; // Cesta a nazov suboru
      oFile: TStrings;
      oEof: boolean; // Je TRUE ak uz dalej nie su dalsie tovarove polozky
      // Udaje tovarovej o polozke
      oItmNum:word;     // Poradove cislo polozky na pokladnicnom doklade
      oSalTime:Str8;    // Cas predaja tovarovej polozky
      oSalHour:byte;    // Hodina predaja tovarovej polozky
      oIntNum:longint;  // Interné èíslovanie jednotilivých dokladov poèas naèítania
      oBlkNum:longint;  // Danove cislo pokladnicneho dokladu
      oBlkVal: double;  // Hodnota dokladu z hlavicky
      oSerNum:longint;  // Chronologicke poradove cislo pokladnicneho dokladu
      oIntBlkNum:longint;  // Interne cislo pokladnicneho dokladu
      oLgnName:Str8;    // prihlasovacie meno pokladnika
      oUsrName:Str30;   // Celé meno pokladnika
      oCusCard:Str20;   // Identifikacny kod zakaznickej karty
      oRegIno:Str15;    // ICO zakaznika
      oPaCode:longint;  // Kod zakaznika
      oPaName:Str30;    // Meno zakaznika
      oCrdName:Str30;   // Meno majitela zakaznickej karty
      oSrcDoc:Str12;    // zdrojovy doklad
      oBlkType:Str2;    // Typ dokladu

      // Globalne udaje pokladnicneho predaja
      oCValue: TValue3; // Hodnota predaja v NC bez DPH
      oAValue: TValue3; // Hodnota predaja v PC bez DPH
      oBValue: TValue3; // Hodnota predaja v PC s DPH
      oVatVal: TValue3; // Hodnota DPH z PC
      oBegVal: TValue9; // Pociatocne stavy podla paltidiel
      oTrnVal: TValue9; // Trzba podla platidiel
      oIncVal: double;  // Prijem hotovosti do pokladne
      oExpVal: TValue9; // Vydaj z pokladne podla platidiel
      oInvVal: TValue9; // Hotovostne uhrady OFA
      oChoVal: TValue9; // Vydaj na zmenu platidla
      oChiVal: TValue9; // Prijem zo zmeny platidla
      oPayName: array [0..9] of Str20;  // Názov platieb
      oClaim: double;   // Refundacia tovaru - reklamacia
      oNegVal: double;  // Hodnota zapornych poloziek
      oDscVal: double;  // Hodnota zliav
      oFirstBlk: longint; // Interne cislo prveho pokladnicneho dokladu
      oLastBlk: longint;  // Interne cislo posledneho pokladnicneho dokladu
      oGsDocCount: longint; // Pocet dokladov pkladnicneho predaja(zakaznikov)
      oGsItmCount: longint; // Pocitadlo tovarovych poloziek
      oDClsVal: double;  // Trzba s DPH z dennej uzavierky
      oDClsVat: double;  // Hodnota DPH z dennej uzavierky
      oDClsValA: array[1..5] of double;  // Trzba s DPH z dennej uzavierky podla sazdieb
      oDClsVatA: array[1..5] of double;  // Hodnota DPH z dennej uzavierky podla sazdieb
      oActItm: integer;  // Aktualna pozicia v textovom subore kde sa nachadza tovarova polozka
      oRetVal:double;
      oVer:double;  // Verzia pokladne
    public
      oItems: TStrings;
      oBlkPayVal: double;  // Prijem hotovosti do pokladne
      oBlkSumVal: double;  // Prijem hotovosti do pokladne
      oBlkItmVal: double;  // Prijem hotovosti do pokladne
      oBlkStvVal: double;  //

      function ReadFile(pCasNum:word; pSalDate: TDateTime):boolean; // Nacita udaje T suboru. Ak subor neexistuje hodnota funkcie je FALSE
      procedure SaveFile; // Nacita udaje T suboru. Ak subor neexistuje hodnota funkcie je FALSE
      procedure Clear; // Procedure vynuluje interne premenne
      procedure First; // Nastavi ukazovatel textoveho suboru na prvy riadok
      function Next: boolean; // Nastavy ukazovatel na nasledujucu tovarovu polozku, ak existuje hodnota funkcie je TRUE
      function NextDoc: boolean; // Nastavy ukazovatel na nasledujucu hlavicku uctenky, ak existuje hodnota funkcie je TRUE
      function NextFullDoc: boolean; // Nastavy ukazovatel na nasledujucu paticku uctenky, ak existuje hodnota funkcie je TRUE
      function Eof: boolean; // Hodnota funkcie je TRUE ak uz dalej nie su dalsie tovarove polozky

      // Ukladanie udajov
      procedure SetMgCode(pMgCode:longint); // Tovarova skupina

      // Udaje tovarovej o polozke
      procedure ReadGlobData; // Procedura nacita globalne udaje predaja do pamatovych premennych
      function GetItmNum: word;    // Poradove cislo polozky na pokladnicnom doklade
      function GetSalTime: Str8;   // Cas predaja tovarovej polozky
      function GetSalHour: byte;   // Cele hodiny predaja tovarovej polozky
      function GetBlkNum: longint; // Danove cislo pokladnicneho dokladu
      function GetBlkVal: double;  // Hodnota dokladu z hlavicky
      function GetIntBlkNum: longint; // Interne cislo pokladnicneho dokladu
      function GetSerNum: longint; // Chronologicke poradove cislo pokladnicneho dokladu
      function GetGsCode: longint; // Tovarove cislo
      function GetGsName: Str30;   // Nazov tovaru
      function GetMgCode: longint; // Tovarova skupina
      function GetBarCode: Str15;  // Identifikacny kod tovaru
      function GetStkCode: Str15;  // Skladový kod tovaru TIBI 23.03.2015
      function GetGsQnt: double;   // Mnozstvo predaneho tovaru
      function GetVatPrc: double;  // Sadzba DPH
      function GetDscPrc: double;  // Percentualna sadzba zlavy
      function GetProfPrc: double; // Percentualna sadzba zisku
      function GetStkNum: longint; // Sklad odkial sa odpocita tovar
      function GetProdNum: Str20;  // Vyrobne cislo tovaru
      function GetDscType: Str1;   // Typ poskytnutej zlavy
      function GetDscGrp: byte;    // Skupina zlavy - cislo tocenia KS(pre MF)
      function GetIDscVal: double; // Hodnota zlavy z PC s DPH
      function GetICValue: double; // Hodnota tovaru v NC bez DPH
      function GetIBPrice: double; // PC s DPH
      function GetIAValue: double; // Hodnota tovaru v PC bez DPH
      function GetIBValue: double; // Hodnota tovaru v PC s DPH
      function GetLgnName: Str8;   // Prihlasovacie meno pokladnicky
      function GetUsrName: Str30;  // Cele meno pokladnicky
      function GetCusCard: Str20;  // Cislo identifikacnej karty zakaznika
      function GetRegIno: Str15;   // ICO zakaznika
      function GetPaName: Str30;   // Meno zakaznika
      function GetPaCode: longint; // Kod zakaznika
      function GetCrdName:Str30;   // Meno majitela zakaznickej karty
      function GetSrcDoc: Str12;   // zdrojovy doklad

      // Globalne udaje pokladnicneho predaja
      function GetCValue(pIndex:byte): double;
      function GetAValue(pIndex:byte): double;
      function GetBValue(pIndex:byte): double;
      function GetVatVal(pIndex:byte): double;
      function GetBegVal(pIndex:byte): double;
      function GetTrnVal(pIndex:byte): double;
      function GetExpVal(pIndex:byte): double;
      function GetInvVal(pIndex:byte): double;
      function GetChiVal(pIndex:byte): double;
      function GetChoVal(pIndex:byte): double;
      function GetPayName(pIndex:byte): Str20;
      function GetClaim: double;
      function GetNegVal: double;
      function GetDscVal: double;
      function GetIncVal: double;
      function GetFirstBlk: longint;
      function GetLastBlk: longint;
      function GetGsDocCount: longint;
      function GetGsItmCount: longint;

      function GetDClsVal: double;
      function GetDClsVat: double;
      function GetDClsValA(pVatGrp:byte): double;
      function GetDClsVatA(pVatGrp:byte): double;
    published
      property GsDocCount:longint read oGsDocCount;
      property GsItmCount:longint read oGsItmCount;
      property BlkType:Str2 read oBlkType;

      property IntNum:longint read oIntNum;
  end;


implementation

constructor TPsDayData.Create;
begin
  inherited;
  oFile:=TStringList.Create;
  oItems:=TStringList.Create;
  oCut:=TTxtCut.Create;
  oWrap:=TTxtWrap.Create;
  oVer:= 16; // Verzia suboru
end;

destructor TPsDayData.Destroy;
begin
  oCut.Free;
  oWrap.Free;
  oFile.Free;
  oItems.Free;
  inherited;
end;

function TPsDayData.ReadFile(pCasNum:word; pSalDate: TDateTime):boolean; // Nacita udaje T suboru
begin
  Clear;
  oEof:=FALSE;
  oItmNum:=0;
  oGsDocCount:=0;
  oGsItmCount:=0;
  oFileName:=gPath.CasPath(pCasNum)+'T'+DateToFileName(pSalDate)+'.'+StrIntZero(pCasNum,3);
  Result:=FileExists(oFileName);
  oFile.Clear;
  If Result then oFile.LoadFromFile(oFileName);
  Result:=oFile.Count>1;
end;

procedure TPsDayData.SaveFile;
begin
  If oFile.Count>0 then oFile.SaveToFile(oFileName);
end;

procedure TPsDayData.Clear;
begin
  FillChar(oCValue,SizeOf(TValue3),#0);
  FillChar(oAValue,SizeOf(TValue3),#0);
  FillChar(oBValue,SizeOf(TValue3),#0);
  FillChar(oVatVal,SizeOf(TValue3),#0);
  FillChar(oBegVal,SizeOf(TValue9),#0);
  FillChar(oTrnVal,SizeOf(TValue9),#0);
  FillChar(oExpVal,SizeOf(TValue9),#0);
  FillChar(oInvVal,SizeOf(TValue9),#0);
  FillChar(oChoVal,SizeOf(TValue9),#0);
  FillChar(oChiVal,SizeOf(TValue9),#0);
  FillChar(oPayName,SizeOf(oPayName),#0);
  oIncVal:=0; oClaim:=0; oNegVal:=0; oDscVal:=0; oFirstBlk:=0; oLastBlk:=0; 
  oGsDocCount:=0; oGsItmCount:=0; oDClsVal:=0; oDClsVat:=0;
  FillChar(oDClsValA,SizeOf(oDClsValA),#0);
  FillChar(oDClsVatA,SizeOf(oDClsVatA),#0);
  oRetVal:=0;
end;

procedure TPsDayData.First;
var mFind: boolean;
begin
  oActItm:=-1;
  oIntNum:=0;
end;

function TPsDayData.Next;
var mFind: boolean;
begin
  Repeat
    Inc(oActItm);
    Inc(oItmNum);
    oCut.SetStr(oFile.Strings[oActItm]);
    If(oCut.GetText(1)='SB') or(oCut.GetText(1)='CB') then begin
      oItmNum:=0;
      Inc(oIntNum);
      oSalTime:=oCut.GetText(6);
//      oSalHour:=ValInt(copy(oCut.GetText(6),1,2));
      oSalHour:=ValInt(copy(oCut.GetText(6),1,Pos(':',oCut.GetText(6))-1));
      oSerNum:=ValInt(oCut.GetText(4));
      oBlkNum:=ValInt(oCut.GetText(10));
      oBlkVal:=ValDoub(oCut.GetText(7));
      oIntBlkNum:=ValInt(oCut.GetText(4));
      oLgnName:=oCut.GetText(9);
      oUsrName:=oCut.GetText(13);
      oCusCard:=oCut.GetText(8);
      oRegIno:=oCut.GetText(11);
      oPaName:=oCut.GetText(11); // ???
      oSrcDoc:=oCut.GetText(16);
      If(oCut.GetNum(25)>0)and(oCut.GetText(26)<>'') then begin
        oPaCode:=oCut.GetNum(25);
        oPaName:=oCut.GetText(26);
      end else oPaCode:=0;
      oCrdName:=oCut.GetText(27); // ???
    end;
    mFind:=(oCut.GetText(1)='SI') or(oCut.GetText(1)='CI');
    If mFind then oItems.Add(oFile.Strings[oActItm]);
  until mFind or(oActItm=oFile.Count-1);
  oEof:=not mFind;
  Result:=mFind;
end;

function TPsDayData.NextDoc;
var mFind: boolean;
begin
  Repeat
    Inc(oActItm);
    Inc(oItmNum);
    oCut.SetStr(oFile.Strings[oActItm]);
    If(oCut.GetText(1)='SB') or(oCut.GetText(1)='CB') then begin
      oBlkType:=oCut.GetText(1);
      mFind:=TRUE;
      oItmNum:=0;
      oSalTime:=oCut.GetText(6);
//      oSalHour:=ValInt(copy(oCut.GetText(6),1,2));
      oSalHour:=ValInt(copy(oCut.GetText(6),1,Pos(':',oCut.GetText(6))-1));
      oSerNum:=ValInt(oCut.GetText(4));
      oBlkNum:=ValInt(oCut.GetText(10));
      oIntBlkNum:=ValInt(oCut.GetText(4));
      oBlkVal:=ValDoub(oCut.GetText(7));
      oLgnName:=oCut.GetText(9);
      oUsrName:=oCut.GetText(13);
      oCusCard:=oCut.GetText(8);
      oRegIno:=oCut.GetText(11);
      oPaName:=oCut.GetText(11);
      oSrcDoc:=oCut.GetText(16);
      If(oCut.GetNum(25)>0)and(oCut.GetText(26)<>'') then begin
        oPaCode:=oCut.GetNum(25);
        oPaName:=oCut.GetText(26);
      end else oPaCode:=0;
      oCrdName:=oCut.GetText(27); // ???
    end;
  until mFind or(oActItm=oFile.Count-1);
  oEof:=not mFind;
  Result:=mFind;
end;

function TPsDayData.NextFullDoc;
var mFind20,mFind: boolean;
    mPayNum:byte; // Poradove cislo platidla
begin
  mFind:=False;mFind20:=False;
  oItems.Clear;
  Repeat
    Inc(oActItm);
    Inc(oItmNum);
    oCut.SetStr(oFile.Strings[oActItm]);
    If oCut.GetText(1)='FH' then oVer:= oCut.GetReal(2); // Verzia suboru
    If oVer>=20 then begin
      // cisluju sa vsetky doklady
      If(oCut.GetText(1)='SB') or(oCut.GetText(1)='CB') or(oCut.GetText(1)='RB')
      or(oCut.GetText(1)='OB') or(oCut.GetText(1)='IB') or(oCut.GetText(1)='BB')
      or(oCut.GetText(1)='HB') or(oCut.GetText(1)='FB') or(oCut.GetText(1)='PB')
      or(oCut.GetText(1)='DB') or(oCut.GetText(1)='NB') then begin
{
*FH*,*20.24*,*09.01.2012*,*SK*,*Eur*
*BB*,*1*,*1*,*59*,*19.1.2012*,*10:09:44*,*1339.43*,*33*,*1*,*33*,*TOM*,*TOM BECK*,*13.1.2012*,*19.1.2012*
*DB*,*1*,*1*,*61*,*19.1.2012*,*10:10:13*,*89*,*1*,*33*,*0*,*33*,*0*,*TOM*,*TOM BECK*
*FB*,*1*,*1*,*62*,*19.1.2012*,*13:01:15*,*1273.23*,*ADMIN*,*Administrátor*
*IB*,*1*,*1*,*63*,*19.1.2012*,*13:01:21*,*100.00*,*ADMIN*,*Administrátor*,**,*0*
*OB*,*1*,*1*,*64*,*19.1.2012*,*13:01:42*,*439.43*,*ADMIN*,*Administrátor*,*0*,*Odvod*,**
*NB*,*1*,*1*,*65*,*19.1.2012*,*13:02:20*,*500.00*,*ADMIN*,*Administrátor*
*HB*,*1*,*1*,*66*,*19.1.2012*,*13:02:33*,*200.00*,*ADMIN*,*Administrátor*,**
*PB*,*1*,*1*,*67*,*19.1.2012*,*13:02:49*,*1000.00*,*ADMIN*,*Administrátor*,*33*,*0*,*33*,*0*,*89*,*0*,**,*0.00*
*RB*,*1*,*1*,*4*,*16.11.2012*,*8:55:03*,*3*,*2222*,*22.00*,**,**,**,**,*ADMIN*,*Administrßtor*,*16.11.2012*,*0*
*SB*,*1*,*1*,*7*,*16.11.2012*,*8:56:40*,*4*,**,*ADMIN*,*6*,**,*6*,*Administrßtor*,*16.11.2012*,*20.90*,**,**,**,*B1*,*Bar 1*,*22*,*01*,*0*,**,*0*,**,**
}
        oBlkType :=oCut.GetText(1);
        mFind20 :=TRUE;
        oItmNum :=0;
        oSalTime:=oCut.GetText(6);
        oSalHour:=ValInt(copy(oCut.GetText(6),1,Pos(':',oCut.GetText(6))-1));
        oSerNum :=ValInt(oCut.GetText(4));
        oBlkNum :=ValInt(oCut.GetText(10));
        If(oCut.GetText(1)='DB') then begin
          oLgnName:=oCut.GetText(13);
          oUsrName:=oCut.GetText(14);
        end else If(oCut.GetText(1)='BB') then begin
          oLgnName:=oCut.GetText(11);
          oUsrName:=oCut.GetText(12);
        end else If(oCut.GetText(1)='RB') then begin
          oLgnName:=oCut.GetText(14);
          oUsrName:=oCut.GetText(15);
        end else begin
          oLgnName:=oCut.GetText(8);
          oUsrName:=oCut.GetText(9);
        end;
        If(oCut.GetText(1)='RB')
          then oBlkVal:=ValDoub(oCut.GetText(9))
          else If(oCut.GetText(1)='DB')
            then oBlkVal:=ValDoub(oCut.GetText(10))
            else oBlkVal:=ValDoub(oCut.GetText(7));
        oIntBlkNum:=ValInt(oCut.GetText(4));
      end;
    end;
    If(oCut.GetText(1)='SB') or(oCut.GetText(1)='CB') then begin
      oBlkType:=oCut.GetText(1);
      mFind:=TRUE;
      oItmNum:=0;
      oSalTime:=oCut.GetText(6);
//      oSalHour:=ValInt(copy(oCut.GetText(6),1,2));
      oSalHour:=ValInt(copy(oCut.GetText(6),1,Pos(':',oCut.GetText(6))-1));
      oSerNum:=ValInt(oCut.GetText(4));
      oBlkNum:=ValInt(oCut.GetText(10));
      oBlkVal:=ValDoub(oCut.GetText(15));
      oIntBlkNum:=ValInt(oCut.GetText(4));
      oLgnName:=oCut.GetText(9);
      oUsrName:=oCut.GetText(13);
      oCusCard:=oCut.GetText(8);
      oRegIno:=oCut.GetText(11);
      oPaName:=oCut.GetText(11);
      oSrcDoc:=oCut.GetText(16);
      If(oCut.GetNum(25)>0)and(oCut.GetText(26)<>'') then begin
        oPaCode:=oCut.GetNum(25);
        oPaName:=oCut.GetText(26);
      end else oPaCode:=0;
      oCrdName:=oCut.GetText(27); // ???
    end;
  until mFind or mFind20 or(oActItm=oFile.Count-1);
  oBlkPayVal:=0;oBlkSumVal:=0;oBlkItmVal:=0;oBlkStvVal:=0;oClaim:=0;
  If mFind then begin
    mFind:=False;
    Repeat
      Inc(oActItm);
      oCut.SetStr(oFile.Strings[oActItm]);
      If(oCut.GetText(1)='SS') then begin
        oBlkSumVal:=oBlkSumVal+oCut.GetReal(4);
      end;
      If(oCut.GetText(1)='CS') then begin
        oBlkSumVal:=oBlkSumVal+oCut.GetReal(4);
        oClaim:=oClaim-oCut.GetReal(4);
      end;
      If(oCut.GetText(1)='SI') or(oCut.GetText(1)='CI') then begin // Prve a posledne cislo pokladnicneho dokladu
        oItems.Add(oFile.Strings[oActItm]);
        oBlkItmVal:=oBlkItmVal+oCut.GetReal(10);
        Inc(oItmNum);
      end;
      If(oCut.GetText(1)='SP') or(oCut.GetText(1)='CP') then begin // Trzba podla platidiel
        mPayNum:=oCut.GetNum(2);
        If oVer<20 then begin
          oBlkPayVal:=oBlkPayVal+oCut.GetReal(5);
          If(mPayNum=0)and IsNul(oCut.GetReal(5))
            then oBlkPayVal:=oBlkPayVal-oCut.GetReal(4);
          If IsNul(oCut.GetReal(5)) then oRetVal:=oRetVal+oCut.GetReal(4);
        end else oBlkPayVal:=oBlkPayVal+oCut.GetReal(4);
      end;
      If(oCut.GetText(1)='ST') or(oCut.GetText(1)='CT') then begin // Predaj podla danovych hladin
        oBlkStvVal:=oBlkStvVal+oCut.GetReal(5);
      end;
      If(oCut.GetText(1)='SC') or(oCut.GetText(1)='CC') then begin // Refundacia tovaru - reklamacia
        mFind:=True;
      end;
    until mFind or(oActItm=oFile.Count-1);
  end;
  oEof  :=not mFind;
  Result:=mFind or mFind20;
  oEof  :=oActItm=oFile.Count-1;
end;

function TPsDayData.Eof: boolean; // Hodnota funkcie je TRUE ak uz dalej nie su dalsie tovarove polozky
begin
  Result:=oEof;
end;

procedure TPsDayData.SetMgCode(pMgCode:longint); // Tovarova skupina
var mI:integer;
begin
(*
  oWrap.ClearWrap;
  for mI:=1 to oCut.Count do begin
    If mI<>3
      then oWrap.SetText(oCut.GetText(mI),0)
      else oWrap.SetNum(pMGCode,0)
  end;
  oFile.Strings[oActItm]:=oWrap.GetWrapText;
*)
  oCut.SetNum(3,pMGCode);
  oFile.Strings[oActItm]:=oCut.GetStr;
end;

procedure TPsDayData.ReadGlobData; // Procedura nacita globalne udaje predaja do pamatovych premennych
var mPayNum:byte; // Poradove cislo platidla
    mVatNum:byte; // Hladina DPH
    mCnt:integer;
begin
  oBlkSumVal:=0;
  If oFile.Count>0 then begin
    mCnt:=-1;
    Repeat
      Inc(mCnt);
      oCut.SetStr(oFile.Strings[mCnt]);
      If oCut.GetText(1)='FH' then oVer:= oCut.GetReal(2); // Verzia suboru
      If oCut.GetText(1)='BP' then begin // Pociatocny stav
        mPayNum:=oCut.GetNum(2);
        oPayName[mPayNum]:=oCut.GetText(3);
        oBegVal[mPayNum]:=oBegVal[mPayNum]+oCut.GetReal(4);
      end;
      If(oCut.GetText(1)='SB') or(oCut.GetText(1)='CB') then begin // Prve a posledne cislo pokladnicneho dokladu
        Inc(oGsDocCount);
        If oFirstBlk=0 then oFirstBlk:=oCut.GetNum(4);
        oLastBlk:=oCut.GetNum(4);
      end;
//      If(oCut.GetText(1)='SB') then begin // Zlavy a zaporne polozky
//        oDscVal:=oDscVal+oCut.GetReal(18);  // Hodnota zliav
//      end;
      If(oCut.GetText(1)='SS') or(oCut.GetText(1)='CS') then begin
        oBlkSumVal:=oBlkSumVal+oCut.GetReal(4);
      end;
      If(oCut.GetText(1)='SS') then begin // Zlavy
        oDscVal:=oDscVal+oCut.GetReal(9);  // Hodnota zliav
      end;
      If(oCut.GetText(1)='SI') or(oCut.GetText(1)='CI') then begin // Prve a posledne cislo pokladnicneho dokladu
        oItems.Add(oFile.Strings[mCnt]);
        Inc(oGsItmCount);
      end;
      If(oCut.GetText(1)='SP') or(oCut.GetText(1)='CP') then begin // Trzba podla platidiel
        mPayNum:=oCut.GetNum(2);
        oPayName[mPayNum]:=oCut.GetText(3);
        If oVer<20
          then oTrnVal[mPayNum]:=oTrnVal[mPayNum]+oCut.GetReal(5)  // SU2160001400
          else oTrnVal[mPayNum]:=oTrnVal[mPayNum]+oCut.GetReal(4);  // SU2160001400
//        oTrnVal[mPayNum]:=oTrnVal[mPayNum]+oCut.GetReal(5)-oCut.GetReal(4);  // SU2160001400
//        If IsNul(oCut.GetReal(5)) then oRetVal:=oRetVal+oCut.GetReal(4);  // SU2160001400
      end;
      If(oCut.GetText(1)='ST') or(oCut.GetText(1)='CT') then begin // Predaj podla danovych hladin
        mVatNum:=VatGrp(oCut.GetReal(2));
        oAValue[mVatNum]:=oAValue[mVatNum]+oCut.GetReal(3);
        oVatVal[mVatNum]:=oVatVal[mVatNum]+oCut.GetReal(4);
        oBValue[mVatNum]:=oBValue[mVatNum]+oCut.GetReal(5);
        oAValue[0]:=oAValue[1]+oAValue[2]+oAValue[3];
        oVatVal[0]:=oVatVal[1]+oVatVal[2]+oVatVal[3];
        oBValue[0]:=oBValue[1]+oBValue[2]+oBValue[3];
      end;
      If(oCut.GetText(1)='CS') then begin // Refundacia tovaru - reklamacia
        oClaim:=oClaim+oCut.GetReal(3)*(-1);
      end;
      If oCut.GetText(1)='HX' then begin // Vydaj na zmenu platidla
        mPayNum:=oCut.GetNum(2);
        oPayName[mPayNum]:=oCut.GetText(3);
        If oVer<13
          then oChoVal[mPayNum]:=oChoVal[mPayNum]+oCut.GetReal(5)
          else oChoVal[mPayNum]:=oChoVal[mPayNum]+oCut.GetReal(4);
      end;
      If oCut.GetText(1)='HY' then begin // Prijem zo zmeny platidla
        mPayNum:=oCut.GetNum(2);
        oPayName[mPayNum]:=oCut.GetText(3);
        If oVer<13
          then oChiVal[mPayNum]:=oChiVal[mPayNum]+oCut.GetReal(5)
          else oChiVal[mPayNum]:=oChiVal[mPayNum]+oCut.GetReal(4);
      end;
      If oCut.GetText(1)='OP' then begin // Vydaj z pokladne podla platidiel
        mPayNum:=oCut.GetNum(2);
        oPayName[mPayNum]:=oCut.GetText(3);
        If oVer<13
          then oExpVal[mPayNum]:=oExpVal[mPayNum]+oCut.GetReal(5)
          else oExpVal[mPayNum]:=oExpVal[mPayNum]+oCut.GetReal(4);
      end;
      If oCut.GetText(1)='RP' then begin // Hotovostne uhrady OFA
        mPayNum:=oCut.GetNum(2);
        oPayName[mPayNum]:=oCut.GetText(3);
        oInvVal [mPayNum]:=oInvVal[mPayNum]+oCut.GetReal(4);
      end;
      If oCut.GetText(1)='IP' then begin // prijem do pokladne podla platidiel
        If oVer<13
          then oIncVal:=oIncVal+oCut.GetReal(5)
          else oIncVal:=oIncVal+oCut.GetReal(4);
      end;
      If(oCut.GetText(1)='DI') then begin // prijem do pokladne podla platidiel
        If oCut.GetText(2)='4' then begin
          oDClsVal:=oDClsVal+oCut.GetReal(3);
          If oCut.GetFldNum>4
            then mVatNum:=VatGrp(oCut.GetReal(5))
            else mVatNum:=1;
          oDClsVat:=oDClsVat+(oCut.GetReal(3)-(oCut.GetReal(3)/(1+gIni.GetVatPrc(mVatNum)/100)));
          oDClsValA[mVatNum]:=oDClsValA[mVatNum]+oCut.GetReal(3);
          oDClsVatA[mVatNum]:=oDClsVatA[mVatNum]+oCut.GetReal(4);
        end;
        If oCut.GetText(2)='5' then begin
          oDClsVal:=oDClsVal+oCut.GetReal(3);
          If oCut.GetFldNum>4
            then mVatNum:=VatGrp(oCut.GetReal(5))
            else mVatNum:=2;
          oDClsVat:=oDClsVat+(oCut.GetReal(3)-(oCut.GetReal(3)/(1+gIni.GetVatPrc(mVatNum)/100)));
          oDClsValA[mVatNum]:=oDClsValA[mVatNum]+oCut.GetReal(3);
          oDClsVatA[mVatNum]:=oDClsVatA[mVatNum]+oCut.GetReal(4);
        end;
        If oCut.GetText(2)='6' then begin
          oDClsVal:=oDClsVal+oCut.GetReal(3);
          If oCut.GetFldNum>4
            then mVatNum:=VatGrp(oCut.GetReal(5))
            else mVatNum:=3;
          oDClsVat:=oDClsVat+(oCut.GetReal(3)-(oCut.GetReal(3)/(1+gIni.GetVatPrc(mVatNum)/100)));
          oDClsValA[mVatNum]:=oDClsValA[mVatNum]+oCut.GetReal(3);
          oDClsVatA[mVatNum]:=oDClsVatA[mVatNum]+oCut.GetReal(4);
        end;
      end;
    until(mCnt=oFile.Count-1);
  end;
end;

function TPsDayData.GetItmNum: word;   // Poradove cislo polozky na pokladnicnom doklade
begin
  Result:=oItmNum;
end;

function TPsDayData.GetSalTime: Str8;   // Cas predaja tovarovej polozky
begin
  Result:=oSalTime;
end;

function TPsDayData.GetSalHour: byte; // Cas predaja tovarovej polozky
begin
  Result:=oSalHour;
end;

function TPsDayData.GetSerNum: longint; // Chronologicke poradove cislo pokladnicneho dokladu
begin
  Result:=oSerNum;
end;

function TPsDayData.GetBlkNum: longint; // Danove cislo pokladnicneho dokladu
begin
  Result:=oBlkNum;
end;

function TPsDayData.GetIntBlkNum: longint; // Interne cislo pokladnicneho dokladu
begin
  Result:=oIntBlkNum;
end;

function TPsDayData.GetGsCode: longint;  // Tovarove cislo
begin
  oCut.SetStr(oFile.Strings[oActItm]);
  Result:=oCut.GetNum(4);
end;

function TPsDayData.GetGsName: Str30;  // Nazov tovaru
begin
  oCut.SetStr(oFile.Strings[oActItm]);
  Result:=oCut.GetText(2);
end;

function TPsDayData.GetMgCode: longint;  // Tovarova skupina
begin
  oCut.SetStr(oFile.Strings[oActItm]);
  Result:=oCut.GetNum(3);
end;

function TPsDayData.GetBarCode: Str15;  // Identifikacny kod tovaru
begin
  oCut.SetStr(oFile.Strings[oActItm]);
  Result:=oCut.GetText(12);
end;

//TIBI 23.03.2015
function TPsDayData.GetStkCode: Str15;  // Skladový kod tovaru
begin
  oCut.SetStr(oFile.Strings[oActItm]);
  Result:=oCut.GetText(15);
end;

function TPsDayData.GetGsQnt: double;  // Mnozstvo predaneho tovaru
begin
  oCut.SetStr(oFile.Strings[oActItm]);
  Result:=oCut.GetReal(5);
end;

function TPsDayData.GetVatPrc: double;     // Sadzba DPH
begin
  oCut.SetStr(oFile.Strings[oActItm]);
  Result:=oCut.GetReal(6);
end;

function TPsDayData.GetDscPrc: double;     // Percentualna sadzba zlavy
begin
  oCut.SetStr(oFile.Strings[oActItm]);
  Result:=oCut.GetReal(7);
end;

function TPsDayData.GetProfPrc: double;     // Percentualna sadzba zisku
begin
  oCut.SetStr(oFile.Strings[oActItm]);
  Result:=oCut.GetReal(8);
end;

function TPsDayData.GetStkNum: longint;    // Sklad odkial sa odpocita tovar
begin
  oCut.SetStr(oFile.Strings[oActItm]);
  Result:=oCut.GetNum(16);
end;

function TPsDayData.GetProdNum: Str20;      // Vyrobne cislo tovaru
begin
  oCut.SetStr(oFile.Strings[oActItm]);
  Result:=oCut.GetText(19);
end;

function TPsDayData.GetIDscVal: double;    // Hodnota zlavy z PC s DPH
begin
  oCut.SetStr(oFile.Strings[oActItm]);
  Result:=oCut.GetReal(18);
end;

function TPsDayData.GetDscType: Str1;      // Typ poskytnutej zlavy
begin
  oCut.SetStr(oFile.Strings[oActItm]);
  Result:=oCut.GetText(21);
end;

function TPsDayData.GetDscGrp: byte;      // Skupina zlavy - cislo tocenia KS
begin
  oCut.SetStr(oFile.Strings[oActItm]);
  Result:=oCut.GetNum(22);
end;

function TPsDayData.GetICValue: double;    // Hodnota tovaru v NC bez DPH
begin
  Result:=Rd2(GetIAValue/(1+GetProfPrc/100));
end;

function TPsDayData.GetIBPrice: double;    // PC s DPH
begin
  If IsNul(GetGsQnt)
    then Result:=GetIBValue
    else Result:=Rd2(GetIBValue/GetGsQnt);
end;

function TPsDayData.GetIAValue: double;    // Hodnota tovaru v PC bez DPH
begin
  Result:=Rd2(GetIBValue/(1+GetVatPrc/100));
end;

function TPsDayData.GetIBValue: double;    // Hodnota tovaru v PC s DPH
begin
  oCut.SetStr(oFile.Strings[oActItm]);
  Result:=oCut.GetReal(10);
end;

function TPsDayData.GetLgnName: Str8;  // Prihlasovacie meno pokladnicky
begin
  Result:=oLgnName;
end;

function TPsDayData.GetUsrName: Str30;  // Cele meno pokladnicky
begin
  Result:=oUsrName;
end;

function TPsDayData.GetCusCard: Str20;  // Cislo identifikacnej karty zakaznika
begin
  Result:=oCusCard;
end;

function TPsDayData.GetRegIno:Str15;  // ICO zakaznika
begin
  Result:=oRegIno;
end;

function TPsDayData.GetPaName: Str30;  // Meno zakaznika
begin
  Result:=oPaName;
end;

function TPsDayData.GetPaCode: longint;  // Kod zakaznika
begin
  Result:=oPaCode;
end;

function TPsDayData.GetCrdName: Str30;  // Majitel zakaznickej karty
begin
  Result:=oCrdName;
end;

function TPsDayData.GetSrcDoc: Str12;  // Zdrojovy doklad
begin
  Result:=oSrcDoc;
end;

function TPsDayData.GetCValue(pIndex:byte): double;
begin
  Result:=oCValue[pIndex];
end;

function TPsDayData.GetAValue(pIndex:byte): double;
begin
  Result:=oAValue[pIndex];
end;

function TPsDayData.GetBValue(pIndex:byte): double;
begin
  Result:=oBValue[pIndex];
end;

function TPsDayData.GetVatVal(pIndex:byte): double;
begin
  Result:=oVatVal[pIndex];
end;

function TPsDayData.GetBegVal(pIndex:byte): double;
begin
  Result:=oBegVal[pIndex];
end;

function TPsDayData.GetTrnVal(pIndex:byte): double;
begin
  Result:=oTrnVal[pIndex];
end;

function TPsDayData.GetExpVal(pIndex:byte): double;
begin
  Result:=oExpVal[pIndex];
end;

function TPsDayData.GetInvVal(pIndex:byte): double;
begin
  Result:=oInvVal[pIndex];
end;

function TPsDayData.GetChiVal(pIndex:byte): double;
begin
  Result:=oChiVal[pIndex];
end;

function TPsDayData.GetChoVal(pIndex:byte): double;
begin
  Result:=oChoVal[pIndex];
end;

function TPsDayData.GetPayName(pIndex:byte): Str20;
begin
  Result:=oPayName[pIndex];
end;

function TPsDayData.GetClaim: double;
begin
  Result:=oClaim;
end;

function TPsDayData.GetNegVal: double;
begin
  Result:=oNegVal;
end;

function TPsDayData.GetDscVal: double;
begin
  Result:=oDscVal;
end;

function TPsDayData.GetIncVal: double;
begin
  Result:=oIncVal;
end;

function TPsDayData.GetFirstBlk: longint;
begin
  Result:=oFirstBlk;
end;

function TPsDayData.GetLastBlk: longint;
begin
  Result:=oLastBlk;
end;

function TPsDayData.GetGsDocCount: longint;
begin
  Result:=oGsDocCount;
end;

function TPsDayData.GetGsItmCount: longint;
begin
  Result:=oGsItmCount;
end;

function TPsDayData.GetDClsVal: double;
begin
  Result:=oDClsVal;
end;

function TPsDayData.GetDClsVat: double;
begin
  Result:=Rd2(oDClsVat);
end;

function TPsDayData.GetDClsValA(pVatGrp: byte): double;
begin
  If pVatGrp<=5
    then Result:=oDClsValA[pVatGrp]
    else Result:=0;
end;

function TPsDayData.GetDClsVatA(pVatGrp: byte): double;
begin
  If pVatGrp<=5
    then Result:=oDClsVatA[pVatGrp]
    else Result:=0;
end;

function TPsDayData.GetBlkVal: double;
begin
  Result:=oBlkVal;
end;

end.
