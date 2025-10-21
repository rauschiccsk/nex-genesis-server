unit LangForm;

interface

uses
//  XPMenu,
  IcTypes, IcTools, IcVariab, IcConv, IcStand, IcText,
  NexLang, NexText, NexPath, NexIni, TxtWrap, TxtCut, IniHand,
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  IcEditors, IcInfoFields, NwEditors, ComCtrls, StdCtrls, ExtCtrls;

const
  cEdit = 1;  //Rezim editovania
  cView = 2;  //Rezim  prezerania
type
  TLangForm = class(TForm)
//    XPMenu1: TXPMenu;
    procedure AfterConstruction; override;
    procedure BeforeDestruction; override;
  private
    oFirst: boolean;   // ci prvy krat bol volany Show
    oAccept: boolean;  // TRUE ak bol stlacen7 OK button alebo ENTER
    oFormType: byte;   // Typ formulara - cEdit alebo cView
    procedure SaveFormPos; // Ulozi umiestnenie a velkost formulara
    procedure LoadFormPos; // Nacita umiestnenie a velkost formulara
  published
    constructor Create(AOwner: TComponent); override;
    procedure Loaded; override;
    procedure FormClear;
    procedure FormEnable;
    procedure FormDisable;
  public
    procedure ShowModal (pFormType:byte); overload;
    procedure PrevField; // Premiestni SetFocus na predch8dzaj[ce pole podla poradia TabOrder
    procedure NextField; // Premiestni SetFocus na nasledujuce pole podla poradia TabOrder
    property Accept:boolean read oAccept write oAccept;
    property FormType:byte read oFormType;
  end;

var
  LangForm1: TLangForm;

implementation

uses  xpComp, NexEditors, NwSelectEdit;

{$R *.DFM}

constructor TlangForm.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  Scaled := FALSE;
  Font.Size := 10;
  oFirst := TRUE;
  oAccept := FALSE;
  oFormType := cEdit;
end;

procedure TLangForm.AfterConstruction;
var mI,mJ:integer;mName:string;
begin
  If oFirst then begin
    Scaled := FALSE;
    If gvSys.Language<>'SK' then LoadFormText (Self,Name);
    If (Position=poDesigned) and (WindowState=wsNormal) then LoadFormPos;
    oFirst := FALSE;
//    XPMenu1.Active := TRUE; // FileExists(gpath.SysPath+'xpmenu.ini') ;
//    XPMenu1.AutoDetect := TRUE; // FileExists(gpath.SysPath+'xpmenu.ini');
  end;
