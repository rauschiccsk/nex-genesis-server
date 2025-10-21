unit tSHDPAR;

interface

uses
  IcTypes, IcConv, NexPath, NexGlob, DocHand, 
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls,
  Dialogs, DB, NexBtrTable, DBTables, NexPxTable;

const
  ixParNum='';
  ixParNam_='ParNam_';
  ixPrfPrc='PrfPrc';
  ixDscPrc='DscPrc';

type
  TShdparTmp=class(TComponent)
    constructor Create;
    destructor Destroy; override;
  private
    oTmpTable: TNexPxTable;
    function GetCount:integer;
    function FieldExist (pFieldName:ShortString): boolean;
    // Pristup k databazovym poliam
    function GetParNum:longint;          procedure SetParNum (pValue:longint);
    function GetParNam:Str60;            procedure SetParNam (pValue:Str60);
    function GetParNam_:Str60;           procedure SetParNam_ (pValue:Str60);
    function GetStkAva:double;           procedure SetStkAva (pValue:double);
    function GetPrfPrc:double;           procedure SetPrfPrc (pValue:double);
    function GetPrfAva:double;           procedure SetPrfAva (pValue:double);
    function GetGscAva:double;           procedure SetGscAva (pValue:double);
    function GetSecAva:double;           procedure SetSecAva (pValue:double);
    function GetSalAva:double;           procedure SetSalAva (pValue:double);
    function GetSalBva:double;           procedure SetSalBva (pValue:double);
    function GetDscPrc:double;           procedure SetDscPrc (pValue:double);
    function GetDscAva:double;           procedure SetDscAva (pValue:double);
  public
    // Elementarne databazove operacie
    function Eof:boolean;
    function Active:boolean;
    function LocParNum (pParNum:longint):boolean;
    function LocParNam_ (pParNam_:Str60):boolean;
    function LocPrfPrc (pPrfPrc:double):boolean;
    function LocDscPrc (pDscPrc:double):boolean;

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
    property ParNum:longint read GetParNum write SetParNum;
    property ParNam:Str60 read GetParNam write SetParNam;
    property ParNam_:Str60 read GetParNam_ write SetParNam_;
    property StkAva:double read GetStkAva write SetStkAva;
    property PrfPrc:double read GetPrfPrc write SetPrfPrc;
    property PrfAva:double read GetPrfAva write SetPrfAva;
    property GscAva:double read GetGscAva write SetGscAva;
    property SecAva:double read GetSecAva write SetSecAva;
    property SalAva:double read GetSalAva write SetSalAva;
    property SalBva:double read GetSalBva write SetSalBva;
    property DscPrc:double read GetDscPrc write SetDscPrc;
    property DscAva:double read GetDscAva write SetDscAva;
  end;

implementation

constructor TShdparTmp.Create;
begin
  oTmpTable:=TmpInit ('SHDPAR',Self);
end;

destructor TShdparTmp.Destroy;
begin
  If oTmpTable.Active then oTmpTable.Close;
  FreeAndNil(oTmpTable);
end;

// *************************************** PRIVATE ********************************************

function TShdparTmp.GetCount:integer;
begin
  Result:=oTmpTable.RecordCount;
end;

function TShdparTmp.FieldExist(pFieldName:ShortString):boolean;
begin
  Result:=oTmpTable.FindField(pFieldName)<>nil;
end;

function TShdparTmp.GetParNum:longint;
begin
  Result:=oTmpTable.FieldByName('ParNum').AsInteger;
end;

procedure TShdparTmp.SetParNum(pValue:longint);
begin
  oTmpTable.FieldByName('ParNum').AsInteger:=pValue;
end;

function TShdparTmp.GetParNam:Str60;
begin
  Result:=oTmpTable.FieldByName('ParNam').AsString;
end;

procedure TShdparTmp.SetParNam(pValue:Str60);
begin
  oTmpTable.FieldByName('ParNam').AsString:=pValue;
end;

function TShdparTmp.GetParNam_:Str60;
begin
  Result:=oTmpTable.FieldByName('ParNam_').AsString;
end;

procedure TShdparTmp.SetParNam_(pValue:Str60);
begin
  oTmpTable.FieldByName('ParNam_').AsString:=pValue;
end;

function TShdparTmp.GetStkAva:double;
begin
  Result:=oTmpTable.FieldByName('StkAva').AsFloat;
end;

procedure TShdparTmp.SetStkAva(pValue:double);
begin
  oTmpTable.FieldByName('StkAva').AsFloat:=pValue;
end;

function TShdparTmp.GetPrfPrc:double;
begin
  Result:=oTmpTable.FieldByName('PrfPrc').AsFloat;
end;

procedure TShdparTmp.SetPrfPrc(pValue:double);
begin
  oTmpTable.FieldByName('PrfPrc').AsFloat:=pValue;
end;

