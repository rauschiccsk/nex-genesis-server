unit tSHCBON;

interface

uses
  IcTypes, IcConv, NexPath, NexGlob, DocHand, 
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls,
  Dialogs, DB, NexBtrTable, DBTables, NexPxTable;

const
  ixSerNum='';
  ixOutDte='OutDte';

type
  TShcbonTmp=class(TComponent)
    constructor Create;
    destructor Destroy; override;
  private
    oTmpTable: TNexPxTable;
    function GetCount:integer;
    function FieldExist (pFieldName:ShortString): boolean;
    // Pristup k databazovym poliam
    function GetSerNum:word;             procedure SetSerNum (pValue:word);
    function GetOutDte:TDatetime;        procedure SetOutDte (pValue:TDatetime);
    function GetOutQnt:word;             procedure SetOutQnt (pValue:word);
    function GetCrtUsr:Str8;             procedure SetCrtUsr (pValue:Str8);
    function GetCrtUsn:Str30;            procedure SetCrtUsn (pValue:Str30);
    function GetCrtDte:TDatetime;        procedure SetCrtDte (pValue:TDatetime);
    function GetCrtTim:TDatetime;        procedure SetCrtTim (pValue:TDatetime);
  public
    // Elementarne databazove operacie
    function Eof:boolean;
    function Active:boolean;
    function LocSerNum (pSerNum:word):boolean;
    function LocOutDte (pOutDte:TDatetime):boolean;

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
    property SerNum:word read GetSerNum write SetSerNum;
    property OutDte:TDatetime read GetOutDte write SetOutDte;
    property OutQnt:word read GetOutQnt write SetOutQnt;
    property CrtUsr:Str8 read GetCrtUsr write SetCrtUsr;
    property CrtUsn:Str30 read GetCrtUsn write SetCrtUsn;
    property CrtDte:TDatetime read GetCrtDte write SetCrtDte;
    property CrtTim:TDatetime read GetCrtTim write SetCrtTim;
  end;

implementation

constructor TShcbonTmp.Create;
begin
  oTmpTable:=TmpInit ('SHCBON',Self);
end;

destructor TShcbonTmp.Destroy;
begin
  If oTmpTable.Active then oTmpTable.Close;
  FreeAndNil(oTmpTable);
end;

// *************************************** PRIVATE ********************************************

function TShcbonTmp.GetCount:integer;
begin
  Result:=oTmpTable.RecordCount;
end;

function TShcbonTmp.FieldExist(pFieldName:ShortString):boolean;
begin
  Result:=oTmpTable.FindField(pFieldName)<>nil;
end;

function TShcbonTmp.GetSerNum:word;
begin
  Result:=oTmpTable.FieldByName('SerNum').AsInteger;
end;

procedure TShcbonTmp.SetSerNum(pValue:word);
begin
  oTmpTable.FieldByName('SerNum').AsInteger:=pValue;
end;

function TShcbonTmp.GetOutDte:TDatetime;
begin
  Result:=oTmpTable.FieldByName('OutDte').AsDateTime;
end;

procedure TShcbonTmp.SetOutDte(pValue:TDatetime);
begin
  oTmpTable.FieldByName('OutDte').AsDateTime:=pValue;
end;

function TShcbonTmp.GetOutQnt:word;
begin
  Result:=oTmpTable.FieldByName('OutQnt').AsInteger;
end;

procedure TShcbonTmp.SetOutQnt(pValue:word);
begin
  oTmpTable.FieldByName('OutQnt').AsInteger:=pValue;
end;

function TShcbonTmp.GetCrtUsr:Str8;
begin
  Result:=oTmpTable.FieldByName('CrtUsr').AsString;
end;

procedure TShcbonTmp.SetCrtUsr(pValue:Str8);
begin
  oTmpTable.FieldByName('CrtUsr').AsString:=pValue;
end;

function TShcbonTmp.GetCrtUsn:Str30;
begin
  Result:=oTmpTable.FieldByName('CrtUsn').AsString;
end;

procedure TShcbonTmp.SetCrtUsn(pValue:Str30);
begin
  oTmpTable.FieldByName('CrtUsn').AsString:=pValue;
end;

function TShcbonTmp.GetCrtDte:TDatetime;
begin
  Result:=oTmpTable.FieldByName('CrtDte').AsDateTime;
end;

procedure TShcbonTmp.SetCrtDte(pValue:TDatetime);
begin
  oTmpTable.FieldByName('CrtDte').AsDateTime:=pValue;
end;

function TShcbonTmp.GetCrtTim:TDatetime;
begin
  Result:=oTmpTable.FieldByName('CrtTim').AsDateTime;
end;

procedure TShcbonTmp.SetCrtTim(pValue:TDatetime);
begin
  oTmpTable.FieldByName('CrtTim').AsDateTime:=pValue;
end;

// **************************************** PUBLIC ********************************************

function TShcbonTmp.Eof:boolean;
begin
  Result:=oTmpTable.Eof;
end;

function TShcbonTmp.Active:boolean;
begin
  Result:=oTmpTable.Active;
end;

function TShcbonTmp.LocSerNum(pSerNum:word):boolean;
begin
  SetIndex (ixSerNum);
  Result:=oTmpTable.FindKey([pSerNum]);
end;

function TShcbonTmp.LocOutDte(pOutDte:TDatetime):boolean;
begin
  SetIndex (ixOutDte);
  Result:=oTmpTable.FindKey([pOutDte]);
end;

procedure TShcbonTmp.SetIndex(pIndexName:ShortString);
begin
  If oTmpTable.IndexName<>pIndexName then oTmpTable.IndexName:=pIndexName;
end;

procedure TShcbonTmp.Open;
begin
  oTmpTable.Open;
end;

procedure TShcbonTmp.Close;
begin
  If oTmpTable.Active then oTmpTable.Close;
end;

procedure TShcbonTmp.Prior;
begin
  oTmpTable.Prior;
end;

procedure TShcbonTmp.Next;
begin
  oTmpTable.Next;
end;

procedure TShcbonTmp.First;
begin
  oTmpTable.First;
end;

procedure TShcbonTmp.Last;
begin
  oTmpTable.Last;
end;

procedure TShcbonTmp.Insert;
begin
  oTmpTable.Insert;
end;

procedure TShcbonTmp.Edit;
begin
  oTmpTable.Edit;
end;

procedure TShcbonTmp.Post;
var mEdit:boolean;
begin
  oTmpTable.Post;
end;

procedure TShcbonTmp.Delete;
begin
  oTmpTable.Delete;
end;

procedure TShcbonTmp.SwapIndex;
begin
  oTmpTable.SwapIndex;
end;

procedure TShcbonTmp.RestIndex;
begin
  oTmpTable.RestoreIndex;
end;

procedure TShcbonTmp.SwapStatus;
begin
  oTmpTable.SwapStatus;
end;

procedure TShcbonTmp.RestStatus;
begin
  oTmpTable.RestoreStatus;
end;

procedure TShcbonTmp.EnabCont;
begin
  oTmpTable.EnableControls;
end;

procedure TShcbonTmp.DisabCont;
begin
  oTmpTable.DisableControls;
end;

end.
{MOD 2001001}