(*
    If Components[mI] is TLabel then begin
      If Pos('€',(Components[mI] as TLabel).Caption)>0 then (Components[mI] as TLabel).Caption:=ReplaceStr((Components[mI] as TLabel).Caption,'€',ctIntCoin);
    end;
*)
  For mI := 0 to ComponentCount-1 do begin
    mName := Components[mI].ClassName;
    If Components[mI] is TLabel then begin
      If Pos('€',(Components[mI] as TLabel).Caption)>0 then (Components[mI] as TLabel).Caption:=ReplaceStr((Components[mI] as TLabel).Caption,'€',ctIntCoin);
    end;
    If Components[mI] is TCombobox then begin
      for mJ:=0 to (Components[mI] as TCombobox).Items.Count-1 do
        If Pos('€',(Components[mI] as TCombobox).Items[mJ])>0
          then (Components[mI] as TCombobox).Items[mJ]:=ReplaceStr((Components[mI] as TCombobox).Items[mJ],'€',ctIntCoin);
      If Pos('€',(Components[mI] as TCombobox).Text)>0 then (Components[mI] as TCombobox).Text:=ReplaceStr((Components[mI] as TCombobox).Text,'€',ctIntCoin);
    end;
    If Components[mI] is TxpCombobox then begin
      for mJ:=0 to (Components[mI] as TxpCombobox).Items.Count-1 do
        If Pos('€',(Components[mI] as TxpCombobox).Items[mJ])>0
          then (Components[mI] as TxpCombobox).Items[mJ]:=ReplaceStr((Components[mI] as TxpCombobox).Items[mJ],'€',ctIntCoin);
      If Pos('€',(Components[mI] as TxpCombobox).Text)>0 then (Components[mI] as TxpCombobox).Text:=ReplaceStr((Components[mI] as TxpCombobox).Text,'€',ctIntCoin);
    end;
    If Components[mI] is TComboEdit then begin
      If Pos('€',(Components[mI] as TComboEdit).BefText)>0 then (Components[mI] as TComboEdit).BefText:=ReplaceStr((Components[mI] as TComboEdit).BefText,'€',ctIntCoin);
    end;
    If Components[mI] is TNwValueEdit then begin
      If Pos('€',(Components[mI] as TNwValueEdit).Extend)>0 then (Components[mI] as TNwValueEdit).Extend:=ReplaceStr((Components[mI] as TNwValueEdit).Extend,'€',ctIntCoin);
    end;
    If Components[mI] is TValueEdit then begin
      If Pos('€',(Components[mI] as TValueEdit).Extend)>0 then (Components[mI] as TValueEdit).Extend:=ReplaceStr((Components[mI] as TValueEdit).Extend,'€',ctIntCoin);
      If Pos('€',(Components[mI] as TValueEdit).SpecText)>0 then (Components[mI] as TValueEdit).SpecText:=ReplaceStr((Components[mI] as TValueEdit).SpecText,'€',ctIntCoin);
    end;
    If Components[mI] is TPriceEdit then begin
      If Pos('€',(Components[mI] as TPriceEdit).IntCoin)>0 then (Components[mI] as TPriceEdit).IntCoin:=ReplaceStr((Components[mI] as TPriceEdit).IntCoin,'€',ctIntCoin);
      If Pos('€',(Components[mI] as TPriceEdit).Extend)>0 then (Components[mI] as TPriceEdit).Extend:=ReplaceStr((Components[mI] as TPriceEdit).Extend,'€',ctIntCoin);
      If Pos('€',(Components[mI] as TPriceEdit).SpecText)>0 then (Components[mI] as TPriceEdit).SpecText:=ReplaceStr((Components[mI] as TPriceEdit).SpecText,'€',ctIntCoin);
    end;

    If Components[mI] is TValueInfo then begin
      If Pos('€',(Components[mI] as TValueInfo).Extend)>0 then (Components[mI] as TValueInfo).Extend:=ReplaceStr((Components[mI] as TValueInfo).Extend,'€',ctIntCoin);
    end;
//    TPrcInfo.Extend
//    Components[mI] is TQuantInfo.extend
    If Components[mI] is TPriceInfo then begin
      If Pos('€',(Components[mI] as TPriceInfo).IntCoin)>0 then (Components[mI] as TPriceInfo).IntCoin:=ReplaceStr((Components[mI] as TPriceInfo).IntCoin,'€',ctIntCoin);
    end;
    If Components[mI] is TxpEdit then begin
      If Pos('€',(Components[mI] as TxpEdit).ExtText)>0 then (Components[mI] as TxpEdit).ExtText:=ReplaceStr((Components[mI] as TxpEdit).ExtText,'€',ctIntCoin);
    end;
    If Components[mI] is TxpLabel then begin
      If Pos('€',(Components[mI] as TxpLabel).Caption)>0 then (Components[mI] as TxpLabel).Caption:=ReplaceStr((Components[mI] as TxpLabel).Caption,'€',ctIntCoin);
    end;
  end;
  inherited AfterConstruction;
end;

procedure TLangForm.BeforeDestruction;
begin
  If (Position=poDesigned) and (WindowState=wsNormal) then SaveFormPos; // Ulozi umiestnenie a velkost formulara
  inherited;
end;

procedure TLangForm.Loaded;
begin
  inherited;
  Scaled := FALSE;
  Position := poDesigned;
//  If not gvSys.MaximizeMode and (WindowState=wsMaximized)
//    then WindowState := wsNormal;
end;

procedure TLangForm.ShowModal (pFormType:byte);
begin
  oFormType := pFormType;
//  XPMenu1.Active := TRUE; // FileExists(gpath.SysPath+'xpmenu.ini');
//  XPMenu1.AutoDetect := TRUE; // FileExists(gpath.SysPath+'xpmenu.ini');
  ShowModal;
end;

