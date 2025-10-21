unit h{TABLE_NAME};

{*******************************************************************************
  Business Logic Handler pre {TABLE_NAME} tabuľku

  Tento súbor obsahuje custom business logic špecifickú pre {TABLE_NAME}.
  NEREGENERUJE SA automaticky - je ručne udržiavaný.

  Dedí z: b{TABLE_NAME}.pas (auto-generovaný wrapper)

  Účel:
  - Custom business methods
  - Validácie
  - Komplexné operácie
  - Špecifická logika pre túto tabuľku

  Projekt: NEX Genesis Server
  Vytvorené: {DATE}
  Autor: {AUTHOR}
*******************************************************************************}

interface

uses
  IcTypes, NexPath, NexGlob,
  b{TABLE_NAME},  // Auto-generovaný wrapper
  Forms, Windows, Messages, SysUtils, Variants, Classes, Graphics,
  Controls, Dialogs;

type
  T{TABLE_NAME}Hnd = class(T{TABLE_NAME}Btr)
  private
    // Private helper methods

  public
    // Constructor/Destructor (ak je potrebné)
    // constructor Create; overload;
    // destructor Destroy; override;

    // Custom business methods
    // Príklad:
    // procedure Del(pKeyValue: {KEY_TYPE});
    // function IsValid: boolean;
    // function IsDuplicate(pField: {TYPE}): boolean;

  published
    // Published properties (ak sú potrebné)
  end;

implementation

{*******************************************************************************
  IMPLEMENTÁCIA CUSTOM BUSINESS METHODS
*******************************************************************************}

// Príklad: Vymazanie všetkých záznamov pre daný kľúč
{
procedure T{TABLE_NAME}Hnd.Del(pKeyValue: {KEY_TYPE});
begin
  // Vymaže všetky záznamy s daným kľúčom
  While Locate{KEY_FIELD}(pKeyValue) do
    Delete;
end;
}

// Príklad: Validácia pred uložením
{
procedure T{TABLE_NAME}Hnd.Post; override;
begin
  // Custom validácia
  if Trim({FIELD_NAME}) = '' then
    raise Exception.Create('{FIELD_NAME} nemôže byť prázdny!');

  // Nastavenie audit polí
  ModUser := gCurrentUser;
  ModDate := Now;
  ModTime := Now;

  // Zavolaj parent Post
  inherited Post;
end;
}

// Príklad: Kontrola duplicity
{
function T{TABLE_NAME}Hnd.IsDuplicate(pField: {TYPE}): boolean;
begin
  Result := Locate{FIELD_NAME}(pField);
end;
}

end.

{*******************************************************************************
  POZNÁMKY PRE VÝVOJÁRA:

  1. Tento súbor PREŽIJE regeneráciu b{TABLE_NAME}.pas
  2. Všetka business logic MUSÍ byť tu, NIE v b{TABLE_NAME}.pas
  3. Vždy používaj Locate methods namiesto manuálneho vyhľadávania
  4. Vždy aktualizuj ModUser, ModDate, ModTime
  5. Wrap všetky operácie do try..finally blokov pri použití

  POUŽITIE:

  var
    TableHnd: T{TABLE_NAME}Hnd;
  begin
    TableHnd := T{TABLE_NAME}Hnd.Create;
    try
      // Práca s tabuľkou
      if TableHnd.Locate{KEY_FIELD}(value) then
      begin
        // Našiel sa záznam
      end;
    finally
      TableHnd.Free;
    end;
  end;

*******************************************************************************}