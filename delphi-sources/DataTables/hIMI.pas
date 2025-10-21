unit hIMI;

interface

uses
  IcTypes, IcTools, NexPath, NexGlob, bIMI,
  Forms, Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Dialogs;

type
  TImiHnd = class (TImiBtr)
  private
  public
    function FreeItmNum(pDocNum:Str12):word;
    function NextItmNum(pDocNum:Str12):word;
    procedure SetCPrice (pCPrice:double); // Zadáme jednotkovú cenu a ostatné hodnoty vypoèíta
    procedure Del(pDocNum:Str12);
    procedure Clc; // Vypocita vsetky ceny z jednotkovej ceny bez DPH
  published
  end;

implementation

function TImiHnd.FreeItmNum(pDocNum:Str12):word;
var mItmNum:word;  mFind:boolean;
begin
  Result := 0;
  SwapIndex;
  If LocateDoIt(pDocNum,1) then begin
    mItmNum := 0;
    Repeat
      Inc (mItmNum);
      mFind := mItmNum<ItmNum;
      If mItmNum>ItmNum then mItmNum := ItmNum;
      Next;
    until Eof or mFind or (DocNum<>pDocNum);
    If mFind
      then Result := mItmNum
      else Result := mItmNum+1;
  end
  else Result := 1;
  RestoreIndex;
end;

function TImiHnd.NextItmNum(pDocNum:Str12):word;
begin
  If not NearestDoIt(pDocNum,65000) then Last;
  If not IsLastRec or (DocNum<>pDocNum) then Prior;
  If DocNum=pDocNum
    then Result := ItmNum+1
    else Result := 1;
end;

procedure TImiHnd.SetCPrice (pCPrice:double); // Zadáme jednotkovú cenu a ostatné hodnoty vypoèíta
begin
  CPrice := pCPrice;
  CValue := Rd2(pCPrice*GsQnt);
  EValue := Rd2(CValue*(1+VatPrc/100));
  If IsNotNul (GsQnt) then EPrice := Rd2(EValue/GsQnt);
end;

procedure TImiHnd.Del(pDocNum:Str12);
begin
  While LocateDocNum(pDocNum) do begin
    Delete;
    Application.ProcessMessages;
  end;
end;

procedure TImiHnd.Clc; // Vypocita vsetky ceny z jednotkovej ceny bez DPH
begin
  CValue := Rd2(CPrice*GsQnt);
  EValue := Rd2(CValue*(1+VatPrc/100)); 
  If IsNotNul(GsQnt) then EPrice := RoundCPrice (EValue/GsQnt);
end;

end.
