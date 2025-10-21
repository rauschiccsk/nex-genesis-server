unit tOCMDLV;

interface

uses
  IcTypes, IcConv, NexPath, NexGlob, DocHand, 
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls,
  Dialogs, DB, NexBtrTable, DBTables, NexPxTable;

const
  ixOnIt='';
  ixProNum='ProNum';
  ixProNam_='ProNam_';

type
  TOcmdlvTmp=class(TComponent)
    constructor Create;
    destructor Destroy; override;
  private
    oTmpTable: TNexPxTable;
    function GetCount:integer;
    function FieldExist (pFieldName:ShortString): boolean;
    // Pristup k databazovym poliam
    function GetOcdNum:Str12;            procedure SetOcdNum (pValue:Str12);
    function GetOciNum:longint;          procedure SetOciNum (pValue:longint);
    function GetProNum:longint;          procedure SetProNum (pValue:longint);
    function GetProNam:Str60;            procedure SetProNam (pValue:Str60);
    function GetProNam_:Str60;           procedure SetProNam_ (pValue:Str60);
    function GetOcdDvq:double;           procedure SetOcdDvq (pValue:double);
    function GetTcdDvq:double;           procedure SetTcdDvq (pValue:double);
    function GetDifDvq:double;           procedure SetDifDvq (pValue:double);
    function GetOcdExq:double;           procedure SetOcdExq (pValue:double);
    function GetTcdExq:double;           procedure SetTcdExq (pValue:double);
    function GetDifExq:double;           procedure SetDifExq (pValue:double);
    function GetTcdNum:Str12;            procedure SetTcdNum (pValue:Str12);
    function GetTciNum:longint;          procedure SetTciNum (pValue:longint);
  public
    // Elementarne databazove operacie
    function Eof:boolean;
    function Active:boolean;
    function LocOnIt (pOcdNum:Str12;pOciNum:longint):boolean;
    function LocProNum (pProNum:longint):boolean;
    function LocProNam_ (pProNam_:Str60):boolean;

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
    property OcdNum:Str12 read GetOcdNum write SetOcdNum;
    property OciNum:longint read GetOciNum write SetOciNum;
    property ProNum:longint read GetProNum write SetProNum;
    property ProNam:Str60 read GetProNam write SetProNam;
    property ProNam_:Str60 read GetProNam_ write SetProNam_;
    property OcdDvq:double read GetOcdDvq write SetOcdDvq;
    property TcdDvq:double read GetTcdDvq write SetTcdDvq;
    property DifDvq:double read GetDifDvq write SetDifDvq;
    property OcdExq:double read GetOcdExq write SetOcdExq;
    property TcdExq:double read GetTcdExq write SetTcdExq;
    property DifExq:double read GetDifExq write SetDifExq;
    property TcdNum:Str12 read GetTcdNum write SetTcdNum;
    property TciNum:longint read GetTciNum write SetTciNum;
  end;

implementation

constructor TOcmdlvTmp.Create;
begin
  oTmpTable:=TmpInit ('OCMDLV',Self);
end;

destructor TOcmdlvTmp.Destroy;
begin
  If oTmpTable.Active then oTmpTable.Close;
  FreeAndNil(oTmpTable);
end;

// *************************************** PRIVATE ********************************************

function TOcmdlvTmp.GetCount:integer;
begin
  Result:=oTmpTable.RecordCount;
end;

function TOcmdlvTmp.FieldExist(pFieldName:ShortString):boolean;
begin
  Result:=oTmpTable.FindField(pFieldName)<>nil;
end;

function TOcmdlvTmp.GetOcdNum:Str12;
begin
  Result:=oTmpTable.FieldByName('OcdNum').AsString;
end;

procedure TOcmdlvTmp.SetOcdNum(pValue:Str12);
begin
  oTmpTable.FieldByName('OcdNum').AsString:=pValue;
end;

function TOcmdlvTmp.GetOciNum:longint;
begin
  Result:=oTmpTable.FieldByName('OciNum').AsInteger;
end;

procedure TOcmdlvTmp.SetOciNum(pValue:longint);
begin
  oTmpTable.FieldByName('OciNum').AsInteger:=pValue;
end;

function TOcmdlvTmp.GetProNum:longint;
begin
  Result:=oTmpTable.FieldByName('ProNum').AsInteger;
end;

procedure TOcmdlvTmp.SetProNum(pValue:longint);
begin
  oTmpTable.FieldByName('ProNum').AsInteger:=pValue;
end;

function TOcmdlvTmp.GetProNam:Str60;
begin
  Result:=oTmpTable.FieldByName('ProNam').AsString;
end;

procedure TOcmdlvTmp.SetProNam(pValue:Str60);
begin
  oTmpTable.FieldByName('ProNam').AsString:=pValue;
end;

function TOcmdlvTmp.GetProNam_:Str60;
begin
  Result:=oTmpTable.FieldByName('ProNam_').AsString;
end;

procedure TOcmdlvTmp.SetProNam_(pValue:Str60);
begin
  oTmpTable.FieldByName('ProNam_').AsString:=pValue;
end;

function TOcmdlvTmp.GetOcdDvq:double;
begin
  Result:=oTmpTable.FieldByName('OcdDvq').AsFloat;
