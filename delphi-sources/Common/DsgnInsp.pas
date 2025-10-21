unit DsgnInsp;

interface

uses
  DsgnForm, DsgnUtils, IcConv,
  Forms, Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls,
  Dialogs, Grids, StdCtrls, xpComp, ExtCtrls;

type
  TF_DsgnInsp = class(TForm)
    P_CompPanel: TxpSinglePanel;
    CB_CompList: TxpComboBox;
    P_PropPanel: TxpSinglePanel;
    SG_ObjInsp: TStringGrid;
    CB_Prop: TxpComboBox;
    procedure CB_CompListClick(Sender: TObject);
    procedure SG_ObjInspSelectCell(Sender: TObject; ACol, ARow: Integer;
      var CanSelect: Boolean);
    procedure FormCreate(Sender: TObject);
    procedure SG_ObjInspClick(Sender: TObject);
    procedure CB_PropExit(Sender: TObject);
    procedure CB_PropKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure SG_ObjInspExit(Sender: TObject);
    procedure SG_ObjInspKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure SG_ObjInspDrawCell(Sender: TObject; ACol, ARow: Integer;
      Rect: TRect; State: TGridDrawState);
    procedure SG_ObjInspDblClick(Sender: TObject);
    procedure CB_PropClick(Sender: TObject);
  private
    oCBPropKey : word;
    oOldPropCom: string;
    oOldPropVal: string;

    procedure CMDialogKey(var Msg:TCMDialogKey); message CM_DIALOGKEY;
    procedure FillPropCombo (pCommand,pValue:string);
    procedure FillPropComboBool;
    procedure FillPropComboAlign;
    procedure FillPropComboAlignment;
    procedure FillPropComboAlignText;
    procedure FillPropComboButtLayout;
    procedure FillPropComboTextLayout;
    procedure FillPropComboBGStyle;
    procedure FillPropComboGradFillDir;
    procedure FillPropComboGradFontCharset;

    procedure ChangeValueVerify;
    function  GetPropVal (pPropCom:string):string;
    function  GetPropValue (pField,pProp:string):string;

    procedure SetCompVal (pPropCom, pPropVal:string);
    function  CompIsSelected (pComp:TComponent):boolean;
    procedure SetPropTop (pComp:TComponent;pVal:longint);
    procedure SetPropLeft (pComp:TComponent;pVal:longint);
    procedure SetPropHeight (pComp:TComponent;pVal:longint);
    procedure SetPropWidth (pComp:TComponent;pVal:longint);
    procedure SetPropVisible (pComp:TComponent;pVal:boolean);
    procedure SetPropEnabled (pComp:TComponent;pVal:boolean);
    procedure SetPropReadOnly (pComp:TComponent;pVal:boolean);
    procedure SetPropTabOrder (pComp:TComponent;pVal:longint);
    procedure SetPropTabStop (pComp:TComponent;pVal:boolean);
    procedure SetPropTabsShow (pComp:TComponent;pVal:boolean);
    procedure SetPropTabHeight (pComp:TComponent;pVal:longint);
    procedure SetPropAlign (pComp:TComponent;pVal:TAlign);
    procedure SetPropAlignment (pComp:TComponent;pVal:TAlignment);
    procedure SetPropAlignText (pComp:TComponent;pVal:TAlignText);
    procedure SetPropAnchors (pComp:TComponent;pVal:TAnchors);
    procedure SetPropAutoSize (pComp:TComponent;pVal:boolean);
    procedure SetPropCaption (pComp:TComponent;pVal:string);
    procedure SetPropLines (pComp:TComponent;pVal:string);
    procedure SetPropHead (pComp:TComponent;pVal:string);
    procedure SetPropColor (pComp:TComponent;pVal:TColor);
    procedure SetPropBorderColor (pComp:TComponent;pVal:TColor);
    procedure SetPropGlyph (pComp:TComponent;pVal:string);
    procedure SetPropButtLayout (pComp:TComponent;pVal:TButtonLayout);
    procedure SetPropTextLayout (pComp:TComponent;pVal:TTextLayout);
    procedure SetPropMaxLength (pComp:TComponent;pVal:longint);
    procedure SetPropNumSepar (pComp:TComponent;pVal:boolean);
    procedure SetPropFrac (pComp:TComponent;pVal:longint);
    procedure SetPropEditorType (pComp:TComponent;pVal:TEditorType);
    procedure SetPropExtTextShow (pComp:TComponent;pVal:boolean);
    procedure SetPropInfoField (pComp:TComponent;pVal:boolean);
    procedure SetPropTransparent (pComp:TComponent;pVal:boolean);
    procedure SetPropWordWrap (pComp:TComponent;pVal:boolean);
    procedure SetPropPageIndex (pComp:TComponent;pVal:longint);
    procedure SetPropHint (pComp:TComponent;pVal:string);
    procedure SetPropShowHint (pComp:TComponent;pVal:boolean);
    procedure SetPropSystemColor (pComp:TComponent;pVal:boolean);
    procedure SetPropBasicColor (pComp:TComponent;pVal:TColor);
    procedure SetPropCheckColor (pComp:TComponent;pVal:TColor);
    procedure SetPropMultiLine (pComp:TComponent;pVal:boolean);
    procedure SetPropBGImage (pComp:TComponent;pVal:string);
    procedure SetPropBGStyle (pComp:TComponent;pVal:TxpTabBGStyle);
    procedure SetPropGradStartColor (pComp:TComponent;pVal:TColor);
    procedure SetPropGradEndColor (pComp:TComponent;pVal:TColor);
    procedure SetPropGradFillDir (pComp:TComponent;pVal:TFillDirection);
    procedure SetPropFontColor (pComp:TComponent;pVal:TColor);
    procedure SetPropFontName (pComp:TComponent;pVal:string);
    procedure SetPropFontSize (pComp:TComponent;pVal:longint);
    procedure SetPropFontStyle (pComp:TComponent;pVal:TFontStyles);
    procedure SetPropFontCharset (pComp:TComponent;pVal:TFontCharset);

    function  GetFormPropVal (pComp:TForm;pProp:string):string;
    function  GetxpSinglePanelPropVal (pComp:TxpSinglePanel;pProp:string):string;
    function  GetxpGroupBoxPropVal (pComp:TxpGroupBox;pProp:string):string;
    function  GetxpPageControlPropVal (pComp:TxpPageControl;pProp:string):string;
    function  GetxpTabSheetPropVal (pComp:TxpTabSheet;pProp:string):string;
    function  GetxpLabelPropVal (pComp:TxpUniComp;pProp:string):string;
    function  GetxpEditPropVal (pComp:TxpUniComp;pProp:string):string;
    function  GetxpRadioButtonPropVal (pComp:TxpUniComp;pProp:string):string;
    function  GetxpCheckBoxPropVal (pComp:TxpUniComp;pProp:string):string;
    function  GetxpComboBoxPropVal (pComp:TxpUniComp;pProp:string):string;
    function  GetxpButtonPropVal (pComp:TxpUniComp;pProp:string):string;
    function  GetxpMemoPropVal (pComp:TxpUniComp;pProp:string):string;
    function  GetxpRichEditPropVal (pComp:TxpUniComp;pProp:string):string;
    function  GetBasicCompVal (pComp:TxpUniComp;pProp:string):string;

    procedure FillObjInspFirst;
    procedure FillObjInspNext(pField:string);
  public
    oF_DsgnForm  : TF_DsgnForm;

    procedure SetSelectedComp (pCompName:string);
    procedure FillObjInsp;

  end;

  var
    F_DsgnInsp: TF_DsgnInsp;

implementation

uses Types;


{$R *.dfm}

procedure TF_DsgnInsp.CMDialogKey(var Msg:TCMDialogKey);
begin
  If ActiveControl=CB_Prop then begin
    If Msg.CharCode=VK_TAB then begin
      SG_ObjInsp.SetFocus;
      SG_ObjInsp.Perform(WM_KEYDOWN, Msg.CharCode, Msg.KeyData);
      Msg.Result := 1;
      Exit;
    end;
  end;
  inherited;
end;

procedure TF_DsgnInsp.FillPropCombo (pCommand,pValue:string);
begin
  If (pCommand='Visible') or (pCommand='Enabled') or (pCommand='ReadOnly') or (pCommand='SystemColor')
      or (pCommand='ShowHint') or (pCommand='WordWrap') or (pCommand='TabStop') or (pCommand='InfoField')
      or (pCommand='NumSepar') or (pCommand='AutoSize') or (pCommand='ParentFont') or (pCommand='Transparent')
    then FillPropComboBool;
  If (pCommand='Align') then FillPropComboAlign;
  If (pCommand='Alignment') then FillPropComboAlignment;
  If (pCommand='AlignText') then FillPropComboAlignText;
  If (pCommand='ButtLayout') then FillPropComboButtLayout;
  If (pCommand='TextLayout') then FillPropComboTextLayout;
  If (pCommand='BGStyle') then FillPropComboBGStyle;
  If (pCommand='GradFillDir') then FillPropComboGradFillDir;
  If (pCommand='FontCharset') then FillPropComboGradFontCharset;
  CB_Prop.ItemIndex := CB_Prop.Items.IndexOf(pValue);
end;

procedure TF_DsgnInsp.FillPropComboBool;
begin
  CB_Prop.Clear;
  CB_Prop.Items.Add('True');
  CB_Prop.Items.Add('False');
end;

procedure TF_DsgnInsp.FillPropComboAlign;
begin
  CB_Prop.Clear;
  CB_Prop.Items.Add('alNone');
  CB_Prop.Items.Add('alTop');
  CB_Prop.Items.Add('alBottom');
  CB_Prop.Items.Add('alLeft');
  CB_Prop.Items.Add('alRight');
  CB_Prop.Items.Add('alClient');
  CB_Prop.Items.Add('alCustom');
end;

procedure TF_DsgnInsp.FillPropComboAlignment;
begin
  CB_Prop.Clear;
  CB_Prop.Items.Add('taLeftJustify');
  CB_Prop.Items.Add('taCenter');
  CB_Prop.Items.Add('taRightJustify');
end;

procedure TF_DsgnInsp.FillPropComboAlignText;
begin
  CB_Prop.Clear;
  CB_Prop.Items.Add('atLeft');
  CB_Prop.Items.Add('atCenter');
  CB_Prop.Items.Add('atRight');
end;

procedure TF_DsgnInsp.FillPropComboButtLayout;
begin
  CB_Prop.Clear;
  CB_Prop.Items.Add('blGlyphLeft');
  CB_Prop.Items.Add('blGlyphRight');
  CB_Prop.Items.Add('blGlyphTop');
  CB_Prop.Items.Add('blGlyphBottom');
end;

procedure TF_DsgnInsp.FillPropComboTextLayout;
begin
  CB_Prop.Clear;
  CB_Prop.Items.Add('tlTop');
  CB_Prop.Items.Add('tlCenter');
  CB_Prop.Items.Add('tlBottom');
end;

procedure TF_DsgnInsp.FillPropComboBGStyle;
begin
  CB_Prop.Clear;
  CB_Prop.Items.Add('bgsNone');
  CB_Prop.Items.Add('bgsGradient');
  CB_Prop.Items.Add('bgsTileImage');
  CB_Prop.Items.Add('bgsStrechImage');
