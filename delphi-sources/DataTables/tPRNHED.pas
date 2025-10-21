unit tPRNHED;

interface

uses
  IcTypes, IcConv, NexPath, NexGlob, DocHand, 
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls,
  Dialogs, DB, NexBtrTable, DBTables, NexPxTable;

const
  ixDocNum='';

type
  TPrnhedTmp=class(TComponent)
    constructor Create;
    destructor Destroy; override;
  private
    oTmpTable: TNexPxTable;
    function GetCount:integer;
    function FieldExist (pFieldName:ShortString): boolean;
    // Pristup k databazovym poliam
    function GetDocNum:Str12;            procedure SetDocNum (pValue:Str12);
    function GetDocDte:TDatetime;        procedure SetDocDte (pValue:TDatetime);
    function GetWriNum:word;             procedure SetWriNum (pValue:word);
    function GetWriNam:Str30;            procedure SetWriNam (pValue:Str30);
    function GetStkNum:word;             procedure SetStkNum (pValue:word);
    function GetStkNam:Str30;            procedure SetStkNam (pValue:Str30);
    function GetDocNam:Str20;            procedure SetDocNam (pValue:Str20);
    function GetParNum:longint;          procedure SetParNum (pValue:longint);
    function GetParNam:Str60;            procedure SetParNam (pValue:Str60);
    function GetRegNam:Str90;            procedure SetRegNam (pValue:Str90);
    function GetRegIno:Str10;            procedure SetRegIno (pValue:Str10);
    function GetRegTin:Str15;            procedure SetRegTin (pValue:Str15);
    function GetRegVin:Str15;            procedure SetRegVin (pValue:Str15);
    function GetRegAdr:Str60;            procedure SetRegAdr (pValue:Str60);
    function GetRegCtc:Str3;             procedure SetRegCtc (pValue:Str3);
    function GetRegCtn:Str30;            procedure SetRegCtn (pValue:Str30);
    function GetRegZip:Str15;            procedure SetRegZip (pValue:Str15);
    function GetRegStc:Str2;             procedure SetRegStc (pValue:Str2);
    function GetRegStn:Str30;            procedure SetRegStn (pValue:Str30);
    function GetOwnNam:Str90;            procedure SetOwnNam (pValue:Str90);
    function GetOwnIno:Str10;            procedure SetOwnIno (pValue:Str10);
    function GetOwnTin:Str15;            procedure SetOwnTin (pValue:Str15);
    function GetOwnVin:Str15;            procedure SetOwnVin (pValue:Str15);
    function GetOwnAdr:Str60;            procedure SetOwnAdr (pValue:Str60);
    function GetOwnCtc:Str3;             procedure SetOwnCtc (pValue:Str3);
    function GetOwnCtn:Str30;            procedure SetOwnCtn (pValue:Str30);
    function GetOwnZip:Str10;            procedure SetOwnZip (pValue:Str10);
    function GetOwnStc:Str2;             procedure SetOwnStc (pValue:Str2);
    function GetOwnStn:Str30;            procedure SetOwnStn (pValue:Str30);
    function GetOwnTel:Str20;            procedure SetOwnTel (pValue:Str20);
    function GetOwnFax:Str20;            procedure SetOwnFax (pValue:Str20);
    function GetOwnEml:Str30;            procedure SetOwnEml (pValue:Str30);
    function GetBegDte:TDatetime;        procedure SetBegDte (pValue:TDatetime);
    function GetEndDte:TDatetime;        procedure SetEndDte (pValue:TDatetime);
    function GetDlrNum:word;             procedure SetDlrNum (pValue:word);
    function GetDlrNam:Str30;            procedure SetDlrNam (pValue:Str30);
  public
    // Elementarne databazove operacie
    function Eof:boolean;
    function Active:boolean;
    function LocDocNum (pDocNum:Str12):boolean;

    procedure SetIndex(pIndexName:ShortString);
    procedure Open;
    procedure Close;
    procedure Prior; virtual;
    procedure Next; virtual;
    procedure First; virtual;
    procedure Last; virtual;
    procedure Insert; virtual;
    procedure Edit; virtual;
    procedure Post; virtual;
    procedure Delete; virtual;
    procedure SwapIndex;
    procedure RestIndex;
    procedure SwapStatus;
    procedure RestStatus;
    procedure EnabCont;
    procedure DisabCont;
  published
    property TmpTable:TNexPxTable read oTmpTable write oTmpTable;
    property Count:integer read GetCount;
    property DocNum:Str12 read GetDocNum write SetDocNum;
    property DocDte:TDatetime read GetDocDte write SetDocDte;
    property WriNum:word read GetWriNum write SetWriNum;
    property WriNam:Str30 read GetWriNam write SetWriNam;
    property StkNum:word read GetStkNum write SetStkNum;
    property StkNam:Str30 read GetStkNam write SetStkNam;
    property DocNam:Str20 read GetDocNam write SetDocNam;
    property ParNum:longint read GetParNum write SetParNum;
    property ParNam:Str60 read GetParNam write SetParNam;
    property RegNam:Str90 read GetRegNam write SetRegNam;
    property RegIno:Str10 read GetRegIno write SetRegIno;
    property RegTin:Str15 read GetRegTin write SetRegTin;
    property RegVin:Str15 read GetRegVin write SetRegVin;
    property RegAdr:Str60 read GetRegAdr write SetRegAdr;
    property RegCtc:Str3 read GetRegCtc write SetRegCtc;
    property RegCtn:Str30 read GetRegCtn write SetRegCtn;
    property RegZip:Str15 read GetRegZip write SetRegZip;
    property RegStc:Str2 read GetRegStc write SetRegStc;
    property RegStn:Str30 read GetRegStn write SetRegStn;
    property OwnNam:Str90 read GetOwnNam write SetOwnNam;
    property OwnIno:Str10 read GetOwnIno write SetOwnIno;
    property OwnTin:Str15 read GetOwnTin write SetOwnTin;
    property OwnVin:Str15 read GetOwnVin write SetOwnVin;
    property OwnAdr:Str60 read GetOwnAdr write SetOwnAdr;
    property OwnCtc:Str3 read GetOwnCtc write SetOwnCtc;
    property OwnCtn:Str30 read GetOwnCtn write SetOwnCtn;
    property OwnZip:Str10 read GetOwnZip write SetOwnZip;
    property OwnStc:Str2 read GetOwnStc write SetOwnStc;
    property OwnStn:Str30 read GetOwnStn write SetOwnStn;
    property OwnTel:Str20 read GetOwnTel write SetOwnTel;
    property OwnFax:Str20 read GetOwnFax write SetOwnFax;
    property OwnEml:Str30 read GetOwnEml write SetOwnEml;
    property BegDte:TDatetime read GetBegDte write SetBegDte;
    property EndDte:TDatetime read GetEndDte write SetEndDte;
    property DlrNum:word read GetDlrNum write SetDlrNum;
    property DlrNam:Str30 read GetDlrNam write SetDlrNam;
  end;

