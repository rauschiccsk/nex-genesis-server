unit PrpAcc;
// =============================================================================
//                      PREDVOLEN… NASTAVENIA PRE ⁄»TOVNÕCTVO
// -----------------------------------------------------------------------------
// ****************************** POPIS PARAMETROV *****************************
// -----------------------------------------------------------------------------
//                                 Z¡KLADN… ⁄DAJE
// -----------------------------------------------------------------------------
// DefVat - z·kladn· sadzba DPH v %
// VatLst - zoznam povolen˝ch sadzieb DPH v %
// AnlChr - poËet znakov analytickej Ëasti ˙Ëtu
// -----------------------------------------------------------------------------
//     PREDVOLEN… NASTAVENIA PRE ⁄»TOVANIE BANKY, POKLADNE A INTERN… DOKLADY
// -----------------------------------------------------------------------------
// PdcSnt - syntetick· Ëaasù ˙Ëtu pre cenov˝ rozdiel, Ëo tovrÌ v˝nos
// PdcAnl - analytick· Ëaasù ˙Ëtu pre cenov˝ rozdiel, Ëo tovrÌ v˝nos
// PddSnt - syntetick· Ëaasù ˙Ëtu pre cenov˝ rozdiel, Ëo tovrÌ n·klad
// PddAnl - analytick· Ëaasù ˙Ëtu pre cenov˝ rozdiel, Ëo tovrÌ n·klad
// CdcSnt - syntetick· Ëaasù ˙Ëtu pre kurzov˝ rozdiel, Ëo tovrÌ v˝nos
// CdcAnl - analytick· Ëaasù ˙Ëtu pre kurzov˝ rozdiel, Ëo tovrÌ v˝nos
// CddSnt - syntetick· Ëaasù ˙Ëtu pre kurzov˝ rozdiel, Ëo tovrÌ n·klad
// CddAnl - analytick· Ëaasù ˙Ëtu pre kurzov˝ rozdiel, Ëo tovrÌ n·klad
// -----------------------------------------------------------------------------
//                          NASTAVENIA PRE SAMOZDANENIE
// -----------------------------------------------------------------------------
// ActTsa - aktivovaù ˙Ëtovanie samozdanenia na vstupe a na v˝stupe
// AceSnt - syntetick˝ ˙Ëet na strane vstupu pre tuzemskÈ fakt˙ry
// AceAnl - analytick˝ ˙Ëet na strane vstupu pre tuzemskÈ fakt˙ry
// AcoSnt - syntetick˝ ˙Ëet na strane v˝stupu pre tuzemskÈ fakt˙ry
// AcoAnl - analytick˝ ˙Ëet na strane v˝stupu pre tuzemskÈ fakt˙ry
// FgeSnt - syntetick˝ ˙Ëet na strane vstupu pre zahraniËnÈ fakt˙ry
// FgeAnl - analytick˝ ˙Ëet na strane vstupu pre zahraniËnÈ fakt˙ry
// FgoSnt - syntetick˝ ˙Ëet na strane v˝stupu pre zahraniËnÈ fakt˙ry
// FgoAnl - analytick˝ ˙Ëet na strane v˝stupu pre zahraniËnÈ fakt˙ry
// -----------------------------------------------------------------------------
//                  PREDVOLEN… NASTAVENIA PRE ⁄»TOVANIE FAKT⁄R
// -----------------------------------------------------------------------------
// IsdSnt - syntetick· Ëasù fakturaËnÈho ˙Ëtu (321)
// IsdAnl - analytick· Ëasù fakturaËnÈho ˙Ëtu
// IsvSnt - syntetick· Ëasù ˙Ëtu pre DPH (343)
// IsvAnl - analytick· Ëasù ˙Ëtu pre DPH
// IsmSnt - syntetick· Ëasù ˙Ëtu pre obstaranie materi·lu (111)
// IsmAnl - analytick· Ëasù ˙Ëtu pre obstaranie materi·lu
// IsgSnt - syntetick· Ëasù ˙Ëtu pre obstaranie tovaru (131)
// IsgAnl - analytick· Ëasù ˙Ëtu pre obstaranie tovaru
// IssSnt - syntetick· Ëasù ˙Ëtu pre obstaranie sluûieb (518)
// IssAnl - analytick· Ëasù ˙Ëtu pre obstaranie sluûieb
//
// IcdSnt - syntetick· Ëasù fakturaËnÈho ˙Ëtu (311)
// IcdAnl - analytick· Ëasù fakturaËnÈho ˙Ëtu
// IcvSnt - syntetick· Ëasù ˙Ëtu pre DPH (343)
// IcvAnl - analytick· Ëasù ˙Ëtu pre DPH
// IcmSnt - syntetick· Ëasù ˙Ëtu pre trûby za materi·l (642)
// IcmAnl - analytick· Ëasù ˙Ëtu pre trûby za materi·l
// IcgSnt - syntetick· Ëasù ˙Ëtu pre trûby za tovar (604)
// IcgAnl - analytick· Ëasù ˙Ëtu pre trûby za tovar
// IcsSnt - syntetick· Ëasù ˙Ëtu pre trûby za sluûiebu (602)
// IcsAnl - analytick· Ëasù ˙Ëtu pre trûby za sluûiebu
// -----------------------------------------------------------------------------
//            PREDVOLEN… NASTAVENIA PRE ⁄»TOVANIE OSTATN›CH DOKLADOV
// -----------------------------------------------------------------------------
// RdcSnt - syntetick· Ëasù ˙Ëtu na za˙Ëtovanie rozdielu zo zaokr˙hlenie, ktor·
//          vznikne medzi s˙Ëtom poloûiek a hlaviËky dokladu alebo pri in˝ch
//          zaokr˙hleniach ak zaokr˙hlenie tovorÌ n·klad - strana MD
// RdcAnl - analytick· Ëasù ˙Ëtu na za˙Ëtovanie rozdielu zo zaokr˙hlenie
//          ak zaokr˙hlenie tovorÌ n·klad - strana MD
// RddSnt - syntetick· Ëasù ˙Ëtu na za˙Ëtovanie rozdielu zo zaokr˙hlenie, ktor·
//          vznikne medzi s˙Ëtom poloûiek a hlaviËky dokladu alebo pri in˝ch
//          zaokr˙hleniach ak zaokr˙hlenie tovorÌ v˝nos - strana DAL
// RddAnl - analytick· Ëasù ˙Ëtu na za˙Ëtovanie rozdielu zo zaokr˙hlenie
//          ak zaokr˙hlenie tovorÌ v˝nos - strana DAL
// -----------------------------------------------------------------------------
// ********************************* POZN¡MKY **********************************
// -----------------------------------------------------------------------------
//
// -----------------------------------------------------------------------------
// ****************************** HIST”RIA ZMIEN *******************************
// -----------------------------------------------------------------------------
// 20.06[20.02.18] - vytvorenie unitu
// 21.05[28.03.19] - pridanÈ parametre pre ˙Ëtovanie fakt˙r, pre ˙Ëtovanie
//                   ostatn˝ch dokumetov, a premenovanie parametrov 9 znakov˝ch
//                   n·zvov na 6.
// =============================================================================

