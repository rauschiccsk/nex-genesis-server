unit JrnAcc;

interface

uses
  LangForm, TxtCut, NexMsg, NexPath, NexError, DocHand, NexIni, Key, Prp, AccFnc,
  IcTypes, IcConst, IcVariab, IcTools, IcConv, IcDate, NexText,
  Controls, ExtCtrls, Classes, StdCtrls, Buttons, Windows, Messages,
  SysUtils, Graphics, Forms, Dialogs, ComCtrls, IcLabels, IcInfoFields,
  IcProgressBar, DB, BtrTable, NexBtrTable, CmpTools, DBTables, NexPxTable,
  PxTable, IcStand, IcEditors, IcButtons;    

type
  TF_JrnAccF = class(TLangForm)
    Panel1: TPanel;
    LeftLabel1: TLeftLabel;
    LeftLabel2: TLeftLabel;
    DinamicPanel1: TDinamicPanel;
    CenterLabel1: TCenterLabel;
    PB_Indicator: TIcProgressBar;
    L_ItmCnt: TLongInfo;
    CenterLabel2: TCenterLabel;
    L_DocNum: TNameInfo;
    CenterLabel3: TCenterLabel;
    ptACC: TPxTable;
    btSTKLST: TNexBtrTable;
    btJOURNAL: TNexBtrTable;
    btWRILST: TNexBtrTable;
    L_ExtNum: TNameInfo;
    btSMLST: TNexBtrTable;
    btICI: TNexBtrTable;
    btSOI: TNexBtrTable;
    btISI: TNexBtrTable;
    btCSI: TNexBtrTable;
    btTCH: TNexBtrTable;
    btTSH: TNexBtrTable;
    btACCANL: TNexBtrTable;
    btOWI: TNexBtrTable;
    btPMI: TNexBtrTable;
    procedure FormCreate(Sender: TObject);
    procedure CancelButton1Click(Sender: TObject);
    procedure ptACCBeforeOpen(DataSet: TDataSet);
    procedure FormDestroy(Sender: TObject);
  private
    oAcc:TAccFnc;
    oAbort: boolean;
    oSntErr: boolean;  // TRUE ak nebol zadany synteticky ucet
    oAnlErr: boolean;  // TRUE ak analytický úèet nie je zaevidovaný v úètovnej osonnove
    oCrdVal: double;   // Kumulativna hodnota UZ dokladu strany MD
    oDebVal: double;   // Kumulativna hodnota UZ dokladu strany DAL
    function GetAnlName (pAccSnt:Str3;pAccAnl:Str6):Str30; // Nazov zadaneho analytickeho uctu
    procedure SideSum;  // Spocita strany MD a DAL
    procedure AddToAccAnl (pAccSnt:Str3;pAccAnl:Str6;pAnlName:Str30);
    procedure TmpAcc (pItmNum,pStkNum,pWriNum,pCentNum:word;
                      pAccSnt:Str3; pAccAnl:Str6; pCredVal,pDebVal:double;
                      pAccDate:TDateTime; pDescribe:Str30; pOcdNum,pConDoc:Str12;
                      pAccStk,pAccWri,pAccCen,pOcdAcc:boolean;pBegRec:byte;
                      pSmCode:word;pPaCode,pSpaCode:longint);
    procedure AddTmpToJour; // Vymaze stare a ulozi nove uctovne zapisy do dennika UZ
    procedure AccountIM (pIMH:TNexBtrTable);  // Rozuctuje SP
    procedure AccountOM (pOMH:TNexBtrTable);  // Rozuctuje SV
    procedure AccountRM (pRMH:TNexBtrTable);  // Rozuctuje MP
    procedure AccountTC (pTCH:TNexBtrTable);  // Rozuctuje ODL
    procedure AccountIC (pICH:TNexBtrTable);  // Rozuctuje OF
    procedure AccountTS (pTSH:TNexBtrTable);  // Rozuctuje DDL
    procedure AccountSA (pSAH:TNexBtrTable);  // Rozuctuje SA
    procedure AccountIS (pISH:TNexBtrTable);  // Rozuctuje DF
//    procedure AccountSO (pSOH:TNexBtrTable);  // Rozuctuje BV
    procedure AccountCS (pCSH:TNexBtrTable);  // Rozuctuje HP
    procedure AccountID (pIDH,pIDI:TNexBtrTable);// Rozuctuje ID
    procedure AccountSV (pSPV:TNexBtrTable);     // Rozuctuje SV - danove doklady zalohovych platieb
    procedure AccountMI (pMTBIMD:TNexBtrTable);  // Rozuctuje prijem MTZ
    procedure AccountMO (pMTBOMD:TNexBtrTable);  // Rozuctuje vydaj MTZ
    procedure AccountOW (pOWH:TNexBtrTable);     // Rozuctuje vydaj SC
  public
    procedure DelDoc(pDocNum:Str12);
    procedure DelAcc(pHEAD:TNexBtrTable);
    procedure Execute(pHEAD:TNexBtrTable;pShow:boolean);
    procedure ExecuteBeg (pHEAD:TNexBtrTable;pShow:boolean);
    procedure AccountVD;  // Rozuctuje VD - uzavierka DPH
  end;

  function AccAnlGen (pAnlFrm:Str6;pNum:longint):Str6; // Hodnota funkcia je analyticky ucet vytvoreny s dosadenim cisla pNum do formatu analytickeho uctu pAnlFrm

var
  F_JrnAccF: TF_JrnAccF;

implementation

uses
  DM_SYSTEM, DM_LDGDAT, DM_STKDAT, DM_CABDAT, DM_DLSDAT,
  PrpAcc;

{$R *.DFM}

//************************** APPLIC *****************************

function AccAnlGen (pAnlFrm:Str6;pNum:longint):Str6; // Hodnota funkcia je analyticky ucet vytvoreny s dosadenim cisla pNum do formatu analytickeho uctu pAnlFrm
var mNumChar:Str1; // Znak namiesto ktoreho treba dosadit zadane cislo
    mPos,mLen:byte;
begin
  Result:=UpString (pAnlFrm);
  If Pos ('S',Result)>0 then mNumChar:='S';
  If Pos ('P',Result)>0 then mNumChar:='P';
  If Pos ('N',Result)>0 then mNumChar:='N';
  If Pos ('V',Result)>0 then mNumChar:='V';
  If Pos ('C',Result)>0 then mNumChar:='C';

  mPos:=Pos (mNumChar,Result);
  If mPos>0 then begin
    mLen:=0;
    Repeat
      Delete (Result,mPos,1);
      Inc (mLen);
    until Pos (mNumChar,Result)=0;
    Insert (StrIntZero(pNum,mLen),Result,mPos);
  end;
end;

//*************************** CLASS *****************************
procedure TF_JrnAccF.FormCreate(Sender: TObject);
begin
  oAbort:=FALSE;
  btJOURNAL.Open;
  btSMLST.Open;    btSMLST.IndexName:='SmCode';
  btSTKLST.Open;
  btWRILST.Open;
  btACCANL.Open;   btACCANL.IndexName:='SnAn';
  oAcc:=TAccFnc.Create;
end;

procedure TF_JrnAccF.FormDestroy(Sender: TObject);
begin
  FreeAndNil(oAcc);
  btJOURNAL.Close;
  btSMLST.Close;
  btSTKLST.Close;
  btWRILST.Close;
  btACCANL.Close;
end;

procedure TF_JrnAccF.DelDoc (pDocNum:Str12);
begin
  btJOURNAL.SwapIndex;
  btJOURNAL.IndexName:='DocNum';
  While btJOURNAL.Findkey ([pDocNum]) do begin
    btJOURNAL.Delete;
    Application.ProcessMessages;
  end;
  btJOURNAL.RestoreIndex;
end;

procedure TF_JrnAccF.DelAcc(pHEAD:TNexBtrTable);
begin
  DelDoc(pHEAD.FieldByName ('DocNum').AsString);
  pHEAD.Edit;
  If pHEAD.FindField('DocSnt')<>nil then pHEAD.FieldByName ('DocSnt').AsString:='';
  If pHEAD.FindField('DocAnl')<>nil then pHEAD.FieldByName ('DocAnl').AsString:='';
  If pHEAD.FindField('DstAcc')<>nil then pHEAD.FieldByName ('DstAcc').AsString:='';
  pHEAD.Post;
end;

procedure TF_JrnAccF.Execute (pHEAD:TNexBtrTable;pShow:boolean);
begin
  try
    oSntErr:=FALSE;  oAnlErr:=FALSE;
    oCrdVal:=0;   oDebVal:=0;
    If pShow then Show;
    L_DocNum.Text:=pHEAD.FieldByName('DocNum').AsString;
    Application.ProcessMessages;
    ptACC.Open;
    case GetDocType (L_DocNum.Text) of
      dtIM: AccountIM (pHEAD); // Interne skladove prijemky
      dtOM: AccountOM (pHEAD); // Interne skladove vydajky
      dtRM: AccountRM (pHEAD); // Medziskladove presuny
      dtTS: AccountTS (pHEAD); // Dodavatelske dodacie listy
      dtIS: AccountIS (pHEAD); // Dodavatelske faktury
      dtTC: AccountTC (pHEAD); // Odberatelske dodacie listy
      dtSA: AccountSA (pHEAD); // Vydajky MO predaja
      dtIC: AccountIC (pHEAD); // Odberatelske faktury
//      dtSO: AccountSO (pHEAD); // Bankove vypisy
      dtCS: AccountCS (pHEAD); // Hotovostna pokladna
      dtID: AccountID (pHEAD,dmLDG.btIDI); // Hotovostna pokladna
      dtSV: AccountSV (pHEAD); // Faktura za zalohu
      dtMI: AccountMI (pHEAD); // Prijemka MTZ
      dtMO: AccountMO (pHEAD); // Vydajka MTZ
      dtOW: AccountOW (pHEAD); // Doklad vyuctovania sluzobnej cesty
    end;
  finally
//    If pShow then Hide;
    ptACC.Close;
  end;
end;

procedure TF_JrnAccF.ExecuteBeg (pHEAD:TNexBtrTable;pShow:boolean);
var mDocSnt:Str3;  mDocAnl:Str6;
begin
  try
    If pShow then Show;
    L_DocNum.Text:=pHEAD.FieldByName('DocNum').AsString;
    L_ExtNum.Text:=pHEAD.FieldByName('ExtNum').AsString;
    Application.ProcessMessages;
    ptACC.Open;
    case GetDocType (L_DocNum.Text) of
      dtIS: begin // Dodavatelske faktury
              mDocSnt:=gKey.IsbDocSnt[L_DocNum.Text];
              If mDocSnt='' then mDocSnt:='321';
              mDocAnl:=AccAnlGen (gKey.IsbDocAnl[L_DocNum.Text],pHEAD.FieldByName('PaCode').AsInteger);
              F_JrnAccF.TmpAcc (0,0,pHEAD.FieldByName('WriNum').AsInteger,0,mDocSnt,mDocAnl,
                      0,pHEAD.FieldByName('AcEValue').AsFloat,
                      pHEAD.FieldByName('AccDate').AsDateTime,
                      pHEAD.FieldByName('PaName').AsString,'','',FALSE,FALSE,TRUE,TRUE,1,0,
                      pHEAD.FieldByName('PaCode').AsInteger,0);
              pHEAD.Edit;
              pHEAD.FieldByName ('DocSnt').AsString:=mDocSnt;
              pHEAD.FieldByName ('DocAnl').AsString:=mDocAnl;
              pHEAD.FieldByName ('DstAcc').AsString:='A';
              pHEAD.Post;
              AddTmpToJour; // Vymaze stare a ulozi nove uctovne zapisy do dennika UZ
            end;
      dtIC: begin // Odberatelske faktury
              mDocSnt:=gKey.IcbDocSnt[L_DocNum.Text];
              If mDocSnt='' then mDocSnt:='311';
              mDocAnl:=AccAnlGen (gKey.IcbDocAnl[L_DocNum.Text],pHEAD.FieldByName('PaCode').AsInteger);
              F_JrnAccF.TmpAcc (0,0,pHEAD.FieldByName('WriNum').AsInteger,0,mDocSnt,mDocAnl,
                      pHEAD.FieldByName('AcBValue').AsFloat,0,
                      pHEAD.FieldByName('DocDate').AsDateTime,
                      pHEAD.FieldByName('PaName').AsString,'','',FALSE,FALSE,TRUE,TRUE,1,0,
                      pHEAD.FieldByName('PaCode').AsInteger,0);  
              pHEAD.Edit;
              pHEAD.FieldByName ('DocSnt').AsString:=mDocSnt;
              pHEAD.FieldByName ('DocAnl').AsString:=mDocAnl;
              pHEAD.FieldByName ('DstAcc').AsString:='A';
              pHEAD.Post;
              AddTmpToJour; // Vymaze stare a ulozi nove uctovne zapisy do dennika UZ
            end;
    end;
  finally
    If pShow then Hide;
    ptACC.Close;
  end;
end;

procedure TF_JrnAccF.CancelButton1Click(Sender: TObject);
begin
  oAbort:=TRUE;
end;

// *****************************  PRIVATE **************************

function TF_JrnAccF.GetAnlName (pAccSnt:Str3;pAccAnl:Str6):Str30; // Nazov zadaneho analytickeho uctu
var mMyOp:boolean;
begin
  Result:='';
  mMyOp:=not dmLDG.btACCANL.Active;
  If mMyOp then dmLDG.btACCANL.Open;
  If dmLDG.btACCANL.IndexName<>'SnAn' then dmLDG.btACCANL.IndexName:='SnAn';
  If dmLDG.btACCANL.FindKey([pAccSnt,pAccAnl]) then Result:=dmLDG.btACCANL.FieldByname('AnlName').AsString;
  If mMyOp then dmLDG.btACCANL.Close
end;

procedure TF_JrnAccF.SideSum;  // Spocita strany MD a DAL
begin
  oCrdVal:=0;   oDebVal:=0;
  If ptACC.RecordCount>0 then begin
    ptACC.First;
    Repeat
      oCrdVal:=oCrdVal+Rd2(ptACC.FieldByName ('CredVal').AsFloat);
      oDebVal:=oDebVal+Rd2(ptACC.FieldByName ('DebVal').AsFloat);
      ptACC.Next;
    until ptACC.Eof;
  end;
end;

procedure TF_JrnAccF.AddToAccAnl (pAccSnt:Str3;pAccAnl:Str6;pAnlName:Str30);
begin
  If dmLDG.btACCANL.Active then begin
    If dmLDG.btACCANL.IndexName<>'SnAn' then dmLDG.btACCANL.IndexName:='SnAn';
    If not dmLDG.btACCANL.FindKey ([pAccSnt,pAccAnl]) then begin
      dmLDG.btACCANL.Insert;
      dmLDG.btACCANL.FieldByname ('AccSnt').AsString:=pAccSnt;
      dmLDG.btACCANL.FieldByname ('AccAnl').AsString:=pAccAnl;
      dmLDG.btACCANL.FieldByname ('AnlName').AsString:=pAnlName;
      dmLDG.btACCANL.Post;
    end;
  end;
