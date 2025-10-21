unit tINPMOV;

interface

uses
  IcTypes, IcConv, NexPath, NexGlob, DocHand, 
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls,
  Dialogs, DB, NexBtrTable, DBTables, NexPxTable;

const
  ixOdOiIdIi = '';
  ixOdOiId = 'OdOiId';
  ixOdOi = 'OdOi';
  ixDocGrp = 'DocGrp';

type
  TInpmovTmp = class (TComponent)
    constructor Create;
    destructor  Destroy; override;
  private
    oTmpTable: TNexPxTable;
    function ReadCount:integer;
    function FieldExist (pFieldName:ShortString): boolean;
    // Pristup k databazovym poliam
    function  ReadOutDoc:Str12;          procedure WriteOutDoc (pValue:Str12);
    function  ReadOutItm:word;           procedure WriteOutItm (pValue:word);
    function  ReadInpDoc:Str12;          procedure WriteInpDoc (pValue:Str12);
    function  ReadInpItm:word;           procedure WriteInpItm (pValue:word);
    function  ReadInpDate:TDatetime;     procedure WriteInpDate (pValue:TDatetime);
    function  ReadGsCode:longint;        procedure WriteGsCode (pValue:longint);
    function  ReadGsName:Str30;          procedure WriteGsName (pValue:Str30);
    function  ReadOutQnt:double;         procedure WriteOutQnt (pValue:double);
    function  ReadOutVal:double;         procedure WriteOutVal (pValue:double);
    function  ReadDocGrp:Str20;          procedure WriteDocGrp (pValue:Str20);
  public
    // Elementarne databazove operacie
    function Eof: boolean;
    function Active: boolean;
    function LocateOdOiIdIi (pOutDoc:Str12;pOutItm:word;pInpDoc:Str12;pInpItm:word):boolean;
    function LocateOdOiId (pOutDoc:Str12;pOutItm:word;pInpDate:TDatetime):boolean;
    function LocateOdOi (pOutDoc:Str12;pOutItm:word):boolean;
    function LocateDocGrp (pDocGrp:Str20):boolean;

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
    property InpDoc:Str12 read ReadInpDoc write WriteInpDoc;
    property InpItm:word read ReadInpItm write WriteInpItm;
    property InpDate:TDatetime read ReadInpDate write WriteInpDate;
    property GsCode:longint read ReadGsCode write WriteGsCode;
    property GsName:Str30 read ReadGsName write WriteGsName;
    property OutQnt:double read ReadOutQnt write WriteOutQnt;
    property OutVal:double read ReadOutVal write WriteOutVal;
    property DocGrp:Str20 read ReadDocGrp write WriteDocGrp;
  end;

implementation

constructor TInpmovTmp.Create;
begin
  oTmpTable := TmpInit ('INPMOV',Self);
end;

destructor TInpmovTmp.Destroy;
begin
  If oTmpTable.Active then oTmpTable.Close;
  FreeAndNil (oTmpTable);
end;

// *************************************** PRIVATE ********************************************

function TInpmovTmp.ReadCount:integer;
begin
  Result := oTmpTable.RecordCount;
end;

function TInpmovTmp.FieldExist (pFieldName:ShortString): boolean;
begin
  Result := oTmpTable.FindField(pFieldName)<>nil;
end;

function TInpmovTmp.ReadOutDoc:Str12;
begin
  Result := oTmpTable.FieldByName('OutDoc').AsString;
end;

procedure TInpmovTmp.WriteOutDoc(pValue:Str12);
begin
  oTmpTable.FieldByName('OutDoc').AsString := pValue;
end;

function TInpmovTmp.ReadOutItm:word;
begin
  Result := oTmpTable.FieldByName('OutItm').AsInteger;
end;

procedure TInpmovTmp.WriteOutItm(pValue:word);
begin
  oTmpTable.FieldByName('OutItm').AsInteger := pValue;
end;

function TInpmovTmp.ReadInpDoc:Str12;
begin
  Result := oTmpTable.FieldByName('InpDoc').AsString;
end;

procedure TInpmovTmp.WriteInpDoc(pValue:Str12);
begin
  oTmpTable.FieldByName('InpDoc').AsString := pValue;
end;

function TInpmovTmp.ReadInpItm:word;
begin
  Result := oTmpTable.FieldByName('InpItm').AsInteger;
end;

procedure TInpmovTmp.WriteInpItm(pValue:word);
begin
  oTmpTable.FieldByName('InpItm').AsInteger := pValue;
end;

function TInpmovTmp.ReadInpDate:TDatetime;
begin
  Result := oTmpTable.FieldByName('InpDate').AsDateTime;
end;

