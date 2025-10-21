unit tASRSUM;

interface

uses
  IcTypes, IcConv, NexPath, NexGlob, DocHand, 
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls,
  Dialogs, DB, NexBtrTable, DBTables, NexPxTable;

const
  ixSnDtSoAsAn='';
  ixDifVal='DifVal';

type
  TAsrsumTmp=class(TComponent)
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
    function GetSmoNam:Str30;            procedure SetSmoNam (pValue:Str30);
    function GetDocDes:Str30;            procedure SetDocDes (pValue:Str30);
    function GetStmVal:double;           procedure SetStmVal (pValue:double);
    function GetCrdVal:double;           procedure SetCrdVal (pValue:double);
    function GetDebVal:double;           procedure SetDebVal (pValue:double);
    function GetDifVal:double;           procedure SetDifVal (pValue:double);
  public
    // Elementarne databazove operacie
    function Eof:boolean;
    function Active:boolean;
    function LocSnDtSoAsAn (pStkNum:word;pDocTyp:Str2;pSmoNum:word;pAccSnt:Str3;pAccAnl:Str6):boolean;
    function LocDifVal (pDifVal:double):boolean;

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
    property SmoNam:Str30 read GetSmoNam write SetSmoNam;
    property DocDes:Str30 read GetDocDes write SetDocDes;
    property StmVal:double read GetStmVal write SetStmVal;
    property CrdVal:double read GetCrdVal write SetCrdVal;
    property DebVal:double read GetDebVal write SetDebVal;
    property DifVal:double read GetDifVal write SetDifVal;
  end;

implementation

constructor TAsrsumTmp.Create;
begin
  oTmpTable:=TmpInit ('ASRSUM',Self);
end;

destructor TAsrsumTmp.Destroy;
begin
  If oTmpTable.Active then oTmpTable.Close;
  FreeAndNil(oTmpTable);
end;

// *************************************** PRIVATE ********************************************

function TAsrsumTmp.GetCount:integer;
begin
  Result:=oTmpTable.RecordCount;
end;

function TAsrsumTmp.FieldExist(pFieldName:ShortString):boolean;
begin
  Result:=oTmpTable.FindField(pFieldName)<>nil;
end;

function TAsrsumTmp.GetStkNum:word;
begin
  Result:=oTmpTable.FieldByName('StkNum').AsInteger;
end;

procedure TAsrsumTmp.SetStkNum(pValue:word);
begin
  oTmpTable.FieldByName('StkNum').AsInteger:=pValue;
end;

function TAsrsumTmp.GetDocTyp:Str2;
begin
  Result:=oTmpTable.FieldByName('DocTyp').AsString;
end;

procedure TAsrsumTmp.SetDocTyp(pValue:Str2);
begin
  oTmpTable.FieldByName('DocTyp').AsString:=pValue;
end;

function TAsrsumTmp.GetSmoNum:word;
begin
  Result:=oTmpTable.FieldByName('SmoNum').AsInteger;
end;

procedure TAsrsumTmp.SetSmoNum(pValue:word);
begin
  oTmpTable.FieldByName('SmoNum').AsInteger:=pValue;
end;

function TAsrsumTmp.GetAccSnt:Str3;
begin
  Result:=oTmpTable.FieldByName('AccSnt').AsString;
end;

procedure TAsrsumTmp.SetAccSnt(pValue:Str3);
begin
  oTmpTable.FieldByName('AccSnt').AsString:=pValue;
end;

function TAsrsumTmp.GetAccAnl:Str6;
begin
  Result:=oTmpTable.FieldByName('AccAnl').AsString;
end;

procedure TAsrsumTmp.SetAccAnl(pValue:Str6);
begin
  oTmpTable.FieldByName('AccAnl').AsString:=pValue;
end;

function TAsrsumTmp.GetSmoNam:Str30;
begin
  Result:=oTmpTable.FieldByName('SmoNam').AsString;
end;

procedure TAsrsumTmp.SetSmoNam(pValue:Str30);
begin
  oTmpTable.FieldByName('SmoNam').AsString:=pValue;
end;