end;

procedure TF_JrnAccF.TmpAcc (pItmNum,pStkNum,pWriNum,pCentNum:word; pAccSnt:Str3; pAccAnl:Str6; pCredVal,pDebVal:double; pAccDate:TDateTime; pDescribe:Str30; pOcdNum,pConDoc:Str12; pAccStk,pAccWri,pAccCen,pOcdAcc:boolean; pBegRec:byte; pSmCode:word;pPaCode,pSpaCode:longint);
var mCredVal,mDebVal: double;    mStkNum:word;   mMyOp:boolean;
begin
//  If DateInActYear (pAccDate) then begin
//  If pAccSnt[1]<>'-' then begin  // RZ 27.06.2018
    mMyOp:=not dmLDG.btACCANL.Active;
    If mMyOp then dmLDG.btACCANL.Open;
    If dmLDG.btACCANL.IndexName<>'SnAn' then dmLDG.btACCANL.IndexName:='SnAn';
    If not dmLDG.btACCANL.FindKey([pAccSnt,pAccAnl]) then begin
      oAnlErr:=TRUE;
      ShowMsg(ecSysAccAnlIsNotExist,pAccSnt+' '+pAccAnl);
    end;
    If mMyOp then dmLDG.btACCANL.Close;
    If pAccSnt='' then oSntErr:=TRUE;
    If pDescribe='' then begin  // Ak nazov je prazdny zadamen nazov uctu
      If btACCANL.FindKey([pAccSnt,pAccAnl]) then pDescribe:=btACCANL.FieldByName ('AnlName').AsString;
    end;
    If IsNotNul(pCredVal+pDebVal) then begin // Ak uctovny zapis ma nulovu hodnotu neulozime
      mStkNum:=pStkNum;
      mCredVal:=pCredVal;
      mDebVal:=pDebVal;
//      If not gvSys.AccStk then pStkNum:=0;
      If gvSys.AccWri then begin // Ak je zapnute rozuctovanie podla prevadzok
        If pWriNum=0 then begin // Ak nie je zadane cislo prevadzky urcime podla skldu
          If btSTKLST.FindKey([mStkNum]) then pWriNum:=btSTKLST.FieldByName('WriNum').AsInteger;
        end;
      end
      else pWriNum:=0;
      If gvSys.AccCen then begin
        If pCentNum=0 then begin // Ak nie je zadane cislo strediska urcime podla prevadzky
          If btWRILST.FindKey([pStkNum]) then pCentNum:=btWRILST.FieldByName('CentNum').AsInteger;
        end;
      end
      else pCentNum:=0;
      If (pOcdNum='SPE') then begin // V pripade cerpania zaloho zmenime znamienko z stranu MD a DAL
        mCredVal:=pDebVal*(-1);
        mDebVal:=pCredVal*(-1);
      end
      else If not pOcdAcc and (pOcdNum<>'PROFORMA') then pOcdNum:='';
      If ptACC.FindKey ([pItmNum,pStkNum,pWriNum,pCentNum,pOcdNum,pConDoc,pAccSnt,pAccAnl]) then begin
        ptACC.Edit;
        ptACC.FieldByName('CredVal').AsFloat:=ptACC.FieldByName ('CredVal').AsFloat+pCredVal;
        ptACC.FieldByName('DebVal').AsFloat:=ptACC.FieldByName ('DebVal').AsFloat+pDebVal;
        ptACC.Post;
      end
      else begin
        L_ItmCnt.Long:=L_ItmCnt.Long+1;
        ptACC.Insert;
        ptACC.FieldByName('ItmNum').AsInteger:=pItmNum;
        ptACC.FieldByName('ExtNum').AsString:=L_ExtNum.Text;
        ptACC.FieldByName('StkNum').AsInteger:=pStkNum;
        ptACC.FieldByName('WriNum').AsInteger:=pWriNum;
        ptACC.FieldByName('CentNum').AsInteger:=pCentNum;
        ptACC.FieldByName('OcdNum').AsString:=pOcdNum;
        ptACC.FieldByName('ConDoc').AsString:=pConDoc;
        ptACC.FieldByName('AccSnt').AsString:=pAccSnt;
        ptACC.FieldByName('AccAnl').AsString:=pAccAnl;
        ptACC.FieldByName('CredVal').AsFloat:=mCredVal;
        ptACC.FieldByName('DebVal').AsFloat:=mDebVal;
        ptACC.FieldByName('DocDate').AsDateTime:=pAccDate;
        ptACC.FieldByName('Describe').AsString:=pDescribe;
        ptACC.FieldByName('SmCode').AsInteger:=pSmCode;
        ptACC.FieldByName('PaCode').AsInteger:=pPaCode;
        ptACC.FieldByName('SpaCode').AsInteger:=pSpaCode;
        ptACC.FieldByName('BegRec').AsInteger:=pBegRec;
        ptACC.Post;
      end;
    end;
//  end;
  PB_Indicator.StepBy(1);
  Application.ProcessMessages;
end;

procedure TF_JrnAccF.AddTmpToJour; // Vymaze stare a ulozi nove uctovne zapisy do dennika UZ
var mNotAcc:boolean; // Nezaúètova
begin
  mNotAcc:=oAnlErr and gKey.SysAnlReg;
  If not mNotAcc then begin
    DelDoc (L_DocNum.Text);
    If not oSntErr then begin
      // Ulozime nove uctovne z8pisy do dennika UZ
      If ptACC.RecordCount>0 then begin
        ptACC.First;
        Repeat
          If IsNotNul(Rd2(ptACC.FieldByName ('CredVal').AsFloat)+Rd2(ptACC.FieldByName ('DebVal').AsFloat)) then begin
            btJOURNAL.Insert;
            btJOURNAL.FieldByName ('DocNum').AsString:=L_DocNum.Text;
            If ptACC.FieldByName ('ItmNum').AsInteger=0
              then btJOURNAL.FieldByName ('ItmNum').AsInteger:=ptACC.RecNo
              else btJOURNAL.FieldByName ('ItmNum').AsInteger:=ptACC.FieldByName ('ItmNum').AsInteger;
            btJOURNAL.FieldByName ('ExtNum').AsString:=ptACC.FieldByName ('ExtNum').AsString;
            btJOURNAL.FieldByName ('StkNum').AsInteger:=ptACC.FieldByName ('StkNum').AsInteger;
            btJOURNAL.FieldByName ('WriNum').AsInteger:=ptACC.FieldByName ('WriNum').AsInteger;
            btJOURNAL.FieldByName ('CentNum').AsInteger:=ptACC.FieldByName ('CentNum').AsInteger;
            btJOURNAL.FieldByName ('DocDate').AsDateTime:=ptACC.FieldByName ('DocDate').AsDateTime;
            btJOURNAL.FieldByName ('AccSnt').AsString:=ptACC.FieldByName ('AccSnt').AsString;
            btJOURNAL.FieldByName ('AccAnl').AsString:=ptACC.FieldByName ('AccAnl').AsString;
            btJOURNAL.FieldByName ('Describe').AsString:=ptACC.FieldByName ('Describe').AsString;
            btJOURNAL.FieldByName ('CredVal').AsFloat:=Rd2(ptACC.FieldByName ('CredVal').AsFloat);
            btJOURNAL.FieldByName ('DebVal').AsFloat:=Rd2(ptACC.FieldByName ('DebVal').AsFloat);
            btJOURNAL.FieldByName ('OcdNum').AsString:=ptACC.FieldByName ('OcdNum').AsString;
            btJOURNAL.FieldByName ('OceNum').AsString:='';
            btJOURNAL.FieldByName ('ConDoc').AsString:=ptACC.FieldByName ('ConDoc').AsString;
            btJOURNAL.FieldByName ('SmCode').AsInteger:=ptACC.FieldByName ('SmCode').AsInteger;
            btJOURNAL.FieldByName ('PaCode').AsInteger:=ptACC.FieldByName ('PaCode').AsInteger;
            btJOURNAL.FieldByName ('SpaCode').AsInteger:=ptACC.FieldByName ('SpaCode').AsInteger;
            btJOURNAL.FieldByName ('BegRec').AsInteger:=ptACC.FieldByName ('BegRec').AsInteger;
            // Docasne pokial nsspravime ukladanie zahranicnej meny
            btJOURNAL.FieldByName ('FgCourse').AsFloat:=1;
            btJOURNAL.FieldByName ('FgCrdVal').AsFloat:=btJOURNAL.FieldByName ('CredVal').AsFloat;
            btJOURNAL.FieldByName ('FgDebVal').AsFloat:=btJOURNAL.FieldByName ('DebVal').AsFloat;
            btJOURNAL.Post;
          end;
          PB_Indicator.StepBy(1);
          L_ItmCnt.Long:=L_ItmCnt.Long+1;
          Application.ProcessMessages;
          ptACC.Next;
        until (ptACC.Eof);
      end;
    end;
  end;
end;

//***************************** APPLIC *****************************
procedure TF_JrnAccF.AccountIM (pIMH:TNexBtrTable);  // Rozuctuje SP
var mCAccSnt,mDAccSnt:Str3; mCAccAnl,mDAccAnl:Str6;
begin
  L_ExtNum.Text:='';
  If btSMLST.FindKey ([pIMH.FieldByName('SmCode').AsInteger]) then begin
    PB_Indicator.Max:=4;
    PB_Indicator.Position:=0;
    // Rozuctovanei strany MD
    PB_Indicator.StepBy(1);
    Application.ProcessMessages;
    mCAccSnt:=btSMLST.FieldByName('CAccSnt').AsString;
    If mCAccSnt='' then mCAccSnt:='132';
    mCAccAnl:=btSMLST.FieldByName('CAccAnl').AsString;
    If mCAccAnl='' then mCAccAnl:='000100';
    TmpAcc (0,pIMH.FieldByName('StkNum').AsInteger,0,0,
            mCAccSnt,mCAccAnl,
            pIMH.FieldByName('CValue').AsFloat,0,
            pIMH.FieldByName('DocDate').AsDateTime,
            pIMH.FieldByName('Describe').AsString,'','',
            boolean(btSMLST.FieldByName('CAccStk').AsInteger),
            boolean(btSMLST.FieldByName('CAccWri').AsInteger),
            boolean(btSMLST.FieldByName('CAccCen').AsInteger),TRUE,0,
            pIMH.FieldByName('SmCode').AsInteger,0,0);
    // Rozuctovanei strany DAL
    PB_Indicator.StepBy(1);
    Application.ProcessMessages;
    mDAccSnt:=btSMLST.FieldByName('DAccSnt').AsString;
    mDAccAnl:=btSMLST.FieldByName('DAccAnl').AsString;
    TmpAcc (0,pIMH.FieldByName('StkNum').AsInteger,0,0,
            mDAccSnt,mDAccAnl,
            0,pIMH.FieldByName('CValue').AsFloat,
            pIMH.FieldByName('DocDate').AsDateTime,
            pIMH.FieldByName('Describe').AsString,'','',
            boolean(btSMLST.FieldByName('DAccStk').AsInteger),
            boolean(btSMLST.FieldByName('DAccWri').AsInteger),
            boolean(btSMLST.FieldByName('DAccCen').AsInteger),TRUE,0,
            pIMH.FieldByName('SmCode').AsInteger,0,0);
    pIMH.Edit;
    If oSntErr then begin
      pIMH.FieldByName ('DstAcc').AsString:='';
      pIMH.FieldByName ('CAccSnt').AsString:='';
      pIMH.FieldByName ('CAccAnl').AsString:='';
      pIMH.FieldByName ('DAccSnt').AsString:='';
      pIMH.FieldByName ('DAccAnl').AsString:='';
    end
    else begin
      pIMH.FieldByName ('DstAcc').AsString:='A';
      pIMH.FieldByName ('CAccSnt').AsString:=mCAccSnt;
      pIMH.FieldByName ('CAccAnl').AsString:=mCAccAnl;
      pIMH.FieldByName ('DAccSnt').AsString:=mDAccSnt;
      pIMH.FieldByName ('DAccAnl').AsString:=mDAccAnl;
    end;
    pIMH.Post;
  end
  else ShowMsg (ecAccSmCodeIsNotExist,StrInt(pIMH.FieldByName('SmCode').AsInteger,0));
  AddTmpToJour; // Vymaze stare a ulozi nove uctovne zapisy do dennika UZ
end;

procedure TF_JrnAccF.AccountOM (pOMH:TNexBtrTable);  // Rozuctuje SV
var mCAccSnt,mDAccSnt:Str3; mCAccAnl,mDAccAnl:Str6;
begin
  L_ExtNum.Text:='';
  If btSMLST.FindKey ([pOMH.FieldByName('SmCode').AsInteger]) then begin
    PB_Indicator.Max:=4;
    PB_Indicator.Position:=0;
    // Rozuctovanei strany MD
    PB_Indicator.StepBy(1);
    Application.ProcessMessages;
    mCAccSnt:=btSMLST.FieldByName('CAccSnt').AsString;
    mCAccAnl:=btSMLST.FieldByName('CAccAnl').AsString;
    TmpAcc (0,pOMH.FieldByName('StkNum').AsInteger,0,0,
            mCAccSnt,mCAccAnl,
            pOMH.FieldByName('CValue').AsFloat,0,
            pOMH.FieldByName('DocDate').AsDateTime,
            pOMH.FieldByName('Describe').AsString,'','',
            boolean(btSMLST.FieldByName('CAccStk').AsInteger),
            boolean(btSMLST.FieldByName('CAccWri').AsInteger),
            boolean(btSMLST.FieldByName('CAccCen').AsInteger),TRUE,0,
            pOMH.FieldByName('SmCode').AsInteger,0,0);
    // Rozuctovanei strany DAL
    PB_Indicator.StepBy(1);
    Application.ProcessMessages;
    mDAccSnt:=btSMLST.FieldByName('DAccSnt').AsString;
    If mDAccSnt='' then mDAccSnt:='132';
    mDAccAnl:=btSMLST.FieldByName('DAccAnl').AsString;
    If mDAccAnl='' then mDAccAnl:='000100';
    TmpAcc (0,pOMH.FieldByName('StkNum').AsInteger,0,0,
            mDAccSnt,mDAccAnl,
            0,pOMH.FieldByName('CValue').AsFloat,
            pOMH.FieldByName('DocDate').AsDateTime,
            pOMH.FieldByName('Describe').AsString,'','',
            boolean(btSMLST.FieldByName('DAccStk').AsInteger),
            boolean(btSMLST.FieldByName('DAccWri').AsInteger),
            boolean(btSMLST.FieldByName('DAccCen').AsInteger),TRUE,0,
            pOMH.FieldByName('SmCode').AsInteger,0,0);
    pOMH.Edit;
    If oSntErr then begin
      pOMH.FieldByName ('DstAcc').AsString:='';
      pOMH.FieldByName ('CAccSnt').AsString:='';
      pOMH.FieldByName ('CAccAnl').AsString:='';
      pOMH.FieldByName ('DAccSnt').AsString:='';
      pOMH.FieldByName ('DAccAnl').AsString:='';
    end
    else begin
      pOMH.FieldByName ('DstAcc').AsString:='A';
      pOMH.FieldByName ('CAccSnt').AsString:=mCAccSnt;
      pOMH.FieldByName ('CAccAnl').AsString:=mCAccAnl;
      pOMH.FieldByName ('DAccSnt').AsString:=mDAccSnt;
      pOMH.FieldByName ('DAccAnl').AsString:=mDAccAnl;
    end;
    pOMH.Post;
  end
  else ShowMsg (ecAccSmCodeIsNotExist,StrInt(pOMH.FieldByName('SmCode').AsInteger,0));
  AddTmpToJour; // Vymaze stare a ulozi nove uctovne zapisy do dennika UZ
