unit dBOKLST;

interface

uses
  IcTypes, IcConv, NexPath, NexGlob,
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls,
  Dialogs, DB, NexBtrTable, DBTables, NexPxTable;

const
  ixPmdCod='PmdCod';
  ixPmBn='PmBn';

type
  TBoklstDat=class(TComponent)
    constructor Create; overload;
    destructor Destroy; override;
  private
    oTable:TNexBtrTable;
    function GetCount:integer;
    function FieldExist(pFieldName:Str20):boolean;
    // Prístup k databázovým poliam
    function GetPmdCod:Str3;             procedure SetPmdCod(pValue:Str3);
    function GetBokNum:Str3;             procedure SetBokNum(pValue:Str3);
    function GetBokNam:Str50;            procedure SetBokNam(pValue:Str50);
    function GetCrtUsr:Str8;             procedure SetCrtUsr(pValue:Str8);
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
    function LocPmdCod(pPmdCod:Str3):boolean;
    function LocPmBn(pPmdCod:Str3;pBokNum:Str3):boolean;
    function NearPmdCod(pPmdCod:Str3):boolean;
    function NearPmBn(pPmdCod:Str3;pBokNum:Str3):boolean;

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
    property PmdCod:Str3 read GetPmdCod write SetPmdCod;
    property BokNum:Str3 read GetBokNum write SetBokNum;
    property BokNam:Str50 read GetBokNam write SetBokNam;
    property CrtUsr:Str8 read GetCrtUsr write SetCrtUsr;
    property CrtUsn:Str30 read GetCrtUsn write SetCrtUsn;
    property CrtDte:TDatetime read GetCrtDte write SetCrtDte;
    property CrtTim:TDatetime read GetCrtTim write SetCrtTim;
  end;

implementation

constructor TBoklstDat.Create;
begin
  oTable:=DatInit('BOKLST',gPath.SysPath,Self);
end;

constructor TBoklstDat.Create(pPath:ShortString);
begin
  oTable:=DatInit('BOKLST',pPath,Self);
end;

destructor TBoklstDat.Destroy;
begin
  oTable.Close;
  FreeAndNil(oTable);
end;

// *************************************** PRIVATE ********************************************

function TBoklstDat.GetCount:integer;
begin
  Open;
  Result:=oTable.RecordCount;
end;

function TBoklstDat.FieldExist(pFieldName:Str20):boolean;
begin
  Result:=oTable.FindField(pFieldName)<>nil;
end;

// ********************* FIELDS *********************

function TBoklstDat.GetPmdCod:Str3;
begin
  Result:=oTable.FieldByName('PmdCod').AsString;
end;

procedure TBoklstDat.SetPmdCod(pValue:Str3);
begin
  oTable.FieldByName('PmdCod').AsString:=pValue;
end;

function TBoklstDat.GetBokNum:Str3;
begin
  Result:=oTable.FieldByName('BokNum').AsString;
end;

procedure TBoklstDat.SetBokNum(pValue:Str3);
begin
  oTable.FieldByName('BokNum').AsString:=pValue;
end;

function TBoklstDat.GetBokNam:Str50;
begin
  Result:=oTable.FieldByName('BokNam').AsString;
end;

procedure TBoklstDat.SetBokNam(pValue:Str50);
begin
  oTable.FieldByName('BokNam').AsString:=pValue;
end;

function TBoklstDat.GetCrtUsr:Str8;
begin
  Result:=oTable.FieldByName('CrtUsr').AsString;
end;

procedure TBoklstDat.SetCrtUsr(pValue:Str8);
begin
  oTable.FieldByName('CrtUsr').AsString:=pValue;
end;

function TBoklstDat.GetCrtUsn:Str30;
begin
  Result:=oTable.FieldByName('CrtUsn').AsString;
end;

procedure TBoklstDat.SetCrtUsn(pValue:Str30);
begin
  oTable.FieldByName('CrtUsn').AsString:=pValue;
end;

function TBoklstDat.GetCrtDte:TDatetime;
begin
  Result:=oTable.FieldByName('CrtDte').AsDateTime;
