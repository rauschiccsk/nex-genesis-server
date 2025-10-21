unit IcConv; //01.07.2000 Rausch Zolt·n

interface

uses
  IcVariab, IcTypes,
  Windows, ComCtrls, RichEdit, 
  DB, Controls, StdCtrls, SysUtils, Graphics, Forms, ExtCtrls, Classes,
  IdCoderQuotedPrintable,
  Qrctrls, Barqr5;

  Function Reverse (N:LongInt) : LongInt ;
           // prevod Little Endian na Big Endian  ** http://www.cs.umass.edu/~Verts/cs32/endian.html **
  function ByteToBool (pNum:byte):boolean;
           //Prekonvertuje byte na boolean
  function BoolToByte (pVal:boolean):byte;
           //Prekonvertuje boolean na byte
  function StrInt (pNum:integer;pWidth:byte):ShortString;
           //Prekonvertuje celÈ ËÌslo na string
  function StrIntZero (pNum:integer;pWidth:byte):ShortString;
           //Prekonvertuje celÈ ËÌslo na string a z predu doplnÌ s nulami
  function StrDoub (pNum:double;pWidth,pDeci:byte):ShortString;
           //PrekonvertujÈ re·lne ËÌslo na string
  function StrDoubComma (pNum:double;pWidth,pDeci:byte):ShortString;
           //PrekonvertujÈ re·lne ËÌslo na string
  function StrDoubZero (pNum:double;pWidth,pDeci:byte):ShortString;
           //{Prekonvertuje re·lne ËÌslo na string a z predu doplnÌ s nulami
  function StrDate (pDate:double):Str10;
           // Prekonvertujezadany datum na format DD.MM.YYYY
  function ValInt (pStr:ShortString):integer;
           //Prekonvertuje string na celÈ ËÌslo
  function ValDoub (pStr:ShortString):double;
           //Prekonvertuje string na re·lne ËÌslo
  function StripFractZero (pNum:ShortString): ShortString;
           //Odstrani zbytocne nuly za desatinnou ciarkou

  function StrRealSepar (pNum:double;pLen,pFrac:byte;pSepar:boolean):Str100;  //Prekonvertuje ËÌslo na textov˝ Form·t tak, ûe tisÌcky s˙ oddelenÈ medzerami
           //pNum - je ËÌslo, ktor˙ chceme prekonvertovaù, pLen - dÂûka celÈho ËÌsla, pFrac - dÂûka desatinnÈho ËÌsla, pSepar - ak je FALSE, nepouûÌva medzeru
  function StrIntSepar (pNum:integer;pLen:byte;pSepar:boolean):Str100;

  function TextCheckSumCalc (pText:string):longint; // Kontrolne cislo pre zadany retazec

  function DosCharToWinChar(pChar: char): char;
  function DosCharToWinChar2(pChar: char): char;    //Pre Majka firma Merck v programe LabPrn
  function WinCharToDosChar(pChar: char):char;  //ez egy kicsit lassu mivel csak visszafejti a kodot (nincs ra kulon tablazat)
  function DosStringToWinString(pString: string): string;
  function WinStringToDosString(pString: string): string;
  function DosStrToWinStr  (pStr: string): string; //Prekonvertuje Dos string na Win String
  function DosStrToWinStr2  (pStr: string): string; //Pre Majke firma Merck v programe LabPrn

  function CharToAlias(pChar: char): char; //1999.12.14.    //Karakter atalakitasa Alulcsikos karakterre
  function StrToAlias (pStr: string): string; //1999.12.14. //String atalakitasa Alulcsikos stringe
  function ConvToNoDiakr (pStr: string): string; // Zmeni diakriticke znaky na nediakriticke

  function ConvKamToLat (pStr:string):string;
  function Win1250ToLatin2(pStr: string):string;
  function Latin2ToWin1250(pStr: string):string;

  function DecToHEX (pDec:longint;pLen:byte):string;
           //Prekonvertuje decimalne cislo na hexadecimalne
  function HEXToDec (pHEX:string):longint;
           //Prekonvertuje hexadecimalne cislo na decimalne

  function UpChar (pChar:Char): Char;
           // Uskutocni zmenu maleho pisma na velke podla gvSys.Language
  function UpString (pString:string): string;
           // Uskutocni zmenu retazca na velke pismena podla gvSys.Language

  function GetMaxTextWidth (pS:TMemo; pForm: TWinControl):longint;
           //Funcia vr·ti maxim·lnu öÌrku textu v pS v pixeloch
  function GetTextWidth(pS:string;pF:TFont; pForm: TWinControl):longint;
           //Funkcia vr·ti öÌrku textu pri zadanom nastavenÌ pÌsmien
  function GetTextHeight(pF:TFont; pForm: TWinControl):longint;
           //Funkcia vr·ti v˝öku textu pri zadanom nastavenÌ pÌsmien
  function RemNonCharNum(pStr:string):string;
           // funkcia odstrani vsetky znaky okrempismen a cisel
  function ReplaceNonCharNum(pStr:string;pRChar:char):string;
           // funkcia nahradi vsetky znaky okrem pismen a cisel zadanym znakom
  function RemoveLastBS(pStr:string):string;

  function LongIntervalFilt (pFld:integer; pFr,pTo:longint) : string;
  { funkcia podla zadaneho intervalu celych cisiel vrati retazec pre metodu SetFilterOn }
  function DoubIntervalFilt (pFld:integer; pFr,pTo:double) : string;
  { funkcia podla zadaneho intervalu realnych cisiel vrati retazec pre metodu SetFilterOn }
  function TextIntervalFilt (pFld:integer; pFr,pTo:string) : string;
  { funkcia podla zadaneho intervalu textov vrati retazec pre metodu SetFilterOn }
  function DateIntervalFilt (pFld:integer; pFr,pTo:TDate;pFrC,pToC:boolean) : string;
  { funkcia podla zadaneho intervalu datumu vrati retazec pre metodu SetFilterOn }
  function TimeIntervalFilt (pFld:integer; pFr,pTo:TTime;pFrC,pToC:boolean) : string;
  { funkcia podla zadaneho intervalu casu vrati retazec  pre metodu SetFilterOn }

  function FindMyFldName(pDS:TDataSet;pFldName:String):integer;

  function TextStrip (pText:string): string;
  function NumStrip (pText:ShortString): ShortString;
  function NulBegStrip (pText:ShortString): ShortString; // vymaze z retazca zaciatocne nuly

  function UnicodeIntToStr (pStr:string):string;
  //PremenÌ Unicode kÛdy tvaru integer v texte (napr. #318 = æ) na windows diakritiku
  function UnicodeIntToChar (pStr:string):string;
  //PremenÌ jeden unicode znak tvare 2 byte na diakritick˝ znak
  function CutPoundNum (var pStr:string):string;
  //PremenÌ unicode znaky v tvare integer na 2 byte-ov˝ unicode

  function StrToBarCodeType(pData:string):TBarCodeType;
           // prevod retzca na typ ciaroveho kodu
  function StrToShapeType(pData:string):TQRShapeType;
           // prevod retzca na typ utvaru
  function StrToFrameStyle(pData:string):TPenStyle;
           // prevod retzca na typ ramceka
  function StrToPenStyle(pData:string):TPenStyle;
           // prevod retzca na typ ciary
  function StrToBrushStyle(pData:string):TBrushStyle;
           // prevod retazca na typ vyplne
  function StrToSysDataType(pData:string):TQRSysDataType;
           // prevod retazca na typ premenej QRSysdata
  function StrToAlignment(pAlign:string):TAlignment;
           // prevod retazca na typ zarovania
  function StrToFontStyle(pFS:string):TFontStyles;
           // prevod retazca na typ fontu

  function BarCodeTypeToStr(pData:TBarCodeType):string;
           // prevod typu ciaroveho kodu na retazec
  function ShapeTypeToStr(pData:TQRShapeType):string;
           // prevod typu utvaru na retazec
  function FrameStyleToStr(pData:TPenStyle):string;
           // prevod typu ramceka na retazec
  function PenStyleToStr(pData:TPenStyle):string;
           // prevod typu ciary na retazec
  function BrushStyleToStr(pData:TBrushStyle):string;
           // prevod typu vyplne na retazec
  function SysDataTypeToStr(pData:TQRSysDataType):string;
           // prevod typu premennej QRSysdata na retazec
  function AlignmentToStr(pAlign:TAlignment):string;
           // prevod typu zarovnania na retazec
  function FontStyleToStr(pFS:TFontStyles):string;
           // prevod typu fontu na retazec
  function StrToSpaceStr(pS:String):String;
           // prevod retazca na retazec oddeleny medzerami

  function SeparString (pValue:ShortString):ShortString; // Funkcia vrati zadany text formate kde jedotlive znaky su rozdelene medzerami
  function SeparDoub (pValue:double;pFract:byte):ShortString; // Funkcia vrati zadanu hodnotu v textovom formate kde jedotlive znaky su rozdelene medzerami

  function TextToHtml(s: string): string;

  function DeleteUTF8ControlStrings(Text: String): String;
  function MailsUtf8Convert(Subject: String): String;
  function Utf8Convert(Subject: String): String;
  function LoadUnicodeFileToStr(pFileName:string):string;
  function EAN128Decode(pEAN: String;var pRbaCode:Str30;var pRbaDate:TDate): boolean;

