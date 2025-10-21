unit hDSPLST;

interface

uses
  IcTypes, NexPath, NexGlob, bDSPLST,
  Forms, Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Dialogs;

type
  TDsplstHnd = class (TDsplstBtr)
  private
  public
    function NextSerNum:longint; // Najde nasledujuce volne poradoe cislo
    function FindFreDst(pPaCode:longint):boolean; // Èislo pouzitelne vynimky pre zadaneho zakaznika
  published
  end;

implementation

function TDsplstHnd.NextSerNum:longint; // Najde nasledujuce volne poradoe cislo
begin
  SwapStatus;
  SetIndex (ixSerNum);
  Last;
  Result := SerNum+1;
  RestoreStatus;
end;

function TDsplstHnd.FindFreDst(pPaCode:longint):boolean; // Èislo pouzitelne vynimky pre zadaneho zakaznika
var mFind:boolean;
begin
  mFind := FALSE;
  While LocatePaSt(pPaCode,'') and not mFind do begin
    mFind := Date<ExpDate;
    If not mFind then begin // Vyradime expirovanu vynimku
      Edit;
      Status := 'X';
      Post;
    end;
  end;
  Result := mFind;
end;

end.
