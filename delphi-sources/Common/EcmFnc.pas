unit EcmFnc;
// =============================================================================
//                   FUNKCIE PRE ECS (Electronic Cassa Server)
// -----------------------------------------------------------------------------
// -----------------------------------------------------------------------------
// ************************* POUŽITÉ DATABÁZOVÉ SÚBORY *************************
// -----------------------------------------------------------------------------
// ECMDOC.BTR - zoznam dokladov pre ECS
// -----------------------------------------------------------------------------
// *********************** POPIS PRIVATE FUNKCIÍ OBJEKTU ***********************
// -----------------------------------------------------------------------------
// -----------------------------------------------------------------------------
// ************************ POPIS PUBLIC FUNKCIÍ OBJEKTU ***********************
// -----------------------------------------------------------------------------
// IcdPayDoc - úhrada odberate¾skej faktúry cez pokladnièný server ECS
//             › pDocNum - interné èíslo odberate¾skej faktúry
//             › pCasNum - èíslo pokladne, cez ktorú bude faktúra vyúètovaná
// -----------------------------------------------------------------------------
// ********************************* POZNÁMKY **********************************
// -----------------------------------------------------------------------------
//
// -----------------------------------------------------------------------------
// ****************************** HISTÓRIA ZMIEN *******************************
// -----------------------------------------------------------------------------
// 21.08[28.02.2019] - Nová funkcia (RZ)
// =============================================================================

interface

uses
  IcTypes, IcConv, IcVariab, IcTools, IcDate, BasFnc, EcdHnd, eECMDOC,
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Dialogs, Forms, DateUtils;

type
  TEcmFnc=class
    constructor Create;
    destructor Destroy; override;
  private
    function GetDocSer:longint;
  public
    ohECMDOC:TEcmdocHne;
    procedure CrtNewDoc(pCasNum:word);  // Vytvorí zápis pre ECS
  published
    property DocSer:longint read GetDocSer;
  end;

implementation


// ********************************** OBJECT ***********************************

constructor TEcmFnc.Create;
begin
  ohECMDOC:=TEcmdocHne.Create;
end;

destructor TEcmFnc.Destroy;
begin
  FreeAndNil(ohECMDOC);
end;

// ******************************** PRIVATE ************************************

function TEcmFnc.GetDocSer:longint;
begin
  Result:=ohECMDOC.DocSer;
end;

// ******************************** PUBLIC *************************************

procedure TEcmFnc.CrtNewDoc(pCasNum:word);
var mDocSer:longint;
begin
  // Vygenerujeme nové poradové èíslo dokladu
  ohECMDOC.SwapIndex;
  ohECMDOC.SetIndex('DyDs');
  ohECMDOC.Last;
  mDocSer:=ohECMDOC.DocSer+1;
  ohECMDOC.RestIndex;
  // Vytvoríme nový doklad
  ohECMDOC.Insert;
  ohECMDOC.DocYer:=gvSys.ActYear2;
  ohECMDOC.DocSer:=mDocSer;
  ohECMDOC.DocSta:=0;
  ohECMDOC.DocStd:=ceCasDocStd0; // Vytvorenie tlaèovej úlohy'
  ohECMDOC.CasNum:=pCasNum;
  ohECMDOC.CrtUsr:=gvSys.LoginName;
  ohECMDOC.CrtUsn:=gvSys.UserName;
  ohECMDOC.CrtDte:=Date;
  ohECMDOC.CrtTim:=Time;
  ohECMDOC.Post;
end;

end.