interface

uses
  IcTypes, IcConv, IcVariab, ePRPLST,
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Dialogs, DB, NexBtrTable, DBTables, NexPxTable;

type
  TPrpAcc=class
    constructor Create(phPRPLST:TPrplstHne);
  private
    ohPRPLST:TPrplstHne;
    function GetDefVat:byte;    procedure SetDefVat(pValue:byte);
    function GetVatLst:Str250;  procedure SetVatLst(pValue:Str250);
    function GetAnlChr:byte;    procedure SetAnlChr(pValue:byte);
    // -------------------------------------------------------------------------
    function GetPdcSnt:Str3;      procedure SetPdcSnt(pValue:Str3);
    function GetPdcAnl:Str6;      procedure SetPdcAnl(pValue:Str6);
    function GetPddSnt:Str3;      procedure SetPddSnt(pValue:Str3);
    function GetPddAnl:Str6;      procedure SetPddAnl(pValue:Str6);
    function GetCdcSnt:Str3;      procedure SetCdcSnt(pValue:Str3);
    function GetCdcAnl:Str6;      procedure SetCdcAnl(pValue:Str6);
    function GetCddSnt:Str3;      procedure SetCddSnt(pValue:Str3);
    function GetCddAnl:Str6;      procedure SetCddAnl(pValue:Str6);
    // -------------------------------------------------------------------------
    function GetActTsa:boolean; procedure SetActTsa(pValue:boolean);
    function GetAceSnt(pVatPrc:byte):Str3;  procedure SetAceSnt(pVatPrc:byte;pValue:Str3);
    function GetAceAnl(pVatPrc:byte):Str6;  procedure SetAceAnl(pVatPrc:byte;pValue:Str6);
    function GetAcoSnt(pVatPrc:byte):Str3;  procedure SetAcoSnt(pVatPrc:byte;pValue:Str3);
    function GetAcoAnl(pVatPrc:byte):Str6;  procedure SetAcoAnl(pVatPrc:byte;pValue:Str6);
    function GetFgeSnt(pVatPrc:byte):Str3;  procedure SetFgeSnt(pVatPrc:byte;pValue:Str3);
    function GetFgeAnl(pVatPrc:byte):Str6;  procedure SetFgeAnl(pVatPrc:byte;pValue:Str6);
    function GetFgoSnt(pVatPrc:byte):Str3;  procedure SetFgoSnt(pVatPrc:byte;pValue:Str3);
    function GetFgoAnl(pVatPrc:byte):Str6;  procedure SetFgoAnl(pVatPrc:byte;pValue:Str6);
    // -------------------------------------------------------------------------
    function GetIsdSnt:Str3;  procedure SetIsdSnt(pValue:Str3);
    function GetIsdAnl:Str6;  procedure SetIsdAnl(pValue:Str6);
    function GetIsvSnt:Str3;  procedure SetIsvSnt(pValue:Str3);
    function GetIsvAnl:Str6;  procedure SetIsvAnl(pValue:Str6);
    function GetIsmSnt:Str3;  procedure SetIsmSnt(pValue:Str3);
    function GetIsmAnl:Str6;  procedure SetIsmAnl(pValue:Str6);
    function GetIsgSnt:Str3;  procedure SetIsgSnt(pValue:Str3);
    function GetIsgAnl:Str6;  procedure SetIsgAnl(pValue:Str6);
    function GetIssSnt:Str3;  procedure SetIssSnt(pValue:Str3);
    function GetIssAnl:Str6;  procedure SetIssAnl(pValue:Str6);

    function GetIcdSnt:Str3;  procedure SetIcdSnt(pValue:Str3);
    function GetIcdAnl:Str6;  procedure SetIcdAnl(pValue:Str6);
    function GetIcvSnt:Str3;  procedure SetIcvSnt(pValue:Str3);
    function GetIcvAnl:Str6;  procedure SetIcvAnl(pValue:Str6);
    function GetIcmSnt:Str3;  procedure SetIcmSnt(pValue:Str3);
    function GetIcmAnl:Str6;  procedure SetIcmAnl(pValue:Str6);
    function GetIcgSnt:Str3;  procedure SetIcgSnt(pValue:Str3);
    function GetIcgAnl:Str6;  procedure SetIcgAnl(pValue:Str6);
    function GetIcsSnt:Str3;  procedure SetIcsSnt(pValue:Str3);
    function GetIcsAnl:Str6;  procedure SetIcsAnl(pValue:Str6);
    // -------------------------------------------------------------------------
    function GetRdcSnt:Str3;      procedure SetRdcSnt(pValue:Str3);
    function GetRdcAnl:Str6;      procedure SetRdcAnl(pValue:Str6);
    function GetRddSnt:Str3;      procedure SetRddSnt(pValue:Str3);
    function GetRddAnl:Str6;      procedure SetRddAnl(pValue:Str6);
  public
    // -------------------------- Z¡KLADN… ⁄DAJE  ------------------------------
    property DefVat:byte read GetDefVat write SetDefVat;
    property VatLst:Str250 read GetVatLst write SetVatLst;
    property AnlChr:byte read GetAnlChr write SetAnlChr;
    // -------------------------------------------------------------------------
    property PdcSnt:Str3 read GetPdcSnt write SetPdcSnt;
    property PdcAnl:Str6 read GetPdcAnl write SetPdcAnl;
    property PddSnt:Str3 read GetPddSnt write SetPddSnt;
    property PddAnl:Str6 read GetPddAnl write SetPddAnl;
    property CdcSnt:Str3 read GetCdcSnt write SetCdcSnt;
    property CdcAnl:Str6 read GetCdcAnl write SetCdcAnl;
    property CddSnt:Str3 read GetCddSnt write SetCddSnt;
    property CddAnl:Str6 read GetCddAnl write SetCddAnl;
    // ------------------- NASTAVENIA PRE SAMOZDANENIE  ------------------------
    property ActTsa:boolean read GetActTsa write SetActTsa;
    property AceSnt[pVatPrc:byte]:Str3 read GetAceSnt write SetAceSnt;
    property AceAnl[pVatPrc:byte]:Str6 read GetAceAnl write SetAceAnl;
    property AcoSnt[pVatPrc:byte]:Str3 read GetAcoSnt write SetAcoSnt;
    property AcoAnl[pVatPrc:byte]:Str6 read GetAcoAnl write SetAcoAnl;
    property FgeSnt[pVatPrc:byte]:Str3 read GetFgeSnt write SetFgeSnt;
    property FgeAnl[pVatPrc:byte]:Str6 read GetFgeAnl write SetFgeAnl;
    property FgoSnt[pVatPrc:byte]:Str3 read GetFgoSnt write SetFgoSnt;
    property FgoAnl[pVatPrc:byte]:Str6 read GetFgoAnl write SetFgoAnl;
    // -------------------------------------------------------------------------
    property IsdSnt:Str3 read GetIsdSnt write SetIsdSnt;
    property IsdAnl:Str6 read GetIsdAnl write SetIsdAnl;
    property IsvSnt:Str3 read GetIsvSnt write SetIsvSnt;
    property IsvAnl:Str6 read GetIsvAnl write SetIsvAnl;
    property IsmSnt:Str3 read GetIsmSnt write SetIsmSnt;
    property IsmAnl:Str6 read GetIsmAnl write SetIsmAnl;
    property IsgSnt:Str3 read GetIsgSnt write SetIsgSnt;
    property IsgAnl:Str6 read GetIsgAnl write SetIsgAnl;
    property IssSnt:Str3 read GetIssSnt write SetIssSnt;
    property IssAnl:Str6 read GetIssAnl write SetIssAnl;

    property IcdSnt:Str3 read GetIcdSnt write SetIcdSnt;
    property IcdAnl:Str6 read GetIcdAnl write SetIcdAnl;
    property IcvSnt:Str3 read GetIcvSnt write SetIcvSnt;
    property IcvAnl:Str6 read GetIcvAnl write SetIcvAnl;
    property IcmSnt:Str3 read GetIcmSnt write SetIcmSnt;
    property IcmAnl:Str6 read GetIcmAnl write SetIcmAnl;
    property IcgSnt:Str3 read GetIcgSnt write SetIcgSnt;
    property IcgAnl:Str6 read GetIcgAnl write SetIcgAnl;
    property IcsSnt:Str3 read GetIcsSnt write SetIcsSnt;
    property IcsAnl:Str6 read GetIcsAnl write SetIcsAnl;
    // -------------------------------------------------------------------------
    property RdcSnt:Str3 read GetRdcSnt write SetRdcSnt;
    property RdcAnl:Str6 read GetRdcAnl write SetRdcAnl;
    property RddSnt:Str3 read GetRddSnt write SetRddSnt;
    property RddAnl:Str6 read GetRddAnl write SetRddAnl;
  end;

