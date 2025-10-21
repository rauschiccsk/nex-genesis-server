Unit DefFile;

interface

uses
   IcTypes, IcConv, IcTools, IcFiles, BtrStruct, Nexmsg, NexError,
   Dialogs, SysUtils;

const
   cChar = 1;    cLong = 5;    cTime  =  9;
   cByte = 2;    cReal = 6;    cIAuto = 10;
   cInt  = 3;    cDoub = 7;    cLAuto = 11;
   cWord = 4;    cDate = 8;    cStr   = 12;

type
   TKeyVek   = array[1..30] of KEY_SPECS;
   TFileSpec = packed record
     RecLen    : smallint;
     PageSize  : smallint;
     IndQnt    : smallint;
     NotUsed   : array[0..3] of char;
     FileFlags : smallint;
     Reserved  : byte;
     Reserved2 : byte;
     Allocat   : smallint;
     KeySpec   : TKeyVek;
//     AltSeq    : TAltSeq;
   end;

   TFld = array [1..200] of record
     rName  : String[20];
     rBType : byte; { Btrieve type }
     rPType : byte; { Pascal  type }
     rSize  : word;
     rPos   : word;
   end;

   TKey = array[0..50] of record
      Flds  : array[1..20] of byte;
      Count : byte;
   end;

   TDefFile = class
      oFileSpec  : ^TFileSpec;
      oError     : boolean; { TRUE ak sa nastane fatalna chyba }
      oSegQnt    : byte;    { Pocet segmetnov vsetkych indexov }
      oDuplic    : boolean;

      constructor Create;
      destructor  Destroy; override;
      procedure   ReadFile (pFile:Str80);

      function    GetFldQnt:byte;
      function    GetIndQnt:byte;
      function    GetRecLen:word;
      function    GetPgSize:word;

      function    GetFldName  (pFld:byte): String;
      function    GetFldBType (pFld:byte): byte;
      function    GetFldPType (pFld:byte): byte;
      function    GetFldSize  (pFld:byte): word;
      function    GetFldPos   (pFld:byte): word;

     private
      oFld       : ^TFld;
      oKey       : ^TKey;
      oDuplQnt   : byte;  { Pocest duplicitnych indexov }
      oFldQnt    : byte;  { Pocet databazovych poli }
      oFileName  : Str80; { Cesta a nazov definicneho suboru }

      function    FldBType (pType:String):byte;
      function    FldPType (pType:String):byte;
      function    FldSize (pType:String):word;
      function    CalcPageSize:word; { Urci opt. velkost stranky }
      function    GetFldNum (pFldName:String):byte;
      procedure   AddFld (pStr:string);
      procedure   AddKey (pStr1,pStr2,pStr3:string);
      procedure   SetKeySpec (pSeg,pFld:integer; pGlobFlag,pActFlag:string);
      procedure   FileFlags (pStr:string);
    end;

implementation

CONSTRUCTOR TDefFile.Create;
begin
  New (oFld);
  New (oKey);
  New (oFileSpec);
  oDuplic:=False;
end;

DESTRUCTOR TDefFile.Destroy;
begin
  Dispose (oFileSpec);
  Dispose (oKey);
  Dispose (oFld);
end;

PROCEDURE  TDefFile.ReadFile;
var mTx : TextFile;
    mStr, mStr1, mStr2: string;
    mInd: boolean;
