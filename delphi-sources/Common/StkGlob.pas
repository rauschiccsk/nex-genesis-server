unit StkGlob;

interface

uses
  IcTypes, IcConv, IcTools, IcFiles, IcVariab, TxtWrap, Key,
  NexGlob, NexIni, NexMsg, DefRgh, BookRight, BtrTable,
  NexError, NexPath, NexBtrTable, Math, Classes, SysUtils;

 function GetActQnt (pStkNum:word; pGsCode:longint): double; //Hodnota funkcie je aktualna skladova zasoba
 function GetFreQnt (pStkNum:word; pGsCode:longint): double; //Hodnota funkcie je volne mnozstvo na predaj v sklade
 function GetFifQnt (pGsCode:longint): double; //Hodnota funkcie je volne mnozstvo na FIFO karte
 function GetMgProfit (pMgCode:longint): double;  // Hodnota funkcie je doporuceny zisk zadanej tvoarovej skupiny
 // Pri volani fuunkcie databazovy subor dmDLS.btMGLST musi byt otvoreny
 function GetWriNum (pStkNum:word): word;  // Funkcia vrati cislo prevadzky na zaklade zadaneho cisla skladu
 function GetPlsNum (pStkNum:word): word;  // Funkcia vrati cislo cennika na zaklade zadaneho cisla skladu
 function GetPayName (pPayCode:Str3): Str20;  // Funkcia vrati nazov formy uhrady kod ktoreho sa zadava v pPayCode
 function GetTrsName (pTrsCode:Str3): Str20;  // Funkcia vrati nazov sposobu dopravy kod ktoreho sa zadava v pTrsCode
 function GetBankName (pBankCode:Str4): Str30;  // Funkcia vrati nazov namky kod ktoreho sa zadava v pBankCode
 function GetSwftCode (pBankCode:Str4): Str30;  // Funkcia vrati SWIFT/BIC kod banky
 function GetCtyName (pCtyCode:Str3): Str30;  // Funkcia vrati nazov obce kod ktoreho sa zadava v pCtyCode
 function GetStaName (pStaCode:Str2): Str30;  // Funkcia vrati nazov statu kod ktoreho sa zadava v pStaCode
 function GetMgName (pMgCode:word): Str30;  // Funkcia vrati nazov tvoarovej skupiny
 function GetPaName (pPaCode:word): Str30;  // Funkcia vrati nazov firmy
 function GetDlrName(pDlrCode:word): Str30;  // Funkcia vrati nazov obchodneho zastupcu
 function GetFgName (pFgCode:word): Str30;  // Funkcia vrati nazov financnej skupiny
 function GetGsType (pgsCode:longint): Str1;  // Funkcia vrati Typ tovaru
 function GetPlsStkNum (pPlsNum:word): word;  // Funkcia vrati cislo skladu zadaneho cennika

 function GetCPrice (pStkNum:word;pGsCode:longint; var pActQnt:double):double; // Funkcia vrati nakupnu cenu (priemernu alebo poslednu) zo zadaneho skladu

 function VatPrcVerify (pVatPrc:double):boolean; // TRUE ak zadana precentualna sadba je platna alebo bola niekedy platna
 function GetAfcQnt(pGsCode:longint):double; // Pocet priradenuch poukazok PHM - MOUNTFIELD

 function RoundBPrice (pBPrice:double;pRndType:byte):double; //Zaokruhli BPrice pod2a pRndType
// function RoundBPriceWithPls (pBPrice:double;pPlsNum:word):double; //Zaokruhli BPrice podla nastavenia zadaneho ceniika
 function CalcAPrice (pVatPrc,pBPrice:double):double; // Vypocita APrice podla pBPrice a pVatPrc
 function CalcBPriceFromCPrice (pCPrice,pProfit,pVatPrc:double):double; // Vypocita BPrice a
 function CalcProfPrc (pCPrice,pAPrice:double):double; // Vypocita Profit podla pCPrice a pAPrice

 function StkExist(pStkNum:word):boolean; // TRUE ak sklad existuje
// function MinPrfVer(pProfit:double):boolean; // TRUE ak je zadana marza vacsia alebo sa rovana minimalnej marze daneho uzivatela
 function MinBpcVer(pStkNum,pGsCode:longint;pBprice:double;var pMinBpc:double):boolean; // Kontroluje èi zadaná cena nie je pod minimálnou predajnou cenou. TRUE ak zadan8 predajn8 cena je ni63ia ako minim8lna

 procedure AddGscToPls (pProfit,pAPrice,pBPrice:double; pStkNum:word; pOpenGs:boolean);
(*
 procedure AddPlsToRef(pCommand:Str1;pPlsNum:word;btPLS:TNexBtrTable); // Ulozi zaznam z PLS kde stoji kurzor do vsetkych pokladnic, ktore pouzivaju dany cennik
*)
 procedure AddBacToRef(pCommand:Str1); // Ulozi zaznam z BARCODE kde stoji kurzor do vsetkych pokladnic, ktore pouzivaju dany cennik
 // Prida tovar z bazovej evidencii do cennika so zadanymi hodnotami
// function OcdQntCalcInSto (pGsCode:longint):double; // Hodnota funkcie je rezervacia na obchodne zakazky vypocitane z STO
 function SalQntCalcInSto (pGsCode:longint):double; // Hodnota funkcie je rezervacia na ERP vypocitane z STS
// function ScdQntCalcInSto (pGsCode:longint):double; // Hodnota funkcie je rezervacia na servisne zakazky vypocitane z STO
// function NrsQntCalcInSto (pGsCode:longint):double; // Hodnota funkcie je pozadovane mnozstvo na objednavanie
// function ImrQntCalcInSto (pGsCode:longint):double; // Hodnota funkcie je mnozstvo objednane prijemkou
// function OsrQntCalcInSto (pGsCode:longint):double; // Hodnota funkcie je rezervovane mnozsvo z objednavok
 function  Sts_Clear      (pGsCode:longint;pSalDate:TDateTime;pCasnum:longint):boolean;
 procedure Sts_SubQnt     (pGsCode:longint;pSalDate:TDateTime;pCasnum:longint;pSalQnt:double);
 procedure Sts_AddQnt     (pGsCode:longint;pSalDate:TDateTime;pCasnum:longint;pSalQnt:double);
 procedure Sts_SetQnt     (pGsCode:longint;pSalDate:TDateTime;pCasnum:longint;pSalQnt:double;pStkNum:word);
// procedure ImiToSto       (pImi:TBtrieveTable);

 procedure StcRecalcFromStm(pGsCode:longint); // Prepocita aktualnu skladovu kartu na zaklade skladovych pohybov
          // ak je pGsCode=0 tak tak nehlada PLU ale bere aktualnu kartu podla btSTK
 procedure StcRecalcFromFif ; // Prepocita aktualnu skladovu kartu na zaklade FIFO
(*
 procedure OsdRecalcFromSto (pGsCode:longint); // Vypocita hodnotu pola OsdQnt z databaze STO a ulozi na skladove karty
 procedure OcdRecalcFromSto (pGsCode:longint); // Vypocita hodnotu pola OcdQnt a NrsQnt z databaze STO a ulozi na skladove karty
 procedure ImdRecalcFromSto (pGsCode:longint); // Vypocita hodnotu pola ImrQnt z databaze STO a ulozi na skladove karty
 procedure DelSciFromSto (pDocNum:Str12;pItmNum,pGsCode:longint);
 procedure DelImiFromSto (pDocNum:Str12;pItmNum,pGsCode:longint);
*)
 procedure StpOutPdnClear (pStkNum:word; pDocNum:Str12; pItmNum:longint); // Vymaze vydaj vyrobneho cisla zadanej polozky vydajoveho dokladu

 procedure AddTciToPcc; // Prida aktualnu polozku do obaloveho konta
 procedure DelTciFromPcc; // Zrusi aktualnu polozku z obaloveho konta
 function  StmIsBegMov(pStm:TBtrieveTable):boolean;

implementation

uses DM_STKDAT, DM_DLSDAT, DM_CABDAT, DB, Dat, Pcf;

function GetActQnt (pStkNum:word; pGsCode:longint): double; //Hodnota funkcie je aktualna skladova zasoba
begin
  Result:=0;
  If dmSTK.GetActStkNum<>pStkNum then dmSTK.OpenStkFiles (pStkNum);
  dmSTK.btSTK.IndexName:='GsCode';
//  dmSTK.btSTO.IndexName:='DoIt';
  If dmSTK.btSTK.FindKey ([pGsCode]) then Result:=Result+dmSTK.btSTK.FieldByName ('ActQnt').AsFloat;
end;

function GetFreQnt (pStkNum:word; pGsCode:longint): double; //Hodnota funkcie je volne mnozstvo na predaj v sklade
begin
  Result:=0;
  If dmSTK.GetActStkNum<>pStkNum then dmSTK.OpenStkFiles (pStkNum);
  dmSTK.btSTK.IndexName:='GsCode';
//  dmSTK.btSTO.IndexName:='DoIt';
  If dmSTK.btSTK.FindKey ([pGsCode]) then Result:=Result+dmSTK.btSTK.FieldByName ('FreQnt').AsFloat;
end;