implementation

uses
  IcTools;

const
  ChToCh: array [128..255] of byte =       (128, 129,
    130, 131, 132, 133, 134, 135, 136, 137, 138, 139,
    140, 141, 142, 143, 144, 145, 146, 147, 148, 149,
    150, 151, 152, 153, 154, 155, 156, 157, 158, 159,
    160, 161, 162, 163, 164, 165, 166, 167, 168, 169,
    170, 171, 172, 173, 174, 175, 176, 177, 178, 179,
    180, 181, 182, 183, 184, 185, 186, 187, 188, 189,
    190, 191, 192, 193, 194, 195, 196, 197, 198, 199,
    200, 201, 202, 203, 204, 205, 206, 207, 208, 209,
    210, 211, 212, 213, 214, 215, 216, 217, 218, 219,
    220, 221, 222, 223, 224, 225, 226, 227, 228, 229,
    230, 231, 232, 233, 234, 235, 236, 237, 238, 239,
    240, 241, 242, 243, 244, 245, 246, 247, 248, 249,
    250, 251, 252, 253, 254, 255);

{old 1999.7.17. ChDosToChWin: array [128..255] of byte =  (200, 252,
    233, 239, 228, 249, 141, 232, 179, 235, 188, 245,
    190, 190, 196, 198, 201, 158, 142, 244, 246, 188,
    190, 218, 253, 214, 220, 138, 157, 163, 215, 157,  
    225, 237, 243, 250, 242, 185, 142, 158, 154, 248,
    160, 159, 200, 186, 171, 187, 176, 177, 178, 179,
    180, 193, 194, 204, 170, 185, 186, 187, 188, 175,
    191, 191, 192, 193, 194, 195, 196, 197, 195, 227,
    200, 201, 202, 203, 204, 205, 206, 164, 240, 208,
    207, 203, 239, 210, 205, 206, 236, 217, 218, 219,
    220, 222, 217, 223, 211, 223, 212, 209, 241, 242,
    139, 154, 192, 218, 224, 219, 253, 221, 254, 180,
    173, 189, 178, 161, 162, 167, 247, 130, 176, 168,
    255, 251, 216, 248, 149, 255);
}
                                            {128, 129}
 ChDosToChWin: array [128..255] of byte =  ( 200, 252,

         {130, 131, 132, 133, 134, 135, 136, 137, 138, 139,}
    {130} 233, 239, 228, 207, 141, 232, 236, 204, 197, 205,

         {140, 141, 142, 143, 144, 145, 146, 147, 148, 149,}
    {140} 190, 229, 196, 193, 201, 158, 142, 244, 246, 211,

         {150, 151, 152, 153, 154, 155, 156, 157, 158, 159,}
    {150} 249, 218, 253, 214, 220, 138, 188, 221, 216, 157,

         {160, 161, 162, 163, 164, 165, 166, 167, 168, 169,}
    {160} 225, 237, 243, 250, 242, 210, 217, 212, 154, 248,

         {170, 171, 172, 173, 174, 175, 176, 177, 178, 179,}
    {170} 224, 192, 172, 167, 174, 175, 176, 177, 178, 179,

         {180, 181, 182, 183, 184, 185, 186, 187, 188, 189,}
    {180} 180, 230, 182, 183, 184, 185, 186, 187, 188, 189,

         {190, 191, 192, 193, 194, 195, 196, 197, 198, 199,}
    {190} 190, 191, 192, 193, 194, 195, 196, 197, 198, 199,

         {200, 201, 202, 203, 204, 205, 206, 207, 208, 209,}
    {200} 200, 201, 202, 203, 204, 205, 206, 207, 208, 209,

         {210, 211, 212, 213, 214, 215, 216, 217, 218, 219,}
    {210} 210, 211, 212, 213, 214, 215, 216, 217, 218, 219,

         {220, 221, 222, 223, 224, 225, 226, 227, 228, 229,}
    {220} 220, 221, 222, 223, 224, 225, 226, 227, 228, 229,

         {230, 231, 232, 233, 234, 235, 236, 237, 238, 239,}
    {230} 181, 231, 232, 233, 234, 235, 236, 237, 238, 239,

         {240, 241, 242, 243, 244, 245, 246, 247, 248, 249,}
    {240} 240, 241, 242, 243, 244, 245, 246, 247, 248, 249,

         {250, 251, 252, 253, 254, 255}
    {250} 250, 251, 252, 253, 166, 255);

 ChDosToChWin2: array [128..255] of byte =  (199, 252,
    233, 174, 228, 249, 230, 231, 179, 235, 213, 245,
    238, 143, 196, 198, 201, 197, 229, 244, 246, 188,
    190, 140, 156, 214, 220, 141, 157, 163, 215, 232,
    225, 237, 243, 250, 165, 185, 142, 158, 202, 234,
    160, 159, 200, 186, 171, 187, 176, 177, 178, 179,
    180, 193, 194, 204, 170, 185, 186, 187, 188, 175,
    191, 191, 192, 193, 194, 195, 196, 197, 195, 227,
    200, 201, 202, 203, 204, 205, 206, 164, 240, 208,
    207, 203, 239, 210, 205, 206, 236, 217, 218, 219,
    220, 222, 217, 223, 211, 223, 212, 209, 241, 242,
    138, 154, 192, 218, 224, 219, 253, 221, 254, 180,
    173, 189, 178, 161, 162, 167, 247, 130, 176, 168,
    255, 251, 216, 248, 149, 255);

 ChToAlias: array [128..255] of byte =     (128, 129,
    130, 131, 132, 133, 134, 135, 136, 137,  83, 139,
     83,  84,  90,  90, 144, 145, 146, 147, 148, 149,
    150, 151, 152, 153, 115, 155, 115, 116, 122, 122,
    160, 161, 162,  76, 164,  65, 166, 167, 168, 169,
    183, 171, 172, 173,  82,  90, 176, 177, 178, 108,
    180, 181, 182, 183, 184,  97, 115, 187, 176, 189,
    108, 122,  82,  65,  65,  65,  65,  76,  67,  67,
     67,  69,  69,  69,  69,  73,  73,  68,  68,  78,
     78,  79,  79,  79,  79, 215,  82,  85,  85,  85,
     85,  89,  84, 223, 114,  97,  97,  97,  97, 108,
     99,  99,  99, 101, 101, 101, 101, 105, 105, 100,
    100, 110, 110, 111, 111, 111, 111, 247, 114, 117,
    117, 117, 117, 121, 116, 255);

  cLatin2: array [128..255] of byte =      (200, 252,
    233, 239, 228, 207, 141, 232, 216, 183, 145, 214,
    150, 146, 142, 181, 144, 167, 166, 147, 148, 224,
    133, 233, 236, 153, 154, 230, 149, 237, 252, 156,
    160, 161, 162, 163, 229, 213, 222, 226, 231, 253,
    234, 232, 207, 245, 174, 175, 176, 177, 178, 179,
    180, 207, 207, 207, 207, 185, 186, 187, 188, 207,
    207, 191, 192, 193, 194, 195, 196, 197, 207, 207,
    200, 201, 202, 203, 204, 205, 206, 207, 207, 207,
    207, 207, 207, 207, 207, 207, 207, 217, 218, 219,
    220, 207, 207, 223, 207, 225, 207, 207, 207, 207,
    207, 232, 207, 207, 207, 207, 207, 207, 207, 207,
    240, 207, 207, 207, 207, 207, 246, 241, 248, 207,
    207, 207, 207, 207, 254, 255);

 ChWinToLatin2: array [128..255] of byte =    ( 128,  32,
  {130}  39,  32,  34,  32,  32,  32,  32,  32, 230,  32,
  {140} 151, 155, 166, 141,  32,  39,  39,  34,  34, 186,
  {150} 196, 196,  32,  32, 231,  32, 151, 156, 167, 141,
  {160}  32, 243, 244, 157, 207, 164,  58, 245, 249,  99,
  {170} 184, 174, 170,  32,  82, 189, 248,  32, 242, 136,
  {180} 239,  32,  32, 250, 247, 165, 173, 175, 149, 241,
  {190} 150, 190, 232, 181, 182, 198, 142, 149, 143, 128,
  {200} 172, 144, 168, 211, 183, 214, 215, 210, 209, 227,
  {210} 213, 224, 226, 138, 153, 158, 252, 222, 233, 235,
  {220} 154, 237, 221, 225, 234, 160, 131, 199, 132, 146,
  {230} 134, 135, 159, 130, 169, 137, 216, 161, 140, 212,
  {240} 208, 228, 229, 162, 147, 139, 148, 246, 253, 133,
  {250} 163, 251, 129, 236, 238, 250);