implementation

constructor TPrnhedTmp.Create;
begin
  oTmpTable:=TmpInit ('PRNHED',Self);
end;

destructor TPrnhedTmp.Destroy;
begin
  If oTmpTable.Active then oTmpTable.Close;
  FreeAndNil(oTmpTable);
end;

// *************************************** PRIVATE ********************************************

function TPrnhedTmp.GetCount:integer;
begin
  Result:=oTmpTable.RecordCount;
end;

function TPrnhedTmp.FieldExist(pFieldName:ShortString):boolean;
begin
  Result:=oTmpTable.FindField(pFieldName)<>nil;
end;

function TPrnhedTmp.GetDocNum:Str12;
begin
  Result:=oTmpTable.FieldByName('DocNum').AsString;
end;

procedure TPrnhedTmp.SetDocNum(pValue:Str12);
begin
  oTmpTable.FieldByName('DocNum').AsString:=pValue;
end;

function TPrnhedTmp.GetDocDte:TDatetime;
begin
  Result:=oTmpTable.FieldByName('DocDte').AsDateTime;
end;

procedure TPrnhedTmp.SetDocDte(pValue:TDatetime);
begin
  oTmpTable.FieldByName('DocDte').AsDateTime:=pValue;
end;

function TPrnhedTmp.GetWriNum:word;
begin
  Result:=oTmpTable.FieldByName('WriNum').AsInteger;
end;

