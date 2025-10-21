unit DsgnUtils;

interface

  uses
    xpComp, BaseUtils, IcConv, IcTools,
    Forms,Windows, Graphics, StdCtrls, Controls, Classes, SysUtils;

  const
    zETX = Chr (3);
    zTAB = Chr (9);
    zLF  = Chr (10);
    zCR  = Chr (13);
    zRS  = Chr (30);

  type

  TCompData = class
  private
    oCompType   : string;
    oParent     : string;
    oLeft       : longint;
    oTop        : longint;
    oHeight     : longint;
    oWidth      : longint;
    oVisible    : boolean;
    oEnabled    : boolean;
    oReadOnly   : boolean;
    oTabOrder   : longint;
    oTabStop    : boolean;
    oTabsShow   : boolean;
    oTabHeight  : longint;
    oAlign      : TAlign;
    oAlignment  : TAlignment;
    oAlignText  : TAlignText;
    oAnchors    : TAnchors;
    oAutoSize   : boolean;
    oCaption    : string;
    oLines      : string;
    oHead       : string;
    oColor      : TColor;
    oBorderColor: TColor;
    oGlyph      : string;
    oButtLayout : TButtonLayout;
    oTextLayout : TTextLayout;
    oMaxLength  : longint;
    oNumSepar   : boolean;
    oFrac       : longint;
    oEditorType : TEditorType;
    oExtTextShow: boolean;
    oInfoField  : boolean;
    oTransparent: boolean;
    oWordWrap   : boolean;
    oPageIndex  : longint;
    oHint       : string;
    oShowHint   : boolean;
    oSystemColor: boolean;
    oBasicColor : TColor;
    oCheckColor : TColor;
    oMultiLine  : boolean;
    oBGImage       : string;
    oBGStyle       : TxpTabBGStyle;
    oGradEndColor  : TColor;
    oGradStartColor: TColor;
    oGradFillDir   : TFillDirection;
    oFontColor  : TColor;
    oFontName   : string;
    oFontSize   : longint;
    oFontStyle  : TFontStyles;
    oFontCharset: TFontCharset;

    oCompFlds  : string;

    oSaveOnlySelected: boolean;

    procedure AddCompFlds (pFld:string);
    function  FindCompFld (pFld:string):boolean;
  public
    constructor Create;
    destructor  Destroy;

    procedure SetCompData (pParam:string);
    function  GetCompData:string;
    procedure ClearCompData;
    procedure SetDefPropList (pPropList:string);

    procedure SetCompType (pValue: string);
    procedure SetParent (pValue: string);
    procedure SetLeft (pValue: longint);
    procedure SetTop (pValue: longint);
    procedure SetHeight (pValue: longint);
    procedure SetWidth (pValue: longint);
    procedure SetVisible (pValue: boolean);
    procedure SetEnabled (pValue: boolean);
    procedure SetReadOnly (pValue: boolean);
    procedure SetTabOrder (pValue: longint);
    procedure SetTabStop (pValue: boolean);
    procedure SetTabsShow (pValue: boolean);
    procedure SetTabHeight (pValue: longint);
    procedure SetAlign (pValue: TAlign);
    procedure SetAlignment (pValue: TAlignment);
    procedure SetAlignText (pValue: TAlignText);
    procedure SetAnchors (pValue: TAnchors);
    procedure SetAutoSize (pValue: boolean);
    procedure SetCaption (pValue: string);
    procedure SetLines (pValue: string);
    procedure SetHead (pValue: string);
    procedure SetColor (pValue: TColor);
    procedure SetBorderColor (pValue: TColor);
    procedure SetGlyph (pValue: string);
    procedure SetButtLayout (pValue: TButtonLayout);
    procedure SetTextLayout (pValue: TTextLayout);
    procedure SetMaxLength (pValue: longint);
    procedure SetNumSepar (pValue: boolean);
    procedure SetFrac (pValue: longint);
    procedure SetEditorType (pValue: TEditorType);
    procedure SetExtTextShow (pValue:boolean);
    procedure SetInfoField (pValue: boolean);
    procedure SetTransparent (pValue: boolean);
    procedure SetWordWrap (pValue: boolean);
    procedure SetPageIndex (pValue: longint);
    procedure SetHint (pValue: string);
    procedure SetShowHint (pValue: boolean);
    procedure SetSystemColor (pValue: boolean);
    procedure SetBasicColor (pValue: TColor);
    procedure SetCheckColor (pValue: TColor);
    procedure SetMultiLine (pValue: boolean);
    procedure SetBGImage (pValue: string);
    procedure SetBGStyle (pValue: TxpTabBGStyle);
    procedure SetGradEndColor (pValue: TColor);
    procedure SetGradStartColor (pValue: TColor);
    procedure SetGradFillDir (pValue: TFillDirection);
    procedure SetFontColor (pValue: TColor);
    procedure SetFontName (pValue: string);
    procedure SetFontSize (pValue: longint);
    procedure SetFontStyle (pValue: TFontStyles);
    procedure SetFontCharset (pValue:TFontCharset);

    function  GetCompType:string;
    function  GetParent:string;
    function  GetLeft (pValue:longint):longint;
    function  GetTop (pValue:longint):longint;
    function  GetHeight (pValue:longint):longint;
    function  GetWidth (pValue:longint):longint;
    function  GetVisible (pValue:boolean):boolean;
    function  GetEnabled (pValue:boolean):boolean;
    function  GetReadOnly (pValue:boolean):boolean;
    function  GetTabOrder (pValue:longint):longint;
    function  GetTabStop (pValue:boolean):boolean;
    function  GetAlign (pValue:TAlign):TAlign;
    function  GetAlignment (pValue:TAlignment):TAlignment;
    function  GetAlignText (pValue:TAlignText):TAlignText;
    function  GetAnchors (pValue:TAnchors):TAnchors;
    function  GetAutoSize (pValue:boolean):boolean;
    function  GetCaption (pValue:string):string;
    function  GetLines (pValue:string):string;
    function  GetHead (pValue:string):string;
    function  GetColor (pValue:TColor):TColor;
    function  GetBorderColor (pValue:TColor):TColor;
    function  GetGlyph (pValue:string):string;
    function  GetButtLayout (pValue:TButtonLayout):TButtonLayout;
    function  GetTextLayout (pValue:TTextLayout):TTextLayout;
    function  GetMaxLength (pValue:longint):longint;
    function  GetNumSepar (pValue:boolean):boolean;
    function  GetFrac (pValue:longint):longint;
    function  GetEditorType (pValue:TEditorType):TEditorType;
    function  GetExtTextShow (pValue:boolean):boolean;
    function  GetInfoField (pValue:boolean):boolean;
    function  GetTransparent (pValue:boolean):boolean;
    function  GetWordWrap (pValue:boolean):boolean;
    function  GetPageIndex (pValue:longint):longint;
    function  GetHint (pValue:string):string;
    function  GetShowHint (pValue:boolean):boolean;
    function  GetTabsShow (pValue:boolean):boolean;
    function  GetTabHeight (pValue:longint):longint;
    function  GetSystemColor (pValue:boolean):boolean;
    function  GetBasicColor (pValue:TColor):TColor;
    function  GetCheckColor (pValue:TColor):TColor;
    function  GetMultiLine (pValue:boolean):boolean;
    function  GetBGImage (pValue:string):string;
    function  GetBGStyle (pValue:TxpTabBGStyle):TxpTabBGStyle;
    function  GetGradEndColor (pValue:TColor):TColor;
    function  GetGradStartColor (pValue:TColor):TColor;
    function  GetGradFillDir (pValue:TFillDirection):TFillDirection;
    function  GetFontColor (pValue:TColor):TColor;
    function  GetFontName (pValue:string):string;
    function  GetFontSize (pValue:longint):longint;
    function  GetFontStyle (pValue:TFontStyles):TFontStyles;
    function  GetFontCharset (pValue:TFontCharset):TFontCharset;

    property  SaveOnlySelected:boolean read oSaveOnlySelected write oSaveOnlySelected;
    property  CompFlds:string read oCompFlds write oCompFlds; 
  end;

  procedure CutNextParam (var pParam,pCom,pVal:string);
  function  GetParentObj(pMainForm:TForm;pParent:string):TWinControl;

  function  ConvStrToAnchors (pVal:string):TAnchors;
  function  ConvAnchorsToStr (pVal:TAnchors):string;
  function  ConvStrToAlignText (pVal:string):TAlignText;
  function  ConvAlignTextToStr (pVal:TAlignText):string;
  function  ConvStrToButtonLayout (pVal:string):TButtonLayout;
  function  ConvButtLayoutToStr (pVal:TButtonLayout):string;
  function  ConvStrToFontStyle (pVal:string):TFontStyles;
  function  ConvFontStyleToStr (pVal:TFontStyles):string;
  function  EncodeMultiLnStr (pVal:string):string;
  function  DecodeMultiLnStr (pVal:string):string;
  function  ConvStrToTextLayout (pVal:string):TTextLayout;
  function  ConvTextLayoutToStr (pVal:TTextLayout):string;
  function  ConvStrToAlignment (pVal:string):TAlignment;
  function  ConvAlignmentToStr (pVal:TAlignment):string;
  function  ConvStrToAlign (pVal:string):TAlign;
  function  ConvAlignToStr (pVal:TAlign):string;
  function  ConvStrToEditorType (pVal:string):TEditorType;
  function  ConvEditorTypeToStr (pVal:TEditorType):string;
  function  ConvStrToBGStyle (pVal:string):TxpTabBGStyle;
  function  ConvBGStyleToStr (pVal:TxpTabBGStyle):string;
  function  ConvStrToGradFillDir (pVal:string):TFillDirection;
  function  ConvGradFillDirToStr (pVal:TFillDirection):string;
  function  ConvStrToFontCharset (pVal:string):TFontCharset;
  function  ConvFontCharsetToStr (pVal:TFontCharset):string;
  function  ConvStrToWindowState (pVal:string):TWindowState;
  function  ConvWindowStateToStr (pVal:TWindowState):string;

  function  ConvBitmapToHEX (pBitmap:TBitmap):string;
  procedure ConvHEXToBitmap (pStr:string;pBitmap:TBitmap);

  function  GetFormDefFileName (pFile:string;pFormNum:byte):string;