implementation

constructor TPrpAcc.Create(phPRPLST:TPrplstHne);
begin
  ohPRPLST:=phPRPLST;
end;

// ******************************** PRIVATE ************************************

function TPrpAcc.GetAnlChr:byte;
begin
  Result:=ohPRPLST.ReadInteger('ACC','','AnlChr','',6);
end;

procedure TPrpAcc.SetAnlChr(pValue:byte);
begin
  ohPRPLST.WriteInteger('ACC','','AnlChr','',pValue);
end;

function TPrpAcc.GetActTsa:boolean;
begin
  Result:=ohPRPLST.ReadBoolean('ACC','','ActTsa','',FALSE);
end;

procedure TPrpAcc.SetActTsa(pValue:boolean);
begin
  ohPRPLST.WriteBoolean('ACC','','ActTsa','',pValue);
end;

function TPrpAcc.GetDefVat:byte;
begin
  Result:=ohPRPLST.ReadInteger('ACC','','DefVat','',23);
end;

procedure TPrpAcc.SetDefVat(pValue:byte);
begin
  ohPRPLST.WriteInteger('ACC','','DefVat','',pValue);
end;

function TPrpAcc.GetVatLst:Str250;
begin
  Result:=ohPRPLST.ReadString('ACC','','VatLst','','0,,5,19,23');
