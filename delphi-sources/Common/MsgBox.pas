unit MsgBox;
// =============================================================================
//                               DIALÓGOVÝ BOX
// -----------------------------------------------------------------------------
//
// -----------------------------------------------------------------------------
// *********************** POPIS PRIVATE FUNKCIÍ OBJEKTU ***********************
// -----------------------------------------------------------------------------
// CrtFilNam - vytvorí názvy súborov
// SetAskFrm - nastaví kompenenty dotazového formulára
// SetInfFrm - nastaví kompenenty informaèného formulára
// SetWarFrm - nastaví kompenenty upozoròovacieho formulára
// LodMsgDat - naèíta text hlásenia a hlasový súbor do dialógového okna.
//             Ak nenájde textový súbor vloží vlastný krátky text.
// AddMsgPar - doplní parametre do textu hlásenia
// AddEmpLin - pridá zadaný poèet prázdnych riadkov
//             › pLinQnt - poèet riadkov
// AddOneLin - pridá do správy jednoriadkový text
//             › pTxtLin - obsah textového riadku
// -----------------------------------------------------------------------------
// ************************ POPIS PUBLIC FUNKCIÍ OBJEKTU ***********************
// -----------------------------------------------------------------------------
// AskYes - zobrazí dialógové okno s otázkou a dvoma tlaèítkami "ÁNO" a "NIE".
//          Hodnota funkcie je TRUE ak bolo v dialógom boxe stlaèené tlaèítko
//          "ÁNO".
//          › pErrCod - èíselný kód hlásenia
//          › pParLst - zoznam parametrov hlásenia, parametre v texte sú uvedené
//                      so znakom "%s", jednotlivé parametre sú rozdelené s "|"
//
// ShwInf - zobrazí dialógové okno s informáciu pre užívate¾a
// ShwWar - zobrazí dialógové okno s upozornením pre užívate¾a
// -----------------------------------------------------------------------------
// ********************************* POZNÁMKY **********************************
// -----------------------------------------------------------------------------
//
// -----------------------------------------------------------------------------
// ****************************** HISTÓRIA ZMIEN *******************************
// -----------------------------------------------------------------------------
// 21.03[24.12.2018] - Nová funkcia (RZ)
// =============================================================================

interface

uses
  IcVariab, IcTypes, IcConv, IcTools, IcLabels, NexText, NexPath, NexIni,
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls, ComCtrls, ExtCtrls, Buttons, MPlayer, ToolWin, RichEdit, ImgList,
  IcStand, ActnList, IcActionList, xpComp, jpeg;

