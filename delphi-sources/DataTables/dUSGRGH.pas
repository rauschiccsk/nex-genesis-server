unit dUSGRGH;

interface

uses
  IcTypes, IcConv, NexPath, NexGlob,
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls,
  Dialogs, DB, NexBtrTable, DBTables, NexPxTable;

const
  ixGnPcBn='GnPcBn';
  ixGnPc='GnPc';
  ixPcBn='PcBn';

type
  TUsgrghDat=class(TComponent)
    constructor Create; overload;
    destructor Destroy; override;
  private
    oTable:TNexBtrTable;
    function GetCount:integer;
    function FieldExist(pFieldName:Str20):boolean;
    // Prístup k databázovým poliam
    function GetGrpNum:word;             procedure SetGrpNum(pValue:word);
    function GetPmdCod:Str3;             procedure SetPmdCod(pValue:Str3);
    function GetBokNum:Str3;             procedure SetBokNum(pValue:Str3);
    function GetUsgRgh:Str255;           procedure SetUsgRgh(pValue:Str255);
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
    function LocGnPcBn(pGrpNum:word;pPmdCod:Str3;pBokNum:Str3):boolean;
    function LocGnPc(pGrpNum:word;pPmdCod:Str3):boolean;
    function LocPcBn(pPmdCod:Str3;pBokNum:Str3):boolean;
    function NearGnPcBn(pGrpNum:word;pPmdCod:Str3;pBokNum:Str3):boolean;
    function NearGnPc(pGrpNum:word;pPmdCod:Str3):boolean;
    function NearPcBn(pPmdCod:Str3;pBokNum:Str3):boolean;

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
    property GrpNum:word read GetGrpNum write SetGrpNum;
    property PmdCod:Str3 read GetPmdCod write SetPmdCod;
    property BokNum:Str3 read GetBokNum write SetBokNum;
    property UsgRgh:Str255 read GetUsgRgh write SetUsgRgh;
  end;

implementation

constructor TUsgrghDat.Create;
begin
  oTable:=DatInit('USGRGH',gPath.SysPath,Self);
end;

constructor TUsgrghDat.Create(pPath:ShortString);
begin
  oTable:=DatInit('USGRGH',pPath,Self);
end;

destructor TUsgrghDat.Destroy;
begin
  oTable.Close;
  FreeAndNil(oTable);
end;

// *************************************** PRIVATE ********************************************

function TUsgrghDat.GetCount:integer;
begin
  Open;
  Result:=oTable.RecordCount;
end;

function TUsgrghDat.FieldExist(pFieldName:Str20):boolean;
begin
  Result:=oTable.FindField(pFieldName)<>nil;
end;

// ********************* FIELDS *********************

function TUsgrghDat.GetGrpNum:word;
begin
  Result:=oTable.FieldByName('GrpNum').AsInteger;
end;

procedure TUsgrghDat.SetGrpNum(pValue:word);
begin
  oTable.FieldByName('GrpNum').AsInteger:=pValue;
end;

function TUsgrghDat.GetPmdCod:Str3;
begin
  Result:=oTable.FieldByName('PmdCod').AsString;
end;

procedure TUsgrghDat.SetPmdCod(pValue:Str3);
begin
  oTable.FieldByName('PmdCod').AsString:=pValue;
end;

function TUsgrghDat.GetBokNum:Str3;
begin
  Result:=oTable.FieldByName('BokNum').AsString;
end;

procedure TUsgrghDat.SetBokNum(pValue:Str3);
begin
  oTable.FieldByName('BokNum').AsString:=pValue;
end;

function TUsgrghDat.GetUsgRgh:Str255;
begin
  Result:=oTable.FieldByName('UsgRgh').AsString;
end;

procedure TUsgrghDat.SetUsgRgh(pValue:Str255);
begin
  oTable.FieldByName('UsgRgh').AsString:=pValue;
end;

// **************************************** PUBLIC ********************************************

function TUsgrghDat.Eof:boolean;
begin
  Result:=oTable.Eof;
end;

function TUsgrghDat.IsFirst:boolean;
begin
  Open;
  Result:=oTable.Bof;
