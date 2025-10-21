unit MsgBox;
// =============================================================================
//                               DIAL�GOV� BOX
// -----------------------------------------------------------------------------
//
// -----------------------------------------------------------------------------
// *********************** POPIS PRIVATE FUNKCI� OBJEKTU ***********************
// -----------------------------------------------------------------------------
// CrtFilNam - vytvor� n�zvy s�borov
// SetAskFrm - nastav� kompenenty dotazov�ho formul�ra
// SetInfFrm - nastav� kompenenty informa�n�ho formul�ra
// SetWarFrm - nastav� kompenenty upozor�ovacieho formul�ra
// LodMsgDat - na��ta text hl�senia a hlasov� s�bor do dial�gov�ho okna.
//             Ak nen�jde textov� s�bor vlo�� vlastn� kr�tky text.
// AddMsgPar - dopln� parametre do textu hl�senia
// AddEmpLin - prid� zadan� po�et pr�zdnych riadkov
//             � pLinQnt - po�et riadkov
// AddOneLin - prid� do spr�vy jednoriadkov� text
//             � pTxtLin - obsah textov�ho riadku
// -----------------------------------------------------------------------------
// ************************ POPIS PUBLIC FUNKCI� OBJEKTU ***********************
// -----------------------------------------------------------------------------
// AskYes - zobraz� dial�gov� okno s ot�zkou a dvoma tla��tkami "�NO" a "NIE".
//          Hodnota funkcie je TRUE ak bolo v dial�gom boxe stla�en� tla��tko
//          "�NO".
//          � pErrCod - ��seln� k�d hl�senia
//          � pParLst - zoznam parametrov hl�senia, parametre v texte s� uveden�
//                      so znakom "%s", jednotliv� parametre s� rozdelen� s "|"
//
// ShwInf - zobraz� dial�gov� okno s inform�ciu pre u��vate�a
// ShwWar - zobraz� dial�gov� okno s upozornen�m pre u��vate�a
// -----------------------------------------------------------------------------
// ********************************* POZN�MKY **********************************
// -----------------------------------------------------------------------------
//
// -----------------------------------------------------------------------------
// ****************************** HIST�RIA ZMIEN *******************************
// -----------------------------------------------------------------------------
// 21.03[24.12.2018] - Nov� funkcia (RZ)
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
    oYesBut:boolean; // TRUE ak bolo stla�en� tla��tko "�NO"
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
    eCanNotDelBok=10001; // Nie je mo�n� vymaza� vybran� knihu, preto�e obsahuje doklady !
    eCanNotDocEdi=10002; // Dan� doklad teraz nem��ete upravova�, preto�e momnent�lne pracuje s t�m u��vate�:
    eUsrNotEbaDef=10003; // Nem�te pridelen� pr�stup k elektronick�mu bankovn�ctvu !

    eErrNotSavDat=20001; // �daje nie je mo�n� ulo�i�, lebo niektor� polia nie s� spr�vne vyplnen� !
    eErrDteNotYer=20002; // Zadan� d�tum nepatr� do ��tovn�ho obdobia dan�ho dokladu !
    eErrDteNotCor=20003; // Nespr�vne zadan� d�tum !

    eCanDelSlcDoc=30001; // Naozaj chcete vymaza� vybran� doklad ?
    eCanDelSlcItm=30002; // Naozaj chcete vymaza� vybran� polo�ku ?
    eCanDelSlcRec=30003; // Naozaj chcete vymaza� vybran� z�znam ?
    eCanDelSlcBok=30004; // Naozaj chcete vymaza� vybranu knihu ?
    eCanLocSlcDoc=30006; // Naozaj chcete uzamkn�� vybran� doklad ?
    eCanUnlSlcDoc=30007; // Naozaj chcete odomkn�� vybran� doklad ?
    eCanClcSlcDoc=30008; // Naozaj chcete prepo��ta� vybran� doklad ?

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
  Caption:='Ot�zka k u��vate�ovi';
  T_MsgDat.Caption:='OT�ZKA';
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
  Caption:='Informovanie u��vate�a';
  T_MsgDat.Caption:='INFORM�CIA';
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
  Caption:='Upozornenie u��vate�a';
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
  If not mFind then begin // Ak nebol n�jden� textov s�bor vlo�ime vlastn� texty
    case E_MsgCod.AsInteger of
      eCanNotDelBok: begin
                       AddEmpLin(4);
                       E_MsgEdi.Lines.Add('Nie je mo�n� vymaza� vybran� knihu,');
                       E_MsgEdi.Lines.Add('preto�e dan� kniha obsahuje doklady !');
                     end;
      eCanNotDocEdi: begin
                       AddEmpLin(3);
                       E_MsgEdi.Lines.Add('Dan� doklad teraz nem��ete upravova�,');
                       E_MsgEdi.Lines.Add('preto�e momnent�lne pracuje s t�m u��vate�:');
                       E_MsgEdi.Lines.Add('%s');
                     end;
      eUsrNotEbaDef: begin
                       AddEmpLin(4);
                       E_MsgEdi.Lines.Add('Nem�te pridelen� pr�stup k elektronick�mu');
                       E_MsgEdi.Lines.Add('bankovn�ctvu: %s');
                     end;
      // -----------------------------------------------------------------------
      eErrNotSavDat: begin
                       AddEmpLin(3);
                       E_MsgEdi.Lines.Add('�daje nie je mo�n� ulo�i� do datab�ze,');
                       E_MsgEdi.Lines.Add('lebo niektor� polia nie s� spr�vne vyplnen� !');
                       E_MsgEdi.Lines.Add('Chybn� polia s� ozna�en� �ervenou farbou.');
                     end;
      eErrDteNotYer: begin
                       AddEmpLin(3);
                       E_MsgEdi.Lines.Add('Zadali ste nespr�vny d�tum: '+' %s !');
                       E_MsgEdi.Lines.Add('Tento d�tum nepatr� do ��tovn�ho');
                       E_MsgEdi.Lines.Add('odbdobia dan�ho dokladu.');
                     end;
      eErrDteNotCor: AddOneLin('Zadali ste nespr�vny d�tum: '+' %s !');
      // -----------------------------------------------------------------------
      eCanDelSlcDoc: AddOneLin('Naozaj chcete vymaza� vybran� doklad ?');
      eCanDelSlcItm: AddOneLin('Naozaj chcete vymaza� vybran� polo�ku ?');
      eCanDelSlcRec: AddOneLin('Naozaj chcete vymaza� vybran� z�znam ?');
      eCanDelSlcBok: AddOneLin('Naozaj chcete vymaza� vybran� knihu ?');
      eCanLocSlcDoc: AddOneLin('Naozaj chcete uzamkn�� vybran� doklad ?');
      eCanUnlSlcDoc: AddOneLin('Naozaj chcete odomkn�� vybran� doklad ?');
      eCanClcSlcDoc: AddOneLin('Naozaj chcete prepo��ta� vybran� doklad ?');
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

