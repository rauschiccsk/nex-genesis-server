unit tEBAISD;

interface

uses
  IcTypes, IcConv, NexPath, NexGlob, DocHand, 
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls,
  Dialogs, DB, NexBtrTable, DBTables, NexPxTable;

const
  ixRnDn='';
  ixRowNum='RowNum';

type
  TEbaisdTmp=class(TComponent)
    constructor Create;
    destructor Destroy; override;
  private
    oTmpTable: TNexPxTable;
    function GetCount:integer;
    function FieldExist (pFieldName:ShortString): boolean;
    // Pristup k databazovym poliam
    function GetRowNum:word;             procedure SetRowNum (pValue:word);
    function GetDocNum:Str12;            procedure SetDocNum (pValue:Str12);
    function GetExtNum:Str12;            procedure SetExtNum (pValue:Str12);
    function GetBokNum:Str5;             procedure SetBokNum (pValue:Str5);
    function GetParNum:longint;          procedure SetParNum (pValue:longint);
    function GetParNam:Str60;            procedure SetParNam (pValue:Str60);
    function GetWriNum:word;             procedure SetWriNum (pValue:word);
    function GetDocDte:TDatetime;        procedure SetDocDte (pValue:TDatetime);
    function GetEndVal:double;           procedure SetEndVal (pValue:double);
    function GetDocSnt:Str3;             procedure SetDocSnt (pValue:Str3);
    function GetDocAnl:Str6;             procedure SetDocAnl (pValue:Str6);
  public
    // Elementarne databazove operacie
    function Eof:boolean;
    function Active:boolean;
    function LocRnDn (pRowNum:word;pDocNum:Str12):boolean;
    function LocRowNum (pRowNum:word):boolean;

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
    property RowNum:word read GetRowNum write SetRowNum;
    property DocNum:Str12 read GetDocNum write SetDocNum;
    property ExtNum:Str12 read GetExtNum write SetExtNum;
    property BokNum:Str5 read GetBokNum write SetBokNum;
    property ParNum:longint read GetParNum write SetParNum;
    property ParNam:Str60 read GetParNam write SetParNam;
    property WriNum:word read GetWriNum write SetWriNum;
    property DocDte:TDatetime read GetDocDte write SetDocDte;
    property EndVal:double read GetEndVal write SetEndVal;
    property DocSnt:Str3 read GetDocSnt write SetDocSnt;
    property DocAnl:Str6 read GetDocAnl write SetDocAnl;
  end;

implementation

constructor TEbaisdTmp.Create;
begin
  oTmpTable:=TmpInit ('EBAISD',Self);
end;

destructor TEbaisdTmp.Destroy;
begin
  If oTmpTable.Active then oTmpTable.Close;
  FreeAndNil(oTmpTable);
end;

// *************************************** PRIVATE ********************************************

function TEbaisdTmp.GetCount:integer;
begin
  Result:=oTmpTable.RecordCount;
end;

function TEbaisdTmp.FieldExist(pFieldName:ShortString):boolean;
begin
  Result:=oTmpTable.FindField(pFieldName)<>nil;
end;

function TEbaisdTmp.GetRowNum:word;
begin
  Result:=oTmpTable.FieldByName('RowNum').AsInteger;
end;

procedure TEbaisdTmp.SetRowNum(pValue:word);
begin
  oTmpTable.FieldByName('RowNum').AsInteger:=pValue;
end;

function TEbaisdTmp.GetDocNum:Str12;
begin
  Result:=oTmpTable.FieldByName('DocNum').AsString;
end;

procedure TEbaisdTmp.SetDocNum(pValue:Str12);
begin
  oTmpTable.FieldByName('DocNum').AsString:=pValue;
end;

function TEbaisdTmp.GetExtNum:Str12;
begin
  Result:=oTmpTable.FieldByName('ExtNum').AsString;
end;

procedure TEbaisdTmp.SetExtNum(pValue:Str12);
begin
  oTmpTable.FieldByName('ExtNum').AsString:=pValue;
end;

function TEbaisdTmp.GetBokNum:Str5;
begin
  Result:=oTmpTable.FieldByName('BokNum').AsString;
end;

procedure TEbaisdTmp.SetBokNum(pValue:Str5);
begin
  oTmpTable.FieldByName('BokNum').AsString:=pValue;
end;

function TEbaisdTmp.GetParNum:longint;
begin
  Result:=oTmpTable.FieldByName('ParNum').AsInteger;
end;

