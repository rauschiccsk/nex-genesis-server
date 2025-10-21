unit dXRHLST;

interface

uses
  IcTypes, IcConv, NexPath, NexGlob,
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls,
  Dialogs, DB, NexBtrTable, DBTables, NexPxTable;

const
  ixDySn='DySn';

type
  TXrhlstDat=class(TComponent)
    constructor Create; overload;
    destructor Destroy; override;
  private
    oTable:TNexBtrTable;
    function GetCount:integer;
    function FieldExist(pFieldName:Str20):boolean;
    // Prístup k databázovým poliam
    function GetDocYer:Str2;             procedure SetDocYer(pValue:Str2);
    function GetSerNum:word;             procedure SetSerNum(pValue:word);
    function GetBegDte:TDatetime;        procedure SetBegDte(pValue:TDatetime);
    function GetEndDte:TDatetime;        procedure SetEndDte(pValue:TDatetime);
    function GetMthNum:byte;             procedure SetMthNum(pValue:byte);
    function GetMthNam:Str10;            procedure SetMthNam(pValue:Str10);
    function GetXlsNam:Str30;            procedure SetXlsNam(pValue:Str30);
    function GetCrtUsr:Str15;            procedure SetCrtUsr(pValue:Str15);
    function GetCrtUsn:Str30;            procedure SetCrtUsn(pValue:Str30);
    function GetCrtDte:TDatetime;        procedure SetCrtDte(pValue:TDatetime);
    function GetCrtTim:TDatetime;        procedure SetCrtTim(pValue:TDatetime);
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
    function LocDySn(pDocYer:Str2;pSerNum:word):boolean;
    function NearDySn(pDocYer:Str2;pSerNum:word):boolean;

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
    property SerNum:word read GetSerNum write SetSerNum;
    property BegDte:TDatetime read GetBegDte write SetBegDte;
    property EndDte:TDatetime read GetEndDte write SetEndDte;
    property MthNum:byte read GetMthNum write SetMthNum;
    property MthNam:Str10 read GetMthNam write SetMthNam;
    property XlsNam:Str30 read GetXlsNam write SetXlsNam;
    property CrtUsr:Str15 read GetCrtUsr write SetCrtUsr;
    property CrtUsn:Str30 read GetCrtUsn write SetCrtUsn;
    property CrtDte:TDatetime read GetCrtDte write SetCrtDte;
    property CrtTim:TDatetime read GetCrtTim write SetCrtTim;
  end;

implementation

constructor TXrhlstDat.Create;
begin
  oTable:=DatInit('XRHLST',gPath.StkPath,Self);
end;

constructor TXrhlstDat.Create(pPath:ShortString);
begin
  oTable:=DatInit('XRHLST',pPath,Self);
end;

destructor TXrhlstDat.Destroy;
begin
  oTable.Close;
  FreeAndNil(oTable);
end;

// *************************************** PRIVATE ********************************************

function TXrhlstDat.GetCount:integer;
begin
  Open;
  Result:=oTable.RecordCount;
end;

function TXrhlstDat.FieldExist(pFieldName:Str20):boolean;
begin
  Result:=oTable.FindField(pFieldName)<>nil;
end;

// ********************* FIELDS *********************

function TXrhlstDat.GetDocYer:Str2;
begin
  Result:=oTable.FieldByName('DocYer').AsString;
end;

procedure TXrhlstDat.SetDocYer(pValue:Str2);
begin
  oTable.FieldByName('DocYer').AsString:=pValue;
end;

function TXrhlstDat.GetSerNum:word;
begin
  Result:=oTable.FieldByName('SerNum').AsInteger;
end;

procedure TXrhlstDat.SetSerNum(pValue:word);
begin
  oTable.FieldByName('SerNum').AsInteger:=pValue;
end;

function TXrhlstDat.GetBegDte:TDatetime;
begin
  Result:=oTable.FieldByName('BegDte').AsDateTime;
end;

procedure TXrhlstDat.SetBegDte(pValue:TDatetime);
begin
  oTable.FieldByName('BegDte').AsDateTime:=pValue;
end;

function TXrhlstDat.GetEndDte:TDatetime;
begin
  Result:=oTable.FieldByName('EndDte').AsDateTime;
end;

procedure TXrhlstDat.SetEndDte(pValue:TDatetime);
begin
  oTable.FieldByName('EndDte').AsDateTime:=pValue;
end;

function TXrhlstDat.GetMthNum:byte;
begin
  Result:=oTable.FieldByName('MthNum').AsInteger;
end;

procedure TXrhlstDat.SetMthNum(pValue:byte);
begin
  oTable.FieldByName('MthNum').AsInteger:=pValue;
end;

function TXrhlstDat.GetMthNam:Str10;
begin
  Result:=oTable.FieldByName('MthNam').AsString;
end;

