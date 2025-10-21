{$B-}
unit barqr5;
{Change History
July 17th 1998   Before testing whether canvas is qreport.printer.canvas, check
whether it is self.canvas.  Can be asked to draw self when qreportprinter
not initialised}

interface

uses
   WinTypes, WinProcs, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  ExtCtrls, printers, QuickRpt, db, dbctrls, dbTables;







type
  TBarCodeType = (Code39,Interleaved2Of5,Code128,PostNet,PostnetZip,PostNetZipPlus4,Postnet11,
  EAN,EAN8,EAN13,ITF14,FIMA,FIMB,FIMC, EAN128);{Postnet & ean8/13.. determines which by Data provided }
  Charbool = array[1..9] of boolean;




  TQRBarcode = class(TQRPrintable)
  private
   {for Barcoding}
    FDesignable : boolean;
    Bars, Blank : CharBool;
    FBarCodeType : TBarCodeType;{MAY KEEP THIS.. NOT SURE}
    SavePenColor : TColor;
    SaveBrushColor : TColor;
    SaveFont : TFont;
    FBarColor : TColor;
    FClearZone : boolean;
    FWidthInInches : Double;
    FLeftInInches : Double;
{    DataAware}
    FDataSet : TDataset;
    FDataField : string;
    FField : TField;
    FDataOK : boolean;

    procedure SetText(const Value: TCaption);
    PROCEDURE SetBarCodeType(Value : TBarCodeType);
    PROCEDURE SetBarColor(Value : TColor);

{  DataAware}
    procedure SetDataField(Const Value: string);
  protected
  StartX1, StartY1, StartX2, StartY2 : integer;
  NewX1, NewY1, NewX2, NewY2 : integer;
  LastX1, LastY1, LastX2, LastY2 : integer;
  StartMX, StartMY : integer; {for start move pos}
  MoveTop, MoveLeft, MoveRight, MoveBottom, MoveAll : boolean;
   FUNCTION GetHeightInInches : Double;{only Ean}
   FUNCTION GetWidthInInches : Double;{only Ean}
   FUNCTION GetTopInInches : Double;{only Ean}
   FUNCTION GetLeftInInches : Double;{only Ean}
   PROCEDURE Loaded ; override;
   PROCEDURE Prepare; override;
  public
    constructor Create(AOwner : TComponent); override;
    destructor Destroy; override;
    procedure Paint; override;
    procedure Print(OfsX, OfsY : integer); override;
    PROCEDURE DrawBarCode(PrintWhere : TObject;UsePixelsPerInchX : integer);
    procedure SetHeightInInches(Value : Double);
    procedure SetWidthInInches(Value : Double);
    procedure SetTopInInches(Value : Double);
    procedure SetLeftInInches(Value : Double);

   { Public declarations }
  published
    Property Text write SetText;
    Property BarCodeType : TBarCodeType Read FBarCodeType write SetBarCodeType Default code39;
    Property ClearZone : boolean read FClearZone write FClearZone default true;
    Property HeightInInches : Double Read GetHeightInInches write SetHeightInInches;
    Property WidthInInches : double Read GetWidthInInches write SetWidthInInches;
    Property TopInInches : Double Read GetTopInInches write SetTopInInches;
    Property LeftInInches : double Read GetLeftInInches write SetLeftInInches;
    { Published declarations }
    Property BarColor : TColor read FBarColor write SetBarcolor Default clBLack;
    Property DataField : String read FDataField write SetDataField;
    Property DataSet : TDataSet read FDataset write FDataset;
  END;

procedure Register;

var TempPaintBox : TPaintBox;

implementation
VAR UseHeight, UseWidth : integer;


procedure Register;
begin
  RegisterComponents('QReport', [TQRBarcode]);
END;


