unit BaseUtils;

interface

  uses
    SysUtils, Graphics, Windows, Math;

  const
    cCoin = 'Eur';

    cbcBasicColor = $00FFE1E1;

    HLSMAX = 255;
    RGBMAX = 255;
    UNDEFINED = (HLSMAX*2 div 3);

    ctSLYear     :string = '2010';
    ctSLFirmaNum :string = '';
    ctSLFirmaName:string = '';
    ctSLUserName :string = '';

  clIccActBorder       :TColor = TColor($0000AAAA);
  clIccInactBorder     :TColor = TColor($0000D5D5);
  clIccBG              :TColor = TColor($00D5FFFF);
  clIccBGActive        :TColor = TColor($00AAFFFF);
  clIccBGModify        :TColor = TColor($0055FFFF);

  clIccEditorBGNormal  :TColor = TColor(clWhite);
  clIccEditorBGReadOnly:TColor = TColor(clWhite);
  clIccEditorBGInfoField:TColor = TColor(clWhite);
  clIccEditorBGExtText :TColor = TColor($0080FFFF);
  clIccEditorFont      :TColor = TColor(clBlack);

  clIccMemoFont        :TColor = TColor(clBlack);

  clIccButtonFrameTop  :TColor = TColor($00CEFFFF);
  clIccButtonFrame     :TColor = TColor($00B3FFFF);
  clIccButtonFrameBot  :TColor = TColor($0055FFFF);
  clIccButtonGradBeg   :TColor = TColor($00EAFFFF);
  clIccButtonGradEnd   :TColor = TColor($006AFFFF);
  clIccButtonFont      :TColor = TColor($00005555);
  clIccButtonFontShad  :TColor = TColor($00D4D4D4);
  clIccButtonFontDis   :TColor = TColor($0092A1A1);
  clIccButtonSelected  :TColor = TColor($0030B3F8);
  clIccButtonBorderDis :TColor = TColor($00D3D3D6);
  clIccButtonDis       :TColor = TColor($00EDF1F1);

  clIccChBoxCheck       :TColor = TColor($0000A000);
  clIccChBoxCheckDis    :TColor = TColor(clLtGray);
  clIccChBoxDownGradBeg :TColor = TColor($0055FFFF);
  clIccChBoxDownGradEnd :TColor = TColor($00D5FFFF);
  clIccChBoxActGradBeg  :TColor = TColor($00CFF0FF);
  clIccChBoxActGradEnd  :TColor = TColor($0030B3F8);
  clIccChBoxInactGradBeg:TColor = TColor($00B5FFFF);
  clIccChBoxInactGradEnd:TColor = TColor(clWhite);

  clIccComboBoxActButton  :TColor = TColor($0095FFFF);
  clIccComboBoxInactButton:TColor = TColor($00B5FFFF);
  clIccComboBoxGradBeg    :TColor = TColor(clWhite);
  clIccComboBoxGradEnd    :TColor = TColor($00B5FFFF);
  clIccComboBoxSelBeg     :TColor = TColor($0075FFFF);
  clIccComboBoxSelEnd     :TColor = TColor($00B5FFFF);

  clIccStatusLineBG       :TColor = TColor($00B5FFFF);
  clIccStatusLineLn       :TColor = TColor(clOlive);
  clIccStatusLineBorderL  :TColor = TColor(clWhite);
  clIccStatusLineBorderD  :TColor = TColor($0000D5D5);
  clIccStatusLineFont     :TColor = TColor(clBlack);

  clIccPanelBG            :TColor = TColor($00F3D0C2); //$00F3D0C2
  clIccPanelBGBeg         :TColor = TColor($00FBF1ED); //$FBF1ED
  clIccPanelBGEnd         :TColor = TColor($00F7DFD6); //$F7DFD6
  clIccPanelTitleBeg      :TColor = TColor(clWhite);   //$FFFFFF
  clIccPanelTitleEnd      :TColor = TColor($00F0BDAA); //$F0BDAA
  clIccPanelTitleFont     :TColor = TColor(clNavy);    //clNavy
  clIccPanelTitleFontSh   :TColor = TColor(clLtGray);  //clLtGray
  clIccPanelArrowAct      :TColor = TColor($00FF5C33); //$FF5C33
  clIccPanelArrowInact    :TColor = TColor($00A53C00); //$A53C00
  clIccPanelCircle        :TColor = TColor($0015EAEA);
  clIccPanelBorder        :TColor = TColor(clWhite);

  clIccPageBG             :TColor = TColor($00B5FFFF); //$00F3D0C2
  clIccPageBGBeg          :TColor = TColor(clWhite);   //clWhite
  clIccPageBGEnd          :TColor = TColor($00B5FFFF); //$00EED2C1
  clIccPageTab            :TColor = TColor($00D5FFFF); //$00FBF3EE

  TclIccActBorder          :Smallint = 50;
  TclIccInactBorder        :Smallint = 30;
  TclIccBG                 :Smallint = -255;
  TclIccBGActive           :Smallint = 25;  // Kurzor
  TclIccBGModify           :Smallint = 15;

  TclIccEditorBGReadOnly   :Smallint = 15;
  TclIccEditorBGInfoField  :Smallint = -10;
  TclIccEditorBGExtText    :Smallint = 10;

  TclIccButtonFrameTop     :Smallint = 5;
  TclIccButtonFrame        :Smallint = 10;
  TclIccButtonFrameBot     :Smallint = 30;
  TclIccButtonGradBeg      :Smallint = -255;
  TclIccButtonGradEnd      :Smallint = 10;
  TclIccButtonFont         :Smallint = 140;

  TclIccComboBoxActButton  :Smallint = 20;
  TclIccComboBoxInactButton:Smallint = 10;
  TclIccComboBoxGradBeg    :Smallint = -255;
  TclIccComboBoxGradEnd    :Smallint = 10;
  TclIccComboBoxSelBeg     :Smallint = 20;
  TclIccComboBoxSelEnd     :Smallint = 5;

  TclIccStatusLineBG       :Smallint = 0;
  TclIccStatusLineLn       :Smallint = 25;
  TclIccStatusLineBorderL  :Smallint = -255;
  TclIccStatusLineBorderD  :Smallint = 50;
  TclIccStatusLineFont     :Smallint = 255;

  TclIccPanelBG            :Smallint = 0;
  TclIccPanelBGBeg         :Smallint = 0;
  TclIccPanelBGEnd         :Smallint = 0;
  TclIccPanelTitleEnd      :Smallint = 15;
  TclIccPanelArrowAct      :Smallint = 50;
  TclIccPanelArrowInact    :Smallint = 30;
  TclIccPanelCircle        :Smallint = 70;

  TclIccPageBG             :Smallint = 0;
  TclIccPageBGBeg          :Smallint = 0;
  TclIccPageBGEnd          :Smallint = 0;
  TclIccPageTab            :Smallint = 10;

  TclIccChBoxDownGradBeg   :Smallint = 10;
  TclIccChBoxDownGradEnd   :Smallint = -255;
  TclIccChBoxInactGradBeg  :Smallint = -255;
  TclIccChBoxInactGradEnd  :Smallint = 10;
  TclIccChBoxActGradBeg    :Smallint = -40;
  TclIccChBoxActGradEnd    :Smallint = -10;