implementation


procedure TCompData.AddCompFlds (pFld:string);
begin
  If not oSaveOnlySelected then begin
    If oCompFlds='' then oCompFlds := oCompFlds+';';
  end;
  If not FindCompFld (pFld) then oCompFlds := oCompFlds+pFld+';';
end;

function  TCompData.FindCompFld (pFld:string):boolean;
begin
  Result := Pos (';'+pFld+';',oCompFlds)>0;
end;

constructor TCompData.Create;
begin
  oSaveOnlySelected := FALSE;
  ClearCompData;
end;

destructor  TCompData.Destroy;
begin
end;

procedure TCompData.SetCompData (pParam:string);
var mCom,mVal:string;
begin
  ClearCompData;
  Repeat
    CutNextParam(pParam,mCom,mVal);
    If mCom='Parent' then SetParent (mVal);
    If mCom='Left' then SetLeft (ValInt (mVal));
    If mCom='Top' then SetTop (ValInt (mVal));
    If mCom='Height' then SetHeight (ValInt (mVal));
    If mCom='Width' then SetWidth (ValInt (mVal));
    If mCom='Visible' then SetVisible (StrToBool (mVal));
    If mCom='Enabled' then SetEnabled (StrToBool (mVal));
    If mCom='ReadOnly' then SetReadOnly (StrToBool (mVal));
    If mCom='TabOrder' then SetTabOrder (ValInt (mVal));
    If mCom='TabStop' then SetTabStop (StrToBool (mVal));
    If mCom='Align' then SetAlign (ConvStrToAlign (mVal));
    If mCom='Alignment' then SetAlignment (ConvStrToAlignment (mVal));
    If mCom='AlignText' then SetAlignText (ConvStrToAlignText (mVal));
    If mCom='Anchors' then SetAnchors (ConvStrToAnchors (mVal));
    If mCom='AutoSize' then SetAutoSize (StrToBool (mVal));
    If mCom='Caption' then SetCaption (mVal);
    If mCom='Items' then SetLines (DecodeMultiLnStr (mVal));
    If mCom='Lines' then SetLines (DecodeMultiLnStr (mVal));
    If mCom='Head' then SetHead (mVal);
    If mCom='Color' then SetColor (ValInt (mVal));
    If mCom='BorderColor' then SetBorderColor (ValInt (mVal));
    If mCom='CheckColor' then SetCheckColor (ValInt (mVal));
    If mCom='Glyph' then SetGlyph (mVal);
    If mCom='ButtLayout' then SetButtLayout (ConvStrToButtonLayout (mVal));
    If mCom='TextLayout' then SetTextLayout (ConvStrToTextLayout (mVal));
    If mCom='MaxLength' then SetMaxLength (ValInt (mVal));
    If mCom='NumSepar' then SetNumSepar (StrToBool (mVal));
    If mCom='Frac' then SetFrac (ValInt (mVal));
    If mCom='EditorType' then SetEditorType (ConvStrToEditorType (mVal));
    If mCom='ExtTextShow' then SetExtTextShow (StrToBool (mVal));
    If mCom='InfoField' then SetInfoField (StrToBool (mVal));
    If mCom='Transparent' then SetTransparent (StrToBool (mVal));
    If mCom='WordWrap' then SetWordWrap (StrToBool (mVal));
    If mCom='PageIndex' then SetPageIndex (ValInt (mVal));
    If mCom='Hint' then SetHint (DecodeMultiLnStr (mVal));
    If mCom='ShowHint' then SetShowHint (StrToBool (mVal));
    If mCom='SystemColor' then SetSystemColor (StrToBool (mVal));
    If mCom='BasicColor' then SetBasicColor (ValInt (mVal));
    If mCom='MultiLine' then SetMultiLine (StrToBool (mVal));
    If mCom='TabsShow' then SetTabsShow (StrToBool (mVal));
    If mCom='TabHeight' then SetTabHeight (ValInt (mVal));
    If mCom='BGImage' then SetBGImage (mVal);
    If mCom='BGStyle' then SetBGStyle (ConvStrToBGStyle (mVal));
    If mCom='GradEndColor' then SetGradEndColor (ValInt (mVal));
    If mCom='GradStartColor' then SetGradStartColor (ValInt (mVal));
    If mCom='GradFillDir' then SetGradFillDir (ConvStrToGradFillDir (mVal));
    If mCom='FontColor' then SetFontColor (ValInt (mVal));
    If mCom='FontName' then SetFontName (mVal);
    If mCom='FontSize' then SetFontSize (ValInt (mVal));
    If mCom='FontStyle' then SetFontStyle (ConvStrToFontStyle (mVal));
    If mCom='FontCharset' then SetFontCharset (ConvStrToFontCharset (mVal));
  until pParam='';