end;

procedure TOcmdlvTmp.SetOcdDvq(pValue:double);
begin
  oTmpTable.FieldByName('OcdDvq').AsFloat:=pValue;
end;

function TOcmdlvTmp.GetTcdDvq:double;
begin
  Result:=oTmpTable.FieldByName('TcdDvq').AsFloat;
end;

procedure TOcmdlvTmp.SetTcdDvq(pValue:double);
begin
  oTmpTable.FieldByName('TcdDvq').AsFloat:=pValue;
end;

function TOcmdlvTmp.GetDifDvq:double;
begin
  Result:=oTmpTable.FieldByName('DifDvq').AsFloat;
end;

procedure TOcmdlvTmp.SetDifDvq(pValue:double);
begin
  oTmpTable.FieldByName('DifDvq').AsFloat:=pValue;
end;

function TOcmdlvTmp.GetOcdExq:double;
begin
  Result:=oTmpTable.FieldByName('OcdExq').AsFloat;
end;

procedure TOcmdlvTmp.SetOcdExq(pValue:double);
begin
  oTmpTable.FieldByName('OcdExq').AsFloat:=pValue;
end;

function TOcmdlvTmp.GetTcdExq:double;
begin
  Result:=oTmpTable.FieldByName('TcdExq').AsFloat;
end;

procedure TOcmdlvTmp.SetTcdExq(pValue:double);
begin
  oTmpTable.FieldByName('TcdExq').AsFloat:=pValue;
end;

function TOcmdlvTmp.GetDifExq:double;
begin
  Result:=oTmpTable.FieldByName('DifExq').AsFloat;
end;

procedure TOcmdlvTmp.SetDifExq(pValue:double);
begin
  oTmpTable.FieldByName('DifExq').AsFloat:=pValue;
end;

function TOcmdlvTmp.GetTcdNum:Str12;
begin
  Result:=oTmpTable.FieldByName('TcdNum').AsString;
end;

procedure TOcmdlvTmp.SetTcdNum(pValue:Str12);
begin
  oTmpTable.FieldByName('TcdNum').AsString:=pValue;
end;

function TOcmdlvTmp.GetTciNum:longint;
begin
  Result:=oTmpTable.FieldByName('TciNum').AsInteger;
end;

procedure TOcmdlvTmp.SetTciNum(pValue:longint);
begin
  oTmpTable.FieldByName('TciNum').AsInteger:=pValue;
end;

// **************************************** PUBLIC ********************************************

function TOcmdlvTmp.Eof:boolean;
begin
  Result:=oTmpTable.Eof;
end;

function TOcmdlvTmp.Active:boolean;
begin
  Result:=oTmpTable.Active;
end;

function TOcmdlvTmp.LocOnIt(pOcdNum:Str12;pOciNum:longint):boolean;
begin
  SetIndex (ixOnIt);
  Result:=oTmpTable.FindKey([pOcdNum,pOciNum]);
end;

function TOcmdlvTmp.LocProNum(pProNum:longint):boolean;
begin
  SetIndex (ixProNum);
  Result:=oTmpTable.FindKey([pProNum]);
end;

function TOcmdlvTmp.LocProNam_(pProNam_:Str60):boolean;
begin
  SetIndex (ixProNam_);
  Result:=oTmpTable.FindKey([pProNam_]);
end;

procedure TOcmdlvTmp.SetIndex(pIndexName:ShortString);
begin
  If oTmpTable.IndexName<>pIndexName then oTmpTable.IndexName:=pIndexName;
end;

procedure TOcmdlvTmp.Open;
begin
  oTmpTable.Open;
end;

procedure TOcmdlvTmp.Close;
begin
  If oTmpTable.Active then oTmpTable.Close;
end;

procedure TOcmdlvTmp.Prior;
begin
  oTmpTable.Prior;
end;

procedure TOcmdlvTmp.Next;
begin
  oTmpTable.Next;
end;

procedure TOcmdlvTmp.First;
begin
  oTmpTable.First;
end;

procedure TOcmdlvTmp.Last;
begin
  oTmpTable.Last;
end;

procedure TOcmdlvTmp.Insert;
begin
  oTmpTable.Insert;
end;

procedure TOcmdlvTmp.Edit;
begin
  oTmpTable.Edit;
end;

procedure TOcmdlvTmp.Post;
var mEdit:boolean;
begin
  oTmpTable.Post;
end;

procedure TOcmdlvTmp.Delete;
begin
  oTmpTable.Delete;
end;

procedure TOcmdlvTmp.SwapIndex;
begin
  oTmpTable.SwapIndex;
end;

procedure TOcmdlvTmp.RestIndex;
begin
  oTmpTable.RestoreIndex;
end;

procedure TOcmdlvTmp.SwapStatus;
begin
  oTmpTable.SwapStatus;
end;

procedure TOcmdlvTmp.RestStatus;
begin
  oTmpTable.RestoreStatus;
end;

procedure TOcmdlvTmp.EnabCont;
begin
  oTmpTable.EnableControls;
end;

procedure TOcmdlvTmp.DisabCont;
begin
  oTmpTable.DisableControls;
end;

end.
{MOD 2011001}
