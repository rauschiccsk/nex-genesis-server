unit tASRJRN;

interface

uses
  IcTypes, IcConv, NexPath, NexGlob, DocHand, 
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls,
  Dialogs, DB, NexBtrTable, DBTables, NexPxTable;

const
  ixSnDtSoAsAn='';

type
  TAsrjrnTmp=class(TComponent)
    constructor Create;
    destructor Destroy; override;
  private
    oTmpTable: TNexPxTable;
    function GetCount:integer;
    function FieldExist (pFieldName:ShortString): boolean;
    // Pristup k databazovym poliam
    function GetStkNum:word;             procedure SetStkNum (pValue:word);
    function GetDocTyp:Str2;             procedure SetDocTyp (pValue:Str2);
    function GetSmoNum:word;             procedure SetSmoNum (pValue:word);
    function GetAccSnt:Str3;             procedure SetAccSnt (pValue:Str3);
    function GetAccAnl:Str6;             procedure SetAccAnl (pValue:Str6);
    function GetCrdVal:double;           procedure SetCrdVal (pValue:double);
    function GetDebVal:double;           procedure SetDebVal (pValue:double);
  public
    // Elementarne databazove operacie
    function Eof:boolean;
    function Active:boolean;
    function LocSnDtSoAsAn (pStkNum:word;pDocTyp:Str2;pSmoNum:word;pAccSnt:Str3;pAccAnl:Str6):boolean;

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
    property StkNum:word read GetStkNum write SetStkNum;
    property DocTyp:Str2 read GetDocTyp write SetDocTyp;
    property SmoNum:word read GetSmoNum write SetSmoNum;
    property AccSnt:Str3 read GetAccSnt write SetAccSnt;
    property AccAnl:Str6 read GetAccAnl write SetAccAnl;
    property CrdVal:double read GetCrdVal write SetCrdVal;
    property DebVal:double read GetDebVal write SetDebVal;
  end;

implementation

constructor TAsrjrnTmp.Create;
begin
  oTmpTable:=TmpInit ('ASRJRN',Self);
end;

destructor TAsrjrnTmp.Destroy;
begin
  If oTmpTable.Active then oTmpTable.Close;
  FreeAndNil(oTmpTable);
end;

// *************************************** PRIVATE ********************************************

function TAsrjrnTmp.GetCount:integer;
begin
  Result:=oTmpTable.RecordCount;
end;

function TAsrjrnTmp.FieldExist(pFieldName:ShortString):boolean;
begin
  Result:=oTmpTable.FindField(pFieldName)<>nil;
end;

function TAsrjrnTmp.GetStkNum:word;
begin
  Result:=oTmpTable.FieldByName('StkNum').AsInteger;
end;

procedure TAsrjrnTmp.SetStkNum(pValue:word);
begin
  oTmpTable.FieldByName('StkNum').AsInteger:=pValue;
end;

function TAsrjrnTmp.GetDocTyp:Str2;
begin
  Result:=oTmpTable.FieldByName('DocTyp').AsString;
end;

procedure TAsrjrnTmp.SetDocTyp(pValue:Str2);
begin
  oTmpTable.FieldByName('DocTyp').AsString:=pValue;
end;

function TAsrjrnTmp.GetSmoNum:word;
begin
  Result:=oTmpTable.FieldByName('SmoNum').AsInteger;
end;

procedure TAsrjrnTmp.SetSmoNum(pValue:word);
begin
  oTmpTable.FieldByName('SmoNum').AsInteger:=pValue;
end;

function TAsrjrnTmp.GetAccSnt:Str3;
begin
  Result:=oTmpTable.FieldByName('AccSnt').AsString;
end;

procedure TAsrjrnTmp.SetAccSnt(pValue:Str3);
begin
  oTmpTable.FieldByName('AccSnt').AsString:=pValue;
end;

function TAsrjrnTmp.GetAccAnl:Str6;
begin
  Result:=oTmpTable.FieldByName('AccAnl').AsString;
end;

procedure TAsrjrnTmp.SetAccAnl(pValue:Str6);
begin
  oTmpTable.FieldByName('AccAnl').AsString:=pValue;
end;

function TAsrjrnTmp.GetCrdVal:double;
begin
  Result:=oTmpTable.FieldByName('CrdVal').AsFloat;
end;

procedure TAsrjrnTmp.SetCrdVal(pValue:double);
begin
  oTmpTable.FieldByName('CrdVal').AsFloat:=pValue;
end;

function TAsrjrnTmp.GetDebVal:double;
begin
  Result:=oTmpTable.FieldByName('DebVal').AsFloat;
end;

procedure TAsrjrnTmp.SetDebVal(pValue:double);
begin
  oTmpTable.FieldByName('DebVal').AsFloat:=pValue;
end;

// **************************************** PUBLIC ********************************************

function TAsrjrnTmp.Eof:boolean;
begin
  Result:=oTmpTable.Eof;
end;

function TAsrjrnTmp.Active:boolean;
begin
  Result:=oTmpTable.Active;
end;

function TAsrjrnTmp.LocSnDtSoAsAn(pStkNum:word;pDocTyp:Str2;pSmoNum:word;pAccSnt:Str3;pAccAnl:Str6):boolean;
begin
  SetIndex (ixSnDtSoAsAn);
  Result:=oTmpTable.FindKey([pStkNum,pDocTyp,pSmoNum,pAccSnt,pAccAnl]);
end;

procedure TAsrjrnTmp.SetIndex(pIndexName:ShortString);
begin
  If oTmpTable.IndexName<>pIndexName then oTmpTable.IndexName:=pIndexName;
end;

procedure TAsrjrnTmp.Open;
begin
  oTmpTable.Open;
end;

procedure TAsrjrnTmp.Close;
begin
  If oTmpTable.Active then oTmpTable.Close;
end;

procedure TAsrjrnTmp.Prior;
begin
  oTmpTable.Prior;
end;

procedure TAsrjrnTmp.Next;
begin
  oTmpTable.Next;
end;

procedure TAsrjrnTmp.First;
begin
  oTmpTable.First;
end;

procedure TAsrjrnTmp.Last;
begin
  oTmpTable.Last;
end;

procedure TAsrjrnTmp.Insert;
begin
  oTmpTable.Insert;
end;

procedure TAsrjrnTmp.Edit;
begin
  oTmpTable.Edit;
end;

procedure TAsrjrnTmp.Post;
var mEdit:boolean;
begin
  oTmpTable.Post;
end;

procedure TAsrjrnTmp.Delete;
begin
  oTmpTable.Delete;
end;

procedure TAsrjrnTmp.SwapIndex;
begin
  oTmpTable.SwapIndex;
end;

procedure TAsrjrnTmp.RestIndex;
begin
  oTmpTable.RestoreIndex;
end;

procedure TAsrjrnTmp.SwapStatus;
begin
  oTmpTable.SwapStatus;
end;

procedure TAsrjrnTmp.RestStatus;
begin
  oTmpTable.RestoreStatus;
end;

procedure TAsrjrnTmp.EnabCont;
begin
  oTmpTable.EnableControls;
end;

procedure TAsrjrnTmp.DisabCont;
begin
  oTmpTable.DisableControls;
end;

end.
{MOD 2011001}
