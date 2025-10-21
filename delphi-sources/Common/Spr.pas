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
  ohSPRLST.SerNum:=mSerNum;  // Poradov� ��slo z�znamu
  ohSPRLST.DocNum:=pDocNum;  // Intern� ��slo dokladu
  ohSPRLST.GsCode:=pGsCode;  // Katal�gov� ��slo produktu (PLU)
  ohSPRLST.PaCode:=pPaCode;  // Katal�gov� ��slo firmy, pre ktor� doklad bol vystaven�
  ohSPRLST.DocDes:=pDocDes;  // Popis syst�movej spr�vy
  ohSPRLST.Reason:=pReason;  // D�vod vzniku z�znamu
  ohSPRLST.Soluti:=pSoluti;  // Popis rie�enia
  ohSPRLST.PrgMod:=pPrgMod;  // Skratka programov�ho modulu, v ktorom vznikol z�znam
  ohSPRLST.CrtNam:=gvSys.LoginName;
  ohSPRLST.CrtUsr:=gvSys.UserName;
  ohSPRLST.CrtDat:=Date;
  ohSPRLST.CrtTim:=Time;
  ohSPRLST.DocPri:=pDocPri;  // Priorita z�znamu (!-vysok� priorita)
  ohSPRLST.DocSta:='W';      // Pr�znak stavu protokolu (W-�ak� na rie�enie;C-Ukon�en�)
  ohSPRLST.Post;
end;

end.
{MOD 19.24}
