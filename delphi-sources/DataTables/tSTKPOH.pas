unit tSTKPOH;

interface

uses
  IcTypes, IcConv, NexPath, NexGlob, DocHand, 
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls,
  Dialogs, DB, NexBtrTable, DBTables, NexPxTable;

const
  ixDnIn='';

type
  TStkpohTmp=class(TComponent)
    constructor Create;
    destructor Destroy; override;
  private
    oTmpTable: TNexPxTable;
    function GetCount:integer;
    function FieldExist (pFieldName:ShortString): boolean;
    // Pristup k databazovym poliam
    function GetDocNum:Str12;            procedure SetDocNum (pValue:Str12);
    function GetItmNum:longint;          procedure SetItmNum (pValue:longint);
    function GetMovPrq:double;           procedure SetMovPrq (pValue:double);
    function GetRmiPos:Str15;            procedure SetRmiPos (pValue:Str15);
    function GetRmoPos:Str15;            procedure SetRmoPos (pValue:Str15);
    function GetCrtUsr:str10;            procedure SetCrtUsr (pValue:str10);
    function GetCrtDte:TDatetime;        procedure SetCrtDte (pValue:TDatetime);
    function GetCrtTim:TDatetime;        procedure SetCrtTim (pValue:TDatetime);
    function GetActPos:longint;          procedure SetActPos (pValue:longint);
  public
    // Elementarne databazove operacie
    function Eof:boolean;
    function Active:boolean;
    function LocDnIn (pDocNum:Str12;pItmNum:longint):boolean;

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
    property DocNum:Str12 read GetDocNum write SetDocNum;
    property ItmNum:longint read GetItmNum write SetItmNum;
    property MovPrq:double read GetMovPrq write SetMovPrq;
    property RmiPos:Str15 read GetRmiPos write SetRmiPos;
    property RmoPos:Str15 read GetRmoPos write SetRmoPos;
    property CrtUsr:str10 read GetCrtUsr write SetCrtUsr;
    property CrtDte:TDatetime read GetCrtDte write SetCrtDte;
    property CrtTim:TDatetime read GetCrtTim write SetCrtTim;
    property ActPos:longint read GetActPos write SetActPos;
  end;

implementation

constructor TStkpohTmp.Create;
begin
  oTmpTable:=TmpInit ('STKPOH',Self);
end;

destructor TStkpohTmp.Destroy;
begin
  If oTmpTable.Active then oTmpTable.Close;
  FreeAndNil(oTmpTable);
end;

// *************************************** PRIVATE ********************************************

function TStkpohTmp.GetCount:integer;
begin
  Result:=oTmpTable.RecordCount;
end;

function TStkpohTmp.FieldExist(pFieldName:ShortString):boolean;
begin
  Result:=oTmpTable.FindField(pFieldName)<>nil;
end;

function TStkpohTmp.GetDocNum:Str12;
begin
  Result:=oTmpTable.FieldByName('DocNum').AsString;
end;

procedure TStkpohTmp.SetDocNum(pValue:Str12);
begin
  oTmpTable.FieldByName('DocNum').AsString:=pValue;
end;

function TStkpohTmp.GetItmNum:longint;
begin
  Result:=oTmpTable.FieldByName('ItmNum').AsInteger;
end;

procedure TStkpohTmp.SetItmNum(pValue:longint);
begin
  oTmpTable.FieldByName('ItmNum').AsInteger:=pValue;
end;

function TStkpohTmp.GetMovPrq:double;
begin
  Result:=oTmpTable.FieldByName('MovPrq').AsFloat;
end;

procedure TStkpohTmp.SetMovPrq(pValue:double);
begin
  oTmpTable.FieldByName('MovPrq').AsFloat:=pValue;
end;

function TStkpohTmp.GetRmiPos:Str15;
begin
  Result:=oTmpTable.FieldByName('RmiPos').AsString;
end;