PROCEDURE TQRBarcode.DrawBarCode(PrintWhere : TObject;UsePixelsPerInchX : integer);
var
  Slength, {MinLength, }LeadIn : integer;
  Wide, Narrow, mult, Height : integer; {# pixels}
  StartPoint : integer; {where Barcode next bar Starts}
  StartX, StartY : integer;
  WhichCanvas : TCanvas;
  UsePixelsPerInchY : integer;

PROCEDURE  printbar(Sender : TCanvas; drk, WideBar : boolean); {Uses global vars so all procs can call}
var Barwidth : integer;
BEGIN

  with  Sender do
  BEGIN
  if drk then Pen.Color := FBarColor  else  Pen.Color := Self.color;
  if drk then  Brush.Color := FBarColor else Brush.Color := Self.color;
  if WideBar then Barwidth := Wide else BarWidth := Narrow;
  Rectangle(StartPOint + StartX,0+ StartY,StartPOint + BarWidth + StartX,UseHeight + StartY);
  StartPoint := StartPOint + BarWidth;

  END
END;




procedure PCode39(S : string; Sender: TCanvas);
var
SI, LI : integer;
ClearSize : integer;



PROCEDURE barchar(ch : char);
var Drk : boolean;
    i : integer;



     PROCEDURE EnCode(ch : char);
     BEGIN
       Bars := blank;
       case ch of
       '0' : BEGIN Bars[4] := true; Bars[5] := true; Bars[7] := true; END;
       '1' : BEGIN Bars[1] := true; Bars[4] := true; Bars[9] := true; END;
       '2' : BEGIN Bars[3] := true; Bars[4] := true; Bars[9] := true; END;
       '3' : BEGIN Bars[1] := true; Bars[3] := true; Bars[4] := true; END;
       '4' : BEGIN Bars[4] := true; Bars[5] := true; Bars[9] := true; END;
       '5' : BEGIN Bars[1] := true; Bars[4] := true; Bars[5] := true; END;
       '6' : BEGIN Bars[3] := true; Bars[4] := true; Bars[5] := true; END;
       '7' : BEGIN Bars[4] := true; Bars[7] := true; Bars[9] := true; END;
       '8' : BEGIN Bars[1] := true; Bars[4] := true; Bars[7] := true; END;
       '9' : BEGIN Bars[3] := true; Bars[4] := true; Bars[7] := true; END;
       'A' : BEGIN Bars[1] := true; Bars[6] := true; Bars[9] := true; END;
       'B' : BEGIN Bars[3] := true; Bars[6] := true; Bars[9] := true; END;
       'C' : BEGIN Bars[1] := true; Bars[3] := true; Bars[6] := true; END;
       'D' : BEGIN Bars[5] := true; Bars[6] := true; Bars[9] := true; END;
       'E' : BEGIN Bars[1] := true; Bars[5] := true; Bars[6] := true; END;
       'F' : BEGIN Bars[3] := true; Bars[5] := true; Bars[6] := true; END;
       'G' : BEGIN Bars[6] := true; Bars[7] := true; Bars[9] := true; END;
       'H' : BEGIN Bars[1] := true; Bars[6] := true; Bars[7] := true; END;
       'I' : BEGIN Bars[3] := true; Bars[6] := true; Bars[7] := true; END;
       'J' : BEGIN Bars[5] := true; Bars[6] := true; Bars[7] := true; END;
       'K' : BEGIN Bars[1] := true; Bars[9] := true; Bars[8] := true; END;
       'L' : BEGIN Bars[3] := true; Bars[9] := true; Bars[8] := true; END;
       'M' : BEGIN Bars[1] := true; Bars[3] := true; Bars[8] := true; END;
       'N' : BEGIN Bars[5] := true; Bars[9] := true; Bars[8] := true; END;
       'O' : BEGIN Bars[1] := true; Bars[5] := true; Bars[8] := true; END;
       'P' : BEGIN Bars[3] := true; Bars[5] := true; Bars[8] := true; END;
       'Q' : BEGIN Bars[7] := true; Bars[9] := true; Bars[8] := true; END;
       'R' : BEGIN Bars[1] := true; Bars[7] := true; Bars[8] := true; END;
       'S' : BEGIN Bars[3] := true; Bars[7] := true; Bars[8] := true; END;
       'T' : BEGIN Bars[5] := true; Bars[7] := true; Bars[8] := true; END;
       'U' : BEGIN Bars[1] := true; Bars[2] := true; Bars[9] := true; END;
       'V' : BEGIN Bars[2] := true; Bars[3] := true; Bars[9] := true; END;
       'W' : BEGIN Bars[1] := true; Bars[2] := true; Bars[3] := true; END;
       'X' : BEGIN Bars[2] := true; Bars[5] := true; Bars[9] := true; END;
       'Y' : BEGIN Bars[1] := true; Bars[2] := true; Bars[5] := true; END;
       'Z' : BEGIN Bars[2] := true; Bars[3] := true; Bars[5] := true; END;
       '-' : BEGIN Bars[2] := true; Bars[7] := true; Bars[9] := true; END;
       '.' : BEGIN Bars[1] := true; Bars[2] := true; Bars[7] := true; END;
       ' ' : BEGIN Bars[2] := true; Bars[3] := true; Bars[7] := true; END;
       '$' : BEGIN Bars[2] := true; Bars[4] := true; Bars[6] := true; END;
       '/' : BEGIN Bars[2] := true; Bars[4] := true; Bars[8] := true; END;
       '+' : BEGIN Bars[2] := true; Bars[6] := true; Bars[8] := true; END;
       '%' : BEGIN Bars[4] := true; Bars[6] := true; Bars[8] := true; END;
       '*' : BEGIN Bars[2] := true; Bars[5] := true; Bars[7] := true; END;
     END;

END;

BEGIN
  EnCode(ch); {returned in Bars}
  drk := true;
  for i := 1 to 9  do
  BEGIN
  printbar(Sender,drk,Bars[i]);
  drk := not drk;
  END;
  printbar(Sender,false,false);
END;



{cODE 39 ration wide : narrow  > 1.8  < 3.4 }

Function TryRatio(TryWide, TryNarrow : integer) : boolean;
{BASICALLY TESTS TO SEE IF IT WILL FIT}
var Leadin, CharSize : integer;
BEGIN
  if not FClearZone then LeadIn := 0
  else
  if TryWIde > 3 then Leadin := 20 else Leadin := 16;
  CharSize := ((3 * TryWide) + (7 * TryNarrow));
  if ((Leadin * TryNarrow) + (CharSize  * (2 + SLength)) > UseWidth) then
  TryRatio := false
  else
  BEGIN
    TryRatio := true; {2:1}
    Wide := tryWide;
    Narrow := TryNarrow;
  END;
END;


BEGIN{PCode39}
  if s = ''  then exit;
  SLength := length(S);
  if (18 + 13 * (2 + SLength)) > UseWidth then  {2:1}
  BEGIN
    if Sender = Self.canvas then
    with  self, canvas do
  BEGIN
  Pen.Color := FBarColor;
  Rectangle(0,0,width,height);
  END;
   exit;
  END;
  if  TryRatio(24,9) then{BIG ANYWAY}
  BEGIN
     if FClearZone then ClearSize := 0 else ClearSize := 19;
     {145 = 3 X Wide (24)  + 7 * Narrow (9)}
     mult := (UseWidth) div ((SLength + 2) * 145 + (Clearsize * 9));
     Wide := mult * 8;
     Narrow := Mult * 3;
  END
  ELSE
  IF NOT TryRatio(20,8) then
  IF NOT TryRatio(16,6) then
  IF NOT TryRatio(13,5) then
  IF NOT TryRatio(10,4) then
  IF NOT TryRatio(8,3) then
  IF NOT TryRatio(6,2) then
  IF NOT TryRatio(5,2) then
  IF NOT TryRatio(3,1) then
  BEGIN
    Wide := 2; Narrow := 1;
  END;
    Leadin :=  UseWidth -  (((3 * Wide) + (7 * Narrow))  * (2 + SLength));
    Leadin := (Leadin + Narrow)  div (2 * Narrow);
    Height := UseHeight;
    StartPoint := 0;
    if Leadin > 0 then
    for LI := 1 to Leadin do PrintBar(Sender,false,False);
    BarChar('*');
    For si := 1 to Length(s) do BarChar(s[SI]);
    BarChar('*');
    if Leadin > 1 then
    for LI := 1 to (Leadin - 1) do PrintBar(Sender,false,False);
  END;

procedure PI2Of5(S : string; Sender: TCanvas);
var
SI, LI : integer;
ClearSizePlusStartEND : integer;



PROCEDURE barchar(ch1,ch2 : char);
var i : integer;
     Bars2 : CharBool;


     PROCEDURE EnCode(ch : char);
     BEGIN
       Bars := blank;
       case ch of
       '0' : BEGIN Bars[3] := true; Bars[4] := true; END;
       '1' : BEGIN Bars[1] := true; Bars[5] := true; END;
       '2' : BEGIN Bars[2] := true; Bars[5] := true; END;
       '3' : BEGIN Bars[1] := true; Bars[2] := true; END;
       '4' : BEGIN Bars[3] := true; Bars[5] := true; END;
       '5' : BEGIN Bars[1] := true; Bars[3] := true; END;
       '6' : BEGIN Bars[2] := true; Bars[3] := true; END;
       '7' : BEGIN Bars[4] := true; Bars[5] := true; END;
       '8' : BEGIN Bars[1] := true; Bars[4] := true; END;
       '9' : BEGIN Bars[2] := true; Bars[4] := true; END;
     END;

END;

BEGIN
  EnCode(ch2); {returned in Bars}
  Bars2 := Bars;
  EnCode(ch1); {returned in Bars}
  for i := 1 to 5  do
  BEGIN
  printbar(Sender,true,Bars[i]);
  printbar(Sender,false,Bars2[i]);
  END;
END;




Function TryRatio(TryWide, TryNarrow : integer) : boolean;
{BASICALLY TESTS TO SEE IF IT WILL FIT}
var Leadin, CharSize, StartENDSymbols : integer;
BEGIN
  if not FClearZone then Leadin := 0 else
  if TryWIde > 3 then Leadin := 21 else {20 MINUTELY UNDER MIN DIMENSIONS}
  if TryWIde > 2 then Leadin := 20 else Leadin := 12;{28 = blank + start & stop bars}
  CharSize := ((2 * TryWide) + (3 * TryNarrow));
  StartENDSymbols := 8 * TryNarrow;
  if ((Leadin * TryNarrow) + (CharSize  * (SLength) + StartENDSymbols)  > UseWidth) then
  TryRatio := false
  else
  BEGIN
    TryRatio := true; {2:1}
    Wide := tryWide;
    Narrow := TryNarrow;
  END;
END;


BEGIN{PI2of5}
  if s = ''  then exit;
  if ((length(s) mod 2) = 1) then s := '0' + s;
  SLength := length(S);
  if (16 + 7 * (SLength)) > UseWidth then
  BEGIN
     if Sender = Self.canvas then
     with  self,canvas do
  BEGIN
  Pen.Color := FBarColor;
  Rectangle(0,0,width,height);
  END;
   exit; {2:1}
  END;
  if  TryRatio(24,9) then{BIG ANYWAY}
  BEGIN
     { start END = 8 narrow = 8   Clear = 21 narrow }
     if FClearZone then ClearSizePlusStartEND := 8  else ClearSizePlusStartEND := 8  + 21;
     {75 = 2 X Wide (24)  + 3 * Narrow (9)}
     mult := (UseWidth) div ((SLength + 2) * 75 + (ClearsizePlusStartEND * 9));
     Wide := mult * 8;
     Narrow := Mult * 3;
  END
  ELSE
  IF NOT TryRatio(20,8) then
  IF NOT TryRatio(16,6) then
  IF NOT TryRatio(13,5) then
  IF NOT TryRatio(10,4) then
  IF NOT TryRatio(8,3) then
  IF NOT TryRatio(6,2) then
  IF NOT TryRatio(5,2) then
  IF NOT TryRatio(3,1) then
  BEGIN
    Wide := 2; Narrow := 1;
  END;
    Leadin :=  UseWidth -  (((2 * Wide) + (3 * Narrow))  * SLength) - 8 * Narrow{start& END Symbols};
    Leadin := (Leadin + Narrow)  div (2 * Narrow);
    Height := UseHeight;
    StartPoint := 0;
    {space at start}
    if Leadin > 0 then
    for LI := 1 to Leadin do PrintBar(Sender,false,False);
    {Lead In Symbol}

    PrintBar(Sender,true,false);
    PrintBar(Sender,false,false);
    PrintBar(Sender,true,false);
    PrintBar(Sender,false,false);
    si := 1;
    REPEAT
     BarChar(s[SI],s[SI + 1]);
     SI := SI + 2;
    UNTIL (SI > SLength);
        {Finish Symbol}
    PrintBar(Sender,true,true);
    PrintBar(Sender,false,false);
    PrintBar(Sender,true,false);
    {space at END}
    if Leadin > 1 then
    for LI := 1 to (Leadin - 1) do PrintBar(Sender,false,False);
{    Guardbars}
    Sender.pen.color := FBarColor;
    Sender.Brush.color := FBarColor;
    Sender.Rectangle(startX + Leadin * Narrow,StartY,
    startX  + (Leadin) * Narrow + (((2 * Wide) + (3 * Narrow))  * SLength  + 8 * NARROW), StartY + 2 * Narrow);
    Sender.Rectangle(startX + Leadin * Narrow,StartY + Height - 2 * narrow,
    startX  + Leadin * Narrow + (((2 * Wide) + (3 * Narrow))  * SLength) + 8 * NARROW, StartY  + Height );
  END;


procedure PPostnet(S : string; Sender: TCanvas; pnSize : integer);

var
SI : integer;
DarkWidth, LightWIdth : integer;
HighHeight,LowHeight : integer;
CorrectionTotal       : integer;

PROCEDURE  printbar(Sender : TCanvas; drk, HighBar : boolean); {Uses global vars so all procs can call}
var Barwidth : integer;
BEGIN

  with  Sender do
  BEGIN
  if drk then Pen.Color := FBarColor else  Pen.Color := Self.color;
  if drk then  Brush.Color := FBarColor else Brush.Color := Self.color;
  if drk then Barwidth := DarkWidth else BarWidth := LightWidth;
  if Highbar then
  Rectangle(StartPOint + StartX,0+ StartY,StartPOint + BarWidth + StartX,HighHeight + StartY)
  ELSE
  BEGIN
  Rectangle(StartPOint + StartX,0+ StartY + HighHeight - LowHeight,StartPOint + BarWidth + StartX,HighHeight + StartY);
  Pen.Color := Self.color;
  Brush.Color := Self.color;
  Rectangle(StartPOint + StartX,0+ StartY ,StartPOint + BarWidth + StartX,HighHeight - Lowheight + StartY);
  END;
  StartPoint := StartPOint + BarWidth;
  END
END;





PROCEDURE barchar(ch : char);
var
    i : integer;


     PROCEDURE EnCode(ch : char);
     BEGIN
       Bars := blank;
       case ch of
       '0' : BEGIN Bars[1] := true; Bars[2] := true; END;
       '1' : BEGIN Bars[4] := true; Bars[5] := true; END;
       '2' : BEGIN Bars[3] := true; Bars[5] := true; END;
       '3' : BEGIN Bars[3] := true; Bars[4] := true; END;
       '4' : BEGIN Bars[2] := true; Bars[5] := true; END;
       '5' : BEGIN Bars[2] := true; Bars[4] := true; END;
       '6' : BEGIN Bars[2] := true; Bars[3] := true; END;
       '7' : BEGIN Bars[1] := true; Bars[5]:= true; END;
       '8' : BEGIN Bars[1] := true; Bars[4] := true; END;
       '9' : BEGIN Bars[1] := true; Bars[3] := true; END;
     END;

END;

BEGIN
  EnCode(ch); {returned in Bars}
  for i := 1 to 5  do
  BEGIN
  printbar(Sender,true,Bars[i]);
  printbar(Sender,False,true);

  END;
END;



BEGIN{PPostnet}
  if s = ''  then exit;
    if length(s) <= pnSize then
    BEGIN
      CorrectionTotal := 0;
      for si := 1 to length(s) do
      CorrectionTotal := CorrectionTotal + Ord(s[si]) - 48;
      CorrectionTotal := 10 - (CorrectionTotal Mod 10);
      if CorrectionTotal = 10 then CorrectionTotal := 0;
      s := s + chr(48 + CorrectionTotal);
    END;
    LightWidth := (UsePixelsPerInchX + 11) Div 22; {bar & space = 22 / inch}
    DarkWidth := LightWidth Div 2;{Bars}
    LightWidth := LightWidth - DarkWidth; {spaces}
    HighHeight := (UsePixelsPerInchY + 4) div 8;{.125"}
    LowHeight := (UsePixelsPerInchY + 10) div 20;{.05"}
    StartPoint := 0;
    {space at start}
{    for LI := 1 to Leadin do PrintBar(Sender,false,False);}
    {Lead In Symbol}
    PrintBar(Sender,true,true);
    PrintBar(Sender,false,true);
    si := 1;
    REPEAT
     BarChar(s[SI]);
     SI := SI + 1;
    UNTIL (SI > length(S));
        {Finish Symbol}
    PrintBar(Sender,true,true);
  END;
procedure PFIM(S : string; Sender: TCanvas );

var
{SI : integer;}
DarkWidth, LightWIdth : integer;
HighHeight : integer;

PROCEDURE  printbar(Sender : TCanvas; drk : boolean); {Uses global vars so all procs can call}
var Barwidth : integer;
BEGIN

  with  Sender do
  BEGIN
  if drk then Pen.Color := FBarColor else  Pen.Color := Self.color;
  if drk then  Brush.Color := FBarColor else Brush.Color := Self.color;
  if drk then Barwidth := DarkWidth else BarWidth := LightWidth;
{  if Highbar then}
  Rectangle(StartPOint + StartX,0+ StartY,StartPOint + BarWidth + StartX,HighHeight + StartY);
  StartPoint := StartPOint + BarWidth;
  END
END;



PROCEDURE barchar(ch : char);
var
    i : integer;

     PROCEDURE EnCode(ch : char);
     BEGIN
       Bars := blank;
       case ch of
       'A' : BEGIN Bars[1] := true; Bars[2] := true;
                   Bars[5] := true; Bars[8] := true;
                   Bars[9] := true;  END;
       'B' : BEGIN Bars[1] := true; Bars[3] := true;
                   Bars[4] := true; Bars[6] := true;
                   Bars[7] := true; Bars[9] := true; END;
       'C' : BEGIN Bars[1] := true; Bars[2] := true;
                   Bars[4] := true; Bars[6] := true;
                   Bars[8] := true; Bars[9] := true; END;
     END;

END;

BEGIN
  EnCode(ch); {returned in Bars}
  for i := 1 to 9  do
  BEGIN
  printbar(Sender,Bars[i]);
  printbar(Sender,FALSE);

  END;
END;


BEGIN{PFIM}
  if s = ''  then exit;
   if not (s[1] in ['A'..'C','a'..'c']) then exit;
    LightWidth := (UsePixelsPerInchX + 16) Div 32; {BAR = 1/32"}
    DarkWidth := LightWidth;{Bars}
    HighHeight := (UsePixelsPerInchY * 5 + 4) div 8;{.625"}
    StartPoint := 0;
    if Sender <> Self.canvas then
    if Sender = Self.canvas then
    BEGIN
    self.Width := (UsePixelsPerInchX ) DIV 2 + DarkWidth + 2;
    Self.Height := HighHeight;
    END;
    BarChar(s[1]);
  END;




procedure PEAN(S : string; Sender: TCanvas);
Type NumberSet = (A,B,C);
var i : integer;
     NumSets : array[1..13] of NumberSet;
     SI : integer;
     ThisHeight : integer;
    CheckDig, Mult, TotalWide : integer;
    Ean13 : boolean; {else ean8}
     StopPt : integer;
PROCEDURE  printbar(Sender : TCanvas; drk, ExtraHigh : boolean); {Uses global vars so all procs can call}
var Barwidth : integer;
BEGIN

  with  Sender do
  BEGIN
  if drk then Pen.Color := FBarColor else  Pen.Color := Self.color;
  if drk then  Brush.Color := FBarColor else Brush.Color := Self.color;
  Barwidth := Wide;
  if ExtraHigh then
  Rectangle(StartPOint + StartX,0+ StartY,StartPOint + BarWidth + StartX,ThisHeight + StartY + (5 * wide))
  else
  Rectangle(StartPOint + StartX,0+ StartY,StartPOint + BarWidth + StartX,ThisHeight + StartY);
  StartPoint := StartPOint + BarWidth;

  END
END;






{NOTE i CALL LEFT DIGIT 1 ..WHAT THEY CALL DIGIT 13 IN THEIR SPECS}
PROCEDURE Encode1(Ch : char);
var i : integer;
BEGIN
  FOR I := 8 to 13 do NumSets[i] := C;
  CASE ch of
  '0' : BEGIN  NumSets[2] := A;
          NumSets[3] := A; NumSets[4] := A;
             NumSets[5] := A; NumSets[6] := A; NumSets[7] := A; END;
  '1' : BEGIN  NumSets[2] := A; NumSets[3] := A; NumSets[4] := B;
             NumSets[5] := A; NumSets[6] := B; NumSets[7] := B; END;
  '2' : BEGIN  NumSets[2] := A; NumSets[3] := A; NumSets[4] := B;
             NumSets[5] := B; NumSets[6] := A; NumSets[7] := B; END;
  '3' : BEGIN  NumSets[2] := A; NumSets[3] := A; NumSets[4] := B;
             NumSets[5] := B; NumSets[6] := B; NumSets[7] := A; END;
  '4' : BEGIN  NumSets[2] := A; NumSets[3] := B; NumSets[4] := A;
             NumSets[5] := A; NumSets[6] := B; NumSets[7] := B; END;
  '5' : BEGIN  NumSets[2] := A; NumSets[3] := B; NumSets[4] := B;
             NumSets[5] := A; NumSets[6] := A; NumSets[7] := B; END;
  '6' : BEGIN  NumSets[2] := A; NumSets[3] := B; NumSets[4] := B;
             NumSets[5] := B; NumSets[6] := A; NumSets[7] := A; END;
  '7' : BEGIN  NumSets[2] := A; NumSets[3] := B; NumSets[4] := A;
             NumSets[5] := B; NumSets[6] := A; NumSets[7] := B; END;
  '8' : BEGIN  NumSets[2] := A; NumSets[3] := B; NumSets[4] := A;
             NumSets[5] := B; NumSets[6] := B; NumSets[7] := A; END;
  '9' : BEGIN  NumSets[2] := A; NumSets[3] := B; NumSets[4] := B;
             NumSets[5] := A; NumSets[6] := B; NumSets[7] := A; END;
  END;
END;





PROCEDURE barchar(ch : char; pos : integer);
Var i : integer;

     PROCEDURE EnCode(ch : char;ns : NumberSet);
     BEGIN
       Bars := blank;
       if ns = A then
       case ch of
       '0' : BEGIN Bars[4] := true; Bars[5] := true;  Bars[7] := true; END;
       '1' : BEGIN Bars[3] := true; Bars[4] := true;  Bars[7] := true; END;
       '2' : BEGIN Bars[3] := true; Bars[6] := true;  Bars[7] := true; END;
       '3' : BEGIN Bars[2] := true; Bars[3] := true; Bars[4] := true;
                                   Bars[5] := true;  Bars[7] := true; END;
       '4' : BEGIN Bars[2] := true; Bars[6] := true;  Bars[7] := true; END;
       '5' : BEGIN Bars[2] := true; Bars[3] := true;  Bars[7] := true; END;
       '6' : BEGIN Bars[2] := true; Bars[4] := true;  Bars[5] := true;
                                   Bars[6] := true;  Bars[7] := true;  END;
       '7' : BEGIN Bars[2] := true; Bars[3] := true;  Bars[4] := true;
                                   Bars[6] := true;  Bars[7] := true;  END;
       '8' : BEGIN Bars[2] := true; Bars[3] := true;  Bars[5] := true;
                                   Bars[6] := true;  Bars[7] := true;  END;
       '9' : BEGIN Bars[4] := true; Bars[6] := true;  Bars[7] := true; END;
     END;
     if ns = B then
       case ch of
       '0' : BEGIN Bars[2] := true; Bars[5] := true; Bars[6] := true; Bars[7] := true; END;
       '1' : BEGIN Bars[2] := true; Bars[3] := true; Bars[6] := true; Bars[7] := true; END;
       '2' : BEGIN Bars[3] := true; Bars[4] := true; Bars[6] := true; Bars[7] := true; END;
       '3' : BEGIN Bars[2] := true; Bars[7] := true; END;
       '4' : BEGIN Bars[3] := true; Bars[4] := true; Bars[5] := true; Bars[7] := true; END;
       '5' : BEGIN Bars[2] := true; Bars[3] := true; Bars[4] := true; Bars[7] := true; END;
       '6' : BEGIN Bars[5] := true; Bars[7] := true; END;
       '7' : BEGIN Bars[3] := true; Bars[7] := true; END;
       '8' : BEGIN Bars[4] := true; Bars[7] := true; END;
       '9' : BEGIN Bars[3] := true; Bars[5] := true; Bars[6] := true; Bars[7] := true; END;
       END;
     if ns = C then
       case ch of
       '0' : BEGIN Bars[1] := true; Bars[2] := true; Bars[3] := true; Bars[6] := true; END;
       '1' : BEGIN Bars[1] := true; Bars[2] := true; Bars[5] := true; Bars[6] := true; END;
       '2' : BEGIN Bars[1] := true; Bars[2] := true; Bars[4] := true; Bars[5] := true; END;
       '3' : BEGIN Bars[1] := true; Bars[6] := true; END;
       '4' : BEGIN Bars[1] := true; Bars[3] := true; Bars[4] := true; Bars[5] := true; END;
       '5' : BEGIN Bars[1] := true; Bars[4] := true; Bars[5] := true; Bars[6] := true; END;
       '6' : BEGIN Bars[1] := true; Bars[3] := true; END;
       '7' : BEGIN Bars[1] := true; Bars[5] := true; END;
       '8' : BEGIN Bars[1] := true; Bars[4] := true; END;
       '9' : BEGIN Bars[1] := true; Bars[2] := true; Bars[3] := true; Bars[5] := true; END;
       END;

END;

BEGIN
  Sender.Brush.color := Self.Color;
   Sender.textout(StartPOint + StartX,ThisHeight + StartY {+} - WIde,ch);{- allows for char leadin}
  EnCode(ch,NumSetS[Pos]); {returned in Bars}
  for i := 1 to 7  do
  BEGIN
  printbar(Sender,Bars[i],false);{true = always wide.. no wide/narrow}
  END;
END;




BEGIN{EAN}
  if (length(s) in [12,13])   then ean13 := true
  else
  if (length(s) in [7,8])   then ean13 := false
  else
    BEGIN
    if Sender = Self.canvas then
    with  self, canvas do
  BEGIN
  Pen.Color := FBarColor;
  Rectangle(0,0,width,height);
  END;
   exit;
  END;
    if ean13 then
    BEGIN
    Wide := UseWidth div 113;   {95 + leadin 7 + 11}
    TotalWIde := 113 * Wide;
    END
    else
    BEGIN
    Wide := UseWidth div 81; {67 + leadin 7 + 7}
    TotalWIde := 81 * Wide;
    END;
    if wide = 0 then
      BEGIN
    if Sender = Self.canvas then
    with  self, canvas do
  BEGIN
  Pen.Color := FBarColor;
  Rectangle(0,0,width,height);
  END;
   exit;
  END;
    ThisHeight := UseHeight - 12 * Wide;
    Sender.Font.Name := 'Ariel';
   Sender.Font.Height := Wide * 14;{must be after wide assigned}
   Sender.Font.Style := [fsBold];
    Sender.Pen.color := Self.color;
    Sender.Rectangle(StartX,StartY,TotalWide + StartX,ThisHeight + StartY + (11 * wide));
    Sender.Brush.color := Self.Color;
   if Sender = Self.canvas then
   with  self, canvas do
  BEGIN
  Pen.Color := Self.color;
  Rectangle(0,0,width,height);
  END;
   if Ean13 then
   BEGIN
   Sender.textout(5 * wide + StartX,ThisHeight + StartY ,s[1]);{- allows for char leadin}
   StartX := StartX + 11*Wide;
   END
   ELSE
   StartX := StartX + 7 * Wide;
   StartY := StartY + Wide;

  if  (Length(s) = 12) or (Length(s) = 7) then {checkdigit}
  BEGIN
    if  (Length(s) = 12) then Mult := 1 else Mult := 3;
    CheckDig := 0;
    for i := 1 to length(s) do
    BEGIN
      Checkdig := CheckDig + mult * (Ord(s[i]) - 48);
      if mult = 3 then mult := 1 else mult := 3;
    END;
    CheckDig := (10 - (CheckDig mod 10));
    if CheckDig = 10 then CheckDig := 0;
    s := s + ' ';
    s[Length(s)] := chr(48 + CheckDig);
  END;

   SLength := length(S);
    StartPoint := 0;

    IF ean13 then EnCode1(s[1])
    else
    BEGIN
      FOR I := 1 to 4 do NumSets[i] := A;
      FOR I := 5 to 8 do NumSets[i] := C;
    END;
    {space at start}
{    for LI := 1 to Leadin do PrintBar(Sender,false,false);}
    {Lead In Symbol}
    PrintBar(Sender,true,true);
    PrintBar(Sender,false,true);
    PrintBar(Sender,true,true);
    if ean13 then si := 2 else si := 1;
    IF EAN13 THEN StopPt := 8 else StopPt := 5;
    REPEAT
      BarChar(s[SI],si);
       SI := SI + 1;
     UNTIL (SI >= StopPt);
    {CENTRE gUARD bARS}
    PrintBar(Sender,false,true);
    PrintBar(Sender,true,true);
    PrintBar(Sender,false,true);
    PrintBar(Sender,true,true);
    PrintBar(Sender,false,true);

    IF EAN13 THEN
    BEGIN
     si := 8;
     StopPt := 14
     END
     else
     BEGIN
     si := 5;
     StopPt := 9;
     END;
    REPEAT
      BarChar(s[SI],si);
      SI := SI + 1;
    UNTIL (SI >= StopPt);
        {Finish Symbol}
    PrintBar(Sender,true,true);
    PrintBar(Sender,false,true);
    PrintBar(Sender,true,true);
    {space at END .. done in rect}
{    for LI := 1 to (Leadin - 1) do PrintBar(Sender,false,true);}

  END;


  PROCEDURE PITF14(S : string; Sender: TCanvas);
VAR CheckDig,mult, i   : integer;
  BEGIN
  if (length(s) < 12)   then
    BEGIN
    if Sender = Self.canvas then
    with  self, canvas do
  BEGIN
  Pen.Color := FBarColor;
  Rectangle(0,0,width,height);
  END;
   exit;
  END;
   if  (Length(s) = 12)  then {checkdigit}
  BEGIN
    Mult := 1;
    CheckDig := 0;
    for i := 1 to length(s) do
    BEGIN
      Checkdig := CheckDig + mult * (Ord(s[i]) - 48);
      if mult = 3 then mult := 1 else mult := 3;
    END;
    CheckDig := (10 - (CheckDig mod 10));
    if CheckDig = 10 then CheckDig := 0;
    s := s + ' ';
    s[Length(s)] := chr(48 + CheckDig);
  END;
   if  (Length(s) = 13)  then  s := '0' + s;
    PI2of5(s,Sender);
  END;




procedure PCode128(S : string; Sender: TCanvas; EAN128 : Boolean);
{EAN 128 ADDS EAN FNC1 .. otherwise Code128 standard}
{Type NumberSet = (A,B,C);}
var Drk : boolean;
     CodeChars : array[1..400] of char;
     CCPtr,  {alway 1 greater than last code added}
     SI : integer;
      ThisHeight : integer;



PROCEDURE  printbar(Sender : TCanvas; drk: boolean; NoOfWide : integer); {Uses global vars so all procs can call}
var Barwidth : integer;
BEGIN

  with  Sender do
  BEGIN
  if drk then Pen.Color := FBarColor else  Pen.Color := Self.color;
  if drk then  Brush.Color := FBarColor else Brush.Color := Self.color;
  Barwidth := Wide * NoOfWide;
  Rectangle(StartPOint + StartX,0+ StartY,StartPOint + BarWidth + StartX,ThisHeight + StartY {+ (5 * wide)});
  StartPoint := StartPOint + BarWidth;

  END
END;


PROCEDURE barchar(ch : char);
Var i : integer;
   BarWidths : array[1..6] of integer;

PROCEDURE EnCode(ch : char);
BEGIN
  CASE ord(ch) of
  0 : BEGIN BarWidths[1] := 2; BarWidths[2] := 1; BarWidths[3] := 2;
            BarWidths[4] := 2; BarWidths[5] := 2; BarWidths[6] := 2; END;
  1 : BEGIN BarWidths[1] := 2; BarWidths[2] := 2; BarWidths[3] := 2;
            BarWidths[4] := 1; BarWidths[5] := 2; BarWidths[6] := 2; END;
  2 : BEGIN BarWidths[1] := 2; BarWidths[2] := 2; BarWidths[3] := 2;
            BarWidths[4] := 2; BarWidths[5] := 2; BarWidths[6] := 1; END;
  3 : BEGIN BarWidths[1] := 1; BarWidths[2] := 2; BarWidths[3] := 1;
            BarWidths[4] := 2; BarWidths[5] := 2; BarWidths[6] := 3; END;
  4 : BEGIN BarWidths[1] := 1; BarWidths[2] := 2; BarWidths[3] := 1;
            BarWidths[4] := 3; BarWidths[5] := 2; BarWidths[6] := 2; END;
  5 : BEGIN BarWidths[1] := 1; BarWidths[2] := 3; BarWidths[3] := 1;
            BarWidths[4] := 2; BarWidths[5] := 2; BarWidths[6] := 2; END;
  6 : BEGIN BarWidths[1] := 1; BarWidths[2] := 2; BarWidths[3] := 2;
            BarWidths[4] := 2; BarWidths[5] := 1; BarWidths[6] := 3; END;
  7 : BEGIN BarWidths[1] := 1; BarWidths[2] := 2; BarWidths[3] := 2;
            BarWidths[4] := 3; BarWidths[5] := 1; BarWidths[6] := 2; END;
  8 : BEGIN BarWidths[1] := 1; BarWidths[2] := 3; BarWidths[3] := 2;
            BarWidths[4] := 2; BarWidths[5] := 1; BarWidths[6] := 2; END;
  9 : BEGIN BarWidths[1] := 2; BarWidths[2] := 2; BarWidths[3] := 1;
            BarWidths[4] := 2; BarWidths[5] := 1; BarWidths[6] := 3; END;
  10: BEGIN BarWidths[1] := 2; BarWidths[2] := 2; BarWidths[3] := 1;
            BarWidths[4] := 3; BarWidths[5] := 1; BarWidths[6] := 2; END;
  11: BEGIN BarWidths[1] := 2; BarWidths[2] := 3; BarWidths[3] := 1;
            BarWidths[4] := 2; BarWidths[5] := 1; BarWidths[6] := 2; END;
  12 : BEGIN BarWidths[1] := 1; BarWidths[2] := 1; BarWidths[3] := 2;
            BarWidths[4] := 2; BarWidths[5] := 3; BarWidths[6] := 2; END;
  13: BEGIN BarWidths[1] := 1; BarWidths[2] := 2; BarWidths[3] := 2;
            BarWidths[4] := 1; BarWidths[5] := 3; BarWidths[6] := 2; END;
  14: BEGIN BarWidths[1] := 1; BarWidths[2] := 2; BarWidths[3] := 2;
            BarWidths[4] := 2; BarWidths[5] := 3; BarWidths[6] := 1; END;
  15: BEGIN BarWidths[1] := 1; BarWidths[2] := 1; BarWidths[3] := 3;
            BarWidths[4] := 2; BarWidths[5] := 2; BarWidths[6] := 2; END;
  16: BEGIN BarWidths[1] := 1; BarWidths[2] := 2; BarWidths[3] := 3;
            BarWidths[4] := 1; BarWidths[5] := 2; BarWidths[6] := 2; END;
  17: BEGIN BarWidths[1] := 1; BarWidths[2] := 2; BarWidths[3] := 3;
            BarWidths[4] := 2; BarWidths[5] := 2; BarWidths[6] := 1; END;
  18: BEGIN BarWidths[1] := 2; BarWidths[2] := 2; BarWidths[3] := 3;
            BarWidths[4] := 2; BarWidths[5] := 1; BarWidths[6] := 1; END;
  19: BEGIN BarWidths[1] := 2; BarWidths[2] := 2; BarWidths[3] := 1;
            BarWidths[4] := 1; BarWidths[5] := 3; BarWidths[6] := 2; END;
  20: BEGIN BarWidths[1] := 2; BarWidths[2] := 2; BarWidths[3] := 1;
            BarWidths[4] := 2; BarWidths[5] := 3; BarWidths[6] := 1; END;
  21: BEGIN BarWidths[1] := 2; BarWidths[2] := 1; BarWidths[3] := 3;
            BarWidths[4] := 2; BarWidths[5] := 1; BarWidths[6] := 2; END;
  22: BEGIN BarWidths[1] := 2; BarWidths[2] := 2; BarWidths[3] := 3;
            BarWidths[4] := 1; BarWidths[5] := 1; BarWidths[6] := 2; END;
  23: BEGIN BarWidths[1] := 3; BarWidths[2] := 1; BarWidths[3] := 2;
            BarWidths[4] := 1; BarWidths[5] := 3; BarWidths[6] := 1; END;
  24: BEGIN BarWidths[1] := 3; BarWidths[2] := 1; BarWidths[3] := 1;
            BarWidths[4] := 2; BarWidths[5] := 2; BarWidths[6] := 2; END;
  25: BEGIN BarWidths[1] := 3; BarWidths[2] := 2; BarWidths[3] := 1;
            BarWidths[4] := 1; BarWidths[5] := 2; BarWidths[6] := 2; END;
  26: BEGIN BarWidths[1] := 3; BarWidths[2] := 2; BarWidths[3] := 1;
            BarWidths[4] := 2; BarWidths[5] := 2; BarWidths[6] := 1; END;
  27: BEGIN BarWidths[1] := 3; BarWidths[2] := 1; BarWidths[3] := 2;
            BarWidths[4] := 2; BarWidths[5] := 1; BarWidths[6] := 2; END;
  28: BEGIN BarWidths[1] := 3; BarWidths[2] := 2; BarWidths[3] := 2;
            BarWidths[4] := 1; BarWidths[5] := 1; BarWidths[6] := 2; END;
  29: BEGIN BarWidths[1] := 3; BarWidths[2] := 2; BarWidths[3] := 2;
            BarWidths[4] := 2; BarWidths[5] := 1; BarWidths[6] := 1; END;
  30: BEGIN BarWidths[1] := 2; BarWidths[2] := 1; BarWidths[3] := 2;
            BarWidths[4] := 1; BarWidths[5] := 2; BarWidths[6] := 3; END;
  31: BEGIN BarWidths[1] := 2; BarWidths[2] := 1; BarWidths[3] := 2;
            BarWidths[4] := 3; BarWidths[5] := 2; BarWidths[6] := 1; END;
  32: BEGIN BarWidths[1] := 2; BarWidths[2] := 3; BarWidths[3] := 2;
            BarWidths[4] := 1; BarWidths[5] := 2; BarWidths[6] := 1; END;
  33: BEGIN BarWidths[1] := 1; BarWidths[2] := 1; BarWidths[3] := 1;
            BarWidths[4] := 3; BarWidths[5] := 2; BarWidths[6] := 3; END;
  34: BEGIN BarWidths[1] := 1; BarWidths[2] := 3; BarWidths[3] := 1;
            BarWidths[4] := 1; BarWidths[5] := 2; BarWidths[6] := 3; END;
  35: BEGIN BarWidths[1] := 1; BarWidths[2] := 3; BarWidths[3] := 1;
            BarWidths[4] := 3; BarWidths[5] := 2; BarWidths[6] := 1; END;
  36: BEGIN BarWidths[1] := 1; BarWidths[2] := 1; BarWidths[3] := 2;
            BarWidths[4] := 3; BarWidths[5] := 1; BarWidths[6] := 3; END;
  37: BEGIN BarWidths[1] := 1; BarWidths[2] := 3; BarWidths[3] := 2;
            BarWidths[4] := 1; BarWidths[5] := 1; BarWidths[6] := 3; END;
  38: BEGIN BarWidths[1] := 1; BarWidths[2] := 3; BarWidths[3] := 2;
            BarWidths[4] := 3; BarWidths[5] := 1; BarWidths[6] := 1; END;
  39: BEGIN BarWidths[1] := 2; BarWidths[2] := 1; BarWidths[3] := 1;
            BarWidths[4] := 3; BarWidths[5] := 1; BarWidths[6] := 3; END;
  40: BEGIN BarWidths[1] := 2; BarWidths[2] := 3; BarWidths[3] := 1;
            BarWidths[4] := 1; BarWidths[5] := 1; BarWidths[6] := 3; END;
  41: BEGIN BarWidths[1] := 2; BarWidths[2] := 3; BarWidths[3] := 1;
            BarWidths[4] := 3; BarWidths[5] := 1; BarWidths[6] := 1; END;
  42: BEGIN BarWidths[1] := 1; BarWidths[2] := 1; BarWidths[3] := 2;
            BarWidths[4] := 1; BarWidths[5] := 3; BarWidths[6] := 3; END;
  43: BEGIN BarWidths[1] := 1; BarWidths[2] := 1; BarWidths[3] := 2;
            BarWidths[4] := 3; BarWidths[5] := 3; BarWidths[6] := 1; END;
  44: BEGIN BarWidths[1] := 1; BarWidths[2] := 3; BarWidths[3] := 2;
            BarWidths[4] := 1; BarWidths[5] := 3; BarWidths[6] := 1; END;
  45: BEGIN BarWidths[1] := 1; BarWidths[2] := 1; BarWidths[3] := 3;
            BarWidths[4] := 1; BarWidths[5] := 2; BarWidths[6] := 3; END;
  46: BEGIN BarWidths[1] := 1; BarWidths[2] := 1; BarWidths[3] := 3;
            BarWidths[4] := 3; BarWidths[5] := 2; BarWidths[6] := 1; END;
  47: BEGIN BarWidths[1] := 1; BarWidths[2] := 3; BarWidths[3] := 3;
            BarWidths[4] := 1; BarWidths[5] := 2; BarWidths[6] := 1; END;
  48: BEGIN BarWidths[1] := 3; BarWidths[2] := 1; BarWidths[3] := 3;
            BarWidths[4] := 1; BarWidths[5] := 2; BarWidths[6] := 1; END;
  49: BEGIN BarWidths[1] := 2; BarWidths[2] := 1; BarWidths[3] := 1;
            BarWidths[4] := 3; BarWidths[5] := 3; BarWidths[6] := 1; END;
  50: BEGIN BarWidths[1] := 2; BarWidths[2] := 3; BarWidths[3] := 1;
            BarWidths[4] := 1; BarWidths[5] := 3; BarWidths[6] := 1; END;
  51: BEGIN BarWidths[1] := 2; BarWidths[2] := 1; BarWidths[3] := 3;
            BarWidths[4] := 1; BarWidths[5] := 1; BarWidths[6] := 3; END;
  52: BEGIN BarWidths[1] := 2; BarWidths[2] := 1; BarWidths[3] := 3;
            BarWidths[4] := 3; BarWidths[5] := 1; BarWidths[6] := 1; END;
  53: BEGIN BarWidths[1] := 2; BarWidths[2] := 1; BarWidths[3] := 3;
            BarWidths[4] := 1; BarWidths[5] := 3; BarWidths[6] := 1; END;
  54: BEGIN BarWidths[1] := 3; BarWidths[2] := 1; BarWidths[3] := 1;
            BarWidths[4] := 1; BarWidths[5] := 2; BarWidths[6] := 3; END;
  55: BEGIN BarWidths[1] := 3; BarWidths[2] := 1; BarWidths[3] := 1;
            BarWidths[4] := 3; BarWidths[5] := 2; BarWidths[6] := 1; END;
  56: BEGIN BarWidths[1] := 3; BarWidths[2] := 3; BarWidths[3] := 1;
            BarWidths[4] := 1; BarWidths[5] := 2; BarWidths[6] := 1; END;
  57: BEGIN BarWidths[1] := 3; BarWidths[2] := 1; BarWidths[3] := 2;
            BarWidths[4] := 1; BarWidths[5] := 1; BarWidths[6] := 3; END;
  58: BEGIN BarWidths[1] := 3; BarWidths[2] := 1; BarWidths[3] := 2;
            BarWidths[4] := 3; BarWidths[5] := 1; BarWidths[6] := 1; END;
  59: BEGIN BarWidths[1] := 3; BarWidths[2] := 3; BarWidths[3] := 2;
            BarWidths[4] := 1; BarWidths[5] := 1; BarWidths[6] := 1; END;
  60: BEGIN BarWidths[1] := 3; BarWidths[2] := 1; BarWidths[3] := 4;
            BarWidths[4] := 1; BarWidths[5] := 1; BarWidths[6] := 1; END;
  61: BEGIN BarWidths[1] := 2; BarWidths[2] := 2; BarWidths[3] := 1;
            BarWidths[4] := 4; BarWidths[5] := 1; BarWidths[6] := 1; END;
  62: BEGIN BarWidths[1] := 4; BarWidths[2] := 3; BarWidths[3] := 1;
            BarWidths[4] := 1; BarWidths[5] := 1; BarWidths[6] := 1; END;
  63: BEGIN BarWidths[1] := 1; BarWidths[2] := 1; BarWidths[3] := 1;
            BarWidths[4] := 2; BarWidths[5] := 2; BarWidths[6] := 4; END;
  64: BEGIN BarWidths[1] := 1; BarWidths[2] := 1; BarWidths[3] := 1;
            BarWidths[4] := 4; BarWidths[5] := 2; BarWidths[6] := 2; END;
  65: BEGIN BarWidths[1] := 1; BarWidths[2] := 2; BarWidths[3] := 1;
            BarWidths[4] := 1; BarWidths[5] := 2; BarWidths[6] := 4; END;
  66: BEGIN BarWidths[1] := 1; BarWidths[2] := 2; BarWidths[3] := 1;
            BarWidths[4] := 4; BarWidths[5] := 2; BarWidths[6] := 1; END;
  67: BEGIN BarWidths[1] := 1; BarWidths[2] := 4; BarWidths[3] := 1;
            BarWidths[4] := 1; BarWidths[5] := 2; BarWidths[6] := 2; END;
  68: BEGIN BarWidths[1] := 1; BarWidths[2] := 4; BarWidths[3] := 1;
            BarWidths[4] := 2; BarWidths[5] := 2; BarWidths[6] := 1; END;
  69: BEGIN BarWidths[1] := 1; BarWidths[2] := 1; BarWidths[3] := 2;
            BarWidths[4] := 2; BarWidths[5] := 1; BarWidths[6] := 4; END;
  70: BEGIN BarWidths[1] := 1; BarWidths[2] := 1; BarWidths[3] := 2;
            BarWidths[4] := 4; BarWidths[5] := 1; BarWidths[6] := 2; END;
  71: BEGIN BarWidths[1] := 1; BarWidths[2] := 2; BarWidths[3] := 2;
            BarWidths[4] := 1; BarWidths[5] := 1; BarWidths[6] := 4; END;
  72: BEGIN BarWidths[1] := 1; BarWidths[2] := 2; BarWidths[3] := 2;
            BarWidths[4] := 4; BarWidths[5] := 1; BarWidths[6] := 1; END;
  73: BEGIN BarWidths[1] := 1; BarWidths[2] := 4; BarWidths[3] := 2;
            BarWidths[4] := 1; BarWidths[5] := 1; BarWidths[6] := 2; END;
  74: BEGIN BarWidths[1] := 1; BarWidths[2] := 4; BarWidths[3] := 2;
            BarWidths[4] := 2; BarWidths[5] := 1; BarWidths[6] := 1; END;
  75: BEGIN BarWidths[1] := 2; BarWidths[2] := 4; BarWidths[3] := 1;
            BarWidths[4] := 2; BarWidths[5] := 1; BarWidths[6] := 1; END;
  76: BEGIN BarWidths[1] := 2; BarWidths[2] := 2; BarWidths[3] := 1;
            BarWidths[4] := 1; BarWidths[5] := 1; BarWidths[6] := 4; END;
  77: BEGIN BarWidths[1] := 4; BarWidths[2] := 1; BarWidths[3] := 3;
            BarWidths[4] := 1; BarWidths[5] := 1; BarWidths[6] := 1; END;
  78: BEGIN BarWidths[1] := 2; BarWidths[2] := 4; BarWidths[3] := 1;
            BarWidths[4] := 1; BarWidths[5] := 1; BarWidths[6] := 2; END;
  79: BEGIN BarWidths[1] := 1; BarWidths[2] := 3; BarWidths[3] := 4;
            BarWidths[4] := 1; BarWidths[5] := 1; BarWidths[6] := 1; END;
  80: BEGIN BarWidths[1] := 1; BarWidths[2] := 1; BarWidths[3] := 1;
            BarWidths[4] := 2; BarWidths[5] := 4; BarWidths[6] := 2; END;
  81: BEGIN BarWidths[1] := 1; BarWidths[2] := 2; BarWidths[3] := 1;
            BarWidths[4] := 1; BarWidths[5] := 4; BarWidths[6] := 2; END;
  82: BEGIN BarWidths[1] := 1; BarWidths[2] := 2; BarWidths[3] := 1;
            BarWidths[4] := 2; BarWidths[5] := 4; BarWidths[6] := 1; END;
  83: BEGIN BarWidths[1] := 1; BarWidths[2] := 1; BarWidths[3] := 4;
            BarWidths[4] := 2; BarWidths[5] := 1; BarWidths[6] := 2; END;
  84: BEGIN BarWidths[1] := 1; BarWidths[2] := 2; BarWidths[3] := 4;
            BarWidths[4] := 1; BarWidths[5] := 1; BarWidths[6] := 2; END;
  85: BEGIN BarWidths[1] := 1; BarWidths[2] := 2; BarWidths[3] := 4;
            BarWidths[4] := 2; BarWidths[5] := 1; BarWidths[6] := 1; END;
  86: BEGIN BarWidths[1] := 4; BarWidths[2] := 1; BarWidths[3] := 1;
            BarWidths[4] := 2; BarWidths[5] := 1; BarWidths[6] := 2; END;
  87: BEGIN BarWidths[1] := 4; BarWidths[2] := 2; BarWidths[3] := 1;
            BarWidths[4] := 1; BarWidths[5] := 1; BarWidths[6] := 2; END;
  88: BEGIN BarWidths[1] := 4; BarWidths[2] := 2; BarWidths[3] := 1;
            BarWidths[4] := 2; BarWidths[5] := 1; BarWidths[6] := 1; END;
  89: BEGIN BarWidths[1] := 2; BarWidths[2] := 1; BarWidths[3] := 2;
            BarWidths[4] := 1; BarWidths[5] := 4; BarWidths[6] := 1; END;
  90: BEGIN BarWidths[1] := 2; BarWidths[2] := 1; BarWidths[3] := 4;
            BarWidths[4] := 1; BarWidths[5] := 2; BarWidths[6] := 1; END;
  91: BEGIN BarWidths[1] := 4; BarWidths[2] := 1; BarWidths[3] := 2;
            BarWidths[4] := 1; BarWidths[5] := 2; BarWidths[6] := 1; END;
  92: BEGIN BarWidths[1] := 1; BarWidths[2] := 1; BarWidths[3] := 1;
            BarWidths[4] := 1; BarWidths[5] := 4; BarWidths[6] := 3; END;
  93: BEGIN BarWidths[1] := 1; BarWidths[2] := 1; BarWidths[3] := 1;
            BarWidths[4] := 3; BarWidths[5] := 4; BarWidths[6] := 1; END;
  94: BEGIN BarWidths[1] := 1; BarWidths[2] := 3; BarWidths[3] := 1;
            BarWidths[4] := 1; BarWidths[5] := 4; BarWidths[6] := 1; END;
  95: BEGIN BarWidths[1] := 1; BarWidths[2] := 1; BarWidths[3] := 4;
            BarWidths[4] := 1; BarWidths[5] := 1; BarWidths[6] := 3; END;
  96: BEGIN BarWidths[1] := 1; BarWidths[2] := 1; BarWidths[3] := 4;
            BarWidths[4] := 3; BarWidths[5] := 1; BarWidths[6] := 1; END;
  97: BEGIN BarWidths[1] := 4; BarWidths[2] := 1; BarWidths[3] := 1;
            BarWidths[4] := 1; BarWidths[5] := 1; BarWidths[6] := 3; END;
  98: BEGIN BarWidths[1] := 4; BarWidths[2] := 1; BarWidths[3] := 1;
            BarWidths[4] := 3; BarWidths[5] := 1; BarWidths[6] := 1; END;
  99: BEGIN BarWidths[1] := 1; BarWidths[2] := 1; BarWidths[3] := 3;
            BarWidths[4] := 1; BarWidths[5] := 4; BarWidths[6] := 1; END;
 100: BEGIN BarWidths[1] := 1; BarWidths[2] := 1; BarWidths[3] := 4;
            BarWidths[4] := 1; BarWidths[5] := 3; BarWidths[6] := 1; END;
 101: BEGIN BarWidths[1] := 3; BarWidths[2] := 1; BarWidths[3] := 1;
            BarWidths[4] := 1; BarWidths[5] := 4; BarWidths[6] := 1; END;
 102: BEGIN BarWidths[1] := 4; BarWidths[2] := 1; BarWidths[3] := 1;
            BarWidths[4] := 1; BarWidths[5] := 3; BarWidths[6] := 1; END;
 103: BEGIN BarWidths[1] := 2; BarWidths[2] := 1; BarWidths[3] := 1;
            BarWidths[4] := 4; BarWidths[5] := 1; BarWidths[6] := 2; END;
 104: BEGIN BarWidths[1] := 2; BarWidths[2] := 1; BarWidths[3] := 1;
            BarWidths[4] := 2; BarWidths[5] := 1; BarWidths[6] := 4; END;
 105: BEGIN BarWidths[1] := 2; BarWidths[2] := 1; BarWidths[3] := 1;
            BarWidths[4] := 2; BarWidths[5] := 3; BarWidths[6] := 2; END;
  END; {CASE}
END;

BEGIN
  Sender.Brush.color := Self.Color;
  EnCode(ch); {returned in BarsWidths}
  drk := true;
  for i := 1 to 6  do
  BEGIN
  printbar(Sender,drk,BarWidths[i]);
  drk := not Drk;
  END;
END;


PROCEDURE AddCC(ch : char);
BEGIN
   CodeChars[CCPtr] := ch;
   CCPtr := CCPtr + 1;
END;

PROCEDURE AddNCode(ch : char);
BEGIN
  if ord(ch) < 32 then AddCC(chr(ord(ch) + 64))
  else
  AddCC(chr(ord(ch) - 32))
END;




PROCEDURE TranslateCode;
TYPE CodeTypeS = (A,B,C,None);
VAR SPtr, SLen, NextC : integer;
    CodeType : CodeTypes;

FUNCTION  TrySetC(TempPtr : integer) : Boolean;
var i : integer;
BEGIN
   result := false;
   if TempPtr > SLen - 3 then exit;
{test for 4 consec digits}
    for i := TempPtr to  (TempPtr + 3) DO
    if not (s[i] in ['0'..'9']) then exit;
    result := true;
 END;

 PROCEDURE DoSetC;
 var ch : char;
 BEGIN
    if CodeType <> C then AddCC(#99);
    Codetype := C;
    while (SPtr <= SLen - 1)
            and (s[SPtr] in ['0'..'9'])
            and (s[SPtr + 1] in ['0'..'9']) do
    BEGIN
       ch :=   chr(10 * (ord(s[SPtr]) - 48)  + ord(s[SPtr + 1]) - 48);
       AddCC(ch);
       SPtr := SPtr + 2;
    END;

 END;

 FUNCTION TryNextCode(startPtr : integer) : CodeTypeS;
 var Found : boolean;
    i : integer;
 BEGIN
   result  := B;
   if StartPtr > SLen then exit;
   i := StartPtr - 1;
   found := false;
   REPEAT
     i := i + 1;
     if ord(s[i]) <= 31 then
     BEGIN
       Result := A;
       Found := true;
     END;
     if ord(s[i]) >= 96 then
     BEGIN
     Result := B;
     Found := true;
     END;
   UNTIL (i = SLen) or found;

 END;


 PROCEDURE FindNextC;
 var i : integer;
 BEGIN
   {ie not before END of string}
   i := SPtr -1;
   REPEAT
     i := i + 1;
   UNTIL (i >= SLen) or TrySetC(i);
   NextC := i;
   if NextC = SLen then NextC := SLen + 1{(i = SLen + 1) means  not before END of string}
 END;


 PROCEDURE DoSetA;
Var NextB : integer;
    MustStop : boolean;

 PROCEDURE TryNextB(startPtr : integer;var ItsPtr : integer);
 BEGIN
      ItsPtr := StartPtr - 1;
   REPEAT
     ItsPtr := ItsPtr + 1;
   UNTIL (ItsPtr > SLen) or (ord(s[ItsPtr]) >= 96);
 END;



 BEGIN
    if CodeType <> A then AddCC(#101);
    Codetype := A;
    MustStop := false;
    TryNextB(SPtr,NextB);
    REPEAT
    while (SPtr <= NextB - 1) and (SPtr <= NextC - 1) and (SPtr <= SLen) do
    BEGIN
       AddNCode(s[SPtr]);
       SPtr := SPtr + 1;
    END;
    if SPtr >= NextC then MustStop := true {nextC <= SLen}
    else
    if SPtr > SLen then MustStop := true {nextC <= SLen}
    else
    BEGIN {CAN ASSUME SPtr = NEXT A}
       if TryNextCode(SPtr + 1) = B then MustStop := true
      else
      AddCC(chr(98));{ONE CODE B ONLY.. USE SHIFT}
    END;
    UNTIL MustStop;
 END;



 PROCEDURE DoSetB;
Var NextA : integer;
        MustStop : boolean;

 PROCEDURE TryNextA(startPtr : integer;var ItsPtr : integer);
 BEGIN
      ItsPtr := StartPtr - 1;
   REPEAT
     ItsPtr := ItsPtr + 1;
   UNTIL (ItsPtr > SLen) or (ord(s[ItsPtr]) >= 96);
 END;


 BEGIN
    if CodeType <> B then AddCC(#100);
    Codetype := B;
    MustStop := false;
    TryNextA(SPtr,NextA);
    REPEAT
    while (SPtr <= NextA - 1) and (SPtr <= NextC - 1) and (SPtr <= SLen) do
    BEGIN
       AddNCode(s[SPtr]);
       SPtr := SPtr + 1;
    END;
    if SPtr >= NextC then MustStop := true {nextC <= SLen ie if END of string , this is true}
    else
    if SPtr > SLen then MustStop := true
    else
    BEGIN {CAN ASSUME SPtr = NEXT A}
       if TryNextCode(SPtr + 1) = A then MustStop := true
      else
      BEGIN
       TryNextA(SPtr + 1,NextA);{Move Next A on further}
       AddCC(chr(98));{ONE CODE A ONLY.. USE SHIFT}
      END;
    END;
    UNTIL MustStop;
 END;



 BEGIN {TranslateCode}
  SPtr := 1; CCPtr := 1;
  SLen := length(s);
  FindNextC;
  if NextC = 1 then BEGIN CodeType := C; AddCC(chr(105)); END {startC}
  else
  if TryNextCode(1) = A then BEGIN Codetype := A; AddCC(chr(103)); END
  else BEGIN CodeType := B; AddCC(chr(104)); END;
  if EAN128 then AddCC(#102);
  REPEAT
    if  TrySetC(SPtr)  then DoSetC;
    FindNextC;
    if (SPtr <= (NextC - 1)) then
    BEGIN
      if TryNextCode(SPtr) = A then DoSetA  else DoSetB;
    END;
  UNTIL SPtr > SLen;
END;


PROCEDURE AddCheckSum;
var i, ExtraChar : integer;
    ChkSum : longint;{can hve long barcodes}
BEGIN
{  Test differnt checksum .. replace ean128 with true}
  ExtraChar := 1;
  ChkSum := Ord(CodeChars[1]);
  For i := (1 )  to   (CCPtr -1 - ExtraChar) do
    ChkSum := ChkSum + ord(CodeChars[i + ExtraChar]) * i;
  ChkSum := ChkSum mod 103;
  AddCC(chr(ChkSum));
END;

BEGIN{PCode128}
    Wide := 1;
    ThisHeight := Self.Height;
    TranslateCode;
    AddCheckSum;
     Wide :=  Self.WIdth div (11 * (CCPtr - 1) + 13   { +2 * Leadin });
     if Wide < 1 then exit;
     Leadin := Self.width - Wide * (11 * (CCPtr- 1) + 13);
   Sender.Font.Assign(Self.font);
   Sender.Font.Height := Wide * 4;{must be after wide is allocated}
   Sender.Font.Style := [fsBold];
    Sender.Pen.color := Self.color;
    Sender.Rectangle(StartX,StartY,
            Wide * 11 * (CCPtr -1 ) + 13 * wide + 2 * Leadin * Wide + StartX,
            ThisHeight + StartY {+ (11 * wide)});
    Sender.Brush.color := Self.Color;
    StartPoint := 0;

    {space at start}
    PrintBar(Sender,false,Leadin);
    SI := 1;
    REPEAT
      BarChar(CodeChars[SI]);
      SI := SI + 1;
    UNTIL (SI >= CCPtr);
        {Stop Symbol}
    PrintBar(Sender,true,2);
    PrintBar(Sender,False,3);
    PrintBar(Sender,true,3);
    PrintBar(Sender,False,1);
    PrintBar(Sender,true,1);
    PrintBar(Sender,False,1);
    PrintBar(Sender,true,2);
    {space at END .. done in rect}
    PrintBar(Sender,false,Leadin);
  END;


BEGIN{DrawBarCode}
    if UsePixelsPerInchX < 5 then
    UsePixelsPerInchX := Screen.PixelsPerInch;
  IF PrintWhere is TForm then
  BEGIN
    if UsePixelsPerInchX = 0 then UsePixelsPerInchX := TForm(PrintWhere).PixelsPerInch;
    WhichCanvas := TForm(PrintWhere).Canvas;
  END
  else
  IF PrintWhere is TCanvas then
  BEGIN
   try {can't assume parentreport.qrprinter ok it would seem}
    if not (csdesigning in ComponentState) then
    if  WhichCanvas <> Self.Canvas then
     if PrintWhere = ParentReport.QRPrinter.Canvas then
     BEGIN
       UsePixelsPerInchX :=
           GetDeviceCaps(ParentReport.QRPrinter.Canvas.Handle,LOGPIXELSX);
       UsePixelsPerInchY :=
            GetDeviceCaps(ParentReport.QRPrinter.Canvas.Handle, LOGPIXELSY);
     END;
    except
     END;
    WhichCanvas := TCanvas(PrintWhere);
  END
  else
  IF PrintWhere is TPaintBox then
  BEGIN
    WhichCanvas := TPaintBox(PrintWhere).Canvas;
  END
  else
  BEGIN
    WhichCanvas := Self.Canvas;
  END;
 {POSITIONING}
  if whichCanvas = Self.canvas then
  BEGIN
    StartX := 0;
    StartY := 0;
  END
  ELSE
  BEGIN
  StartY := Self.top;
  StartX := Self.Left;
  END;
  UseHeight := Self.Height;
  UseWidth := Self.Width;
  SavePenColor := WHichCanvas.pen.color;
  SaveBrushColor := WHichCanvas.Brush.color;
  SaveFont.Assign(WHichCanvas.Font);
  If Self.text<>'' then begin
    case Self.FBarcodeType of
    Code39: PCode39(Self.Text,WhichCanvas);
    Interleaved2of5 : PI2of5(self.text,WhichCanvas);
    ITF14 :  PITF14(self.text,WhichCanvas);
    PostNetZip      : PPostNEt(Self.text,WhichCanvas,5);
    PostNetZipPlus4    : PPostNEt(Self.text,WhichCanvas,9);
    PostNet11       : PPostNEt(Self.text,WhichCanvas,11);
    Code128 : PCode128(Self.text,WhichCanvas,false);
    EAN128 : PCode128(Self.text,WhichCanvas,TRUE);
    EAN, EAN8, EAN13   : PEAN(Self.text,WhichCanvas);
    PostNet      : if length(Self.text) < 6 then PPostNEt(Self.text,WhichCanvas,5)
                   else
                   if length(Self.text) < 10 then PPostNEt(Self.text,WhichCanvas,9)
                   else PPostNEt(Self.text,WhichCanvas,11);
    FIMA : PFIM('A',WhichCanvas);
    FIMB : PFIM('B',WhichCanvas);
    FIMC : PFIM('C',WhichCanvas);
    END;
  end;
  WHichCanvas.Font.Assign(SaveFont);
  WHichCanvas.pen.color := SavePenColor ;
  WHichCanvas.Brush.color := SaveBrushColor;
END;


procedure TQRBarcode.Print(OfsX, OfsY : integer);
var
  TempLeft,
  TempTop,
  TempHeight,
  TempWidth : Longint;
BEGIN
{May need to test for Default Fields here}
  if FDataOK then
  BEGIN
     text := FField.AsString;
     If Text<>'' then begin
       if (FBarCodeType in [EAN13,ITF14] ) then
       while length(text)<12 do Text := '0' + Text;
       if (FBarCodeType = EAN8 ) then
           while length(text) < 7 do Text := '0' + Text;
     end;
  END;
  with ParentReport.QRPrinter do
  BEGIN
    TempLeft := Left;
    TempTop := Top;
    TempHeight := Height;
    TempWidth := Width;
    Left := XPos(OfsX + Size.Left);
    Top := YPos(OfsY + Size.Top);
    Width := XPos(OfsX + Size.Left + Size.Width) - XPos(OfsX + Size.Left);
    Height := YPos(OfsY + Size.Top + Size.Height) - YPos(OfsY + Size.Top);
    DrawBarCode(Canvas,0);
    Left := TempLeft;
    Top := TempTop;
    Height := TempHeight;
    Width := TempWidth;
  END;
END;





procedure TQRBarcode.SetText(const Value: TCaption);
var TempPChar : PChar;
BEGIN
   TempPChar := StrAlloc(280);
   StrPlCopy(TempPchar,Value,280);
    SetTextBuf(TempPCHAR);
   Invalidate;
END;

PROCEDURE TQRBarcode.SetBarCodeType(Value : TBarCodeType);
BEGIN
  FBarCodeType := Value;
  Invalidate;
END;


procedure TQRBarcode.SetHeightInInches(Value : Double);{only Ean}
var Calc : integer;
BEGIN
  Calc := GetDeviceCaps(Canvas.Handle, LOGPIXELSY);
  Self.height := Round(Value * Calc);
  Invalidate;
END;

procedure TQRBarcode.SetWidthInInches(Value : Double);{only Ean}
BEGIN
  Self.Width := Round(Value * GetDeviceCaps(Canvas.Handle, LOGPIXELSX));
  Invalidate;
END;


FUNCTION TQRBarcode.GetHeightInInches : Double;{only Ean}
var Calc : integer; LCalc : longint;
BEGIN
   Calc := GetDeviceCaps(Canvas.Handle, LOGPIXELSY);
  LCalc := round((Self.height / Calc) * 1000);
  result := LCalc / 1000;

END;

FUNCTION TQRBarcode.GetWidthInInches : Double;{only Ean}
var LCalc : double;
BEGIN
  LCalc := (Self.Width /GetDeviceCaps(Canvas.Handle, LOGPIXELSX));
  FWidthInInches := (round(LCalc * 1000) / 1000); {redundant}
  Result := FWidthInInches;
END;

procedure TQRBarcode.SetTopInInches(Value : Double);{only Ean}
var Calc : integer;
BEGIN
  Calc := GetDeviceCaps(Canvas.Handle, LOGPIXELSY);
  Self.top := Round(Value * Calc);
END;

procedure TQRBarcode.SetLeftInInches(Value : Double);{only Ean}
BEGIN
  Self.Left := Round(Value * GetDeviceCaps(Canvas.Handle, LOGPIXELSX));
  Invalidate;
END;


FUNCTION TQRBarcode.GetTopInInches : Double;{only Ean}
var Calc : integer; LCalc : longint;
BEGIN
   Calc := GetDeviceCaps(Self.Canvas.Handle, LOGPIXELSY);
  LCalc := round((Self.top / Calc) * 1000);
  result := LCalc / 1000;
  Invalidate;
END;

FUNCTION TQRBarcode.GetLeftInInches : Double;{only Ean}
var LCalc : double;
BEGIN
  LCalc := (Self.Left /GetDeviceCaps(Self.Canvas.Handle, LOGPIXELSX));
  FLeftInInches := (round(LCalc * 1000) / 1000); {redundant}
  Result := FLeftInInches;
  Invalidate;

END;




PROCEDURE TQRBarcode.SetBarColor(Value : TColor);
BEGIN
  FBarColor := value;
  Invalidate;
END;




PROCEDURE TQRBarcode.Paint;
BEGIN
  DrawBarCode(Canvas,0);
END;


constructor TQRBarcode.Create(AOwner: TComponent);
var i : integer;
BEGIN
  inherited Create(AOwner);
  for i := 1 to 9 do  Blank[i] := false;
  FDesignable := true;
      FBarCodeType := Code39;
    ClearZone := true;
    FBarColor := clBLack;
    Color := clWhite;
    text := '12';
    SaveFont := TFont.Create;
  FDataField := '';
  if Width < 120 then width := 120;
END;

Destructor TQRBarcode.Destroy;
BEGIN
  Inherited Destroy;
END;



PROCEDURE TQRBarcode.SetDataField(const Value : string);
BEGIN
  FDataField := Value;
 if Assigned(FDataSet) then
   FField := FDataSet.FindField(FDataField)
 else FField := nil;
 if FField = nil then
   FDataOK := false
 else FDataOK := true;

END;

PROCEDURE TQRBarcode.Loaded;
BEGIN
 Inherited Loaded;
 if Assigned(FDataSet) then
   FField := FDataSet.FindField(FDataField)
 else FField := nil;
 if FField = nil then
   FDataOK := false
 else FDataOK := true;
END;

PROCEDURE  TQRBarcode.Prepare;
BEGIN
inherited Prepare;
{ Can these values be assigned at runtime?}
 if Assigned(FDataSet) then
   FField := FDataSet.FindField(FDataField)
 else FField := nil;
 if FField = nil then
   FDataOK := false
 else FDataOK := true;
END;

END.