(*
  TclIccActBorder          :Smallint = 85;
  TclIccInactBorder        :Smallint = 42;
  TclIccBG                 :Smallint = -220;
  TclIccBGActive           :Smallint = -170;
  TclIccBGModify           :Smallint = -85;

  TclIccEditorBGExtText    :Smallint = -128;

  TclIccButtonFrameTop     :Smallint = -206;
  TclIccButtonFrame        :Smallint = -179;
  TclIccButtonFrameBot     :Smallint = -85;
  TclIccButtonGradBeg      :Smallint = -234;
  TclIccButtonGradEnd      :Smallint = -106;
  TclIccButtonFont         :Smallint = 170;

  TclIccChBoxDownGradBeg   :Smallint = -85;
  TclIccChBoxDownGradEnd   :Smallint = -213;
  TclIccChBoxActGradBeg    :Smallint = -202;
  TclIccChBoxActGradEnd    :Smallint = -43;
  TclIccChBoxInactGradBeg  :Smallint = -181;
  TclIccChBoxInactGradEnd  :Smallint = -255;

  TclIccComboBoxActButton  :Smallint = -149;
  TclIccComboBoxInactButton:Smallint = -181;
  TclIccComboBoxGradBeg    :Smallint = -255;
  TclIccComboBoxGradEnd    :Smallint = -181;
  TclIccComboBoxSelBeg     :Smallint = -117;
  TclIccComboBoxSelEnd     :Smallint = -181;

  TclIccStatusLineBG       :Smallint = -181;
  TclIccStatusLineLn       :Smallint = 127;

  TclIccPanelBG            :Smallint = -181;
  TclIccPanelBGBeg         :Smallint = -234;
  TclIccPanelBGEnd         :Smallint = -202;
  TclIccPanelTitleEnd      :Smallint = -159;
  TclIccPanelArrowAct      :Smallint = 42;
  TclIccPanelArrowInact    :Smallint = 85;
  TclIccPanelCircle        :Smallint = 0;

  TclIccPageBG             :Smallint = -181;
  TclIccPageBGEnd          :Smallint = -181;
  TclIccPageTab            :Smallint = -213;
*)


  function FillStr (pStr:string;pLen:byte;pCh:string):string;
           //Hodnota funkcie je retazec pStr vyplneny z prava
           //so znakom pCh na pLen dlzku
  function AlignLeftBy (pStr:string;pLen:byte;pCh:char):string;
           //Doplní reazec z ¾ava so zadaním znakom
  function AlignRightBy (pStr:string;pLen:byte;pCh:char):string;
           //Doplní reacez z prava so zadaním znakom
  function  ValInt        (pStr:string):longint;
            //Prekonvertuje string na celé èíslo
  function  StrInt        (pNum:longint;pWidth:byte):string;
            //Prekonvertuje celé èíslo na string
  function StrIntZero (pNum:integer;pWidth:byte):string;
           //Prekonvertuje celé èíslo na string a z predu doplní s nulami
  function  ValDoub       (pStr:string):double;
            //Prekonvertuje string na reálne èíslo
  function  StrDoub       (pNum:double;pWidth,pDeci:byte):string;
            //PrekonvertujÚ reálne èíslo na string
  function  StrDoubSepar (pNum:double;pLen,pFrac:byte):string;
            //Prekonvertuje reálne èíslo na string doplnení s medzerami po tisíckach

  function  RemLeftSpaces  (pStr:string):string;
            //Odstráni medzery z ¾ava
  function  RemRightSpaces (pStr:string):string;
            //Odstráni medzery z prava
  function  RemSpaces      (pStr:string):string;
            //Odstráni zbytoèné medzery z reazca

  function StripFractZero (pNum:string):string;
           //Odstrani zbytocne nuly za desatinnou ciarkou

  function LineElement      (const pStr: string; const pNum: integer; const pSeparator :char): string;//new 1999.4.27.

  function  ReplaceStr     (pStr,pFind,pRepl:string):string;
            //Nahradí všetky podreazce so zadanou reazcou
  function  VerifyDate (pDate:string):string;
            //Kontroluje správnos dátumu rôzneho fomátu

  function MakeDarkColor (AColor : TColor; ADarkRate : Integer) : TColor;

  procedure RGBtoHLS(RGBColor: TColor; var Hue, Lum, Sat: Byte);  // Prekonvertuje RGB farbu na odtieò, sýtos a jas
  function  HLStoRGB(Hue, Lum, Sat:byte): TColor;           // Prekonvertuje odtieò, sýtos a jas na RGB farbu

  function  IccCompHueColor (AColor: TColor; ADarkRate: Integer) : TColor;

  function  GetDateFileName (pDate:TDateTime):string;

  procedure SetSystemColor (pColor:TColor;pDarknes:byte);

