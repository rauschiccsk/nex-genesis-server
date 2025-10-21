unit Apc;
{$F+}

// *****************************************************************************
//                      OBJEKT NA PRACU S AKCIOVYMI CENAMI
// *****************************************************************************
// Tento objekt obsahuje funkcie potrebné na rôzne výpoèty predajných cien
//
// Programové funkcia:
// ---------------
// *****************************************************************************


interface

uses
  IcTypes, IcConst, IcConv, IcTools, DocHand, NexGlob, NexPath, NexIni, Key,
  hAPLITM,
  SysUtils, Classes, Forms;

type
  TApc = class(TComponent)
    constructor Create;
    destructor  Destroy; override;
    private
      ohAPLITM:TAplitmHnd;
    public
      function LocLowApc(pGsCode:longint;pDate:TDateTime):boolean;
      {PROPERTY}
      property phAPLITM:TAplitmHnd read ohAPLITM write ohAPLITM;
  end;

implementation

constructor TApc.Create;
begin
  ohAPLITM := TAplitmHnd.Create;   ohAPLITM.Open;
end;

destructor TApc.Destroy;
begin
  FreeAndNil(ohAPLITM);
end;

// ********************************* PRIVATE ***********************************

// ********************************** PUBLIC ***********************************

function TApc.LocLowApc(pGsCode:longint;pDate:TDateTime):boolean;
begin
  Result := FALSE;
  If ohAPLITM.LocateGsCode(pGsCode) then begin
    Repeat
      Result := InDateInterval(ohAPLITM.BegDate,ohAPLITM.EndDate,pDate);
      ohAPLITM.Next;
    until Result or ohAPLITM.Eof or (ohAPLITM.GsCode<>pGsCode);
  end;
end;

end.
