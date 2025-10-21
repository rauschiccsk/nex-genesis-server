unit Dac;

interface

uses
  NexMsg, NexError, NexIni, NexGlob, IcTypes, IcConst, IcVariab, IcTools, IcConv, IcDate,
  Key, hJOURNAL, hACCSNT, hACCANL, tDAC,
  LangForm, Controls, ExtCtrls, Classes, StdCtrls, Buttons, Windows, Messages,
  SysUtils, Graphics, Forms, Dialogs, ComCtrls, IcLabels, IcInfoFields,
  IcProgressBar, DB, BtrTable, NexBtrTable, CmpTools, DBTables, NexPxTable,
  PxTable, IcStand, IcEditors, IcButtons, xpComp;

type
  TDacF = class(TLangForm)
    P_WinHed: TPanel;
    L_WinTit: TLeftLabel;
    L_WinDes: TLeftLabel;
    P_WinBas: TxpSinglePanel;
    StatusLine: TxpStatusLine;
    T_DocNum: TxpLabel;
    E_DocNum: TxpEdit;
    E_DocDate: TxpEdit;
    T_DocDate: TxpLabel;
    P_Ind: TxpSinglePanel;
    T_Ind: TxpLabel;
    PB_Ind: TProgressBar;
    C_Ind: TxpEdit;
    P_Err: TxpSinglePanel;
    T_Err: TxpLabel;
    E_Err: TxpMemo;
    B_Exi: TxpBitBtn;
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure B_ExiClick(Sender: TObject);
  private
    oBegRec:byte;
    oCntNum:word;
    oStkNum:word;
    oWriNum:word;
    oDesTxt:Str30;
    oExtNum:Str12;
    oOcdNum:Str12;
    oConDoc:Str12;
    oSmCode:word;
    oPaCode:longint;
    oSpaCode:longint;
    oAccCen:boolean;
    oAccWri:boolean;
    oAccStk:boolean;
    oOcdAcc:boolean;
    ohJOURNAL:TJournalHnd;
    ohACCSNT:TAccsntHnd;
    ohACCANL:TAccanlHnd;
    otDAC:TDacTmp;
    function GetAnlName (pAccSnt:Str3;pAccAnl:Str6):Str30; // Nazov zadaneho analytickeho uctu
    function GetAccErr:boolean;
    procedure SetDocNum(pValue:Str12);
    procedure SetDocDate(pValue:TDateTime);
  public
    procedure Clear;
    procedure Del(pDocNum:Str12);  // Zrusi zapisy zadaného dokladu z dennika UZ
    procedure Add(pItmNum:longint;pAccSnt:Str3;pAccAnl:Str6;pCrdVal,pDebVal:double); // Prida uètovný zápis do doèasného súboru
    procedure Save; // Ulozi zapisy do dennika UZ

    property AccErr:boolean read GetAccErr;
    property DocNum:Str12 write SetDocNum;
    property DocDate:TDateTime write SetDocDate;
    property BegRec:byte write oBegRec;
    property CntNum:word write oCntNum;
    property StkNum:word write oStkNum;
    property WriNum:word write oWriNum;
    property DesTxt:Str30 write oDesTxt;
    property ExtNum:Str12 write oExtNum;
    property OcdNum:Str12 write oOcdNum;
    property ConDoc:Str12 write oConDoc;
    property SmCode:word write oSmCode;
    property PaCode:longint write oPaCode;
    property SpaCode:longint write oSpaCode;
    property AccCen:boolean write oAccCen;
    property AccWri:boolean write oAccWri;
    property AccStk:boolean write oAccStk;
    property OcdAcc:boolean write oOcdAcc;
  end;

function AnlGen (pAnlFrm:Str6;pNum:longint):Str6; // Hodnota funkcia je analyticky ucet vytvoreny s dosadenim cisla pNum do formatu analytickeho uctu pAnlFrm

implementation


{$R *.DFM}

//************************** APPLIC *****************************

function AnlGen (pAnlFrm:Str6;pNum:longint):Str6; // Hodnota funkcia je analyticky ucet vytvoreny s dosadenim cisla pNum do formatu analytickeho uctu pAnlFrm
var mPos,mLen:byte;  mNumChar:Str1; // Znak namiesto ktoreho treba dosadit zadane cislo
begin
  Result := UpString (pAnlFrm);
  If Pos ('S',Result)>0 then mNumChar := 'S';
  If Pos ('P',Result)>0 then mNumChar := 'P';
  If Pos ('N',Result)>0 then mNumChar := 'N';
  If Pos ('V',Result)>0 then mNumChar := 'V';
  If Pos ('C',Result)>0 then mNumChar := 'C';
  mPos := Pos (mNumChar,Result);
  If mPos>0 then begin
    mLen := 0;
    Repeat
      Delete (Result,mPos,1);
      Inc (mLen);
    until Pos (mNumChar,Result)=0;
    Insert (StrIntZero(pNum,mLen),Result,mPos);
  end;
end;

//*************************** CLASS *****************************
procedure TDacF.FormCreate(Sender: TObject);
begin
  Height := 160;
  Clear;
  ohJOURNAL := TJournalHnd.Create; ohJOURNAL.Open;
  ohACCSNT := TAccsntHnd.Create;  ohACCSNT.Open;
  ohACCANL := TAccanlHnd.Create;  ohACCANL.Open;
  otDAC := TDacTmp.Create; otDAC.Open;
end;

procedure TDacF.FormDestroy(Sender: TObject);
begin
  FreeAndNil(otDAC);
  FreeAndNil(ohACCANL);
  FreeAndNil(ohACCSNT);
  FreeAndNil(ohJOURNAL);
end;

