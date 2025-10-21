unit IcTools;
{ REAL Real48 Single Double Extended Comp }
interface

uses
  {IdentCode} IcConv, IcTypes, IcVariab, Tlhelp32,
  {Delphi}    DateUtils, StdCtrls, Consts, SysUtils, WinTypes, WinProcs, Messages,
              Classes, Graphics, Controls, DBTables, Forms, Dialogs, ExtCtrls,
              Registry, DB, HTTPApp, idhttp, Math;

const
  cStand = 0;
  cDown  = 1;
  cUp    = 2;

  cStDec  = 'Q';
  cCancel = 'S';
  cNormal = 'N';

  ccStr       = 1;
  ccLong      = 2;
  ccDoub      = 3;
  ccDate      = 4;

  function KillTask(ExeFileName: string): Integer;

//  procedure KillProcess(hWindowHandle: HWND);

  function translategoogle(ss:string;lngs,lngD:str3):string;

  function GetLocalIPAddress : string;
            //vrati IP adresu
  procedure GetLocalName(var sUser,sComputer : string);
            //vrati meno uzivatela a pocitaca
  procedure Wait(pTime:word);
            //»ak· zadan˝ poËet milisek˙nd
  procedure WaitInSec (pSec:word);
            //»ak· zadan˝ poËet sek˙nd
  function AlignLeftBy (pStr:string;pLen:byte;pCh:char):string;
           //DoplnÌ reùazec z æava so zadanÌm znakom
  function AlignRightBy (pStr:string;pLen:byte;pCh:char):string;
           //DoplnÌ reùacez z prava so zadanÌm znakom
  function AlignCenterBy (pStr:string;pLen:byte;pCh:char):string;
           //DoplnÌ reùazec z zæava a z prava so zadanÌm znakom
  function AlignLeft (pStr:string;pLen:byte):string;
           //DoplnÌ reùazec z æava s medzerou
  function AlignRight (pStr:string;pLen:byte):string;
           //DoplnÌ reùacez z prava s medzerou
  function AlignCenter (pStr:string;pLen:byte):string;
           //DoplnÌ reùazec z æava a z prava s medzerou

  function RemAllChar (pStr:string; pChar:char):string;
           //Funkcia odstrani znak pChar z retazca pStr
  function RemLeftSpaces (pStr:string):string;
           //Odstr·ni medzery z æava
  function RemRightSpaces (pStr:string):string;
           //Odstr·ni medzery z prava
  function RemSpaces (pStr:string):string;
           //Odstr·ni zbytoËnÈ medzery z reùazca
  function DelSpaces(pStr:string):string;
           // Odstrani vsetky medzery zo zadaneho textu
  function ReplaceStr (pStr,pFind,pRepl:string):string;
           //NahradÌ vöetky podreùazce so zadanou reùazcou}
  function FillStr (pStr:string;pLen:byte;pCh:string):string;
           //Hodnota funkcie je retazec pStr vyplneny z prava
           //so znakom pCh na pLen dlzku
  function RemNonCharNum (pStr:string): string;
           //Funkcia odstrani z retazca pStr vsetky symboli
  function RemNonNum (pStr:string): string;
           //Funkcia ponecha z pStr len cisla a znaky  [,.+-]
  function ReplaceNonCharNum (pStr:string;pRChar:char): string;
           //Funkcia vymeni symboli na pRChar
  function RemLastBS (pStr:string):string;
           //Funkcia odstrani opacne lomitko z konci retazca
  function RemEndNums (pStr:string):string;
           //Funkcia odstr·ni ËÌsla z konca reùazca
  function RemEndNumsDef (pStr:string):string;
           //Funkcia odstr·ni ËÌsla z konca reùazca a aj retazce A- resp. P- ore def subory

  function GetMaxTextWidth (pS:TMemo; pForm: TWinControl):longint;
           //Funcia vr·ti maxim·lnu öÌrku textu v pS v pixeloch
  function GetTextWidth(pS:string;pF:TFont; pForm: TWinControl):longint;
           //Funkcia vr·ti öÌrku textu pri zadanom nastavenÌ pÌsmien
  function GetTextHeight(pF:TFont; pForm: TWinControl):longint;
           //Funkcia vr·ti v˝öku textu pri zadanom nastavenÌ pÌsmien

  procedure CutNextParam (var pParam,pFld:string);
            //Funkcia vr·ti prvÈ pole z parametra a vymaûe z premennej pParam. Parametre s˙ oddelenÈ s Ëiarkami
  procedure CutNextParamSepar (var pParam,pFld:string;pSepar:string);
            //Funkcia vr·ti prvÈ pole z parametra a vymaûe z premennej pParam. Parametre s˙ oddelenÈ s reùazcami pSepar
  function GetNParams (pParam:string;pN:integer;pSepar:char):string;
           //Funkcia vr·ti prv˝ch pN parametrov z reùazcapParam, parametre s˙ oddelenÈ so znakom pSepar

  function VarDataAsString (const Value: array of const;pNum:byte):string;
           //Funkcia vr·ti hodnotu variabilnej premennej v poradÌ pNum, v textovom tvare. PouûÌva typy string, integer a double.

  procedure FillTVarRec (const pRV: array of const;var pValue: array of TVarRec);

  function FormTop  (pForm:TForm):longint;
  function FormLeft (pForm:TForm):longint;

  function GetDGFieldNum (pTbl:TTable;pFld:string):longint;

  function RoundOK(pValue:double):double;
           // Funkcia zaokruhli podobne ako ROUND s tym rozdielom ze
           /// XXX.5 sa vzdy rovna XXX+1
           // a nie podla toho ci XXX je parne nadol a neparne nahor
  function Rnd (pValue:double;pRndType:byte):double;
  function Roundx (pNumber:double;pFract:integer):double;
  function RoundCPrice (pNumber:double):double;
  function RoundCValue (pNumber:double):double;
  function Rd (pNum:double;pFract,pMode:byte):double;
  function Rd1 (pNumber:double):double;
  function Rd2 (pNumber:double):double;
  function Rd3 (pNumber:double):double;
  function Rd5 (pNumber:double):double;
  function RdX (pNumber:double;pFract:byte):double;
  function RoundOff (pNum: double; pType, pFract, pMode: byte): double;
           //fodnota funkcie je zaokruhlene cislo podla zadanych
           //parametrov
           //  pNum   - cislo ktore treba zaokruhlit
           //  pType  - sposob zaokruhlenia, moze mat dve hodnoty:
           //           1 alebo 5
           //  pFract - pocet desaticnych miest
           //  pMode  - zaokruhlenie hore, dole alebo aritmeticky
  function SpecRnd5(pValue:double):double;

  function Sign (pNum:Double):integer;

  function Sq (pX,pY:double):double;

  function GetEndNum(pStr:string): integer; //By Laci 97.2.20. // 'Akarmilyen szoveg 323' -> 323

  function WriteStrToFile (pFile,pText:string):boolean;

  function GetParamString (pStr:string;pNum:byte):string;
           //Zo zadanÈho textu vr·ti parameter v textovom tvare ktor˝ je v poradÌ na mieste pNum. Parametre s˙ oddelenÈ s Ëiarkami
  function GetParamBool (pStr:string;pNum:byte):boolean;
           //Zo zadanÈho textu vr·ti parameter v boolean tvare ktor˝ je v poradÌ na mieste pNum. Parametre s˙ oddelenÈ s Ëiarkami
  function GetParamLong (pStr:string;pNum:byte):longint;
           //Zo zadanÈho textu vr·ti parameter v Longint tvare ktor˝ je v poradÌ na mieste pNum. Parametre s˙ oddelenÈ s Ëiarkami

  function LineElementNum   (const pStr: string; const pSeparator :char): integer; //new 1999.4.27.
  function LineElement      (const pStr: string; const pNum: integer; const pSeparator :char): string;//new 1999.4.27.
  function LineElementChange(const pStr: string; const pChStr: string; const pNum:integer;  const pSeparator :char): string;//new 1999.7.31.
  function LineElementPos   (const pStr: string; const pChStr: string; const pSeparator :char): integer;//new 1999.12.8. megadja a keresett szoveg elso eloFordulasat
  function LineElementInString(const pStr: string; const pChStr: string; const pSeparator :char): integer;
  //new 2000.07.25 urci ci niektory z elementov je castou retazca

  function GreaterEqual (pNum1,pNum2:double; pFract:byte): boolean;
            // Hodnota funkcie je TRUE ak re·lne ËÌslo pNum1 je vacsie ako pNum2
            // alebo s˙ rovnakÈ do pFract-om zadanÈho poËtu desatinn˝ch miest

  function Equal (pNum1,pNum2:double; pFract:byte): boolean;
            // Hodnota funkcie je TRUE ak re·lne ËÌsla pNum1a
            // pNum2 s˙ rovnakÈ do zpFract-om adanÈho poËtu
            // desatinn˝ch miest

  function EqualD(pNum1,pNum2,pDiff:double): boolean;
            // Hodnota funkcie je TRUE ak re·lne ËÌsla pNum1a
            // pNum2 s˙ rovnakÈ do zpFract-om adanÈho poËtu
            // pDiff je maximalna hodnota rozdielu

  function Eq1(pNum1,pNum2:double): boolean;
  function Eq2(pNum1,pNum2:double): boolean;
            // Hodnota funkcie je TRUE ak re·lne ËÌsla pNum1a
            // pNum2 s˙ rovnakÈ na 2 desatinnÈ miesta
  function Eq3(pNum1,pNum2:double): boolean;
  function Eq4(pNum1,pNum2:double): boolean;
  function Eq5(pNum1,pNum2:double): boolean;
  function Eqd(pNum1,pNum2,pDifVal:double): boolean;
  function Eqn(pNum:double; pFract:byte): boolean;
            // Hodnota funkcie je TRUE ak re·lne ËÌsla pNum=0
            // Porovnavanie sa vykonava na zadany pocet desatinnych miest
            //   pNum - kontrolovane cislo
            //   pFract - poËet desatinnych miest
  function Eqt(pText1,pText2:string): boolean; // TRUE ak zadane texty su rovnake

  function IsNul (pValue:double): boolean; // TRUE ak pValue=0
  function IsNotNul (pValue:double): boolean; // TRUE ak pValue<>0
  function IsNotNul2 (pValue:double): boolean; // TRUE ak pValue<>0

  function WToD(pFName: string): string;

  function CalcPrice(pValue,pQnt: double):double;

  function ConventionStrComp(pStr, pConvStr: string): boolean; // * ill. ? konvencios osszehasonlitas
  function LPosCh(pChar: Char; pStr: string): integer; //Megadja a stringben a kivalasztott karakter utolso elofordulasi poziciojat ha nincs akkor 0

  function StringInInt (pStr,pInt:string):boolean;
  function LongInInt (pNum:longint;pInt:string):boolean;

  function InLongInterval (pNum1,pNum2,pNum:LongInt): boolean;
  function InDoubInterval (pNum1,pNum2,pNum:double): boolean;
  function InTextInterval (pTxt1,pTxt2,pTxt:string): boolean;
  function InDateInterval (pDate1,pDate2,pDate:TDateTime): boolean;
  function InTimeInterval (pTime1,pTime2,pTime:TDateTime): boolean;

  function  LongInInterval (pNum:longint;pInterval:string):boolean;
