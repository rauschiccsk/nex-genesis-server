unit dEDIDOC;

interface

uses
  IcTypes, IcConv, NexPath, NexGlob,
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls,
  Dialogs, DB, NexBtrTable, DBTables, NexPxTable;

const
  ixExtNum='ExtNum';
  ixOrdNum='OrdNum';
  ixDocDte='DocDte';
  ixParNam='ParNam';

type
  TEdidocDat=class(TComponent)
    constructor Create; overload;
    destructor Destroy; override;
  private
    oTable:TNexBtrTable;
    function GetCount:integer;
    function FieldExist(pFieldName:Str20):boolean;
    // Prístup k databázovým poliam
    function GetExtNum:Str12;            procedure SetExtNum(pValue:Str12);
    function GetOrdNum:Str12;            procedure SetOrdNum(pValue:Str12);
    function GetDocDte:TDatetime;        procedure SetDocDte(pValue:TDatetime);
    function GetDlvDte:TDatetime;        procedure SetDlvDte(pValue:TDatetime);
    function GetParNum:longint;          procedure SetParNum(pValue:longint);
    function GetParNam:Str60;            procedure SetParNam(pValue:Str60);
    function GetParNam_:Str60;           procedure SetParNam_(pValue:Str60);
    function GetDocAva:double;           procedure SetDocAva(pValue:double);
    function GetDocBva:double;           procedure SetDocBva(pValue:double);
    function GetDvzNam:Str3;             procedure SetDvzNam(pValue:Str3);
    function GetDocTyp:Str1;             procedure SetDocTyp(pValue:Str1);
    function GetEdfNam:Str50;            procedure SetEdfNam(pValue:Str50);
    function GetItmQnt:word;             procedure SetItmQnt(pValue:word);
    function GetNidQnt:word;             procedure SetNidQnt(pValue:word);
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
    function LocExtNum(pExtNum:Str12):boolean;
    function LocOrdNum(pordNum:Str12):boolean;
    function LocDocDte(pDocDte:TDatetime):boolean;
    function LocParNam(pParNam_:Str60):boolean;
    function NearExtNum(pExtNum:Str12):boolean;
    function NearOrdNum(pordNum:Str12):boolean;
    function NearDocDte(pDocDte:TDatetime):boolean;
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
    property ExtNum:Str12 read GetExtNum write SetExtNum;
    property OrdNum:Str12 read GetOrdNum write SetOrdNum;
    property DocDte:TDatetime read GetDocDte write SetDocDte;
    property DlvDte:TDatetime read GetDlvDte write SetDlvDte;
    property ParNum:longint read GetParNum write SetParNum;
    property ParNam:Str60 read GetParNam write SetParNam;
    property ParNam_:Str60 read GetParNam_ write SetParNam_;
    property DocAva:double read GetDocAva write SetDocAva;
    property DocBva:double read GetDocBva write SetDocBva;
    property DvzNam:Str3 read GetDvzNam write SetDvzNam;
    property DocTyp:Str1 read GetDocTyp write SetDocTyp;
    property EdfNam:Str50 read GetEdfNam write SetEdfNam;
    property ItmQnt:word read GetItmQnt write SetItmQnt;
    property NidQnt:word read GetNidQnt write SetNidQnt;
  end;

implementation

constructor TEdidocDat.Create;
begin
  oTable:=DatInit('EDIDOC',gPath.StkPath,Self);
end;

constructor TEdidocDat.Create(pPath:ShortString);
begin
  oTable:=DatInit('EDIDOC',pPath,Self);
end;

destructor TEdidocDat.Destroy;
begin
  oTable.Close;
  FreeAndNil(oTable);
end;

// *************************************** PRIVATE ********************************************

function TEdidocDat.GetCount:integer;
begin
  Open;
  Result:=oTable.RecordCount;
end;

function TEdidocDat.FieldExist(pFieldName:Str20):boolean;
begin
  Result:=oTable.FindField(pFieldName)<>nil;
end;

// ********************* FIELDS *********************

function TEdidocDat.GetExtNum:Str12;
begin
  Result:=oTable.FieldByName('ExtNum').AsString;