end;

procedure TPrpAcc.SetVatLst(pValue:Str250);
begin
  ohPRPLST.WriteString('ACC','','VatLst','',pValue);
end;

function TPrpAcc.GetAceSnt(pVatPrc:byte):Str3;
begin
  Result:=ohPRPLST.ReadString('ACC','','AceSnt',StrIntZero(pVatPrc,2),'343');
end;

procedure TPrpAcc.SetAceSnt(pVatPrc:byte;pValue:Str3);
begin
  ohPRPLST.WriteString('ACC','','AceSnt',StrIntZero(pVatPrc,2),pValue);
end;

function TPrpAcc.GetAceAnl(pVatPrc:byte):Str6;
begin
  Result:=ohPRPLST.ReadString('ACC','','AceAnl',StrIntZero(pVatPrc,2),StrIntZero(pVatPrc,AnlChr));
end;

procedure TPrpAcc.SetAceAnl(pVatPrc:byte;pValue:Str6);
begin
  ohPRPLST.WriteString('ACC','','AceAnl',StrIntZero(pVatPrc,2),pValue);
end;

function TPrpAcc.GetAcoSnt(pVatPrc:byte):Str3;
begin
  Result:=ohPRPLST.ReadString('ACC','','AcoSnt',StrIntZero(pVatPrc,2),'343');
