unit dAGCLST;

interface

uses
  IcTypes, IcConv, NexPath, NexGlob,
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls,
  Dialogs, DB, NexBtrTable, DBTables, NexPxTable;

const
  ixPaAc='PaAc';
  ixParNum='ParNum';
  ixAgcNum='AgcNum';
  ixAgcNam='AgcNam';

type
  TAgclstDat=class(TComponent)
    constructor Create; overload;
    destructor Destroy; override;
  private
    oTable:TNexBtrTable;
    function GetCount:integer;
    function FieldExist(pFieldName:Str20):boolean;
    // Prístup k databázovým poliam
    function GetParNum:longint;          procedure SetParNum(pValue:longint);
    function GetAgcNum:Str30;            procedure SetAgcNum(pValue:Str30);
    function GetAgcNam:Str90;            procedure SetAgcNam(pValue:Str90);
    function GetAgcNam_:Str90;           procedure SetAgcNam_(pValue:Str90);
    function GetBegDte:TDatetime;        procedure SetBegDte(pValue:TDatetime);
    function GetExpDte:TDatetime;        procedure SetExpDte(pValue:TDatetime);
    function GetIseDay:word;             procedure SetIseDay(pValue:word);
    function GetMinPrf:double;           procedure SetMinPrf(pValue:double);
    function GetSigDat:Str60;            procedure SetSigDat(pValue:Str60);
    function GetSigNam:Str30;            procedure SetSigNam(pValue:Str30);
    function GetItmQnt:longint;          procedure SetItmQnt(pValue:longint);
    function GetCrtUsr:Str20;            procedure SetCrtUsr(pValue:Str20);
    function GetCrtUsn:Str30;            procedure SetCrtUsn(pValue:Str30);
    function GetCrtDte:TDatetime;        procedure SetCrtDte(pValue:TDatetime);
    function GetCrtTim:TDatetime;        procedure SetCrtTim(pValue:TDatetime);
    function GetModUsr:Str8;             procedure SetModUsr(pValue:Str8);
    function GetModDte:TDatetime;        procedure SetModDte(pValue:TDatetime);
    function GetModTim:TDatetime;        procedure SetModTim(pValue:TDatetime);
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
    function LocPaAc(pParNum:longint;pAgcNum:Str30):boolean;
    function LocParNum(pParNum:longint):boolean;
    function LocAgcNum(pAgcNum:Str30):boolean;
    function LocAgcNam(pAgcNam_:Str90):boolean;
    function NearPaAc(pParNum:longint;pAgcNum:Str30):boolean;
    function NearParNum(pParNum:longint):boolean;
    function NearAgcNum(pAgcNum:Str30):boolean;
    function NearAgcNam(pAgcNam_:Str90):boolean;

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
    property AgcNum:Str30 read GetAgcNum write SetAgcNum;
    property AgcNam:Str90 read GetAgcNam write SetAgcNam;
    property AgcNam_:Str90 read GetAgcNam_ write SetAgcNam_;
    property BegDte:TDatetime read GetBegDte write SetBegDte;
    property ExpDte:TDatetime read GetExpDte write SetExpDte;
    property IseDay:word read GetIseDay write SetIseDay;
    property MinPrf:double read GetMinPrf write SetMinPrf;
    property SigDat:Str60 read GetSigDat write SetSigDat;
    property SigNam:Str30 read GetSigNam write SetSigNam;
    property ItmQnt:longint read GetItmQnt write SetItmQnt;
    property CrtUsr:Str20 read GetCrtUsr write SetCrtUsr;
    property CrtUsn:Str30 read GetCrtUsn write SetCrtUsn;
    property CrtDte:TDatetime read GetCrtDte write SetCrtDte;
    property CrtTim:TDatetime read GetCrtTim write SetCrtTim;
    property ModUsr:Str8 read GetModUsr write SetModUsr;
    property ModDte:TDatetime read GetModDte write SetModDte;
    property ModTim:TDatetime read GetModTim write SetModTim;
  end;

implementation

constructor TAgclstDat.Create;
begin
  oTable:=DatInit('AGCLST',gPath.StkPath,Self);
end;

constructor TAgclstDat.Create(pPath:ShortString);
begin
  oTable:=DatInit('AGCLST',pPath,Self);
end;

destructor TAgclstDat.Destroy;
begin
  oTable.Close;
  FreeAndNil(oTable);
end;

// *************************************** PRIVATE ********************************************

function TAgclstDat.GetCount:integer;
begin
  Open;
  Result:=oTable.RecordCount;
end;

function TAgclstDat.FieldExist(pFieldName:Str20):boolean;
begin
  Result:=oTable.FindField(pFieldName)<>nil;
end;

// ********************* FIELDS *********************

function TAgclstDat.GetParNum:longint;
begin
  Result:=oTable.FieldByName('ParNum').AsInteger;
