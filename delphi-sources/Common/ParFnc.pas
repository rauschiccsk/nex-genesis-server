unit ParFnc;
// =============================================================================
//                             EVIDENCIA PARTNEROV
// =============================================================================
// -----------------------------------------------------------------------------
// ********************************* POZNÁMKY **********************************
// -----------------------------------------------------------------------------
//
// -----------------------------------------------------------------------------
// ********************* PARAMETRE KTORÝCH POUŽÍVA FUNKCIA *********************
// -----------------------------------------------------------------------------
//
// -----------------------------------------------------------------------------
// ***************************** POUŽITÉ DATABÁZE ******************************
// -----------------------------------------------------------------------------
// PARLST - Zoznam obchodných partnerov
// PARBAC - Zoznam bankových úètov
// CNTLST - Zoznam kontaktných osob
// -----------------------------------------------------------------------------
// ****************************** HISTÓRIA ZMIEN *******************************
// -----------------------------------------------------------------------------
// 21.01[29.05.18] - Nová funkcia (RZ)

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
    ohPARLST:TParlstHne;  // Zoznam obchodných partnerov
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