end;

procedure TF_DsgnInsp.FillPropComboGradFillDir;
begin
  CB_Prop.Clear;
  CB_Prop.Items.Add('fdTopToBottom');
  CB_Prop.Items.Add('fdBottomToTop');
  CB_Prop.Items.Add('fdVerticalFromCenter');
  CB_Prop.Items.Add('fdHorizFromCenter');
  CB_Prop.Items.Add('fdXP');
  CB_Prop.Items.Add('fdDown');
end;

procedure TF_DsgnInsp.FillPropComboGradFontCharset;
begin
  CB_Prop.Clear;
  CB_Prop.Items.Add('DEFAULT_CHARSET');
  CB_Prop.Items.Add('ANSI_CHARSET');
  CB_Prop.Items.Add('MAC_CHARSET');
  CB_Prop.Items.Add('SHIFTJIS_CHARSET');
  CB_Prop.Items.Add('JOHAB_CHARSET');
  CB_Prop.Items.Add('GB2312_CHARSET');
  CB_Prop.Items.Add('CHINESEBIG5_CHARSET');
  CB_Prop.Items.Add('GREEK_CHARSET');
  CB_Prop.Items.Add('TURKISH_CHARSET');
  CB_Prop.Items.Add('VIETNAMESE_CHARSET');
  CB_Prop.Items.Add('HEBREW_CHARSET');
  CB_Prop.Items.Add('ARABIC_CHARSET');
  CB_Prop.Items.Add('BALTIC_CHARSET');
  CB_Prop.Items.Add('RUSSIAN_CHARSET');
  CB_Prop.Items.Add('THAI_CHARSET');
  CB_Prop.Items.Add('EASTEUROPE_CHARSET');
  CB_Prop.Items.Add('OEM_CHARSET');
end;

procedure TF_DsgnInsp.ChangeValueVerify;
var mVal:string; mS:string;
begin
  If oOldPropCom<>'' then begin
    mS := SG_ObjInsp.Cells[0,SG_ObjInsp.Row];
    mVal := GetPropVal (oOldPropCom);
    If oOldPropVal<>mVal then SetCompVal (oOldPropCom, mVal);
    oOldPropVal := mVal;
  end;
end;

function  TF_DsgnInsp.GetPropVal (pPropCom:string):string;
var I:longint;
begin
  Result := '';
  If SG_ObjInsp.RowCount>0 then begin
    For I:=0 to SG_ObjInsp.RowCount-1 do begin
      If pPropCom=SG_ObjInsp.Cells[0,I] then begin
        Result := SG_ObjInsp.Cells[1,I];
        Break;
      end;
    end;
  end;
end;

function  TF_DsgnInsp.GetPropValue (pField,pProp:string):string;
var mComp:TComponent;
begin
  Result := '';
  mComp := oF_DsgnForm.oForm.FindComponent(pField);
  If mComp=nil then mComp := oF_DsgnForm.oForm;
  If mComp<>nil then begin
    If mComp is TForm then Result := GetFormPropVal (mComp as TForm,pProp);
    If mComp is TxpSinglePanel then Result := GetxpSinglePanelPropVal (mComp as TxpSinglePanel,pProp);
    If mComp is TxpGroupBox then Result := GetxpGroupBoxPropVal (mComp as TxpGroupBox,pProp);
    If mComp is TxpPageControl then Result := GetxpPageControlPropVal (mComp as TxpPageControl,pProp);
    If mComp is TxpTabSheet then Result := GetxpTabSheetPropVal (mComp as TxpTabSheet,pProp);
    If mComp is TxpUniComp then begin
      If (mComp as TxpUniComp).CompType=ucLabel then Result := GetxpLabelPropVal (mComp as TxpUniComp,pProp);
      If (mComp as TxpUniComp).CompType=ucEditor then Result := GetxpEditPropVal (mComp as TxpUniComp,pProp);
      If (mComp as TxpUniComp).CompType=ucRadioButton then Result := GetxpRadioButtonPropVal (mComp as TxpUniComp,pProp);
      If (mComp as TxpUniComp).CompType=ucCheckBox then Result := GetxpCheckBoxPropVal (mComp as TxpUniComp,pProp);
      If (mComp as TxpUniComp).CompType=ucComboBox then Result := GetxpComboBoxPropVal (mComp as TxpUniComp,pProp);
      If (mComp as TxpUniComp).CompType=ucButton then Result := GetxpButtonPropVal (mComp as TxpUniComp,pProp);
      If (mComp as TxpUniComp).CompType=ucMemo then Result := GetxpMemoPropVal (mComp as TxpUniComp,pProp);
      If (mComp as TxpUniComp).CompType=ucRichEdit then Result := GetxpRichEditPropVal (mComp as TxpUniComp,pProp);
      If (mComp as TxpUniComp).CompType=ucBasic then Result := GetBasicCompVal (mComp as TxpUniComp,pProp);
    end;
  end;
end;

procedure TF_DsgnInsp.SetCompVal (pPropCom, pPropVal:string);
var I:longint; mComp:TComponent;
begin
  If oF_DsgnForm.oSelCnt=0 then begin
    If pPropCom='Top' then oF_DsgnForm.oForm.Top := ValInt (pPropVal);
    If pPropCom='Left' then oF_DsgnForm.oForm.Left := ValInt (pPropVal);
    If pPropCom='Height' then oF_DsgnForm.oForm.Height := ValInt (pPropVal);
    If pPropCom='Width' then oF_DsgnForm.oForm.Width := ValInt (pPropVal);
    If pPropCom='Caption' then oF_DsgnForm.oForm.Caption := pPropVal;
    If pPropCom='Color' then oF_DsgnForm.oForm.Color := ValInt (pPropVal);
    If pPropCom='Align' then oF_DsgnForm.oForm.Align := ConvStrToAlign (pPropVal);
  end else begin
    If oF_DsgnForm.oForm.ComponentCount>0 then begin
      For I:=0 to oF_DsgnForm.oForm.ComponentCount-1 do begin
        mComp := oF_DsgnForm.oForm.Components[I];
        If CompIsSelected(mComp) then begin
          If pPropVal<>'' then begin
            If pPropCom='Top' then SetPropTop (mComp,ValInt (pPropVal));
            If pPropCom='Left' then SetPropLeft (mComp,ValInt (pPropVal));
            If pPropCom='Height' then SetPropHeight (mComp,ValInt (pPropVal));
            If pPropCom='Width' then SetPropWidth (mComp,ValInt (pPropVal));
          end;
          If pPropCom='Visible' then SetPropVisible (mComp,StrToBool (pPropVal));
          If pPropCom='Enabled' then SetPropEnabled (mComp,StrToBool (pPropVal));
          If pPropCom='ReadOnly' then SetPropReadOnly (mComp,StrToBool (pPropVal));
          If pPropCom='TabOrder' then SetPropTabOrder (mComp,ValInt (pPropVal));
          If pPropCom='TabStop' then SetPropTabStop (mComp,StrToBool (pPropVal));
          If pPropCom='TabsShow' then SetPropTabsShow (mComp,StrToBool (pPropVal));
          If pPropCom='TabHeight' then SetPropTabHeight (mComp,ValInt (pPropVal));
          If pPropCom='Align' then SetPropAlign (mComp,ConvStrToAlign(pPropVal));
          If pPropCom='Alignment' then SetPropAlignment (mComp,ConvStrToAlignment(pPropVal));
          If pPropCom='AlignText' then SetPropAlignText (mComp,ConvStrToAlignText(pPropVal));
          If pPropCom='Anchors' then SetPropAnchors (mComp,ConvStrToAnchors(pPropVal));
          If pPropCom='AutoSize' then SetPropAutoSize (mComp,StrToBool (pPropVal));
          If pPropCom='Caption' then SetPropCaption (mComp,DecodeMultiLnStr (pPropVal));
          If pPropCom='Lines' then SetPropLines (mComp,DecodeMultiLnStr (pPropVal));
          If pPropCom='Head' then SetPropHead (mComp,pPropVal);
          If pPropCom='Color' then SetPropColor (mComp,ValInt (pPropVal));
          If pPropCom='BorderColor' then SetPropBorderColor (mComp,ValInt (pPropVal));
          If pPropCom='Glyph' then SetPropGlyph (mComp,pPropVal);
          If pPropCom='ButtLayout' then SetPropButtLayout (mComp,ConvStrToButtonLayout (pPropVal));
          If pPropCom='TextLayout' then SetPropTextLayout (mComp,ConvStrToTextLayout (pPropVal));
          If pPropCom='MaxLength' then SetPropMaxLength (mComp,ValInt (pPropVal));
          If pPropCom='NumSepar' then SetPropNumSepar (mComp,StrToBool (pPropVal));
          If pPropCom='Frac' then SetPropFrac (mComp,ValInt (pPropVal));
          If pPropCom='EditorType' then SetPropEditorType (mComp,ConvStrToEditorType (pPropVal));
          If pPropCom='ExtTextShow' then SetPropExtTextShow (mComp,StrToBool (pPropVal));
          If pPropCom='InfoField' then SetPropInfoField (mComp,StrToBool (pPropVal));
          If pPropCom='Transparent' then SetPropTransparent (mComp,StrToBool (pPropVal));
          If pPropCom='WordWrap' then SetPropWordWrap (mComp,StrToBool (pPropVal));
          If pPropCom='PageIndex' then SetPropPageIndex (mComp,ValInt (pPropVal));
          If pPropCom='Hint' then SetPropHint (mComp,DecodeMultiLnStr (pPropVal));
          If pPropCom='ShowHint' then SetPropShowHint (mComp,StrToBool (pPropVal));
          If pPropCom='SystemColor' then SetPropSystemColor (mComp,StrToBool (pPropVal));
          If pPropCom='BasicColor' then SetPropBasicColor (mComp,ValInt (pPropVal));
          If pPropCom='CheckColor' then SetPropCheckColor (mComp,ValInt (pPropVal));
          If pPropCom='MultiLine' then SetPropMultiLine (mComp,StrToBool (pPropVal));
          If pPropCom='BGImage' then SetPropBGImage (mComp,pPropVal);
          If pPropCom='BGStyle' then SetPropBGStyle (mComp,ConvStrToBGStyle(pPropVal));
          If pPropCom='GradStartColor' then SetPropGradStartColor (mComp,ValInt (pPropVal));
          If pPropCom='GradEndColor' then SetPropGradEndColor (mComp,ValInt (pPropVal));
          If pPropCom='GradFillDir' then SetPropGradFillDir (mComp,ConvStrToGradFillDir (pPropVal));
          If pPropCom='FontColor' then SetPropFontColor (mComp,ValInt (pPropVal));
          If pPropCom='FontName' then SetPropFontName (mComp,pPropVal);
          If pPropCom='FontSize' then SetPropFontSize (mComp,ValInt (pPropVal));
          If pPropCom='FontStyle' then SetPropFontStyle (mComp,ConvStrToFontStyle (pPropVal));
          If pPropCom='FontCharset' then SetPropFontCharset (mComp,ConvStrToFontCharset (pPropVal));
        end;
      end;
    end;
  end;
end;