end;

function  TCompData.GetCompData:string;
begin
  Result := 'Type'+zTAB+oCompType;
  If FindCompFld ('Parent') then Result := Result+zETX+'Parent'+zTAB+oParent;
  If FindCompFld ('Top') then Result := Result+zETX+'Top'+zTAB+StrInt(oTop,0);
  If FindCompFld ('Left') then Result := Result+zETX+'Left'+zTAB+StrInt(oLeft,0);
  If FindCompFld ('Height') then Result := Result+zETX+'Height'+zTAB+StrInt(oHeight,0);
  If FindCompFld ('Width') then Result := Result+zETX+'Width'+zTAB+StrInt(oWidth,0);
  If FindCompFld ('Visible') then Result := Result+zETX+'Visible'+zTAB+BoolToStr (oVisible,TRUE);
  If FindCompFld ('Enabled') then Result := Result+zETX+'Enabled'+zTAB+BoolToStr (oEnabled,TRUE);
  If FindCompFld ('ReadOnly') then Result := Result+zETX+'ReadOnly'+zTAB+BoolToStr (oReadOnly,TRUE);
  If FindCompFld ('TabOrder') then Result := Result+zETX+'TabOrder'+zTAB+StrInt(oTabOrder,0);
  If FindCompFld ('TabStop') then Result := Result+zETX+'TabStop'+zTAB+BoolToStr (oTabStop,TRUE);
  If FindCompFld ('Align') then Result := Result+zETX+'Align'+zTAB+ConvAlignToStr (oAlign);
  If FindCompFld ('Alignment') then Result := Result+zETX+'Alignment'+zTAB+ConvAlignmentToStr (oAlignment);
  If FindCompFld ('AlignText') then Result := Result+zETX+'AlignText'+zTAB+ConvAlignTextToStr (oAlignText);
  If FindCompFld ('Anchors') then Result := Result+zETX+'Anchors'+zTAB+ConvAnchorsToStr (oAnchors);
  If FindCompFld ('AutoSize') then Result := Result+zETX+'AutoSize'+zTAB+BoolToStr (oAutoSize,TRUE);
  If FindCompFld ('Caption') then Result := Result+zETX+'Caption'+zTAB+oCaption;
  If FindCompFld ('Items') then Result := Result+zETX+'Items'+zTAB+EncodeMultiLnStr (oLines);
  If FindCompFld ('Lines') then Result := Result+zETX+'Lines'+zTAB+EncodeMultiLnStr (oLines);
  If FindCompFld ('Head') then Result := Result+zETX+'Head'+zTAB+oHead;
  If FindCompFld ('Glyph') then Result := Result+zETX+'Glyph'+zTAB+oGlyph;
  If FindCompFld ('ButtLayout') then Result := Result+zETX+'ButtLayout'+zTAB+ConvButtLayoutToStr (oButtLayout);
  If FindCompFld ('TextLayout') then Result := Result+zETX+'TextLayout'+zTAB+ConvTextLayoutToStr (oTextLayout);
  If FindCompFld ('MaxLength') then Result := Result+zETX+'MaxLength'+zTAB+StrInt(oMaxLength,0);
  If FindCompFld ('NumSepar') then Result := Result+zETX+'NumSepar'+zTAB+BoolToStr (oNumSepar,TRUE);
  If FindCompFld ('Frac') then Result := Result+zETX+'Frac'+zTAB+StrInt(oFrac,0);
  If FindCompFld ('EditorType') then Result := Result+zETX+'EditorType'+zTAB+ConvEditorTypeToStr(oEditorType);
  If FindCompFld ('ExtTextShow') then Result := Result+zETX+'ExtTextShow'+zTAB+BoolToStr (oExtTextShow,TRUE);
  If FindCompFld ('InfoField') then Result := Result+zETX+'InfoField'+zTAB+BoolToStr (oInfoField,TRUE);
  If FindCompFld ('Transparent') then Result := Result+zETX+'Transparent'+zTAB+BoolToStr (oTransparent,TRUE);
  If FindCompFld ('WordWrap') then Result := Result+zETX+'WordWrap'+zTAB+BoolToStr (oWordWrap,TRUE);
  If FindCompFld ('Hint') then Result := Result+zETX+'Hint'+zTAB+EncodeMultiLnStr (oHint);
  If FindCompFld ('ShowHint') then Result := Result+zETX+'ShowHint'+zTAB+BoolToStr (oShowHint,TRUE);
  If FindCompFld ('MultiLine') then Result := Result+zETX+'MultiLine'+zTAB+BoolToStr (oMultiLine,TRUE);
  If FindCompFld ('PageIndex') then Result := Result+zETX+'PageIndex'+zTAB+StrInt(oPageIndex,0);
  If FindCompFld ('TabsShow') then Result := Result+zETX+'TabsShow'+zTAB+BoolToStr (oTabsShow,TRUE);
  If FindCompFld ('TabHeight') then Result := Result+zETX+'TabHeight'+zTAB+StrInt (oTabHeight,0);
  If FindCompFld ('SystemColor') then Result := Result+zETX+'SystemColor'+zTAB+BoolToStr (oSystemColor,TRUE);
  If FindCompFld ('BasicColor') then Result := Result+zETX+'BasicColor'+zTAB+StrInt(oBasicColor,0);
  If FindCompFld ('Color') then Result := Result+zETX+'Color'+zTAB+StrInt(oColor,0);
  If FindCompFld ('BorderColor') then Result := Result+zETX+'BorderColor'+zTAB+StrInt(oBorderColor,0);
  If FindCompFld ('CheckColor') then Result := Result+zETX+'CheckColor'+zTAB+StrInt(oCheckColor,0);
  If FindCompFld ('BGImage') then Result := Result+zETX+'BGImage'+zTAB+oBGImage;
  If FindCompFld ('BGStyle') then Result := Result+zETX+'BGStyle'+zTAB+ConvBGStyleToStr(oBGStyle);
  If FindCompFld ('GradEndColor') then Result := Result+zETX+'GradEndColor'+zTAB+StrInt(oGradEndColor,0);
  If FindCompFld ('GradStartColor') then Result := Result+zETX+'GradStartColor'+zTAB+StrInt(oGradStartColor,0);
  If FindCompFld ('GradFillDir') then Result := Result+zETX+'GradFillDir'+zTAB+ConvGradFillDirToStr(oGradFillDir);
  If FindCompFld ('FontColor') then Result := Result+zETX+'FontColor'+zTAB+StrInt(oFontColor,0);
  If FindCompFld ('FontName') then Result := Result+zETX+'FontName'+zTAB+oFontName;
  If FindCompFld ('FontSize') then Result := Result+zETX+'FontSize'+zTAB+StrInt(oFontSize,0);
  If FindCompFld ('FontStyle') then Result := Result+zETX+'FontStyle'+zTAB+ConvFontStyleToStr(oFontStyle);
  If FindCompFld ('FontCharset') then Result := Result+zETX+'FontCharset'+zTAB+ConvFontCharsetToStr(oFontCharset);