end;

procedure TPrpAcc.SetAcoSnt(pVatPrc:byte;pValue:Str3);
begin
  ohPRPLST.WriteString('ACC','','AcoSnt',StrIntZero(pVatPrc,2),pValue);
end;

function TPrpAcc.GetAcoAnl(pVatPrc:byte):Str6;
begin
  Result:=ohPRPLST.ReadString('ACC','','AcoAnl',StrIntZero(pVatPrc,2),StrIntZero(100+pVatPrc,AnlChr));
end;

procedure TPrpAcc.SetAcoAnl(pVatPrc:byte;pValue:Str6);
begin
  ohPRPLST.WriteString('ACC','','AcoAnl',StrIntZero(pVatPrc,2),pValue);
end;

function TPrpAcc.GetFgeSnt(pVatPrc:byte):Str3;
begin
  Result:=ohPRPLST.ReadString('ACC','','FgeSnt',StrIntZero(pVatPrc,2),'343');
end;

procedure TPrpAcc.SetFgeSnt(pVatPrc:byte;pValue:Str3);
begin
  ohPRPLST.WriteString('ACC','','FgeSnt',StrIntZero(pVatPrc,2),pValue);
end;

function TPrpAcc.GetFgeAnl(pVatPrc:byte):Str6;
begin
  Result:=ohPRPLST.ReadString('ACC','','FgeAnl',StrIntZero(pVatPrc,2),StrIntZero(pVatPrc,AnlChr));