function  TF_DsgnInsp.CompIsSelected (pComp:TComponent):boolean;
begin
  Result := FALSE;
  If pComp is TxpUniComp then Result := (pComp as TxpUniComp).Selected;
  If pComp is TxpSinglePanel then Result := (pComp as TxpSinglePanel).Selected;
  If pComp is TxpGroupBox then Result := (pComp as TxpGroupBox).Selected;
  If pComp is TxpPageControl then Result := (pComp as TxpPageControl).Selected;
  If pComp is TxpTabSheet then Result := (pComp as TxpTabSheet).Selected;
end;

procedure TF_DsgnInsp.SetPropTop (pComp:TComponent;pVal:longint);
begin
  If pComp is TWinControl then begin
    If oF_DsgnForm.ParentVerify((pComp as TWinControl).Parent.Name) then (pComp as TWinControl).Top := pVal;
  end;
end;

procedure TF_DsgnInsp.SetPropLeft (pComp:TComponent;pVal:longint);
begin
  If pComp is TWinControl then begin
    If oF_DsgnForm.ParentVerify((pComp as TWinControl).Parent.Name) then (pComp as TWinControl).Left := pVal;
  end;
end;

procedure TF_DsgnInsp.SetPropHeight (pComp:TComponent;pVal:longint);
var mChanged:boolean;
begin
  If pComp is TWinControl then begin
    mChanged := ((pComp as TWinControl).Height = pVal);
    (pComp as TWinControl).Height := pVal;
    If mChanged then FillObjInsp;
  end;
end;

procedure TF_DsgnInsp.SetPropWidth (pComp:TComponent;pVal:longint);
var mChanged:boolean;
begin
  If pComp is TWinControl then begin
    mChanged := ((pComp as TWinControl).Width = pVal);
    (pComp as TWinControl).Width := pVal;
    If mChanged then FillObjInsp;
  end;
end;

procedure TF_DsgnInsp.SetPropVisible (pComp:TComponent;pVal:boolean);
begin
  If pComp is TxpTabSheet
    then (pComp as TxpTabSheet).TabVisible := pVal
    else begin
      If pComp is TWinControl then (pComp as TWinControl).Visible := pVal;
    end;
  oF_DsgnForm.FillHideCompList;
end;

procedure TF_DsgnInsp.SetPropEnabled (pComp:TComponent;pVal:boolean);
begin
  If pComp is TxpSinglePanel then (pComp as TxpSinglePanel).EnabledExt := pVal;
  If pComp is TxpGroupBox then (pComp as TxpGroupBox).EnabledExt := pVal;
  If pComp is TxpPageControl then (pComp as TxpPageControl).EnabledExt := pVal;
  If pComp is TxpTabSheet then (pComp as TxpTabSheet).EnabledExt := pVal;
  If pComp is TxpUniComp then begin
     If (pComp as TxpUniComp).CompType in [ucButton,ucEditor,ucLabel,ucCheckBox,ucComboBox,ucRadioButton,ucMemo,ucRichEdit]
       then (pComp as TxpUniComp).EnabledExt := pVal;
  end;
end;

procedure TF_DsgnInsp.SetPropReadOnly (pComp:TComponent;pVal:boolean);
begin
  If pComp is TxpUniComp then begin
     If (pComp as TxpUniComp).CompType in [ucEditor,ucMemo,ucRichEdit] then begin
      (pComp as TxpUniComp).ReadOnly := pVal;
      (pComp as TWinControl).Repaint;
     end;
  end;
end;

procedure TF_DsgnInsp.SetPropTabOrder (pComp:TComponent;pVal:longint);
begin
  If pComp is TxpSinglePanel then (pComp as TxpSinglePanel).TabOrderExt := pVal;
  If pComp is TxpGroupBox then (pComp as TxpGroupBox).TabOrderExt := pVal;
  If pComp is TxpPageControl then (pComp as TxpPageControl).TabOrderExt := pVal;
  If pComp is TxpUniComp then begin
     If (pComp as TxpUniComp).CompType in [ucButton,ucEditor,ucCheckBox,ucComboBox,ucRadioButton,ucMemo,ucRichEdit]
       then (pComp as TxpUniComp).TabOrderExt := pVal;
  end;
  oF_DsgnForm.RecalcTabOrder ((pComp as TWinControl).Parent.Name,pComp.Name,pVal);
  FillObjInspFirst;
end;

procedure TF_DsgnInsp.SetPropTabStop (pComp:TComponent;pVal:boolean);
begin
  If pComp is TxpSinglePanel then (pComp as TxpSinglePanel).TabStopExt := pVal;
  If pComp is TxpGroupBox then (pComp as TxpGroupBox).TabStopExt := pVal;
  If pComp is TxpPageControl then (pComp as TxpPageControl).TabStopExt := pVal;
  If pComp is TxpUniComp then begin
     If (pComp as TxpUniComp).CompType in [ucButton,ucEditor,ucCheckBox,ucComboBox,ucRadioButton,ucMemo,ucRichEdit]
       then (pComp as TxpUniComp).TabStopExt := pVal;
  end;
end;

procedure TF_DsgnInsp.SetPropTabsShow (pComp:TComponent;pVal:boolean);
begin
  If pComp is TxpPageControl then (pComp as TxpPageControl).TabsShow := pVal;
end;

procedure TF_DsgnInsp.SetPropTabHeight (pComp:TComponent;pVal:longint);
begin
  If pComp is TxpPageControl then (pComp as TxpPageControl).TabHeight := pVal;
end;

procedure TF_DsgnInsp.SetPropAlign (pComp:TComponent;pVal:TAlign);
begin
  If pComp is TxpSinglePanel then (pComp as TxpSinglePanel).Align := pVal;
  If pComp is TxpGroupBox then (pComp as TxpGroupBox).Align := pVal;
  If pComp is TxpPageControl then (pComp as TxpPageControl).Align := pVal;
  If pComp is TxpUniComp then begin
     If (pComp as TxpUniComp).CompType in [ucEditor,ucMemo,ucRichEdit]
       then (pComp as TxpUniComp).Align := pVal;
  end;
  (pComp as TWinControl).Repaint;
end;

procedure TF_DsgnInsp.SetPropAlignment (pComp:TComponent;pVal:TAlignment);
begin
  If pComp is TxpUniComp then begin
     If (pComp as TxpUniComp).CompType in [ucEditor,ucLabel,ucMemo,ucRichEdit]
       then (pComp as TxpUniComp).Alignment := pVal;
  end;
  (pComp as TWinControl).Repaint;
end;

procedure TF_DsgnInsp.SetPropAlignText (pComp:TComponent;pVal:TAlignText);
begin
  If pComp is TxpUniComp then begin
     If (pComp as TxpUniComp).CompType in [ucButton]
       then (pComp as TxpUniComp).AlignText := pVal;
  end;
  (pComp as TWinControl).Repaint;
end;

procedure TF_DsgnInsp.SetPropAnchors (pComp:TComponent;pVal:TAnchors);
begin
  If pComp is TxpSinglePanel then (pComp as TxpSinglePanel).Anchors := pVal;
  If pComp is TxpGroupBox then (pComp as TxpGroupBox).Anchors := pVal;
  If pComp is TxpPageControl then (pComp as TxpPageControl).Anchors := pVal;
  If pComp is TxpUniComp then begin
     If (pComp as TxpUniComp).CompType in [ucButton,ucEditor,ucLabel,ucCheckBox,ucComboBox,ucRadioButton,ucMemo,ucRichEdit]
       then (pComp as TxpUniComp).Anchors := pVal;
  end;
end;

procedure TF_DsgnInsp.SetPropAutoSize (pComp:TComponent;pVal:boolean);
var mW,mH:longint;
begin
  If pComp is TxpUniComp then begin
    If (pComp as TxpUniComp).CompType in [ucLabel] then begin
      mW := (pComp as TxpUniComp).Width;
      mH := (pComp as TxpUniComp).Height;
      (pComp as TxpUniComp).AutoSize := pVal;
      (pComp as TWinControl).Repaint;
      If (mW<>(pComp as TxpUniComp).Width) or (mH<>(pComp as TxpUniComp).Height) then FillObjInsp;
    end;
  end;
end;

procedure TF_DsgnInsp.SetPropCaption (pComp:TComponent;pVal:string);
begin
  pVal := DecodeMultiLnStr (pVal);
  If pComp is TxpGroupBox then (pComp as TxpGroupBox).Caption := pVal;
  If pComp is TxpTabSheet then (pComp as TxpTabSheet).Caption := pVal;
  If pComp is TxpUniComp then begin
     If (pComp as TxpUniComp).CompType in [ucButton,ucLabel,ucCheckBox,ucRadioButton]
       then (pComp as TxpUniComp).Caption := pVal;
  end;
  (pComp as TWinControl).Repaint;
end;

procedure TF_DsgnInsp.SetPropLines (pComp:TComponent;pVal:string);
begin
  pVal := DecodeMultiLnStr (pVal);
  If pComp is TxpUniComp then begin
     If (pComp as TxpUniComp).CompType in [ucComboBox,ucMemo,ucRichEdit]
       then (pComp as TxpUniComp).Lines := pVal;
  end;
  (pComp as TWinControl).Repaint;
end;

procedure TF_DsgnInsp.SetPropHead (pComp:TComponent;pVal:string);
begin
  If pComp is TxpSinglePanel then (pComp as TxpSinglePanel).Head := pVal;
  (pComp as TWinControl).Repaint;
end;

procedure TF_DsgnInsp.SetPropColor (pComp:TComponent;pVal:TColor);
begin
  SetPropSystemColor(pComp,FALSE);
  If pComp is TxpSinglePanel then (pComp as TxpSinglePanel).Color := pVal;
  If pComp is TxpGroupBox then (pComp as TxpGroupBox).Color := pVal;
  If pComp is TxpPageControl then (pComp as TxpPageControl).Color := pVal;
  If pComp is TxpTabSheet then (pComp as TxpTabSheet).Color := pVal;
  If pComp is TxpUniComp then begin
     If (pComp as TxpUniComp).CompType in [ucEditor,ucLabel,ucMemo,ucRichEdit]
       then (pComp as TxpUniComp).Color := pVal;
  end;
  (pComp as TWinControl).Repaint;
end;

procedure TF_DsgnInsp.SetPropBorderColor (pComp:TComponent;pVal:TColor);
begin
  SetPropSystemColor(pComp,FALSE);
  If pComp is TxpSinglePanel then (pComp as TxpSinglePanel).BorderColor := pVal;
  If pComp is TxpGroupBox then (pComp as TxpGroupBox).BorderColor := pVal;
  If pComp is TxpPageControl then (pComp as TxpPageControl).BorderColor := pVal;
  (pComp as TWinControl).Repaint;
end;

procedure TF_DsgnInsp.SetPropGlyph (pComp:TComponent;pVal:string);
begin
  If pComp is TxpUniComp then begin
     If (pComp as TxpUniComp).CompType in [ucButton]
       then ConvHEXToBitmap (pVal,(pComp as TxpUniComp).Glyph);
  end;
  (pComp as TWinControl).Repaint;
end;

