unit PrbKey;

interface

uses
  IcTypes, IcConv, IcVariab, NexPath, NexGlob, NexIni, hKEYDEF,
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls,
  Dialogs, DB, NexBtrTable, DBTables, NexPxTable;

type
  TPrbKey = class (TComponent)
    constructor Create(phKEYDEF:TKeydefHnd);
    destructor  Destroy; override;
  private
    ohKEYDEF:TKeydefHnd;
    function ReadSrvPrj(pBokNum:Str5):boolean;    procedure WriteSrvPrj(pBokNum:Str5;pValue:boolean);
    function ReadDurDay(pBokNum:Str5):byte;       procedure WriteDurDay(pBokNum:Str5;pValue:byte);
    function ReadDurWek(pBokNum:Str5):byte;       procedure WriteDurWek(pBokNum:Str5;pValue:byte);
    function ReadUniMin(pBokNum:Str5):byte;       procedure WriteUniMin(pBokNum:Str5;pValue:byte);
    function ReadSpcPrc(pBokNum:Str5):double;     procedure WriteSpcPrc(pBokNum:Str5;pValue:double);
    function ReadDocPrc(pBokNum:Str5):double;     procedure WriteDocPrc(pBokNum:Str5;pValue:double);
    function ReadAdmPrc(pBokNum:Str5):double;     procedure WriteAdmPrc(pBokNum:Str5;pValue:double);
    function ReadPrgPrc(pBokNum:Str5):double;     procedure WritePrgPrc(pBokNum:Str5;pValue:double);
    function ReadTesPrc(pBokNum:Str5):double;     procedure WriteTesPrc(pBokNum:Str5;pValue:double);
    function ReadDebPrc(pBokNum:Str5):double;     procedure WriteDebPrc(pBokNum:Str5;pValue:double);
    function ReadAcpPrc(pBokNum:Str5):double;     procedure WriteAcpPrc(pBokNum:Str5;pValue:double);
    function ReadResPrc(pBokNum:Str5):double;     procedure WriteResPrc(pBokNum:Str5;pValue:double);
    function ReadSpcPce(pBokNum:Str5):double;     procedure WriteSpcPce(pBokNum:Str5;pValue:double);
    function ReadDocPce(pBokNum:Str5):double;     procedure WriteDocPce(pBokNum:Str5;pValue:double);
    function ReadAdmPce(pBokNum:Str5):double;     procedure WriteAdmPce(pBokNum:Str5;pValue:double);
    function ReadPrgPce(pBokNum:Str5):double;     procedure WritePrgPce(pBokNum:Str5;pValue:double);
    function ReadTesPce(pBokNum:Str5):double;     procedure WriteTesPce(pBokNum:Str5;pValue:double);
    function ReadDebPce(pBokNum:Str5):double;     procedure WriteDebPce(pBokNum:Str5;pValue:double);
    function ReadAcpPce(pBokNum:Str5):double;     procedure WriteAcpPce(pBokNum:Str5;pValue:double);
    function ReadResPce(pBokNum:Str5):double;     procedure WriteResPce(pBokNum:Str5;pValue:double);
  public
    property SrvPrj[pBokNum:Str5]:boolean   read ReadSrvPrj write WriteSrvPrj;  // Projektové riadenie tvorby IS
    property DurDay[pBokNum:Str5]:byte      read ReadDurDay write WriteDurDay;  // Poèet pacovných hodín pracovného dòa
    property DurWek[pBokNum:Str5]:byte      read ReadDurWek write WriteDurWek;  // Poèet pracovných dní pracovného týždòa
    property UniMin[pBokNum:Str5]:byte      read ReadUniMin write WriteUniMin;  // Trvanie tvorby jednej funkènej jednotky:
    property SpcPrc[pBokNum:Str5]:double    read ReadSpcPrc write WriteSpcPrc;
    property DocPrc[pBokNum:Str5]:double    read ReadDocPrc write WriteDocPrc;
    property AdmPrc[pBokNum:Str5]:double    read ReadAdmPrc write WriteAdmPrc;
    property PrgPrc[pBokNum:Str5]:double    read ReadPrgPrc write WritePrgPrc;
    property TesPrc[pBokNum:Str5]:double    read ReadTesPrc write WriteTesPrc;
    property DebPrc[pBokNum:Str5]:double    read ReadDebPrc write WriteDebPrc;
    property AcpPrc[pBokNum:Str5]:double    read ReadAcpPrc write WriteAcpPrc;
    property ResPrc[pBokNum:Str5]:double    read ReadResPrc write WriteResPrc;
    property SpcPce[pBokNum:Str5]:double    read ReadSpcPce write WriteSpcPce;
    property DocPce[pBokNum:Str5]:double    read ReadDocPce write WriteDocPce;
    property AdmPce[pBokNum:Str5]:double    read ReadAdmPce write WriteAdmPce;
    property PrgPce[pBokNum:Str5]:double    read ReadPrgPce write WritePrgPce;
    property TesPce[pBokNum:Str5]:double    read ReadTesPce write WriteTesPce;
    property DebPce[pBokNum:Str5]:double    read ReadDebPce write WriteDebPce;
    property AcpPce[pBokNum:Str5]:double    read ReadAcpPce write WriteAcpPce;
    property ResPce[pBokNum:Str5]:double    read ReadResPce write WriteResPce;
  end;