end;

procedure TPrpAcc.SetFgeAnl(pVatPrc:byte;pValue:Str6);
begin
  ohPRPLST.WriteString('ACC','','FgeAnl',StrIntZero(pVatPrc,2),pValue);
end;

function TPrpAcc.GetFgoSnt(pVatPrc:byte):Str3;
begin
  Result:=ohPRPLST.ReadString('ACC','','FgoSnt',StrIntZero(pVatPrc,2),'343');
end;

procedure TPrpAcc.SetFgoSnt(pVatPrc:byte;pValue:Str3);
begin
  ohPRPLST.WriteString('ACC','','FgoSnt',StrIntZero(pVatPrc,2),pValue);
end;

function TPrpAcc.GetFgoAnl(pVatPrc:byte):Str6;
begin
  Result:=ohPRPLST.ReadString('ACC','','FgoAnl',StrIntZero(pVatPrc,2),StrIntZero(100+pVatPrc,AnlChr));
end;

procedure TPrpAcc.SetFgoAnl(pVatPrc:byte;pValue:Str6);
begin
  ohPRPLST.WriteString('ACC','','FgoAnl',StrIntZero(pVatPrc,2),pValue);
end;

function TPrpAcc.GetRdcSnt:Str3;
begin
  Result:=ohPRPLST.ReadString('ACC','','RdcSnt','');
end;

procedure TPrpAcc.SetRdcSnt(pValue:Str3);
begin
  ohPRPLST.WriteString('ACC','','RdcSnt',pValue);
end;

function TPrpAcc.GetRdcAnl:Str6;
begin
  Result:=ohPRPLST.ReadString('ACC','','RdcAnl','');
end;

procedure TPrpAcc.SetRdcAnl(pValue:Str6);
begin
  ohPRPLST.WriteString('ACC','','RdcAnl',pValue);
end;

function TPrpAcc.GetRddSnt:Str3;
begin
  Result:=ohPRPLST.ReadString('ACC','','RddSnt','');
end;

procedure TPrpAcc.SetRddSnt(pValue:Str3);
begin
  ohPRPLST.WriteString('ACC','','RddSnt',pValue);
end;

function TPrpAcc.GetRddAnl:Str6;
begin
  Result:=ohPRPLST.ReadString('ACC','','RddAnl','');
end;

procedure TPrpAcc.SetRddAnl(pValue:Str6);
begin
  ohPRPLST.WriteString('ACC','','RddAnl',pValue);
end;

function TPrpAcc.GetPdcSnt:Str3;
begin
  Result:=ohPRPLST.ReadString('ACC','','PdcSnt','');
end;

procedure TPrpAcc.SetPdcSnt(pValue:Str3);
begin
  ohPRPLST.WriteString('ACC','','PdcSnt',pValue);
end;

function TPrpAcc.GetPdcAnl:Str6;
begin
  Result:=ohPRPLST.ReadString('ACC','','PdcAnl','');
end;

procedure TPrpAcc.SetPdcAnl(pValue:Str6);
begin
  ohPRPLST.WriteString('ACC','','PdcAnl',pValue);
end;

function TPrpAcc.GetPddSnt:Str3;
begin
  Result:=ohPRPLST.ReadString('ACC','','PddSnt','');
end;

procedure TPrpAcc.SetPddSnt(pValue:Str3);
begin
  ohPRPLST.WriteString('ACC','','PddSnt',pValue);
end;

function TPrpAcc.GetPddAnl:Str6;
begin
  Result:=ohPRPLST.ReadString('ACC','','PddAnl','');