procedure TF_DsgnInsp.SetPropButtLayout (pComp:TComponent;pVal:TButtonLayout);
begin
  If pComp is TxpUniComp then begin
     If (pComp as TxpUniComp).CompType in [ucButton]
       then (pComp as TxpUniComp).ButtLayout := pVal;
  end;
  (pComp as TWinControl).Repaint;
end;

procedure TF_DsgnInsp.SetPropTextLayout (pComp:TComponent;pVal:TTextLayout);
begin
  If pComp is TxpUniComp then begin
     If (pComp as TxpUniComp).CompType in [ucLabel]
       then (pComp as TxpUniComp).Layout := pVal;
  end;
  (pComp as TWinControl).Repaint;
end;

procedure TF_DsgnInsp.SetPropMaxLength (pComp:TComponent;pVal:longint);
begin
  If pComp is TxpUniComp then begin
     If (pComp as TxpUniComp).CompType in [ucEditor,ucComboBox,ucMemo,ucRichEdit]
       then (pComp as TxpUniComp).MaxLength := pVal;
  end;
end;

procedure TF_DsgnInsp.SetPropNumSepar (pComp:TComponent;pVal:boolean);
begin
  If pComp is TxpUniComp then begin
     If (pComp as TxpUniComp).CompType in [ucEditor]
       then (pComp as TxpUniComp).NumSepar := pVal;
  end;
  (pComp as TWinControl).Repaint;
end;

procedure TF_DsgnInsp.SetPropFrac (pComp:TComponent;pVal:longint);
begin
  If pComp is TxpUniComp then begin
     If (pComp as TxpUniComp).CompType in [ucEditor] then begin
       (pComp as TxpUniComp).Frac := pVal;
       (pComp as TxpUniComp).Repaint;
     end;
  end;
end;

procedure TF_DsgnInsp.SetPropEditorType (pComp:TComponent;pVal:TEditorType);
begin
  If pComp is TxpUniComp then begin
     If (pComp as TxpUniComp).CompType in [ucEditor] then begin
       (pComp as TxpUniComp).EditorType := pVal;
       (pComp as TxpUniComp).Repaint;
     end;
  end;
end;

procedure TF_DsgnInsp.SetPropExtTextShow (pComp:TComponent;pVal:boolean);
begin
  If pComp is TxpUniComp then begin
     If (pComp as TxpUniComp).CompType in [ucEditor] then begin
       (pComp as TxpUniComp).ExtTextShow := pVal;
       (pComp as TxpUniComp).Repaint;
     end;
  end;
end;

procedure TF_DsgnInsp.SetPropInfoField (pComp:TComponent;pVal:boolean);
begin
  If pComp is TxpUniComp then begin
     If (pComp as TxpUniComp).CompType in [ucEditor] then begin
       (pComp as TxpUniComp).InfoField := pVal;
       (pComp as TWinControl).Repaint;
     end;
  end;
end;

procedure TF_DsgnInsp.SetPropTransparent (pComp:TComponent;pVal:boolean);
begin
  If pComp is TxpUniComp then begin
     If (pComp as TxpUniComp).CompType in [ucLabel]
       then (pComp as TxpUniComp).Transparent := pVal;
  end;
  (pComp as TWinControl).Repaint;
end;

procedure TF_DsgnInsp.SetPropWordWrap (pComp:TComponent;pVal:boolean);
begin
  If pComp is TxpUniComp then begin
     If (pComp as TxpUniComp).CompType in [ucButton,ucEditor,ucLabel,ucCheckBox,ucComboBox,ucRadioButton,ucMemo,ucRichEdit]
       then (pComp as TxpUniComp).WordWrap := pVal;
  end;
end;

procedure TF_DsgnInsp.SetPropPageIndex (pComp:TComponent;pVal:longint);
begin
  If pComp is TxpTabSheet then (pComp as TxpTabSheet).PageIndex := pVal;
end;

procedure TF_DsgnInsp.SetPropHint (pComp:TComponent;pVal:string);
begin
  pVal := DecodeMultiLnStr (pVal);
  If pComp is TxpSinglePanel then (pComp as TxpSinglePanel).HintExt := pVal;
  If pComp is TxpGroupBox then (pComp as TxpGroupBox).HintExt := pVal;
  If pComp is TxpPageControl then (pComp as TxpPageControl).HintExt := pVal;
  If pComp is TxpTabSheet then (pComp as TxpTabSheet).HintExt := pVal;
  If pComp is TxpUniComp then begin
     If (pComp as TxpUniComp).CompType in [ucButton,ucEditor,ucLabel,ucCheckBox,ucComboBox,ucRadioButton,ucMemo,ucRichEdit]
       then (pComp as TxpUniComp).HintExt := pVal;
  end;
end;

procedure TF_DsgnInsp.SetPropShowHint (pComp:TComponent;pVal:boolean);
begin
  If pComp is TxpSinglePanel then (pComp as TxpSinglePanel).ShowHintExt := pVal;
  If pComp is TxpGroupBox then (pComp as TxpGroupBox).ShowHintExt := pVal;
  If pComp is TxpPageControl then (pComp as TxpPageControl).ShowHintExt := pVal;
  If pComp is TxpTabSheet then (pComp as TxpTabSheet).ShowHintExt := pVal;
  If pComp is TxpUniComp then begin
     If (pComp as TxpUniComp).CompType in [ucButton,ucEditor,ucLabel,ucCheckBox,ucComboBox,ucRadioButton,ucMemo,ucRichEdit]
       then (pComp as TxpUniComp).ShowHintExt := pVal;
  end;
end;

procedure TF_DsgnInsp.SetPropSystemColor (pComp:TComponent;pVal:boolean);
var mChanged:boolean;
begin
  mChanged := FALSE;
  If pComp is TxpSinglePanel then begin
    mChanged := (pComp as TxpSinglePanel).SystemColor<>pVal;
    (pComp as TxpSinglePanel).SystemColor := pVal;
  end;
  If pComp is TxpGroupBox then begin
    mChanged := (pComp as TxpGroupBox).SystemColor<>pVal;
    (pComp as TxpGroupBox).SystemColor := pVal;
  end;
  If pComp is TxpPageControl then begin
     mChanged := (pComp as TxpPageControl).SystemColor<>pVal;
    (pComp as TxpPageControl).SystemColor := pVal;
  end;
  If pComp is TxpTabSheet then begin
    mChanged := (pComp as TxpTabSheet).SystemColor<>pVal;
    (pComp as TxpTabSheet).SystemColor := pVal;
  end;
  If pComp is TxpUniComp then begin
     If (pComp as TxpUniComp).CompType in [ucButton,ucEditor,ucLabel,ucCheckBox,ucComboBox,ucRadioButton,ucMemo,ucRichEdit] then begin
       mChanged := (pComp as TxpUniComp).SystemColor<>pVal;
       (pComp as TxpUniComp).SystemColor := pVal;
     end;
  end;
  (pComp as TWinControl).Repaint;
  If mChanged then FillObjInsp;
end;

procedure TF_DsgnInsp.SetPropBasicColor (pComp:TComponent;pVal:TColor);
begin
  SetPropSystemColor(pComp,FALSE);
  If pComp is TxpSinglePanel then (pComp as TxpSinglePanel).BasicColor := pVal;
  If pComp is TxpGroupBox then (pComp as TxpGroupBox).BasicColor := pVal;
  If pComp is TxpPageControl then (pComp as TxpPageControl).BasicColor := pVal;
  If pComp is TxpTabSheet then (pComp as TxpTabSheet).BasicColor := pVal;
  If pComp is TxpUniComp then begin
     If (pComp as TxpUniComp).CompType in [ucButton,ucEditor,ucCheckBox,ucComboBox,ucRadioButton,ucMemo,ucRichEdit]
       then (pComp as TxpUniComp).BasicColor := pVal;
  end;
  (pComp as TWinControl).Repaint;
end;

procedure TF_DsgnInsp.SetPropCheckColor (pComp:TComponent;pVal:TColor);
begin
  If pComp is TxpUniComp then begin
     If (pComp as TxpUniComp).CompType in [ucCheckBox,ucRadioButton] then begin
       SetPropSystemColor(pComp,FALSE);
       (pComp as TxpUniComp).CheckColor := pVal;
       (pComp as TWinControl).Repaint;
     end;
  end;
end;

procedure TF_DsgnInsp.SetPropMultiLine (pComp:TComponent;pVal:boolean);
begin
  If pComp is TxpPageControl then (pComp as TxpPageControl).MultiLine := pVal;
end;

procedure TF_DsgnInsp.SetPropBGImage (pComp:TComponent;pVal:string);
begin
  If pComp is TxpSinglePanel then ConvHEXToBitmap (pVal,(pComp as TxpSinglePanel).BGImage);
  If pComp is TxpTabSheet then ConvHEXToBitmap (pVal,(pComp as TxpTabSheet).BGImage);
  (pComp as TWinControl).Repaint;
end;

procedure TF_DsgnInsp.SetPropBGStyle (pComp:TComponent;pVal:TxpTabBGStyle);
begin
  If pComp is TxpSinglePanel then (pComp as TxpSinglePanel).BGStyle := pVal;
  If pComp is TxpTabSheet then (pComp as TxpTabSheet).BGStyle := pVal;
  (pComp as TWinControl).Repaint;
end;

procedure TF_DsgnInsp.SetPropGradStartColor (pComp:TComponent;pVal:TColor);
begin
  SetPropSystemColor(pComp,FALSE);
  If pComp is TxpSinglePanel then (pComp as TxpSinglePanel).GradStartColor := pVal;
  If pComp is TxpTabSheet then (pComp as TxpTabSheet).GradientStartColor := pVal;
  (pComp as TWinControl).Repaint;
end;

procedure TF_DsgnInsp.SetPropGradEndColor (pComp:TComponent;pVal:TColor);
begin
  SetPropSystemColor(pComp,FALSE);
  If pComp is TxpSinglePanel then (pComp as TxpSinglePanel).GradEndColor := pVal;
  If pComp is TxpTabSheet then (pComp as TxpTabSheet).GradientEndColor := pVal;
  (pComp as TWinControl).Repaint;
end;

procedure TF_DsgnInsp.SetPropGradFillDir (pComp:TComponent;pVal:TFillDirection);
begin
  If pComp is TxpSinglePanel then (pComp as TxpSinglePanel).GradFillDir := pVal;
  If pComp is TxpTabSheet then (pComp as TxpTabSheet).GradientFillDir := pVal;
end;

procedure TF_DsgnInsp.SetPropFontColor (pComp:TComponent;pVal:TColor);
begin
  SetPropSystemColor(pComp,FALSE);
  If pComp is TxpSinglePanel then (pComp as TxpSinglePanel).Font.Color := pVal;
  If pComp is TxpGroupBox then (pComp as TxpGroupBox).Font.Color := pVal;
  If pComp is TxpPageControl then (pComp as TxpPageControl).Font.Color := pVal;
  If pComp is TxpTabSheet then (pComp as TxpTabSheet).Font.Color := pVal;
  If pComp is TxpUniComp then begin
     If (pComp as TxpUniComp).CompType in [ucButton,ucEditor,ucLabel,ucCheckBox,ucComboBox,ucRadioButton,ucMemo,ucRichEdit]
       then (pComp as TxpUniComp).Font.Color := pVal;
  end;
  (pComp as TWinControl).Repaint;