procedure TInpmovTmp.WriteInpDate(pValue:TDatetime);
begin
  oTmpTable.FieldByName('InpDate').AsDateTime := pValue;
end;

function TInpmovTmp.ReadGsCode:longint;
begin
  Result := oTmpTable.FieldByName('GsCode').AsInteger;
end;

procedure TInpmovTmp.WriteGsCode(pValue:longint);
begin
  oTmpTable.FieldByName('GsCode').AsInteger := pValue;
end;

function TInpmovTmp.ReadGsName:Str30;
begin
  Result := oTmpTable.FieldByName('GsName').AsString;
end;

procedure TInpmovTmp.WriteGsName(pValue:Str30);
begin
  oTmpTable.FieldByName('GsName').AsString := pValue;
end;

function TInpmovTmp.ReadOutQnt:double;
begin
  Result := oTmpTable.FieldByName('OutQnt').AsFloat;
end;

procedure TInpmovTmp.WriteOutQnt(pValue:double);
begin
  oTmpTable.FieldByName('OutQnt').AsFloat := pValue;
end;

function TInpmovTmp.ReadOutVal:double;
begin
  Result := oTmpTable.FieldByName('OutVal').AsFloat;
end;

procedure TInpmovTmp.WriteOutVal(pValue:double);
begin
  oTmpTable.FieldByName('OutVal').AsFloat := pValue;
end;

function TInpmovTmp.ReadDocGrp:Str20;
begin
  Result := oTmpTable.FieldByName('DocGrp').AsString;
end;

procedure TInpmovTmp.WriteDocGrp(pValue:Str20);
begin
  oTmpTable.FieldByName('DocGrp').AsString := pValue;
end;

// **************************************** PUBLIC ********************************************

function TInpmovTmp.Eof: boolean;
begin
  Result := oTmpTable.Eof;
end;

function TInpmovTmp.Active: boolean;
begin
  Result := oTmpTable.Active;
end;

function TInpmovTmp.LocateOdOiIdIi (pOutDoc:Str12;pOutItm:word;pInpDoc:Str12;pInpItm:word):boolean;
begin
  SetIndex (ixOdOiIdIi);
  Result := oTmpTable.FindKey([pOutDoc,pOutItm,pInpDoc,pInpItm]);
end;

function TInpmovTmp.LocateOdOiId (pOutDoc:Str12;pOutItm:word;pInpDate:TDatetime):boolean;
begin
  SetIndex (ixOdOiId);
  Result := oTmpTable.FindKey([pOutDoc,pOutItm,pInpDate]);
end;

function TInpmovTmp.LocateOdOi (pOutDoc:Str12;pOutItm:word):boolean;
begin
  SetIndex (ixOdOi);
  Result := oTmpTable.FindKey([pOutDoc,pOutItm]);
end;

function TInpmovTmp.LocateDocGrp (pDocGrp:Str20):boolean;
begin
  SetIndex (ixDocGrp);
  Result := oTmpTable.FindKey([pDocGrp]);
end;

procedure TInpmovTmp.SetIndex (pIndexName:ShortString);
begin
  If oTmpTable.IndexName<>pIndexName then oTmpTable.IndexName := pIndexName;
end;

procedure TInpmovTmp.Open;
begin
  oTmpTable.Open;
end;

procedure TInpmovTmp.Close;
begin
  If oTmpTable.Active then oTmpTable.Close;
end;

procedure TInpmovTmp.Prior;
begin
  oTmpTable.Prior;
end;

procedure TInpmovTmp.Next;
begin
  oTmpTable.Next;
end;

procedure TInpmovTmp.First;
begin
  oTmpTable.First;
end;

procedure TInpmovTmp.Last;
begin
  oTmpTable.Last;
end;

procedure TInpmovTmp.Insert;
begin
  oTmpTable.Insert;
end;

procedure TInpmovTmp.Edit;
begin
  oTmpTable.Edit;
end;

procedure TInpmovTmp.Post;
var mEdit:boolean;
begin
  oTmpTable.Post;
end;

procedure TInpmovTmp.Delete;
begin
  oTmpTable.Delete;
end;

procedure TInpmovTmp.SwapIndex;
begin
  oTmpTable.SwapIndex;
end;

procedure TInpmovTmp.RestoreIndex;
begin
  oTmpTable.RestoreIndex;
end;

procedure TInpmovTmp.SwapStatus;
begin
  oTmpTable.SwapStatus;
end;

procedure TInpmovTmp.RestoreStatus;
begin
  oTmpTable.RestoreStatus;
end;

procedure TInpmovTmp.EnableControls;
begin
  oTmpTable.EnableControls;
end;

procedure TInpmovTmp.DisableControls;
begin
  oTmpTable.DisableControls;
end;

end.