end;

function TUsgrghDat.IsLast:boolean;
begin
  Open;
  Result:=oTable.Eof;
end;

function TUsgrghDat.Active:boolean;
begin
  Result:=oTable.Active;
end;

function TUsgrghDat.ActPos:longint;
begin
  Result:=oTable.ActPos;
end;

function TUsgrghDat.GotoPos(pActPos:longint): boolean;
begin
  Open;
  If oTable.Filtered and (Count=0) then begin
    oTable.Filtered:=FALSE;
    oTable.Filtered:=TRUE;
  end;
  oTable.Refresh;
  Result:=oTable.GotoPos(pActPos);
end;

function TUsgrghDat.FieldNum(pFieldName:Str20):Str3;
begin
  Open;
  Result:=StrInt(oTable.FieldByName(pFieldName).FieldNo-1,0);
end;

function TUsgrghDat.LocGnPcBn(pGrpNum:word;pPmdCod:Str3;pBokNum:Str3):boolean;
begin
  SetIndex(ixGnPcBn);
  Result:=oTable.FindKey([pGrpNum,pPmdCod,pBokNum]);
end;

function TUsgrghDat.LocGnPc(pGrpNum:word;pPmdCod:Str3):boolean;
begin
  SetIndex(ixGnPc);
  Result:=oTable.FindKey([pGrpNum,pPmdCod]);
end;

function TUsgrghDat.LocPcBn(pPmdCod:Str3;pBokNum:Str3):boolean;
begin
  SetIndex(ixPcBn);
  Result:=oTable.FindKey([pPmdCod,pBokNum]);
end;

function TUsgrghDat.NearGnPcBn(pGrpNum:word;pPmdCod:Str3;pBokNum:Str3):boolean;
begin
  SetIndex(ixGnPcBn);
  Result:=oTable.FindNearest([pGrpNum,pPmdCod,pBokNum]);
end;

function TUsgrghDat.NearGnPc(pGrpNum:word;pPmdCod:Str3):boolean;
begin
  SetIndex(ixGnPc);
  Result:=oTable.FindNearest([pGrpNum,pPmdCod]);
end;

function TUsgrghDat.NearPcBn(pPmdCod:Str3;pBokNum:Str3):boolean;
begin
  SetIndex(ixPcBn);
  Result:=oTable.FindNearest([pPmdCod,pBokNum]);
end;

procedure TUsgrghDat.SetIndex(pIndexName:Str20);
begin
  Open;
  If oTable.IndexName<>pIndexName then oTable.IndexName:=pIndexName;
end;

procedure TUsgrghDat.Open;
begin
  If not oTable.Active then oTable.Open;
end;

procedure TUsgrghDat.Close;
begin
  If oTable.Active then oTable.Close;
end;

procedure TUsgrghDat.Prior;
begin
  oTable.Prior;
end;

procedure TUsgrghDat.Next;
begin
  oTable.Next;
end;

procedure TUsgrghDat.First;
begin
  Open;
  oTable.First;
end;

procedure TUsgrghDat.Last;
begin
  Open;
  oTable.Last;
end;

procedure TUsgrghDat.Insert;
begin
  Open;
  oTable.Insert;
end;

procedure TUsgrghDat.Edit;
begin
  oTable.Edit;
end;

procedure TUsgrghDat.Post;
begin
  oTable.Post;
end;

procedure TUsgrghDat.Delete;
begin
  oTable.Delete;
end;

procedure TUsgrghDat.SwapIndex;
begin
  Open;
  oTable.SwapIndex;
end;

procedure TUsgrghDat.RestIndex;
begin
  oTable.RestoreIndex;
end;

procedure TUsgrghDat.SwapStatus;
begin
  Open;
  oTable.SwapStatus;
end;

procedure TUsgrghDat.RestStatus;
begin
  oTable.RestoreStatus;
end;

procedure TUsgrghDat.EnabCont;
begin
  oTable.EnableControls;
end;

procedure TUsgrghDat.DisabCont;
begin
  oTable.DisableControls;
end;

end.
{MOD 2011001}
