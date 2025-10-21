unit EcmFnc;
// =============================================================================
//                   FUNKCIE PRE ECS (Electronic Cassa Server)
// -----------------------------------------------------------------------------
// -----------------------------------------------------------------------------
// ************************* POU�IT� DATAB�ZOV� S�BORY *************************
// -----------------------------------------------------------------------------
// ECMDOC.BTR - zoznam dokladov pre ECS
// -----------------------------------------------------------------------------
// *********************** POPIS PRIVATE FUNKCI� OBJEKTU ***********************
// -----------------------------------------------------------------------------
// -----------------------------------------------------------------------------
// ************************ POPIS PUBLIC FUNKCI� OBJEKTU ***********************
// -----------------------------------------------------------------------------
// IcdPayDoc - �hrada odberate�skej fakt�ry cez pokladni�n� server ECS
//             � pDocNum - intern� ��slo odberate�skej fakt�ry
//             � pCasNum - ��slo pokladne, cez ktor� bude fakt�ra vy��tovan�
// -----------------------------------------------------------------------------
// ********************************* POZN�MKY **********************************
// -----------------------------------------------------------------------------
//
// -----------------------------------------------------------------------------
// ****************************** HIST�RIA ZMIEN *******************************
// -----------------------------------------------------------------------------
// 21.08[28.02.2019] - Nov� funkcia (RZ)
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
    procedure CrtNewDoc(pCasNum:word);  // Vytvor� z�pis pre ECS
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
  // Vygenerujeme nov� poradov� ��slo dokladu
  ohECMDOC.SwapIndex;
  ohECMDOC.SetIndex('DyDs');
  ohECMDOC.Last;
  mDocSer:=ohECMDOC.DocSer+1;
  ohECMDOC.RestIndex;
  // Vytvor�me nov� doklad
  ohECMDOC.Insert;
  ohECMDOC.DocYer:=gvSys.ActYear2;
  ohECMDOC.DocSer:=mDocSer;
  ohECMDOC.DocSta:=0;
  ohECMDOC.DocStd:=ceCasDocStd0; // Vytvorenie tla�ovej �lohy'
  ohECMDOC.CasNum:=pCasNum;
  ohECMDOC.CrtUsr:=gvSys.LoginName;
  ohECMDOC.CrtUsn:=gvSys.UserName;
  ohECMDOC.CrtDte:=Date;
  ohECMDOC.CrtTim:=Time;
  ohECMDOC.Post;
end;

end.


