unit tSTKOFR;

interface

uses
  IcTypes, IcConv, NexPath, NexGlob, DocHand, 
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls,
  Dialogs, DB, NexBtrTable, DBTables, NexPxTable;

const
  ixPaCode='';

type
  TStkofrTmp=class(TComponent)
    constructor Create;
    destructor Destroy; override;
  private
    oTmpTable: TNexPxTable;
    function GetCount:integer;
    function FieldExist (pFieldName:ShortString): boolean;
    // Pristup k databazovym poliam
    function GetPaCode:longint;          procedure SetPaCode (pValue:longint);
    function GetPaName:Str60;            procedure SetPaName (pValue:Str60);
    function GetOfrQnt:double;           procedure SetOfrQnt (pValue:double);
    function GetStatus:Str1;             procedure SetStatus (pValue:Str1);
    function GetModUser:Str10;           procedure SetModUser (pValue:Str10);
    function GetModDate:TDatetime;       procedure SetModDate (pValue:TDatetime);
    function GetModTime:TDatetime;       procedure SetModTime (pValue:TDatetime);
    function GetActPos:longint;          procedure SetActPos (pValue:longint);
  public
    // Elementarne databazove operacie
    function Eof:boolean;
    function Active:boolean;
    function LocPaCode (pPaCode:longint):boolean;

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
    property PaCode:longint read GetPaCode write SetPaCode;
    property PaName:Str60 read GetPaName write SetPaName;
    property OfrQnt:double read GetOfrQnt write SetOfrQnt;
    property Status:Str1 read GetStatus write SetStatus;
    property ModUser:Str10 read GetModUser write SetModUser;
    property ModDate:TDatetime read GetModDate write SetModDate;
    property ModTime:TDatetime read GetModTime write SetModTime;
    property ActPos:longint read GetActPos write SetActPos;
  end;

implementation

constructor TStkofrTmp.Create;
begin
  oTmpTable:=TmpInit ('STKOFR',Self);
end;

destructor TStkofrTmp.Destroy;
begin
  If oTmpTable.Active then oTmpTable.Close;
  FreeAndNil(oTmpTable);
end;

// *************************************** PRIVATE ********************************************

function TStkofrTmp.GetCount:integer;
begin
  Result:=oTmpTable.RecordCount;
end;

function TStkofrTmp.FieldExist(pFieldName:ShortString):boolean;
begin
  Result:=oTmpTable.FindField(pFieldName)<>nil;
end;

function TStkofrTmp.GetPaCode:longint;
begin
  Result:=oTmpTable.FieldByName('PaCode').AsInteger;
end;

procedure TStkofrTmp.SetPaCode(pValue:longint);
begin
  oTmpTable.FieldByName('PaCode').AsInteger:=pValue;
end;

function TStkofrTmp.GetPaName:Str60;
begin
  Result:=oTmpTable.FieldByName('PaName').AsString;
end;

procedure TStkofrTmp.SetPaName(pValue:Str60);
begin
  oTmpTable.FieldByName('PaName').AsString:=pValue;
end;

function TStkofrTmp.GetOfrQnt:double;
begin
  Result:=oTmpTable.FieldByName('OfrQnt').AsFloat;
end;

procedure TStkofrTmp.SetOfrQnt(pValue:double);
begin
  oTmpTable.FieldByName('OfrQnt').AsFloat:=pValue;
end;

function TStkofrTmp.GetStatus:Str1;
begin
  Result:=oTmpTable.FieldByName('Status').AsString;
end;

procedure TStkofrTmp.SetStatus(pValue:Str1);
begin
  oTmpTable.FieldByName('Status').AsString:=pValue;
end;

function TStkofrTmp.GetModUser:Str10;
begin
  Result:=oTmpTable.FieldByName('ModUser').AsString;
end;

procedure TStkofrTmp.SetModUser(pValue:Str10);
begin
  oTmpTable.FieldByName('ModUser').AsString:=pValue;
end;

function TStkofrTmp.GetModDate:TDatetime;
begin
  Result:=oTmpTable.FieldByName('ModDate').AsDateTime;
end;

procedure TStkofrTmp.SetModDate(pValue:TDatetime);
begin
  oTmpTable.FieldByName('ModDate').AsDateTime:=pValue;
end;

function TStkofrTmp.GetModTime:TDatetime;
begin
  Result:=oTmpTable.FieldByName('ModTime').AsDateTime;
end;

procedure TStkofrTmp.SetModTime(pValue:TDatetime);
begin
  oTmpTable.FieldByName('ModTime').AsDateTime:=pValue;
end;

function TStkofrTmp.GetActPos:longint;
begin
  Result:=oTmpTable.FieldByName('ActPos').AsInteger;
end;

procedure TStkofrTmp.SetActPos(pValue:longint);
begin
  oTmpTable.FieldByName('ActPos').AsInteger:=pValue;
end;

// **************************************** PUBLIC ********************************************

function TStkofrTmp.Eof:boolean;
begin
  Result:=oTmpTable.Eof;
end;

function TStkofrTmp.Active:boolean;
begin
  Result:=oTmpTable.Active;
end;

function TStkofrTmp.LocPaCode(pPaCode:longint):boolean;
begin
  SetIndex (ixPaCode);
  Result:=oTmpTable.FindKey([pPaCode]);
end;

procedure TStkofrTmp.SetIndex(pIndexName:ShortString);
begin
  If oTmpTable.IndexName<>pIndexName then oTmpTable.IndexName:=pIndexName;
end;

procedure TStkofrTmp.Open;
begin
  oTmpTable.Open;
end;

procedure TStkofrTmp.Close;
begin
  If oTmpTable.Active then oTmpTable.Close;
end;

procedure TStkofrTmp.Prior;
begin
  oTmpTable.Prior;
end;

procedure TStkofrTmp.Next;
begin
  oTmpTable.Next;
end;

procedure TStkofrTmp.First;
begin
  oTmpTable.First;
end;

procedure TStkofrTmp.Last;
begin
  oTmpTable.Last;
end;

procedure TStkofrTmp.Insert;
begin
  oTmpTable.Insert;
end;

procedure TStkofrTmp.Edit;
begin
  oTmpTable.Edit;
end;

procedure TStkofrTmp.Post;
var mEdit:boolean;
begin
  oTmpTable.Post;
end;

procedure TStkofrTmp.Delete;
begin
  oTmpTable.Delete;
end;

procedure TStkofrTmp.SwapIndex;
begin
  oTmpTable.SwapIndex;
end;

procedure TStkofrTmp.RestIndex;
begin
  oTmpTable.RestoreIndex;
end;

procedure TStkofrTmp.SwapStatus;
begin
  oTmpTable.SwapStatus;
end;

procedure TStkofrTmp.RestStatus;
begin
  oTmpTable.RestoreStatus;
end;

procedure TStkofrTmp.EnabCont;
begin
  oTmpTable.EnableControls;
end;

procedure TStkofrTmp.DisabCont;
begin
  oTmpTable.DisableControls;
end;

end.
{MOD 2202001}
