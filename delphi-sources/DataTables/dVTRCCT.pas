unit dVTRCCT;

interface

uses
  IcTypes, IcConv, NexPath, NexGlob,
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls,
  Dialogs, DB, NexBtrTable, DBTables, NexPxTable;

const
  ixDyCn='DyCn';
  ixDyCnInCc='DyCnInCc';

type
  TVtrcctDat=class(TComponent)
    constructor Create; overload;
    destructor Destroy; override;
  private
    oTable:TNexBtrTable;
    function GetCount:integer;
    function FieldExist(pFieldName:Str20):boolean;
    // Prístup k databázovým poliam
    function GetDocYer:Str2;             procedure SetDocYer(pValue:Str2);
    function GetClsNum:word;             procedure SetClsNum(pValue:word);
    function GetIndNum:Str12;            procedure SetIndNum(pValue:Str12);
    function GetCctCod:Str10;            procedure SetCctCod(pValue:Str10);
    function GetCctPrq:double;           procedure SetCctPrq(pValue:double);
    function GetCctVal:double;           procedure SetCctVal(pValue:double);
    function GetMsuNam:Str10;            procedure SetMsuNam(pValue:Str10);
    function GetIneNum:Str12;            procedure SetIneNum(pValue:Str12);
    function GetRegVin:Str15;            procedure SetRegVin(pValue:Str15);
    function GetVatDte:TDatetime;        procedure SetVatDte(pValue:TDatetime);
  public
    constructor Create(pPath:ShortString); overload;
    // Základné databázové operácie
    function Eof:boolean;
    function IsFirst:boolean;
    function IsLast:boolean;
    function Active:boolean;
    function ActPos:longint;
    function GotoPos(pActPos:longint):boolean;
    function FieldNum(pFieldName:Str20):Str3;
    function LocDyCn(pDocYer:Str2;pClsNum:word):boolean;
    function LocDyCnInCc(pDocYer:Str2;pClsNum:word;pIndNum:Str12;pCctCod:Str10):boolean;
    function NearDyCn(pDocYer:Str2;pClsNum:word):boolean;
    function NearDyCnInCc(pDocYer:Str2;pClsNum:word;pIndNum:Str12;pCctCod:Str10):boolean;

    procedure SetIndex(pIndexName:Str20);
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
    property Table:TNexBtrTable read oTable;
    property Count:integer read GetCount;
    // Prístup k databázovým poliam
    property DocYer:Str2 read GetDocYer write SetDocYer;
    property ClsNum:word read GetClsNum write SetClsNum;
    property IndNum:Str12 read GetIndNum write SetIndNum;
    property CctCod:Str10 read GetCctCod write SetCctCod;
    property CctPrq:double read GetCctPrq write SetCctPrq;
    property CctVal:double read GetCctVal write SetCctVal;
    property MsuNam:Str10 read GetMsuNam write SetMsuNam;
    property IneNum:Str12 read GetIneNum write SetIneNum;
    property RegVin:Str15 read GetRegVin write SetRegVin;
    property VatDte:TDatetime read GetVatDte write SetVatDte;
  end;

implementation

constructor TVtrcctDat.Create;
begin
  oTable:=DatInit('VTRCCT',gPath.LdgPath,Self);
end;

constructor TVtrcctDat.Create(pPath:ShortString);
begin
  oTable:=DatInit('VTRCCT',pPath,Self);
end;

destructor TVtrcctDat.Destroy;
begin
  oTable.Close;
  FreeAndNil(oTable);
end;

// *************************************** PRIVATE ********************************************

function TVtrcctDat.GetCount:integer;
begin
  Open;
  Result:=oTable.RecordCount;
end;

function TVtrcctDat.FieldExist(pFieldName:Str20):boolean;
begin
  Result:=oTable.FindField(pFieldName)<>nil;
end;

// ********************* FIELDS *********************

function TVtrcctDat.GetDocYer:Str2;
begin
  Result:=oTable.FieldByName('DocYer').AsString;
end;

procedure TVtrcctDat.SetDocYer(pValue:Str2);
begin
  oTable.FieldByName('DocYer').AsString:=pValue;
end;

function TVtrcctDat.GetClsNum:word;
begin
  Result:=oTable.FieldByName('ClsNum').AsInteger;
end;

procedure TVtrcctDat.SetClsNum(pValue:word);
begin
  oTable.FieldByName('ClsNum').AsInteger:=pValue;
end;

function TVtrcctDat.GetIndNum:Str12;
begin
  Result:=oTable.FieldByName('IndNum').AsString;
end;

procedure TVtrcctDat.SetIndNum(pValue:Str12);
begin
  oTable.FieldByName('IndNum').AsString:=pValue;
end;

function TVtrcctDat.GetCctCod:Str10;
begin
  Result:=oTable.FieldByName('CctCod').AsString;
end;

procedure TVtrcctDat.SetCctCod(pValue:Str10);
begin
  oTable.FieldByName('CctCod').AsString:=pValue;
end;

function TVtrcctDat.GetCctPrq:double;
begin
  Result:=oTable.FieldByName('CctPrq').AsFloat;
end;

procedure TVtrcctDat.SetCctPrq(pValue:double);
begin
  oTable.FieldByName('CctPrq').AsFloat:=pValue;
end;