end;

procedure TF_DsgnInsp.SetPropFontName (pComp:TComponent;pVal:string);
begin
  If pComp is TxpSinglePanel then (pComp as TxpSinglePanel).Font.Name := pVal;
  If pComp is TxpGroupBox then (pComp as TxpGroupBox).Font.Name := pVal;
  If pComp is TxpPageControl then (pComp as TxpPageControl).Font.Name := pVal;
  If pComp is TxpTabSheet then (pComp as TxpTabSheet).Font.Name := pVal;
  If pComp is TxpUniComp then begin
     If (pComp as TxpUniComp).CompType in [ucButton,ucEditor,ucLabel,ucCheckBox,ucComboBox,ucRadioButton,ucMemo,ucRichEdit]
       then (pComp as TxpUniComp).Font.Name := pVal;
  end;
  (pComp as TWinControl).Repaint;
end;

procedure TF_DsgnInsp.SetPropFontSize (pComp:TComponent;pVal:longint);
begin
  If pComp is TxpSinglePanel then (pComp as TxpSinglePanel).Font.Size := pVal;
  If pComp is TxpGroupBox then (pComp as TxpGroupBox).Font.Size := pVal;
  If pComp is TxpPageControl then (pComp as TxpPageControl).Font.Size := pVal;
  If pComp is TxpTabSheet then (pComp as TxpTabSheet).Font.Size := pVal;
  If pComp is TxpUniComp then begin
     If (pComp as TxpUniComp).CompType in [ucButton,ucEditor,ucLabel,ucCheckBox,ucComboBox,ucRadioButton,ucMemo,ucRichEdit]
       then (pComp as TxpUniComp).Font.Size := pVal;
  end;
  (pComp as TWinControl).Repaint;
end;

procedure TF_DsgnInsp.SetPropFontStyle (pComp:TComponent;pVal:TFontStyles);
begin
  If pComp is TxpSinglePanel then (pComp as TxpSinglePanel).Font.Style := pVal;
  If pComp is TxpGroupBox then (pComp as TxpGroupBox).Font.Style := pVal;
  If pComp is TxpPageControl then (pComp as TxpPageControl).Font.Style := pVal;
  If pComp is TxpTabSheet then (pComp as TxpTabSheet).Font.Style := pVal;
  If pComp is TxpUniComp then begin
     If (pComp as TxpUniComp).CompType in [ucButton,ucEditor,ucLabel,ucCheckBox,ucComboBox,ucRadioButton,ucMemo,ucRichEdit]
       then (pComp as TxpUniComp).Font.Style := pVal;
  end;
  (pComp as TWinControl).Repaint;
end;

procedure TF_DsgnInsp.SetPropFontCharset (pComp:TComponent;pVal:TFontCharset);
begin
  If pComp is TxpSinglePanel then (pComp as TxpSinglePanel).Font.Charset := pVal;
  If pComp is TxpGroupBox then (pComp as TxpGroupBox).Font.Charset := pVal;
  If pComp is TxpPageControl then (pComp as TxpPageControl).Font.Charset := pVal;
  If pComp is TxpTabSheet then (pComp as TxpTabSheet).Font.Charset := pVal;
  If pComp is TxpUniComp then begin
     If (pComp as TxpUniComp).CompType in [ucButton,ucEditor,ucLabel,ucCheckBox,ucComboBox,ucRadioButton,ucMemo,ucRichEdit]
       then (pComp as TxpUniComp).Font.Charset := pVal;
  end;
  (pComp as TWinControl).Repaint;
end;

function  TF_DsgnInsp.GetFormPropVal (pComp:TForm;pProp:string):string;
begin
  Result := '';
  If pProp='Left' then Result := StrInt (pComp.Left,0);
  If pProp='Top' then Result := StrInt (pComp.Top,0);
  If pProp='Height' then Result := StrInt (pComp.Height,0);
  If pProp='Width' then Result := StrInt (pComp.Width,0);
  If pProp='Align' then Result := ConvAlignToStr (pComp.Align);
  If pProp='Caption' then Result := pComp.Caption;
  If pProp='Color' then Result := StrInt (pComp.Color,0);
end;

function  TF_DsgnInsp.GetxpSinglePanelPropVal (pComp:TxpSinglePanel;pProp:string):string;
begin
  Result := '';
  If pProp='Left' then Result := StrInt (pComp.Left,0);
  If pProp='Top' then Result := StrInt (pComp.Top,0);
  If pProp='Height' then Result := StrInt (pComp.Height,0);
  If pProp='Width' then Result := StrInt (pComp.Width,0);
  If pProp='Visible' then Result := BoolToStr (pComp.Visible,TRUE);
  If pProp='Enabled' then Result := BoolToStr (pComp.EnabledExt,TRUE);
  If pProp='Align' then Result := ConvAlignToStr (pComp.Align);
  If pProp='Anchors' then Result := ConvAnchorsToStr (pComp.Anchors);
  If pProp='Head' then Result := pComp.Head;
  If pProp='Hint' then Result := EncodeMultiLnStr (pComp.HintExt);
  If pProp='ShowHint' then Result := BoolToStr (pComp.ShowHintExt,TRUE);
  If pProp='TabOrder' then Result := StrInt (pComp.TabOrderExt,0);
  If pProp='TabStop' then Result := BoolToStr (pComp.TabStopExt,TRUE);
  If pProp='SystemColor' then Result := BoolToStr (pComp.SystemColor,TRUE);
  If pProp='BasicColor' then Result := StrInt (pComp.BasicColor,0);
  If pProp='Color' then Result := StrInt (pComp.Color,0);
  If pProp='BorderColor' then Result := StrInt (pComp.BorderColor,0);
  If pProp='BGImage' then Result := ConvBitmapToHEX (pComp.BGImage);
  If pProp='BGStyle' then Result := ConvBGStyleToStr (pComp.BGStyle);
  If pProp='GradStartColor' then Result := StrInt (pComp.GradStartColor,0);
  If pProp='GradEndColor' then Result := StrInt (pComp.GradEndColor,0);
  If pProp='GradFillDir' then Result := ConvGradFillDirToStr (pComp.GradFillDir);
  If pProp='FontColor' then Result := StrInt (pComp.Font.Color,0);
  If pProp='FontName' then Result := pComp.Font.Name;
  If pProp='FontSize' then Result := StrInt (pComp.Font.Size,0);
  If pProp='FontStyle' then Result :=  ConvFontStyleToStr (pComp.Font.Style);
  If pProp='FontCharset' then Result :=  ConvFontCharsetToStr (pComp.Font.Charset);
end;

function  TF_DsgnInsp.GetxpGroupBoxPropVal (pComp:TxpGroupBox;pProp:string):string;
begin
  Result := '';
  If pProp='Left' then Result := StrInt (pComp.Left,0);
  If pProp='Top' then Result := StrInt (pComp.Top,0);
  If pProp='Height' then Result := StrInt (pComp.Height,0);
  If pProp='Width' then Result := StrInt (pComp.Width,0);
  If pProp='Visible' then Result := BoolToStr (pComp.Visible,TRUE);
  If pProp='Enabled' then Result := BoolToStr (pComp.EnabledExt,TRUE);
  If pProp='Align' then Result := ConvAlignToStr (pComp.Align);
  If pProp='Anchors' then Result := ConvAnchorsToStr (pComp.Anchors);
  If pProp='Caption' then Result := EncodeMultiLnStr (pComp.Caption);
  If pProp='Hint' then Result := EncodeMultiLnStr (pComp.HintExt);
  If pProp='ShowHint' then Result := BoolToStr (pComp.ShowHintExt,TRUE);
  If pProp='TabOrder' then Result := StrInt (pComp.TabOrderExt,0);
  If pProp='TabStop' then Result := BoolToStr (pComp.TabStopExt,TRUE);
  If pProp='SystemColor' then Result := BoolToStr (pComp.SystemColor,TRUE);
  If pProp='BasicColor' then Result := StrInt (pComp.BasicColor,0);
  If pProp='Color' then Result := StrInt (pComp.Color,0);
  If pProp='BorderColor' then Result := StrInt (pComp.BorderColor,0);
  If pProp='FontColor' then Result := StrInt (pComp.Font.Color,0);
  If pProp='FontName' then Result := pComp.Font.Name;
  If pProp='FontSize' then Result := StrInt (pComp.Font.Size,0);
  If pProp='FontStyle' then Result :=  ConvFontStyleToStr (pComp.Font.Style);
  If pProp='FontCharset' then Result :=  ConvFontCharsetToStr (pComp.Font.Charset);
end;

function  TF_DsgnInsp.GetxpPageControlPropVal (pComp:TxpPageControl;pProp:string):string;
begin
  Result := '';
  If pProp='Left' then Result := StrInt (pComp.Left,0);
  If pProp='Top' then Result := StrInt (pComp.Top,0);
  If pProp='Height' then Result := StrInt (pComp.Height,0);
  If pProp='Width' then Result := StrInt (pComp.Width,0);
  If pProp='Visible' then Result := BoolToStr (pComp.Visible,TRUE);
  If pProp='Enabled' then Result := BoolToStr (pComp.EnabledExt,TRUE);
  If pProp='Align' then Result := ConvAlignToStr (pComp.Align);
  If pProp='Anchors' then Result := ConvAnchorsToStr (pComp.Anchors);
  If pProp='Hint' then Result := EncodeMultiLnStr (pComp.HintExt);
  If pProp='ShowHint' then Result := BoolToStr (pComp.ShowHintExt,TRUE);
  If pProp='TabOrder' then Result := StrInt (pComp.TabOrderExt,0);
  If pProp='TabStop' then Result := BoolToStr (pComp.TabStopExt,TRUE);
  If pProp='TabsShow' then Result := BoolToStr (pComp.TabsShow,TRUE);
  If pProp='TabHeight' then Result := StrInt (pComp.TabHeight,0);
  If pProp='MultiLine' then Result := BoolToStr (pComp.MultiLine,TRUE);
  If pProp='SystemColor' then Result := BoolToStr (pComp.SystemColor,TRUE);
  If pProp='BasicColor' then Result := StrInt (pComp.BasicColor,0);
  If pProp='Color' then Result := StrInt (pComp.Color,0);
  If pProp='BorderColor' then Result := StrInt (pComp.BorderColor,0);
  If pProp='FontColor' then Result := StrInt (pComp.Font.Color,0);
  If pProp='FontName' then Result := pComp.Font.Name;
  If pProp='FontSize' then Result := StrInt (pComp.Font.Size,0);
  If pProp='FontStyle' then Result :=  ConvFontStyleToStr (pComp.Font.Style);
  If pProp='FontCharset' then Result :=  ConvFontCharsetToStr (pComp.Font.Charset);
end;

