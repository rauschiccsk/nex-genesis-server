unit MarkGrid;
(*
TMarkData je pomocny objekt, s cim sa da nastavit kritéria pre vyfarbenie
riadkov alebo poli v tabulke TMarkGrid.

Vlastnosti
  SelRowColor       - farebne nastavenie pozadia vybraneho riadku ak tabulka je aktivna
  SelCellColor      - farebne nastavenie pozadia vybraneho pola ak tabulka je aktivna
  SelInactRowColor  - farebne nastavenie pozadia vybraneho riadku ak tabulka nie je aktivna
  SelInactCellColor - farebne nastavenie pozadia vybraneho pola ak tabulka nie je aktivna
  PairRowColor      - farebne nastavenie pozadia parnych riadkov

Udalosti
  OnChange - je volana, ak sa zmeni nejaky parameter TMarkData.
*)

interface

uses
  DBGrids, Grids,
  IcConv, IcTools,
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  DB,
  BtrTable;

  const
    cGridPairRowSelect:boolean = TRUE;

type
  TDrawColorRowEvent = procedure (Sender: TObject;var pRowColor:TColor; pField:TField;pFirstFld:boolean{; var pBkColor:TColor}) of object;
  TGetSelectedRow = function:boolean of object;
  TWriteCelText = procedure (pField:TField;var pText:string) of object;

  TMarkData = class (TGraphicsObject)
  private
    oPairRowColor     : TColor;
    oNormalColor      : TColor;
    oSelRowColor      : TColor;
    oSelCellColor     : TColor;
    oSelMultiRowColor : TColor;
    oSelMultiCellColor: TColor;
    oSelInactRowColor : TColor;
    oSelInactCellColor: TColor;
    oSelTextColor     : TColor;
    eOnChange         : TNotifyEvent;

    procedure SetPairRowColor (Value:TColor);
    procedure SetNormalColor (Value:TColor);
    procedure SetSelRowColor (Value:TColor);
    procedure SetSelCellColor (Value:TColor);
    procedure SetSelMultiRowColor (Value:TColor);
    procedure SetSelMultiCellColor (Value:TColor);
    procedure SetSelInactRowColor (Value:TColor);
    procedure SetSelInactCellColor (Value:TColor);
    { Private declarations }
  public
    constructor Create;
    destructor  Destroy; override;
    { Public declarations }
  published
