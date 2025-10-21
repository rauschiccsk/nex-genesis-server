unit dARDLST;

interface

uses
  IcTypes, IcConv, NexPath, NexGlob,
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls,
  Dialogs, DB, NexBtrTable, DBTables, NexPxTable;

const
  ixDocNum='DocNum';
  ixDocTyp='DocTyp';

type
  TArdlstDat=class(TComponent)
    constructor Create; overload;
    destructor Destroy; override;
  private
    oTable:TNexBtrTable;
    function GetCount:integer;
    function FieldExist(pFieldName:Str20):boolean;
    // Prístup k databázovým poliam
    function GetDocNum:Str12;            procedure SetDocNum(pValue:Str12);
    function GetDocTyp:Str2;             procedure SetDocTyp(pValue:Str2);
    function GetParNum:longint;          procedure SetParNum(pValue:longint);
    function GetParNam:Str60;            procedure SetParNam(pValue:Str60);
    function GetParNam_:Str60;           procedure SetParNam_(pValue:Str60);
    function GetCrtDte:TDatetime;        procedure SetCrtDte(pValue:TDatetime);
    function GetCrtTim:TDatetime;        procedure SetCrtTim(pValue:TDatetime);
    function GetLasUsn:Str30;            procedure SetLasUsn(pValue:Str30);
    function GetLasDte:TDatetime;        procedure SetLasDte(pValue:TDatetime);
    function GetLasTim:TDatetime;        procedure SetLasTim(pValue:TDatetime);
    function GetChgNum:word;             procedure SetChgNum(pValue:word);
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
    function LocDocTyp(pDocTyp:Str2):boolean;
    function NearDocNum(pDocNum:Str12):boolean;
    function NearDocTyp(pDocTyp:Str2):boolean;

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
    property DocTyp:Str2 read GetDocTyp write SetDocTyp;
    property ParNum:longint read GetParNum write SetParNum;
    property ParNam:Str60 read GetParNam write SetParNam;
    property ParNam_:Str60 read GetParNam_ write SetParNam_;
    property CrtDte:TDatetime read GetCrtDte write SetCrtDte;
    property CrtTim:TDatetime read GetCrtTim write SetCrtTim;
    property LasUsn:Str30 read GetLasUsn write SetLasUsn;
    property LasDte:TDatetime read GetLasDte write SetLasDte;
    property LasTim:TDatetime read GetLasTim write SetLasTim;
    property ChgNum:word read GetChgNum write SetChgNum;
  end;

implementation

constructor TArdlstDat.Create;
begin
  oTable:=DatInit('ARDLST',gPath.SysPath,Self);
end;

constructor TArdlstDat.Create(pPath:ShortString);
begin
  oTable:=DatInit('ARDLST',pPath,Self);
end;

destructor TArdlstDat.Destroy;
begin
  oTable.Close;
  FreeAndNil(oTable);
end;

// *************************************** PRIVATE ********************************************

function TArdlstDat.GetCount:integer;
begin
  Open;
  Result:=oTable.RecordCount;
end;

function TArdlstDat.FieldExist(pFieldName:Str20):boolean;
begin
  Result:=oTable.FindField(pFieldName)<>nil;
end;

// ********************* FIELDS *********************

function TArdlstDat.GetDocNum:Str12;
begin
  Result:=oTable.FieldByName('DocNum').AsString;
end;

procedure TArdlstDat.SetDocNum(pValue:Str12);
begin
  oTable.FieldByName('DocNum').AsString:=pValue;
end;

function TArdlstDat.GetDocTyp:Str2;
begin
  Result:=oTable.FieldByName('DocTyp').AsString;
end;

procedure TArdlstDat.SetDocTyp(pValue:Str2);
begin
  oTable.FieldByName('DocTyp').AsString:=pValue;
end;

function TArdlstDat.GetParNum:longint;
begin
  Result:=oTable.FieldByName('ParNum').AsInteger;
end;

procedure TArdlstDat.SetParNum(pValue:longint);
begin
  oTable.FieldByName('ParNum').AsInteger:=pValue;
end;

function TArdlstDat.GetParNam:Str60;
begin
  Result:=oTable.FieldByName('ParNam').AsString;
end;

procedure TArdlstDat.SetParNam(pValue:Str60);
begin
  oTable.FieldByName('ParNam').AsString:=pValue;
end;

function TArdlstDat.GetParNam_:Str60;
begin
  Result:=oTable.FieldByName('ParNam_').AsString;
end;

procedure TArdlstDat.SetParNam_(pValue:Str60);
begin
  oTable.FieldByName('ParNam_').AsString:=pValue;
end;

function TArdlstDat.GetCrtDte:TDatetime;
begin
  Result:=oTable.FieldByName('CrtDte').AsDateTime;
end;

procedure TArdlstDat.SetCrtDte(pValue:TDatetime);
begin
  oTable.FieldByName('CrtDte').AsDateTime:=pValue;