procedure TStkpohTmp.SetRmiPos(pValue:Str15);
begin
  oTmpTable.FieldByName('RmiPos').AsString:=pValue;
end;

function TStkpohTmp.GetRmoPos:Str15;
begin
  Result:=oTmpTable.FieldByName('RmoPos').AsString;
end;

procedure TStkpohTmp.SetRmoPos(pValue:Str15);
begin
  oTmpTable.FieldByName('RmoPos').AsString:=pValue;
end;

function TStkpohTmp.GetCrtUsr:str10;
begin
  Result:=oTmpTable.FieldByName('CrtUsr').AsString;
end;

procedure TStkpohTmp.SetCrtUsr(pValue:str10);
begin
  oTmpTable.FieldByName('CrtUsr').AsString:=pValue;
end;

function TStkpohTmp.GetCrtDte:TDatetime;
begin
  Result:=oTmpTable.FieldByName('CrtDte').AsDateTime;
end;

procedure TStkpohTmp.SetCrtDte(pValue:TDatetime);
begin
  oTmpTable.FieldByName('CrtDte').AsDateTime:=pValue;
end;

function TStkpohTmp.GetCrtTim:TDatetime;
begin
  Result:=oTmpTable.FieldByName('CrtTim').AsDateTime;
end;

procedure TStkpohTmp.SetCrtTim(pValue:TDatetime);
begin
  oTmpTable.FieldByName('CrtTim').AsDateTime:=pValue;
end;

function TStkpohTmp.GetActPos:longint;
begin
  Result:=oTmpTable.FieldByName('ActPos').AsInteger;
end;

procedure TStkpohTmp.SetActPos(pValue:longint);
begin
  oTmpTable.FieldByName('ActPos').AsInteger:=pValue;
end;

// **************************************** PUBLIC ********************************************

function TStkpohTmp.Eof:boolean;
begin
  Result:=oTmpTable.Eof;
end;

function TStkpohTmp.Active:boolean;
begin
  Result:=oTmpTable.Active;
end;

function TStkpohTmp.LocDnIn(pDocNum:Str12;pItmNum:longint):boolean;
begin
  SetIndex (ixDnIn);
  Result:=oTmpTable.FindKey([pDocNum,pItmNum]);
end;

procedure TStkpohTmp.SetIndex(pIndexName:ShortString);
begin
  If oTmpTable.IndexName<>pIndexName then oTmpTable.IndexName:=pIndexName;
end;

procedure TStkpohTmp.Open;
begin
  oTmpTable.Open;
end;

procedure TStkpohTmp.Close;
begin
  If oTmpTable.Active then oTmpTable.Close;
end;

procedure TStkpohTmp.Prior;
begin
  oTmpTable.Prior;
end;

procedure TStkpohTmp.Next;
begin
  oTmpTable.Next;
end;

procedure TStkpohTmp.First;
begin
  oTmpTable.First;
end;

procedure TStkpohTmp.Last;
begin
  oTmpTable.Last;
end;

procedure TStkpohTmp.Insert;
begin
  oTmpTable.Insert;
end;

procedure TStkpohTmp.Edit;
begin
  oTmpTable.Edit;
end;

procedure TStkpohTmp.Post;
var mEdit:boolean;
begin
  oTmpTable.Post;
end;

procedure TStkpohTmp.Delete;
begin
  oTmpTable.Delete;
end;

procedure TStkpohTmp.SwapIndex;
begin
  oTmpTable.SwapIndex;
end;

procedure TStkpohTmp.RestIndex;
begin
  oTmpTable.RestoreIndex;
end;

procedure TStkpohTmp.SwapStatus;
begin
  oTmpTable.SwapStatus;
end;

procedure TStkpohTmp.RestStatus;
begin
  oTmpTable.RestoreStatus;
end;

procedure TStkpohTmp.EnabCont;
begin
  oTmpTable.EnableControls;
end;

procedure TStkpohTmp.DisabCont;
begin
  oTmpTable.DisableControls;
end;

end.
{MOD 2011001}