end;

procedure TCompData.ClearCompData;
begin
  oCompFlds :=  '';
  oCompType    := '';
  oParent      := '';
  oLeft        := 0;
  oTop         := 0;
  oHeight      := 0;
  oWidth       := 0;
  oVisible     := FALSE;
  oEnabled     := FALSE;
  oReadOnly    := FALSE;
  oTabOrder    := 0;
  oTabStop     := FALSE;
  oAlign       := alNone;
  oAlignment   := taLeftJustify;
  oAlignText   := atLeft;
  oAnchors     := [akLeft,akTop];
  oAutoSize    := FALSE;
  oCaption     := '';
  oLines       := '';
  oHead        := '';
  oColor       := 0;
  oBorderColor := 0;
  oGlyph       := '';
  oButtLayout  := blGlyphLeft;
  oTextLayout  := tlTop;
  oMaxLength   := 0;
  oNumSepar    := FALSE;
  oFrac        := 0;
  oInfoField   := FALSE;
  oTransparent := FALSE;
  oWordWrap    := FALSE;
  oPageIndex   := 0;
  oHint        := '';
  oShowHint    := FALSE;
  oSystemColor := FALSE;
  oBasicColor  := cbcBasicColor;
  oCheckColor  := 0;
  oMultiLine   := FALSE;
  oBGImage     := '';
  oBGStyle     := bgsNone;
  oGradEndColor := 0;
  oGradStartColor := 0;
  oGradFillDir := fdXP;
  oFontColor   := 0;
  oFontName    := '';
  oFontSize    := 0;
  oFontStyle   := [];
  oFontCharset := DEFAULT_CHARSET;
end;

procedure TCompData.SetDefPropList (pPropList:string);
begin
  oCompFlds := pPropList;
end;

procedure TCompData.SetCompType (pValue: string);
begin
  oCompType := pValue;
  AddCompFlds('Type');
end;

procedure TCompData.SetParent (pValue: string);
begin
  oParent := pValue;
  AddCompFlds('Parent');
end;

procedure TCompData.SetLeft (pValue: longint);
begin
  oLeft := pValue;
  AddCompFlds('Left');
end;

procedure TCompData.SetTop (pValue: longint);
begin
  oTop := pValue;
  AddCompFlds('Top');
end;

procedure TCompData.SetHeight (pValue: longint);
begin
  oHeight := pValue;
  AddCompFlds('Height');
end;

procedure TCompData.SetWidth (pValue: longint);
begin
  oWidth := pValue;
  AddCompFlds('Width');
end;

procedure TCompData.SetVisible (pValue: boolean);
begin
  oVisible := pValue;
  AddCompFlds('Visible');
end;

procedure TCompData.SetEnabled (pValue: boolean);
begin
  oEnabled := pValue;
  AddCompFlds('Enabled');
end;

procedure TCompData.SetReadOnly (pValue: boolean);
begin
  oReadOnly := pValue;
  AddCompFlds('ReadOnly');
end;

procedure TCompData.SetTabOrder (pValue: longint);
begin
  oTabOrder := pValue;
  AddCompFlds('TabOrder');
end;

procedure TCompData.SetTabStop (pValue: boolean);
begin
  oTabStop := pValue;
  AddCompFlds('TabStop');
end;

procedure TCompData.SetTabsShow (pValue: boolean);
begin
  oTabsShow := pValue;
  AddCompFlds('TabsShow');
end;

procedure TCompData.SetTabHeight (pValue: longint);
begin
  oTabHeight := pValue;
  AddCompFlds('TabHeight');
end;

procedure TCompData.SetAlign (pValue: TAlign);
begin
  oAlign := pValue;
  AddCompFlds('Align');
end;

procedure TCompData.SetAlignment (pValue: TAlignment);
begin
  oAlignment := pValue;
  AddCompFlds('Alignment');
end;

procedure TCompData.SetAlignText (pValue: TAlignText);
begin
  oAlignText := pValue;
  AddCompFlds('AlignText');
end;

procedure TCompData.SetAnchors (pValue: TAnchors);
begin
  oAnchors := pValue;
  AddCompFlds('Anchors');
end;

procedure TCompData.SetAutoSize (pValue: boolean);
begin
  oAutoSize := pValue;
  AddCompFlds('AutoSize');
end;

procedure TCompData.SetCaption (pValue: string);
begin
  oCaption := pValue;
  AddCompFlds('Caption');
end;

procedure TCompData.SetLines (pValue: string);
begin
  oLines := pValue;
  AddCompFlds('Lines');
end;

procedure TCompData.SetHead (pValue: string);
begin
  oHead := pValue;
  AddCompFlds('Head');
end;

procedure TCompData.SetColor (pValue: TColor);
begin
  oColor := pValue;
  AddCompFlds('Color');
end;

procedure TCompData.SetBorderColor (pValue: TColor);
begin
  oBorderColor := pValue;
  AddCompFlds('BorderColor');