type
  TMsgBox=class(TForm)
    MediaPlayer: TMediaPlayer;
    ActionList: TIcActionList;
    ImageList: TImageList;
    B_Con: TxpBitBtn;
    B_Yes: TxpBitBtn;
    B_Not: TxpBitBtn;
    A_Exi: TAction;
    A_Yes: TAction;
    A_Not: TAction;
    A_Con: TAction;
    P_MsgDat: TxpSinglePanel;
    H_MsgDat: TxpSinglePanel;
    T_MsgDat: TxpLabel;
    E_MsgEdi: TRichEdit;
    ToolBar: TToolBar;
    B_SavMsg: TToolButton;
    B_EdiUnd: TToolButton;
    ToolButton10: TToolButton;
    FontName: TComboBox;
    ToolButton11: TToolButton;
    FontSize: TEdit;
    UpDown1: TUpDown;
    ToolButton2: TToolButton;
    B_Bold: TToolButton;
    B_Italic: TToolButton;
    B_Underline: TToolButton;
    ToolButton16: TToolButton;
    B_LeftAlign: TToolButton;
    B_CenterAlign: TToolButton;
    B_RightAlign: TToolButton;
    ToolButton20: TToolButton;
    B_Bullets: TToolButton;
    ToolButton1: TToolButton;
    A_Edit: TAction;
    A_Ext: TAction;
    E_MsgCod: TxpEdit;
    P_ImgBor: TxpSinglePanel;
    P_ImgDat: TxpSinglePanel;
    I_InfImg: TImage;
    I_WarImg: TImage;
    I_AskImg: TImage;
    procedure FormActivate(Sender: TObject);
    procedure B_SavMsgClick(Sender: TObject);
    procedure B_BoldClick(Sender: TObject);
    procedure B_ItalicClick(Sender: TObject);
    procedure B_UnderlineClick(Sender: TObject);
    procedure B_AlignClick(Sender: TObject);
    procedure B_EdiUndClick(Sender: TObject);
    procedure FontNameChange(Sender: TObject);
    procedure B_BulletsClick(Sender: TObject);
    procedure FontSizeChange(Sender: TObject);
    procedure SelectionChange(Sender: TObject);
    procedure A_ExiExecute(Sender: TObject);
    procedure KeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure A_EditExecute(Sender: TObject);
    procedure A_ExtExecute(Sender: TObject);
    procedure A_YesExecute(Sender: TObject);
    procedure A_NotExecute(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure A_ConExecute(Sender: TObject);
  private
    oMsgFil:ShortString;
    oWavFil:ShortString;
    oYesBut:boolean; // TRUE ak bolo stlaèené tlaèítko "ÁNO"
    function CurrText:TTextAttributes;
    procedure CrtFilNam;
    procedure SetAskFrm;
    procedure SetInfFrm;
    procedure SetWarFrm;
    procedure LodFonNam;
    procedure LodMsgDat;
    procedure AddMsgPar(pParLst:ShortString);
    procedure AddEmpLin(pLinQnt:byte);
    procedure AddOneLin(pTxtLin:ShortString);
  public
    function AskYes(pMsgCod:integer;pParLst:ShortString):boolean;
    procedure ShwInf(pMsgCod:integer;pParLst:ShortString);
    procedure ShwWar(pMsgCod:integer;pParLst:ShortString);
  end;

const
    eCanNotDelBok=10001; // Nie je možné vymaza vybranú knihu, pretože obsahuje doklady !
    eCanNotDocEdi=10002; // Daný doklad teraz nemôžete upravova, pretože momnentálne pracuje s tým užívate¾:
    eUsrNotEbaDef=10003; // Nemáte pridelený prístup k elektronickému bankovníctvu !

    eErrNotSavDat=20001; // Údaje nie je možné uloži, lebo niektoré polia nie sú správne vyplnené !
    eErrDteNotYer=20002; // Zadaný dátum nepatrí do úètovného obdobia daného dokladu !
    eErrDteNotCor=20003; // Nesprávne zadaný dátum !

    eCanDelSlcDoc=30001; // Naozaj chcete vymaza vybraný doklad ?
    eCanDelSlcItm=30002; // Naozaj chcete vymaza vybranú položku ?
    eCanDelSlcRec=30003; // Naozaj chcete vymaza vybraný záznam ?
    eCanDelSlcBok=30004; // Naozaj chcete vymaza vybranu knihu ?
    eCanLocSlcDoc=30006; // Naozaj chcete uzamknú vybraný doklad ?
    eCanUnlSlcDoc=30007; // Naozaj chcete odomknú vybraný doklad ?
    eCanClcSlcDoc=30008; // Naozaj chcete prepoèíta vybraný doklad ?

var gMsg:TMsgBox;

implementation

uses  ExecWait;

function EnumFontsProc(var LogFont:TLogFont; var TextMetric:TTextMetric; FontType:Integer; Data:Pointer):Integer; stdcall;
begin
  TStrings(Data).Add(LogFont.lfFaceName);
  Result:=1;
end;

{$R *.DFM}

// ******************************** OBJECT *************************************

procedure TMsgBox.FormActivate(Sender: TObject);
begin
  try
    If FileExists(MediaPlayer.FileName) then begin
      MediaPlayer.Open;
      MediaPlayer.Play;
    end;
  except end;
end;

procedure TMsgBox.FormShow(Sender: TObject);
begin
  If B_Not.Visible then B_Not.SetFocus;
end;

// ******************************** PRIVATE ************************************

procedure TMsgBox.CrtFilNam;
begin
  oMsgFil:=gPath.MsgPath+'msg'+StrIntZero(E_MsgCod.AsInteger,5)+'.rtf';
  owavFil:=gPath.MsgPath+'msg'+StrIntZero(E_MsgCod.AsInteger,5)+'.wav';
end;

procedure TMsgBox.SetAskFrm;
begin
  Caption:='Otázka k užívate¾ovi';
  T_MsgDat.Caption:='OTÁZKA';
  I_AskImg.Align:=alClient;
  I_AskImg.Visible:=TRUE; I_InfImg.Visible:=FALSE;  I_WarImg.Visible:=FALSE;
  A_Con.Enabled:=FALSE;  A_Con.Visible:=FALSE;
  B_Con.Enabled:=FALSE;  B_Con.Visible:=FALSE;
  A_Yes.Enabled:=TRUE;   A_Yes.Visible:=TRUE;
  B_Yes.Enabled:=TRUE;   B_Yes.Visible:=TRUE;
  A_Not.Enabled:=TRUE;   A_Not.Visible:=TRUE;
  B_Not.Enabled:=TRUE;   B_Not.Visible:=TRUE;
  E_MsgEdi.Enabled:=FALSE;
  ToolBar.Visible:=FALSE;
end;

procedure TMsgBox.SetInfFrm;
begin
  Caption:='Informovanie užívate¾a';
  T_MsgDat.Caption:='INFORMÁCIA';
  I_InfImg.Top:=45;  I_InfImg.Left:=40;
  I_InfImg.Height:=180;  I_InfImg.Width:=180;
  I_InfImg.Align:=alClient;
  I_InfImg.Visible:=TRUE; I_AskImg.Visible:=FALSE;  I_WarImg.Visible:=FALSE;
  A_Con.Enabled:=TRUE;   A_Con.Visible:=TRUE;
  B_Con.Enabled:=TRUE;   B_Con.Visible:=TRUE;
  A_Yes.Enabled:=FALSE;  A_Yes.Visible:=FALSE;
  B_Yes.Enabled:=FALSE;  B_Yes.Visible:=FALSE;
  A_Not.Enabled:=FALSE;  A_Not.Visible:=FALSE;
  B_Not.Enabled:=FALSE;  B_Not.Visible:=FALSE;
  E_MsgEdi.Enabled:=FALSE;
  ToolBar.Visible:=FALSE;
end;

procedure TMsgBox.SetWarFrm;
begin
  Caption:='Upozornenie užívate¾a';
  T_MsgDat.Caption:='UPOZORNENIE';
  I_WarImg.Top:=45;  I_WarImg.Left:=40;
  I_WarImg.Height:=180;   I_WarImg.Width:=190;
  I_WarImg.Align:=alClient;
  I_WarImg.Visible:=TRUE; I_AskImg.Visible:=FALSE;  I_InfImg.Visible:=FALSE;
  A_Con.Enabled:=TRUE;   A_Con.Visible:=TRUE;
  B_Con.Enabled:=TRUE;   B_Con.Visible:=TRUE;
  A_Yes.Enabled:=FALSE;  A_Yes.Visible:=FALSE;
  B_Yes.Enabled:=FALSE;  B_Yes.Visible:=FALSE;
  A_Not.Enabled:=FALSE;  A_Not.Visible:=FALSE;
  B_Not.Enabled:=FALSE;  B_Not.Visible:=FALSE;
  E_MsgEdi.Enabled:=FALSE;
  ToolBar.Visible:=FALSE;
end;

procedure TMsgBox.LodFonNam;
var DC:HDC;
begin
  DC:=GetDC(0);
  EnumFonts(DC,nil,@EnumFontsProc,Pointer(FontName.Items));
  ReleaseDC(0,DC);
  FontName.Sorted:=TRUE;
end;

procedure TMsgBox.LodMsgDat;
var mFind:boolean;
begin
  try
    E_MsgEdi.Lines.Clear;
    mFind:=FileExists(oMsgFil);
    If mFind then E_MsgEdi.Lines.LoadFromFile(oMsgFil);
  except end;
  If not mFind then begin // Ak nebol nájdený textov súbor vložime vlastné texty
    case E_MsgCod.AsInteger of
      eCanNotDelBok: begin
                       AddEmpLin(4);
                       E_MsgEdi.Lines.Add('Nie je možné vymaza vybranú knihu,');
                       E_MsgEdi.Lines.Add('pretože daná kniha obsahuje doklady !');
                     end;
      eCanNotDocEdi: begin
                       AddEmpLin(3);
                       E_MsgEdi.Lines.Add('Daný doklad teraz nemôžete upravova,');
                       E_MsgEdi.Lines.Add('pretože momnentálne pracuje s tým užívate¾:');
                       E_MsgEdi.Lines.Add('%s');
                     end;
      eUsrNotEbaDef: begin
                       AddEmpLin(4);
                       E_MsgEdi.Lines.Add('Nemáte pridelený prístup k elektronickému');
                       E_MsgEdi.Lines.Add('bankovníctvu: %s');
                     end;
      // -----------------------------------------------------------------------
      eErrNotSavDat: begin
                       AddEmpLin(3);
                       E_MsgEdi.Lines.Add('Údaje nie je možné uloži do databáze,');
                       E_MsgEdi.Lines.Add('lebo niektoré polia nie sú správne vyplnené !');
                       E_MsgEdi.Lines.Add('Chybné polia sú oznaèené èervenou farbou.');
                     end;
      eErrDteNotYer: begin
                       AddEmpLin(3);
                       E_MsgEdi.Lines.Add('Zadali ste nesprávny dátum: '+' %s !');
                       E_MsgEdi.Lines.Add('Tento dátum nepatrí do úètovného');
                       E_MsgEdi.Lines.Add('odbdobia daného dokladu.');
                     end;
      eErrDteNotCor: AddOneLin('Zadali ste nesprávny dátum: '+' %s !');
      // -----------------------------------------------------------------------
      eCanDelSlcDoc: AddOneLin('Naozaj chcete vymaza vybraný doklad ?');
      eCanDelSlcItm: AddOneLin('Naozaj chcete vymaza vybranú položku ?');
      eCanDelSlcRec: AddOneLin('Naozaj chcete vymaza vybraný záznam ?');
      eCanDelSlcBok: AddOneLin('Naozaj chcete vymaza vybranú knihu ?');
      eCanLocSlcDoc: AddOneLin('Naozaj chcete uzamknú vybraný doklad ?');
      eCanUnlSlcDoc: AddOneLin('Naozaj chcete odomknú vybraný doklad ?');
      eCanClcSlcDoc: AddOneLin('Naozaj chcete prepoèíta vybraný doklad ?');
    end;
  end;
  try
    If FileExists(oWavFil) then begin
      MediaPlayer.FileName:=oWavFil;
      MediaPlayer.Visible:=TRUE;
    end;
  except end;
end;

procedure TMsgBox.AddMsgPar(pParLst:ShortString);
var I,mPos: integer;
begin
  mPos:=LineElementNum (pParLst,'|');
  If mPos>0 then begin
    If E_MsgEdi.Lines.Count=0 then begin
      For I:=0 to mPos-1 do
        E_MsgEdi.Lines.Add(LineElement(pParLst,I,'|'));
    end else begin
      For I:=0 to mPos-1 do begin
        E_MsgEdi.SelStart:=E_MsgEdi.FindText('%s',0,E_MsgEdi.GetTextLen,[]); //???
        If E_MsgEdi.SelStart<E_MsgEdi.GetTextLen then begin
          E_MsgEdi.SelLength:=2;
          E_MsgEdi.SelText:=LineElement(pParLst,I,'|');
        end;
      end;
      Repeat
        E_MsgEdi.SelStart:=E_MsgEdi.FindText('%s',0,E_MsgEdi.GetTextLen,[]);
        If E_MsgEdi.SelStart<E_MsgEdi.GetTextLen then begin
          E_MsgEdi.SelLength:=2;
          E_MsgEdi.SelText:='';
        end;
      until (E_MsgEdi.SelStart>=E_MsgEdi.GetTextLen);
    end;
  end;
  While E_MsgEdi.FindText('%s',0,E_MsgEdi.GetTextLen,[])>-1 do begin
    E_MsgEdi.SelStart:=E_MsgEdi.FindText('%s',0,E_MsgEdi.GetTextLen,[]);
    If E_MsgEdi.SelStart<E_MsgEdi.GetTextLen then begin
      E_MsgEdi.SelLength:=2;
      E_MsgEdi.SelText:='';
    end;
  end;
end;

procedure TMsgBox.AddEmpLin(pLinQnt:byte);
var I:byte;
begin
  For I:=1 to pLinQnt do
    E_MsgEdi.Lines.Add('');
end;

procedure TMsgBox.AddOneLin(pTxtLin:ShortString);
begin
  AddEmpLin(5);
  E_MsgEdi.Lines.Add(pTxtLin);
end;

// ******************************** PUBLIC *************************************

function TMsgBox.AskYes(pMsgCod:integer;pParLst:ShortString):boolean;
begin
  oYesBut:=FALSE;
  E_MsgCod.AsInteger:=pMsgCod;
  SetAskFrm;
  CrtFilNam;
  LodFonNam;
  LodMsgDat;
  AddMsgPar(pParLst);
  ShowModal;
  Result:=oYesBut;
end;

procedure TMsgBox.ShwInf(pMsgCod:integer;pParLst:ShortString);
begin
  E_MsgCod.AsInteger:=pMsgCod;
  SetInfFrm;
  CrtFilNam;
  LodFonNam;
  LodMsgDat;
  AddMsgPar(pParLst);
  ShowModal;
end;

procedure TMsgBox.ShwWar(pMsgCod:integer;pParLst:ShortString);
begin
  E_MsgCod.AsInteger:=pMsgCod;
  SetWarFrm;
  CrtFilNam;
  LodFonNam;
  LodMsgDat;
  AddMsgPar(pParLst);
  ShowModal;
end;

function TMsgBox.CurrText:TTextAttributes;
begin
  If E_MsgEdi.SelLength>0 then Result:=E_MsgEdi.SelAttributes
                          else Result:=E_MsgEdi.DefAttributes;
end;

procedure TMsgBox.B_BoldClick(Sender: TObject);
begin
  If B_Bold.Down
    then CurrText.Style:=CurrText.Style+[fsBold]
    else CurrText.Style:=CurrText.Style-[fsBold];
end;

procedure TMsgBox.B_ItalicClick(Sender: TObject);
begin
  If B_Italic.Down
    then CurrText.Style:=CurrText.Style+[fsItalic]
    else CurrText.Style:=CurrText.Style-[fsItalic];
end;

procedure TMsgBox.B_UnderlineClick(Sender: TObject);
begin
  If B_Underline.Down
    then CurrText.Style:=CurrText.Style+[fsUnderline]
    else CurrText.Style:=CurrText.Style-[fsUnderline];
end;

procedure TMsgBox.B_AlignClick(Sender: TObject);
begin
  E_MsgEdi.Paragraph.Alignment:=TAlignment(TControl(Sender).Tag);
end;

procedure TMsgBox.B_EdiUndClick(Sender: TObject);
begin
  With E_MsgEdi do
    If HandleAllocated then SendMessage(Handle,EM_UNDO,0,0);
end;

procedure TMsgBox.FontNameChange(Sender: TObject);
begin
  CurrText.Name:=FontName.Items[FontName.ItemIndex];
  E_MsgEdi.SetFocus;
end;

procedure TMsgBox.B_BulletsClick(Sender: TObject);
begin
  E_MsgEdi.Paragraph.Numbering:=TNumberingStyle(B_Bullets.Down);
end;

procedure TMsgBox.FontSizeChange(Sender: TObject);
begin
  CurrText.Size:=StrToInt(FontSize.Text);
end;

procedure TMsgBox.SelectionChange(Sender: TObject);
var CharPos: TPoint;
begin
  with E_MsgEdi.Paragraph do
  try
    B_Bold.Down:=fsBold in E_MsgEdi.SelAttributes.Style;
    B_Italic.Down:=fsItalic in E_MsgEdi.SelAttributes.Style;
    B_Underline.Down:=fsUnderline in E_MsgEdi.SelAttributes.Style;
    B_Bullets.Down:=Boolean(Numbering);
    FontSize.Text:=IntToStr(E_MsgEdi.SelAttributes.Size);
    FontName.Text:=E_MsgEdi.SelAttributes.Name;
    case Ord(Alignment) of
      0: B_LeftAlign.Down:=TRUE;
      1: B_RightAlign.Down:=TRUE;
      2: B_CenterAlign.Down:=TRUE;
    end;
//    UpdateCursorPos;
  finally
//    FUpdating:=False;
  end;
end;

// ******************************** ACTION *************************************

procedure TMsgBox.KeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
var mForm:TCustomForm;
begin
(*
  If E_MsgEdi.ReadOnly and ((Key=VK_RETURN) or (Key=VK_DOWN)) then begin
    mForm:=GetParentForm(((Sender as TComponent).Owner as TControl));
    If (mForm<>nil) then SendMessage(mForm.Handle,WM_NEXTDLGCTL,0,0);
  end;
*)  
end;

procedure TMsgBox.B_SavMsgClick(Sender: TObject);
begin
  E_MsgEdi.Enabled:=FALSE;
  E_MsgEdi.Lines.SaveToFile(oMsgFil);
  ToolBar.Visible:=FALSE;
end;

procedure TMsgBox.A_EditExecute(Sender: TObject);
begin
  E_MsgEdi.Enabled:=TRUE;
  ToolBar.Visible:=TRUE;
  E_MsgEdi.SetFocus;
end;

procedure TMsgBox.A_ExtExecute(Sender: TObject);
begin
  If FileExists(oMsgFil) then begin
    ExecAppWait(oMsgFil,'');
    LodMsgDat;
  end;
end;

procedure TMsgBox.A_YesExecute(Sender: TObject);
begin
  oYesBut:=TRUE;
  Close;
end;

procedure TMsgBox.A_NotExecute(Sender: TObject);
begin
  oYesBut:=FALSE;
  Close;
end;

procedure TMsgBox.A_ExiExecute(Sender: TObject);
begin
  oYesBut:=FALSE;
  Close;
end;

procedure TMsgBox.A_ConExecute(Sender: TObject);
begin
  Close;
end;

end.