implementation

constructor TPrbKey.Create(phKEYDEF:TKeydefHnd);
begin
  ohKEYDEF := phKEYDEF;
end;

destructor TPrbKey.Destroy;
begin
end;

// ******************************** PRIVATE ************************************

function TPrbKey.ReadSrvPrj(pBokNum:Str5):boolean;
begin
  Result := ohKEYDEF.ReadBoolean('PRB',pBokNum,'SrvPrj',FALSE);
end;

procedure TPrbKey.WriteSrvPrj(pBokNum:Str5;pValue:boolean);
begin
  ohKEYDEF.WriteBoolean('PRB',pBokNum,'SrvPrj',pValue);
end;

function TPrbKey.ReadDurDay(pBokNum:Str5):byte;
begin
  Result := ohKEYDEF.ReadInteger('PRB',pBokNum,'DurDay',8);
end;

procedure TPrbKey.WriteDurDay(pBokNum:Str5;pValue:byte);
begin
  ohKEYDEF.WriteInteger('PRB',pBokNum,'DurDay',pValue);
end;

function TPrbKey.ReadDurWek(pBokNum:Str5):byte;
begin
  Result := ohKEYDEF.ReadInteger('PRB',pBokNum,'DurWek',5);
end;

procedure TPrbKey.WriteDurWek(pBokNum:Str5;pValue:byte);
begin
  ohKEYDEF.WriteInteger('PRB',pBokNum,'DurWek',pValue);
end;

function TPrbKey.ReadUniMin(pBokNum:Str5):byte;
begin
  Result := ohKEYDEF.ReadInteger('PRB',pBokNum,'UniMin',5);
end;

procedure TPrbKey.WriteUniMin(pBokNum:Str5;pValue:byte);
begin
  ohKEYDEF.WriteInteger('PRB',pBokNum,'UniMin',pValue);
end;

function TPrbKey.ReadSpcPrc(pBokNum:Str5):double;
begin
  Result := ohKEYDEF.ReadFloat('PRB',pBokNum,'SpcPrc',10,2);
end;

procedure TPrbKey.WriteSpcPrc(pBokNum:Str5;pValue:double);
begin
  ohKEYDEF.WriteFloat('PRB',pBokNum,'SpcPrc',pValue,2);
end;

function TPrbKey.ReadDocPrc(pBokNum:Str5):double;
begin
  Result := ohKEYDEF.ReadFloat('PRB',pBokNum,'DocPrc',25,2);
end;

procedure TPrbKey.WriteDocPrc(pBokNum:Str5;pValue:double);
begin
  ohKEYDEF.WriteFloat('PRB',pBokNum,'DocPrc',pValue,2);
end;

function TPrbKey.ReadAdmPrc(pBokNum:Str5):double;
begin
  Result := ohKEYDEF.ReadFloat('PRB',pBokNum,'AdmPrc',5,2);
end;

procedure TPrbKey.WriteAdmPrc(pBokNum:Str5;pValue:double);
begin
  ohKEYDEF.WriteFloat('PRB',pBokNum,'AdmPrc',pValue,2);
end;

function TPrbKey.ReadPrgPrc(pBokNum:Str5):double;
begin
  Result := ohKEYDEF.ReadFloat('PRB',pBokNum,'PrgPrc',25,2);
end;

procedure TPrbKey.WritePrgPrc(pBokNum:Str5;pValue:double);
begin
  ohKEYDEF.WriteFloat('PRB',pBokNum,'PrgPrc',pValue,2);
end;

function TPrbKey.ReadTesPrc(pBokNum:Str5):double;
begin
  Result := ohKEYDEF.ReadFloat('PRB',pBokNum,'TesPrc',15,2);
end;

procedure TPrbKey.WriteTesPrc(pBokNum:Str5;pValue:double);
begin
  ohKEYDEF.WriteFloat('PRB',pBokNum,'TesPrc',pValue,2);
