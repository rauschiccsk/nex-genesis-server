unit tGPS;

interface

uses
  IcTypes, IcConv, NexPath, NexGlob, DocHand, 
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls,
  Dialogs, DB, NexBtrTable, DBTables, NexPxTable;

const
  ixRecNum = '';
  ixPoCode = 'PoCode';

type
  TGpsTmp = class (TComponent)
    constructor Create;
    destructor  Destroy; override;
  private
    oTmpTable: TNexPxTable;
    function ReadCount:integer;
    function FieldExist (pFieldName:ShortString): boolean;
    // Pristup k databazovym poliam
    function  ReadRecNum:word;           procedure WriteRecNum (pValue:word);
    function  ReadPoCode:Str15;          procedure WritePoCode (pValue:Str15);
    function  ReadGsCode:longint;        procedure WriteGsCode (pValue:longint);
    function  ReadGsName:Str30;          procedure WriteGsName (pValue:Str30);
    function  ReadBaCode:Str15;          procedure WriteBaCode (pValue:Str15);
    function  ReadStCode:Str15;          procedure WriteStCode (pValue:Str15);
    function  ReadMsName:Str10;          procedure WriteMsName (pValue:Str10);
    function  ReadOutQnt:double;         procedure WriteOutQnt (pValue:double);
    function  ReadExpQnt:double;         procedure WriteExpQnt (pValue:double);
    function  ReadDocNum:Str12;          procedure WriteDocNum (pValue:Str12);
    function  ReadItmNum:word;           procedure WriteItmNum (pValue:word);
  public
    // Elementarne databazove operacie
    function Eof: boolean;
    function Active: boolean;
    function LocateRecNum (pRecNum:word):boolean;
    function LocatePoCode (pPoCode:Str15):boolean;

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
    property RecNum:word read ReadRecNum write WriteRecNum;
    property PoCode:Str15 read ReadPoCode write WritePoCode;
    property GsCode:longint read ReadGsCode write WriteGsCode;
    property GsName:Str30 read ReadGsName write WriteGsName;
    property BaCode:Str15 read ReadBaCode write WriteBaCode;
    property StCode:Str15 read ReadStCode write WriteStCode;
    property MsName:Str10 read ReadMsName write WriteMsName;
    property OutQnt:double read ReadOutQnt write WriteOutQnt;
    property ExpQnt:double read ReadExpQnt write WriteExpQnt;
    property DocNum:Str12 read ReadDocNum write WriteDocNum;
    property ItmNum:word read ReadItmNum write WriteItmNum;
  end;

implementation

constructor TGpsTmp.Create;
begin
  oTmpTable := TmpInit ('GPS',Self);
end;

destructor TGpsTmp.Destroy;
begin
  If oTmpTable.Active then oTmpTable.Close;
  FreeAndNil (oTmpTable);
end;

// *************************************** PRIVATE ********************************************

function TGpsTmp.ReadCount:integer;
begin
  Result := oTmpTable.RecordCount;
end;

function TGpsTmp.FieldExist (pFieldName:ShortString): boolean;
begin
  Result := oTmpTable.FindField(pFieldName)<>nil;
end;

function TGpsTmp.ReadRecNum:word;
begin
  Result := oTmpTable.FieldByName('RecNum').AsInteger;
end;

procedure TGpsTmp.WriteRecNum(pValue:word);
begin
  oTmpTable.FieldByName('RecNum').AsInteger := pValue;
end;

function TGpsTmp.ReadPoCode:Str15;
begin
  Result := oTmpTable.FieldByName('PoCode').AsString;
end;

procedure TGpsTmp.WritePoCode(pValue:Str15);
begin
  oTmpTable.FieldByName('PoCode').AsString := pValue;
end;

function TGpsTmp.ReadGsCode:longint;
begin
  Result := oTmpTable.FieldByName('GsCode').AsInteger;
end;

procedure TGpsTmp.WriteGsCode(pValue:longint);
begin
  oTmpTable.FieldByName('GsCode').AsInteger := pValue;
end;

function TGpsTmp.ReadGsName:Str30;
begin
  Result := oTmpTable.FieldByName('GsName').AsString;
end;

procedure TGpsTmp.WriteGsName(pValue:Str30);
begin
  oTmpTable.FieldByName('GsName').AsString := pValue;
end;

