unit KsbKey;

interface

uses
  IcTypes, IcConv, IcVariab, NexPath, NexGlob, NexIni, hKEYDEF,
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls,
  Dialogs, DB, NexBtrTable, DBTables, NexPxTable;

type
  TKsbKey = class (TComponent)
    constructor Create(phKEYDEF:TKeydefHnd);
    destructor  Destroy; override;
  private
    ohKEYDEF:TKeydefHnd;
    function ReadTsiBok(pBokNum:Str5):Str5;   procedure WriteTsiBok(pBokNum:Str5;pValue:Str5);
    function ReadTsiSmc(pBokNum:Str5):word;   procedure WriteTsiSmc(pBokNum:Str5;pValue:word);
    function ReadTsoBok(pBokNum:Str5):Str5;   procedure WriteTsoBok(pBokNum:Str5;pValue:Str5);
    function ReadTsoSmc(pBokNum:Str5):word;   procedure WriteTsoSmc(pBokNum:Str5;pValue:word);

  public
    property TsiBok[pBokNum:Str5]:Str5   read ReadTsiBok write WriteTsiBok;  // Kniha vyúètovacích dodacích listov
    property TsiSmc[pBokNum:Str5]:word   read ReadTsiSmc write WriteTsiSmc;  // Pohyb vyúètovacích dodacích listov
    property TsoBok[pBokNum:Str5]:Str5   read ReadTsoBok write WriteTsoBok;  // Kniha vrátenkových dodacích listov
    property TsoSmc[pBokNum:Str5]:word   read ReadTsoSmc write WriteTsoSmc;  // Pohyb vrátenkových dodacích listov
  end;

implementation

constructor TKsbKey.Create(phKEYDEF:TKeydefHnd);
begin
  ohKEYDEF := phKEYDEF;
end;

destructor TKsbKey.Destroy;
begin
end;

// ******************************** PRIVATE ************************************

function TKsbKey.ReadTsiBok(pBokNum:Str5):Str5;
begin
  Result := ohKEYDEF.ReadString('KSB',pBokNum,'TsiBok','A-001');
end;

procedure TKsbKey.WriteTsiBok(pBokNum:Str5;pValue:Str5);
begin
  ohKEYDEF.WriteString('KSB',pBokNum,'TsiBok',pValue);
end;

function TKsbKey.ReadTsiSmc(pBokNum:Str5):word;
begin
  Result := ohKEYDEF.ReadInteger('KSB',pBokNum,'TsiSmc',54);
end;

procedure TKsbKey.WriteTsiSmc(pBokNum:Str5;pValue:word);
begin
  ohKEYDEF.Writeinteger('KSB',pBokNum,'TsiSmc',pValue);
end;

function TKsbKey.ReadTsoBok(pBokNum:Str5):Str5;
begin
  Result := ohKEYDEF.ReadString('KSB',pBokNum,'TsoBok','A-001');
end;

procedure TKsbKey.WriteTsoBok(pBokNum:Str5;pValue:Str5);
begin
  ohKEYDEF.WriteString('KSB',pBokNum,'TsoBok',pValue);
end;

function TKsbKey.ReadTsoSmc(pBokNum:Str5):word;
begin
  Result := ohKEYDEF.ReadInteger('KSB',pBokNum,'TsoSmc',54);
end;

procedure TKsbKey.WriteTsoSmc(pBokNum:Str5;pValue:word);
begin
  ohKEYDEF.Writeinteger('KSB',pBokNum,'TsoSmc',pValue);
end;

// ********************************* PUBLIC ************************************

end.
{MOD 1905002}