end;

procedure TF_JrnAccF.AccountRM (pRMH:TNexBtrTable);  // Rozuctuje MP
var mCAccSnt,mDAccSnt:Str3; mCAccAnl,mDAccAnl:Str6;
begin
  L_ExtNum.Text:='';
  If btSMLST.FindKey ([pRMH.FieldByName('ScSmCode').AsInteger]) then begin
    PB_Indicator.Max:=8;
    PB_Indicator.Position:=0;
    // Rozuctovanei strany MD
    PB_Indicator.StepBy(1);
    Application.ProcessMessages;
    mCAccSnt:=btSMLST.FieldByName('CAccSnt').AsString;
    mCAccAnl:=btSMLST.FieldByName('CAccAnl').AsString;
    TmpAcc (1,pRMH.FieldByName('ScStkNum').AsInteger,0,0,
            mCAccSnt,mCAccAnl,
            pRMH.FieldByName('CValue').AsFloat,0,
            pRMH.FieldByName('DocDate').AsDateTime,
            pRMH.FieldByName('Describe').AsString,'','',
            boolean(btSMLST.FieldByName('CAccStk').AsInteger),
            boolean(btSMLST.FieldByName('CAccWri').AsInteger),
            boolean(btSMLST.FieldByName('CAccCen').AsInteger),TRUE,0,
            pRMH.FieldByName('ScSmCode').AsInteger,0,0);
    // Rozuctovanei strany DAL
    PB_Indicator.StepBy(1);
    Application.ProcessMessages;
    mDAccSnt:=btSMLST.FieldByName('DAccSnt').AsString;
    If mDAccSnt='' then mDAccSnt:='132';
    mDAccAnl:=btSMLST.FieldByName('DAccAnl').AsString;
    If mDAccAnl='' then mDAccAnl:='000100';
    TmpAcc (2,pRMH.FieldByName('ScStkNum').AsInteger,0,0,
            mDAccSnt,mDAccAnl,
            0,pRMH.FieldByName('CValue').AsFloat,
            pRMH.FieldByName('DocDate').AsDateTime,
            pRMH.FieldByName('Describe').AsString,'','',
            boolean(btSMLST.FieldByName('DAccStk').AsInteger),
            boolean(btSMLST.FieldByName('DAccWri').AsInteger),
            boolean(btSMLST.FieldByName('DAccCen').AsInteger),TRUE,0,
            pRMH.FieldByName('ScSmCode').AsInteger,0,0);
    // Cielovy pohyb
    If btSMLST.FindKey ([pRMH.FieldByName('TgSmCode').AsInteger]) then begin
      // Rozuctovanei strany MD
      PB_Indicator.StepBy(1);
      Application.ProcessMessages;
      mCAccSnt:=btSMLST.FieldByName('CAccSnt').AsString;
      mCAccAnl:=btSMLST.FieldByName('CAccAnl').AsString;
      TmpAcc (3,pRMH.FieldByName('TgStkNum').AsInteger,0,0,
              mCAccSnt,mCAccAnl,
              pRMH.FieldByName('CValue').AsFloat,0,
              pRMH.FieldByName('DocDate').AsDateTime,
              pRMH.FieldByName('Describe').AsString,'','',
              boolean(btSMLST.FieldByName('CAccStk').AsInteger),
              boolean(btSMLST.FieldByName('CAccWri').AsInteger),
              boolean(btSMLST.FieldByName('CAccCen').AsInteger),TRUE,0,
              pRMH.FieldByName('TgSmCode').AsInteger,0,0);
      // Rozuctovanei strany DAL
      PB_Indicator.StepBy(1);
      Application.ProcessMessages;
      mDAccSnt:=btSMLST.FieldByName('DAccSnt').AsString;
      If mDAccSnt='' then mDAccSnt:='132';
      mDAccAnl:=btSMLST.FieldByName('DAccAnl').AsString;
      If mDAccAnl='' then mDAccAnl:='000100';
      TmpAcc (4,pRMH.FieldByName('TgStkNum').AsInteger,0,0,
              mDAccSnt,mDAccAnl,
              0,pRMH.FieldByName('CValue').AsFloat,
              pRMH.FieldByName('DocDate').AsDateTime,
              pRMH.FieldByName('Describe').AsString,'','',
              boolean(btSMLST.FieldByName('DAccStk').AsInteger),
              boolean(btSMLST.FieldByName('DAccWri').AsInteger),
              boolean(btSMLST.FieldByName('DAccCen').AsInteger),TRUE,0,
              pRMH.FieldByName('TgSmCode').AsInteger,0,0);
    end;
    pRMH.Edit;
    If oSntErr then begin
      pRMH.FieldByName ('DstAcc').AsString:='';
    end
    else begin
      pRMH.FieldByName ('DstAcc').AsString:='A';
    end;
    pRMH.FieldByName ('DstAcc').AsString:='A';
//    pRMH.FieldByName ('CAccSnt').AsString:=mCAccSnt;
//    pRMH.FieldByName ('CAccAnl').AsString:=mCAccAnl;
//    pRMH.FieldByName ('DAccSnt').AsString:=mDAccSnt;
//    pRMH.FieldByName ('DAccAnl').AsString:=mDAccAnl;
//    pRMH.Post;
  end
  else ShowMsg (ecAccSmCodeIsNotExist,StrInt(pRMH.FieldByName('SmCode').AsInteger,0));
  AddTmpToJour; // Vymaze stare a ulozi nove uctovne zapisy do dennika UZ
end;

procedure TF_JrnAccF.AccountTC (pTCH:TNexBtrTable);  // Rozuctuje ODL
var mCAccSnt,mDAccSnt:Str3; mCAccAnl,mDAccAnl:Str6;
begin
  If copy(pTCH.FieldByName('IcdNum').AsString,1,3)<>'ECR' then begin
    L_ExtNum.Text:=pTCH.FieldByName('ExtNum').AsString;
    If btSMLST.FindKey ([pTCH.FieldByName('SmCode').AsInteger]) then begin
      PB_Indicator.Max:=4;
      PB_Indicator.Position:=0;
      // Rozuctovanei strany MD
      PB_Indicator.StepBy(1);
      Application.ProcessMessages;
      mCAccSnt:=btSMLST.FieldByName('CAccSnt').AsString;
      If mCAccSnt='' then mCAccSnt:='504';
      mCAccAnl:=btSMLST.FieldByName('CAccAnl').AsString;
      If mCAccAnl='' then mCAccAnl:='000100';
      TmpAcc (0,pTCH.FieldByName('StkNum').AsInteger,0,0,
              mCAccSnt,mCAccAnl,
              pTCH.FieldByName('AcCValue').AsFloat,0,
              pTCH.FieldByName('DocDate').AsDateTime,
              pTCH.FieldByName('PaName').AsString,
              pTCH.FieldByName('OcdNum').AsString,'',
              boolean(btSMLST.FieldByName('CAccStk').AsInteger),
              boolean(btSMLST.FieldByName('CAccWri').AsInteger),
              boolean(btSMLST.FieldByName('CAccCen').AsInteger),TRUE,0,
              pTCH.FieldByName('SmCode').AsInteger,pTCH.FieldByName('PaCode').AsInteger,
              pTCH.FieldByName('SpaCode').AsInteger);
      // Rozuctovanei strany DAL
      PB_Indicator.StepBy(1);
      Application.ProcessMessages;
      mDAccSnt:=btSMLST.FieldByName('DAccSnt').AsString;
      If mDAccSnt='' then mDAccSnt:='132';
      mDAccAnl:=btSMLST.FieldByName('DAccAnl').AsString;
      If mDAccAnl='' then mDAccAnl:='000100';
      TmpAcc (0,pTCH.FieldByName('StkNum').AsInteger,0,0,
              mDAccSnt,mDAccAnl,
              0,pTCH.FieldByName('AcCValue').AsFloat,
              pTCH.FieldByName('DocDate').AsDateTime,
              pTCH.FieldByName('PaName').AsString,
              pTCH.FieldByName('OcdNum').AsString,'',
              boolean(btSMLST.FieldByName('DAccStk').AsInteger),
              boolean(btSMLST.FieldByName('DAccWri').AsInteger),
              boolean(btSMLST.FieldByName('DAccCen').AsInteger),TRUE,0,
              pTCH.FieldByName('SmCode').AsInteger,pTCH.FieldByName('PaCode').AsInteger,
              pTCH.FieldByName('SpaCode').AsInteger);
      pTCH.Edit;
      If oSntErr then begin
        pTCH.FieldByName ('DstAcc').AsString:='';
        pTCH.FieldByName ('CAccSnt').AsString:='';
        pTCH.FieldByName ('CAccAnl').AsString:='';
        pTCH.FieldByName ('DAccSnt').AsString:='';
        pTCH.FieldByName ('DAccAnl').AsString:='';
      end
      else begin
        pTCH.FieldByName ('DstAcc').AsString:='A';
        pTCH.FieldByName ('CAccSnt').AsString:=mCAccSnt;
        pTCH.FieldByName ('CAccAnl').AsString:=mCAccAnl;
        pTCH.FieldByName ('DAccSnt').AsString:=mDAccSnt;
        pTCH.FieldByName ('DAccAnl').AsString:=mDAccAnl;
      end;
      pTCH.Post;
    end
    else ShowMsg (ecAccSmCodeIsNotExist,StrInt(pTCH.FieldByName('SmCode').AsInteger,0));
    AddTmpToJour; // Vymaze stare a ulozi nove uctovne zapisy do dennika UZ
  end
  else begin
    DelDoc (L_DocNum.Text);
    pTCH.Edit;
    pTCH.FieldByName ('DstAcc').AsString:='';
    pTCH.FieldByName ('CAccSnt').AsString:='';
    pTCH.FieldByName ('CAccAnl').AsString:='';
    pTCH.FieldByName ('DAccSnt').AsString:='';
    pTCH.FieldByName ('DAccAnl').AsString:='';
    pTCH.Post;
  end;
end;

procedure TF_JrnAccF.AccountIC (pICH:TNexBtrTable);  // Rozuctuje OF
var mDocSnt,mAccSnt,mVatSnt:Str3; mDocAnl,mAccAnl,mSpvAnl,mVatAnl:Str6;  mCredVal,mDebVal:double;
    mSideChg:boolean; // Ak je TRUE zmeni sa znak a strana uctovania
    mPaCode,mSpaCode:longint;  mTcbNum:Str12;  mItmNum:word;  mDescribe:Str30;
    mAValue,mVatVal,mBValue,mDifVal:double;   mVatDate:TDateTime;
begin
  mPaCode:=pICH.FieldByName ('PaCode').AsInteger;
  mVatDate:=pICH.FieldByName('VatDate').AsDateTime;
  mSpaCode:=pICH.FieldByName ('SpaCode').AsInteger;
  L_ExtNum.Text:=pICH.FieldByName('ExtNum').AsString;
//  If YearL(pICH.FieldByName('VatDate').AsDateTime)=gvSys.ActYear then begin // Je to aktualny rok v kotom bola faktura zauctovana
    If gKey.IcbTcdAcc[pICH.BookNum] then dmSYS.ptDOCLST.Open;