//**********************************************************

Function Reverse (N:LongInt) : LongInt ;
Var B0, B1, B2, B3 : Byte ;
  Begin
      B0 := (N AND $000000FF) SHR  0 ;
      B1 := (N AND $0000FF00) SHR  8 ;
      B2 := (N AND $00FF0000) SHR 16 ;
      B3 := (N AND $FF000000) SHR 24 ;
      Reverse := (B0 SHL 24) OR (B1 SHL 16) OR (B2 SHL 8) OR (B3 SHL 0) ;
  End ;

function  FindMyFldName;
var i: integer;
begin
  i:=0;
  while (i<pDS.FieldCount)and (UpperCase(pDS.fields[i].FieldName)<>UpperCase(pFldName))
    do Inc(i);
  If (i>=pDS.FieldCount)or(UpperCase(pDS.fields[i].FieldName)<>UpperCase(pFldName)) then i:=-1;
  Result:=i;
end;

  FUNCTION   LongIntervalFilt;
    var mFr,mTo:Str20;
        mSp:Str1;
    BEGIN
      mFr := '';
      mTo := '';
      If pFr <> pTo  then begin  {lebo mozu bit -100 a 100}
        mFr := '['+IntToStr(pFld)+']>={'+StrInt(pFr,0)+'}';
        mTo := '['+IntToStr(pFld)+']<={'+StrInt(pTo,0)+'}';
      end else if pFr<>0 then mTo:='['+IntToStr(pFld)+']={'+StrInt(pTo,0)+'}';
      If (mFr <> '') and (mTo <> '') then mSp := '^' else mSp := '';
      LongIntervalFilt := mFr+mSp+mTo;
    END;     { *** DoubIntervalLong *** }

  FUNCTION   DoubIntervalFilt;
    var mFr,mTo:Str20;
        mSp:Str1;
    BEGIN
      mFr := '';
      mTo := '';
      If pFr <> pTo  then begin  {lebo mozu bit -100 a 100}
        mFr := '['+IntToStr(pFld)+']>={'+StrDoub(pFr,0,2)+'}';
        mTo := '['+IntToStr(pFld)+']<={'+StrDoub(pTo,0,2)+'}';
      end else if pFr<>0 then mTo:='['+IntToStr(pFld)+']={'+StrDoub(pTo,0,2)+'}';
      If (mFr <> '') and (mTo <> '') then mSp := '^' else mSp := '';
      DoubIntervalFilt := mFr+mSp+mTo;
    END;     { *** DoubIntervalFilt *** }

  FUNCTION   TextIntervalFilt;
    var mFr,mTo:Str20;
        mSp:Str1;
    BEGIN
      mFr := '';
      mTo := '';
      If pFr <> pTo  then begin
        mFr := '['+IntToStr(pFld)+']>={'+pFr+'}';
        mTo := '['+IntToStr(pFld)+']<={'+pTo+'}';
      end else if pFr<>'' then mTo:='['+IntToStr(pFld)+']={'+pTo+'}';
      If (mFr <> '') and (mTo <> '') then mSp := '^' else mSp := '';
      TextIntervalFilt := mFr+mSp+mTo;
    END;     { *** TextIntervalFilt *** }

  FUNCTION   DateIntervalFilt;
    var mFr,mTo:Str20;
        mSp:Str1;
    BEGIN
      mFr := '';
      mTo := '';
      If pFrC or pToC then begin
        If pFr <> pTo  then begin
          If pFrC then mFr := '['+IntToStr(pFld)+']>={'+DateToStr(pFr)+'}';
          If pToC then mTo := '['+IntToStr(pFld)+']<={'+DateToStr(pTo)+'}';
        end else begin
          if pFrC then mTo:='['+IntToStr(pFld)+']={'+DateToStr(pFr)+'}';
          if pToC then mTo:='['+IntToStr(pFld)+']={'+DateToStr(pTo)+'}';
        end;
      end;
      If (mFr <> '') and (mTo <> '') then mSp := '^' else mSp := '';
      DateIntervalFilt := mFr+mSp+mTo;
    END;     { *** DateIntervalFilt *** }

  FUNCTION   TimeIntervalFilt;
    var mFr,mTo:Str20;
        mSp:Str1;
    BEGIN
      mFr := '';
      mTo := '';
      If pFr <> pTo  then begin
        mFr := '['+IntToStr(pFld)+']>={'+TimeToStr(pFr)+'}';
        mTo := '['+IntToStr(pFld)+']<={'+TimeToStr(pTo)+'}';
      end else if (pFr<>0)  then mTo:='['+IntToStr(pFld)+']={'+TimeToStr(pTo)+'}';
      If (mFr <> '') and (mTo <> '') then mSp := '^' else mSp := '';
      TimeIntervalFilt := mFr+mSp+mTo;
    END;     { *** TimeIntervalFilt *** }