// T·to funkcia vr·ti TRUE, ak zadanÈ celÈ ËÌslo patrÌ do intervalu
  function  FloatInInterval (pNum:double;pInterval:string):boolean;
// T·to funkcia vr·ti TRUE, ak zadanÈ ËÌslo patrÌ do intervalu
  function  DateInInterval (pDate:TDateTime;pInterval:string):boolean;
// T·to funkcia vr·ti TRUE, ak zadan˝ d·tum patrÌ do intervalu
  function  StrInInterval (pStr:string;pInterval:string):boolean;
  function  TextInInterval (pStr:string;pInterval:string):boolean;
// T·to funkcia vr·ti TRUE, ak zadan˝ reùazec patrÌ do intervalu
  procedure GetLongIntFirstLast (pInterval:string;var pFirst, pLast:longint);
// UrËÌ prvÈ a poslednÈ celÈ ËÌslo v danom intervale
  procedure GetFloatIntFirstLast (pInterval:string;var pFirst, pLast:double);
// UrËÌ prvÈ a poslednÈ re·lne ËÌslo v danom intervale
  procedure GetStrIntFirstLast (pInterval:string;var pFirst, pLast:string);
// UrËÌ prv˝ a posledn˝ reùazec v danom intervale
  procedure GetDateIntFirstLast (pInterval:string;var pFirst, pLast:TDate);
// UrËÌ prv˝ a posledn˝ d·tum v danom intervale

  function VerifyDate (pDate:string):string; //Kontroluje spr·vnosù d·tumu rozneho fom·tu a vr·ti cel˝ d·tum
  function VerifyTime (pTime:string):string; //Kontroluje spr·vnosù casu rozneho fom·tu a vr·ti cel˝ cas
  function GetDayNameOfWeek (pDate:TDate):string; //Vr·ti n·zov dÚa na dve znaky

  function RoundTimeToQuarter (pTime:TTime;pRoundUp:boolean):TTime;
  function RoundTimeToMin (pTime:TTime):TTime;

  function GetLastNonNumericChar (pStr:string):char;
           //Funkcia vyhlada posledny nenumericky znak
  procedure LoadSectionFromFile (pFileName,pSecName:ShortString; pSecFile:TStrings);
           // V StrinList vrati cast suboru - zadanu sekciu bez nazvu sekcie
  function IsNumChar (pChar:Char):boolean; // TRUE ak zadany znak je cislo
  function DecNumStr (pStr:String):String; // vrati numericky retaz znizeny o 1
  function IncNumStr (pStr:String):String; // vrati numericky retaz zvyseny o 1
  function CombineStr(pStr1,pStr2,pDelim:String):String; // vrati spojeny retazec pStr1+pDelim+pStr2 resp. pStr2 ak pStr1 je prazdny

  function  LongIntervalToSql (pFldname:Str30;pInterval:string):String;
// T·to funkcia vr·ti retazec SQL pre urcenie podmienky intervalu
  function WildComp(const mask: String; const target: String): Boolean;

implementation

uses WINSOCK;

function translategoogle(ss:string;lngs,lngD:str3):string;
var s:widestring;
a,b:integer;
http:tidhttp;
begin
  http:=tidhttp.Create;
  HTTP.Request.UserAgent:='Mozilla/4.0 (compatible; MSIE 6.0; Windows NT 5.1)';
  s:=http.Get('http://translate.google.com/translate_t?text='
  +httpencode(ss)+'&langpair='+lngS+'%7C'+lngD);
  a:=1;b:=length(S);
//  a:=posex('õ',s,pos('ãtextarea',s));
//  b:=posex('ã/textareaõ',s,a);
  result:=copy(s,a+1,b-a-1);
  http.Free;
end;

function KillTask(ExeFileName: string): Integer;
const
  PROCESS_TERMINATE = $0001;
var
  ContinueLoop: BOOL;
  FSnapshotHandle: THandle;
  FProcessEntry32: TProcessEntry32;
begin
  Result:=0;
  FSnapshotHandle:=CreateToolhelp32Snapshot(TH32CS_SNAPPROCESS, 0);
  FProcessEntry32.dwSize:=SizeOf(FProcessEntry32);
  ContinueLoop:=Process32First(FSnapshotHandle, FProcessEntry32);

  while Integer(ContinueLoop) <> 0 do
  begin
    if ((UpperCase(ExtractFileName(FProcessEntry32.szExeFile)) =
      UpperCase(ExeFileName)) or (UpperCase(FProcessEntry32.szExeFile) =
      UpperCase(ExeFileName))) then
      Result:=Integer(TerminateProcess(
                        OpenProcess(PROCESS_TERMINATE,
                                    BOOL(0),
                                    FProcessEntry32.th32ProcessID),
                                    0));
     ContinueLoop:=Process32Next(FSnapshotHandle, FProcessEntry32);
  end;
  CloseHandle(FSnapshotHandle);
end;
(*
procedure KillProcess(hWindowHandle: HWND);
var
  hprocessID: INTEGER;
  processHandle: THandle;
  DWResult: DWORD;
begin
  SendMessageTimeout(hWindowHandle, WM_CLOSE, 0, 0,
    SMTO_ABORTIFHUNG or SMTO_NORMAL, 5000, DWResult);

  if isWindow(hWindowHandle) then
  begin
    // PostMessage(hWindowHandle, WM_QUIT, 0, 0);

    { Get the process identifier for the window}
    GetWindowThreadProcessID(hWindowHandle, @hprocessID);
    if hprocessID <> 0 then
    begin
      { Get the process handle }
      processHandle:=OpenProcess(PROCESS_TERMINATE or PROCESS_QUERY_INFORMATION,
        False, hprocessID);
      if processHandle <> 0 then
      begin
        { Terminate the process }
        TerminateProcess(processHandle, 0);
        CloseHandle(ProcessHandle);
      end;
    end;
  end;
end;
*)

(* NepouûÌvanÈ od 10.12.2019  TIBI
function RoundOK(v:double):double;
var fracs,rundop:boolean;
    I:double;
begin
  rundop:=frac(abs(v))>=0.5;
  I:=int(v);
  if v>0 then begin
    if rundop then I:=I+1;
  end else begin
    if rundop then I:=I-1;
  end;
  Result:=I;
end;
*)
function RoundOK(pValue:double):double;
// Zaokruhlenie podæa Excelu
var mRoundUp:boolean; I:double; mS:ShortString;
begin
  mS:=StrDoub(pValue,0,4);
  Delete(mS,Length(mS)-2,3);
  pValue:=ValDoub(mS);
  mRoundUp:=Frac(Abs(pValue))>=0.5;
  I:=Int(pValue);
  If pValue>0 then begin
    If mRoundUp then I:=I+1;
  end else begin
    If mRoundUp then I:=I-1;
  end;
  Result:=I;
