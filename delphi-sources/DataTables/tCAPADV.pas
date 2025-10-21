unit tCAPADV;

interface

uses
  IcTypes, IcConv, NexPath, NexGlob, DocHand, 
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls,
  Dialogs, DB, NexBtrTable, DBTables, NexPxTable;

const
  ixAnPu = '';
  ixAdvName = 'AdvName';
  ixPuAn = 'PuAn';

type
  TCapadvTmp = class (TComponent)
    constructor Create;
    destructor  Destroy; override;
  private
    oTmpTable: TNexPxTable;
    function ReadCount:integer;
    function FieldExist (pFieldName:ShortString): boolean;
    // Pristup k databazovym poliam
    function  ReadAdvName:Str10;         procedure WriteAdvName (pValue:Str10);
    function  ReadPayNum:byte;           procedure WritePayNum (pValue:byte);
    function  ReadPayName:Str30;         procedure WritePayName (pValue:Str30);
    function  ReadIncVal:double;         procedure WriteIncVal (pValue:double);
    function  ReadIncMsu:Str10;          procedure WriteIncMsu (pValue:Str10);
    function  ReadChgCrs:double;         procedure WriteChgCrs (pValue:double);
    function  ReadChgMsu:Str10;          procedure WriteChgMsu (pValue:Str10);
    function  ReadPayVal:double;         procedure WritePayVal (pValue:double);
    function  ReadPayMsu:Str10;          procedure WritePayMsu (pValue:Str10);
    function  ReadActPos:longint;        procedure WriteActPos (pValue:longint);
  public
    // Elementarne databazove operacie
    function Eof: boolean;
    function Active: boolean;
    function LocateAnPu (pAdvName:Str10;pPayNum:byte):boolean;
    function LocateAdvName (pAdvName:Str10):boolean;
    function LocatePuAn (pPayNum:byte;pAdvName:Str10):boolean;

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
    property AdvName:Str10 read ReadAdvName write WriteAdvName;
    property PayNum:byte read ReadPayNum write WritePayNum;
    property PayName:Str30 read ReadPayName write WritePayName;
    property IncVal:double read ReadIncVal write WriteIncVal;
    property IncMsu:Str10 read ReadIncMsu write WriteIncMsu;
    property ChgCrs:double read ReadChgCrs write WriteChgCrs;
    property ChgMsu:Str10 read ReadChgMsu write WriteChgMsu;
    property PayVal:double read ReadPayVal write WritePayVal;
    property PayMsu:Str10 read ReadPayMsu write WritePayMsu;
    property ActPos:longint read ReadActPos write WriteActPos;
  end;

implementation

constructor TCapadvTmp.Create;
begin
  oTmpTable := TmpInit ('CAPADV',Self);
end;

destructor TCapadvTmp.Destroy;
begin
  If oTmpTable.Active then oTmpTable.Close;
  FreeAndNil (oTmpTable);
end;

// *************************************** PRIVATE ********************************************

function TCapadvTmp.ReadCount:integer;
begin
  Result := oTmpTable.RecordCount;
end;

function TCapadvTmp.FieldExist (pFieldName:ShortString): boolean;
begin
  Result := oTmpTable.FindField(pFieldName)<>nil;
end;

function TCapadvTmp.ReadAdvName:Str10;
begin
  Result := oTmpTable.FieldByName('AdvName').AsString;
end;

procedure TCapadvTmp.WriteAdvName(pValue:Str10);
begin
  oTmpTable.FieldByName('AdvName').AsString := pValue;
end;

function TCapadvTmp.ReadPayNum:byte;
begin
  Result := oTmpTable.FieldByName('PayNum').AsInteger;
end;

procedure TCapadvTmp.WritePayNum(pValue:byte);
begin
  oTmpTable.FieldByName('PayNum').AsInteger := pValue;
end;

function TCapadvTmp.ReadPayName:Str30;
begin
  Result := oTmpTable.FieldByName('PayName').AsString;
end;

procedure TCapadvTmp.WritePayName(pValue:Str30);
begin
  oTmpTable.FieldByName('PayName').AsString := pValue;
end;

function TCapadvTmp.ReadIncVal:double;
begin
  Result := oTmpTable.FieldByName('IncVal').AsFloat;
end;

procedure TCapadvTmp.WriteIncVal(pValue:double);
begin
  oTmpTable.FieldByName('IncVal').AsFloat := pValue;
end;

