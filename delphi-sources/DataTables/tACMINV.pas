unit tACMINV;

interface

uses
  IcTypes, IcConv, NexPath, NexGlob, DocHand, 
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls,
  Dialogs, DB, NexBtrTable, DBTables, NexPxTable;

const
  ixAsAn='';

type
  TAcminvTmp=class(TComponent)
    constructor Create;
    destructor Destroy; override;
  private
    oTmpTable: TNexPxTable;
    function GetCount:integer;
    function FieldExist (pFieldName:ShortString): boolean;
    // Pristup k databazovym poliam
    function GetAccSnt:Str3;             procedure SetAccSnt (pValue:Str3);
    function GetAccAnl:Str6;             procedure SetAccAnl (pValue:Str6);
    function GetAccNam:Str30;            procedure SetAccNam (pValue:Str30);
    function GetBegAcv:double;           procedure SetBegAcv (pValue:double);
    function GetCrdAcv:double;           procedure SetCrdAcv (pValue:double);
    function GetDebAcv:double;           procedure SetDebAcv (pValue:double);
    function GetEndAcv:double;           procedure SetEndAcv (pValue:double);
    function GetBegInv:double;           procedure SetBegInv (pValue:double);
    function GetDocInv:double;           procedure SetDocInv (pValue:double);
    function GetPayInv:double;           procedure SetPayInv (pValue:double);
    function GetEndInv:double;           procedure SetEndInv (pValue:double);
    function GetDifVal:double;           procedure SetDifVal (pValue:double);
  public
    // Elementarne databazove operacie
    function Eof:boolean;
    function Active:boolean;
    function LocAsAn (pAccSnt:Str3;pAccAnl:Str6):boolean;

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
    property AccSnt:Str3 read GetAccSnt write SetAccSnt;
    property AccAnl:Str6 read GetAccAnl write SetAccAnl;
    property AccNam:Str30 read GetAccNam write SetAccNam;
    property BegAcv:double read GetBegAcv write SetBegAcv;
    property CrdAcv:double read GetCrdAcv write SetCrdAcv;
    property DebAcv:double read GetDebAcv write SetDebAcv;
    property EndAcv:double read GetEndAcv write SetEndAcv;
    property BegInv:double read GetBegInv write SetBegInv;
    property DocInv:double read GetDocInv write SetDocInv;
    property PayInv:double read GetPayInv write SetPayInv;
    property EndInv:double read GetEndInv write SetEndInv;
    property DifVal:double read GetDifVal write SetDifVal;
  end;

implementation

constructor TAcminvTmp.Create;
begin
  oTmpTable:=TmpInit ('ACMINV',Self);
end;

destructor TAcminvTmp.Destroy;
begin
  If oTmpTable.Active then oTmpTable.Close;
  FreeAndNil(oTmpTable);
end;

// *************************************** PRIVATE ********************************************

function TAcminvTmp.GetCount:integer;
begin
  Result:=oTmpTable.RecordCount;
end;

function TAcminvTmp.FieldExist(pFieldName:ShortString):boolean;
begin
  Result:=oTmpTable.FindField(pFieldName)<>nil;
end;

function TAcminvTmp.GetAccSnt:Str3;
begin
  Result:=oTmpTable.FieldByName('AccSnt').AsString;
end;

procedure TAcminvTmp.SetAccSnt(pValue:Str3);
begin
  oTmpTable.FieldByName('AccSnt').AsString:=pValue;
end;

function TAcminvTmp.GetAccAnl:Str6;
begin
  Result:=oTmpTable.FieldByName('AccAnl').AsString;
end;

procedure TAcminvTmp.SetAccAnl(pValue:Str6);
begin
  oTmpTable.FieldByName('AccAnl').AsString:=pValue;
end;

function TAcminvTmp.GetAccNam:Str30;
begin
  Result:=oTmpTable.FieldByName('AccNam').AsString;
end;

procedure TAcminvTmp.SetAccNam(pValue:Str30);
begin
  oTmpTable.FieldByName('AccNam').AsString:=pValue;
end;

function TAcminvTmp.GetBegAcv:double;
begin
  Result:=oTmpTable.FieldByName('BegAcv').AsFloat;
end;

procedure TAcminvTmp.SetBegAcv(pValue:double);
begin
  oTmpTable.FieldByName('BegAcv').AsFloat:=pValue;
end;

function TAcminvTmp.GetCrdAcv:double;
begin
  Result:=oTmpTable.FieldByName('CrdAcv').AsFloat;
end;

