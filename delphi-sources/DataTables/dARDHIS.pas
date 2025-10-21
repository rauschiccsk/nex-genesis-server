unit dARDHIS;

interface

uses
  IcTypes, IcConv, NexPath, NexGlob,
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls,
  Dialogs, DB, NexBtrTable, DBTables, NexPxTable;

const
  ixDocNum='DocNum';
  ixDnCn='DnCn';
  ixPdfSta='PdfSta';

type
  TArdhisDat=class(TComponent)
    constructor Create; overload;
    destructor Destroy; override;
  private
    oTable:TNexBtrTable;
    function GetCount:integer;
    function FieldExist(pFieldName:Str20):boolean;
    // Prístup k databázovým poliam
    function GetDocNum:Str12;            procedure SetDocNum(pValue:Str12);
    function GetChgNum:word;             procedure SetChgNum(pValue:word);
    function GetParNum:longint;          procedure SetParNum(pValue:longint);
    function GetParNam:Str60;            procedure SetParNam(pValue:Str60);
    function GetPdfSta:Str1;             procedure SetPdfSta(pValue:Str1);
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
    function LocDocNum(pDocNum:Str12):boolean;
    function LocDnCn(pDocNum:Str12;pChgNum:word):boolean;
    function LocPdfSta(pPdfSta:Str1):boolean;
    function NearDocNum(pDocNum:Str12):boolean;
    function NearDnCn(pDocNum:Str12;pChgNum:word):boolean;
    function NearPdfSta(pPdfSta:Str1):boolean;

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
    property DocNum:Str12 read GetDocNum write SetDocNum;
    property ChgNum:word read GetChgNum write SetChgNum;
    property ParNum:longint read GetParNum write SetParNum;
    property ParNam:Str60 read GetParNam write SetParNam;
    property PdfSta:Str1 read GetPdfSta write SetPdfSta;
    property CrtUsn:Str30 read GetCrtUsn write SetCrtUsn;
    property CrtDte:TDatetime read GetCrtDte write SetCrtDte;
    property CrtTim:TDatetime read GetCrtTim write SetCrtTim;
  end;

implementation

constructor TArdhisDat.Create;
begin
  oTable:=DatInit('ARDHIS',gPath.SysPath,Self);
end;

constructor TArdhisDat.Create(pPath:ShortString);
begin
  oTable:=DatInit('ARDHIS',pPath,Self);
end;

destructor TArdhisDat.Destroy;
begin
  oTable.Close;
  FreeAndNil(oTable);
end;

// *************************************** PRIVATE ********************************************

function TArdhisDat.GetCount:integer;
begin
  Open;
  Result:=oTable.RecordCount;
end;

function TArdhisDat.FieldExist(pFieldName:Str20):boolean;
begin
  Result:=oTable.FindField(pFieldName)<>nil;
end;

// ********************* FIELDS *********************

function TArdhisDat.GetDocNum:Str12;
begin
  Result:=oTable.FieldByName('DocNum').AsString;
end;

procedure TArdhisDat.SetDocNum(pValue:Str12);
begin
  oTable.FieldByName('DocNum').AsString:=pValue;
end;

function TArdhisDat.GetChgNum:word;
begin
  Result:=oTable.FieldByName('ChgNum').AsInteger;
end;

procedure TArdhisDat.SetChgNum(pValue:word);
begin
  oTable.FieldByName('ChgNum').AsInteger:=pValue;
end;

function TArdhisDat.GetParNum:longint;
begin
  Result:=oTable.FieldByName('ParNum').AsInteger;
end;

procedure TArdhisDat.SetParNum(pValue:longint);
begin
  oTable.FieldByName('ParNum').AsInteger:=pValue;
end;

function TArdhisDat.GetParNam:Str60;
begin
  Result:=oTable.FieldByName('ParNam').AsString;
end;

procedure TArdhisDat.SetParNam(pValue:Str60);
begin
  oTable.FieldByName('ParNam').AsString:=pValue;
end;

function TArdhisDat.GetPdfSta:Str1;
begin
  Result:=oTable.FieldByName('PdfSta').AsString;
end;

procedure TArdhisDat.SetPdfSta(pValue:Str1);
begin
  oTable.FieldByName('PdfSta').AsString:=pValue;
end;

function TArdhisDat.GetCrtUsn:Str30;
begin
  Result:=oTable.FieldByName('CrtUsn').AsString;
end;