end;

procedure TCompData.SetGlyph (pValue: string);
begin
  oGlyph := pValue;
  AddCompFlds('Glyph');
end;

procedure TCompData.SetButtLayout (pValue: TButtonLayout);
begin
  oButtLayout := pValue;
  AddCompFlds('ButtLayout');
end;

procedure TCompData.SetTextLayout (pValue: TTextLayout);
begin
  oTextLayout := pValue;
  AddCompFlds('TextLayout');
end;

procedure TCompData.SetMaxLength (pValue: longint);
begin
  oMaxLength := pValue;
  AddCompFlds('MaxLength');
end;

procedure TCompData.SetNumSepar (pValue: boolean);
begin
  oNumSepar := pValue;
  AddCompFlds('NumSepar');
end;

procedure TCompData.SetFrac (pValue: longint);
begin
  oFrac := pValue;
  AddCompFlds('Frac');
end;

procedure TCompData.SetEditorType (pValue: TEditorType);
begin
  oEditorType := pValue;
  AddCompFlds('EditorType');
end;

procedure TCompData.SetExtTextShow (pValue:boolean);
begin
  oExtTextShow := pValue;
  AddCompFlds('ExtTextShow');
end;

procedure TCompData.SetInfoField (pValue: boolean);
begin
  oInfoField := pValue;
  AddCompFlds('InfoField');
end;

procedure TCompData.SetTransparent (pValue: boolean);
begin
  oTransparent := pValue;
  AddCompFlds('Transparent');
end;

procedure TCompData.SetWordWrap (pValue: boolean);
begin
  oWordWrap := pValue;
  AddCompFlds('WordWrap');
end;

procedure TCompData.SetPageIndex (pValue: longint);
begin
  oPageIndex := pValue;
  AddCompFlds('PageIndex');
end;

procedure TCompData.SetHint (pValue: string);
begin
  oHint := pValue;
  AddCompFlds('Hint');
end;

procedure TCompData.SetShowHint (pValue: boolean);
begin
  oShowHint := pValue;
  AddCompFlds('ShowHint');
end;

procedure TCompData.SetSystemColor (pValue: boolean);
begin
  oSystemColor := pValue;
  AddCompFlds('SystemColor');
end;

procedure TCompData.SetBasicColor (pValue: TColor);
begin
  oBasicColor := pValue;
  AddCompFlds('BasicColor');
end;

procedure TCompData.SetCheckColor (pValue: TColor);
begin
  oCheckColor := pValue;
  AddCompFlds('CheckColor');
end;

procedure TCompData.SetMultiLine (pValue: boolean);
begin
  oMultiLine := pValue;
  AddCompFlds('MultiLine');
end;

procedure TCompData.SetBGImage (pValue: string);
begin
  oBGImage := pValue;
  AddCompFlds('BGImage');
end;

procedure TCompData.SetBGStyle (pValue: TxpTabBGStyle);
begin
  oBGStyle := pValue;
  AddCompFlds('BGStyle');
end;

procedure TCompData.SetGradEndColor (pValue: TColor);
begin
  oGradEndColor := pValue;
  AddCompFlds('GradEndColor');
end;

procedure TCompData.SetGradStartColor (pValue: TColor);
begin
  oGradStartColor := pValue;
  AddCompFlds('GradStartColor');
end;

procedure TCompData.SetGradFillDir (pValue: TFillDirection);
begin
  oGradFillDir := pValue;
  AddCompFlds('GradFillDir');
end;

procedure TCompData.SetFontColor (pValue: TColor);
begin
  oFontColor := pValue;
  AddCompFlds('FontColor');
end;

procedure TCompData.SetFontName (pValue: string);
begin
  oFontName := pValue;
  AddCompFlds('FontName');
end;

procedure TCompData.SetFontSize (pValue: longint);
begin
  oFontSize := pValue;
  AddCompFlds('FontSize');
end;

procedure TCompData.SetFontStyle (pValue: TFontStyles);
begin
  oFontStyle := pValue;
  AddCompFlds('FontStyle');
end;

procedure TCompData.SetFontCharset (pValue:TFontCharset);
begin
  oFontCharset := pValue;
  AddCompFlds('FontCharset');
end;

function  TCompData.GetCompType:string;
begin
  Result := oCompType;
end;

function  TCompData.GetParent:string;
begin
  Result := oParent;
end;

function  TCompData.GetLeft (pValue:longint):longint;
begin
  Result := pValue;
  If FindCompFld('Left') then Result := oLeft;
end;

function  TCompData.GetTop (pValue:longint):longint;
begin
  Result := pValue;
  If FindCompFld('Top') then Result := oTop;
end;

function  TCompData.GetHeight (pValue:longint):longint;
begin
  Result := pValue;
  If FindCompFld('Height') then Result := oHeight;
end;

function  TCompData.GetWidth (pValue:longint):longint;
begin
  Result := pValue;
  If FindCompFld('Width') then Result := oWidth;
end;

function  TCompData.GetVisible (pValue:boolean):boolean;
begin
  Result := pValue;
  If FindCompFld('Visible') then Result := oVisible;
end;

function  TCompData.GetEnabled (pValue:boolean):boolean;
begin
  Result := pValue;
  If FindCompFld('Enabled') then Result := oEnabled;
end;

function  TCompData.GetReadOnly (pValue:boolean):boolean;
begin
  Result := pValue;
  If FindCompFld('ReadOnly') then Result := oReadOnly;
end;

function  TCompData.GetTabOrder (pValue:longint):longint;
begin
  Result := pValue;
  If FindCompFld('TabOrder') then Result := oTabOrder;
end;

function  TCompData.GetTabStop (pValue:boolean):boolean;
begin
  Result := pValue;
  If FindCompFld('TabStop') then Result := oTabStop;
end;

function  TCompData.GetAlign (pValue:TAlign):TAlign;
begin
  Result := pValue;
  If FindCompFld('Align') then Result := oAlign;
end;

function  TCompData.GetAlignment (pValue:TAlignment):TAlignment;
begin
  Result := pValue;
  If FindCompFld('Alignment') then Result := oAlignment;
end;

function  TCompData.GetAlignText (pValue:TAlignText):TAlignText;
begin
  Result := pValue;
  If FindCompFld('AlignText') then Result := oAlignText;
end;

function  TCompData.GetAnchors (pValue:TAnchors):TAnchors;
begin
  Result := pValue;
  If FindCompFld('Anchors') then Result := oAnchors;
end;

function  TCompData.GetAutoSize (pValue:boolean):boolean;
begin
  Result := pValue;
  If FindCompFld('AutoSize') then Result := oAutoSize;
end;

function  TCompData.GetCaption (pValue:string):string;
begin
  Result := pValue;
  If FindCompFld('Caption') then Result := oCaption;