function  TF_DsgnInsp.GetxpTabSheetPropVal (pComp:TxpTabSheet;pProp:string):string;
begin
  Result := '';
  If pProp='Left' then Result := StrInt (pComp.Left,0);
  If pProp='Top' then Result := StrInt (pComp.Top,0);
  If pProp='Height' then Result := StrInt (pComp.Height,0);
  If pProp='Width' then Result := StrInt (pComp.Width,0);
  If pProp='Visible' then Result := BoolToStr (pComp.TabVisible,TRUE);
  If pProp='Enabled' then Result := BoolToStr (pComp.EnabledExt,TRUE);
  If pProp='Caption' then Result := EncodeMultiLnStr (pComp.Caption);
  If pProp='PageIndex' then Result := StrInt (pComp.PageIndex,0);
  If pProp='Hint' then Result := EncodeMultiLnStr (pComp.HintExt);
  If pProp='ShowHint' then Result := BoolToStr (pComp.ShowHintExt,TRUE);
  If pProp='SystemColor' then Result := BoolToStr (pComp.SystemColor,TRUE);
  If pProp='BasicColor' then Result := StrInt (pComp.BasicColor,0);
  If pProp='Color' then Result := StrInt (pComp.Color,0);
  If pProp='BGImage' then Result := ConvBitmapToHEX (pComp.BGImage);
  If pProp='BGStyle' then Result := ConvBGStyleToStr (pComp.BGStyle);
  If pProp='GradStartColor' then Result := StrInt (pComp.GradientStartColor,0);
  If pProp='GradEndColor' then Result := StrInt (pComp.GradientEndColor,0);
  If pProp='GradFillDir' then Result := ConvGradFillDirToStr (pComp.GradientFillDir);
  If pProp='FontColor' then Result := StrInt (pComp.Font.Color,0);
  If pProp='FontName' then Result := pComp.Font.Name;
  If pProp='FontSize' then Result := StrInt (pComp.Font.Size,0);
  If pProp='FontStyle' then Result :=  ConvFontStyleToStr (pComp.Font.Style);
  If pProp='FontCharset' then Result :=  ConvFontCharsetToStr (pComp.Font.Charset);
end;

function  TF_DsgnInsp.GetxpLabelPropVal (pComp:TxpUniComp;pProp:string):string;
begin
  Result := '';
  If pProp='Left' then Result := StrInt (pComp.Left,0);
  If pProp='Top' then Result := StrInt (pComp.Top,0);
  If pProp='Height' then Result := StrInt (pComp.Height,0);
  If pProp='Width' then Result := StrInt (pComp.Width,0);
  If pProp='Visible' then Result := BoolToStr (pComp.Visible,TRUE);
  If pProp='Enabled' then Result := BoolToStr (pComp.EnabledExt,TRUE);
  If pProp='Align' then Result := ConvAlignToStr (pComp.Align);
  If pProp='Alignment' then Result := ConvAlignmentToStr (pComp.Alignment);
  If pProp='Anchors' then Result := ConvAnchorsToStr (pComp.Anchors);
  If pProp='AutoSize' then Result := BoolToStr (pComp.AutoSize,TRUE);
  If pProp='TextLayout' then Result := ConvTextLayoutToStr (pComp.Layout);
  If pProp='Hint' then Result := EncodeMultiLnStr (pComp.HintExt);
  If pProp='ShowHint' then Result := BoolToStr (pComp.ShowHintExt,TRUE);
  If pProp='Transparent' then Result := BoolToStr (pComp.Transparent,TRUE);
  If pProp='WordWrap' then Result := BoolToStr (pComp.WordWrap,TRUE);
  If pProp='Caption' then Result := EncodeMultiLnStr (pComp.Caption);
  If pProp='SystemColor' then Result := BoolToStr (pComp.SystemColor,TRUE);
  If pProp='Color' then Result := StrInt (pComp.Color,0);
  If pProp='FontColor' then Result := StrInt (pComp.Font.Color,0);
  If pProp='FontName' then Result := pComp.Font.Name;
  If pProp='FontSize' then Result := StrInt (pComp.Font.Size,0);
  If pProp='FontStyle' then Result :=  ConvFontStyleToStr (pComp.Font.Style);
  If pProp='FontCharset' then Result :=  ConvFontCharsetToStr (pComp.Font.Charset);
end;

function  TF_DsgnInsp.GetxpEditPropVal (pComp:TxpUniComp;pProp:string):string;
begin
  Result := '';
  If pProp='Left' then Result := StrInt (pComp.Left,0);
  If pProp='Top' then Result := StrInt (pComp.Top,0);
  If pProp='Height' then Result := StrInt (pComp.Height,0);
  If pProp='Width' then Result := StrInt (pComp.Width,0);
  If pProp='Visible' then Result := BoolToStr (pComp.Visible,TRUE);
  If pProp='Enabled' then Result := BoolToStr (pComp.EnabledExt,TRUE);
  If pProp='ReadOnly' then Result := BoolToStr (pComp.ReadOnly,TRUE);
  If pProp='Anchors' then Result := ConvAnchorsToStr (pComp.Anchors);
  If pProp='Alignment' then Result := ConvAlignmentToStr (pComp.Alignment);
  If pProp='Align' then Result := ConvAlignToStr (pComp.Align);
  If pProp='Hint' then Result := EncodeMultiLnStr (pComp.HintExt);
  If pProp='ShowHint' then Result := BoolToStr (pComp.ShowHintExt,TRUE);
  If pProp='TabOrder' then Result := StrInt (pComp.TabOrderExt,0);
  If pProp='TabStop' then Result := BoolToStr (pComp.TabStopExt,TRUE);
  If pProp='MaxLength' then Result := StrInt (pComp.MaxLength,0);
  If pProp='NumSepar' then Result := BoolToStr (pComp.NumSepar,TRUE);
  If pProp='Frac' then Result := StrInt (pComp.Frac,0);
  If pProp='EditorType' then Result := ConvEditorTypeToStr (pComp.EditorType);
  If pProp='ExtTextShow' then Result := BoolToStr (pComp.ExtTextShow,TRUE);
  If pProp='SystemColor' then Result := BoolToStr (pComp.SystemColor,TRUE);
  If pProp='BasicColor' then Result := StrInt (pComp.BasicColor,0);
  If pProp='Color' then Result := StrInt (pComp.Color,0);
  If pProp='InfoField' then Result := BoolToStr (pComp.InfoField,TRUE);
  If pProp='FontColor' then Result := StrInt (pComp.Font.Color,0);
  If pProp='FontName' then Result := pComp.Font.Name;
  If pProp='FontSize' then Result := StrInt (pComp.Font.Size,0);
  If pProp='FontStyle' then Result :=  ConvFontStyleToStr (pComp.Font.Style);
  If pProp='FontCharset' then Result :=  ConvFontCharsetToStr (pComp.Font.Charset);
end;

function  TF_DsgnInsp.GetxpRadioButtonPropVal (pComp:TxpUniComp;pProp:string):string;
begin
  Result := '';
  If pProp='Left' then Result := StrInt (pComp.Left,0);
  If pProp='Top' then Result := StrInt (pComp.Top,0);
  If pProp='Height' then Result := StrInt (pComp.Height,0);
  If pProp='Width' then Result := StrInt (pComp.Width,0);
  If pProp='Visible' then Result := BoolToStr (pComp.Visible,TRUE);
  If pProp='Enabled' then Result := BoolToStr (pComp.EnabledExt,TRUE);
  If pProp='Anchors' then Result := ConvAnchorsToStr (pComp.Anchors);
  If pProp='Caption' then Result := EncodeMultiLnStr (pComp.Caption);
  If pProp='Hint' then Result := EncodeMultiLnStr (pComp.HintExt);
  If pProp='ShowHint' then Result := BoolToStr (pComp.ShowHintExt,TRUE);
  If pProp='TabOrder' then Result := StrInt (pComp.TabOrderExt,0);
  If pProp='TabStop' then Result := BoolToStr (pComp.TabStopExt,TRUE);
  If pProp='SystemColor' then Result := BoolToStr (pComp.SystemColor,TRUE);
  If pProp='BasicColor' then Result := StrInt (pComp.BasicColor,0);
  If pProp='CheckColor' then Result := StrInt (pComp.CheckColor,0);
  If pProp='FontColor' then Result := StrInt (pComp.Font.Color,0);
  If pProp='FontName' then Result := pComp.Font.Name;
  If pProp='FontSize' then Result := StrInt (pComp.Font.Size,0);
  If pProp='FontStyle' then Result :=  ConvFontStyleToStr (pComp.Font.Style);
  If pProp='FontCharset' then Result :=  ConvFontCharsetToStr (pComp.Font.Charset);
end;

function  TF_DsgnInsp.GetxpCheckBoxPropVal (pComp:TxpUniComp;pProp:string):string;
begin
  Result := '';
  If pProp='Left' then Result := StrInt (pComp.Left,0);
  If pProp='Top' then Result := StrInt (pComp.Top,0);
  If pProp='Height' then Result := StrInt (pComp.Height,0);
  If pProp='Width' then Result := StrInt (pComp.Width,0);
  If pProp='Visible' then Result := BoolToStr (pComp.Visible,TRUE);
  If pProp='Enabled' then Result := BoolToStr (pComp.EnabledExt,TRUE);
  If pProp='Anchors' then Result := ConvAnchorsToStr (pComp.Anchors);
  If pProp='Caption' then Result := EncodeMultiLnStr (pComp.Caption);
  If pProp='Hint' then Result := EncodeMultiLnStr (pComp.HintExt);
  If pProp='ShowHint' then Result := BoolToStr (pComp.ShowHintExt,TRUE);
  If pProp='TabOrder' then Result := StrInt (pComp.TabOrderExt,0);
  If pProp='TabStop' then Result := BoolToStr (pComp.TabStopExt,TRUE);
  If pProp='SystemColor' then Result := BoolToStr (pComp.SystemColor,TRUE);
  If pProp='BasicColor' then Result := StrInt (pComp.BasicColor,0);
  If pProp='CheckColor' then Result := StrInt (pComp.CheckColor,0);
  If pProp='FontColor' then Result := StrInt (pComp.Font.Color,0);
  If pProp='FontName' then Result := pComp.Font.Name;
  If pProp='FontSize' then Result := StrInt (pComp.Font.Size,0);
  If pProp='FontStyle' then Result :=  ConvFontStyleToStr (pComp.Font.Style);
  If pProp='FontCharset' then Result :=  ConvFontCharsetToStr (pComp.Font.Charset);
end;

function  TF_DsgnInsp.GetxpComboBoxPropVal (pComp:TxpUniComp;pProp:string):string;
begin
  Result := '';
  If pProp='Left' then Result := StrInt (pComp.Left,0);
  If pProp='Top' then Result := StrInt (pComp.Top,0);
  If pProp='Height' then Result := StrInt (pComp.Height,0);
  If pProp='Width' then Result := StrInt (pComp.Width,0);
  If pProp='Visible' then Result := BoolToStr (pComp.Visible,TRUE);
  If pProp='Enabled' then Result := BoolToStr (pComp.EnabledExt,TRUE);
  If pProp='Anchors' then Result := ConvAnchorsToStr (pComp.Anchors);
  If pProp='Hint' then Result := EncodeMultiLnStr (pComp.HintExt);
  If pProp='ShowHint' then Result := BoolToStr (pComp.ShowHintExt,TRUE);
  If pProp='TabOrder' then Result := StrInt (pComp.TabOrderExt,0);
  If pProp='TabStop' then Result := BoolToStr (pComp.TabStopExt,TRUE);
  If pProp='Lines' then Result := EncodeMultiLnStr (pComp.Lines);
  If pProp='MaxLength' then Result := StrInt (pComp.MaxLength,0);
  If pProp='SystemColor' then Result := BoolToStr (pComp.SystemColor,TRUE);
  If pProp='BasicColor' then Result := StrInt (pComp.BasicColor,0);
  If pProp='Color' then Result := StrInt (pComp.Color,0);
  If pProp='FontColor' then Result := StrInt (pComp.Font.Color,0);
  If pProp='FontName' then Result := pComp.Font.Name;
  If pProp='FontSize' then Result := StrInt (pComp.Font.Size,0);
  If pProp='FontStyle' then Result :=  ConvFontStyleToStr (pComp.Font.Style);
  If pProp='FontCharset' then Result :=  ConvFontCharsetToStr (pComp.Font.Charset);
