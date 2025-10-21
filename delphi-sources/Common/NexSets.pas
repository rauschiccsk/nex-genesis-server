unit NexSets;

interface

uses
  IcTypes, NexMsg, NexError, NexIni, IcVariab;

  // Nastavenia k jedotlivym kniham
  function AutoDocRnd (pBookType:Str3; pBookNum:Str5): boolean;  // TRUE ak prihlaseny uzivatel ma zapnutu funkciu automatickeho zaokruhlenia v danej knihe
  function EasyItmEditor (pBookType:Str3; pBookNum:Str5): boolean;  // TRUE ak sa pouziva jednoduchy editor poloziek dokladov


implementation

uses
  DM_SYSTEM;

function AutoDocRnd (pBookType:Str3; pBookNum:Str5): boolean;  // TRUE ak prihlaseny uzivatel ma zapnutu funkciu automatickeho zaokruhlenia v danej knihe
begin
  If not gSet.ValueExists (pBookType,'AutoDocRnd_'+pBookNum) then gSet.WriteBool (pBookType,'AutoDocRnd_'+pBookNum,TRUE);
  Result := gSet.ReadBool (pBookType,'AutoDocRnd_'+pBookNum,TRUE);
end;

function EasyItmEditor (pBookType:Str3; pBookNum:Str5): boolean;  // TRUE ak sa pouziva jednoduchy editor poloziek dokladov
begin
  If not gSet.ValueExists (pBookType,'EasyItmEditor_'+pBookNum) then gSet.WriteBool (pBookType,'EasyItmEditor_'+pBookNum,FALSE);
  Result := gSet.ReadBool (pBookType,'EasyItmEditor_'+pBookNum,FALSE);
end;

end.