begin
  oFileName := pFile;
  If FileExistsI (pFile) then begin
    FillChar (oFileSpec^,SizeOf(TFileSpec),#0);
    oFileSpec^.RecLen := 0;
    oDuplQnt := 0;
    oSegQnt  := 0;
    oFldQnt  := 0;
    AssignFile(mTx, pFile);
    Reset(mTX);
    Repeat Readln(mTX, mStr) until mStr<>'';
    FileFlags (mStr);

    { Nacitanie databazovych poli }
    Repeat
      Readln(mTX, mStr);
      // Odstranime poznamky
      Delete (mStr,Pos(';',mStr),255);

      mStr := RemSpaces (mStr);
      mInd := (copy(mStr,1,4)='IND ');
      If not mInd and (mStr<>'') then AddFld (mStr);
    until mInd or Eof(mTx);

    { Nacitanie indexov }
    Repeat
      If copy(mStr,1,4)='IND ' then begin
        Readln(mTX, mStr1);
        Readln(mTX, mStr2);
        If oDuplic and (Pos('CDUPLIC',UpperCase(mStr1))=0)
          then AddKey (mStr, mStr1+'+CDUPLIC', mStr2)
          else AddKey (mStr, mStr1, mStr2);
      end;
      Readln(mTX, mStr);
      mStr := RemSpaces (mStr);
    until Eof(mTX);
    CloseFile(mTX);
    oFileSpec^.PageSize := CalcPageSize;
  end else begin
    ShowMsg (ecBtrDefFileIsNotExist, pFile);  { Neexistujuci definicny subor }
    oError := TRUE;
  end;
end;

FUNCTION   TDefFile.GetFldQnt;
begin
  GetFldQnt := oFldQnt;
end;

FUNCTION   TDefFile.GetIndQnt;
begin
  GetIndQnt := oFileSpec^.IndQnt;
end;

FUNCTION   TDefFile.GetRecLen;
begin
  GetRecLen := oFileSpec^.RecLen;
end;

FUNCTION   TDefFile.GetPgSize;
begin
  GetPgSize := oFileSpec^.PageSize;
end;

FUNCTION   TDefFile.GetFldName;
begin
  GetFldName := oFld^[pFld].rName;
end;

FUNCTION   TDefFile.GetFldBType;
begin
  GetFldBType := oFld^[pFld].rBType;
end;

FUNCTION   TDefFile.GetFldPType;
begin
  GetFldPType := oFld^[pFld].rPType;
end;

FUNCTION   TDefFile.GetFldSize;
begin
  GetFldSize := oFld^[pFld].rSize;
end;

FUNCTION   TDefFile.GetFldPos;
begin
  GetFldPos := oFld^[pFld].rPos;
end;

{ 같같같같같같같같같같 PRIVATE METHODS 같같같같같같같같같같� }
FUNCTION   TDefFile.FldBType;
var mType:byte;
begin
  mType := 255; { Nie je zadany ziadny typ }
  If Pos (pType,'CHAR BYTE ')>0                      then mType := 0;  { 0 Code}
  If Pos (pType,'INTEGER ')>0                        then mType := 1;  { 1 Code}
  If Pos (pType,'DOUBLE ')>0                         then mType := 2;  { 2 Code}
  If Pos (pType,'SINGLE ')>0                         then mType := 9;  { 9 Code}
  If Pos (pType,'WORD DATETYPE TIMETYPE LONGINT ')>0 then mType := 14; {14 code}
  If Pos (pType,'INTAUTO LONGAUTO ')>0               then mType := 15; {15 Code}
  If copy(pType,1,3)='STR'                           then mType := 10; {10 Code}
  If mType=255 { Nie je zadany ziadny typ }
    then ShowMsg (ecBtrFieldTypeIsBad,oFileName+'  '+pType)
    else FldBType := mType;
end;

FUNCTION   TDefFile.FldPType;
var mType:byte;
begin
  mType := 255; { Nie je zadany ziadny typ }

  If pType='CHAR'     then mType := cChar;
  If pType='BYTE'     then mType := cByte;
  If pType='INTEGER'  then mType := cInt;
  If pType='WORD'     then mType := cWord;
  If pType='LONGINT'  then mType := cLong;
  If pType='REAL'     then mType := cReal;
  If pType='DOUBLE'   then mType := cDoub;
  If pType='DATETYPE' then mType := cDate;
  If pType='TIMETYPE' then mType := cTime;
  If pType='INTAUTO'  then mType := cIAuto;
  If pType='LONGAUTO' then mType := cLAuto;
  If copy(pType,1,3)='STR' then mType := cStr;

  If mType=255 { Nie je zadany ziadny typ }
    then ShowMsg (ecBtrFieldTypeIsBad,oFileName+'  '+pType)
    else FldPType := mType;
end;

FUNCTION   TDefFile.FldSize;
var mSize:word;
begin
  mSize := 0;
  If Pos (pType,'CHAR BYTE ')>0                        then mSize := 1; { 1 byte}
  If Pos (pType,'WORD INTEGER DATETYPE INTAUTO ')>0    then mSize := 2; { 2 byte}
  If Pos (pType,'LONGINT TIMETYPE SINGLE LONGAUTO ')>0 then mSize := 4; { 4 byte}
  If Pos (pType,'DOUBLE ')>0                           then mSize := 8; { 8 byte}
  If copy(pType,1,3)='STR' then begin
    If copy(pType,1,6)='STRING'
      then mSize := 255
      else mSize := ValInt(copy(pType,4,3))+1;  {pri stringu +1}
  end;
  If mSize=0 { Nebolo mozne urcit dlzku pola }
    then ShowMsg (ecBtrFieldTypeIsBad,oFileName+'  '+pType)
    else FldSize := mSize;
end;

FUNCTION   TDefFile.CalcPageSize;
var mFizLen,mMin:word;
    I,J:word;
    mPointDup:byte;
begin
  mPointDup:=0;

  mFizLen:=2+oFileSpec^.RecLen+8*oDuplQnt+8*mPointDup;
  If mFizLen>4096 then writeln('Fiz. size of record is more length.',mFizLen,' byte.');

  mMin:=mFizLen;
  I:=1; J:=1;
  If oSegQnt>8  then I := 2;
  If oSegQnt>23 then I := 3;
  If oSegQnt>24 then I := 4;
  If oSegQnt>54 then begin I:=8;J:=8; end;

  While I<8 do begin
    While 512*I<mFizLen do Inc(I);
    If ((512*I) mod mFizLen) < mMin then begin
      mMin:=(512*I) mod mFizLen;
      J:=i;
    end;
    inc(i);
  end;
  CalcPageSize := J*512;
end;

FUNCTION TDefFile.GetFldNum;
var I: byte;  mFind: boolean;
begin
  I:=0;
  Repeat
    Inc (I);
    mFind := UpperCase(oFld^[I].rName)=UpperCase(pFldName);
  until mFind or (I=oFldQnt);
  If not mFind then begin
    GetFldNum := 0;
    ShowMsg (ecBtrIndexTypeIsBad,pFldName); // Chybne definovany index
  end
  else GetFldNum := I;
end;

PROCEDURE  TDefFile.AddFld;
var mType:String; mPos:byte;
begin
  Inc (oFldQnt);
  oFld^[oFldQnt].rName := copy(pStr,1,Pos(' ',pStr)-1);

  Delete (pStr,1,Pos(' ',pStr));
//  mPos := Pos(';',pStr)-1;   // Do zaciatku poznamky
//  If mPos=0 then mPos := Length(mType);  // Ak nie je pozn8mka potom berieme riadok do konca
  mPos := 255;
  mType := RemRightSpaces (UpperCase (copy(pStr,1,mPos)));
  oFld^[oFldQnt].rBType := FldBType (mType);
  oFld^[oFldQnt].rPType := FldPType (mType);
  oFld^[oFldQnt].rSize  := FldSize (mType);
  oFld^[oFldQnt].rPos   := oFileSpec^.RecLen+1;
  oFileSpec^.RecLen := oFileSpec^.RecLen+oFld^[oFldQnt].rSize;
end;

PROCEDURE  TDefFile.AddKey;
var mPos,I:word;
    mName:String;
    mActFlag  :string;
    mGlobFlag :string;
    mActFld   :byte;

  FUNCTION  FindFlag(pFldName,pStr:string):string;
  var j,k:integer;
  BEGIN
     J:=Pos(pFldName,pStr);
     If J>0 then begin
       Delete (pStr,1,J+Length(pFldName));
       pStr := RemSpaces (pStr);
       If pStr[1]='(' then Delete(pStr,1,1);
       k := Pos(')',pStr);
       Delete (pStr,k,255);
       FindFlag := ' '+RemSpaces (pStr);
     end
     else  FindFlag:=' 0';
  END;     { *** FindFlag *** }

begin
  mGlobFlag := RemSpaces(copy(RemSpaces(pStr2),4,255));
  mGlobFlag := mGlobFlag + '+cExtType';
  If mGlobFlag='' then mGlobFlag := '0';
  If Pos('CDUPLIC',UpperCase(pStr2))>0 then Inc (oDuplQnt);

  Delete (pStr1,1,4);
  Inc(oFileSpec^.IndQnt);

  { Riadok 1 }
  mPos := Pos('=',pStr1);
  If mPos>0 then Delete (pStr1,mPos,255); { Odstranime nazov indexu }

  I:=1;
  While Pos(',',pStr1)>0 do begin
    mPos := Pos(',',pStr1);
    mName := RemSpaces (copy(pStr1,1,mPos-1));
    mActFld := GetFldNum(mName);
    oKey^[oFileSpec^.IndQnt].Flds[I] := mActFld;
    Inc (oSegQnt);
    If Pos('CDUPLIC',UpperCase(pStr2))>0 then Inc (oDuplQnt);
    Inc (I);
    mActFlag := FindFlag (mName,pStr3);
    If mPos=0
      then SetKeySpec(oSegQnt,mActFld,mGlobFlag,mActFlag)
      else SetKeySpec(oSegQnt,mActFld,mGlobFlag+'+cSegm',mActFlag);

    Delete(pStr1,1,mPos);
  end;
  mName:=RemSpaces (copy(pStr1,1,255));
  If mName=''
    then oKey^[oFileSpec^.IndQnt].Count := I-1
    else begin
      Inc(oSegQnt);
      oKey^[oFileSpec^.IndQnt].Count   := I;
      oKey^[oFileSpec^.IndQnt].Flds[I] := GetFldNum (mName);
      mActFld  := GetFldNum(mName);
      mActFlag := FindFlag (mName,pStr3);
      SetKeySpec(oSegQnt,mActFld,mGlobFlag,mActFlag)
    end;
end;

PROCEDURE  TDefFile.SetKeySpec;
var mI:word;
    mFlag:string;
begin
  mFlag := UpperCase (pGlobFlag+pActFlag);
  oFileSpec^.KeySpec[pSeg].Position  := oFld^[pFld].rPos;
  oFileSpec^.KeySpec[pSeg].Length    := oFld^[pFld].rSize;
  oFileSpec^.KeySpec[pSeg].keyType   := Chr(oFld^[pFld].rBType);
  mI:=0;
  If Pos('CDUPLIC',  mFlag)>0 then mI:=mI+1;
  If Pos('CMODIF',   mFlag)>0 then mI:=mI+2;
  If Pos('CNULLAll', mFlag)>0 then mI:=mI+8;
  If Pos('CSEGM', mFlag)>0 then mI:=mI+16;
  If Pos('CDESCEND', mFlag)>0 then mI:=mI+64;
  If Pos('CEXTTYPE', mFlag)>0 then mI:=mI+256;
  If Pos('CNULLANY', mFlag)>0 then mI:=mI+512;
  If Pos('CINSENSIT',mFlag)>0 then mI:=mI+1024;
  oFileSpec^.KeySpec[pSeg].Flags  :=mI;
  oFileSpec^.KeySpec[pSeg].NullChar:=#0; //Itt vigyazni mert nem biztos ???
end;

PROCEDURE  TDefFile.FileFlags;
var mST   : String;
    mErr  : integer;
    mCalc : word;
    mPos,J: word;
begin
  pStr  := UpperCase(pStr);
  mCalc := 0;
  If Pos ('CPREALLOC',pStr)>0 then mCalc := mCalc+4;
  If Pos ('CCOMPRES',pStr)>0  then mCalc := mCalc+8;
  If Pos ('CBALANCED',pStr)>0 then mCalc := mCalc+32;
  If Pos ('FREE10',pStr)>0    then mCalc := mCalc+64;
  If Pos ('FREE20',pStr)>0    then mCalc := mCalc+128;
  oFileSpec^.FileFlags := mCalc;

  mST:='0';
  mPos := Pos ('CPREALLOC',pStr);
  If mPos>0 then begin
    mST:='10';
    If Length(pStr) > mPos+9-1 then begin
      If pStr[mPos+9] in ['1'..'9'] then begin
        mST:=copy(pStr,mPos+9,255);
        j := pos('+',mST);
        If j>0 then mST:=copy(mST,1,j-1);
      end;
    end;
  end;
  val(mST,mCalc,mErr);
  oFileSpec^.Allocat := mCalc;
end;

end.