procedure TLangForm.PrevField; // Premiestni SetFocus na predch8dzaj[ce pole podla poradia TabOrder
var Mgs:TMsg;
begin
  SendMessage (Self.Handle,WM_NEXTDLGCTL,-1,0);
 // Vypnutie sysutils.beep po opusteni pola
  PeekMessage(Mgs, 0, WM_CHAR, WM_CHAR, PM_REMOVE);
end;

procedure TLangForm.NextField; // Premiestni SetFocus na nasledujuce pole podla poradia TabOrder
var Mgs:TMsg;
begin
  SendMessage (Self.Handle,WM_NEXTDLGCTL,0,0);
 // Vypnutie sysutils.beep po opusteni pola
  PeekMessage(Mgs, 0, WM_CHAR, WM_CHAR, PM_REMOVE);
end;

procedure TLangForm.SaveFormPos; // Ulozi umiestnenie a velkost formulara
var mFile:TIniHand; mWrap:TTxtWrap;  mCut:TTxtCut;
begin
  If Align=alClient then Exit;
  try
    mFile := TIniHand.Create(GetFormFileName(Tag)+'.WPR');
    //Pripravime vlastnosti na pripadny zapis do WPR s[boru
    mWrap := TTxtWrap.Create;
    mWrap.SetDelimiter('');
    mWrap.ClearWrap;
    mWrap.SetNum(Left,0);
    mWrap.SetNum(Top,0);
    mWrap.SetNum(Width,0);
    mWrap.SetNum(Height,0);
    mWrap.SetText(cPrgVer,0);
    //Ak vlastnosti boli zmenene ulozime do WPR suboru
    If mFile.ReadString(gvSys.LoginName,Name,mWrap.GetWrapText)<>mWrap.GetWrapText then mFile.WriteString (gvSys.LoginName,Name,mWrap.GetWrapText);
    FreeAndNil(mWrap);
    FreeAndNil(mFile);
  except
  end;
end;

procedure TLangForm.LoadFormPos; // Nacita umiestnenie a velkost formulara
var mFile:TIniHand; mWrap:TTxtWrap;  mCut:TTxtCut;
    mProperty:string; mVersion:string;
    mLeft,mTop,mHeight,mWidth:longint;
begin
  mHeight := Height;
  mWidth := Width;
  mFile := TIniHand.Create(GetFormFileName(Tag)+'.WPR');
  //Pripravime vlastnosti na pripadny zapis do WPR s[boru
  mWrap := TTxtWrap.Create;
  mWrap.SetDelimiter('');
  mWrap.ClearWrap;
  mWrap.SetNum(Left,0);
  mWrap.SetNum(Top,0);
  mWrap.SetNum(Width,0);
  mWrap.SetNum(Height,0);
  mWrap.SetText(cPrgVer,0);
  //Nacitame vlastnosti z WPR s[boru, ak neexistuje potom ulozime do suboru
  mProperty := mFile.ReadString(gvSys.LoginName,Name,mWrap.GetWrapText);
  mCut := TTxtCut.Create;
  mCut.SetDelimiter('');
  mCut.SetStr(mProperty);
  If mCut.GetText(5)<>cPrgVer then begin
    mLeft := mCut.GetNum(1);
    mTop := mCut.GetNum(2);
    If mWidth<mCut.GetNum(3) then mWidth := mCut.GetNum(3);
    If mHeight<mCut.GetNum(4) then mHeight := mCut.GetNum(4);
    mWrap.ClearWrap;
    mWrap.SetNum(mLeft,0);
    mWrap.SetNum(mTop,0);
    mWrap.SetNum(mWidth,0);
    mWrap.SetNum(mHeight,0);
    mWrap.SetText(cPrgVer,0);
    mFile.WriteString (gvSys.LoginName,Name,mWrap.GetWrapText);
    mProperty := mFile.ReadString(gvSys.LoginName,Name,mWrap.GetWrapText);
    mCut.SetStr(mProperty);
  end;
  //Nastavime formular podla nacitanych vlastnosti
  Left := mCut.GetNum(1);
  Top := mCut.GetNum(2);
  Width := mCut.GetNum(3);
  Height := mCut.GetNum(4);
  FreeAndNil(mCut);
  FreeAndNil(mWrap);
  FreeAndNil(mFile);
