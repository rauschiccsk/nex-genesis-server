unit tIOMHIS;

interface

uses
  IcTypes, IcConv, NexPath, NexGlob, DocHand, 
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls,
  Dialogs, DB, NexBtrTable, DBTables, NexPxTable;

const
  ixDoItFn = '';
  ixDoIt = 'DoIt';
  ixGsCode = 'GsCode';
  ixDocDate = 'DocDate';

type
  TIomhisTmp = class (TComponent)
    constructor Create;
    destructor  Destroy; override;
  private
    oTmpTable: TNexPxTable;
    function ReadCount:integer;
    function FieldExist (pFieldName:ShortString): boolean;
    // Pristup k databazovym poliam
    function  ReadDocNum:Str12;          procedure WriteDocNum (pValue:Str12);
    function  ReadItmNum:word;           procedure WriteItmNum (pValue:word);
    function  ReadFifNum:longint;        procedure WriteFifNum (pValue:longint);
    function  ReadGsCode:longint;        procedure WriteGsCode (pValue:longint);
    function  ReadGsName:Str30;          procedure WriteGsName (pValue:Str30);
    function  ReadInpQnt:double;         procedure WriteInpQnt (pValue:double);
    function  ReadOutQnt:double;         procedure WriteOutQnt (pValue:double);
    function  ReadCPrice:double;         procedure WriteCPrice (pValue:double);
    function  ReadInpVal:double;         procedure WriteInpVal (pValue:double);
    function  ReadOutVal:double;         procedure WriteOutVal (pValue:double);
    function  ReadDocDate:TDatetime;     procedure WriteDocDate (pValue:TDatetime);
  public
    // Elementarne databazove operacie
    function Eof: boolean;
    function Active: boolean;
    function LocateDoItFn (pDocNum:Str12;pItmNum:word;pFifNum:longint):boolean;
    function LocateDoIt (pDocNum:Str12;pItmNum:word):boolean;
    function LocateGsCode (pGsCode:longint):boolean;
    function LocateDocDate (pDocDate:TDatetime):boolean;

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
    property DocNum:Str12 read ReadDocNum write WriteDocNum;
    property ItmNum:word read ReadItmNum write WriteItmNum;
    property FifNum:longint read ReadFifNum write WriteFifNum;
    property GsCode:longint read ReadGsCode write WriteGsCode;
    property GsName:Str30 read ReadGsName write WriteGsName;
    property InpQnt:double read ReadInpQnt write WriteInpQnt;
    property OutQnt:double read ReadOutQnt write WriteOutQnt;
    property CPrice:double read ReadCPrice write WriteCPrice;
    property InpVal:double read ReadInpVal write WriteInpVal;
    property OutVal:double read ReadOutVal write WriteOutVal;
    property DocDate:TDatetime read ReadDocDate write WriteDocDate;
  end;

implementation

constructor TIomhisTmp.Create;
begin
  oTmpTable := TmpInit ('IOMHIS',Self);
end;

destructor TIomhisTmp.Destroy;
begin
  If oTmpTable.Active then oTmpTable.Close;
  FreeAndNil (oTmpTable);
end;

// *************************************** PRIVATE ********************************************

function TIomhisTmp.ReadCount:integer;
begin
  Result := oTmpTable.RecordCount;
end;

function TIomhisTmp.FieldExist (pFieldName:ShortString): boolean;
begin
  Result := oTmpTable.FindField(pFieldName)<>nil;
end;

function TIomhisTmp.ReadDocNum:Str12;
begin
  Result := oTmpTable.FieldByName('DocNum').AsString;
end;

procedure TIomhisTmp.WriteDocNum(pValue:Str12);
begin
  oTmpTable.FieldByName('DocNum').AsString := pValue;
end;

function TIomhisTmp.ReadItmNum:word;
begin
  Result := oTmpTable.FieldByName('ItmNum').AsInteger;
end;

procedure TIomhisTmp.WriteItmNum(pValue:word);
begin
  oTmpTable.FieldByName('ItmNum').AsInteger := pValue;
end;

function TIomhisTmp.ReadFifNum:longint;
begin
  Result := oTmpTable.FieldByName('FifNum').AsInteger;
end;

procedure TIomhisTmp.WriteFifNum(pValue:longint);
begin
  oTmpTable.FieldByName('FifNum').AsInteger := pValue;
end;

function TIomhisTmp.ReadGsCode:longint;
begin
  Result := oTmpTable.FieldByName('GsCode').AsInteger;
end;

procedure TIomhisTmp.WriteGsCode(pValue:longint);
begin
  oTmpTable.FieldByName('GsCode').AsInteger := pValue;
end;

function TIomhisTmp.ReadGsName:Str30;
begin
  Result := oTmpTable.FieldByName('GsName').AsString;
end;