end;

function  TF_DsgnInsp.GetxpButtonPropVal (pComp:TxpUniComp;pProp:string):string;
begin
  Result := '';
  If pProp='Left' then Result := StrInt (pComp.Left,0);
  If pProp='Top' then Result := StrInt (pComp.Top,0);
  If pProp='Height' then Result := StrInt (pComp.Height,0);
  If pProp='Width' then Result := StrInt (pComp.Width,0);
  If pProp='Visible' then Result := BoolToStr (pComp.Visible,TRUE);
  If pProp='Enabled' then Result := BoolToStr (pComp.EnabledExt,TRUE);
  If pProp='Anchors' then Result := ConvAnchorsToStr (pComp.Anchors);
  If pProp='Caption' then Result := EncodeMultiLnStr (pComp.Caption);
  If pProp='AlignText' then Result := ConvAlignTextToStr (pComp.AlignText);
  If pProp='Hint' then Result := EncodeMultiLnStr (pComp.HintExt);
  If pProp='ShowHint' then Result := BoolToStr (pComp.ShowHintExt,TRUE);
  If pProp='TabOrder' then Result := StrInt (pComp.TabOrderExt,0);
  If pProp='TabStop' then Result := BoolToStr (pComp.TabStopExt,TRUE);
  If pProp='SystemColor' then Result := BoolToStr (pComp.SystemColor,TRUE);
  If pProp='BasicColor' then Result := StrInt (pComp.BasicColor,0);
  If pProp='ButtLayout' then Result := ConvButtLayoutToStr (pComp.ButtLayout);
  If pProp='Glyph' then Result := ConvBitmapToHEX (pComp.Glyph);
  If pProp='FontColor' then Result := StrInt (pComp.Font.Color,0);
  If pProp='FontName' then Result := pComp.Font.Name;
  If pProp='FontSize' then Result := StrInt (pComp.Font.Size,0);
  If pProp='FontStyle' then Result :=  ConvFontStyleToStr (pComp.Font.Style);
  If pProp='FontCharset' then Result :=  ConvFontCharsetToStr (pComp.Font.Charset);
end;

function  TF_DsgnInsp.GetxpMemoPropVal (pComp:TxpUniComp;pProp:string):string;
begin
  Result := '';
  If pProp='Left' then Result := StrInt (pComp.Left,0);
  If pProp='Top' then Result := StrInt (pComp.Top,0);
  If pProp='Height' then Result := StrInt (pComp.Height,0);
  If pProp='Width' then Result := StrInt (pComp.Width,0);
  If pProp='Visible' then Result := BoolToStr (pComp.Visible,TRUE);
  If pProp='Enabled' then Result := BoolToStr (pComp.EnabledExt,TRUE);
  If pProp='ReadOnly' then Result := BoolToStr (pComp.ReadOnly,TRUE);
  If pProp='Align' then Result := ConvAlignToStr (pComp.Align);
  If pProp='Alignment' then Result := ConvAlignmentToStr (pComp.Alignment);
  If pProp='Anchors' then Result := ConvAnchorsToStr (pComp.Anchors);
  If pProp='Hint' then Result := EncodeMultiLnStr (pComp.HintExt);
  If pProp='ShowHint' then Result := BoolToStr (pComp.ShowHintExt,TRUE);
  If pProp='TabOrder' then Result := StrInt (pComp.TabOrderExt,0);
  If pProp='TabStop' then Result := BoolToStr (pComp.TabStopExt,TRUE);
  If pProp='Lines' then Result := EncodeMultiLnStr (pComp.Lines);
  If pProp='MaxLength' then Result := StrInt (pComp.MaxLength,0);
  If pProp='WordWrap' then Result := BoolToStr (pComp.WordWrap,TRUE);
  If pProp='SystemColor' then Result := BoolToStr (pComp.SystemColor,TRUE);
  If pProp='BasicColor' then Result := StrInt (pComp.BasicColor,0);
  If pProp='Color' then Result := StrInt (pComp.Color,0);
  If pProp='FontColor' then Result := StrInt (pComp.Font.Color,0);
  If pProp='FontName' then Result := pComp.Font.Name;
  If pProp='FontSize' then Result := StrInt (pComp.Font.Size,0);
  If pProp='FontStyle' then Result :=  ConvFontStyleToStr (pComp.Font.Style);
  If pProp='FontCharset' then Result :=  ConvFontCharsetToStr (pComp.Font.Charset);
end;

function  TF_DsgnInsp.GetxpRichEditPropVal (pComp:TxpUniComp;pProp:string):string;
begin
  Result := '';
  If pProp='Left' then Result := StrInt (pComp.Left,0);
  If pProp='Top' then Result := StrInt (pComp.Top,0);
  If pProp='Height' then Result := StrInt (pComp.Height,0);
  If pProp='Width' then Result := StrInt (pComp.Width,0);
  If pProp='Visible' then Result := BoolToStr (pComp.Visible,TRUE);
  If pProp='Enabled' then Result := BoolToStr (pComp.EnabledExt,TRUE);
  If pProp='ReadOnly' then Result := BoolToStr (pComp.ReadOnly,TRUE);
  If pProp='Align' then Result := ConvAlignToStr (pComp.Align);
  If pProp='Alignment' then Result := ConvAlignmentToStr (pComp.Alignment);
  If pProp='Anchors' then Result := ConvAnchorsToStr (pComp.Anchors);
  If pProp='Hint' then Result := EncodeMultiLnStr (pComp.HintExt);
  If pProp='ShowHint' then Result := BoolToStr (pComp.ShowHintExt,TRUE);
  If pProp='TabOrder' then Result := StrInt (pComp.TabOrderExt,0);
  If pProp='TabStop' then Result := BoolToStr (pComp.TabStopExt,TRUE);
  If pProp='Lines' then Result := EncodeMultiLnStr (pComp.Lines);
  If pProp='MaxLength' then Result := StrInt (pComp.MaxLength,0);
  If pProp='WordWrap' then Result := BoolToStr (pComp.WordWrap,TRUE);
  If pProp='SystemColor' then Result := BoolToStr (pComp.SystemColor,TRUE);
  If pProp='BasicColor' then Result := StrInt (pComp.BasicColor,0);
  If pProp='Color' then Result := StrInt (pComp.Color,0);
  If pProp='FontColor' then Result := StrInt (pComp.Font.Color,0);
  If pProp='FontName' then Result := pComp.Font.Name;
  If pProp='FontSize' then Result := StrInt (pComp.Font.Size,0);
  If pProp='FontStyle' then Result :=  ConvFontStyleToStr (pComp.Font.Style);
  If pProp='FontCharset' then Result :=  ConvFontCharsetToStr (pComp.Font.Charset);
end;

function  TF_DsgnInsp.GetBasicCompVal (pComp:TxpUniComp;pProp:string):string;
begin
  Result := '';
  If pProp='Left' then Result := StrInt (pComp.Left,0);
  If pProp='Top' then Result := StrInt (pComp.Top,0);
  If pProp='Height' then Result := StrInt (pComp.Height,0);
  If pProp='Width' then Result := StrInt (pComp.Width,0);
  If pProp='Visible' then Result := BoolToStr (pComp.Visible,TRUE);
  If pProp='Align' then Result := ConvAlignToStr (pComp.Align);
end;

procedure TF_DsgnInsp.FillObjInspFirst;
var mCnt:longint; mS,mField,mProps:string;
begin
  mField := oF_DsgnForm.oFirstSelComp;
  mProps := oF_DsgnForm.oDefCompList.Values[mField];
  mCnt := 0;
  Repeat
    If Pos (';',mProps)>0 then begin
      mS := Copy (mProps,1,Pos (';',mProps)-1);
      Delete (mProps,1,Pos (';',mProps));
    end else begin
      mS := mProps;
      mProps := '';
    end;
    If (mS<>'') and (mS<>'Parent') then begin
      SG_ObjInsp.Cells[0,mCnt] := mS;
      SG_ObjInsp.Cells[1,mCnt] := GetPropValue (mField,mS);
      Inc (mCnt);
    end;
  until (mProps='');
  SG_ObjInsp.RowCount := mCnt;
end;

procedure TF_DsgnInsp.FillObjInspNext(pField:string);
var mCnt,I:longint; mS,mProps:string;
begin
  mCnt := 0;
  mProps := oF_DsgnForm.oDefCompList.Values[pField];
  While (mCnt<=SG_ObjInsp.RowCount-1) do begin
    If (Pos (SG_ObjInsp.Cells[0,mCnt],mProps)>0) and (SG_ObjInsp.Cells[0,mCnt]<>'TabOrder') then begin
      If SG_ObjInsp.Cells[1,mCnt]<>'' then begin
        If SG_ObjInsp.Cells[1,mCnt]<>GetPropValue (pField,SG_ObjInsp.Cells[0,mCnt])
          then SG_ObjInsp.Cells[1,mCnt] := '';
      end;
      Inc (mCnt);
    end else begin
      If mCnt<SG_ObjInsp.RowCount then begin
        For I:=mCnt to SG_ObjInsp.RowCount-2 do begin
          SG_ObjInsp.Cells[0,I] := SG_ObjInsp.Cells[0,I+1];
          SG_ObjInsp.Cells[1,I] := SG_ObjInsp.Cells[1,I+1];
        end;
      end;
      SG_ObjInsp.RowCount := SG_ObjInsp.RowCount-1;
    end;
  end;
end;

procedure TF_DsgnInsp.SetSelectedComp (pCompName:string);
begin
  oOldPropCom := '';
  oOldPropVal := '';
  If (pCompName='') or (oF_DsgnForm.oSelCnt>1)
    then CB_CompList.ItemIndex := -1
    else CB_CompList.ItemIndex := CB_CompList.GetItemIndex(pCompName);
end;

procedure TF_DsgnInsp.FillObjInsp;
var I,mRow:longint; mOldProp:string;
begin
  mOldProp := SG_ObjInsp.Cells[0,SG_ObjInsp.Row];
  CB_Prop.Visible := FALSE;
//  If Visible then SG_ObjInsp.SetFocus;
  SG_ObjInsp.Row := 0;
  FillObjInspFirst;
  If oF_DsgnForm.oSelCnt>1 then begin
    For I:=0 to oF_DsgnForm.oForm.ComponentCount-1 do begin
      If oF_DsgnForm.CompIsSelected(oF_DsgnForm.oForm.Components[I])
        then FillObjInspNext(oF_DsgnForm.oForm.Components[I].Name);
    end;
  end;
  mRow := 0;
  For I:=0 to SG_ObjInsp.RowCount-1 do begin
    If mOldProp=SG_ObjInsp.Cells[0,I] then begin
      mRow := I;
      Break;
    end;
  end;
  SG_ObjInsp.Row := mRow;
  SG_ObjInsp.Col := 0;  //Umelo vyvolat udalost SelectCell