function ByteToBool (pNum:byte):boolean; //Prekonvertuje byte na boolean
begin
  Result := pNum>0;
end;

function BoolToByte (pVal:boolean):byte;//Prekonvertuje boolean na byte
begin
  If pVal then Result := 1 else Result := 0;
end;

function  StrInt (pNum:longint;pWidth:byte):ShortString;
var mStr:Str100;
begin
  Str (pNum:pWidth,mStr);
  Result := mStr;
end;

function  StrIntZero (pNum:longint;pWidth:byte):ShortString;
begin
  Result := AlignLeftBy (StrInt (pNum,0),pWidth,'0');
end;

function  StrDoub (pNum:double;pWidth,pDeci:byte):ShortString;
var mStr:Str100;
begin
  Str (pNum:pWidth:pDeci,mStr);
  Result := mStr;
end;

function  StrDoubComma (pNum:double;pWidth,pDeci:byte):ShortString;
var mStr:Str100;
begin
  Str (pNum:pWidth:pDeci,mStr);
  mStr:=ReplaceStr(mStr,'.',',');
  Result := mStr;
end;

function  StrDoubZero (pNum:double;pWidth,pDeci:byte):ShortString;
begin
  Result := AlignLeftBy (StrDoub (pNum,0,pDeci),pWidth,'0');
end;

function StrDate (pDate:double):Str10;
var  mD,mM,mY: word;
begin
  DecodeDate (pDate,mY,mM,mD);
  Result := StrInt(mD,2)+'.'+StrIntZero(mM,2)+'.'+StrIntZero(mY,4);
end;

function  ValInt (pStr:ShortString):integer;
var mNum:integer;  mErr:integer;
begin
  Val (pStr,mNum,mErr);
  If mErr<>0 then mNum := 0;
  Result := mNum;
end;

function StrRealSepar (pNum:double;pLen,pFrac:byte;pSepar:boolean):Str100;
var mS,mI,mF: Str100;  I:byte;   mCnt:byte;
BEGIN
  mS := StrDoub (pNum,pLen,pFrac);
  If pSepar then begin
    If pFrac=0 then begin
      mI := mS;
      mF := '';
    end else begin
      mI := Copy (mS,1,Pos ('.',mS)-1);
      mF := Copy (mS,Pos ('.',mS),Length (mS));
    end;
    If Length (mI)>3 then begin
      If (Length (mI) div 3) = (Length (mI) / 3)
        then mCnt := Length (mI) div 3 -1
        else mCnt := Length (mI) div 3;
      For I:=1 to mCnt do
        Insert (' ',mI,Length (mI)-I*3-(I-1)+1);
      mS := mI+mF;
    end;
  end;
  Result := mS;
end;

function StrIntSepar (pNum:integer;pLen:byte;pSepar:boolean):Str100;
var mS: Str100;  I:byte;   mCnt:byte;
BEGIN
  mS := StrInt (pNum,pLen);
  If pSepar then begin
    If Length (mS)>3 then begin
      If (Length (mS) div 3) = (Length (mS) / 3)
        then mCnt := Length (mS) div 3 -1
        else mCnt := Length (mS) div 3;
      For I:=1 to mCnt do
        Insert (' ',mS,Length (mS)-I*3-(I-1)+1);
    end;
  end;
  Result := mS;
end;

function TextCheckSumCalc (pText:string):longint;
var I: integer;  mLen:word;  mEvenSum,mOrdSum:longint;
begin
  mLen := Length(pText);
  // Parne znaky
  I:= 0; mEvenSum := 0;
  Repeat
    Inc (I,2);
    mEvenSum := mEvenSum+Ord(pText[I]);
  until (I>=mLen);
  // Neparne znaky   
  I:= -1; mOrdSum:=0;
  Repeat
    Inc (I,2);
    mOrdSum := mOrdSum+Ord(pText[I])*3;
  until (I>=mLen);
  Result := mEvenSum+mOrdSum;
end;

function  ValDoub (pStr:ShortString):double;
var mNum:double;  mErr,mPos:integer;
begin
  pStr := ReplaceStr(pStr,' ','');  // 17.06.2010 - RZ
  mPos := Pos(',',pStr);
  If mPos>0 then begin
    Delete (pStr,mPos,1);
    Insert ('.',pStr,mPos);
  end;
  Val (pStr,mNum,mErr);
  If mErr<>0 then mNum := 0;
  Result := mNum;
end;

function StripFractZero (pNum:ShortString): ShortString;
var mFind:boolean;
begin
  Result := pNum;
  Repeat
    mFind := (Result[Length(Result)]='0');
    If mFind
      then Delete (Result,Length(Result),1)
      else begin
        If Result[Length(Result)]='.' then Delete (Result,Length(Result),1);
      end;
  until not mFind or (Result='0');
end;

function CharToAlias(pChar: char): char;
begin
  If Ord(pChar) in [128..254] then pChar := Chr(ChToAlias[Ord(pChar)]);
  Result := pChar;
end;

function StrToAlias(pStr: string): string;
var I: word;
begin
  I := 1;
  While i<=length(pStr) do begin
    If pStr[I]=' '
      then Delete(pStr,i,1)
      else Inc(I);
  end;
  If (gvSys.Language='SK') or (gvSys.Language='CZ') then begin
    For I:=1 to Length(pStr) do begin
      pStr[I] := CharToAlias(pStr[I]);
    end;
  end;
  Result := UpString(pStr);
end;

function StrToSpaceStr(pS: string): string;
var I: word;S:String;
begin
  i:=length(pS);
  S:=pS;
  While i>1 do begin
    Insert(' ',S,I);
    Dec(I);
  end;
  Result := S;
end;