procedure TPrnhedTmp.SetWriNum(pValue:word);
begin
  oTmpTable.FieldByName('WriNum').AsInteger:=pValue;
end;

function TPrnhedTmp.GetWriNam:Str30;
begin
  Result:=oTmpTable.FieldByName('WriNam').AsString;
end;

procedure TPrnhedTmp.SetWriNam(pValue:Str30);
begin
  oTmpTable.FieldByName('WriNam').AsString:=pValue;
end;

function TPrnhedTmp.GetStkNum:word;
begin
  Result:=oTmpTable.FieldByName('StkNum').AsInteger;
end;

procedure TPrnhedTmp.SetStkNum(pValue:word);
begin
  oTmpTable.FieldByName('StkNum').AsInteger:=pValue;
end;

function TPrnhedTmp.GetStkNam:Str30;
begin
  Result:=oTmpTable.FieldByName('StkNam').AsString;
end;

procedure TPrnhedTmp.SetStkNam(pValue:Str30);
begin
  oTmpTable.FieldByName('StkNam').AsString:=pValue;
end;

function TPrnhedTmp.GetDocNam:Str20;
begin
  Result:=oTmpTable.FieldByName('DocNam').AsString;
end;

procedure TPrnhedTmp.SetDocNam(pValue:Str20);
begin
  oTmpTable.FieldByName('DocNam').AsString:=pValue;
end;

function TPrnhedTmp.GetParNum:longint;
begin
  Result:=oTmpTable.FieldByName('ParNum').AsInteger;
end;

procedure TPrnhedTmp.SetParNum(pValue:longint);
begin
  oTmpTable.FieldByName('ParNum').AsInteger:=pValue;
end;

function TPrnhedTmp.GetParNam:Str60;
begin
  Result:=oTmpTable.FieldByName('ParNam').AsString;
end;

procedure TPrnhedTmp.SetParNam(pValue:Str60);
begin
  oTmpTable.FieldByName('ParNam').AsString:=pValue;
end;

function TPrnhedTmp.GetRegNam:Str90;
begin
  Result:=oTmpTable.FieldByName('RegNam').AsString;
end;

procedure TPrnhedTmp.SetRegNam(pValue:Str90);
begin
  oTmpTable.FieldByName('RegNam').AsString:=pValue;
end;

function TPrnhedTmp.GetRegIno:Str10;
begin
  Result:=oTmpTable.FieldByName('RegIno').AsString;
end;

procedure TPrnhedTmp.SetRegIno(pValue:Str10);
begin
  oTmpTable.FieldByName('RegIno').AsString:=pValue;
end;

function TPrnhedTmp.GetRegTin:Str15;
begin
  Result:=oTmpTable.FieldByName('RegTin').AsString;
end;

procedure TPrnhedTmp.SetRegTin(pValue:Str15);
begin
  oTmpTable.FieldByName('RegTin').AsString:=pValue;
end;

function TPrnhedTmp.GetRegVin:Str15;
begin
  Result:=oTmpTable.FieldByName('RegVin').AsString;
end;

procedure TPrnhedTmp.SetRegVin(pValue:Str15);
begin
  oTmpTable.FieldByName('RegVin').AsString:=pValue;
end;

function TPrnhedTmp.GetRegAdr:Str60;
begin
  Result:=oTmpTable.FieldByName('RegAdr').AsString;
end;

procedure TPrnhedTmp.SetRegAdr(pValue:Str60);
begin
  oTmpTable.FieldByName('RegAdr').AsString:=pValue;
end;

function TPrnhedTmp.GetRegCtc:Str3;
begin
  Result:=oTmpTable.FieldByName('RegCtc').AsString;
end;

procedure TPrnhedTmp.SetRegCtc(pValue:Str3);
begin
  oTmpTable.FieldByName('RegCtc').AsString:=pValue;
end;

function TPrnhedTmp.GetRegCtn:Str30;
begin
  Result:=oTmpTable.FieldByName('RegCtn').AsString;
end;

procedure TPrnhedTmp.SetRegCtn(pValue:Str30);
begin
  oTmpTable.FieldByName('RegCtn').AsString:=pValue;
end;

function TPrnhedTmp.GetRegZip:Str15;
begin
  Result:=oTmpTable.FieldByName('RegZip').AsString;
