unit Sdi;
{$F+}

// *****************************************************************************
//                           SPECIFIC DATA INTERFACE
// *****************************************************************************

interface

uses
  IcTypes, IcConst, IcConv, IcTools, IcVariab, DocHand, NumText,
  NexGlob, NexPath, NexIni, NexMsg, NexError,
  SavClc, LinLst, ItgLog, Bok, Rep, Key, Afc, Doc, Dac, Plc, Csd,
  hSYSTEM, hPAB, hSABLST, hSAH, hSAI, tSAI, tSAH,
  LangForm, BtrHand, ComCtrls, SysUtils, Classes, Forms;

type
  TSad = class(TComponent)
    constructor Create(AOwner: TComponent);
    destructor  Destroy; override;
    private
    public
    published
  end;

implementation

constructor TSdi.Create(AOwner: TComponent);
begin
end;

destructor TSdi.Destroy;
begin
end;

// ********************************* PRIVATE ***********************************

DocLocate
DocCalc
DocPrint
DocFilt
DocSave

// ********************************** PUBLIC ***********************************

end.

