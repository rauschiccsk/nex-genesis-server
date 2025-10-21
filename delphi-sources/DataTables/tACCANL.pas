unit tACCANL;

interface

uses
  IcTypes, IcConv, NexPath, NexGlob, DocHand, 
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls,
  Dialogs, DB, NexBtrTable, DBTables, NexPxTable;

const
  ixAsAn='';

type
  TAccanlTmp=class(TComponent)
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
  end;

implementation

constructor TAccanlTmp.Create;
begin
  oTmpTable:=TmpInit ('ACCANL',Self);
end;

destructor TAccanlTmp.Destroy;
begin
  If oTmpTable.Active then oTmpTable.Close;
  FreeAndNil(oTmpTable);
end;

// *************************************** PRIVATE ********************************************

function TAccanlTmp.GetCount:integer;
begin
  Result:=oTmpTable.RecordCount;
end;

function TAccanlTmp.FieldExist(pFieldName:ShortString):boolean;
begin
  Result:=oTmpTable.FindField(pFieldName)<>nil;
end;

function TAccanlTmp.GetAccSnt:Str3;
begin
  Result:=oTmpTable.FieldByName('AccSnt').AsString;
end;

procedure TAccanlTmp.SetAccSnt(pValue:Str3);
begin
  oTmpTable.FieldByName('AccSnt').AsString:=pValue;
end;

function TAccanlTmp.GetAccAnl:Str6;
begin
  Result:=oTmpTable.FieldByName('AccAnl').AsString;
end;

procedure TAccanlTmp.SetAccAnl(pValue:Str6);
begin
  oTmpTable.FieldByName('AccAnl').AsString:=pValue;
end;

function TAccanlTmp.GetAccNam:Str30;
begin
  Result:=oTmpTable.FieldByName('AccNam').AsString;
end;

procedure TAccanlTmp.SetAccNam(pValue:Str30);
begin
  oTmpTable.FieldByName('AccNam').AsString:=pValue;
end;

// **************************************** PUBLIC ********************************************

function TAccanlTmp.Eof:boolean;
begin
  Result:=oTmpTable.Eof;
end;

function TAccanlTmp.Active:boolean;
begin
  Result:=oTmpTable.Active;
end;

function TAccanlTmp.LocAsAn(pAccSnt:Str3;pAccAnl:Str6):boolean;
begin
  SetIndex (ixAsAn);
  Result:=oTmpTable.FindKey([pAccSnt,pAccAnl]);
end;

procedure TAccanlTmp.SetIndex(pIndexName:ShortString);
begin
  If oTmpTable.IndexName<>pIndexName then oTmpTable.IndexName:=pIndexName;
end;

procedure TAccanlTmp.Open;
begin
  oTmpTable.Open;
end;

procedure TAccanlTmp.Close;
begin
  If oTmpTable.Active then oTmpTable.Close;
end;

procedure TAccanlTmp.Prior;
begin
  oTmpTable.Prior;
end;

procedure TAccanlTmp.Next;
begin
  oTmpTable.Next;
end;

procedure TAccanlTmp.First;
begin
  oTmpTable.First;
end;

procedure TAccanlTmp.Last;
begin
  oTmpTable.Last;
end;

procedure TAccanlTmp.Insert;
begin
  oTmpTable.Insert;
end;

procedure TAccanlTmp.Edit;
begin
  oTmpTable.Edit;
end;

procedure TAccanlTmp.Post;
var mEdit:boolean;
begin
  oTmpTable.Post;
end;

procedure TAccanlTmp.Delete;
begin
  oTmpTable.Delete;
end;

procedure TAccanlTmp.SwapIndex;
begin
  oTmpTable.SwapIndex;
end;

procedure TAccanlTmp.RestIndex;
begin
  oTmpTable.RestoreIndex;
end;

procedure TAccanlTmp.SwapStatus;
begin
  oTmpTable.SwapStatus;
end;

procedure TAccanlTmp.RestStatus;
begin
  oTmpTable.RestoreStatus;
end;

procedure TAccanlTmp.EnabCont;
begin
  oTmpTable.EnableControls;
end;

procedure TAccanlTmp.DisabCont;
begin
  oTmpTable.DisableControls;
end;

end.
{MOD 2011001}