function ConvToNoDiakr (pStr: string): string; // Zmeni diakriticke znaky na nediakriticke
var I: word;
begin
  If (gvSys.Language='SK') or (gvSys.Language='CZ') then begin
    I := 1;
    For I:=1 to Length(pStr) do begin
      pStr[I] := CharToAlias(pStr[I]);
    end;
  end;
  Result := pStr;
end;


function DOSCharToWINChar(pChar: char):char;
begin
  if (ord(pChar) < 128)
    then Result := pChar
    else Result := chr(ChDosToChWin[ord(pChar)]);
end;

function WINCharToDOSChar(pChar: char):char;
var
  mCharCode,i: byte;
begin
  if (ord(pChar) < 128) then begin
    Result := pChar;
  end else begin
    mCharCode := ord(pChar);
    i := 128;
    while (ChDosToChWin[i]<>mCharCode) and (i<255) do inc(i);
    if (ChDosToChWin[i] = mCharCode)
      then Result := chr(i)
      else Result := pChar;
  end;
end;

function DOSStringToWINString(pString: string):string;
var
  mLen, i: integer;
begin
  mLen := length(pString);
  if (mLen > 0) then begin
    for i:= 1 to mLen do begin
      pString[i] := DOSCharToWINChar(pString[i]);
    end;
  end;
  Result := pString;
end;

function WINStringToDOSString(pString: string):string;
var mLen, i: integer;
begin
  mLen := length(pString);
  if (mLen > 0) then begin
    for i:= 1 to mLen do begin
      pString[i] := WINCharToDOSChar(pString[i]);
    end;
  end;
  Result := pString;
end;

function   ConvKamToLat (pStr:string):string;
var I: longint;
begin
  Result := '';
  For I:=1 to Length (pStr) do begin
    If Ord (pStr[I]) in [128..254]
      then Result := Result+Chr(cLatin2[Ord(pStr[I])])
      else Result := Result+pStr[I];
  end;
end;

function DecToHEX (pDec:longint;pLen:byte):string;
var mNum: array[1..2] of byte;
    mHEX: array[1..2] of string;
    mHEXStr: string;  mN: longint;

  procedure ConvToHEX (pNull:boolean);
  var I:byte;
  begin
    mHEX[1] := '';
    mHEX[2] := '';
    For I:=1 to 2 do begin
      case mNum[I] of
        10: mHEX[I] := 'A';
        11: mHEX[I] := 'B';
        12: mHEX[I] := 'C';
        13: mHEX[I] := 'D';
        14: mHEX[I] := 'E';
        15: mHEX[I] := 'F';
        else Str (mNum[I],mHEX[I]);
      end;
    end;
    If (mHEX[1]='0') and not pNull then mHEX[1] := '';
  end;

begin
  mHEXStr := '';
  If pDec<=255 then begin
    mNum[1] := pDec div 16;
    mNum[2] := pDec-16*mNum[1];
    ConvToHEX (pLen>1);
    mHEXStr := mHEX[1]+mHEX[2];
  end else begin
    mN := pDec div 256;
    mNum[1] := mN div 16;
    mNum[2] := mN-16*mNum[1];
    ConvToHEX (pLen>3);
    mHEXStr := mHEX[1]+mHEX[2];
    mN := pDec-mN*256;
    mNum[1] := mN div 16;
    mNum[2] := mN-16*mNum[1];
    ConvToHEX (TRUE);
    mHEXStr := mHEXStr+mHEX[1]+mHEX[2];
  end;
  Result := mHEXStr;
end;

function HEXToDec (pHEX:string):longint;
var mStr:string;  mNum: longint;  mC: integer;
begin
  mStr := '$'+pHEX;
  Val (mStr,mNum,mC);
  Result := mNum;
end;

function  UpChar (pChar:Char): Char;
begin
  Result := pChar;
  If Ord(pChar) in [224..255]
    then Result := Chr(Ord(pChar)-32)
    else Result := UpCase (pChar);
end;

function  UpString (pString:string): string;
var I:longint;
begin
  Result := pString;
  For I:=1 to Length(pString) do
    Result[I] := UpChar(pString[I]);
end;

function DosStrToWinStr(pStr: string): string;
var i: word;
begin
  for i := 1 to length(pStr) do pStr[i] := DosCharToWinChar(pStr[i]);
  DosStrToWinStr := pStr;
end;

function DosStrToWinStr2(pStr: string): string;
var i: word;
begin
  for i := 1 to length(pStr) do pStr[i] := DosCharToWinChar2(pStr[i]);
  DosStrToWinStr2 := pStr;
end;

function DosCharToWinChar2(pChar: char): char;
  begin
    if Ord(pChar) in [128..254] then pChar := Chr(ChDosToChWin2[Ord(pChar)]);
    DosCharToWinChar2 := pChar;
  end;

function RemoveLastBS;
begin
  If pStr[length(pStr)]='\'
    then Result:=Copy(pStr,1,length(pStr)-1)
    else Result:=pStr;
end;

function RemoveSpaces(pStr:string):string;
begin

end;

function RemNonCharNum(pStr:string):string;
var m:longint;
    S:string;
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

function ReplaceNonCharNum;
var m:longint;
    S:string;
begin
  s:=pStr;
  for m:=1 to Length(S) do begin
    If (Ord(s[m])<32)
    or((Ord(s[m])>179)and (Ord(s[m])<223))
//    or((Ord(s[m])>57) and (Ord(s[m])<64))
      then s[m]:=pRChar;
  end;
  s:=DosStrToWinStr(S);
  result:=s;
end;

function  GetMaxTextWidth (pS:TMemo; pForm: TWinControl):longint;
var
  I:longint;
  mMax:longint;
  mC:TPaintBox;
begin
  mMax := 0;
  mC := TPaintBox.Create(pForm);
  mC.Parent := pForm;
  mC.Name := 'PaintBox';
  mC.Canvas.Font := pS.Font;
  if pS.Lines.Count>0 then begin
    For I:=0 to pS.Lines.Count-1 do begin
      if mC.Canvas.TextWidth(pS.Lines[I])>mMax then mMax := mC.Canvas.TextWidth (pS.Lines[I]);
    end;
  end;
  mC.Free;
  Result := mMax;
end;

function  GetTextWidth(pS:string;pF:TFont; pForm: TWinControl):longint;
var
  mC:TPaintBox;
  mW:longint;
begin
  mC := TPaintBox.Create(pForm);
  mC.Parent := pForm;
  mC.Name := 'PaintBox';
  mC.Canvas.Font := pF;
  mW := mC.Canvas.TextWidth (pS);
  mC.Free;
  Result := mW;
end;

function  GetTextHeight(pF:TFont; pForm: TWinControl):longint;
var
  mC:TPaintBox;
  mH:longint;
begin
  mC := TPaintBox.Create(pForm);
  mC.Parent := pForm;
  mC.Name := 'PaintBox';
  mC.Canvas.Font := pF;
  mH := mC.Canvas.TextHeight ('TextHeight');
  mC.Free;
  Result := mH;
end;