function TShdparTmp.GetPrfAva:double;
begin
  Result:=oTmpTable.FieldByName('PrfAva').AsFloat;
end;

procedure TShdparTmp.SetPrfAva(pValue:double);
begin
  oTmpTable.FieldByName('PrfAva').AsFloat:=pValue;
end;

function TShdparTmp.GetGscAva:double;
begin
  Result:=oTmpTable.FieldByName('GscAva').AsFloat;
end;

procedure TShdparTmp.SetGscAva(pValue:double);
begin
  oTmpTable.FieldByName('GscAva').AsFloat:=pValue;
end;

function TShdparTmp.GetSecAva:double;
begin
  Result:=oTmpTable.FieldByName('SecAva').AsFloat;
end;

procedure TShdparTmp.SetSecAva(pValue:double);
begin
  oTmpTable.FieldByName('SecAva').AsFloat:=pValue;
end;

function TShdparTmp.GetSalAva:double;
begin
  Result:=oTmpTable.FieldByName('SalAva').AsFloat;
end;

procedure TShdparTmp.SetSalAva(pValue:double);
begin
  oTmpTable.FieldByName('SalAva').AsFloat:=pValue;
end;

function TShdparTmp.GetSalBva:double;
begin
  Result:=oTmpTable.FieldByName('SalBva').AsFloat;
end;

procedure TShdparTmp.SetSalBva(pValue:double);
begin
  oTmpTable.FieldByName('SalBva').AsFloat:=pValue;
end;

function TShdparTmp.GetDscPrc:double;
begin
  Result:=oTmpTable.FieldByName('DscPrc').AsFloat;
end;

procedure TShdparTmp.SetDscPrc(pValue:double);
begin
  oTmpTable.FieldByName('DscPrc').AsFloat:=pValue;
end;

function TShdparTmp.GetDscAva:double;
begin
  Result:=oTmpTable.FieldByName('DscAva').AsFloat;
end;

procedure TShdparTmp.SetDscAva(pValue:double);
begin
  oTmpTable.FieldByName('DscAva').AsFloat:=pValue;
end;

// **************************************** PUBLIC ********************************************

function TShdparTmp.Eof:boolean;
begin
  Result:=oTmpTable.Eof;
end;

function TShdparTmp.Active:boolean;
begin
  Result:=oTmpTable.Active;
end;

function TShdparTmp.LocParNum(pParNum:longint):boolean;
begin
  SetIndex (ixParNum);
  Result:=oTmpTable.FindKey([pParNum]);
end;

function TShdparTmp.LocParNam_(pParNam_:Str60):boolean;
begin
  SetIndex (ixParNam_);
  Result:=oTmpTable.FindKey([pParNam_]);
end;

function TShdparTmp.LocPrfPrc(pPrfPrc:double):boolean;
begin
  SetIndex (ixPrfPrc);
  Result:=oTmpTable.FindKey([pPrfPrc]);
end;

function TShdparTmp.LocDscPrc(pDscPrc:double):boolean;
begin
  SetIndex (ixDscPrc);
  Result:=oTmpTable.FindKey([pDscPrc]);
end;

procedure TShdparTmp.SetIndex(pIndexName:ShortString);
begin
  If oTmpTable.IndexName<>pIndexName then oTmpTable.IndexName:=pIndexName;
end;

procedure TShdparTmp.Open;
begin
  oTmpTable.Open;
end;

procedure TShdparTmp.Close;
begin
  If oTmpTable.Active then oTmpTable.Close;
end;

procedure TShdparTmp.Prior;
begin
  oTmpTable.Prior;
end;

procedure TShdparTmp.Next;
begin
  oTmpTable.Next;
end;

procedure TShdparTmp.First;
begin
  oTmpTable.First;
end;

procedure TShdparTmp.Last;
begin
  oTmpTable.Last;
end;

procedure TShdparTmp.Insert;
begin
  oTmpTable.Insert;
end;

procedure TShdparTmp.Edit;
begin
  oTmpTable.Edit;
end;

procedure TShdparTmp.Post;
var mEdit:boolean;
begin
  oTmpTable.Post;
end;

procedure TShdparTmp.Delete;
begin
  oTmpTable.Delete;
end;

procedure TShdparTmp.SwapIndex;
begin
  oTmpTable.SwapIndex;
end;

procedure TShdparTmp.RestIndex;
begin
  oTmpTable.RestoreIndex;
end;

procedure TShdparTmp.SwapStatus;
begin
  oTmpTable.SwapStatus;
end;

procedure TShdparTmp.RestStatus;
begin
  oTmpTable.RestoreStatus;
end;

procedure TShdparTmp.EnabCont;
begin
  oTmpTable.EnableControls;
end;

procedure TShdparTmp.DisabCont;
begin
  oTmpTable.DisableControls;
end;

end.
{MOD 2011001}
