unit tIMPPDG;

interface

uses
  IcTypes, IcConv, NexPath, NexGlob, DocHand, 
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls,
  Dialogs, DB, NexBtrTable, DBTables, NexPxTable;

const
  ixGsCode = '';

type
  TImppdgTmp = class (TComponent)
    constructor Create;
    destructor  Destroy; override;
  private
    oTmpTable: TNexPxTable;
    function ReadCount:integer;
    function FieldExist (pFieldName:ShortString): boolean;
    // Pristup k databazovym poliam
    function  ReadGsCode:longint;        procedure WriteGsCode (pValue:longint);
    function  ReadGsName:Str30;          procedure WriteGsName (pValue:Str30);
    function  ReadBaCode:Str15;          procedure WriteBaCode (pValue:Str15);
    function  ReadStkNum:word;           procedure WriteStkNum (pValue:word);
    function  ReadPdnQnt:double;         procedure WritePdnQnt (pValue:double);
    function  ReadInpDoc:Str12;          procedure WriteInpDoc (pValue:Str12);
    function  ReadInpItm:word;           procedure WriteInpItm (pValue:word);
    function  ReadInpDat:TDatetime;      procedure WriteInpDat (pValue:TDatetime);
    function  ReadInpFif:longint;        procedure WriteInpFif (pValue:longint);
    function  ReadInpQnt:double;         procedure WriteInpQnt (pValue:double);
  public
    // Elementarne databazove operacie
    function Eof: boolean;
    function Active: boolean;
    function LocateGsCode (pGsCode:longint):boolean;

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
    property GsCode:longint read ReadGsCode write WriteGsCode;
    property GsName:Str30 read ReadGsName write WriteGsName;
    property BaCode:Str15 read ReadBaCode write WriteBaCode;
    property StkNum:word read ReadStkNum write WriteStkNum;
    property PdnQnt:double read ReadPdnQnt write WritePdnQnt;
    property InpDoc:Str12 read ReadInpDoc write WriteInpDoc;
    property InpItm:word read ReadInpItm write WriteInpItm;
    property InpDat:TDatetime read ReadInpDat write WriteInpDat;
    property InpFif:longint read ReadInpFif write WriteInpFif;
    property InpQnt:double read ReadInpQnt write WriteInpQnt;
  end;

implementation

constructor TImppdgTmp.Create;
begin
  oTmpTable := TmpInit ('IMPPDG',Self);
end;

destructor TImppdgTmp.Destroy;
begin
  If oTmpTable.Active then oTmpTable.Close;
  FreeAndNil (oTmpTable);
end;

// *************************************** PRIVATE ********************************************

function TImppdgTmp.ReadCount:integer;
begin
  Result := oTmpTable.RecordCount;
end;

function TImppdgTmp.FieldExist (pFieldName:ShortString): boolean;
begin
  Result := oTmpTable.FindField(pFieldName)<>nil;
end;

function TImppdgTmp.ReadGsCode:longint;
begin
  Result := oTmpTable.FieldByName('GsCode').AsInteger;
end;

procedure TImppdgTmp.WriteGsCode(pValue:longint);
begin
  oTmpTable.FieldByName('GsCode').AsInteger := pValue;
end;

function TImppdgTmp.ReadGsName:Str30;
begin
  Result := oTmpTable.FieldByName('GsName').AsString;
end;

procedure TImppdgTmp.WriteGsName(pValue:Str30);
begin
  oTmpTable.FieldByName('GsName').AsString := pValue;
end;

function TImppdgTmp.ReadBaCode:Str15;
begin
  Result := oTmpTable.FieldByName('BaCode').AsString;
end;

procedure TImppdgTmp.WriteBaCode(pValue:Str15);
begin
  oTmpTable.FieldByName('BaCode').AsString := pValue;
end;

function TImppdgTmp.ReadStkNum:word;
begin
  Result := oTmpTable.FieldByName('StkNum').AsInteger;
end;

procedure TImppdgTmp.WriteStkNum(pValue:word);
begin
  oTmpTable.FieldByName('StkNum').AsInteger := pValue;
end;

