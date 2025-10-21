unit ParFnc;
// =============================================================================
//                             EVIDENCIA PARTNEROV
// =============================================================================
// -----------------------------------------------------------------------------
// ********************************* POZN�MKY **********************************
// -----------------------------------------------------------------------------
//
// -----------------------------------------------------------------------------
// ********************* PARAMETRE KTOR�CH POU��VA FUNKCIA *********************
// -----------------------------------------------------------------------------
//
// -----------------------------------------------------------------------------
// ***************************** POU�IT� DATAB�ZE ******************************
// -----------------------------------------------------------------------------
// PARLST - Zoznam obchodn�ch partnerov
// PARBAC - Zoznam bankov�ch ��tov
// CNTLST - Zoznam kontaktn�ch osob
// -----------------------------------------------------------------------------
// ****************************** HIST�RIA ZMIEN *******************************
// -----------------------------------------------------------------------------
// 21.01[29.05.18] - Nov� funkcia (RZ)

interface
                                                                  
uses
  IcTypes, IcConv, IcVariab, IcTools, Nexpath, NexClc, NexGlob, ePARLST,
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Dialogs, Forms, DateUtils;

type
  TParFnc=class
    constructor Create;
    destructor Destroy; override;
  private                  
  public
    ohPARLST:TParlstHne;  // Zoznam obchodn�ch partnerov
  end;

implementation

constructor TParFnc.Create;
begin
  ohPARLST:=TParlstHne.Create;
end;

destructor TParFnc.Destroy;
begin
  FreeAndNil(ohPARLST);
end;

// ******************************** PRIVATE ************************************

// ********************************* PUBLIC ************************************

end.