function TVtrcctDat.GetCctVal:double;
begin
  Result:=oTable.FieldByName('CctVal').AsFloat;
end;

procedure TVtrcctDat.SetCctVal(pValue:double);
begin
  oTable.FieldByName('CctVal').AsFloat:=pValue;
end;

function TVtrcctDat.GetMsuNam:Str10;
begin
  Result:=oTable.FieldByName('MsuNam').AsString;
end;

procedure TVtrcctDat.SetMsuNam(pValue:Str10);
begin
  oTable.FieldByName('MsuNam').AsString:=pValue;
end;

function TVtrcctDat.GetIneNum:Str12;
begin
  Result:=oTable.FieldByName('IneNum').AsString;
end;

procedure TVtrcctDat.SetIneNum(pValue:Str12);
begin
  oTable.FieldByName('IneNum').AsString:=pValue;
end;

function TVtrcctDat.GetRegVin:Str15;
begin
  Result:=oTable.FieldByName('RegVin').AsString;
end;

procedure TVtrcctDat.SetRegVin(pValue:Str15);
begin
  oTable.FieldByName('RegVin').AsString:=pValue;
end;

function TVtrcctDat.GetVatDte:TDatetime;
begin
  Result:=oTable.FieldByName('VatDte').AsDateTime;
end;

procedure TVtrcctDat.SetVatDte(pValue:TDatetime);
begin
  oTable.FieldByName('VatDte').AsDateTime:=pValue;
end;

// **************************************** PUBLIC ********************************************

function TVtrcctDat.Eof:boolean;
begin
  Result:=oTable.Eof;
end;

function TVtrcctDat.IsFirst:boolean;
begin
  Open;
  Result:=oTable.Bof;
end;

function TVtrcctDat.IsLast:boolean;
begin
  Open;
  Result:=oTable.Eof;
end;

function TVtrcctDat.Active:boolean;
begin
  Result:=oTable.Active;
end;

function TVtrcctDat.ActPos:longint;
begin
  Result:=oTable.ActPos;
end;

function TVtrcctDat.GotoPos(pActPos:longint): boolean;
begin
  Open;
  If oTable.Filtered and (Count=0) then begin
    oTable.Filtered:=FALSE;
    oTable.Filtered:=TRUE;
  end;
  oTable.Refresh;
  Result:=oTable.GotoPos(pActPos);
end;

function TVtrcctDat.FieldNum(pFieldName:Str20):Str3;
begin
  Open;
  Result:=StrInt(oTable.FieldByName(pFieldName).FieldNo-1,0);
end;

function TVtrcctDat.LocDyCn(pDocYer:Str2;pClsNum:word):boolean;
begin
  SetIndex(ixDyCn);
  Result:=oTable.FindKey([pDocYer,pClsNum]);
end;

function TVtrcctDat.LocDyCnInCc(pDocYer:Str2;pClsNum:word;pIndNum:Str12;pCctCod:Str10):boolean;
begin
  SetIndex(ixDyCnInCc);
  Result:=oTable.FindKey([pDocYer,pClsNum,pIndNum,pCctCod]);
end;

function TVtrcctDat.NearDyCn(pDocYer:Str2;pClsNum:word):boolean;
begin
  SetIndex(ixDyCn);
  Result:=oTable.FindNearest([pDocYer,pClsNum]);
end;

function TVtrcctDat.NearDyCnInCc(pDocYer:Str2;pClsNum:word;pIndNum:Str12;pCctCod:Str10):boolean;
begin
  SetIndex(ixDyCnInCc);
  Result:=oTable.FindNearest([pDocYer,pClsNum,pIndNum,pCctCod]);
end;

procedure TVtrcctDat.SetIndex(pIndexName:Str20);
begin
  Open;
  If oTable.IndexName<>pIndexName then oTable.IndexName:=pIndexName;
end;

procedure TVtrcctDat.Open;
begin
  If not oTable.Active then oTable.Open;
end;

procedure TVtrcctDat.Close;
begin
  If oTable.Active then oTable.Close;
end;

procedure TVtrcctDat.Prior;
begin
  oTable.Prior;
end;

procedure TVtrcctDat.Next;
begin
  oTable.Next;
end;

procedure TVtrcctDat.First;
begin
  Open;
  oTable.First;
end;

procedure TVtrcctDat.Last;
begin
  Open;
  oTable.Last;
end;

procedure TVtrcctDat.Insert;
begin
  Open;
  oTable.Insert;
end;

procedure TVtrcctDat.Edit;
begin
  oTable.Edit;
end;

procedure TVtrcctDat.Post;
begin
  oTable.Post;
end;

procedure TVtrcctDat.Delete;
begin
  oTable.Delete;
end;

procedure TVtrcctDat.SwapIndex;
begin
  Open;
  oTable.SwapIndex;
end;

procedure TVtrcctDat.RestIndex;
begin
  oTable.RestoreIndex;
end;

procedure TVtrcctDat.SwapStatus;
begin
  Open;
  oTable.SwapStatus;
end;

procedure TVtrcctDat.RestStatus;
begin
  oTable.RestoreStatus;
end;

procedure TVtrcctDat.EnabCont;
begin
  oTable.EnableControls;
end;

procedure TVtrcctDat.DisabCont;
begin
  oTable.DisableControls;
end;

end.
{MOD 2008001}