end;

procedure TPrnhedTmp.SetRegZip(pValue:Str15);
begin
  oTmpTable.FieldByName('RegZip').AsString:=pValue;
end;

function TPrnhedTmp.GetRegStc:Str2;
begin
  Result:=oTmpTable.FieldByName('RegStc').AsString;
end;

procedure TPrnhedTmp.SetRegStc(pValue:Str2);
begin
  oTmpTable.FieldByName('RegStc').AsString:=pValue;
end;

function TPrnhedTmp.GetRegStn:Str30;
begin
  Result:=oTmpTable.FieldByName('RegStn').AsString;
end;

procedure TPrnhedTmp.SetRegStn(pValue:Str30);
begin
  oTmpTable.FieldByName('RegStn').AsString:=pValue;
end;

function TPrnhedTmp.GetOwnNam:Str90;
begin
  Result:=oTmpTable.FieldByName('OwnNam').AsString;
end;

procedure TPrnhedTmp.SetOwnNam(pValue:Str90);
begin
  oTmpTable.FieldByName('OwnNam').AsString:=pValue;
end;

function TPrnhedTmp.GetOwnIno:Str10;
begin
  Result:=oTmpTable.FieldByName('OwnIno').AsString;
end;

procedure TPrnhedTmp.SetOwnIno(pValue:Str10);
begin
  oTmpTable.FieldByName('OwnIno').AsString:=pValue;
end;

function TPrnhedTmp.GetOwnTin:Str15;
begin
  Result:=oTmpTable.FieldByName('OwnTin').AsString;
end;

procedure TPrnhedTmp.SetOwnTin(pValue:Str15);
begin
  oTmpTable.FieldByName('OwnTin').AsString:=pValue;
end;

function TPrnhedTmp.GetOwnVin:Str15;
begin
  Result:=oTmpTable.FieldByName('OwnVin').AsString;
end;

procedure TPrnhedTmp.SetOwnVin(pValue:Str15);
begin
  oTmpTable.FieldByName('OwnVin').AsString:=pValue;
end;

function TPrnhedTmp.GetOwnAdr:Str60;
begin
  Result:=oTmpTable.FieldByName('OwnAdr').AsString;
end;

procedure TPrnhedTmp.SetOwnAdr(pValue:Str60);
begin
  oTmpTable.FieldByName('OwnAdr').AsString:=pValue;
end;

function TPrnhedTmp.GetOwnCtc:Str3;
begin
  Result:=oTmpTable.FieldByName('OwnCtc').AsString;
end;

procedure TPrnhedTmp.SetOwnCtc(pValue:Str3);
begin
  oTmpTable.FieldByName('OwnCtc').AsString:=pValue;
end;

function TPrnhedTmp.GetOwnCtn:Str30;
begin
  Result:=oTmpTable.FieldByName('OwnCtn').AsString;
end;

procedure TPrnhedTmp.SetOwnCtn(pValue:Str30);
begin
  oTmpTable.FieldByName('OwnCtn').AsString:=pValue;
end;

function TPrnhedTmp.GetOwnZip:Str10;
begin
  Result:=oTmpTable.FieldByName('OwnZip').AsString;
end;

procedure TPrnhedTmp.SetOwnZip(pValue:Str10);
begin
  oTmpTable.FieldByName('OwnZip').AsString:=pValue;
end;

function TPrnhedTmp.GetOwnStc:Str2;
begin
  Result:=oTmpTable.FieldByName('OwnStc').AsString;
end;

procedure TPrnhedTmp.SetOwnStc(pValue:Str2);
begin
  oTmpTable.FieldByName('OwnStc').AsString:=pValue;
end;

function TPrnhedTmp.GetOwnStn:Str30;
begin
  Result:=oTmpTable.FieldByName('OwnStn').AsString;
end;

procedure TPrnhedTmp.SetOwnStn(pValue:Str30);
begin
  oTmpTable.FieldByName('OwnStn').AsString:=pValue;
end;

function TPrnhedTmp.GetOwnTel:Str20;
begin
  Result:=oTmpTable.FieldByName('OwnTel').AsString;
end;

procedure TPrnhedTmp.SetOwnTel(pValue:Str20);
begin
  oTmpTable.FieldByName('OwnTel').AsString:=pValue;
