unit PceDet;
{$F+}

// *****************************************************************************
//                          URCENIE PREDAJNEJ CENY TOVARU
// *****************************************************************************
// Tento objekt sluzi na urcenie predajnej ceny zadanej polozky. Predajn� cena
// moze pochadzat z nalsedovnych zdrojov:
// 1. Z�kladn� cen�kov� predajn� cena zo zadan�ho cenn�ka
// 2. �peci�lna predajn� cena z cenn�ka, ktor� je priraden� k partnerovi
// 3. Predajn� cena vypo��tan� z glob�lnej z�avy partnera
// 4. Predajn� cena vypocitana na zaklade obchodnych podmienok partnera
// 5. Zmluvna predajna cena pre daneho partnera
// 6. Akciov� predajn� cena
// 7. Predajn� cena vypo��tan� zo z�avy z v�hodnenej hodiny
// 8. Terminovan� predajn� cena
//
// Priorita v�beru ceny m��e by� nastaven� nasledovne:
// - vyber najlep�ej t.j. najni��ej ceny
// - podla zadanej priority - z�kladn� prioritu je moz�n� zmeni� pre konkr�tnoho
//   zakaznika prostrednictvom inicializanych parametrov pokladne-
//
// Programov� funkcia:
// ---------------
// Add - zalo�� pre zadaneho pracovnikanovy pracovny ukol
// *****************************************************************************


interface

uses
  IcTypes, IcConv, IcTools, IcVariab, IniFiles, SysUtils, NexGlob, BtrHand, Bok, Key, Txt, AgmFnc,
  hPLS, hPAB, hTPC, hAPLITM, hFGPADSC,
  NexPath, NexIni, TxtWrap, TxtCut, StkCanc, DocHand, TxtDoc, Forms, Classes;