end;

function GetLocalIPAddress : string;
var wsdata : TWSAData;
    he : PHostEnt;
    ss : pchar;
    ip : TInAddr;
    i  : cardinal;
    co : string;
begin
  i:=MAX_COMPUTERNAME_LENGTH + 1;
  SetLength(co,i);
  GetComputerName(PChar(co),i);
  WSAStartup(MakeWord(1, 1), wsdata);
  he:=gethostbyname(pchar(co));
  if he<>nil then begin
    ip.S_addr:=integer(pointer(he^. h_addr_list^)^);
    ss:=inet_ntoa(ip);
    Result:=string(ss);
  end;
  WSACleanup();
end;

procedure GetLocalName(var sUser,sComputer : string);
var
  i : cardinal;
begin
  try
    i:=255;
    { user }
    SetLength(sUser,i);
    GetUserName(PChar(sUser),i);
    SetLength(sUser,(i));
    { computer }
    i:=255;
    SetLength(sComputer,i);
    GetComputerName(PChar(sComputer),i); 
    SetLength(sComputer,(i));
  except
    ShowMessage('Can not get Local Name !');
  end;
end;

procedure Wait (pTime:word);
var mWaitTime:TDateTime;
begin
  mWaitTime:=IncMilliSecond (Now,pTime);
  While Now<mWaitTime do begin
    Application.ProcessMessages;
  end;
end;

procedure WaitInSec (pSec:word);
var mWaitTime:TDateTime;
begin
  mWaitTime:=IncSecond (Now,pSec);
  While Now<mWaitTime do begin
    Application.ProcessMessages;
  end;
end;

function CalcPrice(pValue,pQnt: double):double;
begin
  If pQnt<>0 then Result:=pValue/pQnt else Result:=0;
end;

function  AlignLeftBy (pStr:string;pLen:byte;pCh:char):string;
var mF:string;
begin
  If Length (pStr)>=pLen
  then pStr:=Copy (pStr,1,pLen)
  else begin
    mF:='';
    mF:=FillStr (mF,pLen-Length (pStr)+1,pCh);
    mF:=Copy (mF,1,pLen-Length (pStr));
    pStr:=mF+pStr;
  end;
  AlignLeftBy:=pStr;
end;

function  AlignRightBy (pStr:string;pLen:byte;pCh:char):string;
var
  mF:string;
  mB:byte;
begin
  If Length (pStr)>=pLen
  then pStr:=Copy (pStr,1,pLen)
  else begin
    mF:='';
    mB:=pLen-Length (pStr)+1;
    mF:=FillStr (mF,mB,pCh);
    mF:=Copy (mF,1,pLen-Length (pStr));
    pStr:=pStr+mF;
  end;
  AlignRightBy:=pStr;
end;

function  AlignCenterBy (pStr:string;pLen:byte;pCh:char):string;
var
  mFS:byte;
  mLS:byte;
  mS1: string;
  mS2: string;
begin
  If Length (pStr)>=pLen
  then pStr:=Copy (pStr,1,pLen)
  else begin
    mLS:=pLen-Length (pStr)+1;
    mFS:=mLS div 2;
    mLS:=(pLen-Length (pStr)+1)-mFS;
    mS1:='';
    mS1:=FillStr (mS1,mFS+1,pCh);
    mS1:=Copy (mS1,1,mFS);
    mS2:='';
    mS2:=FillStr (mS2,mLS+1,pCh);
    mS2:=Copy (mS2,1,mLS);
    pStr:=mS1+pStr+mS2;
  end;
  AlignCenterBy:=pStr;
end;

function  AlignLeft (pStr:string;pLen:byte):string;
begin
  AlignLeft:=AlignLeftBy (pStr,pLen,' ');
end;

function  AlignRight (pStr:string;pLen:byte):string;
begin
  AlignRight:=AlignRightBy (pStr,pLen,' ');
end;

function  AlignCenter (pStr:string;pLen:byte):string;
begin
  AlignCenter:=AlignCenterBy (pStr,pLen,' ');
end;

function RemAllChar(pStr:string; pChar:Char): string;
var I: integer;
begin
  I:=1;
  While (I<=Length(pStr)) do
    If pStr[I]=pChar
      then Delete(pStr,I,1)
      else Inc(I);
  Result:=pStr;
end;

function  RemLeftSpaces (pStr:string):string;
begin
  While Pos (' ',pStr)=1 do Delete (pStr,1,1);
  Result:=pStr;
end;

function  RemRightSpaces (pStr:string):string;
begin
  While Copy (pStr,Length (pStr),1)=' ' do Delete (pStr,Length (pStr),1);
  Result:=pStr;
end;

function  RemSpaces (pStr:string):string;
begin
  pStr:=RemLeftSpaces (RemRightSpaces (pStr));
  While Pos ('  ',pStr)>0 do Delete (pStr,Pos ('  ',pStr),1);
  Result:=pStr;
end;

function  DelSpaces (pStr:string):string;
begin
  Result:=pStr;
  While Pos(' ',Result)>0 do Delete (Result,Pos(' ',Result),1);
end;

function  ReplaceStr (pStr,pFind,pRepl:string):string;
var mStr:string;
begin
  mStr:='';
  While Pos (pFind,pStr)>0 do begin
    mStr:=mStr+Copy (pStr,1,Pos (pFind,pStr)-1)+pRepl;
    Delete (pStr,1,Pos (pFind,pStr)-1+Length (pFind));
  end;
  Result:=mStr+pStr;
end;

function  FillStr (pStr:string;pLen:byte;pCh:string):string;
var mCh: array [1..255] of char;  I: byte;  mStr: string;
    mLen:longint;  mL: longint;
