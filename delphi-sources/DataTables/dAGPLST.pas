unit dAGPLST;

interface

uses
  IcTypes, IcConv, NexPath, NexGlob,
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls,
  Dialogs, DB, NexBtrTable, DBTables, NexPxTable;

const
  ixParNum='ParNum';
  ixParNam='ParNam';

type
  TAgplstDat=class(TComponent)
    constructor Create; overload;
    destructor Destroy; override;
  private
    oTable:TNexBtrTable;
    function GetCount:integer;
    function FieldExist(pFieldName:Str20):boolean;
    // Prístup k databázovým poliam
    function GetParNum:longint;          procedure SetParNum(pValue:longint);
    function GetParNam:Str60;            procedure SetParNam(pValue:Str60);
    function GetParNam_:Str60;           procedure SetParNam_(pValue:Str60);
    function GetAgcQnt:word;             procedure SetAgcQnt(pValue:word);
    function GetAgiQnt:longint;          procedure SetAgiQnt(pValue:longint);
    function GetNotice:Str60;            procedure SetNotice(pValue:Str60);
    function GetMinPrf:double;           procedure SetMinPrf(pValue:double);
    function GetAgcNum:Str30;            procedure SetAgcNum(pValue:Str30);
    function GetCrtUsr:Str20;            procedure SetCrtUsr(pValue:Str20);
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
    function LocParNum(pParNum:longint):boolean;
    function LocParNam(pParNam_:Str60):boolean;
    function NearParNum(pParNum:longint):boolean;
    function NearParNam(pParNam_:Str60):boolean;

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
    property ParNum:longint read GetParNum write SetParNum;
    property ParNam:Str60 read GetParNam write SetParNam;
    property ParNam_:Str60 read GetParNam_ write SetParNam_;
    property AgcQnt:word read GetAgcQnt write SetAgcQnt;
    property AgiQnt:longint read GetAgiQnt write SetAgiQnt;
    property Notice:Str60 read GetNotice write SetNotice;
    property MinPrf:double read GetMinPrf write SetMinPrf;
    property AgcNum:Str30 read GetAgcNum write SetAgcNum;
    property CrtUsr:Str20 read GetCrtUsr write SetCrtUsr;
    property CrtUsn:Str30 read GetCrtUsn write SetCrtUsn;
    property CrtDte:TDatetime read GetCrtDte write SetCrtDte;
    property CrtTim:TDatetime read GetCrtTim write SetCrtTim;
  end;

implementation

constructor TAgplstDat.Create;
begin
  oTable:=DatInit('AGPLST',gPath.StkPath,Self);
end;

constructor TAgplstDat.Create(pPath:ShortString);
begin
  oTable:=DatInit('AGPLST',pPath,Self);
end;

destructor TAgplstDat.Destroy;
begin
  oTable.Close;
  FreeAndNil(oTable);
end;

// *************************************** PRIVATE ********************************************

function TAgplstDat.GetCount:integer;
begin
  Open;
  Result:=oTable.RecordCount;
end;

function TAgplstDat.FieldExist(pFieldName:Str20):boolean;
begin
  Result:=oTable.FindField(pFieldName)<>nil;
end;

// ********************* FIELDS *********************

function TAgplstDat.GetParNum:longint;
begin
  Result:=oTable.FieldByName('ParNum').AsInteger;
end;

procedure TAgplstDat.SetParNum(pValue:longint);
begin
  oTable.FieldByName('ParNum').AsInteger:=pValue;
end;

function TAgplstDat.GetParNam:Str60;
begin
  Result:=oTable.FieldByName('ParNam').AsString;
end;

procedure TAgplstDat.SetParNam(pValue:Str60);
begin
  oTable.FieldByName('ParNam').AsString:=pValue;
end;

function TAgplstDat.GetParNam_:Str60;
begin
  Result:=oTable.FieldByName('ParNam_').AsString;
end;

procedure TAgplstDat.SetParNam_(pValue:Str60);
begin
  oTable.FieldByName('ParNam_').AsString:=pValue;
end;

function TAgplstDat.GetAgcQnt:word;
begin
  Result:=oTable.FieldByName('AgcQnt').AsInteger;
end;

procedure TAgplstDat.SetAgcQnt(pValue:word);
begin
  oTable.FieldByName('AgcQnt').AsInteger:=pValue;
end;

function TAgplstDat.GetAgiQnt:longint;
begin
  Result:=oTable.FieldByName('AgiQnt').AsInteger;
end;

procedure TAgplstDat.SetAgiQnt(pValue:longint);
begin
  oTable.FieldByName('AgiQnt').AsInteger:=pValue;
end;

function TAgplstDat.GetNotice:Str60;
begin
  Result:=oTable.FieldByName('Notice').AsString;
end;

procedure TAgplstDat.SetNotice(pValue:Str60);
begin
  oTable.FieldByName('Notice').AsString:=pValue;
end;

function TAgplstDat.GetMinPrf:double;
begin
  Result:=oTable.FieldByName('MinPrf').AsFloat;
end;