function GetFifQnt (pGsCode:longint): double; //Hodnota funkcie je volne mnozstvo na na FIFO karte
begin
  Result:=0;
  dmSTK.btFIF.SwapStatus;
  dmSTK.btFIF.IndexName:='GsCode';
  If dmSTK.btFIF.FindKey ([pGsCode]) then begin
    Repeat
      Result:=Result+dmSTK.btFIF.FieldByName ('ActQnt').AsFloat;
      dmSTK.btFIF.Next;
    until (dmSTK.btFIF.Eof) or (dmSTK.btFIF.FieldByname('GsCode').AsInteger<>pGsCode)
  end;
  dmSTK.btFIF.RestoreStatus;
end;

function GetMgProfit (pMgCode:longint): double;
begin
  Result:=0;
  If dmSTK.btMGLST.IndexName<>'MgCode' then dmSTK.btMGLST.IndexName:='MgCode';
  If dmSTK.btMGLST.FindKey ([pMgCode]) then Result:=dmSTK.btMGLST.FieldByName ('Profit').AsFloat;
end;

function GetWriNum (pStkNum:word): word;
var oMyOpen: boolean;
begin
  If cNexStart then Result:=1
  else begin
    Result:=0;
    oMyOpen:=not dmSTK.btSTKLST.Active;
    If oMyOpen
      then dmSTK.btSTKLST.Open
      else dmSTK.btSTKLST.SwapIndex;
    If dmSTK.btSTKLST.IndexName<>'StkNum' then dmSTK.btSTKLST.IndexName:='StkNum';
    If dmSTK.btSTKLST.FindKey ([pStkNum]) then Result:=dmSTK.btSTKLST.FieldByName ('WriNum').AsInteger;
    If oMyOpen
      then dmSTK.btSTKLST.Close
      else dmSTK.btSTKLST.RestoreIndex;
  end;
end;

function GetPlsNum (pStkNum:word): word;
var oMyOpen: boolean;
begin
  If cNexStart then Result:=1
  else begin
    Result:=1;
    oMyOpen:=not dmSTK.btSTKLST.Active;
    If oMyOpen
      then dmSTK.btSTKLST.Open
      else dmSTK.btSTKLST.SwapIndex;
    If dmSTK.btSTKLST.IndexName<>'StkNum' then dmSTK.btSTKLST.IndexName:='StkNum';
    If dmSTK.btSTKLST.FindKey ([pStkNum]) then Result:=dmSTK.btSTKLST.FieldByName ('PlsNum').AsInteger;
    If oMyOpen
      then dmSTK.btSTKLST.Close
      else dmSTK.btSTKLST.RestoreIndex;
  end;
end;

function GetPlsStkNum (pPlsNum:word): word;
var oMyOpen: boolean;
begin
  If cNexStart then Result:=1
  else begin
    Result:=0;
    oMyOpen:=not dmSTK.btPLSLST.Active;
    If oMyOpen
      then dmSTK.btPLSLST.Open
      else dmSTK.btPLSLST.SwapIndex;
    If dmSTK.btPLSLST.IndexName<>'PlsNum' then dmSTK.btPLSLST.IndexName:='PlsNum';
    If dmSTK.btPLSLST.FindKey ([pPlsNum]) then Result:=dmSTK.btPLSLST.FieldByName ('StkNum').AsInteger;
    If oMyOpen
      then dmSTK.btPLSLST.Close
      else dmSTK.btPLSLST.RestoreIndex;
    If Result = 0 then Result:=gIni.MainStk;
  end;
end;

function GetPayName (pPayCode:Str3): Str20;  // Funkcia vrate nazov formy uhrady kod ktoreho sa zadava v pPayCode
var mMyOp:boolean;
begin
  Result:='';
  mMyOp:=not dmDLS.btPAYLST.Active;
  If mMyOp
    then dmDLS.btPAYLST.Open
    else dmDLS.btPAYLST.SwapIndex;
  If dmDLS.btPAYLST.IndexName<>'PayCode' then dmDLS.btPAYLST.IndexName:='PayCode';
  If dmDLS.btPAYLST.FindKey ([pPayCode]) then Result:=dmDLS.btPAYLST.FieldByName ('PayName').AsString;
  If mMyOp
    then dmDLS.btPAYLST.Close
    else dmDLS.btPAYLST.RestoreIndex;
end;

function GetTrsName (pTrsCode:Str3): Str20;  // Funkcia vrate nazov sposobu dopravy kod ktoreho sa zadava v pTrsCode
var mMyOp:boolean;
begin
  Result:='';
  mMyOp:=not dmDLS.btTRSLST.Active;
  If mMyOp
    then dmDLS.btTRSLST.Open
    else dmDLS.btTRSLST.SwapIndex;
  If dmDLS.btTRSLST.IndexName<>'TrsCode' then dmDLS.btTRSLST.IndexName:='TrsCode';
  If dmDLS.btTRSLST.FindKey ([pTrsCode]) then Result:=dmDLS.btTRSLST.FieldByName ('TrsName').AsString;
  If mMyOp
    then dmDLS.btTRSLST.Close
    else dmDLS.btTRSLST.RestoreIndex;
end;

function GetBankName (pBankCode:Str4): Str30;  // Funkcia vrate nazov namky kod ktoreho sa zadava v pBankCode
var mMyOp:boolean;
begin
  Result:='';
  mMyOp:=not dmDLS.btBANKLST.Active;
  If mMyOp
    then dmDLS.btBANKLST.Open
    else dmDLS.btBANKLST.SwapIndex;
  If dmDLS.btBANKLST.IndexName<>'BankCode' then dmDLS.btBANKLST.IndexName:='BankCode';
  If dmDLS.btBANKLST.FindKey ([pBankCode]) then Result:=dmDLS.btBANKLST.FieldByName ('BankName').AsString;
  If mMyOp
    then dmDLS.btBANKLST.Close
    else dmDLS.btBANKLST.RestoreIndex;
end;

function GetSwftCode   (pBankCode:Str4): Str30;  // Funkcia vrati SWIFT/BIC kod banky
var mMyOp:boolean;
begin
  Result:='';
  mMyOp:=not dmDLS.btBANKLST.Active;
  If mMyOp
    then dmDLS.btBANKLST.Open
    else dmDLS.btBANKLST.SwapIndex;
  If dmDLS.btBANKLST.IndexName<>'BankCode' then dmDLS.btBANKLST.IndexName:='BankCode';
  If dmDLS.btBANKLST.FindKey ([pBankCode]) then Result:=dmDLS.btBANKLST.FieldByName ('SwftCode').AsString;
  If mMyOp
    then dmDLS.btBANKLST.Close
    else dmDLS.btBANKLST.RestoreIndex;
  If (Result='') and (gBankCodeSwift.IndexOfName(pBankCode)>-1)
    then Result:=gBankCodeSwift.Values[pBankCode];
end;


function GetCtyName (pCtyCode:Str3): Str30;  // Funkcia vrate nazov obce kod ktoreho sa zadava v pCtyCode
var mMyOp:boolean;
begin
  Result:='';
  mMyOp:=not dmDLS.btCTYLST.Active;
  If mMyOp
    then dmDLS.btCTYLST.Open
    else dmDLS.btCTYLST.SwapIndex;
  If dmDLS.btCTYLST.IndexName<>'CtyCode' then dmDLS.btCTYLST.IndexName:='CtyCode';
  If dmDLS.btCTYLST.FindKey ([pCtyCode]) then Result:=dmDLS.btCTYLST.FieldByName ('CtyName').AsString;
  If mMyOp
    then dmDLS.btCTYLST.Close
    else dmDLS.btCTYLST.RestoreIndex;
end;

function GetStaName (pStaCode:Str2): Str30;  // Funkcia vrate nazov statu kod ktoreho sa zadava v pCtyCode
var mMyOp:boolean;
begin
  Result:='';
  mMyOp:=not dmDLS.btSTALST.Active;
  If mMyOp
    then dmDLS.btSTALST.Open
    else dmDLS.btSTALST.SwapIndex;
  If dmDLS.btSTALST.IndexName<>'StaCode' then dmDLS.btSTALST.IndexName:='StaCode';
  If dmDLS.btSTALST.FindKey ([pStaCode]) then Result:=dmDLS.btSTALST.FieldByName ('StaName').AsString;
  If mMyOp
    then dmDLS.btSTALST.Close
    else dmDLS.btSTALST.RestoreIndex;
end;

function GetMgName (pMgCode:word): Str30;  // Funkcia vrati nazov tvoarovej skupiny
var mMyOp:boolean;
begin
  Result:='';
  mMyOp:=not dmSTK.btMGLST.Active;
  If mMyOp
    then dmSTK.btMGLST.Open
    else dmSTK.btMGLST.SwapIndex;
  If dmSTK.btMGLST.IndexName<>'MgCode' then dmSTK.btMGLST.IndexName:='MgCode';
  If dmSTK.btMGLST.FindKey ([pMgCode]) then Result:=dmSTK.btMGLST.FieldByName ('MgName').AsString;
  If mMyOp
    then dmSTK.btMGLST.Close
    else dmSTK.btMGLST.RestoreIndex;
end;

function GetPaName (pPaCode:word): Str30;  // Funkcia vrati nazov Firmy
var mMyOp:boolean;
begin
  Result:='';
  mMyOp:=not dmDls.btPABCAT.Active;
  If mMyOp
    then dmDls.btPABCAT.Open
    else dmDls.btPABCAT.SwapIndex;
  If dmDls.btPABCAT.IndexName<>'PaCode' then dmDls.btPABCAT.IndexName:='PaCode';
  If dmDls.btPABCAT.FindKey ([pPaCode]) then Result:=dmDls.btPABCAT.FieldByName ('PaName').AsString;
  If mMyOp
    then dmDls.btPABCAT.Close
    else dmDls.btPABCAT.RestoreIndex;