end;

procedure TLangForm.FormEnable;
var I:word;   mName:string; mCodeEdit:TCodeEdit;
    mCodeNameEdit: TCodeNameEdit;
begin
  For I := 0 to ComponentCount-1 do begin
    mName := Components[I].ClassName;
    // IcInfoFileds
    If mName='TMemo' then (Components[I] as TMemo).Enabled := TRUE;
    If mName='TComboBox' then (Components[I] as TComboBox).Enabled := TRUE;
    // IcEditors
    If mName='TNameEdit' then (Components[I] as TNameEdit).Enabled := TRUE;
    If mName='TLongEdit' then (Components[I] as TLongEdit).Enabled := TRUE;
    If mName='TBarCodeEdit' then (Components[I] as TBarCodeEdit).Enabled := TRUE;
    If mName='TIntervalEdit' then (Components[I] as TIntervalEdit).Enabled := TRUE;
    If mName='TDateEdit' then (Components[I] as TDateEdit).Enabled := TRUE;
    If mName='TTimeEdit' then (Components[I] as TTimeEdit).Enabled := TRUE;
    If mName='TCodeEdit' then (Components[I] as TCodeEdit).Enabled := TRUE;
    If mName='TCodeNameEdit' then (Components[I] as TCodeNameEdit).Enabled := TRUE;
    If mName='TValueEdit' then (Components[I] as TvalueEdit).Enabled := TRUE;
    If mName='TPriceEdit' then (Components[I] as TPriceEdit).Enabled := TRUE;
    If mName='TQuantEdit' then (Components[I] as TQuantEdit).Enabled := TRUE;
    If mName='TPrcEdit' then (Components[I] as TPrcEdit).Enabled := TRUE;
    If mName='TDblCodeEdit' then (Components[I] as TDblCodeEdit).Enabled := TRUE;
    If mName='TFLongEdit' then (Components[I] as TFLongEdit).Enabled := TRUE;
    If mName='TFPriceEdit' then (Components[I] as TFPriceEdit).Enabled := TRUE;
    If mName='TFValueEdit' then (Components[I] as TFvalueEdit).Enabled := TRUE;
    If mName='TFQuantEdit' then (Components[I] as TFQuantEdit).Enabled := TRUE;
    If mName='TFPrcEdit' then (Components[I] as TFPrcEdit).Enabled := TRUE;
    If mName='TFDateEdit' then (Components[I] as TFDateEdit).Enabled := TRUE;
    If mName='TFTimeEdit' then (Components[I] as TFTimeEdit).Enabled := TRUE;
    If mName='TLstEdi' then (Components[I]  as TLstEdi).Enabled := TRUE;
    // xpComp
    If mName='TxpEdit'        then (Components[I] as TXpEdit).Enabled := TRUE;
//    If mName='TxpBitBtn'      then (Components[I] as TxpBitBtn).Enabled := TRUE;
    If mName='TxpCheckBox'    then (Components[I] as  TxpCheckBox).Enabled := TRUE;
    If mName='TxpComboBox'    then (Components[I] as TxpComboBox).Enabled := TRUE;
    If mName='TxpGroupBox'    then (Components[I] as TxpGroupBox).Enabled := TRUE;
    If mName='TxpRadioButton' then (Components[I] as TxpRadioButton).Enabled := TRUE;
    If mName='TxpMemo'        then (Components[I] as TxpMemo).Enabled := TRUE;
//    If mName='TxpPageControl' then (Components[I] as TxpPageControl).Enabled := FALSE;
//    If mName='TxpTabSheet'    then (Components[I] as TxpTabSheet).Enabled := FALSE;
//    If mName='TxpPanel'       then (Components[I] as TxpPanel).Enabled := FALSE;
//    If mName='TxpSinglePanel' then (Components[I] as TxpSinglePanel).Enabled := FALSE;
//    If mName='TxpStatusLine'  then (Components[I] as TxpStatusLine).Enabled := FALSE;
  end;
end;

procedure TLangForm.FormDisable;
var I:word;   mName:string; mCodeEdit:TCodeEdit;
    mCodeNameEdit: TCodeNameEdit;