begin
  mL:=pLen;
  mLen:=Length (pStr)+mL;
{
  For I:=1 to 255 do
    mCh[I]:=#32;
}
  FillChar (mCh,255,#32);
  FillChar (mCh,mLen,pCh[1]);
  For I:=mL+1 to (mL+Length (pStr)) do
    mCh[I]:=pStr[I-mL];
  mStr:='';
  For I:=1 to mLen do
    mStr:=mStr+mCh[I];
  Result:=mStr;
end;

function RemNonCharNum(pStr:string):string;
var m:byte;   S:string;
begin
  m:=1;s:=pStr;If pStr='' then m:=0;
  while m>0 do begin
    If (Ord(s[m])<48) or (Ord(s[m])>90)
    or((Ord(s[m])>57) and (Ord(s[m])<64))
      then Delete (s,m,1)
      else Inc(m);
    If m>length (s) then m:=0;
  end;
  result:=s;
end;

function RemNonNum(pStr:string):string;
var m:byte;   S:string;
begin
  m:=1;s:=pStr;If pStr='' then m:=0;
  while m>0 do begin
    If ((Ord(s[m])>=48) and (Ord(s[m])<=57))
    or (s[m]='.')or (s[m]=',')or (s[m]='-')or (s[m]='+')
      then Inc(m)
      else Delete (s,m,1);
    If m>length (s) then m:=0;
  end;
  result:=s;
end;

function ReplaceNonCharNum;
var m:byte;  S:string;
begin
  s:=pStr;
  For m:=1 to Length(S) do begin
    If (Ord(s[m])<32) or((Ord(s[m])>179)and (Ord(s[m])<223))
      then s[m]:=pRChar;
  end;
  s:=DosStrToWinStr(S);
  result:=s;
end;

function RemLastBS;
begin
  If pStr[length(pStr)]='\'
    then Result:=Copy(pStr,1,length(pStr)-1)
    else Result:=pStr;
end;

function RemEndNums (pStr:string):string;
begin
  Result:=pStr;
  While (Result<>'') and (Result[Length (Result)] in ['0'..'9']) do begin
    Delete (Result,Length (Result),1);
  end;
end;

function RemEndNumsDef (pStr:string):string;
begin
  Result:=RemEndNums(pStr);
  If Copy(Result,length(Result)-1,2)='A-' then Result:=Copy(Result,1,length(Result)-2);
  If Copy(Result,length(Result)-1,2)='P-' then Result:=Copy(Result,1,length(Result)-2);
end;

function  FormTop  (pForm:TForm):longint;
begin
  FormTop:=pForm.Top+(pForm.Height-pForm.ClientHeight)-((pForm.Width-pForm.ClientWidth) div 2);
end;

function  FormLeft (pForm:TForm):longint;
begin
  FormLeft:=pForm.Left+(pForm.Width-pForm.ClientWidth) div 2;
end;

function GetDGFieldNum (pTbl:TTable;pFld:string):longint;
var I:longint;  mNum:longint;
begin
  mNum:=pTbl.FieldByName (pFld).Index-1;
  For I:=1 to mNum do begin
    If not pTbl.Fields[I].Visible then Dec (mNum);
  end;
  GetDGFieldNum:=mNum;
end;

function Rnd (pValue:double;pRndType:byte):double;
begin
  Result:=pValue;
  case pRndType of
    0: Result:=RoundX(pValue, 2); // Na  0.01 Sk
    1: Result:=RoundX(pValue, 1); // Na  0.10 Sk
    2: Result:=RoundX(pValue, 0); // Na  1.00 Sk
    3: Result:=RoundX(pValue,-1); // Na 10.00 Sk
    4: Result:=RoundOff(pValue,5,1,cStand); // Na 0.50 Sk
  end;
end;

function Roundx (pNumber:double;pFract:integer):double;
var  N: double;
begin
  N:=Sq(10,pFract);
  If pFract<0 then begin
    Result:=RoundOK(pNumber*N)/N;
//    Result:=Int (pNumber)+(RoundOK (Frac(pNumber)*N)/N);
    Result:=ValDoub(StrDoub(Result,0,pFract));
  end else begin
    Result:=RoundOK(pNumber*N)/N;
    Result:=ValDoub(StrDoub(Result,0,pFract));
  end;
end;

function RoundCPrice (pNumber:double):double;
begin
  Result:=Roundx (pNumber,gvSys.StpRndFrc);
end;

function RoundCValue (pNumber:double):double;
begin
  Result:=Roundx (pNumber,gvSys.StvRndFrc);
end;

function Rd (pNum:double;pFract,pMode:byte):double;
begin
  Result:=RoundOff (pNum,1,pFract,pMode);
end;

function Rd1 (pNumber:double):double;
begin
  Result:=Roundx (pNumber,1);
end;

function Rd2 (pNumber:double):double;
begin
  Result:=Roundx (pNumber,2);
end;

function Rd3 (pNumber:double):double;
begin
  Result:=Roundx (pNumber,3);
end;

function Rd5 (pNumber:double):double;
begin
  Result:=Roundx (pNumber,5);
end;

function RdX (pNumber:double;pFract:byte):double;
begin
  Result:=Roundx (pNumber,pFract);
end;

function RoundOff (pNum: double; pType, pFract, pMode: byte): double;
var N,mRound,mInt:double;  mSign,mNum:integer;
begin
  If (Abs(pNum)<100000000) then begin
    mSign:=Sign(pNum);
    pNum:=Abs(pNum);
    mInt:=0;
    If pFract>0 then begin
      mInt:=Int(pNum);
      pNum:=Frac(pNum);
    end;
    mRound:=pNum;
    case pType of
      1: begin
           N:=Sq(10,pFract);
           case pMode of
             cStand: begin
                       mNum:=Round(RoundOK (pNum*N+0.00001));
                       mRound:=mNum/N;
                     end;
             cDown : mRound:=Int(pNum*N)/N;
             cUp   : If not Eq2(pNum,RoundOK(pNum)) then mRound:=Int(pNum*N+1)/N;
           end;
         end;
      5: begin
           N:=Sq(10,pFract-1);
           case pMode of
             cStand: mRound:=Int(pNum*N*2+0.5)/(2*N);
             cDown : mRound:=Int(pNum*N*2)/(2*N);
             cUp   : begin
                       If pNum<>Int(pNum*N*2+0.5)/(2*N) then mRound:=Int(pNum*N*2+1)/(2*N);
                     end;
           end;
         end;
    end;
    If pFract>0 then mRound:=mRound+mInt;
  end else begin
    mSign:=1;
    mRound:=0;
  end;
  RoundOff:=mRound*mSign;
end;

function Sq (pX,pY:double):double;
begin
  Sq:=Exp (pY*Ln (pX));
end;

function  GetEndNum(pStr:string): integer;
  var
    i: integer;
    mStr: string;
  begin
    i:=length(pStr);
    mStr:='';
    while (i>0) and (pStr[i] in ['0'..'9']) do begin
      mStr:=pStr[i] + mStr;
      dec(i);
    end;
    GetEndNum:=ValInt(mStr);    // 'Akarmilyen szoveg 323' -> 323
  end;

function WToD(pFName: string): string;
var
  mStr: string;
  i: integer;
  mSearchRec: TSearchRec;
begin
  If pFName = ''
    then Result:=pFName
    else Result:=LineElement(pFName,LineElementNum(pFName,'\')-1,'\');
  mStr:='';
  If (0 = FindFirst(pFName, faAnyFile, mSearchRec)) then begin
    i:=0;
    while (#0 <> mSearchRec.FindData.cAlternateFileName[i]) and (i<14)do begin
       mStr:=mStr+mSearchRec.FindData.cAlternateFileName[i];
       inc(i);
    end;
  end;
  If mStr <> '' then Result:=mStr;
end;

procedure AddPathToSList (pSList:TStringList;pPath:string);
var I:longint;
begin
  If pSList.Count>0 then begin
    For I:=0 to pSList.Count-1 do
      pSList.Strings[I]:=pPath+pSList.Strings[I];
  end;
end;

procedure CutPathInSList (pSList:TStringList);
var
  I :longint;
  mS:string;
begin
  If pSList.Count>0 then begin
    For I:=0 to pSList.Count-1 do begin
      mS:=pSList.Strings[I];
      While Pos ('\',mS)>0 do
        Delete (mS,1,Pos ('\',mS));
      pSList.Strings[I]:=mS;
    end;
  end;
end;

function  FDDReady (pDrv:string):boolean;
var
  mRec:TSearchRec;
  mErr:integer;
begin
  mErr:=SysUtils.FindFirst (pDrv+':\*.*', faAnyFile, mRec);
  SysUtils.FindClose(mRec);
  FDDReady:=mErr<>21;
end;

function  PutDisk (pDiskNum:longint;pDrv:string):boolean;
var
  mOK :boolean;
  mESC:boolean;
begin
  mOK:=FALSE;
  Repeat
    mESC:=MessageDlg ('Dajte '+StrInt (pDiskNum,0)+'. disketu do disketovej jednotky', mtConfirmation, [mbOK,mbAbort], 0)=mrAbort;
    If not mESC then mOK:=FDDReady (pDrv);
    If not mOK and not mESC then MessageDlg('Disketa nie je pripraven·!', mtConfirmation, [mbOK], 0);
  until mESC or mOK;
  PutDisk:=mOK;
end;

function  WriteStrToFile (pFile,pText:string):boolean;
var
  mOK:boolean;
  mT :text;
  mIOErr:integer;
begin
  mOK:=FALSE;
  AssignFile (mT,pFile);
  {$I-} Append (mT); mIOErr:=IOResult;
  If mIOErr<>0 then begin
    Rewrite (mT); mIOErr:=IOResult;
  end;
  If mIOErr=0 then begin
    {$I-} WriteLn (mT,pText); mIOErr:=IOResult;
    mOK:=(mIOErr=0);
  end;
  {$I-} CloseFile (mT); mIOErr:=IOResult;
  WriteStrToFile:=mOK;
end;

function  GetParamString (pStr:string;pNum:byte):string;
var I:byte;
begin
  For I:=1 to pNum-1 do
    Delete (pStr,1,Pos (',',pStr));
  If Pos (',',pStr)>0 then pStr:=Copy (pStr,1,Pos (',',pStr)-1);
  Result:=pStr;
end;

function  GetParamBool (pStr:string;pNum:byte):boolean;
begin
  Result:=(UpperCase(GetParamString(pStr,pNum))='TRUE') or
            (UpperCase(GetParamString(pStr,pNum))='ON') or
            (GetParamString (pStr,pNum)='Y') or
            (GetParamString (pStr,pNum)='1');
end;

function  GetParamLong (pStr:string;pNum:byte):longint;
begin
  GetParamLong:=ValInt (GetParamString (pStr,pNum));
end;

function  LineElement(const pStr: string; const pNum: integer; const pSeparator :char): string;//new 1999.4.27.
var mStr: string;  I, mNum:integer;
begin
  mStr:='';  mNum:=0; I:=1;
  While (I<=Length(pStr)) and (pStr[I]<>#0) and (mNum<=pNum) do begin
    If (pStr[i] = pSeparator) then begin
      Inc(mNum)
    end else begin
      If (mNum = pNum) then mStr:=mStr + pStr[i];
    end;
    Inc(I);
  end;
  Result:=mStr;
end;

function  LineElementNum(const pStr: string; const pSeparator :char): integer; //new 1999.4.27.
var I, mNum:integer;
begin
  mNum:=0;
  If pStr<>'' then begin
    Inc(mNum);
    For i:=1 to length(pStr) do //new 1999.4.27.
      If (pStr[i] = pSeparator) then inc(mNum);
  end;
  Result:=mNum;
end;

function  LineElementChange(const pStr: string; const pChStr: string; const pNum: integer; const pSeparator :char): string;//new 1999.7.31.
var mLineElementNum: integer; I: integer;
    mLineElement: string;
begin
  mLineElementNum:=LineElementNum(pStr, pSeparator);
  i:=0;
  Result:='';
  While (i < mLineElementNum) or (i <= pNum) do begin
    mLineElement:='';
    If (i < mLineElementNum)
      then mLineElement:=LineElement(pStr, i, pSeparator);
    If (i = pNum)
      then mLineElement:=pChStr;
    If (i > 0)
      then Result:=Result + pSeparator;
    Result:=Result + mLineElement;
    inc(i);
  end;
end;

function  LineElementPos(const pStr: string; const pChStr: string; const pSeparator :char): integer;//new 1999.12.8.
var mElementNum: integer; I: integer;
begin
  Result:=-1;
  mElementNum:=LineElementNum(pStr, pSeparator);
  i:=0;
  If mElementNum > 0 then repeat
    If LineElement(pStr,i,pSeparator) = pChStr then Result:=i;
    Inc(i);
  until (I>=mElementNum) or (Result >= 0);
end;

function  LineElementInString(const pStr: string; const pChStr: string; const pSeparator :char): integer;//new 1999.12.8.
var mElementNum: integer; I: integer;
begin
  Result:=-1;
  mElementNum:=LineElementNum(pStr, pSeparator);
  i:=0;
  If mElementNum > 0 then repeat
    If Pos(LineElement(pStr,i,pSeparator),pChStr)>0 then Result:=i;
    inc(i);
  until (i >= mElementNum) or (Result >= 0);
end;

function GreaterEqual (pNum1,pNum2:double; pFract:byte): boolean;
var mDiff:double;  I:byte;  mFract:integer;
begin
  Result:=pNum1>pNum2;
  If not Result then begin
    mFract:=1;
    For I:=1 to pFract do
      mFract:=mFract*10;
    mDiff:=Abs(pNum1-pNum2);
    Result:=mDiff<=(1/mFract);
  end;
end;   { *** GretaerEqual *** }

function Equal(pNum1,pNum2:double; pFract:byte): boolean;
var mDiff:double;  I:byte;  mFract:integer;
begin
  mFract:=1;
  For I:=1 to pFract do
    mFract:=mFract*10;
  mDiff:=Abs(pNum1-pNum2);
  Result:=mDiff<=(1/mFract);
//  Result:=StrDoub(pNum1,0,pFract)=StrDoub(pNum2,0,pFract);
end;   { *** Equal *** }

function EqualD(pNum1,pNum2,pDiff:double): boolean;
begin
  Result:=Abs(pNum1-pNum2)<pDiff;
end;   { *** Equal *** }

function Eq1;
begin
  Result:=Abs (pNum1-pNum2)<0.09
end;   { *** Eq1 *** }


function Eq2;
begin
  Result:=Abs (pNum1-pNum2)<0.009
end;   { *** Eq2 *** }

function Eq3;
begin
  Result:=Abs (pNum1-pNum2)<0.0009
end;   { *** Eq3 *** }

function Eq4;
begin
  Result:=Abs (pNum1-pNum2)<0.00009
end;   { *** Eq4 *** }

function Eq5;
begin
  Result:=Abs (pNum1-pNum2)<0.000009
end;   { *** Eq5 *** }

function Eqd;
begin
  Result:=Abs (pNum1-pNum2)<pDifVal
end;   { *** Eq5 *** }

function Eqn (pNum:double; pFract:byte): boolean;
begin
  Result:=Equal (pNum,0,pFract);
end;

function Eqt (pText1,pText2:string): boolean; // TRUE ak zadane texty su rovnake
begin
  Result:=StrToAlias(pText1)=StrToAlias(ptext2);
end;

function IsNul (pValue:double): boolean; // TRUE ak pValue=0
begin
  Result:=Eqn (pValue,4);
end;

function IsNotNul (pValue:double): boolean; // TRUE ak pValue<>0
begin
  Result:=not Eqn (pValue,4);
end;

function IsNotNul2 (pValue:double): boolean; // TRUE ak pValue<>0
begin
  Result:=not Eqn (pValue,2);
end;

function SpecRnd5(pValue:double):double;
var mS,mLastNum:string; mSign:longint;
begin
  If Date>=StrToDate('01.07.2022') then begin
    If IsNotNul(pValue) then begin
      mSign := 1;
      If pValue<0 then mSign := -1;
      pValue := Abs (pValue);
      Result := pValue;
      pValue := Roundx (pValue,2);
      If pValue<=0.05 then begin
        Result := 0.05;
      end else begin
        mS:=StrDoub(pValue,0,2);
        mLastNum:=LineElement(mS,1,'.');
        mLastNum := Copy (mLastNum, 2, 1);
        Delete (mS, Length(mS), 1);
        Result := ValDoub(mS);
        case mLastNum[1] of
          '3','4','5','6','7': Result := Result + 0.05;
          '8','9': Result := Result + 0.1;
        end;
      end;
      Result := mSign*Result;
    end else Result:=0;
  end else begin
    Result := pValue;
  end;
end;

function  Sign (pNum:Double):integer;
var mS:integer;
begin
  mS:=0;
  If pNum > 0 then mS:=1;
  If pNum < 0 then mS:=-1;
  Result:=mS;
end;

function  GetMaxTextWidth (pS:TMemo; pForm: TWinControl):longint;
var
  I:longint;
  mMax:longint;
  mC:TPaintBox;
begin
  mMax:=0;
  mC:=TPaintBox.Create(pForm);
  mC.Parent:=pForm;
//  mC.Name:='PaintBox';
  mC.Canvas.Font:=pS.Font;
  if pS.Lines.Count>0 then begin
    For I:=0 to pS.Lines.Count-1 do begin
      If mC.Canvas.TextWidth(pS.Lines[I])>mMax then mMax:=mC.Canvas.TextWidth (pS.Lines[I]);
    end;
  end;
  mC.Free;
  Result:=mMax;
end;

function  GetTextWidth(pS:string;pF:TFont; pForm: TWinControl):longint;
var
  mC:TPaintBox;
  mW:longint;
begin
  mC:=TPaintBox.Create(pForm);
  mC.Parent:=pForm;
//  mC.Name:='PaintBox';
  mC.Canvas.Font:=pF;
  mW:=mC.Canvas.TextWidth (pS);
  mC.Free;
  Result:=mW;
end;

function  GetTextHeight(pF:TFont; pForm: TWinControl):longint;
var
  mC:TPaintBox;
  mH:longint;
begin
  mC:=TPaintBox.Create(pForm);
  mC.Parent:=pForm;
//  mC.Name:='APaintBox';
  mC.Canvas.Font:=pF;
  mH:=mC.Canvas.TextHeight ('TextHeight');
  mC.Free;
  Result:=mH;
end;

procedure CutNextParam (var pParam,pFld:string);
begin
  CutNextParamSepar (pParam,pFld,',');
end;

procedure CutNextParamSepar (var pParam,pFld:string;pSepar:string);
begin
  If Pos (pSepar,pParam)>0 then begin
    pFld:=Copy (pParam,1,Pos (pSepar,pParam)-1);
    Delete (pParam,1,Pos (pSepar,pParam)+Length (pSepar)-1);
  end else begin
    pFld:=pParam;
    pParam:='';
  end;
end;

function  GetNParams (pParam:string;pN:integer;pSepar:char):string;
var
  I:integer;
  mChSepar:char;
begin
  I:=0;
  If pSepar='|'
    then mChSepar:=';'
    else mChSepar:='|';
  If pN>0 then begin
    While (Pos (pSepar,pParam)>0) and (I<pN-1) do begin
      Insert (mChSepar,pParam,Pos (pSepar,pParam));
      Delete (pParam,Pos (pSepar,pParam),1);
      Inc (I);
    end;
    If (I=pN) or (I=pN-1) then begin
      If Pos (pSepar,pParam)>0 then pParam:=Copy (pParam,1,Pos (pSepar,pParam)-1);
      pParam:=ReplaceStr (pParam,mChSepar,pSepar);
    end else pParam:='';
  end else pParam:='';
  Result:=pParam;
end;

function  VarDataAsString (const Value: array of const;pNum:byte):string;
begin
  Result:='';
  If (High(Value)<255) and (pNum<=High(Value)+1) then begin
    If Value[pNum-1].VType=vtAnsiString then Result:=string (Value[pNum-1].VAnsiString);
    If Value[pNum-1].VType=vtInteger then Result:=StrInt (Value[pNum-1].VInteger,0);
    If Value[pNum-1].VType=vtExtended then Result:=StrDoub (Value[pNum-1].VExtended^,0,3);
  end;
end;

procedure FillTVarRec (const pRV: array of const;var pValue: array of TVarRec);
var I:integer;
begin
  If High (pRV)<255 then begin
    For I:=0 to High (pRV) do begin
      pValue[I].VType      :=pRV[I].VType;
      pValue[I].VInteger   :=pRV[I].VInteger;
      pValue[I].VBoolean   :=pRV[I].VBoolean;
      pValue[I].VChar      :=pRV[I].VChar;
      pValue[I].VExtended  :=pRV[I].VExtended;
      pValue[I].VString    :=pRV[I].VString;
      pValue[I].VPointer   :=pRV[I].VPointer;
      pValue[I].VPChar     :=pRV[I].VPChar;
      pValue[I].VObject    :=pRV[I].VObject;
      pValue[I].VClass     :=pRV[I].VClass;
      pValue[I].VWideChar  :=pRV[I].VWideChar;
      pValue[I].VPWideChar :=pRV[I].VPWideChar;
      pValue[I].VAnsiString:=pRV[I].VAnsiString;
      pValue[I].VCurrency  :=pRV[I].VCurrency;
      pValue[I].VVariant   :=pRV[I].VVariant;
      pValue[I].VInterface :=pRV[I].VInterface;
      pValue[I].VWideString:=pRV[I].VWideString;
      pValue[I].VInt64     :=pRV[I].VInt64;
    end;
  end;
end;

function  ConventionStrComp(pStr, pConvStr: string): boolean;
  procedure CSCSlave(var pStr, pConvStr: string);
    var
      mStrLen, mConvStrLen: integer;
      mInsStr: string;
      i, mPos: integer;
    begin
      mStrLen:=length(pStr);
      mConvStrLen:=length(pConvStr);
      mInsStr:='';
      for i:=0 to (mStrLen - mConvStrLen) do mInsStr:=mInsStr + '?';
      mPos:=pos('*',pConvStr);
      if mPos>0 then begin
        delete(pConvStr,mPos,1);
        insert(mInsStr, pConvStr,mPos);
      end;
    end;

var
  mPos, mLen: integer;
  mStr1, mStr2, mConvStr1, mConvStr2: string;
begin
  Result:=TRUE;
  if (pStr = '') and (pConvStr = '') then exit;
  Result:=FALSE;
  if (pStr = '') or  (pConvStr = '') then exit;
  // inentolegyiksemures
  mPos:=LPosCh('.', pStr);
  mStr1:=copy(pStr,1,mPos-1);
  mStr2:=copy(pStr,mPos, length(pStr));

  mPos:=LPosCh('.', pConvStr);
  mConvStr1:=copy(pConvStr,1,mPos-1);
  mConvStr2:=copy(pConvStr,mPos, length(pConvStr));

  if (length(mConvStr1) > length(mStr1)) or (length(mConvStr2) > length(mStr2)) then exit;

  CSCSlave(mStr1, mConvStr1);
  CSCSlave(mStr2, mConvStr2);

  pStr:=mStr1+'.'+mStr2;
  pConvStr:=mConvStr1+'.'+mConvStr2;

  mLen :=length(pStr);
  mPos:=1;
  while (mPos<=mLen) and ((pStr[mPos]=pConvStr[mPos]) or (pConvStr[mPos]='?')) do inc(mPos);
  Result:=(mPos > mLen);
end;

function  LPosCh(pChar: Char; pStr: string): integer;
var
  i: integer;
begin
  i:=length(pStr);
  while (i>0) and (pStr[i]<>pChar) do dec(i);
  Result:=i;
end;


function  StringInInt (pStr,pInt:string):boolean;
var
  mS:string;
  mF,mL:string;
begin
  Result:=FALSE;
  If pInt<>'' then begin
    Repeat
      If Pos (',',pInt)>0 then begin
        mS:=Copy (pInt,1,Pos (',',pInt)-1);
        Delete (pInt,1,Pos (',',pInt));
      end else begin
        mS:=pInt;
        pInt:='';
      end;
      If Pos ('..',mS)>0 then begin
        mF:=Copy (mS,1,Pos ('..',mS)-1);
        mL:=Copy (mS,Pos ('..',mS)+2,Length (mS));
        Result:=(mF<=pStr) and (mL>=pStr);
      end else begin
        Result:=(pStr=mS);
      end;
    until (pInt='') or Result;
  end else Result:=TRUE;
end;

function  LongInInt (pNum:longint;pInt:string):boolean;
var
  mS:string;
  mF,mL:longint;
begin
  Result:=FALSE;
  If pInt<>'' then begin
    Repeat
      If Pos (',',pInt)>0 then begin
        mS:=Copy (pInt,1,Pos (',',pInt)-1);
        Delete (pInt,1,Pos (',',pInt));
      end else begin
        mS:=pInt;
        pInt:='';
      end;
      If Pos ('..',mS)>0 then begin
        mF:=ValInt (Copy (mS,1,Pos ('..',mS)-1));
        mL:=ValInt (Copy (mS,Pos ('..',mS)+2,Length (mS)));
        Result:=(mF<=pNum) and (mL>=pNum);
      end else begin
        Result:=(pNum=ValInt (mS));
      end;
    until (pInt='') or Result;
  end else Result:=TRUE;
end;

function InLongInterval (pNum1,pNum2,pNum:LongInt): boolean;
begin
  If (pNum1=0) and (pNum2=0)
    then InLongInterval:=TRUE  // v pripade nezadaneho intervalu
    else InLongInterval:=(pNum1<=pNum) and (pNum<=pNum2);
end;

function InDoubInterval;
begin
  If Eq2(pNum1,0) and Eq2(pNum2,0)
    then InDoubInterval:=TRUE  { v pripade nezadaneho intervalu }
    else InDoubInterval:=Eq2(pNum1,pNum) or Eq2(pNum2,pNum) or ((pNum1<pNum) and (pNum<pNum2));
end;

function InTextInterval;
begin
  If (pTxt1='')  and (pTxt2='')  then InTextInterval:=TRUE; { v pripade nezadaneho intervalu }
  If (pTxt1<>'') and (pTxt2='')  then InTextInterval:=(pTxt1<=pTxt);
  If (pTxt1<>'') and (pTxt2<>'') then InTextInterval:=(pTxt1<=pTxt) and (pTxt<=pTxt2);
end;

function InDateInterval;
begin
  If (pDate1=0) and (pDate2=0)
    then Result:=TRUE  // v pripade nezadaneho intervalu
    else Result:=(pDate1<=pDate) and (pDate<=pDate2);
end;

function InTimeInterval;
begin
  If (pTime1=0) and (pTime2=0)
    then Result:=TRUE  // v pripade nezadaneho intervalu
    else Result:=(pTime1<=pTime) and (pTime<=pTime2);
end;

function  LongInInterval (pNum:longint;pInterval:string):boolean;
var
  mA:string;
  mF,mL,mM:longint;
begin
  If pInterval<>'' then begin
    If Pos (',,', pInterval)>0 then pInterval:=ReplaceStr (pInterval, ',,', '..');
    Result:=FALSE;
    Repeat
      If Pos (',',pInterval)>0 then begin
        mA:=Copy (pInterval,1,Pos (',',pInterval)-1);
        Delete (pInterval,1,Pos (',',pInterval));
      end else begin
        mA:=pInterval;
        pInterval:='';
      end;
      If Pos ('..',mA)>0 then begin
        mF:=ValInt (Copy (mA, 1, Pos ('..',mA)-1));
        mL:=ValInt (Copy (mA, Pos ('..',mA)+2,Length (mA)));
        If mL<mF then begin
          mM:=mF; mF:=mL; mL:=mM;
        end;
      end else begin
        mF:=ValInt (mA);
        mL:=mF;
      end;
//      If (mF<>0) and (mL<>0) then begin
        Result:=(pNum>=mF) and (pNum<=mL);
//      end;
    until (pInterval='') or Result;
  end else Result:=TRUE;
end;

function  FloatInInterval (pNum:double;pInterval:string):boolean;
var
  mA:string;
  mF,mL,mM:double;
begin
  If pInterval<>'' then begin
    If Pos (',,', pInterval)>0 then pInterval:=ReplaceStr (pInterval, ',,', '..');
    Result:=FALSE;
    Repeat
      If Pos (',',pInterval)>0 then begin
        mA:=Copy (pInterval,1,Pos (',',pInterval)-1);
        Delete (pInterval,1,Pos (',',pInterval));
      end else begin
        mA:=pInterval;
        pInterval:='';
      end;
      If Pos ('..',mA)>0 then begin
        mF:=ValDoub (Copy (mA, 1, Pos ('..',mA)-1));
        mL:=ValDoub (Copy (mA, Pos ('..',mA)+2,Length (mA)));
        If mL<mF then begin
          mM:=mF; mF:=mL; mL:=mM;
        end;
      end else begin
        mF:=ValDoub (mA);
        mL:=mF;
      end;
//      If (mF<>0) and (mL<>0) then begin
        Result:=(pNum>=mF) and (pNum<=mL);
//      end;
    until (pInterval='') or Result;
  end else Result:=TRUE;
end;

function  DateInInterval (pDate:TDateTime;pInterval:string):boolean;
var
  mA:string;
  mF,mL,mM:TDateTime;
begin
  If pInterval<>'' then begin
    If Pos (',,', pInterval)>0 then pInterval:=ReplaceStr (pInterval, ',,', '..');
    Result:=FALSE;
    Repeat
      If Pos (',',pInterval)>0 then begin
        mA:=Copy (pInterval,1,Pos (',',pInterval)-1);
        Delete (pInterval,1,Pos (',',pInterval));
      end else begin
        mA:=pInterval;
        pInterval:='';
      end;
      If Pos ('..',mA)>0 then begin
        try
          mF:=StrToDate (VerifyDate (Copy (mA, 1, Pos ('..',mA)-1)));
        except mF:=0; end;
        try
          mL:=StrToDate (VerifyDate (Copy (mA, Pos ('..',mA)+2,Length (mA))));
        except mL:=0; end;
        If mL<mF then begin
          mM:=mF; mF:=mL; mL:=mM;
        end;
      end else begin
        try
          mF:=StrToDate (VerifyDate (mA));
        except mF:=0; end;
        mL:=mF;
      end;
      If (mF<>0) and (mL<>0) then begin
        mL:=mL+StrToTime ('23:59:59');
        Result:=(pDate>=mF) and (pDate<=mL);
      end;
    until (pInterval='') or Result;
  end else Result:=TRUE;
end;

function  StrInInterval (pStr:string;pInterval:string):boolean;
begin
  Result:=TextInInterval (pStr,pInterval);
end;

function  TextInInterval (pStr:string;pInterval:string):boolean;
var mA:string;
  mF,mL,mM:string;
begin
  If pInterval<>'' then begin
    If Pos (',,', pInterval)>0 then pInterval:=ReplaceStr (pInterval, ',,', '..');
    Result:=FALSE;
    Repeat
      If Pos (',',pInterval)>0 then begin
        mA:=Copy (pInterval,1,Pos (',',pInterval)-1);
        Delete (pInterval,1,Pos (',',pInterval));
      end else begin
        mA:=pInterval;
        pInterval:='';
      end;
      If Pos ('..',mA)>0 then begin
        mF:=Copy (mA, 1, Pos ('..',mA)-1);
        mL:=Copy (mA, Pos ('..',mA)+2,Length (mA));
        If mL<mF then begin
          mM:=mF; mF:=mL; mL:=mM;
        end;
      end else begin
        mF:=mA;
        mL:=mA;
      end;
      If (mF<>'') and (mL<>'') then begin
        mL:=mL+Chr (255);
        Result:=(pStr>=mF) and (pStr<=mL);
      end;
    until (pInterval='') or Result;
  end else Result:=TRUE;
end;

procedure GetLongIntFirstLast (pInterval:string;var pFirst, pLast:longint);
var
  mA:string;
  mF, mL:longint;
  mCnt:longint;
begin
  pFirst:=0;
  pLast:=0;
  mCnt:=0;
  If pInterval<>'' then begin
    If Pos (',,', pInterval)>0 then pInterval:=ReplaceStr (pInterval, ',,', '..');
    Repeat
      If Pos (',',pInterval)>0 then begin
        mA:=Copy (pInterval,1,Pos (',',pInterval)-1);
        Delete (pInterval,1,Pos (',',pInterval));
      end else begin
        mA:=pInterval;
        pInterval:='';
      end;
      If Pos ('..',mA)>0 then begin
        mF:=ValInt (Copy (mA, 1, Pos ('..',mA)-1));
        mL:=ValInt (Copy (mA, Pos ('..',mA)+2,Length (mA)));
      end else begin
        mF:=ValInt (mA);
        mL:=mF;
      end;
      Inc (mCnt);
      If mCnt = 1 then begin
        pFirst:=mF;
        pLast:=mL;
      end else begin
        If pFirst>mF then pFirst:=mF;
        If pLast<mL then pLast:=mL;
      end;
    until (pInterval='');
  end;
end;

procedure GetFloatIntFirstLast (pInterval:string;var pFirst, pLast:double);
var
  mA:string;
  mF, mL:double;
  mCnt:longint;
begin
  pFirst:=0;
  pLast:=0;
  mCnt:=0;
  If pInterval<>'' then begin
    If Pos (',,', pInterval)>0 then pInterval:=ReplaceStr (pInterval, ',,', '..');
    Repeat
      If Pos (',',pInterval)>0 then begin
        mA:=Copy (pInterval,1,Pos (',',pInterval)-1);
        Delete (pInterval,1,Pos (',',pInterval));
      end else begin
        mA:=pInterval;
        pInterval:='';
      end;
      If Pos ('..',mA)>0 then begin
        mF:=ValDoub (Copy (mA, 1, Pos ('..',mA)-1));
        mL:=ValDoub (Copy (mA, Pos ('..',mA)+2,Length (mA)));
      end else begin
        mF:=ValDoub (mA);
        mL:=mF;
      end;
      Inc (mCnt);
      If mCnt = 1 then begin
        pFirst:=mF;
        pLast:=mL;
      end else begin
        If pFirst>mF then pFirst:=mF;
        If pLast<mL then pLast:=mL;
      end;
    until (pInterval='');
  end;
end;

procedure GetStrIntFirstLast (pInterval:string;var pFirst, pLast:string);
var
  mA:string;
  mF, mL:string;
  mCnt:longint;
begin
  pFirst:='';
  pLast:='';
  mCnt:=0;
  If pInterval<>'' then begin
    If Pos (',,', pInterval)>0 then pInterval:=ReplaceStr (pInterval, ',,', '..');
    Repeat
      If Pos (',',pInterval)>0 then begin
        mA:=Copy (pInterval,1,Pos (',',pInterval)-1);
        Delete (pInterval,1,Pos (',',pInterval));
      end else begin
        mA:=pInterval;
        pInterval:='';
      end;
      If Pos ('..',mA)>0 then begin
        mF:=Copy (mA, 1, Pos ('..',mA)-1);
        mL:=Copy (mA, Pos ('..',mA)+2,Length (mA))+Chr (255);
      end else begin
        mF:=mA;
        mL:=mA+Chr (255);
      end;
      Inc (mCnt);
      If mCnt = 1 then begin
        pFirst:=mF;
        pLast:=mL;
      end else begin
        If pFirst>mF then pFirst:=mF;
        If pLast<mL then pLast:=mL;
      end;
    until (pInterval='');
  end;
end;

procedure GetDateIntFirstLast (pInterval:string;var pFirst, pLast:TDate);
var
  mA:string;
  mF, mL:TDate;
  mCnt:longint;
begin
  pFirst:=0;
  pLast:=0;
  mCnt:=0;
  If pInterval<>'' then begin
    If Pos (',,', pInterval)>0 then pInterval:=ReplaceStr (pInterval, ',,', '..');
    Repeat
      If Pos (',',pInterval)>0 then begin
        mA:=Copy (pInterval,1,Pos (',',pInterval)-1);
        Delete (pInterval,1,Pos (',',pInterval));
      end else begin
        mA:=pInterval;
        pInterval:='';
      end;
      If Pos ('..',mA)>0 then begin
        try
          mF:=StrToDate (VerifyDate (Copy (mA, 1, Pos ('..',mA)-1)));
        except mF:=0; end;
        try
          mL:=StrToDate (VerifyDate (Copy (mA, Pos ('..',mA)+2,Length (mA))));
        except mL:=0; end;
      end else begin
        try
          mF:=StrToDate (VerifyDate (mA));
        except mF:=0; end;
        mL:=mF
      end;
      Inc (mCnt);
      If mCnt = 1 then begin
        pFirst:=mF;
        pLast:=mL;
      end else begin
        If pFirst>mF then pFirst:=mF;
        If pLast<mL then pLast:=mL;
      end;
    until (pInterval='');
  end;
end;

function  VerifyDate (pDate:string):string;
var mDateS:string;  mD,mM,mY:word;  mWD:longint;
begin
  pDate:=RemLeftSpaces (RemRightSpaces (pDate));
  If (pDate='.') or (pDate=',') then begin
    try
      mDateS:=ReplaceStr (DateToStr (Date),' ','');
    except mDateS:=''; end;
  end else begin
    mDateS:='';
    mWD:=1;
    DecodeDate (Date,mY,mM,mD);
    mDateS:=ReplaceStr (pDate,',','.');
    If (Length (mDateS)>2) and (Pos ('.',mDateS)=0) then begin
      Insert ('.',mDateS,3);
      If Length (mDateS)>5 then Insert ('.',mDateS,6);
    end;
    If Pos ('.',mDateS)>0 then begin
      mD:=ValInt (Copy (mDateS,1,Pos ('.',mDateS)-1));
      mDateS:=Copy (mDateS,Pos ('.',mDateS)+1,Length (mDateS));
      If Pos ('.',mDateS)>0 then begin
        mM:=ValInt (Copy (mDateS,1,Pos ('.',mDateS)-1));
        mDateS:=Copy (mDateS,Pos ('.',mDateS)+1,Length (mDateS));
        If mDateS<>'' then begin
          mY:=ValInt (mDateS);
         If mY<100 then begin
           If mY<90
             then mY:=mY+2000
             else mY:=mY+1900;
         end;
        end;
      end else mM:=ValInt (mDateS);
    end else mD:=ValInt (mDateS);
    If (mY=0) or (mM=0) or (mD=0)
      then mDateS:=''
      else begin
        try
          mDateS:=ReplaceStr (DateToStr (EncodeDate (mY,mM,mD)),' ','');
        except mDateS:=''; end;
      end;
  end;
  VerifyDate:=mDateS;
end;

function  VerifyTime (pTime:string):string;
var mTimeS:string;  mWD:longint;
begin
  Result:=pTime;
  mTimeS:=RemLeftSpaces (RemRightSpaces (pTime));
  try
    Result:=TimeToStr(StrToTime(mTimeS));
  except
    If pTime<>'' then
    begin
      Result:=TimeToStr(Time);
    end;
  end;
  (*
  pTime:=RemLeftSpaces (RemRightSpaces (pTime));
  If (pTime='.') or (pTime=',') then begin
    try
      mTimeS:=ReplaceStr (TimeToStr (Time),' ','');
    except mTimeS:=''; end;
  end else begin
    mTimeS:='';
    mWD:=1;
    DecodeTime (Time,mh,mM,ms,mn);
    mTimeS:=ReplaceStr (pTime,',','.');
    If (Length (mTimeS)>2) and (Pos ('.',mTimeS)=0) then begin
      Insert ('.',mTimeS,3);
      If Length (mTimeS)>5 then Insert ('.',mTimeS,6);
    end;
    If Pos ('.',mTimeS)>0 then begin
      mD:=ValInt (Copy (mTimeS,1,Pos ('.',mTimeS)-1));
      mTimeS:=Copy (mTimeS,Pos ('.',mTimeS)+1,Length (mTimeS));
      If Pos ('.',mTimeS)>0 then begin
        mM:=ValInt (Copy (mTimeS,1,Pos ('.',mTimeS)-1));
        mTimeS:=Copy (mTimeS,Pos ('.',mTimeS)+1,Length (mTimeS));
        If mTimeS<>'' then begin
          mY:=ValInt (mTimeS);
         If mY<100 then begin
           If mY<90
             then mY:=mY+2000
             else mY:=mY+1900;
         end;
        end;
      end else mM:=ValInt (mTimeS);
    end else mD:=ValInt (mTimeS);
    If (mY=0) or (mM=0) or (mD=0)
      then mTimeS:=''
      else begin
        try
          mTimeS:=ReplaceStr (TimeToStr (EncodeTime (mY,mM,mD)),' ','');
        except mTimeS:=''; end;
      end;
  end;
  VerifyTime:=mTimeS;
  *)
end;

function  GetDayNameOfWeek (pDate:TDate):string;
var mDay:word;
begin
  Result:='';
  mDay:=DayOfWeek (pDate);
  case mDay of
    1: Result:='Ne';
    2: Result:='Po';
    3: Result:='Ut';
    4: Result:='St';
    5: Result:='ät';
    6: Result:='Pi';
    7: Result:='So';
  end;
end;

function RoundTimeToQuarter (pTime:TTime;pRoundUp:boolean):TTime;
var
 mH,mM,mS,mMS:word;
begin
  DecodeTime(pTime,mH, mM, mS, mMS);
  mS:=0;
  mMS:=0;
  If pRoundUp then begin
    case mM of
      1..15: mM:=15;
      16..30: mM:=30;
      31..45: mM:=45;
      46..59: begin
                mM:=0;
                mH:=mH+1;
                If mH>23 then mH:=0;
              end;
    end;
  end else begin
    case mM of
      0..14: mM:=0;
      15..29: mM:=15;
      30..44: mM:=30;
      45..59: mM:=45;
    end;
  end;
  Result:=EncodeTime (mH, mM, mS, mMS);
end;

function RoundTimeToMin (pTime:TTime):TTime;
var
 mH,mM,mS,mMS:word;
begin
  DecodeTime(pTime,mH, mM, mS, mMS);
  mS:=0;
  mMS:=0;
  Result:=EncodeTime (mH, mM, mS, mMS);
end;

function GetLastNonNumericChar;
var mI : integer;
begin
  mI:=Length(pStr);
  Result:=#0;
  while (mI>0) and (pStr[mI] in ['0'..'9']) do Dec(mI);
  If mI>0 then Result:=pStr[mI]; 
end;

procedure LoadSectionFromFile (pFileName,pSecName:ShortString; pSecFile:TStrings);
var mFile:TStrings;  mCnt:word;  mFind:boolean;
begin
  pSecFile.Clear;
  mFile:=TStringList.Create; // Cely subor
  mFile.LoadFromFile(pFileName);
  If mFile.Count>0 then begin
    mCnt:=0;
    // Najdeme zadanu sekciu
    Repeat
      mFind:=UpString(mFile.Strings[mCnt])=UpString('['+pSecName+']');
      Inc (mCnt);
    until (mCnt=mFile.Count) or mFind;
    // Premiestnime zadanu sekciu do pSecFile
    If mFind and (mCnt<>mFile.Count) then begin
      mFind:=FALSE;
      Repeat
        pSecFile.Add (mFile.Strings[mCnt]);
        If mCnt<mFile.Count-1 then mFind:=Pos('[',mFile.Strings[mCnt+1])=1;
        Inc (mCnt);
      until (mCnt=mFile.Count) or mFind;
    end;
  end;
  FreeAndNil (mFile);
end;

function IsNumChar (pChar:Char):boolean; // TRUEA ak zadane znak je cislo
begin
  Result:=pChar in ['0','1','2','3','4','5','6','7','8','9'];
end;

function  LongIntervalToSql (pFldname:Str30;pInterval:string):String;
var mR,mA:string;  mF,mL,mM:longint;
begin
  If pInterval<>'' then begin
    If Pos (',,', pInterval)>0 then pInterval:=ReplaceStr (pInterval, ',,', '..');
    mR:='';
    Repeat
      If Pos (',',pInterval)>0 then begin
        mA:=Copy (pInterval,1,Pos (',',pInterval)-1);
        Delete (pInterval,1,Pos (',',pInterval));
      end else begin
        mA:=pInterval;
        pInterval:='';
      end;
      If Pos ('..',mA)>0 then begin
        mF:=ValInt (Copy (mA, 1, Pos ('..',mA)-1));
        mL:=ValInt (Copy (mA, Pos ('..',mA)+2,Length (mA)));
        If mL<mF then begin
          mM:=mF; mF:=mL; mL:=mM;
        end;
        mR:=mR+' OR (('+pFldname+'>='+IntToStr(mF)+') AND ('+pFldname+'<='+IntToStr(mL)+'))';
      end else begin
        mF:=ValInt (mA);
        mL:=mF;
        MR:=MR+' OR ('+pFldname+'='+IntToStr(mF)+')';
      end;
    until (pInterval='') ;
    Result:='('+copy(MR,5,length(MR)-4)+')';
  end else Result:='';
end;

function DecNumStr (pStr:String):String; // vrati numericky retaz znizeny o 1
begin
  If NumStrip(pStr)='' then Result:=IntToStr(ValInt(pStr)-1);
end;

function IncNumStr (pStr:String):String; // vrati numericky retaz zvyseny o 1
begin
  If NumStrip(pStr)='' then Result:=IntToStr(ValInt(pStr)+1);
end;

function CombineStr(pStr1,pStr2,pDelim:String):String; // vrati spojeny retazec pStr1+pDelim+pStr2 resp. pStr2 ak pStr1 je prazdny
begin
  If pStr1='' then Result:=pStr2 else Result:=pStr1+pDelim+pStr2;
end;

function WildComp(const mask: String; const target: String): Boolean;

    // '*' matches greedy & ungreedy
    // simple recursive descent parser - not fast but easy to understand
    function WComp(const maskI: Integer; const targetI: Integer): Boolean;
    begin

        if maskI > Length(mask) then begin
            Result:=targetI = Length(target) + 1;
            Exit;
        end;
        if targetI > Length(target) then begin
            // unread chars in filter or would have read '#0'
            Result:=False;
            Exit;
        end;

        case mask[maskI] of
            '*':
                // '*' doesnt match '.'
                if target[targetI] <> '.' then
                    // try with and without ending match - but always matches at least one char
                    Result:=WComp(succ(maskI), Succ(targetI)) or WComp(maskI, Succ(targetI))
                else
                    Result:=False;
            '?':
                // ? doesnt match '.'
                if target[targetI] <> '.' then
                    Result:=WComp(succ(maskI), Succ(targetI))
                else
                    Result:=False;

            else     // includes '.' which only matches itself
                if mask[maskI] = target[targetI] then
                    Result:=WComp(succ(maskI), Succ(targetI))
                else
                    Result:=False;
        end;// case

    end;
begin
    WildComp:=WComp(1, 1);
end;

end.

