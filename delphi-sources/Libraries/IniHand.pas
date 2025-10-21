unit IniHand;

interface

uses
  IniFiles;

type
  TIniHand = class (TIniFile)
    function ReadString (const Section, Ident, Default: string): string; override;
    function ReadBool (const Section, Ident: String; Default: Boolean): Boolean; override;
    function ReadDate (const Section, Ident: string; Default: TDateTime): TDateTime; override;
    function ReadDateTime (const Section, Ident: String; Default: TDateTime): TDateTime; override;
    function ReadFloat (const Section, Ident: String; Default: Double): Double; override;
    function ReadInteger (const Section, Ident: String; Default: Longint): Longint; override;
    function ReadTime (const Section, Ident: String; Default: TDateTime): TDateTime; override;
  end;

implementation

function TIniHand.ReadString (const Section, Ident, Default: string): string;
begin
  If not ValueExists (Section,Ident) then WriteString (Section,Ident,Default);
  Result := inherited ReadString (Section,Ident,Default);
end;

function TIniHand.ReadBool (const Section, Ident: String; Default: Boolean): Boolean;
begin
  If not ValueExists (Section,Ident) then WriteBool (Section,Ident,Default);
  Result := inherited ReadBool (Section,Ident,Default);
end;

function TIniHand.ReadDate (const Section, Ident: string; Default: TDateTime): TDateTime;
begin
  If not ValueExists (Section,Ident) then WriteDate (Section,Ident,Default);
  Result := inherited ReadDate (Section,Ident,Default);
end;

function TIniHand.ReadDateTime (const Section, Ident: String; Default: TDateTime): TDateTime;
begin
  If not ValueExists (Section,Ident) then WriteDateTime (Section,Ident,Default);
  Result := inherited ReadDateTime (Section,Ident,Default);
end;

function TIniHand.ReadFloat (const Section, Ident: String; Default: Double): Double;
begin
  If not ValueExists (Section,Ident) then WriteFloat (Section,Ident,Default);
  Result := inherited ReadFloat (Section,Ident,Default);
end;

function TIniHand.ReadInteger (const Section, Ident: String; Default: Longint): Longint;
begin
  If not ValueExists (Section,Ident) then WriteInteger (Section,Ident,Default);
  Result := inherited ReadInteger (Section,Ident,Default);
end;

function TIniHand.ReadTime (const Section, Ident: String; Default: TDateTime): TDateTime;
begin
  If not ValueExists (Section,Ident) then WriteTime (Section,Ident,Default);
  Result := inherited ReadTime (Section,Ident,Default);
end;

end.