end;

function GetDlrName(pDlrCode:word): Str30;  // Funkcia vrati nazov obchodneho zastupcu
var mMyOp:boolean; // DLRLST.BDF
begin
  Result:='';
  mMyOp:=not dmDls.btDLRLST.Active;
  If mMyOp
    then dmDls.btDLRLST.Open
    else dmDls.btDLRLST.SwapIndex;
  If dmDls.btDLRLST.IndexName<>'DlrCode' then dmDls.btDLRLST.IndexName:='DlrCode';
  If dmDls.btDLRLST.FindKey ([pDlrCode]) then Result:=dmDls.btDLRLST.FieldByName ('DlrName').AsString;
  If mMyOp
    then dmDls.btDLRLST.Close
    else dmDls.btDLRLST.RestoreIndex;
end;

function GetFgName (pFgCode:word): Str30;  // Funkcia vrati nazov financnej skupiny
var mMyOp:boolean;
begin
  Result:='';
  mMyOp:=not dmSTK.btFGLST.Active;
  If mMyOp
    then dmSTK.btFGLST.Open
    else dmSTK.btFGLST.SwapIndex;
  If dmSTK.btFGLST.IndexName<>'FgCode' then dmSTK.btFGLST.IndexName:='FgCode';
  If dmSTK.btFGLST.FindKey ([pFgCode]) then Result:=dmSTK.btFGLST.FieldByName ('FgName').AsString;
  If mMyOp
    then dmSTK.btFGLST.Close
    else dmSTK.btFGLST.RestoreIndex;
end;

function GetGsType (pGsCode:longint): Str1;  // Funkcia vrati Typ tovaru
var mMyOp:boolean;
begin
  Result:='';
  mMyOp:=not dmSTK.btGSCAT.Active;
  If mMyOp
    then dmSTK.btGSCAT.Open
    else dmSTK.btGSCAT.SwapIndex;
  If dmSTK.btGSCAT.IndexName<>'GsCode' then dmSTK.btGSCAT.IndexName:='GsCode';
  If dmSTK.btGSCAT.FindKey ([pGsCode]) then Result:=dmSTK.btGSCAT.FieldByName ('GsType').AsString;
  If mMyOp
    then dmSTK.btGSCAT.Close
    else dmSTK.btGSCAT.RestoreIndex;
end;

function GetCPrice (pStkNum:word;pGsCode:longint; var pActQnt:double):double; // Funkcia vrati nakupnu cenu (priemernu alebo poslednu) zo zadaneho skladu
var mMyOp:boolean;  mStkNum: word;
begin
  Result:=0;  pActQnt:=0;
  mMyOp:=not dmSTK.btSTK.Active;
  If mMyOp then dmSTK.OpenSTK (pStkNum); // Ak sklad nie je otvoreny potom otvorime
  mStkNum:=dmSTK.GetActStkNum;
  If pStkNum<>dmSTK.GetActStkNum then dmSTK.OpenSTK (pStkNum); // Ak je otvoreny iny sklad potom otvorime zadany sklad pStkNam
  dmSTK.btSTK.SwapStatus;
  If dmSTK.btSTK.IndexName<>'GsCode' then dmSTK.btSTK.IndexName:='GsCode';
  If dmSTK.btSTK.FindKey ([pGsCode]) then begin // Ak sme nasli tovr nacitame nakupnu cenu
    If gIni.GetUseLastPrice
      then Result:=dmSTK.btSTK.FieldByName ('LastPrice').AsFloat
      else Result:=dmSTK.btSTK.FieldByName ('AvgPrice').AsFloat;
    pActQnt:=dmSTK.btSTK.FieldByName ('ActQnt').AsFloat;
  end;
  dmSTK.btSTK.RestoreStatus;
  If mStkNum<>dmSTK.GetActStkNum then dmSTK.OpenSTK (pStkNum); // Otvorime povodny sklad
  If mMyOp then dmSTK.btSTK.Close;
end;

function RoundBPrice (pBPrice:double;pRndType:byte):double; //Zaokruhli BPrice pod2a pRndType
begin
  case pRndType of
    0: Result:=RoundX (pBPrice, 2); // na 0.01
    1: Result:=RoundX (pBPrice, 1); // na 0.10
    2: Result:=RoundX (pBPrice, 0);  // na 1,-
    3: Result:=RoundX (pBPrice,-1);  // na 10,-
    4: Result:=RoundX (pBPrice,-2);  // na 100,-
    5: Result:=RoundX (pBPrice,-3);  // na 1000,-
    6: // Podla tabylky
  end;
end;

function VatPrcVerify (pVatPrc:double):boolean; // TRUE ak zadana precentualna sadba je platna alebo bola niekedy platna
var I:byte;
begin
  Result:=FALSE;
  For I:=1 to 8 do
    If Eq1 (gIni.GetSumVatPrc(I),pVatPrc) then Result:=TRUE;
  If not Result then ShowMsg (ecGscInvalidVatPrc,StrDoub(pVatPrc,0,0));
end;

function GetAfcQnt(pGsCode:longint):double; // TRUE ak tovarou je priradena poukazka PHM - MOUNTFIELD
begin
  Result:=0;
  If dmSTK.btAFC.FindKey ([pGsCode]) then Result:=dmSTK.btAFC.FieldByName ('AfcQnt').AsFloat;
end;

(*
function RoundBPriceWithPls (pBPrice:double;pPlsNum:word):double; //Zaokruhli BPrice podla nastavenia zadaneho ceniika
begin
  If dmSTK.btPLSLST.FieldByName('PlsNum').AsInteger<>pPlsNum then begin
    If dmSTK.btPLSLST.IndexName<>'PlsNum' then dmSTK.btPLSLST.IndexName:='PlsNum';
    dmSTK.btPLSLST.FindKey([pPlsNum]);
  end;
  Result:=RoundBPrice (pBPrice,dmSTK.btPLSLST.FieldByName('RndType').AsInteger);
end;
*)
function CalcAPrice (pVatPrc,pBPrice:double):double; // Vypocita APrice podla pBPrice a pVatPrc
begin
  Result:=pBPrice/(1+pVatPrc/100);
end;

function CalcBPriceFromCPrice (pCPrice,pProfit,pVatPrc:double):double; // Vypocita BPrice a zaokruhli podla nastavenia zadaneho cennika
begin
  Result:=pCPrice*(1+pProfit/100)*(1+pVatPrc/100);
end;

function CalcProfPrc (pCPrice,pAPrice:double):double; // Vypocita Profit podla pCPrice a pAPrice
begin
  If not Eq3 (pCPrice,0)
    then Result:=((pAPrice/pCPrice)-1)*100
    else Result:=0;
end;

function StkExist (pStkNum:word):boolean; // TRUE ak sklad existuje
var mMyOp:boolean;
begin
  mMyOp:=not dmSTK.btSTKLST.Active;
  If mMyOp
    then dmSTK.btSTKLST.Open
    else dmSTK.btSTKLST.SwapStatus;
  If dmSTK.btSTKLST.IndexName<>'StkNum' then dmSTK.btSTKLST.IndexName:='StkNum';
  Result:=dmSTK.btSTKLST.FindKey([pStkNum]);
  If not Result then ShowMsg (ecStkIsNotExistInStkLst,StrInt(pStkNum,0));
  If mMyOp
    then dmSTK.btSTKLST.Close
    else dmSTK.btSTKLST.RestoreStatus;
end;

(*
function MinPrfVer (pProfit:double):boolean; // TRUE ak je zadana marza vacsia alebo sa rovana minimalnej marze daneho uzivatela
begin
  Result:=(pProfit>=gRgh.MinPrf) or (gRgh.MinPrf=0);
  If not Result then ShowMsg (ecSysProfitIsGrMinPrf,StrDoub(pProfit,0,1)+'|'+StrDoub(gRgh.MinPrf,0,1));
end;
*)

function MinBpcVer(pStkNum,pGsCode:longint;pBprice:double; var pMinBpc:double):boolean;
var mPcf:TPcf;  mDat:TDat;
begin
  Result:=FALSE;
  mDat:=TDat.Create;
  mPcf:=TPcf.Create(mDat);
  pMinBpc:=mPcf.MinBpc[pStkNum,pGsCode];
  If (mPcf.PceSrc<>'AC') or (not gKey.Whs.MpcApc and (mPcf.PceSrc='AC')) then begin
    If pBprice<pMinBpc then begin
      Result:=TRUE;
      ShowMsg(ecAtpSalBlwMinBpc,StrDoub(pMinBpc,0,2));
    end;
  end;
  FreeAndNil(mDat);
end;

