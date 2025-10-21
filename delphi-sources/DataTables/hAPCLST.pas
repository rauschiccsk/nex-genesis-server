unit hAPCLST;

interface

uses
  IcTypes, IcConv, NexPath, NexGlob,
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls,
  Dialogs, DB, NexBtrTable, DBTables, NexPxTable;

const
  ixProNum='GsCode';
  ixAnGs='AnGs';

type
  TApclstHnd=class(TComponent)
    constructor Create;
    destructor Destroy; override;
  private
    oAplNum:word;
    oTable:TNexBtrTable;
    function GetCount:integer;
    function GetTable:TNexBtrTable;
    function FieldExist(pFieldName:Str20):boolean;
    function FieldNum(pFieldName:Str20):byte;
    procedure SetAplNum(pValue:word);
    // Prístup k databázovým poliam
    function GetProNum:longint;          procedure SetProNum(pValue:longint);
    function GetProNam:Str60;            procedure SetProNam(pValue:Str60);
    function GetBarCod:Str15;            procedure SetBarCod(pValue:Str15);
    function GetBegDte:TDate;            procedure SetBegDte(pValue:TDate);
    function GetBegTim:TTime;            procedure SetBegTim(pValue:TTime);
    function GetEndDte:TDate;            procedure SetEndDte(pValue:TDate);
    function GetEndTim:TTime;            procedure SetEndTim(pValue:TTime);
    function GetApsApc:double;           procedure SetApsApc(pValue:double);
    function GetApsBpc:double;           procedure SetApsBpc(pValue:double);
  public
    // Základné databázové operácie
    function Eof:boolean;
    function IsFirst:boolean;
    function IsLast:boolean;
    function Active:boolean;
    function ActPos:longint;
    function GotoPos(pActPos:longint):boolean;
    function LocProNum(pAplNum:word;pProNum:longint):boolean;
    function NearProNum(pAplNum:word;pProNum:longint):boolean;

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

    property Table:TNexBtrTable read GetTable;
  published
    property Count:integer read GetCount;
    // Prístup k databázovým poliam
    property AplNum:word read oAplNum write SetAplNum;
    property ProNum:longint read GetProNum write SetProNum;
    property ProNam:Str60 read GetProNam write SetProNam;
    property BarCod:Str15 read GetBarCod write SetBarCod;
    property BegDte:TDate read GetBegDte write SetBegDte;
    property BegTim:TTime read GetBegTim write SetBegTim;
    property EndDte:TDate read GetEndDte write SetEndDte;
    property EndTim:TTime read GetEndTim write SetEndTim;
    property ApsApc:double read GetApsApc write SetApsApc;
    property ApsBpc:double read GetApsBpc write SetApsBpc;
  end;

implementation

constructor TApclstHnd.Create;
begin
  oTable:=BtrInit('APLITM',gPath.StkPath,Self);
end;

destructor TApclstHnd.Destroy;
begin
  oTable.Close;
  FreeAndNil(oTable);
end;

// *************************************** PRIVATE ********************************************

function TApclstHnd.GetCount:integer;
begin
  Result:=oTable.RecordCount;
end;

function TApclstHnd.GetTable:TNexBtrTable;
begin
  Open;
  Result:=oTable;
end;

function TApclstHnd.FieldExist(pFieldName:Str20):boolean;
begin
  Result:=oTable.FindField(pFieldName)<>nil;
end;

function TApclstHnd.FieldNum(pFieldName:Str20):byte;
begin
  Result:=oTable.FieldByName(pFieldName).FieldNo-1;
end;

procedure TApclstHnd.SetAplNum(pValue:word);
var mFldNum:Str3;
begin
  Open;
  oAplNum:=pValue;
  mFldNum:=StrInt(FieldNum('AplNum'),0);
  oTable.ClearFilter;
  oTable.Filter:='['+mFldNum+']={'+StrInt(oAplNum,0)+'}';
  oTable.Filtered:=TRUE;
end;

// ********************* FIELDS *********************

function TApclstHnd.GetProNum:longint;
begin
  Result:=oTable.FieldByName('GsCode').AsInteger;
end;

procedure TApclstHnd.SetProNum(pValue:longint);
begin
  oTable.FieldByName('GsCode').AsInteger:=pValue;
end;

function TApclstHnd.GetProNam:Str60;
begin
  Result:=oTable.FieldByName('GsName').AsString;
end;

procedure TApclstHnd.SetProNam(pValue:Str60);
begin
  oTable.FieldByName('GsName').AsString:=pValue;
end;

function TApclstHnd.GetBarCod:Str15;
begin
  Result:=oTable.FieldByName('BarCode').AsString;
