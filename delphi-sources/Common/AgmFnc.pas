unit AgmFnc;
// =============================================================================
//                        ZMLUVN… PREDAJN… PORMIENKY
// =============================================================================
// ********************** POPIS JEDNOTLIV›CH FUNKCII ***************************
// -----------------------------------------------------------------------------
// GetAgcApc - hodnotou funkcie je zmluvn· cena bez DPH zadanÈho odberateæa.
// GetAgcBpc - hodnotou funkcie je zmluvn· cena s DPH zadanÈho odberateæa.
//             Popis parametrov:
//             -----------------
//             - pProNum - registraËnÈ ËÌslo produktu (PLU)
//             - pParNum - registraËn˝ kÛd odberateæa
//             - pAgcNum - ËÌslo zmluvy
//             - pDocDte - d·tum dokladu podæa ktorÈho bude urËen· platnosù
//                         zmluvnej ceny.
//
//             Ak je zadanÈ ËÌslo zmluvy potom systÈm hæad· cenu len v danej
//             odberateæskej zmluve. Ak do ËÌsla zmluvy je zadan· hviezdiËka "*"
//             potom systÈm hæad· najlepöiu platn˙ cenu zo vöetk˝ch zmluv·ch
//             danÈho odberateæa  avyberie najniûöiu zmluvn˙ cenu.
//
// -----------------------------------------------------------------------------
// ************************ POUéIT… DATAB¡ZOV… S⁄BORY **************************
// -----------------------------------------------------------------------------
// AGPLST.BTR - zoznam partnerov, ktorÈ maj˙ zmluvnÈ ceny
// AGCLST.BTR - zoznam odberateæsk˝ch zml˙v
// AGILST.BTR - zmluvne ceny odberateæov
// -----------------------------------------------------------------------------
// ********************* PARAMETRE, KTOR… POUéÕVA FUNKCIA **********************
// -----------------------------------------------------------------------------
//
// -----------------------------------------------------------------------------
// ********************************* POZN¡MKY **********************************
// -----------------------------------------------------------------------------
//
// -----------------------------------------------------------------------------
// ****************************** HIST”RIA ZMIEN *******************************
// -----------------------------------------------------------------------------
// 20.03[08.11.17] - Nov· funkcia (RZ)
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
  If pAgcNum='*' then begin // Hæad·me vo vöetk˝ch zmluv·ch danÈho odberateæa
    If ohAGILST.LocPaPr(pParNum,pProNum) then begin
      Repeat
        Result:=InDateInterval(ohAGILST.BegDte,ohAGILST.ExpDte,pDocDte);
        If not Result then ohAGILST.Next;
      until Result or ohAGILST.Eof or (ohAGILST.ParNum<>pParNum) or (ohAGILST.ProNum<>pProNum);
    end;
  end else begin // Hæad·me len v zadanej zmluve (alebo v poloûk·ch bez zmluvy)
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


