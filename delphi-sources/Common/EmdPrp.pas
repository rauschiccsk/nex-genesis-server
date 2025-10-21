unit EmdPrp;

interface

uses
  IcTypes, IcConv, IcVariab, hPRPDEF,
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls,
  Dialogs, DB, NexBtrTable, DBTables, NexPxTable;

type
  TEmdPrp=class
    constructor Create(phPRPDEF:TPrpdefHnd);
    procedure OpenPRPDEF;
  private
    ohPRPDEF:TPrpdefHnd;
    // Parametre modulu
    function GetEmlSnd:boolean;    procedure SetEmlSnd(pValue:boolean);
    function GetSmtp:ShortString;  procedure SetSmtp(pValue:ShortString);
    function Getport:word;         procedure SetPort(pValue:word);
    function GetUser:ShortString;  procedure SetUser(pValue:ShortString);
    function GetPasw:ShortString;  procedure SetPasw(pValue:ShortString);
  public
    property EmlSnd:boolean read GetEmlSnd write SetEmlSnd; // Aktivácia odosielanie pošty - ak je TRUE pošty sú odosielané, ak FALSE odosielanie je pozastavené
    property Smtp:ShortString read GetSmtp write SetSmtp;   // Server odchádzajúcej pošty
    property Port:word read GetPort write SetPort;          // Port na odoslanie emailov
    property User:ShortString read GetUser write SetUser;   // Užívate¾ na odoslanie emailov
    property Pasw:ShortString read GetPasw write SetPasw;   // Heslo na odoslanie emailov
  end;

implementation

constructor TEmdPrp.Create(phPRPDEF:TPrpdefHnd);
begin
  ohPRPDEF:=phPRPDEF;
end;

procedure TEmdPrp.OpenPRPDEF;
begin
  If not ohPRPDEF.Active then ohPRPDEF.Open;;
end;

// ******************************** PRIVATE ************************************

function TEmdPrp.GetEmlSnd:boolean;
begin
  OpenPRPDEF;
  Result:=ohPRPDEF.ReadBoolean('EMD','','EmlSnd',TRUE);
end;

procedure TEmdPrp.SetEmlSnd(pValue:boolean);
begin
  OpenPRPDEF;
  ohPRPDEF.WriteBoolean('EMD','','EmlSnd',pValue);
end;

function TEmdPrp.GetSmtp:ShortString;
begin
  OpenPRPDEF;
  Result:=ohPRPDEF.ReadString('EMD','','Smtp','');
end;

procedure TEmdPrp.SetSmtp(pValue:ShortString);
begin
  OpenPRPDEF;
  ohPRPDEF.WriteString('EMD','','Smtp',pValue);
end;

function TEmdPrp.GetPort:word;
begin
  OpenPRPDEF;
  Result:=ohPRPDEF.ReadInteger('EMD','','Port',25);
end;

procedure TEmdPrp.SetPort(pValue:word);
begin
  OpenPRPDEF;
  ohPRPDEF.WriteInteger('EMD','','Port',pValue);
end;

function TEmdPrp.GetUser:ShortString;
begin
  OpenPRPDEF;
  Result:=ohPRPDEF.ReadString('EMD','','User','');
end;

procedure TEmdPrp.SetUser(pValue:ShortString);
begin
  OpenPRPDEF;
  ohPRPDEF.WriteString('EMD','','User',pValue);
end;

function TEmdPrp.GetPasw:ShortString;
begin
  OpenPRPDEF;
  Result:=ohPRPDEF.ReadString('EMD','','Pasw','');
end;

procedure TEmdPrp.SetPasw(pValue:ShortString);
begin
  OpenPRPDEF;
  ohPRPDEF.WriteString('EMD','','Pasw',pValue);
end;

// ********************************* PUBLIC ************************************

end.