procedure AddGscToPls (pProfit,pAPrice,pBPrice:double; pStkNum:word; pOpenGs:boolean);
begin
  dmSTK.btPLS.Insert;
  dmSTK.btPLS.FieldByName ('GsCode').AsInteger:=dmSTK.btGSCAT.FieldByName ('GsCode').AsInteger;
  dmSTK.btPLS.FieldByName ('GsName').AsString:=dmSTK.btGSCAT.FieldByName ('GsName').AsString;
  dmSTK.btPLS.FieldByName ('MgCode').AsInteger:=dmSTK.btGSCAT.FieldByName ('MgCode').AsInteger;
  dmSTK.btPLS.FieldByName ('BarCode').AsString:=dmSTK.btGSCAT.FieldByName ('BarCode').AsString;
  dmSTK.btPLS.FieldByName ('StkCode').AsString:=dmSTK.btGSCAT.FieldByName ('StkCode').AsString;
  dmSTK.btPLS.FieldByName ('MsName').AsString:=dmSTK.btGSCAT.FieldByName ('MsName').AsString;
  dmSTK.btPLS.FieldByName ('PackGs').AsInteger:=dmSTK.btGSCAT.FieldByName ('PackGs').AsInteger;
  dmSTK.btPLS.FieldByName ('StkNum').AsInteger:=pStkNum;
  dmSTK.btPLS.FieldByName ('VatPrc').AsFloat:=dmSTK.btGSCAT.FieldByName ('VatPrc').AsFloat;
  dmSTK.btPLS.FieldByName ('GsType').AsString:=dmSTK.btGSCAT.FieldByName ('GsType').AsString;
  dmSTK.btPLS.FieldByName ('DrbMust').AsInteger:=dmSTK.btGSCAT.FieldByName ('DrbMust').AsInteger;
  dmSTK.btPLS.FieldByName ('PdnMust').AsInteger:=dmSTK.btGSCAT.FieldByName ('PdnMust').AsInteger;
  dmSTK.btPLS.FieldByName ('GrcMth').AsInteger:=dmSTK.btGSCAT.FieldByName ('GrcMth').AsInteger;
  dmSTK.btPLS.FieldByName ('OpenGs').AsInteger:=Integer(pOpenGs);
  dmSTK.btPLS.FieldByName ('Profit').AsFloat:=pProfit;
  dmSTK.btPLS.FieldByName ('APrice').AsFloat:=pAPrice;
  dmSTK.btPLS.FieldByName ('BPrice').AsFloat:=pBPrice;
  dmSTK.btPLS.FieldByName ('DisFlag').AsInteger:=dmSTK.btGSCAT.FieldByName ('DisFlag').AsInteger;
  dmSTK.btPLS.FieldByName ('ChgItm').AsString:='X';
  dmSTK.btPLS.Post;
end;
(*
procedure AddPlsToRef(pCommand:Str1;pPlsNum:word;btPLS:TNexBtrTable); // Ulozi zaznam z PLS kde stoji kurzor do vsetkych pokladnic, ktore pouzivaju dany cennik
var mWrap:TTxtWrap;  mRef:TStrings;  mFileName:string;  mMyOp:boolean;
begin
  If gIni.PosRefresh then begin
    mMyOp:=not dmCAB.btCABLST.Active;
    // Ulozime REf subor pre kazdu pokladnu
    If mMyOp then dmCAB.btCABLST.Open;
    If dmCAB.btCABLST.RecordCount>0 then begin
      mRef:=TStringList.Create;
      mWrap:=TTxtWrap.Create;
      mWrap.ClearWrap;
      mWrap.SetText (pCommand,1);                                     //  1
      mWrap.SetNum (btPLS.FieldByName('GsCode').AsInteger,0);   //  2
      mWrap.SetText (WinStringToDosString(btPLS.FieldByName('GsName').AsString),0);   //  3
      mWrap.SetNum (btPLS.FieldByName('MgCode').AsInteger,0);   //  4
      mWrap.SetNum (btPLS.FieldByName('FgCode').AsInteger,0);   //  5
      mWrap.SetText (btPLS.FieldByName('BarCode').AsString,0);  //  6
      mWrap.SetText (btPLS.FieldByName('StkCode').AsString,0);  //  7
      mWrap.SetText (btPLS.FieldByName('MsName').AsString,0);   //  8
      mWrap.SetNum (btPLS.FieldByName('PackGs').AsInteger,0);   //  9
      mWrap.SetNum (btPLS.FieldByName('StkNum').AsInteger,0);   // 10
      mWrap.SetNum (btPLS.FieldByName('VatPrc').AsInteger,0);   // 11
      mWrap.SetNum (btPLS.FieldByName('PdnMust').AsInteger,0);  // 12
      mWrap.SetNum (btPLS.FieldByName('GrcMth').AsInteger,0);   // 13
      mWrap.SetReal (btPLS.FieldByName('Profit').AsFloat,0,2);  // 14
      mWrap.SetReal (btPLS.FieldByName('APrice').AsFloat,0,2);  // 15
      mWrap.SetReal (btPLS.FieldByName('BPrice').AsFloat,0,2);  // 16
      mWrap.SetNum (btPLS.FieldByName('OrdPrn').AsInteger,0);   // 17
      mWrap.SetNum (btPLS.FieldByName('OpenGs').AsInteger,0);   // 18
      dmCAB.btCABLST.First;
      Repeat
        mRef.Clear;
        If (dmCAB.btCABLST.FieldByName('PlsNum').AsInteger=pPlsNum) or (dmCAB.btCABLST.FieldByName('PlsNum').AsInteger=0) then begin
          mFileName:=gPath.CasPath(dmCAB.btCABLST.FieldByname('CasNum').AsInteger)+'PLS'+StrIntZero(dmSTK.GetActPlsNum,5)+'.REF';
          If FileExist (mFileName) then mRef.LoadFromFile (mFileName);
          mRef.Add (mWrap.GetWrapText);
          mRef.SaveToFile (mFileName);
        end;
        dmCAB.btCABLST.Next;
      until (dmCAB.btCABLST.Eof);
      FreeAndNil (mWrap);
      FreeAndNil (mRef);
    end;
    If mMyOp then dmCAB.btCABLST.Close;
  end;
end;
*)

procedure AddBacToRef(pCommand:Str1); // Ulozi zaznam z BARCODE kde stoji kurzor do vsetkych pokladnic, ktore pouzivaju dany cennik
var mWrap:TTxtWrap;  mRef:TStrings;  mPath,mFileName:string;  mMyOp:boolean;
    mCnt:word;  mFileExt:Str4;  mFind:boolean;
begin
  If gIni.PosRefresh then begin
    mMyOp:=not dmCAB.btCABLST.Active;
    // Ulozime REf subor pre kazdu pokladnu
    If mMyOp then dmCAB.btCABLST.Open;
    If dmCAB.btCABLST.RecordCount>0 then begin
      mRef:=TStringList.Create;
      mWrap:=TTxtWrap.Create;
      mWrap.ClearWrap;
      mWrap.SetText (pCommand,1);                                        //  1
      mWrap.SetText (dmSTK.btBARCODE.FieldByName('BarCode').AsString,0); //  2
      mWrap.SetNum (dmSTK.btBARCODE.FieldByName('GsCode').AsInteger,0);  //  3
      Repeat
        mRef.Clear;
        mPath:=gPath.CasPath(dmCAB.btCABLST.FieldByname('CasNum').AsInteger);
        mFileName:='BARCODE';
        If gIni.PosRefFile then begin
          If FileExistsI (mPath+mFileName+'.REF') then RenameFile (mPath+mFileName+'.REF',mPath+mFileName+'.TMP');
          If FileExistsI (mPath+mFileName+'.TMP') then mRef.LoadFromFile (mPath+mFileName+'.TMP');
          mRef.Add (mWrap.GetWrapText);
          mRef.SaveToFile (mPath+mFileName+'.TMP');
          RenameFile (mPath+mFileName+'.TMP',mPath+mFileName+'.REF');
        end
        else begin // Po urcitom case zrusit - napr. po zavedeni ERU
          mCnt:=0;
          Repeat
            mFileExt:='.'+StrIntZero(mCnt,3);
            mFind:=FileExistsI (mPath+mFileName+mFileExt);
            If mFind then Inc (mCnt);
          until not mFind;
          mRef.Add (mWrap.GetWrapText);
          mRef.SaveToFile (mPath+'BCF.TMP');
          RenameFile (mPath+'BCF.TMP',mPath+mFileName+mFileExt);
        end;
        dmCAB.btCABLST.Next;
      until (dmCAB.btCABLST.Eof);
      FreeAndNil (mWrap);
      FreeAndNil (mRef);
    end;
    If mMyOp then dmCAB.btCABLST.Close;
  end;
end;

(*
function OcdQntCalcInSto (pGsCode:longint):double; // Hodnota funkcie je rezervacia na zakazkove doklady vypocitane z STO
begin
  // Vypocitame sucet rezervacii STO.BDF
  Result:=0;
  dmSTK.btSTO.SwapIndex;
  dmSTK.btSTO.IndexName:='GsOrSt';
  If dmSTK.btSTO.FindKey ([pGsCode,'C','R']) then begin
    Repeat
      Result:=Result+dmSTK.btSTO.FieldByName ('OrdQnt').AsFloat-dmSTK.btSTO.FieldByName ('DlvQnt').AsFloat;
      dmSTK.btSTO.Next;
    until (dmSTK.btSTO.Eof) or (dmSTK.btSTO.FieldByName('GsCode').AsInteger<>pGsCode) or (dmSTK.btSTO.FieldByName('OrdType').AsString<>'C') or (dmSTK.btSTO.FieldByName('StkStat').AsString<>'R');
  end;
  dmSTK.btSTO.RestoreIndex;
end;
*)

