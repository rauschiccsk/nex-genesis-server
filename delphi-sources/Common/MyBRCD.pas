{$B-}
{
http://www.rozhodni.sk/index.php?&MId=1&Lev1=1&Ind1=54&P=index,sl,
}
unit MyBRCD;

interface

uses
  WinTypes, WinProcs, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  ExtCtrls, printers, db, dbTables, Brcd, Barcd5, DBCtrls;

type

  TMyBarCode = class(TPaintBox)
  private
   {for Barcoding}
    FDesignable   : Boolean;
    FBarCodeType  : TBarCodeType2;

    FCheckSum:boolean;
    FShowText:TBarcodeOption;
    FShowTextPosition: TShowTextPosition;
    FShowTextFont: TFont;
    FAngle  : double;

    SavePenColor  : TColor;
    SaveBrushColor: TColor;
    SaveFont      : TFont;
    FBarColor     : TColor;
    FClearZone    : Boolean;
    oBarCode      : TAsBarcode; // objekt ktory sluzi na samotne vykreslovanie ciaroveho kodu
    {DATA AWARE}
    FDataLink : TFieldDataLink;

    PROCEDURE SetText(const Value: TCaption);
    PROCEDURE SetBarCodeType(Value : TBarCodeType2);
    PROCEDURE SetbarColor   (Value : TColor);
    {for resizing}
    PROCEDURE NewCoords(Sender: TObject; X,Y: Integer);
    PROCEDURE MouseDown(Button: TMouseButton; Shift: TShiftState;X, Y: Integer); override;
    PROCEDURE MouseMove(Shift: TShiftState; X, Y: Integer); override;
    PROCEDURE MouseUp(Button: TMouseButton; Shift: TShiftState;X, Y: Integer); override;
    PROCEDURE Resize;override;
    {DATA AWARE}
    FUNCTION GetDataField : string;
    FUNCTION GetDataSource : TDataSource;
    PROCEDURE SetDataField(Const Value: string);
    PROCEDURE SetDataSource(Value: TDataSource);
    PROCEDURE DataChange(Sender : TObject);
  protected
    StartX1, StartY1, StartX2, StartY2 : integer;
    NewX1, NewY1, NewX2, NewY2 : integer;
    LastX1, LastY1, LastX2, LastY2 : integer;
    StartMX, StartMY : integer; {for start move pos}
    MoveTop, MoveLeft, MoveRight, MoveBottom, MoveAll : Boolean;
    PROCEDURE Paint; override;
    FUNCTION GetHeight : integer;
    FUNCTION GetWidth  : integer;

  public
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
    PROCEDURE DrawBarCode(PrintWhere : TObject;UsePixelsPerInchX : integer);
    PROCEDURE SetHeight (Value : integer);
    PROCEDURE SetWidth  (Value : integer);

    PROCEDURE SetAngle(const Value: Double);
    PROCEDURE SetShowText(const Value: TBarcodeOption);
    PROCEDURE SetShowTextPosition(const Value: TShowTextPosition);
    PROCEDURE SetShowTextFont(const Value: TFont);
    PROCEDURE SetCheckSum(const Value: Boolean);
   { Public declarations }
  published
    Property Text write SetText;
    Property BarCodeType   : TBarCodeType2 Read FBarCodeType write SetBarCodeType Default bcCodeEAN13;
    Property ClearZone     : Boolean read FClearZone write FClearZone default true;
    Property Height        : integer Read GetHeight write SetHeight;
    Property Width         : integer Read GetWidth  write SetWidth;
    Property BarColor      : TColor read FBarColor write SetBarcolor Default clBLack;
    // farba ciaroveho kodu

    property Checksum:boolean read FCheckSum write SetCheckSum default FALSE;
    property Angle  :double read FAngle write SetAngle;
    property ShowTextPosition: TShowTextPosition read FShowTextPosition write SetShowTextPosition default stpTopLeft;
    // poziacia zobrazovania textu ciaroveho kodu
    property ShowText:TBarcodeOption read FShowText write SetShowText default bcoNone;
    // typ zobrazovania textu ciaroveho kodu
    property ShowTextFont: TFont read FShowTextFont write SetShowTextFont;
    // Font zobrazovaneho textu ciaroveho kodu
  {DATA AWARE}
    property DataField:string read GetDataField write SetDataField;
    property DataSource:TDataSource read GetDataSource write SetDataSource;
  end;

