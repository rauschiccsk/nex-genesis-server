unit tFJRBLC;

interface

uses
  IcTypes, IcConv, NexPath, NexGlob, DocHand, 
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls,
  Dialogs, DB, NexBtrTable, DBTables, NexPxTable;

const
  ixSnAn = '';

type
  TFjrblcTmp = class (TComponent)
    constructor Create;
    destructor  Destroy; override;
  private
    oTmpTable: TNexPxTable;
    function ReadCount:integer;
    function FieldExist (pFieldName:ShortString): boolean;
    // Pristup k databazovym poliam
    function  ReadAccSnt:str3;           procedure WriteAccSnt (pValue:str3);
    function  ReadAccAnl:str6;           procedure WriteAccAnl (pValue:str6);
    function  ReadAnlName:Str30;         procedure WriteAnlName (pValue:Str30);
    function  ReadIncVal:double;         procedure WriteIncVal (pValue:double);
    function  ReadOutVal:double;         procedure WriteOutVal (pValue:double);
  public
    // Elementarne databazove operacie
    function Eof: boolean;
    function Active: boolean;
    function LocateSnAn (pAccSnt:str3;pAccAnl:str6):boolean;

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
    property AccSnt:str3 read ReadAccSnt write WriteAccSnt;
    property AccAnl:str6 read ReadAccAnl write WriteAccAnl;
    property AnlName:Str30 read ReadAnlName write WriteAnlName;
    property IncVal:double read ReadIncVal write WriteIncVal;
    property OutVal:double read ReadOutVal write WriteOutVal;
  end;

implementation

constructor TFjrblcTmp.Create;
begin
  oTmpTable := TmpInit ('FJRBLC',Self);
end;

destructor TFjrblcTmp.Destroy;
begin
  If oTmpTable.Active then oTmpTable.Close;
  FreeAndNil (oTmpTable);
end;

// *************************************** PRIVATE ********************************************

function TFjrblcTmp.ReadCount:integer;
begin
  Result := oTmpTable.RecordCount;
end;

function TFjrblcTmp.FieldExist (pFieldName:ShortString): boolean;
begin
  Result := oTmpTable.FindField(pFieldName)<>nil;
end;

function TFjrblcTmp.ReadAccSnt:str3;
begin
  Result := oTmpTable.FieldByName('AccSnt').AsString;
end;

procedure TFjrblcTmp.WriteAccSnt(pValue:str3);
begin
  oTmpTable.FieldByName('AccSnt').AsString := pValue;
end;

function TFjrblcTmp.ReadAccAnl:str6;
begin
  Result := oTmpTable.FieldByName('AccAnl').AsString;
end;

procedure TFjrblcTmp.WriteAccAnl(pValue:str6);
begin
  oTmpTable.FieldByName('AccAnl').AsString := pValue;
end;

function TFjrblcTmp.ReadAnlName:Str30;
begin
  Result := oTmpTable.FieldByName('AnlName').AsString;
end;

procedure TFjrblcTmp.WriteAnlName(pValue:Str30);
begin
  oTmpTable.FieldByName('AnlName').AsString := pValue;
end;

function TFjrblcTmp.ReadIncVal:double;
begin
  Result := oTmpTable.FieldByName('IncVal').AsFloat;
end;

procedure TFjrblcTmp.WriteIncVal(pValue:double);
begin
  oTmpTable.FieldByName('IncVal').AsFloat := pValue;
end;

function TFjrblcTmp.ReadOutVal:double;
begin
  Result := oTmpTable.FieldByName('OutVal').AsFloat;
end;

procedure TFjrblcTmp.WriteOutVal(pValue:double);
begin
  oTmpTable.FieldByName('OutVal').AsFloat := pValue;
end;

// **************************************** PUBLIC ********************************************

function TFjrblcTmp.Eof: boolean;
begin
  Result := oTmpTable.Eof;
end;

function TFjrblcTmp.Active: boolean;
begin
  Result := oTmpTable.Active;
end;

function TFjrblcTmp.LocateSnAn (pAccSnt:str3;pAccAnl:str6):boolean;
begin
  SetIndex (ixSnAn);
  Result := oTmpTable.FindKey([pAccSnt,pAccAnl]);
end;

procedure TFjrblcTmp.SetIndex (pIndexName:ShortString);
begin
  If oTmpTable.IndexName<>pIndexName then oTmpTable.IndexName := pIndexName;
end;

procedure TFjrblcTmp.Open;
begin
  oTmpTable.Open;
end;

procedure TFjrblcTmp.Close;
begin
  If oTmpTable.Active then oTmpTable.Close;
end;

procedure TFjrblcTmp.Prior;
begin
  oTmpTable.Prior;
end;

procedure TFjrblcTmp.Next;
begin
  oTmpTable.Next;
end;

procedure TFjrblcTmp.First;
begin
  oTmpTable.First;
end;

procedure TFjrblcTmp.Last;
begin
  oTmpTable.Last;
end;

procedure TFjrblcTmp.Insert;
begin
  oTmpTable.Insert;
end;

procedure TFjrblcTmp.Edit;
begin
  oTmpTable.Edit;
end;

procedure TFjrblcTmp.Post;
var mEdit:boolean;
begin
  oTmpTable.Post;
end;

procedure TFjrblcTmp.Delete;
begin
  oTmpTable.Delete;
end;

procedure TFjrblcTmp.SwapIndex;
begin
  oTmpTable.SwapIndex;
end;

procedure TFjrblcTmp.RestoreIndex;
begin
  oTmpTable.RestoreIndex;
end;

procedure TFjrblcTmp.SwapStatus;
begin
  oTmpTable.SwapStatus;
end;

procedure TFjrblcTmp.RestoreStatus;
begin
  oTmpTable.RestoreStatus;
end;

procedure TFjrblcTmp.EnableControls;
begin
  oTmpTable.EnableControls;
end;

procedure TFjrblcTmp.DisableControls;
begin
  oTmpTable.DisableControls;
end;

end.
