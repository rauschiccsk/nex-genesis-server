unit tISDLST;

interface

uses
  IcTypes, IcConv, NexPath, NexGlob, DocHand, 
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls,
  Dialogs, DB, NexBtrTable, DBTables, NexPxTable;

const
  ixDocNum='';

type
  TIsdlstTmp=class(TComponent)
    constructor Create;
    destructor Destroy; override;
  private
    oTmpTable: TNexPxTable;
    function GetCount:integer;
    function FieldExist (pFieldName:ShortString): boolean;
    // Pristup k databazovym poliam
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
    function LocDocNum (pDocNum:Str12):boolean;

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

constructor TIsdlstTmp.Create;
begin
  oTmpTable:=TmpInit ('ISDLST',Self);
end;

destructor TIsdlstTmp.Destroy;
begin
  If oTmpTable.Active then oTmpTable.Close;
  FreeAndNil(oTmpTable);
end;

// *************************************** PRIVATE ********************************************

function TIsdlstTmp.GetCount:integer;
begin
  Result:=oTmpTable.RecordCount;
end;

function TIsdlstTmp.FieldExist(pFieldName:ShortString):boolean;
begin
  Result:=oTmpTable.FindField(pFieldName)<>nil;
end;

function TIsdlstTmp.GetDocNum:Str12;
begin
  Result:=oTmpTable.FieldByName('DocNum').AsString;
end;

procedure TIsdlstTmp.SetDocNum(pValue:Str12);
begin
  oTmpTable.FieldByName('DocNum').AsString:=pValue;
end;

function TIsdlstTmp.GetExtNum:Str12;
begin
  Result:=oTmpTable.FieldByName('ExtNum').AsString;
end;

procedure TIsdlstTmp.SetExtNum(pValue:Str12);
begin
  oTmpTable.FieldByName('ExtNum').AsString:=pValue;
end;

function TIsdlstTmp.GetBokNum:Str5;
begin
  Result:=oTmpTable.FieldByName('BokNum').AsString;
end;

procedure TIsdlstTmp.SetBokNum(pValue:Str5);
begin
  oTmpTable.FieldByName('BokNum').AsString:=pValue;
end;

function TIsdlstTmp.GetParNum:longint;
begin
  Result:=oTmpTable.FieldByName('ParNum').AsInteger;
end;

procedure TIsdlstTmp.SetParNum(pValue:longint);
begin
  oTmpTable.FieldByName('ParNum').AsInteger:=pValue;
end;

function TIsdlstTmp.GetParNam:Str60;
begin
  Result:=oTmpTable.FieldByName('ParNam').AsString;
end;

procedure TIsdlstTmp.SetParNam(pValue:Str60);
begin
  oTmpTable.FieldByName('ParNam').AsString:=pValue;
end;

function TIsdlstTmp.GetWriNum:word;
begin
  Result:=oTmpTable.FieldByName('WriNum').AsInteger;
end;

procedure TIsdlstTmp.SetWriNum(pValue:word);
begin
  oTmpTable.FieldByName('WriNum').AsInteger:=pValue;
end;

function TIsdlstTmp.GetDocDte:TDatetime;
begin
  Result:=oTmpTable.FieldByName('DocDte').AsDateTime;
end;

procedure TIsdlstTmp.SetDocDte(pValue:TDatetime);
begin
  oTmpTable.FieldByName('DocDte').AsDateTime:=pValue;
end;

function TIsdlstTmp.GetEndVal:double;
begin
  Result:=oTmpTable.FieldByName('EndVal').AsFloat;
end;

procedure TIsdlstTmp.SetEndVal(pValue:double);
begin
  oTmpTable.FieldByName('EndVal').AsFloat:=pValue;
end;

function TIsdlstTmp.GetDocSnt:Str3;
begin
  Result:=oTmpTable.FieldByName('DocSnt').AsString;
end;

procedure TIsdlstTmp.SetDocSnt(pValue:Str3);
begin
  oTmpTable.FieldByName('DocSnt').AsString:=pValue;
end;

function TIsdlstTmp.GetDocAnl:Str6;
begin
  Result:=oTmpTable.FieldByName('DocAnl').AsString;
end;

procedure TIsdlstTmp.SetDocAnl(pValue:Str6);
begin
  oTmpTable.FieldByName('DocAnl').AsString:=pValue;
end;

// **************************************** PUBLIC ********************************************

function TIsdlstTmp.Eof:boolean;
begin
  Result:=oTmpTable.Eof;
end;

function TIsdlstTmp.Active:boolean;
begin
  Result:=oTmpTable.Active;
end;

function TIsdlstTmp.LocDocNum(pDocNum:Str12):boolean;
begin
  SetIndex (ixDocNum);
  Result:=oTmpTable.FindKey([pDocNum]);
end;

procedure TIsdlstTmp.SetIndex(pIndexName:ShortString);
begin
  If oTmpTable.IndexName<>pIndexName then oTmpTable.IndexName:=pIndexName;
end;

procedure TIsdlstTmp.Open;
begin
  oTmpTable.Open;
end;

procedure TIsdlstTmp.Close;
begin
  If oTmpTable.Active then oTmpTable.Close;
end;

procedure TIsdlstTmp.Prior;
begin
  oTmpTable.Prior;
end;

procedure TIsdlstTmp.Next;
begin
  oTmpTable.Next;
end;

procedure TIsdlstTmp.First;
begin
  oTmpTable.First;
end;

procedure TIsdlstTmp.Last;
begin
  oTmpTable.Last;
end;

procedure TIsdlstTmp.Insert;
begin
  oTmpTable.Insert;
end;

procedure TIsdlstTmp.Edit;
begin
  oTmpTable.Edit;
end;

procedure TIsdlstTmp.Post;
var mEdit:boolean;
begin
  oTmpTable.Post;
end;

procedure TIsdlstTmp.Delete;
begin
  oTmpTable.Delete;
end;

procedure TIsdlstTmp.SwapIndex;
begin
  oTmpTable.SwapIndex;
end;

procedure TIsdlstTmp.RestIndex;
begin
  oTmpTable.RestoreIndex;
end;

procedure TIsdlstTmp.SwapStatus;
begin
  oTmpTable.SwapStatus;
end;

procedure TIsdlstTmp.RestStatus;
begin
  oTmpTable.RestoreStatus;
end;

procedure TIsdlstTmp.EnabCont;
begin
  oTmpTable.EnableControls;
end;

procedure TIsdlstTmp.DisabCont;
begin
  oTmpTable.DisableControls;
end;

end.
{MOD 2008001}