//    If YearL(pICH.FieldByName ('VatDate').AsDateTime)=gvSys.ActYear then begin
      // ----------------------------------- Rozuctovanei strany MD 311 -----------------------------------
      mDocSnt:=gKey.IcbDocSnt[pICH.BookNum]; 
      If mDocSnt='' then mDocSnt:='311';
      mDocAnl:=AccAnlGen (gKey.IcbDocAnl[pICH.BookNum] ,pICH.FieldByName('PaCode').AsInteger);
      
      If gKey.SysAutReg then AddToAccAnl (mDocSnt,mDocAnl,pICH.FieldByName('PaName').AsString);
      mCredVal:=pICH.FieldByName('AcBValue').AsFloat;
      mDebVal:=0;
      TmpAcc (0,0,pICH.FieldByName('WriNum').AsInteger,0,mDocSnt,mDocAnl,mCredVal,mDebVal,mVatDate,pICH.FieldByName('PaName').AsString,
              pICH.FieldByName('OcdNum').AsString,'',TRUE,TRUE,TRUE,FALSE,0,0,mPaCode,mSpaCode);
      // -------------------------------- Rozuctovanei strany DAL 343 DPH ----------------------------------
      mVatSnt:=gKey.IcbVatSnt[pICH.BookNum];
      If mVatSnt='' then mAccSnt:='343';
      mCredVal:=0;
      // --- DPH - 2 ---
      mDebVal:=Rd2(pICH.FieldByName('AcBValue2').AsFloat-pICH.FieldByName('AcAValue2').AsFloat);
      If IsNotNul(mDebVal) then begin
        mVatAnl:=gKey.IcbVatAnl[pICH.BookNum];
        If (mVatAnl='') or (Pos('v',mVatAnl)>0) then mVatAnl:=StrIntZero(pICH.FieldByName('VatPrc2').AsInteger,6);
        mDescribe:=GetAnlName (mVatSnt,mVatAnl);
        TmpAcc (0,0,pICH.FieldByName('WriNum').AsInteger,0,mVatSnt,mVatAnl,mCredVal,mDebVal,pICH.FieldByName('VatDate').AsDateTime,
                mDescribe,'','',TRUE,TRUE,TRUE,FALSE,0,0,mPaCode,mSpaCode);
      end;
      // --- DPH - 3 ---
      mDebVal:=Rd2(pICH.FieldByName('AcBValue3').AsFloat-pICH.FieldByName('AcAValue3').AsFloat);
      If IsNotNul(mDebVal) then begin
        mVatAnl:=gKey.IcbVatAnl[pICH.BookNum];
        If (mVatAnl='') or (Pos('v',mVatAnl)>0) then mVatAnl:=StrIntZero(pICH.FieldByName('VatPrc3').AsInteger,6);
        mDescribe:=GetAnlName (mVatSnt,mVatAnl);
        TmpAcc (0,0,pICH.FieldByName('WriNum').AsInteger,0,mVatSnt,mVatAnl,mCredVal,mDebVal,pICH.FieldByName('VatDate').AsDateTime,
                mDescribe,'','',TRUE,TRUE,TRUE,FALSE,0,0,mPaCode,mSpaCode);
      end;
      // --- DPH - 4 ---
      mDebVal:=Rd2(pICH.FieldByName('AcBValue4').AsFloat-pICH.FieldByName('AcAValue4').AsFloat);
      If IsNotNul(mDebVal) then begin
        mVatAnl:=gKey.IcbVatAnl[pICH.BookNum];
        If (mVatAnl='') or (Pos('v',mVatAnl)>0) then mVatAnl:=StrIntZero(pICH.FieldByName('VatPrc4').AsInteger,6);
        mDescribe:=GetAnlName (mVatSnt,mVatAnl);
        TmpAcc (0,0,pICH.FieldByName('WriNum').AsInteger,0,mVatSnt,mVatAnl,mCredVal,mDebVal,pICH.FieldByName('VatDate').AsDateTime,
                mDescribe,'','',TRUE,TRUE,TRUE,FALSE,0,0,mPaCode,mSpaCode);
      end;
      // --- DPH - 5 ---
      mDebVal:=Rd2(pICH.FieldByName('AcBValue5').AsFloat-pICH.FieldByName('AcAValue5').AsFloat);
      If IsNotNul(mDebVal) then begin
        mVatAnl:=gKey.IcbVatAnl[pICH.BookNum];
        If (mVatAnl='') or (Pos('v',mVatAnl)>0) then mVatAnl:=StrIntZero(pICH.FieldByName('VatPrc5').AsInteger,6);
        mDescribe:=GetAnlName (mVatSnt,mVatAnl);
        TmpAcc (0,0,pICH.FieldByName('WriNum').AsInteger,0,mVatSnt,mVatAnl,mCredVal,mDebVal,pICH.FieldByName('VatDate').AsDateTime,
                mDescribe,'','',TRUE,TRUE,TRUE,FALSE,0,0,mPaCode,mSpaCode);
      end;
      // Rozuctovanie poloziek
      btICI.Open (pICH.BookNum);
      btICI.IndexName:='DocNum';
      If btICI.FindKey ([L_DocNum.Text]) then begin
        mItmNum:=0;
        PB_Indicator.Max:=pICH.FieldByName('ItmQnt').AsInteger+3;
        PB_Indicator.Position:=0;
        Repeat
          PB_Indicator.StepBy(1);
          Application.ProcessMessages;
          mBValue:=btICI.FieldByName('AcBValue').AsFloat+btICI.FieldByName('FgRndVal').AsFloat;
          mAValue:=btICI.FieldByName('AcAValue').AsFloat+btICI.FieldByName('FgRndVal').AsFloat-btICI.FieldByName('FgRndVat').AsFloat;
          If btICI.FieldByName ('OcdNum').AsString='PROFORMA' then begin // Zalohova platba
            // -------------------------------- Zauctovanie zalohy -----------------------------------
            mBValue:=btICI.FieldByName('AcBValue').AsFloat*(-1);
            TmpAcc (0,0,pICH.FieldByName('WriNum').AsInteger,0,mDocSnt,mDocAnl,mBValue*(-1),0,mVatDate,
                    pICH.FieldByName('PaName').AsString,'','',TRUE,TRUE,TRUE,FALSE,0,0,mPaCode,mSpaCode);
            mSpvAnl:=AccAnlGen (gKey.Icm.SpvAnl,pICH.FieldByName('PaCode').AsInteger);
            TmpAcc (0,0,pICH.FieldByName('WriNum').AsInteger,0,gKey.Icm.SpvSnt,mSpvAnl,0,mBValue*(-1),mVatDate,
                    '','','',TRUE,TRUE,TRUE,FALSE,0,0,mPaCode,mSpaCode);
            // ----------------------------- Zauctovanie DPH zo zalohy -------------------------------
            mVatVal:=btICI.FieldByName('AcBValue').AsFloat-btICI.FieldByName('AcAValue').AsFloat;
            mSpvAnl:=AccAnlGen(gKey.Icm.SptAnl,btICI.FieldByName('VatPrc').AsInteger);
            TmpAcc (0,0,pICH.FieldByName('WriNum').AsInteger,0,gKey.Icm.SptSnt,mSpvAnl,0,mVatVal*(-1),mVatDate,
                    '','','',TRUE,TRUE,TRUE,FALSE,0,0,mPaCode,mSpaCode);
            TmpAcc (0,0,pICH.FieldByName('WriNum').AsInteger,0,mVatSnt,mVatAnl,0,mVatVal,mVatDate,
                    '','','',TRUE,TRUE,TRUE,FALSE,0,0,mPaCode,mSpaCode);

            // Pridame do zauctovania 311 hodnoty zalohovej platby
            TmpAcc (0,0,pICH.FieldByName('WriNum').AsInteger,0,mDocSnt,mDocAnl,mBValue,0,mVatDate,pICH.FieldByName('PaName').AsString,
                    pICH.FieldByName('OcdNum').AsString,'',TRUE,TRUE,TRUE,FALSE,0,0,mPaCode,mSpaCode);
            // Pridame do zauctovania 343 hodnoty zalohovej platby --- DPH - 3 ---
            If IsNotNul(mVatVal) then begin
              mDescribe:=GetAnlName (mVatSnt,mVatAnl);
              TmpAcc (0,0,pICH.FieldByName('WriNum').AsInteger,0,mVatSnt,mVatAnl,0,mVatVal*(-1),pICH.FieldByName('VatDate').AsDateTime,
                      mDescribe,'','',TRUE,TRUE,TRUE,FALSE,0,0,mPaCode,mSpaCode);
            end;
          end
          else begin // Bezne polozky
            // ---------------------------- Rozuctovanei strany DAL - hodnota bez DPH ----------------------------
            oAcc.CrtAccDat(btICI.FieldByName('AccSnt').AsString,btICI.FieldByName('AccAnl').AsString,btICI.FieldByName('GsCode').AsInteger,btICI.FieldByName('PaCode').AsInteger,'OF',pICH.BookNum);
            mAccSnt:=oAcc.AccSnt;
            mAccAnl:=oAcc.AccAnl;
            mDescribe:='';
            If gKey.IcbItmAcc[pICH.BookNum]=0 then mDescribe:=GetAnlName(mAccSnt,mAccAnl);
            If gKey.IcbItmAcc[pICH.BookNum]=1 then mDescribe:=pICH.FieldByName('PaName').AsString;
            If gKey.IcbItmAcc[pICH.BookNum]=2 then begin
              mItmNum:=btICI.FieldByName('ItmNum').AsInteger;
              mDescribe:=btICI.FieldByName('GsName').AsString;
            end;
            mCredVal:=0;   mDebVal:=mAValue;
            TmpAcc (mItmNum,0,pICH.FieldByName('WriNum').AsInteger,0,mAccSnt,mAccAnl,mCredVal,mDebVal,pICH.FieldByName('VatDate').AsDateTime,
                    mDescribe,btICI.FieldByName('OcdNum').AsString,'',TRUE,TRUE,TRUE,FALSE,0,0,mPaCode,mSpaCode);
            If gKey.IcbTcdAcc[pICH.BookNum] then begin
              If Length(btICI.FieldByName('TcdNum').AsString)=12 then begin
                // Ulozime cislo dodacieho listu do zoznamu ktory sa pouziva pri rozutovani dodacich listov
                If not dmSYS.ptDOCLST.FindKey([btICI.FieldByName('TcdNum').AsString]) then begin
                  dmSYS.ptDOCLST.Insert;
                  dmSYS.ptDOCLST.FieldByName ('DocNum').AsString:=btICI.FieldByName('TcdNum').AsString;
                  dmSYS.ptDOCLST.Post;
                end;
              end;
            end;
          end; // Koniec zauctovania beznych poloziek
          Application.ProcessMessages;
          btICI.Next;
        until (btICI.Eof) or (btICI.FieldByName('DocNum').AsString<>L_DocNum.Text);
      end;
      btICI.Close;
//    end;
    // ----------------------------------- Cenove zaokruhlenie medzi stranami MD a DAL -----------------------------------
    SideSum;
    mDifVal:=Rd2(oCrdVal-oDebVal);
    mDescribe:='';
    If gKey.IcbItmAcc[pICH.BookNum]=1 then mDescribe:=pICH.FieldByName('PaName').AsString;
    If IsNotNul(mDifVal) then TmpAcc (0,0,pICH.FieldByName('WriNum').AsInteger,0,gKey.Icm.RndSnt,gKey.Icm.RndAnl,0,mDifVal,
                              pICH.FieldByName('VatDate').AsDateTime,mDescribe,'','',TRUE,TRUE,TRUE,FALSE,0,0,0,0);
    // -------------------------------------------------------------------------------------------------------------------
    pICH.Edit;
    If oSntErr then begin
      pICH.FieldByName ('DstAcc').AsString:='';
      pICH.FieldByName ('DocSnt').AsString:='';
      pICH.FieldByName ('DocAnl').AsString:='';
    end
    else begin
      pICH.FieldByName ('DstAcc').AsString:='A';
      pICH.FieldByName ('DocSnt').AsString:=mDocSnt;
      pICH.FieldByName ('DocAnl').AsString:=mDocAnl;
    end;
    pICH.Post;
    AddTmpToJour; // Vymaze stare a ulozi nove uctovne zapisy do dennika UZ
    // Rozuctovanie pripojenych dodacich listov
    If gKey.IcbTcdAcc[pICH.BookNum] then begin
      If dmSYS.ptDOCLST.FieldCount>0 then begin
        mTcbNum:='';
        dmSYS.ptDOCLST.First;
        Repeat
          L_DocNum.Text:=dmSYS.ptDOCLST.FieldByName ('DocNum').AsString;
          If (mTcbNum='') or (btTCH.BookNum<>mTcbNum) then begin
            mTcbNum:=BookNumFromDocNum (L_DocNum.Text);
            btTCH.Open (mTcbNum);  btTCH.IndexName:='DocNum';
          end;
          If btTCH.FindKey([dmSYS.ptDOCLST.FieldByName ('DocNum').AsString]) then begin
            ptACC.Close;
            ptACC.Open;
            AccountTC (btTCH);  // Rozuctuje ODL
          end;
          Application.ProcessMessages;
          dmSYS.ptDOCLST.Next;
        until dmSYS.ptDOCLST.Eof;
      end;
      dmSYS.ptDOCLST.Close;
    end;
(*
  end
  else begin
    If gIni.AccOldIcd then begin
      mDocSnt:=gKey.IcbdocSnt[pICH.BookNum];
      If mDocSnt='' then mDocSnt:='311';
      mDocAnl:=AccAnlGen (gKey.IcbDocAnl[pICH.BookNum],pICH.FieldByName('PaCode').AsInteger);
      mBValue:=pICH.FieldByName('AcBValue').AsFloat-pICH.FieldByName('AcPrvPay').AsFloat;
      TmpAcc (0,0,pICH.FieldByName('WriNum').AsInteger,0,mDocSnt,mDocAnl,
              mBValue,0,FirstActYearDate,
              pICH.FieldByName('PaName').AsString,'','',FALSE,FALSE,TRUE,FALSE,1,0,mPaCode,mSpaCode);
      TmpAcc (0,0,pICH.FieldByName('WriNum').AsInteger,0,gIni.OpnSuvSnt,gIni.OpnSuvAnl,
              0,mBValue,FirstActYearDate,
              pICH.FieldByName('PaName').AsString,'','',FALSE,FALSE,TRUE,FALSE,1,0,mPaCode,mSpaCode);
      pICH.Edit;
      pICH.FieldByName ('DstAcc').AsString:='A';
      pICH.FieldByName ('DocSnt').AsString:=mDocSnt;
      pICH.FieldByName ('DocAnl').AsString:=mDocAnl;
      pICH.Post;
      AddTmpToJour; // Vymaze stare a ulozi nove uctovne zapisy do dennika UZ
    end;
  end;
*)  
end;

procedure TF_JrnAccF.AccountTS (pTSH:TNexBtrTable);  // Rozuctuje DDL
var mAccSnt:Str3; mAccAnl:Str6;   mAcqVal:double;
begin
  L_ExtNum.Text:=pTSH.FieldByName('ExtNum').AsString;
  If btSMLST.FindKey ([pTSH.FieldByName('SmCode').AsInteger]) then begin
    PB_Indicator.Max:=4;
    PB_Indicator.Position:=0;
    mAcqVal:=pTSH.FieldByName('AcZValue').AsFloat+pTSH.FieldByName('AcTValue').AsFloat+pTSH.FieldByName('AcOValue').AsFloat;
    // Rozuctovanei strany MD
    PB_Indicator.StepBy(1);
    Application.ProcessMessages;
    mAccSnt:=btSMLST.FieldByName('CAccSnt').AsString;
    If mAccSnt='' then mAccSnt:='132';
    mAccAnl:=btSMLST.FieldByName('CAccAnl').AsString;
    If mAccAnl='' then mAccAnl:='000100';
    TmpAcc (0,pTSH.FieldByName('StkNum').AsInteger,0,0,
            mAccSnt,mAccAnl,
            pTSH.FieldByName('AcSValue').AsFloat,0,
            pTSH.FieldByName('DocDate').AsDateTime,
            pTSH.FieldByName('PaName').AsString,
            pTSH.FieldByName('OcdNum').AsString,'',
            boolean(btSMLST.FieldByName('CAccStk').AsInteger),
            boolean(btSMLST.FieldByName('CAccWri').AsInteger),
            boolean(btSMLST.FieldByName('CAccCen').AsInteger),TRUE,0,
            pTSH.FieldByName('SmCode').AsInteger,pTSH.FieldByName('PaCode').AsInteger,0);

    If Rd2(pTSH.FieldByName('AcCValue').AsFloat)<>Rd2(pTSH.FieldByName('AcSValue').AsFloat-mAcqVal)then begin // Rozuctujeme cenovy rozdiel zo zaokruhlenia