//    property PairRowColor: TColor read oPairRowColor write SetPairRowColor;
    property NormalColor: TColor read oNormalColor write SetNormalColor;

    property SelMultiRowColor: TColor read oSelMultiRowColor write SetSelMultiRowColor;
    property SelMultiCellColor: TColor read oSelMultiCellColor write SetSelMultiCellColor;
    property SelRowColor: TColor read oSelRowColor write SetSelRowColor;
    property SelCellColor: TColor read oSelCellColor write SetSelCellColor;
    property SelInactRowColor: TColor read oSelInactRowColor write SetSelInactRowColor;
    property SelInactCellColor: TColor read oSelInactCellColor write SetSelInactCellColor;

    property OnChange:TNotifyEvent read eOnChange write eOnChange;
    { Published declarations }
  end;

  TMarkGrid = class(TDBGrid)
  private
    oMarkData: TMarkData;
    eOnKeyDown: TKeyEvent;
    eOnKeyUp  : TKeyEvent;
    eOnWriteCelText: TWriteCelText;
    eOnColWidthsChanged: TNotifyEvent;
    eOnDrawColorRow: TDrawColorRowEvent;
    oRowSelect:boolean;
    oFocused  :boolean;
    oLastTopPos:longint;
    eGetSelectedRow: TGetSelectedRow;
    oImageParams      : string;
    // parameter pre zobrazovanie ikon v zozname

    function  SelField (pSelField,pField:string):boolean;
    function  SelFieldItem (pSelField,pField:string;var pItem:byte):boolean;

    function  VerifySpecParams (pSpecFields,pSpecParam:string;pField:TField):boolean;
    function  GetSpecParam (pParam:string;pItem:byte):string;
    function  DataInNum (pData:double;pParam:string):boolean;
    function  DataInDate (pData:TDateTime;pParam:string):boolean;
    function  DataInString (pData,pParam:string):boolean;
    procedure FillInFields (var pParam:string);

    procedure SetParams (pFld,pParams:string;var pSpecFld,pSpecParam:string);

    procedure GetCellPos (pRect:TRect;var pCol,pRow:integer);
    procedure SetRowSelect (Value:boolean);
    procedure MyMarkDataChange (Sender: TObject);
    procedure MyOnKeyDown (Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure MyOnKeyUp (Sender: TObject; var Key: Word; Shift: TShiftState);

    procedure WMVScroll(var Msg: TWMVScroll); message WM_VSCROLL;
  protected
    procedure ColWidthsChanged; override;
    procedure DrawDataCell (const pRect: TRect; pField: TField; pState: TGridDrawState); override;
  public
    eOnDrawColumnCell  : TDrawColumnCellEvent;
    constructor Create(AOwner: TComponent); override;
    destructor  Destroy; override;

    property  ColWidths;
    property  RowHeights;
    property  Row;

    function  GetSelectedRow:boolean;
  published
    property  ImageParams: string read oImageParams write oImageParams;
    property  OnGetSelectedRow: TGetSelectedRow  read eGetSelectedRow write eGetSelectedRow;

    property  MarkData:TMarkData read oMarkData write oMarkData;

    property  ScrollBars;
    property  LeftCol;
    property  VisibleRowCount;

    property  OnKeyDown:TKeyEvent read eOnKeyDown write eOnKeyDown;
    property  OnKeyUp:TKeyEvent read eOnKeyUp write eOnKeyUp;
    property  OnColWidthsChanged: TNotifyEvent read eOnColWidthsChanged write eOnColWidthsChanged;
    property  RowSelect:boolean read oRowSelect write SetRowSelect;
    property  Focused:boolean read oFocused write oFocused;

    property  OnMouseWheelDown;
    property  OnMouseWheelUp;

    property  OnDrawColorRow:TDrawColorRowEvent read eOnDrawColorRow write eOnDrawColorRow;
    property  OnWriteCelText:TWriteCelText read eOnWriteCelText write eOnWriteCelText;
  end;


implementation

uses Math;

procedure WriteText(ACanvas: TCanvas; ARect: TRect; DX, DY: Integer;
  const Text: string; Alignment: TAlignment; ARightToLeft: Boolean);
const
  AlignFlags : array [TAlignment] of Integer =
    ( DT_LEFT or DT_WORDBREAK or DT_EXPANDTABS or DT_NOPREFIX,
      DT_RIGHT or DT_WORDBREAK or DT_EXPANDTABS or DT_NOPREFIX,
      DT_CENTER or DT_WORDBREAK or DT_EXPANDTABS or DT_NOPREFIX );
  RTL: array [Boolean] of Integer = (0, DT_RTLREADING);
var
  B, R: TRect;
  Hold, Left: Integer;
//  I: TColorRef;
begin
//  I := ColorToRGB(ACanvas.Brush.Color);
//  if GetNearestColor(ACanvas.Handle, I) = I then
//  begin                       { Use ExtTextOut for solid colors }
    { In BiDi, because we changed the window origin, the text that does not
      change alignment, actually gets its alignment changed. }
    if (ACanvas.CanvasOrientation = coRightToLeft) and (not ARightToLeft) then
      ChangeBiDiModeAlignment(Alignment);
    case Alignment of
      taLeftJustify:
        Left := ARect.Left + DX;
      taRightJustify:
        Left := ARect.Right - ACanvas.TextWidth(Text) - 3;
    else { taCenter }
      Left := ARect.Left + (ARect.Right - ARect.Left) shr 1
        - (ACanvas.TextWidth(Text) shr 1);
    end;
    ACanvas.TextRect(ARect, Left, ARect.Top + DY, Text);
(*  end
  else begin                  { Use FillRect and Drawtext for dithered colors }
    DrawBitmap.Canvas.Lock;
    try
      with DrawBitmap, ARect do { Use offscreen bitmap to eliminate flicker and }
      begin                     { brush origin tics in painting / scrolling.    }
        Width := Max(Width, Right - Left);
        Height := Max(Height, Bottom - Top);
        R := Rect(DX, DY, Right - Left - 1, Bottom - Top - 1);
        B := Rect(0, 0, Right - Left, Bottom - Top);
      end;
      with DrawBitmap.Canvas do
      begin
        Font := ACanvas.Font;
        Font.Color := ACanvas.Font.Color;
        Brush := ACanvas.Brush;
        Brush.Style := bsSolid;
        FillRect(B);
        SetBkMode(Handle, TRANSPARENT);
        if (ACanvas.CanvasOrientation = coRightToLeft) then
          ChangeBiDiModeAlignment(Alignment);
        DrawText(Handle, PChar(Text), Length(Text), R,
          AlignFlags[Alignment] or RTL[ARightToLeft]);
      end;
      if (ACanvas.CanvasOrientation = coRightToLeft) then
      begin
        Hold := ARect.Left;
        ARect.Left := ARect.Right;
        ARect.Right := Hold;
      end;
      ACanvas.CopyRect(ARect, DrawBitmap.Canvas, B);
    finally
      DrawBitmap.Canvas.Unlock;
    end;
  end;*)
end;

// TMarkData

constructor TMarkData.Create;
begin
  inherited Create;

  oPairRowColor      := clMoneyGreen;

  oNormalColor       := clBlack;

  oSelRowColor       := $FF5050;
  oSelCellColor      := clNavy;
  oSelMultiRowColor  := $001DB630;
  oSelMultiCellColor := clGreen;

  oSelInactRowColor  := $A0A0A0;
  oSelInactCellColor := clGray;
  oSelTextColor      := clWhite;

end;

destructor TMarkData.Destroy;
begin
  inherited Destroy;
end;

procedure TMarkData.SetPairRowColor (Value:TColor);
begin
  oPairRowColor := Value;
  If Assigned (eOnChange) then eOnChange (Self);
end;

procedure TMarkData.SetNormalColor (Value:TColor);
begin
  oNormalColor := Value;
  If Assigned (eOnChange) then eOnChange (Self);
end;

procedure TMarkData.SetSelRowColor (Value:TColor);
begin
  oSelRowColor := Value;
  If Assigned (eOnChange) then eOnChange (Self);
end;

procedure TMarkData.SetSelCellColor (Value:TColor);
begin
  oSelCellColor := Value;
  If Assigned (eOnChange) then eOnChange (Self);
end;

procedure TMarkData.SetSelMultiRowColor (Value:TColor);
begin
  oSelMultiRowColor := Value;
  If Assigned (eOnChange) then eOnChange (Self);
end;

procedure TMarkData.SetSelMultiCellColor (Value:TColor);
begin
  oSelMultiCellColor := Value;
  If Assigned (eOnChange) then eOnChange (Self);
end;

procedure TMarkData.SetSelInactRowColor (Value:TColor);
begin
  oSelInactRowColor := Value;
  If Assigned (eOnChange) then eOnChange (Self);
end;

procedure TMarkData.SetSelInactCellColor (Value:TColor);
begin
  oSelInactCellColor := Value;
  If Assigned (eOnChange) then eOnChange (Self);
end;

//  TMarkGrid

constructor  TMarkGrid.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  inherited OnKeyDown := MyOnKeyDown;
  inherited OnKeyUp := MyOnKeyUp;
  Font.Name := 'Arial';
  TitleFont.Name := 'Arial';

  oMarkData := TMarkData.Create;
  oMarkData.OnChange := MyMarkDataChange;
  oRowSelect := FALSE;
  oFocused := TRUE;
  DefaultDrawing := FALSE;
  oLastTopPos := 0;
  oImageParams   := '';
end;

destructor TMarkGrid.Destroy;
begin
  oMarkData.Free;
  inherited Destroy;
end;

function  TMarkGrid.GetSelectedRow:boolean;
begin
 Result := FALSE;
 If Assigned (eGetSelectedRow) then Result := eGetSelectedRow;
end;

procedure TMarkGrid.ColWidthsChanged;
begin
  inherited ColWidthsChanged;
  If Assigned (eOnColWidthsChanged) then eOnColWidthsChanged(Self);
end;

function  TMarkGrid.SelField (pSelField,pField:string):boolean;
var mIt:byte;
begin
  SelField := SelFieldItem (pSelField,pField,mIt);
end;

function  TMarkGrid.SelFieldItem (pSelField,pField:string;var pItem:byte):boolean;
var
  mField:string;
  mOK:boolean;
begin
  mOK := FALSE;
  pItem := 0;
  If pSelField<>'' then begin
    While (Length (pSelField)>0) and not mOK do begin
      Inc (pItem);
      CutNextParamSepar (pSelField,mField,';');
      mOK := (UpString (mField)=UpString (pField));
    end;
  end else mOK := TRUE;
  If not mOK then pItem := 0;
  SelFieldItem := mOK;
end;

function  TMarkGrid.VerifySpecParams (pSpecFields,pSpecParam:string;pField:TField):boolean;
var
  mOK:boolean;
  mItem:byte;
  mParam:string;
  mP:string;
begin
  mOK := FALSE;
  If SelFieldItem (pSpecFields,pField.FieldName,mItem) then begin
    mParam := GetSpecParam (pSpecParam,mItem);
    If mParam<>'' then begin
      While (mParam<>'') and not mOK do begin
        CutNextParam (mParam,mP);
        If mP<>'' then begin
          If Pos ('"',mP)>0 then FillInFields (mP);
          If pField is TNumericField then mOK := DataInNum (pField.AsFloat,mP);
          If pField is TDateTimeField then mOK := DataInDate (pField.AsDateTime,mP);
          If pField is TStringField then mOK := DataInString (pField.AsString,mP);
        end else mOK := TRUE;
      end;
    end else mOK := TRUE;
  end;
  VerifySpecParams := mOK;
end;

function  TMarkGrid.GetSpecParam (pParam:string;pItem:byte):string;
var
  I:byte;
  mParam:string;
  mPos:byte;
begin
  mParam := '';
  For I:=1 to pItem-1 do begin
    mPos := Pos (']',pParam);
    If mPos>0
      then Delete (pParam,1,mPos)
      else pParam := '';
  end;
  If Pos (']',pParam)>0
   then mParam := Copy (pParam,1,Pos (']',pParam)-1)
   else mParam := pParam;
  If Pos ('[',mParam)>0 then Delete (mParam,1,Pos ('[',mParam));
  GetSpecParam := mParam;
end;

function  TMarkGrid.DataInNum (pData:double;pParam:string):boolean;
var
  mOK  :boolean;
  mF,mL:string;
begin
  If Pos ('..',pParam)>0 then begin
    mF := Copy (pParam,1,Pos ('..',pParam)-1);
    mL := Copy (pParam,Pos ('..',pParam)+2,Length (pParam));
    mOK := (pData>=ValDoub (mF)) and (pData<=ValDoub (mL));
  end else mOK := (pData=ValDoub (pParam));
  DataInNum := mOK;
end;

function  TMarkGrid.DataInDate (pData:TDateTime;pParam:string):boolean;
var
  mOK  :boolean;
  mF,mL:string;
  mDate:string;
begin
  pData := Round (pData);
  If Pos ('TODAY', UpString (pParam))>0 then begin
    mDate := DateToStr (Date);
    While Pos ('TODAY', UpString (pParam))>0 do begin
      Insert (mDate,pParam,Pos ('TODAY', UpString (pParam)));
      Delete (pParam,Pos ('TODAY', UpString (pParam)),5);
    end;
  end;
  If Pos ('..',pParam)>0 then begin
    mF := Copy (pParam,1,Pos ('..',pParam)-1);
    mL := Copy (pParam,Pos ('..',pParam)+2,Length (pParam));
    mOK := (pData>=StrToDate (mF)) and (pData<=StrToDate (mL));
  end else mOK := (pData=StrToDate (pParam));
  DataInDate := mOK;
end;

function  TMarkGrid.DataInString (pData,pParam:string):boolean;
var
  mOK  :boolean;
  mF,mL:string;
begin
  If Pos ('..',pParam)>0 then begin
    mF := Copy (pParam,1,Pos ('..',pParam)-1);
    mL := Copy (pParam,Pos ('..',pParam)+2,Length (pParam));
    mOK := (pData>=mF) and (pData<=mL);
  end else mOK := (pData=pParam);
  DataInString := mOK;
end;

procedure TMarkGrid.FillInFields (var pParam:string);
var
  mField:string;
  mS    :string;
  mData :string;
  mFind :boolean;
  I     :longint;
begin
  While Pos ('"',pParam)>0 do begin
    mS := pParam;
    Delete (mS,1,Pos ('"',mS));
    If Pos ('"',mS)>0 then begin
      mField := Copy (mS,1,Pos ('"',mS)-1);
      mData := '';
      I := 0;
      mFind := FALSE;
      Repeat
        Inc (I);
        If UpString (Fields[I].FieldName) = UpString (mField) then begin
          mData := Fields[I].AsString;
          mFind := TRUE;
        end;
      until (I>=FieldCount) or mFind;
      If mFind then Insert (mData,pParam,Pos ('"',pParam));
      Delete (pParam,Pos ('"',pParam),Length (mField)+2);
    end else pParam := '';
  end;
end;

procedure TMarkGrid.DrawDataCell(const pRect:TRect; pField:TField; pState:TGridDrawState);
var
  mYear,mMonth,mDay : word;
  mColored          : boolean;
  mCol,mRow         : integer;
  mSelColor         : TColor;
  mSelHighColor     : TColor;
  mRowColor         : TColor;
  mRowBkColor       : TColor;
  mI,mId,mIdx,mII   : byte;
  mStr,mIL,mSta,mFld: string;
  mSV               : string;
  mF                : boolean;
  mAlignment: TAlignment; mText: string;
begin
  If (FieldCount > 0) then begin
//Tibi - vždy svetlý kurzor
    oMarkData.oSelRowColor       := $00FFA5A5;
    oMarkData.oSelCellColor      := $00FFCDCD;
    GetCellPos (pRect,mCol,mRow);

    If cGridPairRowSelect then begin
      If (mRow mod 2)=0 then begin
        Canvas.Brush.Color := $00EEFFFF;
        Canvas.FillRect(pRect);
      end;
    end;

    If Row=mRow then begin
      If oFocused then begin
        If GetSelectedRow then begin
          mSelColor := oMarkData.oSelMultiCellColor;
          mSelHighColor := oMarkData.oSelMultiRowColor;
        end else begin
//          mSelColor := oMarkData.oSelCellColor;
//          mSelHighColor := oMarkData.oSelRowColor;
          mSelColor := oMarkData.oSelRowColor;
          mSelHighColor := oMarkData.oSelCellColor;
        end;
      end else begin
        mSelColor := oMarkData.oSelInactCellColor;
        mSelHighColor := oMarkData.oSelInactRowColor;
      end;
      If oRowSelect
      then Canvas.Brush.Color := mSelHighColor
      else begin
        If gdSelected  in pState
          then Canvas.Brush.Color := mSelColor
          else Canvas.Brush.Color := mSelHighColor;
      end;
      // EK 2004-12-07
      // doplnene aby aj polozky pod kurzorom prekresloval farebne
      If Assigned (eOnDrawColorRow) then begin
        mRowBkColor := Canvas.Brush.Color;
        mRowColor   := Canvas.Font.Color;
        eOnDrawColorRow (Self,mRowColor,pField,(oLastTopPos<>pRect.Top) or (pRect.Left<15){,mRowBkColor});
        Canvas.Font.Color := mRowColor;
        Canvas.Brush.Color := mRowBkColor;
        oLastTopPos := pRect.Top;
(*        If mRowColor <> oMarkData.oNormalColor then begin
//          Canvas.Font.Color := mRowColor;  netreba menit aj farbu textu iba kurzor
          Canvas.Font.Color  := oMarkData.oSelTextColor;
          If oRowSelect
          then Canvas.Brush.Color := clMaroon
          else begin
            If gdSelected  in pState
              then Canvas.Brush.Color := clMaroon
              else Canvas.Brush.Color := mRowBkColor;//$000080FF; //$00404080;
          end;
        end else begin
          Canvas.Font.Color := oMarkData.oSelTextColor;
        end;*)
      end;// Tibi test else Canvas.Font.Color := oMarkData.oSelTextColor;
    end else begin
    {Row<>mRow}
      If GetSelectedRow then begin
        If oFocused
          then mSelColor := oMarkData.oSelMultiRowColor
          else mSelColor := oMarkData.oSelInactRowColor;
        Canvas.Brush.Color := mSelColor;
      end;
      If SelectedRows.CurrentRowSelected then begin
        If oFocused
          then mSelColor := oMarkData.oSelCellColor
          else mSelColor := oMarkData.oSelInactCellColor;
        Canvas.Brush.Color := mSelColor;
        Canvas.Font.Color := oMarkData.oSelTextColor;
      end else begin
        Canvas.Font.Color := oMarkData.oNormalColor;
        If Assigned (eOnDrawColorRow) then begin
          mRowColor := Canvas.Font.Color;
          mRowBkColor := Canvas.Brush.Color;
          eOnDrawColorRow (Self,mRowColor,pField,(oLastTopPos<>pRect.Top) or (pRect.Left<15){,mRowBkColor});
          oLastTopPos := pRect.Top;
          Canvas.Font.Color := mRowColor;
          Canvas.Brush.Color := mRowBkColor;
        end;
      end;
    end;
  end;
  mF:=FALSE;
  If ImageParams<>'' then begin
    // zobrazenie ikony namiesto textu v zozname
    for mI:=0 to LineElementNum(ImageParams,'+')-1 do begin
      mStr:=LineElement(oImageParams,mI,'+');
      mIL :=LineElement(mStr,0,'|');
      mFld:=LineElement(mStr,1,'|');
      mSta:=LineElement(mStr,2,'|');
      If (pField.FieldName=mFld)
      then If (Application.FindComponent('DM_System')<>NIL) and (Application.FindComponent('DM_System').FindComponent (mIL)<>NIL) then begin
        for mID:=0 to LineElementNum(mSta,';')-1 do begin
          mIDX:= StrToInt(LineElement(LineElement(mSta,mID,';'),0,'='));
          mSV := LineElement(LineElement(mSta,mID,';'),1,'=');
          mF  := FALSE;
          for mII:=0 to LineElementNum(mSV,',')-1 do begin
            mF:=mF or (LineElement(mSV,mII,',')=pField.AsString);
          end;
          If mF then begin
            Canvas.FillRect(pRect);
            (Application.FindComponent('DM_System').FindComponent (mIL) as TImageList).Draw(Self.Canvas
            ,pRect.left,pRect.top,mIdx);
{              If gdFocused in State then Canvas.DrawFocusRect(pRect);}
          end;
          If mF then Break;
        end;
      end;
    end;
  end;


  If not mF then begin
    mAlignment := taLeftJustify;
    mText := '';
    If Assigned(pField) then begin
      mAlignment := pField.Alignment;
      mText := pField.DisplayText;
      If Assigned(eOnWriteCelText) then eOnWriteCelText (pField,mText);
    end;
    WriteText(Canvas, pRect, 2, 2, mText, mAlignment, UseRightToLeftAlignmentForField(pField, mAlignment));
  end;
//  If not mF then  DefaultDrawDataCell(pRect,pField,pState);
end;

procedure TMarkGrid.SetParams (pFld,pParams:string;var pSpecFld,pSpecParam:string);
var
  I:longint;
  mCnt:longint;
  mP,mS:string;
  mPList: array [1..20] of string;
  mPCnt:byte;
begin
  If Pos (UpString (pFld),UpString (pSpecFld))>0 then begin
    mP := Copy (pSpecFld,1,Pos (UpString (pFld),UpString (pSpecFld))-1);
    mCnt := 1;
    For I:=1 to Length (mP) do begin
      If mP[I]=';' then Inc (mCnt);
    end;
    mPCnt := 0;
    mS := pSpecParam;
    For I:=1 to 20 do
      mPList[I] := '';
    While (mS<>'') and (mPCnt<20) do begin
      If Pos ('[',mS)>0 then begin
        Delete (mS,1,Pos ('[',mS));
        If Pos (']',mS)>0 then begin
          Inc (mPCnt);
          mPList[mPCnt] := Copy (mS,1,Pos (']',mS)-1);
          Delete (mS,1,Pos (']',mS));
        end else begin
          Inc (mPCnt);
          mPList[mPCnt] := mS;
          mS := '';
        end;
      end else mS := '';
    end;
    If (mCnt>0) and (mCnt<=20) then begin
      mPList[mCnt] := pParams;
      pSpecParam := '';
      If mPCnt<mCnt then mPCnt := mCnt;
      For I:=1 to mPCnt do
        pSpecParam := pSpecParam+'['+mPList[I]+']';
    end;
  end else begin
    If Length (pSpecFld)>0
      then pSpecFld := pSpecFld+';'+pFld
      else pSpecFld := pFld;
    pSpecParam := pSpecParam+'['+pParams+']';
  end;
end;

procedure TMarkGrid.GetCellPos (pRect:TRect;var pCol,pRow:integer);
var mTop,mLeft:integer;
begin
 pCol := 0;
 pRow := 0;
 mTop := 0;
 mLeft := 0;
 While mLeft<pRect.Left do begin
   mLeft := mLeft+ColWidths[pCol]+1;
   Inc (pCol);
 end;
 While mTop<pRect.Top do begin
   mTop := mTop+RowHeights[pRow]+1;
   Inc (pRow);
 end;
end;

procedure TMarkGrid.SetRowSelect (Value:boolean);
begin
  oRowSelect := Value;
  Repaint;
end;

procedure TMarkGrid.MyMarkDataChange (Sender: TObject);
begin
  Repaint;
end;

procedure TMarkGrid.MyOnKeyDown (Sender: TObject; var Key: Word; Shift: TShiftState);
begin
  If Assigned(eOnKeyDown) then eOnKeyDown (Self, Key, Shift);
  If Key=VK_Down then begin
    If DataSource.DataSet.Eof then Key := 0;
  end;
end;

procedure TMarkGrid.MyOnKeyUp (Sender: TObject; var Key: Word; Shift: TShiftState);
begin
  If Assigned(eOnKeyUp) then eOnKeyUp (Self, Key, Shift);
  If Key=VK_Up then begin
    If DataSource.DataSet.State=dsInsert then DataSource.DataSet.Cancel;
  end;
end;

procedure TMarkGrid.WMVScroll(var Msg: TWMVScroll);
begin
  inherited;
  If cGridPairRowSelect then Repaint;
end;

end.