function TAsrsumTmp.GetDocDes:Str30;
begin
  Result:=oTmpTable.FieldByName('DocDes').AsString;
end;

procedure TAsrsumTmp.SetDocDes(pValue:Str30);
begin
  oTmpTable.FieldByName('DocDes').AsString:=pValue;
end;

function TAsrsumTmp.GetStmVal:double;
begin
  Result:=oTmpTable.FieldByName('StmVal').AsFloat;
end;

procedure TAsrsumTmp.SetStmVal(pValue:double);
begin
  oTmpTable.FieldByName('StmVal').AsFloat:=pValue;
end;

function TAsrsumTmp.GetCrdVal:double;
begin
  Result:=oTmpTable.FieldByName('CrdVal').AsFloat;
end;

procedure TAsrsumTmp.SetCrdVal(pValue:double);
begin
  oTmpTable.FieldByName('CrdVal').AsFloat:=pValue;
end;

function TAsrsumTmp.GetDebVal:double;
begin
  Result:=oTmpTable.FieldByName('DebVal').AsFloat;
end;

procedure TAsrsumTmp.SetDebVal(pValue:double);
begin
  oTmpTable.FieldByName('DebVal').AsFloat:=pValue;
end;

function TAsrsumTmp.GetDifVal:double;
begin
  Result:=oTmpTable.FieldByName('DifVal').AsFloat;
end;

procedure TAsrsumTmp.SetDifVal(pValue:double);
begin
  oTmpTable.FieldByName('DifVal').AsFloat:=pValue;
end;

// **************************************** PUBLIC ********************************************

function TAsrsumTmp.Eof:boolean;
begin
  Result:=oTmpTable.Eof;
end;

function TAsrsumTmp.Active:boolean;
begin
  Result:=oTmpTable.Active;
end;

function TAsrsumTmp.LocSnDtSoAsAn(pStkNum:word;pDocTyp:Str2;pSmoNum:word;pAccSnt:Str3;pAccAnl:Str6):boolean;
begin
  SetIndex (ixSnDtSoAsAn);
  Result:=oTmpTable.FindKey([pStkNum,pDocTyp,pSmoNum,pAccSnt,pAccAnl]);
end;

function TAsrsumTmp.LocDifVal(pDifVal:double):boolean;
begin
  SetIndex (ixDifVal);
  Result:=oTmpTable.FindKey([pDifVal]);
end;

procedure TAsrsumTmp.SetIndex(pIndexName:ShortString);
begin
  If oTmpTable.IndexName<>pIndexName then oTmpTable.IndexName:=pIndexName;
end;

procedure TAsrsumTmp.Open;
begin
  oTmpTable.Open;
end;

procedure TAsrsumTmp.Close;
begin
  If oTmpTable.Active then oTmpTable.Close;
end;

procedure TAsrsumTmp.Prior;
begin
  oTmpTable.Prior;
end;

procedure TAsrsumTmp.Next;
begin
  oTmpTable.Next;
end;

procedure TAsrsumTmp.First;
begin
  oTmpTable.First;
end;

procedure TAsrsumTmp.Last;
begin
  oTmpTable.Last;
end;

procedure TAsrsumTmp.Insert;
begin
  oTmpTable.Insert;
end;

procedure TAsrsumTmp.Edit;
begin
  oTmpTable.Edit;
end;

procedure TAsrsumTmp.Post;
var mEdit:boolean;
begin
  oTmpTable.Post;
end;

procedure TAsrsumTmp.Delete;
begin
  oTmpTable.Delete;
end;

procedure TAsrsumTmp.SwapIndex;
begin
  oTmpTable.SwapIndex;
end;

procedure TAsrsumTmp.RestIndex;
begin
  oTmpTable.RestoreIndex;
end;

procedure TAsrsumTmp.SwapStatus;
begin
  oTmpTable.SwapStatus;
end;

procedure TAsrsumTmp.RestStatus;
begin
  oTmpTable.RestoreStatus;
end;

procedure TAsrsumTmp.EnabCont;
begin
  oTmpTable.EnableControls;
end;

procedure TAsrsumTmp.DisabCont;
begin
  oTmpTable.DisableControls;
end;

end.
{MOD 2011001}