implementation

function  FillStr (pStr:string;pLen:byte;pCh:string):string;
var mCh: array [1..255] of char;  I: byte;  mStr: string;
    mLen:longint;  mL: longint;
begin
  mL := pLen;
  mLen := Length (pStr)+mL;
  For I:=1 to 255 do
    mCh[I] := #32;
  FillChar (mCh,mLen,pCh[1]);
  For I:=mL+1 to (mL+Length (pStr)) do
    mCh[I] := pStr[I-mL];
  mStr := '';
  For I := 1 to mLen do
    mStr := mStr+mCh[I];
  Result := mStr;
end;

function  AlignLeftBy (pStr:string;pLen:byte;pCh:char):string;
var mF:string;
begin
  If Length (pStr)>=pLen
  then pStr := Copy (pStr,1,pLen)
  else begin
    mF := '';
    mF := FillStr (mF,pLen-Length (pStr)+1,pCh);
    mF := Copy (mF,1,pLen-Length (pStr));
    pStr := mF+pStr;
  end;
  AlignLeftBy := pStr;
end;

function  AlignRightBy (pStr:string;pLen:byte;pCh:char):string;
var
  mF:string;
  mB:byte;
begin
  If Length (pStr)>=pLen
  then pStr := Copy (pStr,1,pLen)
  else begin
    mF := '';
    mB := pLen-Length (pStr)+1;
    mF := FillStr (mF,mB,pCh);
    mF := Copy (mF,1,pLen-Length (pStr));
    pStr := pStr+mF;
  end;
  AlignRightBy := pStr;
