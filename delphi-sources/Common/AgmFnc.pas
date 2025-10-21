unit AgmFnc;
// =============================================================================
//                        ZMLUVN� PREDAJN� PORMIENKY
// =============================================================================
// ********************** POPIS JEDNOTLIV�CH FUNKCII ***************************
// -----------------------------------------------------------------------------
// GetAgcApc - hodnotou funkcie je zmluvn� cena bez DPH zadan�ho odberate�a.
// GetAgcBpc - hodnotou funkcie je zmluvn� cena s DPH zadan�ho odberate�a.
//             Popis parametrov:
//             -----------------
//             - pProNum - registra�n� ��slo produktu (PLU)
//             - pParNum - registra�n� k�d odberate�a
//             - pAgcNum - ��slo zmluvy
//             - pDocDte - d�tum dokladu pod�a ktor�ho bude ur�en� platnos�
//                         zmluvnej ceny.
//
//             Ak je zadan� ��slo zmluvy potom syst�m h�ad� cenu len v danej
//             odberate�skej zmluve. Ak do ��sla zmluvy je zadan� hviezdi�ka "*"
//             potom syst�m h�ad� najlep�iu platn� cenu zo v�etk�ch zmluv�ch
//             dan�ho odberate�a  avyberie najni��iu zmluvn� cenu.
//
// -----------------------------------------------------------------------------
// ************************ POU�IT� DATAB�ZOV� S�BORY **************************
// -----------------------------------------------------------------------------
// AGPLST.BTR - zoznam partnerov, ktor� maj� zmluvn� ceny
// AGCLST.BTR - zoznam odberate�sk�ch zml�v
// AGILST.BTR - zmluvne ceny odberate�ov
// -----------------------------------------------------------------------------
// ********************* PARAMETRE, KTOR� POU��VA FUNKCIA **********************
// -----------------------------------------------------------------------------
//
// -----------------------------------------------------------------------------
// ********************************* POZN�MKY **********************************
// -----------------------------------------------------------------------------
//
// -----------------------------------------------------------------------------
// ****************************** HIST�RIA ZMIEN *******************************
// -----------------------------------------------------------------------------
// 20.03[08.11.17] - Nov� funkcia (RZ)
// =============================================================================

interface

uses
  IcTypes, IcConv, IcVariab, IcTools, Nexpath, NexClc, NexGlob, StkGlob, Prp, BasUtilsTCP, eAGPLST, eAGCLST, eAGILST,
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Dialogs, Forms, DateUtils;

type
  TAgmFnc=class
    constructor Create;
    destructor Destroy; override;
  private
    function Locate(pProNum,pParNum:longint;pAgcNum:Str30;pDocDte:TDateTime):boolean;
  public
    ohAGPLST:TAgplstHne;
    ohAGCLST:TAgclstHne;
    ohAGILST:TAgilstHne;
    function GetAgcApc(pProNum,pParNum:longint;pAgcNum:Str30;pDocDte:TDateTime):double;
    function GetAgcBpc(pProNum,pParNum:longint;pAgcNum:Str30;pDocDte:TDateTime):double;
  published
  end;

implementation

constructor TAgmFnc.Create;
begin
  ohAGPLST:=TAgplstHne.Create;
  ohAGCLST:=TAgclstHne.Create;
  ohAGILST:=TAgilstHne.Create;
end;

destructor TAgmFnc.Destroy;
begin
  FreeAndNil(ohAGILST);
  FreeAndNil(ohAGCLST);
  FreeAndNil(ohAGPLST);
end;

// ******************************** PRIVATE ************************************
function TAgmFnc.Locate(pProNum,pParNum:longint;pAgcNum:Str30;pDocDte:TDateTime):boolean;
begin
  Result:=FALSE;
  If pAgcNum='*' then begin // H�ad�me vo v�etk�ch zmluv�ch dan�ho odberate�a
    If ohAGILST.LocPaPr(pParNum,pProNum) then begin
      Repeat
        Result:=InDateInterval(ohAGILST.BegDte,ohAGILST.ExpDte,pDocDte);
        If not Result then ohAGILST.Next;
      until Result or ohAGILST.Eof or (ohAGILST.ParNum<>pParNum) or (ohAGILST.ProNum<>pProNum);
    end;
  end else begin // H�ad�me len v zadanej zmluve (alebo v polo�k�ch bez zmluvy)
    If ohAGILST.LocPaAcPr(pParNum,pAgcNum,pProNum) then begin
      Repeat
        Result:=InDateInterval(ohAGILST.BegDte,ohAGILST.ExpDte,pDocDte);
        If not Result then ohAGILST.Next;
      until Result or ohAGILST.Eof or (ohAGILST.ParNum<>pParNum) or (ohAGILST.AgcNum<>pAgcNum) or (ohAGILST.ProNum<>pProNum);
    end;
  end;
end;

// ********************************* PUBLIC ************************************

function TAgmFnc.GetAgcApc(pProNum,pParNum:longint;pAgcNum:Str30;pDocDte:TDateTime):double;
begin
  Result:=0;
  If Locate(pProNum,pParNum,pAgcNum,pDocDte) then Result:=ohAGILST.AgcApc;
end;

function TAgmFnc.GetAgcBpc(pProNum,pParNum:longint;pAgcNum:Str30;pDocDte:TDateTime):double;
begin
  Result:=0;
  If Locate(pProNum,pParNum,pAgcNum,pDocDte) then Result:=ohAGILST.AgcBpc;
end;

end.