procedure TArdhisDat.SetCrtUsn(pValue:Str30);
begin
  oTable.FieldByName('CrtUsn').AsString:=pValue;
end;

function TArdhisDat.GetCrtDte:TDatetime;
begin
  Result:=oTable.FieldByName('CrtDte').AsDateTime;
end;

procedure TArdhisDat.SetCrtDte(pValue:TDatetime);
begin
  oTable.FieldByName('CrtDte').AsDateTime:=pValue;
end;

function TArdhisDat.GetCrtTim:TDatetime;
begin
  Result:=oTable.FieldByName('CrtTim').AsDateTime;
end;

procedure TArdhisDat.SetCrtTim(pValue:TDatetime);
begin
  oTable.FieldByName('CrtTim').AsDateTime:=pValue;
end;

// **************************************** PUBLIC ********************************************

function TArdhisDat.Eof:boolean;
begin
  Result:=oTable.Eof;
end;

function TArdhisDat.IsFirst:boolean;
begin
  Open;
  Result:=oTable.Bof;
end;

function TArdhisDat.IsLast:boolean;
begin
  Open;
  Result:=oTable.Eof;
end;

function TArdhisDat.Active:boolean;
begin
  Result:=oTable.Active;
end;

function TArdhisDat.ActPos:longint;
begin
  Result:=oTable.ActPos;
end;

function TArdhisDat.GotoPos(pActPos:longint): boolean;
begin
  Open;
  Result:=oTable.GotoPos(pActPos);
end;

function TArdhisDat.FieldNum(pFieldName:Str20):Str3;
begin
  Result:=StrInt(oTable.FieldByName(pFieldName).FieldNo-1,0);
end;

function TArdhisDat.LocDocNum(pDocNum:Str12):boolean;
begin
  SetIndex(ixDocNum);
  Result:=oTable.FindKey([pDocNum]);
end;

function TArdhisDat.LocDnCn(pDocNum:Str12;pChgNum:word):boolean;
begin
  SetIndex(ixDnCn);
  Result:=oTable.FindKey([pDocNum,pChgNum]);
end;

function TArdhisDat.LocPdfSta(pPdfSta:Str1):boolean;
begin
  SetIndex(ixPdfSta);
  Result:=oTable.FindKey([pPdfSta]);
end;

function TArdhisDat.NearDocNum(pDocNum:Str12):boolean;
begin
  SetIndex(ixDocNum);
  Result:=oTable.FindNearest([pDocNum]);
end;

function TArdhisDat.NearDnCn(pDocNum:Str12;pChgNum:word):boolean;
begin
  SetIndex(ixDnCn);
  Result:=oTable.FindNearest([pDocNum,pChgNum]);
end;

function TArdhisDat.NearPdfSta(pPdfSta:Str1):boolean;
begin
  SetIndex(ixPdfSta);
  Result:=oTable.FindNearest([pPdfSta]);
end;

procedure TArdhisDat.SetIndex(pIndexName:Str20);
begin
  Open;
  If oTable.IndexName<>pIndexName then oTable.IndexName:=pIndexName;
end;

procedure TArdhisDat.Open;
begin
  If not oTable.Active then oTable.Open;
end;

procedure TArdhisDat.Close;
begin
  If oTable.Active then oTable.Close;
end;

procedure TArdhisDat.Prior;
begin
  oTable.Prior;
end;

procedure TArdhisDat.Next;
begin
  oTable.Next;
end;

procedure TArdhisDat.First;
begin
  Open;
  oTable.First;
end;

procedure TArdhisDat.Last;
begin
  Open;
  oTable.Last;
end;

procedure TArdhisDat.Insert;
begin
  Open;
  oTable.Insert;
end;

procedure TArdhisDat.Edit;
begin
  oTable.Edit;
end;

procedure TArdhisDat.Post;
begin
  oTable.Post;
end;

procedure TArdhisDat.Delete;
begin
  oTable.Delete;
end;

procedure TArdhisDat.SwapIndex;
begin
  Open;
  oTable.SwapIndex;
end;

procedure TArdhisDat.RestIndex;
begin
  oTable.RestoreIndex;
end;

procedure TArdhisDat.SwapStatus;
begin
  Open;
  oTable.SwapStatus;
end;

procedure TArdhisDat.RestStatus;
begin
  oTable.RestoreStatus;
end;

procedure TArdhisDat.EnabCont;
begin
  oTable.EnableControls;
end;

procedure TArdhisDat.DisabCont;
begin
  oTable.DisableControls;
end;

end.
{MOD 2001001}
