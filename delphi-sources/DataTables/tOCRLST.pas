unit tOCRLST;

interface

uses
  IcTypes, IcConv, NexPath, NexGlob, DocHand, 
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls,
  Dialogs, DB, NexBtrTable, DBTables, NexPxTable;

const
  ixOcOs='';
  ixOcdPar='OcdPar';
  ixOsdPar='OsdPar';

type
  TOcrlstTmp=class(TComponent)
    constructor Create;
    destructor Destroy; override;
  private
    oTmpTable: TNexPxTable;
    function GetCount:integer;
    function FieldExist (pFieldName:ShortString): boolean;
    // Pristup k databazovym poliam
    function GetOciAdr:longint;          procedure SetOciAdr (pValue:longint);
    function GetOsiAdr:longint;          procedure SetOsiAdr (pValue:longint);
    function GetOcdNum:Str12;            procedure SetOcdNum (pValue:Str12);
    function GetOcdItm:word;             procedure SetOcdItm (pValue:word);
    function GetOcdPar:longint;          procedure SetOcdPar (pValue:longint);
    function GetOcdPan:Str60;            procedure SetOcdPan (pValue:Str60);
    function GetOcdDte:TDatetime;        procedure SetOcdDte (pValue:TDatetime);
    function GetResPrq:double;           procedure SetResPrq (pValue:double);
    function GetReqDte:TDatetime;        procedure SetReqDte (pValue:TDatetime);
    function GetRatDte:TDatetime;        procedure SetRatDte (pValue:TDatetime);
    function GetOsdNum:Str13;            procedure SetOsdNum (pValue:Str13);
    function GetOsdItm:word;             procedure SetOsdItm (pValue:word);
    function GetOsdPar:longint;          procedure SetOsdPar (pValue:longint);
    function GetOsdPan:Str60;            procedure SetOsdPan (pValue:Str60);
  public
    // Elementarne databazove operacie
    function Eof:boolean;
    function Active:boolean;
    function LocOcOs (pOciAdr:longint;pOsiAdr:longint):boolean;
    function LocOcdPar (pOcdPar:longint):boolean;
    function LocOsdPar (pOsdPar:longint):boolean;

    procedure SetIndex(pIndexName:ShortString);
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
    property TmpTable:TNexPxTable read oTmpTable write oTmpTable;
    property Count:integer read GetCount;
    property OciAdr:longint read GetOciAdr write SetOciAdr;
    property OsiAdr:longint read GetOsiAdr write SetOsiAdr;
    property OcdNum:Str12 read GetOcdNum write SetOcdNum;
    property OcdItm:word read GetOcdItm write SetOcdItm;
    property OcdPar:longint read GetOcdPar write SetOcdPar;
    property OcdPan:Str60 read GetOcdPan write SetOcdPan;
    property OcdDte:TDatetime read GetOcdDte write SetOcdDte;
    property ResPrq:double read GetResPrq write SetResPrq;
    property ReqDte:TDatetime read GetReqDte write SetReqDte;
    property RatDte:TDatetime read GetRatDte write SetRatDte;
    property OsdNum:Str13 read GetOsdNum write SetOsdNum;
    property OsdItm:word read GetOsdItm write SetOsdItm;
    property OsdPar:longint read GetOsdPar write SetOsdPar;
    property OsdPan:Str60 read GetOsdPan write SetOsdPan;
  end;

implementation

constructor TOcrlstTmp.Create;
begin
  oTmpTable:=TmpInit ('OCRLST',Self);
end;

destructor TOcrlstTmp.Destroy;
begin
  If oTmpTable.Active then oTmpTable.Close;
  FreeAndNil(oTmpTable);
end;

// *************************************** PRIVATE ********************************************

function TOcrlstTmp.GetCount:integer;
begin
  Result:=oTmpTable.RecordCount;
end;

function TOcrlstTmp.FieldExist(pFieldName:ShortString):boolean;
begin
  Result:=oTmpTable.FindField(pFieldName)<>nil;
end;

function TOcrlstTmp.GetOciAdr:longint;
begin
  Result:=oTmpTable.FieldByName('OciAdr').AsInteger;
end;

procedure TOcrlstTmp.SetOciAdr(pValue:longint);
begin
  oTmpTable.FieldByName('OciAdr').AsInteger:=pValue;
end;

function TOcrlstTmp.GetOsiAdr:longint;
begin
  Result:=oTmpTable.FieldByName('OsiAdr').AsInteger;
end;

procedure TOcrlstTmp.SetOsiAdr(pValue:longint);
begin
  oTmpTable.FieldByName('OsiAdr').AsInteger:=pValue;
end;

function TOcrlstTmp.GetOcdNum:Str12;
begin
  Result:=oTmpTable.FieldByName('OcdNum').AsString;
end;

procedure TOcrlstTmp.SetOcdNum(pValue:Str12);
begin
  oTmpTable.FieldByName('OcdNum').AsString:=pValue;
end;

function TOcrlstTmp.GetOcdItm:word;
begin
  Result:=oTmpTable.FieldByName('OcdItm').AsInteger;
end;

procedure TOcrlstTmp.SetOcdItm(pValue:word);
begin
  oTmpTable.FieldByName('OcdItm').AsInteger:=pValue;
end;

function TOcrlstTmp.GetOcdPar:longint;
begin
  Result:=oTmpTable.FieldByName('OcdPar').AsInteger;
end;

procedure TOcrlstTmp.SetOcdPar(pValue:longint);
begin
  oTmpTable.FieldByName('OcdPar').AsInteger:=pValue;
end;