end;

procedure TF_DsgnInsp.CB_CompListClick(Sender: TObject);
begin
  If CB_CompList.ItemIndex>-1 then oF_DsgnForm.SetCompSelectByName (CB_CompList.Text);
end;

procedure TF_DsgnInsp.SG_ObjInspSelectCell(Sender: TObject; ACol,
  ARow: Integer; var CanSelect: Boolean);
var Rect:TRect; Point:TPoint; mCom:string;
begin
  CB_Prop.Clear;
  ChangeValueVerify;
  If ACol=0 then ACol := 1;
  mCom := SG_ObjInsp.Cells[0,ARow];
  If (mCom='Glyph') or (mCom='BGImage') or (mCom='Anchors') or (mCom='FontStyle')
    or (mCom='EditorType') or (mCom='ExtTextShow')
    then SG_ObjInsp.Options := SG_ObjInsp.Options-[goEditing]
    else SG_ObjInsp.Options := SG_ObjInsp.Options+[goEditing];
  If (ACol = 1) then begin
    oOldPropCom := SG_ObjInsp.Cells[0,ARow];
    oOldPropVal := SG_ObjInsp.Cells[1,ARow];
    If (mCom='Visible') or (mCom='Enabled') or (mCom='ReadOnly') or (mCom='SystemColor')
      or (mCom='ShowHint') or (mCom='WordWrap') or (mCom='TabStop') or (mCom='InfoField')
      or (mCom='NumSepar') or (mCom='AutoSize') or (mCom='ParentFont') or (mCom='Transparent')
      or (mCom='Align') or (mCom='Alignment') or (mCom='AlignText') or (mCom='ButtLayout')
      or (mCom='TextLayout') or (mCom='BGStyle') or (mCom='GradFillDir') or (mCom='FontCharset')
      then begin
      Perform(WM_CANCELMODE, 0, 0);
      Rect := SG_ObjInsp.CellRect(ACol, ARow);
      Point := Self.ScreenToClient(SG_ObjInsp.ClientToScreen(Rect.TopLeft));
      Point.X := Point.X-P_PropPanel.Left;
      Point.Y := Point.Y-P_PropPanel.Top-1;
      CB_Prop.SetBounds(Point.X, Point.Y, Rect.Right-Rect.Left, Rect.Bottom-Rect.Top);
      FillPropCombo (SG_ObjInsp.Cells[0,ARow],SG_ObjInsp.Cells[1,ARow]);
      CB_Prop.Show;
      CB_Prop.BringToFront;
      CB_Prop.SetFocus;
      CB_Prop.DroppedDown := FALSE;
    end;
  end;
end;

procedure TF_DsgnInsp.FormCreate(Sender: TObject);
begin
  CB_Prop.Visible := FALSE;
  SG_ObjInsp.Col := 1;
  oCBPropKey := 0;
  oOldPropCom := '';
  oOldPropVal := '';
end;

procedure TF_DsgnInsp.SG_ObjInspClick(Sender: TObject);
begin
  If SG_ObjInsp.Col = 0 then SG_ObjInsp.Col := 1;
  oOldPropCom := SG_ObjInsp.Cells[0,SG_ObjInsp.Row];
  oOldPropVal := SG_ObjInsp.Cells[1,SG_ObjInsp.Row];
end;

procedure TF_DsgnInsp.CB_PropExit(Sender: TObject);
begin
  CB_Prop.Visible := FALSE;
  If CB_Prop.ItemIndex>=0 then begin
    SG_ObjInsp.Cells[SG_ObjInsp.Col, SG_ObjInsp.Row] := CB_Prop.Items[CB_Prop.ItemIndex];
    ChangeValueVerify;
  end;
  SG_ObjInsp.SetFocus;
  If oCBPropKey=VK_UP then begin
    If SG_ObjInsp.Row>0 then SG_ObjInsp.Row := SG_ObjInsp.Row-1;
  end;
  If oCBPropKey=VK_DOWN then begin
    If SG_ObjInsp.Row<SG_ObjInsp.RowCount-1
      then SG_ObjInsp.Row := SG_ObjInsp.Row+1
      else SG_ObjInsp.Col := 0;
  end;
  CB_Prop.Clear;
  oCBPropKey := 0;
end;

procedure TF_DsgnInsp.CB_PropKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  oCBPropKey := 0;
  If (Key=VK_UP) or (Key=VK_DOWN) then begin
    oCBPropKey := Key;
    SG_ObjInsp.Options := SG_ObjInsp.Options-[goEditing];
    SG_ObjInsp.Repaint;
  end;
  If (Key=VK_RETURN) then begin
    If CB_Prop.ItemIndex>=0
      then SG_ObjInsp.Cells[SG_ObjInsp.Col, SG_ObjInsp.Row] := CB_Prop.Items[CB_Prop.ItemIndex];
    ChangeValueVerify;
    oOldPropCom := SG_ObjInsp.Cells[0,SG_ObjInsp.Row];
    oOldPropVal := SG_ObjInsp.Cells[1,SG_ObjInsp.Row];
    Key := 0;
  end;
end;

procedure TF_DsgnInsp.SG_ObjInspExit(Sender: TObject);
begin
  ChangeValueVerify;
end;

procedure TF_DsgnInsp.SG_ObjInspKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  If Key=VK_ESCAPE then SG_ObjInsp.Cells[1,SG_ObjInsp.Row] := oOldPropVal;
  If Key=VK_RETURN then begin
    ChangeValueVerify;
    SG_ObjInsp.EditorMode := FALSE;
    SG_ObjInsp.EditorMode := TRUE;
    SG_ObjInsp.Refresh;
    oOldPropCom := SG_ObjInsp.Cells[0,SG_ObjInsp.Row];
    oOldPropVal := SG_ObjInsp.Cells[1,SG_ObjInsp.Row];
  end;
end;

procedure TF_DsgnInsp.SG_ObjInspDrawCell(Sender: TObject; ACol,
  ARow: Integer; Rect: TRect; State: TGridDrawState);
var mColor,mPrevColor:TColor;mRect:TRect; mGlyph:string; mHeight:longint;
begin
  If (ACol=1) then begin
    If (SG_ObjInsp.Cells[0,ARow]='Color') or (SG_ObjInsp.Cells[0,ARow]='BorderColor')
      or (SG_ObjInsp.Cells[0,ARow]='BasicColor') or (SG_ObjInsp.Cells[0,ARow]='CheckColor')
      or (SG_ObjInsp.Cells[0,ARow]='GradEndColor') or (SG_ObjInsp.Cells[0,ARow]='GradStartColor')
      or (SG_ObjInsp.Cells[0,ARow]='FontColor') then begin
      mColor := ValInt (SG_ObjInsp.Cells[1,ARow]);
      mPrevColor := SG_ObjInsp.Canvas.Brush.Color;
      SG_ObjInsp.Canvas.FillRect(Rect);
      If SG_ObjInsp.Cells[1,ARow]<>'' then begin
        SetRect(mRect,Rect.Left+2,Rect.Top+2,Rect.Left+2+Rect.Bottom-Rect.Top-4,Rect.Bottom-2);
        SG_ObjInsp.Canvas.Brush.Color := mColor;
        SG_ObjInsp.Canvas.FillRect(mRect);
        SG_ObjInsp.Canvas.Brush.Color := clBlack;
        SG_ObjInsp.Canvas.FrameRect(mRect);
        SG_ObjInsp.Canvas.Brush.Color := mPrevColor;
      end;
    end;
    If (SG_ObjInsp.Cells[0,ARow]='Glyph') or (SG_ObjInsp.Cells[0,ARow]='BGImage') then begin
      mColor := ValInt (SG_ObjInsp.Cells[1,ARow]);
      SG_ObjInsp.Canvas.FillRect(Rect);
      SetRect(mRect,Rect.Left+2,Rect.Top+2,Rect.Left+2+Rect.Bottom-Rect.Top-4,Rect.Bottom-2);
      mGlyph := SG_ObjInsp.Cells[1,ARow];
      If mGlyph<>'' then begin
        If SG_ObjInsp.Canvas.Brush.Bitmap=nil then SG_ObjInsp.Canvas.Brush.Bitmap := TBitmap.Create;
        ConvHEXToBitmap (mGlyph,SG_ObjInsp.Canvas.Brush.Bitmap);
        mHeight := Rect.Bottom-Rect.Top-4;
        If (SG_ObjInsp.Cells[0,ARow]='Glyph') then begin
          StretchBitmapTransparent(SG_ObjInsp.Canvas,SG_ObjInsp.Canvas.Brush.Bitmap,
            SG_ObjInsp.Canvas.Brush.Bitmap.Canvas.Pixels[0,SG_ObjInsp.Canvas.Brush.Bitmap.Height-1],Rect.Left+2,Rect.Top+2,mHeight,mHeight,0,0,SG_ObjInsp.Canvas.Brush.Bitmap.Height,SG_ObjInsp.Canvas.Brush.Bitmap.Width);
        end else begin
          StretchBitmapTransparent(SG_ObjInsp.Canvas,SG_ObjInsp.Canvas.Brush.Bitmap,
            clNone,Rect.Left+2,Rect.Top+2,mHeight,mHeight,0,0,SG_ObjInsp.Canvas.Brush.Bitmap.Height,SG_ObjInsp.Canvas.Brush.Bitmap.Width);
        end;
      end;
    end;
  end;
end;

procedure TF_DsgnInsp.SG_ObjInspDblClick(Sender: TObject);
var mProp:string; mCD:TColorDialog;
begin
  If (SG_ObjInsp.Col=1) then begin
    mProp := SG_ObjInsp.Cells[0,SG_ObjInsp.Row];
    If (mProp='Color') or (mProp='BasicColor') or (mProp='FontColor')
      or (mProp='BorderColor') or (mProp='CheckColor') or (mProp='GradEndColor')
      or (mProp='GradStartColor') then begin
        mCD := TColorDialog.Create(Self);
        mCD.Color := ValInt (SG_ObjInsp.Cells[1,SG_ObjInsp.Row]);
        If mCD.Execute then begin
          SG_ObjInsp.Cells[1,SG_ObjInsp.Row] := StrInt (mCD.Color,0);
          SG_ObjInsp.Col := 0;
        end;
        FreeAndNil (mCD);
      end;
  end;
end;

procedure TF_DsgnInsp.CB_PropClick(Sender: TObject);
begin
  If CB_Prop.ItemIndex>=0
    then SG_ObjInsp.Cells[SG_ObjInsp.Col, SG_ObjInsp.Row] := CB_Prop.Items[CB_Prop.ItemIndex];
  ChangeValueVerify;
  oOldPropCom := SG_ObjInsp.Cells[0,SG_ObjInsp.Row];
  oOldPropVal := SG_ObjInsp.Cells[1,SG_ObjInsp.Row];
end;

end.
