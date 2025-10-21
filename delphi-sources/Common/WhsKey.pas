// ------------------------------------------------------------------------------
//                               PREDAJN¡ »INNOSç
// ------------------------------------------------------------------------------
unit WhsKey;

interface      

uses
  IcTypes, IcConv, IcVariab, NexPath, NexGlob, NexIni, hKEYDEF,
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls,
  Dialogs, DB, NexBtrTable, DBTables, NexPxTable;

type
  TWhsKey=class (TComponent)
    constructor Create(phKEYDEF:TKeydefHnd);
    destructor Destroy; override;
  private
    ohKEYDEF:TKeydefHnd;
    // Minim·lna predajn· cena
    function ReadMpcAct:boolean;    procedure WriteMpcAct(pValue:boolean);
    function ReadMpcApc:boolean;    procedure WriteMpcApc(pValue:boolean);
    function ReadMpcStk:byte;       procedure WriteMpcStk(pValue:byte);
    function ReadMpcCpc:byte;       procedure WriteMpcCpc(pValue:byte);
    function ReadMinPrf:double;     procedure WriteMinPrf(pValue:double);
    // SystÈm z·lohov˝ch platieb
    function ReadDepAct:boolean;    procedure WriteDepAct(pValue:boolean);
    function ReadDpiMgc:longint;    procedure WriteDpiMgc(pValue:longint);
    function ReadDpeMgc:longint;    procedure WriteDpeMgc(pValue:longint);
    function ReadDpiGsc:longint;    procedure WriteDpiGsc(pValue:longint);
    function ReadDpeGsc:longint;    procedure WriteDpeGsc(pValue:longint);
  public
    // Minim·lna predajn· cena
    property MpcAct:boolean read ReadMpcAct write WriteMpcAct;   // Aktivovaù systÈm minim·lnej predajnej ceny
    property MpcApc:boolean read ReadMpcApc write WriteMpcApc;   // Akciov· cena mÙûe byù niûöia ako minim·lna predajn· cena
    property MpcStk:byte read ReadMpcStk write WriteMpcStk;      // Zdrojov˝ sklad n·kupnej ceny pre (0-sklad dokladu,1-hlavn˝ sklad)
    property MpcCpc:byte read ReadMpcCpc write WriteMpcCpc;      // Zdroj n·kupnej ceny pre v˝poËet minim·lnej predajnej ceny
    property MinPrf:double read ReadMinPrf write WriteMinPrf;    // Glob·lna minim·lna obchodn· marûa
    // SystÈm z·lohov˝ch platieb
    property DepAct:boolean read ReadDepAct write WriteDepAct;   // Aktivovaù systÈm z·lohov˝ch platieb
    property DpiMgc:longint read ReadDpiMgc write WriteDpiMgc;   // Tovarov· skupina - Prijem z·lohy
    property DpeMgc:longint read ReadDpeMgc write WriteDpeMgc;   // Tovarov· skupina - OdpoËet z·lohy
    property DpiGsc:longint read ReadDpiGsc write WriteDpiGsc;   // B·zovÈ PLU - Prijem z·lohy
    property DpeGsc:longint read ReadDpeGsc write WriteDpeGsc;   // B·zovÈ PLU - OdpoËet z·lohy
  end;

implementation

constructor TWhsKey.Create(phKEYDEF:TKeydefHnd);
begin
  ohKEYDEF:=phKEYDEF;
end;

destructor TWhsKey.Destroy;
begin
end;

// ******************************** PRIVATE ************************************

function TWhsKey.ReadMpcAct:boolean;
begin
  Result:=ohKEYDEF.ReadBoolean('WHS','','MpcAct',FALSE);
end;

procedure TWhsKey.WriteMpcAct(pValue:boolean);
begin
  ohKEYDEF.WriteBoolean('WHS','','MpcAct',pValue);
end;

function TWhsKey.ReadMpcApc:boolean;
begin
  Result:=ohKEYDEF.ReadBoolean('WHS','','MpcApc',FALSE);
end;

procedure TWhsKey.WriteMpcApc(pValue:boolean);
begin
  ohKEYDEF.WriteBoolean('WHS','','MpcApc',pValue);
end;

function TWhsKey.ReadMpcStk:byte;
begin
  Result:=ohKEYDEF.ReadInteger('WHS','','MpcStk',0);
end;

procedure TWhsKey.WriteMpcStk(pValue:byte);
begin
  ohKEYDEF.Writeinteger('WHS','','MpcStk',pValue);
end;

function TWhsKey.ReadMpcCpc:byte;
begin
  Result:=ohKEYDEF.ReadInteger('WHS','','MpcCpc',0);
end;

procedure TWhsKey.WriteMpcCpc(pValue:byte);
begin
  ohKEYDEF.WriteInteger('WHS','','MpcCpc',pValue);
end;

function TWhsKey.ReadMinPrf:double;
begin
  Result:=ohKEYDEF.ReadFloat('WHS','','MinPrf',0,2);
end;

procedure TWhsKey.WriteMinPrf(pValue:double);
begin
  ohKEYDEF.WriteFloat('WHS','','MinPrf',pValue,2);
end;

function TWhsKey.ReadDepAct:boolean;
begin
  Result:=ohKEYDEF.ReadBoolean('WHS','','DepAct',FALSE);
end;

procedure TWhsKey.WriteDepAct(pValue:boolean);
begin
  ohKEYDEF.WriteBoolean('WHS','','DepAct',pValue);
end;

function TWhsKey.ReadDpiMgc:longint;
begin
  Result:=ohKEYDEF.ReadInteger('WHS','','DpiMgc',0);
end;

procedure TWhsKey.WriteDpiMgc(pValue:longint);
begin
  ohKEYDEF.WriteInteger('WHS','','DpiMgc',pValue);
end;

function TWhsKey.ReadDpeMgc:longint;
begin
  Result:=ohKEYDEF.ReadInteger('WHS','','DpeMgc',0);
end;

procedure TWhsKey.WriteDpeMgc(pValue:longint);
begin
  ohKEYDEF.WriteInteger('WHS','','DpeMgc',pValue);
end;

function TWhsKey.ReadDpiGsc:longint;
begin
  Result:=ohKEYDEF.ReadInteger('WHS','','DpiGsc',90000);
end;

procedure TWhsKey.WriteDpiGsc(pValue:longint);
begin
  ohKEYDEF.WriteInteger('WHS','','DpiGsc',pValue);
end;

function TWhsKey.ReadDpeGsc:longint;
begin
  Result:=ohKEYDEF.ReadInteger('WHS','','DpeGsc',90100);
end;

procedure TWhsKey.WriteDpeGsc(pValue:longint);
begin
  ohKEYDEF.WriteInteger('WHS','','DpeGsc',pValue);
end;

// ********************************* PUBLIC ************************************

end.