function SalQntCalcInSto (pGsCode:longint):double; // Hodnota funkcie je rezervacia na ERP vypocitane z STS
begin
  // Vypocitame sucet rezervacii  ERP STS.BDF
  Result:=0;
  If not dmStk.btSTS.Active then dmStk.btSTS.Open(dmStk.getActStkNum);
  dmSTK.btSTS.SwapStatus;
  dmSTK.btSTS.IndexName:='GsCode';
  If dmSTK.btSTS.FindKey ([pGsCode]) then begin
    Repeat
      Result:=Result+dmSTK.btSTS.FieldByName ('SalQnt').AsFloat;
      dmSTK.btSTS.Next;
    until (dmSTK.btSTS.Eof) or (dmSTK.btSTS.FieldByName('GsCode').AsInteger<>pGsCode);
  end;
  dmSTK.btSTS.RestoreStatus;
end;

function  Sts_Clear (pGsCode:longint;pSalDate:TDateTime;pCasnum:longint):boolean;
begin
  Result:=False;
  // vynuluje rezervacie tovaru ESP
  If not dmStk.btSTS.Active then dmStk.btSTS.Open(dmStk.getActStkNum);
  dmSTK.btSTS.SwapIndex;
  dmSTK.btSTS.IndexName:='GsCode';
  If dmSTK.btSTS.FindKey ([pGsCode]) then begin
    Repeat
      If  ((pSalDate=0) or (dmSTK.btSTS.FieldByName('SalDate').AsDateTime=pSalDate))
      and ((pCasNum =0) or (dmSTK.btSTS.FieldByName('CasNum').AsInteger=pCasNum))
        then begin dmSTK.btSTS.Delete; Result:=True;end
        else dmSTK.btSTS.Next;
    until (dmSTK.btSTS.Eof) or (dmSTK.btSTS.FieldByName('GsCode').AsInteger<>pGsCode);
  end;
  dmSTK.btSTS.RestoreIndex;
end;

procedure Sts_SubQnt (pGsCode:longint;pSalDate:TDateTime;pCasnum:longint;pSalQnt:double);
begin
  // vynuluje rezervacie tovaru ESP STS.BDF
  If not dmStk.btSTS.Active then dmStk.btSTS.Open(dmStk.getActStkNum);
  dmSTK.btSTS.SwapIndex;
  If pCasNum<>0 then begin
    dmSTK.btSTS.IndexName:='GcSdCn'; // GsCode,SalDate,CasNum=GcSdCn
    If not dmSTK.btSTS.FindKey ([pGsCode,pSalDate,pCasNum]) then begin
      dmSTK.btSTS.Insert;
      dmSTK.btSTS.fieldbyname('GsCode').AsInteger   :=pGsCode;
      dmSTK.btSTS.fieldbyname('SalDate').AsDateTime :=pSalDate;
      dmSTK.btSTS.fieldbyname('CasNum').AsInteger   :=pCasNum;
      dmSTK.btSTS.fieldbyname('SalQnt').AsFloat     :=0-pSalQnt;
      dmSTK.btSTS.fieldbyname('DocNum').AsString    :='';
      dmSTK.btSTS.fieldbyname('ItmNum').AsInteger   :=0;
      dmSTK.btSTS.Post;
    end else begin
      dmSTK.btSTS.Edit;
      dmSTK.btSTS.fieldbyname('SalQnt').AsFloat     :=dmSTK.btSTS.fieldbyname('SalQnt').AsFloat-pSalQnt;
      dmSTK.btSTS.Post;
    end;
  end else begin
    Sts_Clear (pGsCode,pSalDate,0);
  end;
  dmSTK.btSTS.RestoreIndex;
end;

procedure Sts_AddQnt (pGsCode:longint;pSalDate:TDateTime;pCasnum:longint;pSalQnt:double);
begin
  // vynuluje rezervacie tovaru ESP STS.BDF
  If not dmStk.btSTS.Active then dmStk.btSTS.Open(dmStk.getActStkNum);
  dmSTK.btSTS.SwapIndex;
    dmSTK.btSTS.IndexName:='GcSdCn'; // GsCode,SalDate,CasNum=GcSdCn
    If not dmSTK.btSTS.FindKey ([pGsCode,pSalDate,pCasNum]) then begin
      dmSTK.btSTS.Insert;
      dmSTK.btSTS.fieldbyname('GsCode').AsInteger   :=pGsCode;
      dmSTK.btSTS.fieldbyname('SalDate').AsDateTime :=pSalDate;
      dmSTK.btSTS.fieldbyname('CasNum').AsInteger   :=pCasNum;
      dmSTK.btSTS.fieldbyname('SalQnt').AsFloat     :=0+pSalQnt;
      dmSTK.btSTS.fieldbyname('DocNum').AsString    :='';
      dmSTK.btSTS.fieldbyname('ItmNum').AsInteger   :=0;
      dmSTK.btSTS.Post;
    end else begin
      dmSTK.btSTS.Edit;
      dmSTK.btSTS.fieldbyname('SalQnt').AsFloat     :=dmSTK.btSTS.fieldbyname('SalQnt').AsFloat+pSalQnt;
      dmSTK.btSTS.Post;
    end;
  dmSTK.btSTS.RestoreIndex;
end;

procedure Sts_SetQnt (pGsCode:longint;pSalDate:TDateTime;pCasnum:longint;pSalQnt:double;pStkNum:word);
begin
  If pStkNum>0 then begin
    dmStk.OpenStkFiles(pStkNum);
    If not dmStk.btSTS.Active or (dmStk.btSTS.ListNum<>pStkNum)
      then dmStk.btSTS.Open(dmStk.getActStkNum);
  end;
  // vynuluje rezervacie tovaru ESP STS.BDF
  If not dmStk.btSTS.Active then dmStk.btSTS.Open(dmStk.getActStkNum);
  dmSTK.btSTS.SwapIndex;
    dmSTK.btSTS.IndexName:='GcSdCn'; // GsCode,SalDate,CasNum=GcSdCn
    If not dmSTK.btSTS.FindKey ([pGsCode,pSalDate,pCasNum]) then begin
      dmSTK.btSTS.Insert;
      dmSTK.btSTS.fieldbyname('GsCode').AsInteger   :=pGsCode;
      dmSTK.btSTS.fieldbyname('SalDate').AsDateTime :=pSalDate;
      dmSTK.btSTS.fieldbyname('CasNum').AsInteger   :=pCasNum;
      dmSTK.btSTS.fieldbyname('SalQnt').AsFloat     :=pSalQnt;
      dmSTK.btSTS.fieldbyname('DocNum').AsString    :='';
      dmSTK.btSTS.fieldbyname('ItmNum').AsInteger   :=0;
      dmSTK.btSTS.Post;
    end else begin
      dmSTK.btSTS.Edit;
      dmSTK.btSTS.fieldbyname('SalQnt').AsFloat     :=pSalQnt;
      dmSTK.btSTS.Post;
    end;
  dmSTK.btSTS.RestoreIndex;
end;

(*
function ScdQntCalcInSto (pGsCode:longint):double; // Hodnota funkcie je rezervacia na servisne zakazky vypocitane z STO
begin
  // Vypocitame sucet rezervacii
  Result:=0;
  dmSTK.btSTO.SwapIndex;
  dmSTK.btSTO.IndexName:='GsOrSt';
  If dmSTK.btSTO.FindKey ([pGsCode,'X','R']) then begin
    Repeat
      Result:=Result+dmSTK.btSTO.FieldByName ('OrdQnt').AsFloat;
      dmSTK.btSTO.Next;
    until (dmSTK.btSTO.Eof) or (dmSTK.btSTO.FieldByName('GsCode').AsInteger<>pGsCode) or (dmSTK.btSTO.FieldByName('OrdType').AsString<>'X') or (dmSTK.btSTO.FieldByName('StkStat').AsString<>'R');
  end;
  dmSTK.btSTO.RestoreIndex;
end;

function NrsQntCalcInSto (pGsCode:longint):double; // Hodnota funkcie je pozadovane mnozstvo na objednavanie
begin
  // Vypocitame sucet rezervacii
  Result:=0;
  dmSTK.btSTO.IndexName:='GsOrSt';
  // Obchodne zakazky
  If dmSTK.btSTO.FindKey ([pGsCode,'C','N']) then begin
    Repeat
      Result:=Result+dmSTK.btSTO.FieldByName ('OrdQnt').AsFloat;
      dmSTK.btSTO.Next;
    until (dmSTK.btSTO.Eof) or (dmSTK.btSTO.FieldByName('GsCode').AsInteger<>pGsCode) or (dmSTK.btSTO.FieldByName('OrdType').AsString<>'C') or (dmSTK.btSTO.FieldByName('StkStat').AsString<>'N');
  end;
  // Servisne zakazky
  If dmSTK.btSTO.FindKey ([pGsCode,'X','N']) then begin
    Repeat
      Result:=Result+dmSTK.btSTO.FieldByName ('OrdQnt').AsFloat;
      dmSTK.btSTO.Next;
    until (dmSTK.btSTO.Eof) or (dmSTK.btSTO.FieldByName('GsCode').AsInteger<>pGsCode) or (dmSTK.btSTO.FieldByName('OrdType').AsString<>'X') or (dmSTK.btSTO.FieldByName('StkStat').AsString<>'N');
  end;
end;

function ImrQntCalcInSto (pGsCode:longint):double; // Hodnota funkcie je pozadovane mnozstvo na objednavanie
begin
  // Vypocitame sucet rezervacii
  Result:=0;
  dmSTK.btSTO.IndexName:='GsOrSt';
  // Prijemky TOVAR NA CESTE
  If dmSTK.btSTO.FindKey ([pGsCode,'M','M']) then begin
    Repeat
      Result:=Result+dmSTK.btSTO.FieldByName ('OrdQnt').AsFloat;
      dmSTK.btSTO.Next;
    until (dmSTK.btSTO.Eof) or (dmSTK.btSTO.FieldByName('GsCode').AsInteger<>pGsCode) or (dmSTK.btSTO.FieldByName('OrdType').AsString<>'M') or (dmSTK.btSTO.FieldByName('StkStat').AsString<>'M');
  end;
end;

function OsrQntCalcInSto (pGsCode:longint):double; // Hodnota funkcie je pozadovane mnozstvo na objednavanie
begin
  // Vypocitame sucet rezervacii
  Result:=0;
  dmSTK.btSTO.IndexName:='GsOrSt';
  // Obchodne zakazky
  If dmSTK.btSTO.FindKey ([pGsCode,'C','O']) then begin
    Repeat
      Result:=Result+dmSTK.btSTO.FieldByName ('OrdQnt').AsFloat;
      dmSTK.btSTO.Next;
    until (dmSTK.btSTO.Eof) or (dmSTK.btSTO.FieldByName('GsCode').AsInteger<>pGsCode) or (dmSTK.btSTO.FieldByName('OrdType').AsString<>'C') or (dmSTK.btSTO.FieldByName('StkStat').AsString<>'O');
  end;
  // Servisne zakazky
  If dmSTK.btSTO.FindKey ([pGsCode,'X','O']) then begin
    Repeat
      Result:=Result+dmSTK.btSTO.FieldByName ('OrdQnt').AsFloat;
      dmSTK.btSTO.Next;
    until (dmSTK.btSTO.Eof) or (dmSTK.btSTO.FieldByName('GsCode').AsInteger<>pGsCode) or (dmSTK.btSTO.FieldByName('OrdType').AsString<>'X') or (dmSTK.btSTO.FieldByName('StkStat').AsString<>'O');
  end;
end;
*)

