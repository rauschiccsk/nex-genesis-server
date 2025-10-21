unit Oac;

interface

uses
  IcTypes, IcConst, IcVariab, IcTools, IcConv, IcDate,
  NexGlob, NexPath, NexIni, NexMsg, NexError, DocHand, NumText,
  Key, PayFnc, Csd, Isd, Icd, hFINJRN, hACCANL, tOAC,
  LangForm, Controls, ExtCtrls, Classes, StdCtrls, Buttons, Windows, Messages,
  SysUtils, Graphics, Forms, Dialogs, ComCtrls, IcLabels, IcInfoFields,
  IcProgressBar, DB, BtrTable, NexBtrTable, CmpTools, DBTables, NexPxTable,
  PxTable, IcStand, IcEditors, IcButtons, xpComp;

type
  TOac = class(TLangForm)
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
    procedure FormShow(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
  private
      oFrmName:Str15;
      oPayItm:word;
      oPayDate:TDateTime;
      procedure AccCsd; // Rozuctovanie zadaneho pokladnicneho dokladu
      procedure AccSod; // Rozuctovanie zadaneho bankoveho vypisu

      procedure AccIsd(pInvDoc:Str12); // Rozuctovanie zadaneho pokladnicneho dokladu
      procedure AccIcd(pInvDoc:Str12); // Rozuctovanie zadaneho bankoveho vypisu
      procedure ColIsi(pInvDoc:Str12); // Kumulatiovne nacita polozky zadanej DF podla kodu uctovania
      procedure ColIci(pInvDoc:Str12); // Kumulatiovne nacita polozky zadanej OF podla kodu uctovania
      procedure ColPmi(pInvDoc:Str12;var pOldPay,pActPay:double); // Nacita uhrady zadanej faktury
      procedure AddOac(pPreced:Str1;pAccSnt:Str3;pAccAnl:Str6;pVatPrc:byte;pValue:double);
      procedure DelOac; // Vymaze polozky z databazoveho suboru OAC.DB
      procedure AddJrn(pPayDoc:Str12;pPayItm:word;pWriNum:word;pPayDate:TDateTime;pConDoc,pExtNum:Str12;pPaCode:longint;pOpType:Str1;pVatSnt:Str3;pVatAnl:Str6); // Ulozi ucttovne zapisy do penazneho dennika
      procedure AddJrnVal(pPayDoc:Str12;pPayItm:word;pWriNum:word;pPayDate:TDateTime;pConDoc,pExtNum:Str12;pPaCode:longint;pOpType:Str1;pSnt:Str3;pAnl:Str6;pVal:Double); // Ulozi uctovne zapisy do penazneho dennika
      function GetAccErr:boolean;
  public
      oPay:TPayFnc;
      oCsd:TCsd;
//      oSod:TSod;
      oIsd:TIsd;
      oIcd:TIcd;
      otOac:TOacTmp;
      ohACCANL:TAccanlHnd;
      ohFINJRN:TFinjrnHnd;
      oExit : boolean;
      procedure Clear;
      procedure Acc(pPayDoc:Str12);
      property AccErr:boolean read GetAccErr;
  end;

implementation

{$R *.DFM}


//*************************** CLASS *****************************
procedure TOac.FormCreate(Sender: TObject);
begin
  oExit:=False;
  Height:=170;
  Clear;
  oCsd:=TCsd.Create(Self);
//  oSod:=TSod.Create(Self);
  oIsd:=TIsd.Create(Self);
  oIcd:=TIcd.Create(Self);
  oPay:=TPayFnc.Create;
  ohACCANL:=TAccanlHnd.Create;  ohACCANL.Open;
  ohFINJRN:=TFinjrnHnd.Create;  ohFINJRN.Open;
end;

procedure TOac.FormDestroy(Sender: TObject);
begin
  FreeAndNil (ohFINJRN);
  FreeAndNil (ohACCANL);
  FreeAndNil (oPay);
  FreeAndNil (oIcd);
  FreeAndNil (oIsd);
//  FreeAndNil (oSod);
  FreeAndNil (oCsd);
end;

procedure TOac.B_ExiClick(Sender: TObject);
begin
  Close;
  oExit:=True;
end;

// ********************************* PRIVATE ***********************************

procedure TOac.Clear;
begin
  C_Ind.AsInteger:=0;
  PB_Ind.Position:=0;
  E_Err.Clear;
end;

procedure TOac.AccCsd; // Rozuctovanie zadaneho pokladnicneho dokladu
var mInvBok,mBokNum:Str5;  mDocTyp:byte;  mOpType:Str1; mValue:double;
    mAccSnt:Str3;  mAccAnl:Str6;
begin
  mBokNum:=BookNumFromDocNum(E_DocNum.Text);
  With oCsd do begin
    Open(mBokNum);
    SlcItm(E_DocNum.Text);
    If ohCSH.LocateDocNum(E_DocNum.Text) then E_DocDate.AsDateTime:=ohCSH.DocDate;
    If otCSI.Count>0 then begin
      PB_Ind.Max:=otCSI.Count;PB_Ind.Step:=1;PB_Ind.Position:=0;
      C_Ind.AsInteger:=otCSI.Count;
      otCSI.First;
      Repeat
        PB_Ind.StepIt;
        C_Ind.AsInteger:=C_Ind.AsInteger-1;
        Application.ProcessMessages;
        oPayItm:=otCSI.ItmNum;
        oPayDate:=otCSI.DocDate;
        DelOac; // Vymaze polozky z databazoveho suboru OAC.DB
        mDocTyp:=GetDocType(otCSI.ConDoc);
        mInvBok:=BookNumFromDocNum(otCSI.ConDoc);
        mOpType:='P';
        If otCSI.DocType='E' then mOpType:='V';
        case mDocTyp of
          dtIS: begin
                  AccIsd(otCSI.ConDoc); // Rozuctovanie zadaneho pokladnicneho dokladu
                  AddJrn(otCSI.DocNum,otCSI.ItmNum,otCSI.WriNum,otCSI.DocDate,otCSI.ConDoc,otCSI.ConExt,otCSI.PaCode,mOpType,gKey.IsbVatSnt[mInvBok],gKey.IsbVatAnl[mInvBok]); // Ulozi ucttovne zapisy do penazneho dennika
                end;
          dtIC: begin
                  AccIcd(otCSI.ConDoc); // Rozuctovanie zadaneho bankoveho vypisu
                  AddJrn(otCSI.DocNum,otCSI.ItmNum,otCSI.WriNum,otCSI.DocDate,otCSI.ConDoc,otCSI.ConExt,otCSI.PaCode,mOpType,gKey.IcbVatSnt[mInvBok],gKey.IcbVatAnl[mInvBok]); // Ulozi ucttovne zapisy do penazneho dennika
                end;
          else begin
            If otCSI.DocType='E'
              then mValue:=0-otCSI.AcAValue
              else mValue:=otCSI.AcAValue;
            If IsNotNul(mValue) then begin
              mAccSnt:=otCSI.AccSnt;
              mAccAnl:=otCSI.AccAnl;
              AddJrnVal(otCSI.DocNum,otCSI.ItmNum,otCSI.WriNum,otCSI.DocDate,otCSI.ConDoc,otCSI.ConExt,otCSI.PaCode,mOpType,mAccSnt,mAccAnl,mValue); // Ulozi ucttovne zapisy do penazneho dennika
            end;
            // DPH
            If otCSI.DocType='E' then begin
              mValue:=(otCSI.AcAValue-otCSI.AcBValue);
              mAccSnt:=gKey.CsbVaiSnt[mBokNum];
              mAccAnl:=gKey.CsbVaiAnl[mBokNum];
            end
            else begin
              mValue:=(otCSI.AcBValue-otCSI.AcAValue);
              mAccSnt:=gKey.CsbVaoSnt[mBokNum];
              mAccAnl:=gKey.CsbVaoAnl[mBokNum];
            end;
            If IsNotNul (mValue) then begin
              AddJrnVal(otCSI.DocNum,otCSI.ItmNum,otCSI.WriNum,otCSI.DocDate,otCSI.ConDoc,otCSI.ConExt,otCSI.PaCode,mOpType,mAccSnt,mAccAnl,mValue); // Ulozi ucttovne zapisy do penazneho dennika
            end;

          end;
        end;
        Application.ProcessMessages;
        otCSI.Next;
      until otCSI.Eof;
    end;
  end;
end;

procedure TOac.AccSod; // Rozuctovanie zadaneho bankoveho vypisu
var mInvBok,mBokNum:Str5;  mDocTyp:byte;  mOpType:Str1;
begin
(*
  mBokNum:=BookNumFromDocNum(E_DocNum.Text);
  With oSod do begin
    Open(mBokNum);
    If ohSOH.LocateDocNum(E_DocNum.Text) then E_DocDate.AsDateTime:=ohSOH.DocDate;
    SlcItm(E_DocNum.Text);
    If otSOI.Count>0 then begin
      PB_Ind.Max:=otSOI.Count;PB_Ind.Step:=1;PB_Ind.Position:=0;
      C_Ind.AsInteger:=otSOI.Count;
      otSOI.First;
      Repeat
        PB_Ind.StepIt;
        C_Ind.AsInteger:=C_Ind.AsInteger-1;
        Application.ProcessMessages;
        oPayItm:=otSOI.ItmNum;
        oPayDate:=otSOI.DocDate;
        DelOac; // Vymaze polozky z databazoveho suboru OAC.DB
        mDocTyp:=GetDocType(otSOI.ConDoc);
        mInvBok:=BookNumFromDocNum(otSOI.ConDoc);
        mOpType:='P';
        If otSOI.PyPayVal<0 then mOpType:='V';
        case mDocTyp of
          dtIS: begin
                  AccIsd(otSOI.ConDoc); // Rozuctovanie zadaneho pokladnicneho dokladu
                  AddJrn(otSOI.DocNum,otSOI.ItmNum,otSOI.WriNum,otSOI.DocDate,otSOI.ConDoc,otSOI.ExtNum,otSOI.PaCode,mOpType,gKey.IsbVatSnt[mInvBok],gKey.IsbVatAnl[mInvBok]); // Ulozi ucttovne zapisy do penazneho dennika
                end;
          dtIC: begin
                  AccIcd(otSOI.ConDoc); // Rozuctovanie zadaneho bankoveho vypisu
                  AddJrn(otSOI.DocNum,otSOI.ItmNum,otSOI.WriNum,otSOI.DocDate,otSOI.ConDoc,otSOI.ExtNum,otSOI.PaCode,mOpType,gKey.IcbVatSnt[mInvBok],gKey.IcbVatAnl[mInvBok]); // Ulozi ucttovne zapisy do penazneho dennika
                end;
          else begin
            AddJrnVal(otSOI.DocNum,otSOI.ItmNum,otSOI.WriNum,otSOI.DocDate,otSOI.ConDoc,otSOI.ExtNum,otSOI.PaCode,mOpType,otSOI.DocSnt,otSOI.DocAnl,otSOI.AcPayVal); // Ulozi ucttovne zapisy do penazneho dennika
          end;
        end;
        Application.ProcessMessages;
        otSOI.Next;
      until otSOI.Eof;
    end;
  end;
*)
end;

procedure TOac.AccIsd(pInvDoc:Str12); // Rozuctovanie zadaneho pokladnicneho dokladu
var mBokNum:Str5;  mOldPay,mActPay:double;  mSign:integer;
begin
  mBokNum:=BookNumFromDocNum(pInvDoc);
  oIsd.Open(mBokNum,TRUE,TRUE,FALSE);
  ColIsi(pInvDoc);  // Kumulatiovne nacita polozky zadanej DF podla kodu uctovania
  If otOac.Count>0 then begin
    ColPmi(pInvDoc,mOldPay,mActPay); // Nacita uhrady zadanej faktury
    otOac.First;
    Repeat
      otOac.Edit;
      If IsNotNul(mOldPay) then begin // Zapocitame predchadzajucu uhradu
        mSign:=Sign(otOac.MovVal);
        If Abs(otOac.MovVal)>Abs(mOldPay)
          then otOac.OldPay:=Abs(mOldPay)*mSign
          else otOac.OldPay:=otOac.MovVal;
        otOac.NpyVal:=otOac.MovVal-otOac.OldPay;
        mOldPay:=mOldPay-otOac.OldPay;
      end;
      If IsNotNul(otOac.NpyVal) then begin // Zapocitame aktualnu uhradu
        mSign:=Sign(otOac.NpyVal);
        If Abs(otOac.NpyVal)>Abs(mActPay)
          then otOac.ActPay:=Abs(mActPay)*mSign
          else otOac.ActPay:=otOac.NpyVal;
        otOac.EndVal:=mActPay-otOac.ActPay;
        mActPay:=mActPay-otOac.ActPay;
      end;
      otOac.AccVal:=otOac.ActPay/(1+otOac.VatPrc/100);
      otOac.AccVat:=otOac.ActPay-otOac.AccVal;
      otOac.Post;
      otOac.Next;
    until otOac.Eof;
    If IsNotNul(mActPay) then begin  // Preplatok faktury
      otOac.Insert;
      otOac.AccSnt:='998';  // Preplatok DF
      otOac.VatGrp:=1;
      otOac.AccVal:=mActPay;
      otOac.Post;
    end;
  end;
end;

procedure TOac.AccIcd(pInvDoc:Str12); // Rozuctovanie zadaneho bankoveho vypisu
var mBokNum:Str5;  mOldPay,mActPay:double;  mSign:integer;
begin
  mBokNum:=BookNumFromDocNum(pInvDoc);
  oIcd.Open(mBokNum,TRUE,TRUE,FALSE);
  ColIci(pInvDoc);  // Kumulatiovne nacita polozky zadanej DF podla kodu uctovania
  If otOac.Count>0 then begin
    ColPmi(pInvDoc,mOldPay,mActPay); // Nacita uhrady zadanej faktury
    otOac.First;
    Repeat
      otOac.Edit;
      If IsNotNul(mOldPay) then begin // Zapocitame predchadzajucu uhradu
        mSign:=Sign(otOac.MovVal);
        If Abs(otOac.MovVal)>Abs(mOldPay)
          then otOac.OldPay:=Abs(mOldPay)*mSign
          else otOac.OldPay:=otOac.MovVal;
        otOac.NpyVal:=otOac.MovVal-otOac.OldPay;
        mOldPay:=mOldPay-otOac.OldPay;
      end;
      If IsNotNul(otOac.NpyVal) then begin // Zapocitame aktualnu uhradu
        mSign:=Sign(otOac.NpyVal);
        If Abs(otOac.NpyVal)>Abs(mActPay)
          then otOac.ActPay:=Abs(mActPay)*mSign
          else otOac.ActPay:=otOac.NpyVal;
        otOac.EndVal:=mActPay-otOac.ActPay;
        mActPay:=mActPay-otOac.ActPay;
      end;
      otOac.AccVal:=otOac.ActPay/(1+otOac.VatPrc/100);
      otOac.AccVat:=otOac.ActPay-otOac.AccVal;
      otOac.Post;
      otOac.Next;
    until otOac.Eof;
    If IsNotNul(mActPay) then begin  // Preplatok faktury
      otOac.Insert;
      otOac.AccSnt:='999';  // Preplatok OF
      otOac.VatGrp:=1;
      otOac.AccVal:=mActPay;
      otOac.Post;
    end;
  end;
end;

procedure TOac.ColIsi(pInvDoc:Str12);  // Kumulatiovne nacita polozky zadanej DF podla kodu uctovania
var mAccSnt:Str3;  mAccAnl:Str6;  mSrvMgc:word;  mDocSig:integer;
begin
  mSrvMgc:=gIni.ServiceMg;
  With oIsd do begin
    If ohISH.LocateDocNum(pInvDoc) then begin
      mDocSig:=Sign(ohISH.AcEValue);
      If ohISI.LocateDocNum(pInvDoc) then begin
        Repeat
          mAccSnt:=ohISI.AccSnt;
          mAccAnl:=ohISI.AccAnl;
          If mAccSnt='' then begin
            If ohISI.MgCode<mSrvMgc then begin
              If ohISI.AcEValue>0 then begin
                mAccSnt:=gKey.IsbGscSnt[BokNum];
                mAccAnl:=gKey.IsbGscAnl[BokNum];
              end else begin
                mAccSnt:=gKey.IsbGsdSnt[BokNum];
                mAccAnl:=gKey.IsbGsdAnl[BokNum];
              end;
            end
            else begin
              If ohISI.AcEValue>0 then begin
                mAccSnt:=gKey.IsbSecSnt[BokNum];
                mAccAnl:=gKey.IsbSecAnl[BokNum];
              end else begin
                mAccSnt:=gKey.IsbSedSnt[BokNum];
                mAccAnl:=gKey.IsbSedAnl[BokNum];
              end;
            end;
          end;
          If mDocSig<>Sign(ohISI.AcEValue)
            then AddOac('A',mAccSnt,mAccAnl,ohISI.VatPrc,ohISI.AcEValue*(-1))
            else AddOac('B',mAccSnt,mAccAnl,ohISI.VatPrc,ohISI.AcEValue*(-1));
          ohISI.Next;
        until ohISI.Eof or (ohISI.DocNum<>pInvDoc);
      end;
    end;
  end;
end;

procedure TOac.ColIci(pInvDoc:Str12);  // Kumulatiovne nacita polozky zadanej OF podla kodu uctovania
var mAccSnt:Str3;  mAccAnl:Str6;  mSrvMgc:word;  mDocSig:integer;
begin
  mSrvMgc:=gIni.ServiceMg;
  With oIcd do begin
    If ohICH.LocateDocNum(pInvDoc) then begin
      mDocSig:=Sign(ohICH.AcBValue);
      If ohICI.LocateDocNum(pInvDoc) then begin
        Repeat
          mAccSnt:=ohICI.AccSnt;
          mAccAnl:=ohICI.AccAnl;
          If mAccSnt='' then begin
            If ohICI.MgCode<mSrvMgc then begin
              mAccSnt:=gKey.IcbGscSnt[BokNum];
              mAccAnl:=gKey.IcbGscAnl[BokNum];
            end
            else begin
              mAccSnt:=gKey.IcbSecSnt[BokNum];
              mAccAnl:=gKey.IcbSecAnl[BokNum];
            end;
          end;
          If mDocSig<>Sign(ohICI.AcBValue)
            then AddOac('A',mAccSnt,mAccAnl,ohICI.VatPrc,ohICI.AcBValue)
            else AddOac('B',mAccSnt,mAccAnl,ohICI.VatPrc,ohICI.AcBValue);
          ohICI.Next;
        until ohICI.Eof or (ohICI.DocNum<>pInvDoc);
      end;
    end;
  end;
end;

procedure TOac.ColPmi(pInvDoc:Str12;var pOldPay,pActPay:double); // Nacita uhrady zadanej faktury
var I:byte;
begin
  oPay.ClcPayVal(pInvDoc,oPayDate,0);
  pOldPay:=0;
  pActPay:=oPay.InvAcv;
(*
  pOldPay:=0;    pActPay:=0;
  With oPmi do begin
    If OpenCount>0 then begin
      For I:=1 to OpenCount do begin
        Activate(I);
        If ohPMI.LocateConDoc(pInvDoc) then begin
          Repeat
            If ohPMI.PayDate<=oPayDate then begin
              If (ohPMI.DocNum=E_DocNum.Text) then begin
                If (ohPMI.ItmNum<=oPayItm) then begin
                  If (ohPMI.ItmNum<oPayItm)
                    then pOldPay:=pOldPay+ohPMI.AcPayVal
                    else pActPay:=pActPay+ohPMI.AcPayVal;
                end;
              end
              else pOldPay:=pOldPay+ohPMI.AcPayVal;
            end;
            ohPMI.Next;
          until ohPMI.Eof or (ohPMI.ConDoc<>pInvDoc);
        end;
      end;
    end;
  end;
*)
end;

procedure TOac.AddOac(pPreced:Str1;pAccSnt:Str3;pAccAnl:Str6;pVatPrc:byte;pValue:double);
begin
  If otOac.LocatePrAsAnVp(pPreced,pAccSnt,pAccAnl,pVatPrc)
    then otOac.Edit
    else begin
      otOac.Insert;
      otOac.Preced:=pPreced;
      otOac.AccSnt:=pAccSnt;
      otOac.AccAnl:=pAccAnl;
      otOac.VatGrp:=VatGrp(pVatPrc);
      otOac.VatPrc:=pVatPrc;
    end;
    otOac.MovVal:=otOac.MovVal+pValue;
    otOac.NpyVal:=otOac.NpyVal+pValue;
    otOac.Post;
end;

procedure TOac.DelOac; // Vymaze polozky z databazoveho suboru OAC.DB
begin
  If otOac.Count>0 then begin
    otOac.First;
    Repeat
      otOac.Delete;
    until otOac.Count=0;
  end;
end;

procedure TOac.AddJrn(pPayDoc:Str12;pPayItm:word;pWriNum:word;pPayDate:TDateTime;pConDoc,pExtNum:Str12;pPaCode:longint;pOpType:Str1;pVatSnt:Str3;pVatAnl:Str6); // Ulozi ucttovne zapisy do penazneho dennika
var mAccVat:double;
begin
  If otOac.Count>0 then begin
    mAccVat:=0;
    otOac.First;
    Repeat
      If IsNotNul (otOac.AccVal) then begin
        ohFINJRN.Insert;
        ohFINJRN.DocNum:=pPayDoc;
        ohFINJRN.ItmNum:=pPayItm;
        ohFINJRN.WriNum:=pWriNum;
        ohFINJRN.DocDate:=pPayDate;
        ohFINJRN.CndNum:=pConDoc;
        ohFINJRN.CneNum:=pExtNum;
        ohFINJRN.PaCode:=pPaCode;
        ohFINJRN.AccSnt:=otOac.AccSnt;
        ohFINJRN.AccAnl:=otOac.AccAnl;
        ohFINJRN.AcValue:=Rd2(otOac.AccVal);
        ohFINJRN.FgValue:=Rd2(otOac.AccVal);
        If ohACCANL.LocateSnAn(otOac.AccSnt,otOac.AccAnl) then begin
          ohFINJRN.AccText:=ohACCANL.AnlName;
          ohFINJRN.FjrRow:=ValInt(ohACCANL.FjrRow);
        end else begin
          E_Err.Lines.Add('Chybajuci ucet : '+otOac.AccSnt+'/'+otOac.AccAnl+' v '+pPayDoc+' '+pConDoc);
        end;
        ohFINJRN.OpType:=pOpType;
        ohFINJRN.Post;
      end;
      mAccVat:=mAccVat+otOac.AccVat;
      otOac.Next;
    until (otOac.Eof);
    If IsNotNul(mAccVat) then begin  // Zauctujeme DPH
      ohFINJRN.Insert;
      ohFINJRN.DocNum:=pPayDoc;
      ohFINJRN.ItmNum:=pPayItm;
      ohFINJRN.WriNum:=pWriNum;
      ohFINJRN.DocDate:=pPayDate;
      ohFINJRN.CndNum:=pConDoc;
      ohFINJRN.CneNum:=pExtNum;
      ohFINJRN.PaCode:=pPaCode;
      ohFINJRN.AccSnt:=pVatSnt;
      ohFINJRN.AccAnl:=pVatAnl;
      ohFINJRN.AcValue:=Rd2(mAccVat);
      ohFINJRN.FgValue:=Rd2(mAccVat);
      If ohACCANL.LocateSnAn(pVatSnt,pVatAnl) then begin
        ohFINJRN.AccText:=ohACCANL.AnlName;
        ohFINJRN.FjrRow:=ValInt(ohACCANL.FjrRow);
      end else begin
        E_Err.Lines.Add('Chybajuci ucet : '+pVatSnt+'/'+pVatAnl+' v '+pPayDoc+' '+pConDoc);
      end;
      ohFINJRN.OpType:=pOpType;
      ohFINJRN.Post;
    end;
  end;
end;

procedure TOac.AddJrnVal(pPayDoc:Str12;pPayItm:word;pWriNum:word;pPayDate:TDateTime;pConDoc,pExtNum:Str12;pPaCode:longint;pOpType:Str1;pSnt:Str3;pAnl:Str6;pVal:Double); // Ulozi ucttovne zapisy do penazneho dennika
var mAccVat:double;
begin
  If IsNotNul (pVal) then begin
    ohFINJRN.Insert;
    ohFINJRN.DocNum:=pPayDoc;
    ohFINJRN.ItmNum:=pPayItm;
    ohFINJRN.WriNum:=pWriNum;
    ohFINJRN.DocDate:=pPayDate;
    ohFINJRN.CndNum:=pConDoc;
    ohFINJRN.CneNum:=pExtNum;
    ohFINJRN.PaCode:=pPaCode;
    ohFINJRN.AccSnt:=pSnt;
    ohFINJRN.AccAnl:=pAnl;
    ohFINJRN.AcValue:=Rd2(pVal);
    ohFINJRN.FgValue:=Rd2(pVal);
    If ohACCANL.LocateSnAn(pSnt,pAnl) then begin
      ohFINJRN.AccText:=ohACCANL.AnlName;
      ohFINJRN.FjrRow:=ValInt(ohACCANL.FjrRow);
    end else begin
      E_Err.Lines.Add('Chybajuci ucet : '+psnt+'/'+pAnl+' v '+pPayDoc+' '+pConDoc);
    end;
    ohFINJRN.OpType:=pOpType;
    ohFINJRN.Post;
  end;
end;

// ********************************** PUBLIC ***********************************

procedure TOac.Acc(pPayDoc:Str12);
var mDocTyp:byte;
begin
  Clear;
  Height:=170;
  E_DocNum.Text:=pPayDoc;
  Show;
  mDocTyp:=GetDocType (E_DocNum.Text);
  ohFINJRN.DocDel(E_DocNum.Text);
  otOac:=TOacTmp.Create;  otOac.Open;
  case mDocTyp of
    dtCS: AccCsd; // Rozuctovanie zadaneho pokladnicneho dokladu
    dtSO: AccSod; // Rozuctovanie zadaneho bankoveho vypisu
  end;
  FreeAndNil(otOac);
  If GetAccErr then begin
    oExit:=False;
    Height:= 420;
    repeat
      Application.ProcessMessages;
    until oExit;
  end;
end;

function TOac.GetAccErr:boolean;
begin
  Result:=E_Err.Lines.Count>0;
end;

procedure TOac.FormShow(Sender: TObject);
begin
//   with self do SetWindowPos(Handle,HWND_TOPMOST,Left,Top,Width,Height,SWP_NOACTIVATE or SWP_NOMOVE or SWP_NOSIZE);
 SetWindowPos(Self.Handle,HWND_TOPMOST,0, 0, 0, 0,SWP_NOMOVE or SWP_NOSIZE or SWP_SHOWWINDOW);
end;

procedure TOac.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  oExit:=True;
end;

end.