function TImppdgTmp.ReadPdnQnt:double;
begin
  Result := oTmpTable.FieldByName('PdnQnt').AsFloat;
end;

procedure TImppdgTmp.WritePdnQnt(pValue:double);
begin
  oTmpTable.FieldByName('PdnQnt').AsFloat := pValue;
end;

function TImppdgTmp.ReadInpDoc:Str12;
begin
  Result := oTmpTable.FieldByName('InpDoc').AsString;
end;

procedure TImppdgTmp.WriteInpDoc(pValue:Str12);
begin
  oTmpTable.FieldByName('InpDoc').AsString := pValue;
end;

function TImppdgTmp.ReadInpItm:word;
begin
  Result := oTmpTable.FieldByName('InpItm').AsInteger;
end;

procedure TImppdgTmp.WriteInpItm(pValue:word);
begin
  oTmpTable.FieldByName('InpItm').AsInteger := pValue;
end;

function TImppdgTmp.ReadInpDat:TDatetime;
begin
  Result := oTmpTable.FieldByName('InpDat').AsDateTime;
end;

procedure TImppdgTmp.WriteInpDat(pValue:TDatetime);
begin
  oTmpTable.FieldByName('InpDat').AsDateTime := pValue;
end;

function TImppdgTmp.ReadInpFif:longint;
begin
  Result := oTmpTable.FieldByName('InpFif').AsInteger;
end;

procedure TImppdgTmp.WriteInpFif(pValue:longint);
begin
  oTmpTable.FieldByName('InpFif').AsInteger := pValue;
end;

function TImppdgTmp.ReadInpQnt:double;
begin
  Result := oTmpTable.FieldByName('InpQnt').AsFloat;
end;

procedure TImppdgTmp.WriteInpQnt(pValue:double);
begin
  oTmpTable.FieldByName('InpQnt').AsFloat := pValue;
end;

// **************************************** PUBLIC ********************************************

function TImppdgTmp.Eof: boolean;
begin
  Result := oTmpTable.Eof;
end;

function TImppdgTmp.Active: boolean;
begin
  Result := oTmpTable.Active;
end;

function TImppdgTmp.LocateGsCode (pGsCode:longint):boolean;
begin
  SetIndex (ixGsCode);
  Result := oTmpTable.FindKey([pGsCode]);
end;

procedure TImppdgTmp.SetIndex (pIndexName:ShortString);
begin
  If oTmpTable.IndexName<>pIndexName then oTmpTable.IndexName := pIndexName;
end;

procedure TImppdgTmp.Open;
begin
  oTmpTable.Open;
end;

procedure TImppdgTmp.Close;
begin
  If oTmpTable.Active then oTmpTable.Close;
end;

procedure TImppdgTmp.Prior;
begin
  oTmpTable.Prior;
end;

procedure TImppdgTmp.Next;
begin
  oTmpTable.Next;
end;

procedure TImppdgTmp.First;
begin
  oTmpTable.First;
end;

procedure TImppdgTmp.Last;
begin
  oTmpTable.Last;
end;

procedure TImppdgTmp.Insert;
begin
  oTmpTable.Insert;
end;

procedure TImppdgTmp.Edit;
begin
  oTmpTable.Edit;
end;

procedure TImppdgTmp.Post;
var mEdit:boolean;
begin
  oTmpTable.Post;
end;

procedure TImppdgTmp.Delete;
begin
  oTmpTable.Delete;
end;

procedure TImppdgTmp.SwapIndex;
begin
  oTmpTable.SwapIndex;
end;

procedure TImppdgTmp.RestoreIndex;
begin
  oTmpTable.RestoreIndex;
end;

procedure TImppdgTmp.SwapStatus;
begin
  oTmpTable.SwapStatus;
end;

procedure TImppdgTmp.RestoreStatus;
begin
  oTmpTable.RestoreStatus;
end;

procedure TImppdgTmp.EnableControls;
begin
  oTmpTable.EnableControls;
end;

procedure TImppdgTmp.DisableControls;
begin
  oTmpTable.DisableControls;
end;

end.
{MOD 1920001}
