unit IniHandle;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  IniFiles;

type
  TIniHandle = class(TComponent)
  private
    { Private declarations }
    oFileName: string;
    oSection: string;
    oIniFile: TIniFile;
  protected
    { Protected declarations }
    procedure OpenIniFile;

  public
    { Public declarations }
    destructor Destroy; override;

    function  ReadString(pKeyName, pDefault: string): string;
    procedure WriteString(pKeyName, pValue: string);
    function  ReadBool(pKeyName: string; pDefault: boolean): boolean;
    procedure WriteBool(pKeyName: string; pValue: boolean);
    function  ReadInteger(pKeyName: string; pDefault: integer): integer;
    procedure WriteInteger(pKeyName: string; pValue: integer);
    function  ReadFloat(pKeyName: string; pDefault: double): double;
    procedure WriteFloat(pKeyName: string; pValue: double);
    function  ReadDoub(pKeyName: string; pDefault: double): double;
    procedure WriteDoub(pKeyName: string; pValue: double);
    function  ReadLong(pKeyName: string; pDefault: integer): longint;
    procedure WriteLong(pKeyName: string; pValue: integer);
    function  ReadWord(pKeyName: string; pDefault: integer): word;
    procedure WriteWord(pKeyName: string; pValue: integer);
    function  ReadByte(pKeyName: string; pDefault: integer): byte;
    procedure WriteByte(pKeyName: string; pValue: integer);

    procedure ReadSection(pSection: TStrings);
    procedure ReadSections(pSections: TStrings);
    procedure EraseSection;

    function  SectionExists: Boolean;
    function  ValueExists(const pIdent: String): Boolean;

    procedure DeleteKey(pKeyName: string);
  published
    { Published declarations }
    property FileName: string read oFileName write oFileName;
    property Section: string read oSection write oSection;
  end;

procedure Register;

implementation

destructor TIniHandle.Destroy;
begin
  inherited ;
  oIniFile.Free;
end;

procedure TIniHandle.DeleteKey(pKeyName: string);
begin
  OpenIniFile;
  oIniFile.DeleteKey(oSection, pKeyName);
end;

function  TIniHandle.SectionExists: Boolean;
begin
  OpenIniFile;
  Result := oIniFile.SectionExists(oSection);
end;

function  TIniHandle.ValueExists(const pIdent: String): Boolean;
begin
  OpenIniFile;
  Result := oIniFile.ValueExists (oSection, pIdent);
end;

function  TIniHandle.ReadByte(pKeyName: string; pDefault: integer): byte;
begin
  Result := ReadInteger (pKeyName, pDefault);
end;

procedure TIniHandle.WriteByte(pKeyName: string; pValue: integer);
begin
  WriteInteger (pKeyName, pValue);
end;

function  TIniHandle.ReadWord(pKeyName: string; pDefault: integer): word;
begin
  Result := ReadInteger (pKeyName,pDefault);
end;

procedure TIniHandle.WriteWord(pKeyName: string; pValue: integer);
begin
  WriteInteger (pKeyName,pValue);
end;

function  TIniHandle.ReadLong(pKeyName: string; pDefault: integer): longint;
begin
  Result := ReadInteger (pKeyName,pDefault);
end;

procedure TIniHandle.WriteLong(pKeyName: string; pValue: integer);
begin
  WriteInteger (pKeyName,pValue);
end;

function  TIniHandle.ReadDoub(pKeyName: string; pDefault: double): double; //2000.5.2.
begin
  Result := ReadFloat (pKeyName,pDefault);
end;

procedure TIniHandle.WriteDoub(pKeyName: string; pValue: double); //2000.5.2.
begin
  WriteFloat (pKeyName,pValue);
end;

procedure TIniHandle.EraseSection;
begin
  OpenIniFile;
  oIniFile.EraseSection(oSection);
end;

procedure TIniHandle.ReadSection(pSection: TStrings);
begin
  OpenIniFile;
  oIniFile.ReadSection(oSection, pSection);
end;

procedure TIniHandle.ReadSections(pSections: TStrings);
begin
  OpenIniFile;
  oIniFile.ReadSections(pSections);
end;

function  TIniHandle.ReadString(pKeyName, pDefault: string): string;
begin
  OpenIniFile;
  Result := oIniFile.ReadString(oSection, pKeyName, pDefault);
end;

procedure TIniHandle.WriteString(pKeyName, pValue: string);
begin
  OpenIniFile;
  oIniFile.WriteString(oSection, pKeyName, pValue);
end;

function  TIniHandle.ReadBool(pKeyName: string; pDefault: boolean): boolean;
begin
  OpenIniFile;
  Result := oIniFile.ReadBool(oSection, pKeyName, pDefault);
end;

procedure TIniHandle.WriteBool(pKeyName: string; pValue: boolean);
begin
  OpenIniFile;
  oIniFile.WriteBool(oSection, pKeyName, pValue);
end;

function  TIniHandle.ReadInteger(pKeyName: string; pDefault: integer): integer;
begin
  OpenIniFile;
  Result := oIniFile.ReadInteger(oSection, pKeyName, pDefault);
end;

procedure TIniHandle.WriteInteger(pKeyName: string; pValue: integer);
begin
  OpenIniFile;
  oIniFile.WriteInteger(oSection, pKeyName, pValue);
end;

function  TIniHandle.ReadFloat(pKeyName: string; pDefault: double): double;
begin
  OpenIniFile;
  Result := oIniFile.ReadFloat(oSection, pKeyName, pDefault);
end;

procedure TIniHandle.WriteFloat(pKeyName: string; pValue: double);
begin
  OpenIniFile;
  oIniFile.WriteFloat(oSection, pKeyName, pValue);
end;

//**************** PRIVATE METHODS ****************
procedure TIniHandle.OpenIniFile;
begin
  If (oIniFile<>nil) and (oIniFile.FileName<>oFileName) then oIniFile.Free;
  If oIniFile=nil then oIniFile := TIniFile.Create(oFileName);
end;


procedure Register;
begin
  RegisterComponents('IcDataAccess', [TIniHandle]);
end;

end.
