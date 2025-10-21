unit dEASLST;

interface

uses
  IcTypes, IcConv, NexPath, NexGlob,
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls,
  Dialogs, DB, NexBtrTable, DBTables, NexPxTable;

const
  ixEasNum='EasNum';
  ixEasCod='EasCod';

type
  TEaslstDat=class(TComponent)
    constructor Create; overload;
    destructor Destroy; override;
  private
    oTable:TNexBtrTable;
    function GetCount:integer;
    function FieldExist(pFieldName:Str20):boolean;
    // Prístup k databázovým poliam
    function GetEasNum:word;             procedure SetEasNum(pValue:word);
    function GetEasCod:Str9;             procedure SetEasCod(pValue:Str9);
    function GetEasDes:Str200;           procedure SetEasDes(pValue:Str200);
    function GetItmQnt:word;             procedure SetItmQnt(pValue:word);
    function GetCrtUsr:str8;             procedure SetCrtUsr(pValue:str8);
    function GetCrtDte:TDatetime;        procedure SetCrtDte(pValue:TDatetime);
    function GetCrtTim:TDatetime;        procedure SetCrtTim(pValue:TDatetime);
    function GetSndEml:Str30;            procedure SetSndEml(pValue:Str30);
    function GetCpyEml:Str30;            procedure SetCpyEml(pValue:Str30);
    function GetEmpEml:Str30;            procedure SetEmpEml(pValue:Str30);
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
    function LocEasNum(pEasNum:word):boolean;
    function LocEasCod(pEasCod:Str9):boolean;
    function NearEasNum(pEasNum:word):boolean;
    function NearEasCod(pEasCod:Str9):boolean;

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
    property EasNum:word read GetEasNum write SetEasNum;
    property EasCod:Str9 read GetEasCod write SetEasCod;
    property EasDes:Str200 read GetEasDes write SetEasDes;
    property ItmQnt:word read GetItmQnt write SetItmQnt;
    property CrtUsr:str8 read GetCrtUsr write SetCrtUsr;
    property CrtDte:TDatetime read GetCrtDte write SetCrtDte;
    property CrtTim:TDatetime read GetCrtTim write SetCrtTim;
    property SndEml:Str30 read GetSndEml write SetSndEml;
    property CpyEml:Str30 read GetCpyEml write SetCpyEml;
    property EmpEml:Str30 read GetEmpEml write SetEmpEml;
  end;

implementation

constructor TEaslstDat.Create;
begin
  oTable:=DatInit('EASLST',gPath.SysPath,Self);
end;

constructor TEaslstDat.Create(pPath:ShortString);
begin
  oTable:=DatInit('EASLST',pPath,Self);
end;

destructor TEaslstDat.Destroy;
begin
  oTable.Close;
  FreeAndNil(oTable);
end;

// *************************************** PRIVATE ********************************************

function TEaslstDat.GetCount:integer;
begin
  Open;
  Result:=oTable.RecordCount;
end;

function TEaslstDat.FieldExist(pFieldName:Str20):boolean;
begin
  Result:=oTable.FindField(pFieldName)<>nil;
end;

// ********************* FIELDS *********************

function TEaslstDat.GetEasNum:word;
begin
  Result:=oTable.FieldByName('EasNum').AsInteger;
end;

procedure TEaslstDat.SetEasNum(pValue:word);
begin
  oTable.FieldByName('EasNum').AsInteger:=pValue;
end;

function TEaslstDat.GetEasCod:Str9;
begin
  Result:=oTable.FieldByName('EasCod').AsString;
end;

procedure TEaslstDat.SetEasCod(pValue:Str9);
begin
  oTable.FieldByName('EasCod').AsString:=pValue;
end;

function TEaslstDat.GetEasDes:Str200;
begin
  Result:=oTable.FieldByName('EasDes').AsString;
end;

procedure TEaslstDat.SetEasDes(pValue:Str200);
begin
  oTable.FieldByName('EasDes').AsString:=pValue;
end;

function TEaslstDat.GetItmQnt:word;
begin
  Result:=oTable.FieldByName('ItmQnt').AsInteger;
end;

procedure TEaslstDat.SetItmQnt(pValue:word);
begin
  oTable.FieldByName('ItmQnt').AsInteger:=pValue;
end;

function TEaslstDat.GetCrtUsr:str8;
begin
  Result:=oTable.FieldByName('CrtUsr').AsString;
end;

procedure TEaslstDat.SetCrtUsr(pValue:str8);
begin
  oTable.FieldByName('CrtUsr').AsString:=pValue;
end;

function TEaslstDat.GetCrtDte:TDatetime;
begin
  Result:=oTable.FieldByName('CrtDte').AsDateTime;
end;