end;

procedure TBoklstDat.SetCrtDte(pValue:TDatetime);
begin
  oTable.FieldByName('CrtDte').AsDateTime:=pValue;
end;

function TBoklstDat.GetCrtTim:TDatetime;
begin
  Result:=oTable.FieldByName('CrtTim').AsDateTime;
end;

procedure TBoklstDat.SetCrtTim(pValue:TDatetime);
begin
  oTable.FieldByName('CrtTim').AsDateTime:=pValue;
end;

// **************************************** PUBLIC ********************************************

function TBoklstDat.Eof:boolean;
begin
  Result:=oTable.Eof;
end;

function TBoklstDat.IsFirst:boolean;
begin
  Open;
  Result:=oTable.Bof;
end;

function TBoklstDat.IsLast:boolean;
begin
  Open;
  Result:=oTable.Eof;
end;

function TBoklstDat.Active:boolean;
begin
  Result:=oTable.Active;
end;

function TBoklstDat.ActPos:longint;
begin
  Result:=oTable.ActPos;
end;

function TBoklstDat.GotoPos(pActPos:longint): boolean;
begin
  Open;
  If oTable.Filtered and (Count=0) then begin
    oTable.Filtered:=FALSE;
    oTable.Filtered:=TRUE;
  end;
  oTable.Refresh;
  Result:=oTable.GotoPos(pActPos);
end;

function TBoklstDat.FieldNum(pFieldName:Str20):Str3;
begin
  Open;
  Result:=StrInt(oTable.FieldByName(pFieldName).FieldNo-1,0);
end;

function TBoklstDat.LocPmdCod(pPmdCod:Str3):boolean;
begin
  SetIndex(ixPmdCod);
  Result:=oTable.FindKey([pPmdCod]);
end;

function TBoklstDat.LocPmBn(pPmdCod:Str3;pBokNum:Str3):boolean;
begin
  SetIndex(ixPmBn);
  Result:=oTable.FindKey([pPmdCod,pBokNum]);
end;

function TBoklstDat.NearPmdCod(pPmdCod:Str3):boolean;
begin
  SetIndex(ixPmdCod);
  Result:=oTable.FindNearest([pPmdCod]);
end;

function TBoklstDat.NearPmBn(pPmdCod:Str3;pBokNum:Str3):boolean;
begin
  SetIndex(ixPmBn);
  Result:=oTable.FindNearest([pPmdCod,pBokNum]);
end;

procedure TBoklstDat.SetIndex(pIndexName:Str20);
begin
  Open;
  If oTable.IndexName<>pIndexName then oTable.IndexName:=pIndexName;
end;

procedure TBoklstDat.Open;
begin
  If not oTable.Active then oTable.Open;
end;

procedure TBoklstDat.Close;
begin
  If oTable.Active then oTable.Close;
end;

procedure TBoklstDat.Prior;
begin
  oTable.Prior;
end;

procedure TBoklstDat.Next;
begin
  oTable.Next;
end;

procedure TBoklstDat.First;
begin
  Open;
  oTable.First;
end;

procedure TBoklstDat.Last;
begin
  Open;
  oTable.Last;
end;

procedure TBoklstDat.Insert;
begin
  Open;
  oTable.Insert;
end;

procedure TBoklstDat.Edit;
begin
  oTable.Edit;
end;

procedure TBoklstDat.Post;
begin
  oTable.Post;
end;

procedure TBoklstDat.Delete;
begin
  oTable.Delete;
end;

procedure TBoklstDat.SwapIndex;
begin
  Open;
  oTable.SwapIndex;
end;

procedure TBoklstDat.RestIndex;
begin
  oTable.RestoreIndex;
end;

procedure TBoklstDat.SwapStatus;
begin
  Open;
  oTable.SwapStatus;
end;

procedure TBoklstDat.RestStatus;
begin
  oTable.RestoreStatus;
end;

procedure TBoklstDat.EnabCont;
begin
  oTable.EnableControls;
end;

procedure TBoklstDat.DisabCont;
begin
  oTable.DisableControls;
end;

end.
{MOD 2011001}