end;

function  TCompData.GetLines (pValue:string):string;
begin
  Result := pValue;
  If FindCompFld('Lines') then Result := oLines;
end;

function  TCompData.GetHead (pValue:string):string;
begin
  Result := pValue;
  If FindCompFld('Head') then Result := oHead;
end;

function  TCompData.GetColor (pValue:TColor):TColor;
begin
  Result := pValue;
  If FindCompFld('Color') then Result := oColor;
end;

function  TCompData.GetBorderColor (pValue:TColor):TColor;
begin
  Result := pValue;
  If FindCompFld('BorderColor') then Result := oBorderColor;
end;

function  TCompData.GetGlyph (pValue:string):string;
begin
  Result := pValue;
  If FindCompFld('Glyph') then Result := oGlyph;
end;

function  TCompData.GetButtLayout (pValue:TButtonLayout):TButtonLayout;
begin
  Result := pValue;
  If FindCompFld('ButtLayout') then Result := oButtLayout;
end;

function  TCompData.GetTextLayout (pValue:TTextLayout):TTextLayout;
begin
  Result := pValue;
  If FindCompFld('TextLayout') then Result := oTextLayout;
end;

function  TCompData.GetMaxLength (pValue:longint):longint;
begin
  Result := pValue;
  If FindCompFld('MaxLength') then Result := oMaxLength;
end;

function  TCompData.GetNumSepar (pValue:boolean):boolean;
begin
  Result := pValue;
  If FindCompFld('NumSepar') then Result := oNumSepar;
end;

function  TCompData.GetFrac (pValue:longint):longint;
begin
  Result := pValue;
  If FindCompFld('Frac') then Result := oFrac;
end;

function  TCompData.GetEditorType (pValue:TEditorType):TEditorType;
begin
  Result := pValue;
  If FindCompFld('EditorType') then Result := oEditorType;
end;

function  TCompData.GetExtTextShow (pValue:boolean):boolean;
begin
  Result := pValue;
  If FindCompFld('ExtTextShow') then Result := oExtTextShow;
end;

function  TCompData.GetInfoField (pValue:boolean):boolean;
begin
  Result := pValue;
  If FindCompFld('InfoField') then Result := oInfoField;
end;

function  TCompData.GetTransparent (pValue:boolean):boolean;
begin
  Result := pValue;
  If FindCompFld('Transparent') then Result := oTransparent;
end;

function  TCompData.GetWordWrap (pValue:boolean):boolean;
begin
  Result := pValue;
  If FindCompFld('WordWrap') then Result := oWordWrap;
end;

function  TCompData.GetPageIndex (pValue:longint):longint;
begin
  Result := pValue;
  If FindCompFld('PageIndex') then Result := oPageIndex;
end;

function  TCompData.GetHint (pValue:string):string;
begin
  Result := pValue;
  If FindCompFld('Hint') then Result := oHint;
end;

function  TCompData.GetShowHint (pValue:boolean):boolean;
begin
  Result := pValue;
  If FindCompFld('ShowHint') then Result := oShowHint;
end;

function  TCompData.GetTabsShow (pValue:boolean):boolean;
begin
  Result := pValue;
  If FindCompFld('TabsShow') then Result := oTabsShow;
end;

function  TCompData.GetTabHeight (pValue:longint):longint;
begin
  Result := pValue;
  If FindCompFld('TabHeight') then Result := oTabHeight;
end;

function  TCompData.GetSystemColor (pValue:boolean):boolean;
begin
  Result := pValue;
  If FindCompFld('SystemColor') then Result := oSystemColor;
end;

function  TCompData.GetBasicColor (pValue:TColor):TColor;
begin
  Result := pValue;
  If FindCompFld('BasicColor') then Result := oBasicColor;
end;

function  TCompData.GetCheckColor (pValue:TColor):TColor;
begin
  Result := pValue;
  If FindCompFld('CheckColor') then Result := oCheckColor;
end;

function  TCompData.GetMultiLine (pValue:boolean):boolean;
begin
  Result := pValue;
  If FindCompFld('MultiLine') then Result := oMultiLine;
end;

function  TCompData.GetBGImage (pValue:string):string;
begin
  Result := pValue;
  If FindCompFld('BGImage') then Result := oBGImage;
end;

function  TCompData.GetBGStyle (pValue:TxpTabBGStyle):TxpTabBGStyle;
begin
  Result := pValue;
  If FindCompFld('BGStyle') then Result := oBGStyle;
end;

function  TCompData.GetGradEndColor (pValue:TColor):TColor;
begin
  Result := pValue;
  If FindCompFld('GradEndColor') then Result := oGradEndColor;
end;

function  TCompData.GetGradStartColor (pValue:TColor):TColor;
begin
  Result := pValue;
  If FindCompFld('GradStartColor') then Result := oGradStartColor;
end;

function  TCompData.GetGradFillDir (pValue:TFillDirection):TFillDirection;
begin
  Result := pValue;
  If FindCompFld('GradFillDir') then Result := oGradFillDir;
end;

function  TCompData.GetFontColor (pValue:TColor):TColor;
begin
  Result := pValue;
  If FindCompFld('FontColor') then Result := oFontColor;
end;

function  TCompData.GetFontName (pValue:string):string;
begin
  Result := pValue;
  If FindCompFld('FontName') then Result := oFontName;
end;

function  TCompData.GetFontSize (pValue:longint):longint;
begin
  Result := pValue;
  If FindCompFld('FontSize') then Result := oFontSize;
end;

function  TCompData.GetFontStyle (pValue:TFontStyles):TFontStyles;
begin
  Result := pValue;
  If FindCompFld('FontStyle') then Result := oFontStyle;
end;

function  TCompData.GetFontCharset (pValue:TFontCharset):TFontCharset;
begin
  Result := pValue;
  If FindCompFld('FontCharset') then Result := oFontCharset;
end;

procedure CutNextParam (var pParam,pCom,pVal:string);
begin
  If Pos (zETX,pParam)>0 then begin
    pVal := Copy (pParam,1,Pos (zETX,pParam)-1);
    Delete (pParam,1,Pos (zETX,pParam));
  end else begin
    pVal := pParam;
    pParam := '';
  end;
  pCom := Copy (pVal,1,Pos (zTAB,pVal)-1);
  Delete (pVal,1,Pos (zTAB,pVal));
end;

function  GetParentObj(pMainForm:TForm;pParent:string):TWinControl;
var mParent:TComponent;
begin
  Result := nil;
  If pMainForm.Name=pParent
    then Result := pMainForm
    else begin
      mParent := pMainForm.FindComponent(pParent);
      If mParent<>nil then Result := mParent as TWinControl;
    end;
end;