function  TextStrip (pText:string): string;
var I: word;
begin
  If pText<>'' then begin
    I:=1;
    Repeat
      If not (pText[I] in ['0'..'9','-','.'])
        then Delete (pText,I,1)
        else Inc (I);
    until I>Length(pText);
  end;
  Result := pText
end;

function NumStrip (pText:ShortString): ShortString;
var I: word;
begin
  If pText<>'' then begin
    I:=1;
    Repeat
      If (pText[I] in ['0'..'9'])
        then Delete (pText,I,1)
        else Inc (I);
    until I>Length(pText);
  end;
  Result := pText
end;

function NulBegStrip (pText:ShortString): ShortString; // vymaze z retazca zaciatocne nuly
var mS:String;
begin
  mS:=pText;
  while (mS<>'') and (mS[1]='0') do delete(mS,1,1);
  Result := mS;
end;

function UnicodeIntToStr (pStr:string):string;
var mPound:boolean;
begin
  Result := '';
  mPound := Pos ('#',pStr)=1;
  Repeat
    If Copy (pStr,1,1)=Chr (39) then begin
      Delete (pStr, 1, 1);
      mPound := Pos ('#',pStr)=1;
    end;
    If mPound then begin
      Repeat
        Result := Result+UnicodeIntToChar (CutPoundNum (pStr));
      until (pStr='') or (Copy (pStr,1,1)=Chr (39));
      mPound := FALSE;
    end else begin
      If Pos (Chr (39),pStr)>0 then begin
        Result := Result+Copy (pStr,1,Pos (Chr (39),pStr)-1);
        Delete (pStr,1,Pos (Chr (39),pStr)-1)
      end else begin
        Result := Result+pStr;
        pStr := '';
      end;
    end;
  until (pStr='') or (pStr=Chr (39));
end;

function UnicodeIntToChar (pStr:string):string;
var
  mB:longint;
  mB1,mB2:byte;
begin
  mB := ValInt (pStr);
  mB1 := 192+(mB div 64);
  mB2 := 128+(mB mod 64);
  Result := UTF8Decode (Chr (mB1)+Chr (mB2));
end;

function CutPoundNum (var pStr:string):string;
var mLen:longint;
begin
  If Pos ('#',pStr)=1 then Delete (pStr,1,1);
  mLen := 0;
  While (Length (pStr)>=mLen+1) and (pStr[mLen+1] in ['0'..'9']) do Inc (mLen);
  Result := Copy (pStr,1,mLen);
  Delete (pStr,1,mLen);
end;

//******************************************************************************
// String to Component types

function StrToBarCodeType(pData:string):TBarCodeType;
begin
  If pData = 'Code39'               then Result :=Code39
  else If pData = 'Interleaved2Of5' then Result :=Interleaved2Of5
  else If pData = 'Code128'         then Result :=Code128
  else If pData = 'PostNet'         then Result :=PostNet
  else If pData = 'PostnetZip'      then Result :=PostnetZip
  else If pData = 'PostNetZipPlus4' then Result :=PostNetZipPlus4
  else If pData = 'Postnet11'       then Result :=Postnet11
  else If pData = 'EAN'             then Result :=EAN
  else If pData = 'EAN8'            then Result :=EAN8
  else If pData = 'EAN13'           then Result :=EAN13
  else If pData = 'ITF14'           then Result :=ITF14
  else If pData = 'FIMA'            then Result :=FIMA
  else If pData = 'FIMB'            then Result :=FIMB
  else If pData = 'FIMC'            then Result :=FIMC
  else If pData = 'EAN128'          then Result :=EAN128
end;

function StrToShapeType(pData:string):TQRShapeType;
begin
  If pData      = 'R'  then Result :=  qrsRectangle
  else If pData = 'C'  then Result :=  qrsCircle
  else If pData = 'V'  then Result :=  qrsVertLine
  else If pData = 'H'  then Result :=  qrsHorLine
  else If pData = 'TB' then Result :=  qrsTopAndBottom
  else If pData = 'RL' then Result :=  qrsRightAndLeft
end;

function StrToFrameStyle(pData:string):TPenStyle;
begin
  If pData      = 'S'   then Result :=  psSolid
  else If pData = 'D'   then Result :=  psDash
  else If pData = 'DT'  then Result :=  psDot
  else If pData = 'DD'  then Result :=  psDashDot
  else If pData = 'DDD' then Result :=  psDashDotDot
  else If pData = 'C'   then Result :=  psClear
  else If pData = 'F'   then Result :=  psInsideFrame
end;

function StrToPenStyle(pData:string):TPenStyle;
begin
  If pData      = 'S'   then Result := psSolid
  else If pData = 'D'   then Result := psDash
  else If pData = 'DT'  then Result := psDot
  else If pData = 'DD'  then Result := psDashDot
  else If pData = 'DDD' then Result := psDashDotDot
  else If pData = 'C'   then Result := psClear
end;

function StrToBrushStyle(pData:string):TBrushStyle;
begin
  If pData      = 'S'  then Result := bsSolid
  else If pData = 'C'  then Result := bsClear
  else If pData = 'H'  then Result := bsHorizontal
  else If pData = 'V'  then Result := bsVertical
  else If pData = 'FD' then Result := bsFDiagonal
  else If pData = 'BD' then Result := bsBDiagonal
  else If pData = 'CS' then Result := bsCross
  else If pData = 'DC' then Result := bsDiagCross
end;

function StrToSysDataType(pData:string):TQRSysDataType;
begin
  If pData      = 'D' Then Result := qrsDate
  else If pData = 'T' Then Result := qrsTime
  else If pData = 'DT' Then Result := qrsDateTime
  else If pData = 'RT' Then Result := qrsReportTitle
  else If pData = 'PN' Then Result := qrsPageNumber
  else If pData = 'DN' Then Result := qrsDetailNo
  else If pData = 'DC' Then Result := qrsDetailCount
end;

function StrToAlignment(pAlign:string):TAlignment;
begin
  If pAlign='L' then Result := taLeftJustify
  else if pAlign='R' then Result := taRightJustify
  else result := taCenter;
end;

function StrToFontStyle(pFS:string):TFontStyles;
var
  mFS: TFontstyles;
begin
  mFS:=[];
  If Length (pFS)=4 then begin
    If pFS[1] = 'B' then mFS := mFS + [fsBold];
    If pFS[2] = 'I' then mFS := mFS + [fsItalic];
    If pFS[3] = 'U' then mFS := mFS + [fsUnderline];
    If pFS[4] = 'S' then mFS := mFS + [fsStrikeout];
  end;
  Result := mFS;
end;

// Component Types to Str

function barCodeTypeToStr(pData:TBarCodeType):string;
begin
  If pData = Code39               then Result :='Code39'
  else If pData = Interleaved2Of5 then Result :='Interleaved2Of5'
  else If pData = Code128         then Result :='Code128'
  else If pData = PostNet         then Result :='PostNet'
  else If pData = PostnetZip      then Result :='PostnetZip'
  else If pData = PostNetZipPlus4 then Result :='PostNetZipPlus4'
  else If pData = Postnet11       then Result :='Postnet11'
  else If pData = EAN             then Result :='EAN'
  else If pData = EAN8            then Result :='EAN8'
  else If pData = EAN13           then Result :='EAN13'
  else If pData = ITF14           then Result :='ITF14'
  else If pData = FIMA            then Result :='FIMA'
  else If pData = FIMB            then Result :='FIMB'
  else If pData = FIMC            then Result :='FIMC'
  else If pData = EAN128          then Result :='EAN128'
  else Result:='';