//    If (pTSH.FieldByName('AcCValue').AsFloat-pTSH.FieldByName('AcSValue').AsFloat-mAcqVal)>=0.00499999999 then begin // Rozuctujeme cenovy rozdiel zo zaokruhlenia
      If gPrp.Tsm.RndSnt='' then begin
        gPrp.Tsm.RndSnt:=gIni.TsdRndSnt;
        gPrp.Tsm.RndAnl:=gIni.TsdRndAnl;
      end;
      mAccSnt:=gPrp.Tsm.RndSnt;  // Default: 132
      mAccAnl:=gPrp.Tsm.RndAnl;  // Default: 000900
      TmpAcc (0,pTSH.FieldByName('StkNum').AsInteger,0,0,
              mAccSnt,mAccAnl,
              Rd2(pTSH.FieldByName('AcCValue').AsFloat)-Rd2(pTSH.FieldByName('AcSValue').AsFloat-mAcqVal),0,
              pTSH.FieldByName('DocDate').AsDateTime,
              pTSH.FieldByName('PaName').AsString,
              pTSH.FieldByName('OcdNum').AsString,'',
              boolean(btSMLST.FieldByName('CAccStk').AsInteger),
              boolean(btSMLST.FieldByName('CAccWri').AsInteger),
              boolean(btSMLST.FieldByName('CAccCen').AsInteger),TRUE,0,
              pTSH.FieldByName('SmCode').AsInteger,pTSH.FieldByName('PaCode').AsInteger,0);
    end;
    // Rozuctovanei strany DAL
    PB_Indicator.StepBy(1);
    Application.ProcessMessages;
    mAccSnt:=btSMLST.FieldByName('DAccSnt').AsString;
    If mAccSnt='' then mAccSnt:='131';
    mAccAnl:=btSMLST.FieldByName('DAccAnl').AsString;
    If mAccAnl='' then mAccAnl:='000100';
    TmpAcc (0,pTSH.FieldByName('StkNum').AsInteger,0,0,
            mAccSnt,mAccAnl,
            0,pTSH.FieldByName('AcCValue').AsFloat,
            pTSH.FieldByName('DocDate').AsDateTime,
            pTSH.FieldByName('PaName').AsString,
            pTSH.FieldByName('OcdNum').AsString,pTSH.FieldByName('DocNum').AsString,
            boolean(btSMLST.FieldByName('DAccStk').AsInteger),
            boolean(btSMLST.FieldByName('DAccWri').AsInteger),
            boolean(btSMLST.FieldByName('DAccCen').AsInteger),TRUE,0,
            pTSH.FieldByName('SmCode').AsInteger,pTSH.FieldByName('PaCode').AsInteger,0);
    // Obstaravacich nakladov
    PB_Indicator.StepBy(1);
    Application.ProcessMessages;
    If IsNotNul (mAcqVal) then begin
      mAccSnt:=gPrp.Tsm.AqvSnt; // Default: 131
      mAccAnl:=gPrp.Tsm.AqvAnl; // Default: 000900
      TmpAcc (0,pTSH.FieldByName('StkNum').AsInteger,0,0,
              mAccSnt,mAccAnl,0,mAcqVal,
              pTSH.FieldByName('DocDate').AsDateTime,
              pTSH.FieldByName('PaName').AsString,
              pTSH.FieldByName('OcdNum').AsString,'',
              boolean(btSMLST.FieldByName('DAccStk').AsInteger),
              boolean(btSMLST.FieldByName('DAccWri').AsInteger),
              boolean(btSMLST.FieldByName('DAccCen').AsInteger),TRUE,0,
              pTSH.FieldByName('SmCode').AsInteger,pTSH.FieldByName('PaCode').AsInteger,0);
    end;
    pTSH.Edit;
    If oSntErr then begin
      pTSH.FieldByName ('DstAcc').AsString:='';
    end
    else begin
      pTSH.FieldByName ('DstAcc').AsString:='A';
    end;
    pTSH.Post;
  end
  else ShowMsg (ecAccSmCodeIsNotExist,StrInt(pTSH.FieldByName('SmCode').AsInteger,0));
  AddTmpToJour; // Vymaze stare a ulozi nove uctovne zapisy do dennika UZ
end;

procedure TF_JrnAccF.AccountSA (pSAH:TNexBtrTable);  // Rozuctuje SA
var mCAccSnt,mDAccSnt:Str3; mCAccAnl,mDAccAnl:Str6; mSmCode:word;
begin
  L_ExtNum.Text:='';  mSmCode:=59;
  If btSMLST.FindKey ([mSmCode]) then begin
    PB_Indicator.Max:=2;
    PB_Indicator.Position:=0;
    // Rozuctovanei strany MD
    PB_Indicator.StepBy(1);
    Application.ProcessMessages;
    mCAccSnt:=btSMLST.FieldByName('CAccSnt').AsString;
    If mCAccSnt='' then mCAccSnt:='504';
    mCAccAnl:=btSMLST.FieldByName('CAccAnl').AsString;
    If mCAccAnl='' then mCAccAnl:='000100';
    TmpAcc (0,gKey.SabStkNum[dmCAB.btSAH.BookNum],
            gKey.SabWriNum[dmCAB.btSAH.BookNum],0,
            mCAccSnt,mCAccAnl,
            pSAH.FieldByName('CValue').AsFloat,0,
            pSAH.FieldByName('DocDate').AsDateTime,'','','',
            boolean(btSMLST.FieldByName('CAccStk').AsInteger),
            boolean(btSMLST.FieldByName('CAccWri').AsInteger),
            boolean(btSMLST.FieldByName('CAccCen').AsInteger),TRUE,0,mSmCode,0,0);
    // Rozuctovanei strany DAL
    PB_Indicator.StepBy(1);
    Application.ProcessMessages;
    mDAccSnt:=btSMLST.FieldByName('DAccSnt').AsString;
    If mDAccSnt='' then mDAccSnt:='132';
    mDAccAnl:=btSMLST.FieldByName('DAccAnl').AsString;
    If mDAccAnl='' then mDAccAnl:='000100';
    TmpAcc (0,gKey.SabStkNum[dmCAB.btSAH.BookNum],gKey.SabWriNum[dmCAB.btSAH.BookNum],0,
            mDAccSnt,mDAccAnl,
            0,pSAH.FieldByName('CValue').AsFloat,
            pSAH.FieldByName('DocDate').AsDateTime,'','','',
            boolean(btSMLST.FieldByName('CAccStk').AsInteger),
            boolean(btSMLST.FieldByName('CAccWri').AsInteger),
            boolean(btSMLST.FieldByName('CAccCen').AsInteger),TRUE,0,mSmCode,0,0);
    pSAH.Refresh;
    pSAH.Edit;
    If oSntErr then begin
      pSAH.FieldByName ('DstAcc').AsString:='';
      pSAH.FieldByName ('CAccSnt').AsString:='';
      pSAH.FieldByName ('CAccAnl').AsString:='';
      pSAH.FieldByName ('DAccSnt').AsString:='';
      pSAH.FieldByName ('DAccAnl').AsString:='';
    end
    else begin
      pSAH.FieldByName ('DstAcc').AsString:='A';
      pSAH.FieldByName ('CAccSnt').AsString:=mCAccSnt;
      pSAH.FieldByName ('CAccAnl').AsString:=mCAccAnl;
      pSAH.FieldByName ('DAccSnt').AsString:=mDAccSnt;
      pSAH.FieldByName ('DAccAnl').AsString:=mDAccAnl;
    end;
    pSAH.Post;
  end
  else ShowMsg (ecAccSmCodeIsNotExist,StrInt(mSmCode,0));
  AddTmpToJour; // Vymaze stare a ulozi nove uctovne zapisy do dennika UZ
end;

procedure TF_JrnAccF.AccountIS (pISH:TNexBtrTable);  // Rozuctuje DF
var mDocSnt,mAccSnt:Str3; mDocAnl,mAccAnl:Str6;  mAccDate:TDateTime;
    mCredVal,mDebVal,mEValue,mDifVal,mVatVal:double;  mOcdNum:Str12;  mVatPrc,mAccMth,mVatMth:byte;
    mPaCode:longint;  mTsbNum:Str5;  mItmNum:word;  mDescribe:Str30;
begin   
  mAccDate:=pISH.FieldByName('AccDate').AsDateTime;
  mAccMth:=MthNum (mAccDate);
  mVatMth:=MthNum (pISH.FieldByName('VatDate').AsDateTime);
  mPaCode:=pISH.FieldByName('PaCode').AsInteger;
  L_ExtNum.Text:=pISH.FieldByName('ExtNum').AsString;
  // ---------------------------------------------------------------------------
  If gKey.IsbTsdAcc[pISH.BookNum] then dmSYS.ptDOCLST.Open;
  dmSYS.ptDOCLST.Open;
  If mAccDate=0 then mAccDate:=pISH.FieldByName('DocDate').AsDateTime;
  // Rozuctovanei strany DAL 321
  mDocSnt:=gKey.IsbDocSnt[pISH.BookNum];
  If mDocSnt='' then mDocSnt:='321';