function  ConvStrToAnchors (pVal:string):TAnchors;
begin
  Result := [];
  If Pos ('akTop',pVal)>0 then Result := Result+[akTop];
  If Pos ('akLeft',pVal)>0 then Result := Result+[akLeft];
  If Pos ('akRight',pVal)>0 then Result := Result+[akRight];
  If Pos ('akBottom',pVal)>0 then Result := Result+[akBottom];
end;

function  ConvAnchorsToStr (pVal:TAnchors):string;
begin
  Result := '';
  If akTop in pVal then Result := Result+'akTop';
  If akLeft in pVal then begin
    If Result<>'' then Result := Result+',';
    Result := Result+'akLeft';
  end;
  If akRight in pVal then begin
    If Result<>'' then Result := Result+',';
    Result := Result+'akRight';
  end;
  If akBottom in pVal then begin
    If Result<>'' then Result := Result+',';
    Result := Result+'akBottom';
  end;
end;

function  ConvStrToAlignText (pVal:string):TAlignText;
begin
  Result := atLeft;
  If pVal='atCenter' then Result := atCenter;
  If pVal='atRight' then Result := atRight;
end;

function  ConvAlignTextToStr (pVal:TAlignText):string;
begin
  Result := 'atLeft';
  If pVal=atCenter then Result := 'atCenter';
  If pVal=atRight then Result := 'atRight';
end;

function  ConvStrToButtonLayout (pVal:string):TButtonLayout;
begin
  Result := blGlyphLeft;
  If pVal='blGlyphRight' then Result := blGlyphRight;
  If pVal='blGlyphTop' then Result := blGlyphTop;
  If pVal='blGlyphBottom' then Result := blGlyphBottom;
end;

function  ConvButtLayoutToStr (pVal:TButtonLayout):string;
begin
  Result := 'blGlyphLeft';
  If pVal=blGlyphRight then Result := 'blGlyphRight';
  If pVal=blGlyphTop then Result := 'blGlyphTop';
  If pVal=blGlyphBottom then Result := 'blGlyphBottom';
end;

function  ConvStrToFontStyle (pVal:string):TFontStyles;
begin
  Result := [];
  If Pos ('fsBold',pVal)>0 then Result := Result+[fsBold];
  If Pos ('fsItalic',pVal)>0 then Result := Result+[fsItalic];
  If Pos ('fsUnderline',pVal)>0 then Result := Result+[fsUnderline];
  If Pos ('fsStrikeOut',pVal)>0 then Result := Result+[fsStrikeOut];
end;

function  ConvFontStyleToStr (pVal:TFontStyles):string;
begin
  Result := '';
  If fsBold in pVal then Result := Result+'fsBold';
  If fsItalic in pVal then begin
    If Result<>'' then Result := Result+',';
    Result := Result+'fsItalic';
  end;
  If fsUnderline in pVal then begin
    If Result<>'' then Result := Result+',';
    Result := Result+'fsUnderline';
  end;
  If fsStrikeOut in pVal then begin
    If Result<>'' then Result := Result+',';
    Result := Result+'fsStrikeOut';
  end;
end;

function  EncodeMultiLnStr (pVal:string):string;
begin
  Result := ReplaceStr (pVal,zCR+zLF,'#13');
end;

function  DecodeMultiLnStr (pVal:string):string;
begin
  Result := ReplaceStr (pVal,'#13',zCR+zLF);
end;

function  ConvStrToTextLayout (pVal:string):TTextLayout;
begin
  Result := tlTop;
  If pVal='tlCenter' then Result := tlCenter;
  If pVal='tlBottom' then Result := tlBottom;
end;

function  ConvTextLayoutToStr (pVal:TTextLayout):string;
begin
  Result := 'tlTop';
  If pVal=tlCenter then Result := 'tlCenter';
  If pVal=tlBottom then Result := 'tlBottom';
end;

function  ConvStrToAlignment (pVal:string):TAlignment;
begin
  Result := taLeftJustify;
  If pVal='taRightJustify' then Result := taRightJustify;
  If pVal='taCenter' then Result := taCenter;
end;

function  ConvAlignmentToStr (pVal:TAlignment):string;
begin
  Result := 'taLeftJustify';
  If pVal=taRightJustify then Result := 'taRightJustify';
  If pVal=taCenter then Result := 'taCenter';
end;

function  ConvStrToAlign (pVal:string):TAlign;
begin
  Result := alNone;
  If pVal='alTop' then Result := alTop;
  If pVal='alBottom' then Result := alBottom;
  If pVal='alLeft' then Result := alLeft;
  If pVal='alRight' then Result := alRight;
  If pVal='alClient' then Result := alClient;
  If pVal='alCustom' then Result := alCustom;
end;

function  ConvAlignToStr (pVal:TAlign):string;
begin
  Result := 'alNone';
  If pVal=alNone then Result := 'alNone';
  If pVal=alTop then Result := 'alTop';
  If pVal=alBottom then Result := 'alBottom';
  If pVal=alLeft then Result := 'alLeft';
  If pVal=alRight then Result := 'alRight';
  If pVal=alClient then Result := 'alClient';
  If pVal=alCustom then Result := 'alCustom';
end;

function  ConvStrToEditorType (pVal:string):TEditorType;
begin
  Result := etString;
  If pVal='etString' then Result := etString;
  If pVal='etInteger' then Result := etInteger;
  If pVal='etFloat' then Result := etFloat;
  If pVal='etDate' then Result := etDate;
  If pVal='etTime' then Result := etTime;
  If pVal='etDateTime' then Result := etDateTime;
end;

function  ConvEditorTypeToStr (pVal:TEditorType):string;
begin
  Result := 'etString';
  If pVal=etString then Result := 'etString';
  If pVal=etInteger then Result := 'etInteger';
  If pVal=etFloat then Result := 'etFloat';
  If pVal=etDate then Result := 'etDate';
  If pVal=etTime then Result := 'etTime';
  If pVal=etDateTime then Result := 'etDateTime';
end;

function  ConvStrToBGStyle (pVal:string):TxpTabBGStyle;
begin
  Result := bgsNone;
  If pVal='bgsNone' then Result := bgsNone;
  If pVal='bgsGradient' then Result := bgsGradient;
  If pVal='bgsTileImage' then Result := bgsTileImage;
  If pVal='bgsStrechImage' then Result := bgsStrechImage;
end;

function  ConvBGStyleToStr (pVal:TxpTabBGStyle):string;
begin
  Result := 'bgsNone';
  If pVal=bgsNone then Result := 'bgsNone';
  If pVal=bgsGradient then Result := 'bgsGradient';
  If pVal=bgsTileImage then Result := 'bgsTileImage';
  If pVal=bgsStrechImage then Result := 'bgsStrechImage';