begin
  For I := 0 to ComponentCount-1 do begin
    mName := Components[I].ClassName;
    // IcInfoFileds
    If mName='TMemo' then (Components[I] as TMemo).Enabled := FALSE;
    If mName='TComboBox' then (Components[I] as TComboBox).Enabled := FALSE;
    If mName='TSelectButton' then (Components[I] as TSelectButton).Enabled := FALSE;
    If mName='TCheckButton' then (Components[I] as TCheckButton).Enabled := FALSE;
    // IcEditors
    If mName='TNameEdit' then (Components[I] as TNameEdit).Enabled := FALSE;
    If mName='TLongEdit' then (Components[I] as TLongEdit).Enabled := FALSE;
    If mName='TBarCodeEdit' then (Components[I] as TBarCodeEdit).Enabled := FALSE;
    If mName='TIntervalEdit' then (Components[I] as TIntervalEdit).Enabled := FALSE;
    If mName='TDateEdit' then (Components[I] as TDateEdit).Enabled := FALSE;
    If mName='TTimeEdit' then (Components[I] as TTimeEdit).Enabled := FALSE;
    If mName='TCodeEdit' then (Components[I] as TCodeEdit).Enabled := FALSE;
    If mName='TCodeNameEdit' then (Components[I] as TCodeNameEdit).Enabled := FALSE;
    If mName='TValueEdit' then (Components[I] as TvalueEdit).Enabled := FALSE;
    If mName='TPriceEdit' then (Components[I] as TPriceEdit).Enabled := FALSE;
    If mName='TQuantEdit' then (Components[I] as TQuantEdit).Enabled := FALSE;
    If mName='TPrcEdit' then (Components[I] as TPrcEdit).Enabled := FALSE;
    If mName='TDoubEdit' then (Components[I] as TDoubEdit).Enabled := FALSE;
    If mName='TDblCodeEdit' then (Components[I] as TDblCodeEdit).Enabled := FALSE;
    If mName='TFLongEdit' then (Components[I] as TFLongEdit).Enabled := FALSE;
    If mName='TFPriceEdit' then (Components[I] as TFPriceEdit).Enabled := FALSE;
    If mName='TFValueEdit' then (Components[I] as TFvalueEdit).Enabled := FALSE;
    If mName='TFQuantEdit' then (Components[I] as TFQuantEdit).Enabled := FALSE;
    If mName='TFPrcEdit' then (Components[I] as TFPrcEdit).Enabled := FALSE;
    If mName='TFDateEdit' then (Components[I] as TFDateEdit).Enabled := FALSE;
    If mName='TFTimeEdit' then (Components[I] as TFTimeEdit).Enabled := FALSE;
    // NexEditors
    If mName='TMyContoSlct' then (Components[I] as TMyContoSlct).Enabled := FALSE;
    If mName='TAccAnlEdit' then (Components[I] as TAccAnlEdit).Enabled := FALSE;
    If mName='TDvzNameEdit' then (Components[I] as TDvzNameEdit).Enabled := FALSE;
    If mName='TPlsEdit' then (Components[I] as TPlsEdit).Enabled := FALSE;
    If mName='TStkEdit' then (Components[I] as TStkEdit).Enabled := FALSE;
    If mName='TWriEdit' then (Components[I] as TWriEdit).Enabled := FALSE;
    If mName='TPabEdit' then (Components[I] as TPabEdit).Enabled := FALSE;
    If mName='TPacEdit' then (Components[I] as TPacEdit).Enabled := FALSE;
    If mName='TCtyEdit' then (Components[I] as TCtyEdit).Enabled := FALSE;
    If mName='TDlrEdit' then (Components[I] as TDlrEdit).Enabled := FALSE;
    If mName='TWpaEdit' then (Components[I] as TWpaEdit).Enabled := FALSE;
    If mName='TStaEdit' then (Components[I] as TStaEdit).Enabled := FALSE;
    // NwEditors
    If mName='TNwNameEdit' then (Components[I] as TNwNameEdit).Enabled := FALSE;
    If mName='TNwLongEdit' then (Components[I] as TNwLongEdit).Enabled := FALSE;
    If mName='TNwDateEdit' then (Components[I] as TNwDateEdit).Enabled := FALSE;
    If mName='TNwValueEdit' then (Components[I] as TNwValueEdit).Enabled := FALSE;
    // NwSelectEdit
    If mName='TNwStkLstEdit' then (Components[I] as TNwStkLstEdit).Enabled := FALSE;
    If mName='TNwPlsLstEdit' then (Components[I] as TNwPlsLstEdit).Enabled := FALSE;
    If mName='TNwAplLstEdit' then (Components[I] as TNwAplLstEdit).Enabled := FALSE;
    If mName='TNwSmLstEdit' then (Components[I] as TNwSmLstEdit).Enabled := FALSE;
    If mName='TNwDlrLstEdit' then (Components[I] as TNwDlrLstEdit).Enabled := FALSE;
    If mName='TBokEdi' then (Components[I]  as TBokEdi).Enabled := FALSE;
    If mName='TLstEdi' then (Components[I]  as TLstEdi).Enabled := FALSE;
    If mName='TCtyEdi' then (Components[I]  as TCtyEdi).Enabled := FALSE;
    If mName='TStaEdi' then (Components[I]  as TStaEdi).Enabled := FALSE;
    If mName='TAccEdi' then (Components[I]  as TAccEdi).Enabled := FALSE;
