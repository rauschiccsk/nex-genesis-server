unit tZIPREP;

interface

uses
  IcTypes, IcConv, NexPath, NexGlob, DocHand, 
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls,
  Dialogs, DB, NexBtrTable, DBTables, NexPxTable;

const
  ixPnZc='';
  ixOcZc='OcZc';
  ixProNam_='ProNam_';
  ixOrdCod='OrdCod';

type
  TZiprepTmp=class(TComponent)
    constructor Create;
    destructor Destroy; override;
  private
    oTmpTable: TNexPxTable;
    function GetCount:integer;
    function FieldExist (pFieldName:ShortString): boolean;
    // Pristup k databazovym poliam
    function GetProNum:longint;          procedure SetProNum (pValue:longint);
    function GetZipCod:Str10;            procedure SetZipCod (pValue:Str10);
    function GetProNam:Str60;            procedure SetProNam (pValue:Str60);
    function GetProNam_:Str60;           procedure SetProNam_ (pValue:Str60);
    function GetPgrNum:word;             procedure SetPgrNum (pValue:word);
    function GetOrdCod:Str30;            procedure SetOrdCod (pValue:Str30);
    function GetStkCod:Str15;            procedure SetStkCod (pValue:Str15);
    function GetMsuNam:Str10;            procedure SetMsuNam (pValue:Str10);
    function GetSalPrq:double;           procedure SetSalPrq (pValue:double);
    function GetSalAva:double;           procedure SetSalAva (pValue:double);
    function GetSalApc:double;           procedure SetSalApc (pValue:double);
  public
    // Elementarne databazove operacie
    function Eof:boolean;
    function Active:boolean;
    function LocPnZc (pProNum:longint;pZipCod:Str10):boolean;
    function LocOcZc (pOrdCod:Str30;pZipCod:Str10):boolean;
    function LocProNam_ (pProNam_:Str60):boolean;
    function LocOrdCod (pOrdCod:Str30):boolean;

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
    property ProNum:longint read GetProNum write SetProNum;
    property ZipCod:Str10 read GetZipCod write SetZipCod;
    property ProNam:Str60 read GetProNam write SetProNam;
    property ProNam_:Str60 read GetProNam_ write SetProNam_;
    property PgrNum:word read GetPgrNum write SetPgrNum;
    property OrdCod:Str30 read GetOrdCod write SetOrdCod;
    property StkCod:Str15 read GetStkCod write SetStkCod;
    property MsuNam:Str10 read GetMsuNam write SetMsuNam;
    property SalPrq:double read GetSalPrq write SetSalPrq;
    property SalAva:double read GetSalAva write SetSalAva;
    property SalApc:double read GetSalApc write SetSalApc;
  end;

implementation

constructor TZiprepTmp.Create;
begin
  oTmpTable:=TmpInit ('ZIPREP',Self);
end;

destructor TZiprepTmp.Destroy;
begin
  If oTmpTable.Active then oTmpTable.Close;
  FreeAndNil(oTmpTable);
end;

// *************************************** PRIVATE ********************************************

function TZiprepTmp.GetCount:integer;
begin
  Result:=oTmpTable.RecordCount;
end;

function TZiprepTmp.FieldExist(pFieldName:ShortString):boolean;
begin
  Result:=oTmpTable.FindField(pFieldName)<>nil;
end;

function TZiprepTmp.GetProNum:longint;
begin
  Result:=oTmpTable.FieldByName('ProNum').AsInteger;
end;

procedure TZiprepTmp.SetProNum(pValue:longint);
begin
  oTmpTable.FieldByName('ProNum').AsInteger:=pValue;
end;

function TZiprepTmp.GetZipCod:Str10;
begin
  Result:=oTmpTable.FieldByName('ZipCod').AsString;
end;

procedure TZiprepTmp.SetZipCod(pValue:Str10);
begin
  oTmpTable.FieldByName('ZipCod').AsString:=pValue;
end;

function TZiprepTmp.GetProNam:Str60;
begin
  Result:=oTmpTable.FieldByName('ProNam').AsString;
end;

procedure TZiprepTmp.SetProNam(pValue:Str60);
begin
  oTmpTable.FieldByName('ProNam').AsString:=pValue;
end;

function TZiprepTmp.GetProNam_:Str60;
begin
  Result:=oTmpTable.FieldByName('ProNam_').AsString;
end;

procedure TZiprepTmp.SetProNam_(pValue:Str60);
begin
  oTmpTable.FieldByName('ProNam_').AsString:=pValue;
end;

function TZiprepTmp.GetPgrNum:word;
begin
  Result:=oTmpTable.FieldByName('PgrNum').AsInteger;
end;

procedure TZiprepTmp.SetPgrNum(pValue:word);
begin
  oTmpTable.FieldByName('PgrNum').AsInteger:=pValue;
