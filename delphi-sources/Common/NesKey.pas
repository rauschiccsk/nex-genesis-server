unit NesKey;

interface

uses
  IcTypes, IcConv, IcVariab, NexPath, NexGlob, NexIni, hKEYDEF,
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls,
  Dialogs, DB, NexBtrTable, DBTables, NexPxTable;

type
  TNesKey=class (TComponent)
    constructor Create(phKEYDEF:TKeydefHnd);
    destructor Destroy; override;
  private
    ohKEYDEF:TKeydefHnd;
    function ReadPlsNum:word;    procedure WritePlsNum(pValue:word);
    function ReadPlrNum:word;    procedure WritePlrNum(pValue:word);
    function ReadPlwNum:word;    procedure WritePlwNum(pValue:word);
    function ReadAplNum:word;    procedure WriteAplNum(pValue:word);
    function ReadPerTim:word;    procedure WritePerTim(pValue:word);
    function ReadShpDir:Str250;  procedure WriteShpDir(pValue:Str250);

  public
    property PlsNum:word read ReadPlsNum write WritePlsNum;   // »Ìslo predajnÈho cennÌka pre Eshop
    property PlrNum:word read ReadPlrNum write WritePlrNum;   // »Ìslo cennÌka doporuËen˝ch cien
    property PlwNum:word read ReadPlwNum write WritePlwNum;   // »Ìslo cennÌka pre inÈ webovÈ str·nky
    property AplNum:word read ReadAplNum write WriteAplNum;   // »Ìslo akciovÈho cennÌka pre Eshop
    property PerTim:word read ReadPerTim write WritePerTim;   // »as periodeckÈho sp˙öùania funkcie
    property ShpDir:Str250 read ReadShpDir write WriteShpDir; // KomunikaËn˝ adres·r pre Eshop
  end;

implementation

constructor TNesKey.Create(phKEYDEF:TKeydefHnd);
begin
  ohKEYDEF:=phKEYDEF;
end;

destructor TNesKey.Destroy;
begin
end;

// ******************************** PRIVATE ************************************

function TNesKey.ReadPlsNum:word;
begin
  Result:=ohKEYDEF.ReadInteger('NES','','PlsNum',1);
end;

procedure TNesKey.WritePlsNum(pValue:word);
begin
  ohKEYDEF.Writeinteger('NES','','PlsNum',pValue);
end;

function TNesKey.ReadPlrNum:word;
begin
  Result:=ohKEYDEF.ReadInteger('NES','','PlrNum',2);
end;

procedure TNesKey.WritePlrNum(pValue:word);
begin
  ohKEYDEF.Writeinteger('NES','','PlrNum',pValue);
end;

function TNesKey.ReadPlwNum:word;
begin
  Result:=ohKEYDEF.ReadInteger('NES','','PlwNum',3);
end;

procedure TNesKey.WritePlwNum(pValue:word);
begin
  ohKEYDEF.Writeinteger('NES','','PlwNum',pValue);
end;

function TNesKey.ReadAplNum:word;
begin
  Result:=ohKEYDEF.ReadInteger('NES','','AplNum',0);
end;

procedure TNesKey.WriteAplNum(pValue:word);
begin
  ohKEYDEF.Writeinteger('NES','','AplNum',pValue);
end;

function TNesKey.ReadPerTim:word;
begin
  Result:=ohKEYDEF.ReadInteger('NES','','PerTim',60);
end;

procedure TNesKey.WritePerTim(pValue:word);
begin
  ohKEYDEF.Writeinteger('NES','','PerTim',pValue);
end;

function TNesKey.ReadShpDir:Str250;
begin
  Result:=ohKEYDEF.ReadString('NES','','ShpDir',gPath.ExpPath);
end;

procedure TNesKey.WriteShpDir(pValue:Str250);
begin
  ohKEYDEF.WriteString('NES','','ShpDir',pValue);
end;

// ********************************* PUBLIC ************************************

end.