type
  TPceDet = class(TComponent)
    constructor Create;
    destructor  Destroy; override;
    private
      oGsCode: longint; // ��slo tovaru (PLU) predajnu cenu ktoreho chceme zistit
      oFgCode: longint; // ��slo finan�nej skupiny
      oPaCode: longint; // ��seln� k�d firmy
      oVatPrc: byte;    // Percentu�lna sadzba DPH
      oSaDate: TDateTime; // D�tum predaja
      oSaTime: TDateTime; // �as predaja
      oPlsNum: word;    // Cislo predajneho cennika ktorym pracuje objekt
      oPacPls: word;    // Cislo cennika, ktory je zadany pre danu firmu
      oTpcNum: word;    // Cislo cennika terminovanych cien
      oPcePri: byte;    // Definicia urcenia priority (0-najlep�ia cena;1-zadana priorita)
      oPlsPri: byte;    // Priorita cennikovej predajnej ceny
      oPalPri: byte;    // Priorita predajnej ceny z cenn�ka, ktor� je priraden� k partnerovi
      oPadPri: byte;    // Priorita predajnej ceny vypo��tanej z glob�lnej z�avy partnera
      oBciPri: byte;    // Priorita predajnej ceny vypocitanej na zaklade obchodnych podmienok partnera
      oAglPri: byte;    // Priorita zmluvnej predajnej ceny pre daneho partnera
      oActPri: byte;    // Priorita akciovej predajnej ceny
      oFavPri: byte;    // Priorita predajnej ceny vypo��tanej zo z�avy z v�hodnenej hodiny
      oTpcPri: byte;    // Priorita terminovanej predajnej ceny
      oOcdPri: byte;    // Priorita predajnej ceny z z�kazky
      oDscPrc: double;  // Vysledna percentu�lna hodnota poskytnutej z�avy
      oPadDsc: double;  // Percentu�lna hodnota glob�lnej z�avy partnera
      oBciDsc: double;  // Percentu�lna hodnota z�avy z obchodnych podmienok
      oFavDsc: double;  // Percentu�lna hodnota zv�hodnenej hodiny
      oDocDsc: double;  // Percentu�lna hodnota dokladovej z�avy
      oPlsPce: double;  // Z�kladn� cennikova predajna cena tovaru s DPH
      oPalPce: double;  // �peci�lna predajn� cena s DPH z cenn�ka, ktor� je priraden� k partnerovi
      oPadPce: double;  // Predajn� cena s DPH vypo��tan� z glob�lnej z�avy partnera
      oBciPce: double;  // Predajn� cena s DPH vypocitana na zaklade obchodnych podmienok partnera
      oAgmPce: double;  // Zmluvna predajna cena s DPH pre daneho partnera
      oActPce: double;  // Akciov� predajn� cena s DPH
      oFavPce: double;  // Predajn� cena s DPH vypo��tan� zo z�avy z v�hodnenej hodiny
      oTpcPce: double;  // Terminovan� predajn� cena s DPH
      oOcdPce: double;  // Predajn� cena s DPH zo z�kazky
      oCrdPce: double;  // Predajn� cena s DPH po odpocitani kartovaej zlavy
      oLevPce: double;  // Predajna cena podla zadanej cenovej hladiny
      oLevNum: byte;    // Cenova hladina
      oPceDes: Str90;   // Pomenovanie v7slednej ceny
      oAPrice: double;  // Vysledna predajna cena bez DPH
      oBPrice: double;  // Vysledna predajna cena s DPH
      oPceSrc: Str3;    // Zdroj predajnej ceny (PLS,PAL,AGL,ACT,TPC,OCD)
      oDscSrc: Str3;    // Zdroj z�avy (PAD,BCI,FAV,CRD)

      oAgm:TAgmFnc;
      ohPLS: TPlsHnd;   // Zakladny predajny cennik - cennikove ceny
      ohPAB: TPabHnd;   // Katalog partnerov
      ohTPC: TTpcHnd;   // Cennik terminovanych cien
      ohPACPLS: TPlsHnd;   // Specialny predajny cennik zadany na karte danej firmy
      ohAPLITM: TAplitmHnd;   // Akciove ceny
      ohFGPADSC: TFgpadscHnd; // Obchodne podmienky odberatelov

      function GetPlsPce:double;
      function GetPalPce:double;
      function GetPadPce:double;
      function GetBciPce:double;
      function GetAglPce:double;
      function GetActPce:double;
      function GetFavPce:double;
      function GetTpcPce:double;
      function GetCrdPce:double;
      function GetLevPce:double;
      function GetAPrice:double;
      function GetAction:Str1;
      procedure BstPceDet; // Ur�� najlepsiu cenu
      procedure PriPceDet; // Ur�� cenu podla zadanej priority
    public
      procedure Clear;  // Vynuluje menne parametre objektu
      procedure Execute(pGsCode,pPaCode:longint); // Spusti funkcie na urcenie predajnej ceny podla zadanych vlastnosti
    published
      // Doplnkov� parametre - nie su povinn�
      property PlsNum:word write oPlsNum;
      property TpcNum:word write oTpcNum;
      property VatPrc:byte write oVatPrc;
      property OcdPce:double write oOcdPce;
      property DocDsc:double write oDocDsc;
      property SaDate:TDateTime write oSaDate;
      property SaTime:TDateTime write oSaTime;
      // V�sledok
      property DscPrc:double read oDscPrc;
      property APrice:double read GetAPrice;
      property BPrice:double read oBPrice;
      property PlsPce:double read oPlsPce;
      property PceSrc:Str3 read oPceSrc;
      property DscSrc:Str3 read oDscSrc;
      property Action:Str1 read GetAction;
      property LevNum:byte read oLevNum;
      property PceDes:Str90 read oPceDes;
  end;

implementation

uses bPAB;

constructor TPceDet.Create;
begin
  oPlsNum:=0;  oPacPls:=0;  oTpcNum:=0;
  oVatPrc:=gIni.GetVatPrc(2);  // Nastavime zakldne DPH pre sadzbu skupinu 2
  // Zakladne nastavenie
  oPcePri:=0;  // Definicia urcenia priority (0-najlep�ia cena)
  oPlsPri:=1;
  oPalPri:=2;
  oPadPri:=3;
  oBciPri:=4;
  oAglPri:=5;
  oActPri:=6;
  oFavPri:=7;
  oTpcPri:=8;
  oOcdPri:=9;
  // Pouzite databazove subory
  oAgm:=TAgmFnc.Create;
  ohPLS:=TPlsHnd.Create;
  ohPAB:=TPabHnd.Create;  ohPAB.Open(0);
  ohTPC:=TTpcHnd.Create;
  ohPACPLS:=TPlsHnd.Create;
  ohAPLITM:=TAplitmHnd.Create;  ohAPLITM.Open;
  ohFGPADSC:=TFgpadscHnd.Create;  ohFGPADSC.Open;
  oPceDes:=SysTxt('PlsPce','Cenn�kov� predajn� cena');