//  mDocAnl:=AccAnlGen (gKey.IsbDocAnl[pISH.BookNum],pISH.FieldByName('PaCode').AsInteger);
  mDocAnl:=AccAnlCom(gKey.IsbDocAnl[pISH.BookNum],'p',pISH.FieldByName('PaCode').AsInteger);
  If gKey.SysAutReg then AddToAccAnl (mDocSnt,mDocAnl,pISH.FieldByName('PaName').AsString);
  mOcdNum:=''; // Teraz pouzivame na rozdelenie uctovnych zapisov ktore su uctovane na opacnu stranu
  mCredVal:=0;
  mDebVal:=pISH.FieldByName('AcEValue').AsFloat;
  TmpAcc (0,0,pISH.FieldByName('WriNum').AsInteger,0,mDocSnt,mDocAnl,mCredVal,mDebVal,mAccDate,pISH.FieldByName('PaName').AsString,mOcdNum,'',FALSE,FALSE,TRUE,TRUE,0,0,mPaCode,0);
  // Rozuctovanei strany MD 343 DPH
  mOcdNum:=''; // Teraz pouzivame na rozdelenie uctovnych zapisov ktore su uctovane na opacnu stranu
  mDebVal:=0;

  // VatPrc2
  if IsNotNul(pISH.FieldByName('VatPrc2').AsInteger) then begin
    If mAccMth=mVatMth then begin
      mAccSnt:=gKey.IsbVatSnt[pISH.BookNum];
      If mAccSnt='' then mAccSnt:='343';
      mAccAnl:=AccAnlCom(gKey.IsbVatAnl[pISH.BookNum],'v',pISH.FieldByName('VatPrc2').AsInteger);
    end
    else begin
      mAccSnt:=gKey.IsbNvaSnt[pISH.BookNum];
      If mAccSnt='' then mAccSnt:='343';
      mAccAnl:=AccAnlCom(gKey.IsbNvaAnl[pISH.BookNum],'v',pISH.FieldByName('VatPrc2').AsInteger);
    end;
    mDescribe:=GetAnlName (mAccSnt,mAccAnl);
    mCredVal:=pISH.FieldByName('AcEValue2').AsFloat-pISH.FieldByName('AcCValue2').AsFloat;
    TmpAcc (0,0,pISH.FieldByName('WriNum').AsInteger,0,mAccSnt,mAccAnl,mCredVal,mDebVal,mAccDate,mDescribe,mOcdNum,'',FALSE,FALSE,TRUE,TRUE,0,0,mPaCode,0);
  end;
  // VatPrc3
  if IsNotNul(pISH.FieldByName('VatPrc3').AsInteger) then begin
    If mAccMth=mVatMth then begin
      mAccSnt:=gKey.IsbVatSnt[pISH.BookNum];
      If mAccSnt='' then mAccSnt:='343';
      mAccAnl:=AccAnlCom(gKey.IsbVatAnl[pISH.BookNum],'v',pISH.FieldByName('VatPrc3').AsInteger);
    end else begin
      mAccSnt:=gKey.IsbNvaSnt[pISH.BookNum];
      If mAccSnt='' then mAccSnt:='343';
      mAccAnl:=AccAnlCom(gKey.IsbNvaAnl[pISH.BookNum],'v',pISH.FieldByName('VatPrc3').AsInteger);
    end;
    mDescribe:=GetAnlName (mAccSnt,mAccAnl);
    mCredVal:=pISH.FieldByName('AcEValue3').AsFloat-pISH.FieldByName('AcCValue3').AsFloat;
    TmpAcc (0,0,pISH.FieldByName('WriNum').AsInteger,0,mAccSnt,mAccAnl,mCredVal,mDebVal,mAccDate,mDescribe,mOcdNum,'',FALSE,FALSE,TRUE,TRUE,0,0,mPaCode,0);
  end;
  // VatPrc4
  if IsNotNul(pISH.FieldByName('VatPrc4').AsInteger) then begin
    If mAccMth=mVatMth then begin
      mAccSnt:=gKey.IsbVatSnt[pISH.BookNum];
      If mAccSnt='' then mAccSnt:='343';
      mAccAnl:=AccAnlCom(gKey.IsbVatAnl[pISH.BookNum],'v',pISH.FieldByName('VatPrc4').AsInteger);
    end else begin
      mAccSnt:=gKey.IsbNvaSnt[pISH.BookNum];
      If mAccSnt='' then mAccSnt:='343';
      mAccAnl:=AccAnlCom(gKey.IsbNvaAnl[pISH.BookNum],'v',pISH.FieldByName('VatPrc4').AsInteger);
    end;
    mDescribe:=GetAnlName (mAccSnt,mAccAnl);
    mCredVal:=pISH.FieldByName('AcEValue4').AsFloat-pISH.FieldByName('AcCValue4').AsFloat;
    TmpAcc (0,0,pISH.FieldByName('WriNum').AsInteger,0,mAccSnt,mAccAnl,mCredVal,mDebVal,mAccDate,mDescribe,mOcdNum,'',FALSE,FALSE,TRUE,TRUE,0,0,mPaCode,0);
  end;
  // VatPrc5
  if IsNotNul(pISH.FieldByName('VatPrc5').AsInteger) then begin
    If mAccMth=mVatMth then begin
      mAccSnt:=gKey.IsbVatSnt[pISH.BookNum];
      If mAccSnt='' then mAccSnt:='343';
      mAccAnl:=AccAnlCom(gKey.IsbVatAnl[pISH.BookNum],'v',pISH.FieldByName('VatPrc5').AsInteger);
    end else begin
      mAccSnt:=gKey.IsbNvaSnt[pISH.BookNum];
      If mAccSnt='' then mAccSnt:='343';
      mAccAnl:=AccAnlCom(gKey.IsbNvaAnl[pISH.BookNum],'v',pISH.FieldByName('VatPrc5').AsInteger);
    end;
    mDescribe:=GetAnlName (mAccSnt,mAccAnl);
    mCredVal:=pISH.FieldByName('AcEValue5').AsFloat-pISH.FieldByName('AcCValue5').AsFloat;
    TmpAcc (0,0,pISH.FieldByName('WriNum').AsInteger,0,mAccSnt,mAccAnl,mCredVal,mDebVal,mAccDate,mDescribe,mOcdNum,'',FALSE,FALSE,TRUE,TRUE,0,0,mPaCode,0);
  end;
  dmLDG.OpenBook (btISI,pISH.BookNum);
  btISI.IndexName:='DocNum';
  If btISI.FindKey ([L_DocNum.Text]) then begin
    mItmNum:=0;
    PB_Indicator.Max:=pISH.FieldByName('ItmQnt').AsInteger+3;
    PB_Indicator.Position:=0;
    Repeat
      PB_Indicator.StepBy(1);
      Application.ProcessMessages;
        // Rozuctovanei strany MD - hodnota bez DPH
        mAccSnt:=btISI.FieldByName('AccSnt').AsString;
        If mAccSnt='' then begin // Pre polozku nie je zadany specialny ucet
          If copy(btISI.FieldByName('TsdNum').AsString,1,2)='DD' then begin // Tovar
            mAccSnt:=gKey.IsbGscSnt[pISH.BookNum];
          end
          else begin // Sluzby
            mAccSnt:=gKey.IsbSecSnt[pISH.BookNum]; // RZ 11.02.2025
  //          If mAccSnt='' then mAccSnt:='518';
          end;
        end;
        mAccAnl:=btISI.FieldByName('AccAnl').AsString;
        If mAccAnl='' then begin // Pre polozku nie je zadany specialny ucet
          If copy(btISI.FieldByName('TsdNum').AsString,1,2)='DD' then begin // Tovar
            mAccAnl:=gKey.IsbGscAnl[pISH.BookNum];
          end
          else begin // Sluzby
  //          mAccAnl:=gKey.IsbSecAnl[pISH.BookNum];
            If mAccAnl='' then mAccAnl:='000100';
          end;
        end;
        mOcdNum:=''; // Teraz pouzivame na rozdelenie uctovnych zapisov ktore su uctovane na opacnu stranu
        mCredVal:=btISI.FieldByName('AcCValue').AsFloat;
        mDebVal:=0;
        If btISI.FieldByName ('OsdNum').AsString='SIDECHG' then begin
          mCredVal:=0;
          mDebVal:=btISI.FieldByName('AcCValue').AsFloat*(-1);
        end;
        // Urcime text uctovneho zapisu
        If gKey.IsbItmAcc[pISH.BookNum]=0 then mDescribe:=GetAnlName (mAccSnt,mAccAnl);
        If gKey.IsbItmAcc[pISH.BookNum]=1 then mDescribe:=pISH.FieldByName('PaName').AsString;
        If(gKey.IsbItmAcc[pISH.BookNum]=2) or (btISI.FieldByName('Status').AsString='L') then begin
          mItmNum:=btISI.FieldByName('ItmNum').AsInteger;
          mDescribe:=btISI.FieldByName('GsName').AsString;
        end;
        If btISI.FieldByName('GsCode').AsInteger=90100 then mItmNum:=0;
        TmpAcc (mItmNum,btISI.FieldByName('StkNum').AsInteger,btISI.FieldByName('WriNum').AsInteger,0,mAccSnt,mAccAnl,mCredVal,mDebVal,mAccDate,
                mDescribe,mOcdNum,btISI.FieldByName('TsdNum').AsString,FALSE,FALSE,TRUE,TRUE,0,0,mPaCode,0);
        If gKey.IsbTsdAcc[pISH.BookNum] then begin
          If Length(btISI.FieldByName('TsdNum').AsString)=12 then begin
            // Ulozime cislo dodacieho listu do zoznamu ktory sa pouziva pri rozutovani dodacich listov
            If not dmSYS.ptDOCLST.FindKey([btISI.FieldByName('TsdNum').AsString]) then begin
              dmSYS.ptDOCLST.Insert;
              dmSYS.ptDOCLST.FieldByName ('DocNum').AsString:=btISI.FieldByName('TsdNum').AsString;
              dmSYS.ptDOCLST.Post;
            end;
          end;
        end;
      If mAccMth<>mVatMth then begin
        // Preuctovanei strany MD 343 DPH - DAL
        mAccSnt:=gKey.IsbNvaSnt[pISH.BookNum];
        If mAccSnt='' then mAccSnt:='343';
        mAccAnl:=gKey.IsbNvaAnl[pISH.BookNum];
        If mAccAnl='' then mAccAnl:='100019';
        If (mAccAnl='') or (Pos('v',mAccAnl)>0) then begin
          mAccAnl:=ReplaceStr (mAccAnl,'v','');
          mAccAnl:=mAccAnl+StrIntZero(btISI.FieldByName('VatPrc').AsInteger,2);
        end;
        mCredVal:=0;
        mDebVal:=btISI.FieldByName('AcEValue').AsFloat-btISI.FieldByName('AcCValue').AsFloat;
        TmpAcc (0,btISI.FieldByName('StkNum').AsInteger,btISI.FieldByName('WriNum').AsInteger,0,mAccSnt,mAccAnl,mCredVal,mDebVal,
                pISH.FieldByName('VatDate').AsDateTime,'','NVAT1','',FALSE,FALSE,TRUE,TRUE,0,0,mPaCode,0);
        // Preuctovanei strany MD 343 DPH - MD
        mAccSnt:=gKey.IsbVatSnt[pISH.BookNum];
        If mAccSnt='' then mAccSnt:='343';
        mAccAnl:=gKey.IsbVatAnl[pISH.BookNum];
        If (mAccAnl='') or (Pos('v',mAccAnl)>0) then mAccAnl:=StrIntZero(btISI.FieldByName('VatPrc').AsInteger,6);
        mCredVal:=btISI.FieldByName('AcEValue').AsFloat-btISI.FieldByName('AcCValue').AsFloat;
        mDebVal:=0;
        TmpAcc (0,btISI.FieldByName('StkNum').AsInteger,btISI.FieldByName('WriNum').AsInteger,0,mAccSnt,mAccAnl,mCredVal,mDebVal,
                pISH.FieldByName('VatDate').AsDateTime,'','NVAT2','',FALSE,FALSE,TRUE,TRUE,0,0,mPaCode,0);
      end;
      Application.ProcessMessages;
      btISI.Next;
    until (btISI.Eof) or (btISI.FieldByName('DocNum').AsString<>L_DocNum.Text);
    // ------------------------------------------------- SAMOZDANENIE ----------------------------------------------------
    If pISH.FieldByName('DocSpc').AsInteger<>4 then begin // Dovoz z trtích krajín
      If pISH.FieldByName('VatDoc').AsInteger=0 then begin // Samozdaninie
        If gPrp.Acc.ActTsa then begin
          mVatPrc:=gPrp.Acc.DefVat;
          mVatVal:=Rd2(pISH.FieldByName('AcCValue').AsFloat*mVatPrc/100);
          //----------------------- VSTUP > MD ---------------------------
          If pISH.FieldByName('DocSpc').AsInteger in [1,3,11] then begin
            mAccSnt:=gPrp.Acc.FgeSnt[mVatPrc];
            mAccAnl:=gPrp.Acc.FgeAnl[mVatPrc];
          end else begin
            mAccSnt:=gPrp.Acc.AceSnt[mVatPrc];
            mAccAnl:=gPrp.Acc.AceAnl[mVatPrc];
          end;
          mDescribe:=GetAnlName(mAccSnt,mAccAnl);
          TmpAcc(0,0,pISH.FieldByName('WriNum').AsInteger,0,mAccSnt,mAccAnl,mVatVal,0,mAccDate,mDescribe,'','',FALSE,FALSE,TRUE,TRUE,0,0,mPaCode,0);
          //----------------------- VÝSTUP > DAL -------------------------
          If pISH.FieldByName('DocSpc').AsInteger in [1,3,11] then begin
            mAccSnt:=gPrp.Acc.FgoSnt[mVatPrc];
            mAccAnl:=gPrp.Acc.FgoAnl[mVatPrc];
          end else begin
            mAccSnt:=gPrp.Acc.AcoSnt[mVatPrc];
            mAccAnl:=gPrp.Acc.AcoAnl[mVatPrc];
          end;
          mDescribe:=GetAnlName(mAccSnt,mAccAnl);
          TmpAcc(0,0,pISH.FieldByName('WriNum').AsInteger,0,mAccSnt,mAccAnl,0,mVatVal,mAccDate,mDescribe,'','',FALSE,FALSE,TRUE,TRUE,0,0,mPaCode,0);
        end;
      end;
    end;
    // ----------------------------------- Cenove zaokruhlenie medzi stranami MD a DAL -----------------------------------
    SideSum;
    mDescribe:='';
    If gKey.IsbItmAcc[pISH.BookNum]=1 then mDescribe:=pISH.FieldByName('PaName').AsString;
    mDifVal:=Rd2(oDebVal-oCrdVal);
    If IsNotNul(mDifVal) then TmpAcc (0,0,pISH.FieldByName('WriNum').AsInteger,0,gIni.IsRndSnt,gIni.IsRndAnl,mDifVal,0,
                              pISH.FieldByName('VatDate').AsDateTime,'','','',TRUE,TRUE,TRUE,FALSE,0,0,0,0);
    // -------------------------------------------------------------------------------------------------------------------
    pISH.Edit;
    If oSntErr then begin
      pISH.FieldByName ('DocSnt').AsString:='';
      pISH.FieldByName ('DocAnl').AsString:='';
      pISH.FieldByName ('DstAcc').AsString:='';
    end
    else begin
      pISH.FieldByName ('DocSnt').AsString:=mDocSnt;
      pISH.FieldByName ('DocAnl').AsString:=mDocAnl;
      pISH.FieldByName ('DstAcc').AsString:='A';
    end;
    pISH.Post;
  end;
  btISI.Close;
  AddTmpToJour; // Vymaze stare a ulozi nove uctovne zapisy do dennika UZ
  If gKey.IsbTsdAcc[pISH.BookNum] then begin
    If dmSYS.ptDOCLST.FieldCount>0 then begin
      mTsbNum:='';
      dmSYS.ptDOCLST.First;
      Repeat
        L_DocNum.Text:=dmSYS.ptDOCLST.FieldByName ('DocNum').AsString;
        If (mTsbNum='') or (btTCH.BookNum<>mTsbNum) then begin
          mTsbNum:=BookNumFromDocNum (L_DocNum.Text);
          btTSH.Open (mTsbNum);  btTSH.IndexName:='DocNum';
        end;
        If btTSH.FindKey([dmSYS.ptDOCLST.FieldByName ('DocNum').AsString]) then begin
          ptACC.Close;
          ptACC.Open;
          AccountTS (btTSH);  // Rozuctuje DDL
        end;
        Application.ProcessMessages;
        dmSYS.ptDOCLST.Next;
      until dmSYS.ptDOCLST.Eof;
    end;
    dmSYS.ptDOCLST.Close;
  end;
  // ---------------------------------------------------------------------------
  If YearL(mAccDate)<>gvSys.ActYear then begin // Nie je to aktualny rok v kotom bola faktura zauctovana
    If gIni.AccOldIsd then begin
      mDocSnt:=gKey.IsbDocSnt[pISH.BookNum];
      If mDocSnt='' then mDocSnt:='321';
      mDocAnl:=AccAnlGen (gKey.IsbDocAnl[pISH.BookNum],pISH.FieldByName('PaCode').AsInteger);
      mEValue:=pISH.FieldByName('AcEValue').AsFloat-pISH.FieldByName('AcPrvPay').AsFloat;
      TmpAcc (0,0,pISH.FieldByName('WriNum').AsInteger,0,mDocSnt,mDocAnl,
              0,mEValue,FirstActYearDate,
              pISH.FieldByName('PaName').AsString,'','',FALSE,FALSE,TRUE,TRUE,1,0,mPaCode,0);
      TmpAcc (0,0,pISH.FieldByName('WriNum').AsInteger,0,gIni.OpnSuvSnt,gIni.OpnSuvAnl,
              mEValue,0,FirstActYearDate,
              pISH.FieldByName('PaName').AsString,'','',FALSE,FALSE,TRUE,TRUE,1,0,mPaCode,0);
      pISH.Edit;
      pISH.FieldByName ('DocSnt').AsString:=mDocSnt;
      pISH.FieldByName ('DocAnl').AsString:=mDocAnl;
      pISH.FieldByName ('DstAcc').AsString:='A';
      pISH.Post;
      AddTmpToJour; // Vymaze stare a ulozi nove uctovne zapisy do dennika UZ
    end;
  end;
end;

procedure TF_JrnAccF.AccountCS (pCSH:TNexBtrTable);  // Rozuctuje HP
var mCsbSnt,mVatSnt,mItmSnt,mPdfSnt,mCrdSnt:Str3;  mDocDate:TDateTime;
    mCsbAnl,mVatAnl,mItmAnl,mPdfAnl,mCrdAnl:Str6;  mValue,mCrdVal,mDebVal:double;
    mPdfText,mCrdText,mDescribe:Str30;  mDocType:Str2;  mLength:byte;
    mItmNum,mWriNum:word;  mConDoc:Str12;  mPaCode:longint;  mPos:byte;
begin
  btCSI.Open (pCSH.BookNum);
  btCSI.IndexName:='DocNum';
  If btCSI.FindKey ([L_DocNum.Text]) then begin
    mDocDate:=pCSH.FieldByName('DocDate').AsDateTime;
    mPdfText:=gNT.GetSecText('ACCOUNT','PdfVal','Rozdiel uhrady');
    mCrdText:=gNT.GetSecText('ACCOUNT','CrdVal','Kurzový rozdiel');
    mCsbSnt:=gKey.CsbDocSnt[pCSH.BookNum];
    If mCsbSnt='' then mCsbSnt:='211';
    mCsbAnl:=gKey.CsbDocAnl[pCSH.BookNum];
    If mCsbAnl='' then mCsbAnl:='000100';
    mItmNum:=0;
    PB_Indicator.Max:=pCSH.FieldByName('ItmQnt').AsInteger;
    PB_Indicator.Position:=0;
    Repeat
      PB_Indicator.StepBy(1);
      Application.ProcessMessages;
      If not gKey.CsbSumAcc[pCSH.BookNum] then mItmNum:=btCSI.FieldByName('ItmNum').AsInteger;
      mDocType:=copy(btCSI.FieldByName('ConDoc').AsString,1,2);
      mDescribe:=btCSI.FieldByName('Describe').AsString;
      mConDoc:=btCSI.FieldByName('ConDoc').AsString;
      mWriNum:=btCSI.FieldByName('WriNum').AsInteger;
      If mWriNum=0 then mWriNum:=pCSH.FieldByName('WriNum').AsInteger;
      mPaCode:=btCSI.FieldByName('PaCode').AsInteger;
      // Zauctujeme pokladnu - 211
      mCrdVal:=0; mDebVal:=0;
      If pCSH.FieldByName('DocType').AsString='I'
        then mCrdVal:=btCSI.FieldByName('AcBValue').AsFloat
        else mDebVal:=btCSI.FieldByName('AcBValue').AsFloat;