function TOcrlstTmp.GetOcdPan:Str60;
begin
  Result:=oTmpTable.FieldByName('OcdPan').AsString;
end;

procedure TOcrlstTmp.SetOcdPan(pValue:Str60);
begin
  oTmpTable.FieldByName('OcdPan').AsString:=pValue;
end;

function TOcrlstTmp.GetOcdDte:TDatetime;
begin
  Result:=oTmpTable.FieldByName('OcdDte').AsDateTime;
end;

procedure TOcrlstTmp.SetOcdDte(pValue:TDatetime);
begin
  oTmpTable.FieldByName('OcdDte').AsDateTime:=pValue;
end;

function TOcrlstTmp.GetResPrq:double;
begin
  Result:=oTmpTable.FieldByName('ResPrq').AsFloat;
end;

procedure TOcrlstTmp.SetResPrq(pValue:double);
begin
  oTmpTable.FieldByName('ResPrq').AsFloat:=pValue;
end;

function TOcrlstTmp.GetReqDte:TDatetime;
begin
  Result:=oTmpTable.FieldByName('ReqDte').AsDateTime;
end;

procedure TOcrlstTmp.SetReqDte(pValue:TDatetime);
begin
  oTmpTable.FieldByName('ReqDte').AsDateTime:=pValue;
end;

function TOcrlstTmp.GetRatDte:TDatetime;
begin
  Result:=oTmpTable.FieldByName('RatDte').AsDateTime;
end;

procedure TOcrlstTmp.SetRatDte(pValue:TDatetime);
begin
  oTmpTable.FieldByName('RatDte').AsDateTime:=pValue;
end;

function TOcrlstTmp.GetOsdNum:Str13;
begin
  Result:=oTmpTable.FieldByName('OsdNum').AsString;
end;

procedure TOcrlstTmp.SetOsdNum(pValue:Str13);
begin
  oTmpTable.FieldByName('OsdNum').AsString:=pValue;
end;

function TOcrlstTmp.GetOsdItm:word;
begin
  Result:=oTmpTable.FieldByName('OsdItm').AsInteger;
end;

procedure TOcrlstTmp.SetOsdItm(pValue:word);
begin
  oTmpTable.FieldByName('OsdItm').AsInteger:=pValue;
end;

function TOcrlstTmp.GetOsdPar:longint;
begin
  Result:=oTmpTable.FieldByName('OsdPar').AsInteger;
end;

procedure TOcrlstTmp.SetOsdPar(pValue:longint);
begin
  oTmpTable.FieldByName('OsdPar').AsInteger:=pValue;
end;

function TOcrlstTmp.GetOsdPan:Str60;
begin
  Result:=oTmpTable.FieldByName('OsdPan').AsString;
end;

procedure TOcrlstTmp.SetOsdPan(pValue:Str60);
begin
  oTmpTable.FieldByName('OsdPan').AsString:=pValue;
end;

// **************************************** PUBLIC ********************************************

function TOcrlstTmp.Eof:boolean;
begin
  Result:=oTmpTable.Eof;
end;

function TOcrlstTmp.Active:boolean;
begin
  Result:=oTmpTable.Active;
end;

function TOcrlstTmp.LocOcOs(pOciAdr:longint;pOsiAdr:longint):boolean;
begin
  SetIndex (ixOcOs);
  Result:=oTmpTable.FindKey([pOciAdr,pOsiAdr]);
end;

function TOcrlstTmp.LocOcdPar(pOcdPar:longint):boolean;
begin
  SetIndex (ixOcdPar);
  Result:=oTmpTable.FindKey([pOcdPar]);
end;

function TOcrlstTmp.LocOsdPar(pOsdPar:longint):boolean;
begin
  SetIndex (ixOsdPar);
  Result:=oTmpTable.FindKey([pOsdPar]);
end;

procedure TOcrlstTmp.SetIndex(pIndexName:ShortString);
begin
  If oTmpTable.IndexName<>pIndexName then oTmpTable.IndexName:=pIndexName;
end;

procedure TOcrlstTmp.Open;
begin
  oTmpTable.Open;
end;

procedure TOcrlstTmp.Close;
begin
  If oTmpTable.Active then oTmpTable.Close;
end;

procedure TOcrlstTmp.Prior;
begin
  oTmpTable.Prior;
end;

procedure TOcrlstTmp.Next;
begin
  oTmpTable.Next;
end;

procedure TOcrlstTmp.First;
begin
  oTmpTable.First;
end;

procedure TOcrlstTmp.Last;
begin
  oTmpTable.Last;
end;

procedure TOcrlstTmp.Insert;
begin
  oTmpTable.Insert;
end;

procedure TOcrlstTmp.Edit;
begin
  oTmpTable.Edit;
end;

procedure TOcrlstTmp.Post;
var mEdit:boolean;
begin
  oTmpTable.Post;
end;

procedure TOcrlstTmp.Delete;
begin
  oTmpTable.Delete;
end;

procedure TOcrlstTmp.SwapIndex;
begin
  oTmpTable.SwapIndex;
end;

procedure TOcrlstTmp.RestIndex;
begin
  oTmpTable.RestoreIndex;
end;

procedure TOcrlstTmp.SwapStatus;
begin
  oTmpTable.SwapStatus;
end;

procedure TOcrlstTmp.RestStatus;
begin
  oTmpTable.RestoreStatus;
end;

procedure TOcrlstTmp.EnabCont;
begin
  oTmpTable.EnableControls;
end;

procedure TOcrlstTmp.DisabCont;
begin
  oTmpTable.DisableControls;
end;

end.
{MOD 2008001}