function TGpsTmp.ReadBaCode:Str15;
begin
  Result := oTmpTable.FieldByName('BaCode').AsString;
end;

procedure TGpsTmp.WriteBaCode(pValue:Str15);
begin
  oTmpTable.FieldByName('BaCode').AsString := pValue;
end;

function TGpsTmp.ReadStCode:Str15;
begin
  Result := oTmpTable.FieldByName('StCode').AsString;
end;

procedure TGpsTmp.WriteStCode(pValue:Str15);
begin
  oTmpTable.FieldByName('StCode').AsString := pValue;
end;

function TGpsTmp.ReadMsName:Str10;
begin
  Result := oTmpTable.FieldByName('MsName').AsString;
end;

procedure TGpsTmp.WriteMsName(pValue:Str10);
begin
  oTmpTable.FieldByName('MsName').AsString := pValue;
end;

function TGpsTmp.ReadOutQnt:double;
begin
  Result := oTmpTable.FieldByName('OutQnt').AsFloat;
end;

procedure TGpsTmp.WriteOutQnt(pValue:double);
begin
  oTmpTable.FieldByName('OutQnt').AsFloat := pValue;
end;

function TGpsTmp.ReadExpQnt:double;
begin
  Result := oTmpTable.FieldByName('ExpQnt').AsFloat;
end;

procedure TGpsTmp.WriteExpQnt(pValue:double);
begin
  oTmpTable.FieldByName('ExpQnt').AsFloat := pValue;
end;

function TGpsTmp.ReadDocNum:Str12;
begin
  Result := oTmpTable.FieldByName('DocNum').AsString;
end;

procedure TGpsTmp.WriteDocNum(pValue:Str12);
begin
  oTmpTable.FieldByName('DocNum').AsString := pValue;
end;

function TGpsTmp.ReadItmNum:word;
begin
  Result := oTmpTable.FieldByName('ItmNum').AsInteger;
end;

procedure TGpsTmp.WriteItmNum(pValue:word);
begin
  oTmpTable.FieldByName('ItmNum').AsInteger := pValue;
end;

// **************************************** PUBLIC ********************************************

function TGpsTmp.Eof: boolean;
begin
  Result := oTmpTable.Eof;
end;

function TGpsTmp.Active: boolean;
begin
  Result := oTmpTable.Active;
end;

function TGpsTmp.LocateRecNum (pRecNum:word):boolean;
begin
  SetIndex (ixRecNum);
  Result := oTmpTable.FindKey([pRecNum]);
end;

function TGpsTmp.LocatePoCode (pPoCode:Str15):boolean;
begin
  SetIndex (ixPoCode);
  Result := oTmpTable.FindKey([pPoCode]);
end;

procedure TGpsTmp.SetIndex (pIndexName:ShortString);
begin
  If oTmpTable.IndexName<>pIndexName then oTmpTable.IndexName := pIndexName;
end;

procedure TGpsTmp.Open;
begin
  oTmpTable.Open;
end;

procedure TGpsTmp.Close;
begin
  If oTmpTable.Active then oTmpTable.Close;
end;

procedure TGpsTmp.Prior;
begin
  oTmpTable.Prior;
end;

procedure TGpsTmp.Next;
begin
  oTmpTable.Next;
end;

procedure TGpsTmp.First;
begin
  oTmpTable.First;
end;

procedure TGpsTmp.Last;
begin
  oTmpTable.Last;
end;

procedure TGpsTmp.Insert;
begin
  oTmpTable.Insert;
end;

procedure TGpsTmp.Edit;
begin
  oTmpTable.Edit;
end;

procedure TGpsTmp.Post;
var mEdit:boolean;
begin
  oTmpTable.Post;
end;

procedure TGpsTmp.Delete;
begin
  oTmpTable.Delete;
end;

procedure TGpsTmp.SwapIndex;
begin
  oTmpTable.SwapIndex;
end;

procedure TGpsTmp.RestoreIndex;
begin
  oTmpTable.RestoreIndex;
end;

procedure TGpsTmp.SwapStatus;
begin
  oTmpTable.SwapStatus;
end;

procedure TGpsTmp.RestoreStatus;
begin
  oTmpTable.RestoreStatus;
end;

procedure TGpsTmp.EnableControls;
begin
  oTmpTable.EnableControls;
end;

procedure TGpsTmp.DisableControls;
begin
  oTmpTable.DisableControls;
end;

end.
{MOD 1919001}