//      TmpAcc (0,0,mWriNum,0,mCsbSnt,mCsbAnl,mCrdVal,mDebVal,mDocDate,mDescribe,'','',FALSE,FALSE,FALSE,FALSE,0,0,mPaCode,0);
      TmpAcc(0,0,mWriNum,0,mCsbSnt,mCsbAnl,mCrdVal,mDebVal,mDocDate,'','','',FALSE,FALSE,FALSE,FALSE,0,0,mPaCode,0);
      If btCSI.FieldByName('ConExt').AsString='DEPOSIT' then begin
        mValue:=btCSI.FieldByName('AcBValue').AsFloat;
        mItmAnl:=AccAnlGen(gKey.Icm.SpvAnl,mPaCode);
        If mValue>0
          then TmpAcc(0,0,mWriNum,0,gKey.Icm.SpvSnt,mItmAnl,0,mValue,mDocDate,'','','',FALSE,FALSE,FALSE,FALSE,0,0,mPaCode,0)
          else TmpAcc(0,0,mWriNum,0,gKey.Icm.SpvSnt,mItmAnl,mValue*(-1),0,mDocDate,'','','',FALSE,FALSE,FALSE,FALSE,0,0,mPaCode,0);
        mValue:=(btCSI.FieldByName('AcBValue').AsFloat-btCSI.FieldByName('AcAValue').AsFloat);
        mVatAnl:=gKey.CsbVaiAnl[pCSH.BookNum];
        mPos:=Pos('v',mVatAnl);
        If (mPos>0) then mVatAnl:=copy(mVatAnl,1,mPos-1)+StrIntZero(btCSI.FieldByName('VatPrc').AsInteger,2);
        TmpAcc(0,0,mWriNum,0,gKey.CsbVaiSnt[pCSH.BookNum],mVatAnl,0,mValue,mDocDate,'','','',FALSE,FALSE,FALSE,FALSE,0,0,mPaCode,0);
        mVatAnl:=gKey.Icm.SptAnl;
        mPos:=Pos('v',mVatAnl);
        If (mPos>0) then mVatAnl:=copy(mVatAnl,1,mPos-1)+StrIntZero(btCSI.FieldByName('VatPrc').AsInteger,2);
        If mValue>0
          then TmpAcc(0,0,mWriNum,0,gKey.Icm.SptSnt,mVatAnl,0,mValue*(-1),mDocDate,'','','',FALSE,FALSE,FALSE,FALSE,0,0,mPaCode,0)
          else TmpAcc(0,0,mWriNum,0,gKey.Icm.SptSnt,mVatAnl,mValue,0,mDocDate,'','','',FALSE,FALSE,FALSE,FALSE,0,0,mPaCode,0);
      end else begin
        // Ucet polozky - 311,321, a pod
        mItmSnt:=btCSI.FieldByName('AccSnt').AsString;
        mItmAnl:=btCSI.FieldByName('AccAnl').AsString;
        // Rozdiel uhrady
        mPdfSnt:=btCSI.FieldByName('PdfSnt').AsString;
        mPdfAnl:=btCSI.FieldByName('PdfAnl').AsString;
        // Kurzovy rozdiel
        mCrdSnt:=btCSI.FieldByName('CrdSnt').AsString;
        mCrdAnl:=btCSI.FieldByName('CrdAnl').AsString;
        L_ExtNum.Text:=btCSI.FieldByName('ConExt').AsString;
        // Zauctujeme DPH - 343
        mCrdVal:=0; mDebVal:=0;
        If pCSH.FieldByName('DocType').AsString='I' then begin
          mVatSnt:=gKey.CsbVaoSnt[pCSH.BookNum];
          mVatAnl:=gKey.CsbVaoAnl[pCSH.BookNum];
          mDebVal:=btCSI.FieldByName('AcBValue').AsFloat-btCSI.FieldByName('AcAValue').AsFloat
        end else begin
          mVatSnt:=gKey.CsbVaiSnt[pCSH.BookNum];
          mVatAnl:=gKey.CsbVaiAnl[pCSH.BookNum];
          mCrdVal:=btCSI.FieldByName('AcBValue').AsFloat-btCSI.FieldByName('AcAValue').AsFloat-btCSI.FieldByName('ExcVatVal').AsFloat;
        end;
        If mVatSnt='' then mVatSnt:='343';
        mLength:=Length (mVatAnl);
  //      If (mVatAnl='' ) or (Pos('v',mVatAnl)>0) then mVatAnl:=StrIntZero(btCSI.FieldByName('VatPrc').AsInteger,mLength);
        If (mVatAnl='' ) then mVatAnl:=StrIntZero(btCSI.FieldByName('VatPrc').AsInteger,mLength);
        mPos:=Pos('v',mVatAnl);
        If (mPos>0) then mVatAnl:=copy(mVatAnl,1,mPos-1)+StrIntZero(btCSI.FieldByName('VatPrc').AsInteger,2);
  //      If IsNotNul (mCrdVal+mDebVal) then TmpAcc (0,0,mWriNum,0,mVatSnt,mVatAnl,mCrdVal,mDebVal,mDocDate,mDescribe,'','',FALSE,FALSE,FALSE,FALSE,0,0,mPaCode,0);
        If IsNotNul (mCrdVal+mDebVal) then TmpAcc (0,0,mWriNum,0,mVatSnt,mVatAnl,mCrdVal,mDebVal,mDocDate,'','','',FALSE,FALSE,FALSE,FALSE,0,0,mPaCode,0);
        // Ak je èiastka vylúèená z DPH
        If IsNotNul(btCSI.FieldByName('ExcVatVal').AsFloat) then begin
          mVatSnt:=gKey.ExcVatSnt[pCSH.BookNum]; If mVatSnt='' then mVatSnt:='343';
          mVatAnl:=gKey.ExcVatAnl[pCSH.BookNum]; If mVatAnl='' then mVatAnl:='000000';
          mCrdVal:=btCSI.FieldByName('ExcVatVal').AsFloat;
          TmpAcc (0,0,mWriNum,0,mVatSnt,mVatAnl,mCrdVal,0,mDocDate,'','','',FALSE,FALSE,FALSE,FALSE,0,0,mPaCode,0);
        end;
        // Protiucet - 311,321 ... polozka pokladnicneho dokladu
        mCrdVal:=0; mDebVal:=0;
        If pCSH.FieldByName('DocType').AsString='I' then begin
          If btCSI.FieldByName('AcAValue').AsFloat>0
            then mDebVal:=btCSI.FieldByName('AcAValue').AsFloat+btCSI.FieldByName('AcPdfVal').AsFloat
            else mCrdVal:=(btCSI.FieldByName('AcAValue').AsFloat+btCSI.FieldByName('AcPdfVal').AsFloat)*(-1)
        end else mCrdVal:=btCSI.FieldByName('AcAValue').AsFloat+btCSI.FieldByName('AcPdfVal').AsFloat-btCSI.FieldByName('ExcCosVal').AsFloat;
        TmpAcc (mItmNum,0,mWriNum,0,mItmSnt,mItmAnl,mCrdVal,mDebVal,mDocDate,mDescribe,'',mConDoc,FALSE,FALSE,FALSE,FALSE,0,0,mPaCode,0);
        // Ak je èiastka vylúèená z z nákladov
        If IsNotNul(btCSI.FieldByName('ExcCosVal').AsFloat) then begin
          mVatSnt:=gKey.ExcCosSnt[pCSH.BookNum]; If mVatSnt='' then mVatSnt:='XXX';
          mVatAnl:=gKey.ExcCosAnl[pCSH.BookNum]; If mVatAnl='' then mVatAnl:='000000';
          mCrdVal:=btCSI.FieldByName('ExcCosVal').AsFloat;
          TmpAcc (0,0,mWriNum,0,mVatSnt,mVatAnl,mCrdVal,0,mDocDate,'','','',FALSE,FALSE,FALSE,FALSE,0,0,mPaCode,0);
        end;
        // Rozdiel uhrady
        If IsNotNul (btCSI.FieldByName('AcPdfVal').AsFloat) then begin
          mCrdVal:=0; mDebVal:=0;
          If btCSI.FieldByName('AcPdfVal').AsFloat>0
            then mCrdVal:=btCSI.FieldByName('AcPdfVal').AsFloat       // 548
            else mDebVal:=Abs(btCSI.FieldByName('AcPdfVal').AsFloat);  // 648
          TmpAcc (0,0,mWriNum,0,mPdfSnt,mPdfAnl,mCrdVal,mDebVal,mDocDate,mPdfText,'',mConDoc,TRUE,TRUE,TRUE,TRUE,0,0,mPaCode,0);
        end;
      end;
      Application.ProcessMessages;
      btCSI.Next;
    until (btCSI.Eof) or (btCSI.FieldByName('DocNum').AsString<>L_DocNum.Text);
  end;
  btCSI.Close;
  pCSH.Edit;
  If oSntErr then begin
    pCSH.FieldByName ('DstAcc').AsString:='';
  end
  else begin
    pCSH.FieldByName ('DstAcc').AsString:='A';
  end;
  pCSH.Post;
  AddTmpToJour; // Vymaze stare a ulozi nove uctovne zapisy do dennika UZ
end;

procedure TF_JrnAccF.AccountID (pIDH,pIDI:TNexBtrTable);  // Rozuctuje ID
begin
  L_ExtNum.Text:='';
  If pIDH.FieldByName('ItmQnt').AsInteger>0 then begin
    try
      pIDI.SwapIndex;
      pIDI.IndexName:='DocNum';
      If pIDI.FindKey([pIDH.FieldByName('DocNum').AsString]) then begin
        PB_Indicator.Max:=pIDH.FieldByName('ItmQnt').AsInteger;
        PB_Indicator.Position:=0;
        Repeat
          PB_Indicator.StepBy(1);
          L_ExtNum.Text:=pIDI.FieldByName('ConExt').AsString;
          TmpAcc (pIDI.FieldByName('ItmNum').AsInteger,0,
                  pIDI.FieldByName('WriNum').AsInteger,0,
                  pIDI.FieldByName('AccSnt').AsString,
                  pIDI.FieldByName('AccAnl').AsString,
                  pIDI.FieldByName('CredVal').AsFloat,
                  pIDI.FieldByName('DebVal').AsFloat,
                  pIDI.FieldByName('DocDate').AsDateTime,
                  pIDI.FieldByName('Describe').AsString,'',
                  pIDI.FieldByName('ConDoc').AsString,FALSE,FALSE,FALSE,FALSE,
                  pIDI.FieldByName('DocType').AsInteger,0,
                  pIDI.FieldByName('PaCode').AsInteger,0);
          Application.ProcessMessages;
          pIDI.Next;
        until pIDI.Eof or (pIDI.FieldByName('DocNum').AsString<>pIDH.FieldByName('DocNum').AsString);
      end;
      pIDH.Edit;
      If oSntErr then begin
        pIDH.FieldByName ('DstAcc').AsString:='';
      end
      else begin
        pIDH.FieldByName ('DstAcc').AsString:='A';
      end;
      pIDH.Post;
    finally
      pIDI.RestoreIndex;
    end;
  end;
  AddTmpToJour; // Vymaze stare a ulozi nove uctovne zapisy do dennika UZ
end;

procedure TF_JrnAccF.AccountVD;  // Rozuctuje VD
var I:byte;  mAccSnt:Str3; mAccAnl:Str6;  mVatVal:double;
begin
  try
    Show;
    L_ExtNum.Text:='';
    L_DocNum.Text:='DU'+gvSys.ActYear2+StrIntZero(dmLDG.btVTBLST.FieldByName('ClsNum').AsInteger,8);
    Application.ProcessMessages;
    ptACC.Open;
    // Preuctujeme DPH na ucet zavazkov voci danovemu uradu
    PB_Indicator.Max:=8;
    PB_Indicator.Position:=0;
    For I:=1 to 8 do begin
      PB_Indicator.StepBy(1);
      mVatVal:=dmLDG.btVTBLST.FieldByName('OuVatVal'+StrInt(I,1)).AsFloat-dmLDG.btVTBLST.FieldByName('InVatVal'+StrInt(I,1)).AsFloat;
      If IsNotNul (mVatVal) then begin
        mAccSnt:='343';
        // Ucet - DPH
        mAccAnl:=StrIntZero(dmLDG.btVTBLST.FieldByName('VatPrc'+StrInt(I,1)).AsInteger,6);
        TmpAcc (0,0,0,0,mAccSnt,mAccAnl,mVatVal,0,
                dmLDG.btVTBLST.FieldByName('EndDate').AsDateTime,
                dmLDG.btVTBLST.FieldByName('Notice').AsString,
                '','',FALSE,FALSE,FALSE,FALSE,0,0,0,0);
        // Ucet - danovy urad
        mAccAnl:='100000';
        TmpAcc (0,0,0,0,mAccSnt,mAccAnl,0,mVatVal,
                dmLDG.btVTBLST.FieldByName('EndDate').AsDateTime,
                dmLDG.btVTBLST.FieldByName('Notice').AsString,
                '','',FALSE,FALSE,FALSE,FALSE,0,0,0,0);
        Application.ProcessMessages;
      end;
    end;
    AddTmpToJour; // Vymaze stare a ulozi nove uctovne zapisy do dennika UZ
  finally
    Hide;
    ptACC.Close;
//    btJOURNAL.Close;
  end;
end;

procedure TF_JrnAccF.AccountSV (pSPV:TNexBtrTable);  // Rozuctuje SV - danove doklady zalohovych platieb
var mAccAnl:Str6;  mBokNum:Str5;
begin
  L_ExtNum.Text:='';
  mBokNum:=BookNumFromDocNum(pSPV.FieldByName('DocNum').AsString);
  If IsNotNul (pSPV.FieldByName('VatVal').AsFloat) then begin
    PB_Indicator.Max:=2;
    PB_Indicator.Position:=0;
    // Ucet 324
    mAccAnl:=gKey.SvbDocAnl[mBokNum];
    If (mAccAnl='') or (Pos('p',mAccAnl)>0) then begin
      If mAccAnl[1]<>'p'
        then mAccAnl:=mAccAnl[1]+StrIntZero(pSPV.FieldByName('PaCode').AsInteger,5)
        else mAccAnl:=StrIntZero(pSPV.FieldByName('PaCode').AsInteger,6);
    end;
    If gKey.SvbAccNeg[mBokNum] then begin
      TmpAcc (1,0,0,0,gKey.SvbDocSnt[mBokNum],mAccAnl,pSPV.FieldByName('VatVal').AsFloat*(-1),0,
              pSPV.FieldByName('DocDate').AsDateTime,pSPV.FieldByName('PaName').AsString,
              '','',FALSE,FALSE,FALSE,FALSE,0,0,pSPV.FieldByName('PaCode').AsInteger,0)
    end else begin
      TmpAcc (1,0,0,0,gKey.SvbDocSnt[mBokNum],mAccAnl,0,pSPV.FieldByName('VatVal').AsFloat,
              pSPV.FieldByName('DocDate').AsDateTime,pSPV.FieldByName('PaName').AsString,
              '','',FALSE,FALSE,FALSE,FALSE,0,0,pSPV.FieldByName('PaCode').AsInteger,0)
    end;
    // Ucet 343
    mAccAnl:=gKey.SvbVatAnl[mBokNum];
    If (mAccAnl='') or (Pos('p',mAccAnl)>0) then begin
      If mAccAnl[1]<>'p'
        then mAccAnl:=mAccAnl[1]+StrIntZero(pSPV.FieldByName('PaCode').AsInteger,5)
        else mAccAnl:=StrIntZero(pSPV.FieldByName('PaCode').AsInteger,6);
    end;
    If gKey.SvbAccNeg[mBokNum] then begin
      TmpAcc (2,0,0,0,gKey.SvbVatSnt[mBokNum],mAccAnl,0,pSPV.FieldByName('VatVal').AsFloat*(-1),
              pSPV.FieldByName('DocDate').AsDateTime,pSPV.FieldByName('PaName').AsString,
              '','',FALSE,FALSE,FALSE,FALSE,0,0,pSPV.FieldByName('PaCode').AsInteger,0)
    end else begin
      TmpAcc (2,0,0,0,gKey.SvbVatSnt[mBokNum],mAccAnl,pSPV.FieldByName('VatVal').AsFloat,0,
              pSPV.FieldByName('DocDate').AsDateTime,pSPV.FieldByName('PaName').AsString,
              '','',FALSE,FALSE,FALSE,FALSE,0,0,pSPV.FieldByName('PaCode').AsInteger,0)
    end;
  end;
  AddTmpToJour; // Vymaze stare a ulozi nove uctovne zapisy do dennika UZ