procedure TXrhlstDat.SetMthNam(pValue:Str10);
begin
  oTable.FieldByName('MthNam').AsString:=pValue;
end;

function TXrhlstDat.GetXlsNam:Str30;
begin
  Result:=oTable.FieldByName('XlsNam').AsString;
end;

procedure TXrhlstDat.SetXlsNam(pValue:Str30);
begin
  oTable.FieldByName('XlsNam').AsString:=pValue;
end;

function TXrhlstDat.GetCrtUsr:Str15;
begin
  Result:=oTable.FieldByName('CrtUsr').AsString;
end;

procedure TXrhlstDat.SetCrtUsr(pValue:Str15);
begin
  oTable.FieldByName('CrtUsr').AsString:=pValue;
end;

function TXrhlstDat.GetCrtUsn:Str30;
begin
  Result:=oTable.FieldByName('CrtUsn').AsString;
end;

procedure TXrhlstDat.SetCrtUsn(pValue:Str30);
begin
  oTable.FieldByName('CrtUsn').AsString:=pValue;
end;

function TXrhlstDat.GetCrtDte:TDatetime;
begin
  Result:=oTable.FieldByName('CrtDte').AsDateTime;
end;

procedure TXrhlstDat.SetCrtDte(pValue:TDatetime);
begin
  oTable.FieldByName('CrtDte').AsDateTime:=pValue;
end;

function TXrhlstDat.GetCrtTim:TDatetime;
begin
  Result:=oTable.FieldByName('CrtTim').AsDateTime;
end;

procedure TXrhlstDat.SetCrtTim(pValue:TDatetime);
begin
  oTable.FieldByName('CrtTim').AsDateTime:=pValue;
end;

// **************************************** PUBLIC ********************************************

function TXrhlstDat.Eof:boolean;
begin
  Result:=oTable.Eof;
end;

function TXrhlstDat.IsFirst:boolean;
begin
  Open;
  Result:=oTable.Bof;
end;

function TXrhlstDat.IsLast:boolean;
begin
  Open;
  Result:=oTable.Eof;
end;

function TXrhlstDat.Active:boolean;
begin
  Result:=oTable.Active;
end;

function TXrhlstDat.ActPos:longint;
begin
  Result:=oTable.ActPos;
end;

function TXrhlstDat.GotoPos(pActPos:longint): boolean;
begin
  Open;
  If oTable.Filtered and (Count=0) then begin
    oTable.Filtered:=FALSE;
    oTable.Filtered:=TRUE;
  end;
  oTable.Refresh;
  Result:=oTable.GotoPos(pActPos);
end;

function TXrhlstDat.FieldNum(pFieldName:Str20):Str3;
begin
  Open;
  Result:=StrInt(oTable.FieldByName(pFieldName).FieldNo-1,0);
end;

function TXrhlstDat.LocDySn(pDocYer:Str2;pSerNum:word):boolean;
begin
  SetIndex(ixDySn);
  Result:=oTable.FindKey([pDocYer,pSerNum]);
end;

function TXrhlstDat.NearDySn(pDocYer:Str2;pSerNum:word):boolean;
begin
  SetIndex(ixDySn);
  Result:=oTable.FindNearest([pDocYer,pSerNum]);
end;

procedure TXrhlstDat.SetIndex(pIndexName:Str20);
begin
  Open;
  If oTable.IndexName<>pIndexName then oTable.IndexName:=pIndexName;
end;

procedure TXrhlstDat.Open;
begin
  If not oTable.Active then oTable.Open;
end;

procedure TXrhlstDat.Close;
begin
  If oTable.Active then oTable.Close;
end;

procedure TXrhlstDat.Prior;
begin
  oTable.Prior;
end;

procedure TXrhlstDat.Next;
begin
  oTable.Next;
end;

procedure TXrhlstDat.First;
begin
  Open;
  oTable.First;
end;

procedure TXrhlstDat.Last;
begin
  Open;
  oTable.Last;
end;

procedure TXrhlstDat.Insert;
begin
  Open;
  oTable.Insert;
end;

procedure TXrhlstDat.Edit;
begin
  oTable.Edit;
end;

procedure TXrhlstDat.Post;
begin
  oTable.Post;
end;

procedure TXrhlstDat.Delete;
begin
  oTable.Delete;
end;

procedure TXrhlstDat.SwapIndex;
begin
  Open;
  oTable.SwapIndex;
end;

procedure TXrhlstDat.RestIndex;
begin
  oTable.RestoreIndex;
end;

procedure TXrhlstDat.SwapStatus;
begin
  Open;
  oTable.SwapStatus;
end;

procedure TXrhlstDat.RestStatus;
begin
  oTable.RestoreStatus;
end;

procedure TXrhlstDat.EnabCont;
begin
  oTable.EnableControls;
end;

procedure TXrhlstDat.DisabCont;
begin
  oTable.DisableControls;
end;

end.
{MOD 2011001}
