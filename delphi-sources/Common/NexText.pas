unit NexText;

interface

uses 
  IcTypes, NexPath, IniFiles, Classes;

type
  TNexText = class (TIniFile)
  private
    { Private declarations }
    oSection: Str30;
  public
    { Public declarations }
    constructor Create; overload;
    procedure SetSection (pSection:string);
    function  GetText (pKeyName,pDefault:string): string;
    function  GetLong (pKeyName:string; pDefault:longint): longint;
    function  GetSecText (pSection,pKeyName,pDefault:string): string;
    function  GetSecLong (pSection,pKeyName:string; pDefault:longint): longint;

    procedure WriteLong (pKeyName:string; pDefault:longint);
  end;

var  gNT: TNexText;

implementation

constructor TNexText.Create;
begin
  inherited Create (gPath.LngPath+'NEXTEXT.TXT');
end;

procedure TNexText.SetSection (pSection:string);
begin
  oSection := pSection;
end;

function TNexText.GetText (pKeyName,pDefault:string): string;
begin
  If not ValueExists (oSection,pKeyName) then WriteString (oSection,pKeyName,pDefault);
  Result := ReadString (oSection, pKeyName,'');
  If Result='' then begin
    WriteString (oSection,pKeyName,pDefault);
    Result := ReadString (oSection, pKeyName,'');
  end;
end;

function TNexText.GetLong (pKeyName:string; pDefault:longint): longint;
begin
  If not ValueExists (oSection,pKeyName) then WriteInteger (oSection,pKeyName,pDefault);
  Result := ReadInteger (oSection,pKeyName,0);
end;

function TNexText.GetSecText (pSection,pKeyName,pDefault:string): string;
var mSection: string;
begin
  mSection := oSection;
  SetSection (pSection);
  Result := GetText (pKeyName,pDefault);
  oSection := mSection
end;

function TNexText.GetSecLong (pSection,pKeyName:string; pDefault:longint): longint;
var mSection: string;
begin
  mSection := oSection;
  Result := GetLong (pKeyName,pDefault);
  oSection := mSection
end;

procedure TNexText.WriteLong (pKeyName:string; pDefault:longint);
begin
  WriteInteger (oSection,pKeyName,pDefault);
end;

end.