procedure TAcminvTmp.SetCrdAcv(pValue:double);
begin
  oTmpTable.FieldByName('CrdAcv').AsFloat:=pValue;
end;

function TAcminvTmp.GetDebAcv:double;
begin
  Result:=oTmpTable.FieldByName('DebAcv').AsFloat;
end;

procedure TAcminvTmp.SetDebAcv(pValue:double);
begin
  oTmpTable.FieldByName('DebAcv').AsFloat:=pValue;
end;

function TAcminvTmp.GetEndAcv:double;
begin
  Result:=oTmpTable.FieldByName('EndAcv').AsFloat;
end;

procedure TAcminvTmp.SetEndAcv(pValue:double);
begin
  oTmpTable.FieldByName('EndAcv').AsFloat:=pValue;
end;

function TAcminvTmp.GetBegInv:double;
begin
  Result:=oTmpTable.FieldByName('BegInv').AsFloat;
end;

procedure TAcminvTmp.SetBegInv(pValue:double);
begin
  oTmpTable.FieldByName('BegInv').AsFloat:=pValue;
end;

function TAcminvTmp.GetDocInv:double;
begin
  Result:=oTmpTable.FieldByName('DocInv').AsFloat;
end;

procedure TAcminvTmp.SetDocInv(pValue:double);
begin
  oTmpTable.FieldByName('DocInv').AsFloat:=pValue;
end;

function TAcminvTmp.GetPayInv:double;
begin
  Result:=oTmpTable.FieldByName('PayInv').AsFloat;
end;

procedure TAcminvTmp.SetPayInv(pValue:double);
begin
  oTmpTable.FieldByName('PayInv').AsFloat:=pValue;
end;

function TAcminvTmp.GetEndInv:double;
begin
  Result:=oTmpTable.FieldByName('EndInv').AsFloat;
end;

procedure TAcminvTmp.SetEndInv(pValue:double);
begin
  oTmpTable.FieldByName('EndInv').AsFloat:=pValue;
end;

function TAcminvTmp.GetDifVal:double;
begin
  Result:=oTmpTable.FieldByName('DifVal').AsFloat;
end;

procedure TAcminvTmp.SetDifVal(pValue:double);
begin
  oTmpTable.FieldByName('DifVal').AsFloat:=pValue;
end;

// **************************************** PUBLIC ********************************************

function TAcminvTmp.Eof:boolean;
begin
  Result:=oTmpTable.Eof;
end;

function TAcminvTmp.Active:boolean;
begin
  Result:=oTmpTable.Active;
end;

function TAcminvTmp.LocAsAn(pAccSnt:Str3;pAccAnl:Str6):boolean;
begin
  SetIndex (ixAsAn);
  Result:=oTmpTable.FindKey([pAccSnt,pAccAnl]);
end;

procedure TAcminvTmp.SetIndex(pIndexName:ShortString);
begin
  If oTmpTable.IndexName<>pIndexName then oTmpTable.IndexName:=pIndexName;
end;

procedure TAcminvTmp.Open;
begin
  oTmpTable.Open;
end;

procedure TAcminvTmp.Close;
begin
  If oTmpTable.Active then oTmpTable.Close;
end;

procedure TAcminvTmp.Prior;
begin
  oTmpTable.Prior;
end;

procedure TAcminvTmp.Next;
begin
  oTmpTable.Next;
end;

procedure TAcminvTmp.First;
begin
  oTmpTable.First;
end;

procedure TAcminvTmp.Last;
begin
  oTmpTable.Last;
end;

procedure TAcminvTmp.Insert;
begin
  oTmpTable.Insert;
end;

procedure TAcminvTmp.Edit;
begin
  oTmpTable.Edit;
end;

procedure TAcminvTmp.Post;
var mEdit:boolean;
begin
  oTmpTable.Post;
end;

procedure TAcminvTmp.Delete;
begin
  oTmpTable.Delete;
end;

procedure TAcminvTmp.SwapIndex;
begin
  oTmpTable.SwapIndex;
end;

procedure TAcminvTmp.RestIndex;
begin
  oTmpTable.RestoreIndex;
end;

procedure TAcminvTmp.SwapStatus;
begin
  oTmpTable.SwapStatus;
end;

procedure TAcminvTmp.RestStatus;
begin
  oTmpTable.RestoreStatus;
end;

procedure TAcminvTmp.EnabCont;
begin
  oTmpTable.EnableControls;
end;

procedure TAcminvTmp.DisabCont;
begin
  oTmpTable.DisableControls;
end;

end.
{MOD 2011001}