end;

function TPrbKey.ReadDebPrc(pBokNum:Str5):double;
begin
  Result := ohKEYDEF.ReadFloat('PRB',pBokNum,'DebPrc',15,2);
end;

procedure TPrbKey.WriteDebPrc(pBokNum:Str5;pValue:double);
begin
  ohKEYDEF.WriteFloat('PRB',pBokNum,'DebPrc',pValue,2);
end;

function TPrbKey.ReadAcpPrc(pBokNum:Str5):double;
begin
  Result := ohKEYDEF.ReadFloat('PRB',pBokNum,'AcpPrc',2,2);
end;

procedure TPrbKey.WriteAcpPrc(pBokNum:Str5;pValue:double);
begin
  ohKEYDEF.WriteFloat('PRB',pBokNum,'AcpPrc',pValue,2);
end;

function TPrbKey.ReadResPrc(pBokNum:Str5):double;
begin
  Result := ohKEYDEF.ReadFloat('PRB',pBokNum,'ResPrc',3,2);
end;

procedure TPrbKey.WriteResPrc(pBokNum:Str5;pValue:double);
begin
  ohKEYDEF.WriteFloat('PRB',pBokNum,'ResPrc',pValue,2);
end;

function TPrbKey.ReadSpcPce(pBokNum:Str5):double;
begin
  Result := ohKEYDEF.ReadFloat('PRB',pBokNum,'SpcPce',12,2);
end;

procedure TPrbKey.WriteSpcPce(pBokNum:Str5;pValue:double);
begin
  ohKEYDEF.WriteFloat('PRB',pBokNum,'SpcPce',pValue,2);
end;

function TPrbKey.ReadDocPce(pBokNum:Str5):double;
begin
  Result := ohKEYDEF.ReadFloat('PRB',pBokNum,'DocPce',12,2);
end;

procedure TPrbKey.WriteDocPce(pBokNum:Str5;pValue:double);
begin
  ohKEYDEF.WriteFloat('PRB',pBokNum,'DocPce',pValue,2);
end;

function TPrbKey.ReadAdmPce(pBokNum:Str5):double;
begin
  Result := ohKEYDEF.ReadFloat('PRB',pBokNum,'AdmPce',12,2);
end;

procedure TPrbKey.WriteAdmPce(pBokNum:Str5;pValue:double);
begin
  ohKEYDEF.WriteFloat('PRB',pBokNum,'AdmPce',pValue,2);
end;

function TPrbKey.ReadPrgPce(pBokNum:Str5):double;
begin
  Result := ohKEYDEF.ReadFloat('PRB',pBokNum,'PrgPce',12,2);
end;

procedure TPrbKey.WritePrgPce(pBokNum:Str5;pValue:double);
begin
  ohKEYDEF.WriteFloat('PRB',pBokNum,'PrgPce',pValue,2);
end;

function TPrbKey.ReadTesPce(pBokNum:Str5):double;
begin
  Result := ohKEYDEF.ReadFloat('PRB',pBokNum,'TesPce',12,2);
end;

procedure TPrbKey.WriteTesPce(pBokNum:Str5;pValue:double);
begin
  ohKEYDEF.WriteFloat('PRB',pBokNum,'TesPce',pValue,2);
end;

function TPrbKey.ReadDebPce(pBokNum:Str5):double;
begin
  Result := ohKEYDEF.ReadFloat('PRB',pBokNum,'DebPce',12,2);
end;

procedure TPrbKey.WriteDebPce(pBokNum:Str5;pValue:double);
begin
  ohKEYDEF.WriteFloat('PRB',pBokNum,'DebPce',pValue,2);
end;

function TPrbKey.ReadAcpPce(pBokNum:Str5):double;
begin
  Result := ohKEYDEF.ReadFloat('PRB',pBokNum,'AcpPce',12,2);
end;

procedure TPrbKey.WriteAcpPce(pBokNum:Str5;pValue:double);
begin
  ohKEYDEF.WriteFloat('PRB',pBokNum,'AcpPce',pValue,2);
end;

function TPrbKey.ReadResPce(pBokNum:Str5):double;
begin
  Result := ohKEYDEF.ReadFloat('PRB',pBokNum,'ResPce',12,2);
end;

procedure TPrbKey.WriteResPce(pBokNum:Str5;pValue:double);
begin
  ohKEYDEF.WriteFloat('PRB',pBokNum,'ResPce',pValue,2);
end;
// ********************************* PUBLIC ************************************

end.
{MOD 1809006}
{MOD 1810001}
{MOD 1810004}