procedure TAgplstDat.SetMinPrf(pValue:double);
begin
  oTable.FieldByName('MinPrf').AsFloat:=pValue;
end;

function TAgplstDat.GetAgcNum:Str30;
begin
  Result:=oTable.FieldByName('AgcNum').AsString;
end;

procedure TAgplstDat.SetAgcNum(pValue:Str30);
begin
  oTable.FieldByName('AgcNum').AsString:=pValue;
end;

function TAgplstDat.GetCrtUsr:Str20;
begin
  Result:=oTable.FieldByName('CrtUsr').AsString;
end;

procedure TAgplstDat.SetCrtUsr(pValue:Str20);
begin
  oTable.FieldByName('CrtUsr').AsString:=pValue;
end;

function TAgplstDat.GetCrtUsn:Str30;
begin
  Result:=oTable.FieldByName('CrtUsn').AsString;
end;

procedure TAgplstDat.SetCrtUsn(pValue:Str30);
begin
  oTable.FieldByName('CrtUsn').AsString:=pValue;
end;

function TAgplstDat.GetCrtDte:TDatetime;
begin
  Result:=oTable.FieldByName('CrtDte').AsDateTime;
end;

procedure TAgplstDat.SetCrtDte(pValue:TDatetime);
begin
  oTable.FieldByName('CrtDte').AsDateTime:=pValue;
end;

function TAgplstDat.GetCrtTim:TDatetime;
begin
  Result:=oTable.FieldByName('CrtTim').AsDateTime;
end;

procedure TAgplstDat.SetCrtTim(pValue:TDatetime);
begin
  oTable.FieldByName('CrtTim').AsDateTime:=pValue;
end;

// **************************************** PUBLIC ********************************************

function TAgplstDat.Eof:boolean;
begin
  Result:=oTable.Eof;
end;

function TAgplstDat.IsFirst:boolean;
begin
  Open;
  Result:=oTable.Bof;
end;

function TAgplstDat.IsLast:boolean;
begin
  Open;
  Result:=oTable.Eof;
end;

function TAgplstDat.Active:boolean;
begin
  Result:=oTable.Active;
end;

function TAgplstDat.ActPos:longint;
begin
  Result:=oTable.ActPos;
end;

function TAgplstDat.GotoPos(pActPos:longint): boolean;
begin
  Open;
  If oTable.Filtered and (Count=0) then begin
    oTable.Filtered:=FALSE;
    oTable.Filtered:=TRUE;
  end;
  oTable.Refresh;
  Result:=oTable.GotoPos(pActPos);
end;

function TAgplstDat.FieldNum(pFieldName:Str20):Str3;
begin
  Open;
  Result:=StrInt(oTable.FieldByName(pFieldName).FieldNo-1,0);
end;

function TAgplstDat.LocParNum(pParNum:longint):boolean;
begin
  SetIndex(ixParNum);
  Result:=oTable.FindKey([pParNum]);
end;

function TAgplstDat.LocParNam(pParNam_:Str60):boolean;
begin
  SetIndex(ixParNam);
  Result:=oTable.FindKey([StrToAlias(pParNam_)]);
end;

function TAgplstDat.NearParNum(pParNum:longint):boolean;
begin
  SetIndex(ixParNum);
  Result:=oTable.FindNearest([pParNum]);
end;

function TAgplstDat.NearParNam(pParNam_:Str60):boolean;
begin
  SetIndex(ixParNam);
  Result:=oTable.FindNearest([pParNam_]);
end;

procedure TAgplstDat.SetIndex(pIndexName:Str20);
begin
  Open;
  If oTable.IndexName<>pIndexName then oTable.IndexName:=pIndexName;
end;

procedure TAgplstDat.Open;
begin
  If not oTable.Active then oTable.Open;
end;

procedure TAgplstDat.Close;
begin
  If oTable.Active then oTable.Close;
end;

procedure TAgplstDat.Prior;
begin
  oTable.Prior;
end;

procedure TAgplstDat.Next;
begin
  oTable.Next;
end;

procedure TAgplstDat.First;
begin
  Open;
  oTable.First;
end;

procedure TAgplstDat.Last;
begin
  Open;
  oTable.Last;
end;

procedure TAgplstDat.Insert;
begin
  Open;
  oTable.Insert;
end;

procedure TAgplstDat.Edit;
begin
  oTable.Edit;
end;

procedure TAgplstDat.Post;
begin
  oTable.Post;
end;

procedure TAgplstDat.Delete;
begin
  oTable.Delete;
end;

procedure TAgplstDat.SwapIndex;
begin
  Open;
  oTable.SwapIndex;
end;

procedure TAgplstDat.RestIndex;
begin
  oTable.RestoreIndex;
end;

procedure TAgplstDat.SwapStatus;
begin
  Open;
  oTable.SwapStatus;
end;

procedure TAgplstDat.RestStatus;
begin
  oTable.RestoreStatus;
end;

procedure TAgplstDat.EnabCont;
begin
  oTable.EnableControls;
end;

procedure TAgplstDat.DisabCont;
begin
  oTable.DisableControls;
end;

end.
{MOD 2001001}