procedure TEaslstDat.SetCrtDte(pValue:TDatetime);
begin
  oTable.FieldByName('CrtDte').AsDateTime:=pValue;
end;

function TEaslstDat.GetCrtTim:TDatetime;
begin
  Result:=oTable.FieldByName('CrtTim').AsDateTime;
end;

procedure TEaslstDat.SetCrtTim(pValue:TDatetime);
begin
  oTable.FieldByName('CrtTim').AsDateTime:=pValue;
end;

function TEaslstDat.GetSndEml:Str30;
begin
  Result:=oTable.FieldByName('SndEml').AsString;
end;

procedure TEaslstDat.SetSndEml(pValue:Str30);
begin
  oTable.FieldByName('SndEml').AsString:=pValue;
end;

function TEaslstDat.GetCpyEml:Str30;
begin
  Result:=oTable.FieldByName('CpyEml').AsString;
end;

procedure TEaslstDat.SetCpyEml(pValue:Str30);
begin
  oTable.FieldByName('CpyEml').AsString:=pValue;
end;

function TEaslstDat.GetEmpEml:Str30;
begin
  Result:=oTable.FieldByName('EmpEml').AsString;
end;

procedure TEaslstDat.SetEmpEml(pValue:Str30);
begin
  oTable.FieldByName('EmpEml').AsString:=pValue;
end;

// **************************************** PUBLIC ********************************************

function TEaslstDat.Eof:boolean;
begin
  Result:=oTable.Eof;
end;

function TEaslstDat.IsFirst:boolean;
begin
  Open;
  Result:=oTable.Bof;
end;

function TEaslstDat.IsLast:boolean;
begin
  Open;
  Result:=oTable.Eof;
end;

function TEaslstDat.Active:boolean;
begin
  Result:=oTable.Active;
end;

function TEaslstDat.ActPos:longint;
begin
  Result:=oTable.ActPos;
end;

function TEaslstDat.GotoPos(pActPos:longint): boolean;
begin
  Open;
  If oTable.Filtered and (Count=0) then begin
    oTable.Filtered:=FALSE;
    oTable.Filtered:=TRUE;
  end;
  oTable.Refresh;
  Result:=oTable.GotoPos(pActPos);
end;

function TEaslstDat.FieldNum(pFieldName:Str20):Str3;
begin
  Open;
  Result:=StrInt(oTable.FieldByName(pFieldName).FieldNo-1,0);
end;

function TEaslstDat.LocEasNum(pEasNum:word):boolean;
begin
  SetIndex(ixEasNum);
  Result:=oTable.FindKey([pEasNum]);
end;

function TEaslstDat.LocEasCod(pEasCod:Str9):boolean;
begin
  SetIndex(ixEasCod);
  Result:=oTable.FindKey([pEasCod]);
end;

function TEaslstDat.NearEasNum(pEasNum:word):boolean;
begin
  SetIndex(ixEasNum);
  Result:=oTable.FindNearest([pEasNum]);
end;

function TEaslstDat.NearEasCod(pEasCod:Str9):boolean;
begin
  SetIndex(ixEasCod);
  Result:=oTable.FindNearest([pEasCod]);
end;

procedure TEaslstDat.SetIndex(pIndexName:Str20);
begin
  Open;
  If oTable.IndexName<>pIndexName then oTable.IndexName:=pIndexName;
end;

procedure TEaslstDat.Open;
begin
  If not oTable.Active then oTable.Open;
end;

procedure TEaslstDat.Close;
begin
  If oTable.Active then oTable.Close;
end;

procedure TEaslstDat.Prior;
begin
  oTable.Prior;
end;

procedure TEaslstDat.Next;
begin
  oTable.Next;
end;

procedure TEaslstDat.First;
begin
  Open;
  oTable.First;
end;

procedure TEaslstDat.Last;
begin
  Open;
  oTable.Last;
end;

procedure TEaslstDat.Insert;
begin
  Open;
  oTable.Insert;
end;

procedure TEaslstDat.Edit;
begin
  oTable.Edit;
end;

procedure TEaslstDat.Post;
begin
  oTable.Post;
end;

procedure TEaslstDat.Delete;
begin
  oTable.Delete;
end;

procedure TEaslstDat.SwapIndex;
begin
  Open;
  oTable.SwapIndex;
end;

procedure TEaslstDat.RestIndex;
begin
  oTable.RestoreIndex;
end;

procedure TEaslstDat.SwapStatus;
begin
  Open;
  oTable.SwapStatus;
end;

procedure TEaslstDat.RestStatus;
begin
  oTable.RestoreStatus;
end;

procedure TEaslstDat.EnabCont;
begin
  oTable.EnableControls;
end;

procedure TEaslstDat.DisabCont;
begin
  oTable.DisableControls;
end;

end.
{MOD 2001001}
