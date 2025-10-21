unit Prp;
{$F+}
// =============================================================================
//                          PARAMETRE INFORMAÈNÉHO SYSTÉ?U
//                               pre moduly od v20.01
// -----------------------------------------------------------------------------
// -----------------------------------------------------------------------------
// ************************* POUŽITÉ DATABÁZOVÉ SÚBORY *************************
// -----------------------------------------------------------------------------
//
// -----------------------------------------------------------------------------
// *********************** POPIS PRIVATE FUNKCIÍ OBJEKTU ***********************
// -----------------------------------------------------------------------------
// -----------------------------------------------------------------------------
// ************************ POPIS PUBLIC FUNKCIÍ OBJEKTU ***********************
// -----------------------------------------------------------------------------
// PrpRename - premenuje zadaný parameter v súbore PRPLST
//             › pPmdNam - názov programového modulu
//             › pOldNam - názov parametra, ktorý bude premenovaný
//             › pNewNam - názov parametra, na ktorý bude premenovaný
// -----------------------------------------------------------------------------
// ********************************* POZNÁMKY **********************************
// -----------------------------------------------------------------------------
//
// -----------------------------------------------------------------------------
// ****************************** HISTÓRIA ZMIEN *******************************
// -----------------------------------------------------------------------------
// 21.04[26.02.2019] - Nová funkcia (RZ)
// =============================================================================


interface

uses
  hPRPDEF,
  NemPrp,
  EmdPrp, StmPrp, UdmPrp, SrmPrp, OsmPrp, TsmPrp, OcmPrp, IcmPrp, ShmPrp, BwmPrp, BsmPrp,
  IcTypes, IcConv, IcTools, IcVariab, ePRPLST, SysUtils, Forms,
  PrpAcc;

type
  TPrp=class
    constructor Create;
    destructor Destroy; override;
    private
      ohPRPLST:TPrplstHne;
      ohPRPDEF:TPrpdefHnd;
      oAcc:TPrpAcc;
      oNem:TNemPrp;
      oEmd:TEmdPrp;
      oStm:TStmPrp;
      oUdm:TUdmPrp;
      oOsm:TOsmPrp;
      oTsm:TTsmPrp;
      oOcm:TOcmPrp;
      oIcm:TIcmPrp;
      oShm:TShmPrp;
      oBwm:TBwmPrp;
      oSrm:TSrmPrp;
      oBsm:TBsmPrp;
    public
      procedure PrpRename(pPmdNam:Str3;pOldNam,pNewNam:Str9);
    published
      property Acc:TPrpAcc read oAcc write oAcc;

      property Nem:TNemPrp read oNem write oNem;
      property Emd:TEmdPrp read oEmd write oEmd;
      property Stm:TStmPrp read oStm write oStm;
      property Osm:TOsmPrp read oOsm write oOsm;
      property Tsm:TTsmPrp read oTsm write oTsm;
      property Udm:TUdmPrp read oUdm write oUdm;
      property Ocm:TOcmPrp read oOcm write oOcm;
      property Icm:TIcmPrp read oIcm write oIcm;
      property Shm:TShmPrp read oShm write oShm;
      property Bwm:TBwmPrp read oBwm write oBwm;
      property Srm:TSrmPrp read oSrm write oSrm;
      property Bsm:TBsmPrp read oBsm write oBsm;
  end;

var gPrp:TPrp;

implementation

constructor TPrp.Create;
begin
  ohPRPDEF:=TPrpdefHnd.Create;
  oNem:=TNemPrp.Create(ohPRPDEF);
  oEmd:=TEmdPrp.Create(ohPRPDEF);
  oStm:=TStmPrp.Create(ohPRPDEF);
  oOsm:=TOsmPrp.Create(ohPRPDEF);
  oTsm:=TTsmPrp.Create(ohPRPDEF);
  oUdm:=TUdmPrp.Create(ohPRPDEF);
  oOcm:=TOcmPrp.Create(ohPRPDEF);
  oIcm:=TIcmPrp.Create(ohPRPDEF);
  oShm:=TShmPrp.Create(ohPRPDEF);
  oBwm:=TBwmPrp.Create(ohPRPDEF);

  ohPRPLST:=TPrplstHne.Create;
  oAcc:=TPrpAcc.Create(ohPRPLST);
  // Nové
  oSrm:=TSrmPrp.Create;
  oBsm:=TBsmPrp.Create;
end;

destructor TPrp.Destroy;
begin
  FreeAndNil(oAcc);
  FreeAndNil(ohPRPLST);

  FreeAndNil(oNem);
  FreeAndNil(oEmd);
  FreeAndNil(oStm);
  FreeAndNil(oUdm);
  FreeAndNil(oIcm);
  FreeAndNil(oOcm);
  FreeAndNil(oTsm);
  FreeAndNil(oOsm);
  FreeAndNil(oShm);
  FreeAndNil(oBwm);
  FreeAndNil(ohPRPDEF);

  FreeAndNil(oSrm);
  FreeAndNil(oBsm);
end;

// ********************************* PRIVATE ***********************************

// ********************************** PUBLIC ***********************************

procedure TPrp.PrpRename(pPmdNam:Str3;pOldNam,pNewNam:Str9);
begin
  If ohPRPLST.LocPmdNam(pPmdNam) then begin
    Repeat
      If UpString(ohPRPLST.PrpNam)=UpString(pOldnam) then begin
        ohPRPLST.Edit;
        ohPRPLST.PrpNam:=pNewNam;
        ohPRPLST.Post;
      end;
      Application.ProcessMessages;
      ohPRPLST.Next;
    until ohPRPLST.Eof or (ohPRPLST.PmdNam<>pPmdNam)
  end;
end;

end.