end;

destructor TPceDet.Destroy;
begin
  FreeAndNil (ohFGPADSC);
  FreeAndNil (ohAPLITM);
  FreeAndNil (ohPACPLS);
  FreeAndNil (ohTPC);
  FreeAndNil (ohPAB);
  FreeAndNil (ohPLS);
  FreeAndNil (oAgm);
end;

// ********************************* PRIVATE ***********************************

function TPceDet.GetPlsPce:double;
begin
  oFgCode:=0;
  Result:=0;
  Result:=oPlsPce; // Ak cennikovu predajnu cenu nebude mozne urcit potom zostava povodna cena
  If not ohPLS.Active and (oPlsNum>0) then ohPLS.Open(oPlsNum);
  If ohPLS.Active then begin
    If ohPLS.LocateGsCode(oGsCode) then begin
      Result:=ohPLS.BPrice;
      oFgCode:=ohPLS.FgCode;
    end;
  end;
end;

function TPceDet.GetPalPce:double;
begin
  Result:=0;
  If ohPAB.LocatePaCode(oPaCode) then begin
    If ohPAB.IcPlsNum>0 then begin  // Dana firma ma zadany �peci�lny cenn�k
      oPacPls:=ohPAB.IcPlsNum;
      If not ohPACPLS.Active and (oPacPls>0) then ohPACPLS.Open(oPacPls);
      If ohPACPLS.Active then begin
        If ohPACPLS.LocateGsCode(oGsCode) then Result:=ohPACPLS.BPrice;
      end;
    end;
  end;
end;

function TPceDet.GetLevPce:double;
begin
  Result:=0;
  If ohPAB.LocatePaCode(oPaCode) then begin
    If ohPAB.IcPlsNum>0 then begin  // Dana firma ma zadany �peci�lny cenn�k
      oLevNum:=ohPAB.SpeLev;
      If ohPLS.LocateGsCode(oGsCode) then begin
        case oLevNum of
          0: begin Result:=ohPLS.BPrice;  oPceSrc:='EU';  end;
          1: begin Result:=ohPLS.BPrice1; oPceSrc:='D1';  end;
          2: begin Result:=ohPLS.BPrice2; oPceSrc:='D2';  end;
          3: begin Result:=ohPLS.BPrice3; oPceSrc:='D3';  end;
        end;
      end;
    end;
  end;
end;

function TPceDet.GetPadPce:double;
begin
  Result:=0;
  If ohPAB.LocatePaCode(oPaCode) then begin
    oPadDsc:=ohPAB.IcDscPrc;
    If IsNotNul(oPadDsc) then begin  // Dana firma ma zadanu globalnu zlavu
      Result:=Rd2(oPlsPce*(1-oPadDsc/100));
    end;
  end;
end;

function TPceDet.GetBciPce:double;
begin
  Result:=0;
  If oFgCode>0 then begin // Hladame cenu podla obchodnych podmienok ak je zadana financna skupina
    If ohFGPADSC.LocatePaFg(oPaCode,oFgCode) then begin
      oBciDsc:=ohFGPADSC.DscPrc;
      Result:=Rd2(oPlsPce*(1-oBciDsc/100));
    end;
  end;
end;

function TPceDet.GetAglPce:double;
begin
  Result:=oAgm.GetAgcBpc(oGsCode,oPaCode,'',Date);
//  If ohAGRITM.LocatePaGs(oPaCode,oGsCode) then Result:=ohAGRITM.BPrice;  TODO
end;

