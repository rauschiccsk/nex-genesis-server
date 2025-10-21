unit EmdFnc;
// *****************************************************************************
//                 FUNKCIE, NA VYTVORENIE EMAILOV›CH SPR¡V
// *****************************************************************************
// *****************************************************************************

interface

uses
  BasSrv,
  IcTypes, IcConv, IcVariab, IcTools, IcDate, Prp, NexPath, EmdHnd, Cnt, eEMDLST, eEMDATD,
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Dialogs, Forms, DateUtils;

type
  TEmdFnc=class
    constructor Create;
    destructor Destroy; override;
  private
  public
    oEmh:TEmdHnd;
    oErrCod:integer;
    ohEMDLST:TEmdlstHne;
    ohEMDATD:TEmdatdHne;

    procedure AddVar(pVarNam,pVarVal:ShortString); // Orid· premennÈ emailovej spr·vy
    procedure CrtTxtEmd(pEmdNum:longint;pEmlTxt:string);  // VytvorÌ textov˙ emailov˙ spr·vu, ktor˙ potom emailov˝ server dokonËÌ a odoöle
    procedure CrtEmd(pEmdNum:longint);  // VytvorÌ html emailov˙ spr·vu, ktor˙ potom emailov˝ server dokonËÌ a odoöle
    procedure SavAtd(pEmdNum:longint;pAtdNam:Str30);    // UloûÌ do zoznamu prÌlohu
    function AddAtd:boolean;   // Sk˙si pridaù prÌlohu
    function SndEmd:boolean;   // Odoöle email

    property ErrCod:integer read oErrCod;
  end;

function AdrVer(pEmlAdr:ShortString):boolean;  // TRUE ak emailov· adresa m· spre·vny syntax

implementation

uses EmdPrp, dEMDLST;

function AdrVer(pEmlAdr:ShortString):boolean;  // TRUE ak emailov· adresa m· spre·vny syntax
var mDot,mEmc,I:integer;
begin
  mDot:=0; mEmc:=0;
  If pEmlAdr<>'' then begin
    For I:=1 to Length(pEmlAdr) do begin
      If pEmlAdr[I]='@' then Inc(mEmc);
      If pEmlAdr[I]='.' then Inc(mDot);
    end;
  end;
  Result:=(mDot>0) and (mEmc=1);
end;

// ********************************** OBJECT ***********************************

constructor TEmdFnc.Create;
begin
  ohEMDLST:=TEmdlstHne.Create;
  ohEMDATD:=TEmdatdHne.Create;
  oEmh:=TEmdHnd.Create;
end;

destructor TEmdFnc.Destroy;
begin
  FreeAndNil(oEmh);
  FreeAndNil(ohEMDATD);
  FreeAndNil(ohEMDLST);
end;

// ******************************** PRIVATE ************************************

// ******************************** PUBLIC *************************************

procedure TEmdFnc.AddVar(pVarNam,pVarVal:ShortString); // Orid· premennÈ emailovej spr·vy
begin
  oEmh.AddVar(pVarNam,pVarVal);
end;

procedure TEmdFnc.CrtTxtEmd(pEmdNum:longint;pEmlTxt:string);
var mEmlNam:Str20;
begin
  If ohEMDLST.LocEmdNum(pEmdNum) then begin
    oEmh.AddTrgAdr(ohEMDLST.TrgAdr);
    oEmh.SndNam:=ohEMDLST.SndNam;
    oEmh.SndAdr:=ohEMDLST.SndAdr;
    oEmh.RcvAdr:=ohEMDLST.SndAdr;
    oEmh.HidAdr:=ohEMDLST.HidAdr;
    oEmh.Subjec:=ohEMDLST.Subjec;
    oEmh.AddBody(pEmlTxt);
    oEmh.SaveDraft(gPath.EmlPath,StrInt(ohEMDLST.EmdNum,0)+'.emd');
    oErrCod:=oEmh.ErrCod;
  end;
end;

procedure TEmdFnc.CrtEmd(pEmdNum:longint);
var mEmlNam:Str20;
begin
  If ohEMDLST.LocEmdNum(pEmdNum) then begin
    oEmh.AddTrgAdr(ohEMDLST.TrgAdr);
    oEmh.SndNam:=ohEMDLST.SndNam;
    oEmh.SndAdr:=ohEMDLST.SndAdr;
    oEmh.RcvAdr:=ohEMDLST.SndAdr;
    oEmh.HidAdr:=ohEMDLST.HidAdr;
    oEmh.Subjec:=ohEMDLST.Subjec;
    oEmh.AddBodyHTMLMask(gPath.RepPath,ohEMDLST.EmlMsk);
    oEmh.SaveDraft(gPath.EmlPath,StrInt(ohEMDLST.EmdNum,0)+'.emd');
    oErrCod:=oEmh.ErrCod;
  end;