// PROCEDURE Register;

var TempPaintBox : TPaintBox;

implementation
{
PROCEDURE Register;
begin
  RegisterComponents('samples', [TMyBarCode]);
end;
}
// ********************************* TMyBarCode **********************************
PROCEDURE TMyBarCode.Resize;
begin
  inherited;
  If oBarCode<>NIL then begin
    oBarCode.Height:=TControl(Self).Height;
    oBarCode.Width:=TControl(self).Width;
    TControl(Self).Width:=oBarCode.Width;
  end;
  invalidate;
end;

PROCEDURE TMyBarCode.DrawBarCode(PrintWhere : TObject;UsePixelsPerInchX : integer);
begin{DrawBarCode}
  oBarCode.DrawBarcode(TPaintBox(Self).Canvas);
end;

PROCEDURE TMyBarCode.SetText(const Value: TCaption);
var TempPChar : PChar;
begin
  TempPChar := StrAlloc(280);
  StrPlCopy(TempPchar,Value,280);
  SetTextBuf(TempPCHAR);
  oBarCode.Text:=Value;
  if (self.parent <> nil) and Self.visible then DrawBarCode(Self,0);
end;

PROCEDURE TMyBarCode.SetAngle(const Value: Double);
begin
   if Value <> FAngle then
   begin
      FAngle := Value;
      oBarCode.Angle:=Value;
      if (self.parent <> nil) and Self.visible then DrawBarCode(Self,0);
   end;
end;

PROCEDURE TMyBarCode.SetShowText(const Value: TBarcodeOption);
begin
   if Value <> FShowText then
   begin
      FShowText := Value;
      oBarCode.ShowText:=Value;
      if (self.parent <> nil) and Self.visible then DrawBarCode(Self,0);
   end;
end;

PROCEDURE TMyBarCode.SetShowTextPosition(const Value: TShowTextPosition);
begin
   if Value <> FShowTextPosition then
   begin
     FShowTextPosition := Value;
     oBarCode.ShowTextPosition:=Value;
     if (self.parent <> nil) and Self.visible then DrawBarCode(Self,0);
   end;
end;

PROCEDURE TMyBarCode.SetCheckSum(const Value: Boolean);
begin
   if Value <> FCheckSum then
   begin
      FCheckSum := Value;
      oBarCode.Checksum:=Value;
      if (self.parent <> nil) and Self.visible then DrawBarCode(Self,0);
   end;
end;

PROCEDURE TMyBarCode.SetShowTextFont(const Value: TFont);
begin
  FShowTextFont.Assign(Value);
  oBarCode.ShowTextFont.Assign(Value);
  if (self.parent <> nil) and Self.visible then DrawBarCode(Self,0);
end;

PROCEDURE TMyBarCode.SetBarCodeType(Value : TBarCodeType2);
begin
  FBarCodeType := Value;
  oBarCode.Typ:=FBarCodeType;
  if Self.visible then DrawBarCode(Self,0);
end;

PROCEDURE TMyBarCode.SetHeight(Value : integer);
var Calc : integer;
begin
  oBarCode.Height:=Value;
  TControl(Self).Height:=oBarCode.Height;
end;

PROCEDURE TMyBarCode.SetWidth(Value : integer);
begin
  oBarCode.Width:=Value;
  TControl(Self).Width:=oBarCode.Width;
end;


FUNCTION TMyBarCode.GetHeight : integer;
begin
  Result := oBarCode.Height;
end;

FUNCTION TMyBarCode.GetWidth : integer;
begin
  Result := oBarCode.Width
end;

PROCEDURE TMyBarCode.SetBarColor(Value : TColor);
begin
  FBarColor := value;
  oBarCode.ColorBar:=FBarColor;
  if Self.visible then DrawBarCode(Self,0);
end;

