unit IcProgressBar;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  ComCtrls;

type
  TIcProgressBar = class(TProgressBar)
  private
    oSkip: integer; // Pocet volani, ktore bude prazdne, t.j. nebude volat StepBy
    oPosition: integer; // Interne pocidadlo, ktoru pocita pocet volani SkipStep
    function TrueOn (pPosition,pSkip:integer): boolean; // Hodnota funckie je TRUE ak pIndex je celym nasobkom pSkip
  public
    procedure SkipStep;  // Procedure sluzi na urychlenie indikatora v pripade velkeho poctu
  published
    property Skip: integer read oSkip write oSkip;
    property Color;
  end;

procedure Register;

implementation

function TIcProgressBar.TrueOn (pPosition,pSkip:integer): boolean;
begin
  Result := (pPosition mod pSkip) = 0;
end;

procedure TIcProgressBar.SkipStep;
begin
  If Position=0 then begin
    oPosition := 0;
    Position := Skip;
  end;  
  Inc (oPosition);
  If TrueOn (oPosition,Skip) then StepBy (Skip);
end;

procedure Register;
begin
  RegisterComponents('IcStandard', [TIcProgressBar]);
end;

end.
