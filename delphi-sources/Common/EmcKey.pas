unit EmcKey;

interface

uses
  IcTypes, IcConv, IcVariab, NexPath, NexGlob, NexIni, hKEYDEF,
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls,
  Dialogs, DB, NexBtrTable, DBTables, NexPxTable;

type
  TEMCKey = class (TComponent)
    constructor Create(phKEYDEF:TKeydefHnd);
    destructor  Destroy; override;
  private
    ohKEYDEF:TKeydefHnd;
    function ReadPdfPrg:Str60;      procedure WritePdfPrg(pValue:Str60);
    function ReadUserName:Str60;    procedure WriteUserName(pValue:Str60);
    function ReadPassword:Str60;    procedure WritePassword(pValue:Str60);
    function ReadPort:Str60;        procedure WritePort(pValue:Str60);
    function ReadHost:Str60;        procedure WriteHost(pValue:Str60);
    function ReadAuthType:byte;     procedure WriteAuthType(pValue:byte);
    function ReadUseTLS:byte;       procedure WriteUseTLS(pValue:byte);
    function ReadWaiOne:integer;    procedure WriteWaiOne(pValue:integer);
  public
    property EmcPdfPrg:Str60   read ReadPdfPrg     write WritePdfPrg;     // Tlacovy manager PDF
    property UserName:Str60    read ReadUserName   write WriteUserName;   // Prihlasovacie meno
    property Password:Str60    read ReadPassword   write WritePassword;   // Prihlasovacie meno
    property Port:Str60        read ReadPort       write WritePort;       // Prihlasovacie meno
    property Host:Str60        read ReadHost       write WriteHost;       // SMTP Host
    property AuthType:byte     read ReadAuthType   write WriteAuthType;   // Authentication
    property UseTLS:byte       read ReadUseTLS     write WriteUseTLS;     // UseTLS
    property WaiOne:integer    read ReadWaiOne     write WriteWaiOne;     // Cakanie kym sa vygeneruje PDF pri hromadnom generovani
  end;

implementation

constructor TEMCKey.Create(phKEYDEF:TKeydefHnd);
begin
  ohKEYDEF := phKEYDEF;
end;

destructor TEMCKey.Destroy;
begin
end;

// ******************************** PRIVATE ************************************

function TEMCKey.ReadPdfPrg:Str60;
begin
  Result := ohKEYDEF.ReadString('EMC','','EmcPdfPrg','PDFCreator');
end;

procedure TEMCKey.WritePdfPrg(pValue:Str60);
begin
  ohKEYDEF.WriteString('EMC','','EmcPdfPrg',pValue);
end;

function TEMCKey.ReadUserName:Str60;
begin
  Result := ohKEYDEF.ReadString('EMC','','UserName','test@icc.sk');
end;

procedure TEMCKey.WriteUserName(pValue:Str60);
begin
  ohKEYDEF.WriteString('EMC','','UserName',pValue);
end;

function TEMCKey.ReadHost:Str60;
begin
  Result := ohKEYDEF.ReadString('EMC','','Host','mail.icc.sk');
end;

procedure TEMCKey.WriteHost(pValue:Str60);
begin
  ohKEYDEF.WriteString('EMC','','Host',pValue);
end;

function TEMCKey.ReadPassword:Str60;
begin
  Result := ohKEYDEF.ReadString('EMC','','Password','Test123');
end;

procedure TEMCKey.WritePassword(pValue:Str60);
begin
  ohKEYDEF.WriteString('EMC','','Password',pValue);
end;

function TEMCKey.ReadPort:Str60;
begin
  Result := ohKEYDEF.ReadString('EMC','','Port','25');
end;

procedure TEMCKey.WritePort(pValue:Str60);
begin
  ohKEYDEF.WriteString('EMC','','Port',pValue);
end;

function TEMCKey.ReadAuthType:byte;
begin
  Result := ValInt(ohKEYDEF.ReadString('EMC','','AuthType','0'));
end;

procedure TEMCKey.WriteAuthType(pValue:byte);
begin
  ohKEYDEF.WriteString('EMC','','AuthType',IntToStr(pValue));
end;

function TEMCKey.ReadUseTLS:byte;
begin
  Result := ValInt(ohKEYDEF.ReadString('EMC','','UseTLS','0'));
end;

procedure TEMCKey.WriteUseTLS(pValue:byte);
begin
  ohKEYDEF.WriteString('EMC','','UseTLS',IntToStr(pValue));
end;

function TEMCKey.ReadWaiOne:integer;
begin
  Result := ValInt(ohKEYDEF.ReadString('EMC','','EmcWaiOne','2000'));
end;

procedure TEMCKey.WriteWaiOne(pValue:integer);
begin
  ohKEYDEF.WriteString('EMC','','EmcWaiOne',IntToStr(pValue));
end;

// ********************************* PUBLIC ************************************

end.

{MOD 1807014}
{MOD 1807016}
{MOD 1807018}