end;

function  ValInt (pStr:string):longint;
var
  mNum:longint;
  mErr:integer;
begin
  Val (pStr,mNum,mErr);
  If mErr<>0 then mNum := 0;
  ValInt := mNum;
end;

function  StrInt (pNum:longint;pWidth:byte):string;
var mStr:string;
begin
  Str (pNum:pWidth,mStr);
  StrInt := mStr;
end;

function  StrIntZero (pNum:longint;pWidth:byte):string;
begin
  Result := AlignLeftBy (StrInt (pNum,0),pWidth,'0');
end;

function  ValDoub (pStr:string):double;
var
  mNum:double;
  mErr:integer;
begin
  Val (pStr,mNum,mErr);
  If mErr<>0 then mNum := 0;
  ValDoub := mNum;
end;

function  StrDoub (pNum:double;pWidth,pDeci:byte):string;
var mStr:string;
begin
  Str (pNum:pWidth:pDeci,mStr);
  StrDoub := mStr;
end;

function  StrDoubSepar (pNum:double;pLen,pFrac:byte):string;
var
  mS: string;
  mI,mF:string;
  I:byte;
  mCnt:byte;
BEGIN
  try
    mS := StrDoub (pNum,pLen,pFrac);
  except end;
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
  StrDoubSepar := mS;
end;

function  RemLeftSpaces (pStr:string):string;
begin
  While Pos (' ',pStr)=1 do Delete (pStr,1,1);
  RemLeftSpaces := pStr;
end;

function  RemRightSpaces (pStr:string):string;
begin
  While Copy (pStr,Length (pStr),1)=' ' do Delete (pStr,Length (pStr),1);
  RemRightSpaces := pStr;
end;

function  RemSpaces (pStr:string):string;
begin
  pStr := RemLeftSpaces (RemRightSpaces (pStr));
  While Pos ('  ',pStr)>0 do Delete (pStr,Pos ('  ',pStr),1);
  RemSpaces := pStr;
end;

function StripFractZero (pNum:string):string;
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