end;

function TArdlstDat.GetCrtTim:TDatetime;
begin
  Result:=oTable.FieldByName('CrtTim').AsDateTime;
end;

procedure TArdlstDat.SetCrtTim(pValue:TDatetime);
begin
  oTable.FieldByName('CrtTim').AsDateTime:=pValue;
end;

function TArdlstDat.GetLasUsn:Str30;
begin
  Result:=oTable.FieldByName('LasUsn').AsString;
end;

procedure TArdlstDat.SetLasUsn(pValue:Str30);
begin
  oTable.FieldByName('LasUsn').AsString:=pValue;
end;

function TArdlstDat.GetLasDte:TDatetime;
begin
  Result:=oTable.FieldByName('LasDte').AsDateTime;
end;

procedure TArdlstDat.SetLasDte(pValue:TDatetime);
begin
  oTable.FieldByName('LasDte').AsDateTime:=pValue;
end;

function TArdlstDat.GetLasTim:TDatetime;
begin
  Result:=oTable.FieldByName('LasTim').AsDateTime;
end;

procedure TArdlstDat.SetLasTim(pValue:TDatetime);
begin
  oTable.FieldByName('LasTim').AsDateTime:=pValue;
end;

function TArdlstDat.GetChgNum:word;
begin
  Result:=oTable.FieldByName('ChgNum').AsInteger;
end;

procedure TArdlstDat.SetChgNum(pValue:word);
begin
  oTable.FieldByName('ChgNum').AsInteger:=pValue;
end;

// **************************************** PUBLIC ********************************************

function TArdlstDat.Eof:boolean;
begin
  Result:=oTable.Eof;
end;

function TArdlstDat.IsFirst:boolean;
begin
  Open;
  Result:=oTable.Bof;
end;

function TArdlstDat.IsLast:boolean;
begin
  Open;
  Result:=oTable.Eof;
end;

function TArdlstDat.Active:boolean;
begin
  Result:=oTable.Active;
end;

function TArdlstDat.ActPos:longint;
begin
  Result:=oTable.ActPos;
end;

function TArdlstDat.GotoPos(pActPos:longint): boolean;
begin
  Open;
  Result:=oTable.GotoPos(pActPos);
end;

function TArdlstDat.FieldNum(pFieldName:Str20):Str3;
begin
  Result:=StrInt(oTable.FieldByName(pFieldName).FieldNo-1,0);
end;

function TArdlstDat.LocDocNum(pDocNum:Str12):boolean;
begin
  SetIndex(ixDocNum);
  Result:=oTable.FindKey([pDocNum]);
end;

function TArdlstDat.LocDocTyp(pDocTyp:Str2):boolean;
begin
  SetIndex(ixDocTyp);
  Result:=oTable.FindKey([pDocTyp]);
end;

function TArdlstDat.NearDocNum(pDocNum:Str12):boolean;
begin
  SetIndex(ixDocNum);
  Result:=oTable.FindNearest([pDocNum]);
end;

function TArdlstDat.NearDocTyp(pDocTyp:Str2):boolean;
begin
  SetIndex(ixDocTyp);
  Result:=oTable.FindNearest([pDocTyp]);
end;

procedure TArdlstDat.SetIndex(pIndexName:Str20);
begin
  Open;
  If oTable.IndexName<>pIndexName then oTable.IndexName:=pIndexName;
end;

procedure TArdlstDat.Open;
begin
  If not oTable.Active then oTable.Open;
end;

procedure TArdlstDat.Close;
begin
  If oTable.Active then oTable.Close;
end;

procedure TArdlstDat.Prior;
begin
  oTable.Prior;
end;

procedure TArdlstDat.Next;
begin
  oTable.Next;
end;

procedure TArdlstDat.First;
begin
  Open;
  oTable.First;
end;

procedure TArdlstDat.Last;
begin
  Open;
  oTable.Last;
end;

procedure TArdlstDat.Insert;
begin
  Open;
  oTable.Insert;
end;

procedure TArdlstDat.Edit;
begin
  oTable.Edit;
end;

procedure TArdlstDat.Post;
begin
  oTable.Post;
end;

procedure TArdlstDat.Delete;
begin
  oTable.Delete;
end;

procedure TArdlstDat.SwapIndex;
begin
  Open;
  oTable.SwapIndex;
end;

procedure TArdlstDat.RestIndex;
begin
  oTable.RestoreIndex;
end;

procedure TArdlstDat.SwapStatus;
begin
  Open;
  oTable.SwapStatus;
end;

procedure TArdlstDat.RestStatus;
begin
  oTable.RestoreStatus;
end;

procedure TArdlstDat.EnabCont;
begin
  oTable.EnableControls;
end;

procedure TArdlstDat.DisabCont;
begin
  oTable.DisableControls;
end;

end.
{MOD 2001001}