PROCEDURE TMyBarCode.Paint;
begin
  oBarCode.Color:=Color;
  DrawBarCode(Self,0);
end;

PROCEDURE TMyBarCode.MouseDown(Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
begin
  If Assigned (OnMouseDown) then inherited MouseDown(Button,  Shift, X, Y)
  else begin
    inherited MouseDown(Button,  Shift, X, Y);
    if not FDesignable then exit;
    MoveLeft := false; MoveTop := false; MoveBottom := false; MoveRight := false;
    if not FDesignable then exit;
    if (x  < 3) then MoveLEft := true;
    if (y  < 3) then MoveTop := true;
    if ( TControl(self).height - 4 - y) < 3 then MoveBottom := true;
    if  (TControl(self).Width - 4 - x) < 3 then MoveRight := true;     {East border}
    StartMX := X;
    StartMY := Y;
    with TControl(self) do
    begin
      StartX1 := Left;
      StartY1 := Top;
      StartY2 := top + Height;
      StartX2 := Left + Width;
      NewX1 := StartX1;
      NewX2 := StartX2;
      NewY1 := StartY1;
      NewY2 := StartY2;
      TempPaintBox := TPaintBox.Create(Self.PARENT);
      TempPaintBox.parent := self.parent;
      TempPaintBox.canvas.Brush.Style := bsClear;
      TempPaintBox.HEIGHT := TControl(parent).height- 1;
      TempPaintBox.Width := TControl(parent).Width - 1;
    end;
    if MoveLeft or MoveTop or MoveBottom or MoveRight then MoveAll := false else MoveAll := true;
  end;
end;

PROCEDURE TMyBarCode.MouseUp(Button: TMouseButton;Shift: TShiftState; X, Y: Integer);
begin
  If Assigned (OnMouseUp) then Inherited MouseUp(Button, Shift, X, Y)
  else begin
    if  FDesignable then begin
      with TempPaintBox do
      if MoveLeft or MoveTop or MoveBottom or MoveRight or MoveAll then{AMOUSEBUTTON PUSHED}begin
        TempPaintBox.Canvas.Pen.Style := psClear;
        TempPaintBox.Canvas.Rectangle(LastX1,LastY1,LastX2,LastY2);
        if (NewX2 - NewX1 > 8) and ( NewY2 - NewY1 > 8) then begin
          TControl(self).hide;
          TControl(self).top := NewY1;
          TControl(self).Left := NewX1;
          oBarCode.Height := NewY2 - NewY1;
          oBarCode.Width  := NewX2 - NewX1;
  //        TControl(self).Height := oBarCode.Height;
  //        TControl(self).Width := oBarCode.Width;
          SetHeight (oBarCode.Height);
          SetWidth  (oBarCode.Width);
          TControl(self).Show;
        end;
        TempPaintBox.Destroy;
      end;
      MoveLeft := false; MoveTop := false; MoveBottom := false; MoveRight := false;
      MoveAll := false;
    end; {fdESIGNABLE}
    Inherited MouseUp(Button, Shift, X, Y);
  end;
end;


PROCEDURE TMyBarCode.MouseMove(Shift: TShiftState; X,Y: Integer);
begin
  If Assigned (OnMouseMove) then inherited MouseMove(Shift, X,  Y)
  else begin
    inherited MouseMove(Shift, X,  Y);
    if not FDesignable then exit;
    {FDesignable}
    if MoveLeft or MoveTop or MoveBottom or MoveRight or MoveAll then{AMOUSEBUTTON PUSHED}
    begin
       NewCoords(self,X,Y);
       TempPaintBox.Canvas.Pen.width := 2;
       TempPaintBox.Canvas.Pen.color := clAqua;
       TempPaintBox.Canvas.Pen.color := TForm(Parent).color;
       TempPaintBox.Canvas.Rectangle(LastX1,LastY1,LastX2,LastY2);
       TempPaintBox.Canvas.Pen.Style := psSolid;
       TempPaintBox.Canvas.Pen.color := Self.color;

       if (NewX2 - NewX1 > 8) and ( NewY2 - NewY1 > 8) then
       TempPaintBox.canvas.Rectangle(NewX1,NewY1,NewX2,NewY2);
       LastX1 := NewX1;
       LastX2 := NewX2;
       LastY1 := NewY1;
       LastY2 := NewY2;
    end
    else {BUTTON NOT PUSHED}
     with TControl(self) do
     begin
     {left border}
     if (x  < 3) then {left border}
     if (y  < 3) then {norht}
     Cursor := crSizeNWSE
     else
     if ( height - 4 - y) < 3 then {south}
     Cursor := crSizeNESW
     else
     Cursor := crSizeWE
     else {not left}
     {East Border}
     if  (Width - 4 - x) < 3 then      {East border}
     if (y  < 2) then {norht}
     Cursor := crSizeNESW
     else
     if ( height - 4 - y) < 3 then {south}
     Cursor := crSizeNWSE
     else
     Cursor := crSizeWE
     else
     {top}
     if (y  < 2) then
     Cursor := crSizeNS
     else
     if ( height - 4 - y) < 3 then {south}
     Cursor := crSizeNS
     else
     Cursor := crArrow;
     end;
  end;
end;

PROCEDURE TMyBarCode.NewCoords(Sender: TObject; X,Y: Integer);
begin
  if MoveLeft then
  if StartMX <> X then begin
    NewX1  := X + StartX1 - StartMX;
  end;
  if MoveRight then
  if StartMX <> X then begin
    NewX2  := X + StartX2 - StartMX;
  end;

  if MoveTop Then
  if StartMY <> Y then begin
    NewY1  := Y + StartY1 - StartMY;
  end;

  if MoveBottom then
  if StartMY <> Y then begin
    NewY2  := Y + StartY2 - StartMY;
  end;
  if MoveAll then begin
    NewX1  := X + StartX1 - StartMX;
    NewX2  := X + StartX2 - StartMX;
    NewY2  := Y + StartY2 - StartMY;
    NewY1  := Y + StartY1 - StartMY;
  end;
end;{mOVEeDIT}

constructor TMyBarCode.Create(AOwner: TComponent);
var i : integer;
begin
  inherited Create(AOwner);
  Parent:=AOwner as TWincontrol;;
  oBarCode     :=TAsBarcode.Create(Self);
  FDesignable  := true;
  FBarCodeType := bcCodeEAN13;oBarCode.Typ:=FBarCodeType;
  ClearZone    := true;
  FBarColor    := clBLack;    oBarCode.ColorBar:= clBlack;
  Color        := clWhite;    oBarCode.Color   := clWhite;
  text := '123456789012';     oBarCode.Text    := Text;
  SaveFont := TFont.Create;
{  data Aware}
  FDataLink := TFieldDataLink.Create;
  FDataLink.OnDataChange := DataChange;
  oBarCode.Modul:=2;
  FShowTextFont := TFont.Create;
end;

destructor TMyBarCode.Destroy;
{  data Aware}
begin
  FShowTextFont.Free;
  FDataLink.OnDataChange := nil;
  FDataLink.Free;
  FreeandNil(oBarCode);
  inherited Destroy;
end;


{data aware PROCEDUREs}
 FUNCTION TMyBarCode.GetDataField;
 begin
   Result := FDataLink.FieldName;
 end;

 FUNCTION TMyBarCode.GetDataSource;
 begin
   Result := FDataLink.DataSource;
 end;

PROCEDURE TMyBarCode.SetDataField(Const Value: string);
begin
 FDataLink.FieldName:=value;
end;

PROCEDURE TMyBarCode.SetDataSource(Value:TDataSource);
begin
 FDataLink.DataSource:=value;
end;

PROCEDURE TMyBarCode.DataChange(Sender:TObject);
begin
  if (FDataLink.Field <> nil) and (FDataLink.DataSource<>nil) then
  begin
     text:=FDataLink.Field.AsString;
     if(FBarCodeType in [bcCodeEAN13] ) then
     while length(text)<12 do Text := '0' + Text;
     if (FBarCodeType = bcCodeEAN8 ) then
         while length(text) < 7 do Text := '0' + Text;
  end;
end;

end.