end;

function TPrnhedTmp.GetOwnFax:Str20;
begin
  Result:=oTmpTable.FieldByName('OwnFax').AsString;
end;

procedure TPrnhedTmp.SetOwnFax(pValue:Str20);
begin
  oTmpTable.FieldByName('OwnFax').AsString:=pValue;
end;

function TPrnhedTmp.GetOwnEml:Str30;
begin
  Result:=oTmpTable.FieldByName('OwnEml').AsString;
end;

procedure TPrnhedTmp.SetOwnEml(pValue:Str30);
begin
  oTmpTable.FieldByName('OwnEml').AsString:=pValue;
end;

function TPrnhedTmp.GetBegDte:TDatetime;
begin
  Result:=oTmpTable.FieldByName('BegDte').AsDateTime;
end;

procedure TPrnhedTmp.SetBegDte(pValue:TDatetime);
begin
  oTmpTable.FieldByName('BegDte').AsDateTime:=pValue;
end;

function TPrnhedTmp.GetEndDte:TDatetime;
begin
  Result:=oTmpTable.FieldByName('EndDte').AsDateTime;
end;

procedure TPrnhedTmp.SetEndDte(pValue:TDatetime);
begin
  oTmpTable.FieldByName('EndDte').AsDateTime:=pValue;
end;

function TPrnhedTmp.GetDlrNum:word;
begin
  Result:=oTmpTable.FieldByName('DlrNum').AsInteger;
end;

procedure TPrnhedTmp.SetDlrNum(pValue:word);
begin
  oTmpTable.FieldByName('DlrNum').AsInteger:=pValue;
end;

function TPrnhedTmp.GetDlrNam:Str30;
begin
  Result:=oTmpTable.FieldByName('DlrNam').AsString;
end;

procedure TPrnhedTmp.SetDlrNam(pValue:Str30);
begin
  oTmpTable.FieldByName('DlrNam').AsString:=pValue;
end;

// **************************************** PUBLIC ********************************************

function TPrnhedTmp.Eof:boolean;
begin
  Result:=oTmpTable.Eof;
end;

function TPrnhedTmp.Active:boolean;
begin
  Result:=oTmpTable.Active;
end;

function TPrnhedTmp.LocDocNum(pDocNum:Str12):boolean;
begin
  SetIndex (ixDocNum);
  Result:=oTmpTable.FindKey([pDocNum]);
end;

procedure TPrnhedTmp.SetIndex(pIndexName:ShortString);
begin
  If oTmpTable.IndexName<>pIndexName then oTmpTable.IndexName:=pIndexName;
end;

procedure TPrnhedTmp.Open;
begin
  oTmpTable.Open;
end;

procedure TPrnhedTmp.Close;
begin
  If oTmpTable.Active then oTmpTable.Close;
end;

procedure TPrnhedTmp.Prior;
begin
  oTmpTable.Prior;
end;

procedure TPrnhedTmp.Next;
begin
  oTmpTable.Next;
end;

procedure TPrnhedTmp.First;
begin
  oTmpTable.First;
end;

procedure TPrnhedTmp.Last;
begin
  oTmpTable.Last;
end;

procedure TPrnhedTmp.Insert;
begin
  oTmpTable.Insert;
end;

procedure TPrnhedTmp.Edit;
begin
  oTmpTable.Edit;
end;

procedure TPrnhedTmp.Post;
var mEdit:boolean;
begin
  oTmpTable.Post;
end;

procedure TPrnhedTmp.Delete;
begin
  oTmpTable.Delete;
end;

procedure TPrnhedTmp.SwapIndex;
begin
  oTmpTable.SwapIndex;
end;

procedure TPrnhedTmp.RestIndex;
begin
  oTmpTable.RestoreIndex;
end;

procedure TPrnhedTmp.SwapStatus;
begin
  oTmpTable.SwapStatus;
end;

procedure TPrnhedTmp.RestStatus;
begin
  oTmpTable.RestoreStatus;
end;

procedure TPrnhedTmp.EnabCont;
begin
  oTmpTable.EnableControls;
end;

procedure TPrnhedTmp.DisabCont;
begin
  oTmpTable.DisableControls;
end;

end.
{MOD 2011001}