end;

procedure TApclstHnd.SetBarCod(pValue:Str15);
begin
  oTable.FieldByName('BarCode').AsString:=pValue;
end;

function TApclstHnd.GetBegDte:TDate;
begin
  Result:=oTable.FieldByName('BegDate').AsDateTime;
end;

procedure TApclstHnd.SetBegDte(pValue:TDate);
begin
  oTable.FieldByName('BegDate').AsDateTime:=pValue;
end;

function TApclstHnd.GetBegTim:TTime;
begin
  Result:=oTable.FieldByName('BegTime').AsDateTime;
end;

procedure TApclstHnd.SetBegTim(pValue:TTime);
begin
  oTable.FieldByName('BegTime').AsDateTime:=pValue;
end;

function TApclstHnd.GetEndDte:TDate;
begin
  Result:=oTable.FieldByName('EndDate').AsDateTime;
end;

procedure TApclstHnd.SetEndDte(pValue:TDate);
begin
  oTable.FieldByName('EndDate').AsDateTime:=pValue;
end;

function TApclstHnd.GetEndTim:TTime;
begin
  Result:=oTable.FieldByName('EndTime').AsDateTime;
end;

procedure TApclstHnd.SetEndTim(pValue:TTime);
begin
  oTable.FieldByName('EndTime').AsDateTime:=pValue;
end;

function TApclstHnd.GetApsApc:double;
begin
  Result:=oTable.FieldByName('AcAPrice').AsFloat;
end;

procedure TApclstHnd.SetApsApc(pValue:double);
begin
  oTable.FieldByName('AcAPrice').AsFloat:=pValue;
end;

function TApclstHnd.GetApsBpc:double;
begin
  Result:=oTable.FieldByName('AcBPrice').AsFloat;
end;

procedure TApclstHnd.SetApsBpc(pValue:double);
begin
  oTable.FieldByName('AcBPrice').AsFloat:=pValue;
end;

// **************************************** PUBLIC ********************************************

function TApclstHnd.Eof:boolean;
begin
  Result:=oTable.Eof;
end;

function TApclstHnd.IsFirst:boolean;
begin
  Result:=oTable.Bof;
end;

function TApclstHnd.IsLast:boolean;
begin
  Result:=oTable.Eof;
end;

function TApclstHnd.Active:boolean;
begin
  Result:=oTable.Active;
end;

function TApclstHnd.ActPos:longint;
begin
  Result:=oTable.ActPos;
end;

function TApclstHnd.GotoPos(pActPos:longint): boolean;
begin
  Open;
  Result:=oTable.GotoPos(pActPos);
end;

function TApclstHnd.LocProNum(pAplNum:word;pProNum:longint):boolean;
begin
  Open;
  SetIndex(ixAnGs);
  Result:=oTable.FindKey([pAplNum,pProNum]);
end;

function TApclstHnd.NearProNum(pAplNum:word;pProNum:longint):boolean;
begin
  Open;
  AplNum:=pAplNum;
  SetIndex(ixProNum);
  Result:=oTable.FindNearest([pProNum]);
end;

procedure TApclstHnd.SetIndex(pIndexName:Str20);
begin
  If oTable.IndexName<>pIndexName then oTable.IndexName:=pIndexName;
end;

procedure TApclstHnd.Open;
begin
  If not oTable.Active then oTable.Open;
end;

procedure TApclstHnd.Close;
begin
  If oTable.Active then oTable.Close;
end;

procedure TApclstHnd.Prior;
begin
  oTable.Prior;
end;

procedure TApclstHnd.Next;
begin
  oTable.Next;
end;

procedure TApclstHnd.First;
begin
  oTable.First;
end;

procedure TApclstHnd.Last;
begin
  oTable.Last;
end;

procedure TApclstHnd.Insert;
begin
  oTable.Insert;
end;

procedure TApclstHnd.Edit;
begin
  oTable.Edit;
end;

procedure TApclstHnd.Post;
begin
  oTable.Post;
end;

procedure TApclstHnd.Delete;
begin
  oTable.Delete;
end;

procedure TApclstHnd.SwapIndex;
begin
  Open;
  oTable.SwapIndex;
end;

procedure TApclstHnd.RestIndex;
begin
  oTable.RestoreIndex;
end;

procedure TApclstHnd.SwapStatus;
begin
  Open;
  oTable.SwapStatus;
end;

procedure TApclstHnd.RestStatus;
begin
  oTable.RestoreStatus;
end;

procedure TApclstHnd.EnabCont;
begin
  oTable.EnableControls;
end;

procedure TApclstHnd.DisabCont;
begin
  oTable.DisableControls;
end;

end.