end;

procedure TEdidocDat.SetExtNum(pValue:Str12);
begin
  oTable.FieldByName('ExtNum').AsString:=pValue;
end;

function TEdidocDat.GetOrdNum:Str12;
begin
  Result:=oTable.FieldByName('OrdNum').AsString;
end;

procedure TEdidocDat.SetOrdNum(pValue:Str12);
begin
  oTable.FieldByName('OrdNum').AsString:=pValue;
end;

function TEdidocDat.GetDocDte:TDatetime;
begin
  Result:=oTable.FieldByName('DocDte').AsDateTime;
end;

procedure TEdidocDat.SetDocDte(pValue:TDatetime);
begin
  oTable.FieldByName('DocDte').AsDateTime:=pValue;
end;

function TEdidocDat.GetDlvDte:TDatetime;
begin
  Result:=oTable.FieldByName('DlvDte').AsDateTime;
end;

procedure TEdidocDat.SetDlvDte(pValue:TDatetime);
begin
  oTable.FieldByName('DlvDte').AsDateTime:=pValue;
end;

function TEdidocDat.GetParNum:longint;
begin
  Result:=oTable.FieldByName('ParNum').AsInteger;
end;

procedure TEdidocDat.SetParNum(pValue:longint);
begin
  oTable.FieldByName('ParNum').AsInteger:=pValue;
end;

function TEdidocDat.GetParNam:Str60;
begin
  Result:=oTable.FieldByName('ParNam').AsString;
end;

procedure TEdidocDat.SetParNam(pValue:Str60);
begin
  oTable.FieldByName('ParNam').AsString:=pValue;
end;

function TEdidocDat.GetParNam_:Str60;
begin
  Result:=oTable.FieldByName('ParNam_').AsString;
end;

procedure TEdidocDat.SetParNam_(pValue:Str60);
begin
  oTable.FieldByName('ParNam_').AsString:=pValue;
end;

function TEdidocDat.GetDocAva:double;
begin
  Result:=oTable.FieldByName('DocAva').AsFloat;
end;

procedure TEdidocDat.SetDocAva(pValue:double);
begin
  oTable.FieldByName('DocAva').AsFloat:=pValue;
end;

function TEdidocDat.GetDocBva:double;
begin
  Result:=oTable.FieldByName('DocBva').AsFloat;
end;

procedure TEdidocDat.SetDocBva(pValue:double);
begin
  oTable.FieldByName('DocBva').AsFloat:=pValue;
end;

function TEdidocDat.GetDvzNam:Str3;
begin
  Result:=oTable.FieldByName('DvzNam').AsString;
end;

procedure TEdidocDat.SetDvzNam(pValue:Str3);
begin
  oTable.FieldByName('DvzNam').AsString:=pValue;
end;

function TEdidocDat.GetDocTyp:Str1;
begin
  Result:=oTable.FieldByName('DocTyp').AsString;
end;

procedure TEdidocDat.SetDocTyp(pValue:Str1);
begin
  oTable.FieldByName('DocTyp').AsString:=pValue;
end;

function TEdidocDat.GetEdfNam:Str50;
begin
  Result:=oTable.FieldByName('EdfNam').AsString;
end;

procedure TEdidocDat.SetEdfNam(pValue:Str50);
begin
  oTable.FieldByName('EdfNam').AsString:=pValue;
end;

function TEdidocDat.GetItmQnt:word;
begin
  Result:=oTable.FieldByName('ItmQnt').AsInteger;
end;

procedure TEdidocDat.SetItmQnt(pValue:word);
begin
  oTable.FieldByName('ItmQnt').AsInteger:=pValue;
end;

function TEdidocDat.GetNidQnt:word;
begin
  Result:=oTable.FieldByName('NidQnt').AsInteger;
end;

procedure TEdidocDat.SetNidQnt(pValue:word);
begin
  oTable.FieldByName('NidQnt').AsInteger:=pValue;
end;

// **************************************** PUBLIC ********************************************

function TEdidocDat.Eof:boolean;
begin
  Result:=oTable.Eof;
end;