function TCapadvTmp.ReadIncMsu:Str10;
begin
  Result := oTmpTable.FieldByName('IncMsu').AsString;
end;

procedure TCapadvTmp.WriteIncMsu(pValue:Str10);
begin
  oTmpTable.FieldByName('IncMsu').AsString := pValue;
end;

function TCapadvTmp.ReadChgCrs:double;
begin
  Result := oTmpTable.FieldByName('ChgCrs').AsFloat;
end;

procedure TCapadvTmp.WriteChgCrs(pValue:double);
begin
  oTmpTable.FieldByName('ChgCrs').AsFloat := pValue;
end;

function TCapadvTmp.ReadChgMsu:Str10;
begin
  Result := oTmpTable.FieldByName('ChgMsu').AsString;
end;

procedure TCapadvTmp.WriteChgMsu(pValue:Str10);
begin
  oTmpTable.FieldByName('ChgMsu').AsString := pValue;
end;

function TCapadvTmp.ReadPayVal:double;
begin
  Result := oTmpTable.FieldByName('PayVal').AsFloat;
end;

procedure TCapadvTmp.WritePayVal(pValue:double);
begin
  oTmpTable.FieldByName('PayVal').AsFloat := pValue;
end;

function TCapadvTmp.ReadPayMsu:Str10;
begin
  Result := oTmpTable.FieldByName('PayMsu').AsString;
end;

procedure TCapadvTmp.WritePayMsu(pValue:Str10);
begin
  oTmpTable.FieldByName('PayMsu').AsString := pValue;
end;

function TCapadvTmp.ReadActPos:longint;
begin
  Result := oTmpTable.FieldByName('ActPos').AsInteger;
end;

procedure TCapadvTmp.WriteActPos(pValue:longint);
begin
  oTmpTable.FieldByName('ActPos').AsInteger := pValue;
end;

// **************************************** PUBLIC ********************************************

function TCapadvTmp.Eof: boolean;
begin
  Result := oTmpTable.Eof;
end;

function TCapadvTmp.Active: boolean;
begin
  Result := oTmpTable.Active;
end;

function TCapadvTmp.LocateAnPu (pAdvName:Str10;pPayNum:byte):boolean;
begin
  SetIndex (ixAnPu);
  Result := oTmpTable.FindKey([pAdvName,pPayNum]);
end;

function TCapadvTmp.LocateAdvName (pAdvName:Str10):boolean;
begin
  SetIndex (ixAdvName);
  Result := oTmpTable.FindKey([pAdvName]);
end;

function TCapadvTmp.LocatePuAn (pPayNum:byte;pAdvName:Str10):boolean;
begin
  SetIndex (ixPuAn);
  Result := oTmpTable.FindKey([pPayNum,pAdvName]);
end;

procedure TCapadvTmp.SetIndex (pIndexName:ShortString);
begin
  If oTmpTable.IndexName<>pIndexName then oTmpTable.IndexName := pIndexName;
end;

procedure TCapadvTmp.Open;
begin
  oTmpTable.Open;
end;

procedure TCapadvTmp.Close;
begin
  If oTmpTable.Active then oTmpTable.Close;
end;

procedure TCapadvTmp.Prior;
begin
  oTmpTable.Prior;
end;

procedure TCapadvTmp.Next;
begin
  oTmpTable.Next;
end;

procedure TCapadvTmp.First;
begin
  oTmpTable.First;
end;

procedure TCapadvTmp.Last;
begin
  oTmpTable.Last;
end;

procedure TCapadvTmp.Insert;
begin
  oTmpTable.Insert;
end;

procedure TCapadvTmp.Edit;
begin
  oTmpTable.Edit;
end;

procedure TCapadvTmp.Post;
var mEdit:boolean;
begin
  oTmpTable.Post;
end;

procedure TCapadvTmp.Delete;
begin
  oTmpTable.Delete;
end;

procedure TCapadvTmp.SwapIndex;
begin
  oTmpTable.SwapIndex;
end;

procedure TCapadvTmp.RestoreIndex;
begin
  oTmpTable.RestoreIndex;
end;

procedure TCapadvTmp.SwapStatus;
begin
  oTmpTable.SwapStatus;
end;

procedure TCapadvTmp.RestoreStatus;
begin
  oTmpTable.RestoreStatus;
end;

procedure TCapadvTmp.EnableControls;
begin
  oTmpTable.EnableControls;
end;

procedure TCapadvTmp.DisableControls;
begin
  oTmpTable.DisableControls;
end;

end.