procedure StcRecalcFromStm(pGsCode:longint); // Prepocita aktualnu skladovu kartu na zaklade skladovych pohybov
var  mBegQnt,mBegVal,mInQnt,mInVal,mOutQnt,mOutVal:double;
begin
  mBegQnt:=0;    mBegVal:=0;
  mInQnt:=0;     mInVal:=0;
  mOutQnt:=0;    mOutVal:=0;
  dmSTK.btSTM.SwapStatus;
  try
    dmSTK.btSTK.SwapIndex;
    If (pGsCode>0)and(pGsCode<>dmSTK.btSTK.FieldByName ('GsCode').AsInteger) then begin
      dmSTK.btSTK.IndexName:='GsCode';
      dmSTK.btSTK.FindKey([pGSCode]);
    end;
    dmSTK.btSTM.IndexName:='GsCode';
    If dmSTK.btSTM.FindKey ([dmSTK.btSTK.FieldByName ('GsCode').AsInteger]) then begin
      Repeat
        If (dmSTK.btSTM.FieldByName('SmCode').AsFloat=900)
        or (dmSTK.btSTM.FieldByName('BegStat').AsString='B') then begin  // Pociatocny stav
          mBegQnt:=mBegQnt+dmSTK.btSTM.FieldByName('GsQnt').AsFloat;
          mBegVal:=mBegVal+dmSTK.btSTM.FieldByName('CValue').AsFloat;
        end
        else begin
          If dmSTK.btSTM.FieldByName('GsQnt').AsFloat>0 then begin
            mInQnt:=mInQnt+dmSTK.btSTM.FieldByName('GsQnt').AsFloat;
            mInVal:=mInVal+dmSTK.btSTM.FieldByName('CValue').AsFloat;
          end
          else begin
            mOutQnt:=mOutQnt+Abs(dmSTK.btSTM.FieldByName('GsQnt').AsFloat);
            mOutVal:=mOutVal+Abs(dmSTK.btSTM.FieldByName('CValue').AsFloat);
          end;
        end;
        dmSTK.btSTM.Next;
      until (dmSTK.btSTM.Eof) or (dmSTK.btSTM.FieldByName('GsCode').AsInteger<>dmSTK.btSTK.FieldByName ('GsCode').AsInteger);
    end;
    // Ulozim udaje vypocitanej skladovej karty
    dmSTK.btSTK.Edit;
    dmSTK.btSTK.FieldByName ('BegQnt').AsFloat:=mBegQnt;
    dmSTK.btSTK.FieldByName ('InQnt').AsFloat:=mInQnt;
    dmSTK.btSTK.FieldByName ('OutQnt').AsFloat:=mOutQnt;
    dmSTK.btSTK.FieldByName ('BegVal').AsFloat:=mBegVal;
    dmSTK.btSTK.FieldByName ('InVal').AsFloat:=mInVal;
    dmSTK.btSTK.FieldByName ('OutVal').AsFloat:=mOutVal;
    dmSTK.btSTK.Post;
  finally
    dmSTK.btSTK.RestoreIndex;
    dmSTK.btSTM.RestoreStatus;
  end;
end;

procedure StcRecalcFromFif ; // Prepocita aktualnu skladovu kartu na zaklade FIFO
var  mBegQnt,mBegVal,mInQnt,mInVal,mOutQnt,mOutVal:double;
begin
  mBegQnt:=0;    mBegVal:=0;
  mInQnt:=0;     mInVal:=0;
  mOutQnt:=0;    mOutVal:=0;
  try
    dmSTK.btFIF.SwapStatus;
    If dmSTK.btFIF.IndexName<>'GsCode' then dmSTK.btFIF.IndexName:='GsCode';
    If dmSTK.btFIF.FindKey ([dmSTK.btSTK.FieldByName ('GsCode').AsInteger]) then begin
      Repeat
        mInQnt:=mInQnt+dmSTK.btFIF.FieldByName('InQnt').AsFloat;
        mInVal:=mInVal+dmSTK.btFIF.FieldByName('inPrice').AsFloat*dmSTK.btFIF.FieldByName('InQnt').AsFloat;
        mOutQnt:=mOutQnt+dmSTK.btFIF.FieldByName('OutQnt').AsFloat;
        mOutVal:=mOutVal+dmSTK.btFIF.FieldByName('InPrice').AsFloat*dmSTK.btFIF.FieldByName('OutQnt').AsFloat;

        dmSTK.btFIF.Next;
      until (dmSTK.btFIF.Eof) or (dmSTK.btFIF.FieldByName('GsCode').AsInteger<>dmSTK.btSTK.FieldByName ('GsCode').AsInteger);
      // Ulozim udaje vypocitanej skladovej karty
      dmSTK.btSTK.Edit;
      dmSTK.btSTK.FieldByName ('BegQnt').AsFloat:=mBegQnt;
      dmSTK.btSTK.FieldByName ('InQnt').AsFloat:=mInQnt;
      dmSTK.btSTK.FieldByName ('OutQnt').AsFloat:=mOutQnt;
      dmSTK.btSTK.FieldByName ('BegVal').AsFloat:=mBegVal;
      dmSTK.btSTK.FieldByName ('InVal').AsFloat:=mInVal;
      dmSTK.btSTK.FieldByName ('OutVal').AsFloat:=mOutVal;
      dmSTK.btSTK.Post;
    end;
  finally
    dmSTK.btFIF.RestoreStatus;
  end;
end;

