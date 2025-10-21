unit Spr;

{$F+}

interface

uses
  IcTypes, IcConst, IcConv, IcTools, IcVariab, bSPRLST, hSPRLST,
  NexBtrTable, NexPxTable, NexGlob, NexPath, NexIni, NexMsg, NexError,
  StkGlob, DocHand, LinLst,  SavClc, TxtDoc, TxtWrap,
  DB, SysUtils, Classes, Graphics, ExtCtrls, Jpeg, Forms;

type
  TSpr=class(TComponent)
    constructor Create;
    destructor Destroy; override;
    private
      function NextSerNum:longint;
    public
      ohSPRLST:TSprlstHnd;
      procedure Add(pDocNum:Str12;pGsCode,pPaCode:longint;pDocDes,pReason,pSoluti:Str250;pPrgMod:Str3;pDocPri:Str1);
    published
  end;

implementation

constructor TSpr.Create;
begin
  ohSPRLST:=TSprlstHnd.Create;
  ohSPRLST.Open;
end;

destructor TSpr.Destroy;
begin
  FreeAndNil(ohSPRLST);
end;

// ********************************* PRIVATE ***********************************

function TSpr.NextSerNum:longint;
begin
  ohSPRLST.SwapStatus;
  ohSPRLST.SetIndex(ixSerNum);
  ohSPRLST.Last;
  Result:=ohSPRLST.SerNum+1;
  ohSPRLST.RestoreStatus;
end;

// ********************************* PUBLIC ************************************

procedure TSpr.Add(pDocNum:Str12;pGsCode,pPaCode:longint;pDocDes,pReason,pSoluti:Str250;pPrgMod:Str3;pDocPri:Str1);
var mSerNum:longint;
begin
  mSerNum:=NextSerNum;
  ohSPRLST.Insert;
  ohSPRLST.SerNum:=mSerNum;  // Poradové èíslo záznamu
  ohSPRLST.DocNum:=pDocNum;  // Interné èíslo dokladu
  ohSPRLST.GsCode:=pGsCode;  // Katalógové èíslo produktu (PLU)
  ohSPRLST.PaCode:=pPaCode;  // Katalógové èíslo firmy, pre ktorú doklad bol vystavený
  ohSPRLST.DocDes:=pDocDes;  // Popis systémovej správy
  ohSPRLST.Reason:=pReason;  // Dôvod vzniku záznamu
  ohSPRLST.Soluti:=pSoluti;  // Popis riešenia
  ohSPRLST.PrgMod:=pPrgMod;  // Skratka programového modulu, v ktorom vznikol záznam
  ohSPRLST.CrtNam:=gvSys.LoginName;
  ohSPRLST.CrtUsr:=gvSys.UserName;
  ohSPRLST.CrtDat:=Date;
  ohSPRLST.CrtTim:=Time;
  ohSPRLST.DocPri:=pDocPri;  // Priorita záznamu (!-vysoká priorita)
  ohSPRLST.DocSta:='W';      // Príznak stavu protokolu (W-èaká na riešenie;C-Ukonèený)
  ohSPRLST.Post;
end;

end.
{MOD 19.24}