end;

function ShapeTypeToStr(pData:TQRShapeType):string;
begin
  If pData = qrsRectangle then Result:='R'
  else If pData = qrsCircle then Result:='C'
  else If pData = qrsVertLine then Result:='V'
  else If pData = qrsHorLine then Result:='H'
  else If pData = qrsTopAndBottom then Result:='TB'
  else If pData = qrsRightAndLeft then Result:='RL'
  else Result:='';
end;

function FrameStyleToStr(pData:TPenStyle):string;
begin
  If pData = psSolid then Result:='S'
  else If pData = psDash then Result:='D'
  else If pData = psDot then Result:='DT'
  else If pData = psDashDot then Result:='DD'
  else If pData = psDashDotDot then Result:='DDD'
  else If pData = psClear then Result:='C'
  else If pData = psInsideFrame then Result:='F'
  else Result:='';
end;

function PenStyleToStr(pData:TPenStyle):string;
begin
  If pData = psSolid then Result:='S'
  else If pData = psDash then Result:='D'
  else If pData = psDot then Result:='DT'
  else If pData = psDashDot then Result:='DD'
  else If pData = psDashDotDot then Result:='DDD'
  else If pData = psClear then Result:='C'
  else Result:='';
end;

function BrushStyleToStr(pData:TBrushStyle):string;
begin
  If pData = bsSolid then Result:='S'
  else If pData = bsClear then Result:='C'
  else If pData = bsHorizontal then Result:='H'
  else If pData = bsVertical then Result:='V'
  else If pData = bsFDiagonal then Result:='FD'
  else If pData = bsBDiagonal then Result:='BD'
  else If pData = bsCross then Result:='CS'
  else If pData = bsDiagCross then Result:='DC'
  else Result:=''
end;

function SysDataTypeToStr(pData:TQRSysDataType):string;
begin
  If pData = qrsDate then Result:='D'
  else If pData = qrsTime then Result:='T'
  else If pData = qrsDateTime then Result:='DT'
  else If pData = qrsReportTitle then Result:='RT'
  else If pData = qrsPageNumber then Result:='PN'
  else If pData = qrsDetailNo then Result:='DN'
  else If pData = qrsDetailCount then Result:='DC'
  else Result := '';
end;

function AlignmentToStr(pAlign:TAlignment):string;
begin
  If pAlign=taLeftJustify then Result := 'L'
  else if pAlign=taRightJustify then Result := 'R'
  else result := 'C';
end;

function FontStyleToStr(pFS:TFontStyles):string;
var mS:string;
begin
  mS:='....';
  If fsBold in pFS then mS[1] := 'B';
  If fsItalic in pFS then mS[2] := 'I';
  If fsUnderline in pFS then mS[3] := 'U';
  If fsStrikeout in pFS then mS[4] := 'S';
  result:=mS;
end;

function SeparString (pValue:ShortString):ShortString; // Funkcia vrati zadany text formate kde jedotlive znaky su rozdelene medzerami
var I:byte;
begin
  Result := '';
  For I:=1 to Length(pValue) do
    Result := Result+pValue[I]+' ';
end;

function SeparDoub (pValue:double;pFract:byte):ShortString; // Funkcia vrati zadanu hodnotu v textovom formate kde jedotlive znaky su rozdelene medzerami
var mStr:ShortString; I:byte;
begin
  Result := '';
  mStr := StrDoub(pValue,0,pFract);
  For I:=1 to Length(mStr) do
    Result := Result+' '+mStr[I];
end;

function Win1250ToLatin2 (pStr: string):string;
var I:longint;
begin
  Result := '';
  For I:=1 to Length (pStr) do begin
    If Ord (pStr[I])<128
      then Result := Result+pStr[I]
      else Result := Result+Chr (ChWinToLatin2[Ord (pStr[I])]);
  end;
end;

function Latin2ToWin1250(pStr: string):string;
var I,J:longint; mCh:string;
begin
  Result := '';
  For I:=1 to Length (pStr) do begin
    If Ord (pStr[I])<128
      then mCh := pStr[I]
      else begin
        mCh := #32;
        For J:=128 to 255 do begin
          If Ord (pStr[I])=ChWinToLatin2[J] then begin
            mCh := Chr (J);
            Break;
          end;
        end;
      end;
    Result := Result+mCh;
  end;
end;