function TPceDet.GetActPce:double;
var mAplNum:word;
begin
  Result:=0;  mAplNum:=0;
  If ohPAB.LocatePaCode(oPaCode) then mAplNum:=ohPAB.IcAplNum;
  If ohAPLITM.LocateGsCode(oGsCode) then begin  // Ak by bolo viac platnych akciovych cien vyberieme najni��iu cenu
    Repeat
      If ohAPLITM.AplNum=mAplNum then begin
        If ohAPLITM.TimeInt=0 then begin
          If ohAPLITM.EndTime>ohAPLITM.BegTime then begin
            If InDateInterval (ohAPLITM.BegDate,ohAPLITM.EndDate,oSaDate)
            and InTimeInterval(ohAPLITM.BegTime,ohAPLITM.EndTime,oSaTime)  then begin
              If IsNul(Result) or (Result>ohAPLITM.AcBPrice) then Result:=ohAPLITM.AcBPrice;
            end;
          end else begin
            If InDateInterval (ohAPLITM.BegDate,ohAPLITM.EndDate,oSaDate) then begin
              If IsNul(Result) or (Result>ohAPLITM.AcBPrice) then Result:=ohAPLITM.AcBPrice;
            end;
          end;
        end else begin
          If ((ohAPLITM.BegDate<oSaDate)or((ohAPLITM.BegDate=oSaDate)and(ohAPLITM.BegTime<oSaTime)))
          and((ohAPLITM.EndDate>oSaDate)or((ohAPLITM.EndDate=oSaDate)and(ohAPLITM.EndDate>oSaTime))) then
          begin
            If IsNul(Result) or (Result>ohAPLITM.AcBPrice) then Result:=ohAPLITM.AcBPrice;
          end;
        end;
      end;
      Application.ProcessMessages;
      ohAPLITM.Next;
    until ohAPLITM.Eof or (ohAPLITM.GsCode<>oGsCode);
  end;
end;

function TPceDet.GetFavPce:double;
begin
  Result:=0;
end;

function TPceDet.GetTpcPce:double;
begin
  Result:=0;
  If not ohTPC.Active and (oPlsNum>0) then ohTPC.Open(oPlsNum);
  If ohTPC.Active then begin
    If ohTPC.LocateGsCode(oGsCode) then begin  // Ak by bolo viac platnych terminovan�ch cien vyberieme najni��iu cenu
      Repeat
        If InDateInterval (ohTPC.BegDate,ohTPC.EndDate,oSaDate) and InTimeInterval (ohTPC.BegTime,ohTPC.EndTime,oSaTime) then begin
          If IsNul(Result) or (Result>ohTPC.BPrice) then Result:=ohTPC.BPrice;
        end;
        Application.ProcessMessages;
        ohTPC.Next;
      until ohTPC.Eof or (ohTPC.GsCode<>oGsCode);
    end;
  end;
end;

function TPceDet.GetCrdPce:double;
begin
  Result:=0;
  If IsNotNul(oDocDsc) then Result:=Rd2(oPlsPce*(1-oDocDsc/100));
end;

function TPceDet.GetAPrice:double;
begin
  Result:=Rd2(oBPrice/(1+oVatPrc/100));
end;

function TPceDet.GetAction:Str1;
begin
  If oPceSrc='ACT'
    then Result:='A'
    else Result:='';
end;


procedure TPceDet.Clear; // Vynuluje menne parametre objektu
begin
  oDscPrc:=0;  oPlsPce:=0;  oPalPce:=0;  oPadPce:=0;  oBciPce:=0;
  oAgmPce:=0;  oActPce:=0;  oFavPce:=0;  oTpcPce:=0;  oOcdPce:=0;
  oLevPce:=0;  oDocDsc:=0;  oAPrice:=0;  oBPrice:=0;  oPceSrc:='';
  oSaDate:=Date;
  oSaTime:=Time;
end;