//  TNwLstEdit
    // xpComp
    If mName='TxpEdit'        then (Components[I] as TXpEdit).Enabled := FALSE;
//    If mName='TxpBitBtn'      then (Components[I] as TxpBitBtn).Enabled := FALSE;
    If mName='TxpCheckBox'    then (Components[I] as  TxpCheckBox).Enabled := FALSE;
    If mName='TxpComboBox'    then (Components[I] as TxpComboBox).Enabled := FALSE;
    If mName='TxpGroupBox'    then (Components[I] as TxpGroupBox).Enabled := FALSE;
    If mName='TxpRadioButton' then (Components[I] as TxpRadioButton).Enabled := FALSE;
    If mName='TxpMemo'        then (Components[I] as TxpMemo).Enabled := FALSE;
//    If mName='TxpPageControl' then (Components[I] as TxpPageControl).Enabled := FALSE;
//    If mName='TxpTabSheet'    then (Components[I] as TxpTabSheet).Enabled := FALSE;
//    If mName='TxpPanel'       then (Components[I] as TxpPanel).Enabled := FALSE;
//    If mName='TxpSinglePanel' then (Components[I] as TxpSinglePanel).Enabled := FALSE;
//    If mName='TxpStatusLine'  then (Components[I] as TxpStatusLine).Enabled := FALSE;
  end;
end;

procedure TLangForm.FormClear;
var I:word;   mName:string; mCodeEdit:TCodeEdit;
    mCodeNameEdit: TCodeNameEdit;
begin
  For I := 0 to ComponentCount-1 do begin
    mName := Components[I].ClassName;
    // IcInfoFileds
    If mName='TMemo' then (Components[I] as TMemo).Clear;
    If mName='TComboBox' then (Components[I] as TComboBox).ItemIndex := -1;
    If mName='TNameInfo' then (Components[I] as TNameInfo).Text := '';
    If mName='TLongInfo' then (Components[I] as TLongInfo).Long := 0;
    If mName='TDateInfo' then (Components[I] as TDateInfo).Date := Date;
    If mName='TTimeInfo' then (Components[I] as TTimeInfo).Time := Now;
    If mName='TValueInfo' then (Components[I] as TValueInfo).Value := 0;
    If mName='TPriceInfo' then (Components[I] as TPriceInfo).Value := 0;
    If mName='TQuantInfo' then (Components[I] as TQuantInfo).Value := 0;
    If mName='TPrcInfo' then (Components[I] as TPrcInfo).Value := 0;
    // IcEditors
    If mName='TNameEdit' then (Components[I] as TNameEdit).Text := '';
    If mName='TLongEdit' then (Components[I] as TLongEdit).Long := 0;
    If mName='TBarCodeEdit' then (Components[I] as TBarCodeEdit).Text := '';
    If mName='TIntervalEdit' then (Components[I] as TIntervalEdit).Text := '';
    If mName='TDateEdit' then begin
      If gIni.AutoActDate
        then (Components[I] as TDateEdit).Date := Date
        else (Components[I] as TDateEdit).Date := 0;
    end;
    If mName='TTimeEdit' then (Components[I] as TTimeEdit).Time := Now;
    If mName='TCodeEdit' then begin
      mCodeEdit := (Components[I] as TCodeEdit);
      mCodeEdit.Search := FALSE;
      mCodeEdit.Long := 0;
      mCodeEdit.Text := '';
      mCodeEdit.Search := TRUE;
    end;
    If mName='TCodeNameEdit' then begin
      mCodeNameEdit := (Components[I] as TCodeNameEdit);
      mCodeNameEdit.Search := FALSE;
      mCodeNameEdit.Code := '';
      mCodeNameEdit.Text := '';
      mCodeNameEdit.Search := TRUE;
    end;
    If mName='TValueEdit' then (Components[I] as TvalueEdit).Value := 0;