end;

function  ConvStrToGradFillDir (pVal:string):TFillDirection;
begin
  Result := fdXP;
  If pVal='fdTopToBottom' then Result := fdTopToBottom;
  If pVal='fdBottomToTop' then Result := fdBottomToTop;
  If pVal='fdLeftToRight' then Result := fdLeftToRight;
  If pVal='fdRightToLeft' then Result := fdRightToLeft;
  If pVal='fdVerticalFromCenter' then Result := fdVerticalFromCenter;
  If pVal='fdHorizFromCenter' then Result := fdHorizFromCenter;
  If pVal='fdXP' then Result := fdXP;
  If pVal='fdDown' then Result := fdDown;
end;

function  ConvGradFillDirToStr (pVal:TFillDirection):string;
begin
  Result := 'fdXP';
  If pVal=fdTopToBottom then Result := 'fdTopToBottom';
  If pVal=fdBottomToTop then Result := 'fdBottomToTop';
  If pVal=fdLeftToRight then Result := 'fdLeftToRight';
  If pVal=fdRightToLeft then Result := 'fdRightToLeft';
  If pVal=fdVerticalFromCenter then Result := 'fdVerticalFromCenter';
  If pVal=fdHorizFromCenter then Result := 'fdHorizFromCenter';
  If pVal=fdXP then Result := 'fdXP';
  If pVal=fdDown then Result := 'fdDown';
end;

function  ConvStrToFontCharset (pVal:string):TFontCharset;
begin
  Result := DEFAULT_CHARSET;
  If pVal='ANSI_CHARSET' then Result := ANSI_CHARSET;
  If pVal='DEFAULT_CHARSET' then Result := DEFAULT_CHARSET;
  If pVal='MAC_CHARSET' then Result := MAC_CHARSET;
  If pVal='SHIFTJIS_CHARSET' then Result := SHIFTJIS_CHARSET;
  If pVal='HANGEUL_CHARSET' then Result := HANGEUL_CHARSET;
  If pVal='JOHAB_CHARSET' then Result := JOHAB_CHARSET;
  If pVal='GB2312_CHARSET' then Result := GB2312_CHARSET;
  If pVal='CHINESEBIG5_CHARSET' then Result := CHINESEBIG5_CHARSET;
  If pVal='GREEK_CHARSET' then Result := GREEK_CHARSET;
  If pVal='TURKISH_CHARSET' then Result := TURKISH_CHARSET;
  If pVal='VIETNAMESE_CHARSET' then Result := VIETNAMESE_CHARSET;
  If pVal='HEBREW_CHARSET' then Result := HEBREW_CHARSET;
  If pVal='ARABIC_CHARSET' then Result := ARABIC_CHARSET;
  If pVal='BALTIC_CHARSET' then Result := BALTIC_CHARSET;
  If pVal='RUSSIAN_CHARSET' then Result := RUSSIAN_CHARSET;
  If pVal='THAI_CHARSET' then Result := THAI_CHARSET;
  If pVal='EASTEUROPE_CHARSET' then Result := EASTEUROPE_CHARSET;
  If pVal='OEM_CHARSET' then Result := OEM_CHARSET;
end;

function  ConvFontCharsetToStr (pVal:TFontCharset):string;
begin
  Result := 'DEFAULT_CHARSET';
  If pVal=ANSI_CHARSET then Result := 'ANSI_CHARSET';
  If pVal=DEFAULT_CHARSET then Result := 'DEFAULT_CHARSET';
  If pVal=MAC_CHARSET then Result := 'MAC_CHARSET';
  If pVal=SHIFTJIS_CHARSET then Result := 'SHIFTJIS_CHARSET';
  If pVal=HANGEUL_CHARSET then Result := 'HANGEUL_CHARSET';
  If pVal=JOHAB_CHARSET then Result := 'JOHAB_CHARSET';
  If pVal=GB2312_CHARSET then Result := 'GB2312_CHARSET';
  If pVal=CHINESEBIG5_CHARSET then Result := 'CHINESEBIG5_CHARSET';
  If pVal=GREEK_CHARSET then Result := 'GREEK_CHARSET';
  If pVal=TURKISH_CHARSET then Result := 'TURKISH_CHARSET';
  If pVal=VIETNAMESE_CHARSET then Result := 'VIETNAMESE_CHARSET';
  If pVal=HEBREW_CHARSET then Result := 'HEBREW_CHARSET';
  If pVal=ARABIC_CHARSET then Result := 'ARABIC_CHARSET';
  If pVal=BALTIC_CHARSET then Result := 'BALTIC_CHARSET';
  If pVal=RUSSIAN_CHARSET then Result := 'RUSSIAN_CHARSET';
  If pVal=THAI_CHARSET then Result := 'THAI_CHARSET';
  If pVal=EASTEUROPE_CHARSET then Result := 'EASTEUROPE_CHARSET';
  If pVal=OEM_CHARSET then Result := 'OEM_CHARSET';
end;

function  ConvStrToWindowState (pVal:string):TWindowState;
begin
  Result := wsNormal;
  If pVal='wsMinimized' then Result := wsMinimized;
  If pVal='wsMaximized' then Result := wsMaximized;
end;

function  ConvWindowStateToStr (pVal:TWindowState):string;
begin
  Result := 'wsNormal';
  If pVal=wsMinimized then Result := 'wsMinimized';
  If pVal=wsMaximized then Result := 'wsMaximized';
end;

function  ConvBitmapToHEX (pBitmap:TBitmap):string;
var mStr:string;mStream:TMemoryStream;
begin
  mStr := '';
  mStream := TMemoryStream.Create;
  pBitmap.SaveToStream(mStream);
  If mStream.Size>0 then begin
    SetLength (mStr,mStream.Size*2);
    If Length(mStr)>0 then begin
      BinToHex(PChar(Integer(mStream.Memory)), PChar(mStr),mStream.Size);
    end;
  end;
  FreeAndNil (mStream);
  Result := mStr;
end;

procedure ConvHEXToBitmap (pStr:string;pBitmap:TBitmap);
var mStream:TMemoryStream; mSize:longint;
begin
  If pStr<>'' then begin
    mStream := TMemoryStream.Create;
    mStream.SetSize(Length(pStr) div 2);
    mStream.Position := 0;
    HexToBin(PChar(pStr), PChar(Integer(mStream.Memory)), Length(pStr) div 2);
    mSize := mStream.Size;
    try
      pBitmap.LoadFromStream(mStream);
    except end;
    FreeAndNil (mStream);
  end;
end;

function  GetFormDefFileName (pFile:string;pFormNum:byte):string;
begin
  If pFormNum in [100..199]
    then Result := pFile+'.UFD'
    else Result := pFile+'.SFD';
end;

end.