(*
procedure OsdRecalcFromSto (pGsCode:longint); // Vypocita hodnotu pola OsdQnt z databaze STO
var mOsdQnt,mOsrQnt:double;  mMyOp:boolean;
begin
  // Vypocitame sucet rezervacii
  mOsdQnt:=0;mOsrQnt:=0;
  dmSTK.btSTO.SwapIndex;
  dmSTK.btSTO.IndexName:='GsOrSt';
  If dmSTK.btSTO.FindKey ([pGsCode,'S','O']) then begin
    Repeat
      mOsdQnt:=mOsdQnt+dmSTK.btSTO.FieldByName ('OrdQnt').AsFloat-dmSTK.btSTO.FieldByName ('DlvQnt').AsFloat;
      mOsrQnt:=mOsrQnt+dmSTK.btSTO.FieldByName ('ResQnt').AsFloat;
      dmSTK.btSTO.Next;
    until (dmSTK.btSTO.Eof) or (dmSTK.btSTO.FieldByName('GsCode').AsInteger<>pGsCode) or (dmSTK.btSTO.FieldByName('OrdType').AsString<>'S') or (dmSTK.btSTO.FieldByName('StkStat').AsString<>'O');
  end;
  dmSTK.btSTO.RestoreIndex;
  //Zaznamename rezervovane mnozstco na skladovej karte
  If dmSTK.btSTK.IndexName<>'GsCode' then dmSTK.btSTK.IndexName:='GsCode';
  If dmSTK.btSTK.FindKey ([pGsCode]) then begin //Zevidujeme novu kartu
    dmSTK.btSTK.Edit;
    dmSTK.btSTK.FieldByName ('OsdQnt').AsFloat:=mOsdQnt;
    dmSTK.btSTK.FieldByName ('OsrQnt').AsFloat:=mOsrQnt;
    dmSTK.btSTK.Post;
  end
  else begin  //Zevidujeme novu kartu
    try
      mMyOp:=not dmSTK.btGSCAT.Active;
      If mMyOp
        then dmSTK.btGSCAT.Open
        else dmSTK.btGSCAT.SwapStatus;
      dmSTK.btGSCAT.IndexName:='GsCode';
      If dmSTK.btGSCAT.FindKey ([pGsCode]) then begin
        dmSTK.btSTK.Insert;
        dmSTK.GSCAT_To_STK (dmSTK.btSTK); // Ulozi zaznam z btGSCAT do btSTK
        dmSTK.btSTK.FieldByName ('OsdQnt').AsFloat:=mOsdQnt;
        dmSTK.btSTK.FieldByName ('OsrQnt').AsFloat:=mOsrQnt;
        dmSTK.btSTK.Post;
      end;
    finally
      If mMyOp
        then dmSTK.btGSCAT.Open
        else dmSTK.btGSCAT.RestoreStatus;
    end;
  end;
end;

procedure OcdRecalcFromSto (pGsCode:longint); // Vypocita hodnotu pola OcdQnt a NrsQnt z databaze STO a ulozi na skladove karty
var mOcdQnt:double; // Sucet rezervacii
    mScdQnt:double; // Sucet rezervacii servisnych zakaziek
    mNrsQnt:double; // Sucet pozadovanych mnozstive na objednavanie
    mImrQnt:double; // Sucet pozadovanych mnozstiev TOVAR NA CESTE
    mOsrQnt:double; // Sucet pozadovanych rezervacii z objednavok
    mSalQnt:double; // Sucet pozadovanych mnozstive ERP
begin
//  mSalQnt:=SalQntCalcInSto (pGsCode); // Vypocitame sucet rezervacii ERP
  mOcdQnt:=OcdQntCalcInSto (pGsCode); // Vypocitame sucet rezervacii ZK
  mScdQnt:=ScdQntCalcInSto (pGsCode); // Vypocitame sucet rezervacii OBJ
  mNrsQnt:=NrsQntCalcInSto (pGsCode); // Vypocitame sucet rezervacii NRS
  mImrQnt:=ImrQntCalcInSto (pGsCode);
  mOsrQnt:=OsrQntCalcInSto (pGsCode);
  //Zaznamename rezervovane mnozstco na skladovej karte
  dmSTK.btSTK.IndexName:='GsCode';
  If dmSTK.btSTK.FindKey ([pGsCode]) then begin //Zevidujeme novu kartu
    dmSTK.btSTK.Edit;
    dmSTK.btSTK.FieldByName ('OcdQnt').AsFloat:=mOcdQnt+mScdQnt;
    dmSTK.btSTK.FieldByName ('NrsQnt').AsFloat:=mNrsQnt;
    dmSTK.btSTK.FieldByName ('OsrQnt').AsFloat:=mOsrQnt;
    dmSTK.btSTK.FieldByName ('ImrQnt').AsFloat:=mImrQnt;
    dmSTK.btSTK.Post;
  end
  else begin  //Zevidujeme novu kartu
    try
      dmSTK.btGSCAT.SwapStatus;
      dmSTK.btGSCAT.IndexName:='GsCode';
      If dmSTK.btGSCAT.FindKey ([pGsCode]) then begin
        dmSTK.btSTK.Insert;
        dmSTK.GSCAT_To_STK (dmSTK.btSTK); // Ulozi zaznam z btGSCAT do btSTK
        dmSTK.btSTK.FieldByName ('OcdQnt').AsFloat:=mOcdQnt;
        dmSTK.btSTK.FieldByName ('NrsQnt').AsFloat:=mNrsQnt;
        dmSTK.btSTK.FieldByName ('OsrQnt').AsFloat:=mOsrQnt;
        dmSTK.btSTK.FieldByName ('ImrQnt').AsFloat:=mImrQnt;
        dmSTK.btSTK.Post;
      end;
    finally
      dmSTK.btGSCAT.RestoreStatus;
    end;
  end;
end;

procedure ImdRecalcFromSto (pGsCode:longint); // Vypocita hodnotu pola ImrQnt z databaze STO a ulozi na skladove karty
var mImrQnt:double; // Sucet pozadovanych mnozstiev TOVAR NA CESTE
begin
  mImrQnt:=ImrQntCalcInSto (pGsCode);
  //Zaznamename rezervovane mnozstco na skladovej karte
  dmSTK.btSTK.IndexName:='GsCode';
  If dmSTK.btSTK.FindKey ([pGsCode]) then begin //Zevidujeme novu kartu
    dmSTK.btSTK.Edit;
    dmSTK.btSTK.FieldByName ('ImrQnt').AsFloat:=mImrQnt;
    dmSTK.btSTK.Post;
  end
  else begin  //Zevidujeme novu kartu
    try
      dmSTK.btGSCAT.SwapStatus;
      dmSTK.btGSCAT.IndexName:='GsCode';
      If dmSTK.btGSCAT.FindKey ([pGsCode]) then begin
        dmSTK.btSTK.Insert;
        dmSTK.GSCAT_To_STK (dmSTK.btSTK); // Ulozi zaznam z btGSCAT do btSTK
        dmSTK.btSTK.FieldByName ('ImrQnt').AsFloat:=mImrQnt;
        dmSTK.btSTK.Post;
      end;
    finally
      dmSTK.btGSCAT.RestoreStatus;
    end;
  end;
end;

procedure DelSciFromSto (pDocNum:Str12;pItmNum,pGsCode:longint);
var mFind:boolean;
begin
  dmSTK.btSTO.SwapIndex;
  If dmSTK.btSTO.IndexName<>'DoIt' then dmSTK.btSTO.IndexName:='DoIt';
  Repeat
    mFind:=dmSTK.btSTO.FindKey ([pDocNum,pItmNum]);
    If mFind then dmSTK.btSTO.Delete;
  until not mFind;
  dmSTK.btSTO.RestoreIndex;
  OcdRecalcFromSto (pGsCode);  // Prepocita rezervaciu tovaru a ulozi na skladovu kartu
end;

procedure DelImiFromSto (pDocNum:Str12;pItmNum,pGsCode:longint);
var mFind:boolean;
begin
  dmSTK.btSTO.SwapIndex;
  If dmSTK.btSTO.IndexName<>'DoIt' then dmSTK.btSTO.IndexName:='DoIt';
  Repeat
    mFind:=dmSTK.btSTO.FindKey ([pDocNum,pItmNum]);
    If mFind then dmSTK.btSTO.Delete;
  until not mFind;
  dmSTK.btSTO.RestoreIndex;
  ImdRecalcFromSto (pGsCode);  // Prepocita rezervaciu tovaru na ceste a ulozi na skladovu kartu
end;
*)

procedure StpOutPdnClear (pStkNum:word; pDocNum:Str12; pItmNum:longint); // Vymaze vydaj vyrobneho cisla zadanej polozky vydajoveho dokladu
begin
  dmSTK.btSTP.Open (pStkNum);
  dmSTK.btSTP.IndexName:='OutDoIt';
  While dmSTK.btSTP.FindKey ([pDocNum,pItmNum]) do begin
    dmSTK.btSTP.Edit;
    dmSTK.btSTP.FieldByName ('OutDocNum').AsString:='';
    dmSTK.btSTP.FieldByName ('OutItmNum').AsInteger:=0;
    dmSTK.btSTP.FieldByName ('OutDocDate').AsDateTime:=0;
    dmSTK.btSTP.FieldByName ('Status').AsString:='A';
    dmSTK.btSTP.Post;
  end;
  dmSTK.btSTP.Close;
end;

