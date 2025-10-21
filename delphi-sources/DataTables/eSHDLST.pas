unit eSHDLST;

interface

uses
  IcTypes, IcConv, IcTools, NexClc, Cnt, Prp, dSHDLST,
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Dialogs;

type
  TShdlstHne=class(TShdlstDat)
  private
  public
    procedure Post; overload;
  published
  end;

implementation

// *************************************** PRIVATE ********************************************

// **************************************** PUBLIC ********************************************

procedure TShdlstHne.Post;
var mBonVal:double;
begin
  PprAva:=PsaAva-PstAva;
  PprPrc:=ClcPrfPrc(PstAva,PsaAva);
  AprAva:=AsaAva-AstAva;
  AprPrc:=ClcPrfPrc(AstAva,AsaAva);
  CstAva:=PstAva+AstAva;
  CsaAva:=PsaAva+AsaAva;
  CsaBva:=PsaBva+AsaBva;
  CreAva:=PreAva+AreAva;
  CreBva:=PreBva+AreBva;
  CdcAva:=PdcAva+AdcAva;
  CdcBva:=PdcBva+AdcBva;
  CprAva:=CsaAva-CstAva;
  CprPrc:=ClcPrfPrc(CstAva,CsaAva);
  If BonCnv>0 then begin  
    ActBov:=AsaAva;
    BasBov:=PncBov+ActBov;
    If IsNotNul(BonCnv) then InpBon:=Round(Int(BasBov/BonCnv));
    BonBov:=InpBon*BonCnv;
    AncBov:=BasBov-BonBov;
    ActBon:=InpBon-OutBon;
  end else begin
    PncBov:=0;  ActBov:=0;  BasBov:=0;  BonBov:=0;
    AncBov:=0;  InpBon:=0;  OutBon:=0;  ActBon:=0;
  end;
  inherited ;
end;

end.