end;

procedure TPrpAcc.SetPddAnl(pValue:Str6);
begin
  ohPRPLST.WriteString('ACC','','PddAnl',pValue);
end;

function TPrpAcc.GetCdcSnt:Str3;
begin
  Result:=ohPRPLST.ReadString('ACC','','CdcSnt','');
end;

procedure TPrpAcc.SetCdcSnt(pValue:Str3);
begin
  ohPRPLST.WriteString('ACC','','CdcSnt',pValue);
end;

function TPrpAcc.GetCdcAnl:Str6;
begin
  Result:=ohPRPLST.ReadString('ACC','','CdcAnl','');
end;

procedure TPrpAcc.SetCdcAnl(pValue:Str6);
begin
  ohPRPLST.WriteString('ACC','','CdcAnl',pValue);
end;

function TPrpAcc.GetCddSnt:Str3;
begin
  Result:=ohPRPLST.ReadString('ACC','','CddSnt','');
end;

procedure TPrpAcc.SetCddSnt(pValue:Str3);
begin
  ohPRPLST.WriteString('ACC','','CddSnt',pValue);
end;

function TPrpAcc.GetCddAnl:Str6;
begin
  Result:=ohPRPLST.ReadString('ACC','','CddAnl','');
end;

procedure TPrpAcc.SetCddAnl(pValue:Str6);
begin
  ohPRPLST.WriteString('ACC','','CddAnl',pValue);
end;

function TPrpAcc.GetIsdSnt:Str3;
begin
  Result:=ohPRPLST.ReadString('ACC','','IsdSnt','');
end;

procedure TPrpAcc.SetIsdSnt(pValue:Str3);
begin
  ohPRPLST.WriteString('ACC','','IsdSnt',pValue);
end;

function TPrpAcc.GetIsdAnl:Str6;
begin
  Result:=ohPRPLST.ReadString('ACC','','IsdAnl','');
end;

procedure TPrpAcc.SetIsdAnl(pValue:Str6);
begin
  ohPRPLST.WriteString('ACC','','IsdAnl',pValue);
end;

function TPrpAcc.GetIsvSnt:Str3;
begin
  Result:=ohPRPLST.ReadString('ACC','','IsvSnt','');
end;

procedure TPrpAcc.SetIsvSnt(pValue:Str3);
begin
  ohPRPLST.WriteString('ACC','','IsvSnt',pValue);
end;

function TPrpAcc.GetIsvAnl:Str6;
begin
  Result:=ohPRPLST.ReadString('ACC','','IsvAnl','');
end;

procedure TPrpAcc.SetIsvAnl(pValue:Str6);
begin
  ohPRPLST.WriteString('ACC','','IsvAnl',pValue);
end;

function TPrpAcc.GetIsmSnt:Str3;
begin
  Result:=ohPRPLST.ReadString('ACC','','IsmSnt','');
end;

procedure TPrpAcc.SetIsmSnt(pValue:Str3);
begin
  ohPRPLST.WriteString('ACC','','IsmSnt',pValue);
end;

function TPrpAcc.GetIsmAnl:Str6;
begin
  Result:=ohPRPLST.ReadString('ACC','','IsmAnl','');
end;

procedure TPrpAcc.SetIsmAnl(pValue:Str6);
begin
  ohPRPLST.WriteString('ACC','','IsmAnl',pValue);
end;

function TPrpAcc.GetIsgSnt:Str3;
begin
  Result:=ohPRPLST.ReadString('ACC','','IsgSnt','');
end;

procedure TPrpAcc.SetIsgSnt(pValue:Str3);
begin
  ohPRPLST.WriteString('ACC','','IsgSnt',pValue);
end;

function TPrpAcc.GetIsgAnl:Str6;
begin
  Result:=ohPRPLST.ReadString('ACC','','IsgAnl','');
end;