procedure TDacF.Del (pDocNum:Str12);
begin
  While ohJOURNAL.LocateDocNum(pDocNum) do begin
    ohJOURNAL.Delete;
    Application.ProcessMessages;
  end;
end;

// ********************************** PRIVATE **********************************

function TDacF.GetAnlName (pAccSnt:Str3;pAccAnl:Str6):Str30; // Nazov zadaneho analytickeho uctu
begin
  Result := '';
  If ohACCANL.LocateSnAn(pAccSnt,pAccAnl) then Result := ohACCANL.AnlName;
end;

function TDacF.GetAccErr:boolean;
begin
  Result := E_Err.Lines.Count>0;
end;

procedure TDacF.SetDocNum(pValue:Str12);
begin
  E_DocNum.AsString := pValue;
end;

procedure TDacF.SetDocDate(pValue:TDateTime);
begin
  E_DocDate.AsDateTime := pValue;
end;

(*
procedure TDacF.AddToAccAnl (pAccSnt:Str3;pAccAnl:Str6;pAnlName:Str30);
begin
  If dmLDG.btACCANL.Active then begin
    If dmLDG.btACCANL.IndexName<>'SnAn' then dmLDG.btACCANL.IndexName := 'SnAn';
    If not dmLDG.btACCANL.FindKey ([pAccSnt,pAccAnl]) then begin
      dmLDG.btACCANL.Insert;
      dmLDG.btACCANL.FieldByname ('AccSnt').AsString := pAccSnt;
      dmLDG.btACCANL.FieldByname ('AccAnl').AsString := pAccAnl;
      dmLDG.btACCANL.FieldByname ('AnlName').AsString := pAnlName;
      dmLDG.btACCANL.Post;
    end;
  end;
end;
*)

// *********************************** PUBLIC **********************************

procedure TDacF.Clear;
begin
  C_Ind.AsInteger := 0;
  PB_Ind.Position := 0;
  E_Err.Clear;
end;

procedure TDacF.Add(pItmNum:longint;pAccSnt:Str3;pAccAnl:Str6;pCrdVal,pDebVal:double); // Prida uètovný zápis do doèasného súboru
var mStkNum:word;
begin
  If DateInActYear (E_DocDate.AsDateTime) then begin
    If IsNotNul(pCrdVal+pDebVal) then begin // Ak uctovny zapis ma nulovu hodnotu neulozime
      If not ohACCSNT.LocateAccSnt(pAccSnt) then E_Err.Lines.Add('Chybný syntetický úèet: '+pAccSnt);
      If ohACCANL.LocateSnAn(pAccSnt,pAccAnl)
        then oDesTxt := ohACCANL.AnlName
        else E_Err.Lines.Add('Chybný analytický úèet: '+pAccSnt+' '+pAccAnl);
      If pItmNum=0 then pItmNum := otDAC.Count+1;
      If otDAC.LocatePrimary(pItmNum,oCntNum,oWriNum,oStkNum,oOcdNum,oConDoc,pAccSnt,pAccAnl) then begin
        otDAC.Edit;
        otDAC.CrdVal := otDAC.CrdVal+pCrdVal;
        otDAC.DebVal := otDAC.DebVal+pDebVal;
        otDAC.Post;
      end
      else begin
        C_Ind.AsInteger := C_Ind.AsInteger+1;
        otDAC.Insert;
        otDAC.ItmNum := pItmNum;
        otDAC.ExtNum := oExtNum;
        otDAC.StkNum := oStkNum;
        otDAC.WriNum := oWriNum;
        otDAC.CntNum := oCntNum;
        otDAC.OcdNum := oOcdNum;
        otDAC.ConDoc := oConDoc;
        otDAC.AccSnt := pAccSnt;
        otDAC.AccAnl := pAccAnl;
        otDAC.CrdVal := pCrdVal;
        otDAC.DebVal := pDebVal;
        otDAC.DocDate := E_DocDate.AsDateTime;
        otDAC.Describe := oDesTxt;
        otDAC.SmCode := oSmCode;
        otDAC.PaCode := oPaCode;
        otDAC.SpaCode := oSpaCode;
        otDAC.BegRec := oBegRec;
        otDAC.Post;
      end;
    end;
  end
  else E_Err.Lines.Add('Chybný dátum: '+DateToStr(E_DocDate.AsDateTime));
  C_Ind.AsInteger := C_Ind.AsInteger+1;
  Application.ProcessMessages;
end;

procedure TDacF.Save;
begin
  Del(E_DocNum.AsString);
//  If not AccErr then begin
    If otDAC.Count>0 then begin
      PB_Ind.Max := otDAC.Count;    PB_Ind.Position := 0;
      otDAC.First;
      Repeat
        PB_Ind.StepBy(1);
        C_Ind.AsInteger := C_Ind.AsInteger-1;
        ohJOURNAL.Insert;
        ohJOURNAL.DocNum := E_DocNum.AsString;
        PX_To_BTR(otDAC.TmpTable,ohJOURNAL.BtrTable);
        If ohJOURNAL.ItmNum=0 then ohJOURNAL.ItmNum := otDAC.TmpTable.RecNo;
        // Docasne pokial nsspravime ukladanie zahranicnej meny
        ohJOURNAL.CredVal := otDAC.CrdVal;
        ohJOURNAL.FgCourse := 1;
        ohJOURNAL.FgCrdVal := ohJOURNAL.CredVal;
        ohJOURNAL.FgDebVal := ohJOURNAL.DebVal;
        ohJOURNAL.Post;
        Application.ProcessMessages;
        otDAC.Next;
      until otDAC.Eof;
    end;
//  end;
  Hide;
  If AccErr then begin
    Height := 400;
    ShowModal;
  end;
end;

procedure TDacF.B_ExiClick(Sender: TObject);
begin
  Close;
end;

end.