procedure DelTciFromPcc; // Zrusi aktualnu polozku z obaloveho konta
begin
  dmSTK.btPCCHIS.IndexName:='DoIt';
  If dmSTK.btPCCHIS.FindKey ([dmSTK.btTCI.FieldByName ('DocNum').AsString,dmSTK.btTCI.FieldByName ('ItmNum').AsInteger]) then begin
    // Odpocitame zrusenu polozku z kumulativnej tabulky obaloveho konta
    dmSTK.btPCCGSC.IndexName:='PaGs';
    If dmSTK.btPCCGSC.FindKey ([dmSTK.btPCCHIS.FieldByName ('PaCode').AsInteger,dmSTK.btPCCHIS.FieldByName ('GsCode').AsInteger]) then begin
      dmSTK.btPCCGSC.Edit;
      If dmSTK.btPCCHIS.FieldByName ('GsQnt').AsFloat>0 then begin
        // Vydaj vratneho obalu
        dmSTK.btPCCGSC.FieldByName ('OutQnt').AsFloat:=dmSTK.btPCCGSC.FieldByName ('OutQnt').AsFloat-dmSTK.btPCCHIS.FieldByName ('GsQnt').AsFloat;
        dmSTK.btPCCGSC.FieldByName ('OutVal').AsFloat:=dmSTK.btPCCGSC.FieldByName ('OutVal').AsFloat-dmSTK.btPCCHIS.FieldByName ('AValue').AsFloat;
      end
      else begin
        // Vratenie (prijem) vratneho obalu
        dmSTK.btPCCGSC.FieldByName ('IncQnt').AsFloat:=dmSTK.btPCCGSC.FieldByName ('IncQnt').AsFloat-Abs(dmSTK.btPCCHIS.FieldByName ('GsQnt').AsFloat);
        dmSTK.btPCCGSC.FieldByName ('IncVal').AsFloat:=dmSTK.btPCCGSC.FieldByName ('IncVal').AsFloat-Abs(dmSTK.btPCCHIS.FieldByName ('AValue').AsFloat);
      end;
      If dmSTK.btPCCGSC.FieldByName ('OutQnt').AsFloat<0 then dmSTK.btPCCGSC.FieldByName ('OutQnt').AsFloat:=0;
      If dmSTK.btPCCGSC.FieldByName ('OutVal').AsFloat<0 then dmSTK.btPCCGSC.FieldByName ('OutVal').AsFloat:=0;
      If dmSTK.btPCCGSC.FieldByName ('IncQnt').AsFloat<0 then dmSTK.btPCCGSC.FieldByName ('IncQnt').AsFloat:=0;
      If dmSTK.btPCCGSC.FieldByName ('IncVal').AsFloat<0 then dmSTK.btPCCGSC.FieldByName ('IncVal').AsFloat:=0;
      dmSTK.btPCCGSC.FieldByName ('EndQnt').AsFloat:=dmSTK.btPCCGSC.FieldByName ('OutQnt').AsFloat-dmSTK.btPCCGSC.FieldByName ('IncQnt').AsFloat;
      dmSTK.btPCCGSC.FieldByName ('EndVal').AsFloat:=dmSTK.btPCCGSC.FieldByName ('OutVal').AsFloat-dmSTK.btPCCGSC.FieldByName ('IncVal').AsFloat;
      dmSTK.btPCCGSC.Post;
    end;
    // Zrusime polozku z historie obaloveho konta
    dmSTK.btPCCHIS.Delete;
  end
end;

procedure AddTciToPcc; // Prida aktualnu polozku do obaloveho konta
begin
  // Ak firma neexistuje v obalovom konte pridame
  If not dmSTK.btPCCLST.FindKey ([dmSTK.btTCH.FieldByname('PaCode').AsInteger]) then begin
    dmSTK.btPCCLST.Insert;
    dmSTK.btPCCLST.FieldByname ('PaCode').AsInteger:=dmSTK.btTCH.FieldByname('PaCode').AsInteger;
    dmSTK.btPCCLST.FieldByname ('PaName').AsString:=dmSTK.btTCH.FieldByname('PaName').AsString;
    dmSTK.btPCCLST.FieldByname ('PaAddr').AsString:=dmSTK.btTCH.FieldByname('RegAddr').AsString;
    dmSTK.btPCCLST.FieldByname ('PaIno').AsString:=dmSTK.btTCH.FieldByname('RegIno').AsString;
    dmSTK.btPCCLST.Post;
  end;
  // Pridame polozku do obalového konta
  dmSTK.btPCCHIS.IndexName:='DoIt';
  DelTciFromPcc; // Zrusi aktualnu polozku z obaloveho konta
  // Pridame do historie obaloveho konta
  dmSTK.btPCCHIS.Insert;
  dmSTK.btPCCHIS.FieldByName ('DocNum').AsString:=dmSTK.btTCI.FieldByName ('DocNum').AsString;
  dmSTK.btPCCHIS.FieldByName ('ItmNum').AsInteger:=dmSTK.btTCI.FieldByName ('ItmNum').AsInteger;
  dmSTK.btPCCHIS.FieldByName ('PaCode').AsInteger:=dmSTK.btTCI.FieldByName ('PaCode').AsInteger;
  dmSTK.btPCCHIS.FieldByName ('GsCode').AsInteger:=dmSTK.btTCI.FieldByName ('GsCode').AsInteger;
  dmSTK.btPCCHIS.FieldByName ('GsName').AsString:=dmSTK.btTCI.FieldByName ('GsName').AsString;
  dmSTK.btPCCHIS.FieldByName ('GsQnt').AsFloat:=dmSTK.btTCI.FieldByName ('GsQnt').AsFloat;
  dmSTK.btPCCHIS.FieldByName ('AValue').AsFloat:=dmSTK.btTCI.FieldByName ('FgAValue').AsFloat;
  dmSTK.btPCCHIS.Post;
  // Upravime kumulativnu tabulku obaloveho konta
  dmSTK.btPCCGSC.IndexName:='PaGs';
  If dmSTK.btPCCGSC.FindKey ([dmSTK.btPCCHIS.FieldByName ('PaCode').AsInteger,dmSTK.btPCCHIS.FieldByName ('GsCode').AsInteger]) then begin
    dmSTK.btPCCGSC.Edit;
  end
  else begin
    dmSTK.btPCCGSC.Insert;
    dmSTK.btPCCGSC.FieldByName ('PaCode').AsInteger:=dmSTK.btPCCHIS.FieldByName ('PaCode').AsInteger;
    dmSTK.btPCCGSC.FieldByName ('GsCode').AsInteger:=dmSTK.btPCCHIS.FieldByName ('GsCode').AsInteger;
  end;
  dmSTK.btPCCGSC.FieldByName ('GsName').AsString:=dmSTK.btPCCHIS.FieldByName ('GsName').AsString;
  If dmSTK.btPCCHIS.FieldByName ('GsQnt').AsFloat>0 then begin
    // Vydaj vratneho obalu
    dmSTK.btPCCGSC.FieldByName ('OutQnt').AsFloat:=dmSTK.btPCCGSC.FieldByName ('OutQnt').AsFloat+dmSTK.btPCCHIS.FieldByName ('GsQnt').AsFloat;
    dmSTK.btPCCGSC.FieldByName ('OutVal').AsFloat:=dmSTK.btPCCGSC.FieldByName ('OutVal').AsFloat+dmSTK.btPCCHIS.FieldByName ('AValue').AsFloat;
  end
  else begin
    // Vratenie (prijem) vratneho obalu
    dmSTK.btPCCGSC.FieldByName ('IncQnt').AsFloat:=dmSTK.btPCCGSC.FieldByName ('IncQnt').AsFloat+Abs(dmSTK.btPCCHIS.FieldByName ('GsQnt').AsFloat);
    dmSTK.btPCCGSC.FieldByName ('IncVal').AsFloat:=dmSTK.btPCCGSC.FieldByName ('IncVal').AsFloat+Abs(dmSTK.btPCCHIS.FieldByName ('AValue').AsFloat);
  end;
  dmSTK.btPCCGSC.FieldByName ('EndQnt').AsFloat:=dmSTK.btPCCGSC.FieldByName ('OutQnt').AsFloat-dmSTK.btPCCGSC.FieldByName ('IncQnt').AsFloat;
  dmSTK.btPCCGSC.FieldByName ('EndVal').AsFloat:=dmSTK.btPCCGSC.FieldByName ('OutVal').AsFloat-dmSTK.btPCCGSC.FieldByName ('IncVal').AsFloat;
  dmSTK.btPCCGSC.Post;
end;

function  StmIsBegMov(pStm:TBtrieveTable):boolean;
begin
  Result:=(pStm.FindField('SmCode')<>NIL)and(pStm.FindField('BegStat')<>NIL)
  and((pStm.FieldByName('SmCode').AsInteger=900)or(pStm.FieldByName('BegStat').AsString='B'));
end;

(*
procedure ImiToSto(pImi:TBtrieveTable);
begin
  If (dmStk.GetActStkNum<>pImi.FieldByName('StkNum').AsInteger)
    then dmSTK.OpenStkFiles(pImi.FieldByName('StkNum').AsInteger);
  dmSTK.btSTO.SwapIndex;
  dmSTK.btSTO.IndexName:='DoIt';
  If dmSTK.btSTO.FindKey ([pImi.FieldByName('DocNum').AsString,pImi.FieldByName('ItmNum').AsInteger]) then begin
    dmSTK.btSTO.Edit;
    dmSTK.btSTO.FieldByName ('StkStat').AsString:=pIMI.FieldByName ('StkStat').AsString;
    dmSTK.btSTO.FieldByName ('OrdQnt').AsFloat:=pImi.FieldByName ('GsQnt').AsFloat;
    If dmSTK.btSTO.FieldByName ('StkStat').AsString = 'S'
      then dmSTK.btSTO.FieldByName ('DlvQnt').AsFloat:=dmSTK.btSTO.FieldByName ('OrdQnt').AsFloat
      else dmSTK.btSTO.FieldByName ('DlvQnt').AsFloat:=0;
    dmSTK.btSTO.Post;
  end
  else begin
    dmSTK.btSTO.Insert;
    BTRT_To_BTRT(pImi,dmSTK.btSTO);
    dmSTK.btSTO.FieldByName ('OrdType').AsString:='M';
    dmSTK.btSTO.FieldByName ('OrdQnt').AsFloat:=pImi.FieldByName ('GsQnt').AsFloat;
    If dmSTK.btSTO.FieldByName ('StkStat').AsString = 'S'
      then dmSTK.btSTO.FieldByName ('DlvQnt').AsFloat:=dmSTK.btSTO.FieldByName ('OrdQnt').AsFloat
      else dmSTK.btSTO.FieldByName ('DlvQnt').AsFloat:=0;
    dmSTK.btSTO.Post;
  end;
  ImdRecalcFromSto(pImi.FieldByName ('GsCode').AsInteger);
  dmSTK.btSTO.RestoreIndex;
end;
*)
end.