procedure TPrpAcc.SetIsgAnl(pValue:Str6);
begin
  ohPRPLST.WriteString('ACC','','IsgAnl',pValue);
end;

function TPrpAcc.GetIssSnt:Str3;
begin
  Result:=ohPRPLST.ReadString('ACC','','IssSnt','');
end;

procedure TPrpAcc.SetIssSnt(pValue:Str3);
begin
  ohPRPLST.WriteString('ACC','','IssSnt',pValue);
end;

function TPrpAcc.GetIssAnl:Str6;
begin
  Result:=ohPRPLST.ReadString('ACC','','IssAnl','');
end;

procedure TPrpAcc.SetIssAnl(pValue:Str6);
begin
  ohPRPLST.WriteString('ACC','','IssAnl',pValue);
end;

function TPrpAcc.GetIcdSnt:Str3;
begin
  Result:=ohPRPLST.ReadString('ACC','','IcdSnt','');
end;

procedure TPrpAcc.SetIcdSnt(pValue:Str3);
begin
  ohPRPLST.WriteString('ACC','','IcdSnt',pValue);
end;

function TPrpAcc.GetIcdAnl:Str6;
begin
  Result:=ohPRPLST.ReadString('ACC','','IcdAnl','');
end;

procedure TPrpAcc.SetIcdAnl(pValue:Str6);
begin
  ohPRPLST.WriteString('ACC','','IcdAnl',pValue);
end;

function TPrpAcc.GetIcvSnt:Str3;
begin
  Result:=ohPRPLST.ReadString('ACC','','IcvSnt','');
end;

procedure TPrpAcc.SetIcvSnt(pValue:Str3);
begin
  ohPRPLST.WriteString('ACC','','IcvSnt',pValue);
end;

function TPrpAcc.GetIcvAnl:Str6;
begin
  Result:=ohPRPLST.ReadString('ACC','','IcvAnl','');
end;

procedure TPrpAcc.SetIcvAnl(pValue:Str6);
begin
  ohPRPLST.WriteString('ACC','','IcvAnl',pValue);
end;

function TPrpAcc.GetIcmSnt:Str3;
begin
  Result:=ohPRPLST.ReadString('ACC','','IcmSnt','');
end;

procedure TPrpAcc.SetIcmSnt(pValue:Str3);
begin
  ohPRPLST.WriteString('ACC','','IcmSnt',pValue);
end;

function TPrpAcc.GetIcmAnl:Str6;
begin
  Result:=ohPRPLST.ReadString('ACC','','IcmAnl','');
end;

procedure TPrpAcc.SetIcmAnl(pValue:Str6);
begin
  ohPRPLST.WriteString('ACC','','IcmAnl',pValue);
end;

function TPrpAcc.GetIcgSnt:Str3;
begin
  Result:=ohPRPLST.ReadString('ACC','','IcgSnt','');
end;

procedure TPrpAcc.SetIcgSnt(pValue:Str3);
begin
  ohPRPLST.WriteString('ACC','','IcgSnt',pValue);
end;

function TPrpAcc.GetIcgAnl:Str6;
begin
  Result:=ohPRPLST.ReadString('ACC','','IcgAnl','');
end;

procedure TPrpAcc.SetIcgAnl(pValue:Str6);
begin
  ohPRPLST.WriteString('ACC','','IcgAnl',pValue);
end;

function TPrpAcc.GetIcsSnt:Str3;
begin
  Result:=ohPRPLST.ReadString('ACC','','IcsSnt','');
end;

procedure TPrpAcc.SetIcsSnt(pValue:Str3);
begin
  ohPRPLST.WriteString('ACC','','IcsSnt',pValue);
end;

function TPrpAcc.GetIcsAnl:Str6;
begin
  Result:=ohPRPLST.ReadString('ACC','','IcsAnl','');
end;

procedure TPrpAcc.SetIcsAnl(pValue:Str6);
begin
  ohPRPLST.WriteString('ACC','','IcsAnl',pValue);
end;

// ********************************* PUBLIC ************************************

end.