end;

function TZiprepTmp.GetOrdCod:Str30;
begin
  Result:=oTmpTable.FieldByName('OrdCod').AsString;
end;

procedure TZiprepTmp.SetOrdCod(pValue:Str30);
begin
  oTmpTable.FieldByName('OrdCod').AsString:=pValue;
end;

function TZiprepTmp.GetStkCod:Str15;
begin
  Result:=oTmpTable.FieldByName('StkCod').AsString;
end;

procedure TZiprepTmp.SetStkCod(pValue:Str15);
begin
  oTmpTable.FieldByName('StkCod').AsString:=pValue;
end;

function TZiprepTmp.GetMsuNam:Str10;
begin
  Result:=oTmpTable.FieldByName('MsuNam').AsString;
end;

procedure TZiprepTmp.SetMsuNam(pValue:Str10);
begin
  oTmpTable.FieldByName('MsuNam').AsString:=pValue;
end;

function TZiprepTmp.GetSalPrq:double;
begin
  Result:=oTmpTable.FieldByName('SalPrq').AsFloat;
end;

procedure TZiprepTmp.SetSalPrq(pValue:double);
begin
  oTmpTable.FieldByName('SalPrq').AsFloat:=pValue;
end;

function TZiprepTmp.GetSalAva:double;
begin
  Result:=oTmpTable.FieldByName('SalAva').AsFloat;
end;

procedure TZiprepTmp.SetSalAva(pValue:double);
begin
  oTmpTable.FieldByName('SalAva').AsFloat:=pValue;
end;

function TZiprepTmp.GetSalApc:double;
begin
  Result:=oTmpTable.FieldByName('SalApc').AsFloat;
end;

procedure TZiprepTmp.SetSalApc(pValue:double);
begin
  oTmpTable.FieldByName('SalApc').AsFloat:=pValue;
end;

// **************************************** PUBLIC ********************************************

function TZiprepTmp.Eof:boolean;
begin
  Result:=oTmpTable.Eof;
end;

function TZiprepTmp.Active:boolean;
begin
  Result:=oTmpTable.Active;
end;

function TZiprepTmp.LocPnZc(pProNum:longint;pZipCod:Str10):boolean;
begin
  SetIndex (ixPnZc);
  Result:=oTmpTable.FindKey([pProNum,pZipCod]);
end;

function TZiprepTmp.LocOcZc(pOrdCod:Str30;pZipCod:Str10):boolean;
begin
  SetIndex (ixOcZc);
  Result:=oTmpTable.FindKey([pOrdCod,pZipCod]);
end;

function TZiprepTmp.LocProNam_(pProNam_:Str60):boolean;
begin
  SetIndex (ixProNam_);
  Result:=oTmpTable.FindKey([pProNam_]);
end;

function TZiprepTmp.LocOrdCod(pOrdCod:Str30):boolean;
begin
  SetIndex (ixOrdCod);
  Result:=oTmpTable.FindKey([pOrdCod]);
end;

procedure TZiprepTmp.SetIndex(pIndexName:ShortString);
begin
  If oTmpTable.IndexName<>pIndexName then oTmpTable.IndexName:=pIndexName;
end;

procedure TZiprepTmp.Open;
begin
  oTmpTable.Open;
end;

procedure TZiprepTmp.Close;
begin
  If oTmpTable.Active then oTmpTable.Close;
end;

procedure TZiprepTmp.Prior;
begin
  oTmpTable.Prior;
end;

procedure TZiprepTmp.Next;
begin
  oTmpTable.Next;
end;

procedure TZiprepTmp.First;
begin
  oTmpTable.First;
end;

procedure TZiprepTmp.Last;
begin
  oTmpTable.Last;
end;

procedure TZiprepTmp.Insert;
begin
  oTmpTable.Insert;
end;

procedure TZiprepTmp.Edit;
begin
  oTmpTable.Edit;
end;

procedure TZiprepTmp.Post;
var mEdit:boolean;
begin
  oTmpTable.Post;
end;

procedure TZiprepTmp.Delete;
begin
  oTmpTable.Delete;
end;

procedure TZiprepTmp.SwapIndex;
begin
  oTmpTable.SwapIndex;
end;

procedure TZiprepTmp.RestIndex;
begin
  oTmpTable.RestoreIndex;
end;

procedure TZiprepTmp.SwapStatus;
begin
  oTmpTable.SwapStatus;
end;

procedure TZiprepTmp.RestStatus;
begin
  oTmpTable.RestoreStatus;
end;

procedure TZiprepTmp.EnabCont;
begin
  oTmpTable.EnableControls;
end;

procedure TZiprepTmp.DisabCont;
begin
  oTmpTable.DisableControls;
end;

end.
{MOD 2011001}