//    If mName='TVatEdit' then (Components[I] as TVatEdit).Value := 0;
    If mName='TPriceEdit' then (Components[I] as TPriceEdit).Value := 0;
    If mName='TQuantEdit' then (Components[I] as TQuantEdit).Value := 0;
    If mName='TPrcEdit' then (Components[I] as TPrcEdit).Value := 0;
    If mName='TDblCodeEdit' then begin
      (Components[I] as TDblCodeEdit).Code1 := '';
      (Components[I] as TDblCodeEdit).Code2 := '';
    end;
    If mName='TFLongEdit' then begin
      (Components[I] as TFLongEdit).Long1 := 0;
      (Components[I] as TFLongEdit).Long2 := 0;
    end;
    If mName='TFPriceEdit' then begin
      (Components[I] as TFPriceEdit).Value1 := 0;
      (Components[I] as TFPriceEdit).Value2 := 0;
    end;
    If mName='TFValueEdit' then begin
      (Components[I] as TFvalueEdit).Value1 := 0;
      (Components[I] as TFvalueEdit).Value2 := 0;
    end;
    If mName='TFQuantEdit' then begin
      (Components[I] as TFQuantEdit).Value1 := 0;
      (Components[I] as TFQuantEdit).Value2 := 0;
    end;
    If mName='TFPrcEdit' then begin
      (Components[I] as TFPrcEdit).Value1 := 0;
      (Components[I] as TFPrcEdit).Value2 := 0;
    end;
    If mName='TFDateEdit' then begin
      (Components[I] as TFDateEdit).Date1 := Date;
      (Components[I] as TFDateEdit).Date2 := Date;
      (Components[I] as TFDateEdit).Date1 := 0;
      (Components[I] as TFDateEdit).Date2 := 0;
    end;
    If mName='TFTimeEdit' then begin
      (Components[I] as TFTimeEdit).Time1 := Time;
      (Components[I] as TFTimeEdit).Time2 := Time;
    end;
    // xpComp
    If mName='TxpEdit'        then (Components[I] as TXpEdit).text := '';
    If mName='TxpCheckBox'    then (Components[I] as  TxpCheckBox).Checked:= FALSE;
    If mName='TxpComboBox'    then (Components[I] as TxpComboBox).ItemIndex := -1;
    If mName='TxpRadioButton' then (Components[I] as TxpRadioButton).Checked := FALSE;
    If mName='TxpMemo'        then (Components[I] as TxpMemo).clear;
//    If mName='TxpGroupBox'    then (Components[I] as TxpGroupBox).Enabled := FALSE;
//    If mName='TxpBitBtn'      then (Components[I] as TxpBitBtn).Enabled := FALSE;
//    If mName='TxpPageControl' then (Components[I] as TxpPageControl).Enabled := FALSE;
//    If mName='TxpTabSheet'    then (Components[I] as TxpTabSheet).Enabled := FALSE;
//    If mName='TxpPanel'       then (Components[I] as TxpPanel).Enabled := FALSE;
//    If mName='TxpSinglePanel' then (Components[I] as TxpSinglePanel).Enabled := FALSE;
//    If mName='TxpStatusLine'  then (Components[I] as TxpStatusLine).Enabled := FALSE;
  end;
end;

end.
{MOD 1807023}
{MOD 1810006}