function  LineElement(const pStr: string; const pNum: integer; const pSeparator :char): string;//new 1999.4.27.
var mStr: string;  I, mNum:integer;
begin
  mStr := '';  mNum := 0; I := 1;
  While (I<=Length(pStr)) and (pStr[I]<>#0) and (mNum<=pNum) do begin
    If (pStr[i] = pSeparator) then begin
      Inc(mNum)
    end else begin
      If (mNum = pNum) then mStr := mStr + pStr[i];
    end;
    Inc(I);
  end;
  Result := mStr;
end;

function  ReplaceStr (pStr,pFind,pRepl:string):string;
var mStr:string;
begin
  mStr := '';
  While Pos (pFind,pStr)>0 do begin
    mStr := mStr+Copy (pStr,1,Pos (pFind,pStr)-1)+pRepl;
    Delete (pStr,1,Pos (pFind,pStr)-1+Length (pFind));
  end;
  ReplaceStr := mStr+pStr;
end;

function  VerifyDate (pDate:string):string;
var
  mDateS:string;
  mD,mM,mY:word;
  mWD  :longint;
  mW   :longint;
  mS   :string;
  mFDate:TDateTime;
  mDate :TDateTime;
begin
  pDate := RemLeftSpaces (RemRightSpaces (pDate));
  If pDate='' then begin
    try
      mDateS := DateToStr (Date);
    except mDateS := ''; end;
  end else begin
    mDateS := '';
    mWD := 1;
    DecodeDate (Date,mY,mM,mD);
    mDateS := ReplaceStr (pDate,',','.');
    If (Length (mDateS)>2) and (Pos ('.',mDateS)=0) then begin
      Insert ('.',mDateS,3);
      If Length (mDateS)>5 then Insert ('.',mDateS,6);
    end;
    If Pos ('.',mDateS)>0 then begin
      mD := ValInt (Copy (mDateS,1,Pos ('.',mDateS)-1));
      mDateS := Copy (mDateS,Pos ('.',mDateS)+1,Length (mDateS));
      If Pos ('.',mDateS)>0 then begin
        mM := ValInt (Copy (mDateS,1,Pos ('.',mDateS)-1));
        mDateS := Copy (mDateS,Pos ('.',mDateS)+1,Length (mDateS));
        If mDateS<>'' then begin
          mY := ValInt (mDateS);
         If mY<100 then begin
           If mY<90
             then mY := mY+2000
             else mY := mY+1900;
         end;
        end;
      end else mM := ValInt (mDateS);
    end else mD := ValInt (mDateS);
    If (mY=0) or (mM=0) or (mD=0)
      then mDateS := ''
      else begin
        try
          mDateS := DateToStr (EncodeDate (mY,mM,mD));
        except mDateS := ''; end;
      end;
  end;
  VerifyDate := mDateS;
end;

function MakeDarkColor (AColor : TColor; ADarkRate : Integer) : TColor;
var
  R, G, B : Integer;
begin
  R := GetRValue (ColorToRGB (AColor)) - ADarkRate;
  G := GetGValue (ColorToRGB (AColor)) - ADarkRate;
  B := GetBValue (ColorToRGB (AColor)) - ADarkRate;
  If R < 0 then R := 0;
  If G < 0 then G := 0;
  If B < 0 then B := 0;
  If R > 255 then R := 255;
  If G > 255 then G := 255;
  If B > 255 then B := 255;
  Result := TColor (RGB (R, G, B));
end;

procedure RGBtoHLS(RGBColor: TColor; var Hue, Lum, Sat: Byte);
var
 R, G, B: Byte;
 cMax, cMin: Byte;
 RDelta,GDelta,BDelta: Word;
begin
  R := GetRValue(RGBColor);
  G := GetGValue(RGBColor);
  B := GetBValue(RGBColor);
  cMax := Max(Max(R, G), B);
  cMin := Min(Min(R, G), B);
  Lum := (((cMax + cMin)*HLSMAX) + RGBMAX ) div (2*RGBMAX);
  If cMax = cMin then begin
    Sat := 0;
    Hue := UNDEFINED;
  end else begin
    If Lum <= (HLSMAX div 2)
      then Sat := (((cMax - cMin)*HLSMAX) + ((cMax + cMin) div 2)) div (cMax + cMin)
      else Sat := (((cMax - cMin)*HLSMAX) + ((2*RGBMAX - cMax - cMin) div 2)) div (2*RGBMAX - cMax - cMin);

    RDelta := (((cMax - R)*(HLSMAX div 6)) + ((cMax - cMin) div 2)) div (cMax - cMin);
    GDelta := (((cMax - G)*(HLSMAX div 6)) + ((cMax - cMin) div 2)) div (cMax - cMin);
    BDelta := (((cMax - B)*(HLSMAX div 6)) + ((cMax - cMin) div 2)) div (cMax - cMin);
    If R = cMax
      then Hue := BDelta - GDelta
      else begin
        If G = cMax
          then Hue := (HLSMAX div 3) + RDelta - BDelta
          else Hue := ((2*HLSMAX) div 3) + GDelta - RDelta;
      end;
  end;
end;

function HLStoRGB(Hue, Lum, Sat:byte): TColor;

  function HueToRGB(n1, n2, Hue: Byte): Byte;
  begin
    Result := n1;
    If Hue < (HLSMAX div 6) then begin
      Result := (n1 + (((n2 - n1)*Hue + (HLSMAX div 12)) div (HLSMAX div 6)));
      Exit;
    end;
    If Hue < (HLSMAX div 2) then begin
      Result := n2;
      Exit;
    end;
    If Hue < ((HLSMAX*2) div 3) then begin
      Result := (n1 + (((n2 - n1)*(((HLSMAX*2) div 3) - Hue)+(HLSMAX div 12)) div (HLSMAX div 6)));
      Exit;
    end;
  end;

var
  R, G, B: Byte;
  Magic1, Magic2: Word; mColor:longint;
begin
  If Sat = 0 then begin
    B := (Lum*RGBMAX) div HLSMAX;
    R := B;
    G := B;
    If Hue <> UNDEFINED then raise EConvertError.Create('Bad Hue');
  end else begin
    If Lum <= (HLSMAX div 2)
      then Magic2 := (Lum*(HLSMAX + Sat) + (HLSMAX div 2)) div HLSMAX
      else Magic2 := Lum + Sat - ((Lum*Sat) + (HLSMAX div 2)) div HLSMAX;
    Magic1 := 2*Lum - Magic2;

    mColor := Hue + (HLSMAX div 3);
    If mColor>255 then mColor := 255;
    If mColor<0 then mColor := 0;
    R := (HueToRGB(Magic1, Magic2, byte (mColor))*RGBMAX + (HLSMAX div 2)) div HLSMAX;
    G := (HueToRGB(Magic1, Magic2, Hue)*RGBMAX + (HLSMAX div 2)) div HLSMAX;
    mColor := Hue - (HLSMAX div 3);
    If mColor>255 then mColor := 255;
    If mColor<0 then mColor := 0;
    B := (HueToRGB(Magic1, Magic2, byte (mColor))*RGBMAX + (HLSMAX div 2)) div HLSMAX;
  end;
  Result := RGB(R, G, B);
end;

procedure RGBtoHSB(const r, g, b: Integer; var h, s, br: Double);
var
  largestColor: Integer; {holds the largest color (RGB) at the start}
  lowestColor: Integer; {opposite of above}
  hue: Double; {it puts the ""H"" in ""HSB""}
  saturation: Double; {S}
  brightness: Double; {and the B}
  redRatio: Double;
  greenRatio: Double;
  blueRatio: Double;
begin
  If (r <= g) then largestColor := g else largestColor := r;
  If (b > largestColor) then largestColor := b;
  If (g < r) then lowestColor := g else lowestColor := r;
  If (b < lowestColor) then lowestColor := b;

  brightness := largestColor / 255;
  If (largestColor <> 0)
    then saturation := (largestColor - lowestColor) / largestColor
    else saturation := 0;
  If (saturation = 0.0)
    then hue := 0.0
    else begin
      redRatio := (largestColor - r) / (largestColor - lowestColor);
      greenRatio := (largestColor - g) / (largestColor - lowestColor);
      blueRatio := (largestColor - b) / (largestColor - lowestColor);
      If (r = largestColor)
        then hue := blueRatio - greenRatio
        else begin
          If (g = largestColor)
            then hue := (2.0 + redRatio) - blueRatio
            else hue := (4.0 + greenRatio) - redRatio;
        end;
      hue := hue / 6.0;
      If (hue < 0.0) then hue := hue + 1;
    end;
  h := hue;
  s := saturation;
  br := brightness;
end;

procedure HSBtoRGB(const hue, saturation, brightness: Double; var r, g, b:
  Integer);
const
  max = 255;
var
  h: Double;
  f: Double;
  p: Double;
  q: Double;
  t: Double;
begin
  If (saturation = 0) then begin
    r := trunc(brightness * 255);
    g := trunc(brightness * 255);
    b := trunc(brightness * 255);
  end else begin
    h := (hue - floor(hue)) * 6.0;
    f := h - floor(h);
    p := brightness * (1.0 - saturation);
    q := brightness * (1.0 - saturation * f);
    t := brightness * (1.0 - (saturation * (1.0 - f)));
    case trunc(h) of
      0:
        begin
          r := trunc(brightness * 255);
          g := trunc(t * max);
          b := trunc(p * max);
        end;
      1:
        begin
          r := trunc(q * max);
          g := trunc(brightness * max);
          b := trunc(p * max);
        end;
      2:
        begin
          r := trunc(p * max);
          g := trunc(brightness * max);
          b := trunc(t * max);
        end;
      3:
        begin
          r := trunc(p * max);
          g := trunc(q * max);
          b := trunc(brightness * max);
        end;
      4:
        begin
          r := trunc(t * max);
          g := trunc(p * max);
          b := trunc(brightness * max);
        end;
      5:
        begin
          r := trunc(brightness * max);
          g := trunc(p * max);
          b := trunc(q * max);
        end;
    end;
  end;
end;

function  IccCompHueColor (AColor: TColor; ADarkRate: Integer) : TColor;
var mHue, mLum, mSat:byte; mNewLum:integer; mR,mG,mB:longint;
begin
//  RGBtoHLS ($00FFE6E6, mHue, mLum, mSat);
//  Result := HLStoRGB(mHue, mLum, mSat);


  RGBtoHLS (AColor, mHue, mLum, mSat);
  mNewLum := mLum-ADarkRate;
  If mNewLum<0 then mNewLum := 0;
  If mNewLum>255 then mNewLum := 255;
  mLum := mNewLum;
  Result := HLStoRGB(mHue, mLum, mSat);
(*
//  RGBToColor ();
  mR := GetRValue (AColor);
  mG := GetGValue (AColor);
  mB := GetBValue (AColor);
  RGBtoHSB(mR,mG,mB,mHue,mLum,mSat);
  mR := 124;
  mG := 124;
  mB := 124;
  RGBtoHSB(mR,mG,mB,mHue,mLum,mSat);
//  mSat := Int ((mSat*10000000))/10000000;
  HSBtoRGB(mHue,mLum,mSat,mR,mG,mB);
  mR := 126;
  mG := 126;
  mB := 126;
//  mSat := Int ((mSat*10000))/10000;
  RGBtoHSB(mR,mG,mB,mHue,mLum,mSat);
  HSBtoRGB(mHue,mLum,mSat,mR,mG,mB);
  Result := RGB (mR,mG,mB);*)
end;

function  GetDateFileName (pDate:TDateTime):string;
var mD,mM,mY:word;
begin
  DecodeDate (pDate,mY,mM,mD);
  Result := StrIntZero (mD,2)+StrIntZero (mM,2)+Copy (StrInt (mY,4),3,2);
end;

procedure SetSystemColor (pColor:TColor;pDarknes:byte);
begin
  clIccActBorder       := IccCompHueColor (clWhite, 0);
  clIccActBorder       := IccCompHueColor (clBlack, 0);
  clIccActBorder       := IccCompHueColor (pColor, TclIccActBorder);
  clIccInactBorder     := IccCompHueColor (pColor, TclIccInactBorder);
  clIccBG              := IccCompHueColor (pColor, TclIccBG);
  clIccBGActive        := IccCompHueColor (pColor, TclIccBGActive);
  clIccBGModify        := IccCompHueColor (pColor, TclIccBGModify);

  clIccEditorBGExtText := IccCompHueColor (pColor, TclIccEditorBGExtText);
  clIccEditorBGReadOnly  := IccCompHueColor (pColor, TclIccEditorBGReadOnly);
  clIccEditorBGInfoField := IccCompHueColor (pColor, TclIccEditorBGInfoField);

  clIccButtonFrameTop  := IccCompHueColor (pColor, TclIccButtonFrameTop);
  clIccButtonFrame     := IccCompHueColor (pColor, TclIccButtonFrame);
  clIccButtonFrameBot  := IccCompHueColor (pColor, TclIccButtonFrameBot);
  clIccButtonGradBeg   := IccCompHueColor (pColor, TclIccButtonGradBeg);
  clIccButtonGradEnd   := IccCompHueColor (pColor, TclIccButtonGradEnd);
  clIccButtonFont      := IccCompHueColor (pColor, TclIccButtonFont);

  clIccChBoxDownGradBeg  := IccCompHueColor (pColor, TclIccChBoxDownGradBeg);
  clIccChBoxDownGradEnd  := IccCompHueColor (pColor, TclIccChBoxDownGradEnd);
  clIccChBoxInactGradBeg := IccCompHueColor (pColor, TclIccChBoxInactGradBeg);
  clIccChBoxInactGradEnd := IccCompHueColor (pColor, TclIccChBoxInactGradEnd);

  clIccComboBoxActButton   := IccCompHueColor (pColor, TclIccComboBoxActButton);
  clIccComboBoxInactButton := IccCompHueColor (pColor, TclIccComboBoxInactButton);
  clIccComboBoxGradBeg     := IccCompHueColor (pColor, TclIccComboBoxGradBeg);
  clIccComboBoxGradEnd     := IccCompHueColor (pColor, TclIccComboBoxGradEnd);
  clIccComboBoxSelBeg      := IccCompHueColor (pColor, TclIccComboBoxSelBeg);
  clIccComboBoxSelEnd      := IccCompHueColor (pColor, TclIccComboBoxSelEnd);

  clIccStatusLineBG       := IccCompHueColor (pColor, TclIccStatusLineBG);
  clIccStatusLineLn       := IccCompHueColor (pColor, TclIccStatusLineLn);
  clIccStatusLineBorderL  := clWhite;
  clIccStatusLineBorderD  := IccCompHueColor (pColor, TclIccStatusLineBorderD);
  clIccStatusLineFont     := clBlack;

  clIccPanelBG            := IccCompHueColor (pColor, TclIccPanelBG);
  clIccPanelBGBeg         := IccCompHueColor (pColor, TclIccPanelBGBeg);
  clIccPanelBGEnd         := IccCompHueColor (pColor, TclIccPanelBGEnd);
//  clIccPanelTitleBeg      := IccCompHueColor (pColor, TclIccStatusLineLn);
  clIccPanelTitleEnd      := IccCompHueColor (pColor, TclIccPanelTitleEnd);
//  clIccPanelTitleFont     := IccCompHueColor (pColor, TclIccStatusLineLn);
  clIccPanelArrowAct      := IccCompHueColor (pColor, TclIccPanelArrowAct);
  clIccPanelArrowInact    := IccCompHueColor (pColor, TclIccPanelArrowInact);
  clIccPanelCircle        := IccCompHueColor (pColor, TclIccPanelCircle);
  clIccPanelBorder        := IccCompHueColor (pColor, TclIccStatusLineLn);

  clIccPageBG             := IccCompHueColor (pColor, TclIccPageBG);
  clIccPageBGBeg          := IccCompHueColor (pColor, TclIccPageBGBeg);
  clIccPageBGEnd          := IccCompHueColor (pColor, TclIccPageBGEnd);
  clIccPageTab            := IccCompHueColor (pColor, TclIccPageTab);
end;

begin
//  SetSystemColor ($00FFE6E6,2);
  SetSystemColor (cbcBasicColor,2);
end.