procedure TIomhisTmp.WriteGsName(pValue:Str30);
begin
  oTmpTable.FieldByName('GsName').AsString := pValue;
end;

function TIomhisTmp.ReadInpQnt:double;
begin
  Result := oTmpTable.FieldByName('InpQnt').AsFloat;
end;

procedure TIomhisTmp.WriteInpQnt(pValue:double);
begin
  oTmpTable.FieldByName('InpQnt').AsFloat := pValue;
end;

function TIomhisTmp.ReadOutQnt:double;
begin
  Result := oTmpTable.FieldByName('OutQnt').AsFloat;
end;

procedure TIomhisTmp.WriteOutQnt(pValue:double);
begin
  oTmpTable.FieldByName('OutQnt').AsFloat := pValue;
end;

function TIomhisTmp.ReadCPrice:double;
begin
  Result := oTmpTable.FieldByName('CPrice').AsFloat;
end;

procedure TIomhisTmp.WriteCPrice(pValue:double);
begin
  oTmpTable.FieldByName('CPrice').AsFloat := pValue;
end;

function TIomhisTmp.ReadInpVal:double;
begin
  Result := oTmpTable.FieldByName('InpVal').AsFloat;
end;

procedure TIomhisTmp.WriteInpVal(pValue:double);
begin
  oTmpTable.FieldByName('InpVal').AsFloat := pValue;
end;

function TIomhisTmp.ReadOutVal:double;
begin
  Result := oTmpTable.FieldByName('OutVal').AsFloat;
end;

procedure TIomhisTmp.WriteOutVal(pValue:double);
begin
  oTmpTable.FieldByName('OutVal').AsFloat := pValue;
end;

function TIomhisTmp.ReadDocDate:TDatetime;
begin
  Result := oTmpTable.FieldByName('DocDate').AsDateTime;
end;

procedure TIomhisTmp.WriteDocDate(pValue:TDatetime);
begin
  oTmpTable.FieldByName('DocDate').AsDateTime := pValue;
end;

// **************************************** PUBLIC ********************************************

function TIomhisTmp.Eof: boolean;
begin
  Result := oTmpTable.Eof;
end;

function TIomhisTmp.Active: boolean;
begin
  Result := oTmpTable.Active;
end;

function TIomhisTmp.LocateDoItFn (pDocNum:Str12;pItmNum:word;pFifNum:longint):boolean;
begin
  SetIndex (ixDoItFn);
  Result := oTmpTable.FindKey([pDocNum,pItmNum,pFifNum]);
end;

function TIomhisTmp.LocateDoIt (pDocNum:Str12;pItmNum:word):boolean;
begin
  SetIndex (ixDoIt);
  Result := oTmpTable.FindKey([pDocNum,pItmNum]);
end;

function TIomhisTmp.LocateGsCode (pGsCode:longint):boolean;
begin
  SetIndex (ixGsCode);
  Result := oTmpTable.FindKey([pGsCode]);
end;

function TIomhisTmp.LocateDocDate (pDocDate:TDatetime):boolean;
begin
  SetIndex (ixDocDate);
  Result := oTmpTable.FindKey([pDocDate]);
end;

procedure TIomhisTmp.SetIndex (pIndexName:ShortString);
begin
  If oTmpTable.IndexName<>pIndexName then oTmpTable.IndexName := pIndexName;
end;

procedure TIomhisTmp.Open;
begin
  oTmpTable.Open;
end;

procedure TIomhisTmp.Close;
begin
  If oTmpTable.Active then oTmpTable.Close;
end;

procedure TIomhisTmp.Prior;
begin
  oTmpTable.Prior;
end;

procedure TIomhisTmp.Next;
begin
  oTmpTable.Next;
end;

procedure TIomhisTmp.First;
begin
  oTmpTable.First;
end;

procedure TIomhisTmp.Last;
begin
  oTmpTable.Last;
end;

procedure TIomhisTmp.Insert;
begin
  oTmpTable.Insert;
end;

procedure TIomhisTmp.Edit;
begin
  oTmpTable.Edit;
end;

procedure TIomhisTmp.Post;
var mEdit:boolean;
begin
  oTmpTable.Post;
end;

procedure TIomhisTmp.Delete;
begin
  oTmpTable.Delete;
end;

procedure TIomhisTmp.SwapIndex;
begin
  oTmpTable.SwapIndex;
end;

procedure TIomhisTmp.RestoreIndex;
begin
  oTmpTable.RestoreIndex;
end;

procedure TIomhisTmp.SwapStatus;
begin
  oTmpTable.SwapStatus;
end;

procedure TIomhisTmp.RestoreStatus;
begin
  oTmpTable.RestoreStatus;
end;

procedure TIomhisTmp.EnableControls;
begin
  oTmpTable.EnableControls;
end;

procedure TIomhisTmp.DisableControls;
begin
  oTmpTable.DisableControls;
end;

end.