procedure TEbaisdTmp.SetParNum(pValue:longint);
begin
  oTmpTable.FieldByName('ParNum').AsInteger:=pValue;
end;

function TEbaisdTmp.GetParNam:Str60;
begin
  Result:=oTmpTable.FieldByName('ParNam').AsString;
end;

procedure TEbaisdTmp.SetParNam(pValue:Str60);
begin
  oTmpTable.FieldByName('ParNam').AsString:=pValue;
end;

function TEbaisdTmp.GetWriNum:word;
begin
  Result:=oTmpTable.FieldByName('WriNum').AsInteger;
end;

procedure TEbaisdTmp.SetWriNum(pValue:word);
begin
  oTmpTable.FieldByName('WriNum').AsInteger:=pValue;
end;

function TEbaisdTmp.GetDocDte:TDatetime;
begin
  Result:=oTmpTable.FieldByName('DocDte').AsDateTime;
end;

procedure TEbaisdTmp.SetDocDte(pValue:TDatetime);
begin
  oTmpTable.FieldByName('DocDte').AsDateTime:=pValue;
end;

function TEbaisdTmp.GetEndVal:double;
begin
  Result:=oTmpTable.FieldByName('EndVal').AsFloat;
end;

procedure TEbaisdTmp.SetEndVal(pValue:double);
begin
  oTmpTable.FieldByName('EndVal').AsFloat:=pValue;
end;

function TEbaisdTmp.GetDocSnt:Str3;
begin
  Result:=oTmpTable.FieldByName('DocSnt').AsString;
end;

procedure TEbaisdTmp.SetDocSnt(pValue:Str3);
begin
  oTmpTable.FieldByName('DocSnt').AsString:=pValue;
end;

function TEbaisdTmp.GetDocAnl:Str6;
begin
  Result:=oTmpTable.FieldByName('DocAnl').AsString;
end;

procedure TEbaisdTmp.SetDocAnl(pValue:Str6);
begin
  oTmpTable.FieldByName('DocAnl').AsString:=pValue;
end;

// **************************************** PUBLIC ********************************************

function TEbaisdTmp.Eof:boolean;
begin
  Result:=oTmpTable.Eof;
end;

function TEbaisdTmp.Active:boolean;
begin
  Result:=oTmpTable.Active;
end;

function TEbaisdTmp.LocRnDn(pRowNum:word;pDocNum:Str12):boolean;
begin
  SetIndex (ixRnDn);
  Result:=oTmpTable.FindKey([pRowNum,pDocNum]);
end;

function TEbaisdTmp.LocRowNum(pRowNum:word):boolean;
begin
  SetIndex (ixRowNum);
  Result:=oTmpTable.FindKey([pRowNum]);
end;

procedure TEbaisdTmp.SetIndex(pIndexName:ShortString);
begin
  If oTmpTable.IndexName<>pIndexName then oTmpTable.IndexName:=pIndexName;
end;

procedure TEbaisdTmp.Open;
begin
  oTmpTable.Open;
end;

procedure TEbaisdTmp.Close;
begin
  If oTmpTable.Active then oTmpTable.Close;
end;

procedure TEbaisdTmp.Prior;
begin
  oTmpTable.Prior;
end;

procedure TEbaisdTmp.Next;
begin
  oTmpTable.Next;
end;

procedure TEbaisdTmp.First;
begin
  oTmpTable.First;
end;

procedure TEbaisdTmp.Last;
begin
  oTmpTable.Last;
end;

procedure TEbaisdTmp.Insert;
begin
  oTmpTable.Insert;
end;

procedure TEbaisdTmp.Edit;
begin
  oTmpTable.Edit;
end;

procedure TEbaisdTmp.Post;
var mEdit:boolean;
begin
  oTmpTable.Post;
end;

procedure TEbaisdTmp.Delete;
begin
  oTmpTable.Delete;
end;

procedure TEbaisdTmp.SwapIndex;
begin
  oTmpTable.SwapIndex;
end;

procedure TEbaisdTmp.RestIndex;
begin
  oTmpTable.RestoreIndex;
end;

procedure TEbaisdTmp.SwapStatus;
begin
  oTmpTable.SwapStatus;
end;

procedure TEbaisdTmp.RestStatus;
begin
  oTmpTable.RestoreStatus;
end;

procedure TEbaisdTmp.EnabCont;
begin
  oTmpTable.EnableControls;
end;

procedure TEbaisdTmp.DisabCont;
begin
  oTmpTable.DisableControls;
end;

end.
{MOD 2008001}
