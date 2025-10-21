unit tOUTMOV;

interface

uses
  IcTypes, IcConv, NexPath, NexGlob, DocHand, 
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls,
  Dialogs, DB, NexBtrTable, DBTables, NexPxTable;

const
  ixDoItFn = '';
                         
type
  TOutmovTmp = class (TComponent)
    constructor Create;
    destructor  Destroy; override;
  private
    oTmpTable: TNexPxTable;
    function ReadCount:integer;
    function FieldExist (pFieldName:ShortString): boolean;
    // Pristup k databazovym poliam
    function  ReadOutDoc:Str12;          procedure WriteOutDoc (pValue:Str12);
    function  ReadOutItm:word;           procedure WriteOutItm (pValue:word);
    function  ReadFifNum:longint;        procedure WriteFifNum (pValue:longint);
    function  ReadStkNum:word;           procedure WriteStkNum (pValue:word);
    function  ReadOutQnt:double;         procedure WriteOutQnt (pValue:double);
    function  ReadOutVal:double;         procedure WriteOutVal (pValue:double);
  public
    // Elementarne databazove operacie
    function Eof: boolean;
    function Active: boolean;
    function LocateDoItFn (pOutDoc:Str12;pOutItm:word;pFifNum:longint):boolean;

    procedure SetIndex (pIndexName:ShortString);
    procedure Open;
    procedure Close;
    procedure Prior;
    procedure Next;
    procedure First;
    procedure Last;
    procedure Insert;
    procedure Edit;
    procedure Post; virtual;
    procedure Delete;
    procedure SwapIndex;
    procedure RestoreIndex;
    procedure SwapStatus;
    procedure RestoreStatus;
    procedure DisableControls;
    procedure EnableControls;
  published
    property TmpTable:TNexPxTable read oTmpTable write oTmpTable;
    property Count:integer read ReadCount;
    property OutDoc:Str12 read ReadOutDoc write WriteOutDoc;
    property OutItm:word read ReadOutItm write WriteOutItm;
    property FifNum:longint read ReadFifNum write WriteFifNum;
    property StkNum:word read ReadStkNum write WriteStkNum;
    property OutQnt:double read ReadOutQnt write WriteOutQnt;
    property OutVal:double read ReadOutVal write WriteOutVal;
  end;

implementation

constructor TOutmovTmp.Create;
begin
  oTmpTable := TmpInit ('OUTMOV',Self);
end;

destructor TOutmovTmp.Destroy;
begin
  If oTmpTable.Active then oTmpTable.Close;
  FreeAndNil (oTmpTable);
end;

// *************************************** PRIVATE ********************************************

function TOutmovTmp.ReadCount:integer;
begin
  Result := oTmpTable.RecordCount;
end;

function TOutmovTmp.FieldExist (pFieldName:ShortString): boolean;
begin
  Result := oTmpTable.FindField(pFieldName)<>nil;
end;

function TOutmovTmp.ReadOutDoc:Str12;
begin
  Result := oTmpTable.FieldByName('OutDoc').AsString;
end;

procedure TOutmovTmp.WriteOutDoc(pValue:Str12);
begin
  oTmpTable.FieldByName('OutDoc').AsString := pValue;
end;

function TOutmovTmp.ReadOutItm:word;
begin
  Result := oTmpTable.FieldByName('OutItm').AsInteger;
end;

procedure TOutmovTmp.WriteOutItm(pValue:word);
begin
  oTmpTable.FieldByName('OutItm').AsInteger := pValue;
end;

function TOutmovTmp.ReadFifNum:longint;
begin
  Result := oTmpTable.FieldByName('FifNum').AsInteger;
end;

procedure TOutmovTmp.WriteFifNum(pValue:longint);
begin
  oTmpTable.FieldByName('FifNum').AsInteger := pValue;
end;

function TOutmovTmp.ReadStkNum:word;
begin
  Result := oTmpTable.FieldByName('StkNum').AsInteger;
end;

procedure TOutmovTmp.WriteStkNum(pValue:word);
begin
  oTmpTable.FieldByName('StkNum').AsInteger := pValue;
end;

function TOutmovTmp.ReadOutQnt:double;
begin
  Result := oTmpTable.FieldByName('OutQnt').AsFloat;
end;

procedure TOutmovTmp.WriteOutQnt(pValue:double);
begin
  oTmpTable.FieldByName('OutQnt').AsFloat := pValue;
end;

function TOutmovTmp.ReadOutVal:double;
begin
  Result := oTmpTable.FieldByName('OutVal').AsFloat;
end;

procedure TOutmovTmp.WriteOutVal(pValue:double);
begin
  oTmpTable.FieldByName('OutVal').AsFloat := pValue;
end;

// **************************************** PUBLIC ********************************************

function TOutmovTmp.Eof: boolean;
begin
  Result := oTmpTable.Eof;
end;

function TOutmovTmp.Active: boolean;
begin
  Result := oTmpTable.Active;
end;

function TOutmovTmp.LocateDoItFn (pOutDoc:Str12;pOutItm:word;pFifNum:longint):boolean;
begin
  SetIndex (ixDoItFn);
  Result := oTmpTable.FindKey([pOutDoc,pOutItm,pFifNum]);
end;

procedure TOutmovTmp.SetIndex (pIndexName:ShortString);
begin
  If oTmpTable.IndexName<>pIndexName then oTmpTable.IndexName := pIndexName;
end;

procedure TOutmovTmp.Open;
begin
  oTmpTable.Open;
end;

procedure TOutmovTmp.Close;
begin
  If oTmpTable.Active then oTmpTable.Close;
end;

procedure TOutmovTmp.Prior;
begin
  oTmpTable.Prior;
end;

procedure TOutmovTmp.Next;
begin
  oTmpTable.Next;
end;

procedure TOutmovTmp.First;
begin
  oTmpTable.First;
end;

procedure TOutmovTmp.Last;
begin
  oTmpTable.Last;
end;

procedure TOutmovTmp.Insert;
begin
  oTmpTable.Insert;
end;

procedure TOutmovTmp.Edit;
begin
  oTmpTable.Edit;
end;

procedure TOutmovTmp.Post;
var mEdit:boolean;
begin
  oTmpTable.Post;
end;

procedure TOutmovTmp.Delete;
begin
  oTmpTable.Delete;
end;

procedure TOutmovTmp.SwapIndex;
begin
  oTmpTable.SwapIndex;
end;

procedure TOutmovTmp.RestoreIndex;
begin
  oTmpTable.RestoreIndex;
end;

procedure TOutmovTmp.SwapStatus;
begin
  oTmpTable.SwapStatus;
end;

procedure TOutmovTmp.RestoreStatus;
begin
  oTmpTable.RestoreStatus;
end;

procedure TOutmovTmp.EnableControls;
begin
  oTmpTable.EnableControls;
end;

procedure TOutmovTmp.DisableControls;
begin
  oTmpTable.DisableControls;
end;

end.
