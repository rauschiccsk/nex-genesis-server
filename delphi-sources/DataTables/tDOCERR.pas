unit tDOCERR;

interface

uses
  IcTypes, IcConv, NexPath, NexGlob, DocHand, 
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls,
  Dialogs, DB, NexBtrTable, DBTables, NexPxTable;

const
  ixYeSn = '';
  ixDocNum = 'DocNum';

type
  TDocerrTmp = class (TComponent)
    constructor Create;
    destructor  Destroy; override;
  private
    oTmpTable: TNexPxTable;
    function ReadCount:integer;
    function FieldExist (pFieldName:ShortString): boolean;
    // Pristup k databazovym poliam
    function  ReadYear:Str2;             procedure WriteYear (pValue:Str2);
    function  ReadSerNum:longint;        procedure WriteSerNum (pValue:longint);
    function  ReadDocNum:Str12;          procedure WriteDocNum (pValue:Str12);
    function  ReadExtNum:Str12;          procedure WriteExtNum (pValue:Str12);
    function  ReadErrCode:longint;       procedure WriteErrCode (pValue:longint);
    function  ReadErrDesc:Str100;        procedure WriteErrDesc (pValue:Str100);
  public
    // Elementarne databazove operacie
    function Eof: boolean;
    function Active: boolean;
    function LocateYeSn (pYear:Str2;pSerNum:longint):boolean;
    function LocateDocNum (pDocNum:Str12):boolean;

    procedure SetIndex (pIndexName:ShortString);
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
    procedure RestoreIndex;
    procedure SwapStatus;
    procedure RestoreStatus;
    procedure DisableControls;
    procedure EnableControls;
  published
    property TmpTable:TNexPxTable read oTmpTable write oTmpTable;
    property Count:integer read ReadCount;
    property Year:Str2 read ReadYear write WriteYear;
    property SerNum:longint read ReadSerNum write WriteSerNum;
    property DocNum:Str12 read ReadDocNum write WriteDocNum;
    property ExtNum:Str12 read ReadExtNum write WriteExtNum;
    property ErrCode:longint read ReadErrCode write WriteErrCode;
    property ErrDesc:Str100 read ReadErrDesc write WriteErrDesc;
  end;

implementation

constructor TDocerrTmp.Create;
begin
  oTmpTable := TmpInit ('DOCERR',Self);
end;

destructor TDocerrTmp.Destroy;
begin
  If oTmpTable.Active then oTmpTable.Close;
  FreeAndNil (oTmpTable);
end;

// *************************************** PRIVATE ********************************************

function TDocerrTmp.ReadCount:integer;
begin
  Result := oTmpTable.RecordCount;
end;

function TDocerrTmp.FieldExist (pFieldName:ShortString): boolean;
begin
  Result := oTmpTable.FindField(pFieldName)<>nil;
end;

function TDocerrTmp.ReadYear:Str2;
begin
  Result := oTmpTable.FieldByName('Year').AsString;
end;

procedure TDocerrTmp.WriteYear(pValue:Str2);
begin
  oTmpTable.FieldByName('Year').AsString := pValue;
end;

function TDocerrTmp.ReadSerNum:longint;
begin
  Result := oTmpTable.FieldByName('SerNum').AsInteger;
end;

procedure TDocerrTmp.WriteSerNum(pValue:longint);
begin
  oTmpTable.FieldByName('SerNum').AsInteger := pValue;
end;

function TDocerrTmp.ReadDocNum:Str12;
begin
  Result := oTmpTable.FieldByName('DocNum').AsString;
end;

procedure TDocerrTmp.WriteDocNum(pValue:Str12);
begin
  oTmpTable.FieldByName('DocNum').AsString := pValue;
end;

function TDocerrTmp.ReadExtNum:Str12;
begin
  Result := oTmpTable.FieldByName('ExtNum').AsString;
end;

procedure TDocerrTmp.WriteExtNum(pValue:Str12);
begin
  oTmpTable.FieldByName('ExtNum').AsString := pValue;
end;

function TDocerrTmp.ReadErrCode:longint;
begin
  Result := oTmpTable.FieldByName('ErrCode').AsInteger;
end;

procedure TDocerrTmp.WriteErrCode(pValue:longint);
begin
  oTmpTable.FieldByName('ErrCode').AsInteger := pValue;
end;

function TDocerrTmp.ReadErrDesc:Str100;
begin
  Result := oTmpTable.FieldByName('ErrDesc').AsString;
end;

procedure TDocerrTmp.WriteErrDesc(pValue:Str100);
begin
  oTmpTable.FieldByName('ErrDesc').AsString := pValue;
end;

// **************************************** PUBLIC ********************************************

function TDocerrTmp.Eof: boolean;
begin
  Result := oTmpTable.Eof;
end;

function TDocerrTmp.Active: boolean;
begin
  Result := oTmpTable.Active;
end;

function TDocerrTmp.LocateYeSn (pYear:Str2;pSerNum:longint):boolean;
begin
  SetIndex (ixYeSn);
  Result := oTmpTable.FindKey([pYear,pSerNum]);
end;

function TDocerrTmp.LocateDocNum (pDocNum:Str12):boolean;
begin
  SetIndex (ixDocNum);
  Result := oTmpTable.FindKey([pDocNum]);
end;

procedure TDocerrTmp.SetIndex (pIndexName:ShortString);
begin
  If oTmpTable.IndexName<>pIndexName then oTmpTable.IndexName := pIndexName;
end;

procedure TDocerrTmp.Open;
begin
  oTmpTable.Open;
end;

procedure TDocerrTmp.Close;
begin
  If oTmpTable.Active then oTmpTable.Close;
end;

procedure TDocerrTmp.Prior;
begin
  oTmpTable.Prior;
end;

procedure TDocerrTmp.Next;
begin
  oTmpTable.Next;
end;

procedure TDocerrTmp.First;
begin
  oTmpTable.First;
end;

procedure TDocerrTmp.Last;
begin
  oTmpTable.Last;
end;

procedure TDocerrTmp.Insert;
begin
  oTmpTable.Insert;
end;

procedure TDocerrTmp.Edit;
begin
  oTmpTable.Edit;
end;

procedure TDocerrTmp.Post;
var mEdit:boolean;
begin
  oTmpTable.Post;
end;

procedure TDocerrTmp.Delete;
begin
  oTmpTable.Delete;
end;

procedure TDocerrTmp.SwapIndex;
begin
  oTmpTable.SwapIndex;
end;

procedure TDocerrTmp.RestoreIndex;
begin
  oTmpTable.RestoreIndex;
end;

procedure TDocerrTmp.SwapStatus;
begin
  oTmpTable.SwapStatus;
end;

procedure TDocerrTmp.RestoreStatus;
begin
  oTmpTable.RestoreStatus;
end;

procedure TDocerrTmp.EnableControls;
begin
  oTmpTable.EnableControls;
end;

procedure TDocerrTmp.DisableControls;
begin
  oTmpTable.DisableControls;
end;

end.
{MOD 1928001}