function TEdidocDat.IsFirst:boolean;
begin
  Open;
  Result:=oTable.Bof;
end;

function TEdidocDat.IsLast:boolean;
begin
  Open;
  Result:=oTable.Eof;
end;

function TEdidocDat.Active:boolean;
begin
  Result:=oTable.Active;
end;

function TEdidocDat.ActPos:longint;
begin
  Result:=oTable.ActPos;
end;

function TEdidocDat.GotoPos(pActPos:longint): boolean;
begin
  Open;
  If oTable.Filtered and (Count=0) then begin
    oTable.Filtered:=FALSE;
    oTable.Filtered:=TRUE;
  end;
  oTable.Refresh;
  Result:=oTable.GotoPos(pActPos);
end;

function TEdidocDat.FieldNum(pFieldName:Str20):Str3;
begin
  Open;
  Result:=StrInt(oTable.FieldByName(pFieldName).FieldNo-1,0);
end;

function TEdidocDat.LocExtNum(pExtNum:Str12):boolean;
begin
  SetIndex(ixExtNum);
  Result:=oTable.FindKey([pExtNum]);
end;

function TEdidocDat.LocOrdNum(pordNum:Str12):boolean;
begin
  SetIndex(ixOrdNum);
  Result:=oTable.FindKey([pordNum]);
end;

function TEdidocDat.LocDocDte(pDocDte:TDatetime):boolean;
begin
  SetIndex(ixDocDte);
  Result:=oTable.FindKey([pDocDte]);
end;

function TEdidocDat.LocParNam(pParNam_:Str60):boolean;
begin
  SetIndex(ixParNam);
  Result:=oTable.FindKey([StrToAlias(pParNam_)]);
end;

function TEdidocDat.NearExtNum(pExtNum:Str12):boolean;
begin
  SetIndex(ixExtNum);
  Result:=oTable.FindNearest([pExtNum]);
end;

function TEdidocDat.NearOrdNum(pordNum:Str12):boolean;
begin
  SetIndex(ixOrdNum);
  Result:=oTable.FindNearest([pordNum]);
end;

function TEdidocDat.NearDocDte(pDocDte:TDatetime):boolean;
begin
  SetIndex(ixDocDte);
  Result:=oTable.FindNearest([pDocDte]);
end;

function TEdidocDat.NearParNam(pParNam_:Str60):boolean;
begin
  SetIndex(ixParNam);
  Result:=oTable.FindNearest([pParNam_]);
end;

procedure TEdidocDat.SetIndex(pIndexName:Str20);
begin
  Open;
  If oTable.IndexName<>pIndexName then oTable.IndexName:=pIndexName;
end;

procedure TEdidocDat.Open;
begin
  If not oTable.Active then oTable.Open;
end;

procedure TEdidocDat.Close;
begin
  If oTable.Active then oTable.Close;
end;

procedure TEdidocDat.Prior;
begin
  oTable.Prior;
end;

procedure TEdidocDat.Next;
begin
  oTable.Next;
end;

procedure TEdidocDat.First;
begin
  Open;
  oTable.First;
end;

procedure TEdidocDat.Last;
begin
  Open;
  oTable.Last;
end;

procedure TEdidocDat.Insert;
begin
  Open;
  oTable.Insert;
end;

procedure TEdidocDat.Edit;
begin
  oTable.Edit;
end;

procedure TEdidocDat.Post;
begin
  oTable.Post;
end;

procedure TEdidocDat.Delete;
begin
  oTable.Delete;
end;

procedure TEdidocDat.SwapIndex;
begin
  Open;
  oTable.SwapIndex;
end;

procedure TEdidocDat.RestIndex;
begin
  oTable.RestoreIndex;
end;

procedure TEdidocDat.SwapStatus;
begin
  Open;
  oTable.SwapStatus;
end;

procedure TEdidocDat.RestStatus;
begin
  oTable.RestoreStatus;
end;

procedure TEdidocDat.EnabCont;
begin
  oTable.EnableControls;
end;

procedure TEdidocDat.DisabCont;
begin
  oTable.DisableControls;
end;

end.
{MOD 2011001}
