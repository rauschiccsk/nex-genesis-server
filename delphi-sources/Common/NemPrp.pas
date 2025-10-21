unit NemPrp;

interface

uses
  IcTypes, IcConv, IcVariab, hPRPDEF,
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls,
  Dialogs, DB, NexBtrTable, DBTables, NexPxTable;

type
  TNemPrp=class
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

constructor TNemPrp.Create(phPRPDEF:TPrpdefHnd);
begin
  ohPRPDEF:=phPRPDEF;
end;

procedure TNemPrp.OpenPRPDEF;
begin
  If not ohPRPDEF.Active then ohPRPDEF.Open;;
end;

// ******************************** PRIVATE ************************************

function TNemPrp.GetEmlSnd:boolean;
begin
  OpenPRPDEF;
  Result:=ohPRPDEF.ReadBoolean('NEM','','EmlSnd',TRUE);
end;

procedure TNemPrp.SetEmlSnd(pValue:boolean);
begin
  OpenPRPDEF;
  ohPRPDEF.WriteBoolean('NEM','','EmlSnd',pValue);
end;

function TNemPrp.GetSmtp:ShortString;
begin
  OpenPRPDEF;
  Result:=ohPRPDEF.ReadString('NEM','','Smtp','');
end;

procedure TNemPrp.SetSmtp(pValue:ShortString);
begin
  OpenPRPDEF;
  ohPRPDEF.WriteString('NEM','','Smtp',pValue);
end;

function TNemPrp.GetPort:word;
begin
  OpenPRPDEF;
  Result:=ohPRPDEF.ReadInteger('NEM','','Port',25);
end;

procedure TNemPrp.SetPort(pValue:word);
begin
  OpenPRPDEF;
  ohPRPDEF.WriteInteger('NEM','','Port',pValue);
end;

function TNemPrp.GetUser:ShortString;
begin
  OpenPRPDEF;
  Result:=ohPRPDEF.ReadString('NEM','','User','');
end;

procedure TNemPrp.SetUser(pValue:ShortString);
begin
  OpenPRPDEF;
  ohPRPDEF.WriteString('NEM','','User',pValue);
end;

function TNemPrp.GetPasw:ShortString;
begin
  OpenPRPDEF;
  Result:=ohPRPDEF.ReadString('NEM','','Pasw','');
end;

procedure TNemPrp.SetPasw(pValue:ShortString);
begin
  OpenPRPDEF;
  ohPRPDEF.WriteString('NEM','','Pasw',pValue);
end;

// ********************************* PUBLIC ************************************

end.