end;

procedure TF_JrnAccF.AccountMI (pMTBIMD:TNexBtrTable);  // Rozuctuje prijem MTZ
begin
  L_ExtNum.Text:='';
  PB_Indicator.Max:=4;
  PB_Indicator.Position:=0;
  // Rozuctovanei strany MD
  PB_Indicator.StepBy(1);
  Application.ProcessMessages;
  TmpAcc (0,0,0,0,
          pMTBIMD.FieldByName('CinSnt').AsString,
          pMTBIMD.FieldByName('CinAnl').AsString,
          pMTBIMD.FieldByName('CValue').AsFloat,0,
          pMTBIMD.FieldByName('DocDate').AsDateTime,
          pMTBIMD.FieldByName('MtName').AsString,
          '','',FALSE,FALSE,FALSE,TRUE,0,0,0,0);
  // Rozuctovanei strany DAL
  PB_Indicator.StepBy(1);
  Application.ProcessMessages;
  TmpAcc (0,0,0,0,
          pMTBIMD.FieldByName('DinSnt').AsString,
          pMTBIMD.FieldByName('DinAnl').AsString,
          0,pMTBIMD.FieldByName('CValue').AsFloat,
          pMTBIMD.FieldByName('DocDate').AsDateTime,
          pMTBIMD.FieldByName('MtName').AsString,
          '','',FALSE,FALSE,FALSE,TRUE,0,0,0,0);
  AddTmpToJour; // Vymaze stare a ulozi nove uctovne zapisy do dennika UZ
end;

procedure TF_JrnAccF.AccountMO (pMTBOMD:TNexBtrTable);  // Rozuctuje vydaj MTZ
begin
  L_ExtNum.Text:='';
  PB_Indicator.Max:=4;
  PB_Indicator.Position:=0;
  // Rozuctovanei strany MD
  PB_Indicator.StepBy(1);
  Application.ProcessMessages;
  TmpAcc (0,0,pMTBOMD.FieldByName('WriNum').AsInteger,0,
          pMTBOMD.FieldByName('CouSnt').AsString,
          pMTBOMD.FieldByName('CouAnl').AsString,
          pMTBOMD.FieldByName('CValue').AsFloat,0,
          pMTBOMD.FieldByName('DocDate').AsDateTime,
          pMTBOMD.FieldByName('MtName').AsString,
          '','',FALSE,FALSE,FALSE,TRUE,0,0,0,0);
  // Rozuctovanei strany DAL
  PB_Indicator.StepBy(1);
  Application.ProcessMessages;
  TmpAcc (0,0,pMTBOMD.FieldByName('WriNum').AsInteger,0,
          pMTBOMD.FieldByName('DouSnt').AsString,
          pMTBOMD.FieldByName('DouAnl').AsString,
          0,pMTBOMD.FieldByName('CValue').AsFloat,
          pMTBOMD.FieldByName('DocDate').AsDateTime,
          pMTBOMD.FieldByName('MtName').AsString,
          '','',FALSE,FALSE,FALSE,TRUE,0,0,0,0);
  AddTmpToJour; // Vymaze stare a ulozi nove uctovne zapisy do dennika UZ
end;

procedure TF_JrnAccF.AccountOW (pOWH:TNexBtrTable);  // Rozuctuje SC
var mAccSnt:Str3;  mAccAnl:Str6;   mAccDate:TDateTime;
    mCrdVal:double;  // Kumulativny kurzovy rozdiel
begin
  L_DocNum.Text:=pOWH.FieldByName('DocNum').AsString;
  L_ExtNum.Text:=pOWH.FieldByName('ExtNum').AsString;
  If pOWH.FieldByName('ItmQnt').AsInteger>0 then begin
    try
      btOWI.Open (pOWH.BookNum);
      btOWI.IndexName:='DocNum';
      If btOWI.FindKey ([L_DocNum.Text]) then begin
        PB_Indicator.Max:=pOWH.FieldByName('ItmQnt').AsInteger;
        PB_Indicator.Position:=0;
        Repeat
          PB_Indicator.StepBy(1);
          // Rozuctovanie strany MD
          TmpAcc (0,0,pOWH.FieldByName('WriNum').AsInteger,0,
                  btOWI.FieldByName('AccSnt').AsString,btOWI.FieldByName('AccAnl').AsString,
                  btOWI.FieldByName('AcBValue').AsFloat-btOWI.FieldByName('AcVatVal').AsFloat,0,
                  pOWH.FieldByName('DocDate').AsDateTime,
                  btOWI.FieldByName('Describe').AsString,
                  '','',FALSE,FALSE,FALSE,FALSE,0,0,
                  pOWH.FieldByName('EpCode').AsInteger,0);
          If IsNotNul (btOWI.FieldByName('AcVatVal').AsFloat) then begin
            // Rozuctovanei strany MD 343 DPH
            mAccSnt:=gKey.OwbVatSnt[pOWH.BookNum];
            If mAccSnt='' then mAccSnt:='343';
            mAccAnl:=gKey.OwbVatAnl[pOWH.BookNum];;
            If (mAccAnl='') or (Pos('v',mAccAnl)>0) then mAccAnl:=StrIntZero(btOWI.FieldByName('VatPrc').AsInteger,6);
            TmpAcc (0,0,pOWH.FieldByName('WriNum').AsInteger,0,mAccSnt,mAccAnl,
                    btOWI.FieldByName('AcVatVal').AsFloat,0,
                    pOWH.FieldByName('DocDate').AsDateTime,
                    btOWI.FieldByName('Describe').AsString,
                    '','',FALSE,FALSE,TRUE,TRUE,0,0,
                    pOWH.FieldByName('EpCode').AsInteger,0);
          end;
          // Rozuctovanie strany MD
          TmpAcc (0,0,pOWH.FieldByName('WriNum').AsInteger,0,
                  gKey.OwbDocSnt[pOWH.BookNum],gKey.OwbDocAnl[pOWH.BookNum],
                  0,btOWI.FieldByName('AcBValue').AsFloat,
                  pOWH.FieldByName('DocDate').AsDateTime,
                  pOWH.FieldByName('EpName').AsString,
                  '','',FALSE,FALSE,FALSE,FALSE,0,0,
                  pOWH.FieldByName('EpCode').AsInteger,0);
          Application.ProcessMessages;
          btOWI.Next;
        until btOWI.Eof or (btOWI.FieldByName('DocNum').AsString<>pOWH.FieldByName('DocNum').AsString);
      end;
    finally
      btOWI.Close;
    end;
    // Zauctovanie kurzoveho rozdielu
    btPMI.Open (YearL(pOWH.FieldByName ('DocDate').AsDateTime));
    btPMI.IndexName:='ConDoc';
    If btPMI.FindKey([pOWH.FieldByName ('DocNum').AsString]) then begin
      Repeat
        If btPMI.FieldByName('Status').AsString<>'D' then begin
          If btPMI.FieldByName('PayDate').AsDateTime<pOWH.FieldByName ('DocDate').AsDateTime
            then mAccDate:=pOWH.FieldByName ('DocDate').AsDateTime
            else mAccDate:=btPMI.FieldByName('PayDate').AsDateTime;
          mCrdVal:=btPMI.FieldByName('AcCrdVal').AsFloat;
          If IsNotNul (mCrdVal) then begin
            If (mCrdVal>0) then begin // Kurzovy zisk
              // Strana MD
              TmpAcc (0,0,pOWH.FieldByName('WriNum').AsInteger,0,
                      gKey.OwbDocSnt[pOWH.BookNum],gKey.OwbDocAnl[pOWH.BookNum],
                      mCrdVal,0,mAccDate,pOWH.FieldByName('EpName').AsString,
                      'K-'+DateToStr(mAccDate),'',FALSE,FALSE,FALSE,TRUE,0,0,
                      pOWH.FieldByName('EpCode').AsInteger,0);
              // Strana DAL
              TmpAcc (0,0,pOWH.FieldByName('WriNum').AsInteger,0,
                      gIni.CrdPrfSnt,gIni.CrdPrfAnl,
                      0,mCrdVal,mAccDate,pOWH.FieldByName('EpName').AsString,
                      'K-'+DateToStr(mAccDate),'',FALSE,FALSE,FALSE,TRUE,0,0,
                      pOWH.FieldByName('EpCode').AsInteger,0);
            end
            else begin // Kurzova strata
              // Strana MD
              TmpAcc (0,0,pOWH.FieldByName('WriNum').AsInteger,0,
                      gIni.CrdLosSnt,gIni.CrdLosAnl,
                      Abs(mCrdVal),0,mAccDate,pOWH.FieldByName('EpName').AsString,
                      'K-'+DateToStr(mAccDate),'',FALSE,FALSE,FALSE,TRUE,0,0,
                      pOWH.FieldByName('EpCode').AsInteger,0);
              // Strana DAL
              TmpAcc (0,0,pOWH.FieldByName('WriNum').AsInteger,0,
                      gKey.OwbDocSnt[pOWH.BookNum],gKey.OwbDocAnl[pOWH.BookNum],
                      0,Abs(mCrdVal),mAccDate,pOWH.FieldByName('EpName').AsString,
                      'K-'+DateToStr(mAccDate),'',FALSE,FALSE,FALSE,TRUE,0,0,
                      pOWH.FieldByName('EpCode').AsInteger,0);
            end;
          end;
        end;
        Application.ProcessMessages;
        btPMI.Next;
      until btPMI.Eof or (btPMI.FieldByName ('ConDoc').AsString<>pOWH.FieldByName ('DocNum').AsString);
      btPMI.Close;
    end;
    pOWH.Edit;
    If oSntErr then begin
      pOWH.FieldByName ('DstAcc').AsString:='';
    end
    else begin
      pOWH.FieldByName ('DstAcc').AsString:='A';
    end;
    pOWH.Post;
  end;
  AddTmpToJour; // Vymaze stare a ulozi nove uctovne zapisy do dennika UZ
end;

procedure TF_JrnAccF.ptACCBeforeOpen(DataSet: TDataSet);
begin
  ptACC.FieldDefs.Clear;
  ptACC.FieldDefs.Add ('ItmNum',ftInteger,0,FALSE);
  ptACC.FieldDefs.Add ('StkNum',ftInteger,0,FALSE);
  ptACC.FieldDefs.Add ('WriNum',ftInteger,0,FALSE);
  ptACC.FieldDefs.Add ('CentNum',ftInteger,0,FALSE);
  ptACC.FieldDefs.Add ('OcdNum',ftString,12,FALSE);
  ptACC.FieldDefs.Add ('ConDoc',ftString,12,FALSE);
  ptACC.FieldDefs.Add ('AccSnt',ftString,3,FALSE);
  ptACC.FieldDefs.Add ('AccAnl',ftString,6,FALSE);
  ptACC.FieldDefs.Add ('CredVal',ftFloat,0,FALSE);
  ptACC.FieldDefs.Add ('DebVal',ftFloat,0,FALSE);
  ptACC.FieldDefs.Add ('DocDate',ftDate,0,FALSE);
  ptACC.FieldDefs.Add ('Describe',ftString,30,FALSE);
  ptACC.FieldDefs.Add ('BegRec',ftInteger,0,FALSE);
  ptACC.FieldDefs.Add ('SmCode',ftInteger,0,FALSE);
  ptACC.FieldDefs.Add ('PaCode',ftInteger,0,FALSE);
  ptACC.FieldDefs.Add ('SpaCode',ftInteger,0,FALSE);
  ptACC.FieldDefs.Add ('ExtNum',ftString,12,FALSE);

  ptACC.IndexDefs.Clear;
  ptACC.IndexDefs.Add ('','ItmNum;StkNum;WriNum;CentNum;OcdNum;ConDoc;AccSnt;AccAnl',[ixPrimary]);
  ptACC.CreateTable;
end;

end.
{MOD 1903011}
{MOD 1905013}
{MOD 1905023}
{MOD 1912001 - Rozúètovanie zálohovej platby - úètovalo na opaèné strany}


(*
*********************************************************************
*********************** ROZDIEL UHRADY FAKTUR ***********************
*********************************************************************
AccVal+PdfVal = InvVal - Hodnota faktury
1. BV:  100.00  PD: -0.10   OF:   99.90  faktura   648
2.                          DF:  -99.90  dobropis  648
3.              PD:  0.10   OF:  100.10  faktura   548
4.                          DF: -100.10  dobropis  548

5. BV: -100.00  PD: -0.10   OF: -100.10  dobropis  648
6.                          DF:  100.10  faktura   648
7.              PD:  0.10   OF:  -99.90  dobropis  548
8.                          DF:   99.90  faktura   548

Rozuctovanie:
       ------- PayVal>0 -------            ------- PayVal<0 -------
1. OF  221       100.00    0.00     5. OD  221         0.00  100.00
       311         0.00   99.90            311       100.10    0.00
       648         0.00    0.10            648         0.00    0.10

2. DD  221       100.00    0.00     6. DF  221         0.00  100.00
       321       -99.90    0.00            321       100.10    0.00
       648         0.00    0.10            648         0.00    0.10

3. OF  221       100.00    0.00     7. OD  221         0.00  100.00
       311         0.00  100.10            311        99.90    0.00
       548         0.10    0.00            548         0.10    0.00

4. DD  221       100.00    0.00     8. DF  221         0.00  100.00
       321      -100.10    0.00            321        99.90    0.00
       548         0.10    0.00            548         0.10    0.00

*********************************************************************
********************** KURZOVY ROZDIEL Z UHRADY *********************
*********************************************************************
AccVal+PdfVal = InvVal - Hodnota faktury
1. BV:  1000.00  CR: -50.00  OF: 663
2.                           DF: 663
3.               CR:  50.00  OF: 563
4.                           DF: 563

5. BV: -1000.00  CR: -50.10  OF: 648
6.                           DF: 648
7.               CR:  50.10  OF: 548
8.                           DF: 548

Rozuctovanie:
       ------- CrdVal>0 -------            ------- CrdVal<0 -------
1. OF  221      1000.00    0.00     5. OD  221         0.00  100.00
       311         0.00   99.90            311       100.10    0.00
       648         0.00    0.10            648         0.00    0.10

2. DD  221       100.00    0.00     6. DF  221         0.00  100.00
       321       -99.90    0.00            321       100.10    0.00
       648         0.00    0.10            648         0.00    0.10

3. OF  221       100.00    0.00     7. OD  221         0.00  100.00
       311         0.00  100.10            311        99.90    0.00
       548         0.10    0.00            548         0.10    0.00

4. DD  221       100.00    0.00     8. DF  221         0.00  100.00
       321      -100.10    0.00            321        99.90    0.00
       548         0.10    0.00            548         0.10    0.00
*)