end;

procedure TAgclstDat.SetParNum(pValue:longint);
begin
  oTable.FieldByName('ParNum').AsInteger:=pValue;
end;

function TAgclstDat.GetAgcNum:Str30;
begin
  Result:=oTable.FieldByName('AgcNum').AsString;
end;

procedure TAgclstDat.SetAgcNum(pValue:Str30);
begin
  oTable.FieldByName('AgcNum').AsString:=pValue;
end;

function TAgclstDat.GetAgcNam:Str90;
begin
  Result:=oTable.FieldByName('AgcNam').AsString;
end;

procedure TAgclstDat.SetAgcNam(pValue:Str90);
begin
  oTable.FieldByName('AgcNam').AsString:=pValue;
end;

function TAgclstDat.GetAgcNam_:Str90;
begin
  Result:=oTable.FieldByName('AgcNam_').AsString;
end;

procedure TAgclstDat.SetAgcNam_(pValue:Str90);
begin
  oTable.FieldByName('AgcNam_').AsString:=pValue;
end;

function TAgclstDat.GetBegDte:TDatetime;
begin
  Result:=oTable.FieldByName('BegDte').AsDateTime;
end;

procedure TAgclstDat.SetBegDte(pValue:TDatetime);
begin
  oTable.FieldByName('BegDte').AsDateTime:=pValue;
end;

function TAgclstDat.GetExpDte:TDatetime;
begin
  Result:=oTable.FieldByName('ExpDte').AsDateTime;
end;

procedure TAgclstDat.SetExpDte(pValue:TDatetime);
begin
  oTable.FieldByName('ExpDte').AsDateTime:=pValue;
end;

function TAgclstDat.GetIseDay:word;
begin
  Result:=oTable.FieldByName('IseDay').AsInteger;
end;

procedure TAgclstDat.SetIseDay(pValue:word);
begin
  oTable.FieldByName('IseDay').AsInteger:=pValue;
end;

function TAgclstDat.GetMinPrf:double;
begin
  Result:=oTable.FieldByName('MinPrf').AsFloat;
end;

procedure TAgclstDat.SetMinPrf(pValue:double);
begin
  oTable.FieldByName('MinPrf').AsFloat:=pValue;
end;

function TAgclstDat.GetSigDat:Str60;
begin
  Result:=oTable.FieldByName('SigDat').AsString;
end;

procedure TAgclstDat.SetSigDat(pValue:Str60);
begin
  oTable.FieldByName('SigDat').AsString:=pValue;
end;

function TAgclstDat.GetSigNam:Str30;
begin
  Result:=oTable.FieldByName('SigNam').AsString;
end;

procedure TAgclstDat.SetSigNam(pValue:Str30);
begin
  oTable.FieldByName('SigNam').AsString:=pValue;
end;

function TAgclstDat.GetItmQnt:longint;
begin
  Result:=oTable.FieldByName('ItmQnt').AsInteger;
end;

procedure TAgclstDat.SetItmQnt(pValue:longint);
begin
  oTable.FieldByName('ItmQnt').AsInteger:=pValue;
end;

function TAgclstDat.GetCrtUsr:Str20;
begin
  Result:=oTable.FieldByName('CrtUsr').AsString;
end;

procedure TAgclstDat.SetCrtUsr(pValue:Str20);
begin
  oTable.FieldByName('CrtUsr').AsString:=pValue;
end;

function TAgclstDat.GetCrtUsn:Str30;
begin
  Result:=oTable.FieldByName('CrtUsn').AsString;
end;

procedure TAgclstDat.SetCrtUsn(pValue:Str30);
begin
  oTable.FieldByName('CrtUsn').AsString:=pValue;
end;

function TAgclstDat.GetCrtDte:TDatetime;
begin
  Result:=oTable.FieldByName('CrtDte').AsDateTime;
end;

procedure TAgclstDat.SetCrtDte(pValue:TDatetime);
begin
  oTable.FieldByName('CrtDte').AsDateTime:=pValue;
end;

function TAgclstDat.GetCrtTim:TDatetime;
begin
  Result:=oTable.FieldByName('CrtTim').AsDateTime;
end;

procedure TAgclstDat.SetCrtTim(pValue:TDatetime);
begin
  oTable.FieldByName('CrtTim').AsDateTime:=pValue;
end;

function TAgclstDat.GetModUsr:Str8;
begin
  Result:=oTable.FieldByName('ModUsr').AsString;
end;

procedure TAgclstDat.SetModUsr(pValue:Str8);
begin
  oTable.FieldByName('ModUsr').AsString:=pValue;
end;

function TAgclstDat.GetModDte:TDatetime;
begin
  Result:=oTable.FieldByName('ModDte').AsDateTime;
end;