// *****************
// ** RTF to HTML **
// *****************
function TextToHtml(s: string): string;
const ot = #1'<'; ct = '>'#1;

  function HtmlColor(Col: integer): string;
  begin
    Col := ColorToRGB(Col);
    Result := '#' + Format('%.2x%.2x%.2x', [GetRValue(Col), GetGValue(Col), GetBValue(Col)]);
  end;

  function IsRTF(txt: string): boolean;
  begin
    if copy(txt,1,5) = '{\rtf' then result := true
    else result := false;
  end;

  function HtmlChar(ch: char): string;
  const
    sim: array[1..6] of string = ('<', '>','"','&', '', '');
    sims = '<>"&'#13#10;
  begin
    if pos(ch, sims) > 0 then result := sim[pos(ch, sims)]
    else result := ch;
  end;
 
  function DetectUrl(txt: string): string;
  var
    i,j: integer;
    s,l: string;
    h:   boolean;
  begin
    result := ''; l := LowerCase(txt); h := false; i := 0;
    repeat
      inc(i);
      if txt[i] = #1 then h := not h;
      if h then result := result + txt[i]
      else
        if (copy(l, i, 7) = 'http://')
        or (copy(l, i, 8) = 'https://')
        or (copy(l, i, 6) = 'ftp://')
        or (copy(l, i, 4) = 'www.') then begin
          s := '';
          for j := i to Length(l) do
            if pos(l[j], #1#13#10' <>') = 0 then s := s + txt[j]
            else Break;
          inc(i, Length(s)-1);
          result := result + ot + 'a href="';
          if pos('://', s) = 0 then result := result + 'http://';
          result := result + s + '"' + ct + s + ot + '/a' + ct;
        end else result := result + txt[i];
    until i >= Length(l);
  end;
 
  function RtfToHtml(s: string): string;
  var
    re: TRichEdit;
    ss: TStringStream;
    f:  string;
    i, sz, cl: integer;
    st: TFontStyles;
    al: TAlignment;
    n:  TNumberingStyle;
    sp: boolean;
  begin
    result := '';
    re := TRichEdit.Create(nil);
    re.Visible := false; re.Width := 4096; re.Height := 0;
    re.Parent := Application.MainForm;
    ss := TStringStream.Create(s);
    re.Lines.LoadFromStream(ss);
    ss.Free; s := re.Text;
    f := ''; sz := 0; cl := -1; st := []; sp := false;
    al := taLeftJustify; n := nsNone;
    for i := 1 to Length(s) do
    begin
      re.SelStart := i;
      if (re.CaretPos.X=0) and (re.Lines[re.CaretPos.Y]='') then
        if s[i]=#13 then result:=result+ot+'br'+ct;
      if re.CaretPos.X = 1 then begin // Paragraph
        if re.Paragraph.Alignment <> al then begin
          if al <> taLeftJustify then result := result + ot+'/div'+ct;
          al := re.Paragraph.Alignment;
          if al = taRightJustify then result := result + ot+'div align=right'+ct;
          if al = taCenter then result := result + ot+'div align=center'+ct;
        end else if n = nsNone then result := result + ot+'br'+ct;
        if n = nsBullet then result := result+ot+'/li'+ct;
        if (re.Paragraph.Numbering = nsBullet) and (n = nsNone) then
        begin result := result + ot +'ul'+ct; n := nsBullet; end;
        if (re.Paragraph.Numbering <> nsBullet) and (n = nsBullet) then
        begin result := result + ot+'/ul'+ct; n := nsNone; end;
        if n = nsBullet then result := result + ot+'li'+ct;
      end;
      with re.SelAttributes do // Font
        if (f <> Name) or (sz <> Size) or (cl <> Color) or (st <> Style) then
        begin
          if sp then begin result := result + ot+'/span'+ct; sp := false; end;
          if s[i] > #31 then begin
            f := Name; sz := Size; cl := Color; st := Style;
            result := result + ot+'span style="{font-family:' + f + ';font-size:' +
            IntToStr(sz) + 'pt;';
            if cl <> 0 then result := result + 'color:' + HtmlColor(cl)+';';
            if fsBold in st then result := result + 'font-weight:bold;';
            if fsItalic in st then result := result + 'font-style:italic;';
            if fsUnderline in st then result := result + 'text-decoration:underline;';
            if fsStrikeOut in st then result := result + 'text-decoration:line-through;';
            result := result + '}"'+ct; sp := true;
          end;
        end;
      if s[i] > #31 then result := result + s[i];
    end;
    if sp then result := result + ot+'/span'+ct;
    if al <> taLeftJustify then result := result + ot+'/div'+ct;
    if n = nsBullet then result := result + ot+'/ul'+ct;
    re.Free;
  end;
 
var
  i: integer;
  h: boolean;
begin
  i := 0; result := ''; h := false;
  if IsRTF(s) then s := RtfToHtml(s)
  else result := '<font style="font-size:12pt; font-family:courier">';
  s := DetectUrl(s);
  repeat
    inc(i);
    if s[i] = #1 then h := not h
    else if h then result := result + s[i]
    else result := result + HtmlChar(s[i]);
  until i = Length(s);
end;

function DeleteUTF8ControlStrings(Text: String): String;
var
  Encoded       : String;
  Dump          : String;
  StartPos      : Integer;
  EndPos        : Integer;
begin
  Encoded:='';
  Dump:=Text;
  while Pos('=?UTF-8',UpperCase(Dump))<>0 do
  begin
    StartPos:=Pos('=?UTF-8',UpperCase(Dump))+10;
    EndPos:=Pos('?=',UpperCase(Dump));
    Encoded:=Encoded+Copy(Dump,StartPos,EndPos-StartPos);
    Dump:=Encoded+Copy(Dump,EndPos+3,Length(Dump)-(EndPos+2));
  end;
  Result:=Trim(ReplaceStr(Encoded,'_',' '));
end;

function MailsUtf8Convert(Subject: String): String;
var
  Decoder        : TIdDecoderQuotedPrintable;
  TextAnsi       : String;
begin
  Result:=Subject;
  if Pos('=?utf-8',Subject)<>0 then
  begin
    Decoder:=TIdDecoderQuotedPrintable.Create;
    try
      Result:=DeleteUTF8ControlStrings(Subject);
      Result:=Decoder.DecodeString(Result);
      TextAnsi:=UTF8ToAnsi(Result);
      if Length(TextAnsi)>0 then Result:=TextAnsi;
    finally
      FreeAndNil(Decoder);
    end;
  end;
end;

function Utf8Convert(Subject: String): String;
var
  Decoder        : TIdDecoderQuotedPrintable;
  TextAnsi       : String;
begin
  Result:=Subject;
  Decoder:=TIdDecoderQuotedPrintable.Create;
  try
    Result:=Decoder.DecodeString(Result);
    TextAnsi:=UTF8ToAnsi(Result);
    if Length(TextAnsi)>0 then Result:=TextAnsi;
  finally
    FreeAndNil(Decoder);
  end;
end;


function LoadUnicodeFileToStr(pFileName:string):string;
var
  ms: TMemoryStream; ptr: PWideChar; s: AnsiString; dlen, slen: Integer;
begin
  ms := TMemoryStream.Create;
  try
    ms.LoadFromFile('C:\NEX Develop1703\Aplik·cie\Z·kladnÈ moduly\MDC - Objedn·vky z MEDIACAT\a.txt');
    ptr := PWideChar(ms.Memory);
    dlen := ms.Size div SizeOf(WideChar);
    if (dlen >= 1) and (PWord(ptr)^ = $FEFF) then
    begin
      Inc(ptr);
      Dec(dlen);
    end;
    slen := WideCharToMultiByte(0, 0, ptr, dlen, nil, 0, nil, nil);
    if slen > 0 then begin
      SetLength(s, slen);
      WideCharToMultiByte(0, 0, ptr, dlen, PAnsiChar(s), slen, nil, nil);
    end;
    Result := s;
  finally
    ms.Free;
  end;
end;

function EAN128Decode(pEAN: String;var pRbaCode:Str30;var pRbaDate:TDate): boolean;
begin
  try
  // (10)L1400027(15)150525
  //  10 25400027 15 150525
  pRbaCode:='';pRbaDate:=0;
{
  If Pos('(15)',pEAN)>0 then
  begin
    pRbaCode:=Copy(pEAN,Pos('(15)',pEAN)+4,255);
    pRbaDate:=StrToDate(Copy(pRbaCode,5,2)+'.'+Copy(pRbaCode,3,2)+'.20'+Copy(pRbaCode,1,2));
  end;
  If Pos('(10)',pEAN)>0 then
  begin
    pRbaCode:=Copy(pEAN,Pos('(10)',pEAN)+4,255);
    pRbaCode:=Copy(pRbaCode,1,Pos('(',pRbaCode)-1);
  end;
}
  If length(pEan)=18 then begin
    pRbaCode:=Copy(pEAN,13,6);
    pRbaDate:=StrToDate(Copy(pRbaCode,5,2)+'.'+Copy(pRbaCode,3,2)+'.20'+Copy(pRbaCode,1,2));
// 14.01.2020 Tibi do roku 2019
    If Pos('25',pEAN)=3 then pRbaCode:='L1'+Copy(pEAN,5,6);
// 14.01.2020 Tibi od roku 2020
    If Pos('26',pEAN)=3 then pRbaCode:='L2'+Copy(pEAN,5,6);
  end;
  finally
    Result:=(pRbaCode<>'')and(pRbaDate>0);
  end;
end;

end.
{MOD 1809010} 
{MOD 1809014}
{MOD 1901008}