end;

procedure TEmdFnc.SavAtd(pEmdNum:longint;pAtdNam:Str30);    // UloûÌ do zoznamu prÌlohu
var mAtdDoq:byte;
begin
  ohEMDATD.Insert;
  ohEMDATD.EmdNum:=pEmdNum;
  ohEMDATD.AtdNam:=pAtdnam;
  ohEMDATD.Post;
  mAtdDoq:=0;
  If ohEMDATD.LocEmdNum(pEmdNum) then begin
    Repeat
      Inc(mAtdDoq);
      ohEMDATD.Next;
    until ohEMDATD.Eof or (ohEMDATD.EmdNum<>pEmdNum)
  end;
  ohEMDLST.Edit;
  ohEMDLST.AtdDoq:=mAtdDoq;
  ohEMDLST.Post;
end;

function TEmdFnc.AddAtd:boolean;   // Sk˙si pridaù prÌlohu
var mEmh:TEmdHnd; mSndSta:Str1;  mAtdLst:string;
begin
  Result:=FALSE;
  mSndSta:=ohEMDLST.SndSta;
  If mSndSta[1] in ['P'] then begin
    try
      mEmh:=TEmdHnd.Create;
      If ohEMDATD.LocEmdNum(ohEMDLST.EmdNum) then begin
        mAtdLst:='';
        Repeat
          If mAtdLst<>'' then mAtdLst:=mAtdLst+';';
          mAtdLst:=mAtdLst+ohEMDATD.AtdNam;
          ohEMDATD.Next;
        until ohEMDATD.Eof or (ohEMDATD.EmdNum<>ohEMDLST.EmdNum);
        Result:=mEmh.AddAttachToDraft(gPath.EmlPath,StrInt(ohEMDLST.EmdNum,0)+'.emd',gPath.ArcPath+'DOC\',mAtdLst);
      end;
      mSndSta:='P';  // »ak· na pripojenie prÌlohy
      If not Result then begin
        If (ohEMDLST.AtdCnt>20) then mSndSta:='E';  // Chyba pripojenia prÌlohy
      end else mSndSta:='W';  // »ak· na odoslanie
      ohEMDLST.Edit;
      ohEMDLST.AtdCnt:=ohEMDLST.AtdCnt+1;
      ohEMDLST.ErrCod:=mEmh.ErrCod;
      ohEMDLST.SndSta:=mSndSta;
      ohEMDLST.Post;
      FreeAndNil(mEmh);
      SetLastProc('Pripojenie prÌlohy ('+StrInt(ohEMDLST.EmdNum,0)+'). Stav: '+mSndSta+'  ');
    except end;
  end;
end;

function TEmdFnc.SndEmd:boolean;   // Odoöle email
var mEmh:TEmdHnd;  mSndSta:Str1;
begin
  Result:=FALSE;
  mSndSta:=ohEMDLST.SndSta;
  If mSndSta[1] in ['W'] then begin
    try
      mEmh:=TEmdHnd.Create;
      mEmh.Smtp:=gPrp.Emd.Smtp;
      mEmh.Port:=gPrp.Emd.Port;
      mEmh.User:=gPrp.Emd.User;
      mEmh.Pasw:=gPrp.Emd.Pasw;
      Result:=mEmh.SendDraft(gPath.EmlPath,StrInt(ohEMDLST.EmdNum,0)+'.emd');
      mSndSta:='W';  // »ak· na odoslanie
      If not Result then begin
        If (ohEMDLST.SndCnt>20) then mSndSta:='E';  // Chyba odoslania spr·vy
      end else mSndSta:='S';  // Odoslan· spr·va
      ohEMDLST.Edit;
      ohEMDLST.SndCnt:=ohEMDLST.SndCnt+1;
      ohEMDLST.ErrCod:=mEmh.ErrCod;
      ohEMDLST.SndSta:=mSndSta;
      If mSndSta='S' then begin
        ohEMDLST.SndDte:=Date;
        ohEMDLST.SndTim:=Time;
      end;  
      ohEMDLST.Post;
      FreeAndNil(mEmh);
      SetLastProc('Odoslanie mailu ('+StrInt(ohEMDLST.EmdNum,0)+'). Stav: '+mSndSta+'  ');
    except end;
  end;
end;

end.