procedure TAgclstDat.SetModDte(pValue:TDatetime);
begin
  oTable.FieldByName('ModDte').AsDateTime:=pValue;
end;

function TAgclstDat.GetModTim:TDatetime;
begin
  Result:=oTable.FieldByName('ModTim').AsDateTime;
end;

procedure TAgclstDat.SetModTim(pValue:TDatetime);
begin
  oTable.FieldByName('ModTim').AsDateTime:=pValue;
end;

// **************************************** PUBLIC ********************************************

function TAgclstDat.Eof:boolean;
begin
  Result:=oTable.Eof;
end;

function TAgclstDat.IsFirst:boolean;
begin
  Open;
  Result:=oTable.Bof;
end;

function TAgclstDat.IsLast:boolean;
begin
  Open;
  Result:=oTable.Eof;
end;

function TAgclstDat.Active:boolean;
begin
  Result:=oTable.Active;
end;

function TAgclstDat.ActPos:longint;
begin
  Result:=oTable.ActPos;
end;

function TAgclstDat.GotoPos(pActPos:longint): boolean;
begin
  Open;
  If oTable.Filtered and (Count=0) then begin
    oTable.Filtered:=FALSE;
    oTable.Filtered:=TRUE;
  end;
  oTable.Refresh;
  Result:=oTable.GotoPos(pActPos);
end;

function TAgclstDat.FieldNum(pFieldName:Str20):Str3;
begin
  Open;
  Result:=StrInt(oTable.FieldByName(pFieldName).FieldNo-1,0);
end;

function TAgclstDat.LocPaAc(pParNum:longint;pAgcNum:Str30):boolean;
begin
  SetIndex(ixPaAc);
  Result:=oTable.FindKey([pParNum,pAgcNum]);
end;

function TAgclstDat.LocParNum(pParNum:longint):boolean;
begin
  SetIndex(ixParNum);
  Result:=oTable.FindKey([pParNum]);
end;

function TAgclstDat.LocAgcNum(pAgcNum:Str30):boolean;
begin
  SetIndex(ixAgcNum);
  Result:=oTable.FindKey([pAgcNum]);
end;

function TAgclstDat.LocAgcNam(pAgcNam_:Str90):boolean;
begin
  SetIndex(ixAgcNam);
  Result:=oTable.FindKey([StrToAlias(pAgcNam_)]);
end;

function TAgclstDat.NearPaAc(pParNum:longint;pAgcNum:Str30):boolean;
begin
  SetIndex(ixPaAc);
  Result:=oTable.FindNearest([pParNum,pAgcNum]);
end;

function TAgclstDat.NearParNum(pParNum:longint):boolean;
begin
  SetIndex(ixParNum);
  Result:=oTable.FindNearest([pParNum]);
end;

function TAgclstDat.NearAgcNum(pAgcNum:Str30):boolean;
begin
  SetIndex(ixAgcNum);
  Result:=oTable.FindNearest([pAgcNum]);
end;

function TAgclstDat.NearAgcNam(pAgcNam_:Str90):boolean;
begin
  SetIndex(ixAgcNam);
  Result:=oTable.FindNearest([pAgcNam_]);
end;

procedure TAgclstDat.SetIndex(pIndexName:Str20);
begin
  Open;
  If oTable.IndexName<>pIndexName then oTable.IndexName:=pIndexName;
end;

procedure TAgclstDat.Open;
begin
  If not oTable.Active then oTable.Open;
end;

procedure TAgclstDat.Close;
begin
  If oTable.Active then oTable.Close;
end;

procedure TAgclstDat.Prior;
begin
  oTable.Prior;
end;

procedure TAgclstDat.Next;
begin
  oTable.Next;
end;

procedure TAgclstDat.First;
begin
  Open;
  oTable.First;
end;

procedure TAgclstDat.Last;
begin
  Open;
  oTable.Last;
end;

procedure TAgclstDat.Insert;
begin
  Open;
  oTable.Insert;
end;

procedure TAgclstDat.Edit;
begin
  oTable.Edit;
end;

procedure TAgclstDat.Post;
begin
  oTable.Post;
end;

procedure TAgclstDat.Delete;
begin
  oTable.Delete;
end;

procedure TAgclstDat.SwapIndex;
begin
  Open;
  oTable.SwapIndex;
end;

procedure TAgclstDat.RestIndex;
begin
  oTable.RestoreIndex;
end;

procedure TAgclstDat.SwapStatus;
begin
  Open;
  oTable.SwapStatus;
end;

procedure TAgclstDat.RestStatus;
begin
  oTable.RestoreStatus;
end;

procedure TAgclstDat.EnabCont;
begin
  oTable.EnableControls;
end;

procedure TAgclstDat.DisabCont;
begin
  oTable.DisableControls;
end;

end.
{MOD 2001001}