procedure TPceDet.BstPceDet; // Ur�� najlepsiu cenu
begin
  // Ur��me v�etky ceny
  oPlsPce:=GetPlsPce;
  oActPce:=GetActPce;
  oFavPce:=GetFavPce;
  oTpcPce:=GetTpcPce;
  oCrdPce:=GetCrdPce;
  If oPaCode<>0 then begin // Ak je zadana firma urcime aj nasledovne ceny
    oPalPce:=GetPalPce;
    oPadPce:=GetPadPce;
    oBciPce:=GetBciPce;
    oAgmPce:=GetAglPce;
    If gKey.SysSpeLev then oLevPce:=GetLevPce;
  end;
  // N�jdeme najlep�iu cenu
  oBPrice:=oPlsPce;    oPceSrc:='PLS';  oDscSrc:='';     oDscPrc:=0;
  If IsNotNul(oActPce) and ((oActPce<oBPrice) or IsNul(oBPrice)) then begin
    oPceDes:=SysTxt('ActPce','Akciov� predajn� cena');
    oBPrice:=oActPce;  oPceSrc:='ACT';  oDscSrc:='';     oDscPrc:=0;
  end;
  If IsNotNul(oFavPce) and ((oFavPce<oBPrice) or IsNul(oBPrice)) then begin
    oPceDes:=SysTxt('FavPce','Predajn� cena pod�a v�hodnej hodiny');
    oBPrice:=oPlsPce;  oPceSrc:='PLS';  oDscSrc:='FAV';  oDscPrc:=oFavDsc;
  end;
  If IsNotNul(oTpcPce) and ((oTpcPce<oBPrice) or IsNul(oBPrice)) then begin
    oPceDes:=SysTxt('TpcPce','Terminovan� predajn� cena');
    oBPrice:=oTpcPce;  oPceSrc:='TPC';  oDscSrc:='';     oDscPrc:=0;
  end;
  If IsNotNul(oCrdPce) and ((oCrdPce<oBPrice) or IsNul(oBPrice)) then begin
    oPceDes:=SysTxt('CrdPce','Predajn� cena pod�a z�kazn�ckej karty');
    oBPrice:=oPlsPce;  oPceSrc:='PLS';  oDscSrc:='CRD';  oDscPrc:=oDocDsc;
  end;
  If IsNotNul(oPalPce) and ((oPalPce<oBPrice) or IsNul(oBPrice)) then begin
    oPceDes:=SysTxt('PalPce','Predajn� cena z predajn�ho cenn�ka partnera');
    oBPrice:=oPalPce;  oPceSrc:='PAL';  oDscSrc:='';     oDscPrc:=0;
  end;
  If IsNotNul(oPadPce) and ((oPadPce<oBPrice) or IsNul(oBPrice)) then begin
    oPceDes:=SysTxt('PadPce','Predajn� cena pod�a glon�lnej z�avy z�kazn�ka');
    oBPrice:=oPadPce;  oPceSrc:='PAD';  oDscSrc:='PAD';  oDscPrc:=oPadDsc;
  end;
  If IsNotNul(oBciPce) and ((oBciPce<oBPrice) or IsNul(oBPrice)) then begin
    oPceDes:=SysTxt('BciPce','Predajn� cena pod�a obchodn�ch podmienok');
    oBPrice:=oBciPce;  oPceSrc:='BCI';  oDscSrc:='BCI';  oDscPrc:=oBciDsc;
  end;
  If IsNotNul(oAgmPce) and ((oAgmPce<oBPrice) or IsNul(oBPrice)) then begin
    oPceDes:=SysTxt('AgmPce','Predajn� cena pod�a zmluvn�ch podmienok');
    oBPrice:=oAgmPce;  oPceSrc:='AGL';  oDscSrc:='';     oDscPrc:=0;
  end;
  If gKey.SysSpeLev then begin
    If IsNotNul(oLevPce) and ((oLevPce<oBPrice) or IsNul(oBPrice)) then begin
      oPceDes:=SysTxt('LevPce','Predajna cena podla cenovej hladiny');
      oBPrice:=oLevPce;  oPceSrc:='LEV';  oDscSrc:='';     oDscPrc:=0;
    end;
  end;
end;

procedure TPceDet.PriPceDet; // Ur�� cenu podla zadanej priority
begin
end;

// ********************************** PUBLIC ***********************************

procedure TPceDet.Execute(pGsCode,pPaCode:longint);  // Spusti funkcie na urcenie predajnej ceny podla zadanych vlastnosti
begin
  oGsCode:=pGsCode;  oPaCode:=pPaCode;
  oPceDes:=SysTxt('PlsPce','Cenn�kov� predajn� cena');
  case oPcePri of
    0: BstPceDet; // Ur��me najlepsiu cenu
    1: PriPceDet; // Ur��me cenu podla zadanej priority
  end;
end;

end.
